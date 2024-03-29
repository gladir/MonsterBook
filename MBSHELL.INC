{$I DEF.INC}

Uses Systex;

Procedure CallFile(Run:Boolean);
Procedure CompFile;
Procedure Conv2Pas;
Procedure DosShell;
Procedure Execute;
Procedure LookOutput;
Procedure RunFile;
{$IFDEF Developpeur}
 Procedure RunNExecBasic(Const Name:String);
{$ENDIF}

{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�}
                                IMPLEMENTATION
{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�}

Uses TaskMgr,Adele,Isatex,Memories,Systems,Video,Mouse,Dials,Terminal,
     ToolTerm,FileMana,Editor,ResServD,
     {$IFDEF FullVersion}
      MalEnv,
      MalLibra,
      MBBkRes,
      MBCortex,
     {$ENDIF}
     {$IFDEF BureauVersion}
      MalBEnv,
      MalBLibr,
      MBBBkRes,
      MBBCrtex,
     {$ENDIF}
     {$IFDEF Reseau}
      Server,
     {$ENDIF}
     EdtSearc,
     {$IFDEF Developpeur}
      Basic,
      Logo,
      ToolNGZ,
      ToolRes,
     {$ENDIF}
     InfoMemo,Dialex,DialPlus,EdtSave,Apps,
     SysPlus,ToolDB;

Type
 ExtensiorRec=Record
  ID:Word;
  Ext:String;
  Parent:String;
 End;

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�}
{�                           Z o n e  P r i v �                          �}
{突袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴�}

{$IFDEF Developpeur}
 Procedure RunNExecBasic(Const Name:String);
 Var
  B:BasicStruct;
  Source:ArrayList;
 Begin
  ALLoadFileASCII(Source,Name);
  If BasicInit(B)Then Begin
   B.MainSource:=Name;
   If Not BasicRun(B,Source)Then Begin
    ALDone(Source);
    OpenFile(Name);
    If(HModel(Windows)=wnEdit)Then Begin
     TEGotoXY(EditorApp(HPtr(Windows)^),B.X,B.Line);
     ErrMsgOk(BasicErrExitCodeStr(B));
    End;
    Exit;
   End;
  End
   Else
  ErrNoMsgOk(OutOfMemory);
  BasicDone(B);
  ALDone(Source);
 End;
{$ENDIF}

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴콘
 �                            Fonction PresetCall                         �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複蔔


 Description
 袴袴袴袴袴�

  Cette fonction permet  d'extraire le nom  du fichier  en 괺ition  dans la
 fen늯re courante.  Si la fen늯re n'a pas  encore sauver le fichier source,
 une invitation de sauvegarde est offerte pour ne pas lancer un compilateur
 ou un convertisseur pour rien...
}

Function PresetCall(Var Fast:Boolean):String;Near;
Var
 App:Pointer;
 Editor:^EditorApp Absolute App;
 ViewAscii:^ViewAsciiApp Absolute App;
 FileManager:^FileManagerApp Absolute App;
 Debug:^DebugRec Absolute App;
 Name:String;
Begin
 Fast:=False;
 App:=HPtr(Windows);
 Case HModel(Windows)of
  wnFileManager:PresetCall:=FMGetCurrName(FileManager^);
  wnEdit:Begin
   Name:=Editor^.EditName;
   PresetCall:=Name;
   If(Editor^.Modified)or(Not FileExist(Name))Then TESave(Editor^)
                                              Else Fast:=True;
  End;
  wnView:Name:=ViewAscii^.FileName;
  wnDebug:Name:=Debug^.Name;
  Else PresetCall:='';
 End;
End;

Procedure LoadExtensior(Const Ext,Table:String;Var Extensior:ExtensiorRec);Near;
Var
 PBuffer:Pointer;
 PString:^String Absolute PBuffer;
Begin
 DBOpenServerName(ChantalServer,Table);
 If DBLocateAbs(ChantalServer,1,Ext,[])Then Begin
  DBReadRec(ChantalServer,Extensior);
  PBuffer:=@Extensior;
  DBGotoColumnAbs(ChantalServer,2,PBuffer);
  Extensior.Parent:=PString^;
 End;
End;

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴캠}
{�                        Z o n e  P u b l i q u e                      �}
{突袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴暠}

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                          Proc괺ure CallFile                           �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Description
 袴袴袴袴袴�

  Cette proc괺ure s'occupe de produire un effet  de compilation externe en
 fonction du fichier source et l'ex괹ute par la m늤e occasion si demander.
}

Procedure CallFile;
Var
 Refresh,Fast,CShow:Boolean;
 Name,N2:String;
 Ext:ExtStr;
 Curr:PathStr;
 Extensior:ExtensiorRec;
