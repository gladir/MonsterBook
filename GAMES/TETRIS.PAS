{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                                                             Û
 ³            şşşşş şşşşş şşşşş şşşş  şşş  şşşş                Û
 ³            ş ş ş ş   ş ş ş ş ş   ş  ş  ş                    Û
 ³      	ş   şşş     ş   şşşş   ş   şşş                 Û
 ³      	ş   ş   ş   ş   ş ş    ş      ş                Û
 ³              ş   şşşşş   ş   ş  şş şşş şşşş                 Û
 ³                                                             Û
 ³                            pour                             Û
 ³                                                             Û
 ³     L'ensemble Malte Genesis III & IV: Isabel & Chantal     Û
 ³ Tous droits r‚serv‚ par les Chevaliers de Malte 1990 … 1996 Û
 ³                                                             Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ

 Nom des programmeurs:
 ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

  Sylvain Maltais
}

Program Tetris;

{$I ..\DEF.INC}

Uses {$IFDEF Adele}Adele,{$ELSE}{$IFDEF Chantal}Chantal,{$ENDIF}{$ENDIF}
     Dos,Systex,Isatex,Systems,Video,Arcade,Mouse,Dials,Volume;

Const FileNameHighScore='TETRIS.HGH';SLevel:Byte=0;
Type HighScoreFile=Array[0..9]of Record Name:String[31];Score:Long;Level,Bar:Wd;End;
Var HighScore:HighScoreFile; Score:Long; Level,Bar:Wd; ModeVGA:Bool;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure UpDataHighScore                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure demande au joueur de rentrer son pointage car il est dans
 un des 10 premiers de la liste.  Elle les sauvegarde sur disque aprŠs cela
 pour de ne pas perdre votre record!
}

Procedure UpDateHighScore;Var I:Byte;TName,Title:String;Begin
 For I:=0to 9do Begin
  If(Score>=HighScore[I].Score)Then Begin
   If I<9Then MoveRight(HighScore[I],HighScore[I+1],SizeOf(HighScore[0])*(9-I));
   TName:='';
   Case I of
    0: Title:='PremiŠre place des meilleurs pointages';
    1: Title:='DeuxiŠme place des meilleurs pointages';
    2: Title:='TroisiŠme place des meilleurs pointages';
    3: Title:='QuatriŠme place des meilleurs pointages';
    4: Title:='CinquiŠme place des meilleurs pointages';
    5: Title:='SixiŠme place des meilleurs pointages';
    6: Title:='SeptiŠme place des meilleurs pointages';
    7: Title:='HuitiŠme place des meilleurs pointages';
    8: Title:='NeuviŠme place des meilleurs pointages';
    9: Title:='DixiŠme place des meilleurs pointages';
   End;
   Repeat Until
    WinInp(40,Title,'Veuillez S.V.P. entrer votre nom:',
	   CurrKrs.Dialog.Wins,No,TName)=kbEnter;
   HighScore[I].Name:=Left(TName,31); HighScore[I].Score:=Score;
   HighScore[I].Level:=Level; HighScore[I].Bar:=Bar;
   SetFile(FileNameHighScore,0,SizeOf(HighScore),HighScore);
   Break;
  End;
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure PutHighScore                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure affiche les 10 meilleurs pointages ayant ‚t‚ fait dans ce
 jeu vid‚o Tetris.
}

Procedure PutHighScore;Var I:Byte;Begin
 ClrScr(7);
 PutTxtCenter(0,__Justified__,'Tetris',$F);
 PutTxtCenter(1,__Justified__,'Les meilleurs pointages',$E);
 For I:=0to 9do PutTxtCenter((I shl 1)+3,__Left__,
			  StrUSpc(HighScore[I].Name,20)+
			  Str2(HighScore[I].Level+1,3)+
			  Str2(HighScore[I].Bar,6)+
			  Str2(HighScore[I].Score,9),$7+Byte(I=0)*8);
 ReadKey;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure Play                           Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure est le coeur du jeu lui-mˆme. C'est lui bougeant les
 objets et les fesant descendre.


 Remarques
 ÍÍÍÍÍÍÍÍÍ

  ş Cette  proc‚dure  r‚clame  le  fichier  dessin  ®TETRIS.GFX¯  pour
    afficher une toile de fond style russie … l'arriŠre du jeu.

  ş Les objets compos‚  de 4 bloques  ont dans  ce programme  des noms
    diff‚rent dont voici leur sens:
    ÚÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿
    ³ Barre  ³ BoŒte ³    V     ³   L    ³   L    ³Serpent ³ Serpent ³
    ³        ³       ³          ³ gauche ³ droite ³ romain ³  arabe  ³
    ÆÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍµ
    ³ş       ³       ³şşş     ş ³ ş   şş ³  ş  şş ³  şş    ³ şş      ³
    ³ş  şşşş ³   şş  ³ ş  ş  şşş³ ş    ş ³  ş  ş  ³ şş     ³  şş     ³
    ³ş       ³   şş  ³    şş    ³ şş   ş ³ şş  ş  ³        ³         ³
    ³ş       ³       ³    ş     ³        ³        ³        ³         ³
    ÀÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÙ
}

