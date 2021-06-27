{ Cette unit‚ contient un joueur de disque compacte. Les routines permettant
 d'effectuer le travail sont tir‚es d'une unit‚ d'un jeu de  ®PinBall¯  dont
 j'ai perdu la trace...
}

Unit ToolSoun;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                   INTERFACE
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses Systex,Disk;

Type
 PInteger=^Integer;

 AudioStatus=Record
  Status:Word;
  Start:CDAddr;
  End1:CDAddr;
 END;

 QChannelInfo=Record
  Tno:Byte; { Track }
  x:Byte;
  tMin:Byte;
  tSec:Byte;
  tFrame:Byte;
  Zero:Byte;
  dMin:Byte;
  dSec:Byte;
  dFrame:Byte;
 End;

 IOInpAudioStatus=Record
  IOctlCmd:Byte;
  Report:AudioStatus;
 End;

 IOInpTrackInfo=Record
  IOctlCmd:Byte;
  Tno:Byte;
  Start:CDAddr;
  Control:Byte;
 End;
  { controle :
     2 pistes      00h
     4 pistes      80h
     Emphasis      10h
     Donn‚es       40h
     Copie digital 20h }
 IOInpAudioInfo=Record
  IOctlCmd:Byte;
  TrackLo:Byte;
  TrackHi:Byte;
  TrackLeadOut:CDAddr;
 End;

 IOCTLInpRequest=Record
  IOctlRqh:RequestHdr;
  IOctlMedia:Byte;
  IOCtlxFer:PInteger;
  IOCtlnBytes:Word;
  IOctlSector:Word;
  IOctlVolID:PInteger;
 End;

 TrackInfoTag=Record
  Start:CDAddr;
  Frames:LongInt;
  Delta:CDAddr;
 End;

 ATrackInfoTag99=Array[0..98]of TrackInfoTag;

 IOInpDeviceStatus=Record
  IOctlCmd:Byte;
  Status:Word;
 End;

 IOInpUPC=Record
  IOctlCmd:Byte;
  AddrMode:Byte;
  Signature:Array[0..13]of Char;
  aFrame:Byte;                  { ????? }
 End;

 IOInpDeviceHdr=Record
  IOctlCmd:Byte;
  DeviceHdr:PInteger;
 End;

 IOInpMediaChanged=Record
  IOctlCmd:Byte;
  MediaByte:Byte;
 End;

 IOInpQChannel=Record
  IOctlCmd:Byte;
  AddrMode:Byte;
  qInfo:QChannelInfo;
 End;

 IOOutpEject=Record
  IOctlCmd:Byte;
 End;

 IOInpAudiochanInfo=Record
  IOctlCmd:Byte;
  InpChan0:Byte;
  VolChan0:Byte;
  InpChan1:Byte;
  VolChan1:Byte;
  InpChan2:Byte;
  VolChan2:Byte;
  InpChan3:Byte;
  VolChan3:Byte;
 End;

 IOOutpLockDoor=Record
  IOctlCmd:Byte;
  Function1:Byte;
 END;

 IOInpVolumeSize=Record
  IOctlCmd:Byte;
  HSGSect:Word;
 End;

 IOInpSectorSize=Record
  IOctlCmd:Byte;
  AddrMode:Byte;
  SectSize:Word;
 End;

 IOInpDriveBytes=Record
  IOctlCmd:Byte;
  Bytes2read:Byte;
  ReadBuff:Array[0..127]of Byte;
 End;

 IOInpHeadLoc=Record
  IOctlCmd:Byte;
  AddrMode:Byte;
  Location:Word;
 End;

