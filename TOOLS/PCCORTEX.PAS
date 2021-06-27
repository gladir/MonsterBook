{ ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ

 ³                Compilateur Pascal Niveau B57/Cortex                  ³
                     Malte Genesis IV: Alias Chantal
 ³                                                                      ³
            Tous droits r‚serv‚s par les Chevaliers de Malte
 ³                                                                      ³

 ³                            1998 … 2000                               ³

  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ


 Nom du programmeur
 ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

  Sylvain Maltais


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette unit‚ renferme toutes les d‚finitions et constantes n‚cessaires au
 compilateur de langage Pascal niveau B57.

  Ainsi  on   retrouve   entre   autre   les  structures  de  stockage  de
 l'information des unit‚s  dans les fichiers  et ceux utilis‚ au niveau de
 la m‚moire, structure utilis‚e pour le transfert...

  On retrouve ‚galement les mots r‚serv‚s utilis‚ par le langage Pascal de
 niveau B57.  Les  chaŒnes  de  caractŠres  associ‚s  ainsi  que  l'action
 appropri‚e en fonction du mot trouv‚.
}

Unit PCCortex;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                 INTERFACE
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses Systex{$IFDEF IDE},Isatex{$ENDIF};

Const
  {Constantes des mots r‚serv‚s du langage Pascal B57 }
 cmwpAsm=0;               { Mot r‚serv‚ de langage Pascal ®ASM¯ }
 cmwpBegin=1;             { Mot r‚serv‚ de langage Pascal ®BEGIN¯ ou ®DBUT¯ }
 cmwpCSConst=2;           { Mot r‚serv‚ de langage Pascal B57 ®CSConst¯ }
 cmwpConst=3;             { Mot r‚serv‚ de langage Pascal ®CONST¯ ou ®CONSTANTE¯ }
 cmwpExports=4;           { Mot r‚serv‚ de langage Pascal ®EXPORTS¯ }
 cmwpFinalization=5;      { Mot r‚serv‚ de langage Delphi ®FINALIZATION¯ ou ®FINALISATION¯ }
 cmwpFunction=6;          { Mot r‚serv‚ de langage Pascal ®FUNCTION¯ ou ®FONCTION¯ }
 cmwpImplementation=7;    { Mot r‚serv‚ de langage Pascal ®IMPLEMENTATION¯ }
 cmwpInclude=8;           { Mot r‚serv‚ de langage Pascal B57 ®INCLUDE¯ }
 cmwpInitialization=9;    { Mot r‚serv‚ de langage Delphi ®INITIALIZATION¯ }
 cmwpInterface=10;        { Mot r‚serv‚ de langage Pascal ®INTERFACE¯ }
 cmwpLibrary=11;          { Mot r‚serv‚ de langage Pascal ®LIBRARY¯ ou ®BIBLIOTHEQUE¯ }
 cmwpMacro=12;            { Mot r‚serv‚ de langage Pascal B57 ®MACRO¯ }
 cmwpProcedure=13;        { Mot r‚serv‚ de langage Pascal ®PROCEDURE¯ ou ®PROCDURE¯ }
 cmwpProgram=14;          { Mot r‚serv‚ de langage Pascal ®PROGRAM¯ ou ®PROGRAMME¯ }
 cmwpType=15;             { Mot r‚serv‚ de langage Pascal ®TYPE¯ ou ®TYPEDEF¯ }
 cmwpUnit=16;             { Mot r‚serv‚ de langage Pascal ®UNIT¯ ou ®UNIT¯ }
 cmwpUses=17;             { Mot r‚serv‚ de langage Pascal ®USES¯ ou ®UTILISS¯ }
 cmwpVar=18;              { Mot r‚serv‚ de langage Pascal ®VAR¯ ou ®VARIABLE¯ }
 cmwpEnd=19;              { Mot r‚serv‚ de langage Pascal ®END¯ ou ®FIN¯ }
 cmwpIf=20;               { Mot r‚serv‚ de langage Pascal ®IF¯ ou ®SI¯ }
 cmwpElse=21;             { Mot r‚serv‚ de langage Pascal ®ELSE¯, ®SINON¯ ou ®AUTREMENT¯ }
 cmwpThen=22;             { Mot r‚serv‚ de langage Pascal ®THEN¯ ou ®ALORS¯ }
 cmwpFor=23;              { Mot r‚serv‚ de langage Pascal ®FOR¯ ou ®POUR¯ }
 cmwpGoto=24;             { Mot r‚serv‚ de langage Pascal ®GOTO¯ ou ®ALLERA¯ }
 cmwpWhile=25;            { Mot r‚serv‚ de langage Pascal ®WHILE¯ ou ®TANTQUE¯ }
 cmwpRepeat=26;           { Mot r‚serv‚ de langage Pascal ®REPEAT¯ ou ®REPETER¯ }
 cmwpAbsolute=27;         { Mot r‚serv‚ de langage Pascal ®ABSOLUTE¯ ou ®ABSOLUE¯ }
 cmwpAnd=28;              { Mot r‚serv‚ de langage Pascal ®AND¯ ou ®ET¯ }
 cmwpArray=29;            { Mot r‚serv‚ de langage Pascal ®ARRAY¯ ou ®RANGE¯ }
 cmwpAssembler=30;        { Mot r‚serv‚ de langage Pascal ®ASSEMBLER¯ ou ®ASSEMBLEUR¯ }
 cmwpCase=31;             { Mot r‚serv‚ de langage Pascal ®CASE¯ ou ®CAS¯ }
 cmwpConstructor=32;      { Mot r‚serv‚ de langage Pascal ®CONSTRUCTOR¯ ou ®CONSTRUCTEUR¯ }
 cmwpDestructor=33;       { Mot r‚serv‚ de langage Pascal ®DESTRUCTOR¯ ou ®DESTRUCTEUR¯ }
 cmwpDo=34;               { Mot r‚serv‚ de langage Pascal ®DO¯ ou ®FAIRE¯ }
 cmwpFar=35;              { Mot r‚serv‚ de langage Pascal ®FAR¯ ou ®LOIN¯ }
 cmwpFile=36;             { Mot r‚serv‚ de langage Pascal ®FILE¯ ou ®FICHIER¯ }
 cmwpIn=37;               { Mot r‚serv‚ de langage Pascal ®IN¯ ou ®DANS¯ }
 cmwpInherited=38;        { Mot r‚serv‚ de langage Pascal ®INHERITED¯ ou ®HRITIER¯ }
 cmwpInline=39;           { Mot r‚serv‚ de langage Pascal ®INLINE¯ ou ®ENLIGNE¯ }
 cmwpLabel=40;            { Mot r‚serv‚ de langage Pascal ®LABEL¯ ou ®TIQUETTE¯ }
 cmwpNear=41;             { Mot r‚serv‚ de langage Pascal ®NEAR¯ ou ®COURT¯ }
 cmwpObject=42;           { Mot r‚serv‚ de langage Pascal ®OBJECT¯ ou ®OBJET¯ }
 cmwpOf=43;               { Mot r‚serv‚ de langage Pascal ®OF¯ ou ®DE¯ }
 cmwpPacked=44;           { Mot r‚serv‚ de langage Pascal ®PACKED¯ ou ®PAQUET¯ }
 cmwpRecord=45;           { Mot r‚serv‚ de langage Pascal ®RECORD¯ ou ®ENREGISTREMENT¯ }
 cmwpSet=46;              { Mot r‚serv‚ de langage Pascal ®SET¯ ou ®ENSEMBLE¯ }
 cmwpTo=47;               { Mot r‚serv‚ de langage Pascal ®TO¯ ou ®JUSQUA¯ }
 cmwpVirtual=48;          { Mot r‚serv‚ de langage Pascal ®VIRTUAL¯ ou ®VIRTUEL¯ }
 cmwpWith=49;             { Mot r‚serv‚ de langage Pascal ®WITH¯ ou ®AVEC¯ }
 cmwpDiv=50;              { Mot r‚serv‚ de langage Pascal ®DIV¯ }
 cmwpMod=51;              { Mot r‚serv‚ de langage Pascal ®MOD¯ }
 cmwpNot=52;              { Mot r‚serv‚ de langage Pascal ®NOT¯ ou ®PAS¯ }
 cmwpOr=53;               { Mot r‚serv‚ de langage Pascal ®OR¯ ou ®OU¯ }
 cmwpShl=54;              { Mot r‚serv‚ de langage Pascal ®SHL¯, ®DECALG¯ ou ®DEG¯ }
 cmwpShr=55;              { Mot r‚serv‚ de langage Pascal ®SHR¯, ®DECALD¯ ou ®DED¯ }
 cmwpXor=56;              { Mot r‚serv‚ de langage Pascal ®XOR¯ ou ®OUX¯ }
 cmwpInterrupt=57;        { Mot r‚serv‚ de langage Pascal ®INTERRUPT¯ }
 cmwpElseIf=58;           { Mot r‚serv‚ de langage Pascal B57 ®ELSEIF¯, ®ELIF¯ ou ®ELSIF¯ }
 cmwpDuplicate=59;        { Mot r‚serv‚ de langage Pascal B57 ®DUPLICATE¯ ou ®DUPLICATION¯ }
 cmwpRegister=60;         { Mot r‚serv‚ de langage Pascal B57 ®REGISTER¯ ou ®REGISTRE¯ }
 cmwpMax=60;              { Dernier mot r‚serv‚ de la liste du langage Pascal B57 }
 cmwpError=$FF;

