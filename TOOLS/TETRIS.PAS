{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                                                             Û
 ³            þþþþþ þþþþþ þþþþþ þþþþ  þþþ  þþþþ                Û
 ³            þ þ þ þ   þ þ þ þ þ   þ  þ  þ                    Û
 ³      	þ   þþþ     þ   þþþþ   þ   þþþ                 Û
 ³      	þ   þ   þ   þ   þ þ    þ      þ                Û
 ³              þ   þþþþþ   þ   þ  þþ þþþ þþþþ                 Û
 ³                                                             Û
 ³                            pour                             Û
 ³                                                             Û
 ³     L'ensemble Malte Genesis III & IV: Isabel & Chantal     Û
 ³ Tous droits r‚serv‚ par les Chevaliers de Malte 1990 … 1999 Û
 ³                                                             Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Nom du programmeur
 ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

  Sylvain Maltais


 Remarque
 ÍÍÍÍÍÍÍÍ

  þ Les objets compos‚  de 4 bloques  ont dans  ce programme  des noms
    diff‚rent dont voici leur sens:
    ÚÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿
    ³ Barre  ³ BoŒte ³    V     ³   L    ³   L    ³Serpent ³ Serpent ³
    ³        ³       ³          ³ gauche ³ droite ³ romain ³  arabe  ³
    ÆÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍµ
    ³þ       ³       ³þþþ     þ ³ þ   þþ ³  þ  þþ ³  þþ    ³ þþ      ³
    ³þ  þþþþ ³   þþ  ³ þ  þ  þþþ³ þ    þ ³  þ  þ  ³ þþ     ³  þþ     ³
    ³þ       ³   þþ  ³    þþ    ³ þþ   þ ³ þþ  þ  ³        ³         ³
    ³þ       ³       ³    þ     ³        ³        ³        ³         ³
    ÀÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÙ
}

Program Tetris;

Uses Adele,Systex,Systems,Video;

Const SLevel:Byte=0;

Var Score:Long;
    Level,Bar:Wd;

Label _Exit;Const HomeX=15; HomeY=3;
      BlkHeight:Array[0..6,0..3]of Byte=(
       (4,1,4,1), { Barre }
       (2,2,2,2), { BoŒte }
       (3,2,3,2), { V }
       (3,2,3,2), { L gauche }
       (3,2,3,2), { L droite }
       (3,2,3,2), { Serpent romain }
       (3,2,3,2));{ Serpent arabe }
      BlkLength:Array[0..6,0..3]of Byte=( {Largeur des objets:}
       (1,4,1,4), { Barre }
       (2,2,2,2), { BoŒte }
       (2,3,2,3), { V }
       (2,3,2,3), { L gauche }
       (2,3,2,3), { L droite }
       (2,3,2,3), { Serpent romain }
       (2,3,2,3));{ Serpent arabe }
      BlkFormat:Array[0..6,0..3,0..3]of Record X,Y:Byte;End=(
       (((X:0;Y:0),(X:0;Y:1),(X:0;Y:2),(X:0;Y:3)),   { þþþþ }
	((X:0;Y:0),(X:1;Y:0),(X:2;Y:0),(X:3;Y:0)),
	((X:0;Y:0),(X:0;Y:1),(X:0;Y:2),(X:0;Y:3)),
	((X:0;Y:0),(X:1;Y:0),(X:2;Y:0),(X:3;Y:0))),
       (((X:0;Y:0),(X:1;Y:0),(X:0;Y:1),(X:1;Y:1)),   { þþ }
	((X:0;Y:0),(X:1;Y:0),(X:0;Y:1),(X:1;Y:1)),   { þþ }
	((X:0;Y:0),(X:1;Y:0),(X:0;Y:1),(X:1;Y:1)),
	((X:0;Y:0),(X:1;Y:0),(X:0;Y:1),(X:1;Y:1))),
       (((X:1;Y:0),(X:0;Y:1),(X:1;Y:1),(X:1;Y:2)),   { þþþ }
	((X:1;Y:0),(X:0;Y:1),(X:1;Y:1),(X:2;Y:1)),   {  þ  }
	((X:0;Y:0),(X:0;Y:1),(X:1;Y:1),(X:0;Y:2)),
	((X:0;Y:0),(X:1;Y:0),(X:2;Y:0),(X:1;Y:1))),
       (((X:0;Y:0),(X:0;Y:1),(X:0;Y:2),(X:1;Y:2)),
	((X:0;Y:1),(X:1;Y:1),(X:2;Y:1),(X:2;Y:0)),   { þ  }
	((X:0;Y:0),(X:1;Y:0),(X:1;Y:1),(X:1;Y:2)),   { þ  }
	((X:0;Y:0),(X:1;Y:0),(X:2;Y:0),(X:0;Y:1))),  { þþ }
       (((X:1;Y:0),(X:1;Y:1),(X:1;Y:2),(X:0;Y:2)),
	((X:0;Y:1),(X:1;Y:1),(X:2;Y:1),(X:0;Y:0)),   {  þ }
	((X:1;Y:0),(X:0;Y:0),(X:0;Y:1),(X:0;Y:2)),   {  þ }
	((X:0;Y:0),(X:1;Y:0),(X:2;Y:0),(X:2;Y:1))),  { þþ }
       (((X:0;Y:0),(X:0;Y:1),(X:1;Y:1),(X:1;Y:2)),
	((X:1;Y:0),(X:2;Y:0),(X:0;Y:1),(X:1;Y:1)),
	((X:0;Y:0),(X:0;Y:1),(X:1;Y:1),(X:1;Y:2)),
	((X:1;Y:0),(X:2;Y:0),(X:0;Y:1),(X:1;Y:1))),
       (((X:1;Y:0),(X:0;Y:1),(X:1;Y:1),(X:0;Y:2)),
	((X:0;Y:0),(X:1;Y:0),(X:1;Y:1),(X:2;Y:1)),
	((X:1;Y:0),(X:0;Y:1),(X:1;Y:1),(X:0;Y:2)),   {þþ  }
	((X:0;Y:0),(X:1;Y:0),(X:1;Y:1),(X:2;Y:1)))); { þþ }