Procedure Play;Label _Exit;Const HomeX=15; HomeY=3;
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
       (((X:0;Y:0),(X:0;Y:1),(X:0;Y:2),(X:0;Y:3)),   { şşşş }
	((X:0;Y:0),(X:1;Y:0),(X:2;Y:0),(X:3;Y:0)),
	((X:0;Y:0),(X:0;Y:1),(X:0;Y:2),(X:0;Y:3)),
	((X:0;Y:0),(X:1;Y:0),(X:2;Y:0),(X:3;Y:0))),
       (((X:0;Y:0),(X:1;Y:0),(X:0;Y:1),(X:1;Y:1)),   { şş }
	((X:0;Y:0),(X:1;Y:0),(X:0;Y:1),(X:1;Y:1)),   { şş }
	((X:0;Y:0),(X:1;Y:0),(X:0;Y:1),(X:1;Y:1)),
	((X:0;Y:0),(X:1;Y:0),(X:0;Y:1),(X:1;Y:1))),
       (((X:1;Y:0),(X:0;Y:1),(X:1;Y:1),(X:1;Y:2)),   { şşş }
	((X:1;Y:0),(X:0;Y:1),(X:1;Y:1),(X:2;Y:1)),   {  ş  }
	((X:0;Y:0),(X:0;Y:1),(X:1;Y:1),(X:0;Y:2)),
	((X:0;Y:0),(X:1;Y:0),(X:2;Y:0),(X:1;Y:1))),
       (((X:0;Y:0),(X:0;Y:1),(X:0;Y:2),(X:1;Y:2)),
	((X:0;Y:1),(X:1;Y:1),(X:2;Y:1),(X:2;Y:0)),   { ş  }
	((X:0;Y:0),(X:1;Y:0),(X:1;Y:1),(X:1;Y:2)),   { ş  }
	((X:0;Y:0),(X:1;Y:0),(X:2;Y:0),(X:0;Y:1))),  { şş }
       (((X:1;Y:0),(X:1;Y:1),(X:1;Y:2),(X:0;Y:2)),
	((X:0;Y:1),(X:1;Y:1),(X:2;Y:1),(X:0;Y:0)),   {  ş }
	((X:1;Y:0),(X:0;Y:0),(X:0;Y:1),(X:0;Y:2)),   {  ş }
	((X:0;Y:0),(X:1;Y:0),(X:2;Y:0),(X:2;Y:1))),  { şş }
       (((X:0;Y:0),(X:0;Y:1),(X:1;Y:1),(X:1;Y:2)),
	((X:1;Y:0),(X:2;Y:0),(X:0;Y:1),(X:1;Y:1)),
	((X:0;Y:0),(X:0;Y:1),(X:1;Y:1),(X:1;Y:2)),
	((X:1;Y:0),(X:2;Y:0),(X:0;Y:1),(X:1;Y:1))),
       (((X:1;Y:0),(X:0;Y:1),(X:1;Y:1),(X:0;Y:2)),
	((X:0;Y:0),(X:1;Y:0),(X:1;Y:1),(X:2;Y:1)),
	((X:1;Y:0),(X:0;Y:1),(X:1;Y:1),(X:0;Y:2)),   {şş  }
	((X:0;Y:0),(X:1;Y:0),(X:1;Y:1),(X:2;Y:1)))); { şş }
Var Tbl:Array[0..20,0..9]of Bool; Form,Move,X,Y,Sleep,I,J:Byte; K:Wd; Touch,Ok:Bool;
    SleepDelay:Byte; OldAttr,H,XT:Byte; W:Wins; Kr:MtxColors; FBar:Wd;xR:RGB;
    OldWinType:WinModelType;

 Procedure UpDateKr;Begin
  xR.R:=47+16*(Level+1);xR.G:=0;xR.B:=0;
  SetPalRGB(xR,251,1);
 End;

 Procedure PutForm(Clr:Bool);Var Chr:Char;I,Attr:Byte;Begin
  If(Clr)Then Begin Chr:=' ';Attr:=7;End Else Begin Chr:='ş';Attr:=$81+Form;End;
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
      If(IsGraf)Then
      Begin
       UpDateKr;
       For H:=0to 19do For I:=0to 9do Begin
	OldAttr:=GetAttr(HomeX+I,HomeY+H);
	If OldAttr>$FThen SetAttr(HomeX+I,HomeY+H,OldAttr+$10);
       End;
       PutTxtXY(4,3,Str(Level+1),$E);
      End
       Else
      Begin
       For H:=0to MaxYTxts do For I:=0to MaxXTxts do Begin
	OldAttr:=GetAttr(I,H);
	If OldAttr>$FThen SetAttr(I,H,OldAttr+$10);
       End;
       PutTxtXY(4,3,Str(Level+1),$1E+Level*$10);
      End;
      If SleepDelay>8Then Dec(SleepDelay,2);
     End;
    End;
   End;
   If Y<=1Then Begin
    UpDateData:=No;
    Exit;
   End;
   Init;
  End;
 End;

Begin
 SetVideoModeDeluxe(vmGrf320x200c256);
 FillClr(Tbl,SizeOf(Tbl)); FillChr(Tbl[20],SizeOf(Tbl[20]),Byte(Ya));
 Score:=0;Bar:=0;SleepDelay:=25;Level:=SLevel;FBar:=Level shl 4;
 For I:=0to SLevel do If SleepDelay>8Then Dec(SleepDelay,2);
 If(IsGraf)Then Begin
  ExecGetFile('RESOURCE\TETRIS\TETRIS.GFX',0,64000,Mem[GetVideoSeg:0]);
  UpDateKr;
 End
  Else
 ClrScr($10*(Level+1));
 PutOTxtU(1,__Justified__,'Tetris',$C);
 WEInit(W,HomeX-1,HomeY-1,HomeX+10,HomeY+20);
 FillClr(Kr,SizeOf(Kr));
 OldWinType:=WinType;WinType:=Robotic;
 WEPutWn(W,'',Kr);
 WinType:=OldWinType;
 If(IsGrf)Then Begin
  ClrWn(2,1,12,10,$F);PutRect(2*8,1*8,12*8+7,10*8+7,$F);
  I:=$E;
 End
  Else
 I:=$1E+Level*$10;
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
 SetShade(No);
 WEInit(W,10,10,28,14);
 WinType:=Normal;
 Kr.Border:=$17;
 WEPutWn(W,'',Kr);
 WinType:=Robotic;
 WELn(W);
 WEPutOTxt(W,'Partie Terminer');
 ClrKbd;
 ReadKey;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure SetLevel                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de fixer le niveau de difficult‚ du jeu vid‚o
 Tetris en fonction d'une ‚chelle de 15.
}

