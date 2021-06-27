{TextEdit.Inc}

{$IFNDEF __TextEdit}
 {$DEFINE __TextEdit}

Const
  { Retourne les valuer de Gestalt }
 gestaltUndefSelectorErr=0;   { AprŠs MAC/OS System 6.0.4, de multiple style
                                de ®TextEdit¯ sont disponibles sur tous les
                                mat‚riels }
 gestaltTE1=1;                { System 6.0.4 systŠme scripte Romain dans le
                                mat‚riel de la famille Ici }
 gestaltTE2=2;                { Gestionnaire de scripte compatible. System
                                6.0.4 de scripte non-Romain dans le mat‚riel.
                                New (nouveau mat‚riel) de la famille Ici
                                accrochant les mesures de nWIDTHHook. }
 gestaltTE3=3;                { Gestionnaire de scripte compatible. System
                                6.0.4 de scripte non-Romain n'‚tant pas du
                                mat‚riel de la famille des Ici }
 gestaltTE4=4;                { Gestionnaire de scripte compatible. System
                                6.0.5 de tous mat‚riel. Nouvelle fonction
                                drapeau de ®TEFeature¯. }
 gestaltTE5=5;                { Gestionnaire de scripte compatible. System
                                7.0 de tous mat‚riel. }

  { Styles d'allignement: Nouveau noms de constante pour les paramŠtres
                          d'alignement:TESetAlignment&TETextBox}
 teFlushDefault=0;{ Nettoyage tous d‚pendament de l'orientation du systŠme }
 teCenter=1;      { Centre pour tous scriptes }
 teFlushRight=-1; { Nettoyage de la gauche de tous les scriptes }
 teFlushLeft=-2;  { Nettoyage de la droite de tous les scriptes }

  { Styles d'alignement; ancienne noms de constante support‚ pour une
    compatibilit‚ ant‚rieur }
 teJustLeft=0;
 teJustCenter=1;
 teJustRight=-1;
 teJustForceLeft=-2;

  { Valeur fournit pour les paramŠtres de TEFeatureFlag }
 teFAutoScroll=0;      { "Scrolling" automatique }
 teFAutoScr=0;         { Ancienne constante de "Scrolling" }
 teFTextBuffering=1;   { Temporisation de texte }
 teFOutlineHilite=2;   { "highlighting" hors ligne }
 teFInLineInput=3;     { Entr‚e en ligne }
 teFUseTextServices=4; { Utilise entr‚e service en ligne }

  { Valeur pour l'action des paramŠtres TEFeatureFlag }
 teBitClear=0;         { Efface les fournitures TEFeatureFlag }
 teBitSet=1;           { Fourniture d'ensemble de TEFeatureFlag }
 teBitTest=-1;         { Teste l'ancienne fourniture TEFeature:
                         Retourne l'ensemble courant }

  { S‚lecteurs pour l'identification de routine d'appelle TEFindWord }
 teWordSelect=4; { Appelle pour d‚terminer ligne d'arrˆte }
 teWordDrag=8;   { Appelle pour s‚lectionner des mots ‚tendues }
 teFromFind=12;  { Appelle pour s‚lectionner des mots }
 teFromRecal=16; { Appelle pour l'arrˆte en ligne de recalculation de mot }

  { Valeur pour les modes TSSetStyle/TEContinuousStyle/TEReplaceStyle }
 doFont=1;    { Ensemble de nombre de la famille de police }
 doFace=2;    { Ensemble de style de caractŠre }
 doSize=4;    { Ensemble de type de taille }
 doColor=8;   { Ensemble de couleur }
 doAll=15;    { Ensemble de toutes les attributs }
 addSize=16;  { Type de taille ajustable }
 doToggle=32; { Mode "toggle" pour TESetStyle }

  { S‚lecteur pour TECustomHook }
 intEOLHook=0;        { Fin de ligne de "crochet" }
 intDrawHook=1;       { Dessinage de "crochet" }
 intWidthHook=2;      { Mesure la largeur du "crochet" }
 intHitTestHook=3;    { Teste "Hit" de "Crochet" }
 intNWidthHook=6;     { Mesure de "Crochet" nWIDTHHook }
 intTextWidthHook =7; { Mesure de "Crochet" TextWidth }

Type
 TERec=Record
  destRect,viewRect,selRect:Rect; { Rectangle de destination, Rectangle "View", la s‚lection de rectangle }
  lineHeight,fontAscent:Integer;  { Utiliser pour l'espacement vertical entre ligne, position caret/highlight }
  selPoint:Point;                 { S‚lection avec le point de souris }
  selStart,selEnd:Integer;        { Commen‡ement et fin de la rang‚ de s‚lection }
  active:Integer;                 { Fixe l'enregistrement actif/inactif }
  wordBreak,clipLoop:ProcPtr;     { Arrˆt du mot du "crochet", la boucle d'attachement }
  clockTime:LongInt;              { Usage interne }
  clickLoc:Integer;               { Usage interne }
  caretTime:LongInt;              { Usage interne }
  just,teLength:Integer;          { Alignement de texte; longueur du texte }
  hText:Handle;                   { Le texte handle … ˆtre ‚dit‚ }
  hDispatchRec:LongInt;           { Handle … TextEdit pour l'exp‚dition de l'enregistrement }
  clikStuff:Integer;              { Usage interne }
  crOnly,txFont:Integer;          { Si <0, nouvelle ligne … retour seulement, police de texte }
  txFace:Style;                   { Style de caractŠre; octet d‚compact‚ }
  txMode:Integer;                 { Mode plume }
  txSize:Integer;                 { Valeur indiquant l'une ou l'autre des multiples styles d'enregistrement
                                    d'‚dition ou une taille de police }
  inPort:GrafPtr;                 { Un pointeur … la grafPort pour ces TERec }
  highHook,caretHook:ProcPtr;     { Utilise pour le texte "hightlighting";utilis‚ pour l'apparence du "caret"}
  nLines:Integer;                 { Nombre de lignes }
  lineStarts:Array[0..16000] of Integer; { Position du commencement de ligne }
 End;
 TEPtr=^TERec;
 TEHandle=^TEPtr;
 Chars=Packed Array[0..32000] of Char;
 CharsHandle=^CharPtr;
 CharsPtr=^Chars;

 TEStyleRec=Record
  nRuns,nStyles:Integer;          { Nombre de style d'ex‚cution; Taille de la table de style }
  styleTab:STHandle;              { Handle de la table de style }
  lhTab:LHHandle;                 { Handle de la hauteur de la table de ligne }
  teRefCon:LongInt;               { R‚serv‚ pour l'usage d'application }
  nullStyle:NullStHandle;         { Handle … style d'ensemble … s‚lection nulle }
  runs:Array[0..8000]of StyleRun; { Tableau de 8001 ‚l‚ment de StyleRun }
 End;
 TEStylePtr=^TEStyleRece;
 TEStyleHandle=^TEStylePtr;

 StyleRun=Record
  startChar,styleIndex:Integer;
  {Commen‡ement de la position du caractŠre; Index dans la table}
 End;

 STElement=Record
  stCount,stHeight:Integer; { Nombre d'ex‚cution dans ce style; hauteur de ligne }
  stAscent,stFont:Integer;  { Mont‚ de la police; num‚ro de la famille de police }
  stFace:Style;             { Style de caractŠre }
  stSize:Integer;           { Taille des points }
  stColor:RGBColor;         { Couleur RGB absolue }
 End;

 STPtr=^TEStyleTable;
 STHandle=^STPTr;
 TEStyleTable=Array[0..1776] of STElement;
 LHElement=Record lhHeight,lhAscent:Integer; { Hauteur et mont‚ maximal en ligne } End;
 LHPtr=^LHTable;
 LHHandle=^LHPtr;
 LHTable=Array[0..8000] of LHElement;

 ScrpSTElement=Record
  scrpStartChar:LongInt;         { Commen‡ement du style d'Offset }
  scrpHeight,scrpAscent:Integer; { Hauteur de ligne, mont‚ de la police }
  scrpFont:Integer;              { Num‚ro de la famille de la police }
  scrpFace:Style;                { Style de caractŠre }
  scrpSize:Integer;              { Taille des points }
  scrpColor:RGBColor;            { Couleur RGB absolu }
 End;

 StScrpRec=Record
  scrpNStyles:Integer; scrpSTyleTab:ScrpSTTable; { Nombre de styles et table de style dans scrap }
 End;
 StScrpPtr=^StScrpRec;
 StScrpHandle=^StScrpPtr;

 NullStRec=Record teReserved:LongInt; nullScrap:StScpHandle; { R‚serv‚; Handle de style de table scrap} End;
 NullStPtr=^NullStRec;
 NullStHandle=^NullStPtr;

 TextStyle=Record
  tsFont:Integer;tsFace:Style;     { Num‚ro de la famille de police; Style de caractŠre }
  tsSize:Integer;tsColor:RGBColor; { Taille des points; couleur RGB absolue }
 End;
 TextStylePtr=^TextStyle;
 TextStyleHandle=^TextStylePtr;
 TEIntHook=Integer;

 { Initilisation de TextEdit, Cr‚ation d'un enregistrement d'‚dit., et dipositif dans un enregistrement ‚dit.}
Procedure TEInit;Forward;
Function  TEStyleNew(destRect:Rect;viewRect:Rect):TEHandle;Forward;
Procedure TEDispose(hTE:TEHandle);Forward;

 { Activation/D‚sactivation d'un enregistrement d'‚dition }
Procedure TEActivate(hTE:TEHandle);Forward;
Procedure TEDesativate(hTE:TEHandle);Forward;

 { Demande/Fixe un enregistrement d'‚dition et les informations d'attribut du caractŠre }
Procedure TEKey(key:Char;hTE:THHandle);Forward;
Procedure TESetText(text:Ptr;length:LongInt;hTE:TEHandle);Forward;
Function  TEGetText(hTE:TEHandle):CharsHandle;Forward;
Procedure TESetStyleHandle(theHandle:TEStyleHandle;hTE:TEHandle);Forward;
Function  TEGetStyleHandle(hTE:TEHandle):TEStyleHandle;Forward;

 { Fixe le "Caret" et rang‚ de s‚lection }
Procedure TEIdle(hTE:THHandle);Forward;
Procedure TEClick(pt:Point;extend:Boolean;hTE:TEHandle);Forward;
Procedure TESetSelect(selStart,selEnd:LongInt;hTE:TEHandle);Forward;

 { Affichage/d‚filement de texte }
Procedure TESetAlignement(align:Integer;hTE:TEHandle);Forward;
Procedure TEUpDate(rUpDate:Rect;hTE:TEHandle);Forward;
Procedure TETextBox(text:Ptr;length:LongInt;box:Rect;just:Integer);Forward;
Procedure TECalText(hTEHandle);Forward;
Function  TEGetHeight(endline,startline:LongInt;hTE:TEHandle):Integer;Forward;
Procedure TEScroll(dh,dv:Integer;hTE:TEHandle);Forward;
Procedure TEPinScroll(dh,dv:Integer;hTE:TEHandle);Forward;
Procedure TEAutoView(fAuto:Boolean;hTE:TEHandle);Forward;
Procedure TESelView(hTE:TEHandle);Forward;

 { Modification du texte pour l'‚dition d'enregistrement }
Procedure TEDelete(hTE:TEHandle);Forward;
Procedure TEInsert(text:Ptr;length:LongInt;hTE:TEHandle);Forward;
Procedure TECut(hTE:TEHandle);Forward;
Procedure TECopy(hTE:TEHandle);Forward;
Procedure TEPaste(hTE:TEHandle);Forward;
Procedure TEStylePaste(hTE:TEHandle);Forward;
Function  TEToScrap:OSErr;Forward;
Function  TEFromScrap:OSErr;Forward;

 { Gestionnaire de TextEdit de Scrap Priv‚e }
Function  TEScrapHandle:Handle;Forward;
Function  TEGetScrapLength:LongInt;Forward;
Procedure TESetScrapLength(length:LongInt);Forward;

 { V‚rification, Ajustement, Remplacement de styles }
Procedure TESetStyle(mode:Integer;newStyle:TextStyle;redraw:Boolean;hTE:TEHandle);Forward;
Procedure TEReplaceStyle(mode:Integer;oldStyle,newStyle:TextStyle;redraw:Boolean;hTE:TEHandle);Forward;
Function  TEContinousStyle(Var Mode:Integer;Var aStyle:TextStyle;hTE:TEHandle):Boolean;Forward;
Procedure TEStyleInsert(text:Ptr;length:LongInt;hST:STScrpHandle;hTE:TEHandle);Forward;
Function  TEGetStyleScrapHandle(hTE:Handle):StyleScrpHandle;Forward;
Procedure TEUseStyleScrap(rS:LongInt;rE:LongInt;nS:STScrpHandle;redraw:Boolean;hTE:TEHandle);Forward;
Function  TENumStyles(rangeStart:LongInt;rangeEnd:LongInt;hTE:TEHandle):LongInt;Forward;

 { Utilisation d'octet d'offset et point correspondant }
Function TEGetOffset(pt:Point;hTE:TEHandle):Integer;Forward;
Function TEGetPoint(offset:Integer;hTE:TEHandle):Point;Forward;

 { Fourniture additionnel de TextEdit }
Function TeFeatureFlag(feature:Integer;action:Integer;hTE:TEHandle):Integer;Forward;

 { "Custumizing" TextEdit }
Procedure TECustomHook(which:TEIntHook;Var addr:ProcPtr;hTE:TEHandle);Forward;
Procedure TESetWordBreak(wBrkProc:ProcPtr;hTE:TEHandle);Forward;
Procedure TESetClickLoop(clickProc:ProcPtr;hTE:TEHandle);Forward;

{$ENDIF}