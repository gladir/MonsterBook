Program Nibbles;

{$I \Source\Chantal\Def.Inc}
Uses {$IFDEF Adele}Adele,{$ELSE}Chantal,{$ENDIF}
     Systex,Systems,Video,Mouse,Math;

Const PalYellow:Array[0..7]of RGB=(
 (R:$FC-70;G:$FC-70;B:$24-35),
 (R:$FC-60;G:$FC-60;B:$24-30),
 (R:$FC-50;G:$FC-50;B:$24-25),
 (R:$FC-40;G:$FC-40;B:$24-20),
 (R:$FC-30;G:$FC-30;B:$24-15),
 (R:$FC-20;G:$FC-20;B:$24-10),
 (R:$FC-10;G:$FC-10;B:$24-5),
 (R:$FC;G:$FC;B:$24));

Const PalRed:Array[0..7]of RGB=(
 (R:$FC-70;G:0;B:0),
 (R:$FC-60;G:0;B:0),
 (R:$FC-50;G:0;B:0),
 (R:$FC-40;G:0;B:0),
 (R:$FC-30;G:0;B:0),
 (R:$FC-20;G:0;B:0),
 (R:$FC-10;G:0;B:0),
 (R:$FC;G:0;B:0));

CurrText:Byte=0;

Var Speed:Integer;X,Y,RX,RY,PR:Array[1..2]of Integer;

Procedure PutMsg(X:Byte;Msg:String;Kr:Byte);Var I,J:Byte;Begin
 For J:=0to Length(Msg)-1do For I:=0to 7do
  Copy8Bin((X+J)shl 3,192+I,TByte(GetVideoTxtMtxPtr^)[I+Byte(Msg[J+1])shl 3],0,Kr+I)
End;

Procedure Init;Begin
 X[1]:=Random(320);Y[1]:=Random(192);
 Repeat;X[2]:=Random(320);Y[2]:=Random(192)Until Not((X[1]=X[2])and(Y[1]=Y[2]));
 RX[1]:=0;RY[1]:=-1;RX[2]:=0;RY[2]:=1;
 ClrScrBlack;
 PutMsg(0,'Joueur 1: '+WordToStr(PR[1]),236);
 PutMsg(25,'Ordinateur: '+WordToStr(PR[2]),244);
End;

Const HomeY=8;Max=9;

Procedure PutBar(Y:Integer);Begin
 BarSelHor(6,Y+HomeY,MaxXTxts-6,$A0);
 SetMousePos(0,Y*8);
End;

Procedure UndoBar(Y:Integer);Begin
 BarSelHor(6,Y+HomeY,MaxXTxts-6,$9);
End;

Var D:Byte;

Procedure Show;Begin
 Case(D)of
  0:PutTxtCenter(2,__Justified__,'Vitesse',$B);
  8:PutTxtCenter(2,__Justified__,'Vitesse',$E);
 End;
 D:=(D+1)and 15;
End;

Procedure ChoiceSpeed;Label 0;Var XM,YM,BM,K:Wd;J,Y,Wait:Integer;Begin
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
     Show;
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
    kbEnter:0:Begin;Speed:=9-Alpha(Y,Max-1);Exit;End;
    kbEsc:Begin;Speed:=1;Exit;End;
   End;
  Until No;
 Until No;
End;

Procedure Play;Var J:Integer;Begin
 FillClr(PR,SizeOf(PR));Speed:=1;
 ChoiceSpeed;
 SetVideoMode(vmGrf320x200c256);
 CloseCur;
 SetPalRGB(PalYellow,236,8);
 SetPalRGB(PalRed,244,8);
 Init;
 Repeat
  Repeat
   If GetPixel(X[1],Y[1])<>0Then Begin
    PutTxtCenter(12,__Justified__,'Vous avez fait l''impacte!',$C);
    ClrKbd;
    ReadKey;
    Inc(PR[2]);
    Init;
   End;
   If GetPixel(X[2],Y[2])<>0Then Begin
    PutTxtCenter(12,__Justified__,'L''Ordinateur a fait l''impacte!',$C);
    ClrKbd;
    ReadKey;
    Inc(PR[1]);
    Init;
   End;
   For J:=1to 2do SetPixel(X[J],Y[J],228+(J shl 3)+CurrText);
   For J:=1to(Speed)do WaitRetrace;
   CurrText:=(CurrText+1)and 7;
   If RX[2]<>0Then Begin
    If GetPixel(X[2]+RX[2],Y[2])<>0Then Begin
     RX[2]:=0;
     If GetPixel(X[2],Y[2]-1)=0Then RY[2]:=-1 Else RY[2]:=1;
    End;
   End
    Else
   If RY[2]<>0Then Begin
    If GetPixel(X[2],Y[2]+RY[2])<>0Then Begin
     RY[2]:=0;
     If GetPixel(X[2]-1,Y[2])=0Then RX[2]:=-1 Else RX[2]:=1;
    End;
   End;
   For J:=1to 2do Begin
    Inc(X[J],RX[J]);Inc(Y[J],RY[J]);
    If RX[J]<>0Then Begin;If X[J]=0Then X[J]:=319 Else If X[J]=319Then X[J]:=0;End;
    If RY[J]<>0Then Begin;If Y[J]=0Then Y[J]:=191 Else If Y[J]=191Then Y[J]:=0;End;
   End;
  Until KeyPress;
  Case(ReadKey)of
   kbUp:If RY[1]=0Then Begin;RY[1]:=-1;RX[1]:=0;End;
   kbDn:If RY[1]=0Then Begin;RY[1]:=1;RX[1]:=0;End;
   kbLeft:If RX[1]=0Then Begin;RY[1]:=0;RX[1]:=-1;End;
   kbRight:If RX[1]=0Then Begin;RY[1]:=0;RX[1]:=1;End;
   kbEsc:Break;
  End;
 Until No;
End;

BEGIN
 Randomize;
 InitSystems(suIsabel);
 Play;
END.