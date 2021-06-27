Program PegLeap;

Uses Chantal,Systex,Systems,Video;

Label 40,360,410,690;

Procedure Instruction;Var J:Byte;K:Wd;CK:Char Absolute K;Begin
 ClrScrBlack;SetKr(6);
 _PutTxt(MultChr('ш',80));
 For J:=1to 21do Begin;_PutTxtXY(0,J,'ш');_PutTxtXY(79,J,'ш')End;
 _PutTxtXY(0,22,MultChr('ш',80));
 PutTxtXY(33,2,'P E G    L E A P',11);
 PutTxtXY(24,7,'Veux-tu les instructions? <O/N>',15);
 _SetKr(3);
 Repeat
  K:=ReadKey;
  Case(CK)of
   'n','N':Break;
   'o','O':Begin
    _PutTxtXY(20,6,'  Il s''agit d''un jeu fort simple qui res-');
    _PutTxtXY(20,7,'  semble aux dames. Le but du jeu est');
    _PutTxtXY(20,8,'  d''enlever le plus de jetons possible du');
    _PutTxtXY(20,9,'  en sautant par dessus chaque jeton avec');
    _PutTxtXY(20,10,'  un autre. Tu ne peux sauter diagonalle-');
    _PutTxtXY(20,11,'  ment. Le jeton saut┌ sera enlev┌ du jeu.');
    _PutTxtXY(20,13,'  D''abord place le curseur sous le jeton');
    _PutTxtXY(20,14,'  qui saute et p┼se <ENTER>.');
    _PutTxtXY(20,16,'  Ensuite place le curseur dans l''espace');
    _PutTxtXY(20,17,'  libre o≈ sauter et p┼se encore <ENTER>.');
    PutTxtXY(27,24,'P┼se un touche pour continuer',15);
    ReadKey;
    Break;
   End;
  End;
 Until No;
 ClrScrBlack;
End;

Const Data:Array[0..32]of Byte=(13,14,15,
                                22,23,24,
                          29,30,31,32,33,34,35,
                          38,39,40,41,42,43,44,
                          47,48,49,50,51,52,53,
                                58,59,60,
                                67,68,69);
DataPtr:Byte=0;

Var Pegs,Holes,Contents:String;B:Array[0..70]of Long;T,XY:Array[0..9,0..9]of Long;
    XLin,XPos,XSave,YSave,XCoord,YCoord,ZXSave,ZYSave,ZXCoord,ZYCoord:Integer;
    A,_B,F,P,R,C,W,X,Y,Z,_T:Integer;K:Wd;CK:Char Absolute K;

Procedure ExitMsg;Begin
 ClrLn(MaxYTxts,' ',7);
 PutTxtXY(24,MaxYTxts,' P┼se <F10> pour abandonner ce Jeu ',7);
 SetKr(3);SetPos(XPos,XLin);
End;

Procedure Restore;Begin
 DataPtr:=0;
End;

Function XCur:Integer;Begin;XCur:=VidBnkSwitch.XP+1;End;
Function YCur:Integer;Begin;YCur:=VidBnkSwitch.YP+1;End;