Type CDPlayer=Record
 W:Window;                    { Fenˆtre courante }
 MaxTitles:Integer;           { Nombre maximal de titre de l'Album }
 Mode:(cdOpen,cdClose);       { Mode CD-ROM … l'int‚rieur et ext‚rieur }
 rqInput:IOInpAudiochanInfo;
 rqVolume:IOInpAudiochanInfo;
 rqInsert:IOOutpEject;
 rqEject:IOOutpEject;
 rqReset:IOOutpEject;
 rqQChan:IOInpQChannel;
 Index:ATrackInfoTag99;
 StartPlay:LongInt;
 EndPlay:LongInt;
 AudioDrive:Word;
 UnitDrive:Byte;
 Titles:Byte;
 rqInp:IOCTLInpRequest;
 CurrTitle:String;
 Actual,Status:Integer;
 RR:Wd;
 TimeInfo:QChannelInfo;
 OldTrack,OldTMin,OldTSec:Byte;
 P:Byte;
 T:Array[0..1]of Char;
End;

Function  CDInitApp(Var QX;X1,Y1,X2,Y2:Byte):Boolean;
Procedure CDCheck(Var Q:CDPlayer);
Procedure CDRefresh(Var QX);
Procedure CDPrevTrack(Var Q:CDPlayer);
Procedure CDNextTrack(Var Q:CDPlayer);
Procedure CDEject(Var Q:CDPlayer);
Procedure CDPlayPause(Var Q:CDPlayer);
Procedure CDStop(Var Q:CDPlayer);
Function  CDRun(Var QX):Word;
Function  CDTitle(Var QX;Max:Byte):String;
Procedure CDMove2(Var QX;X,Y:Byte);
Function  CDDone(Var QX):Word;
Function  MnuNoSound:Byte;
Function  SelOutput:Byte;
Procedure StartCDPLayer;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                IMPLEMENTATION
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses Sound,Adele,Video,Memories,Systems,Mouse,Dials,Isatex,Dialex;

Const
  NotChanged=$01;
  IooCloseTray=5;
  Lock=$01;
  Seek1=131;
  DigitalCopy=$20;
  DevClose=14;
  HasChanged=$FF;
  StopAudio=133;
  IoiSectSize=7;
  IoctlInp=3;
  IoctlOutp=12;
  Emphasis=$10;
  FourTrack=$80;
  DoorOpen=$001;
  DataAndAudio=$010;
  DoorUnlocked=$002;
  TwoTrack=$00;
  PrefetChing=$080;
  Unlock=$00;
  DevOpen=13;
  HSGAndRed=$200;
  Interleaving=$020;
  WriteLong=134;
  IoiDriveByteS=5;
  IoiQChanInfo=12;
  ReadLong=128;
  DontKnow=$00;
  ResumeAudio=136;
  IoiUPC=14;
  Data=$40;
  IoiAudioInfo=10;
  AudioManipulation=$100;
  IooEject=0;
  IoiVolSize=8;
  IoiDevStat=6;
  IoiLochead=1;
  IoiDrvHead=0;
  IoiMediaChang=9;
  WriteLongVerify=135;
  IoiAudioStatus=15;
  PlayAudio=132;
  IooLock=1;
  IooAudioChanCtrl=3;
  IoiAudioChanInfo=4;
  CookedAnDraw=$004;
  Red=1;
  ReadWrite=$008;
  IoiTrackInfo=11;
  ReadLongPrefetch=130;
  cdInit=0;
  HSG=0;
  IooReset=2;
  OutputFlush=8;
  InputFlush=7;

  rqStatus:IOInpDeviceStatus=(
   IOctlCmd:IOIDEVSTAT;
   Status:0);

  rqUPC:IOInpUPC=(
   IOctlCmd:IOIUPC;
   AddrMode:Red;
   Signature:(#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0,#0);
   aFrame:0);

  rqHeader:IOInpDeviceHdr=(
   IOctlCmd:IOIDRVHEAD;
   DeviceHdr:NIL);

  rqBusy:IOInpDeviceHdr=(
   IOctlCmd:IOIDRVHEAD;
   DeviceHdr:NIL);

  rqAudioStatus:IOInpAudioStatus=(
   IOctlCmd:IOIAUDIOSTATUS;
   Report:(
    Status:0;
    Start:(HSGSector:0);
    End1:(HSGSector:0)));

  rqMedia:IOInpMediaChanged=(
   IOctlCmd:IOIMEDIACHANG;
   MediaByte:0);

Const
 FileNameTitle='AUDIO.TTL';
 MaxLenTitle=80;

Type
 TitleRec=Record
  Title:String[MaxLenTitle];
  Piste:Byte;
  Index:Array[0..10]of TrackInfoTag;
 End;

Procedure ReadQChannel(Var Q:CDPlayer;Var QC:QChannelInfo);Near;Forward;

Function IOctlIn(Var Q:CDPlayer;Drive:Word;Unit1:Byte;PRequest:PInteger;rqLen:Word):Word;Near;Begin
 Q.rqInp.IOCtlnBytes:=rqLen;
 Q.rqInp.IOCtlxFer:=pInteger(pRequest);
 Q.rqInp.IOctlRqh.rqUnit:=Unit1;
 ASM
  MOV AX,1510h
  MOV CX,Drive
  LES BX,Q
  ADD BX,Offset CDPlayer.rqInp
  INT 2Fh
 END;
 IOctlIn:=Q.rqInp.IOctlRqh.rqStatus;
End;

Function GetStatus(Var Q:CDPlayer;Drive:Char):Word;Near;Begin
 If(IOctlIn(Q,Integer(Drive),0,@rqStatus,SizeOf(IOInpDeviceStatus))and$8000)<>0Then Begin
  GetStatus:=$FFFF;
  Exit;
 End
  Else
 Begin
  GetStatus:=rqStatus.Status;
  Exit;
 End;
End;

Function GetHeader(Var Q:CDPlayer):PInteger;Near;Begin
 IOctlIn(Q,Q.AudioDrive,Q.UnitDrive,@rqHeader,SizeOf(IOInpDeviceHdr));
 GetHeader:=rqHeader.DeviceHdr;
End;

Function GetMediaChanged(Var Q:CDPlayer):Byte;Near;Begin
 IOctlIn(Q,Q.AudioDrive,Q.UnitDrive,@rqMedia,SizeOf(IOInpMediaChanged));
 GetMediaChanged:=rqMedia.MediaByte;
End;

Function GetTOC(Var Q:CDPlayer):Byte;Near;
Var
 rqTOC:IOInpAudioInfo;
 rqTrack:IOInpTrackInfo;
 I:Integer;
Begin
 rqTOC.IOctlCmd:=IOIAUDIOINFO;
 IOctlIn(Q,Q.AudioDrive,Q.UnitDrive,@rqTOC,SizeOf(IOInpAudioInfo));
 rqTrack.IOctlCmd:=IOITRACKINFO;
 For I:=Integer(rqTOC.TrackLo)to Integer(rqTOC.TrackHi)+1do Begin
  rqTrack.Tno:={ToBCD(}I{)};
  IOctlIn(Q,Q.AudioDrive,Q.UnitDrive,@rqTrack,SizeOf(IOInpTrackInfo));
  Q.Index[I].Start:=rqTrack.Start;
  Q.Index[I-1].Frames:=Red2HSG(Q.Index[I].Start)-Red2HSG(Q.Index[I-1].Start);
  HSG2Red(Q.Index[I-1].Frames,Q.Index[I-1].Delta);
  If I>=98Then Break;
 End;
 Q.Index[I-1].Frames:=Red2HSG(rqTOC.TrackLeadOut)-Red2HSG(Q.Index[I-1].Start);
 HSG2Red(Q.Index[I-1].Frames,Q.Index[I-1].Delta);
 Q.Index[0].Start:=Q.Index[1].Start;
 Q.Index[0].Frames:=Red2HSG(rqTOC.TrackLeadOut)-Red2HSG(Q.Index[1].Start);
 HSG2Red(Q.Index[0].Frames,Q.Index[0].Delta);
 GetTOC:=rqTOC.TrackHi
End;

Procedure ReadAudioStatus(Var Q:CDPlayer;Var Status:AudioStatus);Near;Begin
 IOctlIn(Q,Q.AudioDrive,Q.UnitDrive,@rqAudioStatus,SizeOf(IOInpAudioStatus));
 Status:=rqAudioStatus.Report;
End;

Function InitCDAudio(Var Q:CDPlayer):Integer;
Label Xit;
Var
 StatAudio:AudioStatus;
 I,nDrives:Integer;
 LogicalDrives:Array[0..25]of Char;
Begin
 ASM
  MOV @Result,-1
  MOV AX,01500h
  XOR BX,BX
  INT 02Fh
  OR  BX,BX
  JZ  Xit
  MOV nDrives,BX
  XOR AX,AX
  SUB AX,BP
  MOV BX,Offset LogicalDrives
  SUB BX,AX
  PUSH SS
  POP ES
  MOV AX,150Dh
  INT 2Fh
 End;
 I:=DefaultCDROMPort;
 While(I<nDrives)do Begin
  If((GetStatus(Q,LogicalDrives[I])and DataAndAudio))<>0Then Begin
   Q.AudioDrive:=Integer(LogicalDrives[I]);
   Q.UnitDrive:=I and 1;
   Break;
  End;
  I:=Succ(I)
 End;
 If(I=nDrives)Then Begin
  InitCDAudio:=-2;
  Exit;
 End;
 GetHeader(Q);
 I:=1;
 While I<=20do Begin
  If Integer(GetMediaChanged(Q))<128Then Break;
  I:=Succ(I)
 End;
 If Integer(GetMediaChanged(Q))>128Then Begin
  InitCDAudio:=-3;
  Exit;
 End;
 Q.Titles:=GetTOC(Q);
 ReadAudioStatus(Q,StatAudio);
 Q.EndPlay:=Red2HSG(StatAudio.End1);
 InitCDAudio:=Integer(Q.Titles);
Xit:
End;

Procedure CDUpDateTotalTime(Var Q:CDPlayer);Begin
 WESetKrSel(Q.W);
 If Q.Index[0].Delta.Time.Minute<>0Then
  WEPutTxtXY(Q.W,29,4,Str0(Q.Index[0].Delta.Time.Minute,2)+':'+Str0(Q.Index[0].Delta.Time.Second,2))
 Else
  WEPutTxtXY(Q.W,29,4,'--:--');
 WESetKrBorder(Q.W);
End;

Procedure CDResetMenu(Var Q:CDPlayer);Begin
 WEPutTxtXY(Q.W,0,2,'tat :');WEPutTxtXY(Q.W,30,2,'>__<');
 WEPutTxtXY(Q.W,0,3,'Piste:');
 WEPutTxtXY(Q.W,0,4,'Temps:');
 WEPutTxtXY(Q.W,23,4,'Total:');
 WESetKrSel(Q.W);
 WEPutTxtXY(Q.W,6,3,'00/00');
 WEPutTxtXY(Q.W,6,4,'00:00/00:00');
 WESetKrBorder(Q.W);
 CDUpDateTotalTime(Q);
End;

Function CDSearchTitle(Var Q:CDPlayer):String;
Var
 Handle:Hdl;
 R:TitleRec;
 P,J:LongInt;
 Ok:Boolean;
 N,I:Byte;
Begin
 CDSearchTitle:='';P:=0;
 Handle:=FileOpen(MaltePath+FileNameTitle,fmDef);
 If(Handle<>errHdl)Then Begin
  For J:=0to FileSize(Handle)div SizeOf(TitleRec)do Begin
   _GetAbsRec(Handle,P,SizeOf(TitleRec),R);
   If(R.Piste=Q.MaxTitles)Then Begin
    Ok:=True;
    If R.Piste<=10Then N:=R.Piste Else N:=10;
    For I:=0to(N)do Ok:=Ok and(Compare(R.Index[I],Q.Index[I],SizeOf(Q.Index[I])));
    If(Ok)Then Begin
     CDSearchTitle:=R.Title;
     Break;
    End;
   End;
   Inc(P,SizeOf(TitleRec));
  End;
  FileClose(Handle);
 End;
End;

Procedure CDPutTitle(Var Q:CDPlayer);Begin
 Q.CurrTitle:=CDSearchTitle(Q);
 WEPutTxtXY(Q.W,0,1,'Titre:');
 WESetKrHigh(Q.W);
 If Q.CurrTitle=''Then WEPutTxtXY(Q.W,6,1,Left(StrUSpc('Sans titre',28),28))
                  Else WEPutTxtXY(Q.W,6,1,Left(StrUSpc(Q.CurrTitle,28),28));
 WESetKrBorder(Q.W);
End;

Function CDInitApp(Var QX;X1,Y1,X2,Y2:Byte):Boolean;
Var
 Q:CDPlayer Absolute QX;
Begin
 CDInitApp:=No;
 FillClr(Q,SizeOf(Q));
 WEPushEndBar(Q.W);
 WEPutLastBar('Un instant S.V.P. v‚rification du lecteur de disque compacte en cours...');
 Q.rqInp.IOctlRqh.rqLen:=SizeOf(IOCTLInpRequest);
 Q.rqInp.IOctlRqh.rqCmd:=IOCTLINP;
 Q.MaxTitles:=InitCDAudio(Q);
 WEDone(Q.W);
 Q.T[0]:='_';Q.T[1]:='_';
 WEInit(Q.W,X1,Y1,X2,Y2);
 CDRefresh(Q);
 CDInitApp:=True;
End;

Procedure CDRefreshVolume(Var Q:CDPlayer);
Var
 GX1,GY1:Word;   { Coordonn‚e graphique d'affichage }
 TrueColor:Word; { Vrai couleur }
 CDVolume:Byte;  { Volume du lecteur de disque compacte }
 J:Byte;         { Compteur de boucle }
 Show:Boolean;   { Le pointeur de souris est affich‚e? }
Begin
 Show:=IsShowMouse;
 If(Show)Then __HideMousePtr;
 GX1:=((WEGetRX1(Q.W)+34)shl 3)+1;
 GY1:=GetRawY(WEGetRY1(Q.W)+1)+1;
 CDVolume:=GetCDVolume and$F;
 For J:=0to 15do Begin
  If(J>15-CDVolume)Then Case(J)of
   8..15:TrueColor:=GetClassicToColor(LightGreen);
   4..7:TrueColor:=GetClassicToColor(Yellow);
   Else TrueColor:=GetClassicToColor(LightRed);
  End
   Else
  TrueColor:=GetClassicToColor(DarkGray);
  ClrLnHor(GX1,GY1,6,TrueColor);
  Inc(GY1);
  ClrLnHor(GX1,GY1,6,TrueColor);
  Inc(GY1);
  ClrLnHor(GX1,GY1,6,Black);
  Inc(GY1,2);
 End;
 If(Show)Then __ShowMousePtr;
End;

Procedure CDROMStatus(Var Q:CDPlayer;T:Integer);Near;
Var
 A:Byte;
 S:String;
Begin
 Q.Status:=t;
 Case(t)of
  -3:S:='Le CD est chang‚';
  -2:S:='Ce n''est pas un CD audio!';
  -1:S:='Il n''y a pas CD-ROM!';
   0:S:='Prˆt';
   1:S:='Jouer';
   2:S:='Pause';
   3:S:='Arrˆter';
   4:S:='Saut ->';
   5:S:='Saut <-';
   6:S:='Recherche >>';
   7:S:='Recherche <<';
   8:S:='Porte ouverte';
   9:S:='Porte fermer';
  10:S:='Un/Shuffle';
  11:S:='Introjouer ';
 End;
 WESetKrHigh(Q.W);
 If Not(HoleMode)Then WEPutTxtXY(Q.W,6,2,StrUSpc(S,24));
 WESetKrBorder(Q.W);
End;

Procedure CDRefresh(Var QX);
Var
 Q:CDPlayer Absolute QX;
 Y1,Y2:Integer;
 GX1,GY1,I,J,TrueColor:Word;
 FKr,BKr:Byte;
Begin
 WEPutWnKrDials(Q.W,'Lecteur de Disque Compacte');
 WECloseIcon(Q.W);
 WEBar(Q.W);
 If(IsGrf)Then Begin
  If Not InBarHole(WEGetRX1(Q.W),WEGetRY1(Q.W)+5,30)Then Begin
   FKr:=Q.W.Palette.High and$F;BKr:=Q.W.Palette.High shr 4;
   GX1:=WEGetRX1(Q.W)shl 3;GY1:=GetRawY(WEGetRY1(Q.W)+6);
   If BitsPerPixel>=8Then Begin
    Y1:=GetRawY(6)+1;Y2:=Y1+HeightChr-2;
    For I:=0to HeightChr shr 1do Begin
     TrueColor:=RGB2Color(64+(Pred(I)shl 5),64+(Pred(I)shl 5),64+(Pred(I)shl 5));
     If Y2-Y1<=1Then TrueColor:=GetClassicToColor(White);
     WEClrLnHor(Q.W,0,Y1,35*8,TrueColor);
     WEClrLnHor(Q.W,0,Y2,35*8,TrueColor);
     Inc(Y1);
     Dec(Y2);
    End;
   End
    Else
   PutFillBox(GX1,GY1+1,GX1+(34 shl 3)-1,GY1+HeightChr-2,BKr);
   PutRect(GX1,GY1,GX1+(34 shl 3)-1,GY1+HeightChr-1,FKr);
    { Trace le triangle du ®Play¯ }
   For J:=1to(HeightChr shr 1)-2do Begin
    ClrLnHor(GX1+16,GY1+J+1,J shl 1,FKr);
    ClrLnHor(GX1+16,GY1+HeightChr-(J+2),J shl 1,FKr);
   End;
    { Trace les barres de pause }
   For J:=2to HeightChr-3do Begin
    ClrLnHor(GX1+32,GY1+J,5,FKr);
    ClrLnHor(GX1+39,GY1+J,5,FKr);
   End;
    { Boite de stop }
   WESetKrHigh(Q.W);
   WEPutTxtXYT(Q.W,10,6,'þ');
    { Boite de pr‚c‚dent/suivant }
   WEPutTxtXYT(Q.W,14,6,'®');
   WEPutTxtXYT(Q.W,17,6,'¯');
   WEPutTxtXYT(Q.W,21,6,'<');
   WEPutTxtXYT(Q.W,26,6,'>');
   WESetKrBorder(Q.W);
    { Injecte }
   For J:=1to HeightChr-6do PutLnHor(GX1+(31 shl 3)+4-J,GY1+J,GX1+(31 shl 3)+4+J,FKr);
   PutFillBox(GX1+(31 shl 3)+4-(HeightChr-6),GY1+HeightChr-4,
              GX1+(31 shl 3)+4+(HeightChr-6),GY1+HeightChr-3,FKr);
    { S‚parateur de fin }
   WEBarSpcHorRelief(Q.W,0,6,7);
   WEBarSpcHorRelief(Q.W,8,6,12);
   WEBarSpcHorRelief(Q.W,13,6,15);
   WEBarSpcHorRelief(Q.W,16,6,18);
   WEBarSpcHorRelief(Q.W,19,6,23);
   WEBarSpcHorRelief(Q.W,24,6,28);
   WEBarSpcHorRelief(Q.W,29,6,wnMax);
    {Barre de volume}
   CDRefreshVolume(Q);
  End;
 End
  Else
 Begin
  WESetKrSel(Q.W);
  WEPutkHor(Q.W,1,6,7,'Jouer');WEPutkHor(Q.W,10,6,3,'þ');
  WEPutkHor(Q.W,15,6,1,'®');WEPutkHor(Q.W,18,6,1,'¯');
  WEPutkHor(Q.W,21,6,3,'<');WEPutkHor(Q.W,26,6,3,'>');
  WEPutkHor(Q.W,30,6,3,'^');
  WESetKrBorder(Q.W);
 End;
 Q.OldTrack:=0;
 CDResetMenu(Q);
 CDPutTitle(Q);
 CDROMStatus(Q,Q.Status);
End;

Function CDStopAudio1(Var Q:CDPlayer):Word;Near;
Var
 rqStop:AudioPlayRequest;
Begin
 FillClr(rqStop,SizeOf(rqStop));
 rqStop.Playrqh.rqLen:=SizeOf(RequestHdr);
 rqStop.Playrqh.rqUnit:=Q.UnitDrive;
 rqStop.Playrqh.rqCmd:=STOPAUDIO;
 rqStop.AddrMode:=Red;
 ASM
  MOV AX,1510h
  LES BX,Q
  MOV CX,ES:[BX].CDPlayer.AudioDrive
  PUSH SS
  POP ES
  MOV BX,Offset rqStop
  ADD BX,BP
  INT 2Fh
  MOV AX,rqStop.Playrqh.rqStatus
 END;
End;

Function CDPlayAudio1(Var Q:CDPlayer;Start:CDAddr;nSectors:LongInt):Word;Near;
Var
 H:TDiskDevice;
Begin
 DKInit(H,DefaultCDROMPort,False);
 CDPlayAudio1:=DKPlayAudioRed(H,Start,nSectors);
 DKDone(H);
End;

Function CDPlayTracks(Var Q:CDPlayer;From,To1:LongInt):Boolean;Near;
Var
 Frames:LongInt;
Begin
 Frames:=0;
 If(Integer(From)>0)and(From<=To1)and(To1<=Q.Titles)Then Begin
  Frames:=Red2HSG(Q.Index[Integer(To1)].Start)-
          Red2HSG(Q.Index[Integer(From)].Start)+
          Q.Index[Integer(To1)].Frames;
  CDPlayAudio1(Q,Q.Index[Integer(From)].Start,Frames);
  Q.StartPlay:=Red2HSG(Q.Index[Integer(From)].Start);
  Q.EndPlay:=Q.StartPlay+Frames;
  CDPlayTracks:=True
 End
  Else
 CDPlayTracks:=No
End;

Function IOctlOut(Drive:Word;Unit1:Byte;PRequest:PInteger;rqLen:Word):Word;
Var
 rqOutp:IOCTLInpRequest;
Begin
 FillClr(rqOutp,SizeOf(rqOutp));
 rqOutp.IOctlRqh.rqLen:=SizeOf(IOCTLInpRequest);
 rqOutp.IOctlRqh.rqCmd:=IOCTLOUTP;
 rqOutp.IOCtlnBytes:=rqLen;
 rqOutp.IOCtlxFer:=PInteger(pRequest);
 rqOutp.IOctlRqh.rqUnit:=Unit1;
 ASM
  MOV AX,1510h
  MOV CX,Drive
  MOV BX,Offset rqOutp
  ADD BX,BP
  PUSH SS
  POP ES
  INT 2Fh
 END;
 IOctlOut:=rqOutp.IOctlRqh.rqStatus
End;

Procedure CDEject{Var Q:CDPlayer};Begin
 Q.rqEject.IOctlCmd:=IooEject;
 IOctlOut(Q.AudioDrive,Q.UnitDrive,@Q.rqEject,SizeOf(IOOutpEject))
End;

Function SkipAudio(Var Q:CDPlayer;Frames:LongInt):Word;
Var
 SkipDelta:LongInt;
 SkipTo:CDAddr;
 TmpStart:LongInt;
 StatAudio:AudioStatus;
 Dummy:CDAddr;
Begin
 ReadQChannel(Q,Q.TimeInfo);
 TmpStart:=LongInt(LongInt(Q.TimeInfo.dMin)*4500+LongInt(Q.TimeInfo.dSec)*75+LongInt(Q.TimeInfo.dFrame)+Frames);
 If(TmpStart>=Q.EndPlay)Then Begin
  SkipAudio:=0;
  Exit;
 End;
 If(TmpStart>Q.StartPlay)Then Begin
  HSG2Red(TmpStart,SkipTo);
  SkipDelta:=Q.EndPlay-TmpStart;
  CDStopAudio1(Q);
  CDPlayAudio1(Q,SkipTo,SkipDelta);
 End
  Else
 Begin
  CDStopAudio1(Q);
  HSG2Red(Q.StartPlay,Dummy);
  CDPlayAudio1(Q,Dummy,Q.EndPlay-Q.StartPlay);
 End;
 SkipAudio:=1;
End;

Procedure ReadQChannel(Var Q:CDPlayer;Var QC:QChannelInfo);Begin
 Q.rqQChan.IOctlCmd:=IOIQCHANINFO;
 Q.rqQChan.AddrMode:=Red;
 IOctlIn(Q,Q.AudioDrive,Q.UnitDrive,@Q.rqQChan,SizeOf(IOInpQChannel));
 QC:=Q.rqQChan.qInfo
End;

Procedure CDStop{Var Q:CDPlayer};Begin
 ReadQChannel(Q,Q.TimeInfo);
 SkipAudio(Q,-Q.Timeinfo.TMin*4500-Q.TimeInfo.TSec*75-Q.TimeInfo.TFrame);
 CDROMStatus(Q,3);
 CDStopAudio1(Q);
End;

Function AudioBusy(Var Q:CDPlayer):Word;Near;Begin
 AudioBusy:=IOctlIn(Q,Q.AudioDrive,Q.UnitDrive,@rqBusy,SizeOf(IOInpDeviceHdr))and$8200
End;

Function ResumeAudio1(Var Q:CDPlayer):Word;Near;
Var
 rqResume:AudioPlayRequest;
Begin
 FillClr(rqResume,SizeOf(rqResume));
 rqResume.Playrqh.rqLen:=SizeOf(RequestHdr);
 rqResume.Playrqh.rqUnit:=Q.UnitDrive;
 rqResume.Playrqh.rqCmd:=RESUMEAUDIO;
 rqResume.AddrMode:=Red;
 ASM
  MOV AX,1510h
  LES BX,Q
  MOV CX,ES:[BX].CDPlayer.AudioDrive
  PUSH SS
  POP ES
  MOV BX,Offset rqResume
  ADD BX,BP
  INT 2Fh
  MOV AX,rqResume.Playrqh.rqStatus
 END;
End;

Procedure CDPlayPause{Var Q:CDPlayer};Begin
 If AudioBusy(Q)<>0Then Begin
  CDROMStatus(Q,2);
  CDStopAudio1(Q)
 End
  Else
 Begin
  CDROMStatus(Q,1);
  ResumeAudio1(Q);
 End;
End;

Function GetActualTrack(Var Q:CDPlayer):Integer;Begin
 GetActualTrack:=((Integer(Q.TimeInfo.Tno)shr 4)*10)+
                          (Integer(Q.TimeInfo.Tno)and$F)
End;

Function CDRun(Var QX):Word;Var Q:CDPlayer Absolute QX;

 Procedure GetUPC(Var UPC:String);Forward;
 Function AudioPause:Word;Forward;
 Function GetTrackInfo(Tno:Byte):Byte;Forward;
 Procedure CDReset;Forward;
{ Procedure InsertCD;Forward;}
 Procedure SetVolume(Chan0,Chan1,Chan2,Chan3:Byte);Forward;
 Procedure SetInput(Chan0,Chan1,Chan2,Chan3:Byte);Forward;
 Function PlayTrack(Tno:Byte):Boolean;Forward;
 Function PlayTrackIntro(Tno:Integer):Boolean;Forward;
 Function GetTitles:Byte;Forward;
 Procedure GetLen(Tno:Char;Var Len:CDAddr);Forward;
 Procedure GetTimeInTrack(T:QChannelInfo);Forward;
 Function GetAudioDrive:Char;Forward;

 Procedure RecordTitle(Const S:String);
 Var
  Handle:Hdl;
  R:TitleRec;
  I:Byte;
 Begin
  Handle:=FileOpen(MaltePath+FileNameTitle,fmDef);
  If(Handle=errHdl)Then Handle:=FileCreate(MaltePath+FileNameTitle);
  If(Handle<>errHdl)Then Begin
   For I:=0to 10do R.Index[I]:=Q.Index[I];
   R.Title:=S;R.Piste:=Q.MaxTitles;
   _SetAbsRec(Handle,FileSize(Handle),SizeOf(R),R);
   FileClose(Handle);
  End
   Else
  ErrNoMsgOk(errWriteCDTitle);
 End;

 Procedure GetUPC(Var UPC:String);
 Var
  I:Integer;
 Begin
  IOctlIn(Q,Q.AudioDrive,Q.UnitDrive,@rqUPC,SizeOf(IOInpUPC));
  For I:=0to 7do UPC[I+1]:=rqUPC.Signature[I]
 End;

 Function AudioPause:Word;
 Var
  rqAudioStatus:IOInpAudioStatus;
 Begin
  rqAudioStatus.IOctlCmd:=IOIAUDIOSTATUS;
  IOctlIn(Q,Q.AudioDrive,Q.UnitDrive,@rqAudioStatus,SizeOf(IOInpAudioStatus));
  AudioPause:=rqAudioStatus.Report.Status and$1
 End;

 Function GetTrackInfo(Tno:Byte):Byte;
 Var
  rqTrack:IOInpTrackInfo;
 Begin
  rqTrack.IOctlCmd:=IOITRACKINFO;rqTrack.Tno:=Tno;
  IOctlIn(Q,Q.AudioDrive,Q.UnitDrive,@rqTrack,SizeOf(IOInpTrackInfo));
  GetTrackInfo:=rqTrack.Control
 End;

 Procedure CDReset;Begin
  Q.rqReset.IOctlCmd:=IooReset;
  IOctlOut(Q.AudioDrive,Q.UnitDrive,@Q.rqReset,SizeOf(IOOutpEject))
 End;

 Procedure InsertCD(Var Q:CDPlayer);
 Var
  SubData:Record
   Command:Byte;
  End;
  Data:Record
   Len:Byte;
   SubUnit:Byte;
   CommandCode:Byte;
   Status:Word;
   DevName:Array[1..8]of Char;
   MediaDescriptor:Byte;
   Buffer:Pointer;
   BufferSize:Word;
   StartSector:LongInt;
   VolumePtr:LongInt;
  End;
 Begin
  FillClr(SubData,SizeOf(SubData));
  SubData.Command:=5;
  FillClr(Data,SizeOf(Data));
  Data.Len:=SizeOf(Data);
  Data.CommandCode:=12;
  Data.Buffer:=@SubData;
  Data.BufferSize:=SizeOf(SubData);
  ASM
   LES DI,Q
   MOV AX,1510h
   MOV CX,ES:[DI].CDPlayer.AudioDrive
   MOV BX,Offset Data
   ADD BX,BP
   PUSH SS
   POP ES
   INT 2Fh
  END;
 End;

 Procedure SetVolume(Chan0,Chan1,Chan2,Chan3:Byte);Begin
  Q.rqVolume.IOctlCmd:=IOIAUDIOCHANINFO;
  IOctlIn(Q,Q.AudioDrive,0,@Q.rqVolume,SizeOf(IOInpAudiochanInfo));
  Q.rqVolume.IOctlCmd:=IOOAUDIOCHANCTRL;
  Q.rqVolume.VolChan0:=Chan0;
  Q.rqVolume.VolChan1:=Chan1;
  Q.rqVolume.VolChan2:=Chan2;
  Q.rqVolume.VolChan3:=Chan3;
  IOctlOut(Q.AudioDrive,Q.UnitDrive,@Q.rqVolume,SizeOf(IOInpAudiochanInfo))
 End;

 Procedure SetInput(Chan0,Chan1,Chan2,Chan3:Byte);Begin
  Q.rqInput.IOctlCmd:=IoiAudioChanInfo;
  IOctlIn(Q,Q.AudioDrive,Q.UnitDrive,@Q.rqInput,SizeOf(IOInpAudioChanInfo));
  Q.rqInput.IOctlCmd:=IooAudioChanCtrl;
  Q.rqInput.InpChan0:=Chan0;
  Q.rqInput.InpChan1:=Chan1;
  Q.rqInput.InpChan2:=Chan2;
  Q.rqInput.InpChan3:=Chan3;
  IOctlOut(Q.AudioDrive,Q.UnitDrive,@Q.rqInput,SizeOf(IOInpAudioChanInfo));
 End;

 Function PlayTrack(Tno:Byte):Boolean;Begin
  If(Tno<=Q.Titles)Then Begin
   CDPlayAudio1(Q,Q.Index[Integer(Tno)].Start,Q.Index[Integer(Tno)].Frames);
   Q.StartPlay:=Red2HSG(Q.Index[Integer(Tno)].Start);
   Q.EndPlay:=Red2HSG(Q.Index[Integer(Tno)].Start)+Q.Index[Integer(Tno)].Frames;
   PlayTrack:=True;
  End
   Else
  PlayTrack:=No;
 End;

 Function PlayTrackIntro(Tno:Integer):Boolean;Begin
  If(Tno>=0)and(Tno<=Integer(Q.Titles))Then Begin
   CDPlayAudio1(Q,Q.Index[Tno].Start,10*75);
   Q.StartPlay:=Red2HSG(Q.Index[Tno].Start);
   Q.EndPlay:=Red2HSG(Q.Index[Tno].Start)+(10*75);
   PlayTrackIntro:=True;
  End
   Else
  PlayTrackIntro:=No
 End;

 Function GetTitles:Byte;Begin
  GetTitles:=Q.Titles
 End;

 Procedure GetLen(Tno:Char;Var Len:CDAddr);Begin
  Len:=Q.Index[Integer(Tno)].Delta
 End;

 Procedure GetTimeInTrack(T:QChannelInfo);Begin
  ReadQChannel(Q,Q.TimeInfo);
  T:=Q.TimeInfo
 End;

 Function GetAudioDrive:Char;Begin
  GetAudioDrive:=Char(Q.AudioDrive)
 End;

 Procedure TrackTyp;Begin
  Q.Actual:=GetActualTrack(Q);
  If(Q.Actual>Q.MaxTitles)Then Begin
   CDStopAudio1(Q);
   CDPlayTracks(Q,Long(1),Long(Q.MaxTitles));
   CDStopAudio1(Q);
   Q.Actual:=GetActualTrack(Q);
   CDROMStatus(Q,3);
  End;
  If(Q.Actual<>Q.OldTrack)Then Begin
   Q.OldTrack:=Q.Actual;
   WESetKrSel(Q.W);
   WEPutTxtXY(Q.W,6,3,Str0(Q.Actual,2)+'/'+Str0(Q.MaxTitles,2));
   WESetKrBorder(Q.W);
   If GetTrackInfo(Q.Actual)=$40Then Begin
    CDROMStatus(Q,3);
    CDStopAudio1(Q);
   End;
  End;
 End;

 Procedure Time;Begin
  ReadQChannel(Q,Q.TimeInfo);
  If AudioBusy(Q)<>0Then Begin
   With Q.TimeInfo do Begin
    If(TSec<>Q.OldTSec)Then Begin
     Q.OldTSec:=TSec;
     WESetKrSel(Q.W);
     WEPutTxtXY(Q.W,6,4,Str0(tMin,2)+':'+Str0(tSec,2));
     WEPutTxtXY(Q.W,12,4,Str0(Q.Index[Tno].Delta.Time.Minute,2)+':'+Str0(Q.Index[Tno].Delta.Time.Second,2));
     WESetKrBorder(Q.W);
    End;
   End;
  End
   else
  If(Q.Status=3)or(Q.Status=0)Then Begin
   With Q.TimeInfo do Begin
    If(TSec<>Q.OldTSec)Then Begin
     Q.OldTSec:=TSec;
     WESetKrSel(Q.W);
     WEPutTxtXY(Q.W,6,4,'00:00');
     WEPutTxtXY(Q.W,12,4,Str0(Q.Index[Tno].Delta.Time.Minute,2)+':'+Str0(Q.Index[Tno].Delta.Time.Second,2));
     WESetKrBorder(Q.W);
     CDUpDateTotalTime(Q);
    End;
   End;
  End;
 End;

 Function Init:Boolean;
 Var
  RR,MX,MY:Byte;
  K,B:Word;
 Begin
  Q.OldTrack:=255;Q.OldTMin:=255;Q.OldTSec:=255;
  CDResetMenu(Q);
  Init:=No;K:=0;
  __ShowMousePtr;
  _InitKbd;
  Repeat
   _BackKbd;
   Q.MaxTitles:=InitCDAudio(Q);
   If Q.MaxTitles<0Then CDROMStatus(Q,Q.MaxTitles);
   __GetMouseTextSwitch(MX,MY,B);
   If B>0Then Begin
    If WEInCloseIcon(Q.W,MX,MY)Then Begin
     Init:=True;
     Exit;
    End
     Else
    If WEInWindow(Q.W,MX,MY)Then Begin
     If MY-WEGetRY1(Q.W)=5Then Begin
      WaitMouseBut0;
      Case MX-WEGetRX1(Q.W)of
       0..28:;
       Else Begin
        CDROMStatus(Q,9);
        InsertCD(Q);
        CDUpDateTotalTime(Q);
       End;
      End;
     End;
    End;
   End;
   If(KeyPress)Then Begin
    K:=ReadKey;
    If(K=kbEsc)Then Begin
     Init:=True;
     Exit;
    End
     Else
    Case UpCase(Chr(K))of
     'Q':Begin
      Init:=True;
      Exit;
     End;
     'C':Begin
      CDROMStatus(Q,9);
      InsertCD(Q);
      CDUpDateTotalTime(Q);
     End;
     'P':Begin
      K:=Byte('P');
      CDROMStatus(Q,1);
      InsertCD(Q);
     End;
     'O':Begin
      CDROMStatus(Q,8);
      CDEject(Q);
     End;
    End;
   End;
  Until Q.MaxTitles>0;
  __HideMousePtr;
  Q.Actual:=GetActualTrack(Q);
  CDROMStatus(Q,0);
  If AudioBusy(Q)<>0Then K:=Byte('P');
  If AudioPause=0Then Begin
   If K=Byte('P')Then Begin
    RR:=1;
    Repeat
     CDPlayTracks(Q,Long(RR),Long(Q.MaxTitles));
     Inc(RR);
    Until(RR>Q.MaxTitles)or(AudioBusy(Q)<>0);
    CDROMStatus(Q,1);
   End
    Else
   Begin
    CDPlayTracks(Q,Long(1),Long(Q.MaxTitles));
    CDStopAudio1(Q);
    CDROMStatus(Q,3);
   End;
  End
   Else
  CDROMStatus(Q,2);
  Init:=No;Q.Actual:=0;
  TrackTyp;
  Q.Actual:=1;
  CDPutTitle(Q);
 End;

 Procedure CallPrevSkip;Begin
  CDROMStatus(Q,7);
  SkipAudio(Q,-15*75);
  CDROMStatus(Q,1)
 End;

 Procedure CallNextSkip;Begin
  CDROMStatus(Q,6);
  SkipAudio(Q,15*75);
  CDROMStatus(Q,1)
 End;

Label Start;
Var
 MX,MY:Byte;
 B:Word;
 Check:Integer;
 Alt,LT,CT:Byte;
 Volume:Byte;    { Variable pour l'ajustement du volume }
Begin
Start:
 LT:=$FF;
 Repeat
  Case(Q.Mode)of
   cdOpen:Begin
    If(Init)Then Begin
     CDRun:=kbClose;
     __HideMousePtr;
     Exit;
    End;
    Q.Mode:=cdClose;Q.RR:=0;Q.P:=0;
   End;
   cdClose:Begin
    Q.RR:=0;
    _InitKbd;
    Repeat
     __ShowMousePtr;
     CT:=GetRawTimerB shr 4;
     If(LT<>CT)Then Begin
      LT:=CT;
      Time;
      _BackKbd;
      TrackTyp;
      If(Q.Status=1{Joue})and(AudioBusy(Q)=0)Then Begin
       _BackKbd;
       CDROMStatus(Q,Q.status);
       Q.RR:=0;
       CDReset;
       Q.Mode:=cdOpen;
       Goto Start;
      End;
     End;
     Q.RR:=0;
     _BackKbd;
     __GetMouseTextSwitch(MX,MY,B);
     If B>0Then Begin
      If WEInCloseIcon(Q.W,MX,MY)Then Begin
       WaitMouseBut0;
       Q.RR:=kbClose;
       __HideMousePtr;
       Break;
      End
       Else
      If WEInTitle(Q.W,MX,MY)Then Begin
       Q.RR:=kbTitle;
       Break;
      End
       Else
      If WEInWindow(Q.W,MX,MY)Then Begin
       If(MX=WEGetRX1(Q.W)+Q.W.MaxX)and(MY<WEGetRY1(Q.W)+5)and(MY>WEGetRY1(Q.W))Then Begin
        Volume:=15-((__GetMouseYPixels-GetRawY(WEGetRY1(Q.W)+1))shr 2);
        SetCDVolume(Volume+(Volume shl 4));
        CDRefreshVolume(Q);
        WaitMouseBut0;
       End
        Else
       If MY-WEGetRY1(Q.W)=6Then Begin
        WaitMouseBut0;
        Case MX-WEGetRX1(Q.W)of
         0..7:CDPlayPause(Q);
         8..12:CDStop(Q);
         13..15:CallPrevSkip;
         16..18:CallNextSkip;
         19..23:CDPrevTrack(Q);
         24..28:CDNextTrack(Q);
         Else Begin
          If(Q.Status)in[3,8]Then Begin
           CDROMStatus(Q,9);
           InsertCD(Q);
           CDUpDateTotalTime(Q);
          End
           Else
          Begin
           CDROMStatus(Q,8);
           CDEject(Q);
           Q.Mode:=cdOpen;
           Goto Start;
          End;
         End;
        End;
       End;
      End
       Else
      Begin
       Q.RR:=kbMouse;
       Break;
      End;
     End;
     If(KeyPress)Then Q.RR:=WEReadk(Q.W);
     If Lo(Q.RR)=0Then Case(Q.RR)of
      kbLeft:CDPrevTrack(Q);
      kbRight:CDNextTrack(Q);
      kbIns:If Q.CurrTitle=''Then Begin
       If(_WinInp(MaxLenTitle,'D‚finition du Disque compacte',
          'Entrez le titre:',No,Q.CurrTitle)=kbEnter)Then Begin
        RecordTitle(Q.CurrTitle);
        CDPutTitle(Q);
       End;
      End;
      Else If Q.RR<>0Then Break;
     End
      Else
     Case UpCase(Char(Q.RR))of
      '+':CallNextSkip;
      '-':CallPrevSkip;
      'P':CDPlayPause(Q);
      'S':CDStop(Q);
      'O':Begin
       CDROMStatus(Q,8);
       CDEject(Q);
       Q.Mode:=cdOpen;
       Goto Start;
      End;
      'C':Begin
       CDROMStatus(Q,9);
       InsertCD(Q);
       CDUpDateTotalTime(Q);
      End;
      #8:Begin
       Q.T[0]:='_';Q.T[1]:='_';
       WEPutTxtXY(Q.W,31,1,Q.T[0]+Q.T[1]);
       Q.P:=0;
      End;
      '0'..'9',#13:Begin
       Q.T[1]:='_';Q.T[Q.P]:=Char(Q.RR);
       If(Char(Q.rr)=#13)and(Q.P=1)Then Begin
        Q.T[1]:=Q.T[0];Q.T[0]:='0';
       End
        else
       If Char(Q.RR)=#13Then Q.RR:=0;
       If Q.RR<>0Then Begin
        Inc(Q.P);
        If Q.P=2Then Begin
         val(Q.t[0]+Q.t[1],Q.P,check);
         If(Q.P<1)or(Q.P>Q.MaxTitles)Then Begin
          Q.t[0]:='_';
          Q.t[1]:='_';
         End
          else
         Begin
          CDStopAudio1(Q);
          CDROMStatus(Q,1);
          CDPlayTracks(Q,Long(Q.P),Long(Q.MaxTitles));
         End;
         Q.P:=0;
        End;
        WEPutTxtXY(Q.W,31,2,Q.T[0]+Q.T[1]);
       End;
      End;
      Else If Q.RR<>0Then Break;
     End;
    Until(No);
    __HideMousePtr;
    Break;
   End;
  End;
 Until No;
 CDRun:=Q.RR;Q.RR:=0;
End;

Procedure CDPrevTrack{Var Q:CDPlayer};Begin
 CDROMStatus(Q,5);
 Dec(Q.Actual);
 If Q.Actual<1Then Q.Actual:=Q.MaxTitles;
 CDStopAudio1(Q);
 CDPlayTracks(Q,Long(Q.Actual),Long(Q.MaxTitles));
 CDROMStatus(Q,1);
End;

Procedure CDNextTrack{Var Q:CDPlayer};Begin
 CDROMStatus(Q,4);
 Inc(Q.Actual);
 If(Q.Actual>Q.MaxTitles)Then Q.Actual:=1;
 CDStopAudio1(Q);
 CDPlayTracks(Q,Long(Q.Actual),Long(Q.MaxTitles));
 CDROMStatus(Q,1);
End;

Procedure CDCheck{Var Q:CDPlayer};Begin
 ReadQChannel(Q,Q.TimeInfo);
 Q.Actual:=GetActualTrack(Q);
End;

Function CDTitle{Var QX;Max:Byte):String};Begin
 If Max<9Then CDTitle:='CD'Else
 If Max<12Then CDTitle:='Joueur CD'Else
 If Max<25Then CDTitle:='Joueur de CD'
          Else CDTitle:='Joueur de Compacte Disque';
End;

Function CDDone{Var QX):Word};Var Q:CDPlayer Absolute QX;Begin
 WEDone(Q.W);
 CDDone:=0;
End;

Procedure CDMove2{Var QX;X,Y:Byte};
Var
 Q:CDPlayer Absolute QX;
 MX,MY:Byte;
Begin
 MX:=Q.W.T.X2-Q.W.T.X1;MY:=Q.W.T.Y2-Q.W.T.Y1;
 Q.W.T.X1:=X;Q.W.T.X2:=X+MX;
 Q.W.T.Y1:=Y;Q.W.T.Y2:=Y+MY;
 CDRefresh(Q);
End;

Procedure StartCDPLayer;
Var
 Q:CDPlayer;
Begin
 CDInitApp(Q,0,0,35,7+Byte(Not(IsGrf)));
 CDRefresh(Q);
 CDRun(Q);
 CDDone(Q);
End;

{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                         Fonction MnuNoSound                     Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Portabilit‚: Global


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette fonction permet … l'utilisateur de choisir une sortie de son
  appropri‚ pour son jouer de ®.MOD¯.
}

Function MnuNoSound{:Byte};
{$IFNDEF Windows}
 Const NoSound:Array[0..Length('Pas de son')]of Char='Pas de son'#0;
  PCSpeaker:Array[0..Length('PC Speaker')]of Char='PC Speaker'#0;
  ConvLPT:Array[0..Length('Convertisseur D/A dans LPT?')]of Char=
   'Convertisseur D/A dans LPT?'#0;
  StereoBi:Array[0..Length('Stereo dans LPT1 et LPT2')]of Char=
   'Stereo dans LPT1 et LPT2'#0;
  StereoIn:Array[0..Length('Stereo dans LPT1')]of Char='Stereo dans LPT1'#0;
Var Mnu:LstMnu;K:Wd;
{$ENDIF}
Begin
 {$IFNDEF Windows}
  LMInitKrDials(Mnu,8,8,wnMax-8,wnMax-8,'Sortie Son');
  ALAddPChrWord(Mnu.List,@NoSound,soNul);
  ALAddPChrWord(Mnu.List,@PCSpeaker,soPCSpeaker);
  If(LPT1Exist)Then Begin
   ConvLPT[SizeOf(ConvLPT)-1]:='1';
   ALAddPChrWord(Mnu.List,@ConvLPT,soLPT1)
  End;
  If(LPT2Exist)Then Begin
   ConvLPT[SizeOf(ConvLPT)-1]:='2';
   ALAddPChrWord(Mnu.List,@ConvLPT,soLPT2)
  End;
  If(LPT1Exist)and(LPT2Exist)Then ALAddPChrWord(Mnu.List,@StereoBi,soStereoLPT1N2);
  If(LPT1Exist)Then Begin
   StereoIn[SizeOf(StereoIn)-1]:='1';
   ALAddPChrWord(Mnu.List,@StereoIn,soStereoLPT1)
  End;
  If(LPT2Exist)Then Begin
   StereoIn[SizeOf(StereoIn)-1]:='2';
   ALAddPChrWord(Mnu.List,@StereoIn,soStereoLPT2)
  End;
  If(LMRunKbd(Mnu)=kbEnter)Then MnuNoSound:=LMGetVal(Mnu)
                           Else MnuNoSound:=soNul;
  LMDone(Mnu)
 {$ENDIF}
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Fonction SelOutput                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Portabilit‚: Global


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de choisir une sortie de son ‚tendue par d‚faut
 pour les joueur de ®.MOD¯.
}

Function SelOutput{:Byte};Begin
 If(IsSoundBlaster)Then SoundOutPut:=soSoundBlaster
                   Else SoundOutPut:=MnuNoSound;
 SelOutput:=SoundOutput
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
END.