Var Tbl:Array[0..20,0..9]of Bool; Form,Move,X,Y,Sleep,I,J:Byte; K:Wd; Touch,Ok:Bool;
    SleepDelay:Byte; OldAttr,H,XT:Byte; FBar:Wd;

Procedure PutForm(Clr:Bool);Var Chr:Char;I,Attr:Byte;Begin
 If(Clr)Then Begin Chr:=' ';Attr:=7;End Else Begin Chr:='þ';Attr:=$81+Form;End;
 For I:=0to 3do SetCube(HomeX+X+BlkFormat[Form,Move,I].X,
			HomeY+Y+BlkFormat[Form,Move,I].Y,Chr,Attr);
End;

Procedure Init;Begin
 Form:=Random(6);
 If Form=5Then Inc(Form,Random(2));
 X:=5;Y:=0;Move:=0;Sleep:=0;
 PutForm(No);
End;

Function UpDateData:Bool;Var H,I,J:Byte;Bonus:Byte;Begin
 UpDateData:=Ya;Sleep:=0;PutForm(No);Touch:=No;Ok:=No;
 PutForm(Ya); Inc(Y);
 For I:=0to 3do Touch:=Touch or Tbl[Y+BlkFormat[Form,Move,I].Y,X+BlkFormat[Form,Move,I].X];
 If(Touch)Then Dec(Y);
 PutForm(No);
 If(Touch)Then Begin
  While(Sleep>SleepDelay)do Dec(Sleep);
  Sleep:=0; Ok:=Ya;
  For I:=0to 3do Tbl[Y+BlkFormat[Form,Move,I].Y,X+BlkFormat[Form,Move,I].X]:=Ya;
  If Level>7Then Begin
   Inc(Score,Long(5)*Level);
   If(IsGrf)Then PutTxtXY(4,6,Str(Score),$E)Else PutTxtXY(4,6,Str(Score),$1E+Level*$10);
  End;
  Bonus:=0;
  For J:=0to 19do Begin
   Touch:=Ya;
   For I:=0to 9do Touch:=Touch and Tbl[J,I];
   If(Touch)Then Inc(Bonus);
  End;
  If Bonus>0Then Dec(Bonus);
  For J:=0to 19do Begin
   Touch:=Ya;
   For I:=0to 9do Touch:=Touch and Tbl[J,I];
   If(Touch)Then Begin
    MoveRight(Tbl[0,0],Tbl[1,0],10*J);
    FillClr(Tbl[0,0],10);
    MoveText(HomeX,HomeY,HomeX+9,HomeY+J-1,HomeX,HomeY+1);
    Inc(Score,Long(5)+(Bonus*4)*(Level+1)+10*Level); Inc(Bar);
    If(IsGraf)Then Begin
     PutTxtXY(4,6,Str(Score),$E);
     PutTxtXY(4,9,Str(Bar),$E);
    End
     Else
    Begin
     PutTxtXY(4,6,Str(Score),$1E+Level*$10);
     PutTxtXY(4,9,Str(Bar),$1E+Level*$10);
    End;
    I:=(Bar+FBar)shr 4;
    If(Level<>I)Then Begin
     Level:=I;
     For H:=0to MaxYTxts do For I:=0to MaxXTxts do Begin
      OldAttr:=GetAttr(I,H);
      If OldAttr>$FThen SetAttr(I,H,OldAttr+$10);
     End;
     PutTxtXY(4,3,Str(Level+1),$1E+Level*$10);
    End;
    If SleepDelay>8Then Dec(SleepDelay,2);
   End;
  End;
  If Y<=1Then Begin
   UpDateData:=No;
   Exit;
  End;
  Init;
 End;
