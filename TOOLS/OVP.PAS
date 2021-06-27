{Description
 ÕÕÕÕÕÕÕÕÕÕÕ

  Ce programme est un IDE permettant d'Çcrit des programmes dans un langage
 de programmation Pascal de format B57.
}

Program OverCodePascal;

{$I \Source\Chantal\DEF.INC}
Uses OvInit,Adele,Isatex,
     Systex,Systems,SysPlus,Video,Mouse,Dials,DialPlus,Apps,
     Editor,EdtLoad,EdtDone,EdtExtra,EdtSave,Dialex,
     OvIDE,OvConfig,OvStart,OvExit,ToolTerm,ResServD;

{$O DialPlus}
{$O Editor}
{$O EdtBlock}
{$O EdtDone}
{$O EdtExtra}
{$O EdtJust}
{$O EdtLoad}
{$O EdtSave}
{$O EdtSearc}
{$O FileMana}
{$O InfoMemo}
{$O OVConfig}
{$O OVIde}
{$O OVStart}
{$O OVExit}
{$O PCAsm}
{$O PCLink}
{$O PCMake}
{$O PCUnit}
{$O ResLoadI}
{$O ResLoadD}
{$O ResServI}
{$O ResSaveD}
{$O ResSaveI}
{$O SysPlus}
{$O Terminal}
{$O Tools}
{$O ToolInfo}
{$O ToolPrn}
{$O ToolTerm}
{$O ToolView}

Const
 ocOpen=$F000;
 ocSave=$F001;
 ocSaveAs=$F002;
 ocCompile=$F00A;
 ocCompileInfo=$F00B;
 ocSearchIntr=$F00C;
 ocSearchAsm=$F00D;
 ocSearchBasic=$F00E;
 ocSearchC=$F00F;
 ocSearchPascal=$F010;
 ocSearchPL1=$F011;
 ocRun=$F012;
 ocOptionCodeMachine=$F013;
 ocOptionSyntax=$F014;
 ocOptionTarget=$F015;
 ocInterrupt=$F016;
 ocAsm=$F017;
 ocBasic=$F018;
 ocC=$F019;
 ocPascal=$F01A;
 ocPL1=$F01B;
 ocWindowNext=$F01C;
 ocWindowPrevious=$F01D;
 ocWindowClose=$F01E;
 ocWindowList=$F01F;
 ocOutput=$F020;
 ocShell=$F0FE;
 ocExit=$F0FF;

 LstHWin:Array[0..0]of HWin=(
  (SerialNumber:snEdt;
   Init:TENew;
   Load:TEOpen;
   Run:TERun;
   Done:TEDone;
   Refresh:TERefresh;
   Save:TESave;
   SaveAs:TESaveAs;
   SizeOfQ:SizeOf(EditorApp);
   Title:TETitle)
  );

