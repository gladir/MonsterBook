/*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
  ³Malte Genesis/Module des Systems Terminator Element eXtended³
  ³        Edition Chantal pour Mode R‚el/IV - Version 1.0     ³
  ³                       1996/11/10                           ³
  ³                                                            ³
  ³      Tous droits r‚serv‚ par les Chevaliers de Malte (C)   ³
  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/

#define ShortBF

#ifndef Systex
 #define Systex

 #include <DOS.H>
// #include <MEM.H>
// #include <PROCESS.H>

 #define No 0
 #define Ya 1

 //Constante des couleurs standard et d'attribut de caractŠre
 #define Black        0  //Noir
 #define Blue         1  //Bleu
 #define Green        2  //Vert
 #define Cyan         3  //Cyan
 #define Red          4  //Rouge
 #define Magenta      5  //Magenta
 #define Brown        6  //Brun
 #define LightGray    7  //Gris pƒle
 #define DarkGray     8  //Gris fonc‚
 #define LightBlue    9  //Bleu claire
 #define LightGreen   10 //Vert claire
 #define LightCyan    11 //Cyan claire
 #define LightRed     12 //Rouge claire
 #define LightMagenta 13 //Magenta claire
 #define Yellow       14 //Jaune
 #define White        15 //Blanc

 typedef unsigned char Byte;
 typedef unsigned char Char;
 #define Chr unsigned char
 #define Wd unsigned int
 typedef Byte Bool;
 #define Hdl Byte

 #define MaxArray 65520
 #define errHdl   0xFFFF //Handle: Erreur handle

 #ifdef xyzabc

  /***** Constante de l'Ensemble Isabel *****/
 //ModŠle de d‚part
 const suIsabel=0x0;//Mode standard Isabel
 const suNoInt=0xF0;//Pas d'installation d'interruption
 //Drapeau conditionnel de v‚rification autoris‚
 #define flgProtectedMode 0x0001
 /*Ex‚cution en mode prot‚g‚? Par d‚faut: Non*/
 //Ce jumper doit ˆtre mis  … vrai  quand le StartUp est lanc‚ en
 //m‚moire prot‚g‚;  cela aura  pour effet  qu'il n'utilisera pas
 //d'accŠs m‚moire directe. Attention! Ne mettre cette variable …
 //vrai  quand  cas  de n‚cessit‚  parceque ‡a ralentie dr“lement
 //l'ex‚cution  en plus  d'ˆtre partiellement  moins fiable.  Par
 //d‚faut,  mˆme un XT  … un contr“leur CMOS  pour lui,  et l'EMS
 //n'existe pas car inutile en mode prot‚g‚.
 #define flgEquipPerBios 0x0002
 /*Utilise le Bios pour connaŒtre l'‚quipement? Par d‚faut: Non*/
 //Par d‚faut le StartUp utilise l'accŠs en m‚moire pour connaŒtre
 //l'‚quipement plut“t  que d'utiliser l'interruption  11h et 12h.
 //Personnellement,  j'ai jamais utilis‚ le Bios pour connaŒtre se
 //genre  d'information,  mais  dans les cas d‚sesp‚r‚s  de 0%  de
 //compatibilit‚, j'imagine que sa peut servir...
 #define flgJoyPerBios 0x0004
 /*Manette de jeu acc‚der par le Bios ? Par d‚faut: Non*/
 //Mettre  …  vrai  seulement  s'il  plante  en utilisant le port
 //d'entr‚e/sortie 201h ou qu'une ‚mulation de manette de jeu est
 //en cours par l'entremise de l'interruption 15h,Fonction 84h...
 #define flgNoExtBiosMemDetect 0x0008
 /*Pas d‚tection de la m‚moire ‚tendue par l'interruption 15h? Par d‚faut: Non*/
 //Cette variable doit ˆtre mis … vrai lorsque la d‚tection de la
 //m‚moire  ‚tendu   par  l'interruption 15h,  Fonction 88h  fait
 //planter la machine  ou que  des conflits  d'adressage  m‚moire
 //surviennent dans le systŠme.
 #define flgOnlyMem4ComputerName 0x0010
 /*Utilise seulement la m‚moire pour connaŒtre le nom de l'ordinateur? Par d‚faut: Non*/
 //Cette variable utilise seulement l'adresse m‚moire FFFFxh pour
 //connaŒtre  le  modŠle  d'ordinateur  utilis‚.  Mettre  …  vrai
 //seulement si la d‚tection de votre ordinateur, r‚vŠle que vous
 //poss‚dez une %&$%^&^%&,(ou si vous pr‚f‚rer: il "fuck"le chien.
 #define flgNoCountryDetect 0x0020
 /*Pas de d‚tection de pays? Par d‚faut: Non*/
 //Les variables  de pays ne seront pas touch‚  si cette variable
 //est … vrai.  Interne au application,  permet,  par exemple, de
 //charger  … partir d'une fichier la configuration d'un pays. On
 //peut ‚galement fix‚ cette variable  … vrai pour le Dos 1.0, ou
 //un Dos incompatible pour ‚viter d'avoir un retour de donn‚e en
 //blanc.
 #define flgNoMouseDetect 0x0040
 /*Pas de d‚tection de la souris? Par d‚faut: Non*/
 //Ce jumper ne doit seulement ˆtre utilis‚ que lorsque la souris
 //provoque des conflits dans le systŠme.  Alors  si l'ordinateur
 //plante pendant  une d‚tection de souris priŠre de mettre cette
 //variable  … Vrai.  On  peut  ‚galement  avoir  …  faire  … une
 //interruption  de la 4iŠme  DIMENSION  ou  qui plus  est  …  un
 //Virus  narcotique  modifiant  cette interruption  …  des  fins
 //diablique!  Et dans cette situation, je vous suggŠre ‚galement
 //de fixer cette variable … Vrai.
 #define flgNoSpoolerDetect 0x0080
 /*Pas de d‚tection de Spooler d'imprimante? Par d‚faut: Non*/
 //Ce jumper  doit ˆtre  … vrai  quand la  d‚tection  du  spooler
 //provoque un plantage pur et dur de la machine.
 #define flgNoCmosDetect 0x0100
 /*Pas de d‚tection ou d'utilisation du CMOS? Par d‚faut: Non*/
 //Cette variable interdit (vrai) ou autorise (faux) la d‚tection
 //et la manipulation du contr“leur de CMOS. Dois-ˆtre mis … vrai
 //dans le cas d'incompatibilit‚ de CMOS (en particuli‚ chez les XT.
 #define flgJoyFunc 0x0200
 /* Allocation de fonction de manette de jeu ?*/
 //Drapeau d'existance des Interruptions de la variable IntExistFlag
 const flgInt10h=1;//Drapeau indiquant l'existance de l'interruption 10h
 const flgInt11h=2;//Drapeau indiquant l'existance de l'interruption 11h
 const flgInt12h=4;//Drapeau indiquant l'existance de l'interruption 12h
 const flgInt13h=8;//Drapeau indiquant l'existance de l'interruption 13h
 const flgInt14h=0x0010;//Drapeau indiquant l'existance de l'interruption 14h
 const flgInt15h=0x0020;//Drapeau indiquant l'existance de l'interruption 15h
 const flgInt16h=0x0040;//Drapeau indiquant l'existance de l'interruption 16h
 const flgInt1Ah=0x0080;//Drapeau indiquant l'existance de l'interruption 1Ah
 const flgInt21h=0x0100;//Drapeau indiquant l'existance de l'interruption 21h
 const flgInt2Ah=0x0200;//Drapeau indiquant l'existance de l'interruption 2Ah
 const flgInt2Fh=0x0400;//Drapeau indiquant l'existance de l'interruption 2Fh
 const flgInt33h=0x0800;//Drapeau indiquant l'existance de l'interruption 33h
 const flgInt67h=0x1000;//Drapeau indiquant l'existance de l'interruption 67h
 //Constante de Resource m‚moire au niveau interne
 const irmDsk=0;//Resource Disque
 const irmEms=1;//Resource EMS
 const irmXms=2;//Resource XMS
 const irmVRam=3;//Resource Vid‚o
 const irmExtBios=4;//Resource Bios Interruption 15h
 //Mode de Jumper par d‚faut
 const stupJumperDef=flgProtectedMode*
  #ifdef _Windows
   Yes
  #elseif DPMI
   Yes
  #else
   No
  #endif)
  +
  flgEquipPerBios*
  #ifdef _Windows
   Yes
  #else
   No
  #endif
   +
  flgJoyPerBios*No+
  flgNoExtBiosMemDetect*No+flgOnlyMem4ComputerName*No+
  flgNoCountryDetect*No+flgNoMouseDetect*No+
  flgNoSpoolerDetect*No+flgNoCmosDetect*No+
  flgJoyFunc*
  #ifdef Joystick
   Yes
  #else
   No
  #endif
 ;

  // D‚finition des types de bases
 #define NIL NULL

 typedef struct WordRec { Byte Lo,Hi;};

 /***** Structure d'horloge *****/
 typedef enum TimeType {AmPm,Military};

 typedef struct FCBRec {
  Byte Num;
  Char Name[7];
  Char Ext[2];
  Wd   CurrBlock,SizeRec;
  long SizeFile,LastTime;
  Byte Reserved[7];
  Byte CurrRec;
  long SelectAcces;
 };

 typedef struct MCBRec {
  Char ID;
  Wd   PSP,Size;
  Byte Reserved[2];
  Char Name[7];
  union {
   Wd   Prg;
   Byte Data[511];
   Char Comspec[7];
  } Header;
 };

 typedef struct DriveParamBlock1Rec {
  Byte NumFat;
  Wd   SectorFirstDir;
  void far *HeaderDriverDevice;
  Char ID;
  Byte DiskAcces;
  void far *NextDPB;
 };

 typedef struct {
  Byte NumFat; Wd SectorFirstDir; void far *HeaderDriverDevice;
  Char ID; Byte DiskAcces; void far *NextDPB; Wd ClusterStartCurrDir;
  Char Path[63];
 } DriveParamBlock2Rec;

 typedef struct {
  Byte NmFat; Wd SectorFirstDir; void far *HeaderDriverDevice;
  Char ID; Byte DiskAcces; void far *NextDPB;
  Wd ClusterSearchFree,NmFreeCluster;
 } DriveParamBlock3Rec;

 typedef struct {
  Wd NmFat,SectorFirstDir; void far *HeaderDriverDevice;
  Char ID; Byte DiskAcces; void far *NextDPB;
  Wd ClusterSearchFree,NumFreeCluster;
 } DriveParamBlock4Rec;

 typedef DriveParamBlock4Rec DriveParamBlock5Rec;

 typedef struct {
  Byte Disk,UnitNumber; Wd BytesPerSector;
  Byte SectorByCluster,ClusterIntoSectors;
  Wd ReservedSector;
  union {
   struct DriveParamBlock1Rec Dos1;
//   struct DriveParamBlock2Rec Dos2;
//   struct DriveParamBlock3Rec Dos3;
//   struct DriveParamBlock4Rec Dos4;
//   struct DriveParamBlock5Rec Dos5;
  } Ver;
 } DriveParamBlockRec;

 typedef struct { void far *Next; Wd Nm; } SystemFileTablesRec;
 typedef struct { Wd NumOfDay1980; Byte Min,Hour,Hund,Sec; } ClockRec;

 typedef struct {
  Wd SizeOf; Byte Class; Wd DosError; Byte IFSExitCode;
  Byte Reserved[15]; Byte FuncCode;
 } ChainIFSRec;

 typedef struct {
  void far *BufHeader; Wd OfsBufChain; void far *LookAheadBuf;
  Wd NumLookAheadBuf; Byte BufLocation; void far *WorkSpaceBuf;
 } DiskBufInfoVer5Rec;

 typedef struct { void far Next;Byte Data[5];Char Name[7];} NulDeviceRec;

 typedef struct {
  Byte NmDrive;Wd MaxBytesBlockDevice;
  void far *FirstDiskBuffer;NulDeviceRec NulDevice;
 } ExtDosBlock2Rec;

 typedef struct {
  Byte NmBlockDevice; Wd MaxBytesBlockInBlockDevice;
  void far *FirstDiskBuf; Char *CurrDir; Byte *LastDrive;
  void far *StringArea; struct FCBRec *FCB; Wd NmFCBS; NulDeviceRec NulDevice;
 } ExtDosBlock3Rec;

 typedef struct {
  Wd MaxBytesPerSectorInBlockDevice; void far *FirstDiskBuf;
  Char *CurrDir; struct FCBRec *FCB; Wd NmFCBS; Byte NmBlockDevice,NmDrive;
  NulDeviceRec NulDevice; Byte NmJoinDrives;
 } ExtDosBlock31Rec;

 typedef struct {
  Wd MaxBytesPerSectorInBlockDevice; void far *DiskBufInfo;
  Char *CurrDir; struct FCBRec *FCB; Wd NmFCBS; Byte NmBlockDevice,LastDrive;
  NulDeviceRec NulDevice; Byte NmJoinDrives; Wd ListPrgNameSeg;
  void far IFS; ChainIFSRec *ChainIFS; Wd NmBufs,NumSubBufs;
  Byte BootDisk; Bool Is32BitsUpCode; Wd XmsSizeK;
 } ExtDosBlock4Rec;

 typedef struct {
  Wd MaxBytesPerSectorInBlockDevice; DiskBufInfoVer5Rec *DiskBufInfo;
  Char *CurrDir; struct FCBRec *FCB; Wd NmFCBS; Byte NmBlockDevice,LastDrive;
  NulDeviceRec NulDevicec; Byte NmJoinDrives; Wd ListPrgNameSeg;
  void far *SetVerListPrg; Wd CsDosFunc,IsDosInHma,NmBufs,NmSubBufs;
  Byte BootDisk; Bool Is32BitsUpCode; Wd XmsSizeK;
 } ExtDosBlock5Rec;

 typedef struct {
  struct MCBRec *FirstMCB;
  DriveParamBlockRec *FirstDriveParm;
  SystemFileTablesRec *SystemFileTables;
  ClockRec *Clock; // $CLOCK
  struct FCBRec *Con; // $CON
  union {
   ExtDosBlock2Rec Dos2;
   ExtDosBlock3Rec Dos30;
   ExtDosBlock31Rec Dos31;
   ExtDosBlock4Rec Dos4;
   ExtDosBlock5Rec Dos5;
  } Ver;
 } DosBlockRec;

 typedef DosBlockRec *DosBlockPtr;
 typedef Chr   TChar[MaxArray];
 typedef TChar *PChr;TChar *PTChr;
 typedef struct RPtr {Wd Base;Byte LoSeg;};
 typedef struct find_t SearchRec;

  /***** M‚moire *****/
 typedef struct PCharByteRec {PChr PChr;Byte Nm;};
 typedef struct PCharByteRec *PPChrByte;
 typedef struct StrByteRec {PChr PChr;Byte Nm;Wd Len;};
 typedef struct StrByteRec *PStrByte;
 typedef struct StrWordRec {PChr PChr;Wd Nm;Wd Len;};
 typedef struct StrWordRec *PStrWord;
 typedef struct PCharWordRec {PChr PChr;Wd Nm;};
 typedef struct PCharWordRec *PPChrWord;

  /***** Structure Micro-Processeur *****/
 //Format de la table d'Interruption
 typedef far void *TableIntRec[255];
 typedef far void *SaveIntRec[8];//Utilis‚ par Isabel pour sauver les anciennes interruptions

   // RemoveBuffer Pointer Type
 #ifdef DPMI
  typedef long RBP;
 #else
  typedef Wd RBP;
 #endif
 typedef struct RBufRec *RBufPtr;
 typedef struct RBufRec {
  void far *Buf;
  Wd Size;
  RBufPtr Prev,Nxt;
 };

 typedef struct RBuf {
  RBP NB; //Nombre de tampon dans la liste
  struct RBufRec *CurrPtr,*Ls,*EndLsPtr;//Pointeur courant,Liste elle-mˆme,Fin de liste
 };

 /***** Structure de communication *****/
 //Structure primaire de communication
 typedef Chr AsyncBufType[1];
 typedef AsyncBufType *AsyncPtr;
 typedef struct IBufRec *IBufPtr;
 typedef struct IBufRec {
  void far *Buf;Wd Size;long Jmp;IBufPtr Prev,Nxt;
 };
 typedef struct IBuf {struct IBufRec *Ls,*EndLsPtr;long NB,NV;};
 //Structure de manipulation de m‚moire par l'Interruption 15h
 typedef struct SDES {Wd Length,AdrLo;Byte AdrHi,Attribut;Wd Res;};
 typedef struct GDT {struct SDES Dummy,GDTS,Start,But,Code,Stack;};
 typedef struct LI {Wd LoWord;Byte HiByte,Dummy;};
 //Structure de l'XMS
 typedef struct ExtMemMoveRec {long Length;Wd SourceHandle;long SourceOffset;Wd DestHandle;long DestOffset;};
 typedef struct XmsGetRec {long Size;Wd QHdl;long QOfs;Wd ZHdl;void far *ZOfs;};
 typedef struct XmsSetRec {long Size;Wd QHdl;void far *QOfs;Wd ZHdl;long ZOfs;};
 typedef struct EMBHandleRec {Byte LockCount,FreeHandles;Wd BlockLenKB;};
 typedef struct UMBSegRec { Wd Seg,UMBSizeKB;};
 //Structure de la CMOS (M‚moire sur Pile)
 typedef Byte CmosType[63];
 //Structure d'un Handle d'une ressource
 typedef struct XInf { Byte Output;Wd Handle;long Size;};

 //Structure de lecture pour la disquette
 typedef struct SecPosType {Byte Head;Wd SectTrack;};
 //Structure de partition
 typedef struct PartEntryType {
  Byte Status; struct SecPosType StartSec; Byte PartType;
  struct SecPosType EndSec; long SecOfs,NumSec;
 };
 //Structure de Boot
 typedef struct PartSecType {Byte BootCode[0x1BD];struct PartEntryType PartTable[3];};

 /**** Fichier ****/
 //Structure du Handle Isabel d'une banque de fichier
 typedef struct Search32Rec {Byte Fill[5];PChr PtrDescr;Byte Attr;long Time,Size;Char Name[12];};
 typedef struct Search32Rec TSearch32Rec[MaxArray>>5];
 typedef enum FileSort {fUnsort,fName,fExt,fSize,fTime};
 typedef struct{
  #ifdef ShortBF
   struct TSearch32Rec *B;Wd SizeB;
  #else
   struct RBuf B;
  #endif
  Bool Init;
  long SizeFiles;
  enum FileSort Tri;
 } BF;

  /***** StartUp *****/
 //Structure des "Jumpers" du StartUp
 typedef struct Jumper { Wd FlgMethod;};
 //Structure de StartUp
 typedef struct StartUpRec {
  Byte CPU;Bool Up32Bits;Byte Bus;//Info sur le Micro-Processeur et son bus systŠme
  Wd ComputerName;Bool PS2;//Info sur le modŠle d'Ordinateur
  Wd IntExistFlags;//Info sur les Interruptions
  Wd GetDosVer;DosBlockPtr GetDosBlock;Bool HandleExist;//Info sur le DOS
  Bool OS2;Byte OS2HiVer,OS2LoVer,Win,WinLoVer,WinHiVer;//Info sur OS/2 et Windows
  Wd CountryCode,CodePage,Date;Chr Curr[4];//Info de pays
  Chr ThSep[1],DeSep[1],DtSep[1],TmSep[1];Byte CurrStyle,Digits;enum TimeType Time;
  void far *CaseUp; Chr DaSep[1];
  Bool FloppyDskExist;Byte NmFloppyDsk;//Info sur le(s) lecteur(s) de disquette
  Bool HardDskExist;Byte NmHardDsk;Wd HardDskCtrl;//Info sur le(s) disque(s) dur
  Bool IsNovell;Byte Spooler;//Info r‚seau/spooler d'imprimante
  Bool JoyExist,BiosJoy;Wd JoyPort,JoyPotentioMeter;//Info sur la manette de jeu
  Byte KbdModel,KbdCtrl;Wd KbdReadPort;Bool BiosKbdEnh;//Info sur le clavier
  Bool LPTExist;Byte NmLPT,Get1LPT;//Info sur le port parallŠle
  Bool ComExist;Byte NmCom;//Info sur le port s‚rie
  Wd MemTotalSize;//Info sur la m‚moire conventionnel
  Bool EmmExist;Wd EmmSeg,EmmTotalSize;//Info sur l''Expanded Memory Manager (EMS)
  Bool XmmExist;void far *XmmCtrl;Wd XmsTotalSize;//Info sur l''eXtended Memory Manager (XMS)
  Bool ExtBiosExist;Wd ExtBiosSizeK;//Info sur la m‚moire ‚tendu g‚r‚ par le Bios Int 15h
  Byte CtrlCmos;Wd CmosPort;//Info sur le CMOS
  Byte Mouse;Wd MouseVer,MsButton;//Info sur la souris
  //Index de proc‚dure ou fonction … r‚f‚rence resource RLL
  Byte indAltPress,indCtrlPress,//AltPressed/CtrlPressed
  indFillChr,//FillByte/FillCharacter
  indGetIntVec,//GetInterruptVector
  indGetRawTimer,//GetRawTimer
  indGetRawTimerB,//GetRawTimerInByte
  indJoyPos,//JoystickPosition
  indKeyPress,//KeyPressed
  indLShiftPress,//LeftShiftPressed
  indMove,//Move/MoveLeft
  indPushKey,//PushKey
  indReadKey,//ReadKey
  indRShiftPress,//RightShiftPressed
  indSetIntVec,//SetInterruptVector
  indShiftPress;//ShiftPressed
 };
 //Tableau d'index du StartUp
 typedef Byte indRec[14];

 extern Byte Mouse;
 #define Halt(a) exit(a)

