{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                                                                         Û
 ³         Malte Genesis/D‚finition de la gestion des ressources           Û
 ³                                                                         Û
 ³            dition Chantal pour Mode R‚el/IV - Version 1.1              Û
 ³                              2001/01/01                                 Û
 ³                                                                         Û
 ³          Tous droits r‚serv‚s par les Chevaliers de Malte (C)           Û
 ³                                                                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Nom du programmeur
  ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

   Sylvain Maltais


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette unit‚ comprend toutes les structures n‚cessaires … la manipulation
  des donn‚es contenue dans les ressources: Images, Base de donn‚e, Texte,
  ...
}

Unit ResTex;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                  INTERFACE
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

{$I DEF.INC}

Uses Systex;

Const
 diAutoDetect=$0000;        { Autod‚tection }
 diIconWindows=$0001;       { Ic“ne ou Curseur de Windows 3.1, 95, 98 ou NT }
 diCurWindows=diIconWindows;{ Curseur de format Windows }
 diIconOS2=$0002;           { Ic“ne du systŠme d'exploitation OS/2 Warp 3 }
 diIconGenesis=$0003;       { Ic“ne de l'ensemble Malte Genesis }
 diIconAdele=$0004;         { Ic“ne de format Malte Genesis V: AdŠle}
 diIconGeoWorks=$0005;      { Ic“ne de l'ensemble GeoWorks }
 diIconGemDesktop=$0006;    { Ic“ne de l'ensemble GEM Desktop }
 diPointerOS2=$0007;        { Pointeur d'OS/2 }
 diBitMapWindows=$0008;     { Image de format BitMap de format Windows }
 diBitMapOS2=$0009;         { Image de format BitMap de format OS/2 }
 diMacPaint=$000A;          { Image de format MacPaint }
 diGemImg=$000B;            { Image de format GEM/IMG et la filiŠre Ventura }
 diGFX=$000C;               { Image sans entˆte: 320x200 en 256 couleurs }
 diPPM=$000D;               { Image de format PPM/PGM }
 diPCX=$000E;               { Image de format PCX (PC PaintBrush) }
 diLBM=$000F;               { Image de format LBM de ®Delux Paint II¯ }
 diTGA=$0010;               { Image de format Targa }
 diTIFF=$0011;              { Image de format TIFF }
 diGIF=$0012;               { Image de format GIF Compuserve }
 diJPEG=$0013;              { Image de format de compression JPEG/JFIF }
 diWPG=$0014;               { Graphique de WordPerfect }
 diGPX=$0015;               { Image de l'ensemble Malte Genesis GPX }
 diBGX=$0016;               { Image de l'ensemble Malte Genesis BGX }
 diHex=$0017;               { Codage hexad‚cimal }
 diGatElectric=$0018;       { Plan ‚lectronique en fichier document GAT }
 diResWindows=$0019;        { Ressource de Windows (RES) }
 diExeWindows=$001A;        { Ex‚cutable de Windows (RES) }
 diCorelDraw=$001B;         { Corel Draw }
 diXBM=$001C;               { XBM de Unix et Linux, XWindow, BSD}
 diWordPerfectGraphics=$01D;{ Dessin de Word Perfect }
 diMBF=$001E;               { MonsterBookFont }
 diRLL=$001F;               { BibliothŠque d'image }
 diSCi=$0020;               { SCi (RIX?) }
 diIMI=$0021;               { Image intelligente}
 diPNG=$0022;               { Image graphique de format PNG }

  {Erreur de lecture}
 eriNone=$0000;             { Aucune erreur de lecture d'image }
 eriUnknownFormat=$2001;    { Format de fichier image inconnue }
 eriFormatNotFound=$2002;   { Le format d'image de recherche n'a pas ‚t‚ trouv‚ }
 eriFileNotFound=$2003;     { Fichier introuvable }
 eriInvalidHeader=$2004;    { Entˆte du fichier invalide pour ce format }
 eriLineTooBig=$2005;       { Ligne trop grande }
 eriOutOfMemory=$2006;      { Manque de m‚moire }
 eriImagePreceded=$2007;    { L'image n'a pas de suivant }
 eriUnExpectedEOF=$2008;    { Fin manquante }
 eriBadCodeSize=$2009;      { Mauvais code de taille }
 eriBadCode=$200A;          { Mauvais code }
 eriUserCancel=$200B;       { Annuler par l'utilisateur }
 eriIndexNotFound=$200C;    { Index introuvable! }
 eriInvalidData=$200D;      { Donn‚e invalide}
 eriInvalidSize=$200E;      { Taille invalide }
 eriCantCreate=$200F;       { Impossible de cr‚er le fichier }
 eriFormatNotSupport=$2010; { Format non support‚e }
 eriDataTooBig=$2011;       { Donn‚e trop grosse }
 eriNotCompatibleColor=$2012;{Couleur incompatible }

  {Identificateur de ressource }
 idResNone=0;        { Identificateur de ressource inconnue }
 idResImage=1;       { Identificateur de ressource image }
 idResAnimate=2;     { Identificateur de ressource d'animation }
 idResFont=3;        { Identificateur de ressource de police de caractŠres }
 idResDataBase=4;    { Identificateur de ressource de base de donn‚es }
 idResText=5;        { Identificateur de ressource texte }
 idResFile=6;        { Identificateur de ressource fichier }
 idResFileList=7;    { Identificateur de ressource liste de fichier }
 idResMusic=8;       { Identificateur de ressource musique }

  {Format des donn‚es images}
 fdiBinary=0;        { Binaire: 1 bits=2 couleurs, 2 pixels de 16 couleurs
                       sur un seul octet, 1 pixel de 256 couleurs sur un
                       seul octet. }
 fdi4Per8=1;         { 4 par 8: Un octet pour 16 couleurs, m‚canisme destin‚e
                       … certain traŒtement rapide... }
 fdiCompress=2;      { Image compress‚e, traŒtement lent mais utilise peu de
                       place en ressource m‚moire. }
 fdiLogic=3;         { Style d'image en format logique de d‚composition }

  {Index m‚diatique}
 imKeyBoard=0;       { Index associ‚e … l'image clavier }
 imDrive=1;          { Index associ‚e aux unit‚s de disques }
 imJoystick=2;       { Index associ‚e aux manettes de jeux }
 imVideo=3;          { Index associ‚e aux cartes vid‚os }
 imSystem=4;         { Index associ‚e au noyau }
 imMouse=5;          { Index associ‚e … la souris }
 imVesa=6;           { Index associ‚e aux composantes VESA }
 imDriveIcon=7;      { Index d'une unit‚ de disquette }
 imHardDiskIcon=8;   { Index d'un disque dur }
 imCDROMIcon=9;      { Index d'unit‚ de CD-ROM }

  {Types de donn‚es}
 tdNone=0;           { Aucun type }
 tdBlob=1;           { Graphique, texte,...}
 tdChar=2;           { Type caractŠre … longueur fixe (genre STRING)}
 tdDate=3;           { Information de date et d'heure }
 tdDecimal=4;
 tdDouble=5;         { Pr‚cision nombre r‚el de 1,7x10ñ308 (Double)}
 tdFloat=6;          { Nombre r‚el }
 tdInteger=7;        { Entier … 4 octets (LongInt) }
 tdNumeric=8;        { Nombre stock‚e en caractŠres }
 tdSmallInt=9;       { Entier court (Integer)}
 tdVarChar=10;       { ChaŒne de caractŠres variables (genre PChar)}
 tdWord=11;          { Naturel (0 … 65535)}
 tdByte=12;          { Naturel (0 … 255) }
 tdBoolean=13;       { Bool‚en (vrai ou faux) }
 tdDirectChar=14;    { ChaŒne de caractŠres directe sans d‚limiteur (DBase) }
 tdVarCharRS=15;     { ChaŒne de caractŠres avec terminaison RS (1Eh) }
  {Pour la base de registres uniquement }
 tdDirectory=16;     { R‚pertoire }
 tdFile=32;          { Fichier pouvant ˆtre fragment‚ }
 tdKill=229;         { Effacer }

  {M‚thode de compression}
 mcStore=0;          { Fichier emballer sans compression }

  {Requˆte SQL}
 scNone=0;
 scALTER=1;
 scBASED=2;
 scBEGIN=3;
 scCLOSE=4;
 scCOMMIT=5;
 scCONNECT=6;
 scCREATE=7;
 scDECLARE=8;
 scDELETE=9;
 scDESCRIBE=10;
 scDISCONNECT=11;
 scDROP=12;
 scEND=13;
 scEVENT=14;
 scEXECUTE=15;
 scFETCH=16;
 scGRANT=17;
 scINSERT=18;
 scOPEN=19;
 scPREPARE=20;
 scREVOKE=21;
 scROLLBACK=22;
 scSELECT=23;
 scSET=24;
 scUPDATE=25;
 scWHENEVER=26;
 scSHOW=33;

Type
  {Drapeaux de processus pendant le chargement d'image}
 FlagsProcessusImage=Set of (
  fpProgressBar,            { Barre de progression de chargement }
  fpViewImage,              { Voir l'image en mˆme temps que le chargement }
  fpViewScr,                { Voir l'image dans l'‚cran appropri‚e }
  fpNotLoadInRessource,     { Ne charger pas l'image dans une ressource }
  fpLoadOnlyTooBig,         { Ne charger dans une ressource que si l'image }
			    { est trop grande pour les diff‚rents modŠles }
 			    { d'‚crans }
  fpPreserveHeader,         { Pr‚serve l'entˆte mˆme s'il les valeurs
                              fpNotLoadInRessource et fpLoadOnlyTooBig
                              sont actives! }
  fpUserInterrupt,          { L'utilisateur peut interrompre le chargement
 			      s'il enfonce la touche ESC et qu'il confirme
			      l'annulation! }
  fpNoHeader,               { INTERNE: Pas d'entˆte de fichier d'image. Utilis‚
                              pour des ressources Windows par exemple... }
  fpAllImage                { Chargement de toutes les images (animation) }
 );

  {Entˆte de la ressource d'image}
 ImageHeaderRes=Record
  ID:Word;           { Identificateur de ressource image: Toujours idResImage=1 }
  BytesPerLine,      { Octets par ligne de pixel }
  NumXPixels,        { Largeur de l'image ne pixel }
  NumYPixels:Word;   { Hauteur de l'image en pixel }
  BitsPerPixel:Byte; { Bits par pixel }
  Format:Byte;       { Format des donn‚es: fdi???? }
  Original:Word;     { Format d'image original, le format ayant ‚t‚ trouv‚
                     { … l'origine lorsqu'il a ‚t‚ trouv‚e dans le fichier
                       ou encore si vous pr‚f‚rez: di???? }
  Index:Word;        { Son num‚ro d'index ou 0 si aucun ou le premier...}
  NumPal:Word;       { Nombres de couleur RGB dans la palette }
  Shadow:Boolean;    { Zone … ne pas effacer?}
  Descr:String[79];  { Description concernant l'image }
  MultiImage:Boolean;{ Plusieurs images pr‚sente dans la ressource? }
  {Image:Array[0..BytesPerLine*NumYPixels-1]of Byte;}
  {Palette:Array[0..NumPal-1]of RGB;}
  {Shadow:Array[0..(NumXPixels shr 3)*NumYPixels-1]of Byte;}
 End;

 ImageObjectLoader=Record
  Handle:Hdl;                 { Fichier ®Handle¯ associ‚ }
  FilePos:LongInt;            { Position de d‚part de lecture dans le fichier }
  DefaultImage:Word;          { Format par d‚faut de reconnaissance de type d'image }
  Index:Word;                 { Index de recherche }
  BitsPerPixel:Byte;          { Bits par pixel … rechercher par d‚faut }
  MaxY:Word;                  { Ligne  d'arrˆt de lecture d'image }
  Option:FlagsProcessusImage; { Option particuliŠre de lecture }
  Ressource:Byte;             { Ressource m‚moire utilis‚ }
  Image:XInf;                 { Image lu }
  Anim:^TXInf;                { Liste d'images multiple }
  NumAnim:Word;               { Nombre d'images multiple }
  SizeAnim:Word;              { Taille du tampon des ressources d'images multiple }
 End;

  {ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
  {Objet de manipulation des fichiers compress‚}
 UnpackRec=Record
  ReadBuffer:Array[0..2047]of Byte; { !!!Tampon de lecture!!! ATTENTION! Toujours en premier! }
  Source:String;                    { Fichier source }
  Target:String;                    { Fichier destination (g‚n‚rique)}
  TargetName:String;                { Fichier destination }
  Handle:Hdl;                       { Handle … utilis‚e }
  HandleTarget:Hdl;                 { Handle du fichier destinataire courant }
  FileType:(ftNone,ftArc,ftArj,ftCab,
            ftLZH{ICE},ftPAK,ftRAR,ftSWG,ftZIP,ftZOO);
  Methode:Byte;                     { M‚thode de compression (mc????) }
  PackSize:LongInt;                 { Taille compress‚e }
  UnPackSize:LongInt;               { Taille d‚compress‚e }
  FilePosFindFiles:LongInt;         { Position de recherche de fichier }
  FilePos:LongInt;                  { Position actuel dans le fichier }
  FileSize:LongInt;                 { Taille du fichier contenant les fichiers compress‚e }
  Time:LongInt;                     { Date et heure du fichier }
  Attr:Word;                        { Attribut du fichier }
  CRC:LongInt;                      { Teste de v‚rification CRC }
  SizeBuf:Word;                     { Taille du tampon de lecture }
  PosBuf:Word;                      { Position dans le tampon de lecture }
 End;

  {ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
  {Entˆte d'un fichier de base de donn‚e de l'Ensemble Malte Genesis}

 DataBaseAttribut=Set of (dsIndex,     { Index d'acc‚l‚ration de donn‚es? }
                          dsEnd,       { Index situ‚ … la fin de la base de donn‚e? }
                          dsBig,       { Index en 32-bits? }
                          dsRelative,  { Enregistrement de taille s‚quentiel }
                          dsSorted,    { Trier en ordre }
                          dsAscending, { Trier en ordre croissant }
                          dsCrypted,   { Prot‚g‚ par un cryptage }
                          dsExternData);{Donn‚es dans un fichier externe }

 DataBaseServerAttribut=Set of (dsIntel, { Donn‚es num‚rique en format Intel? }
                                dsFatDB, { Table de fichier en format base de donn‚es? }
                                dsReverse);{Table de fichier en sens inverse? }
                                         {   Pour les serveurs de base de donn‚es de taille fixe! }

 DataBaseHeader=Record
  TypeASCII:String[39];     { Variable...}
  Sign:Array[0..12]of Char; { Signature 'DataBaseMalte' pour un fichier base de donn‚es }
                            {           'ServerDbMalte' pour un serveur de base de donn‚es }
  RealName:String[80];      { Nom r‚el de la table }
  NumField:Word;            { Nombre de champs }
  Attribut:DataBaseAttribut;{ Attribut de la base de donn‚es }
  SizeTotalField:LongInt;   { Taille total de la description des champs }
  PosIndex:LongInt;         { Position de l'index }
  SizeIndex:LongInt;        { Taille de l'index }
  PosFileNameDataBaseExtern:LongInt;{ Position du nom de la base de donn‚es externe }
  OffsetFilePosExtern:LongInt;{ D‚placement dans le fichier externe de base de donn‚es }
  Reserved:Array[0..2]of Byte;{ R‚serv‚ pour usage futur }
 End;

 DataBaseServerHeader=Record
  TypeASCII:String[39];     { Variable...}
  Sign:Array[0..12]of Char; { Signature 'ServerDbMalte' pour un serveur de base de donn‚es }
  RealName:String[80];      { Nom r‚el de la table }
  Attribut:DataBaseServerAttribut;{ Attribut de la base de donn‚es }
  PosUserTable:LongInt;     { Table des utilisateurs avec mots de passe, }
                            { vaut 0 si tous le monde peut lire ou modifier }
                            { l'information }
  PosFAT:LongInt;           { Position de la table des fichiers }
  Reserved:Array[0..16]of Byte;{ Inutilis‚ pour avoir la mˆme taille que ®DataBaseHeader¯ }
 End;

 DataBaseFileEntry=Record
  StartPos:LongInt; { 0-Position physique ou se trouve la base de donn‚es rechercher }
  Size:LongInt;     { 1-Taille de cette base de donn‚es }
  Priority:Byte;    { 2-Priorit‚ requise pour l'ouverture de cette base de donn‚es }
  Attribut:Word;    { 3-Attribut fichier (compatible avec ceux du DOS) }
  DateCreate:Comp;  { 4-Date de cr‚ation }
  DateModified:Comp;{ 5-Date de derniŠre modification }
  FileName:String;  { 6-Nom de cette base de donn‚es }
 End;

 FieldDataBaseRec=Record
  PrimaryKey:Boolean;{ Cl‚ primaire?}
  Unique:Boolean;    { Unique? }
  NotNull:Boolean;   { Non-nulle? }
  TypeDef:Byte;      { td???? }
  Decimal:Byte;      { Nombre de d‚cimal aprŠs la virgule }
  Len:Word;          { Longueur du champ}
  Title:PChr;        { Titre de l'item d'enregistrement }
 End;

 TFieldRec=Array[0..499]of FieldDataBaseRec;

 DataSetOption=Set Of (dsServer);

 FieldRecDef=Record
  Num:Word;          { Nombre d'item d'enregistrement}
  Buffer:^TFieldRec; { Pointeur d'item }
 End;

  {Objet de base de donn‚es}
 PDataSet=^DataSet;
 DataSet=Record
  FileName:String;     { Nom du fichier de base de donn‚e … utiliser }
  RealName:String;     { Nom r‚el de la table }
  Handle:Hdl;          { ®Handle¯ utilis‚ pour la lecture et ‚criture du fichier}
  HandleExtern:Hdl;    { ®Handle¯ pour les donn‚es externes }
  Option:DataSetOption;{ Option particuliŠre de la base de donn‚es traiter }
  Mode:Byte;           { Lecture et/ou ‚criture (fmDef,fmRead,fmWrite,...)}
  Origin:Word;         { Base de donn‚es d'origine }
   { Fichier de base de donn‚es }
  StartPos:LongInt;    { Position de d‚part dans le fichier des donn‚es }
  StartRec:LongInt;    { Position des enregistrements dans le fichier des donn‚es }
  CurrLine:LongInt;    { Ligne d'enregistrement courante }
  CurrPos:LongInt;     { Position courante }
  FileSize:LongInt;    { Taille du fichier de base de donn‚e interne }
  SizeRec:Word;        { Taille des enregistrements }
  EndPos:LongInt;      { Position de fin des enregistrements }
   { Fichier de traitement actuelle}
  PC:PChr;             { Pointeur sur la ligne courante }
  List:^ArrayList;     { Pointeur sur la liste courante si lancer … partir de la m‚moire }
  ReadHandle:Hdl;      { Handle attribu‚ au fichier en lecture }
  ReadPos:LongInt;     { Position de lecture dans le fichier }
  ReadX:Word;          { Position de lecture dans la chaŒne de caractŠres de la ligne }
  ReadY:LongInt;       { Position de lecture dans le fichier, la ligne courante }
  ReadFileSize:LongInt;{ Taille du fichier en lecture }
   { Donn‚es divers }
  ErrCode:Word;        { Code d'erreur de traitement interne }
  FieldRec:FieldRecDef;{ D‚finition d'un enregistrement }
  Index:Record Case Byte Of
   0:(Word:^TWord);    { Pointeur sur l'index d'acc‚l‚ration 16-bits }
   1:(Long:^TLong);    { Pointeur sur l'index d'acc‚l‚ration 32-bits }
  End;
  SizeIndex:Word;      { Taille de l'index }
  Directory:PDataSet;  { Pointeur temporaire sur la table des fichiers }
  CurrPosEntryOnDir:LongInt; { Position courante dans la base de donn‚es de r‚pertoire }
   { Attribut de la base de donn‚e}
  Attribut:DataBaseAttribut;
   { Routine d'appel }
  OnStatusCompiler:Procedure(Var Q;Var Context;Line:LongInt);
  OnStatusCompilerContext:Pointer;
  OnExternCommand:Procedure(Var Q;Var Context;Const Word:String);
  OnExternCommandContext:Pointer;
 End;

  {Objet de base de donn‚es directe en m‚moire }
 DataSetInMemory=Record
  FieldRec:FieldRecDef;{ D‚finition d'un enregistrement }
  NumRec:Word;         { Nombre d'enregistrement }
  SizeTable:Word;      { Taille de la table en octets }
  Table:^TByte;        { Table contenant les enregistrement }
  SizeIndex:Word;      { Taille de l'index en octets }
  Index:^TWord;        { Pointeur sur l'index }
  Pos:Word;            { Position courante }
  CurrRec:Record Case Byte of { Pointeur sur l'enregistrement courant }
   0:(Ptr:Pointer);    { Format Pointeur sans type }
   1:(Byte:^Byte);     { Format octet }
   2:(Char:^Char);     { Format d'un caractŠre }
   3:(Word:^Word);     { Format mot }
   4:(SmallInt:^Integer);{Format entier }
   5:(Str:^String);    { Format chaŒne de caractŠres }
  End;
 End;

 WallPaperMode=Set of (wpJuxtap,wpCenter,wpSprite);
 WorkImage=Set of (wiCopy2Target,wiPut2Screen);
 SearchOption=Set of (soNotStrict,soNoCaseSensitive,soCharCompare);

 DBListBox=Record
  W:Window;
  P,MP:Word;
  Y:Byte;
  BufChr:String;
  ColumnNum:Byte;
  DB:DataSet;
  ShowCurrLine:Procedure(Var Q;Var Context);
  Context:Pointer;
 End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                 IMPLEMENTATION
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

END.