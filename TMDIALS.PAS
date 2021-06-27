{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³    Malte Genesis/Module de Dialogue T‚l‚matique   ³
 ³           Edition Isabel pour Mode R‚el           ³
 ³                 III - Version 1.0                 ³
 ³                     1995/02/02                    ³
 ³                                                   ³
 ³Tous droits r‚serv‚ par les Chevaliers de Malte (C)³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

 Remarque
 ÍÍÍÍÍÍÍÍ

  ş Cette unit‚ est tir‚e du ®PibTerm¯ et n'a jamais r‚ellement
    bien fonctionn‚...
}

Unit TMDials;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                   INTERFACE
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

{$I DEF.INC}
{$IFDEF Overlay}{$O+,F+}{$ENDIF}

Uses
 Systex,BBStex;

Type
 DialWn=Record
  P:LongInt;
  Y:Byte;
  Lst:ArrayList;
  PathDial:PathStr;
  W:Window;
  Select:^TBool;
  SizeSelect:Word;
 End;

 Term=Record
  W,SW:Window;
  CurrCom:Byte;
  AttendedMode,CurrCarrierStatus:Boolean;
  Done,ReallyDone,HostModeFlag,ExpertOn:Boolean;
  LocalHost,ReviewOn,FirstTime,SaveReview:Boolean;
  RecipientName,CurUserName:PathStr;
  MsgSubject,MsgLn,CurHostStatus:String;
  Fname,Lname,PassWord:String[30];
  CRLFHost:String[2];
  NUsers,UserFileSize,CurUser,Ierr,NMsg,SaveHDataBits,
  SaveHStopBits,PageSize,HostIoError:Integer;
  MsgFile:Text;
  BlankTime:LongInt;
  HostSection,LastHostSect,SaveHParity,Privilege:Chr;
  SaveHBaudRate,NewBaud:Word;
  Prot:Prots;
  NewCarrierStatus,PrnOn,FileOn,DialMode:Boolean;
  NmFiles:LongInt;
  Dial:DialWn;
 End;

Function  ACPercentageUsed:Real;
Procedure DownLoad;
Function  EditDialEntry(Var Dial:TMDialRec):Boolean;
Function  SelectTermEmul(X1,Y1,X2,Y2:Byte):Byte;
Procedure StatDialEntry(Dial:TMDialRec);
Procedure TANew(Var Q;X1,Y1,X2,Y2:Byte;Const PathPhoneList:String);
Procedure TAInit(Var Q:Term;Y1,Y2,Com:Byte;Const PathPhoneList:String);
Procedure TAHostMode(Var Q:Term);
Procedure TADoneHostMode(Var Q:Term);
Procedure TAHangUpPhone(Var Q:Term);
Function  TARun(Var QX):Wd;
Function  TADone(Var Q):Word;
Function  TermRun(Var Q):Wd;Far;
Procedure TMInit(Var Q:Term;X1,Y1,X2,Y2,Com:Byte;Const PathPhoneList:String);
Procedure TMAnswerMode(Var Q:Term);
Procedure TMRefresh(Var Q);
Procedure TMPutTxt(Var Q:Term;Const S:String);
Procedure TMPutTxtLn(Var Q:Term;S:String);
Procedure TMLn(Var Q:Term);
Procedure TMClrScr(Var Q:Term);
Procedure TMOriginateMode(Var Q:Term);
Procedure TMPutMode(Var Q:Term;Const M:String);
Procedure TMPutStatus(Var Q:Term;Const S:String);
Procedure TMPutFlags(Var Q:Term);
Procedure TMBackService(Var Q:Term;Const S:String);
Function  TMExecCmd(Var Q:Term;Const S:String):Bool;
Function  TMInput(Var Q:Term;Var S:String):Wd;
Function  TMRun(Var Q:Term):Wd;
Function  TMTitle(Var Q;Max:Byte):String;
Procedure TMDone(Var Q:Term);
Procedure UpLoad;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                               IMPLEMENTATION
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses
 Adele,Memories,Systems,Video,Dials,Terminal,Dostex,Dialex,Isatex,Mouse,
 Time,Protocol,SysInter,DialPlus,SysPlus,CommBase,Math,Registry,Restex,
 ResServD;

Procedure WDInit(Var Q:DialWn);Near;Forward;
Procedure WDInitWin(Var Q:DialWn;X1,Y1,X2,Y2:Byte;FileName:PathStr);Near;Forward;
Function  WDOpen(Var Q:DialWn;FileName:PathStr):Boolean;Near;Forward;
Procedure WDPutWindow(Var Q:DialWn;X1,Y1,X2,Y2:Byte);Near;Forward;
Procedure WDPutLine(Var Q:DialWn;_Y:Byte;_P:Long);Near;Forward;
Function  WDCallNumber(Var Q:DialWn;Const Number:String):Boolean;Near;Forward;
Procedure WDUpKey(Var Q:DialWn);Near;Forward;
Procedure WDDownKey(Var Q:DialWn);Near;Forward;
Procedure WDHangUp(Var Q:DialWn);Near;Forward;
Function  WDRun(Var Q:DialWn;Var RtnDial:TMDialRec):Word;Near;Forward;
Function  _WDRun(Var Q:DialWn):Word;Near;Forward;
Procedure WDDone(Var Q:DialWn);Near;Forward;
Procedure WDSelectBar(Var Q:DialWn);Near;Forward;
Procedure WDUnSelectBar(Var Q:DialWn);Near;Forward;
Procedure WDUpDateInfo(Var Q:DialWn);Near;Forward;

Procedure TMInitModem(Var Q:Term);Near;Forward;
Procedure TAInitHostMode(Var Q:Term);Near;Forward;
Procedure TACreateXferListFile(Var Q:Term;Handle:Hdl);Near;Forward;
Function  TADoHost(Var Q:Term):Wd;Near;Forward;
Procedure TADownloadAFile(Var Q:Term);Near;Forward;
Procedure TAEndPrompt(Var Q:Term;Const Mess:String);Near;Forward;
Procedure TAGetTransferTime(Var Q:Term;Var FileSpec:String;Var NFiles:Integer;Var TransferTimeMsg:String);Near;Forward;
Procedure TAGetUserInfo(Var Q:Term;Var Found:Bool);Near;Forward;
Function  TAGetXferProtocol(Var Q:Term):Byte;Near;Forward;
Procedure TAHostAutoBaudDetect(Var Q:Term;ModemAns:String);Near;Forward;
Procedure TAHostBaudDetect(Var Q:Term);Near;Forward;
Function  TAHostCarrierDetect(Var Q:Term):Bool;Near;Forward;
Procedure TAHostSend(Var Q:Term;C:Chr);Near;Forward;
Procedure TAHostSendStr(Var Q:Term;Const S:String);Near;Forward;
Procedure TAHostSendStrLn(Var Q:Term;Const S:String);Near;Forward;
Procedure TAHostSendStrNEcho(Var Q:Term;Const S:String);Near;Forward;
Procedure TAHostPromptNReadStr(Var Q:Term;Const Prompt:String;Var S:String;Echo:Bool);Near;Forward;
Procedure TAListFiles4Transfer(Var Q:Term);Near;Forward;
Procedure TAListPrompt(Var Q:Term;Var ListCount:Integer;Var ListDone:Bool);Near;Forward;
Function  TAOpen4Append(Var Q:Term;Var F:Text;Const FNm:String;Var Error:Integer):Bool;Near;Forward;
Procedure TAPageSysop(Var Q:Term;Var SysopFound:Bool);Near;Forward;
Procedure TAPutHostCmd(Var Q:Term);Near;Forward;
Procedure TAPutWelcomeMsg(Var Q:Term);Near;Forward;
Procedure TAPutXferCmd(Var Q:Term);Near;Forward;
Procedure TAPutXferProtocols(Var Q:Term);Near;Forward;
Function  TAProcessFileTransferCmd(Var Q:Term;Var Done,Back:Bool):Wd;Near;Forward;
Function  TAProcessHostCmd(Var Q:Term;Var Done:Bool):Wd;Near;Forward;
Procedure TAResetThePort(Var Q:Term);Near;Forward;
Procedure TAUploadAFile(Var Q:Term);Near;Forward;
Procedure TAWriteLog(Var Q:Term;Const S:String;Cont,Scr:Bool);Near;Forward;
Procedure TAWait4Ring(Var Q:Term;Var Done:Bool);Near;Forward;
Function  WinInpUser(Var User:UserRec):Bool;Near;Forward;
Function  WinNewUser(Var User:UserRec):Bool;Near;Forward;

Function ACPercentageUsed;Begin
 ACPercentageUsed:=aBufUsed/(aBufSize+1)
End;

Function UserFileName:String;Begin
 UserFileName:=BBSPath+'USERS.LST'
End;

Procedure TAInit;Begin
 FillClr(Q,SizeOf(Q));
 TMInit(Q,0,Y1,79,Y2,Com,PathPhoneList);
 PLInit(Q.Prot,0,4);
End;

Procedure TANew;Begin
 TAInit(Term(Q),Y1,Y2,CmdLnPort,PathPhoneList);
End;

Function TAHostCarrierDetect;Begin
 TAHostCarrierDetect:=True;
 If Not(Q.LocalHost)Then TAHostCarrierDetect:=ACCarrierDetect;
End;

Procedure TAWriteLog;Begin
{ If(Scr)Then TMPutTxtLn(Q,S);}
 WriteLog(S);
 TMBackService(Q,S);
End;

Function TAOpen4Append;Var OpenOk:Bool;Begin
 OpenOk:=FileExist(FNm);
 Assign(F,FNm);
 If(OpenOk)Then Append(F)Else ReWrite(F);
 Error:=IoResult; TAOpen4Append:=Error=0;
End;

Procedure TACreateXferListFile;Var FileEntry:SearchRec;SFileTime,SFileDate:String[8];Begin
 WEPutLastBar('Cr‚e la liste des fichiers t‚l‚chargeable...');
 If GetSysErr<>0Then Begin
  TAWriteLog(Q,'Impossible de cr‚‚ FILES.LST',No,True);
  TMLn(Q);
  Exit;
 End
  Else
 If Length(DownloadDir)=0Then Begin
  TAWriteLog(Q,'Cr‚e FILES.LST vide.',No,True);
  TMLn(Q);
  PutFileTxtLn(Handle,'Pas fichier disponible pour le "Download".');
  Exit;
 End;
 TAWriteLog(Q,'Cr‚e FILES.LST pour le r‚pertoire '+DownloadDir+'.',No,True);
 Q.NmFiles:=0;
 PutFileTxtLn(Handle,
  '==================== Fichiers pour "Downloader" ====================');
 FindFirst(DownloadDir+'*.*',fa,FileEntry);
 While SysErr=0do With(FileEntry)do Begin
  PutFileTxtLn(Handle,StrUSpc(Name,14)+Str2(Size,9)+' '+TimeToStr(FileEntry.Time));
  Inc(Q.NmFiles);
  FindNext(FileEntry);
 End;
End;

Procedure TAPresBBS(Var Q:Term);Begin
 WETypeFile(Q.W,BBSPath+'MALTEBBS.ANS');
 WEPutTxtLn(Q.W,CStrBasic(Q.NUsers));
 WEPutTxtLn(Q.W,'Nombre de message dans la boŒte aux lettres:'+CStrBasic(Q.NMsg));
 WEPutTxtLn(Q.W,'Nombre de fichier t‚l‚chargeable:'+CStrBasic(Q.NmFiles));
