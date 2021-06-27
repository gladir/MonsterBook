{Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette unit‚ contient toutes les structures reli‚s … Windows 3.1,
 95, 98, NT.


 Remarque
 ÍÍÍÍÍÍÍÍ

  þ Les d‚finitions concernant les entˆtes de fichiers EXE de format ®PE¯
    (Windows 32 bits) sont originaire de ®Haypo¯,  et ont ‚t‚ t‚l‚charger
    … partir  du  site  Internet  ®http://www.haypo.fr.st/¯.  Malgr‚  les
    nombreuses  modifications  apport‚es,  les  d‚finitions  sont  rest‚s
    relativement les mˆmes.


 Nom des programmeurs
 ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

  Sylvain Maltais
  Haypo
}

Unit WinTex;

INTERFACE

Const
  (* Constante de Windows 9X/NT *)

  { Attribut de mode d'ouverture fichier}
 wGenericRead=$80000000;      { Attribut de lecture }
 wGenericWrite=$40000000;     { Attribut d'‚criture }
 wGenericExecute=$20000000;   { Attribut d'ex‚cution }
 wGenericAll=$10000000;       { Tous les attributs }

  { Attribut d'ouverture de fichier}
 wCreateNew=1;                { Cr‚ation d'un nouveau fichier }
 wCreateAlways=2;             { Toujours cr‚er un nouveau fichier }
 wOpenExisting=3;             { Ouvrir s'il existe }
 wOpenAlways=4;               { Toujours ouvrir }
 wTruncateExisting=5;         { Tronque s'il est existant }

  { Attribut de mode de fichier }
 wFileShareRead=$00000001;
 wFileShareWrite=$00000002;
 wFileShareDelete=$00000004;
 wFileAttributeReadOnly=$00000001;
 wFileAttributeHidden=$00000002;
 wFileAttributeSystem=$00000004;
 wFileAttributeDirectory=$00000010;
 wFileAttributeArchive=$00000020;
 wFileAttributeNormal=$00000080;
 wFileAttributeTemporary=$00000100;
 wFileAttributeCompressed=$00000800;
 wFileAttributeOffline=$00001000;
 wFileNotifyChangeFileName=$00000001;
 wFileNotifyChangeDirName=$00000002;
 wFileNotifyChangeAttributes=$00000004;
 wFileNotifyChangeSize=$00000008;
 wFileNotifyChangeLastWrite=$00000010;
 wFileNotifyChangeLastAccess=$00000020;
 wFileNotifyChangeCreation=$00000040;
 wFileNotifyChangeSecurity=$00000100;
 wFileActionAdded=$00000001;
 wFileActionRemoved=$00000002;
 wFileActionModified=$00000003;
 wFileActionRenamedOldName=$00000004;
 wFileActionRenamedNewName=$00000005;

  (* Structure d'un fichier Windows *)

  { Signature des fichiers Windows Ex‚cutable }
 SignatureNE=$454E;     { (16 bits invers‚) 'NE' }
 SignaturePE=$00004550; { (32 bits invers‚) 'PE'+#0#0 }
 SignatureLE=$0000454C; { (32 bits invers‚) 'LE'+#0#0 }

  {Type de ressource Windows}
 rtCursor=1;       { Curseur }
 rtBitmap=2;       { Image bitmap }
 rtIcon=3;         { Ic“ne }
 rtMenu=4;         { Menu }
 rtDialog=5;       { BoŒte de dialogue }
 rtString=6;       { ChaŒne de caractŠres (texte) }
 rtFontDir=7;      { R‚pertoire de police de caractŠres }
 rtFont=8;         { Police de caractŠres }
 rtAccelerator=9;  { Acc‚l‚rateur clavier }
 rtRCData=10;      { Donn‚es non-format‚e }
 rtTableMsg=11;    { Table des messages }
 rtGroupCursor=12; { Groupe de curseur }
 rtGroupIcon=14;   { Groupe d'ic“ne }
 rtVersion=16;     { Informations de version }
 rtTaskBar=241;    { Barre de tƒche }

Type
 HeaderExe4Res=Record
  Signature:Word;
  LastCount:Word;
  PageCount:Word;
  ReloCount:Word;
  eHdrSize:Word;
  eMinAbove:Word;
  eMaxAbove:Word;
  eInitSS:Word;
  eInitSP:Word;
  eCheckSum:Word;
  eInitPC:Word;
  eInitCS:Word;
  eRelocOfs:Word;
  eOvlyNum:Word;
  eRelocTab:Word;
  eSpace:Array[1..30]of Byte;
  eNewHeader:Word;
 End;

 HeaderExeWindows=Record
  Signature:Word;
  LinkerVer:Word;
  EntryOffs:Word;
  EntrySize:Word;
  ReservedA:Array[0..3]of Byte;
  LinkerFlags:Word;
  nDataSeg:Word;
  LocalHeapSize:Word;
  StackSize:Word;
  CSIP:Pointer;
  SSSP:Pointer;
  nSegEntries:Word;
  nModRefEntries:Word;
  nNonResNameBytes:Word;
  SegTbl:Word;
  ResourceTbl:Word;
  ResNameTbl:Word;
  ModRefTbl:Word;
  ImpNameTbl:Word;
  NonResNameTbl:LongInt;
  nMovableEntryPoints:Word;
  ShiftCount:Word;
  nResourceSegs:Word;
  OS:Byte;
  Extra:Byte;
  ReservedB:Array[0..7]of Byte;
 End;

  (************************)
  (* Format de fichier NE *)
  (************************)

 NETypeHeader=Record
  {00h … 01h}ID:Array[0..1]of Char;          { Signature = 'NE' }
  {02h … 02h}LinkerMajorVersion:Byte;        { Version des liens  }
  {03h … 03h}LinkerMinorVersion:Byte;        { Version des liens  }
  {04h … 05h}OffsetOfEntryTable:Word;
  {06h … 07h}LengthOfEntryTableInBytes:Word;
  {08h … 0Bh}FileLoadCRC:LongInt;            { Vaut 0 dans TPW de Borland }
  {0Ch … 0Ch}ProgramFlagsBitmapped:Byte;
   { 0-1 - Type DGroup:
            0 - Aucun
            1 - Simple partage
            2 - multiple
            3 - Nulle
     2 - Initialisation globale
     3 - Mode protect‚e seulement
     4 - instructions code machine de famille 8086
     5 - instructions code machine de famille 80286
     6 - instructions code machine de famille 80386
     7 - instructions code machine de famille 80x87 }
  {0Dh … 0Dh}ApplicationFlagsBitmapped:Byte;
   { 0-2 - Type d'application
            1 - Plein ‚cran
            2 - Compatible avec Windows/P.M. API
            3 - Utilise Windows/P.M. API
     3 - Application de la famille OS/2
     4 - Reserv‚
     5 - Erreurs dans l'image/executable
     6 - Cependant "non-conforming program"
     7 - DLL ou pilote (SS:SP info invalide, CS:IP pointes sur une
         routine d'initialisation FAR appell‚ avec:
          AX=Handle module lequel retourne
              AX=0000h dans le cas d'un ‚chec
              AX<>0000h succŠs d'initialisation)}
  {0Eh … 0Eh}AutoDataSegmentIndex:Byte;
  {0Fh … 0Fh}ReservedA:Byte;                 { Signification inconnue????}
  {10h … 11h}InitialLocalHeapSize:Word;
  {12h … 13h}InitialStackSize:Word;
  {14h … 15h}EntryPointCS:Word;              { Point d'entr‚e CS (CS est l'index dans la table segment) }
  {16h … 17h}EntryPointIP:Word;              { Point d'entr‚e IP }
  {18h … 19h}InitialStackPointerSS:Word;     { Pointeur de pilote initial SS (SS est l'index dans la table segment) }
  {1Ah … 1Bh}InitialStackPointerSP:Word;     { Pointeur de pilote initial SP }
  {1Ch … 1Dh}SegmentCount:Word;              { Compteur de segment }
  {1Eh … 1Fh}ModuleReferenceCount:Word;
  {20h … 21h}SizeOfNonresidentNamesTableInBytes:Word;
  {22h … 23h}OffsetOfSegmentTable:Word;
  {24h … 25h}OffsetOfResourceTable:Word;
  {26h … 27h}OffsetOfResidentNamesTable:Word;
  {28h … 29h}OffsetOfModuleReferenceTable:Word;
  {2Ah … 2Bh}OffsetOfImportedNamesTable:Word;{ ChaŒne se terminant par un 0 }
  {2Ch … 2Fh}OffsetFromStartOfFileToNonResidentNamesTable:LongInt;
  {30h … 31h}CountOfMoveableEntryPointListedInEntryTable:Word;
   { 0 est ‚quivalent … 9 (la valeur par d‚faut sont des pages 512-octet) }
  {32h … 33h}FileAlignmentSizeShiftCount:Word;
  {34h … 35h}NumberOfResourceTableEntries:Word;
  {36h … 36h}TargetOperatingSystem:Byte;     { Type de systŠme d'exploitation }
   {  0 - Inconnue
      1 - OS/2
      2 - Windows
      3 - MS-DOS 4.x europ‚en
      4 - Windows 386
      5 - BOSS (Borland Operating System Services) }
  {37h … 37h}OtherEXEFlags:Set Of (neLongFileNameSupport, { Nom long support‚? }
                                   ne2xProtectedMode,     { Mode prot‚g‚e 2.x? }
                                   ne2xProportionalFonts, { Police de caractŠres proportionnel 2.x? }
                                   neExecutableHasGangloadArea);
  {38h … 39h}OffsetToReturnThunksOrStartOfGangloadArea:Word;
  {3Ah … 3Bh}OffsetToSegmentReferenceThunksOrLengthOfGangloadArea:Word;
  {3Ch … 3Dh}MinimumCodeSwapAreaSize:Word;
  {3Eh … 3Fh}WinVersion:Word;                { Version Windows (sous-version en premier) }
 End;

  (************************)
  (* Format de fichier PE *)
  (************************)

  { Entˆte EXE DOS pour format PE }
 PETypeHeaderExeDos=Record
  Signature:Word;                   { Signature = 'MZ'                    }
  OctetDerPage:Word;                { Nombre d'octets dans la deniŠre page}
  NbrPage:Word;                     { Nombre de page dans le fichier (une }
                                    { page = 512 octets)                  }
  NbrReallocation:Word;             { Nombre de r‚allocation              }
  TailleEntete:Word;                { Taille de l'en-tˆte en paragraphe   }
                                    { (un paragraphe = 16 octets)         }
  MemMinRecquis:Word;               { M‚moire (en paragraphe) minimum     }
                                    { recquise)                           }
  MemMaxRecquis:Word;               { M‚moire (en paragraphe) maximum     }
                                    { recquise)                           }
  ValSSinit:Word;                   { Valeur relative de SS (Segement     }
                                    { Stack) initiale                     }
  ValSPinit:Word;                   { Valeur de SP (Stack Offset) initiale}
  CheckSum:Word;                    { CheckSum (CRC)                      }
  ValIPinit:Word;                   { Valeur de IP (Instruction Offset)   }
                                    { initiale                            }
  ValCSinit:Word;                   { Valeur relative de CS (Code         }
                                    { Segment) initiale                   }
  OfstReallocation:Word;            { Offset dans le fichier des tables   }
                                    { de r‚allocation                     }
  OverlayNumber:Word;               { Nombre d'overlays                   }
  Reserve4m:Array[1..4] of Word;    { - 4 mots r‚serv‚s -                 }
  OemID:Word;                       { OEM identifieur (pour OemInfo)      }
  OemInfo:Word;                     { OEM informations                    }
  Reserve10m:Array[1..10] of Word;  { - 10 mots r‚serv‚s -                }
  OfstEntetePE:LongInt;             { Offset de l'entˆte PE               }
 End;

 { Entˆte d'un fichier PE }
 PETypeHeaderPE=Record
  Signature:LongInt;                { Signature = 'PE'+#0#0               }
  CPU:Word;                         { Processeur recquis pour l'ex‚cution }
                                    { du programme (voir fonction         }
                                    { 'PE_CpuRecquis')                    }
  NbrSection:Word;                  { Nombre de sections                  }
  DateCreation:LongInt;             { Date de cr‚ation du fichier         }
                                    { (au format (time_t)                 }
  PointerToSymbolTable:LongInt;     { ??? (utilis‚ pour d‚bogueur, =0)    }
  NumberOfSymbols:LongInt;          { ??? (utilis‚ pour d‚bogueur, =0)    }
  TailleEnteteOptionnel:Word;       { Taille de l'en-tˆte optionnel       }
  Option:Word;                      { Caract‚ristiques                    }
 End;

 { Un r‚pertoire }
 PETypeDir=Record
  Rva:LongInt;      { RVA du r‚pertoire }
  Taille:LongInt;   { Taille (en octets) de la section }
 End;

 { En-tˆte optionnel d'un fichier PE }
 PETypeHeaderOptionnelPE=Record
  Signature:Word;             { Signature: 010Bh }
  VerMajLink:Byte;            { Version majeur du linker }
  VerMinLink:Byte;            { Version mineur du linker }
  TailleCode:LongInt;         { Taille (en octets) du code }
  TailleDonnee:LongInt;       { Taille (en octets) des donn‚es }
                              { (donn‚e initialis‚es) }
  TailleVar:LongInt;          { Taille (en octets) des variables }
                              { (donn‚e non-initialis‚es) }
  RvaPointEntreeCode:LongInt; { Point d'entr‚e (RVA) du code }
  RvaCode:LongInt;            { Offset (RVA) du code }
  RvaDonnee:LongInt;          { Offset (RVA) des donn‚es }
  RvaImageBase:LongInt;       { Offset (RVA) de l'image de base }
  AlignementRam:LongInt;      { Alignement dans la m‚moire (est ‚gal}
                              { en g‚n‚ral … 4096 ou 32) }
  AlignementFichier:LongInt;  { Alignement dans le fichier (est ‚gal}
                              { en g‚n‚ral … 512 ou 32) }
  VerMajOS:Word;              { Version majeur du systŠme d'exploi- }
                              { tation recquise }
  VerMinOS:Word;              { Version mineur du systŠme d'exploi- }
                              { tation recquise }
  VerMaj:Word;                { Version majeur du programme }
  VerMin:Word;                { Version mineur du programme }
  VerMajSousOS:Word;          { Version majeur du sous-systŠme recquis }
  VerMinSousOS:Word;          { Version mineur du sous-systŠme recquis }
  ValeurVerWin32:LongInt;     { Valeur de la version Win32 ? (=0) }
  TailleImage:LongInt;        { Taille de l'image (m‚moire recquise)}
  TailleDesEntete:LongInt;    { Taille de tous les en-tˆtes }
  CheckSum:LongInt;           { Somme de v‚rification (CRC) calcul‚ }
                              { avec une proc‚dure propre … Microsoft }
  SousSystemeRecquis:Word;    { Sous-systŠme recquis (Voir la }
                              { fonction 'PENomSousSystem') }
  OptionDLL:Word;             { Caract‚ristiques de la DLL (si s'en }
                              { est une ...) }
  TaillePileReserve:LongInt;  { Taille de la pile de r‚serve }
  TaillePileCommune:LongInt;  { Taille de la pile commune }
  TailleMemReserve:LongInt;   { Taille de la m‚moire de r‚serve }
  TailleMemCommune:LongInt;   { Taille de la m‚moire commune }
  OptionLoader:LongInt;       { Caract‚ristiques du "LOADER" (peu ou non utilis‚) }
  NbrRepertoire:LongInt;      { Nombre de r‚pertoires (valeur constante = 16) }
  Repertoire:Array[1..16]of PETypeDir; { 16 r‚pertoires }
 End;

 { Une section d'un fichier PE }
 PETypeHeaderSection=Record
  Nom:Array[1..8]of Char;          { Court nom de la section             }
  TailleVirtuelle:LongInt;         { Union 32 bits de l'adresse physique }
                                   { et de la taille virtuelle           }
  AdresseVirtuel:LongInt;          { Adresse (RVA) virtuelle             }
  TailleDonnee:LongInt;            { Taille des donn‚es RAW              }
  PosDonnee:LongInt;               { Pointeur dans le fichier vers les   }
                                   { donn‚es RAW (si =0, alors les       }
                                   { donn‚es ne seront accessible que    }
                                   { lors de l'ex‚cution)                }
  PtrRelocation:LongInt;           { Pointeur vers les relocations       }
  PtrNumeroLigne:LongInt;          { Pointeur vers les num‚ros de ligne  }
  NbrRelocation:Word;              { Nombre de relocation                }
  NbrNumeroLigne:Word;             { Nombre de num‚ro de ligne           }
  Option:LongInt;                  { Caract‚ristiques                    }
 End;

 { Entˆte d'un niveau de ressource }
 PETypeHeaderRessource=Record
  Option:LongInt;          { Caract‚ristiques (inutilis‚es = 0)  }
  DateCreation:LongInt;    { Date de cr‚ation (format 'time_t')  }
  VerMaj,VerMin:Word;      { Version majeur, mineur              }
  NbrEntreeNommee:Word;    { Nombre d'entr‚es nomm‚es            }
  NbrEntreeIndexee:Word;   { Nombre d'entr‚es index‚es           }
 End;

 { Entr‚e d'une ressource: r‚pertoire ou entr‚e de ressource }
 PETypeDirRes=Record
  Nom:LongInt;   { Nom  }
  Ofst:LongInt;  { Offset vers le prochain r‚pertoire }
 End;

 { Une ressource }
 PETypeHeaderUneRes=Record
  Ofst:LongInt;      { Offset des donn‚es depuis le d‚but des ressources }
  Taille:LongInt;    { Taille (en octet) }
  CodePage:LongInt;  { (utilis‚ pour les ressources dans de diff‚rents langages) }
  Inutilise:LongInt; { - inutilis‚ (=0) - }
 End;

  {Structure du systŠme d'exploitation Windows 9X/NT }
 PSecurityAttributes=^TSecurityAttributes;
 TSecurityAttributes=Record
  nLength:LongInt;
  lpSecurityDescriptor:Pointer;
  bInheritHandle:Boolean;
 End;

IMPLEMENTATION

END.