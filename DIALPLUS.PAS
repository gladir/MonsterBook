{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                                                                         Û
 ³                   Malte Genesis/Suppl‚ment de dialogue                  Û
 ³                                                                         Û
 ³            dition Chantal pour Mode R‚el/IV - Version 1.1              Û
 ³                              1999/08/08                                 Û
 ³                                                                         Û
 ³          Tous droits r‚serv‚s par les Chevaliers de Malte (C)           Û
 ³                                                                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Nom du programmeur
 ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

  Sylvain Maltais


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette  unit‚  renferme  toutes  les options  suppl‚mentaires  de  dialogue
 utilisateur utilis‚ couramment par le programmeur.  Par exemple les options
 pour l'ouverture d'un fichier,...
}

Unit DialPlus;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                  INTERFACE
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

{$I DEF.INC}

Uses Systex,Isatex,Dialex;

Const
  {ModŠle de fichier demander }
 omCoder=$0001;         { Fichier de programmeur }
 omConfig=$0002;        { Fichier de configuration }
 omMacro=$0004;         { Fichier de macro ou raccourci }
 omDocument=$0008;      { Fichier de document et de texte }
 omDraw=$0010;          { Fichier d'image }
 omCursor=$0020;        { Fichier de curseur }
 omIcon=$0040;          { Fichier d'ic“ne }
 omFont=$0080;          { Fichier de police de caractŠres }
 omBase=$0100;          { Fichier de base de donn‚es }
 omResource=$0200;      { Fichier de ressource }
 omSound=$0400;         { Fichier de musique ou bande sonore }
 omCalc=$0800;          { Fichier de chiffrier ‚lectronique }
 omAnim=$1000;          { Fichier d'animation }
 omTechDraw=$2000;      { Fichier de dessin technique (DFD, ‚lectronique,...)}
 omCompress=$4000;      { Fichier compress‚ }
 omExecutable=$8000;    { Ex‚cutable }
 omAll=$FFFF;           { Tous les fichiers }

Const
  {Cat‚gorie de fichier}
 cfoIconWindows=$0001;       { Ic“ne Windows }
 cfoIconOS2=$0002;           { Ic“ne OS/2 }
 cfoIconGenesis=$0003;       { Ic“ne Genesis }
 cfoIconAdele=$0004;         { Ic“ne AdŠle }
 cfoIconGeoWorks=$0005;      { Ic“ne GeoWorks }
 cfoIconGemDesktop=$0006;    { Ic“ne GemDesktop }
 cfoPointerOS2=$0007;        { Pointeur OS/2 }
 cfoBitMapWindows=$0008;     { Image de format BitMap de format Windows }
 cfoBitMapOS2=$0009;         { Image de format BitMap de format OS/2 }
 cfoMacPaint=$000A;          { Image de format MacPaint }
 cfoGemImg=$000B;            { Image de format GEM/IMG et la filiŠre Ventura }
 cfoGFX=$000C;               { Image GFX sans entˆte: 320x200 en 256 couleurs }
 cfoPPM=$000D;               { Image PPM/PGM }
 cfoPCX=$000E;               { Image PCX }
 cfoLBM=$000F;               { Image LBM/BBM }
 cfoTGA=$0010;               { Image de format Targa }
 cfoTIFF=$0011;              { Image de format TIFF }
 cfoGIF=$0012;               { Image GIF }
 cfoJPEG=$0013;              { Image de format de compression JPEG/JFIF }
 cfoWPG=$0014;               { Graphique de WordPerfect }
 cfoGPX=$0015;               { Image de l'ensemble Malte Genesis GPX }
 cfoBGX=$0016;               { Image BitMap Genesis }
 cfoHex=$0017;               { Codage hexad‚cimal }
 cfoGatElectric=$0018;       { Plan ‚lectronique en fichier document GAT }
 cfoResWindows=$0019;        { Ressource de Windows (RES) }
 cfoExeWindows=$001A;        { Ex‚cutable de Windows (RES) }
 cfoCorelDraw=$001B;         { Image Corel Draw }
 cfoXBM=$001C;               { Image XBM }
 diWordPerfectGraphics=$001D;{ Dessin de Word Perfect }
 diMBF=$001E;                { MonsterBookFont }
 diRLL=$001F;                { BibliothŠque d'image }
 cfoSCi=$0020;               { Image SCi }
 cfoImi=$0021;               { Dessin technique (Intelligent Image)}
 cfoPNG=$0022;               { Image graphique de format PNG }
 cfoMacro=$0024;             { Macro }
 cfoMouseMenu=$0025;         { Menu Souris }
 cfoFNT=$0026;               { Police de caractŠres BIOS }
 cfoQQF=$0027;               { Police de caractŠres QQF }
 cfoProfessionnalWrite=$0028;{ Document "Professionnal Write"}
 cfoRes=$0029;               { Ressource }
 cfoVoice=$002A;             { Musique "Voice" VOC }
 cfoWave=$002B;              { Musique WAVE }
 cfoBatch=$002C;             { Fichier Batch }
 cfoHTML=$002D;              { Document HTML }
 cfoANSI=$002E;              { Format texte ANSI }
 cfoASCII=$002F;             { Format texte ASCII DOS }
 cfoTextUnix=$0030;          { Format texte ASCII Unix }
 cfoRTF=$0031;               { Format texte mise en format RTF }
 cfoMGC=$0032;               { Format tableur ®Malte Genesis Calc¯ }
 cfoLst=$0033;               { Format tableur liste ASCII }
 cfo3DStudio=$0034;          { Format d'une animation 3D Studio }
 cfoLotus123=$0035;          { Format tableur Lotus 1-2-3 }
 cfoLogo=$0036;              { Langage de programmation LOGO }
 cfoExcel21=$0037;           { Format tableur Excel 2.1 }
 cfoWord=$0039;              { Document Microsoft Word }
 cfoAssembler=$003A;         { Code Source de langage Assembleur }
 cfoCobol=$003B;             { Code Source de langage Cobol }
 cfoGat=$003D;               { Document GAT }
 cfoDBase=$003E;             { Base de donn‚es DBase }
 cfoAC=$003F;                { Code Source de langage AC }
 cfoAda=$0040;               { Code Source de langage Ada }
 cfoBasic=$0041;             { Code Source de langage Basic }
 cfoC=$0042;                 { Code Source de langage C/C++ }
 cfoEuphoria=$0043;          { Code Source de langage Euphoria }
 cfoFortran=$0044;           { Code Source de langage Fortran }
 cfoPascal=$0045;            { Code Source de langage Pascal }
 cfoFirstChoice=$0046;       { Document Premier Choix }
 cfoCorelPhotoPaint=$047;    { Image Corel Photo-Paint }
 cfoIcon=$0048;              { Ic“ne }
 cfoIcn=$0049;               { Ic“ne Genesis }
 cfoINI=$0050;               { Configuration Initialisation .INI }
 cfoCSV=$0051;               { Tableur de format .CSV }
 cfoGeoWorks=$BE00;          { GeoWorks }
 cfoExe=$C000;               { Ex‚cutable }
 cfoCursor=$D000;            { Curseur }
 cfoDocument=$D001;          { Document }
 cfoXokyReg=$E000;           { Base de registres ®Xoky¯ }
 cfoExtensior=$E001;         { Extensior }
 cfoCab=$F000;               { Fichier compress‚ Microsoft Compressed File }
 cfoZip=$F001;               { Fichier compress‚ ®Zip¯ }
 cfoZoo=$F002;               { Fichier compress‚ ®Zoo¯ }
 cfoArj=$F003;               { Fichier compress‚ ®Arj¯ }
 cfoSwag=$F004;              { Fichier compress‚ ®Swag¯ }
 cfoLZH=$F005;               { Fichier compress‚ ®LZH¯ }
 cfoRAR=$F006;               { Fichier compress‚ ®RAR¯ }
 cfoAll=$FFFF;               { Tous les fichiers }

 ExtAC:PChr=NIL;          { Extension par d‚faut du langage AC: "*.AC" }
 ExtAsm:PChr=NIL;         { Extension par d‚faut du langage Assembleur: "*.ASM;*.MAC;*.INC" }
 ExtBas:PChr=NIL;         { Extension par d‚faut du langage Basic: "*.BAS" }
 ExtC:PChr=NIL;           { Extension par d‚faut du langage C/C++: "*.C;*.CAS;*.CC;*.CPP;*.H" }
 ExtEuphoria:PChr=NIL;    { Extension par d‚faut du langage Euphoria: "*.E;*.EX" }
 ExtFortran:PChr=NIL;     { Extension par d‚faut du langage Fortran: "*.FOR;*.F77" }
 ExtIni:PChr=NIL;         { Extension par d‚faut des fichiers d'initialisation: "*.INI" }
 ExtMsMnu:PChr=NIL;       { Extension par d‚faut du fichier souris PopMenu: "*.MNU;*.DEF" }
 ExtPas:PChr=NIL;         { Extension par d‚faut du langage Pascal: "*.PAS;*.INC" }
 ExtRC:PChr=NIL;          { Extension par d‚faut d'une ressource: "*.RC;*.RES" }

Procedure CMLoad(Var Q:ContextMenu;Const Path:String;Index:Word);
Procedure CMLoadApp(Var Q:ContextMenu;Index:Word);
Procedure CMDone(Var Q:ContextMenu);
Procedure ErrMsgRes(Code:Word);
Function  ExecuteAppDPU(Index:Word;Var Output):Boolean;
Function  ExecuteDPU(Const Name:String;Index:Word;Var Output):Boolean;
Procedure ExtensiorInit(Var Q:Extensior);
Procedure ExtensiorAdd(Var Q:Extensior;Const Name,Image,WildCard,Execute:String;Attr:Word);
Procedure ExtensiorEditor;
Function  ExtensiorNumIcon(Var Q:Extensior):Word;
Procedure ExtensiorDone(Var Q:Extensior);
Function  FindActionExtensior(Const Name:String;Var Action:String):Boolean;
Function  FLInit(Var Q;X1,Y1,X2,Y2:Byte):Boolean;
Procedure FLInitNPropriety(Var Q:FileListBox;Const Path,Title:String;
                           Var H:History;Var M:ArrayList;
                           PreView,SettingDescr,Push:Boolean);
Procedure FLInitModel(Var Q:FileListBox;Const Path,Title:String;
                      Var H:History;PreView,SettingDescr,Push:Boolean;Model:Word);
Function  FLDirectory(Const Q:FileListBox):String;
Function  FLDrive(Const Q:FileListBox):Char;
Function  FLMask(Const Q:FileListBox):String;
Function  FLFormat(Const Q:FileListBox):Word;
Procedure FLRefresh(Var Q);
Function  FLRun(Var QX):Word;
Function  FLTitle(Var Q;Max:Byte):String;
Procedure FLMove2(Var Q;X,Y:Byte);
Procedure FLUpDateFormat(Var Q:FileListBox;Format:Word);
Function  FLDone(Var Q):Word;
Function  OpenWin(Const Path,Title:String):String;
Function _OpenWin(Const Path,Title:String;Var Q:History):String;
Function _OpenWinAllModel(Const Path,Title:String;Var Q:History):String;
Function _OpenWinModel(Const Path,Title:String;Var Q:History;Model:Word):String;
Function _OpenWinMultiModel(Const Path,Title:String;Var Q:History;Var M:ArrayList;
                            PreView,SettingDescr:Boolean):String;
Function  RunDPU(Const CodeDPU;Var Output):Boolean;
Function  RunMenuApp(Index:Word):Word;
Procedure SOInit(Var Inf:SwitchOption;X,Y:Byte;Const Name,Option:String;YP:Byte);
Function  TypeCFO(Const Path:String):Word;
Function  WEInputString(Var W:Window;X1,Y,X2,Len:Byte;Var S:String):Word;
Procedure WEMoveWn(Var Q:Window);
Procedure WERInit(Var R:ResourceWindow);
Procedure WERDecompile(Var R:ResourceWindow;Const CodeDPU;Var Output);
Procedure WERLoad(Var R:ResourceWindow;Const Name:String;Index:Word;Var Output);
Procedure WERLoadApp(Var R:ResourceWindow;Index:Word;Var Output);
Function  WERRun(Var R:ResourceWindow):Boolean;
Procedure WERDone(Var R:ResourceWindow);
Procedure WinAddExtensior(Const Name:String);
Function  WinInpNmWord(L:Byte;Const Title,Msg:String;Const Kr:MtxColors;Min,Max:Word;Var Num:Word):Word;
Procedure _CMLoad(Var Q:ContextMenu;Const Path:String;Index:Word;Var _Ptr);
Procedure _CMLoadApp(Var Q:ContextMenu;Index:Word;Var Ptr);
Function  _RunMenuApp(Index:Word;Var Ptr):Word;
Procedure __CMInit(Var Q:ContextMenu);
Procedure __CMLoad(Var Q:ContextMenu;Const Path:String;Index:Word;Var _Ptr{:Array of Pointer});
Procedure __CreateError(Const FileName:String);
Procedure __DirectoryFull;
Procedure __DiskFull;
Function  __DiskNotReady(Disk:Byte):Word;
Procedure __FileAccessDenied;
Procedure __FileNotFound(Const FileName:String);
Function  __InputExit(Const Msg:String):Boolean;
Function  __InputOverwriteFile(Const FileName:String):Boolean;
Procedure __OutOfMemory;
Procedure __PathNotFound;
Procedure __TooManyOpenFiles;
Procedure __UnknownCompress;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                 IMPLEMENTATION
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses
 Adele,Memories,Systems,Video,Mouse,Dials,DialTree,
 ResLoadI,ResServI,SysPlus,ResTex,Math,Registry,
 Numerix,ResServD,ToolFile;

Function  SOSelect(Var Inf:SwitchOption):Word;Near;Forward;
Function  SOGetPos(Var Inf:SwitchOption):Byte;Near;Forward;
Procedure PutBoxRelief(Var G:GraphBoxRec);Near;Forward;
Procedure WEShowInput(Var W:Window;X1,Y,X2:Byte);Near;Forward;
Procedure WEShowInputText(Var W:Window;X1,Y,X2:Byte;Const S:String);Near;Forward;

Function MessageByLanguage(Const Raw:String):String;Near;
Var
 P:Byte;
Begin
 P:=Pos('³',Raw);
 If P=0Then MessageByLanguage:=Raw
  Else
 Begin
  If DefaultLanguage=0Then MessageByLanguage:=Left(Raw,P-1)
                      Else MessageByLanguage:=Copy(Raw,P+1,255)
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ·}
{³                 O b j e t  S e l e c t e  O                 º}
{ÔÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Construteur SOInit                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: SwitchOption
 Portabilit‚:  Global


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Ce constructeur initialise l'‚cran ainsi que les donn‚es de l'objet
 ®Selecte O¯ sans toutefois faire appel … une demande utilisateur. Il
 s'occupe  de pr‚parer  et non par  de faire prendre  des d‚cisions …
 l'utilisateur.
}

Procedure SOInit{Var Inf:SwitchOption;X,Y:Byte;Const Name,Option:String;YP:Byte};
Var
 I,ML,LL:Byte;
 OldShade:Boolean;
Begin
 FillClr(Inf,SizeOf(Inf));Inf.P:=YP;ML:=0;LL:=0;Inf.X:=X;Inf.Y:=Y;
 For I:=1to Length(Option)do If Option[I]='|'Then Begin
  If(LL>ML)Then ML:=LL;
  Inc(Inf.L);LL:=0
 End
  Else
 Inc(LL);
 If(LL>ML)Then ML:=LL;
 Inc(ML,2+5);
 SetBorderSimple;
 OldShade:=GetShade;
 SetShade(False);
 If ML<Length(Name)+3Then ML:=Length(Name)+3;
 ASM
  {Inf.X1:=X;Inf.Y1:=Y;Inf.X2:=X+ML;Inf.Y2:=Y+2+Inf.L;}
  {$IFDEF FLAT386}
   LEA EDX,Inf
   MOV AL,X
   MOV AH,Y
   MOV Word Ptr [EDX].SwitchOption.X1,AX
   ADD AL,ML
   ADD AH,[EDX].SwitchOption.L
   ADD AH,2
   MOV Word Ptr [EDX].SwitchOption.X2,AX
  {$ELSE}
   LES DI,Inf
   MOV AL,X
   MOV AH,Y
   MOV Word Ptr ES:[DI].SwitchOption.X1,AX
   ADD AL,ML
   ADD AH,ES:[DI].SwitchOption.L
   ADD AH,2
   MOV Word Ptr ES:[DI].SwitchOption.X2,AX
  {$ENDIF}
 END;
 PutFillBorder(X,Y,Inf.X2,Inf.Y2,GetLastKr);
 SetBorderSimpleLuxe;
 SetShade(OldShade);
 Inf.Tl:=' '+Name+' ';
 PutTxtXY(X+1,Y,Inf.Tl,GetKr);
 For I:=0to(Inf.L)do UnSelIcon(X+2,Y+1+I,GetLastKr);
 SelIcon(X+2,Y+1+Inf.P,GetLastKr);
 PutTypingXY(X+6,Y+1,Option)
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Fonction SOSelect                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: SwitchOption
 Portabilit‚:  Global


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet  de faire s‚lectionner  … l'utilisateur le choix
 d‚sirer dans fenˆtre de s‚lection. Elle retourne l'action effectuer par
 l'utilisateur si celui-ci ne correspond pas … un traŒtement r‚gulier de
 d‚placement  dans la fenˆtre.  Ainsi  le  code de touche  ®Enter¯  sera
 retourner  aussi bien  qu'un  code  de touche  classique  ®A¯ par cette
 fonction mais jamais les touches mont‚e et descendre.
}

Function SOSelect{Var Inf:SwitchOption):Word};
Label Break;
Var
 K,B:Word;
 M:TextCharRec;
 Data:TextBoxRec;

 Procedure UnSel;Begin
  UnSelIcon(Inf.X+2,Inf.Y+1+Inf.P,GetLastKr)
 End;

 Procedure Sel;Begin
  SelIcon(Inf.X+2,Inf.Y+1+Inf.P,GetLastKr);
  If(Pointer(@Inf.OnMove)<>NIL)Then Inf.OnMove(Inf.Context^);
 End;

 Procedure PutBorder;Begin
  __PutBorderUnKr(Inf.X1);
  PutTxtXY(Inf.X1+1,Inf.Y1,Inf.Tl,GetKr)
 End;

Begin
 SetBorderDouble;
 PutBorder;
 MoveLeft(Inf.X1,Data,SizeOf(Data));
 Inc(Data.Y1);
 Dec(Data.Y2);
 Repeat
  __ShowMousePtr;
  _InitKbd;
  Repeat
   __GetMouseTextSwitchZ(M,B);
   If B>0Then Begin
    __HideMousePtr;
    If WaitMouseBut0OrOutZone(Inf.X1)Then Begin
     K:=kbMouse;
     Goto Break;
    End
     Else
    Begin
     If Not WaitMouseBut0OrOutZone(Data)Then Begin
      Dec(M.Y,Inf.Y1+1);
      UnSel;
      Inf.P:=M.Y;
      Sel;
     End;
     __ShowMousePtr;
    End;
   End;
   _BackKbd;
   If(Pointer(@Inf.OnWait)<>NIL)Then Inf.OnWait(Inf.OnWaitContext^);
  Until KeyPress;
  K:=ReadKey;
  __HideMousePtr;
  Case(K)of
   kbUp,kbDn:Begin
    UnSel;
    Case(K)of
     kbUp:If Inf.P>0Then Dec(Inf.P)Else Inf.P:=Inf.L;
     Else If(Inf.P<Inf.L)Then Inc(Inf.P)Else Inf.P:=0;
    End;
    Sel
   End;
   Else Goto Break;
  End
 Until False;
Break:
 SetBorderSimple;
 PutBorder;
 SetBorderSimpleLuxe;
 SOSelect:=K
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Fonction SOGetPos                           Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: SwitchOption
 Portabilit‚:  Global


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de connaŒtre la position courante de la fenˆtre de
 s‚lection.   La premiŠre s‚lection retour 0,  la deuxiŠme 1,  et ainsi de
 suite,...
}

Function SOGetPos{Var Inf:SwitchOption):Byte};Assembler;ASM
 {$IFDEF FLAT386}
  LEA EAX,DWord Ptr Inf
  MOV AL,[EAX].SwitchOption.P
 {$ELSE}
  LES DI,Inf
  MOV AL,ES:[DI].SwitchOption.P
 {$ENDIF}
END;

Procedure Frame(Var R:ResourceWindow;Const Data);
Var
 Q:Record
  X1,Y1,X2,Y2:Byte;
  Title:String;
 End Absolute Data;
 OldShade:Boolean;
Begin
 SetBorderSimple;
 OldShade:=GetShade;
 SetShade(False);
 WESetKrBorder(R.W);
 PutFillBorder(WEGetRX1(R.W)+Q.X1,WEGetRY1(R.W)+Q.Y1,
               WEGetRX1(R.W)+Q.X2,WEGetRY1(R.W)+Q.Y2,R.W.CurrColor);
 SetBorderSimpleLuxe;
 SetShade(OldShade);
 If Q.Title<>''Then Begin
  WESetKrHigh(R.W);
  WEPutTxtXY(R.W,Q.X1+1,Q.Y1,' '+Q.Title+' ');
 End;
 WESetKrBorder(R.W);
End;

Procedure ErrMsgRes{Code:Word};Begin
 If Code>0Then ErrNoMsgOk(Code);
End;

Procedure LFChgPath(Var Q:FileListBox);Forward;

Procedure MakeModel(Var M:ArrayList;Model:Word);

 Function Add(Const Name,Ext:String;Code:Word):Boolean;
 Var
  R:MultiModel;
 Begin
  R.Name:=Name;R.Ext:=Ext;R.Code:=Code;
  Add:=ALAddBlock(M,SizeOf(MultiModel),R);
 End;

Begin
 ALInit(M);
 Add('Tous','*.*',cfoAll);
 If(Model and omAnim=omAnim)Then Add('Animation','*.3DS',cfo3DStudio);
 If(Model and omBase=omBase)Then Begin
  Add('Base de donn‚es DBase','*.DBF',cfoDBase);
  Add('Base de donn‚es Mentronix','*.DAT',cfoDBase);
 End;
 If(Model and omCoder=omCoder)Then Begin
  Add('Code Source AC','*.AC',cfoAC);
  Add('Code Source Ada','*.ADA',cfoAda);
  Add('Code Source Assembleur','*.ASM;*.ASO;*.INC;*.MAC',cfoAssembler);
  Add('Code Source Basic','*.BAS;*.FRM',cfoBasic);
  Add('Code Source C/C++','*.C;*.CAS;*.CC;*.CPP;*.H;*.HPP',cfoC);
  Add('Code Source Cobol','*.COB',cfoCobol);
  Add('Code Source Euphoria','*.E;*.EX',cfoEuphoria);
  Add('Code Source Fortran','*.FOR;*.F77',cfoFortran);
  Add('Code Source Logo','*.LGO',cfoLogo);
  Add('Code Source Pascal','*.PAS;*.INC;*.DPR',cfoPascal);
 End;
 If(Model and omCursor=omCursor)Then Add('Curseur Windows','*.CUR',cfoCursor);
 If(Model and omTechDraw=omTechDraw)Then Begin
  Add('Dessin ‚lectronique','*.IMI',cfoImi);
  Add('Dessin vectorielle','*.IMI',cfoImi);
  Add('DFD','*.IMI',cfoImi);
 End;
 If(Model and omDocument=omDocument)Then Begin
  Add('Document','*.GAT;*.DOC;*.RTF',cfoDocument);
  Add('Document GAT','*.GAT',cfoGAT);
  Add('Document HTML','*.HTM',cfoHTML);
  Add('Document Premier Choix','*.DOC',cfoFirstChoice);
 End;
 If(Model and omDraw=omDraw)Then Begin
  Add('Image BitMap de Windows','*.BMP',cfoBitMapWindows);
  Add('Image BitMap de OS/2','*.BMP',cfoBitMapOS2);
  Add('Image BitMap de Genesis','*.BGX',cfoBGX);
  Add('Image Corel Draws','*.CDR',cfoCorelDraw);
  Add('Image Corel Photo-Paint','*.CPT',cfoCorelPhotoPaint);
  Add('Image GEM/Ventura','*.IMG',cfoGEMImg);
  Add('Image GFX','*.GFX;*.SEX',cfoGFX);
  Add('Image GIF Compuserve','*.GIF',cfoGIF);
  Add('Image GPX','*.GPX',cfoGPX);
  Add('Image deLux Paint II','*.LBM;*.BBM',cfoLBM);
  Add('Image MacPaint','*.MAC',cfoMacPaint);
  Add('Image PCX de PC Paintbrush','*.PCX',cfoPCX);
  Add('Image PPM/PGM','*.PPM',cfoPPM);
  Add('Image SCi (RIX)','*.SCI',cfoSCi);
  Add('Image TIFF','*.TIF;*.CPT',cfoTIFF);
  Add('Image XBM de Unix','*.XBM',cfoXBM);
 End;
 If(Model and omConfig=omConfig)Then Add('Initialisation','*.INI',cfoIni);
 If(Model and omIcon=omIcon)Then Begin
  Add('Ic“ne','*.CUR;*.ICN;*.ICO',cfoIcon);
  Add('Ic“ne Genesis','*.ICN',cfoIcn);
  Add('Ic“ne OS/2','*.ICO',cfoIconOS2);
  Add('Ic“ne Windows','*.ICO;*.CUR',cfoIconWindows);
 End;
 If(Model and omMacro=omMacro)Then Begin
  Add('Macro','*.MAC',cfoMacro);
  Add('Menu Souris','*.MNU;*.DEF',cfoMouseMenu);
 End;
 If(Model and omFont=omFont)Then Begin
  Add('Police de caractŠres BIOS','*.FNT',cfoFNT);
  Add('Police de caractŠres QQF','*.QQF',cfoQQF);
 End;
 If(Model and omDocument=omDocument)Then Add('Professionnal Write','*.DOC',cfoProfessionnalWrite);
 If(Model)and(omResource or omDraw)>0Then Add('Ressource','*.RC;*.RES',cfoRes);
 If(Model and omSound=omSound)Then Begin
  Add('Son de format Voice','*.VOC',cfoVoice);
  Add('Son de format WAVE','*.WAV',cfoWave);
 End;
 If(Model and omCalc=omCalc)Then Begin
  Add('Tableur MGC','*.MGC',cfoMGC);
  Add('Tableur Lotus 1-2-3','*.WK1',cfoLotus123);
  Add('Tableur Excel Version 2.1','*.XLS',cfoExcel21);
  Add('Tableur CSV','*.CSV',cfoCSV);
  Add('Tableur HTML','*.HTM',cfoHTML);
  Add('Tableur liste ASCII','*.LST',cfoLST);
 End;
 If(Model and omDocument=omDocument)Then Begin
  Add('Texte ASCII DOS','*.ASC;*.TXT',cfoASCII);
  Add('Texte ASCII Unix','*.TXT',cfoTextUnix);
  Add('Texte ANSI','*.ANS',cfoANSI);
  Add('Texte mise en format (RTF)','*.RTF;*.DOC',cfoRTF);
 End;
End;

Function FLFormat{Const Q:FileListBox):Word};Begin
 If(Q.PMM=NIL)Then FLFormat:=0
              Else FLFormat:=Q.PMM^.Code;
End;

{ Cette fonction permet de retourner le type CFO (Cat‚gorie de fichier
 Optionnel) correspondant au nom de fichier indiqu‚e.
}

Function TypeCFO(Const Path:String):Word;
Var
 Ext:String;
Begin
 TypeCFO:=$FFFF;
 Ext:=Path2Ext(Path);
 If Ext<>''Then Begin
  If Pos(Ext,StrPas(ExtAC))>0Then TypeCFO:=cfoAC Else
  If Pos(Ext,'.ADA')>0Then TypeCFO:=cfoAda Else
  If Pos(Ext,StrPas(ExtAsm))>0Then TypeCFO:=cfoAssembler Else
  If Pos(Ext,StrPas(ExtBas))>0Then TypeCFO:=cfoBasic Else
  If Pos(Ext,'.BAT;.BTM')>0Then TypeCFO:=cfoBatch Else
  If Pos(Ext,'.DBF')>0Then TypeCFO:=cfoDBase Else
  If Pos(Ext,StrPas(ExtC))>0Then TypeCFO:=cfoC Else
  If(Length(Ext)>=4)and(Pos(Ext,'.CBL')>0)Then TypeCFO:=cfoCobol Else
  If Pos(Ext,StrPas(ExtEuphoria))>0Then TypeCFO:=cfoEuphoria Else
  If Pos(Ext,StrPas(ExtFortran))>0Then TypeCFO:=cfoFortran Else
  If Pos(Ext,'.GAT')>0Then TypeCFO:=cfoGat Else
  If Pos(Ext,'.INI')>0Then TypeCFO:=cfoIni Else
  If Pos(Ext,StrPas(ExtPas))>0Then TypeCFO:=cfoPascal Else
  If Pos(Ext,StrPas(ExtRC))>0Then TypeCFO:=cfoRes;
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure WaitRetrace2                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Portabilit‚: Local


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette routine fait simplement attendre 2 retour de balayage de l'‚cran.


  Remarque
  ÍÍÍÍÍÍÍÍ

   ş Elle est essentiellement utilis‚  afin d'‚conomiser  de la m‚moire et
     c'est la raison pour laquelle est a un statue local.
}

Procedure WaitRetrace2;Near;Begin
 WaitRetrace;WaitRetrace;
End;

Procedure FLInitComplexe(Var Q:FileListBox;Const Path:String;PreView,SettingDescr:Boolean;Var M:ArrayList);
Var
 I:Byte;
 J:Char;
Begin
 FillClr(Q,SizeOf(FileListBox));
 Q.ShowGlyphs:=(IsGrf)and(MediaSupport)and(NmXTxts>42);
 If(Q.ShowGlyphs)and(UseExtensior)Then ExtensiorInit(Q.ExtImg);
 Q.Tri:=fName;Q.UnixSupport:=True;
 Q.StartPath:=Path;
 Q.Path:=Path;
 If(Q.Path[1]in['*','?'])and(StrI(2,Q.Path)=':')Then For J:='C'to'Z'do Begin
  If DirExist(J+Copy(Q.Path,2,255))Then Begin
   Q.Path[1]:=J;
   Break;
  End;
 End;
 Q.M:=M;
 Q.PreView:=PreView;Q.SettingDescr:=SettingDescr;
 If(PreView)and(MediaSupport)Then Q.Length:=70
                             Else Q.Length:=41;
 Q.YD:=(Byte(M.Count>0)shl 1);Q.Height:=16;
 Inc(Q.Height,Q.YD);
 BFInit(Q.FileList);
 Q.FileList.Tri:=Q.Tri;
 Q.MaxCol:=1;
 For I:=0to(Q.MaxCol)do Begin
  Q.ColPos[I]:=(13+(Byte(Q.ShowGlyphs)shl 1))*I;
  Q.EndColPos[I]:=Q.ColPos[I]+11+(Byte(Q.ShowGlyphs)shl 1);
  If(Q.ShowGlyphs)Then Inc(Q.Length,2);
 End;
End;

Function FLInit(Var Q;X1,Y1,X2,Y2:Byte):Boolean;
Var
 M:ArrayList;
Begin
 FLInit:=False;
 ALInit(M);
 FLInitComplexe(FileListBox(Q),'*.*',False,False,M);
 WEInit(FileListBox(Q).W,X1,Y1,
        X1+FileListBox(Q).Length,
        Y1+FileListBox(Q).Height+Byte(DescrInFile));
 FileListBox(Q).W.Title:='Ouvre';
 FLRefresh(Q);
 LFChgPath(FileListBox(Q));
 FLInit:=True;
End;

Procedure FLInitNPropriety{Var Q:FileListBox;Const Path,Title:String;
                           Var H:History;Var M:RBuf;
                           PreView,SettingDescr,Push:Boolean};Begin
 FLInitComplexe(Q,Path,PreView,SettingDescr,M);
 WEInitO(Q.W,Q.Length,Q.Height+Byte(DescrInFile));
 If(Push)Then WEPushWn(Q.W);
 Q.W.Title:=Title;Q.H:=@H;
 FLRefresh(Q);
 LFChgPath(Q);
End;

Procedure FLInitModel{Var Q:FileListBox;Const Path,Title:String;
Var H:History;PreView,SettingDescr,Push:Boolean;Model:Word};
Var
 M:ArrayList;
Begin
 MakeModel(M,Model);
 FLInitNPropriety(Q,Path,Title,H,M,PreView,SettingDescr,Push);
End;

{ Cette fonction permet de connaŒtre le r‚pertoire courant o— se trouve
 actuellement la s‚lection du fichier.
}

Function FLDirectory{Const Q:FileListBox):String};Begin
 FLDirectory:=Q.Path;
