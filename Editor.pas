{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³Malte Genesis/Module de Traitement de Texte (TextEdt)³
 ³    Edition Chantal pour Mode R‚el/IV-Version 1.0    ³
 ³                      1995/11/02                     ³
 ³                                                     ³
 ³ Tous droits r‚serv‚ par les Chevaliers de Malte (C) ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ


 Nom du programmeur
 ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

  Sylvain Maltais, Alias Malte


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette unit‚ contient toutes les proc‚dures principales
 d'‚ditions d'un  texte de  format standard DOS ASCII ou
 GAT de taille limit‚ … la m‚moire du systŠme,  c'est-…-
 dire … 640 Ko en mode r‚el, 16 Mo en mode prot‚g‚,...

  L'‚diteur supporte  ‚galement  l'‚dition  en mode  512
 caractŠres utilis‚  par exemple les  plans ‚lectronique
 et  l'affichage  accentu‚ des  listings  de langage  de
 programmations.  Leur chemin de recherche par d‚faut se
 trouve dans les variables ®Path???¯ et leurs extensions
 par d‚faut dans les variables ®Ext????¯.

  Le traŒtement de texte supporte la souris,  le copiage
 de bloc … l'int‚rieur de la fenˆtre et … l'ext‚rieur de
 celle-ci  si n‚cessaire ainsi  que  l'‚change de pages,
 ainsi  que l'‚dition  en  caractŠres  soulign‚s,  gras,
 double  largeur,   invers‚  le  fond   et  l'affichage,
 exposant,...

  Il permet  de d‚finir  diff‚rent  format de  taille de
 page  en  fonction  des   besoins   de   l'utilisateur,
 toutefois les longueurs  des lignes ne doit pas exc‚der
 une longueur de 65 520 caractŠres pendant l'‚dition. En
 mode r‚el,  l'‚diteur ne peut th‚oriquement pas exc‚der
 plus de 65535 lignes s'il y assez de m‚moire tandis que
 le mode prot‚g‚ permet  de monter jusqu'… 2 147 483 648
 lignes si la m‚moire le permet.

  Lorsqu'il  s'agit du format ®GAT¯,  il peut  ‚galement
 support‚  des mots de passes  pour prot‚ger le document
 contre les voyeurs et les espions.

  L'‚diteur affichera  une rŠgle en bas de la fenˆtre si
 la variable  bool‚enne  ®Rules¯  est  vrai  sinon  elle
 l'utilise comme  ligne  suppl‚mentaire  pour l'‚dition.
 Cette option  peut ˆtre  mis … faux  si l'affichage est
 trop lent.

  On  peut  ‚galement  d‚finir  des  marqueurs  de fin …
 chacun des lignes en fixant la variable  ®MakeEnd¯ … la
 valeur vrai.  Ceux-ci  sont  soit  des  cercles  ou des
 parenthŠses d‚pendamment  de la carte vid‚o install‚ et
 de l'environnement charg‚.


 Remarques
 ÍÍÍÍÍÍÍÍÍ

  ş La directive de compilation ®SepLn¯ est utilis‚ dans
    cette unit‚ pour autoris‚  des s‚parateurs entre les
    pages d‚finit par des petits points ®úúúúúúúúú¯ pour
    signaler … l'utilisateur qu'il change de page.

  ş Le proc‚dure virtuel ®PutMemory¯ est proc‚dure bidon
    appeler  … chaque  fois  qu'une  modification  de la
    m‚moire disponible … lieu.  On peut mettre sa propre
    routine … la place  de  celle-ci  en  n'oubliant pas
    qu'il doit s'agir d'une routine ®FAR¯ et surtout pas
    ®NEAR¯.

  ş Le module de chargement  des textes de divers format
    se  trouve  dans  l'unit‚ ®EdtLoad¯  et des  options
    compl‚mentaire  dont les tries  et les recherches se
    trouve dans ®EdtExtra¯.  En terminant, la routine de
    terminaison  de  l'‚diteur  se trouve  dans  l'unit‚
    ®EdtDone¯.

  ş L'‚diteur n'‚tant pas limiter … une taille de 64 Ko,
    il utilise  donc une autre m‚thode que la classique,
    et cette m‚thode est celle du  ®RBuf¯  contenue dans
    l'unit‚ ®Systems¯.


 Utilisation
 ÍÍÍÍÍÍÍÍÍÍÍ

  ş Par  le  ®MonsterBook¯  comme traitement  de  texte,
    ‚diteur, ‚diteur de listing d'Assembleur, Basic,  C,
    Pascal, aide de terminal,...

  ş Par le ®OverCode¯ comme traitement de texte,‚diteur,
    ‚diteur de listing d'Assembleur, Basic, C, Pascal.

  ş ®Basic Pro¯ comme ‚diteur de listing de Basic.
}
Unit Editor;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                 INTERFACE
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

{$I DEF.INC}
{$DEFINE SepLn}

Uses
 Systex,Systems,Isatex,Editex;

Procedure TEBoldWord(Var Q:EditorApp);
Procedure TEChkMaxLen(Var Q:EditorApp;L:Word);
Procedure TEDelCurrLn(Var Q:EditorApp);
Procedure TEDelSpc(Var Q:EditorApp);
Procedure TEDelWord(Var Q:EditorApp);
Procedure TEDoubleWord(Var Q:EditorApp);
Procedure TEEndText(Var Q:EditorApp);
Procedure TEExposantWord(Var Q:EditorApp);
Function  TEGetViewMode(Var Q:EditorApp):Byte;
Procedure TEHomeText(Var Q:EditorApp);
Function  TEInsSpcHome(Var Q:EditorApp;L,N:Word;Var PC:PChr):Boolean;
Procedure TEInsSpcIfHome(Var Q:EditorApp;Num:Wd);
Procedure TEInverseWord(Var Q:EditorApp);
Procedure TEItalicWord(Var Q:EditorApp);
Procedure TEkBS(Var Q:EditorApp);
Procedure TEkCtrlLeft(Var Q:EditorApp);
Procedure TEkCtrlRight(Var Q:EditorApp);
Procedure TEkDel(Var Q:EditorApp);
Procedure TEkDn(Var Q:EditorApp);
Procedure TEkEnd(Var Q:EditorApp);
Procedure TEkEnter(Var Q:EditorApp);
Procedure TEkEnterIns(Var Q:EditorApp);
Procedure TEkHome(Var Q:EditorApp);
Procedure TEkLeft(Var Q:EditorApp);
Procedure TEkPgDn(Var Q:EditorApp);
Procedure TEkPgUp(Var Q:EditorApp);
Procedure TEkRight(Var Q:EditorApp);
Procedure TEkUp(Var Q:EditorApp);
Function  TEMaxLns(Var Q:EditorApp):RBP;
Procedure TENormalWord(Var Q:EditorApp);
Procedure TEPushStr(Var Q:EditorApp;S:String);
Procedure TEPutPos(Var Q:EditorApp);
Procedure TEPutRules(Var Q:EditorApp);
Procedure TEPutKeyTxt(Var Q:EditorApp);
Procedure TEPutWn(Var Q:EditorApp;X1,Y1,X2,Y2:Byte);
Procedure TEPutBar(Var Q:EditorApp);
Procedure TERefresh(Var Q);
Function  TERun(Var Context):Word;
Procedure TESetChrType(Var Q:EditorApp;M:Byte);
Procedure TESetCur(Var Q:EditorApp);
Procedure TESetDrawMode(Var Q:EditorApp;M:Boolean);
Procedure TESetFormat(Var Q:EditorApp);
Procedure TESetThisChr(Var Q:EditorApp;Chr:Char);
Procedure TESetViewMode(Var Q:EditorApp;M:Byte);
Procedure TESetWn(Var Q:EditorApp;X1,Y1,X2,Y2:Byte);
Procedure TEUnderlineWord(Var Q:EditorApp);
Procedure TEUpDateInfo(Var Q:EditorApp);
Procedure TEUpDateScr(Var Q:EditorApp);
Function  _TEInsSpcHome(Var Q:EditorApp;L,N:Word;Var PC:PChr):Bool;

{$IFDEF __Windows__}
 Function TEGetCurrChr(Var Q:EditorApp):Chr;
 Function TEGetDnChr(Var Q:EditorApp):Chr;
 Function TEGetLastChr(Var Q:EditorApp):Chr;
 Function TEGetNextChr(Var Q:EditorApp):Chr;
 Function TEGetUpChr(Var Q:EditorApp):Chr;
{$ENDIF}

 {Proc‚dure interne globale}
Procedure TEInitCoord(Var Q:EditorApp);
Procedure TEInitLang(Var Q:EditorApp);

Const
 PutMemory:Procedure=Ret; { Proc‚dure affichant la m‚moire disponible }

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                              IMPLEMENTATION
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses
 Adele,Video,Dials,Math,Numerix,Terminal,Mouse,Memories,Tools,
 EdtLoad,EdtExtra,EdtBlock,EdtJust,EdtSearc,
 Dialex,DialPlus,ResServI,ResServD;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ·}
{³                     Z o n e  P r i v ‚ s                    º}
{ÔÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼}

Function   GetGatLen(PChr:PChr):Word;Near;Forward;
Function   PosGat2X(PChr:PChr;P:Word):Word;Forward;
Function   PosX2Gat(PChr:PChr;P:Word):Word;Forward;
Procedure  SetGatAttr(Len:Word;PChr:PChr;Var PChrT:Char;P,L:Word;Attr:Byte);Near;Forward;
{$IFNDEF __Windows__}
 Function  TEGetCurrChr(Var Q:EditorApp):Chr;Near;Forward;
 Function  TEGetDnChr(Var Q:EditorApp):Chr;Near;Forward;
 Function  TEGetLastChr(Var Q:EditorApp):Chr;Near;Forward;
 Function  TEGetNextChr(Var Q:EditorApp):Chr;Near;Forward;
 Function  TEGetUpChr(Var Q:EditorApp):Chr;Near;Forward;
{$ENDIF}
Function   TEInsChr(Var Q:EditorApp;L:Word;PC:PChr;Chr:Char):Boolean;Near;Forward;
Function   TEIsAttrDbl(Var Q:EditorApp):Boolean;Near;Forward;
Function   TEIsAttrUnder(Var Q:EditorApp):Boolean;Near;Forward;
Function   TEIsDbl(Chr:Char):Boolean;Near;Forward;
Function   TEkRightNShow(Var Q:EditorApp;Show:Boolean):Boolean;Near;Forward;
Procedure  TELeft4Word(Var Q:EditorApp);Near;Forward;
Procedure  TEMacro(Var Q:EditorApp;S:PChr);Near;Forward;
Function   TEPopCurr(Var Q:EditorApp):PChr;Near;Forward;
Procedure  TEPutBarXYM(Var Q:EditorApp;_X:Wd;_Y:RBP;Mem:LongInt);Near;Forward;
Procedure  TEPutIns(Var Q:EditorApp);Near;Forward;
Procedure _TEPutLn(Var Q:EditorApp;Size,I1:Integer;P:Word;PC:PChr);Far;Forward;
Procedure _TEPutLnGat(Var Q:EditorApp;Size,I1:Integer;P:Wd;PC:PChr);Far;Forward;
Procedure  TEPutScrollLck(Var Q:EditorApp);Near;Forward;
Procedure  TEPutViewMode(Var Q:EditorApp);Near;Forward;
Procedure _TEPutWn(Var Q:EditorApp);Near;Forward;
Procedure  TESetModified(Var Q:EditorApp);Near;Forward;
Procedure _TESetModified(Var Q:EditorApp);Near;Forward;
Procedure  TESetWord(Var Q:EditorApp;ChrMode:Byte);Near;Forward;
Procedure  TESetPtr(Var Q:EditorApp);Near;Forward;
Procedure  TETab(Var Q:EditorApp);Near;Forward;
Procedure  TEUpDateEOS(Var Q:EditorApp);Near;Forward;
{Procedure TEUpDateInfo(Var Q:EditorApp);Near;Forward;}
Procedure  TEUpDateLn(Var Q:EditorApp);Near;Forward;
Procedure  TEUpDatePXGWithX(Var Q:EditorApp;_X:Byte);Near;Forward;

{ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ
       Sous-Routine de manipulation des chaŒnes de caractŠres ®Gat¯
 ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Proc‚dure SetGatAttr                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'affecter une attribut particulier … une partie de
 la chaŒne de caractŠres en param‚trage ®PChr¯ et retourne dans la chaŒne de
 caractŠres ®PChrT¯.


 Remarque
 ÍÍÍÍÍÍÍÍ

  ş Les chaŒnes  de caractŠres  ®PChrT¯  doit avoir  une longueur suffisante
    pour re‡evoir  en entier  la chaŒne  de caractŠres  avec  ses  nouvelles
    attributs.
}

Procedure SetGatAttr;
Var
 I,J,K:Word;                { Variable compteur de boucle }
 TChr:TChar Absolute PChrT; { ChaŒne de caractŠres destinataire }
Begin
 If Len=0Then Exit;
 J:=0;
 If P>0Then Begin
  For I:=0to P-1do Case PChr^[J]of
   #0:Begin
    MoveLeft(PChr^,PChrT,Len+1);
    Exit;
   End;
   #1..#31:If(Byte(PChr^[J])and cgDouble=cgDouble)Then Inc(J)
                                                  Else Inc(J,2);
   Else Inc(J);
  End;
  MoveLeft(PChr^,PChrT,J);
 End;
 K:=J;
 If Attr=0Then For I:=P to P+L-1do Begin
  Case PChr^[J]of
   #0:Begin
    TChr[K]:=#0;
    Exit;
   End;
   #1..#31:Begin
    TChr[K]:=PChr^[J+1];Inc(J,2)
   End;
   Else Begin
    TChr[K]:=PChr^[J];Inc(J)
   End;
  End;
  Inc(K)
 End
  Else
 For I:=P to P+L-1do Case PChr^[J]of
  #0: Begin
   TChr[K]:=#0;
   Exit;
  End;
  ' ': Begin
   If(Attr and cgUnderline=cgUnderline)Then TChr[K]:='_'
                                       Else TChr[K]:=' ';
   Inc(J);Inc(K)
  End;
  #1..#31:Begin
   TChr[K]:=Char(Attr);
   TChr[K+1]:=PChr^[J+1];
   Inc(J,2);Inc(K,2)
  End;
  Else Begin
   TChr[K]:=Char(Attr);
   TChr[K+1]:=PChr^[J];
   Inc(J);Inc(K,2)
  End;
 End;
 If(J-1<Len)Then MoveLeft(PChr^[J],TChr[K],Len-J+1)
End;

{$I \Source\Chantal\Library\System\Malte\ExecFile\GetGatLe.Inc}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Fonction PosGat2X                            Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction convertie la position physique … l'‚cran avec la position
 physique … l'int‚rieur d'une chaŒne de caractŠres.
}

Function PosGat2X;
Label
 Break;
Var
 I:Word;     { Variable de compteur de boucle }
 L:Word;     { Longueur logique de la chaŒne de caractŠres de format GAT }
 Ok:Boolean; { CaractŠre … compter dans la longueur? }
Begin
 I:=0;L:=0;PosGat2X:=P;
 If IsPChrEmpty(PChr)Then Exit;
 While PChr^[I]<>#0do Begin
  Ok:=False;
  Case PChr^[I]of
   #1..#31:Ok:=Byte(PChr^[I])and cgDouble=cgDouble;
   ' '..#254:Ok:=True;
  End;
  If(Ok)Then Begin
   Inc(L);
   If(L>=P)Then Goto Break
  End;
  Inc(I)
 End;
Break:
 PosGat2X:=I
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Fonction PosX2Gat                            Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Portabilit‚:  Local


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction convertie la position physique … l'int‚rieur d'une chaŒne
 de caractŠres avec la position physique … l'‚cran.
}

Function PosX2Gat;
Label
 Break;
Var
 I:Word;     { Variable compteur de boucle }
 L:Word;     { Longueur logique de la chaŒne de caractŠres de format GAT }
 Ok:Boolean; { CaractŠre … compter dans la longueur? }
Begin
 I:=0;L:=0;PosX2Gat:=P;
 If IsPChrEmpty(PChr)or(P=0)Then Exit;
 While PChr^[I]<>#0do Begin
  Ok:=False;
  Case PChr^[I]of
   #1..#31: Ok:=Byte(PChr^[I])and cgDouble=cgDouble;
   ' '..#254: Ok:=True;
  End;
  If(Ok)Then Begin
   Inc(L);
   If(L>=P)Then Goto Break
  End;
  Inc(I)
 End;
Break:
 PosX2Gat:=L
End;

{$I POSX2GAT.INC}

{ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ
                          O b j e t  - >   d i t e u r
 ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure TELeft4Word                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: EditorApp
 Portabilit‚:  Local


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure d‚place le pointeur texte  … la gauche totalement du mot
 pr‚c‚dent. C'est utilisez lors de changement de ligne automatique pendant
 la frappe de long texte.
}