Procedure ChoicePeace;Begin
 SimpleCur;
 Repeat
  K:=ReadKey;
  Case(K)of
   kbUp:If YCur>=6Then Begin
    If Not((YCur<12)and(XCur in[0..33,48..255]))Then Begin
     SetPos(VidBnkSwitch.XP,VidBnkSwitch.YP-3);
     SetCurPos(VidBnkSwitch.XP,VidBnkSwitch.YP);
    End;
   End;
   kbLeft:If XCur>=28Then Begin
    If Not((YCur in[0..8,16..255])and(XCur<40))Then Begin
     SetPos(VidBnkSwitch.XP-6,VidBnkSwitch.YP);
     SetCurPos(VidBnkSwitch.XP,VidBnkSwitch.YP);
    End;
   End;
   kbRight:If XCur<=53Then Begin
    If Not((YCur in[0..8,16..255])and(XCur>41))Then Begin
     SetPos(VidBnkSwitch.XP+6,VidBnkSwitch.YP);
     SetCurPos(VidBnkSwitch.XP,VidBnkSwitch.YP);
    End;
   End;
   kbDn:If YCur<=20Then Begin
    If Not((YCur>12)and(XCur in[0..33,48..255]))Then Begin
     SetPos(VidBnkSwitch.XP,VidBnkSwitch.YP+3);
     SetCurPos(VidBnkSwitch.XP,VidBnkSwitch.YP);
    End;
   End;
   kbEnter,kbEsc,kbF10:Break;
  End;
  If CK=' 'Then Begin;K:=kbEnter;Break;End;
 Until No;
 CloseCur;
 XSave:=XCur;XCoord:=(XSave-10)div 6;
 YSave:=YCur;YCoord:=(YSave div 3)+1;
End;

Function IsOK:Bool;Label 1140,1160;Begin
 IsOk:=No;C:=1;
 For X:=1 to 9do For Y:=1to 9do Begin
  If(C<>Z)Then Goto 1160;
  If(C+2=P)Then Begin
   If T[X,Y+1]=0Then Exit;
   T[X,Y+2]:=5;T[X,Y+1]:=0;B[C+1]:=-3;
   Goto 1140
  End;
  If(C+18=P)Then Begin
   If T[X+1,Y]=0Then Exit;
   T[X+2,Y]:=5;T[X+1,Y]:=0;B[C+9]:=-3;
   Goto 1140
  End;
  If(C-2=P)Then Begin
   If T[X,Y-1]=0Then Exit;
   T[X,Y-2]:=5;T[X,Y-1]:=0;B[C-1]:=-3;
   Goto 1140;
  End;
  If(C-18=P)Then Begin
   If T[X-1,Y]=0Then Exit;
   T[X-2,Y]:=5;T[X-1,Y]:=0;B[C-9]:=-3;B[Z]:=-3;B[P]:=-7;
1140:B[Z]:=-3;B[P]:=-7;T[X,Y]:=0;IsOk:=Ya;Exit;
  End;
1160:Inc(C);
 End;
 IsOk:=Ya;
End;

Procedure UpDate;Var XOffset,YOffset:Integer;Begin
 CONTENTS:=HOLES;
 If T[ZYCOORD,ZXCOORD]=5Then Contents:=Pegs;
 _PutTxtXY(ZXSave-1,ZYSave-1,Contents);Contents:=Holes;
 If T[YCoord,XCoord]=5Then Contents:=Pegs;
 _PutTxtXY(XSAVE-1,YSAVE-1,Contents);
 YOFFSET:=ZYCOORD-YCOORD;XOFFSET:=ZXCOORD-XCOORD;
 If YOFFSET>0Then YOFFSET:=1;
 If XOFFSET>0Then XOFFSET:=1;
 If YOFFSET<0Then YOFFSET:=-1;
 If XOFFSET<0Then XOFFSET:=-1;
 CONTENTS:=HOLES;
 _PutTxtXY(XSAVE+(XOFFSET*6)-1,YSAVE+(YOFFSET*3)-1,Contents);
End;

Procedure _Halt;Begin
 XLIN:=VidBnkSwitch.YP;XPOS:=VidBnkSwitch.XP;
 ClrLn(24,' ',7);
 _PutTxtXY(21,24,'Veux-tu abandonner ce Jeu? <O/N>');
 Repeat
  K:=ReadKey;
  If CK in['O','o']Then Halt;
 Until CK in['n','N'];
 ExitMsg;
End;

BEGIN
 InitSystems(suIsabel);
 SetVideoMode(vmTxtDef);
 Instruction;
 PEGS:='o';HOLES:=' ';
