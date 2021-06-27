{$DEFINE MonsterBook}
{$I DEF.INC}
Uses
 Isatex,
 Systex
 {$IFDEF FullVersion}
  ,MBCortex
 {$ENDIF}
 {$IFDEF BureauVersion}
  ,MBBCrtex
 {$ENDIF};

Var
 NoLuxe:Boolean;

Procedure AgendaWindow;
{$IFDEF Reseau}
 Procedure AnswerMode;
 Procedure BBSWelcome;
{$ENDIF}
Procedure BadDistribution;
Procedure Bureau;
Procedure Calendar;
Procedure CallHexView;
Procedure ChangeCase;
Procedure ChangeCurrMtxChr;
Procedure ChangeDiskOnBoard2;
Procedure ChgFont;
Procedure ClipboardOutput;
Procedure CloseAllWnSaved;
Function  ClsWn:Boolean;
{$IFDEF Developpeur}
 Procedure Compile;
{$ENDIF}
Procedure CopyClipBoard;
Procedure Correcteur;
Procedure CpyFiles;
Procedure DefEndBar;
Procedure Delete;
Procedure DelSel;
Procedure DelSpc;
Procedure DelWord;
Procedure DskHex;
Procedure DoneMnu;
Procedure EditFileMenu;
Procedure EditImage;
Procedure EditMainMenu;
Procedure EditMenuApplication;
Procedure EditXChgPg;
Procedure EdtSetMtx;
Procedure EdtHugeMtx;
Procedure ErrPrn;
Procedure ExecMenu;
Procedure ExecuteMacro;
Procedure NewExplorerDB;
Procedure ExtChrMode;
Procedure FileExplorer;
Procedure FileSetAttribut;
Procedure FillMode;
Procedure Filtre;
Procedure FindPerson;
Procedure FLIPlay;
Procedure FullScrn;
Procedure GotoLn;
Procedure GotoPage;
Procedure GotoRow;
{$IFDEF Reseau}
 Procedure HangUpPhone;
{$ENDIF}
Procedure Help(Const FileName:String;Min,Max:Word);
Procedure HelpKey;
Procedure HelpOnLine;
Procedure HexView(Const Path:String);
Procedure HMenuTitle(Var Context);
Procedure InfoFont;
Procedure InitMnu(Mode:Byte;SubMode:Byte);
Procedure InsCol;
Procedure InsFile;
Procedure InsertImage;
Procedure InverseWildCard;
Procedure LineHor;
Procedure LookLog;
Procedure LocalMenuFont;
Procedure LstEdt;
Procedure MakeCadre;
Procedure MakeDirectory;
Procedure MakeMacro(Const Path:String);
Procedure MemoryMenu;
Procedure MenuDESQview;
Procedure MenuClassicEnglish;
Procedure MenuClassicFrancais;
Procedure MinimiseAllWindows;
Procedure MoveFiles;
{$IFDEF Developpeur}
 Procedure NewBasic;
{$ENDIF}
Procedure NewDataBase;
Procedure NewDFD;
Procedure NewIcnEdt;
Procedure NewDrw;
Procedure NewEdt;
Procedure NewElectric;
Procedure NewFolder;
Procedure NewFont;
Procedure NewGat;
Procedure NewProgMan;
Procedure NewSuperCalc;
Procedure NewTechDraw;
Procedure NewTerm;
Procedure NortonCommander;
Procedure OpenAC;Far;
Procedure OpenAssembler;Far;
Procedure OpenAtlas;
Procedure OpenBasic;Far;
Procedure OpenBasAppleII;Far;
Procedure OpenBasCK64;Far;
Procedure OpenBasCoco3;Far;
Procedure OpenC;Far;
Procedure OpenCobol;Far;
Procedure OpenDataBase(Const FileName:String);Far;
Procedure OpenDebug;Far;
Procedure OpenEuphoria;Far;
Procedure OpenFortran;Far;
Procedure OpenIni;Far;
{$IFDEF Developpeur}
 Procedure OpenLogo(Const FileName:String);Far;
{$ENDIF}
Procedure OpenMacro;Far;
Procedure OpenPascal;Far;
Procedure OpenRC;Far;
Procedure OpenIcnEdt;
Procedure OpenDraw(Path:String);
Procedure OpenDrw;
Procedure OpenEdt;
Function  OpenFile(FileName:String):Boolean;
Procedure OpenFolderWindow(Const Name,Path:String);
Procedure OpenFont;
Procedure OpenHelp(Const FileName,Title:String);
Procedure OpenMod;
Procedure OpenPartitionManager;
Procedure OpenResource;
Procedure OpenSearchFiles;
Procedure OpenSelection(Path:String;Mode:Byte);
Procedure OpenTechDraw;
Procedure OpenText;
Procedure OpenSuperCalc;
Procedure OpenView;
{$IFDEF Developpeur}
 Procedure OpenWorkShop;
{$ENDIF}
Procedure OpenX(Mode:Byte);
{$IFDEF Reseau}
 Procedure OriginateMode;
{$ENDIF}
Procedure PasteClipBoard;
Procedure PasteOS2File;
Function  PutTaskIcon(X,Model:Byte;Compact:Boolean):Boolean;
Procedure Print;
Procedure PrintersSetup;
Procedure PromptAmigaDOS;
Procedure PromptDRDOS;
Procedure PromptMSDOS;
Procedure PromptNDOS;
Procedure PromptOS2;
Procedure PromptVAX;
Procedure PromptWindows9X;
Procedure RenameVolume;
Procedure RunApp(Cmd:Word);
{$IFDEF Reseau}
 Procedure RunBBS;
{$ENDIF}
Procedure RunCDPlayer;
Procedure RunLoader;
Procedure RunPlayMod;
Procedure SautPage;
Procedure SaveAll;
Procedure SaveAs;
{$IFDEF Educative}
 Procedure SearchCity;
 Procedure SearchCountry;
{$ENDIF}
Procedure SelectWildCard;
Procedure SendMail;
Procedure SetColor;
Procedure SetFormat;
Procedure SetRead;
Procedure SetTri;
Procedure SetupDesktop;
Procedure ShutDown;
{$IFDEF Developpeur}
 Procedure SQLCommand;
{$ENDIF}
Procedure StartMode;
Procedure StartPartition;
Procedure SwitchTaskBar;
Procedure TBMLoad(Var Context;X1,Y1,X2,Y2:Byte;Const Path:String);
Function  TBMTitle(Var Context;Max:Byte):String;
Procedure TileWindows;
Procedure TitleMenu;
Procedure UnselectWildCard;
Procedure UpdateTaskBar;
Procedure UserChDir;
Procedure ViewAscii(Path:String);
Procedure ViewDownload;
Procedure ViewOption;
Procedure WallPaper;
Procedure WinGlobalDraw;
Procedure WnFM;
Procedure WnPrompt;
Procedure WnMUnix;
Procedure WnWatch;
Procedure Win9XMenu(X:Byte);
Function  WinGotoLine:LongInt;
Function  WinGotoRow:LongInt;
Function  WinGotoPg:Word;
Procedure WriteBlock;
Procedure XAltF1Key;
Function  XEditor:Byte;
Procedure Zoom;
Procedure _OpenDataBase;
Procedure _OpenFont(Path:String);
Procedure _OpenIcnEdt(Const Path:String);
Procedure _OpenSelection;
Procedure _OpenSuperCalc(Path:String);

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                             IMPLEMENTATION
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses
 Adele,
 {$IFNDEF DPMI}
  Overlay,              {Unit‚ non fournit avec le Malte Genesis,}
                        {s'occupant exclusivement de la gestion des}
                        {recouvrement...}
 {$ENDIF}
 Registry, {Base de registres}
 ChkMouse, {Teste de v‚rification de la souris}
 TaskMgr,  {Gestionnaire de tƒche}
 EdtMacro, {Macro pour l'‚diteur}
 Math,     {Services math‚matiques}
 Memories, {Gestionnaire de m‚moires}
 Systems,  {Outils d'exploitation}
 Video,    {Gestionnaire vid‚o suppl‚mentaire}
 Sound,    {Joueur de musique sur carte de son}
 Mouse,    {Gestionnaire de souris}
 Dialex,   {D‚finition des dialogues}
 Dials,    {Dialogues de base}
 Apps,     {Gestionnaire d'application}
 {$IFDEF Developpeur}
  Basic,   {Interpr‚teur BASIC}
 {$ENDIF}
 Agenda,   {Agenda, bottin de t‚l‚phone personnel}
 Editex,   {Structures et donn‚es de l'‚diteur}
 Editor,   {TraŒtement de texte}
 Tools,    {Outils divers}
 {$IFDEF FullVersion}
  MalEnv,  {Gestionnaire d'environnement du ®MonsterBook¯}
  MBStart, {D‚marreur du ®MonsterBook¯}
  MBConfig,{Changement utilisateur de la configuration}
  MBInitSc,{cran de travail du ®MonsterBook¯}
  MBInstal,{Installation du MonsterBook }
  MBMenu,  {Menu programmable}
  MBOpenCu,{Ouvre au curseur}
  MBSave,  {Sauvegarde du fichier de configuration}
  MBSearch,{Recherche … effectuer...}
  MBShell, {Appel d'un composant ou application externe}
  MBExit,  {Terminaison du ®MonsterBook¯}
 {$ENDIF}
 {$IFDEF BureauVersion}
  MalBEnv, {Gestionnaire d'environnement du ®MonsterBook¯}
  MBBStart,{D‚marreur du ®MonsterBook¯}
  MBBConfi,{Changement utilisateur de la configuration}
  MBBInitS,{cran de travail du ®MonsterBook¯}
  MBBInsta,{Installation du MonsterBook }
  MBBMenu, {Menu programmable}
  MBBOpenC,{Ouvre au curseur}
  MBBSave, {Sauvegarde du fichier de configuration}
  MBBSearc,{Recherche … effectuer...}
  MBBShell,{Appel d'un composant ou application externe}
  MBBExit, {Terminaison du ®MonsterBook¯}
 {$ENDIF}
 {$IFDEF Educative}
  Besch,   {Bescherelle (les verbes) }
  Geo,     {Service d'atlas de g‚ographique}
 {$ENDIF}
 Terminal, {mulateur de terminal}
 FileMana, {Gestionnaire de fichiers}
 ToolFile, {Outils du Gestionnaire de fichiers}
 PrnFileM, {Impression pour le Gestionnaire de fichiers}
 {$IFDEF Reseau}
  Email,   {Courriel}
  TMDials, {Terminal avanc‚e}
 {$ENDIF}
 ToolTerm, {Prompt, Shell,...}
 DrawEdit, {Editeur de dessin}
 ToolVid,  {Outils vid‚o}
 ToolInfo, {Informations systŠmes}
 ToolPCI,  {Outil PCI}
 {$IFDEF Developpeur}
  QHexView,{diteur hexad‚cimal}
 {$ENDIF}
 EdtExtra, {Outils suppl‚mentaire du traŒtement de texte}
 EdtLoad,  {Chargeur de document du traŒtement de texte}
 Arcade,   {Arcade, animation et ‚conomiseur d'‚cran}
 Numerix,  {Calculatrice programmable, conversion de donn‚es}
 MalCalc,  {Tableur (chiffrier ‚lectronique)}
 Loader,   {Menu d'application texte}
 AppDB,    {Application de base de donn‚es}
 ToolPrn,  {Outils d'impression}
 ToolSoun, {Outils de son}
 EdtDone,  {Terminaison du traŒtement de texte}
 EdtBlock, {TraŒtement de texte - Gestion des blocs}
 {$IFDEF Developpeur}
  ExplorDB,{Explorateur de Base de donn‚es}
  EditIcon,{Editeur d'ic“ne}
  MBDebug, {D‚bogueur}
  Sourcer, {D‚sassembleur de code machine}
  FontEdt, {Editeur de police de caractŠres}
  ToolRes, {Outils associ‚e aux ressources RLL}
  WS,      {WorkShop}
 {$ENDIF}
 EdtSearc, {Recherche dans le traŒtement de texte}
 ProgMan,  {Gestionnaire de programmes}
 DialPlus, {Suppl‚ment de dialogue}
 DialTree, {Objet d'arbre}
 ToolTime, {Outils du temps}
 Restex,   {D‚finition des ressources}
 ResLoadI, {Chargement de ressources d'image}
 ResServI, {Service de ressources d'image}
 ResSaveI, {Sauvegarde de ressources d'image}
 ToolDsk,  {Outils disque}
 ToolView, {Outils de visualisation ASCII}
 Show,     {Affiche des dessins et ex‚cute les animations}
 SysPlus,  {Suppl‚ment au systŠme d'exploitation}
 {$IFDEF Joystick}
  MBJoysti,{Gestionnaire de manettes de jeux}
 {$ENDIF}
 InfoMemo, {Information sur les composants m‚moires}
 GloDraw,  {Visualisateur global de dessin}
 Server,   {Serveur ASP, JSP }
 ResServD, {Service de base de donn‚es}
 ResSaveD, {Sauvegarde de base de donn‚es}
 {$IFDEF Developpeur}
  EditHelp, {Aide en ligne pour les programmeurs}
 {$ENDIF}
 ToolTask, {Gestionnaire de tƒches}
 TechDraw  {Dessin technique }
 {$IFDEF Reseau}
  ,ToolNet
 {$ENDIF}
 {$IFDEF Games}
  ,Tetris
  ,Missile
  ,Nibbles
 {$ENDIF}; {Jeux Tetris pour Application}

Function ExitMethod:Byte;Near;Forward;

Procedure ResetMnu;Begin
 LoadMenu(MaltePath+FileNameMenu);
 SetMnuSwitch;
 HRefreshBackground(Windows);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Proc‚dure InitMnu                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de cr‚er le menu d‚roulant  correspondant … la
 fenˆtre courante ouverte ou s'il n'y en pas d'ouverte, … la d‚finition
 par d‚faut.
}

Procedure InitMnu(Mode:Byte;SubMode:Byte);Begin
 RunMenu(Mode,SubMode);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                             Proc‚dure DoneMnu                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de restituer la m‚moire allou‚e au menu d‚roulant
 contenue dans la m‚moire par le ®MonsterBook¯.
}

Procedure DoneMnu;
Var
 I:SmallInt; { Compteur de boucle }
Begin
 For I:=0to(MaxSubMenu)do SMDone(SubMenu[I]);
 MaxSubMenu:=-1;
 PMDone;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure XEditor                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure demande la coordonn‚es verticale th‚orique o— devra
 s'ouvrir en principe la prochaine fenˆtre MDI.
}

Function XEditor;Begin
 XEditor:=YEditor-2;
End;

Procedure MakeApplication(X:Byte);Near;Begin
 HNew(Windows,X);
 SetMnuSwitch;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                     Proc‚dure NewSuperCalc                   Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet … l'utilisateur d'ouvrir une fenˆtre MDI
 calculatrice programmable afin  d'effectuer des calcules d'ordre
 math‚matique.
}

Procedure WnWatch;Begin
 MakeApplication(wnPC)
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Proc‚dure WnPrompt                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'ouvrir une fenˆtre MDI permettant d'effectuer
 des op‚rations compatible … l'interpr‚teur du systŠme d'exploitation de
 style DOS.
}

Procedure WnPrompt;Begin
 MakeApplication(wnPrmpt)
End;

Procedure PromptMode(Mode:Word);
Var
 FM:^Prompt;
 X1,Y1,X2,Y2:Byte;
Begin
 If(IsGrf)and(MediaSupport)Then Begin
  PutTaskIcon($FF,icnFolder,False);
 End;
 FM:=HNewManual(Windows,wnPrmpt,X1,Y1,X2,Y2);
 If(FM<>NIL)Then Begin
  PDInitMode(FM^,X1,Y1,X2,Y2,Mode);
  SetMnuSwitch;
 End;
End;

Procedure PromptDRDOS;Begin
 PromptMode(piDRDOS);
End;

Procedure PromptMSDOS;Begin
 PromptMode(piMSDOS);
End;

Procedure PromptNDOS;Begin
 PromptMode(piNDOS);
End;

Procedure PromptOS2;Begin
 PromptMode(piOS2);
End;

Procedure PromptVAX;Begin
 PromptMode(piVAX);
End;

Procedure PromptWindows9X;Begin
 PromptMode(piWindows9X);
End;

Procedure PromptAmigaDOS;Begin
 PromptMode(piAmigaDOS);
End;

Procedure NewTerm;Begin
 {$IFDEF Reseau}
  HLoad(Windows,wnTerm,StrPas(PathPhoneList));
 {$ELSE}
  BadDistribution;
 {$ENDIF}
End;

Procedure NewIcnEdt;Begin
 {$IFDEF Developpeur}
  MakeApplication(wnIcon)
 {$ELSE}
  BadDistribution;
 {$ENDIF}
End;

Procedure WnMUnix;Begin
 MakeApplication(wnUnix)
End;

Procedure Calendar;Begin
 MakeApplication(wnCalendar)
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Proc‚dure NewSuperCalc                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure lance l'ouverture d'une nouvelle base d'un chiffrier
 ‚lectronique.
}

Procedure NewSuperCalc;Begin
 MakeApplication(wnSuperCalc)
End;

Procedure RunLoader;Begin
 MakeApplication(wnMnu)
End;

Procedure OpenDraw;Begin
 If Path=''Then NewDrw
  Else
 Begin
  HLoad(Windows,wnDraw,Path);
  SetMnuSwitch;
 End;
End;

Procedure OpenDrw;
Var
 Path:String;
Begin
 Path:=_OpenWinModel('*.*','Ouvre Dessin',H,omDraw);
 If Path<>''Then OpenDraw(Path);
End;

Procedure _OpenIcnEdt(Const Path:String);Begin
 {$IFDEF Developpeur}
  HLoad(Windows,wnIcon,Path);
  SetMnuSwitch;
 {$ELSE}
  BadDistribution;
 {$ENDIF}
End;

Procedure OpenIcnEdt;
{$IFDEF Developpeur}
 Var
  Path:String;
{$ENDIF}
Begin
 {$IFDEF Developpeur}
  Path:=_OpenWin('*.ICN;*.ICO;*.CUR','Ouvre Ic“ne',H);
  If Path<>''Then _OpenIcnEdt(Path);
 {$ELSE}
  BadDistribution;
 {$ENDIF}
End;

Procedure LstEdt;Begin
 HGotoWin(Windows);
 SetMnuSwitch;
End;

Function IconName(X:Byte):String;
Var
 S:String;
Begin
 Case(X)of
  wnEdit:S:='WRITE';
  wnView:S:='';
  wnIcon:S:='';
  wnDraw:S:='PAINT';
  wnSuperCalc:S:='TABLEUR';
  wnFileManager:S:='WINFILE';
  wnPrmpt,wnTaskBarMgr:S:='COMMAND';
  wnTerm:S:='SETUP\MODEM';
  wnUnix:S:='UNIX';
  wnHexView:S:='DISKEDIT';
  wnOutput:S:='';
  wnMusicMod:S:='';
  wnMacro:S:='NOTEPAD';
  wnPC,wnCalculator:S:='CALC';
  wnCalendar:S:='CALENDAR';
  wnAgenda:S:='';
  wnMnu:S:='';
  wnFont:S:='';
  wnDebug:S:='';
  wnProgMan:S:='';
  wnTetris:S:='TETRIS';
  wnCDPlayer:S:='CDPLAYER';
  wnFileListBox:S:='FIND';
  icnSetup:S:='CONTROL';
  icnNewDoc:S:='DOCUMENT';
  icnFind:S:='FIND';
  icnFolder:S:='FOLDER';
  icnParam:S:='CONFIG';
  icnHelp:S:='HELP';
  icnExec:S:='EXEC';
  icnExit:S:='EXIT';
  icnExplorer:S:='EXPLORER';
  icnControl:S:='CONTROL';
  icnPrinter:S:='SETUP\SPOOL';
  icnBesch:S:='BESCH';
  icnStart:S:='START';
  icnCleanMgr:S:='CLEANMGR';
  icnElectronic:S:='SETUP\CHIPS';
  icnDesktop:S:='DESKTOP';
  icnSound:S:='SOUND';
  Else S:='';
 End;
 If S<>''Then IconName:=MaltePath+'ICON\'+S+'.ICO'
         Else IconName:='';
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ·}
{³     R o u t i n e   d e   b a r r e   d e   t ƒ c h e       º}
{ÔÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼}

Const
 stClose=$F001;
 stRefresh=$F002;
 stInTaskBar=$F003;
 stMaximise=$F004;
 stStartMode=$F005;
 stTaskManager=$F006;
  {Menu Windows 95/Calmira}
 w9Program=$F001;
 w9Favorite=$F002;
 w9Param=$F003;
 w9Search=$F004;
 w9Help=$F005;
 w9Run=$F006;
 w9Exit=$F007;
 w9Control=$F008;
 w9EditMenu=$F009;
 w9Explorer=$F00A;
 w9StartUP=$F00B;
 w9ShellDos=$F00C;
 w9Printers=$F00D;
 w9Ext=$F00E;
 w9FindFiles=$F00F;
 w9FindVerb=$F010;
 w9NewDoc=$F011;
 w9OpenDoc=$F012;
 w9FileMalteIni=$F013;
 w9SpaceWizard=$F014;
 w9FileApp7Iles=$F015;
 w9FindPerson=$F016;
 w9AssistantConfig=$F018;
 w9FindCity=$F019;
 w9DataBaseChantal=$F01A;
 w9FindCountry=$F01B;
 w9CheckMouse=$F01C;
 w9CheckPCI=$F01D;
 w9CompileApp7Iles=$F01E;
 w9RegEdit=$F01F;
 w9ModemDoctor=$F020;
 w9IPConfig=$F021;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                     Fonction _GetModelIcon                   Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de retourner le modŠle d'ic“ne associ‚e …
 l'application sp‚cifi‚e de la barre de tƒche
}

Function _GetModelIcon(Const W:WindowApp):Byte;Near;
Var
 Model:Byte;
Begin
 Model:=W.Model;
 Case(Model)of
  wnProgMan:Begin
   If(Pos('SETUP',W.P.ProgMan.Path)>0)Then Model:=icnSetup Else
   If(W.P.ProgMan.Mode=mWin9X)Then Model:=icnStart;
  End;
  wnFileManager:Begin
   If(W.P.FM.Explorer)Then Model:=icnExplorer;
  End;
  wnTechDraw:If(W.P.TechDraw.FileInfo.Origin=tdElectronic)Then Model:=icnElectronic;
 End;
 _GetModelIcon:=Model;
End;

Procedure LoadCountryIcon;
Var
 Data:CountryDataSetRec;
 ConvStart:Pointer;
 ConvEnd:Pointer;
 Size:^Word;
 Ok:Boolean;
Begin
 DBOpenServerName(ChantalServer,'CHANTAL:/Country/Country.Dat');
 If MalteCountryCode=0Then Ok:=DBLocateAbs(ChantalServer,1,CountryCode,[])
                      Else Ok:=DBLocateAbs(ChantalServer,0,MalteCountryCode,[]);
 If(Ok)Then Begin
  DBReadRec(ChantalServer,Data);
  ConvStart:=@Data;ConvEnd:=@Data;
  DBGotoColumnAbs(ChantalServer,5,ConvStart);
  Size:=ConvStart;
  ASM
   ADD Word Ptr ConvStart,4+11
  END;
  If XAllocMem(rmAllResSteady,Size^,IconBnk[icnCountry])Then
   XSetAbsRec(IconBnk[icnCountry],0,Size^,ConvStart^);
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Fonction PutTaskIcon                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction affiche l'ic“ne appropri‚ sur la barre de tƒche et
 retourne vrai si l'op‚ration a r‚ussi.
}

Function PutTaskIcon(X,Model:Byte;Compact:Boolean):Boolean;
Var
 Path:String;
 Y1,H,L:Word;
Begin
 PutTaskIcon:=False;
 If Not(MediaSupport)Then Exit;
 If Not(IsGrf)Then Exit;
 If(Model>wnMI)Then Exit;
 If IconBnk[Model].Output=$FFThen Begin
  If(Model=icnCountry)Then LoadCountryIcon
   Else
  Begin
   Path:=IconName(Model);
   If Path<>''Then Begin
    RILoadImage(Path,diAutoDetect,0,$FFFF,rmAllResSteady,[],IconBnk[Model]);
   End;
  End;
 End;
 If(IconBnk[Model].Output<>$FF)and(X<>$FF)Then Begin
  Y1:=GetRawY(YTaskMnu)+1;
  H:=HeightChr-2;
  L:=23;
  If(Compact)and(HeightChr>8)Then Begin
   Inc(Y1,2);Dec(H,4);Inc(X);Dec(L,8);
  End
   Else
  If Not(Compact)Then H:=GetMaxYPixelsTaskBar-Y1-3;
  RIPutImageScale(IconBnk[Model],(X shl 3)+1,Y1,L,H,CurrKrs.Menu.Normal shr 4);
  PutTaskIcon:=True;
 End;
End;

Function IsWindowsXPLook:Boolean;Begin
 IsWindowsXPLook:=(WindowsXPLook)and(IsGrf)and(BitsPerPixel>=15);
End;

Procedure PutTaskBarRelief(X1,X2:Byte);
Var
 G:GraphBoxRec;
Begin
 If(IsGrf)Then Begin
  G.X1:=X1 shl 3;
  G.Y1:=GetRawY(YTaskMnu);
  G.X2:=Pred(Succ(X2)shl 3);
  G.Y2:=GetMaxYPixelsTaskBar;
  If Not(WindowsXPLook)Then __GraphBoxRelief(G,CurrKrs.Menu.Normal);
 End;
End;

Function GetAttribut(Curr:Boolean):Byte;
Var
 A:Byte;
Begin
 If(Curr)Then Begin
  If CurrKrs.Menu.Normal and$F<>7Then A:=CurrKrs.Menu.Normal or 7
                                 Else A:=CurrKrs.Menu.Normal;
  If CurrKrs.Menu.Normal shr 4=7Then GetAttribut:=A or 8
                                Else GetAttribut:=A;
 End
  Else
 GetAttribut:=CurrKrs.Menu.Normal;
End;

Procedure PutTaskMsg(X,Len:Byte;Curr:Boolean;Const Msg:String);
Var
 A:Byte;
 H:Byte; { Hauteur de la ligne de caractŠre }
 G:GraphBoxRec;
Begin
 A:=GetAttribut(Curr);
 H:=GetMaxYPixelsTaskBar-GetRawY(YTaskMnu);
 If(Not Curr)and(H>=16)Then Begin
  G.X1:=X shl 3;
  G.Y1:=GetRawY(YTaskMnu);
  PutFillBox(G.X1,G.Y1+1,G.X1+(Len shl 3)-1,G.Y1+H-1,A shr 4);
  OutTxtXY(G.X1,G.Y1+((H-16)shr 1),Left(Msg,Len),A and $F)
 End
  Else
 Begin
  If(IsWindowsXPLook)Then Begin
   PutSmlTxtXYT(X,YTaskMnu,Left(Msg,Len),A);
  End
   Else
  PutSmlTxtXY(X,YTaskMnu,Left(Msg,Len),A);
 End;
End;

{ Cette fonction r‚gularise le canal de couleur de fa‡on … ce qu'il ne
 soit pas affect‚ par des valeurs ab‚rante, c'est-…-dire que les valeurs
 sup‚rieurs … 255 ou inf‚rieur … 0 sont normalis‚es.
}

Function RegularizeCanalColor(Color:Integer):Byte;Begin
 If Color<0Then RegularizeCanalColor:=0 Else
 If Color>255Then RegularizeCanalColor:=255
             Else RegularizeCanalColor:=Color;
End;

{ Cette proc‚dure affiche toute la barre de tƒche en fonction de toutes
 les attributs courant des applications.
}

Procedure PutOpenWin;
Var
 I:RBP;
 W:^WindowApp;
 A,Attr,X,Max,NB,IX,MO:Byte;
 G:GraphBoxRec;
 Color:Word;
 RGBColor:RGB;

 Procedure PutCDBoard;
 Var
  B,IX,XM:Byte;
 Begin
  If PutTaskIcon(X,wnCDPlayer,False)Then IX:=2
                                    Else IX:=0;
  B:=GetAttribut(True);
  XM:=GetMaxXTaskBar(I);
  PutSmlTxtXY(XM-4,YTaskMnu,#16'ş<>',B);
  BarSpcHorRelief(XM-4,YTaskMnu,XM-4,B);
  BarSpcHorRelief(XM-3,YTaskMnu,XM-3,B);
  BarSpcHorRelief(XM-2,YTaskMnu,XM-2,B);
  BarSpcHorRelief(XM-1,YTaskMnu,XM-1,B);
  If Max>IX+6Then
   PutTaskMsg(X+1+IX,Max-6-IX,No,HTitleInLst(Windows,Max-6-IX,I));
 End;

Begin
 If Not(TaskBar.Visible)Then Exit;
 Attr:=CurrKrs.Menu.Normal;
 If(IsGrf)Then Begin
  G.X1:=0;
  G.Y1:=GetRawY(YTaskMnu);
  G.X2:=Pred(Succ(TaskBar.MaxX)shl 3);
  G.Y2:=GetMaxYPixelsTaskBar;
  Color:=Attr shr 4;
  If(IsWindowsXPLook)Then Begin
   Color2RGB(GetClassicToColor(Color),RGBColor);
   If RGBColor.R+$20>255Then Dec(RGBColor.R,$20);
   If RGBColor.G+$20>255Then Dec(RGBColor.G,$20);
   If RGBColor.B+$20>255Then Dec(RGBColor.B,$20);
   Color:=RGB2Color(RegularizeCanalColor(RGBColor.R+$20),
                    RegularizeCanalColor(RGBColor.G+$20),
                    RegularizeCanalColor(RGBColor.B+$20));
  End;
  PutFillBox(G.X1,G.Y1,G.X2,G.Y2,Color);
  If(IsWindowsXPLook)Then Begin
   For I:=0to 7do Begin
    PutLnHor(G.X1,G.Y1,G.X2,RGB2Color(RegularizeCanalColor(RGBColor.R-$20+I shl 3),
                                      RegularizeCanalColor(RGBColor.G-$20+I shl 3),
                                      RegularizeCanalColor(RGBColor.B-$20+I shl 3)));
    Inc(G.Y1);
   End;
   For I:=0to 1do Begin
    PutLnHor(G.X1,G.Y2,G.X2,RGB2Color(RegularizeCanalColor(RGBColor.R-$20+I shl 6),
                                      RegularizeCanalColor(RGBColor.G-$20+I shl 6),
                                      RegularizeCanalColor(RGBColor.B-$20+I shl 6)));
    Dec(G.Y2);
   End;
  End;
  If(CountryIconOnStatus)Then PutTaskIcon(TaskBar.MaxX+1,icnCountry,False);
  If(SoundIconOnStatus)Then PutTaskIcon(TaskBar.MaxX+1+(Byte(CountryIconOnStatus)*3),icnSound,False);
 End
  Else
 BarSpcHor(0,YTaskMnu,TaskBar.MaxX,Attr);
 If Windows.Lst.Count=0Then Begin
  If(RegUserName=NIL)Then PutTxtXYUnKr(2,YTaskMnu,'[Non-enregistr‚e]')
                     Else PutTxtXYUnKr(2,YTaskMnu,StrPas(RegUserName));
  PutTaskBarRelief(0,TaskBar.MaxX);
  Exit;
 End;
 If Not(IsGrf)Then SetChr(TaskBar.MaxX+1,YTaskMnu,'³');
 NB:=Windows.Lst.Count;
 If NB>9Then NB:=9;
 Max:=TaskBar.MaxX div NB;X:=0;
 For I:=0to NB-1do Begin
  W:=_ALGetBuf(Windows.Lst,I);
  A:=GetAttribut(I=Windows.Curr);
  MO:=_GetModelIcon(W^);
  If I=Windows.Lst.Count-1Then Begin
   If(I<>Windows.Curr)and(IsGrf)and(W^.Model=wnCDPlayer)Then PutCDBoard
    Else
   Begin
    IX:=0;
    If PutTaskIcon(X,MO,I=Windows.Curr)Then IX:=2;
    PutTaskMsg(X+1+IX,TaskBar.MaxX-X-1-IX,I=Windows.Curr,HTitleInLst(Windows,Max-2-IX,I));
   End;
   If(IsGrf)Then Begin
    PutTaskBarRelief(X,TaskBar.MaxX);
    If(I=Windows.Curr)Then Begin
     BarSpcHorReliefExt(X+1,YTaskMnu,TaskBar.MaxX-1,Attr);
    End;
   End
    Else
   Begin
    SetChr(X,YTaskMnu,'³');
    If(I=CurrEdit)Then SetChr(TaskBar.MaxX,YTaskMnu,'<');
   End;
  End
   Else
  Begin
   If(IsGrf)Then Begin
    PutTaskBarRelief(X,X+Max-1);
    If(I=Windows.Curr)Then Begin
     BarSpcHorReliefExt(X+1,YTaskMnu,X+Max-2,Attr);
    End;
   End
    Else
   Begin
    SetChr(X,YTaskMnu,'³');
    If(I=CurrEdit)Then SetChr(X+Max-1,YTaskMnu,'<');
   End;
   If(I<>Windows.Curr)and(IsGrf)and(W^.Model=wnCDPlayer)Then PutCDBoard
    Else
   Begin
    IX:=0;
    If PutTaskIcon(X,MO,I=Windows.Curr)Then IX:=2;
    PutTaskMsg(X+1+IX,Max-2-IX,I=Windows.Curr,HTitleInLst(Windows,Max-2-IX,I));
    If(DesktopIconOnStartMode)and(MO=icnStart)Then PutTaskIcon(X+Max-3,icnDesktop,No);
   End;
  End;
  Inc(X,Max);
 End;
End;

Function IsProgramsManager:Boolean;
Var
 PM:^ProgramsManagerApp;
Begin
 PM:=HPtr(Windows);
 IsProgramsManager:=(HModel(Windows)=wnProgMan)and(Pos('PROGMAN',PM^.Path)>0);
End;

Procedure TaskMenuIcon(X,Y:Byte;Level:Word);Far;Begin
 If(IsProgramsManager)Then Inc(Y,2);
 ZoomIcon(X,Y,$F);
 PutTaskBarIcon(X,Y+1,$F);
 CloseIcon(X,Y+6,$F);
End;

Const
 w95Len=24;

Procedure Win95MenuIcon(X,Y:Byte;Level:Word);Far;
Var
 GX,GY,Nm:Word;
 J:Byte;

 Procedure PutIconModel(Model,P:Byte);
 Var
  Path:String;
 Begin
  If Not(MediaSupport)Then Exit;
  If(Model>wnMI)Then Exit;
  If IconBnk[Model].Output=$FFThen Begin
   Path:=IconName(Model);
   If Path<>''Then Begin
    RILoadImage(Path,diAutoDetect,0,$FFFF,rmAllResSteady,[],IconBnk[Model]);
   End;
  End;
  If IconBnk[Model].Output<>$FFThen Begin
   GY:=GetRawY(Y+P);
   RIPutImageScale(IconBnk[Model],GX,GY,w95Len,HeightChr,
                   CurrKrs.Menu.Normal shr 4);
  End;
 End;

Begin
 GX:=X shl 3;
 Case(Level)of
  0:Begin { Menu Windows 9X }
   PutIconModel(icnNewDoc,0);
   PutIconModel(icnFind,1);
   PutIconModel(icnFolder,3);
   PutIconModel(icnFolder,4);
   PutIconModel(icnParam,5);
   PutIconModel(icnFolder,6);
   PutIconModel(icnFind,7);
   PutIconModel(icnHelp,8);
   PutIconModel(icnExec,9);
   PutIconModel(icnExit,11);
  End;
  352:Begin { Programmes }
   Nm:=WinPtr^.P.ProgMan.ML.Count;
   For J:=0to(Nm)do PutIconModel(icnFolder,J);
   PutIconModel(icnExplorer,1+Nm);
   PutIconModel(wnPrmpt,2+Nm);
  End;
  416:Begin { ParamŠtres }
   PutIconModel(icnControl,0);
   PutIconModel(icnControl,1);
   PutIconModel(icnPrinter,2);
   PutIconModel(wnEdit,6);
   If(TaskBar.App7IlesRC)Then PutIconModel(wnEdit,7);
  End;
  448:Begin
   PutIconModel(icnControl,0);
  End;
  480:Begin { Menu Recherche }
   PutIconModel(icnCleanMgr,7);
   PutIconModel(icnBesch,9);
  End;
  Else Begin
   If Level and 512=512Then Begin
    PMWPutIconVert({ProgramsManager(HPtr(Windows)^)}WinPtr^.P.ProgMan,(Level and Not(512))shr 5,GX,
                  GetRawY(Y),w95Len,HeightChr,CurrKrs.Menu.Normal shr 4);
   End;
  End;
 End;
End;

Function OnContextWin9X(Code:Word):Boolean;
Var
 Document:HistoryDocument;
 LastDoc:History;
Begin
 OnContextWin9X:=False;
 Case(Code)of
  w9Favorite:Begin { Effacer tous }
   Case RunMenuApp(134)of
    $F101:Begin
     FillClr(Document,SizeOf(Document));
     HYInitTo(LastDoc,512,@Document.History);
     SaveHistoryDocument(Document);
     OnContextWin9X:=True;
    End;
    kbMouse:WaitMouseBut0;
   End;
  End;
 End;
End;

Procedure MenuVolume;Begin
 Case RunMenuApp(95)of
  $F001:SetSonVolume;
  $F002:SetWindows9X;
  $F003:RunCDPlayer;
  kbMouse:WaitMouseBut0;
 End;
End;

Function MenuTaskBar:Word;
Var
 CM:ContextMenu;
 TM:MainMnuPtr;
 PL:Record
  StartMode:Boolean;
  StartModeSwitch:Pointer;
  IsGraf:Boolean;
 End;
 PM:^ProgramsManagerApp;
Begin
 FillClr(PL,SizeOf(PL));
 PM:=HPtr(Windows);
 PL.StartMode:=IsProgramsManager;
 If(PL.StartMode)Then Dec(LastMouseY,2);
 PL.StartModeSwitch:=@PM^.Mode;
 PL.IsGraf:=IsGrf;
 _CMLoadApp(CM,113,PL);
 ALSetPtr(MainMenu.Mnu,0);
 If(IsGrf)Then Begin
  MainMenu.Space4Icon:=2;
  MainMenu.IconRoutine:=TaskMenuIcon;
 End;
 TM:=_ALGetCurrBuf(MainMenu.Mnu);
 MenuTaskBar:=PMExecMnu(LastMouseX,LastMouseY-9,TM^.Lst,TM^.P);
 CMDone(CM);
End;

Procedure BadDistribution;Begin
 ErrNoMsgOk(errNotFoundInDistribution);
End;

Procedure ShutDown;Begin
 Case(ExitMethod)of
  0,2,3:PushKey(mbFileExit);
  1:HClose(Windows);
  4:RunScrnSaver;
 End;
End;

Procedure Win9XMenu(X:Byte);
Var
 P:Word;
 K:Word;
 Max:SmallInt;
 I:Byte;
 TM:MainMnuPtr;
 CM:ContextMenu;
 FormMenu:Record
  App7Iles:Boolean;
  App7IlesRebuild:Boolean;
  Group:Array[0..9]of PullSubMnu;
  LD:Array[0..512]of Char;
 End;
 LastDoc:History;
 Document:HistoryDocument;
 App7Iles:String;
Begin
 FillClr(FormMenu,SizeOf(FormMenu));
 App7Iles:=FSearch('APP7ILES.RC',';'+MaltePath+';'+StrPas(PathSystems));
 TaskBar.App7IlesRC:=App7Iles<>'';
 FormMenu.App7Iles:=TaskBar.App7IlesRC;
 FormMenu.App7IlesRebuild:=TaskBar.App7IlesRC;
 __CMInit(CM);
 MainMenu.OnContext:=OnContextWin9X;
 If({HModel(Windows)}WinPtr^.Model=wnProgMan)Then Begin
  Max:={ProgramsManager(HPtr(Windows)^)}WinPtr^.P.ProgMan.ML.Count-1;
  If Max>=0Then Begin
   If Max>9Then Max:=9;
   For I:=0to(Max)do Begin
    PMWMakeGroupMenu({ProgramsManager(HPtr(Windows)^)}WinPtr^.P.ProgMan,I,FormMenu.Group[I]);
   End;
  End;
  PMWMakeOngletMenu({ProgramsManager(HPtr(Windows)^)}WinPtr^.P.ProgMan,CM.SubMenu[0],FormMenu.Group);
 End
  Else
 Inc(LastMouseY);
  { Compilation des derniers documents consult‚s...}
 LoadHistoryDocument(LastDoc,Document);
 LastDoc.Ptr:=LastDoc.Tail;P:=0;
 While Pointer(LastDoc.Ptr)<>Pointer(LastDoc.Cmd)do Begin
  Dec(PtrRec(LastDoc.Ptr).Ofs);
  Dec(PtrRec(LastDoc.Ptr).Ofs,Length(LastDoc.Ptr^)+1);
  If P+Length(LastDoc.Ptr^)>512Then Break;
  StrPCopy(@FormMenu.LD[P],LastDoc.Ptr^);
  If(Length(LastDoc.Ptr^)<>0)and(Length(LastDoc.Ptr^)<MaxXTxts-5)Then Begin
   SMAddFullItem(CM.SubMenu[1],@FormMenu.LD[P],kbNoKey,$E000+P,NIL,@FormMenu.LD[P]);
  End;
  Inc(P,Length(LastDoc.Ptr^)+1);
 End;
 __CMLoad(CM,'APP7ILES.*',133,FormMenu);
 ALSetPtr(MainMenu.Mnu,0);
 If(IsGrf)Then Begin
  MainMenu.Space4Icon:=w95Len shr 3;
  MainMenu.IconRoutine:=Win95MenuIcon;
 End;
 TM:=_ALGetCurrBuf(MainMenu.Mnu);
 K:=PMExecMnu(X,MaxYTxts-14-Byte(HelpBar),TM^.Lst,TM^.P);
 CMDone(CM);
 Case(K)of
  kbMouse:WaitMouseBut0;
  w9NewDoc:RunApp(pmwWrite);
  w9OpenDoc:RunApp(pmwOpenWrite);
  w9Explorer:FileExplorer;
  w9ShellDos:RunApp(pmwShellDos);
  w9Control:RunApp(pmwControl);
  w9EditMenu:Begin
   PushKey(kbTab);
   SetWindows9X;
  End;
  w9Printers:RunApp(pmwPrintMan);
  w9FindVerb:Begin
   {$IFDEF Educative}
    InputSearchVerb;
   {$ELSE}
    BadDistribution;
   {$ENDIF}
  End;
  w9Help:HelpOnline;
  w9Run:Execute;
  w9Ext:ExtensiorEditor;
  w9Exit:ShutDown;
  $E000..$E000+512:Begin
   OpenSelection(StrPas(@FormMenu.LD[K-$E000]),0);
  End;
  $F200..$FFFF:RunApp(PMWExecCmd(WinPtr^.P.ProgMan,K));
  w9FileMalteIni:OpenFile(MaltePath+MB_INI);
  w9FileApp7Iles:OpenFile(App7Iles);
  w9FindFiles:HNew(Windows,wnSearchFiles);
  w9FindPerson:FindPerson;
  w9SpaceWizard:CleanCurrDisk;
  w9AssistantConfig:AssistantConfig;
  w9FindCity:Begin
   {$IFDEF Educative}
    SearchCity;
   {$ELSE}
    BadDistribution;
   {$ENDIF}
  End;
  w9DataBaseChantal:OpenDataBase(MaltePath+'DATA\CHANTAL.DAT');
  w9FindCountry:Begin
   {$IFDEF Educative}
    SearchCountry;
   {$ELSE}
    BadDistribution;
   {$ENDIF}
  End;
  w9CheckMouse:CheckMouse;
  w9CheckPCI:InfoPCI;
  w9CompileApp7Iles:MakeRLLFile(App7Iles,NIL);
  w9RegEdit:RegistryEditor;
  w9ModemDoctor:ModemDoctor;
  w9IPConfig:ShowIPConfig;
 End;
 SetMnuSwitch;
End;

Procedure SwitchTaskBar;
Var
 NB:RBP;
 I,X,Max,OldCurr:Byte;
 Win:HWins;
 K:Word;
 XM:Byte; { Coordonn‚e maximal }

 Procedure ActiveTask;
 Label Restart;
 Var
  MS:ImgRec;
  Q:^TaskBarManager;
  Graphic:Boolean;
 Begin
  ALSetPtr(Win.Lst,CurrEdit);
  Win.CurrModel:=_ALGetCurrBuf(Win.Lst);
  Q:=HPtr(Win);
  If(Q<>NIL)Then Begin
   __HideMousePtr;
   Graphic:=IsGrf;
   If(Graphic)Then Begin
    PushScr(MS);
    PopScr(Output);
   End;
   TMSwitchTo(Q^.Index);
   If(Graphic)Then Begin
    PushScr(Output);
    PopScr(MS);
   End;
   UpdateTaskBar;
   __ShowMousePtr;
  End;
 End;

Begin
 Win:=Windows;NB:=Win.Lst.Count;
 If NB=0Then Exit;
 __HideMousePtr;
 WaitMouseBut0;
 If NB>9Then NB:=9;
 Max:=TaskBar.MaxX div NB;
 X:=0;
 OldCurr:=Windows.Curr;
 CurrEdit:=Windows.Curr;
 ALSetPtr(Win.Lst,0);
 For I:=0to NB-1do Begin
  WinPtr:=_ALGetCurrBuf(Win.Lst);
  If I=Win.Lst.Count-1Then CurrEdit:=I
   Else
  If(LastMouseX>=X)and(LastMouseX<=X+Max-1)Then Begin
   CurrEdit:=I;
   Break;
  End;
  Inc(X,Max);
  ALNext(Win.Lst);
 End;
 If NB=1Then X:=0;
 Case(LastMouseB)of
  2:If Windows.Lst.Count>0Then Begin
   XM:=GetMaxXTaskBar(CurrEdit);
   If(DesktopIconOnStartMode)and(LastMouseX>=XM-2)Then Begin
    WaitMouseBut0;
    SetWindows9X;
   End
    Else
   Begin
    If(Windows.Lst.Count>1)and(WinPtr^.Model=wnProgMan)and
      (WinPtr^.P.ProgMan.Mode=mWin9X)Then HGotoNum(Windows,CurrEdit);
    K:=MenuTaskBar;
    Case(K)of
     stStartMode:StartMode;
     stClose:Begin
      HClose(Windows);
      SetMnuSwitch;
     End;
     stMaximise:Zoom;
     stRefresh:HRefresh(Windows);
     stInTaskBar:HInTaskBar(Windows);
     stTaskManager:TaskDialog(Windows);
     kbMouse:WaitMouseBut0;
    End;
   End;
  End;
  Else If Windows.Lst.Count>0Then Begin
   XM:=GetMaxXTaskBar(CurrEdit);
   If(OldCurr<>CurrEdit)and(WinPtr^.Model=wnCDPlayer)and(LastMouseX>=XM-4)Then Begin
    HoleMode:=True;
    CDCheck(WinPtr^.P.CD);
    Case LastMouseX-(XM-4)of
     0:CDPlayPause(WinPtr^.P.CD);
     1:CDStop(WinPtr^.P.CD);
     2:CDPrevTrack(WinPtr^.P.CD);
     3:CDNextTrack(WinPtr^.P.CD);
    End;
    HoleMode:=False;
   End
    Else
   If(DesktopIconOnStartMode)and(LastMouseX>=XM-2)Then Begin
    WaitMouseBut0;
    MinimiseAllWindows;
   End
    Else
   If(WinPtr^.Model=wnTaskBarMgr)Then ActiveTask Else
   If((OldCurr=CurrEdit)and(IsProgramsManager))or
     ((WinPtr^.Model=wnProgMan)and(WinPtr^.P.ProgMan.Mode=mWin9X)and
     (Pos('PROGMAN',WinPtr^.P.ProgMan.Path)>0))Then Win9XMenu(X)
    Else
   Begin
    WaitMouseBut0;
    HGotoNum(Windows,CurrEdit);
    SetMnuSwitch;
   End;
  End
   Else
  Win9XMenu(X);
 End;
 __ShowMousePtr;
End;

Procedure UpdateStatusBar;Begin
 If Not(TaskBar.Visible)Then Exit;
 PBLastLen:=$FFFF;
 BarSpcHor(TaskBar.MaxX+1,YTaskMnu,MaxXTxts,CurrKrs.Menu.Normal);
 PutBarStatusMemory;
 If(CountryIconOnStatus)Then PutTaskIcon(TaskBar.MaxX+1,icnCountry,False);
 If(SoundIconOnStatus)Then PutTaskIcon(TaskBar.MaxX+1+Byte(CountryIconOnStatus)*3,icnSound,False);
End;

Procedure MemoryMenu;
Label
 LabelChangeCountry;
Const
 mmNumericProgressBar=$F001;
 mmGraph=$F002;
 mmMemoryInfo=$F003;
 mmTaskManager=$F004;
Var
 PL:Boolean;
 X:SmallInt;
Begin
 WaitMouseBut0;
 __HideMousePtr;
 X:=Byte(CountryIconOnStatus)*3;
 If X>0Then Dec(X);
 If(CountryIconOnStatus)and(LastMouseX>=TaskBar.MaxX+1)and(LastMouseX<=TaskBar.MaxX+3)Then Begin
  If LastMouseB=2Then Begin
   Case RunMenuApp(149)of
    $F001:Goto LabelChangeCountry;
    $F002:ChangeLanguage;
    $F003:SetWindows9X;
    $F004:CountryInfo;
   End;
  End
   Else
  Begin
LabelChangeCountry:
   ChangeCountry;
   XFreeMem(IconBnk[icnCountry]);
  End;
  UpdateStatusBar;
 End
  Else
 If(SoundIconOnStatus)and(LastMouseX>=TaskBar.MaxX+1+X)and(LastMouseX<=TaskBar.MaxX+4+X)Then Begin
  If LastMouseB=2Then Begin
   MenuVolume;
   UpdateStatusBar;
  End
   Else
  SetSonVolume;
 End
  Else
 If LastMouseB=2Then Begin
  PL:=MemoryModel=mmNumber;
  Case _RunMenuApp(22,PL)of
   mmNumericProgressBar:Begin
    If(MemoryModel=mmNumber)Then MemoryModel:=mmProgressBar
                            Else MemoryModel:=mmNumber;
    UpDateStatusBar;
    SaveIni;
   End;
   mmGraph:GraphResource;
   mmMemoryInfo:MemInfo;
   mmTaskManager:TaskDialog(Windows);
   kbMouse:WaitMouseBut0;
  End;
 End
  Else
 GraphResource;
 __ShowMousePtr;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ·}
{³          R o u t i n e   p o u r   q u i t t e r            º}
{ÔÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼}

Function SetAPMMode(Mode:Word):Boolean;Assembler;ASM
  { Connecter l'interface RM }
 MOV AX,5301h
 XOR BX,BX
 INT 15h
  { Active le pilote APM 1.1 }
 MOV AX,530Eh
 XOR BX,BX
 MOV CX,0101h
 INT 15h
  { Active l'APM }
 MOV AX,5308h
 MOV BX,1
 MOV CX,BX
 INT 15h
  { Demande la mode sp‚cifier }
 MOV AX,5307h
 mov BX,1
 MOV CX,Mode
 INT 15h
 MOV AL,0
 JC  @Error
 MOV AL,Ya
 JMP @End
@Error:
 MOV Byte Ptr SysErr,AH
 MOV Byte Ptr SysErr[1],03h
@End:
END;

{ Cette proc‚dure d‚sactive le signal envoy‚e au moniteur.
}

Procedure ScreenOff;Near;Begin
 Port[$3c4]:=1;               {Register 1 des TS (TS Mode)}
 Port[$3c5]:=Port[$3c5]or 32; {Bit 5 (Screen Off)}
End;

Procedure ScreenOn;Near;Begin
 Port[$3c4]:=1;                     {Register 1 des TS (TS Mode)}
 Port[$3c5]:=Port[$3c5] and not 32; {Bit 5 (Screen On)}
End;

Procedure WaitActionUser;Near;Begin
 ClrKbd;
 ResetMouseMove;
 Repeat Until(MouseMove)or(KeyPress);
 If(KeyPress)Then ReadKey;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Fonction ExitMethod                           Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction retourne la fa‡on dont l'utilisateur d‚sir quitter le menu
 de Windows 9X.
}

Function ExitMethod:Byte;
Var
 Data:Record
  APM:Boolean;
  CurrMode:Byte;
  CurrMode2:Byte;
 End;
Begin
 ExitMethod:=$FF;
 FillClr(Data,SizeOf(Data));
 ASM
  MOV AX,5300h
  XOR BX,BX
  INT 015h
  JC  @Exit
  MOV Data.APM,Ya
@Exit:
 END;
 If ExecuteAppDPU(40,Data)Then Begin
  If Not(Data.APM)Then Data.CurrMode:=Data.CurrMode2;
  ExitMethod:=Data.CurrMode;
  Case(Data.CurrMode)of
   2:ExitLevel:=xlRestart;
   3:ExitLevel:=xlBoot;
   5..7:If Not(Data.APM)Then Begin
    ScreenOff;
    WaitActionUser;
    ScreenOn;
   End
    Else
   Begin
    If Data.CurrMode=8Then SaveAll;
    If Not SetAPMMode(Data.CurrMode-4)Then Case(SysErr)of
     errPMFunctionalityDisabled,
     errRMInterfaceAlreadyEstablished,
     errInterfaceNotConnected,
     err16bitPMmodeInterfaceAlewadyEstablished,
     errUnrecognisedDeviceID,
     errUnable2EnterRequestedState:ErrNoMsgOk(SysErr);
     Else ErrNoMsgOk(errProblemMode);
    End;
   End;
  End;
 End;
End;

Procedure DefEndBar;Begin
 SetAllKr($1B,$1F);
 Case HModel(Windows)of
  wnSuperCalc:
  WEPutLastBar('^F2^ Sauve  ^F3^ Ouvre  ^Alt+F3^ Ferme  ^F9^ Calcule');
  wnFileManager:If(FileManagerApp(HPtr(Windows)^).NortonCommander)Then
   WEPutLastBar('^F1^ Aide')
  Else
   WEPutLastBar('^F3^ Edite  ^Shift+F4^ Regarde  ^F5^ Copie  ^F9^ Renomme/Mouve  ^F7^ Cr‚e R‚peroire');
  wnEdit:Case(EditorApp(HPtr(Windows)^).Mode)of
   vtGat,vtHlp,vtDefault:WEPutLastBar('^F1^ Aide  ^F2^ Sauvegarder  ^F3^ Ouvrir un fichier  ^Alt+F3^ Fermer la fenˆtre');
   vtBas:WEPutLastBar('^F1^ Aide (si curseur sur un mot) ^F2^ Sauvegarde  ^F3^ Ouvrir  ^Alt+F3^ Ferme  ^Alt+F9^ Ex‚cute');
   Else WEPutLastBar('^F2^ Sauvegarde  ^F3^ Ouvre  ^Alt+F3^ Ferme  ^Alt+F9^ Compile  ^Ctrl+F9^ Ex‚cute');
  End;
  wnMnu:
  WEPutLastBar('^Enter^ Change de r‚pertoire/L''ex‚cute  ^BackSpace^ Revenir  ^Esc^ Sortir');
  wnDebug:WEPutLastBar('^F7^ Trace  ^F8^ Ex‚cute l''instruction');
  wnProgMan:Begin
   If(ProgramsManagerApp(HPtr(Windows)^).Mode=mWin9X)Then
    WEPutLastBar('Appuyez sur la barre ®D‚marrer¯ pour acc‚der au menu d''application')
   Else
    WEPutLastBar('Appuyez sur les ic“nes et les onglets appropri‚s pour effectuer une action...');
  End;
  wnHexView:;
  wnFileListBox:
  WEPutLastBar('Entrez le r‚pertoire et le nom du fichier d‚sir‚...');
  Else
  WEPutLastBar('^F1^ Aide  ^F3^ Ouvre  ^Shift+F3^ Ouvre document  ^Ctrl+F3^ Gestionnaire de Fichiers');
 End;
 PutOpenWin;
End;

Procedure DelSel;
Label KillFile;
Var
 FM:^FileManagerApp;
 S,ST:String;
 W:Window;
 X:SearchRec;
 NB:LongInt;
 H:History;
 History:Record
  Len:Word;
  EndCmd:Word;
  Buffer:Array[0..511]of Byte;
 End;
Begin
 S:='';
 FM:=HPtr(Windows);
 HYInitTo(H,512,@History.Buffer);
 If(MainRegistryExist)Then Begin
  If ReadMainKey(HKEY_CURRENT_USER,'Software\FilesManager\History','SelectDelete',History)Then Begin
   HYSetSizeBuffer(H,History.EndCmd);
  End;
 End;
 If(WinInpH(40,'Effacer','Nom du/des fichier(s)',
            CurrKrs.Dialog.Window,False,S,H,False)=kbYes)Then Begin
  History.Len:=SizeOf(History)-2;
  History.EndCmd:=HYGetSizeBuffer(H);
  CreateKeyFormat(HKEY_CURRENT_USER,'Software\FilesManager\History','SelectDelete',tdBlob,History);
  S:=StrUp(S);
  If IsWildCard(S)Then Begin
   If(ErrMsg('Etes-vous certains de vouloirs effacer tous les '+
             'fichiers correspondant … ®'+S+'¯?',KeyYes+KeyNo)=kbYes)Then Begin
    NB:=0;
    If Path2Dir(S)=''Then Begin
     S:=Path2Dir(FMGetPath(FM^))+S;
    End;
    FindFirst(S,faAll,X);
    If GetSysErr<>0Then __FileNotFound(S)
     Else
    While GetSysErr=0do Begin
     ST:=Path2Dir(S)+X.Name;
     WEInitO(W,Omega(20,Length(ST)+2),5);
     WEPushWn(W);
     WEPutWnKrDials(W,'');
     WEPutTxtLn(W,'Efface le fichier:');
     WEPutTxtLn(W,ST);
     If(sfaReadOnly)in(X.Attr.Flags)Then Begin
      If(ErrMsg('Fichier Prot‚g‚! Etes-vous vraiment certain de vouloir effacer ®'+X.Name+'¯ ?',KeyYes+KeyNo)=kbYes)Then Begin
       FileSetAttr(ST,faArchive);
       Goto KillFile;
      End;
     End
      Else
     KillFile:DeleteFile(ST);
     WEDone(W);
     If GetSysErr<>0Then Begin
      ErrNoMsgOk(GetSysErr);
      Break;
     End;
     FindNext(X);
     Inc(NB);
    End;
    If NB=0Then ErrNoMsgOk(NoFileSelectFound)
           Else DialogMsgOk(CStr(NB)+' fichier(s) effac‚es!');
   End;
   If(HModel(Windows)=wnFileManager)Then
    FMRefresh(FM^,True)
  End
   Else
  DeleteFile(S);
 End;
 HYDone(H);
End;

Procedure Delete;Begin
 If(HModel(Windows)=wnFileManager)Then
  FMDeleteFiles(FileManagerApp(HPtr(Windows)^))Else DelSel;
End;

{ Cette fonction demande le nom du r‚pertoire … cr‚er et le retourne le
 paramŠtre ®Name¯.
}

Function QuestionMakeDir(Var Name:String):Word;Near;Begin
 QuestionMakeDir:=_WinInp(50,'Cr‚e R‚pertoire','Entrez le nom du r‚pertoire … cr‚er:',False,Name);
End;

{ Cette proc‚dure permet d'ex‚cuter une commande de cr‚ation de r‚pertoire.
}

Procedure MakeDirectory;
Var
 FM:^FileManagerApp;
 Path,Name:String;
Begin
 Name:='';
 FM:=HPtr(Windows);
 If(HModel(Windows)=wnFileManager)Then Begin
  Path:=SetPath4AddFile(Path2Dir(FMGetPath(FM^)));
  If(QuestionMakeDir(Name)=kbYes)Then Begin
   If(Pos('\',Name)or Pos(':',Name))=0Then Name:=Path+Name;
   MkDir(Name);
   FMReadFiles(FM^,FM^.Plane);
  End
 End
  Else
 If(QuestionMakeDir(Name)=kbOk)Then MkDir(Name);
End;

Procedure NewDrw;Begin
 If HNew(Windows,wnDraw)Then SetMnuSwitch;
 PutFreeMemory;
End;

Procedure _NewEdt;Begin
 HNew(Windows,wnEdit);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure NewEdt                            Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure ouvre un nouveau texte de format ASCII. Il est donc de
 format compatible avec le DOS.
}

Procedure NewEdt;Begin
 _NewEdt;
 SetMnuSwitch;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure NewGat                            Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet … l'utilisateur d'ouvrir un nouveau document de
 traŒtement de texte du format GAT.
}

Procedure NewGat;
Var
 Editor:^EditorApp;
Begin
 _NewEdt;
 Editor:=HPtr(Windows);
 TESetViewMode(Editor^,vtGat);
 Editor^.SheetFormat.X1:=10;
 Editor^.SheetFormat.X2:=70;
 Editor^.SheetFormat.Y1:=6;
 Editor^.SheetFormat.Y2:=60;
 TESetFormat(Editor^);
 SetMnuSwitch;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Proc‚dure OpenX                             Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet l'ouverture d'un ou la cr‚ation d'un fichier texte
 de format sp‚cifi‚ par la variable ®Mode¯ de ces param‚trages.
}

Procedure OpenX;
Label 1;
Const
 All:Array[0..Length('*.*')]of Char='*.*'#0;
Var
 App:Pointer;
 FileManager:^FileManagerApp Absolute App;
 GlobalDraw:^GlobalDrawApp Absolute App;
 PPath,PExt:PChr;
 X1,Y1,X2,Y2:Byte;
 Path,Title:String;
 TPath:Array[Byte]of Char;
 PL:^FileListBox;
Begin
 App:=HPtr(Windows);
 If Mode=255Then Begin
  Case HModel(Windows)of
   wnGlobalDraw:Path:=GDGetCurrName(GlobalDraw^);
   Else Path:=FMGetCurrName(FileManager^);
  End;
  If Path=''Then Begin
   StrPCopy(@TPath,Path2Dir(FMGetPath(FileManager^)));
   PPath:=@TPath;PExt:=@All;
   Goto 1
  End;
 End
  Else
 Begin
  PPath:=NIL;PExt:=NIL;
  Case(Mode)of
   vtDefault:PExt:=@All;
   vtAda:Begin
    PPath:=PathAda;
    PExt:=@All;
   End;
   vtAsm:Begin
    PPath:=PathAsm;
    PExt:=ExtAsm;
   End;
   vtBas:Begin
    PPath:=PathBas;
    PExt:=ExtBas;
   End;
   vtC:Begin
    PPath:=PathC;
    PExt:=ExtC;
   End;
   vtCobol:Begin
    PPath:=PathCobol;
    PExt:=PChr(PChar('*.CBL'));
   End;
   vtEuphoria:Begin
    PPath:=PathEuphoria;
    PExt:=ExtEuphoria;
   End;
   vtForth:Begin
    PPath:=PathForth;
    PExt:=@All;
   End;
   vtFortran:Begin
    PPath:=PathFortran;
    PExt:=ExtFortran;
   End;
   vtIni:PExt:=ExtIni;
   vtMsMnu:PExt:=ExtMsMnu;
   vtPas:Begin
    PPath:=PathPas;
    PExt:=ExtPas;
   End;
   vtPW:PExt:=@All;
   vtRC:Begin
    PPath:=PathResource;
    PExt:=ExtRC;
   End;
   vtGAT:Begin
    PPath:=PathGat;
    PExt:=PChr(PChar('*.GAT;*.DOC;*.RTF'))
   End;
   vtAC:PExt:=PChr(PChar('*.AC'));
   vtMacro:Begin
    PPath:=PathMac;
    PExt:=PChr(PChar('*.MAC'))
   End;
   $80:PExt:=PChr(PChar('*.COM;*.EXE'));
  End;
1:If(PPath=NIL)Then Path:=''
               Else Path:=SetPath4AddFile(StrPas(PPath));
  Case(Mode)of
   $80:Title:='Ouvre un programme';
   vtGat:Title:='Ouvre un document';
   Else Title:='Ouvre Fichier';
  End;
{  Path:=_OpenWinAllModel(Path+StrPas(PExt),Title,H);}
  PL:=HNewManual(Windows,wnFileListBox,X1,Y1,X2,Y2);
  If(PL<>NIL)Then Begin
   If(IsGrf)and(MediaSupport)Then Begin
    PutTaskIcon($FF,icnFolder,False);
   End;
   FLInitModel(PL^,Path+StrPas(PExt),Title,H,False,False,False,omAll);
   SetMnuSwitch;
  End;
  Exit;
 End;
 OpenSelection(Path,Mode);
End;

Procedure OpenAC;Begin
 OpenX(vtAC)
End;

Procedure OpenAssembler;Begin
 OpenX(vtAsm)
End;

Procedure OpenBasic;Begin
 OpenX(vtBas)
End;

Procedure OpenBasAppleII;Begin
{ OpenX(vtBasAppleII)}
End;

Procedure OpenBasCK64;Begin
{ OpenX(vtBasCK64)}
End;

Procedure OpenBasCoco3;Begin
{ OpenX(vtBasCoco3)}
End;

Procedure OpenC;Begin
 OpenX(vtC)
End;

Procedure OpenCobol;Begin
 OpenX(vtCobol)
End;

Procedure OpenEuphoria;Begin
 OpenX(vtEuphoria)
End;

Procedure OpenFortran;Begin
 OpenX(vtFortran)
End;

Procedure OpenIni;Begin
 OpenX(vtIni)
End;

{$IFDEF Developpeur}
 Procedure OpenLogo;Begin
  HLoad(Windows,wnLogo,FileName);
  SetMnuSwitch;
 End;
{$ENDIF}

Procedure OpenDataBase;Begin
 HLoad(Windows,wnDataBase,FileName);
 SetMnuSwitch;
End;

Procedure _OpenDataBase;
Var
 Path:String;
Begin
 Path:=_OpenWinModel('*.*','Ouvre une base de donn‚es',H,omBase);
 If Path<>''Then OpenDataBase(Path);
End;

Procedure OpenMacro;Begin
 OpenX(vtMacro)
End;

Procedure OpenPascal;Begin
 OpenX(vtPas)
End;

Procedure OpenRC;Begin
 OpenX(vtRC)
End;

Procedure OpenDebug;Begin
 OpenX($80)
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Proc‚dure OpenEdt                            Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure ouvre un fichier pointer par le gestionnaire de fichier ou
 d‚finit par une boŒte de dialogue manuellement.
}

Procedure OpenEdt;Begin
 If(HModel(Windows)=wnFileManager)Then OpenX(255)
                                  Else OpenX(vtDefault);
End;

Function OpenFile;Begin
 OpenFile:=False;
 HLoad(Windows,wnEdit,FileName);
 If GetSysErr>0Then HClose(Windows)
               Else OpenFile:=True;
 SetMnuSwitch;
End;

Procedure MakeMacro;Begin
 If OpenFile(Path)Then
  TESetViewMode(EditorApp(HPtr(Windows)^),vtMacro)
End;

Function GetPathAllSel(Const Title:String):String;
Begin
 If(HModel(Windows)=wnFileManager)Then Begin
  GetPathAllSel:=FMGetCurrName(FileManagerApp(HPtr(Windows)^));
 End
  Else
 Begin
  GetPathAllSel:=_OpenWin('*.*',Title,H);
 End;
End;

Procedure OpenView;
Var
 FileName:String;
Begin
 Case HModel(Windows)of
  wnFileManager: FileName:=FMGetCurrName(FileManagerApp(HPtr(Windows)^));
  Else FileName:=_OpenWin('','Regarde ASCII',H);
 End;
 If FileName=''Then Exit;
 HLoad(Windows,wnView,FileName);
 SetMnuSwitch;
End;

Procedure Help;
Var
 XModel,X1,Y1,X2,Y2:Byte;
 Name:String;
 PV:^ViewAsciiApp;
Begin
 Name:=MaltePath+Path2Name(FileName)+'.RLL';
 If Not FileExist(Name)Then Name:=FileName;
 Case(HModel(Windows))of
  wnPC:Begin
   Min:=hisPC;
   Max:=hiePC;
  End;
  wnHexView:Begin
   Min:=hisHexView;
   Max:=hieHexView;
  End;
 End;
 PV:=HNewManual(Windows,wnView,X1,Y1,X2,Y2);
 If(PV<>NIL)Then Begin
  VAInit4RLL(PV^,X1,Y1,X2,Y2,Name,Min,Max);
  SetMnuSwitch;
 End;
End;

Procedure OpenHelp(Const FileName,Title:String);
Var
 X1,Y1,X2,Y2:Byte;
 PE:^EditorApp;
Begin
 PE:=HNewManual(Windows,wnEdit,X1,Y1,X2,Y2);
 If(PE<>NIL)Then Begin
  TEOpenSpecialTitle(PE^,X1,Y1,X2,Y2,FileName,Title);
  SetMnuSwitch;
 End;
End;

Procedure OpenMod;Begin End;

Procedure OpenResource;Begin
 OpenX(vtRC)
End;

Procedure OpenText;Begin
 OpenX(vtGAT)
End;

Procedure _OpenSuperCalc;Begin
 If Path<>''Then Begin
  HLoad(Windows,wnSuperCalc,Path);
  If GetSysErr>0Then Begin
   Case(GetSysErr)of
    errEdtFileTooBig,errEdtOpen..errEdtRead:ErrNoMsgOk(GetSysErr);
   End;
   SCDone(SuperCalcApp(HPtr(Windows)^));
   HClose(Windows);
   Dec(CurrEdit);
  End;
  SetMnuSwitch;
 End;
End;

Procedure OpenSuperCalc;
Var
 Path:String;
Begin
 Path:=_OpenWinModel(SetPath4AddFile(StrPas(PathCalc))+'*.*','Ouvre tableur',H,omCalc);
 _OpenSuperCalc(Path);
End;

Procedure OpenTechDraw;
Var
 Path:String;
Begin
 Path:=_OpenWinModel('*.*','Ouvre un dessin technique',H,omTechDraw);
 HLoad(Windows,wnTechDraw,Path)
End;

Procedure OpenWorkShop;
Var
 Path:String;
Begin
 Case HModel(Windows)of
  wnFileManager:Path:=FMGetCurrName(FileManagerApp(HPtr(Windows)^));
  Else Path:=_OpenWin('*.*','Ouvre un programme',H);
 End;
 HLoad(Windows,wnWorkShop,Path)
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Fonction GetNm                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de connaŒtre un valeur num‚rique entr‚e par
 l'utilisateur … l'aide d'une boŒte de dialogue dont le programmeur
 doit sp‚cifier les titres et la question.
}

Function GetNm(Const Title,Msg:String):LongInt;
Var
 Str:String;
 Ok:Boolean;
 Target:LongInt;
 Err,K:Word;
Begin
 GetNm:=0;Ok:=False;Str:='';
 Repeat
  K:=_WinInp(40,Title,Msg,False,Str);
  If(K=kbEsc)Then Exit;
  Val(Str,Target,Err);
  Ok:=Err=0;
  If Not(Ok)Then ErrNoMsgOk(NumberExpected);
 Until Ok;
 GetNm:=Target;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Proc‚dure WinGotoLine                   Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet d'aller … une ligne absolue en particulier
 dans le traŒtement de texte de la fenˆtre MDI courante.
}

Function WinGotoLine;Begin
 WinGotoLine:=GetNm('Aller … la Ligne','Entrer la nouvelle ligne')
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Proc‚dure WinGotoWin                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet d'aller … une colonne en particulier dans le
 traŒtement de texte de la fenˆtre MDI courante.
}

Function WinGotoRow;Begin
 WinGotoRow:=GetNm('Aller … la Colonne','Entrer la nouvelle colonne')
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure WinGotoPg                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de changer la page courante de la fenˆtre MDI
 courante s'il s'agit du traŒtement de texte.
}

Function WinGotoPg;Begin
 WinGotoPg:=GetNm('Aller … la Page','Entrer la nouvelle page')-1;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure UserChDir                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet … l'utilisateur de changer le r‚pertoire courant
 utilis‚e par l'application ®MonsterBook¯.
}

Procedure UserChDir;
Var
 Rep:String;
Begin
 Rep:=SelectDirectory('S‚lectionner un r‚pertoire',GetCurrentDir,True);
 If Rep<>''Then System.ChDir(Rep);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Proc‚dure PrintersSetup                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet … l'utilisateur de configurer les imprimantes
 actuellement installer sur la machine.
}

Procedure PrintersSetup;Begin
 If(SetupPrinters)Then SaveIni;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Proc‚dure SetFormat                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet … l'utilisateur de fixer les dimensions de la page
 du traŒtement de texte de la fenˆtre MDI courante.
}

Procedure SetFormat;
Var
 Sheet:SheetFormatEditor;
 Editor:^EditorApp;
Begin
 Case HModel(Windows)of
  wnEdit:Begin
   Editor:=HPtr(Windows);
   If vtGat=TEGetViewMode(Editor^)Then Begin
    Sheet:=Editor^.SheetFormat;
    If SetFormatPage(Sheet)Then Begin
     Editor^.SheetFormat:=Sheet;
    End;
   End;
  End;
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Proc‚dure ViewAscii                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de visualiser des fichiers de format ASCII
 sp‚cifier par la variable de param‚trage.
}

Procedure ViewAscii;
Var
 X1,Y1,X2,Y2:Byte;
 Old:Word;
Begin
 If Path<>''Then Begin
  Path:=LTrim(Path);
  If Not FileExist(Path)Then Exit;
  Old:=CurrEdit;
  If Not HLoad(Windows,wnView,Path)Then Begin
   HClose(Windows);
   CurrEdit:=Old;
   PutFreeMemory;
  End
   Else
  SetMnuSwitch;
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Proc‚dure HexView                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de visualiser ou d'‚diter en mode hexad‚cimal des
 fichier de n'importe quel type sp‚cifier par la variable de param‚trage.
}