Procedure SetLevel;Var L:LstMnu;K:Wd;Begin
 LMInitCenter(L,30,10,'Niveau de difficult‚',CurrKrs.Dialog.Wins);
 For K:=1to 15do RBAddStrByte(L.X,'Niveau '+Str(K),K);
 K:=LMRun(L);
 LMDone(L);
 If K>0Then SLevel:=K-1;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Proc‚dure Historik                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure affiche un cours historique du jeu Tetris avec une police
 de caractŠres d'un style antiquit‚.
}

Procedure Historik;Begin
 ClrScrBlack;
 LoadMtx('ANTIQUE.FNT');
 PutTxtCenter(0,__Justified__,'Historique',$C);
 PutTxtXYT(0,2,'Tetris a ‚t‚ invent‚ par un ‚tudiant du',$C);
 PutTxtXYT(0,3,'centre de recherche sovi‚tique. Il se',$C);
 PutTxtXYT(0,4,'nommait Alexi Paszinov, il ‚tait ƒg‚ de',$C);
 PutTxtXYT(0,5,'30 ans et il faisait le travail courant',$C);
 PutTxtXYT(0,6,'au Centre de logiciel pour ordinateur',$C);
 PutTxtXYT(0,7,'dans l''Acad‚mie Scientifique de Moscou.',$C);
 PutTxtXYT(0,8,'Le programmeur original ‚tait ƒg‚ de 18',$C);
 PutTxtXYT(0,9,'ans, il se nommait Vagin Merasinov, il',$C);
 PutTxtXYT(0,10,'‚tait ‚tudiant en Informatique …',$C);
 PutTxtXYT(0,11,'l''Universit‚ de Moscou.',$C);
 LoadMtx('STD');
 ReadKey;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                              Fonction Mnu                              Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de s‚lectionner dans un menu de brique, lequel des
 actions l'utilisateur veut-il entreprendre: Jouer, changer de niveau, voir
 l'historique,  les meilleurs pointages,...  Il s'adapte en th‚orie au mode
 d'‚cran de texte si rien ne fait l'affaire par ‡a.
}

Function Mnu:Byte;Label 0;Var Icn:BlockButton;I,J,P:Byte;K,XM,YM,BM:Wd;L:LstMnu;Const Isc:Byte=0;scDir:Bool=Ya;
 Procedure SpecialCur;Var I:Byte;Begin
  For I:=0to 7do PutRect(8+I,(3+P)*16+I,8+15-I,(3+P)*16+15-I,47-((I+Isc)and$F));
  If(scDir)Then Inc(Isc,2)Else Dec(Isc,2);
  If Isc=0Then scDir:=Ya;
  If Isc=15Then scDir:=No;
 End;
 Procedure ClrCur;Begin PutFillBox(8,(3+P)*16,8+15,(3+P)*16+15,0);End;
Begin
 If Not(IsGrf)Then Begin
  If(ModeVGA)Then SetVideoModeDeluxe(vmGrf320x200c256)
   Else
  Begin
   LMInitCenter(L,30,10,'Menu',CurrKrs.Dialog.Wins);
   RBAddStrByte(L.X,'Historique',1);
   RBAddStrByte(L.X,'D‚buter une partie',2);
   RBAddStrByte(L.X,'Changer le niveau de difficult‚',3);
   RBAddStrByte(L.X,'Voir les meilleurs pointages',4);
   RBAddStrByte(L.X,'Quitter',5);
   K:=LMRun(L);
   If K=0Then Mnu:=4 Else Mnu:=K-1;
   LMDone(L);
   Exit;
  End;
 End
  Else
 ClrScrBlack;
 __InitMouse;
 SetFontName('COMPUTER.POL');
 _SetKr(48);
 _Move2(110,0);
 PutFont('Menu');
 FillChr(Icn,SizeOf(Icn),9);BMIcon(Icn);
 For J:=0to 3do For I:=1to 9do PutSmlImg(I*32,40+J*32,I*32+31,40+J*32+31,Icn.Data);
 LoadMtx('FUTURE.FNT');
 OutSTxtXY(4*8+4,3*16,'Historique',$C);
 OutSTxtXY(4*8+4,4*16,'D‚buter une partie',$C);
 OutSTxtXY(4*8+4,5*16,'Changer le niveau de difficult‚',$C);
 OutSTxtXY(4*8+4,6*16,'Voir les meilleurs pointages',$C);
 OutSTxtXY(4*8+4,7*16,'Quitter',$C);
 SetMouseMoveAreaY(0,4*8);
 P:=0;
 Repeat
  While Not(KeyPress)do Begin
   For I:=0to 5do WaitRetrace;
   SpecialCur;
   GetMouseSwitch(XM,YM,BM);
   If(YM shr 3<>P)Then Begin
    ClrCur;
    P:=YM shr 3;
    If P>4Then P:=4;
    SpecialCur;
   End;
   If BM>0Then Goto 0;
  End;
  K:=ReadKey;
  If Chr(K)=' 'Then K:=kbEnter;
  Case(K)of
   kbUp: Begin ClrCur;P:=MinByte(P,4);SetMousePos(0,P shl 3);SpecialCur;End;
   kbDn: Begin ClrCur;P:=MaxByte(P,4);SetMousePos(0,P shl 3);SpecialCur;End;