Type
 ProgramFormatType=(
  fCOM,               { Fichier de format ®.COM¯ }
  fEXE,               { Fichier de format ®.EXE¯ }
  fMEX,               { Fichier de format ®.MEX¯ }
  fBOOT,              { Secteur de d‚marrage }
  fUnitTiny,          { Unit‚ compacte }
  fUnitLarge,         { Unit‚ ‚tendue }
  fLibrary            { BibliothŠque }
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
 StackSize:Word=16384;      { Taille de la pile par d‚faut }
 MinParag:Word=0;           { Nombre minimum de paragraphe en mode r‚el }
 MaxParag:Word=65535;       { Nombre maximal de paragraphe en mode r‚el }
 CurrPointer:Byte=cmwpNear; { Portabilit‚ des proc‚dures et fonctions }
 InstrFormat:(              { Format de code machine par d‚faut }
  p88,                      { INTEL 8088/8086/NEC V20/V30 }
  p186,                     { INTEL 80188/80186 }
  p286,                     { INTEL 80286/AMD 286}
  p386,                     { 80386/AMD 386 }
  p486,                     { 80486/Cyrix 5x86 }
  p586,                     { 80586/Pentium/Cyrix 6x86 }
  p686)                     { 80686/Pentium Pro }
 =p88;                      { Format par d‚faut 8088 }
 ProgramFormat:ProgramFormatType=fCOM; { Format d'ex‚cutable par d‚faut: .COM }
 ProgramTarget:ProgramTargetType=ftDOS;
 Body:(
  bPRELUDE,                 { Quelque part au d‚but du fichier sans en autre s–r...}
  bINTERFACE,               { Zone interface d'une unit‚ }
  bIMPLEMENTATION,          { Zone d'impl‚mentation d'une unit‚ }
  bINITIALIZATION,          { Bloc d'initialisation }
  bFINALISATION,            { Bloc de terminaison }
  bMAIN                     { Bloc principal }
 )=bPRELUDE;
 CSyntax:Bool=Ya;           { Autorise les syntaxes C style #define...}
 BuildAll:Bool=No;          { Reconstruit toutes les unit‚s utilis‚s ? }
 MakeModifiedUnit:Bool=Ya;  { Reconstruit les unit‚s modifi‚ ? }
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

 SignUnit='Unit‚ Pascal Niveau B57 Version A'#13#10'Tous droits r‚serv‚s par les Chevaliers de Malte'#26;

 DefTypeSize:Array[0..13]of Word=(
  0,1,1,1,1,2,2,4,4,4,0,0,256,256
 );

 GhostConst:Long=0; { Constante fant“me }
 GhostCode:Long=0;  { Code fant“me }

Type
 DefType=(    { Type de d‚finition }
  tEnum,      { num‚ration }
  tBool,      { Bool‚an (True/False) (Vrai/Faux) }
  tByte,      { Byte/Octet }
  tShort,     { Short (-128 … 127) }
  tChar,      { Char (caractŠre)}
  tInt,       { Integer/entier (-32768 … 32767) }
  tWord,      { Word/Mot (0 … 65535) }
  tLong,      { LongInt }
  tProc,      { Procedure/Proc‚dure }
  tFunc,      { Function/Fonction }
  tPtr,       { Pointer }
  tArray,     { Array/Rang‚e }
  tRec,       { RECORD }
  tString,    { STRING }
  tCString,   { ®CSTRING¯ comme QuickPascal }
  tPtrString, { Pointeur de STRING }
  tIntervalle,{ Intervalle ?..? }
  tCase,      { Case Record ... of }
  tExternRec, { Enregistrement externe }
  tEnd,       { END/FIN }
  tExtern,    { Type externe dans le module courant (unit‚ ou programme)}
  tExternUnit,{ Type externe dans un autre unit‚ }
  tNoType);   { Sans type }

  {Destination … utiliser comme Segment }
 SegDesType=(
  vCS,            { Segment de code utilis‚ comme destination }
  vDS,            { Segment de donn‚e utilis‚ comme destination }
  vES,            { Segment extra utilis‚ comme destination }
  vFS,            { Segment FS 386 utilis‚ comme destination }
  vGS,            { Segment GS 386 utilis‚ comme destination }
  vSS,            { Segment de pile utilis‚ comme destination }
  vAbsolute,      { Adressage absolue comme destination }
  vSSParam,       { Segment de pile en paramŠtre comme destination }
  vRegParam);     { Registre comme destination }

 QParamType=(
  qNone,          { Aucun typage de paramŠtre }
  qVar,           { ParamŠtre par pointeur/modification autoris‚ }
  qConst          { ParamŠtre par pointeur/modification interdite }
 );

 UnitHeaderRec=Record
  Sign:Array[0..Length(SignUnit)]of Char;
  ProgramFormat:ProgramFormatType;
  DebugInfo:Bool;   { Pr‚sence d'information de d‚boguage }
  ResWordFound:Bool;{ Mot r‚serv‚ pr‚sent?}
  NmResWord,        { Nombre de mots r‚serv‚s }
  SizeResWord:Word; { Taille de la table des mots r‚serv‚s }
  NmConst,          { Nombre de constante(s) }
  NmType,           { Nombre de type(s) et structure(s) }
  NmVar,            { Nombre de variable(s) }
  NmProc:Word;      { Nombre de proc‚dure(s) et fonction(s) }
  IP:Long;          { Taille totalement en octets du code machine }
                    { contenu dans l'unit‚ }
  OffConst,         { Position absolue des constante(s) dans le fichier }
  OffType,          { Position absolue des type(s) dans le fichier }
  OffVar,           { Position absolue des variable(s) dans le fichier }
  OffProc:Long;     { Position absolue des proc‚dure(s) et fonction(s) }
  OffPrivate:Long;  { Position absolue des donn‚es priv‚es }
  Date:Long;        { Date du source de l'unit‚ }
  Name:String;      { Nom de l'unit‚ }
 End;

 UnitCstRec=Record
  Gauche,Droite:Long;   { Position du pr‚c‚dent et du suivant }
  TypeDef:DefType;      { Style de d‚finition }
  Name:String[255];     { Nom de la constante }
 End;

 UnitVarRec=Record
  Suivant:Long;         { Position du suivant }
  TypeDef:DefType;      { Style de d‚finition }
  SegDes:SegDesType;    { Segment de destination }
  QParam:QParamType;    { Style de paramŠtre: Const, Var,... }
  Volatile:Bool;        { Variable pouvant ˆtre s‚par‚e de ses conseurs }
  Size:Word;            { Taille }
  Name:String[255];     { Nom de la variable }
 End;

 UnitTypeRec=Record
  Gauche,Droite:Long;
  Name:String;
 End;

 UnitProcRec=Record
  Gauche,Droite:Long;   { 0 … 7:   Position du pr‚d‚dent et du suivant }
  NmParam:Word;         { 8 … 9:   Nombre de paramŠtres }
  CurrPtr:Byte;         { 10:      De type Near, Far }
  Func,Dupl:Bool;       { 11 … 12: Fonction?, Duplication d'une autre proc‚dure }
  OffBody:Long;         { 13 … 16: Position du code de la routine dans le fichier }
  Name:String[255];     { 17 … ...:Nom de la proc‚dure }
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
  7:(Buf:Pointer); { Contenu con‡ernant cette constante }
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
  Free:Bool;         { Constante lib‚rer? }
  Q:Variant;         { Valeur de la constante }
 End;

 TypeRec=Record{Enregistrement d'un type}
  TypeDef:DefType;      { ModŠle de type }
  ArrayTypeDef:DefType; { Tableau de type }
  PointTo:Bool;         { Pointeur sur l'argument (^?) }
  Pile:RBuf;            { Si ‚num‚ration, enregistrement, cas... }
  Min:Integer;          { Si tableau: minimum (Array[Min..Max]..)}
  Max:Word;             { Si tableau: maximum, Si ChaŒne: String[Max] }
  Name:String;          { Nom de l'item }
 End;

  {Enregistrement de variable}
 VarRec=Record
  TypeDef:DefType;     { ModŠle de variable }
  SegDes:SegDesType;   { Segment de destination }
  QParam:QParamType;   { Style de paramŠtre: Const, Var,... }
  Volatile:Bool;       { Variable pouvant ˆtre s‚par‚e de ses consoeurs }
  Reg:Byte;            { Num‚ro de registre }
  SizeReg:Byte;        { Taille du registre }
  X:XVariant;          { Valeur par d‚faut de la variable si Const...}
  Ofs:Long;            { Offset sur le segment o— se trouve la variable }
  Size:Word;           { Taille }
  Name:String;         { Nom de la variable }
  ExternType:^TypeRec; { Type d‚finit manuellement }
  UnitNum:Word;        { Num‚ro de l'autre unit‚ si type externe }
  OfsUnit:Long;        { Position absolue dans l'unit‚ }
 End;

 TypeMainRec=Record
  Struct:RBuf;          { Liste de TypeRec }
  Free:Bool;            { Type lib‚rer ? }
  Name:String;          { Nom de l'enregistrement }
 End;

 ExternProcRec=Record
  BankAddr:RBuf;   { Adresse dans le code o— la routine est r‚clam‚ }
  FP:Long;         { Adresse de l'entˆte de la proc‚dure dans le fichier}
  UnitNum:Word;    { Num‚ro d'unit‚ par rapport … la liste d'unit‚ }
  ProcName:String; { Nom de la proc‚dure }
 End;

 ExternVarRec=Record
  BankAddr:RBuf;   { Adresse dans le code o— la variable est r‚clam‚ }
  FP:Long;         { Adresse de l'entˆte de la variable dans le fichier }
  UnitNum:Word;    { Num‚ro d'unit‚ par rapport … la liste d'unit‚ }
  VarName:String;  { Nom de la variable }
 End;

 ProcPtr=^ProcRec;

  {Enregistrement de proc‚dure}
 ProcRec=Record
  Func,Free,Dupl:Bool; { Proc‚dure lib‚r‚e, duplication }
  Ofs:Wd;              { Adresse d'offset de cette proc‚dure }
  CurrPtr:Byte;        { Proc‚dure de style ®FAR¯ ou ®NEAR¯ }
  Param:RBuf;          { Pile contenant les information sur les paramŠtres }
  ParamRegister:Bool;  { ParamŠtre(s) dans les registres? }
  Parent:ProcPtr;      { Proc‚dure parent si c'est une duplication }
  Return:VarRec;       { Si fonction, variable de retour }
  Name:String[131];    { Nom de la proc‚dure }
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
  FB,FE:Long;       { Position absolue du d‚but et la fin de la macro }
 End;
 MacroPtr=^MacroRec;

 AccessType=(isLabel,isJump);

 JumpRec=Record
  Off:Word;          { L'adresse absolue }
  Access:AccessType; { L'association … cette adresse est du genre...}
  Setted:(NoSetted,ShortJmp,NearJmpManual,NearJmp386,NearGoto);
  Nom:String[131];   { Nom du saut }
 End;
 JumpPtr=^JumpRec;

  {D‚finition des types pour l'assembleur en ligne du Pascal}
 AsmNmType=(
  aDec,                      { Format d‚cimal }
  aBin,                      { Format binaire }
  aOct,                      { Format octal }
  aHex,                      { Format hexad‚cimal }
  aError                     { Erreur de format }
 );
 DataAsmType=(
  DB,                        { Donn‚e de taille octet }
  DD,                        { Donn‚e de taille double mot }
  DW                         { Donn‚e de taille mot }
 );

 NoeudAsmPtr=^NoeudAsmRec;
 NoeudAsmRec=Record
  Nom:PChar;                 { Nom de l'instruction }
  Code:Word;                 { Code d'instruction Assembleur }
  CPU:Byte;                  { Code de CPU correspondant }
  Parameters:Bool;           { ParamŠtres? }
  OpCode:String[3];          { Code machine sugg‚r‚}
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
  Extra:Byte;         { Code suppl‚mentaire de niveau }
  Gauche,Droite:Word; { Pointeur sur celui de droite et de gauche }
 End;

 NoeudRegAsmPtr=^NoeudRegAsmRec;
 NoeudRegAsmRec=Record
  Nom:String[3];      { Nom du registre }
  Code:Byte;          { Code d'instruction Pascal }
  Extra:Byte;         { Code suppl‚mentaire de niveau }
  Gauche,Droite:Word; { Pointeur sur celui de droite et de gauche }
 End;

 NoeudVarPasPtr=^NoeudVarPasRec;
 NoeudVarPasRec=Record
  Nom:PChar;          { Nom du variable }
  TypeDef:DefType;    { Type de variable }
  Size:Word;          { Code suppl‚mentaire de niveau }
  Gauche,Droite:Word; { Pointeur sur celui de droite et de gauche }
 End;

{$I \Source\Chantal\Tools\PCCortex.Inc}

Var
 NL:Long;        { Num‚ro de ligne actuel }
 Status:Int;     { R‚sultat final du programme aprŠs compilation }
 ResWordBk,      { Banque des mots r‚serv‚s … additionner dans l'unit‚ }
 TypeDef,        { Banque de type et de d‚finition de structure }
 ExternVar,      { Banque de variable externe }
 ExternProc,     { Banque de routine externe }
 UnitList,       { Banque des unit‚s de r‚f‚rence }
 Macro,          { Banque de Macro }
 Include,        { Banque d'inclusion }
 Jump,           { Banque des sauts }
 SuppData,       { Banque de donn‚e suppl‚mentaire }
 Redef,          { Banque de constante }
 VarBk,          { Banque de variable global }
 ProcBk:RBuf;    { Banque de proc‚dure global }
 ProcName:String;{ Nom de la proc‚dure actuel }
 ProcAsm:Bool;   { Proc‚dure de style assembleur }
 VarInProc:Bool; { Inclusion de variable dans la proc‚dure actuel }
 CodePrg:PTByte; { Tampon contenant le langage machine du programme }
 IP:Wd;          { Position actuel  du pointeur  d'instruction dans }
                 { le tampon de la langage machine. }
 PrevIP:Wd;      { Pr‚c‚dent IP...}
 Org:Wd;         { Position de l'entrer dans le programme (par d‚faut 100h) }
 DP:Wd;          { Position dans les donn‚es...}
 Handle:Hdl;     { Handle du fichier courant }
 SuggName,       { Nom du programme, de l'unit‚ ou de la bibliothŠque }
 MainFile,       { R‚pertoire du fichier source principal }
 PathOutput,     { R‚pertoire du fichier destinataire }
 CurrFile,       { R‚pertoire du fichier source actuel }
  { Variable de travail }
 S,S2,S3,S4,S5,S6:String;
 I:Byte;FP,FS,l1,l2:Long;Ok:Bool;W:Wd;
 PProc:ProcPtr;PVar:^VarRec;PInclude:^IncludeRec;PJump:^JumpRec;
 ArrayCond:Array[0..255]of (cNone,cElse,cEndIf);
 CurrCond:Byte;
 ResWordDef:Bool;{ Il s'agit d'une unit‚ unit‚ o— se trouve des d‚finitions de mots r‚serv‚s}
 NmResWord:Wd;   { Nombre de mots r‚serv‚s }
 SizeResWord:Wd; { Taille des mots r‚serv‚s }
 {$IFDEF IDE}
  WC:Window;
  XEdt:^EditorApp;
 {$ENDIF}
 InRem:Boolean;

Const
 CaseLevel:Word=0;
 IfLevel:Word=0;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                               IMPLEMENTATION
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

END.