Procedure HexView;
Var
 X,Y:Byte;
 Old:Word;
Begin
 {$IFDEF Developpeur}
  If Path<>''Then Begin
   Old:=CurrEdit;
   If Not HLoad(Windows,wnHexView,Path)Then Begin
    HClose(Windows);
    CurrEdit:=Old;
    PutFreeMemory;
   End
    Else
   SetMnuSwitch;
  End;
 {$ELSE}
  BadDistribution;
 {$ENDIF}
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Proc‚dure ViewOption                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet … l'utilisateur de visualiser ou d'‚diter en mode
 hexad‚cimal des fichier de n'importe quel type.
}

Procedure ViewOption;Begin
 {$IFDEF Developpeur}
  HexView(GetPathAllSel('Regarde Hex'));
 {$ELSE}
  BadDistribution;
 {$ENDIF}
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Proc‚dure InsFile                            Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet … l'utilisateur d'ins‚rer le contenu d'un texte de
 contenu externe … la fenˆtre MDI actuel  dans le contenu de la fenˆtre MDI
 courante en pleine ‚dition.
}

Procedure InsFile;
Var
 Path:String;
 H:History;
 Q:Record
  Len:Word;
  EndCmd:Word;
  History:Array[0..511]of Byte;
 End;
Begin
 FillClr(Q,SizeOf(Q));
 HYInitTo(H,512,@Q.History);
 If ReadMainKey(HKEY_CURRENT_USER,'Software\Typewriter','InsertFileHistory',Q)Then Begin
  HYSetSizeBuffer(H,Q.EndCmd);
 End;
 HYQueue(H,Curr);
 Path:=_OpenWin('*.*','InsŠre un fichier',H);
 Q.Len:=514;
 Q.EndCmd:=HYGetSizeBuffer(H);
 CreateKeyFormat(HKEY_CURRENT_USER,'Software\Typewriter','InsertFileHistory',tdBlob,Q);
 HYDone(H);
 If Path<>''Then TEInsFile(EditorApp(HPtr(Windows)^),Path);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Proc‚dure DskHex                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de visualiser ou d'‚diter sous forme hexad‚cimal
 directement des secteurs d'une unit‚ disque.
}