kbEnter:0:Begin Mnu:=P;Break;End;
  kbEsc: Begin Mnu:=4;Break;End;
  End;
 Until No;
 ClrCur;
 LoadMtx('STD');
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                             Zone d'Intro                            Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette partie est r‚serv‚ … l'animation de pr‚sentation, elle n'est pas
 n‚cessaire pour le bon fonctionnement du jeu vid‚o Tetris.
}

Const NmLn=180;NumberBar=3;ScrollYPos=40;Radius=40;NumSlices=90;
 AngleInc=2*Pi/NumSlices;Spacing=4;NumXCoords=300div Spacing;CharColor=247;
 MsgDisp='                  * * * * * Les Chevaliers de Malte pr‚sentent '+
	 '....... ®Tetris¯ * * * * *              ';
 NumDispChars=Length(MsgDisp);CharLength=8;NumChars=256;NumCycles=200;
 Music:Bool=Ya;LedStandard:Bool=Ya;CharBlink:Bool=No;
 FlagsTremble:Bool=No;ZipScreen:Bool=No;SuperFast:Bool=No;
 _Volume:Byte=64;DispStr:String=MsgDisp;
 Colors:Array[1..15*3]of Byte=
 (Trunc(7 /1.2)shl 2,0,0,Trunc(15/1.2)shl 2,0,0,Trunc(23/1.2)shl 2,0,0,
  Trunc(31/1.2)shl 2,0,0,Trunc(39/1.2)shl 2,0,0,Trunc(47/1.2)shl 2,0,0,
  Trunc(55/1.2)shl 2,0,0,Trunc(63/1.2)shl 2,0,0,Trunc(55/1.2)shl 2,0,0,
  Trunc(47/1.2)shl 2,0,0,Trunc(39/1.2)shl 2,0,0,Trunc(31/1.2)shl 2,0,0,
  Trunc(23/1.2)shl 2,0,0,Trunc(15/1.2)shl 2,0,0,Trunc( 7/1.2)shl 2,0,0);
Var ScreenPath:Array[1..8*80]of Wd;ScreenPathLine:Array[1..8*80]of Byte;
 CurrentLine,CurrentArrayLoc:Wd;DispChars:Array[1..NumDispChars*64]of Byte;
 Locs:Array[1..NumCycles]of Byte;BarLocs:Array[1..NumberBar]of Byte;
 J:Byte;CurrAngle:Real;K,PosMsg:Wd;SD,SN:String[15];

Procedure MatrixEpee;Assembler;ASM
 DB 00111100B;
 DB 00111100B;
 DB 11111111B;
 DB 11111111B;
 DB 11111111B;
 DB 11111111B;
 DB 00111100B;
 DB 00111100B;
END;

Procedure BuildPath;Var I,J:Byte; AP,T:Wd; CA,OldCA:Real;Begin
 CA:=Pi; AP:=1;
 For I:=0to NumXCoords-1do Begin
  OldCA:=CA;
  For J:=1to 8do Begin
   T:=ScrollYPos+Round(Radius*Sin(CA));
   ScreenPath[AP]:=T*320+I*Spacing+1; ScreenPathLine[AP]:=T;
   CA:=CA+AngleInc; Inc(AP);
  End;
  CA:=OldCA+AngleInc;
 End;
End;

Procedure BuildCharArray;Var H,I,J:Byte;AP:Wd;TxtMtx:^TByte;Begin
 AP:=1;TxtMtx:=GetVideoTxtMtxPtr;
 For H:=1to NumDispChars do For I:=0to 7do For J:=0to 7do Begin
  If(TxtMtx^[Byte(DispStr[H])*8+J]shl I)and$80=0Then DispChars[AP]:=0
  Else If DispStr[H]='*'Then DispChars[AP]:=CharColor-8+J Else DispChars[AP]:=CharColor+J;
  Inc(AP);
 End;
End;

Procedure MoveWordStepHoriRight2Left(Y,NL:Byte);Assembler;ASM
 CLD
 PUSH DS
  MOV AL,NL
  XOR AH,AH
  SHL AX,1
  ADD AL,Y
  ADC AH,0
  MOV BX,320
  MUL BX
  MOV DI,AX
  MOV SI,AX
  ADD SI,4
  MOV CL,NL
  XOR CH,CH
  SHL CX,1
  INC CX
  {$IFOPT G+}
   PUSH $A000
   POP  ES
  {$ELSE}
   MOV AX,$A000
   MOV ES,AX
  {$ENDIF}
  PUSH ES
  POP DS
@@1:
  PUSH CX
   MOV CX,(316 shr 1)
   REP MOVSW
  POP CX
  SUB DI,636
  SUB SI,636
  LOOP @@1
 POP DS
END;

Procedure MoveTextMsgStep2Res200(L:Byte;Len:Word;Var Buffer;Var Pos:Wd);
Var I,T:Byte;TBuffer:TByte Absolute Buffer;
Begin
 MoveWordStepHoriRight2Left(L,8);
 If Pos>Len-1Then Pos:=1;
 For I:=0to 7do Begin
  T:=TBuffer[(Pos*8)+I];
  If T=0Then ClrLnHor(316,L+(I shl 1),4,L+(I shl 1))Else ClrLnHor(316,L+(I shl 1),4,T);
 End;
 Inc(Pos);
 If Pos>Len-1Then Pos:=0;
