{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                                                                        Û
 ³                     Malte Genesis/Outils pour terminal                 Û
 ³       dition Chantal & AdŠle pour Mode R‚el/IV & V - Version 1.1      Û
 ³                             1994/12/03                                 Û
 ³                                                                        Û
 ³       Tous droits r‚serv‚s par les Chevaliers de Malte XXIe siŠcle     Û
 ³                                                                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Nom du programmeur
 ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

  Sylvain Maltais


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette unit‚ contient des routines pour ‚muler un terminal de commande tel
 le prompt du DOS ou le Shell de Unix.


 Remarques
 ÍÍÍÍÍÍÍÍÍ

  ş La variable  global  ®Output¯  d‚signe  l'‚cran  de sortie  sous lequel
    l'application  a ‚t‚  lanc‚  et  naturellement  l'‚cran utilis‚ lors de
    l'appel du v‚ritable interpr‚teur de commande si n‚cessaire.

  ş La variable ®RegUserName¯ d‚finit le nom de l'utilisateur (usager) sous
    lequel l'application  a ‚t‚ lanc‚.  Il est utilis‚,  par exemple,  pour
    enregistrer le programme … un nom particulier.

  ş Le prompt DOS  et le ®Shell Unix¯  sont rattach‚  … des fichiers d'aide
    devant  se trouver  dans le r‚pertoire  d'aide  standard de  l'ensemble
    ®Malte Genesis VI et V:  Alais Chantal et AdŠle¯,  soit ®\MALTE\HLP¯ ou
    ®\MALTE\HELP¯ sous les noms de  ®DOS.HLP¯ et  ®UNIX.HLP¯ sous le format
    d'un fichier RLL.  Ils sont sortie dans la fenˆtre de dialogue … l'aide
    de la  ®WETypeFile¯  permettant de d‚finir un index particulier dans un
    fichier d'aide de format RLL.
}
{$I DEF.INC}

Unit ToolTerm;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                   INTERFACE
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses
 {$IFDEF __Windows__}
  WinProcs,WinTypes,
 {$ENDIF}
 Systex,Isatex,Dialex;

Procedure ExecPrg(Name,Param:String);
Function  PDInit(Var Context;X1,Y1,X2,Y2:Byte):Boolean;
Function  PDInitMode(Var Context;X1,Y1,X2,Y2:Byte;Mode:Word):Boolean;
Procedure PDRefresh(Var Context);
Procedure PDReSize(Var Q;X1,Y1,X2,Y2:Byte);
Procedure PDMove2(Var Context;X,Y:Byte);
Procedure PDExecBatch(Var Q:Prompt;Const Name:String);
Procedure PDWinFind(Var Q:Prompt);
Function  PDRun(Var Qx):Word;
Function  PDTitle(Var Context;Max:Byte):String;
Function  PDDone(Var Context):Word;
Function  PUInit(Var Context;X1,Y1,X2,Y2:Byte):Boolean;
Procedure ExecBatch(Const Name:String);

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                               IMPLEMENTATION
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses
 Adele,Memories,Systems,dostex,pritex,Math,Video,Mouse,Terminal,ToolPrn,
 ToolInfo,Dials,ToolDsk,Sourcer,SysPlus,DialPlus,Sound,
 ResTex,ResServD,DialTree,Registry,FileMana,
 ToolFile,ToolRes,ToolVid,UnZip,Time;

