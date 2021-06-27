{ToolKit.Inc}

{$IFNDEF __ToolKit}
 {$DEFINE __ToolKit}
Const
  { Bits dans l'octet itlcFlags }
 itlcShowIcon=7;  { Affiche l'Icon d'‚v‚nement si c'est un scripte seulement }
 itlcDialCaret=6; { Utilise "dual caret" pour la direction du texte mixte }

  { Bits du mot itlcSysFlags }
 itlcSysDirection=15; { Direction du systŠme - gauche-droite ou droite-gauche }

  { L'indice NumerParts }
 tokLeftQuote=1;
 tokRightQuote=2;
 tokLeadPlacer=3;
 tokLeader=4;
 tokNonLeader=5;
 tokZeroLead=6;
 tokPercent=7;
 tokPlusSign=8;
 tokMinusSign=9;
 tokThousands=10;
 tokSeparator=12; { 11 est un champ r‚serv‚ }
 tokEscape=13;
 tokDecPoint=14;
 tokUnquoteds=15;
 tokMaxSymbols=31;

 curNumberPartsVersion=1; { Version courant de l'enregistrement NumberParts }

 currSymLead=16;
 currNegSym=32;
 currTrailingZ=64;
 currLeadingZ=128;

 zeroCycle=1;  { 0:00 format AM/PM }
 longDay=0;    { Jour du mois }
 longWeek=1;   { Jour de la semaine }
 longMonth=2;  { Mois de l'ann‚e }
 longYear=3;   { Ann‚e }
 subDay=1;     { Contient le jour du mois }
 subWeek=2;    { Contient le jour de semaine }
 subMonth=4;   { Contient le mois }
 subYear=8;    { Contient l'ann‚e }
 dayLdingZ=32;
 mntLdingZ=64;
 century=128;
 secLeadingZ=32;
 minLeadingZ=64;
 hrLeadingZ=128;

  { Ordre de Date }
 mdy=0;
 dmy=1;
 ymd=2;
 myd=3;
 dym=4;
 ydm=5;

{$I \Source\Chantal\Library\System\Mac\Types\Base.Inc}

Type
 ItlcRecord=Record
  itlcSystem,itlcReserved:Integer;          { Scripte systŠme par d‚faut, R‚serv‚ }
  itlcFontForce:SignedByte;                 { Force le drapeau de police par d‚faut }
  itlcIntlForce:SignedByte;                 { Force le drapeau international par d‚faut }
  itlcOldKybd,itlcFlags:SignedByte;         { Drapeau du clavier du MacPlus International, Drapeau g‚n‚ral }
  itlcIconOffset:Integer;                   { R‚serv‚ }
  itlcIconSide,itlcIconRsvd:SignedByte;     { R‚serv‚ }
  itlcRegionCode,itlcSysFlags:Integer;      { Code pr‚f‚r‚ de verXxx/Drapeau pour ajuster le systŠme globale }
  itlcReserved4:Array[0..31] of SignedByte; { Pour utilisation futur }
 End;

 ItlbRecord=Record
  itlbNumber,itlbDate,itlbSort:Integer;     { Identificateur de nombre itl0, itl1, itl2 }
  itlbFlags,itlbToken,itlbEncoding:Integer; { Drapeau de scripte, ID de nombre itl4, ID # itl5 (opt.) }
  itlbLang:Integer;                         { Pour le langage courant du scripte }
  itlbNumRep,itlbDateRep:SignedByte;        { Code de repr‚sentation de date }
  itlbKeys,itblIcon:Integer;                { Nombre ID KCHR, ID# de SIGN ou la famille kcs#/kcs4/kcs8 }
 End;

 ItlbExtRecord=Record
  base:IltRecord;                      { ItlbRecord Non-‚tendu }
  itlbLocalSize:LongInt;               { Taille de scripte de l'enregistrement local }
  itlbMonoFond,itlbMonoSize:Integer;   { Simple espace: identificateur de police, taille de la police }
  itlbPrefFond,itlbPrefSize:Integer;   { Pr‚f‚r‚: Identificateur de police, taille de la police }
  itlbSmallFond,itlbSmallSize:Integer; { Petite par d‚faut: Identificateur de police, taille de la police }
  itlbSysFond,itlbSysSize:Integer;     { SystŠme par d‚faut: Identificateur de police, taille de la police }
  itlbAppFond,itlbAppSize:Integer;     { Applicatioon par d‚faut:Identificateur de police,taille de la police}
  itlbHelpFond,itlbHelpSize:Integer;   { Aide par d‚faut: Identificateur de police, taille de la police }
  itlbValideStyle:Style;               { Ensemble de style valide pour le scripte }
  itlbAliasStyle:Style;                { Ensemble de style … marquer les aliases }
 End;

 Intl0Rec=Packed Record
  decimalPt,thousSep:Char;           { CaractŠre de point d‚cimal, caractŠre de s‚parateur de millier }
  listSep,currSym1:Char;             { Liste de caractŠre s‚parateur, symbol courant }
  currSym2,currSym2:Char;
  currFmt,dateOrder:Byte;            { Drapeau de format courant,Ordre de petit ‚l‚ment de date: mdy, dmy,... }
  shrtDateFmt:Byte;                  { Format de drapeau pour chaque petit ‚l‚ment de date }
  dateSep:Char;                      { CaractŠre de s‚parateur de date }
  timeCycle:Byte;                    { Sp‚cifie le cycle de l'heure: 0 … 23, 1 … 12, 0 … 11 }
  timeFmt:Byte                       { Format du drapeau pour chaque ‚l‚ment de l'heure }
  mornStr:Packed Array[1..4]of Char; { Tracage de chaŒne de caractŠre pour AM si cycle de 12 heures }
  eveStr:Packed Array[1..4] of Char; { Tracage de chaŒne de caractŠre pour PM si cycle de 12 heures }
  timeSep:Char;                      { S‚parateur de l'heure }
  time1Stuff,time2Stuff:Char;        { Tracage de chaŒne de caractŠre pour AM si cycle de 24 heures }
  time3Stuff,time4Stuff:Char;
  time5Stuff,time6Stuff:Char;        { Tracage de chaŒne de caractŠre pour PM si cylce de 24 heures }
  time7Stuff,time8Stuff:Char;
  metricSys:Byte;                    { 255 si m‚trique, 0 si pouce,... }
  intl0Vers:Integer;                 { Code de r‚gion (hi octet) et version (lo octet) }
 End;
 Intl0Ptr=^Intl0Rec;
 Intl0Hndl=^Intl0Ptr;

 Intl1Rec=Packed Record
  days:Array[1..7] of Str15;      { Nom des jours de semaine }
  months:Array[1..12] of Str15;   { Nom des mois }
  suppressDay:Byte;               { 255 pour num‚ro journ‚e, ou drapeau contenant n'importe quel ‚l‚ment }
  lngDateFmt:Byte;                { Ordre de la longue date d'‚l‚ment }
  dayLeading0:Byte;               { 255 pour premier 0 pour le num‚ro de jour }
  abbrLen:Byte;                   { Longueur pour les abr‚viations de nom }
  st0,st1,st2,st3,st4:Packed Array[1..4] of Char; { S‚parateur de chaŒne de caractŠre pour une longue date }
  intl1Vers:Integer;              { Code de r‚gion (octet hi) et version (octet lo) }
  localRtn:Array[0..0]of Integer; { Un drapeau pour l'extension optionnel }
 End;
 Intl1Ptr=^IntlRec;
 Intl1Hndl=^Intl1Ptr;

 Itl1ExtRec=Record
  base:Intl1Rec;                   { Enregistrement de non ‚tendue Intl1Rec }
  version,format:Integer;          { Num‚ro de version, code de format }
  calendarCode:Integer;            { Code de calendrier pour 'itl1' }
  extraDaysTableOffset:LongInt;    { Offset de la table des jours extra }
  extraDaysTableLength:LongInt;    { Longueur de la table des jours extra }
  extraMonthsTableOffset:LongInt;  { Offset de la table des mois extra }
  extraMonthsTableLength:LongInt;  { Longueur de la table des mois extra }
  abbrevDaysTableOffset:LongInt;   { Offset de l'abr‚viation de la table des jours }
  abbrevDaysTableLength:LongInt;   { Longueur de l'abr‚viation de la table des jours }
  abbrevMonthsTableOffset:LongInt; { Offset de l'abr‚viation de la table des mois }
  abbrevMonthsTableLength:LongInt; { Longueur de l'abr‚viation de table des mois }
  extraSepsTableOffset:LongInt;    { Offset de la table extra de la seps }
  extraSepsTableLength:LongInt;    { Longueur de la table extra de la seps }
  tables:Array[0..0] of Integer;   { Les tables, longueur de la variable }
 End;

 NItl4Rec=Record
  flags:Integer;           { R‚serv‚ }
  resourceType:LongInt;    { Contient 'itl4' }
  resourceNum:LongInt;     { Resource d'identificateur }
  version:Integer;         { Num‚ro de version }
  format:Integer;          { Code de format }
  resHeader:Integer;       { R‚serv‚ }
  resHeader2:LongInt;      { R‚serv‚ }
  numTables:Integer;       { Nombre des tables, une base }
  mapOffset:LongInt;       { Table de la carte octet au marqueur }
  strOffset:LongInt;       { Routine copiant la chaŒne de caractŠre }
  fetchOffset:LongInt;     { Routine demandant le prochaine octet de caractŠre }
  unTokenOffset:LongInt;   { Table des cartes de marqueur … chaŒne de caractŠre }
  defPartsOffset:LongInt;  { Offset par d‚faut de la partie de la table de nombre }
  whtSpListOffset:LongInt; { Offset la table d'espace blanc }
  resOffset7:LongInt;      { R‚serv‚ }
  resOffset8:LongInt;      { R‚serv‚ }
  resLength1:Integer;      { R‚serv‚ }
  resLength2:Integer;      { R‚serv‚ }
  resLength3:Integer;      { R‚serv‚ }
  unTokenLength:Integer;   { Longueur de la table d‚marqueur }
  defPartsLength:Integer;  { Longueur de la table partie de nombre }
  whtSpListLength:Integer; { Longueur de la table d'espace blanc }
  resLength7:Integer;      { R‚serv‚ }
  resLenght8:Integer;      { R‚serv‚ }
 End;
 NItl14Ptr=^NItl4Rec;
 NItl4Handle=^NItl4Ptr;

 UntokenTable=Record
  len,lastToken:Integer; Index:Array[0..255] of Integer; { Index de la table; dernier=lastToken }
 End;

 WideChar=Record Case Boolean of
  True:(a:Packed Array[0..1] of Char); { 0 est la partie haut de l'ordre des caractŠres }
  False:(b:Integer);
 End;
 WideCharArr=Record size:Integer; data:Packed Array[0..9] of WideChar; End;

 NumberParts=Record
  version:Integer; data:Array[1..31] of WideChar; pePlus,peMinus,peMinusPLus,altNumTable:WideChar;
  reserved:Packed Array[0..19] of Char;
 End;
 NumberPartsPtr=^NumberParts;

 Itl5Record=Record
  versionNumber:Fixed;                                { Version du nombre de resource du itl5 }
  numberOfTables:Integer;                             { Nombre de tables qu'il contient }
  reserved:Array[0..2] of Integer;                    { R‚serv‚ pour usage interne }
  tableDirectory:Array[0..0] of TableDirectoryRecord; { Table d'enregistrement de r‚pertoire }
 End;

 TableDirectoryRecord=Record
  tableSignature:OSType;    { Nom de la table en 4 octets long }
  reserved:LongInt;         { R‚serv‚ pour usage interne }
  tableStartOffset:LongInt; { D‚but de la table d'offset en octets }
  tableSize:LongInt;        { Taille de la table en octets }
 End;

 RuleBaseTrslRecord=Record
  sourceType:Integer;    { Type de destination pour la gauche du c“t‚ de la rŠgle }
  targetType:Integer;    { Type de destination pour la droite du c“t‚ de la rŠgle }
  formatNumber:Integer;  { Format des resources de nombre de translit‚ration }
  propertyFlags:Integer; { Drapeau des propri‚t‚s de translit‚ration }
  numberOfRules:Integer; { Nombre de rŠgle suivant ces champs }
 End;

{$ENDIF}