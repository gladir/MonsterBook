{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                 Malte Genesis/Gestionnaire d'Impression              Û
 ³            dition Chantal pour Mode R‚el/IV - Version 1.0           Û
 ³                               1996/10/10                             Û
 ³                                                                      Û
 ³         Tous droits r‚serv‚s par les Chevaliers de Malte (C)         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Nom des programmeurs
 ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

  Sylvain Maltais


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette unit‚ est r‚serv‚e pour  les  d‚finitions  des imprimantes
 connectable sur un PC et leur m‚thode d'exploitation de ceux-ci.


 Remarque
 ÍÍÍÍÍÍÍÍ

  ş Afin de permettre au moins une lisibilit‚ du texte advenant un
    incompatibilit‚ de l'imprimante,  il est possible de n'envoyer
    que la partie texte  d'un document  par exemple  en sp‚cifiant
    tout  simplement  ®pnNone¯ …  l'imprimante sp‚cifier et aucune
    accentuation du texte ne sera donc possible.
}

Unit Pritex;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                             INTERFACE
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

{$I DEF.INC}

Uses Systex;

Const
 {Les diff‚rents modŠle d'imprimante}
 pnNone=0;{Nom inconnu,absent}
 pnBrotherM1209=1;{Brother M1209}
 pnBrotherM1224=2;{Brother M1224}
 pnBrotherM2518=3;{Brother M2518}
 pnBrotherM2524L=4;{Brother M2524L}
 pnBrotherM3524L=5;{Brother M3524L}
 pnBrotherM4018=6;{Brother M4018}
 pnCItohC310=7;{C.Itoh C310}
 pnCItohC315=8;{C.Itoh C315}
 pnCItohC510=9;{C.Itoh C510}
 pnCItohC510Plus=10;{C.Itoh C510+}
 pnCItohC545=11;{C.Itoh C545}
 pnCItohC715A=12;{C.Itoh C715A}
 pnCItohC815=13;{C.Itoh C815}
 pnCItohCI2500=14;{C.Itoh CI2500}
 pnCItohM1209=15;{C.Itoh M1209}
 pnCItohM1224=16;{C.Itoh M1224}
 pnCItohM2518=17;{C.Itoh M2518}
 pnCItohM2524L=18;{C.Itoh M2524L}
 pnCItohM4018=19;{C.Itoh M4018}
 pnCItohSuperRillman=20;{C.Itoh Super Rillman}
 pnCitizen120D=21;{Citizen 120D}
 pnCitizen120DPlus=22;{Citizen 120D+}
 pnCitizenMSP40=23;{Citizen MSP40}
 pnCitizenMSP45=24;{Citizen MSP45}
 pnCitizenMSP50=25;{Citizen MSP50}
 pnCitizenMSP55=26;{Citizen MSP55}
 pnCitizen124D=27;{Citizen 124D}
 pnCitizenHQP45=28;{Citizen HQP45}
 pnCitizenProdot24=29;{Citizen Prodot 24}
 pnCitizenProdot9_9X=30;{Citizen Prodot 9 9X}
 pnCititzenSwift9=31;{Citizen Swift 9}
 pnEpsonDFX5000=32;{Epson DFX5000}
 pnEpsonDFX8000=33;{Epson DFX8000}
 pnEpsonDLQ2000=34;{Epson DLQ2000}
 pnEpsonFX85=35;{Epson FX85}
 pnEpsonFX800=36;{Epson FX800}
 pnEpsonFX850=37;{Epson FX850}
 pnEpsonFX1000=38;{Epson FX1000}
 pnEpsonFX1050=39;{Epson FX1050}
 pnEpsonLQ400=40;{Epson LQ400}
 pnEpsonLQ550=41;{Epson LQ550}
 pnEpsonLQ850=42;{Epson LQ850}
 pnEpsonLQ850Plus=43;{Epson LQ850+}
 pnEpsonLQ860=44;{Epson LQ860}
 pnEpsonLQ1050=45;{Epson LQ1050}
 pnEpsonLQ1060=46;{Epson LQ1060}
 pnEpsonLQ2550=47;{Epson LQ2550}
 pnEpsonLX400=48;{Epson LX400}
 pnEpsonLX850=49;{Epson LX850}
 pnFujitsuDL1100=50;{Fujitsu DL1100}
 pnFujitsuDX3300=51;{Fujitsu DX3300}
 pnFujitsuDL3400=52;{Fujitsu DL3400}
 pnFujitsuDL4400=53;{Fujitsu DL4400}
 pnFujitsuDL4600=54;{Fujitsu DL4600}
 pnFujitsuDL5600=55;{Fujitsu DL5600}
 pnFujitsuDX2150=56;{Fujitsu DX2150}
 pnFujitsuDX2250=57;{Fujitsu DX2250}
 pnHPLaserJet=58;{HP LaserJet}
 pnIBM4201003=59;{IBM 420 1003}
 pnIBM4202003=60;{IBM 420 2003}
 pnIBM4202007=61;{IBM 420 2007}
 pnIBM4208002=62;{IBM 420 8002}
 pnIBM5204001=63;{IBM 520 4001}
 pnMannMT81=64;{Mann MT81}
 pnMannMT90=65;{Mann MT90}
 pnMannMT91=66;{Mann MT91}
 pnMannMT130_9=67;{Mann MT130 9}
 pnMannMT130_24=68;{Mann MT130 24}
 pnMannMT131_9=69;{Mann MT131 9}
 pnMannMT131_24=70;{Mann MT131 24}
 pnMannMT230_9=71;{Mann MT230 9}
 pnMannMT230_18=72;{Mann MT230 18}
 pnMannMT230_24=73;{Mann MT230 24}
 pnMannMT290=74;{Mann MT290}
 pnMannMT330=75;{Mann MT330}
 pnMannMT340=76;{Mann MT340}
 pnMannMT460=77;{Mann MT460}
 pnMannMT490=78;{Mann MT490}
 pnNECP2Plus=79;{NEC P2+}
 pnNECP6=80;{NEC P6}
 pnNECP6Plus=81;{NEC P6+}
 pnNECP7=82;{NEC P7}
 pnNECP7Plus=83;{NEC P7+}
 pnNECP20=84;{NEC P20}
 pnNECP30=85;{NEC P30}
 pnNECP60=86;{NEC P60}
 pnNECP70=87;{NEC P70}
 pnNECP90=88;{NEC P90}
 pnNECP2200=89;{NEC P2200}
 pnOkiML182=90;{Oki Systems ML182}
 pnOkiML183=91;{Oki Systems ML183}
 pnOkiML192Elite=92;{Oki Systems ML192}
 pnOkiML193Elite=93;{Oki Systems ML193 Elite}
 pnOkiML292=94;{Oki Systems ML292}
 pnOkiML293Elite=95;{Oki Systems ML293 Elite}
 pnOkiML294=96;{Oki Systems ML294}
 pnOkiML320=97;{Oki Systems ML320 }
 pnOkiML320Elite=98;{Oki Systems ML320 Elite}
 pnOkiML380=99;{Oki Systems ML380}
 pnOkiML390=100;{Oki Systems ML390}
 pnOkiML391=101;{Oki Systems ML391}
 pnOkiML393=102;{Oki Systems ML393}
 pnOkimate20=103;{Oki Systems Okimate 20}
 pnPanasonicKX1081=104;{Panasonic KX 1081}
 pnPanasonicKX1180=105;{Panasonic KX 1180}
 pnPanasonicKX1123=106;{Panasonic KX 1123}
 pnPanasonicKX1124=107;{Panasonic KX 1124}
 pnPanasonicKX1624=108;{Panasonic KX 1624}
 pnPanasonicKX1695=109;{Panasonic KX 1695}
 pnRolandDGPR1215=110;{Roland Digital Groupe PR-1215}
 pnRolandDGPR2417=111;{Roland Digital Groupe PR-2417}
 pnSeikoshaBP5420FA=112;{Seikosha BP 5420 FA}
 pnSeikoshaBP5500=113;{Seikosha BP 5500}
 pnSeikoshaMP1300AI=114;{Seikosha MP 1300 AI}
 pnSeikoshaMP5300AI=115;{Seikosha MP 5300 AI}
 pnSeikoshaSBP10AI=116;{Seikosha SBP 10 AI}
 pnSeikoshaSL80IP=117;{Seikosha SL80 IP}
 pnSeikoshaSL92=118;{Seikosha SL92}
 pnSeikoshaSL130AI=119;{Seikosha SL130 AI}
 pnSeikoshaSL230AI=120;{Seikosha SL230 AI}
 pnSeikoshaSL532=121;{Seikosha SL 532}
 pnSeikoshaSP1600AI=122;{Seikosha SP 1600 AI}
 pnSeikoshaSP1800AI=123;{Seikosha SP 1800 AI}
 pnSeikoshaSP2000=124;{Seikosha SP 2000}
 pnStarLC10=125;{Star LC10}
 pnStarLC10LL=126;{Star LC10LL }
 pnStarLC10colour=127;{Star LC10 couleur}
 pnStarLC15=128;{Star LC15}
 pnStarLC20=129;{Star LC20}
 pnStarLC24_10=130;{Star LC24 10}
 pnStarLC24_15=131;{Star LC24 15}
 pnStarLC24_200=132;{Star LC24 200}
 pnStarLC200=133;{Star LC200}
 pnStarNB15=134;{Star NB15}
 pnStarNB24_10=135;{Star NB24 10}
 pnStarNB24_15=136;{Star NB24 15}
 pnStarND10=137;{Star ND10}
 pnStarND15=138;{Star ND15}
 pnStarNL10=139;{Star NL10}
 pnStarNR10=140;{Star NR10}
 pnStarNR15=141;{Star NR15}
 pnStarXB24_10=142;{Star XB24 10}
 pnStarXB24_15=143;{Star XB24 15 }
 pnMax=143;{Num‚ro maximal de nom d'imprimante.}
 {Sortie d'Imprimante}
 poLPT1=0;{Port ParallŠle 1}
 poLPT2=1;{Port ParallŠle 2}
 poLPT3=2;{Port ParallŠle 3}
 poLPT4=3;{Port ParallŠle 4}
 poLPT1Dos=4;{Port parallŠle 1 par le DOS}
 poLPT2Dos=5;{Port parallŠle 2 par le DOS}
 poLPT3Dos=6;{Port parallŠle 3 par le DOS}
 poLPT4Dos=7;{Port parallŠle 4 par le DOS}
 poCom1=8;{Port s‚rie 1 (Souvant utilis‚ pour la souris)}
 poCom2=9;{Port s‚rie 2}
 poCom3=10;{Port s‚rie 3}
 poCom4=11;{Port s‚rie 4}
 poCom5=12;{Port s‚rie 5}
 poCom6=13;{Port s‚rie 6}
 poCom7=14;{Port s‚rie 7}
 poCom8=15;{Port s‚rie 8}
 poFile=16;{Sortie dans un fichier}
 poNUL=$FF;{Sortie nulle,dans le vide...}
  {ModŠle de spooler d'imprimante}
 drvNoSpooler=$00;{Pas de spooler d'imprimante.}
 drvDiskSpoolII=$01;{Disk Spool II de Budget Software Company.}
 drvPrintDos=$02;{Print du Dos (Spooler de fichier)}
 drvPrintManager=$03;{PrintManager de Windows}

 {Les param‚trages des imprimantes}
 psInitIBM=ccEsc+'@';                       { Initialise IBM }
 psInitHP=#27'E'#27'(10U'#27'&k0S'#27'(s3T';{ Initialise HP LaserJet }
 psBoldIBM=ccEsc+'E';                       { CaractŠre gras IBM }
 psBoldHP=#27'(s3B';                        { CaractŠre gras HP LaserJet }
 psCmpIBM=ccEsc+Char(caSI);
 psCmpMaxIBM=ccEsc+'M'+ccEsc+Char(caSI);
 psDblIBM=ccEsc+'W1';
 psEliteModeIBM=ccEsc+'M';
 psEndOfPaperOffIBM=ccEsc+'8';
 psGrafDblIBM=ccEsc+'L';
 psInterLn1_8IBM=ccEsc+'0';
 psInterLn7_72IBM=ccEsc+'1';
 psItalicIBM='';                            { CaractŠre italique IBM }
 psItalicHP=#27'(s1S';                      { CaractŠre italique HP LaserJet }
 psItalicNEC=ccEsc+'4';                     { CaractŠre italique NEC }
 psLnIBM=ccStdLn;
 psSimpleIBM=ccEsc+'W0';
 psUnBoldIBM=ccEsc+'F';                     { CaractŠre non-gras IBM }
 psUnBoldHP=#27'(s0B';                      { CaractŠre non-gras HP LaserJet }
 psUnItalicIBM='';                          { CaractŠre non-italique IBM }
 psUnItalicHP=#27'(s0S';                    { CaractŠre non-italique HP LaserJet }
 psUnItalicNEC=ccEsc+'5';                   { CaractŠre non-italique NEC }
 psExposantIBM=ccEsc+'S'#0;
 psUnExposantIBM=ccEsc+'T';
   { Imprime un caractŠre de soulignement en passant par
     la fonction de soulignement. }
 psUnderlnChr=Chr(caEsc)+'-'#1' '+Chr(caEsc)+'-'#0;

Type
 PrnStandardEnum=(pmNONE,pmIBM,pmESCP,pmNEC);
  {Structure de gestion de l'imprimante}
 PrnSetupRec=Record
  Code:Word;              { Code du modŠle d'imprimante}
  Mode:PrnStandardEnum;   { Standard d'imprimante }
  Mem,PLen,PHeight:Word;  { M‚moire, Longueur et largeur de la page }
  ModeWM,                 { Mode machine … ‚crire }
  P2P,                    { Mode feuille … feuille }
  PrnMarge,               { Impression en marge }
  BorderPixel,            { Bordure en pixel }
  CompMode:Boolean;       { Mode compresser }
 End;

 PrnSetupType=Array[0..16]of PrnSetupRec;

 PrnRec=Record
  Init:String[3];
  Bold:String[3];
  Compress:String[3];
  CompressMax:String[4];
  Dbl:String[3];
  EliteMode:String[3];
  EndOfPaperOff:String[3];
  GrafDbl:String[3];
  InterLn1_8:String[3];
  InterLn7_72:String[3];
  Italic:String[3];
  Ln:String[2];
  Simple:String[3];
  UnBold:String[3];
  UnItalic:String[3];
  Exposant:String[3];
 End;

Const
 psPrn:PrnRec=(
  Init:psInitIBM;                   { Initialisation }
  Bold:psBoldIBM;                   { CaractŠre gras }
  Compress:psCmpIBM;                { Format compress‚ (137) }
  CompressMax:psCmpMaxIBM;          { Format super compress‚ (160) }
  Dbl:psDblIBM;                     { Format double largeur }
  EliteMode:psEliteModeIBM;         { Format Elite }
  EndOfPaperOff:psEndOfPaperOffIBM; { D‚sactive la fin de papier }
  GrafDbl:psGrafDblIBM;             { Graphique en double densit‚ }
  InterLn1_8:psInterLn1_8IBM;       { Interligne 1/8" (88 lignes) }
  InterLn7_72:psInterLn7_72IBM;     { Interligne 7/72" (113 lignes) }
  Italic:psItalicIBM;               { CaractŠre italique }
  Ln:psLnIBM;                       { Saut de ligne }
  Simple:psSimpleIBM;               { CaractŠre simple }
  UnBold:psUnBoldIBM;               { D‚sactive le caractŠre gras }
  UnItalic:psUnItalicIBM;           { D‚sactive l'italique }
  Exposant:psExposantIBM            { D‚sactive le mode exposant }
 );
 psUnExposant=psUnExposantIBM;
  {Imprimante}
 PrnSetup:PrnSetupType=(
   {LPT1: … LPT4:}
  (Code:pnNone;Mode:pmIBM;Mem:4;PLen:95;PHeight:110;ModeWM:False;P2P:False;PrnMarge:False;BorderPixel:False;CompMode:False),
  (Code:pnNone;Mode:pmESCP;Mem:4;PLen:95;PHeight:110;ModeWM:False;P2P:False;PrnMarge:False;BorderPixel:False;CompMode:False),
  (Code:pnNone;Mode:pmNONE;Mem:0;PLen:95;PHeight:110;ModeWM:False;P2P:False;PrnMarge:False;BorderPixel:False;CompMode:False),
  (Code:pnNone;Mode:pmNONE;Mem:0;PLen:95;PHeight:110;ModeWM:False;P2P:False;PrnMarge:False;BorderPixel:False;CompMode:False),
   {LPT1.DOS: … LPT4.DOS:}
  (Code:pnNone;Mode:pmIBM;Mem:4;PLen:95;PHeight:110;ModeWM:False;P2P:False;PrnMarge:False;BorderPixel:False;CompMode:False),
  (Code:pnNone;Mode:pmESCP;Mem:4;PLen:95;PHeight:110;ModeWM:False;P2P:False;PrnMarge:False;BorderPixel:False;CompMode:False),
  (Code:pnNone;Mode:pmNONE;Mem:0;PLen:95;PHeight:110;ModeWM:False;P2P:False;PrnMarge:False;BorderPixel:False;CompMode:False),
  (Code:pnNone;Mode:pmNONE;Mem:0;PLen:95;PHeight:110;ModeWM:False;P2P:False;PrnMarge:False;BorderPixel:False;CompMode:False),
   {COM1: … COM8:}
  (Code:pnNone;Mode:pmNONE;Mem:0;PLen:95;PHeight:110;ModeWM:False;P2P:False;PrnMarge:False;BorderPixel:False;CompMode:False),
  (Code:pnNone;Mode:pmNONE;Mem:0;PLen:95;PHeight:110;ModeWM:False;P2P:False;PrnMarge:False;BorderPixel:False;CompMode:False),
  (Code:pnNone;Mode:pmNONE;Mem:0;PLen:95;PHeight:110;ModeWM:False;P2P:False;PrnMarge:False;BorderPixel:False;CompMode:False),
  (Code:pnNone;Mode:pmNONE;Mem:0;PLen:95;PHeight:110;ModeWM:False;P2P:False;PrnMarge:False;BorderPixel:False;CompMode:False),
  (Code:pnNone;Mode:pmNONE;Mem:0;PLen:95;PHeight:110;ModeWM:False;P2P:False;PrnMarge:False;BorderPixel:False;CompMode:False),
  (Code:pnNone;Mode:pmNONE;Mem:0;PLen:95;PHeight:110;ModeWM:False;P2P:False;PrnMarge:False;BorderPixel:False;CompMode:False),
  (Code:pnNone;Mode:pmNONE;Mem:0;PLen:95;PHeight:110;ModeWM:False;P2P:False;PrnMarge:False;BorderPixel:False;CompMode:False),
  (Code:pnNone;Mode:pmNONE;Mem:0;PLen:95;PHeight:110;ModeWM:False;P2P:False;PrnMarge:False;BorderPixel:False;CompMode:False),
   {Fichier:}
  (Code:pnNone;Mode:pmIBM;Mem:0;PLen:95;PHeight:110;ModeWM:False;P2P:False;PrnMarge:False;BorderPixel:False;CompMode:False));
 DelSpooler:Boolean=True; { Indiquateur interdisant d'effacer le fichier d'impression (Spooler) }
 HandlePrn:Hdl=errHdl;    { Handle r‚serv‚ pour les fichiers
                            d'imprimante LPT1: par le DOS, FILE:,...}
 PrnOutput:Byte=$FF;      { Num‚ro de l'imprimante courante }

Function AssignFile2Prn(Const Str:String):Boolean;
Function DonePrn:Boolean;
Function InitPrn:Boolean;
Function Prn(Const Str:String):Boolean;
Function PrnLn:Boolean;
Function PrnStepBit(Nm:Byte):Boolean;
Function StrPrnItalic(Mode:PrnStandardEnum):String;
Function StrPrnUnItalic(Mode:PrnStandardEnum):String;
Function __SetPrnBold:Boolean;
Function __SetPrnCompress:Boolean;
Function __SetPrnDouble:Boolean;
Function __SetPrnExposant:Boolean;
Function __SetPrnInterLn1_8:Boolean;
Function __SetPrnItalic:Boolean;
Function __SetPrnNLQQuality:Boolean;
Function __SetPrnSimple:Boolean;
Function __SetPrnUnBold:Boolean;
Function __SetPrnUnExposant:Boolean;
Function __SetPrnUnItalic:Boolean;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                          IMPLEMENTATION
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses CommBase,Systems;

{ Cette fonction permet d'associer un fichier … une sortie d'impression.
}

Function AssignFile2Prn(Const Str:String):Boolean;Begin
 HandlePrn:=FileCreate(Str);
 AssignFile2Prn:=HandlePrn<>errHdl;
End;

Function DonePrn:Boolean;Begin
 If(PrnOutput)in[poLPT1Dos..poLPT4Dos,poFile]Then FileClose(HandlePrn);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                             Fonction InitPrn                            Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction initialise l'imprimante courante et retourne vrai (True) si
 l'op‚ration c'est d‚roul‚ correctement.
}

Function InitPrn:Boolean;Begin
 InitPrn:=False;
 If(PrnOutput)in[poLPT1Dos..poLPT4Dos]Then Begin
  HandlePrn:=FileCreate('LPT'+Chr(Byte('1')+PrnOutput-poLPT1Dos));
 End;
 If(PrnOutput<poFile)Then Begin
  If(PrnSetup[prnOutput].Code<>pnHPLaserJet)Then Begin
   Prn(psPrn.Init);
   If(PrnSetup[prnOutput].Code=pnRolandDGPR2417)Then Prn(#28'I1');
   If(PrnSetup[prnOutput].P2P)Then Prn(psPrn.EndOfPaperOff)
  End;
  PrnSetup[prnOutput].CompMode:=False;InitPrn:=True;
 End
  Else
 InitPrn:=True;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                               Fonction Prn                             Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction imprime sur l'imprimante la chaŒne de caractŠres sp‚cifi‚e
 et indique si l'op‚ration  c'est d‚roul‚  sans problŠme  avec sa valeur de
 sortie.


 Remarque
 ÍÍÍÍÍÍÍÍ

  ş Cette fonction  peut aussi bien  imprim‚ dans le  RS-232  que les ports
    parallŠles.   A  vous  de  v‚rifier  …  l'aide  de  la variable  global
    ®PrnOutput¯.
}

Function Prn(Const Str:String):Boolean;Begin
 {$IFDEF Win32}
 {$ELSE}
  Case(PrnOutput)of
   poLPT1..poLPT4:
   {$IFNDEF NoSpooler}
    Begin
     PushStrSpooler(Str);
     Prn:=True;
    End;
   {$ELSE}
    Prn:=Print(Str,PrnOutput);
   {$ENDIF}
   poLPT1Dos..poLPT4Dos,poFile:_SetRec(HandlePrn,Byte(Str[0]),Str[1]);
   {$IFNDEF Windows}
    poCom1..poCom8:Begin
     ACSendStr2Com(Str,PrnOutput-poCom1);
     Prn:=True;
    End;
   {$ENDIF}
  End;
 {$ENDIF}
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                               Fonction PrnLn                           Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de faire changer de ligne l'imprimante courante. Si
 l'op‚ration  c'est bien d‚roul‚,  la fonction retourne vrai  (True) sinon,
 manque de papier par exemple, faux (False).
}

Function PrnLn:Boolean;Begin
 PrnLn:=Prn(psPrn.Ln)
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Fonction PrnStepBit                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet d'imprimer une partie d'image graphique vide
 sur l'imprimante courante.
}

Function PrnStepBit(Nm:Byte):Boolean;Begin
 If Nm=0Then Exit;
 If(PrnSetup[PrnOutput].Code=pnHPLaserJet)Then
  Prn(Char(caEsc)+'*b'+Char(Nm)+'W')
  Else
 If(PrnSetup[PrnOutput].CompMode)Then Prn(psPrn.GrafDbl+Char(Nm))
                                 Else Prn(Char(caESC)+'K'+Char(Nm));
 Prn(MultChr(#0,Nm+1));
End;

Function StrPrnItalic(Mode:PrnStandardEnum):String;Begin
 Case(Mode)of
  pmNEC,pmESCP:StrPrnItalic:=psItalicNEC;
  Else StrPrnItalic:='';
 End;
End;

Function StrPrnUnItalic(Mode:PrnStandardEnum):String;Begin
 Case(Mode)of
  pmNEC,pmESCP:StrPrnUnitalic:=psUnItalicNEC;
  Else StrPrnUnitalic:='';
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                      Fonction __SetPrnCompress                   Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction fixe le format d'impression  de l'imprimante en mode
 compress‚ (137 caractŠres). Il met ‚galement … jour ces donn‚es pour
 permettre de savoir  que l'imprimante ce trouve dans ce param‚trage.
 Il retourne ensuite l'‚tat  de l'op‚ration  (Ya)  si elle c'est bien
 pass‚ et (No) s'elle c'est conclu‚e par un ‚chec.
}

Function __SetPrnCompress:Boolean;
Var
 X:Boolean;
Begin
 Case(PrnSetup[PrnOutput].Code)of
  pnNone:X:=True;
  pnHPLaserJet:X:=Prn(Chr(caEsc)+'&k2S');
  Else X:=Prn(psPrn.Compress);
 End;
 __SetPrnCompress:=X;
 If(X)Then PrnSetup[PrnOutput].CompMode:=True;
End;

Function __SetPrnBold:Boolean;Begin
 Case(PrnSetup[PrnOutput].Code)of
  pnNone:__SetPrnBold:=True;
  pnHPLaserJet:__SetPrnBold:=Prn(psBoldHP);
  Else __SetPrnBold:=Prn(psPrn.Bold);
 End;
End;

Function __SetPrnDouble:Boolean;Begin
 Case(PrnSetup[PrnOutput].Code)of
  pnNone:__SetPrnDouble:=True;
  pnHPLaserJet:__SetPrnDouble:=True;
  Else __SetPrnDouble:=Prn(psPrn.Dbl);
 End;
End;

Function __SetPrnExposant:Boolean;Begin
 Case(PrnSetup[PrnOutput].Code)of
  pnNone:__SetPrnExposant:=True;
  pnHPLaserJet:__SetPrnExposant:=True;
  Else __SetPrnExposant:=Prn(psPrn.Exposant);
 End;
End;

Function __SetPrnInterLn1_8:Boolean;Begin
 Case(PrnSetup[PrnOutput].Code)of
  pnNone:__SetPrnInterLn1_8:=True;
  pnHPLaserJet:__SetPrnInterLn1_8:=Prn(Chr(caEsc)+'&l8D');
  Else __SetPrnInterLn1_8:=Prn(psPrn.InterLn1_8);
 End;
End;

Function __SetPrnItalic:Boolean;Begin
 Case(PrnSetup[PrnOutput].Code)of
  pnNone:__SetPrnItalic:=True;
  pnHPLaserJet:__SetPrnItalic:=Prn(psItalicHP);
  Else __SetPrnItalic:=Prn(StrPrnItalic(PrnSetup[PrnOutput].Mode));
 End;
End;

Function __SetPrnNLQQuality:Boolean;Begin
 Case(PrnSetup[PrnOutput].Code)of
  pnNone:__SetPrnNLQQuality:=True;
  pnHPLaserJet:__SetPrnNLQQuality:=Prn(Chr(caEsc)+'(s8T');
  Else __SetPrnNLQQuality:=Prn(Chr(caEsc)+'I'+#2);
 End;
End;

Function __SetPrnSimple:Boolean;Begin
 Case(PrnSetup[PrnOutput].Code)of
  pnNone:__SetPrnSimple:=True;
  pnHPLaserJet:__SetPrnSimple:=True;
  Else __SetPrnSimple:=Prn(psPrn.Simple);
 End;
End;

Function __SetPrnUnBold:Boolean;Begin
 Case(PrnSetup[PrnOutput].Code)of
  pnNone:__SetPrnUnBold:=True;
  pnHPLaserJet:__SetPrnUnBold:=Prn(psUnBoldHP);
  Else __SetPrnUnBold:=Prn(psPrn.UnBold);
 End;
End;

Function __SetPrnUnExposant:Boolean;Begin
 Case(PrnSetup[PrnOutput].Code)of
  pnNone:__SetPrnUnExposant:=True;
  pnHPLaserJet:__SetPrnUnExposant:=True;
  Else __SetPrnUnExposant:=Prn(psUnExposant);
 End;
End;

Function __SetPrnUnItalic:Boolean;Begin
 Case(PrnSetup[PrnOutput].Code)of
  pnNone:__SetPrnUnItalic:=True;
  pnHPLaserJet:__SetPrnUnItalic:=Prn(psUnItalicHP);
  Else __SetPrnUnItalic:=Prn(StrPrnUnItalic(PrnSetup[PrnOutput].Mode));
 End;
End;

END.