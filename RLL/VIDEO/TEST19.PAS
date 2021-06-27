Uses Systex,Systems,D3v19;

Const EY:Array[0..22]of Byte=(0,0,0,0,6,6,2,2,4,4,4,1,5,0,0,0,4,4,2,2,4,0,1);

Procedure PutCity(X:Word);Var I:Byte;Begin
 For I:=0to 22do Begin
  PutLn(X+I,20*8+EY[I],X+I,22*8-1,3);
 End;
End;

Const HomeX=15; HomeY=3;
Const PtrDrv:Pointer=@_Driver19;
Var I,J:Word;Buffer:Array[0..255]of Byte;Int43h:Pointer;
    Buffer2:Array[0..32000]of Byte;

Procedure PutChr;Var Attr,I,J,X,Y:Wd;Chr:Char;Begin
 ASM
 MOV DX,3C4h
 MOV AL,4
 OUT DX,AL
 INC DX
 IN  AL,DX
 AND AL,0F7h
 OR  AL,4h
 OUT DX,AL
 DEC DX
 MOV AX,0F02h
 OUT DX,AX

{ MOV DX,3D4h
 MOV AL,14h
 OUT DX,AL
 INC DX
 IN  AL,DX
 AND AL,0BFh
 OUT DX,AL
 DEC DX
 MOV AL,17h
 OUT DX,AL
 INC DX
 IN  AL,DX
 OR  AL,40h
 OUT DX,AL}
 END;
{ For J:=0to 15do Mem[$A000:J*80]:=TByte(Int43h^)[J+65*8];}
 X:=0;Y:=0;Attr:=$F0;Chr:=#65;
 Port[$3C4]:=2;
 Port[$3C5]:=(Attr and$F)and(Attr shr 4);
 For I:=0to 7do Mem[$A000:X+(Y+I)*80]:=$FF;
 Port[$3C4]:=2;
 Port[$3C5]:=(Attr and$F)and Not(Attr shr 4);
 For I:=0to 7do Mem[$A000:X+(Y+I)*80]:=Mem[$FFA6:$E+Byte(Chr)*8+I];
 Port[$3C4]:=2;
 Port[$3C5]:=(Attr shr 4)and Not(Attr and$F);
 For I:=0to 7do Mem[$A000:X+(Y+I)*80]:=Not(Mem[$FFA6:$E+Byte(Chr)*8+I]);
End;

BEGIN
 InitSystems(suIsabel);
 For I:=0to 255do Buffer[I]:=I;
 ASM
  MOV AX,$13
  INT $10
 END;
 Int43h:=TableInt[$43];
 ASM
  LES DI,PtrDrv
  MOV AX,Int43h.Word
  MOV ES:[DI+286].MIV.TxtMtx.Word,AX
  MOV AX,Int43h.Word[2]
  MOV ES:[DI+286].MIV.TxtMtx.Word[2],AX
 END;
 Init;
(* SetBorderColor(2);
 For J:=0to 24do For I:=0to 31do Begin
  SetCube(I,J,Chr(J){'A'},{(I and 15)}+J*16);
 End;
 MoveText(HomeX,HomeY,HomeX+9,HomeY+19-1,HomeX,HomeY+1);
 MoveText(1,HomeY+1,9,HomeY+19-1,1,HomeY);
 ClrWn(32,1,36,2,$E0);
 SetPixel(0,1,15);
 SetGCube(1,0,'A',$F0);
 GetSmlImg(0,0,15,15,Buffer);
 PutSmlImg(20,20,35,35,Buffer);
 PutSprite(4,4,19,19,Buffer);
 Repeat Until KeyPress;
 ReadKey;
{ ClrScr(7);}
{ PutChr;}
 ReadBnk(0,32000,Buffer2);
 WriteBnk(32000,32000,Buffer2);
 ReadKey;
 For J:=0to 4do For I:=0to 39do Begin
  SetCube(I,J,Chr(J){'A'},{(I and 15)}+J*16);
 End;
 ReadKey;
 PCopy(0,3);
 PCopy(0,1);
 SetVisualPg(1);
 ClrScr(7);
{ PCopy(3,0);}*)
 PutCharGAttr(1,0,'M',$1F,1);
 PutLnHor(319,0,328,$C);
 PutLnHor(0,199{1},340,1);
 ReadKey;
{ For I:=0to 107do ClrLnHorImg(40,I,8,8,Mem[$F000:0]);}
{ BarSpcHor(0,0,3,$C0);
 ClrWn(4,4,120,44,$B0);
 For I:=0to 127do SetGCubeT(I shl 3,4*16,'M',$5);
 PutTxtXY(8,8,'Salut',$90);
 FillBox(10,10,121,40,'@',$7E);
 SetPixel(512,70,$C);
 For I:=600to 699do PutLnHor(257,I,800,$9);
 For I:=700to 767do ClrLnHorImg(0,I,256,8,Buffer);}
 Done;
 DoneSystems;
END.