Procedure TELeft4Word;
Label Xit;
Var
 I:Word;   { Variable compteur de boucle }
 PC:PChr;  { Pointeur sur la ligne de traŒtement de texte courante }
 PX9:Word; { Position d'‚cran physique horizontal … conserver }
 X9:Byte;  { Postiion d'‚cran logique horizontal … conserver }
Begin
 PC:=TEPopCurr(Q);
 PX9:=Q.PX;X9:=Q.X;
 If(Q.Mode<>vtGAT)Then Q.PXG:=Q.PX;
 If Not IsPChrEmpty(PC)Then Begin
  For I:=Q.PXG downto 0do Begin
   Case PC^[I]of
    '-':If(I<>Q.PXG)Then Begin
     {$IFDEF __Windows__}
      Q.PXG:=I+1;
      Goto Xit;
     {$ELSE}
      Inc(I);
      Break;
     {$ENDIF}
    End;
    ' ':Begin
     {$IFDEF __Windows__}
      Q.PXG:=I+1;
      Goto Xit;
     {$ELSE}
      Inc(I);
      Break;
     {$ENDIF}
    End;
    #33..#44,#46..#254:Begin
     If Q.PX>0Then Dec(Q.PX);
     If Q.X>0Then Dec(Q.X);
     If(I<=Q.SheetFormat.X1)or(I=0)Then Begin
      Q.PX:=PX9;Q.X:=X9;
      Exit;
     End;
    End;
   End;
  End;
 End;
 Q.PXG:=I;
Xit:
 TESetCur(Q);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Proc‚dure TEMacro                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: EditorApp
 Portabilit‚:  Local


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure interprŠte une chaŒne de Macro Machine du traŒtement de
 texte de cette unit‚.
}

Procedure TEMacro;
Label
 Break;
Var
 I:Word;  { Variable compteur de boucle }
Begin
 I:=0;
 Repeat
  Case S^[I]of
  macCtrlRight:TEkCtrlRight(Q);     { Permet de ce d‚plac‚ … droite d'un mot }
  macDecFS:Dec(Q.FileSize,Long(1)); { Permet de d‚cr‚menter la taille du fichier }
  macDecFS2:Dec(Q.FileSize,Long(2));{ Permet de d‚cr‚menter de 2 la taille du fichier }
  macDel:TEkDel(Q);                 { Efface le caractŠre o— se trouve la curseur }
  macDn:TEkDn(Q);                   { Descend d'une ligne }
  macEnd:TEkEnd(Q);                 { Va … la fin d'une ligne }
  macHome:TEkHome(Q);               { Va au d‚but d'une ligne }
  macIncFS:Inc(Q.FileSize,Long(1)); { Permet d'incr‚menter la taille du fichier }
  macIncFS2:Inc(Q.FileSize,Long(2));{ Permet d'incr‚menter de 2 la taille du fichier }
  macLeft:TEkLeft(Q);               { Permet de ce d‚plac‚ … gauche d'un mot }
  macPutCurrLn:TEUpDateLn(Q);       { Affiche la ligne courante }
  macPXG0:Q.PXG:=0;                 { Initialise la variable ®PXG¯ }
  macRight:TEkRight(Q);             { Permet de ce d‚placer d'un caractŠre vers la droite }
  macSetModified:TESetModified(Q);  { Affecte l'attribut de modification }
  macUp:TEkUp(Q);                   { Permet de monter d'une ligne }
  macUpdateInfo:TEUpdateInfo(Q);    { Permet de faire une mise … jour des donn‚es }
  macUpdateLn:TEUpdateLn(Q);        { Permet d'effectuer une mise … jour de la ligne }
  macUpdateScr:TEUpdateScr(Q);      { Permet d'effectuer une mise … jour complŠte de l'‚diteur }
  #0:Goto Break;                    { Code de terminaison }
  End;
  Inc(I)
 Until False;
Break:
End;

{$I \Source\Chantal\TEPOPCUR.INC}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure TEPutBarXYM                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: EditorApp
 Portabilit‚:  Local


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure affiche les donn‚es actuel concernant la dimension de
 texte en plein ‚dition.
}

Procedure TEPutBarXYM;
Var
 Kr:Byte; { Variable contenu la couleur de la barre d'information }
Begin
 If(Q.Mode=vtHlp)Then
  WESetEndBarTxtX(Q.W,45,WordToStr((Q.SheetFormat.Y2-Q.SheetFormat.Y1+1)div _Y)+' Pages',Q.W.Palette.Title)
  Else
 Begin
  If(Q.Mode=vtPJ)Then Kr:=$D5
                 Else Kr:=CurrKrs.Editor.Env.Pos;
  WESetEndBarTxtX(Q.W,45,WordToStr(_X)+'x'+WordToStr(_Y)+':'+BasicStr(Mem)+' octet(s)',Kr);
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure TEPutIns                           Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: Edt
 Portabilit‚:  Local


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure met … jour les  4 indicateurs du traŒtement du texte de
 l'objet  d'‚dition.  Il ne  s'occupe pas  de restaurer  la barre en sous
 laquelle il s'affiche, ni mˆme la position du curseur mais seulement lui
 mˆme.
}

Procedure TEPutIns;
Var
 Kr:Byte;     { Couleur de la barre d'information }
 S:String[4]; { ChaŒne de caractŠres affichant le contenu des drapeaux }
Begin
 If(Q.Mode=vtHlp)Then Kr:=Q.W.Palette.Title         { Couleur utilis‚ lors d'un ‚diteur d'aide }
                 Else Kr:=CurrKrs.Editor.Env.Insert;{ Couleur normalement utilis‚ pour l'‚diteur }
 S:='    ';                     { Cr‚e une chaŒne par d‚faut sans affectation }
 If(Q.InsMode)Then S[1]:='I';   { Mode d'insertion ? }
 If(Q.ScrollLock)Then S[2]:='S';{ Mode de fenˆtrage/ScrollLock? }
 If(Q.DrawMode)Then S[3]:='D';  { Mode de dessin }
 If(Q.ReadOnly)Then S[4]:='L';  { Mode en lecture seulement }
 WESetEndBarTxtX(Q.W,17,S,Kr);  { Affiche sur la derniŠre ligne de l'‚diteur les ‚tats }
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure TESetModified                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: Edt
 Portabilit‚:  Local


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure fixe le drapeau de modification l'‚diteur de traŒtement
 pour lui indiquer  que le texte n'est plus identique … celui sur disque.
 Il met  en  plus  … jour  la position  actuel  du  pointeur  de texte de
 l'objet.
}

Procedure TESetModified;Begin
 _TESetModified(Q); { Fixe le drapeau de modification de l'‚diteur ®Q¯ }
 TESetPtr(Q)        { Mise … jour de la position du pointeur de l'‚diteur ®Q¯ }
End;

{$I TESETPTR.INC}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure TETab                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: EditorApp
 Portabilit‚:  Local


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure  insŠre  8 espaces  … la position courante  dans le
 traŒtement de texte de l'objet d'‚dition. Si elle est enclench‚ lors
 d'un mode ®ScrollLock¯ sur sa bordure gauche  et que dans cette mˆme
 bordure sur la mˆme ligne,  il contient du texte, elle le sortira de
 son trou  et n'effectuera  donc  pas l'op‚ration  de tabulation de 8
 espaces.
}

Procedure TETab(Var Q:EditorApp);
Var
 PC:PChr; { Pointeur sur la ligne de texte courant }
 I:Wd;    { Variable de compteur de boucle }
Begin
 If(Q.ScrollLock)and(Q.Mode=vtGat)and(Q.X=Q.SheetFormat.X1)Then Begin
  PC:=TEPopCurr(Q);
  If(PC<>NIL)Then For I:=0to Q.SheetFormat.X1-1do Begin
   If PC^[I]=#0Then Break;
   If PC^[I]>' 'Then Begin
    TEInsSpcHome(Q,StrLen(PC),Q.SheetFormat.X1,PC);
    Exit;
   End;
  End;
 End;
 TEPushStr(Q,SpcTab);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Proc‚dure TEUpDatePXGWithX                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: EditorApp
 Portabilit‚:  Local


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure met … jour la position ®PXG¯ en fonction de celle demander
 par la variable de param‚trage.
}

Procedure TEUpDatePXGWithX;Begin
 If(Q.Mode=vtGAT)Then Q.PXG:=PosX2Gat1{xx}(_ALGetBuf(Q.List,Q.P),_X)
                 Else Q.PXG:=_X;
End;

{$F-}
{$I Library\Compiler\C\PXtrkCNm.Inc}
{$F+}

Function CobolXtrkWord(Var I:Word;Line:PChr):String;Near;
Var
 W:String; { Variable temporaire pour contenir la chaŒne de caractŠres de sortie }
Begin
 CobolXtrkWord:='';
 If Not(Line^[I]in['A'..'Z','a'..'z'])Then Exit;
 W:=Line^[I];Inc(I);
 While Line^[I]<>#0do Begin
  If(Line^[I]in['A'..'Z','a'..'z','0'..'9','-'])Then Begin
   IncStr(W,Line^[I]);Inc(I);
   If I=255Then Break;
  End
   Else
  Break;
 End;
 CobolXtrkWord:=W;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure _TEPutLn                            Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: EditorApp
 Portabilit‚:  Local


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure s'occupe d'affiche une ligne en format par d‚faut et les
 autres modes diff‚rent de "GAT"  dans le  traŒtement de texte  de l'objet
 d'‚dition.
}

Procedure _TEPutLn;
Label
 FR,PS,AsmInstr,AsmNoInstr,BasInstr,BasFunc,
 BasNone,NotCMainWord,NotCobolMainWord,
 NotMainWordBatch,OutCaseBatch;
Var
 XCmp:Byte;
 Str,UStr:String;
 I,J,K:Word;
 Ok:Boolean;

 Procedure PutChar(Chr:Char);Begin
  If(I>=I1)Then Begin
   If I-I1>255Then Exit;
   If(Q.ScrollLock)Then Begin
    If((I<Q.SheetFormat.X1)or(I>Q.SheetFormat.X2))and(ViewOutZone)Then Begin
     _WESetCube(Q.W,I-I1,Q.W.Y,Chr,CurrKrs.Editor.OutZone)
    End
     Else
    WESetCube(Q.W,I-I1,Q.W.Y,Chr);
   End
    else
   WESetCube(Q.W,I-I1,Q.W.Y,Chr);
  End;
 End;

 Procedure PutText(Const Str:String);
 Var
  I2,I3:Wd;OldY:Byte;
 Begin
  If(I<I1)Then Exit;
  I2:=I-Word(Length(Str));OldY:=Q.W.Y;
  For I3:=I2 to I-1do Begin
   If(Q.ScrollLock)and(ViewOutZone)and((I3<Q.SheetFormat.X1)or(I3>Q.SheetFormat.X2))Then
    _WESetCube(Q.W,I3-I1,Q.W.Y,PC^[I3],CurrKrs.Editor.OutZone)
   Else
    WESetCube(Q.W,I3-I1,Q.W.Y,PC^[I3]);
  End;
  Q.W.Y:=OldY;
 End;

 Procedure __Put;Begin
  PutChar(PC^[I]);
  Inc(I)
 End;

 Procedure SetKrDef;Begin
  Q.W.CurrColor:=CurrKrs.Editor.Env.Default;
 End;

 Procedure SetKrRem;Begin
  Q.W.CurrColor:=CurrKrs.Editor.Env.Rem;
 End;

 Procedure SetKrResWd;Begin
  Q.W.CurrColor:=CurrKrs.Editor.Env.ResWord;
 End;

 Procedure PutCString;
 Label
  Break;
 Begin
  J:=I;Q.W.CurrColor:=CurrKrs.Editor.Env.Chars;
  __Put;
  While PC^[I]<>'"'do Begin
   If PC^[I]='\'Then Begin
    PutChar('\');
    Inc(I)
   End;
   If PC^[I]=#0Then Goto Break;
   __Put;
  End;
Break:
  If PC^[I]<>#0Then __Put;
  SetKrDef;
 End;

 Procedure PutAsmCString;
 Label
  Break;
 Begin
  J:=I;Q.W.CurrColor:=CurrKrs.Editor.Env.Chars;
  __Put;
  While PC^[I]<>'"'do Begin
   If PC^[I]=#0Then Goto Break;
   __Put;
  End;
Break:
  If PC^[I]<>#0Then __Put;
  SetKrDef;
 End;

 Procedure PutBasicString;
 Label
  Break;
 Begin
  J:=I;Q.W.CurrColor:=CurrKrs.Editor.Env.Chars;
  __Put;
  While PC^[I]<>'"'do Begin
   If PC^[I]=#0Then Goto Break;
   If PC^[I]<' 'Then Begin
    Q.W.CurrColor:=(CurrKrs.Editor.Env.Chars shr 4)+CurrKrs.Editor.Env.Chars shl 4;
    PutChar(Char(Byte(PC^[I])+64));
    Inc(I);Q.W.CurrColor:=CurrKrs.Editor.Env.Chars;
   End
    Else
   __Put;
  End;
Break:
  If PC^[I]<>#0Then __Put;
  SetKrDef;
 End;

 Procedure PutPascalString;
 Label
  Break;
 Begin
  J:=I;Q.W.CurrColor:=CurrKrs.Editor.Env.Chars;
  __Put;
  While PC^[I]<>''''do Begin
   If PC^[I]=''''Then Begin
    PutChar('''');
    Inc(I)
   End;
   If PC^[I]=#0Then Goto Break;
   __Put;
  End;
Break:
  If PC^[I]<>#0Then __Put;
  SetKrDef;
 End;

 Procedure PutCChar;Begin
  J:=I;Q.W.CurrColor:=CurrKrs.Editor.Env.Chars;
  __Put;
  While PC^[I]<>''''do Begin
   If PC^[I]=#0Then Break;
   If(PC^[I]='\')and(PC^[I+1]='''')Then Begin
    __Put;
    __Put;
   End
   Else __Put;
  End;
  If PC^[I]<>#0Then __Put;
  SetKrDef;
 End;

 Procedure PutSymbol;Begin
  Q.W.CurrColor:=CurrKrs.Editor.Env.Symbol;
  __Put;
  SetKrDef;
 End;

 Procedure PutZ;Begin
  Q.W.CurrColor:=CurrKrs.Editor.Env.Z;
  PutChar('E');
  Inc(I);
  SetKrDef;
 End;

 Procedure ResWd;
 Label
  NotMainWord;
 Begin
  If(Q.Mode=vtPas)and((Q.ModeSub=0)or(Q.ModeSub and pmPascalB57>0))Then Begin
   If Not(PC^[I]in['A'..'Z','a'..'z','_',#128..#255])Then Exit;
   Str:=PC^[I];UStr:=Str;
   Inc(I);
   While PC^[I]<>#0do Begin
    If(PC^[I]in['A'..'Z','a'..'z','0'..'9','_',#128..#255])Then Begin
     IncStr(Str,PC^[I]);
     Case PC^[I]of
      '‡','€':IncStr(UStr,'C');
      '‚','':IncStr(UStr,'E');
      Else IncStr(UStr,ChrUp(PC^[I]));
     End;
     Inc(I);
     If I=255Then Break;
    End
     Else
    Break;
   End;
  End
   Else
  Begin
   Str:=PXtrkWord(I,PC);
   UStr:=StrUp(Str);
  End;
  If DBLocateAbsIM(Q.DBMainWord,2,UStr,[])Then Begin
   If Q.ModeSub>0Then Begin
    If Q.DBMainWord.CurrRec.Word^ and Q.ModeSub=0Then Goto NotMainWord;
   End;
{   ASM
    LES DI,Q
    MOV AX,ES:[DI].EditorApp.ModeSub
    OR  AX,AX
    JZ  @End
    LES DI,ES:[DI].EditorApp.DBMainWord.CurrRec
    AND AX,ES:[DI+1]
    JZ  NotMainWord
 @End:
   END;}
   SetKrResWd;
  End
   Else
  Begin
   NotMainWord:SetKrDef;
  End;
  PutText(Str);
  SetKrDef;
 End;

Begin
 If(PC<>NIL)Then If(Size>I1)Then Case(Q.Mode)of
  vtAsm:Begin
   I:=0;
   While PC^[I]<>#0do Begin
    Case PC^[I]of
     ';':Begin
      SetKrRem;
      While PC^[I]<>#0do __Put;
      SetKrDef;
     End;
     '@',':',',','.','(',')','[',']','=','$','+','-','#','!','?','&','*','%','/':PutSymbol;
     '"':PutAsmCString;
     '0'..'9':Begin
      Q.W.CurrColor:=CurrKrs.Editor.Env.Number;
      __Put;
      While(PC^[I]in ArabicXDigit)do __Put;
      If PC^[I]in['B','b','O','o','H','h']Then __Put;
      SetKrDef;
     End;
     '''':PutCChar;
     'A'..'Z','a'..'z','_':Begin
      Str:=PXtrkWord(I,PC);
      UStr:=StrUp(Str);
      If DBLocateAbsIM(Q.DBFunc,2,UStr,[])Then Begin
       Q.W.CurrColor:=CurrKrs.Editor.Env.AsmInst and$F7;
      End
       Else
      If DBLocateAbsIM(Q.DBMainWord,2,UStr,[])Then Begin
       ASM
        {$IFDEF FLAT386}
         LEA EDX,Q
         MOV AX,[EDX].EditorApp.ModeSub
         OR  AX,AX
         JZ  @End
         LEA ECX,[EDX].EditorApp.DBMainWord.CurrRec
         AND AX,[EDX+1]
         JZ  AsmInstr
        {$ELSE}
         LES DI,Q
         MOV AX,ES:[DI].EditorApp.ModeSub
         OR  AX,AX
         JZ  @End
         LES DI,ES:[DI].EditorApp.DBMainWord.CurrRec
         AND AX,ES:[DI+1]
         JZ  AsmInstr
        {$ENDIF}
@End:  END;
       SetKrResWd;
      End
       Else
AsmInstr:If DBLocateAbsIM(Q.DBInstr,3,UStr,[])Then Begin
       ASM
        {$IFDEF FLAT386}
         LEA EDX,Q
         MOV AX,[EDX].EditorApp.ModeSub
         OR  AX,AX
         JZ  @End
         LEA EDX,[EDX].EditorApp.DBInstr.CurrRec
         AND AL,[EDX+2]
         JZ  AsmNoInstr
        {$ELSE}
         LES DI,Q
         MOV AX,ES:[DI].EditorApp.ModeSub
         OR  AX,AX
         JZ  @End
         LES DI,ES:[DI].EditorApp.DBInstr.CurrRec
         AND AL,ES:[DI+2]
         JZ  AsmNoInstr
        {$ENDIF}
@End:  END;
       Q.W.CurrColor:=CurrKrs.Editor.Env.AsmInst;
      End
       Else
      AsmNoInstr:SetKrDef;
      PutText(Str);
      SetKrDef;
     End;
     ^Z:PutZ;
     Else
     __Put;
    End;
   End;
  End;
  vtBas:Begin
   I:=0;
   While PC^[I]<>#0do Begin
    Case PC^[I]of
     '.','0'..'9':Begin
     Q.W.CurrColor:=CurrKrs.Editor.Env.Number;
      __Put;
      While(PC^[I]in ArabicDigit)do __Put;
      SetKrDef;
     End;
     '&':Begin
      Q.W.CurrColor:=CurrKrs.Editor.Env.Number;
      __Put;
      Case PC^[I]of
       'H':Begin
        __Put;
	While(PC^[I]in ArabicXDigit)do __Put;
       End;
       'O':Begin
        __Put;
	While(PC^[I]in OctArabicDigit)do __Put;
       End;
       'B':Begin
        __Put;
	While(PC^[I]in BinArabicDigit)do __Put;
       End;
      End;
      SetKrDef;
     End;
     '''':Begin
      SetKrRem;
      While PC^[I]<>#0do __Put;
      SetKrDef;
     End;
     'A'..'Z','a'..'z':Begin
      J:=I;Str:='';{XCmp:=0;}
      While IsRomanLetter(PC^[I])do Begin
       IncStr(Str,PC^[I]);Inc(I);
       If PC^[I]='$'Then Begin
        IncStr(Str,PC^[I]);
        Inc(I);
        Break;
       End;
      End;
      UStr:=StrUp(Str); Ok:=False;
      If CmpLeft(UStr,'REM')Then Begin
       I:=J;
       SetKrRem;
       While PC^[I]<>#0do __Put;
      End
       Else
      Begin
       If CmpLeft(UStr,'ATTR')Then Begin
        SetKrDef;
        I:=J+4;
        Systems._Left(Str,4)
       End
	Else
       Begin
        If DBLocateAbsIM(Q.DBMainWord,2,UStr,[])Then Begin
         ASM
          {$IFDEF FLAT386}
           LEA EDX,Q
           MOV AX,[EDX].EditorApp.ModeSub
           OR  AX,AX
           JZ  @End
           LEA EDX,[EDX].EditorApp.DBMainWord.CurrRec
           AND AX,[EDX+1]
           JZ  BasInstr
          {$ELSE}
           LES DI,Q
           MOV AX,ES:[DI].EditorApp.ModeSub
           OR  AX,AX
           JZ  @End
           LES DI,ES:[DI].EditorApp.DBMainWord.CurrRec
           AND AX,ES:[DI+1]
           JZ  BasInstr
          {$ENDIF}
@End:    END;
         SetKrResWd;
         Inc(PtrRec(Q.DBMainWord.CurrRec).Ofs,3);
         XCmp:=Length(Q.DBMainWord.CurrRec.Str^);
         I:=J+XCmp;
         Systems._Left(Str,XCmp)
        End
         Else
	Begin
 BasInstr:If DBLocateAbsIM(Q.DBInstr,2,UStr,[])Then Begin
          ASM
           {$IFDEF FLAT386}
            LEA EDX,Q
            MOV AX,[EDX].EditorApp.ModeSub
            OR  AX,AX
            JZ  @End
            LEA EDX,[EDX].EditorApp.DBInstr.CurrRec
            AND AX,[EDX+1]
            JZ  BasFunc
           {$ELSE}
            LES DI,Q
            MOV AX,ES:[DI].EditorApp.ModeSub
            OR  AX,AX
            JZ  @End
            LES DI,ES:[DI].EditorApp.DBInstr.CurrRec
            AND AX,ES:[DI+1]
            JZ  BasFunc
           {$ENDIF}
@End:     END;
          SetKrDef;
          Inc(PtrRec(Q.DBInstr.CurrRec).Ofs,3);
          XCmp:=Length(Q.DBInstr.CurrRec.Str^);
          I:=J+XCmp;
          Systems._Left(Str,XCmp)
         End
          Else
 BasFunc:If DBLocateAbsIM(Q.DBFunc,2,UStr,[])Then Begin
          ASM
           {$IFDEF FLAT386}
            LEA EDX,Q
            MOV AX,[EDX].EditorApp.ModeSub
            OR  AX,AX
            JZ  @End
            LEA EDX,[EDX].EditorApp.DBFunc.CurrRec
            AND AX,[EDX+1]
            JZ  BasNone
           {$ELSE}
            LES DI,Q
            MOV AX,ES:[DI].EditorApp.ModeSub
            OR  AX,AX
            JZ  @End
            LES DI,ES:[DI].EditorApp.DBFunc.CurrRec
            AND AX,ES:[DI+1]
            JZ  BasNone
           {$ENDIF}
@End:     END;
          Q.W.CurrColor:=(CurrKrs.Editor.Env.Normal and$F0)+$7;
          Inc(PtrRec(Q.DBFunc.CurrRec).Ofs,3);
          XCmp:=Length(Q.DBFunc.CurrRec.Str^);
          I:=J+XCmp;
          Systems._Left(Str,XCmp)
         End
	 Else BasNone:Q.W.CurrColor:=CurrKrs.Editor.Env.AsmInst;
	End;
       End;
       PutText(Str);
      End;
      SetKrDef;
      Continue;
     End;
     '%','$','!':Begin
      Q.W.CurrColor:=CurrKrs.Editor.Env.AsmInst;
      __Put;
      SetKrDef;
     End;
     '[',']','(',')',',',';','^','-','+','=',':','*','/','<','>','\':PutSymbol;
     '"' :PutBasicString;
     ^Z :PutZ;
     Else __Put;
    End;
   End;
  End;
   { Interpr‚tation de la syntaxe du langage Cobol }
  vtCobol:Begin
   I:=0;
   While PC^[I]<>#0do Begin
    Case PC^[I]of
     '*':If I=6Then Begin
      SetKrRem;
      While PC^[I]<>#0do __Put;
      SetKrDef;
     End
      Else
     __Put;
     '"':PutCString;
     '''':PutPascalString;
     '.','(',')':
     PutSymbol;
     '0'..'9':Begin
      Q.W.CurrColor:=CurrKrs.Editor.Env.Number;
      __Put;
      SetKrDef;
     End;
     'A'..'Z','a'..'z':Begin
      Str:=CobolXtrkWord(I,PC);
      UStr:=StrUp(Str);
      If DBLocateAbsIM(Q.DBMainWord,2,UStr,[])Then Begin
       ASM
        {$IFDEF FLAT386}
         LEA EDX,Q
         MOV AX,[EDX].EditorApp.ModeSub
         OR  AX,AX
         JZ  @End
         LEA EDX,[EDX].EditorApp.DBMainWord.CurrRec
         AND AX,[EDX+2]
         JZ  NotCobolMainWord
        {$ELSE}
         LES DI,Q
         MOV AX,ES:[DI].EditorApp.ModeSub
         OR  AX,AX
         JZ  @End
         LES DI,ES:[DI].EditorApp.DBMainWord.CurrRec
         AND AX,ES:[DI+2]
         JZ  NotCobolMainWord
        {$ENDIF}
@End:  END;
       SetKrResWd;
      End
       Else
      Begin
       NotCobolMainWord:SetKrDef
      End;
      PutText(Str);
      SetKrDef;
     End;
     ^Z:PutZ;
     Else __Put;
    End;
   End;
  End;
   { Interpr‚tation des formats de fichiers de configuration }
  vtIni:Begin
   I:=0;
   While PC^[I]<>#0do Begin
    Case PC^[I]of
     '=':Begin
      PutSymbol;
      SetKrResWd;
      While PC^[I]<>#0do Case PC^[I]of
       '{','}','(',')',',',';','^','-','+',':','*','/','<','>','\':Begin
	PutSymbol;SetKrResWd;
       End;
       '"': PutBasicString;
       '.','0'..'9':Begin
	Q.W.CurrColor:=CurrKrs.Editor.Env.Number;
	__Put;
	While(PC^[I]in ArabicDigit)do __Put;
	SetKrResWd;
       End;
       Else __Put;
      End;
      SetKrDef;
     End;
   ';':Begin
      SetKrRem;
      While PC^[I]<>#0do __Put;
      SetKrDef;
     End;
   '[':Begin
      Q.W.CurrColor:=CurrKrs.Editor.Env.AsmInst;
      While PC^[I]<>#0do __Put;
      SetKrDef;
     End;
     '"': PutBasicString;
     'A'..'Z','a'..'z','_':Begin
      Str:=PXtrkWord(I,PC);
      SetKrDef;
      PutText(Str)
     End;
     ^Z: PutZ;
     Else __Put;
    End;
   End;
  End;
   { Interpr‚tation de la syntaxe du format C et compagnie...}
  vtRC,vtC,vtMacro,vtSQL:Begin
   I:=0;
   While PC^[I]<>#0do Begin
    Case PC^[I]of
     '/':Begin
      SetKrRem;
      Case PC^[I+1]of
       '/':While PC^[I]<>#0do __Put;
       '*':Begin
        __Put;__Put;
	While PC^[I]<>#0do Begin
	 If(PC^[I]='*')and(PC^[I+1]='/')Then Begin
	  __Put;__Put;
	  Break;
	 End;
	 __Put;
        End;
       End;
       Else Begin
        Q.W.CurrColor:=CurrKrs.Editor.Env.Symbol;
	__Put;
       End;
      End;
      SetKrDef;
     End;
     'A'..'Z','a'..'z','_':Begin
      Str:=PXtrkWord(I,PC);
      Repeat
        {Ne pas mettre de chaŒne  de caractŠres  en majuscule car le
         table de comparaison est en minuscule comme l'est le C/C++.}
       If DBLocateAbsIM(Q.DBMainWord,2,Str,[])Then Begin
        ASM
         {$IFDEF FLAT386}
          LEA EDX,Q
          MOV AX,[EDX].EditorApp.ModeSub
          OR  AX,AX
          JZ  @End
          LEA EDX,[EDX].EditorApp.DBMainWord.CurrRec
          AND AX,[EDX+1]
          JZ  NotCMainWord
         {$ELSE}
          LES DI,Q
          MOV AX,ES:[DI].EditorApp.ModeSub
          OR  AX,AX
          JZ  @End
          LES DI,ES:[DI].EditorApp.DBMainWord.CurrRec
          AND AX,ES:[DI+1]
          JZ  NotCMainWord
         {$ENDIF}
 @End:  END;
        SetKrResWd;
        If Q.DBMainWord.CurrRec.Byte^=1Then Begin { 'asm'? }
	 PutText(Str);
	 Q.W.CurrColor:=CurrKrs.Editor.Env.AsmInst;
	 While PC^[I]<>#0do __Put;
	 Break;
        End;
       End
        Else
       Begin
        NotCMainWord:SetKrDef;
       End;
       PutText(Str);
      Until True;
      SetKrDef;
     End;
     '0'..'9':Begin
      Q.W.CurrColor:=CurrKrs.Editor.Env.Number;
      PutText(PXtrkCNm(I,PC));
      SetKrDef;
     End;
     '{','}':Begin
      SetKrResWd;
      __Put;
      SetKrDef;
     End;
     '[',']','(',')',',','.',';','|','^','$','?','-','+','=',
     ':','*','%','!','~','&','<','>','\':PutSymbol;
     '#':Begin
      SetKrRem;
      J:=I;
      While Not(PC^[I]in[#0..' '])do __Put;
      SetKrDef;
     End;
     '"':PutCString;
     '''':PutCChar;
     ^Z:PutZ;
     Else __Put;
    End;
   End;
  End;
   { Interpr‚tation du langage Euphoria, PostScript,...}
  vtEuphoria:Begin
   I:=0;
   While PC^[I]<>#0do Begin
    Case PC^[I]of
     '-':Begin
      If PC^[I+1]='-'Then Begin
       SetKrRem;
       While PC^[I]<>#0do __Put;
      End
       Else
      Begin
       Q.W.CurrColor:=CurrKrs.Editor.Env.Symbol;
       __Put;
      End;
      SetKrDef;
     End;
     '"':PutCString;
     '''':PutCChar;
     '@',':',',','.','(',')','[',']','<','>','=','+','#','!','&','*','%','/','{','}':
     PutSymbol;
     '0'..'9':Begin
      Q.W.CurrColor:=CurrKrs.Editor.Env.Number;
      __Put;
      While(PC^[I]in ArabicXDigit)do __Put;
      SetKrDef;
     End;
     'A'..'Z','a'..'z','_':Begin
      Str:=PXtrkWord(I,PC);UStr:=StrUp(Str);
      If DBLocateAbsIM(Q.DBMainWord,2,UStr,[])Then Begin
       SetKrResWd;
       PutText(Str);
       If Q.DBMainWord.CurrRec.Byte^=$0EThen Begin
        Q.W.CurrColor:=CurrKrs.Editor.Env.Chars;
        While PC^[I]<>#0do __Put;
       End;
      End
       Else
      Begin
       SetKrDef;
       PutText(Str);
      End;
      SetKrDef;
     End;
     ^Z: PutZ;
     Else __Put;
    End;
   End;
  End;
   {Interpr‚tation du langage Fortran }
  vtFortran:Begin
   I:=0;
   While PC^[I]<>#0do Begin
    Case PC^[I]of
     'C':If I=0Then Goto FR
               Else ResWd;
     '*':Begin
      If I=0Then Begin
    FR:SetKrRem;
       While PC^[I]<>#0do __Put;
       SetKrDef;
      End
       Else
      PutSymbol;
     End;
     '''':PutPascalString;
     '[',']','\','/','-','<','>','+','^','&','(',')','.',',','?','=','%','@',':',';':
     PutSymbol;
     '0'..'9':Begin
      Q.W.CurrColor:=CurrKrs.Editor.Env.Number;
      __Put;
      SetKrDef;
     End;
     'A','B','D'..'Z','a'..'z','_':ResWd;
     ^Z:PutZ;
     Else __Put;
    End;
   End;
  End;
   {Interpr‚tation du langage Pascal, Delphi,...}
  vtPas:Begin
   I:=0;
   While PC^[I]<>#0do Begin
    Case PC^[I]of
     '{':Begin
      SetKrRem;
      While Not(PC^[I]in[#0,'}'])do __Put;
      If PC^[I]='}'Then __Put;
      SetKrDef;
     End;
     '(':Begin
      If PC^[I+1]='*'Then Begin
       SetKrRem;
       Inc(I,2);
       PutText('(*');
       While PC^[I]<>#0do Begin
	If(PC^[I]='*')and(PC^[I+1]=')')Then Begin
	 Inc(I,2);
	 PutText('*)');
	 Break;
	End;
	__Put;
       End;
      End
       Else
      PutSymbol;
     End;
     '[',']','\','/','-','<','>','*','+','^','&',')','.',',','?','=','%','@',':',';':
     PutSymbol;
     '#':Begin
      Q.W.CurrColor:=CurrKrs.Editor.Env.Chars;
      __Put;
      Case PC^[I]of
       '$': Goto PS;
       Else While(PC^[I]in ArabicDigit)do __Put;
      End;
      SetKrDef;
     End;
     '$':Begin
      Q.W.CurrColor:=CurrKrs.Editor.Env.Number;
   PS:__Put;
      While(PC^[I]in ArabicXDigit)do __Put;
      SetKrDef;
     End;
     '0'..'9':Begin
      Q.W.CurrColor:=CurrKrs.Editor.Env.Number;
      __Put;
      SetKrDef;
     End;
     '''':PutPascalString;
     'A'..'Z','a'..'z','_':ResWd;
     ^Z:PutZ;
     Else __Put;
    End;
   End;
  End;
   { Interpr‚tation des fichiers Batch du DOS}
  vtBatch:Begin
   I:=0;
   While PC^[I]<>#0do Begin
    Case PC^[I]of
     '[',']','\','/','-','<','>','*','+','^','&','(',')','.',',','?','=','%','@',':',';':
     PutSymbol;
     '0'..'9':Begin
      Q.W.CurrColor:=CurrKrs.Editor.Env.Number;
      __Put;
      SetKrDef;
     End;
     'A'..'Z','a'..'z','_':Begin
      J:=I;
      Str:=PXtrkWord(I,PC);
      UStr:=StrUp(Str);
      If DBLocateAbsIM(Q.DBMainWord,2,UStr,[])Then Begin
       ASM
        {$IFDEF FLAT386}
         LEA EDX,Q
         MOV AX,[EDX].EditorApp.ModeSub
         OR  AX,AX
         JZ  @End
         LEA EDX,[EDX].EditorApp.DBMainWord.CurrRec
         AND AX,[EDX+1]
         JZ  NotMainWordBatch
        {$ELSE}
         LES DI,Q
         MOV AX,ES:[DI].EditorApp.ModeSub
         OR  AX,AX
         JZ  @End
         LES DI,ES:[DI].EditorApp.DBMainWord.CurrRec
         AND AX,ES:[DI+1]
         JZ  NotMainWordBatch
        {$ENDIF}
@End:  END;
       SetKrResWd;
       Case(Q.DBMainWord.CurrRec.Byte^)of
        $00:Begin { REM }
         I:=J;
         SetKrRem;
         While PC^[I]<>#0do __Put;
         Goto OutCaseBatch;
        End;
        $13:Begin { ECHO }
         PutText(Str);
         Q.W.CurrColor:=CurrKrs.Editor.Env.Chars;
         While PC^[I]<>#0do __Put;
        End;
       End;
      End
       Else
      Begin
       NotMainWordBatch:SetKrDef;
      End;
      PutText(Str);
OutCaseBatch:
      SetKrDef;
     End;
     ^Z:PutZ;
     Else __Put;
    End;
   End;
  End;
  vtHTMLSourceCode:Begin { Interpr‚tation du code HTML }
   I:=0;
   While PC^[I]<>#0do Begin
    Case PC^[I]of
     '<':If PC^[I+1]='!'Then Begin
      SetKrRem;
      While Not(PC^[I]in[#0,'>'])do __Put;
      If PC^[I]='>'Then __Put;
      SetKrDef;
     End
      Else
     Begin
      SetKrResWd;
      While Not(PC^[I]in[#0,'>'])do Begin
       If PC^[I]='"'Then Begin
        If(Q.W.CurrColor=CurrKrs.Editor.Env.Chars)Then Begin
         __Put;
         SetKrResWd;
        End
         Else
        Begin
         Q.W.CurrColor:=CurrKrs.Editor.Env.Chars;
         __Put;
        End;
       End
        Else
       __Put;
      End;
      If PC^[I]='>'Then __Put;
      SetKrDef;
     End;
     Else __Put;
    End;
   End;
  End;
  Else Begin
   Q.W.CurrColor:=CurrKrs.Editor.Env.Normal;
   If(Q.ScrollLock)Then Begin
    I:=0; {Str:='';}
    While PC^[I]<>#0do __Put;{Begin
     If Length(Str)<250Then IncStr(Str,PC^[I])
      Else
     Begin
      PutText(Str);
      Str:='';
     End;
     Inc(I);
    End;
    If I>0Then PutText(Str);}
   End
    Else
   WEPutPTxtXY2(Q.W,0,Q.W.Y,I1,PC);
  End;
 End;
 If(MarkEnd)Then Begin
  If(Q.W.MaxX>Q.W.X){$IFNDEF GraphicOS}and Not(HoleMode){$ENDIF}Then Begin
   {$IFDEF Adele}
    UnSelIcon(WEGetRealX(Q.W),WEGetRealY(Q.W),(Q.W.CurrColor and $F0)+3);
    If(IsLuxe)Then Inc(Q.W.X,2)Else Inc(Q.W.X,3);
   {$ELSE}
    Str:=UnSelIcon;
    If(Q.W.X+Length(Str)>Q.W.MaxX)Then Str[0]:=Chr(Q.W.MaxX-Q.W.X);
    PutTxtLuxe(WEGetRealX(Q.W),WEGetRealY(Q.W),Str,(Q.W.CurrColor and $F0)+3);
    Inc(Q.W.X,Length(UnSelIcon));
   {$ENDIF}
  End;
 End;
 WEClrEol(Q.W);
 If(Q.BY1<=P)and(Q.BY2>=P)Then Begin
  Q.W.CurrColor:=$6E;
  If(Q.BY1=Q.BY2)Then Begin
   If(Q.BX1<Q.BX2)Then Begin
    If I1>0Then WEBarSelHor(Q.W,0,Q.W.Y,Q.BX2-I1-1)
           Else WEBarSelHor(Q.W,Q.BX1,Q.W.Y,Q.BX2-I1-1);
   End;
  End
   Else
  Begin
   If(P=Q.BY1)Then WEBarSelHor(Q.W,Q.BX1-I1,Q.W.Y,wnMax)Else
   If(P=Q.BY2)Then WEBarSelHor(Q.W,0,Q.W.Y,Q.BX2-I1-1)
   Else WEBarSelHor(Q.W,0,Q.W.Y,wnMax);
  End;
  Q.W.CurrColor:=CurrKrs.Editor.Env.Normal;
 End;
 WELn(Q.W);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                     Proc‚dure _TEPutLnGat                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: Edt
 Portabilit‚:  Local (appel global)


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure affiche la ligne sp‚cifi‚ en format "Gat" dans un
 traŒtement de texte de l'objet d'‚dition.
}

Procedure _TEPutLnGat;
Label Xit;
Var
 Str,UStr:String;
 I,J,K,I2:Word;
 Ok:Boolean;
 PDrw:^DrawInEdt;
 PLineHor:^LineHorInEdt Absolute PDrw;
 Handle:Hdl;
 TGX1,GX1,GY1:Integer;
 Len,SizeBuf:Word;
 {Ofs:LongInt;}
 TBuf,Buf:^TByte;
 OldY:Byte;
Begin
 If(Not(HoleMode))and(Q.Processus.Count>0)Then Begin
  ALSetPtr(Q.Processus,0);
  For I:=0to Q.Processus.Count-1do Begin
   PDrw:=_ALGetCurrBuf(Q.Processus);
   If(PDrw<>NIL)Then Begin
    If(PDrw^.Y1<=P)and(PDrw^.Y2>P)Then Case(PDrw^.Model)of
     mtImage:Begin
      WEClrEol(Q.W);
      TGX1:=WEGetRX1(Q.W);
      GX1:=((TGX1+(((Q.SheetFormat.X2-Q.SheetFormat.X1)shr 1)+Q.SheetFormat.X1))shl 3);
      Dec(GX1,PDrw^.GPX.Len shr 1);
      GY1:=GetRawY(WEGetRY1(Q.W)+Q.W.Y);
      TGX1:=TGX1 shl 3;
      Dec(GX1,I1 shl 3);
      If(TGX1>GX1)Then Begin
       GX1:=TGX1;I2:=I1;
      End
       Else
      I2:=0;
      Len:=((WEGetRX1(Q.W)+Q.W.MaxX+1)shl 3)-GX1;
      RIPutImageLine(PDrw^.Res,GX1,GY1,I2,Len,P-PDrw^.Y1);
      WELn(Q.W);
      Exit;
     End;
     mtLineHor:Begin
      WEClrEol(Q.W);
      WEPutTxtXY(Q.W,Q.SheetFormat.X1,Q.W.Y,MultChr(PLineHor^.Bar,Q.SheetFormat.X2-Q.SheetFormat.X1));
      WELn(Q.W);
      Exit;
     End;
    End;
   End;
   ALNext(Q.Processus);
  End;
 End;
 If(PC<>NIL)Then If(Size>I1)Then Begin
  If(Q.Mode=vtHlp)Then WESetKrBorderF(Q.W,$7)
                  Else Q.W.CurrColor:=CurrKrs.Editor.Env.Typewriter;
  I:=0;K:=0;
  While PC^[K]<>#0do Begin
   Case PC^[K]of
    #1..#31:Begin{ Attr ? }
     Inc(K);
     {$IFDEF FLAT386}
      If PC^[K]<>#0Then Begin
       WEPutChrGAttr(Q.W,PC^[K],Byte(PC^[K-1]));
       If TEIsDbl(PC^[K-1])Then Inc(I);
       Inc(K);Inc(I);
      End;
     {$ELSE}
      ASM
       {If PC^[K]<>#0Then Begin
         WEPutChrGAttr(Q.W,PC^[K],Byte(PC^[K-1]));
         If TEIsDbl(PC^[K-1])Then Inc(I);
         Inc(K);Inc(I);
        End;}
       LES DI,Q
       PUSH ES
       ADD DI,Offset EditorApp.W
       PUSH DI
       LES DI,PC
       ADD DI,K
       MOV AL,ES:[DI]
       OR  AL,AL
       JNZ @1
       ADD SP,4 { Mise … jour de la pile}
       JMP @End
@1:    PUSH AX
       DEC DI
       MOV AL,ES:[DI]
       TEST AL,cgDouble
       JE  @2
       INC I
@2:    PUSH AX
       CALL WEPutChrGAttr
       INC K
       INC I
 @End:END;
     {$ENDIF}
    End;
    Else Begin
     If(I>=I1)Then Begin
      If I-I1>=255Then Goto Xit;
      OldY:=Q.W.Y;
      If(Q.ScrollLock)Then Begin
       If(ViewOutZone)and((I<Q.SheetFormat.X1)or(I>Q.SheetFormat.X2))Then
        _WESetCube(Q.W,I-I1,Q.W.Y,PC^[K],CurrKrs.Editor.OutZone)
       Else
        WESetCube(Q.W,I-I1,Q.W.Y,PC^[K]);
      End
       else
      WESetCube(Q.W,I-I1,Q.W.Y,PC^[K]);
      Q.W.Y:=OldY;
     End;
     Inc(I);Inc(K);
    End;
   End;
  End;
  If(MarkEnd)Then Begin
   If((K>0)and(PC^[K-1]=' '))or(I>=Q.SheetFormat.X2)Then Begin
    If(Q.W.MaxY>=Q.W.Y)and(Q.W.MaxX>Q.W.X)
      {$IFNDEF GraphicOS}and Not(HoleMode){$ENDIF}Then Begin
     UnSelIcon(WEGetRealX(Q.W),WEGetRealY(Q.W),(Q.W.CurrColor and $F0)+3);
     If(IsLuxe)Then Inc(Q.W.X,2)Else Inc(Q.W.X,3);
    End;
   End;
  End;
 End;
 WEClrEol(Q.W);
 If(Q.BY1<=P)and(Q.BY2>=P)Then Begin
  Q.W.CurrColor:=$6E;
  If(Q.BY1=Q.BY2)Then Begin
   If(Q.BX1<Q.BX2)Then Begin
    If I1>0Then WEBarSelHor(Q.W,0,Q.W.Y,Q.BX2-I1-1)
           Else WEBarSelHor(Q.W,Q.BX1,Q.W.Y,Q.BX2-I1-1);
   End;
  End
   Else
  Begin
   If(P=Q.BY1)Then WEBarSelHor(Q.W,Q.BX1-I1,Q.W.Y,wnMax)Else
   If(P=Q.BY2)Then WEBarSelHor(Q.W,0,Q.W.Y,Q.BX2-I1-1)
   Else WEBarSelHor(Q.W,0,Q.W.Y,wnMax);
  End;
  Q.W.CurrColor:=CurrKrs.Editor.Env.Typewriter;
 End;
Xit:
 WELn(Q.W);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Proc‚dure _TEPutWn                           Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: EditorApp
 Portabilit‚:  Local


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure affiche la basse de la fenˆtre avec les paramŠtres par
 d‚faut  contenu  dans  l'objet  d'‚dition  du traŒtement  de texte sans
 r‚actualiser son contenu en texte ‚crit par l'utilisateur.
}

Procedure _TEPutWn;
Var
 X:Byte;
 S:String; { ChaŒne de caractŠres devant recevoir le titre de la fenˆtre }
Begin
 Include(Q.W.Attribut,winNotClearBackground);
 Include(Q.W.Attribut,winNotBorderDown);
 Include(Q.W.Attribut,winNotBorderRight);
 If(Q.Mode=vtHlp)Then WEPutWn(Q.W,Q.Title,CurrKrs.Help.Window)
  Else
 Begin
  If Length(Q.EditName)=0Then S:='Pasnom'
                         Else S:=TruncName(Q.EditName,Q.W.MaxX);
  WEPutWn(Q.W,S,CurrKrs.Editor.Window);
 End;
 WECloseIcon(Q.W);
 WEZoomIcon(Q.W);
 WEPutBarMsRight(Q.W);
 If Not((eNoRules)in(Q.Option))Then Begin
  If Not(HoleMode)Then Begin
   X:=WEGetRX1(Q.W);
   BarSpcHor(X,Q.W.T.Y2-1,X+Q.W.MaxX,Q.W.Palette.Border);
  End;
 End;
{ If(Edt(Q).Mode in[vtGat,vtBas])and(IsGraf)Then Begin
  Include(Q.Option,eBarUp);
 End;}
 If(eBarUp)in(Q.Option)Then Begin
  WESetHomeLine(Q.W,2);
 End;
End;

{$I \Source\Chantal\_TESetMo.INC}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ·}
{³                    Z o n e  P u b l i q u e                 º}
{ÔÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Proc‚dure TEBoldWord                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: EditorApp


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure modifie le mot courant pour qu'il soit en format gras
 seulement. S'il se trouve sur un espace, il affecte le mot pr‚c‚dent.
}

Procedure TEBoldWord;Begin
 TESetWord(Q,cgBold)
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure TEChkMaxLen                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: EditorApp


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure met … jour la longueur de la ligne la plus longue ‚crite
 dans le traŒtement de texte de l'objet d'‚dition.
}

Procedure TEChkMaxLen;Begin
 If L=255Then Exit;
 If(Q.StrMX<L)Then Q.StrMX:=L
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Proc‚dure TEDelCurrLn                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: EditorApp


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure efface la ligne courante du traŒtement de texte de l'objet
 d'‚dition. S'il est rendu … la derniŠre ligne, il fait qu'effacer la ligne.
}

Procedure TEDelCurrLn;
Var
 Size:Word; { Taille de la ligne effacer }
Begin
 ALDelBufNSize(Q.List,Q.P,Size);
 If(Q.P=Q.List.Count)Then ALAddLn(Q.List);
 TESetPtr(Q);
 Dec(Q.FileSize,Size);
 TEUpDateEOS(Q);
 TEUpDateInfo(Q);
 _TESetModified(Q)
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure TEDelSpc                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: EditorApp


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure efface  tous les lignes espaces jusqu'au prochain mot
 dans la liste contenu dans le traŒtement de texte de l'objet d'‚dition
 de cette unit‚.  Elle utilis‚ par le raccourcis clavier  ®Ctrl+S¯  par
 ®ISABEL.KEY¯.
}

Procedure TEDelSpc;Var
 PC:PChr; { Pointeur sur la ligne de traŒtement de texte courante }
 I:Word;  { Variable compteur de boucle }
Begin
 If(Q.ReadOnly)Then Exit;
 If(Q.Mode<>vtGat)Then Q.PXG:=Q.PX;
 PC:=TEPopCurr(Q);
 If(PC=NIL)Then Exit;
 I:=Q.PXG;
 If PC^[I]=#0Then TEkDel(Q)
  Else
 Begin
  While PC^[I]=' 'do Inc(I);
  Dec(Q.FileSize,LongInt(I-Q.PXG));
  StrDel(PC,Q.PXG,I-Q.PXG);
  TEUpDateLn(Q);
  TEUpDateInfo(Q);
  _TESetModified(Q)
 End
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Proc‚dure TEDelWord                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: EditorApp


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure efface  un mot  s'il  y en  a un  imm‚diatement … la
 position du curseur, sinon il efface tous les lignes espaces jusqu'au
 prochain mot dans  la liste contenu  dans  le traŒtement  de texte de
 l'objet  d'‚dition  de cette  unit‚.  Elle utilis‚  par le raccourcis
 clavier ®Ctrl+T¯ par ®ISABEL.KEY¯.
}

Procedure TEDelWord;
Var
 PC:PChr; { Pointeur sur la ligne du traŒtement de texte courant }
 I:Word;  { Variable compteur de boucle }
Begin
 If(Q.ReadOnly)Then Exit;
 If(Q.Mode<>vtGat)Then Q.PXG:=Q.PX;
 PC:=TEPopCurr(Q);
 If(PC=NIL)Then Exit;
 I:=Q.PXG;
 If PC^[I]=#0Then TEkDel(Q)
  Else
 Begin
  If PC^[I]=' 'Then While PC^[I]=' 'do Inc(I)
               Else While Not(PC^[I]in[#0,' '])do Inc(I);
  Dec(Q.FileSize,LongInt(I-Q.PXG));
  StrDel(PC,Q.PXG,I-Q.PXG);
  TEUpDateLn(Q);
  TEUpDateInfo(Q);
  _TESetModified(Q)
 End
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure TEDoubleWord                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: EditorApp


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure modifie le mot courant pour qu'il soit en format double
 largeur seulement.  S'il se trouve  sur  un  espace,  il affecte  le mot
 pr‚c‚dent.
}

Procedure TEDoubleWord;Begin
 TESetWord(Q,cgDouble)
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure TEEndText                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: EditorApp


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure d‚place le pointeur du texte … la fin complŠtement du
 texte.  Elle adapte  naturellement  les donn‚es  visuel  et interne en
 cons‚quence.
}

Procedure TEEndText;Begin
 If(Q.List.Count<Q.W.MaxY)Then TEHomeText(Q)
  Else
 Begin
  If(Q.P>=Q.List.Count-1)and(Q.Y>=Q.W.MaxY)Then Exit;
  If(Q.P=Q.List.Count-Q.W.MaxY)Then Begin
   Q.Y:=Q.W.MaxY;
   Q.P:=Q.List.Count-1;
  End
   Else
  Begin
   Q.Y:=0;
   Q.P:=Q.List.Count-Q.W.MaxY;
  End;
  TESetCur(Q);
  TESetPtr(Q);
  TEPutPos(Q);
  TEUpDateScr(Q);
  WESelRightBarPos(Q.W,Q.P,Q.List.Count-1);
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure TEExposantWord                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: EditorApp


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure modifie le mot courant pour qu'il soit en format exposant
 seulement. S'il se trouve sur un espace, il affecte le mot pr‚c‚dent.
}

Procedure TEExposantWord;Begin
 TESetWord(Q,cgExposant)
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Fonction TEGetCurrChr                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: EditorApp


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction indique  quel est le  caractŠre courant dans une chaŒne de
 caractŠres de format GAT  de la ligne courante en calculant … partir de la
 colonne courante de la fenˆtre de l'‚diteur.
}

Function TEGetCurrChr;
Var
 PC:PChr; { Pointeur sur la ligne de traŒtement de texte courant }
 L:Word;  { Longueur physique de la ligne de traŒtement de texte courant }
Begin
 TEGetCurrChr:=#0;
 PC:=TEPopCurr(Q);
 L:=StrLen(PC);
 If(L>=Q.PX)Then Begin
  If Q.Mode in[vtGat,vtHlp]Then TEGetCurrChr:=PC^[Q.PXG]
                           Else TEGetCurrChr:=PC^[Q.PX]
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Fonction TEGetLastChr                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: EditorApp


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction indique quel est le caractŠre pr‚c‚dent dans une chaŒne de
 caractŠres de format GAT  de la ligne courante en calculant … partir de la
 colonne courante de la fenˆtre de l'‚diteur.
}

Function TEGetLastChr;
Var
 PC:PChr; { Pointeur sur la ligne de traŒtement de texte courant }
 L:Word;  { Longueur physique de la ligne de traŒtement de texte courant }
Begin
 TEGetLastChr:=#0; { Fixe par d‚faut un caractŠre de fin }
 PC:=TEPopCurr(Q);
 L:=StrLen(PC);
 If(Q.PX>0)and(L>0)and(L>=Q.PX)Then Begin
  If Q.Mode in[vtGat,vtHlp]Then TEGetLastChr:=PC^[Q.PXG-1]
                           Else TEGetLastChr:=PC^[Q.PX-1]
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Fonction TEGetNextChr                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: EditorApp


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction indique  quel est le  caractŠre suivant dans une chaŒne de
 caractŠres de format GAT  de la ligne courante en calculant … partir de la
 colonne courante de la fenˆtre de l'‚diteur.
}

Function TEGetNextChr;
Var
 PC:PChr; { Pointeur sur la ligne de traŒtement de texte courant }
 L:Word;  { Longueur physique de la ligne de traŒtement de texte courant }
Begin
 TEGetNextChr:=#0; { Fixe par d‚faut un caractŠre de fin }
 PC:=TEPopCurr(Q);
 L:=StrLen(PC);
 If L>=Q.PX+1Then Begin
  If Q.Mode in[vtGat,vtHlp]Then TEGetNextChr:=PC^[Q.PXG+1]
                           Else TEGetNextChr:=PC^[Q.PX+1];
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Fonction TEGetViewMode                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: EditorApp


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction retourne le mode d'‚dition (Document, Pascal, C/C++,...) en
 cours dans le traŒtement de texte.
}

Function TEGetViewMode;
{$IFDEF NoAsm}
 Begin
  TEGetViewMode:=Q.Mode;
 End;
{$ELSE}
 Assembler;ASM
  {$IFDEF FLAT386}
   MOV EAX,Q
   MOV AL,[EAX].EditorApp.Mode
  {$ELSE}
   LES DI,Q
   MOV AL,ES:[DI].EditorApp.Mode
  {$ENDIF}
 END;
{$ENDIF}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Proc‚dure TEHomeText                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: EditorApp


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure d‚place le pointeur du texte au d‚but complŠtement du
 texte.  Elle  adapte naturellement  les donn‚es visuel  et  interne en
 cons‚quence.
}

Procedure TEHomeText;Begin
 If Q.P or Q.Y>0Then Begin
  Q.Y:=0;Q.P:=0;
  TESetCur(Q);
  ALSetPtr(Q.List,0);
  Q.CurrPtr:=ALPushCurrPtr(Q.List);
  TEPutPos(Q);
  TEUpDateScr(Q);
  WESelRightBarPos(Q.W,Q.P,Q.List.Count-1);
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Proc‚dure TEInitCoord                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: EditorApp


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure initialise toutes les coordonn‚es du traŒtement de texte …
 celle d'orgine  mais sans affecter l'affichage.  Il s'occupe aussi bien des
 positions du bloque que cele du curseur ou de la fenˆtre de ®ScrollLock¯.
}

Procedure TEInitCoord;
{$IFDEF NotReal}
 Begin
  Q.X:=0;
  Q.Y:=0;
  Q.P:=0;
  Q.PX:=0;
  Q.PXG:=0;
  Q.SheetFormat.X1:=0;
  Q.SheetFormat.X2:=65520;
  Q.SheetFormat.Y1:=0;
  Q.SheetFormat.Y2:=214783647;
  Q.BX1:=0;
  Q.BY1:=0;
  Q.BX2:=0;
  Q.BY2:=0;
 End;
{$ELSE}
 Assembler;ASM
  LES DI,Q
  XOR AX,AX
  MOV EditorApp(ES:[DI]).X.Word,AX {X&Y}
  MOV EditorApp(ES:[DI]).P.Word,AX
  {$IFDEF DPMI}
   MOV EditorApp(ES:[DI]).P.Word[2],AX
  {$ENDIF}
  MOV EditorApp(ES:[DI]).PX,AX
  MOV EditorApp(ES:[DI]).PXG,AX
  MOV EditorApp(ES:[DI]).SheetFormat.X1,AX
  MOV EditorApp(ES:[DI]).SheetFormat.X2,65520
  MOV EditorApp(ES:[DI]).SheetFormat.Y1.Word,AX
  {$IFDEF DPMI}
   MOV EditorApp(ES:[DI]).SheetFormat.Y1.Word[2],AX
   MOV EditorApp(ES:[DI]).SheetFormat.Y2.Word,214783647 and $FFFF
   MOV EditorApp(ES:[DI]).SheetFormat.Y2.Word[2],214783647 shr 16
  {$ELSE}
   MOV EditorApp(ES:[DI]).SheetFormat.Y2,$FFFF
  {$ENDIF}
  MOV EditorApp(ES:[DI]).BX1,AX
  MOV EditorApp(ES:[DI]).BY1.Word,AX
  {$IFDEF DPMI}
   MOV EditorApp(ES:[DI]).BY1.Word[2],AX
  {$ENDIF}
  MOV EditorApp(ES:[DI]).BX2,AX
  MOV EditorApp(ES:[DI]).BY2.Word,AX
  {$IFDEF DPMI}
   MOV EditorApp(ES:[DI]).BY2.Word[2],AX
  {$ENDIF}
 END;
{$ENDIF}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure TEInitLang                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: EditorApp


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure charge une table de r‚f‚rence pour les mots r‚serv‚s de
 certains langage de programmation  et libŠre l'ancien m‚moire occup‚ par
 ceux-ci s'ils sont charg‚s en m‚moire.
}

Procedure TEInitLang;
Var
 XF:Word; { Num‚ro d'index dans la ressource … allou‚e }
Begin
 If(EditorApp(Q).Mode in[vtGat,vtBas])and(IsGraf)Then Begin
  Include(Q.Option,eBarUp);
 End;
 DBDispose(Q.DBInstr);
 DBDispose(Q.DBFunc);
 DBDispose(Q.DBMainWord);
 Repeat
  Case(Q.Mode)of
   vtAsm:Begin
    DBOpenServerName(ChantalServer,'CHANTAL:/CPU/Intel/Registre.Dat');
    DBCopyToMemory(ChantalServer,Q.DBFunc);
    DBOpenServerName(ChantalServer,'CHANTAL:/CPU/Intel/Instr.Dat');
    DBCopyToMemory(ChantalServer,Q.DBInstr);
    DBOpenServerName(ChantalServer,'CHANTAL:/CPU/Intel/MotsReserves.Dat');
   End;
   vtC,vtRC:DBOpenServerName(ChantalServer,'CHANTAL:/Compilateur/C/MotsReserves.Dat');
   vtCobol:DBOpenServerName(ChantalServer,'CHANTAL:/Compilateur/Cobol/MotsReserves.Dat');
   vtEuphoria:DBOpenServerName(ChantalServer,'CHANTAL:/Compilateur/Euphoria/MotsReserves.Dat');
   vtFortran:DBOpenServerName(ChantalServer,'CHANTAL:/Compilateur/Fortran/MotsReserves.Dat');
   vtPas:DBOpenServerName(ChantalServer,'CHANTAL:/Compilateur/Pascal/MotsReserves.Dat');
   vtBas:Begin
    DBOpenServerName(ChantalServer,'CHANTAL:/Compilateur/Basic/Fonction.Dat');
    DBCopyToMemory(ChantalServer,Q.DBFunc);
    DBOpenServerName(ChantalServer,'CHANTAL:/Compilateur/Basic/Instruction.Dat');
    DBCopyToMemory(ChantalServer,Q.DBInstr);
    DBOpenServerName(ChantalServer,'CHANTAL:/Compilateur/Basic/MotsReserves.Dat');
   End;
   vtMsMnu:DBOpenServerName(ChantalServer,'CHANTAL:/Materiel/Souris/PopMenu.Dat');
   vtBatch:DBOpenServerName(ChantalServer,'CHANTAL:/DOS/Prompt.Dat');
   vtSQL:DBOpenServerName(ChantalServer,'CHANTAL:/Compilateur/SQL/MotsReserves.Dat');
   Else Break;
  End;
  DBCopyToMemory(ChantalServer,Q.DBMainWord);
 Until True;
 If(Q.Mode)in[vtHlp,vtGat]Then Q._PutLn:=@_TEPutLnGat
                          Else Q._PutLn:=@_TEPutLn;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Proc‚dure TEInsChr                           Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: EditorApp


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction insŠre un caractŠre dans ligne de traŒtement de texte. Elle
 met … jour les donn‚es visuel.
}

Function TEInsChr;
Label Break;
Const
 MacInsChr:Array[0..2]of Char=macPutCurrLn+macIncFS2+#0;
 MacInsChr2:Array[0..2]of Char=macPutCurrLn+macIncFS+#0;
Var
 NewPBuf:PChr;
Begin
 TEInsChr:=False;
 If(Q.ReadOnly)Then Exit;
 NewPBuf:=StrNew(PC);
 If(NewPBuf=NIL)Then Exit;
 Repeat
  If(Q.Mode=vtGAT)Then Begin
   If(Q.ChrAttr>0)and(Chr<>' ')Then Begin
    ALPopCurrPtr(Q.List,Q.CurrPtr);
    PC:=ALSetCurrBuf(Q.List,L+3);
    If(PC=NIL)Then Exit;
    Q.CurrPtr:=ALPushCurrPtr(Q.List);
    MoveLeft(NewPBuf^,PC^,Q.PXG);
    PC^[Q.PXG]:=Char(Q.ChrAttr);
    PC^[Q.PXG+1]:=Chr;
    MoveLeft(NewPBuf^[Q.PXG],PC^[Q.PXG+2],L-Q.PXG);
    PC^[L+2]:=#0;
    TEMacro(Q,@MacInsChr);
    Goto Break
   End
  End
   Else
  Q.PXG:=Q.PX;
  ALPopCurrPtr(Q.List,Q.CurrPtr);
  PC:=ALSetCurrBuf(Q.List,L+2);
  If(PC=NIL)Then Exit;
  Q.CurrPtr:=ALPushCurrPtr(Q.List);
  StrCopy(PC,NewPBuf);
  StrInsChr(PC,Q.PXG,Chr);
  TEMacro(Q,@MacInsChr2)
 Until True;
Break:
 StrDispose(NewPBuf);
 TEChkMaxLen(Q,L);
 TEUpDateInfo(Q);
 TEInsChr:=True
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Proc‚dure TEInsSpcHome                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: EditorApp


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction insŠre des espaces … chaque d‚but de ligne avec affectation
 de l'attribut de modification.
}

Function TEInsSpcHome;Begin
 TEInsSpcHome:=_TEInsSpcHome(Q,L,N,PC);
 _TESetModified(Q);
 TEUpDateLn(Q);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure _TEInsSpcHome                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: EditorApp


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction insŠre des espaces … chaque d‚but de ligne sans affectation
 de l'attribut de modification.
}

Function _TEInsSpcHome;
Var
 NewPBuf:PChr;
Begin
 _TEInsSpcHome:=False;
 If(Q.ReadOnly)Then Exit;
 If L>0Then Begin
  NewPBuf:=NewBlock(PC^,L);
  If(NewPBuf=NIL)Then Exit;
 End;
 ALPopCurrPtr(Q.List,Q.CurrPtr);
 PC:=ALSetCurrBuf(Q.List,L+N+2);
 If(PC=NIL)Then Exit;
 FillSpc(PC^,N);
 If L>0Then MoveLeft(NewPBuf^,PC^[N],L);
 PC^[L+N]:=#0;
 If L>0Then FreeMemory(NewPBuf,L);
 Q.CurrPtr:=ALPushCurrPtr(Q.List);
 Inc(Q.FileSize,N);
 _TEInsSpcHome:=True;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Proc‚dure TEInsSpcIfHome                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: EditorApp


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure insŠre des espaces … chaque d‚but de ligne du listing que
 si la ligne contient de l'information et non pas si la ligne est nulle.
}

Procedure TEInsSpcIfHome;
Var
 I,M:LongInt;
 PBuffer,NewPBuf:PChr;
 L:Word;
Begin
 If(Q.ReadOnly)Then Exit;
 If Q.List.Count=0Then Exit;
 M:=Q.List.Count-1;
 ALSetPtr(Q.List,0);
 PBuffer:=_ALGetCurrBuf(Q.List);
 L:=StrLen(PBuffer);
 If L>0Then Begin
  If PBuffer^[0]=' 'Then Exit;
 End;
 ALSetPtr(Q.List,0);
 For I:=0to(M)do Begin
  PBuffer:=_ALGetCurrBuf(Q.List);
  L:=StrLen(PBuffer);
  If L>0Then Begin
   NewPBuf:=NewBlock(PBuffer^,L);
   If(NewPBuf=NIL)Then Exit;
   PBuffer:=ALSet(Q.List,I,L+Num+2);
   If(PBuffer=NIL)Then Exit;
   FillSpc(PBuffer^,Num);
   MoveLeft(NewPBuf^[0],PBuffer^[Num],L);
   PBuffer^[L+Num]:=#0;
   FreeMemory(NewPBuf,L);
   TESetModified(Q);
   Inc(Q.FileSize,Num);
  End;
  ALNext(Q.List);
 End;
 TEUpDateScr(Q);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure TEInverseWord                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: EditorApp


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure modifie le mot courant pour qu'il soit en format inverse
 seulement. S'il se trouve sur un espace, il affecte le mot pr‚c‚dent.
}

Procedure TEInverseWord;Begin
 TESetWord(Q,cgInverse)
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure TEItalicWord                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: EditorApp


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure modifie le mot courant pour qu'il soit en format italique
 seulement. S'il se trouve sur un espace, il affecte le mot pr‚c‚dent.
}

Procedure TEItalicWord;Begin
 TESetWord(Q,cgItalic)
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                             Proc‚dure TEkBS                            Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: EditorApp


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure recule d'un caractŠre et efface le caractŠre si trouvant.
 C'est l'‚quivalent de la touche clavier ®BackSpace¯ en pratique.
}

Procedure TEkBS;
Const
 MacBS1:Array[0..2]of Char=macLeft+#0;
 MacBS2:Array[0..3]of Char=macUp+macEnd+#0;
Begin
 If Q.PX>0Then TEMacro(Q,@MacBS1)Else
 If Q.P>0Then TEMacro(Q,@MacBS2);
 TEkDel(Q)
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure TEkCtrlLeft                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: EditorApp


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure  d‚place le curseur  sur le mot  pr‚c‚dent  de la  ligne
 courante du texte en ‚dition.  Il adapte ‚galement les variables internes
 pour qu'elles correspondent  … la position du curseur.  Il reproduit donc
 l'effet de retour au mot pr‚c‚dent pour l'utilisateur de ce traŒtement de
 texte.


 Remarque
 ÍÍÍÍÍÍÍÍ

  ş Comme  toutes les autres proc‚dures  et  fonctions  de cette unit‚s ou
    presque,  elle fait  partie  de  l'objet  ®Editeur¯  et  ne  peut ˆtre
    utilisez individuellement  dans une autre sorte de tƒches diff‚rente …
    cela.
}

