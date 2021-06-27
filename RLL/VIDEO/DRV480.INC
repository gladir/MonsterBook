{Drv480.Inc}

Procedure RawTxtY;Forward;
Procedure RawY;Forward;
Procedure RealRawY;Forward;

Procedure _Driver480;Assembler;ASM
 JMP Init.Near
 JMP BarChrHor.Near
 JMP BarChrVer.Near
 JMP BarSpcHor.Near
 JMP BarSpcVer.Near
 JMP BarTxtHor.Near
 JMP Circle.Near
 JMP CloseCur.Near
 JMP ClrLnHor.Near
 JMP ClrLnHorImg.Near
 JMP ClrWn.Near
 JMP ClrScr.Near
 JMP CopT8Bin.Near
 JMP Copy8Bin.Near
 JMP FillBox.Near
 JMP GetAttr.Near
 JMP GetChr.Near
 JMP GetCube.Near
 JMP GetLnHorImg.Near
 JMP GetPixel.Near
 JMP GetSizeSmlImg.Near
 JMP GetSmlImg.Near
 JMP MoveText.Near
 RETF 4{PCopy(S,T:Byte)}
 RETF 10{PCopy2Img(Page:Byte;X1,Y1,X2,Y2:Word)}
 JMP PutCharGAttr.Near
 JMP PutFillBox.Near
 JMP PutFillCircle.Near
 JMP PutFillRoundRect.Near
 JMP PutLn.Near
 JMP PutLnHor.Near
 JMP PutRect.Near
 JMP PutRoundRect.Near
 JMP PutSmlImg.Near
 JMP PutSprite.Near
 JMP PutTxtXY.Near
 JMP PutTxtXYUnKr.Near
 JMP SetAttr.Near
 JMP SetBackgroundColor.Near
 JMP SetBlink.Near
 JMP SetBorderColor.Near
 JMP SetBytesPerLn.Near
 JMP SetChr.Near
 RETF 2 {SetChrWidth(L:Byte)}
 JMP SetCube.Near
 JMP SetCur.Near
 JMP SetCurPos.Near
 RETF 2          {SetDblMtx}
 JMP SetChr.Near {SetExtChr}
 JMP SetCube.Near{SetExtCube}
 JMP SetGCube.Near
 JMP SetGCubeT.Near
 JMP SetHorizontalScale.Near
 RETF 12 {SetMatrix(Palette,Height:Byte;Number,Start:Wd;Var X:TByte)}
 RETF   {SetModeMtx}
 NOP
 NOP
 RETF   {SetModeScr}
 NOP
 NOP
 JMP SetPalBlk.Near
 JMP SetPaletteRGB.Near
 JMP SetPalRGB.Near
 RETF 2 {SetPg(Pg:Byte)}
 JMP SetPixel.Near
 RETF 2 {SetUnderline(X:Bool)}
 JMP SetVerticalScale.Near
 RETF 2 {SetVisualPg(Pg:Byte)}
 JMP SetWriteMode.Near
 JMP SplitScreen.Near
 RETF 2 {SetBnkPg(Pg:Byte)}
 JMP ReadBnk.Near
 JMP WriteBnk.Near
 JMP FillBnk.Near
 JMP Done.Near
  {Gestion des Icons/Luxe}
 RETF 2{SetLuxe(X:Bool)}
 JMP IsLuxe.Near
 JMP CloseIcon.Near
 JMP DownIcon.Near
 JMP LeftIcon.Near
 JMP RightIcon.Near
 JMP SelIcon.Near
 JMP UnSelIcon.Near
 JMP UpIcon.Near
 JMP ZoomIcon.Near
 JMP DossierDocumentIcon.Near
 JMP DossierProgramIcon.Near
  {}
 DW Offset RawTxtY
 DW Offset RawY
 DW Offset RealRawY
END;

{$I PhysDef.Inc}

