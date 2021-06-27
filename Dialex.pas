{���������������������������������������������������������������������������
 �                                                                         �
 �                    Malte Genesis/Cortex du Dialogue                     �
 �                                                                         �
 �            �dition Chantal pour Mode R�el/IV - Version 1.1              �
 �                              1995/11/30                                 �
 �                                                                         �
 �          Tous droits r�serv�s par les Chevaliers de Malte (C)           �
 �                                                                         �
 ���������������������������������������������������������������������������


 Nom du programmeur
 ������������������

  Sylvain Maltais


 Description
 �����������

  Cette unit� renferme les m�canismes internes des services offerts par
 l'unit� de dialogue.
}

Unit Dialex;

{���������������������������������������������������������������������������}
                                  INTERFACE
{���������������������������������������������������������������������������}

{$I DEF.INC}

Uses Systex,ResTex;

Const
 werInputByte=$0001;         { Demande une valeur num�rique (octet)}
 werInputWord=$0002;         { Demande une valeur num�rique (mot)}
 werInputLong=$0003;         { Demande une valeur num�rique (entier long)}
 werInputReal=$0004;         { Demande une valeur num�rique (r�el)}
 werKeyDown=$0005;           { Demande des boutons de s�lection en bas }
 werInputString=$0006;       { Demande une cha�ne de caract�res (String)}
 werListBox=$0007;           { Demande d'afficher une bo�te �ListBox� }
 werScrollBar=$0008;         { Barre de s�lection }
 werTextXY=$0009;            { Affiche du texte � une position pr�cise }
 werPage=$000A;              { Page d'onglet }
 werColorGrid=$000B;         { Demande la couleur souhaiter }
 werFrame=$000C;             { �Frame� }
 werRadioButton=$000D;       { Demande un bouton radio }
 werKeyHori=$000E;           { Demande des boutons de s�lection horizontal }
 werClickBox=$000F;          { Demande une bo�te � cliquer }
 werCopy=$0010;              { Demande une copie de fichier }
 werMove=$0011;              { Demande un d�placement de fichier }
 werColorCube=$0012;         { Demande la couleur � partir d'un cube }
 werTree=$0013;              { Arbre }
 werImage=$0014;             { Image }
 werInputCountry=$0015;      { Demande la s�lection d'un pays }
 werBarHori=$0016;           { Barre horizontal }
 werInputFile=$0017;         { Demande un nom de fichier }
 werList=$0018;              { Liste de CheckBox,...}

  { Les styles de barres de menu }
 sbmClassic=0;               { Normal }
 sbmBadSeal=1;               { Genre Bad Seal (Copper) }

  { Le styles des arri�res plans }
 sbmMacOsX=1;                { Mac OS X }
 sbmDESQView=4;              { Style � la DESQview (double barre relief) }

 SizeOfVideoBios=24; {Constante d�finissant la taille des variables de la
                      RAM  Bios situ�  en adresse  de segment 0040h. Elle
                      part  naturellement  de la position  du mode  vid�o
                      actuel � l'adresse d'offset 0049h. }
 FontAppPath:PChr=NIL;
 {{$IFNDEF GraphicOS}
  HoleMode:Boolean=False;  { Mode trou�? Utilise le tableau pour les trous dans
                             l'�ventualit� de rafra�chissement de l'�cran
                 ou des sous-fen�tres... }
 {{$ENDIF}
 PrtScr:Boolean=False;     { Impression de l'�cran }
 ViewAppTitle:Boolean=True;{ Barre d'application visible?}

  { Ajustement des bo�tes de dialogues }
 UseExtensior:Boolean=True;{ Autorisation d'utilis� l'extensior }
 DialTimer:Boolean=False;  { Autorise/interdit l'affichage de l'heure p�riodiquement }
 ComInInput:Boolean=False; { Autorise/interdit l'entrer utilisateur par le
                             port de communication }
 SpcMnu:Byte=2;            { D�finition le nombre d'espace (en caract�res)
                             entre chaque Menu d�roulant. }
 StyleBarMnu:Byte=sbmBadSeal;{ Style de barre de menu }
 StyleBackgroundMenu:Byte=sbmClassic; { Style d'arri�re plan des menus }
 MatrixBorderLeft:Array[0..3]of Byte=(48,52,56,60);
 MatrixBorderRight:Array[0..3]of Byte=(255,254,253,252);
 Cadril:Boolean=True;      { Autorise le cadrillage en graphique des objets de dialogues? }
 Banderolle:Boolean=True;  { Banderolle ligne paire et impaire dans les listes }
 FX:Boolean=True;          { Autorise les effets sp�ciaux }
 Log:Boolean=False;        { Autorise/interdit le journal de bord }
 ClipPos:LongInt=0;        { Position actuel du presse-papier }
 SizeOfClipBoard:LongInt=0;{ Taille du presse-papier }
 SecSS:Word=60;            { Nombre de seconde avant l'activation
                             de l'�conomiseur d'�cran }
 TimeOnLine:LongInt=0;     { L'heure de mise en op�ration du programme lors
                             du lancement }
 MasterPassWord:PChr=NIL;  { Mots de passe centrale, utilis� entre-autre
                             pour le retour de l'�conomiseur d'�cran. }
 CurrPalette:Byte=$FF;     { Num�ro de la palette d'application actuel }
 HelpBar:Boolean=True;     { Barre d'aide? }
 WallPaperCfg:WallPaperMode=[wpJuxtap];{ Mod�le d'affichage du papier peint }
 LnsMnu:Byte=1;           { Ligne en texte � lequel le menu principal s'affiche }

Var
 WallPaperConfig:Byte Absolute WallPaperCfg;

Const

  {Caract�ristique de l'environnement}
 sttNone=0;               { Aucun style de barre titre pr�d�finie }
 sttMacintosh=1;          { Barre de titre style Macintosh (�)}
 StyleBarTitle:Byte=sttNone;
 TitleCenter:CenterType=__Justified__;

  {Son attribu�e par d�faut au tableau}
 sndStartUp=0;            { Son de d�marrage }
 sndError=1;              { Son d'erreur }
 sndWarning=2;            { Son d'attention }
 sndInfo=3;               { Son de notes }
 sndOpenWin=4;            { Son d'ouvrir une fen�tre }
 sndCloseWin=5;           { Son de fermeture de fen�tre }
 sndExit=6;               { Son pour quitter }

 SoundPlay:Array[0..6]of PChr=(NIL,NIL,NIL,NIL,NIL,NIL,NIL);

 LoadKeyboardBiosTable:Boolean=False; { Table de code clavier charg�e?}

  {Remarque: Toutes les variables suivantes sont volatile!}
 KeyStrc:Array[0..9]of Word=(
  kbHelp,        { Touche d'aide }
  kbOk,          { Touche �Correcte� }
  kbCancel,      { Touche d'annulation }
  kbYes,         { Touche Oui }
  kbNo,          { Touche Non }
  kbRetry,       { Touche r�essayer }
  kbAbort,       { Touche abandon }
  kbIgnore,      { Touche ignorer }
  kbDef,         { Touche de cas par d�faut }
  kbAll);        { Touche de tous }
 HelpPChr:Array[0..Length('Aide')]of Char='Aide'#0;
 LenOk:Byte=8;
 OkPChr:Array[0..Length('Correcte')]of Char='Correcte'#0;
 CancelPChr:Array[0..Length('Annule')]of Char='Annule'#0;
 YesPChr:Array[0..Length('Oui')]of Char='Oui'#0;
 NoPChr:Array[0..Length('Non')]of Char='Non'#0;
 RetryPChr:Array[0..Length('R�essayer')]of Char='R�essayer'#0;
 AbortPChr:Array[0..Length('Abandonne')]of Char='Abandonne'#0;
 IgnorePChr:Array[0..Length('Ignore')]of Char='Ignore'#0;
 DefPChr:Array[0..Length('Par d�faut')]of Char='Par d�faut'#0;
 AllPChr:Array[0..Length('Tous')]of Char='Tous'#0;
 {$IFDEF Real}
  StrKey:Array[0..9]of PChr=(
   PChr(@HelpPChr),
   PChr(@OkPChr),
   PChr(@CancelPChr),
   PChr(@YesPChr),
   PChr(@NoPChr),
   PChr(@RetryPChr),
   PChr(@AbortPChr),
   PChr(@IgnorePChr),
   PChr(@DefPChr),
   PChr(@AllPChr)
  );
 {$ELSE}
  StrKey:Array[0..9]of PChr=(
   @HelpPChr,
   @OkPChr,
   @CancelPChr,
   @YesPChr,
   @NoPChr,
   @RetryPChr,
   @AbortPChr,
   @IgnorePChr,
   @DefPChr,
   @AllPChr
  );
 {$ENDIF}

 {$IFNDEF NoSpooler}
  ExitIfSpoolerIsEmpty:Boolean=False;
 {$ENDIF}

 TimeX:Byte=$FE;TimeY:Byte=$FE;           { Position X,Y en texte o� s'affiche l'heure }
 TimeXA:Byte=$FE;TimeYA:Byte=$FE;         { Position X,Y en texte o� s'affiche l'heure
                                            avant que la journ�e finisse.}
 TimeXIn:Byte=$FE;TimeYIn:Byte=$FE;       { Position X,Y en texte o� s'affiche l'heure
                                            depuis lequel l'application est en fonction.}
 TimeXMod:Byte=$FE;TimeYMod:Byte=$FE;     { Position X,Y en texte o� s'affiche le temps
                                            musicale.}
 TimeXOnLine:Byte=$FE;TimeYOnLine:Byte=$FE;{Position X,Y en texte o� s'affiche le temps
                                            en ligne du circuit de communication.}
 DateX:Byte=$FE;DateY:Byte=$FE;           { Position X,Y en texte o� s'affiche la date
                                            actuel du syst�me }
 TimeMod:LongInt=0;                       { Nombre de secondes/18,2 depuis lequel
                                            la m�lodie joue.}

Type
 DialogTreeElement=Record
  Level:ShortInt;        { Niveau dans l'arbre }
  Open:Boolean;          { Ouvre sur d'autre �l�memt }
  ReturnCode:Word;       { Code de retour }
  ShortName:String[12];  { Nom court }
  LongName:String;       { Nom long }
 End;

 PDialogTreeElement=^DialogTreeElement;

 DialogTreeObject=Record
  W:Window;              { Zone attribu� }
  Tree:ArrayList;        { Arbre }
  P:Word;                { Position physique }
  InsP:Word;             { Position d'insertion (interne) }
  Y:Byte;                { Position affich�e }
  Option:Set Of(dtEnterExit);
  OnEnter:Function(Var Q;Var Context):Boolean;
  OnContextMenu:Function(Var Q;Var Context):Boolean;
  OnDirNotExist:Function(Var Q;Var Context;Const CurrName,Next2Create:String):Boolean;
  Context:Pointer;
 End;

 Border8BitsColorType=Array[0..1,0..7]of Byte;
 BorderTrueColorType=Array[0..1,0..7]of Word;
 XTabType=Array[0..127]of Byte;

 {Structure permettant de garder un historique des pr�c�dante commande}
 History=Record
  Cmd:^TByte;             { Tampon }
  SizeCmd:Word;           { Taille du tampon }
  Tail,Ptr,TPtr:^String;  { Pointeur sur le tampon }
  Fixed:Boolean;          { Tampon fixe? }
 End;

 Extensior=Record
  Handle:Hdl;             { Handle utilis� pour lire le fichier Extensior}
 End;

 MultiModel=Record
  Name:String[31];        { Identification du mod�le (nom,...)}
  Ext:String[31];         { Extension associ�e s�par� de point-virgule }
  Code:Word;              { Code d'identification ou num�ro de s�rie }
 End;

 FileListBox=Record
  W:Window;               { Bo�te de dialogue � utiliser pour l'affichage }
  RX1,RY1:Byte;           { Position physique de l'affichage dans la fen�tre }
  Length,Height:Byte;     { Largeur et hauteur en texte de la fen�tre }
  Position:Word;          { Position courante dans la liste }
  YScreen:Word;           { Y � l'�cran en tenant compte qu'� la fin d'une
                            colonne, il passe � la suivante }
  Box:Byte;               { Indique dans quel bo�te se trouve actuellement
                            l'utilisateur: Entr�e, S�lection, Fixe description,...}
  KB:Byte;                { Position du bouton courant }
  UnixSupport:Boolean;    { Supporte le format Unix par exemple avec les
                            barre oblique � l'angle inverse du DOS }
  ShowGlyphs:Boolean;     { D�termine si des ic�nes apparaisse � c�t� des
                            nom de fichier de la bo�te de liste de fichiers.}
  Tri:FileSort;           { Technique de tri des fichiers }
  PreView:Boolean;        { Autorise une partie permettant de visualiser les
                            images correspondant � fichier courant }
  SettingDescr:Boolean;   { Modification des desscriptions possibles par
                            clavier (toujours possible par la souris) }
  FileType:Word;          { Type de fichier, leur attribut }
  FileList:BF;            { Liste des fichiers }
  Model:Word;             { D�finit le mod�le de fichier � rechercher }
  CurrModelPos:Word;      { Position du mod�le dans la liste }
  PMM:^MultiModel;        { Pointeur sur un mod�le multiple }
  StartPath:String;       { R�pertoire d'origine }
  Path:String;            { Changement de recherche d'origine }
  M:ArrayList;            { Mod�le de recherche support� par la bo�te de
                            s�lection de fichier }
  YD:Byte;                { Additionner � la hauteur de la fen�tre si des
                            mod�les sont disponibles.}
  H:^History;             { Histoire � utiliser comme r�f�rence des derniers
                            chemin de fichier }
  OnChange:Procedure;     { �v�nement: Cette routine est appell�e � chaque
                            fois qu'un nouveau fichier est s�lectionn�e }
  ExtImg:Extensior;       { Extensior }
   {Variable de FONCTIONNEMENT INTERNE}
  ExtAss:^TWord;          { Association extensior }
  ExtAssSize:Word;        { Taille de l'association extensior }
  ExtAssCurrPos:Word;     { Position courante dans l'asociation d'extensior }
  NotFirstTime:Boolean;   { Usage interne seulement, pour dire que ce n'est
                            pas la premi�re fois qu'il est lanc�e }
  MaxCol:Byte;            { Nombre de colonnes moins 1}
  ColPos:Array[0..9]of Byte; { Position des colonnes en texte dans
                               la fen�tre }
  EndColPos:Array[0..9]of Byte;{ Fin de la position des colonnes en texte
                                 dans la fen�tre }
 End;

 LMPtrRec=Record Case Byte of
  0:(PChrByte:PCharByteRec);
  1:(PChrWd:PCharWordRec);
  2:(StrByte:StrByteRec);
  3:(StrWd:StrWordRec);
  4:(StrLong:StrLongRec);
 End;

 ExtensiorHeader=Record
  Signature:Array[0..26]of Char; { Signature: 'Extensior - Base de donn�e'#26 }
  HomeData:LongInt;              { Position au commence les donn�es }
 End;

 {Structure du Menu}
 PullMnuPtr=^PullMnuItem;
 PullSwitchPtr=^PullSwitchItem;
 MainMnuPtr=^MainMnuRec;
 PullSwitchItem=TPChar;

 PullMnuItem=Record
  Option:PChr;            { Item de menu }
  HighChar:Chr;           { Caract�re surimprim� de l'item }
  KeyFunc,RtnCode:Word;   { Combinaisons de fonctions, cl� de retour }
  SubMenu:Pointer;        { Pointeur de sous-menu }
  Switch:^Byte;           { Pointeur d'activit� (Actif/Inactif)}
  {$IFDEF LuxeExtra}
   PSwitch:PullSwitchPtr; { Description de l'item (genre d'aide en ligne) }
  {$ENDIF}
  Next:PullMnuPtr;        { Pointeur sur le prochaine item }
 End;

 MainMnuRec=Record{ Dan� est celui changeant l'ordre de cette enregistrement!}
  Title:PChr;             { Titre d'un menu }
  KeyCode:Word;           { Cl� d'acc�s }
  Lst:PullMnuPtr;         { Liste des items }
  NmLst:Word;             { Nombre d'item dans la liste }
  P:Byte;                 { Position courante }
  NxtMnu:MainMnuPtr;      { Pointeur sur le prochain menu }
 End;

  {Sous-menu d�roulant}
 PullSubMnu=Record
  Ptr:PullMnuPtr;
  NmLst:Word;
 End;

  {Menu d�roulant}
 PullMnu=Record
  X1,Y,X2:Byte;                               { Coordonn�e o� se trouve la barre de menu }
  Mnu:ArrayList;                              { Listes des items et des menus }
  Space4Icon:Byte;                            { Nombre d'espace r�serv� pour le tra�age d'Ic�ne }
  IconRoutine:Procedure(X,Y:Byte;Level:Word); { Routine devant �tre appel�e pour le tra�age des Ic�nes }
  OnContext:Function(Code:Word):Boolean;      { Cette routine est appel�e si le deuxi�me bouton est enfonc�e }
 End;

 SectionRec=Record
  W:Window;               { Bo�te de dialogue }
  X:ArrayList;            { Liste des boutons }
  P,L,IL,LY:Byte;         { Position courant, largeur, largeur d'image,...}
  ImageAssistant:Boolean; { Image d'assistance? }
  FileName:String;        { Nom des ressources d'image }
  StartIndex:Word;        { Index de d�marrage }
 End;

 ContextMenu=Record
  Data:^TByte;
  Size:Word;
  OldMnu:PullMnu;
  SubMenu:Array[0..7]of PullSubMnu;
  MaxSubMenu:Integer;
 End;

 ListTitle=Record
  Y:Byte;                  { Liste de la ligne d'affichage }
  XP:Array[0..255]of Byte; { Liste des positions X }
  MaxX:Byte;               { Position maximal X}
  NB:Byte;                 { Nombre de colonne}
  Title:String;            { Les titres s�par�s par le caract�re �|� }
 End;

 ResourceWindow=Record
  W:Window;                       { Fen�tre associ�e }
  IsWindowFixed:Boolean;          { Fen�tre d�j� fix�? }
  R:ArrayList;                    { Liste des �l�ments }
  P:Word;                         { Position courante d'�l�ment }
  CurrPage:Byte;                  { Position de la page courante }
  NumPage:Byte;                   { Nombre de page d'onglet }
  XPage:Byte;                     { Position horizontal du dernier onglet }
  NotFirstTime:Boolean;           { Ce n'est pas la premi�re fois qu'elle est ex�cut�e? }
  Anim:Boolean;                   { Animation pr�sente? }
  XCS,YCS,XCT,YCT,                { ATTENTION! Ne pas changer! Copie Source, Destination }
  XCG,YCG,XCL,YCL:Byte;           { ATTENTION! Ne pas changer! Copie Global, Local }
  CollectiveSoul:Pointer;         { Donn�e attribu�e de fa�on collective � la routine}
  OnInput:Function(Var Q;P:Word):Boolean;{ Cette fonction est entr�e }
                                         { lorsqu'une donn�e est entr�e }
  ExternInit:Record
   Proc:Procedure(Var R;Var Context);
   Context:Pointer;
  End;
 End;

 PBoolean=^Boolean;
 KeyHoriProc=Record
  OnPress:Procedure(Var R:ResourceWindow;Var Context);
  Context:Pointer;
 End;

 MethodeCopySet=Set Of (mcsMove,mcsOverwrite,mcsSubDirectory);

 CopyRec=Record
  Source:String;
  Target:String;
  Methode:MethodeCopySet;
 End;

 ColorGridValueRec=Record
  Value:Byte;
  OnPressButton2:Procedure(Value:Word;Var Context);
  Context:Pointer;
  Palette:^Palette256RGB;
 End;

 PColorGridValue=^ColorGridValueRec;

 ScrollBarByteRec=Record
  Value:Byte;
  OnMove:Procedure(Var Q:ResourceWindow;Var Context);
  Context:Pointer;
 End;

 ScrollBarWordRec=Record
  Value:Word;
  OnMove:Procedure(Var Q:ResourceWindow;Var Context);
  Context:Pointer;
 End;

 PScrollBarByteRec=^ScrollBarByteRec;
 PScrollBarWordRec=^ScrollBarWordRec;

 {Enregistrement pour la gestion avanc� des fen�tres}
 MultiInputPtr=^MultiInputRec;

 MultiInputRec=Record
  X1,Y,X2:Byte;
  Msg,Buf:PChr;
  MaxLen:Word;
  Next:MultiInputPtr;
 End;

 LineImage=Record
  Size:Word;                    { Taille du tampon }
  Buf:Pointer;                  { Tampon contenant les donn�es d'affichage }
  X1,Y,X2:Byte;                 { Position de la ligne � sauvegarder }
  CharacterTransparent:Boolean; { Caract�re avec fond transparent? }
 End;

 LstMnu=Record
  List:ArrayList;         { Liste des �l�ments de la liste }
  P:Word;                 { Position absolue dans la liste }
  W:Window;               { Bo�te de dialogue utilis� }
  Y:Byte;                 { Position vertical dans la bo�te de dialogue }
  SearchString:String[15];{ Cha�ne de recherche }
  (* Variable d'�v�nement externe *)
   { Retourner une valeur de retour que lorsqu'il a cliqu� par la deuxi�me
     fois sur l'�l�ment d�sirer!}
  EnterOnDoubleClick:Boolean;
   { Nombre d'espace r�serv� pour le tra�age d'Ic�ne }
  Space4Icon:Byte;
   { Routine devant �tre appel�e pour le tra�age des Ic�nes }
  IconRoutine:Procedure(X,Y:Byte;P:Word;Var Context);
   { Apr�s chaque rafra�chissement }
  OnRefresh:Procedure(Var L;Var Context);
   { Routine appeler apr�s un d�placement }
  OnMove:Procedure(Var Context);
   { Routine appeler lorsque la touche �INSERT� est enfonc�e }
  OnInsert:Function(Var Context):String;
   { Routine appeler lorsque la touche barre d'espace est enfonc� }
  OnModified:Function(Var Context;P:Word):String;
   { Routine appeler lorsque le premier bouton de la souris est enfonc� }
  OnClickButton:Procedure(Var Context;P:Word);
   { Routine appeler lorsque le deuxi�me bouton de la souris est enfonc� }
  OnClickButton2:Function(Var Context;P:Word;Var Insert:Boolean):String;
   { Variable utilis� comme contexte lors de l'appel des �v�nements}
  Context:Pointer;
 End;

 ListBox=Record
  Value:Word;
  LoadList:Procedure(Var L:LstMnu;Var Context);
  OnMove:Procedure(Var L:LstMnu;Var Context);
  Context:Pointer;
 End;

 PListBox=^ListBox;

  { Ces enregistrements font partie des entr�es de donn�es d'une feuille de dialogue }
 MInputByte=Record
  Value:Byte;
  OnChange:Function(Var R:ResourceWindow;Var Context):Boolean; { Routine d'appel lorsque modifier }
  Context:Pointer;                                             { Contexte de la routine d'appel }
 End;

 MInputWord=Record
  Value:Word;
  OnChange:Function(Var R:ResourceWindow;Var Context):Boolean; { Routine d'appel lorsque modifier }
  Context:Pointer;                                             { Contexte de la routine d'appel }
 End;

 MInputLong=Record
  Value:LongInt;
  OnChange:Function(Var R:ResourceWindow;Var Context):Boolean; { Routine d'appel lorsque modifier }
  Context:Pointer;                                             { Contexte de la routine d'appel }
 End;

 MInputReal=Record
  Value:Real;
  OnChange:Function(Var R:ResourceWindow;Var Context):Boolean; { Routine d'appel lorsque modifier }
  Context:Pointer;                                             { Contexte de la routine d'appel }
 End;


  { Cette enregistrement fait partie d'une feuille de dialogue: CheckBox }
 MCheckBox=Record
  Checked:Boolean;
 End;

 MCheckBoxExtern=Record
  OnPress:Function(Var R:ResourceWindow;Var Context):Boolean;
  Context:Pointer;
  Checked:Boolean;
 End;

  { Cette enregistrement fait partie d'une feuille de dialogue: ScrollBar }
 MScrollBar=Record
  Position:Byte;
  OnScroll:Procedure(Var R:ResourceWindow;Var Context);
  OnScrollContext:Pointer;
 End;

 MColorGrid16=Record
  Color:Byte;
  OnMouseButton:Procedure(Var Context);
  Context:Pointer;
 End;

 MRadioButton=Record
  Alignment:Byte;
 End;

 MRadioButtonExtended=Record
  OnMove:Procedure(Var Context);
  Alignment:Byte;
 End;

 MButton=Record
  OnPress:Procedure(Var R:ResourceWindow;Var Context);
  Context:Pointer;
 End;

 MColorGrid=Record
  Color:Byte;
  OnPress:Procedure(Var R:ResourceWindow;Var Context);
  Context:Pointer;
 End;

 MListBox=Record
  ItemIndex:Word;
  LoadList:Procedure(Var L:LstMnu;Var Context);
  OnMove:Procedure(Var L:LstMnu;Var Context);
  Context:Pointer;
 End;

  { Objet d'arbre }
 MTree=Record
  LoadTree:Procedure(Var T:DialogTreeObject;Var Context);
  Context:Pointer;
 End;

  { Objet de taille relative de la fen�tre }
 MSizeRelative=Record
  Length:Byte;        { Largeur }
  Height:Byte;        { Hauteur }
 End;

 MExtern=Record
  Call:Procedure(Var R:ResourceWindow;Var Context);
  Context:Pointer;
 End;

 SwitchOption=Record
  L,P,X,Y,X1,Y1,X2,Y2:Byte;
  Tl:String;
  OnMove:Procedure(Var Context); { �v�nement si d�placement }
  Context:Pointer;               { Contexte concernant dans l'appel OnMove }
  OnWait:Procedure(Var Context); { Si rien � faire }
  OnWaitContext:Pointer;         { Contexte de si rien � faire }
 End;

 {$IFDEF Graf}
  BlockButton=Record {Enregistrement du Bouton/Ic�ne}
   Name:String[19];                { Nom de la page de Bouton }
   Data:Array[0..31,0..31]of Byte; { Image du bouton }
  End;
 {$ENDIF}

 ColorGridRec=Record
  X,Y:Byte;                  { Coordonn�e o� se trouve le bo�te }
  Length,Height:Byte;        { Largeur et hauteur }
  Palette:Boolean;           { Avec palette?}
  PValue:PColorGridValue;    { Valeur actuel }
 End;

 sbRec=Record
  Min,Max:Word;              { Minimum et maximum de la barre...}
  X1,Y,X2:Byte;              { Coordonn�e de la barre de s�lection }
  Attr:Byte;                 { Attribut associ� }
  NoNum:Boolean;             { Pas de modification num�rique?}
 End;

 SOOption=Record
  Title:String;
  Input:String;
 End;

 ColorCubeData=Record
  Color:RGB;
  OnClick:Procedure(Var R:ResourceWindow;Var Context);
  Context:Pointer;
 End;

  { Input String }
 IsRec=Record
  X1,Y,X2,Len:Byte; { Coordonn�e de l'�l�ment }
  OnChange:Function(Var R:ResourceWindow;Var Context):Boolean; { Routine d'appel lorsque modifier }
  Context:Pointer;                                             { Contexte de la routine d'appel }
  PValue:^String;   { Valeur actuel }
  PKey:^String      { Pointeur sur la cl� associ� }
 End;

  { Input File }
 FiRec=Record
  X1,Y,X2,Len:Byte; { Coordonn�e de l'�l�ment }
  OnChange:Function(Var R:ResourceWindow;Var Context):Boolean; { Routine d'appel lorsque modifier }
  Context:Pointer;                                             { Contexte de la routine d'appel }
  PValue:^String;   { Valeur actuel }
  PKey:^String      { Pointeur sur la cl� associ� }
 End;

  { Input Country }
 InputCountryObject=Record
  X1,Y,X2:Byte;     { Coordonn�e de l'�l�ment }
  Mode:Byte;        { Mode de pays }
  PValue:^Word;     { Valeur actuel }
 End;

  { Barre horizontal }
 BhRec=Record
  X1,Y,X2:Byte;
 End;

 ElementWins=Record
  SerialNumber:Word; { wer???? }
  Page:Byte;         { Num�ro de page d'onglet }
  Data:Record Case Word of
   werBarHori:(
    bh:BhRec;
   );
   werImage:(
    ioImage:ImageObjectLoader;
    ioOneImage:XInf;
    ioX,ioY:Word;
    ioCurrImage:Word;
   );
   werTree:(
    wtTree:DialogTreeObject;
   );
   werInputByte:(
    ibX1,ibY,ibX2,ibLen:Byte; { Coordonn�e de l'�l�ment }
    ibOnChange:Function(Var R:ResourceWindow;Var Context):Boolean; { Routine d'appel lorsque modifier }
    ibContext:Pointer;                                             { Contexte de la routine d'appel }
    ibPValue:PByte            { Valeur actuel }
   );
   werInputWord:(
    iwX1,iwY,iwX2,iwLen:Byte; { Coordonn�e de l'�l�ment }
    iwOnChange:Function(Var R:ResourceWindow;Var Context):Boolean; { Routine d'appel lorsque modifier }
    iwContext:Pointer;                                             { Contexte de la routine d'appel }
    iwPValue:PWord            { Valeur actuel }
   );
   werInputLong:(
    ilX1,ilY,ilX2,ilLen:Byte; { Coordonn�e de l'�l�ment }
    ilOnChange:Function(Var R:ResourceWindow;Var Context):Boolean; { Routine d'appel lorsque modifier }
    ilContext:Pointer;                                             { Contexte de la routine d'appel }
    ilPValue:PLong            { Valeur actuel }
   );
   werInputReal:(
    irX1,irY,irX2,irLen:Byte; { Coordonn�e de l'�l�ment }
    irOnChange:Function(Var R:ResourceWindow;Var Context):Boolean; { Routine d'appel lorsque modifier }
    irContext:Pointer;                                             { Contexte de la routine d'appel }
    irPValue:PReal            { Valeur actuel }
   );
   werInputString:(IStr:IsRec);
   werInputCountry:(InputCountry:InputCountryObject);
   werInputFile:(Fi:FiRec);
   werTextXY:(
    txX,txY:Byte;             { Position o� il doit �tre afficher }
    txMsg:String;             { Message � afficher }
   );
   werFrame:(
    frX1,frY1,frX2,frY2:Byte;
    frStr:String;
   );
   werListBox:(
    lbLM:LstMnu;
    lbPValue:PListBox;
   );
   werList:(
    listLM:LstMnu;
    listPValue:PListBox;
   );
   werScrollBar:(
    sbData:sbRec;
    sb:Record Case Byte of
     0:(PValueByte:PByte);
     1:(PValueWord:PWord);
     2:(PValueByteStruct:PScrollBarByteRec);
     3:(PValueWordStruct:PScrollBarWordRec);
    End;
    sbFormat:Byte;            { Format Byte=0, Word=1}
    sbOldX:Byte;              { Ancienne position }
    sbX1:Byte;                { Position de d�part de la barre }
   );
   werPage:(
    pgColor:Byte;             { Couleur d'attribut de la page d'onglet }
    pgX:Byte;                 { Position horizontal de l'onglet }
    pgTitle:String;           { Titre de la page d'onglet }
   );
   werColorGrid:(cg:ColorGridRec);
   werClickBox:(
    cbX,cbY:Byte;             { Coordonn�e o� se trouve le bo�te }
    cbPValue:PBoolean;        { Valeur actuel }
    cbXMsg:Byte;              { Position X du message }
    cbMsg:String;             { Message afficher }
    cbOnPress:Function(Var R:ResourceWindow;Var Context):Boolean; { Routine d'appel lorsque modifier }
    cbContext:Pointer;                                            { Contexte de la routine d'appel }
   );
   werKeyHori:(
    khX,khY,khLen:Byte;       { Position et largeur }
    khKey:String;             { Les touches }
    khPValue:^KeyHoriProc;
   );
   werKeyDown:(
    kdPValue:^Byte;           { Pointeur de position si plus que > 2}
    kdKey:String              { Les touches }
   );
   werRadioButton:(
    rbDial:SwitchOption;      { Bo�te de dialogue associ�e }
    rbPValue:PByte;           { Pointe sur l'octet indiquant la position }
    rbOption:^SOOption;       { Pointeur sur les options }
   );
   werCopy:(wc:CopyRec);
   werColorCube:(
    ccX,ccY:Byte;             { Position du cube }
    ccL,ccH:Byte;             { Largeur et hauteur }
    ccData:^ColorCubeData;
   );
  End;
 End;

 ProgramRec=Record
  Name:String[80];
  Path,Args,Icon:String;
  X,Y:Word;
  Res:XInf;
 End;

 BarProgress=Record
  W:^Window;  { Fen�tre de dialogue a utilis� }
  X,Y:Byte;   { Position dans la fen�tre }
 End;

  {Bo�te de dialogue de recherche de fichiers}
 SearchFilesDataRec=Record
  H:SearchRec;
  S:String;
 End;

 WinsSearchFiles=Record
  W:Window;
  ListY:Byte;
  LT:ListTitle;
  Total:LongInt;
  R:ArrayList;
  Y,P:Byte;
  X:^SearchFilesDataRec;  { Donn�e de l'�l�ment courant }
  SearchWildCard:String;  { Fichier � rechercher }
  Drive:Char;             { Unit� de recherche }
  SearchMode:Boolean;     { Tableau de recherche? }
  Section:Byte;           { Dans quel section se trouve-t-il? }
 End;

 MenuPalette=Record
  Normal,High,Select:Byte;
 End;

 (***** Environnement *****)
 {Palette de couleur}
 MatrixKrs=Record
  LastBar:Record
   Higher,Normal:Byte;
  End;
  Menu:MenuPalette;
  Desktop:Record
   Tapiserie:Byte;  { Couleur de la tapiserie }
   DialStatus:Byte; { Couleur des informations d'�tat sur une bo�te de dialogue }
  End;
  Dialog:Record
   Window:MtxColors;
   Env:Record
    BarSelInactive,BarSelect:Byte;
    List:MtxColors;
   End;
  End;
  ErrorWin:Record
   Window:MtxInputColors;
   Env:Record
    Input:Byte;
   End;
  End;
  WarningWin:MtxInputColors;
  RemWin:MtxInputColors;
  OpenWin:Record
   Window:MtxColors;
   Env:Record
    Input,Dir:Byte;
   End;
  End;
  MalteDos:Record
   Window:MtxColors;
   Env:Record
    Default,Prompt:Byte;
   End;
  End;
  Editor:Record
   Window:MtxColors;
   Env:Record
    BarInfo,Default,Typewriter,Rem,ResWord,Chars,Symbol:Byte;
    AsmInst,Number,Z,Normal,Pos,Insert,Modified:Byte;
   End;
   OutZone:Byte;
  End;
  PersonalJournal:Record
   Window:MtxColors;
   Env:Record
    BarInfo,Default,Pos,Insert:Byte;
   End;
  End;
  ViewAscii:Record
   Window:MtxColors;
   Env:Record
    BarInfo,Default,Rem,ResWord,Chars,Symbol:Byte;
    AsmInst,Number,Z,Normal,Pos,Insert,Modified:Byte;
   End;
  End;
  HexView:Record
   Window:MtxColors;
   Env:Record
    Input:Byte;
   End;
  End;
  EditButt:MtxColors;
  Dial:Record
   Window:MtxColors;
   Env:Record
    BarSelect,BarUnSelect,Number:Byte;
   End;
  End;
  Draw:Record
   Window:MtxColors;
  End;
  Help:Record
   Window:MtxColors;
  End;
  FileManager:Record
   Window:MtxColors;
   SubTitle:Byte;
  End;
 End;

 CountryDataSetRec=Record
  ID:Word;
  CountryCode:Word;
  CodePage:Word;
  Buffer:Record Case Byte Of
   0:(Fill:Array[0..4095]of Byte);
   1:(Res:ImageHeaderRes);
  End;
 End;

Var
 KeyboardBiosTable:DataSetInMemory; { Table clavier en m�moire }
 FontApp:XInf;            { Fond associ�e au fond de l'application }
 FontTitle:XInf;          { Fond associ�e � la barre de titre d'une fen�tre
                            de dialogue quelconque }
 FontInActifTitle:XInf;   { Fond associ�e � la barre de titre d'une fen�tre
                            inactif }
 ChantalServer:DataSet;        { Serveur �CHANTAL� }
 {{$IFNDEF GraphicOS}
  Hole:^TBool;            { Tableau temporaire pour indiquer les trous...
                            dans une application MDI }
 {{$ENDIF}
 CurrKrs:MatrixKrs;       { Palette d'application courante }
 {$IFNDEF MultiMenu}
  MainMenu:PullMnu;       { D�finition des menus d�roulant }
 {$ENDIF}

 StrOk:String[8]Absolute LenOk; {Duplication d'une cha�ne de bouton
                                 correcte sur un format ASCIIZ }
 OldYear{$IFDEF DosUnit},{$ELSE}:Word;{$ENDIF}
 OldMonth,OldDay,OldDayOfWeek:{$IFDEF DosUnit}Word{$ELSE}Byte{$ENDIF};

 TmPs:Array[0..5]of Record
  X,Y:Byte;
 End Absolute TimeX;

 TimeIn:LongInt;
 Old:Byte;
 OldBackKbd:Procedure;
 {$IFDEF Int8Dh}OldInt8Dh:Pointer;{$ENDIF} { Pointeur d'ancienne routine d'interruption 8Dh }
 NSS,TSS:Word;OldSS:Byte;                  { Variables de mise � jour de l'horloge }

Const
  {Donn�e du presse-papier}
 FirstTimeCB:Boolean=True; { Est-ce la premi�re fois que le presse-papier est utilis�? }
 InstallDir:PChr=NIL;      { R�pertoire du fichier d'installation }

  {Information de pays}
 MalteCountryCode:Word=0;  { Code de pays du Malte Genesis }

Var
  {Donn�e du presse-papier}
 ClipBoard:XInf;           { Tampon utilis� pour le presse-papier... }

  { Donn�e sur la feuille de travail }
 CurrForm:Pointer;              { Pointeur sur la structure de la feuille courante }
 CurrResWins:^ResourceWindow;   { Ressource de fen�tre courante }
 CurrList:^LstMnu;              { Pointeur sur la liste courante }

 Output:ImgRec;                 { Ecran de sortie }
 RegUserName:PChr;              { Nom de l'utilisateur courant }

{���������������������������������������������������������������������������}
                                IMPLEMENTATION
{���������������������������������������������������������������������������}

 {Pour l'instant aucune routine n'existe...}

{���������������������������������������������������������������������������}
END.