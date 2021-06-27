Unit ChkMouse;

INTERFACE

Procedure CheckMouse;

IMPLEMENTATION

Uses Adele,Systex,Systems,Video,Mouse,Dialex,Dials;

Procedure CheckMouse;
Var
 W:Window;
 K:Word;
 XM,YM,BM,OB,OX,OY:Word;
 X,Y:Byte;
 OldShade:Boolean;
 Button:Set Of (Left,Right,Center) Absolute BM;
 Color:Byte;
Begin
 WEInitO(W,40,20);
 WEPushWn(W);
 WEPutWnKrDials(W,'Souris');
 WECloseIcon(W);
 WEBar(W);
 WEPutTxtXY(W,0,1,'Bouton:');
 WEPutTxtXY(W,0,2,'X:');
 WEPutTxtXY(W,0,3,'Y:');
 X:=WEGetRX1(W);
 Y:=WEGetRY1(W);
 BarHorDials(X,Y+4,X+38,W.CurrColor);
  { Dessine la souris }
 OldShade:=GetShade;
 SetShade(False);
 SetBorderSimple;
 PutFillBorder(X+10,Y+6,X+29,Y+18,$70);
 PutFillBorder(X+11,Y+7,X+16,Y+11,$70);
 PutFillBorder(X+17,Y+7,X+22,Y+11,$70);
 PutFillBorder(X+23,Y+7,X+28,Y+11,$70);
 OB:=$FFFF;OX:=$FFFF;OY:=$FFFF;
 SetShade(OldShade);
 __ShowMousePtr;
 _InitKbd;
 Repeat
  GetMouseSwitch(XM,YM,BM);
  If BM>0Then Begin
   If WEInCloseIcon(W,XM shr 3,YM div GetHeightChr)Then Begin
    WaitMouseBut0;
    Break;
   End;
  End;
  If(OB<>BM)Then Begin
   __HideMousePtr;
   WEPutTxtXY(W,15,1,StrUSpc(IntToStr(BM),10));
   If(Left)in(Button)Then Color:=Black
                     Else Color:=$70;
   WEClrWn(W,12,8,15,10,Color);
   If(Center)in(Button)Then Color:=Black
                       Else Color:=$70;
   WEClrWn(W,18,8,21,10,Color);
   If(Right)in(Button)Then Color:=Black
                      Else Color:=$70;
   WEClrWn(W,24,8,27,10,Color);
   __ShowMousePtr;
   OB:=BM;
  End;
  If(OX<>XM)Then Begin
   __HideMousePtr;
   WEPutTxtXY(W,15,2,StrUSpc(IntToStr(XM),10));
   __ShowMousePtr;
   OX:=XM;
  End;
  If(OY<>YM)Then Begin
   __HideMousePtr;
   WEPutTxtXY(W,15,3,StrUSpc(IntToStr(YM),10));
   __ShowMousePtr;
   OY:=YM;
  End;
  _BackKbd;
 Until KeyPress;
 __HideMousePtr;
 ClrKbd;
 WEDone(W);
End;

END.