End;

Procedure PutMessage;Begin
 MoveTextMsgStep2Res200(160,Length(DispStr)*8,DispChars,PosMsg);
End;

Procedure Cycle;Assembler;ASM
 CALL GetVideoSeg
 MOV ES,AX
 MOV BX,CurrentLine
 MOV SI,BX
 {$IFOPT G+}
  SHL BX,3
 {$ELSE}
  MOV CL,3
  SHL BX,CL
 {$ENDIF}
 MOV DX,BX
 MOV AX,NumXCoords
@Loop1:
 MOV CX,8
@Loop2:
 PUSH AX
  MOV AL,Byte Ptr DispChars[BX]
  PUSH BX
   SUB BX,DX
   CMP AL,0
   JNE @@2
   MOV AL,Byte Ptr ScreenPathLine[BX]
@@2:
   SHL BX,1
   MOV DI,Word Ptr ScreenPath[BX]
   STOSB
  POP BX
 POP AX
 INC BX
 CMP BX,(NumDispChars-1)*8*8
 JNG @@3
 XOR BX,BX
 XOR DX,DX
@@3:
 LOOP @Loop2
 DEC AX
 JNZ @Loop1
 INC SI
 CMP SI,(NumDispChars-1)*8
 JNG @@4
 XOR SI,SI
@@4:
 MOV CurrentLine,SI
END;

Procedure CalcLocs;Var I:Byte;Begin
 For I:=1to NumCycles do Locs[I]:=Round(80*Sin((2*Pi/NumCycles)*I))+80+1;
End;

Procedure DrawBar(Var Bar:Byte);Var I,PrevBar:Byte;Begin
 If BarLocs[Bar]=1Then PrevBar:=Locs[NumCycles]Else PrevBar:=Locs[BarLocs[Bar]-1];
 SetPalBlk(PrevBar,15);
 SetPalRGB(Colors,Locs[BarLocs[Bar]],15);
 Inc(BarLocs[Bar]);
End;

Procedure PutMusicBar;
Const L=130;X1=90;Y1=L-(7 shl 2)-4;X2=319-78;Y2=L+4;Var I,J,K:Byte; X1G,Y1G:Wd;
Begin
 PutRect(X1-2,Y1-2,X2+3,Y2+1,CharColor-1);
 PutFillBox(X1,Y1,X2,Y2,CharColor-3);
 SetPalBlk(NmLn,32);
 For I:=0to 7do For J:=0to 3do For K:=0to 1do Begin
  X1G:=X1+3+K*14+J*40; Y1G:=L-(I shl 2);
  PutFillBox(X1G,Y1G-1,X1G+11,Y1G,NmLn+I+J*8);
 End;
End;

Procedure SetAddrHome;Begin
 SetVerticalScale(0);
End;

Procedure SetMusicBar;
Const RealColor:Array[0..8*3-1]of Byte=(0,63,0,0,63,0,0,63,0,0,63,0,63,63,0,63,0,0,63,0,0,63,0,0);
FlagsUp:Bool=No;Var I,J,K,T,T2:Byte;T3:Wd;Begin
 If(LedStandard)Then Begin
  For J:=0to 3do Begin
   T2:=Byte(BopBar(J+1))shr 3; K:=T2 and 7;
   If(FlagsTremble)Then Begin
    If(T2>K)Then Begin
     T3:=(1+Byte(FlagsUp)*4);
     SetVerticalScale(T3);
     FlagsUp:=Ya;
    End
     else
    If(FlagsUp)Then Begin
     FlagsUp:=No;
     SetAddrHome;
    End;
   End;
   If K>0Then Begin
    T:=K*3+2;
    Port[$3C8]:=NmLn+J*8;
    For I:=0to T Do Port[$3C9]:=RealColor[I];
    If Not(K+1>7)Then Begin
     Inc(T);
     For I:=T to 8*3do Port[$3C9]:=0;
    End;
   End
    Else
   ASM
    MOV AL,J
    {$IFOPT G+}
     SHL AL,3
    {$ELSE}
     SHL AL,1
     SHL AL,1
     SHL AL,1
    {$ENDIF}
    ADD AL,NmLn
    MOV DX,$3C8
    OUT DX,AL
    INC DX
    MOV AL,0
    MOV CX,24
@@1:
    OUT DX,AL
    LOOPNZ @@1
   END;
  End;
 End
  Else
 Begin
  For J:=0to 3do Begin
   T2:=Byte(BopBar(J+1))shr 3;
   K:=T2 and 7;
   If(FlagsTremble)Then Begin
    If(T2>K)Then Begin
     FlagsUp:=Ya;
     T3:=1+Byte(FlagsUp)*4;
     SetVerticalScale(T3);
    End
     else
    If(FlagsUp)Then Begin
     FlagsUp:=No;
     SetAddrHome;
    End;
   End;
   If K>0Then Begin
    For I:=0to K-1do SetPaletteRGB(NmLn+I+J*8,0,0,$FF);
    SetPaletteRGB(NmLn+K+J*8,$FF,0,0);
    If Not(K+1>7)Then SetPalBlk(NmLn+K+1+J*8,7-K);
   End
    Else
   ASM
    MOV AL,J
    {$IFOPT G+}
     SHL AL,3
    {$ELSE}
     SHL AL,1
     SHL AL,1
     SHL AL,1
    {$ENDIF}
    ADD AL,NmLn
    MOV DX,$3C8
    OUT DX,AL
    INC DX
    MOV AL,0
    MOV CX,24
