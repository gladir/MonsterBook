Uses Systex,Systems,V3A256;

Const EY:Array[0..22]of Byte=(0,0,0,0,6,6,2,2,4,4,4,1,5,0,0,0,4,4,2,2,4,0,1);

Procedure PutCity(X:Word);Var I:Byte;Begin
 For I:=0to 22do Begin
  PutLn(X+I,20*8+EY[I],X+I,22*8-1,3);
 End;
End;

Const HomeX=16; HomeY=3;
Const PtrDrv:Pointer=@_DriverVGA256;
Var I,J:Word;Buffer:Array[0..255]of Byte;Int43h:Pointer;
    Tx:Array[0..32768]of Byte;

BEGIN
 InitSystems(suIsabel);
 ASM
  MOV AX,$2F
  INT $10;
 END;
 Init;
 For I:=0to 255do Buffer[I]:=I;
(* For J:=0to 24do For I:=0to 31do Begin
  SetCube(I,J,Chr(J){'A'},{(I and 15)}+J*16);
 End;*)
{ MoveText(HomeX,HomeY,HomeX+9,HomeY+19-1,HomeX,HomeY+1);
 MoveText(1,HomeY+1,9,HomeY+19-1,1,HomeY);}
 PutCharGAttr(0,0,'A',$1F,1);
 Copy8Bin(0,0,$FF,0,$E);
 For J:=0to 399do SetPixel(0,J,15);
 For J:=0to 399do SetPixel(1,J,1);
 For J:=0to 399do SetPixel(3,J,$C);
 For J:=0to 399do SetPixel(4+256-4,J,$7);
 For J:=0to 399do SetPixel(4+256-3,J,$8);
 For J:=0to 399do SetPixel(4+256-3,J,$9);
 For J:=0to 399do SetPixel(4+256-2,J,$F);
 For J:=0to 399do SetPixel(4+256-1,J,$E);
 For J:=0to 399do SetPixel(4+256+3,J,$9);
 For J:=0to 399do SetPixel(4+256+2,J,$A);
 For J:=0to 399do SetPixel(4+256,J,$B);
 For J:=0to 399do SetPixel(4+256+1,J,$C);
 For I:=0to 99do ClrLnHorImg(4,I,256,8,Buffer);
 For I:=100to 199do ClrLnHorImg(5,I,256,8,Buffer);
 For I:=200to 299do ClrLnHorImg(6,I,256,8,Buffer);
 For I:=300to 399do ClrLnHorImg(7,I,256,8,Buffer);
 ClrWn(3,3,5,5,$C0);
 SetCube(0,0,'A',$F0);
{ For I:=50to 99do ClrLnHor(7,I,252,$F);
 PutFillBox(8,101,200,200,$E);
 For I:=0to 2do PutFillBox(101+I,102+I,101+16-I,102+16-I,253+I);
 For J:=0to 2do Begin
   PutCity((5*(J+1))*8);
  PutCity((J*5+23)*8);
 End;
{ ReadBnk(0,1000,Tx);
{ GetLnHorImg(0,0,99,Tx);}
 GetSmlImg(0,0,99,99,Tx);
{ ReadKey;}
{ WriteBnk(0,1000,Tx);}
{ ClrLnHorImg(0,0,100,8,Tx);}
 PutSmlImg(0,0,99,99,Tx);
 PutFillBox(0,0,99,99,0);
 PutSprite(0,0,99,99,Tx);
 For I:=0to 24do FillBox(15,I,79,I,Chr(I),$F0);
 PutTxtXYUnKr(15,7,'Merde');
 MoveText(HomeX,HomeY,HomeX+9,HomeY+19-1,HomeX,HomeY+1);
 MoveText(1,HomeY+1,9,HomeY+19-1,1,HomeY);
{ MoveText(40,3,40+9,3+19-1,40,3+1);
 MoveText(61,3+1,69,3+19-1,61,3);}
 Repeat Until KeyPress;
{ For I:=0to 107do ClrLnHorImg(40,I,8,8,Mem[$F000:0]);
{ BarSpcHor(0,0,3,$C0);
 ClrWn(4,4,120,44,$B0);
 For I:=0to 127do SetGCubeT(I shl 3,4*16,'M',$5);
 PutTxtXY(8,8,'Salut',$90);
 FillBox(10,10,121,40,'@',$7E);
 SetPixel(512,70,$C);
 For I:=600to 699do PutLnHor(257,I,800,$9);}
 ReadKey;
 ASM
  MOV AX,3
  INT 10h
  PUSH DS
   CLD
   LES DI,PtrDrv
   MOV DS,ES:[DI+244].MIV.SegBuf
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