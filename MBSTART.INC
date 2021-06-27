{$I DEF.INC}

Uses
 Systex;

Type
 StartUpInfoRec=Record
  Verbose,NoSVGA,NoKey,InfoSys,NoChgMode,Setup,
  NotSoundCard,CmdVideo,ImageFound,UMB,NoMouse:Boolean;
  CmdIsGrf,NoPres,Enreg,XmsOvrSwap,OpenFileManager:Boolean;
  CmdX,CmdY,CmdBPP:Word;
  LoadFiles:ArrayList;
  Path,PathDesktop:String;
 End;

Var
 SUP:^StartUpInfoRec;

Function  Assistant:Byte;
Function  EnregPrg(Config:Boolean):ShortInt;
Procedure LoadMalteCountry;
Procedure LoadNewMtx(K:Byte);
Procedure LoadTaskBarApp;
Procedure MnuInfo;
Procedure MnuSetup(Reset:Boolean);
Procedure Initialize;
Procedure FinishStart;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                              IMPLEMENTATION
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses
 Adele,
 {$IFDEF Real}
  Overlay,
 {$ENDIF}
 Restex,Show,SysPlus,Mouse,
 {$IFDEF Reseau}
  CommBase,
 {$ENDIF}
 Disk,dialex,Isatex,SysInter,Memories,Systems,Video,Dials,Tools,ToolInfo,
 ToolVid,Editex,Editor,
 FileMana,
 InfoMemo,
 {$IFDEF FullVersion}
  MBBoot,
  MBBkRes,
  MBConfig,
  MBMenu,
  MBSave,
  MalEnv,
  MalLibra,
  MBCortex,
  MBInstal,
  MBShell,
  MBInitSc,
  MBExit,
  ExplorDB,
  Geo,
 {$ENDIF}
 {$IFDEF BureauVersion}
  MBBBoot,
  MBBBkRes,
  MBBConfi,
  MBBMenu,
  MBBSave,
  MalBEnv,
  MalBLibr,
  MBBCrtex,
  MBBInsta,
  MBBShell,
  MBBInitS,
  MBBExit,
 {$ENDIF}
 {$IFDEF CAOVersion}
  MBCBoot,
  MBCConfi,
  MBCMenu,
  MBCSave,
  MalCEnv,
  MalCLibr,
  MBCCrtex,
  MBCInsta,
  MBCShell,
  MBCInitS,
  MBCExit,
 {$ENDIF}
 {$IFDEF DeveloppeurVersion}
  MBDBoot,
  MBDConfi,
  MBDMenu,
  MBDSave,
  MalDEnv,
  MalDLibr,
  MBDCrtex,
  MBDInsta,
  MBDShell,
  MBDInitS,
  MBDExit,
  ExplorDB,
 {$ENDIF}
 {$IFDEF GamesVersion}
  MBGBoot,
  MBGConfi,
  MBGMenu,
  MBGSave,
  MalGEnv,
  MalGLibr,
  MBGCrtex,
  MBGInsta,
  MBGShell,
  MBGInitS,
  MBGExit,
 {$ENDIF}
 {$IFDEF ReseauVersion}
  MBRBoot,
  MBRConfi,
  MBRMenu,
  MBRSave,
  MalREnv,
  MalRLibr,
  MBRCrtex,
  MBRInsta,
  MBRShell,
  MBRInitS,
  MBRExit,
 {$ENDIF}
 ToolTerm,
 ToolPrn,
 ToolTime,
 EdtLoad,
 EdtDone,
 EdtExtra,
 DrawEdit,
 {$IFDEF Bureau}
  MalCalc,
  CalcLoad,
  CalcSave,
  Agenda,
 {$ENDIF}
 {$IFDEF Reseau}
  Email,
  TMDials,
  Protocol,
 {$ENDIF}
 Numerix,
 Loader,
 ProgMan,
 FontEdt,
 ToolView,
 Pritex,
 ResServI,
 DialPlus,
 EdtSave,
 EdtSearc,
 Volume,
 {$IFDEF Games}
  Tetris,
  Missile,
  Nibbles,
 {$ENDIF}
 ToolSoun,
 Sound,
 ToolDsk,
 {$IFDEF CAO}
  TechDraw,
 {$ENDIF}
 Apps,
 GloDraw,
 ResServD,
 {$IFDEF Developpeur}
  SQLCmd,
  Sourcer,
  EditIcon,
  QHexView,
  MBDebug,
  MBDebugT,
  Logo,
  WS,
 {$ENDIF}
 TaskMgr,
 AppDB,
 Registry;