@@2:OUT DX,AL
    LOOPNZ @@2
   END;
  End;
 End;
End;

Procedure SetPaletteWhiteToBlue(S,N:Byte);Var J,T:Byte;Begin
 Port[$3C8]:=S;
 For J:=0to N-1do Begin
  T:=(7-J)shl 3;
  Port[$3C9]:=T;
  Port[$3C9]:=T;
  Port[$3C9]:=T+(J shl 3);
 End;
End;

Procedure SetPaletteRedToWhite(S,N:Byte);Var J,T:Byte;Begin
 Port[$3C8]:=S;
 For J:=0to N-1do Begin
  T:=J shl 3;
  Port[$3C9]:=T+((7-J)shl 3);
  Port[$3C9]:=T;
  Port[$3C9]:=T;
 End;
End;

Procedure SetPaletteBlack2Green(S,N:Byte);Var J,T:Byte;Palette:Array[Byte]of RGB;Begin
 FillClr(Palette,SizeOf(Palette));
 For J:=0to N-1do Begin T:=(7-J)*6; Inc(T,16); Palette[J].G:=T shl 2; End;
 SetPalRGB(Palette,S,N);
End;

Procedure SetCharBlink;Const Blink:Byte=0;Begin
 Blink:=(Blink+1)and 15;
 If Blink=0Then SetPaletteWhiteToBlue(CharColor,8);
 If Blink=8Then SetPaletteRedToWhite(CharColor,8);
End;

Procedure PutString8x8(XPos,YPos:Word;Color:Byte;Var Str:String);
Type PaletteChar=Array[Byte,0..7]of Byte;PPaletteChar=^PaletteChar;
Var H,J:Byte;
Begin
 For H:=1to Length(Str)do For J:=0to 7do CopT8Bin(XPos+(H-1)*8,YPos+J,PPaletteChar(GetVideoTxtMtxPtr)^[Byte(Str[H]),J],Color);
End;

Procedure PutAbout;
Type PosRec=Record X1:Wd;Y1:Byte;X2:Wd;Y2:Byte;End;
Const PPlane:Array[0..1]of PosRec=((X1:48;Y1:32;X2:64;Y2:48),(X1:200;Y1:8;X2:220;Y2:24));
      Pos:Byte=0; Tour:Byte=0; Plane:Byte=0; NmItem=6;
Var I,X1,Y1,X2,Y2,X,Y,LD,LN,T,T2:Byte;

 Procedure SetString;Begin
  Case Pos of
   0: Begin SD:='Programmeur';SN:='Malte';End;
   1: Begin SD:='Musique';SN:='Amadeus'; End;
   2: Begin SD:='Technique';SN:='The Magician';End;
   3: Begin SD:='Programmeuse';SN:='Eva';End;
   4: Begin SD:='Analyste';SN:='Isabelle';End;
   5: Begin SD:='Recherche';SN:='Le Loup';End;
   6: Begin SD:='Programmeuse';SN:='Mika';End;
  End;
 End;

Begin
 Tour:=(Tour+1)and 127;
 If Tour=60Then Begin
  X1:=PPlane[Plane].X1; Y1:=PPlane[Plane].Y1; LD:=Length(SD)*8;
  For I:=0to 7do ClrLnHor(X1,Y1+I,LD,Y1+I)
 End
  else
 If Tour=64Then Begin
  X2:=PPlane[Plane].X2; Y2:=PPlane[Plane].Y2; LN:=Length(SN)*8;
  For I:=0to 7do ClrLnHor(X2,Y2+I,LN,Y2+I);
  Pos:=MaxByte(Pos,NmItem);
  Plane:=(Plane+1)and 1;
 End
  else
 If Tour=1Then Begin
  SetString;
  PutString8x8(PPlane[Plane].X1,PPlane[Plane].Y1,NmLn+32,SD);
 End
  else
 If Tour=2Then PutString8x8(PPlane[Plane].X2,PPlane[Plane].Y2,NmLn+32,SN)
  else
 Begin
  If Tour<32Then Begin T:=Tour shl 1;T2:=T;End
  Else Begin T:=$FF-((Tour and 31) shl 3); T2:=0;End;
  SetPaletteRGB(NmLn+32,T,T,T2);
 End;
End;

Procedure SetMatrix;Var EpeePtr:^TByte;TxtMtx:^TByte;Begin
 EpeePtr:=@MatrixEpee;TxtMtx:=GetVideoTxtMtxPtr;
 MoveLeft(EpeePtr^,TxtMtx^[Byte('*')*8],8);
End;

Procedure LineHoriBlackPalette0To(L:Byte);Var J:Byte;Begin
 SetPalBlk(0,NmLn);
 For J:=0to L-1do ClrLnHor(0,J,320,J);
End;

Procedure PutDegrade(XPos,YPos:Wd;Str:String);Type PaChr=Array[Byte,0..7]of Byte;PPaChr=^PaChr;Var H,J:Byte;Begin
 For H:=1to Length(Str)do For J:=0to 7do CopT8Bin(XPos+(H-1)*8,YPos+J,
  PPaChr(GetVideoTxtMtxPtr)^[Byte(Str[H]),J],CharColor-8+J);
End;

