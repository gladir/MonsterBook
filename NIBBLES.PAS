Unit Nibbles;

{$I Def.Inc}

INTERFACE

Uses Isatex;

Function  NibbleInit(Var Context;X1,Y1,X2,Y2:Byte):Boolean;
Procedure NibbleStart(Var Q:NibbleGame);
Procedure NibbleRefresh(Var Context);
Function  NibblePlay(Var Context):Word;
Procedure NibbleMove2(Var Context;X,Y:Byte);
Function  NibbleTitle(Var Context;Max:Byte):String;
Procedure NibbleSetLevel(Var Q:NibbleGame);
Function  NibbleDone(Var Q):Word;

IMPLEMENTATION

Uses
 Adele,Systex,Systems,Video,Mouse,Math,Dials,Dialex;

Procedure WEPutMsg(Var W:Window;X:Byte;Const Msg:String;Color:Byte);Near;
Var
 I,J:Byte;
 Y:Word;
Begin
 Inc(X,WEGetRX1(W));
 Y:=GetRawY(WEGetRY1(W)+W.MaxY);
 For J:=0to Length(Msg)-1do For I:=0to HeightChr-1do
  Copy8Bin((X+J)shl 3,Y+I,TByte(GetVideoTxtMtxPtr^)[I+Byte(Msg[J+1])*HeightChr],0,Color+I);
End;

Procedure NibbleStart(Var Q:NibbleGame);Begin
 Randomize;
 Q.X[1]:=Random(320);
 Q.Y[1]:=Random(192);
 Repeat
  Q.X[2]:=Random(320);
  Q.Y[2]:=Random(192)
 Until Not((Q.X[1]=Q.X[2])and(Q.Y[1]=Q.Y[2]));
 Q.RX[1]:=0;Q.RY[1]:=-1;
 Q.RX[2]:=0;Q.RY[2]:=1;
 WEClrWn(Q.MainWin,0,0,wnMax,wnMax,Black);
 WEPutMsg(Q.MainWin,0,'Joueur 1: '+WordToStr(Q.PR[1]),236);
 WEPutMsg(Q.MainWin,25,'Ordinateur: '+WordToStr(Q.PR[2]),244);
End;

Const HomeY=8;Max=9;

Procedure PutBar(Y:Integer);Begin
 BarSelHor(6,Y+HomeY,MaxXTxts-6,$A0);
 SetMousePos(0,Y*8);
End;

Procedure UndoBar(Y:Integer);Begin
 BarSelHor(6,Y+HomeY,MaxXTxts-6,$9);
End;

Procedure NibbleShow(Var Q:NibbleGame);Begin
 Case(Q.D)of
  0:PutTxtCenter(2,__Justified__,'Vitesse',$B);
  8:PutTxtCenter(2,__Justified__,'Vitesse',$E);
 End;
 Q.D:=(Q.D+1)and 15;
End;

Procedure NibbleSetLevel(Var Q:NibbleGame);
Label 0;
Var
 XM,YM,BM,K:Word;
 J,Y,Wait:SmallInt;
Begin
 Repeat
  Y:=0;
  SetVideoMode(vmTxtC40);
  SetBlink(No);
  CloseCur;
  __InitMouse;
  SetMouseMoveAreaY(0,Max*8);
  SetKr($9);
  For J:=0to(Max)do _PutTxtXY(8,HomeY+J,CenterStr(WordToStr(J+1),24));
  PutBar(Y);
  Wait:=0;
  Repeat
   Repeat
    WaitRetrace;
    Inc(Wait);
    If Wait=4Then Begin
     NibbleShow(Q);
     Wait:=0;
    End;
    GetMouseSwitch(XM,YM,BM);
    If(YM shr 3<>Y)Then Begin
     UndoBar(Y);
     Y:=YM shr 3;
     PutBar(Y);
    End;
    If BM>0Then Goto 0;
   Until KeyPress;
   K:=ReadKey;
   Case(K)of
    kbHome:Begin
     UndoBar(Y);
     Y:=0;
     PutBar(Y);
    End;
    kbUp,kbLeft:Begin
     UndoBar(Y);
     Y:=MinByte(Y,Max);
     PutBar(Y);
    End;
    kbDn,kbTab,kbRight:Begin
     UndoBar(Y);
     Y:=MaxByte(Y,Max);
     PutBar(Y);
    End;
    kbEnd:Begin
     UndoBar(Y);
     Y:=Max;
     PutBar(Y);
    End;
    kbEnter:0:Begin
     Q.Speed:=9-Alpha(Y,Max-1);
     Exit;
    End;
    kbEsc:Begin
     Q.Speed:=1;
     Exit;
    End;
   End;
  Until No;
 Until No;