Const
 NumApp=33;
 LstHWin:Array[0..NumApp]of HWin=(
  (SerialNumber:wnEdit;
   Init:TENew;
   Load:TEOpen;
   Run:TERun;
   Done:TEDone;
   Refresh:TERefresh;
   Save:TESave;
   SaveAs:TESaveAs;
   SizeOfQ:SizeOf(EditorApp);
   Title:TETitle;
   ReSize:TEReSize;
   NumXTexts:0;
   NumYTexts:0;
   OnDeactivate:NIL;
   Move2:TEMove2),
  (SerialNumber:wnView;
   Init:NIL;
   Load:VALoad;
   Run:VARun;
   Done:VADone;
   Refresh:VARefresh;
   Save:NIL;
   SaveAs:NIL;
   SizeOfQ:SizeOf(ViewAsciiApp);
   Title:VATitle;
   ReSize:VAReSize;
   NumXTexts:0;
   NumYTexts:0;
   OnDeactivate:NIL;
   Move2:VAMove2),
  ({$IFDEF Developpeur}
    SerialNumber:wnIcon;
    Init:IENew;
    Load:IELoad;
    Run:IERun;
    Done:IEDone;
    Refresh:IERefresh;
    Save:IESave;
    SaveAs:IESaveAs;
    SizeOfQ:SizeOf(IconEditApp);
    Title:IETitle;
    ReSize:NIL;
    NumXTexts:0;
    NumYTexts:0;
    OnDeactivate:NIL;
    Move2:IEMove2
   {$ELSE}
    SerialNumber:0
   {$ENDIF}),
  (SerialNumber:wnDraw;
   Init:DWNew;
   Load:DWOpen;
   Run:NIL;
   Done:DWDone;
   Refresh:DWRefresh;
   Save:DWSave;
   SaveAs:DWSaveAs;
   SizeOfQ:SizeOf(DrawEditApp);
   Title:DWTitle;
   ReSize:DWReSize;
   NumXTexts:0;
   NumYTexts:0;
   OnDeactivate:NIL;
   Move2:DWMove2;
   OnWaiting:DWBackOperation;
   OnKeyPress:DWOnKeyPress;
   OnKeyDown:DWOnKeyDown;
   OnKeyUp:NIL;
   OnMouseDown:DWOnMouseDown;
   OnMouseUp:NIL;
   OnMouseMove:DWOnMouseMove;
   OnMouseControl:DWOnMouseControl),
  ({$IFDEF Bureau}
    SerialNumber:wnSuperCalc;
    Init:SCNew;
    Load:SCLoadClassic;
    Run:SCRun;
    Done:SCDone;
    Refresh:SCRefresh;
    Save:SCSave;
    SaveAs:SCSaveAs;
    SizeOfQ:SizeOf(SuperCalcApp);
    Title:SCTitle;
    ReSize:SCReSize;
    NumXTexts:0;
    NumYTexts:0;
    OnDeactivate:NIL;
    Move2:SCMove2
   {$ELSE}
    SerialNumber:0
   {$ENDIF}),
  (SerialNumber:wnFileManager;
   Init:FMInit;
   Load:NIL;
   Run:FMRun;
   Done:FMDone;
   Refresh:_FMRefresh;
   Save:NIL;
   SaveAs:NIL;
   SizeOfQ:SizeOf(FileManagerApp);
   Title:FMTitle;
   ReSize:FMReSize;
   NumXTexts:0;
   NumYTexts:0;
   OnDeactivate:NIL;
   Move2:FMMove2),
  (SerialNumber:wnPrmpt;
   Init:PDInit;
   Load:NIL;
   Run:PDRun;
   Done:PDDone;
   Refresh:PDRefresh;
   Save:NIL;
   SaveAs:NIL;
   SizeOfQ:SizeOf(Prompt);
   Title:PDTitle;
   ReSize:PDReSize;
   NumXTexts:0;
   NumYTexts:0;
   OnDeactivate:NIL;
   Move2:PDMove2),
  ({$IFDEF Reseau}
    SerialNumber:wnTerm;
    Init:NIL;
    Load:TANew;
    Run:TARun;
    Done:TADone;
    Refresh:TMRefresh;
    Save:NIL;
    SaveAs:NIL;
    SizeOfQ:SizeOf(Term);
    Title:TMTitle;
    ReSize:NIL;
    NumXTexts:0;
    NumYTexts:0;
    OnDeactivate:NIL
   {$ELSE}
    SerialNumber:0
   {$ENDIF}),
  (SerialNumber:wnUnix;
   Init:PUInit;
   Load:NIL;
   Run:PDRun;
   Done:PDDone;
   Refresh:PDRefresh;
   Save:NIL;
   SaveAs:NIL;
   SizeOfQ:SizeOf(Prompt);
   Title:PDTitle;
   ReSize:PDReSize;
   NumXTexts:0;
   NumYTexts:0;
   OnDeactivate:NIL;
   Move2:PDMove2),
 ({$IFDEF Developpeur}
   SerialNumber:wnHexView;
   Init:NIL;
   Load:HVLoad;
   Run:HVRun;
   Done:HVDone;
   Refresh:HVRefresh;
   Save:HVSave;
   SaveAs:NIL;
   SizeOfQ:SizeOf(HexEditApp);
   Title:HVTitle;
   ReSize:NIL;
   NumXTexts:HexViewNumXTxts;
   NumYTexts:HexViewNumYTxts;
   OnDeactivate:NIL;
   Move2:HVMove2
  {$ELSE}
   SerialNumber:0
  {$ENDIF}),
 (SerialNumber:wnPC;
   Init:WWInit;
   Load:NIL;
   Run:WWRun;
   Done:WWDone;
   Refresh:WWRefresh;
   Save:NIL;
   SaveAs:NIL;
   SizeOfQ:SizeOf(WatchWin);
   Title:WWTitle;
   ReSize:NIL;
   NumXTexts:0;
   NumYTexts:0;
   OnDeactivate:NIL;
   Move2:WWMove2),
 (SerialNumber:wnCalendar;
   Init:CAInit;
   Load:NIL;
   Run:CARun;
   Done:CADone;
   Refresh:CARefresh;
   Save:NIL;
   SaveAs:NIL;
   SizeOfQ:SizeOf(CalendarApp);
   Title:CATitle;
   ReSize:NIL;
   NumXTexts:MaxXCalendar;
   NumYTexts:MaxYCalendar;
   OnDeactivate:NIL;
   Move2:CAMove2),
 (SerialNumber:wnMnu;
   Init:MAInit;
   Load:NIL;
   Run:MARun;
   Done:MADone;
   Refresh:NIL;
   Save:NIL;
   SaveAs:NIL;
   SizeOfQ:SizeOf(LoaderMenuApp);
   Title:MATitle),
 (SerialNumber:wnFont;
   Init:NIL;
   Load:FELoad;
   Run:FERun;
   Done:FEDone;
   Refresh:FERefresh;
   Save:FESave;
   SaveAs:FESaveAs;
   SizeOfQ:SizeOf(FontEditor);
   Title:FMTitle;
   ReSize:NIL;
   NumXTexts:0;
   NumYTexts:0;
   OnDeactivate:NIL;
   Move2:FEMove2),
 ({$IFDEF Developpeur}
   SerialNumber:wnDebug;
   Init:NIL;
   Load:DELoadProgram;
   Run:RunDebugProgram;
   Done:DoneDebug;
   Refresh:RefreshDebug;
   Save:NIL;
   SaveAs:NIL;
   SizeOfQ:SizeOf(DebugRec);
   Title:DETitle;
   ReSize:NIL;
   NumXTexts:0;
   NumYTexts:0;
   OnDeactivate:NIL;
   Move2:DEMove2
  {$ELSE}
   SerialNumber:0
  {$ENDIF}),
 (SerialNumber:wnProgMan;
   Init:PMWInit;
   Load:PMWLoad;
   Run:PMWRun;
   Done:PMWDone;
   Refresh:PMWRefresh;
   Save:NIL;
   SaveAs:NIL;
   SizeOfQ:SizeOf(ProgramsManagerApp);
   Title:PMWTitle;
   ReSize:PMWReSize;
   NumXTexts:0;
   NumYTexts:0;
   OnDeactivate:PMWInActif;
   Move2:PMWMove2),
 ({$IFDEF Games}
   SerialNumber:wnTetris;
   Init:TetrisInit;
   Load:NIL;
   Run:TetrisPlay;
   Done:TetrisDone;
   Refresh:TetrisRefresh;
   Save:NIL;
   SaveAs:NIL;
   SizeOfQ:SizeOf(TetrisGame);
   Title:TetrisTitle;
   ReSize:NIL;
   NumXTexts:30;
   NumYTexts:23;
   OnDeactivate:NIL;
   Move2:TetrisMove2
  {$ELSE}
   SerialNumber:0
  {$ENDIF}),
 (SerialNumber:wnCDPlayer;
   Init:CDInitApp;
   Load:NIL;
   Run:CDRun;
   Done:CDDone;
   Refresh:CDRefresh;
   Save:NIL;
   SaveAs:NIL;
   SizeOfQ:SizeOf(CDPlayer);
   Title:CDTitle;
   ReSize:NIL;
   NumXTexts:36;
   NumYTexts:9;
   OnDeactivate:NIL;
   Move2:CDMove2),
 (SerialNumber:wnFileListBox;
   Init:FLInit;
   Load:NIL;
   Run:FLRun;
   Done:FLDone;
   Refresh:FLRefresh;
   Save:NIL;
   SaveAs:NIL;
   SizeOfQ:SizeOf(FileListBox);
   Title:FLTitle;
   ReSize:NIL;
   NumXTexts:0;
   NumYTexts:0;
   OnDeactivate:NIL;
   Move2:FLMove2),
 (SerialNumber:wnSearchFiles;
   Init:WSFInit4Search;
   Load:NIL;
   Run:WSFRun;
   Done:WSFDone;
   Refresh:WSFRefresh;
   Save:NIL;
   SaveAs:NIL;
   SizeOfQ:SizeOf(WinsSearchFiles);
   Title:WSFTitle;
   ReSize:WSFReSize;
   NumXTexts:0;
   NumYTexts:0;
   OnDeactivate:NIL;
   Move2:WSFMove2),
 ({$IFDEF Developpeur}
   SerialNumber:wnSQL;
   Init:SQLInit;
   Load:NIL;
   Run:SQLRun;
   Done:SQLDone;
   Refresh:SQLRefresh;
   Save:NIL;
   SaveAs:NIL;
   SizeOfQ:SizeOf(SQLCommandApp);
   Title:SQLTitle;
   ReSize:SQLResize;
   NumXTexts:0;
   NumYTexts:0;
   OnDeactivate:NIL;
   Move2:SQLMove2
  {$ELSE}
   SerialNumber:0
  {$ENDIF}),
 ({$IFDEF CAO}
   SerialNumber:wnTechDraw;
   Init:TDNew;
   Load:TDOpen;
   Run:NIL;
   Done:TDDone;
   Refresh:TDRefresh;
   Save:TDSave;
   SaveAs:TDSaveAs;
   SizeOfQ:SizeOf(TechDrawApp);
   Title:TDTitle;
   ReSize:NIL;
   NumXTexts:0;
   NumYTexts:0;
   OnDeactivate:NIL;
   Move2:NIL;
   OnWaiting:TDBackOperation;
   OnKeyPress:NIL;
   OnKeyDown:TDOnKeyDown;
   OnKeyUp:NIL;
   OnMouseDown:TDOnMouseDown;
   OnMouseUp:NIL;
   OnMouseMove:TDOnMouseMove;
   OnMouseControl:TDOnMouseControl
  {$ENDIF}),
  ({$IFDEF Bureau}
    SerialNumber:wnAgenda;
    Init:APInit;
    Load:NIL;
    Run:APRun;
    Done:APDone;
    Refresh:APRefresh;
    Save:NIL;
    SaveAs:NIL;
    SizeOfQ:SizeOf(AgendaApp);
    Title:APTitle;
    ReSize:NIL;
    NumXTexts:0;
    NumYTexts:0;
    OnDeactivate:NIL;
    Move2:APMove2;
    OnWaiting:NIL;
    OnKeyPress:NIL;
    OnKeyDown:NIL;
    OnKeyUp:NIL;
    OnMouseDown:NIL;
    OnMouseUp:NIL;
    OnMouseMove:NIL;
    OnMouseControl:NIL
   {$ELSE}
    SerialNumber:0
   {$ENDIF}),
  (SerialNumber:wnGlobalDraw;
   Init:GDInit;
   Load:NIL;
   Run:GDRun;
   Done:GDDone;
   Refresh:GDRefresh;
   Save:NIL;
   SaveAs:NIL;
   SizeOfQ:SizeOf(GlobalDrawApp);
   Title:GDTitle;
   ReSize:GDReSize;
   NumXTexts:0;
   NumYTexts:0;
   OnDeactivate:NIL;
   Move2:GDMove2;
   OnWaiting:NIL;
   OnKeyPress:NIL;
   OnKeyDown:NIL;
   OnKeyUp:NIL;
   OnMouseDown:NIL;
   OnMouseUp:NIL;
   OnMouseMove:NIL;
   OnMouseControl:NIL),
  ({$IFDEF Developpeur}
    SerialNumber:wnLogo;
    Init:LAInit;
    Load:LALoad;
    Run:LARun;
    Done:LADone;
    Refresh:LARefresh;
    Save:LASave;
    SaveAs:LASaveAs;
    SizeOfQ:SizeOf(LogoApp);
    Title:LATitle;
    ReSize:LAReSize;
    NumXTexts:0;
    NumYTexts:0;
    OnDeactivate:NIL;
    Move2:LAMove2;
    OnWaiting:NIL;
    OnKeyPress:NIL;
    OnKeyDown:NIL;
    OnKeyUp:NIL;
    OnMouseDown:NIL;
    OnMouseUp:NIL;
    OnMouseMove:NIL;
    OnMouseControl:NIL
   {$ELSE}
    SerialNumber:0
   {$ENDIF}),
  (SerialNumber:wnTaskBarMgr;
   Init:NIL;
   Load:TBMLoad;
   Run:NIL;
   Done:NIL;
   Refresh:NIL;
   Save:NIL;
   SaveAs:NIL;
   SizeOfQ:SizeOf(TaskBarManager);
   Title:TBMTitle),
  (SerialNumber:wnDataBase;
   Init:ADBNew;
   Load:ADBOpen;
   Run:ADBRun;
   Done:ADBDone;
   Refresh:ADBRefresh;
   Save:NIL;
   SaveAs:NIL;
   SizeOfQ:SizeOf(DataBaseApp);
   Title:ADBTitle;
   ReSize:ADBReSize;
   NumXTexts:0;
   NumYTexts:0;
   OnDeactivate:NIL;
   Move2:ADBMove2),
  (SerialNumber:wnPartitionManager;
   Init:PMAInit;
   Load:PMAOpen;
   Run:PMARun;
   Done:PMADone;
   Refresh:PMARefresh;
   Save:NIL;
   SaveAs:NIL;
   SizeOfQ:SizeOf(PartitionManagerApp);
   Title:PMATitle;
   ReSize:PMAReSize;
   NumXTexts:0;
   NumYTexts:0;
   OnDeactivate:NIL;
   Move2:NIL),
  ({$IFDEF Developpeur}
    SerialNumber:wnExplorerDataBase;
    Init:EDBNew;
    Load:NIL;
    Run:EDBRun;
    Done:EDBDone;
    Refresh:EDBRefresh;
    Save:NIL;
    SaveAs:NIL;
    SizeOfQ:SizeOf(ExplorerDataBaseApp);
    Title:EDBTitle;
    ReSize:EDBReSize;
    NumXTexts:0;
    NumYTexts:0;
    OnDeactivate:NIL;
    Move2:NIL
   {$ELSE}
    SerialNumber:0
   {$ENDIF}
   ),
  ({$IFDEF Games}
   SerialNumber:wnMissileCommand;
   Init:MissileCommandInit;
   Load:NIL;
   Run:MissileCommandPlay;
   Done:MissileCommandDone;
   Refresh:MissileCommandRefresh;
   Save:NIL;
   SaveAs:NIL;
   SizeOfQ:SizeOf(MissileCommandGame);
   Title:MissileCommandTitle;
   ReSize:NIL;
   NumXTexts:41;
   NumYTexts:24;
   OnDeactivate:NIL;
   Move2:MissileCommandMove2
  {$ELSE}
   SerialNumber:0
  {$ENDIF}),
  ({$IFDEF Games}
   SerialNumber:wnNibble;
   Init:NibbleInit;
   Load:NIL;
   Run:NibblePlay;
   Done:NibbleDone;
   Refresh:NibbleRefresh;
   Save:NIL;
   SaveAs:NIL;
   SizeOfQ:SizeOf(NibbleGame);
   Title:NibbleTitle;
   ReSize:NIL;
   NumXTexts:41;
   NumYTexts:24;
   OnDeactivate:NIL;
   Move2:NibbleMove2
  {$ELSE}
   SerialNumber:0
  {$ENDIF}),
  ({$IFDEF Developpeur}
    SerialNumber:wnWorkShop;
    Init:WSNew;
    Load:WSOpen;
    Run:WSRun;
    Done:WSDone;
    Refresh:WSRefresh;
    Save:NIL;
    SaveAs:NIL;
    SizeOfQ:SizeOf(WorkShopApp);
    Title:WSTitle;
    ReSize:WSReSize;
    NumXTexts:0;
    NumYTexts:0;
    OnDeactivate:NIL;
    Move2:NIL
   {$ELSE}
    SerialNumber:0
   {$ENDIF}
   ),
  ({$IFDEF Reseau}
    SerialNumber:wnEmail;
    Init:EMInit;
    Load:NIL;
    Run:EMRun;
    Done:EMDone;
    Refresh:EMRefresh;
    Save:NIL;
    SaveAs:NIL;
    SizeOfQ:SizeOf(EmailApp);
    Title:EMTitle;
    ReSize:EMReSize;
    NumXTexts:0;
    NumYTexts:0;
    OnDeactivate:NIL;
    Move2:NIL
   {$ELSE}
    SerialNumber:0
   {$ENDIF}
   ),
  (SerialNumber:wnAtlas;
    Init:GOInit;
    Load:NIL;
    Run:GORun;
    Done:NIL;
    Refresh:GORefresh;
    Save:NIL;
    SaveAs:NIL;
    SizeOfQ:SizeOf(GeoApp);
    Title:GOTitle;
    ReSize:NIL;
    NumXTexts:0;
    NumYTexts:0;
    OnDeactivate:NIL;
    Move2:NIL
   )
 );

{$I Library\Typemati.Inc}

Procedure LoadMalteCountry;
Var
 Data:CountryDataSetRec;
 BP:^Byte;
 CP:^Char Absolute BP;