Procedure AnimateMario;Var X:Wd;I:Byte;Boo:Array[0..1]of BlockButton;Begin
 ExecGetFile('RESOURCE\TETRIS\MARIO.ICN',0,SizeOf(Boo),Boo);
 SetPaletteRGB(8,0,0,0);
 ClrScr($80);
 PutTxtCenter(MaxYTxts,__Justified__,'Hi! Hi! Hi!',$8F);
 For I:=0to MaxXTxts do SetCube(I,14,'ş',$10+$10*(I shr 2)shl 1+Random(16));
 X:=280; I:=0;
 Repeat
  WaitRetrace; WaitRetrace; WaitRetrace; WaitRetrace; WaitRetrace;
  PutSmlImg(X,80,X+31,111,Boo[I].Data);
  I:=(I+1)and 1; Dec(X,5);
  If X<10Then Exit;
 Until Keypress;
 Readkey;
End;

Const
 sfDef=0;
 sf4kHz=1;  fn4kHz=1193182 div 4000;
 sf8kHz=2;  fn8kHz=1193182 div 8000;
 sf12kHz=3; fn12kHz=1193182 div 12000;
 sf16kHz=4; fn16kHz=1193182 div 15750;
 sf18KHz=5; fn18kHz=1193182 div 18000;
 sf20kHz=6; fn20kHz=1193182 div 20000;
 sf24kHz=7; fn24kHz=1193182 div 24000;
 sf28kHz=8; fn28kHz=1193182 div 28000;
 sf32kHz=9; fn32kHz=1193182 div 32000;
 sf36kHz=10; fn36kHz=1193182 div 36000;
 sf44kHz=11; fn44kHz=1193182 div 44000;
 sf63kHz=12; fn63kHz=1193182 div 62799;
 FreTbl:Array[1..12]of Wd=(fn4kHz,fn8kHz,fn12kHz,fn16kHz,fn18kHz,fn20kHz,fn24kHz,
			   fn28kHz,fn32kHz,fn36kHz,fn44kHz,fn63kHz);
Var I,SizeOfMtx,Timer:Wd;PathMod:PathStr;W:LstMnu;Fre:Byte;Kr:MtxColors;
    SavePalette:Array[Byte]of RGB;
Label _KEYPRESS;
BEGIN
 If ParamStr(1)='/?'Then Begin
  WriteLn('Jeux Tetris');
  WriteLn;
  WriteLn('Syntaxe: TETRIS [/NOSOUNDCARD]');
  WriteLn;
  WriteLn(' /NOSOUNDCARD  Interdit la d‚tection de carte de son');
  Halt;
 End;
 InitSystems(suIsabel);
 InitExecVolume;
 If ParamStr(1)<>'/NOSOUNDCARD'Then InitSound;
 ASM {OR}MOV CheckSvga,$80;END;
 If SetVideoModeDeluxe(vmGrf320x200c256)Then Begin
  __InitMouse;
  FillClr(Kr,SizeOf(Kr));
  Kr.Title:=$FC; Kr.Border:=$F0; Kr.Sel:=$1E; Kr.Icon:=$F;
  If(Music)Then Begin
   GetPaletteRGB(SavePalette,0,256);
   SetPalBlk(0,256);
   SetFontName('BROADWAY.POL');
   _SetKr(16);
   For I:=0to 6do PutFont('Configuration!');
   WinType:=Normal;
   LMInitCenter(W,34,10,'Sortie du Son',Kr);
   RBAddStrByte(W.X,'Haut-Parleur PC (PC Speaker)',soPCSpeaker);
   If(LPT1Exist)Then Begin
    RBAddStrByte(W.X,'Port ParallŠle 1 (Mono)',soLPT1);
    RBAddStrByte(W.X,'Port ParallŠle 1 (St‚r‚o)',soStereoLPT1);
   End;
   If(LPT2Exist)Then Begin
    RBAddStrByte(W.X,'Port ParallŠle 2 (Mono)',soLPT2);
    RBAddStrByte(W.X,'Port ParallŠle 2 (St‚r‚o)',soStereoLPT2);
   End;
   If(LPT1Exist)and(LPT2Exist)Then RBAddStrByte(W.X,'Port ParallŠle 1 et 2 (St‚r‚o)',soStereoLPT1N2);
   If(IsSoundBlaster)Then Begin
    RBAddStrByte(W.X,'SoundBlaster (Mono)',soSoundBlaster);
    RBAddStrByte(W.X,'SoundBlaster Pro (St‚r‚o)',soSoundBlasterPro);
   End;
   LMRefresh(W);
   FadeIn(7,SavePalette);
   SoundOutput:=LMRun(W);
   LMDone(W);
   If SoundOutput=0Then Music:=No
    Else
   Begin
    LMInitCenter(W,34,13,'Fr‚quences par Seconde',Kr);
    RBAddStrByte(W.X,'4 kHz (XT 8 Mhz)',sf4kHz);
    RBAddStrByte(W.X,'8 kHz (286 16 Mhz)',sf8kHz);
    RBAddStrByte(W.X,'12 kHz (386 25 Mhz)',sf12kHz);
    RBAddStrByte(W.X,'16 kHz (386 33 Mhz)',sf16kHz);
    RBAddStrByte(W.X,'18 kHz (386 40 Mhz)',sf18kHz);
    RBAddStrByte(W.X,'20 kHz (486 33 Mhz)',sf20kHz);
    RBAddStrByte(W.X,'24 kHz (486 40 Mhz)',sf24kHz);
    RBAddStrByte(W.X,'28 kHz',sf28kHz);
    RBAddStrByte(W.X,'32 kHz',sf32kHz);
    RBAddStrByte(W.X,'36 kHz',sf36kHz);
    RBAddStrByte(W.X,'44 kHz',sf44kHz);
    RBAddStrByte(W.X,'64 kHz',sf63kHz);
    Fre:=LMRun(W);
    WinType:=Robotic;
    If Fre=0Then Music:=No
     Else
    Begin
     PathMod:=FileExpand('DMC3.MOD');
     FreeHeap((90*1024+GetFileSize(PathMod))shr 4);
     If(Systems.LoadDriver)Then Begin
      SetSysSound(SoundOutput,FreTbl[Fre],1,7,$220);
      Systems.LoadModule(PathMod);
      If Error<>0Then Begin
       Systems.StopPlaying;
       Systems.DeAlloc;
       Systems.RemoveOvl;
       Systems.Unload;
       {$IFNDEF DPMI}MaxExpandHeap;{$ENDIF}
       Music:=No;
      End;
     End
      Else
     Music:=No;
    End;
    LMDone(W);
   End;
  End;
  SetTxtMtx(AllocFont(4,SizeOfMtx));
  AnimateMario;
  ClrScrBlack;
  SetMatrix;
  LineHoriBlackPalette0To(NmLn);
  SetPaletteBlack2Green(CharColor-16,8);
  SetPaletteRedToWhite(CharColor-8,8);
  SetPaletteWhiteToBlue(CharColor,8);
  BuildCharArray;
  BuildPath;
  CurrentLine:=0; CurrentArrayLoc:=0; PosMsg:=1;
  CalcLocs;
  For J:=1to NumberBar do BarLocs[J]:=J*10;
  For J:=0to 7do Begin
   PutLnHor(0,191-J,319,CharColor-16+J);
   PutLnHor(0,192+J,319,CharColor-16+J);
  End;
  PutDegrade(0,184,'+/- Volume F3/F4 Leds F5/F6 Clignotement');
  PutDegrade(0,192,'F7/F8 Tremble/Normal  F9/F10 Lent/Rapide');
  DegradLen:=8;
  If(Music)Then Begin
   PutMusicBar;
   _Move2(0,98);
   _SetKr(CharColor-16);
   PutFont('Tet');
   _Move2(245,98);
   PutFont('ris');
   StartPlaying;
  End
   Else
  Begin
   _Move2(80,88);
   _SetKr(CharColor-16);
   PutFont('Tetris');
  End;
  Timer:=0;
  Repeat
   Inc(Timer);
   If Not(SuperFast)Then WaitRetrace;
   PutAbout;
   If(Music)Then Begin
    SetMusicBar;
    If(CharBlink)Then SetCharBlink;
   End;
   PutMessage;
   If Not(SuperFast)Then WaitRetrace;
   For J:=1to NumberBar do Begin
    DrawBar(J);
    If(BarLocs[J]>NumCycles)Then BarLocs[J]:=1;
   End;
   Cycle;
