Uses Adele,Systex,Systems,Video,Drv65536;

Const PtrDrv:PTByte=@_Driver65536;
Var I,J,X,HC:Word;
    MIVPtr:^MIV;PIVPtr:^PIV;OldMIV:MIV;

    Buffer:Array[0..4096]of Word;

Const LuxePtr:Array[0..9*17-1]of Word=(
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

Function RGB2Kr(R,G,B:Byte):Word;Begin
 RGB2Kr:=((B shr 2)+((((G and$F8)shl 3)+((R and$F8)shl 8))))shr 1;
{ RGB2Kr:=(B shr 3)+((((G and$F8)shl 3)+((R and$F8)shl 8)));}
End;

BEGIN
 InitSystems(suIsabel);
 SetVideoModeDeluxe({vmGrf640x480c32768}vmGrf800x600c65536);
 PIVPtr:=@PtrDrv^[256];
 GetPIV(PIVPtr^);
 Init;
 MIVPtr:=@PtrDrv^[286];
{ MIVPtr^.NmXPixels:=799;
 MIVPtr^.BytesPerLn:=1600-2;}
{ MoveLeft(MIVPtr^,OldMIV,SizeOf(MIV));
 GetMIV(MIVPtr^);
{ ASM
  MOV AX,4F02h
  MOV BX,0111h
  INT 10h
 END;
 Init;}
{ X:=$FFFF;
 For J:=0to 479do For I:=0to 639do Begin
  SetPixel(I,J,X);
  Dec(X);
 End;}
 ClrLnHor(8,8,624,$C000);
 PutFillBox(8,10,632,51,$00E);
 SetCube(0,0,'A',$1F);
 SetCube(1,1,'B',$2E);
 BarSpcHor(1,0,79,$3F);
 CopT8Bin(8,0,$AA,$C000);
 Copy8Bin(8,1,$AA,$C000,$00E);
 SetGCube(12,2,'Z',$3F);
 PutCharGAttr(0,10,'A',$10,$10);
 PutCharGAttr(13,13,'B',$10,1);
 PutCharGAttr(1,14,'C',$F0,8);
 CloseIcon(31,6,$F);
 DownIcon(1,2,$F);
 LeftIcon(1,3,$F);
 RightIcon(1,4,$F);
 SelIcon(1,5,$F);
 UnSelIcon(1,6,$F);
 UpIcon(1,7,$F);
 ZoomIcon(1,8,$F);
 DossierDocumentIcon(2,9,$1B);
 DossierProgramIcon(2,10,$1C);
 GetLnHorImg(256,80,256+256,Buffer);
 FillClr(Buffer,SizeOf(Buffer));
 For I:=0to 255do Buffer[I]:=RGB2Kr(I,I,I);
 ClrLnHorImg(0,80,256,16,Buffer);
{ For I:=0to 255do SetPixel(I,80,RGB2Kr(I,I,I));}
{ ClrLnHor(8,51,600,$C);}
 PutFillBox(550,90,580,120,$FFFF);
 PutSprite(555,95,563,111,LuxePtr);
 PutTxtXY(1,1,'Salut',$9F);
 For I:=20to 50do Begin
  GetSmlImg(2,19,I,I,Buffer);
  PutRect(2,19,I,I,RGB2Kr($FF,0,0));
  PutSmlImg(2,19,I,I,Buffer);
 End;
 ReadKey;
 ASM
  MOV AX,3
  INT 10h
 END;
END.