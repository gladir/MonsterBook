{ 컴  컴  컴  컴  컴  컴  컴  컴  컴  컴  컴  컴  컴  컴  컴  컴  컴  컴

 �                Compilateur Pascal Niveau B57/Cortex                  �
                     Malte Genesis IV: Alias Chantal
 �                                                                      �
            Tous droits r굎erv굎 par les Chevaliers de Malte
 �                                                                      �

 �                            1998 � 2000                               �

  컴  컴  컴  컴  컴  컴  컴  컴  컴  컴  컴  컴  컴  컴  컴  컴  컴  컴


 Nom du programmeur
 袴袴袴袴袴袴袴袴袴

  Sylvain Maltais


 Description
 袴袴袴袴袴�

  Cette unit� renferme toutes les d괽initions et constantes n괹essaires au
 compilateur de langage Pascal niveau B57.

  Ainsi  on   retrouve   entre   autre   les  structures  de  stockage  de
 l'information des unit굎  dans les fichiers  et ceux utilis� au niveau de
 la m굆oire, structure utilis괻 pour le transfert...

  On retrouve 괾alement les mots r굎erv굎 utilis� par le langage Pascal de
 niveau B57.  Les  cha똭es  de  caract둹es  associ굎  ainsi  que  l'action
 appropri괻 en fonction du mot trouv�.
}

Unit PCCortex;

{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�}
                                 INTERFACE
{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�}

Uses Systex{$IFDEF IDE},Isatex{$ENDIF};

