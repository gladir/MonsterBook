{ Cette unit‚ est destin‚e … lanc‚e des applications en fenˆtres dans un
 genre de session DOS sous un systŠme d'exploitation DOS.
}

Unit Session;

INTERFACE

Uses Systex;

Type
 SessionRec=Record
  W:Window;
  RealMode:Byte;
  RealNumXTexts:Word;
 End;

Procedure SessionOpen(Var Q;X1,Y1,X2,Y2:Byte;Const Path:String);

IMPLEMENTATION

Uses Memories,Adele,Systems,Video,Isatex,Dialex,Dials;

Var
 CurrSession:^SessionRec;
 OldIntr10h,OldIntr28h:Pointer;
 NewStack:Pointer;

Procedure PublicData;Assembler;ASM
 DD CurrSession
 DD 0
END;

Procedure InternalData;Assembler;ASM
 DW 0       { Ancien DS }
 DW 0       { Ancien SP }
 DW 0       { Ancien SS }
END;

{Var VidBuf:Array[0..4095]of Byte;}

Procedure Intr28h;Interrupt;
Var
 I,J:Byte;
Begin
 ASM
  MOV Word Ptr InternalData,DS
  MOV DS,Word Ptr PublicData[2]
  MOV Word Ptr InternalData[2],SP
  MOV Word Ptr InternalData[4],SS
  MOV SS,Word Ptr PublicData[6]
  MOV SP,Word Ptr PublicData[4]
 END;
{ MoveLeft(Mem[$B800:0],VidBuf,4096);
 Port[$3CE]:=$6;
 Port[$3CF]:=(Port[$3CF]and Not(2+4))or 2;}
 {For J:=0to 24do For I:=0to 79do
  SetCube(I,J,Chr(VidBuf[(I shl 1)+J*160]),VidBuf[((I shl 1)+1)+J*160]);}
 _BackKbd;
(* Port[$3CE]:=$6;
 Port[$3CF]:=(Port[$3CF]{or(2+4)}and Not(2+4));*)
 ASM
  MOV SP,Word Ptr InternalData[2]
  MOV SS,Word Ptr InternalData[4]
  MOV DS,Word Ptr InternalData
 END;
End;

Procedure Intr10h(_Flags,_CS,_IP,_AX,_BX,_CX,_DX,_SI,_DI,_DS,_ES,_BP:Word);Interrupt;
Const InInterrupt:Bool=No;Var OldIntr:Procedure Absolute OldIntr10h;
AX,BX,CX,DX:Word;Begin
 ASM
  MOV AX,_AX
  MOV BX,_BX
  MOV CX,_CX
  MOV DX,_DX
  MOV Word Ptr InternalData,DS
  MOV DS,Word Ptr PublicData[2]
  MOV Word Ptr InternalData[2],SP
  MOV Word Ptr InternalData[4],SS
  MOV SS,Word Ptr PublicData[6]
  MOV SP,Word Ptr PublicData[4]
  MOV Word Ptr &AX,AX
  MOV Word Ptr &BX,BX
  MOV Word Ptr &CX,CX
  MOV Word Ptr &DX,DX
 END;
 If(InInterrupt)Then OldIntr
  Else
 Begin
  InInterrupt:=Ya;
{  Port[$3CE]:=$6;
  Port[$3CF]:=(Port[$3CF]and Not(2+4))or 2;}
  Case Hi(AX)of
   0:;
   2:Begin
    CurrSession^.W.X:=Lo(DX);
    CurrSession^.W.Y:=Hi(DX);
    WESetCurPos(CurrSession^.W,Lo(DX),Hi(DX));
   End;
   3:MoveLeft(CurrSession^.W.X,DX,SizeOf(Word));
   $9:Begin
    WESetKr(CurrSession^.W,BX);
    WEPutTxt(CurrSession^.W,MultChr(Chr(Lo(AX)),CX));
   End;
   $A:WEPutTxt(CurrSession^.W,MultChr(Chr(Lo(AX)),CX));
   $E:Begin
    Case Lo(AX)of
     0..7:;
     8:Begin
      _WELeft(CurrSession^.W);
      WEPutCube(CurrSession^.W,' ');
      Dec(CurrSession^.W.X);
     End;
     9..12:;
     13:Begin
      _WELn(CurrSession^.W);
     End;
     14..31:;
     Else Begin
      WESetKr(CurrSession^.W,BX);
      WEPutTxt(CurrSession^.W,Chr(Lo(AX)));
      If(CurrSession^.W.X>CurrSession^.W.MaxX)Then _WELn(CurrSession^.W);
     End;
    End;
    WESetCurPos(CurrSession^.W,CurrSession^.W.X,CurrSession^.W.Y);
   End;
   $F:Begin
    AX:=((CurrSession^.W.MaxX+1)shl 8)+CurrVideoMode;
    BX:=0;
   End;
  End;
(*  Port[$3CE]:=$6;
  Port[$3CF]:=(Port[$3CF]{or(2+4)}and Not(2+4));*)
  InInterrupt:=No;
 End;
 ASM
  MOV AX,Word Ptr &AX
  MOV BX,Word Ptr &BX
  MOV CX,Word Ptr &CX
  MOV DX,Word Ptr &DX
  MOV SP,Word Ptr InternalData[2]
  MOV SS,Word Ptr InternalData[4]
  MOV DS,Word Ptr InternalData
  MOV _AX,AX
  MOV _BX,BX
  MOV _CX,CX
  MOV _DX,DX
 END;
End;

Procedure SessionOpen(Var Q;X1,Y1,X2,Y2:Byte;Const Path:String);Begin
 WEInit(SessionRec(Q).W,X1,Y1,X2,Y2);
 WEPutWn(SessionRec(Q).W,'Session DOS '+
         TruncName(Path,SessionRec(Q).W.MaxX-15),
         CurrKrs.MalteDos.Wins);
 SimpleCur;
 CurrSession:=@Q;
 GetIntVec($10,OldIntr10h);
 SetIntVec($10,@Intr10h);
 GetIntVec($28,OldIntr28h);
 SetIntVec($28,@Intr28h);
 NewStack:=MemAlloc(16384);
 {$IFNDEF NotReal}
  FreeMaxHeap;
 {$ENDIF}
 ASM
  LES DI,NewStack
  MOV Word Ptr PublicData[6],ES
  ADD DI,16380
  MOV Word Ptr PublicData[4],DI
 END;
 SessionRec(Q).RealMode:=CurrVideoMode;
 SessionRec(Q).RealNumXTexts:=MemW[_0040:$4A];
 MemW[_0040:$4A]:=SessionRec(Q).W.MaxX+1;
 Exec(Path,'');
 CurrVideoMode:=SessionRec(Q).RealMode;
 MemW[_0040:$4A]:=SessionRec(Q).RealNumXTexts;
 {$IFNDEF NotReal}
  FreeMaxHeap;
 {$ENDIF}
 SetIntVec($10,OldIntr10h);
 SetIntVec($28,OldIntr28h);
End;

END.