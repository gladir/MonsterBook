{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ·
 ³                               TSCROLL                              º
 ³   Malte Genesis/dition Chantal pour Mode R‚el/IV - Version 1.2    º
 ³                             1997/08/16                             º
 ³                                                                    º
 ³         Tous droits r‚serv‚s par les Chevaliers de Malte (C)       º
 ÔÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Ce petit programme est un d‚monstrateur montrant comment utiliser les
 fonctions vid‚o pour cr‚er un effet  de d‚filement  continue Vertical,
 Horizontal puis bidirectionnelle.


 Remarque
 ÍÍÍÍÍÍÍÍ

  ş Ce programme requŠre une carte VGA minimum!
}

Uses Chantal,Systex,Systems,Video;

Var J,I,X,Y,XDir,YDir,IDir:Wd;

BEGIN
 InitSystems(suIsabel);
 SetVideoMode(vmTxtDef);
 If Not(IsVGA)Then Begin                                      { Les cartes MDA, CGA et EGA ne supporte pas cette technique}
  WriteLn('Carte VGA r‚clam‚ pour ce genre d''effet sp‚ciaux!');
  Halt;
 End;
 SetBytesPerLn(320);                                          { Double la largeur des bandes (normalement … 160) }
 FillBox(0,0,159,49,'-',7);                                   { Affiche une tapiserie vulgaire }
 For J:=0to 49do For I:=0to 15do PutTxtXYUnKr(10*I,J,Str(I)); { Affiche les chiffres de colonnes...}
  {***D‚placement Vertical}
 Y:=0;YDir:=1;
 Repeat
  Inc(Y,YDir);If(Y<=0)or(Y>=NmYTxts*16)Then YDir:=-YDir;
  SetVerticalScale(Y);
 Until KeyPress;
 ReadKey;
  {***D‚placement Horizontal***}
 X:=0;XDir:=1;
 Repeat
  Inc(X,XDir);If(X<=0)or(X>=NmXTxts*9)Then XDir:=-XDir;
  SetHorizontalScale(X);
 Until KeyPress;
 ReadKey;
  {***D‚placement bidimensionnel***}
 Repeat
  Inc(X,XDir);If(X<=0)or(X>=NmXTxts*9)Then XDir:=-XDir;
  Inc(Y,YDir);If(Y<=0)or(Y>=NmYTxts*16)Then YDir:=-YDir;
  SetVerticalScale(Y);SetHorizontalScale(X);
 Until KeyPress;
 ReadKey;
  {***Superposition de page***}
 FillBox(0,0,159,49,'ş',$70);
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