Begin
 Name:=PresetCall(Fast);
 If Name=''Then Exit;
 Refresh:=False;
 Curr:=GetCurrentDir;
 Ext:=Path2Ext(Name);
 LoadExtensior(Ext,'CHANTAL:/Compilateur/Extensior.Dat',Extensior);
 ChDir(Path2Dir(Name));
 Case(Extensior.ID)of
  12,19,21,22,26,28,30,31,{.CUT;.HAM;.IFF;.JPG;.PIC;.RIX;.TGA;.TAR}
  16,17,{.F77;.FOR}
  25,{.PAS}
  8,{.CBL}
  6,7,9,11,18,20:Begin{.C;.CAS;.CC;.CPP;.H;.HPP}
   N2:=FSearch(Extensior.Parent,DosPath);
  End;
 End;
 Case(Extensior.ID)of
  1:{.ASM}Begin
   If(Run)and(Fast)and(FileExist(Path2NoExt(Name)+'.EXE'))Then ExecPrg(Path2NoExt(Name)+'.EXE','')
    Else
   Begin
    N2:=FSearch(Extensior.Parent,DosPath);
    If N2=''Then ErrNoMsgOk(errCompilerNotFound)
     Else
    Begin
     ExecPrg(N2,Name);
     If(Run)Then Begin
      N2:=FSearch('LINK.EXE;TLINK.EXE;LINK86.EXE',DosPath);
      If N2=''Then ErrNoMsgOk(errLinkerNotFound)Else
      Begin
       If Path2Name(N2)='LINK'Then Begin
        PushKey(kbEnter);
        PushKey(kbEnter);
        PushKey(kbEnter)
       End;
       ExecPrg(N2,Path2NoExt(Name)+'.OBJ');
       If FileExist(Path2NoExt(Name)+'.OBJ')Then Begin
        ExecPrg(Path2NoExt(Name)+'.EXE','');
        If Not FileExist(Path2NoExt(Name)+'.EXE')Then
 	ErrNoMsgOk(errLinkerOutput);
       End
        Else
       ErrNoMsgOk(errCompilerOutput);
      End;
     End;
    End;
   End;
  End;
  {$IFDEF Reseau}
   2:{.ASP}SEExec(Name);
  {$ENDIF}
  {$IFDEF Developpeur}
   3:{.BAS}RunNExecBasic(Name);
  {$ENDIF}
  4,5:{.BAT;.BTM}Begin
   ExecPrg('',Name);
   Refresh:=True;
  End;
  6,7,9,11,18,20:{.C;.CAS;.CC;.CPP;.H;.HPP}Begin
   If N2=''Then ErrNoMsgOk(errCompilerNotFound)
   Else ExecPrg(N2,Name);
  End;
  8:{.CBL -> Langage Cobol? }Begin
   If N2=''Then ErrNoMsgOk(errCompilerNotFound)
   Else ExecPrg(N2,Name+',NUL');
  End;
  13,14:{.DAT;.DBF}OpenDataBase(Name);
  10,15:{.COM;.EXE}Begin
   Refresh:=True;
   ExecPrg(Name,'');
  End;
  24:{.OBJ}Begin
   If _InputMsg('Orientation','Dois-je cr괻r les liaisons ou le d굎assembler?',
	       'Liaison|D굎assembler',wfLosange+wiInfo,CurrKrs.RemWin)=0Then Begin
    N2:=FSearch(Extensior.Parent,DosPath);
    If N2=''Then ErrNoMsgOk(errLinkerNotFound)
            Else ExecPrg(N2,Name);
   End
    Else
   Begin
    N2:=FSearch('OBJASM.EXE;OBJ2ASM.EXE',DosPath);
    If N2=''Then ErrNoMsgOk(errWorkerNotFound)
            Else ExecPrg(N2,Name);
   End;
  End;
  25:{.PAS}Begin
   If N2=''Then ErrNoMsgOk(errCompilerNotFound)
   Else ExecPrg(N2,Name);
   If(Run)Then Begin
    N2:=FSearch(Path2Name(Name)+'.EXE',Path2Dir(Name)+';'+StrPas(PathOutput));
    ExecPrg(N2,'');
   End;
  End;
  16,17:{.F77;.FOR}Begin { Fortran}
   If N2=''Then ErrNoMsgOk(errCompilerNotFound)
   Else ExecPrg(N2,Path2NoDir(Name));
   N2:=FSearch('LINK86.EXE;LINK.EXE;TLINK.EXE',DosPath);
   If N2=''Then ErrNoMsgOk(errLinkerNotFound)
   Else ExecPrg(N2,Path2Name(Name)+'.OBJ');
   If(Run)Then ExecPrg(Path2Name(Name)+'.EXE','');
  End;
 {$IFDEF Developpeur}
  27:{.RC}MakeRLLFile(Name,NIL);
 {$ENDIF}
   { Fichier d'image ??? }
  12,19,21,22,26,28,30,31:{.CUT;.HAM;.IFF;.JPG;.PIC;.RIX;.TGA;.TAR}Begin
   If N2=''Then ErrNoMsgOk(errCompilerNotFound)
    Else
   Begin
    CShow:=Pos('CSHOW.EXE',N2)>0;
    If(CShow)Then AddStr(Name,'+x');
    ExecPrg(N2,Name);
    If(CShow)Then ReadKey;
   End;
  End;
 {$IFDEF Developpeur}
  23:{.LGO}Begin
   OpenLogo(Name);
   LAExecute(LogoApp(HPtr(Windows)^));
  End;
  29:{.SQL}Begin
   DBSQLToDataBase(Name,Path2NoExt(Name)+'.DAT');
  End;
 {$ENDIF}
  32,33:_OpenSuperCalc(Name);
  Else Begin
   {$IFDEF Developpeur}
    Ext[0]:=#2;
    GetFile(Name,0,2,Ext[1]);
    If Ext='NG'Then Begin
     RunNGZ(Name);
     Refresh:=True;
    End
     Else
   {$ENDIF}
   If FindActionExtensior(Name,N2)Then ExecPrg(N2,Name)
                                  Else WinAddExtensior('*'+Path2Ext(Name));
  End;
 End;
 ChDir(Curr);
 If(Refresh)Then FMRefresh(FileManagerApp(HPtr(Windows)^),True);
End;

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴콘
 �                           Proc괺ure Conv2Pas                           �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複蔔


 Description
 袴袴袴袴袴�

  Cette proc괺ure s'occupe de convertir un fichier en fonction de la source
 actuellement actif dans la fen늯re courante.
}

