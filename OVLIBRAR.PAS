Unit OVLibrary;

INTERFACE

{$I DEF.INC}

Uses {$IFDEF Adele}Adele,{$ELSE}Chantal,{$ENDIF}Isatex,
     Systex,Systems,Video,Mouse,Dials,DialPlus,
     Editor,EdtLoad,EdtDone,EdtExtra,EdtSave,
     Pas2Lam,Project;

Const
 ocOpen=$F000;
 ocData2Bin=$F001;
 ocBin2BGI=$F002;
 ocBinToAsm=$F003;
 ocCP2GAT=$F004;
 ocC2Pas=$F005;
 ocRC2Pas=$F006;
 ocQPU2Pas=$F007;
 ocNG2ASC=$F008;
 ocFLB2RC=$F009;
 ocRC2RLL=$F00A;
 ocSearchIntr=$F00B;
 ocSearchAsm=$F00C;
 ocSearchBasic=$F00D;
 ocSearchC=$F00E;
 ocSearchPascal=$F00F;
 ocSearchPL1=$F010;
 ocInterrupt=$F011;
 ocAsm=$F012;
 ocBasic=$F013;
 ocC=$F014;
 ocPascal=$F015;
 ocPL1=$F016;
 ocNewPrj=$F017;
 ocPrjTitle=$F018;
 ocWindowNext=$F019;
 ocWindowPrevious=$F01A;
 ocWindowClose=$F01B;
 ocWindowList=$F01C;
 ocPrjComposant=$F01D;
 ocSaveProject=$F01E;
 ocSaveAsProject=$F01F;
 ocOpenProject=$F020;
 ocExit=$F0FF;

 snEdt=$01;
 snPrj=$02;

 LstHWin:Array[0..1]of HWin=(
  (SerialNumber:snEdt;
   Init:TENew;
   Load:TEOpen;
   Run:TERun;
   Done:TEDone;
   Refresh:TERefresh;
   Save:TESave;
   SaveAs:TESaveAs;
   SizeOfQ:SizeOf(EditorApp);
   Title:TETitle),
  (SerialNumber:snPrj;
   Init:PRNew;
   Load:PROpen;
   Run:PRRun;
   Done:PRDone;
   Refresh:PRRefresh;
   Save:PRSave;
   SaveAs:PRSaveAs;
   SizeOfQ:SizeOf(ProjectRec);
   Title:PRTitle)
 );

Var Windows:HWins;

Procedure NewComposantProject;
Procedure SetTitleProject;
Procedure OpenProject;
Procedure LoadCurrFile;
Procedure MakeMnu;
Procedure ResetMenu;

IMPLEMENTATION

Uses Apps;

Procedure SetTitleProject;Var S:String;Begin
 S:=ProjectRec(HPtr(Windows)^).Title;
 If(_WinInp(40,'Titre','Entrez le son nouveau titre',No,S)=kbEnter)Then Begin
  PRSetTitle(ProjectRec(HPtr(Windows)^),S);
 End;
End;

Procedure NewComposantProject;Begin
 PRNewComposant(ProjectRec(HPtr(Windows)^));
End;

Procedure OpenProject;Var Path:String;Begin
 Path:=OpenWin('*.PRP','Ouvre Dessin');
 If Path<>''Then HLoad(Windows,snPrj,Path);
End;

Procedure LoadCurrFile;Var Path:String;Begin
 If(HModel(Windows)=snPrj)Then Begin
  Path:=PRCurrFile(ProjectRec(HPtr(Windows)^));
  HLoad(Windows,snEdt,Path);
  ResetMenu;
 End;
End;

