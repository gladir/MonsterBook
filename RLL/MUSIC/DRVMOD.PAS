Program DrvMod;

{$M 4096,0,40000 }

{$G-}

Uses Dos,GoldPlay;

Var Old8Ch,Old8Eh:Pointer; MCBSeg,MCBOfs:Word;

Function Unload:Boolean; Forward;

Procedure Int8Ch(Flags,CS,IP,AX,BX,CX,DX,SI,DI,DS,ES,BP:Word);
Interrupt;
Type ByteRegs=Record L,H:Byte;End;
Var A: ByteRegs Absolute AX;
    B: ByteRegs Absolute BX;
    C: ByteRegs Absolute CX;
    D: ByteRegs Absolute DX;
    S: ^String;
Begin
 Case Hi(AX) of
  $00: AX := (Byte('G') shl 8) + Byte('P');
  $01: LoadOvl('GOLDPLAY.OVL');
  $02: SetSys(A.L,BX,C.L,C.H,DX);
  $03: AskInit;
  $04: Initialize;
  $05: Begin
	 S := Ptr(ES,DI);
	 LoadModule(S^);
	End;
  $06 : StartPlaying;
  $07 : MasterVolume(A.L);
  $08 : StopPlaying;
  $09 : DeAlloc;
  $0A : RemoveOvl;
  $0B : A.L:=BopBar(A.L);
  $3A : Begin
         ES := Seg(StartPlaying);
         BX := Ofs(StartPlaying);
        End;
  $3B : Begin
         ES := Seg(MasterVolume);
         BX := Ofs(MasterVolume);
        End;
  $3C : Begin
         ES := Seg(StopPlaying);
         BX := Ofs(StopPlaying);
        End;
  $3D : Begin
         ES := Seg(DeAlloc);
         BX := Ofs(DeAlloc);
        End;
  $3E : Begin
         ES := Seg(RemoveOvl);
         BX := Ofs(RemoveOvl);
        End;
  $3F : Begin
         S := Ptr(ES,DI);
         LoadOvl(S^);
        End;
  $40 : Begin
	 ES := Seg(BopBar);
	 BX := Ofs(BopBar);
	End;
  $FE : A.L := Error;
  $FF : A.L := Byte(Unload);
 End;
End;

Procedure FirstMCB(Var Seg,Ofs:Word);
Var _ES,_BX   : Word;
    TSeg,TOfs : Word;
Begin
 ASM
  MOV AH,$52;
  INT $21;
  MOV _BX,BX;
  MOV AX,ES;
  MOV _ES,AX;
 END;
 TSeg := _ES - 1; TOfs := _BX + 12;
 Seg:=MemW[TSeg:TOfs+2];
 Ofs:=MemW[TSeg:TOfs];
End;

Function Unload:Boolean;
Var Addr8Ch : Pointer;

 Procedure Free(Segment:Word);
 Assembler;
 ASM
  MOV ES,Segment;
  MOV AH,$49;
  INT $21;
 END;

Begin
 Unload:=False;
 GetIntVec($8C,Addr8Ch);
 If(Addr8Ch<>@Int8Ch)Then Exit;
 SetIntVec($8C,Old8Ch);
 SetIntVec($8E,Old8Eh);
 While Mem[MCBSeg:0]=Byte('M')do
 Begin
  If(MemW[MCBSeg:1]=PrefixSeg)Then Free(MCBSeg+1);
  Inc(MCBSeg,MemW[MCBSeg:3]+1);
 End;
 Unload:=True;
End;

BEGIN
 If(ParamCount=1)and(ParamStr(1)='/MALTE')Then
 Begin
  GetIntVec($8C,Old8Ch);
  GetIntVec($8E,Old8Eh);
  FirstMCB(MCBSeg,MCBOfs);
  SetIntVec($8C,@Int8Ch);
  SetIntVec($8E,@BopBar);
  Keep(0);
 End
  Else
 Begin
  WriteLn('Malte Genesis Phoenix - Pilote Musique ''.MOD''');
  WriteLn;
  WriteLn('Seulement pour des Applications du Malte Genesis II - Phoenix.');
 End;
END.