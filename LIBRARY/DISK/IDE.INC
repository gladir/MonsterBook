{Library\Disk\IDE.Inc}

{ Description
  ÕÕÕÕÕÕÕÕÕÕÕ

   Ce fichier contient les informations d'entàte concernant les disques dur
  et CD-ROM compatible IDE.
}

Const
  { Registre fichier de disque ATA/ATAPI (port d'adressage 01F0h ou 0170h) }
 ideAtaRegData=0;		        { DonnÇe (16 bits) }
 ideAtaRegFeat=1;		        { êcriture: Registre de fourniture }
 ideAtaRegErr=ideAtaRegFeat;	        { Lecture: Erreur }
 ideAtaRegCnt=2;		        { ATA: Compteur de secteur }
 ideAtaRegReason=ideAtaRegCnt;	        { ATAPI: Raison d'interruption }
 ideAtaRegSect=3;		        { Secteur }
 ideAtaRegLoCyl=4;		        { ATA: Cylindre pour LSB }
 ideAtaRegLoCnt=ideAtaRegLoCyl;	        { ATAPI: Compteur de transfert pour LSB }
 ideAtaRegHiCyl=5;		        { ATA: Cylindre pour MSB }
 ideAtaRegHiCnt=ideAtaRegHiCyl;	        { ATAPI: Compteur de transfert pour MSB }
 ideAtaRegDrvHD=6;	                { UnitÇ sÇlectionner; tàte }
 ideAtaRegCmd=7;		        { êcriture: Commande d'unitÇ }
 ideAtaRegStat=7;		        { Lecture: êtat actuel et drapeaux d'erreur }
 ideAtaRegSLCT=$0206;		        { êcriture: Contrìle de device }
 ideAtaRegAltSt=$0206;		        { Lecture: êtat ou erreur alternative }
  { Octets d'unitÇe de commande ATA }
 ideAtaCmdRD=$20;		        { Lecture d'un secteur }
 ideAtaCmdWR=$30;	                { êcriture d'un secteur }
 ideAtaCmdPkt=$A0;		        { Commande de paquet ATAPI }
 ideAtaCmdPID=$A1;		        { Identificateur ATAPI }
 ideAtaCmdRrMul=$C4;		        { Lecture de multiple secteurs }
 ideAtaCmdWrMul=$C5;                    { êcritre de multiple secteurs }
 ideAtaCmdID=$EC;		        { Identificateur ATA }
 ideAtaCmdRrDMA=$C8;		        { Lecture des secteurs w/ DMA }
 ideAtaCmdWrDMA=$CA;		        { êcriture des secteurs w/ DMA }
 ideAtaCmdSetMult=$C6;		        { Fixe le mode multiple }
  { Taille de secteur ATA (512 octets) }
 ideAtaLgSectSize=9;
 ideAtaSectSize=(1 shl ideAtaLgSectSize);
  { Taille de secteur ATAPI (2048 octets) }
 ideAtapiLgSectSize=11;
 ideAtapiSectSize=(1 shl ideAtapiLgSectSize);
  { Phases de transfert de donnÇe/commande ATAPI }
 ideAtapiPhAbort=0;	{ Autre phases possibles }
 ideAtapiPhDone=3;      { (1, 2, 11) sont valides }
 ideAtapiPhDataOut=8;
 ideAtapiPhCmdOut=9;
 ideAtapiPhDataIn=10;
  { Commande de paquet d'octets ATAPI }
 ideAtapiCmdStartStop=$1B;	{ Ejection/Chargement }
 ideAtapiCmdRead10=$28;	        { Lecture de(s) secteur(s) }
 ideAtapiCmdReadTOC=$43; 	{ Lecture de table de contenue audio (Table-Of-Contents) }
 ideAtapiCmdPlay=$47;           { Jouer audio }
 ideAtapiCmdPause=$4B;	        { Pause/Continue audio }
  { Delays de Linux ide.h (milliseconds) }
 ideWaitID=30000;
 ideWaitPID=1000;
 ideWaitCMD=10000;
 ideWaitReady=30;
  { Champ de 'Cmd' de la structure 'IdeDriveCmd' }
 ideDrvCmdRd=1;
 ideDrvCmdWr=2;

Type
 IdeDriveInfo=Record
  Cyls,Heads,Sects:Word;	{ GÇomÇtrie CHS }
  DoesDMA:Boolean;
  DoesLBA:Boolean;
  UseLBA:Boolean;
  IsATAPI:Boolean;
  MultSect:Word; { Nombre de secteur a dÇplacer dans le mode multiple }
  DrvSel:Byte;	 { Seulement ATA, ATAPI (LUN pour SCSI?) }
  IOAdr:Word;
 End;

 IdeDriveCmd=Record
  Blk:LongInt;	{ Dans les Secteurs }
  Count:LongInt;{ En octets }
  Cmd,Dev:Byte;
  Data:^Byte;
 End;