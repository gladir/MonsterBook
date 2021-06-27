{⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
 ≥          Malte Genesis/Module des Protocoles        ≥
 ≥              Edition Isabel pour Mode RÇel          ≥
 ≥                   III - Version 1.0                 ≥
 ≥                       1995/02/02                    ≥
 ≥                                                     ≥
 ≥ Tous droits rÇservÇ par les Chevaliers de Malte (C) ≥
 ¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ}

Unit Protocol;

{ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ}
                                INTERFACE
{ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ}

{$A-,V-}
Uses
 Systex,BBStex;

Var
 PathUpload:PChr;
 PathDownload:PChr;

Function  DownloadDir:String;
Function  UploadDir:String;
Function  ExitMsgStr(Code:Byte):String;
Procedure PLInit(Var Q:Prots;X,Y:Byte);
Procedure PLUpDownLoad(Var Q:Prots;TransferProt:Byte;TransferDirec:Chr);
Procedure PLDone(Var Q:Prots);

{ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ}
                              IMPLEMENTATION
{ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ}

Uses
 Memories,Systems,Time,Video,Dials,TMDials,
 Dostex,Numerix,Terminal,SysInter,Dialex,DialPlus,
 SysPlus,CommBase,Math,ResServD;

 { Ascii }
Procedure PLInitAsciiReceiveScr(Var Q:Prots;Const AsciiTitle:String);Near;Forward;
Procedure PLUpdateAsciiReceiveScr(Var Q:Prots);Near;Forward;
Function  PLReceiveAsciiFile(Var Q:Prots):Boolean;Near;Forward;
Procedure PLInitAsciiSendScr(Var Q:Prots;Const AsciiTitle:String);Near;Forward;
Procedure PLUpdateAsciiSendScr(Var Q:Prots);Near;Forward;
Procedure PLSendAsciiFile(Var Q:Prots);Near;Forward;
 { XModem }
Procedure PLCancelTransfer(Var Q:Prots);Near;Forward;
Procedure PLInitReceiveScr(Var Q:Prots);Near;Forward;
Procedure PLInitSendScr(Var Q:Prots);Near;Forward;
Procedure PLPutBatchWn(Var Q:Prots);Near;Forward;
Procedure PLChkKbd(Var Q:Prots);Near;Forward;
Procedure PLGetXmodemTitles(Var Q:Prots);Near;Forward;
Procedure PLSaveComm4Xmodem(Var Q:Prots);Near;Forward;
Procedure PLRestoreComm4Xmodem(Var Q:Prots);Near;Forward;
Procedure PLExtractUploadPathName(Var FilePattern:String);Near;Forward;
Procedure PLEndBatchTransfer(Var Q:Prots);Near;Forward;
Procedure PLUpdateXmodemSendScr(Var Q:Prots);Near;Forward;
Procedure PLAsyncSendDLEChar(Var Q:Prots;C:Char);Near;Forward;
Procedure PLSendXmodemFile(Var Q:Prots;UseCRC:Boolean);Near;Forward;

{$I Library\System\Unix\GetUnixS.Inc}
{$I Library\System\Unix\SetUnixS.Inc}

Function DownloadDir;Begin
 DownloadDir:=SetPath4AddFile(StrPas(PathDownload))
End;

Function UploadDir;Begin
 UploadDir:=SetPath4AddFile(StrPas(PathUpload))
End;

Function ExitMsgStr;Begin
 Case(Code)of
  protNone:ExitMsgStr:='';
  protReceiveError:ExitMsgStr:='Erreur de rÇception';
  protCarrierDrop:ExitMsgStr:='Carrier Drop';
  protAltRStop:ExitMsgStr:='Arràt par Alt+R';
  protOk:ExitMsgStr:='RÇception rÇussit';
  Else ExitMsgStr:='Erreur inconnue!';
 End;
End;

Procedure PLInit;Begin
 FillClr(Q,SizeOf(Q));
 DefaultTransferType:=trsXmodemChk;
 Q.TX:=X;Q.TY:=Y;
 Q.Config:=Q.Config+[AsciiTranslate,HonorXoffYmodem];
 Q.AsciiLineSize:=255;
 Q.AsciiCRLFStr:=^M;
 Q.XmodemCharWait:=1;
 Q.XmodemBlockWait:=10;
 Q.XmodemAckWait:=10;
 Q.XmodemMaxErrors:=20;
End;

Procedure PLInitAsciiReceiveScr;Begin
 WEInit(Q.W,Q.TX,Q.TY,Q.TX+50,Q.TY+5);
 WEPushWn(Q.W);
 WEPutWnKrDials(Q.W,AsciiTitle);
 WEPutTxtXY(Q.W,0,0,'Texte reáue');
 WEPutTxtXY(Q.W,0,1,MultChr('ƒ',30));
 WEPutTxtXY(Q.W,0,2,'Lignes reáue :');
 WEPutTxtXY(Q.W,0,3,'Octets reáue :');
End;

Procedure PLUpdateAsciiReceiveScr;Begin
 WEPutTxtXY(Q.W,17,2,IntToStr(Q.LineCount));
 WEPutTxtXY(Q.W,17,3,IntToStr(Q.ByteCount));
End;

Function PLReceiveAsciiFile;
Var
 Local:Record
  Fin:Boolean;
  RError:Boolean;
  OkDispSize:Boolean;
  NotUseChar:Boolean;
  AltRHit:Boolean;
 End;
 FullName,AsciiTitle:String;
 AFile:Text;
 Ch:Char;
 K:Word;
Begin
 PLReceiveAsciiFile:=False;
 FillClr(Local,SizeOf(Local));
 Q.LineCount:=0;
 Q.ByteCount:=0;
 AsciiTitle:='RÇception Ascii du fichier '+Q.TName;
 PLInitAsciiReceiveScr(Q,AsciiTitle);
 FullName:=DownloadDir+Q.TName;
 Assign(Afile,FullName);
 SetTextBuf(AFile,Q.SectorData);
 ReWrite(AFile);
 Local.RError:=IoResult<>0;
 Repeat
  While KeyPress do Begin
   K:=ReadKey;
   Case(K)of
    kbEsc:If(KeyPress)Then Begin
     K:=ReadKey;
     Case(K)of
      kbAltR:Begin
       Local.Fin:=True;
       Local.AltRHit:=True;
      End;
      Else ACSend(Char(K));
     End;
    End;
   End;
  End;
  If ACReceive(Ch)Then Begin
   If(Q.AutoStripHighBit)Then Ch:=Char(Byte(Ch)and$7F);
   If(AsciiTranslate)in(Q.Config)Then Begin
    Ch:=Q.TrTab[Ch];
    Local.NotUseChar:=Byte(Ch)=caNUL;
   End;
   If Not(Local.NotUseChar)Then Begin
    Write(AFile,Ch);
    Local.RError:=Local.RError or(IoResult<>0);
    Inc(Q.ByteCount);
    If Ch=Char(caCR)Then Begin
     Inc(Q.LineCount);
     PLUpdateAsciiReceiveScr(Q);
     If(Q.AddLF)Then Begin
      Write(AFile,Char(caLF));
      Local.RError:=Local.RError or(IoResult<>0);
      Inc(Q.ByteCount);
     End;
    End
     Else
    If(Q.AsciiUseCtrlZ)and(Ch=^Z)Then Local.Fin:=True;
   End;
  End;
  Local.Fin:=Local.Fin or(ACCarrierDrop)or Local.RError;
 Until Local.Fin;
 Local.OkDispSize:=False;
 If(ACCarrierDrop)Then Q.ExitMsg:=protCarrierDrop Else
 If(Local.AltRHit)Then Q.ExitMsg:=protAltRStop Else
 If Not(Local.RError)Then Begin
  Q.ExitMsg:=protOk;
  Local.OkDispSize:=True;
 End
  Else
 Q.ExitMsg:=protReceiveError;
 System.Close(AFile);
 WEDone(Q.W);
 PLReceiveAsciiFile:=IoResult<>0;
End;

Procedure PLInitAsciiSendScr;Begin
 WEInit(Q.W,Q.TX,Q.TY,Q.TX+55,Q.TY+8);
 WEPushWn(Q.W);
 WEPutWnKrDials(Q.W,AsciiTitle);
 WEPutTxtXY(Q.W,0,0,'Caractäre Ö envoyÇ:');
 WEPutTxtXY(Q.W,0,1,'Lignes envoyÇ:'+Str2(Q.LineCount,19));
 WEPutTxtXY(Q.W,0,2,'Octets envoyÇ:'+Str2(Q.ByteCount,19));
 WEPutTxtXY(Q.W,0,3,'Temps appro. transfäre:  '+TimeString(Q.Time2Send,Military));
 WEPutTxtXY(Q.W,0,5,'Lignes Ö envoyer:');
 WEPutTxtXY(Q.W,0,6,'Octet encore Ö envoyer:');
 WEPutTxtXY(Q.W,0,7,'Temps restant transfäre: '+TimeString(Q.Time2Send,Military));
End;

Procedure PLUpdateAsciiSendScr;Begin
 WEPutTxtXY(Q.W,32,1,IntToStr(Q.LineCount));
 WEPutTxtXY(Q.W,32,2,IntToStr(Q.ByteCount));
End;

Procedure PLSendAsciiFile;
Label 1;
Const
 PacingDelay=0.10;
 ModemFudge=0.85;
 MaxWaitTime=60;
Var
 Local:Record
  BufferSize:SmallInt;
  EOFAFile:Boolean;
  LongBuffer:Boolean;
  AltSHit:Boolean;
 End;
 Ch,ACh:Char;
 EscFound,B,PaceFound,Pacing,Fin,PaceTime,AsciiDisplay,
 DoSendBlank:Boolean;
 LineKount,LengthLine,T1:LongInt;
 RBaudRate,RCharDelay,RLineDelay:Real;
 I,X,Y,BufferPos,MaxDLine:SmallInt;
 TextLine,AsciiTitle:String;
 CRLFString:String[30];
 SBSize,SLSize:String[20];
 Handle:Hdl;
 K:Word;

 Function AsciiReceive(Var Ch:Char):Boolean;
 Var
  KeyC:Char;
 Begin
  If ACReceive(Ch)Then Begin
   AsciiReceive:=True;
   Case Byte(Ch)of
    caNUL,caDEL:AsciiReceive:=False;
    caBELL:Beep;
    Else If(AsciiDisplay)Then WEPutTxt(Q.W,Ch);
   End;
  End
   Else
  AsciiReceive:=False;
 End;

 Procedure AsciiSend(Ch:Char);Begin
  If(AsciiDisplay)Then ACSendNow(Ch)
                  Else ACSend(Ch)
 End;

 Procedure SendAsciiLine;
 Var
  B:Boolean;
  I:Integer;
 Begin
  For I:=1to Length(TextLine)do Begin
   AsciiSend(TextLine[I]);
   If Q.AsciiCharDelay>0Then Delay(Q.AsciiCharDelay);
   B:=AsciiReceive(Ch);
  End;
  If Not(Pacing)Then Begin
   If Q.AsciiLineDelay>0Then Delay(Q.AsciiLineDelay);
   While AsciiReceive(Ch)do;
  End;
 End;

 Procedure ReadALine(Var S:String);
 Var
  I,Ierr:Integer;
  Eol:Boolean;
 Begin
  I:=0;Eol:=False;S:='';
  While Not(Eol or Local.EOFAFile)do Begin
   Inc(BufferPos);
   If(BufferPos>Local.BufferSize)Then Begin
    Local.BufferSize:=_GetRec(Handle,SizeOf(Q.SectorData),Q.SectorData);
    BufferPos:=1;
    If(Local.BufferSize<=0)or(SysErr<>0)Then Begin
     Eol:=True;
     Local.EOFAFile:=True;
    End;
   End;
   If Not(Local.EOFAFile)Then If Not(Q.AsciiSendAsis)Then
   Case Byte(Q.SectorData[BufferPos])of
    caCR:;
    caLF:Eol:=True;
    Else Begin
     Inc(I);
     S[I]:=Q.SectorData[BufferPos];
     Eol:=Eol or(I>252)
    End;
   End
    Else
   Begin
    Inc(I);
    S[I]:=Q.SectorData[BufferPos];
    Eol:=Eol or(I>Q.AsciiLineSize)
   End;
  End;
  If I>0Then If ^Z=S[I]Then Dec(I);
  S[0]:=Char(I);
 End;

