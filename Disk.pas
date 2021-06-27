{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                                                                         Û
 ³                         Malte Genesis/Disque                            Û
 ³                                                                         Û
 ³            dition Chantal pour Mode R‚el/IV - Version 1.1              Û
 ³                              2001/08/06                                 Û
 ³                                                                         Û
 ³          Tous droits r‚serv‚s par les Chevaliers de Malte (C)           Û
 ³                                                                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Nom du programmeur
 ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

  Sylvain Maltais


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette unit‚ contient les divers routines tant au niveau physique que
 logique pour manipuler les unit‚s disques, CD-ROM ou virtuel.
}

{$I DEF.INC}

Unit Disk;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                  INTERFACE
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses Systex;

Const
  { Adresse des ports IDE }
 idePort:Array[0..3]of Word=(
  $1F0,
  $170,
  $1E8,
  $168
 );

 DefaultCDROMPort:Byte=0;

 idePortDATA=$0;                 {16 bits (optionnel) lecture/‚critre}
 idePortError=$1;                {Lecture}
 idePortFeature=$1;              {criture}
 idePortSectorCount=$2;          {Lecture/‚criture}
 idePortSec=$3;                  {Lecture/‚criture}
 idePortCyl=$4;                  {16 bits (optionnel) lecture/‚criture}
 idePortCylLo=$4;
 idePortCylHi=$5;
 idePortDrive=$6;                {Lecture/‚criture}
 idePortStatus=$7;               {Lecture}
 idePortCommand=$7;              {criture}
 idePortStatusEx=$206;           {Lecture}
 idePortControl=$206;            {criture}
 idePortAddress=$207;            {Lecture}

  {Liste des commandes du contr“leur IDE ATAPI}
 cmdExecuteDriveDiagnostics=$90;
 cmdFormatTrack=$50;
 cmdInitDriveParameters=$91;
 cmdRecalibrate=$10;             { 010h … 01Fh}
 cmdReadSectorsRep=$20;
 cmdReadSectors=$21;
 cmdReadLongRep=$22;
 cmdReadLong=$23;
 cmdReadVerifySectorsRep=$40;
 cmdReadVerifySectors=$41;
 cmdSeek=$70;                    { 070h … 07Fh}
 cmdWriteSectorsRep=$30;
 cmdWriteSectors=$31;
 cmdWriteLongRep=$32;
 cmdWriteLong=$33;
 cmdAckMediaChange=$DB;
 cmdCheckPowerMode=$98;          { Optionnel}
 cmdCheckPowerMode2=$E5;
 cmdDoorLock=$DE;
 cmdDoorUnlock=$DF;
 cmdIdentifyDrive=$EC;
 cmdIdentifyATAPIDrive=$A1;
 cmdIdle=$97;                    { Optionnel }
 cmdIdle2=$E3;
 cmdIdleImmediate=$95;           { Optionnel }
 cmdIdleImmediate2=$E1;
 cmdReadBuffer=$E4;
 cmdReadDmaRep=$C8;
 cmdReadDma=$C9;
 cmdReadDriveState=$E9;
 cmdReadMultiple=$C4;
 cmdRest=$E7;
 cmdRestoreDriveState=$EA;
 cmdSetFeatures=$EF;
 cmdSetMultipleMode=$C6;
 cmdSleep=$99;                   { Optionnel }
 cmdSleep2=$E6;
 cmdStandBy=$96;                 { Optionnel }
 cmdStandBy2=$E2;
 cmdStandByImmediate=$94;        { Optionnel }
 cmdStandByImmediate2=$E0;
 cmdWriteBuffer=$E8;
 cmdWriteDmaRep=$CA;
 cmdWriteDma=$CB;
 cmdWriteMultiple=$C5;
 cmdWriteSame=$E9;
 cmdWriteVerify=$3C;
 cmdAtapiSoftReset=$08;

 drvMaster=False;
 drvSlave=True;
 ResetDrive=True;
 NoResetDrive=False;

  { Valeur de retour de ®GetStatus¯ }
 AstBsy=$80;
 AstDRDY=$40;
 AstDmaReady=$20;
 AstDF=$20;
 AstService=$10;
 AstDsc=$10;
 AstDRQ=$08;
 AstCorr=$04;
 AstCheck=$01;

  { Valeur de retour de ®GetError¯ }
 AerSenseKey=$F0;
 AerMCR=$08;
 AerABRT=$04;
 AerEOM=$02;
 AerILI=$01;

 {®SetFeatures¯}
 AftOverlap=$02;
 AftDma=$01;

 {®GetInterruptReason¯}
 AirRelease=$04;
 AirIO=$02;
 AirCOD=$01;

 {®SetDeviceControl¯}
 AdcSRST=$04;
 AdcNIEN=$02;

 { Commandes ®ATAPI¯ }
 AcInquiry=$12;
 AcReadTOC=$43;
 AcPlayAudio=$45;
 AcStartStopUnit=$1B;
 AcReadCD=$BE;
 AcReadSubChannel=$42;
 AcSetCDSpeed=$BB;
 AcModeSense=$5A;
 AcModeSelect=$55;
 AcRequestSense=$03;
 AcWrite10=$2A;
 AcSyncCache=$35;
 AcTestUnitReady=$00;
 AcBlank=$A1;
 AcCloseTrackSession=$5B;
 AcReadDiscInfo=$51;
 AcReadTrackInfo=$52;
 AcReserveTrack=$53;

 {Quelques constantes}
 MaxToCDataLen=804;
 MaxDataBlock=$8000;
 MaxCDDataBlock=2048;
 MaxCDDADataBlock=2352;
 MaxRAWDataBlock=2368;
 MaxSenseBuffer=$FFF8;
 PacketCommandSize=12;

 {Types de secteur pour ®ReadCD¯ }
 SecTypeAnyType=0;
 SecTypeCDDA=1;
 SecTypeMode1=2;
 SecTypeMode2=3;
 SecTypeMode1Form2=4;
 SecTypeMode2Form2=5;

 {Drapeaux pour ®READCD¯}
 RcdfSynch=$80;
 RcdfNoHdr=$00;
 RcdfHhrOnly=$20;
 RcdfSubHdrOnly=$40;
 RcdfHdr=$60;
 RcdfUserData=$10;
 RcdfEDCECC=$08;
 RcdfNoErrInf=$00;
 RcdfErrC2Inf=$02;
 RcdfErrC2AndBlockInf=$04;

 {®SetCDSpeed¯}
 ScdsMaxSpeed=$FFFF;
 ScdsNone=0;

 {Champs de s‚lection de sous canal de donn‚es pour le ®READCD¯ }
 RcdscNoSubChData=$0;  {Toutes les autres valeurs sont r‚serv‚s!}
 RcdscRaw=$1;
 RcdscQ=$2;
 RcdscRW=$4;

 {Type de m‚dia dans ®ModeParametersHeader¯ }
 MtUNKNOWN=$00;
 MtCDROMDATA120=$01;
 MtCDAUDIO120=$02;
 MtCDROMMIXED120=$03;
 MtCDROMHYBRID120=$04;
 MtCDROMDATA80=$05;
 MtCDAUDIO80=$06;
 MtCDROMMIXED80=$07;
 MtCDROMHYBRID80=$08;
 MtCDRUNKNOWN=$10;
 MtCDRDATA120=$11;
 MtCDRAUDIO120=$12;
 MtCDRMIXED120=$13;
 MtCDRHYBRID120=$14;
 MtCDRDATA80=$15;
 MtCDRAUDIO80=$16;
 MtCDRMIXED80=$17;
 MtCDRHYBRID80=$18;
 MtCDRWUnknown=$20;
 MtCDRWDATA120=$21;
 MtCDRWAUDIO120=$22;
 MtCDRWMIXED120=$23;
 MtCDRWHYBRID120=$24;
 MtCDRWDATA80=$25;
 MtCDRWAUDIO80=$26;
 MtCDRWMIXED80=$27;
 MtCDRWHYBRID80=$28;
 MtNoDisc=$70;
 MtDoorOpen=$71;

 {®CloseTrackSession¯ ®CloseTypes¯ }
 CtstTrack=$01;
 CtstSession=$02;

 {®ReadTrackInformation¯}
 RtiTRACK=True;
 RtiLBA=False;

 {Format de donn‚es de ®ReadSubChannel¯ }
 RscCurPos=$01;
 RscMCN=$02;
 RscISRC=$03;

 {Drapeaux de ®ReadSubChannel¯ }
 RscfMSF=$01;
 RscfSUBQ=$02;

 { ®Blank¯ }
 BlankDisc=0;   { Disque vierge }
 BlankMinimal=1;
 BlankTrack=2;