End;

Procedure TAInitHostMode;Var QErr,DoneFlag:Bool;UserFile:Wd;UserLine:String;I:Integer;
XferHandle:Hdl;UserList:UserRec;Begin
 WEPopWn(Q.SW);
 Q.HostModeFlag:=True;Q.Done:=No;Q.ReallyDone:=No;Q.FirstTime:=True;
 Q.UserFileSize:=0;Q.SaveReview:=Q.ReviewOn;Q.ReviewOn:=No;Log:=True;
 TMPutMode(Q,'BBS');
 TAWriteLog(Q,'D‚bute le mode BBS.',No,No);
 If Not FileExist(UserFileName)Then Begin
  TMLn(Q);
  TAWriteLog(Q,'Pas d''usager pr‚sent dans le fichier, assume l''usager en mode simple.',No,True);
  WinNewUser(UserList);
  SetFile(UserFileName,0,SizeOf(UserList),UserList);
  Q.NUsers:=1;
 End
  Else
 Begin
  Q.UserFileSize:=GetFileSize(UserFileName);
  Q.NUsers:=Q.UserFileSize div SizeOf(UserRec);
  If Q.NUsers=1Then TAWriteLog(Q,'Il y a 1 usager enregistr‚ dans le UserFile.',No,True)
	       Else TAWriteLog(Q,'Il y a'+BasicStrW(Q.NUsers)+' usagers enregistr‚s dans le UserFile.',No,True);
 End;
 Q.NMsg:=0;
 Assign(Q.MsgFile,'TERMINAL.MSG');
 Reset(Q.MsgFile);
 If IoResult<>0Then TAWriteLog(Q,'Pas de messages dans la BoŒte aux lettres.',No,True)
  Else
 Repeat
  ReadLn(Q.MsgFile,Q.MsgLn);
  If Systems.Left(Q.MsgLn,6)='== End'Then Inc(Q.NMsg);
 Until EOF(Q.MsgFile);
 If Q.NMsg>0Then TAWriteLog(Q,'Il y a'+BasicStrW(Q.NMsg)+' message(s) dans la boŒte aux lettres.',No,True);
 System.Close(Q.MsgFile);
 I:=IoResult;
 XFerHandle:=FileCreate(BBSPath+'FILES.LST');
 If(XFerHandle<>errHdl)Then Begin
  TACreateXferListFile(Q,XFerHandle);
  FileClose(XFerHandle)
 End;
 TAPresBBS(Q);
 WEPutLastBar('^ESC^ Sortir  ^F1^ Mode Chat  ^F2^ Log et sortir  ^F5^ Appelle  ^Enter^ Local');
End;

Procedure TAHostMode;Begin
 Q.HostModeFlag:=True;Q.SaveHParity:=Parity;Q.SaveHDataBits:=DataBits;
 Q.SaveHStopBits:=StopBits; Q.SaveHBaudRate:=BaudRate;
 TAInitHostMode(Q);
End;

Procedure TAPutXferCmd;Begin
 If Not(Q.ExpertOn)Then WETypeFile(Q.W,BBSPath+'MENUFILE.MSG')
  Else
 Begin
  TAHostSendStrLn(Q,'');
  TAHostSendStrNEcho(Q,'Xfer (U,D,');
  If Q.Privilege='S'Then TAHostSendStrNEcho(Q,'J,');
  TAHostSendStrNEcho(Q,'L,M,Q,X) ? ');
 End;
 If Not(Q.LocalHost)Then ACPurgeBuf;
End;

Procedure TAListFiles4Transfer;Begin
 TMPutStatus(Q,'Liste des fichiers');
 WESetPause(Q.W,True);
 WETypeFile(Q.W,BBSPath+'FILES.LST');
 WESetPause(Q.W,No);
 TAWriteLog(Q,'Liste des fichiers pour le transfŠre.',No,No);
 TMPutStatus(Q,Q.CurHostStatus);
End;

Procedure DBOpenModemProtocol;Near;Begin
 DBOpenServerName(ChantalServer,'CHANTAL:/Modem/Protocol.Dat');
End;

Procedure TAPutXferProtocols;
Var
 I:Byte;
 Data:Record
  ID:Byte;
  SingleFile:Boolean;
  TN:String[2];
  Name:String;
 End;
 S:String;
Begin
 TAHostSendStrLn(Q,'');
 TAHostSendStrLn(Q,'Les protocols de transfŠre disponible sont:');
 TAHostSendStrLn(Q,'');
 DBOpenModemProtocol;
 DBFirst(ChantalServer);
 While Not DBEOF(ChantalServer)do Begin
  DBReadRec(ChantalServer,Data);
  TAHostSendStrLn(Q,Spc(4)+Data.TN+SpcTab+Data.Name);
 End;
 TAHostSendStrLn(Q,'   Q ou ^X  Quitte le transfŠre');
End;

Function TAGetXferProtocol;
Var
 TransMode:String[30];
 TransProt,T:Byte;
 I:Integer;
 TransModeChar2:String[2];
 Data:DataProtocolRec;
Begin
 Repeat
  TAHostSendStrLn(Q,'');
  TAHostPromptNReadStr(Q,'Entrer le protocol de transfŠre (? pour la Liste, ^X pour Quitter): ',TransMode,True);
  TransModeChar2[1]:=' ';
  TransModeChar2[2]:=' ';
  TransMode:=StrUp(Trim(TransMode));
  For I:=1to Alpha(Length(TransMode),2)do TransModeChar2[I]:=TransMode[I];
  TransProt:=trsNone;
  If TransMode='?'Then TAPutXferProtocols(Q)else
  If Not(TransMode[1]in[^X,'Q'])Then Begin
   DBOpenModemProtocol;
   If DBLocateAbs(ChantalServer,2,TransMode,[soNoCaseSensitive])Then Begin
    DBReadRec(ChantalServer,Data);
    TransProt:=Data.ID;
   End;
  End;
 Until(TransProt<>trsNone)or(TransMode='Q')or(TransMode=^X);
 TAGetXferProtocol:=TransProt;
 If(TransProt=trsKermit)Then Q.Prot.KermitFileTypeVar:=KermitBinary;
End;

Procedure TAUploadAFile;
Var
 FileName,TransMode:String;
 TransferProtocol:Byte;
 OK2Upload,SaveAttended,SDone,SingleFP:Boolean;
Begin
 TransferProtocol:=TAGetXferProtocol(Q);
 If(TransferProtocol=trsNone)Then Exit;
 FileName:=''; SingleFP:=SingleFileProtocol[TransferProtocol]; OK2Upload:=True;
 If(SingleFP)Then Begin
  TAHostSendStrLn(Q,'');
  TAHostPromptNReadStr(Q,'Entrer le nom du fichier … recevoir: ',FileName,True);
  If(FileName='')or(Pos(^X,FileName)>0)Then Exit;
  If Not IsWildCard(FileName)Then Ok2Upload:=Not(FileExist(UploadDir+FileName))
   Else
  Begin
   Ok2Upload:=No;
   TAHostSendStrLn(Q,'');
   TAHostSendStr(Q,'Les g‚n‚riques (Wildcards) ne sont pas disponible pour ce protocole.');
   Exit;
  End;
 End;
 If Q.Privilege='S'Then Ok2Upload:=True;
 If(Ok2Upload)Then Begin
  FileName:=FileName;
  TAHostSendStrLn(Q,'');
  TAHostSendStrLn(Q,'Prˆte … recevoir, d‚butez votre proc‚dure d''envoie.');
  ACDrainOutBuf(5000);
  SaveAttended:=Q.AttendedMode; Q.AttendedMode:=No;
  TMPutStatus(Q,'R‚ception fichier');
  PLUpDownLoad(Q.Prot,TransferProtocol,'R');
  TMPutStatus(Q,Q.CurHostStatus);
  Q.AttendedMode:=SaveAttended;
 End
  Else
 Begin
  TAHostSendStrLn(Q,'');
  TAHostSendStrLn(Q,'Fichier d‚j… existant, "UpLoad" annul‚.');
  Ok2Upload:=No;
 End;
End;

Procedure TAGetTransferTime;
Var
 TotalFileSize,FileSize,TransferTime:LongInt;
 FileEntry:SearchRec;
 LastFound,OkFile:Boolean;
 SNFiles,SFileSize:String[8];
 InfoLine:String;
Begin
 TAHostSendStrLn(Q,'');
 TAHostSendStrLn(Q,'Recherche la liste de fichier...');
 TotalFileSize:=0; NFiles:=0;
 FileSpec:=DownloadDir+FileSpec;
 FindFirst(FileSpec,fa,FileEntry);
 LastFound:=SysErr<>0;
 While Not(LastFound)do With(FileEntry)do Begin
  OkFile:=True;
{   If(Privilege <> 'S')Then OkFile := (ScanXferList(Name) > 0);}
  If(OkFile)Then Begin
   Inc(NFiles);
   If NFiles=1Then Begin
    TAHostSendStrLn(Q,'Nom fichier   Taille     Temps Tran.');
    TAHostSendStrLn(Q,'ÍÍÍÍÍÍÍÍÍÍÍÍ  ÍÍÍÍÍÍÍÍ   ÍÍÍÍÍÍÍÍÍÍÍ');
   End;
   Inc(TotalFileSize,Size); SFileSize:=Str2(Size,8);
   TransferTime:=Round(Round((Size/128.0)+0.49)*(TransTimeVal*1.0)/(BaudRate*1.0));
   InfoLine:=StrUSpc(Name,14)+SFileSize+'     '+TimeString(TransferTime,Military);
   TAHostSendStrLn(Q,InfoLine);
  End;
  FindNext(FileEntry);
  LastFound:=(LastFound)or(SysErr<>0);
 End;
 TransferTimeMsg:='Temps approximatif de transfŠre pour ';
 If NFiles<=1Then AddStr(TransferTimeMsg,'1 fichier est ')
	     Else AddStr(TransferTimeMsg,IntToStr(NFiles)+' fichiers est ');
 AddStr(TransferTimeMsg,TimeString(Round((TotalFileSize/128.0)+0.49)*
	Round((TransTimeVal*1.0)/BaudRate),Military));
End;

Procedure TADownloadAFile;
Var
 FN,TransMode:String;
 TransProt:Byte;
 NFiles:Integer;
 SaveWait,SDone:Boolean;
