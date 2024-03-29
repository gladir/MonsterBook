{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴콘
 �                                                                �
 �                   Malte Genesis/BBS Cortex                     �
 �       릁ition Chantal pour Mode R괻l/IV - Version 1.2          �
 �                          1997/01/02                            �
 �                                                                �
 �      Tous droits r굎erv굎 par les Chevaliers de Malte (C)      �
 �                                                                �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複蔔


 Nom du programmeur
 袴袴袴袴袴袴袴袴袴

  Sylvain Maltais


 Description
 袴袴袴袴袴�

  Cette unit� est en quelque sorte une ent늯e de d괽inition pour la
 communication par modem.
}

Unit BBSTex;

{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�}
                                 INTERFACE
{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�}

Uses Systex;

Const

 MaxUsers=100;        { Nombre maximal d'usager chargeable en m굆oire }
 MaxLoginTry=3;       { Nombre maximal de tentative de connexion avant d'abandonner }
 KermitNone=0;        { Protocol Kermit sans format }
 KermitAscii=1;       { Protocol Kermit en ASCII }
 KermitBinary=2;      { Protocol Kermit en Binaire }
 TransTimeVal=1800.0; { Valeur du temps de transfert }

 SingleFileProtocol:Array[1..trsMax]of Boolean=(True,True,True,No,No,No,No,True,True,No,No,True,True,True,True,True);

 DefaultTransferType:Byte=trsXmodemChk;

  {Code de retour du protocol}
 protNone=0;         { Rien }
 protReceiveError=1; { Erreur de r괹eption }
 protCarrierDrop=2;  { Raccrocher }
 protAltRStop=3;     { Arr늯er par Alt+R }
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
  FirstName:Array[0..18]of Chr;{Pr굈om}
  LastName:Array[0..18]of Chr;{Nom de famille}
  PassWd:Array[0..15]of Chr;{Mot de passe}
  Phone:Array[0..20]of Chr;{Num굍o de t굃굋hone}
  Level:Array[0..4]of Chr;{Niveau de s괹urit�}
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

{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�}
                              IMPLEMENTATION
{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�}

 { Il n'y a pas de code...}

{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�}
END.