Type
 CDAddr=Record Case Integer Of
  0:(HSGSector:Word);
  1:(Time:Record
   Frame:Byte;
   Second:Byte;
   Minute:Byte;
   Unused:Byte;
  End);
 End;

 RequestHdr=Record
  rqLen:Byte;
  rqUnit:Byte;
  rqCmd:Byte;
  rqStatus:Word;
  Reserved:Array[0..7]of Byte;
 End;

 AudioPlayRequest=Record
  Playrqh:RequestHdr;
  AddrMode:Byte;         { ®RED¯ ou ®HSG¯ }
  Start:CDAddr;          { ®Startframe¯ }
  nFrames:LongInt;
 End;

 PPacketCommand=^TPacketCommand;
 TPacketCommand=Array[0..11]of Byte;

 PPacketCommandData=^TPacketCommandData;
 TPacketCommandData=Array[0..5]of Word;

 PTOCHeader=^TTOCHeader;
 TTOCHeader=Record
  TocDataLength:Word;
  FirstTrackNr,LastTrackNr:Byte;
 End;

 PTOC=^TTOC;
 TTOC=Record
  TocDataLength:Word;
  FirstTrack,LastTrack:Byte;
  Entry:Array[0..255]of Record
   Reserved1:Byte;
   ADRControl:Byte;
   TrackNr:Byte;
   Reserved2:Byte;
   LBA:LongInt;
  End;
 End;

 TModeParametersHeader=Record
  ModeDataLength:Word;
  MediumType:Byte;
  Reserved:Array[1..5]of Byte;
 End;

 TPCReadTOC=Record
  OpCode:Byte;                   { = 043h }
  MSF:Byte;                      { Bit 1 }
  FormatMMC:Byte;                { Bits 0 … 2 }
  Reserved1:Array[1..3]of Byte;
  StartTrackOrSession:Byte;
  AllocLength:Word;              { chang‚e!}
  Format:Byte;                   { Bits 6 … 7}
  Reserved2:Array[1..2]of Byte;
 End;

 TPCInquiry=Record
  OpCode:Byte;                   { = 12h }
  Reserved1:Array[1..3]of Byte;
  AllocLength:Byte;
  Reserved2:Array[1..7]of Byte;
 End;

 TPCModeSense=Record
  OpCode:Byte;                  { = 05Ah }
  Reserved1:Byte;
  PageControlCode:Byte;         { Bits 6 … 7 -> Ctrl}
                                { Bits 0 … 5 -> Code}
  Reserved2:Array[1..4]of Byte;
  AllocLength:Word;
  Reserved3:Array[1..3]of Byte;
 End;

 TPCModeSelect=Record
  OpCode:Byte;                  { = 055h }
  PFSP:Byte;                    { = 010h }
  Reserved1:Array[1..5]of Byte;
  AllocLength:Word;
  Reserved3:Array[1..3]of Byte;
 End;

 TPCPlayAudio=Record
  OpCode:Byte;                  { = 045h }
  Reserved1:Byte;
  StartLBA:LongInt;
  Reserved2:Byte;
  TransferLength:Word;
  Reserved3:Array[1..3]of Byte;
 End;

 TPCStartStopUnit=Record
  OpCode:Byte;                  { = 01Bh }
  Immed:Byte;                   { Bit 0 }
  Reserved1:Array[1..2]of Byte;
  LoadUnloadAndStart:Byte;      { Bits 0 … 1 }
  Reserved2:Array[1..7]of Byte;
 End;

 TPCReadCD=Record
  OpCode:Byte;                      { = 0BEh }
  ExpectedSectorType:Byte;          { Bits 2 … 4 }
  StartLBA:LongInt;
  TransferLength:Array[0..2]of Byte;
  FlagBits:Byte;
  SubChannelDataSel:Byte;           { Bits 0 … 2 }
  Reserved1:Byte;
 End;

 TPCReadSubChannel=Record
  Opcode:Byte;                   { = 042h }
  MSF:Byte;                      { Bit 1 }
  SubQ:Byte;                     { Bit 6 }
  SubChannelDataFormat:Byte;     { 01h -> Position courante }
                                 { 02h -> MCN/UPC}
                                 { 03h -> ISRC}
  Reserved1:Array[1..2]of Byte;
  TrackNr:Byte;                  {Seulement pour ISRC !}
  AllocLength:Word;              {changer!}
  Reserved2:Array[1..3]of Byte;
 End;

 TPCWrite10=Record
  OpCode:Byte;                   { = 02Ah }
  DPOFUARELADR:Byte;             { Bit 4 -> DPO }
                                 { Bit 3 -> FUA }
                                 { Bit 0 -> RELADR }
  LBA:LongInt;
  Reserved1:Byte;
  TransferLength:Word;
  Reserved2:Array[1..3]of Byte;
 End;

 TPCSyncCache=Record
  OpCode:Byte;                   { = 035h }
  Immed:Byte;                    { Bit 1 }
  Reserved:Array[1..10]of Byte;
 End;

 TPCSetCDSpeed=Record
  OpCode:Byte;                   { = 0BBh }
  Reserved1:Byte;
  ReadDriveSpeed:Word;
  WriteDriveSpeed:Word;
  Reserved2:Array[1..6]of Byte;
 End;

 TPCRequestSense=Record
  OpCode:Byte;                   { = 003h }
  Reserved1:Array[1..3]of Byte;
  AllocLength:Byte;
  Reserved2:Array[1..7]of Byte;
 End;

 TPCTestUnitReady=Record
  OpCode:Byte;                   { = 000h }
  Reserved:Array[1..11]of Byte;
 End;

 TPCBlank=Record
  OpCode:Byte;                   { = 0A1h }
  ImmedBlankType:Byte;           { bit 4:      Immed }
                                 { bits 0 … 2: Type}
  StartLBA:LongInt;
  Reserved:Array[1..6]of Byte;
 End;

 TPCCloseTrackSession=Record
  OpCode:Byte;                   { = 05Bh }
  Immed:Byte;                    { bit 0:  Immédiat }
  SessionTrack:Byte;             { bit 0:  Cylindre }
                                 { bit 1:  Session }
  Reserved1:Array[1..2]of Byte;
  TrackNr:Byte;
  Reserved2:Array[1..6]of Byte;
 End;

 TPCReadDiscInformation=Record
  OpCode:Byte;                   { = 051h }
  Reserved1:Array[1..6]of Byte;
  AllocLength:Word;
  Reserved2:Array[1..3]of Byte;
 End;

 TPCReadTrackInformation=Record
  OpCode:Byte;                   { = 052h }
  Track:Byte;                    { Bit  0   Drapeau de cylindre }
  LBAOrTrackNr:LongInt;
  Reserved1:Byte;
  AllocLength:Word;
  Reserved2:Array[1..3]of Byte;
 End;

 TPCReserveTrack=Record
  OpCode:Byte;                   { = 053h }
  Reserved1:Array[1..4]of Byte;
  ReservationSize:LongInt;
  Reserved2:Array[1..3]of Byte;
 End;

 PResponseBuffer=^TResponseBuffer;
 TResponseBuffer=Array[0..32760]of Word;

 PSenseBuffer=^TSenseBuffer;
 TSenseBuffer=Record
  ErrorCode:Byte;                { Bit  7     -> Valide }
                                 { Bits 0 … 6 -> Code d'erreur }
  SegmentNumber:Byte;            { R‚serv‚ }
  ILISenseKey:Byte;              { Bit  5     -> ILI}
                                 { Bits 0 … 3 -> ®Sense Key¯ }
  Information:Byte;
  Reserved1:Array[1..3]of Byte;
  AdditionalSenseLength:Byte;
  CommandSpecificInformation:Byte;
  Reserved2:Array[1..3]of Byte;
  ASC:Byte;
  ASCQ:Byte;
  SenseKeySpecific:Byte;         { Bit  7     -> Valide }
                                 { Bits 0 … 6 -> SKS}
  Reserved3:Array[1..2]of Byte;
  AdditionalSenseBytes:Array[0..255-17]of Byte;
 End;

 PDiscInformation=^TDiscInformation;
 TDiscInformation=Record
  DataLength:Word;
  DiscFlags:Byte;                { Bit  4     -> Effacable }
                                 { Bits 2 … 3 -> tat des derniŠres sessions }
                                 { Bits 0 … 1 -> tat du disque }
  FirstTrackNr:Byte;
  SessionCount:Byte;
  FirstTrackInLastSession:Byte;
  LastTrackInLastSession:Byte;
  IDFlags:Byte;                  { Bit  7     -> Identificateur de disque valide }
                                 { Bit  6     -> Disque valide }
                                 { Bit  5     -> Utilisation restrainte }
  DiscType:Byte;
  Reserved1:Array[1..3]of Byte;
  DiscID:LongInt;
  LeadInStartInLastSession:LongInt;
  LastPossibleLeadOut:LongInt;
  DiscBarCode:Array[0..5]of Byte;
  Reserved:Byte;
  OPCEntryCount:byte;
  OPCEntry:Array[0..$FF]of Record
   Speed:Word;
   OPCVal:Array[0..5]of Byte;
  End;
 End;

 PTrackInformation=^TTrackInformation;
 TTrackInformation=Record
  DataLength:Word;
  TrackNr:Byte;
  SessionNr:Byte;
  Reserved1:Byte;
  TrackFlags:Byte;   { Bit  5   -> Endommag‚ }
                     { Bit  4   -> Copie }
                     { Bits 0-3 -> Mode de piste }
  TrackType:Byte;    { Bit  7   -> Cylindre r‚serv‚ }
                     { Bit  6   -> blanc }
                     { Bit  5   -> Paquet}
                     { Bit  4   -> Paquet fixe}
                     { Bits 0-3 -> Mode de donn‚es}
  NWAValid:Byte;     { Bit  0   -> NWA valide }
  StartLBA:LongInt;
  NextWritableAddr:LongInt;
  FreeBlocks:LongInt;
  FixedPacketSize:LongInt;
  TrackSize:LongInt;
 End;

 PWritePageParameters=^TWritePageParameters;
 TWritePageParameters=Record
  Header:TModeParametersHeader;
  PSPageCode:Byte;             { PS                bit 7}
                               { PageCode          bits 0-6}
  PageLength:Byte;             { = 032h }
  TestFlagWriteType:Byte;      { TestFlag          bit 4}
                               { Type d'‚criture   bits 0 … 3}
  MSFPCopyTrackMode:Byte;      { MS (Multisession) bits 6 … 7}
                               { FP                bit 5}
                               { Copie             bit 4}
                               { Mode de cylindre  bits 0 … 3}
  DataBlockType:Byte;          { Bits 0 … 3 }
  Reserved1:Array[1..2]of Byte;
  HostApplicationCode:Byte;    { Bits 0 … 5 }
  SessionFormat:Byte;
  Reserved2:Byte;
  PacketSize:LongInt;
  AudioPauseLength:Word;
  MCVAL:Byte;                  { Bit 7 }
  MediaCatalogNumber:Array[1..13]of Byte;
  ZeroMC:Byte;
  AFRAMEMC:Byte;               { = 000h }
  TCVAL:Byte;                  { bit 7 }
  CountryCode:Byte;
  InternationalStandardRecordingCode:Byte;
  OwnerCode:Array[1..3]of Byte;
  YearOfRecording:Word;
  SerialNumber:Array[1..5]of Byte;
  ZeroTC:Byte;
  AFRAMETC:Byte;
  Reserved3:Byte;
  SubHeader:Array[0..3]of Byte;
 End;

 PDiskDevice=^TDiskDevice;
 TDiskDevice=Record
  Method:(mATAPI,mDOS);
  NumDrives:Integer;       { Nombre d'unit‚ (Entre 0 et 8) }
  ATAPIPort:Word;
  Drv,Int,IntMsg:Byte;
  ResponseBuffer:PResponseBuffer;
  SenseBuffer:PSenseBuffer;
  ResponseSize,SenseSize:word;
  OldIntHandler:Pointer;
  IntDetected:Boolean;
  AudioDrive:Word;
 End;

 PByteArray=^TByte;
 PWordArray=^TWord;

 TWaveHeader=Record
  Riff:Array[1..4]of Char;
  Length:LongInt;
  Wavefmt:Array[1..8]of Char;
  Dummy1:LongInt;
  Dummy2,Channels:Integer;
  Freq,BperSec:LongInt;
  BperSmp,SmpRes:Integer;
  Data:Array[1..4]of Char;
  DataSize:LongInt;
 End;

Function  BigEndianLongint(L:LongInt):LongInt;
Function  BigEndianWord(W:Word):Word;
Function  CHS2LBA(NumHeads,NumSectors,Head,Track,Sector:LongInt):LongInt;
Function  CorrectedData(PortNum:Byte):Boolean;
Function  DataRequest(PortNum:Byte):Boolean;
Function  DiskEBIOSExist(Dsk:Byte):Boolean;
Procedure DKAllocResponseBuffer(Var Q:TDiskDevice;Size:Word);
Procedure DKBlank(Var Q:TDiskDevice;BlankType:Byte;LBA:LongInt;Immed:Boolean);
Procedure DKCloseTrackSession(Var Q:TDiskDevice;CloseType,Track:Byte;Immedb:Boolean);
Procedure DKDone(Var Q:TDiskDevice);
Procedure DKFreeResponseBuffer(Var Q:TDiskDevice);
Function  DKGetByteCount(Var Q:TDiskDevice):Word;
Function  DKGetError(Var Q:TDiskDevice):Byte;
Function  DKGetInterruptReason(Var Q:TDiskDevice):Byte;
Function  DKGetSelectedDrive(Var Q:TDiskDevice):Boolean;
Function  DKGetStatus(Var Q:TDiskDevice):Byte;
Function  DKGetStatusEx(Var Q:TDiskDevice):Byte;
Function  DKIdentify(Var Q:TDiskDevice):Boolean;
Function  DKInATAPIBytes(Var Q:TDiskDevice):Boolean;
Procedure DKInit(Var Q:TDiskDevice;Drive:Byte;ResetDrv:Boolean);
Procedure DKInquiry(Var Q:TDiskDevice;Var Data;Var Size:Word);
Procedure DKModeSense(Var Q:TDiskDevice;PageCtrl,PageCode:Byte;Var Data;Var Size:Word);
Function  DKModeSelect(Var Q:TDiskDevice;Var Data;Size:Word):Boolean;
Function  DKOutATAPIBytes(Var Q:TDiskDevice;Var Data;Size:Word):Boolean;
Function  DKPacketCommand(Var Q:TDiskDevice;PC:PPacketCommand;BufferSize:Word):Boolean;
Function  DKPIODataIn(Var Q:TDiskDevice):Boolean;
Function  DKPIODataOut(Var Q:TDiskDevice;Var Data;Size:Word):Boolean;
Procedure DKPlayAudio(Var Q:TDiskDevice;Start,Len:LongInt);
Function  DKPlayAudioRed(Var Q:TDiskDevice;Start:CDAddr;Len:LongInt):Word;
Function  DKReadCDInit(Var Q:TDiskDevice;SectorType:Byte;Start,Len:LongInt;Flags,SubCh:Byte;TransferSize:Word):Boolean;
Procedure DKReadDiscInformation(Var Q:TDiskDevice;Var Buffer;Size:Word);
Procedure DKReadSubChannel(Var Q:TDiskDevice;Var Buffer;Track,DataFormat,Flags:Byte;Size:Word);
Procedure DKReadTOC(Var Q:TDiskDevice;Var TOC:PTOC;Var Size:Word);
Procedure DKReadTrackInformation(Var Q:TDiskDevice;Var Buffer;TrackInfo:Boolean;TrackOrLBA:LongInt;Size:Word);
Procedure DKRegisterIntHandler(Var Q:TDiskDevice;InterruptNr:Byte);
Procedure DKRequestSense(Var Q:TDiskDevice);
Procedure DKReserveTrack(Var Q:TDiskDevice;Size:LongInt);
Procedure DKSoftReset(Var Q:TDiskDevice);
Procedure DKSetFeatures(Var Q:TDiskDevice;Features:Byte);
Procedure DKSetByteCount(Var Q:TDiskDevice;ByteCount:Word);
Procedure DKSetDeviceControl(Var Q:TDiskDevice;DeviceControl:Byte);
Procedure DKSelectDrive(Var Q:TDiskDevice);
Procedure DKSetCDSpeed(Var Q:TDiskDevice;ReadSpeed,WriteSpeed:Word);
Procedure DKStartStopUnit(Var Q:TDiskDevice;Load,Start,Immediat:Boolean);
Function  DKSyncCache(Var Q:TDiskDevice;ImmedBit:Boolean):Boolean;
Function  DKTestUnitReady(Var Q:TDiskDevice):Boolean;
Procedure DKUnregisterIntHandler(Var Q:TDiskDevice);
Function  DKWaitUnitReady(Var Q:TDiskDevice;Wait:LongInt):Boolean;
Function  DKWriteCDInit(Var Q:TDiskDevice;Start:LongInt;Len,TransferSize:Word):Boolean;
Function  DriveBusy(PortNum:Byte):Boolean;
Function  DriveError(PortNum:Byte):Boolean;
Function  DriveIndexMark(PortNum:Byte):Boolean;
Function  DriveReady(PortNum:Byte):Boolean;
Function  DriveSeekComplete(PortNum:Byte):Boolean;
Function  DriveSelectedHead(PortNum:Byte):Byte;
Procedure DriveSetResetandInterrupt(PortNum:Byte;ResetOn,IntrOn:Boolean);
Function  DriveWriteAccess(PortNum:Byte):Boolean;
Function  DriveWriteFault(PortNum:Byte):Boolean;
Function  Dsk2Drv(Dsk:Byte):Char;
          {$IFNDEF NoInLine}
           InLine($58/            { POP AX     }
                  $04/Byte('@')); { ADD AL,'@' }
          {$ENDIF}
Function  GetBufferByte(PortNum:Byte):Byte;
Function  GetBufferWord(PortNum:Byte):Word;
Function  GetErrorFlags(PortNum:Byte):Byte;
Function  GetFloppyDrvType(Drive:Byte):Byte;
Procedure GetSectCyl(SecCyl:Word;Var Secteur:Byte;Var Cylindre:Word);
Procedure HSG2Red(nSect:LongInt;Var Local:CDAddr);
Procedure LBA2CHS(NumHeads,NumSectors,LBA:LongInt;Var Head,Track,Sector:Longint);
Function  IsCDROM(Drive:Integer):Boolean;
Function  IsMountDrive(Var Buffer):Boolean;
Function  IsMountDriveDOSEmu(Var Buffer):Boolean;
Function  MasterDriveSelected(PortNum:Byte):Boolean;
Function  ReadSectorBIOS(Dsk,Head:Byte;SecCyl:Word;Var Buffer):Boolean;
Function  ReadSectorEBIOS(Dsk:Byte;LBA:LongInt;Count:Word;Var Buffer):Boolean;
Function  Red2HSG(Time:CDAddr):LongInt;
Function  SlaveDriveSelected(PortNum:Byte):Boolean;
Procedure SelectDriveHead(PortNum,B:Byte);
Procedure SelectMasterDrive(PortNum:Byte);
Procedure SelectSlaveDrive(PortNum:Byte);
Procedure SelectLBAMode(PortNum:Byte;On:Boolean);
Procedure SendCommand(PortNum,Command:Byte);
Procedure SetDriveControl(PortNum,ControlByte:Byte);
Procedure SetBufferByte(PortNum,B:Byte);
Procedure SetBufferWord(PortNum:Byte;W:Word);
Function  WaitBusy(PortNum:Byte):Boolean;
Function  WriteSectorBIOS(Dsk,Head:Byte;SecCyl:Word;Var Buffer):Boolean;
Function  WriteSectorEBIOS(Dsk:Byte;LBA:LongInt;Count:Word;Var Buffer):Boolean;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                IMPLEMENTATION
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses Adele,Memories,Systems,Volumex;

Function CorrectedData(PortNum:Byte):Boolean;Begin
 {$IFNDEF __Windows__}
  CorrectedData:=Port[idePort[PortNum]+idePortStatus]and$4=$4;
 {$ELSE}
  CorrectedData:=False;
 {$ENDIF}
End;

Function DataRequest(PortNum:Byte):Boolean;Begin
 {$IFNDEF __Windows__}
  DataRequest:=Port[idePort[PortNum]+idePortStatus]and$8=$8;
 {$ELSE}
  DataRequest:=False;
 {$ENDIF}
End;

Function DriveBusy(PortNum:Byte):Boolean;Begin
 {$IFNDEF __Windows__}
  DriveBusy:=Port[idePort[PortNum]+idePortStatus]and$80=$80;
 {$ELSE}
  DriveBusy:=False;
 {$ENDIF}
End;

Function DriveError(PortNum:Byte):Boolean;Begin
 {$IFNDEF __Windows__}
  DriveError:=Port[idePort[PortNum]+idePortStatus]and$1=$1;
 {$ELSE}
  DriveError:=False;
 {$ENDIF}
End;

Function DriveReady(PortNum:Byte):Boolean;Begin
 {$IFNDEF __Windows__}
  DriveReady:=Port[idePort[PortNum]+idePortStatus]and$40=$40;
 {$ELSE}
  DriveReady:=False;
 {$ENDIF}
End;

Function DriveSeekComplete(PortNum:Byte):Boolean;Begin
 {$IFNDEF __Windows__}
  DriveSeekComplete:=Port[idePort[PortNum]+idePortStatus]and$10=$10;
 {$ELSE}
  DriveSeekComplete:=False;
 {$ENDIF}
End;

Function DriveIndexMark(PortNum:byte):Boolean;Begin
 {$IFNDEF __Windows__}
  DriveIndexMark:=Port[idePort[PortNum]+idePortStatus]and $2=$2;
 {$ELSE}
  DriveIndexMark:=False;
 {$ENDIF}
End;

Function DriveWriteFault(PortNum:Byte):Boolean;Begin
 {$IFNDEF __Windows__}
  DriveWriteFault:=(Port[idePort[PortNum]+idePortStatus]and $20)=$20;
 {$ELSE}
  DriveWriteFault:=False;
 {$ENDIF}
End;

Function GetErrorFlags(PortNum:Byte):Byte;Begin
 {$IFNDEF __Windows__}
  GetErrorFlags:=Port[idePort[PortNum]+idePortError];
 {$ELSE}
  GetErrorFlags:=0;
 {$ENDIF}
End;

Procedure SendCommand(PortNum,Command:Byte);Begin
 {$IFNDEF __Windows__}
  Port[idePort[PortNum]+idePortCommand]:=Command;
 {$ENDIF}
End;

Procedure DriveSetResetandInterrupt(PortNum:Byte;ResetOn,IntrOn:Boolean);
{$IFNDEF __Windows__}
 Var
  B:Byte;
 Begin
  If(ResetOn)Then B:=4
             Else B:=0;
  If(IntrOn)Then ASM
   OR B,2
  END;
  Port[idePort[PortNum]+idePortControl]:=B;
 End;
{$ELSE}
 Begin
 End;
{$ENDIF}

Function DriveWriteAccess(PortNum:Byte):Boolean;Begin
 {$IFNDEF __Windows__}
  DriveWriteAccess:=Port[idePort[PortNum]+idePortAddress]and$40=0;
 {$ELSE}
  DriveWriteAccess:=False;
 {$ENDIF}
End;

Function DriveSelectedHead(PortNum:Byte):Byte;Begin
 {$IFNDEF __Windows__}
  DriveSelectedHead:=(Port[idePort[PortNum]+idePortAddress]shr 2)and$F;
 {$ELSE}
  DriveSelectedHead:=0;
 {$ENDIF}
End;

Function MasterDriveSelected(PortNum:Byte):Boolean;Begin
 {$IFNDEF __Windows__}
  MasterDriveSelected:=Port[idePort[PortNum]+idePortAddress]and 1=0;
 {$ELSE}
  MasterDriveSelected:=False;
 {$ENDIF}
End;

Function SlaveDriveSelected(PortNum:Byte):Boolean;Begin
 {$IFNDEF __Windows__}
  SlaveDriveSelected:=Port[idePort[PortNum]+idePortAddress]and 2=0;
 {$ELSE}
  SlaveDriveSelected:=False;
 {$ENDIF}
End;

Procedure SelectDriveHead(PortNum,B:byte);Begin
 {$IFNDEF __Windows__}
  Port[idePortDrive]:=(Port[idePort[PortNum]+idePortDrive]and$F0)or(B and$F);
 {$ENDIF}
End;

Procedure SelectMasterDrive(PortNum:Byte);Begin
 {$IFNDEF __Windows__}
  Port[idePort[PortNum]+idePortDrive]:=Port[idePort[PortNum]+idePortDrive]and$EF;
 {$ENDIF}
End;

Procedure SelectSlaveDrive(PortNum:Byte);Begin
 {$IFNDEF __Windows__}
  Port[idePort[PortNum]+idePortDrive]:=Port[idePort[PortNum]+idePortDrive]or$10;
 {$ENDIF}
End;

Procedure SelectLBAMode(PortNum:Byte;On:Boolean);Begin
 {$IFNDEF __Windows__}
  If(On)Then Port[idePort[PortNum]+idePortDrive]:=Port[idePort[PortNum]+idePortDrive]or$40
        Else Port[idePort[PortNum]+idePortDrive]:=Port[idePort[PortNum]+idePortDrive]and$BF;
 {$ENDIF}
End;

Function WaitBusy(PortNum:Byte):Boolean;
Var
 Index:Word;
Begin
 Index:=$FFFF;
 While(DriveBusy(PortNum)or(Not DriveReady(PortNum)))and(Index>0)do Dec(Index);
 WaitBusy:=Index<>0;
End;

Function GetBufferByte(PortNum:Byte):Byte;Begin
 {$IFNDEF __Windows__}
  GetBufferByte:=Port[idePort[PortNum]+idePortData];
 {$ELSE}
  GetBufferByte:=0;
 {$ENDIF}
End;

Function GetBufferWord(PortNum:Byte):Word;Begin
 {$IFNDEF __Windows__}
  GetBufferWord:=Portw[idePort[PortNum]+idePortData];
 {$ELSE}
  GetBufferWord:=0;
 {$ENDIF}
End;

Procedure SetBufferByte(PortNum,B:Byte);Begin
 {$IFNDEF __Windows__}
  Port[idePort[PortNum]+idePortData]:=B;
 {$ENDIF}
End;

Procedure SetBufferWord(PortNum:Byte;W:Word);Begin
 {$IFNDEF __Windows__}
  Portw[idePort[PortNum]+idePortData]:=W;
 {$ENDIF}
End;

Procedure SetDriveControl(PortNum,ControlByte:Byte);Begin
 {$IFNDEF __Windows__}
  Port[idePort[PortNum]+idePortControl]:=ControlByte;
 {$ENDIF}
End;

Var
 RegisteredObj:PDiskDevice;
 Timer:LongInt;

Function BigEndianLongint(L:LongInt):LongInt;Begin
 BigEndianLongint:=(l shl 24)or
                  ((l shl  8)and$FF0000)or
                   (l shr 24)or
                  ((l shr  8)and$FF00);
End;

Function BigEndianWord(W:Word):Word;Begin
 BigEndianWord:=(W shl 8)or(W shr 8);
End;

Procedure DummyInt;
{$IFNDEF __Windows__}
 Interrupt;Begin
  If(DKGetStatus(RegisteredObj^)and astDRQ)>0Then RegisteredObj^.IntDetected:=True;
  If RegisteredObj^.Int>7Then Port[$A0]:=$20;
  Port[$20]:=$20;
 End;
{$ELSE}
 Begin
 End;
{$ENDIF}

Procedure TimerInt;
{$IFNDEF __Windows__}
 Interrupt;Begin
  Inc(Timer);
 End;
{$ELSE}
 Begin
  Inc(Timer);
 End;
{$ENDIF}

Procedure DKInit(Var Q:TDiskDevice;Drive:Byte;ResetDrv:Boolean);
{$IFNDEF __Windows__}
 Label Driver,NoDriver,Xit;
 Const
  DataAndAudio=$010;
 Var
  LogicalDrives:Array[0..25]of Byte;
 Begin
  FillClr(Q,SizeOf(TDiskDevice));
  Q.Drv:=Drive and 1;
  If(Win<>0)or(OS2)Then Begin
   Q.Method:=mDOS;
   Goto Driver;
  End
   Else
  Begin
   ASM
    MOV AX,01500h
    XOR BX,BX
    INT 02Fh
    OR  BX,BX
    JZ  NoDriver
Driver:
    LES DI,Q
    MOV ES:[DI].TDiskDevice.Method,mDOS
    MOV ES:[DI].TDiskDevice.NumDrives,BX
    XOR AX,AX
    SUB AX,BP
    MOV BX,Offset LogicalDrives
    SUB BX,AX
    PUSH SS
    POP ES
    MOV AX,150Dh
    INT 2Fh
   END;
   Q.AudioDrive:=LogicalDrives[DefaultCDROMPort];
   Goto Xit;
NoDriver:
   Q.ATAPIPort:=idePort[Drive shr 1];
   GetMem(Q.SenseBuffer,SizeOf(TSenseBuffer));
   If(ResetDrv)Then DKSoftReset(Q)
  End;
Xit:
 End;
{$ELSE}
 Begin
 End;
{$ENDIF}

Procedure DKDone(Var Q:TDiskDevice);Begin
 DKFreeResponseBuffer(Q);
 If(Q.OldIntHandler<>NIL)Then DKUnregisterIntHandler(Q);
 FreeMemory(Q.SenseBuffer,Sizeof(TSenseBuffer));
End;

Function DKGetStatus(Var Q:TDiskDevice):Byte;Begin
 {$IFNDEF __Windows__}
  DKGetStatus:=Port[Q.ATAPIPort+idePortStatus];
 {$ELSE}
  DKGetStatus:=0;
 {$ENDIF}
End;

Function DKGetStatusEx(Var Q:TDiskDevice):Byte;Begin
 {$IFNDEF __Windows__}
  DKGetStatusEx:=Port[Q.ATAPIPort+idePortStatusEx];
 {$ELSE}
  DKGetStatusEx:=0;
 {$ENDIF}
End;

Function DKGetError(Var Q:TDiskDevice):Byte;Begin
 {$IFNDEF __Windows__}
  DKGetError:=Port[Q.ATAPIPort+idePortError];
 {$ELSE}
  DKGetError:=0;
 {$ENDIF}
End;

Function DKGetInterruptReason(Var Q:TDiskDevice):Byte;Begin
 {$IFNDEF __Windows__}
  DKGetInterruptReason:=Port[Q.ATAPIPort+idePortSectorCount];
 {$ELSE}
  DKGetInterruptReason:=0;
 {$ENDIF}
End;

Function DKGetSelectedDrive(Var Q:TDiskDevice):Boolean;Begin
 {$IFNDEF __Windows__}
  If Port[Q.ATAPIPort+idePortDrive]and$10>0Then DKGetSelectedDrive:=DrvSlave
                                           Else DKGetSelectedDrive:=DrvMaster;
 {$ELSE}
  DKGetSelectedDrive:=False;
 {$ENDIF}
End;

Function DKGetByteCount(Var Q:TDiskDevice):Word;Begin
 {$IFNDEF __Windows__}
  DKGetByteCount:=Port[Q.ATAPIPort+idePortCylLo]or(Word(Port[Q.ATAPIPort+idePortCylHi])shl 8)
 {$ELSE}
  DKGetByteCount:=0;
 {$ENDIF}
End;

Procedure DKSetFeatures(Var Q:TDiskDevice;Features:Byte);Begin
 {$IFNDEF __Windows__}
  Port[Q.ATAPIPort+idePortFeature]:=Features;
 {$ENDIF}
End;

Procedure DKSetByteCount(Var Q:TDiskDevice;ByteCount:Word);Begin
 {$IFNDEF __Windows__}
  Port[Q.ATAPIPort+idePortCylLo]:=Lo(ByteCount);
  Port[Q.ATAPIPort+idePortCylHi]:=Hi(ByteCount);
 {$ENDIF}
End;

Procedure DKSetDeviceControl(Var Q:TDiskDevice;DeviceControl:Byte);Begin
 {$IFNDEF __Windows__}
  Port[Q.ATAPIPort+idePortControl]:=DeviceControl;
 {$ENDIF}
End;

Procedure DKSelectDrive(Var Q:TDiskDevice);Begin
 {$IFNDEF __Windows__}
  Port[Q.ATAPIPort+idePortDrive]:=(Port[Q.ATAPIPort+idePortDrive]and$EF)or(Q.Drv shl 4);
 {$ENDIF}
End;

Procedure DKSoftReset(Var Q:TDiskDevice);Begin
 {$IFNDEF __Windows__}
  DKSelectDrive(Q);
  Port[Q.ATAPIPort+idePortCommand]:=cmdAtapiSoftReset;
  While (DKGetStatus(Q)and astBsy)>0do;
  DKWaitUnitReady(Q,100000);
 {$ENDIF}
End;

Function DKIdentify(Var Q:TDiskDevice):Boolean;
{$IFNDEF __Windows__}
 Var
  Rs,I,Timer:Word;
 Begin
  If(Q.ResponseSize>=512)Then Begin
   DKSelectDrive(Q);
   While(DKGetStatus(Q)and(AstBsy or AstDRDY))=(AstBsy or AstDRDY)do;
   DKSetFeatures(Q,0);
   Port[Q.ATAPIPort+idePortSectorCount]:=0;
   Port[Q.ATAPIPort+idePortSec]:=0;
   DKSetByteCount(Q,Q.ResponseSize);
   Port[Q.ATAPIPort+idePortCommand]:=$A1;
   Timer:=$FFFF;
   While(Timer>0)and((DKGetStatus(Q)and AstBsy)>0)do Dec(Timer);
   If Timer=0Then Begin
    DKIdentify:=False;
    Exit;
   End;
   Rs:=DKGetByteCount(Q);
   If(DKGetError(Q)>0)or(Rs<>512)Then DKIdentify:=False
    Else
   Begin
    For I:=0to Pred(Rs)shr 1do Q.ResponseBuffer^[I]:=PortW[Q.ATAPIPort+idePortData];
    DKIdentify:=(Q.ResponseBuffer^[0]and $8000)>0;
   End;
  End
   Else
  DKIdentify:=False;
 End;
{$ELSE}
 Begin
  DKIdentify:=False;
 End;
{$ENDIF}

Function DKPacketCommand(Var Q:TDiskDevice;PC:PPacketCommand;BufferSize:Word):Boolean;
{$IFNDEF __Windows__}
 Var
  I:Byte;
  ClockStart,Clock:Byte;
 Begin
  DKSelectDrive(Q);
  ClockStart:=GetRawTimerB;
  While(DKGetStatus(Q)and(AstBsy or AstDRDY))=(AstBsy or AstDRDY)do Begin
   If ClockStart shr 4<>Clock shr 4Then Break;
  End;
   {Initie le paquet de commande}
  DKSetFeatures(Q,0);
  Port[Q.ATAPIPort+idePortSectorCount]:=0;
  Port[Q.ATAPIPort+idePortSec]:=0;
  DKSetByteCount(Q,BufferSize);
  Port[Q.ATAPIPort+idePortCommand]:=$A0;
  ClockStart:=GetRawTimerB;
  While(DKGetInterruptReason(Q)and(AirCOD or AirIO))<>AirCOD do Begin
   If ClockStart shr 4<>Clock shr 4Then Break;
  End;
  While(DKGetStatus(Q)and AstDRQ)=0do;
  For I:=0to 5do PortW[Q.ATAPIPort+idePortData]:=PPacketCommandData(PC)^[I];
 End;
{$ELSE}
 Begin
  DKPacketCommand:=False;
 End;
{$ENDIF}

Function DKPIODataIn(Var Q:TDiskDevice):Boolean;Begin
 While(DKGetInterruptReason(Q)and AirIO)=0do;
 While(DKGetStatus(Q)and AstBSY)>0do;
 DKFreeResponseBuffer(Q);
 DKPIODataIn:=DKInATAPIBytes(Q);
End;

Function DKInATAPIBytes(Var Q:TDiskDevice):Boolean;
{$IFNDEF __Windows__}
 Var
  I:Word;
 Begin
  If DKGetStatus(Q)and AstDRQ>0Then Begin
   Q.ResponseSize:=DKGetByteCount(Q);
   DKAllocResponseBuffer(Q,Q.ResponseSize);
   If Q.ResponseSize>0Then
    For I:=0to Pred(Q.ResponseSize)shr 1do
     Q.ResponseBuffer^[I]:=PortW[Q.ATAPIPort+idePortData];
   DKInATAPIBytes:=True;
  End
   Else
  Begin
   Q.ResponseSize:=0;
   DKInATAPIBytes:=False;
  End;
 End;
{$ELSE}
 Begin
  DKInATAPIBytes:=False;
 End;
{$ENDIF}

Function DKPIODataOut(Var Q:TDiskDevice;Var Data;Size:Word):Boolean;Begin
 While(DKGetInterruptReason(Q)and AirIO)=1do;
 While(DKGetStatus(Q)and AstBSY)>0do;
 DKPIODataOut:=DKOutATAPIBytes(Q,Data,Size);
End;

Function DKOutATAPIBytes(Var Q:TDiskDevice;Var Data;Size:Word):Boolean;
{$IFNDEF __Windows__}
 Var
  I,Ts:Word;
 Begin
  If DKGetStatus(Q)and AstDRQ>0Then Begin
   For I:=0to Pred(Size)shr 1do Begin
    While(DKGetStatus(Q)and(AstBSY or AstDRQ))<>AstDRQ do;
    Portw[Q.ATAPIPort+idePortData]:=TResponseBuffer(Data)[I];
   End;
   DKOutATAPIBytes:=DKGetStatus(Q)and(AstCheck or AstDRQ)=0;
  End
   Else
  DKOutATAPIBytes:=False;
 End;
{$ELSE}
 Begin
  DKOutATAPIBytes:=False;
 End;
{$ENDIF}

Procedure DKAllocResponseBuffer(Var Q:TDiskDevice;Size:Word);Begin
 DKFreeResponseBuffer(Q);
 GetMem(Q.ResponseBuffer,Size);
 Q.ResponseSize:=Size;
End;

Procedure DKFreeResponseBuffer(Var Q:TDiskDevice);Begin
 If(Q.ResponseBuffer<>NIL)Then FreeMemory(Q.ResponseBuffer,Q.ResponseSize);
 Q.ResponseBuffer:=NIL;
 Q.ResponseSize:=0;
End;

Procedure DKRegisterIntHandler(Var Q:TDiskDevice;InterruptNr:Byte);Begin
 If(Q.OldIntHandler<>NIL)Then Exit;
 Q.Int:=InterruptNr;
 Q.IntDetected:=False;
 RegisteredObj:=@Q;
 If Q.Int<8Then Begin
  GetIntVec($08+Q.Int,Q.OldIntHandler);
  SetIntVec($08+Q.Int,@DummyInt);
 End
  Else
 Begin
  GetIntVec($70+(Q.Int and 7),Q.OldIntHandler);
  SetIntVec($70+(Q.Int and 7),@DummyInt);
 End;
End;

Procedure DKUnregisterIntHandler(Var Q:TDiskDevice);Begin
 If(Q.OldIntHandler=NIL)Then Exit;
 If Q.Int<8Then SetIntVec($08+Q.Int,Q.OldIntHandler)
           Else SetIntVec($70+(Q.Int and 7),Q.OldIntHandler);
 Q.OldIntHandler:=NIL;
 RegisteredObj:=NIL;
End;

Function DKTestUnitReady(Var Q:TDiskDevice):Boolean;
Var
 PC:TPCTestUnitReady;
Begin
 FillClr(PC,PacketCommandSize);
 DKPacketCommand(Q,@PC,MaxDataBlock);
 While(DKGetStatus(Q)and AstBSY)>0do;
 DKTestUnitReady:=DKGetStatus(Q)and AstCheck=0;
End;

Function DKWaitUnitReady(Var Q:TDiskDevice;Wait:LongInt):Boolean;Begin
 While Not DKTestUnitReady(Q)do Begin
  DKRequestSense(Q);
  If(Q.SenseBuffer^.ASC<>4)and(Q.SenseBuffer^.ASC<>$28)and
    (Q.SenseBuffer^.ASC<>$29)and(Q.SenseBuffer^.ASC<>78)and
    (Q.SenseBuffer^.ASC<>0)Then Begin
   DKWaitUnitReady:=False;
   Exit;
  End;
 End;
 DKWaitUnitReady:=True;
End;

Procedure DKReadTOC(Var Q:TDiskDevice;Var TOC:PTOC;Var Size:Word);
Var
 PC:TPCReadTOC;
Begin
 FillClr(PC,SizeOf(TPCReadTOC));
 PC.OpCode:=AcReadTOC;
 PC.AllocLength:=BigEndianWord(MaxTOCDataLen);
 DKPacketCommand(Q,@PC,MaxTOCDataLen);
 If DKPIODataIn(Q)Then Begin
  Size:=Q.ResponseSize;
  TOC:=NewBlock(Q.ResponseBuffer^,Size);
 End
  Else
 Begin
  TOC:=NIL;
  Size:=0;
 End;
End;

Procedure DKInquiry(Var Q:TDiskDevice;Var Data;Var Size:Word);
Var
 PC:TPCInquiry;
Begin
 FillClr(PC,PacketCommandSize);
 PC.OpCode:=AcInquiry;
 PC.AllocLength:=$FF;
 DKPacketCommand(Q,@PC,MaxDataBlock);
 Size:=0;
 While DKPIODataIn(Q)do Begin
  MoveLeft(Q.ResponseBuffer^,TByte(Data)[Size],Q.ResponseSize);
  Inc(Size,Q.ResponseSize);
 End;
End;

Procedure DKRequestSense(Var Q:TDiskDevice);
Var
 PC:TPCRequestSense;
Begin
 FillClr(PC,SizeOf(TPCRequestSense));
 PC.OpCode:=AcRequestSense;
 PC.AllocLength:=$FF;
 DKPacketCommand(Q,@PC,MaxDataBlock);
 While DKPIODataIn(Q)do Begin
  MoveLeft(Q.ResponseBuffer^,PByteArray(Q.SenseBuffer)^[Q.SenseSize],Q.ResponseSize);
  Inc(Q.SenseSize,Q.ResponseSize);
 End;
End;

Procedure DKModeSense(Var Q:TDiskDevice;PageCtrl,PageCode:Byte;Var Data;Var Size:Word);
Var
 PC:TPCModeSense;
Begin
 FillClr(PC,PacketCommandSize);
 PC.OpCode:=AcModeSense;
 PC.AllocLength:=BigEndianWord(MaxSenseBuffer);
 PC.PageControlCode:=((PageCtrl and 3)shl 6)or(PageCode and $3F);
 DKPacketCommand(Q,@PC,MaxDataBlock);
 Size:=0;
 While DKPIODataIn(Q)do Begin
  MoveLeft(Q.ResponseBuffer^,TByte(Data)[Size],Q.ResponseSize);
  Inc(Size,Q.ResponseSize);
 End;
End;

Function DKModeSelect(Var Q:TDiskDevice;Var Data;Size:Word):Boolean;
Var
 PC:TPCModeSelect;
Begin
 FillClr(PC,PacketCommandSize);
 PC.OpCode:=AcModeSelect;
 PC.PFSP:=$10;
 PC.AllocLength:=BigEndianWord(Size);
 DKPacketCommand(Q,@PC,MaxDataBlock);
 DKModeSelect:=DKPIODataOut(Q,Data,Size);
End;

Procedure DKPlayAudio(Var Q:TDiskDevice;Start,Len:LongInt);
Var
 PC:TPCPlayAudio;
Begin
 FillClr(PC,PacketCommandSize);
 PC.OpCode:=AcPlayAudio;
 PC.StartLBA:=BigEndianLongint(Start);
 PC.TransferLength:=BigEndianWord(Len);
 DKPacketCommand(Q,@PC,MaxDataBlock);
End;

Function DKPlayAudioRed(Var Q:TDiskDevice;Start:CDAddr;Len:LongInt):Word;
{$IFNDEF __Windows__}
 Var
  rqPlay:AudioPlayRequest;
 Begin
  If(Q.Method=mATAPI)Then Begin
   DKPlayAudio(Q,Red2HSG(Start)-1,Len);
   DKPlayAudioRed:=0;
  End
   Else
  Begin
   FillClr(rqPlay,SizeOf(rqPlay));
   rqPlay.Playrqh.rqLen:=SizeOf(AudioPlayRequest);
   rqPlay.Playrqh.rqUnit:=Q.Drv;
   rqPlay.Playrqh.rqCmd:=132;
   rqPlay.AddrMode:=Red;
   rqPlay.Start:=Start;
   rqPlay.nFrames:=Len;
   ASM
    LES DI,Q
    MOV AX,1510h
    MOV CX,ES:[DI].TDiskDevice.AudioDrive
    MOV BX,Offset rqPlay
    ADD BX,BP
    PUSH SS
    POP ES
    INT 2Fh
   END;
   DKPlayAudioRed:=rqPlay.Playrqh.rqStatus
  End;
 End;
{$ELSE}
 Begin
  DKPlayAudioRed:=0;
 End;
{$ENDIF}

Procedure DKStartStopUnit(Var Q:TDiskDevice;Load,Start,Immediat:Boolean);
Var
 PC:TPCStartStopUnit;
Begin
 FillClr(PC,PacketCommandSize);
 PC.OpCode:=AcStartStopUnit;
 If(Immediat)Then PC.Immed:=PC.Immed or 1;
 If(Load)Then PC.LoadUnloadAndStart:=PC.LoadUnloadAndStart or 2;
 If(Start)Then PC.LoadUnloadAndStart:=PC.LoadUnloadAndStart or 1;
 DKPacketCommand(Q,@PC,MaxDataBlock);
End;

Procedure DKSetCDSpeed(Var Q:TDiskDevice;ReadSpeed,WriteSpeed:Word);
Var
 PC:TPCSetCDSpeed;
Begin
 FillClr(PC,PacketCommandSize);
 PC.OpCode:=AcSetCDSpeed;
 PC.ReadDriveSpeed:=BigEndianWord(ReadSpeed);
 PC.WriteDriveSpeed:=BigEndianWord(WriteSpeed);
 DKPacketCommand(Q,@PC,MaxDataBlock);
End;

Function DKReadCDInit(Var Q:TDiskDevice;SectorType:Byte;Start,Len:LongInt;Flags,SubCh:Byte;TransferSize:Word):Boolean;
Var
 PC:TPCReadCD;
Begin
 FillClr(PC,PacketCommandSize);
 PC.OpCode:=AcReadCD;
 PC.ExpectedSectorType:=SectorType shl 2;
 PC.StartLBA:=BigEndianLongint(Start);
 PC.TransferLength[0]:=(Len shr 16)and 255;
 PC.TransferLength[1]:=(Len shr 8 )and 255;
 PC.TransferLength[2]:=(Len       )and 255;
 PC.FlagBits:=Flags;
 PC.SubChannelDataSel:=Subch;
 DKPacketCommand(Q,@PC,TransferSize);
 DKReadCDInit:=DKGetStatus(Q)and AstCheck=0;
End;

Function DKWriteCDInit(Var Q:TDiskDevice;Start:LongInt;Len,TransferSize:Word):Boolean;
Var
 PC:TPCWrite10;
Begin
 FillClr(PC,SizeOf(TPCWrite10));
 PC.OpCode:=AcWrite10;
 PC.LBA:=BigEndianLongint(Start);
 PC.TransferLength:=BigEndianWord(Len);
 DKPacketCommand(Q,@PC,TransferSize);
 DKWriteCDInit:=DKGetStatus(Q)and AstCheck=0;
End;

Function DKSyncCache(Var Q:TDiskDevice;ImmedBit:Boolean):Boolean;
Var
 PC:TPCSyncCache;
Begin
 FillClr(PC,SizeOf(TPCSyncCache));
 PC.OpCode:=AcSyncCache;
 If(ImmedBit)Then PC.Immed:=$02;
 DKPacketCommand(Q,@PC,MaxDataBlock);
 DKSyncCache:=DKGetStatus(Q)and AstCheck=0;
End;

Procedure DKBlank(Var Q:TDiskDevice;BlankType:Byte;LBA:LongInt;Immed:Boolean);
Var
 PC:TPCBlank;
Begin
 FillClr(PC,PacketCommandSize);
 PC.OpCode:=AcBlank;
 PC.ImmedBlankType:=BlankType and 7;
 If(Immed)Then PC.ImmedBlankType:=PC.ImmedBlankType or $10;
 PC.StartLBA:=BigEndianLongint(LBA);
 DKPacketCommand(Q,@PC,MaxDataBlock);
End;

Procedure DKCloseTrackSession(Var Q:TDiskDevice;CloseType,Track:Byte;Immedb:Boolean);
Var
 PC:TPCCloseTrackSession;
Begin
 FillClr(PC,PacketCommandSize);
 PC.OpCode:=AcCloseTrackSession;
 PC.SessionTrack:=CloseType;
 PC.TrackNr:=Track;
 If(Immedb)Then PC.Immed:=PC.Immed or 1;
 DKPacketCommand(Q,@PC,MaxDataBlock);
End;

Procedure DKReadDiscInformation(Var Q:TDiskDevice;Var Buffer;Size:Word);
Var
 PC:TPCReadDiscInformation;
 Sz:Word;
Begin
 FillClr(PC,PacketCommandSize);
 PC.OpCode:=AcReadDiscInfo;
 PC.AllocLength:=BigEndianWord(Size);
 DKPacketCommand(Q,@PC,MaxDataBlock);
 Sz:=0;
 While DKPIODataIn(Q)do Begin
  If(Sz+Q.ResponseSize>Size)Then Q.ResponseSize:=Size-Sz;
  MoveLeft(Q.ResponseBuffer^,TByte(Buffer)[Sz],Q.ResponseSize);
  Inc(Sz,Q.ResponseSize);
 End;
End;

Procedure DKReadTrackInformation(Var Q:TDiskDevice;Var Buffer;TrackInfo:Boolean;
                                 TrackOrLBA:LongInt;Size:Word);
Var
 PC:TPCReadTrackInformation;
 Sz:Word;
Begin
 FillClr(PC,PacketCommandSize);
 PC.OpCode:=AcReadTrackInfo;
 PC.AllocLength:=BigEndianWord(Size);
 If(TrackInfo)Then PC.Track:=PC.Track or 1;
 PC.LBAOrTrackNr:=BigEndianLongint(TrackOrLBA);
 DKPacketCommand(Q,@PC,MaxDataBlock);
 Sz:=0;
 While DKPIODataIn(Q)do Begin
  If(Sz+Q.ResponseSize>Size)Then Q.ResponseSize:=Size-Sz;
  MoveLeft(Q.ResponseBuffer^,TByte(Buffer)[Sz],Q.ResponseSize);
  Inc(Sz,Q.ResponseSize);
 End;
End;

Procedure DKReserveTrack(Var Q:TDiskDevice;Size:LongInt);
Var
 PC:TPCReserveTrack;
Begin
 FillClr(PC,PacketCommandSize);
 PC.OpCode:=AcReserveTrack;
 PC.ReservationSize:=BigEndianLongint(Size);
 DKPacketCommand(Q,@PC,MaxDataBlock);
End;

Procedure DKReadSubChannel(Var Q:TDiskDevice;Var Buffer;Track,DataFormat,Flags:Byte;Size:Word);
Var
 PC:TPCReadSubChannel;
 Sz:Word;
Begin
 FillClr(PC,PacketCommandSize);
 PC.OpCode:=AcReadSubChannel;
 If Flags and RscfMSF>0Then PC.MSF:=2;
 If Flags and RscfSubQ>0Then PC.SubQ:=64;
 PC.SubChannelDataFormat:=DataFormat;
 PC.TrackNr:=Track;
 PC.AllocLength:=BigEndianWord(Size);
 DKPacketCommand(Q,@PC,MaxDataBlock);
 Sz:=0;
 While DKPIODataIn(Q)do Begin
  If(Sz+Q.ResponseSize>Size)Then Q.ResponseSize:=Size-Sz;
  MoveLeft(Q.ResponseBuffer^,TByte(Buffer)[Sz],Q.ResponseSize);
  Inc(Sz,Q.ResponseSize);
 End;
End;

Function Red2HSG(Time:CDAddr):LongInt;Begin
 Red2HSG:=LongInt(LongInt(Time.Time.Minute)*4500+
                  LongInt(Time.Time.Second)*75+
                  LongInt(Time.Time.Frame));
End;

Procedure HSG2Red(nSect:LongInt;Var Local:CDAddr);Begin
 Local.Time.Frame:=nSect mod 75;
 nSect:=nSect div 75;
 Local.Time.Second:=nSect mod 60;
 Local.Time.Minute:=nSect div 60;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Fonction Dsk2Drv                           Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de convertir une unit‚ logique (1=A:, 2=B:,...) en
 sont ‚quivalent en lettre.
}

{$IFDEF NoInLine}
 Function Dsk2Drv(Dsk:Byte):Char;Assembler;ASM
  MOV AL,Dsk
  ADD AL,'@'
 END;
{$ENDIF}

Function IsMountDriveDOSEmu(Var Buffer):Boolean;
Var
 Header:DosEmuHeader Absolute Buffer;
Begin
 IsMountDriveDOSEmu:=(Header.Sign='DOSEMU'#0);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Fonction IsMountDrive                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de d‚terminer si l'entˆte de fichier d‚finit par
 le tampon ®Buffer¯ est de format ®DosEmu¯ de Linux ou ®Connectix¯ de
 Virtual PC.
}

Function IsMountDrive(Var Buffer):Boolean;
Var
 VirtualPC:ConnectixVirtualPCHeader Absolute Buffer;
Begin
 IsMountDrive:=IsMountDriveDOSEmu(Buffer)or(VirtualPC.Sign='conectix');
End;

{$I \Source\Chantal\Library\Disk\CDROM\IsCDROM.Inc}

{ Cette fonction permet de d‚terminer le type de disquette ‚tant dans
 l'unit‚. Les valeurs retourner possibles sont:
 ÚÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³ Valeur  ³ Description                                            ³
 ÆÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍµ
 ³ 1       ³ 360 Ko                                                 ³
 ³ 2       ³ 1,2 Mo                                                 ³
 ³ 3       ³ 720 Ko                                                 ³
 ³ 4       ³ 1,44 Mo                                                ³
 ³ 5       ³ 2,88 Mo                                                ³
 ³ 6       ³ 2,88 Mo                                                ³
 ÀÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
}

Function GetFloppyDrvType(Drive:Byte):Byte;Assembler;ASM
 MOV AH,08h
 MOV DL,Drive
 INT 13h
 JNC @Ok
 MOV BL,dtDD525
@Ok:
 XCHG AX,BX
END;

Function ReadSectorBIOS(Dsk,Head:Byte;SecCyl:Word;Var Buffer):Boolean;Assembler;ASM
 MOV AX,0201h
 MOV DL,Dsk
 MOV DH,Head
 MOV CX,SecCyl
 LES BX,Buffer
 INT 13h
 CMC
 MOV AL,0
 ADC AL,AL
END;

Function WriteSectorBIOS(Dsk,Head:Byte;SecCyl:Word;Var Buffer):Boolean;Assembler;ASM
 MOV AX,0301h
 MOV DL,Dsk
 MOV DH,Head
 MOV CX,SecCyl
 LES BX,Buffer
 INT 13h
 CMC
 MOV AL,0
 ADC AL,AL
END;

Function DiskEBIOSExist(Dsk:Byte):Boolean;Assembler;ASM
 MOV AH,41h
 MOV BX,55AAh
 MOV DL,Dsk
 INT 13h
 MOV AL,0
 ADC AL,AL
 XOR AL,1
END;

Function ActionSectorEBIOS(Action:Word;Dsk:Byte;LBA:LongInt;Count:Word;Var Buffer):Boolean;Near;
{$IFDEF Real}
 Var
  Block:Record
   Size:Byte;
   Res:Byte;
   Count:Word;
   Addr:Pointer;
   LBAlo:Longint;
   LBAhi:Longint;
  End;
  SegBuf,OfsBuf:Word;
 Begin
  FillClr(Block,SizeOf(Block));
  Block.Size:=SizeOf(Block);
  Block.Count:=Count;
  Block.Addr:=@Buffer;
  Block.LBAlo:=LBA;
  SegBuf:=Seg(Block);
  OfsBuf:=Ofs(Block);
  ASM
   PUSH DS
    MOV AX,Action
    MOV DL,Dsk
    MOV DS,SegBuf
    MOV SI,OfsBuf
    INT 13h
    MOV AL,0
    ADC AL,AL
    XOR AL,1
   POP DS
   MOV @Result,AL
  END;
 End;
{$ELSE}
 Begin
 End;
{$ENDIF}

Function WriteSectorEBIOS(Dsk:Byte;LBA:LongInt;Count:Word;Var Buffer):Boolean;Begin
 WriteSectorEBIOS:=ActionSectorEBIOS($4300,Dsk,LBA,Count,Buffer);
End;

Function ReadSectorEBIOS(Dsk:Byte;LBA:LongInt;Count:Word;Var Buffer):Boolean;Begin
 ReadSectorEBIOS:=ActionSectorEBIOS($4200,Dsk,LBA,Count,Buffer);
End;

Function CHS2LBA(NumHeads,NumSectors,Head,Track,Sector:LongInt):LongInt;Begin
 CHS2LBA:=(Track*(NumHeads+1)+Head)*NumSectors+Sector-1;
End;

Procedure LBA2CHS(NumHeads,NumSectors,LBA:LongInt;Var Head,Track,Sector:Longint);Begin
 Sector:=LBA mod NumSectors+1;
 LBA:=LBA div NumSectors;
 Head:=LBA mod (NumHeads+1);
 Track:=LBA div (NumHeads+1);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Proc‚dure GetSectCyl                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure renvoie les num‚ro de secteur et de cylindre aprŠs
 conversion des codes BIOS du secteur et du cylindre.


 Entr‚e
 ÍÍÍÍÍÍ

  SecCyl      Valeur … d‚coder
  Secteur     R‚f‚rence … la variable Secteur
  Cylindre    R‚f‚rence … la variable Cylindre
}

Procedure GetSectCyl(SecCyl:Word;Var Secteur:Byte;Var Cylindre:Word);Begin
 Secteur:=SecCyl and 63;                 { masque les bits 6 et 7 }
 Cylindre:=Hi(SecCyl)+(Lo(SecCyl)and 192)shl 2;
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
END.