Procedure Conv2Pas;
Var
 Name,N2:String;
 Ext:ExtStr;
 Fast:Boolean;
 Extensior:ExtensiorRec;
Begin
 Name:=PresetCall(Fast);
 If Name=''Then Exit;
 Ext:=Path2Ext(Name);
 LoadExtensior(Ext,'CHANTAL:/Conversion/Pascal/Extensior.Dat',Extensior);
 Case(Extensior.ID)of
  6,7,9,11,18,20,25:Begin
   N2:=FSearch(Extensior.Parent,DosPath);
   If N2=''Then __FileNotFound(Extensior.Parent)
           Else ExecPrg(N2,Name);
  End;
  Else ErrNoMsgOk(errConversNotFound);
 End;
End;

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                           Proc괺ure CompFile                          �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Description
 袴袴袴袴袴�

  Cette proc괺ure compresse ou convertie en liens le fichier source.
}

Procedure CompFile;
Var
 Name,N2:String;
 Ext:ExtStr;
 Fast:Boolean;
Begin
 Name:=PresetCall(Fast);
 If Name=''Then Exit;
 Ext:=Path2Ext(Name);
 If Ext='.OBJ'Then Begin
  N2:=FSearch('TLINK.EXE;LINK.EXE',DosPath);
  If N2=''Then ErrNoMsgOk(errLinkerNotFound)
          Else ExecPrg(N2,Name);
 End;
End;

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                           Proc괺ure DosShell                          �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Description
 袴袴袴袴袴�

  Cette proc괺ure s'occupe de lancer l'interpr굏eur de commande du syst둴e
 d'exploitation DOS ou compatible.
}

Procedure DosShell;Begin
 ExecPrg('','')
End;

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴콘
 �                         Proc괺ure Execute                        �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複蔔


 Description
 袴袴袴袴袴�

  Cette proc괺ure offre une bo똳e de dialogue pour savoir quel est le
 programme � lancer l'ex괹ution.
}

