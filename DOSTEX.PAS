{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³         Malte Genesis/Module des Dos Terminator Element eXtended       Û
 ³             dition Chantal pour Mode R‚el/IV - Version 1.0            Û
 ³                              1995/11/30                                Û
 ³                                                                        Û
 ³            Tous droits r‚serv‚s par les Chevaliers de Malte (C)        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Nom des programmeurs
 ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

  Sylvain Maltais ainsi que Dieu Tout-Puissant


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette unit‚ contient toutes les donn‚es relativement au structure interne
 et longtemps garder secrŠte par le DOS au application.


 Remarques
 ÍÍÍÍÍÍÍÍÍ

  ş Les donn‚es con‡ern‚e,  peuvent ˆtre utilis‚ avec le DOS 2.0+, mais pas
    avec le DOS 1.xx ne supportant pas les fonctions de retour de donn‚e.

  ş Cette unit‚ est incompatible au langage de programmation QuickPascal de
    Microsoft annon‡ant une erreur  … cause qu'il explore des zones dont il
    n'aurait pas d– interpr‚ter.
}
Unit Dostex;

INTERFACE
{$I DEF.INC}
{$A-,O-}

Const
 fsPathName=79;
 fsDirectory=67;
 fsFileName=8;
 fsExtension=4;

 fcExtension=$0001;
 fcFileName=$0002;
 fcDirectory=$0004;
 fcWildcards=$0008;