Procedure DataVideo;Assembler;ASM
 DW 0{Mode:Mode vid‚o actuel (vm???)}
 DB No{IbmLogic:Mode dans la logique IBM (pas hors cas texte … la SVGA...)}
 DB No{BiosSupport:Mode support‚ par le Bios (Par exemple, la GS en 16 couleurs le Bios ne le connaŒt pas)}
 DB Ya{Colr:Mode couleur? Sinon monochrome for‡‚ment...}
 DB Ya{Graf:Mode graphique? Sinon texte}
 DB Ya{Direct:M‚thode directe? Sinon Bios ou Dos}
 DB No{Blink:Clignotement}
 DB No{Snow:Neige lors de l'envoie de donn‚e dans le tampon vid‚o?}
 DW $A000{SegV:Segment vid‚o (A000h,B000h,B800h,...)}
 DB 16{HeightChr:Hauteur de la police de caractŠre actuel}
 DW 360{NmXPixels:Nombre de pixels horizontal qu'affiche l'‚cran}
 DW 480{NmYPixels:Nombre de pixels vertical qu'affiche l'‚cran}
 DB 50,30{NmXTxts,NmYTxts:Nombre de caractŠre texte horizontal/vertical qu'affiche l'‚cran}
 DB 1{NmVidPgs:Nombre de page vid‚o que supporte le mode actuel}
 DD 256{NmColrs:Nombre de couleurs affich‚}
 DB 8{BitsPerPixel:Nombre de Bit(s) utilis‚ pour l'affichage d'un pixel}
 DW 80{BytesPerLn:Nombre d'octet par ligne affich‚ (trŠs relatif en VGA...)}
 DB 0{Pg:Num‚ro de la page vid‚o de travail}
 DW 0{AddrPg:En texte, adresse en m‚moire vid‚o de la page actuel}
 DB 0{ShowPg:Num‚ro de la page vid‚o actuellement affich‚}
 DD 0{TxtMtx:Pointeur sur la police de caractŠre courante}
 DD 172800{ScrSize:Taille de l'‚cran}
 DW 0{SizeBnk:Taille d'un page de la banque (0=64Ko)}
 DW 0{SegBuf:Segment du tampon d'acc‚l‚ration}
 DB 0{IsDblMtx:Y a-t-il une police de 512 caractŠres?}
 DB 0,0 {XCur,YCur:Position actuel du curseur}
 DB 0,0 {StartCur,EndCur:D‚but et fin du curseur}
END;

Procedure RawTxtY;Assembler;ASM
 DW    0,  50, 100, 150, 200, 250, 300, 350, 400, 450, 500, 550, 600, 650, 700
 DW  750, 800, 850, 900, 950,1000,1050,1100,1150,1200,1250, 1300,1350,1400,1450
 DW    0,  50, 100, 150, 200, 250, 300, 350, 400, 450, 500, 550, 600, 650, 700
 DW  750, 800, 850, 900, 950,1000,1050,1100,1150,1200,1250, 1300,1350,1400,1450
 DW    0,  50, 100, 150, 200, 250, 300, 350, 400, 450, 500, 550, 600, 650, 700
 DW  750, 800, 850, 900, 950,1000,1050,1100,1150,1200,1250, 1300,1350,1400,1450
 DW    0,  50, 100, 150, 200, 250, 300, 350, 400, 450, 500, 550, 600, 650, 700
 DW  750, 800, 850, 900, 950,1000,1050,1100,1150,1200,1250, 1300,1350,1400,1450
 DW Offset PhysVideo
END;

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

Procedure RawY;Assembler;ASM
 DW   0*16,  1*16,  2*16,  3*16,  4*16,  5*16,  6*16,  7*16,  8*16,  9*16, 10*16, 11*16, 12*16, 13*16, 14*16, 15*16
 DW  16*16, 17*16, 18*16, 19*16, 20*16, 21*16, 22*16, 23*16, 24*16, 25*16, 26*16, 27*16, 28*16, 29*16, 30*16, 31*16
 DW  32*16, 33*16, 34*16, 35*16, 36*16, 37*16, 38*16, 39*16, 40*16, 41*16, 42*16, 43*16, 44*16, 45*16, 46*16, 47*16
 DW  48*16, 49*16, 50*16, 51*16, 52*16, 53*16, 54*16, 55*16, 56*16, 57*16, 58*16, 59*16, 60*16, 61*16, 62*16, 63*16
 DW  64*16, 65*16, 66*16, 67*16, 68*16, 69*16, 70*16, 71*16, 72*16, 73*16, 74*16, 75*16, 76*16, 77*16, 78*16, 79*16
 DW  80*16, 81*16, 82*16, 83*16, 84*16, 85*16, 86*16, 87*16, 88*16, 89*16, 90*16, 91*16, 92*16, 93*16, 94*16, 95*16
 DW  96*16, 97*16, 98*16, 99*16,100*16,101*16,102*16,103*16,104*16,105*16,106*16,107*16,108*16,109*16,110*16,111*16
 DW 112*16,113*16,114*16,115*16,116*16,117*16,118*16,119*16,120*16,121*16,122*16,123*16,124*16,125*16,126*16,127*16
 DW 128*16,129*16,130*16,131*16,132*16,133*16,134*16,135*16,136*16,137*16,138*16,139*16,140*16,141*16,142*16,143*16
 DW 144*16,145*16,146*16,147*16,148*16,149*16,150*16,151*16,152*16,153*16,154*16,155*16,156*16,157*16,158*16,159*16
 DW 160*16,161*16,162*16,163*16,164*16,165*16,166*16,167*16,168*16,169*16,170*16,171*16,172*16,173*16,174*16,175*16
 DW 176*16,177*16,178*16,179*16,180*16,181*16,182*16,183*16,184*16,185*16,186*16,187*16,188*16,189*16,190*16,191*16
 DW 192*16,193*16,194*16,195*16,196*16,197*16,198*16,199*16,200*16,201*16,202*16,203*16,204*16,205*16,206*16,207*16
 DW 208*16,209*16,210*16,211*16,212*16,213*16,214*16,215*16,216*16,217*16,218*16,219*16,220*16,221*16,222*16,223*16
 DW 224*16,225*16,226*16,227*16,228*16,229*16,230*16,231*16,232*16,233*16,234*16,235*16,236*16,237*16,238*16,239*16
 DW 240*16,241*16,242*16,243*16,244*16,245*16,246*16,247*16,248*16,249*16,250*16,251*16,252*16,253*16,254*16,255*16
END;

Procedure BarChrHor;Var I:Byte;Begin;For I:=X1 to(X2)do SetChr(I,Y,Chr)End;
Procedure BarChrVer;Var J:Byte;Begin;For J:=Y1 to(Y2)do SetChr(X,J,Chr)End;

{$I bhsx256.Inc}

Procedure BarSpcVer;Assembler;ASM
 MOV AL,X
 XOR AH,AH
 {$IFOPT G+}SHL AX,3{$ELSE}SHL AX,1;SHL AX,1;SHL AX,1{$ENDIF}
 PUSH AX
 MOV BL,Y1
 XOR BH,BH
 SHL BX,1
 MOV AX,Word Ptr RawY[BX]
 PUSH AX
 MOV AL,X
 XOR AH,AH
 INC AX
 {$IFOPT G+}SHL AX,3{$ELSE}SHL AX,1;SHL AX,1;SHL AX,1{$ENDIF}
 DEC AX
 PUSH AX
 MOV BL,Y2
 XOR BH,BH
 INC BX
 SHL BX,1
 MOV AX,Word Ptr RawY[BX]
 DEC AX
 PUSH AX
 MOV AL,Attr
 XOR AH,AH
 MOV CL,4
 SHR AX,CL
 PUSH AX
 PUSH CS
 CALL Near Ptr PutFillBox
 {Mise … jour du tampon d'acc‚l‚ration}
 XOR AX,AX
 MOV BL,Y1
 XOR BH,BH
 SHL BX,1
 MOV DI,Word Ptr RawTxtY[BX]
 MOV AL,DataVideo.MIV.NumXTexts
 MOV ES,DataVideo.MIV.SegBuffer
 DEC AX
 SHL AX,1
 MOV SI,AX
 MOV BL,X
 ADD DI,BX
 SHL DI,1
 MOV AL,' '
 MOV AH,Attr
 MOV CL,Y1
 MOV CH,Y2
@@Loop:
 STOSW
 ADD DI,SI
 INC CL
 CMP CL,CH
 JBE @@Loop
END;

{$I Circle.Inc}
{$I ClsCurGr.Inc}

Procedure ClrLnHor;Assembler;ASM
 MOV BX,Y
 CMP BX,DataVideo.MIV.NumYPixels
 JAE @End
 SHL BX,1
 MOV AX,Word Ptr RealRawY[BX]
 {$IFNDEF __360x480c256}
  ADD AX,DataVideo.MIV.AddrPg
 {$ENDIF}
 XOR DX,DX
(* {$IFDEF __386__}
  DB 0Fh,0A4h,0C2h,02h {SHLD DX,AX,2}
 {$ELSE}*)
  SHL AX,1;RCL DX,1;SHL AX,1;RCL DX,1
(* {$ENDIF}*)
 ADD AX,X
 ADC DX,0
 PUSH DX
 PUSH AX
 PUSH L
 PUSH Kr
 PUSH CS
 CALL Near Ptr FillBnk
@End:
END;

Procedure ClrLnHorImg;
Var
 Ta:Byte;
 Xa,MX,MY,I:Word;
 TBuf:TByte Absolute Buffer;
Begin
 ASM
  MOV AX,DataVideo.MIV.NumXPixels
  MOV MX,AX
  MOV AX,DataVideo.MIV.NumYPixels
  MOV MY,AX
 END;
 If(X>=MX)or(Y>MY)Then Exit;
 If(X+L>MX)Then L:=MX-X;
 Case(BitsPerPixel)of
  4:For I:=0to(L-1)shr 1do Begin
   SetPixel(X,Y,TBuf[0]shr 4);
   Inc(X);
   SetPixel(X,Y,TBuf[0]and 15);
   Inc(X);
   ASM
    INC Word Ptr Buffer
   END;
  End;
  0:Begin
   MY:=TBuf[0];
   ASM INC Word Ptr Buffer;END;
   MX:=TBuf[0];
   ASM INC Word Ptr Buffer;END;
   For I:=0to(L-1)shr 3do Copy8Bin(X+(I shl 3),Y,TBuf[I],15,0);
   If L and 7>0Then Begin
    Ta:=TBuf[L-1]; Xa:=X+(L-1)shl 3;
    For I:=0to 7do Begin
     If ((Ta shr I)and 1)=1Then SetPixel(Xa+I,Y,MX)
                           Else SetPixel(Xa+I,Y,MY)
    End;
   End;
  End;
  Else ASM
   MOV BX,Y
   SHL BX,1
   MOV AX,Word Ptr RealRawY[BX]
   {$IFNDEF __360x480c256}
    ADD AX,DataVideo.MIV.AddrPg
   {$ENDIF}
   XOR DX,DX
 (*  {$IFDEF __386__}
    DB 0Fh,0A4h,0C2h,02h {SHLD DX,AX,2}
   {$ELSE}*)
    SHL AX,1;RCL DX,1;SHL AX,1;RCL DX,1
 (*  {$ENDIF}*)
   ADD AX,X
   ADC DX,0
   PUSH DX
   PUSH AX
   PUSH L
   PUSH Word Ptr Buffer[2]
   PUSH Word Ptr Buffer
   PUSH CS
   CALL Near Ptr WriteBnk
  END;
 End;
End;

{$I ClrWn256.Inc}

Procedure ClrScr;Assembler;ASM
 CLD
 MOV AL,Attr
 MOV CL,4
 SHR AL,CL
 MOV AH,AL
 MOV CX,32000
 XOR DI,DI
 {$IFDEF DPMI}
  MOV ES,SegA000
 {$ELSE}
  MOV ES,DataVideo.MIV.SegVideo
 {$ENDIF}
 REP STOSW
 XOR DI,DI
 MOV ES,DataVideo.MIV.SegBuffer
 MOV BL,DataVideo.MIV.NumYTexts
 XOR BH,BH
 SHL BX,1
 MOV CX,Word Ptr RawTxtY[BX]
 MOV AH,Attr
 MOV AL,' '
 REP STOSW
END;

{$I CpyNT256.Inc}
{$I BrTxt256.Inc}

Procedure FillBox;Var J:Byte;Begin
 For J:=Y1 to(Y2)do BarTxtHor(X1,J,X2,Chr,Attr);
End;

{$I GFXGETCH.INC}

Procedure GetLnHorImg;Assembler;ASM
 MOV BX,Y
 CMP BX,DataVideo.MIV.NumYPixels
 JAE @End
 SHL BX,1
 MOV AX,Word Ptr RealRawY[BX]
 {$IFNDEF __360x480c256}
  ADD AX,DataVideo.MIV.AddrPg
 {$ENDIF}
 XOR DX,DX
(* {$IFDEF __386__}
  DB 0Fh,0A4h,0C2h,02h {SHLD DX,AX,2}
 {$ELSE}*)
  SHL AX,1;RCL DX,1;SHL AX,1;RCL DX,1
(* {$ENDIF}*)
 ADD AX,X1
 ADC DX,0
 PUSH DX
 PUSH AX
 MOV CX,X2
 SUB CX,X1
 INC CX
 PUSH CX
 PUSH Word Ptr Buffer[2]
 PUSH Word Ptr Buffer
 PUSH CS
 CALL Near Ptr ReadBnk
@End:
END;

Function GetPixel;Assembler;ASM
 {$IFDEF DPMI}
  MOV ES,SegA000
 {$ELSE}
  MOV ES,DataVideo.MIV.SegVideo
 {$ENDIF}
 MOV CX,X
 AND CX,3
 MOV AH,CL
 MOV DX,3CEh
 MOV AL,4
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
 {$IFNDEF __360x480c256}
  ADD DI,DataVideo.MIV.AddrPg
 {$ENDIF}
 MOV AL,ES:[DI]
 XOR AH,AH
END;

Function GetSizeSmlImg;Assembler;ASM
 MOV AX,X2
 SUB AX,X1
 INC AX
 INC AX
 MOV BX,Y2
 SUB BX,Y1
 INC BX
 MUL BX
END;

Procedure GetSmlImg;Var TBuf:TByte Absolute Buffer;J,L,O:Wd;Begin
 L:=X2-X1+1;O:=0;
 For J:=0to(Y2-Y1)do Begin GetLnHorImg(X1,J+Y1,X2,TBuf[O]);Inc(O,L)End;
End;

Procedure RegWord;Assembler;ASM
 DB $6B,$59,$5A,$8E,$5E,$8A,$0D,$3E,$FF,$40,$FF,$FF
 DB $FF,$FF,$FF,$FF,$EA,$AC,$DF,$2D,$00,$E7,$06,$E3
END;

Procedure Init;Assembler;ASM
 MOV AX,0012h
 INT 10h
 XOR AX,AX
 MOV ES,AX
 LES AX,ES:[43h*4]
 MOV DataVideo.MIV.TxtMtx.Word,AX
 MOV DataVideo.MIV.TxtMtx.Word[2],ES
 MOV AX,0013h
 INT 10h
 MOV DX,3C4h
 MOV AL,4
 OUT DX,AL
 INC DX
 IN  AL,DX
 AND AL,0F7h
 OR  AL,4h
 OUT DX,AL
 MOV DL,0D4h
 MOV AL,14h
 OUT DX,AL
 INC DX
 IN  AL,DX
 AND AL,0BFh
 OUT DX,AL
 DEC DX
 MOV AL,17h
 OUT DX,AL
 INC DX
 IN  AL,DX
 OR  AL,40h
 OUT DX,AL
 MOV DL,0D4h
 MOV AL,9
 OUT DX,AL
 INC DX
 IN AL,DX
 AND AL,01110000b
 OUT DX,AL
  {Port[$3C4]:=4;Port[$3C5]:=6;}
 MOV DL,0C4h
 MOV AX,0604h
 OUT DX,AX
  {Port[$3C4]:=0;Port[$3C5]:=1;}
 MOV AX,0100h
 OUT DX,AX
  {Port[$3C2]:=$E7;}
 MOV DL,0C2h
 MOV AL,$E7
 OUT DX,AL
  {Port[$3C4]:=0;Port[$3C5]:=3;}
 MOV DL,0C4h
 MOV AX,0300h
 OUT DX,AX
  {D‚protŠge les registres CRTC: ®Port[$3D4]:=$11;Port[$3D5]:=Port[$3D5]and$7F;¯}
 MOV DL,$D4
 MOV AL,$11
 OUT DX,AL
 INC DX
 IN  AL,DX
 AND AL,$7F
 OUT DX,AL
 DEC DX
  {For I:=0to$17 do If RegWord[I]<>$FFThen Begin;Port[$3D4]:=I;Port[$3D5]:=RegWord[I]End}
 MOV CX,$18
 MOV AL,0
 XOR BX,BX
@9:
 MOV AH,Byte Ptr RegWord[BX]
 CMP AH,$FF
 JE  @10
 OUT DX,AX
@10:
 INC AL
 INC BX
 LOOP @9
 MOV BX,6000/16 { BUG: Le nombre doit ˆtre (50x30)x2=3000/16 paragraphes
		  mais il ne marche correctement qu'avec le double de ce
		  qu'il r‚clame r‚ellement en m‚moire. Il est fixer
		  temporaire … 4000 pour l'empˆcher de planter.}
 {$IFDEF Autonome}
  MOV AH,48h
  INT 21h
 {$ELSE}
  INT 9Bh
 {$ENDIF}
 JC  @2
 MOV ES,AX
 MOV DataVideo.MIV.SegBuffer,AX
 XOR DI,DI
 MOV AX,' '+(7 shl 8)
 MOV CX,3000 {3000}  {6000/2=3000}
 CLD
 REP STOSW
@2:
END;

{$I MoveT256.Inc}
{$I PutCharG.Inc}

Procedure PutFillBox;
{$IFDEF __360x480c256}
 Assembler;ASM
  MOV CX,Y1
 @1:
  PUSH CX
   PUSH X1
   PUSH CX
   PUSH X2
   PUSH Kr
   PUSH CS
   CALL Near Ptr PutLnHor
  POP CX
  INC CX
  CMP CX,Y2
  JBE @1
 END;
{$ELSE}
 Assembler;ASM
  MOV SI,X2
  SUB SI,X1
  INC SI
  MOV BX,Y1
  SHL BX,1
  MOV BX,Word Ptr RealRawY[BX]
  ADD BX,X1
  MOV DX,Y1
  CLD
  MOV AL,Byte Ptr Kr
  {$IFDEF DPMI}
   MOV ES,SegA000
  {$ELSE}
   MOV ES,DataVideo.MIV.SegV
  {$ENDIF}
@@Home:
  MOV DI,BX
  MOV CX,SI
  REP STOSB
  ADD BX,DataVideo.MIV.BytesPerLn
  INC DX
  CMP Y2,DX
  JAE @@Home
 END;
{$ENDIF}

Function AbsInt(I:Int):Int;Near;Assembler;ASM
 MOV AX,I
 OR AX,AX
 JGE @1
 NEG AX
@1:
END;

{$I FillCirc.Inc}
{$I FillRndR.Inc}

Procedure PutLn;Var D,DX,DY,I,J,Ainc,Binc,Ic:Int;Begin
 If(Y2=Y1)Then Begin PutLnHor(X1,Y1,X2,Kr);Exit;End;
 If AbsInt(X2-X1)<AbsInt(Y2-Y1)Then Begin
  If(Y1>Y2)Then ASM MOV AX,X1;XCHG AX,X2;MOV X1,AX;MOV AX,Y1;XCHG AX,Y2;MOV Y1,AX;END;
  If(X2>X1)Then Ic:=1 Else Ic:=-1;
  DY:=Y2-Y1;DX:=AbsInt(X2-X1);D:=(DX shl 1)-DY;Ainc:=(DX-DY)shl 1;Binc:=DX shl 1;J:=X1;
  SetPixel(X1,Y1,Kr);
  I:=Y1+1;
  While(I<=Y2)do Begin
   If D>=0Then Begin Inc(J,Ic);Inc(D,Ainc)End else Inc(D,Binc);
   SetPixel(J,I,Kr);
   Inc(I);
  End;
 End
  else
 Begin
  If(X1>X2)Then ASM MOV AX,X1;XCHG AX,X2;MOV X1,AX;MOV AX,Y1;XCHG AX,Y2;MOV Y1,AX;END;
  If(Y2>Y1)Then Ic:=1 else Ic:=-1;
  DX:=X2-X1;DY:=AbsInt(Y2-Y1);D:=(DY shl 1)-DX;AInc:=(DY-DX)shl 1;BInc:=DY shl 1;J:=Y1;
  SetPixel(X1,Y1,Kr);
  I:=X1+1;
  While(I<=X2)do Begin
   If D>=0Then Begin Inc(J,Ic);Inc(D,Ainc)End else Inc(D,Binc);
   SetPixel(I,J,Kr);
   Inc(I);
  End;
 End;
End;

{$I PutLnHor.Inc}
{$I PutRect.Inc}
{$I PutRndRe.Inc}

Procedure PutSmlImg;Var TBuf:TByte Absolute Buffer;J,I,L:Wd;Begin
 I:=0;L:=X2-X1+1;
 For J:=0to(Y2-Y1)do Begin ClrLnHorImg(X1,J+Y1,L,8,TBuf[I]);Inc(I,L)End;
End;

Procedure Plane0;Assembler;ASM DB 0,3,2,1;END;
Procedure Plane1;Assembler;ASM DB 1,0,3,2;END;
Procedure Plane2;Assembler;ASM DB 2,1,0,3;END;
Procedure Plane3;Assembler;ASM DB 3,2,1,0;END;

Procedure PutSprite;Assembler;Var Start,StartPlane,L,YP:Wd;Len:Int;aY:Long;ASM
 PUSH DS
  MOV AX,Y2
  SUB AX,Y1
  INC AX
  MOV YP,AX
  MOV AX,X2
  SUB AX,X1
  INC AX
  MOV L,AX
  {$IFOPT G+}
   SHR AX,2
  {$ELSE}
   SHR AX,1
   SHR AX,1
  {$ENDIF}
  MOV Len,AX
  MOV AX,L
  MOV BX,Y1
  SHL BX,1
  MOV AX,Word Ptr RealRawY[BX]
  ADD AX,DataVideo.MIV.AddrPage
  XOR DX,DX
(*  {$IFDEF __386__}
   DB 0Fh,0A4h,0C2h,02h {SHLD DX,AX,2}
  {$ELSE}*)
   SHL AX,1;RCL DX,1;SHL AX,1;RCL DX,1
(*  {$ENDIF}*)
  ADD AX,X1
  ADC DX,0
  MOV Word Ptr aY,AX
  MOV Word Ptr aY[2],DX
  MOV ES,DataVideo.MIV.SegVideo
  CLD
  DEC L
@000:
  MOV BX,AX
  AND BX,3
  MOV StartPlane,BX
(*  {$IFDEF __386__}
   DB 0Fh,0ACh,0C2h,02h {SHRD DX,AX,2}
  {$ELSE}*)
   SHR DX,1;RCR AX,1;SHR DX,1;RCR AX,1
(*  {$ENDIF}*)
  SUB AX,BX
  MOV Start,AX
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
  ADD CX,Len
  JCXZ @3
@2:LODSB
  INC SI
  INC SI
  INC SI
  OR AL,AL
  JE @x
  STOSB
  LOOP @2
  JMP @3
@x:
  INC DI
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
  ADD CX,Len
  JCXZ @3b
@2b:LODSB
  INC SI
  INC SI
  INC SI
  OR AL,AL
  JE @xb
  STOSB
  LOOP @2b
  JMP @3b
@xb:
  INC DI
  LOOP @2b
@3b:
   { Fixe la plage 2 }
  MOV DX,$3C4
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
   {For J:=0to(Len)do Begin;Mem[_A000:P1]:=Buf[P];Inc(P,4);Inc(P1)End;}
  LDS SI,Buffer
  ADD SI,AX
  ADD CX,Len
  JCXZ @3c
@2c:LODSB
  INC SI
  INC SI
  INC SI
  OR AL,AL
  JE @xc
  STOSB
  LOOP @2c
  JMP @3c
@xc:
  INC DI
  LOOP @2c
@3c:
   { Fixe la plage 3 }
  MOV DX,$3C4
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
  ADD CX,Len
  JCXZ @3d
@2d:LODSB
  INC SI
  INC SI
  INC SI
  OR AL,AL
  JE @xd
  STOSB
  LOOP @2d
  JMP @3d
@xd:
  INC DI
  LOOP @2d
@3d:
  MOV AX,L
  INC AX
  ADD Word Ptr Buffer,AX
  MOV AX,DataVideo.MIV.BytesPerLine
  {$IFOPT G+}
   SHL AX,2
  {$ELSE}
   SHL AX,1
   SHL AX,1
  {$ENDIF}
  XOR CX,CX
  ADD Word Ptr aY,AX
  ADC Word Ptr aY[2],CX
  MOV AX,Word Ptr aY
  MOV DX,Word Ptr aY[2]
  DEC YP
  CMP YP,CX
  JNE @000
 POP DS
END;

Procedure PutTxtXY;Var I,J:Byte;Begin
 If Attr and$F=Attr shr 4Then BarSpcHor(X,Y,X+Length(Str)-1,Attr)
  Else
 For I:=1to Length(Str)do Begin
  If Str[I]=' 'Then Begin
   J:=I;
   For I:=J to Length(Str)do If Str[I]<>' 'Then Break;
   BarSpcHor(X+J-1,Y,X+I-1,Attr)
  End;
  SetCube(X+I-1,Y,Str[I],Attr)
 End;
End;

Procedure PutTxtXYUnKr;Var I,J:Byte;Begin
 J:=X;
 For I:=1to Length(Str)do Begin SetCube(J,Y,Str[I],GetAttr(J,Y));Inc(J)End;
End;

Procedure SetAttr;Begin;SetCube(X,Y,GetChr(X,Y),Attr)End;
Procedure SetBackgroundColor;Begin End;
Procedure SetBlink;Begin End;

Procedure SetBorderColor;Assembler;ASM
 MOV DX,3DAh
 IN  AL,DX                  { active le mode index de l'ATC }
 MOV DL,0C0h
 MOV AL,$11 or 32;          { s‚lectionne le registre 11h }
 OUT DX,AL
 MOV AL,Kr                  { Envoie la couleur }
 OUT DX,AL
END;

Procedure SetBytesPerLn;Assembler;ASM
 MOV AX,X
 {$IFOPT G+}
  SHR AX,2
 {$ELSE}
  SHR AX,1
  SHR AX,1
 {$ENDIF}
 MOV DataVideo.MIV.BytesPerLine,AX
 PUSH AX
  SHR AX,1
  MOV AH,AL
  MOV DX,3D4h
  MOV AL,13h
  OUT DX,AX
   { Fixe les longueurs des lignes... }
  XOR AX,AX
  MOV CX,728 { Nombre de ligne }
  MOV BX,Offset RealRawY
 POP DX
@L:
 MOV CS:[BX],AX
 INC BX
 INC BX
 ADD AX,DX
 LOOP @L
END;

Procedure SetChr;Assembler;ASM
 PUSH Word Ptr X
 PUSH Word Ptr Y
 PUSH CS
 CALL Near Ptr GetAttr
 PUSH Word Ptr X
 PUSH Word Ptr Y
 PUSH Word Ptr Chr
 PUSH AX
 PUSH CS
 CALL Near Ptr SetCube
END;
{Begin SetCube(X,Y,Chr,GetAttr(X,Y))End;}

{$I scx256.Inc}

Procedure SetCur;Assembler;ASM
 XOR AX,AX
 MOV ES,AX
 MOV AL,B
 MOV AH,A
 MOV ES:[460h],AX
END;

Procedure SetCurPos;Assembler;ASM
 XOR BX,BX
 MOV ES,BX
 MOV AH,Y
 MOV BL,ES:[462h]
 AND BL,7
 SHL BX,1
 MOV AL,X
 MOV ES:[0450h+BX],AX
END;

{$I GCube256.Inc}

Procedure SetGCubeT;
Var
 I,M:Byte;
 PB:^Byte;
Begin
 ASM
  MOV AL,DataVideo.MIV.HeightChar
  DEC AL
  MOV M,AL
  LES DI,DataVideo.MIV.TxtMtx
  MOV Word Ptr PB[2],ES
  MOV BL,Chr
  XOR BH,BH
  SHL BX,1
  ADD DI,Word Ptr RawY[BX]
  MOV Word Ptr PB,DI
 END;
 For I:=0to(M)do Begin CopT8Bin(X,Y+I,PB^,Attr);Inc(Word(PB))End;
End;

Procedure SetPalBlk;Assembler;ASM
 MOV AL,Byte Ptr Start
 MOV DX,3C8h
 OUT DX,AL
 INC DX
 MOV AX,Nm
 MOV CX,AX
 ADD CX,AX
 ADD CX,AX
 MOV AL,0
@2:
 OUT DX,AL
 LOOP @2
END;

Procedure SetPaletteRGB;Assembler;ASM
 MOV DX,3C8h
 MOV AL,Byte Ptr Start
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

Procedure SetPalRGB;Assembler;ASM
 MOV AL,Byte Ptr Start
 MOV DX,3C8h
 OUT DX,AL
 CLD
 INC DX
 PUSH DS
  LDS SI,P
  MOV AX,Num
  MOV CX,AX
  ADD CX,AX
  ADD CX,AX
@2:
  LODSB
  {$IFOPT G+}
   SHR AL,2
  {$ELSE}
   SHR AL,1
   SHR AL,1
  {$ENDIF}
  OUT DX,AL
  LOOP @2
 POP DS
END;

Procedure SetPixel;Assembler;ASM
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
 {$IFNDEF __360x480c256}
  ADD DI,DataVideo.MIV.AddrPg
 {$ENDIF}
 MOV AL,Byte Ptr Kr
 STOSB
@End:
END;

Procedure HoriData;Assembler;ASM
 DW 0
END;

Procedure VertData;Assembler;ASM
 DW 0
END;

Procedure SetVerticalScale;Assembler;ASM
 MOV BX,Y
 SHL BX,1
 MOV CX,Word Ptr RealRawY[BX]
 MOV Word Ptr VertData,CX
 ADD CX,Word Ptr HoriData
 MOV DX,3D4h
 MOV AL,0Ch
 MOV AH,CH
 OUT DX,AX
 MOV AL,0Dh
 MOV AH,CL
 OUT DX,AX
END;

Procedure SetHorizontalScale;Assembler;ASM
 MOV CX,X
 {$IFOPT G+}
  SHR CX,3
 {$ELSE}
  SHR CX,1
  SHR CX,1
  SHR CX,1
 {$ENDIF}
 MOV Word Ptr HoriData,CX
 ADD CX,Word Ptr VertData
 MOV DX,3D4h
 MOV AL,0Ch
 MOV AH,CH
 OUT DX,AX
 MOV AL,0Dh
 MOV AH,CL
 OUT DX,AX
END;

Procedure WriteMode;Assembler;ASM
 DB 0
END;

Procedure SetWriteMode;Assembler;ASM
 MOV DX,03CEh
 MOV AL,03h
 MOV AH,Mode
 AND AH,3
 MOV Byte Ptr WriteMode,AH
 {$IFOPT G+}SHL AH,3{$ELSE}SHL AH,1;SHL AH,1;SHL AH,1{$ENDIF}
 OUT DX,AX
END;

Procedure SplitScreen;Assembler;ASM
 MOV DX,3D4h
 MOV BX,Y
 MOV CX,BX
 MOV AL,07h
 OUT DX,AL
 INC DX
 IN  AL,DX
 AND AL,11101111b
 {$IFOPT G+}
  SHR CX,4
 {$ELSE}
  SHR CX,1
  SHR CX,1
  SHR CX,1
  SHR CX,1
 {$ENDIF}
 AND CL,16
 OR  AL,CL
 OUT DX,AL
 DEC DX
 MOV AL,09h
 OUT DX,AL
 INC DX
 IN  AL,DX
 AND AL,10111111b
 {$IFOPT G+}
  SHR BL,3
 {$ELSE}
  SHR BL,1
  SHR BL,1
  SHR BL,1
 {$ENDIF}
 AND BL,64
 OR  AL,BL
 OUT DX,AL
 DEC DX
 MOV AL,18h
 MOV AH,Byte Ptr Y
 OUT DX,AX
@End:
END;

{ Cette proc‚dure permet de lire une partie de l'‚cran … partir d'un
 tampon de fa‡on totalement lin‚aire (et non pas par groupe de quatre
 comme les routines de Hacker!). Ainsi le premier offset lin‚aire
 correspondra au pixel (0,0), le deuxiŠme au pixel (1,0) et ainsi
 de suite...
}

Procedure ReadBnk;Assembler;
Var
 Start,StartPlane:Word;
 Len:Integer;
ASM
 LES AX,x0
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
  MOV Len,AX
  DEC L
  LES AX,aY
  MOV DX,ES
  MOV BX,AX
  AND BX,3
  MOV StartPlane,BX
(*  {$IFDEF __386__}
   DB 0Fh,0ACh,0C2h,02h {SHRD DX,AX,2}
  {$ELSE}*)
   SHR DX,1;RCR AX,1;SHR DX,1;RCR AX,1
(*  {$ENDIF}*)
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
   { Calcule le point de d‚part dans le tampon... ®P==_AX¯ }
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
   { Calcul le LenSub ®_CX:=(L ï 3 < 3) ï (L ï 3 >= P) ? 1 : 0;¯}
  XOR CX,CX
  MOV DX,L
  AND DX,3
  CMP DX,3
  JNB @1
  CMP DX,AX
  JNAE @1
  INC CX
@1:{For J:=0to(Len)do Begin;Buf[P]:=Mem[_A000:P1];Inc(P,4);Inc(P1)End;}
  LES DI,x0
  ADD DI,AX
  ADD CX,Len
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
   {For J:=0to(Len)do Begin;Buf[P]:=Mem[_A000:P1];Inc(P,4);Inc(P1)End;}
  LES DI,x0
  ADD DI,AX
  ADD CX,Len
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
  LES DI,x0
  ADD DI,AX
  ADD CX,Len
  JCXZ @3c
@2c:
  MOVSB
  INC DI
  INC DI
  INC DI
  LOOP @2c
@3c:
   { Fixe la plage 3 }
  MOV DX,$3CE
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
  LES DI,x0
  ADD DI,AX
  ADD CX,Len
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

Procedure WriteBnk;Assembler;
Var
 Start,StartPlane:Word;
 Len:Integer;
ASM
 PUSH DS
  MOV AX,L
  {$IFOPT G+}
   SHR AX,2
  {$ELSE}
   SHR AX,1
   SHR AX,1
  {$ENDIF}
  MOV Len,AX
  DEC L
  LES AX,aY
  MOV DX,ES
  MOV BX,AX
  AND BX,3
  MOV StartPlane,BX
(*  {$IFDEF __386__}
   DB 0Fh,0ACh,0C2h,02h {SHRD DX,AX,2}
  {$ELSE}*)
   SHR DX,1;RCR AX,1;SHR DX,1;RCR AX,1
(*  {$ENDIF}*)
  SUB AX,BX
  MOV Start,AX
  MOV ES,DataVideo.MIV.SegVideo
  CLD
@Restart:
   { Fixe la plage 0 }
  MOV DX,3C4h
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
  LDS SI,x0
  ADD SI,AX
  ADD CX,Len
  JCXZ @3
@2:LODSW
  INC SI
  INC SI
  STOSB
  LOOP @2
@3:
   { Fixe la plage 1 }
  MOV DX,3C4h
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
  LDS SI,x0
  ADD SI,AX
  ADD CX,Len
  JCXZ @3b
@2b:LODSW
  INC SI
  INC SI
  STOSB
  LOOP @2b
@3b:
   { Fixe la plage 2 }
  MOV DX,3C4h
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
   {For J:=0to(Len)do Begin;Mem[_A000:P1]:=Buf[P];Inc(P,4);Inc(P1)End;}
  LDS SI,x0
  ADD SI,AX
  ADD CX,Len
  JCXZ @3c
@2c:LODSW
  INC SI
  INC SI
  STOSB
  LOOP @2c
@3c:
   { Fixe la plage 3 }
  MOV DX,3C4h
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
  LDS SI,x0
  ADD SI,AX
  ADD CX,Len
  JCXZ @3d
@2d:LODSW
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

Procedure FillBnk;Assembler;
Var
 Start,StartPlane:Word;
 Len:Integer;
ASM
 MOV AX,L
 {$IFOPT G+}
  SHR AX,2
 {$ELSE}
  SHR AX,1
  SHR AX,1
 {$ENDIF}
 MOV Len,AX
 DEC L
 LES AX,aY
 MOV DX,ES
 MOV BX,AX
 AND BX,3
 MOV StartPlane,BX
(* {$IFDEF __386__}
  DB 0Fh,0ACh,0C2h,02h {SHRD DX,AX,2}
 {$ELSE}*)
  SHR DX,1;RCR AX,1;SHR DX,1;RCR AX,1
(* {$ENDIF}*)
 SUB AX,BX
 MOV Start,AX
 {$IFDEF DPMI}
  MOV ES,SegA000
 {$ELSE}
  MOV ES,DataVideo.MIV.SegVideo
 {$ENDIF}
 CLD
@Restart:
  { Fixe la plage 0 }
 MOV DX,3C4h
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
@1:{For J:=0to(Len)do Begin;Mem[_A000:P1]:=Kr;Inc(P1)End;}
 ADD CX,Len
 MOV AL,Byte Ptr Kr
 MOV AH,AL
 SHR CX,1
 REP STOSW
 ADC CX,CX
 REP STOSB
  { Fixe la plage 1 }
 MOV DX,3C4h
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
  {For J:=0to(Len)do Begin;Mem[_A000:P1]:=Kr;Inc(P1)End;}
 ADD CX,Len
 MOV AL,Byte Ptr Kr
 MOV AH,AL
 SHR CX,1
 REP STOSW
 ADC CX,CX
 REP STOSB
  { Fixe la plage 2 }
 MOV DX,3C4h
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
 ADD CX,Len
 MOV AL,Byte Ptr Kr
 MOV AH,AL
 SHR CX,1
 REP STOSW
 ADC CX,CX
 REP STOSB
  { Fixe la plage 3 }
 MOV DX,3C4h
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
 ADD CX,Len
 MOV AL,Byte Ptr Kr
 MOV AH,AL
 SHR CX,1
 REP STOSW
 ADC CX,CX
 REP STOSB
END;

{$I GrfIcon.Inc}
{$I Done.Inc}