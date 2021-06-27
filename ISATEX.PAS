{⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
 ≥   Malte Genesis/Module Isabel Terminator Element eXtended  ≥
 ≥        Edition Isabel pour Mode RÇel/III - Version 1.0     ≥
 ≥                       1995/11/30                           ≥
 ≥                                                            ≥
 ≥      Tous droits rÇservÇ par les Chevaliers de Malte (C)   ≥
 ¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ


 Nom du programmeur
 ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕ

  Sylvain Maltais


 Description
 ÕÕÕÕÕÕÕÕÕÕÕ

  Cette unitÇ renferme toutes les dÇfinitions de type avancÇes sur
 l'ensemble de dÇveloppement Malte Genesis IV: Chantal.
}

Unit Isatex;

{ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ}
                                  INTERFACE
{ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ}

{$I DEF.INC}

Uses Systex,pritex,ImageTex,ResTex,Dialex;

Const
  {Constante de modäle d'application}
 wnEdit=1;             { êditeur de traåtement de texte: Document, Pascal, C,...}
 wnView=2;             { Regarde ASCII }
 wnIcon=3;             { êditeur d'Icìne graphique }
 wnDraw=4;             { Programme de dessin }
 wnSuperCalc=5;        { Chiffrier Çlectronique, tableur }
 wnFileManager=6;      { Gestionnaire de fichiers }
 wnPrmpt=7;            { Prompt de style DOS }
 wnTerm=8;             { Terminal de communication modem }
 wnUnix=9;             { Prompt de style Unix }
 wnHexView=10;         { êditeur HexadÇcimal }
 wnOutput=11;          { êcran de sortie }
 wnMusicMod=12;        { êditeur de .MOD }
 wnMacro=13;           { êditeur de Macro }
 wnPC=14;              { Watch, Calculatrice Programmable }
 wnCalculator=15;      { Calculatrice ordinaire }
 wnCalendar=16;        { Calendrier }
 wnAgenda=17;          { Agenda }
 wnCatDisk=18;         { Catalogue de disquette }
 wnMnu=19;             { Menu d'application }
 wnFont=20;            { êditeur de Police}
 wnDataBase=21;        { Base de donnÇes }
 wnDebug=22;           { DÇbogueur de programme (PowerHacken seulement) }
 wnProgMan=23;         { Gestionnaire de programmes }
 wnTetris=24;          { Jeux Tetris }
 wnCDPlayer=25;        { Joueur de CD de musique}
 wnFileListBox=26;     { Ouvre un fichier }
 wnSQL=27;             { Commande SQL }
 wnSearchFiles=28;     { Recherche fichier(s) }
 wnTechDraw=29;        { Dessin technique }
 wnGlobalDraw=30;      { ÆGlobal DrawØ: Visualisateur Global de Dessin }
 wnLogo=31;            { Langage de programmation LOGO }
 wnTaskBarMgr=32;      { Application sur le gestionnaire de barre de tÉche }
 wnPartitionManager=33;{ Gestionnaire de partition }
 wnExplorerDataBase=34;{ Explorateur de Base de donnÇes }
 wnMissileCommand=35;  { Jeux Missile Command}
 wnNibble=36;          { Jeux Nibbles }
 wnWorkShop=37;        { WorkShop }
 wnEmail=38;           { Courriel }
 wnAtlas=39;           { Atlas GÇographique }

  {Constante des boåtes de dialogues graphiques}
 {Format:}
 wfNone=0;           { Aucune image }
 wfTriangle=1;       { Triangle ÇquilatÇral }
 wfLosange=2;        { Losange rÇgulier parfaitement symÇtrique }
 wfOctogone=3;       { Octogone rÇgulier parfaitement symÇtrique }
 wfSquare=4;         { CarrÇe }
 wfCircle=5;         { Cercle }
 wfIllegalCircle=6;  { Cercle d'illÇgalitÇ avec une barre en diagonale }
 wfLyse=7;           { Fleur de lyse }
 {Figure:}
 wiNone=0 shl 3;     { Aucune figure }
 wiInfo=1 shl 3;     { Point d'interrogation }
 wiStop=2 shl 3;     { êcriture ÆSTOPØ }
 wiDead=3 shl 3;     { Tàte de mort }
 wiExit=4 shl 3;     { Porte de sortie }

 {Constante d'animation 3D}
 NmPntMxObj=63;
 NmFaceMxObj=63;
 NmPntMxFace=10;
 PROFONDEUR=150;
 DISTANCE=400;
 Delta=10000;

  {Constante du Traitement de texte}
 cgNormal=0;                   { Caractäre normal }
 cgBold=1;                     { Caractäre gras }
 cgUnderLine=2;                { Caractäre soulignÇ }
 cgItalic=4;                   { Caractäre italique }
 cgInverse=8;                  { Caractäre inversÇ en couleur de fond et d'Çcriture }
 cgExposant=cgInverse+cgBold;  { Caractäre en expososant }
 cgDouble=16;                  { Caractäre en largeur double }

  {Modäle d'objet du traitement de texte}
 mtNone=0;                     { Nulle, inutilisÇ }
 mtBookMark=1;                 { Repäre de texte }
 mtImage=2;                    { Image }
 mtFont=3;                     { Police de caractäres externe }
 mtWorkSheet=4;                { Tableau, tableur,... }
 mtDataBase=5;                 { Base de donnÇes }
 mtTechDraw=6;                 { Dessin en fil de fer }
 mtHyperlink=7;                { Lien INTERNET }
 mtInternalData=8;             { DonnÇes interne du document }
 mtDictionary=9;               { Faute d'orthographe ... }
 mtColor=10;                   { Couleur comme les remarques de code source }
 mtDateOfDay=11;               { Date du jour }
 mtLettrine=12;                { Lettrine }
 mtComment=13;                 { Remarque/commentaires }
 mtMacro=14;                   { Macro commande }
 mtLineHor=15;                 { Ligne horizontal }

 { Visualisation de traitement de texte (View TypeWriter) }
 vtDefault=0;                  { Visualisateur par dÇfaut: texte ASCII }
 vtAda=1;                      { Visualisateur de langage de programmation Ada }
 vtAsm=2;                      { Visualisateur de langage de programmation Assembleur }
 vtBas=3;                      { Visualisateur de langage de programmation Basic }
 vtC=4;                        { Visualisateur de langage de programmation C/C++ }
 vtCobol=5;                    { Visualisateur de langage de programmation Cobol }
 vtEuphoria=6;                 { Visualisateur de langage de programmation Euphoria }
 vtForth=7;                    { Visualisateur de langage de programmation Forth }
 vtFortran=8;                  { Visualisateur de langage de programmation Fortran }
 vtIni=9;                      { Visualisateur de fichier de configuration Æ.INIØ }
 vtMsMnu=10;                   { Visualisateur de fichier de menu souris }
 vtPas=11;                     { Visualisateur de langage de programmation Pascal }
 vtPW=12;                      { Visualisateur de fichier document Professional Write }
 vtRC=13;                      { Visualisateur de ressource }
 vtGAT=14;                     { Visualisateur de document Genesis-Ascii-Typewriter }
 vtPJ=15;                      { Visualisateur de journal personnel }
 vtAC=16;                      { Visualisateur de langage de programmation AC }
{ vtBasCoco3=17;                { Visualisateur de langage de programmation Basic pour Coco 3}
{ vtBasCK64=18;                 { Visualisateur de langage de programmation Basic pour Commodore 64K }
{ vtBasAppleII=19;              { Visualisateur de langage de programmation Basic pour Apple ][ }
{ vtBasVic20=20;                { Visualisateur de langage de programmation Basic pour VIC-20 }
 vtHlp=21;                     { Visualisateur de fichier d'Aide }
 vtMacro=22;                   { Visualisateur de fichier Macro }
 vtBatch=23;                   { Visualisateur de fichier Batch }
 vtHTMLSourceCode=24;          { Visualisateur du code source HTML }
 vtSQL=25;                     { Visualisateur du code source SQL }

 vtCoder=[vtAda,vtAsm,vtBas,vtC,vtCobol,vtEuphoria,vtForth,vtFortran,vtPas,vtAC,vtSQL];

  {Format Document}
 vtsGat=0;                     { Format Document GAT }
 vtsPW=1;                      { Format Document Professionnal Write }
 vtsFirstChoice=2;             { Format Document Premier Choix }
 vtsHTML=3;                    { Format Document HTML }
 vtsANSI=4;                    { Format Document ANSI }
 vtsASCII=5;                   { Format Document Texte ASCII DOS }
 vtsTextUnix=6;                { Format Document Texte ASCII Unix }
 vtsRTF=7;                     { Format mise en format RTF }
 vtsImage=8;                   { Format Document d'image }
 vtsMicrosoftWord=9;           { Format document Microsoft Word }

  { Mode de liste de l'Çditeur de traåtement de texte}
 mlNone=0;       { Aucun mode actuellement }
 mlBloc=1;       { Mode avec des blocs (˛) }
 mlRoman=2;      { Nombre roman (I, II, III, IV,...)}
 mlArabic=3;     { Nombre arabe (1, 2, 3, 4, 5,...)}
 mlAlphabetic=4; { Style de liste alphabÇtique (A, B, C,...)}

  { Constante du Gestionnaire de Fichier}
 FirstBoard=1;    { Premier numÇro de tableau }
 BoardFile=1;     { Tableau de fichier }
 BoardTree=2;     { Tableau d'arbre des rÇpertoires }
 BoardInfo=3;     { Tableau d'information }
 BoardView=4;     { Tableau de visualisation d'image }
 BoardExplorer=5; { Tableau d'Explorateur Windows }

  {Mode de dÇmarrage du Gestionnaire de programmes}
 startOff=0;       { DÇsactivÇ }
 startOn=1;        { ActivÇ }
 startInv=2;       { InversÇ l'Çtat actuel }

  {Format de la cellule du tableau}
 cfEmpty=0;      { Cellule vide }
 cfValue=1;      { Valeur numÇrique }
 cfText=2;       { Valeur texte }
 cfFormula=3;    { Formule }
 cfDate=4;       { Date }
 cfColumn=5;     { Colonne (usage de lecture et sauvegarde seulement) }

  {Fichier tableur}
 tfMGC=0;          { Mode de sauvegarde MGC }
 tfASCII=1;        { Mode de sauvegarde ASCII }
 tfLotus=2;        { Mode de sauvegarde Lotus 1-2-3 }
 tfQuattroPro=3;   { Mode de sauvegarde Quattro Pro }
 tfExcel=4;        { Mode de sauvegarde Excel }
 tfCSV=5;          { Mode de sauvegarde CSV }
 tfHTML=6;         { Mode de sauvegarde HTML }

  {Mode d'interpräte du tableur }
 shmLotus=1;        { Mode Lotus 1-2-3 }
 shmQuattroPro=2;   { Mode Quattro Pro }
 shmExcel=$100;     { Mode Microsoft Excel }
 shmStarOffice=$200;{ Mode StarOffice }
 shmMGC=$8000;      { Mode MGC }

  {Format de dessin technique}
 tdDefault=0;      { Mode de dessin technique par dÇfaut }
 tdDFD=1;          { Mode DFD (Diagramme de flux de donnÇes) }
 tdOrganigramme=2; { Mode de dessin d'organigramme }
 tdElectronic=3;   { Mode de dessin Çlectronique }

  {Constante par programmes par dÇfaut du gestionnaire de programmes}
 pmwNone=0;             { Aucun programme }
 pmwFileManager=1;      { Gestionnaire de fichiers }
 pmwControl=2;          { Panneau de configuration }
 pmwPrintMan=3;         { Gestionnaire d'impression }
 pmwClipBoard=4;        { Presse-papier }
 pmwShellDos=5;         { Commande DOS }
 pmwShellUnix=6;        { Commande Unix }
 pmwInstall=7;          { Installation }
 pmwPIFEdit=8;          { Editeur de PIF }
 pmwReadMe=9;           { Lisez-moi }
 pmwWrite=10;           { Document }
 pmwPaint=11;           { Programme de dessin }
 pmwTerminal=12;        { Terminal }
 pmwNotePad=13;         { Bloc-notes }
 pmwCalendar=14;        { Calendrier }
 pmwCalc=15;            { Calculatrice }
 pmwClock=16;           { Horloge }
 pmwCharMap=17;         { Table de caractäres }
 pmwCDPlayer=18;        { Joueur de disque compacte }
 pmwFLIPlay=19;         { Joueur d'animation FLI }
 pmwBesch=20;           { Bescherelle }
 pmwConvers=21;         { Conversion }
 pmwCleanMgr=22;        { MÇnagäre de disque }
 pmwVolume=23;          { Volume du son }
 pmwPassWord=24;        { SÇcuritÇ }
 pmwSysInfo=25;         { Information systäme }
 pmwPascal=26;          { Source Pascal }
 pmwCPP=27;             { Source C/C++ }
 pmwCobol=28;           { Source Cobol }
 pmwAsm=29;             { Source Assembleur }
 pmwFormat=30;          { Formatter une disquette }
 pmwHexDiskEdit=31;     { Editeur de disque hexadÇcimal }
 pmwOpenWrite=32;       { Ouvre un document }
 pmwOpenPaint=33;       { Ouvre un dessin }
 pmwOpenNotePad=34;     { Ouvre un texte }
 pmwCfgCountry=35;      { Configuration du pays }
 pmwCfgVideoMode=36;    { Configuration du mode d'affichage vidÇo }
 pmwCfgMouse=37;        { Configuration de la souris }
 pmwCfgKeyboard=38;     { Configuration du clavier }
 pmwCfgJoystick=39;     { Configuration de la manette de jeux }
 pmwCfgSystem=40;       { Configuration du noyau systäme }
 pmwTetris=41;          { Jeux Tetris }
 pmwCfgPalette=42;      { Configuration des palettes de couleur }
 pmwCfgCyrix6x86=43;    { Configuraiton du Cyrix 6x86}
 pmwDel=44;             { Demande la poubelle}
 pmwNortonCommander=45; { Norton Commander }
 pmwHTMLComposer=46;    { HTML Composer }
 pmwCuteHTML=47;        { CuteHTML }
 pmwCfgDesktop=48;      { Configuration du bureau }
 pmwTechDraw=49;        { Dessin technique }
 pmwLogo=50;            { Langage de programmation LOGO }
 pmwGlobalDraw=51;      { Visualisateur global }
 pmwExplorerSystem=52;  { Explorateur systäme }
 pmwDataBase=53;        { Base de donnÇes }
 pmwExplorerDataBase=54;{ Explorateur de base de donnÇes }
 pmwMissileCommand=55;  { Jeux Missile Command }
 pmwNibbles=56;         { Jeux Nibbles }
 pmwShutDown=57;        { Arràte le systäme }
 pmwAtlas=58;           { Atlas }

  {Type de point}
 ptSimple=0;       { Un simple point }
 ptNoPoint=1;      { Point invisible }
 ptCroix=2;        { Une croix (+)}
 ptX=3;            { Un fois (X) }
 ptLineVert=4;     { Ligne vertical au dessus du point }
 ptLineHori=5;     { Ligne horizontal }

  {Mode d'interprÇteur BASIC}
 bmCK64=1;                  { InterprÇteur de BASIC de Commodore 64 }
 bmApple=2;                 { InterprÇteur de BASIC de l'Apple ][ }
 bmCOCO3=4;                 { InterprÇteur de BASIC COULEUR du COCO 3 }
 bmGWBASIC=8;               { InterprÇteur du BASICA/GWBASIC }
 bmTurboBasic=$10;          { Compilateur de TurboBasic }
 bmGFABasic=$20;            { GFA Basic d'Amiga }
 bmQBasic=$40;              { QBasic/QuickBasic }
 bmVisualBasic=$80;         { Visual Basic }
 bmAPSI=$100;               { BASIC APSI de 1978 }
 bmBasicPro=$200;           { BasicPro des Chevaliers de Malte }
 bmVAX=$400;                { BASIC VAX/Alpha }
 bmASP=$800;                { VBScript des ASP (Active Server Page)}
 bmAll=$FFFF;               { Tous les BASICs }

  {Mode des compilateurs PASCAL}
 pmPascalStandard=1;        { Pascal Standard }
 pmPascalB57=2;             { Pascal B57 }
 pmQuickPascal=4;           { QuickPascal }
 pmTurboPascal5=8;          { Turbo Pascal 5 }
 pmTurboPascal7=$10;        { Turbo Pascal 7 }
 pmTinkPascal=$20;          { Tink Pascal }
 pmCodeWarrior=$40;         { CodeWarrior }
 pmDelphi=$80;              { Delphi }
 pmKylix=$100;              { Kylix }

  {Mode d'interprÇteur de commande }
 piMSDOS=$0001;             { InterprÇteur de commande MS-DOS }
 piDRDOS=$0002;             { InterprÇteur de commande DR-DOS }
 piPCDOS=$0004;             { InterprÇteur de commande PC-DOS }
 piFreeDOS=$0008;           { InterprÇteur de commande FreeDOS }
 pi4DOS=$0010;              { InterprÇteur de commande 4DOS }
 piNDOS=$0020;              { InterprÇteur de commande NDOS/Norton Utility }
 piMalteDOS=$0040;          { InterprÇteur de commande Malte-DOS }
 piOS2=$0080;               { InterprÇteur de commande OS/2 }
 piWindows9X=$0100;         { InterprÇteur de commande Windows 9X }
 piVAX=$0200;               { InterprÇteur de commande VAX/Alpha }
 piUnix=$0400;              { InterprÇteur de commande Unix }
 piLinux=$0800;             { InterprÇteur de commande Linux }
 piXenix=$1000;             { InterprÇteur de commande Xenix }
 piAmigaDOS=$2000;          { InterprÇteur de commande AmigaDOS }

 piDOS=piMSDOS or piDRDOS or piPCDOS or piFreeDOS or pi4DOS or piNDOS or
       piMalteDOS or piOS2 or piWindows9X or piAmigaDOS;

Type
 ItemFont=Record
  Path:String;
  Index:FontIndexRecord;
 End;

  {Information recueilli pendant la lecture d'un arbre de rÇpertoire}
 FileInfoType=Record
  Size,SizeArchive,SizeHidden,SizeReadOnly,SizeSys,NmFile,NmSector,
  ArchiveFile,HiddenFile,ReadOnlyFile,SysFile,Directory:LongInt;
 End;

 {Structure de l'ensemble Icon graphique}
 ButtonMnu=Record
  FileName:String;
  X,Y,PerLn:Byte;
  Dir:(Hori,Vert);
  NB:Word;
 End;

 (***** Application *****)
 {Type pour les Impressions}
 PgNmType=(ptNone,ptLeft,ptRight,ptCenter,ptAltern);

 {Choisie un modäle d'imprimante}
 SelectPrn=Record
  Lst:LstMnu;
  PtrPChr:^TPChar;
  PtrSize:^TWord;
 End;

 {Structure d'impression}
 InfoPrintRec=Record
  XP:SelectPrn;
  NumCopy,                    { Nombre de copie }
  StartPage,EndPage:Word;     { Page de dÇpart et jusqu'Ö la page }
  Justify,                    { Justifier les lignes pour quelle soit de
                                màme longueur dans un paragraphe? }
  Compress,                   { Police de caractäres rÇduite? }
  Paysage,                    { Impression Paysage (dans l'autre sens) }
  Info:Boolean;               { Rajouter des informations complÇmentaires }
  AddPage:LongInt;            { Additionner se nombre au numÇro de page }
  Quality:(Standard,NLQ);     { QualitÇ d'impression, ordinaire ou NLQ }
  Page:PgNmType;              { NumÇro de page: aucun, droite, gauche ou centrÇe }
  Font:MListBox;              { NumÇro de police de caractäres Ö utiliser. }
  PrnOutput:MListBox;         { Sortie d'impression }
  Model:MListBox;             { Modäle d'imprimante }
  PrnType:Array[0..12]of Byte;{ Format d'impression }
 End;

 {Gestionnaire/configuration de l'imprimante }
 SetupPrn=Record
  Def:PrnSetupType;
  W:Window;
  P:Byte;
  SelPrn:SelectPrn;
  PrnMethode:SwitchOption;
  LstPrn,SelPrnOut:LstMnu;
 End;

 {Structure de dessin graphique}
 WIRec=Record
  T:TextBoxRec;                  { CoordonnÇe (X1,Y1)-(X2,Y2) }
  BitsPerPixel:Byte;             { Nombre de bits par pixel }
  NumXPixels:Word;               { Largeur en pixels }
  NumYPixels:Word;               { Hauteur en pixels }
  BaseColor:Word;                { Couleur de base }
 End;

 MCanvas=Record
  Screen:GraphBoxRec;       { Position du canvas Ö l'Çcran }
  SGXM,SGYM:Word;
  DrawX,DrawY:Word;
  Struct:WIRec;
  Res:ImageHeaderRes;
  DrawSize:Byte;            { êchelle d'agrandissement }
  XMove,YMove:Word;         { DÇplacement horizontal et vertical }
  CurrColor:Word;           { Couleur courante }
  Image:XInf;               { Dessin en mÇmoire }
  Miroir:XInf;              { Miroir logique du dessin }
  Magnify:Boolean;          { Mode magnifique }
  BitmapInit:Boolean;       { Image Bitmap crÇer? }
  MagnifyX,MagnifyY,MagnifyLength:Word; { Position de l'affiche rÇel en mode magnifique}
  PaletteRGB:^Palette256RGB;{ Palette de couleurs }
  CT:Array[0..255]of Byte;  { Table de conversion des couleurs }
 End;

  {Application Editeur texte (TypeWriter)}
 GPXHeader=Record
  Sign:Array[0..3]of Char; { Signature: 'GPX'#26 }
  Len,Height,Ln:Word;      { Largeur, Hauteur en pixels, nombre de bande }
  BitsPerPixel:Byte;       { Bits par pixels }
 End;

 LineHorInEdt=Record
  Model:Byte;              { Modäle correspondant (mtLineHor) }
  X1:Word;                 { Position horizontal supÇrieur }
  Y1:RBP;                  { NumÇro de ligne oó commence }
  X2:Word;                 { Position horizontal infÇrieur }
  Y2:RBP;                  { NumÇro de ligne ou le dessin finit }
  Bar:Char;                { Code de la barre }
 End;

 DrawInEdt=Record
  Model:Byte;              { Modäle correspondant (mtImage) }
  X1:Word;                 { Position horizontal supÇrieur }
  Y1:RBP;                  { NumÇro de ligne oó commence }
  X2:Word;                 { Position horizontal infÇrieur }
  Y2:RBP;                  { NumÇro de ligne ou le dessin finit }
  Pos:(deLeft,deCenter);   { Gauche, milieu }
  Path:String;             { Nom du dessin }
  GPX:GPXHeader;           { Entàte de la structure du dessin }
  Ofs:LongInt;             { Position absolue de l'image dans le fichier GPX }
  Res:XInf;                { Ressource attribut au dessin }
 End;

  { Format du texte dans la feuille }
 SheetFormatEditor=Record
  X1,X2:Word;              { Marge gauche, droite }
  Y1,Y2:RBP;               { Marge du haut et du bas de la page }
 End;

 {Enregistrement central d'Application de traåtement de texte}
 EditorApp=Record
  W:Window;                { Boåte de dialogue de l'Çditeur }
  List:ArrayList;          { Source du texte }
  Processus:ArrayList;     { Liste des processus (dessin,...) }
  SheetFormat:SheetFormatEditor;{ Format du texte dans la feuille }
  StrMX:Word;              { La plus grande largeur}
  FileSize:LongInt;        { Taille du texte }
  Mode:Byte;               { Mode d'Çdition }
  ModeSub:Word;            { Sous-mode d'Çdition (si traåtement de texte)}
  ReadOnly:Boolean;        { Mode lecture seulement, sans possibilitÇ de modifier le source }
  Modified:Boolean;        { Le texte a-t-il ÇtÇ modifiÇ depuis sa derniäre sauvegarde? }
  DrawMode:Boolean;        { Mode dessin? }
  MakeSpc:Boolean;         { Fabrication d'espace? }
  EditName,Title:String;   { Chemin du texte, titre du texte }
  X,Y,ChrAttr:Byte;        { Position (X,Y) actuel, attribut actuel des caractäres }
  P:RBP;                   { Ligne courante }
  PageNumStart:LongInt;    { Additionne au numÇro de page }
  PX,PXG:Word;             { Colonne courante logique et physique }
  ScrollLock:Boolean;      { Mode marge vÇrouillÇ? }
  InsMode:Boolean;         { Mode insertion? }
  InfoCompl:Boolean;       { Impression d'information complÇmentaire }
  PageNumIn:PgNmType;      { Impression des numÇros de lignes Ö droite, gauche, centrÇ ou absent }
  CurrPtr:Pointer;         { Pointeur de la ligne courante }
  DBInstr:DataSetInMemory; { Base de donnÇes des instructions (code source) }
  DBFunc:DataSetInMemory;  { Base de donnÇes des fonctions (code source) }
  DBMainWord:DataSetInMemory;{Base de donnÇes des mots rÇservÇs (code source) }
  _PutLn:Pointer;          { Pointeur de la procÇdure d'affichage ligne }
  PassWord:String[31];     { Mode de passe utilisÇ pour protÇgÇ le document }
  BX1,BX2:Word;            { Limite X1 et X2 d'un bloc }
  BY1,BY2:RBP;             { Limite Y1 et Y2 d'un bloc }
  OldXRules:Byte;          { Pointeur de la rägle }
  RefreshRules:Boolean;    { Restauration compläte de la rägle? }
  Interln:Boolean;         { Double interligne? }
  Option:Set of (eNoRules, {                   Pas de rägles }
                 eBarUp    {                   Barre d'outil en haut }
                );
  ModeList:Byte;           { Type de mode list (Aucun, ˛, chiffre,...)}
  ModeListNumber:Word;     { NumÇro courant dans la liste des nombres }
  Handle:Hdl;              { ÆHandleØ associÇ au fichier Ö lire (mode }
                           { de sauvegarde Ö partir d'un fichier directement)}
  TmpBuffer:Pointer;       { Pointeur de tampon temporaire pour les transfert et conversion }
  SizeTmpBuffer:Word;      { Taille du tampon temporaire pour les transfert et conversion}
  TmpBufferP:LongInt;      { Position du tampon temporaire }
 End;

 _TEPutLnProc=Procedure(Var Inf:EditorApp;Size,I1,P:Word;PChr:PChr);
 {Application Gestionnaire de fichier (FileManager)}
 TreeRec=Record
  Name:Array[0..10]of Chr; { Nom court du rÇpertoire }
  Nm:Byte;                 { Niveau de rÇpertoire }
 End;
 TreeArray=Array[0..65520 div SizeOf(TreeRec)]of TreeRec;
 TreePtr=^TreeArray;

 PanelFileManager=Record
  W:Window;             { Boåte de dialogue des tableaux }
  Select:^TBool;        { Tableaux des fichiers sÇlectionnÇs }
  BF:BF;                { Banque de fichier }
  Ext:Record
   Ass:^TWord;          { Association extensior }
   AssSize:Word;        { Taille de l'association extensior }
   AssCurrPos:Word;     { Position courante dans l'association d'extensior }
  End;
  P:LongInt;            { Position courante dans un tableau }
  SizeFileSel:LongInt;  { Taille des fichiers sÇlectionnÇ }
  Y:Byte;               { Position vertical de la barre }
  Board:Byte;           { Modäle des tableaux }
  OldBoard:Byte;        { Modäle des anciennes tableaux }
  Path:String;          { Nom des rÇpertoires des tableaux }
  SizeSelect:Word;      { Nombre de fichier sÇlectionnÇ }
  DirSelFiles:Word;     { Nombre de rÇpertoire sÇlectionnÇ }
  SelFiles:Word;        { Nombre de sÇlection }
  Brief:Boolean;        { Visualisation bräve }
  Status:Boolean;       { êtat de visualisation }
  Res:XInf;             { Ressource de visualisation }
  RM:XInf;              { Ressource miroir de visualisation }
  DescrList:Boolean;    { Affiche la description dans la liste }
   { Arbres }
  BufTree:Record        { Enregistrement des arbres de rÇpertoires: }
   Ptr:^TreeArray;      { Tableaux des arbres de rÇpertoires }
   SizePtr,NB:Word;     { Taille du tableau et le nombre de rÇpertoire }
  End;
   { Explorateur Windows }
  EW:DialogTreeObject;  { Objet d'Explorateur Windows }
 End;

 FileManagerApp=Record { Boåte de dialogue de gestionnaire de fichier }
  W:Window;                         { Boåte de dialogue centrale }
  Panel:Array[0..1]of PanelFileManager;{ Les pannels du gestionnaire de fichiers }
  Plane:Byte;                       { NumÇro du tableau courant: 0=gauche, 1=droite }
  ExtImg:Extensior;                 { Extensior }
  Name:String;                      { Nom du fichier de compression listÇ }
  SizeDsk,UsedDsk,FreeDsk:LongInt;  { Taille de l'unitÇ: Total, utilisÇ et disponible }
  CurrDsk:Byte;                     { UnitÇ courante }
  WildCard:String;                  { SÇlection gÇnÇrique courante }
  But:ButtonMnu;                    { Button utilisÇ pour la boåte de dialogue }
  HWildCard:History;                { Historique des sÇlections }
  DR:XInf;                          { Icìne d'UnitÇ disquette }
  HR:XInf;                          { Icìne de disque dur }
  CR:XInf;                          { Icìne de disque compacte }
  Explorer:Boolean;                 { Mode Explorateur Windows }
  NortonCommander:Boolean;          { Mode Norton Commander }
  RefreshAnyWay:Boolean;            { Autorise la rafraåchissement}
                                    { des icìnes en arriäre plan}
 End;

 PFileManager=^FileManagerApp;

 {Regarde/êdite hexadÇcimal (HexView)}
 SecPos=Record { Donne la position d'un secteur }
  Tete:Byte;        { tàte de lecture/Çcriture }
  SectCyl:Word;     { NumÇro de cylindre et de secteur }
 End;

 PartEntry=Record { EntrÇe dans la table des partitions }
  Status:Byte;      { Çtat partition }
  StartSec:SecPos;  { premier secteur }
  PartTyp:Byte;     { type de partition }
  EndSec:SecPos;    { dernier secteur }
  SecOfs:LongInt;   { Offset du boot secteur }
  NbreSec:LongInt;  { nombre de secteurs }
 End;

 PartSec=Record { dÇcrit le secteur de partition }
  BootCode:Array[0..$1BD]of Byte;    { Code de dÇmarrage du disque dur }
  PartTable:Array[0..3]of PartEntry; { Table des partitions de disque dur }
  IdCode:Word;                       { Signature: AA55h }
 End;

  { Gestionnaire de partition (exemple: FDISK,PartitionMagic,...) }
 PartitionManagerApp=Record
  W:Window;             { Objet de la fenàtre }
  HardDisk:Byte;        { NumÇro de disque dur physique }
  Partition:Byte;       { NumÇro de la partition courante }
  LC:Byte;              { NumÇro de disque dur par le BIOS: 80h+HardDisk }
  L:Window;             { Objet de barre d'affichage }
  FS:FileSystemObject;  { Objet de fichier systäme }
  LT1,LT2:ListTitle;    { Objet de barre de description }
  Changed:Boolean;      { Partition modifiÇ? }
  TechFlag:Boolean;
  ParSec:PartSec;
  FileName:String;      { Nom du fichier utilisÇ pour simulÇ un disque }
  StartPos:LongInt;     { Position de dÇpart dans le fichier }
 End;

 HexEditApp=Record
  W:Window;                         { Boåte de dialogue de l'Çditeur Hex}
  ViewName:String;                  { Nom du fichier hexadÇcimal Ö Çditer }
  EditMode:Boolean;                 { Mode d'Çdition?}
  DskView:Boolean;                  { Visualisation du disque? }
  Partition:Byte;                   { Partition numÇro ? }
  Mount:Boolean;                    { Disque montÇ? }
  CurrRec,MaxRec:LongInt;           { Enregistrement courant et maximum }
  Mode:(Hex,Full);                  { Mode d'Çdition hexadÇcimal/plein }
  Operator:Record
   NotOp,XorOp,OrOp,AndOp:Boolean;  { Attribut Ö ajouter NOT, XOR, OR, AND }
  End;
  TrackMin,TrackMax,CurrTrack:Word; { Cylindre minimum, maximum, courant }
  CurrSector,CurrHead,              { Secteur courant, tàte courante }
  SectorMin,HeadMin,                { Secteur minimum, tàte minimum }
  SectorMax,HeadMax:Byte;           { Secteur maximum, tàte maximum }
  Bi,X,Y,Plane:Byte;                { CoordonnÇe X, Y et le cìtÇ du tableau}
  Modified:Boolean;                 { DonnÇes modifiÇe?}
  Moved:Boolean;                    { DÇplacement des donnÇes?}
  FS:FileSystemObject;              { Objet de ficher volume image }
  ModBoard:Array[0..2047]of Byte;   { Tableau des donnÇes modifiÇes}
  Buffer:Array[0..2047]of Byte;     { Tableau temporaires des donnÇes courante}
 End;

 {êditeur d'Icon (IconEditor)}
 IconEditApp=Record
  W:Window;                               { Fenàtre de l'application }
  Name:String;                            { Nom du fichier icìne }
  WritePathIcon:String;                   { Dernier rÇpertoire demander pour la sauvegarde d'un icìne }
  Res:ImageHeaderRes;                     { Information technique sur l'image }
  Block:BlockButton;                      { Enregistrement de l'icìne courant }
  Palette:Array[0..15]of RGB;             { Palette de couleur associÇe }
  Shadow:Array[0..127]of Byte;            { La partie Ö ne pas altÇrer }
  X,Y,XM,YM,CurrKr,Mode:Byte;
  CurrPg:Word;                            { NumÇro de la page courante }
  Modified,SM:Boolean;                    { CoordonnÇe fixÇ; ModifiÇ }
 End;

 {Menu d'Application}
 LoaderMenuApp=Record
  W:Window;                 { Boåte de dialogue du Menu d'Application }
  NameL,ParamL:String[127]; { Nom du programme et ces paramätres }
  Ym,Level:Byte;            { Position vertical dans la fenàtre, niveau }
  Pm:Word;                  { Position absolue dans la liste }
  LstMnu:ArrayList;         { Liste des programmes }
  Path:PathStr;             { Chemin }
  LastKr:Byte;              { La derniäre couleur...}
 End;

 {Application Regarde Ascii (ViewAscii)}
 ViewAsciiApp=Record
  W:Window;             { Fenàtre de visualisation }
  FileName:String;      { Nom du fichier Ö visualiser }
  Min,FileSize:LongInt; { CoordonnÇe minimum et maximum (taille de fichier) }
  PBnk:^TLong;          { Banque de position de chaque dÇbut de ligne }
  SizeBnk:Word;         { Taille de la banque de position }
  View:(ASCII,Hlp,GAT); { Visualisateur sous forme d'Aide, GAT ou Normal (ASCII) }
  Raw:Boolean;          { Ne pas mettre de cadre, par exemple pour voir
                        { directement Ö partir d'une autre fenàtre... }
 End;

 {Application Prompt}
 Prompt=Record
  Ansi:Window;             { JAMAIS DEPLACER! Boåte de dialogue utilisÇ pour le prompt }
  ImageLst:ArrayList;      { JAMAIS DEPLACER! Image du contenu de l'Çcran }
  TmpImageLst:String;      { JAMAIS DEPLACER! Ligne courante temporaire }
  Param,Ext:String;        { Commande et paramätres }
  Echo:Boolean;            { êcho autorisÇ? }
  H,Alias:History;         { Histoire, Alias }
  Dump:Record Case Byte of { Position courante de la commande ÆDUMPØ ou }
   0:(Ptr:Pointer);        { ÆUNASMØ permet de traåter directement en }
   1:(Long:LongInt);       { mÇmoire ou dans un fichier le traáage }
  End;                     { utilisateur. }
  DumpFile:String;         { Nom du fichier courant de ÆDUMPØ }
  Mode:Word;               { Mode d'interprÇteur de commande }
  Convention:(             { Convention de style: }
   pDos,                   {  DOS/MS-DOS/DR-DOS }
   pVax,                   {  VAX/Alpha }
   pUnix);                 {  Unix/Linux }
  CmdSearch:SearchOption;  { MÇthode de recherche des commandes }
  FS:LongInt;              { Taille du fichier }
  NP:Word;                 { Nombre de paramätres de la commande courante }
   {SpÇcifique Ö Unix }
  PS1,PS2,PathVar:String;  { Variable d'environnement Unix }
  PathUnix:String;         { RÇpertoire courant du Shell Unix}
   {Tampon d'historique }
  History:Record
   Len:Word;               { Longueur de la clÇ }
   EndCmd:Word;            { Position de fin du tampon d'historique }
   Buffer:Array[0..511]of Byte;{ Tampon }
  End;
 End;

 {Debug}
 DebugRec=Record
  W:Window;                    { Fenàtre de dialogue utilisÇ par le dÇbogueur }
  Monitor:(Primary,Secondary);
  Name:String;
 End;

 {Watch-Calculatrice Programmable}
 WatchWin=Record
  W,Sub:Window;
  V:ArrayList;
 End;

 {Programme de dessin}
 DrawEditApp=Record
  W:Window;                   { Objet de la fenàtre de la boåte de dialogue }
  Canvas:MCanvas;             { Objet ressource de l'image }
  HelpBar:Window;             { Objet de barre d'aide }
  OldHelpBarP:SmallInt;       { Ancien position de la barre d'aide }
  MaxX,MaxY:Word;             { Maximum X et Y en magnifique }
  XM,YM,XE,YE:Integer;        { Endroit de la boåte de sauvegarde }
  BufCurSize:Word;            { Taille du tampon de curseur }
  XC,YC,XO,YO,XPtr,YPtr:Word; { CoordonnÇes }
  XText,YText:Word;           { Pointeur sur le texte }
  Mode:Word;                  { Mode d'objet? (drw????) }
  Fill:Boolean;               { Mode plein ?}
  CircleMode:Boolean;         { Mode cercle? (affiche d'un point)}
  RectMode:Boolean;           { Mode rectangle? (affiche d'un point)}
  PointType:Byte;             { Type de point (pt???) }
  LengthBrush:Word;           { Largeur de l'efface }
  HeightBrush:Word;           { Hauteur de l'efface}
  BaseColor:Word;             { Couleur de fond }
  SM,Modified:Boolean;        { CoordonnÇe fixÇ; ModifiÇ }
  FileName:String;            { Nom du fichier de dessin }
  ImgBufCur:ImgRec;           { Tampon de ressource pour le pointeur graphique alÇatoire...}
  BufCur:Pointer;             { Tampon pour le pointeur graphique }
  ButtonDraw:ButtonMnu;       { Button utilisÇ pour la boåte de dialogue }
  FontType:ItemFont;          { Type de police Ö utilisÇ pour le dessin }
  PathFont:String;            { Nom de la police }
  QQF:^TByte;                 { Pointeur de la police QQF }
  QQFSize:Word;               { Taille de la police QQF }
  QQFHeight:Byte;             { Hauteur de la police QQF }
 End;

  {Structure du HashCode}
Const
 MaxBuckets=1000;
 MaxHashItemSize=512;

Type
 BucketRange=1..MaxBuckets;
 HashItemSizeRange=1..MaxHashItemSize;

 HashItemData=Array[0..Pred(MaxHashItemSize)]of Byte;
 HashItemDataPtr=^HashItemData;
 HashItemPtr=^HashItem;
 HashItem=Record
  Next:HashItemPtr;
  Data:HashItemData;
 End;
 HashItemArray=Array[BucketRange]of HashItemPtr;

 HashTable=Record
  DefaultItemSize:Word;
  Buckets:BucketRange;
  Items:LongInt;
  CurrItem:HashItemPtr;
  CurrBucket:BucketRange;
  HashData:^HashItemArray;
   { DonnÇes externe }
  Context:Pointer; { Contexte des routines virtuels }
  CreateItem:Procedure(Var Context;Var Item:HashItemPtr);
  CurrItemSize:Function(Var Context;Item:HashItemPtr):Word;
  Found:Function(Var Context;Item:HashItemPtr):Boolean;
  HashValue:Function(Var Context):Word;
  ItemSize:Function(Var Context):Word;
 End;

  {Structure du tableur}
 CelluleValue=Record
  Value:Real;          { Valeur de la cellule }
  Dec:Byte;            { Nombre de dÇcimal }
 End;

 CelluleText=Record
  Text:String;        { Chaåne de caractäre de la cellule }
 End;

 CelluleFormula=Record
  Value:Real;      { Valeur actuel de la formule }
  Compute:Boolean; { Formule calculer? }
  Error:Boolean;   { Erreur de la valeur }
  Cellule:Boolean; { Y a-t-il au moins une cellule dans la formule? }
  Dec:Byte;        { Nombre de dÇcimal }
  Formula:String;  { Formule proprement dite }
 End;

 CelluleHeader=Record
  Format:Byte;
  Justify:(cLeft,cCenter,cRight);
  Attribut:Byte;         { Couleur d'attribut (comme celui de l'Çcran de texte)}
  GAttr:Byte;            { Attribut Gras=1, Souligner=2,...}
 End;

  { DÇfinition d'une colonne }
 ColumnHeader=Record
  Length:Integer;        { Largeur de la colonne }
 End;

 CelluleRec=Record
  Column,Row:LongInt;
  Header:CelluleHeader;
  Data:Record Case Byte of
  {cfEmpty:();}
   cfValue:(v:CelluleValue);
   cfText:(t:CelluleText);
   cfFormula:(f:CelluleFormula);
   cfColumn:(c:ColumnHeader);
  End;
 End;

 PCellule=^CelluleRec;

 ColumnRec=Record
  Column:LongInt;
  Header:CelluleHeader;
  c:ColumnHeader;
 End;

 PColumn=^ColumnRec;

 ColumnObject=Record
  List:HashTable;
  Curr:ColumnRec;
 End;

 CelluleObject=Record
  List:HashTable;
  Curr:CelluleRec;
  X1,Y1,X2,Y2:LongInt;
 End;

 {Chiffrier Çlectronique, Tableur }
 SuperCalcApp=Record
  W:Window;                    { Fenàtre de dialogue utilisÇ par le tableur }
  HomeLine:Byte;               { Position de dÇpart vertical de la grille }
  FileName:String;             { Nom du fichier }
  Mode:Byte;
  YS:Byte;                     { Position physique Ö l'Çcran }
  XL:Byte;                     { Position logique Ö l'Çcran }
  Column:ColumnObject;         { Tableau de colonnes }
  ColumnX:Array[0..59]of Byte; { Position des colonnes Ö l'Çcran }
  MaxColumnX:Byte;             { Derniäre position de la liste }
  Cellule:CelluleObject;       { Tableau des cellules }
  PX,PY,PZ:LongInt;
  FormatMode:Byte;             { Mode de sauvegarde du fichier }
  Moved:Boolean;               { DÇplacement? }
  MovedX:Boolean;              { DÇplacement horizontal? }
  MovedY:Boolean;              { DÇplacement vertical? }
  Modified:Boolean;            { Modification de cellule est en cours? }
  GlobalModified:Boolean;      { Modification nÇcessistant une sauvegarde }
  CellPos:Byte;                { Position dans la cellule lors de l'Çdition }
  BX1,BY1,BX2,BY2:LongInt;     { Position du bloc }
  BufChr:String;
 End;

 {êditeur de Police}
 FontEditor=Record
  W:Window;              { Fenàtre de dÇveloppement }
  FileName:String;       { Nom de la police de caractäres }
  Height:Byte;           { Hauteur de la police de caractäres }
  Ptr:^TByte;            { Pointeur sur la police de caractäres }
  Clipboard:Array[0..15]of Byte;{ Presse-papier }
  SizeOfPtr,CurrChr:Word;{ Taille de la police de caractäre,
                           numÇro du caractäre courant}
  Modified:Boolean;      { Drapeaux indiquant si une modification a ÇtÇ
                           effectuer sur la police de caractäres}
  X,Y:Byte;              { Position absolue horizontal et vertical sur un
                           caractäre de la police de caractäres}
 End;

 {Gestionnaire ÆHØ}
 HWin=Record
  SerialNumber:Byte;          { NumÇro de sÇrie ou modäle }
  Init:Function(Var Q;X1,Y1,X2,Y2:Byte):Boolean;
  Load:Procedure(Var Q;X1,Y1,X2,Y2:Byte;Const Path:String);
  Run:Function(Var Q):Word;
  Done:Function(Var Q):Word;
  Refresh:Procedure(Var Q);
  Save:Function(Var Q):Boolean;
  SaveAs:Function(Var Q;Const Path:String):Boolean;
  SizeOfQ:Word;                    { Taille des donnÇes physique de la fenàtre }
  Title:Function(Var Q;Max:Byte):String;{ Nom par dÇfaut de la fenàtre }
  ReSize:Procedure(Var Q;X1,Y1,X2,Y2:Byte);
  NumXTexts,NumYTexts:Byte;        { Nombre de colonne et de ligne exigÇe }
  OnDeactivate:Procedure(Var Q);   { êvÇnement appelÇ lorsque la fenàtre
                                     n'est plus au premier plan. }
  Move2:Procedure(Var Q;X,Y:Byte);
  OnWaiting:Procedure(Var Q); { êvÇnÇment appelÇ lorsque le systäme est en
                                attente et qu'il ne fait rien... }
  OnKeyPress:Procedure(Var Q;Key:Char);{ êvÇnÇment lorsqu'une touche
                                         clavier de style ASCII }
  OnKeyDown:Procedure(Var Q;Key:Word;Shift:ShiftState);
  OnKeyUp:Procedure(Var Q;Key:Word;Shift:ShiftState);
  OnMouseDown:Procedure(Var Q;X,Y:Integer;TX,TY:Byte;Shift:Word);
  OnMouseUp:Procedure(Var Q;X,Y:Integer;TX,TY:Byte;Shift:Word);
  OnMouseMove:Procedure(Var Q;X,Y:Integer;TX,TY:Byte);
  OnMouseControl:Procedure(Var Q;Control:Word);
 End;

 InternalModel=Record
   {NOTES: Dependance Menu Contextuel du programme de dessin: EditorStruct }
  Model:Byte;              { Modäle, numÇro de sÇrie...}
  O:TextBoxRec;            { Pour le Zoom...}
  InTaskBar:Boolean;       { Invisible sur la barre de tÉche }
  X:Record Case Byte of
   0:(Data:Array[0..0]of Byte); { DonnÇe typique Ö la fenàtre }
   1:(W:Window);
  End;
 End;

 HWins=Record
  X,Lst:ArrayList;            { DÇfinition des fenàtres, liste des fenàtres}
  Curr:RBP;                   { NumÇro de la fenàtre courante }
  CurrModel:^InternalModel;   { Pointeur sur la fenàtre courante}
  CurrHWin:^HWin;             { Pointeur de dÇfinition de la fenàtre courante}
  HomeYEditor:Byte;           { Position minimum vertical }
  YEditor:Byte;               { Position verticale courante de la prochain fenàtre}
  VisualLst:^TWord;           { NumÇro des fenàtres affichÇes en premier jusqu'au derniäre }
  SizeVisualLst:Word;         { Taille de la ÆVisualLstØ }
  OnRefreshBackground:Procedure;{Cette routine est appellÇe Ö chaque fois que la
                                 rafraåchissement de l'arriäre plan Ö lieu}
  MenuTitleContext:Procedure(Var Q);{Appeler lorsque le deuxiäme bouton clic la souris }
 End;

 {Gestionnaire de programme}
 ProgramsManagerApp=Record
  W:Window;         { Fenàtre de dialogue }
  ML,L:ArrayList;   { Liste des Onglets, liste des applications de l'onglet courant }
  WP,P:Word;        { Onglet courant, Position courante }
  YP:Integer;       { Position vertical de dÇcalage }
  MXP:Integer;      { Position maximal horizontal }
  MYP:Integer;      { Position maximal vertical de dÇcalage }
  Min,Max:Word;     { La position minimum et maximum dans l'onglet courant }
  Kr:Byte;          { Attribut de couleur de l'onglet courant }
  CurrProg:Byte;    { Programme demander...}
  Modified:Boolean; { Modifier? }
  Mode:(mDefault,   { Par dÇfaut }
        mWin9X,     { Menu Windows 9X }
        mOS2Warp3,  { Tableau de bord d'OS/2 Warp 3 }
        mFolder);   { Dossier }
  Option:Set of (
          NoOnglet, { Onglet prÇsent? }
          NewFolder,{ Ouvrir une nouvelle fenàtre si cliquer rÇpertoire }
          DirLine,  { Ligne indicatrice de rÇpertoire ou d'adresse Internet }
          KeyTool   { Touche outils sur la premiäre ligne (genre Precedent, Suivant,...)}
         );
  Path:String;      { Nom du fichiers contenant les indications de programmes }
  Title:String;     { Titre de la fenàtre s'il y a lieu}
  SizeFolder:LongInt;{Taille de tous les fichiers du dossier (dossier seulement) }
   { DonnÇe interne }
  SXI,SYI:Byte;     { Position du derniäre affichage d'icìne dans la fenàtre }
 End;

  {Commande SQL}
 OptionPromptSQL=Set of(   { Instruction SET d'ISQL: }
   sAutoDDL,               { Valider seulement apräs un commit? }
   sCount,                 { Affiche le nombre de ligne? }
   sEcho,                  { Affiche la commande? }
   sList,                  { Affiche en format tabulaire? }
   sPlan,                  { Affiche le plan de requàte? }
   sStats,                 { Affiche les statistiques? }
   sTime                   { Affiche l'heure dans une date? }
  );

 SQLCommandApp=Record
  W:Window;                { Fenàtre de dialogue }
  ImageLst:ArrayList;      { JAMAIS DEPLACER! Image du contenu de l'Çcran }
  TmpImageLst:String;      { JAMAIS DEPLACER! Ligne courante temporaire }
  Mode:Word;               { Mode du prompt SQL (Mentronix, Oracle, SQL Server,...)}
  Param:String;            { Paramätres }
  Option:OptionPromptSQL;  { Instruction SET d'ISQL }
  Request:Byte;            { Type de requàte SQL }
  ObjDataBase:DataSet;     { Base de donnÇes courante }
  CurrDataBase:String;     { Chemin de la base de donnÇes courante }
  TableName:String;        { Nom de la table }
  Error:Word;              { Code d'erreur }
  H:History;               { Historique des commandes }
  Instr:DataSetInMemory;   { Tampon des commandes SQL }
   {Tampon d'historique }
  History:Record
   Len:Word;               { Longueur de la clÇ }
   EndCmd:Word;            { Position de fin du tampon d'historique }
   Buffer:Array[0..511]of Byte;{ Tampon }
  End;
 End;

  {Object du dessin en fil de fer }
 TechDrawLineRec=Record
  ID:Byte;              { Identificateur de ligne }
  X1,Y1,X2,Y2:Real;     { CoordonnÇe rÇel de la ligne }
  Z1,Z2:Real;           { Troisieme dimension }
  Color:RGB;            { Couleur associÇe }
 End;

 TechDrawRectRec=Record
  ID:Byte;              { Identificateur de ligne }
  X1,Y1,X2,Y2:Real;     { CoordonnÇe rÇel de la ligne }
  Z1,Z2:Real;           { Troisieme dimension }
  Border:RGB;           { Couleur de bordure }
  Background:RGB;       { Couleur de fond de la boåte rectangulaire }
  Transparent:Boolean;  { Transparent? }
  LineWidth:Word;       { êpaisseur de la ligne }
  WidthRotate:Word;     { Longueur des coins rond }
 End;

 DirectionType=Set of (dFirst,dSecond);

 TechDrawDFDFluxRec=Record
  ID:Byte;                          { Identificateur de ligne }
  X1,Y1,X2,Y2:Real;                 { CoordonnÇe rÇel de la ligne }
  Z1,Z2:Real;                       { Troisiäme dimension }
  Color:RGB;                        { Couleur associÇe }
  Direction:DirectionType;          { Direction (Premier, Deuxiäme) }
 End;

 TechDrawDFDProcessusRec=Record
  ID:Byte;              { Identificateur du processus }
  X1,Y1,X2,Y2:Real;     { CoordonnÇe rÇel du processus }
  Z1,Z2:Real;           { Troisiäme dimension }
  Color:RGB;            { Couleur associÇe }
  NumID:Word;           { NumÇro d'identification }
  IdAlpha:String;       { Identificateur alphanumÇrique }
  Name:String;          { Nom du processus de DFD }
  Alias:String;         { Alias du processus de DFD }
  NameCode:String;      { Nom codÇ de processus de DFD }
  RegleSynch:String;    { Rägle de synchronisation }
  EnsComposant:String;  { Ensemble de composant }
  CoutFixe:Real;        { Coñt fixe }
  TempsFixe:Real;       { Temps fixe }
  Option:Set of (
   dpExtern,            { Externe }
   dpExplode,           { êclatÇ }
   dpControl            { Contrìle }
  );
 End;

 TDObject=Record Case Byte Of
  imiRealLine:(DrawLine:TechDrawLineRec);
  imiRealBox:(DrawRect:TechDrawRectRec);
  imiDFDFlux:(DFDFlux:TechDrawDFDFluxRec);
  imiDFDProcessus:(DFDProcessus:TechDrawDFDProcessusRec);
 End;

 EncrageType=(etNone,etUpLeft,etUpRight,etDownLeft,etDownRight,
                     etUp,etDown,etLeft,etRight);

  {Dessin technique (en file de fer)}
 TechDrawApp=Record
  W:Window;                { Fenàtre de dialogue }
  Screen:GraphBoxRec;      { CoordonnÇe graphique dans la fenàtre de l'image }
  Lst:ArrayList;           { Liste contenant les informations sur le dessin }
  XScroll,YScroll:Word;    { DÇplacement X et Y }
  ZScroll:Word;            { DÇplacement Z }
  ZScale:Word;             { Scalaire Z }
  XCenter,YCenter:Word;    { Centre de la fenàtre }
  CurrFrame:Word;          { Frame courant pour les animations }
  SensX:ShortInt;          { Animation: Sens X }
  SensY:ShortInt;          { Animation: Sens Y }
  SensZ:ShortInt;          { Animation: Sens Z }
  LenCoord:Byte;           { Longueur du message de coordonnÇes }
  Mode:(tdmEdit,tdmAnim);  { Mode: êdition, animation,... }
  CurrObject:^TDObject;    { Pointeur sur l'object en fil de fer courant }
  CurrPosObject:Integer;   { Position de l'objet courant }
  CurrYObject:Integer;     { Position visual dans la fenàtre de l'objet courant }
  Encrage:EncrageType;     { Encrage }
  TrueBackgroundColor:Word;{ Couleur physique de fond }
  ProcessusID:Word;        { Processus d'identification }
  DepotID:Word;            { DÇpot d'identification }
  EntiteID:Word;           { EntitÇe d'identification }
  FluxID:Word;             { Flux d'identification }
  CurrColor:Word;          { Couleur courante }
  Modified:Boolean;        { ModifiÇe? }
  FileName:String;         { Nom du fichier couramment Çditer }
  FileInfo:ImiHeader;      { Information fichier }
  Composant:DataSetInMemory;{Composante d'Çlectronique par exemple }
  IsImage:Boolean;         { Il y a une image d'exportation? }
  Image:XInf;              { Image de sauvegarde d'exportation }
  ResImage:ImageHeaderRes; { Information sur l'image d'exportation }
  CompPosX:^TByte;         { Position X des composants }
  CompPosY:^TByte;         { Position Y des composants }
  OldCompPosX:Byte;        { Ancienne position X de composants }
  OldCompPosY:Byte;        { Ancienne position Y de composants }
  CompSize:Word;           { Taille des positions }
  HelpBar:Window;          { PrÇservation de la barre d'aide }
  PaletteBar1:Window;      { Barre de palette 1 }
  PosPalette1:Word;        { Position dans la palette 1 }
  LastPalette:Word;        { Derniäre position de la palette }
  PaletteBar2:Window;      { Barre de palette 2 }
  PosPalette2:Word;        { Position dans la palette 2 }
  CurrMatrix:Word;         { Objet courant de la matrice }
  Cos,Sin:Array[0..360]of Integer;{ Table des Sinus et Cosinus }
 End;

  {Jeux Tetris}
 TetrisHighScoreFile=Record
  Len:Word;
  User:Array[0..9]of Record
   Name:String[31];
   Score:LongInt;
   Level,Bar:Word;
  End;
 End;

 GameInputMode=(imJoystick,imKeyboard);

 TetrisGame=Record
  MainWin:Window;
  Mode:(tmNone,tmStart,tmPlay,tmGameOver);
  InputMode:GameInputMode;
  FullScrn:Boolean;    { Jouer en mode pleine Çcran }
  CurrJoy:Byte;        { NumÇro de la manette de jeux courante }
  XBrut,YBrut:Word;    { CoordonnÇe centrÇe de la manette de jeux }
  OX1,OY1,OX2,OY2:Byte;{ Dimension d'origine de la fenàtre }
  Level:Byte;
  Score:LongInt;
  Bar,SLevel:Word;
  Tbl:Array[0..20,0..9]of Boolean;
  Form,Move,X,Y,Sleep:Byte;
  K:Word;
  Touch,Ok:Boolean;
  SleepDelay:Byte;
  OldAttr,H,XT:Byte;
  W:Window;
  Kr:MtxColors;
  FBar:Word;
  xR:RGB;
  OldWinType:WinModelType;
  HighScore:TetrisHighScoreFile;
  UpDate:Boolean;
 End;

 {Jeux ÆMissile CommandØ }
 MissileCommandGame=Record
  MainWin:Window;
  G:GraphBoxRec;
  Score:LongInt;
  NumCity:Byte;
  Level:Word;
  KM:SmallInt;
  PtrOn:Boolean;
  Color1,Color2,Color3:Word;
  MI,ML:Array[0..19]of Byte;
  MX1,MX2:Array[0..19]of Word;
  LevelMissile:Array[0..5]of Byte;
  LevelMaxMissile:Array[0..5]of Byte;
  MaxMissile,Missile2Send:SmallInt;
  PtrMs:String;
 End;

 {Jeux ÆNibbleØ }
 NibbleGame=Record
  MainWin:Window;
  G:GraphBoxRec;
  CurrText:Byte;
  Speed:SmallInt;
  D:Byte;
  MaxYPixel:Word;
  X,Y,RX,RY,PR:Array[1..2]of SmallInt;
  Pal:Array[0..1]of Array[0..7]of RGB;
 End;

  {Application joueur multimÇdia}
 MediaPlayerRec=Record
  W:Window;
  State:(mpNone,mpPause,mpPlay);
 End;

 TPolyface=Record
  Pix:Array[0..NmPntMxFace]of Integer;
  nbPixs,Kr:Integer;
 End;

 TObjet=Record
  face:Array[0..NmFaceMxObj]of TPolyface;
  x3d,y3d,z3d:Array[0..NmPntMxObj]of Integer;
  nbPixs,nbfaces:Integer;
 End;

 {Animation 3D}
 Anim3D=Record
  W:Window;
  TCos,TSin:Array[0..360]of Integer;
  VirtualScreen:XInf;
  CurObj,Speed:Word;
  FilDeFer:Boolean;
  Objet:Array[0..7]of TObjet;
  XC,YC,X1,Y1,X2,Y2:Word;
 End;

  {Application Calendrier}
 CalendarApp=Record
  W:Window;                   { Fenàtre de dialogue utilisÇ par le calendrier }
  Year:LongInt;               { AnnÇe courante }
  Month,Day,DayOfWeek:Byte;   { Mois, jour, jour de la semaine }
  WeekDayMode:Byte;           { Mode de jour de semaine: 0=Standard, 1=Astre, 2=Latin,... }
  MonthMode:Byte;             { Mode de mois: 0=Standard, 2=Latin,... }
 End;

  {Application d'agenda}
 AgendaApp=Record
  W:Window;                   { Fenàtre de dialogue utilisÇ par l'agenda }
  Person:DataSet;             { Table de personne }
  Phone:DataSet;              { Table de numÇro de tÇlÇphone }
  NoPersonne:Word;            { NumÇro personne courante }
  TPhone:Array[0..31]of Word; { Liste des positions de numÇro de tÇlÇphone de la personne courante }
  MP:Byte;                    { Position maximal de numÇro de tÇlÇphone }
  LT:ListTitle;               { Objet de barre de description }
  Tried:Boolean;              { Le nom sont triÇe? }
  Tri:^TWord;                 { Les positions absolue de la tri }
  NumTri:Word;                { Nombre d'ÇlÇments dans la tri }
  Y:Byte;
  P:LongInt;
  FileName:String;            { Nom du fichier de la table de personne }
  FileNamePhone:String;       { Nom du fichier de la table de numÇro de tÇlÇphone }
 End;

  {GlobalDraw}
 GlobalDrawApp=Record
  W:Window;                   { Boåte de dialogue associÇ Ö cette application }
  NumWidth:Word;              { Nombre d'icìne de largeur }
  NumHeight:Word;             { Nombre d'icìne de hauteur }
  Path:String;                { Nom du rÇpertoire Ö analyser }
  Image:^TXInf;               { Tableau d'image }
  ImageSize:Word;             { Taille du tableau d'image }
  Files:BF;                   { Contenu du rÇpertoires courant }
  P:Word;                     { Position }
  X,Y:Byte;                   { Position X et Y }
  MinX:Byte;                  { Position X minimum }
  MinY:Byte;                  { Position Y minimum }
  Tree:DialogTreeObject;      { Arbre de rÇpertoire }
 End;

  {Application LOGO }
 LogoApp=Record
  W:Window;                   { Boåte de dialogue associÇ Ö cette application }
  TurtleW:Window;             { Fenàtre de tortue }
  Angle:Real;                 { Angle de la tortue }
  X,Y:Integer;                { Position de la tortue }
  XC,YC:Integer;              { Position centre }
  PC:PChr;                    { Pointeur sur la ligne courante }
  I:Word;                     { Position dans la ligne }
  Line:Integer;               { Ligne courante }
  PenDown:Boolean;            { Crayon baissÇ? }
  Source:EditorApp;           { Editeur de source du LOGO }
  BouclePos:Byte;
  Boucle:Array[0..63]of Record
   Model:(blNone,blFor,blWhile,blDo);
   X,Y,X2,X3:Word;
   Data:Array[0..6]of Byte;
  End;
  Gosub:Array[0..63]of Record
   X,Y:Word;
  End;
  Fonction:DataSetInMemory;   { Table des fonctions }
  CurData:Word;               { Position courante dans les donnÇes }
  ExitCode:Integer;           { Code de sortie }
  Data:Array[0..1023]of Byte; { DonnÇes local }
 End;

  {Application de base de donnÇes}
 DataBaseApp=Record
  W:Window;                   { Boåte de dialogue associÇ Ö cette application }
  DataBase:DataSet;           { Base de donnÇes de associÇs Ö cette application }
  Mode:Word;                  { Mode d'affichage: 0=Navigateur, 20=Edite les champs...}
  ReadOnly:Boolean;           { Mode en lecture seulement }
  XP:Word;                    { NumÇro du champs courant (position horizontal) }
  P:LongInt;                  { Ligne d'enregistrement dans la base de donnÇes }
  Y:Byte;                     { Position vertical }
  YP:Byte;                    { Position vertical dans le format colonnes }
  NumRec:LongInt;             { Nombre d'enregistrement }
  SizeColumn:Word;            { Taille du tableau de largeur des colonnes }
  Column:^TByte;              { Tableau de largeur des colonnes }
  ListField:ArrayList;        { Liste de champs pendant l'Çdition }
  CurrField:FieldDataBaseRec; { Champs courant pendant l'Çdition }
  IndexPos:^TWord;            { Index de position pour le serveur }
  OldP:LongInt;               { Ancienne position d'une table }
  OldY:Byte;                  { Ancienne position d'affichage d'une table }
  OldXP:Byte;                 { Ancienne position de champs }
  ExternDataBaseName:String;  { Nom de la base de donnÇes externe }
  ExternDataBaseOffset:Record {DÇplacement de la base de donnÇes externe }
   Long:LongInt;
   Word:Word;
  End;
 End;

  {Explorateur de base de donnÇes}
 ExplorerDataBaseApp=Record
  W:Window;                   { Boåte de dialogue associÇ Ö cette application }
  Tree:DialogTreeObject;      { Arbre de rÇpertoire }
  DataBase:DataSet;           { Base de donnÇes de associÇs Ö cette application }
  MinX:Byte;                  { Position X minimum }
  MinY:Byte;                  { Position Y minimum }
  SpreadSheet:DataBaseApp;    { Feuille de base de donnÇes }
 End;

 CategorieGeographique=(Ville,Pays);

  {Application Atlas de gÇographie}
 GeoApp=Record
  W:Window;                   { Fenàtre de l'application }
  Geo:DataSet;                { Base de donnÇes gÇographique de ville }
  Pays:DataSetInMemory;       { Table des pays }
  Country:SmallInt;           { Identificateur de pays }
  IDCountry:SmallInt;         { Identificateur de pays/rÇgion }
  Global:Boolean;             { Application global }
  Mode:CategorieGeographique; { CatÇgorie gÇographique de recherche }
  R:DBListBox;
 End;

  {InterprÇteur BASIC }
 BasicStruct=Record
  W:Window;                   { Feuille utiliser pour l'interprÇteur }
  InForm:Boolean;             { ExÇcution dans une feuille? }
  CreateForm:Boolean;         { Feuille crÇer? }
  ViewMenu:Boolean;           { Voir menu? }
  Output:Hdl;                 { Fichier de sortie pour ASP par exemple }
  Mode:Word;                  { Mode de Basic }
  Line:Word;                  { NumÇro de ligne d'exÇcution }
  X:Word;                     { Position courante sur la ligne }
  PC:PChr;                    { Pointeur sur la ligne courante }
  _ELSE:Integer;              { Conditionnel }
  NothingZone:Boolean;        { Zone exterieur d'une page ASP... }
  Option:Set of (boExplicit); { Les diffÇrentes options disponibles }
  Screen:GraphBoxRec;         { CoordonnÇe de la limite de l'Çcran }
  HScreen:Boolean;            { Mode Coco 3? }
  InKeyB:Integer;             { Valeur de ÆINKEY$Ø }
  Key:Boolean;                { Affiche les touches de fonction ÆKEYØ }
  Regs:Registers;             { Variable temporaire de registre }
  SegBas:Word;                { Segment BASIC }
  OldMode:Byte;               { Ancien mode vidÇo }
  OnError:Record
   Active:Boolean;            { Le ON ERROR GOTO est activÇ? }
   Y:Word;                    { NumÇro de la ligne Ö effectuer un branchement si une erreur se produit }
   InOnError:Boolean;         { Est-ce qu'il est dans un dans un ON ERROR? }
  End;
  MS:ImgRec;                  { Sauvegarde de l'Çcran }
  Menu:PullMnu;               { Menu local }
   { Structure des boucles: Maximum 64 }
  Boucle:Array[0..63]of Record
   Model:(BNo,BFor,BWhile,BDo);
   X,Y,X2,X3:Word;
   Data:Array[0..6]of Byte;
  End;
   { Structures des ÆGOSUBØ }
  Gosub:Array[0..63]of Record
   X,Y:Word;
  End;
  BouclePos:Byte;             { Position dans la boucle }
  GosubPos:Byte;              { Position dans le ÆGOSUBØ }
  ReadDataX,ReadDataY:Word;   { Position de lecture des ÆDATAØ }
  Instr:DataSetInMemory;      { Table des instructions }
  Fonction:DataSetInMemory;   { Table des fonctions }
  FoncStr:DataSetInMemory;    { Table des fonctions de chaine }
  ExitCode:Integer;           { Code de sortie }
  ErrLine:Word;               { NumÇro de ligne de l'erreur }
  CurData:Word;               { Position courante dans les donnÇes }
  MainSource:String;          { Source principal }
  Data:Array[0..8192]of Byte; { Variable global du BASIC }
 End;

  {Application WorkShop }
 WorkShopApp=Record
  W:Window;              { Boåte de dialogue associÇ Ö cette application }
  FileName:String;       { Nom du fichier }
  ID:Word;               { Identificateur de donnÇes }
  MinX:Byte;             { Position X minimum }
  MinY:Byte;             { Position Y minimum }
  OffsetResource:LongInt;{ Position des ressources }
  Tree:DialogTreeObject; { Arbre de structures }
  R:ResourceWindow;      { Fenetre Resource Courante }
 End;

  {Email}
 EmailApp=Record
  W:Window;              { Fenàtre de l'application }
  Pos:Byte;              { Position dans l'application 0=De:, 1=A:, 2=Titre, 3=Corps}
  EmailFrom:String;      { EnvoyÇ de}
  EmailTo:String;        { EnvoyÇ Ö}
  Title:String;          { Titre }
  TextEdit:EditorApp;    { Traitement de texte pour le corps du message }
 End;

Var
 Windows:HWins;          { Objet d'application }

{ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ}
                                 IMPLEMENTATION
{ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ}

END.