Procedure TEkCtrlLeft;Begin
 If(Q.PX=0)or((Q.PX<=Q.SheetFormat.X1)and(Q.ScrollLock))Then Begin
  TEkUp(Q);
  TEkEnd(Q)
 End
  Else
 Case TEGetCurrChr(Q)of
  #0:Begin
   While TEGetCurrChr(Q)in[#0,' ']do Begin
    TEkLeft(Q);
    If Q.PX=0Then Exit;
    If(Q.ScrollLock)and(Q.PX<=Q.SheetFormat.X1)Then Break;
   End;
   While Not(TEGetCurrChr(Q)in[#0,' '])do Begin
    TEkLeft(Q);
    If Q.PX=0Then Exit;
    If(Q.ScrollLock)and(Q.PX<=Q.SheetFormat.X1)Then Exit;
   End;
   TEkRight(Q);
  End;
  ' ':Begin
   While TEGetLastChr(Q)=' 'do Begin
    TEkLeft(Q);
    If Q.PX=0Then Break;
    If(Q.ScrollLock)and(Q.PX<=Q.SheetFormat.X1)Then Break;
   End;
   While TEGetLastChr(Q)<>' 'do Begin
    TEkLeft(Q);
    If Q.PX=0Then Break;
    If(Q.ScrollLock)and(Q.PX<=Q.SheetFormat.X1)Then Break;
   End;
  End;
  Else
  Begin
   If TEGetLastChr(Q)=' 'Then Begin
    While TEGetLastChr(Q)=' 'do Begin
     TEkLeft(Q);
     If Q.PX=0Then Break;
     If(Q.ScrollLock)and(Q.PX<=Q.SheetFormat.X1)Then Break;
    End;
    While TEGetLastChr(Q)<>' 'do Begin
     TEkLeft(Q);
     If Q.PX=0Then Break;
     If(Q.ScrollLock)and(Q.PX<=Q.SheetFormat.X1)Then Break;
    End;
   End
    Else
   While TEGetLastChr(Q)<>' 'do Begin
    TEkLeft(Q);
    If Q.PX=0Then Break;
    If(Q.ScrollLock)and(Q.PX<=Q.SheetFormat.X1)Then Break;
   End;
  End;
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Proc‚dure TEkCtrlRight                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: EditorApp


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure d‚place le curseur et compagnie au mot suivant dans le
 traŒtement de texte de l'objet d'‚dition.
}

Procedure TEkCtrlRight;
Var
 Ok:Boolean; { RafraŒchissement de l'‚cran requis? }
 L:Word;     { Longueur de la ligne du traŒtement de texte courante }
Begin
 Ok:=False;
 L:=StrLen(TEPopCurr(Q));
 Case TEGetCurrChr(Q)of
  #0:Begin TEkDn(Q);TEkHome(Q)End;
  ' ':While TEGetCurrChr(Q)=' 'do Begin
   Ok:=TEkRightNShow(Q,False);
   If(Q.ScrollLock)and(Q.PX>=Q.SheetFormat.X2)Then Break;
   If(Q.PX>=L)Then Break;
  End;
  Else Begin
   While Not(TEGetCurrChr(Q)in[' ',#0])do Begin
    Ok:=TEkRightNShow(Q,False);
    If(Q.ScrollLock)and(Q.PX>=Q.SheetFormat.X2)Then Break;
    If(Q.PX>=L)Then Break;
   End;
   While TEGetCurrChr(Q)=' 'do Begin
    Ok:=TEkRightNShow(Q,False);
    If(Q.ScrollLock)and(Q.PX>=Q.SheetFormat.X2)Then Break;
    If(Q.PX>=L)Then Break;
   End;
  End;
 End;
 TEPutPos(Q);
 If(Ok)Then TEUpDateScr(Q);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                              Proc‚dure TEkDel                            Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: EditorApp


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure efface le caractŠre actuellement pointer par le pointeur du
 texte. C'est l'‚quivalent de la touche clavier ®Delete¯ si vous pr‚f‚rez!
}

Procedure TEkDel;
Var
 PBuf,PBuf2,TBuf:PChr;
 Ptr:Pointer Absolute PBuf;
 L,L2,TSize,_X,PSX,SX,OX,OY:Word;
 DelSpc:Boolean;
 OldChr:Char;
Begin
 If(Q.ReadOnly)Then Exit;
 ALPopCurrPtr(Q.List,Q.CurrPtr);
 PBuf:=ALGetCurrBuf(Q.List,TSize);
 L:=StrLen(PBuf);
 OldChr:=PBuf^[Q.PXG];
 If(L=0)and(Q.List.Count-1=Q.P)Then Exit;
 If(Q.Mode=vtGAT)Then _X:=Q.PXG Else _X:=Q.PX;
 DelSpc:=False;
 If(_X<L)Then Begin
  If(Q.Mode=vtGAT)Then Begin
   If PBuf^[_X]in[#1..#31]Then Case PBuf^[_X+1]of
    ' '..#254:Begin
     StrDel(PBuf,_X,2);
     Dec(Q.FileSize,LongInt(1))
    End;
    #0:PBuf^[_X]:=#0;
   End
    Else
   If(_X>0)and(PBuf^[_X-1]in[#1..#31])Then Begin
    StrDel(PBuf,_X-1,2);
    Dec(Q.FileSize,LongInt(1))
   End
    Else
   StrDel(PBuf,_X,1);
   Dec(Q.FileSize,LongInt(1))
  End
   Else
  Begin
   Dec(Q.FileSize);
   StrDel(PBuf,Q.PX,1)
  End;
  Q.W.X:=0;
  _TEPutLnProc(Q._PutLn)(Q,TSize,Q.PX-Q.X,Q.P,PBuf)
 End
  Else
 Begin
  If L=0Then Begin        { Est-ce que la ligne est vide ? }
   ALDelBuf(Q.List,Q.P);  { Oui alors: limine la ligne de la liste }
   TESetPtr(Q)            {            Mise … jour du pointeur de liste }
  End
   else
  Begin
   PBuf2:=_ALGetBuf(Q.List,Q.P+1);
   If(PBuf2=NIL)Then Begin
    If(Q.P+1=Q.List.Count)Then Exit;
    ALDelBuf(Q.List,Q.P+1)
   End
    else
   Begin
    L2:=StrLen(PBuf2);
    If(Q.Mode<>vtGAT)Then Q.PXG:=Q.PX;
    TSize:=Q.PXG+L2;TBuf:=StrNew(PBuf);
    If(TBuf=NIL)Then Exit;
    Ptr:=ALSet(Q.List,Q.P,TSize+1);
    If(Ptr=NIL)Then Exit;
    StrCopy(PBuf,TBuf);
    StrIns(PBuf,L,PBuf2);
    ALDelBuf(Q.List,Q.P+1);
    StrDispose(TBuf);
    DelSpc:=Q.Mode=vtGat;
   End
  End;
  Dec(Q.FileSize,Long(2));
  TEUpdateEOS(Q);
 End;
 _TESetModified(Q);
 TEUpdateInfo(Q);
 If(DelSpc)Then Begin { Demande d'effacer les espaces inutile? Oui }
  Q.W.Y:=Q.Y;         {  Positionne la ligne d'affichage. }
  TEDelSpc(Q)         {  Appel de la proc‚dure effa‡ant les espaces. }
 End;
 ALPopCurrPtr(Q.List,Q.CurrPtr);
 PBuf:=ALGetCurrBuf(Q.List,TSize);

  { ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ }
  { Mise … jour d'une ligne trop longue ? }
  { ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ }

 { Remarque: S'applique seulement dans le cas de l'‚dition d'un fichier }
 {           de style traŒtement de texte! Car, franchement, ‡a n'aurait }
 {           aucun sans d'aligner un source de Pascal... }

 {$IFNDEF __Windows__}
  If(Q.Mode=vtGat)and(Q.ScrollLock)and(OldChr=#0)Then Begin
   OX:=Q.PX;OY:=Q.P;L:=GetGatLen(PBuf);
   Repeat
    If(Q.SheetFormat.X2<L)Then Begin { Alignement du paragraphe ? }
     _X:=0;SX:=0;
     For L2:=0to StrLen(PBuf)-1do Begin
      Case PBuf^[L2]of
       #0:Break;
       #1..#31:Begin
        If(Byte(PBuf^[L2])and cgDouble=cgDouble)Then Inc(_X);
        Inc(L2);
        Inc(_X);
       End;
       ' ','-':Begin
        SX:=_X;PSX:=L2;Inc(_X)
       End;
       Else Inc(_X);
      End;
      If(_X>=Q.SheetFormat.X2)Then Break;
     End;
     If PBuf^[L2+1]in[' ','-']Then Begin
      Q.PX:=_X+1;Q.PXG:=L2+1;
      TEkEnterIns(Q);
      TEkDel(Q);
     End
      Else
     Begin
      If(SX<=Q.SheetFormat.X1)Then Break;       { Ligne trop longue? }
      Q.PX:=SX+1;                    { Positionne le pointeur physique }
      Q.PXG:=PSX+1;                  { Positionne le pointeur logique }
      TEkEnterIns(Q)                 { Insertion d'une ligne … la position }
                                     { pr‚c‚damment calculer... }
     End;
    End
     Else
    Break;
    ALPopCurrPtr(Q.List,Q.CurrPtr);   { Restitution de la ligne courante }
    PBuf:=ALGetCurrBuf(Q.List,TSize); { Chargement de la ligne courante }
    If IsPChrEmpty(PBuf)Then Break;   { Ligne vierge ou vide? }
    If Q.P>=Q.List.Count-1Then Break; { Fin de la liste atteint? }
    L2:=StrLen(PBuf);                 { Calcul la longueur de la ligne }
    If(L2<Q.SheetFormat.X2)Then Begin { La ligne est … l'int‚rieur de la fenˆtre ? }
     If PBuf^[L2-1]<>' 'Then Break;   {  Ligne termin‚e? }
    End;
    L:=GetGatLen(PBuf);               { Longueur de la ligne en format ®GAT¯ }
   Until False;
   TEGotoXY(Q,OX,OY);
  End;
 {$ENDIF}
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                             Proc‚dure TEkDn                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: EditorApp


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure d‚place vers le bas le pointeur du texte s'il n'est pas
 rendu … la derniŠre ligne. Elle adapte aussi bien les donn‚es visuel que
 les internes.


 Remarque
 ÍÍÍÍÍÍÍÍ

  ş Lorsque la directive de compilation ®SepLn¯ est d‚finit, la proc‚dure
    tient compte de la ligne de s‚paration fictive entre les pages.
}

Procedure TEkDn;Begin
 If Q.P<Q.List.Count-1Then Begin
  ALPopCurrPtr(Q.List,Q.CurrPtr);
  ALNext(Q.List);
  Q.CurrPtr:=ALPushCurrPtr(Q.List);
  Inc(Q.P);
  TEPutPos(Q);
  If(Q.Y<Q.W.MaxY)Then Begin
   {$IFDEF SepLn}
    If Q.P mod(Q.SheetFormat.Y2-Q.SheetFormat.Y1)=0Then Begin
     Inc(Q.Y);
     If(Q.Y>=Q.W.MaxY)Then Begin
      _WEScrollDn(Q.W);
      TEUpDateLn(Q);
      Dec(Q.Y);
     End;
    End;
   {$ENDIF}
   Inc(Q.Y);
  End
   Else
  Begin
   {$IFDEF SepLn}
    If(Q.P>0)Then
    If Q.P mod(Q.SheetFormat.Y2-Q.SheetFormat.Y1)=0Then Begin
     _WEScrollDn(Q.W);
     WEPutTxtXY(Q.W,0,Q.Y,MultChr('ú',Q.W.MaxX+1));
    End;
   {$ENDIF}
   _WEScrollDn(Q.W);
   TEUpDateLn(Q);
  End;
  If(Q.Mode=vtGat)Then Begin
   Q.PXG:=PosX2Gat1(_ALGetCurrBuf(Q.List),Q.PX);
   If(Q.PXG<Q.PX)Then Begin
    Dec(Q.PX);Dec(Q.X)
   End;
  End;
{  If(Q.Mode=ViewGat)Then Q.PXG:=PosX2Gat1(_RBGetCurrBuf(Q.Lst),Q.PX);}
  TESetCur(Q);
  WESelRightBarPos(Q.W,Q.P,Q.List.Count-1);
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Proc‚dure TEkEnd                            Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: EditorApp


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure d‚place le pointeur du texte avec son curseur … la fin de
 la ligne courante en tenant compte  du mode ScrollLock  et son application
 par  cette objet.  Elle met … jour  les donn‚es visuel  aussi bien que les
 donn‚es internes contenant l'objet de format d'‚dition.
}

Procedure TEkEnd;
Var
 L:Word;  { Longueur logique de la ligne de traŒtement de texte courante }
 PC:PChr; { Pointeur sur la ligne de traŒtement de texte }
Begin
 PC:=TEPopCurr(Q);
 If(Q.Mode=vtGAT)Then L:=GetGatLen(PC)
                 Else L:=StrLen(PC);
 If(Q.ScrollLock)Then Begin
  If(L<Q.SheetFormat.X1)Then L:=Q.SheetFormat.X1;
  If(L>Q.SheetFormat.X2)Then L:=Q.SheetFormat.X2;
 End;
 If(L<Q.W.MaxX)Then Q.X:=L
               Else Q.X:=Q.W.MaxX;
 Q.PX:=L;
 If(Q.Mode=vtGAT)Then Begin
  If(Q.ScrollLock)Then Q.PXG:=PosX2Gat1(PC,Q.PX)
                 Else Q.PXG:=StrLen(PC);
 End;
 TEPutPos(Q);
 TEUpDateScr(Q);
 TESetCur(Q);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Fonction RomanStr                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Portabilit‚: Local


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction retourne sous forme de chaŒne de caractŠres le nombre
 roman correspondant … la valeur num‚rique envoy‚e.
}

Function RomanStr(X:LongInt):String;Near;
Var
 S:String; { ChaŒne de caractŠres de traŒtement pour le retour }
Begin
 If X>9999Then Begin
  S:=IntToStr((Wd(X)mod 10000)*10000);
  If Wd(X)mod 10000>0Then IncStr(S,'+');
 End
  Else
 S:='';
 AddStr(S,Left(MultChr('M',(Wd(X)mod 10000)div 1000),9));
 Case(Wd(X)mod 1000)div 100of
  9: AddStr(S,'CM');
  8: AddStr(S,'DCCC');
  7: AddStr(S,'DCC');
  6: AddStr(S,'DC');
  5: IncStr(S,'D');
  4: AddStr(S,'CD');
  3: AddStr(S,'CCC');
  2: AddStr(S,'CC');
  1: IncStr(S,'C');
 End;
 Case(Wd(X)mod 100)div 10of
  9: AddStr(S,'XC');
  8: AddStr(S,'LXXX');
  7: AddStr(S,'LXX');
  6: AddStr(S,'LX');
  5: IncStr(S,'L');
  4: AddStr(S,'XL');
  3: AddStr(S,'XXX');
  2: AddStr(S,'XX');
  1: IncStr(S,'X');
 End;
 Case Wd(X)mod 10of
  9: AddStr(S,'IX');
  8: AddStr(S,'VIII');
  7: AddStr(S,'VII');
  6: AddStr(S,'VI');
  5: IncStr(S,'V');
  4: AddStr(S,'IV');
  3: AddStr(S,'III');
  2: AddStr(S,'II');
  1: IncStr(S,'I');
 End;
 RomanStr:=S;
End;

Function Col2Str(C:LongInt):String;
Var
 S:String[6];
Begin
 If C>308915802Then S:=Char(Byte('A')+DivLong(C-308915803,308915776))
	       Else S:='';
 If C>11881402Then IncStr(S,Char(Byte('A')+DivLong(C-11881403,11881376)));
 If C>457002Then IncStr(S,Char(Byte('A')+DivLong(C-457003,456976)));
 If C>18278Then IncStr(S,Char(Byte('A')+DivLong(C-18279,17576)));
 If C>702Then IncStr(S,Char(Byte('A')+DivLong(Word(C-703)mod 17576,676)));
 If C>26Then IncStr(S,Char(Byte('A')+DivLong(Word(C-27)mod 676,26)));
 IncStr(S,Char(Byte('A')+(Wd(C-1)mod 26)));
 Col2Str:=S;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Proc‚dure TEkEnter                           Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: EditorApp


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure, comme son nom le laisse sous-entendre, elle l'‚quivalent
 de la touche clavier ®Enter¯. Elle permet l'insertion d'une nouvelle ligne
 s'il est en mode insertion, sinon, il passe … la ligne suivante.
}

Procedure TEkEnter;Begin
 If(Q.InsMode)or(Q.P=Q.List.Count-1)Then TEkEnterIns(Q)
  Else
 Begin
  TEkDn(Q);
  TEkHome(Q)
 End;
  { V‚rification de l'ajout d'entˆte de liste? }
 If Q.ModeList>0Then Case(Q.ModeList)of
  mlBloc:TEPushStr(Q,' ş ');
  mlRoman:Begin
   TEPushStr(Q,RomanStr(Q.ModeListNumber)+'. ');
   Inc(Q.ModeListNumber);
  End;
  mlArabic:Begin
   TEPushStr(Q,WordToStr(Q.ModeListNumber)+'. ');
   Inc(Q.ModeListNumber);
  End;
  mlAlphabetic:Begin
   TEPushStr(Q,Col2Str(Q.ModeListNumber)+'. ');
   Inc(Q.ModeListNumber);
  End;
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure TEkEnterIns                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: EditorApp


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure insŠre une nouvelle ligne  dans le traŒtement de texte de
 l'objet d'‚dition. C'est l'‚quivalent de la touche clavier ®Enter¯ en mode
 d'insertion.


 Remarque
 ÍÍÍÍÍÍÍÍ

  ş Lorsque la directive de compilation  ®SepLn¯ est d‚finit,  la proc‚dure
    tient compte de la ligne de s‚paration fictive entre les pages.
}

Procedure TEkEnterIns;
Const
 MacIns:Array[0..5]of Char=macIncFS+macUpDateInfo+#0;
Var
 PBuffer,PC,TC:PChr;
 Ptr:Pointer Absolute PBuffer;
 L,SB:Word;
 UpScr:Boolean;
 I:Word;                       { Compteur de boucle }
 PDrw:^DrawInEdt;              { Pointeur sur le dessin courant }
Begin
 If(Q.ReadOnly)Then Exit;
 UpScr:=Q.PX>Q.W.MaxX;
 If Not(UpScr)Then Begin
  {$IFDEF SepLn}If(Q.Mode=vtGat)Then UpScr:=True Else{$ENDIF}
  WEScrollUp(Q.W,0,Q.Y+1,wnMax,wnMax);
 End;
 PC:=TEPopCurr(Q);L:=StrLen(PC);
 If(Q.Mode<>vtGAT)Then Q.PXG:=Q.PX;
 If(Q.PXG>L)Then SB:=0
            Else SB:=L-Q.PXG+1;
 Ptr:=ALIns(Q.List,Q.P+1,SB);
 If(Q.InterLn)Then Begin
  TC:=ALIns(Q.List,Q.P+1,2); { Cr‚ation d'une ligne bidon pour }
  TC^[0]:=#0;                { produire un double interligne }
 End;
 TESetPtr(Q);
 If(Ptr=NIL)and(SB>0)Then __OutOfMemory
  else
 If SB>0Then Begin
  MoveLeft(PC^[Q.PXG],PBuffer^,L-Q.PXG);
  PBuffer^[L-Q.PXG]:=#0;
  PC^[Q.PXG]:=#0;
  If(Q.ScrollLock)and(Q.SheetFormat.X1=Q.PX)Then DelRightSpc(_ALGetCurrBuf(Q.List));
 End;
 If Not(UpScr)Then TEUpDateLn(Q);
 ALNext(Q.List);
 If(Q.InterLn)Then ALNext(Q.List);
 Q.CurrPtr:=ALPushCurrPtr(Q.List);
 If(Q.BX1>=Q.PX)and(Q.BY1=Q.P)Then Begin
  Q.BX1:=Q.SheetFormat.X1;Inc(Q.BY1)
 End
  Else
 Begin
  If(Q.BY1>Q.P)Then Inc(Q.BY1);
  If(Q.BY2>Q.P)Then Inc(Q.BY2);
 End;
  { D‚place les processus (dessins,...) si n‚cessaire. }
 If Q.Processus.Count>0Then Begin
  ALSetPtr(Q.Processus,0);
  For I:=0to Q.Processus.Count-1do Begin
   PDrw:=_ALGetCurrBuf(Q.Processus);
   If(PDrw<>NIL)Then Begin
    If(PDrw^.Y1>=Q.P)Then Begin
     Inc(PDrw^.Y1);
     Inc(PDrw^.Y2);
    End;
   End;
   ALNext(Q.Processus);
  End;
 End;
 Inc(Q.P);
 If(Q.InterLn)Then Inc(Q.P);
 If(Q.Y<Q.W.MaxY)Then Begin
  {$IFDEF SepLn}
   If Q.P mod(Q.SheetFormat.Y2-Q.SheetFormat.Y1)=0Then Begin
    Inc(Q.Y);
    If(Q.Y>=Q.W.MaxY)Then Begin
     If Not(UpScr)Then _WEScrollDn(Q.W);
     Dec(Q.Y);
    End;
   End;
  {$ENDIF}
  Inc(Q.Y);
  {$IFDEF SepLn}
   WESetPos(Q.W,0,Q.Y);
  {$ENDIF}
 End
  Else
 Begin
  {$IFDEF SepLn}
   If(Q.P>0)Then
   If(Q.P)mod(Q.SheetFormat.Y2-Q.SheetFormat.Y1)=0Then If Not(UpScr)Then Begin
    _WEScrollDn(Q.W);
    WEPutTxtXY(Q.W,0,Q.Y,MultChr('ú',Q.W.MaxX+1));
   End;
  {$ENDIF}
  If Not(UpScr)Then _WEScrollDn(Q.W);
 End;
 If(Q.ScrollLock)Then Begin
  PC:=_ALGetCurrBuf(Q.List);
  L:=StrLen(PC);
  If L>0Then Begin
   _TEInsSpcHome(Q,L,Q.SheetFormat.X1,PC);
   Inc(Q.FileSize,Long(Q.SheetFormat.X1));
  End;
 End;
 If Not(UpScr)Then TEUpDateLn(Q);
 _TESetModified(Q);
{ If(UpScr)Then TEUpDateScr(Q);}
 If(Q.ScrollLock)Then Begin
  If(Q.SheetFormat.X1>Q.W.MaxX)Then Q.X:=Q.W.MaxX
                               Else Q.X:=Q.SheetFormat.X1-(Q.PX-Q.X);
  Q.PX:=Q.SheetFormat.X1;
  If(Q.Mode=vtGAT)Then Q.PXG:=PosX2Gat1{xx}(_ALGetCurrBuf(Q.List),Q.SheetFormat.X1);
 End
  else
 Begin
  Q.X:=0;Q.PX:=0;Q.PXG:=0;
 End;
 If(UpScr)Then TEUpDateScr(Q);
 TEMacro(Q,@MacIns);
 TESetCur(Q);
 WESelRightBarPos(Q.W,Q.P,Q.List.Count-1);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure TEkHome                            Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: EditorApp


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure d‚place le pointeur de texte ainsi que son curseur … la
 position du d‚but de la ligne en tenant compte du mode ScrollLock et son
 application  par cette objet.  Elle met … jour  les donn‚es visuel aussi
 bien que les donn‚es internes contenant l'objet de format d'‚dition.
}

Procedure TEkHome;Begin
 If(Q.ScrollLock)Then Begin
  If(Q.SheetFormat.X1>Q.W.MaxX)Then Q.X:=Q.W.MaxX
                               Else Q.X:=Q.SheetFormat.X1;
  Q.PX:=Q.SheetFormat.X1;
  If(Q.Mode=vtGAT)Then Q.PXG:=PosX2Gat1(TEPopCurr(Q),Q.SheetFormat.X1)
 End
  else
 Begin
  Q.X:=0;Q.PX:=0;Q.PXG:=0;
 End;
 TEPutPos(Q);
 TEUpDateScr(Q);
 TESetCur(Q);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure TEkLeft                           Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: EditorApp


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure d‚place le pointeur du texte vers la gauche … condition
 qu'il ne soit pas … la zone limite  en mode ScrollLock ou au d‚but de la
 ligne. Elle actualise l'‚cran et les donn‚es internes de l'objet.
}

Procedure TEkLeft;
Label XSet,Big;
Var
 PC:PChr;
 BiChar,Dbl:Boolean;
 L:Word;

 Procedure Sub;Begin
  Dec(Q.PX);
  TEPutPos(Q);
  If Q.X>0Then Dec(Q.X)
          Else TEUpDateScr(Q);
  TESetCur(Q);
 End;

Begin
 If(Q.Mode=vtGAT)Then Begin
  If(GetScrollLck)Then Begin
   If(Q.PX>Q.SheetFormat.X1)Then Begin
    PC:=TEPopCurr(Q);L:=StrLen(PC);
    If(Q.PXG=L)Then Begin
     Dec(Q.PX);Dec(Q.PXG);
     If(Q.PXG>0)and(PC^[Q.PXG-1]in[#0..#31])Then Begin
      Dec(Q.PXG);
      If(Byte(PC^[Q.PXG])and cgDouble=cgDouble)Then Begin
       Dec(Q.PX);Dec(Q.X)
      End;
     End;
     Goto XSet;
    End
     Else
    If(Q.PXG>L)Then Begin
     Dec(Q.PX);Dec(Q.PXG);
XSet:If Q.X>0Then Dec(Q.X)
             Else TEUpDateScr(Q)
    End
     Else
    Goto Big;
    TEPutPos(Q);
    TESetCur(Q);
   End;
  End
   else
  Begin
   If Q.PX>0Then Begin
Big:PC:=TEPopCurr(Q);
    If PC^[Q.PXG]in[#0..#31]Then Begin
     If PC^[Q.PXG]=#0Then Begin
      Dec(Q.PXG);BiChar:=PC^[Q.PXG]in[#0..#31];
      If(BiChar)Then Dec(Q.PXG);
     End
      Else
     If PC^[Q.PXG-2]in[#0..#31]Then Begin
      Dec(Q.PXG,2);
      Dbl:=TEIsDbl(PC^[Q.PXG]);
      BiChar:=True;
     End
      Else
     Begin
      Dec(Q.PXG);
      Dbl:=False;BiChar:=False;
     End;
    End
     Else
    Begin
     If PC^[Q.PXG-2]in[#0..#31]Then Begin
      Dec(Q.PXG,2);
      Dbl:=TEIsDbl(PC^[Q.PXG])
     End
      Else
     Begin
      Dec(Q.PXG);
      BiChar:=PC^[Q.PXG]in[#1..#31];
      Dbl:=TEIsDbl(PC^[Q.PXG]);
      If(BiChar)Then Dec(Q.PXG);
     End;
    End;
    If(BiChar)and(Dbl)Then Begin
     If Q.PX>1Then Dec(Q.PX,2)
              Else Q.PX:=0;
     If Q.X>1Then Dec(Q.X,2)
      Else
     Begin
      Q.X:=0;
      TEUpDateScr(Q)
     End;
    End
     Else
    Begin
     Dec(Q.PX);
     If Q.X>0Then Dec(Q.X)
             Else TEUpDateScr(Q);
    End;
    If Q.X=Q.PX+1Then Begin
     Q.PX:=Q.X;Q.PXG:=PosX2Gat1(PC,Q.PX)
    End;
    TEPutPos(Q);
    TESetCur(Q);
   End;
  End;
 End
  Else
 Begin
  If(GetScrollLck)Then Begin
   If(Q.PX>Q.SheetFormat.X1)Then Sub;
  End
   Else
  If Q.PX>0Then Sub;
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Proc‚dure TEkPgDn                             Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: EditorApp


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction passe  … un ‚cran texte plus loin … condition de ne pas ˆtre
 … la fin du texte.  Il met comme  vous vous en doutez  les donn‚es visuel et
 internes … jour.
}

Procedure TEkPgDn;Begin
 If(Q.P+Q.W.MaxY<Q.List.Count)Then Begin
  Inc(Q.P,Q.W.MaxY);
  TEPutPos(Q);
  TEUpDateScr(Q);
  TESetPtr(Q)
 End
  Else
 TEEndText(Q);
 WESelRightBarPos(Q.W,Q.P,Q.List.Count-1);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                             Proc‚dure TEkPgUp                            Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: EditorApp


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction passe  … un ‚cran texte plus loin … condition de ne pas ˆtre
 au d‚but du texte. Il met bien entendu les donn‚es visuel et interne … jour.
}

Procedure TEkPgUp;Begin
 If(Q.P>Q.W.MaxY)Then Begin
  Dec(Q.P,Q.W.MaxY);
  If(Q.P<Q.W.MaxY)Then Q.Y:=Q.P;
  TEPutPos(Q);
  TEUpDateScr(Q);
  TESetPtr(Q);
  WESelRightBarPos(Q.W,Q.P,Q.List.Count-1);
 End
  else
 TEHomeText(Q);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                             Proc‚dure TEkRight                           Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: EditorApp


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure d‚place  le pointeur  du texte  vers la droite  … condition
 qu'il n'y est pas de collision  avec le mode de fenˆtre  ®ScrollLock¯ et que
 celle-ci soit enclench‚. Elle met … jour les donn‚es internes aussi bien que
 les donn‚es visuel affich‚e … l'‚cran.
}

Procedure TEkRight;Begin
 TEkRightNShow(Q,True)
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure TEkRightNShow                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: EditorApp


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction d‚place le pointeur texte vers la droite en fesant la mise …
 jour si demander (Show=Ya) par les paramŠtres d'entr‚e.
}

Function TEkRightNShow;
Label UpDate;
Var
 PC:PChr;
 L:Word;
Begin
 TEkRightNShow:=False;
 PC:=TEPopCurr(Q);
 If(Q.Mode=vtGAT)Then Begin
  If(GetScrollLck)Then Begin
   If(Q.PX<Q.SheetFormat.X2)Then Begin
    L:=StrLen(PC);Inc(Q.PX);
    If(Q.PXG>L)Then Inc(Q.PXG)
     Else
    Begin
     If(PC^[Q.PXG]<' ')and TEIsDbl(PC^[Q.PXG])Then Begin
      Inc(Q.PX);
      If(Q.X<Q.W.MaxX)Then Inc(Q.X)
     End;
     If PC^[Q.PXG]in[#1..#31]Then Inc(Q.PXG);
     Inc(Q.PXG)
    End;
   End
    Else
   If(Q.PX-5<Q.SheetFormat.X2)Then If Q.SheetFormat.X2>=Q.W.MaxX-5Then Begin
    Inc(Q.PX);
    If Q.PXG<=StrLen(PC)Then Begin
     If PC^[Q.PXG]in[#1..#31]Then Inc(Q.PXG);
    End;
    Inc(Q.PXG)
   End
   Else Exit
  End
   else
  Begin
   If Q.PXG<65520Then Begin
    Inc(Q.PX);
    If(PC^[Q.PXG]<' ')and TEIsDbl(PC^[Q.PXG])Then Begin
     Inc(Q.PX);
     If(Q.X<Q.W.MaxX)Then Inc(Q.X)
    End;
    If PC^[Q.PXG]in[#1..#31]Then Inc(Q.PXG);
    Inc(Q.PXG)
   End
    Else
   Q.PXG:=0;
  End;
  Goto UpDate;
 End
  Else
 Begin
  If(GetScrollLck)Then L:=Q.SheetFormat.X2
                  Else L:=65520;
  If(Q.PX<L)Then Begin
   Inc(Q.PX);
UpDate:
   If(Show)Then TEPutPos(Q);
   If(Q.X<Q.W.MaxX)Then Inc(Q.X)Else
   If(Show)Then TEUpDateScr(Q)
           Else TEkRightNShow:=True
  End
 End;
 If(Show)Then TESetCur(Q)
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                             Proc‚dure TEkUp                           Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: EditorApp


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure d‚place vers le haut le pointeur du texte s'il n'est pas
 rendu … la premiŠre ligne.  Elle adapte aussi bien les donn‚es visuel que
 les internes.


 Remarque
 ÍÍÍÍÍÍÍÍ

  ş Lorsque la directive de compilation  ®SepLn¯ est d‚finit, la proc‚dure
    tient compte de la ligne de s‚paration fictive entre les pages.
}

Procedure TEkUp;Begin
 If Q.P>0Then Begin
  ALPopCurrPtr(Q.List,Q.CurrPtr);
  ALPrevious(Q.List);
  Q.CurrPtr:=ALPushCurrPtr(Q.List);
  Dec(Q.P);
  TEPutPos(Q);
  If Q.Y>0Then Begin
   {$IFDEF SepLn}
    If Q.P mod(Q.SheetFormat.Y2-Q.SheetFormat.Y1)=Q.SheetFormat.Y2-Q.SheetFormat.Y1-1Then Begin
     Dec(Q.Y);
     If Q.Y=0Then Begin
      _WEScrollUp(Q.W);
      TEUpDateLn(Q);
      Inc(Q.Y);
     End;
    End;
   {$ENDIF}
   Dec(Q.Y);
  End
   else
  Begin
   {$IFDEF SepLn}
    If(Q.P>0)Then
    If Q.P mod(Q.SheetFormat.Y2-Q.SheetFormat.Y1)=Q.SheetFormat.Y2-Q.SheetFormat.Y1-1Then Begin
     _WEScrollUp(Q.W);
     WEPutTxtXY(Q.W,0,0,MultChr('ú',Q.W.MaxX+1));
    End;
   {$ENDIF}
   _WEScrollUp(Q.W);
   TEUpDateLn(Q);
  End;
  If(Q.Mode=vtGat)Then Begin
   Q.PXG:=PosX2Gat1(_ALGetCurrBuf(Q.List),Q.PX);
   If(Q.PXG<Q.PX)Then Begin
    Dec(Q.PX);Dec(Q.X)
   End;
  End;
  TESetCur(Q);
  WESelRightBarPos(Q.W,Q.P,Q.List.Count-1);
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Fonction TEMaxLns                            Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: EditorApp


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction retourne le num‚ro de ligne maximal de l'objet d'‚dition de
 traŒtement de texte.
}

Function TEMaxLns;
{$IFDEF NotReal}
 Begin
  TEMaxLns:=ALMax(Q.List)
 End;
{$ELSE}
 Assembler;ASM
  LES DI,Q
  MOV AX,ES:[DI].EditorApp.List.Count
  DEC AX
 END;
{$ENDIF}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Proc‚dure TENormalWord                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: EditorApp


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure modifie le mot courant pour qu'il soit en format normal.
 S'il se trouve sur un espace, il affecte le mot pr‚c‚dent.
}

Procedure TENormalWord;Begin
 TESetWord(Q,cgNormal)
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure TEPushStr                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: EditorApp


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure insŠre une chaŒne de caractŠre … la position actuel du
 pointeur de traŒtement de texte de l'objet d'‚dition.
}

Procedure TEPushStr;
Label Default;
Var
 I:Byte;
 L:Word;
 PC,TPC:PChr;
Begin
 If Q.ChrAttr=0Then Begin
  If(Q.PX+Length(S)>Q.SheetFormat.X2)and(Q.ScrollLock)Then Goto Default;
  PC:=TEPopCurr(Q);
  If(Q.Mode<>vtGat)Then Q.PXG:=Q.PX;
  If IsPChrEmpty(PC)Then Begin
   PC:=ALSetCurrBuf(Q.List,Length(S)+Q.PXG+2);
   If(PC<>NIL)Then Begin
    PC^[0]:=#0;
    StrInsBuf(PC,Q.PXG,S[1],Length(S))
   End;
  End
   Else
  Begin
   If(Length(S)<Q.PXG)Then L:=Q.PXG
                      Else L:=Length(S);
   TPC:=StrNew(PC);
   PC:=ALSetCurrBuf(Q.List,L+StrLen(PC)+1);
   If(PC<>NIL)Then Begin
    StrCopy(PC,TPC);
    If Not(Q.InsMode)Then StrDel(PC,Q.PXG,Length(S));
    StrInsBuf(PC,Q.PXG,S[1],Length(S))
   End;
   StrDispose(TPC);
  End;
  Inc(Q.PX,Length(S));Inc(Q.PXG,Length(S));Inc(Q.X,Length(S));
  If(Q.X>Q.W.MaxX)Then Q.X:=Q.W.MaxX;
  TESetPtr(Q);
  TEUpDateLn(Q);
  TEUpDateInfo(Q);
 End
  Else
 Default:For I:=1to Length(S)do Begin
  TESetThisChr(Q,S[I]);
  If(Q.PX>=Q.SheetFormat.X2)Then Begin
   TEkCtrlLeft(Q);
   TEkEnterIns(Q);
   TEkEnd(Q);
  End
   Else
  TEkRight(Q)
 End
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                             Proc‚dure TEPutBar                           Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: EditorApp


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure affiche la barre des indicateurs de la fenˆtre de l'‚diteur
 de texte.
}

Procedure TEPutBar;
Var
 Color:Byte;
Begin
 If(Q.Mode=vtHlp)Then Color:=Q.W.Palette.Title
                 Else Color:=CurrKrs.Editor.Env.BarInfo;
 WESetEndBar(Q.W,Color);
 TEPutPos(Q);
 If(IsGrf){$IFNDEF GraphicOS}and Not(HoleMode){$ENDIF}Then Begin
  BarSpcHorRelief(Q.W.T.X1,Q.W.T.Y2,Q.W.T.X1+15,Color);
  BarSpcHorReliefExt(Q.W.T.X1+1,Q.W.T.Y2,Q.W.T.X1+14,Color);
 End
  Else
 WESetEndBarTxtX(Q.W,16,'³',Color);
 TEPutIns(Q);
 If(IsGrf){$IFNDEF GraphicOS}and Not(HoleMode){$ENDIF}Then Begin
  BarSpcHorRelief(Q.W.T.X1+16,Q.W.T.Y2,Q.W.T.X1+22,Color);
  BarSpcHorReliefExt(Q.W.T.X1+17,Q.W.T.Y2,Q.W.T.X1+21,Color)
 End
  Else
 WESetEndBarTxtX(Q.W,23,'³',Color);
 TEPutViewMode(Q);
 If(IsGrf){$IFNDEF GraphicOS}and Not(HoleMode){$ENDIF}Then Begin
  BarSpcHorRelief(Q.W.T.X1+23,Q.W.T.Y2,Q.W.T.X1+32,Color);
  BarSpcHorReliefExt(Q.W.T.X1+24,Q.W.T.Y2,Q.W.T.X1+31,Color);
  BarSpcHorRelief(Q.W.T.X1+33,Q.W.T.Y2,Q.W.T.X1+42,Color);
  BarSpcHorReliefExt(Q.W.T.X1+34,Q.W.T.Y2,Q.W.T.X1+41,Color);
  BarSpcHorRelief(Q.W.T.X1+43,Q.W.T.Y2,Q.W.T.X2,Color);
  BarSpcHorReliefExt(Q.W.T.X1+44,Q.W.T.Y2,Q.W.T.X2-2,Color);
  LuxeBox(Q.W.T.X2-1,Q.W.T.Y2);
 End
  Else
 Begin
  WESetEndBarTxtX(Q.W,33,'³',Color);
  WESetEndBarTxtX(Q.W,43,'³',Color);
 End;
 TEPutBarXYM(Q,Q.StrMX,Q.List.Count,Q.FileSize);
 If(Q.Mode=vtHlp)Then WESetKrBorder(Q.W)
                 Else Q.W.CurrColor:=CurrKrs.Editor.Env.Default;
End;

Procedure PutSepIcon(Var Q:Window;X,Y:Word);
Var
 Y2:Word;
Begin
 Y2:=Y+HeightChr;
 WEPutLine(Q,X,Y,X,Y2,Black);
 WEPutLine(Q,X+1,Y,X+1,Y2,White);
End;

Procedure WESelectBox(Var Q:EditorApp;X,L:Byte);
Var
 G:GraphBoxRec;
 SelectColor:Byte;
 GX,GY:Word;
Begin
 If BitsPerPixel=1Then SelectColor:=$80
                  Else SelectColor:=CurrKrs.Menu.Select{Editor.Wins.Sel};
 G.X1:=(X shl 3)-4;
 G.Y1:=4;
 G.X2:=G.X1+(L shl 3)-2;
 G.Y2:=24;
 WEPutFillBox(Q.W,G.X1,G.Y1,G.X2,G.Y2,SelectColor);
 GX:=WEGetRX1(Q.W)shl 3;
 GY:=GetRawY(WEGetRY1(Q.W));
 Inc(G.X1,GX);Inc(G.X2,GX);
 Inc(G.Y1,GY);Inc(G.Y2,GY);
 __GraphBoxRelief(G,0);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Proc‚dure TEPutKeyTxt                   Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: Edt


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure effectue une mise … jour de la Bar d'icon en bas
 de la fenˆtre de l'‚diteur courant.
}

Procedure TEPutKeyTxt;
Var
 XP,YP,I,J,B:Word;
 GX1,GY1,GX2:Word;
 Exp:Boolean;
 Color:Byte;
Begin
 {$IFNDEF GraphicOS}
  If(HoleMode)Then Exit;
 {$ENDIF}
 If(eBarUp)in(Q.Option)Then Begin
  Exp:=Q.ChrAttr=cgExposant;
  WESetHomeLine(Q.W,0);
  If BitsPerPixel=1Then Color:=$F0
                   Else Color:=CurrKrs.Desktop.DialStatus;
  WEClrWn(Q.W,0,0,wnMax,1,Color);
  GX1:=WEGetRX1(Q.W)shl 3;
  GY1:=GetRawY(WEGetRY1(Q.W))+8;
  Case(Q.Mode)of
   vtGat:Begin
    If Not(Exp)and(Q.ChrAttr and cgBold=cgBold)Then WESelectBox(Q,1,2);
    BoldIcon(GX1+8,GY1,Color);
    If Not(Exp)and(Q.ChrAttr and cgUnderline=cgUnderline)Then WESelectBox(Q,3,2);
    UnderlineIcon(GX1+24,GY1,Color);
    If Not(Exp)and(Q.ChrAttr and cgInverse=cgInverse)Then WESelectBox(Q,5,2);
    SetGCube(GX1+40,GY1,'I',(Color shr 4)+(Color shl 4));
    If Not(Exp)and(Q.ChrAttr and cgItalic=cgItalic)Then WESelectBox(Q,7,2);
    ItalicIcon(GX1+56,GY1,Color);
    If(Exp)Then WESelectBox(Q,9,2);
    OutSmlTxtXY(GX1+72,GY1,'e',Color);
    If Not(Exp)and(Q.ChrAttr and cgDouble=cgDouble)Then WESelectBox(Q,11,3);
    DoubleIcon(GX1+88,GY1,Color);
    PutSepIcon(Q.W,112,7);
    If(Q.DrawMode)Then WESelectBox(Q,15,3);
    DrawIcon(GX1+120,GY1,Color);
    PutSepIcon(Q.W,144,7);
    LeftCenterIcon(GX1+152,GY1,Color);
    JustifyCenterIcon(GX1+176,GY1,Color);
    RightCenterIcon(GX1+200,GY1,Color);
    PutSepIcon(Q.W,224,7);
    SimpleLineIcon(GX1+232,GY1,Color);
    DoubleLineIcon(GX1+256,GY1,Color);
    PutSepIcon(Q.W,280,7);
    Case(Q.ModeList)of
     mlBloc:WESelectBox(Q,36,3);
     mlRoman:WESelectBox(Q,39,3);
     mlArabic:WESelectBox(Q,42,3);
     mlAlphabetic:WESelectBox(Q,45,3);
    End;
    PuceBlockIcon(GX1+288,GY1,Color);
    PuceRomanIcon(GX1+312,GY1,Color);
    PuceNumberIcon(GX1+336,GY1,Color);
    PuceAlphaIcon(GX1+360,GY1,Color);
   End;
   vtBas:Begin
    SetGCube(GX1+8,GY1,#16,Color);
    OutSmlTxtXY(GX1+32,GY1,'³',Color);
    OutSmlTxtXY(GX1+40,GY1,'³',Color);
    SetGCube(GX1+64,GY1,'ş',Color);
   End;
  End;
  GY1:=GetRawY(2)-1;
  GX2:=Pred((Q.W.MaxX+1)shl 3);
  WEPutLnHor(Q.W,0,0,GX2,Black);
  WEPutLnHor(Q.W,0,1,GX2,White);
  WEPutLnHor(Q.W,0,GY1,GX2,Black);
  WEPutLnHor(Q.W,0,GY1-2,GX2,White);
  WEPutLnHor(Q.W,0,GY1-3,GX2,Black);
  WEPutLine(Q.W,0,2,0,GY1-2,White);
  WEPutLine(Q.W,GX2,2,GX2,GY1-2,Black);
  WESetHomeLine(Q.W,2);
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Proc‚dure TEPutPos                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: Edt


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure affiche la position actuellement en usage du pointeur de
 texte sur la barre du bas.
}

Procedure TEPutPos;
Var
 S:String;
 Color:Byte;
 LP:Word;
Begin
 If(Q.Mode=vtHlp)Then Color:=Q.W.Palette.Title
                 Else Color:=CurrKrs.Editor.Env.Pos;
 LP:=Q.SheetFormat.Y2-Q.SheetFormat.Y1;
 If(Q.Mode)in[vtHlp,vtGat]Then S:=WordToStr((Q.P div LP)+1)+':('+WordToStr(Q.PX+1)+','+WordToStr((Q.P mod LP)+1)
                          Else S:='('+WordToStr(Q.PX+1)+','+WordToStr(Q.P+1);
 IncStr(S,')');
 If(IsGrf)Then
  WESetEndBarTxtX(Q.W,1,Spc(13-Length(S))+S,Color)
 Else
  WESetEndBarTxtX(Q.W,0,Spc(15-Length(S))+S,Color);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Proc‚dure TEPutRules                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: Edt


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure affiche la rŠgle de positionnement en bas de la fenˆtre de
 l'‚diteur avec des num‚ros de colonnes … chaque dizaines.


 Remarque
 ÍÍÍÍÍÍÍÍ

  ş Cette  op‚ration  s'effectue  que  si la variable  globale  ®Rules¯  est
    affect‚ en cons‚quence d'un bon vouloir d'une rŠgle.
}

Procedure TEPutRules;
Var
 XP,YP,MD,Len:Byte;
 GX1,GY1,GX2:Word;
 Start,I,H:Word;
 Chr:Char;
 MO:Word;
 S:String;
Begin
 {$IFNDEF __Windows__}
  If(eNoRules)in(Q.Option)Then Exit;
  If(Rules)and Not(HoleMode)Then Begin
   If(eBarUp)in(Q.Option)Then WESetHomeLine(Q.W,0);
   XP:=WEGetRX1(Q.W);
   YP:=WEGetRY1(Q.W)+Q.W.MaxY+1;
   Start:=Q.PX-Q.X;
   MD:=Start mod 10;MO:=(Start div 10)+1;
   If MO>=1000Then Len:=5 Else
   If MO>=100Then Len:=4 Else
   If MO>=10Then Len:=3 Else Len:=2;
   H:=(10-Len)shr 1;
   If(MD>=H)and(MD<H+Len)Then Begin
    S:=WordToStr(MO);
    If MO>0Then Begin
     IncStr(S,'0');
     S:=DelStr(S,1,MD-H);
    End;
    If(IsGrf)Then PutSmlTxtXY(XP,YP,S,GetAttr(XP,YP))
             Else PutTxtXYUnKr(XP,YP,S);
    {$IFDEF NoAsm}
     Inc(XP,Length(S));
     Inc(Start,Length(S));Inc(MD,Length(S));
    {$ELSE}
     ASM
      MOV AL,Byte Ptr S
      XOR AH,AH
      ADD XP,AL
      ADD Start,AX
      ADD MD,AL
     END;
    {$ENDIF}
   End;
   If((Q.RefreshRules)or(Q.OldXRules=$FF))and(IsGrf)and(HeightChr>=16)Then Begin
    GX1:=XP shl 3;GY1:=GetRawY(YP);GX2:=(Pred(Q.W.T.X2)shl 3)-1;
    PutLineHori(GX1,GY1,GX2,DarkGray);
    PutLineHori(GX1,GY1+1,GX2,White);
    PutLineHori(GX1,GY1+2,GX2,LightGray);
    PutLineHori(GX1,GY1+3,GX2,DarkGray);
    PutLineHori(GX1,GY1+HeightChr-4,GX2,DarkGray);
    PutLineHori(GX1,GY1+HeightChr-3,GX2,White);
    PutLineHori(GX1,GY1+HeightChr-2,GX2,LightGray);
    PutLineHori(GX1,GY1+HeightChr-1,GX2,DarkGray);
    Q.RefreshRules:=False;
   End;
   For I:=Start to(Q.W.MaxX+Q.PX-Q.X)do Begin
    If(I=Q.SheetFormat.X1)Then Chr:='['Else
    If(I=Q.SheetFormat.X2)Then Chr:=']'Else
    If MD=(10-Len)shr 1Then Begin
     S:=WordToStr(MO);
     If MO>0Then IncStr(S,'0');
     If XP+Len>Q.W.MaxX+WEGetRX1(Q.W)Then Begin
      Inc(Q.W.MaxY);
      WESetKrBorder(Q.W);
      WEPutSmlTxtXY(Q.W,XP-WEGetRX1(Q.W),YP-WEGetRY1(Q.W),S);
      Dec(Q.W.MaxY);
      Exit;
     End
      Else
     Begin
      If(IsGrf)Then PutSmlTxtXY(XP,YP,S,GetAttr(XP,YP))
               Else PutTxtXYUnKr(XP,YP,S);
      Inc(XP,Length(S));Inc(I,Length(S));Inc(MD,Length(S));
     End;
    End
     Else
    Case(MD)of
     0:Chr:='Å';
     Else Chr:='Á';
    End;
    If(IsGrf)Then Begin
     If(Chr)in['[',']']Then PutAiguillon(XP,YP)
                       Else PutSmlTxtXY(XP,YP,Chr,GetAttr(XP,YP));
    End
     Else
    SetChr(XP,YP,Chr);
    Inc(XP);
    MD:=MaxByte(MD,9);
    If MD=0Then Begin
     Inc(MO);
     If MO>=1000Then Len:=5 Else
     If MO>=100Then Len:=4 Else
     If MO>=10Then Len:=3 Else Len:=2;
    End;
   End;
   If(eBarUp)in(Q.Option)Then WESetHomeLine(Q.W,2);
  End;
 {$ENDIF}
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure TEPutScrollLck                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: Edt


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette  proc‚dure  fixe  le traŒtement  de  texte  de l'objet  d'‚dition en
 fonction de l'‚tat actuel du la touche ®ScrollLock¯ … l'indicatif lumineux.
}

Procedure TEPutScrollLck;Begin
 Q.ScrollLock:=GetScrollLck;
 TEPutIns(Q);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Proc‚dure TEPutViewMode                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: Edt


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction affiche le mode actuellement en usage dans le traŒtement
 de texte, c'est-…-dire s'il s'agit du Pascal, GAT, d'une police...
}

Procedure TEPutViewMode;
Var
 S:String[15]; { Mode }
 MS:String[15];{ Sous-mode }
Begin
 If(Q.Mode)in[vtHlp,vtPJ]Then Exit;
 MS:='';
 Case(Q.Mode)of
  vtAda:S:='Ada';
  vtAsm:S:='Assembler';
  vtBas:Begin
   S:='Basic';
   Case(Q.ModeSub)of
    bmCK64:MS:='Commodore 64';
    bmApple:MS:='Apple ][';
    bmCOCO3:MS:='COCO 3';
    bmGWBASIC:MS:='BASICA/GWBASIC';
    bmTurboBasic:MS:='TurboBasic';
    bmGFABasic:MS:='GFABasic';
    bmQBasic:MS:='QBasic/QuickBasic';
    bmVisualBasic:MS:='Visual Basic';
    bmAPSI:MS:='APSI';
    bmBasicPro:MS:='BasicPro';
    bmVAX:MS:='VAX/Alpha';
    Else MS:='Tous';
   End;
  End;
  vtC:S:='C/C++';
  vtCobol:S:='Cobol';
  vtEuphoria:S:='Euphoria';
  vtForth:S:='Forth';
  vtFortran:S:='Fortran';
  vtIni:S:='Ini';
  vtMsMnu:S:='Mouse Mnu';
  vtPas:S:='Pascal';
  vtPW:S:='PW';
  vtRC:S:='Ressource';
  vtGAT:Begin
   Case(Q.ModeSub)of
    vtsFirstChoice:S:='Premier';
    vtsHTML:S:='HTML Doc.';
    vtsMicrosoftWord:Begin
     S:='Document';
     MS:='MsWord';
    End;
    Else S:='Gat';
   End;
   Q.ScrollLock:=True;
  End;
  vtBatch:S:='Batch';
  vtSQL:S:='SQL';
  vtHTMLSourceCode:S:='Code HTML';
  Else S:='Normal';
 End;
 WESetEndBarTxtX(Q.W,24,Left(StrUSpc(S,9),8),CurrKrs.Editor.Env.Insert);
 WESetEndBarTxtX(Q.W,34,Left(StrUSpc(MS,9),8),CurrKrs.Editor.Env.Insert);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Proc‚dure TEPutWn                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: EditorApp


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure initialise la fenˆtre du traŒtement de texte de l'objet
 d'‚dition.
}

Procedure TEPutWn;Begin
 WEInit(Q.W,X1,Y1,X2,Y2);
 _TEPutWn(Q);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Proc‚dure TERefresh                           Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: EditorApp
 Portabilit‚:  Global


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure r‚affiche totalement la fenˆtre d'‚dition du traŒtement de
 texte.  Si par exemple, vous vouliez montrer d'autre chose  et  que l… vous
 revener … lui, c'est plus ‚conomique que sauvegarder l'image.
}

Procedure TERefresh;Begin
 EditorApp(Q).OldXRules:=$FF;
 _TEPutWn(EditorApp(Q));
 TEPutBar(EditorApp(Q));
 TEUpDateScr(EditorApp(Q));
 If(EditorApp(Q).Modified)Then Begin
  EditorApp(Q).Modified:=False;
  TESetModified(EditorApp(Q))
 End;
 If(EditorApp(Q).Mode in[vtBas,vtGat])Then TEPutKeyTxt(EditorApp(Q));
 WESelRightBarPos(EditorApp(Q).W,EditorApp(Q).P,EditorApp(Q).List.Count-1);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Proc‚dure TERun                             Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: EditorApp
 Portabilit‚:  Global


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction est le coeur de l'action utilisateur. C'est elle recevant
 l'avis clavier ou souris et prenant la d‚cision appropri‚. Toutefois dans
 le cas des raccourcis clavier ou combinaison de touche relatif au menu ou
 autres, elle renvoie le code clavier re‡u.
}

Function TERun;
Label
 BreakAltBar,BreakAltPBar,BreakCtrlBar,BreakShiftBar,
 ReRead,Break,PushChr,MouseExit,RunPress,ShPress,AltPr;
Const
 WaitDelay=20; { D‚lai en interval de 1/70 secondes avant d'afficher l'information }
{$IFDEF Debug}
 Const DebugKey:Boolean=False;
{$ENDIF}
Var
 Q:EditorApp Absolute Context; { Variable objet ‚diteur }
 L,_X,K,BM,TP,I:Word;
 Chr:Char Absolute K;
 Ok2:Boolean;
 Shift:Boolean;          { Un/les boutons ®Shift¯ du clavier sont enfonc‚s? }
 PBuffer:PChr;Ptr:Pointer Absolute PBuffer;
 OldAttr:Byte;           { Ancienne attribut du caractŠre }
 LastChr,                { CaractŠre pr‚c‚dent }
 NextChr,                { CaractŠre suivant }
 UpChr,                  { CaractŠre au dessus }
 DnChr:Char;             { CaractŠre en dessous }
 OldScrollLck:Boolean;   { Mode Scroll Lock? }
 LT:Window;              { Sauvegarde d'‚cran de la derniŠre ligne d'information }

 Procedure SetChapeau;
 Var
  Chr:Char;
  PC:PChr;
 Begin
  Chr:=TEGetCurrChr(Q);
  If(Chr)in['a','…','„','e','‚','f','i','n','o','u','N']Then Begin
   If Not(Q.Mode in[vtGat,vtHlp])Then Q.PXG:=Q.PX;
   PC:=TEPopCurr(Q);
   Case(Chr)of
    'a','…','„':Chr:='ƒ';
    'e','‚':Chr:='ˆ';
    'f':Chr:='Ÿ';
    'i':Chr:='Œ';
    'n':Chr:='¤';
    'o':Chr:='“';
    'u':Chr:='–';
    'N':Chr:='¥';
   End;
   PC^[Q.PXG]:=Chr;
   WESetChr(Q.W,Q.X,Q.Y,Chr);
  End;
 End;

 Procedure SetTrema;
 Var
  Chr:Char;
  PC:PChr;
 Begin
  Chr:=TEGetCurrChr(Q);
  If Chr in['a','e','f','i','n','o','u','y','A','N','U']Then Begin
   If Not(Q.Mode in[vtGat,vtHlp])Then Q.PXG:=Q.PX;
   PC:=TEPopCurr(Q);
   Case(Chr)of
    'a':Chr:='„';
    'e':Chr:='‰';
    'f':Chr:='Ÿ';
    'i':Chr:='‹';
    'n':Chr:='¤';
    'o':Chr:='”';
    'u':Chr:='';
    'y':Chr:='˜';
    'A':Chr:='';
    'N':Chr:='¥';
    'U':Chr:='š';
   End;
   PC^[Q.PXG]:=Chr;
   WESetChr(Q.W,Q.X,Q.Y,Chr);
  End;
 End;

 Procedure EndBlock;
 Var
  PC:PChr;
 Begin
  Q.BX1:=Q.BX2;Q.BY1:=Q.BY2;
  TEEndBlk(Q);
  TESetPtr(Q);
  PC:=_ALGetCurrBuf(Q.List);
  Q.PXG:=PosX2Gat1(PC,Q.PX);
 End;

Begin
 OldScrollLck:=GetScrollLck;
 If(Q.Mode)in[vtGat,vtDefault]Then SetScrollLck(Q.ScrollLock);
 TESetCur(Q);
 If(Q.InsMode)Then SimpleCur
              Else FullCur;
 Repeat
  TESetCur(Q);
  If(IsGraf)Then WEPushCur(Q.W);
  __ShowMousePtr;
  _InitKbd;
  Repeat
ReRead:
   _BackKbd;
   K:=WEBackReadk(Q.W);
   If K>0Then Begin
    If(K=kbRBarMsUp)or(K=kbRBarMsDn)or(K=kbRBarMsPgUp)or(K=kbRBarMsPgDn)Then Begin
     If(IsGraf)Then WEPopCur(Q.W);
     __HideMousePtr;
    End;
    Case(K)of
    kbInWn:Begin
     K:=TEActionMouse(Q);
     Case(K)of
      0:;
      Else Goto MouseExit;
     End;
    End;
    kbCompat:Begin
     TP:=WEGetCompatPosition(Q.W,Q.List.Count);
     If(Q.P<>TP)Then Begin
      Q.P:=TP;
      If(Q.P<Q.W.MaxY)Then Q.Y:=Q.P
                      Else Q.Y:=Q.W.MaxY;
      TESetPtr(Q);
      __HideMousePtr;
      TEUpDateScr(Q);
      WESelRightBarPos(Q.W,Q.P,Q.List.Count-1);
      __ShowMousePtr;
      If(IsGraf)Then WEPushCur(Q.W);
     End;
     Goto ReRead;
    End;
    kbZoom,kbClose:Begin
     WaitMouseBut0;
     __HideMousePtr;
     Goto MouseExit;
    End;
    kbMouse:Begin
     If(Q.Mode in[vtBas,vtGat])and(IsGraf)Then Begin
      If(LastMouseY>=Q.W.T.Y1)and(LastMouseY<=Q.W.T.Y1+2)and
        (LastMouseX>=Q.W.T.X1+Byte(Q.W.NotFullScrnX))
         and(LastMouseX<=Q.W.T.X2)Then Begin
       _X:=LastMouseX-(Q.W.T.X1+Byte(Q.W.NotFullScrnX));
       BM:=__GetMouseButton;
       __HideMousePtr;
       WaitMouseBut0;
       Repeat
        Case(_X)of
         0..1:If(Q.Mode=vtGat)Then Begin
          If BM=2Then Begin
           TEInvAttrBlk(Q,cgBold);
           EndBlock;
          End
           Else
          Q.ChrAttr:=Q.ChrAttr xor cgBold;
         End
          Else
         Begin
          K:=kbRun;
          Goto MouseExit;
         End;
         2..3:If BM=2Then Begin
          TEInvAttrBlk(Q,cgUnderline);
          EndBlock;
         End
          Else
         Q.ChrAttr:=Q.ChrAttr xor cgUnderline;
         4..5:If BM=2Then Begin
          TEInvAttrBlk(Q,cgInverse);
          EndBlock;
         End
          Else
         Q.ChrAttr:=Q.ChrAttr xor cgInverse;
         6..7:If BM=2Then Begin
          TEInvAttrBlk(Q,cgItalic);
          EndBlock;
         End
          Else
         Q.ChrAttr:=Q.ChrAttr xor cgItalic;
         8..9:If BM=2Then TEInvAttrBlk(Q,cgExposant)Else Begin
          If(Q.ChrAttr=cgExposant)Then Q.ChrAttr:=cgNormal
                                  Else Q.ChrAttr:=cgExposant;
          System.Break;
         End;
         10..12:If BM=2Then Begin
          TEInvAttrBlk(Q,cgDouble);
          EndBlock;
         End
          Else
         Q.ChrAttr:=Q.ChrAttr xor cgDouble;
         14..16:TESetDrawMode(Q,Not(Q.DrawMode));
         19..21:TECenter(Q,__Left__);        { Centr‚ … gauche }
         22..24:TECenter(Q,__Justified__);   { Centr‚ au milieu }
         25..27:TECenter(Q,__Right__);       { Centr‚ … droite }
         28..30:Q.InterLn:=False; { Simple interligne }
         31..33:Q.InterLn:=True;  { Double interligne }
         34..37:Begin
          If(Q.ModeList=mlNone)Then Q.ModeList:=mlBloc
                               Else Q.ModeList:=mlNone;
          TESetList4Bloc(Q);
         End;
         38..40:Begin
          If(Q.ModeList=mlNone)Then Q.ModeList:=mlRoman
                               Else Q.ModeList:=mlNone;
          Q.ModeListNumber:=1;
          TESetList4Bloc(Q);
         End;
         41..43:Begin
          If(Q.ModeList=mlNone)Then Q.ModeList:=mlArabic
                               Else Q.ModeList:=mlNone;
          Q.ModeListNumber:=1;
          TESetList4Bloc(Q);
         End;
         44..46:Begin
          If(Q.ModeList=mlNone)Then Q.ModeList:=mlAlphabetic
                               Else Q.ModeList:=mlNone;
          Q.ModeListNumber:=1;
          TESetList4Bloc(Q);
         End;
        End;
       Until True;
       If BM<>2Then TESetChrType(Q,Q.ChrAttr);
       __ShowMousePtr;
      End
       Else
      Goto MouseExit;
     End
      Else
     Begin
MouseExit:
      If(IsGrf)Then WEPopCur(Q.W);
      CloseCur;
      TERun:=K;
      Exit;
     End;
    End;
    kbDataBar:Begin
     _X:=LastMouseX-Q.W.T.X1;
     CloseCur;
     __HideMousePtr;
     If(_X)in[24..32]Then If TEChangeView(Q)Then Begin
      TERun:=$FFFF;
      Exit;
     End;
     If(Q.InsMode)Then SimpleCur Else FullCur;
     __ShowMousePtr;
    End;
    kbRBarMsUp:TEkUp(Q);
    kbRBarMsDn:TEkDn(Q);
  kbRBarMsPgUp:TEkPgUp(Q);
  kbRBarMsPgDn:TEkPgDn(Q);
    Else
    Begin
     TERun:=K;
     If(IsGrf)Then WEPopCur(Q.W);
     CloseCur;
     __HideMousePtr;
     Exit;
    End;
    End;
    DelayMousePress(100);
    __ShowMousePtr;
    If(IsGraf)Then WEPushCur(Q.W);
   End
    Else
   If(ShiftPress)Then Begin
    For I:=0to(WaitDelay)do Begin
     _BackKbd;
     WaitRetrace;
     If(KeyPress)Then Goto RunPress;
    End;
ShPress:
    If(AltPress)Then Begin
     If Not(KeyPress)Then Begin
      WEPushEndBar(LT);
      WEPutLastBar('^A^à ^B^á ^C^› ^D^ú ^E^ä ^F^Ÿ ^G^Å ^H^× ^I^¡ ^J^õ '+
                   '^L^â ^M^ì ^N^ü ^O^§ ^P^ ^Q^‘ ^R^Û ^S^ë ^T^ã ^U^ï '+
                   '^V^û ^W^ğ ^Y^ ^Z^í ^<^ó ^>^ò');
      Repeat
       _BackKbd;
       If(Not(AltPress))or(Not(ShiftPress))Then Goto BreakAltBar;
      Until KeyPress;
BreakAltBar:
      WEDone(LT);
      If(AltPress)Then Goto AltPr;
     End;
    End
     Else
    If(CtrlPress)Then Begin
      WEPushEndBar(LT);
      WEPutLastBar('^A^¦ ^B^é ^C^€ ^D^ ^E^î ^F^œ ^G^“ ^H^è ^I^ ^J^ô '+
                   '^K^« ^L^¬ ^M^ ^N^” ^O^ø ^P^å ^Q^‘ ^R^Ü ^T^ç ^U^æ '+
                   '^V^ê ^Y^˜ ^[^© ^]^ª');
      Repeat
       _BackKbd;
       If(Not(CtrlPress))or(Not(ShiftPress))Then Goto BreakCtrlBar;
      Until KeyPress;
BreakCtrlBar:
      WEDone(LT);
    End
     Else
    If Not(GetNmLck)Then Begin
     WEPushEndBar(LT);
     If(GetCapsLck)Then
      WEPutLastBar('Bloc num‚rique: ^.^™ ^0^O ^1^¥ ^2^I '+
                   '^3^I ^4^E ^5^E ^6^ '+
                   '^7^A ^8^ ^9^ ^/^U ^*^U ^-^š '+
                   '^+^€')
      Else
       WEPutLastBar('Bloc num‚rique: ^.^” ^0^“ ^1^¤ ^2^Œ '+
                    '^3^‹ ^4^Š ^5^ˆ ^6^‚ '+
                    '^7^… ^8^ƒ ^9^„ ^/^— ^*^– ^-^ '+
                    '^+^‡');
     Repeat
      _BackKbd;
      If Not(ShiftPress)Then Goto BreakShiftBar;
     Until KeyPress;
BreakShiftBar:
     WEDone(LT);
    End;
   End
    Else
   If(AltPress)Then Begin
    For I:=0to(WaitDelay)do Begin
     _BackKbd;
     WaitRetrace;
     If(KeyPress)Then Goto RunPress;
    End;
AltPr:
    If Not(KeyPress)Then Begin
     WEPushEndBar(LT);
     WEPutLastBar('^[^® ^]^¯ ^<^ó ^>^ò ^?^¨ ^+=^ñ ^~^÷ ^\^³ '+
                  '^-_^Í  Bloc num‚rique: ^/^ö ^*^“ ^-^Ä');
     Repeat
      _BackKbd;
      If(Not(AltPress))or(ShiftPress)Then Goto BreakAltPBar;
     Until KeyPress;
BreakAltPBar:
     WEDone(LT);
     If(ShiftPress)Then Goto ShPress;
    End;
   End;
   If(Q.ScrollLock<>GetScrollLck)Then Begin
    TEPutScrollLck(Q);
    TEkHome(Q);
   End;
{   If(IsGraf)Then WEAniCur(Q.W);}
  Until KeyPress;
RunPress:
  __HideMousePtr;
  K:=ReadKeyTypeWriter;Shift:=ShiftPress;
  If(IsGraf)Then WEPopCur(Q.W);
  Case Lo(K)of
   0:Case Hi(K)of
   Hi(kbCtrlHome),Hi(kbCtrlPgUp):TEHomeText(Q);
   Hi(kbCtrlEnd),Hi(kbCtrlPgDn):TEEndText(Q);
   Hi(kbCtrlLeft):TEkCtrlLeft(Q);
   Hi(kbCtrlRight):TEkCtrlRight(Q);
   Hi(kbLeft):Begin
    If(Q.DrawMode)Then Begin
     {TEkLeft(Q);}LastChr:=TEGetLastChr(Q);
     NextChr:=TEGetNextChr(Q);{TEkRight(Q);}
     UpChr:=TEGetUpChr(Q);
     DnChr:=TEGetDnChr(Q);
     Case(UpChr)of
      '¿','´','µ','¸','Â','Ã','Å','Æ','Ñ','Õ','Ú','³':Case(NextChr)of
       'À','Á','Â','Ã','Å','Ç','Ğ','Ò','Ó','Ö','×','Ú','Ä':Case(DnChr)of
        '´','µ','¾','À','Á','Ã','Å','Æ','Ï','Ô','Ù','³':TESetThisChr(Q,'Å');
        Else TESetThisChr(Q,'Á');
       End;
       Else Case(DnChr)of
        '´','µ','¾','À','Á','Ã','Å','Æ','Ï','Ô','Ù','³':TESetThisChr(Q,'´');
        Else TESetThisChr(Q,'Ù');
       End;
      End;
      Else Case(NextChr)of
       'À','Á','Â','Ã','Å','Ç','Ğ','Ò','Ó','Ö','×','Ú','Ä':Case(DnChr)of
        '´','µ','¾','À','Á','Ã','Å','Æ','Ï','Ô','Ù','³':TESetThisChr(Q,'Â');
	Else TESetThisChr(Q,'Ä');
       End;
       Else Case(DnChr)of
        '´','µ','¾','À','Á','Ã','Å','Æ','Ï','Ô','Ù','³':TESetThisChr(Q,'¿');
	Else TESetThisChr(Q,'Ä');
       End;
      End;
     End;
    End;
    TEkLeft(Q);
   End;
   Hi(kbRight):Begin
    If(Q.DrawMode)Then Begin
     {TEkRight(Q);}
     LastChr:=TEGetLastChr(Q);
     NextChr:=TEGetNextChr(Q);
     {TEkLeft(Q);}
     UpChr:=TEGetUpChr(Q);
     DnChr:=TEGetDnChr(Q);
     Case(UpChr)of
'¿','´','µ','¸','Â','Ã','Å','Æ','Ñ','Õ','Ú','³':Case(LastChr)of
'´','¶','·','½','¿','Á','Â','Å','Ğ','Ò','×','Ù','Ä':Case(DnChr)of
'´','µ','¾','À','Á','Ã','Å','Æ','Ï','Ô','Ù','³':TESetThisChr(Q,'Å');
        Else TESetThisChr(Q,'Á');
       End;
       Else Case(DnChr)of
'´','µ','¾','À','Á','Ã','Å','Æ','Ï','Ô','Ù','³':TESetThisChr(Q,'Ã');
        Else TESetThisChr(Q,'À');
       End;
      End;
      Else Case(LastChr)of
'´','¶','·','½','¿','Á','Â','Å','Ğ','Ò','×','Ù','Ä':Case(DnChr)of
'´','µ','¾','À','Á','Ã','Å','Æ','Ï','Ô','Ù','³':TESetThisChr(Q,'Â');
        Else TESetThisChr(Q,'Ä');
       End;
       Else Case(DnChr)of
'´','µ','¾','À','Á','Ã','Å','Æ','Ï','Ô','Ù','³':TESetThisChr(Q,'Ú');
        Else TESetThisChr(Q,'Ä');
       End;
      End;
     End;
    End;
    TEkRight(Q);
   End;
   Hi(kbDn):Begin
    If(Q.DrawMode)Then Begin
     LastChr:=TEGetLastChr(Q);
     NextChr:=TEGetNextChr(Q);
     UpChr:=TEGetUpChr(Q);
     DnChr:=TEGetDnChr(Q);
     Case(UpChr)of
'¿','´','µ','¸','Â','Ã','Å','Æ','Ñ','Õ','Ú','³':Case(LastChr)of
'´','¶','·','½','¿','Á','Â','Å','Ğ','Ò','×','Ù','Ä':Case(NextChr)of
'À','Á','Â','Ã','Å','Ç','Ğ','Ò','Ó','Ö','×','Ú','Ä':TESetThisChr(Q,'Å');
        Else TESetThisChr(Q,'´');
       End;
       Else Case(NextChr)of
'À','Á','Â','Ã','Å','Ç','Ğ','Ò','Ó','Ö','×','Ú','Ä':TESetThisChr(Q,'Ã');
        Else TESetThisChr(Q,'³');
       End;
      End;
      Else Case(LastChr)of
'´','¶','·','½','¿','Á','Â','Å','Ğ','Ò','×','Ù','Ä':Case(NextChr)of
'À','Á','Â','Ã','Å','Ç','Ğ','Ò','Ó','Ö','×','Ú','Ä':TESetThisChr(Q,'Â');
        Else TESetThisChr(Q,'¿');
       End;
       Else Case(NextChr)of
'À','Á','Â','Ã','Å','Ç','Ğ','Ò','Ó','Ö','×','Ú','Ä':TESetThisChr(Q,'Ú');
        Else TESetThisChr(Q,'³');
       End;
      End;
     End;
    End;
   If(Q.DrawMode)or(Q.Mode=vtHlp)Then Begin
     If Q.P>=Q.List.Count-1Then ALAddLn(Q.List);
    End;
    TEkDn(Q);
   End;
   Hi(kbUp):Begin
    If(Q.DrawMode)Then Begin
     LastChr:=TEGetLastChr(Q);
     NextChr:=TEGetNextChr(Q);
     UpChr:=TEGetUpChr(Q);
     DnChr:=TEGetDnChr(Q);
     Case(DnChr)of
'´','µ','¾','À','Á','Ã','Å','Æ','Ï','Ô','Ù','³' :Case(LastChr)of
'´','¶','·','½','¿','Á','Â','Å','Ğ','Ò','×','Ù','Ä':Case(NextChr)of
'À','Á','Â','Ã','Å','Ç','Ğ','Ò','Ó','Ö','×','Ú','Ä':TESetThisChr(Q,'Å');
        Else TESetThisChr(Q,'´');
       End;
       Else Case(NextChr)of
'À','Á','Â','Ã','Å','Ç','Ğ','Ò','Ó','Ö','×','Ú','Ä':TESetThisChr(Q,'Ã');
        Else TESetThisChr(Q,'³');
       End;
      End;
      Else Case(LastChr)of
'´','¶','·','½','¿','Á','Â','Å','Ğ','Ò','×','Ù','Ä':Case(NextChr)of
'À','Á','Â','Ã','Å','Ç','Ğ','Ò','Ó','Ö','×','Ú','Ä':TESetThisChr(Q,'Á');
        Else TESetThisChr(Q,'Ù');
       End;
       Else Case(NextChr)of
'Ù','Á','Â','Ã','Å','Ç','Ğ','Ò','Ó','Ö','×','Ú','Ä':TESetThisChr(EditorApp(Q),'À');
        Else TESetThisChr(EditorApp(Q),'³');
       End;
      End;
     End;
    End;
    TEkUp(Q);
   End;
   Hi(kbIns):Begin
    If(Shift)Then PushKey(kbShiftIns)
     Else
    Begin
     {$IFDEF NoAsm}
      Q.InsMode:=Not(Q.InsMode);
      TEPutIns(Q);
     {$ELSE}
      ASM
       {$IFDEF FLAT386}
        LEA EAX,Q
        XOR [EAX].EditorApp.InsMode,1
        CALL TEPutIns
       {$ELSE}
        LES DI,Q
        XOR ES:[DI].EditorApp.InsMode,1
        PUSH ES
        PUSH DI
        CALL TEPutIns
       {$ENDIF}
      END;
     {$ENDIF}
     If(Q.InsMode)Then SimpleCur
                  Else FullCur;
    End;
   End;
   Hi(kbDel):TEkDel(Q);
   Hi(kbHome):If Not(GetScrollLck)Then Begin
    If(Shift)Then Q.SheetFormat.X1:=Q.PX
             Else TEkHome(Q);
   End
    Else
   TEkHome(Q);
   Hi(kbEnd):If Not(GetScrollLck)Then Begin
    If(Shift)Then Q.SheetFormat.X2:=Q.PX
             Else TEkEnd(Q);
   End
    else
   TEkEnd(Q);
   Hi(kbPgUp):TEkPgUp(Q);
   Hi(kbPgDn):TEkPgDn(Q);
   Hi(kbCtrlF1):Begin
    CloseCur;
    TEInfoDocument(Q);
    SimpleCur;
   End;
   {$IFNDEF __Windows__}
    Hi(kbCtrlWindows95Menu):Case(Q.Mode)of
     vtAsm:TEAsmStrMacro(Q);
     vtC:TECMacro(Q);
     vtPas:TEPasMacro(Q);
    End;
   {$ENDIF}
   Else Goto Break;
  End;
  $F0:Case Hi(K)of
(*   Hi(kbAltQuestion):{$IFDEF Debug}If(Shift)Then DebugKey:=Not(DebugKey){$ENDIF};*)
   Hi(kbAltQuote):SetTrema;
   0:Goto PushChr;
   Else Goto Break;
  End;
  Else Case(K)of
      kbBS:TEkBS(Q);
     kbTab:TETab(Q);
   kbEnter:TEkEnter(Q);
   kbMouse:Goto Break;
kbCtrl6:SetChapeau;
	Else If(Chr>#31)or((K<32)and(Q.Mode<>vtGat))Then Begin
      PushChr:If Not(Q.DrawMode)Then Begin
	       OldAttr:=Q.ChrAttr;
	       If(Q.Mode=vtGAT)Then Begin
		If(Chr=' ')and(TEIsAttrDbl(Q))and(TEIsAttrUnder(Q))Then Begin
		 Chr:='_';
                 Q.ChrAttr:=cgNormal;
		End;
                _X:=Q.PXG;
	       End
		Else
	       _X:=Q.PX;
	       Ok2:=Q.ScrollLock;
	       If(Ok2)Then Begin
		If(Q.SheetFormat.X2>Q.PX)Then Ok2:=False
		 Else
		Begin
		 If(Chr)in['''','-','.','!','?',',',';',':','(',')',
                           '0'..'9','A'..'Z','_'..'z',
                           '€'..'§','®','¯']Then TELeft4Word(Q);
		 If TEGetLastChr(Q)='-'Then Begin
		  If(Q.PX<Q.SheetFormat.X2)Then Begin
                   TESetThisChr(Q,' ');
                   TEkRight(Q)
                  End;
		 End;
		 TEkEnterIns(Q);
		 TECenterHomeParagraph(Q);
		 TEkEnd(Q);
		 If Chr<>' 'Then Begin
		  TESetThisChr(Q,Char(K));
		  TEkRight(Q);
		 End;
		End;
	       End;
	       If Not(Ok2)Then Begin
		TESetThisChr(Q,Chr);
		TEkRight(Q);
	       End;
	       Q.ChrAttr:=OldAttr;
	      End
	       Else
	      Goto Break;
	     End
	      Else
	     Goto Break;
  End;
  End;
 Until False;
Break:
(* {$IFDEF Debug}If(DebugKey)Then DialogMsgOk('Code Clavier = '+HexWord2Str(K)+'h');{$ENDIF}*)
 CloseCur;
 SetScrollLck(OldScrollLck);
 TERun:=K;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Proc‚dure TESetChrType                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: Edt


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure fixe en fonction de la variable de param‚trage ®M¯ le mode
 de caractŠre devant ˆtre utilis‚  dor‚navant dans le traŒtement de texte de
 l'objet d'‚dition.
}

Procedure TESetChrType;Begin
 Q.ChrAttr:=M;
 If(IsGraf)Then TEPutKeyTxt(Q);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                             Proc‚dure TESetCur                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: Edt


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure affiche la curseur … sa position respective par rapport au
 texte.  Elle fixe ‚galement la position du pointeur de la rŠgle lorsqu'elle
 est active.
}

Procedure TESetCur;
Var
 X,TX,TY:Byte;
 Chr:Char;
 OldSetHomeLine:Byte;
Begin
 If(Q.Mode in[vtGat])and(Q.ScrollLock)and(Q.X<Q.SheetFormat.X1)and(Q.PX<Q.SheetFormat.X1)Then TEkHome(Q);
 If(eBarUp)in(Q.Option)Then Begin
  OldSetHomeLine:=Q.W.LineHome;
  WESetHomeLine(Q.W,2);
 End;
 WESetPos(Q.W,Q.X,Q.Y);
 If(Q.Mode=vtGat)and(GetScrollLck)and(Q.PX>Q.SheetFormat.X2)Then Begin
  X:=Q.X-(Q.PX-Q.SheetFormat.X2)
 End
  Else
 X:=Q.X;
 WESetCurPos(Q.W,X,Q.Y);
 If(eBarUp)in(Q.Option)Then WESetHomeLine(Q.W,OldSetHomeLine);
 If(Rules)and Not((eNoRules)in(Q.Option))Then Begin
  If(eBarUp)in(Q.Option)Then Begin
   WESetHomeLine(Q.W,0);
  End;
  If(Q.OldXRules<>X)Then Begin
(*   {$IFDEF NoAsm}*)
    If Q.OldXRules<$FFThen Begin
     If(Q.OldXRules<=Q.W.MaxX)Then Begin
      TX:=WEGetRX1(Q.W)+Q.OldXRules;
      TY:=WEGetRY1(Q.W)+Q.W.MaxY+1;
      If(IsGrf)Then Begin
       Chr:=GetChr(TX,TY);
       If(Chr)in[#0,' ']Then PutAiguillon(TX,TY)
       Else PutSmlTxtXY(TX,TY,Chr,Q.W.Palette.Border)
      End
       Else
      SetAttr(TX,TY,Q.W.Palette.Border);
     End;
    End;
    Q.OldXRules:=X;
(*   {$ELSE}
    ASM
     LES DI,Q
     CMP ES:[DI].Edt.OldXRules,$FF
     JE  @3
     ADD DI,Offset Edt.W
     PUSH ES
     PUSH DI
     CALL WEGetRX1
     LES DI,Q
     ADD AL,ES:[DI].Edt.OldXRules
     PUSH AX
     MOV AL,ES:[DI].Edt.W.Y1
     ADD AL,ES:[DI].Edt.W.MaxY
     ADD AL,2
     PUSH AX
     PUSH Word Ptr ES:[DI].Edt.W.XColrs.Border
     CALL SetAttr
@3:  LES DI,Q
     MOV AL,X
     MOV ES:[DI].Edt.OldXRules,AL
    END;
   {$ENDIF}*)
   If(X<=Q.W.MaxX)Then Begin
    TX:=WEGetRX1(Q.W)+X;
    TY:=Q.W.T.Y1+Q.W.MaxY+2{Q.W.Y2-1};
    If(IsGrf)Then PutSmlTxtXY(TX,TY,GetChr(TX,TY),Not(Q.W.Palette.Border))
             Else SetAttr(TX,TY,Not(Q.W.Palette.Border));
   End;
  End;
  If(eBarUp)in(Q.Option)Then WESetHomeLine(Q.W,2);
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure TESetDrawMode                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: Edt


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure fixe le traŒtement de texte de l'objet d'‚dition en mode
 dessin  si celui  ce ne l'est  pas sinon  il revient au mode normal,  non
 dessin.
}

Procedure TESetDrawMode;Begin
 If(Q.Mode=vtHlp)Then Exit;
 Q.DrawMode:=M;Q.InsMode:=Not(Q.InsMode);
 SetInsMode(Q.InsMode);
 TEPutIns(Q);
 If(Q.Mode in[vtBas,vtGat])Then TEPutKeyTxt(Q);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Proc‚dure TESetFormat                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: Edt


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure fixe le format d'une page de document de l'objet d'‚dition
 de traŒtement de texte.
}

Procedure TESetFormat;Begin
 If(Q.Mode=vtGAT)and(SetFormatPage(Q.SheetFormat))Then Begin
  If Q.SheetFormat.X1>0Then TEInsSpcIfHome(Q,Q.SheetFormat.X1);
  TEPutKeyTxt(Q);
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Proc‚dure TESetThisChr                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: Edt


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure entre un caractŠre dans le traŒtement de texte en tenant
 compte du mode d'Insertion ou d'‚crasement.
}

Procedure TESetThisChr;
Label OutMem;
Var
 PC,NewPBuf:PChr;
 L,_X:Word;
 Ptr:Pointer Absolute PC;
Begin
 If(Q.ReadOnly)Then Exit;
 If(Q.Mode=vtGAT)Then Begin
  If Chr in[#0..#31]Then Chr:=' ';
  If(Chr=' ')and(Q.ChrAttr and(cgDouble+cgUnderline)=cgDouble+cgUnderline)Then Begin
   Chr:='_';Q.ChrAttr:=cgNormal;
  End;
  _X:=Q.PXG;
 End
  Else
 Begin
  If Chr=#0Then Chr:=' ';
  _X:=Q.PX
 End;
 PC:=TEPopCurr(Q);L:=StrLen(PC);
 If L>=65520Then Begin
  WarningMsgOk('Impossible de d‚passer la limite de 65520 octets par ligne!');
  Exit
 End;
 If L=0Then Begin
  Case(_X)of
   0:Begin
    ALPopCurrPtr(Q.List,Q.CurrPtr);
    PC:=ALSetCurrBuf(Q.List,3);
    If(PC=NIL)Then Goto OutMem;
    If(Q.Mode=vtGAT)and(Q.ChrAttr>0)and(Chr<>' ')Then Begin
     StrCopy2Chr(PC,Char(Q.ChrAttr),Chr);
     Inc(Q.FileSize,LongInt(2))
    End
     Else
    Begin
     StrCopyChr(PC,Chr);
     Inc(Q.FileSize)
    End;
    Q.CurrPtr:=ALPushCurrPtr(Q.List);
   End;
   Else Begin
    Repeat
     If(Q.Mode=vtGAT)Then Begin
      If(Q.ChrAttr>0)and(Chr<>' ')Then Begin
       ALPopCurrPtr(Q.List,Q.CurrPtr);
       PC:=ALSetCurrBuf(Q.List,Q.PXG+3);
       If(PC=NIL)Then Goto OutMem;
       FillSpc(PC^[0],Q.PXG);
       StrCopy2Chr(@PC^[Q.PXG],Char(Q.ChrAttr),Chr);
       Inc(Q.FileSize,LongInt(1));
       Break
      End
     End
      Else
     Q.PXG:=Q.PX;
     ALPopCurrPtr(Q.List,Q.CurrPtr);
     PC:=ALSetCurrBuf(Q.List,Q.PXG+2);
     If(PC=NIL)Then Goto OutMem;
     PC^[0]:=#0;StrInsChr(PC,Q.PXG,Chr);
    Until True;
    Q.CurrPtr:=ALPushCurrPtr(Q.List);
    Inc(Q.FileSize,Long(Q.PXG));
    TEChkMaxLen(Q,L);
    TEUpDateInfo(Q);
   End;
  End;
  {$IFNDEF __Windows__}
   TEUpDateLn(Q);
  {$ENDIF}
 End
  else
 If(L>_X)Then Begin
  If(Q.InsMode)Then Begin
   If Not TEInsChr(Q,L,PC,Chr)Then Goto OutMem;
  End
   Else
  Begin
   If(Q.Mode=vtGAT)Then Begin
    If(Q.ChrAttr>0)and(Chr<>' ')Then Begin
     If PC^[Q.PXG]in[#1..#31]Then Begin
      PC^[Q.PXG]:=Char(Q.ChrAttr);PC^[Q.PXG+1]:=Chr
     End
      Else
     Begin
      StrDel(PC,Q.PXG,1);Dec(L);
      If Not TEInsChr(Q,L,PC,Chr)Then Goto OutMem;
     End
    End
     Else
    Begin
     If PC^[Q.PXG]in[#1..#31]Then StrDel(PC,Q.PXG,1);
     PC^[Q.PXG]:=Chr
    End;
   End
    Else
   PC^[Q.PX]:=Chr;
   {$IFNDEF __Windows__}
    TEUpDateLn(Q)
   {$ENDIF}
  End
 End
  else
 Begin
  NewPBuf:=StrNew(PC);
  If(NewPBuf=NIL)Then Goto OutMem;
  Repeat
   If(Q.Mode=vtGAT)Then Begin
    If(Q.ChrAttr>0)and(Chr<>' ')Then Begin
     ALPopCurrPtr(Q.List,Q.CurrPtr);
     PC:=ALSetCurrBuf(Q.List,Q.PXG+3);
     If(PC=NIL)Then Goto OutMem;
     MoveLeft(NewPBuf^,PC^,L+1);
     StrInsChr(PC,Q.PXG,Char(Q.ChrAttr));
     StrCopyChr(@PC^[Q.PXG+1],Chr);
     Inc(Q.FileSize,LongInt(Q.PXG-L+2));
     Break
    End;
   End
    Else
   Q.PXG:=Q.PX;
   ALPopCurrPtr(Q.List,Q.CurrPtr);
   PC:=ALSetCurrBuf(Q.List,Q.PXG+2);
   If(PC=NIL)Then Goto OutMem;
   StrCopy(PC,NewPBuf);
   StrInsChr(PC,Q.PXG,Chr);
   Inc(Q.FileSize,LongInt(Q.PXG-L+1))
  Until True;
  Q.CurrPtr:=ALPushCurrPtr(Q.List);
  If(Q.Mode=vtGat)Then Begin
   Q.W.CurrColor:=CurrKrs.Editor.Env.Typewriter;
   If(Q.X>L)Then WEBarSpcHor(Q.W,L,Q.Y,Q.X-1);
   Q.W.X:=Q.X;Q.W.Y:=Q.Y;
   If Q.ChrAttr=0Then WESetCube(Q.W,Q.W.X,Q.W.Y,Chr)
                 Else WEPutChrGAttr(Q.W,Chr,Q.ChrAttr);
   If(MarkEnd)Then Begin
    If(Chr=' ')Then Begin
     If(Q.ChrAttr and cgDouble<>cgDouble)Then WESetCube(Q.W,Q.W.X,Q.W.Y,' ');
     Dec(Q.W.X)
    End;
    If(Chr=' ')or(Q.W.X>=Q.SheetFormat.X2)Then Begin
     If(Q.W.MaxX>Q.W.X)Then Begin
      {$IFDEF Adele}
       UnSelIcon(WEGetRealX(Q.W),WEGetRealY(Q.W),(Q.W.CurrColor and $F0)+3);
      {$ELSE}
       Str:=UnSelIcon;
       If(Q.W.X+Length(Str)>Q.W.MaxX)Then Str[0]:=Chr(Q.W.MaxX-Q.W.X);
       PutTxtLuxe(WEGetRealX(Q.W),WEGetRealY(Q.W),Str,Q.W.Kr);
      {$ENDIF}
     End;
    End
     Else
    {If Not(IsGrf)Then} WEPutTxt(Q.W,'  ');
   End;
  End
  {$IFNDEF __Windows__}
    Else
   TEUpDateLn(Q)
  {$ENDIF};
  StrDispose(NewPBuf);
  TEChkMaxLen(Q,L);
  {$IFNDEF __Windows__}
   TEUpDateInfo(Q);
  {$ENDIF}
 End;
 _TESetModified(Q);
 Exit;
OutMem:
 __OutOfMemory;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Proc‚dure TESetViewMode                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: Edt


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure fixe le mode de visualisation actuel: Document, Pascal, C/
 C++, Fortran,...
}

Procedure TESetViewMode;Begin
 If(Q.Mode<>M)Then Begin
  Q.Mode:=M;
  TEInitLang(Q);
  If(Q.Mode in[vtBas,vtGat])and(IsGraf)Then Begin
   Include(Q.Option,eBarUp);
  End;
  TEPutViewMode(Q);
  TEUpDateScr(Q);
  TEPutPos(Q);
  If(Q.Mode in[vtBas,vtGat])and((eBarUp)in(Q.Option))Then Begin
   If(eBarUp)in(Q.Option)Then WESetHomeLine(Q.W,0);
   Q.W.MaxY:=Q.W.T.Y2-Q.W.T.Y1-{4}3;
   TEPutKeyTxt(Q);
  End;
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure TESetWn                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: Edt


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure fixe une position de fenˆtre (X1,Y1)-(X2,Y2) pour le
 traŒtement de texte.  Dor‚navant,  l'objet  d'‚dition  sera contr‚ de
 fonctionner dans cette zone avec son environnement bordulaire.
}

Procedure TESetWn;Begin
 TEPutWn(Q,X1,Y1,X2,Y2);
 TEInitCoord(Q);
 TEUpDateScr(Q);
 TEPutBar(Q);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure TESetWord                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: Edt


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure effectue une changement de style de votre mot courant.
 Selon la technique d‚finit par la variable paramŠtre ®ChrMode¯.
}

Procedure TESetWord;
Const
 MacSetWord:Array[0..4]of Char=macCtrlRight+macSetModified+macUpDateInfo+macUpDateLn+#0;
Var
 PC,NewPChr:PChr;
 L,I,N:Word;
Begin
 If(Q.ReadOnly)Then Exit;
 If(Q.Mode=vtGat)or(ChrMode in[cgDouble,cgBold,cgItalic])Then Begin
  PC:=TEPopCurr(Q);L:=StrLen(PC);
  If L=0Then TEkCtrlRight(Q)
   Else
  If(Q.Mode<>vtGat)Then Begin
   If(Q.PX>L)Then Exit;
   If(ChrMode=cgDouble)Then Begin
    PC^[Q.PX]:=ChrUp(PC^[Q.PX]);Inc(Q.PX);Inc(Q.X)
   End
    Else
   While PC^[Q.PX]in['A'..'Z','a'..'z']do Begin
    If(ChrMode=cgItalic)Then PC^[Q.PX]:=ChrDn(PC^[Q.PX])
    Else PC^[Q.PX]:=ChrUp(PC^[Q.PX]);
    Inc(Q.PX);Inc(Q.X)
   End;
   TEUpDateLn(Q);
   _TESetModified(Q);
  End
   Else
  Begin
   If(Q.PXG>L)Then Exit;
   If(PC^[Q.PXG]in[#0,' '])and(Q.PX>Q.SheetFormat.X1)Then TEkCtrlLeft(Q);
   I:=Q.PXG;N:=0;
   If PC^[I]=Char(ChrMode)Then Begin
    TEkCtrlRight(Q);
    TEkCtrlRight(Q)
   End
    Else
   Begin
    While Not(PC^[I]in[#0,' '])do Begin
     If PC^[I]in[#33..#254]Then Inc(N);
     Inc(I);
    End;
    If N=0Then Begin
     TEkCtrlRight(Q);
     Exit;
    End;
    NewPChr:=MemAlloc(L+N+1);
    If(NewPChr=NIL)Then Exit;
    SetGatAttr(L,PC,NewPChr^[0],Q.PX,N,ChrMode);
    PC:=ALSet(Q.List,Q.P,L+N+1);
    If(PC=NIL)Then Exit;
    Q.CurrPtr:=ALPushCurrPtr(Q.List);
    MoveLeft(NewPChr^,PC^,L+N+1);
    FreeMemory(NewPChr,L+N+1);
    TEMacro(Q,@MacSetWord)
   End;
  End;
 End
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure TEUnderlineWord                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: Edt


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure modifie le mot courant pour qu'il soit en format soulign‚
 seulement. S'il se trouve sur un espace, il affecte le mot pr‚c‚dent.
}

Procedure TEUnderlineWord;Begin
 {$IFDEF __Windows__}
  TESetWord(Q,cgUnderline);
 {$ELSE}
  Case(Q.Mode)of
   vtAsm:TEAsmStrMacro(Q);
   vtC:TECMacro(Q);
   vtPas:TEPasMacro(Q);
   Else TESetWord(Q,cgUnderline);
  End;
 {$ENDIF}
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Proc‚dure TEUpDateEOS                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: Edt


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure fait une mise … jour de l'‚cran de la position actuel
 vertical du pointeur texte jusqu'… la fin de la fenˆtre. Toutefois, il
 ne s'occupe  que du texte en tant  que tel  et ne fait  pas une mise …
 jour au niveau des indicateurs.
}

Procedure TEUpDateEOS;
Var
 PC:PChr;
 J,M:Byte;
 Size,X,XBlk:Word;
 {$IFDEF SepLn}
  Ok:Boolean;
  Y:Byte;
 {$ENDIF}
Begin
 Q.W.X:=0;Q.W.Y:=Q.Y;
 {$IFDEF SepLn}
  Ok:=Q.P mod(Q.SheetFormat.Y2-Q.SheetFormat.Y1)=Q.Y;
  Y:=Q.Y;
  If Not(Ok)Then If(Q.P-Q.Y)div(Q.SheetFormat.Y2-Q.SheetFormat.Y1)<>Q.P div(Q.SheetFormat.Y2-Q.SheetFormat.Y1)Then Dec(Y);
 {$ENDIF}
 ALSetPtr(Q.List,Q.P);
 M:=Q.W.MaxY;X:=Q.PX-Q.X;XBlk:=0;
 For J:=Q.Y to(M)do Begin
  {$IFDEF SepLn}
   If Q.P>0Then If(Q.P-Y+J)mod(Q.SheetFormat.Y2-Q.SheetFormat.Y1)=0Then Begin
    WEPutTxtLn(Q.W,MultChr('ú',Q.W.MaxX+1));
    {$IFNDEF __Windows__}
     Inc(J);
    {$ENDIF}
    Inc(XBlk);
    If(J>{=}M)Then Exit;
   End;
  {$ENDIF}
  PC:=ALGetCurrBuf(Q.List,Size);
  _TEPutLnProc(Q._PutLn)(Q,Size,X,Q.P+J-XBlk,PC);
  ALNext(Q.List);
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Proc‚dure TEUpDateInfo                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: Edt


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure met … jour  que les indicateurs  du traŒtement  sans ce
 soucier  ni mˆme  de la  barre  o— il  l'affiche.  Si le clavier  est en
 action, le traŒtement de texte en d‚duit que cette op‚ration est inutile
 compte tenu qu'il aura … le r‚actualis‚ de toutes fa‡on.
}

Procedure TEUpDateInfo;Begin
 If(KeyPress)Then Exit;
 TEPutBarXYM(Q,Q.StrMX,Q.List.Count,Q.FileSize);
 PutMemory;
 TEPutPos(Q);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure TEUpDateLn                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: Edt


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure actualise la ligne actuellement en usage du traitement de
 texte (d‚finit par le pointeur de texte). Il ne met pas … jour sa position
 visuel met se fait aux donn‚es interne actuellement en usage.
}

Procedure TEUpDateLn;
Var
 PC:PChr;   { Pointeur sur la ligne de traŒtement de texte courant }
 Size:Word; { Taille physique de la ligne de traŒtement de texte courant }
Begin
 ALPopCurrPtr(Q.List,Q.CurrPtr);
 PC:=ALGetCurrBuf(Q.List,Size);Q.W.X:=0;
 _TEPutLnProc(Q._PutLn)(Q,Size,Q.PX-Q.X,Q.P,PC);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure TEUpDateScr                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: Edt


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure met … jour tout le texte de la fenˆtre sans exception. Il
 ne tient pourtant pas compte  des indicateurs dans sa d‚marrache.  Il faut
 donc les mettres … jour par une autre proc‚dure.
}

Procedure TEUpDateScr;
Var
 PC:PChr;
 J,M:Byte;
 Size,_X,XBlk:Word;
 PY:RBP;
 {$IFDEF SepLn}
  Ok:Boolean;
 {$ENDIF}
Begin
 WESetPosHome(Q.W);
 PY:=Q.P-Long(Q.Y);
 Q.RefreshRules:=True;
 {$IFDEF SepLn}
  Ok:=Q.P mod(Q.SheetFormat.Y2-Q.SheetFormat.Y1)=Q.Y;
  If Not(Ok)Then Begin
   If PY div(Q.SheetFormat.Y2-Q.SheetFormat.Y1)<>Q.P div(Q.SheetFormat.Y2-Q.SheetFormat.Y1)Then Inc(PY);
  End;
 {$ENDIF}
 ALSetPtr(Q.List,PY);
{ Old:=RBPushCurrPtr(Q.Lst);}
 M:=Q.W.MaxY;_X:=Q.PX-Q.X;XBlk:=PY;
 For J:=0to(M)do Begin
  {$IFDEF SepLn}
   If Not((J=0)and(Ok))Then
   If PY>0Then If(PY+J)mod(Q.SheetFormat.Y2-Q.SheetFormat.Y1)=0Then Begin
    WEPutTxtLn(Q.W,MultChr('ú',Q.W.MaxX+1));
    {$IFNDEF __Windows__}
     Inc(J);
    {$ENDIF}
    If(J>{=}M)Then Begin
     TEPutRules(Q);
     Exit;
    End;
   End;
  {$ENDIF}
  PC:=ALGetCurrBuf(Q.List,Size);
  _TEPutLnProc(Q._PutLn)(Q,Size,_X,XBlk,PC);
  Inc(XBlk);
  ALNext(Q.List);
 End;
 TEPutRules(Q);
{ RBPopCurrPtr(Q.Lst,Old);}
End;

Function TEGetUpChr;
Var
 PC:PChr;
 L,P:Word;
Begin
 TEGetUpChr:=#0;
 If Q.P>0Then Begin
  ALPopCurrPtr(Q.List,Q.CurrPtr);
  ALPrevious(Q.List);
  PC:=_ALGetCurrBuf(Q.List);
  ALNext(Q.List);
  If(PC<>NIL)Then Begin
   L:=StrLen(PC);
   If Q.Mode in[vtGat,vtHlp]Then Begin
    P:=PosX2Gat1(PC,Q.PX);
    If(P<=L)Then TEGetUpChr:=PC^[P]
   End
    Else
   If(L>=Q.PX)Then TEGetUpChr:=PC^[Q.PX]
  End;
 End;
End;

Function TEGetDnChr;
Var
 PC:PChr;
 L,P:Word;
Begin
 TEGetDnChr:=#0;
 If Q.P<Q.List.Count-1Then Begin
  ALPopCurrPtr(Q.List,Q.CurrPtr);
  ALNext(Q.List);
  PC:=_ALGetCurrBuf(Q.List);
  ALPrevious(Q.List);
  L:=StrLen(PC);
  If Q.Mode in[vtGat,vtHlp]Then Begin
   P:=PosX2Gat1(PC,Q.PX);
   If(P<=L)Then TEGetDnChr:=PC^[P]
  End
   Else
  If(L>=Q.PX)Then TEGetDnChr:=PC^[Q.PX]
 End;
End;

{ Cette fonction permet d'indiquer si le caractŠre de traŒtement de texte
 se trouve en mode double largeur de caractŠre.
}

Function TEIsDbl;
{$IFDEF NoAsm}
 Begin
  TEIsDbl:=Byte(Chr)and cgDouble=cgDouble;
 End;
{$ELSE}
 Assembler;ASM
  XOR  AL,AL
  TEST Chr,cgDouble
  JZ   @1
  MOV  AL,1
@1:
 END;
{$ENDIF}

{ Cette fonction permet d'indiquer si le traŒtement de texte se trouve
 … ˆtre en mode double largeur de caractŠre.
}

Function TEIsAttrDbl;
{$IFDEF NoAsm}
 Begin;
  TEIsAttrDbl:=Q.ChrAttr and cgDouble=cgDouble
 End;
{$ELSE}
 Assembler;ASM
  {$IFDEF FLAT386}
   XOR  AL,AL
   LEA  ECX,DWord Ptr Q
   TEST [ECX].EditorApp.ChrAttr,cgDouble
   JZ   @1
   MOV  AL,1
@1:
  {$ELSE}
   XOR  AL,AL
   LES  DI,Q
   TEST ES:[DI].EditorApp.ChrAttr,cgDouble
   JZ   @1
   MOV  AL,1
@1:
  {$ENDIF}
 END;
{$ENDIF}

{ Cette fonction permet d'indiquer si le traŒtement de texte se trouve
 actuellement en mode soulignement.
}

Function TEIsAttrUnder;
{$IFDEF NoAsm}
 Begin
  TEIsAttrUnder:=Q.ChrAttr and cgUnderline=cgUnderline
 End;
{$ELSE}
 Assembler;ASM
  {$IFDEF FLAT386}
   XOR  AL,AL
   LEA  ECX,DWord Ptr Q
   TEST [ECX].EditorApp.ChrAttr,cgUnderline
   JZ   @1
   MOV  AL,1
@1:
  {$ELSE}
   XOR  AL,AL
   LES  DI,Q
   TEST ES:[DI].EditorApp.ChrAttr,cgUnderline
   JZ   @1
   MOV  AL,1
@1:
  {$ENDIF}
 END;
{$ENDIF}

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
END.