Begin
 If MalteCountryCode>0Then Begin
  DBOpenServerName(ChantalServer,'CHANTAL:/Country/Country.Dat');
  If DBLocateAbs(ChantalServer,0,MalteCountryCode,[])Then Begin
   DBReadRec(ChantalServer,Data);
   CountryCode:=Data.CountryCode;
   CodePage:=Data.CodePage;
   BP:=@Data;
   DBGotoColumnAbs(ChantalServer,6,Pointer(BP));
   Date:=BP^;
   BP:=@Data;
   DBGotoColumnAbs(ChantalServer,9,Pointer(BP));
   Byte(Time):=BP^;
   CP:=@Data;
   DBGotoColumn(ChantalServer,'ThSep',Pointer(CP));
   ThSep[0]:=CP^;
   CP:=@Data;
   DBGotoColumn(ChantalServer,'DecSep',Pointer(CP));
   DeSep[0]:=CP^;
   CP:=@Data;
   DBGotoColumn(ChantalServer,'DateSep',Pointer(CP));
   DtSep[0]:=CP^;
   CP:=@Data;
   DBGotoColumn(ChantalServer,'TimeSep',Pointer(CP));
   TmSep[0]:=CP^;
   CP:=@Data;
   DBGotoColumn(ChantalServer,'ParaSep',Pointer(CP));
   DaSep[0]:=CP^;
  End
   Else
  ErrNoMsgOk(errCountryInfoNotFound);
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure ChkPHPassword                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de v‚rifier l'autorisation du Power Hacken selon
 le mot de passe du maŒtre des Chevaliers de Malte.
}

Procedure ChkPHPassWord;
Var
 S,PHPassWord:String;
 I:Byte;
Begin
 PHPassWord:=Chr(Byte('G')xor 255)+
             Chr(Byte('A')xor 255)+
             Chr(Byte('B')xor 255)+
             Chr(Byte('R')xor 255)+
             Chr(Byte('I')xor 255)+
             Chr(Byte('E')xor 255)+
             Chr(Byte('L')xor 255);
 For I:=1to Length(PHPassWord)do PHPassWord[I]:=Chr(Byte(PHPassWord[I])xor 255);
 S:='';ClrKbd;
 Repeat
  WinInp(40,'Protection du Gardien de la forˆt','Entrez le mot de passe',CurrKrs.Draw.Window,Ya,S);
 Until StrUp(S)=PHPassWord;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Fonction SerialCode                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction recherche le num‚ro de s‚rie correspondant … la chaŒne de
 caractŠres  envoy‚e  par le paramŠtre ®S¯  et  le retourne  sous forme de
 chaŒne de caractŠres Pascal ASCII (String).
}

Function SerialCode(Const S:String):String;Near;
Var
 ST:String;
 I:Byte;
Begin
 ST:='';
 For I:=1to 4do Begin
  If(Length(S)<I)Then AddStr(ST,'00')
  Else AddStr(ST,HexByte2Str(Not(Byte(ChrUp(S[I])))));
 End;
 For I:=1to 8do If ST[I]>='A'Then Dec(Byte(ST[I]),17);
 SerialCode:=ST;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Fonction UnlockKey                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette  fonction  recherche  pour  l'utilisateur  le  num‚ro  de  s‚rie
 correspondant … la chaŒne de caractŠres envoy‚e par le paramŠtre ®S¯ et
 le retourne sous forme de chaŒne de caractŠres Pascal ASCII (String).
}

Function UnLockKey(Const S:String):String;Near;Begin
 DialogMsgOk('Le serrurier … trouver la cl‚!');
 UnLockKey:=SerialCode(S);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Fonction EnregPrg                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet … un utilisateur de s'enregistrer avec son nom et
 un num‚ro de s‚rie.
}

Function EnregPrg(Config:Boolean):ShortInt;
Var
 W:Window;
 P:Byte;
 K:Word;
 TC1,TC2:PChrAByte;
 PC1,PC2:PChr;

 Procedure MouseAction;
 Var
  MX,MY:Byte;
 Begin
  MX:=LastMouseX-WEGetRX1(W);MY:=LastMouseY-WEGetRY1(W);
  Case(MY)of
   0..6:P:=0;
   7..10:P:=1;
   10..14:P:=2;
  End;
 End;

Begin
 EnregPrg:=0;
 WEInitO(W,48,14);
 WEPushWn(W);
 WEPutWnKrDials(W,'Enregistrer le '+NamePrg);
 WECloseIcon(W);
 WEBar(W);
 SetIntVec($01,System.Ptr($FFFF,0));
 SetIntVec($03,System.Ptr($FFFF,0));
 WELn(W);
 WEPutTxtLn(W,'Entrer les informations re‡us par la poste pour');
 WEPutTxtLn(W,'enregistrer votre application.');
 WELn(W);
 WELn(W);
 WEPutTxtLn(W,'Nom Utilisateur:');
 WELn(W);
 WELn(W);
 WEPutTxtLn(W,'Num‚ro de s‚rie:');
 W.CurrColor:=$8F;P:=0;PC1:=@TC1;PC2:=@TC2;
 FillClr(TC1,SizeOf(TC1));FillClr(TC2,SizeOf(TC2));
 WEBarSpcHorShade(W,17,5,wnMax);
 WEBarSpcHorShade(W,17,8,wnMax);
 Case(Config)of
  Ya:WEPutKHorDn(W,'$Suivant|Pr‚c‚dent|Annuler');
  Else WEPutKHorDn(W,'$Correcte');
 End;
 Repeat
  Case(P)of
   0:Begin
      WESetInpColors(W,$8F,W.Palette.Sel);
      K:=_WEInput(W,17,5,wnMax-1,28,PC1);
      WESetKr(W,$8F);
      WEBarSelHor(W,17,5,wnMax-1);
      Case(K)of
       13:Begin{Alt+13}
        StrPCopy(PC2,UnlockKey(StrPas(PC1)));
        P:=1;
       End;
       kbEsc,kbClose:Break;
       kbUp:P:=2;
       kbDn,kbTab:P:=1;
       kbEnter:P:=2;
       kbInWn:MouseAction;
      End;
     End;
   1:Begin
      WESetInpColors(W,$8F,W.Palette.Sel);
      K:=_WEInput(W,17,8,wnMax-1,28,PC2);
      WESetKr(W,$8F);
      WEBarSelHor(W,17,8,wnMax-1);
      Case(K)of
       kbEsc,kbClose:Break;
       kbUp:P:=0;
       kbDn,kbTab:P:=2;
       kbEnter:P:=2;
       kbInWn:MouseAction;
      End;
     End;
   2:Begin
      Case(Config)of
       Ya:K:=WEGetKHorDn(W,'$Suivant|Pr‚c‚dent|Annuler');
       Else K:=WEGetKHorDn(W,'$Correcte');
      End;
      Case(K)of
       0,1:Begin
        If SerialCode(StrPas(PC1))=StrPas(PC2)Then Begin
         RegUserName:=StrNew(PC1);RegSerialCode:=StrNew(PC2);
         SaveIni;
         PutTxtXYUnKr(2,MaxYTxts-1,LeftJustifyStr(StrPas(RegUserName),28));
        End
         Else
        Begin PC1:=NIL;PC2:=NIL;End;
        If(Config)Then Begin
         If K=1Then EnregPrg:=-1
               Else EnregPrg:=1;
        End;
        Break;
       End;
       kbInWn:MouseAction;
       kbAbort,2:Break;
       kbTab:P:=0;
      End;
     End;
  End;
 Until No;
 WEDone(W);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Proc‚dure LoadNewMtx                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure charge une police de caractŠres dans celle utiliser par la
 carte vid‚o  actuellement. Ceci dit, la carte doit  supporter  cette option
 pour permettre cela.
}

Procedure LoadNewMtx;
Label Normal;
Var
 Ptr:Pointer;
 PString:^String Absolute Ptr;
 Path,SP:String;
 DataDB:Record
  ID:Byte;
  HeightChar:Byte;
  Name:String;
  Font:String;
 End;
Begin
 If K>0Then Begin
  If GetNumYPixels=200Then Exit;
  Case(K)of
   10:If HeightChr=8Then Path:='THIN8X8'Else Goto Normal;
   31:If HeightChr in[11..14]Then Path:='8X11SNSF'Else Goto Normal;
   Else Begin
Normal:
    DBOpenServerName(ChantalServer,'CHANTAL:/Polices/IndexFont.Dat');
    If DBLocateAbs(ChantalServer,0,K,[])Then Begin
     DBReadRec(ChantalServer,DataDB);
     If(DataDB.HeightChar>HeightChr)Then Exit;
     PString:=@DataDB;
     DBGotoColumnAbs(ChantalServer,3,Ptr);
     Path:=PString^;
    End
     Else
    Exit;
   End;
  End;
  If K>1Then Begin
   AddStr(Path,'.FNT');
   If Not(FileExist(Path))Then Begin
    SP:=MaltePath+'FNT\'+Path;
    If FileExist(SP)Then Path:=SP Else Begin
     SP:=MaltePath+'FONT\'+Path;
     If FileExist(SP)Then Path:=SP Else Begin
      __FileNotFound(Path);
      Exit;
     End;
    End;
   End;
  End;
  LoadMtx(Path);
 End;
End;

Procedure _LoadNewMtx;Far;Begin
 LoadNewMtx(MtxNm);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure MnuInfo                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet … un utilisateur d'obtenir un menu rapide pour
 obtenir des informations sur son systŠme informatique.
}

Procedure MnuInfo;
Var
 Q:SectionRec;
Begin
 SEInit(Q,30,'SystŠme d''information');
 SEAdd(Q,'Sommaire');
 SEAdd(Q,'Pays');
 SEAdd(Q,'M‚moire');
 SEAdd(Q,'CMOS');
 SEAdd(Q,'Carte de son');
 SEAdd(Q,'Vid‚o Primaire');
 SEAdd(Q,'Vid‚o Secondaire');
 SEAdd(Q,'Disque');
 SEAdd(Q,'Souris');
 SEAdd(Q,'Manette de Jeux');
 SEPutWn(Q);
 Repeat
  If(SERun(Q)=kbEsc)Then Break;
  Case(Q.P)of
   0:SomaryInfo;
   1:CountryInfo;
   2:MCBInfo;
   3:CmosInfo;
   4:SoundCardInfo;
   5:VideoInfo(0);
   6:VideoInfo(1);
   7:DskInfo;
   8:MouseInfo;
   9:JoystickInfo;
  End;
 Until No;
 SEDone(Q);
End;

Procedure MnuSetup(Reset:Boolean);
Var
 Q:SectionRec;
Begin
 If(Reset)Then ClrScr(CurrKrs.Desktop.Tapiserie);
 SEInit(Q,37,'Ajustement');
 SEAdd(Q,'Mode vid‚o');
 SEAdd(Q,'Change de police de caractŠres');
 SEAdd(Q,'Environnement vid‚o');
 SEAdd(Q,'Imprimante');
 SEAdd(Q,'SystŠme');
 SEAdd(Q,'Horloge');
 SEAdd(Q,'Clavier');
 SEAdd(Q,'Souris');
 SEAdd(Q,'Environnement');
 SEAdd(Q,'Securit‚');
 SEAdd(Q,'Application');
 SEAdd(Q,'Quitter');
 SEPutWn(Q);
 Repeat
  If(SERun(Q)=kbEsc)Then Break;
  Case(Q.P)of
   0:ChgVidMode;
   1:ChgFont;
   2:Begin
    If(VideoSetup)Then Begin
     SEPutWn(Q);
     SaveIni;
    End;
   End;
   3:SetupPrinters;
   4:SetSystems;
   5:SetClock;
   6:SetupKeyboard;
   7:SetupMouse;
   8:Env;
   9:SetupSecurity;
   10:SetApplication;
   11:Break;
  End;
 Until No;
 SEDone(Q);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Fonction Assistant                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet  de retourner le r‚sultat s‚lectionner dans
 l'assistant de d‚marrage du ®MonsterBook¯ lorsqu'aucun fichier n'a
 ‚t‚ pr‚vu d'ˆtre charg‚ au d‚marrage.
}

