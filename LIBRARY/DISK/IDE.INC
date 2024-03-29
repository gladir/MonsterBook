{Library\Disk\IDE.Inc}

{ Description
  様様様様様�

   Ce fichier contient les informations d'ent�te concernant les disques dur
  et CD-ROM compatible IDE.
}

Const
  { Registre fichier de disque ATA/ATAPI (port d'adressage 01F0h ou 0170h) }
 ideAtaRegData=0;		        { Donn�e (16 bits) }
 ideAtaRegFeat=1;		        { �criture: Registre de fourniture }
 ideAtaRegErr=ideAtaRegFeat;	        { Lecture: Erreur }
 ideAtaRegCnt=2;		        { ATA: Compteur de secteur }
 ideAtaRegReason=ideAtaRegCnt;	        { ATAPI: Raison d'interruption }
 ideAtaRegSect=3;		        { Secteur }
 ideAtaRegLoCyl=4;		        { ATA: Cylindre pour LSB }
 ideAtaRegLoCnt=ideAtaRegLoCyl;	        { ATAPI: Compteur de transfert pour LSB }
 ideAtaRegHiCyl=5;		        { ATA: Cylindre pour MSB }
 ideAtaRegHiCnt=ideAtaRegHiCyl;	        { ATAPI: Compteur de transfert pour MSB }
 ideAtaRegDrvHD=6;	                { Unit� s�lectionner; t�te }
 ideAtaRegCmd=7;		        { �criture: Commande d'unit� }
 ideAtaRegStat=7;		        { Lecture: �tat actuel et drapeaux d'erreur }
 ideAtaRegSLCT=$0206;		        { �criture: Contr�le de device }
 ideAtaRegAltSt=$0206;		        { Lecture: �tat ou erreur alternative }
  { Octets d'unit�e de commande ATA }
 ideAtaCmdRD=$20;		        { Lecture d'un secteur }
 ideAtaCmdWR=$30;	                { �criture d'un secteur }
 ideAtaCmdPkt=$A0;		        { Commande de paquet ATAPI }
 ideAtaCmdPID=$A1;		        { Identificateur ATAPI }
 ideAtaCmdRrMul=$C4;		        { Lecture de multiple secteurs }
 ideAtaCmdWrMul=$C5;                    { �critre de multiple secteurs }
 ideAtaCmdID=$EC;		        { Identificateur ATA }
 ideAtaCmdRrDMA=$C8;		        { Lecture des secteurs w/ DMA }
 ideAtaCmdWrDMA=$CA;		        { �criture des secteurs w/ DMA }
 ideAtaCmdSetMult=$C6;		        { Fixe le mode multiple }
  { Taille de secteur ATA (512 octets) }
 ideAtaLgSectSize=9;
 ideAtaSectSize=(1 shl ideAtaLgSectSize);
  { Taille de secteur ATAPI (2048 octets) }
 ideAtapiLgSectSize=11;
 ideAtapiSectSize=(1 shl ideAtapiLgSectSize);
  { Phases de transfert de donn�e/commande ATAPI }
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
  Cyls,Heads,Sects:Word;	{ G�om�trie CHS }
  DoesDMA:Boolean;
  DoesLBA:Boolean;
  UseLBA:Boolean;
  IsATAPI:Boolean;
  MultSect:Word; { Nombre de secteur a d�placer dans le mode multiple }
  DrvSel:Byte;	 { Seulement ATA, ATAPI (LUN pour SCSI?) }
  IOAdr:Word;
 End;

 IdeDriveCmd=Record
  Blk:LongInt;	{ Dans les Secteurs }
  Count:LongInt;{ En octets }
  Cmd,Dev:Byte;
  Data:^Byte;
 End;