Const
  {Constantes des mots r굎erv굎 du langage Pascal B57 }
 cmwpAsm=0;               { Mot r굎erv� de langage Pascal 췆SM� }
 cmwpBegin=1;             { Mot r굎erv� de langage Pascal 췇EGIN� ou 췉륛UT� }
 cmwpCSConst=2;           { Mot r굎erv� de langage Pascal B57 췈SConst� }
 cmwpConst=3;             { Mot r굎erv� de langage Pascal 췈ONST� ou 췈ONSTANTE� }
 cmwpExports=4;           { Mot r굎erv� de langage Pascal 췊XPORTS� }
 cmwpFinalization=5;      { Mot r굎erv� de langage Delphi 췋INALIZATION� ou 췋INALISATION� }
 cmwpFunction=6;          { Mot r굎erv� de langage Pascal 췋UNCTION� ou 췋ONCTION� }
 cmwpImplementation=7;    { Mot r굎erv� de langage Pascal 췏MPLEMENTATION� }
 cmwpInclude=8;           { Mot r굎erv� de langage Pascal B57 췏NCLUDE� }
 cmwpInitialization=9;    { Mot r굎erv� de langage Delphi 췏NITIALIZATION� }
 cmwpInterface=10;        { Mot r굎erv� de langage Pascal 췏NTERFACE� }
 cmwpLibrary=11;          { Mot r굎erv� de langage Pascal 췓IBRARY� ou 췇IBLIOTHEQUE� }
 cmwpMacro=12;            { Mot r굎erv� de langage Pascal B57 췔ACRO� }
 cmwpProcedure=13;        { Mot r굎erv� de langage Pascal 췗ROCEDURE� ou 췗ROC륞URE� }
 cmwpProgram=14;          { Mot r굎erv� de langage Pascal 췗ROGRAM� ou 췗ROGRAMME� }
 cmwpType=15;             { Mot r굎erv� de langage Pascal 췛YPE� ou 췛YPEDEF� }
 cmwpUnit=16;             { Mot r굎erv� de langage Pascal 췜NIT� ou 췜NIT맦 }
 cmwpUses=17;             { Mot r굎erv� de langage Pascal 췜SES� ou 췜TILIS륲� }
 cmwpVar=18;              { Mot r굎erv� de langage Pascal 췝AR� ou 췝ARIABLE� }
 cmwpEnd=19;              { Mot r굎erv� de langage Pascal 췊ND� ou 췋IN� }
 cmwpIf=20;               { Mot r굎erv� de langage Pascal 췏F� ou 췚I� }
 cmwpElse=21;             { Mot r굎erv� de langage Pascal 췊LSE�, 췚INON� ou 췆UTREMENT� }
 cmwpThen=22;             { Mot r굎erv� de langage Pascal 췛HEN� ou 췆LORS� }
 cmwpFor=23;              { Mot r굎erv� de langage Pascal 췋OR� ou 췗OUR� }
 cmwpGoto=24;             { Mot r굎erv� de langage Pascal 췍OTO� ou 췆LLERA� }
 cmwpWhile=25;            { Mot r굎erv� de langage Pascal 췞HILE� ou 췛ANTQUE� }
 cmwpRepeat=26;           { Mot r굎erv� de langage Pascal 췙EPEAT� ou 췙EPETER� }
 cmwpAbsolute=27;         { Mot r굎erv� de langage Pascal 췆BSOLUTE� ou 췆BSOLUE� }
 cmwpAnd=28;              { Mot r굎erv� de langage Pascal 췆ND� ou 췊T� }
 cmwpArray=29;            { Mot r굎erv� de langage Pascal 췆RRAY� ou 췙ANG륟� }
 cmwpAssembler=30;        { Mot r굎erv� de langage Pascal 췆SSEMBLER� ou 췆SSEMBLEUR� }
 cmwpCase=31;             { Mot r굎erv� de langage Pascal 췈ASE� ou 췈AS� }
 cmwpConstructor=32;      { Mot r굎erv� de langage Pascal 췈ONSTRUCTOR� ou 췈ONSTRUCTEUR� }
 cmwpDestructor=33;       { Mot r굎erv� de langage Pascal 췉ESTRUCTOR� ou 췉ESTRUCTEUR� }
 cmwpDo=34;               { Mot r굎erv� de langage Pascal 췉O� ou 췋AIRE� }
 cmwpFar=35;              { Mot r굎erv� de langage Pascal 췋AR� ou 췓OIN� }
 cmwpFile=36;             { Mot r굎erv� de langage Pascal 췋ILE� ou 췋ICHIER� }
 cmwpIn=37;               { Mot r굎erv� de langage Pascal 췏N� ou 췉ANS� }
 cmwpInherited=38;        { Mot r굎erv� de langage Pascal 췏NHERITED� ou 췎륱ITIER� }
 cmwpInline=39;           { Mot r굎erv� de langage Pascal 췏NLINE� ou 췊NLIGNE� }
 cmwpLabel=40;            { Mot r굎erv� de langage Pascal 췓ABEL� ou 츖TIQUETTE� }
 cmwpNear=41;             { Mot r굎erv� de langage Pascal 췕EAR� ou 췈OURT� }
 cmwpObject=42;           { Mot r굎erv� de langage Pascal 췖BJECT� ou 췖BJET� }
 cmwpOf=43;               { Mot r굎erv� de langage Pascal 췖F� ou 췉E� }
 cmwpPacked=44;           { Mot r굎erv� de langage Pascal 췗ACKED� ou 췗AQUET� }
 cmwpRecord=45;           { Mot r굎erv� de langage Pascal 췙ECORD� ou 췊NREGISTREMENT� }
 cmwpSet=46;              { Mot r굎erv� de langage Pascal 췚ET� ou 췊NSEMBLE� }
 cmwpTo=47;               { Mot r굎erv� de langage Pascal 췛O� ou 췑USQUA� }
 cmwpVirtual=48;          { Mot r굎erv� de langage Pascal 췝IRTUAL� ou 췝IRTUEL� }
 cmwpWith=49;             { Mot r굎erv� de langage Pascal 췞ITH� ou 췆VEC� }
 cmwpDiv=50;              { Mot r굎erv� de langage Pascal 췉IV� }
 cmwpMod=51;              { Mot r굎erv� de langage Pascal 췔OD� }
 cmwpNot=52;              { Mot r굎erv� de langage Pascal 췕OT� ou 췗AS� }
 cmwpOr=53;               { Mot r굎erv� de langage Pascal 췖R� ou 췖U� }
 cmwpShl=54;              { Mot r굎erv� de langage Pascal 췚HL�, 췉ECALG� ou 췉EG� }
 cmwpShr=55;              { Mot r굎erv� de langage Pascal 췚HR�, 췉ECALD� ou 췉ED� }
 cmwpXor=56;              { Mot r굎erv� de langage Pascal 췟OR� ou 췖UX� }
 cmwpInterrupt=57;        { Mot r굎erv� de langage Pascal 췏NTERRUPT� }
 cmwpElseIf=58;           { Mot r굎erv� de langage Pascal B57 췊LSEIF�, 췊LIF� ou 췊LSIF� }
 cmwpDuplicate=59;        { Mot r굎erv� de langage Pascal B57 췉UPLICATE� ou 췉UPLICATION� }
 cmwpRegister=60;         { Mot r굎erv� de langage Pascal B57 췙EGISTER� ou 췙EGISTRE� }
 cmwpMax=60;              { Dernier mot r굎erv� de la liste du langage Pascal B57 }
 cmwpError=$FF;