End;

BEGIN
 InitSystems(suIsabel);
 SetVideoModeDeluxe(vmTxtC40);
 FillClr(Tbl,SizeOf(Tbl)); FillChr(Tbl[20],SizeOf(Tbl[20]),Byte(Ya));
 Score:=0;Bar:=0;SleepDelay:=25;Level:=SLevel;FBar:=Level shl 4;
 I:=$1E+Level*$10;
 ClrScr($1F);
 ClrWn(HomeX,HomeY,HomeX+9,HomeY+19,Black);
 PutTxtXY(3,2,'Niveau:',I+1);
 PutTxtXY(4,3,Str(Level),I);
 PutTxtXY(3,5,'Pointage:',I+1);
 PutTxtXY(4,6,'0',I);
 PutTxtXY(3,8,'Ligne:',I+1);
 PutTxtXY(4,9,Str(Bar),I);
 Init;
 Repeat
  Repeat
   If(Sleep>SleepDelay)Then If Not(UpDateData)Then Goto _Exit;
   WaitRetrace;
   Inc(Sleep);
  Until KeyPress;
  K:=ReadKey;
  If Chr(K)='2'Then K:=kbDn;
  If Chr(K)='4'Then K:=kbLeft;
  If Chr(K)='6'Then K:=kbRight;
  Case(K)of
   kbLeft:If X>0Then Begin
    Touch:=No;
    For I:=0to 3do Touch:=Touch or Tbl[Y+BlkFormat[Form,Move,I].Y,X+BlkFormat[Form,Move,I].X-1];
    If Not(Touch)Then Begin PutForm(Ya);Dec(X);PutForm(No);End;
   End;
   kbRight:If X+BlkLength[Form,Move]-1<9Then Begin
    Touch:=No;
    For I:=0to 3do Touch:=Touch or Tbl[Y+BlkFormat[Form,Move,I].Y,X+BlkFormat[Form,Move,I].X+1];
    If Not(Touch)Then Begin PutForm(Ya);Inc(X);PutForm(No);End;
   End;
   kbDn:While(Ya)do Begin
    If Not(UpDateData)Then Goto _Exit;
    If(Ok)Then Break;
   End;
  End;
  If(K=kbKeyPad5)or(Char(K)in[' ','5'])Then Begin
   Touch:=No;
   For I:=0to 3do Begin
    XT:=X+BlkFormat[Form,(Move+1)and 3,I].X; Touch:=Touch or(XT>9);
    Touch:=Touch or Tbl[Y+BlkFormat[Form,(Move+1)and 3,I].Y,XT];
   End;
   If Not(Touch)Then Begin PutForm(Ya);Move:=(Move+1)and 3;PutForm(No);End
    Else
   Begin
    Touch:=No;
    For I:=0to 3do Begin
     XT:=X; If XT>0Then Dec(XT);
     Inc(XT,BlkFormat[Form,(Move+1)and 3,I].X); Touch:=Touch or(XT>9);
     Touch:=Touch or Tbl[Y+BlkFormat[Form,(Move+1)and 3,I].Y,XT];
    End;
    If Not(Touch)Then Begin
     PutForm(Ya);
     Dec(X); Move:=(Move+1)and 3;
     PutForm(No);
    End;
   End;
  End;
 Until K=kbEsc;
_Exit:
 ClrKbd;
END.

