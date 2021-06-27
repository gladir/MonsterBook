Uses Chantal,Systex,Systems,Video;

Var Tab:Array[0..1,0..9,0..15]of Byte;

Procedure PutGameBoard(X,Y:Word);Var I:Byte;Begin
 For I:=0to 15do Begin
  SetPaletteRGB(252-I,(15-I) shl 2+I shl 2,(15-I) shl 2,(15-I) shl 2);
  PutRect(X+I,Y+I,X+16*10+16*2-1-I,Y+16*18+16*2-1-I-1,252-I);
 End;
 PutFillBox(X+16,Y+16,X+16*10+16*2-16,Y+16*18+16*2-16-1,253);
End;

Procedure PutPillule(X,Y:Word;PX,PY,D:Byte);Var RX,RY:Word;Begin
 Inc(X,16);Inc(Y,16);
 RX:=Word(PX)*16;RY:=Word(PY)*16;
 PutLnHor(X+RX,Y+RY+Word(D),X+RX+15,253);
 Inc(Y);
 PutFillBox(X+RX,Y+RY+Word(D),X+RX+15,Y+RY+15+Word(D),3);
 PutFillBox(X+RX,Y+RY+16+Word(D),X+RX+15,Y+RY+16+15+Word(D),4);
End;

Procedure SetFontImage;Var I,J:Byte;Begin
 SetPalBlk(253,3);
 For J:=0to(NmYPixels-1)shr 5do For I:=0to(NmXPixels-1) shr 5do Begin
  PutRect(I*32,J*32+0,I*32+15,J*32+15,255);
  PutFillBox(I*32+1,J*32+1,I*32+14,J*32+14,254);
  PutRect(16+I*32,J*32+16,16+I*32+15,J*32+16+15,255);
  PutFillBox(16+I*32+1,J*32+16+1,16+I*32+14,J*32+16+14,255);
 End;
 PutGameBoard(64,64);
 SetPaletteRGB(253,0,0,31);
 SetPaletteRGB(255,0,47,0);
 SetPaletteRGB(254,0,31,0);
End;

Procedure RunMono;Var J,D,P:Byte;Begin
 J:=0;D:=0;P:=0;
 PutPillule(64,64,5,J,D);
 Repeat
  WaitRetrace;
  If P=0Then Begin
   If D=15Then J := (J + 1) and 15;
   D:=(D+1)and 15;
   PutPillule(64,64,5,J,D);
  End;
  P:=(P+1)and 15;
 Until KeyPress;
End;

BEGIN { Main Unit }
 InitSystems(suIsabel);
 SetVideoMode(vmGrf320x200c256);
 FillChar(Tab,SizeOf(Tab),0);
 RunMono;
 DoneLuxeVideo;
END.