Begin
 If Q.TName=''Then Begin
  If(_WinInp(60,'Envoyer un fichier','Entrez le nom du fichier Ö envoyer',False,Q.TName)<>kbYes)Then Exit;
  If Q.TName=''Then Begin
   ErrMsgOk('DÇsolÇ! Je ne peux pas envoyer du vent...');
   Exit;
  End;
 End;
 AsciiTitle:='Envoie le fichier '+Q.TName+' en utilisant ASCII';
 PLInitAsciiSendScr(Q,AsciiTitle);
 Handle:=FileOpen(Q.TName,fmRead);
 If(Handle=errHdl)Then Exit;
 Q.ByteCount:=FileSize(Handle);
 RBaudRate:=(BaudRate*ModemFudge)/10.0;
 Q.LineCount:=0;
 FillClr(Local,SizeOf(Local));
 BufferPos:=SizeOf(Q.SectorData);
 Repeat
  ReadALine(TextLine);
  Inc(Q.LineCount);
 Until(Local.EOFAFile);
 SetFilePos(Handle,0);
 BufferPos:=SizeOf(Q.SectorData);
 Local.BufferSize:=0;
 Local.EOFAFile:=False;
 SBSize:=IntToStr(Q.ByteCount);
 SLSize:=IntToStr(Q.LineCount);
 RCharDelay:=Q.AsciiCharDelay/1000.0;
 RLineDelay:=Q.AsciiLineDelay/1000.0;
 Q.Time2Send:=Round(Q.ByteCount/RBaudRate+RCharDelay*Q.ByteCount+RLineDelay*Q.LineCount);
 PaceTime:=(Q.AsciiCharDelay=0)and(Q.AsciiLineDelay=0)and
	   (Q.AsciiPacingChar<>Char(caNUL))and(Q.AsciiPacingChar<>' ');
 If(PaceTime)Then Q.Time2Send:=Round(Q.Time2Send+Q.LineCount*(PacingDelay+RLineDelay));
 DoSendBlank:=Q.AsciiSendBlank; CRLFString:=Q.AsciiCRLFStr;
 If(Q.AsciiSendAsis)Then Begin
  DoSendBlank:=False;
  CRLFString:='';
 End;
 Fin:=False;
 Q.StartTime:=TimeOfDay;
 PaceFound:=True;
 Pacing:=False;
 LineKount:=Q.LineCount;
 Q.LineCount:=0;
 Repeat
  ReadALine(TextLine);
  If Local.EOFAFile and(Length(TextLine)=0)Then Goto 1;
  If(DoSendBlank)and(Length(TextLine)=0)Then TextLine:=' ';
  AddStr(TextLine,CRLFString);
  LengthLine:=Length(TextLine+CRLFString);
  EscFound:=False;
  If Pacing and(Not Fin)Then Repeat
   If(KeyPress)Then Begin
    K:=ReadKey;
    Case(K)of
     kbEsc: EscFound:=True;
     Else Begin
      B:=AsciiReceive(ACh);
      AsciiSend(Char(K));
     End;
    End;
   End;
   If AsciiReceive(Ch)Then Begin
    PaceFound:=Ch=Q.AsciiPacingChar;
    If(PaceFound)Then Delay(Q.AsciiLineDelay);
   End;
  Until PaceFound or EscFound
   Else
  Repeat
   If(KeyPress)Then Begin
    K:=ReadKey;
    Case(K)of
     kbEsc:EscFound:=True;
     Else Begin
      B:=AsciiReceive(ACh);
      AsciiSend(Char(K));
     End;
    End;
   End;
   B:=AsciiReceive(Ch);
  Until PaceFound or EscFound;
  If(EscFound and KeyPress)Then Begin
   If(ReadKey=kbAltS)Then Begin
    Fin:=True;
    Local.AltSHit:=True;
   End;
  End
   Else
  While KeyPress do Begin
   Ch:=Char(ReadKey);
   B:=AsciiReceive(ACh);
   AsciiSend(Ch);
  End;
  If Not(Fin)Then SendAsciiLine;
  Inc(Q.LineCount);
  Dec(LineKount);
  Dec(Q.ByteCount,LengthLine);
  If Q.ByteCount<0Then Q.ByteCount:=0;
  Q.Time2Send:=Round(Q.ByteCount/RBaudRate+RCharDelay*Q.ByteCount+RLineDelay*LineKount);
  If(PaceTime)Then Q.Time2Send:=Round(Q.Time2Send+LineKount*(PacingDelay+RLineDelay));
  If Q.Time2Send<=0Then Q.Time2Send:=0;
  PLUpdateAsciiSendScr(Q);
  Pacing:=(Q.AsciiPacingChar<>Char(caNUL))and(Q.AsciiPacingChar<>' ');
  Fin:=Fin or ACCarrierDrop;
1:Until(Fin or Local.EOFAFile);
 If(Q.AsciiUseCtrlZ)Then Begin
  B:=AsciiReceive(Ch);
  AsciiSend(^Z);
 End;
 T1:=TimeOfDay;
 While(aOBufHead<>aOBufTail)and(TimeDiff(T1,TimeOfDay)<=MaxWaitTime)and(Not KeyPress)do
  AsciiReceive(Ch);
 Delay(2000);
 PLInitAsciiSendScr(Q,AsciiTitle);
 If Not(Fin)Then
  WEPutTxtXY(Q.W,0,0,'Le temps actuel de transmission est '+TimeString(TimeDiff(Q.StartTime,TimeOfDay),Military));
 FileClose(Handle);
 WEDone(Q.W);
End;

Procedure PLCancelTransfer;Begin
 If(Q.DoAcks)Then ACPurgeBuf;
 ACSendStr(Char(caCAN)+Char(caCAN)+Char(caCAN)+Char(caCAN)+Char(caCAN)+
           Char(caBS)+Char(caBS)+Char(caBS)+Char(caBS)+Char(caBS));
End;

Procedure PLInitReceiveScr;Begin
 WEInit(Q.W,Q.TX,Q.TY,Q.TX+35,Q.TY+11);
 WEPushWn(Q.W);
 WEPutWnKrDials(Q.W,'');
 WEPutTxtXY(Q.W,0,0,'Blocs reáu:');
 WEPutTxtXY(Q.W,0,1,'Erreur de longueur:');
 WEPutTxtXY(Q.W,0,2,'Erreurs SOH:');
 WEPutTxtXY(Q.W,0,3,'Nombre d''erreur bloc:');
 WEPutTxtXY(Q.W,0,4,'Erreur complÇmentaire:');
 WEPutTxtXY(Q.W,0,5,'Erreur de dÇlai:');
 WEPutTxtXY(Q.W,0,6,'Erreurs de rÇception:');
 If Not(Q.CRCUsed)Then WEPutTxtXY(Q.W,0,7,'Erreurs de somme vÇr.:')
		  Else WEPutTxtXY(Q.W,0,7,'Erreurs de CRC:');
 WEPutTxtXY(Q.W,0,8,'Temps tÇlÇchargement:');
 WEPutTxtXY(Q.W,0,9,'Dernier message:');
End;

Procedure PLInitSendScr;Begin
 WEInit(Q.W,Q.TX,Q.TY,Q.TX+45,Q.TY+11);
 WEPushWn(Q.W);
 WEPutWnKrDials(Q.W,'');
 WEPutTxtXY(Q.W,0,0,'Blocs Ö envoyer:'+IntToStr(Q.Blocks2Send));
 WEPutTxtXY(Q.W,35,0,IntToStr(Q.Blocks2Send shr 3)+'Ko');
 WEPutTxtXY(Q.W,0,2,'Approx. transfer time:'+TimeString(Q.Time2Send,Military));
 WEPutTxtXY(Q.W,0,4,'Envoie du bloc:');
 WEPutTxtXY(Q.W,0,5,'Erreurs:');
 WEPutTxtXY(Q.W,0,6,'Temps restant:'+TimeString(Q.Time2Send,Military));
 WEPutTxtXY(Q.W,0,8,'êtat du dernier message:');
End;

Procedure PLUpdateXmodemSendScr;Begin
 WEPutTxtXY(Q.W,25,0,IntToStr(Q.Base.SectorCount));
 WEPutTxtXY(Q.W,35,25,IntToStr(Q.Base.SectorCount shr 3)+'K');
 WEPutTxtXY(Q.W,25,1,IntToStr(Q.Base.SendErrors));
End;

Function FindProtocol(Protocol:Byte;Var Data:DataProtocolRec):Boolean;Near;Begin
 FindProtocol:=True;
 DBOpenServerName(ChantalServer,'CHANTAL:/Modem/Protocol.Dat');
 DBFirst(ChantalServer);
 While Not DBEOF(ChantalServer)do Begin
  DBReadRec(ChantalServer,Data);
  If(Data.ID=Protocol)Then Exit;
 End;
 FindProtocol:=False;
End;

Function GetProtocolName(Protocol:Byte):String;Near;
Var
 Data:DataProtocolRec;
Begin
 If FindProtocol(Protocol,Data)Then GetProtocolName:=Data.Name
                               Else GetProtocolName:='';
End;

Procedure PLPutBatchWn;
Var
 BatchTitle,Direction:String;
Begin
 If(Q.SendingFiles)Then Direction:='envoye'
                   Else Direction:='reáois';
 BatchTitle:='Fichier Batch '+Direction+' en utilisant '+GetProtocolName(Q.TransferProtocol);
 WESetTitle(Q.W,BatchTitle,Q.W.Palette.Title);
End;

Procedure PLChkKbd;Begin
 While(KeyPress)do Begin
  If(ReadKey=kbESC)Then If(KeyPress)Then Begin
   Case(ReadKey)Of
    kbAltR:If Not(Q.SendingFiles)Then Begin
     ClrKbd;
     If(WarningMsgYesNo('Etes-vous vraiment certain que vous voulez aborder la rÇception?')=kbYes)Then Begin
      Q.AltRPressed:=True;Q.StopReceive:=True;
     End;
    End;
    kbAltS:If(Q.SendingFiles)Then Begin
     ClrKbd;
     If(WarningMsgYesNo('Etes-vous vraiment certain que vous voulez abandonner l''envoie?')=kbYes)Then Begin
      Q.Base.AltSPressed:=True;Q.Base.StopSend:=True;
     End;
    End;
   End;
  End
   Else
  If(aXOffReceived)Then ClrXOFFReceived;
 End;
End;

Procedure PLGetXmodemTitles;
Var
 Direction,_TName:String;
Begin
 _TName:=GetProtocolName(Q.TransferProtocol);
 If(Q.SendingFiles)Then Begin
  Direction:='Envoie ';
  Q.MenuLength:=19;
 End
  Else
 Begin
  Direction:='Recoit ';
  Q.MenuLength:=22;
 End;
 If Q.TName=''Then Q.MenuTitle:=Direction+'fichier utilisant '+_TName
	      Else Q.MenuTitle:=Direction+'fichier '+Q.XFileName+' utilisant '+_TName;
 WESetTitle(Q.W,Q.MenuTitle,Q.W.Palette.Title);
End;

Procedure PLSaveComm4Xmodem;Begin
 Q.XmodemBitsSave:=DataBits;
 Q.XmodemParitySave:=Parity;
 If(DataBits<>8)or(Parity<>'N')Then Begin
  Parity:='N';
  DataBits:=8;
  ACResetPort(CommPort,BaudRate,Parity,DataBits,StopBits);
 End;
End;