End;

Procedure NibbleRefresh(Var Context);
Var
 Q:NibbleGame Absolute Context;
 T:TextBoxRec;
Begin
 T:=Q.MainWin.T;
 T.X1:=WEGetRX1(Q.MainWin);
 T.Y1:=WEGetRY1(Q.MainWin);
 T.Y2:=T.Y1+Q.MainWin.MaxY-1;
 CoordTxt2Graph(T,Q.G);
 Q.MaxYPixel:=(Q.G.Y2-Q.G.Y1)-1;
 WEPutWn(Q.MainWin,'Nibbles',CurrKrs.MalteDos.Window);
 WECloseIcon(Q.MainWin);
End;

Function NibbleInit(Var Context;X1,Y1,X2,Y2:Byte):Boolean;
Var
 Q:NibbleGame Absolute Context;
 S:String;
Begin
 FillClr(Q,SizeOf(NibbleGame));
 Q.CurrText:=0;
 Q.Speed:=1;
 S:=Chr($FC-70)+Chr($FC-70)+Chr($24-35)+
    Chr($FC-60)+Chr($FC-60)+Chr($24-30)+
    Chr($FC-50)+Chr($FC-50)+Chr($24-25)+
    Chr($FC-40)+Chr($FC-40)+Chr($24-20)+
    Chr($FC-30)+Chr($FC-30)+Chr($24-15)+
    Chr($FC-20)+Chr($FC-20)+Chr($24-10)+
    Chr($FC-10)+Chr($FC-10)+Chr($24-5)+
    Chr($FC)+Chr($FC)+Chr($24)+
    Chr($FC-70)+Chr(0)+Chr(0)+
    Chr($FC-60)+Chr(0)+Chr(0)+
    Chr($FC-50)+Chr(0)+Chr(0)+
    Chr($FC-40)+Chr(0)+Chr(0)+
    Chr($FC-30)+Chr(0)+Chr(0)+
    Chr($FC-20)+Chr(0)+Chr(0)+
    Chr($FC-10)+Chr(0)+Chr(0)+
    Chr($FC)+Chr(0)+Chr(0);
 MoveLeft(S[1],Q.Pal,SizeOf(Q.Pal));
 If BitsPerPixel<=8Then Begin
  SetPalRGB(Q.Pal,236,16);
 End;
 WEInit(Q.MainWin,X1,Y1,X2,Y2);
 NibbleRefresh(Q);
 NibbleStart(Q);
End;

Function NibblePlay(Var Context):Word;
Var
 Q:NibbleGame Absolute Context;
 J:SmallInt;
 K:Word;
 Color:Word;