#endif

 #define dvBios    0 //Pilote utilisant le Bios
 #define dvTxt     1 //Pilote sp‚cialis‚ pour les ‚crans de texte
 #define dv2       2 //Pilote sp‚cialis‚ pour les ‚crans graphiques en 2 couleurs: CGA, EGA, VGA,...
 #define dvGS640   3 //Pilote sp‚cialis‚ pour l'‚cran 640x200 en 16 couleurs de la Super CGA d'ATI
 #define dv16      4 //Pilote sp‚cialis‚ pour les ‚crans 16 couleurs des (S)EGA, (S)VGA
 #define dv19      5 //Pilote sp‚cialis‚ exlusivement pour le mode 320x200 en 256 couleurs (S)VGA
 #define dvSVGA    6 //Pilote sp‚cialis‚ pour les modes 256 couleurs des Super VGA
 #define dvSVGA386 7 //Identique au pilote pr‚c‚dant mes r‚clames un CPU 386 ou +
 #define dvSetMode 8

 typedef struct PIV {
  Byte Card,Monitor; //Nom de la carte vid‚o (vn????),Nom du moniteur (mn????)
  Byte CardCat;//Cat‚gorie de la carte vid‚o(MDA,CGA,...)(cvn????)
  long Memory;//Nombre de m‚moire (en octet) dont dispose la carte vid‚o
  Bool Font;//Police programme support‚ par cette carte?
  Bool Hercule;//Mode Hercule support‚ par cette carte?
  Wd Seg16C;//Segment par d‚faut en 16 couleurs
  Bool Palette;//Palette de couleur programme support‚?
  Bool Color;//Carte de type couleur? autrement monochrome
  Bool BBlink; //Le Bios supporte le mode clignotement/intensit‚?
  Bool EGA; //La carte est post‚rieur ou ‚gale … l'EGA
  Bool VGA; //La carte est post‚rieur ou ‚gale … la VGA
  Bool VGA320x400; //Le mode VGA 320x400 est support‚ (pas toujours le cas chez les clones)
  Bool VESA; //Le standard VESA support‚?
  Wd ROM;//Adresse de la ROM Bios
  Bool MousePort;//Port souris inclue … la carte vid‚o?
  Byte VideoBits;//Nombre d'accŠs bits au entr‚e/sortie vid‚o
  Byte ROMBits;//Nombre d'accŠs bits … la ROM Bios
  Byte DACBits;//Nombre de bits utilis‚ pour modifi‚ un des 3 DAC RGB
  Bool PVC;//Horloge vid‚o programme?
  Wd ProcSelBnkPg; //Adresse d'index de la proc‚dure de changement de page de la banque
  Wd ProcSetVideoMode;//Adresse d'index de la proc‚dure de changement de mode vid‚o
 };

 typedef struct MIV {
  Wd Mode;//Mode vid‚o actuel (vm???)
  Bool IbmLogic,//Mode dans la logique IBM (pas hors cas texte … la SVGA...)
  BiosSupport,//Mode support‚ par le Bios (Par exemple, la GS en 16 couleurs le Bios ne le connaŒt pas)
   Colr,//Mode couleur? Sinon monochrome for‡‚ment...
   Graf,//Mode graphique? Sinon texte
   Direct,//M‚thode directe? Sinon Bios ou Dos
   Blink,//Clignotement?
   Snow;//Neige lors de l'envoie de donn‚e dans le tampon vid‚o?
  Wd SegV;//Segment vid‚o (A000h,B000h,B800h,...)
  Byte HeightChr;//Hauteur de la police de caractŠre actuel
  Wd NmXPixels,//Nombre de pixels horizontal qu'affiche l'‚cran
     NmYPixels;//Nombre de pixels vertical qu'affiche l'‚cran
  Byte NmXTxts,NmYTxts,//Nombre de caractŠre texte horizontal/vertical qu'affiche l'‚cran
   NmVidPgs;//Nombre de page vid‚o que supporte le mode actuel
  long NmColrs;//Nombre de couleurs affich‚
  Byte BitsPerPixel;//Nombre de Bit(s) utilis‚ pour l'affichage d'un pixel
  Wd BytesPerLn;//Nombre d'octet par ligne affich‚ (trŠs relatif en VGA...)
  Byte Pg;//Num‚ro de la page vid‚o de travail
  Wd AddrPg;//En texte, adresse en m‚moire vid‚o de la page actuel
  Byte ShowPg;//Num‚ro de la page vid‚o actuellement affich‚
  Byte *TxtMtx;//Pointeur sur la police de caractŠre courante
  long ScrSize;//Taille de l'‚cran
  Wd SizeBnk;//Taille d'un page de la banque (0=64Ko)
  Wd SegBuf;//Segment du tampon d'acc‚l‚ration
 };

#endif