Procedure PLRestoreComm4Xmodem;Begin
 If(Q.XmodemBitsSave<>8)or(Q.XmodemParitySave<>'N')Then Begin
  Parity:=Q.XmodemParitySave;
  DataBits:=Q.XmodemBitsSave;
  ACResetPort(CommPort,BaudRate,Parity,DataBits,StopBits);
 End;
End;

Procedure PLExtractUploadPathName;
Var
 I:SmallInt;
 UpLoad:String;
Begin
 I:=Length(FilePattern)+1;
 UpLoad:=UpLoadDir;
 Repeat
  Dec(I);
 Until(FilePattern[I]in[':','\'])or(I=1);
 If I>1Then Upload:=Left(FilePattern,I)
  Else
 Begin
  Upload:=GetCurrentDir;
  If IoResult<>0Then Upload:='';
 End;
 FilePattern:=SetPath4AddFile(Upload)+FilePattern;
End;

Procedure PLEndBatchTransfer;Begin End;

Procedure PLAsyncSendDLEChar;
Const
 DLEChars:Set of Char=[^P,^Q,^S,^V];
Begin
 If(Q.DoWXModem)Then Begin
  If(C in DLEChars)Then Begin
   ACSendDLE;
   C:=Char(Byte(C)xor 64)
  End;
 End;
 ACSend(C);
End;

Procedure PLPutSendError(Var Q:Prots;ErrText:String;DisplayBlock:Boolean);Near;Begin
 If(DisplayBlock)Then
  AddStr(ErrText,' au/apräs bloc '+BasicStr(Omega(Q.Base.SectorCount-1,0)));
 WEPutTxtXY(Q.W,25,8,ErrText);
 WEClrEol(Q.W);
End;

Procedure PLXmodemWait4Ch(Var Q:Prots;WaitTime:Integer;Var Ch:Integer);Near;
Var
 ITime:SmallInt;
Begin
 ITime:=0;
 Repeat
  Inc(ITime);
  ACReceiveWithTimeout(1000,Ch);
  PLChkKbd(Q);
 Until(Ch<>TimeOut)or(ITime>=WaitTime)or(Q.Base.StopSend);
End;

Procedure PLSendXmodemFile;
Label 1;
Const
 BadThreshhold=6;
 SOHTries=5;
 NAKCh=^U;
 WXmodemWindow=4;
 SeaLinkWindow=6;
Var
 I,L,Tries,Checksum,Crc,Ch,NRead,MaxTries,ITime,TransferTime,BadSectors:SmallInt;
 ACKWindow,ACKSector,MaxACKWindow,MaxWindowSize,MaxWindowSize1,GoodSectors:SmallInt;
 KbdCh,HeaderCh,NewHeaderCh:Char;
 EOFXFile,SaveXonXoff:Boolean;
 RFileSize,XFileSize:LongInt;
 EffectiveRate:Real;
 SendingTitle:String;
 SCps:String[20];

 Procedure DoInitialHandshake;Begin
  WEPutTxtXY(Q.W,25,8,'Attend pour NAK/C/G/W --- ');
  WEClrEol(Q.W);
  MaxWindowSize:=0; MaxWindowSize1:=1;
  Repeat
   PLXmodemWait4Ch(Q,Q.XmodemBlockWait,Ch);
   If(Ch=caCAN)Then PLXmodemWait4Ch(Q,Q.XmodemACKWait,Ch);
   Inc(Tries);
   Q.Base.StopSend:=Q.Base.StopSend or Not(ACCarrierDetect);
  Until(Tries>SOHTries)or(Ch in[caNAK,Byte('C'),Byte('G'),Byte('W'),caCAN])or(Q.Base.StopSend);
  If(Ch=TimeOut)or(Tries>SOHTries)or(Ch=caCAN)Then Begin
   WEPutTxtXY(Q.W,25,8,'Pas de rÇception');
   WEClrEol(Q.W);
   Q.Base.StopSend:=True;
  End
   Else
  Case(Ch)of
   caNAK,Byte('C'):UseCrc:=True;
   Byte('G'):Begin
    UseCrc:=True;
    Q.DoACKs:=No;
    AsyncDoXonXoff:=True;
   End;
   Byte('W'):Begin
    UseCrc:=True;
    Q.DoWXModem:=True;
    AsyncDoXonXoff:=True;
    MaxACKWindow:=WXmodemWindow;
    MaxWindowSize:=WXmodemWindow;
    MaxWindowSize1:=Succ(MaxWindowSize);
   End;
  End;
  If Not(Q.Base.StopSend)Then Begin
   WEPutTxtXY(Q.W,25,8,'Reáoit ');
   Case Char(Ch)of
    'C','G','W':WEPutTxt(Q.W,Chr(Ch));
    NAKCh:WEPutTxt(Q.W,'NAK');
   End;
   WEClrEol(Q.W);
  End;
 End;

 Procedure HandleSectorACKNAK(Var Ch:SmallInt);
 Var
  ACKCh:SmallInt;
  CompCh:Chr;
 Begin
  Ch:=caACK;
  If(Q.DoWXModem)or(Q.DoSeaLink)Then If(ACKWindow<MaxACKWindow)Then
  If(aBufHead=aBufTail)Then Exit;
  PLXmodemWait4Ch(Q,Q.XmodemAckWait,Ch);
  If(Ch=caCAN)Then Begin
   PLXmodemWait4Ch(Q,Q.XmodemAckWait,Ch);
   If(Ch=caCAN)Then Exit;
  End;
  ACKSector:=Q.Base.SectorNumber;
  If(Q.DoWXModem or Q.DoSeaLink)Then Begin
   If(Ch=caACK)or(Ch=caNAK)Then Begin
    PLXModemWait4Ch(Q,Q.XModemAckWait,ACKCh);
    If(Q.DoWXModem)Then If(ACKCh>Pred(MaxWindowSize))Then Ch:=caACK
     Else
    Begin
     ACKSector:=ACKCh and 3;
     ACKWindow:=(Q.Base.SectorNumber and 3)-ACKSector;
     If ACKWindow<0Then Inc(ACKWindow,MaxWindowSize);
    End
     Else
    If(Q.DoSeaLink)Then Begin
     If ACReceive(CompCh)Then If Byte(CompCh)+ACKCh=255Then Begin
      ACKSector:=ACKCh mod MaxWindowSize1;
      ACKWindow:=(Q.Base.SectorNumber mod MaxWindowSize1)-ACKSector;
      If ACKWindow<0Then Inc(ACKWindow,MaxWindowSize);
     End
      Else
     MaxACKWindow:=0
      Else
     MaxACKWindow:=0;
    End;
   End;
  End;
  If(Ch<>caACK)Then Begin
   PLPutSendError(Q,'Pas d''ACK',True);
   Inc(Q.Base.SendErrors);
  End;
 End;

 Procedure SendXmodemBlock;
 Var
  I:SmallInt;
  SendState:Byte;
 Begin
  Tries:=0;
  SendState:=Byte(Q.CRCUsed);
  Repeat
   If(Q.DoWXModem)Then ACSendSYN;
   PLAsyncSendDLEChar(Q,HeaderCh);
   PLAsyncSendDLEChar(Q,Chr(Q.Base.SectorNumber));
   PLAsyncSendDLEChar(Q,Chr(255-Q.Base.SectorNumber));
   If SendState<8Then For I:=1to(Q.SectorSize)do PLAsyncSendDLEChar(Q,Q.SectorData[I]);
   Case(SendState)of
     0,2:Begin
      CheckSum:=0;
      For I:=1to Q.SectorSize do CheckSum:=(CheckSum+Byte(Q.SectorData[I]))and$FF;
      PLAsyncSendDLEChar(Q,Chr(CheckSum));
     End;
     1,3:Begin
      Crc:=0;
      For I:=1to Q.SectorSize do Begin
       Crc:=Swap(Crc)xor Byte(Q.SectorData[I]);
       Crc:=Crc xor(Lo(Crc)shr 4);
       Crc:=Crc xor(Swap(Lo(Crc))shl 4)xor(Lo(Crc)shl 5);
      End;
      PLAsyncSendDLEChar(Q,Chr(Hi(CRC)));
      PLAsyncSendDLEChar(Q,Chr(CRC));
     End;
     4,6:PLAsyncSendDLEChar(Q,Chr(CheckSum));
     5,7:Begin
      PLAsyncSendDLEChar(Q,Chr(Hi(Crc)));
      PLAsyncSendDLEChar(Q,Chr(Crc));
     End;
   End;
   If Not(Q.DoWXModem or Q.DoSEALink or Not Q.DoAcks)Then ACPurgeBuf;
   SendState:=SendState or 4;
   Inc(Tries);
   If(Q.DoAcks)Then HandleSectorACKNAK(Ch)Else Ch:=caACK;
   PLUpdateXmodemSendScr(Q);
  Until(Ch=caACK)or(Ch=caCAN)or(Tries>MaxTries)or(Q.Base.StopSend)or
       (ACCarrierDrop)or(Q.DoWXModem)or(Q.DoSEALink);
  Inc(ACKWindow);
  Q.Base.StopSend:=Q.Base.StopSend or ACCarrierDrop;
 End;

 Procedure SendTelinkHeader;
 Var
  SaveSize:SmallInt;
  SaveCRC:Boolean;
 Begin
  MaxTries:=3;
  SaveSize:=Q.SectorSize;
  SaveCRC:=Q.CRCUsed;
  Q.SectorSize:=128;
  Q.CRCUsed:=False;
  HeaderCh:=Char(caSYN);
  SendXmodemBlock;
  Q.SectorSize:=SaveSize;
  Q.CRCUsed:=SaveCRC;
  MaxTries:=Q.XmodemMaxErrors;
  If(Ch=caACK)Then PLPutSendError(Q,'Telink accepte l''entàte.',False)
	      Else PLPutSendError(Q,'Telink n''accepte pas l''entàte.',False);
 End;

 Procedure SendYmodemHeader;
 Var
  SaveSize:SmallInt;
  SaveACK:Boolean;
 Begin
  MaxTries:=3;
  SaveSize:=Q.SectorSize;
  Q.SectorSize:=128;
  HeaderCh:=Char(caSOH);
  SaveACK:=Q.DoACKs;
  Q.DoACKs:=True;
  SendXmodemBlock;
  Q.SectorSize:=SaveSize;
  Q.DoACKs:=SaveACK;
  MaxTries:=Q.XmodemMaxErrors;
  If(Ch=caACK)Then PLPutSendError(Q,'Ymodem accepte l''entàte.',False)
	      Else PLPutSendError(Q,'Ymodem n''accepte pas l''entàte.',False);
 End;

Begin
 Q.CrcUsed:=UseCRC;
 Q.XFileName:=UploadDir+Q.XFileName;
 PLGetXmodemTitles(Q);
 Q.XHandle:=FileOpen(Q.XFileName,fmRead);
 If(Q.XHandle=errHdl)Then Begin
  WEPutLastBar('Je ne peux pas ouvrir le fichier Ö envoyer, transfäre annulÇ.');
  PLCancelTransfer(Q);
  Exit;
 End;
 XFileSize:=FileSize(Q.XHandle);
 RFileSize:=XFileSize;
 MaxTries:=Q.XmodemMaxErrors;
 Q.Blocks2Send:=Round((XFileSize/128)+0.49);
 Q.SavedTime2Send:=Round(Q.Blocks2Send*(1800.0/BaudRate));
 Q.Time2Send:=Q.SavedTime2Send;
 PLInitSendScr(Q);
 SCps:=IntToStr(RFileSize);
 HeaderCh:=Char(caSOH);
 If Q.Default.SectorSize=-1Then Begin
  If(Q.DownSizeYmodem)and(XFileSize<1024)Then Begin
   Q.SectorSize:=128;
   PLPutSendError(Q,'êchange en bloc de 128 octets',False);
  End
   Else
  Begin
   Q.SectorSize:=1024;
   HeaderCh:=Char(caSTX)
  End;
 End
  Else
 Q.SectorSize:=Q.Default.SectorSize;
 NewHeaderCh:=HeaderCh;
 FillClr(Q.Base,SizeOf(Q.Base));
 Q.StartTime:=TimeOfDay;
 EofXFile:=False;
 Tries:=0;
 Q.DoACKs:=True;
 Q.DoWXModem:=False;
 Q.DoSeaLink:=False;
 ACKWindow:=0;
 MaxACKWindow:=0;
 ACPurgeBuf;
 SaveXonXoff:=AsyncDoXonXoff;
 AsyncDoXonXoff:=(HonorXoffYmodem in Q.Config)and(Q.Default.DoXonXoff);
 DoInitialHandshake;
 If Not(Q.Base.StopSend)Then Begin
  If(Q.Default.Header)and(Q.UseYmodemHeader)Then Begin
   SendYmodemHeader;
   Q.CRCUsed:=True;
   DoInitialHandshake;
  End
   Else
  If(Q.TransferProtocol=trsTelink)Then Begin
   SendTelinkHeader;
   Q.CrcUsed:=True;
  End;
 End;
 Repeat
  PLChkKbd(Q);
  Q.Base.StopSend:=Q.Base.StopSend or Not ACCarrierDetect;
  If Not(Q.Base.StopSend)Then Begin
   HeaderCh:=NewHeaderCh;
   NRead:=_GetRec(Q.XHandle,Q.SectorSize,Q.SectorData);
   If SysErr<>0Then Begin
    PLPutSendError(Q,'Impossible de lire les donnÇes d''informations du fichier',True);
    Q.Base.StopSend:=True;
   End
    Else
   If NRead<=0Then EOFXFile:=True
    Else
   Begin
    If(NRead<Q.SectorSize)Then FillClr(Q.SectorData[NRead+1],Q.SectorSize-NRead+1);
    Inc(Q.Base.SectorNumber);
    Inc(Q.Base.SectorCount,Q.SectorSize shr 7);
    SendXmodemBlock;
    If(Q.DoWXModem)or(Q.DoSeaLink)Then If(Ch=caNAK)Then Begin
     Dec(Q.Base.SectorNumber,ACKWindow);
     L:=(ACKWindow+1)*Q.SectorSize;
     SetFilePos(Q.XHandle,GetFilePos(Q.XHandle)-L);
     EofXFile:=No;
     Inc(XFileSize,L);
     Goto 1;
    End;
    If(Ch=caACK)Then Begin
     Q.Time2Send:=Round(Q.SavedTime2Send*(1.0-Q.Base.SectorCount/Q.Blocks2Send));
     If Q.Time2Send<0Then Q.Time2Send:=0;
     Inc(GoodSectors);
    End
     Else
    Begin
     Inc(BadSectors);
     If(BadThreshhold*BadSectors>GoodSectors)and(Q.DownsizeYmodem)and(Q.SectorSize=1024)Then
     Begin
      NewHeaderCh:=Char(caSOH); Q.SectorSize:=128;
      PLPutSendError(Q,'êchange en bloc de 128 octets',False);
     End;
    End;
    Dec(XFileSize,NRead);
    If(XFileSize<1024)and(Q.DownSizeYmodem)and(Q.SectorSize=1024)Then Begin
     NewHeaderCh:=Char(caSOH); Q.SectorSize:=128;
     PLPutSendError(Q,'êchange en bloc de 128 octets',False);
    End;
   End;
  End;
1:WEPutTxtXY(Q.W,25,7,TimeString(Q.Time2Send,Military));
 Until(EOFXFile)or(Tries=MaxTries)or(Ch=caCAN)or(Q.Base.StopSend);
 If(Q.DoWXModem)or(Q.DoSeaLink)Then Begin
  MaxACKWindow:=0;
  While(ACKWindow>0)and(Ch<>caCAN)and(Ch<>TimeOut)do HandleSectorACKNAK(Ch);
 End;
 If(Q.Base.StopSend)Then If(ACCarrierDetect)Then PLCancelTransfer(Q);
 If(Tries>=MaxTries)Then PLPutSendError(Q,'Pas d''ACK en rÇception.',False)Else
 IF(Ch=caCAN)Then PLPutSendError(Q,'Recoie une annulation de transmission.',False)Else
 If(Q.Base.AltSPressed)Then PLPutSendError(Q,'Alt+S enfoncÇ, envoie l''annulation.',False)Else
 If Not(Q.Base.StopSend)Then Begin
  If Not(Q.DoAcks)Then Begin
   WEPutTxtXY(Q.W,25,8,'Attend que le tampon de sortie soit vide');
   WEClrEol(Q.W);
   While(aOBufUsed>128)and(Not Q.Base.StopSend)do Begin
    PLChkKbd(Q);
    Q.Base.StopSend:=Q.Base.StopSend or Not ACCarrierDetect;
   End;
  End;
  WEPutTxtXY(Q.W,25,8,'Attend pour l''ACK de l''EOT');
  WEClrEol(Q.W);
  Tries:=0;
  Q.DoACKs:=True;
  Repeat
   ACSendEOT;
   Inc(Tries);
   PLXmodemWait4Ch(Q,Q.XmodemAckWait,Ch);
   If(Ch=caCAN)Then PLXmodemWait4Ch(Q,Q.XmodemAckWait,Ch);
   If Tries>1Then Inc(Q.Base.SendErrors);
   PLUpdateXmodemSendScr(Q);
   WEPutTxtXY(Q.W,25,6,TimeString(Q.Time2Send,Military));
   PLChkKbd(Q);
  Until(Ch=caACK)or(Tries=MaxTries)or(Ch=caCAN)or(Q.Base.StopSend);
  If(Tries=MaxTries)Then PLPutSendError(Q,'Pas de ACK dans le EOT (fin de transmission)',False)Else
  If(Ch=caCAN)Then PLPutSendError(Q,'Reáois une annulation de transmission.',False)Else
  If(Q.Base.AltSPressed)or(Q.Base.StopSend)Then PLPutSendError(Q,'Alt+S enfoncÇ, envoie l''annulation.',False)
   Else
  Begin
   WEPutTxtXY(Q.W,25,8,'Fin de transmission, envoi complet.');
   WEClrEol(Q.W);
   Q.EndTime:=TimeOfDay;
   If(Q.EndTime<Q.StartTime)Then Inc(Q.EndTime,86400);
   EffectiveRate:=Q.EndTime-Q.StartTime;
   If EffectiveRate=0.0Then EffectiveRate:=1.0;
   EffectiveRate:=RFileSize/EffectiveRate;
   WEPutTxtXY(Q.W,25,8,'Taux de transfert '+RealStr2(EffectiveRate,6,1)+' CPS');
   WEClrEol(Q.W);
  End;
 End;
 If(Q.Base.StopSend)Then If(ACCarrierDrop)Then PLPutSendError(Q,'Communication coupÇ.',False);
 FileClose(Q.XHandle);
 AsyncDoXonXoff:=SaveXonXoff;
End;

Function MoveString(Const Name:String;Var Buffer):Word;Near;Begin
 MoveLeft(Name[1],Buffer,Length(Name));
 MoveString:=Length(Name);
End;

Procedure PLMakeTelinkHeader(Var Q:Prots;FileEntry:SearchRec);Near;Begin
 FillClr(Q.SectorData[1],0);
 MoveLeft(FileEntry.Size,Q.SectorData[1],4);
 MoveLeft(FileEntry.Time,Q.SectorData[5],4);
 FillSpc(Q.SectorData[9],16);
 MoveString(FileEntry.Name,Q.SectorData[9]);
 MoveString('MONSTERBOOK     ',Q.SectorData[26]);
End;

Procedure PLCheckTheKeyBoard(Var Q:Prots);Near;Begin
 PLChkKbd(Q);
 If(Q.Base.StopSend)Then Begin
  {If Not(Q.DisplayStatus)Then PLPutBatchWn(Q);}
  ErrMsgOk('Alt+S enfoncÇ, transfäre abandonnÇ.');
 End;
End;

Procedure PLPerformUpload(Var Q:Prots;Const FileEntry:SearchRec;UseCRC:Boolean);Near;
Var
 S:String;
Begin
 S:='Envoi: '+Q.XFileName;
 DialogMsgOk(S);
 WriteLog(S);
 If(Q.TransferProtocol=trsTelink)Then PLMakeTelinkHeader(Q,FileEntry);
 If Not(Q.Base.StopSend)Then PLSendXmodemFile(Q,UseCRC);
End;

Procedure PLSendModem7File(Var Q:Prots;UseCRC:Boolean);
Var
 IntCh:Integer;
 Ch:Char;
 CheckSum:Integer;
 EndFName:Boolean;
 I,J:SmallInt;
 FileEntry:SearchRec;
 AckOK,OKFile:Boolean;
 SFileName:Array[1..11]of Char;
 FilePattern:String;

 Procedure GetModem7FileName(Var OkFile:Boolean);
 Var
  I,J:SmallInt;
 Begin
  I:=1;J:=0;
  SFileName:='           ';
  Q.XFileName:='';
  While(I<=Length(FileEntry.Name))do Begin
   Ch:=FileEntry.Name[I];
   If Ch='.'Then J:=8
    Else
   Begin
    Inc(J);
    SFileName[J]:=Ch;
   End;
   IncStr(Q.XFileName,Ch);Inc(I);
  End;
  CheckSum:=0;
  For I:=1to 11do CheckSum:=(CheckSum+Byte(SFileName[I]))and$FF;
  CheckSum:=(CheckSum+caSub)and$FF;
  OkFile:=FileEntry.Attr.Value and(faVolumeID+faDir)=0;
{  If(Q.HostMode)Then If Q.Privilege<>'S'Then
    OkFile:=OkFile and(TAScanXferList(FileName)>0);}
 End;

 Procedure Wait4Nak;Begin
  I:=0;
  Repeat
   ACReceiveWithTimeout(1,IntCh);
   PLCheckTheKeyBoard(Q);
   Inc(I);
  Until(IntCh=caNAK)or(I>=60)or Q.Base.StopSend;
  If(IntCh<>caNAK)Then Begin
   Q.Base.StopSend:=True;
   WriteLn('NAK pour dÇbut le nom de fichier non reáu;');
   WriteLn('RÇception ASCII ',IntCh);
  End
   Else
  ACSend(Chr(caACK));
  ACPurgeBuf;
 End;

 Procedure SendFileName;
 Var
  I,J:SmallInt;
 Begin
  I:=0;
  While(Not Q.Base.StopSend)and(I<11)do Begin
   Inc(I);ACSend(SFileName[I]);J:=0;
   Repeat
    ACReceiveWithTimeout(1,IntCh);
    PLCheckTheKeyBoard(Q);
    Inc(J);
   Until(IntCh=caACK)or(J>=10);
   AckOk:=(IntCh=caACK);
   Q.Base.StopSend:=Q.Base.StopSend or Not(AckOk);
  End;
  If Not(Q.Base.StopSend)Then Begin
   ACSend(Chr(caSub));
   J:=0;
   Repeat
    ACReceiveWithTimeout(1,IntCh);
    PLCheckTheKeyBoard(Q);
    Inc(J);
   Until(IntCh=CheckSum)or(J>=10);
   If(IntCh<>CheckSum)Then Begin
    Q.Base.StopSend:=True;
    WriteLn('Sommaire de vÇrification de la rÇception du nom est incorrecte;');
    WriteLn('Sommaire de vÇrification correcte = ',CheckSum,', reáu ',IntCh);
   End
    Else
   ACSend(Chr(caACK));
  End;
 End;

Begin
 PLPutBatchWn(Q);
 UseCRC:=UseCRC and(Q.TransferProtocol<>trsModem7Chk);
 FilePattern:=Q.XFileName;
 PLExtractUploadPathName(FilePattern);
 Q.Base.StopSend:=Not FileExist(FilePattern);
 If(Q.Base.StopSend)Then __FileNotFound(FilePattern);
 While Not(Q.Base.StopSend)do Begin
  GetModem7FileName(OkFile);
  If(OkFile)Then Begin
   If Not(Q.Base.StopSend)Then Wait4Nak;
   If Not(Q.Base.StopSend)Then SendFileName;
   If Not(Q.Base.StopSend)Then PLPerformUpload(Q,FileEntry,UseCRC);
  End;
  FindNext(FileEntry);
  Q.Base.StopSend:=Q.Base.StopSend or(SysErr<>0);
 End;
 ACSend(Chr(caEOT));
 ACReceiveWithTimeOut(5,IntCh);
 PLPutBatchWn(Q);
 If(IntCh=caACK)Then Begin
  ErrMsgOk('Fin de transmission ACK du systäme hìte.');
  WriteLog('Fin de transmission ACK du systäme hìte.');
 End;
 PLEndBatchTransfer(Q);
End;

Procedure PLSendYmodemFile(Var Q:Prots;BatchMode:Boolean);
Var
 FilePattern:String;
 SFileName:Array[1..11]Of Char;
 IntCh:SmallInt;
 Ch:Char;
 CheckSum:SmallInt;
 EndFName:Boolean;
 I,J:SmallInt;
 FileEntry:SearchRec;
 AckOK,OkFile:Boolean;

 Procedure MakeYmodemHeader;
 Var
  I,J,CRC:SmallInt;
  ACKOk:Boolean;
  IntCh:SmallInt;
  Fs1,Fs2,SFileSize:LongInt;
  OkFile:Boolean;
  DTRec:DateTime;
  Date:LongInt;
  RemO,Quot:LongInt;
  OctD:String[20];
 Begin
  FillClr(Q.SectorData[1],130);
  I:=MoveString(StrDn(UploadDir+Q.XFileName),Q.SectorData[1])+2;
  Inc(I,MoveString(IntToStr(FileEntry.Size),Q.SectorData[I]));
  UnPackTime(FileEntry.Time,DTRec);
  With(DTRec)do SetUnixStyleDate(Date,Year,Month,Day,Hour,Min,Sec);
  OctD:='';
  Repeat
   Quot:=Date shr 3;
   Remo:=Date-8*Quot;
   OctD:=Chr(Byte(Remo)+Byte('0'))+OctD;
   Date:=Quot;
  Until Date<=0;
  Q.SectorData[I]:=' ';
  MoveString(OctD,Q.SectorData[I+1]);
 End;

(* Procedure MakeSEALinkHeader(FileEntry:SearchRec);
 Var I,J,L,CheckSum:Int;ACKOk:Bool;IntCh:Int;DTRec:DateTime;
 C:String[1];Date:Long;Begin{MakeSEALinkHeader}
  FillClr(Q.SectorData[1],130);
  MoveLeft(FileEntry.Size,Q.SectorData[1],4);
  UnPackTime(FileEntry.Time,DTRec);
  With DTRec do SetUnixStyleDate(Date,Year,Month,Day,Hour,Min,Sec);
  MoveLeft(Date,Q.SectorData[5],4);
  J:=1;
  For I:=1to Length(FileEntry.Name)do Begin
   Q.SectorData[J+8]:=FileEntry.Name[J];Inc(J)
  End;
  For I:=J to 16do Q.SectorData[I+8]:=' ';
  For I:=1to 15do Begin C:=Copy('MONSTERBOOK    ',I,1);Q.SectorData[I+25]:=C[1]End;
 END;*)

 Procedure GetYmodemFileName(Var OkFile:Boolean);
 Var
  I:Integer;
 Begin
  Q.XFileName:=FileEntry.Name;
  OkFile:=(FileEntry.Attr.Value and(faVolumeID+faDir)=0);
{  If(Q.HostMode)Then If Q.Privilege<>'S'Then
    OkFile:=OkFile and(ScanXferList(FileName)>0);}
 End;

 Procedure PerformUpload;Begin
  If(BatchMode)Then Begin
   WriteLn('Envoi: '+Q.XFileName);
  {WriteLog('Envoi: '+Q.XFileName,No,No);}
  End;
  PLSendXmodemFile(Q,True);
 End;

 Procedure SendNullFileName;Begin
  Repeat
   ACReceiveWithTimeout(1,IntCh)
  Until IntCh=TimeOut;
  ACSendStr(Chr(caSOH)+#0#255);
  ACSendStr(MultChr(#0,130));
  PLPutBatchWn(Q);
  WriteLn;
  WriteLn('Envoie d''un nom de fichier nulle pour terminer transfäre en "Batch" ...');
  WriteLog('Envoie d''un nom de fichier nulle pour terminer transfäre en "Batch" ...');
  ACReceiveWithTimeOut(10,IntCh);
  If(IntCh=caACK)Then Begin
   WriteLn;
   WriteLn('Signal de fin de queue de transfert ACK du systäme hìtre.');
{   WriteLog('Signal de fin de queue de transfert ACK du systäme hìtre.',Ya,No);}
  End;
 End;

Begin
 If(BatchMode)Then PLPutBatchWn(Q);
 FilePattern:=Q.XFileName;
 PLExtractUploadPathName(FilePattern);
 Q.Base.StopSend:=Not FileExist(FilePattern);
 If(Q.Base.StopSend)Then If(BatchMode)Then __FileNotFound(FilePattern);
 While Not(Q.Base.StopSend)do Begin
  GetYmodemFileName(OKFile);
  If(OkFile)Then Begin
   If Not(Q.Base.StopSend)Then
{  If(TransferProtocol=trsSeaLink)Then MakeSEAlinkHeader(FileEntry)Else}
   If(BatchMode or Q.UseYmodemHeader)Then MakeYmodemHeader;
   If Not(Q.Base.StopSend)Then PerformUpload;
  End;
  FindNext(FileEntry);
  Q.Base.StopSend:=Q.Base.StopSend or(Not BatchMode)or(SysErr<>0);
 End;
 If(BatchMode)Then Begin
  SendNullFileName;
  PLEndBatchTransfer(Q);
 End;
End;

Procedure PLDoXmodemUpload(Var Q:Prots;TransProtocol:Byte);Begin
 Q.TransferProtocol:=TransProtocol;
 PLSaveComm4Xmodem(Q);
 Q.SendingFiles:=True;
 Case(Q.TransferProtocol)of
  trsXmodemChk:PLSendXmodemFile(Q,False);
  trsXmodemCRC:PLSendXmodemFile(Q,True);
  trsTelink,trsModem7CRC:PLSendModem7File(Q,True);
  trsModem7Chk:PLSendModem7File(Q,False);
{SeaLink,}trsYmodemG,trsYmodemBatch:PLSendYmodemFile(Q,True);
  trsXmodem1K,trsXmodem1KG:PLSendYmodemFile(Q,No);
 End;
 PLRestoreComm4Xmodem(Q);
End;

Procedure PLReceiveXmodemFile(Var Q:Prots;UseCRC:Boolean);Near;
Const
 XOFFDelay=250;
 WXmodemFlush=4;
 SEALinkFlush=6;
Var
 SectorCount:Integer;
 SectorComp,SectorPrev:Byte;
 I,ErrorCount,Ch:Integer;
 ErrorFlag:Boolean;
 InitialCh,SectorLength:Integer;
 SectorPrev1:Byte;
 BlockLErrors,SOHErrors,BlockNErrors,CompleErrors,TimeOutErrors:Integer;
 ResendErrors,CRCErrors:Integer;
 EffectiveRate:Real;
 CRCTries,WXMTries,SOHTime:Integer;
 RFileSize,RFileDate:LongInt;
 FileDate,FileTime:Word;
 RFileName:String;
 TruncateFile,RFileOpen:Boolean;
 OKTransfer,Block0:Boolean;
 RFileSize2:Long;
 WriteCount,Err:Integer;
 WriteBuffer:^TByte;
 BufferPos:Integer;
 BufferLength:Wd;
 CRCUsed2,LongBuffer:Boolean;
 KbdCh:Char;FullFileName:String;
 DupBlock:Boolean;
 BSFlag:Bool;WCount:Integer;
 BlockStartSet:Set of ^A..^Z;
 SVal:String[10];
 FlushCount:Integer;
 SaveXonXoff:Boolean;
 ErrMess:String;
 GFailure,SaveXonOv:Boolean;
 SCps:String[20];
 AttendedMode:Boolean;

 Procedure OpenReceivingFile;
 Var
  Err:Integer;
  B:Bool;
 Begin
  If Q.XFileName=''Then
  If(AttendedMode)Then WinInp(40,'RÇception','Entrer le nom du fichier Ö recevoir:',CurrKrs.Dialog.Window,False,Q.XFileName)
   Else
  Begin
   ErrMsgOk('Pas de fichier reáu du systäme hìte, rÇception annulÇe.');
{    WriteLog('Pas de fichier reáu du systäme hìte, rÇception annulÇe.');}
   ErrorFlag:=True;Q.StopReceive:=True;
  End;
  If Q.XFileName<>''Then Begin
   FullFileName:=DownloadDir+Q.XFileName;
   If Not(RFileOpen)Then Begin
    Q.XHandle:=FileCreate(FullFileName);
    If(Q.XHandle<>errHdl)Then Begin
     __CreateError(FullFileName);
     Q.StopReceive:=True;
     ErrorFlag:=True;
    End
     Else
    RFileOpen:=True;
   End;
   If(RfileOpen)Then WriteLog('RÇception du fichier '+FullFileName);
  End;
 End;

 Procedure UpdateXmodemReceiveDisplay;Begin
  WEPutTxtXY(Q.W,25,1,IntToStr(SectorCount));
  WEPutTxtXY(Q.W,35,1,IntToStr(SectorCount shr 3)+'Ko');
  WEPutTxtXY(Q.W,25,2,IntToStr(BlockLErrors));
  WEPutTxtXY(Q.W,25,3,IntToStr(SOHErrors));
  WEPutTxtXY(Q.W,25,4,IntToStr(BlockNErrors));
  WEPutTxtXY(Q.W,25,5,IntToStr(CompleErrors));
  WEPutTxtXY(Q.W,25,6,IntToStr(TimeOutErrors));
  WEPutTxtXY(Q.W,25,7,IntToStr(ResendErrors));
  WEPutTxtXY(Q.W,25,8,IntToStr(CRCErrors));
  If(Q.DisplayTime)Then WEPutTxtXY(Q.W,25,9,TimeString(Q.Time2Send,Military));
 End;

 Procedure PutReceiveErr(ErrText:String);Begin
  {If Not(DisplayStatus)Then FlipDisplayStatus;}
  ErrMess:=ErrText+' around block '+IntToStr(SectorCount);
  WEPutTxtXY(Q.W,25,10,ErrMess);
  WEClrEol(Q.W);
{   WriteLog(ErrMess);}
  ErrorFlag:=True;
 End;

 Procedure WXModemReceiveWithTimeOut(Var Ch:Integer);
 Const
  SpecialChars:Set Of Byte=[caDLE,caSYN,caXON,caXOFF];
 Begin
  ACReceiveWithTimeOut(Q.XmodemCharWait,Ch);
  If(Q.DoWXModem)Then
   If(Ch=caDLE)Then Begin
    If(Ch in SpecialChars)Then Begin
     ACReceiveWithTimeOut(Q.XmodemCharWait,Ch);
     If(Ch<>TimeOut)Then Ch:=Ch XOR 64;
    End
   End
    Else
   If(Ch=caSYN)Then Ch:=TimeOut;
 End;

 Function ReceiveXmodemSector(CRCUsed:Boolean):Boolean;
 Var
  CRC,Checksum,I:Integer;
  ErrorFl:Byte;
  ReceiveOK:Boolean;
 Begin
  ReceiveOk:=ACLnErr(ErrorFl);
  ReceiveXmodemSector:=No;
  ReceiveOK:=No;Checksum:=0;CRC:=0;
  For I:=1to SectorLength do Begin
   ACReceiveWithTimeOut(Q.XmodemCharWait,Ch);
   If(Ch=TimeOut)Then Begin
    PutReceiveErr('Erreur de longueur de bloque');
    Inc(BlockLErrors);
    Exit;
   End;
   Q.SectorData[I]:=Char(Ch);
   If(CRCUsed)Then Begin
    CRC:=SWAP(CRC)XOR Byte(Ch);
    CRC:=CRC xor(Lo(CRC)shr 4);
    CRC:=CRC xor(Swap(Lo(CRC))shl 4)xor(Lo(CRC)shl 5);
   End
    Else
   Checksum:=(Checksum+Ch)and$FF;
  End;
  If(CRCUsed)Then Begin
   ACReceiveWithTimeOut(Q.XmodemCharWait,Ch);
   If(Ch<>TimeOut)Then Begin
    CRC:=Swap(CRC)xor Byte(Ch);
    CRC:=CRC xor(Lo(CRC)shr 4);
    CRC:=CRC xor(Swap(Lo(CRC))shl 4)xor(Lo(CRC)shl 5);
    ACReceiveWithTimeOut(Q.XmodemCharWait,Ch);
    If(Ch<>TimeOut)Then Begin
     CRC:=Swap(CRC)xor Byte(Ch);CRC:=CRC xor(Lo(CRC)shr 4);
     CRC:=CRC xor(Swap(Lo(CRC))shl 4)xor(Lo(CRC)shl 5);
     ReceiveOk:=CRC=0;
    End
     Else
    Begin
     PutReceiveErr('Erreur de longueur de bloque');
     Inc(BlockLErrors);
    End
   End
    Else
   Begin
    PutReceiveErr('Erreur de longueur de bloque');
    Inc(BlockLErrors);
   End;
  End
   Else
  Begin
   ACReceiveWithTimeOut(Q.XmodemCharWait,Ch);
   ReceiveOk:=Checksum=Ch;
  End;
  ReceiveXmodemSector:=ReceiveOk and(Not ACLnErr(ErrorFl));
 End;

 Procedure ReceiveTelinkHeader;
 Var
  I:Integer;
  CDate,CTime:String[8];
  Date:Long;
  DTRec:DateTime;
 Begin
  RFileName:='';
  MoveLeft(Q.SectorData[1],RFileSize,SizeOf(Long));
  Q.Blocks2Send:=Long(RFileSize)shr 7;
  If RFileSize and$7F>0Then Inc(Long(Q.Blocks2Send));
  If(Q.TransferProtocol=trsTelink)Then Begin
   FileTime:=Byte(Q.SectorData[6])shl 8or Byte(Q.SectorData[5]);
   FileDate:=Byte(Q.SectorData[8])shl 8or Byte(Q.SectorData[7]);
  End
   Else
  Begin
   Date:=Byte(Q.SectorData[8])shl 8+Byte(Q.SectorData[7]);
   Date:=65536*Date+Byte(Q.SectorData[6])shl 8+Byte(Q.SectorData[5]);
   If Date>0Then With DTRec do Begin
    GetUnixStyleDate(Date,Year,Month,Day,Hour,Min,Sec);
    FileTime:=Hour shl 11or Min shl 5or(Sec shr 1);
    FileDate:=Omega(Year-1980,0)shl 9+Month shl 5+Day;
   End;
  End;
  For I:=9to 24do If Q.SectorData[I]<>#0Then IncStr(RFileName,Q.SectorData[I]);
  RFileName:=Trim(RFileName);
  IF Q.XFileName=''Then If RFileName<>''Then Q.XFileName:=RFileName;
   { Affiche la Fenàtre de Download}
  If(FileDate<>0)and(FileTime<>0)Then BEGIN
   CTime:=CStrTimeDos(DTRec.Hour,DTRec.Min,DTRec.Sec);
   CDate:=CStrDate(Long(FileDate)shl 16);
  End
   Else
  Begin CTime:='';CDate:=''End;
{   DrawMenuFrame( 10, 3, 78, 9, MenuFrameColor, MenuTitleColor,
		   MenuTextColor, '' );
  PibTermWindow( 11, 4, 77, 8 );
  GoToXY( 1 , 1 );
  TextColor( MenuTextColor2 );
  WRITE(' File name            : ');
  TextColor( MenuTextColor );
  WRITE(FileName);
  GoToXY( 1 , 2 );
  TextColor( MenuTextColor2 );
  WRITE(' File Size in bytes   : ');
  TextColor( MenuTextColor );
  WRITE(RFileSize:8);
  GoToXY( 1 , 3 );
  TextColor( MenuTextColor2 );
  WRITE(' File Size in blocks  : ');
  TextColor( MenuTextColor );
  WRITE(BlocksToSend:8);
  GoToXY( 1 , 4 );
  TextColor( MenuTextColor2 );
  WRITE(' File creation time   : ');
  TextColor( MenuTextColor );
  WRITE( CTime );
  GoToXY( 1 , 5 );
  TextColor( MenuTextColor2 );
  WRITE(' File creation date   : ');
  TextColor( MenuTextColor );
  WRITE( CDate );
  PibTermWindow( 11, 11, 77, 21 );}
  If RFileSize>0Then Begin
   Q.DisplayTime:=True;
   Q.Time2Send:=Round(Q.Blocks2Send*(TransTimeVal/BaudRate));
   Q.SavedTime2Send:=Q.Time2Send;
   {If(DisplayStatus)Then} PLInitReceiveScr(Q);
   TruncateFile:=True;
  End;
{  If(DoSeaLink)Then Begin
   If(Q.HostMode)Then
    If Privilege<>'S'Then
     StopReceive:=StopReceive or FileExist(FileName,DownloadDirPath);
     If Length(RFileName)=0Then Begin NullFileName:=Ya;Exit;End;
     If Not(StopReceive)Then OpenReceivingFile;
  End;}
 End;

 Procedure ReceiveYmodemHeader;
 Var
  I,L:Integer;
  CTime,CDate:String[10];
  DTRec:DateTime;
 Begin
  RFileSize:=0;RFileDate:=0;RFileName:='';FileTime:=0;FileDate:=0;I:=0;
  While(Q.SectorData[I]<>ccNul)and(Q.SectorData[I]<>' ')do Begin
   IncStr(RFileName,Q.SectorData[I]);Inc(I);
  End;
  If Length(RFileName)=0Then Begin
   Q.NullFileName:=True;
   Exit;
  End;
  Inc(I);
  While(Q.SectorData[I]<>ccNul)and(Q.SectorData[I]<>' ')do Begin
   RFileSize:=RFileSize*10+Byte(Q.SectorData[I])-Byte('0');
   Inc(I)
  End;
  Inc(I);
  While(Q.SectorData[I]<>ccNul)and(Q.SectorData[I]<>' ')do Begin
   RFileDate:=RFileDate*8+Byte(Q.SectorData[I])-Byte('0');
   Inc(I)
  End;
  If RFileDate>0Then With DTRec do Begin
   GetUnixStyleDate(RFileDate,Year,Month,Day,Hour,Min,Sec);
   FileTime:=Hour shl 11or Min shl 5or(Sec shr 1);
   FileDate:=Omega(Year-1980,0)shl 9+Month shl 5+Day;
   CTime:=CStrTimeDos(Hour,Min,Sec);
   CDate:=CStrDate(Long(FileDate)shl 16);
  End;
{   DrawMenuFrame( 10, 3, 78, 9, MenuFrameColor, MenuTitleColor,
		   MenuTextColor,
		   'Receive file ' + RFileName );
  PibTermWindow( 11, 4, 77, 8 );}
  WEPutTxtXY(Q.W,2,1,'Nom du fichier:        '+RFileName);
  Q.Blocks2Send:=Long(RFileSize)shr 7;
  If RFileSize and$7F>0Then Inc(Long(Q.Blocks2Send));
  If RFileSize>0Then Begin
   WEPutTxtXY(Q.W,2,2,'Taille en octets:      '+Str2(RFileSize,8));
   WEPutTxtXY(Q.W,2,3,'Taille en bloques:     '+Str2(Q.Blocks2Send,8));
  End;
  If FileDate>0Then Begin
   WEPutTxtXY(Q.W,2,4,'Heure de crÇation:     '+CTime);
   WEPutTxtXY(Q.W,2,5,'Date de crÇation:      '+CDate);
  End;
  Q.XFileName:=RFileName;
{   If(Pos( '\' ,Q.XFileName)<>0)or(Pos(':',Q.XFileName)<>0)Then If Not(UseFullPathName)Then Begin
    L:=Length(FileName);I:=L;
    Repeat Dec(I)Until(I=1)or(FileName[I]in['\',':']);
    FileName:=Copy(FileName,Succ(I),L-I);
   End;}
{   PibTermWindow( 11, 11, 77, 21 );}
  If RFileSize>0Then Begin
   Q.DisplayTime:=True;
   Q.Time2Send:=Round(Q.Blocks2Send*(TransTimeVal/BaudRate));
   Q.SavedTime2Send:=Q.Time2Send;
   {If(DisplayStatus)Then} PLInitReceiveScr(Q);
   TruncateFile:=RFileSize>0;
  End;
  Q.StopReceive:=Q.StopReceive or FileExist(DownloadDir+Q.XFileName);
  If Not(Q.StopReceive)Then OpenReceivingFile;
  If RFileName=''Then Begin
   {PibTermWindow(11,4,77,8);}
   WEPutTxtXY(Q.W,2,1,'Nom du fichier:        '+Q.XFileName);
{    PibTermWindow(11,11,77,21);}
  End;
  CRCTries:=0;Q.CRCUsed:=True;
 End;

 Procedure Wait4SOH(WaitTime:Integer;Var InitialCh:Integer;Var StopReceive:Boolean);
 Var
  ITime:Integer;
  SOHStartTime:Long;
  SOHChar:Char;
 Begin
  InitialCh:=TimeOut;
  If(StopReceive)Then EXIT;
  ITime:=0;
  Repeat
   Inc(ITime);
   InitialCh:=TimeOut;SOHStartTime:=TimeOfDayH;
   Repeat
    If ACReceive(SOHChar)Then Begin
     If(SOHChar in BlockStartSet)Then InitialCh:=Byte(SOHChar);
    End;
   Until(InitialCh<>TimeOut)or(TimeDiffH(SOHStartTime,TimeOfDayH)>100);
   PLChkKbd(Q);
   If(ACCarrierDrop)Then Begin
    StopReceive:=True;
    InitialCh:=TimeOut;
   End;
  Until(StopReceive)or(ITime>WaitTime)or(InitialCh<>TimeOut);
 End;

 Procedure SetFileDateAndTime;
 Var
  Time:LongInt;
  T:Array[1..2]of Word Absolute Time;
 Begin
  T[1]:=FileTime;T[2]:=FileDate;
  SetFTime(Q.XHandle,Time);
  If SysErr<>0Then Begin
   {If Not(Q.DisplayStatus)Then FlipDisplayStatus;}
   WEPutTxtXY(Q.W,25,10,'Incapable de fixer la date et l''heure du fichier');
   WEClrEol(Q.W);
{    WriteLog('Impossible de fixer la date et l''heure',True,False);}
  End;
 End;

 Procedure WriteFileData;

  Procedure DoActualWrite(WriteCount:Integer);Begin
   IF((RFileSize2+WriteCount)>RFileSize)and(TruncateFile)Then
   WriteCount:=Trunc(RFileSize-RfileSize2);WCount:=WriteCount;
   IF(Q.DoWXModem)Then Begin
    ACSend(ccXOFF);
    Delay(XOFFDelay);
   End;
   WriteCount:=_SetRec(Q.XHandle,WCount,WriteBuffer^);
   If(Q.DoWXModem)Then ACSend(ccXON);
   If(SysErr<>0)or(WriteCount<>WCount)Then Begin
{     If Not(Q.DisplayStatus)Then FlipDisplayStatus;}
    WEPutTxtXY(Q.W,25,10,'Erreur d''Çcriture sur le disque, transfert annulÇ.');
{     WriteLog('Error writing to disk.',Ya,No);}
    WEClrEol(Q.W);
    ErrorFlag:=True;Q.StopReceive:=True;
   End;
   Inc(RFileSize2,WriteCount);
  End;

 Begin
  If Not(RFileOpen)Then Begin
   OpenReceivingFile;
   If(Q.StopReceive)Then Exit;
  End;
  If Not(LongBuffer)Then DoActualWrite(SectorLength)
   Else
  Begin
   If(BufferPos+SectorLength)>BufferLength Then Begin
    DoActualWrite(BufferPos);
    BufferPos:=0;
   End;
   MoveLeft(Q.SectorData,WriteBuffer^[BufferPos+1],SectorLength);
   Inc(BufferPos,SectorLength);
  End;
 End;

Begin
 Q.CRCUsed:=UseCRC;
 PLGetXmodemTitles(Q);
 SOHErrors:=0;BlockLErrors:=0;BlockNErrors:=0;CompleErrors:=0;
 TimeOutErrors:=0;ResendErrors:=0;CRCErrors:=0;Q.DisplayTime:=No;
 DupBlock:=No;GFailure:=No;
 PLInitReceiveScr(Q);
 Q.Base.SectorNumber:=0;
 SectorCount:=0;
 SectorPrev:=0;
 SectorLength:=128;
 ErrorCount:=0;CRCTries:=0;WXMTries:=0;SOHTime:=Q.XmodemBlockWait;TruncateFile:=No;
 RFileSize:=0;RFileSize2:=0;RFileDate:=0;FileDate:=0;FileTime:=0;
 Q.DoACKs:=Not Q.TransferProtocol in[trsYmodemG,trsXmodem1KG];
 Q.DoWXmodem:=No;Q.DoSeaLink:=No;RFileName:='';OKTransfer:=No;Block0:=No;
 Q.StartTime:=TimeOfDay;
 Q.AltRPressed:=False;
 Q.StopReceive:=False;
 Q.NullFileName:=False;
{  If(MaxWriteBuffer>1024)and(MaxWriteBuffer<MaxAvail)Then Begin
  BufferLength:=((WhoMin(MaxWriteBuffer,31744)+1023)shr 10)shl 10;
  LongBuffer:=Ya;
  GetMem(WriteBuffer,BufferLength);
  If(WriteBuffer=NIL)Then Begin
   LongBuffer:=No;BufferLength:=1024;WriteBuffer:=@Q.SectorData;
  End;
 End
  Else}
 Begin
  LongBuffer:=No;BufferLength:=1024;WriteBuffer:=@Q.SectorData;
 End;
 BlockStartSet:=[^A,^B,^D,^V,^X];FlushCount:=0;BufferPos:=0;RFileOpen:=No;
 If Q.XFileName<>''Then Begin
  OpenReceivingFile;
  If(Q.StopReceive)Then Begin
   PLCancelTransfer(Q);
   Exit;
  End;
 End;
 SaveXonXoff:=AsyncDoXonXoff;AsyncDoXonXoff:=Q.DoWXModem;
 SaveXonOV:=AsyncOVXonXoff;AsyncOVXonXoff:=Q.DoWXModem or Not(Q.DoAcks);
 Repeat
  ErrorFlag:=No;DupBlock:=No;
  Repeat
   If(SectorCount=0)and(WXMTries=0)Then Begin
    Q.CRCUsed:=Q.CRCUsed and(CRCTries<4);
    Q.DoWXModem:=Q.DoWXModem and(WXMTries<4);
    ACPurgeBuf;
    If(Q.DoWXModem)Then Begin
     ACSend('W');
     Inc(WXMTries)
    End
     Else
    Begin
     IF Not(Q.DoACKs)Then ACSend('G')Else
     If(Q.CRCUsed)Then ACSend('C')Else ACSend(Chr(caNAK));
     Inc(CRCTries);
     If(Q.DoSealink)Then Begin
      ACSend(#1);
      ACSend(#254);
     End;
    End;
    If Not(Q.CRCUsed)Then WEPutTxtXY(Q.W,0,7,'Erreur somme de vÇr. :')
		     Else WEPutTxtXY(Q.W,0,7,'Erreurs CRC          :');
   End;
   Wait4SOH(SOHTime,InitialCh,Q.StopReceive);
   If(InitialCh=caCAN)Then Wait4SOH(SOHTime,InitialCh,Q.StopReceive)
    Else
   If(InitialCh=caEOT)and(Q.DoWXModem or(Q.DoSeaLink and(SectorCount>0)))Then Begin
    ACSend(Chr(caNAK));
    Wait4SOH(SOHTime,InitialCh,Q.StopReceive)
   End
    Else
   If(InitialCh=TimeOut)Then Begin
    If SectorCount>0Then ACSend(Chr(caNAK));
    PutReceiveErr('DÇlai dÇpassÇ, pas de SOH');
    Inc(TimeOutErrors);
   End;
   AsyncDoXonXoff:=Q.DoWXModem;
   {If(Q.DisplayStatus)Then} UpdateXmodemReceiveDisplay;
   Until(InitialCh in[caSOH,caEOT,caCAN,caSYN,caSTX])or(ErrorCount>Q.XmodemMaxErrors)or(Q.StopReceive);
   If(Q.StopReceive)Then Begin
    If Not(ACCarrierDetect)Then Begin
     PutReceiveErr('Communication coupÇ');
    End;
   End
    Else
   If(InitialCh=TimeOut)Then Begin
    PutReceiveErr('DÇlai dÇpassÇ, pas de SOH');
    Inc(TimeOutErrors);
   End
    Else
   IF((InitialCh=caSYN)and Q.DoWXModem)Then Else
   If InitialCh in[caSOH,caSYN,caSTX]Then Begin
    IF(InitialCh=caSTX)Then SectorLength:=1024 else SectorLength:=128;
    If(Q.DoWXModem)Then WXModemReceiveWithTimeOut(Ch)
    Else ACReceiveWithTimeOut(Q.XmodemCharWait,Ch);
    If(Ch=TimeOut)Then Begin
     Inc(BlockLErrors);
     PutReceiveErr('Bloc trop court')
    End;
    Q.Base.SectorNumber:=Ch;
    If(Q.DoWXModem)Then WXModemReceiveWithTimeOut(Ch)
    Else ACReceiveWithTimeOut(Q.XmodemCharWait,Ch);
    If(Ch=TimeOut)Then Begin
     Inc(BlockLErrors);
     PutReceiveErr('Bloc trop court')
    End;
    SectorComp:=Ch;
    If Q.Base.SectorNumber+SectorComp=255Then Begin
     SectorPrev1:=SUCC(SectorPrev);
     Block0:=(SectorCount=0)and(Q.Base.SectorNumber=0)and((InitialCh=caSYN)or
	     (Q.TransferProtocol in[trsXmodem1K,trsXmodem1KG,trsYmodemG,trsYmodemBatch{,trsSeaLink}]));
     CRCUsed2:=Q.CRCUsed and Not(Block0 and(Q.TransferProtocol=trsTelink));
     If(Q.Base.SectorNumber=SectorPrev1)or(Block0)Then Begin
      If ReceiveXmodemSector(CRCUsed2)Then If Not(Block0)Then Begin
       WriteFileData;
       If Not(Q.StopReceive)Then Begin
	ErrorCount:=0;Inc(SectorCount,SectorLength shr 7);
	SectorPrev:=Q.Base.SectorNumber;
	If(Q.DoACKs)Then Begin
	 ACSend(Chr(caACK));
	 If(Q.DoWXModem)Then ACSend(Chr(Q.Base.SectorNumber and 3))
	  Else
	 If(Q.DoSeaLink)Then
	 Begin
	  ACSend(Chr(Q.Base.SectorNumber));
	  ACSend(Chr(SectorComp));
	 End;
	End;
       End
      End
       Else
      Begin
       If(InitialCh=caSYN){or(TransferProtocol=trsSeaLink)}Then ReceiveTelinkHeader
	Else
       If Q.TransferProtocol in[trsXmodem1K,trsXmodem1KG,trsYmodemG,trsYmodemBatch]Then ReceiveYmodemHeader;
       If Not(Q.StopReceive)Then Begin
	If Not(Q.DoACKs)Then ACSend('G')Else ACSend(Chr(caACK));
       If(Q.DoWXModem)Then ACSend(Chr(Q.Base.SectorNumber and 3))
	Else
       If(Q.DoSeaLink)Then Begin
	ACSend(Chr(Q.Base.SectorNumber));
	ACSend(Chr(SectorComp));
       End;
       ErrorCount:=0;
      End;
     End
      Else
     Begin
      Inc(CRCErrors);
      IF(Q.CRCUsed)Then PutReceiveErr('Erreur CRC')
                   Else PutReceiveErr('Erreur de somme de vÇrification');
     End
    End
     Else
    If(Q.Base.SectorNumber=SectorPrev)Then Begin
     BSFlag:=ReceiveXmodemSector(CRCUsed2);
     If(Q.DoACKs)Then Begin
      ACSend(Chr(caACK));
      If(Q.DoWXModem)Then ACSend(Chr(Q.Base.SectorNumber and 3))
       Else
      If(Q.DoSeaLink)Then Begin
       ACSend(Chr(Q.Base.SectorNumber));
       ACSend(Chr(SectorComp));
      End;
     End;
     PutReceiveErr('Bloc dupliquÇ');
     Inc(ResendErrors);
     ErrorFlag:=False;
     DupBlock:=True;
    End
     Else
    Begin
     BSFlag:=ReceiveXmodemSector(CRCUsed2);
     If FlushCount>0Then Begin
      Dec(FlushCount);
      PutReceiveErr('Re-synchronise ... ');
      ErrorFlag:=No;
     End
      Else
     Begin
      PutReceiveErr('Erreur de synchronisation');
      Inc(BlockNErrors);
     End;
    End;
   End
    Else
   Begin
    PutReceiveErr('Erreur de numÇro de secteur');
    Inc(CompleErrors);
   End;
  End
   Else
  If(InitialCh=caEOT)Then Begin
   If Q.DoSeaLink and(SectorCount=0)Then Q.NullFileName:=True;
  End
   Else
  Begin
   PutReceiveErr('SOH introuvable');
   Inc(SOHErrors);
  End;
  If(ErrorFlag)Then Begin
   Inc(ErrorCount);
   If(Q.DoAcks)Then If Not(Q.DoWXmodem or Q.DoSeaLink)Then ACPurgeBuf;
   ACSend(Chr(caNAK));
   If(Q.DoWXModem)Then Begin
    ACSend(Chr(Q.Base.SectorNumber and 3));
    BlockStartSet:=[^V];
    Wait4SOH(SOHTime,InitialCh,Q.StopReceive);
    BlockStartSet:=[^A,^B,^D,^V,^X];FlushCount:=WXmodemFlush;
   End
    Else
   If(Q.DoSeaLink)Then
   Begin
    ACSend(Chr(Q.Base.SectorNumber));
    ACSend(Chr(255-Q.Base.SectorNumber));
    FlushCount:=SEALinkFlush;
   End;
   If Not(Q.DoACKs)Then Begin
    Q.StopReceive:=True;
    GFailure:=True;
   End;
  End;
  IF(Q.DisplayTime)Then Begin
   If Not( ErrorFlag or DupBlock)Then Begin
    Q.Time2Send:=Round(Q.SavedTime2Send*(1.0-SectorCount/Q.Blocks2Send));
    If Q.Time2Send<0Then Q.Time2Send:=0;
   End;
  End;
  PLChkKbd(Q);
  UpdateXmodemReceiveDisplay;
 Until(InitialCh in[caEOT,caCAN])or(Q.StopReceive)or(Q.NullFileName)or(ErrorCount>Q.XmodemMaxErrors);
 If(Q.StopReceive)Then Begin
  PLCancelTransfer(Q);
  If(Q.AltRPressed)Then Begin
{    If Not(DisplayStatus)Then FlipDisplayStatus;}
   WEPutTxtXY(Q.W,25,10,'Alt+R presser, rÇception annuler.');
   WEClrEol(Q.W);
   WriteLog('Alt+R presser, rÇception annuler.');
  End
   Else
  If(GFailure)Then Begin
{    If Not(DisplayStatus)Then FlipDisplayStatus;}
   WEPutTxtXY(Q.W,25,10,'Erreur durant le protocol G, rÇception annuler.');
   WEClrEol(Q.W);
   WriteLog('Erreur durant le protocol G, rÇception annuler.');
  End;
 End
  Else
 If(Q.NullFileName)Then Begin
{   If Not(Q.DisplayStatus)Then FlipDisplayStatus;}
   WEPutTxtXY(Q.W,25,10,'RÇception d''un fichier nulle.');
{    WriteLog('RÇception d''un fichier nulle.',Ya,No);}
   WEClrEol(Q.W);
   OKTransfer:=True;
  End
   Else
  If(InitialCh=caEOT)and(ErrorCount<=Q.XmodemMaxErrors)Then Begin
   ACSend(Chr(caACK));
   If BufferPos>0Then Begin
    WriteCount:=BufferPos;
    If((RFileSize2+WriteCount)>RFileSize)and TruncateFile Then WriteCount:=Trunc(RFileSize-RfileSize2);
    WCount:=WriteCount;
    WriteCount:=_SetRec(Q.XHandle,WCount,WriteBuffer^);
    If(SysErr<>0)or(WCount<>WriteCount)Then Begin
{     If Not(DisplayStatus)Then FlipDisplayStatus;}
    WEPutTxtXY(Q.W,25,10,'Erreur d''Çcriture sur le disque.');
    WEClrEol(Q.W);
   End;
   RFileSize2:=RFileSize2+WriteCount;
  End;
  Q.EndTime:=TimeOfDay;
{   If Not(Q.DisplayStatus)Then FlipDisplayStatus;}
  OKTransfer:=True;
  If RFileSize>0Then
   If(RFileSize<=RFileSize2)Then Begin
    RFileSize2:=RFileSize;
    WEPutTxtXY(Q.W,2,10,'RÇception compläte; ');
   End
    Else
   Begin
    WEPutTxtXY(Q.W,2,10,'RÇception apparamment incompläte; ');
    OKTransfer:=No;
   End
   Else
  WEPutTxtXY(Q.W,2,10,'RÇception compläte; ');
  If(Q.EndTime<Q.StartTime)Then Inc(Q.EndTime,86400);
  EffectiveRate:=Q.EndTime-Q.StartTime;
  If EffectiveRate=0.0Then EffectiveRate:=1.0;
  EffectiveRate:=RFileSize2/EffectiveRate;
  Write('Taux de transfert ',EffectiveRate:6:1,' CPS');
{   ClrEol;}
{   If(OkTransfer)Then WriteLog('RÇception du fichier '+FileName,True,False)
  Else WriteLog('RÇception du fichier '+FileName+' (apparament incomplet)',True,False);}
  OkTransfer:=True;
{   Str(RFileSize2,SCps);
  WriteLog('Taille du fichier reáu est '+SCps+' octet(s)',True,False);
  Str(EffectiveRate:6:1,SCps);
  WriteLog('Transfer rate was '+SCps+' CPS',Ya,No);}
 End
  Else
 If(InitialCh=caCAN)Then Begin
{   If Not(DisplayStatus)Then FlipDisplayStatus;}
  WEPutTxtXY(Q.W,25,10,'êmetteur a annuler la transmission du fichier.');
  WriteLog('êmetteur a annuler la transmission du fichier.');
  WEClrEol(Q.W);
  Q.StopReceive:=True;
 End
  Else
 Begin
  PLCancelTransfer(Q);
{   If Not(DisplayStatus)Then FlipDisplayStatus;}
  WEPutTxtXY(Q.W,25,10,'RÇception annulÇ - trop d''erreurs');
  WriteLog('RÇception annulÇ - trop d''erreurs');
  WEClrEol(Q.W);
 End;
 If(FileDate<>0){and(UseTimeSent)}Then SetFileDateAndTime;
 FileClose(Q.XHandle);
{  If(EvictPartialTrans and Not(OKTransfer))Then DelFile(FullFileName);}
 If(LongBuffer)Then FreeMemory(WriteBuffer,BufferLength);
 AsyncDoXonXoff:=SaveXonXoff;AsyncOVXonXoff:=SaveXonOV;
End;

Procedure ReceiveModem7File(Var Q:Prots;UseCRC:Boolean);Near;
Const
 MaxTry=10;
 MaxNoise=5;
Var
 RFileName:String;
 IntCh,IntChSave:Integer;
 Ch:Char;
 CheckSum:Integer;
 EndFName:Boolean;
 I,Tries,NTries,J:Integer;

 Procedure CheckTheKeyBoard;Begin
  PLChkKbd(Q);
  If(Q.StopReceive)Then Begin
{    If Not(Q.DisplayStatus)Then DisplayBatchWindow;}
   ErrMsgOk('Alt+R enfoncÇ, transfäre annuler.');
  End;
 End;

Begin
 PLPutBatchWn(Q);
 UseCRC:=UseCRC and(Q.TransferProtocol<>trsModem7Chk);Q.StopReceive:=No;
 ACPurgeBuf;
 Tries:=0;
 Repeat
  CheckSum:=0;RFileName:='';
  Repeat
   ACSend(Chr(caNAK));
   NTries:=0;
   Repeat
    ACReceiveWithTimeOut(1,IntCh);
    Inc(NTries);
    PLChkKbd(Q);
   Until(Ntries>MaxNoise)or(IntCh<=127)or Q.StopReceive;
   Inc(Tries);
  Until(IntCh=caACK)or(IntCh=caCAN)or(IntCh=caEOT)or(Tries>=MaxTry)or Q.StopReceive;
  Q.StopReceive:=(IntCh<>caACK)or Q.StopReceive;IntChSave:=IntCh;
  If Not(Q.StopReceive)Then Repeat
   NTries:=0;
   Repeat
    ACReceiveWithTimeOut(1,IntCh);
    CheckTheKeyBoard;
    Inc(NTries);
   Until(IntCh<>TimeOut)or(NTries>=MaxTry)or Q.StopReceive;
   EndFName:=(Byte(IntCh)in[caCAN,caEOT,caSub])or(IntCh=TimeOut)or Q.StopReceive;
   If Not(EndFname)Then Begin
    ACSend(Chr(caACK));
    IncStr(RFileName,Chr(IntCh));
    Checksum:=(Checksum+IntCh)and$FF;
   End;
  Until EndFname
   Else
  IntCh:=TimeOut;
  If(IntCh=caSub)Then Begin
   CheckSum:=(CheckSum+IntCh)and$FF;
   ACSend(Chr(CheckSum));
   NTries:=0;
   Repeat
    ACReceiveWithTimeOut(1,IntCh);
    CheckTheKeyBoard;
    Inc(NTries);
   Until(IntCh=caACK)or(NTries>=MaxTry);
   If(IntCh=caACK)and Not(Q.StopReceive)Then Begin
    For I:=Length(RFileName)to 11do IncStr(RFileName,' ');
    Q.XFileName:=Trim(Left(RFileName,8));
    If Copy(RfileName,9,3)<>'   'Then InsStr(Q.XFileName,9,'.');
    {If(Q.HostMode)Then If Privilege<>'S'Then StopReceive:=StopReceive or FileExist(FileName,DownloadDirPath);}
    If Not(Q.StopReceive)Then Begin
     WriteLn('TÇlÇchargement: '+Q.XFileName);
     WriteLog('TÇlÇchargement: '+Q.XFileName);
     PLReceiveXmodemFile(Q,UseCRC);
    End;
   End
    Else
   Q.StopReceive:=True;
  End
   Else
  Q.StopReceive:=True;
 Until Q.StopReceive;
 PLPutBatchWn(Q);
 If(IntChSave=caEOT)Then Begin
  ACSend(Chr(caACK));
  WriteLog('RÇception du signal EOT de l''hìte.');
  ErrMsgOk('RÇception du signal EOT de l''hìte.');
 End
  Else
 Begin
  WriteLog('Transfert annulÇ.');
  ErrMsgOk('Transfert annulÇ.');
 End;
 PLEndBatchTransfer(Q);
End;

Procedure PLReceiveYmodemFile(Var Q:Prots);Near;Begin
 PLPutBatchWn(Q);
 Q.StopReceive:=False;
 Q.NullFileName:=False;
 While(Not Q.StopReceive)and(Not Q.NullFileName)do Begin
  Q.XFileName:='';
  PLReceiveXmodemFile(Q,True);
  If(Not Q.NullFileName)and(Not Q.StopReceive)Then Begin
   WriteLn('RÇception du fichier: '+Q.XFileName);
{    WriteLog('RÇception du fichier: '+Q.XFileName,False,False);}
  End;
 End;
 PLPutBatchWn(Q);
 If(Q.NullFileName)Then Begin
{   WriteLog(RÇception d''un fichier nulle de l''hìtre,False,False);}
  ErrMsgOk('RÇception d''un fichier nulle de l''hìte.');
 End;
 PLEndBatchTransfer(Q);
End;

Procedure PLDoXmodemDownload(Var Q:Prots;TransProtocol:Byte);
Var
 NullFileName:Boolean;
Begin
 Q.TransferProtocol:=TransProtocol;
 PLSaveComm4Xmodem(Q);
 Q.SendingFiles:=False;
 Case(Q.TransferProtocol)of
  trsXmodemChk:PLReceiveXmodemFile(Q,False);
  trsModem7CRC,trsTelink:ReceiveModem7File(Q,True);
  trsModem7Chk:ReceiveModem7File(Q,False);
{ trsSeaLink,}trsYmodemG,trsYmodemBatch:PLReceiveYmodemFile(Q);
  trsXmodem1K,trsXmodem1KG,trsXmodemCrc:PLReceiveXmodemFile(Q,True);
 End;
 PLRestoreComm4Xmodem(Q);
End;

Procedure PLLoadConfig(Var Q:Prots;Protocol:Byte);Near;
Var
 Data:DataProtocolRec;
Begin
 If FindProtocol(Protocol,Data)Then Q.Default:=Data.Default;
End;

Procedure PLUpDownLoad;
Var
 SaveClose:Boolean;
 I:SmallInt;
Begin
 If(TransferProt=trsNone)Then Exit;
 PLLoadConfig(Q,TransferProt);
 DefaultTransferType:=TransferProt;
 Case(TransferDirec)of
  'R':Q.TName:=StrPas(Q.ReceiveScriptNames[TransferProt]);
  'S':Q.TName:=StrPas(Q.SendScriptNames[TransferProt]);
 End;
{ If(Length(TName)>0)Then If(Pos('.BAT',TName)=0)Then
 Begin
  SaveClose:=CloseComm4Dos;
  CloseComm4Dos:=Ya;
  ProcessScript(TName,'E');
  CloseComm4Dos:=SaveClose;
 End
  Else
 TransferThroughBatchFile(TransferProtocol,TName,TransferDirec)
  Else}
 Begin
  Case(TransferProt)of
   trsAscii:Case(TransferDirec)of
    'R':PLReceiveAsciiFile(Q);
    'S':PLSendAsciiFile(Q);
   End;
   trsYmodemBatch,trsYmodemG,trsXmodem1K,trsXmodem1KG,trsXmodemCrc,
   trsXmodemChk,trsModem7CRC,trsTelink,trsModem7Chk:Case(TransferDirec)of
    'R':PLDoXmodemDownload(Q,TransferProt);
    'S':PLDoXmodemUpload(Q,TransferProt);
   End;
   {trsKermit:
   DoKermit(TransferDirec);}
  End;
 End;
End;

Procedure PLDone;Begin
 WEDone(Q.W)
End;

{ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ}
END.