_KEYPRESS:
  If(KeyPress)Then Begin
    K:=NxtKey;
    Case K of
    kbF3: Begin
	   LedStandard:=No;
	   ReadKey;
	   Goto _KEYPRESS;
	  End;
    kbF4: Begin
	   LedStandard:=Ya;
	   ReadKey;
	   Goto _KEYPRESS;
	  End;
    kbF5: Begin
	   CharBlink:=No;
	   ReadKey;
	   Goto _KEYPRESS;
	  End;
    kbF6: Begin
	   CharBlink:=Ya;
	   ReadKey;
	   Goto _KEYPRESS;
	  End;
    kbF7: Begin
	   FlagsTremble:=No;
	   ReadKey;
	   Goto _KEYPRESS;
	  End;
    kbF8: Begin
	   FlagsTremble:=Ya;
	   ReadKey;
	   Goto _KEYPRESS;
	  End;
    kbF9: Begin
	   SuperFast:=No;
	   ReadKey;
	   Goto _KEYPRESS;
	  End;
   kbF10: Begin
	   SuperFast:=Ya;
	   ReadKey;
	   Goto _KEYPRESS;
	  End;
    End;
    If Lo(K)>0Then Case Char(Lo(K))of
     '-' : Begin
	    If _Volume>0Then Begin
	     Dec(_Volume);
	     MasterVolume(_Volume);
	    End;
	    ReadKey;
	    Goto _KEYPRESS;
	   End;
     '+' : Begin
	    If _Volume<64Then Begin
	     Inc(_Volume);
	     MasterVolume(_Volume);
	    End;
	    ReadKey;
	    Goto _KEYPRESS;
	   End;
    End;
   End;
   If Timer=5777Then Break;
  Until KeyPress;
  If(Music)Then Begin
   Systems.StopPlaying;
   Systems.DeAlloc;
   Systems.RemoveOvl;
   Systems.Unload;
   {$IFNDEF DPMI}MaxExpandHeap;{$ENDIF}
  End;
  ClrKbd;
 End;
 Randomize;
 GetFile(FileNameHighScore,0,SizeOf(HighScore),HighScore);
 ModeVGA:=SetVideoModeDeluxe(vmGrf320x200c256);
 If Not(ModeVGA)THen SetVideoModeDeluxe(vmTxtC40);
 __InitMouse;
 InitEnv;
 Repeat
  K:=Mnu;
  Case K of
   0: Historik;
   1: Begin
       Play;
       UpDateHighScore;
       PutHighScore;
      End;
   2: SetLevel;
   3: PutHighScore;
  End;
 Until K=4;
 FadeOut;
 DoneLuxeVideo;
 WriteLn('Ce n''est qu''un '#14'Au Revoir...'#14'!');
 DoneExecVolume;
 DoneSystems;
END.