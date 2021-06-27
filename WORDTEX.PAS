Unit WordTex;

INTERFACE

Const
  { Les diff‚rents format de fichier WordPerfect (FileType) }
 wpMacroFile=$01;               { Fichier de macro WordPerfect }
 wpWordPerfectHelp=$02;         { Fichier d'aide WordPerfect }
 wpKeyboardDefinition=$03;      { D‚finition clavier }
 wpDocumentFile=$0A;            { Document WordPerfect }
 wpDictionaryFile=$0B;          { Fichier dictionnaire }
 wpThesaurusFile=$0C;
 wpBlock=$0D;
 wpRectangularBlock=$0E;
 wpColumnBlock=$0F;
 wpPrinterResourceFile=$10;     { Ressource d'impression (PRS) }
 wpSetupFile=$11;               { Fichier de configuration }
 wpPrefixInformationFile=$12;
 wpPrinterResourceFileAll=$13;  { ALL }
 wpDisplayResourceFile=$14;     { DRS }
 wpOverlayFile=$15;             { Fichier de recouvrement (WP.FIL) }
 wpGraphicsFile=$16;            { Fichier graphique de WordPerfect (WPG) }
 wpHyphenationCodeModule=$17;
 wpHyphenationDataModule=$18;
 wpMacroResourceFile=$19;       { Ressource de macro (MRS) }
 wpGraphicsDriver=$1A;          { Pilote pour WordPerfect (WPD) }
 wpHyphenationLexModule=$1B;

  { Type de document de Microsoft Word }
 mwWordText=0;                  { Texte Microsoft Word }
 mwTextBuildingBlock=1;         { Texte construit en bloc }
 mwPrinterDescriptionFile=2;    { Fichier de description d'impression }

  { Type de caractŠres de document WordStar (TypeStyle) }
 wstsLinePrinter=0;       { Impression en ligne }
 wstsPica=1;              { Pica }
 wstsElite=2;             { Elite }
 wstsCourier=3;           { Courrier }
 wstsHelv=4;              { Pour aussi le "Helvetica", "CG Triumvirate", et suisse }
 wstsTmsRmn=5;            { Pour aussi "CG Times", "Times Roman" et allemand }
 wstsGothic=6;            { Peut aussi ˆtre 130 pour les lettres Gothique }
 wstsScript=7;            { Scripte }
 wstsPrestige=8;          { Peut aussi ˆtre 48 pour le Elite Prestige }
 wstsCaslon=9;            { Caslon }
 wstsOrator=10;           { Orateur }
 wstsPresentations=11;    { Pr‚sentations }
 wstsHelvCond=12;         { Peut ˆtre aussi du Suisse condens‚ }
 wstsSerifa=13;
 wstsBlippo=14;
 wstsWindsor=15;
 wstsCentury=16;
 wstsZapfHumanist=17;
 wstsGaramond=18;
 wstsCooper=19;
 wstsCoronet=20;
 wstsBroadway=21;
 wstsBodoni=22;
 wstsCntrySchlbk=23;
 wstsUnivRoman=24;
 wstsHelvOutline=25;
 wstsPeignot=26;          { Aussi Exotique }
 wstsClarendon=27;
 wstsStick=28;
 wstsHPGLDrafting=29;
 wstsHPGLSpline=30;
 wstsTimes=31;
 wstsHPLJSoftFont=32;
 wstsBorders=33;
 wstsUncleSamOpen=34;
 wstsRaphael=35;
 wstsUncial=36;
 wstsManhattan=37;
 wstsDomCasual=38;
 wstsOldEnglish=39;
 wstsTriumCondensed=40;
 wstsTriumUltraComp=41;
 wstsTradeExtraCond=42;
 wstsAmericanClassic=43;  { Aussi Amerigo}
 wstsGlobeGothicOutline=44;
 wstsUniversCondensed=45; { Aussi Zurich Condens‚ }
 wstsUnivers=46;          { Aussi Zurich }
 wstsTmsRmnCond=47;       { Oki Laserline 6 }
 wstsPrstElite=48;        { Voir aussi #8 pour Prestige }
 wstsOptima=49;
 wstsAachen=50;           { Postscript }
 wstsAmTypewriter=51;
 wstsAvantGarde=52;
 wstsBenguiat=53;
 wstsBrushScript=54;
 wstsCarta=55;
 wstsCentennial=56;
 wstsCheltenham=57;
 wstsFranklinGothic=58;
 wstsFrstyleScrpt=59;
 wstsFrizQuadrata=60;
 wstsFutura=61;
 wstsGalliard=62;
 wstsGlypha=63;
 wstsGoudy=64;
 wstsHobo=65;
 wstsLubalinGraph=66;
 wstsLucida=67;
 wstsLucidaMath=68;
 wstsMachine=69;
 wstsMelior=70;           { Aussi Zapf Elliptical }
 wstsNewBaskrvlle=71;     { Aussi Baskerville }
 wstsNewCntSchlbk=72;
 wstsNewsGothic=73;       {Aussi "Trade Gothic" }
 wstsPalatino=74;         {Aussi "Zapf Calligraphic"}
 wstsParkAvenue=75;
 wstsRevue=76;
 wstsSonata=77;
 wstsStencil=78;
 wstsSouvenir=79;
 wstsTrmpMedievel=80;     { Aussi Activa }
 wstsZapfChancery=81;
 wstsZapfDingbats=82;
 wstsStone=83;
 wstsCntryOldStyle=84;
 wstsCorona=85;
 wstsGoudyOldStyle=86;
 wstsExcelsior=87;
 wstsFuturaCondensed=88;
 wstsHelvCompressed=89;
 wstsHelvExtraCompressed=90;
 wstsHelvNarrow=91;
 wstsHelvUltraCompressed=92;
 wstsKorinnaKursiv=93;
 wstsLucidaSans=94;
 wstsMemphis=95;
 wstsStoneInformal=96;
 wstsStoneSans=97;
 wstsStoneSerif=98;
 wstsPostscript=99;
 wstsNPSUtility=100;
 wstsNPSDraft=101;
 wstsNPSCorr=102;
 wstsNPSSansSerQual=103;
 wstsNPSSerifQual=104;
 wstsPSUtility=105;
 wstsPSDraft=106;
 wstsPSCorr=107;
 wstsPSSansSerQual=108;
 wstsPSSerifQual=109;
 wstsDownload=110;
 wstsNPSECSQual=111;
 wstsPSPlastic=112;
 wstsPSMetal=113;
 wstsCloisterBlack=114;
 wstsGillSans=115;        { Aussi Hammersmith }
 wstsRockwell=116;        { Aussi Slate}
 wstsTiffany=117;         { ITC }
 wstsClearface=118;
 wstsAmelia=119;
 wstsHandelGothic=120;
 wstsOratorSC=121;
 wstsOutline=122;         { Toshiba }
 wstsBookmanLight=123;    { Canon }
 wstsHumanist=124;        { Canon }
 wstsSwissNarrow=125;     { Canon }
 wstsZapfCalligraphic=126;{ Canon }
 wstsSpreadsheet=127;     { Quadlaser }
 wstsBroughm=128;         { Les imprimantes Brother }
 wstsAnelia=129;          { Les imprimantes Brother }
 wstsLtrGothic=130;       { Aussi d‚finie pour le Brother }
 wstsBoldface=131;        { Boldface PS }
 wstsHighDensity=132;     { NEC }
 wstsHighSpeed=133;       { NEC }
 wstsSuperFocus=134;      { NEC P2200 }
 wstsSwissOutline=135;    { Cordata }
 wstsSwissDisplay=136;    { Cordata }
 wstsMomentoOutline=137;  { Cordata }
 wstsCourierItalic=138;   { TI 855 }
 wstsTextLight=139;       { Cordata }
 wstsMomentoHeavy=140;    { Cordata }
 wstsBarCode=141;
 wstsEANUPC=142;
 wstsMath7=143;           { HPLJ }
 wstsMath8=144;           { HPLJ }
 wstsSwiss=145;
 wstsDutch=146;
 wstsTrend=147;           { Nissho }
 wstsHolsatia=148;        { Qume Laser }
 wstsSerif=149;           { IBM Pageprinter }
 wstsBandit=150;          { Cordata }
 wstsBookman=151;         { Cordata }
 wstsCasual=152;          { Cordata }
 wstsDot=153;             { Cordata }
 wstsEDP=154;             { Epson GQ3500 }
 wstsExtGraphics=155;     { Epson GQ3500 }
 wstsGarland=156;         { Canon Laser }
 wstsPCLine=157;
 wstsHPLine=158;
 wstsHamilton=159;        { QMS }
 wstsKorinna=160;         { Cordata }
 wstsLineDrw=161;         { QMS }
 wstsModern=162;
 wstsMomento=163;         { Cordata }
 wstsMX=164;              { Cordata }
 wstsPC=165;              { Cordata }
 wstsPI=166;
 wstsProfile=167;         { Quadlaser }
 wstsQFmt=168;            { QMS }
 wstsRule=169;            { Cordata }
 wstsSB=170;              { Cordata }
 wstsTaylor=171;          { Cordata }
 wstsText=172;            { Cordata }
 wstsAPL=173;
 wstsArtisan=174;
 wstsTriumvirate=175;
 wstsChart=176;
 wstsClassic=177;
 wstsData=178;
 wstsDocument=179;
 wstsEmperor=180;
 wstsEssay=181;
 wstsForms=182;
 wstsFacet=183;
 wstsMicro=184;           { Aussi Microstyle, Eurostyle }
 wstsOCRA=185;
 wstsOCRB=186;
 wstsApollo=187;          { Blaser }
 wstsMath=188;
 wstsScientific=189;
 wstsSonoran=190;         { IBM Pageprinter }
 wstsSquare3=191;
 wstsSymbol=192;
 wstsTempora=193;
 wstsTitle=194;
 wstsTitan=195;
 wstsTheme=196;
 wstsTaxLineDraw=197;
 wstsVintage=198;
 wstsXCP=199;
 wstsEletto=200;          { Olivetti }
 wstsEstElite=201;        { Olivetti }
 wstsIdea=202; 	          { Olivetti }
 wstsItalico=203;         { Olivetti }
 wstsKent=204;            { Olivetti }
 wstsMikron=205;          { Olivetti }
 wstsNotizia=206;         { Olivetti }
 wstsRoma=207;            { Olivetti }
 wstsPresentor=208;       { Olivetti }
 wstsVictoria=209;        { Olivetti }
 wstsDraftItalic=210;     { Olivetti }
 wstsPSCapita=211;        { Olivetti }
 wstsQualItalic=212;      { Olivetti }
 wstsAntiqueOlive=213;    { Aussi Province }
 wstsBauhaus=214;         { ITC }
 wstsEras=215;            { ITC }
 wstsMincho=216;
 wstsSerifGothic=217;     { ITC }
 wstsSignetRoundhand=218;
 wstsSouvenirGothic=219;
 wstsStymie=220;          { ATF }
 wstsBernhardModern=221;
 wstsGrandRondeScript=222;
 wstsOndine=223;          { Aussi Mermaid }
 wstsPTBarnum=224;
 wstsKaufmann=225;
 wstsBolt=226;            { ITC }
 wstsAntOliveCompact=227; { Aussi Province compacte }
 wstsGarthGraphic=228;
 wstsRonda=229;           { ITC }
 wstsEngShcreibschrift=230;
 wstsFlash=231;
 wstsGothicOutline=232;   { URW }
 wstsAkzidenzGrotesk=233;
 wstsTDLogos=234;
 wstsShannon=235;
 wstsOberon=236;
 wstsCallisto=237;
 wstsCharter=238;
 wstsPlantin=239;
 wstsHelveticaBlack=240;  { PS }
 wstsHelveticaLight=241;  { PS }
 wstsArnoldBocklin=242;   { PS }
 wstsFetteFraktur=243;    { PS }
 wstsGreek=244;           { PS (Grecque Universel) }

Type
  {Entˆte de fichier ®Professionnel Write¯}
 PWHeader=Record
  NumYTexts,                     { Nombre de ligne texte par page }
  Y1,EndPageMargeY:Word;         { Marge du haut et du bas }
  Res1:Array[6..9]of Byte;       { R‚serv‚s }
  X1,X2:Word;                    { Marge de gauche et droite }
  Res3:Array[14..639]of Byte;    { R‚serv‚s }
  Sign:String[6];                { Signature: "TYPE 3" }
 End;

  {Structure de fichier .PFS (format PFS1) fichier de
   description du ®Professionnel Write¯}
 PFS1=Record
  Name:String[12];               { Nom du fichier }
  Res:Byte;                      { R‚serv‚ }
  Descr:String[43];              { Description }
 End;

  {Entˆte du traitement de texte ®Premier Choix¯}
 FirstChoiceHeader=Record
  X1,X2:Word;                    { Marge de gauche et de droite }
  NumLetters:Word;               { Nombre de lettre contenu dans le document }
  NumLine:Word;                  { Nombre de ligne }
  Sign:String[12];               { Signature: "GERBILDOC   " }
  ResB:Byte;                     { R‚serv‚s }
  MargeUp,MargeDn:Word;          { Marge du haut et du bas }
  PageLen:Word;                  { Longueur de la page }
  ResC:Array[28..511]of Byte;    { R‚serv‚s }
   { Suit les donn‚es de fichiers: }
  { CaractŠre (bit 0 … 6)
              Si bit 7 = 1 alors
                 Si bit 0 caractŠre suivant = 1 alors soulignement
                 Si bit 1 caractŠre suivant = 1 alors gras
                 Si bit 2 caractŠre suivant = 1 alors italique
                 Si bit 3 caractŠre suivant = 1 alors CaractŠre bit 7 <- 1
              Fin Si}
 End;

  {Entˆte de fichier WordPerfect }
 WordPerfectHeader=Record
  Sign:Array[0..3]of Char;       { Signature: #$FF'WPC' }
  ResA:Array[0..3]of Byte;       { R‚serv‚s }
  ID:Byte;                       { Identificateur = 1}
  FileType:Byte;                 { Type de fichier WordPerfect (wp???) }
 End;

  {Entˆte de fichier Microsoft Word, Microsoft Office, Windows Write }
 MicrosoftWordHeader=Record
  ID:Word;                       { Identificateur 031BEh }
  DocumentType:Byte;             { Type de document (mw???)}
  ResA:Byte;                     { R‚serv‚ (toujours 0)}
  Version:Word;                  { Version??? (AB00h) }
  ResB:Word;                     { R‚serv‚ (0) }
  TextBytes:LongInt;
  ParagraphInfo:Word;
  FootNoteTable:Word;
  SectionProperty:Word;
  SectionTable:Word;
  PageTable:Word;
  StyleSheetPath:Array[0..63]of Char;
  WindowsWritePageCount:Word;    { Nombre de pages sous Windows Write }
  PrinterName:Array[0..7]of Char;{ MS Word / WinWord seulement }
  MSWordPageCount:Word;
  DocumentProperties:Array[0..7]of Char;
  WordVersionFile:Byte;
  AutoSaveFlag:Boolean;
  Word5PageTable:Word;
  MacBkmk:Word;
  OffsetFileName4AutoSave:Word;
  RunningHeadTable:Word;
  CodePage:Word;                 { Code de page utilis‚ pour le document }
 End;

IMPLEMENTATION

END.