Type
 ProgramFormatType=(
  fCOM,               { Fichier de format �.COM� }
  fEXE,               { Fichier de format �.EXE� }
  fMEX,               { Fichier de format �.MEX� }
  fBOOT,              { Secteur de d굆arrage }
  fUnitTiny,          { Unit� compacte }
  fUnitLarge,         { Unit� 굏endue }
  fLibrary            { Biblioth둸ue }
 );

 ProgramTargetType=(
  ftDOS,
  ftDOSX,
  ftOS2,
  ftWin31,
  ftWin32s,
  ftWindows95,
  ftWindows98,
  ftWindowsNT,
  ftWindows2000,
  ftLinux
 );

Const
 ExtFormat:Array[ProgramFormatType]of String[4]=(
  '.COM','.EXE','.MEX','.BIN','.UPC','.UPL','.RLL'
 );
 StackSize:Word=16384;      { Taille de la pile par d괽aut }
 MinParag:Word=0;           { Nombre minimum de paragraphe en mode r괻l }
 MaxParag:Word=65535;       { Nombre maximal de paragraphe en mode r괻l }
 CurrPointer:Byte=cmwpNear; { Portabilit� des proc괺ures et fonctions }
 InstrFormat:(              { Format de code machine par d괽aut }
  p88,                      { INTEL 8088/8086/NEC V20/V30 }
  p186,                     { INTEL 80188/80186 }
  p286,                     { INTEL 80286/AMD 286}
  p386,                     { 80386/AMD 386 }
  p486,                     { 80486/Cyrix 5x86 }
  p586,                     { 80586/Pentium/Cyrix 6x86 }
  p686)                     { 80686/Pentium Pro }
 =p88;                      { Format par d괽aut 8088 }
 ProgramFormat:ProgramFormatType=fCOM; { Format d'ex괹utable par d괽aut: .COM }
 ProgramTarget:ProgramTargetType=ftDOS;
 Body:(
  bPRELUDE,                 { Quelque part au d괷ut du fichier sans en autre s뻭...}
  bINTERFACE,               { Zone interface d'une unit� }
  bIMPLEMENTATION,          { Zone d'impl굆entation d'une unit� }
  bINITIALIZATION,          { Bloc d'initialisation }
  bFINALISATION,            { Bloc de terminaison }
  bMAIN                     { Bloc principal }
 )=bPRELUDE;
 CSyntax:Bool=Ya;           { Autorise les syntaxes C style #define...}
 BuildAll:Bool=No;          { Reconstruit toutes les unit굎 utilis굎 ? }
 MakeModifiedUnit:Bool=Ya;  { Reconstruit les unit굎 modifi� ? }
 asmUp386:String[1]=#$66;
 asmCallFarAbs:String[1]=#$9A;                         { CALL ????h:????h }
 asmCallNear:String[1]=#$E8;                           { CALL ????h       }
 asmFABS:String[2]=#$D9#$E1;                           { FABS             }
 asmFINIT:String[2]=#$DB#$E3;                          { FINIT            }
 asmFLD1:String[2]=#$D9#$E8;                           { FLD1             }
 asmFLDL2E:String[2]=#$D9#$EA;                         { FLDL2E           }
 asmFLDL2T:String[2]=#$D9#$E9;                         { FLDL2T           }
 asmFLDLG2:String[2]=#$D9#$EC;                         { FLDLG2           }
 asmFLDLN2:String[2]=#$D9#$ED;                         { FLDLN2           }
 asmFLDPI:String[2]=#$D9#$EB;                          { FLDPI            }
 asmFLDZ:String[2]=#$D9#$EE;                           { FLDZ             }
 asmFNOP:String[2]=#$D9#$D0;                           { FNOP             }
 asmFPATAN:String[2]=#$D9#$F3;                         { FPATAN           }
 asmFPREM:String[2]=#$D9#$F8;                          { FPREM            }
 asmFPTAN:String[2]=#$D9#$F2;                          { FPTAN            }
 asmFRNDINT:String[2]=#$D9#$FC;                        { FRNDINT          }
 asmFSCALE:String[2]=#$D9#$FD;                         { FSCALE           }
 asmFSETPM:String[2]=#$D9#$E4;                         { FSETPM           }
 asmFSIN:String[2]=#$D9#$FE;                           { FSIN             }
 asmFSINCOS:String[2]=#$D9#$FB;                        { FSINCOS          }
 asmFSQRT:String[2]=#$D9#$FA;                          { FSQRT            }
 asmFTST:String[2]=#$D9#$E4;                           { FTST             }
 asmFXAM:String[2]=#$D9#$E5;                           { FXAM             }
 asmFXTRACT:String[2]=#$D9#$F4;                        { FXTRACT          }
 asmFYL2X:String[2]=#$D9#$F1;                          { FYL2X            }
 asmINT:String[1]=Chr(ciINT);                          { INT              }
 asmINT20:String[2]=Chr(ciINT)+#$20;                   { INT 20h          }
 asmMovAdrBX_AX:String[2]=#$89#$07;                    { MOV [BX],AX      }
 asmMovAX_:String[1]=#$A1;                             { MOV AX,[????]    }
 asmMovAX_ES:String[2]=#$8C#$C0;                       { MOV AX,ES        }
 asmMovES_AX:String[2]=#$8E#$C0;                       { MOV ES,AX        }
 asmMovSS_AX:String[2]=#$8E#$D0;                       { MOV SS,AX        }
 asmMov_AX:String[1]=#$A3;                             { MOV [????],AX    }
 asmNOP386:String[2]=#$66+Chr(ciNOP);                  { NOP386           }
 asmPOPAD:String[2]=#$66#$61;                          { POPAD            }
 asmPUSHAD:String[2]=#$66#$60;                         { PUSHAD           }
 asmREP:String[1]=Chr(ciREP);                          { REP              }
 asmREPNZ:String[1]=#$F2;                              { REPNZ            }
 asmXORAX_AX:String[2]=#$33#$C0;                       { XOR AX,AX        }

 SikReg:Array[0..7]of Byte=($06,$0E,$16,$1E,$26,$2E,$36,$3E);

 p8088Plus=0;
 p8088=$80+p8088Plus;
 p8086Plus=0;
 p8086=$80+p8086Plus;
 p80186Plus=1;
 p80186=$80+p80186Plus;
 p80188Plus=1;
 p80188=$80+p80188Plus;
 p80286Plus=2;
 p80286=$80+p80286Plus;
 p80386Plus=3;
 p80386=$80+p80386Plus;
 p80486Plus=4;
 p80486=$80+p80486Plus;
 p80586Plus=5;
 p80586=$80+p80586Plus;
 p80686Plus=6;
 p80686=$80+p80686Plus;
 p8087Plus=7;
 p8087=$80+p8087Plus;
 p80287Plus=8;
 p80287=$80+p80287Plus;
 p80387Plus=9;
 p80387=$80+p80387Plus;
 pMMX=10;

 SignUnit='Unit� Pascal Niveau B57 Version A'#13#10'Tous droits r굎erv굎 par les Chevaliers de Malte'#26;

 DefTypeSize:Array[0..13]of Word=(
  0,1,1,1,1,2,2,4,4,4,0,0,256,256
 );

 GhostConst:Long=0; { Constante fant뱈e }
 GhostCode:Long=0;  { Code fant뱈e }

Type
 DefType=(    { Type de d괽inition }
  tEnum,      { 릒um굍ation }
  tBool,      { Bool괶n (True/False) (Vrai/Faux) }
  tByte,      { Byte/Octet }
  tShort,     { Short (-128 � 127) }
  tChar,      { Char (caract둹e)}
  tInt,       { Integer/entier (-32768 � 32767) }
  tWord,      { Word/Mot (0 � 65535) }
  tLong,      { LongInt }
  tProc,      { Procedure/Proc괺ure }
  tFunc,      { Function/Fonction }
  tPtr,       { Pointer }
  tArray,     { Array/Rang괻 }
  tRec,       { RECORD }
  tString,    { STRING }
  tCString,   { 췈STRING� comme QuickPascal }
  tPtrString, { Pointeur de STRING }
  tIntervalle,{ Intervalle ?..? }
  tCase,      { Case Record ... of }
  tExternRec, { Enregistrement externe }
  tEnd,       { END/FIN }
  tExtern,    { Type externe dans le module courant (unit� ou programme)}
  tExternUnit,{ Type externe dans un autre unit� }
  tNoType);   { Sans type }

  {Destination � utiliser comme Segment }
 SegDesType=(
  vCS,            { Segment de code utilis� comme destination }
  vDS,            { Segment de donn괻 utilis� comme destination }
  vES,            { Segment extra utilis� comme destination }
  vFS,            { Segment FS 386 utilis� comme destination }
  vGS,            { Segment GS 386 utilis� comme destination }
  vSS,            { Segment de pile utilis� comme destination }
  vAbsolute,      { Adressage absolue comme destination }
  vSSParam,       { Segment de pile en param둻re comme destination }
  vRegParam);     { Registre comme destination }

 QParamType=(
  qNone,          { Aucun typage de param둻re }
  qVar,           { Param둻re par pointeur/modification autoris� }
  qConst          { Param둻re par pointeur/modification interdite }
 );

 UnitHeaderRec=Record
  Sign:Array[0..Length(SignUnit)]of Char;
  ProgramFormat:ProgramFormatType;
  DebugInfo:Bool;   { Pr굎ence d'information de d괷oguage }
  ResWordFound:Bool;{ Mot r굎erv� pr굎ent?}
  NmResWord,        { Nombre de mots r굎erv굎 }
  SizeResWord:Word; { Taille de la table des mots r굎erv굎 }
  NmConst,          { Nombre de constante(s) }
  NmType,           { Nombre de type(s) et structure(s) }
  NmVar,            { Nombre de variable(s) }
  NmProc:Word;      { Nombre de proc괺ure(s) et fonction(s) }
  IP:Long;          { Taille totalement en octets du code machine }
                    { contenu dans l'unit� }
  OffConst,         { Position absolue des constante(s) dans le fichier }
  OffType,          { Position absolue des type(s) dans le fichier }
  OffVar,           { Position absolue des variable(s) dans le fichier }
  OffProc:Long;     { Position absolue des proc괺ure(s) et fonction(s) }
  OffPrivate:Long;  { Position absolue des donn괻s priv괻s }
  Date:Long;        { Date du source de l'unit� }
  Name:String;      { Nom de l'unit� }
 End;

 UnitCstRec=Record
  Gauche,Droite:Long;   { Position du pr괹괺ent et du suivant }
  TypeDef:DefType;      { Style de d괽inition }
  Name:String[255];     { Nom de la constante }
 End;

 UnitVarRec=Record
  Suivant:Long;         { Position du suivant }
  TypeDef:DefType;      { Style de d괽inition }
  SegDes:SegDesType;    { Segment de destination }
  QParam:QParamType;    { Style de param둻re: Const, Var,... }
  Volatile:Bool;        { Variable pouvant 늯re s굋ar괻 de ses conseurs }
  Size:Word;            { Taille }
  Name:String[255];     { Nom de la variable }
 End;

 UnitTypeRec=Record
  Gauche,Droite:Long;
  Name:String;
 End;

 UnitProcRec=Record
  Gauche,Droite:Long;   { 0 � 7:   Position du pr괺괺ent et du suivant }
  NmParam:Word;         { 8 � 9:   Nombre de param둻res }
  CurrPtr:Byte;         { 10:      De type Near, Far }
  Func,Dupl:Bool;       { 11 � 12: Fonction?, Duplication d'une autre proc괺ure }
  OffBody:Long;         { 13 � 16: Position du code de la routine dans le fichier }
  Name:String[255];     { 17 � ...:Nom de la proc괺ure }
 End;

 PString=^String;

 XVariant=Record Case Byte of
  0:(DataLong:LongInt);
  1:(DataBool:Boolean);
  2:(DataByte:Byte);
  3:(DataChar:Char);
  4:(DataShort:ShortInt);
  5:(DataWord:Word);
  6:(DataInt:Integer);
  7:(Buf:Pointer); { Contenu con놽rnant cette constante }
  8:(ArrayByte:PTByte);
  9:(PString:PString);
  10:(DirectByte:Array[0..3]of Byte);
 End;

 Variant=Record
  TypeDef:DefType;
  X:XVariant;
 End;

  {Enregistrement de constante }
 CstRec=Record
  Name:String[131];  { Nom de la constante }
  Free:Bool;         { Constante lib굍er? }
  Q:Variant;         { Valeur de la constante }
 End;

 TypeRec=Record{Enregistrement d'un type}
  TypeDef:DefType;      { Mod둳e de type }
  ArrayTypeDef:DefType; { Tableau de type }
  PointTo:Bool;         { Pointeur sur l'argument (^?) }
  Pile:RBuf;            { Si 굈um굍ation, enregistrement, cas... }
  Min:Integer;          { Si tableau: minimum (Array[Min..Max]..)}
  Max:Word;             { Si tableau: maximum, Si Cha똭e: String[Max] }
  Name:String;          { Nom de l'item }
 End;

  {Enregistrement de variable}
 VarRec=Record
  TypeDef:DefType;     { Mod둳e de variable }
  SegDes:SegDesType;   { Segment de destination }
  QParam:QParamType;   { Style de param둻re: Const, Var,... }
  Volatile:Bool;       { Variable pouvant 늯re s굋ar괻 de ses consoeurs }
  Reg:Byte;            { Num굍o de registre }
  SizeReg:Byte;        { Taille du registre }
  X:XVariant;          { Valeur par d괽aut de la variable si Const...}
  Ofs:Long;            { Offset sur le segment o� se trouve la variable }
  Size:Word;           { Taille }
  Name:String;         { Nom de la variable }
  ExternType:^TypeRec; { Type d괽init manuellement }
  UnitNum:Word;        { Num굍o de l'autre unit� si type externe }
  OfsUnit:Long;        { Position absolue dans l'unit� }
 End;

 TypeMainRec=Record
  Struct:RBuf;          { Liste de TypeRec }
  Free:Bool;            { Type lib굍er ? }
  Name:String;          { Nom de l'enregistrement }
 End;

 ExternProcRec=Record
  BankAddr:RBuf;   { Adresse dans le code o� la routine est r괹lam� }
  FP:Long;         { Adresse de l'ent늯e de la proc괺ure dans le fichier}
  UnitNum:Word;    { Num굍o d'unit� par rapport � la liste d'unit� }
  ProcName:String; { Nom de la proc괺ure }
 End;

 ExternVarRec=Record
  BankAddr:RBuf;   { Adresse dans le code o� la variable est r괹lam� }
  FP:Long;         { Adresse de l'ent늯e de la variable dans le fichier }
  UnitNum:Word;    { Num굍o d'unit� par rapport � la liste d'unit� }
  VarName:String;  { Nom de la variable }
 End;

 ProcPtr=^ProcRec;

  {Enregistrement de proc괺ure}
 ProcRec=Record
  Func,Free,Dupl:Bool; { Proc괺ure lib굍괻, duplication }
  Ofs:Wd;              { Adresse d'offset de cette proc괺ure }
  CurrPtr:Byte;        { Proc괺ure de style 췋AR� ou 췕EAR� }
  Param:RBuf;          { Pile contenant les information sur les param둻res }
  ParamRegister:Bool;  { Param둻re(s) dans les registres? }
  Parent:ProcPtr;      { Proc괺ure parent si c'est une duplication }
  Return:VarRec;       { Si fonction, variable de retour }
  Name:String[131];    { Nom de la proc괺ure }
 End;

  {Enregistrement d'inclusion}
 IncludeRec=Record
  Path:String; { Nom du fichier. }
  FP,FS:Long;  { Position actuel dans le fichier, ainsi que sa taille. }
  I:Byte;      { Position actuel dans la ligne courante du fichier. }
  Line:String; { Contenu de la ligne courante. }
 End;

  {Enregistrement d'une Macro}
 MacroRec=Record
  Name,Path:String; { Nom de la macro, Nom du fichier. }
  FB,FE:Long;       { Position absolue du d괷ut et la fin de la macro }
 End;
 MacroPtr=^MacroRec;

 AccessType=(isLabel,isJump);

 JumpRec=Record
  Off:Word;          { L'adresse absolue }
  Access:AccessType; { L'association � cette adresse est du genre...}
  Setted:(NoSetted,ShortJmp,NearJmpManual,NearJmp386,NearGoto);
  Nom:String[131];   { Nom du saut }
 End;
 JumpPtr=^JumpRec;

  {D괽inition des types pour l'assembleur en ligne du Pascal}
 AsmNmType=(
  aDec,                      { Format d괹imal }
  aBin,                      { Format binaire }
  aOct,                      { Format octal }
  aHex,                      { Format hexad괹imal }
  aError                     { Erreur de format }
 );
 DataAsmType=(
  DB,                        { Donn괻 de taille octet }
  DD,                        { Donn괻 de taille double mot }
  DW                         { Donn괻 de taille mot }
 );

 NoeudAsmPtr=^NoeudAsmRec;
 NoeudAsmRec=Record
  Nom:PChar;                 { Nom de l'instruction }
  Code:Word;                 { Code d'instruction Assembleur }
  CPU:Byte;                  { Code de CPU correspondant }
  Parameters:Bool;           { Param둻res? }
  OpCode:String[3];          { Code machine sugg굍�}
  Gauche,Droite:Word{NoeudAsmPtr}; { Pointeur sur celui de droite et de gauche }
 End;

 NoeudIfCondAsmPtr=^NoeudIfCondAsmRec;
 NoeudIfCondAsmRec=Record
  Nom:PChar;          { Nom de l'instruction }
  Code:Byte;          { Code de condition d'assembleur pour le IF }
  Gauche,Droite:Word; { Pointeur sur celui de droite et de gauche }
 End;

 NoeudMainWordPasPtr=^NoeudMainWordPasRec;
 NoeudMainWordPasRec=Record
  Nom:PChar;          { Nom de l'instruction }
  Code:Byte;          { Code de mots principal Pascal }
  Gauche,Droite:Word; { Pointeur sur celui de droite et de gauche }
 End;

 NoeudInstrPasPtr=^NoeudInstrPasRec;
 NoeudInstrPasRec=Record
  Nom:PChar;          { Nom de l'instruction }
  Code:Byte;          { Code d'instruction Pascal }
  Extra:Byte;         { Code suppl굆entaire de niveau }
  Gauche,Droite:Word; { Pointeur sur celui de droite et de gauche }
 End;

 NoeudRegAsmPtr=^NoeudRegAsmRec;
 NoeudRegAsmRec=Record
  Nom:String[3];      { Nom du registre }
  Code:Byte;          { Code d'instruction Pascal }
  Extra:Byte;         { Code suppl굆entaire de niveau }
  Gauche,Droite:Word; { Pointeur sur celui de droite et de gauche }
 End;

 NoeudVarPasPtr=^NoeudVarPasRec;
 NoeudVarPasRec=Record
  Nom:PChar;          { Nom du variable }
  TypeDef:DefType;    { Type de variable }
  Size:Word;          { Code suppl굆entaire de niveau }
  Gauche,Droite:Word; { Pointeur sur celui de droite et de gauche }
 End;

{$I \Source\Chantal\Tools\PCCortex.Inc}

Var
 NL:Long;        { Num굍o de ligne actuel }
 Status:Int;     { R굎ultat final du programme apr둺 compilation }
 ResWordBk,      { Banque des mots r굎erv굎 � additionner dans l'unit� }
 TypeDef,        { Banque de type et de d괽inition de structure }
 ExternVar,      { Banque de variable externe }
 ExternProc,     { Banque de routine externe }
 UnitList,       { Banque des unit굎 de r괽굍ence }
 Macro,          { Banque de Macro }
 Include,        { Banque d'inclusion }
 Jump,           { Banque des sauts }
 SuppData,       { Banque de donn괻 suppl굆entaire }
 Redef,          { Banque de constante }
 VarBk,          { Banque de variable global }
 ProcBk:RBuf;    { Banque de proc괺ure global }
 ProcName:String;{ Nom de la proc괺ure actuel }
 ProcAsm:Bool;   { Proc괺ure de style assembleur }
 VarInProc:Bool; { Inclusion de variable dans la proc괺ure actuel }
 CodePrg:PTByte; { Tampon contenant le langage machine du programme }
 IP:Wd;          { Position actuel  du pointeur  d'instruction dans }
                 { le tampon de la langage machine. }
 PrevIP:Wd;      { Pr괹괺ent IP...}
 Org:Wd;         { Position de l'entrer dans le programme (par d괽aut 100h) }
 DP:Wd;          { Position dans les donn괻s...}
 Handle:Hdl;     { Handle du fichier courant }
 SuggName,       { Nom du programme, de l'unit� ou de la biblioth둸ue }
 MainFile,       { R굋ertoire du fichier source principal }
 PathOutput,     { R굋ertoire du fichier destinataire }
 CurrFile,       { R굋ertoire du fichier source actuel }
  { Variable de travail }
 S,S2,S3,S4,S5,S6:String;
 I:Byte;FP,FS,l1,l2:Long;Ok:Bool;W:Wd;
 PProc:ProcPtr;PVar:^VarRec;PInclude:^IncludeRec;PJump:^JumpRec;
 ArrayCond:Array[0..255]of (cNone,cElse,cEndIf);
 CurrCond:Byte;
 ResWordDef:Bool;{ Il s'agit d'une unit� unit� o� se trouve des d괽initions de mots r굎erv굎}
 NmResWord:Wd;   { Nombre de mots r굎erv굎 }
 SizeResWord:Wd; { Taille des mots r굎erv굎 }
 {$IFDEF IDE}
  WC:Window;
  XEdt:^EditorApp;
 {$ENDIF}
 InRem:Boolean;

Const
 CaseLevel:Word=0;
 IfLevel:Word=0;

{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�}
                               IMPLEMENTATION
{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�}

END.