End;

{ Cette fonction permet de connaŒtre l'unit‚ courante o— se trouve
 actuellement la s‚lection de fichier.
}

Function FLDrive{Const Q:FileListBox):Char};Begin
 FLDrive:=Path2Drv(Q.Path);
End;

{ Cette fonction permet de connaŒtre le masque actuellement en usage
 avec s‚paration par des points-virgules (exemple: ®*.INC;*.PAS¯).
}

Function FLMask{Const Q:FileListBox):String};Begin
 FLMask:=Path2NoDir(Q.Path);
End;

Function FLTitle(Var Q;Max:Byte):String;Begin
 FLTitle:=FileListBox(Q).W.Title;
End;

Procedure FLMove2(Var Q;X,Y:Byte);
Var
 QX:FileListBox Absolute Q;
 MX,MY:Byte;
Begin
 MX:=QX.W.T.X2-QX.W.T.X1;MY:=QX.W.T.Y2-QX.W.T.Y1;
 QX.W.T.X1:=X;QX.W.T.X2:=X+MX;
 QX.W.T.Y1:=Y;QX.W.T.Y2:=Y+MY;
 FLRefresh(Q);
End;

Procedure FLPutGlyphs(Var Q:FileListBox;X,Y,Kr:Byte;P:Word;Var Info:SearchRec);
Var
 S:String;
Begin
 If(Q.ShowGlyphs)Then Begin
  If(UseExtensior)and(Q.ExtAss<>NIL)and(Q.ExtAss^[P]>0)and(Q.ExtAss^[P]<>$FFFF)Then Begin
   If Info.Attr.Value and faDir=0Then S:=Path2Dir(Q.Path)+Info.Name
                                 Else S:=Info.Name;
   ExtensiorPutIcon(Q.ExtImg,(Q.RX1+X)shl 3,GetRawY(Q.RY1+Y),16,HeightChr,
                    Q.ExtAss^[P],Kr shr 4,S);
  End
   Else
  If(sfaDir)in(Info.Attr.Flags)Then Begin
   If(FolderIcon<>NIL)Then Begin
    RIPutImageScale(FolderIcon^,(Q.RX1+X)shl 3,GetRawY(Q.RY1+Y),
                    16,HeightChr,Kr shr 4);
   End;
  End
   Else
  If Pos(Info.Name,'.EXE;.COM;.CMD;.BAT;.BTM')>0Then
   DossierProgramIcon(Q.RX1+X,Q.RY1+Y,Kr)
  Else
   DossierDocumentIcon(Q.RX1+X,Q.RY1+Y,Kr);
 End;
End;

