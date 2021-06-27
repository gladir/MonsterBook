{$IFNDEF __Script}
 {$DEFINE __Script}

Const
  { Constante scripte du systŠme }
 smSystemScript=-1;  { D‚signation du scripte systŠme }
 smCurrentScript=-2; { D‚signation de la police scripte }
 smAllScripts=-3;    { D‚signation de tous scriptes }

  { Codes scripte expliqu‚ }
 smRoman=0;          { Romain }
 smJaponese=1;       { Japonais }
 smTradChinese=2;    { Chinois traditionnel }
 smKorean=3;         { Cor‚en }
 smArabic=4;         { Arabie }
 smHebrew=5;         { H‚breu }
 smGreek=6;          { Grec }
 smCyrillic=7;       { Cyrillic }
 smRSymbol=8;        { Symbole Gauche-droite }
 smDevanagari=9;     { Devanagari }
 smGurmukhi=10;      { Gurmukhi }
 smGujarati=11;      { Gujarati }
 smOriya=12;         { Oriya }
 smBengali=13;       { Bengali }
 smTamil=14;         { Tamil }
 smTelugu=15;        { Telugu }
 smKannada=16;       { Kannada/Kanarese }
 smMalayalam=17;     { Malayalam }
 smSinhalese=18;     { Sinhalese }
 smBurmese=19;       { Burmese }
 smKhmer=20;         { Khmer/Combodian }
 smThai=21;          { Thai }
 smLoatian=22;       { Loatian }
 smGeorgian=23;      { Georgian }
 smArmenian=24;      { Armenian }
 smSimpChinese=25;   { Simplified Chinese }
 smTibetan=26;       { Tib‚tain }
 smMongolian=27;     { Monogolien }
 smGeez=28;          { Geez/Ethiopic }
 smEthiopic=28;      { Synonyme pour smGeez }
 smEastEurRoman=29;  { Synonyme pour smSlavic }
 smVietnamese=30;    { Vietnamien }
 smExtArabic=31;     { Extended Arabic }
 smUninterp=32;      { Symbole non-interpr‚table, symbole de palette }

  { Langage de codes }
 langEnglish=0;          { Scripte smRoman }
 langFrench=1;           { Scripte smRoman }
 langGerman=2;           { Scripte smRoman }
 langItalian=3;          { Scripte smRoman }
 langDutch=4;            { Scripte smRoman }
 langSwedish=5;          { Scripte smRoman }
 langSpanish=6;          { Scripte smRoman }
 langDanish=7;           { Scripte smRoman }
 langPortuguese=8;       { Scripte smRoman }
 langNorwegian=9;        { Scripte smRoman }
 langHebrew=10;          { Scripte smHebrew }
 langJapanese=11;        { Scripte smJapanese }
 langArabic=12;          { Scripte smArabic }
 langFinnish=13;         { Scripte smRoman }
 langGreek=14;           { Scripte smGreek }
 langIcelandic=15;       { Scripte ‚tendu Romain }
 langMaltese=16;         { Scripte ‚tendu Romain }
 langTurkish=17;         { Scripte ‚tendu Romain }
 langCroatian=18;        { Scripte Serbo-Croatien en Romain ‚tendu }
 langTradChinese=19;     { CaractŠre en chinois traditionnel }
 langUrdu=20;            { Scripte smArabic }
 langHindi=21;           { Scripte smDevanagari }
 langThai=22;            { Scripte smThai }
 langKorean=23;          { Scripte smKorean }
 langLithuanian=24;      { Scripte smEastEurRoman }
 langPolish=25;          { Scripte smEastEurRoman }
 langHungarian=26;       { Scripte smEastEurRoman }
 langEstonian=27;        { Scripte smEastEurRoman }
 langLettish=28;         { Scripte smEastEurRoman }
 langLatvian=28;         { Synonyme de langLettish }
 langSaamisk=29;         { Scripte Romain ‚tendu }
 langLappish=29;         { Synonyme de langSaamisk }
 langFaeroese=30;        { Scripte smRoman }
 langFarsi=31;           { Scripte smArabic }
 langPersian=31;         { Synonyme de langFarsi }
 langRussian=32;         { Scripte smCyrillic }
 langSimpChinese=33;     { CaractŠre chinois simplifi‚ }
 langFlemish=34;         { Scripte smRoman }
 langIrish=35;           { Scripte smRoman }
 langAlbanian=36;        { Scripte smRoman }
 langRomanian=37;        { Scripte smEastEurRoman }
 langCzech=38;           { Scripte smEastEurRoman }
 langSlovak=39;          { Scripte smEastEurRoman }
 langSlovenian=40;       { Scripte smEastEurRoman }
 langYiddish=41;         { Scripte smHebrew }
 langSerbian=42;         { Scripte Serbo-Croatien dans smCyrillic }
 langMacedonian=43;      { Scripte smCyrillic }
 langBulgarian=44;       { Scripte smCyrillic }
 langUkrainian=45;       { Scripte smCyrillic }
 langByelorussian=46;    { Scripte smCyrillic }
 langUzbek=47;           { Scripte smCyrillic }
 langKazakh=48;          { Scripte smCyrillic }
 langAzarbaijani=49;     { Scripte Azervaijani dans smCyrillic }
 langAzerbaijanAr=50;    { Scripte Azervaijani dans smArabic (Iran) }
 langArmenian=51;        { Scripte smArmenian }
 langGeorgian=52;        { Scripte smGeorgian }
 langMoldovan=53;        { Scripte smCyrillic }
 langMoldavian=53;       { Synonyme langMoldovan }
 langKirghiz=54;         { Scripte smCyrillic }
 langTajiki=55;          { Scripte smCyrillic }
 langTurkmen=56;         { Scripte smCyrillic }
 langMongolian=57;       { Scripte Mongolien dans smMongolia }
 langMongolianCyr=58;    { Scripte Mongolien dans smCyrillic }
 langPashto=59;          { Scripte smArabic }
 langKurdish=60;         { Scripte smArabic }
 langKashmiri=61;        { Scripte smArabic }
 langSindhi=62;          { Scripte smExtArabic }
 langTibetan=63;         { Scripte smTibetan }
 langNepali=64;          { Scripte smDevanagari }
 langSanskrit=65;        { Scripte smDevanagari }
 langMarathi=66;         { Scripte smDevanagari }
 langBengali=67;         { Scripte smBengali }
 langAssamese=68;        { Scripte smAssamese }
 langGujarati=69;        { Scripte smGujarati }
 langPunjabi=70;         { Scripte smGurmukhi }
 langOriya=71;           { Scripte smOriya }
 langMalayalam=72;       { Scripte smMalayalam }
 langKannada=73;         { Scripte smKannada }
 langTamil=74;           { Scripte smTamil }
 langTelugu=75;          { Scripte smTelugu }
 langSinhalese=76;       { Scripte smSinhalease }
 langBurmese=77;         { Scripte smBurmese }
 langKhmer=78;           { Scripte smKhmer }
 langLoa=79;             { Scripte smLoatian }
 langVietnamese=80;      { Scripte smVietnamese }
 langIndonesian=81;      { Scripte smRoman }
 langTagalog=82;         { Scripte smRoman }
 langMalayRoman=83;      { Scripte "Malay" dans smRoman }
 langMalayArabic=84;     { Scripte "Malay" dans smArabic }
 langAmharic=85;         { Scripte smEthiopic }
 langTigrinya=86;        { Scripte smEthiopic }
 langGalla=87;           { Scripte smEthiopic }
 langOromo=87;           { Synonyme pour langGalla }
 langSomali=88;          { Scripte smRoman }
 langSwahili=89;         { Scripte smRoman }
 langRuanda=90;          { Scripte smRoman }
 langRundi=91;           { Scripte smRoman }
 langChewa=92;           { Scripte smRoman }
 langMalagasy=93;        { Scripte smRoman }
 langEsperanto=94;       { Scripte Romain ‚tendu }
 langWelsh=128;          { Scripte smRoman }
 langBasque=129;         { Scripte smRoman }
 langCatalan=130;        { Scripte smRoman }
 langLatin=131;          { Scripte smRoman }
 langQuechua=132;        { Scripte smRoman }
 langGuarani=133;        { Scripte smRoman }
 langAymara=134;         { Scripte smRoman }
 langTatar=135;          { Scripte smCyrillic }
 langUighur=136;         { Scripte smArabic }
 langDzongkha=137;       { Scripte smTibetan (lang de Bhutan) }
 langJavaneseRom=138;    { Scripte Javanese dans smRoman }
 langSundaneseRom=139;   { Scripte Sundanese dans smRoman }

  { Code de R‚gion }
 verUS=0;
 verFrance=1;
 verBritain=2;
 verGermany=3;
 verItaly=4;
 verNetherlands=5;
 verFrBelgiumLux=6; { Fran‡ais pour Belgique & Luxembourg }
 verSweden=7;
 verSpain=8;
 verDenmark=9;
 verPortugal=10;
 verFrCanada=11;
 verNorway=12;
 verIsrael=13;
 verJapan=14;
 verAustralia=15;
 verArabia=16;
 verArabic=16; { Synonyme pour ver Arabia }
 verFinland=17;
 verFrSwiss=18; { Suisse fran‡aise }
 verGrSwiss=19; { Suisse allemande }
 verGreece=20;
 verIceland=21;
 verMalta=22;
 verCyprus=23;
 verTurkey=24;
 verYugoCroatian=25; { SystŠme Croatien }
 verIndiaHindi=33; { SystŠme Hindi pour India }
 verPakistan=34;
 verLithunia=41;
 verPoland=42;
 verHungary=43;
 verEstonia=44;
 verLatvia=45;
 verLapland=46;
 verFaeroeIsl=47;
 verIran=48;
 verRussia=49;
 verIreland=50; { Langage l'anglais version pour Irlande }
 verKorea=51;
 verChina=52;
 verTaiwan=53;
 verThailand=54;
 minCountry=verUS;
 maxCountry=verThailand;

  { Codes de calendrier }
 calGregorian=0;
 calArabicCivil=1;
 calArabicLunar=2;
 calJapanese=3;
 calJewish=4;
 calCoptic=5;
 calPersian=6;

  { Codes de nombre }
 intWestern=0;
 intArabic=1;
 intRoman=2;
 intJapanese=3;
 intEuropean=4;
 intOutputMask=$8000;

  { Types d'octet CharacterByteType }
 smSingleByte=0;
 smFirstByte=-1;
 smLastByte=1;
 smMiddleByte=2;

  { Masque des champs CharacterType }
 smcTypeMask=$000F;
 smcReserved=$00F0;
 smcClassMask=$0F00;
 smcOrientationMask=$1000; { Scripte glyph de 2 octets d'orientation }
 smcRightMask=$2000;
 smcUpperMask=$4000;
 smcDoubleMask=$8000;

  { Simple type de caractŠre CharacterType }
 smCharPunct=$1000;
 smCharAscii=$0001;
 smCharEuro=$0007;
 smCharExtAscii=$0007; { Meilleur synonyme pour smCharEuro }

  { Types de caractŠre pour le systŠme scripte CharacterType suppl‚mentaire }
 smCharKatakana=$0002;        { Katakana Japonais }
 smCharHiragana=$0003;        { Hiragana Japonais }
 smCharIdeographic=$0004;     { Hanzi, Kanji, Hanja }
 smCharTwoByteGreek=$0005;    { 2 octets Grec dans le systŠme Est loin }
 smCharTwoByteRussian=$0006;  { 2 octets "Cyrillic" dans le systŠme Est loin }
 smCharBidirect=$0008;        { Arabe/H‚breu }
 smCharContextualLR=$0009;    { Gauche-Droite Contextual: Thai, scriptes Indic }
 smCharNonContextualLR=$000A; { Gauche-Droite Contextual: "Cyrillic", Grec }
 smCharHangul=$000C;          { Cor‚en "Hangul" }
 smCharJamo=$000D;            { Cor‚en "Jamo" }
 smCharBopomofo=$000E;        { Bopomofo de Chine (Zhuyinfuhao) }

  { Classes pour ponctuation CharacterType (smCharPunct) }
 smPunctNormal=$0000;
 smPunctNumber=$0100;
 smPunctSymbol=$0200;
 smPunctBlank=$0300;

  { Classes pour ponctuation CharacterType suppl‚mentaire dans 2 octets systŠme }
 smPunctRepeat=$0400;  { Masque de r‚p‚tition }
 smPunctGraphic=$0500; { Ligne graphiques }

  { Classes Katakana & Hiragana CharacterType pour 2 octets systŠme }
 smKanaSmall=$0100;  { Petit caractŠre Kana }
 smKanaHardOk=$0200; { Peut avoir dakuten }
 smKanaSoftOk=$0300; { Peut avoir dakuten ou han-dakuten }

  { Classes Ideographique CharacterType pour 2 octets systŠme }
 smIdeographicLevel1=$0000; { CaractŠre niveau 1 }
 smIdeographicLevel2=$0100; { CaractŠre niveau 2 }
 smIdeographicUser=$0200;   { CaractŠre utilisateur }

  { Classes Jamo CharacterType pour le systŠme Cor‚en }
 smJamoJaeum=$0000;    { CaractŠre simple consone }
 smJamoBogJaeum=$0100; { CaractŠre compexe consone }
 smJamoMoeum=$0200;    { CaractŠre simple voyelle }
 smJamoBogMoeum=$0300; { CaractŠre complexe voyelle }

  { Orientation glyph CharacterType pour 2 octets systŠme }
 smCharHorizontal=$0000; { CaractŠre de forme horizontal, ou pour tous }
 smCharVertical=$1000;   { CaractŠre de forme vertical }

  { Directions de CharacterType }
 smCharLeft=$0000;
 smCharRight=$2000;

  { Case modificateur de CharacterType }
 smCharLower=$0000;
 smCharUpper=$4000;

  { CaractŠre modificateur de taille CharacterType (1 ou multiple octets) }
 smChar1byte=$0000;
 smChar2byte=$8000;

  { Types de destination TransliterateText pour Romain }
 smTransAscii=0;    { Conversion en Ascii }
 smTransNative=1;   { Conversion en police scripte }
 smTransCase=$FE;   { Case de conversion pour tous texte }
 smTransSystem=$FF; { Conversion au scripte systŠme }

  { Types de destination TransliterateTexte pour 2 octets scripte }
 smTransAscii1=2;     { 1 octet Romain }
 smTransAscii2=3;     { 2 octet Romain }
 smTransKana1=4;      { 1 octet Japonais Katakana }
 smTransKana2=5;      { 2 octet Japonais Katakana }
 smTransGana2=7;      { 2 octet Japonais Hiragana (pas 1 octet Hiragana) }
 smTransHangul2=8;    { 2 octet Cor‚en Hangul }
 smTransJamo2=9;      { 2 octet Cor‚en Jamo }
 smTransBopomofo2=10; { 2 octet Chinois Bopomofo (Zhuyinfuhao) }

  { Modificateur de destination TransliterateText }
 smTransLower=$4000; { Destination en minuscule }
 smTransUpper=$8000; { Destination en majuscule }

  { Nombre de format resource TransliterateText }
 smTransRuleBaseFormat=1; { Resource du format des rŠgles de base trs1 }
 smTransHangulFormat=2;   { Resource du format des tables de base trs1 }

  { Drapeau de propri‚t‚ TransliterateText }
 smTransPreDoubleByting=1; { Converti tous textes … 2 octets avant la translit‚ration }
 smTransPreLowerCasing=2;  { Converti tous textes en minuscule avant la translit‚ration }

  { Masque source TransliterateText - G‚n‚ral }
 smMaskAll=$FFFFFFFF; { Converti tous textes }

  { Masque source TransliterateText }
 smMaskAscii=$00000001;  { 2^smTransAscii }
 smMaskNative=$00000002; { 2^smTransNative }

  { Masque source TransliterateText pour scripte 2 octets }
 smMaskAscii1=$00000004;    { 2^smTransAscii1 }
 smMaskAscii2=$00000008;    { 2^smTransAscii2 }
 smMaskKana1=$00000010;     { 2^smTransKana1 }
 smMaskKana2=$00000020;     { 2^smTransKana2 }
 smMaskGana2=$00000080;     { 2^smTransGana2 }
 smMaskHangul2=$00000100;   { 2^smTransHangul2 }
 smMaskJamo2=$00000200;     { 2^smTransJamo2 }
 smMaskBopomofo2=$00000200; { 2^smTransBopomofo2 }

  { Valeur r‚sultat: GetScriptManagerVariable, SetScriptManagerVariable, GetScriptVariable & SetScriptVarible }
 smNotInstalled=0; { Routine invalide dans le scripte sp‚cifi‚ }
 smBadVerb=-1;     { Mauvais s‚lecteur pass‚ … la routine }
 smBadScript=-2;   { Mauvais code scripte pass‚ … la routine }

  { Valeur pour scripte du drapeau de retracage }
 smRedrawChar=0;  { Retrace le caractŠre seulement }
 smRedrawWord=1;  { Mot d'entr‚e de retracage (systŠme 2 octets) }
 smRedrawLine=-1; { Ligne d'entr‚e de retracage (systŠme bidirectionnel) }

  { S‚lecteurs GetScriptManagerVariable & SetScriptManagerVariable }
 smVersion=0;          { Version du gestion scripte des nombres }
 smMunged=2;           { Changement globales du compteur }
 smEnable=4;           { Compteur de scriptes actif, incluant Romain }
 smBidirect=6;         { Scripte moins bidirectionnel 1 }
 smFontForce=8;        { Force le drapeau de police }
 smIntlForce=10;       { Drapeau de s‚lection des resources International }
 smForced=12;          { Force le scripte … ˆtre un scripte systŠme }
 smDefault=14;         { Par d‚faut le scripte doit ˆtre un scripte Romain }
 smPrint=16;           { Routine d'action d'impression }
 smSysScript=18;       { Scripte systŠme }
 smLastScript=20;      { Dernier scripte clavier }
 smKeyScript=22;       { Scripte clavier }
 smSysRef=24;          { Pliage systŠme par refNum }
 smKeyCache=26;        { "obsolete" }
 smKeySwap=28;         { Handle de table d'‚change }
 smGenFlags=30;        { Long drapeaux g‚n‚ral }
 smOverride=32;        { Drapeau du scripte "override" }
 smCharPortion=34;     { CaractŠre avec proportion SpExtra }
 smDoubleByte=36;      { Drapeau pour le scripte double octet install‚ }
 smKCHRCache=38;       { Pointeur retourn‚ au cache KCHR }
 smRegionCode=40;      { Retourne le code de la region courante (verXxx) }
 smKeyDisableState=42; { Retourne l'‚tat inactif cournant du clavier }

  { S‚lecteur GetScriptVariable & SetScriptVariable }
 smScriptVersion=0;       { Version logiciel du scripte }
 smScriptMunged=2;        { Compteur de scripte de changement d'entr‚e }
 smScriptEnable=4;        { Scripte du drapeau actif }
 smScriptRight=6;         { Drapeau de droite … gauche }
 smScriptJust=8;          { Drapeau de justification }
 smScriptRedraw=10;       { Mot de drapeau de retracage }
 smScriptSysFond=12;      { Police systŠme pr‚f‚rable }
 smScriptAppFond=14;      { Police d'application pr‚f‚rable }
 smScriptBundle=16;       { Commen‡ement des verbes itlb }
 smScriptNumber=16;       { Scripte identificateur international 0 (itl0) }
 smScriptDate=18;         { Scripte identificateur international 1 (itl1) }
 smScriptSort=20;         { Scripte identificateur international 2 (itl2) }
 smScriptFlags=22;        { Mot de drapeau }
 smScriptToken=24;        { Scripte identificateur international 4 (itl4) }
 smScriptEncoding=26;     { Identificateur optionnel international 5 (itl5), si pr‚sent }
 smScriptLang=28;         { Langage courante pour le scripte }
 smScriptNumDate=30;      { Format du nombre de la date dans le scripte }
 smScriptKeys=32;         { Identificateur de scripte KCHR }
 smScriptIcon=34;         { ID # de SICN ou de la famille kcs#/kcs4/kcs8 }
 smScriptPrint=36;        { Routine d'action de scripte d'impression }
 smScriptTrap=38;         { Porte d'entr‚e de pointeur }
 smScriptCreator=40;      { Cr‚ateur de fichier scripte }
 smScriptFile=42;         { Nom du fichier scripte }
 smScriptName=44;         { Nom du scripte }
 smScriptMonoFondSize=78; { Police sans espace (hi) et taille (lo) }
 smScriptPrefFondSize=80; { Police pr‚f‚rable (hi) et taille (lo) }
 smScriptSmallFondSize=82;{ Petite police par d‚faut (hi) et taille (lo) }
 smScriptSysFondSize=84;  { Police systŠme par d‚faut (hi) et taille (lo) }
 smScriptAppFondSize=86;  { Police d'appliation par d‚faut (hi) et taille (lo) }
 smScriptHelpFondSize=88; { Aide Mgr par d‚faut (hi) et taille (lo) }
 smScriptValidStyles=90;  { Masque de style de validit‚ pour les scriptes }
 smScriptAliasStyles=92;  { Style (ensemble) … utiliser pour les aliases }

  { S‚lecteur n‚gatif pour KeyScript }
 smKeyNextScript=-1;         { Switch du prochain scripte valide }
 smKeySysScript=-2;          { Switch du scripte du systŠme }
 smKeySwapScript=-3;         { Switch du scripte pr‚c‚damment utilis‚ }
 smKeyNextKybd=-4;           { Switch du prochain code clavier dans le keyscript courant }
 smKeySwapKybd=-5;           { Switch du pr‚c‚dant code clavier dans le keyscript courant }
 smKeyDisableKybds=-6;       { Codes clavier inactive pas dans le systŠm ou dans le scripte Romain }
 smKeyEnableKybds=-7;        { Codes clavier pre-activ‚ par tous les scriptes actif }
 smKeyToggleInLine=-8;       { Entr‚e de "Toggle inline" pour le keyscript courant }
 smKeyToggleDirection=-9;    { Direction de la ligne du "Toggle" par d‚faut (TESysJust) }
 smKeyNextInputMethod=-10;   { Switch du prochain m‚thode d'entr‚e dans le script courant }
 smKeySwapInputMethod=-11;   { Switch de la pr‚c‚dante m‚thode d'entr‚e dans le script courant }
 smKeyDisableKybdSwitch=-12; { Switchage inactif du code clavier courant }
 smKeyDirLeftRight=-15;      { Ensemble de direction de ligne par d‚faut gauche-droite, align‚ gauche }
 smKeySetDirRightLeft=-16;   { Ensemble de direction de ligne par d‚faut droite-gauche, align‚ droite }
 smKeyRoman=-17;             { Ensemble de keyscript … Romain. N'est accomplit qu'avec le format Romain }

  { Bits dans le mot smScriptFlags  (environ 8 bits sont non-static) }
 smsfIntellCP=0;        { Scripte intelligent pour "Cut" & "Paste" }
 smsfSingByte=1;        { Scripte avec un seul octet }
 smsfNatCase=2;         { CaractŠre d'origine ont des cases minuscules/majuscules }
 smsfContext=3;         { Le Scripte est contextuel }
 smsfNoForceFont=4;     { Le scripte ne force pas les caractŠres }
 smsfB0Digits=5;        { Scripte sont des nombres altern‚ de B0-B9 }
 smsfAutoInit=6;        { Initialisation automatique du scripte }
 smsfUnivExt=7;         { Script est un Handler par WorldScript I }
 smsfSynchUnstyledTE=8; { Synchronise le clavier et le type de caractŠre dans TE ind‚finie }
 smsfForms=13;          { Utilise la forme contextuel pour les lettres }
 smsfLigatures=14;      { Utilise les ligatures contextuel }
 smsfReverse=15;        { Texte inverse d'origine, droite-gauche }

  { Bits long dans le smGenFlags (Premier (Haut-ordre) octet est un ensemble de forme de drapeau d'octet itlc)}
 smfShowIcon=31;      { Affiche l'icon mˆme s'il n'y a qu'un scripte }
 smfDualCaret=30;     { Utilise le "dual caret" pour le mixage de direction de texte }
 smfNameTagEnable=29; { R‚serv‚ pour usage interne }

  { Gestionnaire de police scripte centrale }
 smFondStart=$4000; { Commence avec 16Ko }
 smFondEnd=$C000;   { Passe la fin de la rang‚ … 48Ko }

  { Outils police centrale }
 smUprHalfCharSet=$80; { Premier code de caractŠre dans le moiti‚ du sommet de l'ensemble de caractŠre standard }

  { Extensions de l'ensemble de caractŠre }
 diaeresisUprY=$D9;
 fraction=$DA;
 intlCurrency=$DB;
 leftSingGuillement=$DC;
 rightSingGuillement=$DD;
 fiLigature=$DE;
 flLigature=$DF;
 dblDagger=$E0;
 centeredDot=$E1;
 baseSingQuote=$E2;
 baseDblQuote=$E3;
 perThousand=$E4;
 circumflexUprA=$E5;
 circumflexUprE=$E6;
 acuteUprA=$E7;
 diaeresisUprE=$E8;
 graveUprE=$E9;
 acuteUprI=$EA;
 circumflexUprI=$EB;
 diaeresisUprI=$EC;
 graveUprI=$ED;
 acuteUprO=$EE;
 circumflexUprO=$EF;
 appleLogo=$F0;
 graveUprO=$F1;
 acuteUprU=$F2;
 circumflexUprU=$F3;
 graveUprU=$F4;
 dotlessLwrI=$F5;
 circumflex=$F6;
 tilde=$F7;
 macron=$F8;
 breveMask=$F9;
 overDot=$FA;
 ringMark=$FB;
 cedilla=$FC;
 doubleAcute=$FD;
 ogonek=$FE;
 hachek=$FF;

  { Valeur de TokenType }
 tokenIntl=4;          { La ressource internationnal de nombre de marqueur }
 tokenEmpty=-1;        { Usage interne aussi un drapeau vide }
 tokenUnknown=0;       { Ce caractŠre ne pas compatible avec le d‚finition du type de marqueur }
 tokenWhite=1;         { Espace blanc }
 tokenLeftLit=2;       { Commencement lit‚rale }
 tokenRightLit=3;      { Fin lit‚rale }
 tokenAlpha=4;         { Alphab‚thique }
 tokenNumeric=5;       { Num‚rique }
 tokenNewLine=6;       { Nouvelle ligne }
 tokenLeftComment=7;   { Ouvre un commentaire }
 tokenRightComment=8;  { Ferme un commentaire }
 tokenLiteral=9;       { Literal }
 tokenEscape=10;       { CaractŠre d'‚chapement/contr“le ('\' dans "\n", "\t") }
 tokenAltNum=11;       { Nombre altern‚ (B0h-B9h en Arabie, Hebreu }
 tokenRealNum=12;      { Nombre r‚el }
 tokenAltReal=13;      { Nombre r‚el altern‚ }
 tokenReserve1=14;     { Reserv‚ }
 tokenReserve2=15;     { R‚serv‚ }
 tokenLeftParen=16;    { Ouvre parenthŠse }
 tokenRightParen=17;   { Ferme parenthŠse }
 tokenLeftBracket=18;  { Ouvre la console carr‚ }
 tokenRightBracket=19; { Ferme la console carr‚ }
 tokenLeftCurly=20;    { Ouvre la console boucl‚ }
 tokenRightCurly=21;   { Ferme la console boucl‚ }
 tokenLeftEnclose=22;  { Ouvre guillemet }
 tokenRightEnclose=23; { Ferme guillemet }
 tokenPlus=24;         { Plus (+) }
 tokenMinus=25;        { Moins (-) }
 tokenAsterick=26;     { Heures/Multiple }
 tokenDivide=27;       { Diviseur }
 tokenPlusMinus=28;    { Symbole Plus ou moins }
 tokenSlash=29;        { / }
 tokenBackSlash=30;    { \ }
 tokenLess=31;         { Symbole de plus petit '<' }
 tokenGreat=32;        { Symbole de plus grand '>' }
 tokenEqual=33;        { Egale (=) }
 tokenLessEqual2=34;   { Inf‚rieur ou ‚gale, 2 caractŠres (<=) }
 tokenLessEqual1=35;   { Inf‚rieur ou ‚gale, 1 caractŠre (ó) }
 tokenGreatEqual2=36;  { Sup‚rieur ou ‚gale, 2 caractŠres (>=) }
 tokenGreatEqual1=37;  { Sup‚rieur ou ‚gale, 1 caractŠre (ò) }
 token2Equal=38;       { Double ‚galit‚ (==) }
 tokenColonEqual=39;   { deux-point ‚gale (:=) }
 tokenNotEqual=40;     { Pas ‚gale, 1 caractŠre }
 tokenLessGreat=41;    { Inf‚rieur/sup‚rieur, symbole Pascal de non ‚galit‚ (<>) }
 tokenExclamEqual=42;  { Exclamation ‚gale, symbole C/C++ pour non ‚galit‚ (!=) }
 tokenExclam=43;       { Point d'exclamation (!) }
 tokenTilde=44;        { "Tilde" centrer }
 tokenComma=45;        { Virgule (,) }
 tokenPeriod=46;
 tokenLeft2Quote=47;   { Ouvre un double citation (®) }
 tokenRight2Quote=48;  { Ferme un double citation (¯) }
 tokenLeft1Quote=49;   { Ouvre un simple citation }
 tokenRight1Quote=50;  { Ferme un simple citation }
 token2Quote=51;       { Double citation }
 token1Quote=52;       { Simple citation }
 tokenSemicolon=53;    { (;) }
 tokenPercent=54;      { (%) }
 tokenCaret=55;
 tokenUnderline=56;    { (_) }
 tokenAmpersand=57;
 tokenAtSign=58;
 tokenBar=59;          { (³) }
 tokenQuestion=60;     { (?) }
 tokenPi=61;           { Case minscule pi (ã) }
 tokenRoot=62;         { Symbole racine carr‚ (û) }
 tokenSigma=63;        { "Capital sigma" }
 tokenIntegral=64;     { Signe int‚gral }
 tokenMicro=65;
 tokenCapPi=66;        { pi capital }
 tokenInfinity=67;
 tokenColon=68;        { (:) }
 tokenHash=69;         { (#) }
 tokenDollar=70;       { ($) }
 tokenNoBreakSpace=71; { Espace "non-breaking" }
 tokenFraction=72;
 tokenIntlCurrency=73;
 tokenLeftSingGuillemet=74;
 tokenRightSingGuillemet=75;
 tokenPerThousand=76;
 tokenEllipsis=77;
 tokenCenterDot=78;
 tokenNil=127;
 delimPad=-2;

  { Table des s‚lecteurs pour GetIntlResourceTable }
 smWordSelectTable=0;  { Demande le mot d'arrˆt de la table 'itl2' }
 smWordWrapTable=1;    { Demande la ligne d'arrˆt de la table 'itl2' }
 smNumberPartsTable=2; { Demande les parties du nombre de la table 'itl4' }
 smTokenTable=3;       { Demande une d‚marqueur de la table de 'itl4' }
 smWhiteSpaceList=4;   { Demande un espace blanc de la table de 'itl4' }

{$I \Source\Chantal\Library\System\Mac\Types\Base.Inc}

Type
 TokenResults=(tokenOk,tokenOverflow,stringOverflow,badDelim,badEnding,crash);
 CharByteTable=Packed Array[0..255] of SignedByte;
 TokenType=Integer;
 DelimType=Array[0..1] of TokenType;
 CommentType=Array[0..3] of TokenType;

 TokenRec=Record
  thetoken:TokenType;
  position:Ptr;             { Pointeur de la source originale }
  length:LongInt;           { Longueur du texte de la source originale }
  stringPosition:StringPtr; { ChaŒne de caractŠre de la copie Pascal/C de l'identificateur }
 End;
 TokenRecPtr=^TokenRec;

 TokenBlock=Record
  source:Ptr;                           { Pointeur de la chaŒne de caractŠre }
  sourceLength:LongInt;                 { Longueur de la source de chaŒne de caractŠre }
  tokenList:Ptr;                        { Pointeur de la Array des marqueurs }
  tokenLength:LongInt;                  { Longueur maximal de la TokenList }
  tokenCount:LongInt;                   { Nombre de marqueur g‚n‚r‚ par faiseur de marqueur }
  stringList:Ptr;                       { Pointeur de la chaŒne d'identificateur }
  stringLength:LongInt;                 { Longueur de la chaŒne de chaŒne de caractŠre }
  stringCount:LongInt;                  { Nombre d'octet de l'usage courant }
  doString:Boolean;                     { Marque la chaŒne de caractŠre et le fixe dans StringList }
  doAlphanumeric:Boolean;               { Identificateurs peut inclure des nombres }
  doNest:Boolean;                       { Fait poser une question ? }
  leftDelims,rightDelims:DelimType;
  leftComment,rightComment:CommentType;
  escapeCode,decimalCode:TokenType;     { Symbole de code d'‚chapement/code d‚cimal }
  itlResource:Handle;                   { Handle du scripte courant de la resource itl4 }
  reserved:Array[0..7]of LongInt;       { Simplement une liste de 0 }
 End;
 TokenBlockPtr=^TokenBlock;

 { V‚rification et ajustement de la direction systŠme }
Function GetSysDirection:Integer;Forward;
Procedure SetSysDirection(newDirection:Integer);Forward;

 { V‚rification et ajustement du Gestionnaire scripte de variable }
Function GetScriptManagerVariable(selector:Integer):LongInt;Forward;
Function SetScriptManagerVariable(selector:Integer;param:LongInt):OSErr;Forward;

 { V‚rification et ajustement du scripte de variable }
Function GetScriptVariable(script:ScriptCode;selector:Integer):LongInt;Forward;
Function SetScriptVariable(script:ScriptCode;selector:Integer;param:LongInt):OSErr;Forward;

 { Ajustement clavier }
Procedure KeyScript(code:Integer);Forward;

 { D‚termination du codes de scripte de l'information de la police }
Function FontScript:Integer;Forward;
Function FontToScript(fontNumber:Integer):Integer;Forward;
Function IntlScript:Integer;Forward;

 { Analyseur des caractŠres }
Function CharacterByteType(textBuf:Ptr;textOffset:Integer;script:ScriptCode):Integer;Forward;
Function CharacterType(textBuf:Ptr;textOffset:Integer;script:ScriptCode):Integer;Forward;
Function FillParseTable(Var table:CharByteTable;script:ScriptCode):Boolean;Forward;

 { AccŠs directe au resource international }
Procedure ClearIntlResourceCache;Forward;
Function  GetIntlResource(theID:Integer):Handle;Forward;
Procedure GetIntlResourceTable(script:ScriptCode;tableCode:Integer;Var itlHandle:Handle;
                               Var offset:LongInt;Var length:LongInt);Forward;

 { Initilisation des marqueurs }
Function IntlTokenize(tokenParam:TokenBlockPtr):TokenResults;Forward;

 { Translit‚ration }
Function TransliterateText(scrHandle:Handle;dstHandle:Hdl;target:Integer;srcMask:LongInt;scr:ScriptCode):OSErr;Forward;

 { Remplacement d'un scripte du systŠme par des routines par d‚faut }
Function  GetScriptUtilityAddress(selector:Integer;before:Boolean;script:ScriptCode):Ptr;Forward;
Procedure SetScriptUtilityAddress(selector:Integer;before:Boolean;routineAddr:Ptr;script:ScriptCode);Forward;
Function  GetScriptQDPatchAddress(trapNum:Integer;before,forPrinting:Boolean;script:ScriptCode):Ptr;Forward;
Procedure SetScriptQDPatchAddress(trapNum:Integer;before,forPrinting:Boolean;routineAddr:Ptr;scr:ScriptCode);Forward;

{$ENDIF}