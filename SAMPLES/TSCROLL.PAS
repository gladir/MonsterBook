{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴캠
 �                               TSCROLL                              �
 �   Malte Genesis/릁ition Chantal pour Mode R괻l/IV - Version 1.2    �
 �                             1997/08/16                             �
 �                                                                    �
 �         Tous droits r굎erv굎 par les Chevaliers de Malte (C)       �
 突袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴暠


 Description
 袴袴袴袴袴�

  Ce petit programme est un d굆onstrateur montrant comment utiliser les
 fonctions vid굊 pour cr괻r un effet  de d괽ilement  continue Vertical,
 Horizontal puis bidirectionnelle.


 Remarque
 袴袴袴袴

  � Ce programme requ둹e une carte VGA minimum!
}

Uses Chantal,Systex,Systems,Video;

Var J,I,X,Y,XDir,YDir,IDir:Wd;

BEGIN
 InitSystems(suIsabel);
 SetVideoMode(vmTxtDef);
 If Not(IsVGA)Then Begin                                      { Les cartes MDA, CGA et EGA ne supporte pas cette technique}
  WriteLn('Carte VGA r괹lam� pour ce genre d''effet sp괹iaux!');
  Halt;
 End;
 SetBytesPerLn(320);                                          { Double la largeur des bandes (normalement � 160) }
 FillBox(0,0,159,49,'-',7);                                   { Affiche une tapiserie vulgaire }
 For J:=0to 49do For I:=0to 15do PutTxtXYUnKr(10*I,J,Str(I)); { Affiche les chiffres de colonnes...}
  {***D굋lacement Vertical}
 Y:=0;YDir:=1;
 Repeat
  Inc(Y,YDir);If(Y<=0)or(Y>=NmYTxts*16)Then YDir:=-YDir;
  SetVerticalScale(Y);
 Until KeyPress;
 ReadKey;
  {***D굋lacement Horizontal***}
 X:=0;XDir:=1;
 Repeat
  Inc(X,XDir);If(X<=0)or(X>=NmXTxts*9)Then XDir:=-XDir;
  SetHorizontalScale(X);
 Until KeyPress;
 ReadKey;
  {***D굋lacement bidimensionnel***}
 Repeat
  Inc(X,XDir);If(X<=0)or(X>=NmXTxts*9)Then XDir:=-XDir;
  Inc(Y,YDir);If(Y<=0)or(Y>=NmYTxts*16)Then YDir:=-YDir;
  SetVerticalScale(Y);SetHorizontalScale(X);
 Until KeyPress;
 ReadKey;
  {***Superposition de page***}
 FillBox(0,0,159,49,'�',$70);
 SetPg(1);
 FillBox(0,0,159,49,'-',7);
 For J:=0to 49do For I:=0to 15do PutTxtXYUnKr(10*I,J,Str(I));
 X:=0;XDir:=1;Y:=0;YDir:=1;I:=0;IDir:=1;
 Repeat
  Inc(X,XDir);Inc(Y,YDir);Inc(I,IDir);
  If(I<=0)or(I>=NmYTxts*16)Then IDir:=-IDir;
  If(X<=0)or(X>=NmXTxts*9)Then XDir:=-XDir;
  If(Y<=0)or(Y>=NmYTxts*16)Then YDir:=-YDir;
  SplitScreen(I);
  SetVerticalScale(Y);
  SetHorizontalScale(X);
 Until KeyPress;
 ReadKey;
 SetVideoMode(vmTxtDef);
END.