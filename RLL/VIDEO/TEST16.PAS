Uses D3v16,Systex,Systems;

Const PtrDrv:Pointer=@_Driver16;Const HomeX=16; HomeY=3;
Var Old,J,I:Word;Buffer:Array[0..60000]of Byte;Int43h:Pointer;

Function ReadKey:Word;Assembler;ASM
 XOR AX,AX
 INT 16h
END;

BEGIN
 InitSystems(suIsabel);
 For I:=0to 255do Buffer[I]:=I;
 ASM
  MOV AX, 18 { $E }
  INT $10
 END;
 Int43h:=TableInt[$43];
 ASM
  LES DI,PtrDrv
{  MOV ES:[DI+256].PIV.VGA,Ya}
  MOV ES:[DI+286].MIV.Mode,vmGrf640x480c16
  MOV AX,Int43h.Word
  MOV ES:[DI+286].MIV.TxtMtx.Word,AX
  MOV AX,Int43h.Word[2]
  MOV ES:[DI+286].MIV.TxtMtx.Word[2],AX
 END;
 Init;
 SetPaletteRGB(14,$FF,$FF,$FF);
 ClrScr($10);
 BarSpcHor(0,0,79,$F0);
 For I:=0to 639do PutLn(639-I,479,I,0,$7);
 PutLn(638,200,1,200,14);
 CloseIcon(1,1,$F);
 DownIcon(1,2,$F);
 LeftIcon(1,3,$F);
 RightIcon(1,4,$F);
 SelIcon(1,5,$F);
 UnSelIcon(1,6,$F);
 UpIcon(1,7,$F);
 ZoomIcon(1,8,$F);
 DossierDocumentIcon(2,9,$1E);
 DossierProgramIcon(2,10,$1C);
 BarChrHor(4,4,8,'C');
 ReadKey;
 ClrScr($20);
 PutFillCircle(200,200,100,$C);
 For I:=0to 7do PutLnHor(I,I,7,$E);
 For I:=8to 25do PutLnHor(I,I,7,$E);
 PutLn(1,0,1,239,1);
 FillClr(Buffer,SizeOf(Buffer));
 GetSmlImg(2+0,0,2+399,239,Buffer);
 PutSmlImg(8+0,0,8+399,199,Buffer);
{ PutFillBox(16,240,415,480,15);}
(* SetPg(1);
 PutSmlImg(16,{240}0,415,{480}79,Buffer);
 SetPg(0);
 PCopy2Img(1,0,1,639,79);*)
 ReadKey;
(* BarSpcHor(10,10,13,$C0);
 BarSpcVer(3,1,25,$E0);
 ClrWn(4,4,12{0},5{4},$F0);
 Copy8Bin(0,0,$FF,13,12);
 SetPixel(0,0,14);
 SetPixel(0,2,1);
 SetPixel(18,8,GetPixel(0,0));
 For I:=0to 12{7}do SetGCubeT(I shl 3,{4*}16,'M',$5);
 For I:=0to 12{7}do Begin
  SetGCube(I shl 4,{4*}32,'A',$10*I+$10);
  SetGCube(I shl 4+1,{4*}48,'A',$10*I+$10+15-I);
  SetCube(I,5,'Z',$10*I+$10+15-I);
 End;
 PutCharGAttr(0,0,'D',$10,$1B);
 PutCharGAttr(2,0,'A',$20,9);
 PutCharGAttr(3,0,'ê',$20,9);
 PutCharGAttr(3,1,'A',$80,$01);
 PutTxtXY(8,8,'Salut',$9C);
 PutTxtXY(8,8,'Merde',$A0);
 PutTxtXY(8,8,'Allo!',$2B);
 PutLnHor(0,100,199,1);
 FillBox(10,11,21,21,'@',$7C);
 SetChr(10,11,'A');
 For J:=0to 29do For I:=0to 31do FillBox(16+(I shl 1),J,17+(I shl 1),J,'@',(J shl 4){+I});
{ SetPixel(512,70,$C);
 For I:=600to 699do PutLnHor(257,I,800,$9);}
 For I:=60to 67do ClrLnHorImg(0,I,256,8,Buffer);
 ReadKey;

{ For I:=0to 24do FillBox(15,I,79,I,'A',$F0);}
 MoveText(HomeX,HomeY,HomeX+9,HomeY+19-1,HomeX,HomeY+1);
 MoveText(1,HomeY+1,9,HomeY+19-1,1,HomeY);
 ReadKey;*)
 ASM
  MOV AX,3
  INT 10h
  PUSH DS
   CLD
   LES DI,PtrDrv
   MOV DS,ES:[DI+286].MIV.SegBuf
   XOR SI,SI
   XOR DI,DI
   MOV AX,$B800
   MOV ES,AX
   MOV CX,4000
   REP MOVSB
  POP DS
 END;
 Done;
 DoneSystems;
END.