Begin
 Repeat
  __ShowMousePtr;
  Repeat
   If __GetMouseButton>0Then Break;
   If GetPixel(Q.G.X1+Q.X[1],Q.G.Y1+Q.Y[1])<>0Then Begin
    Q.MainWin.CurrColor:=$C;
    Q.MainWin.Y:=Q.MainWin.MaxY shr 1;
    WEPutOTxt(Q.MainWin,'Vous avez fait l''impacte!');
    ClrKbd;
    ReadKey;
    Inc(Q.PR[2]);
    NibbleStart(Q);
   End;
   If GetPixel(Q.G.X1+Q.X[2],Q.G.Y1+Q.Y[2])<>0Then Begin
    Q.MainWin.CurrColor:=$C;
    Q.MainWin.Y:=Q.MainWin.MaxY shr 1;
    WEPutOTxt(Q.MainWin,'L''Ordinateur a fait l''impacte!');
    ClrKbd;
    ReadKey;
    Inc(Q.PR[1]);
    NibbleStart(Q);
   End;
   For J:=0to 1do Begin
    If BitsPerPixel<=8Then Color:=236+(J shl 3)+Q.CurrText
     Else
    Begin
     Color:=RGB2Color(Q.Pal[J][Q.CurrText].R,Q.Pal[J][Q.CurrText].G,Q.Pal[J][Q.CurrText].B)
    End;
    SetPixel(Q.G.X1+Q.X[J+1],Q.G.Y1+Q.Y[J+1],Color);
   End;
   For J:=1to(Q.Speed)do WaitRetrace;
   Q.CurrText:=(Q.CurrText+1)and 7;
   If Q.RX[2]<>0Then Begin
    If GetPixel(Q.G.X1+Q.X[2]+Q.RX[2],Q.G.Y1+Q.Y[2])<>0Then Begin
     Q.RX[2]:=0;
     If GetPixel(Q.G.X1+Q.X[2],Q.G.Y1+Q.Y[2]-1)=0Then Q.RY[2]:=-1 Else Q.RY[2]:=1;
    End;
   End
    Else
   If Q.RY[2]<>0Then Begin
    If GetPixel(Q.G.X1+Q.X[2],Q.G.Y1+Q.Y[2]+Q.RY[2])<>0Then Begin
     Q.RY[2]:=0;
     If GetPixel(Q.G.X1+Q.X[2]-1,Q.G.Y1+Q.Y[2])=0Then Q.RX[2]:=-1
                                                 Else Q.RX[2]:=1;
    End;
   End;
   For J:=1to 2do Begin
    Inc(Q.X[J],Q.RX[J]);
    Inc(Q.Y[J],Q.RY[J]);
    If Q.RX[J]<>0Then Begin
     If Q.X[J]=0Then Q.X[J]:=319 Else
     If Q.X[J]=319Then Q.X[J]:=0;
    End;
    If Q.RY[J]<>0Then Begin
     If Q.Y[J]=0Then Q.Y[J]:=Q.MaxYPixel Else
     If(Q.Y[J]=Q.MaxYPixel)Then Q.Y[J]:=0;
    End;
   End;
  Until KeyPress;
  __HideMousePtr;
  K:=WEReadk(Q.MainWin);
  Case(K)of
   kbUp:If Q.RY[1]=0Then Begin;Q.RY[1]:=-1;Q.RX[1]:=0;End;
   kbDn:If Q.RY[1]=0Then Begin;Q.RY[1]:=1;Q.RX[1]:=0;End;
   kbLeft:If Q.RX[1]=0Then Begin;Q.RY[1]:=0;Q.RX[1]:=-1;End;
   kbRight:If Q.RX[1]=0Then Begin;Q.RY[1]:=0;Q.RX[1]:=1;End;
   Else Begin
    NibblePlay:=K;
    Break;
   End;
  End;
 Until No;
End;

Procedure NibbleMove2(Var Context;X,Y:Byte);
Var
 Q:NibbleGame Absolute Context;
 MX,MY:Byte;
Begin
 MX:=Q.MainWin.T.X2-Q.MainWin.T.X1;
 MY:=Q.MainWin.T.Y2-Q.MainWin.T.Y1;
 Q.MainWin.T.X1:=X;Q.MainWin.T.X2:=X+MX;
 Q.MainWin.T.Y1:=Y;Q.MainWin.T.Y2:=Y+MY;
 NibbleRefresh(Q);
End;

Function NibbleTitle(Var Context;Max:Byte):String;Begin
 NibbleTitle:='Nibble';
End;

Function NibbleDone(Var Q):Word;Begin
 NibbleDone:=0;
End;

END.