{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                                                                Û
 ³                   Malte Genesis/BBS Cortex                     Û
 ³       dition Chantal pour Mode R‚el/IV - Version 1.2          Û
 ³                          1997/01/02                            Û
 ³                                                                Û
 ³      Tous droits r‚serv‚s par les Chevaliers de Malte (C)      Û
 ³                                                                Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Nom du programmeur
 ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

  Sylvain Maltais


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette unit‚ est en quelque sorte une entˆte de d‚finition pour la
 communication par modem.
}

Unit BBSTex;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                 INTERFACE
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses Systex;

Const

 MaxUsers=100;        { Nombre maximal d'usager chargeable en m‚moire }
 MaxLoginTry=3;       { Nombre maximal de tentative de connexion avant d'abandonner }
 KermitNone=0;        { Protocol Kermit sans format }
 KermitAscii=1;       { Protocol Kermit en ASCII }
 KermitBinary=2;      { Protocol Kermit en Binaire }
 TransTimeVal=1800.0; { Valeur du temps de transfert }

 SingleFileProtocol:Array[1..trsMax]of Boolean=(True,True,True,No,No,No,No,True,True,No,No,True,True,True,True,True);

 DefaultTransferType:Byte=trsXmodemChk;

  {Code de retour du protocol}
 protNone=0;         { Rien }
 protReceiveError=1; { Erreur de r‚ception }
 protCarrierDrop=2;  { Raccrocher }
 protAltRStop=3;     { Arrˆter par Alt+R }
 protOk=255;         { Tous va bien }

Type
 DefaultProtocolSetting=Record
  SectorSize:SmallInt;
  Header:Boolean;
  DoXonXoff:Boolean;
 End;

 DataProtocolRec=Record
  ID:Byte;
  SingleFile:Boolean;
  TN:String[2];
  Default:DefaultProtocolSetting;
  Name:String;
 End;

  {Enregistrement d'un dialogue}
 UserRec=Record
  Alias:Array[0..18]of Chr;{Alias (Surnom)}
  FirstName:Array[0..18]of Chr;{Pr‚nom}
  LastName:Array[0..18]of Chr;{Nom de famille}
  PassWd:Array[0..15]of Chr;{Mot de passe}
  Phone:Array[0..20]of Chr;{Num‚ro de t‚l‚phone}
  Level:Array[0..4]of Chr;{Niveau de s‚curit‚}
  CRLF:Array[0..1]of Chr;{Retour de ligne}
 End;

  {Enregistrement utilise pour les protocols par modem}
 Prots=Record
  ExitMsg,                { Code de sortie }
  KermitFileTypeVar:Byte; { Type de fichier Kermit }
  ReceiveScriptNames,SendScriptNames:Array[1..16]of PChr;
  Default:DefaultProtocolSetting;
  Config:Set of (AsciiTranslate,HonorXoffYModem);
   { Ascii }
  AutoStripHighBit,AddLF,AsciiUseCtrlZ,AsciiSendAsis,AsciiSendBlank:Boolean;
  AsciiCharDelay,AsciiLineDelay,AsciiLineSize:Integer;
  AsciiPacingChar:Char;
  AsciiCRLFStr:String[2];
   { XModem }
  AltRPressed,SendingFiles,CrcUsed,DisplayTime,DoAcks,DoWXModem,DoSeaLink:Boolean;
  Base:Record
   SectorNumber:SmallInt;
   SendErrors:SmallInt;
   SectorCount:SmallInt;
   StopSend:Boolean;
   AltSPressed:Boolean;
  End;
  MenuTitle,XFileName:String;
  Blocks2Send,Time2Send,SavedTime2Send,StartTime:LongInt;
  EndTime,TimePerBlock:LongInt;
  TransferProtocol:Byte;
  XmodemCharWait,XmodemBlockWait,XmodemAckWait,XmodemMaxErrors,
  MenuLength:Integer;
  SectorSize:SmallInt;
  DownSizeYmodem,UseYmodemHeader:Boolean;
  TX,TY:Byte;
  W:Window;
  LineCount,ByteCount:Long;
  DefaultTransferType:Byte;
  CloseComm4Dos:Boolean;
  TName:String;
  SectorData:Array[0..2047]of Char;
  TrTab:Array[Char]of Char;
   { XModem }
  StopReceive:Boolean;
  XmodemParitySave:Char;
  XmodemStopSave,XmodemBitsSave:Integer;
  XHandle:Hdl;
  NullFileName:Boolean;
 End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                              IMPLEMENTATION
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

 { Il n'y a pas de code...}

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
END.