Function Assistant:Byte;
Var
 Q:SectionRec;
 L:Window;
 Path:String;
Begin
 WEPushEndBar(L);
 WEPutLastBar('Cliquez le bouton correspondant … votre choix ou ^Esc^ pour quitter l''assistant');
 Assistant:=0;
 SEInit(Q,34,'Assistant');
 SEAssociateImageRes(Q,MaltePath+'ASSISTAN.RLL',0,40);
 If(IsGrf)Then Begin
  SEAdd(Q,'Menu … la Windows 9X');
  SEAdd(Q,'Gestionnaire de programmes');
 End;
 SEAdd(Q,'Ouvrir un document');
 SEAdd(Q,'Ouvrir un dessin');
 SEAdd(Q,'Ouvrir un tableur');
 SEAdd(Q,'Gestionnaire de fichiers');
 SEAdd(Q,'Information SystŠme');
 SEAdd(Q,'Quitter l''Assistant');
 SEPutWn(Q);
 Repeat
  If(SERun(Q)=kbEsc)Then Break;
  If Q.P<=7Then Begin
   If Not(IsGrf)Then Inc(Q.P,2);
  End;
  Case(Q.P)of
   0:Begin
    SEDone(Q);
    WEDone(L);
    If BitsPerPixel<>1Then CurrPalette:=8;
    Windows.HomeYEditor:=0;
    ViewToolBar:=False;
    StyleBackgroundMenu:=sbmClassic;
    TaskBar.Visible:=True;
    InputType:=itWindows;
    CreateKeyFormat(HKEY_CURRENT_USER,'Window','InputType',tdByte,InputType);
    CreateKeyFormat(HKEY_CURRENT_USER,'Software\Windows9X\TaskBar','Visible',tdBoolean,TaskBar.Visible);
    If FileExist('ISABEL.COL')Then Path:=''
                              Else Path:=MaltePath;
    GetFile(Path+'ISABEL.COL',CurrPalette,SizeOf(CurrKrs),CurrKrs);
    MtxNm:=9;
    LoadNewMtx(9);
    Desktop:=True; { Sauvegarde du bureau }
    SaveIni;
    RefreshExterne;
    PMPutMnuBar;
    DefEndBar;
    RunFunc(cmdProgMan);
    StartMode;
    Exit;
   End;
   1:Begin
    Assistant:=cmdProgMan;
    Break;
   End;
   2:Begin
    Assistant:=cmdOpenGatt;
    Break;
   End;
   3:Begin
    Assistant:=cmdOpenDrw;
    Break;
   End;
   4:Begin
    Assistant:=cmdOpenSuperCalc;
    Break;
   End;
   5:Begin
    Assistant:=cmdNewFileManagers;
    Break;
   End;
   6:MnuInfo;
   7:Break;
  End;
 Until False;
 SEDone(Q);
 WEDone(L);
End;

Function LevelWordCode(Const Source,S:String):Byte;Assembler;ASM
 CLD
 XOR BX,BX
 LES DI,S
 CMP Byte Ptr ES:[DI],3
 JB  @Err
 CMP Byte Ptr ES:[DI+3],':'
 JNE @Err
 MOV AX,ES:[DI+1]
 LES DI,Source
 MOV CL,ES:[DI]
 XOR CH,CH
 INC DI
@Loop:
 INC BX
 SCASW
 JE  @1
 LOOP @Loop
@Err:
 XOR BX,BX
@1:
 XCHG AX,BX
END;

Procedure TBInit;Begin
 FillClr(TaskBar,SizeOf(TaskBar));
 TaskBar.Visible:=True;
End;

Procedure InitScrNDesktop;
Var
 XP,YP,I:RBP;
 SP,SP2:Byte;
 P,FS:LongInt;
 Handle:Hdl;
 S,CurrFileName:String;
 PM:^ProgramsManagerApp;
 X1,Y1,X2,Y2:Byte;
