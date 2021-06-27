{⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ∑
 ≥      Malte Genesis/Module crÇateur de dÇmarreur      ∫
 ≥ Edition Isabel (partie Top Secräte)/III-Version 1.16 ∫
 ≥                        1995/09/26                    ∫
 ≥                                                      ∫
 ≥  Tous droits rÇservÇ par les Chevaliers de Malte (C) ∫
 ‘ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕº}

{ Ce programme sert Ö crÇer le dÇmarreur externe (StartUp)
  inclus dans la bibliothäque "STARTUP.RLL".

  Cette bibliothäque est top secräte donc le langage l'est
  parfois aussi...!!!! }

{$IFDEF VER70}{$Q-}{$ENDIF}{$A-,B-,E+,F+,G-,I-,N+,O-,P-,R-,S-,T-,V-,X+}

Uses Dostex,Systex,pritex;

{$DEFINE StartUp}

Const

  { Entàte RLL }
 HeaderRLL:String='StartUp/Real.Link.Library=2/Isabel.Psychotic '+
		  'Tous droits rÇservÇs par les Chevaliers de Malte (C).'+
		  'Fuck you DLL and MZ format!';

  { RÇfÇrence d'index de la resource "STARTUP.*" }
 suStartUpIsabel=$00;    {>StartUpIsabel(Var Jump:Jumper;Var StartUp:StartUpRec) }
 suStartUpEconomic=$01;
 suStartUpGolden=$02;
 suStartUpGame=$03;
 suStartUpNetwork=$04;
 suStartUpWindows=$05;
 suStartUpOpt1=$06;
 suStartUpOpt2=$07;
 suStartUpOpt3=$08;
 suStartUpOpt4=$09;
 suStartUpOpt5=$0A;
 suStartUpOpt6=$0B;
 suStartUpOpt7=$0C;
 suStartUpOpt8=$0D;
 suStartUpOpt9=$0E;
 suStartUpOpt10=$0F;
 suSetupMod=$10;         {>SetupMod ... }
 suSetupPassword=$11;
 suUnSetupPassword=$12;
 suSetupOpt1=$13;
 suSetupOpt2=$14;
 suSetupOpt3=$15;
 suSetupOpt4=$16;
 suSetupOpt5=$17;
 suSetupOpt6=$18;
 suSetupOpt7=$19;
 suSetupOpt8=$1A;
 suSetupOpt9=$1B;
 suSetupOpt10=$1C;
 suSetupOpt11=$1D;
 suSetupOpt12=$1E;
 suSetupOpt13=$1F;
  (* Technique pour le AltPressed: Nombre 6, option 3. *)
 suAltPress4Mem=$20;     {>AltPressedPerMemory:Boolean  pour indiquer que la<}
			 { lecture  de l'Çtat  de la touche Alt  se fait par<}
			 { un mÇthode d'accäs directe en mÇmoire. }
 suAltPress4Memi286=$21; {>GetAltPressedPerMemoryIntel80286:  Boolean   pour<}
			 { indiquer  que la lecture  de l'Çtat  de la touche<}
			 { Alt se fait  par un mÇthode  d'accäs  directe  en<}
			 { mÇmoire avec des instruction pour les CPU 80286. }
 suAltPress4MemNoCLI=$22;{>AltPressedPerMemoryNoCLI:Boolean   pour  indiquer<}
			 { que la lecture de l'Çtat de la touche Alt se fait<}
			 { par un mÇthode  d'accäs  directe en mÇmoire  sans<}
			 { tenir compte  des  interruptions  d'arriäre  plan<}
			 { (IRQ). }
 suAltPress4MemNoCLIi286=$23;{>AltPressedPerMemoryNoCLIi80286:Boolean   pour<}
			 { indiquer  que la lecture  de l'Çtat  de la touche<}
			 { Alt se fait  par un mÇthode  d'accäs  directe  en<}
			 { mÇmoire avec  des instruction  pour les CPU 80286<}
			 { sans  tenir  compte  des interruptions  d'arriäre<}
			 { plan (IRQ). }
 suAltPress4Bios=$24;    {>AltPressedPerBios:Boolean  pour  indiquer  que la<}
			 { lecture  de l'Çtat  de la touche Alt  se fait par<}
			 { l'intremise du Bios:  Interruption 16h,  Fonction<}
			 { 01h. }
 suAltPressOpt1=$25;     {>(Option1)  Cette entrÇe est bidon pour le moment,<}
			 { mais dans les futurs versions du StartUp, il sera<}
			 { utilisÇ  fort  probablement  pour  une   nouvelle<}
			 { mÇthode de manipulation du clavier. }
 suAltPressOpt2=$26;     {>(Option2) Màme objectif que le suAltPressOpt1. }
 suAltPressOpt3=$27;     {>(Option3) Màme objectif que le suAltPressOpt1. }
 suAltPressRet=$28;      {>AltPressedReturn:Boolean  n'est  en  faite  qu'un<}
			 { simple  retour  de  fonction  pour  Çviter  qu'un<}
			 { appel  accidentel est lieu  lorsqu'aucun  clavier<}
			 { n'existe. }
  (* Technique pour le AltPressed: Nombre 6, option 3. *)
 suCtrlPress4Mem=$29;    {>CtrlPressedPerMemory:Boolean pour indiquer que la<}
			 { lecture de l'Çtat  de la touche  Ctrl se fait par<}
			 { un mÇthode d'accäs directe en mÇmoire. }
 suCtrlPress4Memi286=$2A;{>GetCtrlPressedPerMemoryIntel286:  Boolean    pour<}
			 { indiquer  que la lecture  de l'Çtat  de la touche<}
			 { Ctrl  se fait  par un mÇthode  d'accäs directe en<}
			 { mÇmoire avec des instructions pour le CPU 80286. }
 suCtrlPress4MemNoCLI=$2B;{>CtrlPressedPerMemoryNoCLI:Boolean  pour indiquer<}
			 { que la lecture  de l'Çtat  de la touche  Ctrl  se<}
			 { fait  par un mÇthode  d'accäs  directe en mÇmoire<}
			 { sans  tenir  compte  des interruptions  d'arriäre<}
			 { plan (IRQ). }
 suCtrlPress4MemNoCLIi286=$2C;{>CtrlPressedPerMemoryNoCLIi80286:Boolean pour<}
			 { indiquer  que la lecture  de l'Çtat  de la touche<}
			 { Ctrl se fait par un mÇthode  d'accäs  directe  en<}
			 { mÇmoire avec  des instruction  pour les CPU 80286<}
			 { sans  tenir  compte  des interruptions  d'arriäre<}
			 { plan (IRQ). }
 suCtrlPress4Bios=$2D;   {>CtrlPressedPerBios:Boolean pour  indiquer  que la<}
			 { lecture  de l'Çtat de la touche Ctrl  se fait par<}
			 { l'intremise du Bios:  Interruption 16h,  Fonction<}
			 { 01h. }
 suCtrlPressOpt1=$2E;    {>(Option1)  Cette entrÇe est bidon pour le moment,<}
			 { mais dans les futurs versions du StartUp, il sera<}
			 { utilisÇ  fort  probablement   pour  une  nouvelle<}
			 { mÇthode de manipulation du clavier. }
 suCtrlPressOpt2=$2F;    {>(Option2) Màme objectif que le suCtrlPressOpt1. }
 suCtrlPressOpt3=$30;    {>(Option3) Màme objectif que le suCtrlPressOpt1. }
 suCtrlPressRet=$31;     {>CtrlPressedReturn:Boolean  n'est  en faite  qu'un<}
			 { simple  retour  de  fonction  pour  Çviter  qu'un<}
			 { appelle accidentel est lieu  lorsqu'aucun clavier<}
			 { n'existe. }
  (* Technique pour FillCharacter: Nombre 4, option 2. *)
 suFillChr4Def=$32;      {>FillCharPerDefault(Var Buffer;Length:Word; Value:<}
			 { Byte) pour les CPU 8088, 80188 et NEC V20. }
 suFillChrPer86=$33;     {>FillCharPer86(Var  Buffer;Length:Word;Value:Byte)<}
			 { pour les CPU 8086, 80186, 80286 et NEC V30. }
 suFillChrPer32Bits=$34; {>FillCharPer32Bits(Var Buffer; Length:Word; Value:<}
			 { Byte) pour les CPU 80386, 80486 ou postÇrieur. }
 suFillChrOpt1=$35;      {>(Option1)  Cette entrÇe est bidon pour le moment,<}
			 { mais dans les futurs versions du StartUp, il sera<}
			 { utilisÇ  fort  probablement   pour  une  nouvelle<}
			 { mÇthode de FillCharacter. }
 suFillChrOpt2=$36;      {>(Option2) Màme objectif que le suFillChrOpt1. }
 suFillChrOpt3=$37;      {>(Option3) Màme objectif que le suFillChrOpt1. }
  (* Technique pour GetInterruptVector: Nombre 4, option 2. *)
 suGetIntVec4Mem=$38;    {>GetIntVecPerMemoryAccess(InterruptNumber:Byte;Var<}
			 { Vector:Pointer)  pour  les  mÇthodes  directe  en<}
			 { accäs mÇmoire extràmant rapide! }
 suGetIntVec4Mem286=$39; {>GetIntVecPerMemoryAccess(InterruptNumber:Byte;Var<}
			 { Vector:Pointer)  pour  les  mÇthodes  directe  en<}
			 { accäs mÇmoire extràmant rapide! MÇthode utilisant<}
			 { des instructions pour CPU 80286. }
 suGetIntVec4Mem386=$3A; {>GetIntVecPerMemoryAccess(InterruptNumber:Byte;Var<}
			 { Vector:Pointer)  pour  les  mÇthodes  directe  en<}
			 { accäs mÇmoire extràmant rapide! MÇthode utilisant<}
			 { des instructions pour CPU 80386. }
 suGetIntVec4Dos=$3B;    {>GetIntVecPerDos(InterruptNumber:Byte;Var  Vector:<}
			 { Pointer)  pour les mÇthodes  compatible  en  Mode<}
			 { ProtÇgÇ et Windows. }
 suGetIntVecOpt1=$3C;    {>(Option1)  Cette entrÇe est bidon pour le moment,<}
			 { mais dans les futurs version du StartUp,  il sera<}
			 { sans doute utilisÇ  pour une nouvelle mÇthode  de<}
			 { modification de vecteur d'interruption. }
 suGetIntVecOpt2=$3D;    {>(Option2) Màme objectif que le suGetIntVecOpt2. }
  (* Technique de GetRawTimer: Nombre 4, option 0 *)
 suGetRawTimer4Mem=$3E;  {>GetRawTimerPerMemory:Long cette fonction retourne<}
			 { l'horloge brute incrÇmentÇ Ö tous les  18,2  fois<}
			 { par  seconde  en  utilisant  la  cellule  mÇmoire<}
			 { affectÇ par l'IRQ0 (La meilleur mÇthode). }
 suGetRawTimer4Memi286=$3F;{>GetRawTimerPerM286:Long cette fonction retourne<}
			 { l'horloge brute incrÇmentÇ Ö tous les  18,2  fois<}
			 { par  seconde  en  utilisant  la  cellule  mÇmoire<}
			 { affectÇ par l'IRQ0 et des instructions CPU 80286.}
 suGetRawTimer4Int1Ah=$40;{>GetRawTimerPerInt1A:Long cette fonction retourne<}
			 { l'horloge brute incrÇmentÇ Ö tous les  18,2  fois<}
			 { par seconde en utilisant l'interruption 1Ah}
 suGetRawTimer4Cmos=$41; {>GetRawTimerPerCmos:Long cette  fonction  retourne<}
			 { l'horloge brute incrÇmentÇ Ö tous les  18,2  fois<}
			 { par seconde en utilisant le RTC du CMOS.}
 suGetRawTimerOpt1=$42;
 suGetRawTimerOpt2=$43;
  (* Technique de GetRawTimerByte: Nombre x, option 3 *)
 suGetRawTimerB4Mem=$44; {>GetRawTimerBytePerDefault:Byte   cette   fonction<}
			 { retourne le 1iäre octet  de l'horloge  incrÇmentÇ<}
			 { Ö tous les 18,2 fois  par  seconde  en  utilisant<}
			 { l'adressage mÇmoire directe 0040h:006Ch. }
 suGetRawTimerB4Memi286=$45;{>GetRawTimerBytePerDefault:Byte   cette   fonction<}
			 { retourne le 1iäre octet  de l'horloge  incrÇmentÇ<}
			 { Ö tous les 18,2 fois  par  seconde  en  utilisant<}
			 { l'adressage mÇmoire directe 0040h:006Ch. Avec des<}
			 { instruction   de   CPU   80286  contrairement  au<}
			 { prÇcÇdent. }
 suGetRawTimerB4Int1Ah=$46;{GetRawTimerBytePerInter1Ah:Byte  cette  fonction<}
			 { retourne le 1iäre octet  de  l'horloge incrÇmentÇ<}
			 { Ö tous les 18,2 fois  par  seconde  en  utilisant<}
			 { l'interruption 1Ah. }
 suGetRawTimerB4Dos=$47; {>GetRawTimerBytePerDos:Byte     cette     fonction<}
			 { retourne le 1iäre octet  de  l'horloge incrÇmentÇ<}
			 { Ö tous les 18,2 fois  par  seconde  en  utilisant<}
			 { l'interruption 21h  (Dos).  A moins  que  le  CPU<}
			 { tourne dans les 100 Mhz,  Çviter d'utiliser cette<}
			 { technique parcequ'un 33 en arrache alors imaginez<}
			 { un XT...69...(Fantasme)...69...tu marches dans le<}
			 { mauvais sense Çpais!  Äa ne  se fait pas  avec un<}
			 { Ordi.}
 suGetRawTimerBOpt1=$48; {>(Option1)  Cette entrÇe est bidon pour le moment,<}
			 { mais dans les futurs version du StartUp,  il sera<}
			 { Ö toute  fin pratique employÇ  pour  une  mÇthode<}
			 { plus adapter au nouveau modäle d'ordinateur. }
 suGetRawTimerBOpt2=$49; {>(Option2) Màme objectif que le suGetRawTimerBOpt1.}
 suGetRawTimerBOpt3=$4A; {>(Option3) Màme objectif que le suGetRawTimerBOpt1.}
  { JoystickPosition }
 suJoyPos4IO=$4B;        {>JoystickPositionPerInputOuput(Axe:Byte):Word pour<}
			 { la mÇthode utilisant  les  ports  d'entrÇe/sortie<}
			 { 201h du contrìleur supportÇ par  tous les anciens<}
			 { modäle de PC.  Mais  y  eu un mÇchant scrach avec<}
			 { l'arrivÇe de Windows... }
 suJoyPos4Bios=$4C;      {>JoystickPositionPerBios(Axe:Byte):Word   pour  la<}
			 { mÇthode   de     compatibilitÇ    du   dÇsespoir:<}
			 { Interruption 15h, Fonction 84h. }
 suJoyPosOpt1=$4D;       {>(Option1)  Cette entrÇe est bidon pour le moment,<}
			 { mais dans les futurs version du StartUp,  il sera<}
			 { Ö toute  fin pratique employÇ  pour  une  mÇthode<}
			 { plus adapter au nouveau modäle de manette de jeu. }
 suJoyPosOpt2=$4E;       {>(Option2) Màme objectif que le suJoyPosOpt1. }
 suJoyPosOpt3=$4F;       {>(Option3) Màme objectif que le suJoyPosOpt1. }
 suJoyPosOpt4=$50;       {>(Option4) Màme objectif que le suJoyPosOpt1. }
 suJoyPosRet=$51;        { JoystickPositionReturn(Axe:Byte):Word   n'est  en<}
			 { faite qu'un simple retour de fonction pour Çviter<}
			 { qu'un  appel  accidentel est  lieu  lorsqu'aucune<}
			 { manette de jeu n'existe. }
  { KeyPressed }
 suKeyPress4IO=$52;      {>KeypressedPerInputOutput:Boolean  pour la mÇthode<}
			 { directe d'utilisation par le contrìleur d'entrÇe/<}
			 { sortie au port 0060h. }
 suKeyPress4Mem=$53;     {>KeypressedPerMemory:Boolean  pour la mÇthode  par<}
			 { dÇfaut utilisant les accäs  au tampon mÇmoire  en<}
			 { adresse 0040h:x. }
 suKeyPress4MemNoCLI=$54;{>KeypressedPerMemoryButNoClearedInterrupt: Boolean<}
			 { pour  la  mÇthode  utilisant  l'accäs  au  tampon<}
			 { mÇmoire en adresse 0040h:x sans protection contre<}
			 { les interruptions d'arriäre plan,  idÇal pour les<}
			 { "playeur" de ".MOD". }
 suKeyPress4Bios=$55;    {>KeypressedPerBios:Boolean   pour    la    mÇthode<}
			 { utilisant le Bios: Interruption 16h, Fonction 01h.}
 suKeyPress4Dos=$56;     {>KeypressedPerDos:Boolean     pour   la    mÇthode<}
			 { utilisant le Dos: Interruption 21h, Fonction ??h. }
 suKeyPressOpt1=$57;     {>(Option1)  Cette entrÇe est bidon pour le moment,<}
			 { mais dans les futurs versions du StartUp, il sera<}
			 { utilisÇ  fort  probablement   pour  une  nouvelle<}
			 { mÇthode de manipulation du clavier. }
 suKeyPressOpt2=$58;     {>(Option2) Màme objectif que le suKeyPressOpt1. }
 suKeyPressOpt3=$59;     {>(Option3) Màme objectif que le suKeyPressOpt1. }
 suKeyPressRet=$5A;      {>KeyPressedReturn:Boolean  n'est  en  faite  qu'un<}
			 { simple  retour  de  fonction  pour  Çviter  qu'un<}
			 { appel  accidentel est lieu  lorsqu'aucun  clavier<}
			 { n'existe. }
  (* LeftShiftPressd *)
 suLShiftPress4Mem=$5B;  {>LShiftPressedPerMemory:Boolean  pour indiquer que la<}
			 { lecture  de l'Çtat  de la touche Alt  se fait par<}
			 { un mÇthode d'accäs directe en mÇmoire. }
 suLShiftPress4Memi286=$5C; {>GetLShiftPressedPerMemoryIntel80286:  Boolean   pour<}
			 { indiquer  que la lecture  de l'Çtat  de la touche<}
			 { Alt se fait  par un mÇthode  d'accäs  directe  en<}
			 { mÇmoire avec des instruction pour les CPU 80286. }
 suLShiftPress4MemNoCLI=$5D;{>LShiftPressedPerMemoryNoCLI:Boolean pour indiquer<}
			 { que la lecture de l'Çtat de la touche Alt se fait<}
			 { par un mÇthode  d'accäs  directe en mÇmoire  sans<}
			 { tenir compte  des  interruptions  d'arriäre  plan<}
			 { (IRQ). }
 suLShiftPress4MemNoCLIi286=$5E;{>LShiftPressedPerMemoryNoCLIi80286:Boolean   pour<}
			 { indiquer  que la lecture  de l'Çtat  de la touche<}
			 { Alt se fait  par un mÇthode  d'accäs  directe  en<}
			 { mÇmoire avec  des instruction  pour les CPU 80286<}
			 { sans  tenir  compte  des interruptions  d'arriäre<}
			 { plan (IRQ). }
 suLShiftPress4Bios=$5F; {>GetLeftShiftPressedPerBios:Boolean     pour    la<}
			 { mÇthode utilisant  l'interruption  16h,  fonction<}
			 { 01h. }
 suLShiftPressOpt1=$60;  {>(Option1)  Cette entrÇe est bidon pour le moment,<}
			 { mais dans les futurs versions du StartUp, il sera<}
			 { utilisÇ  fort  probablement   pour  une  nouvelle<}
			 { mÇthode de manipulation du clavier. }
 suLShiftPressOpt2=$61;  {>(Option2) Màme objectif que le suLShiftPressOpt1. }
 suLShiftPressOpt3=$62;  {>(Option3) Màme objectif que le suLShiftPressOpt1. }
 suLShiftPressRet=$63;   {>GetLeftShiftPressedReturn:Boolean  n'est en faite<}
			 { qu'un simple retour de fonction pour Çviter qu'un<}
			 { appelle accidentel est lieu lorsqu'aucun  clavier<}
			 { n'existe. }
  (* MoveLeft *)
 suMove4Def=$64;         {>MoveLeftPerDefault(Var  Source, Dest; Count:Word)<}
			 { pour les 8088, 80188 et NEC V20. }
 suMovePer86=$65;        {>MoveLeftPer86(Var  Source, Dest;Count:Word)  pour<}
			 { les 8086, 80186, 80286 et NEC V30. }
 suMovePer32Bits=$66;    {>MoveLeftPer32Bits(Var  Source, Dest;  Count:Word)<}
			 { pour les 80386, 80486,... }
 suMoveOpt1=$67;         {>(Option1)  Cette entrÇe est bidon pour le moment,<}
			 { mais dans les futurs versions du StartUp, il sera<}
			 { utilisÇ  fort  probablement   pour  une  nouvelle<}
			 { mÇthode de MoveLeft. }
 suMoveOpt2=$68;         {>(Option2) Màme objectif que le suMoveOpt1. }
 suMoveOpt3=$69;         {>(Option3) Màme objectif que le suMoveOpt1. }
  { PushKey }
 suPushKey4Mem=$6A;      {>PushKeyPerMemory(Key:Word)   pour   insÇrer   une<}
			 { touche  de  clavier directe  dans la  mÇmoire  du<}
			 { tampon.  A utiliser  par  dÇfaut.  Sur  tout  les<}
			 { anciens  modäles  d'ordinateur   100%  compatible<}
			 { c'est la seule faáon d'insÇrer  des  touches  car<}
			 { l'Interruption 15h, Fonction 4Fh. }
 suPushKey4Bios15h=$6B;  {>PushKeyPerBios15h(Key:Word)   pour  insÇrer   une<}
			 { touche de clavier  dans le tampon en passant  par<}
			 { le Bios: Interruption 15h, Fonction 4Fh. }
 suPushKey4Bios16h=$6C;  {>PushKeyPerBios16h(Key:Word)   pour  insÇrer   une<}
			 { touche de clavier  dans le tampon en passant  par<}
			 { le Bios: Interruption 16h, Fonction 05h. }
 suPushKeyOpt1=$6D;      {>(Option1)  Cette entrÇe est bidon pour le moment,<}
			 { mais dans les futurs versions du StartUp, il sera<}
			 { utilisÇ  fort  probablement   pour  une  nouvelle<}
			 { mÇthode de manipulation du clavier. }
 suPushKeyOpt2=$6E;      {>(Option2) Màme objectif que le suPushKeyOpt1. }
 suPushKeyOpt3=$6F;      {>(Option3) Màme objectif que le suPushKeyOpt1. }
 suPushKeyRet=$70;       {>LeftShiftPressedReturn:Boolean   n'est  en  faite<}
			 { qu'un simple retour de fonction pour Çviter qu'un<}
			 { appelle  accidentel est lieu lorsqu'aucun clavier<}
			 { n'existe. }
  { ReadKey }
 suReadKey4IO=$71;       {>ReadKeyPerInputOutput:Word  pour extraire un code<}
			 { clavier  du  tampon clavier  en  passant  par  le<}
			 { contrìleur d'entrÇe/sortie Ö l'adresse 0060h. }
 suReadKey4Mem=$72;      {>ReadKeyPerMemory:Word   pour   extraire  un  code<}
			 { clavier du tampon clavier en passant  directement<}
			 { par le tampon mÇmoire 0040h:x. }
 suReadKey4Bios00h=$73;  {>ReadKeyPerBiosFunction00h:Word  pour extraire  un<}
			 { code  clavier   du  tampon  clavier   en  passant<}
			 { par  la  fonction   00h  de  l'interruption  16h.<}
			 { CompatibilitÇ pour les anciens träs vieux modäle. }
 suReadKey4Bios10h=$74;  {>ReadKeyPerBiosFunction10h:Word  pour  extraire un<}
			 { code  clavier  du  tampon  clavier   en   passant<}
			 { par  la  fonction  10h   de  l'interruption  16h.<}
			 { Technique disponible  que  sur les  Bios  clavier<}
			 { Çtendu.  Contrairement Ö la fonction  00h,  cette<}
			 { fonction lit Çgalement les F11, F12,... }
 suReadKey4Dos=$75;      {>ReadKeyPerDos:Word  pour extraire un code clavier<}
			 { du  tampon  clavier   en  passant   par  le  Dos.<}
			 { Technique  critique  consernant la compatibilitÇ.<}
			 { Ne doit àtre utilisÇ que dans les cas poussant au<}
			 { suicide ou Ö une alternative de celle-ci...! }
 suReadKeyOpt1=$76;      {>(Option1)  Cette entrÇe est bidon pour le moment,<}
			 { mais dans les futurs versions du StartUp, il sera<}
			 { utilisÇ  fort  probablement   pour  une  nouvelle<}
			 { mÇthode de manipulation du clavier. }
 suReadKeyOpt2=$77;      {>(Option2) Màme objectif que le suReadKeyOpt1. }
 suReadKeyProtect=$78;   {>(Option3) Version directe protÇger. }
 suReadKeyRet=$79;       {>ReadKeyReturn:Word  n'est  en faite  qu'un simple<}
			 { retour  de  fonction   pour  Çviter  qu'un  appel<}
			 { accidentel est lieu lorsqu'aucun clavier n'existe.}
  { RightShiftPress }
 suRShiftPress4Mem=$7A;  {>GetRightShiftPressedPerMemory:   Boolean     pour<}
			 { indiquer que la lecture  de l'Çtat  de la  touche<}
			 { Shift  de droite se fait  par un mÇthode  d'accäs<}
			 { directe en mÇmoire. }
 suRShiftPress4Memi286=$7B;
 suRShiftPress4MemNoCLI=$7C;
 suRShiftPress4MemNoCLIi286=$7D;
 suRShiftPress4Bios=$7E; {>GetRightShiftPressedPerBios:Boolean pour indiquer<}
			 { que la lecture de l'Çtat  de la touche  Shift  de<}
			 { droite   se  fait  par   l'intremise   du   Bios:<}
			 { Interruption 16h, Fonction 01h. }
 suRShiftPressOpt1=$7F;  {>(Option1)  Cette entrÇe est bidon pour le moment,<}
			 { mais dans les futurs versions du StartUp, il sera<}
			 { utilisÇ  fort  probablement   pour  une  nouvelle<}
			 { mÇthode de manipulation du clavier. }
 suRShiftPressOpt2=$80;  {>(Option2) Màme objectif que le suRShiftPressOpt1. }
 suRShiftPressOpt3=$81;  {>(Option3) Màme objectif que le suRShiftPressOpt1. }
 suRShiftPressRet=$82;   {>RShiftPressReturn:Boolean n'est  en  faite  qu'un<}
			 { simple retour de fonction pour Çviter qu'un appel<}
			 { accidentel est lieu lorsqu'aucun clavier n'existe.}
  { SetIntVec }
 suSetIntVec4Mem=$83;    {>SetInterruptVectorPerMemory(InterruptNumber:Byte; }
			 { Vector:Pointer) }
 suSetIntVec4Memi286=$84;
 suSetIntVec4Memi386=$85;
 suSetIntVec4Dos=$86;    {>SetInterruptVectorPerDos(InterruptNumber:Byte; }
			 { Vector:Pointer) }
 suSetIntVecOpt1=$87;    {>(Option1)  Cette entrÇe est bidon pour le moment,<}
			 { mais dans les futurs version du StartUp,  il sera<}
			 { sans doute utilisÇ  pour une nouvelle mÇthode  de<}
			 { modification de vecteur d'interruption. }
 suSetIntVecOpt2=$88;    {>(Option2) Màme objectif que le suSetIntVecOpt1. }
  { ShiftPressed }
 suShiftPress4Mem=$89;   {>GetShiftPressedPerMemory:Boolean   pour  indiquer<}
			 { que la lecture de l'Çtat  de l'une/les  touche(s)<}
			 { Shift se fait/font par un mÇthode d'accäs directe<}
			 { en mÇmoire. }
 suShiftPress4Memi286=$8A;
 suShiftPress4MemNoCLI=$8B;
 suShiftPress4MemNoCLIi286=$8C;
 suShiftPress4Bios=$8D;  {>GetShiftPressedPerBios:Boolean  pour indiquer que<}
			 { la lecture de l'Çtat de la touche Shift  se  fait<}
			 { par  l'intremise  du  Bios:   Interruption   16h,<}
			 { Fonction 01h. }
 suShiftPressOpt1=$8E;   {>(Option1)  Cette entrÇe est bidon pour le moment,<}
			 { mais dans les futurs version du StartUp,  il sera<}
			 { sans doute utilisÇ  pour une nouvelle mÇthode  de<}
			 { de dÇtection de l'enfoncement de la touche Shift. }
 suShiftPressOpt2=$8F;   {>(Option2) Màme objectif que le suShiftPressOpt1. }
 suShiftPressOpt3=$90;   {>(Option3) Màme objectif que le suShiftPressOpt1. }
 suShiftPressRet=$91;    {>ShiftPressReturn:Boolean  n'est  en  faite  qu'un<}
			 { simple retour de fonction pour Çviter qu'un appel<}
			 { appel  accidentel  est lieu  lorsqu'aucun clavier<}
			 { n'existe. }

 NumIndex=$91+1;

Function HexWord2Str(X:Word):String; Forward;

Procedure StartUpIsabel(Var Jump:Jumper;Var StartUp:StartUpRec); Forward;
Procedure EndStartUpIsabel; Forward;

Procedure StartUpIsabel;
Assembler;
Var OldByte:Byte;
ASM
  { GetCPU }
 PUSHF;
 XOR AX,AX;
 PUSH AX;
  POPF;
  PUSHF;
  POP AX;
  AND AX,$F000;
  CMP AX,$F000;
  JE  @@inferieur286;
  MOV  DL,cpu80286;
  MOV  AX,$7000;
  PUSH AX;
  POPF;
  PUSHF;
  POP AX;
  AND AX,$7000;
  JE  @@pfin
  INC DL;
  CLI;
  DB $66,$8B,0DCh         { MOV    EBX,ESP;     }
  DB $66,$83,0E4h,0FCh    { AND    ESP,$FFFC;   }
  DB $66,$9C              { PUSHFD;             }
  DB $66,$58              { POP    EAX;         }
  DB $66,$8B,0C8h         { MOV    ECX,EAX;     }
  DB $66,$35,000h,0h,4h,0h{ XOR    EAX,1 shl 18 }
  DB $66,$50              { PUSH   EAX;         }
  DB $66,$9D              { POPFD;              }
  DB $66,$9C              { PUSHFD;             }
  DB $66,$58              { POP    EAX;         }
  DB $66,$51              { PUSH   ECX;         }
  DB $66,$9D              { POPFD;              }
  DB $66,$33,0C1h         { XOR    EAX,ECX;     }
  DB $66,$C1,0E8h,012h    { SHR    EAX,18;      }
  DB $66,$83,0E0h,001h    { AND    EAX,1h       }
  DB $66,$8B,0E3h         { MOV    ESP,EBX      }
  STI;
  ADD DL,AL;
  JMP @@pfin;
@@inferieur286:
  MOV DL,cpu80188;
  MOV AL,$FF;
  MOV CL,$21;
  SHR AL,CL;
  JNE @@t88_86;
  MOV DL,cpuV20;
  STI;
  MOV SI,0;
  MOV CX,$FFFF;
  DB  $F3,$26,$AC;
  OR  CX,CX;
  JE  @@t88_86;
  MOV DL,cpu8088;
@@t88_86:
  PUSH CX;
  POP  ES;
  STD;
  MOV DI,Offset @@q2_end;
  MOV AL,$FB;
  MOV CX,3;
  CLI;
  REP STOSB;
  CLD;
  NOP;
  NOP;
  NOP;
  INC DX;
  NOP;
@@q2_end:
  STI;
@@pfin:
 POPF;
 XOR DH,DH;
 MOV AX,DX;
{@@End:}
 LES DI,StartUp;
 MOV StartUpRec(ES:[DI]).CPU,AL; { Fixe le CPU }
 CMP AL,cpu80286;
 JA  @@32Bits;
 MOV AL,No;
 JMP @@End32Bits;
@@32Bits:
 MOV AL,Ya;
@@End32Bits:
 MOV StartUpRec(ES:[DI]).Up32Bits,AL; { PrÇcise si le 32-bit est supportÇ }
  { Teste les interruptions existante... }
 PUSH DS;
  LDS SI,Jump;
  MOV StartUpRec(ES:[DI]).IntExistFlags,0;{ Fixe  Ö   0   le   drapeau   des }
					  { interruptions pour pouvoir faire }
					  { un OR plus tard...}
   { Int 10h }
  TEST Jumper(DS:[SI]).FlgMethod,flgProtectedMode;
  JZ  @@DirectInt10h;
  MOV AX,$3510;
  INT $21;
  JMP @@TestInt10h;
@@DirectInt10h:
  XOR AX,AX;
  MOV ES,AX;
  LES BX,ES:[$40];
@@TestInt10h:
  MOV AX,ES;
  OR  AX,BX;
  JZ  @@NoInt10h;
  CMP ES:[BX].Byte,$CF; { Pour les hypocrites d'interruption miroir, quand }
  JE  @@NoInt10h;       { elles sont bidon, elles pointent sur un IRET! }
  LES DI,StartUp;
  OR  StartUpRec(ES:[DI]).IntExistFlags,flgInt10h;
@@NoInt10h:
   { Int 11h }
  TEST Jumper(DS:[SI]).FlgMethod,flgProtectedMode;
  JZ  @@DirectInt11h;
  MOV AX,$3511;
  INT $21;
  JMP @@TestInt11h;
@@DirectInt11h:
  XOR AX,AX;
  MOV ES,AX;
  LES BX,ES:[$44];
@@TestInt11h:
  MOV AX,ES;
  OR  AX,BX;
  JZ  @@NoInt11h;
  CMP ES:[BX].Byte,$CF; { Pour les hypocrites d'interruption miroir, quand }
  JE  @@NoInt11h;       { elles sont bidon, elles pointent sur un IRET! }
  LES DI,StartUp;
  OR  StartUpRec(ES:[DI]).IntExistFlags,flgInt11h;
@@NoInt11h:
   { Int 12h }
  TEST Jumper(DS:[SI]).FlgMethod,flgProtectedMode;
  JZ  @@DirectInt12h;
  MOV AX,$3512;
  INT $21;
  JMP @@TestInt12h;
@@DirectInt12h:
  XOR AX,AX;
  MOV ES,AX;
  LES BX,ES:[$48];
@@TestInt12h:
  MOV AX,ES;
  OR  AX,BX;
  JZ  @@NoInt12h;
  CMP ES:[BX].Byte,$CF; { Pour les hypocrites d'interruption miroir, quand }
  JE  @@NoInt12h;       { elles sont bidon, elles pointent sur un IRET! }
  LES DI,StartUp;
  OR  StartUpRec(ES:[DI]).IntExistFlags,flgInt12h;
@@NoInt12h:
   { Int 13h }
  TEST Jumper(DS:[SI]).FlgMethod,flgProtectedMode;
  JZ  @@DirectInt13h;
  MOV AX,$3513;
  INT $21;
  JMP @@TestInt13h;
@@DirectInt13h:
  XOR AX,AX;
  MOV ES,AX;
  LES BX,ES:[$4C];
@@TestInt13h:
  MOV AX,ES;
  OR  AX,BX;
  JZ  @@NoInt13h;
  CMP ES:[BX].Byte,$CF; { Pour les hypocrites d'interruption miroir, quand }
  JE  @@NoInt13h;       { elles sont bidon, elles pointent sur un IRET! }
  LES DI,StartUp;
  OR  StartUpRec(ES:[DI]).IntExistFlags,flgInt13h;
@@NoInt13h:
   { Int 15h }
  TEST Jumper(DS:[SI]).FlgMethod,flgProtectedMode;
  JZ  @@DirectInt15h;
  MOV AX,$3515;
  INT $21;
  JMP @@TestInt15h;
@@DirectInt15h:
  XOR AX,AX;
  MOV ES,AX;
  LES BX,ES:[$54];
@@TestInt15h:
  MOV AX,ES;
  OR  AX,BX;
  JZ  @@NoInt15h;
  CMP ES:[BX].Byte,$CF; { Pour les hypocrites d'interruption miroir, quand }
  JE  @@NoInt15h;       { elles sont bidon, elles pointent sur un IRET! }
  LES DI,StartUp;
  OR  StartUpRec(ES:[DI]).IntExistFlags,flgInt15h;
@@NoInt15h:
   { Int 16h }
  TEST Jumper(DS:[SI]).FlgMethod,flgProtectedMode;
  JZ  @@DirectInt16h;
  MOV AX,$3516;
  INT $21;
  JMP @@TestInt16h;
@@DirectInt16h:
  XOR AX,AX;
  MOV ES,AX;
  LES BX,ES:[$58];
@@TestInt16h:
  MOV AX,ES;
  OR  AX,BX;
  JZ  @@NoInt16h;
  CMP ES:[BX].Byte,$CF; { Pour les hypocrites d'interruption miroir, quand }
  JE  @@NoInt16h;       { elles sont bidon, elles pointent sur un IRET! }
  LES DI,StartUp;
  OR  StartUpRec(ES:[DI]).IntExistFlags,flgInt16h;
@@NoInt16h:
   { Int 1Ah }
  TEST Jumper(DS:[SI]).FlgMethod,flgProtectedMode;
  JZ  @@DirectInt1Ah;
  MOV AX,$351A;
  INT $21;
  JMP @@TestInt1Ah;
@@DirectInt1Ah:
  XOR AX,AX;
  MOV ES,AX;
  LES BX,ES:[$68];
@@TestInt1Ah:
  MOV AX,ES;
  OR  AX,BX;
  JZ  @@NoInt1Ah;
  CMP ES:[BX].Byte,$CF; { Pour les hypocrites d'interruption miroir, quand }
  JE  @@NoInt1Ah;       { elles sont bidon, elles pointent sur un IRET! }
  LES DI,StartUp;
  OR  StartUpRec(ES:[DI]).IntExistFlags,flgInt1Ah;
@@NoInt1Ah:
   { Int 21h }
  TEST Jumper(DS:[SI]).FlgMethod,flgProtectedMode;
  JNZ @@YesInt21h;
  XOR AX,AX;
  MOV ES,AX;
  LES BX,ES:[$84];
  MOV AX,ES;
  OR  AX,BX;
  JZ  @@NoInt21h;
  CMP ES:[BX].Byte,$CF; { Pour les hypocrites d'interruption miroir, quand }
  JE  @@NoInt21h;       { elles sont bidon, elles pointent sur un IRET! }
@@YesInt21h:
  LES DI,StartUp;
  OR  StartUpRec(ES:[DI]).IntExistFlags,flgInt21h;
@@NoInt21h:
   { Int 2Fh }
  TEST Jumper(DS:[SI]).FlgMethod,flgProtectedMode;
  JZ  @@DirectInt2Fh;
  MOV AX,$352F;
  INT $21;
  JMP @@TestInt2Fh;
@@DirectInt2Fh:
  XOR AX,AX;
  MOV ES,AX;
  LES BX,ES:[$BC];
@@TestInt2Fh:
  MOV AX,ES;
  OR  AX,BX;
  JZ  @@NoInt2Fh;
  CMP ES:[BX].Byte,$CF; { Pour les hypocrites d'interruption miroir, quand }
  JE  @@NoInt2Fh;       { elles sont bidon, elles pointent sur un IRET! }
  LES DI,StartUp;
  OR  StartUpRec(ES:[DI]).IntExistFlags,flgInt2Fh;
@@NoInt2Fh:
   { Int 33h }
  TEST Jumper(DS:[SI]).FlgMethod,flgProtectedMode;
  JZ  @@DirectInt33h;
  MOV AX,$3533;
  INT $21;
  JMP @@TestInt33h;
@@DirectInt33h:
  XOR AX,AX;
  MOV ES,AX;
  LES BX,ES:[$CC];
@@TestInt33h:
  MOV AX,ES;
  OR  AX,BX;
  JZ  @@NoInt33h;
  CMP ES:[BX].Byte,$CF; { Pour les hypocrites d'interruption miroir, quand }
  JE  @@NoInt33h;       { elles sont bidon, elles pointent sur un IRET! }
  LES DI,StartUp;
  OR  StartUpRec(ES:[DI]).IntExistFlags,flgInt33h;
@@NoInt33h:
   { Int 67h }
  TEST Jumper(DS:[SI]).FlgMethod,flgProtectedMode;
  JZ  @@DirectInt67h;
  MOV AX,$3567;
  INT $21;
  JMP @@TestInt67h;
@@DirectInt67h:
  XOR AX,AX;
  MOV ES,AX;
  LES BX,ES:[$19C];
@@TestInt67h:
  MOV AX,ES;
  OR  AX,BX;
  JZ  @@NoInt67h;
  CMP ES:[BX].Byte,$CF; { Pour les hypocrites d'interruption miroir, quand }
  JE  @@NoInt67h;       { elles sont bidon, elles pointent sur un IRET! }
  LES DI,StartUp;
  OR  StartUpRec(ES:[DI]).IntExistFlags,flgInt67h;
@@NoInt67h:
   { GetDosVersion/HandleExist }
  LES DI,StartUp;
  TEST StartUpRec(ES:[DI]).IntExistFlags,flgInt21h;
  JZ  @@NoDos;
  MOV StartUpRec(ES:[DI]).HandleExist,Ya;
  MOV AX,$3306;
  INT $21;
  CMP AL,$06;
  JNE @@OldGetDosVer;
  CMP BH,100;
  JNA @@OldGetDosVer;
  CMP BL,5;
  JNBE @@OldGetDosVer;
  LES DI,StartUp;
  MOV StartUpRec(ES:[DI]).GetDosVer,BX;
   { OS/2 ? }
  MOV AX,$4452;
  INT $21;
  JNC @@EndGetDosVer;
  LES DI,StartUp;
  MOV AL,StartUpRec(ES:[DI]).GetDosVer.Byte;
  CMP AL,10;
  JNBE @@EndGetDosVer;
  LES DI,StartUp;
  MOV StartUpRec(ES:[DI]).OS2,Ya;
  MOV AL,StartUpRec(ES:[DI]).GetDosVer.Byte;
  MOV AH,0;
  MOV BL,10;
  DIV BL;
  LES DI,StartUp;
  MOV StartUpRec(ES:[DI]).OS2LoVer,AL;
  MOV AL,StartUpRec(ES:[DI+1]).GetDosVer.Byte;
  MOV StartUpRec(ES:[DI]).OS2HiVer,AL;
   { Pas de Jump? pour dÇtecter le Version DOS ÇmulÇ! Träfle! }
@@OldGetDosVer:
  MOV AH,$30;
  INT $21;
  LES DI,StartUp;
  MOV StartUpRec(ES:[DI]).GetDosVer,AX;
  CMP AL,0; { Dos 1.0 ? }
  JNE @@EndGetDosVer;
@@NoDos:
  MOV StartUpRec(ES:[DI]).GetDosVer,1; { Yache! Dos 1.0 }
  MOV StartUpRec(ES:[DI]).HandleExist,No;
@@EndGetDosVer:
   { Demande le code de pays }
  MOV BX,$FFFF;
  MOV CX,$FFFF;
  TEST Jumper(DS:[SI]).FlgMethod,flgNoCountryDetect;
  JNZ @@EndCountry;
  TEST StartUpRec(ES:[DI]).IntExistFlags,flgInt21h;
  JZ  @@CodeCountryOff;
  CMP StartUpRec(ES:[DI]).GetDosVer.Byte,3;
  JB  @@CodeCountryOff;
  JNE @@OkCodeCountry;
  CMP StartUpRec(ES:[DI+1]).GetDosVer.Byte,3;
  JB  @@CodeCountryOff; { C'est un DOS 3, mais infÇrieur au .3... }
@@OkCodeCountry:
  ADD DI,Offset StartUpRec.Date;
  MOV CX,7;
  MOV BX,$FFFF;
  MOV DX,BX;
  MOV AX,$6501;
  INT $21;
  MOV BX,ES:[DI+3];
  MOV CX,ES:[DI+5];
  LES DI,StartUp;
@@CodeCountryOff:
  MOV StartUpRec(ES:[DI]).CountryCode,BX;
  MOV StartUpRec(ES:[DI]).CodePage,CX;
   { GetCountry }
  CLD;
  PUSH DI;
   ADD DI,Offset StartUpRec.Date;
   MOV CX,TYPE CountryRec;
   MOV AL,0;
   REP STOSB;
  POP DI;
  TEST StartUpRec(ES:[DI]).IntExistFlags,flgInt21h;
  JZ  @@EndCountry;
  PUSH DS;
   MOV AX,$3800;
   LDS DX,StartUp;
   ADD DX,Offset StartUpRec.Date;
   INT $21;
  POP DS;
  LES DI,StartUp;
  CMP StartUpRec(ES:[DI]).GetDosVer.Byte,2;
  JNE @@EndCountry;
   { Dos 2.xx, c'Çtait codÇ de faáon batarde... }
  MOV AX,StartUpRec(ES:[DI]).Curr[4].Word;
  MOV StartUpRec(ES:[DI]).DeSep,AX;
  MOV AX,StartUpRec(ES:[DI]).Curr[2].Word;
  MOV StartUpRec(ES:[DI]).ThSep,AX;
@@EndCountry:
   { IsNovell }
  MOV AX,$DC00;
  TEST StartUpRec(ES:[DI]).IntExistFlags,flgInt21h;
  JZ  @@EndNovell;
  XOR CX,CX;
  INT $21;
  CMP AL,0;
  JE  @@EndNovell;
  MOV AL,Ya;
  LES DI,StartUp;
@@EndNovell:
  MOV StartUpRec(ES:[DI]).IsNovell,AL;
   { GetDosBlock/Mode RÇel seulement }
  XOR BX,BX;
  XOR DX,DX;
  TEST Jumper(DS:[SI]).FlgMethod,flgProtectedMode;
  JNZ  @@NoDosBlock;
  TEST StartUpRec(ES:[DI]).IntExistFlags,flgInt21h;
  JZ  @@NoDosBlock;
  MOV AH,$52; { Garantie Ö 200% que si cet appel Ö lieu en }
  INT $21;    { mode protÇgÇ que sa plante! }
  ADD BX,12;
  MOV DX,ES;
  DEC DX;
  LES DI,StartUp;
@@NoDosBlock:
  MOV StartUpRec(ES:[DI]).GetDosBlock.Word,BX;
  MOV StartUpRec(ES:[DI+2]).GetDosBlock.Word,DX;
   { DÇtection de Windows }
  MOV StartUpRec(ES:[DI]).WinLoVer.Word,0;
  TEST StartUpRec(ES:[DI]).IntExistFlags,flgInt2Fh;
  JZ  @@NoWin;
  MOV AX,$1600;
  INT $2F;
  CMP AL,$01;
  JE  @@W386X;
  CMP AL,$FF;
  JE  @@W386X;
  CMP AL,$00;
  JE  @@WinFucked;
  CMP AL,$80;
  JE  @@WinFucked;
  LES DI,StartUp;
  MOV StartUpRec(ES:[DI]).WinLoVer.Word,AX;
  MOV StartUpRec(ES:[DI]).Win,winEnhanced;
  JMP @@EndWin;
@@W386X:
  LES DI,StartUp;
  MOV StartUpRec(ES:[DI]).WinLoVer.Word,$200;
  MOV StartUpRec(ES:[DI]).Win,win386X;
  JMP @@EndWin;
@@WinFucked:
  MOV AX,$4680;
  INT $2F;
  CMP AL,$80;
  JNE @@Win;
@@NoWin:
  LES DI,StartUp;
  MOV StartUpRec(ES:[DI]).Win,winNo;
  JMP @@EndWin;
@@Win:
  MOV AX,$1605;
  XOR BX,BX;
  XOR SI,SI;
  XOR CX,CX;
  MOV ES,CX;
  PUSH DS;
   MOV DS,CX;
   MOV DX,$0001;
   INT $2F;
  POP DS;
  CMP CX,0;
  JNE @@Standard;
  MOV AX,$1606;
  INT $2F;
  LES DI,StartUp;
  MOV StartUpRec(ES:[DI]).Win,winReal;
  JMP @@EndWin;
@@Standard:
  LES DI,StartUp;
  MOV StartUpRec(ES:[DI]).Win,winStandard;
@@EndWin:
   { Contrìleur de manette de jeu existe ? }
  TEST Jumper(DS:[SI]).FlgMethod,flgJoyPerBios;
  JNZ  @@JoyPerBios;
  MOV DX,$201;
  MOV AL,1;
  OUT DX,AL;
  IN  AL,DX;
  TEST AL,$F;
  JNZ  @@CtrlJoyExist;
@@NoJoy:
  MOV AL,No;
@@SetJoyPort0:
  XOR DX,DX;
  JMP @@EndJoy;
@@JoyPerBios:
  TEST StartUpRec(ES:[DI]).IntExistFlags,flgInt15h;
  JZ  @@NoJoy;
  MOV AX,$0084;
  XOR DX,DX;
  INT $15;
  MOV AL,0;
  CMC;
  ADC AL,0;
  LES DI,StartUp;
  JMP @@SetJoyPort0;
@@CtrlJoyExist:
  MOV AL,Ya;
@@EndJoy:
  MOV StartUpRec(ES:[DI]).JoyExist,AL;
  MOV StartUpRec(ES:[DI]).JoyPort,DX;
  { BiosJostickSupport/Contrìleur clavier ? }
  PUSH ES;
   {$IFOPT G+}
    PUSH $FFFF;
    POP ES;
   {$ELSE}
    MOV AX,$FFFF;
    MOV ES,AX;
   {$ENDIF}
   CMP ES:[$E].Byte,$FC;
   JE  @@BiosSupport;
   MOV BL,ctrlkb8048;
   MOV AL,No;
   JMP @@EndBiosJoy;
@@BiosSupport:
   MOV AL,Ya;
   MOV BL,ctrlkb8042;
@@EndBiosJoy:
  POP ES;
  MOV StartUpRec(ES:[DI]).BiosJoy,AL;
  MOV StartUpRec(ES:[DI]).KbdCtrl,BL;
   { Potentio Mätre de la manette de jeu }
  XOR BX,BX;
  CMP StartUpRec(ES:[DI]).JoyExist,Ya;
  JNE @@NoJoyPot;
  MOV BX,416;
  TEST Jumper(DS:[SI]).FlgMethod,flgJoyPerBios;
  JNZ @@JoyPotPerBios;
  MOV BX,270;
@@JoyPotPerBios:
@@NoJoyPot:
  MOV StartUpRec(ES:[DI]).JoyPotentioMeter,BX;
   { Get1LPT/LPTExist/NumLPT }
  XOR AX,AX;
  MOV BX,AX;
  TEST Jumper(DS:[SI]).FlgMethod,flgProtectedMode;
  JNZ  @@BiosLPT;
  TEST Jumper(DS:[SI]).FlgMethod,flgEquipPerBios;
  JNZ  @@BiosLPT;
  PUSH ES;
   MOV ES,AX;
   MOV AL,$FF;
   CMP ES:[$40E].Word,BX;
   JZ  @@LPT2;
   MOV AL,3;
   MOV AH,Ya;
   INC BX;
@@LPT2:
   CMP ES:[$40C].Word,0;
   JZ  @@LPT3;
   MOV AL,2;
   MOV AH,Ya;
   INC BX;
@@LPT3:
   CMP ES:[$40A].Word,0;
   JZ  @@LPT4;
   MOV AL,1;
   MOV AH,Ya;
   INC BX;
@@LPT4:
   CMP ES:[$408].Word,0;
   JZ  @@EndGet1LPT;
   MOV AL,0;
   MOV AH,Ya;
   INC BX;
@@EndGet1LPT:
  POP ES;
  JMP @@EndLPT;
@@BiosLPT:
  TEST StartUpRec(ES:[DI]).IntExistFlags,flgInt11h;
  JZ  @@EndLPT;
  INT $11;
  MOV CL,6;
  SHR AH,CL;
  MOV BL,AH;
  MOV AX,$00FF;
  CMP BL,0;
  JE  @@EndLPT;
  MOV AX,$0100;
@@EndLPT:
  MOV StartUpRec(ES:[DI]).Get1LPT,AL;
  MOV StartUpRec(ES:[DI]).LPTExist,AH;
  MOV StartUpRec(ES:[DI]).NmLPT,BL;
   { BiosEnhKbd }
  TEST StartUpRec(ES:[DI]).IntExistFlags,flgInt16h;
  JZ  @@NoBiosEnhKbd;
  MOV AH,$02;
  INT $16;
  MOV OldByte,AL;
  XOR AL,$FF;
  MOV AH,$12;
  INT $16;
  CMP OldByte,AL;
  JE  @@NoBiosEnhKbd;
  MOV AL,Ya;
  JMP @@BiosEnhKbd;
@@NoBiosEnhKbd:
  MOV AL,No;
@@BiosEnhKbd:
  MOV StartUpRec(ES:[DI]).BiosKbdEnh,AL;
   { KbdModel/KbdReadPort }
  PUSH ES;
   {$IFOPT G+}
    PUSH $0040;
    POP ES;
    MOV AL,ES:[$96];
   {$ELSE}
    XOR AX,AX;
    MOV ES,AX;
    MOV AL,ES:[$496];
   {$ENDIF}
   AND AL,$10;
   JZ @@NoExtKbd;
   MOV AL,kbMF;
   JMP @@EndIsExtKbd;
@@NoExtKbd:
   MOV AX,$FFFF;
   MOV ES,AX;
   CMP ES:[$E].Byte,$FC;
   JE  @@ATKb;
   CMP ES:[$E].Byte,$FE;
   JE  @@XTKb;
   CMP ES:[$E].Byte,$56;
   JE  @@ContermKb;
   MOV AL,kbPC;
   JMP @@EndIsExtKbd;
@@ContermKb:
   MOV AL,kbConterm;
   JMP @@EndIsExtKbd;
@@XTKb:
   MOV AL,kbXT;
   JMP @@EndIsExtKbd;
@@ATKb:
   MOV AL,kbAT;
@@EndIsExtKbd:
  POP ES;
  MOV StartUpRec(ES:[DI]).KbdModel,AL;
  MOV StartUpRec(ES:[DI]).KbdReadPort,$0060;
   { MemTotalSize }
  PUSH ES;
   XOR AX,AX;
   TEST Jumper(DS:[SI]).FlgMethod,flgEquipPerBios;
   JZ  @@DirectMemTotalSize;
   TEST StartUpRec(ES:[DI]).IntExistFlags,flgInt12h;
   JZ  @@SetMemTotalSize;
   INT $12;
   JMP @@SetMemTotalSize;
@@DirectMemTotalSize:
   MOV ES,AX;
   MOV AX,ES:[$413];
@@SetMemTotalSize:
  POP ES;
  MOV StartUpRec(ES:[DI]).MemTotalSize,AX;
   { EmmExist}
  XOR AX,AX;
  XOR BX,BX;
  PUSH ES;
   MOV StartUpRec(ES:[DI]).EmmTotalSize,AX;
   TEST StartUpRec(ES:[DI]).IntExistFlags,flgInt67h;
   JZ  @@NoEmm;
   TEST Jumper(DS:[SI]).FlgMethod,flgProtectedMode;
   JNZ @@NoEmm;                           { Le mode protÇgÇ ne permet  pas }
   PUSH ES;                               { de tester la prÇsence de l'EMM }
    MOV ES,AX;                            { par  la mÇthode  tradionnelle, }
    LES BX,ES:[$19C];                     { cela prouve  donc  que le mode }
    CMP ES:[10].Char,'E';                 { protÇgÇ est une poubelle conáu }
    JNE @@NoEmm;                          { par       des     Intel-Jellos }
    CMP ES:[11].Word,'MM';                { "unintelligente"... }
    JNE @@NoEmm;
    CMP ES:[13].Word,'XX';
    JNE @@NoEmm;
    CMP ES:[15].Word,'XX';
    JNE @@NoEmm;
    MOV AH,$42;
    INT $67;
    {$IFOPT G+} SHR DX,4; {$ELSE} MOV CL,4; SHR DX,CL; {$ENDIF}
   POP ES;
   MOV StartUpRec(ES:[DI]).EmmTotalSize,DX;
   MOV AH,$41;
   INT $67;
   MOV AL,Ya;
   JMP @@EndEmmExist;
@@NoEmm:
   MOV AL,No;
@@EndEmmExist:
  POP ES;
  MOV StartUpRec(ES:[DI]).EmmExist,AL;
  MOV StartUpRec(ES:[DI]).EmmSeg,BX;
   { XmsExist}
  TEST StartUpRec(ES:[DI]).IntExistFlags,flgInt2Fh;
  JZ  @@NoXmm;
  MOV AX,$4300;
  INT $2F;
@@NoXmm:
  MOV CL,No;
  CMP AL,$80;
  JNE @@EndXms;
  MOV AX,$4310;
  INT $2F;
  MOV DX,ES;
  LES DI,StartUp;
  MOV StartUpRec(ES:[DI]).XmmCtrl.Word,BX;
  MOV StartUpRec(ES:[DI+2]).XmmCtrl.Word,DX;
  CMP StartUpRec(ES:[DI]).GetDosVer.Byte,5;
  JE  @@XmsDos5;
  CMP StartUpRec(ES:[DI]).GetDosVer.Byte,4;
  JNE @@CmosMethod;
@@XmsDos4:
  LES DI,StartUpRec(ES:[DI]).GetDosBlock;
  MOV BX,DosBlockRec(ES:[DI]).Ver.Dos4.XmsSizeK;
  JMP @@SetXmsSize;
@@XmsDos5:
  LES DI,StartUpRec(ES:[DI]).GetDosBlock;
  MOV BX,DosBlockRec(ES:[DI]).Ver.Dos5.XmsSizeK;
  JMP @@SetXmsSize;
@@CmosMethod:
  XOR BX,BX;
  TEST Jumper(DS:[SI]).FlgMethod,flgNoCmosDetect;
  JNZ @@SetXmsSize;
  MOV AL,$17;
  OUT $70,AL;
  NOP; NOP; NOP; NOP;
  IN  AL,$71;
  NOP; NOP; NOP; NOP;
  MOV BL,AL;
  MOV AL,$18;
  OUT $70,AL;
  NOP; NOP; NOP; NOP;
  IN  AL,$71;
  NOP; NOP; NOP; NOP;
  MOV BH,AL;
@@SetXmsSize:
  LES DI,StartUp;
  MOV StartUpRec(ES:[DI]).XmsTotalSize,BX;
  MOV CL,Ya;
@@EndXms:
  MOV StartUpRec(ES:[DI]).XmmExist,CL;
   { GetCmosPort/CtrlCmos/ExtBiosExist }
  MOV StartUpRec(ES:[DI]).ExtBiosExist,No;
  MOV StartUpRec(ES:[DI]).ExtBiosSizeK,0;
  TEST Jumper(DS:[SI]).FlgMethod,flgProtectedMode;
  JNZ @@SkipXTCmosTest;
  TEST StartUpRec(ES:[DI]).IntExistFlags,flgInt15h;{ƒø }
  MOV AX,$FFFF;                                    { ≥ }
  MOV ES,AX;        {~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ≥ }
  JZ  @@SetCmosPort;{ <ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ }
  CMP ES:[$E].Byte,253;
  JA  @@SetCmosPort;
@@SkipXTCmosTest:
  XOR AX,AX;
  TEST Jumper(DS:[SI]).FlgMethod,flgNoExtBiosMemDetect;
  JNZ @@SkipExtInt15h;
  MOV AH,$88;
  INT $15;
@@SkipExtInt15h:
  CMP AX,0;
  MOV CX,$70;
  MOV BL,ctrlCmosMC146818;
  JE  @@SetCmosPort; { Pas de Ext Bios Int 15h }
  LES DI,StartUp;
  MOV StartUpRec(ES:[DI]).ExtBiosExist,Ya;
  MOV StartUpRec(ES:[DI]).ExtBiosSizeK,AX;
  JMP @@DetectCmos;
@@SetCmosPort:
  MOV AX,$FFFF;
  MOV ES,AX;
  CMP ES:[$E].Byte,252;
  JE  @@DetectCmos;
  TEST Jumper(DS:[SI]).FlgMethod,flgNoCmosDetect;
  JZ @@NoCmos;
  CMP ES:[$E].Byte,255; { PC ? }
  JE  @@NoCmos;
  CMP ES:[$E].Byte,253; { PC Junior ? }
  JE  @@NoCmos;
  MOV DX,$2C0;
  IN  AL,DX;
  TEST AL,$F;
  JNZ @TooBad;
  MOV DX,$2CB;
  IN  AL,DX;
  CMP AL,$DE;
  JE  @CmosB;
  MOV AL,$DE;
  OUT DX,AL;
  IN  AL,DX;
  CMP AL,$DE;
  JE  @CmosB;
@TooBad:
  XOR AL,AL;
  OUT DX,AL;
  INC DX;
  IN  AL,DX;
  DEC DX;
  TEST AL,$F;
  JNZ @TriBad;
  MOV AL,$0B;
  OUT DX,AL;
  INC DX;
  IN  AL,DX;
  CMP AL,$DE;
  JE  @CmosC;
  MOV AL,$DE;
  OUT DX,AL;
  IN  AL,DX;
  CMP AL,$DE;
  JE  @CmosC;
@TriBad:
  XOR AL,AL;
  OUT DX,AL;
  MOV AL,$80;
  OUT DX,AL;
  MOV BL,$E;
  INC DX;
  MOV AL,BL;
  OUT DX,AL;
  DEC DX;
  MOV AL,$88;
  OUT DX,AL
  MOV AL,$98;
  OUT DX,AL
  MOV AL,$88;
  OUT DX,AL
  MOV AL,$80;
  OUT DX,AL;
  MOV AL,$A0;
  OUT DX,AL;
  INC DX;
  MOV CX,$100;
@LoopA:
  IN  AL,DX
  TEST AL,1
  LOOPZ @LoopA;
  JZ  @NoCmosXT;
  MOV CX,$100;
@LoopB:
  IN  AL,DX
  TEST AL,1
  LOOPNZ @LoopB;
  JZ @CmosA;
@NoCmosXT:
  MOV DX,$2C0;
  XOR AL,AL;
  OUT DX,AL;
  { XT, difficile Ö dire si un CMOS existe... Wyse, Commodore,...
    mais si oui: le Port est E0h pour les ordinateurs Wyses XT }
  MOV CX,$E0;
  MOV BL,ctrlCmosUnknown;
  JMP @@EndCmosXT;
@CmosA:
  MOV BL,ctrlCmosRTC58321;(* RTC-58321, 2C0h-2C1h *)
  JMP @SetCmosXTPort;
@CmosB:
  MOV BL,ctrlCmosMM58167a;(* MM58167, 2C0h-2DFh *)
  JMP @SetCmosXTPort;
@CmosC:
  MOV BL,ctrlCmosMM58167b;(* MM58167, 2C0h-2C7h *)
@SetCmosXTPort:
  MOV CX,$2C0;
@@EndCmosXT:
  JMP @@DetectCmos;
@@NoCmos:
  XOR CX,CX; { Je fixe le port Ö 0, mais il faudrait
	      surtout pas essayez pour voir...}
  MOV BL,ctrlCmosNo;
@@DetectCmos:
  LES DI,StartUp;
  MOV StartUpRec(ES:[DI]).CmosPort,CX;
  MOV StartUpRec(ES:[DI]).CtrlCmos,BL;
   { MouseDriverExist/Version/Nombre de bouton }
  XOR AX,AX;
  LES DI,StartUp;
  MOV StartUpRec(ES:[DI]).MouseVer,AX;
  MOV StartUpRec(ES:[DI]).MsButton,AX;
  TEST StartUpRec(ES:[DI]).IntExistFlags,flgInt33h;
  JZ  @@NoMouse;
  TEST Jumper(DS:[SI]).FlgMethod,flgNoMouseDetect;
  JNZ @@NoMouse;
  MOV ES,AX;
  MOV BX,ES:[$CE];
  MOV ES,BX;
  CMP ES:[0].Byte,$CF; { Pour les hypocrites d'interruption souris, quand }
  JE  @@NoMouse;       { elles sont bidon, elles pointent sur un IRET! }
  CMP ES:[3].Word,'OL';{ Teste le copyright Ö la "snobinare" de "LOGITECH"}
  JNE @@NoLogitech;
  CMP ES:[5].Word,'IG';
  JNE @@NoLogitech;
  CMP ES:[7].Word,'ET';
  JNE @@NoLogitech;
  CMP ES:[9].Word,'HC';
  JNE @@NoLogitech;
  XCHG CL,CH;
  LES DI,StartUp;
  MOV StartUpRec(ES:[DI]).MouseVer,CX;
  MOV AL,msLogitech;
  JMP @@EndMouse;
@@NoLogitech:
  XOR AX,AX;
  INT $33;
  AND AL,msStandard;
  CMP AL,msStandard;
  JNE @@EndMouse;
  MOV AX,$004D;
  INT $33;
  CMP ES:[DI].Word,'YK'; { KYE }
  JNE @@NoGenius;
  CMP ES:[DI+2].Char,'E';
  JNE @@NoGenius;
  MOV AX,$0011;
  INT $33;
  CMP AX,$FFFF;
  JE  @@PatateGenius;
  LES DI,StartUp;
  MOV StartUpRec(ES:[DI]).MsButton,BX;
@@PatateGenius:
  MOV AL,msGenius;
  JMP @@EndMouse;
@@NoGenius:
  CMP ES:[DI+27].Word,'iM';
  JNE @@NoMicro;
  CMP ES:[DI+29].Word,'rc';
  JNE @@NoMicro;
  CMP ES:[DI+31].Word,'so';
  JNE @@NoMicro;
  CMP ES:[DI+33].Word,'fo';
  JNE @@NoMicro;
  CMP ES:[DI+35].Char,'t';
  JNE @@NoMicro; { Ah! Fuckanadationamacrostofumerdusapiloteproute! }
  MOV AX,$006C;
  INT $33;
  MOV BX,ES:[DI];
  LES DI,StartUp;
  MOV StartUpRec(ES:[DI]).MouseVer,BX;
  MOV AL,msMicrosoft;
  JMP @@EndMouse;
@@NoMicro:
  MOV AX,$004B;
  INT $33;
  CMP ES:[DI].Word,'-Z'; { Z-NIX }
  JNE @@NoZNIX;
  CMP ES:[DI+2].Word,'IN';
  JNE @@NoZNIX;
  CMP ES:[DI+4].Char,'X';
  JNE @@noZNIX;
  MOV AL,msZNIX;
  JMP @@EndMouse;
@@NoZNIX:
  MOV AX,$3000;
  INT $33;
  CMP AX,$FFFF;
  JE  @@Smooth;
  MOV AL,Ya;
  JMP @@EndMouse;
@@Smooth:
  XCHG BL,BH;
  LES DI,StartUp;
  MOV StartUpRec(ES:[DI]).MouseVer,BX;
  MOV AL,msSmooth;
  JMP @@EndMouse;
@@NoMouse:
  MOV AL,msNoMouse;
@@EndMouse:
  LES DI,StartUp;
  MOV StartUpRec(ES:[DI]).Mouse,AL;
   (* ComputerName *)
  { La variable PS2 n'est pas  de la dÇmagogie,  car  dans les prochaines
    instructions, ces variables permettra, sans faire 1 000 000 de teste,
    de dÇtecter un bus MCA  des PS/2.  Voyez  que c'est utile les psychos
    compacteur Ö la Hacker! }
  MOV StartUpRec(ES:[DI]).PS2,No;
  TEST Jumper(DS:[SI]).FlgMethod,flgProtectedMode;
  JNZ @@Int15hTestComputerName;
  MOV AX,$F000;
  MOV ES,AX;
  CMP ES:[$E076].Word,'ED'; { DE }
  JE  @@TestDell;
@@ContinueComputerName:
  MOV AL,ES:[$FFFE];
  CMP AL,$FD;
  JB  @@NotSupportComputerName;
  LES DI,StartUp;
@@Int15hTestComputerName:
  TEST StartUpRec(ES:[DI]).IntExistFlags,flgInt15h;
  JZ  @@NoInt15hComputerName;
  TEST Jumper(DS:[SI]).FlgMethod,flgOnlyMem4ComputerName;
  JNZ  @@NoInt15hComputerName;
  MOV AH,$C0;
  XOR BX,BX;
  MOV ES,BX;
  INT $15;
  MOV AX,ES;
  OR  AX,BX;
  CMP AX,0;
  JE  @@NotSupportComputerName;
  MOV AX,ES:[BX+2];
  CMP AX,$01FC; { Les races de clones AT ? }
  JE  @@CloneAT;
  CMP AX,$04FC; { PS/2 Modäle 50/50Z ? }
  JE  @@PS2_50x;
  CMP AX,$09FC; { PS/2 Modäle 25 ou 30 avec 286 ? }
  JE  @@PS2_25_30;
  CMP AX,$00E1; { PS/2 Modäle 55-5530 Laptop ? }
  JE  @@PS2;
  CMP AL,$F8;
  JE  @@PS2Fucked; { Gros chance de PS/2... }
  CMP AL,$F9; { PC-Convertible ? }
  JE  @@PCConvertible;
  CMP AX,$05FC; { PS/2 Modäle 60 ? }
  JE  @@PS2;
  CMP AX,$00FA; { PS/2 Modäle 30 ? }
  JE  @@PS2;
  CMP AX,$01FA; { PS/2 Modäle 25/25L ? }
  JE  @@PS2;
    { Les cas suivants n'ont pas de sous-spÇcification: }
   { 01FBh, PC-XT/2 passe sans teste! }
   { 02FCh, PC-XT/286 passe sans teste! }
   { 06FCh, 7552 Gearbox passe sans teste! }
   { 0BFCh, PS/1 Modäle 2011 passe sans teste! }
   { 42FCh, Olivetti M280 passe sans teste! }
   { 45FCh, Olivetti M380 (XP1/XP3/XP5) passe sans teste! Quoi que... }
   { 48FCh, Olivetti M290 passe sans teste! }
   { 4CFBh, Olivetti M200 passe sans teste! }
   { 4EFEh, Olivetti M111 passe sans teste! }
   { 4FFCh, Olivetti M250 passe sans teste! }
   { 50FCh, Olivetti M380 (XP7) passe sans teste! }
   { 51FCh, Olivetti PCS286 passe sans teste! }
   { 52FCh, Olivetti M300 passe sans teste! }
  JMP @@SetComputerName;
@@PCConvertible:
  MOV AH,0;
  JMP @@SetComputerName;
@@CloneAT:
  MOV CL,ES:[BX+4];
  CMP CL,$30;
  JE  @@NotTandy3000NL;
  MOV AX,cnTandy3000NL;
  JMP @@SetComputerName;
@@NotTandy3000NL:
  CMP CL,$20;
  JE  @@NotAST;
  MOV AX,cnAST;
  JMP @@SetComputerName;
@@NotAST:
  CMP CL,0;
  JE  @@FuckedDateCloneAT;
  LES DI,StartUp;
  MOV AL,StartUpRec(ES:[DI]).Up32Bits; { Compaq 286/386 }
  MOV AH,$FA;
  JMP @@SetComputerName;
@@FuckedDateCloneAT:
  MOV AX,$FFFF;
  MOV AX,ES:[$B];
  CMP AL,'9';
  JNE @@NotModel90;
  MOV AX,ES:[$A];
   { 2639h, Toshiba T5200/200 }
   { 4139h, Toshiba T4500SX-C }
   { 6F39h, Toshiba 1800SX }
   { 6E39h, Toshiba 1850SX }
   { 4539h, Toshiba 4400C }
@@NotModel90:
   { 3538h, PC-AT 319 ou 339, 8Mhz, passe sans teste... }
   { 3838h, Toshiba T5200/100, passe sans teste... }
   { 3938h, Toshiba T1200/XE, passe sans teste... }
   { 3738h, Tandy 3000, passe sans teste... }
  JMP @@SetComputerName;
@@TestDell:
  CMP ES:[$E078].Word,'LL';
  JNE @@ContinueComputerName;
  MOV AL,ES:[$E845];
  MOV AH,$A3;
  JMP @@SetComputerName;
@@SetIBM7561_2:
  MOV AX,cnIBM7561_2;
  JMP @@SetComputerName;
@@SetPS2Model55_5551:
  MOV AX,cnPS2M55_5551;
  JMP @@PS2;
   { PS/2 Modäle 90XP et 95XP, race de complexÇ Ö n'en plus finir... }
@@SetPS2Model90XP:
  MOV AX,cnPS2M90XP;
  JMP @@PS2;
@@SetPS2Model95XP:
  MOV AX,cnPS2M95XP;
  JMP @@PS2;
@@PS2Fucked:
  MOV BL,ES:[BX+4];
  MOV BH,AH;
  CMP AH,$05; { IBM PC 7566 ? }
  JE  @@SetComputerName;
  CMP BX,$0700; { IBM PC 7561/2 ? }
  JE  @@SetIBM7561_2;
  CMP BX,$0702; { IBM PC 7561/2 ? }
  JE  @@SetIBM7561_2;
  CMP AH,$07; { PS/2 Modäle 55-5551 ? }
  JE  @@SetPS2Model55_5551;
  CMP AH,$0E; { PS/1 486SX ? }
  JE  @@SetComputerName;
  CMP AH,$0F; { PS/1 486DX ? }
  JE  @@SetComputerName;
  CMP AH,$10; { PS/2 Modäle 55-5551 ? }
  JE  @@SetPS2Model55_5551;
  CMP AH,$12; { PS/2 Modäle 95 XP ? }
  JE  @@SetPS2Model95XP;
  CMP AH,$15; { PS/2 Modäle 90 XP ? }
  JE  @@SetPS2Model90XP;
  CMP AH,$30; { PS/1 Modäle 2121 ? }
  JE  @@SetComputerName;
  CMP AH,$39; { PS/2 Modäle 95 XP ? }
  JE  @@SetPS2Model95XP;
  CMP AH,$3F; { PS/2 Modäle 90 XP ? }
  JE  @@SetPS2Model90XP;
  CMP AH,$40; { PS/2 Modäle 95 XP ? }
  JE  @@SetPS2Model95XP;
  CMP AH,$49; { PS/ValuePoint 325T ? }
  JE  @@SetComputerName;
  CMP AH,$4A; { PS/ValuePoint 425SX ? }
  JE  @@SetComputerName;
  CMP AH,$4B; { PS/ValuePoint 433DX ? }
  JE  @@SetComputerName;
  CMP AH,$57; { PS/2 Modäle 90 XP ? }
  JE  @@SetPS2Model90XP;
  CMP AH,$58; { PS/2 Modäle 95 XP ? }
  JE  @@SetPS2Model95XP;
  CMP AH,$59; { PS/2 Modäle 90 XP ? }
  JE  @@SetPS2Model90XP;
  CMP AH,$5A; { PS/2 Modäle 95 XP ? }
  JE  @@SetPS2Model95XP;
  CMP AH,$5B; { PS/2 Modäle 90 XP ? }
  JE  @@SetPS2Model90XP;
  CMP AH,$5C; { PS/2 Modäle 95 XP ? }
  JE  @@SetPS2Model95XP;
  CMP AH,$5E; { IBM ThinkPad 700 ? }
  JE  @@SetComputerName;
  CMP AH,$61; { Olivetti P500 ? }
  JE  @@SetComputerName;
  CMP AH,$62; { Olivetti P800 ? }
  JE  @@SetComputerName;
  CMP AH,$F2; { Reply Model 32 ? }
  JE  @@SetComputerName;
  CMP AH,$F6; { Memorex Telex ? }
  JE  @@SetComputerName;
  CMP AH,$FD; { Processeur IBM Complexe (avec VPD) ? }
  JE  @@SetComputerName;
  JMP @@PS2;
@@PS2_25_30:
  CMP CL,2;
  JNE @@PS2; { PS/2 Modäle 25-286 }
  JMP @@AddSubPS2; { PS/2 Modäle 30-286 }
@@PS2_50x:
  CMP CL,3;
  JNE @@PS2; { P2/Model 50 }
@@AddSubPS2:
  MOV CL,ES:[BX+4];
  MOV CH,0;
  ADD AX,CX; { PS/2 Model 50Z }
@@PS2:
  LES DI,StartUp;
  MOV StartUpRec(ES:[DI]).PS2,Ya;
  JMP @@SetComputerName;
@@NoInt15hComputerName:
  MOV AX,$F000;
  MOV ES,AX;
@@NotSupportComputerName:
  MOV BX,ES:[$FFFD];
  CMP BX,$43FE; { Olivetti M240 ? }
  JE  @@OlivettiM240;
  CMP BX,$46FF;
  JNE @@NoOlivettiM15;
  MOV AL,$46; { Olivetti M15 }
  JMP @@SetUpComputerName;
@@OlivettiM240:
  MOV AX,BX;
  JMP @@SetComputerName;
@@NoOlivettiM15:
  CMP ES:[$C000].Byte,$21;
  JNE @@NoTandy1000;
  MOV AL,$21; { Tandy 1000 }
@@NoTandy1000:
@@SetUpComputerName:
  MOV AH,0;
@@SetComputerName:
  LES DI,StartUp;
  MOV StartUpRec(ES:[DI]).ComputerName,AX;
   { Modäle de Bus }
  CMP StartUpRec(ES:[DI]).PS2,Ya
  JE  @@MCA;
  CMP StartUpRec(ES:[DI]).CPU,cpui486;
  JA  @@EISA;
  CMP StartUpRec(ES:[DI]).CPU,cpu80286;
  JA  @@ISA16;
  MOV AL,busISA8;
  JMP @@SetBus;
@@ISA16:
  MOV AL,busISA16;
  JMP @@SetBus;
@@EISA:
  MOV AL,busEISA;
  JMP @@SetBus;
@@MCA:
  MOV AL,busMCA;
  JMP @@SetBus;
@@SetBus:
  MOV StartUpRec(ES:[DI]).Bus,AL;
   { ComExist/NmCom }
  PUSH ES;
   XOR AX,AX;
   TEST Jumper(DS:[SI]).FlgMethod,flgEquipPerBios;
   JNZ  @@ComInt11h;
   TEST Jumper(DS:[SI]).FlgMethod,flgProtectedMode;
   JNZ  @@ComInt11h;
@@NotComInt11h:
   MOV ES,AX;
   MOV AL,ES:[$411];
   JMP @@EndComDetect;
@@ComInt11h:
   TEST StartUpRec(ES:[DI]).IntExistFlags,flgInt11h;
   JZ  @@EndComDetect;
   INT $11;
   MOV AL,AH;
@@EndComDetect:
  POP ES;
  SHR AL,1;
  AND AL,7;
  MOV StartUpRec(ES:[DI]).NmCom,AL;
  CMP AL,0;
  JE  @@NoCom;
  MOV AL,Ya;
@@NoCom:
  MOV StartUpRec(ES:[DI]).ComExist,AL;
   { FloppyDskExist, NmFloppyDsk }
  XOR AX,AX;
  PUSH ES;
   TEST Jumper(DS:[SI]).FlgMethod,flgEquipPerBios;
   JNZ @@FlopInt11h;
   TEST Jumper(DS:[SI]).FlgMethod,flgProtectedMode;
   JNZ @@FlopInt11h;
@@NotFlopInt11h:
   MOV ES,AX;
   MOV AL,ES:[$410];
   JMP @@EndFlopDetect;
@@FlopInt11h:
   TEST StartUpRec(ES:[DI]).IntExistFlags,flgInt11h;
   JZ  @@EndComDetect;
   INT $11;
@@EndFlopDetect:
  POP ES;
  MOV BL,AL;
  AND BL,1;
  MOV StartUpRec(ES:[DI]).FloppyDskExist,BL;
  CMP BL,0;
  JE  @@NoFloppyDskExist;
  MOV CL,6;
  SHR AL,CL;
  INC AL;
  MOV AH,AL;
@@NoFloppyDskExist:
  MOV StartUpRec(ES:[DI]).NmFloppyDsk,AH;
   { HardDskExist, NmHardDsk, HardDskCtrl }
  TEST Jumper(DS:[SI]).FlgMethod,flgProtectedMode;
  JNZ @@BiosNmHD;
  TEST Jumper(DS:[SI]).FlgMethod,flgEquipPerBios;
  JZ  @@DirectNmHD;
@@BiosNmHD:
  PUSH ES;
   PUSH DI;
    MOV AH,$08;
    MOV DL,$80;
    INT $13;
   POP DI;
  POP ES;
  MOV AL,DL;
  JMP @@SetNmHD;
@@DirectNmHD:
  PUSH ES;
   XOR AX,AX;
   MOV ES,AX;
   MOV AL,ES:[$475];
  POP ES;
@@SetNmHD:
  MOV StartUpRec(ES:[DI]).NmHardDsk,AL;
  CMP AL,0;
  JNE @@NoHardDsk;
  MOV AL,Ya;
@@NoHardDsk:
  MOV StartUpRec(ES:[DI]).HardDskExist,AL;
  MOV AL,ctrlhdNo;
  CMP StartUpRec(ES:[DI]).HardDskExist,No;
  JE  @@SetHardDskCtrl;
  TEST StartUpRec(ES:[DI]).IntExistFlags,flgInt13h;
  JZ  @@NoSCSI;
  MOV AH,$18; { Teste le SCSI }
  MOV DL,$80;
  MOV CX,$FFFF;
  INT $13;
  CMP AX,$4321;
  JE  @@SCSI;
   { Teste le MFM }
@@NoSCSI:
  TEST Jumper(DS:[SI]).FlgMethod,flgProtectedMode;
  JNZ @@SkipTest;                      { Logiquement le mode protÇgÇ veut }
  PUSH ES;                             { aussi dire que le processeur est }
   MOV AX,$FFFF;                       { secondÇ par un contrìleur  CMOS: }
   MOV ES,AX;                          { Non? }
   MOV AL,ES:[$E];
  POP ES;
  CMP AL,$FC;
  JA  @@MFM;
@@SkipTest:
  MOV AL,$19;
  OUT $70,AL;
  IN  AL,$71;
  CMP AL,0;
  JE  @@MFM; { Pas de disque dur, en CMOS, un stool! Disque dur MFM... }
  MOV AX,ctrlhdIDE;
  JMP @@SetHardDskCtrl;
@@SCSI:
  MOV AX,CX;
  JMP @@SetHardDskCtrl;
@@MFM:
  MOV AX,ctrlhdMFM;
@@SetHardDskCtrl:
  MOV StartUpRec(ES:[DI]).HardDskCtrl,AX;
   { DÇtection de spooler }
  TEST StartUpRec(ES:[DI]).IntExistFlags,flgInt1Ah;
  JZ  @@NoSpooler;
  TEST Jumper(DS:[SI]).FlgMethod,flgNoSpoolerDetect;
  JNZ @@NoSpooler;
  MOV AH,$AB;
  INT $1A;
  CMP AH,$BA;
  JE  @@DiskSpoolII;
  MOV AH,$A0;
  INT $1A;
  CMP AH,$B0;
  JNE @@NoSpooler;
@@DiskSpoolII:
  MOV AL,drvDiskSpoolII;
  JMP @@EndSpooler;
@@NoSpooler:
  LES DI,StartUp;
  CMP StartUpRec(ES:[DI]).Win,winNo;
  JNE @@SpoolerPrintManager;
  TEST StartUpRec(ES:[DI]).IntExistFlags,flgInt2Fh;
  JZ  @@ReallyNoSpooler;
  MOV AX,$0100;
  INT $2F;
  CMP AL,$FF;
  JE  @@DosPrint;
@@ReallyNoSpooler:
  MOV AL,drvNoSpooler;
  JMP @@EndSpooler;
@@DosPrint:
  MOV AL,drvPrintDos;
  JMP @@EndSpooler;
@@SpoolerPrintManager:
  MOV AL,drvPrintManager;
@@EndSpooler:
  LES DI,StartUp;
  MOV StartUpRec(ES:[DI]).Spooler,AL;
   { *********** Ajustement des fonctions les plus adÇquoites *********** }
   { AltPress/CtrlPress/LeftShiftPress/RightShiftPress/ShiftPress }
  TEST Jumper(DS:[SI]).FlgMethod,flgProtectedMode
  JNZ @@BiosAltPress;
  TEST Jumper(DS:[SI]).FlgMethod,flgEquipPerBios;
  JNZ @@BiosAltPress;
  CMP StartUpRec(ES:[DI]).CPU,cpu80286;
  JB  @@AltPress4Mem;
  MOV AX,suAltPress4Memi286+(suCtrlPress4Memi286 shl 8);
  MOV BX,suLShiftPress4Memi286+(suRShiftPress4Memi286 shl 8);
  MOV CL,suShiftPress4Memi286;
  JMP @@EndAltPress;
@@AltPress4Mem:
  MOV AX,suAltPress4Mem+(suCtrlPress4Mem shl 8);
  MOV BX,suLShiftPress4Mem+(suRShiftPress4Mem shl 8);
  MOV CL,suShiftPress4Mem;
  JMP @@EndAltPress;
@@BiosAltPress:
  MOV AX,suAltPress4Bios+(suCtrlPress4Bios shl 8);
  MOV BX,suLShiftPress4Bios+(suLShiftPress4Bios shl 8);
  MOV CL,suShiftPress4Bios;
@@EndAltPress:
  MOV StartUpRec(ES:[DI]).indAltPress,AL;
  MOV StartUpRec(ES:[DI]).indCtrlPress,AH;
  MOV StartUpRec(ES:[DI]).indLShiftPress,BL;
  MOV StartUpRec(ES:[DI]).indRShiftPress,BH;
  MOV StartUpRec(ES:[DI]).indShiftPress,CL;
   { FillChar/MoveLeft }
  CMP StartUpRec(ES:[DI]).Up32Bits,Ya;
  JE  @@FillChar386;
  CMP StartUpRec(ES:[DI]).CPU,cpu80286;
  JE  @@FillChar86;
  CMP StartUpRec(ES:[DI]).CPU,cpu80186;
  JE  @@FillChar86;
  CMP StartUpRec(ES:[DI]).CPU,cpu8086;
  JE  @@FillChar86;
  CMP StartUpRec(ES:[DI]).CPU,cpuV30;
  JE  @@FillChar86;
  MOV AX,suFillChr4Def+(suMove4Def shl 8);
  JMP @@EndFillChar;
@@FillChar86:
  MOV AX,suFillChrPer86+(suMovePer86 shl 8);
  JMP @@EndFillChar;
@@FillChar386:
  MOV AX,suFillChrPer32Bits+(suMovePer32Bits shl 8);
  JMP @@EndFillChar;
@@EndFillChar:
  MOV StartUpRec(ES:[DI]).indFillChr,AL;
  MOV StartUpRec(ES:[DI]).indMove,AH;
   { GetIntVec/SetIntVec }
  TEST Jumper(DS:[SI]).FlgMethod,flgProtectedMode;
  JNZ @@DosGetIntVec;
  CMP StartUpRec(ES:[DI]).Up32Bits,Ya;
  JE  @@GetIntVec386;
  CMP StartUpRec(ES:[DI]).CPU,cpu80286;
  JE  @@GetIntVec86;
  MOV AX,suGetIntVec4Mem+(suSetIntVec4Mem shl 8);
  JMP @@EndGetIntVec;
@@GetIntVec86:
  MOV AX,suGetIntVec4Mem286+(suSetIntVec4Memi286 shl 8);
  JMP @@EndGetIntVec;
@@GetIntVec386:
  MOV AX,suGetIntVec4Mem386+(suSetIntVec4Memi386 shl 8);
  JMP @@EndGetIntVec;
@@DosGetIntVec:
  MOV AX,suGetIntVec4Dos+(suSetIntVec4Dos shl 8);
@@EndGetIntVec:
  MOV StartUpRec(ES:[DI]).indGetIntVec,AL;
  MOV StartUpRec(ES:[DI]).indSetIntVec,AH;
   { GetRawTimer }
  TEST Jumper(DS:[SI]).FlgMethod,flgProtectedMode;
  JNZ @@GetRawTimerInt1Ah;
  CMP StartUpRec(ES:[DI]).CPU,cpu80286;
  JB  @@GetRawTimer4Mem;
  MOV AX,suGetRawTimer4Memi286+(suGetRawTimerB4Memi286 shl 8);
  JMP @@EndGetRawTimer;
@@GetRawTimer4Mem:
  MOV AX,suGetRawTimer4Mem+(suGetRawTimerB4Mem shl 8);
  JMP @@EndGetRawTimer;
@@GetRawTimerInt1Ah:
  MOV AX,suGetRawTimer4Int1Ah+(suGetRawTimerB4Int1Ah shl 8);
@@EndGetRawTimer:
  MOV StartUpRec(ES:[DI]).indGetRawTimer.Word,AX; { GetRawTimer/GetRawTimerB}
   { JoystickPosition }
  TEST Jumper(DS:[SI]).FlgMethod,flgJoyFunc;
  JZ  @@NoJoyFunc;
  CMP StartUpRec(ES:[DI]).JoyExist,Ya;
  JE  @@JoyPosExist;
@@NoJoyFunc:
  MOV AL,suJoyPosRet;
  JMP @@EndJoyPos;
@@JoyBios:
  MOV AL,suJoyPos4Bios;
  JMP @@EndJoyPos;
@@JoyPosExist:
  CMP StartUpRec(ES:[DI]).JoyPort,0;
  JE  @@JoyBios;
  MOV AL,suJoyPos4IO;
@@EndJoyPos:
  MOV StartUpRec(ES:[DI]).indJoyPos,AL;
   { KeyPressed }
  TEST Jumper(DS:[SI]).FlgMethod,flgProtectedMode;
  JNZ @@KeyPressBios;
  CMP StartUpRec(ES:[DI]).Win,0;
  JNE @@KeyPressDos;
  MOV AL,suKeypress4Mem;
  JMP @@EndKeyPress;
@@KeyPressDos:
  MOV AL,suKeypress4Dos;
  JMP @@EndKeyPress;
@@KeyPressBios:
  MOV AL,suKeyPress4Bios;
@@EndKeyPress:
  MOV StartUpRec(ES:[DI]).indKeyPress,AL;
   { PushKey }
  TEST Jumper(DS:[SI]).FlgMethod,flgProtectedMode;
  JNZ @@PushKeyBios;
  MOV AL,suPushKey4Mem;
  JMP @@EndPushKey;
@@PushKeyBios:
  MOV AL,suPushKey4Bios16h;
@@EndPushKey:
  MOV StartUpRec(ES:[DI]).indPushKey,AL;
   { ReadKey }
  TEST Jumper(DS:[SI]).FlgMethod,flgProtectedMode;
  JNZ @@ReadKeyBios;
  MOV AL,suReadKey4Mem;
  JMP @@EndReadKey;
@@ReadKeyBios:
  MOV AL,suReadKey4Bios00h;
  CMP StartUpRec(ES:[DI]).BiosKbdEnh,No;
  JE  @@EndReadKey;
  MOV AL,suReadKey4Bios10h;
@@EndReadKey:
  MOV StartUpRec(ES:[DI]).indReadKey,AL;
 POP DS;
END;

Procedure EndStartUpIsabel;Begin End;
Procedure StartUpEconomic(Var Jump:Jumper;Var StartUp:StartUpRec);Begin End;
Procedure EndStartUpEconomic;Begin End;
Procedure StartUpGolden(Var Jump:Jumper;Var StartUp:StartUpRec);Begin End;
Procedure EndStartUpGolden;Begin End;
Procedure StartUpGame(Var Jump:Jumper;Var StartUp:StartUpRec);Begin End;
Procedure EndStartUpGame;Begin End;
Procedure StartUpNetwork(Var Jump:Jumper;Var StartUp:StartUpRec);Begin End;
Procedure EndStartUpNetwork;Begin End;
Procedure StartUpWindows(Var Jump:Jumper;Var StartUp:StartUpRec);Begin End;
Procedure EndStartUpWindows;Begin End;
Procedure StartUpOpt(Var Jump:Jumper;Var StartUp:StartUpRec);Begin End;
Procedure EndStartUpOpt;Begin End;
Procedure SetupMod;Begin End;
Procedure EndSetupMod;Begin End;
Procedure SetupOpt;Begin End;
Procedure EndSetupOpt;Begin End;

Function AltPress4Mem:Bool;Assembler;ASM
 XOR AX,AX
 MOV ES,AX
 CLI
 MOV AL,ES:[$417]
 STI
 AND AL,8
 JZ @@End
 MOV AL,Ya
@@End:
END;

Procedure EndAltPress4Mem;Begin End;

Function AltPress4Memi286:Bool;Assembler;ASM
 DB $6A,$40 { PUSH $0040; }
 DB ciPopES { POP ES; }
 CLI
 MOV AL,ES:[$17]
 STI
 AND AL,8
 JZ @@End
 MOV AL,Ya
@@End:
END;

Procedure EndAltPress4Memi286;Begin End;

Function AltPress4MemNoCLI:Bool;Assembler;ASM
 XOR AX,AX
 MOV ES,AX
 MOV AL,ES:[$417]
 AND AL,8
 JZ @@End
 MOV AL,Ya
@@End:
END;

Procedure EndAltPress4MemNoCLI;Begin End;

Function AltPress4MemNoCLIi286:Bool;Assembler;ASM
 DB $6A,$40 { PUSH $0040; }
 DB ciPopES { POP ES; }
 MOV AL,ES:[$17]
 AND AL,8
 JZ @@End
 MOV AL,Ya
@@End:
END;

Procedure EndAltPress4MemNoCLIi286;Begin End;

Function AltPress4Bios:Bool;Assembler;ASM
 MOV AH,$02
 INT $16
 AND AL,8
 JZ @@End
 MOV AL,Ya
@@End:
END;

Procedure EndAltPress4Bios;Begin End;
Function AltPressOpt:Bool;Begin End;{ Futur option }
Procedure EndAltPressOpt;Begin End;
Function AltPressRtn:Bool;Begin End;
Procedure EndAltPressRtn;Begin End;

Function CtrlPress4Mem:Bool;Assembler;ASM
 XOR AX,AX
 MOV ES,AX
 CLI
 MOV AL,ES:[$417]
 STI
 AND AL,4
 JZ @@End
 MOV AL,Ya
@@End:
END;

Procedure EndCtrlPress4Mem;Begin End;

Function CtrlPress4Memi286:Bool;Assembler;ASM
 DB $6A,$40 { PUSH $0040; }
 DB ciPopES { POP ES; }
 CLI
 MOV AL,ES:[$17]
 STI
 AND AL,4
 JZ @@End
 MOV AL,Ya
@@End:
END;

Procedure EndCtrlPress4Memi286;Begin End;

Function CtrlPress4MemNoCLI:Bool;Assembler;ASM
 XOR AX,AX
 MOV ES,AX
 MOV AL,ES:[$417]
 AND AL,4
 JZ @@End
 MOV AL,Ya
@@End:
END;

Procedure EndCtrlPress4MemNoCLI;Begin End;

Function CtrlPress4MemNoCLIi286:Bool;Assembler;ASM
 DB $6A,$40 { PUSH $0040; }
 DB ciPopES { POP ES; }
 MOV AL,ES:[$17]
 AND AL,4
 JZ @@End
 MOV AL,Ya
@@End:
END;

Procedure EndCtrlPress4MemNoCLIi286;Begin End;

Function CtrlPress4Bios:Bool;Assembler;ASM
 MOV AH,$02
 INT $16
 AND AL,4
 JZ @@End
 MOV AL,Ya
@@End:
END;

Procedure EndCtrlPress4Bios;Begin End;
Function CtrlPressOpt:Bool;Begin End;{ Futur option }
Procedure EndCtrlPressOpt;Begin End;
Function CtrlPressRtn:Bool;Begin End;
Procedure EndCtrlPressRtn;Begin End;

Procedure FillChar88(Var X;Len:Word;Value:Byte);Assembler;ASM
 CLD
 LES DI,X
 MOV CX,Len
 MOV AL,Value
 REP STOSB
END;

Procedure EndFillChar88;Begin End;

Procedure FillChar86(Var X;Len:Word;Value:Byte);Assembler;ASM
 CLD
 LES DI,X
 MOV CX,Len
 MOV AL,Value
 MOV AH,AL
 SHR CX,1
 REP STOSW
 ADC CX,CX
 REP STOSB
END;

Procedure EndFillChar86;Begin End;

Procedure FillChar386(Var X;Len:Word;Value:Byte);Assembler;ASM
 CLD
 LES DI,X
 MOV CX,Len
 MOV AL,Value
 MOV AH,AL
 DB  ciPushAX,ciPushAX { EAX := AX:AX }
 DW  ciPopEAX
 MOV BX,CX
 AND BX,3
 DB  $C1,$E9,$02          { SHR CX,2 }
 DB  ciREP; DW ciSTOSD    { REP STOSD }
 MOV CX,BX
 REP STOSB
END;

Procedure EndFillChar386;Begin End;
Procedure FillChrOpt(Var X;Len:Word;Value:Byte);Begin End;
Procedure EndFillChrOpt;Begin End;

Procedure GetIntVec4Mem(IntNo:Byte;Var Vector:Pointer);Assembler;ASM
 XOR BX,BX
 MOV ES,BX
 MOV BL,IntNo
 SHL BX,1
 SHL BX,1
 CLI
 MOV AX,ES:[BX]   { Vector.Ofs := MemW[0:IntNo shl 2] }
 MOV DX,ES:[BX+2] { Vector.Seg := MemW[0:(IntNo shl 2)+2] }
 STI
 LES DI,Vector
 MOV ES:[DI],AX
 MOV ES:[DI+2],DX
END;

Procedure EndGetIntVec4Mem;Begin End;

Procedure GetIntVec4Memi286(IntNo:Byte;Var Vector:Pointer);Assembler;ASM
 XOR BX,BX
 MOV ES,BX
 MOV BL,IntNo
 DB $C1,$E3,$02   { SHL BX,2 }
 CLI
 MOV AX,ES:[BX]   { Vector.Ofs := MemW[0:IntNo shl 2] }
 MOV DX,ES:[BX+2] { Vector.Seg := MemW[0:(IntNo shl 2)+2] }
 STI
 LES DI,Vector
 MOV ES:[DI],AX
 MOV ES:[DI+2],DX
END;

Procedure EndGetIntVec4Memi286;Begin End;

Procedure GetIntVec4Memi386(IntNo:Byte;Var Vector:Pointer);Assembler;ASM
 XOR BX,BX
 MOV ES,BX
 MOV BL,IntNo
 DB $C1,$E3,$02 { SHL BX,2 }
 CLI
 DB $26,$66,$8B,$07 { MOV EAX,ES:[BX] }
 STI
 LES DI,Vector
 DB $26,$66,$89,$05 { MOV ES:[DI],EAX }
END;

Procedure EndGetIntVec4Memi386;Begin End;

Procedure GetIntVec4Dos(IntNo:Byte;Var Vector:Pointer);Assembler;ASM
 MOV AL,IntNo
 MOV AH,$35
 INT $21
 MOV AX,ES
 LES DI,Vector
 CLD
 XCHG AX,BX
 STOSW
 XCHG AX,BX
 STOSW
END;

Procedure EndGetIntVec4Dos;Begin End;
Procedure GetIntVecOpt(IntNo:Byte;Var Vector:Pointer);Begin End;
Procedure EndGetIntVecOpt;Begin End;

Function GetRawTimer4Mem:Long;Assembler;ASM
 {$IFOPT G+}
  PUSH 0
  POP ES
 {$ELSE}
  XOR AX,AX
  MOV ES,AX
 {$ENDIF}
 { Pour une instruction, la logique veut que je n'est pas besoin }
 { de mettre Ö 0 les IRQ pendant la lecture de l'heure,  mais si }
 { j'utiliserais 2 instructions alors cela aurait eu la forme: }
 {  CLI }
 {  MOV AX,ES:[46Ch] (5 octets pour un 88 et 4 octets pour un 286) }
 {  MOV DX,ES:[46Eh] (5 octets pour un 88 et 4 octets pour un 286) }
 {  STI }
 LES AX,ES:[$46C] { (5 octets) }
 MOV DX,ES        { (2 octets) }
END;

Procedure EndGetRawTimer4Mem;Begin End;

Function GetRawTimer4Memi286:Long;Assembler;ASM
 DB $6A,$40 { PUSH $0040; }
 DB ciPopES { POP ES; }
 LES AX,ES:[$6C]
 MOV DX,ES
END;

Procedure EndGetRawTimer4Memi286;Begin End;

Function GetRawTimer4Cmos:Long;Assembler;ASM
 XOR AX,AX
 XOR DX,DX
 OUT $70,AL
 IN  AL,$71
 MOV BL,AL
 MOV BH,AL
 AND BL,$F
 MOV CL,4
 SHR BH,CL
 MOV AL,10
 MUL BH
 ADD BL,AL
 MOV AL,18
 MUL BL
 MOV SI,AX
 MOV AL,2
 OUT $70,AL
 IN  AL,$71
 MOV BL,AL
 MOV BH,AL
 AND BL,$F
 MOV CL,4
 SHR BH,CL
 MOV AL,10
 MUL BH
 ADD BL,AL
 MOV AL,182
 MUL BL
 MOV BX,6
 MUL BX
 ADD AX,SI
 ADC DX,0
 MOV SI,AX
 MOV DI,DX
 MOV AL,4
 OUT $70,AL
 IN  AL,$71
 MOV BL,AL
 MOV BH,AL
 AND BL,$F
 MOV CL,4
 SHR BH,CL
 MOV AL,10
 MUL BH
 ADD BL,AL
 MOV AL,182
 MUL BL
 MOV BX,60*6
 MUL BX
 ADD AX,SI
 ADC DX,DI
END;

Procedure EndGetRawTimer4Cmos;Begin End;

Function GetRawTimer4Int1Ah:Long;Assembler;ASM
 XOR AX,AX
 INT $1A
 MOV AX,DX
 MOV DX,CX
END;

Procedure EndGetRawTimer4Int1Ah;Begin End;
Function GetRawTimerOpt:Long;Begin End;
Procedure EndGetRawTimerOpt;Begin End;

Function GetRawTimerB4Mem:Byte;Assembler;ASM
 XOR AX,AX
 MOV ES,AX
 CLI
 MOV AL,ES:[$046C]
 STI
END;

Procedure EndGetRawTimerB4Mem;Begin End;

Function GetRawTimerB4Mem286:Byte;Assembler;ASM
 DB $6A,$40 { PUSH $0040; }
 DB ciPopES { POP ES; }
  { CLI/STI inutile pour un instruction parceque briser une opÇration
  { en cours reläve d'un monde Utopique n'Çtant pas präs de ce concrÇtiser. }
 MOV AL,ES:[$6C]
END;

Procedure EndGetRawTimerB4Mem286;Begin End;

Function GetRawTimerB4Int1Ah:Byte;Assembler;ASM
 XOR AX,AX
 INT $1A
 MOV AL,DL
END;

Procedure EndGetRawTimerB4Int1Ah;Begin End;
Function GetRawTimerB4Dos:Byte;Begin End;
Procedure EndGetRawTimerB4Dos;Begin End;
Function GetRawTimerBOpt:Byte;Begin End;
Procedure EndGetRawTimerBOpt;Begin End;

Function JoyPos4IO(Axe:Byte):Word;Assembler;ASM
 MOV CL,Axe
 MOV BX,1
 SHL BX,CL
 MOV CX,$FFFF
 XOR AX,AX
 XOR SI,SI
 MOV DX,$0201
 CLI
 OUT DX,AL
@@Next:
 IN   AL,DX
 TEST AL,BL
 JE   @@Done
 INC  SI
 LOOP @@Next
@@Done:
 STI
 MOV AX,SI
@@End:
END;

Procedure EndJoyPos4IO;Begin End;

Function JoyPos4Bios(Axe:Byte):Word;Assembler;ASM
 MOV AH,$84
 MOV DX,$1
 INT $15
 CMP Axe,0
 JE  @@End
 MOV BX,AX
 CMP Axe,1
 MOV CX,AX
 CMP Axe,2
 JE  @@End
 MOV DX,AX
@@End:
END;

Procedure EndJoyPos4Bios;Begin End;
Function JoyPosOpt(Axe:Byte):Word;Begin End;
Procedure EndJoyPosOpt;Begin End;
Function JoyPosRtn(Axe:Byte):Word;Begin End;
Procedure EndJoyPosRtn;Begin End;
Function Keypress4IO:Bool;Begin End;
Procedure EndKeypress4IO;Begin End;

Function KeyPress4Mem:Bool;Assembler;ASM
 XOR AX,AX
 MOV ES,AX
 CLI
 LES DX,ES:[$41A]
 STI
 MOV BX,ES
 CMP BX,DX
 JE  @@End
 MOV AL,Ya
@@End:
END;

Procedure EndKeyPress4Mem;Begin End;

Function KeyPress4MemNoCLI:Bool;Assembler;ASM
 XOR AX,AX
 MOV ES,AX
 LES DX,ES:[$41A]
 MOV BX,ES
 CMP BX,DX
 JE  @@End
 MOV AL,Ya
@@End:
END;

Procedure EndKeyPress4MemNoCLI;Begin End;

Function KeyPress4Bios:Bool;Assembler;ASM
 MOV AX,1
 INT $16
 MOV AL,No
 JZ  @@End
 MOV AL,Ya
@@End:
END;

Procedure EndKeyPress4Bios;Begin End;

Function KeyPress4Dos:Bool;Assembler;ASM
 MOV AH,$0B
 INT $21
 AND AL,1
END;

Procedure EndKeyPress4Dos;Begin End;
Function KeyPressOpt:Bool;Begin End;
Procedure EndKeyPressOpt;Begin End;
Function KeyPressRtn:Bool;Begin End;
Procedure EndKeyPressRtn;Begin End;

Function LShiftPress4Mem:Bool;Assembler;ASM
 XOR AX,AX
 MOV ES,AX
 CLI
 MOV AL,ES:[$417]
 STI
 AND AL,2
 JZ @@End
 MOV AL,Ya
@@End:
END;

Procedure EndLShiftPress4Mem;Begin End;

Function LShiftPress4Memi286:Bool;Assembler;ASM
 DB $6A,$40 { PUSH $0040; }
 DB ciPopES { POP ES; }
 CLI
 MOV AL,ES:[$17]
 STI
 AND AL,2
 JZ @@End
 MOV AL,Ya
@@End:
END;

Procedure EndLShiftPress4Memi286;Begin End;

Function LShiftPress4MemNoCLI:Bool;Assembler;ASM
 XOR AX,AX
 MOV ES,AX
 MOV AL,ES:[$417]
 AND AL,2
 JZ @@End
 MOV AL,Ya
@@End:
END;

Procedure EndLShiftPress4MemNoCLI;Begin End;

Function LShiftPress4MemNoCLIi286:Bool;Assembler;ASM
 DB $6A,$40 { PUSH $0040; }
 DB ciPopES { POP ES; }
 MOV AL,ES:[$17]
 AND AL,2
 JZ @@End
 MOV AL,Ya
@@End:
END;

Procedure EndLShiftPress4MemNoCLIi286;Begin End;

Function LShiftPress4Bios:Bool;Assembler;ASM
 MOV AH,$02
 INT $16
 AND AL,2
 JZ @@End
 MOV AL,Ya
@@End:
END;

Procedure EndLShiftPress4Bios;Begin End;
Function LShiftPressOpt:Bool;Begin End;{ Futur option }
Procedure EndLShiftPressOpt;Begin End;
Function LShiftPressRtn:Bool;Begin End;
Procedure EndLShiftPressRtn;Begin End;

Procedure Move88(Var Source,Dest;Count:Word);Assembler;ASM
 CLD
 PUSH DS
  LDS SI,Source
  LES DI,Dest
  MOV CX,Count
  REP MOVSB
 POP DS
END;

Procedure EndMove88;Begin End;

Procedure Move86(Var Source,Dest;Count:Word);Assembler;ASM
 CLD
 PUSH DS
  LDS SI,Source
  LES DI,Dest
  MOV CX,Count
  SHR CX,1
  REP MOVSW
  ADC CX,CX
  REP MOVSB
 POP DS
END;

Procedure EndMove86;Begin End;

Procedure Move386(Var Source,Dest;Count:Word);Assembler;ASM
 CLD
 PUSH DS
 LDS SI,Source
 LES DI,Dest
 MOV CX,Count
  MOV BX,CX
  AND BX,3
  DB $C1,$E9,$02 { SHR CX,2 }
  DB  ciREP; DW ciMOVSD
  MOV CX,BX
  REP MOVSB
 POP  DS
END;

Procedure EndMove386;Begin End;
Procedure MoveOpt(Var Source,Dest;Count:Word);Begin End;
Procedure EndMoveOpt;Begin End;

Procedure PushKey4Mem(K:Word);Assembler;ASM
 MOV AX,$0040
 MOV ES,AX
 CLI
 MOV BX,ES:[$1C]
 MOV AX,K
 MOV ES:[BX],AX
 INC BX
 INC BX
 MOV ES:[$1C],BX
 MOV AX,ES:[$82]
 CMP AX,BX
 JNE @@End
 MOV AX,ES:[$80]
 MOV ES:[$1C],AX
@@End:
 STI
END;

Procedure EndPushKey4Mem;Begin End;
Procedure PushKey4Bios15h(K:Word);Begin End;
Procedure EndPushKey4Bios15h;Begin End;

Procedure PushKey4Bios16h(K:Word);Assembler;ASM
 MOV AX,$0005
 MOV CX,K
 INT $16
END;

Procedure EndPushKey4Bios16h;Begin End;
Procedure PushKeyOpt(K:Word);Begin End;
Procedure EndPushKeyOpt;Begin End;
Procedure PushKeyRtn(K:Word);Begin End;
Procedure EndPushKeyRtn;Begin End;
Function ReadKey4IO:Word;Begin End;
Procedure EndReadKey4IO;Begin End;

Function ReadKey4Mem:Word;Assembler;ASM
 MOV AX,$0040
 MOV ES,AX
 CLI
 MOV BX,ES:[$1A]
 MOV AX,ES:[BX]
 CMP AL,$E0
 JE  @@NotOk
 CMP AL,$D0
 JNE @@Ok
@@NotOk:
 CMP AH,0
 JE  @@Ok
 MOV AL,0
@@Ok:
 INC BX
 INC BX
 MOV ES:[$1A],BX
 MOV CX,ES:[$82]
 CMP CX,BX
 JNE @@End
 MOV CX,ES:[$80]
 MOV ES:[$1A],CX
@@End:
 STI
END;

Procedure EndReadKey4Mem;Begin End;

Function ReadKey4Bios00h:Wd;Assembler;ASM
 XOR AX,AX
 INT $16
END;

Procedure EndReadKey4Bios00h;Begin End;

Function ReadKey4Bios10h:Wd;Assembler;ASM
 MOV AX,$1000
 INT $16
END;

Procedure EndReadKey4Bios10h;Begin End;
Function ReadKey4Dos:Wd;Begin End;
Procedure EndReadKey4Dos;Begin End;
Function ReadKeyOpt:Wd;Begin End;
Procedure EndReadKeyOpt;Begin End;
Function ReadKeyRtn:Wd;Assembler;ASM XOR AX,AX;END;

Function ReadKeyProtect:Wd;Assembler;ASM
 {$IFOPT G+}PUSH _0040;POP ES{$ELSE}MOV AX,$40;MOV ES,AX{$ENDIF}
 CLI
 MOV BX,ES:[$1A]
  { Protection Paranoãaque...}
 MOV AX,ES:[$1C]
 CMP AX,ES:[$82]
 JA  @@Error
 CMP AX,ES:[$80]
 JB  @@Error
 CMP BX,ES:[$82]
 JB  @@OkTst
@@Error:
 XOR AX,AX;MOV ES,AX;CLI;MOV AX,ES:[$480];MOV ES:[$41C],AX;MOV ES:[$41A],AX
 { Si le clavier "dÇconne", Çlimine toute les saloppries ayant}
 { pus àtre dit par se psychopathe! }
 JMP @@End{ Le fait sauter Ö un endroit ou le terrorisme Contrìleurien }
	  { n'a plus d'importance... }
@@OkTst:
 CMP BX,ES:[$80]
 JB  @@Error
  { Fin de protection paranoãaque!}
 MOV AX,ES:[BX]
 CMP AL,$E0
 JE  @@NotOk
 CMP AL,$D0
 JNE @@Ok
@@NotOk:
 CMP AH,0
 JE  @@Ok
 MOV AL,0
@@Ok:
 MOV DX,AX
 INC BX
 INC BX
 MOV ES:[$1A],BX
 MOV AX,ES:[$82]
 CMP AX,BX
 JNE @@End
 MOV AX,ES:[$80]
 MOV ES:[$1A],AX
 STI
 MOV AX,DX
@@End:
END;

Procedure EndReadKeyRtn;Begin End;

Function RShiftPress4Mem:Bool;Assembler;ASM
 XOR AX,AX
 MOV ES,AX
 CLI
 MOV AL,ES:[$417]
 STI
 AND AL,1
END;

Procedure EndRShiftPress4Mem;Begin End;

Function RShiftPress4Memi286:Bool;Assembler;ASM
 DB $6A,$40 { PUSH $0040; }
 DB ciPopES { POP ES; }
 CLI
 MOV AL,ES:[$17]
 STI
 AND AL,1
END;

Procedure EndRShiftPress4Memi286;Begin End;

Function RShiftPress4MemNoCLI:Bool;Assembler;ASM
 XOR AX,AX
 MOV ES,AX
 MOV AL,ES:[$417]
 AND AL,1
END;

Procedure EndRShiftPress4MemNoCLI;Begin End;

Function RShiftPress4MemNoCLIi286:Bool;Assembler;ASM
 DB $6A,$40 { PUSH $0040; }
 DB ciPopES { POP ES; }
 MOV AL,ES:[$17]
 AND AL,1
END;

Procedure EndRShiftPress4MemNoCLIi286;Begin End;

Function RShiftPress4Bios:Bool;Assembler;ASM
 MOV AH,$02
 INT $16
 AND AL,1
END;

Procedure EndRShiftPress4Bios;Begin End;
Function RShiftPressOpt:Bool;Begin End;{ Futur option }
Procedure EndRShiftPressOpt;Begin End;
Function RShiftPressRtn:Bool;Begin End;
Procedure EndRShiftPressRtn;Begin End;

Procedure SetIntVec4Mem(IntNo:Byte;Vector:Pointer);Assembler;ASM
 XOR BX,BX
 MOV ES,BX
 MOV BL,IntNo
 SHL BX,1
 SHL BX,1
 MOV AX,Vector.Word[0]
 MOV DX,Vector.Word[2]
 CLI
 MOV ES:[BX],AX { Vector.Ofs := MemW[0:IntNo shl 2] }
 MOV ES:[BX+2],DX { Vector.Seg := MemW[0:(IntNo shl 2)+2] }
 STI
END;

Procedure EndSetIntVec4Mem;Begin End;

Procedure SetIntVec4Memi286(IntNo:Byte;Vector:Pointer);Assembler;ASM
 XOR BX,BX
 MOV ES,BX
 MOV BL,IntNo
 DB $C1,$E3,$02 { SHL BX,2 }
 MOV AX,Vector.Word[0]
 MOV DX,Vector.Word[2]
 CLI
 MOV ES:[BX],AX   { Vector.Ofs := MemW[0:IntNo shl 2] }
 MOV ES:[BX+2],DX { Vector.Seg := MemW[0:(IntNo shl 2)+2] }
 STI
END;

Procedure EndSetIntVec4Memi286;Begin End;

Procedure SetIntVec4Memi386(IntNo:Byte;Vector:Pointer);Assembler;ASM
 XOR BX,BX
 MOV ES,BX
 MOV BL,IntNo
 DB $C1,$E3,$02             { SHL BX,2 }
 DB $66; MOV AX,Vector.Word { MOV EAX,Vector }
 CLI
 DB $66; MOV ES:[BX],AX { MOV ES:[BX],EAX }
 STI
END;

Procedure EndSetIntVec4Memi386;Begin End;

Procedure SetIntVec4Dos(IntNo:Byte;Vector:Pointer);Assembler;ASM
 PUSH DS
  LDS DX,Vector
  MOV AL,IntNo
  MOV AH,$25
  INT $21
 POP DS
END;

Procedure EndSetIntVec4Dos;Begin End;
Procedure SetIntVecOpt(IntNo:Byte;Vector:Pointer);Begin End;
Procedure EndSetIntVecOpt;Begin End;

Function ShiftPress4Mem:Bool;Assembler;ASM
 XOR AX,AX
 MOV ES,AX
 CLI
 MOV AL,ES:[$417]
 STI
 AND AL,3
 JZ @@End
 MOV AL,Ya
@@End:
END;

Procedure EndShiftPress4Mem;Begin End;

Function ShiftPress4Memi286:Bool;Assembler;ASM
 DB $6A,$40 { PUSH $0040; }
 DB ciPopES { POP ES; }
 CLI
 MOV AL,ES:[$17]
 STI
 AND AL,3
 JZ @@End
 MOV AL,Ya
@@End:
END;

Procedure EndShiftPress4Memi286;Begin End;

Function ShiftPress4MemNoCLI:Bool;Assembler;ASM
 XOR AX,AX
 MOV ES,AX
 MOV AL,ES:[$417]
 AND AL,3
 JZ @@End
 MOV AL,Ya
@@End:
END;

Procedure EndShiftPress4MemNoCLI;Begin End;

Function ShiftPress4MemNoCLIi286:Bool;Assembler;ASM
 DB $6A,$40 { PUSH $0040; }
 DB ciPopES { POP ES; }
 MOV AL,ES:[$17]
 AND AL,3
 JZ @@End
 MOV AL,Ya
@@End:
END;

Procedure EndShiftPress4MemNoCLIi286;Begin End;

{Function ShiftPress4Bios:Bool}
{$DEFINE Bios}
{$I ..\LIBRARY\SHIFTPRE.INC}
{$UNDEF Bios}

Procedure EndShiftPress4Bios;Begin End;
Function ShiftPressOpt:Bool;Begin End;{ Futur option }
Procedure EndShiftPressOpt;Begin End;
Function ShiftPressRtn:Bool;Begin End;
Procedure EndShiftPressRtn;Begin End;

Const HexData:Array[0..15] of Char='0123456789ABCDEF';

Function HexWord2Str;Begin
 HexWord2Str:=HexData[X shr 12]+HexData[(X shr 8) and 15]+
	      HexData[(X shr 4)and 15]+HexData[X and 15];
End;

Procedure Close(Var Handle:Word);Assembler;ASM
 MOV AX,$3E00
 LES DI,Handle
 MOV BX,ES:[DI]
 INT $21
 JNC @@1
 LES DI,Handle
 MOV AX,$FFFF
 MOV ES:[DI],AX
 XOR AX,AX
@@1:
END;

Procedure SetFilePos(Handle:Word;P:Long);Assembler;ASM
 MOV BX,Handle
 CMP BX,$FFFF
 JE  @@1
 MOV AX,$4200
 MOV CX,P.Word[2]
 MOV DX,P.Word[0]
 INT $21
 JC  @@1
 XOR AX,AX
@@1:
END;

Procedure _SetRec(Handle,Size:Word;X:Pointer);Assembler;ASM
 PUSH DS
  LDS DX,X
  MOV BX,Handle
  CMP BX,$FFFF
  JE  @@Bug
  MOV CX,Size
  MOV AX,$4000
  INT $21
@@Bug:
 POP DS
 JC  @@1
 XOR AX,AX
@@1:
END;

Procedure SetRec(Handle:Wd;P:Long;Size:Wd;X:Pointer);Begin
 SetFilePos(Handle,P*Long(Size));
 _SetRec(Handle,Size,X);
End;

Function FileSize(Handle:Word):Long;Assembler;ASM
 MOV BX,Handle
 CMP BX,$FFFF
 JE  @@1
 MOV AX,$4202
 XOR CX,CX
 XOR DX,DX
 INT $21
 JC  @@1
 MOV BX,DX
 JMP @@2
@@1:
 MOV AX,$FFFF
 MOV BX,AX
@@2:
END;

Procedure PutFileTxt(Handle:Word;X:String);
Begin
 SetFilePos(Handle,FileSize(Handle));
 _SetRec(Handle,Byte(X[0]),@X[1]);
End;

Function New(Name:String):Wd;Var SegName,OfsName:Wd;Begin
 Name:=Name+#0;SegName:=Seg(Name[1]);OfsName:=Ofs(Name[1]);
 ASM
  PUSH DS
   XOR CX,CX
   MOV DX,OfsName
   MOV DS,SegName
   MOV AH,$3C
   INT $21
  POP DS
  JC  @@1
  JMP @@2
@@1:
  MOV AX,$FFFF
@@2:
  MOV @Result,AX
 END;
End;

Function IsHandleErr(Handle:Wd):Bool;Begin IsHandleErr:=Handle=$FFFF;End;

Const Jump:Jumper=(FlgMethod:
		   (flgProtectedMode*Word({$IFDEF DPMI}Ya{$ELSE}No{$ENDIF}))+
		   (flgEquipPerBios*Word(No))+
		   (flgJoyPerBios*Word(No))+
		   (flgNoExtBiosMemDetect*Word(No))+
		   (flgOnlyMem4ComputerName*Word(No))+
		   (flgNoCountryDetect*Word(No))+
		   (flgNoMouseDetect*Word(No))+
		   (flgNoSpoolerDetect*Word(No))+
		   (flgNoCmosDetect*Word(No)));

Var StartUp:StartUpRec; SD,HandleData,HandleMap:Word; PF,NmIndex:Long;

Procedure AddIndex;
Begin
 SetRec(HandleData,NmIndex+1,SizeOf(PF),@PF);
{ If(SD<>0)Then
  PutFileTxtLn(HandleMap,'Index '+Str(NmIndex)+' : '+StrPas(NameIndex[NmIndex+1])+
	       ', Taille '+Str(SD)+' octets');}
 Inc(NmIndex);
 SetFilePos(HandleData,PF)
End;

Procedure PutMethod;
Begin
 WriteLn;
 WriteLn('**** MÇthode sugÇrÇ ****');
 WriteLn;
 Write('Function AltPressed:Boolean; ƒ> ');
 Case StartUp.indAltPress of
  suAltPress4Mem: WriteLn('Accäs directe en mÇmoire, instruction 8088 (protection IRQ)');
  suAltPress4Memi286: WriteLn('Accäs directe en mÇmoire, instruction 80286 (protection IRQ)');
  suAltPress4MemNoCLI: WriteLn('Accäs directe en mÇmoire, instruction 8088 (sans protection IRQ)');
  suAltPress4MemNoCLIi286: WriteLn('Accäs directe en mÇmoire, instruction 80286 (sans protection IRQ)');
  suAltPress4Bios: WriteLn('Accäs Ö l''Interruption 16h');
  suAltPressOpt1: WriteLn('Option 1');
  suAltPressOpt2: WriteLn('Option 2');
  suAltPressOpt3: WriteLn('Option 3');
  suAltPressRet: WriteLn('Retourne sans tester!');
  Else WriteLn('Inconnu...');
 End;
 Write('Function CtrlPressed:Boolean; ƒ> ');
 Case StartUp.indCtrlPress of
  suCtrlPress4Mem: WriteLn('Accäs directe en mÇmoire, instruction 8088 (protection IRQ)');
  suCtrlPress4Memi286: WriteLn('Accäs directe en mÇmoire, instruction 80286 (protection IRQ)');
  suCtrlPress4MemNoCLI: WriteLn('Accäs directe en mÇmoire, instruction 8088 (sans protection IRQ)');
  suCtrlPress4MemNoCLIi286: WriteLn('Accäs directe en mÇmoire, instruction 80286 (sans protection IRQ)');
  suCtrlPress4Bios: WriteLn('Accäs Ö l''Interruption 16h');
  suCtrlPressOpt1: WriteLn('Option 1');
  suCtrlPressOpt2: WriteLn('Option 2');
  suCtrlPressOpt3: WriteLn('Option 3');
  suCtrlPressRet: WriteLn('Retourne sans tester!');
  Else WriteLn('Inconnu...');
 End;
 Write('Procedure FillCharacter(Var Buffer;Length:Word;Value:Byte); ƒ> ');
 Case StartUp.indFillChr of
  suFillChr4Def: WriteLn('MÇthode pour CPU avec bus 8-bits');
  suFillChrPer86: WriteLn('MÇthode pour CPU avec bus 16-bits');
  suFillChrPer32Bits: WriteLn('MÇthode pour CPU 386');
  suFillChrOpt1: WriteLn('Option 1');
  suFillChrOpt2: WriteLn('Option 2');
  suFillChrOpt3: WriteLn('Option 3');
  Else WriteLn('Inconnu...');
 End;
 Write('Procedure GetIntVec(IntNo:Byte;Var Vector:Pointer); ƒ> ');
 Case StartUp.indGetIntVec of
  suGetIntVec4Mem: WriteLn('MÇthode pour CPU avec bus 8-bits');
  suGetIntVec4Mem286: WriteLn('MÇthode pour CPU avec bus 16-bits');
  suGetIntVec4Mem386: WriteLn('MÇthode pour CPU 386');
  suGetIntVecOpt1: WriteLn('Option 1');
  suGetIntVecOpt2: WriteLn('Option 2');
  Else WriteLn('Inconnu...');
 End;
 Write('Function GetRawTimer:Long; ƒ> ');
 Case StartUp.indGetRawTimer of
  suGetRawTimer4Mem: WriteLn('Accäs directe en mÇmoire (instruction 8088)');
  suGetRawTimer4Memi286: WriteLn('Accäs directe en mÇmoire (instruction 80286)');
  suGetRawTimer4Int1Ah: WriteLn('Accäs Ö l''Interruption 1Ah');
  suGetRawTimer4Cmos: WriteLn('MÇthode d''accäs par le RTC CMOS');
  suGetRawTimerOpt1: WriteLn('Option 1');
  suGetRawTimerOpt2: WriteLn('Option 2');
  Else WriteLn('Inconnu...');
 End;
 Write('Function GetRawTimerByte:Byte; ƒ> ');
 Case StartUp.indGetRawTimerB of
  suGetRawTimerB4Mem: WriteLn('Accäs directe en mÇmoire (instruction 8088)');
  suGetRawTimerB4Memi286: WriteLn('Accäs directe en mÇmoire (instruction 80286)');
  suGetRawTimerB4Int1Ah: WriteLn('Accäs Ö l''Interruption 1Ah');
  suGetRawTimerB4Dos: WriteLn('Accäs par l''Interruption 21h (Dos)');
  suGetRawTimerBOpt1: WriteLn('Option 1');
  suGetRawTimerBOpt2: WriteLn('Option 2');
  suGetRawTimerBOpt3: WriteLn('Option 3');
  Else WriteLn('Inconnu...');
 End;
 Write('Function JoystickPosition(Axe:Byte):Word; ƒ> ');
 Case StartUp.indJoyPos of
  suJoyPos4IO: WriteLn('Accäs par le contrìleur en port 201h');
  suJoyPos4Bios: WriteLn('Accäs par l''Interruption 15h');
  suJoyPosOpt1: WriteLn('Option 1');
  suJoyPosOpt2: WriteLn('Option 2');
  suJoyPosOpt3: WriteLn('Option 3');
  suJoyPosOpt4: WriteLn('Option 4');
  suJoyPosRet: WriteLn('Retour sans teste!');
  Else WriteLn('Inconnu...');
 End;
 Write('Function KeyPressed:Boolean; ƒ> ');
 Case StartUp.indKeypress of
  suKeyPress4IO: WriteLn('Accäs par le contrìleur en port 60h');
  suKeyPress4Mem: WriteLn('Accäs directe dans la zone Bios 0040h:x');
  suKeyPress4MemNoCLI: WriteLn('Accäs directe dans le Bios 0040h:x (sans protection IRQ)');
  suKeyPress4Bios: WriteLn('Accäs par l''Interruption 16h, Fonction 01h');
  suKeyPress4Dos: WriteLn('Accäs par l''Interruption 21h, Fonction ??h');
  suKeyPressOpt1: WriteLn('Option 1');
  suKeyPressOpt2: WriteLn('Option 2');
  suKeyPressOpt3: WriteLn('Option 3');
  suKeyPressRet: WriteLn('Retour sans teste!');
  Else WriteLn('Inconnu...');
 End;
 Write('Function LeftShiftPressed:Boolean; ƒ> ');
 Case StartUp.indLShiftPress of
  suLShiftPress4Mem: WriteLn('Accäs directe en mÇmoire, instruction 8088 (protection IRQ)');
  suLShiftPress4Memi286: WriteLn('Accäs directe en mÇmoire, instruction 80286 (protection IRQ)');
  suLShiftPress4MemNoCLI: WriteLn('Accäs directe en mÇmoire, instruction 8088 (sans protection IRQ)');
  suLShiftPress4MemNoCLIi286: WriteLn('Accäs directe en mÇmoire, instruction 80286 (sans protection IRQ)');
  suLShiftPress4Bios: WriteLn('Accäs Ö l''Interruption 16h');
  suLShiftPressOpt1: WriteLn('Option 1');
  suLShiftPressOpt2: WriteLn('Option 2');
  suLShiftPressOpt3: WriteLn('Option 3');
  suLShiftPressRet: WriteLn('Retourne sans tester!');
  Else WriteLn('Inconnu...');
 End;
 Write('Procedure MoveLeft(Var Source,Target;Length:Word); ƒ> ');
 Case StartUp.indMove of
  suMove4Def: WriteLn('MÇthode pour CPU avec bus 8-bits');
  suMovePer86: WriteLn('MÇthode pour CPU avec bus 16-bits');
  suMovePer32Bits: WriteLn('MÇthode pour CPU 386');
  suMoveOpt1: WriteLn('Option 1');
  suMoveOpt2: WriteLn('Option 2');
  suMoveOpt3: WriteLn('Option 3');
  Else WriteLn('Inconnu...');
 End;
 Write('Procedure PushKey(Key:Word); ƒ> ');
 Case StartUp.indPushKey of
  suPushKey4Mem: WriteLn('MÇthode par accäs directe au tampon mÇmoire');
  suPushKey4Bios15h: WriteLn('Accäs par l''Interruption 15h, Fonction 4Fh');
  suPushKey4Bios16h: WriteLn('Accäs par l''Interruption 16h, Fonction 05h');
  suPushKeyOpt1: WriteLn('Option 1');
  suPushKeyOpt2: WriteLn('Option 2');
  suPushKeyOpt3: WriteLn('Option 3');
  suPushKeyRet: WriteLn('Retour sans opÇration!');
  Else WriteLn('Inconnu...');
 End;
 Write('Function ReadKey:Word; ƒ> ');
 Case StartUp.indReadKey of
  suReadKey4IO: WriteLn('MÇthode d''accäs par le port 0060h');
  suReadKey4Mem: WriteLn('MÇthode d''accäs par le tampon mÇmoire');
  suReadKey4Bios00h: WriteLn('MÇthode par l''Interruption 16h, Fonction 00h');
  suReadKey4Bios10h: WriteLn('MÇthode par l''Interruption 16h, Fonction 10h');
  suReadKey4Dos: WriteLn('MÇthode par l''Interruption 21h (Dos)');
  suReadKeyOpt1: WriteLn('Option 1');
  suReadKeyOpt2: WriteLn('Option 2');
  suReadKeyProtect: WriteLn('Option 3');
  suReadKeyRet: WriteLn('Retour sans testes!');
  Else WriteLn('Inconnu...');
 End;
 Write('Function RightShiftPressed:Boolean; ƒ> ');
 Case StartUp.indRShiftPress of
  suRShiftPress4Mem: WriteLn('Accäs directe en mÇmoire, instruction 8088 (protection IRQ)');
  suRShiftPress4Memi286: WriteLn('Accäs directe en mÇmoire, instruction 80286 (protection IRQ)');
  suRShiftPress4MemNoCLI: WriteLn('Accäs directe en mÇmoire, instruction 8088 (sans protection IRQ)');
  suRShiftPress4MemNoCLIi286: WriteLn('Accäs directe en mÇmoire, instruction 80286 (sans protection IRQ)');
  suRShiftPress4Bios: WriteLn('Accäs Ö l''Interruption 16h');
  suRShiftPressOpt1: WriteLn('Option 1');
  suRShiftPressOpt2: WriteLn('Option 2');
  suRShiftPressOpt3: WriteLn('Option 3');
  suRShiftPressRet: WriteLn('Retourne sans tester!');
  Else WriteLn('Inconnu...');
 End;
 Write('Procedure SetIntVec(IntNo:Byte;Vector:Pointer); ƒ> ');
 Case StartUp.indSetIntVec of
  suSetIntVec4Mem: WriteLn('MÇthode pour CPU avec bus 8-bits');
  suSetIntVec4Memi286: WriteLn('MÇthode pour CPU avec bus 16-bits');
  suSetIntVec4Memi386: WriteLn('MÇthode pour CPU 386');
  suSetIntVecOpt1: WriteLn('Option 1');
  suSetIntVecOpt2: WriteLn('Option 2');
  Else WriteLn('Inconnu...');
 End;
 Write('Function ShiftPressed:Boolean; ƒ> ');
 Case StartUp.indShiftPress of
  suShiftPress4Mem: WriteLn('Accäs directe en mÇmoire, instruction 8088 (protection IRQ)');
  suShiftPress4Memi286: WriteLn('Accäs directe en mÇmoire, instruction 80286 (protection IRQ)');
  suShiftPress4MemNoCLI: WriteLn('Accäs directe en mÇmoire, instruction 8088 (sans protection IRQ)');
  suShiftPress4MemNoCLIi286: WriteLn('Accäs directe en mÇmoire, instruction 80286 (sans protection IRQ)');
  suShiftPress4Bios: WriteLn('Accäs Ö l''Interruption 16h');
  suShiftPressOpt1: WriteLn('Option 1');
  suShiftPressOpt2: WriteLn('Option 2');
  suShiftPressOpt3: WriteLn('Option 3');
  suShiftPressRet: WriteLn('Retourne sans tester!');
  Else WriteLn('Inconnu...');
 End;
End;

BEGIN
 ASM
  MOV AX,$0022; { Tseng ET3000/Tseng ET4000 }
  INT $10;
 END;
 WriteLn('StartUp Maker  Version 1.0.16  Tous droits rÇservÇ par les Chevaliers de Malte');
 WriteLn;
 StartUpIsabel(Jump,StartUp);
 Write('CPU: ');
 Case StartUp.CPU of
  cpui486: Write('i486');
  cpui386: Write('i386');
 cpu80286: Write('80286');
 cpu80186: Write('80186');
 cpu80188: Write('80188');
   cpuV30: Write('V30');
   cpuV20: Write('V20');
  cpu8086: Write('8086');
  cpu8088: Write('8088');
 End;
 Write(', registres 32 bits: ',StartUp.Up32Bits,', Bus ');
 Case StartUp.Bus of
  busISA8: WriteLn('ISA 8-bits');
  busISA16: WriteLn('ISA 16-bits');
  busEISA: WriteLn('EISA');
  busMCA: WriteLn('MCA');
  Else WriteLn('Inconnue');
 End;
 Write('Modäle d''ordinateur: ');
 Case StartUp.ComputerName of
  cnAST: WriteLn('AST');
  cnAT: WriteLn('Clone AT');
  cnCompaq286: WriteLn('Compaq 286 ou clone');
  cnCompaq386: WriteLn('Compaq 386 ou clone');
  cnCompaqPC: WriteLn('Compaq PC/Compaq Deskpro');
  cnCompaqProLinea: WriteLn('Compaq Pro Linea');
  cnCompaqXT: WriteLn('Compaq XT/Compaq Plus');
  cnContermMax: WriteLn('ContermMax');
  cnDell200: WriteLn('Dell 200');
  cnDell210: WriteLn('Dell 210');
  cnDell220: WriteLn('Dell 220');
  cnDell220E: WriteLn('Dell 220E');
  cnDell300: WriteLn('Dell 300');
  cnDell310: WriteLn('Dell 310');
  cnDell310A: WriteLn('Dell 310A');
  cnDell316: WriteLn('Dell 316');
  cnDell316LT: WriteLn('Dell 316LT');
  cnDell316SX: WriteLn('Dell 316SX');
  cnDell320LX: WriteLn('Dell 320LX');
  cnDell325: WriteLn('Dell 325');
  cnDell425E: WriteLn('Dell 425E');
  cnEpson1: WriteLn('Epson');
  cnEpson2: WriteLn('Epson');
  cnEpson3: WriteLn('Epson');
  cnHewlettPackard110: WriteLn('Hewlett-Packard 110');
  cnIBM7552Gearbox: WriteLn('IBM 7552 Gearbox');
  cnIBM7561_2: WriteLn('IBM 7561/2');
  cnIBMPC7568: WriteLn('IBM PC 7568');
  cnIBMPCradio9075: WriteLn('IBM PCradio 9075');
  cnIBMProcessorComplex: WriteLn('Processeur IBM complexe');
  cnIBMRestaurantTerm: WriteLn('Terminal Restaurant d''IBM');
  cnIBMThinkPad700: WriteLn('IBM Think Pad 700');
  cnMemorexTelex: WriteLn('Memorex Telex');
  cnOlivettiM15: WriteLn('Olivetti M15');
  cnOlivettiM111: WriteLn('Olivetti M111');
  cnOlivettiM200: WriteLn('Olivetti M200');
  cnOlivettiM240: WriteLn('Olivetti M240');
  cnOlivettiM250: WriteLn('Olivetti M250');
  cnOlivettiM280: WriteLn('Olivetti M280');
  cnOlivettiM290: WriteLn('Olivetti M290');
  cnOlivettiM300: WriteLn('Olivetti M300');
  cnOlivettiM380: WriteLn('Olivetti M380 (XP1/XP3/XP5)');
  cnOlivettiM380XP7: WriteLn('Olivetti M380 (XP7)');
  cnOlivettiP500: WriteLn('Olivetti P500');
  cnOlivettiP800: WriteLn('Olivetti P800');
  cnOlivettiPCS286: WriteLn('Olivetti PCS286');
  cnPC: WriteLn('PC original');
  cnPCAT319: WriteLn('PC-AT 319 ou 339, 8Mhz');
  cnPCConv: WriteLn('PC-Convertible');
  cnPCJunior: WriteLn('PC Junior');
  cnPCXT_: WriteLn('PC XT d''IBM inconnue');
  cnPCXT2: WriteLn('PC-XT/2');
  cnPCXT286: WriteLn('PC-XT/286');
  cnPS1i486DX: WriteLn('PS/1 486DX');
  cnPS1i486SX: WriteLn('PS/1 486SX');
  cnPS1M2011: WriteLn('PS/1 Modäle 2011');
  cnPS1M2121: WriteLn('PS/1 Modäle 2121');
  cnPS2M25: WriteLn('PS/2 Modäle 25/25L');
  cnPS2M25i286: WriteLn('PS/2 Modäle 25-286');
  cnPS2M30: WriteLn('PS/2 Modäle 30');
  cnPS2M30i286: WriteLn('PS/2 Modäle 30-286');
  cnPS2M35: WriteLn('PS/2 Modäle 35/35LS/40 20Mhz 386SX');
  cnPS2M50: WriteLn('PS/2 Modäle 50, 10Mhz 286');
  cnPS2M50Z: WriteLn('PS/2 Modäle 50Z, 10Mhz 286');
  cnPS2M55_5502: WriteLn('PS/2 Modäle 55-5502');
  cnPS2M55_5530: WriteLN('PS/2 Modäle 55-5530 Laptop');
  cnPS2M55_5530T: WriteLn('PS/2 Modäle 55-5530T');
  cnPS2M55_5551: WriteLn('PS/2 Modäle 55-5551');
  cnPS2M55_5571: WriteLn('PS/2 Modäle 55-5571');
  cnPS2M55LS: WriteLn('PS/2 Modäle 55LS, 16Mhz');
  cnPS2M55N28SX: WriteLn('PS/2 Modäle 55 N28SX');
  cnPS2M55N33SX: WriteLn('PS/2 Modäle 55 N33SX');
  cnPS2M55SZ: WriteLn('PS/2 Modäle 55SZ');
  cnPS2M57: WriteLn('PS/2 Modäle 57, 20Mhz 386SX');
  cnPS2M60: WriteLn('PS/2 Modäle 60, 10Mhz 286');
  cnPS2M65_121: WriteLn('P2/2 Modäle 65-121, 16Mhz 386SX');
  cnPS2M70_16: WriteLn('PS/2 Modäle 70, 16Mhz 386');
  cnPS2M70_20: WriteLn('PS/2 Modäle 70, 20Mhz 386');
  cnPS2M70i386_25: WriteLn('PS/2 Modäle 70, 25Mhz 386');
  cnPS2M70i486_25: WriteLn('PS/2 Modäle 70, 25Mhz 486');
  cnPS2M77: WriteLn('PS/2 Modäle 77');
  cnPS2M80_16: WriteLn('PS/2 Modäle 80, 16Mhz 386');
  cnPS2M80_20: WriteLn('PS/2 Modäle 80, 20Mhz 386');
  cnPS2M80_25: WriteLn('PS/2 Modäle 80, 25Mhz 386');
  cnPS2M85: WriteLn('PS/2 Modäle 85');
  cnPS2M90_25: WriteLn('PS/2 Modäle 90, 25Mhz 386');
  cnPS2M90_33: WriteLn('PS/2 Modäle 90, 33Mhz 386');
  cnPS2M90_50: WriteLn('PS/2 Modäle 90, 50Mhz 486');
  cnPS2M90_SX87_20: WriteLn('PS/2 Modäle 90, 20Mhz 486SX+487SX');
  cnPS2M90AK9: WriteLn('PS/2 Modäle 90, AK9 25Mhz 486');
  cnPS2M90AKD: WriteLn('PS/2 Modäle 90, AKD 33Mhz 486');
  cnPS2M90XP: WriteLn('PS/2 Modäle 90 XP');
  cnPS2M90XPPentium: WriteLn('PS/2 Modäle 90 XP Pentium');
  cnPS2M95_20: WriteLn('PS/2 Modäle 95, 20Mhz 486SX');
  cnPS2M95_50: WriteLn('PS/2 Modäle 95, 50Mhz 486');
  cnPS2M95_SX87_20: WriteLn('PS/2 Modäle 95, 20Mhz 486SX+487SX');
  cnPS2M95XP: WriteLn('PS/2 Modäle 95 XP');
  cnPS2M95XPPentium: WriteLn('PS/2 Modäle 95 XP Pentium');
  cnPS2M295: WriteLn('PS/2 Modäle 295');
  cnPS2MCL57SX: WriteLn('PS/2 Modäle CL57 SX');
  cnPS2ML40: WriteLn('PS/2 Modäle L40, 20Mhz 386SX');
  cnPS2MM57: WriteLn('PS/2 Modäle M57, 20Mhz 386SLC');
  cnPS2MN51SLC: WriteLn('PS/2 Modäle N51 SLC');
  cnPS2MN51SX: WriteLn('PS/2 Modäle N51 SX');
  cnPS2MP70: WriteLn('PS/2 Modäle P70');
  cnPS2MP70_16: WriteLn('PS/2 Modäle P70, 16Mhz 386');
  cnPS2MP75_33: WriteLn('PS/2 Modäle P75, 33Mhz 386');
  cnPSVP325T: WriteLn('PS/ValuePoint 325T');
  cnPSVP425SX: WriteLn('PS/ValuePoint 425SX');
  cnPSVP433DX: WriteLn('PS/ValuePoint 433DX');
  cnQuadramQuad386: WriteLn('Quadram Quad 386');
  cnReplyModel32: WriteLn('Reply Modäle 32');
  cnSperryPC: WriteLn('Sperry PC');
  cnTandy1000: WriteLn('Tandy 1000');
  cnTandy3000: WriteLn('Tandy 3000');
  cnTandy3000NL: WriteLn('Tandy 3000NL');
  cnToshiba1800SX: WriteLn('Toshiba 1800SX');
  cnToshiba1850SX: WriteLn('Toshiba 1850SX');
  cnToshiba4400C: WriteLn('Toshiba 4400C');
  cnToshibaT1200XE: WriteLn('Toshiba T1200/XE');
  cnToshibaT4500SX_C: WriteLn('Toshiba T4500SX-C');
  cnToshibaT5200_100: WriteLn('Toshiba T5200/100');
  cnToshibaT5200_200: WriteLn('Toshiba T5200/200');
  cnXT: WriteLn('PC XT');
  cnZenith386: WriteLn('Zenith 386');
 End;
 WriteLn('Int 10h: ',StartUp.IntExistFlags and flgInt10h=flgInt10h,
	 ', 11h: ',StartUp.IntExistFlags and flgInt11h=flgInt11h,
	 ', 12h: ',StartUp.IntExistFlags and flgInt12h=flgInt12h,
	 ', 13h: ',StartUp.IntExistFlags and flgInt13h=flgInt13h,
	 ', 15h: ',StartUp.IntExistFlags and flgInt15h=flgInt15h,
	 ', 16h: ',StartUp.IntExistFlags and flgInt16h=flgInt16h);
 WriteLn('Int 1Ah: ',StartUp.IntExistFlags and flgInt1Ah=flgInt1Ah,
	 ', Int 21h: ',StartUp.IntExistFlags and flgInt21h=flgInt21h,
	 ', Int 2Fh: ',StartUp.IntExistFlags and flgInt2Fh=flgInt2Fh,
	 ', Int 33h: ',StartUp.IntExistFlags and flgInt33h=flgInt33h,
	 ', Int 67h: ',StartUp.IntExistFlags and flgInt67h=flgInt67h);
 WriteLn('Dos Version ',Lo(StartUp.GetDosVer),'.',Hi(StartUp.GetDosVer),
	 ', Pointeur interne DOS: ',HexWord2Str(Seg(StartUp.GetDosBlock^)),'h:',
	 HexWord2Str(Ofs(StartUp.GetDosBlock^))+'h');
 Write('OS/2: ',StartUp.OS2,' Version ',StartUp.OS2HiVer,'.',StartUp.OS2LoVer);
 Write(', Windows: ');
 Case StartUp.Win of
  winNo: WriteLn('Absent');
  win386X: WriteLn('/386 Version 2.X');
  winReal: WriteLn('fonctionne en mode rÇel');
  winStandard: WriteLn('fonctionne en mode standard');
  winEnhanced: Writeln('Version ',StartUp.WinLoVer,'.',StartUp.WinHiVer,' actif en mode Etendu');
 End;
 Write('Code de pays: ',StartUp.CountryCode,
       ', code de page: ',StartUp.CodePage);
 Write(', Format de la date: ');
 Case StartUp.Date of
  0: WriteLn('MM/JJ/AA');
  1: WriteLn('JJ/MM/AA');
  2: WriteLn('AA/MM/JJ');
  3: WriteLn('MM/AA/JJ');
  4: WriteLn('JJ/AA/MM');
  5: WriteLn('AA/JJ/MM');
 End;
 WriteLn('Monnaie: "',StartUp.Curr,
	 '", sÇparateur de millier: "',StartUp.ThSep,
	 '", sÇparateur de dÇcimal: "',StartUp.DeSep,'"');
 Write('SÇparateur de date: "',StartUp.DtSep,
       '", sÇparateur d''heure: "',StartUp.TmSep,
       '", format d''heure: ');
 Case StartUp.Time of
  AmPm: WriteLn('12 heures');
  Military: WriteLn('24 heures');
 End;
 WriteLn('Novell: ',StartUp.IsNovell);
 WriteLn('Ctrl. de manette de jeu: ',StartUp.JoyExist,
	 ', sup. par Bios: ',StartUp.BiosJoy,
	 ', pot.: ',StartUp.JoyPotentioMeter,
	 ', port: ',HexWord2Str(StartUp.JoyPort)+'h');
 Write('Modäle de clavier: ');
 Case StartUp.KbdModel of
  kbConterm: Write('Conterm Max/intÇgrÇ au boåtier');
  kbPC: Write('PC');
  kbXT: Write('XT');
  kbAT: Write('AT');
  kbMF: Write('MF');
 End;
 Write(', Int 16h Çtendu: ',StartUp.BiosKbdEnh,', Contrìleur: ');
 Case StartUp.KbdCtrl of
  ctrlkb8048: Write('8048');
  ctrlkb8042: Write('8042');
 End;
 WriteLn(', port: ',HexWord2Str(StartUp.KbdReadPort),'h');
 WriteLn('UnitÇ de disquette: ',StartUp.FloppyDskExist,
	 ', nombre: ',StartUp.NmFloppyDsk);
 Write('Disque dur: ',StartUp.HardDskExist,
       ', nombre: ', StartUp.NmHardDsk,
       ', contrìleur: ');
 Case StartUp.HardDskCtrl of
  ctrlhdNo: WriteLn('Absent');
  ctrlhdMFM: WriteLn('MFM');
  ctrlhdIDE: WriteLn('IDE');
  ctrlhdSCSITMC1680: WriteLn('SCSI TMC-1680');
  ctrlhdSCSITMC1650: WriteLN('SCSI TMC-1650/1660/1670/1680');
  ctrlhdSCSITMC820: WriteLn('SCSI TMC-820/830/860/870/875/880/885');
  ctrlhdSCSITMC840: WriteLn('SCSI TMC-840/880/881');
  ctrlhdSCSITMC830: WriteLn('SCSI TMC-830/850/860/875/885');
  Else WriteLn('Inconnu');
 End;
 WriteLn('Port paralläle existe: ',StartUp.LPTExist,
	 ', nombre: ',StartUp.NmLPT,
	 ', premiäre: LPT',StartUp.Get1LPT+1);
 WriteLn('Port sÇrie existe: ',StartUp.ComExist,', nombre: ',StartUp.NmCom);
 WriteLn('Taille de la mÇmoire conventionnel: ',StartUp.MemTotalSize,'Ko');
 WriteLn('Pilote EMM existe: ',StartUp.EmmExist,', segment: ',
	 HexWord2Str(StartUp.EmmSeg),'h, Taille de l''EMM: ',StartUp.EmmTotalSize,'Ko');
 WriteLn('Pilote XMM existe: ',StartUp.XmmExist,', adresse: ',
	 HexWord2Str(Seg(StartUp.XmmCtrl^)),'h:',HexWord2Str(Ofs(StartUp.XmmCtrl^)),
	 'h, taille de l''XMS: ',StartUp.XmsTotalSize,'Ko');
 WriteLn('MÇmoire Çtendue gÇrÇ par l''Int 15h: ',StartUp.ExtBiosExist,
	 ', Taille: ',StartUp.ExtBiosSizeK,'Ko');
 Write('Contrìleur CMOS: ');
 Case StartUp.CtrlCmos of
  ctrlCmosNo: Write('Absent');
  ctrlCmosUnknown: Write('Inconnu');
  ctrlCmosMC146818: Write('MC146818 de Motorola');
 End;
 WriteLn(', Port du CMOS: ',HexWord2Str(StartUp.CmosPort),'h');
 Write('Souris: ');
 Case StartUp.Mouse of
  msNoMouse: Write('Absente');
  msStandard: Write('Standard');
  msLogitech: Write('Logitech ',Lo(StartUp.MouseVer),'.',Hi(StartUp.MouseVer));
  msMicrosoft: Write('Microsoft ',Lo(StartUp.MouseVer),'.',Hi(StartUp.MouseVer));
  msSmooth: Write('Smooth ',Lo(StartUp.MouseVer),'.',Hi(StartUp.MouseVer));
  msZNIX: Write('Z-NIX');
  msGenius: Write('Genius');
 End;
 Write(' (',StartUp.MsButton,' boutons)');
 Write(', Spooler d''imprimante: ');
 Case StartUp.Spooler of
  drvNoSpooler: WriteLn('Absent');
  drvDiskSpoolII: WriteLn('Disk Spool II');
  drvPrintDos: WriteLn('Print du Dos');
  drvPrintManager: WriteLn('Print Manager');
 End;
 PutMethod;
 NmIndex:=0; HandleData:=New('STARTUP.RLL');
 If(IsHandleErr(HandleData))Then
 Begin
  WriteLn('Impossible de crÇer le fichier STARTUP.RLL');
  Halt;
 End;
 HandleMap := New('STARTUP.MAP');
 If(IsHandleErr(HandleData))Then
 Begin
  WriteLn('Impossible de crÇer le fichier STARTUP.MAP');
  Halt;
 End;
 SetFilePos(HandleData,0);
 PutFileTxt(HandleData,'RL2'+#26);
 PF:=(NumIndex+2)*SizeOf(Long);
  { Header }
 SetFilePos(HandleData,PF);
 _SetRec(HandleData,Length(HeaderRLL),@HeaderRLL[1]);
 Inc(PF,Length(HeaderRLL));
  { -- Index 0 -- : StartUpIsabel }
 SD := Ofs(EndStartUpIsabel) - Ofs(StartUpIsabel) + 1;
 AddIndex;
 _SetRec(HandleData,SD,@StartUpIsabel);
 Inc(PF,SD);
  { -- Index 1 -- : StartUpEconomic }
 SD := Ofs(EndStartUpEconomic) - Ofs(StartUpEconomic) + 1;
 AddIndex;
 _SetRec(HandleData,SD,@StartUpEconomic);
 Inc(PF,SD);
  { -- Index 2 -- : StartUpGolden }
 SD := Ofs(EndStartUpGolden) - Ofs(StartUpGolden) + 1;
 AddIndex;
 _SetRec(HandleData,SD,@StartUpGolden);
 Inc(PF,SD);
  { -- Index 3 -- : StartUpGame }
 SD := Ofs(EndStartUpGame) - Ofs(StartUpGame) + 1;
 AddIndex;
 _SetRec(HandleData,SD,@StartUpGame);
 Inc(PF,SD);
  { -- Index 4 -- : StartUpNetwork }
 SD := Ofs(EndStartUpNetwork) - Ofs(StartUpNetwork) + 1;
 AddIndex;
 _SetRec(HandleData,SD,@StartUpNetwork);
 Inc(PF,SD);
  { -- Index 5 -- : StartUpWindows }
 SD := Ofs(EndStartUpWindows) - Ofs(StartUpWindows) + 1;
 AddIndex;
 _SetRec(HandleData,SD,@StartUpWindows);
 Inc(PF,SD);
  { -- Index 6 -- : StartUpOpt1 }
 SD := Ofs(EndStartUpOpt) - Ofs(StartUpOpt) + 1;
 AddIndex;
 _SetRec(HandleData,SD,@StartUpOpt);
 Inc(PF,SD);
  { -- Index 7 -- : StartUpOpt2 }
 SD := Ofs(EndStartUpOpt) - Ofs(StartUpOpt) + 1;
 AddIndex;
 _SetRec(HandleData,SD,@StartUpOpt);
 Inc(PF,SD);
  { -- Index 8 -- : StartUpOpt3 }
 SD := Ofs(EndStartUpOpt) - Ofs(StartUpOpt) + 1;
 AddIndex;
 _SetRec(HandleData,SD,@StartUpOpt);
 Inc(PF,SD);
  { -- Index 9 -- : StartUpOpt4 }
 SD := Ofs(EndStartUpOpt) - Ofs(StartUpOpt) + 1;
 AddIndex;
 _SetRec(HandleData,SD,@StartUpOpt);
 Inc(PF,SD);
  { -- Index 0Ah -- : StartUpOpt5 }
 SD := Ofs(EndStartUpOpt) - Ofs(StartUpOpt) + 1;
 AddIndex;
 _SetRec(HandleData,SD,@StartUpOpt);
 Inc(PF,SD);
  { -- Index 0Bh -- : StartUpOpt6 }
 SD := Ofs(EndStartUpOpt) - Ofs(StartUpOpt) + 1;
 AddIndex;
 _SetRec(HandleData,SD,@StartUpOpt);
 Inc(PF,SD);
  { -- Index 0Ch -- : StartUpOpt7 }
 SD := Ofs(EndStartUpOpt) - Ofs(StartUpOpt) + 1;
 AddIndex;
 _SetRec(HandleData,SD,@StartUpOpt);
 Inc(PF,SD);
  { -- Index 0Dh -- : StartUpOpt8 }
 SD := Ofs(EndStartUpOpt) - Ofs(StartUpOpt) + 1;
 AddIndex;
 _SetRec(HandleData,SD,@StartUpOpt);
 Inc(PF,SD);
  { -- Index 0Eh -- : StartUpOpt9 }
 SD := Ofs(EndStartUpOpt) - Ofs(StartUpOpt) + 1;
 AddIndex;
 _SetRec(HandleData,SD,@StartUpOpt);
 Inc(PF,SD);
  { -- Index 0Fh -- : StartUpOpt10 }
 SD := Ofs(EndStartUpOpt) - Ofs(StartUpOpt) + 1;
 AddIndex;
 _SetRec(HandleData,SD,@StartUpOpt);
 Inc(PF,SD);
  { -- Index 10h -- : SetupMod }
 SD := Ofs(EndSetupMod) - Ofs(SetupMod) + 1;
 AddIndex;
 _SetRec(HandleData,SD,@SetupMod);
 Inc(PF,SD);
  { -- Index 11h -- : SetupPassword }
 SD := Ofs(EndSetupOpt) - Ofs(SetupOpt) + 1;
 AddIndex;
 _SetRec(HandleData,SD,@SetupOpt);
 Inc(PF,SD);
  { -- Index 12h -- : UnSetupPassword }
 SD := Ofs(EndSetupOpt) - Ofs(SetupOpt) + 1;
 AddIndex;
 _SetRec(HandleData,SD,@SetupOpt);
 Inc(PF,SD);
  { -- Index 13h -- : UnSetupOpt1 }
 SD := Ofs(EndSetupOpt) - Ofs(SetupOpt) + 1;
 AddIndex;
 _SetRec(HandleData,SD,@SetupOpt);
 Inc(PF,SD);
  { -- Index 14h -- : UnSetupOpt2 }
 SD := Ofs(EndSetupOpt) - Ofs(SetupOpt) + 1;
 AddIndex;
 _SetRec(HandleData,SD,@SetupOpt);
 Inc(PF,SD);
  { -- Index 15h -- : UnSetupOpt3 }
 SD := Ofs(EndSetupOpt) - Ofs(SetupOpt) + 1;
 AddIndex;
 _SetRec(HandleData,SD,@SetupOpt);
 Inc(PF,SD);
  { -- Index 16h -- : UnSetupOpt4 }
 SD := Ofs(EndSetupOpt) - Ofs(SetupOpt) + 1;
 AddIndex;
 _SetRec(HandleData,SD,@SetupOpt);
 Inc(PF,SD);
  { -- Index 17h -- : UnSetupOpt5 }
 SD := Ofs(EndSetupOpt) - Ofs(SetupOpt) + 1;
 AddIndex;
 _SetRec(HandleData,SD,@SetupOpt);
 Inc(PF,SD);
  { -- Index 18h -- : UnSetupOpt6 }
 SD := Ofs(EndSetupOpt) - Ofs(SetupOpt) + 1;
 AddIndex;
 _SetRec(HandleData,SD,@SetupOpt);
 Inc(PF,SD);
  { -- Index 19h -- : UnSetupOpt7 }
 SD := Ofs(EndSetupOpt) - Ofs(SetupOpt) + 1;
 AddIndex;
 _SetRec(HandleData,SD,@SetupOpt);
 Inc(PF,SD);
  { -- Index 1Ah -- : UnSetupOpt8 }
 SD := Ofs(EndSetupOpt) - Ofs(SetupOpt) + 1;
 AddIndex;
 _SetRec(HandleData,SD,@SetupOpt);
 Inc(PF,SD);
  { -- Index 1Bh -- : UnSetupOpt9 }
 SD := Ofs(EndSetupOpt) - Ofs(SetupOpt) + 1;
 AddIndex;
 _SetRec(HandleData,SD,@SetupOpt);
 Inc(PF,SD);
  { -- Index 1Ch -- : UnSetupOpt10 }
 SD := Ofs(EndSetupOpt) - Ofs(SetupOpt) + 1;
 AddIndex;
 _SetRec(HandleData,SD,@SetupOpt);
 Inc(PF,SD);
  { -- Index 1Dh -- : UnSetupOpt11 }
 SD := Ofs(EndSetupOpt) - Ofs(SetupOpt) + 1;
 AddIndex;
 _SetRec(HandleData,SD,@SetupOpt);
 Inc(PF,SD);
  { -- Index 1Eh -- : UnSetupOpt12 }
 SD := Ofs(EndSetupOpt) - Ofs(SetupOpt) + 1;
 AddIndex;
 _SetRec(HandleData,SD,@SetupOpt);
 Inc(PF,SD);
  { -- Index 1Fh -- : UnSetupOpt13 }
 SD := Ofs(EndSetupOpt) - Ofs(SetupOpt) + 1;
 AddIndex;
 _SetRec(HandleData,SD,@SetupOpt);
 Inc(PF,SD);
  { -- Index 20h -- : AltPress4Mem }
 SD := Ofs(EndAltPress4Mem) - Ofs(AltPress4Mem) + 1;
 AddIndex;
 _SetRec(HandleData,SD,@AltPress4Mem);
 Inc(PF,SD);
  { -- Index 21h -- : AltPress4Memi286 }
 SD := Ofs(EndAltPress4Memi286) - Ofs(AltPress4Memi286) + 1;
 AddIndex;
 _SetRec(HandleData,SD,@AltPress4Memi286);
 Inc(PF,SD);
  { -- Index 22h -- : AltPress4MemNoCLI }
 SD := Ofs(EndAltPress4MemNoCLI) - Ofs(AltPress4MemNoCLI) + 1;
 AddIndex;
 _SetRec(HandleData,SD,@AltPress4MemNoCLI);
 Inc(PF,SD);
  { -- Index 23h -- : AltPress4MemNoCLIi286 }
 SD := Ofs(EndAltPress4MemNoCLIi286) - Ofs(AltPress4MemNoCLIi286) + 1;
 AddIndex;
 _SetRec(HandleData,SD,@AltPress4MemNoCLIi286);
 Inc(PF,SD);
  { -- Index 24h -- : AltPress4Bios }
 SD := Ofs(EndAltPress4Bios) - Ofs(AltPress4Bios) + 1;
 AddIndex;
 _SetRec(HandleData,SD,@AltPress4Bios);
 Inc(PF,SD);
  { -- Index 25h -- : AltPressOpt1 }
 SD := Ofs(EndAltPressOpt) - Ofs(AltPressOpt) + 1;
 AddIndex;
 _SetRec(HandleData,SD,@AltPressOpt);
 Inc(PF,SD);
  { -- Index 26h -- : AltPressOpt2 }
 SD := Ofs(EndAltPressOpt) - Ofs(AltPressOpt) + 1;
 AddIndex;
 _SetRec(HandleData,SD,@AltPressOpt);
 Inc(PF,SD);
  { -- Index 27h -- : AltPressOpt3 }
 SD := Ofs(EndAltPressOpt) - Ofs(AltPressOpt) + 1;
 AddIndex;
 _SetRec(HandleData,SD,@AltPressOpt);
 Inc(PF,SD);
  { -- Index 28h -- : AltPressReturn }
 SD := Ofs(EndAltPressRtn) - Ofs(AltPressRtn) + 1;
 AddIndex;
 _SetRec(HandleData,SD,@AltPressRtn);
 Inc(PF,SD);
  { -- Index 29h -- : CtrlPress4Mem }
 SD := Ofs(EndCtrlPress4Mem) - Ofs(CtrlPress4Mem) + 1;
 AddIndex;
 _SetRec(HandleData,SD,@CtrlPress4Mem);
 Inc(PF,SD);
  { -- Index 2Ah -- : CtrlPress4Memi286 }
 SD := Ofs(EndCtrlPress4Memi286) - Ofs(CtrlPress4Memi286) + 1;
 AddIndex;
 _SetRec(HandleData,SD,@CtrlPress4Memi286);
 Inc(PF,SD);
  { -- Index 2Bh -- : CtrlPress4MemNoCLI }
 SD := Ofs(EndCtrlPress4MemNoCLI) - Ofs(CtrlPress4MemNoCLI) + 1;
 AddIndex;
 _SetRec(HandleData,SD,@CtrlPress4MemNoCLI);
 Inc(PF,SD);
  { -- Index 2Ch -- : CtrlPress4MemNoCLIi286 }
 SD := Ofs(EndCtrlPress4MemNoCLIi286) - Ofs(CtrlPress4MemNoCLIi286) + 1;
 AddIndex;
 _SetRec(HandleData,SD,@CtrlPress4MemNoCLIi286);
 Inc(PF,SD);
  { -- Index 2Dh -- : CtrlPress4Bios }
 SD := Ofs(EndCtrlPress4Bios) - Ofs(CtrlPress4Bios) + 1;
 AddIndex;
 _SetRec(HandleData,SD,@CtrlPress4Bios);
 Inc(PF,SD);
  { -- Index 2Eh -- : CtrlPressOpt1 }
 SD := Ofs(EndCtrlPressOpt) - Ofs(CtrlPressOpt) + 1;
 AddIndex;
 _SetRec(HandleData,SD,@CtrlPressOpt);
 Inc(PF,SD);
  { -- Index 2Fh -- : CtrlPressOpt2 }
 SD := Ofs(EndCtrlPressOpt) - Ofs(CtrlPressOpt) + 1;
 AddIndex;
 _SetRec(HandleData,SD,@CtrlPressOpt);
 Inc(PF,SD);
  { -- Index 30h -- : CtrlPressOpt3 }
 SD := Ofs(EndCtrlPressOpt) - Ofs(CtrlPressOpt) + 1;
 AddIndex;
 _SetRec(HandleData,SD,@CtrlPressOpt);
 Inc(PF,SD);
  { -- Index 31h -- : CtrlPressReturn }
 SD := Ofs(EndCtrlPressRtn) - Ofs(CtrlPressRtn) + 1;
 AddIndex;
 _SetRec(HandleData,SD,@CtrlPressRtn);
 Inc(PF,SD);
  { -- Index 32h -- : FillChr4Def }
 SD := Ofs(EndFillChar88) - Ofs(FillChar88) + 1;
 AddIndex;
 _SetRec(HandleData,SD,@FillChar88);
 Inc(PF,SD);
  { -- Index 33h -- : FillChrPer86 }
 SD := Ofs(EndFillChar86) - Ofs(FillChar86) + 1;
 AddIndex;
 _SetRec(HandleData,SD,@FillChar86);
 Inc(PF,SD);
  { -- Index 34h -- : FillChrPer32Bits }
 SD := Ofs(EndFillChar386) - Ofs(FillChar386) + 1;
 AddIndex;
 _SetRec(HandleData,SD,@FillChar386);
 Inc(PF,SD);
  { -- Index 35h -- : FillChrOpt1 }
 SD := Ofs(EndFillChrOpt) - Ofs(FillChrOpt) + 1;
 AddIndex;
 _SetRec(HandleData,SD,@FillChrOpt);
 Inc(PF,SD);
  { -- Index 36h -- : FillChrOpt2 }
 SD := Ofs(EndFillChrOpt) - Ofs(FillChrOpt) + 1;
 AddIndex;
 _SetRec(HandleData,SD,@FillChrOpt);
 Inc(PF,SD);
  { -- Index 37h -- : FillChrOpt3 }
 SD := Ofs(EndFillChrOpt) - Ofs(FillChrOpt) + 1;
 AddIndex;
 _SetRec(HandleData,SD,@FillChrOpt);
 Inc(PF,SD);
  { -- Index 38h -- : GetIntVec4Mem }
 SD := Ofs(EndGetIntVec4Mem) - Ofs(GetIntVec4Mem) + 1;
 AddIndex;
 _SetRec(HandleData,SD,@GetIntVec4Mem);
 Inc(PF,SD);
  { -- Index 39h -- : GetIntVec4Mem286 }
 SD := Ofs(EndGetIntVec4Memi286) - Ofs(GetIntVec4Memi286) + 1;
 AddIndex;
 _SetRec(HandleData,SD,@GetIntVec4Memi286);
 Inc(PF,SD);
  { -- Index 3Ah -- : GetIntVec4Mem386 }
 SD := Ofs(EndGetIntVec4Memi386) - Ofs(GetIntVec4Memi386) + 1;
 AddIndex;
 _SetRec(HandleData,SD,@GetIntVec4Memi386);
 Inc(PF,SD);
  { -- Index 3Bh -- : GetIntVec4Dos }
 SD := Ofs(EndGetIntVec4Dos) - Ofs(GetIntVec4Dos) + 1;
 AddIndex;
 _SetRec(HandleData,SD,@GetIntVec4Dos);
 Inc(PF,SD);
  { -- Index 3Ch -- : GetIntVecOpt1 }
 SD := Ofs(EndGetIntVecOpt) - Ofs(GetIntVecOpt) + 1;
 AddIndex;
 _SetRec(HandleData,SD,@GetIntVecOpt);
 Inc(PF,SD);
  { -- Index 3Dh -- : GetIntVecOpt2 }
 SD := Ofs(EndGetIntVecOpt) - Ofs(GetIntVecOpt) + 1;
 AddIndex;
 _SetRec(HandleData,SD,@GetIntVecOpt);
 Inc(PF,SD);
  { -- Index 3Eh -- : GetRawTimer4Mem }
 SD := Ofs(EndGetRawTimer4Mem) - Ofs(GetRawTimer4Mem) + 1;
 AddIndex;
 _SetRec(HandleData,SD,@GetRawTimer4Mem);
 Inc(PF,SD);
  { -- Index 3Fh -- : GetRawTimer4Memi286 }
 SD := Ofs(EndGetRawTimer4Memi286) - Ofs(GetRawTimer4Memi286) + 1;
 AddIndex;
 _SetRec(HandleData,SD,@GetRawTimer4Memi286);
 Inc(PF,SD);
  { -- Index 40h -- : GetRawTimer4Int1Ah }
 SD := Ofs(EndGetRawTimer4Int1Ah) - Ofs(GetRawTimer4Int1Ah)+1;
 AddIndex;
 _SetRec(HandleData,SD,@GetRawTimer4Int1Ah);
 Inc(PF,SD);
  { -- Index 41h -- : GetRawTimer4Cmos }
 SD := Ofs(EndGetRawTimer4Cmos) - Ofs(GetRawTimer4Cmos)+1;
 AddIndex;
 _SetRec(HandleData,SD,@GetRawTimer4Cmos);
 Inc(PF,SD);
  { -- Index 42h -- : GetRawTimerOpt1 }
 SD := Ofs(EndGetRawTimerOpt) - Ofs(GetRawTimerOpt)+1;
 AddIndex;
 _SetRec(HandleData,SD,@GetRawTimerOpt);
 Inc(PF,SD);
  { -- Index 43h -- : GetRawTimerOpt2 }
 SD := Ofs(EndGetRawTimerOpt) - Ofs(GetRawTimerOpt)+1;
 AddIndex;
 _SetRec(HandleData,SD,@GetRawTimerOpt);
 Inc(PF,SD);
  { -- Index 44h -- : GetRawTimerB4Mem }
 SD := Ofs(EndGetRawTimerB4Mem) - Ofs(GetRawTimerB4Mem)+1;
 AddIndex;
 _SetRec(HandleData,SD,@GetRawTimerB4Mem);
 Inc(PF,SD);
  { -- Index 45h -- : GetRawTimerB4Mem286 }
 SD := Ofs(EndGetRawTimerB4Mem286) - Ofs(GetRawTimerB4Mem286)+1;
 AddIndex;
 _SetRec(HandleData,SD,@GetRawTimerB4Mem286);
 Inc(PF,SD);
  { -- Index 46h -- : GetRawTimerB4Int1Ah }
 SD := Ofs(EndGetRawTimerB4Int1Ah) - Ofs(GetRawTimerB4Int1Ah)+1;
 AddIndex;
 _SetRec(HandleData,SD,@GetRawTimerB4Int1Ah);
 Inc(PF,SD);
  { -- Index 47h -- : GetRawTimerB4Dos }
 SD := Ofs(EndGetRawTimerB4Dos) - Ofs(GetRawTimerB4Dos)+1;
 AddIndex;
 _SetRec(HandleData,SD,@GetRawTimerB4Dos);
 Inc(PF,SD);
  { -- Index 48h -- : GetRawTimerOpt1 }
 SD := Ofs(EndGetRawTimerOpt) - Ofs(GetRawTimerOpt)+1;
 AddIndex;
 _SetRec(HandleData,SD,@GetRawTimerOpt);
 Inc(PF,SD);
  { -- Index 49h -- : GetRawTimerOpt2 }
 SD := Ofs(EndGetRawTimerOpt) - Ofs(GetRawTimerOpt)+1;
 AddIndex;
 _SetRec(HandleData,SD,@GetRawTimerOpt);
 Inc(PF,SD);
  { -- Index 4Ah -- : GetRawTimerOpt3 }
 SD := Ofs(EndGetRawTimerOpt) - Ofs(GetRawTimerOpt)+1;
 AddIndex;
 _SetRec(HandleData,SD,@GetRawTimerOpt);
 Inc(PF,SD);
  { -- Index 4Bh -- : JoyPos4IO }
 SD := Ofs(EndJoyPos4IO) - Ofs(JoyPos4IO)+1;
 AddIndex;
 _SetRec(HandleData,SD,@JoyPos4IO);
 Inc(PF,SD);
  { -- Index 4Ch -- : JoyPos4Bios }
 SD := Ofs(EndJoyPos4Bios) - Ofs(JoyPos4Bios)+1;
 AddIndex;
 _SetRec(HandleData,SD,@JoyPos4Bios);
 Inc(PF,SD);
  { -- Index 4Dh -- : JoyPosOpt1 }
 SD := Ofs(EndJoyPosOpt) - Ofs(JoyPosOpt)+1;
 AddIndex;
 _SetRec(HandleData,SD,@JoyPosOpt);
 Inc(PF,SD);
  { -- Index 4Eh -- : JoyPosOpt2 }
 SD := Ofs(EndJoyPosOpt) - Ofs(JoyPosOpt)+1;
 AddIndex;
 _SetRec(HandleData,SD,@JoyPosOpt);
 Inc(PF,SD);
  { -- Index 4Fh -- : JoyPosOpt3 }
 SD := Ofs(EndJoyPosOpt) - Ofs(JoyPosOpt)+1;
 AddIndex;
 _SetRec(HandleData,SD,@JoyPosOpt);
 Inc(PF,SD);
  { -- Index 50h -- : JoyPosOpt4 }
 SD := Ofs(EndJoyPosOpt) - Ofs(JoyPosOpt)+1;
 AddIndex;
 _SetRec(HandleData,SD,@JoyPosOpt);
 Inc(PF,SD);
  { -- Index 51h -- : JoyPosRtn }
 SD := Ofs(EndJoyPosRtn) - Ofs(JoyPosRtn)+1;
 AddIndex;
 _SetRec(HandleData,SD,@JoyPosRtn);
 Inc(PF,SD);
  { -- Index 52h -- : Keypress4IO }
 SD := Ofs(EndKeypress4IO) - Ofs(Keypress4IO)+1;
 AddIndex;
 _SetRec(HandleData,SD,@Keypress4IO);
 Inc(PF,SD);
  { -- Index 53h -- : Keypress4Mem }
 SD := Ofs(EndKeypress4Mem) - Ofs(Keypress4Mem)+1;
 AddIndex;
 _SetRec(HandleData,SD,@Keypress4Mem);
 Inc(PF,SD);
  { -- Index 54h -- : Keypress4MemNoCLI }
 SD := Ofs(EndKeypress4MemNoCLI) - Ofs(Keypress4MemNoCLI)+1;
 AddIndex;
 _SetRec(HandleData,SD,@Keypress4MemNoCLI);
 Inc(PF,SD);
  { -- Index 55h -- : Keypress4Bios }
 SD := Ofs(EndKeypress4Bios) - Ofs(Keypress4Bios)+1;
 AddIndex;
 _SetRec(HandleData,SD,@Keypress4Bios);
 Inc(PF,SD);
  { -- Index 56h -- : Keypress4Dos }
 SD := Ofs(EndKeypress4Dos) - Ofs(Keypress4Dos)+1;
 AddIndex;
 _SetRec(HandleData,SD,@Keypress4Dos);
 Inc(PF,SD);
  { -- Index 57h -- : KeypressOpt1 }
 SD := Ofs(EndKeypressOpt) - Ofs(KeypressOpt)+1;
 AddIndex;
 _SetRec(HandleData,SD,@KeypressOpt);
 Inc(PF,SD);
  { -- Index 58h -- : KeypressOpt2 }
 SD := Ofs(EndKeypressOpt) - Ofs(KeypressOpt)+1;
 AddIndex;
 _SetRec(HandleData,SD,@KeypressOpt);
 Inc(PF,SD);
  { -- Index 59h -- : KeypressOpt3 }
 SD := Ofs(EndKeypressOpt) - Ofs(KeypressOpt)+1;
 AddIndex;
 _SetRec(HandleData,SD,@KeypressOpt);
 Inc(PF,SD);
  { -- Index 5Ah -- : KeypressRtn }
 SD := Ofs(EndKeypressRtn) - Ofs(KeypressRtn)+1;
 AddIndex;
 _SetRec(HandleData,SD,@KeypressRtn);
 Inc(PF,SD);
  { -- Index 5Bh -- : LShiftPress4Mem }
 SD := Ofs(EndLShiftPress4Mem) - Ofs(LShiftPress4Mem)+1;
 AddIndex;
 _SetRec(HandleData,SD,@LShiftPress4Mem);
 Inc(PF,SD);
  { -- Index 5Ch -- : LShiftPress4Memi286 }
 SD := Ofs(EndLShiftPress4Memi286) - Ofs(LShiftPress4Memi286)+1;
 AddIndex;
 _SetRec(HandleData,SD,@LShiftPress4Memi286);
 Inc(PF,SD);
  { -- Index 5Dh -- : LShiftPress4MemNoCLI }
 SD := Ofs(EndLShiftPress4MemNoCLI) - Ofs(LShiftPress4MemNoCLI)+1;
 AddIndex;
 _SetRec(HandleData,SD,@LShiftPress4MemNoCLI);
 Inc(PF,SD);
  { -- Index 5Eh -- : LShiftPress4MemNoCLI286 }
 SD := Ofs(EndLShiftPress4MemNoCLIi286) - Ofs(LShiftPress4MemNoCLIi286)+1;
 AddIndex;
 _SetRec(HandleData,SD,@LShiftPress4MemNoCLIi286);
 Inc(PF,SD);
  { -- Index 5Fh -- : LShiftPress4Bios }
 SD := Ofs(EndLShiftPress4Bios) - Ofs(LShiftPress4Bios)+1;
 AddIndex;
 _SetRec(HandleData,SD,@LShiftPress4Bios);
 Inc(PF,SD);
  { -- Index 60h -- : LShiftPressOpt1 }
 SD := Ofs(EndLShiftPressOpt) - Ofs(LShiftPressOpt)+1;
 AddIndex;
 _SetRec(HandleData,SD,@LShiftPressOpt);
 Inc(PF,SD);
  { -- Index 61h -- : LShiftPressOpt2 }
 SD := Ofs(EndLShiftPressOpt) - Ofs(LShiftPressOpt)+1;
 AddIndex;
 _SetRec(HandleData,SD,@LShiftPressOpt);
 Inc(PF,SD);
  { -- Index 62h -- : LShiftPressOpt3 }
 SD := Ofs(EndLShiftPressOpt) - Ofs(LShiftPressOpt)+1;
 AddIndex;
 _SetRec(HandleData,SD,@LShiftPressOpt);
 Inc(PF,SD);
  { -- Index 63h -- : LShiftPressRtn }
 SD := Ofs(EndLShiftPressRtn) - Ofs(LShiftPressRtn)+1;
 AddIndex;
 _SetRec(HandleData,SD,@LShiftPressRtn);
 Inc(PF,SD);
  { -- Index 64h -- : Move88 }
 SD := Ofs(EndMove88) - Ofs(Move88)+1;
 AddIndex;
 _SetRec(HandleData,SD,@Move88);
 Inc(PF,SD);
  { -- Index 65h -- : Move86 }
 SD := Ofs(EndMove86) - Ofs(Move86)+1;
 AddIndex;
 _SetRec(HandleData,SD,@Move86);
 Inc(PF,SD);
  { -- Index 66h -- : Move386 }
 SD := Ofs(EndMove386) - Ofs(Move386)+1;
 AddIndex;
 _SetRec(HandleData,SD,@Move386);
 Inc(PF,SD);
  { -- Index 67h -- : MoveOpt1 }
 SD := Ofs(EndMoveOpt) - Ofs(MoveOpt)+1;
 AddIndex;
 _SetRec(HandleData,SD,@MoveOpt);
 Inc(PF,SD);
  { -- Index 68h -- : MoveOpt2 }
 SD := Ofs(EndMoveOpt) - Ofs(MoveOpt)+1;
 AddIndex;
 _SetRec(HandleData,SD,@MoveOpt);
 Inc(PF,SD);
  { -- Index 69h -- : MoveOpt3 }
 SD := Ofs(EndMoveOpt) - Ofs(MoveOpt)+1;
 AddIndex;
 _SetRec(HandleData,SD,@MoveOpt);
 Inc(PF,SD);
  { -- Index 6Ah -- : PushKey4Mem }
 SD := Ofs(EndPushKey4Mem) - Ofs(PushKey4Mem)+1;
 AddIndex;
 _SetRec(HandleData,SD,@PushKey4Mem);
 Inc(PF,SD);
  { -- Index 6Bh -- : PushKey4Bios15h }
 SD := Ofs(EndPushKey4Bios15h) - Ofs(PushKey4Bios15h)+1;
 AddIndex;
 _SetRec(HandleData,SD,@PushKey4Bios15h);
 Inc(PF,SD);
  { -- Index 6Ch -- : PushKey4Bios16h }
 SD := Ofs(EndPushKey4Bios16h) - Ofs(PushKey4Bios16h)+1;
 AddIndex;
 _SetRec(HandleData,SD,@PushKey4Bios16h);
 Inc(PF,SD);
  { -- Index 6Dh -- : PushKeyOpt1 }
 SD := Ofs(EndPushKeyOpt) - Ofs(PushKeyOpt)+1;
 AddIndex;
 _SetRec(HandleData,SD,@PushKeyOpt);
 Inc(PF,SD);
  { -- Index 6Eh -- : PushKeyOpt2 }
 SD := Ofs(EndPushKeyOpt) - Ofs(PushKeyOpt)+1;
 AddIndex;
 _SetRec(HandleData,SD,@PushKeyOpt);
 Inc(PF,SD);
  { -- Index 6Fh -- : PushKeyOpt3 }
 SD := Ofs(EndPushKeyOpt) - Ofs(PushKeyOpt)+1;
 AddIndex;
 _SetRec(HandleData,SD,@PushKeyOpt);
 Inc(PF,SD);
  { -- Index 70h -- : PushKeyRtn }
 SD := Ofs(EndPushKeyRtn) - Ofs(PushKeyRtn)+1;
 AddIndex;
 _SetRec(HandleData,SD,@PushKeyRtn);
 Inc(PF,SD);
  { -- Index 71h -- : ReadKey4IO }
 SD := Ofs(EndReadKey4IO) - Ofs(ReadKey4IO)+1;
 AddIndex;
 _SetRec(HandleData,SD,@ReadKey4IO);
 Inc(PF,SD);
  { -- Index 72h -- : ReadKey4Mem }
 SD := Ofs(EndReadKey4Mem) - Ofs(ReadKey4Mem)+1;
 AddIndex;
 _SetRec(HandleData,SD,@ReadKey4Mem);
 Inc(PF,SD);
  { -- Index 73h -- : ReadKey4Bios00h }
 SD := Ofs(EndReadKey4Bios00h) - Ofs(ReadKey4Bios00h)+1;
 AddIndex;
 _SetRec(HandleData,SD,@ReadKey4Bios00h);
 Inc(PF,SD);
  { -- Index 74h -- : ReadKey4Bios10h }
 SD := Ofs(EndReadKey4Bios10h) - Ofs(ReadKey4Bios10h)+1;
 AddIndex;
 _SetRec(HandleData,SD,@ReadKey4Bios10h);
 Inc(PF,SD);
  { -- Index 75h -- : ReadKey4Dos }
 SD := Ofs(EndReadKey4Dos) - Ofs(ReadKey4Dos)+1;
 AddIndex;
 _SetRec(HandleData,SD,@ReadKey4Dos);
 Inc(PF,SD);
  { -- Index 76h -- : ReadKeyOpt1 }
 SD := Ofs(EndReadKeyOpt) - Ofs(ReadKeyOpt)+1;
 AddIndex;
 _SetRec(HandleData,SD,@ReadKeyOpt);
 Inc(PF,SD);
  { -- Index 77h -- : ReadKeyOpt2 }
 SD := Ofs(EndReadKeyOpt) - Ofs(ReadKeyOpt)+1;
 AddIndex;
 _SetRec(HandleData,SD,@ReadKeyOpt);
 Inc(PF,SD);
  { -- Index 78h -- : ReadKeyOpt3 }
 SD := Ofs(EndReadKeyOpt) - Ofs(ReadKeyOpt)+1;
 AddIndex;
 _SetRec(HandleData,SD,@ReadKeyOpt);
 Inc(PF,SD);
  { -- Index 79h -- : ReadKeyRtn }
 SD := Ofs(EndReadKeyRtn) - Ofs(ReadKeyRtn)+1;
 AddIndex;
 _SetRec(HandleData,SD,@ReadKeyRtn);
 Inc(PF,SD);
  { -- Index 7Ah -- : RShiftPress4Mem }
 SD := Ofs(EndRShiftPress4Mem) - Ofs(RShiftPress4Mem)+1;
 AddIndex;
 _SetRec(HandleData,SD,@RShiftPress4Mem);
 Inc(PF,SD);
  { -- Index 7Bh -- : RShiftPress4Memi286 }
 SD := Ofs(EndRShiftPress4Memi286) - Ofs(RShiftPress4Memi286)+1;
 AddIndex;
 _SetRec(HandleData,SD,@RShiftPress4Memi286);
 Inc(PF,SD);
  { -- Index 7Ch -- : RShiftPress4MemNoCLI }
 SD := Ofs(EndRShiftPress4MemNoCLI) - Ofs(RShiftPress4MemNoCLI)+1;
 AddIndex;
 _SetRec(HandleData,SD,@RShiftPress4MemNoCLI);
 Inc(PF,SD);
  { -- Index 7Dh -- : RShiftPress4MemNoCLIi286 }
 SD := Ofs(EndRShiftPress4MemNoCLIi286) - Ofs(RShiftPress4MemNoCLIi286)+1;
 AddIndex;
 _SetRec(HandleData,SD,@RShiftPress4MemNoCLIi286);
 Inc(PF,SD);
  { -- Index 7Eh -- : RShiftPress4Bios }
 SD := Ofs(EndRShiftPress4Bios) - Ofs(RShiftPress4Bios)+1;
 AddIndex;
 _SetRec(HandleData,SD,@RShiftPress4Bios);
 Inc(PF,SD);
  { -- Index 7Fh -- : RShiftPressOpt1 }
 SD := Ofs(EndRShiftPressOpt) - Ofs(RShiftPressOpt)+1;
 AddIndex;
 _SetRec(HandleData,SD,@RShiftPressOpt);
 Inc(PF,SD);
  { -- Index 80h -- : RShiftPressOpt2 }
 SD := Ofs(EndRShiftPressOpt) - Ofs(RShiftPressOpt)+1;
 AddIndex;
 _SetRec(HandleData,SD,@RShiftPressOpt);
 Inc(PF,SD);
  { -- Index 81h -- : RShiftPressOpt3 }
 SD := Ofs(EndRShiftPressOpt) - Ofs(RShiftPressOpt)+1;
 AddIndex;
 _SetRec(HandleData,SD,@RShiftPressOpt);
 Inc(PF,SD);
  { -- Index 82h -- : RShiftPressRtn }
 SD := Ofs(EndRShiftPressRtn) - Ofs(RShiftPressRtn)+1;
 AddIndex;
 _SetRec(HandleData,SD,@RShiftPressRtn);
 Inc(PF,SD);
  { -- Index 83h -- : SetIntVec4Mem }
 SD := Ofs(EndSetIntVec4Mem) - Ofs(SetIntVec4Mem) + 1;
 AddIndex;
 _SetRec(HandleData,SD,@SetIntVec4Mem);
 Inc(PF,SD);
  { -- Index 84h -- : SetIntVec4Mem286 }
 SD := Ofs(EndSetIntVec4Memi286) - Ofs(SetIntVec4Memi286) + 1;
 AddIndex;
 _SetRec(HandleData,SD,@SetIntVec4Memi286);
 Inc(PF,SD);
  { -- Index 85h -- : SetIntVec4Mem386 }
 SD := Ofs(EndSetIntVec4Memi386) - Ofs(SetIntVec4Memi386) + 1;
 AddIndex;
 _SetRec(HandleData,SD,@SetIntVec4Memi386);
 Inc(PF,SD);
  { -- Index 86h -- : SetIntVec4Dos }
 SD := Ofs(EndSetIntVec4Dos) - Ofs(SetIntVec4Dos) + 1;
 AddIndex;
 _SetRec(HandleData,SD,@SetIntVec4Dos);
 Inc(PF,SD);
  { -- Index 87h -- : SetIntVecOpt1 }
 SD := Ofs(EndSetIntVecOpt) - Ofs(SetIntVecOpt) + 1;
 AddIndex;
 _SetRec(HandleData,SD,@SetIntVecOpt);
 Inc(PF,SD);
  { -- Index 88h -- : SetIntVecOpt2 }
 SD := Ofs(EndSetIntVecOpt) - Ofs(SetIntVecOpt) + 1;
 AddIndex;
 _SetRec(HandleData,SD,@SetIntVecOpt);
 Inc(PF,SD);
  { -- Index 89h -- : ShiftPress4Mem }
 SD := Ofs(EndShiftPress4Mem) - Ofs(ShiftPress4Mem)+1;
 AddIndex;
 _SetRec(HandleData,SD,@ShiftPress4Mem);
 Inc(PF,SD);
  { -- Index 8Ah -- : ShiftPress4Memi286 }
 SD := Ofs(EndShiftPress4Memi286) - Ofs(ShiftPress4Memi286)+1;
 AddIndex;
 _SetRec(HandleData,SD,@ShiftPress4Memi286);
 Inc(PF,SD);
  { -- Index 8Bh -- : ShiftPress4MemNoCLI }
 SD := Ofs(EndShiftPress4MemNoCLI) - Ofs(ShiftPress4MemNoCLI)+1;
 AddIndex;
 _SetRec(HandleData,SD,@ShiftPress4MemNoCLI);
 Inc(PF,SD);
  { -- Index 8Ch -- : ShiftPress4MemNoCLIi286 }
 SD := Ofs(EndShiftPress4MemNoCLIi286) - Ofs(ShiftPress4MemNoCLIi286)+1;
 AddIndex;
 _SetRec(HandleData,SD,@ShiftPress4MemNoCLIi286);
 Inc(PF,SD);
  { -- Index 8Dh -- : ShiftPress4Bios }
 SD := Ofs(EndShiftPress4Bios) - Ofs(ShiftPress4Bios)+1;
 AddIndex;
 _SetRec(HandleData,SD,@ShiftPress4Bios);
 Inc(PF,SD);
  { -- Index 8Eh -- : ShiftPressOpt1 }
 SD := Ofs(EndShiftPressOpt) - Ofs(ShiftPressOpt)+1;
 AddIndex;
 _SetRec(HandleData,SD,@ShiftPressOpt);
 Inc(PF,SD);
  { -- Index 8Fh -- : ShiftPressOpt2 }
 SD := Ofs(EndShiftPressOpt) - Ofs(ShiftPressOpt)+1;
 AddIndex;
 _SetRec(HandleData,SD,@ShiftPressOpt);
 Inc(PF,SD);
  { -- Index 90h -- : ShiftPressOpt3 }
 SD := Ofs(EndShiftPressOpt) - Ofs(ShiftPressOpt)+1;
 AddIndex;
 _SetRec(HandleData,SD,@ShiftPressOpt);
 Inc(PF,SD);
  { -- Index 91h -- : ShiftPressRtn }
 SD := Ofs(EndShiftPressRtn) - Ofs(ShiftPressRtn)+1;
 AddIndex;
 _SetRec(HandleData,SD,@ShiftPressRtn);
 Inc(PF,SD);
  { -- Index End -- }
 SD := 0;
 AddIndex;
 Close(HandleMap);
 Close(HandleData);
END.