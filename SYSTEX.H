/*旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
  쿘alte Genesis/Module des Systems Terminator Element eXtended�
  �        Edition Chantal pour Mode R괻l/IV - Version 1.0     �
  �                       1996/11/10                           �
  �                                                            �
  �      Tous droits r굎erv� par les Chevaliers de Malte (C)   �
  읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸*/

#define ShortBF

#ifndef Systex
 #define Systex

 #include <DOS.H>
// #include <MEM.H>
// #include <PROCESS.H>

 #define No 0
 #define Ya 1

 //Constante des couleurs standard et d'attribut de caract둹e
 #define Black        0  //Noir
 #define Blue         1  //Bleu
 #define Green        2  //Vert
 #define Cyan         3  //Cyan
 #define Red          4  //Rouge
 #define Magenta      5  //Magenta
 #define Brown        6  //Brun
 #define LightGray    7  //Gris p긨e
 #define DarkGray     8  //Gris fonc�
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
 //Mod둳e de d굋art
 const suIsabel=0x0;//Mode standard Isabel
 const suNoInt=0xF0;//Pas d'installation d'interruption
 //Drapeau conditionnel de v굍ification autoris�
 #define flgProtectedMode 0x0001
 /*Ex괹ution en mode prot괾�? Par d괽aut: Non*/
 //Ce jumper doit 늯re mis  � vrai  quand le StartUp est lanc� en
 //m굆oire prot괾�;  cela aura  pour effet  qu'il n'utilisera pas
 //d'acc둺 m굆oire directe. Attention! Ne mettre cette variable �
 //vrai  quand  cas  de n괹essit�  parceque 놹 ralentie dr뱇ement
 //l'ex괹ution  en plus  d'늯re partiellement  moins fiable.  Par
 //d괽aut,  m늤e un XT  � un contr뱇eur CMOS  pour lui,  et l'EMS
 //n'existe pas car inutile en mode prot괾�.
 #define flgEquipPerBios 0x0002
 /*Utilise le Bios pour conna똳re l'굌uipement? Par d괽aut: Non*/
 //Par d괽aut le StartUp utilise l'acc둺 en m굆oire pour conna똳re
 //l'굌uipement plut뱓  que d'utiliser l'interruption  11h et 12h.
 //Personnellement,  j'ai jamais utilis� le Bios pour conna똳re se
 //genre  d'information,  mais  dans les cas d굎esp굍굎  de 0%  de
 //compatibilit�, j'imagine que sa peut servir...
 #define flgJoyPerBios 0x0004
 /*Manette de jeu acc괺er par le Bios ? Par d괽aut: Non*/
 //Mettre  �  vrai  seulement  s'il  plante  en utilisant le port
 //d'entr괻/sortie 201h ou qu'une 굆ulation de manette de jeu est
 //en cours par l'entremise de l'interruption 15h,Fonction 84h...
 #define flgNoExtBiosMemDetect 0x0008
 /*Pas d굏ection de la m굆oire 굏endue par l'interruption 15h? Par d괽aut: Non*/
 //Cette variable doit 늯re mis � vrai lorsque la d굏ection de la
 //m굆oire  굏endu   par  l'interruption 15h,  Fonction 88h  fait
 //planter la machine  ou que  des conflits  d'adressage  m굆oire
 //surviennent dans le syst둴e.
 #define flgOnlyMem4ComputerName 0x0010
 /*Utilise seulement la m굆oire pour conna똳re le nom de l'ordinateur? Par d괽aut: Non*/
 //Cette variable utilise seulement l'adresse m굆oire FFFFxh pour
 //conna똳re  le  mod둳e  d'ordinateur  utilis�.  Mettre  �  vrai
 //seulement si la d굏ection de votre ordinateur, r굒둳e que vous
 //poss괺ez une %&$%^&^%&,(ou si vous pr괽굍er: il "fuck"le chien.
 #define flgNoCountryDetect 0x0020
 /*Pas de d굏ection de pays? Par d괽aut: Non*/
 //Les variables  de pays ne seront pas touch�  si cette variable
 //est � vrai.  Interne au application,  permet,  par exemple, de
 //charger  � partir d'une fichier la configuration d'un pays. On
 //peut 괾alement fix� cette variable  � vrai pour le Dos 1.0, ou
 //un Dos incompatible pour 굒iter d'avoir un retour de donn괻 en
 //blanc.
 #define flgNoMouseDetect 0x0040
 /*Pas de d굏ection de la souris? Par d괽aut: Non*/
 //Ce jumper ne doit seulement 늯re utilis� que lorsque la souris
 //provoque des conflits dans le syst둴e.  Alors  si l'ordinateur
 //plante pendant  une d굏ection de souris pri둹e de mettre cette
 //variable  � Vrai.  On  peut  괾alement  avoir  �  faire  � une
 //interruption  de la 4i둴e  DIMENSION  ou  qui plus  est  �  un
 //Virus  narcotique  modifiant  cette interruption  �  des  fins
 //diablique!  Et dans cette situation, je vous sugg둹e 괾alement
 //de fixer cette variable � Vrai.
 #define flgNoSpoolerDetect 0x0080
 /*Pas de d굏ection de Spooler d'imprimante? Par d괽aut: Non*/
 //Ce jumper  doit 늯re  � vrai  quand la  d굏ection  du  spooler
 //provoque un plantage pur et dur de la machine.
 #define flgNoCmosDetect 0x0100
 /*Pas de d굏ection ou d'utilisation du CMOS? Par d괽aut: Non*/
 //Cette variable interdit (vrai) ou autorise (faux) la d굏ection
 //et la manipulation du contr뱇eur de CMOS. Dois-늯re mis � vrai
 //dans le cas d'incompatibilit� de CMOS (en particuli� chez les XT.
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
 //Constante de Resource m굆oire au niveau interne
 const irmDsk=0;//Resource Disque
 const irmEms=1;//Resource EMS
 const irmXms=2;//Resource XMS
 const irmVRam=3;//Resource Vid굊
 const irmExtBios=4;//Resource Bios Interruption 15h
 //Mode de Jumper par d괽aut
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

  // D괽inition des types de bases
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

  /***** M굆oire *****/
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
 typedef far void *SaveIntRec[8];//Utilis� par Isabel pour sauver les anciennes interruptions

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
  struct RBufRec *CurrPtr,*Ls,*EndLsPtr;//Pointeur courant,Liste elle-m늤e,Fin de liste
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
 //Structure de manipulation de m굆oire par l'Interruption 15h
 typedef struct SDES {Wd Length,AdrLo;Byte AdrHi,Attribut;Wd Res;};
 typedef struct GDT {struct SDES Dummy,GDTS,Start,But,Code,Stack;};
 typedef struct LI {Wd LoWord;Byte HiByte,Dummy;};
 //Structure de l'XMS
 typedef struct ExtMemMoveRec {long Length;Wd SourceHandle;long SourceOffset;Wd DestHandle;long DestOffset;};
 typedef struct XmsGetRec {long Size;Wd QHdl;long QOfs;Wd ZHdl;void far *ZOfs;};
 typedef struct XmsSetRec {long Size;Wd QHdl;void far *QOfs;Wd ZHdl;long ZOfs;};
 typedef struct EMBHandleRec {Byte LockCount,FreeHandles;Wd BlockLenKB;};
 typedef struct UMBSegRec { Wd Seg,UMBSizeKB;};
 //Structure de la CMOS (M굆oire sur Pile)
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
  Byte CPU;Bool Up32Bits;Byte Bus;//Info sur le Micro-Processeur et son bus syst둴e
  Wd ComputerName;Bool PS2;//Info sur le mod둳e d'Ordinateur
  Wd IntExistFlags;//Info sur les Interruptions
  Wd GetDosVer;DosBlockPtr GetDosBlock;Bool HandleExist;//Info sur le DOS
  Bool OS2;Byte OS2HiVer,OS2LoVer,Win,WinLoVer,WinHiVer;//Info sur OS/2 et Windows
  Wd CountryCode,CodePage,Date;Chr Curr[4];//Info de pays
  Chr ThSep[1],DeSep[1],DtSep[1],TmSep[1];Byte CurrStyle,Digits;enum TimeType Time;
  void far *CaseUp; Chr DaSep[1];
  Bool FloppyDskExist;Byte NmFloppyDsk;//Info sur le(s) lecteur(s) de disquette
  Bool HardDskExist;Byte NmHardDsk;Wd HardDskCtrl;//Info sur le(s) disque(s) dur
  Bool IsNovell;Byte Spooler;//Info r굎eau/spooler d'imprimante
  Bool JoyExist,BiosJoy;Wd JoyPort,JoyPotentioMeter;//Info sur la manette de jeu
  Byte KbdModel,KbdCtrl;Wd KbdReadPort;Bool BiosKbdEnh;//Info sur le clavier
  Bool LPTExist;Byte NmLPT,Get1LPT;//Info sur le port parall둳e
  Bool ComExist;Byte NmCom;//Info sur le port s굍ie
  Wd MemTotalSize;//Info sur la m굆oire conventionnel
  Bool EmmExist;Wd EmmSeg,EmmTotalSize;//Info sur l''Expanded Memory Manager (EMS)
  Bool XmmExist;void far *XmmCtrl;Wd XmsTotalSize;//Info sur l''eXtended Memory Manager (XMS)
  Bool ExtBiosExist;Wd ExtBiosSizeK;//Info sur la m굆oire 굏endu g굍� par le Bios Int 15h
  Byte CtrlCmos;Wd CmosPort;//Info sur le CMOS
  Byte Mouse;Wd MouseVer,MsButton;//Info sur la souris
  //Index de proc괺ure ou fonction � r괽굍ence resource RLL
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
 #define dvTxt     1 //Pilote sp괹ialis� pour les 괹rans de texte
 #define dv2       2 //Pilote sp괹ialis� pour les 괹rans graphiques en 2 couleurs: CGA, EGA, VGA,...
 #define dvGS640   3 //Pilote sp괹ialis� pour l'괹ran 640x200 en 16 couleurs de la Super CGA d'ATI
 #define dv16      4 //Pilote sp괹ialis� pour les 괹rans 16 couleurs des (S)EGA, (S)VGA
 #define dv19      5 //Pilote sp괹ialis� exlusivement pour le mode 320x200 en 256 couleurs (S)VGA
 #define dvSVGA    6 //Pilote sp괹ialis� pour les modes 256 couleurs des Super VGA
 #define dvSVGA386 7 //Identique au pilote pr괹괺ant mes r괹lames un CPU 386 ou +
 #define dvSetMode 8

 typedef struct PIV {
  Byte Card,Monitor; //Nom de la carte vid굊 (vn????),Nom du moniteur (mn????)
  Byte CardCat;//Cat괾orie de la carte vid굊(MDA,CGA,...)(cvn????)
  long Memory;//Nombre de m굆oire (en octet) dont dispose la carte vid굊
  Bool Font;//Police programme support� par cette carte?
  Bool Hercule;//Mode Hercule support� par cette carte?
  Wd Seg16C;//Segment par d괽aut en 16 couleurs
  Bool Palette;//Palette de couleur programme support�?
  Bool Color;//Carte de type couleur? autrement monochrome
  Bool BBlink; //Le Bios supporte le mode clignotement/intensit�?
  Bool EGA; //La carte est post굍ieur ou 괾ale � l'EGA
  Bool VGA; //La carte est post굍ieur ou 괾ale � la VGA
  Bool VGA320x400; //Le mode VGA 320x400 est support� (pas toujours le cas chez les clones)
  Bool VESA; //Le standard VESA support�?
  Wd ROM;//Adresse de la ROM Bios
  Bool MousePort;//Port souris inclue � la carte vid굊?
  Byte VideoBits;//Nombre d'acc둺 bits au entr괻/sortie vid굊
  Byte ROMBits;//Nombre d'acc둺 bits � la ROM Bios
  Byte DACBits;//Nombre de bits utilis� pour modifi� un des 3 DAC RGB
  Bool PVC;//Horloge vid굊 programme?
  Wd ProcSelBnkPg; //Adresse d'index de la proc괺ure de changement de page de la banque
  Wd ProcSetVideoMode;//Adresse d'index de la proc괺ure de changement de mode vid굊
 };

 typedef struct MIV {
  Wd Mode;//Mode vid굊 actuel (vm???)
  Bool IbmLogic,//Mode dans la logique IBM (pas hors cas texte � la SVGA...)
  BiosSupport,//Mode support� par le Bios (Par exemple, la GS en 16 couleurs le Bios ne le conna똳 pas)
   Colr,//Mode couleur? Sinon monochrome for뇗ment...
   Graf,//Mode graphique? Sinon texte
   Direct,//M굏hode directe? Sinon Bios ou Dos
   Blink,//Clignotement?
   Snow;//Neige lors de l'envoie de donn괻 dans le tampon vid굊?
  Wd SegV;//Segment vid굊 (A000h,B000h,B800h,...)
  Byte HeightChr;//Hauteur de la police de caract둹e actuel
  Wd NmXPixels,//Nombre de pixels horizontal qu'affiche l'괹ran
     NmYPixels;//Nombre de pixels vertical qu'affiche l'괹ran
  Byte NmXTxts,NmYTxts,//Nombre de caract둹e texte horizontal/vertical qu'affiche l'괹ran
   NmVidPgs;//Nombre de page vid굊 que supporte le mode actuel
  long NmColrs;//Nombre de couleurs affich�
  Byte BitsPerPixel;//Nombre de Bit(s) utilis� pour l'affichage d'un pixel
  Wd BytesPerLn;//Nombre d'octet par ligne affich� (tr둺 relatif en VGA...)
  Byte Pg;//Num굍o de la page vid굊 de travail
  Wd AddrPg;//En texte, adresse en m굆oire vid굊 de la page actuel
  Byte ShowPg;//Num굍o de la page vid굊 actuellement affich�
  Byte *TxtMtx;//Pointeur sur la police de caract둹e courante
  long ScrSize;//Taille de l'괹ran
  Wd SizeBnk;//Taille d'un page de la banque (0=64Ko)
  Wd SegBuf;//Segment du tampon d'acc굃굍ation
 };

#endif