Const { Constante des index d'aide }
  { * * * * * * Shell DOS * * * * * * * }
 HelpDosAlias=0;         { Index d'aide pour la commande Dos ®ALIAS¯ }
 HelpDosBeep=1;          { Index d'aide pour la commande Dos ®BEEP¯ }
 HelpDosChDir=2;         { Index d'aide pour les commandes Dos ®CD¯ et ®CHDIR¯ }
 HelpDosConfig=3;        { Index d'aide pour la commande Dos ®CONFIG¯ }
 HelpDosCopy=4;          { Index d'aide pour la commande Dos ®COPY¯ }
 HelpDosDel=5;           { Index d'aide pour la commande Dos ®DEL¯ }
 HelpDosDir=6;           { Index d'aide pour la commande Dos ®DIR¯ }
 HelpDosDump=7;          { Index d'aide pour la commande Dos ®DUMP¯ }
 HelpDosEcho=8;          { Index d'aide pour la commande Dos ®ECHO¯ }
 HelpDosFree=9;          { Index d'aide pour la commande Dos ®FREE¯ }
 HelpDosLabel=10;        { Index d'aide pour la commande Dos ®LABEL¯ }
 HelpDosMemory=11;       { Index d'aide pour la commande Dos ®MEMORY¯ }
 HelpDosMkDir=12;        { Index d'aide pour la commande Dos ®MKDIR¯ }
 HelpDosMove=13;         { Index d'aide pour la commande Dos ®MOVE¯ }
 HelpDosPause=14;        { Index d'aide pour la commande Dos ®PAUSE¯ }
 HelpDosRmDir=15;        { Index d'aide pour la commande Dos ®RMDIR¯ }
 HelpDosScreen=16;       { Index d'aide pour la commande Dos ®SCREEN¯ }
 HelpDosSerNo=17;        { Index d'aide pour la commande Dos ®SERNO¯ }
 HelpDosSetPrn=18;       { Index d'aide pour la commande Dos ®SETPRN¯ }
 HelpDosTime=19;         { Index d'aide pour la commande Dos ®TIME¯ }
 HelpDosTrueName=20;     { Index d'aide pour la commande Dos ®TRUENAME¯ }
 HelpDosType=21;         { Index d'aide pour la commande Dos ®TYPE¯ }
 HelpDosUnAsm=22;        { Index d'aide pour la commande Dos ®UNASM¯ }
 HelpDosVerify=23;       { Index d'aide pour la commande Dos ®VERIFY¯ }
 HelpDosVol=24;          { Index d'aide pour la commande Dos ®VOL¯ }
 HelpDosIndex=25;        { Index d'aide g‚n‚rale }
 HelpDosFind=26;         { Index d'aide pour les commandes Dos ®FIND¯ ou ®GREP¯ }
 HelpDos4MAT=27;         { Index d'aide pour la commande DOS ®FORMAT¯ ou ®4MAT¯ }
 HelpDosBE=28;           { Index d'aide pour les commandes Norton Utility ®BE¯ }
 HelpDosUnzip=36;        { Index d'aide pour la commande ®UNZIP¯ }
 HelpDosDiskCopy=37;     { Index d'aide pour la commande ®DISKCOPY¯ }
  { * * * * * * Shell Unix * * * * * * * }
 HelpUnixBaseName=0;     { Index d'aide pour la commande Unix ®basename¯ }
 HelpUnixDirName=1;      { Index d'aide pour la commande Unix ®dirname¯ }
 HelpUnixHelp=2;         { Index d'aide pour la commande Xenix ®help¯ }
 HelpUnixIndex=3;        { Index d'aide pour l'index des commandes }
 HelpUnixls=4;           { Index d'aide pour la commande Unix ®ls¯ }

 LimitImage=100;         { Nombre maximal de ligne m‚moriser en m‚moire }
                         { avant de les perdres d‚finitivement! }

  { Code TPU (Terminal Processing Unit) }
 tpuPutString=#1;
 tpuPutLong=#2;
 tpuPutLong2=#3;
 tpuLn=#13;

Type
 DelOptionEnum=(doDel,doDelQ,doXDel);

Function PDCommand(Var Q:Prompt):Word;Near;Forward;
Procedure PDConfig(Var Q:Prompt);Near;Forward;
Procedure PDPutCurrentDisk(Var Q:Prompt);Near;Forward;
Procedure PDPutCurrentPath(Var Q:Prompt);Near;Forward;
Procedure PDPutDir(Var Q:Prompt);Near;Forward;
Procedure PDEcho(Var Q:Prompt);Near;Forward;
Procedure PDFree(Var Q:Prompt);Near;Forward;
Procedure PDPutPath(Var Q:Prompt);Near;Forward;
Procedure PDMemory(Var Q:Prompt);Near;Forward;
Procedure PDPutSet(Var Q:Prompt);Near;Forward;
Procedure PDVol(Var Q:Prompt);Near;Forward;
Procedure PDChDir(Var Q:Prompt);Near;Forward;
Procedure PDCopy(Var Q:Prompt);Near;Forward;
Procedure PDDel(Var Q:Prompt;DelOption:DelOptionEnum);Near;Forward;
Procedure PDMkDir(Var Q:Prompt);Near;Forward;
Procedure PDRMDir(Var Q:Prompt);Near;Forward;
Procedure PDRunSetPrn(Var Q:Prompt);Near;Forward;
Procedure PDType(Var Q:Prompt);Near;Forward;
Function  PDExtract(Var Q:Prompt;CmpMsg:String):Bool;Near;Forward;
Function  PDExtractExt(Var Q:Prompt;P:Byte;Var Bar:Bool):String;Near;Forward;
Procedure PURunBanner(Var Q:Prompt);Near;Forward;
Function  PutStr(Var Q;Const Str:String):Boolean;Near;Forward;
Function  PutLine(Var Q;Const Str:String):Boolean;Near;Forward;

{ Cette proc‚dure ex‚cute du code TPU (Terminal Processing Unit) ex‚cut‚
 directement sur le terminal.
}

Procedure TPUProcess(Var Q:Prompt;Const CodeTPU;Var Output);Near;
Label
 Restart;
Var
 TPUByte:TByte Absolute CodeTPU;
 TPUString:String Absolute CodeTPU;
 OutputLong:LongInt Absolute Output;
 OutputLong2:Record
  Value:LongInt;
  Length:Byte;
 End Absolute Output;
 ID:Char;          { Identificateur }
Begin
 Repeat
ReStart:
  ID:=Char(TPUByte[0]);
  ASM INC Word Ptr CodeTPU;END;
  Case(ID)of
   #0:Break;
   tpuPutString:Begin
    PutLine(Q,TPUString);
    ASM
     {$IFDEF Real}
      LES DI,CodeTPU
      MOV AL,ES:[DI]
      MOV AH,0
      INC AX
      ADD Word Ptr CodeTPU,AX
     {$ELSE}
      LEA EAX,CodeTPU
      MOVZX AX,Byte Ptr [EAX]
      INC AX
      ADD Word Ptr CodeTPU,AX
     {$ENDIF}
    END;
   End;
   tpuPutLong:Begin
    PutStr(Q,IntToStr(OutputLong));
    ASM
     ADD Word Ptr Output,TYPE LongInt
    END;
   End;
   tpuPutLong2:Begin
    PutStr(Q,Str2(OutputLong2.Value,OutputLong2.Length));
    ASM
     ADD Word Ptr Output,TYPE LongInt+TYPE Byte
    END;
   End;
   tpuLn:PutLine(Q,'');
   Else Break;
  End;
 Until False;
End;

Procedure TPUProcessString(Var Q:Prompt;CodeTPUStr:String;Var Output);Near;Begin
 IncStr(CodeTPUStr,#0);
 TPUProcess(Q,CodeTPUStr[1],Output);
End;

Function GetPromptMode(Mode:Word):String;Begin
 GetPromptMode:='';
 Case(Mode)of
  piMSDOS:GetPromptMode:='MS-DOS';
  piDRDOS:GetPromptMode:='DR-DOS';
  piPCDOS:GetPromptMode:='PC-DOS';
  piFreeDOS:GetPromptMode:='FreeDOS';
  pi4DOS:GetPromptMode:='4DOS';
  piNDOS:GetPromptMode:='NDOS/Norton Utility';
  piMalteDOS:GetPromptMode:='Malte-DOS';
  piOS2:GetPromptMode:='OS/2';
  piWindows9X:GetPromptMode:='Windows 9X';
  piVAX:GetPromptMode:='VAX/Alpha-VMS';
  piUnix:GetPromptMode:='Unix';
  piLinux:GetPromptMode:='Linux';
  piXenix:GetPromptMode:='Xenix';
  piDOS:GetPromptMode:='DOS';
  piAmigaDOS:GetPromptMode:='AmigaDOS';
  pi4DOS or piNDOS:GetPromptMode:='4DOS/NDOS';
 End;
End;

Function PDConvPath2DOS(Var Q:Prompt;Const Source:String):String;
Var
 S:String;
 P:Integer;
Begin
 S:=Source;
 Case(Q.Convention)of
  pUnix:Begin
   ChgChr(S,'/','\');
   ChgChr(S,':',';');
   If CmpLeft(S,'\dev\fd0')Then S:='A:\'+Copy(S,9,255)Else
   If CmpLeft(S,'\dev\fd1')Then S:='B:\'+Copy(S,9,255)Else
  End;
  pVAX:Begin
   S:=DelChr(S,'[');
   P:=Pos(']',S);
   If P>0Then Begin
    If S[P-1]<>'.'Then S[P]:='\'
                  Else DelChrAt(S,P);
    While P>0do Begin
     If S[P]='.'Then S[P]:='\';
     Dec(P);
    End;
   End;
  End;
 End;
 PDConvPath2DOS:=S;
End;

Function PDConvDOS2Path(Var Q:Prompt;Const Source:String):String;
Var
 S:String;
 D:String;
 N:NameStr;
 E:ExtStr;
Begin
 S:=Source;
 Case(Q.Convention)of
  pUnix:Begin
   ChgChr(S,'/','\');
   If S[1]<>'\'Then S:=FileExpand({SetPath4AddFile(Q.PathUnix)+}S);
   S:=Path2Dir(S);
   ChgChr(S,'\','/');
   If StrI(2,S)=':'Then S:=DelStr(S,1,2);
   S:=StrDn(S);
  End;
  pVAX:Begin
   If S[Length(S)]='\'Then Begin
    D:=S;
    N:='';
    E:='';
   End
    Else
   FSplit(S,D,N,E);
   ChgChr(D,'\','.');
   If D[Length(D)]='.'Then BackStr(D);
   If(Length(D)>=2)and(IsRomanLetter(D[1]))and(D[2]=':')Then Begin
    S:=Left(D,2)+'['+Copy(D,3,255)+']'+N+E;
   End
    Else
   Begin
    S:='['+D+']'+N+E;
   End;
  End;
 End;
 PDConvDOS2Path:=S;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                             Proc‚dure Ln                             Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: Prompt et Munix
 Portabilit‚:  Local


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de passer … la ligne suivante dans un "shell" ou
 interpr‚teur de format DOS ou Unix selon le standard Isatex.
}

Procedure Ln(Var Q);Begin
 WEAnsiLn(Prompt(Q).Ansi);
  {Vide la ligne image dans la liste image}
 If Prompt(Q).TmpImageLst=''Then ALAddLn(Prompt(Q).ImageLst)
                            Else ALAddStr(Prompt(Q).ImageLst,Prompt(Q).TmpImageLst);
 If(Prompt(Q).ImageLst.Count>LimitImage)Then Begin
   {Effacer la premiŠre ligne de la liste, c'est n‚cessaire la}
   {plus ancienne de cette liste.}
  ALDelBuf(Prompt(Q).ImageLst,0);
 End;
 Prompt(Q).TmpImageLst:='';
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                             Fonction PutStr                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: Prompt et Munix
 Portabilit‚:  Local


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet d'afficher un message sur le terminal, "shell" ou
 interpr‚teur de format DOS ou Unix.
}

Function PutStr;Begin
 AddStr(Prompt(Q).TmpImageLst,Str);
 PutStr:=WEPutPas(Prompt(Q).Ansi,Str)
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure PutLine                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: Wins
 Portabilit‚:  Local


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet d'afficher une ligne d'affichage de format ANSI
 dans la boŒte de dialogue de fenˆtre de l'objet ®Wins¯.
}

Function PutLine{Var Q;Const Str:String):Boolean};Begin
 PutLine:=PutStr(Q,Str);
 Ln(Q)
End;

{$I Library\CopyFile.Inc}
{$I Library\MoveFile.Inc}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Proc‚dure ExecPrg                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'ex‚cuter avec des param‚trages une application
 externe quelconque se contentant de la m‚moire actuellement disponible.


 Remarque
 ÍÍÍÍÍÍÍÍ

  ş Cette proc‚dure prend l'initiative de marquer dans le journal de bord
    le fichier allant ˆtre ex‚cut‚.
}

Procedure ExecPrg;
Var
 MS:ImgRec;
 {$IFDEF HeapVram}
  OldHeapVram:Boolean;
 {$ENDIF}
 TS:String;
 Mode:Byte;
 FX:Boolean;
 J:Word;
 SaveInt9Bh,SaveInt9Ch:Pointer;
 UMB:Boolean;
 MX,MY,MB:Word;

 Procedure PutErr(X:Byte);
 Var
  S:String;
 Begin
  If GetSysErr>0Then Begin
   If Not(IsGrf)Then SetBlink(False);
   Case(X)of
    0:S:='Sauve l''‚cran d''application';
    1:S:='Restaure l''‚cran de sortie';
    2:S:='Ex‚cution du programme';
    3:S:='Sauve l''‚cran de sortie';
    4:S:='Restaure l''‚cran d''application';
   End;
   ErrMsgOk(S+': '+GetErrMsg(GetSysErr));
   If Not(IsGrf)Then SetBlink(False);
  End;
 End;

Begin
 DialTimer:=False;
 {$IFDEF HeapVram}
  OldHeapVram:=HeapVram;
 {$ENDIF}
 {$IFNDEF NotReal}
  UMB:=SysPlus.NumBlocks>0;
  If(UMB)Then DoneExtendHeap;
 {$ENDIF}
 FX:=(IsVGA)and(Not IsGrf)and(Name='')and(Param='')and(NmYPixels<512){and(NmXTxts=80)and(NmYTxts=25)};
 GetMouseSwitch(MX,MY,MB);
 __HideMousePtr;
 If Name<>'QUICKSHELL'Then Begin
  If(FX)Then Begin
   PCopy(0,1);
   SetVisualPg(1);
   SplitScreen(GetNmYPixels)
  End;
  PushScr(MS);
  PutErr(0);
  {$IFDEF HeapVram}
   HeapVram:=No;
  {$ENDIF}
  PopScr(Output);
  PutErr(1);
  If(FX)Then Begin
   For J:=GetNmYPixels shr 3downto 0do Begin
    SplitScreen(J shl 3);
    WaitRetrace;
   End;
   SetVisualPg(0);
  End;
 End;
 If Not(IsGraf)Then SetBlink(True);
 SimpleCur;
 If Name=''Then Begin
  Name:=GetEnv('COMSPEC');
  If Param<>''Then InsStr(Param,1,'/C')
  Else WriteLn('Taper "EXIT"<ENTER> pour revenir … l''application...');
 End;
 TS:='Ex‚cute: '+Name;
 If Param<>''Then IncStr(TS,' ');
 WriteLog(TS+Param);
 {$IFNDEF NotReal}
  FreeMaxHeap;
 {$ENDIF}
 Mode:=CurrVideoMode;
  { Pr‚serve les interruptions de gestion de la m‚moire de
    l'ensemble Malte Genesis }
 GetIntVec($9B,SaveInt9Bh);
 GetIntVec($9C,SaveInt9Ch);
 If Name='QUICKSHELL'Then Exec(GetEnv('COMSPEC'),'/C'+Param)
                     Else Exec(Name,Param);
 GetSysErr:=SysErr;
  { Restitue les interruptions de gestion de la m‚moire de
    l'ensemble Malte Genesis }
 SetIntVec($9B,SaveInt9Bh);
 SetIntVec($9C,SaveInt9Ch);
 {$IFNDEF NotReal}
  MaxExpandHeap;
 {$ENDIF}
{ If(Mode<>CurrVideoMode)Then SetVideoMode(DefaultMode);
 SetLuxe;}
 If Name<>'QUICKSHELL'Then Begin
  PutErr(2);
  PushScr(Output);
  PutErr(3);
  If(FX)Then FX:=Mode=CurrVideoMode;
  If(FX)Then Begin
   PCopy(0,2);
   SetVisualPg(2);
   SplitScreen(GetNmYPixels)
  End;
  {$IFDEF HeapVram}HeapVram:=OldHeapVram;{$ENDIF}
  PopScr(MS);
  PutErr(4);
  If(FX)Then Begin
   PCopy(0,1);
   SetVisualPg(1);
   PCopy(2,0);
   For J:=0to GetNmYPixels shr 3do Begin
    SplitScreen(J shl 3);
    WaitRetrace;
   End;
   PCopy(1,0);
   SplitScreen(GetNmYPixels);
   SetVisualPg(0);
  End;
 End
  Else
 If Not(IsGraf)Then SetBlink(No);
 {$IFNDEF NotReal}
  If(UMB)Then ExtendHeap;
 {$ENDIF}
 SetMousePos(MX,MY);
 __ShowMousePtr;
 DialTimer:=True;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Fonction GetPromptPrn                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette fonction retourne la sortie d'imprimante courante sous forme de
  chaŒne de caractŠres de format Pascal.
}

Function GetPromptPrn:String;Near;Begin
 Case(PrnOutput)of
  poLPT1:GetPromptPrn:='LPT1:';
  poLPT2:GetPromptPrn:='LPT2:';
  poLPT3:GetPromptPrn:='LPT3:';
  poLPT4:GetPromptPrn:='LPT4:';
  poCom1:GetPromptPrn:='COM1:';
  poCom2:GetPromptPrn:='COM2:';
  poCom3:GetPromptPrn:='COM3:';
  poCom4:GetPromptPrn:='COM4:';
  poCom5:GetPromptPrn:='COM5:';
  poCom6:GetPromptPrn:='COM6:';
  poCom7:GetPromptPrn:='COM7:';
  poCom8:GetPromptPrn:='COM8:';
  poFile:GetPromptPrn:='FILE:';
  poNUL:GetPromptPrn:='NUL';
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure DumpHelp                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette proc‚dure affiche dans une fenˆtre de l'aide en ligne pour des
  Shell par exemple … partir d'un fichier de format RLL.
}

Procedure DumpHelp(Var Q:Window;Const Path:String;Index:Word);Near;Begin
 WETypeFile(Q,FSearch(Path,';'+MaltePath+'HLP;'+MaltePath+'HELP;'+MaltePath)+':'+WordToStr(Index));
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure DumpHelpDos                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette proc‚dure affiche dans une fenˆtre de l'aide en ligne pour des
  Shell DOS … partir d'un fichier de format RLL.
}

Procedure DumpHelpDos(Var Q:Window;Index:Word);Near;Begin
 DumpHelp(Q,'DOS.HLP',Index)
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure DumpHelpUnix                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette proc‚dure affiche dans une fenˆtre de l'aide en ligne pour des
  Shell Unix … partir d'un fichier de format RLL.
}

Procedure DumpHelpUnix(Var Q:Window;Index:Word);Near;Begin
 DumpHelp(Q,'UNIX.HLP',Index)
End;

{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                          Fonction HYFree                          Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Propri‚taire: History


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette fonction permet de connaŒtre l'espace disponible … travers une
  histoire.
}

Function HYFree(Var Q:History):Word;Near;Begin
 HYFree:=Q.SizeCmd-(PtrRec(Q.Tail).Ofs-PtrRec(Q.Cmd).Ofs)
End;

{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                         Fonction HYDelete                      Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Propri‚taire: History


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette fonction permet d'effacer un item de la liste d'histoire en
  cherchant un item correspondant … la variable de param‚trage ®S¯.
}

Function HYDelete(Var Q:History;Const S:String):Boolean;Near;
Var
 L:Word;
Begin
 {$IFDEF FLAT386}
 {$ELSE}
  HYDelete:=No;Q.Ptr:=Q.Tail;L:=0;
  While Pointer(Q.Ptr)<>Pointer(Q.Cmd)do Begin
   Dec(PtrRec(Q.Ptr).Ofs);Inc(L,Length(Q.Ptr^)+2);
   Dec(PtrRec(Q.Ptr).Ofs,Length(Q.Ptr^)+1);
   If(Q.Ptr^=S)Then Begin
    MoveLeft(Mem[PtrRec(Q.Ptr).Seg:PtrRec(Q.Ptr).Ofs+Length(Q.Ptr^)+2],Q.Ptr^,L);
    HYDelete:=True;
    Break;
   End;
  End;
 {$ENDIF}
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Fonction PDExtractExt                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet d'extraire le num‚ro  de paramŠtres sp‚cifi‚e dans
 une chaŒne de caractŠres de format Pascal avec un style de param‚trage de
 style DOS ou Unix.
}

Function PDExtractExt(Var Q:Prompt;P:Byte;Var Bar:Boolean):String;
Label Xit;
Var
 I,N,E:Byte;
 Str,Ex2:String;
 Elem,Sep:Set of Char;
Begin
 PDExtractExt:='';
 If Q.Ext=''Then Begin
  Bar:=False;
  Exit;
 End;
 If(Q.Convention=pUnix)Then Elem:=['-']
                       Else Elem:=['/'];
 Sep:=Elem+[' '];
 N:=1;{I:=1;}
 Ex2:=LTrim(Q.Ext);
 If Ex2=''Then Exit;
 If Ex2[1]='"'Then I:=1 Else I:=2;
 If(Length(Ex2)=1)and(P=1)Then Begin
  Str:=Ex2;
  Goto Xit;
 End;
 Bar:=False;
 While Not(Ex2[I]in Sep)and(I<Length(Ex2))do Begin
  If Not(Q.Convention=pUnix)Then Begin
   If Ex2[I]='"'Then Begin { ChaŒne de caractŠre comme paramŠtre? }
    Inc(I);
    While(Ex2[I]<>'"')and(I<Length(Ex2))do Inc(I);
   End;
  End;
  Inc(I);
 End;
 If(P=N)Then Begin
  Str:=Trim(Left(Ex2,I));
  If Length(Str)>0Then Begin
   If(Str[1]in Elem)Then Begin
    Bar:=True;
    If Length(Str)=1Then Str:=''
                    Else Str:=Copy(Str,2,Length(Str)-1);
   End;
  End;
  Goto Xit;
 End
  Else
 Inc(N);
 While I<Length(Ex2)do Begin
  Bar:=Ex2[I]in Elem;
  If(Ex2[I]=' ')or(Bar)Then Begin
   If(Ex2[I+1]in Elem)Then Begin
    Bar:=True;
    Ex2:=DelStr(Ex2,I+1,1);
   End;
   Inc(I);E:=I;
   While Not(Ex2[E]in Sep)and(Length(Ex2)>E)do Inc(E);
   If(N=P)Then Begin
    Str:=RTrim(Copy(Ex2,I,E-I+1));
Xit:If(Not(Bar))and(Q.Convention<>pDOS)Then Begin
     If Not(Str[1]in['"'])Then Str:=PDConvPath2Dos(Q,Str);
    End;
    If(Q.Convention<>pUnix)Then Str:=StrUp(Str);
    PDExtractExt:=Str;
    Exit;
   End
    Else
   Inc(N);
   I:=E;
  End
   Else
  Inc(I);
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Fonction PDMaxExtractExt                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction retourne le nombre de paramŠtres contenu dans la chaŒne
 de caractŠres de format Pascal et de style Unix ou DOS.
}

Function PDMaxExtractExt(Var Q:Prompt):Byte;Near;
Var
 I,N,E:Byte;
 Ex2:String;
 Elem,Sep:Set of Char;
Begin
 Ex2:=Q.Ext;
 If Ex2=''Then Begin
  PDMaxExtractExt:=0;
  Exit;
 End;
 If(Q.Convention=pUnix)Then Elem:=['-']
                       Else Elem:=['/'];
 Sep:=Elem+[' '];N:=0;
 If Ex2[1]='"'Then I:=1 Else I:=2;
 While Not(Ex2[I]in Sep)and(I<Length(Ex2))do Begin
  If Not(Q.Convention=pUnix)Then Begin
   If Ex2[I]='"'Then Begin { ChaŒne de caractŠre comme paramŠtre? }
    Inc(I);
    While(Ex2[I]<>'"')and(I<Length(Ex2))do Inc(I);
   End;
  End;
  Inc(I);
 End;
 Inc(N);
 While I<Length(Ex2)do Begin
  If(Ex2[I]in Sep)Then Begin
   If(Ex2[I+1]in Elem)Then Ex2:=DelStr(Ex2,I+1,1);
   Inc(I);E:=I;
   While Not(Ex2[E]in Sep)and(Length(Ex2)>E)do Inc(E);
   I:=E; Inc(N);
  End
   Else
  Inc(I);
 End;
 PDMaxExtractExt:=N;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Proc‚dure WEPutTxtSPSPS                  Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: Prompt ou Munix
 Portabilit‚:  Local


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'imprimer une justaposition de chaŒnes de
 caractŠres de diff‚rent format.
}

Procedure WEPutTxtSPSPS(Var W;Const S1:String;P1:PChr;Const S2:String;
                        P2:PChr;Const S3:String);Near;Begin
 PutStr(W,S1+StrPas(P1)+S2+StrPas(P2)+S3)
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ·}
{³                O b j e t  ® S h e l l  D o s ¯              º}
{ÔÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼}

{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                           Constructeur PDInit                        Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Propri‚taire: Prompt


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Ce constructeur permet d'initialiser la boŒte de dialogue du prompt DOS
  de l'objet ®Prompt¯.
}

Function PDInit;Begin
 PDInit:=PDInitMode(Context,X1,Y1,X2,Y2,piDOS);
End;

{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                        Constructeur PDInitMode                        Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Propri‚taire: Prompt


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Ce constructeur permet d'initialiser la boŒte de dialogue avec le prompt
  d‚sirer de l'objet ®Prompt¯.
}

Function PDInitMode(Var Context;X1,Y1,X2,Y2:Byte;Mode:Word):Boolean;
Var
 Q:Prompt Absolute Context;
Begin
 FillClr(Q,SizeOf(Q));
 Q.Mode:=Mode;
 If Mode and piDOS>0Then Q.Convention:=pDOS Else
 If Mode and piVAX>0Then Begin
  Q.Convention:=pVAX;
  Q.CmdSearch:=[soNotStrict];
 End
  Else
 Begin
  Q.Convention:=pUnix;
  Q.PS1:='$';
  Q.PS2:='>';
  Q.PathVar:=':/bin:/usr/bin';
  Q.PathUnix:=GetCurrentDir;
 End;
 HYInitTo(Q.H,512,@Q.History.Buffer);
 If ReadMainKey(HKEY_CURRENT_USER,'Software\Prompt\History',WordToStr(Mode),Q.History)Then Begin
  HYSetSizeBuffer(Q.H,Q.History.EndCmd);
 End;
 HYInit(Q.Alias,1024);
 WEInit(Q.Ansi,X1,Y1,X2,Y2);
 Q.Echo:=True;
 PDRefresh(Q);
 If(Q.Ansi.MaxY=MaxYTxts)Then Begin
  WEPutTxtLn(Q.Ansi,'Interpr‚teur de commande version 3.01');
  WEPutTxtLn(Q.Ansi,'Tous droits r‚serv‚s par les Chevaliers de Malte 1992-2002');
  Ln(Q);
 End;
 PDInitMode:=True;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure PDReSize                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: Prompt


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

   Cette proc‚dure permet de change la taille de la fenˆtre de l'‚diteur
  de traŒtement de texte de l'objet ®Prompt¯.
}

Procedure PDReSize;
Var
 Y:Byte;
Begin
 Y:=Prompt(Q).Ansi.Y;
 WEDone(Prompt(Q).Ansi);
 WEInit(Prompt(Q).Ansi,X1,Y1,X2,Y2);
 If Prompt(Q).Ansi.MaxY<Prompt(Q).ImageLst.Count-1Then Y:=Prompt(Q).Ansi.MaxY;
 Prompt(Q).Ansi.Y:=Y;
 PDRefresh(Q);
End;

Procedure PDMove2(Var Context;X,Y:Byte);
Var
 Q:Prompt Absolute Context;
Begin
 PDReSize(Q,X,Y,X+Q.Ansi.T.X2-Q.Ansi.T.X1,Y+Q.Ansi.T.Y2-Q.Ansi.T.Y1);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Proc‚dure PDUpDateEcho                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: Prompt


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'afficher la barre d'‚tat de la boŒte de dialogue
 du prompt DOS de l'objet ®Prompt¯.
}

Procedure PDUpDateEcho(Var Q:Prompt);
Var
 S:String;
Begin
 If(Q.Ansi.MaxY<>MaxYTxts)Then Begin
  If(Q.Echo)Then Begin
   If(Q.Convention=pUnix)Then S:='echo'
                         Else S:='ECHO';
  End
   Else
  S:=Spc(4);
  WESetEndBarTxtX(Q.Ansi,1,S,CurrKrs.Desktop.DialStatus);
  WESetEndBarTxtX(Q.Ansi,8,GetPromptMode(Q.Mode),CurrKrs.Desktop.DialStatus);
 End;
End;

{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                          Proc‚dure PDRefresh                         Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Propri‚taire: Prompt


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette proc‚dure permet de restitu‚e l'‚tat de la fenˆtre de dialogue de
  prompt DOS.
}

Procedure PDRefresh;
Var
 I,Y:Byte;
 PC:PChr;
 Q:Prompt Absolute Context;
Begin
 Y:=Q.Ansi.Y;
 WEPutWn(Q.Ansi,PDTitle(Q,Q.Ansi.MaxX),CurrKrs.MalteDos.Window);
 If(Q.Ansi.MaxY<>MaxYTxts)Then Begin
  WECloseIcon(Q.Ansi);
  WEZoomIcon(Q.Ansi);
  WESetEndBar(Q.Ansi,CurrKrs.Desktop.DialStatus);
  If(IsGrf)Then Begin
   BarSpcHorRelief(Q.Ansi.T.X1,Q.Ansi.T.Y2,Q.Ansi.T.X1+6,CurrKrs.Desktop.DialStatus);
   BarSpcHorReliefExt(Q.Ansi.T.X1+1,Q.Ansi.T.Y2,Q.Ansi.T.X1+5,CurrKrs.Desktop.DialStatus);
   BarSpcHorRelief(Q.Ansi.T.X1+7,Q.Ansi.T.Y2,Q.Ansi.T.X2,CurrKrs.Desktop.DialStatus);
   BarSpcHorReliefExt(Q.Ansi.T.X1+8,Q.Ansi.T.Y2,Q.Ansi.T.X2-1,CurrKrs.Desktop.DialStatus);
  End
   Else
  WESetEndBarTxtX(Q.Ansi,6,'³',CurrKrs.Desktop.DialStatus);
  PDUpDateEcho(Q)
 End;
 If Q.ImageLst.Count>0Then Begin
  WESetKr(Q.Ansi,CurrKrs.MalteDos.Env.Default);
  If(Q.ImageLst.Count<Q.Ansi.MaxY)Then ALSetPtr(Q.ImageLst,0)
                                  Else ALSetPtr(Q.ImageLst,Q.ImageLst.Count-Q.Ansi.MaxY);
  For I:=0to(Q.Ansi.MaxY)do Begin
   PC:=_ALGetCurrBuf(Q.ImageLst);
   WEPutTxtXY(Q.Ansi,0,I,StrPas(PC));
   ALNext(Q.ImageLst);
  End;
  Q.Ansi.Y:=Y;
 End;
End;

{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                         Proc‚dure PDAlias                        Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Propri‚taire: Prompt


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette proc‚dure permet d'ex‚cuter une commande ®ALIAS¯ du 4DOS/NDOS
  effectuant un traŒtement des alias.
}

Procedure PDAlias(Var Q:Prompt);
Label Lst,Xit;
Const Syn='ALIAS [/P] [/R [unit‚:][chemin]nomfichier...] [nom[=][valeur]';
Var
 M,I,J:Byte;
 Bar:Boolean;
 Handle:Hdl;
 S:String;
 FP,FS:LongInt;
Begin
 M:=Q.NP;
 If M>0Then Begin
  Bar:=False;I:=1;
  If(PDExtractExt(Q,1,Bar)='?')and(Bar)Then DumpHelpDos(Q.Ansi,HelpDosAlias)
   Else
  Begin
   Bar:=No;
   If(PDExtractExt(Q,I,Bar)='P')and(Bar)Then Begin
    WESetPause(Q.Ansi,True);
    If M=1Then Goto Lst;
    Inc(I);
   End;
   Bar:=No;
   If(PDExtractExt(Q,I,Bar)='R')and(Bar)Then Begin
    Bar:=No;Inc(I);S:=PDExtractExt(Q,I,Bar);
    If(Bar)or(S='')Then Begin
     PutLine(Q,'Erreur: Nom de fichier attendu aprŠs /R');
     Ln(Q);
     PutLine(Q,Syn);
     Goto Xit;
    End;
    Inc(I);
    Handle:=FileOpen(S,fmRead);
    If(Handle=errHdl)Then Begin
     PutLine(Q,'Erreur: Impossible d''ouvrir le fichier "'+S+'"!');
     Ln(Q);
     PutLine(Q,Syn);
    End;
    FS:=FileSize(Handle);
    Repeat
     __GetAbsFileTxtLn(Handle,FP,S);
     If S<>''Then Begin
      If HYFree(Q.Alias)>Length(S)+2Then HYQueue(Q.Alias,S)
       Else
      Begin
       PutLine(Q,'Erreur: Tampon des alias trop petit!');
       Break;
      End;
     End;
    Until FP>=FS;
    FileClose(Handle);
   End;
   If(I>M)Then Goto Xit;
   If I=1Then S:=Q.Ext
    Else
   Begin
    M:=1;
    For J:=1to Length(Q.Ext)do Begin
     If Q.Ext[J]=' 'Then Begin
      Inc(M);
      If(M=I)Then Break;
     End;
    End;
    S:=Copy(Q.Ext,J+1,255)
   End;
   For J:=1to Length(S)do If S[J]in[' ','=']Then Break;
   If S[J]=' 'Then S[J]:='=';
   If J=Length(S)Then Begin
    BackStr(S);
    HYDelete(Q.Alias,StrUp(S))
   End
    Else
   HYQueue(Q.Alias,StrUp(S));
  End;
Xit:
  WESetPause(Q.Ansi,False);
  Exit;
 End;
Lst:
 If Pointer(Q.Alias.Tail)=Pointer(Q.Alias.Cmd)Then PutLine(Q,'Aucun alias en m‚moire')
  Else
 Begin
  Q.Alias.Ptr:=Q.Alias.Tail;
  While Pointer(Q.Alias.Ptr)<>Pointer(Q.Alias.Cmd)do Begin
   Dec(PtrRec(Q.Alias.Ptr).Ofs);
   Dec(PtrRec(Q.Alias.Ptr).Ofs,Length(Q.Alias.Ptr^)+1);
   PutLine(Q,Q.Alias.Ptr^);
  End;
 End;
 WESetPause(Q.Ansi,No);
End;

{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                         Proc‚dure PDBeep                        Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Propri‚taire: Prompt


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette proc‚dure permet d'ex‚cuter une commande ®BEEP¯ du 4DOS/NDOS
  effectuant un signal sonore d'avertissement utilisateur.
}

Procedure PDBeep(Var Q:Prompt);
Var
 Bar:Boolean;
Begin
 If Q.NP>0Then Begin
  Bar:=False;
  If(PDExtractExt(Q,1,Bar)='?')and(Bar)Then DumpHelpDos(Q.Ansi,HelpDosBeep)
   Else
  Begin
   PutLine(Q,'Erreur: ParamŠtres non requis!');
   Ln(Q);
   PutLine(Q,'BEEP [/?]');
  End;
 End
  Else
 Beep;
End;

{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                         Proc‚dure PDBE                          Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Propri‚taire: Prompt


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette proc‚dure permet d'‚muler les commandes du Norton Utility ou
  du Norton Desktop de Symantec.
}

Procedure PDBE(Var Q:Prompt);
Var
 Bar,OldShade:Boolean;
 S:String;
 I,Kr,XH,YH:Byte;
 CP:Array[2..5]of Byte;

 Function ExtractKr:Byte;
 Var
  Kr:Byte;
 Begin
  Kr:=CurrKrs.MalteDos.Window.Border;
  Bar:=No;S:=PDExtractExt(Q,I,Bar);
  If S='BRIGHT'Then Begin
   Kr:=Kr or$80;
   Inc(I);
   Bar:=No;S:=PDExtractExt(Q,I,Bar);
  End;
  Repeat
   If S='BLACK'Then Kr:=Kr and$8F Else
   If S='BLUE'Then Kr:=(Kr and$8F)or$10 Else
   If S='GREEN'Then Kr:=(Kr and$8F)or$20 Else
   If S='CYAN'Then Kr:=(Kr and$8F)or$30 Else
   If S='RED'Then Kr:=(Kr and$8F)or$40 Else
   If S='MAGENTA'Then Kr:=(Kr and$8F)or$50 Else
   If S='BROWN'Then Kr:=(Kr and$8F)or$60 Else
   If S='GRAY'Then Kr:=(Kr and$8F)or$70 Else
   If S='LIGHTGRAY'Then Kr:=(Kr and$F)or$70 Else
   If S='DARKGRAY'Then Kr:=(Kr and$F)or$80 Else
   If S='LIGHTBLUE'Then Kr:=(Kr and$F)or$90 Else
   If S='LIGHTGREEN'Then Kr:=(Kr and$F)or$A0 Else
   If S='LIGHTCYAN'Then Kr:=(Kr and$F)or$B0 Else
   If S='LIGHTRED'Then Kr:=(Kr and$F)or$C0 Else
   If S='LIGHTMAGENTA'Then Kr:=(Kr and$F)or$D0 Else
   If S='YELLOW'Then Kr:=(Kr and$F)or$E0 Else
   If S='WHITE'Then Kr:=Kr or$F0
               Else Break;
   Inc(I);
   Bar:=False;
   S:=PDExtractExt(Q,I,Bar);
   If S='ON'Then Begin
    Inc(I);Bar:=False;
    S:=PDExtractExt(Q,I,Bar);
   End
    Else
   Break;
   If S='BRIGHT'Then Begin
    Kr:=Kr or$8;
    Inc(I);Bar:=False;
    S:=PDExtractExt(Q,I,Bar);
   End;
   If S='BLACK'Then Kr:=Kr and$F8 Else
   If S='BLUE'Then Kr:=(Kr and$F8)or$1 Else
   If S='GREEN'Then Kr:=(Kr and$F8)or$2 Else
   If S='CYAN'Then Kr:=(Kr and$F8)or$3 Else
   If S='RED'Then Kr:=(Kr and$F8)or$4 Else
   If S='MAGENTA'Then Kr:=(Kr and$F8)or$5 Else
   If S='BROWN'Then Kr:=(Kr and$F8)or$6 Else
   If S='GRAY'Then Kr:=(Kr and$F8)or$7 Else
   If S='LIGHTGRAY'Then Kr:=(Kr and$F0)or$7 Else
   If S='DARKGRAY'Then Kr:=(Kr and$F0)or$8 Else
   If S='LIGHTBLUE'Then Kr:=(Kr and$F0)or$9 Else
   If S='LIGHTGREEN'Then Kr:=(Kr and$F0)or$A Else
   If S='LIGHTCYAN'Then Kr:=(Kr and$F0)or$B Else
   If S='LIGHTRED'Then Kr:=(Kr and$F0)or$C Else
   If S='LIGHTMAGENTA'Then Kr:=(Kr and$F0)or$D Else
   If S='YELLOW'Then Kr:=(Kr and$F0)or$E Else
   If S='WHITE'Then Kr:=Kr or$F
               Else Break;
  Until True;
  ExtractKr:=Kr;
 End;

Begin
 If Q.NP>0Then Begin
  Bar:=No;S:=PDExtractExt(Q,1,Bar);
  If(S='?')and(Bar)Then DumpHelpDos(Q.Ansi,HelpDosBE)
   Else
  If S='BOX'Then Begin
   Kr:=CurrKrs.MalteDos.Window.Border;
   For I:=2to 5do Begin
    Bar:=False;
    CP[I]:=StrToWord(PDExtractExt(Q,I,Bar));
   End;
   XH:=WEGetRX1(Q.Ansi);YH:=WEGetRY1(Q.Ansi);Inc(I);
   SetBorderDouble;
   If Q.NP>=6Then Begin
    S:=PDExtractExt(Q,I,Bar);
    If S='AVENGER'Then Begin
     SetBorderAvenger;
     Inc(I);
    End
     Else
    If S='SINGLE'Then Begin
     SetBorderSimple;
     Inc(I);
    End
     Else
    If S='DOUBLE'Then Begin
     SetBorderDouble;
     Inc(I);
    End;
    Kr:=ExtractKr;
   End;
   OldShade:=GetShade;
   SetShade(No);
   PutFillBorder(CP[3]+XH,CP[2]+YH,CP[5]+XH,CP[4]+YH,Kr);
   SetShade(OldShade);
  End
   Else
  If S='CLS'Then Begin
   I:=2;Kr:=ExtractKr;
   WESetKr(Q.Ansi,Kr);
   WEClrScr(Q.Ansi);
  End
   Else
  Begin
   PutLine(Q,'Erreur: Commande non reconnu!');
   Ln(Q);
   PutLine(Q,'BE [/?]');
  End;
 End;
End;

{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                       Proc‚dure PDChDir                        Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Propri‚taire: Prompt


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette proc‚dure ex‚cute la commande du prompt DOS ®CD¯ et ®CHDIR¯
  permettant de changer de r‚pertoire courant.
}

Procedure PDChDir;
Var
 Bar:Boolean;
Begin
 If Q.NP>0Then Begin
  Bar:=False;
  If(PDExtractExt(Q,1,Bar)='?')and(Bar)Then DumpHelpDos(Q.Ansi,HelpDosChDir)
   Else
  If Q.NP>1Then Begin
   PutLine(Q,'Erreur: Trop de paramŠtre!');
   Ln(Q);
   PutLine(Q,'CHDIR|CD [r‚pertoire]');
  End
   Else
  Begin
   System.ChDir(Q.Ext);
   If IoResult<>0Then PutLine(Q,'Erreur de changement de r‚pertoire');
  End;
 End
  Else
 PDPutCurrentPath(Q);
End;

{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                       Proc‚dure PDConfig                       Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Propri‚taire: Prompt


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette proc‚dure permet d'ex‚cuter la commande ®CONFIG¯ s'occupant
  d'afficher l'‚tat actuel du mat‚riel.
}

{$I Library\Disk\CDROM\Number.Inc}
{$I Library\System\OSStr.Inc}

Procedure PDConfig(Var Q:Prompt);
Var
 S:String;
 F,Bar:Boolean;
 PC:PChr;
 SizeOf_:Word;
 _PVid:Array[0..1]of PIV;
Begin
 If Q.NP>0Then Begin
  Bar:=False;
  If(PDExtractExt(Q,1,Bar)='?')and(Bar)Then DumpHelpDos(Q.Ansi,HelpDosConfig)
   Else
  Begin
   PutLine(Q,'Erreur: ParamŠtres non requis!');
   Ln(Q);
   PutLine(Q,'CONFIG [/?]');
  End;
 End
  Else
 Begin
  WESetPause(Q.Ansi,True);
  If(Up32Bits)Then S:='32-bits'Else
  If(CPU)in[cpu8088,cpuV20,cpu80188]Then S:='8-bits'
                                    Else S:='16-bits';
  PutStr(Q,'CPU: '+SelectField('CHANTAL:/Materiel/CPUModele.Dat',CPU,1)+' en '+S+', Bus: ');
  Case(Bus)of
   busUnknown:S:='inconnue';
   busISA8:S:='ISA, 8-bits';
   busISA16:S:='ISA, 16-bits';
   busISAPCI:S:='ISA/PCI';
   busEISA:S:='EISA';
   busMCA:S:='MCA';
  End;
  PutLine(Q,S);
  PutLine(Q,'SystŠme d''exploitation:');
  PutLine(Q,' DOS Version '+WordToStr(Lo(GetDosVer))+'.'+WordToStr(Hi(GetDosVer)));
  PutLine(Q,' '+OperatingSystemStr);
  PutStr(Q,' Handle support‚: ');
  If(HandleExist)Then PutLine(Q,'Oui')Else PutLine(Q,'Non');
  PutLine(Q,'Sortie:');
  GetPIV(_PVid[0]);
  PutLine(Q,' Video: '+SelectField('CHANTAL:/Materiel/IDVideo.Dat',GetVideoCard,1)+
            ', '+CStr(_PVid[0].Memory shr 10)+' Ko');
  PutStr(Q,' Son: ');
  If(IsGravis)Then PutLine(Q,'Gravis Ultra Sound')Else
  If(IsSoundBlaster)Then PutLine(Q,'SoundBlaster')Else
  If(IsRoland)Then PutLine(Q,'Roland MPU-401')Else
  If(IsAdLib)Then PutLine(Q,'AdLib')Else
  If(IsTandyDigital)Then PutLine(Q,'Tandy Digital')
                    Else PutLine(Q,'PC Speaker');
  PutLine(Q,'P‚riph‚rique:');
  PutLine(Q,' Souris: '+GetStrMouse);
  PutLine(Q,' Clavier: '+SelectField('CHANTAL:/Materiel/Clavier/Modele.Dat',KbdModel,1));
  PutStr(Q,' Unit‚: ');
  F:=True;
  If NumberCDROM>0Then Begin
   PutStr(Q,'CD-ROM');
   F:=False;
  End;
  If(FloppyDskExist)Then Begin
   If Not(F)Then PutStr(Q,', ');
   PutStr(Q,'Unit‚ amovible');
   If NmFloppyDsk>1Then PutStr(Q,' x '+WordToStr(NmFloppyDsk));
   F:=False;
  End;
  If(HardDskExist)Then Begin
   If Not(F)Then PutStr(Q,', ');
   PutStr(Q,'Disque dur');
   If NmHardDsk>1Then PutStr(Q,' x '+WordToStr(NmHardDsk));
   F:=No;
  End;
  If(F)Then PutStr(Q,'Aucune');
  Ln(Q);
  PutLine(Q,'Pays:');
  PutLine(Q,' Code de pays:          '+Str0(CountryCode,3));
  PutLine(Q,' Code de page:          '+Str0(CodePage,3));
  S:=SelectField('CHANTAL:/Systeme/Date.Dat',Date,1);
  ChgChr(S,'/',DtSep[0]);
  PutStr(Q,' Format de date:        '+S);
  S:='';
  AddPChr(S,@DaSep);
  IncStr(S,' ');
  Case(Adele.Time)of
   AmPm:AddWdDec(S,12);
   Military:AddWdDec(S,24);
  End;
  AddPChr(S,@TmSep);
  PutStr(Q,S+'00');
  If(Adele.Time=AmPm)Then PutStr(Q,'am');
  Ln(Q);
  PutStr(Q,' Syntaxe de la monnaie: ');
  PutLine(Q,StrPas(@Curr)+CStr(1000)+StrPas(@DeSep)+Zero(Digits));
  PutStr(Q,' Format des nombres:    ');
  PutLine(Q,CStr(1234567)+StrPas(@DeSep)+CStr(890123));
  PutStr(Q,' S‚parateur de donn‚e:  ');
  PutLine(Q,'"'+StrPas(@DaSep)+'"');
  WESetPause(Q.Ansi,No)
 End;
End;

{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                         Proc‚dure PDCopy                           Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Propri‚taire: Prompt


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette proc‚dure permet d'ex‚cuter la commande ®COPY¯ du prompt du DOS
  copiant un/des fichier(s).
}

Procedure PDCopy;
Var
 Source,Target:PathStr;
 I,NP:Byte;
 Bar:Boolean;
 TStr:String;
 K:Word;

 Procedure CommandCopy(Const Source:String;Target:PathStr);Var Rec:SearchRec;TSource,TTarget:PathStr;Begin
  If IsWildCard(Source)Then Begin
   FindFirst(Source,fa,Rec);
   While SysErr=0do Begin
    TSource:=Path2Dir(Source)+Rec.Name;
    TTarget:=Src2Target(TSource,Target);
    PutLine(Q,TSource+' -> '+TTarget);
    CopyFile(TSource,TTarget);
    FindNext(Rec);
   End;
  End
   Else
  Begin
   If IsWildCard(Target)Then Target:=Src2Target(Rec.Name,Target)
			Else Target:=Src2Target(Source,Target);
   PutLine(Q,Source+' -> '+Target);
   CopyFile(Source,Target);
  End;
 End;

Begin
 If Q.NP>0Then Begin
  Bar:=False;
  If(PDExtractExt(Q,1,Bar)='?')and(Bar)Then Begin
   DumpHelpDos(Q.Ansi,HelpDosCopy);
   Exit;
  End;
  NP:=0;
  For I:=1to(Q.NP)do Begin
   TStr:=PDExtractExt(Q,I,Bar);
   If(Bar)Then Begin
    PutLine(Q,'Attention: Je ne connais pas le paramŠtre '+TStr+'.');
    Ln(Q);
    PutLine(Q,'Continue quand mˆme (O/N) ?');
    K:=ReadKey;
    If(K=kbEsc)or(ChrUp(Char(K))='N')Then Exit;
   End
    Else
   Begin
    Case(NP)of
     0:Source:=TStr;
     1:Target:=TStr;
     Else Begin
      PutLine(Q,'Erreur: Trop de r‚pertoire sp‚cifi‚!');
      Exit;
     End;
    End;
    Inc(NP);
   End;
  End;
  CommandCopy(Source,Target);
 End
  Else
 Begin
  If(Q.Convention=pUnix)Then Begin
   PutLine(Q,'Erreur: ParamŠtre requis pour commencer le copiage!');
   Ln(Q);
   PutLine(Q,'cp Source [Destination]');
  End
   Else
  Begin
   PutLine(Q,'Erreur: ParamŠtre requis pour commencer le copiage!');
   Ln(Q);
   PutLine(Q,'COPY Source [Destination]');
  End;
 End;
End;

{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                         Proc‚dure PDEcho                           Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Propri‚taire: Prompt


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette proc‚dure permet d'ex‚cuter la commande ®ECHO¯ du prompt du DOS.
}

Procedure PDEcho;
Var
 Str:String;
 Bar:Boolean;
Begin
 If Q.NP=0Then Begin
  PutStr(Q,'L''‚cho est ');
  If(Q.Echo)Then PutLine(Q,'ouvert')
            Else PutLine(Q,'fermer');
 End
  else
 Begin
  Bar:=No;
  If(PDExtractExt(Q,1,Bar)='?')and(Bar)Then DumpHelpDos(Q.Ansi,HelpDosEcho)
   Else
  Begin
   Str:=StrUp(Q.Ext);
   Repeat
    If Str='ON'Then Q.Echo:=True Else
    If Str='OFF'Then Q.Echo:=False
     Else
    Begin
     If Q.Ext<>'.'Then PutLine(Q,Q.Ext);
     Break;
    End;
    PDUpDateEcho(Q);
   Until True;
  End;
 End;
End;

{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                          Proc‚dure PDFree                      Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Propri‚taire: Prompt


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette proc‚dure permet d'ex‚cuter la commande ®FREE¯ du prompt de
  4DOS/NDOS.
}

Procedure PDFree;
Label Erreur;
Var
 I,J:Byte;
 TStr:String;
 Bar:Boolean;

 Procedure PutMsg(Dsk:Byte);
 Var
  L:LongInt;
 Begin
  Ln(Q);
  TStr:=GetDskLabel(Dsk+1);
  If TStr=''Then TStr:='inexistante';
  PutLine(Q,'Le volume de l''unit‚ '+Char(Dsk+65)+' est '+TStr);
  Ln(Q);
  L:=DiskSize(Dsk+1);
  If L=-1Then PutLine(Q,'L''espace est impossible … d‚terminer...')
   Else
  Begin
   PutLine(Q,CStr2(L,15)+' octet(s) en tous');
   PutLine(Q,CStr2(DiskFree(Dsk+1),15)+' octet(s) de libre');
  End;
 End;

Begin
 If Q.NP>0Then Begin
  Bar:=No;
  If(PDExtractExt(Q,1,Bar)='?')and(Bar)Then DumpHelpDos(Q.Ansi,HelpDosFree)
   Else
  For I:=1to(Q.NP)do Begin
   TStr:=StrUp(PDExtractExt(Q,I,Bar));
   If(Not(Bar))and(StrI(2,TStr)=':')Then Begin
    If(IsRomanLetter(TStr[1]))Then PutMsg(Byte(ChrUp(TStr[1]))-65)Else
    If TStr[1]in['?','*']Then Begin
     For J:=0to 25do If DiskExist(J)Then PutMsg(J);
    End
     Else
    Goto Erreur;
   End
    Else
   Begin
Erreur:
    PutLine(Q,'Erreur: Unit‚ invalide! (Exemple: A: C: ?:)');
    Break;
   End;
  End;
 End
  Else
 PutMsg(GetDsk);
End;

{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                       Proc‚dure PDLabel                     Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Propri‚taire: Prompt


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette proc‚dure permet d'ex‚cuter  l'‚quivalent de la commande
  ®LABEL¯ du systŠme d'exploitation DOS. Il demandera le nom d'un
  volume et le changera.
}

Procedure PDLabel(Var Q:Prompt);
Var
 I,Dsk:Byte;
 Buffer:Array[0..13]of Char;
 PBuffer:PChr;
 K:Word;
 ChrK:Char Absolute K;
 S:String;
 Bar:Boolean;

 Procedure SetDskUser;Begin
  S:=GetDskLabel(Dsk+1);
  If S=''Then S:='inexistant';
  PutLine(Q,'Le volume dans l''unit‚ '+Chr(Dsk+65)+' est '+S);
  PutLine(Q,'Le num‚ro de s‚rie du volume est '+GetSerialNmStr(Dsk));
  Ln(Q);
  PutStr(Q,'Entr‚e de volume (11 caractŠres, si aucun: appuyez sur ®ENTER¯):');
  PBuffer:=@Buffer;FillClr(Buffer,SizeOf(Buffer));
  Repeat
   K:=WEInp(Q.Ansi,PBuffer,SizeOf(Buffer)-1,No);
  Until(K=kbEnter)or(K=kbEsc);
  Ln(Q);
  If(K=kbEnter)Then Begin
   If IsPChrEmpty(PBuffer)Then Begin
    PutStr(Q,'Supprimez le nom du volume actuel (O/N) ? ');
    Repeat
     K:=WEReadk(Q.Ansi);
     ChrK:=ChrUp(ChrK)
    Until Chr(K)in['O','N'];
    Ln(Q);
    If Chr(K)='N'Then Exit;
   End;
   If Not SetDskLabel(Dsk+1,StrPas(PBuffer))Then
   PutLine(Q,'Erreur de renommage de nom de volume!');
  End;
 End;

Begin
 If Q.NP=0Then Begin
  Dsk:=GetDsk;
  SetDskUser;
 End
  Else
 Begin
  Bar:=No;
  If(PDExtractExt(Q,1,Bar)='?')and(Bar)Then DumpHelpDos(Q.Ansi,HelpDosLabel)
   Else
  For I:=1to(Q.NP)do Begin
   Bar:=False;S:=PDExtractExt(Q,I,Bar);
   If(Not(Bar))and(StrI(2,S)=':')and(IsRomanLetter(S[1]))Then Begin
    Dsk:=Byte(ChrUp(S[1]))-65;Bar:=False;S:=PDExtractExt(Q,I+1,Bar);
    If(S<>'')and Not((Not(Bar))and(StrI(2,S)=':')and(IsRomanLetter(S[1])))Then Begin
     If Not SetDskLabel(Dsk+1,S)Then PutLine(Q,'Erreur de renommage de nom de volume!');
     ASM INC I END;
    End
     Else
    SetDskUser;
   End
    Else
   Begin
    PutLine(Q,'Erreur: ParamŠtre invalide!');
    Break;
   End;
   Ln(Q)
  End;
 End;
End;

{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                          Proc‚dure PDMemory                      Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Propri‚taire: Prompt


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette proc‚dure permet d'ex‚cuter la commande ®MEMORY¯ du prompt de
  4DOS/NDOS.
}

Procedure PDMemory;
Var
 Bar:Boolean;
 I:Byte;
 Size:LongInt;
 TerminalOutput:Record
  XmsTotal:LongInt;
  LengthXmsTotal:Byte;
  XmsFree:LongInt;
  LengthXmsFree:Byte;
  MemTotalSize:LongInt;
  LengthMemTotalSize:Byte;
  MemAvail:LongInt;
  LengthMemAvail:Byte;
  {$IFNDEF __Windows__}
   MaxAvail:LongInt;
   LengthMaxAvail:Byte;
  {$ENDIF}
  {$IFNDEF NotReal}
   SizeUMB:LongInt;
   LengthSizeUMB:Byte;
  {$ENDIF}
  SizeHistory:LongInt;
  LengthSizeHistory:Byte;
  SizeAlias:LongInt;
  LengthSizeAlias:Byte;
  FreeAlias:LongInt;
  LengthFreeAlias:Byte;
 End;
Begin
 If Q.NP>0Then Begin
  Bar:=False;
  If(PDExtractExt(Q,1,Bar)='?')and(Bar)Then DumpHelpDos(Q.Ansi,HelpDosMemory)
   Else
  Begin
   TPUProcessString(Q,tpuPutString+#30+'Erreur: ParamŠtres non requis!'+
                      tpuLn+
                      tpuPutString+#11+'MEMORY [/?]',TerminalOutput);
  End;
 End
  Else
 Begin
  PutLine(Q,'tat de la m‚moire');
  Ln(Q);
  If(EmmExist)Then Begin
   PutLine(Q,{$IFDEF NotReal}
              '0'+
             {$ELSE}
              Str2(Long(EmmNumPage)*16384,8)+
             {$ENDIF}
             ' octet(s) en tous dans l''EMS');
   PutLine(Q,{$IFDEF NotReal}
              '0'+
             {$ELSE}
              Str2(EmmTotalSize shl 10,8)+
             {$ENDIF}
             ' octet(s) de libre de EMS');
   Ln(Q);
  End;
  FillChr(TerminalOutput,SizeOf(TerminalOutput),8);
  TerminalOutput.XmsTotal:=Long(Adele.XmsTotalSize)*1024;
  TerminalOutput.XmsFree:=Long(AppResFree(rmXms))*1024;
  TerminalOutput.MemTotalSize:=Long(MemTotalSize)*1024;
  TerminalOutput.MemAvail:=MemAvail;
  TPUProcessString(Q,tpuPutLong2+
                     tpuPutString+#23+' octet(s) en tous d''XMS'+
                     tpuPutLong2+
                     tpuPutString+#24+' octet(s) de libre d''XMS'+
                     tpuPutLong2+
                     tpuPutString+#47+' octet(s) en tous dans la m‚moire conventionnel'+
                     tpuPutLong2+
                     tpuPutString+#43+' octet(s) de libre en m‚moire conventionnel',
                     TerminalOutput);
  {$IFDEF Real}
   TerminalOutput.MaxAvail:=MaxAvail;
   TerminalOutput.SizeUMB:=SizeOfUMB;
  {$ENDIF}
  TerminalOutput.SizeHistory:=Q.H.SizeCmd;
  TerminalOutput.SizeAlias:=Q.Alias.SizeCmd;
  TerminalOutput.FreeAlias:=HYFree(Q.Alias);
  TPUProcessString(Q,{$IFNDEF __Windows__}
                      tpuPutLong2+
                      tpuPutString+#41+' octet(s) de m‚moire continue pour le Dos'+
                     {$ENDIF}
                     {$IFNDEF NotReal}
                     tpuPutLong2+
                     tpuPutString+#47+' octet(s) de m‚moire UMB pour cette application'+
                     {$ENDIF}
                     tpuLn+
                     tpuPutLong2+
                     tpuPutString+#48+' octet(s) r‚serv‚ pour l''histoire des commandes'+
                     tpuLn+
                     tpuPutLong2+
                     tpuPutString+#32+' octet(s) r‚serv‚ pour les Alias'+
                     tpuPutLong2+
                     tpuPutString+#35+' octet(s) disponible pour les Alias',
                     {$IFDEF Real}
                      TerminalOutput.MaxAvail
                     {$ELSE}
                      TerminalOutput.SizeHistory
                     {$ENDIF});
 End;
End;

{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                         Proc‚dure PDMkDir                          Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Propri‚taire: Prompt


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette proc‚dure ex‚cute la commande  du prompt  DOS  ®MKDIR¯ ou  ®MD¯
  permettant  la cr‚ation  du  r‚pertoire  sauf  que  dans  ce  cas  si,
  plusieurs r‚pertoires peuvent ˆtre cr‚‚ en mˆme temps si l'utilisateur
  le demande.
}

Procedure PDMkDir;
Var
 I:Byte;
 Bar:Boolean;
 TStr:String;
Begin
 If Q.NP>0Then Begin
  Bar:=No;
  If(PDExtractExt(Q,1,Bar)='?')and(Bar)Then DumpHelpDos(Q.Ansi,HelpDosMkDir)
   Else
  Begin
   For I:=1to(Q.NP)do Begin
    TStr:=PDExtractExt(Q,I,Bar);
    System.MkDir(TStr);
    If IoResult=0Then PutLine(Q,'R‚pertoire '+TStr+' cr‚‚.')
                 Else PutLine(Q,'Erreur de cr‚ation du r‚pertoire '+TStr);
   End;
  End;
  Exit;
 End
  Else
 PutLine(Q,'Erreur: ParamŠtre requis pour cr‚er le r‚pertoire.');
 Ln(Q);
 PutLine(Q,'MD|MKDIR r‚pertoire [r‚pertoire [...]]');
End;

{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                         Proc‚dure PDMove                           Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Propri‚taire: Prompt


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette proc‚dure permet d'ex‚cuter la commande ®MOVE¯ du prompt du DOS
  d‚pla‡ant un/des fichier(s).
}

Procedure PDMove(Var Q:Prompt);
Var
 Source,Target:PathStr;
 I,NP:Byte;
 Bar:Boolean;
 TStr:String;
 K:Word;

 Procedure CommandMove(Const Source:String;Target:PathStr);Var Rec:SearchRec;TSource,TTarget:PathStr;Begin
  If IsWildCard(Source)Then Begin
   FindFirst(Source,fa,Rec);
   While SysErr=0do Begin
    TSource:=Path2Dir(Source)+Rec.Name;
    TTarget:=Src2Target(TSource,Target);
    PutLine(Q,TSource+' -> '+TTarget);
    MoveFile(TSource,TTarget);
    FindNext(Rec);
   End;
  End
   Else
  Begin
   If IsWildCard(Target)Then Target:=Src2Target(Rec.Name,Target)
			Else Target:=Src2Target(Source,Target);
   PutLine(Q,Source+' -> '+Target);
   MoveFile(Source,Target);
  End;
 End;

Begin
 If Q.NP>0Then Begin
  Bar:=No;
  If(PDExtractExt(Q,1,Bar)='?')and(Bar)Then Begin
   DumpHelpDos(Q.Ansi,HelpDosMove);
   Exit;
  End;
  NP:=0;
  For I:=1to(Q.NP)do Begin
   TStr:=PDExtractExt(Q,I,Bar);
   If(Bar)Then Begin
    PutLine(Q,'Attention: Je ne connais pas le paramŠtre '+TStr+'.');
    Ln(Q);
    PutLine(Q,'Continue quand mˆme (O/N) ?');
    K:=ReadKey;
    If(K=kbEsc)or(ChrUp(Char(K))='N')Then Exit;
   End
    Else
   Begin
    Case(NP)of
     0:Source:=TStr;
     1:Target:=TStr;
     Else Begin
      PutLine(Q,'Erreur: Trop de r‚pertoire sp‚cifi‚!');
      Exit;
     End;
    End;
    Inc(NP);
   End;
  End;
  CommandMove(Source,Target);
 End
  Else
 Begin
  PutLine(Q,'Erreur: ParamŠtre requis pour commencer le copiage!');
  Ln(Q);
  PutLine(Q,'MOVE Source [Destination]');
 End;
End;

{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                         Proc‚dure PDPause                          Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Propri‚taire: Prompt


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette proc‚dure ex‚cute la commande du prompt DOS ®PAUSE¯ demandant
  … l'utilisateur d'enfonc‚ une touche.
}

Procedure PDPause(Var Q:Prompt);
Var
 Bar:Boolean;
Begin
 If Q.NP>0Then Begin
  Bar:=False;
  If(PDExtractExt(Q,1,Bar)='?')and(Bar)Then DumpHelpDos(Q.Ansi,HelpDosPause)
   Else
  Begin
   PutLine(Q,'Erreur: ParamŠtres non requis!');
   Ln(Q);
   PutLine(Q,'PAUSE [/?]');
  End;
 End
  Else
 Begin
  PutLine(Q,'Presse une touche pour continuer...');
  WEReadk(Q.Ansi);
 End;
End;

{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                         Proc‚dure PDRMDir                          Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Propri‚taire: Prompt


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette proc‚dure ex‚cute la commande  du prompt  DOS  ®RMDIR¯ ou  ®RD¯
  permettant la destruction du r‚pertoire  sauf  que  dans  ce  cas  si,
  plusieurs   r‚pertoires   peuvent  ˆtre   d‚truit  en  mˆme  temps  si
  l'utilisateur le demande.
}

Procedure PDRMDir;
Var
 I:Byte;
 Bar:Boolean;
 TStr:String;
Begin
 If Q.NP>0Then Begin
  Bar:=No;
  If(PDExtractExt(Q,1,Bar)='?')and(Bar)Then DumpHelpDos(Q.Ansi,HelpDosRmDir)
   Else
  Begin
   For I:=1to(Q.NP)do Begin
    TStr:=PDExtractExt(Q,I,Bar);
    System.RMDir(TStr);
    If IoResult=0Then PutLine(Q,'R‚pertoire '+TStr+' effac‚.')
                 Else PutLine(Q,'Le r‚pertoire '+TStr+' n''a pas ‚t‚ effac‚.');
   End;
  End;
  Exit;
 End
  Else
 PutLine(Q,'Erreur: ParamŠtre requis pour d‚truire le r‚pertoire!');
 Ln(Q);
 PutLine(Q,'RD|RMDIR r‚pertoire [r‚peroitre [...]]');
End;

{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                         Proc‚dure PDScreen                        Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Propri‚taire: Prompt


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette proc‚dure permet d'ex‚cuter la commande ®SCREEN¯  du prompt de
  4DOS/NDOS. Celle-ci affiche un message … une ligne et colonne pr‚cise
  de l'‚cran.
}

Procedure PDScreen(Var Q:Prompt);
Var
 E,I:Byte;
 L,C:Integer;
 Bar:Boolean;
 S:String;
Begin
 If Q.NP>0Then Begin
  Bar:=False;
  If(PDExtractExt(Q,1,Bar)='?')and(Bar)Then Begin
   DumpHelpDos(Q.Ansi,HelpDosScreen);
   Exit;
  End;
  If Q.NP<2Then Begin
   PutLine(Q,'Erreur: ParamŠtre manquant!');
   Ln(Q);
   PutLine(Q,'Syntaxe: SCREEN ligne colonne [message]');
   Exit;
  End;
  L:=StrToWord(PDExtractExt(Q,1,Bar))-1;
  C:=StrToWord(PDExtractExt(Q,2,Bar))-1;
  If(L=-1)or(C=-1)Then Begin
   PutLine(Q,'Erreur: Position invalide!');
   Ln(Q);
   PutLine(Q,'Syntaxe: SCREEN ligne colonne [message]');
   Exit;
  End;
  WESetPos(Q.Ansi,C,L);
  WESetCurPos(Q.Ansi,C,L);
  If Q.NP>2Then Begin
   E:=0;
   For I:=1to Length(Q.Ext)do Begin
    If Q.Ext[I]=' 'Then Begin
     Inc(E);
     If E=2Then Begin
      {$IFNDEF __Windows__}
       Inc(I);
      {$ENDIF}
      Break;
     End;
    End;
   End;
   PutLine(Q,Copy(Q.Ext,I,255));
  End;
 End;
End;

{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                           Proc‚dure PDTime                          Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Propri‚taire: Prompt


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette proc‚dure ex‚cute la commande du prompt DOS ®TIME¯ permettant de
  changer l'heure courant du systŠme.
}

Procedure PDTime(Var Q:Prompt;Modified:Boolean);
Label _Set;
Var
 M,I,Hour,Min,Sec,Sec100:Byte;
 Bar:Boolean;
 Buffer:Array[0..20]of Char;
 S,TS:String;
 PBuffer:PChr;
 K:Word;
Begin
 If(Modified)Then Begin
  Bar:=False;
  If(PDExtractExt(Q,1,Bar)='?')and(Bar)Then Begin
   DumpHelpDos(Q.Ansi,HelpDosTime);
   Exit;
  End
   Else
  If Q.Ext<>''Then Begin
   S:=Q.Ext;
   Goto _Set;
  End;
 End;
 GetTime(Hour,Min,Sec,Sec100);
 PutLine(Q,'L''heure actuel est '+CStrTimeDos(Hour,Min,Sec)+','+Str0(Sec100,2));
 If(Modified)Then Begin
  PutStr(Q,'Entrer la nouvelle heure (HH:MM:SS): ');
  PBuffer:=@Buffer;
  FillClr(Buffer,SizeOf(Buffer));
  Repeat
   K:=WEInp(Q.Ansi,PBuffer,SizeOf(Buffer)-1,False);
  Until(K=kbEnter)or(K=kbEsc);
  Ln(Q);
  If(K=kbEnter)Then Begin
   S:=StrPas(PBuffer);
   If S=''Then Exit;
   _Set:I:=1;TS:=XtrkDecNm(I,S);
   If TS=''Then Begin
    PutLine(Q,'Erreur: Heure absente!');
    Exit;
   End;
   If StrI(I,S)<>':'Then Begin
    PutLine(Q,'Erreur: S‚parateur '':'' attendu');
    Exit;
   End;
   Inc(I);
   Hour:=StrToWord(TS);
   TS:=XtrkDecNm(I,S);
   If TS=''Then Begin
    PutLine(Q,'Erreur: Minute absente!');
    Exit;
   End;
   Min:=StrToWord(TS);
   If StrI(I,S)<>':'Then Begin
    Sec:=0;
    Sec100:=0;
   End
    Else
   Begin
    Inc(I);
    TS:=XtrkDecNm(I,S);
    Sec:=StrToWord(TS);
    If Not(StrI(I,S)in[':',','])Then Sec100:=0
    Else Begin
     Inc(I);
     TS:=XtrkDecNm(I,S);
     Sec100:=StrToWord(TS)
    End;
   End;
   If ChrUp(StrI(I,S))='P'Then Inc(Hour,12);
   SetTime(Hour,Min,Sec,Sec100);
  End;
 End;
End;

{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                           Proc‚dure PDTrueName                           Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Propri‚taire: Prompt


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette proc‚dure ex‚cute la commande du prompt DOS non-document‚ ®TRUENAME¯,
  celle-ci retournant  le nom au complet  d'un r‚pertoire,  c'est l'‚quivalent
  d'un ®FileExpand¯.
}

Procedure PDTrueName(Var Q:Prompt);
Var
 I:Byte;
 TStr:String;
 Bar:Boolean;
Begin
 If Q.NP>0Then Begin
  Bar:=No;
  If(PDExtractExt(Q,1,Bar)='?')and(Bar)Then DumpHelpDos(Q.Ansi,HelpDosTrueName)
   Else
  Begin
   Ln(Q);
   For I:=1to(Q.NP)do PutLine(Q,FileExpand(StrUp(PDExtractExt(Q,I,Bar))));
  End;
 End
  Else
 PutLine(Q,'Nom de commande r‚serv‚');
End;

{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                           Proc‚dure PDType                         Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Propri‚taire: Prompt


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette proc‚dure ex‚cute la commande du prompt DOS ®TYPE¯, permettant
  d'afficher le contenu d'un fichier de style texte.
}

Procedure PDType;
Var
 Bar,Pause:Boolean;
 I:Byte;
 TStr:String;

 Procedure CmdTypeFile(Path:PathStr);
 Var
  Rec:SearchRec;
 Begin
  Path:=SelAllIfNoExt(Path);
  If IsWildCard(Path)Then Begin
   FindFirst(Path,fa,Rec);
   While SysErr=0do Begin
    WETypeFile(Q.Ansi,Path2Dir(Path)+Rec.Name);
    Q.Ansi.X:=0;
    FindNext(Rec);
   End;
  End
   Else
  Begin
   WETypeFile(Q.Ansi,Path);
   Q.Ansi.X:=0;
  End;
 End;

Begin
 If Q.NP>0Then Begin
  Bar:=No;
  If(PDExtractExt(Q,1,Bar)='?')and(Bar)Then Begin
   DumpHelpDos(Q.Ansi,HelpDosType);
   Exit;
  End;
 End;
 Pause:=No;
 For I:=1to(Q.NP)do Begin
  TStr:=StrUp(PDExtractExt(Q,I,Bar));
  If(Bar)Then Begin
   If(TStr='P')or(TStr='PAUSE')Then Pause:=True;
  End;
 End;
 If(Pause)Then WESetPause(Q.Ansi,True);
 For I:=1to(Q.NP)do Begin
  TStr:=PDExtractExt(Q,I,Bar);
  If Not(Bar)Then CmdTypeFile(TStr);
 End;
 WESetPause(Q.Ansi,No);
End;

{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                           Proc‚dure PDVerify                        Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Propri‚taire: Prompt


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette proc‚dure ex‚cute la commande du prompt DOS ®VERIFY¯, permettant
  de connaŒtre ou de changer l'‚tat du drapeau de v‚rification.
}

{$I \Source\Chantal\Library\GetVerif.Inc}
{$I \Source\Chantal\Library\SetVerif.Inc}

Procedure PDVerify(Var Q:Prompt);
Var
 Bar:Boolean;
 Str:String;
Begin
 If Q.NP=0Then Begin
  PutStr(Q,'VERIFY est … ');
  If(GetVerify)Then PutLine(Q,'actif')Else PutLine(Q,'inactif');
 End
  else
 Begin
  Bar:=No;
  If(PDExtractExt(Q,1,Bar)='?')and(Bar)Then DumpHelpDos(Q.Ansi,HelpDosVerify)
   Else
  Begin
   Str:=StrUp(Q.Ext);
   If Str='ON'Then SetVerify(True)Else
   If Str='OFF'Then SetVerify(No)
    Else
   Begin
    PutLine(Q,'Erreur: ParamŠtre invalide');
    Ln(Q);
    PutLine(Q,'VERIFY [ON|OFF]');
   End;
  End;
 End;
End;

{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                           Proc‚dure PDVol                           Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Propri‚taire: Prompt


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette proc‚dure ex‚cute la commande du prompt DOS ®VOL¯, permettant de
  connaŒtre le nom de volume d'une unit‚,  mais dans  cette  proc‚dure il
  supporte plusieurs unit‚.
}

Procedure PDVol;
Var
 I:Byte;
 Bar:Boolean;
 TStr:String;
 J:Char;
Begin
 If Q.NP>0Then Begin
  Bar:=No;
  If(PDExtractExt(Q,1,Bar)='?')and(Bar)Then DumpHelpDos(Q.Ansi,HelpDosVol)
   Else
  For I:=1to(Q.NP)do Begin
   TStr:=StrUp(PDExtractExt(Q,I,Bar));
   If(Not(Bar))and(StrI(2,TStr)=':')Then Begin
    If(IsRomanLetter(TStr[1]))Then Begin
     PutLine(Q,'Le volume de l''unit‚ '+TStr[1]+' est '+GetDskLabel(Byte(ChrUp(TStr[1]))-64))
    End
     Else
    If TStr[1]in['?','*']Then Begin
     For J:='A'to'Z'do If DrvExist(J)Then Begin
      PutLine(Q,'Le volume de l''unit‚ '+J+' est '+GetDskLabel(Byte(J)-64));
     End;
    End
     Else
    Begin
     PutLine(Q,'Erreur: Unit‚ invalide!');
     Break;
    End;
   End
    Else
   Begin
    PutLine(Q,'Erreur: Unit‚ invalide!');
    Break;
   End;
  End;
 End
  Else
 PutLine(Q,'Le volume de l''unit‚ '+GetDrv+' est '+GetDskLabel(GetDsk+1))
End;

{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                     Proc‚dure PDPutCurrentDisk                  Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Propri‚taire: Prompt


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette proc‚dure affiche l'unit‚ courante du systŠme d'exploitation
  dans la fenˆtre du prompt DOS.
}

Procedure PDPutCurrentDisk;Begin
 PutLine(Q,'Le disque courant est '+GetDrv)
End;

{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                   Proc‚dure PDPutCurrentPath           Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Propri‚taire: Prompt


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette proc‚dure affiche le r‚pertoire courante du systŠme
  d'exploitation dans la fenˆtre du prompt DOS.
}

Procedure PDPutCurrentPath;Begin
 PutLine(Q,GetCurrentDir)
End;

{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                           Proc‚dure PDPutDir                        Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Propri‚taire: Prompt


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette proc‚dure permet de liste des fichiers dans un r‚pertoire pr‚cis
  … la maniŠre de l'interpr‚teur DOS dans la fenˆtre du prompt DOS.
}

Procedure PDPutDir;
Var
 Local:Record
  I:Byte;
  Attr:Record Case Byte of{ Attribut }
   0:(Value:Word);
   1:(Ens:Set of (
       ReadOnly,          { Lecture seulement }
       Hidden,            { Cach‚ }
       SysFile,           { SystŠme }
       VolumeID,          { Volume }
       Dir,               { R‚pertoire }
       Archive));         { Archive }
  End;
  Option:Set Of (Pause,Subdirectory,Lower,Brief,NoDescription);
  Column:Set Of (Double,Width);
  TotalNumFiles:LongInt; { Nombre total de fichiers }
  Describe:^TChar;       { Pointeur des les descriptions }
  SDescr:Word;           { Taille de toutes les descriptions }
  SubReading:Boolean;    { Sous-r‚pertoire lu? }
  Bar,First:Boolean;
  Handle:Hdl;
  Line,Max:Byte;
  K:Word;
  LenWidth:Byte;
  TotalSize:LongInt;
  Serial:LongInt;
  J:Word;
  Path:PathStr;
  DirCMD:String;         { Commande d'environnement pr‚d‚finie }
  TStr:String;           { ChaŒne de traitement temporaire }
 End;

 Function SearchDescr(Name:String):String;
 Var
  I,L:Word;
 Begin
  I:=0;
  SearchDescr:='';
  Name:=StrUp(DelChr(Name,' '))+' ';
  While(I<Local.SDescr)do Begin
   If Compare(Local.Describe^[I],Name[1],Length(Name))Then Begin
    Inc(I,Length(Name));
    L:=I;
    Repeat
     Inc(L)
    Until(Local.Describe^[L]<' ')or(L>Local.SDescr);
    SearchDescr:=LoadStr(Local.Describe^[I],L-I);
    Exit;
   End
    Else
   Begin
    Repeat
     Inc(I)
    Until(Local.Describe^[I]<' ')or(I>Local.SDescr);
    Inc(I,2);
   End;
  End;
 End;

 Function List(Const Path:String):Boolean;
 Var
  Descr:SearchRec;
  Size,NumFiles:LongInt;
  S:String;              { ChaŒne de traitement temporaire }
 Begin
  List:=No;Size:=0;NumFiles:=0;
  If Not((Brief)in(Local.Option))Then Begin
   PutLine(Q,'R‚pertoire '+Path);
   Ln(Q);
  End;
  If(Not((NoDescription)in(Local.Option)))and(DescrInFile)Then Begin { Description de 4Dos/NDos accept‚e?}
   Local.First:=True;
   Local.Handle:=FileOpen(Path2Dir(Path)+'DESCRIPT.ION',fmRead);
   If Not(Local.Handle=errHdl)Then Begin
    Local.SDescr:=FileSize(Local.Handle);
    Local.Describe:=MemAlloc(Local.SDescr);
    If(Local.Describe<>NIL)Then Begin
     _GetAbsRec(Local.Handle,0,Local.SDescr,Local.Describe^);
     Local.J:=0;
     While(Local.J<Local.SDescr)do Begin
      Repeat
       Local.Describe^[Local.J]:=UpCase(Local.Describe^[Local.J]);
       Inc(Local.J)
      Until(Local.Describe^[Local.J]=' ')or(Local.J>Local.SDescr);
      Repeat
       Inc(Local.J)
      Until(Local.Describe^[Local.J]<' ')or(Local.J>Local.SDescr);
      Inc(Local.J,2);
     End;
    End;
    FileClose(Local.Handle);
   End;
  End;
  FindFirst(Path,Local.Attr.Value,Descr);
  If(Width)in(Local.Column)Then Begin
   While SysErr=0do Begin
    If(Descr.Attr.Value and faDir<>faDir)Then Begin
     If(Q.Convention=pDOS)Then Descr.Name:=SetFullName(Descr.Name);
     Inc(NumFiles);
    End;
    S:=StrUSpc(Descr.Name,Local.LenWidth);
    If(Q.Ansi.X+Length(S)+1>Q.Ansi.MaxX)Then Ln(Q);
    PutStr(Q,S+' ');
    FindNext(Descr);
    If(KeyPress)and(ReadKey=kbEsc)Then Begin
     PutLine(Q,'Arrˆte le d‚filement de liste avec ®ESC¯!');
     Exit;
    End;
   End;
   If Q.Ansi.X>0Then Ln(Q);
  End
   Else
  While SysErr=0do Begin
   If(Not((Brief)in(Local.Option)))and(Descr.Attr.Value and faDir<>faDir)Then Begin
    Descr.Name:=SetFullName(Descr.Name);
   End;
   Descr.Name:=StrUSpc(Descr.Name,Local.LenWidth);
   If((Lower)in(Local.Option))and(Descr.Attr.Value and faDir<>faDir)Then Begin
    Descr.Name:=StrDn(Descr.Name);
   End;
   PutStr(Q,Descr.Name);
   If(Brief)in(Local.Option)Then Ln(Q)
    Else
   Begin
    If(sfaDir)in(Descr.Attr.Flags)Then Begin
     If Descr.Name[1]='.'Then PutStr(Q,'<R‚p-pare>')
                         Else PutStr(Q,'<Sous-R‚p>');
    End
     Else
    Begin
     PutStr(Q,Str2(Descr.Size,10));
     Inc(Size,Descr.Size);Inc(NumFiles);
    End;
    Local.TStr:=' '+TimeToStr(Descr.Time);
    If(((Double)in(Local.Column))and(Local.First=False)and(Q.Ansi.X+Length(Local.TStr)>Q.Ansi.MaxX))Then Begin
     Local.TStr[0]:=Char(Q.Ansi.MaxX-Q.Ansi.X);
    End;
    If PutStr(Q,Local.TStr)Then Exit;
    If Not((Double)in(Local.Column))Then Begin
     PutLine(Q,' '+SearchDescr(Descr.Name));
    End;
    If(Double)in(Local.Column)Then Begin
     If(Local.First)Then PutStr(Q,' ')
                    Else Ln(Q);
    End;
   End;
   FindNext(Descr);
   If(KeyPress)and(ReadKey=kbEsc)Then Begin
    PutLine(Q,'Arrˆte de d‚filement de liste avec ®ESC¯!');
    Exit;
   End;
   Local.First:=Not Local.First;
  End;
  If Not((Brief)in(Local.Option))Then
   PutLine(Q,' Les'+CStrBasic(NumFiles)+' fichier(s) utilisent'+CStrBasic(Size)+' octet(s)');
  Inc(Local.TotalSize,Long(Size));
  Inc(Local.TotalNumFiles,LongInt(NumFiles));
  If(Subdirectory)in(Local.Option)Then Begin
   FindFirst(Path,Local.Attr.Value,Descr);
   While SysErr=0do Begin
    If((sfaDir)in(Descr.Attr.Flags))and Not((Descr.Name='..')or(Descr.Name='.'))Then Begin
     Ln(Q);
     If Not List(Path2Dir(Path)+Descr.Name+'\'+Path2NoDir(Path))Then Exit;
     Local.SubReading:=True;
    End;
    FindNext(Descr);
   End;
  End;
  List:=True;
 End;

Begin
 FillClr(Local,SizeOf(Local));
 Local.Path:=FileExpand('*.*');
 Local.Max:=Q.Ansi.MaxY;
 Local.Attr.Value:=faAll;
 If(Q.Convention=pVAX)Then Begin
  Local.Column:=[Width];
  Local.LenWidth:=21;
 End
  Else
 Begin
  Local.LenWidth:=12;
  Local.DirCMD:=GetEnv('DIRCMD');
  If Pos('/P',Local.DirCMD)>0Then Include(Local.Option,Pause);
 End;
 If Q.NP>0Then Begin
  If(PDExtractExt(Q,1,Local.Bar)='?')and(Local.Bar)Then Begin
   DumpHelpDos(Q.Ansi,HelpDosDir);
   Exit;
  End;
  {$IFNDEF __Windows__}
   For Local.I:=1to(Q.NP)do Begin
    Local.TStr:=StrUp(PDExtractExt(Q,Local.I,Local.Bar));
    If(Local.Bar)Then Begin
     If Local.TStr='2'Then Include(Local.Column,Double)Else
     If Local.TStr='W'Then Include(Local.Column,Width)Else
     If Local.TStr='S'Then Include(Local.Option,Subdirectory)Else
     If(Local.TStr='P')or(Local.TStr='PAUSE')Then Include(Local.Option,Pause)Else
     If Local.TStr='L'Then Include(Local.Option,Lower)Else
     If Local.TStr='B'Then Include(Local.Option,Brief)Else
     If(Local.TStr[1]='A')and(Length(Local.TStr)>=2)Then Begin
      Local.Attr.Value:=0;
      For Local.J:=2to Length(Local.TStr)do Case ChrUp(Local.TStr[Local.J])of
       'A':Include(Local.Attr.Ens,Archive);
       'D':Include(Local.Attr.Ens,Dir);
       'H':Include(Local.Attr.Ens,Hidden);
       'R':Include(Local.Attr.Ens,ReadOnly);
       'S':Include(Local.Attr.Ens,SysFile);
       '-':Begin
        ASM INC Local.J;END;
        If Local.J>=Length(Local.TStr)Then Break;
        Case Local.TStr[Local.J]of
         'A':Exclude(Local.Attr.Ens,Archive);
         'D':Exclude(Local.Attr.Ens,Dir);
         'H':Exclude(Local.Attr.Ens,Hidden);
         'R':Exclude(Local.Attr.Ens,ReadOnly);
         'S':Exclude(Local.Attr.Ens,SysFile);
        End;
       End;
       Else Break;
      End;
     End
      Else
     If Local.TStr='NP'Then Exclude(Local.Option,Pause)Else
     If Local.TStr='ND'Then Include(Local.Option,NoDescription)
      Else
     Begin
      PutLine(Q,'Je ne connais pas le paramŠtre '+Local.TStr);
      Exit;
     End;
    End
     Else
    Local.Path:=FileExpand(SelAllIfNoExt(Local.TStr));
   End;
  {$ENDIF}
 End;
 If Local.Column=[Double,Width]Then Begin
  PutLine(Q,'Conflit de paramŠtres!');
  Exit;
 End;
 Local.Line:=5;
 Ln(Q);
 If(Pause)in(Local.Option)Then WESetPause(Q.Ansi,True);
 If Not((Brief)in(Local.Option))Then Begin
  PutLine(Q,'Le volume de l''unit‚ '+Local.Path[1]+' est '+GetDskLabel(Byte(Local.Path[1])-64));
  Local.Serial:=GetSerialNm(Path2Dsk(Local.Path));
  If Local.Serial<>0Then Begin
   Inc(Local.Line);
   PutLine(Q,'Le num‚ro de S‚rie du Volume est '+_GetSerialNmStr(Local.Serial));
  End;
 End;
 If List(Local.Path)and(Local.SubReading)Then Begin
  Ln(Q);
  PutLine(Q,' Les'+CStrBasic(Local.TotalNumFiles)+' fichier(s) utilisent'+CStrBasic(Local.TotalSize)+' octet(s)');
 End;
 FreeMemory(Local.Describe,Local.SDescr);
 If Not((Brief)in(Local.Option))Then
  PutLine(Q,CStr2(DiskFree(GetDsk+1),10)+' octet(s) de libre');
 WESetPause(Q.Ansi,False);
End;

Procedure PDXDir(Var Q:Prompt);Near;
Var
 TStr,S:String;
 I:Byte;
 Bar:Boolean;
Begin
 S:='DIR ';
 If Q.NP>0Then Begin
  Bar:=No;
  If(PDExtractExt(Q,1,Bar)='?')and(Bar)Then Begin
   DumpHelpDos(Q.Ansi,31);
   Exit;
  End;
  For I:=1to(Q.NP)do Begin
   TStr:=StrUp(PDExtractExt(Q,I,Bar));
   If(Bar)Then Begin
    If(TStr='W')or(TStr='S')Then Begin
     IncStr(S,'/');
     AddStr(S,TStr);
    End
     Else
    If TStr='B'Then AddStr(S,'/B /L')
     Else
    Begin
     PutLine(Q,'Je ne connais pas le paramŠtre '+TStr);
     Exit;
    End;
   End
    Else
   AddStr(S,TStr);
  End;
 End;
 Q.Param:=RTrim(S);
 PDCommand(Q);
End;

{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                         Proc‚dure PDPutPath                       Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Propri‚taire: Prompt


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette proc‚dure permet d'afficher la variable d'environnement ®PATH¯
  dans la fenˆtre de dialogue du prompt DOS.
}

Procedure PDPutPath;
Var
 Path:PathStr;
Begin
 Path:=GetEnv('PATH');
 If Path=''Then Path:='Pas de PATH!';
 PutLine(Q,Path)
End;

{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                       Proc‚dure PDPutSet                       Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Propri‚taire: Prompt


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette proc‚dure permet d'afficher  la variable d'environnement du
  systŠme d'exploitation dans une fenˆtre de dialogue du prompt DOS.
}

Procedure PDPutSet;
Var
 P:PChr;
 PP:PtrRec Absolute P;
Begin
 {$IFNDEF FLAT386}
  {$IFDEF Windows}
   WEPut(Q.Ansi,PChr(GetDosEnvironment));
  {$ELSE}
   {$IFDEF __Windows__}
    P:=GetDosEnv;
   {$ELSE}
    P:=Ptr(Word(Ptr(PrefixSeg,$2C)^),0);
   {$ENDIF}
   While P^[0]<>#0do Begin
    PutLine(Q,StrPas(P));
    Inc(PP.Ofs,StrLen(PChr(P))+1)
   End;
  {$ENDIF}
 {$ENDIF}
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Fonction PDExtract                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: Prompt


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet  de retourner le nom  de la commande envoy‚e par
 l'utilisateur, par exemple, dans la commande ®DIR /P¯, il ne retournera
 que ®DIR¯.
}

Function PDExtract;
Var
 RtnValue:Boolean;
Begin
 RtnValue:=CmpLeft(Q.Param,CmpMsg);
 If(Length(Q.Param)>Length(CmpMsg))and(IsRomanLetter(Q.Param[Length(CmpMsg)+1]))Then RtnValue:=False;
 If(RtnValue)Then Begin
  If Length(CmpMsg)=Length(Q.Param)Then Q.Ext:=''
  Else Q.Ext:=LTrim(Copy(Q.Param,Length(CmpMsg)+1,255));
 End;
 PDExtract:=RtnValue;
End;

{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                    Proc‚dure PDRunDel                   Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Propri‚taire: Prompt


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'effacer les fichiers sp‚cifier par
 l'utilisateur dans la fenˆtre dialogue du prompt DOS.
}

Procedure PDDel;
Var
 I:Byte;
 Bar:Boolean;
 TStr:String;

 Procedure CommandDel(Path:String);
 Var
  Rec:SearchRec;
  TPath:PathStr;

  Function DelPrompt(Const Name:String):Boolean;
  Var
   K:Word;
  Begin
   DelPrompt:=True;
   If(DelOption=doDelQ)Then Begin
    PutStr(Q,'Effacer '+Name+' (O/N) ?');
    WESetCurPos(Q.Ansi,Q.Ansi.X,Q.Ansi.Y);
    SimpleCur;
    K:=WEReadk(Q.Ansi);
    CloseCur;
    PutStr(Q,Chr(K));
    Ln(Q);
    DelPrompt:=Not((K=kbEsc)or(ChrUp(Char(K))='N'));
   End;
  End;

 Begin
  Path:=SelAllIfNoExt(Path);
  If IsWildCard(Path)Then Begin
   FindFirst(Path,fa,Rec);
   While SysErr=0do Begin
    TPath:=Path2Dir(Path)+Rec.Name;
    If DelPrompt(TPath)Then Begin
     PutLine(Q,'Efface '+TPath);
     DeleteFile(TPath);
    End;
    FindNext(Rec);
   End;
  End
   Else
  Begin
   If DelPrompt(Path)Then Begin
    PutLine(Q,'Efface '+Path);
    DeleteFile(Path);
   End;
  End;
 End;

Begin
 If Q.NP>0Then Begin
  Bar:=False;
  If(PDExtractExt(Q,1,Bar)='?')and(Bar)Then DumpHelpDos(Q.Ansi,HelpDosDel)
   Else
  For I:=1to(Q.NP)do Begin
   TStr:=PDExtractExt(Q,I,Bar);
   If Not(Bar)Then CommandDel(TStr)Else PutLine(Q,'Erreur: ParamŠtre invalide!');
  End;
 End
  Else
 Begin
  PutLine(Q,'Erreur: ParamŠtre requis pour effacer les fichiers!');
  Ln(Q);
  Case(DelOption)of
   doDelQ:PutLine(Q,'DELQ|ERAQ fichier(s) [fichier(s)] [...]');
   Else PutLine(Q,'DEL|ERASE fichier(s) [fichier(s)] [...]');
  End;
 End;
End;

{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                        Proc‚dure PDRunSetPrn                    Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Propri‚taire: Prompt


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de fixer la configuration de l'imprimante de
 fa‡on temporaire et manuel dans une boŒte de dialogue du prompt DOS.
}

Procedure PDRunSetPrn;
Var
 Bar:Boolean;
Begin
 If Q.NP>0Then Begin
  Bar:=No;
  If(PDExtractExt(Q,1,Bar)='?')and(Bar)Then Begin
   DumpHelpDos(Q.Ansi,HelpDosSetPrn);
   Exit;
  End
 End;
 PutStr(Q,RunSetPrn(Q.Ext));
 If GetSysErr>0Then PutLine(Q,GetErrMsg(GetSysErr));
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure PDDescribe                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: Prompt


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'ajouter une description de style 4DOS/NDOS … un
 nom de fichier.
}

Procedure PDDescribe(Var Q:Prompt);
Label Err;
Var
 I:Word;
 Bar:Boolean;
 X:SearchRec;
 Buffer:Array[0..255]of Char;
 PBuffer:PChr;
 K:Word;
 S:String;
Begin
 If Q.NP>0Then Begin
  Bar:=No;
  If(PDExtractExt(Q,1,Bar)='?')and(Bar)Then {DumpHelpDos(Q.Ansi,HelpDosDescribe)}
   Else
  Begin
   S:=PDExtractExt(Q,1,Bar);
   If Q.NP>=2Then Begin
    If IsWildCard(S)Then Begin
     PutLine(Q,'Erreur: Nom de fichier non-simple ou erreur de paramŠtre!');
     Goto Err;
    End;
    For I:=1to Length(Q.Param)do If Q.Param[I]=' 'Then Break;
    SetDescription(S,Copy(Q.Param,I+1,255));
   End
    Else
   Begin
    If IsWildCard(S)Then Begin { Multiple fichier de description? }
     FindFirst(S,fa,X);
     While SysErr=0do Begin
      PutStr(Q,X.Name+': ');
      PBuffer:=@Buffer;FillClr(Buffer,SizeOf(Buffer));
      StrPCopy(PBuffer,SearchDescription(X.Name));
      Repeat
       K:=WEInp(Q.Ansi,PBuffer,SizeOf(Buffer)-1,False);
      Until(K=kbEnter)or(K=kbEsc);
      Ln(Q);
      If(K=kbEnter)Then SetDescription(X.Name,StrPas(PBuffer));
      If(K=kbEsc)Then Break;
      FindNext(X)
     End;
    End
     Else
    Begin
     PutStr(Q,S+': ');
     PBuffer:=@Buffer;FillClr(Buffer,SizeOf(Buffer));
     StrPCopy(PBuffer,SearchDescription(S));
     Repeat
      K:=WEInp(Q.Ansi,PBuffer,SizeOf(Buffer)-1,False);
     Until(K=kbEnter)or(K=kbEsc);
     If(K=kbEnter)Then SetDescription(S,StrPas(PBuffer));
     Ln(Q);
    End;
   End;
  End;
 End
  Else
 Begin
  PutLine(Q,'Erreur: ParamŠtre requis!');
Err:
  Ln(Q);
  PutLine(Q,'DESCRIBE fichier(s) [description]');
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Proc‚dure PDTruncText                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: Prompt


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet … l'utilisateur de tronqueur des fichiers contenant
 trop de ligne pour un traŒtement de texte.
}

Procedure PDTruncText(Var Q:Prompt);
Var
 Handle,Target:Hdl;
 Path,S:String;
 NL,P,L,FP,FS:LongInt;
 Bar:Boolean;
Begin
 If Q.NP>2Then Begin
  PutLine(Q,'Erreur: Trop de paramŠtre!');
  Ln(Q);
  PutLine(Q,'TRUNCTEXT fichier [/L:nnnnn]');
  Exit;
 End;
 If Q.NP=0Then Begin
  PutLine(Q,'Erreur: ParamŠtre requis!');
  Ln(Q);
  PutLine(Q,'TRUNCTEXT fichier [/L:nnnnn]');
  Exit;
 End;
 Bar:=False;NL:=1000;S:=PDExtractExt(Q,2,Bar);
 If Left(S,3)='/L:'Then NL:=StrToInt(Copy(S,4,255));
 Bar:=False;Path:=PDExtractExt(Q,1,Bar);
 Handle:=FileOpen(Path,fmRead);
 If(Handle=errHdl)Then Begin
  PutLine(Q,'Erreur: Fichier introuvable!');
  Exit;
 End;
 FP:=0;FS:=FileSize(Handle);L:=0;P:=0;
 Target:=FileCreate(Path2NoExt(Path)+'.'+WordToStr(P));
 If(Target=errHdl)Then Begin
  PutLine(Q,'Erreur de cr‚ation de fichier');
  Exit;
 End;
 Repeat
  __GetAbsFileTxtLn(Handle,FP,S);
  PutFileTxtLn(Target,S);
  Inc(L);
  If(L>=NL)Then Begin
   Inc(P);L:=0;
   FileClose(Target);
   Target:=FileCreate(Path2NoExt(Path)+'.'+WordToStr(P));
   If(Target=errHdl)Then Begin
    PutLine(Q,'Erreur de cr‚ation de fichier');
    Exit;
   End;
  End;
 Until FP>=FS;
 FileClose(Target);
 FileClose(Handle);
End;

{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                        Proc‚dure PDSerNo                       Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Propri‚taire: Prompt


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette proc‚dure permet de retourner le nom de l'utilisateur et le
  num‚ro de s‚rie du programme.
}

Procedure PDSerNo(Var Q:Prompt);
Var
 S:String;
 I:Byte;
 Bar:Boolean;

 {$I \Source\Chantal\Library\Security\MonsterB.ook\Serial.Inc}

Begin
 If Q.NP>0Then Begin
  Bar:=False;
  If(PDExtractExt(Q,1,Bar)='?')and(Bar)Then DumpHelpDos(Q.Ansi,HelpDosSerno)
   Else
  Begin
   PutLine(Q,'Erreur: ParamŠtres non requis!');
   Ln(Q);
   PutLine(Q,'SERNO [/?]');
  End;
 End
  Else
 Begin
  S:=StrPas(RegUserName);
  PutLine(Q,'Nom de l''utilisateur: '+S);
  PutLine(Q,'Num‚ro de s‚rie:      '+GetSerialUser(S));
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Proc‚dure PDDump                           Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: Prompt


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'afficher  le code d'une bloque de m‚moire ou de
 fichier sous forme hexad‚cimal ou en assembleur dans la boŒte de dialogue
 du prompt DOS.
}

Procedure PDDump(Var Q:Prompt;Sourcer:Boolean);
Var
 Search:Boolean;
 St,TStr,XS:String;
 Bar:Boolean;
 S,O,O2,IO:Word;
 I,J:Byte;
 Handle:Hdl;
Begin
 Search:=False;
 If Q.NP>0Then Begin
  Bar:=No;
  If(CmpLeft(PDExtractExt(Q,1,Bar),'SEARCH:'))and(Bar)Then Search:=True Else
  If(PDExtractExt(Q,1,Bar)='?')and(Bar)Then Begin
   If(Sourcer)Then DumpHelpDos(Q.Ansi,HelpDosUnAsm)
              Else DumpHelpDos(Q.Ansi,HelpDosDump);
   Exit;
  End
 End;
 If(Search)Then Begin
  For I:=1to Length(Q.Param)do If Q.Param[I]=':'Then Break;
  TStr:=LTrim(Copy(Q.Param,I+1,255));
  S:=$F000;
  For O2:=$F downto $0 do Begin
   O:=IScan(Mem[S:0],$FFF0,TStr);
   If(O<$FFF0)Then Break;
   Dec(S,$1000);
  End;
  If O>$FFF0Then Begin
   PutLine(Q,'Chaine introuvable!');
   Exit;
  End;
  Q.Dump.Ptr:=Ptr(S,O);
  Q.DumpFile:='';
 End
  Else
 If Q.NP>0Then Begin
 { For I:=1to Length(TStr)do If Q.Param[I]=' 'Then Break;}
  For I:=1to Length(Q.Param)do If Q.Param[I]=' 'Then Break;
  TStr:=LTrim(Copy(Q.Param,I,255));I:=1;
  {If 0=Length(TStr)Then Begin
   S:=PtrRec(Q.Dump).Seg;O:=PtrRec(Q.Dump).Ofs;
  End
   Else
  Begin}
   TStr:=StrUp(TStr);St:='';
   SkipSpcInLn(I,TStr);
   While StrI(I,TStr)in['A'..'Z','_',':','.','\']do Begin
    IncStr(St,TStr[I]);
    Inc(I)
   End;
   If St<>''Then Begin
    Q.DumpFile:=St;
    SkipSpcInLn(I,TStr);
   End;
 {  If St='STRPAS'Then Begin;S:=Seg(StrPas);O:=Ofs(StrPas)End Else
   If St='EXEC'Then Begin;S:=Seg(Dos.Exec);O:=Ofs(Dos.Exec)End
    Else}
   Begin
    If Q.DumpFile=''Then Begin
     S:=HexStrToInt(XtrkHexNm(I,TStr));
     While StrI(I,TStr)in[':','h','H']do Inc(I);
     O:=HexStrToInt(XtrkHexNm(I,TStr));
    End
     Else
    Begin
     Q.Dump.Long:=HexStrToInt(XtrkHexNm(I,TStr));
     {$IFNDEF FLAT386}
      S:=Seg(XS);O:=Ofs(XS);
     {$ENDIF}
     Handle:=FileOpen(Q.DumpFile,fmRead);
     If(Handle<>errHdl)Then Begin
      _GetAbsRec(Handle,Q.Dump.Long,SizeOf(XS),XS);
      Q.FS:=FileSize(Handle);
      FileClose(Handle);
     End
      Else
     Begin
      PutLine(Q,'Fichier introuvable!');
      Q.DumpFile:='';Q.Dump.Long:=0;
      Exit;
     End;
    End;
   End;
  {End;}
 End
  Else
 Begin
  S:=PtrRec(Q.Dump).Seg;O:=PtrRec(Q.Dump).Ofs;
 End;
 For J:=0to 7do Begin
  If Q.DumpFile<>''Then St:=HexLong2Str(Q.Dump.Long)
                   Else St:=HexWord2Str(S)+'h:'+HexWord2Str(O);
  AddStr(St,'h  ');
  If(Sourcer)Then Begin
   O2:=O;
   {$IFNDEF FLAT386}
    TStr:=Decode(Mem[S:0],O);
    If Q.DumpFile<>''Then Inc(Q.Dump.Long,O-O2);
    For IO:=0to O-O2-1do Begin
     AddStr(St,HexByte2Str(Mem[S:O2+IO]));
     IncStr(St,' ');
    End;
   {$ENDIF}
   St:=StrUSpc(St,40);
   AddStr(St,TStr);
  End
   Else
  Begin
   {$IFNDEF FLAT386}
    For I:=0to 15do Begin
     AddStr(St,HexByte2Str(Mem[S:O+I]));
     IncStr(St,' ');
    End;
    IncStr(St,' ');
    For I:=0to 15do Begin
     If Mem[S:O+I]>32Then IncStr(St,Chr(Mem[S:O+I]))Else IncStr(St,' ');
    End;
    Inc(O,16);
    If Q.DumpFile<>''Then Inc(Q.Dump.Long,16);
   {$ENDIF}
  End;
  PutLine(Q,St);
  If(Q.DumpFile<>'')and(Q.Dump.Long>=Q.FS)Then Begin
   Q.DumpFile:='';
   Exit;
  End;
 End;
 {$IFNDEF FLAT386}
  If Q.DumpFile=''Then Q.Dump.Ptr:=Ptr(S,O)
 {$ENDIF}
End;

{$I \Source\Chantal\Library\Typemati.inc}

Function PDMode(Var Q:Prompt):Boolean;
Var
 Option:Set of (Con,Prn,ConStatus);
 Bar,Numeric:Boolean;
 CO,Lines,Rate,Delay:Byte;
 I,J,PNum:Byte;
 TStr:String;
Begin
 Option:=[];
 PDMode:=False;CO:=$FF;
 PNum:=0;Rate:=$FF;Delay:=$FF;
 If Q.NP>0Then Begin
  Bar:=No;
  If(PDExtractExt(Q,1,Bar)='?')and(Bar)Then Begin
   DumpHelpDos(Q.Ansi,33);
   Exit;
  End;
  For I:=1to(Q.NP)do Begin
   TStr:=StrUp(PDExtractExt(Q,I,Bar));
   If(Bar)Then Begin
    PutLine(Q,'Je ne connais pas le paramŠtre '+TStr);
    Exit;
   End
    Else
   If(Prn)in(Option)Then Begin
    If CmpLeft(TStr,'COM')and(StrI(4,TStr)in['1'..'8'])and(StrI(5,TStr)=':')Then Begin
     PrnOutput:=poCOM1+Byte(TStr[4])-Byte('1');
    End
     Else
    If CmpLeft(TStr,'LPT')and(StrI(4,TStr)in['1'..'4'])and(StrI(5,TStr)=':')Then Begin
     PrnOutput:=poLPT1+Byte(TStr[4])-Byte('1');
    End
     Else
    PutLine(Q,'ParamŠtre d''imprimante invalide!');
   End
    Else
   If(Con)in(Option)Then Begin
    If(TStr='CP')or(TStr='CODEPAGE')Then Include(Option,ConStatus)Else
    If CmpLeft(TStr,'RATE=')Then Begin
     Rate:=StrToWord(Copy(TStr,6,255));
     If Not(Rate in[1..32])Then Begin
      PutLine(Q,'Intervalle invalide!');
      Exit;
     End;
     Dec(Rate);
     Rate:=$1F-Rate;
    End
     Else
    If CmpLeft(TStr,'LINES=')Then Lines:=StrToWord(Copy(TStr,7,255))Else
    If CmpLeft(TStr,'DELAY=')Then Begin
     Delay:=StrToWord(Copy(TStr,7,255));
     If Not(Delay in[1..4])Then Begin
      PutLine(Q,'Intervalle invalide!');
      Exit;
     End;
     Dec(Delay);
    End
     Else
    If CmpLeft(TStr,'COL=')Then CO:=StrToWord(Copy(TStr,5,255))
     Else
    Begin
     PutLine(Q,'Je ne connais pas le paramŠtre '+TStr);
     Exit;
    End;
   End
    Else
   Begin
    If TStr='CO132'Then CO:=132 Else
    If TStr='CO100'Then CO:=100 Else
    If(TStr='CO80')or(TStr='BW80')Then CO:=80 Else
    If(TStr='CO40')or(TStr='BW40')Then CO:=40 Else
    If(TStr='PRN')or(TStr='PRN:')Then Begin
     Include(Option,Prn);
     If(I=Q.NP)Then PutLine(Q,GetPromptPrn);
    End
     Else
    If(TStr='CON')or(TStr='CON:')Then Include(Option,Con)
     Else
    Begin
     Numeric:=True;
     For J:=1to Length(TStr)do If Not(TStr[J]in['0'..'9',' '])Then Numeric:=False;
     If(Numeric)Then Begin
      Case(PNum)of
       0:Begin
        CO:=StrToWord(TStr);
        If CO<10Then Begin
         PutLine(Q,'ParamŠtres invalide!');
         Exit;
        End;
       End;
       1:Lines:=StrToWord(TStr);
       Else Begin
        PutLine(Q,'ParamŠtre superflux!');
        Exit;
       End;
      End;
      Inc(PNum);
     End
      Else
     Begin
      PutLine(Q,'Je ne connais pas le paramŠtre '+TStr);
      Exit;
     End;
    End;
   End;
  End;
 End;
 If(Rate<>$FF)or(Delay<>$FF)Then Begin
  If Not SetTypm(Delay+(Rate shl 5))Then Begin
   PutLine(Q,'ProblŠme d''ajustement du contr“leur clavier!');
   Exit;
  End;
 End;
 If CO<>$FFThen Begin
  If(CO<=Q.Ansi.MaxX+1)or(Q.Ansi.T.X1+CO<=NmXTxts)Then Begin
   WEInit(Q.Ansi,Q.Ansi.T.X1,Q.Ansi.T.Y1,Q.Ansi.T.X1+CO-1,Q.Ansi.T.Y2);
  End
   Else
  If(CO<=NmXTxts)Then Begin
   WEInit(Q.Ansi,0,Q.Ansi.T.Y1,CO-1,Q.Ansi.T.Y2);
  End
   Else
  Begin
   PutLine(Q,'Mode vid‚o non-supporter!');
   Exit;
  End;
  PDRefresh(Q);
  WEClrScr(Q.Ansi);
  PDMode:=True;
 End;
 If(ConStatus)in(Option)Then Begin
  PutLine(Q,'Le code de page pour la CON est '+WordToStr(CodePage));
 End;
End;

Procedure PDAttrib(Var Q:Prompt);
Var
 Bar,Sub,Pause:Boolean;
 I:Byte;
 TStr:String;
 AndAttr,OrAttr:Word;
 X:SearchRec;
 PosName:Array[0..255]of Boolean;
 NumName:Word;

 Procedure PutIdentification(Attr:Byte;Const Path:String);
 Var
  S:String[13];
 Begin
  S[0]:=#13;
  FillSpc(S[1],13);
  If(Attr and faArchive=faArchive)Then S[3]:='A';
  If(Attr and faSysFile=faSysFile)Then S[5]:='S';
  If(Attr and faHidden=faHidden)Then S[6]:='H';
  If(Attr and faReadOnly=faReadOnly)Then S[7]:='R';
  PutLine(Q,S+StrUSpc(Path2NoDir(Path),13)+FileExpand(Path));
 End;

 Procedure SetFileAttribut(Const Path:String);
 Var
  Attr:Byte;
  S:String;
 Begin
  FindFirst(Path,faAll,X);
  If IsWildCard(Path)Then Begin {Recherche plusieurs fichiers?}
   While SysErr=0do Begin
    If X.Attr.Value and faDir=0Then Begin
     Attr:=(X.Attr.Value and AndAttr)or OrAttr;
     S:=Path2Dir(Path)+X.Name;
     PutIdentification(Attr,S);
     If(Attr<>X.Attr.Value)Then Begin
      If FileSetAttr(S,Attr)<>0Then PutLine(Q,'Erreur de tentative de changement d''attribut');
     End;
    End
     Else
    If(Sub)Then SetFileAttribut(Path2Dir(Path)+X.Name+'\'+Path2NoDir(Path));
    FindNext(X);
   End;
  End
   Else
  Begin
   If SysErr<>0Then Begin
    PutLine(Q,'Fichier '+TStr+' introuvable!');
    Exit;
   End;
   Attr:=(X.Attr.Value and AndAttr)or OrAttr;
   PutIdentification(Attr,Path);
   If(Attr<>X.Attr.Value)Then Begin
    If FileSetAttr(Path,Attr)<>0Then PutLine(Q,'Erreur de tentative de changement d''attribut');
   End;
  End;
 End;

Begin
 FillClr(PosName,SizeOf(PosName));
 OrAttr:=0;
 AndAttr:=$FFFF;
 Sub:=False;
 NumName:=0;
 Pause:=False;
 If Q.NP>0Then Begin
  Bar:=No;
  If(PDExtractExt(Q,1,Bar)='?')and(Bar)Then Begin
   DumpHelpDos(Q.Ansi,34);
   Exit;
  End;
  For I:=1to(Q.NP)do Begin
   TStr:=StrUp(PDExtractExt(Q,I,Bar));
   If(Bar)Then Begin
    If(TStr='P')or(TStr='PAUSE')Then Pause:=True Else
    If TStr='S'Then Sub:=True
     Else
    Begin
     PutLine(Q,'Je ne connais pas le paramŠtre '+TStr);
     Exit;
    End;
   End
    Else
   If StrI(1,TStr)in['-','+']Then Begin
    Case ChrUp(StrI(2,TStr))of
     'A':If TStr[1]='-'Then AndAttr:=AndAttr and Not(faArchive)
                       Else OrAttr:=OrAttr or faArchive;
     'R':If TStr[1]='-'Then AndAttr:=AndAttr and Not(faReadOnly)
                       Else OrAttr:=OrAttr or faReadOnly;
     'H':If TStr[1]='-'Then AndAttr:=AndAttr and Not(faHidden)
                       Else OrAttr:=OrAttr or faHidden;
     'S':If TStr[1]='-'Then AndAttr:=AndAttr and Not(faSysFile)
                       Else OrAttr:=OrAttr or faSysFile;
     Else Begin
      PutLine(Q,'Attribut invalide!');
      Exit;
     End;
    End;
   End
    Else
   Begin
    PosName[I]:=True;
    Inc(NumName);
   End;
  End;
 End;
 If(Pause)Then WESetPause(Q.Ansi,True);
 If NumName>0Then Begin
  For I:=1to(Q.NP)do If PosName[I]Then Begin
   SetFileAttribut(PDExtractExt(Q,I,Bar));
  End;
 End
  Else
 SetFileAttribut('*.*');
 WESetPause(Q.Ansi,No);
End;

Procedure PDPlay(Var Q:Prompt);
Var
 Bar,CD:Boolean;
 I:Byte;
 TStr:String;
 X:SearchRec;
 PosName:Array[0..255]of Boolean;
 NumName:Word;
Begin
 FillClr(PosName,SizeOf(PosName));
 NumName:=0;
 If Q.NP>0Then Begin
  Bar:=False;CD:=False;
  If(PDExtractExt(Q,1,Bar)='?')and(Bar)Then Begin
   DumpHelpDos(Q.Ansi,35);
   Exit;
  End;
  For I:=1to(Q.NP)do Begin
   TStr:=StrUp(PDExtractExt(Q,I,Bar));
   If(Bar)Then Begin
    If(TStr='CD')Then CD:=True
     Else
    Begin
     PutLine(Q,'Je ne connais pas le paramŠtre '+TStr);
     Exit;
    End;
   End
    Else
   If TStr='CD'Then CD:=True
    Else
   Begin
    PosName[I]:=True;
    Inc(NumName);
   End;
  End;
 End;
 If NumName>0Then Begin
  For I:=1to(Q.NP)do If PosName[I]Then Begin
   _LoadSound(PDExtractExt(Q,I,Bar));
   _PlayWave;
  End;
 End;
End;

{$I \Source\Chantal\Library\Scan.Inc}
{$I \Source\Chantal\Library\IScan.Inc}
{$I \Source\Chantal\Library\XtrkWdIn.Inc}
{$I \Source\Chantal\Library\XtrkLong.Inc}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Fonction CountLn                           Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction retourne le nombre de retour de ligne situ‚ … l'int‚rieur
 d'une zone tampon sp‚cifi‚e.


 Entr‚e
 ÍÍÍÍÍÍ

  ®Buffer¯         Tampon dans lequel la recherche doit ˆtre effectu‚e
  ®Size¯           Taille du tampon de recherche


 Sortie
 ÍÍÍÍÍÍ

  ®LastOff¯        Position de la derniŠre ligne dans le tampon (Offset)
}

Function CountLn(Const Buffer;Size:Word;Var LastOff:Word):Word;Assembler;ASM
 {$IFDEF FLAT386}
 {$ELSE}
  LES DI,Buffer
  MOV CX,Size
  XOR DX,DX
  XOR BX,BX
  MOV AL,13
@1:
  SCASB
  JNZ @2
  INC DX
  MOV BX,DI
@2:
  DEC CX
  JNZ @1
  OR  BX,BX
  JZ  @3
  DEC BX
@3:
  LES DI,LastOff
  XCHG AX,BX
  STOSW
  XCHG AX,DX
 {$ENDIF}
END;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                               Proc‚dure PDFind                           Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: Prompt


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'effectuer une recherche d'une chaŒne de caractŠres
 dans un/des fichier(s)  comme la  commande  classique  ®find¯  et  ®grep¯ du
 systŠme d'exploitation DOS.


 ParamŠtre
 ÍÍÍÍÍÍÍÍÍ

  ®Q¯       L'objet de la fenˆtre de dialogue du prompt DOS.
}

Procedure PDFind(Var Q:Prompt);
Const MaxParam=255; { Nombre maximal de paramŠtres support‚es }
Var
 {ModŠle de chaque paramŠtres envoyer par l'utilisateur}
 Param:Array[1..MaxParam]of(pNone,pString,pPath,pSwitch);
 Option:Set of (
  Page,        { Compte le nombre de page dans les documents de format GAT }
  SubDirectory,{ Recherche dans les sous-r‚pertoires }
  MinMaj       { Sans distinction majuscule/minuscule }
 );
 NS:Word;         { nombre de chaŒnes de caractŠres comme paramŠtres }
 I:Byte;          { Compteur de boucle }
 Find:String;     { ChaŒne de caractŠres de recherche }
 S:String;        { ChaŒnes de caractŠres divers }
 Bar:Boolean;     { Barre oblique comme dans le paramŠtre courant }
 Found:Boolean;   { ChaŒne demander trouv‚}
 Tranche:LongInt; { Position courante du pointeur de fichier }
 Handle:Hdl;      { Handle du fichier courant }
 OP,PX:Word;      { Position d'offset, position de recherche }
 Buffer:PChr;     { Tampon pour la recherche }
 SizeBuf,         { Taille du tampon de recherche }
 SizeBufX,        { Taille d'entˆte du tampon de recherche }
 XW1:Word;        { Marge gauche du document }
 YW1:Word;        { Marge sup‚rieur du document }
 XW2:Word;        { Marge droite du document }
 YW2:Word;        { Marge inf‚rieur du document }
 TW:Array[0..3]of {$IFDEF Real}PWord{$ELSE}PLong{$ENDIF};
 J:Word;          { Compteur de recherche }
 NPage:LongInt;   { Nombre global de page }
 NmFiles:LongInt; { Nombre totale de fichiers balayer}
 NmBytes:LongInt; { Nombre totale d'octets pour les fichiers}

 Procedure SearchDir(Const S:String);
 Label Cls;
 Var
  Descr:SearchRec;
  LPage,LN:LongInt;
 Begin
  FindFirst(Path2Dir(S)+'*.*',faAll,Descr);
  While SysErr=0do Begin
   If(Descr.Name<>'..')and(Descr.Name<>'.')Then Begin
    If WildCardMatch(Descr.Name,Path2NoDir(S))Then Begin
     Handle:=FileOpen(Path2Dir(S)+Descr.Name,fmRead);
     Tranche:=0;LN:=1;
     If(Handle<>errHdl)Then Begin
      Inc(NmFiles);Inc(NmBytes,Descr.Size);
      If(Page)in(Option)Then Begin
       __GetAbsFilePTxtLn(Handle,Tranche,Buffer,SizeBufX);
       TW[0]:=@XW1;TW[1]:=@YW1;TW[2]:=@XW2;TW[3]:=@YW2;
       {$IFDEF Real}
        J:=XtrkWdInStr(StrPas(Buffer),4,TW);
       {$ELSE}
        J:=XtrkLongInStr(StrPas(Buffer),4,TW);
       {$ENDIF}
       If J=0Then Begin;YW1:=6;YW2:=60;End;
       J:=0;Dec(YW2,YW1);LPage:=0;
       Repeat
        _GetAbsRec(Handle,Tranche,SizeBuf,Buffer^);
        Inc(LPage,CountLn(Buffer^,SizeBuf,OP));
        Inc(Tranche,SizeBuf);
       Until Tranche>=Descr.Size;
       If(LPage>0)and(YW2>0)Then Begin
        J:=LPage mod YW2;
        LPage:=LPage div YW2;
        If J>0Then Inc(LPage);
       End;
       Inc(NPage,LPage);
       PutLine(Q,Path2Dir(S)+Descr.Name+': '+IntToStr(LPage));
      End
       Else
      Repeat
       _GetAbsRec(Handle,Tranche,SizeBuf,Buffer^);
       If(MinMaj)in(Option)Then PX:=IScan(Buffer^,SizeBuf,Find)
                           Else PX:=Scan(Buffer^,SizeBuf,Find);
       If PX<>$FFFFThen Begin
        Inc(LN,CountLn(Buffer^,PX,OP));
        PutLine(Q,Path2Dir(S)+Descr.Name+': '+IntToStr(LN));
        Found:=True;
        Goto Cls;
       End
        Else
       Inc(LN,CountLn(Buffer^,SizeBuf,OP));
       Inc(Tranche,SizeBuf-Length(Find));
      Until Tranche>=Descr.Size;
  Cls:FileClose(Handle);
     End;
    End;
    If((SubDirectory)in(Option))and((sfaDir)in(Descr.Attr.Flags))Then Begin
     SearchDir(Path2Dir(S)+Descr.Name+'\'+Path2NoDir(S));
    End;
   End;
   FindNext(Descr);
   If(KeyPress)Then Exit;
  End;
 End;

Begin
 Option:=[];
 NS:=0;NmFiles:=0;NmBytes:=0;Found:=False;
 If Q.NP=0Then Begin
  PutLine(Q,'Erreur: ParamŠtre requis!');
  Exit;
 End;
 If(Q.NP>MaxParam)Then Begin
  PutLine(Q,'Erreur: Trop de paramŠtres!');
  Exit;
 End;
 FillClr(Param,SizeOf(Param));
 NPage:=0;
 For I:=1to(Q.NP)do Begin
  Bar:=No;S:=PDExtractExt(Q,I,Bar);
  If(Bar)Then Begin
   Param[I]:=pSwitch;
   S:=StrUp(S);
   If S='?'Then Begin
    DumpHelpDos(Q.Ansi,HelpDosFind);
    Exit;
   End
    Else
   If(S='P')or(S='PAUSE')Then WESetPause(Q.Ansi,True)Else
   If(S='PAGE')Then Include(Option,Page)Else
   If S='D'Then Include(Option,SubDirectory)Else
   If S='I'Then Include(Option,MinMaj)
    Else
   Begin
    PutLine(Q,'Erreur: ParamŠtre invalide!');
    Exit;
   End;
  End
   Else
  If S[1]='"'Then Begin
   Param[I]:=pString;Inc(NS);
   Find:=Copy(S,2,Length(S)-2)
  End
   Else
  Param[I]:=pPath;
 End;
 If Not((Page)in(Option))Then Begin
  If NS<>1Then Begin
   PutLine(Q,'Erreur: ChaŒne de caractŠres requis');
   Exit;
  End;
 End;
 If MaxAvail>65520Then SizeBuf:=65520 Else SizeBuf:=MaxAvail;
 Buffer:=MemAlloc(SizeBuf);
 If SizeBuf>256Then SizeBufX:=256 Else SizeBufX:=SizeBuf;
 If(Buffer=NIL)Then Begin
  PutLine(Q,'Erreur: M‚moire insuffisante');
  Exit;
 End;
 For I:=1to(Q.NP)do If(Param[I]=pPath)Then Begin
  Bar:=False;
  SearchDir(PDExtractExt(Q,I,Bar));
 End;
 If(Page)in(Option)Then Begin
  PutLine(Q,'Nombre de page(s) globale '+CStr(NPage)+' contenu dans '+CStr(NmFiles)+' fichier(s)');
  PutLine(Q,'Nombre totale d''octets: '+CStr(NmBytes));
  If(NmFiles>1)and(NmBytes>0)and(NPage>0)Then Begin
   PutLine(Q,'Moyenne d''octets par fichiers: '+CStr(DivLong(NmBytes,NmFiles)));
   PutLine(Q,'Moyenne de pages par fichiers: '+CStr(DivLong(NPage,NmFiles)));
  End;
 End
  Else
 If Not(Found)Then PutLine(Q,'D‚sol‚! Aucune chaŒne correspondante trouv‚...');
 FreeMemory(Buffer,SizeBuf);
 If(KeyPress)Then ReadKey;
 WESetPause(Q.Ansi,False);
End;

Procedure PDRename(Var Q:Prompt);
Var
 Rec:SearchRec;
 Source,Target,TSource,TTarget:String;
 Bar:Boolean;
Begin
 Bar:=No;Source:=PDExtractExt(Q,1,Bar);
 If Source='?'Then Begin
  DumpHelpDos(Q.Ansi,30);
  Exit;
 End;
 If Q.NP<>2Then PutLine(Q,'Nombre de paramŠtres invalide!')
  Else
 Begin
  Bar:=No;Target:=PDExtractExt(Q,2,Bar);
  If IsWildCard(Source)Then Begin
   FindFirst(Source,fa,Rec);
   While SysErr=0do Begin
    TSource:=Path2Dir(Source)+Rec.Name;
    TTarget:=Src2Target(TSource,Target);
    PutLine(Q,TSource+' -> '+TTarget);
    RenameFile(TSource,TTarget);
    If GetSysErr>0Then PutLine(Q,GetErrMsg(GetSysErr));
    FindNext(Rec);
   End;
  End
   Else
  Begin
   If IsWildCard(Target)Then Target:=Src2Target(Rec.Name,Target)
			Else Target:=Src2Target(Source,Target);
   PutLine(Q,Source+' -> '+Target);
   RenameFile(Source,Target);
  End;
 End;
End;

Procedure PDRenDir(Var Q:Prompt);
Var
 Source,Target:String;
 Bar:Boolean;
Begin
 Bar:=No;Source:=PDExtractExt(Q,1,Bar);
 If Source='?'Then Begin
  DumpHelpDos(Q.Ansi,29);
  Exit;
 End;
 If Q.NP<>2Then PutLine(Q,'Nombre de paramŠtres invalide!')
  Else
 Begin
  Bar:=No;Target:=PDExtractExt(Q,2,Bar);
  RenDir(Source,Target);
  If GetSysErr>0Then PutLine(Q,GetErrMsg(GetSysErr));
 End;
End;

Procedure PDFormat(Var Q:Prompt);
Var
 Source:String;
 Bar:Boolean;
Begin
 Bar:=No;Source:=PDExtractExt(Q,1,Bar);
 If Q.NP>0Then Begin
  If Source='?'Then DumpHelpDos(Q.Ansi,HelpDos4MAT)
               Else PutLine(Q,'ParamŠtres invalide!');
 End
  Else
 Format;
End;

{$I \Source\Chantal\Library\CPU\Cyrix\SetCPUID.Inc}

Procedure PDCPUID(Var Q:Prompt);
Var
 S:String;
 Bar:Boolean;
Begin
 Case(Q.NP)of
  0:Begin
   S:='L''instruction ®CPUID¯ est ';
   If(CPUID)Then AddStr(S,'activ‚')
            Else AddStr(S,'d‚sactiv‚');
   PutLine(Q,S);
  End;
  1:If(CPUVendor<>cvCyrix)Then Begin
   PutLine(Q,'Commande non-support‚e par ce processeur!');
  End
   Else
  Begin
   Bar:=False;
   S:=PDExtractExt(Q,1,Bar);
   If S='ON'Then Begin
    SetCPUID(True);
    CPUID:=True;
   End
    Else
   If S='OFF'Then Begin
    SetCPUID(No);
    CPUID:=No;
   End
    Else
   PutLine(Q,'ParamŠtre invalide!');
  End;
  Else PutLine(Q,'Trop de paramŠtres');
 End;
End;

Procedure PDChCP(Var Q:Prompt);Begin
 If Q.NP=0Then Begin
  Q.Param:='MODE CON: CP';
  PDCommand(Q);
 End
  Else
 PutLine(Q,'ParamŠtre non support‚e!');
End;

Procedure PDCrll(Var Q:Prompt);
Var
 S:String;
 Bar:Boolean;
Begin
 If Q.NP=0Then PutLine(Q,'Nom de fichier requis!')
  Else
 Begin
  S:=PDExtractExt(Q,1,Bar);
  If S='?'Then PutLine(Q,'CRLL nomfichier[.RC]')
          Else MakeRLLFile(S,NIL);
 End;
End;

Procedure PDShow(Var Q:Prompt);
Var
 S:String;
 Bar:Boolean;
Begin
 If Q.NP>0Then Begin
  Bar:=False;
  S:=PDExtractExt(Q,1,Bar);
  If S='TIME'Then PDTime(Q,False)
             Else PutLine(Q,'ParamŠtre inconnu');
 End;
End;

Procedure PDPutTimeDate(Var Q:Prompt);
Var
 Hour,Min,Sec,Sec100:Byte;
 Year:Word;
 Month,Day,DayOfWeek:Byte;
Begin
 GetDate(Year,Month,Day,DayOfWeek);
 GetTime(Hour,Min,Sec,Sec100);
 PutLine(Q,_CStrDate(Year,Month,Day,DayOfWeek)+' '+
           CStrTimeDos(Hour,Min,Sec));
End;

Procedure PDExecBatch{Var Q:Prompt;Const Name:String};
Var
 L:ArrayList;
 I:Integer;
 PC:PChr;
 OldEcho:Boolean;
Begin
 If ALLoadFileASCII(L,Name)Then Begin
  PDUpdateEcho(Q);
  For I:=0to L.Count-1do Begin
   If(NxtKey=kbEsc)Then Begin
    ReadKey;
    If(WarningMsgYesNo('D‚sirez-vous arrˆtez l''ex‚cution du fichier ®Batch¯?')=kbYes)Then Break;
   End;
   PC:=_ALGetBuf(L,I);
   If(PC<>NIL)Then Begin
    Q.Param:=LTrim(StrPas(PC));
    OldEcho:=Q.Echo;
    If StrI(1,Q.Param)='@'Then Begin
     Q.Param:=LTrim(Copy(Q.Param,2,255));
     Q.Echo:=False;
    End;
    PDCommand(Q);
    Q.Echo:=OldEcho;
   End
    Else
   Break;
  End;
  PDUpdateEcho(Q);
  ALDone(L);
 End
  Else
 PutLine(Q,'Ex‚cution impossible du fichier "Batch".');
End;

Function FindSelect:String;
Var
 Data:Record
  S,T:String;            { Source, chaŒne … rechercher }
  CaseSensitive:Boolean; { CaractŠre stricte }
  SubSearch:Boolean;     { Recherche dans les sous-r‚pertoires }
  Pause:Boolean;         { Effectue une pause quand la page est pleine }
 End;
Begin
 FindSelect:='';
 FillClr(Data,SizeOf(Data));
 Data.S:='*.*';Data.Pause:=True;
 If ExecuteAppDPU(18,Data)Then Begin
  Data.S:='FIND "'+Data.T+'" '+Data.S;
  If(Data.CaseSensitive)Then AddStr(Data.S,' /I');
  If(Data.SubSearch)Then AddStr(Data.S,' /D');
  If(Data.Pause)Then AddStr(Data.S,' /P');
  FindSelect:=Data.S;
  Exit;
 End;
End;

Procedure PDWinFind(Var Q:Prompt);Begin
 Q.Param:=FindSelect;
 If Q.Param<>''Then Begin
  _WELn(Q.Ansi);
  PDCommand(Q);
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                             Fonction PDRun                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: Prompt


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet … l'utilisateur d'entr‚e ses commandes du prompt
 DOS et de se les faires ex‚cuter.


 Retour
 ÍÍÍÍÍÍ

  Code clavier utilisateur ne s'appliquant … l'objet du prompt DOS.
}

Function PDRun{Var Qx):Word};
Label Restart;
Var
 K:Word;                      { Code clavier (caractŠre, scan code) }
 Buffer:Array[0..512]of Chr; { Tampon de l'entr‚e utilisateur }
 PBuffer:PChr;               { Pointeur sur l'entr‚e utilisateur }
 Shift,Ctrl:Bool;            { ®Shift¯ enfonc‚, ®Ctrl¯ enfonc‚ }
 Q:Prompt Absolute Qx;       { D‚finition de l'objet de prompt DOS }
 S:String;                   { ChaŒne de caractŠres temporaires }

 Function RunContextMenu:Boolean;
 Var
  K:Word;
 Begin
  RunContextMenu:=True;
  K:=RunMenuApp(7);
  Case(K)of
   $F001:WEClrScr(Q.Ansi);
   $F002:Begin
    Q.Param:='DIR';
    PDCommand(Q);
   End;
   $F003:Begin
    Q.Param:=OpenWin('*.*','Fichier … typer');
    If Q.Param<>''Then Begin
     Q.Param:='TYPE '+Q.Param;
     PDCommand(Q);
    End;
   End;
   $F004:Begin
    Q.Param:=Char(SelectDisk(0)+64)+':';
    PDCommand(Q);
   End;
   $F005:Begin
    Q.Param:='?';
    PDCommand(Q);
   End;
   $F006:Begin
    Q.Param:=OpenWin('*.*','Fichier … imprimer');
    If Q.Param<>''Then Begin
     Q.Param:='PRNFILE '+Q.Param;
     PDCommand(Q);
    End;
   End;
   $F007:CopySelect;
   $F008:Begin
    Q.Param:=FindSelect;
    If Q.Param<>''Then PDCommand(Q);
   End;
   $F009:Begin
    StrCatPas(PBuffer,PDConvDOS2Path(Q,SelectDirectory('Ins‚rer',GetCurrentDir,False)));
    RunContextMenu:=False;
   End;
   $F00A:Begin
    StrCatPas(PBuffer,PDConvDOS2Path(Q,OpenWin('*.*','Ins‚rer')));
    RunContextMenu:=False;
   End;
   kbMouse:Begin
    WaitMouseBut0;
    RunContextMenu:=False;
   End;
  End;
 End;

Begin
Restart:
 Repeat
  If(Q.Echo)Then Begin
   If(OS2)or(Win>=winEnhanced)Then Begin
    If(Q.Mode=piDOS)or(Q.Mode and(pi4DOS+piNDOS+piOS2+piWindows9X)>0)Then Begin
     K:=Q.Ansi.CurrColor;
     WEPushCursor(Q.Ansi);
     If(OS2)Then Begin
      If(IsBlink)Then Q.Ansi.CurrColor:=Green shl 4
                 Else Q.Ansi.CurrColor:=LightGreen shl 4;
     End
      Else
     If(IsBlink)Then Q.Ansi.CurrColor:=Red shl 4
                Else Q.Ansi.CurrColor:=LightRed shl 4;
     WEBarSpcHor(Q.Ansi,0,0,wnMax);
     If(OS2)Then S:='OS/2'Else
     If(Win=winEnhanced)and(WinLoVer=4)and(WinHiVer=0)Then S:='Windows 95'Else
     If(Win=winEnhanced)and(WinLoVer=4)and(WinHiVer=10)Then S:='Windows 98'Else
     If(Win=winNT)Then S:='Windows NT'Else S:='DOS';
     WEPutTxtXY(Q.Ansi,2,0,S+'   Ctrl+Esc = Liste des fenˆtres');
     WEPutTxtXY(Q.Ansi,wnMax-11,0,'F1 = Aide');
     Q.Ansi.CurrColor:=K;
     WEPopCursor(Q.Ansi);
     If Q.Ansi.Y=0Then Begin
      Q.Ansi.Y:=1;
      If Q.ImageLst.Count=0Then ALAddLn(Q.ImageLst);
     End;
    End;
   End;
   _WEHL(Q.Ansi);
   Case(Q.Convention)of
    pDOS:PutStr(Q,GetPrompt);
    pUnix:PutStr(Q,Q.PS1);
    Else PutStr(Q,'$');
   End;
   WESetKr(Q.Ansi,CurrKrs.MalteDos.Env.Default);
  End;
  Buffer[0]:=#0;PBuffer:=@Buffer;
  Repeat
   K:=WEInp(Q.Ansi,PBuffer,SizeOf(Buffer)-1,False);
   Ctrl:=ShiftPress;Shift:=(Ctrl)or(CtrlPress);
   Case(K)of
    kbPgUp,kbPgDn:StrPCopy(@Buffer,HYChoice(Q.H,WEGetRX1(Q.Ansi)+Q.Ansi.MaxX-2,WEGetRY1(Q.Ansi)+1));
    kbUp:StrPCopy(@Buffer,HYPrev(Q.H));
    kbDn:StrPCopy(@Buffer,HYNext(Q.H));
    kbCtrlB:If(Ctrl)Then StrCatPas(PBuffer,'BEEP')Else Break;
    kbCtrlC:If(Ctrl)Then StrCatPas(PBuffer,'CHDIR')Else Break;
    kbAltC: If(Shift)Then StrCatPas(PBuffer,'CHDIR')Else Break;
    kbCtrlD:If(Ctrl)Then StrCatPas(PBuffer,'DIR')Else Break;
    kbAltD: If(Shift)Then StrCatPas(PBuffer,'DIR')Else Break;
    kbCtrlE:If(Ctrl)Then StrCatPas(PBuffer,'ERASE')Else Break;
    kbAltE: If(Shift)Then StrCatPas(PBuffer,'ERASE')Else Break;
    kbCtrlF:If(Ctrl)Then StrCatPas(PBuffer,'FREE')Else Break;
    kbAltF: If(Shift)Then StrCatPas(PBuffer,'FREE')Else Break;
    kbAltG: If(Shift)Then StrCatPas(PBuffer,'GREP')Else Break;
    kbCtrlM:If(Ctrl)Then StrCatPas(PBuffer,'MEMORY')Else Break;
    kbAltM: If(Shift)Then StrCatPas(PBuffer,'MEMORY')Else Break;
    kbCtrlR:If(Ctrl)Then StrCatPas(PBuffer,'RMDIR')Else Break;
    kbAltR: If(Shift)Then StrCatPas(PBuffer,'RMDIR')Else Break;
    kbAltS: StrCatPas(PBuffer,'SET');
    kbAltT: StrCatPas(PBuffer,'TYPE');
    kbAltV: StrCatPas(PBuffer,'VOL');
    kbInWn:If LastMouseB=2Then Begin
     If(RunContextMenu)Then Goto Restart;
    End;
    Else Break;
   End;
  Until False;
  HYQueue(Q.H,StrPas(@Buffer));
  Q.Param:=Trim(StrPas(@Buffer));
{  If(K=kbMouse)Then Begin
   If WEInCloseIcon(Q.Ansi,LastMsX,LastMsY)Then K:=kbClose;
   If WEInZoomIcon(Q.Ansi,LastMsX,LastMsY)Then K:=kbZoom;
  End;}
  If(K<>kbEnter)Then Begin
   PDRun:=K;
   Exit;
  End;
  Q.Ansi.X:=0;Q.TmpImageLst:='';
  If(Q.Echo)Then Begin
   Case(Q.Convention)of
    pDOS:PutStr(Q,GetPrompt);
    pUnix:PutStr(Q,Q.PS1);
    Else PutStr(Q,'$');
   End;
  End;
  WESetKrSel(Q.Ansi);
  PutLine(Q,Q.Param);
  WESetKr(Q.Ansi,CurrKrs.MalteDos.Env.Default);
  Case PDCommand(Q)of
   kbClose:Begin
    PDRun:=kbClose;
    Exit;
   End;
   kbRefresh:Begin
    PDRun:=kbRefresh;
    Exit;
   End;
  End;
  Ln(Q);
 Until No;
End;

Function PDTitle(Var Context;Max:Byte):String;
Var
 S:String;
 Q:Prompt Absolute Context;
Begin
 Case(Q.Convention)of
  pDOS:S:='DOS';
  pVAX:S:='VAX';
  pUnix:S:='Unix';
  Else S:='';
 End;
 PDTitle:='Prompt '+S;
End;

{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                           Destructeur PDDone                          Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Propri‚taire: Prompt


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette proc‚dure permet de lib‚rer de mettre fin … la fenˆtre de dialogue
  de prompt DOS d‚finit par la variable de param‚trage ®Q¯.
}

Function PDDone;
Var
 Q:Prompt Absolute Context;
Begin
 ALDone(Q.ImageLst);
 Q.History.Len:=514;
 Q.History.EndCmd:=HYGetSizeBuffer(Q.H);
 If Q.History.EndCmd>0Then Begin
  CreateKeyFormat(HKEY_CURRENT_USER,'Software\Prompt\History',WordToStr(Q.Mode),tdBlob,Q.History);
 End;
 HYDone(Q.H);
 HYDone(Q.Alias);
 WEDone(Q.Ansi);
 PDDone:=0;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ·}
{³              O b j e t  ® S h e l l  U n i x ¯              º}
{ÔÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼}

Function Dos2UnixPath(Path:String):String;Near;Begin
 If Path[2]=':'Then Begin
  Case Path[1]of
   'A','a':Path:='/dev/fd0'+StrDn(DelStr(Path,1,2));
   'B','b':Path:='/dev/fd1'+StrDn(DelStr(Path,1,2));
   Else Path:=StrDn(DelStr(Path,1,2));
  End;
 End;
 ChgChr(Path,'\','/');
 Dos2UnixPath:=Path;
End;

Function Unix2DosPath(Path:String):String;Near;Begin
 ChgChr(Path,'/','\');
 If CmpLeft(Path,'\dev\fd0')Then Path:='A:\'+Copy(Path,9,255)Else
 If CmpLeft(Path,'\dev\fd1')Then Path:='B:\'+Copy(Path,9,255);
 Unix2DosPath:=Path;
End;

{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                       Constructeur PUInit                      Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Propri‚taire: Munix


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette fonction initialise la fenˆtre de dialogue de Shell Unix et
  l'affecte … la variable de param‚trage ®Q¯.
}

Function PUInit;
Var
 Q:Prompt Absolute Context;
Begin
 PUInit:=PDInitMode(Context,X1,Y1,X2,Y2,piUnix);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Fonction PULoadStr                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: Munix


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de connaŒtre la valeur d'une chaŒne de caractŠres
 de format C ou ASCIIZ contenu … partir de la position  de la variable de
 param‚trage ®I¯ de la variabe de l'objet contenant les paramŠtres Unix.
}

Function PULoadStr(Var Q:Prompt;Var I:Byte):String;
Var
 S,S1:String;
Begin
 S:='';I:=1;
 Repeat
  Case Q.Ext[I]of
   '"':Begin
    Inc(I);
    While(Length(Q.Ext)>=I)do Begin
     Case Q.Ext[I]of
      '"':Break;
      '\':Begin
       Inc(I);
       Repeat
        Case Q.Ext[I]of
         'b':AddStr(S,#8);
         'c':AddStr(S,#13);
         'f':AddStr(S,#12);
         'n':AddStr(S,CRLF);
         'r':AddStr(S,#10);
         't':AddStr(S,#9);
         'v':AddStr(S,#$0B);
         '\':AddStr(S,'\');
         '0'..'7':Begin
          S1:=XtrkOctNm(I,Q.Ext);
          IncStr(S,Chr(OctStr2Nm(S1)));
          Break;
         End;
        End;
        Inc(I);
       Until True;
      End;
      Else Begin
       IncStr(S,Q.Ext[I]);
       Inc(I)
      End;
     End;
    End;
    If Q.Ext[I]<>'"'Then Break;
    Inc(I);
   End;
   '$':Begin
    Inc(I);
    S1:=XtrkWord(I,Q.Ext);
    If S1='HOME'Then AddStr(S,Q.PathVar);
   End;
   ' ','+':Inc(I);
   Else Break;
  End;
 Until I>Length(Q.Ext);
 PULoadStr:=S;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure PURunBanner                    Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: Munix


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'afficher une chaŒne de caractŠres en format
 gigantesque dans la fenˆtre de dialogue du Shell Unix.
}

Procedure PURunBanner;
Var
 TB:Array[0..7,0..79]of Char;
 I,J:Byte;
 S:String;

 Procedure PutTTextXY;
 Var
  Mtx:^TByte;
  _BH,I,J,K,Masque:Byte;
  _ES,_BP:Word;
 Begin
  {$IFNDEF FLAT386}
   ASM
    MOV AX,$1130
    MOV BH,$03
    PUSH BP
     INT $10
     MOV BX,BP
    POP BP
    MOV _BP,BX
    MOV _ES,ES
   END;
   Mtx:=Ptr(_ES,_BP);
   For J:=0to Length(S)-1do For I:=0to 7do Begin
    Masque:=Mtx^[8*Byte(S[J+1])+I];
    For K:=0to 7do Begin
     If Masque and 128<>0Then TB[I,J*8+K]:='#';
     Masque:=Masque shl 1;
    End;
   End;
  {$ENDIF}
 End;

Begin
 If Q.Ext=''Then Exit;
 S:=PULoadStr(Q,I);
 If I<=Length(Q.Ext)Then Begin
  PutLine(Q,'Erreur de chaŒne de caractŠres');
  Exit;
 End;
 FillSpc(TB,SizeOf(TB));
 Systems._Left(S,10);
 PutTTextXY;
 For J:=0to 7do Begin
  For I:=0to Length(S)*8-1do PutStr(Q,TB[J,I]);
  If Length(S)<10Then Ln(Q);
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Proc‚dure PUbasename                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: Munix


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet … l'utilisateur de connaŒtre la partie base (le
 nom et l'extension sans chemin) d'un fichier unix.
}

Procedure PUbasename(Var Q:Prompt);
Var
 S:String;
 Bar:Boolean;
Begin
 If Q.Ext=''Then Begin
  PutLine(Q,'Chemin attendu!');
  Exit;
 End;
 S:=PDExtractExt(Q,1,Bar);
 PutLine(Q,Path2Name(S));
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure PUdirname                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: Munix


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet … l'utilisateur de connaŒtre la partie dir (le
 chemin) d'un nom de fichier unix.
}

Procedure PUdirname(Var Q:Prompt);
Var
 S:String;
 Bar:Boolean;
Begin
 If Q.Ext=''Then Begin
  PutLine(Q,'Chemin attendu!');
  Exit;
 End;
 S:=PDExtractExt(Q,1,Bar);
 S:=Path2Dir(S);
 PutLine(Q,PDConvDOS2Path(Q,S));
End;

{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                           Proc‚dure PUcd                           Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Propri‚taire: Munix


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette proc‚dure permet de changer de r‚pertoire dans le  ®Shell Unix¯
  d‚sign‚ par la variable de param‚trage ®Q¯.


  Remarque
  ÍÍÍÍÍÍÍÍ

   ş Le r‚pertoire  de l'enregistrement  ®Munix¯,  item  ®PathUnix¯  est
     d‚finit comme un r‚pertoire du systŠme  d'exploitation DOS et de ce
     fait   r‚pertoires   ®/dev/fd0¯   et   ®/dev/fd1¯  sont   convertis
     automatiquement pour l'unit‚ A dans le cas du r‚pertoire ®/dev/fd0¯
     et l'unit‚ B dans le cas de du r‚pertoire ®/dev/fd1¯.
}

Procedure PUcd(Var Q:Prompt);
Var
 S:String;
 TS:String;
 Exist:Boolean;
 I:Char;
 Bar:Boolean;
Begin
 If Q.Ext=''Then Begin
  PutLine(Q,'Chemin attendu!');
  Exit;
 End;
 S:=PDExtractExt(Q,1,Bar);
 If((S='bin')and(Length(Q.PathUnix)<=3))or
    (S='\bin')Then Q.PathUnix:='\bin'Else
 TS:=SetPath4AddFile(Q.PathUnix)+S;
 If DirExist(TS)Then Q.PathUnix:=FileExpand(TS)
  Else
 Begin
  Exist:=False;
  For I:='C'to'Z'do If DirExist(I+':'+S)Then Begin
   Q.PathUnix:=FileExpand(I+':'+S);
   Exist:=True;
   Break;
  End;
  If Not(Exist)Then PutLine(Q,'Chemin invalide!');
 End;
End;

{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                            Proc‚dure PUecho                          Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Propri‚taire: Munix


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette proc‚dure permet d'afficher un message dans le Shell Unix d‚sign‚
  par la variable de param‚trage ®Q¯.
}

Procedure PUEcho(Var Q:Prompt);
Var
 S:String;
 I:Byte;
Begin
 If Q.Ext=''Then Exit;
 S:=PULoadStr(Q,I);
 If I<=Length(Q.Ext)Then Begin
  PutLine(Q,'Erreur de chaŒne de caractŠres');
  Exit;
 End;
 PutLine(Q,S)
End;

{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                              Proc‚dure PUls                          Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Propri‚taire: Munix


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette proc‚dure permet d'afficher la liste des fichiers d'un r‚pertoire
  dans le Shell Unix d‚sign‚ par la variable de param‚trage ®Q¯.
}

Procedure PUls(Var Q:Prompt);
Const
 MaxParam=256;
Var
 S:String;
 Option:Set of (Time,Sector,Subdirectory,Bin,P,l);
 Bar:Boolean;
 NP,ND,I:Word;
 Param:Array[1..MaxParam]of Boolean;

 Procedure ExecuteDir(S:String);
 Var
  Descr:SearchRec;
  I:Integer;
 Begin
  S:=Unix2DosPath(S);
  If StrUp(S)='\BIN'Then DumpHelpUnix(Q.Ansi,HelpUnixIndex)Else
  If StrUp(S)='\DEV'Then Begin
   PutLine(Q,'console');
   For I:=0to NmFloppyDsk-1do If DiskExist(I)Then PutLine(Q,'fd'+WordToStr(I));
   PutLine(Q,'harddisk'#13#10+
             'lp'#13#10+
             'mem'#13#10+
             'null'#13#10+
             'root'#13#10+
             'swap'#13#10+
             'tty01');
  End
   Else
  Begin
   If(Bin)in(Option)Then Begin
    PutStr(Q,'bin');
    If(P)in(Option)Then Begin
     If(sfaDir)in(Descr.Attr.Flags)Then PutStr(Q,'/');
    End;
    Ln(Q);
   End;
   If(Not IsWildCard(S))Then S:=SetPath4AddFile(S)+'*.*';
   If FileExist(S)Then Begin
    FindFirst(S,faAll,Descr);
    While SysErr=0do Begin
     If(Descr.Name<>'..')and(Descr.Name<>'.')Then Begin
      PutStr(Q,StrDn(Descr.Name));
      If(P)in(Option)Then Begin
       If(sfaDir)in(Descr.Attr.Flags)Then PutStr(Q,'/');
      End;
      If(l)in(Option)Then Begin { Affiche les attributs? }
       If Q.Ansi.X<16Then Q.Ansi.X:=16;
       If(sfaDir)in(Descr.Attr.Flags)Then PutStr(Q,'d')
                                     Else PutStr(Q,'-');
       If(sfaReadOnly)in(Descr.Attr.Flags)Then PutStr(Q,'r')
                                          Else PutStr(Q,'w');
       If(sfaSysFile)in(Descr.Attr.Flags)Then PutStr(Q,'s')
                                         Else PutStr(Q.Ansi,'-');
       If(sfaHidden)in(Descr.Attr.Flags)Then PutStr(Q,'h')
                                        Else PutStr(Q,'-');
       If(sfaArchive)in(Descr.Attr.Flags)Then PutStr(Q,'a')
                                         Else PutStr(Q,'-');
      End;
      If(Sector)in(Option)Then Begin
       If Q.Ansi.X<16Then Q.Ansi.X:=16;
       PutStr(Q,Str2((Descr.Size shr 9)+Byte((Descr.Size and$1FF)>0),10)+' ');
      End;
      If(Time)in(Option)Then Begin
       If Q.Ansi.X<16Then Q.Ansi.X:=16;
       PutStr(Q,' '+TimeToStr(Descr.Time));
      End;
      Ln(Q);
      If((Subdirectory)in(Option))and((sfaDir)in(Descr.Attr.Flags))Then
       ExecuteDir(Path2Dir(S)+Descr.Name);
     End;
     FindNext(Descr);
    End;
   End
    Else
   If Not((Subdirectory)in(Option))Then PutLine(Q,'Fichier introuvable!');
  End;
 End;

Begin
 NP:=PDMaxExtractExt(Q);
 If(NP>MaxParam)Then Begin
  PutLine(Q,'Erreur: Trop de paramŠtres!');
  Exit;
 End;
 FillClr(Param,SizeOf(Param));
 Option:=[];ND:=0;
 If NP>0Then Begin
  For I:=1to(NP)do Begin
   Bar:=False;
   S:=PDExtractExt(Q,I,Bar);Param[I]:=True;
   If(Bar)Then Begin
    If S='?'Then Begin
     DumpHelpUnix(Q.Ansi,HelpUnixls);
     Exit;
    End
     Else
    If S='l'Then Include(Option,l)Else
    If S='s'Then Include(Option,Sector)Else
    If S='t'Then Include(Option,Time)Else
    If S='F'Then Include(Option,P)Else
    If S='R'Then Include(Option,Subdirectory)Else
    If(StrUp(S)='P')or(StrUp(S)='PAUSE')Then WESetPause(Q.Ansi,True) {Non-Standard … Unix}
     Else
    Begin
     Param[I]:=False;
     Inc(ND)
    End;
   End
    Else
   Begin
    Param[I]:=False;
    Inc(ND)
   End;
  End;
 End;
 If Length(Q.PathUnix)<=3Then Begin
  If Not DirExist(Path2Drv(Q.PathUnix)+'\BIN')Then Include(Option,Bin);
 End;
 If ND=0Then ExecuteDir(Q.PathUnix)
  Else
 For I:=1to(NP)do If Not Param[I]Then Begin
  Bar:=False;
  S:=PDExtractExt(Q,I,Bar);
  ExecuteDir(S);
 End;
 WESetPause(Q.Ansi,False);
End;

{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                           Proc‚dure PUman                         Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Propri‚taire: Munix


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette proc‚dure permet d'obtenir de l'aide sur une commande du Shell
  Unix d‚sign‚ par la variable de param‚trage ®Q¯.


  Remarque
  ÍÍÍÍÍÍÍÍ

   ş Si la commande d'appel contenu dans l'enregistrement, item ®Param¯
     n'est pas ®man¯ m'est ®help¯ comme XENIX la commande est support‚e
     … titre de compatibilit‚ avec se systŠme d'exploitation.
}

Procedure PUman(Var Q:Prompt);Begin
 If Q.Ext=''Then Begin
  If Q.Param='help'Then DumpHelpUnix(Q.Ansi,HelpUnixHelp)
   Else
  Begin
   PutLine(Q,'Cette commande permet d''obtenir de l''aide sur une commande');
   PutLine(Q,'quelconque de Unix.');
   Ln(Q);
   PutLine(Q,'Syntaxe: man [commande]');
  End;
 End
  Else
 Begin
  If(Q.Ext='all')or(Q.Ext='global')or(Q.Ext='index')Then DumpHelpUnix(Q.Ansi,HelpUnixIndex)Else
  If Q.Ext='basename'Then DumpHelpUnix(Q.Ansi,HelpUnixBaseName)Else
  If Q.Ext='dirname'Then DumpHelpUnix(Q.Ansi,HelpUnixDirName)Else
  If Q.Ext='exit'Then Begin
   PutLine(Q,'Commande: logout');
   Ln(Q);
   PutLine(Q,'Cette commande permet de quitter le "Shell" Unix.');
  End
   Else
  If Q.Ext='logout'Then Begin
   PutLine(Q,'Commande: logout');
   Ln(Q);
   PutLine(Q,'Cette commande permet de quitter le "Shell" Unix.');
  End
   Else
  If Q.Ext='ls'Then DumpHelpUnix(Q.Ansi,HelpUnixls)Else
  Begin
   PutLine(Q,'Nom de commande inconnu!');
  End;
 End;
End;

{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                           Proc‚dure PUpwd                          Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Propri‚taire: Munix


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette proc‚dure permet d'afficher le r‚pertoire courant du Shell Unix
  d‚sign‚ par la variable de param‚trage ®Q¯.


  Remarque
  ÍÍÍÍÍÍÍÍ

   ş Le r‚pertoire  de l'enregistrement  ®Munix¯,  item  ®PathUnix¯  est
     d‚finit comme un r‚pertoire du systŠme  d'exploitation DOS et de ce
     fait les unit‚s ®A:¯ et  ®B:¯  sont convertis  automatiquement pour
     les r‚pertoires ®/dev/fd0¯  dans le cas de l'unit‚ A et  ®/dev/fd1¯
     dans le cas de l'unit‚ B.
}

Procedure PUpwd(Var Q:Prompt);Begin
 PutLine(Q,Dos2UnixPath(Q.PathUnix))
End;

{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                           Proc‚dure PUwhoami                          Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Propri‚taire: Munix


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette proc‚dure est l'‚quivalent de la commande ®who am i¯ de Unix, elle
  retourne le nom de l'utilisateur courant.  Cette proc‚dure utilise le nom
  contenu dans la variable ®RegUserName¯ de cette unit‚ afin  de renseigner
  l'usager.  Cette variable est  utilis‚  normalement  pour  enregistrer un
  programme, il s'agit donc d'un bon compromis.
}

Procedure PUwhoami(Var Q:Prompt);Begin
 PutLine(Q,StrPas(RegUserName));
End;

Var CurrPrompt:^Prompt Absolute CurrForm;

Procedure ZipReport(Retcode:LongInt;Rec:PReportRec);
Var
 Message:String;
Begin
 Message:='';
 Case(Rec^.PackMethod)of
  0:Message:='®Stored¯';
  1:Message:='®Unshrink¯';
  6:Message:='®Explode¯';
  8:Message:='®Inflate¯';
 End;
 AddStr(Message,' le fichier ®');
 PutStr(CurrPrompt^,Message);
 PutLine(CurrPrompt^,StrPas(@Rec^.FileName)+'¯');
 If RetCode<16000Then Exit;
 If RetCode>=17000Then Exit;
 PutLine(CurrPrompt^,GetErrMsg(RetCode));
End;

Procedure PDUnZip(Var Q:Prompt);
Var
 Bar:Boolean;
 Zip:ZipClass;
 Source,Target,WildCard:String;
Begin
 If(PDExtractExt(Q,1,Bar)='?')and(Bar)Then DumpHelpDos(Q.Ansi,HelpDosUnzip)
  Else
 Begin
  WildCard:=PDExtractExt(Q,2,Bar);
  If WildCard=''Then WildCard:='*.*';
  UnzipInit(Zip);
  CurrForm:=@Q;
  Source:=PDExtractExt(Q,1,Bar);
  If Path2Ext(Source)=''Then AddStr(Source,'.ZIP');
  Target:=GetCurrentDir;
  FileUnzip(Zip,Source,Target,WildCard,ZipReport,NIL);
  UnzipDone(Zip);
 End;
End;

Procedure PDDiskCopy(Var Q:Prompt);
Var
 A,B:String;
 Bar:Boolean;
 UnitSource:Boolean;
 UnitTarget:Boolean;
Begin
 If(PDExtractExt(Q,1,Bar)='?')and(Bar)Then DumpHelpDos(Q.Ansi,HelpDosDiskCopy)Else
 If Q.NP<>2Then PutLine(Q,'Nombre de paramŠtre invalide!')
  Else
 Begin
  Bar:=False;
  A:=StrUp(PDExtractExt(Q,1,Bar));
  Bar:=False;
  B:=StrUp(PDExtractExt(Q,2,Bar));
  UnitSource:=(Length(A)=2)and(A[2]=':')and(IsRomanLetter(A[1]));
  UnitTarget:=(Length(B)=2)and(B[2]=':')and(IsRomanLetter(B[1]));
  If(UnitSource)and(UnitTarget)Then DiskCopy(Drv2Dsk(A[1])-1,Drv2Dsk(B[1])-1)Else
  If(UnitSource)Then CopyDiskToFile(Drv2Dsk(A[1])-1,B)Else
  If(UnitTarget)Then CopyFileToDisk(A,Drv2Dsk(B[1])-1)
                Else PutLine(Q,'Unit‚ sans relation!')
 End;
End;

Function PDCommand(Var Q:Prompt):Word;
Label Xit,UnknownCommand;
Var
 I,J:Word;                   { Compteur de boucle }
 D,De:Word;                  { Taille du tampon ‚cran, position de d‚part de celle-ci }
 Buffer:Array[0..512]of Chr; { Tampon de l'entr‚e utilisateur }
 Bar:Boolean;                { Indicateur de barre dans le paramŠtre }
 NameCmd:String;
 Instr:DataSetInMemory;
 Len:Word;                   { Longueur d'une instruction }
 PS:^String;                 { Pointeur de chaŒne de caractŠres }
 PW:^Word;                   { Pointeur sur un mot }

 Procedure Elem(Const S:String);Begin
  PutStr(Q,StrUSpc(S,16));
  If Q.Ansi.X+16>Q.Ansi.MaxX+1Then Ln(Q)
 End;

 Function RunBatch:Boolean;
 Var
  S:String;
 Begin
  RunBatch:=True;
  S:=Copy(Q.Param,Length(Q.Param)-3,4);
  If(S='.BAT')or(S='.BTM')Then PDExecBatch(Q,S)
   Else
  Begin
   S:=Q.Param+'.BAT';
   If FileExist(S)Then PDExecBatch(Q,S)
    Else
   Begin
    S:=Q.Param+'.BTM';
    If FileExist(S)Then PDExecBatch(Q,S)
                   Else RunBatch:=False;
   End;
  End;
 End;

 {$I Library\System\OSStr.Inc}

Begin
 PDCommand:=0;
 Case(Q.Convention)of
  pUnix:DBOpenServerName(ChantalServer,'CHANTAL:/UNIX/Shell.Dat');
  pVAX:DBOpenServerName(ChantalServer,'CHANTAL:/VAX/DCL.Dat');
  Else DBOpenServerName(ChantalServer,'CHANTAL:/DOS/Prompt.Dat');
 End;
 DBCopyToMemory(ChantalServer,Instr);
 For I:=1to Length(Q.Param)do If Q.Param[I]in[' ','\','/']Then Break;
 Len:=I;
 If Len>1Then Begin
  If Len=Length(Q.Param)Then Begin
   NameCmd:=Q.Param;
   If(Q.Convention<>pUNIX)Then NameCmd:=StrUp(NameCmd);
   Q.Param:=NameCmd;
  End
   Else
  Begin
   NameCmd:=Left(Q.Param,Len-1);
   If(Q.Convention<>pUNIX)Then NameCmd:=StrUp(NameCmd);
   Q.Param:=NameCmd+Copy(Q.Param,I,255);
  End;
 End
  Else
 NameCmd:='';
 Q.Ext:=Q.Param;
 Q.NP:=PDMaxExtractExt(Q)-1;
 PDExtract(Q,NameCmd);
 If Q.Param='?'Then Begin
  Elem('?');              { Fournit cette liste d'aide }
  If Q.Mode and piMalteDOS>0Then Begin
   Elem(':');              { Retourne l'unit‚ courante }
   Elem('*:');             { Affiche toutes les unit‚s disponible}
  End;
  For I:=0to Instr.NumRec-1do Begin
   PW:=@Instr.Table^[Instr.Index^[I]+1];
   If Q.Mode and PW^<>0Then Begin
    PS:=@Instr.Table^[Instr.Index^[I]+3];
    Elem(PS^);
   End;
  End;
 End
  Else
 If(Q.Mode and piMalteDOS>0)and(Length(Q.Param)=2)and(Q.Param[2]=':')Then Begin
  If Q.Param[1]in['?','*']Then Begin
   PutStr(Q,'Unit‚ accessible: ');
   For J:=0to 25do If DiskExist(J)Then PutStr(Q,Chr(J+65)+': ');
   PutLine(Q,'');
  End
   Else
  Begin
   System.ChDir(Q.Param);
   If IoResult<>0Then PutLine(Q,'Unit‚ invalide!');
  End;
 End
  else
 If(Q.Mode and piMalteDOS>0)and(Q.Param=':')Then Begin
  PDPutCurrentDisk(Q);
  PutLine(Q,GetPromptPrn);
 End
  Else
 If DBLocateAbsIM(Instr,2,NameCmd,Q.CmdSearch)Then Begin
  ASM
   {$IFDEF __Windows__}
    LEA EDX,Q
    MOV AX,Word Ptr [EDX].Prompt.Mode
    LEA EDX,DWord Ptr Instr.CurrRec
    AND AX,Word Ptr [EDX+1]
    JZ  UnknownCommand
   {$ELSE}
    LES DI,Q
    MOV AX,Word Ptr ES:[DI].Prompt.Mode
    LES DI,DWord Ptr Instr.CurrRec
    AND AX,Word Ptr ES:[DI+1]
    JZ  UnknownCommand
   {$ENDIF}
  END;
  Case(Instr.CurrRec.Byte^)of
   $01:PDFormat(Q);
   $02:PDAlias(Q);
   $03:PDAttrib(Q);
   $04:PDBE(Q);
   $05:PDBeep(Q);
   $06:PDChDir(Q);
   $07:PDChCP(Q);
   $08:WEClrScr(Q.Ansi);
   $09:PutLine(Q,'Sp‚cification de commande: '+GetEnv('COMSPEC'));
   $0A:PDConfig(Q);
   $0B:PDCopy(Q);
   $0C:PDCPUID(Q);
   $0D:PDCrll(Q);
   $0E:PDDel(Q,doDel);
   $0F:PDDel(Q,doDelQ);
   $10:PDDescribe(Q);
   $11:PDPutDir(Q);
   $12:PDDump(Q,False);
   $13:PDEcho(Q);
   $14:Begin
    PDCommand:=kbClose;
    Goto Xit;
   End;
   $15:Begin
    Bar:=False;
    If(PDExtractExt(Q,1,Bar)='?')and(Bar)Then DumpHelpDos(Q.Ansi,32)
     Else
    Begin
     Q.Param:=Copy(Q.Param,10,255)+'/?';
     PDCommand:=PDCommand(Q);
    End;
   End;
   $16:PDFind(Q);
   $17:PDFree(Q);
   $18:PDFind(Q);
   $19:PDLabel(Q);
   $1A:PDMkDir(Q);
   $1B:PDMemory(Q);
   $1C:If PDMode(Q)Then PDCommand:=kbRefresh;
   $1D:PDMove(Q);
   $1E:PDPutPath(Q);
   $1F:PDPause(Q);
   $20:PDPlay(Q);
   $21:PDRunPrnFiles(Q);
   $22:PutLine(Q,GetEnv('PROMPT'));
   $23:PDRMDir(Q);
   $24:PDRename(Q);
   $25:PDRenDir(Q);
   $26:PDScreen(Q);
   $27:PDSerNo(Q);
   $28:PDPutSet(Q);
   $29:PDRunSetPrn(Q);
   $2A:PDTime(Q,True);
   $2B:PDTrueName(Q);
   $2C:PDTruncText(Q);
   $2D:PDType(Q);
   $2E:PutLine(Q,OperatingSystemStr+', Interpr‚teur de commande version 3.01');
   $2F:PDVerify(Q);
   $30:PDVol(Q);
   $31:PDDump(Q,True);
   $32:PDPutTimeDate(Q);
   $33:PDXDir(Q);
   $5D:PDShow(Q);
   $67:PURunBanner(Q);
   $68:PUbasename(Q);
   $6B:PUcd(Q);
   $78:PUdirname(Q);
   $85:PUecho(Q);
   $93:PUman(Q);
   $9A:PUls(Q);
   $A9:PUpwd(Q);
   $C4:PUwhoami(Q);
   $DA:PDUnZip(Q);
   $DB:PDDiskCopy(Q);
   $DC:DxDiag;
   $00:;
   Else Begin
    PutLine(Q,'Commande non-support‚');
   End;
  End;
 End
  Else
 Begin
UnknownCommand:
  If Q.Param<>''Then Begin
   If(Q.Convention=pVAX)Then PutLine(Q,'Commande non-reconnu')Else
   If(RunBatch)Then PutLine(Q,'')
    Else
   Begin
    If(Q.Ansi.MaxY=MaxYTxts)Then ExecPrg('QUICKSHELL',Q.Param)
    Else ExecPrg('',Q.Param);
    If(Output.X.Handle<>errHdl)Then Begin
     If Output.Length<>0Then Begin
       { Restitution des donn‚es de la r‚gion BIOS concernant le vid‚o...}
      XGetAbsRec(Output.X,Output.X.Size-24,24,Buffer);
      Q.Ansi.Y:=Byte(Buffer[6+1]);
      If(Q.Ansi.Y>Q.Ansi.MaxY)Then Q.Ansi.Y:=Q.Ansi.MaxY;
      D:=DivLong((Output.X.Size-24)shr 1,Output.Length);De:=0;
      If(D>Q.Ansi.Y)and(Q.Ansi.Y<Q.Ansi.MaxY)Then D:=Q.Ansi.Y Else
      If(D>Q.Ansi.MaxY)Then De:=D-Q.Ansi.MaxY;
      Dec(D);
      For J:=De to(D)do Begin
       XGetRec(Output.X,J,Output.Length shl 1,Buffer);
       For I:=0to(Q.Ansi.MaxX)do Begin
        If Buffer[I shl 1]=#0Then Buffer[I shl 1]:=' ';
        Q.Ansi.CurrColor:=Byte(Buffer[I shl 1+1]);
        WESetCube(Q.Ansi,I,J-De,Buffer[I shl 1]);
       End;
      End;
      If(Q.Ansi.Y<Q.Ansi.MaxY)Then WEClrWnBorder(Q.Ansi,0,Q.Ansi.Y+1,wnMax,wnMax);
     End;
    End;
   End;
  End;
 End;
Xit:
 DBDispose(Instr);
End;

Procedure ExecBatch(Const Name:String);
Var
 W:Window;
 Q:Prompt;
Begin
 WEInit(W,3,3,wnMax,wnMax-4);
 WEPushWn(W);
 PDInit(Q,3,3,wnMax,wnMax-4);
 PDExecBatch(Q,Name);
 PDDone(Q);
 WEDone(W);
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
END.