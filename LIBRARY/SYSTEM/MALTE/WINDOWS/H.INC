{$I DEF.INC}
{$IFDEF UnitH}
 Uses Systex,Isatex,Systems,Dialex,DialPlus,TMDials,ToolView,Memories;
{$ENDIF}

Const
  { Code de reconnaissance des diff‚rentes fenˆtres d'application }
 wnEmpty=0;        { Ce n'est pas une fenˆtre }
 wnMin=1;          { Code de fenˆtre minimum }
 wnMx=22;          { Code de la derniŠre fenˆtre (maximum) }

 wnEdit=1;         { diteur de traŒtement de texte: Document, Pascal, C,...}
 wnView=2;         { Regarde ASCII }
 wnIcn=3;          { diteur d'Icon graphique }
 wnDraw=4;         { Programme de dessin }
 wnLotus=5;        { Chiffrier ‚lectronique, tableur }
 wnFileManager=6;  { Gestionnaire de fichiers }
 wnPrmpt=7;        { Prompt de style DOS }
 wnTerm=8;         { Terminal de communication modem }
 wnUnix=9;         { Prompt de style Unix }
 wnHexView=10;     { diteur Hexad‚cimal }
 wnOutput=11;      { cran de sortie }
 wnMusicMod=12;    { diteur de .MOD }
 wnMacro=13;       { diteur de Macro }
 wnPC=14;          { Watch, Calculatrice Programmable }
 wnCalculator=15;  { Calculatrice ordinaire }
 wnCalendriar=16;  { Calendrier }
 wnAgenda=17;      { Agenda }
 wnCatDisk=18;     { Catalogue de disquette }
 wnMnu=19;         { Menu d'application }
 wnFont=20;        { diteur de Police}
 wnBudget=21;      { Budget }
 wnDebug=22;       { D‚bogueur de programme (PowerHacken seulement) }
 wnAnim=23;        { Fenˆtre d'animation 3 dimensions }

 KrTapis:Byte=$19;
 UpDateMnu:Procedure=Ret;

Type
  { Enregistrement de fenˆtre d'application }
 WinRec=Record
  Model:Byte;                { Le modŠle de fenˆtre: constante wn??? }
  {$IFDEF H}
   BW:Window;                { Pour sauvegarder l'arriŠre plan de la fenˆtre }
  {$ENDIF} 
  OX1,OY1,OX2,OY2:Byte;      { Pour le Zoom...}
  P:Record Case Byte of      { En cas de modŠle de fenˆtre de:}
   {$IFNDEF OnlyAnim}
   1:(Edit:EditorApp);       { TraŒtement de texte, ‚diteur texte }
   2:(ViewAscii:ViewAsciiApp);{ Regarde rapidement en ASCII }
   3:(IcnEdt:IconEditApp);   { diteur d'Icon }
   4:(DrawEdit:DrawEditApp); { Programme de dessin }
   5:(Lotus:SuperCalcApp);   { Chiffrier ‚lectronique, tableur }
   6:(FM:FileManagerApp);    { Gestionnaire de fichiers }
   7:(Shell:Prompt);         { Prompt de style DOS }
   8:(Terminal:Term);        { Terminal de communication }
   9:(Unix:Prompt);          { Prompt de style Unix }
   10:(HexVw:HexEditApp);    { diteur hexad‚cimal }
   14:(PC:WatchWin);         { Calculatrice programmable }
   15:(Calculator:SuperCalcApp);{ Calculatrice }
   19:(Mnu:LoaderMenuApp);       { Menu d'Application }
   20:(Font:FontEditor);     { diteur de police }
   {21:(Budget:BudgetRec);    { Budget }
   22:(Debug:DebugRec)       { D‚boguer de programme }
   {$ELSE}
    23:(Anim:Anim3D);        { Fenˆtre d'animation 3D }
   {$ENDIF}
  End;
 End;

{$I Library\System\Malte\Windows\Data.Inc}

Procedure Init(Const Title:String;Mtx:Byte);{$IFNDEF UnitH}Forward;{$ENDIF}
Procedure InitWindow;{$IFNDEF UnitH}Forward;{$ENDIF}
Procedure CloseAllWindows;{$IFNDEF UnitH}Forward;{$ENDIF}
Procedure CloseAllWindowsNExit;{$IFNDEF UnitH}Forward;{$ENDIF}
Procedure CloseWindow;{$IFNDEF UnitH}Forward;{$ENDIF}
Procedure DestroyNextWindow;{$IFNDEF UnitH}Forward;{$ENDIF}
Procedure ListWindow;{$IFNDEF UnitH}Forward;{$ENDIF}
Function  Model:Byte;{$IFNDEF UnitH}Forward;{$ENDIF}
Procedure NextWindow;{$IFNDEF UnitH}Forward;{$ENDIF}
Procedure MakeApplication(X,Y:Byte);{$IFNDEF UnitH}Forward;{$ENDIF}
Procedure OpenX(Mode:Byte);{$IFNDEF UnitH}Forward;{$ENDIF}
Procedure PreviousWindow;{$IFNDEF UnitH}Forward;{$ENDIF}
Procedure Print;{$IFNDEF UnitH}Forward;{$ENDIF}
Procedure RefreshWindow;{$IFNDEF UnitH}Forward;{$ENDIF}
Function  Run:Wd;{$IFNDEF UnitH}Forward;{$ENDIF}
Procedure Save;{$IFNDEF UnitH}Forward;{$ENDIF}
Procedure SaveAll;{$IFNDEF UnitH}Forward;{$ENDIF}
Procedure SaveAs;{$IFNDEF UnitH}Forward;{$ENDIF}
Function  XEditor:Byte;{$IFNDEF UnitH}Forward;{$ENDIF}

{$IFDEF UnitH}
IMPLEMENTATION

Uses {$IFDEF Adele}Adele,{$ELSE}Chantal,{$ENDIF}
     Video,Dials,Editor,EdtDone,EditIcon,DrawEdit,FontEdt,
     FileMana,QHexView,MalCalc,ToolTerm,Loader,Numerix,EdtLoad,
     ToolPrn,Mouse,PrnFileM,EdtSave,Editex,CalcSave,CalcLoad;
{$ENDIF}

Const
 SizeOfWn:Array[0..wnMx]of Wd=(
  {$IFNDEF OnlyAnim}
  0,                   { Toujours vide...}
  SizeOf(EditorApp),   { diteur de traŒtement de texte: Document, Pascal, C,...}
  SizeOf(ViewAsciiApp),{ Regarde ASCII }
  SizeOf(IconEditApp), { diteur d'Icon graphique }
  SizeOf(DrawEditApp), { Programme de dessin }
  SizeOf(SuperCalcApp),{ Chiffrier ‚lectronique, tableur }
  SizeOf(FileManagerApp),{ Gestionnaire de fichiers }
  SizeOf(Prompt),      { Prompt de style DOS }
  SizeOf(Term),        { Terminal de communication modem }
  SizeOf(Prompt),      { Prompt de style Unix }
  SizeOf(HexEditApp),  { diteur Hexad‚cimal }
  0,{wnOutput=11;}     { cran de sortie }
  0,{wnMusicMod=12;}   { diteur de .MOD }
  0,{wnMacro=13;}      { diteur de Macro }
  SizeOf(WatchWin),    { Watch, Calculatrice Programmable }
  SizeOf(SuperCalcApp),{ Calculatrice ordinaire }
  0,{wnCalendriar=16;} { Calendrier }
  0,{wnAgenda=17;}     { Agenda }
  0,{wnCatDisk=18;}    { Catalogue de disquette }
  SizeOf(LoaderMenuApp),{ Menu d'application }
  SizeOf(FontEditor),  { diteur de Police}
  0{SizeOf(BudgetRec)},   { Budget }
  SizeOf(DebugRec)     { D‚bogueur de programme (PowerHacken seulement) }
  {$ELSE}
   0,0,0,0,0, 0,0,0,0,0, 0,0,0,0,0, 0,0,0,0,0, 0,0,
   SizeOf(Anim3D)
  {$ENDIF}
 );

Function  ClsWn:Bool;Near;Forward;
Function  GetNextWnPos(Var X1,Y1,X2,Y2:Byte;SzOf:Wd;Model:Byte):Pointer;Near;Forward;
Procedure OpenHelp(Const FileName,Title:String);Near;Forward;
Procedure PutTapis(Y1,Y2,Attr:Byte);Near;Forward;
Procedure RefreshBackground;Near;Forward;
Procedure SaveBack;Near;Forward;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Fonction BaseRun                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet d'extraire un ‚v‚nement utilisant lorsque aucune
 fenˆtre d'application n'est ouverte.
}

{Var OldXJoy,OldYJoy,rX,rY:ShortInt;}
Function BaseRun(Var Q):Wd;Far;Var BK,MX,MY:Byte;B:Wd;{$IFDEF Adele}Len:Byte;{$ENDIF}Begin
 {$IFDEF Adele}
  If(IsLuxe)Then Len:=2 Else Len:=3;
 {$ENDIF}
 _InitKbd;
 __ShowMousePtr;
 Repeat
  __GetMouseTextSwitch(MX,MY,B);
  If B>0Then Begin
   If(LastMsY=0)and(LastMsX<{$IFDEF Adele}Len{$ELSE}Length(CloseIcon){$ENDIF})Then Begin
    __HideMousePtr;BaseRun:=kbPrgClsIcon;
   End;
   {$IFDEF MonsterBook}
    BK:=BMGetBut(But,LastMsX,LastMsY);
    If(BK)in[0..3,9..10,16,17]Then __HideMousePtr;
    Case(BK)of
     0: OpenEdt;
     1: OpenDrw;
     2: OpenIcnEdt;
     3: OpenSuperCalc;
     4:;{ Ouvre drapeau }
{     6:SearchFind;
     8:SearchAgain;}
     9: Print;
    10: NewTerm;
    16: SomaryInfo;
    17: LstEdt;
    End;
    If(BK)in[0..3,9..10,16,17]Then Begin __ShowMousePtr;Continue;End;
   {$ENDIF}
   PMGetMnuBar(LastMsX,LastMsY);
  End;
  _BackKbd;
{   rX:=JoyX(0);rY:=JoyY(0);
  If(OldXJoy<>rX)Then Begin
   Case rX of
    -1:PushKey(kbLeft);
    1:PushKey(kbRight);
   End;
   OldXJoy:=rX;
  End;
  If(OldYJoy<>rY)Then Begin
   Case rY of
    -1:PushKey(kbUp);
    1:PushKey(kbDn);
   End;
   OldYJoy:=rY;
  End;}
 Until KeyPress;
 __HideMousePtr;
 BaseRun:=ReadKey;
End;

Procedure CloseAllWindows;Begin
 If _Windows.Count>0Then Begin
  CloseAllWindowsNExit;
  If(GetSysErr<>errUser)Then Begin
   {$IFDEF H}PutTapis(2,MaxYTxts-2,KrTapis);{$ENDIF}
   {$IFNDEF OnlyAnim}
    PutMemory;
   {$ENDIF}
   UpDateMnu;
  End;
 End;
End;

Procedure CloseAllWindowsNExit;Begin
 If _Windows.Count>0Then Begin
  CurrEdit:=0;
  While _Windows.Count>0do If Not(ClsWn)Then Begin;SysErr:=errUser;Exit;End;
 End;
End;

Procedure CloseWindow;Begin
 If CurrEdit>=0Then If Not(ClsWn)Then Begin;SysErr:=errUser;Exit;End;
 {$IFDEF H}
  If _Windows.Count>1Then WEPopWn(WinPtr^.BW);
  {RunFunc:=RunFunc(cmdRefreshWn);}
  RefreshWindow;
  RefreshBackground;
 {$ENDIF}
 UpDateMnu;
 {$IFNDEF OnlyAnim}
  PutMemory;
 {$ENDIF}
End;

Function ClsWn;Begin
 ClsWn:=False;
 WinPtr:=_ALGetBuf(_Windows,CurrEdit);
 Case(Model)of
  {$IFDEF MonsterBook}
   wnDebug:DoneDebug;
  {$ENDIF}
  {$IFNDEF OnlyAnim}
  wnEdit:Begin
   If(TEDone(WinPtr^.P.Edit)=kbAbort)Then Exit;
   WriteLog('Ferme: '+WinPtr^.P.Edit.EditName);
  End;
  wnView:VADone(WinPtr^.P.ViewAscii);
  wnIcn:IEDone(WinPtr^.P.IcnEdt);
  wnDraw:DWDone(WinPtr^.P.DrawEdit);
  wnLotus:SCDone(WinPtr^.P.Lotus);
  wnFileManager:FMDone(WinPtr^.P.FM);
  wnPrmpt:PDDone(WinPtr^.P.Shell);
  wnUnix:PDDone(WinPtr^.P.Unix);
  wnTerm:TADone(WinPtr^.P.Terminal);
  wnHexView:HVDone(WinPtr^.P.HexVw);
  wnMnu:MADone(WinPtr^.P.Mnu);
  wnPC:WWDone(WinPtr^.P.PC);
  wnFont:FEDone(WinPtr^.P.Font);
  {$IFDEF MonsterBook}
   wnBudget:BUDone(WinPtr^.P.Budget);
  {$ENDIF}
  {$ELSE}
   wnAnim:A3Done(WinPtr^.P.Anim);
  {$ENDIF}
  Else Begin;ClsWn:=Ya;Exit;End;
 End;
 {$IFDEF H}WEFreeAll(WinPtr^.BW);{$ENDIF}
 ALDelBuf(_Windows,CurrEdit);
 {$IFDEF H}WinPtr:=_ALGetBuf(_Windows,CurrEdit);{$ENDIF}
 PreviousWindow;
 If CurrEdit<=0Then YEditor:=LnsMnu{$IFDEF MonsterBook}+BMUseYTexts(But){$ENDIF};
 ClsWn:=Ya;
End;

Procedure DestroyNextWindow;Begin
 ALDelBuf(_Windows,CurrEdit);
 Dec(CurrEdit);WinPtr:=_ALGetBuf(_Windows,CurrEdit);
 RefreshWindow;
 {$IFNDEF OnlyAnim}
  PutMemory;
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

{$I Library\System\Malte\Windows\GetNxPos.Inc}
{$I Library\System\Malte\Windows\GetNxMin.Inc}
{$I Library\System\Malte\Windows\GetLastM.Inc}

Procedure Init;Begin
 _InitEnv(Mtx);
 InitDials;
 InitWindow;
 PutTapis(0,MaxYTxts,KrTapis);
 ConMacro('C'#0+Chr(CurrKrs.LastBar.Normal)+ { BarSpcHor(0,0,MaxXTxts,CurrKrs.LastBar.Normal); }
	  'I'+                               { PutCloseIcon(0,0,$F);}
	  'TO'#0+Chr(CurrKrs.LastBar.Normal)+Title+'$'+
	  'C'#$FF+Chr(CurrKrs.Menu.Normal)); { BarSpcHor(0,MaxYTxts,MaxXTxts,CurrKrs.Menu.Normal);}
 PMPutMnuBar;
 UpDateMnu;
End;

{$I Library\System\Malte\Windows\Init.Inc}

Procedure ListWindow;
Var
 List:LstMnu;
 K:Word;
 I:LongInt;
 EditorP:^EditorApp;
Begin
 If _Windows.Count=0Then Begin
  ErrMsgOk('Vous n''avez pas de fenˆtre ouverte! Vous ne pouvez donc pas changer de fenˆtre...');
  Exit;
 End;
 LMInitKrDials(List,10,4,wnMax-10,wnMax-4,'Liste des fenˆtres ouvertes');
 For I:=0to _Windows.Count-1do Begin
  WinPtr:=_ALGetBuf(_Windows,I);
  Case(Model)of
  {$IFNDEF OnlyAnim}
wnEdit: ALAddStrByte(List.List,'diteur Texte '+WinPtr^.P.Edit.EditName,I+1);
wnIcn: ALAddStrByte(List.List,'diteur Icon '+WinPtr^.P.IcnEdt.Name,I+1);
wnDraw: ALAddStrByte(List.List,'iteur dessin ',I+1);
wnPrmpt: ALAddStrByte(List.List,'Prompt Dos',I+1);
wnTerm: ALAddStrByte(List.List,'Terminal',I+1);
wnPC: ALAddStrByte(List.List,'Calculatrice Programme',I+1);
wnLotus: ALAddStrByte(List.List,'Chiffrier ‚lectronique '+WinPtr^.P.Lotus.FileName,I+1);
wnFileManager: ALAddStrByte(List.List,'Gestionnaire de fichiers '+FMGetPath(WinPtr^.P.FM),I+1);
wnHexView: ALAddStrByte(List.List,'Edite/Regarde Hexad‚cimal '+HVGetPath(WinPtr^.P.HexVw),I+1);
wnView:ALAddStrByte(List.List,'Regarde Ascii '+WinPtr^.P.ViewAscii.FileName,I+1);
wnFont:ALAddStrByte(List.List,'diteur Police '+WinPtr^.P.Font.FileName,I+1);
  {$ELSE}
wnAnim:ALAddStrByte(List.List,'Animation 3D',I+1);
  {$ENDIF}
  End;
 End;
 K:=LMRun(List);
 LMDone(List);
 If(_Windows.Count>0)and(K>0)Then Begin
  CurrEdit:=K-1;WinPtr:=_ALGetBuf(_Windows,CurrEdit);
  RefreshWindow;
 End
  Else
 WinPtr:=_ALGetBuf(_Windows,CurrEdit);
 UpDateMnu;
End;

Procedure MakeApplication;Var X1,Y1,X2,Y2:Byte;Begin
 Ptr:=GetNextWnPos(X1,Y1,X2,Y2,SizeOfWn[X],X);
 If(Ptr=NIL)Then Exit;
 Case(X)of
  {$IFNDEF OnlyAnim}
  wnEdit:Begin
   TEOpen(WinPtr^.P.Edit,X1,Y1,X2,Y2,'');
   If Y<>0Then TESetViewMode(WinPtr^.P.Edit,Y);
  End;
  wnIcn:IELoad(WinPtr^.P.IcnEdt,X1,Y1,X2,Y2,'');
  wnLotus:SCInit(WinPtr^.P.Lotus,X1,Y1,X2,Y2,0);
  wnFileManager:FMInit(WinPtr^.P.FM,X1,Y1,X2,Y2);
  wnPrmpt:PDInit(WinPtr^.P.Shell,X1,Y1,X2,Y2);
(*  wnTerm:TAInit(WinPtr^.P.Terminal,Y1,Y2,CommPort,''{StrPas(PathPhoneList)});*)
  wnPC:WWInit(WinPtr^.P.PC,X1,Y1,X2,Y2);
  wnUnix:PUInit(WinPtr^.P.Unix,X1,Y1,X2,Y2);
  wnMnu:If Not MAInit(WinPtr^.P.Mnu,X1,Y1,X2,Y2)Then Begin
   CloseWindow;
   If(WarningMsgYesNo('Fichier de Menu d''Application inexistant! '+
                      'D‚sirez-vous en cr‚er un?')=kbYes)Then EditMenuApplication;
  End;
  {$ELSE}
wnAnim:A3Init(WinPtr^.P.Anim,X1,Y1,X2,Y2);
  {$ENDIF}
 End;
 UpDateMnu;
End;

{$I Library\System\Malte\Windows\Model.Inc}

Procedure NextWindow;Begin
 If _Windows.Count>1Then Begin
  If(_Windows.Count-1>CurrEdit)Then Inc(CurrEdit)Else CurrEdit:=0;
  WinPtr:=_ALGetBuf(_Windows,CurrEdit);
  RefreshWindow;
  UpDateMnu;
 End;
End;

Procedure OpenHelp(Const FileName,Title:String);
Var
 X1,Y1,X2,Y2:Byte;
Begin
 Ptr:=GetNextWnPos(X1,Y1,X2,Y2,SizeOf(EditorApp),wnEdit);
 If(Ptr=NIL)Then Exit;
 {$IFNDEF OnlyAnim}
  TEOpenSpecialTitle(WinPtr^.P.Edit,X1,Y1,X2,Y2,FileName,Title);
 {$ENDIF}
 UpDateMnu;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Proc‚dure OpenX                             Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet l'ouverture d'un ou la cr‚ation d'un fichier texte
 de format sp‚cifi‚ par la variable ®Mode¯ de ces param‚trages.
}

Procedure OpenX(Mode:Byte);
Label 1;
Const
 All:Array[0..Length('*.*')]of Char='*.*'#0;
Var
 PPath,PExt:PChr;
 X1,Y1,X2,Y2:Byte;OldY:Word;
 Path,Ext:String;
 TPath:Array[Byte]of Char;
Begin
 PPath:=NIL;PExt:=NIL;
 Case(Mode)of
  {$IFNDEF OnlyAnim}
  vtDefault:PExt:=@All;
  vtAda:Begin;PPath:=PathAda;PExt:=@All;End;
  vtAsm:Begin;PPath:=PathAsm;PExt:=ExtAsm;End;
  vtBas:Begin;PPath:=PathBas;PExt:=ExtBas;End;
  vtC:Begin;PPath:=PathC;PExt:=ExtC;End;
  vtCobol:Begin PPath:=PathCobol;PExt:=@All;End;
  vtEuphoria:Begin;PPath:=PathEuphoria;PExt:=ExtEuphoria;End;
  vtForth:Begin;PPath:=PathForth;PExt:=@All;End;
  vtFortran:Begin;PPath:=PathFortran;PExt:=ExtFortran;End;
  vtIni:PExt:=ExtIni;
  vtMsMnu:PExt:=ExtMsMnu;
  vtPas:Begin;PPath:=PathPas;PExt:=ExtPas;End;
  vtPW:PExt:=@All;
  vtRC:Begin;PPath:=PathResource;PExt:=ExtRC;End;
  vtGAT:Begin;PPath:=PathGat;PExt:=PChr(PChar('*.GAT;*.DOC'))End;
  vtAC:PExt:=PChr(PChar('*.AC'));
  vtMacro:Begin;PPath:=NIL{PathMac};PExt:=PChr(PChar('*.MAC'))End;
  {$ELSE}
  $A3:PExt:=PChr(PChar('*.3D'));
  {$ENDIF}
 End;
1:If(PPath=NIL)Then Path:=''Else Path:=SetPath4AddFile(StrPas(PPath));
 {$IFDEF OnlyAnim}
  Path:=OpenWin(Path+StrPas(PExt),'Ouvre une Animation 3D');
  If Path<>''Then Begin
   Ext:=Path2Ext(Path);
   If Not FileExist(Path)Then Path:=Path2NoExt(Path)+'.3D';
   Ptr:=GetNextWnPos(X1,Y1,X2,Y2,SizeOf(Anim3D),wnAnim);
   If(Ptr=NIL)Then Exit;
   A3Open(WinPtr^.P.Anim,X1,Y1,X2,Y2,Path);
   OldY:=YEditor;
   If GetSysErr>0Then Begin
    If(GetSysErr<>$FFFF)and(GetSysErr<>errPassWord)Then Begin
     A3Done(WinPtr^.P.Anim);
     ErrMsgOk(GetStrLangRLL(lg1IndexErr+GetSysErr));
    End;
    DestroyNextWindow;
    YEditor:=OldY;
   End;
  End;
 {$ELSE}
  Path:=OpenWin(Path+StrPas(PExt),'Ouvre Fichier Basic');
  If Path<>''Then Begin
   Ext:=Path2Ext(Path);
   If(Mode=vtGAT)Then Begin
    If Not FileExist(Path)Then Path:=Path2NoExt(Path)+'.GAT';
   End;
   Ptr:=GetNextWnPos(X1,Y1,X2,Y2,SizeOf(EditorApp),wnEdit);
   If(Ptr=NIL)Then Exit;
   TEOpen(WinPtr^.P.Edit,X1,Y1,X2,Y2,Path);
   OldY:=YEditor;
   If GetSysErr>0Then Begin
    If(GetSysErr<>$FFFF)and(GetSysErr<>errPassWord)Then Begin
     TEDone(WinPtr^.P.Edit);
     ErrMsgOk(GetErrMsg(GetSysErr));
    End;
    DestroyNextWindow;
    YEditor:=OldY;
   End;
  End;
 {$ENDIF}
 UpDateMnu;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Proc‚dure PreviousWindow                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de passer … la fenˆtre pr‚c‚dente dans la liste.
 S'il est d‚j… rendu … la premiŠre fenˆtre, il passe … la dernier.  Cette
 op‚ration n'est valable qu'avec 2 fenˆtres minimum.
}

Procedure PreviousWindow;Begin
 If Not ALIsEmpty(_Windows)Then Begin
  If CurrEdit>0Then Dec(CurrEdit)Else CurrEdit:=_Windows.Count-1;
  If CurrEdit>=0Then Begin
   WinPtr:=_ALGetBuf(_Windows,CurrEdit);
   RefreshWindow;
   UpDateMnu;
  End;
 End;
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
 {$IFNDEF OnlyAnim}
  Case(Model)of
   wnEdit:TEPrn(WinPtr^.P.Edit);
   wnFileManager:FMPrnFile(WinPtr^.P.FM);
   Else ErrMsgOk('Je ne peux pas deviner ce que vous voulez que je fasse imprimer...');
  End;
 {$ENDIF}
End;

{$I Library\System\Malte\Presenta.tio\PutTapis.Inc}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Proc‚dure RefreshBackground                    Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de r‚actualiser la toile de fond sans toucher au
 fenˆtre s'il y en a.  Elle utilise la m‚thode  ®H¯,  elle n'est donc pas
 disosiable de ce m‚canisme.
}

{$IFDEF H}
 Procedure RefreshBackground;
 Var
  Pln:^TBool;
  SizePln,LW,AW,CW,CW2:Word;
  I,J,IE:Integer;
  W:Window;
  PtrW:Pointer;

  Procedure PutTapisDirect;Var I,J,K,JD,ID,Y1M,Y2M:Byte;JDC,JDC1:Wd;
  T:Array[0..1,0..1]of TextCube;Attr:Byte;Base:Wd;Begin
   Attr:=$19;
   If Not(FontFound)or{$IFDEF Adele}Not(IsLuxe){$ELSE}(Length(CloseIcon)=3){$ENDIF}Then Attr:=$80;
   If(IsMono)Then Attr:=$7F;
   FillChr(T,SizeOf(T),Attr);
   If(FontFound)and{$IFDEF Adele}IsLuxe{$ELSE}(Length(CloseIcon)=2){$ENDIF}Then Begin
    T[0][0].Chr:=#29;T[0][1].Chr:=#30;T[1][0].Chr:=#30;T[1][1].Chr:=#29;
   End
    Else
   Begin
    T[0][0].Chr:=' ';T[0][1].Chr:=' ';T[1][0].Chr:=' ';T[1][1].Chr:=' ';
   End;
   Y1M:=2shr 1; Y2M:=(MaxYTxts-2)shr 1; Base:=NmXTxts shl 1;
   JDC:=Y1M*Base;
   For J:=Y1M to(Y2M)do Begin
    JDC1:=JDC+NmXTxts;
    For K:=0to 1do For I:=0to(MaxXTxts)shr 1do Begin
     ID:=I shl 1;
     If Not Pln^[ID+JDC+K-Base]Then
      Move(T[K],Mem[GetVideoSeg:(ID+JDC+K)shl 1],SizeOf(T[0])shr 1);
     If(J shl 1)+1<=MaxYTxts-2Then If Not Pln^[ID+JDC1+K-Base]Then
      Move(T[(K+1)and 1],Mem[GetVideoSeg:(ID+JDC1+K)shl 1],SizeOf(T[1])shr 1);
    End;
    Inc(JDC,Base);
   End;
  End;

  Procedure FontMarble;Var Handle:Hdl;I,I2,J,J2,IM,JM,Y,YMin,YMax,YB,Jw:Wd;Buf:Array[0..245]of Byte;Begin
   Handle:=FileOpen('SYS:MARBLE.MBF',fmRead);
   If(Handle=errHdl)Then Exit;
   IM:=GetMaxXPixels div 246+Byte((GetMaxXPixels mod 246)>0);
   JM:=GetMaxYPixels div 246+Byte((GetMaxYPixels mod 246)>0);Jw:=0;
   YMin:=(HeightChr shl 1)+31;YMax:=NmYPixels-(HeightChr shl 1);
   For J:=0to 221do Begin
    _GetAbsRec(Handle,Jw,246,Buf);
    YB:=J;
    For J2:=0to(JM)do Begin
     Y:=YB;I2:=0;
     For I:=0to(IM)do Begin
      If(Y<YMax)and(Y>YMin)Then ClrLnHorImg(I2,Y,246,8,Buf);
      Inc(I2,246);
     End;
     Inc(YB,222);
    End;
    Inc(Jw,246);
   End;
   FileClose(Handle)
  End;

 Begin
  SizePln:=NmXTxts*(NmYTxts-4);Pln:=MemAlloc(SizePln);IE:=CurrEdit;
  If(Pln=NIL)Then Exit;
  FillClr(Pln^,SizePln);
  Repeat
   Case(Model)of
    0: Break;
    {$IFNDEF OnlyAnim}
    wnEdit:PtrRec(PtrW).Ofs:=Ofs(WinPtr^.P.Edit.W);
    wnView:PtrRec(PtrW).Ofs:=Ofs(WinPtr^.P.ViewAscii.W);
    wnIcn:PtrRec(PtrW).Ofs:=Ofs(WinPtr^.P.IcnEdt.W);
    wnDraw:PtrRec(PtrW).Ofs:=Ofs(WinPtr^.P.DrawEdit.W);
    wnLotus:PtrRec(PtrW).Ofs:=Ofs(WinPtr^.P.Lotus.W);
    wnFileManager:PtrRec(PtrW).Ofs:=Ofs(WinPtr^.P.FM.W);
    wnPrmpt:PtrRec(PtrW).Ofs:=Ofs(WinPtr^.P.Shell.Ansi);
    wnTerm:PtrRec(PtrW).Ofs:=Ofs(WinPtr^.P.Terminal.W);
    wnPC:PtrRec(PtrW).Ofs:=Ofs(WinPtr^.P.PC.W);
    wnCalculator:PtrRec(PtrW).Ofs:=Ofs(WinPtr^.P.Calculator.W);
    wnHexView:PtrRec(PtrW).Ofs:=Ofs(WinPtr^.P.HexVw.W);
    wnUnix:PtrRec(PtrW).Ofs:=Ofs(WinPtr^.P.Unix.Ansi);
    wnMnu:PtrRec(PtrW).Ofs:=Ofs(WinPtr^.P.Mnu.W);
    wnFont:PtrRec(PtrW).Ofs:=Ofs(WinPtr^.P.Font.W);
    {$ELSE}
    wnAnim:PtrRec(PtrW).Ofs:=Ofs(WinPtr^.P.Anim.W);
    {$ENDIF}
   End;
   PtrRec(PtrW).Seg:=PtrRec(WinPtr).Seg;
   MoveLeft(PtrW^,W,SizeOf(Window));
   AW:=(W.T.Y1-2)*NmXTxts+W.T.X1; LW:=W.T.X2-W.T.X1+1;
   For J:=W.T.Y1-2to W.T.Y2-2do Begin
    FillChr(Pln^[AW],LW,Byte(True));
    Inc(AW,NmXTxts);
   End;
   If IE>0Then Dec(IE)Else IE:=_Windows.Count-1;
   WinPtr:=_ALGetBuf(_Windows,IE);W:=WinPtr^.BW;
   If(W.Buffer<>NIL)Then Begin
    LW:=W.T.X2-W.T.X1+1;
    If W.T.X2=MaxXTxts-1Then Inc(LW)Else If(W.T.X2<MaxXTxts)Then Inc(LW,2);
    CW:=(W.T.Y1-2)*NmXTxts+W.T.X1;CW2:=(CW+(NmXTxts shl 1))shl 1;AW:=0;
    For J:=0to(W.T.Y2-W.T.Y1)do Begin
     For I:=0to(W.T.X2-W.T.X1)do If Not Pln^[CW+I]Then Begin
      MemW[GetVideoSeg:I shl 1+CW2]:=Word(PTTxtCube(W.Buffer)^[AW+I]);
{AW:=I+J*LW;SetCube(I+W.X1,J+W.Y1,PTTxtCube(W.Buf)^[AW].Chr,PTTxtCube(W.Buf)^[AW].Attr);}
     End;
     Inc(CW,NmXTxts);Inc(CW2,BytesPerLn);Inc(AW,LW);
    End;
   End;
  Until IE=CurrEdit;
  If(IsGrf)Then FontMarble Else PutTapisDirect;
  If Not Pln^[NmXTxts*(MaxYTxts-4)]Then
   BarSelHor(0,MaxYTxts-1,MaxXTxts,GetAttr(0,MaxYTxts-1));
  WinPtr:=_ALGetBuf(_Windows,CurrEdit);
  FreeMem(Pln,SizePln);
 End;
{$ENDIF}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure RefreshWindow                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de r‚actualiser l'affichage vid‚o de la fenˆtre
 actuellement en usage.  S'il n'y en pas d'ouverte,  il r‚actualise tout
 bonnement le toile de fond.
}

Procedure RefreshWindow;
{$IFNDEF OnlyAnim}
Const Refresh:Array[wnEdit..wnHexView]of RefreshProc=
 (TERefresh,VARefresh,IERefresh,DWRefresh,SCRefresh,
  _FMRefresh,PDRefresh,TMRefresh,PDRefresh,HVRefresh);
{$ENDIF}
Begin
 Case(Model)of
            0:RefreshBackground;
{$IFDEF OnlyAnim}
       wnAnim:A3Refresh(WinPtr^.P);
{$ELSE}
 wnEdit..wnHexView:Refresh[Model](WinPtr^.P);
              wnPC:WWRefresh(WinPtr^.P.PC);
            wnFont:FERefresh(WinPtr^.P.Font);
{$ENDIF}
       {$IFDEF MonsterBook}
      wnDebug:RefreshDebug;
       {$ENDIF}
 End;
End;

Function Run;
{$IFNDEF OnlyAnim}
 Const wnMaxRun=wnHexView;RunObj:Array[0..wnMaxRun]of RunProc=
 (BaseRun,TERun,VARun,IERun,{DWRun}NIL,SCRun,FMRun,PDRun,TermRun,PDRun,HVRun);
{$ENDIF}
Var K:Wd;Begin
 Case(Model)of
  {$IFDEF OnlyAnim}
   wnAnim:K:=A3Run(WinPtr^.P.Anim);
  {$ELSE}
   0..wnMaxRun:K:=RunObj[Model](WinPtr^.P);
   wnPC:K:=WWRun(WinPtr^.P.PC);
   wnMnu:K:=MARun(WinPtr^.P.Mnu);
   wnFont:K:=FERun(WinPtr^.P.Font);
   {$IFDEF MonsterBook}
    wnBudget:K:=BURun(WinPtr^.P.Budget);
    wnDebug:K:=RunDebugProgram;
   {$ENDIF}
  {$ENDIF}
  Else K:=ReadKey;
 End;
 Run:=K;
End;

{$IFDEF H}
 Procedure SaveBack;Begin
  If ALIsEmpty(_Windows)Then Exit;
  Case(Model)of
   {$IFDEF OnlyAnim}
   wnAnim:WinPtr^.BW:=WinPtr^.P.Anim.W;
   {$ELSE}
   wnEdit:WinPtr^.BW:=WinPtr^.P.Edit.W;
   wnView:WinPtr^.BW:=WinPtr^.P.ViewAscii.W;
   wnIcn:WinPtr^.BW:=WinPtr^.P.IcnEdt.W;
   wnDraw:WinPtr^.BW:=WinPtr^.P.DrawEdit.W;
   wnLotus:WinPtr^.BW:=WinPtr^.P.Lotus.W;
   wnFileManager:WinPtr^.BW:=WinPtr^.P.FM.W;
   wnPrmpt:WinPtr^.BW:=WinPtr^.P.Shell.Ansi;
   wnTerm:WinPtr^.BW:=WinPtr^.P.Terminal.W;
   wnPC:WinPtr^.BW:=WinPtr^.P.PC.W;
   wnCalculator:WinPtr^.BW:=WinPtr^.P.Calculator.W;
   wnHexView:WinPtr^.BW:=WinPtr^.P.HexVw.W;
   wnUnix:WinPtr^.BW:=WinPtr^.P.Unix.Ansi;
   wnMnu:WinPtr^.BW:=WinPtr^.P.Mnu.W;
   wnFont:WinPtr^.BW:=WinPtr^.P.Font.W;
{   wnBudget:WinPtr^.BW:=WinPtr^.P.Budget.W;}
   {$ENDIF}
  End;
  WEPushWn(WinPtr^.BW);
 End;
{$ENDIF}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure Save                           Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet  de sauvegarder les donn‚es  contenus dans la
 fenˆtre courante sous son nom actuel. S'il n'a pas de nom, il demande
 … l'utilisateur de lui en trouver un.


 Remarque
 ÍÍÍÍÍÍÍÍ

  ş Cette proc‚dure se permet  de faire une mise … jour  du journal de
    bord lors d'une sauvegarde r‚ussi.
}

Procedure Save;Begin
 {$IFNDEF OnlyAnim}
  Case(Model)of
  wnEdit:Begin
   TESave(WinPtr^.P.Edit);
   WriteLog('Sauvegarde '+WinPtr^.P.Edit.EditName+' taille actuel: '+CStr(WinPtr^.P.Edit.FileSize)+' octet(s)');
  End;
 wnLotus:SCSave(WinPtr^.P.Lotus);
 wnIcn:IESave(WinPtr^.P.IcnEdt);
 wnDraw:DWSave(WinPtr^.P.DrawEdit);
 wnFont:FESave(WinPtr^.P.Font);
  {$IFDEF MonsterBook}
 wnBudget:BUSave(WinPtr^.P.Budget);
  {$ENDIF}
  End;
 {$ENDIF}
End;

Procedure SaveAll;
Var
 I:SmallInt;
 TW:^WinRec;
Begin
 {$IFNDEF OnlyAnim}
 For I:=0to _Windows.Count-1do Begin
  TW:=_ALGetBuf(_Windows,I);
  Case(TW^.Model)of
   0:Break;
   wnEdit:TESave(TW^.P.Edit);
   wnLotus:SCSave(TW^.P.Lotus);
   wnIcn:IESave(WinPtr^.P.IcnEdt);
   wnDraw:DWSave(WinPtr^.P.DrawEdit);
   wnFont:FESave(WinPtr^.P.Font);
   {$IFDEF MonsterBook}
    wnBudget:BUSave(WinPtr^.P.Budget);
   {$ENDIF}
  End;
 End;
 {$ENDIF}
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
 {$IFNDEF OnlyAnim}
 Case(Model)of
  wnEdit:TESaveAs(WinPtr^.P.Edit,'');
 wnLotus:SCSaveAs(WinPtr^.P.Lotus,'');
   wnIcn:IESaveAs(WinPtr^.P.IcnEdt,'');
  wnDraw:DWSaveAs(WinPtr^.P.DrawEdit,'');
  wnFont:FESaveAs(WinPtr^.P.Font,'');
  {$IFDEF MonsterBook}
wnBudget:BUSaveAs(WinPtr^.P.Budget,'');
  {$ENDIF}
 End;
 {$ENDIF}
End;

Function XEditor:Byte;Begin XEditor:=YEditor-2;End;