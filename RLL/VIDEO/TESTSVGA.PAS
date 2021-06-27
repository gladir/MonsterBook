Uses Adele,Systex,Systems,Video,DrvSVGA3;

{$DEFINE _640}

Const HomeX=15; HomeY=4;
Const PtrDrv:PTByte=@_DriverSVGA3;
Var I:Word;Buffer:Array[0..255]of Byte;
    Int43h:Pointer;MIVPtr:^MIV;PIVPtr:^PIV;OldMIV:MIV;

Const LuxePtr:Array[0..9*17-1]of Byte=(
$08,$00,$00,$00,$00,$00,$00,$00,$00,
$08,$07,$00,$00,$00,$00,$00,$00,$00,
$08,$07,$07,$00,$00,$00,$00,$00,$00,
$08,$0F,$07,$07,$00,$00,$00,$00,$00,
$08,$0F,$07,$07,$07,$00,$00,$00,$00,
$08,$0F,$0F,$07,$07,$07,$00,$00,$00,
$08,$0F,$0F,$07,$07,$07,$07,$00,$00,
$08,$0F,$0F,$0F,$07,$07,$07,$07,$00,
$08,$0F,$0F,$0F,$07,$07,$07,$07,$07,
$08,$0F,$0F,$07,$00,$00,$00,$00,$00,
$08,$0F,$07,$00,$0F,$07,$00,$00,$00,
$08,$07,$00,$00,$08,$0F,$07,$00,$00,
$08,$00,$00,$00,$08,$0F,$07,$00,$00,
$00,$00,$00,$00,$00,$08,$0F,$07,$00,
$00,$00,$00,$00,$00,$08,$0F,$07,$00,
$00,$00,$00,$00,$00,$00,$08,$0F,$07,
$00,$00,$00,$00,$00,$00,$08,$07,$07);

BEGIN
 InitSystems(suIsabel);
 For I:=0to 255do Buffer[I]:=I;
 SetVideoMode(vmGrf640x480c256);
 PIVPtr:=@PtrDrv^[256];
 GetPIV(PIVPtr^);
(* ASM
  {$IFDEF _640}MOV AX,$2E{$ELSE}MOV AX,$38{$ENDIF}
  INT $10
 END;*)
 Init;
 MIVPtr:=@PtrDrv^[286];
 MoveLeft(MIVPtr^,OldMIV,SizeOf(MIV));
 GetMIV(MIVPtr^);
 For I:=0to 479do PutLn{Hor}(0,I,639,I,15);
 BarSpcHor(0,0,3,$C0);
 BarSpcHor(5,1,79,$20);
 SetChr(6,1,'Q');
 For I:=0to 20do PutCharGAttr(8+(I shl 1),1,Chr(I+65),$27,$11);
 For I:=0to 20do PutCharGAttr(8+(I shl 1),3,Chr(I+65),$07,$4);
 ClrWn(4,4,{$IFDEF _640}78,24{$ELSE}120,44{$ENDIF},$B0);
 For I:=0to {$IFDEF _640}79{$ELSE}127{$ENDIF}do SetGCubeT(I shl 3,4*16,'M',$5);
 PutTxtXY(8,8,'Salut',$90);
 FillBox({$IFDEF _640}1,10,77,28{$ELSE}10,10,121,40{$ENDIF},'@',$7E);
 For I:=0to 470do SetPixel(512,I,$C);
 For I:=0to 20do PutCharGAttr(8+(I shl 1),5,Chr(I+65),$07,$3);
 For I:=0to 20do PutCharGAttr(8+(I shl 1),7,Chr(I+65),$07,$9);
 CopT8Bin(253,102,$AA,$C);
 PutSprite(255,95,263,111,LuxePtr);
 ReadKey;
 For I:=0to 767do Copy8Bin(0,I,Mtx8x8High[I],13,1);
 For I:=0to 17do CopT8Bin(630+I,101+I,$AA,$C);
 {$IFDEF _640}
  For I:=300to 399do
 {$ELSE}
  For I:=600to 699do
 {$ENDIF}
  PutLnHor(257,I,{$IFDEF _640}350{$ELSE}800{$ENDIF},$9);
 {$IFDEF _640}
  For I:=200to 479do
 {$ELSE}
  For I:=700to 767do
 {$ENDIF}
  ClrLnHorImg(0,I,256,8,Buffer);
 For I:=0to 479do Begin
  GetLnHorImg(0,I,640,Buffer);
  ClrLnHorImg(0,I,640,8,Buffer);
 End;
 MoveText(HomeX,HomeY,HomeX+9,HomeY+19-1,HomeX,HomeY+1);
 MoveText(1,HomeY+1,9,HomeY+19-1,1,HomeY);
 PutSprite(8,8,8+9-1,8+17-1,LuxePtr);
 PutSprite(636,108,636+9-1,108+17-1,LuxePtr);
{ ReadKey;}
 ASM
  XOR AX,AX
  INT 16h
 END;
(* ASM
  {$IFDEF _640}
   MOV AX,26h
   INT 10h
  {$ELSE}
   MOV AX,22h
   INT 10h
  {$ENDIF}
  PUSH DS
   CLD
   LES DI,PtrDrv
   MOV DS,ES:[DI+286].MIV.SegBuf
   XOR SI,SI
   XOR DI,DI
   MOV AX,$B800
   MOV ES,AX
   MOV CX,128*2*48
   REP MOVSB
  POP DS
 END;*)
 MoveLeft(OldMIV,MIVPtr^,SizeOf(MIV));
{ Done;}
 SetVideoMode(vmTxtDef);
{ DoneSystems;}
END.