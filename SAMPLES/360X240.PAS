{ Cette proc‚dure fournit les routines de base permettant de faire
 fonctionner l'affichage VGA en mode 360x240 en 256 couleurs.
}

Program Routines360x240c256;

Type
  {Tableau d'octet infini...}
 TByte=Array[0..65520]of Byte;

  {ModeInfoVideo}
 MIV=Record
  Mode:Word;               { Mode vid‚o actuel (vm???)}
  IbmLogic,                { Mode dans la logique IBM (pas hors cas texte … la SVGA...)}
  BiosSupport,             { Mode support‚ par le Bios (Par exemple, la GS en 16 couleurs le Bios ne le connaŒt pas) }
  Color,                   { Mode couleur? Sinon monochrome for‡‚ment...}
  Graf,                    { Mode graphique? Sinon texte}
  Direct,                  { M‚thode directe? Sinon Bios ou Dos}
  Blink,                   { Clignotement?}
  Snow:Boolean;            { Neige lors de l'envoie de donn‚e dans le tampon vid‚o?}
  SegVideo:Word;           { Segment vid‚o (A000h,B000h,B800h,...)}
  HeightChar:Byte;         { Hauteur de la police de caractŠre actuel}
  NumXPixels,              { Nombre de pixels horizontal qu'affiche l'‚cran}
  NumYPixels:Word;         { Nombre de pixels vertical qu'affiche l'‚cran}
  NumXTexts,NumYTexts,     { Nombre de caractŠre texte horizontal/vertical qu'affiche l'‚cran}
  NumVideoPages:Byte;      { Nombre de page vid‚o que supporte le mode actuel}
  NumColors:LongInt;       { Nombre de couleurs affich‚}
  BitsPerPixel:Byte;       { Nombre de Bit(s) utilis‚ pour l'affichage d'un pixel}
  BytesPerLine:Word;       { Nombre d'octet par ligne affich‚ (trŠs relatif en VGA...)}
  Page:Byte;               { Num‚ro de la page vid‚o de travail}
  AddrPage:Word;           { En texte, adresse en m‚moire vid‚o de la page actuel}
  ShowPage:Byte;           { Num‚ro de la page vid‚o actuellement affich‚}
  TextMatrix:^TByte;       { Pointeur sur la police de caractŠre courante}
  ScreenSize:LongInt;      { Taille de l'‚cran}
  SizeBank:Word;           { Taille d'un page de la banque (0=64Ko)}
  SegBuf:Word;             { Segment du tampon d'acc‚l‚ration}
  IsDoubleMatrixx:Boolean; { Y a-t-il utilisation d'une police de 512 caractŠres?}
  XCursor,YCursor:Byte;    { Position actuel du curseur}
  StartCur,EndCur:Byte;    { Ligne de d‚part et de fin du curseur}
 End;

{ Voici un tableau de donn‚es utiliser pour l'affichage des ‚l‚ments
 dans l'‚cran.
}

Procedure DataVideo;Assembler;ASM
 DW 0      {Mode:             Mode vid‚o actuel (vm???)}
 DB False  {IbmLogic:         Mode dans la logique IBM (pas hors cas texte … la SVGA...)}
 DB False  {BiosSupport:      Mode support‚ par le Bios (Par exemple, la GS en 16 couleurs le Bios ne le connaŒt pas)}
 DB True   {Color:            Mode couleur? Sinon monochrome for‡‚ment...}
 DB True   {Graf:             Mode graphique? Sinon texte}
 DB True   {Direct:           M‚thode directe? Sinon Bios ou Dos}
 DB False  {Blink:            Clignotement}
 DB False  {Snow:             Neige lors de l'envoie de donn‚e dans le tampon vid‚o?}
 DW 0A000h {SegVideo:         Segment vid‚o (A000h,B000h,B800h,...) }
 DB 8      {HeightChar:       Hauteur de la police de caractŠre actuel}
 DW 360    {NumXPixels:       Nombre de pixels horizontal qu'affiche l'‚cran}
 DW 240    {NumYPixels:       Nombre de pixels vertical qu'affiche l'‚cran}
 DB 45,30  {NumXTxts,NumYTxts:Nombre de caractŠre texte horizontal/vertical qu'affiche l'‚cran}
 DB 2      {NumVideoPages:    Nombre de page vid‚o que supporte le mode actuel}
 DD 256    {NumColors:        Nombre de couleurs affich‚}
 DB 8      {BitsPerPixel:     Nombre de Bit(s) utilis‚ pour l'affichage d'un pixel}
 DW 90     {BytesPerLine:     Nombre d'octet par ligne affich‚ (trŠs relatif en VGA...)}
 DB 0      {Page:             Num‚ro de la page vid‚o de travail}
 DW 0      {AddrPage:         En texte, adresse en m‚moire vid‚o de la page actuel}
 DB 0      {ShowPage:         Num‚ro de la page vid‚o actuellement affich‚}
 DD 0      {TextMatrix:       Pointeur sur la police de caractŠre courante}
 DD 86400  {ScreenSize:       Taille de l'‚cran}
 DW 0      {SizeBank:         Taille d'un page de la banque (0=64 Ko) }
 DW 0      {SegBuf:           Segment du tampon d'acc‚l‚ration}
 DB 0      {IsDoubleMatrix:   Y a-t-il une police de 512 caractŠres?}
 DB 0,0    {XCursor,YCursor:  Position actuel du curseur}
 DB 0,0    {StartCur,EndCur:  D‚but et fin du curseur}
END;

 {Coordonn‚e brute de chacune des lignes afin d'obtenir de meilleur performance}
Procedure RealRawY;Assembler;ASM
  {0 … 199}
 DW     0,   90,  180,  270,  360,  450,  540,  630,  720,  810,  900,  990{0 … 11}
 DW  1080, 1170, 1260, 1350, 1440, 1530, 1620, 1710, 1800, 1890, 1980, 2070{12 … 23}
 DW  2160, 2250, 2340, 2430, 2520, 2610, 2700, 2790, 2880, 2970, 3060, 3150{24 … 35}
 DW  3240, 3330, 3420, 3510, 3600, 3690, 3780, 3870, 3960, 4050, 4140, 4230{36 … 47}
 DW  4320, 4410, 4500, 4590, 4680, 4770, 4860, 4950, 5040, 5130, 5220, 5310{48 … 63}
 DW  5400, 5490, 5580, 5670, 5760, 5850, 5940, 6030, 6120, 6210, 6300, 6390{64 … 75}
 DW  6480, 6570, 6660, 6750, 6840, 6930, 7020, 7110, 7200, 7290, 7380, 7470{76 … 87}
 DW  7560, 7650, 7740, 7830, 7920, 8010, 8100, 8190, 8280, 8370, 8460, 8550{88 … 95}
 DW  8640, 8730, 8820, 8910, 9000, 9090, 9180, 9270, 9360, 9450, 9540, 9630{96 … 107}
 DW  9720, 9810, 9900, 9990,10080,10170,10260,10350,10440,10530,10620,10710{108 … 119}
 DW 10800,10890,10980,11070,11160,11250,11340,11430,11520,11610,11700,11790{120 … 131}
 DW 11880,11970,12060,12150,12240,12330,12420,12510,12600,12690,12780,12870{132 … 143}
 DW 12960,13050,13140,13230,13320,13410,13500,13590,13680,13770,13860,13950{144 … 155}
 DW 14040,14130,14220,14310,14400,14490,14580,14670,14760,14850,14940,15030{156 … 167}
 DW 15120,15210,15300,15390,15480,15570,15660,15750,15840,15930,16020,16110{168 … 179}
 DW 16200,16290,16380,16470,16560,16650,16740,16830,16920,17010,17100,17190{180 … 191}
 DW 17280,17370,17460,17550,17640,17730,17820,17910
  { 200 … 399 }
 DW 18000,18090,18180,18270,18360,18450,18540,18630,18720,18810,18900,18990
 DW 19080,19170,19260,19350,19440,19530,19620,19710,19800,19890,19980,20070
 DW 20160,20250,20340,20430,20520,20610,20700,20790,20880,20970,21060,21150
 DW 21240,21330,21420,21510,21600,21690,21780,21870,21960,22050,22140,22230
 DW 22320,22410,22500,22590,22680,22770,22860,22950,23040,23130,23220,23310
 DW 23400,23490,23580,23670,23760,23850,23940,24030,24120,24210,24300,24390
 DW 24480,24570,24660,24750,24840,24930,25020,25110,25200,25290,25380,25470
 DW 25560,25650,25740,25830,25920,26010,26100,26190,26280,26370,26460,26550
 DW 26640,26730,26820,26910,27000,27090,27180,27270,27360,27450,27540,27630
 DW 27720,27810,27900,27990,28080,28170,28260,28350,28440,28530,28620,28710
 DW 28800,28890,28980,29070,29160,29250,29340,29430,29520,29610,29700,29790
 DW 29880,29970,30060,30150,30240,30330,30420,30510,30600,30690,30780,30870
 DW 30960,31050,31140,31230,31320,31410,31500,31590,31680,31770,31860,31950
 DW 32040,32130,32220,32310,32400,32490,32580,32670,32760,32850,32940,33030
 DW 33120,33210,33300,33390,33480,33570,33660,33750,33840,33930,34020,34110
 DW 34200,34290,34380,34470,34560,34650,34740,34830,34920,35010,35100,35190
 DW 35280,35370,35460,35550,35640,35730,35820,35910
  { 400 … 479 }
 DW 36000,36090,36180,36270,36360,36450,36540,36630,36720,36810,36900,36990 { 400 … 411 }
 DW 37080,37170,37260,37350,37440,37530,37620,37710,37800,37890,37980,38070 { 412 … 423 }
 DW 38160,38250,38340,38430,38520,38610,38700,38790,38880,38970,39060,39150 { 424 … 435 }
 DW 39240,39330,39420,39510,39600,39690,39780,39870,39960,40050,40140,40230 { 436 … 447 }
 DW 40320,40410,40500,40590,40680,40770,40860,40950,41040,41130,41220,41310 { 448 … 459 }
 DW 41400,41490,41580,41670,41760,41850,41940,42030,42120,42210,42300,42390 { 460 … 471 }
 DW 42480,42570,42660,42750,42840,42930,43020,43110,43200                   { 472 … 480 }
  { 481 … ...: Hors limite!!!! }
 DW 43290,43380,43470,43560,43650,43740,43830,43920,44010,44100,44190,44280 { 481 … 492 }
 DW 44370,44460,44550,44640,44730,44820,44910,45000,45090,45180,45270,45360 { 493 … 504 }
 DW 45450,45540,45630,45720,45810,45900,45990,46080,46170,46260,46350,46440 { 505 … 516 }
 DW 46530,46620,46710,46800,46890,46980,47070,47160,47250,47340,47430,47520 { 517 … 528 }
 DW 47610,47700,47790,47880,47970,48060,48150,48240,48330,48420,48510,48600 { 529 … 540 }
 DW 48690,48780,48870,48960,49050,49140,49230,49320,49410,49500,49590,49680 { 541 … 552 }
 DW 49770,49860,49950,50040,50130,50220,50310,50400,50490,50580,50670,50760 { 553 … 564 }
 DW 50850,50940,51030,51120,51210,51300,51390,51480,51570,51660,51750,51840 { 565 … 576 }
 DW 51930,52020,52110,52200,52290,52380,52470,52560,52650,52740,52830,52920 { 577 … 588 }
 DW 53010,53100,53190,53280,53370,53460,53550,53640,53730,53820,53910,54000 { 589 … 600 }
  { 700 … ... }
 DW 54090,54180,54270,54360,54450,54540,54630,54720,54810,54900,54990,55080 { 601 … 612 }
 DW 55170,55260,55350,55440,55530,55620,55710,55800,55890,55980,56070,56160 { 613 … 624 }
 DW 56250,56340,56430,56520,56610,56700,56790,56880,56970,57060,57150,57240 { 625 … 636 }
 DW 57330,57420,57510,57600,57690,57780,57870,57960,58050,58140,58230,58320 { 637 … 648 }
 DW 58410,58500,58590,58680,58770,58860,58950,59040,59130,59220,59310,59400 { 649 … 660 }
 DW 59490,59580,59670,59760,59850,59940,60030,60120,60210,60300,60390,60480 { 661 … 672 }
 DW 60570,60660,60750,60840,60930,61020,61110,61200,61290,61380,61470,61560 { 673 … 684 }
 DW 61650,61740,61830,61920,62010,62100,62190,62280,62370,62460,62550,62640 { 685 … 696 }
 DW 62730,62820,62910,63000,63090,63180,63270,63360,63450,63540,63630,63720 { 697 … 708 }
 DW 63810,63900,63990,64080,64170,64260,64350,64440,64530,64620,64710,64800 { 709 … 720 }
 DW 64890,64980,65070,65160,65250,65340,65430,65520                         { 721 … 728 }
END;

Procedure SetMode360x240c256;Begin
 ASM
   { Fixe le mode graphique 320x200 en 256 couleurs }
  MOV AX,0013h
  INT 10h
   { Reprogramme les registres pour le mode 360x240 en 256 couleurs }
  MOV DX,03C4h
  MOV AX,0604h
  OUT DX,AX
  MOV AX,0100h
  OUT DX,AX
  MOV DX,03C2h
  MOV AL,0E7h
  OUT DX,AL
  MOV DX,03C4h
  MOV AX,0300h
  OUT DX,AX
  MOV DX,03D4h
  MOV AL,011h
  OUT DX,AL
  INC DX
  IN  AL,DX
  AND AL,07Fh
  OUT DX,AL
  MOV DX,03D4h
  CLD
  JMP @Next
@DataSeq:
  DW 06B00h    { Total horizontal }
  DW 05901h    { Horizontal affich‚ }
  DW 05A02h    { D‚but de la p‚riode de blanc horizontal }
  DW 08E03h    { Fin de la p‚riode de blanc horizontal }
  DW 05E04h    { Position de retour de balayage horizontal }
  DW 08A05h    { Fin de retour de balyage horizontal }
  DW 00D06h    { Total vertical }
  DW 03E07h    { Bit 8 et 9 compl‚mentaires }
  DW 04109h    { Hauteur d'une cellule }
  DW 0EA10h    { Ligne de d‚clenchement du retour vertical de balayage }
  DW 0AC11h    { Ligne o— s'arrˆte le retour de balayage vertical et bit de protection }
  DW 0DF12h    { DerniŠre ligne de balayage affich‚e }
  DW 02D13h    { ®Offset¯ entre 2 lignes }
  DW 00014h    { Adressage en double mot ferm‚ }
  DW 0E715h    { Position de d‚part vertical o— le rayon cathodique est d‚sactiv‚ }
  DW 00616h    { Position de fin vertical o— le rayon cathodique est d‚sactiv‚ }
  DW 0E317h    { Fixe le mode octet activ‚ }
@Next:
  MOV SI,Offset @DataSeq
  MOV CX,17
  PUSH DS
   PUSH CS
   POP DS
@@1:
   LODSW
   OUT DX,AX
   LOOP @@1
  POP DS
 END;
 MemW[0:$44A]:=45;
 Mem[0:$484]:=30;
 Mem[0:$485]:=8;
End;

{ Constante de plane 0 }

Procedure Plane0;Assembler;ASM
 DB 0,3,2,1
END;

{ Constante de plane 1 }

Procedure Plane1;Assembler;ASM
 DB 1,0,3,2
END;

{ Constante de plane 2 }

Procedure Plane2;Assembler;ASM
 DB 2,1,0,3
END;

{ Constante de plane 3 }

Procedure Plane3;Assembler;ASM
 DB 3,2,1,0
END;

{ Cette proc‚dure permet de lire une partie de l'‚cran … partir d'un
 tampon de fa‡on totalement lin‚aire (et non pas par groupe de quatre
 comme les routines de Hacker!). Ainsi le premier offset lin‚aire
 correspondra au pixel (0,0), le deuxiŠme au pixel (1,0) et ainsi
 de suite...
}

Procedure ReadBank(OffsetLinear:LongInt;L:Word;Var Buffer);Assembler;
Var
 Start,StartPlane:Word;
 Length:Integer;
ASM
 LES AX,Buffer
 MOV CX,ES
 OR  CX,AX
 JZ  @End
 PUSH DS
  MOV AX,L
  {$IFOPT G+}
   SHR AX,2
  {$ELSE}
   SHR AX,1
   SHR AX,1
  {$ENDIF}
  MOV Length,AX
  DEC L
  LES AX,OffsetLinear
  MOV DX,ES
  MOV BX,AX
  AND BX,3
  MOV StartPlane,BX
  SHR DX,1
  RCR AX,1
  SHR DX,1
  RCR AX,1
  SUB AX,BX
  MOV Start,AX
  {$IFDEF DPMI}
   MOV DS,SegA000
  {$ELSE}
   MOV DS,DataVideo.MIV.SegVideo
  {$ENDIF}
  CLD
@Restart:
   { Fixe la plage 0 }
  MOV DX,03CEh
  MOV AX,4+(0 shl 8)
  OUT DX,AX
   { Calcule le point de d‚part dans le tampon... ®P <- _AX¯ }
  MOV BX,StartPlane
  MOV AL,Byte Ptr Plane0[BX]
  XOR AH,AH
   { Calcul le suppl‚ment de P1 ®_DI:=Byte(StartPlane>0);¯ }
  XOR SI,SI
  OR  BL,BL
  JZ  @0
  INC SI
@0:
   { Calcul l'incr‚mentation de P1 ®_DI+:=Start+StartPlane;¯ }
  ADD SI,Start
  ADD SI,BX
   { Calcul le ®LenSub¯ ®_CX:=(L ï 3 < 3) ï (L ï 3 >= P) ? 1 : 0;¯}
  XOR CX,CX
  MOV DX,L
  AND DX,3
  CMP DX,3
  JNB @1
  CMP DX,AX
  JNAE @1
  INC CX
@1:{For J:=0to(Len)do Begin
    Buffer[P]:=Mem[_A000:P1];
    Inc(P,4);Inc(P1)
   End;}
  LES DI,Buffer
  ADD DI,AX
  ADD CX,Length
  JCXZ @3
@2:
  MOVSB
  INC DI
  INC DI
  INC DI
  LOOP @2
@3:
   { Fixe la plage 1 }
  MOV DX,03CEh
  MOV AX,4+(1 shl 8)
  OUT DX,AX
   { Calcule le point de d‚part dans le tampon...}
  MOV BX,StartPlane
  MOV AL,Byte Ptr Plane1[BX]
  XOR AH,AH
   { Calcul le suppl‚ment de P1 ®_DI:=Byte(StartPlane>1);¯ }
  XOR SI,SI
  CMP BL,1
  JNA @0b
  INC SI
@0b:
   { Calcul l'incr‚mentation de P1 ®_DI+:=Start+StartPlane;¯ }
  ADD SI,Start
  ADD SI,BX
   { Calcul le LenSub ®_CX:=(L ï 3 < 3) ï (L ï 3 >= P) ? 1 : 0;¯}
  XOR CX,CX
  MOV DX,L
  AND DX,3
  CMP DX,3
  JNB @1b
  CMP DX,AX
  JNAE @1b
  INC CX
@1b:
   {For J:=0to(Len)do Begin
    Buffer[P]:=Mem[_A000:P1];
    Inc(P,4);Inc(P1)
   End;}
  LES DI,Buffer
  ADD DI,AX
  ADD CX,Length
  JCXZ @3b
@2b:
  MOVSB
  INC DI
  INC DI
  INC DI
  LOOP @2b
@3b:
   { Fixe la plage 2 }
  MOV DX,03CEh
  MOV AX,4+(2 shl 8)
  OUT DX,AX
   { Calcule le point de d‚part dans le tampon...}
  MOV BX,StartPlane
  MOV AL,Byte Ptr Plane2[BX]
  XOR AH,AH
   { Calcul le suppl‚ment de P1 ®_DI:=Byte(StartPlane>2);¯ }
  XOR SI,SI
  CMP BL,2
  JNA @0c
  INC SI
@0c:
   { Calcul l'incr‚mentation de P1 ®_DI+:=Start+StartPlane;¯ }
  ADD SI,Start
  ADD SI,BX
   { Calcul le LenSub ®_CX:=(L ï 3 < 3) ï (L ï 3 >= P) ? 1 : 0;¯}
  XOR CX,CX
  MOV DX,L
  AND DX,3
  CMP DX,3
  JNB @1c
  CMP DX,AX
  JNAE @1c
  INC CX
@1c:
  LES DI,Buffer
  ADD DI,AX
  ADD CX,Length
  JCXZ @3c
@2c:
  MOVSB
  INC DI
  INC DI
  INC DI
  LOOP @2c
@3c:
   { Fixe la plage 3 }
  MOV DX,03CEh
  MOV AX,4+(3 shl 8)
  OUT DX,AX
   { Calcule le point de d‚part dans le tampon...}
  MOV BX,StartPlane
  MOV AL,Byte Ptr Plane3[BX]
  XOR AH,AH
   { Calcul l'incr‚mentation de P1 ®_DI:=Start+StartPlane;¯ }
  MOV SI,Start
  ADD SI,BX
   { Calcul le LenSub ®_CX:=(L ï 3 < 3) ï (L ï 3 >= P) ? 1 : 0;¯}
  XOR CX,CX
  MOV DX,L
  AND DX,3
  CMP DX,3
  JNB @1d
  CMP DX,AX
  JNAE @1d
  INC CX
@1d:
  LES DI,Buffer
  ADD DI,AX
  ADD CX,Length
  JCXZ @3d
@2d:
  MOVSB
  INC DI
  INC DI
  INC DI
  LOOP @2d
@3d:
 POP DS
@End:
END;

{ Cette proc‚dure permet d'‚crire une partie de l'‚cran … partir d'un
 tampon de fa‡on totalement lin‚aire (et non pas par groupe de quatre
 comme les routines de Hacker!). Ainsi le premier offset lin‚aire
 correspondra au pixel (0,0), le deuxiŠme au pixel (1,0) et ainsi
 de suite...
}

Procedure WriteBank(OffsetLinear:LongInt;L:Word;Var Buffer);Assembler;
Var
 Start,StartPlane:Word;
 Length:Integer;
ASM
 PUSH DS
  MOV AX,L
  {$IFOPT G+}
   SHR AX,2
  {$ELSE}
   SHR AX,1
   SHR AX,1
  {$ENDIF}
  MOV Length,AX
  DEC L
  LES AX,OffsetLinear
  MOV DX,ES
  MOV BX,AX
  AND BX,3
  MOV StartPlane,BX
  SHR DX,1
  RCR AX,1
  SHR DX,1
  RCR AX,1
  SUB AX,BX
  MOV Start,AX
  MOV ES,DataVideo.MIV.SegVideo
  CLD
@Restart:
   { Fixe la plage 0 }
  MOV DX,$3C4
  MOV AX,2+(1 shl 8)
  OUT DX,AX
   { Calcule le point de d‚part dans le tampon... ®P==_AX¯ }
  MOV BX,StartPlane
  MOV AL,Byte Ptr Plane0[BX]
  XOR AH,AH
   { Calcul le suppl‚ment de P1 ®_DI:=Byte(StartPlane>0);¯ }
  XOR DI,DI
  OR  BL,BL
  JZ  @0
  INC DI
@0:
   { Calcul l'incr‚mentation de P1 ®_DI+:=Start+StartPlane;¯ }
  ADD DI,Start
  ADD DI,BX
   { Calcul le LenSub ®_CX:=(L ï 3 < 3) ï (L ï 3 >= P) ? 1 : 0;¯}
  XOR CX,CX
  MOV DX,L
  AND DX,3
  CMP DX,3
  JNB @1
  CMP DX,AX
  JNAE @1
  INC CX
@1:{For J:=0to(Len)do Begin;Mem[_A000:P1]:=Buf[P];Inc(P,4);Inc(P1)End;}
  LDS SI,Buffer
  ADD SI,AX
  ADD CX,Length
  JCXZ @3
@2:LODSW
  INC SI
  INC SI
  STOSB
  LOOP @2
@3:
   { Fixe la plage 1 }
  MOV DX,$3C4
  MOV AX,2+(2 shl 8)
  OUT DX,AX
   { Calcule le point de d‚part dans le tampon...}
  MOV BX,StartPlane
  MOV AL,Byte Ptr Plane1[BX]
  XOR AH,AH
   { Calcul le suppl‚ment de P1 ®_DI:=Byte(StartPlane>1);¯ }
  XOR DI,DI
  CMP BL,1
  JNA @0b
  INC DI
@0b:
   { Calcul l'incr‚mentation de P1 ®_DI+:=Start+StartPlane;¯ }
  ADD DI,Start
  ADD DI,BX
   { Calcul le LenSub ®_CX:=(L ï 3 < 3) ï (L ï 3 >= P) ? 1 : 0;¯}
  XOR CX,CX
  MOV DX,L
  AND DX,3
  CMP DX,3
  JNB @1b
  CMP DX,AX
  JNAE @1b
  INC CX
@1b:
   {For J:=0to(Len)do Begin;Mem[_A000:P1]:=Buf[P];Inc(P,4);Inc(P1)End;}
  LDS SI,Buffer
  ADD SI,AX
  ADD CX,Length
  JCXZ @3b
@2b:
  LODSW
  INC SI
  INC SI
  STOSB
  LOOP @2b
@3b:
   { Fixe la plage 2 }
  MOV DX,03C4h
  MOV AX,2+(4 shl 8)
  OUT DX,AX
   { Calcule le point de d‚part dans le tampon...}
  MOV BX,StartPlane
  MOV AL,Byte Ptr Plane2[BX]
  XOR AH,AH
   { Calcul le suppl‚ment de P1 ®_DI:=Byte(StartPlane>2);¯ }
  XOR DI,DI
  CMP BL,2
  JNA @0c
  INC DI
@0c:
   { Calcul l'incr‚mentation de P1 ®_DI+:=Start+StartPlane;¯ }
  ADD DI,Start
  ADD DI,BX
   { Calcul le LenSub ®_CX:=(L ï 3 < 3) ï (L ï 3 >= P) ? 1 : 0;¯}
  XOR CX,CX
  MOV DX,L
  AND DX,3
  CMP DX,3
  JNB @1c
  CMP DX,AX
  JNAE @1c
  INC CX
@1c:
   {For J:=0to(Len)do Begin
    Mem[_A000:P1]:=Buffer[P];
    Inc(P,4);Inc(P1)
   End;}
  LDS SI,Buffer
  ADD SI,AX
  ADD CX,Length
  JCXZ @3c
@2c:LODSW
  INC SI
  INC SI
  STOSB
  LOOP @2c
@3c:
   { Fixe la plage 3 }
  MOV DX,03C4h
  MOV AX,2+(8 shl 8)
  OUT DX,AX
   { Calcule le point de d‚part dans le tampon...}
  MOV BX,StartPlane
  MOV AL,Byte Ptr Plane3[BX]
  XOR AH,AH
   { Calcul le suppl‚ment de P1 ®_DI:=Byte(StartPlane>3);¯ }
  XOR DI,DI
  CMP BL,3
  JNA @0d
  INC DI
@0d:
   { Calcul l'incr‚mentation de P1 ®_DI+:=Start+StartPlane;¯ }
  ADD DI,Start
  ADD DI,BX
   { Calcul le LenSub ®_CX:=(L ï 3 < 3) ï (L ï 3 >= P) ? 1 : 0;¯}
  XOR CX,CX
  MOV DX,L
  AND DX,3
  CMP DX,3
  JNB @1d
  CMP DX,AX
  JNAE @1d
  INC CX
@1d:
   {For J:=0to(Len)do Begin;Mem[_A000:P1]:=Buf[P];Inc(P,4);Inc(P1)End;}
  LDS SI,Buffer
  ADD SI,AX
  ADD CX,Length
  JCXZ @3d
@2d:
  LODSW
  INC SI
  INC SI
  STOSB
  LOOP @2d
@3d:
 POP DS
END;

{ Cette proc‚dure permet d'effacer une partie de l'‚cran de fa‡on
 totalement lin‚aire (et non pas par groupe de quatre comme les
 routines de Hacker!). Ainsi le premier offset lin‚aire correspondra
 au pixel (0,0), le deuxiŠme au pixel (1,0) et ainsi de suite...
}

Procedure FillBank(OffsetLinear:LongInt;L,Color:Word);Assembler;
Var
 Start,StartPlane:Word;
 Length:Integer;
ASM
 MOV AX,L
 {$IFOPT G+}
  SHR AX,2
 {$ELSE}
  SHR AX,1
  SHR AX,1
 {$ENDIF}
 MOV Length,AX
 DEC L
 LES AX,OffsetLinear
 MOV DX,ES
 MOV BX,AX
 AND BX,3
 MOV StartPlane,BX
 SHR DX,1
 RCR AX,1
 SHR DX,1
 RCR AX,1
 SUB AX,BX
 MOV Start,AX
 MOV ES,DataVideo.MIV.SegVideo
 CLD
@Restart:
  { Fixe la plage 0 }
 MOV DX,03C4h
 MOV AX,2+(1 shl 8)
 OUT DX,AX
  { Calcule le point de d‚part dans le tampon... ®P <- _AX¯ }
 MOV BX,StartPlane
 MOV AL,Byte Ptr Plane0[BX]
 XOR AH,AH
  { Calcul le suppl‚ment de P1 ®_DI:=Byte(StartPlane>0);¯ }
 XOR DI,DI
 OR  BL,BL
 JZ  @0
 INC DI
@0:
  { Calcul l'incr‚mentation de P1 ®_DI+:=Start+StartPlane;¯ }
 ADD DI,Start
 ADD DI,BX
  { Calcul le LenSub ®_CX:=(L ï 3 < 3) ï (L ï 3 >= P) ? 1 : 0;¯}
 XOR CX,CX
 MOV DX,L
 AND DX,3
 CMP DX,3
 JNB @1
 CMP DX,AX
 JNAE @1
 INC CX
@1:{For J:=0to(Length)do Begin
     Mem[_A000:P1]:=Color;
     Inc(P1)
    End;}
 ADD CX,Length
 MOV AL,Byte Ptr Color
 MOV AH,AL
 SHR CX,1
 REP STOSW
 ADC CX,CX
 REP STOSB
  { Fixe la plage 1 }
 MOV DX,03C4h
 MOV AX,2+(2 shl 8)
 OUT DX,AX
  { Calcule le point de d‚part dans le tampon...}
 MOV BX,StartPlane
 MOV AL,Byte Ptr Plane1[BX]
 XOR AH,AH
  { Calcul le suppl‚ment de P1 ®_DI:=Byte(StartPlane>1);¯ }
 XOR DI,DI
 CMP BL,1
 JNA @0b
 INC DI
@0b:
  { Calcul l'incr‚mentation de P1 ®_DI+:=Start+StartPlane;¯ }
 ADD DI,Start
 ADD DI,BX
  { Calcul le LenSub ®_CX:=(L ï 3 < 3) ï (L ï 3 >= P) ? 1 : 0;¯}
 XOR CX,CX
 MOV DX,L
 AND DX,3
 CMP DX,3
 JNB @1b
 CMP DX,AX
 JNAE @1b
 INC CX
@1b:
  {For J:=0to(Length)do Begin
    Mem[_A000:P1]:=Color;
    Inc(P1)
   End;}
 ADD CX,Length
 MOV AL,Byte Ptr Color
 MOV AH,AL
 SHR CX,1
 REP STOSW
 ADC CX,CX
 REP STOSB
  { Fixe la plage 2 }
 MOV DX,03C4h
 MOV AX,2+(4 shl 8)
 OUT DX,AX
  { Calcule le point de d‚part dans le tampon...}
 MOV BX,StartPlane
 MOV AL,Byte Ptr Plane2[BX]
 XOR AH,AH
  { Calcul le suppl‚ment de P1 ®_DI:=Byte(StartPlane>2);¯ }
 XOR DI,DI
 CMP BL,2
 JNA @0c
 INC DI
@0c:
  { Calcul l'incr‚mentation de P1 ®_DI+:=Start+StartPlane;¯ }
 ADD DI,Start
 ADD DI,BX
  { Calcul le LenSub ®_CX:=(L ï 3 < 3) ï (L ï 3 >= P) ? 1 : 0;¯}
 XOR CX,CX
 MOV DX,L
 AND DX,3
 CMP DX,3
 JNB @1c
 CMP DX,AX
 JNAE @1c
 INC CX
@1c:
 ADD CX,Length
 MOV AL,Byte Ptr Color
 MOV AH,AL
 SHR CX,1
 REP STOSW
 ADC CX,CX
 REP STOSB
  { Fixe la plage 3 }
 MOV DX,03C4h
 MOV AX,2+(8 shl 8)
 OUT DX,AX
  { Calcule le point de d‚part dans le tampon...}
 MOV BX,StartPlane
 MOV AL,Byte Ptr Plane3[BX]
 XOR AH,AH
  { Calcul l'incr‚mentation de P1 ®_DI:=Start+StartPlane;¯ }
 MOV DI,Start
 ADD DI,BX
  { Calcul le LenSub ®_CX:=(L ï 3 < 3) ï (L ï 3 >= P) ? 1 : 0;¯}
 XOR CX,CX
 MOV DX,L
 AND DX,3
 CMP DX,3
 JNB @1d
 CMP DX,AX
 JNAE @1d
 INC CX
@1d:
 ADD CX,Length
 MOV AL,Byte Ptr Color
 MOV AH,AL
 SHR CX,1
 REP STOSW
 ADC CX,CX
 REP STOSB
END;

{ Cette proc‚dure permet d'effacer l'‚cran avec la couleur d‚sir‚
}

Procedure ClearScreen(Color:Byte);Assembler;ASM
 CLD
 MOV AL,Color
 MOV AH,AL
 MOV CX,32000
 XOR DI,DI
 {$IFDEF DPMI}
  MOV ES,SegA000
 {$ELSE}
  MOV ES,DataVideo.MIV.SegVideo
 {$ENDIF}
 REP STOSW
END;

{ Cette proc‚dure permet d'effacer l'‚cran avec la couleur noir.
}

Procedure ClearScreenBlack;Begin
 ClearScreen(0);
End;

{ Cette proc‚dure permet de tracer une ligne de longueur ®Length¯
 … partir de la coordonn‚e (X,Y) avec la couleur ®Color¯.
}

Procedure ClearLineHor(X,Y,Length:Word;Color:Byte);Assembler;ASM
 MOV BX,Y
 CMP BX,DataVideo.MIV.NumYPixels
 JAE @End
 SHL BX,1
 MOV AX,Word Ptr RealRawY[BX]
 ADD AX,DataVideo.MIV.AddrPage
 XOR DX,DX
 SHL AX,1
 RCL DX,1
 SHL AX,1
 RCL DX,1
 ADD AX,X
 ADC DX,0
 PUSH DX
 PUSH AX
 PUSH Length
 PUSH Word Ptr Color
 CALL FillBank
@End:
END;

{ Cette proc‚dure permet d'afficher un pixel … l'‚cran.
}

Procedure SetPixel(X,Y:Word;Color:Byte);Assembler;ASM
 TEST X,8000h
 JNZ @End
 {$IFDEF DPMI}
  MOV ES,SegA000
 {$ELSE}
  MOV ES,DataVideo.MIV.SegVideo
 {$ENDIF}
 MOV CX,X
 AND CX,3
 MOV AX,1
 SHL AX,CL
 MOV AH,AL
 MOV DX,3C4h
 MOV AL,2
 OUT DX,AX
 MOV DI,Y
 SHL DI,1
 MOV DI,Word Ptr RealRawY[DI]
 MOV AX,X
 {$IFOPT G+}
  SHR AX,2
 {$ELSE}
  SHR AX,1
  SHR AX,1
 {$ENDIF}
 ADD DI,AX
 ADD DI,DataVideo.MIV.AddrPage
 MOV AL,Byte Ptr Color
 STOSB
@End:
END;

{ Cette proc‚dure permet de programmer une palette de couleur RVB (RGB)
 avec une couleur des valeurs comprise entre 0 et 255.
}

Procedure SetPaletteRGB(Color,R,G,B:Byte);Assembler;ASM
 MOV DX,3C8h
 MOV AL,Byte Ptr Color
 OUT DX,AL
 INC DX
 MOV AL,R
 {$IFOPT G+}
  SHR AL,2
 {$ELSE}
  SHR AL,1
  SHR AL,1
 {$ENDIF}
 OUT DX,AL
 MOV AL,G
 {$IFOPT G+}
  SHR AL,2
 {$ELSE}
  SHR AL,1
  SHR AL,1
 {$ENDIF}
 OUT DX,AL
 MOV AL,B
 {$IFOPT G+}
  SHR AL,2
 {$ELSE}
  SHR AL,1
  SHR AL,1
 {$ENDIF}
 OUT DX,AL
END;

Var I:Word;

BEGIN
 SetMode360x240c256;
 ClearScreenBlack;
 For I:=0to 239do SetPixel(I,I,I);
 ClearLineHor(20,10,100,15);
  { Attend que l'utilisateur presse une touche }
 ASM
  XOR AX,AX
  INT 16h
 END;
END.