Procedure DskHex;
Var
 Z:Byte;
 Old:Word;
Begin
 Z:=SelectDisk(0);
 If Z=$FFThen Exit;
 Old:=CurrEdit;
 If HLoad(Windows,wnHexView,Chr(Z+64)+':[dsk]')Then SetMnuSwitch;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Proc‚dure SetTri                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'effectuer un d‚placement de fichier dans une
 fenˆtre MDI de style gestionnaire de fichier.
}

Procedure MoveFiles;Begin
 If(HModel(Windows)=WnFileManager)Then Begin
  FMCopyFiles(FileManagerApp(HPtr(Windows)^),True)
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Proc‚dure SetTri                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure  permet d'effectuer  une Tri dans la fenˆtre MDI de
 traŒtement de texte ou de fixer le m‚thode de tri du tableau courant
 du gestionnaire de fichier.
}

Procedure SetTri;
Var
 Old:FileSort;
 Editor:^EditorApp;
 FilesManager:^FileManagerApp Absolute Editor;
Begin
 Editor:=HPtr(Windows);
 Case HModel(Windows)of
  wnFileManager:Begin
   Old:=FilesManager^.Panel[FilesManager^.Plane].BF.Tri;
   FilesManager^.Panel[FilesManager^.Plane].BF.Tri:=WinFileSort(Old);
   If(Old<>FilesManager^.Panel[FilesManager^.Plane].BF.Tri)Then
    FMRefresh(FilesManager^,True);
  End;
  wnEdit:TETri(Editor^);
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure ChgFont                           Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de s‚lectionner la police de caractŠres courante
 devant ˆtre utiliser pour l'affichage des modes vid‚o texte.
}