Begin
 If(EnvMode=emDESQview)Then Begin
  ViewAppTitle:=False;
  LnsMnu:=0;
  DialTimer:=False;
  DesktopIconOnStartMode:=False;
  SoundIconOnStatus:=False;
  CountryIconOnStatus:=False;
  StyleBarMnu:=sbmClassic;
  StyleBackgroundMenu:=sbmDESQView;
  TaskBar.Visible:=False;
 End;
 LoadMenu(MaltePath+FileNameMenu);
 InitMnu(0,0);
 InitScr;
 If(ModePH)Then Begin
  ColorMouse:=LightRed;
  BorderColorMouse:=Red;
 End;
 If(SUP^.Enreg)Then EnregPrg(False);
 If(ModePH)Then ChkPHPassWord;
  { Fixe le nom du programme s'il s'agit d'un systŠme d'exploitation graphique }
 If(OS2)Then OS2SetTitle('MonsterBook')
  Else
 If(Win=winEnhanced)and(WinLoVer=4)and(WinHiVer in[0,10])Then
  Win95SetTitle('MonsterBook');
 ChkMasterPassWord;
 If MtxNm>1Then Begin
  LoadNewMtx(MtxNm);
  SetVideoSizeInit:=_LoadNewMtx;
 End;
 PutMemory:=PutFreeMemory;
 DialTimer:=LnsMnu>0;
  { Initialise le gestionnaire de fenˆtre }
 HInit(Windows);
 Windows.MenuTitleContext:=HMenuTitle;
 Windows.HomeYEditor:=BMUseYTexts(But);
 For I:=0to(NumApp)do HAddNewModel(Windows,LstHWin[I]);
 {Charge le Desktop}
 If SUP^.PathDesktop<>''Then Begin
  If StrUp(SUP^.PathDesktop)<>'NONE'Then Desktop:=True; { Activer mˆme si le fichier de configuration l'interdit...}
 End;
 If(EnvMode=emDESQview)Then Begin
  Desktop:=False;
  MenuDESQview;
 End;
 If(Desktop)Then Begin
  P:=0;
  If SUP^.PathDesktop<>''Then Handle:=FileOpen(SUP^.PathDesktop,fmRead)
  Else Handle:=FileOpen(MaltePath+'MB.DSK',fmRead);
  If(Handle<>errHdl)Then Begin
   FS:=FileSize(Handle);
   If FS>0Then Begin
    WEPutLastBar('Chargement du bureau en cours, patientez s''il vous plaŒt,...');
    Repeat
     _GetAbsFileTxtLn(Handle,P,S);
     If GetSysErr<>0Then Break;
     Inc(P,Length(S)+2);
     CurrFileName:=Copy(S,4,255);
     Case LevelWordCode('ED'+ { diteur }
                        'VW'+ { Regarde ASCII }
                        'IC'+ { Editeur d'Ic“ne }
                        'DW'+ { Programme de dessin }
                        'CE'+ { Tableur }
                        'FM'+ { Gestionnaire de fichiers }
                        'PR'+ { Prompt DOS }
                        'TE'+ { Terminal }
                        'UN'+ { Shell Unix }
                        'HV'+ { HexView }
                        'OU'+ { Sortie }
                        'EM'+ { Editeur de musique }
                        'ER'+ { Editeur de macro }
                        'PC'+ { Calculatrice programmable }
                        'CA'+ { Calculatrice classique }
                        'CL'+ { Calendrier }
                        'AP'+ { Agenda }
                        'PD'+ { Catalogue de disquette }
                        'MU'+ { Menu d'application }
                        'FE'+ { Editeur de police }
                        'BD'+ { Base de donn‚es }
                        'DB'+ { Debug }
                        'PM'+ { Gestionnaire de programmes }
                        'TS'+ { Tetris }
                        'CD'+ { Joueur de Compacte disque}
                        'FL'+ { Ouverture de fichier }
                        'SQ'+ { SQL }
                        'SF'+ { Recherche de fichier }
                        'TD'+
                        'GD'+
                        'LG',S)of{ Dessin technique }
      wnAgenda:AgendaWindow;
      wnEdit:Begin
       SP:=Pos(' ',S);
       If SP=0Then SP:=255 Else Dec(SP,4);
       If(OpenFile(Copy(S,4,SP)))and(SP<>255)Then Begin
        Inc(SP,5);SP2:=Pos(',',S);
        XP:=StrToWord(Copy(S,SP,SP2-SP));
        YP:=StrToWord(Copy(S,SP2+1,255));
        TEGotoXY(EditorApp(HPtr(Windows)^),XP,YP);
       End;
      End;
      wnDraw:OpenDraw(CurrFileName);
      wnSuperCalc:_OpenSuperCalc(CurrFileName);
      wnView:ViewAscii(CurrFileName);
      wnHexView:HexView(CurrFileName);
      wnFileManager:Begin
       If CurrFileName='EXPLORER'Then FileExplorer
        Else
       Begin
        WnFM;
        FileManagerApp(HPtr(Windows)^).Panel[0].Path:=Copy(S,4,Pos(',',S)-4);  {Fixe le tableau gauche}
        FileManagerApp(HPtr(Windows)^).Panel[1].Path:=Copy(S,Pos(',',S)+1,255);{Fixe le tableau droite}
        FMRefresh(FileManagerApp(HPtr(Windows)^),True);
       End;
      End;
      wnTerm:NewTerm;
      wnFont:_OpenFont(CurrFileName);
      wnUnix:WnMUnix;
      wnPC:WnWatch;
      wnPrmpt:WnPrompt;
      wnProgMan:Begin
       If Length(S)>4Then Begin
        HLoad(Windows,wnProgMan,CurrFileName);
        SetMnuSwitch;
       End
        Else
       Begin
{        NewProgMan;
        If(ChrUp(StrI(4,S))='D')and(Length(S)=4)Then StartMode;}
        If(ChrUp(StrI(4,S))='D')and(Length(S)=4)Then Begin
         PM:=HNewManual(Windows,wnProgMan,X1,Y1,X2,Y2);
         _PMWLoad(PM^,0,MaxYTxts+1,MaxXTxts,MaxYTxts+1,MaltePath+'PROGMAN.INI',True);
         Windows.OnRefreshBackground:=Bureau;
         HRefreshBackground(Windows);
{         HInTaskBar(Windows);}
         SetMnuSwitch;
        End
         Else
        NewProgMan;
       End;
      End;
      wnIcon:_OpenIcnEdt(CurrFileName);
      wnCalendar:Begin
       Calendar;
       CAGoto(CalendarApp(HPtr(Windows)^),StrToInt(Copy(S,7,255)),StrToWord(Copy(S,4,2)));
      End;
      wnTetris:RunApp(pmwTetris);
      wnCDPlayer:RunCDPlayer;
      wnTechDraw:OpenSelection(CurrFileName,$FF);
      wnDataBase:OpenDataBase(CurrFileName);
      wnLogo:OpenLogo(CurrFileName);
      Else Break;
     End;
    Until P>FS;
   End;
   FileClose(Handle);
  End;
 End;
 If(SUP^.OpenFileManager)Then WnFM;
  {Charge les fichiers donn‚e comme paramŠtres par l'utilisateur}
 If SUP^.LoadFiles.Count>0Then Begin
  ALSetPtr(SUP^.LoadFiles,0);
  For I:=0to SUP^.LoadFiles.Count-1do Begin
   S:=StrPas(_ALGetCurrBuf(SUP^.LoadFiles));
   OpenFile(S);
   ALNext(SUP^.LoadFiles)
  End;
  ALDone(SUP^.LoadFiles);
 End;
  {Initialise les histoires (History)}
 HYInit(H,256);         {Histoire courante d'ouverture de fichier}
 If Windows.Lst.Count=0Then RunFunc(Assistant);
 FreeMemory(SUP,SizeOf(StartUpInfoRec));
End;

Procedure InitMemNKit;
Var
 TPIV:PIV;
 I,SP:Byte;
 FS:LongInt;
Begin
 FillClr(Application,SizeOf(Application));
 PathDskSwp:=FileExpand('MB.$$$');
 If(SUP^.Verbose)Then WriteLn('Initialisation des ressources de m‚moires ‚tendue:');
  InitMemManagers;
 If(SUP^.Verbose)Then Begin
  WriteLn(' ExtBios: ',AppResFree(rmExtBios),'Ko');
  WriteLn(' EMS:     ',AppResFree(rmEms),'Ko');
  WriteLn(' XMS:     ',AppResFree(rmXms),'Ko');
  WriteLn(' Disque   "'+PathDskSwp+'": ',AppResFree(rmDsk),'Ko');
  WriteLn;
  WriteLn('Sauvegarde de l''‚cran de lancement...');
 End;
 If BankRoutine<>0Then Begin
  AutoDetect;
  GetPIV(TPIV);
  TPIV.ProcSelBnkPg:=BankRoutine;
  SetPIV(TPIV);
 End;
  {Initialisation vid‚o}
 PushScr(Output);
 {$IFNDEF DPMI}
  If Not(SUP^.Verbose)Then Begin
   If Not(SUP^.NoPres)Then Begin
    If FileExist(MaltePath+'MALTE.BMP')Then Begin
     FullBMP(MaltePath+'MALTE.BMP',True);
     I:=0;SP:=GetRawTimerB;SUP^.ImageFound:=True;
     Repeat
      If(SP<>GetRawTimerB)Then Begin
       SP:=GetRawTimerB;Inc(I);
      End;
      If(KeyPress)Then Break;
     Until I>20;
     _LoadWave(StrPas(SoundPlay[sndStartUp]));
     _PlayWave;
     ClrKbd;
     If(DefaultMode=vmNone)Then Begin
      PopScr(Output);
      PushScr(Output);
     End;
    End;
   End;
  End;
 {$ENDIF}
 If(SUP^.Verbose)Then WriteLn('Configuration de l''imprimante');
 UpDatePrinter;
 InitSpooler;
 If(SUP^.Verbose)Then WriteLn('Cr‚ation d''un tampon d''impression: '+SpoolName);
 If(SUP^.Verbose)Then WriteLn('Changement de mode vid‚o...');
 If(SUP^.CmdVideo)Then Begin
  If(SUP^.CmdIsGrf)Then Begin
   SetVideoSize(SUP^.CmdBPP,SUP^.CmdX,SUP^.CmdY);
   SetLuxe;
  End
   Else
  Begin
   SetVideoSize(0,SUP^.CmdX,SUP^.CmdY);
   If Not(NoLuxe)Then SetLuxe;
  End;
 End
  Else
 If(NoLuxe)Then Begin
  If(DefaultMode=vmNone)Then InitVideo
                        Else SetVideoMode(DefaultMode);
  SetBlink(False);
  CloseCur;
 End
   Else
 If(DefaultMode=vmNone)Then Begin
  If(SUP^.ImageFound)Then SetVideoModeDeluxe(CurrVideoMode)
                     Else InitVideoDeluxe;
 End
  Else
 SetVideoModeDeluxe(DefaultMode);
{ WriteLn(' VRAM:    ',AppResFree(rmVram),'Ko');}
 GetSysErr:=0;
 If(ModePH)Then _InitEnv(MtxDiablo)
  Else
 Begin
  If CurrPalette=$FFThen InitEnv
                    Else _InitAbsEnv(CurrPalette);
 End;
 If GetSysErr<>0Then Begin
  WriteLn('Erreur: Palette de couleur introuvable!');
  DoneMemManagers;
  Halt;
 End;
 If Not FileExist(MaltePath+MB_INI)Then Begin
  __InitMouse;
  AssistantConfig;
 End;
 LoadMalteCountry;
 DrawModeB:=drwText;
 Randomize;
 If(SUP^.InfoSys)Then Begin
  MnuInfo;
  SmallXit(No);
  Halt;
 End;
 If(SUP^.Setup)Then Begin
  MnuSetup(True);
  SmallXit(No);
  Halt;
 End;
 If Not(SUP^.NoKey)Then Begin
  If FileExist('ISABEL.KEY')Then SUP^.Path:=''
                            Else SUP^.Path:=MaltePath;
  FS:=GetFileSize(SUP^.Path+'ISABEL.KEY');
  Application.PAccelerators:=MemAlloc(FS);
  If(Application.PAccelerators<>NIL)Then Begin
   GetFile(SUP^.Path+'ISABEL.KEY',0,FS,Application.PAccelerators^);
   Application.MaxAccelerators:=FS div 5;
  End;
 End;
 If(ModePH)Then WriteLog('Lancement du PH')
           Else WriteLog('Lancement du '+NamePrg);
End;

{ Cette proc‚dure charge la police graphique 8x8 dans l'interruption 1Fh
 comme dans le cas de Window Me par exemple.
}

Procedure LoadGrfMtx;
Var
 Ptr:Pointer;
 Height:Byte;
Begin
 Height:=8;
 Ptr:=GetCurrMtx(Height);
 ASM
  ADD Word Ptr &Ptr,128*8
 END;
 SetIntVec($1F,Ptr);
End;

{ Cette proc‚dure recherche dans la base de registres les informations
 sur la configuration actuel de l'environnement du MonsterBook.
}

Procedure ReadRegistry;
Var
 Q:RegistryObject;
 X:Boolean;
 Volume:Byte;
Begin
 ROOpenMain(Q);
 _ROReadKey(Q,HKEY_CURRENT_USER,'Window','TitleJustified',TitleCenter,False);
 _ROReadKey(Q,HKEY_CURRENT_USER,'Window','TitleType',StyleBarTitle,False);
 _ROReadKey(Q,HKEY_CURRENT_USER,'Window','ButtonType',kType,False);
 _ROReadKey(Q,HKEY_CURRENT_USER,'Window','InputType',InputType,False);
 _ROReadKey(Q,HKEY_CURRENT_USER,'Window','Banderolle',Banderolle,False);
 _ROReadKey(Q,HKEY_CURRENT_USER,'Menu','BackgroundType',StyleBackgroundMenu,False);
 _ROReadKey(Q,HKEY_CURRENT_USER,'Menu','BarType',StyleBarMnu,False);
 _ROReadKey(Q,HKEY_CURRENT_USER,'Desktop','Title',ViewAppTitle,False);
 LnsMnu:=Byte(ViewAppTitle);
 If _ROReadKey(Q,HKEY_CURRENT_CONFIG,'System\Joystick','Direct',X,False)Then Begin
  If(X)Then Exclude(Jump.FlagsMethod,flgJoyPerBios)
       Else Include(Jump.FlagsMethod,flgJoyPerBios);
 End;
 If _ROReadKey(Q,HKEY_CURRENT_CONFIG,'System\Sound\Volume','Microphone',Volume,False)Then Begin
  SetMicVolume(Volume);
 End;
 If _ROReadKey(Q,HKEY_CURRENT_CONFIG,'System\Sound\Volume','FM',Volume,False)Then Begin
  SetFMVolume(Volume);
 End;
 If _ROReadKey(Q,HKEY_CURRENT_CONFIG,'System\Sound\Volume','CD',Volume,False)Then Begin
  SetCDVolume(Volume);
 End;
 If _ROReadKey(Q,HKEY_CURRENT_CONFIG,'System\Sound\Volume','Line',Volume,False)Then Begin
  SetLineVolume(Volume);
 End;
 If _ROReadKey(Q,HKEY_CURRENT_CONFIG,'System\Sound\Volume','Master',Volume,False)Then Begin
  SetMasterVolume(Volume);
 End;
 _ROReadKey(Q,HKEY_CURRENT_USER,'Software\Windows9X\TaskBar','Visible',TaskBar.Visible,False);
 RODone(Q);
End;

Procedure SearchSoundInSetDos;Near;
Var
 S:String;
 I,J:Byte;
Begin
 S:=GetEnv('BLASTER');
 I:=Pos('A',S);
 If I>0Then Begin
  Inc(I);
  SoundPort:=HexStrToInt(XtrkHexNm(I,S));
  IsSoundBlaster:=True;
 End;
 I:=Pos('D',S);
 If I>0Then Begin
  Inc(I);
  DMAChannel:=HexStrToInt(XtrkHexNm(I,S));
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure Initialize                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure utiliser comme d‚marreur du MonsterBook. Il charge le
 fichier de configuration et l'interpr‚te, initialise l'‚cran, s'occupe
 des param‚trages du prompt et du chargement du desktop.
}

Procedure Initialize;
Var
 P,FS:LongInt;
 S:String;
 Handle:Hdl;
 SP:Byte;
 I:RBP;
 Chr:Char;
 DBData:Record
  ID:Byte;
  Caption:String;
 End;

 Procedure ReadParam;
 Var
  I,J:Byte;
  S:String;
  PS:^String;
  BarSep:Boolean;
 Begin
  PS:=System.Ptr(PrefixSeg,$80);
  PS^:=StrUp(PS^);
  For I:=1to(ParamCount)do Begin
   S:=ParamStr(I);BarSep:=S[1]in['/','-'];
   If(BarSep)Then S:=Copy(S,2,255);
   If(S='?')or(S='H')or(S='HELP')Then Begin
    WriteLn;
    WriteLn('MB [/?] [/V|VERBOSE] [...]');
    WriteLn;
    WriteLn(' /?            Affiche cette aide');
    WriteLn(' /INSTALL      Effectuer l''installation du logiciel ®MonsterBook¯.');
    WriteLn(' /SETUP        Ajuste le MonsterBook quand vous l''avez "fucker".');
    WriteLn(' /V|/VERBOSE   Demande tous les d‚tails de pr‚paration lors du lancement');
    WriteLn(' /NOSVGA       Pas de d‚tection de Super VGA (ormis la norme VESA)');
    WriteLn(' /NOLUXE       Pas d''affichage graphique en mode texte');
    WriteLn(' /NOCHANGEMODE Ne change pas de mode vid‚o lors du d‚marrage, utilise');
    WriteLn('               plut“t le mode actuellement affich‚.');
    WriteLn(' /NOMOUSE      Ne pas faire supporter la souris.');
    WriteLn(' /NOOVRXMS     Ne pas charger le recouvrement en m‚moire XMS.');
    WriteLn(' /NOSOUNDCARD  Interdit la d‚tection des cartes de son');
    WriteLn(' /NOKEY        Ne charge pas les cl‚s de clavier (‚conomise de la m‚moire)');
    WriteLn(' /NODIRKEY     Ne pas utiliser des accŠs directe pour le clavier');
    WriteLn(' /NODELSPOOLER Ne pas effacer le fichier d''impression');
    WriteLn(' /INFO         Pr‚sentation d''information du systŠme et quitte');
    WriteLn(' /UMB          Utilise les bloscs de m‚moires hautes');
    WriteLn(' /DSK:chemin   Chemin du Desktop que vous voulez utilisez...');
    WriteLn(' /VG:x,y,bpp   Mode graphique ®x¯ par ®y¯ en tant de bits par pixel');
    WriteLn(' /VT:x,y       Mode texte en ®x¯ colonne par ®y¯ ligne');
    Halt;
   End
    Else
   If S='VESABIOS'Then VesaBiosBank:=True
    Else
   If(S='V')or(S='VERBOSE')Then SUP^.Verbose:=True
    Else
   If S='INSTALL'Then Install
    Else
   If S='ENREGISTRER'Then SUP^.Enreg:=True
    Else
   If S='NOSVGA'Then SUP^.NoSVGA:=True
    Else
   If S='UMB'Then SUP^.UMB:=True
    Else
   If S='NOKEY'Then SUP^.NoKey:=True
    Else
   If S='NODIRKEY'Then ASM
    OR Jump.FlagsMethod,flgNotDirKey
   END
    Else
   If S='NOPRESENTATION'Then SUP^.NoPres:=True Else
   If S='NODELSPOOLER'Then DelSpooler:=False
    Else
   If S='INFO'Then SUP^.InfoSys:=True
    Else
   If S='NOMOUSE'Then SUP^.NoMouse:=True
    Else
   If S='NOLUXE'Then NoLuxe:=True
    Else
   If S='NOCHANGEMODE'Then SUP^.NoChgMode:=True
    Else
   If(S='NOSOUNDCARD')or(S='NOTSOUNDCARD')Then SUP^.NotSoundCard:=True Else
   If(S='SOUND')Then Begin
    SUP^.NotSoundCard:=False;
    IsNovell:=False;
    SearchSoundInSetDos;
   End
    Else
   If S='NOOVRXMS'Then SUP^.XmsOvrSwap:=False Else
   If S='SETUP'Then Begin
    SUP^.Setup:=True;
    SUP^.NoPres:=True;
   End
    Else
   If S='FM'Then SUP^.OpenFileManager:=True Else
   If S='DV'Then EnvMode:=emDESQview Else
   If S='PH'Then ModePH:=True
    Else
   If CmpLeft(S,'DSK:')Then SUP^.PathDesktop:=Copy(S,5,255)
    Else
   If CmpLeft(S,'VG:')Then Begin
    J:=4;
    SUP^.CmdX:=StrToWord(XtrkDecNm(J,S));
    SUP^.CmdY:=0;
    SUP^.CmdBPP:=0;
    If StrI(J,S)=','Then Begin
     Inc(J);SUP^.CmdY:=StrToWord(XtrkDecNm(J,S));
     If StrI(J,S)=','Then Begin
      Inc(J);SUP^.CmdBPP:=StrToWord(XtrkDecNm(J,S));
      If SUP^.CmdBPP=256Then SUP^.CmdBPP:=8;
      SUP^.CmdVideo:=SUP^.CmdBPP<>0;
      SUP^.CmdIsGrf:=Ya
     End;
    End;
   End
    Else
   If CmpLeft(S,'VT:')Then Begin
    J:=4;
    SUP^.CmdX:=StrToWord(XtrkDecNm(J,S));
    SUP^.CmdY:=0;
    SUP^.CmdBPP:=0;
    If StrI(J,S)=','Then Begin
     Inc(J);SUP^.CmdY:=StrToWord(XtrkDecNm(J,S));
     SUP^.CmdVideo:=SUP^.CmdY<>0;
     SUP^.CmdIsGrf:=No;
    End;
   End
    Else
   If Not(BarSep)Then
    ALAddStr(SUP^.LoadFiles,S); { Additionne … la liste des fichiers … charger }
  End;
 End;

 Type
  HeaderFastConfig=Record
   Sign:Array[0..6]of Char; { Signature: MB.INI#26 }
   FileInfo:SearchRec;
   Path:String;
  End;

  GroupConfig=Record
   ModeTypeWriter:Boolean;
   PrnMarge:Boolean;
   CheckSvga:Boolean;
   DefaultMode:Word;
   MtxNm:Byte;
   FullDate:Boolean;
   CurrPalette:Byte;
   VesaBiosBank:Boolean;
   MediaSupport:Boolean;
   UseExtensior:Boolean;
   Cadril:Boolean;
   FX:Boolean;
   BankRoutine:Byte;
   KeyWait:Byte;
   SwapEms:Boolean;
   NoEms:Boolean;
   DescrInFile:Boolean;
   Log:Boolean;
   ActifScrSave:Boolean;
   SecSS:Word;
   CurrScrnSaver:Byte;
   DirectDos:Boolean;
   MsTxtGrf:Boolean;
   Desktop:Boolean;
   MarkEnd:Boolean;
   Rules:Boolean;
   ViewOutZone:Boolean;
   MakeBak:Boolean;
   OpCodeFormat:Byte;
   OpCodeCPU:Byte;
   CurrModem:Byte;
   BaudRate:Word;
   ModemCmdDelay:Word;
   MemoryModel:Byte;
   WallPaperConfig:Byte;
   ViewToolBar:Boolean;
   HelpBar:Boolean;
   DesktopIconOnStartMode:Boolean;
   SoundIconOnStatus:Boolean;
   CountryIconOnStatus:Boolean;
   DefaultCDROMPort:Byte;
   CountryCode:Word;
  End;

 Function FastReadConfig:Boolean;
 Var
  Handle:Hdl;
  H:SearchRec;
  Header:HeaderFastConfig;
  Group:GroupConfig;

  Procedure ReadPChar(Var Name:PChr);
  Var
   Len:Word;
   Skip:Byte;
  Begin
   _GetRec(Handle,SizeOf(Word),Len);
   If Len=1Then _GetRec(Handle,SizeOf(Byte),Skip)
    Else
   Begin
    Name:=MemAlloc(Len);
    _GetRec(Handle,Len,Name^);
   End;
  End;

 Begin
  FastReadConfig:=False;
  Handle:=FileOpen(MB_CFG,fmRead);
  If(Handle=errHdl)Then Begin
   Handle:=FileOpen(MaltePath+MB_CFG,fmRead);
  End;
  If(Handle<>errHdl)Then Begin
   _GetAbsRec(Handle,0,SizeOf(Header),Header);
   FindFirst(Header.Path,faArchive,H);
   If(Header.FileInfo.Time=H.Time)Then Begin
    ReadPChar(RegUserName);   { 1 - Chargement du ®RegUserName¯ }
    ReadPChar(RegSerialCode); { 2 - Chargement du ®RegSerialCode¯ }
    ReadPChar(MasterPassWord);{ 3 - Chargement du ®MasterPassWord¯ }
    ReadPChar(ExtAsm);       { 4 - Chargement du ®ExtAsm¯ }
    ReadPChar(ExtAC);        { 5 - Chargement du ®ExtAC¯ }
    ReadPChar(ExtBas);       { 6 - Chargement du ®ExtBas¯ }
    ReadPChar(ExtC);         { 7 - Chargement du ®ExtC¯ }
    ReadPChar(ExtEuphoria);  { 8 - Chargement du ®ExtEuphoria¯ }
    ReadPChar(ExtFortran);   { 9 - Chargement du ®ExtFortran¯ }
    ReadPChar(ExtIni);       { 10 - Chargement du ®ExtIni¯ }
    ReadPChar(ExtMsMnu);     { 11 - Chargement du ®ExtMsMnu¯ }
    ReadPChar(ExtPas);       { 12 - Chargement du ®ExtPas¯ }
    ReadPChar(ExtRC);        { 13 - Chargement du ®ExtRC¯ }
    ReadPChar(PathSystems);  { 14 - Chargement du ®PathSystems¯ }
    ReadPChar(PathCountry);  { 15 - Chargement du ®PathCountry¯ }
    ReadPChar(PathUnix);     { 16 - Chargement du ®PathUnix¯ }
    ReadPChar(PathOS2);      { 17 - Chargement du ®PathOS2¯ }
    ReadPChar(PathWin);      { 18 - Chargement du ®PathWin¯ }
    ReadPChar(PathMod);      { 19 - Chargement du ®PathMod¯ }
    ReadPChar(PathBBS);      { 20 - Chargement du ®PathBBS¯ }
    ReadPChar(PathPhoneList);{ 21 - Chargement du ®PathPhoneList¯ }
    {$IFDEF Reseau}
     ReadPChar(PathDownload); { 22 - Chargement du ®PathDownload¯ }
     ReadPChar(PathUpload);   { 23 - Chargement du ®PathUpload¯ }
    {$ENDIF}
    ReadPChar(PathCatDisk);  { 24 - Chargement du ®PathCatDisk¯ }
    ReadPChar(PathDraw);     { 25 - Chargement du ®PathDraw¯ }
    ReadPChar(PathPCX);      { 26 - Chargement du ®PathPCX¯ }
    ReadPChar(PathCalc);     { 27 - Chargement du ®PathCalc¯ }
    ReadPChar(PathGat);      { 28 - Chargement du ®PathGat¯ }
    ReadPChar(PathMac);      { 29 - Chargement du ®PathMac¯ }
    ReadPChar(PathMacDrw);   { 30 - Chargement du ®PathMacDrw¯ }
    ReadPChar(PathAda);      { 31 - Chargement du ®PathAda¯ }
    ReadPChar(PathAsm);      { 32 - Chargement du ®PathAsm¯ }
    ReadPChar(PathAsmC);     { 33 - Chargement du ®PathAsmC¯ }
    ReadPChar(PathBas);      { 34 - Chargement du ®PathBas¯ }
    ReadPChar(PathC);        { 35 - Chargement du ®PathC¯ }
    ReadPChar(PathCobol);    { 36 - Chargement du ®PathCobol¯ }
    ReadPChar(PathEuphoria); { 37 - Chargement du ®PathEuphoria¯ }
    ReadPChar(PathForth);    { 38 - Chargement du ®PathForth¯ }
    ReadPChar(PathFortran);  { 39 - Chargement du ®PathFortran¯ }
    ReadPChar(PathBas);      { 40 - Chargement du ®PathPas¯ }
    ReadPChar(PathResource); { 41 - Chargement du ®PathResource¯ }
    ReadPChar(PathObject);   { 42 - Chargement du ®PathObject¯ }
    ReadPChar(PathUnit);     { 43 - Chargement du ®PathUnit¯ }
    ReadPChar(PathOutput);   { 44 - Chargement du ®PathOutput¯ }
     { 45 - Chargement de ®PrnOutput¯ }
    _GetRec(Handle,1,PrnOutput);
     { Lecture avec traitement: }
    ReadPChar(CurrPrn);      { 46 - Chargement du ®CurrPrn¯ }
    ReadPChar(NameLPT1);     { 47 - Chargement du ®NameLPT1¯ }
     { 48 - Chargement de ®PrnSetup¯ }
    _GetRec(Handle,SizeOf(PrnSetup),PrnSetup);
     { Lecture avec traitement: }
    ReadPChar(NameLPT2);     { 49 - Chargement du ®NameLPT2¯ }
    ReadPChar(NameLPT3);     { 50 - Chargement du ®NameLPT3¯ }
    ReadPChar(NameLPT4);     { 51 - Chargement du ®NameLPT4¯ }
     { 52 - Groupe }
    _GetRec(Handle,SizeOf(Group),Group);
    ModeTypeWriter:=Group.ModeTypeWriter;
    PrnMarge:=Group.PrnMarge;
    CheckSvga:=Group.CheckSvga;
    DefaultMode:=Group.DefaultMode;
    MtxNm:=Group.MtxNm;
    FullDate:=Group.FullDate;
    CurrPalette:=Group.CurrPalette;
    VesaBiosBank:=Group.VesaBiosBank;
    MediaSupport:=Group.MediaSupport;
    UseExtensior:=Group.UseExtensior;
    Cadril:=Group.Cadril;
    FX:=Group.FX;
    BankRoutine:=Group.BankRoutine;
    KeyWait:=Group.KeyWait;
    SwapEms:=Group.SwapEms;
    NoEms:=Group.NoEms;
    DescrInFile:=Group.DescrInFile;
    Dialex.Log:=Group.Log;
    ActifScrSave:=Group.ActifScrSave;
    SecSS:=Group.SecSS;
    DirectDos:=Group.DirectDos;
    MouseTxtGrf:=Group.MsTxtGrf;
    Desktop:=Group.Desktop;
    MarkEnd:=Group.MarkEnd;
    Rules:=Group.Rules;
    ViewOutZone:=Group.ViewOutZone;
    MakeBak:=Group.MakeBak;
    {$IFDEF Developpeur}
     OpCodeFormat:=Group.OpCodeFormat;
     OpCodeCPU:=Group.OpCodeCPU;
    {$ENDIF}
    CurrModem:=Group.CurrModem;
    {$IFDEF Reseau}
     BaudRate:=Group.BaudRate;
     ModemCmdDelay:=Group.ModemCmdDelay;
    {$ENDIF}
    MemoryModel:=Group.MemoryModel;
    WallPaperConfig:=Group.WallPaperConfig;
    ViewToolBar:=Group.ViewToolBar;
    HelpBar:=Group.HelpBar;
    MalteCountryCode:=Group.CountryCode;
    CountryIconOnStatus:=Group.CountryIconOnStatus;
    DefaultCDROMPort:=Group.DefaultCDROMPort;
     { Lecture avec TraŒtement: }
    ReadPChar(NamePrimCard);           { 53 - Chargement du ®NamePrimCard¯ }
    ReadPChar(NamePrimMonitor);        { 54 - Chargement du ®NamePrimMonitor¯ }
    ReadPChar(FontAppPath);            { 55 - Chargement du ®FontAppPath¯ }
    ReadPChar(FontTitlePath);          { 56 - Chargement du ®FontTitlePath¯ }
    ReadPChar(FontInActifTitlePath);   { 57 - Chargement du ®FontInActifTitlePath¯ }
    ReadPChar(SoundPlay[sndStartUp]);  { 58 - Chargement du ®SoundPlay[sndStartUp]¯ }
    ReadPChar(SoundPlay[sndError]);    { 59 - Chargement du ®SoundPlay[sndError]¯ }
    ReadPChar(SoundPlay[sndWarning]);  { 60 - Chargement du ®SoundPlay[sndWarning]¯ }
    ReadPChar(SoundPlay[sndInfo]);     { 61 - Chargement du ®SoundPlay[sndInfo]¯ }
    ReadPChar(SoundPlay[sndOpenWin]);  { 62 - Chargement du ®SoundPlay[sndOpenWin]¯ }
    ReadPChar(SoundPlay[sndCloseWin]); { 63 - Chargement du ®SoundPlay[sndCloseWin]¯ }
    ReadPChar(SoundPlay[sndExit]);     { 64 - Chargement du ®SoundPlay[sndExit]¯ }
    {$IFDEF Reseau}
     ReadPChar(ModemBusy);              { 65 - Chargement du ®ModemBusy¯ }
     ReadPChar(ModemConnect);           { 66 - Chargement du ®ModemConnect¯ }
     ReadPChar(ModemNoCarrier);         { 67 - Chargement du ®ModemNoCarrier¯ }
    {$ENDIF}
     { Tout c'est bien pass‚ }
    FastReadConfig:=True;
   End;
   FileClose(Handle);
  End;
 End;

 Procedure SaveFastConfig;
 Var
  Header:HeaderFastConfig;
  Handle:Hdl;
  Len:Word;
  Group:GroupConfig;

  Procedure WritePChar(Name:PChr);
  Var
   Len:Word;
  Begin
   Len:=Succ(StrLen(Name));
   _SetRec(Handle,SizeOf(Word),Len);
   _SetRec(Handle,Len,Name^);
  End;

 Begin
  Header.Path:=MaltePath+MB_INI;
  If FileExist(Header.Path)Then Begin
   DeleteFile(MaltePath+MB_CFG);
   Handle:=FileCreate(MaltePath+MB_CFG);
   If(Handle<>errHdl)Then Begin
     { 0 - Entˆte }
    Header.Sign:='MB.INI'#26;
    FindFirst(Header.Path,faArchive,Header.FileInfo);
    _SetAbsRec(Handle,0,SizeOf(Header),Header);
     { criture des traŒtements: }
    WritePChar(RegUserName);        { 1 - Sauvegarde du ®RegUserName¯ }
    WritePChar(RegSerialCode);      { 2 - Sauvegarde du ®RegSerialCode¯ }
    WritePChar(MasterPassWord);     { 3 - Sauvegarde du ®MasterPassWord¯ }
    WritePChar(ExtAsm);             { 4 - Sauvegarde du ®ExtAsm¯ }
    WritePChar(ExtAC);              { 5 - Sauvegarde du ®ExtAC¯ }
    WritePChar(ExtBas);             { 6 - Sauvegarde du ®ExtBas¯ }
    WritePChar(ExtC);               { 7 - Sauvegarde du ®ExtC¯ }
    WritePChar(ExtEuphoria);        { 8 - Sauvegarde du ®ExtEuphoria¯ }
    WritePChar(ExtFortran);         { 9 - Sauvegarde du ®ExtFortran¯ }
    WritePChar(ExtIni);             { 10 - Sauvegarde du ®ExtIni¯ }
    WritePChar(ExtMsMnu);           { 11 - Sauvegarde du ®ExtMsMnu¯ }
    WritePChar(ExtPas);             { 12 - Sauvegarde du ®ExtPas¯ }
    WritePChar(ExtRC);              { 13 - Sauvegarde du ®ExtRC¯ }
    WritePChar(PathSystems);        { 14 - Sauvegarde du ®PathSystems¯ }
    WritePChar(PathCountry);        { 15 - Sauvegarde du ®PathCountry¯ }
    WritePChar(PathUnix);           { 16 - Sauvegarde du ®PathUnix¯ }
    WritePChar(PathOS2);            { 17 - Sauvegarde du ®PathOS2¯ }
    WritePChar(PathWin);            { 18 - Sauvegarde du ®PathWin¯ }
    WritePChar(PathMod);            { 19 - Sauvegarde du ®PathMod¯ }
    WritePChar(PathBBS);            { 20 - Sauvegarde du ®PathBBS¯ }
    WritePChar(PathPhoneList);      { 21 - Sauvegarde du ®PathPhoneList¯ }
    {$IFDEF Reseau}
     WritePChar(PathDownload);       { 22 - Sauvegarde du ®PathDownload¯ }
     WritePChar(PathUpload);         { 23 - Sauvegarde du ®PathUpload¯ }
    {$ENDIF}
    WritePChar(PathCatDisk);        { 24 - Sauvegarde du ®PathCatDisk¯ }
    WritePChar(PathDraw);           { 25 - Sauvegarde du ®PathDraw¯ }
    WritePChar(PathPCX);            { 26 - Sauvegarde du ®PathPCX¯ }
    WritePChar(PathCalc);           { 27 - Sauvegarde du ®PathCalc¯ }
    WritePChar(PathGat);            { 28 - Sauvegarde du ®PathGat¯ }
    WritePChar(PathMac);            { 29 - Sauvegarde du ®PathMac¯ }
    WritePChar(PathMacDrw);         { 30 - Sauvegarde du ®PathMacDrw¯ }
    WritePChar(PathAda);            { 31 - Sauvegarde du ®PathAda¯ }
    WritePChar(PathAsm);            { 32 - Sauvegarde du ®PathAsm¯ }
    WritePChar(PathAsmC);           { 33 - Sauvegarde du ®PathAsmC¯ }
    WritePChar(PathBas);            { 34 - Sauvegarde du ®PathBas¯ }
    WritePChar(PathC);              { 35 - Sauvegarde du ®PathC¯ }
    WritePChar(PathCobol);          { 36 - Sauvegarde du ®PathCobol¯ }
    WritePChar(PathEuphoria);       { 37 - Sauvegarde du ®PathEuphoria¯ }
    WritePChar(PathForth);          { 38 - Sauvegarde du ®PathForth¯ }
    WritePChar(PathFortran);        { 39 - Sauvegarde du ®PathFortran¯ }
    WritePChar(PathPas);            { 40 - Sauvegarde du ®PathPas¯ }
    WritePChar(PathResource);       { 41 - Sauvegarde du ®PathResource¯ }
    WritePChar(PathObject);         { 42 - Sauvegarde du ®PathObject¯ }
    WritePChar(PathUnit);           { 43 - Sauvegarde du ®PathUnit¯ }
    WritePChar(PathOutput);         { 44 - Sauvegarde du ®PathOutput¯ }
     { 45 - Sauvegarde de ®PrnOutput¯ }
    _SetRec(Handle,1,PrnOutput);
     { criture des traŒtements: }
    WritePChar(CurrPrn);            { 46 - Sauvegarde du ®CurrPrn¯ }
    WritePChar(NameLPT1);           { 47 - Sauvegarde du ®NameLPT1¯ }
     { 48 - Sauvegarde de ®PrnSetup¯ }
    _SetRec(Handle,SizeOf(PrnSetup),PrnSetup);
     { criture des traŒtements: }
    WritePChar(NameLPT2);           { 49 - Sauvegarde du ®NameLPT2¯ }
    WritePChar(NameLPT3);           { 50 - Sauvegarde du ®NameLPT3¯ }
    WritePChar(NameLPT4);           { 51 - Sauvegarde du ®NameLPT4¯ }
     { 52 - Groupe }
    Group.ModeTypeWriter:=ModeTypeWriter;
    Group.PrnMarge:=PrnMarge;
    Group.CheckSvga:=CheckSvga;
    Group.DefaultMode:=DefaultMode;
    Group.MtxNm:=MtxNm;
    Group.FullDate:=FullDate;
    Group.CurrPalette:=CurrPalette;
    Group.VesaBiosBank:=VesaBiosBank;
    Group.MediaSupport:=MediaSupport;
    Group.UseExtensior:=UseExtensior;
    Group.Cadril:=Cadril;
    Group.FX:=FX;
    Group.BankRoutine:=BankRoutine;
    Group.KeyWait:=KeyWait;
    Group.SwapEms:=SwapEms;
    Group.NoEms:=NoEms;
    Group.DescrInFile:=DescrInFile;
    Group.Log:=Dialex.Log;
    Group.ActifScrSave:=ActifScrSave;
    Group.SecSS:=SecSS;
    Group.DirectDos:=DirectDos;
    Group.MsTxtGrf:=MouseTxtGrf;
    Group.Desktop:=Desktop;
    Group.MarkEnd:=MarkEnd;
    Group.Rules:=Rules;
    Group.ViewOutZone:=ViewOutZone;
    Group.MakeBak:=MakeBak;
    {$IFDEF Developpeur}
     Group.OpCodeFormat:=OpCodeFormat;
     Group.OpCodeCPU:=OpCodeCPU;
    {$ENDIF}
    Group.CurrModem:=CurrModem;
    {$IFDEF Reseau}
     Group.BaudRate:=BaudRate;
     Group.ModemCmdDelay:=ModemCmdDelay;
    {$ENDIF}
    Group.MemoryModel:=MemoryModel;
    Group.WallPaperConfig:=WallPaperConfig;
    Group.ViewToolBar:=ViewToolBar;
    Group.HelpBar:=HelpBar;
    Group.CountryCode:=MalteCountryCode;
    Group.CountryIconOnStatus:=CountryIconOnStatus;
    Group.DefaultCDROMPort:=DefaultCDROMPort;
    _SetRec(Handle,SizeOf(Group),Group);
     {criture des traŒtements: }
    WritePChar(NamePrimCard);          { 53 - Sauvegarde du ®NamePrimCard¯ }
    WritePChar(NamePrimMonitor);       { 54 - Sauvegarde du ®NamePrimMonitor¯ }
    WritePChar(FontAppPath);           { 55 - Sauvegarde du ®FontAppPath¯ }
    WritePChar(FontTitlePath);         { 56 - Sauvegarde du ®FontTitlePath¯ }
    WritePChar(FontInActifTitlePath);  { 57 - Sauvegarde du ®FontInActifTitlePath¯ }
    WritePChar(SoundPlay[sndStartUp]); { 58 - Sauvegarde du ®SoundPlay[sndStartUp]¯ }
    WritePChar(SoundPlay[sndError]);   { 59 - Sauvegarde du ®SoundPlay[sndError]¯ }
    WritePChar(SoundPlay[sndWarning]); { 60 - Sauvegarde du ®SoundPlay[sndWarning]¯ }
    WritePChar(SoundPlay[sndInfo]);    { 61 - Sauvegarde du ®SoundPlay[sndInfo]¯ }
    WritePChar(SoundPlay[sndOpenWin]); { 62 - Sauvegarde du ®SoundPlay[sndOpenWin]¯ }
    WritePChar(SoundPlay[sndCloseWin]);{ 63 - Sauvegarde du ®SoundPlay[sndCloseWin]¯ }
    WritePChar(SoundPlay[sndExit]);    { 64 - Sauvegarde du ®SoundPlay[sndExit]¯ }
    {$IFDEF Reseau}
     WritePChar(ModemBusy);             { 65 - Sauvegarde du ®ModemBusy¯ }
     WritePChar(ModemConnect);          { 66 - Sauvegarde du ®ModemConnect¯ }
     WritePChar(ModemNoCarrier);        { 67 - Sauvegarde du ®ModemNoCarrier¯ }
    {$ENDIF}
     { criture termine! }
    FileClose(Handle);
   End;
  End;
 End;

Begin
 TBInit;
 SUP:=MemNew(SizeOf(StartUpInfoRec));
 If(SUP=NIL)Then Begin
  WriteLn('Pas assez de m‚moire pour le d‚marrage');
  Halt;
 End;
 For I:=wnMin to(wnMI)do IconBnk[I].Output:=$FF;
 FolderIcon:=@IconBnk[icnFolder];
 SUP^.XmsOvrSwap:=True;NoLuxe:=False;RegUserName:=NIL;
 DefaultMode:=vmNone;FullDate:=True;RegSerialCode:=NIL;
 FontTitlePath:=NIL;FontInActifTitlePath:=NIL;FontAppPath:=NIL;
 ViewAppTitle:=True;ViewToolBar:=True;
 WriteLn(NamePrg,' Version ',VerPrg,'  Tous droits r‚serv‚s par les Chevaliers de Malte (C)');
 ALInit(SUP^.LoadFiles);
 ReadParam;
 WriteLn;
 If(SUP^.Verbose)Then WriteLn('Lecture du fichier d''initialisation: '+MB_INI);
 If Not(FastReadConfig)Then Begin
  ReadIniFile;
  SaveFastConfig;
 End;
 If(MainRegistryExist)Then Begin
  If(SUP^.Verbose)Then WriteLn('Lecture de la base de registres');
  ReadRegistry;
 End;
 If IsPChrEmpty(ExtAC)Then ExtAC:=Str2PChr('*.AC');
 If IsPChrEmpty(ExtAsm)Then ExtAsm:=Str2PChr('*.ASM;*.ASO;*.MAC;*.INC');
 If IsPChrEmpty(ExtBas)Then ExtBas:=Str2PChr('*.BAS;*.FRM');
 If IsPChrEmpty(ExtC)Then ExtC:=Str2PChr('*.C;*.CAS;*.CC;*.CPP;*.H;*.HPP');
 If IsPChrEmpty(ExtEuphoria)Then ExtEuphoria:=Str2PChr('*.E;*.EX');
 If IsPChrEmpty(ExtFortran)Then ExtFortran:=Str2PChr('*.FOR;*.F77');
 If IsPChrEmpty(ExtIni)Then ExtIni:=Str2PChr('*.INI');
 If IsPChrEmpty(ExtMsMnu)Then ExtMsMnu:=Str2PChr('*.MNU;*.DEF');
 If IsPChrEmpty(ExtPas)Then ExtPas:=Str2PChr('*.PAS;*.INC;*.DPR');
 If IsPChrEmpty(ExtRC)Then ExtRC:=Str2PChr('*.RC;*.RES');
 If Not FileExist(MaltePath+MB_INI)Then SUP^.Verbose:=True;
 If(SUP^.NoChgMode)Then DefaultMode:=vmNone;
 If IsPChrEmpty(PathSystems)Then PathSystems:=Str2PChr(Path2Dir(_PrgPath));
 I:=PrnOutput;
 InitSystems(suIsabel);
 { Adele.Mouse:=msCOM;}
 If I<>$FFThen PrnOutput:=I;
 If KeyWait and$80=$80Then KeyWait:=$FF;
 If(SUP^.NoMouse)Then SetMouse(False);
 If Not DirExist(StrPas(PathSystems))Then Begin
  WriteLn('AVERTISSEMENT: R‚pertoire du systŠme du Malte Genesis V invalide!');
  WriteLn;
  WriteLn('Le r‚pertoire ',PChar(PathSystems),' n''existe pas...');
  WriteLn('Le ',NamePrg,' ne peut pas fonctionner correctement si');
  WriteLn('ce r‚pertoire n''est pas valide!');
  WriteLn;
  WriteLn('Cause: C''est g‚n‚ralement du … une mauvaise installation, d''une copie');
  WriteLn('       d''un disque dur … un autre ou … une copie pirate...');
  WriteLn;
  WriteLn('Si vous n''autorisez pas la correction automatique, vous devrez');
  WriteLn('l''effectuer vous mˆme par l''entremise du Menu "Option", Item');
  WriteLn('"R‚pertoire", Cat‚gorie "SystŠme d''exploitation", R‚pertoire');
  WriteLn('"Malte" ou en modifier la variable "DIRSYSTEMS" du groupe "[Disk]"');
  WriteLn('du fichier "'+MB_INI+'".');
  WriteLn;
  WriteLn('Dois-je effectuer une correction (O)ui/(N)on ?');
  Repeat
   Chr:=ChrUp(Char(ReadKey))
  Until(Chr)in['O','N'];
  If Chr='O'Then Begin
   Chr:=Path2Drv(_PrgPath);
   If DirExist(Chr+Copy(StrPas(PathSystems),2,255))Then PathSystems^[0]:=Chr
    Else
   Begin
    StrDispose(PathSystems);
    SUP^.Path:=Path2Dir(_PrgPath)+'SYSTEMS';
    If Not DirExist(SUP^.Path)Then SUP^.Path:=Path2Dir(_PrgPath);
    SUP^.Path:=FileExpand(SUP^.Path);
    PathSystems:=Str2PChr(SUP^.Path);
    If Not DirExist(StrPas(PathUnix))Then Begin
     StrDispose(PathUnix);
     If DirExist(MaltePath+'UNIX')Then PathUnix:=Str2PChr(MaltePath+'UNIX')
                                  Else PathUnix:=Str2PChr(MaltePath);
    End;
   End;
   SaveIni;
  End;
 End;
 If KeyWait<>$FFThen Begin
  If(SUP^.Verbose)Then Write('Ajuste la vitesse du clavier... ');
  If SetTypm(KeyWait)Then Begin
   If(SUP^.Verbose)Then WriteLn('Correcte.')
  End
   Else
  WriteLn('Erreur clavier!');
 End;
 {$IFNDEF NotReal}
  If(SUP^.UMB)Then Begin
   If(SUP^.Verbose)Then WriteLn('Allocation des UMBs');
   ExtendHeap;
  End;
 {$ENDIF}
 InitDials;
 InitTools;
 DBInitServer(ChantalServer,MaltePath+'DATA\CHANTAL.DAT');
 If(SUP^.Verbose)Then Begin
  WriteLn('CPU: '+SelectField('CHANTAL:/Materiel/CPUModele.Dat',CPU,1));
  WriteLn('SystŠme d''exploitation:');
  WriteLn(' DOS Version ',Lo(GetDosVer),'.',Hi(GetDosVer));
  If(OS2)Then WriteLn(' OS/2 Version ',OS2LoVer,'.',OS2HiVer)
   Else
  If Win>0Then Begin
   Write(' Windows ');
   Case(Win)of
    winReal:Writeln('en mode R‚el');
    winStandard:Writeln('activ‚ en mode Standard');
    win386X:Writeln(#8'/386 Version 2.x actif');
    winEnhanced:Begin
     If(WinLoVer=4)and(WinHiVer=0)Then WriteLn('95')Else
     If(WinLoVer=4)and(WinHiVer=10)Then WriteLn('98')Else
     If(WinLoVer=4)and(WinHiVer=90)Then WriteLn('Me')Else
     If(WinLoVer=5)Then WriteLn('2000')
     Else
      Writeln('Version ',WinLoVer,'.',WinHiVer,' actif en mode Etendu');
    End;
    winNT:WriteLn('NT');
    Else WriteLn(' d''un univers inconnu...!');
   End;
  End;
 End;
 If Win>0Then SwapEms:=False;{ Swapper en EMS sous Windows relŠve de la
                               t‚m‚rit‚, voir mˆme des tendances suicidaire...}
 If(SUP^.Verbose)Then WriteLn('Initialise le PC Speaker...');
 NoSound;
 If(SUP^.Verbose)Then WriteLn('D‚tection des cartes de son:');
 {$IFDEF Real}
  If Not(SUP^.NotSoundCard)Then Begin
   If Not(IsNovell)Then Begin
    InitSound;
    _InitWave;
   End
    Else
   If(SUP^.Verbose)Then WriteLn('Annuler … cause du r‚seau!');
  End;
 {$ENDIF}
 If(SUP^.Verbose)Then Begin
  Write(' ');
  If(IsGravis)Then WriteLn('Gravis Ultra Sound')Else
  If(IsSoundBlaster)Then WriteLn('Sound Blaster')Else
  If(IsRoland)Then WriteLn('Roland MPU-401')Else
  If(IsAdLib)Then WriteLn('AdLib')Else
  If(IsTandyDigital)Then WriteLn('Tandy Digital')
   Else
  WriteLn('Mmm...Difficile … vivre: PC Speaker!');
  WriteLn('P‚riph‚rique:');
  WriteLn(' Souris: ',GetStrMouse);
  WriteLn(' Clavier: ',SelectField('CHANTAL:/Materiel/Clavier/Modele.Dat',KbdModel,1));
  If CurrModem>0Then WriteLn(' Modem par d‚faut: COM',Char(CurrModem+48),':');
 End;
 If(SUP^.NoSVGA)Then CheckSVGA:=False;
 If(Win=winEnhanced)and(WinLoVer=4)and(WinHiVer=90)Then Begin { Windows Me? }
  LoadGrfMtx;
 End;
End;

Var
 OldExitProc:Procedure;
 OldExitProcPtr:Pointer Absolute OldExitProc;

Procedure ExitRoutine;Far;Begin
 If(OldExitProcPtr<>NIL)Then OldExitProc;
 If ExitCode<>0Then Begin
  DoneMemManagers;  { Lib‚ration de la m‚moire EMS, XMS,...}
  DoneExtendHeap;   { Lib‚ration de la m‚moire UMB }
   { Aller en mode texte si mode graphique... }
  If(IsGrf)and(IsEGA)Then ASM
   MOV AX,3
   INT 10h
  END;
 End;
End;

Procedure LoadTaskBarApp;
Var
 Tasks,MaximumTasks,ForegroundTaskIndex:Word;
 I:Integer;                                   { Compteur de boucle }
 NumTaskBar:Word;
 Q:^TaskBarManager;
Begin
 If(TaskMgrInTaskBar)and(DPMSInstalled)Then Begin
  NumTaskBar:=Windows.Lst.Count-1;
  TMGetStatus(Tasks,MaximumTasks,ForegroundTaskIndex);
  If(Tasks>0)and(Tasks<5000)Then Begin
   For I:=0to Tasks-1do If(TMGetForegroundTaskIndex<>I)Then Begin
    HLoad(Windows,wnTaskBarMgr,TMGetTaskName(I));
    Q:=HPtr(Windows);
    If(Q<>NIL)Then Q^.Index:=I;
   End;
   HGotoNum(Windows,NumTaskBar);
   SetMnuSwitch;
  End;
 End;
End;

Procedure FinishStart;Begin
 InitMemNKit;
 InitScrNDesktop;
 InstallRebootManager;
 LoadTaskBarApp;
 OldExitProcPtr:=ExitProc;
 ExitProc:=@ExitRoutine;
End;
