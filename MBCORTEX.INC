{\Source\Chantal\MBCortex.Inc: Universel}

{$I DEF.INC}

Uses Systex,Isatex,Dialex,TMDials,ToolTime,ToolSoun,ResTex;

Const
 {$IFDEF FullVersion}
  NamePrg='MonsterBook';              { Nom de l'application }
  MB_INI='MB.INI';                    { Nom du fichier d'initialisation }
  MB_CFG='MB.CFG';                    { Nom du fichier de configuration }
  BUREAU_INI='BUREAU.INI';            { Nom du fichier de bureau }
 {$ENDIF}
 {$IFDEF BureauVersion}
  NamePrg='MonsterBook: Bureautique'; { Nom de l'application }
  MB_INI='MBB.INI';                   { Nom du fichier d'initialisation }
  MB_CFG='MBB.CFG';                   { Nom du fichier de configuration }
  BUREAU_INI='BUREAUB.INI';           { Nom du fichier de bureau }
 {$ENDIF}
 {$IFDEF CAOVersion}
  NamePrg='MonsterBook: CAO';         { Nom de l'application }
  MB_INI='MBC.INI';                   { Nom du fichier d'initialisation }
  MB_CFG='MBC.CFG';                   { Nom du fichier de configuration }
  BUREAU_INI='BUREAUC.INI';           { Nom du fichier de bureau }
 {$ENDIF}
 {$IFDEF DeveloppeurVersion}
  NamePrg='MonsterBook: DÇveloppeur'; { Nom de l'application }
  MB_INI='MBD.INI';                   { Nom du fichier d'initialisation }
  MB_CFG='MBD.CFG';                   { Nom du fichier de configuration }
  BUREAU_INI='BUREAUD.INI';           { Nom du fichier de bureau }
 {$ENDIF}
 {$IFDEF EducativeVersion}
  NamePrg='MonsterBook: Educatif';    { Nom de l'application }
  MB_INI='MBE.INI';                   { Nom du fichier d'initialisation }
  MB_CFG='MBE.CFG';                   { Nom du fichier de configuration }
  BUREAU_INI='BUREAUE.INI';           { Nom du fichier de bureau }
 {$ENDIF}
 {$IFDEF GamesVersion}
  NamePrg='MonsterBook: Jeux';        { Nom de l'application }
  MB_INI='MBG.INI';                   { Nom du fichier d'initialisation }
  MB_CFG='MBG.CFG';                   { Nom du fichier de configuration }
  BUREAU_INI='BUREAUG.INI';           { Nom du fichier de bureau }
 {$ENDIF}
 VerPrg='1.7.9';          { NumÇro de version }

  {Mode d'environnement}
 emNone=0;              { Aucun prÇdÇfinie }
 emWin31=1;             { Mode Windows 3.1 }
 emWin9X=2;             { Mode Windows 9X }
 emOS2Warp3=3;          { Mode OS/2 Warp 3 }
 emOS2Warp4=4;          { Mode OS/2 Warp 4 }
 emDESQview=5;          { Mode DESQview }

  {Barre d'Çtat de mÇmoire}
 mmNumber=0;                 { NumÇrique }
 mmProgressBar=1;            { Barre de progression }
 mmAutoDetect=$FF;           { Auto-dÇtection }
 MemoryModel:Byte=mmAutoDetect;

  { Code de reconnaissance des diffÇrentes fenàtres d'application }
 wnEmpty=0;            { Ce n'est pas une fenàtre }
 wnMin=1;              { Code de fenàtre minimum }
 wnMx=34;              { Code de la derniäre fenàtre (maximum) }
 wnMI=wnMx+25;         { Valeur maximal d'icìne }

 icnSetup=wnMx+1;      { Icìne de panneau de configuration}
 icnNewDoc=wnMx+2;     { Icìne d'un nouveau document}
 icnFind=wnMx+3;       { Icìne de recherche }
 icnFolder=wnMx+4;     { Icìne de dossier }
 icnParam=wnMx+5;      { Icìne de paramätres }
 icnHelp=wnMx+6;       { Icìne d'aide }
 icnExec=wnMx+7;       { Icìne d'exÇcution }
 icnExit=wnMx+8;       { Icìne de sortie }
 icnExplorer=wnMx+9;   { Icìne de l'explorateur }
 icnControl=wnMx+10;   { Icìne de panneau de contrìle}
 icnPrinter=wnMx+11;   { Icìne d'imprimante }
 icnBesch=wnMx+12;     { Icìne de Bescherelle}
 icnStart=wnMx+13;     { Icìne de DÇmarrer}
 icnCleanMgr=wnMx+14;  { Icìne de mÇnagäre de disque}
 icnElectronic=wnMx+15;{ Icìne d'Çlectronique}
 icnDesktop=wnMx+16;   { Icìne du bureau}
 icnSound=wnMx+17;     { Icìne de console de son (volume)}
 icnCountry=wnMx+18;   { Drapeau du pays courant}

  { Code de commande de l'application }
 cmdNone=0;                     {0: Commande nulle}
 mbFileNew=$F001;               {1: Nouveau fichier}
 cmdNewEdt=1;                   {1: Nouveau fichier}
 mbFileOpen=$F002;              {2: Ouverture d'un fichier}
 cmdOpenEdt=2;                  {2: Ouverture d'un fichier}
 mbNewGat=$F003;                {3: Nouveau document de format "GAT"}
 cmdNewGatt=3;                  {3: Nouveau document de format "GAT"}
 mbOpenGat=$F004;               {4: Ouverture d'un document de format "GAT"}
 cmdOpenGatt=4;                 {4: Ouverture d'un document de format "GAT"}
 mbHexView=$F005;               {5: Regarde/êditeur hexadÇcimal}
 cmdHexEdt=5;                   {5: Regarde/êditeur hexadÇcimal}
 mbViewAscii=$F006;             {6: Regarde ASCII}
 cmdOpenView=6;                 {6: Regarde ASCII}
 mbFileNewLotus=$F007;          {7: Nouveau fichier tableur}
 cmdNewSuperCalc=7;             {7: Nouveau fichier tableur}
 mbFileOpenLotus=$F008;         {8: Ouverture d'un fichier tableur}
 cmdOpenSuperCalc=8;            {8: Ouverture d'un fichier tableur}
 mbFileSave=$F009;              {9: Sauvegarde du fichier courant dans la fenàtre}
 cmdSave=9;                     {9: Sauvegarde du fichier courant dans la fenàtre}
 mbFileSaveAs=$F00A;            {10: Sauvegarde sous un nom particulier}
 cmdSaveAs=$A;                  {10: Sauvegarde sous un nom particulier}
 mbFileCopy=$F00B;              {11: Copie un fichier}
 cmdCpyFiles=$B;                {11: Copie un fichier}
 mbFileMove=$F00C;              {12: DÇplacement d'un fichier}
 cmdMoveFiles=$C;               {12: DÇplacement d'un fichier}
 mbFileDel=$F00D;               {13: Efface un fichier}
 cmdDelFile=$D;                 {13: Efface un fichier}
 mbFileSaveAll=$F00E;           {14: Sauvegarde tous les fichiers}
 mbFileMkDir=$F00F;             {15: CrÇation d'un nouveau rÇpertoire}
 cmdMkDir=$F;                   {15: CrÇation d'un nouveau rÇpertoire}
 mbFileChDir=$F010;             {16: Change de rÇpertoire courant}
 cmdChDir=$10;                  {16: Change de rÇpertoire courant}
 mbFilePrint=$F011;             {17: Impression du fichier}
 cmdPrint=$11;                  {17: Impression du fichier}
 mbFileDosShell=$F012;          {18: Passage Ö l'interprÇteur DOS}
 cmdShell=$12;                  {18: Passage Ö l'interprÇteur DOS}
 mbFileExit=$F013;              {19: Quitter l'application}
 cmdExit=$13;                   {19: Quitter l'application}
 mbDrawNew=$F014;               {20: Nouveau dessin}
 cmdNewDrw=$14;                 {20: Nouveau dessin}
 mbDrawOpen=$F015;              {21: Ouverture d'un fichier dessin}
 cmdOpenDrw=$15;                {21: Ouverture d'un ficheir dessin}
 mbDrawNewButton=$F016;         {22: Nouveau icìne/button}
 cmdNewButt=$16;                {22: Nouveau icìne/button}
 mbDrawOpenButton=$F017;        {23: Ouverture d'un fichier icìne/button}
 cmdOpenButtEdt=$17;            {23: Ouverture d'un fichier icìne/button}
 mbDrawNewPageButton=$F018;     {24: Nouvelle page d'icìne/button}
 cmdDrwNewPgButt=$18;           {24: Nouvelle page d'icìne/button}
 mbDrawChangePageButton=$F019;  {25: Change la page d'icìne/button}
 cmdDrwChgPgButt=$19;           {25: Change la page d'icìne/button}
 mbEditUndo=$F01A;              {26: Reviens en arriäre dans l'Çdition}
 mbEditCut=$F01B;               {27: DÇcouper un bloc}
 mbEditCopy=$F01C;              {28: Copie un bloc}
 cmdCopyClipBoard=$1C;          {28: Copie un bloc}
 mbEditPaste=$F01D;             {29: Coller un bloc}
 cmdPasteClipBoard=$1D;         {29: Coller un bloc}
 mbEditClear=$F01E;             {30: Efface le bloc}
 mbEditShowClipboard=$F01F;     {31: Voir le Clipboard}
 mbEditMode=$F020;              {32: Mode d'Çdition}
 cmdEditMode=$20;               {32: Mode d'Çdition}
 mbEditCharType=$F021;          {33: Choisir le modäle caractäres}
 cmdChrType=$21;                {33: Choisir le modäle caractäres}
 mbEditDraw=$F022;              {34: Mode dessin}
 cmdDrawMode=$22;               {34: Mode dessin}
 mbEditXChgPg=$F023;            {35: êchange des pages de documents}
 cmdEditXchgPg=$23;             {35: êchange des pages de documents}
 mbEditLine=$F024;              {36: Mode Çdition en ligne}
 cmdLnMode=$24;                 {36: Mode Çdition en ligne}
 mbEditBox=$F025;               {37: Mode Çdition en boåte}
 cmdBoxMode=$25;                {37: Mode Çdition en boåte}
 mbEditCircle=$F026;            {38: Mode Çdition en cercle}
 cmdCircleMode=$26;             {38: Mode Çdition en cercle}
 mbEditPaint=$F027;             {39: Mode Çdition en peinture}
 cmdPaintMode=$27;              {39: Mode Çdition en peinture}
 mbEditTrace=$F028;             {40: Mode Çdition en traáage}
 cmdTraceMode=$28;              {40: Mode Çdition en traáage}
 mbEditText=$F029;              {41: Mode Çdition en texte}
 cmdTextMode=$29;               {41: Mode Çdition en texte}
 mbEditFill=$F02A;              {42: Mode Çdition plein}
 mbEditDel=$F02B;               {43: êdition efface}
 mbEditBS=$F02C;                {44: êdition efface en arriäre}
 mbSearchFind=$F02D;            {45: Recherche}
 cmdSearch=$2D;                 {45: Recherche}
 mbSearchReplace=$F02E;         {46: Recherche et remplace}
 cmdReplace=$2E;                {46: Recherche et remplace}
 mbSearchAgain=$F02F;           {47: Recherche encore}
 cmdSearchAgain=$2F;            {47: Recherche encore}
 mbSearchGotoLine=$F030;        {48: Recherche un numÇro de ligne}
 cmdGotoLn=$30;                 {48: Recherche un numÇro de ligne}
 mbSearchGotoRow=$F031;         {49: Recherche une colonne}
 mbSearchGotoHome=$F032;        {50: Recherche le dÇbut}
 cmdHomeTxt=$32;                {50: Recherche le dÇbut}
 mbSearchGotoEnd=$F033;         {51: Recherche la fin}
 cmdEndTxt=$33;                 {51: Recherche la fin}
 mbTri=$F034;                   {52: Effectuer une tri alphabÇtique}
 mbRun=$F035;                   {53: ExÇcuter}
 cmdRun=$35;                    {53: ExÇcuter}
 mbRunParameters=$F036;         {54: Paramätres d'exÇcution}
 mbCompile=$F037;               {55: Compile}
 cmdCompile=$37;                {55: Compile}
 mbCompileConv=$F038;           {56: Conversion}
 mbCompileCompress=$F039;       {57: Compression}
 cmdCompress=$39;               {57: Compression}
 mbCompileMake=$F03A;           {58: Fabrication}
 mbCompileBuilt=$F03B;          {59: Construction compläte}
 mbCompileInfo=$F03C;           {60: Information de compilation}
 mbOptionApplication=$F03D;     {61: Option d'application}
 mbOptionCompiler=$F03E;        {62: Option de compilateur}
 mbOptionMemorySize=$F03F;      {63: Option de mÇmoire/dimension}
 cmdSetMarge=$3F;               {63: Option de mÇmoire/dimension}
 mbOptionLink=$F040;            {64: Option de lien}
 mbOptionDebug=$F041;           {65: Option de dÇboguage}
 mbOptionDirectory=$F042;       {66: Option de rÇpertoire}
 cmdSetDirSetup=$42;            {66: Option de rÇpertoire}
 mbOptionPrinters=$F043;        {67: Option d'impression}
 cmdPrnSetup=$43;               {67: Option d'impression}
 mbOptionVideo=$F044;           {68: SÇlection d'un nouveau mode vidÇo}
 cmdSetVideoMode=$44;           {68: SÇlection d'un nouveau mode vidÇo}
 mbOptionFont=$F045;            {69: Option de police de caractäres}
 mbOptionVideoEnv=$F046;        {70: Option d'environnement vidÇo}
 cmdVideoEnvironnement=$46;     {70: Option d'environnement vidÇo}
 mbOptionScrnSaver=$F047;       {71: Option d'Çconomiseur d'Çcran}
 mbOptionEnvironment=$F048;     {72: Option d'environnement}
 mbOptionTermWelcome=$F049;     {73: Option de prÇsentation de terminal}
 cmdTermWelcome=$49;            {73: Option de prÇsentation de terminal}
 mbOptionTermUserList=$F04A;    {74: Option de liste des utilisateurs du terminal}
 mbOptionBoard=$F04B;           {75: Option tableau}
 cmdBoard=$4B;                  {75: Option tableau}
 mbOptionMenu=$F04C;            {76: êdition du menu d'application}
 cmdEditMnu=$4C;                {76: êdition du menu d'application}
 mbOptionPassWord=$F04D;        {77: Nouveau/modifiaction mots de passe}
 mbWindowMenu=$F04E;            {78: Lancer le menu d'application}
 cmdLoader=$4E;                 {78: Lancer le menu d'application}
 mbWindowFileManager=$F04F;     {79: Fenàtre de gestionnaire de fichier}
 cmdNewFileManagers=$4F;        {79: Fenàtre de gestionnaire de fichier}
 mbWindowPrompt=$F050;          {80: Fenàtre de prompt DOS}
 cmdNewMDos=$50;                {80: Fenàtre de prompt DOS}
 mbWindowUnix=$F051;            {81: Fenàtre de prompt UNIX}
 cmdNewUnix=$51;                {81: Fenàtre de prompt UNIX}
 mbWindowWatch=$F052;           {82: Fenàtre de surveillance}
 cmdOpenWatch=$52;              {82: Fenàtre de surveillance}
 mbWindowTerm=$F053;            {83: Fenàtre de terminal}
 cmdNewTerm=$53;                {83: Fenàtre de terminal}
 mbWindowOutput=$F054;          {84: êcran de sortie}
 cmdOutput=$54;                 {84: êcran de sortie}
 mbWindowTile=$F055;            {85: Fenàtre en "Tile"}
 mbWindowCascade=$F056;         {86: Fenàtre en "Cascade"}
 mbWindowCloseAll=$F057;        {87: Fermeture de toutes les fenàtres}
 cmdCloseAllWn=$57;             {87: Fermeture de toutes les fenàtres}
 mbWindowRefreshDisplay=$F058;  {88: RÇactualisation des fenàtres}
 cmdRefreshWn=$58;              {88: RÇactualisation des fenàtres}
 mbWindowSizeMove=$F059;        {89: Changer la taille d'une fenàtre}
 mbWindowZoom=$F05A;            {90: Fenàtre pleine Çcran}
 cmdZoom=$5A;                   {90: Fenàtre pleine Çcran}
 mbWindowNext=$F05B;            {91: Passe Ö la fenàtre suivante}
 cmdNextWn=$5B;                 {91: Passe Ö la fenàtre suivante}
 mbWindowPrevious=$F05C;        {92: Passe Ö la fenàtre prÇcÇdente}
 cmdPreviousWn=$5C;             {92: Passe Ö la fenàtre prÇcÇdente}
 mbWindowClose=$F05D;           {93: Fermeture de la fenàtre courante}
 cmdCloseWn=$5D;                {93: Fermeture de la fenàtre courante}
 mbWindowList=$F05E;            {94: Liste des fenàtres ouvertes}
 cmdLstWn=$5E;                  {94: Liste des fenàtres ouvertes}
 mbAbout=$F05F;                 {95: A Propos}
 cmdAbout=$5F;                  {95: A Propos}
 mbInfoCountry=$F060;           {96: Information sur le pays}
 mbInfoSomary=$F061;            {97: Information sommaire}
 cmdSomaryInfo=$61;             {97: Information sommaire}
 mbInfoSomaryVideoPrimary=$F062;{98: Information sommaire vidÇo primaire}
 cmdVidInfo=$62;                {98: Information sommaire vidÇo primaire}
 mbInfoSomaryVideoSecond=$F063; {99: Information sommaire vidÇo secondaire}
 mbInfoFont=$F064;              {100: Information sur la police de caractäres}
 mbInfoMem=$F065;               {101: Information sur la mÇmoire}
 cmdInfoMem=$65;                {101: Information sur la mÇmoire}
 mbInfoMCB=$F066;               {102: Information sur les blocs de mÇmoires}
 cmdInfoMCB=$66;                {102: Information sur les blocs de mÇmoires}
 mbInfoDataCmos=$F067;          {103: Information sur les donnÇes CMOS}
 cmdCmosInfo=$67;               {103: Information sur les donnÇes CMOS}
 mbModemDoctor=$F068;           {104: Information sur le modem}
 cmdModemDoctor=$68;            {104: Information sur le modem}
 mbInfoTermDownload=$F069;      {105}
 cmdViewDownload=$69;           {105}
 mbInfoGat=$F06A;               {106}
 mbCmdHostMode=$F06B;           {107}
 cmdHostMode=$6B;               {107}
 mbExecMacro=$F06C;             {108}
 cmdExecMacro=$6C;              {108}
 mbOpenMacro=$F06D;             {109}
 cmdOpenMacro=$6D;              {109}
 mbClrSpc=$F06E;                {110}
 cmdTxtDelSpc=$6E;              {110}
 mbClrLn=$F06F;                 {111}
 cmdDelCurrLn=$6F;              {111}
 mbCenterTxt=$F070;             {112}
 cmdCenterTxt=$70;              {112}
 mbDblWd=$F071;                 {113}
 cmdTxtDblWord=$71;             {113}
 cmdPlayPause=$71;              {113:Joueur de CD:Jouer/Pause}
 mbBoldWd=$F072;                {114}
 cmdTxtBoldWord=$72;            {114}
 cmdStop=$72;                   {114:Joueur de CD:Arràter}
 mbUnderLnWd=$F073;             {115:Editeur}
 cmdTxtUnderlnWord=$73;         {115:Editeur}
 mbInverseBoard=$F073;          {115:Gestionnaire de fichier}
 cmdInverseBoard=$73;           {115:Gestionnaire de fichier}
 mbInvWd=$F074;                 {116:Editeur}
 cmdTxtInverseWord=$74;         {116:Editeur}
 mbOldOtherBoard=$F074;         {116:Gestionnaire de fichier}
 cmdOldOtherBoard=$74;          {116:Gestionnaire de fichier}
 mbAutopsy=$F075;               {117}
 mbHlpTopic=$F076;              {118}
 cmdHelp=$76;                   {118}
 mbHlpKey=$F077;                {119}
 mbOpenAsm=$F078;               {120}
 cmdOpenAsm=$78;                {120}
 mbOpenBas=$F079;               {121:Ouvre un fichier Basic}
 cmdOpenBas=$79;                {121}
 mbOpenC=$F07A;                 {122}
 cmdOpenC=$7A;                  {122}
 mbOpenEuphoria=$F07B;          {123}
 cmdOpenEuphoria=$7B;           {123}
 mbOpenFortran=$F07C;           {124}
 cmdOpenFortran=$7C;            {124}
 mbOpenIni=$F07D;               {125}
 mbOpenPas=$F07E;               {126}
 cmdOpenPas=$7E;                {126}
 mbOpenRC=$F07F;                {127}
 cmdOpenRC=$7F;                 {127}
 mbTermMainMenu=$F080;          {128}
 cmdEditMainMenu=$80;           {128}
 mbTermFileMenu=$F081;          {129}
 cmdEditFileMenu=$81;           {129}
 cmdNewDial=$82;                {130}
 cmdOpenAC=$83;                 {131}
 cmdOpenBasAppleII=$84;         {132}
 cmdOpenBasCK64=$85;            {133}
 cmdOpenBasCoco3=$86;           {134}
 mbOriginateMode=$F087;         {135}
 cmdOriginateMode=$87;          {135}
 cmdOpenCobol=$88;              {136}
 cmdOpenMod=$89;                {137}
 cmdOpenDataBase=$8A;           {138: Ouverture d'une base de donnÇes }
 mbFiltre=$F08B;                {139}
 cmdFiltre=$8B;                 {139}
 mbSearchVerb=$F08C;            {140}
 cmdSearchVerb=$8C;             {140}
 mbPlayerCD=$F08D;              {141: Lecteur de compacteur disque}
 cmdPlayerCD=$8D;               {141: Lecteur de compacteur disque}
 mbCorrecteur=$F08E;            {142: Correcteur d'orthographe}
 cmdCorrecteur=$8E;             {142: Correcteur d'orthographe}
 mbPasteOS2BlocFile=$F08F;      {143: Colle un morceau de fichier d'OS/2}
 cmdPasteOS2BlocFile=$8F;       {143: Colle un morceau de fichier d'OS/2}
 mbLookLog=$F090;               {144: Regarde le journal de bord}
 cmdLookLog=$90;                {144: Regarde le journal de bord}
 cmdPartition=$91;              {145: Regarde les partitions }
 mbPartition=$F091;             {145: Regarde les partitions }
 cmdSetClock=$92;               {146: Fixe l'heure}
 mbSetClock=$F092;              {146: Fixe l'heure}
 cmdFullScrn=$93;               {147: Pleine Çcran}
 mbFullScrn=$F093;              {147: Pleine Çcran}
 cmdConversion=$94;             {148: Conversion formule}
 mbConversion=$F094;            {148: Conversion formule}
 cmdProgMan=$95;                {149: Gestionnaire de programmes }
 mbProgMan=$F095;               {149: Gestionnaire de programmes }
 cmdCalendar=$96;               {150: Calendrier}
 mbCalendar=$F096;              {150: Calendrier}
 cmdImageTitle=$97;             {151: SÇlectionne l'image de la barre titre }
 mbImageTitle=$F097;            {151: SÇlectionne l'image de la barre titre }
 cmdWallPaper=$98;              {152: Papier paint }
 mbWallPaper=$F098;             {152: Papier paint }
 cmdInsertImage=$99;            {153: Insertion d'une image }
 mbInsertImage=$F099;           {153: Insertion d'une image }
 cmdAssign=$9A;                 {154}
 cmdAwk=$9B;                    {155}
 cmdGrep=$9C;                   {156}
 mbExec=$F09D;                  {157}
 cmdExec=$9D;                   {157}
 cmdJoinDisk=$9E;               {158}
 cmdSQLCommand=$9F;             {159: Commande SQL }
 cmdChDisk=$A0;                 {160}
 cmdChDisk2=$A1;                {161}
 cmdDiskDoctor=$A2;             {162}
 mbHardDiskPark=$F0A3;          {163}
 cmdHardDiskPark=$A3;           {163}
 cmdViewEdtDisk=$A4;            {164}
 mbHexViewEdtDisk=$F0A5;        {165}
 cmdHexViewEdtDisk=$A5;         {165}
 mbFormatDisk=$F0A6;            {166}
 cmdFormatDisk=$A6;             {166}
 cmdDiskOption=$A7;             {167}
 cmdDoctorVirus=$A8;            {168}
 cmdConv2AC=$A9;                {169}
 cmdConv2Bas=$AA;               {170}
 cmdInverseWildCard=$AB;        {171: Gestionnaire de fichiers: Inverse SÇlection *}
 cmdUnSelectWildCard=$AC;       {172: Gestionnaire de fichiers: DeÇlection -}
 cmdSelectWildCard=$AD;         {173: Gestionnaire de fichiers: SÇlection +}
 cmdConv2Pas=$AE;               {174}
 cmdConv2RC=$AF;                {175}
 mbTxtItalicWord=$F0B0;         {176}
 cmdTxtItalicWord=$B0;          {176}
 cmdTxtDelWord=$B1;             {177}
 cmdGlobalDraw=$B2;             {178: Global Draw}
 cmdTxtPgUp=$B3;                {179}
 cmdDelCurrCol=$B4;             {180}
 cmdDelCurrMatrix=$B5;          {181}
 cmdInsCurrCol=$B6;             {182}
 cmdInsCurrLn=$B7;              {183}
 cmdInsCurrMatrix=$B8;          {184}
 cmdTxtBold=$B9;                {185}
 cmdTxtDbl=$BA;                 {186}
 cmdTxtItalic=$BB;              {187}
 cmdTxtInverse=$BC;             {188}
 cmdTxtUnderln=$BD;             {189}
 cmdChgColor=$BE;               {190}
 cmdPlayMod=$BF;                {191}
 cmdStopPlayMod=$C0;            {192}
 cmdInternalInfo=$C1;           {193}
 mbInfoDiskLogic=$F0C2;         {194}
 cmdDiskInfo=$C2;               {194}
 cmdCloseAllWnSaved=$C3;        {195}
 cmdPgUp=$C4;                   {196}
 cmdPgDn=$C5;                   {197}
 cmdLeft=$C6;                   {198}
 cmdRight=$C7;                  {199}
 cmdUp=$C8;                     {200}
 cmd2Up=$C9;                    {201}
 cmdDn=$CA;                     {202}
 mbInfoSoundCard=$F0CB;         {203}
 cmdInfoSoundCard=$CB;          {203}
 cmdDoctorSys=$CC;              {204}
 cmdCurrListFiles=$CD;          {205}
 mbBescherelle=$F0CE;           {206}
 mbFilePrnDir=$F0CF;            {207}
 mbLabel=$F0D0;                 {208}
 cmdLabel=$D0;                  {208}
 cmdHomeBlock=$D1;              {209}
 cmdEndBlock=$D2;               {210}
 cmdCopyBlock=$D3;              {211}
 cmdMoveBlock=$D4;              {212}
 mbEditWriteBlock=$F0D5;        {213}
 cmdWriteBlock=$D5;             {213}
 mbEditReadOnly=$F0D6;          {214:Editeur}
 cmdEditReadOnly=$D6;           {214:Editeur}
 mbFMReread=$F0D6;              {214:Gestionnaire de fichier}
 cmdFMReread=$D6;               {214:Gestionnaire de fichier}
 mbOptionSystems=$F0D7;         {215}
 mbGotoPg=$F0D8;                {216}
 cmdGotoPg=$D8;                 {216}
 mbTxtExposantWord=$F0D9;       {217}
 cmdTxtExposantWord=$D9;        {217}
 mbOptionMouse=$F0DA;           {218}
 mbInsertFile=$F0DB;            {219}
 cmdInsertFile=$DB;             {219}
 mbOptionEditor=$F0DC;          {220}
 cmdOptionEditor=$DC;           {220}
 mbTxtNormalWord=$F0DD;         {221}
 cmdTxtNormalWord=$DD;          {221}
 cmdTetrisLevel=$DD;            {221:Tetris - Niveau de jeux}
 mbOpenFileAtCursor=$F0DE;      {222}
 cmdOpenFileAtCursor=$DE;       {222}
 mbFileSetAttr=$F0DF;           {223}
 cmdFileSetAttr=$DF;            {223}
 cmdMagnify=$DF;                {223: êditeur de dessin: Mode Magnifique }
 mbAnswerMode=$F0E0;            {224}
 cmdAnswerMode=$E0;             {224}
 mbHangUp=$F0E1;                {225}
 cmdHangUp=$E1;                 {225}
 mbUpload=$F0E2;                {226}
 cmdUpload=$E2;                 {226: Terminal: Envoye de fichier }
 mbDownload=$F0E3;              {227}
 cmdDownload=$E3;               {227}
 mbSetupJoystick=$F0E4;         {228}
 cmdSetupJoystick=$E4;          {228}
 mbCloseAllExit=$F0E5;          {229}
 cmdCloseAllExit=$E5;           {229}
 mbOpenDebug=$F0E6;             {230}
 cmdOpenDebug=$E6;              {230}
 mbClearPrinter=$F0E7;          {231}
 cmdClearPrinter=$E7;           {231}
 mbDelSel=$F0E8;                {232}
 cmdDelSel=$E8;                 {232}
 mbCpySel=$F0E9;                {233}
 cmdCpySel=$E9;                 {233}
 mbAgenda=$F0EA;                {234: Demande l'agenda }
 cmdAgenda=$EA;                 {234: Demande l'agenda }
 mbMakeCadre=$F0EB;             {235: Traåtement de texte: CrÇer un cadre}
 cmdMakeCadre=$EB;              {235: Traåtement de texte: CrÇer un cadre}
 mbSetupSourcer=$F0EC;          {236}
 cmdSetupSourcer=$EC;           {236}
 mbSetupKeyboard=$F0ED;         {237}
 cmdSetupKeyboard=$ED;          {237}
 mbInfoJoystick=$F0EE;          {238}
 cmdInfoJoystick=$EE;           {238}
 mbInfoKeyboard=$F0EF;          {239}
 cmdInfoKeyboard=$EF;           {239}
 mbNewFont=$F0F0;               {240}
 cmdNewFont=$F0;                {240}
 mbOpenFont=$F0F1;              {241}
 cmdOpenFont=$F1;               {241}
 mbInfoMouse=$F0F2;             {242}
 cmdInfoMouse=$F2;              {242}
 mbRunScrnSaver=$F0F3;          {243}
 cmdRunScrnSaver=$F3;           {243}
 mbOptionSecurity=$F0F4;        {244}
 cmdOptionSecurity=$F4;         {244}
 mbNewElectric=$F0F5;           {245}
 cmdNewElectric=$F5;            {245}
 mbOpenElectric=$F0F6;          {246}
 cmdOpenElectric=$F6;           {246}
 mbNewDFD=$F0F7;                {247}
 cmdNewDFD=$F7;                 {247}
 mbEdtSetMtx=$F0F8;             {248}
 cmdEdtSetMtx=$F8;              {248}
 mbOptionSetPalette=$F0F9;      {249}
 cmdOptionSetPalette=$F9;       {249}
 mbNewTechDraw=$F0FA;           {250}
 cmdNewTechDraw=$FA;            {250}
 mbSetSonVolume=$F0FB;          {251}
 cmdSetSonVolume=$FB;           {251}
 mbSetEquilizer=$F0FC;          {252}
 cmdSetEquilizer=$FC;           {252}
 mbCleanDisk=$F0FD;             {253}
 cmdCleanDisk=$FD;              {253}
 mbSearchProc=$F0FE;            {254}
 cmdSearchProc=$FE;             {254}
 mbOpenTechDraw=$F0FF;          {255}
 cmdOpenTechDraw=$FF;           {255}
 cmdChangeCasse=$100;           {256: Edition: Changer la casse... }
 cmdLineHori=$101;              {257: Edition: Insertion d'une ligne horizontal }
 cmdSaut=$102;                  {258: Edition: Saut de page, de ligne,...}
 cmdOptionBasic=$103;           {259: Option: BASIC }
 cmdOptionDataBase=$104;        {260: Option: Configuration de la base de donnÇes }
 cmdOptionCompress=$105;        {261: Option: Mode de compression supportÇ }
 cmdSetupCountry=$106;          {262: Change le pays courant}
 cmdPeriphericManager=$107;     {263: Gestionnaire de pÇriphÇrique}
 cmdPromptDRDOS=$108;           {264: Prompt DR-DOS }
 cmdPromptMSDOS=$109;           {265: Prompt MS-DOS }
 cmdPromptNDOS=$10A;            {266: Prompt 4DOS/NDOS }
 cmdPromptOS2=$10B;             {267: Prompt OS/2 }
 cmdPromptVAX=$10C;             {268: Prompt VAX/Alpha }
 cmdPromptWindows9X=$10D;       {269: Prompt Windows 9X }
 cmdNewDataBase=$10E;           {270: Nouvelle base de donnÇes }
 cmdNewBasic=$10F;              {271: Ouvre un fichier Basic}
 cmdConfigJoystick=$110;        {272: Configuration de la manette de jeux}
 cmdConfigModem=$111;           {273: Configuration du modem}
 cmdExplorerDB=$113;            {274: Explorateur de Base de donnÇes}
 cmdIdentification=$114;        {275: Fiche d'Identification GÇnÇral }
 cmdCopyDiskToFile=$115;        {276: Copie un disque dans un fichier }
 cmdMAPDisk=$116;               {277: Carte du disque}
 cmdDiskCopy=$117;              {278: Copie disque}
 cmdOpenWorkShop=$118;          {279: WorkShop}
 cmdAtlas=$119;                 {280: Atlas GÇographique }
 cmdMax=$119;                   {êgale Ö la derniäre commande}
 mbMax=$F000+cmdMax;            {êgale Ö la derniäre commande}

  {Index d'aide de l'application ÆMonsterBookØ}
 hisKey=32;hieKey=hisKey;             { Aide sur les combinaisons de touche }
 hisGlobal=$FFFF;hieGlobal=hisGlobal; { Aide Globale }
 hisPC=14;hiePC=hisPC;                { Calculatrice programmable }
 hisHexView=16;hieHexView=hisHexView; { Regarde/êdite HexadÇcimal }

 ModePH:Boolean=False; { Faux pour ÆMonsterBookØ,Vrai pour ÆPowerHackenØ.
                         Le ÆPowerHackenØ est spÇcialisÇ pour le crackage
                         des   applications,    programmes   ou   systäme
                         d'exploitation. Son alias est PH, ceci veut dire
                         en chimie le taux d'aciditÇ de l'eau.}

  { Commande par dÇfaut supportÇ màme s'il n'y a pas de fenàtre ouverte }
 cmdDefault:Set of Byte=[
  cmdNone,              { Commande nulle }
  cmdNewButt,           { Ouvrir un Icon }
  cmdNewDrw,            { Nouvelle Icon }
  cmdNewEdt,            { Nouveau texte ASCII DOS }
  cmdNewFileManagers,   { Nouvelle fenàtre de gestionnaire de fichier }
  cmdNewGatt,           { Nouveau document (.GAT) }
  cmdNewMDos,           { Ouvre une fenàtre de prompt style DOS }
  cmdNewSuperCalc,      { Nouveau chiffrier Çlectronique }
  cmdNewTerm,           { Nouvelle fenàtre de terminal de communication }
  cmdNewUnix,           { Ouvre une fenàtre de prompt style Unix }
  cmdOpenAC,            { Ouvre un fichier source en langage AC }
  cmdOpenAsm,           { Ouvre un fichier source en langage Assembleur }
  cmdOpenBas,           { Ouvre un fichier source en langage Basic }
  cmdOpenButtEdt,       { Ouvre un Icon existant ou en crÇe un }
  cmdOpenC,             { Ouvre un fichier source en langage C/C++}
  cmdOpenCobol,         { Ouvre un fichier source en langage Cobol }
  cmdOpenDrw,           { Ouvre un dessin existant ou en crÇe un }
  cmdOpenEdt,           { Ouvre un fichier texte ASCII DOS }
  cmdOpenEuphoria,      { Ouvre un fichier source en langage Euphoria }
  cmdOpenFortran,       { Ouvre un fichier source en langage Fortran }
  cmdOpenGatt,          { Ouvre un document existant ou en crÇe un }
  cmdOpenMod,           { Ouvre un fichier musical .MOD }
  cmdOpenPas,           { Ouvre un fichier source en langage Pascal }
  cmdOpenRC,            { Ouvre un fichier source en Ressource de format C }
  cmdOpenSuperCalc,     { Ouvre un chiffrier Çlectronique ou en crÇe un }
  cmdOpenDataBase,      { Ouvre une base de donnÇes }
  cmdOpenView,          { Visualise rapidement en ASCII un fichier quelconque}
  cmdHelp,              { Permet d'obtenir de l'aide }
  cmdShell,             { Lance l'interprÇteur de commande du DOS }
  cmdChDisk,            { Change le disque courant }
  cmdMkDir,             { CrÇe un nouveau rÇpertoire }
  cmdDiskDoctor,        { Docteur de disque }
  cmdHardDiskPark,      { Stationne la/les tàte(s) de disque(s) dur }
  cmdFormatDisk,        { Format une disquette }
  cmdDiskOption,        { SpÇcifie la configuration des disques }
  cmdDoctorVirus,       { Docteur Anti-Virus }
  cmdPlayMod,           { Lance un fichier musique de .MOD }
  cmdStopPlayMod,       { Arràte de faire jouer un fichier de musique .MOD }
  cmdPrnSetup,          { Configuration de l'imprimante }
  cmdVideoEnvironnement,{ Configuration de l'environnement vidÇo }
  cmdSetVideoMode,      { Change de mode vidÇo }
  cmdSomaryInfo,        { Demande des informations sommaire sur le systäme }
  cmdVidInfo,           { Demande des informations sommaire sur le vidÇo primaire }
  cmdDiskInfo,          { Demande des informations sur les unitÇs }
  cmdHexViewEdtDisk,    { Regarde directement un disque en HexadÇcimal }
  cmdSetDirSetup,       { Mise Ö jour des rÇpertoires }
  cmdHexEdt,            { êditeur HexadÇcimal de fichier }
  cmdInfoMem,           { Information mÇmoire gÇnÇral }
  cmdInfoMCB,           { Information sur les MCB }
  cmdCmosInfo,          { Information sur la mÇmoire sur pile CMOS }
  cmdLoader,            { Lance le Menu d'Application }
  cmdOpenWatch,         { Ouvre une calculatrice programmable}
  cmdEditMnu,           { êdite le Menu d'Application }
  cmdOutput,            { Permet de voir l'Çcran de sortie }
  cmdEditMainMenu,      { êdite le menu principal du BBS }
  cmdExec,              { ExÇcute manuellement un fichier }
  cmdEditFileMenu,      { êdite le menu de fichier du BBS }
  cmdRefreshWn,         { Raffraåchis la fenàtre courante }
  cmdCpySel,            { Copie avec sÇlectionnement...}
  cmdDelSel,            { Efface avec sÇlectionnement...}
  cmdAgenda,            { Demande l'agenda }
  cmdSetupSourcer,      { Ajustement du Sourceur }
  cmdSetupKeyboard,     { Ajustement du clavier }
  cmdSetSonVolume,      { Ajustement du volume du son}
  cmdSetEquilizer,      { Ajustement de l'Çgalisateur de frÇquence }
  cmdCleanDisk,         { MÇnagäre de disque}
  cmdSearchVerb,        { Recherche de verbe}
  cmdPlayerCD,          { Joueur de compacte disque}
  cmdLookLog,           { Regarde le journal de bord}
  cmdPartition,         { Regarde les partitions }
  cmdSetClock,          { Fixe l'heure }
  cmdConversion,        { Formule de conversion }
  cmdCalendar,          { Calendrier }
  cmdImageTitle,        { Image associÇ Ö la barre de titre }
  cmdWallPaper,         { Papier paint }
  cmdInsertImage,       { Insäre une image }
  cmdSQLCommand,
  cmdGlobalDraw,
  cmdExit];             { Quitte l'application MonsterBook/PowerHacken }

  { Commande supportÇ quand aux moins une fenàtre est ouverte }
 cmdDefaultOpen:Set of Byte=[
  cmdLstWn,             { Obtient une fenàtre de sÇlection de fenàtre courante }
  cmdPreviousWn,        { Passe Ö la fenàtre prÇcÇdente }
  cmdZoom,              { Zoom de la fenàtre }
  cmdNextWn,            { Passe Ö la fenàtre suivante }
  cmdCloseWn,           { Ferme la fenàtre }
  cmdCloseAllWn,        { Ferme toutes les fenàtres }
  cmdCloseAllWnSaved];  { Ferme toutes les fenàtres et les sauvegardes s'il ne
                          se pas Ö jour. }

 cmdWn:Array[wnMin..wnMx]of Set of Byte=(
{Edt de texte}[cmdSave,          { Sauvegarde le texte }
               cmdSaveAs,        { Sauvegarde sous un nouveau nom }
               cmdCompile,       { Compile si c'est un langage de programmation }
               cmdCompress,      { Compresse en fichier compacte }
               cmdConv2AC,       { Convertie en langage AC }
	       cmdConv2Bas,      { Convertie en langage Basic }
	       cmdConv2Pas,      { Convertie en langage Pascal }
               cmdConv2RC,       { Convertie en ressource de format C }
               cmdTxtBoldWord,   { Change le mot courant en mode gras en mode
                                   document  ou en majuscule  dans les autres
                                   modes. }
               cmdTxtUnderlnWord,{ Change le mot courant en mode soulignement }
	       cmdTxtItalicWord, { Change le mot courant en mode italique }
               cmdTxtDblWord,    { Change le mot courant en mode double largeur }
               cmdTxtInverseWord,{ Change le mot courant en mode inversÇ }
	       cmdTxtExposantWord,{Change le mot courant en mode exposant }
               cmdTxtNormalWord, { Change le mot courant en mode normal }
               cmdTxtDelSpc,     { Efface les espaces suivant jusqu'au prochain mode }
               cmdTxtDelWord,    { Efface le mot courant }
	       cmdTxtPgUp,       { Pas Ö l'Çcran prÇcÇdente }
               cmdDelCurrCol,    { Efface la colonne courante }
               cmdDelCurrLn,     { Efface la ligne courante }
               cmdDelCurrMatrix, { Efface la police courante }
	       cmdInsCurrCol,    { Insäre une colonne Ö la position courante }
               cmdInsCurrLn,     { Insäre une ligne Ö la position courante }
               cmdInsCurrMatrix, { Insäre une police Ö la position courante }
               cmdGotoLn,        { Aller Ö la ligne }

               cmdReplace,       { Remplace un mot par un autre }
               cmdSearch,        { Recherche d'un mot ou d'une expression}
               cmdSearchAgain,   { Continue la recherche ou le remplacement }
               cmdEditMode,      { Change le mode d'Çdition }
               cmdChrType,       { Change le type de caractäre }
	       cmdCenterTxt,     { Centre un texte }
               cmdTxtDbl,        { Fixe le mode double largeur }
               cmdTxtItalic,     { Fixe le mode italique }
               cmdTxtUnderln,    { Fixe le mode soulignement }
               cmdDrawMode,      { Fixe le mode dessin }
               cmdRun,           { ExÇcute la version compilÇ du programme compilÇ }
               cmdSetMarge,      { Fixe la marge }
               cmdPgUp,          { Passe Ö l'Çcran prÇcÇdente }
               cmdPgDn,          { Passe Ö l'Çcran suivante }
	       cmdLeft,          { Passe au caractäre prÇcÇdent }
               cmdRight,         { Passe au caractäre suivant }
               cmdUp,            { Passe Ö la ligne du haut }
               cmdDn,            { Passe Ö la ligne du bas }
               cmdExecMacro,     { ExÇcute un macro }
               cmdEditXChgPg,    { êchange 2 pages }
	       cmdHomeTxt,       { Aller au dÇbut du texte }
               cmdEndTxt,        { Aller Ö la fin du texte }
               cmdPrint,         { Imprimer le texte }
               cmdHomeBlock,     { Fixe le dÇbut du bloque }
               cmdEndBlock,      { Fixe la fin du bloque }
	       cmdCopyBlock,     { Copie le bloque }
               cmdMoveBlock,     { DÇplace le bloque }
               cmdWriteBlock,    { êcrit le bloque }
               cmdPasteOS2BlocFile, { êcrit Ö partir d'un bloc OS/2 }
               cmdOpenMacro,     { Ouvre un macro }
               cmdInsertFile,    { Insäre un fichier Ö l'intÇrieur de celui en Çdition }
               cmdFiltre,        { PossibilitÇ de traåter par filtrer une zone d'Çdition}
               cmdCorrecteur,       { Correcteur d'orthographe}
               cmdGotoPg,           { Aller Ö une page particuliäre }
               cmdMakeCadre,        { CrÇe un cadre }
               cmdOpenFileAtCursor],{ Ouvre un fichier en fonction de chemin ou fichier
                                      Çcrit dans le texte. }
{View}	      [cmdSearch,        { Recherche un mot }
               cmdSearchAgain],  { Recherche encore le màme mot }
{IconEditor}  [cmdSave,          { Sauvegarde l'Icon }
               cmdSaveAs],       { Sauvegarde l'Icon sous un nouveau nom }
{Drw}         [cmdFullScrn,      { Image pleine Çcran }
               cmdMagnify,       { Mode magnifique }
               cmdSave,          { Sauvegarde le dessin }
               cmdSaveAs],       { Sauvegarde le dessin sous un nouveau nom }
{Lotus}       [cmdSave,          { Sauvegarde le tableur }
               cmdSaveAs,        { Sauvegarde le tableur sous un nouveau nom }
               cmdTxtUnderlnWord],{ Soulignement}
{FileMangers} [cmdCpyFiles,      { Copie(s) un/des fichier(s) }
               cmdMoveFiles,     { DÇplace(s)/renomme(s) un/des fichier(s) }
               cmdAssign,        { Assigne des rÇpertoires Ö des unitÇs }
               cmdAwk,           { Recherche... }
               cmdGrep,          { Recherche... }
	       cmdJoinDisk,      { Join des unitÇs }
               cmdBoard,         { Change de tableau }
               cmdChDisk2,       { Change le 2iäme talbeau pour un autre unitÇ }
               cmdPrint,         { Imprime le fichier courant }
               cmdDelFile,       { Efface(s) un/des fichier(s) }
               cmdCompress,      { Compresse un fichier }
               cmdInverseBoard,  { Inverse les 2 tableaux }
               cmdOldOtherBoard, { Change l'autre tableau pour son ancien}
               cmdSelectWildCard,
               cmdUnSelectWildCard,
               cmdInverseWildCard,
               cmdFMReread],     { Relecture des fichiers du tableau courant}
{MDos}	      [cmdTxtDelSpc,     { Fixer les descriptions }
               cmdHelp],         { Demande d'obtenir de l'aide }
{Terminal}    [cmdHostMode,      { Passe en mode BBS }
               cmdTermWelcome,   { Demande l'Çdition de la prÇsentation du BBS }
               cmdViewDownload,  { Demande voir la liste des fichiers reáu par
                                   tÇlÇphone }
               cmdUpload,        { Envoie un fichier }
               cmdModemDoctor,   { Examine l'Çtat du modem }
               cmdAnswerMode,    { Fixe le modem en mode rÇpondeur }
               cmdOriginateMode, { Interdit au modem de rÇpondre }
               cmdDownload],     { Recoie un fichier }
{Unix}	      [cmdHelp],         { Demande d'obtenir de l'aide }
{HexView}     [cmdSave,          { Sauvegarde le bloque courant }
               cmdEditReadOnly,  { Autorise la modification de contenu }
               cmdHelp],         { Demande d'obtenir de l'aide }
{Output}      [cmdHelp],         { Demande d'obtenir de l'aide }
{MusicMod}    [cmdHelp],         { Demande d'obtenir de l'aide }
{Macro}	      [cmdHelp],         { Demande d'obtenir de l'aide }
{Calc.Program}[cmdHelp],         { Demande d'obtenir de l'aide }
{Calculatrice}[cmdHelp],         { Demande d'obtenir de l'aide }
{Calendrier}  [cmdHelp,          { Demande d'obtenir de l'aide }
               cmdSearch,        { Calculer le nombre de jours entre deux dates }
               cmdGotoPg],       { Aller Ö une annÇe particuliäre }
{Agenda}      [cmdHelp],         { Demande d'obtenir de l'aide }
{CatDisk}     [cmdHelp],         { Demande d'obtenir de l'aide }
{Mnu}         [cmdHelp],         { Demande d'obtenir de l'aide }
{Font}        [cmdSave,cmdSaveAs],
{DataBase}    [cmdHelp],
{Debug}       [cmdHelp],
{ProgMan}     [cmdHelp],
{Tetris}      [cmdFullScrn,cmdTetrisLevel],
{Joueur de CD}[cmdHelp,cmdPlayPause,cmdStop],
{Ouvre fichier}[cmdHelp],
{SQL}         [cmdHelp],
{Recherche}   [cmdHelp],
{Dessin tech} [cmdHelp,cmdSave,cmdSaveAs],
{ACDSee}      [cmdHelp],
{Logo}        [cmdHelp,cmdSave,cmdSaveAs],
{Barre tache} [cmdHelp],
{Partition}   [cmdHelp],
{Explorer DB} [cmdHelp]);
 KeyWait:Byte=$FF; { DÇfinit le dÇfinit le dÇlai d'attente du clavier }

Type
  { Enregistrement de fenàtre d'application }
 WindowApp=Record
  Model:Byte;                    { Le modäle de fenàtre: constante wn??? }
  O:TextBoxRec;                  { Pour le Zoom...}
  InTaskBar:Boolean;             { Invisible sur la barre de tÉche }
  P:Record Case Byte of          { En cas de modäle de fenàtre de:}
   1:(Edit:EditorApp);           { Traåtement de texte, Çditeur texte }
   0:(W:Window);                 { CoordonnÇe de l'arriäre plan}
   2:(ViewAscii:ViewAsciiApp);   { Regarde rapidement en ASCII }
   3:(IcnEdt:IconEditApp);       { êditeur d'Icon }
   4:(DrawEdit:DrawEditApp);     { Programme de dessin }
   5:(Lotus:SuperCalcApp);       { Chiffrier Çlectronique, tableur }
   6:(FM:FileManagerApp);        { Gestionnaire de fichiers }
   7:(Shell:Prompt);             { Prompt de style DOS }
   8:(Terminal:Term);            { Terminal de communication }
   9:(Unix:Prompt);              { Prompt de style Unix }
   10:(HexVw:HexEditApp);        { êditeur hexadÇcimal }
   14:(PC:WatchWin);             { Calculatrice programmable }
   15:(Calculator:SuperCalcApp); { Calculatrice }
   16:(Calendar:CalendarApp);    { Calendrier }
   19:(Mnu:LoaderMenuApp);       { Menu d'Application }
   20:(Font:FontEditor);         { êditeur de police }
   21:(DataBase:DataBaseApp);    { Base de donnÇes }
   22:(Debug:DebugRec);          { DÇboguer de programme }
   23:(ProgMan:ProgramsManagerApp);{ Gestionnaire de programme }
   24:(Tetris:TetrisGame);       { Jeux Tetris }
   25:(CD:CDPlayer);             { Joueur de CD}
   26:(FLB:FileListBox);         { Choisir un fichier }
   27:(SQL:SQLCommandApp);       { Commande SQL }
   28:(SearchFiles:WinsSearchFiles);{ Recherche de fichiers }
   29:(TechDraw:TechDrawApp);    { Dessin technique }
   30:(Partition:PartitionManagerApp);{ Gestionnaire de partition }
   31:(ExplorerDB:ExplorerDataBaseApp);{Explorateur de Base de donnÇes }
   32:(Logo:LogoApp);
  End;
 End;

  { Enregistrement d'un raccourcis clavier }
 AcceleratorRec=Record
  KeyA,KeyB:Word; { Touche primaire, touche secondaire...}
  Option:Byte;    { Commande associÇ Ö la combinaison }
 End;

  { Tableau de raccourcis clavier }
 AcceleratorsArray=Array[0..122]of AcceleratorRec;

 TaskBarApp=Record
  Visible:Boolean;       { La barre de tÉche est visible? }
  MaxX:Byte;             { Position maximal de la barre de tÉche }
  App7IlesRC:Boolean;    { ÆApp7Iles.RCØ prÇsent? }
 End;

  {Application de barre de tÉche}
 TaskBarManager=Record
  W:Window;
  Index:Word;
  Title:String[8];
 End;

  {Structure de l'historique des documents pouvant àtre rÇouvert }
 HistoryDocument=Record
  Len:Word;
  EndCmd:Word;
  History:Array[0..511]of Byte;
 End;

  {Application principal}
 MApplication=Record
  Terminated:Boolean;              { Utilisateur Ö demander de quitter le programme }
  FastFinish:Boolean;              { Pour ne pas avoir de question quitter si }
                                   { nÇcessite un redÇmarrage pour un configuraiton }
                                   { a tenir compte...}
  PAccelerators:^AcceleratorsArray;{ Pointeur sur les raccourcis clavier }
  MaxAccelerators:Word;            { Nombre de raccourcis clavier dans le ButtSwitchPtr }
  IsFill:Boolean;                  { Mode plein }
  MousePointerFileName:PChr;       { Nom du pointeur de souris }
 End;

Const
 FileNameMenu:String[12]='FRANCAIS.MNB';
{ TitleSetting:Set of(tsK)=[tsK];}
 DesktopIconOnStartMode:Boolean=True;
 TaskMgrInTaskBar:Boolean=True;
 WindowsXPLook:Boolean=False;
 SoundIconOnStatus:Boolean=True;
 CountryIconOnStatus:Boolean=True;
 OverlayOn:(ooDisk,ooEMS,ooXMS)=ooDisk;
 ExitLevel:(xlNormal,xlRestart,xlBoot)=xlNormal;
 EnvMode:Byte=emWin9X;         { Mode d'environnement }
 PBLastLen:Word=$FFFF;

Var
 TaskBar:TaskBarApp;           { Application barre de tÉche }
 DrawModeB:Byte;               { Mode dessin courant }
 CurrEdit:RBP;                 { NumÇro de la fenàtre courante }
 WinPtr:^WindowApp;            { Pointeur sur la structure de la fenàtre courante }
 But:ButtonMnu;                { Barre d'icìne }
 IsLine:Boolean;               { Mode ligne }
 IsBox:Boolean;                { Mode boåte/rectangle }
 IsCircle:Boolean;             { Mode cercle }
 IsPaint:Boolean;              { Mode peinture }
 IsTrace:Boolean;              { Mode trace }
 IsText:Boolean;               { Mode texte }
 ViewToolBar:Boolean;          { Barre d'outils de l'application visible }
 Application:MApplication;
 YEditor:Byte;                 { DÇfinit la position Y de la prochaåne fenàtre }
 H:History;                    { Historique pour l'ouverture de fichier}
 IconBnk:Array[wnMin..wnMI]of XInf;{ Banque d'Icìne pour la barre d'application}
 FullDate:Boolean;
 MtxNm:Byte;
 Desktop:Boolean;
 CurrModem:Byte;
 SwapEms:Boolean;
 NamePrimMonitor:PCHR;
 NamePrimCard:PCHR;
 PrnMarge:Boolean;
 ModeTypeWriter:Boolean;
 NameLPT4:PCHR;
 NameLPT3:PCHR;
 NameLPT2:PCHR;
 NameLPT1:PCHR;
 CurrPrn:PCHR;
 PathOutput:PCHR;
 PathUnit:PCHR;
 PathObject:PCHR;
 PathMacDrw:PCHR;
 PathMac:PCHR;
 PathAsmC:PCHR;
 PathCalc:PCHR;
 PathPCX:PCHR;
 PathDraw:PCHR;
 PathCatDisk:PCHR;
 PathPhoneList:PCHR;
 PathMod:PCHR;
 PathWin:PCHR;
 PathOS2:PCHR;
 PathUnix:PCHR;
 PathCountry:PCHR;
 FontInActifTitlePath:PCHR;
 FontTitlePath:PCHR;
 RegSerialCode:PCHR;
 BankRoutine:Byte;

