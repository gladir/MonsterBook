{Description
 様様様様様�

  Ce programme est un IDE permettant d'�crit des programmes dans un langage
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
{$O PCBase}
{$O PCCompile}
{$O PCData}
{$O PCDone}
{$O PCInit}
{$O PCLine}
{$O PCLink}
{$O PCMake}
{$O PCPass}
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
 ocOptionDir=$F021;
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
  PMAddItemKey('^O^uvre',kbF3,ocOpen,'Ouvrir un fichier s''il existe, sinon il le cr�e');
  PMAddItemKey('^S^auvegarde',kbF2,ocSave,'Sauvegarde le fichier sous son nom courant');
  PMAddItemKey('S^a^uvegarde sous',kbNoKey,ocSaveAs,'Sauvegarde le fichier sous son nom courant');
  PMAddBarItem;
  PMAddItemKey('Interpr�teur ^D^OS',kbNoKey,ocShell,'Lancez l''interpr�teur de commande du DOS');
  PMAddBarItem;
  PMAddItemKey('^Q^uitter',kbAltX,ocExit,'Permet de quitter l''�OverCode�!');
 PMAddMnu('^R^echerche');
  PMAddItemKey('^I^nterruption',kbNoKey,ocSearchIntr,'Permet de rechercher dans la liste une interruption du standard d''IBM');
  PMAddBarItem;
  PMAddItemKey('^A^ssembleur',kbNoKey,ocSearchAsm,'Permet de rechercher dans la liste une d�finition Assembleur');
  PMAddItemKey('^B^asic',kbNoKey,ocSearchBasic,'Permet de rechercher dans la liste une d�finition Basic');
  PMAddItemKey('^C^/C++',kbNoKey,ocSearchC,'Permet de rechercher dans la liste une d�finition C/C++');
  PMAddItemKey('^P^ascal',kbNoKey,ocSearchPascal,'Permet de rechercher dans la liste une d�finition Pascal');
  PMAddItemKey('PL/^1^',kbNoKey,ocSearchPL1,'Permet de rechercher dans la liste une d�finition PL/1');
 PMAddMnu('^E^x�cution');
  PMAddItemKey('^E^x�cuter',kbCtrlF9,ocRun,'Permet d''ex�cuter le programme');
 PMAddMnu('^C^ompile');
  PMAddItemKey('^C^ompile',kbAltF9,ocCompile,'Compile le programme de la fen�tre courante');
  PMAddBarItem;
  PMAddItemKey('^I^nformation',kbNoKey,ocCompileInfo,'Retourne les informations sur la compilation');
 PMAddMnu('^O^ption');
  PMAddItemKey('^C^ode machine',kbNoKey,ocOptionCodeMachine,'D�finit le format de code machine '+
               'par d�faut lors de la compilation');
  PMAddItemKey('Compr�hension ^S^yntaxique',kbNoKey,ocOptionSyntax,'D�finit la compr�hension syntaxique de langage Pascal');
  PMAddItemKey('^T^ype de Projet',kbNoKey,ocOptionTarget,'D�finit la mod�le de fichier ex�cutable');
  PMAddItemKey('^R^�pertoire',kbNoKey,ocOptionDir,'D�finit les r�pertoires par d�faut');
 PMAddMnu('Fe^n^�tre');
  PMAddItemKey('^S^uivante',kbF6,ocWindowNext,'Passe � la fen�tre suivante');
  PMAddItemKey('^P^r�c�dente',kbShiftF6,ocWindowPrevious,'Passe � la fen�tre pr�c�dente');
  PMAddItemKey('^F^erme',kbAltF3,ocWindowClose,'Ferme la fen�tre actuel');
  PMAddItemKey('^L^iste',kbAlt0,ocWindowList,'Liste des fen�tres ouvertes');
  PMAddItemKey('�cran S^o^rtie',kbAltF5,ocOutput,'Permet de voir l''�cran de sortie du programme fils');
 PMAddMnu('^A^ide');
  PMAddItemKey('^I^nterruption',kbNoKey,ocInterrupt,'Permet de conna�tre quelques informations '+
                'sur les interruptions du standard d''IBM');
  PMAddBarItem;
  PMAddItemKey('^A^ssembleur',kbNoKey,ocAsm,'Permet de conna�tre la liste des instructions Assembleur INTEL');
  PMAddItemKey('^B^asic',kbNoKey,ocBasic,'Permet de conna�tre la liste des proc�dures Basic');
  PMAddItemKey('^C^/C++',kbNoKey,ocC,'Permet de conna�tre la liste des fonctions C/C++');
  PMAddItemKey('^P^ascal',kbNoKey,ocPascal,'Permet de conna�tre la liste des proc�dures Pascal');
  PMAddItemKey('PL/^1^',kbNoKey,ocPL1,'Permet de conna�tre la liste des proc�dures PL/1');
 PMSetWinBar(0,1,MaxXTxts);
End;

Var I:Byte;Path:String;

BEGIN
 Jump.FlagsMethod:=stupJumperSecure;
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
 AppInit('�OverCode� - �dition Pascal',$78,MtxBleuet);
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
   ocOptionDir:OptionDir;
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