{Cette proc‚dure permet d'afficher le nom courant}

Procedure _LFPutName(Var Q:FileListBox;Y:Byte;P:Wd;uX:Byte;Var X:SearchRec);
Var
 Kr:Byte;
Begin
 BFGetFile(Q.FileList,P,X);
 Case(X.Attr.Value)of
  faDir:Kr:=CurrKrs.OpenWin.Env.Dir;
  Else Kr:=CurrKrs.OpenWin.Env.Input;
 End;
 Q.W.CurrColor:=Kr;
 FLPutGlyphs(Q,uX,3+Y,Kr,P,X);
 WEPutTxtXY(Q.W,uX+(Byte(Q.ShowGlyphs)shl 1),3+Y,SetFullName(X.Name));
End;

{Cette proc‚dure permet d'afficher un item dans la liste
 des noms de fichiers}

Procedure LFPutListAt(Var Q:FileListBox;_P:Word);
Var
 I:Word;
 X:SearchRec;
Begin
 If Not BFNoFile(Q.FileList)Then Begin
  For I:=0to 7do Begin
   If _P+I>BFMaxFiles(Q.FileList)Then Begin
    WEClrWn(Q.W,Q.ColPos[0],3+I,Q.EndColPos[0],3+7,CurrKrs.OpenWin.Env.Input);
    WEClrWn(Q.W,Q.ColPos[1],3,Q.EndColPos[1],3+7,CurrKrs.OpenWin.Env.Input);
    Exit
   End;
   _LFPutName(Q,I,Q.Position+I,Q.ColPos[0],X)
  End;
  For I:=0to 7do Begin
   If _P+I+8>BFMaxFiles(Q.FileList)Then Begin
    WEClrWn(Q.W,Q.ColPos[1],3+I,Q.EndColPos[1],3+7,CurrKrs.OpenWin.Env.Input);
    Exit
   End;
   _LFPutName(Q,I,Q.Position+I+8,Q.ColPos[1],X)
  End;
 End;
End;

Procedure FLUpdateModel(Var Q:FileListBox);
Var
 S:String;
Begin
 If Q.W.CurrColor=$8FThen WEShowInput(Q.W,0,13,37)
                     Else WEBarSpcHor(Q.W,0,13,37);
 Adele.UpIcon(Q.RX1+38-UpIconLen,Q.RY1+13,CurrKrs.OpenWin.Window.Icon);
 S:=Left(StrUSpc(Q.PMM^.Name+' ('+Q.PMM^.Ext+')',38-UpIconLen),38-UpIconLen);
 If Q.W.CurrColor=$8FThen WEShowInputText(Q.W,0,13,37-UpIconLen,S)
                     Else WEPutTxtXY(Q.W,0,13,S);
End;

 {Affiche la barre de s‚lection, d‚finition et de description}
Procedure LFPutBar(Var Q:FileListBox);
Var
 Info:SearchRec;
 S:String;
 PC:PChr;
 PQ:Record
  Fill:Array[1..17]of Chr;
  PC:PChr;
 End Absolute Info;
 Col,XC,YC:Byte;
Begin
 If Not BFNoFile(Q.FileList)Then Begin
  BFGetFile(Q.FileList,Q.Position+Q.YScreen,Info);
  If(Q.W.Palette.Border shr 4=0)and(BitsPerPixel=1)Then Q.W.CurrColor:=$F0 Else
  If(Q.W.Palette.Border shr 4=$F)Then Q.W.CurrColor:=$1F
                                 Else Q.W.CurrColor:=$F;
  Col:=Q.YScreen shr 3;XC:=Q.ColPos[Col];YC:=3+(Q.YScreen and 7);
  FLPutGlyphs(Q,XC,YC,Q.W.CurrColor,Q.Position+Q.YScreen,Info);
  If(Q.ShowGlyphs)Then Inc(XC,2);
  WEBarSelHor(Q.W,XC,YC,Q.EndColPos[Col]);
  If HeightChr>8Then WEBarSpcHorRelief(Q.W,XC,YC,Q.EndColPos[Col]);
  Q.W.CurrColor:=CurrKrs.OpenWin.Env.Input;
  WESetPos(Q.W,0,wnMax-Byte(DescrInFile));
  WEPutTxt(Q.W,SetFullName(Info.Name));
  If(Info.Attr.Value=faDir)Then S:='<Dossier>'
                           Else S:=Str2(Info.Size,9);
  WEPutTxt(Q.W,S);
  _WERight(Q.W);
  WEPutTxt(Q.W,TimeToStr(Info.Time));
  If(DescrInFile)Then Begin
   WELn(Q.W);
   WEPutPTxt(Q.W,PQ.PC);
   WEClrEol(Q.W)
  End;
   { Affiche l'image s'il y a un pr‚visualisateur }
  If(Q.PreView)Then Begin
   RIPreViewImage(Path2Dir(Q.Path)+Info.Name,Q.W,1,1,28 shl 3,GetRawY(13));
  End;
 End;
End;

{Cette proc‚dure permet d'afficher l'entr‚e du r‚pertoire}

Procedure LFPutInput(Var Q:FileListBox;Const Path:String);
Var
 Len:Byte;
Begin
 Len:=Succ(Q.EndColPos[Q.MaxCol])-UpIconLen;
 WEPutTxtXYU(Q.W,0,1,Left(StrUSpc(Path,Len),Len));
End;

Procedure FLUpDateAllData(Var Q:FileListBox);Begin
 LFPutListAt(Q,Q.Position);
 Q.W.CurrColor:=CurrKrs.OpenWin.Env.Input;
 WEPutTxtXY(Q.W,1,wnMax-1-Byte(DescrInFile),Q.Path);
 WEClrEol(Q.W);
 LFPutBar(Q);
 LFPutInput(Q,Q.Path);
End;

Procedure FLUpDateFormat(Var Q:FileListBox;Format:Word);
Var
 I:Word;
Begin
 If Q.M.Count>0Then Begin
  ALSetPtr(Q.M,0);
  Q.CurrModelPos:=0;
  If Q.M.Count>0Then For I:=0to Q.M.Count-1do Begin
   Q.PMM:=_ALGetCurrBuf(Q.M);
   If(Q.PMM^.Code=Format)Then Begin
    WESetKr(Q.W,$8F);
    FLUpDateModel(Q);
    Break;
   End;
   ALNext(Q.M);
   Inc(Q.CurrModelPos);
  End;
 End;
End;

Procedure FLRefresh(Var Q);
Var
 QX:FileListBox Absolute Q;
 Ext:ExtStr;
 I,XUpShadow:Word;
Begin
 XUpShadow:=Succ(QX.EndColPos[QX.MaxCol]);
 WEPutWn(QX.W,QX.W.Title,CurrKrs.OpenWin.Window);
 WECloseIcon(QX.W);
 WEBar(QX.W);
 QX.RX1:=WEGetRX1(QX.W);QX.RY1:=WEGetRY1(QX.W);
 QX.W.CurrColor:=CurrKrs.OpenWin.Env.Input;
 {WEBarSpcHorShade(QX.W,0,1,Pred(XUpShadow));}
 WEShowInput(QX.W,0,1,Pred(XUpShadow));
 Adele.UpIcon(QX.RX1+XUpShadow-UpIconLen,QX.RY1+1,CurrKrs.OpenWin.Window.Icon);
 For I:=0to(QX.MaxCol)do Begin
  WEClrWn(QX.W,QX.ColPos[I],3,QX.EndColPos[I],3+7,CurrKrs.OpenWin.Env.Input);
 End;
 QX.W.CurrColor:=QX.W.Palette.kShade;
 WESetCube(QX.W,XUpShadow,3,'Ü');
 BarTxtVer(QX.RX1+XUpShadow,QX.RY1+4,QX.RY1+11,'Û',QX.W.Palette.kShade);
 WEBarTxtHor(QX.W,1,12,XUpShadow,'ß');
 Adele.LeftIcon(QX.RX1,QX.RY1+11,CurrKrs.OpenWin.Window.Icon);
 If LeftIconLen=1Then BarTxtHor(QX.RX1+1,QX.RY1+11,QX.RX1+XUpShadow-2,'±',CurrKrs.OpenWin.Window.Icon)
  Else
 Begin
  QX.W.CurrColor:=(CurrKrs.OpenWin.Window.Icon shr 4)+((CurrKrs.OpenWin.Window.Icon and 7)shl 4);
  WEBarSpcHor(QX.W,LeftIconLen,11,XUpShadow-RightIconLen);
  WEBarSpcHorRelief(QX.W,LeftIconLen,11,Pred(XUpShadow)-RightIconLen)
 End;
 Adele.RightIcon(QX.RX1+XUpShadow-RightIconLen,QX.RY1+11,CurrKrs.OpenWin.Window.Icon);
 WEClrWn(QX.W,0,QX.Height-3,QX.Length-2,
         QX.Height-2+Byte(DescrInFile),CurrKrs.OpenWin.Env.Input);
 WEPutkHor(QX.W,XUpShadow+2,1,11,'Correcte');
 WEPutkHor(QX.W,XUpShadow+2,3,11,'D‚part');
 WEPutkHor(QX.W,XUpShadow+2,5,11,'Racine');
 WEPutkHor(QX.W,XUpShadow+2,7,11,'Cr‚e R‚p.');
 WEPutkHor(QX.W,XUpShadow+2,9,11,'Annule');
 QX.W.CurrColor:=CurrKrs.OpenWin.Env.Input;
  {Recherche d'un modŠle correspondant et l'affiche }
 If QX.M.Count>0Then Begin
  ALSetPtr(QX.M,0);
  Ext:=Path2Ext(QX.Path);QX.CurrModelPos:=0;
  For I:=0to QX.M.Count-1do Begin
   QX.PMM:=_ALGetCurrBuf(QX.M);
   If Pos(Ext,QX.PMM^.Ext)>0Then Begin
    WESetKr(QX.W,$8F);
    FLUpDateModel(QX);
    Break;
   End;
   ALNext(QX.M);
   Inc(QX.CurrModelPos);
  End;
 End;
 If(QX.NotFirstTime)Then FLUpDateAllData(QX);
 QX.NotFirstTime:=True;
End;

{Cette proc‚dure permet d'afficher l'item}
Procedure LFPutItem(Var Q:FileListBox);
Var
 X:SearchRec;
 Kr,y3:Byte;
Begin
 If Q.YScreen<=7Then y3:=0
                Else y3:=8;
 If Q.Position+Q.YScreen<=BFMaxFiles(Q.FileList)Then
  _LFPutName(Q,Q.YScreen-y3,Q.Position+Q.YScreen,Q.ColPos[Q.YScreen shr 3],X)
End;

Function Chk4New(Var Path:String):Boolean;
Var
 I:Byte;
 Option:Set of (Card,Point);
Begin
 Chk4New:=False;Option:=[];
 For I:=1to Length(Path)do Case Path[I]of
  '.':Include(Option,Point);
'*','?':Include(Option,Card);
  ';':Begin
   If Option=[Point]Then Begin
    {$IFDEF __Windows__}
     SetLength(Path,I-1);
    {$ELSE}
     Path[0]:=Chr(I-1);
    {$ENDIF}
    Chk4New:=True;
   End;
   Exit;
  End;
 End;
End;

{Change le r‚pertoire de recherche}
Procedure LFChgPath(Var Q:FileListBox);
Label Ok;
Var
 LW:Window;
 I:Char;
Begin
 WEPushEndBar(LW);
 WEPutLastBar('Lecture du r‚pertoire en cours...');
 Q.Position:=0;Q.YScreen:=0;
 If Q.Path=''Then Begin
  BFSelPathExt(Q.FileList,'*.*',faAll);
 End
  Else
 Begin
  If Not DirExist(Q.Path)Then Begin
    {Recherche du r‚pertoire autoris‚ sur plusieurs unit‚s? }
   If(Q.Path[1]in[':','\','/'])or((Q.Path[1]in['*','?'])and(Q.Path[2]=':'))Then Begin
    Case Q.Path[1]of
     ':':Q.Path:='?'+Q.Path;
     '\','/':Q.Path:='?:'+Q.Path;
    End;
    For I:='C'to 'Z'do Begin
     Q.Path[1]:=I;
     If DirExist(Q.Path)Then Begin
      Goto Ok;
     End;
    End;
   End;
   __PathNotFound;
   Q.Path:=GetCurrentDir;
  End;
Ok:
  Q.Path:=Systems.FileExpand(Q.Path);
  If Q.Path[Length(Q.Path)]='\'Then AddStr(Q.Path,'*.*');
  BFSelPathExt(Q.FileList,Q.Path,faAll);
 End;
 FreeMemory(Q.ExtAss,Q.ExtAssSize);
 If(Q.ShowGlyphs)and(UseExtensior)Then Begin
  Q.ExtAssSize:=Succ(BFMaxFiles(Q.FileList))shl 1;
  Q.ExtAss:=MemNew(Q.ExtAssSize);
  Q.ExtAssCurrPos:=0;
 End
  Else
 Begin
  Q.ExtAss:=NIL;Q.ExtAssSize:=0;
 End;
 FLUpDateAllData(Q);
 WEDone(LW)
End;

Var
 CurrFileListBox:^FileListBox;
 OldKbd:Procedure;

Procedure UpDateExtensior;Far;
Var
 X:SearchRec;
 P,Max:Word;
 S:String;
Begin
 OldKbd;
 Max:=BFMaxFiles(CurrFileListBox^.FileList);
 P:=CurrFileListBox^.ExtAssCurrPos;
 If(P<=Max)Then Begin
  If(CurrFileListBox^.ExtAss<>NIL)Then Begin
   BFGetFile(CurrFileListBox^.FileList,P,X);
   If(sfaDir)in(X.Attr.Flags)Then S:=X.Name
                             Else S:=Path2Dir(CurrFileListBox^.Path)+X.Name;
   CurrFileListBox^.ExtAss^[P]:=ExtensiorSearch(CurrFileListBox^.ExtImg,S,X.Attr.Value);
  End;
  Inc(CurrFileListBox^.ExtAssCurrPos);
 End
  Else
 If P=Max+1Then Begin
  FLUpDateAllData(CurrFileListBox^);
  Inc(CurrFileListBox^.ExtAssCurrPos);
 End;
End;

{Ex‚cute les commandes utilisateur}
Function FLRun(Var QX):Word;
Label Restart,Up,NoOther,BarSel,Wait2,ChgModel,Exit,Enter1,Delete1;
Const BufSize=255;
Var
 Q:FileListBox Absolute QX;
 K:Word;
 Ok:Boolean;
 Yx,XMs,YMs:Byte;
 Buffer:Array[0..BufSize]of Char;
 PBuffer:PChr;
 X:SearchRec;
 T:String;
 Ix:Byte;
 OldPath:String;
 EndCol:Byte;
 Refresh:Boolean; { Besoin de rafraichissement des fichiers? }

 Procedure MakeDirectory;
 Var
  kName:String;
 Begin
  kName:='';
  If(_WinInp(50,'Cr‚e R‚pertoire','Entrez le nom du r‚pertoire … cr‚er:',False,kName)=kbYes)Then Begin
   If(Pos('\',kName)or Pos(':',kName))=0Then kName:=Path2Dir(Q.Path)+kName;
   MkDir(kName);
   LFChgPath(Q);
  End;
 End;

 Procedure SelectFileFormat;
 Var
  LM:LstMnu;
  S:String;
 Begin
  LMInitKrDials(LM,Q.RX1,Q.RY1,Q.RX1+37,Q.RY1+12,'Format fichier');
  ALSetPtr(Q.M,0);
  Q.PMM:=_ALGetCurrBuf(Q.M);
  While(Q.PMM<>NIL)do Begin
   ALAddStr(LM.List,Q.PMM^.Name+' ('+Q.PMM^.Ext+')');
   ALNext(Q.M);
   Q.PMM:=_ALGetCurrBuf(Q.M);
  End;
  LMGotoPos(LM,Q.CurrModelPos);
  K:=LMRun(LM);
  Q.CurrModelPos:=LMGetVal(LM);
  LMDone(LM);
  {If(InputType<>itElvis)Then Begin
   S:=WEGetStr(Q.W,0,11);
   WEShowInput(Q.W,0,11,37);
   WEShowInputText(Q.W,0,11,37,S);
  End;}
 End;

  {Fixe la description courante}
 Procedure SetCurrDescr;
 Var
  Buffer:Array[Byte]of Char;
  PBuffer:PChr;
  K:Word;
  X:SearchRec;
  S:String;
 Begin
  BFGetFile(Q.FileList,Q.Position+Q.YScreen,X);
  WESetPos(Q.W,0,Q.Height-1);
  PBuffer:=@Buffer;
  FillClr(Buffer,SizeOf(Buffer));
  StrPCopy(@Buffer,SearchDescription(Path2Dir(Q.Path)+X.Name));
  Repeat
   K:=WEInp(Q.W,PBuffer,SizeOf(Buffer)-1,False);
   If(Q.SettingDescr)and(K=kbTab)Then Break;
   If(K=kbClose)Then Break;
   If(K=kbMouse)or(K=kbInWn)Then Begin
    WaitMouseBut0;
    Break;
   End;
  Until(K=kbEnter)or(K=kbEsc);
  If(K=kbEnter)Then Begin
   S:=StrPas(PBuffer);
   SetDescription(Path2Dir(Q.Path)+X.Name,S);
   BFSetDescription(Q.FileList,Q.Position+Q.YScreen,Str2PChr(S));
  End;
  WEPutPTxt(Q.W,PBuffer);
  WEClrEol(Q.W)
 End;

 {Affiche la barre de s‚lection}
 Procedure PutBarSel;
 Var
  X:Byte;
 Begin
  X:=Q.EndColPos[Q.MaxCol]+4;
  WEBarSelHor(Q.W,X,1+(Q.KB shl 1),X+8)
 End;

 {Effectue le d‚placement vers la gauche dans la fenˆtre de liste des fichiers}
 Procedure LeftWn;Begin
  LFPutItem(Q);
  If Q.YScreen<8Then Begin
   If Q.Position>7Then Begin
    Dec(Q.Position,8);
    LFPutListAt(Q,Q.Position)
   End;
  End
   Else
  Dec(Q.YScreen,8);
  LFPutBar(Q);
 End;

 {Effectue le d‚placement vers la droite dans la fenˆtre de liste des fichiers}
 Procedure RightWn;
 Var
  MF:Word;
 Begin
  LFPutItem(Q);
  MF:=BFMaxFiles(Q.FileList);
  If Q.YScreen>7Then Begin
   If(Q.Position+16<=MF)Then Begin
    Inc(Q.Position,8);
    If(Q.Position+Q.YScreen>MF)Then Q.YScreen:=(MF and 7)+8;
    LFPutListAt(Q,Q.Position)
   End
  End
   Else
  If(Q.Position+Q.YScreen+8<=MF)Then Inc(Q.YScreen,8);
  LFPutBar(Q)
 End;

 Procedure UnSetInp;
 Var
  S:String;
 Begin
  If(InputType<>itElvis)Then Begin
   S:=WEGetStr(Q.W,0,1);
   WEShowInput(Q.W,0,1,Q.EndColPos[Q.MaxCol]-UpIconLen);
   WEShowInputText(Q.W,0,1,Q.EndColPos[Q.MaxCol]-UpIconLen,S);
  End
   Else
  Begin
   WESetKr(Q.W,$8F);
   WEBarSelHor(Q.W,0,1,Q.EndColPos[Q.MaxCol]-UpIconLen)
  End;
 End;

 Procedure Init4Ext;
 Var
  I:Byte;
 Begin
  For I:=1to Length(OldPath)do If OldPath[I]=';'Then Begin
   AddStr(Q.Path,Copy(OldPath,I,255));
   Break
  End;
 End;

 Function InCol(X,Y:Byte):Boolean;
 Var
  I:Byte;
 Begin
  InCol:=False;
  If Not(Y in[3..11])Then System.Exit;
  For I:=0to(Q.MaxCol)do If(X>=Q.ColPos[I])and(X<=Q.EndColPos[I])Then Begin
   InCol:=True;
   System.Exit;
  End;
 End;

 Procedure UnselectKey;Begin
  If(kType>=ktElvis)Then Q.W.CurrColor:=CurrKrs.OpenWin.Window.Key
                    Else Q.W.CurrColor:=CurrKrs.OpenWin.Window.Border;
  If(kType=ktOS2Win)Then Q.W.CurrColor:=Q.W.CurrColor and$7F;
  PutBarSel;
 End;

 Procedure SelectKey;Begin
  If(kType>=ktElvis)Then Q.W.CurrColor:=CurrKrs.OpenWin.Window.kSel
                    Else Q.W.CurrColor:=CurrKrs.OpenWin.Window.High;
  If(kType=ktOS2Win)Then Q.W.CurrColor:=Q.W.CurrColor and$7F;
  PutBarSel;
 End;

Begin
 CurrFileListBox:=@Q;OldKbd:=_BackKbd;
 If(Q.ShowGlyphs)and(UseExtensior)Then _BackKbd:=UpDateExtensior;
 EndCol:=Q.EndColPos[Q.MaxCol];
Restart:
 FLRun:=kbNoKey;
 Case(Q.Box)of
  0:Begin
    { Panneau d'entr‚e de ligne }
   StrPCopy(@Buffer,Q.Path);PBuffer:=@Buffer;Ok:=False;
   If(InputType<>itElvis)Then WESetInpColors(Q.W,$8F,CurrKrs.Dialog.Window.Sel)
   Else WESetInpColors(Q.W,CurrKrs.OpenWin.Env.Input,CurrKrs.OpenWin.Env.Input);
   K:=_WEInput(Q.W,0,1,Q.EndColPos[Q.MaxCol]-UpIconLen,BufSize,PBuffer);
   Case(K)of
    kbInWn:Begin
     XMs:=LastMouseX-Q.RX1;YMs:=LastMouseY-Q.RY1;
     If(YMs=Q.Height-1)Then SetCurrDescr Else
     If InCol(XMs,YMs)Then Begin
      Q.Box:=1;Ok:=True;
     End
      Else
     If(XMs>=EndCol+3)and(YMs in[1,3,5,7,9])Then Begin
      Q.Box:=3;Ok:=True;
     End
      Else
     If(XMs>EndCol-UpIconLen)and(YMs=1)and(XMs<=EndCol)Then Begin
      WaitMouseBut0;
      Goto Up;
     End
      Else
     If(Q.M.Count>0)and(XMs>=0)and(YMs=13)and(XMs<=37)Then Begin
      Q.Box:=2;Ok:=True;
      WaitMouseBut0;
     End;
    End;
    kbUp:Begin
  Up:If(Q.H<>NIL)Then Begin
      HYQueue(Q.H^,StrPas(PBuffer));
      StrPCopy(PBuffer,HYChoice(Q.H^,Q.RX1+Q.W.MaxX-1,Q.RY1+1));
      If Not IsPChrEmpty(PBuffer)Then Q.Path:=StrPas(PBuffer);
     End;
     K:=kbNoKey;
    End;
    kbDn,kbTab:Begin
     Q.Box:=1;
     UnSetInp;
    End;
    kbEnter:Begin
     Q.Path:=StrPas(@Buffer);
     If(Q.UnixSupport)Then ChgChr(Q.Path,'/','\');
     If(Q.H<>NIL)Then HYQueue(Q.H^,Q.Path);
     OldPath:=Q.Path;
     If Chk4New(Q.Path)Then Begin
      FLRun:=kbEnter;
      Goto Exit;
     End;
     If IsWildCard(Q.Path)Then LFChgPath(Q)
      Else
     Begin
      Q.Path:=SetPath4AddFile(Q.Path);
      If DirExist(Q.Path+'*.*')Then Begin
       Init4Ext;
       LFChgPath(Q)
      End
       Else
      Begin
       BackStr(Q.Path);
       FLRun:=kbEnter;
       Goto Exit;
      End;
     End;
     Q.Box:=1;Ok:=True;
    End;
    kbEsc,kbClose:Begin
     FLRun:=kbClose;
     Goto Exit;
    End;
   End;
   If(Ok)Then Begin
    UnSetInp;
    Goto Restart;
   End;
  End;
  1:Repeat { Panneau de fichiers }
   Ok:=False;K:=WEReadk(Q.W);
   Case(K)of
    kbEsc,kbClose:Begin
     FLRun:=kbClose;
     Goto Exit;
    End;
    kbDel:Begin
     BFGetFile(Q.FileList,Q.Position+Q.YScreen,X);
     T:=Path2Dir(Q.Path)+X.Name;
     Goto Delete1;
    End;
    kbInWn:Begin
     XMs:=LastMouseX-Q.RX1;YMs:=LastMouseY-Q.RY1;
     If(YMs=Q.Height-1)Then SetCurrDescr Else
     For Ix:=0to 1do If(XMs>=Q.ColPos[Ix])and(YMs in[3..10])and(XMs<=Q.EndColPos[Ix])Then Begin
      Yx:=YMs-3;
      If Ix*8+Yx+Q.Position<=BFMaxFiles(Q.FileList)Then Begin
       If Q.YScreen<>Yx+Ix*8Then Begin
	LFPutItem(Q);
	Q.YScreen:=Ix*8+Yx;
	LFPutBar(Q);
	WaitMouseMove;
       End
	Else
       Begin
	WaitMouseMove;
        If LastMouseB=2Then Begin
         BFGetFile(Q.FileList,Q.Position+Q.YScreen,X);
         T:=Path2Dir(Q.Path)+X.Name;
         Case FileMenuContext(NIL,T,X,Refresh)of
          1:Goto Enter1;
          5:SetCurrDescr;
          6,10,11:ErrNoMsgOk(FunctionOutContext);
          7:Refresh:=RenameEntry(T,X);
          8:Delete1:Refresh:=KillFile(T,X);
          9:Refresh:=SetPropriety(T,X);
         End;
         If(Refresh)Then LFChgPath(Q);
        End
         Else
 Enter1:PushKey(kbEnter)
       End;
      End;
      Goto NoOther
     End;
     If(YMs=11)and(XMs>=0)and(XMs<LeftIconLen)Then Begin
      LeftWn;
      Goto Wait2;
     End
      Else
     If(YMs=11)and(XMs>=EndCol+1-RightIconLen)and(XMs<=EndCol)Then Begin
      ClrKbd;
      RightWn;
Wait2:WaitRetrace2;WaitRetrace2;WaitRetrace2;WaitRetrace2
     End
      Else
     If(XMs>=EndCol+3)and(YMs in[1,3,5,7,9])Then Begin
      Q.Box:=3;Ok:=True;
     End
      Else
     If(XMs>=0)and(YMs=1)and(XMs<=EndCol-UpIconLen)Then Begin
      Q.Box:=0;Ok:=True;
     End
      Else
     If(Q.M.Count>0)and(XMs>=0)and(YMs=13)and(XMs<=37)Then Begin
      Q.Box:=2;Ok:=True;
      WaitMouseBut0;
     End;
NoOther:End;
    kbEnter:Begin
     BFGetFile(Q.FileList,Q.Position+Q.YScreen,X);
     If(sfaDir)in(X.Attr.Flags)Then Begin
      OldPath:=Q.Path;
      T:=Path2NoDir(Q.Path);
      Q.Path:=SetPath4AddFile(Path2Dir(Q.Path)+X.Name);
      AddStr(Q.Path,T);
      Init4Ext;
      LFChgPath(Q);
      Goto Restart;
     End
      Else
     Begin
      Q.Path:=Path2Dir(Q.Path)+X.Name;
      FLRun:=kbEnter;
      If(Q.H<>NIL)Then HYQueue(Q.H^,Q.Path);
      Goto Exit;
     End
    End;
    kbTab:Begin
     Q.Box:=2;Ok:=True;
    End;
    kbCtrlUp:Begin
     Q.Box:=0;Ok:=True;
    End;
    kbLeft:LeftWn;
    kbRight:RightWn;
    kbUp:Begin
     LFPutItem(Q);
     If Q.YScreen=0Then Begin
      If Q.Position>7Then Begin
       If Q.Position>15Then Begin
        Q.YScreen:=15;
        Dec(Q.Position,16);
       End
        Else
       Begin
        Q.YScreen:=7;
        Q.Position:=0;
       End;
       LFPutListAt(Q,Q.Position)
      End;
     End
      Else
     Dec(Q.YScreen);
     LFPutBar(Q)
    End;
    kbDn:Begin
     LFPutItem(Q);
     If Q.YScreen=15Then Begin
      If Q.Position+16<=BFMaxFiles(Q.FileList)Then Begin
       Q.YScreen:=0;
       Inc(Q.Position,16);
       LFPutListAt(Q,Q.Position)
      End
     End
      Else
     If Q.Position+Q.YScreen<BFMaxFiles(Q.FileList)Then Inc(Q.YScreen);
     LFPutBar(Q)
    End;
    kbPgUp,kbCtrlPgUp:If Length(Path2Dir(Q.Path))>3Then Begin
     OldPath:=Q.Path;
     T:=Path2NoDir(Q.Path);
     Q.Path:=SetPath4AddFile(Path2Dir(Q.Path)+'..');
     AddStr(Q.Path,T);
     Init4Ext;
     LFChgPath(Q)
    End;
    Else Ok:=True;
   End
  Until Ok;
  2:If Q.M.Count>0Then Begin
   If(InputType=itElvis)Then Q.W.CurrColor:=CurrKrs.OpenWin.Env.Input
                        Else Q.W.CurrColor:=CurrKrs.Dialog.Window.Sel;
   Ok:=False;
   FLUpDateModel(Q);
   K:=WEReadk(Q.W);
   Case(K)of
    kbInWn:Begin
     XMs:=LastMouseX-Q.RX1;YMs:=LastMouseY-Q.RY1;
     If(YMs=Q.Height-1)Then SetCurrDescr Else
     If(XMs>=0)and(YMs=13)and(XMs<=37)Then Goto ChgModel Else
     If(XMs>=EndCol)and(YMs in[1,3,5,7,9])Then Begin
      Q.Box:=3;Ok:=True;
     End
      Else
     If InCol(XMs,YMs)Then Begin
      Q.Box:=1;Ok:=True;
     End
      Else
     If(XMs>=0)and(YMs=1)and(XMs<=EndCol-UpIconLen)Then Begin
      Q.Box:=0;Ok:=True;
     End
    End;
    kbShiftTab:Begin
     Q.Box:=1;Ok:=True;
    End;
    kbTab:Begin
     Q.Box:=3;Ok:=True;
    End;
    kbDn,kbUp,kbEnter:Begin
ChgModel:
     SelectFileFormat;
     If(K=kbEsc)Then Begin
      FLRun:=kbClose;
      Goto Exit;
     End;
     ALSetPtr(Q.M,Q.CurrModelPos);
     Q.PMM:=_ALGetCurrBuf(Q.M);
     Q.Path:=Path2Dir(Q.Path)+Q.PMM^.Ext;
     FLUpDateModel(Q);
     LFChgPath(Q);
     K:=kbNoKey;
    End;
    kbEsc,kbClose:Begin
     FLRun:=kbClose;
     Goto Exit;
    End;
   End;
   If(Ok)Then Begin
    Q.W.CurrColor:=$8F;
    FLUpDateModel(Q);
   End;
  End
   Else
  Inc(Q.Box);
  3:If(Q.SettingDescr)Then Begin
   SetCurrDescr;
   Inc(Q.Box);
  End
   Else
  Inc(Q.Box);
  4:Begin
BarSel:
   SelectKey;
   Repeat
    Ok:=False;K:=WEReadk(Q.W);
    Case(K)of
     kbInWn:Begin
      XMs:=LastMouseX-Q.RX1;YMs:=LastMouseY-Q.RY1;
      If(YMs=Q.Height-1)Then SetCurrDescr Else
      If(XMs>=EndCol+3)and(YMs in[1,3,5,7,9])Then Begin
       If Q.KB<>(YMs-1)shr 1Then Begin
        UnselectKey;
	Q.KB:=(YMs-1)shr 1;
        SelectKey;
	WaitMouseMove;
       End
	Else
       Begin
	WaitMouseMove;
	ClrKbd;
	PushKey(kbEnter)
       End;
      End
       Else
      If InCol(XMs,YMs)Then Begin
       Q.Box:=1;Ok:=True;
      End
       Else
      If(XMs>=0)and(YMs=1)and(XMs<=EndCol-UpIconLen)Then Begin
       Q.Box:=0;Ok:=True;
      End
       Else
      If(Q.M.Count>0)and(XMs>=0)and(YMs=13)and(XMs<=37)Then Begin
       Q.Box:=2;Ok:=True;
       WaitMouseBut0;
      End
     End;
     kbEsc,kbClose:Begin
      FLRun:=kbClose;
      Goto Exit;
     End;
     kbEnter:Case(Q.KB)of
      0:Begin
       BFGetFile(Q.FileList,Q.Position+Q.YScreen,X);
       If(sfaDir)in(X.Attr.Flags)Then Begin
	OldPath:=Q.Path;T:=Path2NoDir(Q.Path);
	Q.Path:=SetPath4AddFile(Path2Dir(Q.Path)+X.Name);
        AddStr(Q.Path,T);
	Init4Ext;
	LFChgPath(Q);
        K:=kbNoKey;
       End
	Else
       Begin
        Q.Path:=Path2Dir(Q.Path)+X.Name;
        FLRun:=kbEnter;
        Goto Exit;
       End;
      End;
      1,2:Begin
       If Q.KB=1Then Q.Path:=Q.StartPath
                Else Q.Path:=Path2Drv(Q.Path)+':\'+Path2NoDir(Q.Path);
       LFChgPath(Q);
       UnselectKey;
       Q.Box:=0;Q.KB:=0;Ok:=True
      End;
      3:MakeDirectory;
      4:Begin
       FLRun:=kbClose;
       Goto Exit;
      End;
     End;
     kbDn,kbTab:Begin
      UnselectKey;
      If Q.KB=4Then Begin
       If(K=kbTab)Then Begin
        Q.Box:=0;Ok:=True;
       End;
       Q.KB:=0
      End
       Else
      Inc(Q.KB);
      SelectKey;
     End;
     kbUp:Begin
      UnselectKey;
      Q.KB:=MinByte(Q.KB,4); { ASM DEC KB;AND KB,3;END;}
      Goto BarSel;
     End;
     Else Ok:=True;
    End
   Until Ok
  End;
 End;
 FLRun:=K;
Exit:
 _BackKbd:=OldKbd;
 ExtensiorDone(Q.ExtImg);
End;

{ Cette fonction permet de mettre … la boŒte de dialogue de s‚lection de
 fichier.
}

Function FLDone{Var Q):Word};Begin
 If(FileListBox(Q).ShowGlyphs)and(UseExtensior)Then
  ExtensiorDone(FileListBox(Q).ExtImg);
 FreeMemory(FileListBox(Q).ExtAss,FileListBox(Q).ExtAssSize);
 BFDone(FileListBox(Q).FileList);
 WEDone(FileListBox(Q).W);
 ALDone(FileListBox(Q).M);
 FLDone:=0;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Fonction OpenWin                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Portabilit‚: Global


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet la s‚lection d'un fichier par l'utilisateur en
 lui offrant la possibilit‚ de le rechercher partout sur les unit‚s de
 disque ratach‚ au systŠme d'exploitation.
}

Function OpenWin{Const Path,Title:String):String};
Var
 H:History;
Begin
 HYInit(H,0);
 OpenWin:=_OpenWin(Path,Title,H);
End;

Procedure WEMoveWn{Var Q:Wins};
Var
 Win:BoxRectRec;
 MB:Word;
 OrgX,OrgY,IY2,IX2,IY1,IX1:Integer;
 LX,LY,MX,MY,Y2,X2,Y1,X1,YM,XM:Byte;
 G:GraphBoxRec;
 WinX:ImgRec;
 TW:Pointer;
 TWSize:Word;
Begin
 __HideMousePtr;
 If _SaveBoxRect(Q.T.X1,Win)Then Begin
  MoveLeft(Q.T.X1,X1,4);
  If(IsGrf)Then __PutRect(Win.GX1,$C)
           Else PutBorderUnKr(X1,Y1,X1+Win.MaxXTexts,Y1+Win.MaxYTexts);
  __ShowMousePtr;
  If __GetMouseButton<>0Then Begin
   OrgX:=LastMouseX;
   OrgY:=LastMouseY;
   LX:=$FF;LY:=$FF;
   IX1:=X1;IY1:=Y1;XM:=Win.MaxXTexts;YM:=Win.MaxYTexts;
   Repeat
    __GetMouseTextSwitch(MX,MY,MB);
    If(MX<>LX)or(MY<>LY)Then Begin
     IX1:=X1-(OrgX-MX);IY1:=Y1-(OrgY-MY);IX2:=IX1+XM;IY2:=IY1+YM;
     If IX1<0Then Begin
      IX1:=0;IX2:=XM;
     End;
     If(IY1<=LnsMnu)Then Begin
      IY1:=LnsMnu+1;IY2:=IY1+YM;
     End;
     If(IX2>MaxXTxts)Then Begin
      IX1:=MaxXTxts-XM;
      IX2:=MaxXTxts;
     End;
     If(IY2>=MaxYTxts-Byte(HelpBar))Then Begin
      IY1:=MaxYTxts-Byte(HelpBar)-YM-1;
      IY2:=MaxYTxts-Byte(HelpBar)-1;
     End;
  {   MoveWord2Byte(IX1,Q.X1,4);}
     WaitRetrace;
     __HideMousePtr;
     _PutBoxRect(Win);
     ReSaveBoxRect(IX1,IY1,Win);
     If(IsGrf)Then __PutRect(Win.GX1,$C)
              Else PutBorderUnKr(IX1,IY1,IX2,IY2);
     __ShowMousePtr;
     LX:=MX;LY:=MY;
    End;
   Until MB=0;
  End;
  __HideMousePtr;
  PutBoxRect(IX1,IY1,Win);
  RestoreBoxRect(Win);
  If(IsGrf)Then Begin
   CoordTxt2Graph(X1,G);
   SaveImage(G.X1,G.Y1,G.X2,G.Y2,WinX)
  End
   Else
  Begin
   TWSize:=SizeBoxTxt(Q.T.X1,Q.T.Y1,Q.T.X2,Q.T.Y2);
   TW:=MemAlloc(TWSize);
   If(TW=NIL)Then Begin
    ShowMousePtr;
    Exit;
   End;
   CopyBoxTxt(Q.T.X1,Q.T.Y1,Q.T.X2,Q.T.Y2,TW^);
  End;
  WEPopWn(Q);
  MoveWord2Byte(IX1,Q.T.X1,4);
  WEPushWn(Q);
  If(IsGrf)Then Begin
   CoordTxt2Graph(Q.T.X1,G);
   PutImage(G.X1,G.Y1,G.X2,G.Y2,WinX);
   XFreeMem(WinX.X);
  End
   Else
  Begin
   PutBoxTxt(Q.T.X1,Q.T.Y1,Q.T.X2,Q.T.Y2,TW^);
   FreeMemory(TW,TWSize);
  End;
 End;
 __ShowMousePtr;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Fonction _OpenWin                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Portabilit‚: Global


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet la s‚lection d'un fichier par l'utilisateur en
 lui offrant la possibilit‚ de le rechercher partout sur les unit‚s de
 disque ratach‚ au systŠme d'exploitation.  Une  liste  historique est
 ‚galement offert afin  de permettre  …  l'utilisateur  de choisir  un
 ancien chemin s'il le d‚sir.
}

Function _OpenWinMultiModel{Const Path,Title:String;Var Q:History;Var M:RBuf;PreView,SettingDescr:Boolean):String};
Var
 LW:Window;
 QX:FileListBox;
Begin
 If Not(MediaSupport)Then PreView:=False;
 If Not(IsGrf)Then PreView:=False;
 FLInitComplexe(QX,Path,PreView,SettingDescr,M);
 QX.H:=@Q;
 WEInitO(QX.W,QX.Length,QX.Height+Byte(DescrInFile));
 WEPushWn(QX.W);
 QX.W.Title:=Title;
 FLRefresh(QX);
 WEPushEndBar(LW);
 WEPutLastBar('Entrez le r‚pertoire et le nom du fichier d‚sir‚...');
 LFChgPath(QX);
 Repeat
  Case FLRun(QX)of
   kbEnter:Begin
    _OpenWinMultiModel:=QX.Path;
    Break;
   End;
   kbClose,kbEsc:Begin
    _OpenWinMultiModel:='';
    Break;
   End;
  End;
 Until False;
 FLDone(QX);
 WEDone(LW);
End;{Fin d'®_OpenWin¯}

Function _OpenWin{Const Path,Title:String;Var Q:History):String};
Var
 M:ArrayList;
Begin
 ALInit(M);
 _OpenWin:=_OpenWinMultiModel(Path,Title,Q,M,False,False);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Fonction _OpenWinModel                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Portabilit‚: Global


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette  fonction  permet  d'ouvrir  une  boŒte de  dialogue  avec un style
 particulier de fichiers supporter par la base de donn‚e du ®Malte Genesis¯
 avec un historique sp‚cifique.  Elle est utilis‚e afin d'ouvrir un fichier
 de format ind‚fini par exemple.
}

Function _OpenWinModel{Const Path,Title:String;Var Q:History;Model:Word):String};
Var
 M:ArrayList;
Begin
 MakeModel(M,Model);
 _OpenWinModel:=_OpenWinMultiModel(Path,Title,Q,M,Model=omDraw,False);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Fonction _OpenWinAllModel                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Portabilit‚: Global


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet d'ouvrir un boŒte de dialogue avec tous les formats
 de fichiers  supporter  par la base  de donn‚e  du ®Malte Genesis¯ avec un
 historique sp‚cifique.  Elle est utilis‚e  afin  d'ouvrir  un  fichier  de
 format ind‚fini par exemple.
}

Function _OpenWinAllModel(Const Path,Title:String;Var Q:History):String;Begin
 _OpenWinAllModel:=_OpenWinModel(Path,Title,Q,omAll);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                      Fonction WinInpNmWord                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Portabilit‚: Global


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet … l'utilisateur d'entrer un nombre dans une
 fenˆtre de dialogue dans un intervalle sp‚cifi‚.
}

Function WinInpNmWord{L:Byte;Const Title,Msg:String;
                      Const Kr:MtxColors;Min,Max:Wd;Var Num:Wd):Wd};
Label Break;
Var
 K,N:Word;
 Err:Integer;
 I:Byte;
 S:String;
 Ok:Bool;
Begin
 WinInpNmWord:=kbEsc;
 If Num=0Then S:=''Else S:=WordToStr(Num);
 N:=Num;
 Repeat
  Ok:=True;K:=WinInp(L,Title,Msg,Kr,False,S);
  If(K=kbEsc)Then Exit;
  For I:=1to Length(S)do Begin
   If Not(S[I]in ArabicDigit)Then Begin
    Ok:=False;
    ErrNoMsgOk(InvalidNumber);
    Goto Break
   End;
  End;
Break:
  Val(S,N,Err);
  If(N<Min)or(N>Max)Then Begin
   Ok:=False;
   ErrMsgOk('Nombre en dehors de limite'+BasicStrW(Min)+' et'+BasicStrW(Max)+'!')
  End
 Until Ok;
 Num:=N;WinInpNmWord:=kbEnter
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                     Proc‚dure __CreateError                  Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Portabilit‚: Global


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'afficher un message d'erreur informant
 l'utilisateur de l'impossibilit‚ de cr‚er le fichier sp‚cifier.
}

Procedure __CreateError{Const FileName:String};Begin
 ErrMsgOk('Impossible de cr‚er le fichier: '+FileName+'!')
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                     Proc‚dure __DirectoryFull                Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Portabilit‚: Global


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'afficher un message d'erreur informant
 l'utilisateur que le r‚pertoire est plein.
}

Procedure __DirectoryFull;Begin
 ErrMsgOk('R‚pertoire est plein.')
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                     Proc‚dure __DiskFull                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Portabilit‚: Global


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'afficher un message d'erreur informant
 l'utilisateur que le disque est plein.
}

Procedure __DiskFull;Begin
 ErrMsgOk('Disque plein.')
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                     Fonction __DiskNotReady                  Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Portabilit‚: Global


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'afficher un message d'erreur informant
 l'utilisateur  que le disque sp‚cifi‚e n'est pas prˆt et demande
 … l'usager quel d‚cision doit ˆtre prise: R‚essayer ou Annuler.
}

Function __DiskNotReady{Disk:Byte):Word};Begin
 If Disk=0Then Disk:=GetDsk+1;
 __DiskNotReady:=ErrMsg('Disque '+Char(Disk+Byte('@'))+
 ': n''est pas prˆt! S.V.P. inser‚ une disquette dans le lecteur '+
 Char(Disk+Byte('@'))+'.',KeyRetry+KeyCancel)
End;


{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                    Proc‚dure __FileAccessDenied              Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Portabilit‚: Global


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette proc‚dure permet d'afficher un message d'erreur informant
  l'utilisateur que le fichier n'est pas accessible.
}

Procedure __FileAccessDenied;Begin
 ErrNoMsgOk(errAccessDenied)
End;

{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                    Proc‚dure __FileNotFound                  Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Portabilit‚: Global


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette proc‚dure permet d'afficher un message d'erreur informant
  l'utilisateur  que le    fichier    sp‚cifier   est   totalement
  introuvable sur le systŠme.
}

Procedure __FileNotFound{Const FileName:String};Begin
 ErrMsgOk('Fichier '+FileName+' introuvable!')
End;