Procedure ChgFont;
Var
 I:SmallInt;
 K:Word;
 L:LstMnu;
 DataDB:Record
  ID:Byte;
  HeightChar:Byte;
  Name:String;
 End;
Begin
 LMInitCenter(L,40,15,'Change de police de caractŠres',CurrKrs.Dialog.Env.List);
 DBOpenServerName(ChantalServer,'CHANTAL:/Polices/IndexFont.Dat');
 DBFirst(ChantalServer);
 For I:=1to 36do Begin
  DBReadRec(ChantalServer,DataDB);
  If(HeightChr>DataDB.HeightChar)Then
   ALAddStrByte(L.List,DataDB.Name,DataDB.ID);
 End;
 K:=LMRun(L);
 LMDone(L);
 If K>0Then Begin
  MtxNm:=K;
  LoadNewMtx(K);
  SaveIni;
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Proc‚dure InfoFont                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de visualiser la police de caractŠres standard du
 systŠme vid‚o mˆme s'il y a 512 caractŠres plut“t que 256 caractŠres.
}

Procedure InfoFont;
Var
 W:Window;
 I,J:Byte;
 Data:MIV;
Begin
 GetMIV(Data);
 WEInitO(W,66,9+Byte(Data.IsDoubleMtx)*4);
 WEPushWn(W);
 WEPutWnKrDials(W,'Police actuel');
 WECloseIcon(W);
 WEBar(W);
 For J:=0 to 3do For I:=0to 63do WESetChr(W,I,J+1,Chr(I+J shl 6));
 If(Data.IsDoubleMtx)Then Begin
  For J:=0 to 3do For I:=0to 63do SetExtChr(WEGetRX1(W)+I,WEGetRY1(W)+J+5,(I+J shl 6)+256);
 End;
 While WEOk(W)do;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Proc‚dure ErrPrn                           Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure est le message d'erreur lorsque la demande d'impression
 en totalement ambigue.
}