40:ClrScrBlack;XLIN:=0;XPOS:=0;ExitMsg;
 FillClr(R,SizeOf(R));FillClr(C,SizeOf(C));FillClr(XY,SizeOf(XY));
 For R:=1to 9do For C:=1to 9do Begin
  If(((R-4)*(R-5)*(R-6)=0)or((C-4)*(C-5)*(C-6)=0))and Not((R-1)*(C-1)*(R-9)*(C-9)=0)Then Begin
    T[R,C]:=5;XY[R,C]:=Data[DataPtr];Inc(DataPtr)
  End
   Else
  T[R,C]:=-5;
 End;
 T[5,5]:=0;
 _Dn;
 _PutTxtLn(Spc(32)+'зддд© зддд© зддд©');
 _PutTxtLn(Spc(32)+'Ё o Ё Ё o Ё Ё o Ё');
 _PutTxtLn(Spc(32)+'юддды юддды юддды');
 _PutTxtLn(Spc(32)+'зддд© зддд© зддд©');
 _PutTxtLn(Spc(32)+'Ё o Ё Ё o Ё Ё o Ё');
 _PutTxtLn(Spc(32)+'юддды юддды юддды');
 _PutTxtLn(Spc(20)+'зддд© зддд© зддд© зддд© зддд© зддд© зддд©');
 _PutTxtLn(Spc(20)+'Ё o Ё Ё o Ё Ё o Ё Ё o Ё Ё o Ё Ё o Ё Ё o Ё');
 _PutTxtLn(Spc(20)+'юддды юддды юддды юддды юддды юддды юддды');
 _PutTxtLn(Spc(20)+'зддд© зддд© зддд© зддд© зддд© зддд© зддд©');
 _PutTxtLn(Spc(20)+'Ё o Ё Ё o Ё Ё o Ё Ё   Ё Ё o Ё Ё o Ё Ё o Ё');
 _PutTxtLn(Spc(20)+'юддды юддды юддды юддды юддды юддды юддды');
 _PutTxtLn(Spc(20)+'зддд© зддд© зддд© зддд© зддд© зддд© зддд©');
 _PutTxtLn(Spc(20)+'Ё o Ё Ё o Ё Ё o Ё Ё o Ё Ё o Ё Ё o Ё Ё o Ё');
 _PutTxtLn(Spc(20)+'юддды юддды юддды юддды юддды юддды юддды');
 _PutTxtLn(Spc(32)+'зддд© зддд© зддд©');
 _PutTxtLn(Spc(32)+'Ё o Ё Ё o Ё Ё o Ё');
 _PutTxtLn(Spc(32)+'юддды юддды юддды');
 _PutTxtLn(Spc(32)+'зддд© зддд© зддд©');
 _PutTxtLn(Spc(32)+'Ё o Ё Ё o Ё Ё o Ё');
 _PutTxtLn(Spc(32)+'юддды юддды юддды');
 Restore;
 For W:=1to 33do Begin;B[Data[DataPtr]]:=-7;Inc(DataPtr)End;
 B[41]:=-3;
360:YSave:=12;XSave:=41;
 _PutTxtXY(0,MaxYTxts-1,Spc(24)+'Place le curseur et p┼se <ENTER>.');
 _PutTxtXY(31,MaxYTxts-2,'  Quelle piece?   ');
 SetCurPos(VidBnkSwitch.XP,VidBnkSwitch.YP);
 SimpleCur;
 SetPos(XSave-1,YSave-1);SetCurPos(XSave-1,YSave-1);
410:ChoicePeace;
 If(K=kbEsc)or(K=kbF10)Then _Halt;
 ZYSAVE:=YSAVE;ZXSAVE:=XSAVE;ZYCOORD:=YCOORD;ZXCOORD:=XCOORD;Z:=XY[YCOORD,XCOORD];
 If B[Z]<>-7Then Begin