Procedure MakeMnu;Begin
 PMInit;
 PMAddMnu('^F^ichier');
  PMAddItemKey('^O^uvre',kbF3,ocOpen,'Ouvrir un fichier s''il existe, sinon il le crÇe');
  PMAddItemKey('^S^auvegarde',kbF2,ocSave,'Sauvegarde le fichier sous son nom courant');
  PMAddItemKey('S^a^uvegarde sous',kbNoKey,ocSaveAs,'Sauvegarde le fichier sous son nom courant');
  PMAddBarItem;
  PMAddItemKey('InterprÇteur ^D^OS',kbNoKey,ocShell,'Lancez l''interprÇteur de commande du DOS');
  PMAddBarItem;
  PMAddItemKey('^Q^uitter',kbAltX,ocExit,'Permet de quitter l''ÆOverCodeØ!');
 PMAddMnu('^R^echerche');
  PMAddItemKey('^I^nterruption',kbNoKey,ocSearchIntr,'Permet de rechercher dans la liste une interruption du standard d''IBM');
  PMAddBarItem;
  PMAddItemKey('^A^ssembleur',kbNoKey,ocSearchAsm,'Permet de rechercher dans la liste une dÇfinition Assembleur');
  PMAddItemKey('^B^asic',kbNoKey,ocSearchBasic,'Permet de rechercher dans la liste une dÇfinition Basic');
  PMAddItemKey('^C^/C++',kbNoKey,ocSearchC,'Permet de rechercher dans la liste une dÇfinition C/C++');
  PMAddItemKey('^P^ascal',kbNoKey,ocSearchPascal,'Permet de rechercher dans la liste une dÇfinition Pascal');
  PMAddItemKey('PL/^1^',kbNoKey,ocSearchPL1,'Permet de rechercher dans la liste une dÇfinition PL/1');
 PMAddMnu('^E^xÇcution');
  PMAddItemKey('^E^xÇcuter',kbCtrlF9,ocRun,'Permet d''exÇcuter le programme');
 PMAddMnu('^C^ompile');
  PMAddItemKey('^C^ompile',kbAltF9,ocCompile,'Compile le programme de la fenàtre courante');
  PMAddBarItem;
  PMAddItemKey('^I^nformation',kbNoKey,ocCompileInfo,'Retourne les informations sur la compilation');
 PMAddMnu('^O^ption');
  PMAddItemKey('^C^ode machine',kbNoKey,ocOptionCodeMachine,'DÇfinit le format de code machine '+
               'par dÇfaut lors de la compilation');
  PMAddItemKey('ComprÇhension ^S^yntaxique',kbNoKey,ocOptionSyntax,'DÇfinit la comprÇhension syntaxique de langage Pascal');
  PMAddItemKey('^T^ype de Projet',kbNoKey,ocOptionTarget,'DÇfinit la modäle de fichier exÇcutable');
 PMAddMnu('Fe^n^àtre');
  PMAddItemKey('^S^uivante',kbF6,ocWindowNext,'Passe Ö la fenàtre suivante');
  PMAddItemKey('^P^rÇcÇdente',kbShiftF6,ocWindowPrevious,'Passe Ö la fenàtre prÇcÇdente');
  PMAddItemKey('^F^erme',kbAltF3,ocWindowClose,'Ferme la fenàtre actuel');
  PMAddItemKey('^L^iste',kbAlt0,ocWindowList,'Liste des fenàtres ouvertes');
  PMAddItemKey('êcran S^o^rtie',kbAltF5,ocOutput,'Permet de voir l''Çcran de sortie du programme fils');
 PMAddMnu('^A^ide');
  PMAddItemKey('^I^nterruption',kbNoKey,ocInterrupt,'Permet de connaåtre quelques informations '+
                'sur les interruptions du standard d''IBM');
  PMAddBarItem;
  PMAddItemKey('^A^ssembleur',kbNoKey,ocAsm,'Permet de connaåtre la liste des instructions Assembleur INTEL');
  PMAddItemKey('^B^asic',kbNoKey,ocBasic,'Permet de connaåtre la liste des procÇdures Basic');
  PMAddItemKey('^C^/C++',kbNoKey,ocC,'Permet de connaåtre la liste des fonctions C/C++');
  PMAddItemKey('^P^ascal',kbNoKey,ocPascal,'Permet de connaåtre la liste des procÇdures Pascal');
  PMAddItemKey('PL/^1^',kbNoKey,ocPL1,'Permet de connaåtre la liste des procÇdures PL/1');
 PMSetWinBar(0,1,MaxXTxts);
End;

Var I:Byte;Path:String;

BEGIN
 InitSystems(suIsabel);
 PathDskSwp:=FileExpand('OVERCODE.$$$');
 {$IFNDEF NotReal}
{  ExtendHeap;}
 {$ENDIF}
 InitMemManagers;
 PushScr(Output);
 SetVideoModeDeluxe(vmTxtDef);
 DBInitServer(ChantalServer,MaltePath+'DATA\CHANTAL.DAT');
 __InitMouse;
 MakeMnu;
 AppInit('ÆOverCodeØ - êdition Pascal',$78,MtxBleuet);
 HInit(Windows);
 For I:=0to 1do HAddNewModel(Windows,LstHWin[I]);
 Start;
 PutLastBar;
 Repeat
  Case HRun(Windows)of
   kbF3,ocOpen:Begin
    Path:=OpenWin('*.*','Ouvre un fichier Pascal');
    If Path<>''Then HLoad(Windows,snEdt,Path);
    PutLastBar;
   End;
   kbAltX,ocExit:Break;
   kbF2,ocSave:HSave(Windows);
   ocSaveAs:HSaveAs(Windows);
   kbAltF5,ocOutput:LookOutput;
   kbAltF3,ocWindowClose:Begin
    HClose(Windows);
    PutLastBar;
   End;
   kbAlt0,ocWindowList:Begin
    HGotoWin(Windows);
    PutLastBar;
   End;
   kbF6,ocWindowNext:Begin
    HNext(Windows);
    PutLastBar;
   End;
   kbShiftF6,ocWindowPrevious:Begin
    HPrevious(Windows);
    PutLastBar;
   End;
   kbAltF9,ocCompile:CompilePascal;
   kbCtrlF9,ocRun:RunProgram;
   ocCompileInfo:CompileInfo;
   ocOptionCodeMachine:SetupCPUTarget;
   ocOptionSyntax:SetupSyntax;
   ocOptionTarget:SetupTarget;
   ocShell:ExecPrg('','');
   kbCtrlEnter:OpenAtCursor;
  End;
 Until No;
 ExitPrg;
 DoneLuxeVideo;
 PopScr(Output);
 {$IFNDEF NotReal}
{  DoneExtendHeap;}
 {$ENDIF}
 DoneMemManagers;
END.