Procedure MakeMnu;Begin
 PMInit;
 PMAddMnu('^F^ichier');
  PMAddItemKey('^O^uvre',kbF3,ocOpen,'Ouvrir un fichier s''il existe, sinon il le cr‚e');
  PMAddBarItem;
  If(HModel(Windows)=snPrj)Then Begin
   PMAddItemKey('^S^auve projet',kbF2,ocSaveProject,'Sauvegarde le projet');
   PMAddItemKey('^S^auve projet sous...',kbNoKey,ocSaveAsProject,'Sauvegarde le projet sous un nom particulier');
   PMAddBarItem;
  End;
  PMAddItemKey('^Q^uitter',kbAltX,ocExit,'Permet de quitter l''®OverCode¯!');
 PMAddMnu('^P^rojet');
  PMAddItemKey('^N^ouveau',kbNoKey,ocNewPrj,'Cr‚ation d''un nouveau projet');
  PMAddItemKey('^O^uvre',kbNoKey,ocOpenProject,'Ouvre un projet existant');
  If(HModel(Windows)=snPrj)Then Begin
   PMAddBarItem;
   PMAddItemKey('^T^itre',kbNoKey,ocPrjTitle,'Permet de d‚finir le titre du projet');
   PMAddItemKey('^N^ouveau composant',kbNoKey,ocPrjComposant,'Ajouter un composante au projet');
  End;
 PMAddMnu('^T^ransformation');
  PMAddItemKey('Donn‚e … Binaire ASCII',kbNoKey,ocData2Bin,'Transforme un fichier de donn‚e en un fichier binaire ASCII');
  PMAddItemKey('Binaire … BGI',kbNoKey,ocBin2BGI,'Transforme un fichier binaire … un format Borland Graphics Interface');
  PMAddItemKey('Binaire … Assembleur',kbNoKey,ocBinToAsm,'Transforme un fichier binaire en assembleur');
  PMAddItemKey('Norton Guide … ASCII',kbNoKey,ocNG2ASC,'Transforme un fichier Norton Guide en un fichier texte ASCII');
  PMAddItemKey('Central-Point … GAT',kbNoKey,ocCP2GAT,'Transforme un fichier texte Central-Point … un format GAT');
  PMAddItemKey('C … Pascal',kbNoKey,ocC2Pas,'Transforme un source C en format Pascal');
  PMAddItemKey('QPU … Pascal',kbNoKey,ocQPU2Pas,'Transforme une unit‚ QPU compil‚ en fichier Pascal');
  PMAddItemKey('RC … Pascal',kbNoKey,ocRC2Pas,'Transforme une ressource en langage Pascal');
  PMAddItemKey('RC … RLL',kbNoKey,ocRC2RLL,'Transforme une ressource en format RLL');
  PMAddItemKey('FLB … RC',kbNoKey,ocFLB2RC,'Transforme une bibliothŠque de police en fichier ressource');
 PMAddMnu('^R^echerche');
  PMAddItemKey('^I^nterruption',kbNoKey,ocSearchIntr,'Permet de rechercher dans la liste une interruption du standard d''IBM');
  PMAddBarItem;
  PMAddItemKey('^A^ssembleur',kbNoKey,ocSearchAsm,'Permet de rechercher dans la liste une d‚finition Assembleur');
  PMAddItemKey('^B^asic',kbNoKey,ocSearchBasic,'Permet de rechercher dans la liste une d‚finition Basic');
  PMAddItemKey('^C^/C++',kbNoKey,ocSearchC,'Permet de rechercher dans la liste une d‚finition C/C++');
  PMAddItemKey('^P^ascal',kbNoKey,ocSearchPascal,'Permet de rechercher dans la liste une d‚finition Pascal');
  PMAddItemKey('PL/^1^',kbNoKey,ocSearchPL1,'Permet de rechercher dans la liste une d‚finition PL/1');
 PMAddMnu('Fe^n^ˆtre');
  PMAddItemKey('^S^uivante',kbF6,ocWindowNext,'Passe … la fenˆtre suivante');
  PMAddItemKey('^P^r‚c‚dente',kbShiftF6,ocWindowPrevious,'Passe … la fenˆtre pr‚c‚dente');
  PMAddItemKey('^F^erme',kbAltF3,ocWindowClose,'Ferme la fenˆtre actuel');
  PMAddItemKey('^L^iste',kbAlt0,ocWindowList,'Liste des fenˆtres ouvertes');
 PMAddMnu('^A^ide');
  PMAddItemKey('^I^nterruption',kbNoKey,ocInterrupt,'Permet de connaŒtre quelques informations '+
                'sur les interruptions du standard d''IBM');
  PMAddBarItem;
  PMAddItemKey('^A^ssembleur',kbNoKey,ocAsm,'Permet de connaŒtre la liste des instructions Assembleur INTEL');
  PMAddItemKey('^B^asic',kbNoKey,ocBasic,'Permet de connaŒtre la liste des proc‚dures Basic');
  PMAddItemKey('^C^/C++',kbNoKey,ocC,'Permet de connaŒtre la liste des fonctions C/C++');
  PMAddItemKey('^P^ascal',kbNoKey,ocPascal,'Permet de connaŒtre la liste des proc‚dures Pascal');
  PMAddItemKey('PL/^1^',kbNoKey,ocPL1,'Permet de connaŒtre la liste des proc‚dures PL/1');
 PMSetWinBar(0,1,MaxXTxts);
 PMPutMnuBar;
End;

Procedure ResetMenu;Begin
 PMDone;
 MakeMnu;
End;

END.