690:CONTENTS:=HOLES;
  If T[ZYCOORD,ZXCOORD]=5THEN CONTENTS:=PEGS;
  _PutTxtXY(ZXSave-1,ZYSave-1,CONTENTS);
  CONTENTS:=HOLES;
  If T[YCOORD,XCOORD]=5THEN CONTENTS:=PEGS;
  _PutTxtXY(XSave-1,YSave-1,CONTENTS);
  _PutTxtXY(0,19,'Invalide...recommence.');
  WaitRetrace;WaitRetrace;WaitRetrace;WaitRetrace;WaitRetrace;
  WaitRetrace;WaitRetrace;WaitRetrace;WaitRetrace;WaitRetrace;
  _PutTxtXY(0,19,Spc(27));SetPos(XSave-1,YSave-1);SetCurPos(XSave-1,YSave-1);
  Goto 360;
 End;
 _PutTxtXY(32,22,'      O≈?       ');
 PutTxtXY(XSave-1,YSave-1,PEGS,(23 and 15)+$80);
 SetPos(XSave-1,YSave-1);SetCurPos(XSave-1,YSave-1);
 ChoicePeace;
 If(K=kbEsc)or(K=kbF10)Then _Halt;
 P:=XY[YCOORD,XCOORD];
 If(B[P]=0)or(B[P]=-7)Then Goto 690;
 If(Z=P)Then Goto 360;
 If (Z+P)and 1=1Then Goto 690;
 If(ABS(Z-P)-2)*(ABS(Z-P)-18)<>0 THEN Goto 690;
 If Not(IsOK)Then Goto 690;
 UpDate;
 F:=0;
 For R:=2to 8do For C:=2to 8do Begin
  If T[R,C]=5Then Begin
   Inc(F);
   For A:=R-1to R+1do Begin
    _T:=0;For _B:=C-1to C+1do Inc(_T,T[A,_B]);
    If _T<>10Then Continue;
    If T[A,C]<>0Then Goto 360;
   End;
   For X:=C-1to C+1do Begin
    _T:=0;For Y:=R-1to R+1do Inc(_T,T[Y,X]);
    If _T<>10Then Continue;
    If T[R,X]<>0Then Goto 360
   End;
  End;
 End;
 _PutTxtXY(0,21,'Il ne reste que'+BasicStrW(F)+' pi┼ces.');
 _PutTxtXY(0,23,Spc(80));
 Case(F)of
  1:Begin
   _PutTxtXY(0,20,'BRAVO!');
   _PutTxtXY(0,22,'Parfait!');
   If T[5,5]=5Then _PutTxtXY(0,22,'Dans le centre! Tu es un G┌nie!');
  End;
  2:Begin
   _PutTxtXY(0,20,'EXECELLENT!');
   _PutTxtXY(2,20,'Essaie encore.');
  End;
  3,4:Begin
   _PutTxtXY(0,20,'Tr┼s bien!');
   _PutTxtXY(0,22,'N''abandones pas!');
  End;
  5..7:Begin
   _PutTxtXY(0,20,'PAS PIRE');
   _PutTxtXY(0,22,'Essaie encore.');
  End;
 End;
 If Not(F<8)Then Begin
  If F>24Then Begin
   _PutTxtXY(0,20,'Ce n''est pas le but du jeu');
   _PutTxtXY(0,22,'Lis les instructions!');
  End
   Else
  Begin
   _PutTxtXY(0,20,'OUCH!');
   _PutTxtXY(0,21,'Il ne reste que'+BasicStrW(F)+' pi┼ces.');
   _PutTxtXY(0,22,'Ce n''est pas ta journ┌e!');
  End;
 End;
 _PutTxtXY(0,23,'Aimerais-tu jouer encore? <O/N>');
 Repeat
  K:=ReadKey;
  If(CK in['n','N'])or(K=kbEsc)Then Halt;
 Until CK in['o','O'];
 Restore;
 Goto 40;
END.