Begin
 TransProt:=TAGetXferProtocol(Q);
 If(TransProt=trsNone)Then Exit;
 TAHostSendStr(Q,Q.CRLFHost);
 TAHostPromptNReadStr(Q,'Entrer le nom du fichier … "download": ',FN,True);
 If(FN='')or(Pos(^X,FN)>0)Then Exit;
 If Q.Privilege<>'S'Then If Pos('\',FN)or Pos(':',FN)<>0Then Begin
  TAHostSendStr(Q,Q.CRLFHost);
  TAHostSendStr(Q,'Cette sp‚cification de fichier est invalide.');
  Exit;
 End;
 If Not IsWildCard(FN)Then If SingleFileProtocol[TransProt]Then Begin
  TAHostSendStr(Q,Q.CRLFHost);
  TAHostSendStr(Q,'Les caractŠres g‚n‚rique ne sont pas disponible avec ce protocole.');
  Exit
 End;
 TAGetTransferTime(Q,FN,NFiles,TransMode);
 If NFiles<=0Then Begin
  TAHostSendStrLn(Q,'');
  TAHostSendStrLn(Q,'Aucun fichiers trouv‚ … envoyer, transfŠre annul‚.');
  Exit;
 End;
 Q.Prot.XFileName:=FN;
 TAHostSendStrLn(Q,'');
 TAHostSendStrLn(Q,TransMode);
 TAHostSendStrLn(Q,'Prˆte … envoyer, pr‚parez votre proc‚dure de r‚ception.');
 ACDrainOutBuf(5000);
 SaveWait:=Q.AttendedMode; Q.AttendedMode:=No;
 TMPutStatus(Q,'Envoie du fichier en cours');
 PLUpDownLoad(Q.Prot,TransProt,'S');
 TMPutStatus(Q,Q.CurHostStatus);
 Q.AttendedMode:=SaveWait;
End;

Function TAProcessFileTransferCmd;
Label ReadChar;
Var
 FoundCh,DontEcho,KbdInput:Boolean;
 K:Word;
 Ch:Char Absolute K;
Begin
 TAProcessFileTransferCmd:=kbNoKey;Q.CurHostStatus:='Section fichier';
 TMPutStatus(Q,Q.CurHostStatus);
 Back:=No;
 TAPutXferCmd(Q);
ReadChar:
 KbdInput:=No;
 Repeat
  FoundCh:=ACReceive(Ch)or(KeyPress);
  If TAHostCarrierDetect(Q)Then Begin
   Done:=True;
   Break;
  End;
 Until(Done)or FoundCh;
 DontEcho:=No;
 If(KeyPress)Then Begin
  K:=ReadKey;Ch:=Char(K);KbdInput:=True;
  If(K=kbEsc)and(KeyPress)Then Begin
   DontEcho:=True;K:=ReadKey;
   Case K of
    kbF1: Ch:='G';
    kbF2: Ch:='Q';
    kbF3: Begin
	    {DosJump('');}
	    Ch:=' ';
	   End;
    kbF5: Begin
	   TMPutTxtLn(Q,'');
	   TMPutTxtLn(Q,'Appeleur courant est '+Q.CurUserName);
	   Ch:=' ';
	   End;
     Else Begin
	   TAProcessFileTransferCmd:=K;
	   Exit;
	  End;
   End;
  End;
 End;
 If Ch=' 'Then Goto ReadChar;
 If Not(Done)Then If Not(DontEcho)Then Begin
  TMBackService(Q,Ch+Q.CRLFHost);
  TAHostSendStr(Q,Ch+Q.CRLFHost);
 End;
 Case UpCase(Ch)of
  'U':TAUploadAFile(Q);
  'D':TADownloadAFile(Q);
  'Q':Begin
   If(KbdInput)Then Begin
    TAHostSendStrLn(Q,'Op‚rateur systŠme termine le systŠme.');
    TAHostSendStrLn(Q,'Merci d''avoir appell‚.');
   End
    Else
   TAHostSendStrLn(Q,'Quitte & d‚connexion');
   Done:=True;
  End;
  'L':TAListFiles4Transfer(Q);
  'X':Q.ExpertOn:=Not(Q.ExpertOn);
  'M':Begin
   Back:=True;
   Q.HostSection:='M';
  End;
  'G':If(KbdInput)Then Begin
   TAHostSendStrLn(Q,'...demande … l''op‚rateur SystŠme de rentrer en dialogue, S.V.P. attendre...');
   TAHostSendStrLn(Q,'');
   Back:=True; Q.LastHostSect:='F'; Q.HostSection:='G';
  End;
  'J':If Q.Privilege='S'Then Begin
   Q.HostSection:='D'; Q.LastHostSect:='F'; Back:=True;
  End
   Else
  TAHostSendStr(Q,^G);
  'Z': {If(KbdInput)Then DosJump('');}
  Else TAHostSendStr(Q,^G);
 End;
End;

Procedure TAHostBaudDetect;
Const
 WaitChTime=10;
 NOfHostBaudRates=5;
 HostBaudRates:Array[1..NOfHostBaudRates]of Wd=(2400,1200,9600,19200,300);
Var
 FoundSpeed:Bool;
 IBaud:Integer;

 Function TryBaudRate(TestBaudRate:Word):Boolean;
 Var
  StrippedCh,Ch:Integer;
  TimedOut:Boolean;
 Begin
  TryBaudRate:=No; BaudRate:=TestBaudRate;
  ACResetPort(CommPort,BaudRate,Parity,DataBits,StopBits);
  ACReceiveWithTimeOut(WaitChTime,Ch);
  TimedOut:=Ch=TimeOut;
  ACClrErrs;
  StrippedCh:=Ch and$7F;
  If Not(TimedOut)Then If StrippedCh in[caCR,caSP]Then Begin
   TryBaudRate:=True;
   If(StrippedCh<>Ch)Then Begin
    DataBits:=7;
    If Parity='N'Then Parity:='E'Else Begin Parity:='N';Inc(DataBits)End;
    ACResetPort(CommPort,BaudRate,Parity,DataBits,StopBits);
   End;
  End;
 End;

Begin
 FoundSpeed:=No;
 Delay(20000);
 ACPurgeBuf;
 While Not(FoundSpeed)and(ACCarrierDetect)do Begin
  IBaud:=0;
  Repeat
   Inc(IBaud);Parity:='N';DataBits:=8;FoundSpeed:=TryBaudRate(HostBaudRates[IBaud]);
  Until (FoundSpeed)or(IBaud>=NOfHostBaudRates);
  If(FoundSpeed)Then FoundSpeed:=TryBaudRate(HostBaudRates[IBaud]);
  If Not(FoundSpeed)Then Begin Delay(5);ACPurgeBuf;End;
 End;
 Delay(20000);
 ACPurgeBuf;
 TMPutTxtLn(Q,'Communications ajust‚ …'+BasicStrW(BaudRate)+' baud et Parit‚ = '+Parity);
End;

Procedure TAHostAutoBaudDetect;
Var
 NewBaud:Wd;
 I,J:Integer;
 MdmConnect:String;
Begin
 MdmConnect:=StrPas(ModemConnect);NewBaud:=0;J:=Pos(MdmConnect,ModemAns)+Length(MdmConnect);
 For I:=J to Length(ModemAns)do
 If ModemAns[I]in['0'..'9']Then NewBaud:=NewBaud*10+Byte(ModemAns[I])-Byte('0');
 If NewBaud=0Then NewBaud:=300;
 If NewBaud>0Then Begin
  BaudRate:=NewBaud;
  ACResetPort(CommPort,BaudRate,Parity,DataBits,StopBits);
  TMPutTxtLn(Q,'Communications ajust‚ …'+BasicStrW(BaudRate)+' baud.');
 End;
End;

{Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure attend que le t‚l‚phone sonne.
}

Procedure TAWait4Ring;
Const
 HardWired=No;
 HostAutoBaud=True;
Var
 Qerr,MTimeOut,Blanked:Boolean;
 ModemAns:String;
 Ch:Char;
 IntCh,I,J:Integer;
 K:Word;
Begin
 Parity:='N';DataBits:=8;StopBits:=1;BaudRate:=Q.SaveHBaudRate;
 ACResetPort(CommPort,BaudRate,Parity,DataBits,StopBits);
 If Not(HardWired)Then SendModemCmd(StrPas(ModemHostSet));
 ACDrainOutBuf(5000);
 ACPurgeBuf;
 TMPutStatus(Q,'Mise en attente d''un appelle t‚l‚phonique...');
 ModemAns:=''; Q.LocalHost:=No;
 ACTermReady(True);
 If(ACCarrierDetect)Then Exit;
 Done:=No;
 Q.W.Y:=12;
 WEPutTxtLn(Q.W,'Attend que le t‚l‚phone sonne.');
 WEPutTxtLn(Q.W,'[ESC] Retourner au terminal.');
 WEPutTxtLn(Q.W,' [F1] D‚bute/Arrˆte le ChatMode.');
 WEPutTxtLn(Q.W,' [F2] Fermer immediatement aprŠs que l''usager est appell‚.');
 WEPutTxtLn(Q.W,' [F5] Donne le nom de l''appeleur courant.');
 WEPutTxtLn(Q.W,'Presse n''importe quel autre touche pour d‚buter un Host Local.');
 ACPurgeBuf;
 Q.BlankTime:=TimeOfDay; Blanked:=No;
 _InitKbd;
 Repeat
  _BackKbd;
  If(KeyPress)Then Begin
   K:=ReadKey;
   Case K of
   kbEsc:Begin
    Done:=True;
    Q.ReallyDone:=True;
   End;
   Else Begin
    Q.LocalHost:=True;
    TMPutTxtLn(Q,'D‚bute une session local de Host... ');
    ACTermReady(No);
   End;
   End;
   Exit;
  End;
 Until TAHostCarrierDetect(Q);
 TMPutTxtLn(Q,'Le t‚l‚phone sonne... ');
 TMPutStatus(Q,'R‚pond au t‚l‚phone');
 Delay(1000);
 MTimeOut:=No;
 Repeat
  ACReceiveWithTimeOut(1,IntCh);
  If(IntCh<>TimeOut)Then Begin
   Ch:=Char(IntCh);
   If Ch in['A'..'Z',' ','0'..'9']Then IncStr(ModemAns,Ch);
   TMPutTxt(Q,Ch);
   TMBackService(Q,Ch);
  End
   Else
  MTimeOut:=True;
 Until(MTimeOut)or(Done);
 If Not(Done)Then If Not(HardWired)Then
  If(HostAutoBaud)Then TAHostAutoBaudDetect(Q,ModemAns)Else TAHostBaudDetect(Q);
 Done:=Done or Not(TAHostCarrierDetect(Q));
End;

Procedure TAResetThePort;Begin
 Q.NewBaud:=150;
 If BaudRate<>300Then Q.NewBaud:=300;
 ACResetPort(CommPort,Q.NewBaud,Parity,DataBits,StopBits);
 TMPutStatus(Q,Q.CurHostStatus);
End;

{Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure raccroche le t‚l‚phone. Si vous pr‚f‚rer, arrˆte
 d‚lib‚rement la communication par modem par la voie du t‚l‚phone.
}

Procedure TAHangUpPhone;
Var
 OpenFlag,SaveXonXoff,SaveXonOV:Boolean;
 W:Window;
Begin
 WEPushEndBar(W);
 WEPutLastBar('Raccrochage de la communication t‚l‚phonique en cours...');
 SaveXonXoff:=AsyncDoXonXoff;AsyncDoXonXoff:=No;SaveXonOV:=AsyncOVXonXoff;AsyncOVXonXoff:=No;
 If(aXoffReceived)Then ClrXoffReceived;
 ACClose(True);
 Delay(1000);
 OpenFlag:=ACOpen(CommPort,BaudRate,Parity,DataBits,StopBits);
 If(ACCarrierDetect)Then Begin
  _Delay(ModemEscTime);SendModemCmd(StrPas(ModemEsc));
  _Delay(ModemEscTime);SendModemCmd(StrPas(ModemHangUp));
  _Delay(ModemEscTime);
 End;
 ACPurgeBuf;
 AsyncDoXonXoff:=SaveXonXoff;AsyncOVXonXoff:=SaveXonOV;
 WEDone(W);
End;

Procedure TADoneHostMode;Const HardWired=No;Var SaveBaud:Wd;Local:Bool;Begin
 If Not(Q.HostModeFlag)Then Exit;
 Q.CurHostStatus:='Fin de la session Host';
 ACDrainOutBuf(1000);
 If Not(HardWired)Then Begin
  TAResetThePort(Q);SaveBaud:=Q.NewBaud;BaudRate:=Q.NewBaud;
  TAHangUpPhone(Q);SendModemCmd(StrPas(ModemHostUnSet));
  ACDrainOutBuf(5000);BaudRate:=SaveBaud;
  ACResetPort(CommPort,BaudRate,Parity,DataBits,StopBits);
  ACPurgeBuf;
 End;
 Local:=Q.LocalHost;Q.LocalHost:=ACCarrierDrop;
 TMLn(Q);
 TMPutTxtLn(Q,'Session Host termin‚.');
 Q.LocalHost:=Local;
 If(HardWired)Then
  Q.ReallyDone:=Q.ReallyDone or(WarningMsgYesNo('Retourne … l''‚mulateur de terminal ?')=kbYes);
End;

Procedure TAHostSendStr;Begin
{ If Not(Q.LocalHost)Then ACSendStr(S);}
 TMPutTxt(Q,S);
 TMBackService(Q,S);
End;

Procedure TAHostSendStrLn;Begin
{ If Not(Q.LocalHost)Then ACSendStr(S+Q.CRLFHost);}
 TMPutTxtLn(Q,S);
 TMBackService(Q,S+CRLF);
End;

Procedure TAHostSendStrNEcho;Begin
 If Not(Q.LocalHost)Then ACSendStr(S);
 TMPutTxt(Q,S);
 TMBackService(Q,S);
End;

Procedure TAHostSend;Begin
 If Not(Q.LocalHost)Then ACSend(C);
 TMPutTxt(Q,C);
End;

Procedure TAListPrompt;Var ListChar:Chr;FoundChar:Bool;Begin
 Inc(ListCount);
 If(ListCount>Q.PageSize)Then Begin
  Repeat
   TAHostSendStrNEcho(Q,'<Enter> pour continuer, S pour arrˆter, <C>ontinue sans arrˆt: ');
   Repeat
    FoundChar:=ACReceive(ListChar)or(KeyPress);
   Until(FoundChar)or Not TAHostCarrierDetect(Q);
   If(KeyPress)Then ListChar:=Char(ReadKey);
   If ListChar=Char(caCR)Then ListChar:=' ';
   TAHostSendStrLn(Q,ListChar);
   TMBackService(Q,ListChar+Q.CRLFHost);
   ListChar:=ChrUp(ListChar);
  Until(ListChar in['S','C',' '])or Not(TAHostCarrierDetect(Q));
  Case ListChar of
   'C': ListCount:=-MaxInt;
   'S': ListDone:=True;
   ' ': ListCount:=1;
  End;
 End;
End;

Procedure TAEndPrompt;Var ListChar:Char;Begin
 TAHostSendStrLn(Q,'');
 TAHostSendStrNEcho(Q,Mess);
 Repeat Until(ACReceive(ListChar)or(KeyPress))or Not(TAHostCarrierDetect(Q));
 If(KeyPress)Then ListChar:=Char(ReadKey);
 If ListChar=Char(caCR)Then ListChar:=' ';
 TAHostSendStrLn(Q,ListChar);
 TMBackService(Q,ListChar+Q.CRLFHost);
End;

Procedure TAHostPromptNReadStr;Var Ch,RemCh:Char;GotChar:Bool;K:Wd;Begin
 If Length(Prompt)>0Then TAHostSendStrNEcho(Q,Prompt);
 Ch:=#0; S:=''; K:=TMInput(Q,S);
{  If(ACReceive(RemCh))Then}
 If(K=kbCtrlX)Then Begin S:=^X;TAHostSendStrNEcho(Q,' *** Annul‚');TMLn(Q)End
 Else If TAHostCarrierDetect(Q)Then Begin TMLn(Q);TMBackService(Q,S)End;
End;

Procedure TAGetUserInfo;Var MyPass,CallLine,FName,LName,PassWd:String;UserFile:Hdl;I:Long;User:UserRec;Begin
 TMPutStatus(Q,'Demande des informations sur un utilisateur');
 TAHostSendStrLn(Q,'');
 TAHostPromptNReadStr(Q,'Entrez le pr‚nom: ',Q.Fname,True);
 Q.Fname:=Trim(StrUp(Q.Fname));
 TAHostSendStrLn(Q,' ');
 TAHostPromptNReadStr(Q,'Entrez le nom de famille: ',Q.Lname,True);
 Q.Lname:=Trim(StrUp(Q.Lname));Q.CurUser:=0;Found:=No;Q.Privilege:='N';Q.CurUserName:='';
 UserFile:=FileOpen(UserFileName,fmRead);
 For I:=0to Q.NUsers do Begin
  GetRec(UserFile,I,SizeOf(UserRec),User);
  FName:=RTrim(LoadStr(User.FirstName,SizeOf(User.FirstName)));
  LName:=RTrim(LoadStr(User.LastName,SizeOf(User.LastName)));
  PassWd:=RTrim(LoadStr(User.PassWd,SizeOf(User.PassWd)));
  Found:=(StrUp(Q.Fname)=StrUp(FName))and(StrUp(Q.Lname)=StrUp(LName));
  If(Found)Then Break;
 End;
 Q.CurUser:=I;
 FileClose(UserFile);
 Q.CurUserName:=Q.Fname+' '+Q.Lname;
 If Not(Found)Then Begin
  TAHostSendStrLn(Q,'');
  TAHostSendStrLn(Q,'Usager invalide.');
 End;
 If(Found)and(TAHostCarrierDetect(Q))Then Begin
  TAHostSendStrLn(Q,'');
  TAHostPromptNReadStr(Q,'Entrez le mots de passe: ',MyPass,No);
  TAHostSendStrLn(Q,'');
  If(StrUp(MyPass)=StrUp(PassWd))Then Begin
   TAHostSendStrLn(Q,'Mots de passe correcte.');
   Found:=True;
   TAWriteLog(Q,Q.Fname+' '+Q.Lname+' connect‚.',No,No);
   Q.Privilege:=Chr(Byte(User.Level[0]='2')*Byte(Q.Privilege));
  End
   Else
  Begin
   TAHostSendStrLn(Q,'Mots de passe incorrecte');
   Found:=No;
   TAWriteLog(Q,Q.Fname+' '+Q.Lname+' connect‚ avec un mauvais mots de passe = '+MyPass,No,No);
  End;
 End;
 If(Found)Then Begin Q.CurHostStatus:=Q.CurUserName;TMPutStatus(Q,Q.CurHostStatus)End;
End;

Procedure TAPutHostCmd;Begin
 If Not(Q.ExpertOn)Then WETypeFile(Q.W,BBSPath+'MENUPRIN.MSG')
  Else
 Begin
  TAHostSendStrLn(Q,'');
  If Q.Privilege='S'Then TAHostSendStrNEcho(Q,'Principal (E,R,S,P,Q,F,G,X,C,W,J) ? ')
		    Else TAHostSendStrNEcho(Q,'Principal (E,R,S,P,Q,F,G,X,C,W) ? ');
 End;
 If Not(Q.LocalHost)Then ACPurgeBuf;
End;

Procedure TAPageSysop;
Const
 SilentMode=No;
Var
 Timer:LongInt;
 I:Integer;
 Ch:Char;
 K:Wd;
Begin
 TAWriteLog(Q,'Page SYSOP.',No,No);
 TMPutStatus(Q,'Page SYSOP');
 TAHostSendStrLn(Q,'');
 SysopFound:=No;
 If Not(SilentMode)Then Begin
  TAHostSendStrLn(Q,'Attend aprŠs le Sysop (^X cancels)...');
  Timer:=30;
  Repeat
   Beep; Beep; Beep; Beep; Beep; Beep;
   If ACReceive(Ch)Then If(Ch=^X)Then Timer:=0;
   If(KeyPress)Then Begin
    K:=ReadKey;
    Case K of
   kbEsc:;
 kbCtrlX: SysopFound:=True;
     Else Timer:=0;
    End;
   End;
   Delay(1000);
   Dec(Timer);
  Until(Timer<=0)or(SysopFound);
 End
  Else
 TAHostSendStrLn(Q,'Sysop non disponible, gossip annul‚.');
 TMPutStatus(Q,Q.CurHostStatus);
End;

Procedure TAPutWelcomeMsg;Begin
 If WETypeFile(Q.W,BBSPath+'WELCOME.MSG')Then
  TAEndPrompt(Q,'Fin de bienvenue, presse <ENTER> pour continuer...');
End;

Function TAProcessHostCmd;Label ReadChar;Var Back,FoundCh,SysopFound,KbdInput:Bool;Ch:Char;K:Wd;

 Procedure GetAMsg(Var F:Text);Begin
  WriteLn(F,'== De:    ',Q.Fname,' ',Q.Lname);
  WriteLn(F,'== A:     ',Q.RecipientName);
  WriteLn(F,'== Date:  ',TimeToStr(TimeOfDay));
  WriteLn(F,'== Sujet: ',Q.MsgSubject);
  TAHostSendStr(Q,Q.CRLFHost);
  TAHostSendStrLn(Q,'Entrer un message.   Ligne vide termines.');
  Repeat
   TAHostSendStr(Q,Q.CRLFHost);
   TAHostPromptNReadStr(Q,'> ',Q.MsgLn,True);
   If Length(Q.MsgLn)>0Then WriteLn(F,' ',Q.MsgLn);
  Until Length(Q.MsgLn)=0;
  WriteLn(F,'== End');
  TAHostSendStr(Q,Q.CRLFHost);
  TAHostSendStrLn(Q,'Message entrer.');
 End;

 Procedure EnterMsg;
 Label Sor;
 Var
  Quit:Boolean;
  Ierr:Integer;
 Begin
  TMPutStatus(Q,'Entrer un message');
  Quit:=No;
  Assign(Q.MsgFile,'TERMINAL.MSG');
  Reset(Q.MsgFile);
  If IoResult<>0Then Begin
   TMPutTxtLn(Q,'Cr‚ation du fichier message TERMINAL.MSG');
   ReWrite(Q.MsgFile);
   If IoResult<>0Then Goto Sor;
  End
   Else
  Begin
   System.Close(Q.MsgFile);
   Q.HostIoError:=IoResult;
   If Not(TAOpen4Append(Q,Q.MsgFile,'TERMINAL.MSG',Ierr))Then Begin
    TAHostSendStr(Q,Q.CRLFHost);
Sor:TAHostSendStrLn(Q,'D‚sol‚, pas assez de place pour tes messages');
    Quit:=True;
   End;
  End;
  TAHostSendStr(Q,Q.CRLFHost);
  TAHostPromptNReadStr(Q,'Entrer le destinataire name ou ALL pour tous: ',Q.RecipientName,True);
  Q.RecipientName:=StrUp(Trim(Q.RecipientName));
  If Q.RecipientName=''Then Q.RecipientName:='ALL';
  TAHostSendStr(Q,Q.CRLFHost);
  TAHostPromptNReadStr(Q,'Entrez le titre du message: ',Q.MsgSubject,True);
  If Not(Quit)Then GetAMsg(Q.MsgFile);
  System.Close(Q.MsgFile);
  Q.HostIOError:=IoResult;
  Inc(Q.NMsg);
  TAWriteLog(Q,'Entrer un message.',No,No);
  TMPutStatus(Q,Q.CurHostStatus);
 End;

 Procedure Skip2Msg(MsgNo:Integer);
 Var
  MsgCount:Integer;
 Begin
  MsgCount:=0;
  Repeat
   ReadLn(Q.MsgFile,Q.MsgLn);
   If Systems.Left(Q.MsgLn,6)='== End'Then Inc(MsgCount);
  Until MsgCount=MsgNo-1;
 End;

 Procedure ReadMsg;
 Label ReadingDone;
 Var
  MsgNo,StartMsg,I,LineCount:Integer;
  ReadDone,OkNumber:Bool;
  StartMStr:String;
  CMsgNo:String[5];
 Begin
  TMPutStatus(Q,'V‚rification du courrier de la boŒte aux lettres...');
  Assign(Q.MsgFile,'TERMINAL.MSG');
  Reset(Q.MsgFile);
  If IoResult<>0Then Begin
   TAHostSendStr(Q,Q.CRLFHost);
   TAHostSendStrLn(Q,'Pas de messages dans la boŒte aux lettres.');
   Exit;
  End;
  Repeat
   OKNumber:=True;
   TAHostSendStrLn(Q,'');
   StartMStr:='Il y a'+BasicStr(Q.NMsg)+' message';
   If Q.NMsg>1Then IncStr(StartMStr,'s');
   AddStr(StartMStr,' dans la boŒte aux lettres.');
   TAHostSendStrLn(Q,StartMStr);
   TAHostPromptNReadStr(Q,'Entrez le point d''entr‚e du courrier ou <Enter> pour tous: ',StartMStr,True);
   StartMsg:=StrToInt(StartMStr);
   If StartMsg=0Then StartMsg:=1;
   If(StartMsg>Q.NMsg)Then StartMsg:=Q.NMsg;
  Until Not(TAHostCarrierDetect(Q))or(OKNumber);
  If Not(TAHostCarrierDetect(Q))Then Goto ReadingDone;
  Skip2Msg(StartMsg);
  MsgNo:=Pred(StartMsg);ReadDone:=No;LineCount:=0;
  Repeat
   Inc(MsgNo);CMsgNo:=Str0(MsgNo,5);
   TAHostSendStr(Q,Q.CRLFHost);
   TAListPrompt(Q,LineCount,ReadDone);
   If(ReadDone)Then Goto ReadingDone;
   TAHostSendStrLn(Q,'Message #'+CMsgNo);
   TAListPrompt(Q,LineCount,ReadDone);
   If(ReadDone)Then Goto ReadingDone;
   For I:=1to 5do Begin
    ReadLn(Q.MsgFile,Q.MsgLn);
    Q.MsgLn:=Copy(Q.MsgLn,4,Length(Q.MsgLn)-3);
    TAHostSendStrLn(Q,Q.MsgLn);
    TAListPrompt(Q,LineCount,ReadDone);
    If(ReadDone)Then Goto ReadingDone;
   End;
   TAHostSendStrLn(Q,'');
   TAListPrompt(Q,LineCount,ReadDone);
   If(ReadDone)Then Goto ReadingDone;
   Repeat
    ReadLn(Q.MsgFile,Q.MsgLn);
    If Left(Q.MsgLn,6)<>'== End'Then Begin
     TAHostSendStrLn(Q,Copy(Q.MsgLn,2,Pred(Length(Q.MsgLn))));
     TAListPrompt(Q,LineCount,ReadDone);
    End;
   Until(Left(Q.MsgLn,6)='== End')or(ReadDone);
  Until(MsgNo>=Q.NMsg)or ReadDone;
ReadingDone:
  TAHostSendStrLn(Q,'');
  TAHostPromptNReadStr(Q,'Fin de la lecture de la messagerie, presse <Enter> pour continuer: ',StartMStr,True);
  TAHostSendStrLn(Q,'');
  System.Close(Q.MsgFile);
  Q.HostIOError:=IoResult;
  TAWriteLog(Q,'Lecture des messages.',No,No);
  TMPutStatus(Q,Q.CurHostStatus);
 End;

 Procedure ScanMsg(PersonalOnly:Bool);Label ScanningDone;
 Var
  MsgNo,I,LineCount,StartMsg,MsgCount:Integer;
  ScanDone,OKNumber:Bool;
  StartMStr,MsgL1,MsgL2,MsgTitle:String;
  CMsgNo:String[5];
 Begin
  TMPutStatus(Q,'Recherche des messages');
  Assign(Q.MsgFile,'TERMINAL.MSG');
  Reset(Q.MsgFile);
  If IoResult<>0Then Begin
   TAHostSendStr(Q,Q.CRLFHost);
   TAHostSendStrLn(Q,'Pas de messages dans la boŒte aux lettres.');
   Goto ScanningDone;
  End;
  StartMsg:=1;
  If Not(PersonalOnly)Then Repeat
   OKNumber:=True;
   TAHostSendStrLn(Q,'');
   StartMStr:='Il y a'+BasicStr(Q.NMsg)+' message';
   If Q.NMsg>1Then IncStr(StartMStr,'s');
   AddStr(StartMStr,' dans la boŒte aux lettres.');
   TAHostSendStrLn(Q,StartMStr);
   TAHostPromptNReadStr(Q,'Entrez le point d''entr‚e du courrier ou <Enter> pour tous: ',StartMStr,True);
   StartMsg:=StrToInt(StartMStr);
   If StartMsg=0Then StartMsg:=1;
   If(StartMsg>Q.NMsg)Then StartMsg:=Q.NMsg;
  Until Not(TAHostCarrierDetect(Q))or(OKNumber);
  If Not(TAHostCarrierDetect(Q))Then Goto ScanningDone;
  Skip2Msg(StartMsg);
  MsgNo:=Pred(StartMsg);LineCount:=0;ScanDone:=No;MsgCount:=0;
  Repeat
   Inc(MsgNo);
   ReadLn(Q.MsgFile,MsgL1);
   ReadLn(Q.MsgFile,MsgL2);
   If(Copy(MsgL2,13,Length(MsgL2)-12)=StrUp(Q.CurUserName))or(Not(PersonalOnly))Then Begin
    Inc(MsgCount);
    System.Str(MsgNo:5,CMsgNo);
    TAHostSendStr(Q,Q.CRLFHost);
    TAListPrompt(Q,LineCount,ScanDone);
    If(ScanDone)Then Goto ScanningDone;
    TAHostSendStrLn(Q,'Message #'+CMsgNo);
    TAListPrompt(Q,LineCount,ScanDone);
    If(ScanDone)Then Goto ScanningDone;
    TAHostSendStrLn(Q,Copy(MsgL1,4,Length(MsgL1)-3));
    TAListPrompt(Q,LineCount,ScanDone);
    If(ScanDone)Then Goto ScanningDone;
    TAHostSendStrLn(Q,Copy(MsgL2,4,Length(MsgL2)-3));
    TAListPrompt(Q,LineCount,ScanDone);
    If(ScanDone)Then Goto ScanningDone;
    For I:=3to 5do Begin
     ReadLn(Q.MsgFile,Q.MsgLn);
     Q.MsgLn:=Copy(Q.MsgLn,4,Length(Q.MsgLn)-3);
     TAHostSendStrLn(Q,Q.MsgLn);
     TAListPrompt(Q,LineCount,ScanDone);
     If(ScanDone)Then Goto ScanningDone;
    End;
    TAHostSendStrLn(Q,'');
    TAListPrompt(Q,LineCount,ScanDone);
   End;
   If Not(ScanDone)Then
   Repeat ReadLn(Q.MsgFile,Q.MsgLn)Until Systems.Left(Q.MsgLn,6)='== End';
  Until(MsgNo>=Q.NMsg)or(ScanDone);
ScanningDone:
  System.Close(Q.MsgFile);
  Q.HostIOError:=IoResult;
  If(PersonalOnly)Then If MsgCount=0Then Begin
   TAHostSendStrLn(Q,'');
   TAHostSendStrLn(Q,'Vous n''avez pas de courrier personnellement.');
  End;
  TAHostSendStrLn(Q,'');
  TAHostPromptNReadStr(Q,'Fin de recherche des messages, presse <Enter> pour continuer: ',StartMStr,True);
  TAHostSendStrLn(Q,'');
  TAWriteLog(Q,'Recherche des messages.',No,No);
  TMPutStatus(Q,Q.CurHostStatus);
 End;

 Procedure EnterComment;
 Var
  Quit:Boolean;
  Ierr:Integer;
  CommentsFile:Text;
 Begin
  TMPutStatus(Q,'Entrer commentaire');
  Quit:=No;
  Assign(CommentsFile,'TERMINAL.CMT');
  Reset(CommentsFile);
  If IoResult<>0Then Begin
   TMPutTxtLn(Q,'Cr‚ation du fichier de commentaires TERMINAL.CMT');
   ReWrite(CommentsFile);
   If IoResult<>0Then Begin
    TAHostSendStrLn(Q,'');
    TAHostSendStrLn(Q,'D‚sol‚, impossible d''accepter votre commentaire maintenant.');
    Quit:=True;
   End;
  End
   Else
  Begin
   System.Close(CommentsFile);
   Q.HostIOError:=IoResult;
   If Not TAOpen4Append(Q,CommentsFile,'TERMINAL.CMT',Ierr)Then Begin
    TAHostSendStrLn(Q,'');
    TAHostSendStrLn(Q,'D‚sol‚, impossible d''accepter votre commentaire maintenant.');
    Quit:=True;
   End;
  End;
  Q.RecipientName:='SYSOP'; Q.MsgSubject:=' ';
  If Not(Quit)Then GetAMsg(CommentsFile);
  System.Close(CommentsFile);
  Q.HostIOError:=IoResult;
  TAWriteLog(Q,'Entrer un commentaire au SYSOP.',No,No);
  TMPutStatus(Q,Q.CurHostStatus);
 End;

Begin
 TAProcessHostCmd:=kbNoKey;
 If Q.HostSection='I'Then Begin
  TAPutWelcomeMsg(Q);
  TAHostSendStrLn(Q,'');
  TAHostSendStrLn(Q,'');
  TAHostSendStrLn(Q,'Recherche pour des messages personnel...');
  ScanMsg(True);
  Q.HostSection:='M';
 End;
 Q.CurHostStatus:='Courrier';
 TMPutStatus(Q,Q.CurHostStatus);
 TAPutHostCmd(Q);
ReadChar:
 KbdInput:=No;
 _InitKbd;
 Repeat
  _BackKbd;
  Done:=Done or Not(TAHostCarrierDetect(Q));
  FoundCh:=ACReceive(Ch)or(KeyPress);
 Until(Done)or(FoundCh);
 If(KeyPress)Then Begin
  _BackKbd;
  K:=ReadKey; Ch:=Char(K); KbdInput:=True;
  If(K=kbEsc)and(Keypress)Then Begin
   K:=ReadKey; Ch:=Char(K);
   Case K of
   kbF1: Ch:='G';
   kbF2: Ch:='Q';
   kbF3: Begin
{          DosJump('');}
	  Ch:= ' ';
	 End;
   kbF5: Begin
	  TMPutTxtLn(Q,'');
	  TMPutTxtLn(Q,'Appelleur courant est '+Q.CurUserName);
	  Ch:=' ';
	 End;
    Else If Ch=#0Then Begin TAProcessHostCmd:=K;Exit;End;
   End;
  End
   Else
  If Ch=#0Then Begin TAProcessHostCmd:=K;Exit;End;
 End;
 If Ch=' 'Then Goto ReadChar;
 If Not(Done)Then TAHostSendStrLn(Q,Ch);
 TMLn(Q);
 TMBackService(Q,Ch+Q.CRLFHost);
 Case UpCase(Ch)Of
  'E': EnterMsg;
  'R': ReadMsg;
  'Q': Begin
	If(KbdInput)Then Begin
	 TAHostSendStrLn(Q,'Op‚rateur SystŠme vous sort du systŠme.');
	 TAHostSendStrLn(Q,'Merci d''avoir appell‚.');
	End
	 Else
	TAHostSendStrLn(Q,'Quitte & d‚connecte');
	Done:=True;
       End;
  'F': Q.HostSection:='F';
  'G':If(KbdInput)Then Begin
       TAHostSendStrLn(Q,' ...Op‚rateur systŠme entrer en "chat" mode, S.V.P. attendre...');
       TAHostSendStrLn(Q,'');
       Q.HostSection:='G'; Q.LastHostSect:='M';
      End
       Else
      Begin
       TAPageSysop(Q,SysopFound);
       If(SysopFound)Then Begin Q.HostSection:='G';Q.LastHostSect:='M'End;
      End;
  'C': EnterComment;
  'P': ScanMsg(True);
  'X': Q.ExpertOn:=Not Q.ExpertOn;
  'S': ScanMsg(No);
  'J': If Q.Privilege='S'Then Begin Q.HostSection:='D';Q.LastHostSect:='M'End
		       Else TAHostSendStr(Q,^G);
  'W': TAPutWelcomeMsg(Q);
  Else TAHostSendStr(Q,^G);
 End;
End;

Function TADoHost;
Var
 Ch,SCh:Char;
 MyPass:String;
 Try:Integer;
 Back,KeyedIn,__Done,Found:Boolean;
 K:Wd;
Begin
 TADoHost:=kbNoKey;
 ACPurgeBuf;
 Q.ExpertOn:=No;Q.CRLFHost:=Char(caCR);__Done:=No;Q.CurHostStatus:='';
 TAHostSendStrLn(Q,'D‚bute la communications');
 TAHostSendStrLn(Q,'');
 TAHostSendStrLn(Q,'Teste si le "Line Feeds" est requis...');
 Repeat
  ACPurgeBuf;
  TAHostSendStrLn(Q,'');
  TAHostSendStrNEcho(Q,'Cette ligne est elle en S U R I M P R E S S I O N ?');
  KeyedIn:=No;
  _InitKbd;
  Repeat
   _BackKbd;
   If(KeyPress)Then Begin
    K:=ReadKey;
    If(K=kbEsc)Then Begin
     Q.ReallyDone:=True;
     Exit;
    End
     Else
    Begin
     Ch:=Char(K);
     Break;
    End;
   End;
   If Not(TAHostCarrierDetect(Q))Then Exit;
  Until ACReceive(Ch);
  SCh:=Char(Byte(Ch)and$7F);
  If(SCh<>Ch)Then Begin
   DataBits:=7;
   If Parity='N'Then Parity:='E'Else Begin Parity:='N';Inc(DataBits)End;
   ACResetPort(CommPort,BaudRate,Parity,DataBits,StopBits);
   TMLn(Q);
   TMPutTxtLn(Q,'Communication r‚ajust‚ … parit‚ = '+Parity+' et donn‚ bits = '+IntToStr(DataBits));
   TMLn(Q);
  End;
  SCh:=UpCase(SCh);
  TAHostSend(Q,SCh);
  TMBackService(Q,SCh);
 Until SCh in['O','N'];
 Q.CRLFHost:=Char(caCR);
 If SCh='O'Then IncStr(Q.CRLFHost,Char(caLF));
 Try:=0;
 Repeat
  Inc(Try);
  TAGetUserInfo(Q,Found)
 Until(Try>MaxLoginTry)or(Found);
 __Done:=__Done or(Not(Found))or(Not(TAHostCarrierDetect(Q)));
 If Not(__Done)Then Begin
  Q.HostSection:='I';
  Repeat
   Case(Q.HostSection)of
    'G':  {GossipMode};
    'F':  Repeat
	   TAProcessFileTransferCmd(Q,__Done,Back);
	  Until(__Done)or(Back);
    'D':  If Q.Privilege='S'Then Begin
	   If Not(Q.LocalHost)Then {Jump2Dos}
	    Else
	   Begin
{            DosJump('');}
	    Q.HostSection:=Q.LastHostSect;
	   End;
	  End;
     Else Begin
	   K:=TAProcessHostCmd(Q,__Done);
	   If(K<>kbNoKey)Then Begin TADoHost:=K;Exit;End;
	  End;
   End;
   __Done:=__Done or Not(TAHostCarrierDetect(Q));
  Until(__Done);
 End;
 TMPutStatus(Q,'Attend un appelle');
 TAWriteLog(Q,'D‚branchement.',No,No);
 TMPutStatus(Q,'D‚branch‚');
 TAWriteLog(Q,'Attend un appelle.',No,No);
 TAPresBBS(Q);
End;

Function TARun;
Var
 K:Word;
 Q:Term Absolute QX;
Begin
 If(Q.ReallyDone)Then Begin
  Q.HostModeFlag:=False;
  TMPutMode(Q,'')
 End;
 If(Q.HostModeFlag)Then Repeat
  TAWait4Ring(Q,Q.Done);
  If Not(Q.Done)Then Begin
   K:=TADoHost(Q);
   If(K<>kbNoKey)Then Begin TARun:=K;Exit;End;
  End;
  TADoneHostMode(Q);
 Until Q.ReallyDone
  Else
 TARun:=TMRun(Q);
End;

Function TADone;Begin
 TADoneHostMode(Term(Q));
 TMDone(Term(Q));
 TADone:=0;
End;

Function EditDialEntry;
Var Data:Record
 Name:String[29];
 Phone:String[20];
 Password:String[15];
 Script:String[8];
 Connect:Byte;
 Term:Byte;
End;
Begin
 EditDialEntry:=False;
 FillClr(Data,SizeOf(Data));
 Data.Name:=LoadStr(Dial.Name,SizeOf(Dial.Name));
 Data.Phone:=LoadStr(Dial.Phone,SizeOf(Dial.Phone));
 Data.Password:=LoadStr(Dial.Password,SizeOf(Dial.Password));
 Data.Script:=LoadStr(Dial.Script,SizeOf(Dial.Script));
 Case(Dial.Connect2)of
  'B':Data.Connect:=0;
  'C':Data.Connect:=1;
  'F':Data.Connect:=2;
  'M':Data.Connect:=3;
 End;
 Case(Dial.Term)of
  'A':Data.Term:=0;
  'T':Data.Term:=1;
  '5':Data.Term:=2;
  '1':Data.Term:=3;
 End;
 If ExecuteAppDPU(38,Data)Then Begin
  StrPascalCopy(Dial.Name,SizeOf(Dial.Name),Data.Name);
  StrPascalCopy(Dial.Phone,SizeOf(Dial.Phone),Data.Phone);
  StrPascalCopy(Dial.Password,SizeOf(Dial.Password),Data.Password);
  StrPascalCopy(Dial.Script,SizeOf(Dial.Script),Data.Script);
  Case(Data.Connect)of
   0:Dial.Connect2:='B';
   1:Dial.Connect2:='C';
   2:Dial.Connect2:='F';
   3:Dial.Connect2:='M';
  End;
  Case(Data.Term)of
   0: Dial.Term:='A';
   1: Dial.Term:='T';
   2: Dial.Term:='5';
   3: Dial.Term:='1';
  End;
  EditDialEntry:=True;
 End;
End;

Procedure StatDialEntry;
Var
 W:Window;
Begin
 WEInitO(W,50,8);
 WEPushWn(W);
 WEPutWnKrDials(W,'Statistique de l''Entr‚e de Bottin');
 WELn(W);
 WEPutTxtLn(W,'Nom du BBS: '+LoadStr(Dial.Name,SizeOf(Dial.Name)));
 WEPutTxtLn(W,'Total appelle:'+LoadStr(Dial.Total,SizeOf(Dial.Total)));
 WEPutTxtLn(W,'DerniŠre communication:'+LoadStr(Dial.Last,SizeOf(Dial.Last)));
 While WEOk(W)do;
End;

{Description
  Cette fonction permet au Sysop de cr‚e ou modifier les informations
 d'un membre. Si le sysop abandonne l'op‚ration, la fonction retourne"No".}

Function WinInpUser;
Var Data:Record
 Alias:String[18];
 Phone:String[20];
 FirstName:String[18];
 LastName:String[18];
 PassWord:String[15];
 SuperLevel:Bool;
End;
BUser:TByte Absolute User;I:Word;
Begin
 WinInpUser:=No;
 FillClr(Data,SizeOf(Data));
 Data.Alias:=StrPas(@User.Alias);
 Data.Phone:=StrPas(@User.Phone);
 Data.FirstName:=StrPas(@User.FirstName);
 Data.LastName:=StrPas(@User.LastName);
 Data.PassWord:=StrPas(@User.PassWd);
 Data.SuperLevel:=User.Level[0]='2';
 If ExecuteAppDPU(39,Data)Then Begin
  If(Data.SuperLevel)Then User.Level[0]:='2'Else User.Level[0]:='0';
  StrPascalCopy(User.Alias,SizeOf(User.Alias),Data.Alias);
  StrPascalCopy(User.Phone,SizeOf(User.Phone),Data.Phone);
  StrPascalCopy(User.FirstName,SizeOf(User.FirstName),Data.FirstName);
  StrPascalCopy(User.LastName,SizeOf(User.LastName),Data.LastName);
  StrPascalCopy(User.Passwd,SizeOf(User.Passwd),Data.Password);
  WinInpUser:=True;
 End;
 For I:=0to SizeOf(UserRec)do If BUser[I]=0Then BUser[I]:=32;
End;

Function WinNewUser;Begin
 FillClr(User,SizeOf(User));
 FillChr(User.Level,SizeOf(User.Level),Byte('0'));
 User.CRLF[0]:=#13;User.CRLF[1]:=#10;
 WinNewUser:=WinInpUser(User);
End;

Procedure WDInit;Begin
 FillClr(Q,SizeOf(Q));
End;

Procedure WDInitWin;Begin
 WDInit(Q);
 WDOpen(Q,FileName);
 Q.PathDial:=FileName;
 WDPutWindow(Q,X1,Y1,X2,Y2);
End;

Function WDOpen;
Label Break;
Var
 J,M:LongInt;
 Handle:Hdl;
 Ptr:Pointer;
Begin
 WDOpen:=False;
 Q.PathDial:=FileName;
 Handle:=FileOpen(FileName,fmRead);
 If(Handle=errHdl)Then Exit;
 M:=Systems.FileSize(Handle)div SizeOf(TMDialRec);
 For J:=0to M-1do Begin
  Ptr:=ALAdd(Q.Lst,SizeOf(TMDialRec));
  If(Ptr=NIL)Then Goto Break;
  Systems.GetRec(Handle,J,SizeOf(TMDialRec),Ptr^);
 End;
Break:
 FileClose(Handle);
 Q.SizeSelect:=M;Q.Select:=MemNew(Q.SizeSelect);
 WDOpen:=True;
End;

Procedure WDPutWindow;
Var
 J:Byte;
 Dial:^TMDialRec;
Begin
 WEInit(Q.W,X1,Y1,X2,Y2);
 WEPushWn(Q.W);
 WEPutWnKrDials(Q.W,'Bottin - ('+Q.PathDial+')');
 WEPutTxtXY(Q.W,0,0,'Nom:');
 WEPutTxtXY(Q.W,0,1,'Num‚ro:');
 WEPutTxtXY(Q.W,35,1,'Attente #');
 WEPutTxtXY(Q.W,0,2,MultChr('Ä',Q.W.MaxX+1));
 WEPutTxtXY(Q.W,0,3,'Ligne  Nom BBS');
 WEPutTxtXY(Q.W,38,3,'Num‚ro T‚l‚phone');
 WEPutTxtXY(Q.W,59,3,'Der. Date Terminal Protocol');
 WEPutTxtXY(Q.W,0,4,MultChr('Ä',6));
 WEPutTxtXY(Q.W,7,4,MultChr('Ä',SizeOf(Dial^.Name)));
 WEPutTxtXY(Q.W,38,4,MultChr('Ä',SizeOf(Dial^.Phone)));
 WEPutTxtXY(Q.W,59,4,MultChr('Ä',SizeOf(Dial^.Last)));
 WEPutTxtXY(Q.W,69,4,MultChr('Ä',8));
 WEPutTxtXY(Q.W,78,4,MultChr('Ä',14));
 For J:=0to Q.W.MaxY-5do WDPutLine(Q,J,J+Q.P-Q.Y);
 WDSelectBar(Q);
End;

Procedure WDPutLine;
Var
 Dial:^TMDialRec;
 S:String;
Begin
 If Q.Select^[_P]Then WESetKrBorderF(Q.W,$E)Else WESetKrBorderF(Q.W,$B);
 WEPutTxtXY(Q.W,0,5+_Y,Str2(_P+1,6));
 Dial:=_ALGetBuf(Q.Lst,_P);
 If(Dial=NIL)Then Exit;
 WEPutTxtXY(Q.W,7,5+_Y,LoadStr(Dial^.Name,SizeOf(Dial^.Name)));
 WEPutTxtXY(Q.W,38,5+_Y,LoadStr(Dial^.Phone,SizeOf(Dial^.Phone)));
 WEPutTxtXY(Q.W,59,5+_Y,LoadStr(Dial^.Last,SizeOf(Dial^.Last)));
 Case Dial^.Term of
  '1': S:='VT102';
  '5': S:='VT52';
  'A': S:='Ansi';
  'T': S:='TTY';
  Else S:='Inconnu';
 End;
 WEPutTxtXY(Q.W,69,5+_Y,S);
 Case Dial^.Protocol of
  'A': S:='ASCII';
  'B': S:='Batch Ymodem';
  'C': S:='CIS Quick B';
  'G': S:='Ymodem-G';
  'M': S:='Modem7';
  'R': S:='XModem Relaxed';
  'S': S:='SeaLink';
  'T': S:='Telink';
  'X': S:='Xmodem';
  'Y': S:='Ymodem';
  'Z': S:='Zmodem';
 End;
 WEPutTxtXY(Q.W,78,5+_Y,S);
End;

Procedure WDSelectBar;Begin
 If Q.Select^[Q.P]Then WESetKrSelF(Q.W,$E)Else WESetKrSel(Q.W);
 WEBarSelHor(Q.W,0,5+Q.Y,wnMax);
End;

Procedure WDUnSelectBar;Begin
 If Q.Select^[Q.P]Then WESetKrBorderF(Q.W,$E)Else WESetKrBorderF(Q.W,$B);
 WEBarSelHor(Q.W,0,5+Q.Y,wnMax);
End;

Procedure WDUpDateInfo;
Var
 Dial:^TMDialRec;
Begin
 Dial:=_ALGetBuf(Q.Lst,Q.P);
 If(Dial=NIL)Then Exit;
 If Q.Select^[Q.P]Then WESetKrBorderF(Q.W,$E)Else WESetKrBorderF(Q.W,$B);
 WEPutTxtXY(Q.W,9,0,LoadStr(Dial^.Name,SizeOf(Dial^.Name)));
 WEPutTxtXY(Q.W,9,1,LoadStr(Dial^.Phone,SizeOf(Dial^.Phone)));
End;

Procedure WDUpKey;Begin
 With Q.Lst do Begin
  If Q.P>0Then Begin
   Dec(Q.P);
   WDUpDateInfo(Q);
   Inc(Q.P);
   If Q.Y>0Then Begin
    WDUnSelectBar(Q);
    Dec(Q.P);Dec(Q.Y);
    WDSelectBar(Q);
   End
    else
   Begin
    WDUnSelectBar(Q);
    Dec(Q.P);
    WEScrollUp(Q.W,0,5,wnMax,wnMax);
    WDPutLine(Q,0,Q.P);
    WDSelectBar(Q);
   End;
  End;
 End;
End;

Procedure WDDownKey;Begin
 If Q.P<Q.Lst.Count-1Then Begin
  Inc(Q.P);
  WDUpDateInfo(Q);
  Dec(Q.P);
  If Q.Y<Q.W.MaxY-5Then Begin
   WDUnSelectBar(Q);
   Inc(Q.P);Inc(Q.Y);
   WDSelectBar(Q);
  End
   Else
  Begin
   WDUnSelectBar(Q);
   Inc(Q.P);
   WEScrollDn(Q.W,0,5,wnMax,wnMax);
   WDPutLine(Q,Q.Y,Q.P);
   WDSelectBar(Q);
  End;
 End;
End;

Function WDRun;
Var
 Dial:^TMDialRec;
 K:Word;
Begin
 WDUpDateInfo(Q);
 WDRun:=kbNoKey;
 Repeat
  K:=WEReadk(Q.W);
  Case(K)of
   kbUp:If Not ALIsEmpty(Q.Lst)Then WDUpKey(Q);
   kbDn:If Not ALIsEmpty(Q.Lst)Then WDDownKey(Q);
   kbIns:If Not ALIsEmpty(Q.Lst)Then Begin
    Q.Select^[Q.P]:=Not(Q.Select^[Q.P]);
    WDDownKey(Q);
   End;
   kbEnter: If Not ALIsEmpty(Q.Lst)Then Begin
    Break;
    Dial:=_ALGetBuf(Q.Lst,Q.P);
    MoveLeft(Dial^.Phone,RtnDial,SizeOf(RtnDial));
   End;
   kbCtrlF1:Begin
    Dial:=_ALGetBuf(Q.Lst,Q.P);
    StatDialEntry(Dial^)
   End;
   Else If Chr(K)=' 'Then Begin
    Dial:=ALAdd(Q.Lst,SizeOf(TMDialRec));
    If(Dial<>NIL)Then Begin
     FillClr(Dial^,SizeOf(TMDialRec));
     EditDialEntry(Dial^);
    End;
   End
    Else
   Break;
  End;
 Until No;
 WDRun:=K;
End;

Function _WDRun;
Var
 Dial:TMDialRec;
Begin
 _WDRun:=WDRun(Q,Dial)
End;

Function WDCallNumber;Begin
 If Number=''Then Exit;
 WESetKr(Q.W,$9B);
 WEPutTxtXY(Q.W,9,1,Number);
 ClrXoffReceived;
 SendModemCmd(StrPas(ModemDial)+StrPas(PrefixStr)+Number+
	      StrPas(PostfixStr)+StrPas(ModemDialEnd));
End;

Procedure WDHangUp;
Var
 OpenFlag,SaveXonXoff,SaveXonOV:Boolean;
Begin
 SaveXonXoff:=AsyncDoXonXoff; AsyncDoXonXoff:=No;
 SaveXonOV:=AsyncOVXonXoff; AsyncOVXonXoff:=No;
 If(aXoffReceived)Then ClrXoffReceived;
 ACClose(True);
 Delay(1000);
 OpenFlag:=ACOpen(CommPort,BaudRate,Parity,DataBits,StopBits);
 If(ACCarrierDetect)Then Begin
  _Delay(ModemEscTime);SendModemCmd(StrPas(ModemEsc));
  _Delay(ModemEscTime);SendModemCmd(StrPas(ModemHangUp));
  _Delay(ModemEscTime);
 End;
 ACPurgeBuf;
 AsyncDoXonXoff:=SaveXonXoff;AsyncOVXonXoff:=SaveXonOV;
End;

Procedure WDDone;Begin
 FreeMemory(Q.Select,Q.SizeSelect);
 WEDone(Q.W);
 ALDone(Q.Lst)
End;

Procedure LoadParamModem;
Var
 Model:LongInt;
 Data:Array[0..1023]of Byte;
 PBuffer:Pointer;
 PString:^String Absolute PBuffer;
 PWord:^Word Absolute PBuffer;
Begin
 If Not ReadMainKey(HKEY_CURRENT_CONFIG,'System\Modem','CurrModel',Model)Then Model:=$09A0;
 DBOpenServerName(ChantalServer,'CHANTAL:/Modem/Index.Dat');
 If DBLocateAbs(ChantalServer,0,Model,[])Then Begin
  DBReadRec(ChantalServer,Data);
  PBuffer:=@Data;
  DBGotoColumn(ChantalServer,'Init',PBuffer);
  StrDispose(ModemInit);
  ModemInit:=Str2PChr(PString^);
  PBuffer:=@Data;
  DBGotoColumn(ChantalServer,'Dial',PBuffer);
  StrDispose(ModemDial);
  ModemDial:=Str2PChr(PString^);
  PBuffer:=@Data;
  DBGotoColumn(ChantalServer,'DialEnd',PBuffer);
  StrDispose(ModemDialEnd);
  ModemDialEnd:=Str2PChr(PString^);
  PBuffer:=@Data;
  DBGotoColumn(ChantalServer,'Answer',PBuffer);
  StrDispose(ModemAnswer);
  ModemAnswer:=Str2PChr(PString^);
  PBuffer:=@Data;
  DBGotoColumn(ChantalServer,'HangUp',PBuffer);
  StrDispose(ModemHangup);
  ModemHangUp:=Str2PChr(PString^);
  PBuffer:=@Data;
  DBGotoColumn(ChantalServer,'BaudRate',PBuffer);
  BaudRate:=PWord^;
 End;
End;

Procedure TMInit;Begin
 Q.CurrCom:=Com;Q.AttendedMode:=True;
 Q.PrnOn:=No;Q.FileOn:=No;Q.DialMode:=No;
 Q.LocalHost:=True;
 WEInit(Q.W,0,Y1,wnMax,Y2);
 WESetPause(Q.W,No);
 Q.SW:=Q.W;
 {$IFNDEF H}WEPushWn(Q.W);{$ENDIF}
 WEPutWn(Q.W,'Terminal',CurrKrs.MalteDos.Window);
 WECloseIcon(Q.W);
 WESetEndBar(Q.W,$70);
 TMRefresh(Q);
 WEPutTxt(Q.W,'Installation des circuits de communication...');
 LoadParamModem;
 InitAC(0,0,0,0,0);
 ACOpen(Com,BaudRate,Parity,DataBits,StopBits);
 WELn(Q.W);
 TMInitModem(Q);
 WEPushWn(Q.SW);
 WDInitWin(Q.Dial,Q.W.T.X1,Q.W.T.Y2-11,Q.W.T.X2,Q.W.T.Y2-1,SetPath4AddFile(PathPhoneList)+'TM.FON');
End;

Procedure TMPutTxt;Var PChr:Array[Byte]of Chr;Begin
 If(ACCarrierDetect)Then ACSendStr(S);
 StrPCopy(@PChr,S);
 WEPut(Q.W,@PChr);
End;

Procedure TMPutTxtLn;Var PChr:Array[Byte]of Chr;Begin
 AddStr(S,CRLF);StrPCopy(@PChr,S);
 If(ACCarrierDetect)Then ACSendStr(S);
 WEPut(Q.W,@PChr);
End;

Procedure TMLn;Begin
 _WELn(Q.W)
End;

Procedure TMClrScr;Begin
 WEClrScr(Q.W)
End;

Function TMInput;Var P:Array[Byte]of Chr;PC:PChr;Begin
 StrPCopy(@P,S);PC:=@P;ComInInput:=True;TMInput:=WEInp(Q.W,PC,SizeOf(P)-1,No);
 ComInInput:=No;S:=StrPas(@P);
End;

Procedure TMInitModem;Var DoneFlag,DoInit:Bool;

 Function ModemConnected:Bool;Var StartTime:Long;TimedOut:Bool;Begin
  ASM MOV DX,aBase;ADD DX,uaMCR;MOV AL,$B;OUT DX,AL;END;
  ACClrErrs;
  StartTime:=TimeOfDay; TimedOut:=No;
  If(AsyncDoDSR)Then Begin
   While Not(TimedOut)and(Port[uaMSR+aBase]and$20=0)do
    TimedOut:=TimeDiff(StartTime,TimeOfDay)>2;
   If(TimedOut)and(Q.AttendedMode)Then Begin
    AsyncDoDSR:=WarningMsgYesNo('Donn‚e ajust‚ correctement sans travail, ferme le tout ?')=kbYes;
    TimedOut:=AsyncDoDSR;
   End
    Else
   TMPutTxtLn(Q,'*** Donn‚ ajust‚ correctement fermer.');
  End;
  StartTime:=TimeOfDay;
  If(AsyncDoCTS)Then Begin
   While Not(TimedOut)and(Port[uaMSR+aBase]and$10=0)do
    TimedOut:=TimeDiff(StartTime,TimeOfDay)>2;
   If(TimedOut)and(Q.AttendedMode)Then Begin
    AsyncDoCTS:=WarningMsgYesNo('Dois-je effacer l''envoie ?')=kbYes;
    TimedOut:=AsyncDoCTS;
   End
    Else
   TMPutTxtLn(Q,'Envoie effacer.');
  End;
  StartTime:=TimeOfDay;
  While Not(TimedOut)and(Port[uaLSR+aBase]and$20=0)do
   TimedOut:=TimeDiff(StartTime,TimeOfDay)>2;
  ModemConnected:=Not(TimedOut);
 End;

Const HardWired=No;

Begin
 Q.CurrCarrierStatus:=ACCarrierDetect; Q.NewCarrierStatus:=Q.CurrCarrierStatus;
 If Not(ModemConnected)Then Begin
  If Not(HardWired)Then Begin
   TMPutTxtLn(Q,'*** Modem apparament fermer.');
   TMPutTxtLn(Q,'*** S.V.P ouvrir le modem et presse une touche pour continuer.');
  End
   Else
  Begin
   TMPutTxtLn(Q,'*** Mauvais connection "Hard-wired".');
   TMPutTxtLn(Q,'*** Vous devriez v‚rifier CTS & DSR.');
   TMPutTxtLn(Q,'*** Presse une touche pour continuer...');
  End;
  If(Q.AttendedMode)Then ReadKey
   Else
  TMPutTxtLn(Q,'*** Continuer de toute fa‡on parcequ''il n''est pas en mode attende.');
 End;
 If Not(IsPChrEmpty(ModemInit))and Not(HardWired)Then Begin
  If(ACCarrierDetect)Then Begin
   TMPutTxt(Q,'*** Session apparament d‚j… en progression.');
   If(Q.AttendedMode)Then DoInit:=WarningMsgYesNo('Initialise le modem quand mˆme ?')=kbYes
    Else
   Begin
    TMPutTxtLn(Q,'*** Initialisation du modem non effectu‚.');
    DoInit:=No;
   End;
  End
   Else
  DoInit:=True;
  If(DoInit)Then Begin
   _WELn(Q.W);
   SendModemCmd(StrPas(ModemInit))
  End;
 End;
End;

Procedure TMBackService;Begin End;
Procedure TMPutMode;Begin WESetEndBarTxtX(Q.W,22,StrUSpc(M,10),$7C)End;

Procedure TMPutFlags;Var D:String[8];Begin
 D[0]:=#8; FillSpc(D[1],8);
 If(Q.FileOn)Then D[1]:='F';
 If(Q.PrnOn)Then D[2]:='P';
 If(Log)Then D[3]:='L';
 If(AsyncHardWiredOn)Then D[4]:='W';
 If(AsyncDoDSR)Then D[5]:='D';
 If(AsyncDoXonXoff)Then D[6]:='X';
 If(AsyncDoCTS)Then D[7]:='T';
 If(Q.CurrCarrierStatus)Then D[8]:='H';
 WESetEndBarTxtX(Q.W,72,D,$74);
End;

Procedure TMPutStatus;Begin
 WESetEndBarTxtX(Q.W,34,Left(StrUSpc(S,35),35),$74);
 TMPutFlags(Q);
End;

Procedure TMRefresh;
Var
 S:String;
Begin
 If(Term(Q).DialMode)Then
  WDPutWindow(Term(Q).Dial,Term(Q).Dial.W.T.X1,Term(Q).Dial.W.T.Y1,Term(Q).Dial.W.T.X2,Term(Q).Dial.W.T.Y2)
 Else WEPopWn(Term(Q).SW);
 S:='COM'+WordToStr(Term(Q).CurrCom)+':'+WordToStr(BaudRate)+','+Parity+
      ','+WordToStr(DataBits)+','+WordToStr(StopBits);
 WESetEndBarTxtX(Term(Q).W,19-Length(S),S,$7C);
 WESetEndBarTxtX(Term(Q).W,20,'³',$70);
 WESetEndBarTxtX(Term(Q).W,32,'³',$70);
 WESetEndBarTxtX(Term(Q).W,70,'³',$70);
End;

Function TMExecCmd;Begin
 TMPutTxtLn(Q,S);
 SendModemCmd(S)
End;

Procedure TMAnswerMode;Begin
 TMExecCmd(Q,'~~~+++~~~AT S0=1|~')
End;

Procedure TMOriginateMode;Begin
 TMExecCmd(Q,'~~~+++~~~AT S0=0|~')
End;

Function TMRun;
Label Break;
Var
 K:Word;
 Chr:Char;

 Procedure Prot;
 Var
  L:LstMnu;
  I:Byte;
  Target:Char;
  P:^Prots;
  Data:Record
   ID:Byte;
   SingleFile:Boolean;
   TN:String[2];
   Name:String;
  End;
 Begin
  If(K=kbPgDn)Then Target:='R'Else Target:='S';
  LMInitCenter(L,30,trsMax+1,'Protocol',CurrKrs.Dialog.Window);
  DBOpenModemProtocol;
  DBFirst(ChantalServer);
  While Not DBEOF(ChantalServer)do Begin
   DBReadRec(ChantalServer,Data);
   ALAddStrByte(L.List,Data.Name,Data.ID);
  End;
  K:=LMRun(L);
  LMDone(L);
  If K>0Then Begin
   P:=MemAlloc(SizeOf(Prots));
   If(P=NIL)Then __OutOfMemory
    Else
   Begin
 {   P^.TName:=OpenWin(UploadDir,'Envoie de fichier(s)');
    If P^.TName<>''Then Begin}
     Protocol.PLInit(P^,4,4);
     Protocol.PLUpDownLoad(P^,K,Target);
     Protocol.PLDone(P^);
{    End;}
    FreeMemory(P,SizeOf(Prots));
   End;
  End;
 End;
Begin
 TMPutFlags(Q);
 Repeat
  If(Q.DialMode)Then K:=_WDRun(Q.Dial)
   Else
  Begin
   WEPushCur(Q.W);
   __ShowMousePtr;
   _InitKbd;
   Repeat
    _BackKbd;
    K:=WEBackReadk(Q.W);
    If K>0Then Case(K)of
     kbInWn:;
     Else Begin
      WEPopCur(Q.W);
      __HideMousePtr;
      TMRun:=K;
      Exit;
     End;
    End;
    WEAniCur(Q.W);
    If ACReceive(Chr)Then Begin WEPopCur(Q.W);TMPutTxt(Q,Chr);WEPushCur(Q.W)End;
    TMPutFlags(Q);
   Until KeyPress;
  __HideMousePtr;
   WEPopCur(Q.W);
   K:=WEReadk(Q.W);
  End;
  Case K of
    kbEsc: If(Q.DialMode)Then Begin Q.DialMode:=No;TMRefresh(Q)End;
    kbTab: Begin
	    If Not(Q.DialMode)Then WEPushWn(Q.SW);
	    Q.DialMode:=Not(Q.DialMode);
	    TMRefresh(Q);
	   End;
   kbHome: Q.W.X:=0;
kbPgUp,kbPgDn: Prot;
     kbUp: _WEUp(Q.W);
     kbDn: _WEDn(Q.W);
   kbLeft: _WELeft(Q.W);
  kbRight: _WERight(Q.W);
  kbEnter: Begin
	    SendModemCmd(RTrim(WEGetStr(Q.W,0,Q.W.Y))+'|');
	    Q.W.X:=0;
	   End;
      Else If Char(K)>#31Then TMPutTxt(Q,Char(K))Else Goto Break;
  End;
 Until No;
Break:
 If Not(Q.DialMode)Then WEPushWn(Q.SW);
 TMRun:=K;
End;

Function TMTitle(Var Q;Max:Byte):String;Begin
 TMTitle:='Terminal';
End;

Procedure TMDone;Begin
 WDDone(Q.Dial);
 ACClose(True);
 WEDone(Q.SW);
 WEDone(Q.W)
End;

Function SelectTermEmul(X1,Y1,X2,Y2:Byte):Byte;
Var
 L:LstMnu;
Begin
 LMInitKrDials(L,X1,Y1,X2,Y2,'Selection le terminal … ‚muler');
 ALAddStrByte(L.List,'ADM3a',teADM3a);
 ALAddStrByte(L.List,'ADM5',teADM5);
 ALAddStrByte(L.List,'Ansi',teANSI);
 ALAddStrByte(L.List,'Dumb',teDumb);
 ALAddStrByte(L.List,'Gossip Mode',teGossipMode);
 ALAddStrByte(L.List,'Host Mode',teHostMode);
 ALAddStrByte(L.List,'Tektronix 401',teTektronix401);
 ALAddStrByte(L.List,'TV925',teTV925);
 ALAddStrByte(L.List,'VT52',teVT52);
 ALAddStrByte(L.List,'VT100',teVT100);
 SelectTermEmul:=LMRun(L);
 LMDone(L);
End;

Procedure Upload;Begin
 PushKey(kbPgUp)
End;

Procedure Download;Begin
 PushKey(kbPgDn)
End;

Function TermRun;Begin
 TMRefresh(Term(Q));
 TermRun:=TARun(Term(Q))
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
END.