Procedure Execute;
Label Default,ChildRun;
Var
 Tasks,MaximumTasks,ForegroundTaskIndex:Word;
 CurPath:String;
 CD:Boolean;
 Ok:Boolean;         { Dois-je l'ex괹uter? }
 FormExecute:Record
  Mode:MRadioButton;
  Command:String;
 End;
 Data:OS2StartData;
 E:Word;
Begin
 FillClr(FormExecute,SizeOf(FormExecute));
 If(OS2)Then Begin
  If ExecuteAppDPU(129,FormExecute)Then Begin
   If FormExecute.Mode.Alignment=1Then Goto ChildRun;
   If FormExecute.Command=''Then FormExecute.Command:=GetEnv('COMSPEC');
   FillClr(Data,SizeOf(Data));
   Data.LenStruct:=$32;
   Data.Process:=prNew;
   Data.Priority:=prForeground;
   PChr(Data.Title):=Str2PChr('Fils du MB');
   PChr(Data.Name):=Str2PChr(FormExecute.Command);
   PChr(Data.Args):=Str2PChr('');
   E:=OS2Exec(Data);
   StrDispose(PChr(Data.Icon));
   StrDispose(PChr(Data.Title));
   StrDispose(PChr(Data.Name));
   StrDispose(PChr(Data.Args));
   If E>0Then ErrNoMsgOk(E);
  End;
 End
  Else
 If(TaskMgrInTaskBar)and(DPMSInstalled)Then Begin
  TMGetStatus(Tasks,MaximumTasks,ForegroundTaskIndex);
  If(Tasks>0)and(Tasks<5000)Then Begin
   If ExecuteAppDPU(116,FormExecute)Then Begin
    If FormExecute.Mode.Alignment=1Then Goto ChildRun;
    If FormExecute.Command=''Then FormExecute.Command:=GetEnv('COMSPEC');
    ExecPrg(FSearch('TASKMGR.EXE',DosPath),'/C '+FormExecute.Command);
    UpdateTaskBar;
   End;
  End
   Else
  Goto Default;
 End
  Else
Default:Ok:=_WinInp(40,'Ex괹ution du syst둴e d''exploitation',
          'Entrez la commande',False,FormExecute.Command)=kbOk;
 If(Ok)Then Begin
ChildRun:
  CD:=HModel(Windows)=wnFileManager;
  If(CD)Then Begin
   CurPath:=GetCurrentDir;
   ChDir(Path2Dir(FileManagerApp(HPtr(Windows)^).Panel[FileManagerApp(HPtr(Windows)^).Plane].Path));
  End;
  If StrUp(Path2Ext(FormExecute.Command))='.BAT'Then ExecBatch(FormExecute.Command)
                                                Else ExecPrg('',FormExecute.Command);
  If(CD)Then Begin
   ChDir(CurPath);
   If(HModel(Windows)=wnFileManager)Then
    FMRefresh(FileManagerApp(HPtr(Windows)^),True);
  End;
  If(HModel(Windows)=wnEdit)Then SimpleCur;
 End;
End;

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                           Proc괺ure LockOutput                        �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Description
 袴袴袴袴袴�

  Cette proc괺ure permet de voir l'괹ran de sortie de l'application. C'est
 l'괹ran DOS d'o� le programme arrive... (Output)!
}

Procedure LookOutput;
Label BrkOutput;
Var
 MS:ImgRec;
 I,XM,YM,BM:Word;
 {$IFDEF HeapVram}
  OldHeapVram:Boolean;
 {$ENDIF}

 Procedure PutErr;Begin
  If GetSysErr>0Then ErrNoMsgOk(GetSysErr)
 End;

Begin
 DialTimer:=False;
 {$IFDEF HeapVram}
  OldHeapVram:=HeapVram;
 {$ENDIF}
 __HideMousePtr;
 PushScr(MS);
 I:=1;
 PutErr;
 {$IFDEF HeapVram}
  HeapVram:=False;
 {$ENDIF}
 PopScr(Output);
 I:=2;
 PutErr;
 SimpleCur;
 __ShowMousePtr;
 Repeat
  Repeat
   GetMouseSwitch(XM,YM,BM);
   If BM>0Then Begin
    WaitMouseBut0;
    Goto BrkOutput;
   End;
  Until KeyPress;
  Case(ReadKey)of
   7:Begin
    If Not(IsGrf)Then SetLuxe;
    __InitMouse;
    CarteBios;
   End;
   kbCtrlIns:ClipBoardOutput;
   Else Break;
  End;
 Until No;
BrkOutput:
 __HideMousePtr;
 PushScr(Output);
 I:=3;
 PutErr;
 {$IFDEF HeapVram}
  HeapVram:=OldHeapVram;
 {$ENDIF}
 PopScr(MS);
 I:=4;
 PutErr;
 __ShowMousePtr;
 DialTimer:=True;
End;

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴콘
 �                            Proc괺ure RunFile                           �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複蔔


 Description
 袴袴袴袴袴�

  Cette proc괺ure compile un fichier et l'ex괹ute aussit뱓 apr둺.  C'est un
 peu le m늤e genre de processus qu'un  environnement  de d굒eloppement pour
 programmeur.
}

Procedure RunFile;Begin
 CallFile(True)
End;