{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                    Proc‚dure __InputExit                     Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Portabilit‚: Global


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette proc‚dure permet d'afficher un message d'erreur informant
  l'utilisateur  s'il souhaite  v‚ritablement quitter le programme
  et si le tampon d'impression  n'est pas vide il lui faire par de
  ce genre de problŠme.
}

Function __InputExit{Const Msg:String):Boolean};
{$IFNDEF NoSpooler}
 Var
  K:Word;
 {$ENDIF}
Begin
 {$IFNDEF NoSpooler}
  If Not(IsSpoolerEmpty)Then Begin
   ExitIfSpoolerIsEmpty:=True;
   K:=WarningMsgYesNo('Impression en arriŠre plan non termin‚! Impossible '+
    'de poursuivre cette op‚ration si vous quitter. Dois-je '+
    'poursuivre l''op‚ration de terminaison?');
   ExitIfSpoolerIsEmpty:=False;
   If(K=kbNo)Then Begin
    __InputExit:=False;
    Exit;
   End
  End;
 {$ENDIF}
 __InputExit:=InputMsg('Attention',Msg,KeyYes+KeyNo,
                       wfCircle+wiExit,CurrKrs.ErrorWin.Window)=kbYes
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Fonction __InputOverWriteFile                    Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Portabilit‚: Global


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette fonction demande  … l'utilisateur  s'il souhaite effacer le fichier
  d‚finit par la variable de param‚trage ®FileName¯. Cette fonction retourne
  True si l'usager est d'avis de l'‚craser et s'il retourne Faux c'est qu'il
  refuse la proposition.
}

Function __InputOverWriteFile{Const FileName:String):Boolean};Begin
 __InputOverWriteFile:=WarningMsgYesNo('Le fichier '+FileName+
                       ' existe! Dois-je le remplacer ?')=kbYes
End;

{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                     Proc‚dure __OutOfMemory                  Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Portabilit‚: Global


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette proc‚dure permet d'afficher un message d'erreur informant
  l'utilisateur que le systŠme manque de m‚moire.
}

Procedure __OutOfMemory;Begin
 ErrMsgOk('Manque de m‚moire')
End;

{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                     Proc‚dure __PathNotFound                 Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Portabilit‚: Global


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette proc‚dure permet d'afficher un message d'erreur informant
  l'utilisateur que le r‚pertoire est introuvable.
}

Procedure __PathNotFound;Begin
 ErrNoMsgOk(errPathNotFound)
End;

{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                    Proc‚dure __TooManyOpenFiles              Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Portabilit‚: Global


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette proc‚dure permet d'afficher un message d'erreur informant
  l'utilisateur qu'il y a trop de fichier ouvert simultan‚ment.
}

Procedure __TooManyOpenFiles;Begin
 ErrNoMsgOk(errTooManyOpenFile)
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                      Proc‚dure __UnknownCompress                Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Portabilit‚: Global


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure  permet d'afficher  un message  d'erreur informant
 l'utilisateur que la technique de compression est incompr‚hensible.
}

Procedure __UnknownCompress;Begin
 ErrNoMsgOk(errUnknownCompress)
End;

Procedure ExtensiorInit(Var Q:Extensior);
Var
 H:ExtensiorHeader;
Begin
 FillClr(Q,SizeOf(Q));
 Q.Handle:=FileOpen('SYS:EXTENSIO.DAT',fmDef);
 If(Q.Handle=errHdl)Then Begin
  Q.Handle:=FileCreate(SetPath4AddFile(StrPas(PathSystems))+'EXTENSIO.DAT');
  If(Q.Handle<>errHdl)Then Begin
   H.Signature:='Extensior - Base de donn‚e'#26;
   H.HomeData:=SizeOf(ExtensiorHeader);
   _SetAbsRec(Q.Handle,0,SizeOf(H),H);
  End;
 End;
End;

Procedure Conv2To1BitsKr(Const Source;Var Target;Length:Word);
Var
 I:Word;
 SourceWord:TWord Absolute Source;
 TargetByte:TByte Absolute Target;
Begin
 For I:=0to Length-1do Begin
  TargetByte[I]:=((Swap(SourceWord[I])and$8000)shr 8)+
                 ((Swap(SourceWord[I])and$2000)shr 7)+
                 ((Swap(SourceWord[I])and$0800)shr 6)+
                 ((Swap(SourceWord[I])and$0200)shr 5)+
                 ((Swap(SourceWord[I])and$0080)shr 4)+
                 ((Swap(SourceWord[I])and$0020)shr 3)+
                 ((Swap(SourceWord[I])and$0008)shr 2)+
                 ((Swap(SourceWord[I])and$0002)shr 1);
 End;
End;

Procedure ExtensiorAdd(Var Q:Extensior;Const Name,Image,WildCard,Execute:String;Attr:Word);
Var
 Buffer:Array[0..1023]of Char;
 Res:ImageHeaderRes Absolute Buffer;
 Img:XInf;
 FS,Size:LongInt;
 I,ND,NM,PosIcon:Word;
 H:ExtensiorHeader;
 TBuf:^TByte;
 HR:Record
  Size,Reference,Attr:Word;
 End Absolute Buffer;