Type
 {$IFDEF VER60}PChar=^Char;{$ENDIF}
 (***** Structure d'horloge *****)
 TimeType=(AmPm,      { 12 heures avec AM/PM comme aux tats-Unis }
	   Military); { 24 heures comme le systŠme international ou militaire }

 (***** Strucure Dos *****)
{$I Library\System\CPM\FCBRec.Inc}

 {Structure du Memory Control Block (MCB)}
 MCBRec=Record
  ID:Char;                     { Offset 00h }
  PSP,Size:Word;               { Offset 02h et 04h }
  Reserved:Array[0..2]of Byte; { Offset 05h, 06h, 07h }
  Name:Record Case Byte of
   0:(PChr:Array[0..7]of Char);{ Offset 08h … 0Fh }
   1:(Sign:Word);
  End;
  Header:Record Case Byte of
   0:(Prg:Word;
      Bla:Array[2..$7F]of Byte;
      Path:String[127]);
   1:(Data:Array[0..511]of Byte);
   2:(Comspec:Array[0..7]of Char);
  End;
 End;

 DriveParamBlock1Rec=Record
  NumFat:Byte;                { Nombre de FAT }
  SectorFirstDir:Word;        { Nombre de secteur du r‚pertoire principal }
  HeaderDriverDevice:Pointer; { Entˆte de la device pilote }
  ID:Char;                    { Identificateur }
  DiskAcces:Byte;             { AccŠs disque }
  NextDPB:Pointer;            { Pointeur sur le prochain DPB }
 End;

 DriveParamBlock2Rec=Record
  NumFat:Byte;                { Nombre de FAT }
  SectorFirstDir:Word;        { Nombre de secteur du r‚pertoire principal }
  HeaderDriverDevice:Pointer; { Entˆte de la device pilote }
  ID:Char;                    { Identificateur }
  DiskAcces:Byte;             { AccŠs disque }
  NextDPB:Pointer;            { Pointeur sur le prochain DPB }
  ClusterStartCurrDir:Word;   { Cluster de d‚part du r‚pertoire courant }
  Path:Array[0..63]of Char;   { R‚pertoire }
 End;

 DriveParamBlock3Rec=Record
  NmFat:Byte;                 { Nombre de FAT }
  SectorFirstDir:Word;        { Nombre de secteur du r‚pertoire principal }
  HeaderDriverDevice:Pointer; { Entˆte de la device pilote }
  ID:Char;                    { Identificateur }
  DiskAcces:Byte;             { AccŠs disque }
  NextDPB:Pointer;            { Pointeur sur le prochain DPB }
  ClusterSearchFree,NmFreeCluster:Word;
 End;

 DriveParamBlock4Rec=Record
  NmFat,SectorFirstDir:Word;  { Nombre de FAT, Nombre de secteur du r‚pertoire principal }
  HeaderDriverDevice:Pointer; { Entˆte de la device pilote }
  ID:Char;                    { Identificateur }
  DiskAcces:Byte;             { AccŠs disque }
  NextDPB:Pointer;            { Pointeur sur le prochain DPB }
  ClusterSearchFree,NumFreeCluster:Word;
 End;

 DriveParamBlock5Rec=DriveParamBlock4Rec;

 DriveParamBlockRec=Record
  Disk,UnitNumber:Byte;
  BytesPerSector:Word;
  SectorByCluster,ClusterIntoSectors:Byte;
  ReservedSector:Word;
  Ver:Record Case Byte of
   0:(Dos1:DriveParamBlock1Rec);
   1:(Dos2:DriveParamBlock2Rec);
   2:(Dos3:DriveParamBlock3Rec);
   3:(Dos4:DriveParamBlock4Rec);
   4:(Dos5:DriveParamBlock5Rec);
  End;
 End;

 {Enregistrement de la table de fichier système}
 SystemFileTablesRec=Record
  Next:Pointer;                 { Pointeur sur la table suivante }
  Nm:Word;                      { Nombre de table }
 End;

 {Enregistrement de l'horloge}
 ClockRec=Record
  NumOfDay1980:Word;            { Nombre de jour depuis 1980 }
  Min,Hour,Hund,Sec:Byte;       { Minute, heure, 100e, seconde }
 End;

 ChainIFSRec=Record
  SizeOf:Word;                  { Taille de cette enregistrement }
  ClassID:Byte;                 { Classe }
  DosError:Word;                { Code d'erreur Dos }
  IFSExitCode:Byte;             { Code de sortie }
  Reserved:Array[0..15]of Byte; { R‚serv‚ }
  FuncCode:Byte;                { Code de fonction }
 End;

 DiskBufInfoVer5Rec=Record
  BufHeader:Pointer;    { Entˆte de tampon }
  OfsBufChain:Word;     { Offset de la chaŒne de tampon }
  LookAheadBuf:Pointer;
  NumLookAheadBuf:Word;
  BufLocation:Byte;
  WorkSpaceBuf:Pointer; { Espace de travail du tampon }
 End;

 {Enregistrement du pilote de device NUL}
 NulDeviceRec=Record
  Next:Pointer;              { Pilote suivant }
  Data:Array[4..9]of Byte;   { Données de validation }
  Name:Array[0..7]of Char;   { Nom de la device }
 End;

 ExtDosBlock2Rec=Record
  NmDrive:Byte;
  MaxBytesBlockDevice:Word;
  FirstDiskBuffer:Pointer;
  NulDevice:NulDeviceRec;
 End;

 ExtDosBlock3Rec=Record
  NmBlockDevice:Byte;
  MaxBytesBlockInBlockDevice:Word;
  FirstDiskBuf:Pointer;
  CurrDir:PChar;
  LastDrive:Byte;
  StringArea:Pointer;
  FCB:^FCBRec;
  NmFCBS:Word;
  NulDevice:NulDeviceRec;
 End;

 ExtDosBlock31Rec=Record
  MaxBytesPerSectorInBlockDevice:Word;
  FirstDiskBuf:Pointer;
  CurrDir:PChar;
  FCB:^FCBRec;
  NmFCBS:Word;
  NmBlockDevice,NmDrive:Byte;
  NulDevice:NulDeviceRec;
  NmJoinDrives:Byte;
 End;

 ExtDosBlock4Rec=Record
  MaxBytesPerSectorInBlockDevice:Word;
  DiskBufInfo:Pointer;
  CurrDir:PChar;
  FCB:^FCBRec;
  NmFCBS:Word;
  NmBlockDevice,LastDrive:Byte;
  NulDevice:NulDeviceRec;
  NmJoinDrives:Byte;
  ListPrgNameSeg:Word;
  IFS:Procedure;
  ChainIFS:^ChainIFSRec;
  NmBufs,NumSubBufs:Word;
  BootDisk:Byte;
  Is32BitsUpCode:Boolean; { Supporte les instructions 32 bits? }
  XmsSizeK:Word;          { Quantit‚ de m‚moire XMS (en Ko) }
 End;

 ExtDosBlock5Rec=Record
  MaxBytesPerSectorInBlockDevice:Word;
  DiskBufInfo:^DiskBufInfoVer5Rec;
  CurrDir:PChar;
  FCB:^FCBRec;
  NmFCBS:Word;
  NmBlockDevice,LastDrive:Byte;
  NulDevice:NulDeviceRec;
  NmJoinDrives:Byte;
  ListPrgNameSeg:Word;
  SetVerListPrg:Pointer;  { Liste des versions pour le programme SETVER.EXE }
  CsDosFunc,IsDosInHma,NmBufs,NmSubBufs:Word;
  BootDisk:Byte;
  Is32BitsUpCode:Boolean; { Supporte les instructions 32 bits? }
  XmsSizeK:Word;          { Quantit‚ de m‚moire XMS (en Ko) }
 End;

 DosBlockRec=Record
  FirstMCB:^MCBRec;
  FirstDriveParm:^DriveParamBlockRec;
  SystemFileTables:^SystemFileTablesRec;
  Clock:^ClockRec;{ Device pilote d'horloge: $CLOCK}
  Con:^FCBRec;    { Device pilote de console: $CON }
  Ver:Record Case Byte of
   0:(Dos2:ExtDosBlock2Rec);
   1:(Dos30:ExtDosBlock3Rec);
   2:(Dos31:ExtDosBlock31Rec);
   3:(Dos4:ExtDosBlock4Rec);
   4:(Dos5:ExtDosBlock5Rec);
  End;
 End;

 DosBlockPtr=^DosBlockRec;

{$I Library\System\Dos\Country3.Inc}

IMPLEMENTATION

END.