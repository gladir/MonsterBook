Unit Calcex;

INTERFACE

Uses Systex,Isatex;

Const
  {Constantes des mots rÇservÇs du langage Pascal B57 }
 cmwpAsm=0;               { Mot rÇservÇ de langage Pascal ÆASMØ }
 cmwpBegin=1;             { Mot rÇservÇ de langage Pascal ÆBEGINØ ou ÆDêBUTØ }
 cmwpCSConst=2;           { Mot rÇservÇ de langage Pascal B57 ÆCSConstØ }
 cmwpConst=3;             { Mot rÇservÇ de langage Pascal ÆCONSTØ ou ÆCONSTANTEØ }
 cmwpExports=4;           { Mot rÇservÇ de langage Pascal ÆEXPORTSØ }
 cmwpFinalization=5;      { Mot rÇservÇ de langage Delphi ÆFINALIZATIONØ ou ÆFINALISATIONØ }
 cmwpFunction=6;          { Mot rÇservÇ de langage Pascal ÆFUNCTIONØ ou ÆFONCTIONØ }
 cmwpImplementation=7;    { Mot rÇservÇ de langage Pascal ÆIMPLEMENTATIONØ }
 cmwpInclude=8;           { Mot rÇservÇ de langage Pascal B57 ÆINCLUDEØ }
 cmwpInitialization=9;    { Mot rÇservÇ de langage Delphi ÆINITIALIZATIONØ }
 cmwpInterface=10;        { Mot rÇservÇ de langage Pascal ÆINTERFACEØ }
 cmwpLibrary=11;          { Mot rÇservÇ de langage Pascal ÆLIBRARYØ ou ÆBIBLIOTHEQUEØ }
 cmwpMacro=12;            { Mot rÇservÇ de langage Pascal B57 ÆMACROØ }
 cmwpProcedure=13;        { Mot rÇservÇ de langage Pascal ÆPROCEDUREØ ou ÆPROCêDUREØ }
 cmwpProgram=14;          { Mot rÇservÇ de langage Pascal ÆPROGRAMØ ou ÆPROGRAMMEØ }
 cmwpType=15;             { Mot rÇservÇ de langage Pascal ÆTYPEØ ou ÆTYPEDEFØ }
 cmwpUnit=16;             { Mot rÇservÇ de langage Pascal ÆUNITØ ou ÆUNITêØ }
 cmwpUses=17;             { Mot rÇservÇ de langage Pascal ÆUSESØ ou ÆUTILISêSØ }
 cmwpVar=18;              { Mot rÇservÇ de langage Pascal ÆVARØ ou ÆVARIABLEØ }
 cmwpEnd=19;              { Mot rÇservÇ de langage Pascal ÆENDØ ou ÆFINØ }
 cmwpIf=20;               { Mot rÇservÇ de langage Pascal ÆIFØ ou ÆSIØ }
 cmwpElse=21;             { Mot rÇservÇ de langage Pascal ÆELSEØ, ÆSINONØ ou ÆAUTREMENTØ }
 cmwpThen=22;             { Mot rÇservÇ de langage Pascal ÆTHENØ ou ÆALORSØ }
 cmwpFor=23;              { Mot rÇservÇ de langage Pascal ÆFORØ ou ÆPOURØ }
 cmwpGoto=24;             { Mot rÇservÇ de langage Pascal ÆGOTOØ ou ÆALLERAØ }
 cmwpWhile=25;            { Mot rÇservÇ de langage Pascal ÆWHILEØ ou ÆTANTQUEØ }
 cmwpRepeat=26;           { Mot rÇservÇ de langage Pascal ÆREPEATØ ou ÆREPETERØ }
 cmwpAbsolute=27;         { Mot rÇservÇ de langage Pascal ÆABSOLUTEØ ou ÆABSOLUEØ }
 cmwpAnd=28;              { Mot rÇservÇ de langage Pascal ÆANDØ ou ÆETØ }
 cmwpArray=29;            { Mot rÇservÇ de langage Pascal ÆARRAYØ ou ÆRANGêEØ }
 cmwpAssembler=30;        { Mot rÇservÇ de langage Pascal ÆASSEMBLERØ ou ÆASSEMBLEURØ }
 cmwpCase=31;             { Mot rÇservÇ de langage Pascal ÆCASEØ ou ÆCASØ }
 cmwpConstructor=32;      { Mot rÇservÇ de langage Pascal ÆCONSTRUCTORØ ou ÆCONSTRUCTEURØ }
 cmwpDestructor=33;       { Mot rÇservÇ de langage Pascal ÆDESTRUCTORØ ou ÆDESTRUCTEURØ }
 cmwpDo=34;               { Mot rÇservÇ de langage Pascal ÆDOØ ou ÆFAIREØ }
 cmwpFar=35;              { Mot rÇservÇ de langage Pascal ÆFARØ ou ÆLOINØ }
 cmwpFile=36;             { Mot rÇservÇ de langage Pascal ÆFILEØ ou ÆFICHIERØ }
 cmwpIn=37;               { Mot rÇservÇ de langage Pascal ÆINØ ou ÆDANSØ }
 cmwpInherited=38;        { Mot rÇservÇ de langage Pascal ÆINHERITEDØ ou ÆHêRITIERØ }
 cmwpInline=39;           { Mot rÇservÇ de langage Pascal ÆINLINEØ ou ÆENLIGNEØ }
 cmwpLabel=40;            { Mot rÇservÇ de langage Pascal ÆLABELØ ou ÆêTIQUETTEØ }
 cmwpNear=41;             { Mot rÇservÇ de langage Pascal ÆNEARØ ou ÆCOURTØ }
 cmwpObject=42;           { Mot rÇservÇ de langage Pascal ÆOBJECTØ ou ÆOBJETØ }
 cmwpOf=43;               { Mot rÇservÇ de langage Pascal ÆOFØ ou ÆDEØ }
 cmwpPacked=44;           { Mot rÇservÇ de langage Pascal ÆPACKEDØ ou ÆPAQUETØ }
 cmwpRecord=45;           { Mot rÇservÇ de langage Pascal ÆRECORDØ ou ÆENREGISTREMENTØ }
 cmwpSet=46;              { Mot rÇservÇ de langage Pascal ÆSETØ ou ÆENSEMBLEØ }
 cmwpTo=47;               { Mot rÇservÇ de langage Pascal ÆTOØ ou ÆJUSQUAØ }
 cmwpVirtual=48;          { Mot rÇservÇ de langage Pascal ÆVIRTUALØ ou ÆVIRTUELØ }
 cmwpWith=49;             { Mot rÇservÇ de langage Pascal ÆWITHØ ou ÆAVECØ }
 cmwpDiv=50;              { Mot rÇservÇ de langage Pascal ÆDIVØ }
 cmwpMod=51;              { Mot rÇservÇ de langage Pascal ÆMODØ }
 cmwpNot=52;              { Mot rÇservÇ de langage Pascal ÆNOTØ ou ÆPASØ }
 cmwpOr=53;               { Mot rÇservÇ de langage Pascal ÆORØ ou ÆOUØ }
 cmwpShl=54;              { Mot rÇservÇ de langage Pascal ÆSHLØ, ÆDECALGØ ou ÆDEGØ }
 cmwpShr=55;              { Mot rÇservÇ de langage Pascal ÆSHRØ, ÆDECALDØ ou ÆDEDØ }
 cmwpXor=56;              { Mot rÇservÇ de langage Pascal ÆXORØ ou ÆOUXØ }
 cmwpInterrupt=57;        { Mot rÇservÇ de langage Pascal ÆINTERRUPTØ }
 cmwpElseIf=58;           { Mot rÇservÇ de langage Pascal B57 ÆELSEIFØ, ÆELIFØ ou ÆELSIFØ }
 cmwpDuplicate=59;        { Mot rÇservÇ de langage Pascal B57 ÆDUPLICATEØ ou ÆDUPLICATIONØ }
 cmwpRegister=60;         { Mot rÇservÇ de langage Pascal B57 ÆREGISTERØ ou ÆREGISTREØ }

 cmfpAbs=1;               { Fonction @ABS }
 cmfpACos=2;              { Fonction @ACOS }
 cmfpActuel=3;            { Fonction @ACTUEL, @NOW }
 cmfpAleat=4;             { Fonction @ALEAT }
 cmfpAmorann=5;           { Fonction @AMORANN, @SYD }
 cmfpAmordeg=6;           { Fonction @AMORDEG, @DDB }
 cmfpAmorlin=7;           { Fonction @AMORLIN, @SLN }
 cmfpAmort=8;             { Fonction @AMORT, @IRR }
 cmfpAnnee=9;             { Fonction @ANNEE, @YEAR }
 cmfpArrondi=10;          { Fonction @ARRONDI, @ROUND }
 cmfpASin=11;             { Fonction @ASIN }
 cmfpATan=12;             { Fonction @ATAN }
 cmfpATan2=13;            { Fonction @ATAN2 }
 cmfpAujourdhui=14;       { Fonction @AUJOURDHUI, @TODAY }
 cmfpBCompte=15;          { Fonction @BCOMPTE, @DCOUNT }
 cmfpBMax=16;             { Fonction @BMAX }
 cmfpBMin=17;             { Fonction @BMIN }
 cmfpBMoyenne=18;         { Fonction @BMOYENNE, @DAVG }
 cmfpBSomme=19;           { Fonction @BSOMME, @DSUM }
 cmfpBStd=20;             { Fonction @BSTD }
 cmfpBStds=21;            { Fonction @BSTDS }
 cmfpBVar=22;             { Fonction @BVAR, @DVAR }
 cmfpBVars=23;            { Fonction @BVARS }
 cmfpC=24;                { Fonction @C, @S }
 cmfpCar=25;              { Fonction @CAR, @CHAR }
 cmfpCellIndex=26;        { Fonction @CELLINDEX }
 cmfpCellule=27;          { Fonction @CELLULE, @CELL }
 cmfpChaine=28;           { Fonction @CHAINE, @STRING }
 cmfpCherche=29;          { Fonction @CHERCHE, @FIND }
 cmfpChoix=30;            { Fonction @CHOIX, @CHOOSE }
 cmfpCode=31;             { Fonction @CODE }
 cmfpCol=32;              { Fonction @COL, @COLS }
 cmfpCompte=33;           { Fonction @COMPTE, @COUNT }
 cmfpConsH=34;            { Fonction @CONSH, @HLOOKUP }
 cmfpConsV=35;            { Fonction @CONSV, @VLOOKUP }
 cmfpCos=36;              { Fonction @COS, COS }
 cmfpDate=37;             { Fonction @DATE }
 cmfpDatVal=38;           { Fonction @DATVAL, @DATEVALUE }
 cmfpDebut=39;            { Fonction @DEBUG, @LEFT }
 cmfpDeg=40;              { Fonction @DEG, @DEGREES }
 cmfpDuree=41;            { Fonction @DUREE, @TERM }
 cmfpDureeComp=42;        { Fonction @DUREECOMP, @CTERM }
 cmfpEgal=43;             { Fonction @EGAL }
 cmfpEnt=44;              { Fonction @ENT, @INT }
 cmfpEpure=45;            { Fonction @EPURE, @CLEAN }
 cmfpErr=46;              { Fonction @ERR }
 cmfpEstChaine=47;        { Fonction @ESTCHAINE, @ISSTRING }
 cmfpEstErr=48;           { Fonction @ESTERR, @ISERR }
 cmfpEstNd=49;            { Fonction @ESTND, @ISNA }
 cmfpEstNum=50;           { Fonction @ESTNUM, @ISNUMBER }
 cmfpExp=51;              { Fonction @EXP }
 cmfpFaux=52;             { Fonction @FAUX, @FALSE }
 cmfpFichierExiste=53;    { Fonction @FICHIEREXISTE, @FILEEXISTS }
 cmfpFin=54;              { Fonction @FIN, @RIGHT }
 cmfpHeure=55;            { Fonction @HEURE, @HOUR }
 cmfpHeurVal=56;          { Fonction @HEURVAL, @TIMEVALUE }
 cmfpHexanum=57;          { Fonction @HEXANUM, @HEXTONUM }
 cmfpIndex=58;            { Fonction @INDEX }
 cmfpInteret=59;          { Fonction @INTERET, @IPAYMT }
 cmfpIsaaf=60;            { Fonction @ISAAF }
 cmfpIsapp=61;            { Fonction @ISAPP }
 cmfpJour=62;             { Fonction @JOUR, @DAY }
 cmfpLignes=63;           { Fonction @LIGNES, @ROWS }
 cmfpLN=64;               { Fonction @LN }
 cmfpLog10=65;            { Fonction @LOG }
 cmfpLong=66;             { Fonction @LONG, @LENGTH }
 cmfpMajusc=67;           { Fonction @MAJUSC, @UPPER }
 cmfpMax=68;              { Fonction @MAX }
 cmfpMemDispo=69;         { Fonction @MEMDISPO, @MEMAVAIL }
 cmfpMemMemsDispo=70;     { Fonction @MEMMEMSDISPO, @MEMMEMSAVAIL }
 cmfpMilieu=71;           { Fonction @MILIEU, @MID }
 cmfpMin=72;              { Fonction @MIN }
 cmfpMinusc=73;           { Fonction @MINUSC, @LOWER }
 cmfpMinute=74;           { Fonction @MINUTE }
 cmfpMod=75;              { Fonction @MOD }
 cmfpMois=76;             { Fonction @MOIS }
 cmfpMoyenne=77;          { Fonction @MOYENNE }
 cmfpN=78;                { Fonction @N }
 cmfpND=79;               { Fonction @ND, @NA }
 cmfpNomPropre=80;        { Fonction @NOMPROPRE, @PROPER }
 cmfpNPer=81;             { Fonction @NPER }
 cmfpNumAHex=82;          { Fonction @NUMAHEX, @NUMTOHEX }
 cmfpPI=83;               { Fonction @PI }
 cmfpPointCell=84;        { Fonction @POINTCELL, @CELLPOINTER }
 cmfpPrincipal=85;        { Fonction @PRINCIPAL, @PPAYMT }
 cmfpProdscal=86;         { Fonction @PRODSCAL, @SUMPRODUCT }
 cmfpRacine=87;           { Fonction @RACINE, @SQRT }
 cmfpRad=88;              { Fonction @RAD, @RADIANS }
 cmfpRemb=89;             { Fonction @REMB }
 cmfpRembour=90;          { Fonction @REMBOUR, @PMT de Quattra Pro }
 cmfpRepete=91;           { Fonction @REPETE, @REPEAT }
 cmfpSeconde=92;          { Fonction @SECONDE, @SECOND }
 cmfpSi=93;               { Fonction @SI, @IF }
 cmfpSin=94;              { Fonction @SIN, SIN }
 cmfpSomme=95;            { Fonction @SOMME, @SUM }
 cmfpStd=96;              { Fonction @STD }
 cmfpStds=97;             { Fonction @STDS }
 cmfpSubstitue=98;        { Fonction @SUBSTITUE, @REPLACE }
 cmfpSupprEspace=99;      { Fonction @SUPPRESPACE, @TRIM }
 cmfpTan=100;             { Fonction @TAN }
 cmfpTaux=101;            { Fonction @TAUX, @RATE }
 cmfpTauxInt=102;         { Fonction @TAUXINT, @IRATE }
 cmfpTemps=103;           { Fonction @TEMPS, @TIME }
 cmfpVact=104;            { Fonction @VACT, @PVAL }
 cmfpValact=105;          { Fonction @VALACT, @PV }
 cmfpValeur=106;          { Fonction @VALEUR }
 cmfpValeurOption=107;    { Fonction @VALEUROPTION, @CURVALUE }
 cmfpValFut=108;          { Fonction @VALFUT, @FV }
 cmfpVan=109;             { Fonction @VAN, @NPV }
 cmfpVar=110;             { Fonction @VAR }
 cmfpVars=111;            { Fonction @VARS }
 cmfpVersion=112;         { Fonction @VERSION }
 cmfpVFut=113;            { Fonction @VFUT, @FVAL }
 cmfpVrai=114;            { Fonction @VRAI, @TRUE }
 cmfpACosH=117;           { Fonction ACOSH }
 cmfpAdresse=118;         { Fonction ADRESSE }
 cmfpAleaEntreBornes=119; { Fonction ALEA.ENTRE.BORNES }
 cmfpASinH=126;           { Fonction ASINH }
 cmfpATanH=127;           { Fonction ATANH }
 cmfpBin2Dec=145;         { Fonction BIN2DEC, BINDEC }
 cmfpBin2Hex=146;         { Fonction BIN2HEX, BINHEX }
 cmfpBin2Oct=147;         { Fonction BIN2OCT, BINOCT }
 cmfpColonne=156;         { Fonction COLONNE }
 cmfpCombin=158;          { Fonction COMBIN }
 cmfpACotH=159;           { Fonction ACOTH (ArcCotH non-supportÇ par Excel)}
 cmfpASecH=160;           { Fonction ASECH (ArcSecH non-supportÇ par Excel)}
 cmfpACscH=161;           { Fonction ACSCH (ArcCscH non-supportÇ par Excel)}
 cmfpCotH=162;            { Fonction COTH (CotanH non-supportÇ par Excel)}
 cmfpEcartTypeP=163;      { Fonction ECARTYPEP }
 cmfpVarP=164;            { Fonction VAR.P }
 cmfpLoiBinomiale=165;    { Fonction LOI.BINOMIALE }
 cmfpLoiPoisson=166;      { Fonction LOI.POISSON }
 cmfpLoiNormaleStandard=167;{ Fonction LOI.NORMALE.STANDARD }
 cmfpInfo=168;            { Fonction INFO }
 cmfpLigne=169;           { Fonction LIGNE }
 cmfpLog=170;             { Fonction LOG }
 cmfpFact=171;            { Fonction @FACT (factorielle) }
 cmfpFactLn=172;          { Fonction @FACTLN (factorielle logarithmique naturel)}
 cmfpACot=173;            { Fonction @ACOT}
 cmfpLoiKhiDeux=174;      { Fonction LOI.KHIDEUX }
 cmfpLoiStudent=175;      { Fonction LOI.STUDENT }
 cmfpProduit=176;         { Fonction PRODUIT }
 cmfpMediane=177;         { Fonction MEDIANE }
 cmfpEstImpair=178;       { Fonction EST.IMPAIR }
 cmfpEstPair=179;         { Fonction EST.PAIR }
 cmfpLnGamma=180;         { Fonction LnGamma }
 cmfpLoiGammaInverse=181; { Fonction LOI.GAMMA.INVERSE }
 cmfpLoiGamma=182;        { Fonction LOI.GAMMA }
 cmfpCosH=183;            { Fonction @COSH }
 cmfpSinH=184;            { Fonction @SINH }
 cmfpSecH=185;            { Fonction @SECH }
 cmfpTanH=186;            { Fonction @TANH }
 cmfpCot=187;             { Fonction @COT }

  {Type d'enregistrement d'Excel }
 xltDimensions=$00;
 xltBlank=$01;
 xltInteger=$02;
 xltNumber=$03;
 xltLabel=$04;
 xltBoolErr=$05;
 xltFormula=$06;
 xltString=$07;
 xltROW=$08;
 xltBOF=$09;
 xltEOF=$0A;
 xltIndex=$0B;
 xltCalcCount=$0C;
 xltCalcMode=$0D;
 xltPrecision=$0E;
 xltRefMode=$0F;
 xltDelta=$10;
 xltIteration=$11;
 xltProtect=$12;
 xltPassword=$13;
 xltHeader=$14;
 xltFooter=$15;
 xltExternCount=$16;
 xltExternSheet=$17;
 xltName=$18;
 xltWindowProtect=$19;
 xltVerticalPageBreaks=$1A;
 xltHorizontalPageBreaks=$1B;
 xltNote=$1C;
 xltSelection=$1D;
 xltFormat=$1E;
 xltFormatCount=$1F;
 xltColumnDefault=$20;
 xltArray=$21;
 xlt1904=$22;
 xltExternName=$23;
 xltColWidth=$24;
 xltDefaultRowHeight=$25;
 xltLeftMargin=$26;
 xltRightMargin=$27;
 xltTopMargin=$28;
 xltBottomMargin=$29;
 xltPrintRowHeaders=$2A;
 xltPrintGridLines=$2B;
 xltFilePass=$2F;
 xltFont=$31;
 xltFont2=$32;
 xltTable=$36;
 xltTable2=$37;
 xltContinue=$3C;
 xltWindow1=$3D;
 xltWindow2=$3E;
 xltBackup=$40;
 xltPane=$41;