Begin
 PosIcon:=0;
 If(RILoadImage(Image,diAutoDetect,4,$FFFF,rmAllRes,[],Img)=eriNone)Then Begin
   { D‚placement des indexs s'il y en au moins 1 }
  FS:=FileSize(Q.Handle);
  _GetAbsRec(Q.Handle,0,SizeOf(H),H);
  If FS>SizeOf(ExtensiorHeader)Then Begin
   If(FS>H.HomeData)Then Begin
    _InsRec(Q.Handle,H.HomeData,160,SizeOf(Buffer),Buffer);
   End;
  End;
  XGetAbsRec(Img,0,SizeOf(Buffer),Buffer);
  If Res.NumXPixels>16Then Begin
   Size:=Res.NumXPixels*Res.NumYPixels;
   If LongRec(Size).Hi=0Then Begin
    TBuf:=MemAlloc(Size);
    If(TBuf<>NIL)Then Begin
     XGetAbsRec(Img,SizeOf(ImageHeaderRes),Size shr 1,TBuf^[Size shr 1]);
     Conv4To8BitsKr(TBuf^[Size shr 1],TBuf^,Size);
     ScaleSmall8Bits(TBuf^,Buffer[SizeOf(Res)],Res.NumXPixels,
                     Res.NumYPixels,16,16);
     Conv8To4BitsKr(Buffer[SizeOf(Res)],Buffer[SizeOf(Res)],128);
     If(Res.NumXPixels=32)and(Res.NumYPixels=32)and(Res.Shadow)Then Begin
      XGetAbsRec(Img,SizeOf(ImageHeaderRes)+Long(Res.NumYPixels)*Long(Res.BytesPerLine)+
                    Long(Res.NumPal*3),Res.NumYPixels*(Res.NumXPixels shr 3),TBuf^);
      NM:=0;ND:=0;
      If Res.NumYPixels=32Then For I:=0to Res.NumYPixels shr 1do Begin
       MoveLeft(TBuf^[NM],TBuf^[ND],4);
       Inc(NM,8);Inc(ND,4);
      End;
      Conv2To1BitsKr(TBuf^,Buffer[SizeOf(Res)+128],(Res.NumXPixels shr 5)*Res.NumYPixels);
     End
      Else
     Res.Shadow:=False;
     FreeMemory(TBuf,Size);
    End;
   End;
  End
   Else
  If(Res.NumPal>0)and(Res.Shadow)Then Begin
   MoveLeft(Buffer[SizeOf(Res)+Res.NumPal*3+128],Buffer[SizeOf(Res)+128],32);
  End;
  If Not(Res.Shadow)Then FillClr(Buffer[SizeOf(Res)+128],32);
  _SetAbsRec(Q.Handle,H.HomeData,160,Buffer[SizeOf(Res)]);
  PosIcon:=(H.HomeData-SizeOf(H))div 160;
  Inc(H.HomeData,160);
  _SetAbsRec(Q.Handle,0,SizeOf(H),H);
  NM:=6;
  MoveLeft(WildCard,Buffer[NM],Succ(Length(WildCard)));
  Inc(NM,Succ(Length(WildCard)));
  MoveLeft(Name,Buffer[NM],Succ(Length(Name)));
  Inc(NM,Succ(Length(Name)));
  MoveLeft(Execute,Buffer[NM],Succ(Length(Execute)));
  Inc(NM,Succ(Length(Execute)));
  HR.Size:=NM;
  HR.Reference:=PosIcon;
  HR.Attr:=Attr;
  _SetAbsRec(Q.Handle,FileSize(Q.Handle),NM,Buffer);
  XFreeMem(Img);
 End;
End;

Type
 PExtensior=Record
  Size:Word;       { Taille d'extensior }
  Reference:Word;  { R‚f‚rence d'image }
  Attr:Word;       { Attribut associ‚e l'extension }
  WildCard:String; { G‚n‚rique associ‚ }
 End;

Function ExtensiorNumIcon(Var Q:Extensior):Word;
Var
 H:ExtensiorHeader;
Begin
 _GetAbsRec(Q.Handle,0,SizeOf(H),H);
 ExtensiorNumIcon:=(H.HomeData-SizeOf(H))div 160;
End;

Procedure ExtensiorDone(Var Q:Extensior);Begin
 FileClose(Q.Handle);
End;

Type
 ExtensiorEditorRec=Record
  ExtImg:Extensior;   { L'Extensior utilis‚ }
  NumIcon:Word;       { Nombre d'ic“ne }
  AssPos:^TLong;      { Position de l'association }
  SizeAssPos:Word;    { Taille des positions d'association }
  LM:^LstMnu;         { Liste de dialogue }
  W:^Window;          { Fenˆtre de dialogue pour le traŒtement }
  Data:Record
   FileType:MListBox;
   New:MButton;
   Del:MButton;
   Setting:MButton;
   Extern:MExtern;
  End;
 End;

Procedure ExtensiorEditorPutIcon(X,Y:Byte;P:Word;Var Context);
Var
 Q:ExtensiorEditorRec Absolute Context;
Begin
 ExtensiorPutIcon(Q.ExtImg,X shl 3,GetRawY(Y),16,HeightChr,P,Q.LM^.W.CurrColor shr 4,'');
End;

Procedure ExtensiorEditorOnMove(Var Context);
Var
 Q:ExtensiorEditorRec Absolute Context;
 Buffer:Array[0..2047]of Char;
 PExt:PExtensior Absolute Buffer;
 S:^String;
 Size:Byte;
Begin
 Size:=Q.W^.MaxX-17;
 _GetAbsRec(Q.ExtImg.Handle,Q.AssPos^[Q.LM^.P],SizeOf(Buffer),Buffer);
 WEPutTxtXY(Q.W^,16,11,Left(StrUSpc(PExt.WildCard,Size),Size));
 S:=@Buffer[Byte(Buffer[7+Length(PExt.WildCard)])+8+Length(PExt.WildCard)];
 WEPutTxtXY(Q.W^,16,13,Left(StrUSpc(S^,Size),Size));
End;

Procedure EWOnPress(Var R:ResourceWindow;Var Context);
Var
 S:String Absolute Context;
Begin
 S:=OpenWin(S,'Choisir l''ic“ne');
End;

Function FindActionExtensior(Const Name:String;Var Action:String):Boolean;
Label Xit;
Var
 H:ExtensiorHeader;
 PExt:^PExtensior;
 FS:Long;
 Q:Extensior;
 PB,PosIcon:Word;
 Buffer:Array[0..2047]of Char;
 S:String;
 SP:^String;
 PPExt:^PExtensior Absolute Buffer;
Begin
 FindActionExtensior:=False;
 ExtensiorInit(Q);
 FS:=FileSize(Q.Handle);
 If FS<=SizeOf(H)Then Exit;
 _GetAbsRec(Q.Handle,0,SizeOf(H),H);
 PosIcon:=0;S:=Path2NoDir(Name);
 While(H.HomeData<=FS)do Begin
  _GetAbsRec(Q.Handle,H.HomeData,SizeOf(Buffer),Buffer);
  Inc(H.HomeData,Long(SizeOf(Buffer)));
  PB:=0;
  Repeat
   PExt:=@Buffer[PB];
   If PExt^.Size=0Then Break;
   If PExt^.Size>=SizeOf(Buffer)Then Break;
   If PB+PExt^.Size>=SizeOf(Buffer)Then Begin
    Dec(H.HomeData,Long(SizeOf(Buffer)-PB));
    Break;
   End;
   If(PExt^.Attr and faDir=0)and(WildCardMatch(S,PExt^.WildCard))Then Begin
    SP:=@Buffer[7+Length(PPExt^.WildCard)];
    SP:=@Buffer[Byte(Buffer[7+Length(PPExt^.WildCard)])+8+Length(PPExt^.WildCard)];
    Action:=SP^;
    FindActionExtensior:=True;
    Goto Xit;
   End;
   Inc(PosIcon);
   Inc(PB,PExt^.Size);
  Until PB>=SizeOf(Buffer);
 End;
Xit:
 ExtensiorDone(Q);
End;

Const
 ewModified=0; { Modification }
 ewAdd=1;      { Ajouter d'un nouveau }
 ewAddName=2;  { Ajout … partir d'un nom }

Procedure ExtensiorWin(Mode:Byte;Var Q:ExtensiorEditorRec;Const SuggestName:String);
Type
 DataRec=Record
  New:Boolean;
  Name:String;
  WildCard:String;
  Execute:String;
  TB:Array[0..4]of Boolean;
  Button:MButton;
End;
Var
 Data:^DataRec;
 Image:String;
 Attr:Word;

 Procedure ExtensiorRead;
 Var
  Buffer:Array[0..2047]of Char;
  PExt:PExtensior Absolute Buffer;
  S:^String;
 Begin
  _GetAbsRec(Q.ExtImg.Handle,Q.AssPos^[Q.LM^.P],SizeOf(Buffer),Buffer);
  Attr:=PExt.Attr;Data^.WildCard:=PExt.WildCard;
  S:=@Buffer[7+Length(PExt.WildCard)];
  Data^.Name:=S^;
  S:=@Buffer[Byte(Buffer[7+Length(PExt.WildCard)])+8+Length(PExt.WildCard)];
  Data^.Execute:=S^;
 End;

Begin
 Data:=MemNew(SizeOf(DataRec));
 If(Data=NIL)Then __OutOfMemory
  Else
 Begin
  Data^.Button.OnPress:=EWOnPress;Data^.Button.Context:=@Image;
  If Not(Mode in[ewAdd,ewAddName])Then ExtensiorRead
   Else
  Begin
   Image:='';Attr:=0;
   If(Mode=ewAddName)Then Data^.WildCard:=SuggestName;
  End;
  Data^.TB[0]:=Attr and faReadOnly=faReadOnly;
  Data^.TB[1]:=Attr and faHidden=faHidden;
  Data^.TB[2]:=Attr and faSysFile=faSysFile;
  Data^.TB[3]:=Attr and faArchive=faArchive;
  Data^.TB[4]:=Attr and faDir=faDir;
  If(Mode in[ewAdd,ewAddName])Then Begin
   Data^.New:=True;
   If ExecuteAppDPU(23,Data^)Then Begin
    Attr:=Byte(Data^.TB[0])*faReadOnly+
          Byte(Data^.TB[1])*faHidden+
          Byte(Data^.TB[2])*faSysFile+
          Byte(Data^.TB[3])*faArchive+
          Byte(Data^.TB[4])*faDir;
    ExtensiorAdd(Q.ExtImg,Data^.Name,Image,Data^.WildCard,Data^.Execute,Attr);
   End;
  End
   Else
  If ExecuteAppDPU(23,Data^)Then Begin
   Attr:=Byte(Data^.TB[0])*faReadOnly+
         Byte(Data^.TB[1])*faHidden+
         Byte(Data^.TB[2])*faSysFile+
         Byte(Data^.TB[3])*faArchive+
         Byte(Data^.TB[4])*faDir;
   { Routine permettant de modifier...}
  End;
  FreeMemory(Data,SizeOf(DataRec));
 End;
End;

Procedure WinAddExtensior(Const Name:String);
Var
 Q:ExtensiorEditorRec;
Begin
 FillClr(Q,SizeOf(Q));
 ExtensiorInit(Q.ExtImg);
 ExtensiorWin(ewAddName,Q,Name);
 ExtensiorDone(Q.ExtImg);
End;

Procedure ExternalExtEdt(Var R:ResourceWindow;Var Context);
Var
 Q:ExtensiorEditorRec Absolute Context;
Begin
 WESetKr(R.W,$8F);
 WEBarSpcHorShade(R.W,16,11,wnMax-1);
 WEBarSpcHorShade(R.W,16,13,wnMax-1);
 Q.W:=@R.W;
End;

Procedure LoadExtEdt(Var L:LstMnu;Var Context);
Var
 Buffer:Array[0..2047]of Char;
 PExt:^PExtensior;
 S:^String;
 FS:LongInt;
 Q:ExtensiorEditorRec Absolute Context;
 H:ExtensiorHeader;
 PosIcon,PB:Word;
Begin
 L.Context:=@Q;
 L.IconRoutine:=ExtensiorEditorPutIcon;
 L.OnMove:=ExtensiorEditorOnMove;
 L.Space4Icon:=2;
 Q.LM:=@L;
 FS:=FileSize(Q.ExtImg.Handle);
 If FS<=SizeOf(H)Then Exit;
 _GetAbsRec(Q.ExtImg.Handle,0,SizeOf(H),H);
 PosIcon:=0;
 While(H.HomeData<=FS)do Begin
  _GetAbsRec(Q.ExtImg.Handle,H.HomeData,SizeOf(Buffer),Buffer);
  Inc(H.HomeData,Long(SizeOf(Buffer)));
  PB:=0;
  Repeat
   PExt:=@Buffer[PB];
   If PExt^.Size=0Then Break;
   If PExt^.Size>=SizeOf(Buffer)Then Break;
   If PB+PExt^.Size>=SizeOf(Buffer)Then Begin
    Dec(H.HomeData,Long(SizeOf(Buffer)-PB));
    Break;
   End;
   S:=@Buffer[PB+7+Length(PExt^.WildCard)];
   ALAddStr(L.List,S^);
   Q.AssPos^[PosIcon]:=H.HomeData-SizeOf(Buffer)+Long(PB);
   Inc(PosIcon);
   Inc(PB,PExt^.Size);
  Until PB>=SizeOf(Buffer);
 End;
End;

Procedure NewEdtExtOnPress(Var R:ResourceWindow;Var Context);
Var
 Q:ExtensiorEditorRec Absolute Context;
Begin
 ExtensiorWin(ewAdd,Q,'');
End;

Procedure DelEdtExtOnPress(Var R:ResourceWindow;Var Context);Begin
End;

Procedure SettingEdtExtOnPress(Var R:ResourceWindow;Var Context);
Var
 Q:ExtensiorEditorRec Absolute Context;
Begin
 ExtensiorWin(ewModified,Q,'');
End;

Procedure ExtensiorEditor;
Var
 Q:ExtensiorEditorRec;
Begin
 FillClr(Q,SizeOf(Q));
 ExtensiorInit(Q.ExtImg);
 Q.NumIcon:=ExtensiorNumIcon(Q.ExtImg);
 If Q.NumIcon>0Then Begin
  Q.SizeAssPos:=Q.NumIcon shl 2;
  Q.AssPos:=MemNew(Q.SizeAssPos);
 End;
 Q.Data.Extern.Call:=ExternalExtEdt;
 Q.Data.Extern.Context:=@Q;
 Q.Data.FileType.Context:=@Q;
 Q.Data.FileType.LoadList:=LoadExtEdt;
 Q.Data.New.OnPress:=NewEdtExtOnPress;
 Q.Data.New.Context:=@Q;
 Q.Data.Del.OnPress:=DelEdtExtOnPress;
 Q.Data.Setting.OnPress:=SettingEdtExtOnPress;
 Q.Data.Setting.Context:=@Q;
 ExecuteAppDPU(78,Q.Data);
 ExtensiorDone(Q.ExtImg);
End;

Procedure __CMInit(Var Q:ContextMenu);Begin
 FillClr(Q,SizeOf(Q));
 Q.OldMnu:=MainMenu;
 Q.MaxSubMenu:=-1;
 PMInit;
 PMAddMnu('');
End;

Procedure __CMLoad(Var Q:ContextMenu;Const Path:String;Index:Word;Var _Ptr{:Array of Pointer});
Label Finish;
Var
{ ParentPos:Byte;
 CurrParentPos:Byte;}
 I,L1,L2,J:Word;
 Msg1,Msg2:PChr;
 WP,WP2:^Word;
 WPR:Word;
 CodeGroup:Word;                { Code du groupe }
 ID:Byte;
 TB:Boolean;
 IfPos:Byte;
 IfCase:Array[0..255]of Boolean;{ Dans un cas Si}
{ ParentMenu:Array[0..15]of Byte;}
{ Ptr:TPointer Absolute _Ptr;}
 Ptr:Pointer;
 Group:Boolean;                 { Dans un groupe? }
 PSG1,PSG2:PChar;               { Nom et descriptions du groupe }
 Len:Word;                      { Longueur de chaŒne de caractŠres }

 Function IsTrue:Boolean;
 Var
  I:Integer;
 Begin
  IsTrue:=False;
  If IfPos>0Then Begin
   For I:=0to IfPos-1do If Not IfCase[I]Then Exit;
  End;
  IsTrue:=IfCase[IfPos];
 End;

Begin
{ __CMInit(Q);}
 Q.Data:=AllocFunc(Index,Path,Q.Size);
 If(Q.Data<>NIL)Then Begin
{  FillClr(ParentMenu,SizeOf(ParentMenu));
  ParentPos:=0;
  CurrParentPos:=0;}
  I:=0;J:=0;IfPos:=0;IfCase[0]:=True;Group:=False;
  Repeat
   ID:=Q.Data^[I];
   Case(ID)of
    9:Begin
     Inc(I);
     If IfPos>0Then Dec(IfPos);
    End;
    8:Begin
     Inc(I);
     IfCase[IfPos]:=Not IfCase[IfPos];
    End;
    7:Begin
     Inc(I);Inc(IfPos);
     ASM
      {$IFDEF FLAT386}
       LEA EAX,_Ptr
       MOVZX ECX,J
       ADD EAX,ECX
       MOV AL,[EAX]
       MOV TB,AL
      {$ELSE}
       LES DI,_Ptr
       ADD DI,J
       MOV AL,ES:[DI]
       MOV TB,AL
      {$ENDIF}
     END;
     IfCase[IfPos]:=TB;
     ASM
      INC Word Ptr _Ptr;
     END;
    End;
    6:Begin
     Inc(I);
     If(IsTrue)Then Begin
      {Dec(ParentPos);
      If ParentPos>0Then Begin
       {SMAddFullItem(Q.SubMenu[ParentMenu[ParentPos-1]],PSG1,kbNoKey,CodeGroup,Q.SubMenu[ParentMenu[ParentPos]].Ptr,PSG2);}
       {CurrParentPos:=ParentMenu[ParentPos];
       ParentMenu[ParentPos]:=0;
      End
       Else
      Begin}
       PMAddFullItem(PSG1,kbNoKey,CodeGroup,Q.SubMenu[Q.MaxSubMenu].Ptr,PSG2);
       {CurrParentPos:=0;}
       Group:=False;
      {End;}
     End;
    End;
    5,$15:Begin
     CodeGroup:=0;
     Inc(I);
     If ID=$15Then Begin
      WP:=@Q.Data^[I];
      Inc(I,2);
      CodeGroup:=WP^;
     End;
     PSG1:=@Q.Data^[I];
     Len:=StrLen(PChr(PSG1));
     Inc(I,Len+1);
     PSG2:=@Q.Data^[I];
     Len:=StrLen(PChr(PSG2));
     Inc(I,Len+1);
     If(IsTrue)Then Begin
      Group:=True;
      {ParentMenu[ParentPos]:=Q.MaxSubMenu;}
      Inc(Q.MaxSubMenu);
      {CurrParentPos:=Q.MaxSubMenu;
      Inc(ParentPos);}

      {SMAddBarItem(Q.SubMenu[CurrParentPos]);
      If ParentPos>1Then Begin
       SMAddFullItem(Q.SubMenu[ParentMenu[ParentPos]],PSG1,kbNoKey,CodeGroup,Q.SubMenu[CurrParentPos].Ptr,PSG2);
      End
       Else
      Begin
       PMAddFullItem(PSG1,kbNoKey,CodeGroup,Q.SubMenu[Q.MaxSubMenu].Ptr,PSG2);
      End;}
     End;
    End;
    4:Begin
     Inc(I);
     WP:=@Q.Data^[I];Inc(I,2);
     WP2:=@Q.Data^[I];WPR:=WP2^;
     Goto Finish;
    End;
    3,2:Begin
     WPR:=0;
     Inc(I);WP:=@Q.Data^[I];
Finish:
     Inc(I,2);Msg1:=@Q.Data^[I];
     L1:=StrLen(Msg1);
     Inc(I,L1+1);
     Msg2:=@Q.Data^[I];
     L2:=StrLen(Msg2);
     Inc(I,L2+1);
     If ID=3Then Begin
      If(IsTrue)Then Begin
       ASM
        {$IFDEF FLAT386}
         LEA EAX,_Ptr
         MOVZX ECX,J
         ADD EAX,ECX
         MOV EAX,[EAX]
         MOV &Ptr,EAX
        {$ELSE}
         LES DI,_Ptr
         ADD DI,J
         LES AX,ES:[DI]
         MOV Word Ptr &Ptr[0],AX
         MOV Word Ptr &Ptr[2],ES
        {$ENDIF}
       END;
       PMAddItemSwitch(Msg1^,Pointer(Ptr^),Pointer(Msg2),WP^);
      End;
      Inc(J,4);
     End
      Else
     If(IsTrue)Then Begin
      If(Group)Then SMAddFullItem(Q.SubMenu[Q.MaxSubMenu{CurrParentPos}],Msg1^,WPR,WP^,NIL,Msg2^)
               Else PMAddItemKey(Msg1^,WPR,WP^,Msg2^);
     End;
    End;
    1:Begin
     If(IsTrue)Then Begin
      If(Group)Then SMAddBarItem(Q.SubMenu[Q.MaxSubMenu{CurrParentPos}])
               Else PMAddBarItem;
     End;
     Inc(I);
    End;
    0:Break;
   End;
  Until I>=Q.Size-1;
 End;
End;

Procedure _CMLoad(Var Q:ContextMenu;Const Path:String;Index:Word;Var _Ptr{:Array of Pointer});Begin
 __CMInit(Q);
 __CMLoad(Q,Path,Index,_Ptr);
End;

Procedure _CMLoadApp(Var Q:ContextMenu;Index:Word;Var Ptr{:Array of Pointer});Begin
 _CMLoad(Q,'APP7ILES.*',Index,Ptr);
End;

Procedure CMLoadApp(Var Q:ContextMenu;Index:Word);
Var
 Ptr:Pointer;
Begin
 _CMLoadApp(Q,Index,Ptr);
End;

Procedure CMLoad(Var Q:ContextMenu;Const Path:String;Index:Word);
Var
 Ptr:Pointer;
Begin
 _CMLoad(Q,Path,Index,Ptr);
End;

Procedure CMDone(Var Q:ContextMenu);Begin
 PMDone;
 FreeMemory(Q.Data,Q.Size);
 MainMenu:=Q.OldMnu;
End;

Procedure WEShowInput(Var W:Window;X1,Y,X2:Byte);
Var
 X:Byte;
 T:TextBoxRec;
 G:GraphBoxRec;
Begin
 If(InputType=itElvis)Then Begin
  WESetKr(W,$8F);
  WEBarSpcHorShade(W,X1,Y,X2);
 End
  Else
 Begin
  If(InputType<>itOS2)or(BitsPerPixel<15)Then WESetKr(W,White shl 4);
  WEBarSpcHor(W,X1,Y,X2);
  X:=WEGetRX1(W);
  T.X1:=X+X1;
  T.Y1:=WEGetRY1(W)+Y;
  T.X2:=X+X2;
  T.Y2:=T.Y1;
  CoordTxt2Graph(T,G);
  If(InputType=itOS2)and(BitsPerPixel>=15)Then Begin
   PutFillBox(G.X1,G.Y1,G.X2,G.Y2,RGB2Color($FC,$FC,$C0));
  End;
  PutBoxRelief(G);
 End;
End;

Procedure WEShowInputText(Var W:Window;X1,Y,X2:Byte;Const S:String);Begin
 If S<>''Then Begin
  If(InputType=itOS2)and(BitsPerPixel>=15)Then Begin
   WESetKr(W,Black);
   WEPutTxtXYT(W,X1,Y,Left(S,X2-X1+1));
  End
   Else
  WEPutTxtXY(W,X1,Y,Left(S,X2-X1+1));
 End;
End;

Function WEInputString(Var W:Window;X1,Y,X2,Len:Byte;Var S:String):Word;
Var
 PBuffer:Array[Byte]of Char;
 PC:PChr;
 Err:Word;
Begin
 PC:=@PBuffer;
 StrPascalCopy(PBuffer,SizeOf(PBuffer),S);
 WESetInpColors(W,$8F,W.Palette.Sel);
 WEInputString:=_WEInput(W,X1,Y,X2,Len,PC);
 S:=StrPas(PC);
 WEShowInput(W,X1,Y,X2);
 WEShowInputText(W,X1,Y,X2,S);
{ WEPutTxtXY(W,X1,Y,Left(S,X2-X1+1));}
End;

Function WEInputVariant(Var W:Window;X1,Y,X2,Len:Byte;Format:Word;Var Value):Word;
Var
 PBuffer:Array[0..63]of Char;PC:PChr;
 ValueByte:Byte Absolute Value;
 ValueWord:Word Absolute Value;
 ValueLong:Long Absolute Value;
 ValueReal:Real Absolute Value;
 Err:Integer;
 S:String;
Begin
 PC:=@PBuffer;
 Case(Format)of
  werInputByte:StrPascalCopy(PBuffer,SizeOf(PBuffer),IntToStr(ValueByte));
  werInputLong:StrPascalCopy(PBuffer,SizeOf(PBuffer),IntToStr(ValueLong));
  werInputReal:StrPascalCopy(PBuffer,SizeOf(PBuffer),RealStr2(ValueReal,1,5));
  Else StrPascalCopy(PBuffer,SizeOf(PBuffer),IntToStr(ValueWord));
 End;
 WESetInpColors(W,$8F,W.Palette.Sel);
 WEInputVariant:=_WEInput(W,X1,Y,X2,Len,PC);
 WEShowInput(W,X1,Y,X2);
 Case(Format)of
  werInputByte:Begin
   ValueByte:=StrToWord(StrPas(PC));
   S:=WordToStr(ValueByte);
  End;
  werInputLong:Begin
   ValueLong:=LongInt(StrToInt(StrPas(PC)));
   S:=IntToStr(ValueLong);
  End;
  werInputReal:Begin
   Val(StrPas(PC),ValueReal,Err);
   S:=RealStr2(ValueReal,1,5);
  End;
  Else Begin
   ValueWord:=StrToWord(StrPas(PC));
   S:=WordToStr(ValueWord);
  End;
 End;
 WEShowInputText(W,X1,Y,X2,S);
{ WEPutTxtXY(W,X1,Y,S);}
End;

Procedure PutLabel(Var W:Window;X,Y,L:Byte;Const S:String;Attr:Byte);
Var
 GY1:Word;
Begin
 Inc(X,WEGetRX1(W));Inc(Y,WEGetRY1(W));
 If(X<NmXTxts)and(Not InBarHole(X,Y,L+4))Then Begin
  GY1:=Y*HeightChr;
  PutFillRoundRectZone(X shl 3,GY1,((X+L+3)shl 3)+7,GY1+HeightChr-1,HeightChr-1,Attr shr 4,[ztNorth]);
  PutLnHor((X+2)shl 3,GY1,((X+3+L)shl 3)-7,Attr shr 4);
  PutTxtXY(X+2+((L-Length(S))shr 1),Y,S,Attr);
 End;
End;

Procedure PutBoxRelief(Var G:GraphBoxRec);Begin
 Dec(G.X1);Dec(G.Y1);Inc(G.X2);Inc(G.Y2);
 __PutRect(G.X1,Black);
 Dec(G.X1);Dec(G.Y1);Inc(G.X2);Inc(G.Y2);
 _SetKr(8);
 _Ln(G.X1,G.Y1,G.X1,G.Y2);
 _LnHor(G.X1,G.Y1,G.X2);
 _SetKr($F);
 _Ln(G.X2,G.Y1+1,G.X2,G.Y2);
 _LnHor(G.X1+1,G.Y2,G.X2);
End;

Procedure WEPutColorBox(Var W:Window;X1,Y1,X2,Y2:Byte;Kr:Word);
Var
 G:GraphBoxRec;
Begin
 Inc(X1,WEGetRX1(W));Inc(Y1,WEGetRY1(W));
 Inc(X2,WEGetRX1(W));Inc(Y2,WEGetRY1(W));
 G.X1:=X1 shl 3;G.X2:=((X2+1)shl 3)-1;
 G.Y1:=GetRawY(Y1);G.Y2:=GetRawY(Y2+1)-1;
 If(X1=X2)Then Begin
  If HeightChr>=14Then Inc(G.Y1);
  Inc(G.X1,4);Inc(G.X2,12);
 End;
 Inc(G.X1,4);Dec(G.X2,4);Inc(G.Y1,2);Dec(G.Y2,3);
 PutFillBox(G.X1,G.Y1,G.X2,G.Y2,Kr);
 PutBoxRelief(G);
{ Dec(G.X1);Dec(G.Y1);Inc(G.X2);Inc(G.Y2);
 __PutRect(G.X1,Black);
 Dec(G.X1);Dec(G.Y1);Inc(G.X2);Inc(G.Y2);
 _SetKr(8);
 _Ln(G.X1,G.Y1,G.X1,G.Y2);
 _LnHor(G.X1,G.Y1,G.X2);
 _SetKr($F);
 _Ln(G.X2,G.Y1+1,G.X2,G.Y2);
 _LnHor(G.X1+1,G.Y2,G.X2);}
End;

Procedure WEGrafItem(Var W:Window;X,Y:Byte;Activited:Boolean);
Var
 Color:Word;
 Foreground:Byte;
 OldColor:Byte;
Begin
 If W.Palette.Border and$F0=$70Then Begin
  Color:=White;
  Foreground:=Black;
 End
  Else
 Begin
  Color:=W.Palette.Sel shr 4;
  Foreground:=White;
 End;
 WESetCube(W,X+1,Y,' ');
 WEPutColorBox(W,X,Y,X,Y,Color);
 If(Activited)Then Begin
  OldColor:=W.CurrColor;
  W.CurrColor:=(W.CurrColor and$F0)+Foreground;
  WEPutTxtXYT(W,X+1,Y,'x');
  W.CurrColor:=OldColor;
 End;
End;

Procedure WERColorGridSetBox(Var R:ResourceWindow;X:ColorGridRec);
Var
 K,C,TX,TY:Byte;
Begin
 C:=X.PValue^.Value;K:=C shl 4;
 If(K)in[0..$6F,$80..$8F]Then K:=White;
 TX:=C mod X.Length;TY:=C div X.Length;
 If(IsGrf)Then Begin
  R.W.CurrColor:=K;
  WEPutTxtXYT(R.W,TX*3+1+X.X,X.Y+TY,'ş');
 End
  Else
 _WESetCube(R.W,TX*3+1+X.X,X.Y+TY,'ş',K);
End;

Procedure WEPutColorObject(Var R:ResourceWindow;Const Element:ElementWins);
Var
 I,J,X,Y,Kr,OldKr:Byte;
Begin
 OldKr:=R.W.CurrColor;
 Y:=Element.Data.cg.Y;Kr:=0;
 For J:=0to Element.Data.cg.Height-1do Begin
  X:=Element.Data.cg.X;
  For I:=0to Element.Data.cg.Length-1do Begin
   If(IsGrf)Then Begin
    If(Element.Data.cg.Palette)Then Begin
     WEPutColorBox(R.W,X,Y,X+2,Y,
                   RGB2Color(Element.Data.cg.PValue^.Palette^[Kr].R,
                             Element.Data.cg.PValue^.Palette^[Kr].G,
                             Element.Data.cg.PValue^.Palette^[Kr].B));
    End
     Else
    WEPutColorBox(R.W,X,Y,X+2,Y,Kr);
   End
    Else
   Begin
    R.W.CurrColor:=Kr shl 4;
    WEBarSpcHor(R.W,X,Y,X+2);
   End;
   Inc(X,3);Inc(Kr);
  End;
  Inc(Y);
 End;
 WERColorGridSetBox(R,Element.Data.cg);
 R.W.CurrColor:=OldKr;
End;

Procedure WERPutColorBar(Var R:ResourceWindow;Const Data;Value:PColorGridValue);
Var
{ I,J,X,Y,Kr,OldKr:Byte;}
 Element:ElementWins;
Begin
{ OldKr:=R.W.CurrColor;}
 FillClr(Element,SizeOf(Element));
 Element.SerialNumber:=werColorGrid;
 If R.NumPage>0Then Element.Page:=R.NumPage-1;
 MoveLeft(Data,Element.Data.cg,SizeOf(ColorGridRec)-SizeOf(Pointer));
 Element.Data.cg.PValue:=Value;
 ALAddBlock(R.R,SizeOf(Element)-SizeOf(String),Element);
 WEPutColorObject(R,Element);
(* Y:=Element.Data.cg.Y;Kr:=0;
 For J:=0to Element.Data.cg.Height-1do Begin
  X:=Element.Data.cg.X;
  For I:=0to Element.Data.cg.Length-1do Begin
   If(IsGrf)Then Begin
    If(Element.Data.cg.Palette)Then Begin
     WEPutColorBox(R.W,X,Y,X+2,Y,
                   RGB2Color(Element.Data.cg.PValue^.Palette^[Kr].R,
                             Element.Data.cg.PValue^.Palette^[Kr].G,
                             Element.Data.cg.PValue^.Palette^[Kr].B));
    End
     Else
    WEPutColorBox(R.W,X,Y,X+2,Y,Kr);
   End
    Else
   Begin
    R.W.CurrColor:=Kr shl 4;
    WEBarSpcHor(R.W,X,Y,X+2);
   End;
   Inc(X,3);Inc(Kr);
  End;
  Inc(Y);
 End;
 WERColorGridSetBox(R,Element.Data.cg);
 R.W.CurrColor:=OldKr;*)
End;

Procedure WERInit(Var R:ResourceWindow);Begin
 FillClr(R,SizeOf(R));
End;

Function WERSelectHistory(Var R:ResourceWindow;X,Y:Byte;Key:String;Const Curr:String):String;
Var
 H:History;
 Q:Record
  Len:Word;
  EndCmd:Word;
  History:Array[0..511]of Byte;
 End;
 Name:String;
 I:Byte;
Begin
 FillClr(Q,SizeOf(Q));
 HYInitTo(H,512,@Q.History);
 Name:='';
 For I:=Length(Key)downto 1do Begin
  If Key[I]in['\','/']Then Break;
  Name:=Key[I]+Name;
  BackStr(Key);
 End;
 If Key[Length(Key)]in['\','/']Then BackStr(Key);
 If ReadMainKey(HKEY_CURRENT_USER,Key,Name,Q)Then Begin
  HYSetSizeBuffer(H,Q.EndCmd);
 End;
 HYQueue(H,Curr);
 If X<>$FFThen WERSelectHistory:=HYChoice(H,R.W.T.X1+X,R.W.T.Y1+Y);
 Q.Len:=514;
 Q.EndCmd:=HYGetSizeBuffer(H);
 CreateKeyFormat(HKEY_CURRENT_USER,Key,Name,tdBlob,Q);
 HYDone(H);
End;

Procedure WERDone(Var R:ResourceWindow);
Var
 PE:^ElementWins;
 I:Word;
Begin
 ALSetPtr(R.R,0);
 For I:=0to R.R.Count-1do Begin
  PE:=_ALGetCurrBuf(R.R);
  If(PE<>NIL)Then Case(PE^.SerialNumber)of
   werInputString:Begin
    If(PE^.Data.IStr.PKey<>NIL)Then Begin
     WERSelectHistory(R,$FF,$FF,PE^.Data.IStr.PKey^,PE^.Data.IStr.PValue^);
     FreeMemory(PE^.Data.IStr.PKey,Length(PE^.Data.IStr.PKey^)+1);
    End;
   End;
   werRadioButton:Begin
    If(PE^.Data.rbOption<>NIL)Then FreeMemory(PE^.Data.rbOption,SizeOf(SOOption));
   End;
   werImage:RIDoneLoaderImage(PE^.Data.ioImage);
  End;
  ALNext(R.R);
 End;
 ALDone(R.R);
 WEDone(R.W);
End;

Procedure WERAddPutTxt(Var R:ResourceWindow;X,Y:Byte;Const Msg:String);
Var
 Element:ElementWins;
Begin
 FillClr(Element,SizeOf(Element));
 Element.Data.txMsg:=MessageByLanguage(Msg);
 If R.NumPage>0Then Begin
  Element.SerialNumber:=werTextXY;
  If R.NumPage>0Then Element.Page:=R.NumPage-1;
  Element.Data.txX:=X;
  Element.Data.txY:=Y;
  ALAddBlock(R.R,SizeOf(Element)-SizeOf(String)+Length(Element.Data.txMsg),Element);
 End;
 WEPutTxtXY(R.W,X,Y,Element.Data.txMsg);
End;

Procedure WERAddInput(Var R:ResourceWindow;Const Data;Serial:Word;Value:Pointer);
Var
 DataX:Record
  X1,Y,X2,Len:Byte;
  Key:String;
 End Absolute Data;
 Element:ElementWins;
 Len:Byte;
Begin
 FillClr(Element,SizeOf(Element));
 If Serial and$20=$20Then Begin
  ASM
   AND Serial,$F;
  END;
  Repeat
   Case(Serial)of
    1:Len:=SizeOf(Byte);
    2:Len:=SizeOf(Word);
    3:Len:=SizeOf(LongInt);
    4:Len:=SizeOf(Real);
    Else Break;
   End;
   MoveLeft(TByte(Value^)[Len],Element.Data.ibOnChange,SizeOf(Pointer)*2);
  Until True;
 End;
 Element.SerialNumber:=Serial;
 If R.NumPage>0Then Element.Page:=R.NumPage-1;
 MoveLeft(DataX,Element.Data.iwX1,4);
 Element.Data.iwPValue:=Value;
 If Serial=6Then Begin
  If Length(DataX.Key)>0Then Begin
   Element.Data.IStr.PKey:=MemAlloc(Length(DataX.Key)+1);
   Element.Data.IStr.PKey^:=DataX.Key;
  End;
 End;
 ALAddBlock(R.R,SizeOf(IsRec)+3,Element);
End;

Procedure WERAddInputFile(Var R:ResourceWindow;Const Data;Value:Pointer);
Var
 DataX:Record
  X1,Y,X2,Len:Byte;
  Key:String;
 End Absolute Data;
 Element:ElementWins;
Begin
 FillClr(Element,SizeOf(Element));
 Element.SerialNumber:=werInputFile;
 If R.NumPage>0Then Element.Page:=R.NumPage-1;
 MoveLeft(DataX,Element.Data.fi.X1,4);
 Element.Data.fi.PValue:=Value;
 If Length(DataX.Key)>0Then Begin
  Element.Data.fi.PKey:=MemAlloc(Length(DataX.Key)+1);
  Element.Data.fi.PKey^:=DataX.Key;
 End;
 ALAddBlock(R.R,SizeOf(FiRec)+3,Element);
End;

Procedure WERAddInputCountry(Var R:ResourceWindow;Const Data;Value:Pointer);
Var
 DataX:Record
  X1,Y,X2,Mode:Byte;
 End Absolute Data;
 Element:ElementWins;
Begin
 FillClr(Element,SizeOf(Element));
 Element.SerialNumber:=werInputCountry;
 If R.NumPage>0Then Element.Page:=R.NumPage-1;
 MoveLeft(DataX,Element.Data.InputCountry.X1,4);
 If Element.Data.InputCountry.X2>240Then Begin
  Element.Data.InputCountry.X2:=R.W.MaxX-(Not(Element.Data.InputCountry.X2)and$F);
 End;
 Element.Data.InputCountry.PValue:=Value;
 ALAddBlock(R.R,SizeOf(InputCountryObject),Element);
End;

Procedure WERAddBarHori(Var R:ResourceWindow;Const Data);
Var
 DataX:Record
  X1,Y,X2:Byte;
 End Absolute Data;
 Element:ElementWins;
 X:Byte;
 Y:Byte;
Begin
 FillClr(Element,SizeOf(Element));
 Element.SerialNumber:=werBarHori;
 If R.NumPage>0Then Element.Page:=R.NumPage-1;
 MoveLeft(DataX,Element.Data.bh.X1,3);
 X:=WEGetRX1(R.W);
 Y:=WEGetRY1(R.W);
 Inc(Element.Data.bh.X1,X);
 Inc(Element.Data.bh.Y,Y);
 Inc(Element.Data.bh.X2,X);
 ALAddBlock(R.R,SizeOf(BhRec)+3,Element);
End;

Procedure WERAddkHorDnExt(Var R:ResourceWindow;Const Key:String;Value:Pointer);Near;
Var
 Element:ElementWins;
Begin
 FillClr(Element,SizeOf(Element));
 Element.SerialNumber:=werKeyDown;
 If R.NumPage>0Then Element.Page:=R.NumPage-1;
 Element.Data.kdKey:='$'+MessageByLanguage(Key);
 Element.Data.kdPValue:=Value;
 ALAddBlock(R.R,SizeOf(Element),Element);
End;

Procedure WERAddkHor(Var R:ResourceWindow;Const Key:String;X,Y,Len:Byte;Value:Pointer);
Var
 Element:ElementWins;
Begin
 FillClr(Element,SizeOf(Element));
 Element.SerialNumber:=werKeyHori;
 If R.NumPage>0Then Element.Page:=R.NumPage-1;
 Element.Data.khKey:='$'+Key;
 Element.Data.khX:=X;
 Element.Data.khY:=Y;
 Element.Data.khLen:=Len;
 Element.Data.khPValue:=Value;
 ALAddBlock(R.R,SizeOf(Element),Element);
End;

Procedure WERAddClickBox(Var R:ResourceWindow;Const Msg:String;X,Y,Len:Byte;Value,Routine:Pointer);
Type
 DataClickBox=Record
  OnPress:Function(Var R:ResourceWindow;Var Context):Boolean; { Routine d'appel lorsque modifier }
  Context:Pointer;                                            { Contexte de la routine d'appel }
 End;
Var
 Element:ElementWins;
 Data:^DataClickBox Absolute Routine;
Begin
 FillClr(Element,SizeOf(Element));
 Element.SerialNumber:=werClickBox;
 If R.NumPage>0Then Element.Page:=R.NumPage-1;
 Element.Data.cbMsg:=MessageByLanguage(Msg);
 If Len=0Then Len:=Length(Element.Data.cbMsg)+1;
 Element.Data.cbX:=X+Len;
 Element.Data.cbXMsg:=X;
 Element.Data.cbY:=Y;
 Element.Data.cbPValue:=Value;
 If(Data<>NIL)Then Begin
  Element.Data.cbOnPress:=Data^.OnPress;
  Element.Data.cbContext:=Data^.Context;
 End;
 ALAddBlock(R.R,SizeOf(Element)+16,Element);
 If R.NumPage=0Then WEPutTxtXY(R.W,X,Y,Element.Data.cbMsg);
End;

Procedure WERAddRadioButton(Var R:ResourceWindow;Const Msg,Option:String;
                            X,Y,Len:Byte;Value,Routine:Pointer);
Type
 ProcRoutine=Procedure(Var Context);
Var
 Element:ElementWins;
 RoutineProc:ProcRoutine Absolute Routine;
 OptionData:SOOption;
Begin
 FillClr(Element,SizeOf(Element));
 Element.SerialNumber:=werRadioButton;
 OptionData.Title:=MessageByLanguage(Msg);
 OptionData.Input:=MessageByLanguage(Option);
 If R.NumPage>0Then Begin
  Element.Page:=R.NumPage-1;
  Element.Data.rbOption:=NewBlock(OptionData,SizeOf(OptionData));
 End;
 If Len=0Then Len:=Length(Msg)+1;
 Element.Data.rbPValue:=Value;
 SetAllKr(R.W.Palette.Border,R.W.Palette.High);
 SOInit(Element.Data.rbDial,WEGetRX1(R.W)+X,WEGetRY1(R.W)+Y,
        OptionData.Title,OptionData.Input,Element.Data.rbPValue^);
 Element.Data.rbDial.OnMove:=RoutineProc;
 Element.Data.rbDial.Context:=@R;
 ALAddBlock(R.R,SizeOf(Element),Element);
End;

Procedure WERAddColorCube(Var R:ResourceWindow;Const Data,Output);
Var
 DataX:Record
  X,Y,L,H:Byte;
 End Absolute Data;
 Element:ElementWins;
Begin
 FillClr(Element,SizeOf(Element));
 Element.SerialNumber:=werColorCube;
 If R.NumPage>0Then Element.Page:=R.NumPage-1;
 MoveLeft(DataX,Element.Data.ccX,SizeOf(DataX));
 Element.Data.ccData:=@Output;
 ALAddBlock(R.R,SizeOf(Element),Element);
End;

Procedure ConvImageToScreen(Var Image:XInf);
Var
 Inf:MCanvas;
Begin
 RIRes2WnImg(Image,Inf);
 RIMakeDoublon(Image,rmAllResSteady,True,Inf);
 XFreeMem(Image);
 Image:=Inf.Miroir;
End;

Procedure ConvImagesToScreen(Var Images:ImageObjectLoader);
Var
 Inf:MCanvas;
 I:Integer;
Begin
 For I:=0to Images.NumAnim-1do Begin
  RIRes2WnImg(Images.Anim^[I],Inf);
  RIMakeDoublon(Images.Anim^[I],rmAllResSteady,True,Inf);
  XFreeMem(Images.Anim^[I]);
  Images.Anim^[I]:=Inf.Miroir;
 End;
End;

Procedure WERAddImage(Var R:ResourceWindow;Const Data);
Var
 DataX:Record
  X,Y:Byte;
  Index:Word;
  Name:String;
 End Absolute Data;
 Element:ElementWins;
Begin
 FillClr(Element,SizeOf(Element));
 Element.SerialNumber:=werImage;
 If R.NumPage>0Then Element.Page:=R.NumPage-1;
 Element.Data.ioX:=(DataX.X+WEGetRX1(R.W))shl 3;
 Element.Data.ioY:=GetRawY(DataX.Y+WEGetRY1(R.W));
 RIInitLoader(Element.Data.ioImage);
 Element.Data.ioImage.Handle:=FileOpen(DataX.Name,fmRead);
 If(Element.Data.ioImage.Handle=errHdl)Then Begin
  Element.Data.ioImage.Handle:=FileOpen(MaltePath+DataX.Name,fmRead);
 End;
 If(Element.Data.ioImage.Handle<>errHdl)Then Begin
  Element.Data.ioImage.Index:=DataX.Index;
  Element.Data.ioImage.Ressource:=rmAllRes;
  If(FX)Then Include(Element.Data.ioImage.Option,fpAllImage);
  RILoaderImage(Element.Data.ioImage,Element.Data.ioOneImage);
  If Not(FX)Then ConvImageToScreen(Element.Data.ioOneImage)
            Else ConvImagesToScreen(Element.Data.ioImage);
  FileClose(Element.Data.ioImage.Handle);
  If(Element.Data.ioOneImage.Output<>$FF)or
    (Element.Data.ioImage.NumAnim>0)Then Begin
   If(FX)and(Element.Data.ioImage.NumAnim>1)Then R.Anim:=True;
   ALAddBlock(R.R,SizeOf(Element),Element);
  End;
 End;
End;

Procedure WERAddTree(Var R:ResourceWindow;Const Data,Output);
Var
 DataX:Record
  X1,Y1,X2,Y2:Byte;
 End Absolute Data;
 Element:ElementWins;
 X,Y:Byte;
 OutputTree:MTree Absolute Output;
Begin
 FillClr(Element,SizeOf(Element));
 Element.SerialNumber:=werTree;
 If R.NumPage>0Then Element.Page:=R.NumPage-1;
 X:=WEGetRX1(R.W);
 Y:=WEGetRY1(R.W);
 DTInit(Element.Data.wtTree,X+DataX.X1,Y+DataX.Y1,X+DataX.X2,Y+DataX.Y2);
 OutputTree.LoadTree(Element.Data.wtTree,OutputTree.Context^);
 ALAddBlock(R.R,SizeOf(Element),Element);
End;

Procedure WERAddListBox(Var R:ResourceWindow;Const Data;Value:Pointer);
Var
 Element:^ElementWins;
 OldShade:Boolean;
 DataX:Record
  X1,Y1,X2,Y2:Byte;
  Shadow:Boolean;
  Title:String;
 End Absolute Data;
Begin
 Element:=ALAdd(R.R,SizeOf(Element^));
 If(Element=NIL)Then Exit;
 FillClr(Element^,SizeOf(Element^));
 Element^.SerialNumber:=werListBox;
 OldShade:=GetShade;
 SetShade(False);
 If R.NumPage>0Then Element^.Page:=R.NumPage-1;
 WESubList(R.W,DataX.X1,DataX.Y1,DataX.X2,DataX.Y2,DataX.Title,Element^.Data.lbLM);
 If(DataX.Shadow)Then LMPutSmallShade(Element^.Data.lbLM);
 Element^.Data.lbPValue:=Value;
 If(Pointer(@Element^.Data.lbPValue^.LoadList)<>NIL)Then Begin
  Element^.Data.lbPValue^.LoadList(Element^.Data.lbLM,
                                  Element^.Data.lbPValue^.Context^);
  If Element^.Data.lbPValue^.Value<>$FFFFThen Begin
   Element^.Data.lbLM.P:=Element^.Data.lbPValue^.Value;
   If(Element^.Data.lbLM.P>Element^.Data.lbLM.W.MaxY)Then
    Element^.Data.lbLM.Y:=Element^.Data.lbLM.W.MaxY;
  End;
  LMRefresh(Element^.Data.lbLM);
  LMSelBarInactive(Element^.Data.lbLM);
 End;
 SetShade(OldShade);
End;

Procedure WEPutCheckBox(Var W:Window;X,Y:Byte;Value:Boolean);Begin
 If(IsGrf)Then WEGrafItem(W,X,Y,Value)
          Else WEPutTxtXY(W,X,Y,'['+Char(Byte(Value)*56+32)+']');
End;

Type
 StrBooleanPtrRec=Record
  PChr:PChr;
  Nm:^Boolean;
  Len:Word;
 End;

Procedure ListIconRoutine(X,Y:Byte;P:Word;Var Context);
Var
 Ptr:^LMPtrRec;
 PBool:^StrBooleanPtrRec Absolute Ptr;
 Value:Boolean;
Begin
 Dec(X,WEGetRX1(CurrList^.W));
 Dec(Y,WEGetRY1(CurrList^.W));
 Ptr:=_ALGetBuf(CurrList^.List,P);
 If(Ptr=NIL)Then Value:=False
            Else Value:=PBool^.Nm^;
 WESetKrBorder(CurrList^.W);
 WEPutCheckBox(CurrList^.W,X,Y,Value);
 CurrList^.W.X:=3;
End;

Procedure ListOnClickButton(Var Context;P:Word);
Var
 Ptr:^LMPtrRec;
 PBool:^StrBooleanPtrRec Absolute Ptr;
 Value:Boolean;
Begin
 Ptr:=_ALGetBuf(CurrList^.List,P);
 If(Ptr<>NIL)Then Begin
  PBool^.Nm^:=Not PBool^.Nm^;
  ListIconRoutine(WEGetRX1(CurrList^.W),CurrList^.Y+WEGetRY1(CurrList^.W),P,P);
 End;
End;

Function ListOnModified(Var Context;P:Word):String;
Var
 Ptr:^LMPtrRec;
 PBool:^StrBooleanPtrRec Absolute Ptr;
 Value:Boolean;
Begin
 Ptr:=_ALGetBuf(CurrList^.List,P);
 If(Ptr<>NIL)Then Begin
  PBool^.Nm^:=Not PBool^.Nm^;
  ListIconRoutine(WEGetRX1(CurrList^.W),CurrList^.Y+WEGetRY1(CurrList^.W),P,P);
 End;
 ListOnModified:='';
End;

Procedure WERAddList(Var R:ResourceWindow;Const Data);
Var
 Element:^ElementWins;
 OldShade:Boolean;
 DataX:Record
  X1,Y1,X2,Y2:Byte;
  Title:String;
 End Absolute Data;
Begin
 Element:=ALAdd(R.R,SizeOf(Element^));
 If(Element=NIL)Then Exit;
 FillClr(Element^,SizeOf(Element^));
 Element^.SerialNumber:=werList;
 OldShade:=GetShade;
 SetShade(False);
 If R.NumPage>0Then Element^.Page:=R.NumPage-1;
 WESubList(R.W,DataX.X1,DataX.Y1,DataX.X2,DataX.Y2,DataX.Title,Element^.Data.listLM);
 Element^.Data.listLM.Space4Icon:=3;
 Element^.Data.listLM.IconRoutine:=ListIconRoutine;
 Element^.Data.listLM.OnClickButton:=ListOnClickButton;
 Element^.Data.listLM.OnModified:=ListOnModified;
 CurrList:=@Element^.Data.listLM;
 SetShade(OldShade);
End;

Procedure WERAddScrollBar(Var R:ResourceWindow;Const Data;Output:Pointer);
Var
 Element:ElementWins;
Begin
 FillClr(Element,SizeOf(Element));
 Element.SerialNumber:=werScrollBar;
 If R.NumPage>0Then Element.Page:=R.NumPage-1;
 MoveLeft(Data,Element.Data.sbData,SizeOf(sbRec));
 Element.Data.sb.PValueByte:=Output;
 Element.Data.sbX1:=Element.Data.sbData.X1;
 If Not(Element.Data.sbData.NoNum)Then Inc(Element.Data.sbX1,8);
 If Hi(Element.Data.sbData.Min)or
    Hi(Element.Data.sbData.Max)>0Then Element.Data.sbFormat:=werInputWord
                                 Else Element.Data.sbFormat:=werInputByte;
 Element.Data.sbOldX:=$FF;
 ALAddBlock(R.R,SizeOf(Element)-SizeOf(String)+32,Element);
End;

Procedure WERAddFrame(Var R:ResourceWindow;Const Data);
Var
 Element:ElementWins;
Begin
 FillClr(Element,SizeOf(Element));
 Element.SerialNumber:=werFrame;
 If R.NumPage>0Then Element.Page:=R.NumPage-1;
 MoveLeft(Data,Element.Data.sbData,4+SizeOf(String));
 ALAddBlock(R.R,SizeOf(Element),Element);
End;

Procedure WERAddPage(Var R:ResourceWindow;Attr:Byte;Const Title:String);
Var
 Element:ElementWins;
Begin
 FillClr(Element,SizeOf(Element));
 Element.SerialNumber:=werPage;
 Element.Page:=R.NumPage-1;
 If R.XPage=0Then Inc(R.XPage);
 Element.Data.pgX:=R.XPage;
 Inc(R.XPage,Length(Title)+6);
 Element.Data.pgColor:=Attr;
 Element.Data.pgTitle:=Title;
 PutLabel(R.W,Element.Data.pgX,1,Length(Element.Data.pgTitle)+2,
          Element.Data.pgTitle,Element.Data.pgColor);
 ALAddBlock(R.R,SizeOf(Element),Element);
End;

Procedure WEPutBarHori(Var W:Window;X1,Y,X2,Attr:Byte);Begin
 W.CurrColor:=Attr;
 WEBarSpcHorShade(W,X1,Y,X2);
 Adele.LeftIcon(WEGetRX1(W)+X1,WEGetRY1(W)+Y,CurrKrs.Draw.Window.Icon);
 WEPutRect(W,(X1+2)shl 3,GetRawY(Y),((X2-1)shl 3)-1,GetRawY(Y+1)-1,Black);
 Adele.RightIcon(WEGetRX1(W)+X2-1,WEGetRY1(W)+Y,CurrKrs.Draw.Window.Icon);
End;

Procedure WERCallOnMoveScrollBar(Var R:ResourceWindow;Var PE:ElementWins);Begin
 Case(PE.Data.sbFormat)of
  werInputByte:Begin
   If(Pointer(@PE.Data.sb.PValueByteStruct^.OnMove)<>NIL)Then Begin
    PE.Data.sb.PValueByteStruct^.OnMove(R,PE.Data.sb.PValueByteStruct^.Context^);
   End;
  End;
  werInputWord:Begin
   If(Pointer(@PE.Data.sb.PValueWordStruct^.OnMove)<>NIL)Then Begin
    PE.Data.sb.PValueWordStruct^.OnMove(R,PE.Data.sb.PValueWordStruct^.Context^);
   End;
  End;
 End;
End;

Procedure WERPutCompatHori(Var R:ResourceWindow;X,Y:Byte;Var PE:ElementWins);
Var
 GX1,GY1,GX2,GY2,I:Word;
Begin
 Inc(X,WEGetRX1(R.W));Inc(Y,WEGetRY1(R.W));
 If PE.Data.sbOldX<>$FFThen Begin
  WERCallOnMoveScrollBar(R,PE);
  GX1:=PE.Data.sbOldX;
  GY1:=Y;GX2:=GX1+1;
  If(IsGrf)Then Begin
   GX1:=GX1 shl 3;
   GY1:=GetRawY(GY1);
   GX2:=(GX2 shl 3)+7;
   GY2:=GY1+HeightChr-1;
   PutFillBox(GX1+1,GY1+1,GX2-1,GY2-1,PE.Data.sbData.Attr shr 4)
  End
   Else
  BarSelHor(GX1,GY1,GX2,PE.Data.sbData.Attr);
 End;
 If(IsGrf)Then Begin
  GX1:=X shl 3;
  GY1:=GetRawY(Y);
  GX2:=GX1+15;
  GY2:=GY1+HeightChr-1;
  PutFillBox(GX1+2,GY1+2,GX2-2,GY2-2,LightGray);
  PutLnHor(GX1+1,GY1+1,GX2-1,White);
  PutLine(GX1+1,GY1+2,GX1+1,GY2-1,White);
  PutLine(GX2-1,GY1+2,GX2-1,GY2-1,DarkGray);
  PutLnHor(GX1+2,GY2-1,GX2-1,DarkGray);
  If(BitsPerPixel>=4)and(HeightChr>8)Then Begin
   For I:=0to((HeightChr-3)shr 1)-2do Begin
    PutLine(GX1+3+(I shl 1),GY1+3,GX1+3+(I shl 1),GY1-3+HeightChr,White);
    PutLine(GX1+4+(I shl 1),GY1+3,GX1+4+(I shl 1),GY1-3+HeightChr,Black);
   End;
  End;
 End
  Else
 BarSelHor(GX1,GY1,GX2,R.W.Palette.Icon);
 PE.Data.sbOldX:=X;
End;

Function WERRunColorGrid(Var R:ResourceWindow;Var X:ColorGridRec):Word;
Var
 K:Word;
 MX,MY,I:Byte;

 Procedure SetUnBox;
 Var
  K,C,TX,TY:Byte;
 Begin
  K:=X.PValue^.Value shl 4;
  If K=0Then K:=White;
  C:=X.PValue^.Value;
  TX:=C mod X.Length;
  TY:=C div X.Length;
  If(IsGrf)Then Begin
   If(X.Palette)Then Begin
    WEPutColorBox(R.W,X.X+TX*3,X.Y+TY,X.X+TX*3+2,X.Y+TY,
                   RGB2Color(X.PValue^.Palette^[C].R,
                             X.PValue^.Palette^[C].G,
                             X.PValue^.Palette^[C].B));
   End
    Else
   WEPutColorBox(R.W,X.X+TX*3,X.Y+TY,X.X+TX*3+2,X.Y+TY,C);
  End
   Else
  _WESetCube(R.W,TX*3+X.X+1,X.Y+TY,' ',K);
 End;

Begin
 Repeat
  K:=WEReadk(R.W);
  Case(K)of
   kbInWn:Begin
    MX:=LastMouseX-WEGetRX1(R.W);
    MY:=LastMouseY-WEGetRY1(R.W);
    If WEMouseInZone(R.W,X.X,X.Y,Succ(X.Length)*3,X.Height)Then Begin
     WaitMouseBut0;
     I:=((MX-X.X)div 3)+((MY-X.Y)*X.Length);
     If(LastMouseB=2)and(Pointer(@X.PValue^.OnPressButton2)<>NIL)Then Begin
      SetUnBox;
      X.PValue^.Value:=I;
      X.PValue^.OnPressButton2(I,X.PValue^.Context^);
      SetUnBox;
      WERColorGridSetBox(R,X);
     End
      Else
     If(I<>X.PValue^.Value)Then Begin
      SetUnBox;
      X.PValue^.Value:=I;
      WERColorGridSetBox(R,X);
     End;
    End
     Else
    Break;
   End;
   kbLeft:Begin
    SetUnBox;
    X.PValue^.Value:=(X.PValue^.Value-1)and$F;
    WERColorGridSetBox(R,X);
   End;
   kbRight:Begin
    SetUnBox;
    X.PValue^.Value:=(X.PValue^.Value+1)and$F;
    WERColorGridSetBox(R,X);
   End;
   Else Break;
  End;
 Until False;
 WERRunColorGrid:=K;
End;

Procedure WERUpDateCompat(R:ResourceWindow;Var PE:ElementWins;P:Word);
Var
 TX:Word;
Begin
 If PE.Data.sbData.Max=0Then TX:=0
  Else
 TX:=(Long(Long(PE.Data.sbData.X2-(PE.Data.sbX1+5))*Long(P))div
     (PE.Data.sbData.Max-PE.Data.sbData.Min));
 WERPutCompatHori(R,PE.Data.sbX1+2+TX,PE.Data.sbData.Y,PE);
End;

Procedure SetPixel3D(CenterHorizontal,CenterVertical,X,Y,Z:Integer;Color:Word);Begin
 SetPixel(CenterHorizontal+X-(Z shr 1),CenterVertical-Y+(Z shr 1),Color);
End;

Procedure WERPutInput(R:ResourceWindow;Const PE:ElementWins);
Var
 CurrColor:Byte;
 SubLen:Byte;
 S:String;
Begin
 If(PE.SerialNumber=werInputFile)Then SubLen:=3
                                 Else SubLen:=0;
 Case(PE.SerialNumber)of
  werInputByte:S:=IntToStr(PE.Data.ibPValue^);
  werInputWord:S:=IntToStr(PE.Data.iwPValue^);
  werInputLong:S:=IntToStr(PE.Data.ilPValue^);
  werInputReal:S:=RealStr2(PE.Data.irPValue^,1,5);
  Else S:=Left(PE.Data.IStr.PValue^,PE.Data.iwX2-PE.Data.iwX1+1-SubLen);
 End;
 WEShowInputText(R.W,PE.Data.iwX1,PE.Data.iwY,PE.Data.iwX2,S);
{ WEPutTxtXY(R.W,PE.Data.iwX1,PE.Data.iwY,S);}
 If(PE.SerialNumber=werInputFile)Then Begin
  CurrColor:=R.W.CurrColor;
  WESetKr(R.W,$70);
  WEPutTxtXY(R.W,PE.Data.fi.X2-2,PE.Data.fi.Y,'...');
  WEBarSpcHorRelief(R.W,PE.Data.fi.X2-2,PE.Data.fi.Y,PE.Data.fi.X2);
  R.W.CurrColor:=CurrColor;
 End
  Else
 If(PE.Data.IStr.PKey<>NIL)Then Begin
  UpIcon(WEGetRX1(R.W)+PE.Data.iwX2-1,
         WEGetRY1(R.W)+PE.Data.iwY,$F);
 End;
End;

Procedure WERPutInputCountry(Var R:ResourceWindow;Var PE:ElementWins);
Var
 S:String;
 Buffer:Record
  ID:SmallInt;
  MID:String[2];
  Pays:String;
  IDCountry:SmallInt;
  Superficie:LongInt;
  Pop79:LongInt;
 End;
Begin
 WEShowInput(R.W,PE.Data.InputCountry.X1,PE.Data.InputCountry.Y,PE.Data.InputCountry.X2);
 S:='';
 If PE.Data.InputCountry.PValue^=0Then Begin
  If PE.Data.InputCountry.Mode=0Then S:='(Tous)'
                                Else S:='(S‚lectionn‚ un pays)';
 End
  Else
 Begin
  DBOpenServerName(ChantalServer,'CHANTAL:/Country/Pays.Dat');
  If DBLocateAbs(ChantalServer,0,PE.Data.InputCountry.PValue^,[])Then Begin
   DBReadRec(ChantalServer,Buffer);
   S:=Buffer.Pays;
  End;
 End;
 WEShowInputText(R.W,PE.Data.InputCountry.X1,PE.Data.InputCountry.Y,PE.Data.InputCountry.X2,S);
{ WEPutTxtXY(R.W,PE.Data.ic.X1,PE.Data.ic.Y,
            Left(S,PE.Data.ic.X2-PE.Data.ic.X1-1));}
 DownIcon(WEGetRX1(R.W)+PE.Data.InputCountry.X2-1,
          WEGetRY1(R.W)+PE.Data.InputCountry.Y,$F);
End;

Procedure WERSelectCountry(Var R:ResourceWindow;Var PE:ElementWins);
Var
 L:LstMnu;
 X,Y:Byte;
 K:Word;
 Buffer:Record
  ID:SmallInt;
  MID:String[2];
  Pays:String;
  IDCountry:SmallInt;
  Superficie:LongInt;
  Pop79:LongInt;
 End;
Begin
 X:=WEGetRX1(R.W);
 Y:=WEGetRY1(R.W);
 WESetKrSel(R.W);
 WEBarSelHor(R.W,PE.Data.InputCountry.X1,PE.Data.InputCountry.Y,PE.Data.InputCountry.X2-2);
 LMInitKrDials(L,X+PE.Data.InputCountry.X1,Y+PE.Data.InputCountry.Y+1,X+PE.Data.InputCountry.X2,Y+PE.Data.InputCountry.Y+10,
                 'S‚lectionner un pays');
 DBOpenServerName(ChantalServer,'CHANTAL:/Country/Pays.Dat');
 DBFirst(ChantalServer);
 If PE.Data.InputCountry.Mode=0Then ALAddStrWord(L.List,'(Tous)',0)
                               Else ALAddStrWord(L.List,'(S‚lectionn‚ un pays)',0);
 While Not DBEOF(ChantalServer)do Begin
  DBReadRec(ChantalServer,Buffer);
  ALAddStrWord(L.List,Buffer.Pays,Buffer.ID);
 End;
 LMGotoPos(L,PE.Data.InputCountry.PValue^);
 K:=LMRun(L);
 If K<>0Then PE.Data.InputCountry.PValue^:=K;
 LMDone(L);
 WERPutInputCountry(R,PE);
End;

Procedure WERPutPage(R:ResourceWindow);
Var
 I,J,K,P:Word;
 Len:Word;                  { Longueur }
 Base:Word;                 { Valeur de base }
 GM:Integer;                { Marge graphique temporaire }
 TempColor:Word;            { Couleur temporaire }
 CenterHorizontal,CenterVertical:Word;
 PE:^ElementWins;
 GTX1,GTX2,GY1,GL,GY2:Word; { Coordonn‚e graphique }
 SaveRadioButton:Record
  OnMove:Procedure(Var Context); { v‚nement si d‚placement }
  Context:Pointer;               { Contexte concernant dans l'appel OnMove }
  OnWait:Procedure(Var Context); { Si rien … faire }
  OnWaitContext:Pointer;         { Contexte de si rien … faire }
 End;
Begin
 ALSetPtr(R.R,0);
 For I:=0to R.R.Count-1do Begin
  PE:=_ALGetCurrBuf(R.R);
  If(PE<>NIL)Then Begin
   If(PE^.Page=R.CurrPage)Then Case(PE^.SerialNumber)of
    werInputByte..werInputReal,werInputString,werInputFile:Begin
     If PE^.Data.iwX2>240Then Begin
      PE^.Data.iwX2:=R.W.MaxX-(Not(PE^.Data.iwX2)and$F);
      If(InputType<>itElvis)Then Dec(PE^.Data.iwX2);
     End;
     WEShowInput(R.W,PE^.Data.iwX1,PE^.Data.iwY,PE^.Data.iwX2);
     WERPutInput(R,PE^);
    End;
    werInputCountry:WERPutInputCountry(R,PE^);
    werClickBox:Begin
     WESetKrBorder(R.W);
     WEPutTxtXY(R.W,PE^.Data.cbXMsg,PE^.Data.cbY,PE^.Data.cbMsg);
     WEPutCheckBox(R.W,PE^.Data.cbX,PE^.Data.cbY,PE^.Data.cbPValue^);
    End;
    werRadioButton:If(PE^.Data.rbOption<>NIL)Then Begin
     MoveLeft(PE^.Data.rbDial.OnMove,SaveRadioButton,SizeOf(SaveRadioButton));
     SetAllKr(R.W.Palette.Border,R.W.Palette.High);
     SOInit(PE^.Data.rbDial,PE^.Data.rbDial.X,PE^.Data.rbDial.Y,
            PE^.Data.rbOption^.Title,PE^.Data.rbOption^.Input,
            PE^.Data.rbPValue^);
     MoveLeft(SaveRadioButton,PE^.Data.rbDial.OnMove,SizeOf(SaveRadioButton));
    End;
    werKeyHori:Begin
     WEPutkHor(R.W,PE^.Data.khX,PE^.Data.khY,PE^.Data.khLen,PE^.Data.khKey);
    End;
    werKeyDown:Begin
     WEPutkHorDn(R.W,PE^.Data.kdKey);
    End;
    werPage:Begin
     PutLabel(R.W,PE^.Data.pgX,1,Length(PE^.Data.pgTitle)+2,
              PE^.Data.pgTitle,PE^.Data.pgColor);
     WEClrWnBorder(R.W,0,2,wnMax,wnMax);
     GL:=Succ(R.W.MaxX)shl 3;
     GY1:=GetRawY(2);
     If(WinType=Normal)Then GM:=6
                       Else GM:=0;
     Inc(GL,GM shl 1);
     WEClrLnHor(R.W,-GM,GY1,GL,Black);
     WEClrLnHor(R.W,-GM,GY1+1,GL,White);
     GTX1:=(PE^.Data.pgX+1)shl 3;
     GTX2:=((PE^.Data.pgX+3+Length(PE^.Data.pgTitle)+2)shl 3);
     WEPutFillBox(R.W,GTX1-8,GY1,GTX2+7,GY1+1,PE^.Data.pgColor shr 4);
     WEPutLnHor(R.W,GTX1-4,GY1+2,GTX2+3,PE^.Data.pgColor shr 4);
     WEPutLnHor(R.W,GTX1,GY1+3,GTX2,PE^.Data.pgColor shr 4);
     GY1:=GetRawY(R.W.MaxY-1);
     If BitsPerPixel<=8Then TempColor:=DarkGray
                       Else TempColor:=GetGrayColor(160);
     For J:=0to 7do Begin
      WEClrLnHor(R.W,-GM,GY1+(J shl 1),GL,TempColor);
     End;
    End;
    werBarHori:Begin
     BarHorDials(PE^.Data.bh.X1,PE^.Data.bh.Y,PE^.Data.bh.X2,R.W.Palette.Border);
    End;
    werColorGrid:Begin
     WEPutColorObject(R,PE^);
    End;
    werScrollBar:Begin
     Case(PE^.Data.sbFormat)of
      werInputByte:P:=PE^.Data.sb.PValueByte^;
      Else P:=PE^.Data.sb.PValueWord^;
     End;
     If Not(PE^.Data.sbData.NoNum)Then Begin
      WEShowInput(R.W,PE^.Data.sbData.X1,PE^.Data.sbData.Y,PE^.Data.sbData.X1+5);
      WEShowInputText(R.W,PE^.Data.sbData.X1,PE^.Data.sbData.Y,PE^.Data.sbData.X1+4,WordToStr(P));
{      WEPutTxtXY(R.W,PE^.Data.sbData.X1,PE^.Data.sbData.Y,Left(WordToStr(P),5));}
     End;
     WEPutBarHori(R.W,PE^.Data.sbX1,PE^.Data.sbData.Y,
                      PE^.Data.sbData.X2,PE^.Data.sbData.Attr);
     WERCallOnMoveScrollBar(R,PE^);
     WERUpdateCompat(R,PE^,P);
    End;
    werFrame:Frame(R,PE^.Data);
    werColorCube:Begin
     CenterHorizontal:=(WEGetRX1(R.W)+PE^.Data.ccX+(PE^.Data.ccL shr 1))shl 3;
     CenterVertical:=GetRawY(WEGetRY1(R.W)+PE^.Data.ccY+(PE^.Data.ccH shr 1));
     Len:=PE^.Data.ccL shl 3;
     For I:=0to Len+8do Begin
      SetPixel3D(CenterHorizontal,CenterVertical,0,0,I,White);
      SetPixel3D(CenterHorizontal,CenterVertical,0,I,0,White);
      SetPixel3D(CenterHorizontal,CenterVertical,I,0,0,White);
     End;
     Dec(Len);
     Base:=(255-Len)shr 1;
     For J:=Len downto 0do For I:=0to(Len)do Begin
      SetPixel3D(CenterHorizontal,CenterVertical,I,J,Len,RGB2Color(Base+I,Base+J,Base+Len));
     End;
     For K:=0to(Len)    do For I:=0to(Len)do Begin
      SetPixel3D(CenterHorizontal,CenterVertical,I,Len,K,RGB2Color(Base+I,Base+Len,Base+K));
     End;
     For J:=Len downto 0do For K:=0to(Len)do Begin
      SetPixel3D(CenterHorizontal,CenterVertical,Len,J,K,RGB2Color(Base+Len,Base+J,Base+K));
     End;
     If(Pointer(@PE^.Data.ccData^.OnClick)<>NIL)Then PE^.Data.ccData^.OnClick(R,PE^.Data.ccData^.Context^);
    End;
    werTextXY:Begin
     WESetKrBorder(R.W);
     WEPutTxtXY(R.W,PE^.Data.txX,PE^.Data.txY,PE^.Data.txMsg);
    End;
    werTree:Begin
     DTRefresh(PE^.Data.wtTree);
    End;
    werListBox,werList:Begin
     LMRefresh(PE^.Data.lbLM);
    End;
    werImage:Begin
     If Not(FX)Then RIPutImage(PE^.Data.ioOneImage,PE^.Data.ioX,PE^.Data.ioY,0,0)
     Else RIPutImage{Juxtap}(PE^.Data.ioImage.Anim^[PE^.Data.ioCurrImage],
                      PE^.Data.ioX,PE^.Data.ioY,0,0{,[]});
    End;
   End
    Else
   Case(PE^.SerialNumber)of
    werKeyDown:Begin
     WEPutkHorDn(R.W,PE^.Data.kdKey);
    End;
   End;
  End
   Else
  Break;
  ALNext(R.R);
 End;
 If(@R.ExternInit.Proc<>NIL)Then Begin
  R.ExternInit.Proc(R,R.ExternInit.Context^);
 End;
End;

Procedure ListBoxOnMove(Var Context);
Var
 R:ResourceWindow Absolute Context;
 PE:^ElementWins;
 DP:Word;
 I:Integer;
Begin
 PE:=_ALGetBuf(R.R,R.P);
 DP:=LMGetVal(PE^.Data.lbLM);
 If(PE^.Data.lbPValue^.Value<>DP)Then Begin
  PE^.Data.lbPValue^.Value:=DP;
  ALSetPtr(R.R,0);
  For I:=0to R.R.Count-1do Begin
   PE:=_ALGetCurrBuf(R.R);
   If(PE^.SerialNumber=werListBox)and
     (Pointer(@PE^.Data.lbPValue^.OnMove)<>NIL)Then Begin
    PE^.Data.lbPValue^.OnMove(PE^.Data.lbLM,PE^.Data.lbPValue^.Context^);
   End;
   ALNext(R.R);
  End;
 End;
End;

Var
 OldBackKbd:Procedure;
 OldTime:Byte;

Procedure AnimBackKbd;Far;
Var
 CurrTime:Byte;
 PE:^ElementWins;
 I:Integer;
Begin
 OldBackKbd;
 CurrTime:=(GetRawTimerB and$F)shr 2;
 If(CurrTime<>OldTime)Then Begin
  ALSetPtr(CurrResWins^.R,0);
  For I:=0to CurrResWins^.R.Count-1do Begin
   PE:=_ALGetCurrBuf(CurrResWins^.R);
   If(PE^.Page=CurrResWins^.CurrPage)and(PE^.SerialNumber=werImage)Then Begin
    PE:=_ALGetCurrBuf(CurrResWins^.R);
    RIPutImage(PE^.Data.ioImage.Anim^[PE^.Data.ioCurrImage],
               PE^.Data.ioX,PE^.Data.ioY,0,0);
    If(PE^.Data.ioCurrImage>=PE^.Data.ioImage.NumAnim)Then Begin
     PE^.Data.ioCurrImage:=0;
    End
     Else
    Inc(PE^.Data.ioCurrImage);
   End;
   ALNext(CurrResWins^.R);
  End;
  OldTime:=CurrTime;
 End;
End;

Procedure WERSelectFile(Var R:ResourceWindow;Var PE:ElementWins);
Var
 S:String;
Begin
 S:=OpenWin(Path2Dir(PE.Data.fi.PValue^)+'*.*','Choisissez un fichier');
 If S<>''Then PE.Data.fi.PValue^:=S;
End;

Function WERRun(Var R:ResourceWindow):Boolean;
Label RestartScrollBar,KeyDown,KeyHori,Restart,MouseKeyDown;
Var
 PE:^ElementWins;
 DP,K:Word;
 I:Integer;
 OldP,MX,MY:Byte;
 XM,YM,MB:Word;
 J:Integer;
 TX,TY:Byte;        { Position de base texte }
 TX1,TY1,TP:Byte;
 OldValue:Boolean;

 Procedure AssignPos;Begin
  Case(PE^.SerialNumber)of
   werInputByte..werInputReal,werInputString,werInputFile,
   werClickBox,werKeyHori,werInputCountry:Begin
    TX1:=PE^.Data.iwX1;
    TY1:=PE^.Data.iwY;
   End;
   werListBox,werList:Begin
    TX1:=PE^.Data.lbLM.W.T.X1-WEGetRX1(R.W);
    TY1:=PE^.Data.lbLM.W.T.Y1-WEGetRY1(R.W);
   End;
   werRadioButton:Begin
    TX1:=PE^.Data.rbDial.X;
    TY1:=PE^.Data.rbDial.Y;
   End;
   werColorGrid:Begin
    TX1:=PE^.Data.cg.X;
    TY1:=PE^.Data.cg.Y;
   End;
   werScrollBar:Begin
    TX1:=PE^.Data.sbData.X1;
    TY1:=PE^.Data.sbData.Y;
   End;
   werTree:Begin
    TX1:=PE^.Data.wtTree.W.T.X1;
    TY1:=PE^.Data.wtTree.W.T.Y1;
   End;
  End;
 End;

Begin
 WERRun:=False;
 CurrResWins:=@R;
 If(R.Anim)Then Begin
  OldBackKbd:=_BackKbd;
  _BackKbd:=AnimBackKbd;
 End;
 If R.R.Count>0Then Begin
  Repeat
   If Not(R.NotFirstTime)Then Begin
    WERPutPage(R);
    PE:=_ALGetCurrBuf(R.R);
    R.NotFirstTime:=True;
   End;
Restart:
   OldP:=R.P;
   PE:=_ALGetBuf(R.R,R.P);
   If(PE<>NIL)and(PE^.Page=R.CurrPage)Then Case(PE^.SerialNumber)of
    werPage,werImage,werBarHori:Begin
     K:=kbTab;
    End;
    werInputByte..werInputReal:Begin
     K:=WEInputVariant(R.W,PE^.Data.ibX1,PE^.Data.ibY,
                      PE^.Data.ibX2,PE^.Data.ibLen,
                      PE^.SerialNumber,PE^.Data.ibPValue^);
     If(@PE^.Data.ibOnChange<>NIL)Then PE^.Data.ibOnChange(R,PE^.Data.ibContext^);
    End;
    werInputFile:Begin
     MX:=LastMouseX-WEGetRX1(R.W);
     MY:=LastMouseY-WEGetRY1(R.W);
     If(MY=PE^.Data.fi.Y)and(MX>=PE^.Data.fi.X2-3)and(MX<=PE^.Data.fi.X2)Then Begin
      WERSelectFile(R,PE^);
     End
      Else
     K:=WEInputString(R.W,PE^.Data.fi.X1,PE^.Data.fi.Y,
                      PE^.Data.fi.X2-3,PE^.Data.fi.Len,PE^.Data.fi.PValue^);
     WERPutInput(R,PE^);
    End;
    werInputString:Begin
     MX:=PE^.Data.IStr.X2;
     If(PE^.Data.IStr.PKey<>NIL)Then Dec(MX,2);
     K:=WEInputString(R.W,PE^.Data.IStr.X1,PE^.Data.IStr.Y,
                      MX,PE^.Data.ibLen,PE^.Data.IStr.PValue^);
     If(PE^.Data.IStr.PKey<>NIL)Then UpIcon(WEGetRX1(R.W)+PE^.Data.iwX2-1,
             WEGetRY1(R.W)+PE^.Data.iwY,$F);
    End;
    werInputCountry:Begin
     WERSelectCountry(R,PE^);
     K:=kbTab;
    End;
    werClickBox:Begin
     WESetKrBorder(R.W);
     TP:=0;
     OldValue:=PE^.Data.cbPValue^;
     K:=WERunItem(R.W,PE^.Data.cbX+1,PE^.Data.cbY,TP,0,1,PE^.Data.cbPValue^);
     If(OldValue<>PE^.Data.cbPValue^)Then Begin
      If(IsGrf)Then Begin
       WEGrafItem(R.W,PE^.Data.cbX,PE^.Data.cbY,PE^.Data.cbPValue^);
      End;
      If(@PE^.Data.cbOnPress<>NIL)Then Begin
       If PE^.Data.cbOnPress(R,PE^.Data.cbContext^)Then WERPutPage(R);
      End;
     End;
    End;
    werRadioButton:Begin
     SetAllKr(R.W.Palette.Border,R.W.Palette.High);
     PE^.Data.rbDial.OnWait:=R.W.BackWait;
     PE^.Data.rbDial.OnWaitContext:=R.W.Context;
     K:=SOSelect(PE^.Data.rbDial);
     PE^.Data.rbPValue^:=SOGetPos(PE^.Data.rbDial);
    End;
    werKeyHori:Begin
KeyHori:
     K:=WEGetkHor(R.W,PE^.Data.khX,PE^.Data.khY,
                  PE^.Data.khLen,PE^.Data.khKey);
     Case(K)of
      0:Begin
       K:=kbEnter;
       If(@PE^.Data.khPValue^.OnPress<>NIL)Then
        PE^.Data.khPValue^.OnPress(R,PE^.Data.khPValue^.Context^);
      End;
      251:K:=kbShiftTab;
      252:K:=kbInWn;
      254:K:=kbTab;
      255:K:=kbEsc;
     End;
     WEPutkHor(R.W,PE^.Data.khX,PE^.Data.khY,PE^.Data.khLen,PE^.Data.khKey);
    End;
    werKeyDown:Begin
KeyDown:
     K:=WEGetkHorDn(R.W,PE^.Data.kdKey);
     If(PE^.Data.kdPValue<>NIL)and(K<10)Then PE^.Data.kdPValue^:=K;
    End;
    werColorGrid:K:=WERRunColorGrid(R,PE^.Data.cg);
    werColorCube:Begin
     K:=WEReadk(R.W);
     If(K=kbInWn)and WEMouseInZone(R.W,PE^.Data.ccX,PE^.Data.ccY,PE^.Data.ccL,PE^.Data.ccH)Then Begin
      GetMouseSwitch(XM,YM,MB);
      __HideMousePtr;
      Color2RGB(GetPixel(XM,YM),PE^.Data.ccData^.Color);
      If(Pointer(@PE^.Data.ccData^.OnClick)<>NIL)Then PE^.Data.ccData^.OnClick(R,PE^.Data.ccData^.Context^);
      WaitMouseBut0;
      __ShowMousePtr;
     End;
    End;
    werList:Begin
     CurrList:=@PE^.Data.listLM;
     K:=LMRunKbd(PE^.Data.listLM);
     If(K<PE^.Data.listLM.List.Count)Then K:=$F000;
     LMSelBarInactive(PE^.Data.listLM);
    End;
    werListBox:Begin
     If(Pointer(@PE^.Data.lbLM.OnMove)=NIL)Then Begin
      PE^.Data.lbLM.OnMove:=ListBoxOnMove;
      PE^.Data.lbLM.Context:=@R;
     End;
     K:=LMRunKbd(PE^.Data.lbLM);
     If(K<PE^.Data.lbLM.List.Count)Then K:=$F000;
     LMSelBarInactive(PE^.Data.lbLM);
    End;
    werTree:Begin
     K:=DTRun(PE^.Data.wtTree);
    End;
    werScrollBar:Begin
RestartScrollBar:
     If(PE^.Data.sbData.NoNum)Then Begin
      Repeat
       K:=WEReadk(R.W);
       If(PE^.Data.sbFormat=werInputByte)Then I:=PE^.Data.sb.PValueByte^
                                         Else I:=PE^.Data.sb.PValueWord^;
       Case(K)of
        kbLeft:If I>0Then Dec(I);
        kbRight:If(I<PE^.Data.sbData.Max)Then Inc(I);
        Else Break;
       End;
       Case(PE^.Data.sbFormat)of
        werInputByte:PE^.Data.sb.PValueByte^:=I;
        Else PE^.Data.sb.PValueWord^:=I;
       End;
       If Not(PE^.Data.sbData.NoNum)Then
        WEPutTxtXY(R.W,PE^.Data.sbData.X1,PE^.Data.sbData.Y,Left(WordToStr(I),5));
      Until True;
     End
      Else
     Begin
      K:=WEInputVariant(R.W,PE^.Data.sbData.X1,PE^.Data.sbData.Y,
                        PE^.Data.sbData.X1+5,6,PE^.Data.sbFormat,
                        PE^.Data.sb.PValueWord^);
      If(PE^.Data.sbFormat=werInputByte)Then I:=PE^.Data.sb.PValueByte^
                                        Else I:=PE^.Data.sb.PValueWord^;
     End;
     If(K=kbInWn)or(K=kbMouse)Then Begin
      If(LastMouseX-WEGetRX1(R.W)>=PE^.Data.sbX1)and
        (PE^.Data.sbData.Y=LastMouseY-WEGetRY1(R.W))and
        (LastMouseX-WEGetRX1(R.W)<=PE^.Data.sbData.X2)Then Begin
       If(LastMouseX-WEGetRX1(R.W)<=PE^.Data.sbX1+1)Then Begin
        If(I>PE^.Data.sbData.Min)Then Dec(I);
       End
        Else
       If(LastMouseX-WEGetRX1(R.W)>=PE^.Data.sbData.X2-1)Then Begin
        If(I<PE^.Data.sbData.Max)Then Inc(I);
       End
        Else
       Begin
        TP:=$FF;
        Repeat
         __GetMouseTextSwitch(MX,MY,MB);
         If MX<=WEGetRX1(R.W)+PE^.Data.sbX1+1Then I:=0 Else
         If MX>=WEGetRX1(R.W)+PE^.Data.sbData.X2-2Then I:=$FF
          Else
         I:=Trunc((MX-WEGetRX1(R.W)-(PE^.Data.sbX1+2))*(
             (PE^.Data.sbData.Max-PE^.Data.sbData.Min)/
             (PE^.Data.sbData.X2-(PE^.Data.sbX1+5))))+PE^.Data.sbData.Min;
         If(I>=PE^.Data.sbData.Max-PE^.Data.sbData.Min)Then I:=PE^.Data.sbData.Max-PE^.Data.sbData.Min;
         If(TP<>I)Then Begin
          __HideMousePtr;
          Case(PE^.Data.sbFormat)of
           werInputByte:PE^.Data.sb.PValueByte^:=I;
           Else PE^.Data.sb.PValueWord^:=I;
          End;
          WERUpdateCompat(R,PE^,I);
          If Not(PE^.Data.sbData.NoNum)Then
           WEPutTxtXY(R.W,PE^.Data.sbData.X1,PE^.Data.sbData.Y,Left(WordToStr(I),5));
          TP:=I;
          __ShowMousePtr;
         End;
         _BackKbd;
        Until MB=0;
        __HideMousePtr;
       End;
       Case(PE^.Data.sbFormat)of
        werInputByte:PE^.Data.sb.PValueByte^:=I;
        Else PE^.Data.sb.PValueWord^:=I;
       End;
       If Not(PE^.Data.sbData.NoNum)Then
        WEPutTxtXY(R.W,PE^.Data.sbData.X1,PE^.Data.sbData.Y,Left(WordToStr(I),5));
       __GetMouseTextSwitch(MX,MY,MB);
       If MB>0Then WaitMouseBut0;
      End;
     End;
     WERUpdateCompat(R,PE^,I);
     If(PE^.Data.sbData.NoNum)and((K=kbLeft)or(K=kbRight))Then Goto RestartScrollBar;
    End;
   End
    Else
   Begin
    Case(PE^.SerialNumber)of
     werKeyDown:Goto KeyDown;
     werKeyHori:Goto KeyHori;
     Else Begin
      If R.NumPage=0Then K:=kbAbort
       Else
      Begin
       K:=0;
       Inc(R.P);
      End;
     End;
    End;
   End;
   If(K=kbMouse)Then Begin
    If WEInCloseIcon(R.W,LastMouseX,LastMouseY)Then Begin
     K:=kbClose;
     WaitMouseBut0;
    End
     Else
    If WEInWindow(R.W,LastMouseX,LastMouseY)Then K:=kbInWn;
   End;
   Case(K)of
    kbEsc,kbClose,kbAbort:Break;
    kbShiftTab,kbLeft,kbCtrlLeft:Begin
     If R.P=0Then R.P:=R.R.Count-1
             Else Dec(R.P);
    End;
    kbCtrlRight,kbRight,kbTab:Begin
     Inc(R.P);
     If(R.P=R.R.Count)Then R.P:=0;
    End;
    kbInWn:Begin
      { Recherche une position correspondante … la demande souris de
       l'utilisateur...}
     ALSetPtr(R.R,0);
     For I:=0to R.R.Count-1do Begin
      PE:=_ALGetCurrBuf(R.R);
      If(PE<>NIL)Then Begin
       TX:=WEGetRX1(R.W);
       TY:=WEGetRY1(R.W);
       If(PE^.Page=R.CurrPage)Then Case(PE^.SerialNumber)of
        werInputByte..werInputReal,werInputString:
        If(LastMouseX-TX>=PE^.Data.iwX1)and
         (LastMouseY-TY=PE^.Data.iwY)and
         (LastMouseX-TX<=PE^.Data.iwX2)Then Begin
         R.P:=I;
         If(PE^.Data.IStr.PKey<>NIL)and(WEMouseInZone(R.W,PE^.Data.IStr.X2-1,PE^.Data.IStr.Y,2,1))Then Begin
          PE^.Data.IStr.PValue^:=WERSelectHistory(R,PE^.Data.IStr.X2,
                                PE^.Data.IStr.Y-1,PE^.Data.IStr.PKey^,PE^.Data.IStr.PValue^);
          WERPutInput(R,PE^);
         End;
         WaitMouseBut0;
        End;
        werInputCountry,werInputFile:Begin
         If(LastMouseX-TX>=PE^.Data.InputCountry.X1)and
          (LastMouseY-TY=PE^.Data.InputCountry.Y)and
          (LastMouseX-TX<=PE^.Data.InputCountry.X2)Then Begin
          R.P:=I;
         End;
         WaitMouseBut0;
        End;
        werClickBox:If WEMouseInZone(R.W,PE^.Data.cbX+1,PE^.Data.cbY,1,1)Then R.P:=I;
        werListBox,werList:If(LastMouseX>=PE^.Data.lbLM.W.T.X1)and
                     (LastMouseY>=PE^.Data.lbLM.W.T.Y1)and
                     (LastMouseX<=PE^.Data.lbLM.W.T.X2)and
                     (LastMouseY<=PE^.Data.lbLM.W.T.Y2)Then Begin
         R.P:=I;
        End;
        werKeyHori:If WEMouseInZone(R.W,PE^.Data.khX,PE^.Data.khY,PE^.Data.khLen,1)Then R.P:=I;
        werKeyDown:MouseKeyDown:If LastMouseY-TY>=R.W.MaxY-3Then Begin
         R.P:=I;
        End;
        werRadioButton:If(LastMouseX>=PE^.Data.rbDial.X1)and
         (LastMouseY>=PE^.Data.rbDial.Y1)and
         (LastMouseX<=PE^.Data.rbDial.X2)and
         (LastMouseY<=PE^.Data.rbDial.Y2)Then Begin
         R.P:=I;
        End;
        werColorGrid:If WEMouseInZone(R.W,PE^.Data.cg.X,PE^.Data.cg.Y,(PE^.Data.cg.Length+1)*3,PE^.Data.cg.Height)Then R.P:=I;
        werColorCube:If WEMouseInZone(R.W,PE^.Data.ccX,PE^.Data.ccY,PE^.Data.ccL,PE^.Data.ccH)Then R.P:=I;
        werScrollBar:If(LastMouseX-TX>=PE^.Data.sbData.X1)and
         (LastMouseY-TY=PE^.Data.sbData.Y)and
         (LastMouseX-TX<=PE^.Data.sbData.X2)Then Begin
         R.P:=I;
        End;
        werTree:If WEInWindow(PE^.Data.wtTree.W,LastMouseX,LastMouseY)Then Begin
         R.P:=I;
        End;
       End
        Else
       If R.NumPage>0Then Begin
        Case(PE^.SerialNumber)of
         werPage:Begin { Recherche sur quel onglet le pointeur de souris … cliquer }
          If WEMouseInZone(R.W,PE^.Data.pgX,1,Length(PE^.Data.pgTitle)+5,1)Then Begin
           WaitMouseBut0;
           R.CurrPage:=PE^.Page;
           WERPutPage(R);
          End;
         End;
         werKeyDown:Goto MouseKeyDown;
        End;
       End;
      End
       Else
      Break;
      ALNext(R.R);
     End;
    End;
    kbCtrlUp,kbUp:Begin
     If R.P=0Then R.P:=R.R.Count-1
      Else
     Begin
      AssignPos;
      ALSetPtr(R.R,R.P-1);
      For J:=R.P-1downto 0do Begin
       PE:=_ALGetCurrBuf(R.R);
       If(PE<>NIL)Then Begin
        If(PE^.Page=R.CurrPage)Then Case(PE^.SerialNumber)of
         werInputByte..werInputReal,werInputString,
         werInputFile,werInputCountry,
         werClickBox,werKeyHori,werColorGrid:
         If(PE^.Data.iwX1<=TX1)and(PE^.Data.iwY<TY1)Then Begin
          R.P:=J;
          Break;
         End;
         werScrollBar:If(PE^.Data.sbData.X1<=TX1)and(PE^.Data.sbData.Y<TY1)Then Begin
          R.P:=J;
          Break;
         End;
        End;
       End
        Else
       Break;
       ALPrevious(R.R);
      End;
      If(R.P<>J)Then R.P:=R.R.Count-1;
     End;
    End;
    kbCtrlDn,kbDn:Begin
     If R.P>=R.R.Count-1Then R.P:=0
      Else
     Begin
      AssignPos;
      ALSetPtr(R.R,R.P+1);
      For J:=R.P+1to R.R.Count-1do Begin
       PE:=_ALGetCurrBuf(R.R);
       If(PE<>NIL)Then Begin
        If(PE^.Page=R.CurrPage)Then Case(PE^.SerialNumber)of
         werInputByte..werInputReal,
         werInputString,werInputFile,werInputCountry,
         werClickBox,werColorGrid:
         If(PE^.Data.iwX1>=TX1)and(PE^.Data.iwY>TY1)Then Begin
          R.P:=J;
          Break;
         End;
         werKeyHori:If(PE^.Data.khY>TY1)Then Begin
          R.P:=J;
          Break;
         End;
         werKeyDown:If(J=R.R.Count-1)and(R.P<>J)Then R.P:=J;
         werListBox,werList:If(PE^.Data.lbLM.W.T.X1>=TX1)and(PE^.Data.lbLM.W.T.Y1>TY1)Then Begin
          R.P:=J;
          Break;
         End;
         werRadioButton:
         If(PE^.Data.rbDial.X1-WEGetRX1(R.W)>=TX1)and
           (PE^.Data.rbDial.Y1-WEGetRY1(R.W)>TY1)Then Begin
          R.P:=J;
          Break;
         End;
         werScrollBar:If(PE^.Data.sbData.X1>=TX1)and(PE^.Data.sbData.Y>TY1)Then Begin
          R.P:=J;
          Break;
         End;
        End;
       End
        Else
       Break;
       ALNext(R.R);
      End;
      If(R.P<>J)Then R.P:=0;
     End;
    End;
    kbEnter:R.P:=R.R.Count-1;
    kbPgUp:If R.NumPage>0Then Begin
     If R.CurrPage>0Then Dec(R.CurrPage)
                    Else R.CurrPage:=R.NumPage-1;
     WERPutPage(R);
    End;
    kbPgDn:If R.NumPage>0Then Begin
     Inc(R.CurrPage);
     If(R.NumPage=R.CurrPage)Then R.CurrPage:=0;
     WERPutPage(R);
    End;
    Else If(PE^.Page>=R.CurrPage)and(PE^.SerialNumber=werKeyDown){and(R.P=R.R.NB-1)}Then Begin
     If K=0Then WERRun:=True;
     Break;
    End;
   End;
   If(@R.OnInput<>NIL)Then R.NotFirstTime:=Not R.OnInput(R.CollectiveSoul^,OldP);
  Until False;
 End;
 If(R.Anim)Then _BackKbd:=OldBackKbd;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Proc‚dure FillArc                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de tracer l'arc d'un cercle dans un intervalle
 radian  donn‚e  de fa‡on  pleine  et ainsi  il rejoindre  le centre du
 centre tel une pointe de tarte.
}

Procedure IFillArc(XO,YO,SAngle,EAngle,Radius,Kr:Word;UpDate:Boolean);Near;
Const
 RadToDeg=180/Pi;
 DegToRad=Pi/180;
Var
 p:Integer;
 x,y,SX,MX:Word;
 Alpha:Real;
 XC,YC:Array[0..1999]of Integer;
 J,I,Index:Integer;

 Procedure PutLn(X1,Y1,X2,Y2:Integer);
 Var
  D,DX,DY,I,J,Ainc,Binc,Ic:Integer;
 Begin
  If(Y2=Y1)Then Begin
   XC[Index]:=X1;YC[Index]:=Y1;Inc(Index);
   XC[Index]:=X2;YC[Index]:=Y2;Inc(Index);
   Exit;
  End;
  If AbsInt(X2-X1)<AbsInt(Y2-Y1)Then Begin
   If(Y1>Y2)Then ASM
    MOV AX,Word Ptr X1
    XCHG AX,Word Ptr X2
    MOV Word Ptr X1,AX
    MOV AX,Word Ptr Y1
    XCHG AX,Word Ptr Y2
    MOV Word Ptr Y1,AX
   END;
   If(X2>X1)Then Ic:=1
            Else Ic:=-1;
   DY:=Y2-Y1;DX:=AbsInt(X2-X1);D:=(DX shl 1)-DY;
   Ainc:=(DX-DY)shl 1;Binc:=DX shl 1;
   J:=X1;
   XC[Index]:=X1;YC[Index]:=Y1;Inc(Index);
   I:=Y1+1;
   While(I<=Y2)do Begin
    If D>=0Then Begin
     Inc(J,Ic);
     Inc(D,Ainc)
    End
     Else
    Inc(D,Binc);
    XC[Index]:=J;YC[Index]:=I;Inc(Index);
    Inc(I);
   End;
  End
   else
  Begin
   If(X1>X2)Then ASM
    MOV AX,Word Ptr X1
    XCHG AX,Word Ptr X2
    MOV Word Ptr X1,AX
    MOV AX,Word Ptr Y1
    XCHG AX,Word Ptr Y2
    MOV Word Ptr Y1,AX
   END;
   If(Y2>Y1)Then Ic:=1
            Else Ic:=-1;
   DX:=X2-X1;DY:=AbsInt(Y2-Y1);
   D:=(DY shl 1)-DX;
   AInc:=(DY-DX)shl 1;BInc:=DY shl 1;
   J:=Y1;
   XC[Index]:=X1;YC[Index]:=Y1;Inc(Index);
   I:=X1+1;
   While(I<=X2)do Begin
    If D>=0Then Begin
     Inc(J,Ic);
     Inc(D,Ainc)
    End
     Else
    Inc(D,Binc);
    XC[Index]:=I;YC[Index]:=J;Inc(Index);
    Inc(I);
   End;
  End;
 End;

Begin
 If Radius=0Then Begin
  SetPixel(XO,YO,Kr);
  Exit;
 End;
 Index:=0;
 If(UpDate)Then Begin
  Inc(SAngle,271);
  Inc(EAngle,271)
 End;
 SAngle:=SAngle mod 361;
 EAngle:=EAngle mod 361;
 If(SAngle>EAngle)Then Begin
  SAngle:=SAngle Xor EAngle;
  EAngle:=EAngle Xor SAngle;
  SAngle:=EAngle Xor SAngle;
 End;
 x:=0;y:=Radius;p:=3-2*Radius;
 While(x<=y)do Begin
  Alpha:=RadToDeg*Arctan(x/y);
  If(Alpha>=SAngle)and(Alpha<=EAngle)Then Begin
   XC[Index]:=XO-x;YC[Index]:=YO-y;Inc(Index)
  End;
  If(90-Alpha>=SAngle)and(90-Alpha<=EAngle)Then Begin
   XC[Index]:=XO-y;YC[Index]:=YO-x;Inc(Index)
  End;
  If(90+Alpha>=SAngle)and(90+Alpha<=EAngle)Then Begin
   XC[Index]:=XO-y;YC[Index]:=YO+x;Inc(Index)
  End;
  If(180-Alpha>=SAngle)and(180-Alpha<=EAngle)Then Begin
   XC[Index]:=XO-x;YC[Index]:=YO+y;Inc(Index)
  End;
  If(180+Alpha>=SAngle)and(180+Alpha<=EAngle)Then Begin
   XC[Index]:=XO+x;YC[Index]:=YO+y;Inc(Index)
  End;
  If(270-Alpha>=SAngle)and(270-Alpha<=EAngle)Then Begin
   XC[Index]:=XO+y;YC[Index]:=YO+x;Inc(Index)
  End;
  If(270+Alpha>=SAngle)and(270+Alpha<=EAngle)Then Begin
   XC[Index]:=XO+y;YC[Index]:=YO-x;Inc(Index)
  End;
  If(360-Alpha>=SAngle)and(360-Alpha<=EAngle)Then Begin
   XC[Index]:=XO+x;YC[Index]:=YO-y;Inc(Index)
  End;
  If p<0Then Inc(p,(x shl 2)+6)
   Else
  Begin
   Inc(p,((x-y)shl 2)+10);
   Dec(y)
  End;
  Inc(x);
 End;
 PutLn(XO,YO,XO-Trunc(Sin(DegToRad*SAngle)*Radius),
       YO-Trunc(Cos(DegToRad*SAngle)*Radius));
 PutLn(XO,YO,XO-Trunc(Sin(DegToRad*EAngle)*Radius),
       YO-Trunc(Cos(DegToRad*EAngle)*Radius));
 QuickSort2(Index-1,XC,YC);
 I:=0;
 While(I<Index)do Begin
  If YC[I]=YC[I+1]Then Begin
   J:=I+1;MX:=XC[I];SX:=XC[I];
   While(YC[I]=YC[J])and(J<Index)do Begin
    If SX>XC[J]Then SX:=XC[J];
    If MX<XC[J]Then MX:=XC[J];
    Inc(J);
   End;
   PutLnHor({XC[I]}SX,YC[I],MX,Kr);
   I:=J;
  End
   Else
  Inc(I);
 End;
End;

Procedure FillArc(XO,YO,SAngle,EAngle,Radius,Color:Word);Near;Begin
 If(SAngle=0)and(EAngle>=359)Then PutFillCircle(XO,YO,Radius,Color)
  Else
 IFillArc(XO,YO,SAngle,EAngle,Radius,Color,False);
End;

Procedure _Arc(XO,YO,SAngle,EAngle,Radius:Word);Near;
Const
 RadToDeg=180/Pi;
Var
 p:Integer;
 x,y:Word;
 Alpha:Real;
Begin
 If Radius=0Then Begin
  _SetPixel(XO,YO);
  Exit;
 End;
 Inc(SAngle,271);Inc(EAngle,271);
 SAngle:=SAngle mod 361;
 EAngle:=EAngle mod 361;
 If(SAngle>EAngle)Then Begin
  SAngle:=SAngle Xor EAngle;
  EAngle:=EAngle Xor SAngle;
  SAngle:=EAngle Xor SAngle;
 End;
 x:=0;y:=Radius;p:=3-2*Radius;
 While(x<=y)do Begin
  Alpha:=RadToDeg*Arctan(x/y);
  If(Alpha>=SAngle)and(Alpha<=EAngle)Then _SetPixel(XO-x,YO-y);
  If(90-Alpha>=SAngle)and(90-Alpha<=EAngle)Then _SetPixel(XO-y,YO-x);
  If(90+Alpha>=SAngle)and(90+Alpha<=EAngle)Then _SetPixel(XO-y,YO+x);
  If(180-Alpha>=SAngle)and(180-Alpha<=EAngle)Then _SetPixel(XO-x,YO+y);
  If(180+Alpha>=SAngle)and(180+Alpha<=EAngle)Then _SetPixel(XO+x,YO+y);
  If(270-Alpha>=SAngle)and(270-Alpha<=EAngle)Then _SetPixel(XO+y,YO+x);
  If(270+Alpha>=SAngle)and(270+Alpha<=EAngle)Then _SetPixel(XO+y,YO-x);
  If(360-Alpha>=SAngle)and(360-Alpha<=EAngle)Then _SetPixel(XO+x,YO-y);
  If p<0Then Inc(p,4*x+6)
   Else
  Begin
   Inc(p,4*(x-y)+10);
   Dec(y)
  End;
  Inc(x);
 End;
End;

Procedure RBAddStrPtr(Var Q:ArrayList;Const Message:String;Ptr:Pointer);
Var
 PLongInt:LongInt Absolute Ptr;
Begin
 ALAddStrLong(Q,Message,PLongInt);
End;

{ Cette proc‚dure permet de d‚compiler le contenu d'une boŒte de dialogue
 afin de l'ex‚cuter...
}

Procedure WERDecompile(Var R:ResourceWindow;Const CodeDPU;Var Output);
Label IncString,ReStart;
Const
 Size:Array[0..6]of Word=(
  0,SizeOf(Byte),SizeOf(Word),
  SizeOf(LongInt),SizeOf(Real),
  0,SizeOf(String)
 );
Var
 Local:Record
  R1:TextCharRec;   { Coordonn‚e de la boŒte de dialogue }
  InList:Boolean;   { Dans une liste? }
  IfPos:Byte;
 End;
 DPUByte:TByte Absolute CodeDPU;
 DPUString:String Absolute CodeDPU;
 DPUCheckBox:Record
  Res:Array[0..2]of Byte;
  Title:String;
 End Absolute CodeDPU;
 GX1,GY1:Word;      { Coordonn‚e graphique temporaire }
 Rayon:Word;        { Rayon du cercle }
 OldKr:Byte;        { Couleur d'attribut temporaire }
 ID:Byte;           { Identificateur }
 X,Y,Len:Byte;      { Position X et Y texte et longueur }
 TS:^String;        { Pointeur de chaŒne temporaire }
 PT:Pointer;        { Pointeur sur une routine }
 OldShade:Boolean;  { Ancienne ‚tat de l'ombre }
 I:Word;            { Compteur de boucle }
 OutputPtr:PtrRec Absolute Output;
 OutputPointer:Pointer Absolute Output;
 OutputString:String Absolute Output;
 OutputBoolean:Boolean Absolute Output;
 OutputByte:Byte Absolute Output;
 OutputWord:Word Absolute Output;
 OutputLong:LongInt Absolute Output;
 ExternInit:Record
  Proc:Procedure(Var R:ResourceWindow;Var Context);
  Context:Pointer;
 End Absolute Output;
 IfCase:Array[0..255]of Boolean;
 T:TextBoxRec;
 G:GraphBoxRec;
Begin
 FillClr(Local,SizeOf(Local));
 IfCase[0]:=True;
 Repeat
ReStart:
  ID:=DPUByte[0];
  ASM INC Word Ptr CodeDPU;END;
  Case(ID)of
   0:Break;
   $12:Begin { END IF}
    If Local.IfPos>0Then Dec(Local.IfPos);
    Goto ReStart;
   End;
   $11:Begin { ELSE }
    IfCase[Local.IfPos]:=Not IfCase[Local.IfPos];
    Goto ReStart;
   End;
   $10:Begin { IF }
    Inc(Local.IfPos);
    IfCase[Local.IfPos]:=OutputBoolean;
    ASM
     INC Word Ptr Output
    END;
    Goto ReStart;
   End;
{  End;
  Case(ID)of}
   1:Begin { SIZE X,Y }
    If IfCase[Local.IfPos]Then Begin
     If Not(R.IsWindowFixed)Then WEInitO(R.W,DPUByte[0],DPUByte[1]);
     If WEInWindow(R.W,LastMouseX,LastMouseY)Then __HideMousePtr;
     WEPushWn(R.W);
     Local.R1.X:=WEGetRX1(R.W);
     Local.R1.Y:=WEGetRY1(R.W);
    End;
    ASM ADD Word Ptr CodeDPU,2;END;
   End;
   2:Begin { WINDOWCOLORCLASSIC }
    If IfCase[Local.IfPos]Then WEPutWnKrDials(R.W,MessageByLanguage(DPUString));
    Goto IncString;
   End;
   3:If IfCase[Local.IfPos]Then WECloseIcon(R.W); { CLOSEICON }
   4:If IfCase[Local.IfPos]Then WELn(R.W); { LN }
   5:If IfCase[Local.IfPos]Then WEBar(R.W); { BARUP }
   6:Begin { TEXT Message }
    If IfCase[Local.IfPos]Then Begin
     WERAddPutTxt(R,R.W.X,R.W.Y,DPUString);
     WELn(R.W);
    End;
    Goto IncString;
   End;
   7:Begin { TEXT (X,Y),Message }
    X:=DPUByte[0];
    ASM INC Word Ptr CodeDPU;END;
    Y:=DPUByte[0];
    ASM INC Word Ptr CodeDPU;END;
    If IfCase[Local.IfPos]Then Begin
     WERAddPutTxt(R,X,Y,DPUString);
    End;
    Goto IncString;
   End;
   8:Begin { TEXT (X),Message }
    R.W.X:=DPUByte[0];
    ASM INC Word Ptr CodeDPU;END;
    If IfCase[Local.IfPos]Then Begin
     WERAddPutTxt(R,R.W.X,R.W.Y,DPUString);
    End;
    Goto IncString;
   End;
   9:Begin { MESSAGE Message }
    WEPutMsg(R.W,DPUString);
    Goto IncString;
   End;
   $A:Begin { SIMPLE GRID(x,y),attribut }
    WEPutColorBox(R.W,DPUByte[0],DPUByte[1],DPUByte[0],DPUByte[1],DPUByte[2]);
    ASM ADD Word Ptr CodeDPU,3;END;
   End;
   $B:Begin { BARHORI (x1,y,x2) }
    WERAddBarHori(R,DPUByte);
    ASM ADD Word Ptr CodeDPU,3;END;
   End;
   $C:Begin { PUT MESSAGE }
    WEPutMsg(R.W,OutputString);
    ASM
     ADD Word Ptr Output,256
    END;
   End;
   $0D:Begin { WINDOWCOLORCLASSIC CAPTION }
    If IfCase[Local.IfPos]Then WEPutWnKrDials(R.W,OutputString);
    ASM
     ADD Word Ptr Output,256
    END;
   End;
   $0E:Begin { SIZE_RELATIVE }
    If IfCase[Local.IfPos]Then Begin
     WEInitO(R.W,Lo(OutputWord),Hi(OutputWord));
     If WEInWindow(R.W,LastMouseX,LastMouseY)Then __HideMousePtr;
     WEPushWn(R.W);
     Local.R1.X:=WEGetRX1(R.W);
     Local.R1.Y:=WEGetRY1(R.W);
    End;
    ASM
     ADD Word Ptr Output,2
    END;
   End;
   $0F:Begin { LOCATE x,y }
    If IfCase[Local.IfPos]Then Begin
     R.W.X:=DPUByte[0];
     R.W.Y:=DPUByte[1];
    End;
    ASM
     ADD Word Ptr CodeDPU,2
    END;
   End;
   $19:Begin { MESSAGE STRING }
    WEPutMsg(R.W,OutputString);
    ASM
     ADD Word Ptr Output,256
    END;
   End;
   $21:Begin { TREE (X1,Y1)-(X2,Y2) }
    WERAddTree(R,DPUByte,Output);
    ASM
     ADD Word Ptr CodeDPU,4
     ADD Word Ptr Output,8
    END;
   End;
   $31:Begin { COLORCUBE }
    WERAddColorCube(R,DPUByte,Output);
    ASM
     ADD Word Ptr CodeDPU,4
     ADD Word Ptr Output,3
    END;
   End;
   $43:Begin { CAPTION LONG }
    X:=DPUByte[0];
    ASM INC Word Ptr CodeDPU;END;
    Y:=DPUByte[0];
    ASM INC Word Ptr CodeDPU;END;
    OldKr:=R.W.CurrColor;
    Len:=DPUByte[0];
    ASM INC Word Ptr CodeDPU;END;
    If IfCase[Local.IfPos]Then Begin
     WESetKrHigh(R.W);
     WERAddPutTxt(R,X,Y,CStr(OutputLong));
     R.W.CurrColor:=OldKr;
    End;
    ASM { Inc LongInt Output }
     ADD Word Ptr Output,4
    END;
   End;
   $46:Begin { CAPTION STRING }
    X:=DPUByte[0];
    ASM INC Word Ptr CodeDPU;END;
    Y:=DPUByte[0];
    ASM INC Word Ptr CodeDPU;END;
    OldKr:=R.W.CurrColor;
    Len:=DPUByte[0];
    ASM INC Word Ptr CodeDPU;END;
    If IfCase[Local.IfPos]Then Begin
     WESetKrHigh(R.W);
     If Y=$FFThen Y:=R.W.Y;
     WERAddPutTxt(R,X,Y,OutputString);
     R.W.CurrColor:=OldKr;
    End;
    ASM { Inc String Output }
     MOV AL,Len
     XOR AH,AH
     INC AX
     ADD Word Ptr Output,AX
    END;
   End;
   $4F:Begin { CAPTION COPY }
    MoveLeft(CodeDPU,R.XCS,8*SizeOf(Byte));
    ASM
     ADD Word Ptr CodeDPU,8
    END;
   End;
   $70:Begin { EXTERNAL PROCESSUS }
    If IfCase[Local.IfPos]Then Begin
     If(OutputPointer<>NIL)Then Begin
      If R.NumPage=0Then ExternInit.Proc(R,ExternInit.Context^)
                    Else MoveLeft(ExternInit,R.ExternInit,SizeOf(ExternInit));
     End;
    End;
    ASM
     ADD Word Ptr Output,8
    END;
   End;
   $71:Begin { LIST }
    Local.InList:=True;
    If IfCase[Local.IfPos]Then WERAddList(R,DPUByte);
    ASM
     {$IFDEF FLAT386}
      MOV AX,4+1
      LEA EDX,CodeDPU
      ADD AL,Byte Ptr [EDX+4]
      ADD Word Ptr CodeDPU,AX
     {$ELSE}
      MOV AX,4+1
      LES DI,CodeDPU
      ADD AL,Byte Ptr ES:[DI+4]
      ADD Word Ptr CodeDPU,AX
     {$ENDIF}
    END;
   End;
   $72:Begin { END LIST }
    Local.InList:=False;
   End;
   $80:Begin { INPUT COUNTRY }
    If IfCase[Local.IfPos]Then WERAddInputCountry(R,DPUByte,@Output);
    ASM
     ADD Word Ptr DPUByte,4
     ADD Word Ptr Output,2
    END;
   End;
   $81..$84,$86,      { INPUT BYTE, WORD, LONG, REAL, STRING }
   $A1..$A4,$A6:Begin { INPUT EXTERN BYTE, WORD, LONG, REAL, STRING }
    If IfCase[Local.IfPos]Then WERAddInput(R,DPUByte,ID and$2F,@Output);
    ASM
     {$IFDEF FLAT386}
      CMP ID,86h
      JNE @Normal
      LEA EDX,CodeDPU
      MOVZX AX,Byte Ptr [EDX+3]
      INC AX
      JMP @Set
 @Normal:
      MOV AL,ID
      AND EAX,000Fh
      SHL EAX,1
      MOV AX,Word Ptr Size[EAX]
 @Set:ADD Word Ptr Output,AX
      ADD Word Ptr CodeDPU,4
     {$ELSE}
      CMP ID,86h
      JNE @Normal
      LES DI,CodeDPU
      MOV AL,ES:[DI+3]
      XOR AH,AH
      INC AX
      JMP @Set
 @Normal:
      MOV BL,ID
      AND BX,000Fh
      SHL BX,1
      MOV AX,Word Ptr Size[BX]
 @Set:ADD Word Ptr Output,AX
      MOV AX,4+1
      LES DI,DPUByte
      ADD AL,Byte Ptr ES:[DI+4]
      ADD Word Ptr CodeDPU,AX
     {$ENDIF}
    END;
    If ID and$20=$20Then ASM
     ADD Word Ptr Output,8
    END;
   End;
   $85:Begin { KEYHORIDOWN }
    Y:=0;
    For X:=1to Length(DPUString)do Begin
     Case DPUString[X]of
      '|':Inc(Y);
      '³':Break;
     End;
    End;
    If Y>1Then Begin
     If IfCase[Local.IfPos]Then WERAddkHorDnExt(R,DPUString,@Output);
     ASM
      INC Word Ptr Output
     END;
    End
     Else
    If IfCase[Local.IfPos]Then WERAddkHorDnExt(R,DPUString,NIL);
IncString:
    ASM
     {$IFDEF FLAT386}
      LEA EAX,DWord Ptr CodeDPU
      MOVZX AX,Byte Ptr [EAX]
      INC AX
      ADD Word Ptr CodeDPU,AX
     {$ELSE}
      LES DI,DWord Ptr CodeDPU
      MOV AL,Byte Ptr ES:[DI]
      XOR AH,AH
      INC AX
      ADD Word Ptr CodeDPU,AX
     {$ENDIF}
    END;
   End;
   $87:Begin { LISTBOX }
    If IfCase[Local.IfPos]Then WERAddListBox(R,CodeDPU,@Output);
    ASM ADD Word Ptr Output,14;END;
    ASM ADD Word Ptr CodeDPU,5;END;
    Goto IncString;
   End;
   $88:Begin { SCROLLBAR }
    If IfCase[Local.IfPos]Then WERAddScrollBar(R,CodeDPU,@Output);
    If DPUByte[1]or DPUByte[3]=0Then ASM INC Word Ptr Output;END
                                Else ASM ADD Word Ptr Output,2;END;
    ASM ADD Word Ptr Output,8;END;
    ASM ADD Word Ptr CodeDPU,9;END;
   End;
   $89:Begin { INPUT FILE }
    WERAddInputFile(R,DPUByte,@Output);
    ASM
     {$IFDEF FLAT386}
      LEA EDX,CodeDPU
       { Incr‚mente l'espace du chemin du fichier }
      MOV AL,[EDX+3]
      XOR AH,AH
      INC AX
      ADD Word Ptr Output,AX
       { Incr‚mente les donn‚es et la cl‚ }
      MOV AX,4+1
      LEA EDX,DPUByte
      ADD AL,Byte Ptr [EDX+4]
      ADD Word Ptr CodeDPU,AX
     {$ELSE}
      LES DI,CodeDPU
       { Incr‚mente l'espace du chemin du fichier }
      MOV AL,ES:[DI+3]
      XOR AH,AH
      INC AX
      ADD Word Ptr Output,AX
       { Incr‚mente les donn‚es et la cl‚ }
      MOV AX,4+1
      LES DI,DPUByte
      ADD AL,Byte Ptr ES:[DI+4]
      ADD Word Ptr CodeDPU,AX
     {$ENDIF}
    END;
   End;
   $8A:Begin { TABBEDNOTEBOOK }
    Inc(R.NumPage);
    X:=DPUByte[0];
    ASM INC Word Ptr CodeDPU;END;
    If IfCase[Local.IfPos]Then WERAddPage(R,X,DPUString);
    Goto IncString;
   End;
   $8B:Begin { COLORGRID }
    If IfCase[Local.IfPos]Then WERPutColorBar(R,CodeDPU,@Output);
    If DPUByte[4]=1Then ASM ADD Word Ptr Output,4;END;
    ASM
     ADD Word Ptr Output,9
     ADD Word Ptr CodeDPU,5
    End;
   End;
   $8C:Begin { FRAME }
    TS:=@TByte(CodeDPU)[4];
    If IfCase[Local.IfPos]Then Begin
     If R.NumPage>0Then WERAddFrame(R,CodeDPU)
                   Else Frame(R,CodeDPU);
    End;
    ASM
     ADD Word Ptr CodeDPU,4
    END;
    Goto IncString;
   End;
   $6D,$8D:Begin { RADIOBUTTON EXTERN, RADIOBUTTON }
    PT:=NIL;
    TS:=@TByte(CodeDPU)[3];
    X:=DPUByte[0];
    Y:=DPUByte[1];
    Len:=DPUByte[2];
    If ID=$6DThen Begin
     PT:=OutputPointer;
     ASM
      ADD Word Ptr Output,4
     END;
    End;
    ASM
     {$IFDEF FLAT386}
      ADD Word Ptr CodeDPU,3
      LEA EAX,DWord Ptr CodeDPU
      MOVZX AX,Byte Ptr [EAX]
      INC AX
      ADD Word Ptr CodeDPU,AX
     {$ELSE}
      ADD Word Ptr CodeDPU,3
      LES DI,DWord Ptr CodeDPU
      MOV AL,Byte Ptr ES:[DI]
      XOR AH,AH
      INC AX
      ADD Word Ptr CodeDPU,AX
     {$ENDIF}
    END;
    If IfCase[Local.IfPos]Then WERAddRadioButton(R,TS^,DPUString,X,Y,Len,@Output,PT);
    ASM
     INC Word Ptr Output
    END;
    Goto IncString;
   End;
   $8E:Begin { KEYHORI (X,Y),Longueur,message }
    TS:=@TByte(CodeDPU)[3];
    If IfCase[Local.IfPos]Then WERAddkHor(R,TS^,DPUByte[0],DPUByte[1],DPUByte[2],@Output);
    ASM
     ADD Word Ptr Output,8
     ADD Word Ptr CodeDPU,3
    END;
    Goto IncString;
   End;
   $6F,$8F:Begin { CHECKBOX }
    TS:=@TByte(CodeDPU)[3];
    If ID=$6FThen Begin
     PT:=@OutputPointer;
     ASM
      ADD Word Ptr Output,8
     END;
    End
     Else
    PT:=NIL;
    If IfCase[Local.IfPos]Then Begin
     If(Local.InList)Then Begin
      RBAddStrPtr(CurrList^.List,DPUCheckBox.Title,@OutputByte);
     End
      Else
     WERAddClickBox(R,TS^,DPUByte[0],DPUByte[1],DPUByte[2],@Output,PT);
    End;
    ASM
     INC Word Ptr Output
     ADD Word Ptr CodeDPU,3
    END;
    Goto IncString;
   End;
   $91..$94,$96:Begin { GHOST BYTE,WORD,LONG,REAL,STRING }
    ASM
     {$IFDEF FLAT386}
      MOV AL,ID
      AND EAX,000Fh
      SHL EAX,1
      MOV AX,Word Ptr Size[EAX]
      ADD Word Ptr Output,AX
     {$ELSE}
      MOV BL,ID
      AND BX,000Fh
      SHL BX,1
      MOV AX,Word Ptr Size[BX]
      ADD Word Ptr Output,AX
     {$ENDIF}
    END;
   End;
   $B0:Begin { SECTORIAL }
    GX1:=(((DPUByte[2]-DPUByte[0])shr 1)+Local.R1.X+DPUByte[0])shl 3;
    GY1:=GetRawY(((DPUByte[3]-DPUByte[1])shr 1)+Local.R1.Y+DPUByte[1])+(HeightChr shr 1);
    Rayon:=(DPUByte[2]-DPUByte[0])shl 2;
    PutFillCircle(GX1,GY1,Rayon,DPUByte[5]);
    For I:=2to DPUByte[4]do Begin
     If(OutputWord>180)and(DPUByte[4]=2)Then Begin
      PutFillCircle(GX1,GY1,Rayon,DPUByte[4+I]);
      FillArc(GX1,GY1,0,360-OutputWord,Rayon,DPUByte[5]);
     End
      Else
     FillArc(GX1,GY1,0,OutputWord,Rayon,DPUByte[4+I]);
     ASM ADD Word Ptr Output,2;END;
    End;
    Circle(GX1,GY1,Rayon,Black);
    _SetKr(White);
    _Arc(GX1,GY1,45,220,Rayon);
    ASM
     {$IFDEF FLAT386}
      LEA EDX,CodeDPU
      MOVZX AX,Byte Ptr [EDX+4]
      ADD AX,5
      ADD Word Ptr CodeDPU,AX
     {$ELSE}
     LES DI,CodeDPU
     MOV AL,Byte Ptr ES:[DI+4]
     XOR AH,AH
     ADD AX,5
     ADD Word Ptr CodeDPU,AX
     {$ENDIF}
    END;
   End;
   $B1:Begin
    MoveLeft(CodeDPU,T,4*SizeOf(Byte));
    ASM
     {Inc(T.X1,R1.X);Inc(T.Y1,R1.Y);Inc(T.X2,R1.X);Inc(T.Y2,R1.Y);}
     MOV AX,Local.R1
     ADD Word Ptr T.X1,AX
     ADD Word Ptr T.X2,AX
    END;
    CoordTxt2Graph(T,G);
    Dec(G.X1);Dec(G.Y1);Inc(G.X2);Inc(G.Y2);
    __GraphBoxRelief(G,0);
    ASM
     ADD Word Ptr CodeDPU,4
    END;
   End;
   $C0:Begin { IMAGE }
    If(MediaSupport)Then WERAddImage(R,CodeDPU);
    ASM
     {$IFDEF FLAT386}
      ADD Word Ptr CodeDPU,4
      LEA EDX,CodeDPU
      MOVZX AX,Byte Ptr [EDX]
      INC AX
      ADD Word Ptr CodeDPU,AX
     {$ELSE}
      ADD Word Ptr CodeDPU,4
      LES DI,CodeDPU
      MOV AL,ES:[DI]
      XOR AH,AH
      INC AX
      ADD Word Ptr CodeDPU,AX
     {$ENDIF}
    END;
   End;
   Else Break;
  End;
 Until False;
End;

Procedure WERLoad(Var R:ResourceWindow;Const Name:String;Index:Word;Var Output);
Var
 Ptr:Pointer;
 Size:Word;
Begin
 Ptr:=AllocFunc(Index,Name,Size);
 If(Ptr=NIL)Then __OutOfMemory
  Else
 Begin
  WERDecompile(R,Ptr^,Output);
  FreeMemory(Ptr,Size);
 End;
End;

Procedure WERLoadApp(Var R:ResourceWindow;Index:Word;Var Output);Begin
 WERLoad(R,'APP7ILES.*',Index,Output);
End;

{ Cette proc‚dure ex‚cute le code ®Dial Processor Unit¯.
}

Function RunDPU(Const CodeDPU;Var Output):Boolean;
Var
 R:ResourceWindow;
Begin
 WERInit(R);
 WERDecompile(R,CodeDPU,Output);
 RunDPU:=WERRun(R);
 WERDone(R);
End;

{ Cette fonction appel un menu contenu dans la bibliothŠque d'application
 ®APP7ILES.RLL¯.
}

Function RunMenuApp(Index:Word):Word;
Var
 PL:Array[0..0]of Pointer;
Begin
 RunMenuApp:=_RunMenuApp(Index,PL);
End;

Function _RunMenuApp(Index:Word;Var Ptr):Word;
Var
 CM:ContextMenu;
 TM:MainMnuPtr;
 K:Word;
Begin
 WaitMouseBut0;
 __HideMousePtr;
 _CMLoadApp(CM,Index,Ptr);
 ALSetPtr(MainMenu.Mnu,0);
 TM:=_ALGetCurrBuf(MainMenu.Mnu);
 K:=PMExecMnu(LastMouseX,LastMouseY+1,TM^.Lst,TM^.P);
 CMDone(CM);
 Case(K)of
  kbMouse:Begin
   __ShowMousePtr;
   WaitMouseBut0;
  End;
 End;
 _RunMenuApp:=K;
End;

Function ExecuteDPU(Const Name:String;Index:Word;Var Output):Boolean;
Var
 Size:Word;
 Ptr:Pointer;
 XCur,YCur:Byte;
Begin
 XCur:=GetXCurPos;YCur:=GetYCurPos;
 Ptr:=AllocFunc(Index,Name,Size);
 If(Ptr=NIL)Then __OutOfMemory
  Else
 Begin
  ExecuteDPU:=RunDPU(Ptr^,Output);
  FreeMemory(Ptr,Size);
 End;
 SetCurPos(XCur,YCur);
End;

Function ExecuteAppDPU(Index:Word;Var Output):Boolean;Begin
 ExecuteAppDPU:=ExecuteDPU('APP7ILES.*',Index,Output);
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
END.