{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                                                                       Û
 ³                          U n i t ‚  B 5 7                             Û
 ³                                                                       Û
 ³                BibliothŠque du compilateur Pascal B57                 Û
 ³         Enemble Malte Genesis IV & V: Alias Chantal & AdŠle           Û
 ³                                                                       Û
 ³    Tous droits r‚serv‚s par les Chevaliers de Malte (C) 1998, 1999    Û
 ³                                                                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Nom du programmeur
 ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

  Sylvain Maltais


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette unit‚ renferme toutes les informations concernant la gestion de base
 du systŠme … la fa‡on du  compilateur  B57. galement  toutes  les routines
 pertinentes … propos de r‚solution de certains problŠmes s'y trouve.
}

Unit‚ B57;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                 INTERFACE
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Constante
 Ya=True;
 Oui=Vrai;
 No=False;
 Non=Faux;
  (***** Constantes culturelles *****)
 {Les codes r‚gionales (version)}
(* verUS=001;                  {tat-Unis (USA)}
 vertatsUnis=001;           {tat-Unis (USA)}
 verQu‚bec=002;              {Qu‚bec (l'ancienne Nouvelle-France)}
 verFrCanada=002;            {Qu‚bec (Canada fran‡ais)}
 verCanadaFran‡ais=002;      {Qu‚bec (Canada fran‡ais)}
 verLatinAmerica=003;        {Am‚rique Latine}
 verAm‚riqueLatine=003;      {Am‚rique Latine}
 verRussia=007;              {Russie}
 verRussie=007;              {Russie}
 verEgypt=020;               {gypte}
 vergypte=020;              {gypte}
 verMalta=022;               {Ile de Malte}
 verMalte=022;               {Ile de Malte}
 verSouthAfrica=027;         {Afrique du Sud}
 verAfriqueDuSud=027;        {Afrique du Sud}
 verGrŠce=030;               {GrŠce}
 verGreece=030;              {GrŠce}
 verNetherlands=031;         {Les Pays-bas}
 verPaysBas=031;             {Les Pays-bas}
 verFrBelgiumLux=032;        {Belgique & Luxembourg fran‡aise}
 verFrance=033;              {France (les anciens Gaulois)}
 verSpain=034;               {Espagne}
 verEspagne=034;             {Espagne}
 verHungary=036;             {Hongrie}
 verYugoslavia=038;          {Yougoslavie}
 verYougoslavie=038;         {Yougoslavie}
 verItaly=039;               {Italie (les anciens Romain)}
 verItalie=039;              {Italie (les anciens Romain)}
 verRomania=040;             {Roumanie}
 verRoumanie=040;            {Roumanie}
 verSwitherland=041;         {Suisse}
 verSuisse=041;              {Suisse}
 verCzechoslavakia=042;      {Yougoslavie (Serbre/Croate/Musulman)}
 verYougoslavie=042;         {Yougoslavie (Serbre/Croate/Musulman)}
 verAustria=043;             {Autriche}
 verAutriche=043;            {Autriche}
 verBritain=044;             {Angleterre/Grande-Bretagne (les anciens Bretons)}
 verUnitedKingdom=044;       {Synonyme d'Angleterre}
 verDenmark=045;             {Danemark (partie des anciens Vikings)}
 verSweden=046;              {SuŠde (partie des anciens Vikings)}
 verNorway=047;              {NorvŠge (partie des anciens Vikings)}
 verPoland=048;              {Pologne}
 verGermany=049;             {Allemagne (les anciens Germain)}
 verPeru=051;                {P‚rou}
 verMexico=052;              {Mexique}
 verArgentina=054;           {Argentine}
 verBrazil=055;              {Br‚sil}
 verChile=056;               {Chili}
 verColumbia=057;            {Columbie}
 verVenesuela=058;           {V‚n‚suela}
 verMalaysia=060;            {Malaysie}
 verAustralia=061;           {Australie (‚galement Anglais international)}
 verIndonesia=062;           {Indon‚sie}
 verPhilippines=063;         {Philippines}
 verNewZealand=064;          {Nouvelle Z‚lande}
 verSingapore=065;           {Singapour}
 verThailand=066;            {Tha‹lande}
 verJapan=081;               {Japon}
 verKoreaSouth=082;          {Cor‚e}
 verChina=086;               {Chine}
 verTaiwanDos5=088;          {Ta‹wan (Pour le Dos 5.0+)}
 verTurkey=090;              {Turkie}
 verIndia=091;               {Inde}
 verPakistan=092;            {Pakistan}
 verSriLanka=094;            {Sri Lanka}
 verIran=098;                {Iran}
 verMoroco=212;              {Maroc}
 verAlgeria=213;             {Alg‚rie}
 verTunisia=216;             {Tun‚sie}
 verPortugal=351;            {Portugal}
 verIreland=353;             {Irlande}
 verIceland=354;             {Islande}
 verCyprus=357;              {Chypre}
 verFinland=358;             {Finlande}
 verGuatemala=502;           {Guatemala}
 verElSalvador=503;          {Salvador}
 verCostaRica=506;           {Costa Rica}
 verPanama=507;              {Panama}
 verHaiti=509;               {Ha‹ti}
 verMiddleEast=785;          {Middle Est}
 verHongKong=852;            {Hong Kong}
 verBangladesh=880;          {Bangladesh}
 verTaiwan=886;              {Ta‹wan comme 88}
 verArabia=966;              {Arabie (saoudite)}
 verArabic=966;              {Arabie (saoudite)}
 verSaudiArabia=966;         {Arabie saoudite}
 verUnitedArabEmirates=971;  {mirats Arabes Unis}
 verIsrael=972;              {Isra‰l}
 verUnknown=$FFFF;           {Inconnue}*)
  {Ordre des dates}
 mdy=0;                      {MM/JJ/AA}
 dmy=1;                      {JJ/MM/AA}
 ymd=2;                      {AA/MM/JJ}
 myd=3;                      {MM/AA/JJ}
 dym=4;                      {JJ/AA/MM}
 ydm=5;                      {AA/JJ/MM}

  (***** Constante Micro-Processeur *****)
 {Les diff‚rents Micro-Processeur (CPU)}
 cpu8088=0;                  {Intel 8088}
 cpu8086=1;                  {Intel 8086}
 cpuV20=2;                   {NEC V20}
 cpuV30=3;                   {NEC V30}
 cpu80188=4;                 {Intel 80188}
 cpu80186=5;                 {Intel 80186}
 cpu80286=6;                 {Intel 80286}
 cpui386=7;                  {Intel 80386}
 cpui486=8;                  {Intel 80486}
 cpuCyrix5x86=9;             {Cyrix 5x86}
 cpuCyrix6x86=10;            {Cyrix 6x86}
 cpuPentium=11;              {Pentium}
 cpuPentiumMMX=12;           {Pentium-MMX}
 cpuPentiumII=13;            {Pentium II}

  (**** Constante de la structure de la machine *****)
 {Les noms des diff‚rents ordinateur (Computer Name)}
(* cnIBM7561_2=$0002;          {IBM 7561/2}
 cnPS2M90XP=$0003;           {PS/2 ModŠle 90XP}
 cnPS2M95XP=$0004;           {PS/2 ModŠle 95XP}
 cnAST=$0010;                {AST}
 cnTandy1000=$0021;          {Tandy 1000}
 cnTandy3000NL=$0023;        {Tandy 3000NL}
 cnCompaqPC=$002D;           {Compaq PC/Compaq Deskpro}
 cnSperryPC=$0030;           {Sperry PC}
 cnOlivettiM15=$0046;        {Olivetti M15}
 cnPS2M55_5551=$0055;        {PS/2 ModŠle 55-5551}
 cnContermMax=$0056;         {ContermMax}
 cnCompaqXT=$009A;           {Compaq XT/Compaq Plus}
 cnHewlettPackard110=$00B6;  {Hewlett-Packard 110}
 cnPS2M55_5530=$00E1;        {PS/2 ModŠle 55-5530 Laptop}
 cnPS2M80_16=$00F8;          {PS/2 ModŠle 80,16Mhz 386}
 cnPCConv=$00F9;             {PC-Convertible}
 cnPS2M30=$00FA;             {PS/2 ModŠle 30}
 cnAT=$00FC;                 {Clone AT}
 cnPCJunior=$00FD;           {PC Junior}
 cnXT=$00FE;                 {PC XT}
 cnPC=$00FF;                 {PC original}
 cnPS2M80_20=$01F8;          {PS/2 ModŠle 80,20Mhz 386}
 cnPS2M25=$01FA;             {PS/2 ModŠle 25/25L}
 cnPCXT2=$01FB;              {PC-XT/2}
 cnPS2M55_5571=$02F8;        {PS/2 ModŠle 55-5571}
 cnPCXT286=$02FC;            {PC-XT/286}
 cnPS2M70_16=$04F8;          {PS/2 ModŠle 70,16Mhz 386}
 cnPS2M50=$04FC;             {PS/2 ModŠle 50,10Mhz 286}
 cnPS2M50Z=$04FF;            {PS/2 ModŠle 50Z,10Mhz 286}
 cnIBMPC7568=$05F8;          {IBM PC 7568}
 cnPS2M60=$05FC;             {PS/2 ModŠle 60,10Mhz 286}
 cnIBM7552Gearbox=$06FC;     {IBM 7552 Gearbox}
 cnPS2M70_20=$09F8;          {PS/2 ModŠle 70,20Mhz 386}
 cnPS2M25i286=$09FC;         {PS/2 ModŠle 25-286}
 cnPS2M30i286=$09FE;         {PS/2 ModŠle 30-286}
 cnPS2MP70=$0BF8;            {PS/2 ModŠle P70}
 cnPS1M2011=$0BFC;           {PS/1 ModŠle 2011}
 cnPS2M55SZ=$0CF8;           {PS/2 ModŠle 55SZ}
 cnPS2M70i386_25=$0DF8;      {PS/2 ModŠle 70,25Mhz 386}
 cnPS1i486SX=$0EF8;          {PS/1 486SX}
 cnPS1i486DX=$0FF8;          {PS/1 486DX}
 cnPS2M90_25=$11F8;          {PS/2 ModŠle 90,25Mhz 386}
 cnPS2M90_33=$13F8;          {PS/2 ModŠle 90,33Mhz 386}
 cnPS2M90AK9=$14F8;          {PS/2 ModŠle 90,AK9 25Mhz 486}
 cnPS2M90AKD=$16F8;          {PS/2 ModŠle 90,AKD 33Mhz 486}
 cnPS2M35=$18F8;             {PS/2 ModŠle 35/35LS/40 20Mhz 386SX}
 cnPS2M70i486_25=$1BF8;      {PS/2 ModŠle 70,25Mhz 486}
 cnPS2M65_121=$1CF8;         {P2/2 ModŠle 65-121,16Mhz 386SX}
 cnPS2M55LS=$1EF8;           {PS/2 ModŠle 55LS,16Mhz}
 cnCompaqProLinea=$20FC;     {Compaq Pro Linea }
 cnPS2ML40=$23F8;            {PS/2 ModŠle L40,20Mhz 386SX}
 cnPS2MM57=$25F8;            {PS/2 ModŠle M57,20Mhz 386SLC}
 cnToshibaT5200_200=$2639;   {Toshiba T5200/200}
 cnPS2M57=$26F8;             {PS/2 ModŠle 57,20Mhz 386SX}
 cnPS2M95_50=$2AF8;          {PS/2 ModŠle 95,50Mhz 486}
 cnPS2M90_50=$2BF8;          {PS/2 ModŠle 90,50Mhz 486}
 cnPS2M95_20=$2CF8;          {PS/2 ModŠle 95,20Mhz 486SX}
 cnPS2M95_SX87_20=$2EF8;     {PS/2 ModŠle 95,20Mhz 486SX+487SX}
 cnPS2M90_SX87_20=$2FF8;     {PS/2 ModŠle 90,20Mhz 486SX+487SX}
 cnPS1M2121=$30F8;           {PS/1 ModŠle 2121}
 cnIBMRestaurantTerm=$30FA;  {IBM Restaurant Terminal}
 cnEpson1=$30FC;             {Epson, modŠle inconnue}
 cnEpson2=$31FC;             {Epson, modŠle inconnue}
 cnEpson3=$33FC;             {Epson, modŠle inconnue}
 cnPCAT319=$3538;            {PC-AT 319 ou 339,8Mhz}
 cnTandy3000=$3738;          {Tandy 3000}
 cnToshibaT5200_100=$3838;   {Toshiba T5200/100}
 cnToshibaT1200XE=$3938;     {Toshiba T1200/XE}
 cnToshibaT4500SX_C=$4139;   {Toshiba T4500SX-C}
 cnPS2M77=$41F8;             {PS/2 ModŠle 77}
 cnOlivettiM280=$42FC;       {Olivetti M280}
 cnPS1=$4320;                {PS/1}
 cnOlivettiM240=$43FF;       {Olivetti M240}
 cnToshiba4400C=$4539;       {Toshiba 4400C}
 cnPS2M90XPPentium=$45F8;    {PS/2 ModŠle 90 XP Pentium}
 cnOlivettiM380=$45FC;       {Olivetti M380 (XP1/XP3/XP5)}
 cnPS2M95XPPentium=$46F8;    {PS/2 ModŠle 95 XP Pentium}
 cnPCXT_=$46FF;              {PC XT d'IBM inconnue}
 cnPS2M85=$48F8;             {PS/2 ModŠle 85}
 cnOlivettiM290=$48FC;       {Olivetti M290}
 cnPSVP325T=$49F8;           {PS/ValuePoint 325T}
 cnPSVP425SX=$4AF8;          {PS/ValuePoint 425SX}
 cnPSVP433DX=$4BF8;          {PS/ValuePoint 433DX}
 cnOlivettiM200=$4CFB;       {Olivetti M200}
 cnPS2M295=$4EF8;            {PS/2 ModŠle 295}
 cnOlivettiM111=$4EFE;       {Olivetti M111}
 cnOlivettiM250=$4FFC;       {Olivetti M250}
 cnPS2MP70_16=$50F8;         {PS/2 ModŠle P70,16Mhz 386}
 cnOlivettiM380XP7=$50FC;    {Olivetti M380 (XP7)}
 cnOlivettiPCS286=$51FC;     {Olivetti PCS286}
 cnPS2MP75_33=$52F8;         {PS/2 ModŠle P75, 33Mhz 386}
 cnOlivettiM300=$52FC;       {Olivetti M300}
 cnPS2MCL57SX=$56F8;         {PS/2 ModŠle CL57 SX}
 cnPS2MN51SLC=$5DF8;         {PS/2 ModŠle N51 SLC}
 cnIBMThinkPad700=$5EF8;     {IBM Think Pad 700}
 cnOlivettiP500=$61F8;       {Olivetti P500}
 cnOlivettiP800=$62F8;       {Olivetti P800}
 cnToshiba1850SX=$6E39;      {Toshiba 1850SX}
 cnToshiba1800SX=$6F39;      {Toshiba 1800SX}
 cnPS2M80_25=$80F8;          {PS/2 ModŠle 80,25Mhz 386}
 cnPS2M55_5502=$81F8;        {PS/2 ModŠle 55-5502}
 cnPS2M55N33SX=$87F8;        {PS/2 ModŠle 55 N33SX}
 cnPS2M55_5530T=$88F8;       {PS/2 ModŠle 55-5530T}
 cnZenith386=$94FC;          {Zenith 386}
 cnPS2M55N28SX=$97F8;        {PS/2 ModŠle 55 Note N28SX}
 cnPS2MN51SX=$99F8;          {PS/2 ModŠle N51 SX}
 cnDell200=$A302;            {Dell 200}
 cnDell300=$A303;            {Dell 300}
 cnDell220=$A305;            {Dell 220}
 cnDell310=$A306;            {Dell 310}
 cnDell325=$A307;            {Dell 325}
 cnDell310A=$A309;           {Dell 310A}
 cnDell316=$A30A;            {Dell 316}
 cnDell220E=$A30B;           {Dell 220E}
 cnDell210=$A30C;            {Dell 210}
 cnDell316SX=$A30D;          {Dell 316SX}
 cnDell316LT=$A30E;          {Dell 316LT}
 cnDell320LX=$A30F;          {Dell 320LX}
 cnDell425E=$A311;           {Dell 425E}
 cnQuadramQuad386=$A6FE;     {Quadram Quad 386}
 cnReplyModel32=$F2F8;       {Reply ModŠle 32}
 cnMemorexTelex=$F6F8;       {Memorex Telex}
 cnCompaq286=$FA00;          {Compaq 286 ou clone}
 cnCompaq386=$FA01;          {Compaq 386 ou clone}
 cnIBMProcessorComplex=$FDF8;{Processeur IBM complexe}
 cnIBMPCradio9075=$FEFA;     {IBM PCradio 9075}*)
  {ModŠle de Bus systŠme}
 busUnknown=$00;             {Bus inconnue}
 busISA8=$08;                {Bus ISA,8-Bits}
 busISA16=$16;               {Bus ISA,16-Bits}
 busEISA=$30;                {Bus EISA}
 busMCA=$40;                 {Bus MCA}
  {Les types de contr“leur CMOS RTC}
 ctrlCmosNo=$00;             {Pas de contr“leur CMOS RTC}
 ctrlCmosUnknown=$01;        {Contr“leur CMOS RTC de modŠle inconnu}
 ctrlCmosMM58167a=$02;       {Contr“leur CMOS RTC MM58167 (2C0h … 2DFh) }
 ctrlCmosMM58167b=$03;       {Contr“leur CMOS RTC MM58167 (2C0h … 2C7h) }
 ctrlCmosRTC58321=$04;       {Contr“leur RTC-58321 (2C0h … 2C1h) }
 ctrlCmosMC146818=$05;       {Contr“leur CMOS RTC MC146818 de Motorola}
  {Constante de type de disque (Interruption 13h)}
 dtNoDrive=0;                {Lecteur introuvable}
 dtDD525=1;                  {Lecteur: 5,25" Double Densit‚}
 dtHD525=2;                  {Lecteur: 5,25" Haute Densit‚}
 dtDD35=3;                   {Lecteur: 3,5" Double Densit‚}
 dtHD35=4;                   {Lecteur: 3,5" Haute Densit‚}
  {Officieusement...}
 dTryMax=5;                  {Nombre d'essais maximal}
  {Constante de partition de disque dur}
 MinPart=1;                  {Nombre minimal partition}
 MaxPart=4;                  {Nombre maximal partition}
  {Les types de contr“leur de Disque Dur}
 ctrlhdNo=$0000;             {Pas de contr“leur de disque dur}
 ctrlhdUnknown=$0001;        {Contr“leur de disque dur inconnu}
 ctrlhdMFM=$0002;            {Contr“leur MFM}
 ctrlhdIDE=$0003;            {Contr“leur IDE}
 ctrlhdScsiTMC1680=$0200;    {Contr“leur SCSI TMC-1680}
 ctrlhdScsiTMC1650=$0203;    {Contr“leur SCSI TMC-1650/1660/1670/1680}
 ctrlhdScsiTMC820=$040A;     {Contr“leur SCSI TMC-820/830/860/870/875/880/885}
 ctrlhdScsiTMC840=$050D;     {Contr“leur SCSI TMC-840/880/881}
 ctrlhdScsiTMC830=$0700;     {Contr“leur SCSI TMC-830/850/860/875/885}
 {Constante de structure d'un disque}
 dskSectorSize=512;          {Taille d'un secteur en octet}
 dskMediaHardDsk=$F8;        {M‚dia de type disque dur}
 dskMediaDbl15SecTrk=$F9;    {M‚dia de type disquette double face,
                              15 secteurs/piste}
 dskMediaSmp9SecTrk=$FC;     {M‚dia de type disquette simple face,
                              9 secteurs/piste}
 dskMediaDbl9SecTrk=$FD;     {M‚dia de type disquette double face,
                              9 secteurs/piste}
 dskMediaSmp8SecTrk=$FE;     {M‚dia de type disquette simple face,
                              8 secteurs/piste}
 dskMediaDbl8SecTrk=$FF;     {M‚dia de type disquette double face,
                              8 secteurs/piste}

  (***** Constante Vid‚o *****)
 {Les diff‚rents nom de modŠle de carte vid‚o}
(* vnUnknown=0;                {D‚tectection automatique}
 vnAhead=1;                  {Ahead}
 vnAheadB=2;                 {Ahead B (SVGA)}
 vnAheadBWizard3270=3;       {Ahead B-Wizard/3270 (SVGA)}
 vnAheadEGA2001=4;           {Ahead EGA2001 (Super EGA)}
 vnAllstarPeacock=5;         {Allstar Peacock (VGA)}
 vnASTVGAPlus=6;             {AST VGA Plus (SVGA)}
 vnATT=7;                    {AT&T}
 vnATT6300=8;                {AT&T 6300 (Super EGA)}
 vnATTVDC600=9;              {AT&T VDC600 (SVGA)}
 vnCardinal=10;              {Cardinal (SVGA)}
 vnCGA=11;                   {CGA}
 vnCirrus=12;                {Cirrus (SVGA)}
 vnCompaqPortable=13;        {Compaq Portable}
 vnCompaqVGA=14;             {Compaq VGA (SVGA)}
 vnCTI82C451=15;             {CTI 82C451 (SVGA)}
 vnCTI82C452=16;             {CTI 82C452 (SVGA)}
 vnDellVGA=17;               {Dell VGA (SVGA)}
 vnEGA=18;                   {EGA}
 vnEGAW800=19;               {EGA Wonder 800+ (Super EGA)}
 vnEGAW800N18800=20;         {EGA Wonder 800+-18800 (Super EGA)}
 vnEGAW800N18800_1=21;       {EGA Wonder 800+-18800-1 (Super EGA)}
 vnEGAW800N28800_2=22;       {EGA Wonder 800+-28800-2 (Super EGA)}
 vnEGAW800N28800_4=23;       {EGA Wonder 800+-28800-4 (Super EGA)}
 vnEGAW800N28800_5=24;       {EGA Wonder 800+-28800-5 (Super EGA)}
 vnEverex=25;                {Everex}
 vnEverexViewPoint=26;       {Everex ViewPoint}
 vnEverexUG2=27;             {Everex UltraGraphics II}
 vnEverexVision=28;          {Everex Vision}
 vnEverexEVGA=29;            {Everex EVGA}
 vnGenoa=30;                 {Genoa}
 vnGenoa5100=31;             {Genoa 5100}
 vnGenoa5300=32;             {Genoa 5300}
 vnGenoa6100=33;             {Genoa 6100}
 vnGenoa6200=34;             {Genoa 6200}
 vnGenoa6400=35;             {Genoa 6400 (SVGA)}
 vnGS=36;                    {Graphics Solution d'ATI (Super CGA)}
 vnGU=37;                    {Graphics Ultra d'ATI (SVGA)}
 vnGUPlus=38;                {Graphics Ultra d'ATI (SVGA)}
 vnGUPro=39;                 {Graphics Ultra d'ATI (SVGA)}
 vnHeadLand=40;              {HeadLand (SVGA)}
 vnHercule=41;               {Hercule (HGC)}
 vnHPD1180A=42;              {Hewlett-Packard D1180A (SVGA)}
 vnHP95LX=43;                {HP 95LX}
 vnIBM8514A=44;              {IBM 8514/AI}
 vnImtec=45;                 {Imtec (SVGA)}
 vnITVGA2=46;                {IT-VGA2 (SVGA)}
 vnLavaChromeIIEGA=47;       {Lava Chrome II EGA (Super EGA)}
 vnLogix=48;                 {Logix (SVGA)}
 vnMCGA=49;                  {MCGA}
 vnMDA=50;                   {MDA}
 vnMaxxon=51;                {Maxxon}
 vnMorseVGA=52;              {Morse VGA (VGA)}
 vnNSISmartEGA=53;           {NSI Smart EGA+ (Super EGA)}
 vnOak=54;                   {Oak Technologies (SVGA)}
 vnOrchid=55;                {Orchid}
 vnOrchidProDesVGA=56;       {Orchid Prodesigner VGA (SVGA)}
 vnOrchidProDesIIVGA=57;     {Orichid Prodesigner II VGA(SVGA/32768 couleurs)}
 vnParadise=58;              {Paradise}
 vnParadiseEGA480=59;        {Paradise EGA-480,Super EGA}
 vnParadisePVGA1A=60;        {Paradise PVGA1A}
 vnParadiseWD90C00=61;       {Paradise WD90C00}
 vnParadiseWD90C10=62;       {Paradise WD90C10}
 vnParadiseWD90C11=63;       {Paradise WD90C11}
 vnPC3270=64;                {PC 3270}
 vnPC3270G=65;               {PC 3270G}
 vnPC3270GX=66;              {PC 3270GX}
 vnPCJr=67;                  {PC Junior}
 vnPGA=68;                   {PGA}
 vnPrismElite=69;            {Prism Elite d'ATI (SVGA)}
 vnQU=70;                    {Quadram Ultra VGA (SVGA)}
 vnSEFCOTVGA=71;             {SEFCO TVGA (SVGA)}
 vnSigma=72;                 {Sigma (SVGA)}
 vnSTB=73;                   {STB (SVGA)}
 vnSTBVGAEM16Plus=74;        {STB VGA/EM-16 Plus (SVGA)}
 vnTatungVGA=75;             {Tatung VGA (SVGA)}
 vnTaxan565EGA=76;           {Taxan 565 EGA (Super EGA)}
 vnTecmarVGAAD=77;           {Tecmar VGA/AD (SVGA)}
 vnTIGA=78;                  {TIGA de Texas Instrument}
 vnTrident8800BR=79;         {Trident 8800BR (SVGA)}
 vnTrident8800CS=80;         {Trident 8800CS (SVGA)}
 vnTrident8900=81;           {Trident 8900 (SVGA)}
 vnT3000=82;                 {Tseng ET3000 (SVGA)}
 vnT4000=83;                 {Tseng ET4000 (SVGA)}
 vnT4000HiColor=84;          {Tseng ET4000 HiColor (SVGA)}
 vnT4000HiColorSC=85;        {Tseng ET4000 HiColor SC (SVGA)}
 vnUltraVisionEGA=86;        {Ultra Vision EGA (Super EGA)}
 vnVESA=87;                  {VESA}
 vnVGA=88;                   {VGA}
 vnVGAW=89;                  {VGA Wonder d'ATI (SVGA)}
 vnVGAW18800=90;             {VGA Wonder d'ATI 18800 (SVGA)}
 vnVGAW18800_1=91;           {VGA Wonder d'ATI 18800-1 (SVGA)}
 vnVGAW28800_2=92;           {VGA Wonder d'ATI 28800-2 (SVGA)}
 vnVGAW28800_4=93;           {VGA Wonder d'ATI 28800-4 (SVGA)}
 vnVGAW28800_5=94;           {VGA Wonder d'ATI 28800-5 (SVGA)}
 vnV7=95;                    {Video 7 (SVGA)}
 vnV7Vram=96;                {Video 7 Vram (SVGA)}
 vnV7Vega=97;                {Video 7 Vega (SVGA)}
 vnV7Ver5=98;                {Video 7 Version 5 (SVGA)}
 vnV71024i=99;               {Video 7 1024i (SVGA)}
 vnVIP=100;                  {ATI VIP (SVGA)}
 vnXGA=101;                  {XGA (SVGA)}
 vnZymos=102;                {Zymos (SVGA)}
 vnZymosPoach=103;           {Zymos Poach (SVGA)}
 vnMatrox=104;               {Matrox}
 vnMatroxMystique=105;       {Matrox Mystique}
 vnMatroxMillenium=106;      {Matrox Millenium}
 vnMatroxG200=107;           {Matrox G200}*)
 vnMax=107;                  {Num‚ro maximal de nom de carte vid‚o.}
 {Cat‚gorie de carte vid‚o}
 cvnNone=0;                  {Aucune,inconnue}
 cvnMDA=1;                   {MDA}
 cvnHGC=2;                   {HGC,GS en mode mono,...}
 cvnCGA=3;                   {GS,CGA,Super CGA,...}
 cvnEGA=4;                   {EGA,Super EGA}
 cvnVGA=5;                   {MCGA,VGA,...}
 cvnSvga=6;                  {Super VGA}
 cvnVESA=7;                  {Super VGA (VESA)}
 {Les diff‚rents modŠle de moniteur}
(* mnUnknown=0;                {Inconnue}
 mn3295=1;                   {3295}
 mn5151=2;                   {5151}
 mn5272=3;                   {5272}
 mn5279=4;                   {5279}
 mn5379C01=5;                {5379C01}
 mn5379M01=6;                {5379M01}
 mn8514=7;                   {8514}
 mnAnalog=8;                 {Analogue}
 mnAnalogKr=9;               {Analogue Couleur}
 mnAnalogMono=10;            {Analogue Monochrome}
 mnAnalogMultiSync=11;       {Analogue MultiSync}
 mnCGA=12;                   {CGA}
 mnDigitalKr=13;             {Digital Couleur}
 mnDigitalMultiSync=14;      {Digital MultiSync}
 mnDigitalTTL=15;            {Digital TTL}
 mnEGA=16;                   {EGA}
 mnFixedSync=17;             {FixedSync}
 mnMDA=18;                   {MDA}
 mnMultiSync=19;             {MultiSync}
 mnMultiSync2A=20;           {MultiSync 2A}
 mnNEC3D=21;                 {NEC 3D}
 mnNECMultiSync=22;          {NEC MultiSync}
 mnRGBkr=23;                 {RGB Couleur}
 mnSeiko1430=24;             {Seiko 1430}
 mnSuperMultiSync=25;        {Super MultiSync}
 mnSuperVGA=26;              {Super VGA}
 mnTatungOmniScan=27;        {Tatung OmniScan}
 mnTTLDigital=28;            {TTL Digital}
 mnTTLMonochrome=29;         {TTL Monochrome}
 mnTVM2A=30;                 {TVM 2A}
 mnTVM3A=31;                 {TVM 3A}
 mnTVM3M=32;                 {TVM 3M}
 mnVGA=33;                   {VGA}*)
 {Constante des modes vid‚os}
 vmTxtBW40=0;                {Texte noir et blanc 40x25}
 vmTxtC40=1;                 {Texte couleur 40x25}
 vmTxtC40x28=$1257;          {Texte couleur 40x28}
 vmTxtC40x43=$1258;          {Texte couleur 40x43}
 vmTxtC40x50=$1259;          {Texte couleur 40x50}
 vmTxtBW80=2;                {Texte noir et blanc 80x25}
 vmTxtC80=3;                 {Texte couleur 80x25}
 vmTxtC80x28=$1260;          {Texte couleur 80x28}
 vmTxtC80x30=$1261;          {Texte couleur 80x30}
 vmTxtC80x33=$1262;          {Texte couleur 80x33}
 vmTxtC80x34=$1263;          {Texte couleur 80x34}
 vmTxtC80x43=$1264;          {Texte couleur 80x43}
 vmTxtC80x50=$1265;          {Texte couleur 80x50}
 vmTxtC80x60=$1266;          {Texte couleur 80x60}
 vmTxtC80x66=$1267;          {Texte couleur 80x66}
 vmTxtC100x30=$1268;         {Texte couleur 100x30}
 vmTxtC100x37=$1269;         {Texte couleur 100x37}
 vmTxtC100x40=$126A;         {Texte couleur 100x40}
 vmTxtC100x50=$1270;         {Texte couleur 100x50}
 vmTxtC100x60=$1271;         {Texte couleur 100x60}
 vmTxtC100x75=$1272;         {Texte couleur 100x75}
 vmTxtC120x25=$1273;         {Texte couleur 120x25}
 vmTxtC120x43=$1274;         {Texte couleur 120x43}
 vmTxtC132=$1275;            {Texte couleur 132x25}
 vmTxtC132x28=$1276;         {Texte couleur 132x28}
 vmTxtC132x30=$1277;         {Texte couleur 132x30}
 vmTxtC132x43=$1278;         {Texte couleur 132x43}
 vmTxtC132x44=$1279;         {Texte couleur 132x44}
 vmTxtC132x50=$1280;         {Texte couleur 132x50}
 vmTxtC132x60=$1281;         {Texte couleur 132x60}
 vmTxtC132x100=$1282;        {Texte couleur 132x100}
 vmTxtC160x50=$1283;         {Texte couleur 160x50}
 vmTxtMono=7;                {Texte monochrome 80x25}
 vmTxtMono80x28=$1284;       {Texte monochrome 80x28}
 vmTxtMono80x30=$1285;       {Texte monochrome 80x30}
 vmTxtMono80x34=$1286;       {Texte monochrome 80x34}
 vmTxtMono80x43=$1287;       {Texte monochrome 80x43}
 vmTxtMono80x50=$1288;       {Texte monochrome 80x50}
 vmTxtMono80x60=$1289;       {Texte monochrome 80x60}
 vmTxtMono100x40=$128A;      {Texte monochrome 100x40}
 vmTxtMono100x60=$128B;      {Texte monochrome 100x60}
 vmTxtMono132=$128C;         {Texte monochrome 132x25}
 vmTxtMono132x28=$128D;      {Texte monochrome 132x28}
 vmTxtMono132x43=$128E;      {Texte monochrome 132x43}
 vmTxtMono132x44=$128F;      {Texte monochrome 132x44}
 vmHerc=$1321;               {Hercule monochrome 720x348}
 vmMinKrMode320x200=$1322;   {Avec le nombre minimal de
                              couleur en 320x200 pixels}
 vmMaxKrMode320x200=$1323;   {Avec le nombre maximal de
                              couleur en 320x200 pixels}
 vmGrf240x128c2=$1324;       {Graphique 240x128 en 2 couleurs}
 vmGrf320x200c4=5;           {Graphique 320x200 en 4 couleurs}
 vmGrf320x200c16=13;         {Graphique 320x200 en 16 couleurs}
 vmGrf320x200c256=19;        {Graphique 320x200 en 256 couleurs}
 vmGrf320x200C32768=$1325;   {Graphique 320x200 en 32768 couleurs}
 vmGrf320x200C65536=$1326;   {Graphique 320x200 en 65536 couleurs}
 vmGrf320x400c256=$1327;     {Graphique 320x400 en 256 couleurs}
 vmGrf360x480c256=$1328;     {Graphique 360x480 en 256 couleurs}
 vmGrf512x512c16=$1329;      {Graphique 512x512 en 16 couleurs}
 vmGrf512x512c256=$132A;     {Graphique 512x512 en 256 couleurs}
 vmMinKrMode640x200=6;       {Mode avec le nombre minimal de couleur
                              en 640x200 pixels}
 vmMaxKrMode640x200=$132B;   {Mode avec le nombre maximal de couleur
                              en 640x200 pixels}
 vmGrf640x200c2=6;           {Graphique 640x200 en 2 couleurs}
 vmGrf640x200c4=10;          {Graphique 640x200 en 4 couleurs}
 vmGrf640x200c16=14;         {Graphique 640x200 en 16 couleurs}
 vmMinKrMode640x350=$132C;   {Mode avec le nombre minimal de couleur
                              en 640x350 pixels}
 vmMaxKrMode640x350=$132D;   {Mode avec le nombre maximal de couleur
                              en 640x350 pixels}
 vmGrf640x350c2=$132E;       {Graphique 640x350 en
                              2 couleurs}
 vmGrf640x350c4=$132F;       {Graphique 640x350 en
                              4 couleurs}
 vmGrf640x350c16=$1330;      {Graphique 640x350 en
                              16 couleurs}
 vmGrf640x350c256=$1331;     {Graphique 640x350 en
                              256 couleurs}
 vmGrf640x350c32768=$1332;   {Graphique 640x350 en
                              32768 couleurs}
 vmMinKrMode640x400=$1333;   {Mode avec le nombre minimal de couleur
                              en 640x400 pixels}
 vmMaxKrMode640x400=$1334;   {Mode avec le nombre maximal de couleur
                              en 640x400 pixels}
 vmGrf640x400c2=$1335;       {Graphique 640x400 en 2 couleurs}
 vmGrf640x400c16=$1336;      {Graphique 640x400 en 16 couleurs}
 vmGrf640x400c256=$1337;     {Graphique 640x400 en 256 couleurs}
 vmGrf640x400c32768=$1338;   {Graphique 640x400 en 32768 couleurs}
 vmGrf640x462c16=$1339;      {Graphique 640x462 en 16 couleurs}
 vmMinKrMode640x480=17;      {Mode avec le nombre minimal de couleur
                              en 640x480 pixels}
 vmMaxKrMode640x480=$133A;   {Mode avec le nombre maximal de couleur
                              en 640x480 pixels}
 vmGrf640x480c2=17;          {Graphique 640x480 en 2 couleurs}
 vmGrf640x480c16=$133B;      {Graphique 640x480 en 16 couleurs}
 vmGrf640x480c256=$133C;     {Graphique 640x480 en 256 couleurs}
 vmGrf640x480c32768=$133D;   {Graphique 640x480 en 32768 couleurs}
 vmGrf640x480c65536=$133E;   {Graphique 640x480 en 65536 couleurs}
 vmGrf640x480c16M=$133F;     {Graphique 640x480 en 16777216 de couleurs}
 vmGrf720x350c2=$1340;       {Graphique 720x350 en 2 couleurs}
 vmGrf720x392c16=$1341;      {Graphique 720x392 en 16 couleurs}
 vmGrf720x512c16=$1342;      {Graphique 720x512 en 16 couleurs}
 vmGrf720x512c256=$1343;     {Graphique 720x512 en 256 couleurs}
 vmGrf720x540c16=$1344;      {Graphique 720x540 en 16 couleurs}
 vmGrf720x540c256=$1345;     {Graphique 720x540 en 256 couleurs}
 vmGrf752x410c16=$1346;      {Graphique 752x410 en 16 couleurs}
 vmGrf768x1024c16=$1347;     {Graphique 768x1024 en 16 couleurs}
 vmGrf800x560c16=$1348;      {Graphique 800x560 en 16 couleurs}
 vmMinKrMode800x600=$1349;   {Mode avec le nombre minimal de couleur
                              en 800x600 pixels}
 vmMaxKrMode800x600=$134A;   {Mode avec le nombre maximal de couleur
                              en 800x600 pixels}
 vmGrf800x600c2=$134B;       {Graphique 800x600 en 2 couleurs}
 vmGrf800x600c16=$134C;      {Graphique 800x600 en 16 couleurs}
 vmGrf800x600c256=$134D;     {Graphique 800x600 en 256 couleurs}
 vmGrf800x600c32768=$134E;   {Graphique 800x600 en 32768 couleurs}
 vmGrf800x600c65536=$134F;   {Graphique 800x600 en 65536 couleurs}
 vmGrf960x720c16=$1350;      {Graphique 960x720 en 16 couleurs}
 vmMinKrMode1024x768=$1351;  {Mode avec le nombre minimal de couleur
                              en 1024x768 pixels}
 vmMaxKrMode1024x768=$1352;  {Mode avec le nombre maximal de couleur
                              en 1024x768 pixels}
 vmGrf1024x768c2=$1353;      {Graphique 1024x768 en 2 couleurs}
 vmGrf1024x768c4=$1354;      {Graphique 1024x768 en 4 couleurs}
 vmGrf1024x768c16=$1355;     {Graphique 1024x768 en 16 couleurs}
 vmGrf1024x768c256=$1356;    {Graphique 1024x768 en 256 couleurs}
 vmGrf1024x768c32768=$1357;  {Graphique 1024x768 en 32768 couleurs}
 vmGrf1280x1024c16=$1358;    {Graphique 1280x1024 en 16 couleurs}
 vmGrf1280x1024c256=$1359;   {Graphique 1280x1024 en 256 couleurs}
 vmTxtDef=$12F0;             {Texte 80x25 en couleur ou monochrome}
 vmTxtMaxRes80=$12F1;        {Texte avec la r‚solution maximal en 80 colonnes}
 vmTxtMaxRes=$12F2;          {Texte avec la r‚solution maximal}
 vmNone=$FFFE;               {Pas de mode vid‚o}
  {Constante des couleurs standard et d'attribut de caractŠre}
 Black=0;                    {Noir}
 Blue=1;                     {Bleu}
 Green=2;                    {Vert}
 Cyan=3;                     {Cyan}
 Red=4;                      {Rouge}
 Magenta=5;                  {Magenta}
 Brown=6;                    {Brun}
 LightGray=7;                {Gris pƒle}
 DarkGray=8;                 {Gris fonc‚}
 LightBlue=9;                {Bleu claire}
 LightGreen=10;              {Vert claire}
 LightCyan=11;               {Cyan claire}
 LightRed=12;                {Rouge claire}
 LightMagenta=13;            {Magenta claire}
 Yellow=14;                  {Jaune}
 White=15;                   {Blanc}
  {Constante des modŠles de curseur Isabel}
 curTxt=0;                   {Standard Texte}
 curCoco3=1;                 {ModŠle Coco3 du mode texte basse d‚finition}
 curCK64=2;                  {ModŠle Commodore 64Ko,carr‚ bleu clignotant}

  (***** Constante Clavier *****)
  {Les types de contr“leur clavier}
 ctrlkbNo=$00;               {Pas de contr“leur clavier,je pr‚sume que cela
                              arrivera dans le futur...}
 ctrlkbUnknown=$01;          {Contr“leur clavier inconnu}
 ctrlkb8048=$02;             {Contr“leur clavier des PC,XT,PC Junior}
 ctrlkb8042=$03;             {Contr“leur clavier des AT,PS/2}
  {Les styles de clavier (keyboard)}
 kbPC=$00;                   {Clavier PC original}
 kbXT=$01;                   {Clavier XT original}
 kbAT=$04;                   {Clavier AT de 84 touches}
 kbConterm=$40;              {Clavier Conterm Max/int‚gr‚ aux boŒtier
                              de l'ordinateur}
 kbMF=$80;                   {Clavier MF de 101/102 touches}
  {Code de touche clavier brute du contr“leur (Standard Querty)}
(* rqkEsc=1;                   {Escape}
 rqk1=2;                     {1}
 rqk2=3;                     {2}
 rqk3=4;                     {3}
 rqk4=5;                     {4}
 rqk5=6;                     {5}
 rqk6=7;                     {6}
 rqk7=8;                     {7}
 rqk8=9;                     {8}
 rqk9=$0A;                   {9}
 rqk0=$0B;                   {0}
 rqkMoin=$0C;                {-}
 rqkEqual=$0D;               {=}
 rqkBS=$0E;                  {BackSpace}
 rqkTab=$0F;                 {Tabulation}
 rqkQ=$10;                   {Q}
 rqkW=$11;                   {W}
 rqkE=$12;                   {E}
 rqkR=$13;                   {R}
 rqkT=$14;                   {T}
 rqkY=$15;                   {Y}
 rqkU=$16;                   {U}
 rqkI=$17;                   {I}
 rqkO=$18;                   {O}
 rqkP=$19;                   {P}
 rqk1QuoteLeft=$1A;          {[}
 rqk1QuoteRight=$1B;         {]}
 rqkEnter=$1C;               {Enter}
 rqkCtrl=$1D;                {Ctrl}
 rqkA=$1E;                   {A}
 rqkS=$1F;                   {S}
 rqkD=$20;                   {D}
 rqkF=$21;                   {F}
 rqkG=$22;                   {G}
 rqkH=$23;                   {H}
 rqkJ=$24;                   {J}
 rqkK=$25;                   {K}
 rqkL=$26;                   {L}
 rqkSemicolon=$27;           {;}
 rqkApostrophe=$28;          {'}
 rqkApoInv=$29;              {`}
 rqkShiftLeft=$2A;           {Shift de gauche}
 rqkZ=$2C;                   {Z}
 rqkX=$2D;                   {X}
 rqkC=$2E;                   {C}
 rqkV=$2F;                   {V}
 rqkB=$30;                   {B}
 rqkN=$31;                   {N}
 rqkM=$32;                   {M}
 rqkFloat=$33;               {,}
 rqkComma=$34;               {.}
 rqkSlash=$35;               {/}
 rqkShiftRight=$36;          {Shift de droite}
 rqkAsterix=$37;             {*}
 rqkAlt=$38;                 {Alt}
 rqkSpaceBar=$39;            {Barre d'espacement}
 rqkCapsLck=$3A;             {CapsLock/MajusculeVerrouill‚e}
 rqkF1=$3B;                  {F1}
 rqkF2=$3C;                  {F2}
 rqkF3=$3D;                  {F3}
 rqkF4=$3E;                  {F4}
 rqkF5=$3F;                  {F5}
 rqkF6=$40;                  {F6}
 rqkF7=$41;                  {F7}
 rqkF8=$42;                  {F8}
 rqkF9=$43;                  {F9}
 rqkF10=$44;                 {F10}
 rqkNumLck=$45;              {NumLock}
 rqkScrollLck=$46;           {ScrollLock}
 rqkHome=$47;                {Home}
 rqkUp=$48;                  {Up}
 rqkPgUp=$49;                {PageUp}
 rqkLeft=$4B;                {Gauche}
 rqkKeypad5=$4C;             {5 du bloc num‚rique}
 rqkRight=$4D;               {Droite}
 rqkPlus=$4E;                {+}
 rqkEnd=$4F;                 {End/Fin}
 rqkDown=$50;                {Bas}
 rqkPgDn=$51;                {PageDown}
 rqkIns=$52;                 {Insert}
 rqkDel=$53;                 {Delete}
 rqkSysRq=$54;               {SysReq}
 rqkBackSlash=$56;           {\ (101/102 touches seulement)}
 rqkF11=$57;                 {F11 (101/102 touches seulement)}
 rqkF12=$58;                 {F12 (101/102 touches seulement)}
 rqkPA1=$5A;                 {PA1 (122 touches seulement)}
 rqkF13=$5B;                 {F13 (122 touches seulement) }
 rqkF14=$5C;                 {F14 (122 touches seulement) }
 rqkF15=$5D;                 {F15 (122 touches seulement) }
 rqkF16=$63;                 {F16 (122 touches seulement) }
 rqkF17=$64;                 {F17 (122 touches seulement) }
 rqkF18=$65;                 {F18 (122 touches seulement) }
 rqkF19=$66;                 {F19 (122 touches seulement) }
 rqkF20=$67;                 {F20 (122 touches seulement) }
 rqkF21=$68;                 {F21 (122 touches seulement) }
 rqkF22=$69;                 {F22 (122 touches seulement) }
 rqkF23=$6A;                 {F23 (122 touches seulement) }
 rqkF24=$6B;                 {F24 (122 touches seulement) }
 rqkEraseEOF=$6D;            {Efface EOF (122 touches seulement)}
 rqkCopyPlay=$6F;            {Copy/Play (122 touches seulement)}
 rqkCrSel=$72;               {CrSel (122 touches seulement)}
 rqkExSel=$74;               {ExSel (122 touches seulement)}
 rqkClr=$76;                 {Clear (122 touches seulement) }
  {Attribut des "Hot Key"}
 mNone=0;                    {Aucun}
 mShiftRight=1;              {Shift droite}
 mShiftLeft=2;               {Shift gauche}
 mShift=3;                   {Shift}
 mCtrl=4;                    {Ctrl}
 mAlt=8;                     {Alt}
  {Code de touche clavier renvoy‚e par ReadKey}
 kbNoKey=0;                  {Pas de touche}
 kbEsc=$011B;                {Escape}
 kbAltSpc=$0200;             {Alt+SpaceBar}
 kbCtrl2=$0300;              {Ctrl+2}
 kbShiftIns=$0500;           {Shift+Insert}
 kbCtrlDel=$0600;            {Ctrl+Delete}
 kbShiftDel=$0700;           {Shift+Delete}
 kbCtrl6=$071E;              {Ctrl+6}
 kbCtrlMinus=$0C1F;          {Ctrl+-_...}
 kbAltBS=$0E00;              {Alt+BackSpace}
 kbBS=$0E08;                 {BackSpace}
 kbCtrlBS=$0E7F;             {Ctrl+BackSpace}
 kbShiftTab=$0F00;           {Shift+Tabulation}
 kbTab=$0F09;                {Tabulation}
 kbAltQ=$1000;               {Alt+Q}
 kbCtrlQ=$1011;              {Ctrl+Q}
 kbAltW=$1100;               {Alt+W}
 kbCtrlW=$1117;              {Ctrl+W}
 kbAltE=$1200;               {Alt+E}
 kbCtrlE=$1205;              {Ctrl+E}
 kbAltR=$1300;               {Alt+R}
 kbCtrlR=$1312;              {Ctrl+R}
 kbAltT=$1400;               {Alt+T}
 kbCtrlT=$1414;              {Ctrl+T}
 kbAltY=$1500;               {Alt+Y}
 kbCtrlY=$1519;              {Ctrl+Y}
 kbAltU=$1600;               {Alt+U}
 kbCtrlU=$1615;              {Ctrl+U}
 kbAltI=$1700;               {Alt+I}
 kbCtrlI=$1709;              {Ctrl+I}
 kbAltO=$1800;               {Alt+O}
 kbCtrlO=$180F;              {Ctrl+O}
 kbAltP=$1900;               {Alt+P}
 kbCtrlP=$1910;              {Ctrl+P}
 kbCtrlOpenBox=$1A1B;        {Ctrl+'['}
 kbAltOpenBox=$1AF0;         {Alt+'['}
 kbCtrlCloseBox=$1B1D;       {Ctrl+']'}
 kbAltCloseBox=$1BF0;        {Alt+']'}
 kbCtrlEnter=$1C0A;          {Ctrl+Enter}
 kbEnter=$1C0D;              {Enter}
 kbAltA=$1E00;               {Alt+A}
 kbCtrlA=$1E01;              {Ctrl+A}
 kbAltS=$1F00;               {Alt+S}
 kbCtrlS=$1F13;              {Ctrl+S}
 kbAltD=$2000;               {Alt+D}
 kbCtrlD=$2004;              {Ctrl+D}
 kbAltF=$2100;               {Alt+F}
 kbCtrlF=$2106;              {Ctrl+F}
 kbAltG=$2200;               {Alt+G}
 kbCtrlG=$2207;              {Ctrl+G}
 kbAltH=$2300;               {Alt+H}
 kbCtrlH=$2308;              {Ctrl+H}
 kbAltJ=$2400;               {Alt+J}
 kbCtrlJ=$240A;              {Ctrl+J}
 kbAltK=$2500;               {Alt+K}
 kbCtrlK=$250B;              {Ctrl+K}
 kbAltL=$2600;               {Alt+L}
 kbCtrlL=$260C;              {Ctrl+L}
 kbAltQuote=$28F0;           {Alt+"}
 kbAltEnviron=$29F0;         {Alt+~}
 kbCtrlBkSl=$2B1C;           {Ctrl+\}
 kbAltBkSl=$2BF0;            {Alt+\}
 kbAltZ=$2C00;               {Alt+Z}
 kbCtrlZ=$2C1A;              {Ctrl+Z}
 kbAltX=$2D00;               {Alt+X}
 kbCtrlX=$2D18;              {Ctrl+X}
 kbAltC=$2E00;               {Alt+C}
 kbCtrlC=$2E03;              {Ctrl+C}
 kbAltV=$2F00;               {Alt+V}
 kbCtrlV=$2F16;              {Ctrl+V}
 kbAltB=$3000;               {Alt+B}
 kbCtrlB=$3002;              {Ctrl+B}
 kbAltN=$3100;               {Alt+N}
 kbCtrlN=$310E;              {Ctrl+N}
 kbAltM=$3200;               {Alt+M}
 kbCtrlM=$320D;              {Ctrl+M}
 kbAltLess=$3300;            {Alt+'<'}
 kbAltGreat=$3400;           {Alt+'>'}
 kbAltQuestion=$35F0;        {Alt+'?'}
 kbAltMult=$3700;            {Alt+'*'}
 kbSpc=$3920;                {Space}
 kbF1=$3B00;                 {F1}
 kbF2=$3C00;                 {F2}
 kbF3=$3D00;                 {F3}
 kbF4=$3E00;                 {F4}
 kbF5=$3F00;                 {F5}
 kbF6=$4000;                 {F6}
 kbF7=$4100;                 {F7}
 kbF8=$4200;                 {F8}
 kbF9=$4300;                 {F9}
 kbF10=$4400;                {F10}
 kbHome=$4700;               {Home}
 kbUp=$4800;                 {Up}
 kbPgUp=$4900;               {PageUp}
 kbGrayMinus=$4A2D;          {- fonc‚}
 kbAltGrayMinus=$4AF0;       {Alt+ - fonc‚}
 kbLeft=$4B00;               {FlŠche de gauche (Left)}
 kbKeypad5=$4CF0;            {5 du bloc num‚rique}
 kbRight=$4D00;              {FlŠche de droite (Right)}
 kbGrayPlus=$4E2B;           {+ fonc‚}
 kbAltGrayPlus=$4EF0;        {Alt+ + fonc‚}
 kbEnd=$4F00;                {End}
 kbDn=$5000;                 {FlŠche du bas (Down)}
 kbPgDn=$5100;               {PageDown}
 kbIns=$5200;                {Insert}
 kbDel=$5300;                {Delete}
 kbShiftF1=$5400;            {Shift+F1}
 kbShiftF2=$5500;            {Shift+F2}
 kbShiftF3=$5600;            {Shift+F3}
 kbShiftF4=$5700;            {Shift+F4}
 kbShiftF5=$5800;            {Shift+F5}
 kbShiftF6=$5900;            {Shift+F6}
 kbShiftF7=$5A00;            {Shift+F7}
 kbShiftF8=$5B00;            {Shift+F8}
 kbShiftF9=$5C00;            {Shift+F9}
 kbShiftF10=$5D00;           {Shift+F10}
 kbCtrlF1=$5E00;             {Ctrl+F1}
 kbCtrlF2=$5F00;             {Ctrl+F2}
 kbCtrlF3=$6000;             {Ctrl+F3}
 kbCtrlF4=$6100;             {Ctrl+F4}
 kbCtrlF5=$6200;             {Ctrl+F5}
 kbCtrlF6=$6300;             {Ctrl+F6}
 kbCtrlF7=$6400;             {Ctrl+F7}
 kbCtrlF8=$6500;             {Ctrl+F8}
 kbCtrlF9=$6600;             {Ctrl+F9}
 kbCtrlF10=$6700;            {Ctrl+F10}
 kbAltF1=$6800;              {Alt+F1}
 kbAltF2=$6900;              {Alt+F2}
 kbAltF3=$6A00;              {Alt+F3}
 kbAltF4=$6B00;              {Alt+F4}
 kbAltF5=$6C00;              {Alt+F5}
 kbAltF6=$6D00;              {Alt+F6}
 kbAltF7=$6E00;              {Alt+F7}
 kbAltF8=$6F00;              {Alt+F8}
 kbAltF9=$7000;              {Alt+F9}
 kbAltF10=$7100;             {Alt+F10}
 kbCtrlPrtSc=$7200;          {Ctrl+PrintScreen}
 kbCtrlLeft=$7300;           {Ctrl+FlŠche de gauche}
 kbCtrlRight=$7400;          {Ctrl+FlŠche de droite}
 kbCtrlEnd=$7500;            {Ctrl+End}
 kbCtrlPgDn=$7600;           {Ctrl+PageDown}
 kbCtrlHome=$7700;           {Ctrl+Home}
 kbAlt1=$7800;               {Alt+1}
 kbAlt2=$7900;               {Alt+2}
 kbAlt3=$7A00;               {Alt+3}
 kbAlt4=$7B00;               {Alt+4}
 kbAlt5=$7C00;               {Alt+5}
 kbAlt6=$7D00;               {Alt+6}
 kbAlt7=$7E00;               {Alt+7}
 kbAlt8=$7F00;               {Alt+8}
 kbAlt9=$8000;               {Alt+9}
 kbAlt0=$8100;               {Alt+0}
 kbAltMinus=$8200;           {Alt+-}
 kbAltEqual=$8300;           {Alt+=}
 kbCtrlPgUp=$8400;           {Ctrl+PageUp}
 kbF11=$8500;                {F11}
 kbF12=$8600;                {F12}
 kbShiftF11=$8700;           {Shift+F11}
 kbShiftF12=$8800;           {Shift+F12}
 kbCtrlF11=$8900;            {Ctrl+F11}
 kbCtrlF12=$8A00;            {Ctrl+F12}
 kbAltF11=$8B00;             {Alt+F11}
 kbAltF12=$8C00;             {Alt+F12}
 kbCtrlUp=$8D00;             {Ctrl+FlŠche de haut}
 kbCtrlDn=$8E00;             {Ctrl+FlŠche de bas}
 kbCtrlIns=$9200;            {Ctrl+Insert}
 kbAltGraySlash=$A400;       {Ctrl+/ fonc‚}
 {*** Code Non-Standard pour Isabel ***}
 kbAltEsc=$9100;             {Alt+Esc}
 kbCtrlEsc=$911B;            {Ctrl+Esc}
 kbShiftEsc=$921B;           {Shift+Esc}
 kbCtrlAltEsc=$9300;         {Ctrl+Alt+Esc}
 kbShiftWindows95=$C100;     {Shift+Touche Windows 95}
 kbShiftWindows95Menu=$C400; {Shift+Touche Windows 95}
 kbCtrlWindows95=$CE00;      {Ctrl+Touche Windows 95}
 kbCtrlWindows95Menu=$D000;  {Ctrl+Touche Windows 95 Menu}
 kbAltWindows95=$DA00;       {Ctrl+Touche Windows 95}
 kbAltWindows95Menu=$DC00;   {Ctrl+Touche Windows 95 Menu}
 kbPrgOutWin=$E600;          {P‚riph‚rique pointeur … l'ext‚rieur
                              de la fenˆtre }
 kbPrgLastBar=$E700;         {P‚riph‚rique pointeur demande la dernier ligne}
 kbPrgMnuBar=$E800;          {P‚riph‚rique pointeur demande la bar de menu }
 kbPrgTitle=$E900;           {P‚riph‚rique pointeur demande le titre}
 kbPrgClsIcon=$EA00;         {P‚riph‚rique pointeur demande l'Ic“ne de
                              fermeture programme}
 kbDnBar=$EB00;              {P‚riph‚rique pointeur demande le Bas de la bar}
 kbWindows95Left=$EC00;      {Touche Windows 95 de gauche}
 kbDnBarMs=$EC80;            {P‚riph‚rique pointeur demande l'Ic“ne Bas de
                              la barre}
 kbWindows95Right=$ED00;     {Touche Windows 95 de droite}
 kbRBarMsPgUp=$ED80;         {P‚riph‚rique pointeur demande la page
                              pr‚c‚dente}
 kbWindows95Menu=$EE00;      {Touche Windows 95 Menu}
 kbRBarMsPgDn=$EF00;         {P‚riph‚rique pointeur demande la page suivante}
 kbDataBar=$FFE0;            {DerniŠre ligne de la fenˆtre}
 kbRBarMsUp=$FFF0;           {P‚riph‚rique pointeur demande la ligne
                              pr‚c‚dente}
 kbRBarMsDn=$FFF1;           {P‚riph‚rique pointeur demande la ligne suivante}
 kbRBarMs=$FFF2;             {P‚riph‚rique pointeur demande la ligne}
 kbInWn=$FFF3;               {P‚riph‚rique pointeur … l'int‚rieur de la
                              fenˆtre}
 kbDef=$FFF4;                {Option par ®D‚faut¯}
 kbHelp=$FFF6;               {Option d'®Aide¯}
 kbOk=kbEnter;               {Option ®Correcte¯}
 kbCancel=kbEsc;             {Option d'®Annulation¯}
 kbYes=kbEnter;              {Option ®Oui¯}
 kbNo=kbEsc;                 {Option ®Non¯}
 kbIgnore=$FFF7;             {Option ®Ignore¯}
 kbRetry=$FFF9;              {Option ®R‚essayer¯}
 kbAbort=$FFF8;              {Option ®Abandon¯}
 kbClose=$FFFA;              {P‚riph‚rique pointeur demandant de terminer le
                              programme}
 kbCloseWin=$FFFA;           {P‚riph‚rique pointeur demandant l'Ic“ne de
                              fermeture}
 kbExit=$FFFB;               {P‚riph‚rique pointeur demandant de quitter}
 kbTitle=$FFFC;              {P‚riph‚rique pointeur demandant le titre}
 kbZoom=$FFFD;               {P‚riph‚rique pointeur demandant une
                              agrandissement}
 kbMouse=$FFFE;              {R‚action p‚riph‚rique souris}
 kbUnknown=$FFFF;            {Inconnue}*)

 {>ÄÄÄÅÄ CP/M, Dos, OS/2 ÄÅÄÄÄ<}
  {Prompt}
(* cpmPromptDef='>';           {Prompt par d‚faut du CP/M, Dos & OS/2}
  {Convention des chemins}
 dosSubDirSep='\';           {S‚parateur des sous-r‚pertoires sous Dos, OS/2}
 dosDirSep=';';              {S‚parateur des chemins sous Dos,OS/2}
 { >ÄÅÄÅÄ Unix ÄÅÄÅÄ< }
  { Prompt }
 unxPromptDef='$';           {Prompt Unix par d‚faut}
 unxPS1Def='$';              {1ier prompt Unix par d‚faut}
 unxPS2Def='>';              {2iŠme prompt Unix par d‚faut}
 {Convention des chemins}
 unxSubDirSep='/';
 unxDirSep=':';
 {R‚pertoire par d‚faut}
 unxPathDef=':/bin:/usr/bin';        {PATH par d‚faut}
 unxDirBin='/bin';                   {Fichier ex‚cutable}
 unxDirDev='/dev';                   {R‚pertoire des pilotes}
 unxDirCInc='/usr/include';          {R‚pertoire des *.H du langage C/C++}
 unxDirSpooler='/usr/spool';         {R‚pertoire du Spooler}
 unxDirAdmErrMsg='/usr/adm/messages';{R‚pertoire des messages d'erreur centrale}
 unxDirTmp='/tmp';                   {R‚pertoire de travaux temporaire}*)
  {Les modes Windows}
 winNo=$00;                  {Pas de Windows actif}
 win386X=$01;                {Windows /386 Version 2.X}
 winReal=$81;                {Windows fonctionne en mode r‚el}
 winStandard=$82;            {Windows fonctionne en mode standard}
 winEnhanced=$83;            {Windows fonctionne en mode ‚tendu}
 winNT=$C0;                  {Windows NT}

  (***** Constante de Souris *****)
  {Les pilotes souris}
 msNoMouse=$00;              {Pas de souris}
 msLogitech=$01;             {Souris Logitech}
 msMicrosoft=$02;            {Souris Microsoft}
 msSmooth=$03;               {Souris Smooth de Andy Hakim}
 msZNIX=$04;                 {Souris Z-NIX}
 msGenius=$05;               {Souris Genius}
 msStandard=$80;             {Souris standard}
  {Les masques d'‚venements de la souris}
 meMsMove=1;                 {D‚placement de la souris}
 meLeftButPressed=2;         {Le bouton de gauche enfonc‚}
 meLeftButReleased=4;        {Le bouton de gauche relƒch‚}
 meRightButPressed=8;        {Le bouton de droite enfonc‚}
 meRightButReleased=16;      {Le bouton de droite relƒch‚}
 meMiddleButPressed=32;      {Le bouton du centre enfonc‚}
 meMiddleButReleased=64;     {Le bouton du centre enfonc‚}
 meAll=$7F;                  {Tous changements de la part de la souris
                              (D‚placement, Bouton,...)}
  {Les types de pointeurs de souris}
 mpTxtAttr=0;                {Pointeur Souris en inverse d'attribut texte }
 mpTxtCur=1;                 {Pointeur Souris en utilisant le curseur}
 mpTxtGrf=2;                 {Pointeur Souris en cr‚ant artificiellement
                              pointeur graphique en texte}
 mpGrf=3;                    {Pointeur Souris Graphique}

 (***** Son *****)
  {Sortie de son (Sound Output)}
(* soLPT1=$01;                 {Port ParallŠle 1}
 soLPT2=$02;                 {Port ParallŠle 2}
 soSoundBlaster=$03;         {SoundBlaster}
 soPCSpeaker=$04;            {PC Speaker}
 soStereoLPT1N2=$05;         {St‚r‚o par le Port ParallŠle 1 et 2}
 soSoundBlasterPro=$06;      {SoundBlasterPro}
 soStereoLPT1=$07;           {St‚r‚o par le port parallŠle 1}
 soStereoLPT2=$08;           {St‚r‚o par le port parallŠle 2}
 soLPT3=$09;                 {Port ParallŠle 3}
 soMonoLPT1N2=$0A;           {Mono par le port parallŠle 1 et 2}
 soMonoUserDef=$0B;          {Mono d‚finie par l'utilisateur}
 soStereoUserDef=$0C;        {St‚r‚o d‚finie par l'utilisateur}
 soDisneySoundLPT1=$0D;      {Disney-Sound par le port parallŠle 1}
 soDisneySoundLPT2=$0E;      {Disney-Sound par le port parallŠle 2}
 soDisneySoundLPT3=$0F;      {Disney-Sound par le port parallŠle 3}
 soQuadOn1LPT=$10;           {Quadrophonique par le port parallŠle 1}
 soAdLib=$11;                {AdLib}
 soGravisUltraSound=$12;     {Gravis Ultra Sound}
 soRolandMPU401=$13;         {Roland MPU 401}
 soTandyDigital=$14;         {Tandy Digital}
 soNul=$FF;                  {Pas de sortie}*)
  {Constante de la carte AdLib}
 AdLibGTMin=0;
 AdLibGTMax=10;

  (***** Communication *****)
 {Contr“le ASCII}
 caNUL=$00;                  {Ctrl+@: Nulle (Null)}
 caSOH=$01;                  {Ctrl+A (Start Of Heading)}
 caSTX=$02;                  {Ctrl+B (Start of TeXt)}
 caETX=$03;                  {Ctrl+C: Arrˆte le processus en cours
                              (End of TeXt, Break)}
 caEOT=$04;                  {Ctrl+D (End of Transmission)}
 caENQ=$05;                  {Ctrl+E (Enquiry)}
 caACK=$06;                  {Ctrl+F (Acknowledgement)}
 caBELL=$07;                 {Ctrl+G: Bip sonore (Bell/Beep)}
 caBS=$08;                   {Ctrl+H: Recule et efface le caractŠre
                              (BackSpace)}
 caHT=$09;                   {Ctrl+I: Tabulation horizontal
                              (Horizontal Tabulation)}
 caLF=$0A;                   {Ctrl+J: D‚placement vers le bas (Line Feed)}
 caVT=$0B;                   {Ctrl+K: Tabulation vertical
                              (Vertical Tabulation)}
 caFF=$0C;                   {Ctrl+L: Efface l'‚cran (Form Feed)}
 caCR=$0D;                   {Ctrl+M: Retour de chariot (Carriage Return)}
 caSO=$0E;                   {Ctrl+N: (Shift Out, Echo off)}
 caSI=$0F;                   {Ctrl+O: (Shift In)}
 caDLE=$10;                  {Ctrl+P: (Data Link Escape, Echo on)}
 caXON=$11;                  {Ctrl+Q: Device Control 1 (DC1/X-ON)}
 caDC2=$12;                  {Ctrl+R: (Device Control 2)}
 caXOFF=$13;                 {Ctrl+S: Device Conreol 3 (DC1/X-OFF/Pause)}
 caDC4=$14;                  {Ctrl+T: (Device Control 4)}
 caNAK=$15;                  {Ctrl+U: (Negative acknownledge)}
 caSYN=$16;                  {Ctrl+V: (Synchronous idle)}
 caETB=$17;                  {Ctrl+W: (End of Transmission Block)}
 caCAN=$18;                  {Ctrl+X: Efface la ligne courant (Cancel)}
 caEM=$19;                   {Ctrl+Y: (End of Medium)}
 caSUB=$1A;                  {Ctrl+Z: (Substitute)}
 caESC=$1B;                  {Ctrl+[: Echappatoire (Escape)}
 caFS=$1C;                   {Ctrl+\: (File Separator)}
 caGS=$1D;                   {Ctrl+]: (Groupe Separator)}
 caRS=$1E;                   {Ctrl+^: (Record Separator)}
 caUS=$1F;                   {Ctrl+_: (Unit Separator)}
 caSP=$20;                   {' ': Espace (Space)}
 caDEL=$7F;                  { '': Efface (Delete)}
 caFFh=$FF;                  {Ascii FFh}

 SegmentVid‚o:Word=$B800;
 NombreColonne:Byte=80;
 NombreLigne:Byte=25;

Type
 {Structure de disque dur}
 IntHardDiskRec=Record
  MaxTrack:Word;      { Nombre maximal de cylindres }
  MaxHead:Byte;       { Nombre maximal de tˆtes }
  ReservedA:LongInt;  { R‚serv‚e … des fins inconnu???}
  LenVerSec:Byte;     { Longueur maximal des octets de v‚rifications }
  Flags:Byte;         { Drapeaux de comportements }
  TimeOut:Byte;       { Valeur maximal avant l'envoie d'un d‚passement de temps }
  FormatTimeOut:Byte; { Valeur de d‚passement de temps lors du formatage }
  TestTimeOut:Byte;   { Valeur de d‚passement de temps lors de tests }
  LandingZone:Word;   { Nombre de cylindre de la zone d'att‚rissage }
  Sector:Byte;        { Nombre de secteur par cylindre }
  ReservedB:Byte;     { R‚serv‚e des fins inconnu??? }
 End;

 {Structure de fichier ®.EXE¯}
 HeaderEXE=Record
  Sign:Array[0..1]of Char; { Signature 'MZ' }
  LenN511:Word;            { Longueur Module 512 (Et binaire 511) }
  LenShr9:Word;            { Longueur Diviser 512 (Shift Right 9) }
  NmSeg:Word;              { Nombre de segment … adapter }
  SizeOfHeader:Word;       { Taille de l'entˆte en paragraphe }
  MinParagraph:Word;       { Nombre minimal de paragraphe }
  MaxParagraph:Word;       { Nombre maximal de paragraphe }
  OfsLoadStack:Word;       { Offset de chargement de module dans la pile }
  SizeOfStack:Word;        { Taille de la pile (SP) }
  CheckSum:Word;           { V‚rificateur de l'en-tˆte du fichier ex‚cutable }
  IP:Word;                 { Point d'entr‚e d'instruction }
  OfsLoad:Word;            { Offset de chargement de module dans le code }
  AdrExeTable:Word;        { Adresse de la table de relogement du programme EXE }
  NmOvr:Word;              { Num‚ro de recouvrement (0 pour le programme principal) }
 End;

Proc‚dure AfficheXY(X,Y:Byte;Const ChaŒne:String;Attr:Byte);
Fonction  AltEnfonc‚:Boolean;
Fonction  AltPress:Boolean;Duplication AltEnfonc‚;
Proc‚dure BarEspaceHor(X1,Y,X2,Attr:Byte);
Proc‚dure BarSpcHor(X1,Y,X2,Attr:Byte);Duplication BarEspaceHor;
Proc‚dure ChangeModeVid‚o(Mode:Byte);Registre;
Proc‚dure ClearKeyboard;
Proc‚dure ClrKbd;Duplication ClearKeyboard;
Proc‚dure ClrScr(Attr:Byte);
Fonction  CmosXT:Byte;
Proc‚dure EffacerClavier;Duplication ClearKeyboard;
Proc‚dure EffacerTamponClavier;Duplication ClearKeyboard;
Proc‚dure Fermer(Handle:Byte);Registre;
Proc‚dure MoveText(X1,Y1,X2,Y2,X3,Y3:Byte);
Proc‚dure PutTxtXY(X,Y:Byte;Const Str:String;Attr:Byte);Duplication AfficheXY;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                IMPLMENTATION
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Fonction AltEnfonc‚                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de savoir si la touche ®Alt¯ est enfonc‚ (True) ou
 non (False).
}

Fonction AltEnfonc‚:Boolean;Assembleur;ASM
 MOV AH,02h
 INT 16h
 AND AL,8
 {$IFOPT 1+}
  SHR AL,3
 {$ELSE}
  JZ  @@End
  MOV AL,Vrai
@@End:
 {$ENDIF}
FIN;

Proc‚dure ClearKeyboard;Assembleur;ASM
 {$IFOPT 2+}
  PUSH 0
  POP ES
 {$ELSE}
  XOR AX,AX
  MOV ES,AX
 {$ENDIF}
 CLI
 MOV AX,ES:[0480h]
 MOV DI,041Ah
 STOSW
 STOSW
 STI
FIN;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Fonction CmosXT                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de connaŒtre le modŠle CMOS install‚ sur XT s'il
 y  en  a  effectivement  d'installer.  Les  constantes  utilis‚es  sont
 compatibles avec l'unit‚ ®Systex¯.


 Remarque
 ÍÍÍÍÍÍÍÍ

  ş A la fin  des ann‚es 1990,  cette proc‚dure  n'est plus utilis‚e par
    aucune application car les XT n'existe plus et son succ‚seur AT en a
    toujours un.
}

Fonction CmosXT:Byte;Assembleur;ASM
 MOV DX,2C0h
 IN  AL,DX
 TEST AL,0Fh
 JNZ @TooBad
 MOV DX,2CBh
 IN  AL,DX
 CMP AL,0DEh
 JE  @CmosB
 MOV AL,0DEh
 OUT DX,AL
 IN  AL,DX
 CMP AL,0DEh
 JE  @CmosB
@TooBad:
 XOR AL,AL
 OUT DX,AL
 INC DX
 IN  AL,DX
 DEC DX
 TEST AL,0Fh
 JNZ @TriBad
 MOV AL,0Bh
 OUT DX,AL
 INC DX
 IN  AL,DX
 CMP AL,0DEh
 JE  @CmosC
 MOV AL,0DEh
 OUT DX,AL
 IN  AL,DX
 CMP AL,0DEh
 JE  @CmosC
@TriBad:
 XOR AL,AL
 OUT DX,AL
 MOV AL,80h
 OUT DX,AL
 MOV BL,0Eh
 INC DX
 MOV AL,BL
 OUT DX,AL
 DEC DX
 MOV AL,88h
 OUT DX,AL
 MOV AL,98h
 OUT DX,AL
 MOV AL,88h
 OUT DX,AL
 MOV AL,80h
 OUT DX,AL
 MOV AL,0A0h
 OUT DX,AL
 INC DX
 MOV CX,100h
@LoopA:
 IN  AL,DX
 TEST AL,1
 LOOPZ @LoopA
 JZ  @NoCmos
 MOV CX,100h
@LoopB:
 IN  AL,DX
 TEST AL,1
 LOOPNZ @LoopB
 JZ @CmosA
@NoCmos:
 MOV DX,2C0h
 XOR AL,AL { CtrlNoCmos=0 }
 OUT DX,AL
 XOR DX,DX
 JMP @@EndCmosXT
@CmosA:
 MOV AL,ctrlCmosRTC58321(* RTC-58321, 2C0h-2C1h *)
 JMP @SetCmosXTPort
@CmosB:
 MOV AL,ctrlCmosMM58167a(* MM58167, 2C0h-2DFh *)
 JMP @SetCmosXTPort
@CmosC:
 MOV AL,ctrlCmosMM58167b(* MM58167, 2C0h-2C7h *)
@SetCmosXTPort:
 MOV DX,2C0h
@@EndCmosXT:
FIN;

{ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ}
{                           Contr“le de l'affichage                        }
{ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure AfficheXY                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure affiche un message … l'‚cran de texte aux coordonn‚es
 texte (X,Y) avec l'attribut ®Attr¯.
}

Proc‚dure AfficheXY(X,Y:Byte;Const ChaŒne:String;Attr:Byte);Assembler;ASM
 PUSH DS
  MOVZX BX,Y
  MOV AL,NombreColonne
  MUL BL
  XCHG DI,AX
  MOV BL,X
  ADD DI,BX
  SHL DI,1
  MOV ES,SegmentVid‚o
  LDS SI,ChaŒne
  MOVZX CX,DS:[SI]
  JCXZ @2
  INC SI
  MOV AH,Attr
@1:
  LODSB
  STOSW
  LOOP @1
@2:
 POP DS
FIN;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure BarEspaceHor                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'afficher une barre texte entre les coordonn‚es
 texte sp‚cifi‚e avec une couleur texte sp‚cifier.
}

Proc‚dure BarEspaceHor(X1,Y,X2,Attr:Byte);Assembleur;ASM
 MOVZX BX,Y
 MOV AL,NombreColonne
 MUL BL
 XCHG DI,AX
 MOV BL,X1
 ADD DI,BX
 SHL DI,1
 MOV ES,SegmentVid‚o
 MOVZX CX,X2
 SUB CL,X1
 INC CL
 MOV AH,Attr
 MOV AL,32
 CLD
 REP STOSW
FIN;

Proc‚dure ChangeModeVid‚o(Mode:Byte);Registre;Assembleur;ASM
 MOVZX AX,Mode
 INT 10h
FIN;

Proc‚dure ClrScr(Attr:Byte);Assembleur;ASM
 CLD
 MOV ES,SegmentVid‚o
 XOR DI,DI
 MOVZX BX,NombreLigne
 SHL BX,1
 MOV AL,NombreColonne
 MUL BL
 XCHG CX,AX
 MOV AH,Attr
 MOV AL,32
 {$IFOPT 3+}
  PUSH AX
  PUSH AX
  POP EAX
  SHR CX,1
  REP STOSD
  ADC CX,CX
 {$ENDIF}
 REP STOSW
FIN;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Fonction MoveText                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure copie le contenu d'un rectangle vers un autre rectangle.
 (X1,Y1) repr‚sente  la coordonn‚e  du coin sup‚rieur gauche  du rectangle
 contenant le texte  … copier.  (X2,Y2)  rep‚sente la  coordonn‚e  du coin
 inf‚rieur  droit  de  ce  mˆme  rectangle.  (X3,Y3)  repr‚sente  le  coin
 sup‚rieur gauche du rectangle destin‚ … recevoir le texte.
}

Proc‚dure MoveText(X1,Y1,X2,Y2,X3,Y3:Byte);Var L:Word;D‚but
 ASM
  PUSH DS
   MOVZX AX,X2
   SUB AL,X1
   INC AX
   MOV L,AX
   CLD
   MOV ES,SegmentVid‚o
   MOV AL,Y1
   CMP Y3,AL
   JB @@Inc
   MOV DL,Y2
   SUB DL,AL
   INC DL
@@Loop:
   DEC DL
   MOV AL,Y1
   ADD AL,DL
   MUL NombreColonne
   MOVZX BX,X1
   ADD AX,BX
   SHL AX,1
   MOV SI,AX
   MOV AL,Y3
   ADD AL,DL
   MUL NombreColonne
   MOVZX BX,X3
   ADD AX,BX
   SHL AX,1
   MOV DI,AX
   MOV CX,L
   MOV DS,ES
   {$IFOPT 3+}
    SHR CX,1
    REP MOVSD
    ADC CX,CX
   {$ENDIF}
   REP MOVSW
   OR  DL,DL
   JNE @@Loop
   JMP @@End
@@Inc:
   MOV DH,Y2
   SUB DH,AL
   INC DH
   MOV DL,0
@@LoopInc:
   MOV AL,Y1
   ADD AL,DL
   MUL NombreColonne
   MOVZX BX,X1
   ADD AX,BX
   SHL AX,1
   MOV SI,AX
   MOV AL,Y3
   ADD AL,DL
   MUL NombreColonne
   MOVZX BX,X3
   ADD AX,BX
   SHL AX,1
   MOV DI,AX
   MOV CX,L
   MOV DS,ES
   REP MOVSW
   INC DL
   CMP DL,DH
   JNE @@LoopInc
@@End:
  POP DS
 END;
End;

{ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ}
{                           Gestion des fichiers                           }
{ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                             Proc‚dure Fermer                            Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure ferme un fichier de type Handle ouvert pr‚c‚demment par le
 systŠme d'exploitation compatible au DOS.
}

Proc‚dure Fermer(Handle:Byte);Registre;Assembleur;ASM
 MOVZX BX,Handle
 MOV AX,03E00h
 INT 021h
FIN;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
FIN.