Type
 DataMGCIdRec=Record
  Col,Row:LongInt;
  H:CelluleHeader;
  Size:Word;
 End;

 TabCoef=Array[0..9]of Real;

  (**********************)
  (* Format Lotus 1-2-3 *)
  (**********************)

  {Entàte d'un fichier Lotus 1-2-3 }
 HeaderLotus123=Record
  TypeCode:Integer;      { Code d'identification = 0 }
  Length:Integer;        { Longueur des donnÇes  = 2 }
  Value:Integer;         { Valeur                = 1030 }
 End;

  {Texte d'un fichier Lotus 1-2-3}
 LabelLotus123=Record
  TypeCode:Integer;          { Code d'identification = 15 }
  Length:Integer;            { Longueur des donnÇes }
  Format:Byte;               { Format }
  Column:Integer;            { Colonne }
  Row:Integer;               { Ligne }
  Text:Array[0..239]of Char; { Texte }
 End;

  {Entier d'un fichier Lotus 1-2-3 }
 IntegerLotus123=Record
  TypeCode:Integer;          { Code d'identification = 13 }
  Length:Integer;            { Longueur des donnÇes }
  Format:Byte;               { Format }
  Column:Integer;            { Colonne }
  Row:Integer;               { Ligne }
  Value:Integer;             { Valeur }
 End;

  {Entier d'un fichier Lotus 1-2-3 }
 DoubleLotus123=Record
  TypeCode:Integer;          { Code d'identification = 13 }
  Length:Integer;            { Longueur des donnÇes }
  Format:Byte;               { Format }
  Column:Integer;            { Colonne }
  Row:Integer;               { Ligne }
  Value:Double;              { Valeur }
 End;

  {Fin d'un fichier Lotus 1-2-3 }
 EndLotus123=Record
  TypeCode:Integer;      { Code d'identification = 1 }
  Length:Integer;        { Longueur des donnÇes  = 0 }
 End;

  (**********************)
  (*    Format Excel    *)
  (**********************)

   { Attribut de la cellule de format Excel }
  rgbAttrExcel=Record
   Propriety:Byte;       { PropriÇtÇ de la cellule }
   FormatNFont:Byte;     { Format de la cellule et numÇro de la police }
   Facing:Byte;          { EsthÇtisme de la cellule }
  End;

  {ÆBOFØ d'un fichier }
 BOFExcel=Record
  TypeCode:Integer;      { Code d'identification }
  Length:Integer;        { Longueur des donnÇes }
  Version:Word;
  DocumentType:Word;
  Data:Word;
 End;

  {ÆDimensionØ d'un fichier }
 DimensionExcel=Record
  TypeCode:Integer;      { Code d'identification }
  Length:Integer;        { Longueur des donnÇes }
  Row1:Integer;
  Column1:Integer;
  Row2:Integer;
  Column2:Integer;
 End;

  {ÆBlankØ d'un fichier }
 BlankExcel=Record
  TypeCode:Integer;      { Code d'identification }
  Length:Integer;        { Longueur des donnÇes }
  Row:Integer;
  Column:Integer;
  rgbAttr:rgbAttrExcel;
 End;

  {ÆIntegerØ d'un fichier Excel }
 IntegerExcel=Record
  TypeCode:Integer;      { Code d'identification = 2 }
  Length:Integer;        { Longueur des donnÇes  = 9 }
  Row:Integer;
  Column:Integer;
  rgbAttr:rgbAttrExcel;
  Value:Word;
 End;

  {ÆNumberØ d'un fichier Excel }
 NumberExcel=Record
  TypeCode:Integer;      { Code d'identification }
  Length:Integer;        { Longueur des donnÇes }
  Row:Integer;
  Column:Integer;
  rgbAttr:rgbAttrExcel;
  Value:Double;
 End;

  {ÆLabelØ d'un fichier Excel }
 LabelExcel=Record
  TypeCode:Integer;      { Code d'identification }
  Length:Integer;        { Longueur des donnÇes }
  Row:Integer;
  Column:Integer;
  rgbAttr:rgbAttrExcel;
  Value:String;
 End;

  {ÆBoolErrØ d'un fichier Excel }
 BoolErrExcel=Record
  TypeCode:Integer;      { Code d'identification }
  Length:Integer;        { Longueur des donnÇes }
  Row:Integer;
  Column:Integer;
  rgbAttr:rgbAttrExcel;
  Value:Byte;
  Error:Boolean;
 End;

  {ÆFormulaØ d'un fichier Excel }
 FormulaExcel=Record
  TypeCode:Integer;      { Code d'identification }
  Length:Integer;        { Longueur des donnÇes }
  Row:Integer;
  Column:Integer;
  rgbAttr:rgbAttrExcel;
  Result:Record Case Byte of
   0:(Dbl:Double);
  End;
  LengthParser:Byte;
 End;

  {ÆEOFØ d'un fichier }
 EOFExcel=Record
  TypeCode:Integer;      { Code d'identification }
  Length:Integer;        { Longueur des donnÇes }
 End;

IMPLEMENTATION

END.