Procedure ErrPrn;Begin
 ErrNoMsgOk(errSourcePrinterNotFound);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure RenameVolume                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet … l'utilisateur de changer le volume d'un unit‚
 en particulier.
}

Procedure RenameVolume;Begin
 RenameDiskName(SelectDisk(0));
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                              Proc‚dure ClsWn                           Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de fermer la fenˆtre d'application MDI courante du
 logiciel ®MonsterBook¯.
}

Function ClsWn;
Var
 S:String;
 HS,HC:SearchRec;
 Handle:Hdl;
Begin
 Case HModel(Windows)of
  wnEdit:Begin
   S:=EditorApp(HPtr(Windows)^).EditName;
   If(S=MaltePath+FileNameMenu)Then ResetMnu Else
   If(S=MaltePath+MB_INI)Then Begin
    FindFirst(S,fa,HS);
    Handle:=FileOpen(MaltePath+MB_CFG,fmRead);
    If(Handle<>errHdl)Then Begin
     _GetAbsRec(Handle,7,SizeOf(HC),HC);
     FileClose(Handle);
    End
     Else
    FillClr(HC,SizeOf(HC));
    If(HS.Time<>HC.Time)Then Begin
     If(WarningMsgYesNo('Fichier de configuration modifier! Si vous voulez '+
                        'que les modifications soit prise en compte, vous '+
                        'devez red‚marrer le programme. Souhaitez-vous red‚marrer?')=kbYes)Then Begin
      Application.FastFinish:=True;
      Application.Terminated:=True;
      ExitLevel:=xlRestart;
     End;
    End;
   End;
  End;
 End;
 ClsWn:=HClose(Windows);
 Case HModel(Windows)of
  wnProgMan:If(ProgramsManagerApp(HPtr(Windows)^).Mode=mWin9X)Then Begin
   HInTaskBar(Windows);
  End;
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Proc‚dure SaveAll                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de sauvegarder tous les fichiers contenu dans les
 fenˆtre MDI actuellement ouverte de l'application ®MonsterBook¯.
}

Procedure SaveAll;Begin
 HSaveAll(Windows);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Proc‚dure SaveAs                           Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de sauvegarde la fenˆtre courante sous un nouveau
 nom diff‚rent de l'ancien.
}

Procedure SaveAs;Begin
 HSaveAs(Windows);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure CloseAllWnSaved                    Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de fermer toutes les fenˆtres MDI ouvertes et les
 sauvegardes automatiquement avant de les fermer.
}

Procedure CloseAllWnSaved;Begin
 SaveAll;
 RunFunc(cmdCloseAllWn);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Proc‚dure AnswerMode                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de fixer l'‚tat du modem en mode de r‚ception des
 appels t‚l‚phonique automatique.
}

{$IFDEF Reseau}
 Procedure AnswerMode;Begin
  TMAnswerMode(Term(HPtr(Windows)^))
 End;
{$ENDIF}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure OriginateMode                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de d‚sactiver l'‚tat du modem en mode de r‚ception
 des appels t‚l‚phonique automatique.
}

{$IFDEF Reseau}
 Procedure OriginateMode;Begin
  TMOriginateMode(Term(HPtr(Windows)^))
 End;
{$ENDIF}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure HangUpPhone                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de raccrocher la ligne de t‚l‚phone occup‚e par le
 modem de l'ordinateur.
}

{$IFDEF Reseau}
 Procedure HangUpPhone;Begin
  TAHangUpPhone(Term(HPtr(Windows)^))
 End;
{$ENDIF}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure CopyClipboard                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de copier un bloc s‚lectionner dans la fenˆtre MDI
 dans la presse-papier de l'application ®MonsterBook¯.
}

Procedure CopyClipBoard;
Var
 Editor:^EditorApp;
 IconEdit:^IconEditApp Absolute Editor;
 DrawEdit:^DrawEditApp Absolute Editor;
 FontEdit:^FontEditor Absolute Editor;
 SuperCalc:^SuperCalcApp Absolute Editor;
Begin
 Editor:=HPtr(Windows);
 Case HModel(Windows)of
  wnEdit:TECpyClipBoard(Editor^);
  wnSuperCalc:SCCopyClipboard(SuperCalc^);
  wnDraw:DWCopyImage2Clipboard(DrawEdit^);
  {$IFDEF Developpeur}
   wnIcon:IECpyClipBoard(IconEdit^);
   wnFont:FECopy(FontEdit^);
  {$ENDIF}
  Else ErrNoMsgOk(CopyIncompatible);
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure PasteClipboard                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de passer le morceau contenu dans le presse-papier
 de l'application ®MonsterBook¯ dans la fenˆtre MDI courante.
}

Procedure PasteClipBoard;
Var
 Editor:^EditorApp;
 IconEdit:^IconEditApp Absolute Editor;
 DrawEdit:^DrawEditApp Absolute Editor;
 FontEdit:^FontEditor Absolute Editor;
 SuperCalc:^SuperCalcApp Absolute Editor;
Begin
 Editor:=HPtr(Windows);
 Case HModel(Windows)of
  wnEdit:TEPasteClipBoard(Editor^);
  wnSuperCalc:SCPasteClipboard(SuperCalc^);
  wnDraw:DWPasteClipboard2Image(DrawEdit^,0,0);
  {$IFDEF Developpeur}
   wnIcon:IEPasteClipBoard(IconEdit^);
   wnFont:FEPaste(FontEdit^);
  {$ENDIF}
  Else ErrNoMsgOk(ErrorPasteBeforeCopy);
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Proc‚dure PasteOS2File                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de cueillir des informations … partir du clipboard
 d'OS/2 de fichier et de les incorporer dans le texte en pleine ‚dition.
}

Procedure PasteOS2File;Begin
 Case HModel(Windows)of
  wnEdit:Begin
   If(OS2)Then TEInsFile(EditorApp(HPtr(Windows)^),'TEXT.TMP')
          Else TEPasteClipboardWindows(EditorApp(HPtr(Windows)^));
  End;
  Else ErrNoMsgOk(ErrorPasteBeforeCopy);
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Fonction GetVideoStr                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ


  Cette fonction permet de connaŒtre les caractŠres d'une ligne d'affichage
 de l'‚cran sans toutefois sa couleur ou attribut.
}

Function GetVideoStr(Y:Byte):String;
Var
 I:Byte;
 S:String;
Begin
 S:='';
 For I:=0to(MaxXTxts)do IncStr(S,GetChr(I,Y));
 GetVideoStr:=RTrim(S)
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                     Proc‚dure ClipboardOutput                    Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de passer sur le presse-papier le contenu de
 l'‚cran de sortie de l'application ®MonsterBook¯.
}

Procedure ClipboardOutput;
Var
 J:Byte;
Begin
 MakeClipboard((NmXTxts+2)*NmYTxts);
 For J:=0to(MaxYTxts)do PutClipboardTxt(GetVideoStr(J)+CRLF);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure _OpenFont                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'ouvrir une police de caractŠres sous un nom
 particulier afin de l'‚diter.
}

Procedure _OpenFont;
Var
 OldY:Byte;
Begin
 If Not HLoad(Windows,wnFont,Path)Then Exit;
 OldY:=YEditor;
 SetMnuSwitch;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Proc‚dure OpenFont                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet … l'utilisateur de cr‚er une nouvelle police de
 caractŠres.
}

Procedure NewFont;Begin
 _OpenFont('')
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                             Proc‚dure OpenFont                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet … l'utilisateur d'ouvrir une police de caractŠres
 afin de l'‚diter.
}

Procedure OpenFont;
Var
 Path:String;
Begin
 Path:=_OpenWin('*.FNT','Ouvre une Police',H);
 If Path<>''Then _OpenFont(Path);
End;

Procedure NewDFD;
Var
 TD:^TechDrawApp;
 X1,Y1,X2,Y2:Byte;
Begin
 TD:=HNewManual(Windows,wnTechDraw,X1,Y1,X2,Y2);
 If(TD<>NIL)Then Begin
  If TDNewDFD(TD^,X1,Y1,X2,Y2)Then SetMnuSwitch;
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure NewElectric                    Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet … l'utilisateur d'‚diter une nouveau plan de
 circuit ‚lectronique.
}

Procedure NewElectric;
Var
 TD:^TechDrawApp;
 X1,Y1,X2,Y2:Byte;
Begin
 TD:=HNewManual(Windows,wnTechDraw,X1,Y1,X2,Y2);
 If(TD<>NIL)Then Begin
  If TDNewElectronic(TD^,X1,Y1,X2,Y2)Then SetMnuSwitch;
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                             Proc‚dure EdtSetMtx                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de passer … la palette secondaire d'une pilote de
 taille sup‚rieur … 256 caractŠres. Si elle est d‚ja en palette secondaire
 alors elle se retrouve en palette primaire.
}

Procedure ExtChrMode;Begin
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Proc‚dure EdtSetMtx                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet au traŒtement de texte d'effectuer l'‚dition du
 texte  avec une  police de  512 caractŠres plut“t  qu'une police de 256
 caractŠres standard.
}

Procedure EdtSetMtx;Begin
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Proc‚dure EdtHugeMtx                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de s‚lection les options de matrices disponible
 par exemple dans l'‚dition de plan de circuit ‚lectronique.
}

Procedure EdtHugeMtx;Begin
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure ChangeCurrMtxChr                Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de s‚lectionner un caractŠre particulier dans
 la liste ‚tendue des 512 caractŠres.
}

Procedure ChangeCurrMtxChr;Begin
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Proc‚dure SetRead                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Dans le cas d'une fenˆtre courante d'‚diteur,  cette proc‚dure fixe
 l'‚diteur en mode lecture seulement ou s'il est d‚j… en mode lecture
 seulement, autorise la lecture et ‚criture du texte.

  Et Dans le cas d'une  fenˆtre  courante  d'‚diteur  hexad‚cimal, il
 autorise la modification des donn‚es visualiser.

  Tandis que dans le cas dans le cas d'un gestionnaire de fichier, il
 y a relecture des fichiers contenu dans la fenˆtre.
}

Procedure SetRead;
Var
 App:Pointer;
 Editor:^EditorApp Absolute App;
 FileManager:^FileManagerApp Absolute App;
 HexEdit:^HexEditApp Absolute App;
Begin
 App:=HPtr(Windows);
 Case(HModel(Windows))of
  wnEdit:ASM
   LES DI,Windows.CurrModel
   XOR ES:[DI].WindowApp.P.Edit.ReadOnly,1
  END;
  {$IFDEF Developpeur}
   wnHexView:HVEditMode(HexEdit^,Not(HexEdit^.EditMode));
  {$ENDIF}
  wnFileManager:Begin
   If(FileManagerApp(HPtr(Windows)^).Panel[FileManager^.Plane].Board=BoardFile)Then
    FMReadFiles(FileManager^,FileManager^.Plane);
  End;
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                              Proc‚dure InsCol                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet l'insertion d'une colonne au d‚but de chacune des
 ligne d'un traŒtement de texte.
}

Procedure InsCol;
Var
 S:String;
 K:Word;
Begin
 Case(HModel(Windows))of
  wnEdit:Begin
   S:='';
   Repeat
    K:=_WinInp(70,'Insertion Colonne','InsŠre une colonne … chaque d‚but de ligne du bloque:',No,S);
    If(K=kbEsc)Then Exit;
   Until K=kbEnter;
   TEInsStrBlk(EditorApp(HPtr(Windows)^),S);
  End;
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                             Proc‚dure Filtre                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'effectuer un filtrage du texte contenu dans le
 traŒtement de texte.
}

Procedure Filtre;
Var
 App:Pointer;
 Editor:^EditorApp Absolute App;
 HexEdit:^HexEditApp Absolute App;
Begin
 App:=HPtr(Windows);
 Case HModel(Windows)of
  wnEdit:TEFiltre(Editor^);
  {$IFDEF Developpeur}
   wnHexView:HVFiltre(HexEdit^);
  {$ENDIF}
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Proc‚dure Zoom                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet … la fenˆtre courante de passer en mode plein
 ‚cran ou r‚duit comme avant.
}

Procedure Zoom;
Var
 Old,Expand:Boolean;
 O,N:TextBoxRec;
 Y1:Byte;
Begin
 If(@Windows.CurrHWin^.ReSize=NIL)Then Exit;
 O:=Windows.CurrModel^.X.W.T;
 Y1:=1+LnsMnu+Windows.HomeYEditor;
 Expand:=(O.X1=0)and(O.Y1=Y1)and(O.X2=MaxXTxts)and(O.Y2=YTaskMnu-1);
 If Not(Expand)Then Begin
  Windows.CurrModel^.O:=O;
  N.X1:=0;
  N.Y1:=Y1;
  N.X2:=MaxXTxts;
  N.Y2:=YTaskMnu-1;
 End
  Else
 N:=Windows.CurrModel^.O;
 HReSize(Windows,N.X1,N.Y1,N.X2,N.Y2);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                              Proc‚dure Correcteur                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de lancer le correcteur d'orthographe du traŒtement
 de texte.
}

Procedure Correcteur;Begin
 If(HModel(Windows)=wnEdit)Then TECorrecteur(EditorApp(HPtr(Windows)^));
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                             Proc‚dure DelWord                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'effacer le mot courant dans une traŒtement de
 texte.
}

Procedure DelWord;Begin
 If(HModel(Windows)=wnEdit)Then TEDelWord(EditorApp(HPtr(Windows)^));
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Proc‚dure LookLog                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de montrer … l'utilisateur le journal de bord
 de l'application ®MonsterBook¯.
}

Procedure LookLog;
Var
 X1,Y1,X2,Y2:Byte;
 S:String;
Begin
 S:=Path2Dir(_PrgPath)+'MALTE.LOG';
 If FileExist(S)Then Begin
  HLoad(Windows,wnView,S);
  SetMnuSwitch;
 End
  Else
 ErrNoMsgOk(LogNotFound);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                             Proc‚dure FullScrn                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet l'affichage pleine ‚cran d'une image contenu dans
 une fenˆtre.
}

Procedure FullScrn;
Var
 App:Pointer;
 DrawEdit:^DrawEditApp Absolute App;
 Tetris:^TetrisGame Absolute App;
Begin
 App:=HPtr(Windows);
 Case(HModel(Windows))of
  wnDraw:DWFullScrn(DrawEdit^);
  {$IFDEF Games}
   wnTetris:TetrisSetScrn(Tetris^,Not Tetris^.FullScrn);
  {$ENDIF}
 End;
End;

Procedure NewProgMan;Begin
 HNew(Windows,wnProgMan);
 SetMnuSwitch;
End;

Procedure WallPaper;
Var
 Name,Path:String;
 Q:HistoryDocument;
 H:History;
Begin
 FillClr(Q,SizeOf(Q));
 HYInitTo(H,512,@Q.History);
 If ReadMainKey(HKEY_CURRENT_USER,'Desktop\WallPaper','History',Q)Then Begin
  HYSetSizeBuffer(H,Q.EndCmd);
 End;
 Path:=StrPas(FontAppPath);
 If Not FileExist(Path)Then Path:='';
 Name:=_OpenWinModel(Path2Dir(Path)+'*.*','Papier Peint',H,omDraw);
 If(Name<>'')and(FileExist(Name))Then Begin
  HYQueue(H,Name);
  Q.EndCmd:=HYGetSizeBuffer(H);
  Q.Len:=514;
  CreateKeyFormat(HKEY_CURRENT_USER,'Desktop\WallPaper','History',tdBlob,Q);
  StrDispose(FontAppPath);
  FontAppPath:=Str2PChr(Name);
  LoadWallPaper(False);
  HRefreshBackground(Windows);
  SaveIni;
 End;
End;

Procedure InsertImage;
Var
 Name:String;       { Chemin de recherche }
 Editor:^EditorApp; { Pointeur sur l'application d'‚dition }
Begin
 If(HModel(Windows)<>wnEdit)Then Exit;
 Name:='';
 Editor:=HPtr(Windows);
 If Editor^.EditName<>''Then Name:=Path2Dir(Editor^.EditName);
 AddStr(Name,'*.*');
 Name:=_OpenWinModel(Name,'Insertion d''une image',H,omDraw);
 If Name<>''Then Begin
   { Routine permettant l'insertion d'une image dans un document...}
  TEInsImage(Editor^,Name);
 End;
End;

{Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Dans le traŒtement de texte de document,  cette proc‚dure permet de
 changer de page directement en demandant son num‚ro. Tandis que dans
 une calendrier, il est plut“t amener … l'ann‚e sp‚cifier.
}

Procedure GotoPage;
Var
 L:LongInt;
 App:Pointer;
 Editor:^EditorApp Absolute App;
 Calendar:^CalendarApp Absolute App;
Begin
 App:=HPtr(Windows);
 Case HModel(Windows)of
  wnEdit:TEGotoLns(Editor^,WinGotoPg*(Editor^.SheetFormat.Y2-Editor^.SheetFormat.Y1)+1);
  wnSuperCalc:Begin

  End;
  wnCalendar:Begin
   L:=GetNm('Aller … l''ann‚e','Entrer l''ann‚e o— aller:');
   CAGoto(Calendar^,L,Calendar^.Month);
  End;
 End;
End;

Procedure DelSpc;
Var
 Q:History;
 M:ArrayList;
Begin
 Case HModel(Windows)of
  wnEdit:TEDelSpc(EditorApp(HPtr(Windows)^));
  wnPrmpt:Begin
   HYInit(Q,0);
   ALInit(M);
   _OpenWinMultiModel(SetPath4AddFile(GetCurrentDir)+'*.*','Descripton',Q,M,No,Ya);
  End;
 End;
End;

Procedure FLIPlay;Var Path:String;Begin
 Path:=OpenWin('*.FLI','Animation FLI');
 If Path<>''Then RunFLI(Path);
End;

{Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de d‚place le pointeur … une nouvelle ligne dans
 la fenˆtre d'‚dition  texte courante.  Dans le cas  de  la  calculatrice
 programme, cependant, il permet de r‚soudre l'‚quation de premier degr‚.
}

Procedure GotoLn;
Var
 App:Pointer;
 Editor:^EditorApp Absolute App;
 HexEdit:^HexEditApp Absolute App;
 SuperCalc:^SuperCalcApp Absolute App;
 CD:^CDPlayer Absolute App;
Begin
 App:=HPtr(Windows);
 Case HModel(Windows)of
  wnEdit:TEGotoLns(Editor^,WinGotoLine);
  wnSuperCalc:SCGotoLine(SuperCalc^,WinGotoLine);
  {$IFDEF Developpeur}
   wnHexView:HVGotoLine(HexEdit^,WinGotoLine);
  {$ENDIF}
  wnProgMan:PushKey(kbPgUp);
  wnPC:Eq1erDegre;
  wnCDPlayer:CDPrevTrack(CD^);
 End;
End;

{Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de changer le num‚ro de colonne dans la fenˆtre
 courante.
}

Procedure GotoRow;
Var
 App:Pointer;
 Editor:^EditorApp Absolute App;
 HexEdit:^HexEditApp Absolute App;
 SuperCalc:^SuperCalcApp Absolute App;
 CD:^CDPlayer Absolute App;
Begin
 App:=HPtr(Windows);
 Case HModel(Windows)of
  wnEdit:TEGotoXY(Editor^,WinGotoRow,Editor^.P);
  wnSuperCalc:SCGotoRow(SuperCalc^,WinGotoRow);
  {$IFDEF Developpeur}
   wnHexView:HVGotoRow(HexEdit^,WinGotoRow);
  {$ENDIF}
  wnProgMan:PushKey(kbPgDn);
  wnPC:Eq2emeDegre;
  wnCDPlayer:CDNextTrack(CD^);
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ·}
{³            R o u t i n e   d e   b u r e a u                º}
{ÔÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼}

Function GetMinYDesktop:Byte;Begin
 GetMinYDesktop:=Windows.HomeYEditor+LnsMnu;
End;

Procedure XtrkProgram(Const S:String;Real:Boolean;Var Q:ProgramRec);Near;
Var
 P:Byte;        { Position d'item }
 I:Byte;        { Compteur de boucle de la chaŒne courante }
 TS:String;     { ChaŒne de caractŠres de l'‚l‚ment courante }
Begin
 FillClr(Q,SizeOf(Q));
 If S<>''Then Begin
  P:=0;TS:='';
  For I:=1to Length(S)do Begin
   If S[I]<>','Then IncStr(TS,S[I])
    Else
   Begin
    TS:=Trim(TS);
    Case(P)of
     0:Q.Name:=TS;
     1:Q.Path:=TS;
     2:Q.Icon:=TS;
     3:Q.X:=StrToWord(TS);
     4:Q.Y:=StrToWord(TS);
    End;
    TS:='';Inc(P);
   End;
  End;
  If TS<>''Then Begin
   TS:=LTrim(TS);
   Case(P)of
    0:Q.Name:=TS;
    1:Q.Path:=TS;
    2:Q.Icon:=TS;
    3:Q.X:=StrToWord(TS);
    4:Q.Y:=StrToWord(TS);
   End;
  End;
  If(Real)Then Inc(Q.Y,GetMinYDesktop);
 End;
End;

Type
 HeaderCacheBureauRec=Record
  Sign:Array[0..6]of Char; { "BUREAU"#26 }
  Info:SearchRec;
  NumProg:Word;
 End;

 CacheBureauProgramRec=Record
  Data:ProgramRec;
  IsValidImage:Boolean;
 End;

Procedure SaveCacheBureau;
Var
 Handle,HandleSource:Hdl;
 Path:String;
 Header:HeaderCacheBureauRec;
 ProgramData:CacheBureauProgramRec;
 Icon:XInf;
 Inf:MCanvas;
 FP,FS:LongInt;
 S:String;
 P:LongInt;
 X:Word;
 GX1:Word;
 Res:ImageHeaderRes;
Begin
 Path:=MaltePath+BUREAU_INI;
 Handle:=FileCreate(Path2NoExt(Path)+'.GIX');
 If(Handle<>errHdl)Then Begin
  FillClr(Header,SizeOf(Header));
  Header.Sign:='BUREAU'#26;
  FindFirst(Path,faArchive,Header.Info);
  _SetAbsRec(Handle,0,SizeOf(Header),Header);
  P:=SizeOf(Header);
  HandleSource:=FileOpen(MaltePath+BUREAU_INI,fmRead);
  If(HandleSource<>errHdl)Then Begin
   FP:=0;FS:=FileSize(HandleSource);
   Repeat
    __GetAbsFileTxtLn(HandleSource,FP,S);
    If S<>''Then Begin
     FillClr(ProgramData,SizeOf(ProgramData));
     XtrkProgram(S,Ya,ProgramData.Data);
     ProgramData.Data.Icon:=MaltePath+LTrim(ProgramData.Data.Icon);
     RILoadImage(ProgramData.Data.Icon,diAutoDetect,0,$FFFF,rmAllRes,[],Icon);
     ProgramData.IsValidImage:=Not((Icon.Handle=errHdl)or(Icon.Output=$FF));
     _SetAbsRec(Handle,P,SizeOf(ProgramData),ProgramData);
     Inc(P,Long(SizeOf(ProgramData)));
     RIWriteImage(Handle,diIconAdele,0,P,Icon);
     XGetAbsRec(Icon,0,SizeOf(Res),Res);
     GX1:=ProgramData.Data.X shl 3;
     If({Res.Original=diGIF}Res.BitsPerPixel>=8)Then Begin
      RIRes2WnImg(Icon,Inf);
      RIMakeDoublon(Icon,rmAllResSteady,True,Inf);
      XFreeMem(Icon);
      Icon:=Inf.Miroir;
      RIPutImageJuxtap(Icon,GX1,GetRawY(ProgramData.Data.Y),32,32,[wpJuxtap]);
     End
      Else
     RIPutImageJuxtap(Icon,GX1,GetRawY(ProgramData.Data.Y),32,32,[wpSprite]);
     X:=(Length(ProgramData.Data.Name)-4)shr 1;
     If(ProgramData.Data.X>X)Then Dec(ProgramData.Data.X,X);
     If Not InBarHole(ProgramData.Data.X,ProgramData.Data.Y+2,Length(ProgramData.Data.Name))Then
      PutSmlTxtXY(ProgramData.Data.X,ProgramData.Data.Y+2,ProgramData.Data.Name,CurrKrs.Desktop.Tapiserie);
     XFreeMem(Icon);
     Inc(Header.NumProg);
    End;
   Until FP>=FS;
   FileClose(HandleSource);
  End;
  _SetAbsRec(Handle,0,SizeOf(Header),Header);
  FileClose(Handle);
 End
  Else
 ErrNoMsgOk(SysErr);
End;

Function LoadCacheBureau:Boolean;
Var
 I:SmallInt;
 P:LongInt;
 GX1:Word;
 X:Word;
 Handle:Hdl;
 Header:HeaderCacheBureauRec;
 ProgramData:CacheBureauProgramRec;
 Info:SearchRec;
 Inf:MCanvas;
 Path:String;
 Res:ImageHeaderRes;
Begin
 LoadCacheBureau:=False;
 Path:=MaltePath+BUREAU_INI;
 Handle:=FileOpen(Path2NoExt(Path)+'.GIX',fmRead);
 If(Handle<>errHdl)Then Begin
  _GetAbsRec(Handle,0,SizeOf(Header),Header);
  FindFirst(Path,faArchive,Info);
  If(Header.Sign<>'BUREAU'#26)or(Header.Info.Time<>Info.Time)Then Begin
   FileClose(Handle);
   Exit;
  End;
  P:=SizeOf(Header);
  For I:=0to Header.NumProg-1do Begin
   _GetAbsRec(Handle,P,SizeOf(ProgramData),ProgramData);
   Inc(P,SizeOf(ProgramData));
   If(ProgramData.IsValidImage)Then Begin
    RIReadImage(Handle,diAutoDetect,P,4,$FFFF,rmAllResSteady,[],ProgramData.Data.Res);
    XGetAbsRec(ProgramData.Data.Res,0,SizeOf(Res),Res);
    GX1:=ProgramData.Data.X shl 3;
    If({Res.Original=diGIF}Res.BitsPerPixel>=8)Then Begin
     RIRes2WnImg(ProgramData.Data.Res,Inf);
     RIMakeDoublon(ProgramData.Data.Res,rmAllResSteady,True,Inf);
     XFreeMem(ProgramData.Data.Res);
     ProgramData.Data.Res:=Inf.Miroir;
     RIPutImageJuxtap(ProgramData.Data.Res,GX1,GetRawY(ProgramData.Data.Y),32,32,[wpJuxtap]);
    End
     Else
    RIPutImageJuxtap(ProgramData.Data.Res,GX1,GetRawY(ProgramData.Data.Y),32,32,[wpSprite]);
    X:=(Length(ProgramData.Data.Name)-4)shr 1;
     If(ProgramData.Data.X>X)Then Dec(ProgramData.Data.X,X);
    If Not InBarHole(ProgramData.Data.X,ProgramData.Data.Y+2,Length(ProgramData.Data.Name))Then
     PutSmlTxtXY(ProgramData.Data.X,ProgramData.Data.Y+2,ProgramData.Data.Name,CurrKrs.Desktop.Tapiserie);
   End;
  End;
  FileClose(Handle);
  LoadCacheBureau:=True;
 End;
End;

Procedure Bureau;
Var
 Handle:Hdl;
 Icon:XInf;
 Inf:MCanvas;
 FP,FS:LongInt;
 S:String;
 P,X:Word;
 Q:ProgramRec;
 GX1:Word;
 Res:ImageHeaderRes;
Begin
 If Not(IsGrf)Then Exit;
 If Not(LoadCacheBureau)Then SaveCacheBureau;

 (*Handle:=FileOpen(MaltePath+BUREAU_INI,fmRead);
 If(Handle<>errHdl)Then Begin
  FP:=0;FS:=FileSize(Handle);
  Repeat
   __GetAbsFileTxtLn(Handle,FP,S);
   If S<>''Then Begin
    XtrkProgram(S,Ya,Q);
    Q.Icon:=MaltePath+LTrim(Q.Icon);
    RILoadImage(Q.Icon,diAutoDetect,0,$FFFF,rmAllRes,[],Icon);
    XGetAbsRec(Icon,0,SizeOf(Res),Res);
    GX1:=Q.X shl 3;
    If({Res.Original=diGIF}Res.BitsPerPixel>=8)Then Begin
     RIRes2WnImg(Icon,Inf);
     RIMakeDoublon(Icon,rmAllResSteady,True,Inf);
     XFreeMem(Icon);
     Icon:=Inf.Miroir;
     RIPutImageJuxtap(Icon,GX1,GetRawY(Q.Y),32,32,[wpJuxtap]);
    End
     Else
    RIPutImageJuxtap(Icon,GX1,GetRawY(Q.Y),32,32,[wpSprite]);
    X:=(Length(Q.Name)-4)shr 1;
    If(Q.X>X)Then Dec(Q.X,X);
    If Not InBarHole(Q.X,Q.Y+2,Length(Q.Name))Then
     PutSmlTxtXY(Q.X,Q.Y+2,Q.Name,CurrKrs.Desktop.Tapiserie);
    XFreeMem(Icon);
   End;
  Until FP>=FS;
  FileClose(Handle);
 End;*)
End;

Procedure InsItemDesktop(Var Q:ProgramRec);
Var
 Handle:Hdl;
 FS,FP:Long;
 IsCRLF:String[2];
Begin
 Handle:=FileOpen(MaltePath+BUREAU_INI,fmDef);
 If(Handle=errHdl)Then Handle:=FileCreate(MaltePath+BUREAU_INI);
 If(Handle=errHdl)Then Begin
  ErrNoMsgOk(CanEditDesktop);
  Exit;
 End;
 FS:=FileSize(Handle);
 _GetAbsRec(Handle,FS-2,2,IsCRLF[1]);
 IsCRLF[0]:=#2;
 If(IsCRLF<>CRLF)Then PutFileLn(Handle);
 PutFileTxtLn(Handle,Q.Name+','+Q.Path+' '+Q.Args+','+Q.Icon+','+
                     WordToStr(Q.X)+','+WordToStr(Q.Y));
 FileClose(Handle);
End;

Procedure SearchFreeZoneForIcon(Var Data:ProgramRec);
Label Xit;
Var
 L:ArrayList;
 Q:ProgramRec;
 XP,XP1,YP,XP2,Len:SmallInt;
 J,IX,IY:SmallInt;
 Occuped:Boolean;
Begin
 If ALLoadFileASCII(L,MaltePath+BUREAU_INI)Then Begin
  For IY:=0to(MaxYTxts)shr 2do For IX:=0to(MaxXTxts)shr 2do Begin
   XP:=IX shl 2;YP:=(IY shl 2)+2;
   Occuped:=False;
   For J:=0to L.Count-1do Begin
    XtrkProgram(_ALGetStr(L,J),No,Q);
    XP1:=Q.X;XP2:=Q.X+3;
    Len:=Length(Q.Name)shr 1;
    If Len<5Then Len:=5;
    Dec(XP1,Len);Inc(XP2,Len);
    If(XP>=XP1)and(XP<=XP2)and(YP>=Q.Y)and(YP<=Q.Y+3)Then Begin
     Occuped:=True;
     Break;
    End;
   End;
   If Not(Occuped)Then Begin
    Data.X:=XP{ shl 3};Data.Y:={GetRawY}(YP);
    Goto Xit;
   End;
  End;
 End;
Xit:
 ALDone(L);
End;

Procedure NewItem;
Var
 Data:ProgramRec;
Begin
 FillClr(Data,SizeOf(Data));
 If ExecuteAppDPU(25,Data)Then Begin
  SearchFreeZoneForIcon(Data);
  InsItemDesktop(Data);
  HRefreshBackground(Windows);
 End;
End;

Procedure KillDesktopItem(Const Name:String;LP:LongInt);
Var
 L:ArrayList;
Begin
 If WarningShortCut(Name)Then Begin
  If ALLoadFileASCII(L,MaltePath+BUREAU_INI)Then Begin
   ALDelBuf(L,LP);
   ALSaveFileASCII(L,MaltePath+BUREAU_INI,False);
   HRefreshBackground(Windows);
  End
   Else
  ErrNoMsgOk(ErrReadDesktop);
 End;
End;

{ Cette proc‚dure permet de modifier une ligne du bureau en fonction de
 nouveau paramŠtres.
}

Procedure SetDesktopItem(LP:LongInt;New:Boolean;Const Name,Path:String;Icon:String;X,Y:Byte);
Label Write;
Var
 L:ArrayList;   { Liste pour modification du bureau... }
 S:String;      { ChaŒne de caractŠres de la ligne courante }
 J:LongInt;     { Compteur de boucle de ligne }
 Q:ProgramRec;  { Enregistrement du programme courant }
Begin
 If ALLoadFileASCII(L,MaltePath+BUREAU_INI)Then Begin
  If CmpLeft(Icon,MaltePath)Then Icon:=DelStr(Icon,1,Length(MaltePath));
  If Not(New)Then Begin
   ALDelBuf(L,LP);
    { Recherche une poubelle???? }
   For J:=0to L.Count-1do Begin
    S:=_ALGetStr(L,J);
    If S<>''Then Begin
     XtrkProgram(S,No,Q);
     If(StrUp(Q.Path)='DELETE')and(X>=Q.X)and(X<=Q.X+3)and(Y>=Q.Y)and(Y<=Q.Y+1)Then Begin
      { Il s'agit d'une demande d'envoyer dans la poubelle? }
      If WarningShortcut(Name)Then Goto Write;
      Exit;
     End;
    End;
   End;
  End;
  ALInsStr(L,LP,Name+','+Path+','+Icon+','+WordToStr(X)+','+WordToStr(Y));
 End;
Write:
 ALSaveFileASCII(L,MaltePath+BUREAU_INI,False);
 ALDone(L);
End;

Procedure EditItem(Var Q:ProgramRec;LP:LongInt);Begin
 If ExecuteAppDPU(25,Q)Then Begin
  SetDesktopItem(LP,False,Q.Name,Q.Path+Q.Args,Q.Icon,Q.X,Q.Y);
  HRefreshBackground(Windows);
 End;
End;

Procedure RenameDesktopItem(Const Name:String;LP:LongInt);
Var
 L:ArrayList;
 S:String;
 Curr:String; { Contenu de la ligne courante }
 PC:PChr;
Begin
 S:=Name;
 If(WinInp(40,'Renommer','Renommer le raccourci ®'+Name+
              '¯ en:',CurrKrs.Dialog.Window,No,S)=kbYes)Then Begin
  If ALLoadFileASCII(L,MaltePath+BUREAU_INI)Then Begin
   Curr:=StrPas(_ALGetBuf(L,LP));
   If Curr<>''Then Begin
    While Not(StrI(1,Curr)in[#0,','])do Curr:=DelStr(Curr,1,1);
    Curr:=S+Curr;
    PC:=ALSet(L,LP,Length(Curr)+1);
    If(PC<>NIL)Then StrPCopy(PC,Curr);
   End;
   ALSaveFileASCII(L,MaltePath+BUREAU_INI,False);
   ALDone(L);
   HRefreshBackground(Windows);
  End
   Else
  ErrNoMsgOk(ErrReadDesktop);
 End;
End;

{ Cette proc‚dure permet … l'utilisateur de modifier le bureau selon ses
 convenance.
}

Procedure SetupDesktop;
Var
 Data:Record
  Foreground:MColorGrid;
  Background:MColorGrid;
  WallPaperCfg:MRadioButton;
  ToolBar:MCheckBox;
  HelpBar:MCheckBox;
 End;
 NewKr:Byte;                { Nouvelle couleur d'arriŠre-plan }
 RefreshBackground:Boolean; { Demande si la rafraŒchissement de l'arriŠre-plan est n‚cessaire }
 OldWallPaper:WallPaperMode;
Begin
 FillClr(Data,SizeOf(Data));
 Data.Foreground.Color:=CurrKrs.Desktop.Tapiserie and$F;
 Data.Background.Color:=CurrKrs.Desktop.Tapiserie shr 4;
 OldWallPaper:=WallPaperCfg;
 If(wpJuxtap)in(WallPaperCfg)Then Data.WallPaperCfg.Alignment:=1;
 Data.ToolBar.Checked:=ViewToolBar;
 Data.HelpBar.Checked:=HelpBar;
 If ExecuteAppDPU(76,Data)Then Begin
  RefreshBackground:=True;
  If Data.WallPaperCfg.Alignment=1Then WallPaperCfg:=[wpJuxtap]
                                  Else WallPaperCfg:=[wpCenter];
  NewKr:=(Data.Background.Color shl 4)+(Data.Foreground.Color and$F);
  CurrKrs.Desktop.Tapiserie:=NewKr;
  If(OldWallPaper<>WallPaperCfg)Then SaveIni;
  If(Data.ToolBar.Checked<>ViewToolBar)Then Begin
   ViewToolBar:=Data.ToolBar.Checked;
   PutToolBar;
   If Not(ViewToolBar)Then Begin
    HRefreshBackground(Windows);
    RefreshBackground:=No;
   End;
   SaveIni;
  End;
  If(HelpBar<>Data.HelpBar.Checked)Then Begin
   HelpBar:=Data.HelpBar.Checked;
   PBLastLen:=$FFFF;
   RefreshExterne;
   PutOpenWin;
   If(HelpBar)Then DefEndBar
    Else
   Begin
    HRefreshBackground(Windows);
    RefreshBackground:=False;
   End;
   SaveIni;
  End;
  If(RefreshBackground)Then HRefreshBackground(Windows);
 End;
End;

Procedure LocalMenuFont;
Label 1;
Const
 fmRefresh=$F001;
 fmWallPaper=$F002;
 fmScrnSaver=$F003;
 fmProgMan=$F004;
 fmEditDesktop=$F005;
 fmNewItem=$F006;
 fmHelpBar=$F007;
 fmNewFolder=$F008;
 fmAssistant=$F009;
 fmSetup=$F00A;
 fmInstall=$F00B;
Var
 PL:Array[0..1]of Boolean;
 K:Word;
 Handle:Hdl;
 FP,FS:LongInt;
 S,TS:String;
 P:Word;
 Q:ProgramRec;
 LP:LongInt;
 I:Byte;
 OX,OY:Byte;    { Ancienne position souris X et Y }
 MX,MY:Byte;    { Position actuel de la souris X et Y }
 MB:Word;       { Position des boutons souris }
 Box:BoxRectRec;{ Sauvegarde de la boite si n‚cessaire }
 Ln:Word;       { Ligne courante de lecture }

 Procedure OpenItem;
 Var
  PMW:ProgramsManagerApp;
 Begin
  If Q.Path[Length(Q.Path)]='\'Then Begin
   HLoad(Windows,wnProgMan,Q.Path+'|'+Q.Name);
  End
   Else
  Begin
   FillClr(PMW,SizeOf(PMW));
   PMWExecute(PMW,Q);
   If(PMW.CurrProg<>pmwNone)Then RunApp(PMW.CurrProg);
  End;
 End;

 Function ClickIcon:Boolean;
 Var
  Move:Boolean;
 Begin
  OX:=LastMouseX;
  OY:=LastMouseY;
  Move:=False;
  __ShowMousePtr;
  Repeat
   __GetMouseTextSwitch(MX,MY,MB);
   If(MY>=YTaskMnu)Then MY:=YTaskMnu;
   If(MY<=GetMinYDesktop)Then MY:=GetMinYDesktop;
   If(OX<>MX)or(OY<>MY)Then Begin
    __HideMousePtr;
    If Not(Move)Then SaveBoxRect(MX,MY,MX+3,MY+2,Box)
     Else
    Begin
     _PutBoxRect(Box);
     ReSaveBoxRect(MX,MY,Box);
    End;
    __PutRect(Box.GX1,$C);
    Move:=Ya;OX:=MX;OY:=MY;
    __ShowMousePtr;
   End;
  Until MB=0;
  __HideMousePtr;
  If(Move)Then Begin
   _PutBoxRect(Box);
   RestoreBoxRect(Box);
  End;
  ClickIcon:=Move;
 End;

Begin
 __HideMousePtr;
 If(Pointer(@Windows.OnRefreshBackground)<>NIL)Then Begin
  Handle:=FileOpen(MaltePath+BUREAU_INI,fmRead);
  If(Handle<>errHdl)Then Begin
   FP:=0;LP:=0;FS:=FileSize(Handle);Ln:=0;
   Repeat
    __GetAbsFileTxtLn(Handle,FP,S);
    Inc(Ln);
    If S<>''Then Begin
     XtrkProgram(S,Ya,Q);
     Q.Icon:=MaltePath+Q.Icon;
     If(LastMouseX>=Q.X)and(LastMouseX<=Q.X+3)and
       (LastMouseY>=Q.Y)and(LastMouseY<=Q.Y+1)Then Begin
    1:FileClose(Handle);
      If LastMouseB=2Then Begin
       If(ClickIcon)Then Begin
        Case RunMenuApp(93)of
         $F001:Begin
          Q.X:=MX;Q.Y:=MY-GetMinYDesktop;
          SetDesktopItem(Ln-1,No,Q.Name,Q.Path,Q.Icon,Q.X,Q.Y);
          HRefreshBackground(Windows);
         End;
         $F002:Begin
          Q.X:=MX;Q.Y:=MY-GetMinYDesktop;
          SetDesktopItem(Ln-1,Ya,Q.Name,Q.Path,Q.Icon,Q.X,Q.Y);
          HRefreshBackground(Windows);
         End;
        End;
       End
        Else
       Begin
        Case RunMenuApp(75)of
         $F001:OpenItem;
         $F002:KillDesktopItem(Q.Name,LP);
         $F003:RenameDesktopItem(Q.Name,LP);
         $F004:_OpenIcnEdt(Q.Icon);
         $F005:EditItem(Q,LP);
        End;
       End;
      End
       Else
      Begin
       If(ClickIcon)Then Begin
        Q.X:=MX;Q.Y:=MY-GetMinYDesktop;
        SetDesktopItem(Ln-1,No,Q.Name,Q.Path,Q.Icon,Q.X,Q.Y);
        HRefreshBackground(Windows);
       End
        Else
       If Q.Path='PAINT.EXE'Then OpenDraw('NEWDRW:')
                            Else OpenItem;
      End;
      __ShowMousePtr;
      Exit;
     End;
      { Text }
     Inc(Q.X,2);
     If(LastMouseX>=Q.X-(Length(Q.Name)shr 1))and(LastMouseX<=Q.X+(Length(Q.Name)shr 1))and
       (LastMouseY=Q.Y+2)Then Goto 1;
    End;
    Inc(LP);
   Until FP>=FS;
   FileClose(Handle);
  End;
 End;
 If(EnvMode=emDESQview)Then MenuDESQview
  Else
 Begin
  PL[0]:=@Windows.OnRefreshBackground<>NIL;
  PL[1]:=Windows.Lst.Count=0;
  Case _RunMenuApp(29,PL)of
   fmRefresh:HRefreshBackground(Windows);
   fmWallPaper:WallPaper;
   fmScrnSaver:RunScrnSaver;
   fmProgMan:NewProgMan;
   fmEditDesktop:OpenFile(MaltePath+BUREAU_INI);
   fmNewItem:NewItem;
   fmHelpBar:SetupDesktop;
   fmNewFolder:NewFolder;
   fmAssistant:RunFunc(Assistant);
   fmSetup:MnuSetup(False);
   fmInstall:InstallSelective;
  End;
 End;
End;

Procedure MenuDESQview;
Var
 OldMenuColor:MenuPalette;
 K:Word;
Begin
 OldMenuColor:=CurrKrs.Menu;
 CurrKrs.Menu.Normal:=$9F;
 CurrKrs.Menu.High:=$9B;
 CurrKrs.Menu.Select:=$1F;
 K:=RunMenuApp(144);
 If K=$F001Then K:=RunMenuApp(150);
 CurrKrs.Menu:=OldMenuColor;
 Case(K)of
  $F002:LstEdt;
  $F101:WnFM;
  $F102:WnPrompt;
  $F103:DosShell;
  $F104:NortonCommander;
 End;
End;

Procedure MenuClassicFrancais;Begin
 FileNameMenu:='FRANCAIS.MNB';
 ResetMnu;
End;

Procedure MenuClassicEnglish;Begin
 FileNameMenu:='ENGLISH.MNB';
 ResetMnu;
End;

Procedure TitleMenu;
Const
 fmNoMenu=$F001;
 fmEdit=$F002;
 fmMenuClassic=$F003;
 fmClock=$F004;
 fmCalendar=$F005;
 fmClockOnOff=$F006;
 fmTitleOnOff=$F007;
 fmToolBarOnOff=$F008;
 fmMenuClassicEnglish=$F009;
 fmAgenda=$F00A;
Var
 PL:Array[0..2]of Boolean;
Begin
 PL[0]:=LastMouseX>=Dialex.TimeX;
 PL[1]:=ViewAppTitle;
 PL[2]:=ViewToolBar;
 Case _RunMenuApp(41,PL)of
  fmNoMenu:Begin
   UnloadMenu;
   SetMnuSwitch;
   HRefreshBackground(Windows);
  End;
  fmEdit:OpenFile(MaltePath+FileNameMenu);
  fmMenuClassic:MenuClassicFrancais;
  fmMenuClassicEnglish:MenuClassicEnglish;
  fmClock:SetClock;
  fmClockOnOff:Begin
   DialTimer:=Not DialTimer;
   If Not(DialTimer)Then PutAppTitleBar;
  End;
  fmCalendar:Calendar;
  fmAgenda:AgendaWindow;
  fmTitleOnOff:Begin
   ViewAppTitle:=Not ViewAppTitle;
   LnsMnu:=Byte(ViewAppTitle);
   MainMenu.Y:=LnsMnu;
   ResetMnu;
   If(ViewAppTitle)Then PutAppTitleBar
    Else
   Begin
    DialTimer:=False;
    HRefreshBackground(Windows);
   End;
   CreateKeyFormat(HKEY_CURRENT_USER,'Desktop','Title',tdBoolean,ViewAppTitle);
  End;
  fmToolBarOnOff:Begin
   ViewToolBar:=Not ViewToolBar;
   PutToolBar;
   If Not(ViewToolBar)Then HRefreshBackground(Windows);
   SaveIni;
  End;
 End;
End;

Procedure NortonCommander;
Var
 FM:^FileManagerApp;
 X1,Y1,X2,Y2:Byte;
Begin
 If(IsGrf)and(MediaSupport)Then Begin
  PutTaskIcon($FF,icnFolder,False);
 End;
 FM:=HNewManual(Windows,wnFileManager,X1,Y1,X2,Y2);
 If(FM<>NIL)Then Begin
  FMNortonCommander(FM^,X1,Y1,X2,Y2);
  SetMnuSwitch;
 End;
End;

Procedure HTMLComposer;
Var
 Q:^EditorApp;
 X1,Y1,X2,Y2:Byte;
Begin
 If(IsGrf)and(MediaSupport)Then Begin
  PutTaskIcon($FF,icnFolder,False);
 End;
 Q:=HNewManual(Windows,wnEdit,X1,Y1,X2,Y2);
 If(Q<>NIL)Then Begin
  TENewHTMLDocument(Q^,X1,Y1,X2,Y2);
  SetMnuSwitch;
 End;
End;

Procedure CuteHTML;
Var
 Q:^EditorApp;
 X1,Y1,X2,Y2:Byte;
Begin
 If(IsGrf)and(MediaSupport)Then Begin
  PutTaskIcon($FF,icnFolder,False);
 End;
 Q:=HNewManual(Windows,wnEdit,X1,Y1,X2,Y2);
 If(Q<>NIL)Then Begin
  TENewHTML(Q^,X1,Y1,X2,Y2);
  SetMnuSwitch;
 End;
End;

Procedure NewTechDraw;Begin
 HNew(Windows,wnTechDraw);
End;

Procedure RunApp(Cmd:Word);Begin
 Case(Cmd)of
  pmwFileManager:WnFM;
  pmwControl:Control;
  pmwPrintMan:PrintersSetup;
  pmwShellDos:WnPrompt;
  pmwShellUnix:WnMunix;
  pmwReadMe:OpenFile(MaltePath+'LISEZMOI.DOC');
  pmwWrite:NewGat;
  pmwPaint:NewDrw;
  pmwTerminal:NewTerm;
  pmwNotePad:NewEdt;
  pmwCalendar:Calendar;
  pmwCalc:WnWatch;
  pmwClock:SetClock;
  pmwCharMap:InfoFont;
  pmwCDPlayer:RunCDPlayer;
  pmwFLIPlay:FLIPlay;
  pmwBesch:Begin
   {$IFDEF Educative}
    Bescherelle;
   {$ELSE}
    BadDistribution;
   {$ENDIF}
  End;
  pmwConvers:UserConversionFormula;
  pmwCleanMgr:CleanCurrDisk;
  pmwVolume:SetSonVolume;
  pmwPassWord:SetupSecurity;
  pmwSysInfo:ManagerPeripheric{SomaryInfo{WindowSommary};
  pmwPascal:OpenPascal;
  pmwCPP:OpenC;
  pmwCobol:OpenCobol;
  pmwAsm:OpenAssembler;
  pmwFormat:Format;
  pmwHexDiskEdit:DskHex;
  pmwOpenWrite:OpenText;
  pmwOpenPaint:OpenDrw;
  pmwOpenNotePad:OpenEdt;
  pmwCfgCountry:ChangeCountry;
  pmwCfgVideoMode:ChgVidMode;
  pmwCfgMouse:SetupMouse;
  pmwCfgKeyboard:SetupKeyboard;
  pmwCfgJoystick:SetupJoystick;
  pmwCfgSystem:SetSystems;
  pmwCfgCyrix6x86:Config6x86;
  pmwTetris:Begin
   HNew(Windows,wnTetris);
   SetMnuSwitch;
  End;
  pmwMissileCommand:Begin
   HNew(Windows,wnMissileCommand);
   SetMnuSwitch;
  End;
  pmwNibbles:Begin
   HNew(Windows,wnNibble);
   SetMnuSwitch;
  End;
  pmwCfgPalette:SetPaletteKr;
  pmwNortonCommander:NortonCommander;
  pmwHTMLComposer:HTMLComposer;
  pmwCuteHTML:CuteHTML;
  pmwCfgDesktop:SetWindows9X;
  pmwTechDraw:NewTechDraw;
  pmwLogo:Begin
   {$IFDEF Developpeur}
    HNew(Windows,wnLogo);
   {$ELSE}
    BadDistribution;
   {$ENDIF}
  End;
  pmwGlobalDraw:WinGlobalDraw;
  pmwExplorerSystem:FullConfigSystem;
  pmwDataBase:NewDataBase;
  pmwExplorerDataBase:NewExplorerDB;
  pmwShutDown:ShutDown;
  pmwAtlas:OpenAtlas;
 End;
End;

{Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure demande de l'aide au niveau des combinaisons et
 raccourcis clavier de l'application.
}

Procedure HelpKey;Begin
 Help('MANUEL.RLL',hisKey,hieKey)
End;

Procedure HelpOnLine;
Label Default;
Var
 Ptr:Pointer;
 Editor:^EditorApp Absolute Ptr;
Begin
 Ptr:=HPtr(Windows);
 {$IFDEF Developpeur}
  Case HModel(Windows)of
   wnEdit:Begin
    If Not(Editor^.Mode in[0,vtGat])Then Begin
     TEOnlineHelp(Editor^);
    End
     Else
    Goto Default;
   End;
   Else Default:Help('MANUEL.RLL',hisGlobal,hieGlobal)
  End;
 {$ELSE}
  Help('MANUEL.RLL',hisGlobal,hieGlobal)
 {$ENDIF}
End;

Procedure StartMode;
Var
 WinPtr:^WindowApp;
Begin
 PMWStartMode(ProgramsManagerApp(HPtr(Windows)^),startInv);
 If(ProgramsManagerApp(HPtr(Windows)^).Mode=mWin9X)Then Begin
  Windows.OnRefreshBackground:=Bureau;
  HInTaskBar(Windows);
 End
  Else
 Begin
  WinPtr:=_ALGetBuf(Windows.Lst,CurrEdit);
  Windows.OnRefreshBackground:=NIL;
  WinPtr^.P.W.T:=WinPtr^.O;
  If(WinPtr^.P.W.T.X2>MaxXTxts)or(WinPtr^.P.W.T.Y2>MaxYTxts)or
    (WinPtr^.P.W.T.Y1=0)or(WinPtr^.P.W.T.X1>WinPtr^.P.W.T.X2)or
    (WinPtr^.P.W.T.Y1>WinPtr^.P.W.T.Y2)Then Begin
   WinPtr^.P.W.T.X1:=0;
   WinPtr^.P.W.T.Y1:=4;
   WinPtr^.P.W.T.X2:=MaxXTxts;
   WinPtr^.P.W.T.Y2:=YTaskMnu-1;
  End;
  HRefresh(Windows);
 End;
 PutOpenWin;
 DefEndBar;
End;

Procedure RunCDPlayer;Begin
 HNew(Windows,wnCDPlayer);
 SetMnuSwitch;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure WnFM                           Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'ouvrir une fenˆtre MDI permettant de g‚rer
 les fichiers  du  systŠme  d'exploitation  de fa‡on  essaie comme le
 ®Norton Commander¯, le ®StupenDos¯ ou le ®Salamand¯.
}

Procedure WnFM;Begin
 If(IsGrf)and(MediaSupport)Then Begin
  PutTaskIcon($FF,icnFolder,False);
 End;
 MakeApplication(wnFileManager)
End;

Procedure StartPartition;Begin
 MakeApplication(wnPartitionManager);
End;

Procedure FileExplorer;
Var
 FM:^FileManagerApp;
 X1,Y1,X2,Y2:Byte;
Begin
 If(IsGrf)and(MediaSupport)Then Begin
  PutTaskIcon($FF,icnFolder,False);
 End;
 FM:=HNewManual(Windows,wnFileManager,X1,Y1,X2,Y2);
 If(FM<>NIL)Then Begin
  FMExplorer(FM^,X1,Y1,X2,Y2);
  SetMnuSwitch;
 End;
End;

Procedure MakeCadre;Begin
 If(HModel(Windows)=wnEdit)Then Begin
  TEMakeCadre(EditorApp(HPtr(Windows)^));
 End;
End;

Procedure RunPlayMod;
Var
 Path:String;
Begin
 Path:=OpenWin('*.WAV','Joueur de la musique');
 If Path<>''Then Begin
  _LoadWave(Path);
  _PlayWave;
 End;
End;

Procedure TileWindows;
Const MinXTxts=0;
Var
 O:TextBoxRec;
 I:Word;
 MinYTexts,MaxYTexts:Byte;
Begin
 MinYTexts:=1+LnsMnu+Windows.HomeYEditor;
 MaxYTexts:=YTaskMnu-1;
 Case(Windows.Lst.Count)of
  1:If(@Windows.CurrHWin^.ReSize<>NIL)Then Begin
   O:=Windows.CurrModel^.X.W.T;
   If Not((O.X1=MinXTxts)and(O.Y1=MinYTexts)and
          (O.X2=MaxXTxts)and(O.Y2=MaxYTexts))Then Zoom;
  End;
  2:For I:=0to 1do Begin
   HGotoNum(Windows,I);
   If I=0Then Begin
    O.Y1:=MinYTexts;
    O.Y2:=((MaxYTexts-MinYTexts)shr 1)+MinYTexts;
   End
    Else
   Begin
    O.Y1:=((MaxYTexts-MinYTexts)shr 1)+MinYTexts+1;
    O.Y2:=MaxYTexts;
   End;
   HReSize(Windows,MinXTxts,O.Y1,MaxXTxts,O.Y2);
  End;
 End;
End;

Function GetFileSign(Const Buffer):Word;
Var
 HeaderList:DataSetInMemory;
 S:String;
Begin
 DBOpenServerName(ChantalServer,'CHANTAL:/Fichier/Entete/Extensior.Dat');
 DBCopyToMemory(ChantalServer,HeaderList);
 If DBLocateAbsIM(HeaderList,3,Buffer,[soCharCompare])Then
  GetFileSign:=HeaderList.CurrRec.Word^
 Else
  GetFileSign:=0;
 DBDispose(HeaderList);
End;

Procedure OpenSelection(Path:String;Mode:Byte);
Label Xit;
Var
 Ext:String;
 Header:Array[0..255]of Char;
 Format:Word;
Begin
 If Path<>''Then Begin
  Ext:=Path2Ext(Path);
  Case(Mode)of
   0,255:Begin
    GetFile(Path,0,SizeOf(Header),Header);
    Case GetFileSign(Header)of
     cfoImi:Begin
      HLoad(Windows,wnTechDraw,Path);
      Goto Xit;
     End;
     cfoMGC,cfoLotus123:Begin
      HLoad(Windows,wnSuperCalc,Path);
      Goto Xit;
     End;
     cfoIconAdele,cfoIconWindows,cfoIconOS2,cfoIconOS2,
     cfoIconOS2,cfoIconGemDesktop:Begin
      _OpenIcnEdt(Path);
      Goto Xit;
     End;
     Else Begin
      Format:=RIDefaultImage(errHdl,Header);
      If Format>0Then Begin
       Case(Format)of
        {diIconAdele,}diIconWindows{,diIconOS2,diIconOS2,
        diIconOS2,diIconGemDesktop}:_OpenIcnEdt(Path);
        diTIFF:If Ext='.3DS'Then HLoad(Windows,wnTechDraw,Path)
                            Else OpenDraw(Path);
        Else OpenDraw(Path);
       End;
       Goto Xit;
      End;
     End;
    End;
   End;
   cfoLotus123,cfoMGC:Begin
    HLoad(Windows,wnSuperCalc,Path);
    Goto Xit;
   End;
  End;
  If(Pos(Ext,'.EXE;.COM')>0)and(ModePH)Then HLoad(Windows,wnDebug,Path)
   Else
  If(Ext='.3DS')Then HLoad(Windows,wnTechDraw,Path)Else
  If Ext='.CSV'Then HLoad(Windows,wnSuperCalc,Path)Else
  If(Length(Ext)=4)and(Pos(Ext,'.CUR;.ICN;.ICO')>0)Then _OpenIcnEdt(Path)Else
  If(Length(Ext)=4)and(Pos(Ext,'.BMP;.GFX;.BGX;.PCX;.GIF;.RES;.GPX'+
                               '.TIF;.CPT;.CDR;.IMG;.XBM;.LBM;.BBM')>0)Then OpenDraw(Path)Else
  If(Length(Ext)=4)and(Pos(Ext,'.FNT')>0)Then _OpenFont(Path)Else
  {$IFDEF Developpeur}
   If Ext='.LGO'Then Begin
    OpenLogo(Path);
   End
    Else
  {$ENDIF}
  If(Ext='.WAV')or(Ext='.VOC')Then Begin
   _LoadWave(Path);
   _PlayWave;
  End
   Else
  If Pos(Ext,'.DBF;.DAT')>0Then OpenDataBase(Path)
   Else
  Begin
   If(Mode=cfoGAT)Then Begin
    If Not FileExist(Path)Then Path:=Path2NoExt(Path)+'.GAT';
   End;
   HLoad(Windows,wnEdit,Path);
   If GetSysErr>0Then Begin
    HClose(Windows);
    If(ProgramsManagerApp(HPtr(Windows)^).Mode=mWin9X)Then Begin
     HInTaskBar(Windows);
    End
   End;
  End;
 End;
Xit:
 SetMnuSwitch;
End;

Procedure _OpenSelection;
Var
 Path:String;
 FL:^FileListBox;
 Model:Word;
Begin
 FL:=HPtr(Windows);
 Path:=FL^.Path;
 Model:=FL^.Model;
 HClose(Windows);
 OpenSelection(Path,Model);
End;

{Procedure FillMode;Begin
 DrawEditApp(HPtr(Windows)^).Fill:=Not DrawEditApp(HPtr(Windows)^).Fill;
 IsFill:=DrawEditApp(HPtr(Windows)^).Fill;
End;}

Procedure FillMode;Assembler;ASM
 LES DI,Windows.CurrModel
 XOR ES:[DI].WindowApp.P.DrawEdit.Fill,1
 MOV AL,ES:[DI].WindowApp.P.DrawEdit.Fill
 MOV Application.IsFill,AL
END;

Procedure SelectWildCard;Begin
 FMSelWildCard(FileManagerApp(HPtr(Windows)^));
End;

Procedure UnselectWildCard;Begin
 FMUnSelWildCard(FileManagerApp(HPtr(Windows)^));
End;

Procedure InverseWildCard;Begin
 FMInverseWildCard(FileManagerApp(HPtr(Windows)^));
End;

Procedure SetColor;Begin
 If(HModel(Windows)=wnDraw)Then Begin
  DWSetColor(DrawEditApp(HPtr(Windows)^));
 End;
End;

{$IFDEF Developpeur}
 Procedure SQLCommand;Begin
  HNew(Windows,wnSQL);
 End;
{$ENDIF}

Procedure OpenSearchFiles;
Var
 WinSearch:^WinsSearchFiles;
Begin
 WinSearch:=HPtr(Windows);
 OpenFile(WinSearch^.X^.S+WinSearch^.X^.H.Name);
End;

{$IFDEF Reseau}
 Procedure BBSWelcome;Begin
  OpenHelp(BBSPath+'WELCOME.MSG','Message de Bienvenue du BBS');
 End;
{$ENDIF}

Procedure CpyFiles;Begin
 Case(HModel(Windows))of
  wnFileManager:FMCopyFiles(FileManagerApp(HPtr(Windows)^),False);
 End;
End;

Procedure MinimiseAllWindows;
Var
 CurrModel:^InternalModel;
 I:SmallInt;
 Maximised:Boolean; { Il y a-t-il au moins une fenˆtre de maximiser? }
Begin
 Maximised:=False;
 For I:=0to Windows.Lst.Count-1do Begin
  CurrModel:=_ALGetBuf(Windows.Lst,I);
  If(CurrModel^.Model<>wnProgMan)Then Begin
   If(CurrModel^.InTaskBar)Then Maximised:=True;
  End
   Else
  CurrModel^.InTaskBar:=True;
 End;
 If(Maximised)Then Begin
  For I:=0to Windows.Lst.Count-1do Begin
   CurrModel:=_ALGetBuf(Windows.Lst,I);
   CurrModel^.InTaskBar:=False;
  End;
  HRefreshOtherWindows(Windows);
  HRefresh(Windows);
 End
  Else
 Begin
  For I:=0to Windows.Lst.Count-1do Begin
   CurrModel:=_ALGetBuf(Windows.Lst,I);
   CurrModel^.InTaskBar:=Ya;
  End;
  HRefreshBackground(Windows);
 End;
End;

Procedure NewFolder;
Var
 Data:ProgramRec;
 B:Word;
Begin
 FillClr(Data,SizeOf(Data));
 Data.Icon:='ICON\FOLDER32.ICO';
 If ExecuteAppDPU(94,Data)Then Begin
  If Data.Path[Length(Data.Path)]<>'\'Then IncStr(Data.Path,'\');
  SearchFreeZoneForIcon(Data);
  InsItemDesktop(Data);
  OpenFolderWindow(Data.Name,Data.Path);
 End;
End;

{ Cette proc‚dure permet l'ouverture d'une fenˆtre de style Windows ou OS/2
 d'Explorer donnant accŠs … une liste de fichiers avec les ic“nes associ‚es.
}

Procedure OpenFolderWindow(Const Name,Path:String);Begin
 HLoad(Windows,wnProgMan,Path+'|'+Name);
End;

Procedure OnStatusCompiler(Var Q;Var Context;Line:LongInt);Far;
Var
 W:Window Absolute Context;
Begin
 WEPutTxtXY(W,33,5,CStr(Line));
End;

{$IFDEF Developpeur}
 Procedure RunBasic(Var Q:EditorApp);
 Var
  B:BasicStruct;
  CurrMode:Word;
 Begin
  If BasicInit(B)Then Begin
   B.MainSource:=Q.EditName;
   If Not BasicRun(B,Q.List)Then Begin
    TEGotoXY(Q,B.X,B.Line);
    ErrMsgOk(BasicErrExitCodeStr(B));
   End;
  End
   Else
  ErrNoMsgOk(OutOfMemory);
  BasicDone(B);
  HRefresh(Windows);
 End;
{$ENDIF}

{$IFDEF Developpeur}
 Procedure Compile;
 Var
  Q:^EditorApp;

  Procedure CompileSQL;
  Var
   DS:DataSet;
   W:Window;
  Begin
   DBInit(DS,Path2NoExt(Q^.EditName)+'.DAT');
   WEInitO(W,60,10);
   WEPushWn(W);
   WEPutWnKrDials(W,'Compilation');
   WEBar(W);
   WELn(W);
   WEPutTxtLn(W,'tat                           = Compilation');
   WEPutTxtLn(W,'Source principal               = '+Path2NoDir(Q^.EditName));
   WEPutTxtLn(W,'Source courante                = '+Path2NoDir(Q^.EditName));
   WEPutTxtLn(W,'Nom du programme de sortie     = '+Path2Name(Q^.EditName)+'.DAT');
   WEPutTxtLn(W,'Nombre de ligne(s) compil‚     =');
   DS.OnStatusCompiler:=OnStatusCompiler;
   DS.OnStatusCompilerContext:=@W;
   If Not DBCreateWithSQL(DS,Q^.List,errHdl)Then ErrNoMsgOk(SQLError);
   WEPutTxtXY(W,33,1,StrUSpc('Terminer.',32));
   While WEOk(W)do;
   WEDone(W);
   DBDone(DS);
  End;

 Begin
  Q:=HPtr(Windows);
  If(HModel(Windows)=wnEdit)Then Begin
   Case(Q^.Mode)of
    vtBas:RunBasic(Q^);
    vtRC:Begin
     MakeRLLFile(Q^.EditName,Q);
     DefEndBar;
    End;
    Else Begin
     If Path2Ext(Q^.EditName)='.SQL'Then CompileSQL
                                    Else CallFile(False);
    End;
   End;
  End
   Else
  CallFile(False)
 End;
{$ENDIF}

Procedure CallHexView;
Var
 App:Pointer;
 Editor:^EditorApp Absolute App;
 Partition:^PartitionManagerApp Absolute App;
Begin
 App:=HPtr(Windows);
 If(HModel(Windows)=wnPartitionManager)Then Begin

  HexView(WordToStr(Partition^.LC-$80)+'[PARTITION]|'+IntToStr(Partition^.Partition));
 End
  Else
 HexView(GetNameAtCursor);
End;

Procedure OpenPartitionManager;
Var
 App:Pointer;
 FileManager:^FileManagerApp Absolute App;
 Path:String;
Begin
 Path:='';
 App:=HPtr(Windows);
 Case HModel(Windows)of
  wnFileManager:Path:=FMGetCurrName(FileManager^);
 End;
 HLoad(Windows,wnPartitionManager,Path);
 SetMnuSwitch;
End;

Procedure AgendaWindow;Begin
 MakeApplication(wnAgenda);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Proc‚dure Print                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'imprimer le contenu d'une fenˆtre dans son
 format devant ˆtre imprimer: Document, texte ASCII,...
}

Procedure Print;Begin
 Case HModel(Windows)of
  wnEdit:TEPrn(EditorApp(HPtr(Windows)^));
  wnFileManager:FMPrnFile(FileManagerApp(HPtr(Windows)^));
  wnAgenda:APPrnAll(AgendaApp(HPtr(Windows)^));
  Else ErrPrn;
 End;
End;

Procedure FindPerson;Begin
 SearchPerson;
End;

Procedure WinGlobalDraw;Begin
 MakeApplication(wnGlobalDraw);
End;

Procedure NewDataBase;Begin
 MakeApplication(wnDataBase);
End;

Procedure ChangeDiskOnBoard2;
Var
 Dsk,Out:Byte;
 Ptr:Pointer;
 FM:^FileManagerApp Absolute Ptr;
Begin
 Ptr:=HPtr(Windows);
 Case HModel(Windows)of
  wnFileManager:Begin
   Dsk:=Path2Dsk(FMGetPath(FM^))+1;
   Out:=SelectDisk(Dsk);
   If Out=$FFThen Exit;
   If(Out<>Dsk)or(FM^.Panel[1].Board<>BoardFile)Then
    FMSetPath(FM^,1,Char(Out+Byte('@'))+':*.*');
  End;
 End;
End;

Procedure XAltF1Key;
Var
 Dsk,Out:Byte;
 App:Pointer;
 FileManager:^FileManagerApp Absolute App;
 GlobalDraw:^GlobalDrawApp Absolute App;
Begin
 App:=HPtr(Windows);
 Case HModel(Windows)of
  wnGlobalDraw:Begin
   Dsk:=Path2Dsk(GlobalDraw^.Path)+1;
   Out:=SelectDisk(Dsk);
   If Out=$FFThen Exit;
   If(Out<>Dsk)Then GDChangePath(GlobalDraw^,Char(Out+Byte('@'))+':\');
  End;
  wnFileManager:Begin
   Dsk:=Path2Dsk(FMGetPath(FileManager^))+1;
   Out:=SelectDisk(Dsk);
   If Out=$FFThen Exit;
   If(Out<>Dsk)Then
    FMSetPath(FileManager^,0,Char(Out+Byte('@'))+':*.*');
  End;
 End;
End;

Procedure EditFileMenu;Begin
 {$IFDEF Reseau}
  OpenHelp(BBSPath+'MENUFILE.MSG','Menu de Fichier du BBS')
 {$ELSE}
  BadDistribution;
 {$ENDIF}
End;

Procedure EditMainMenu;Begin
 {$IFDEF Reseau}
  OpenHelp(BBSPath+'MENUPRIN.MSG','Menu Principal du BBS')
 {$ELSE}
  BadDistribution;
 {$ENDIF}
End;

{Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'ouvrir la liste de menu d'application pour ˆtre
 ‚dit‚ … l'int‚rieur d'une fenˆtre d'application.
}

Procedure EditMenuApplication;Begin
 OpenHelp('LOADER.MNU','Editeur de Menu d''Application')
End;

{Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'‚changer 2 pages d'un traŒtement de texte de
 document dans une fenˆtre d'application si elle le supporte.
}

Procedure EditXChgPg;
Var
 PgA,PgB:RBP;
Begin
 Case HModel(Windows)of
  wnEdit:Begin
   PgA:=0;PgB:=0;
   If GetXChgPg(PgA,PgB)Then
    TEXChgPg(EditorApp(HPtr(Windows)^),PgA,PgB);
  End;
 End;
End;

{Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'ex‚cuter un macro dans le traŒtement de texte de
 la fenˆtre d'application courante si celle si est appropri‚.
}

Procedure ExecuteMacro;
Var
 Path:String;
Begin
 Path:=OpenWin(SetPath4AddFile(StrPas(PathMac))+'*.MAC','Execute Macro');
 If Path<>''Then If(HModel(Windows)=wnEdit)Then
  TEExecMacro(EditorApp(HPtr(Windows)^),Path);
End;

{Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de changer l'attribut d'un fichier quand on utilise
 le gestionnaire de fichier par exemple.
}

Procedure FileSetAttribut;
Var
 App:Pointer;
 FileManager:^FileManagerApp Absolute App;
 DrawEdit:^DrawEditApp Absolute App;
Begin
 App:=HPtr(Windows);
 Case HModel(Windows)of
  wnFileManager:FMSetAttr(FileManager^);
  wnDraw:DWMagnify(DrawEdit^,Not DrawEdit^.Canvas.Magnify);
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Proc‚dure ViewDownload                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet … l'usager de consulter la liste des fichiers
 pouvant ˆtre envoyer lors du mode BBS du terminal.
}

Procedure ViewDownload;Begin
 {$IFDEF Reseau}
  OpenHelp(BBSPath+'FILES.LST','Liste des fichiers Download')
 {$ELSE}
  BadDistribution;
 {$ENDIF}
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure WriteBlock                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure ‚crit un bloque sur disque choisie sur dans la fenˆtre
 courant.
}

Procedure WriteBlock;
Var
 App:Pointer;
 Editor:^EditorApp Absolute App;
 IconEdit:^IconEditApp Absolute App;
Begin
 App:=HPtr(Windows);
 Case HModel(Windows)of
  {$IFDEF Developpeur}
   wnIcon:IESaveIcon(IconEdit^);
  {$ENDIF}
  wnEdit:TEWriteBlk(Editor^);
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure RunBBS                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'enclencher le mode BBS lorsque la fenˆtre
 ouverte courante est de type terminal de communication.
}

{$IFDEF Reseau}
 Procedure RunBBS;Begin
  If(HModel(Windows)=wnTerm)Then TAHostMode(Term(HPtr(Windows)^));
 End;
{$ENDIF}

Procedure ChangeCase;
Var
 FormChangeCase:Record
  CaseChoice:Byte;
 End;
Begin
 FillClr(FormChangeCase,SizeOf(FormChangeCase));
 If ExecuteAppDPU(105,FormChangeCase)Then Begin
 End;
End;

Procedure ExecMenu;Begin
 ExecPrg(LoaderMenuApp(HPtr(Windows)^).NameL,
         LoaderMenuApp(HPtr(Windows)^).ParamL);
End;

Procedure LineHor;Begin
 TELineHor(EditorApp(HPtr(Windows)^),True);
End;

Procedure HMenuTitleIcon(X,Y:Byte;Level:Word);Far;Begin
 LeftCenterIcon(X shl 3,GetRawY(Y+3),Black);
 JustifyCenterIcon(X shl 3,GetRawY(Y+4),Black);
 RightCenterIcon(X shl 3,GetRawY(Y+5),Black);
 ZoomIcon(X,Y+7,$F);
 PutTaskBarIcon(X,Y+8,$F);
 CloseIcon(X,Y+12,$F);
End;

Procedure HMenuTitle(Var Context);
Label Update;
Var
 Q:HWins Absolute Context;
 CM:ContextMenu;
 TM:MainMnuPtr;
 K:Word;
Begin
 WaitMouseBut0;
 __HideMousePtr;
 CMLoadApp(CM,108);
 ALSetPtr(MainMenu.Mnu,0);
 If(IsGrf)Then Begin
  MainMenu.Space4Icon:=2;
  MainMenu.IconRoutine:=HMenuTitleIcon;
 End;
 TM:=_ALGetCurrBuf(MainMenu.Mnu);
 K:=PMExecMnu(LastMouseX,LastMouseY+1,TM^.Lst,TM^.P);
 CMDone(CM);
 Case(K)of
  $F001:Begin
   SetImageBar;
   HRefresh(Windows);
  End;
  $F002:SetSoundWindows;
  $F003:Begin
   TitleCenter:=__Left__;
   Goto Update;
  End;
  $F004:Begin
   TitleCenter:=__Justified__;
   Goto Update;
  End;
  $F005:Begin
   TitleCenter:=__Right__;
Update:
   HRefresh(Windows);
   CreateKeyFormat(HKEY_CURRENT_USER,'Window','TitleJustified',tdByte,TitleCenter);
  End;
  $F006,$F008:HRefresh(Windows);
  $F007:HInTaskBar(Windows);
  $F009:Begin
   HClose(Windows);
   SetMnuSwitch;
  End;
  kbMouse:WaitMouseBut0;
 End;
 __ShowMousePtr;
End;

Procedure EditImage;
Var
 Edit:^EditorApp;
 PImage:^DrawInEdt;
Begin
 Case HModel(Windows)of
  wnEdit:Begin
   Edit:=HPtr(Windows);
   If Edit^.Processus.Count>0Then Begin
    PImage:=_ALGetCurrBuf(Edit^.Processus);
    If(PImage<>NIL)Then Begin
     __HideMousePtr;
     OpenDraw(PImage^.Path);
    End;
   End;
  End;
 End;
End;

Procedure SautPage;Begin
 Case HModel(Windows)of
  wnEdit:TESaut(EditorApp(HPtr(Windows)^));
 End;
End;

Procedure TBMLoad(Var Context;X1,Y1,X2,Y2:Byte;Const Path:String);
Var
 Q:TaskBarManager Absolute Context;
Begin
 FillClr(Q,SizeOf(Q));
 WEInit(Q.W,0,GetNmYTxts+1,MaxXTxts,GetNmYTxts+1);
 Q.Title:=Path;
End;

Function TBMTitle(Var Context;Max:Byte):String;
Var
 Q:TaskBarManager Absolute Context;
Begin
 TBMTitle:=Q.Title;
End;

Procedure UpdateTaskBar;
Label Restart;
Var
 I:SmallInt;
 Model:^Byte;
Begin
Restart:
 ALSetPtr(Windows.Lst,0);
 For I:=0to Windows.Lst.Count-1do Begin
  Model:=_ALGetCurrBuf(Windows.Lst);
  If(Model^=wnTaskBarMgr)Then Begin
   If Not HFastClose(Windows,I)Then Exit;
   Goto Restart;
  End;
  ALNext(Windows.Lst);
 End;
 _HGotoNum(Windows,0,False);
 LoadTaskBarApp;
End;

Procedure SearchCity;Begin
 {$IFDEF Educative}
  FindCity;
 {$ELSE}
  BadDistribution;
 {$ENDIF}
End;

Procedure SearchCountry;Begin
 {$IFDEF Educative}
  FindCountry;
 {$ELSE}
  BadDistribution;
 {$ENDIF}
End;

{$IFDEF Developpeur}
 Procedure NewBasic;
 Var
  Editor:^EditorApp;
 Begin
  _NewEdt;
  Editor:=HPtr(Windows);
  If(Editor<>NIL)Then Begin
   ReadMainKey(HKEY_CURRENT_USER,'Software\Basic','DefaultMode',Editor^.ModeSub);
   TESetViewMode(Editor^,vtBas);
  End;
  SetMnuSwitch;
 End;
{$ENDIF}

{$IFDEF Developpeur}
 Procedure NewExplorerDB;Begin
  HNew(Windows,wnExplorerDataBase);
 End;
{$ENDIF}

Procedure SendMail;
Var
 App:Pointer;
 Agenda:^AgendaApp Absolute App;
 Email:^EmailApp Absolute App;
 EmailTo:String;
Begin
 App:=HPtr(Windows);
 Case HModel(Windows)of
  wnAgenda:EmailTo:=APGetCurrEmail(Agenda^);
  Else EmailTo:='';
 End;
 If(HNew(Windows,wnEmail))Then Begin
  SetMnuSwitch;
  Email:=HPtr(Windows);
  EMSendTo(Email^,EmailTo);
 End;
End;

Procedure OpenAtlas;Begin
 MakeApplication(wnAtlas);
End;