{Drv2.Inc}

Procedure RawTxtY;Forward;
Procedure RawY;Forward;
Procedure RealRawY;Forward;

Procedure _Driver2;Assembler;ASM
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
 JMP PCopy.Near
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
 JMP PutSmlImg.Near{PutSprite...}
 JMP PutTxtXY.Near
 JMP PutTxtXYUnKr.Near
 JMP SetAttr.Near
 JMP SetBackgroundColor.Near
 JMP SetBlink.Near
 JMP SetBorderColor.Near
 JMP SetBytesPerLn.Near
 JMP SetChr.Near
 JMP SetChrWidth.Near
 JMP SetCube.Near
 JMP SetCur.Near
 JMP SetCurPos.Near
 RETF 2          {SetDblMtx}
 JMP SetChr.Near {SetExtChr}
 JMP SetCube.Near{SetExtCube}
 JMP SetGCube.Near
 JMP SetGCubeT.Near
 JMP SetHorizontalScale.Near
 RETF 12{SetMatrix(Palette,Height:Byte;Number,Start:Wd;Var X:TByte)}
 RETF {SetModeMtx}
 NOP
 NOP
 RETF {SetModeScr}
 NOP
 NOP
 JMP SetPalBlk.Near
 JMP SetPaletteRGB.Near
 JMP SetPalRGB.Near
 JMP SetPg.Near
 JMP SetPixel.Near
 RETF 2 {SetUnderline(X:Bool)}
 JMP SetVerticalScale.Near
 JMP SetVisualPg.Near
 JMP SetWriteMode.Near
 JMP SplitScreen.Near
 RETF 2 {SetBnkPg(Pg:Byte)}
 RETF 10 {ReadBnk(P:Long;Size:Wd;Var x0)}
 RETF 10 {WriteBnk(P:Long;Size:Wd;Var x0)}
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
 DB 0{IbmLogic:Mode dans la logique IBM (pas hors cas texte … la SVGA...)}
 DB 0{BiosSupport:Mode support‚ par le Bios (Par exemple, la GS en 16 couleurs le Bios ne le connaŒt pas)}
 DB Ya{Colr:Mode couleur? Sinon monochrome for‡‚ment...}
 DB Ya{Graf:Mode graphique? Sinon texte}
 DB Ya{Direct:M‚thode directe? Sinon Bios ou Dos}
 DB No{Blink:Clignotement}
 DB 0{Snow:Neige lors de l'envoie de donn‚e dans le tampon vid‚o?}
 DW 0B800h{SegV:Segment vid‚o (A000h,B000h,B800h,...)}
 DB 8{HeightChr:Hauteur de la police de caractŠre actuel}
 DW 640{NmXPixels:Nombre de pixels horizontal qu'affiche l'‚cran}
 DW 200{NmYPixels:Nombre de pixels vertical qu'affiche l'‚cran}
 DB 80,25{NmXTxts,NmYTxts:Nombre de caractŠre texte horizontal/vertical qu'affiche l'‚cran}
 DB 1{NmVidPgs:Nombre de page vid‚o que supporte le mode actuel}
 DD 2{NmColrs:Nombre de couleurs affich‚}
 DB 1{BitsPerPixel:Nombre de Bit(s) utilis‚ pour l'affichage d'un pixel}
 DW 80{BytesPerLn:Nombre d'octet par ligne affich‚ (trŠs relatif en VGA...)}
 DB 0{Pg:Num‚ro de la page vid‚o de travail}
 DW 0{AddrPg:En texte, adresse en m‚moire vid‚o de la page actuel}
 DB 0{ShowPg:Num‚ro de la page vid‚o actuellement affich‚}
 DD 0{TxtMtx:Pointeur sur la police de caractŠre courante}
 DD 16384{ScrSize:Taille de l'‚cran}
 DW 0{SizeBnk:Taille d'un page de la banque (0=64Ko)}
 DW 0{SegBuf:Segment du tampon d'acc‚l‚ration}
 DB 0{IsDblMtx:Y a-t-il une police de 512 caractŠres?}
 DB 0,0 {XCur,YCur:Position actuel du curseur}
 DB 0,0 {StartCur,EndCur:D‚but et fin du curseur}
END;

Procedure RawTxtY;Assembler;ASM
 DW    0,  80, 160, 240, 320, 400, 480, 560, 640, 720, 800, 880, 960,1040,1120,1200
 DW 1280,1360,1440,1520,1600,1680,1760,1840,1920,2000,2080,2160,2240,2320,2400,2480
 DW 2560,2640,2720,2800,2880,2960,3040,3120,3200,3280,3360,3440,3520,3600,3680,3760
 DW 3840,3920,4000,4080,4160,4240,4320,4400,4480,4560,4640,4720,4800,4880,4960,5040
 DW 5120,5200,5280,5360,5440,5520,5600,5680,5760,5840,5820,5900,5980,6060,6140,6220
 DW 6300,Offset PhysVideo
END;

Procedure RealRawY;Assembler;ASM
 DW     0, 8192,   80, 8272,  160, 8352,  240, 8432,  320, 8512,  400, 8592
 DW   480, 8672,  560, 8752,  640, 8832,  720, 8912,  800, 8992,  880, 9072
 DW   960, 9152, 1040, 9232, 1120, 9312, 1200, 9392, 1280, 9472, 1360, 9552
 DW  1440, 9632, 1520, 9712, 1600, 9792, 1680, 9872, 1760, 9952, 1840,10032
 DW  1920,10112, 2000,10192, 2080,10272, 2160,10352, 2240,10432, 2320,10512
 DW  2400,10592, 2480,10672, 2560,10752, 2640,10832, 2720,10912, 2800,10992
 DW  2880,11072, 2960,11152, 3040,11232, 3120,11312, 3200,11392, 3280,11472
 DW  3360,11552, 3440,11632, 3520,11712, 3600,11792, 3680,11872, 3760,11952
 DW  3840,12032, 3920,12112, 4000,12192, 4080,12272, 4160,12352, 4240,12432
 DW  4320,12512, 4400,12592, 4480,12672, 4560,12752, 4640,12832, 4720,12912
 DW  4800,12992, 4880,13072, 4960,13152, 5040,13232, 5120,13312, 5200,13392
 DW  5280,13472, 5360,13552, 5440,13632, 5520,13712, 5600,13792, 5680,13872
 DW  5760,13952, 5840,14032, 5920,14112, 6000,14192, 6080,14272, 6160,14352
 DW  6240,14432, 6320,14512, 6400,14592, 6480,14672, 6560,14752, 6640,14832
 DW  6720,14912, 6800,14992, 6880,15072, 6960,15152, 7040,15232, 7120,15312
 DW  7200,15392, 7280,15472, 7360,15552, 7440,15632, 7520,15712, 7600,15792
 DW  7680,15872, 7760,15952, 7840,16032, 7920,16112
  { 200 … 399 }
 DW 16000,16080,16160,16240,16320,16400,16480,18560,16640,16720,16800,16880
 DW 16960,17040,17120,17200,17280,17360,17440,17520,17600,17680,17760,17840
 DW 17920,18000,18080,18160,18240,18320,18400,18480,18560,18640,18720,18800
 DW 18880,18960,19040,19120,19200,19280,19360,19440,19520,19600,19680,19760
 DW 19840,19920,20000,20080,20160,20240,20320,20400,20480,20560,20640,20720
 DW 20800,20880,20960,21040,21120,21200,21280,21360,21440,21520,21600,21680
 DW 21760,21840,21920,22000,22080,22160,22240,22320,22400,22480,22560,22640
 DW 22720,22800,22880,22960,23040,23120,23200,23280,23360,23440,23520,23600
 DW 23680,23760,23840,23920,24000,24080,24160,24240,24320,24400,24480,24560
 DW 24640,24720,24800,24880,24960,25040,25120,25200,25280,25360,25440,25520
 DW 25600,25680,25760,25840,25920,26000,26080,26160,26240,26320,25400,26480
 DW 26560,26640,26720,26800,26880,26960,27040,27120,27200,27280,27360,27440
 DW 27520,27600,27680,27760,27840,27920,28000,28080,28160,28240,28320,28400
 DW 28480,28560,28640,28720,28800,28880,28960,29040,29120,29200,29280,29360
 DW 29440,29520,29600,29680,29760,29840,29920,30000,30080,30160,30240,30320
 DW 30400,30480,30560,30640,30720,30800,30880,30960,31040,31120,31200,31280
 DW 31360,31440,31520,31600,31680,31760,31840,31920
  { 400 … 599 }
 DW 32000,32080,32160,32240,32320,32400,32480,32560,32640,32720,32800,32880
 DW 32960,33040,33140,33200,33280,33360,33440,33520,33600,33680,33760,33840
 DW 33920,34000,34080,34160,34240,34320,34400,34480,34560,34640,34720,34800
 DW 34880,34960,35040,35120,35200,35280,35360,35440,35520,35600,35680,35760
 DW 35840,35920,36000,36080,36160,36240,36320,36400,36480,36560,36640,36720
 DW 36800,36880,36960,37040,37120,37200,37280,37360,37440,37520,37600,37680
 DW 37760,37840,37920,38000,38080,38160,38240,38320,38400,38480,38560,38640
 DW 38720,38800,38960,39040,39080,39120,39200,39280,39360,39440,39520,39600
 DW 39680,39760,39840,39920,40000,40080,40160,40240,40320,40400,40480,40560
 DW 40640,40720,40800,40880,40960,41040,41120,41200,41280,41360,41440,41520
 DW 41600,41680,41760,41840,41920,42000,42080,42160,41240,42320,42400,42480
 DW 42560,42640,42720,42800,42880,42960,43040,43120,43200,43280,43360,43440
 DW 43520,43600,43680,43760,43840,43920,44000,44080,44160,44240,44320,44400
 DW 44480,44560,44640,44720,44800,44880,44960,45040,45120,45200,45280,45360
 DW 45440,45520,45600,45680,45760,45840,45920,46000,46080,46160,46240,46320
 DW 46400,46480,46560,46640,46720,46800,46880,46960,47040,47120,47200,47280
 DW 47360,47440,47520,47600,47680,47760,47840,47920
END;

Procedure RawY;Assembler;ASM
 DW   0*8,  1*8,  2*8,  3*8,  4*8,  5*8,  6*8,  7*8,  8*8,  9*8, 10*8, 11*8, 12*8, 13*8, 14*8, 15*8
 DW  16*8, 17*8, 18*8, 19*8, 20*8, 21*8, 22*8, 23*8, 24*8, 25*8, 26*8, 27*8, 28*8, 29*8, 30*8, 31*8
 DW  32*8, 33*8, 34*8, 35*8, 36*8, 37*8, 38*8, 39*8, 40*8, 41*8, 42*8, 43*8, 44*8, 45*8, 46*8, 47*8
 DW  48*8, 49*8, 50*8, 51*8, 52*8, 53*8, 54*8, 55*8, 56*8, 57*8, 58*8, 59*8, 60*8, 61*8, 62*8, 63*8
 DW  64*8, 65*8, 66*8, 67*8, 68*8, 69*8, 70*8, 71*8, 72*8, 73*8, 74*8, 75*8, 76*8, 77*8, 78*8, 79*8
 DW  80*8, 81*8, 82*8, 83*8, 84*8, 85*8, 86*8, 87*8, 88*8, 89*8, 90*8, 91*8, 92*8, 93*8, 94*8, 95*8
 DW  96*8, 97*8, 98*8, 99*8,100*8,101*8,102*8,103*8,104*8,105*8,106*8,107*8,108*8,109*8,110*8,111*8
 DW 112*8,113*8,114*8,115*8,116*8,117*8,118*8,119*8,120*8,121*8,122*8,123*8,124*8,125*8,126*8,127*8
 DW 128*8,129*8,130*8,131*8,132*8,133*8,134*8,135*8,136*8,137*8,138*8,139*8,140*8,141*8,142*8,143*8
 DW 144*8,145*8,146*8,147*8,148*8,149*8,150*8,151*8,152*8,153*8,154*8,155*8,156*8,157*8,158*8,159*8
 DW 160*8,161*8,162*8,163*8,164*8,165*8,166*8,167*8,168*8,169*8,170*8,171*8,172*8,173*8,174*8,175*8
 DW 176*8,177*8,178*8,179*8,180*8,181*8,182*8,183*8,184*8,185*8,186*8,187*8,188*8,189*8,190*8,191*8
 DW 192*8,193*8,194*8,195*8,196*8,197*8,198*8,199*8,200*8,201*8,202*8,203*8,204*8,205*8,206*8,207*8
 DW 208*8,209*8,210*8,211*8,212*8,213*8,214*8,215*8,216*8,217*8,218*8,219*8,220*8,221*8,222*8,223*8
 DW 224*8,225*8,226*8,227*8,228*8,229*8,230*8,231*8,232*8,233*8,234*8,235*8,236*8,237*8,238*8,239*8
 DW 240*8,241*8,242*8,243*8,244*8,245*8,246*8,247*8,248*8,249*8,250*8,251*8,252*8,253*8,254*8,255*8
END;

Procedure BarChrHor;Var I:Byte;Begin
 For I:=X1 to(X2)do SetChr(I,Y,Chr)
End;

Procedure BarChrVer;Var J:Byte;Begin
 For J:=Y1 to(Y2)do SetChr(X,J,Chr)
End;

Procedure AttributForeground;Assembler;ASM
     {0  1   2   3   4   5   6   7   8   9   10  11  12  13  14  15}
 DB  0,$55,$55,$55,$55,$55,$55,$55,  0,$AA, $AA,$AA,$AA,$AA,$FF,$FF { 0 }
 DB  0,$55,$55,$55,$55,$55,$55,$55,  0,$AA, $AA,$AA,$AA,$AA,$FF,$FF { 1 }
 DB  0,$55,$55,$55,$55,$55,$55,$55,  0,$AA, $AA,$AA,$AA,$AA,$FF,$FF { 2 }
 DB  0,$55,$55,$55,$55,$55,$55,$55,  0,$AA, $AA,$AA,$AA,$AA,$FF,$FF { 3 }
 DB  0,$55,$55,$55,$55,$55,$55,$55,  0,$AA, $AA,$AA,$AA,$AA,$FF,$FF { 4 }
 DB  0,$55,$55,$55,$55,$55,$55,$55,  0,$AA, $AA,$AA,$AA,$AA,$FF,$FF { 5 }
 DB  0,$55,$55,$55,$55,$55,$55,$55,  0,$AA, $AA,$AA,$AA,$AA,$FF,$FF { 6 }
 DB  0,$55,$55,$55,$55,$55,$55,$55,  0,$AA, $AA,$AA,$AA,$AA,$FF,$FF { 7 }
 DB  0,$55,$55,$55,$55,$55,$55,$55,  0,$AA, $AA,$AA,$AA,$AA,$FF,$FF { 8 }
 DB  0,$55,$55,$55,$55,$55,$55,$55,  0,$AA, $AA,$AA,$AA,$AA,$FF,$FF { 9 }
 DB  0,$55,$55,$55,$55,$55,$55,$55,  0,$AA, $AA,$AA,$AA,$AA,$FF,$FF { 10 }
 DB  0,$55,$55,$55,$55,$55,$55,$55,  0,$AA, $AA,$AA,$AA,$AA,$FF,$FF { 11 }
 DB  0,$55,$55,$55,$55,$55,$55,$55,  0,$AA, $AA,$AA,$AA,$AA,$FF,$FF { 12 }
 DB  0,$55,$55,$55,$55,$55,$55,$55,  0,$AA, $AA,$AA,$AA,$AA,$FF,$FF { 13 }
 DB  0,$55,$55,$55,$55,$55,$55,$55,  0,$AA, $AA,$AA,$AA,$AA,$FF,$FF { 14 }
 DB  0,$55,$55,$55,$55,$55,$55,$55,  0,$AA, $AA,$AA,$AA,$AA,$FF,$FF { 15 }
END;

Procedure SpcAttr;Assembler;ASM
 DB 0        { 0 }
 DB 55h      { 1 }
 DB 55h      { 2 }
 DB 55h      { 3 }
 DB 55h      { 4 }
 DB 55h      { 5 }
 DB 55h      { 6 }
 DB 55h      { 7 }
 DB 0        { 8 }
 DB 0AAh     { 9 }
 DB 0AAh     { 10 }
 DB 0AAh     { 11 }
 DB 0AAh     { 12 }
 DB 0AAh     { 13 }
 DB 0FFh     { 14 }
 DB 0FFh     { 15 }
END;

Procedure BarSpcHor;Var I,Max:Wd;Begin
 I:=X2-X1+1;
 ASM
  MOV BL,Byte Ptr Attr
  XOR BH,BH
  {$IFOPT G+}SHR BX,4{$ELSE}MOV CL,4;SHR BX,CL{$ENDIF}
  MOV CL,Byte Ptr SpcAttr[BX]
  MOV BL,Y
  SHL BX,1
  MOV SI,Word Ptr RawY[BX]
  MOV AL,DataVideo.MIV.HeightChar
  XOR AH,AH
  ADD AX,SI
  MOV Max,AX
  MOV ES,DataVideo.MIV.SegVideo
  MOV AL,CL
  CLD
@1:MOV DI,SI
  SHL DI,1
  MOV DI,Word Ptr RealRawY[DI]
  MOV BL,X1
  XOR BH,BH
  ADD DI,BX
  MOV CX,I
  REP STOSB
  INC SI
  CMP SI,Max
  JNE @1
   { Fixe dans le tampon acc‚l‚rateur... }
  MOV ES,DataVideo.MIV.SegBuffer
  MOV BL,Y
  XOR BH,BH
  SHL BX,1
  MOV DI,Word Ptr RawTxtY[BX]
  MOV BL,X1
  ADD DI,BX
  SHL DI,1
  MOV CX,I
  MOV AH,Attr
  MOV AL,' '
  CLD
  REP STOSW
 END;
End;

Procedure BarSpcVer;Assembler;ASM
 CLD
 MOV BL,Byte Ptr Attr
 XOR BH,BH
 {$IFOPT G+}SHR BX,4{$ELSE}MOV CL,4;SHR BX,CL{$ENDIF}
 MOV BL,Byte Ptr SpcAttr[BX]
 PUSH BX
  MOV BL,Y1
  XOR BH,BH
  SHL BX,1
  MOV DX,Word Ptr RawY[BX]
  MOV BL,Y2
  XOR BH,BH
  INC BX
  SHL BX,1
  MOV SI,Word Ptr RawY[BX]
  DEC SI
 POP BX
 MOV ES,DataVideo.MIV.SegVideo
@@Boucle:
 MOV DI,DX
 SHL DI,1
 MOV DI,Word Ptr RealRawY[DI]
 MOV AL,X
 MOV AH,0
 ADD DI,AX
 MOV AL,BL
 STOSB
 INC DX
 CMP DX,SI
 JLE @@Boucle
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

Procedure BarTxtHor;Assembler;Var J,L:Wd;Value,Value2,M:Byte;ASM
 XOR AH,AH
 MOV AL,X2
 SUB AL,X1
 INC AX
 MOV L,AX
 MOV BL,Byte Ptr Attr
 XOR BH,BH
 {$IFOPT G+}SHR BX,4{$ELSE}MOV CL,4;SHR BX,CL{$ENDIF}
 MOV CL,Byte Ptr SpcAttr[BX]
 MOV Value,CL
 MOV BL,Attr
 MOV BH,0
 MOV AL,Byte Ptr AttributForeground[BX]
 MOV Value2,AL
 MOV BL,Chr
 XOR BH,BH
 SHL BX,1
 MOV AX,Word Ptr RawY[BX]
 LES SI,DataVideo.MIV.TxtMtx
 ADD SI,AX
 MOV BL,Y
 XOR BH,BH
 SHL BX,1
 MOV AX,Word Ptr RawY[BX]
 MOV J,AX
 PUSH DS
  MOV DS,DataVideo.MIV.SegVideo
  MOV CL,DataVideo.MIV.HeightChar
  XOR CH,CH
  MOV AL,X1
  XOR AH,AH
@1:MOV DL,ES:[SI]
  MOV DH,DL
  AND DL,Value2
  MOV BH,DL
  MOV BL,Value
  NOT DH
  AND BL,DH
  OR  BL,BH
  MOV DI,J
  SHL DI,1
  MOV DI,Word Ptr RealRawY[DI]
  ADD DI,AX
  PUSH CX
   MOV CX,L
@2:MOV DS:[DI],BL
   INC DI
   LOOP @2
  POP CX
  INC J
  INC SI
  LOOP @1
 POP DS
  { Fixe dans le tampon acc‚l‚rateur... }
 MOV ES,DataVideo.MIV.SegBuffer
 MOV BL,Y
 XOR BH,BH
 SHL BX,1
 MOV DI,Word Ptr RawTxtY[BX]
 MOV BL,X1
 ADD DI,BX
 SHL DI,1
 MOV CX,L
 MOV AH,Attr
 MOV AL,Chr
 CLD
 REP STOSW
END;

{$I Circle.Inc}
{$I ClsCurGr.Inc}

Procedure ClrLnHor;Begin
 PutLnHor(X,Y,X+L-1,Kr)
End;

Procedure ClrLnHorImg;
Var
 MX,MY,I:Word;
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
  8:For I:=0to L-1do SetPixel(X+I,Y,TBuf[I]);
  4:For I:=0to(L-1)shr 1do Begin
   SetPixel(X,Y,TBuf[0]shr 4);
   Inc(X);
   SetPixel(X,Y,TBuf[0]and 15);
   Inc(X);
   ASM
    INC Word Ptr Buffer
   END;
  End;
  Else Begin
   If BitsPerPixel=0Then ASM ADD Word Ptr Buffer,2;END;
   PutSmlImg(X,Y,X+L-1,Y,Buffer);
  End;
 End;
End;

Procedure ClrWn;Assembler;ASM
 CLD
 XOR CH,CH
 MOV BL,Byte Ptr Attr
 XOR BH,BH
 {$IFOPT G+}SHR BX,4{$ELSE}MOV CL,4;SHR BX,CL{$ENDIF}
 MOV BL,Byte Ptr SpcAttr[BX]
 MOV BH,X2
 SUB BH,X1
 INC BH
 PUSH BX
  MOV BL,Y1
  XOR BH,BH
  SHL BX,1
  MOV DX,Word Ptr RawY[BX]
  MOV BL,Y2
  XOR BH,BH
  INC BX
  SHL BX,1
  MOV SI,Word Ptr RawY[BX]
  DEC SI
 POP BX
 MOV ES,DataVideo.MIV.SegVideo
@@Boucle:
 MOV DI,DX
 SHL DI,1
 MOV DI,Word Ptr RealRawY[DI]
 MOV AL,X1
 MOV AH,0
 ADD DI,AX
 MOV AL,BL
 MOV CL,BH
 MOV AH,AL
 SHR CX,1
 REP STOSW
 ADC CX,CX
 REP STOSB
 INC DX
 CMP DX,SI
 JLE @@Boucle
  {Mise … jour du tampon d'acc‚l‚ration}
 XOR AX,AX
 MOV BL,Y1
 XOR BH,BH
 SHL BX,1
 MOV DI,Word Ptr RawTxtY[BX]
 MOV AL,DataVideo.MIV.NumXTexts
 MOV ES,DataVideo.MIV.SegBuffer
 SHL AX,1
 MOV SI,AX
 MOV BL,X1
 ADD DI,BX
 SHL DI,1
 MOV AL,' '
 MOV AH,Attr
 MOV CL,Y1
 MOV CH,Y2
 MOV DL,X2
 SUB DL,X1
 MOV DH,0
 INC DX
@@Loop:
 PUSH CX
  PUSH DI
   MOV CX,DX
   REP STOSW
  POP DI
 POP CX
 ADD DI,SI
 INC CL
 CMP CL,CH
 JBE @@Loop
END;

{$I CLSWPFBO.INC}

Procedure CopT8Bin;Assembler;ASM
 MOV ES,DataVideo.MIV.SegVideo
 MOV BL,Value
 MOV DI,Y
 SHL DI,1
 MOV DI,Word Ptr RealRawY[DI]
 MOV AX,X
 TEST AX,7
 JNZ @FuckedBits
 {$IFOPT G+}SHR AX,3;{$ELSE}SHR AX,1;SHR AX,1;SHR AX,1{$ENDIF}
 ADD DI,AX
 MOV BH,ES:[DI]
 CMP Fore,0 { Reset ? }
 JE  @@Reset
 OR  BH,BL
 JMP @@End
@FuckedBits:
 MOV CL,AL
 NOT CL
 INC CL
 AND CL,7
 XOR BH,BH
 SHL BX,CL
 XCHG BL,BH
 {$IFOPT G+}SHR AX,3{$ELSE}SHR AX,1;SHR AX,1;SHR AX,1{$ENDIF}
 ADD DI,AX
 CMP Fore,0 { Reset ? }
 JE  @@ResetWord
 OR  ES:[DI],BX
 JMP @Over
@@ResetWord:
 NOT BX
 AND ES:[DI],BX
 JMP @Over
@@Reset:
 NOT BL
 AND BH,BL
@@End:
 MOV ES:[DI],BH
@Over:
END;

Procedure Copy8Bin;Assembler;ASM
 MOV ES,DataVideo.MIV.SegVideo
 MOV BL,Value
 MOV CX,13
 TEST Back,CL
 JZ  @@Next
@@Inv:
 TEST Fore,CL
 JNZ @@Next
 NOT BL
@@Next:
 MOV DI,Y
 SHL DI,1
 MOV DI,Word Ptr RealRawY[DI]
 MOV AX,X
 TEST AX,7
 JNZ @FuckedBits
 {$IFOPT G+}SHR AX,3{$ELSE}SHR AX,1;SHR AX,1;SHR AX,1{$ENDIF}
 ADD DI,AX
 MOV ES:[DI],BL
 JMP @End
@FuckedBits:
 MOV CL,AL
 NOT CL
 INC CL
 AND CL,7
 XOR BH,BH
 SHL BX,CL
 XCHG BL,BH
 {$IFOPT G+}SHR AX,3{$ELSE}SHR AX,1;SHR AX,1;SHR AX,1{$ENDIF}
 ADD DI,AX
 MOV AX,0FFh
 SHL AX,CL
 NOT AX
 XCHG AL,AH
 AND ES:[DI],AX
 OR  ES:[DI],BX
@End:
END;

Procedure FillBox;Var J:Byte;Begin
 For J:=Y1 to(Y2)do BarTxtHor(X1,J,X2,Chr,Attr);
End;

{$I GFXGETCH.INC}

Procedure GetLnHorImg;Begin
 GetSmlImg(X1,Y,X2,Y,Buffer)
End;

Function GetPixel;Assembler;ASM
 MOV BX,Y
 SHL BX,1
 MOV DI,Word Ptr RealRawY[BX]
 MOV AX,X
 {$IFOPT G+}
  SHR AX,3
 {$ELSE}
  SHR AX,1
  SHR AX,1
  SHR AX,1
 {$ENDIF}
 ADD DI,AX
 MOV ES,DataVideo.MIV.SegVideo
 MOV AL,ES:[DI]
 MOV CH,Byte Ptr X
 AND CH,7
 MOV CL,7
 SUB CL,CH
 SHR AL,CL
 AND AL,1
END;

Function GetSizeSmlImg;Assembler;ASM
 MOV AX,X2
 SUB AX,X1
 {$IFOPT G+}SHR AX,3{$ELSE}SHR AX,1;SHR AX,1;SHR AX,1{$ENDIF}
 INC AX
 INC AX
 MOV BX,Y2
 SUB BX,Y1
 INC BX
 MUL BX
END;

Procedure StartPlane;Assembler;ASM
 DB 80h+40h+20h+10h+08h+04h+02h+01h
 DB     40h+20h+10h+08h+04h+02h+01h
 DB         20h+10h+08h+04h+02h+01h
 DB             10h+08h+04h+02h+01h
 DB                 08h+04h+02h+01h
 DB                     04h+02h+01h
 DB                         02h+01h
 DB                             01h
END;

Procedure EndPlane;Assembler;ASM
 DB                             80h
 DB                         40h+80h
 DB                     20h+40h+80h
 DB                 10h+20h+40h+80h
 DB             08h+10h+20h+40h+80h
 DB         04h+08h+10h+20h+40h+80h
 DB     02h+04h+08h+10h+20h+40h+80h
 DB 01h+02h+04h+08h+10h+20h+40h+80h
END;

Procedure GetSmlImg;Assembler;Var L:Wd;StupidEnd:Bool;ASM
 PUSH DS
  LES DI,Buffer
  MOV DS,DataVideo.MIV.SegVideo
  MOV CX,X2
  SUB CX,X1
  INC CX
  MOV StupidEnd,No
  TEST CX,7
  JZ @NotStrongLengthFuckedBits
  MOV StupidEnd,Ya
@NotStrongLengthFuckedBits:
  {$IFOPT G+}SHR CX,3{$ELSE}SHR CX,1;SHR CX,1;SHR CX,1{$ENDIF}
  TEST X1,7
  JNZ @FuckedBits
@1:PUSH CX
   MOV SI,Y1
   SHL SI,1
   MOV SI,Word Ptr RealRawY[SI]
   MOV AX,X1
   {$IFOPT G+}SHR AX,3{$ELSE}SHR AX,1;SHR AX,1;SHR AX,1{$ENDIF}
   ADD SI,AX
   SHR CX,1
   REP MOVSW
   ADC CX,CX
   REP MOVSB
   CMP StupidEnd,0
   JE  @9
   {***Damnation de fin monstreuse***}
   MOV BX,X2
   DEC BX
   AND BX,7
   MOV DL,Byte Ptr EndPlane[BX]
   MOV BL,ES:[DI]
   AND BL,DL
   MOV AX,0FFh
   AND AL,DL
   NOT AX
   AND DS:[SI],AL
   OR  DS:[SI],BL
   INC DI
@9:
  POP CX
  INC Y1
  MOV AX,Y2
  CMP Y1,AX
  JBE @1
  JMP @End
@FuckedBits:
  MOV L,CX
@2:
  MOV SI,Y1
  SHL SI,1
  MOV SI,Word Ptr RealRawY[SI]
  MOV AX,X1
  MOV CL,AL
  {$IFOPT G+}SHR AX,3{$ELSE}SHR AX,1;SHR AX,1;SHR AX,1{$ENDIF}
  ADD SI,AX
  NOT CL
  INC CL
  AND CL,7
  MOV DX,L
@3:
  MOV BL,ES:[DI]
  XOR BH,BH
  SHL BX,CL
  XCHG BL,BH
  MOV AX,0FFh
  SHL AX,CL
  NOT AX
  XCHG AL,AH
  AND DS:[SI],AX
  OR  DS:[SI],BX
  INC DI
  INC SI
  DEC DX
  OR  DX,DX
  JNZ @3
  CMP StupidEnd,0
  JE  @6
   {***Damnation de fin monstreuse***}
  MOV BX,X2
  DEC BX
  AND BX,7
  MOV DL,Byte Ptr EndPlane[BX]
  MOV BL,ES:[DI]
  AND BL,DL
  XOR BH,BH
  SHL BX,CL
  XCHG BL,BH
  MOV AX,0FFh
  AND AL,DL
  SHL AX,CL
  NOT AX
  XCHG AL,AH
  AND DS:[SI],AX
  OR  DS:[SI],BX
  INC DI
@6:
  INC Y1
  MOV AX,Y2
  CMP Y1,AX
  JBE @2
@End:
 POP DS
END;

Procedure Init;Var L:Wd;Begin
 ASM
  CMP DataVideo.MIV.Mode,vmGrf640x200c2
  JE  @NoCompute
  MOV DataVideo.MIV.SegVideo,0A000h
  XOR AX,AX
  MOV ES,AX
  MOV BL,ES:[0485h]
  CMP BL,0
  JE  @DefHeightChr
  MOV DataVideo.MIV.HeightChar,BL
@DefHeightChr:
  MOV BL,ES:[0484h]
  CMP BL,0
  JE  @DefNmYTxts
  INC BL
  MOV DataVideo.MIV.NumYTexts,BL
@DefNmYTxts:
  MOV BX,ES:[044Ah]
  MOV DataVideo.MIV.NumXTexts,BL
  MOV DataVideo.MIV.BytesPerLine,BX
  {$IFOPT G+}
   SHL BX,3
  {$ELSE}
   SHL BX,1
   SHL BX,1
   SHL BX,1
  {$ENDIF}
  MOV DataVideo.MIV.NumXPixels,BX
  MOV AL,DataVideo.MIV.NumYTexts
  MUL DataVideo.MIV.HeightChar
  MOV DataVideo.MIV.NumYPixels,AX
  MUL DataVideo.MIV.NumXPixels
  MOV Word Ptr DataVideo.MIV.ScrSize,AX
  MOV Word Ptr DataVideo.MIV.ScrSize[2],DX
  MOV CX,600
  XOR AX,AX
  XOR BX,BX
  MOV DX,DataVideo.MIV.BytesPerLine
@L3:MOV Word Ptr RealRawY[BX],AX
  INC BX
  INC BX
  ADD AX,DX
  LOOP @L3
  MOV CX,80
  XOR AX,AX
  XOR BX,BX
  MOV DL,DataVideo.MIV.NumXTexts
  XOR DH,DH
@L:MOV Word Ptr RawTxtY[BX],AX
  INC BX
  INC BX
  ADD AX,DX
  LOOP @L
@NoCompute:
  MOV DL,DataVideo.MIV.HeightChar
  CMP DL,8
  JE  @NoComputeChr
  MOV CX,256
  XOR BX,BX
  XOR AX,AX
@L2:MOV Word Ptr RawY[BX],AX
  INC BX
  INC BX
  ADD AX,DX
  LOOP @L2
@NoComputeChr:
  MOV BL,DataVideo.MIV.NumYTexts
  XOR BH,BH
  SHL BX,1
  MOV AX,Word Ptr RawTxtY[BX] {Taille/2}
  MOV L,AX
  {$IFOPT G+}
   SHR AX,3
  {$ELSE}
   SHR AX,1 {/8}
   SHR AX,1
   SHR AX,1
  {$ENDIF}
  MOV BX,AX
  {$IFDEF Autonome}
   MOV AH,048h
   INT 021h
  {$ELSE}
   INT 09Bh
  {$ENDIF}
  MOV ES,AX
  MOV DataVideo.MIV.SegBuffer,AX
  XOR DI,DI
  MOV AX,' '+(7 shl 8)
  MOV CX,L
  CLD
  REP STOSW
 END;
End;

Procedure MoveText;Var I,J,L,L2,L1,YL1,YL2,X1a,X3a:Wd;Begin
 If(X2<X1)or(Y2<Y1)Then Exit;
 ASM
  PUSH DS
  MOV AL,X2
  SUB AL,X1
  XOR AH,AH
  INC AX
  MOV L,AX
  CLD
  MOV ES,DataVideo.MIV.SegBuffer
  MOV AL,Y1
  CMP Y3,AL
  JB  @@Inc
  MOV DL,Y2
  SUB DL,AL
  INC DL
@@Loop:
  DEC DL
  MOV AL,Y1
  ADD AL,DL
  MUL DataVideo.MIV.NumXTexts
  MOV BL,X1
  MOV BH,0
  ADD AX,BX
  SHL AX,1
  MOV SI,AX
  MOV AL,Y3
  ADD AL,DL
  MUL DataVideo.MIV.NumXTexts
  MOV BL,X3
  MOV BH,0
  ADD AX,BX
  SHL AX,1
  MOV DI,AX
  MOV CX,L
  PUSH ES
  POP DS
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
  MUL DataVideo.MIV.NumXTexts
  MOV BL,X1
  MOV BH,0
  ADD AX,BX
  SHL AX,1
  MOV SI,AX
  MOV AL,Y3
  ADD AL,DL
  MUL DataVideo.MIV.NumXTexts
  MOV BL,X3
  MOV BH,0
  ADD AX,BX
  SHL AX,1
  MOV DI,AX
  MOV CX,L
  PUSH ES
  POP DS
  REP MOVSW
  INC DL
  CMP DL,DH
  JNE @@LoopInc
@@End:
  POP DS
 END;
 X1a:=X1;X3a:=X3;
 If(Y3<Y1)Then For J:=Y2-Y1+1downto 0do ASM
  XOR BH,BH
  MOV BL,Y1
  SUB BL,Y3
  ADD BL,Y2
  SUB BX,J
  SHL BX,1
  MOV BX,Word Ptr RawY[BX]
  MOV YL1,BX
  XOR BH,BH
  MOV BL,Y2
  SUB BX,J
  SHL BX,1
  MOV BX,Word Ptr RawY[BX]
  MOV YL2,BX
  XOR BX,BX
  PUSH DS
  MOV ES,DataVideo.MIV.SegVideo
  PUSH ES
  POP DS
  CLD
@@Restart:
  MOV SI,YL1
  ADD SI,BX
  SHL SI,1
  MOV SI,Word Ptr RealRawY[SI]
  ADD SI,X1a
  MOV DI,YL2
  ADD DI,BX
  SHL DI,1
  MOV DI,Word Ptr RealRawY[DI]
  ADD DI,X3a
  MOV CX,L
  SHR CX,1
  REP MOVSW
  ADC CX,CX
  REP MOVSB
  INC BX
  TEST BL,DataVideo.MIV.HeightChar
  JZ @@Restart
  POP DS
 END
  Else
 For J:=Y2-Y1 downto 0do ASM
  XOR BH,BH
  MOV BL,Y1
  ADD BX,J
  SHL BX,1
  MOV BX,Word Ptr RawY[BX]
  MOV YL1,BX
  XOR BH,BH
  MOV BL,Y3
  ADD BX,J
  SHL BX,1
  MOV BX,Word Ptr RawY[BX]
  MOV YL2,BX
  XOR BX,BX
  PUSH DS
   MOV ES,DataVideo.MIV.SegVideo
   PUSH ES
   POP DS
   CLD
@@Restart:
   MOV SI,YL1
   ADD SI,BX
   SHL SI,1
   MOV SI,Word Ptr RealRawY[SI]
   ADD SI,X1a
   MOV DI,YL2
   ADD DI,BX
   SHL DI,1
   MOV DI,Word Ptr RealRawY[DI]
   ADD DI,X3a
   MOV CX,L
   SHR CX,1
   REP MOVSW
   ADC CX,CX
   REP MOVSB
   INC BX
   TEST BL,DataVideo.MIV.HeightChar
   JZ @@Restart
  POP DS
 END;
End;

Procedure PCopy;Var Mode,A,B,C:Wd;Begin
 ASM
  MOV AX,DataVideo.MIV.Mode
  MOV Mode,AX
 END;
 If(Mode=vmGrf640x200c2)Then Begin
  C:=16000;A:=C*S;B:=C*T;
  ASM
   CLD
   PUSH DS
    MOV ES,DataVideo.MIV.SegVideo
    MOV DI,B
    PUSH ES
    POP DS
    MOV SI,A
    MOV CX,C
    REP MOVSB
   POP DS
  END;
 End;
End;

{$I PutCharG.Inc}

Procedure PutFillBox;Var J:Wd;Begin For J:=Y1 to(Y2)do PutLnHor(X1,J,X2,Kr)End;

Function AbsInt(I:Int):Int;Near;Assembler;ASM MOV AX,I;OR AX,AX;JGE @1;NEG AX;@1:END;

{$I FillCirc.Inc}
{$I FillRndR.Inc}

Procedure PutLn;
Var D,DX,DY,I,J,Ainc,Binc,Ic:Int;
Begin
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

Procedure PutLnHor;Assembler;ASM
 MOV AX,X1
 TEST AX,8000h
 JZ  @0
 TEST X2,8000h
 JNZ @End
 XOR AX,AX
 MOV X1,AX
@0:
 CMP AX,X2
 JB  @3
 XCHG AX,X2
 MOV X1,AX
@3:
 CLD
 MOV ES,DataVideo.MIV.SegVideo
 MOV CL,3
 MOV AX,X1
 SHR AX,CL
 MOV BX,X2
 SHR BX,CL
 MOV DI,Y
 SHL DI,1
 MOV DI,Word Ptr RealRawY[DI]
 ADD DI,AX
 MOV CX,BX
 SUB CX,AX
 INC CX
 MOV BX,X1
 AND BX,7
 JZ  @NoHome
 MOV AH,Byte Ptr StartPlane[BX]
 MOV AL,Byte Ptr Color
 TEST AL,1
 JZ @Black
@White:
 OR  ES:[DI],AH
 JMP @EndHome
@Black:
 MOV AL,0
 MOV Color,0
 NOT AH
 AND ES:[DI],AH
@EndHome:
 INC DI
 DEC CX
@NoHome:
 MOV BX,X2
 AND BX,7
 CMP BX,7
 JE  @2
 DEC CX
@2:MOV AL,Byte Ptr Color
 TEST AL,1
 JZ @1
 MOV AL,0FFh
@1:
 MOV AH,AL
 SHR CX,1
 REP STOSW
 ADC CX,CX
 REP STOSB
 CMP BX,7
 JE  @End
 TEST AH,1
 JZ @B
@W:
 AND AL,Byte Ptr EndPlane[BX]
 OR ES:[DI],AL
 JMP @End
@B:
 MOV AL,Byte Ptr EndPlane[BX]
 NOT AL
 AND ES:[DI],AL
@End:
END;

{$I PutRect.Inc}
{$I PutRndRe.Inc}

Procedure PutSmlImg;Assembler;
Var
 L:Word;
 StupidEnd:Boolean;
ASM
 PUSH DS
  LDS SI,Buffer
  MOV ES,DataVideo.MIV.SegVideo
  MOV CX,X2
  SUB CX,X1
  INC CX
  MOV StupidEnd,No
  TEST CX,7
  JZ @NotStrongLengthFuckedBits
  MOV StupidEnd,Ya
@NotStrongLengthFuckedBits:
  {$IFOPT G+}SHR CX,3{$ELSE}SHR CX,1;SHR CX,1;SHR CX,1{$ENDIF}
  TEST X1,7
  JNZ @FuckedBits
@1:PUSH CX
   MOV DI,Y1
   SHL DI,1
   MOV DI,Word Ptr RealRawY[DI]
   MOV AX,X1
   {$IFOPT G+}SHR AX,3{$ELSE}SHR AX,1;SHR AX,1;SHR AX,1{$ENDIF}
   ADD DI,AX
   SHR CX,1
   REP MOVSW
   ADC CX,CX
   REP MOVSB
   CMP StupidEnd,0
   JE  @9
   {***Damnation de fin monstreuse***}
   MOV BX,X2
   DEC BX
   AND BX,7
   MOV DL,Byte Ptr EndPlane[BX]
   MOV BL,DS:[SI]
   AND BL,DL
   MOV AX,0FFh
   AND AL,DL
   NOT AX
   AND ES:[DI],AL
   OR  ES:[DI],BL
   INC SI
@9:
  POP CX
  INC Y1
  MOV AX,Y2
  CMP Y1,AX
  JBE @1
  JMP @End
@FuckedBits:
  MOV L,CX
@2:
  MOV DI,Y1
  SHL DI,1
  MOV DI,Word Ptr RealRawY[DI]
  MOV AX,X1
  MOV CL,AL
  {$IFOPT G+}SHR AX,3{$ELSE}SHR AX,1;SHR AX,1;SHR AX,1{$ENDIF}
  ADD DI,AX
  NOT CL
  INC CL
  AND CL,7
  MOV DX,L
  OR  DX,DX
  JE  @nana
@3:
  MOV BL,DS:[SI]
  XOR BH,BH
  SHL BX,CL
  XCHG BL,BH
  MOV AX,0FFh
  SHL AX,CL
  NOT AX
  XCHG AL,AH
  AND ES:[DI],AX
  OR  ES:[DI],BX
  INC SI
  INC DI
  DEC DX
  OR  DX,DX
  JNZ @3
@nana:
  CMP StupidEnd,0
  JE  @6
   {***Damnation de fin monstreuse***}
  MOV BX,X2
  DEC BX
  AND BX,7
  MOV DL,Byte Ptr EndPlane[BX]
  MOV BL,DS:[SI]
  AND BL,DL
  XOR BH,BH
  SHL BX,CL
  XCHG BL,BH
  MOV AX,0FFh
  AND AL,DL
  SHL AX,CL
  NOT AX
  XCHG AL,AH
  AND ES:[DI],AX
  OR  ES:[DI],BX
  INC SI
@6:
  INC Y1
  MOV AX,Y2
  CMP Y1,AX
  JBE @2
@End:
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

Procedure SetAttr;Begin SetCube(X,Y,GetChr(X,Y),Attr)End;

Procedure SetBackgroundColor;Begin End;
Procedure SetBlink;Begin End;

Procedure SetBorderColor;Assembler;ASM
 MOV DX,03D9h
 MOV AL,Kr
 AND AL,0Fh
 OUT DX,AL
END;

Procedure SetBytesPerLn;Assembler;ASM
 MOV AX,X
 MOV DataVideo.MIV.BytesPerLine,AX
 PUSH AX
  {$IFOPT G+}
   SHR AX,3
  {$ELSE}
   SHR AX,1
   SHR AX,1
   SHR AX,1
  {$ENDIF}
  MOV AH,AL
  MOV DX,3D4h
  MOV AL,13h
  OUT DX,AX
   { Fixe les longueurs des lignes... }
  XOR AX,AX
  MOV CX,400 { Nombre de ligne }
  MOV BX,Offset RealRawY
 POP DX
@L:
 MOV CS:[BX],AX
 INC BX
 INC BX
 ADD AX,DX
 LOOP @L
END;

Procedure SetChr;Begin
 SetCube(X,Y,Chr,GetAttr(X,Y))
End;

Procedure SetChrWidth;Begin
End;

Procedure SetCube;
Var
 J:Word;
 Value,Value2,M,Mx:Byte;
Begin
 ASM
  MOV AL,DataVideo.MIV.NumXTexts
  MOV M,AL
  DEC AL
  MOV Mx,AL
 END;
 If(X>Mx)Then Begin
  Inc(Y,X div M);
  X:=X mod M;
 End;
 ASM
  MOV BL,Byte Ptr Attr
  XOR BH,BH
  {$IFOPT G+}
   SHR BX,4
  {$ELSE}
   MOV CL,4
   SHR BX,CL
  {$ENDIF}
  MOV CL,Byte Ptr SpcAttr[BX]
  MOV Value,CL
  MOV BL,Attr
  MOV BH,0
  MOV AL,Byte Ptr AttributForeground[BX]
  MOV Value2,AL
  MOV BL,Chr
  XOR BH,BH
  SHL BX,1
  MOV AX,Word Ptr RawY[BX]
  LES SI,DataVideo.MIV.TxtMtx
  ADD SI,AX
  MOV BL,Y
  XOR BH,BH
  SHL BX,1
  MOV AX,Word Ptr RawY[BX]
  MOV J,AX
  PUSH DS
   MOV DS,DataVideo.MIV.SegVideo
   MOV CL,DataVideo.MIV.HeightChar
   XOR CH,CH
   MOV AL,X
   XOR AH,AH
@1:MOV DL,ES:[SI]
   MOV DH,DL
   AND DL,Value2
   MOV BH,DL
   MOV BL,Value
   NOT DH
   AND BL,DH
   OR  BL,BH
   MOV DI,J
   SHL DI,1
   MOV DI,Word Ptr RealRawY[DI]
   ADD DI,AX
   MOV DS:[DI],BL
   INC J
   INC SI
   LOOP @1
  POP DS
  MOV BL,Y
  XOR BH,BH
  SHL BX,1
  MOV DI,Word Ptr RawTxtY[BX]
  MOV BL,X
  ADD DI,BX
  SHL DI,1
  MOV ES,DataVideo.MIV.SegBuffer
  MOV AL,Chr
  MOV AH,Attr
  MOV ES:[DI],AX
 END;
End;

{$I GFXSETCU.INC}

Procedure SetGCube;Assembler;Var Fore,Back:Byte;ASM
 MOV AL,Attr
 MOV AH,AL
 AND AH,0Fh
 MOV Fore,AH
 MOV CL,4
 SHR AL,CL
 MOV Back,AL
 MOV BL,Chr
 XOR BH,BH
 SHL BX,1
 MOV SI,Word Ptr RawY[BX]
 ADD SI,Word Ptr DataVideo.MIV.TxtMtx
 PUSH DS
  MOV DS,Word Ptr DataVideo.MIV.TxtMtx[2]
  MOV CL,DataVideo.MIV.HeightChar
  XOR CH,CH
  ADD SI,CX
  DEC SI
@@Loop:
  PUSH CX
   PUSH SI
    PUSH X
    DEC CX
    ADD CX,Y
    PUSH CX
    PUSH Word Ptr DS:[SI]
    PUSH Word Ptr Back
    PUSH Word Ptr Fore
    PUSH CS
    CALL Near Ptr Copy8Bin
   POP SI
  POP CX
  DEC SI
  LOOP @@Loop
 POP DS
END;

Procedure SetGCubeT;Assembler;ASM
 AND Attr,0Fh
 MOV BL,Chr
 XOR BH,BH
 SHL BX,1
 MOV SI,Word Ptr RawY[BX]
 ADD SI,Word Ptr DataVideo.MIV.TxtMtx
 PUSH DS
  MOV DS,Word Ptr DataVideo.MIV.TxtMtx[2]
  MOV CL,DataVideo.MIV.HeightChar
  XOR CH,CH
  ADD SI,CX
  DEC SI
@@Loop:
  PUSH SI
   PUSH CX
    PUSH X
    DEC CX
    ADD CX,Y
    PUSH CX
    PUSH Word Ptr DS:[SI]
    PUSH Word Ptr Attr
    PUSH CS
    CALL Near Ptr CopT8Bin
   POP CX
  POP SI
  DEC SI
  LOOP @@Loop
 POP DS
END;

Procedure SetPalBlk;Assembler;ASM
 CMP PhysVideo.PIV.VGA,Ya
 JE  @VGA
 CMP PhysVideo.PIV.EGA,Ya
 JE  @EGA
 MOV DX,03C9h
 XOR AL,AL
 OUT DX,AL
 JMP @End
@EGA:
 MOV DX,03C0h
 MOV BX,Start
 MOV AX,32
 MOV CX,Nm
@1:
 OUT DX,AX
 INC AL
 LOOP @1
 JMP @End
@VGA:
 MOV AL,Byte Ptr Start
 MOV DX,03C8h
 OUT DX,AL
 INC DX
 XOR AX,AX
 MOV CX,Nm
@Loop2:
 OUT DX,AL
 OUT DX,AL
 OUT DX,AL
 LOOP @Loop2
@End:
END;

Procedure TmpRGB;Assembler;ASM
 DW 0
END;

Procedure SetPaletteRGB;Assembler;ASM
 MOV AL,R
 MOV AH,G
 MOV Word Ptr TmpRGB,AX
 MOV BL,B
 MOV Byte Ptr TmpRGB[2],BL
 PUSH CS
 {$IFOPT G+}
  PUSH Offset TmpRGB
 {$ELSE}
  MOV AX,Offset TmpRGB
  PUSH AX
 {$ENDIF}
 PUSH Start
 {$IFOPT G+}
  PUSH 1
 {$ELSE}
  MOV AX,1
  PUSH AX
 {$ENDIF}
 PUSH CS
 CALL Near Ptr SetPalRGB
END;

Procedure SetPalRGB;Assembler;ASM
 PUSH DS
  CLD
  LDS SI,P
  CMP PhysVideo.PIV.CardCat,cvnVGA
  JB  @1
  MOV AL,Byte Ptr Start
  MOV DX,03C8h
  OUT DX,AL
  INC DX
  XOR AX,AX
  MOV AX,Num
  MOV CX,AX
  ADD CX,AX
  ADD CX,AX
@Loop2:
  LODSB
  {$IFOPT G+}
   SHR AL,2
  {$ELSE}
   SHR AL,1
   SHR AL,1
  {$ENDIF}
  OUT DX,AL
  LOOP @Loop2
  JMP @End
@1:
  MOV CX,Num
  MOV DX,03C0h
  MOV BL,Byte Ptr Start
@2:LODSB {Rouge}
  {$IFOPT G+}
   SHR AL,2
  {$ELSE}
   SHR AL,1
   SHR AL,1
  {$ENDIF}
  MOV AH,AL
  AND AH,32
  {$IFOPT G+}
   SHR AL,2
  {$ELSE}
   SHR AL,1
   SHR AL,1
  {$ENDIF}
  AND AL,4
  OR  AH,AL
  LODSB {Vert}
  {$IFOPT G+}
   SHR AL,3
  {$ELSE}
   SHR AL,1
   SHR AL,1
   SHR AL,1
  {$ENDIF}
  MOV BH,AL
  AND BH,16
  OR  AH,BH
  {$IFOPT G+}
   SHR AL,2
  {$ELSE}
   SHR AL,1
   SHR AL,1
  {$ENDIF}
  AND AL,2
  OR  AH,AL
  LODSB{Bleu}
  {$IFOPT G+}
   SHR AL,4
  {$ELSE}
   SHR AL,1
   SHR AL,1
   SHR AL,1
   SHR AL,1
  {$ENDIF}
  MOV BH,AL
  AND BH,8
  OR  AH,BH
  {$IFOPT G+}
   SHR AL,2
  {$ELSE}
   SHR AL,1
   SHR AL,1
  {$ENDIF}
  MOV BH,AL
  AND AL,1
  OR  AH,AL
  CMP PhysVideo.PIV.EGA,Ya
  JE  @EGA
@CGA:
  MOV DX,03D9h
  MOV AL,AH
  JMP @Next
@EGA:
  MOV AL,BL { Mise … jour de la position.}
  AND AL,1Fh
  ADD AL,32
  OUT DX,AX
@Next:
  INC BL
  LOOP @2
@End:
 POP DS
END;

Procedure SetPg;Begin End;

Procedure SetPixel;Assembler;ASM
 TEST X,8000h
 JNZ @End
 MOV BX,Y
 SHL BX,1
 MOV DI,Word Ptr RealRawY[BX]
 MOV ES,DataVideo.MIV.SegVideo
 MOV AX,X
 {$IFOPT G+}
  SHR AX,3
 {$ELSE}
  SHR AX,1
  SHR AX,1
  SHR AX,1
 {$ENDIF}
 ADD DI,AX
 MOV CH,Byte Ptr X
 AND CH,7
 MOV CL,7
 SUB CL,CH
 MOV BH,Byte Ptr Kr
 AND BH,1
 SHL BH,CL
 MOV BL,1
 SHL BL,CL
 NOT BL
 MOV AL,ES:[DI]
 AND AL,BL
 OR  AL,BH
 MOV ES:[DI],AL
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
 XOR AX,AX
 MOV ES,AX
 MOV DX,ES:[463h]
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
 XOR AX,AX
 MOV ES,AX
 MOV DX,ES:[463h]
 MOV AL,0Ch
 MOV AH,CH
 OUT DX,AX
 MOV AL,0Dh
 MOV AH,CL
 OUT DX,AX
END;

Procedure SetVisualPg;Begin End;

Procedure WriteMode;Assembler;ASM
 DB 0
END;

Procedure SetWriteMode;Assembler;ASM
 CMP PhysVideo.PIV.CardCat,cvnEGA;JB @1
 MOV DX,03CEh
 MOV AL,03h
 MOV AH,Mode
 AND AH,3
 MOV Byte Ptr WriteMode,AH
 {$IFOPT G+}SHL AH,3{$ELSE}SHL AH,1;SHL AH,1;SHL AH,1{$ENDIF}
 OUT DX,AX
@1:
END;

Procedure SplitScreen;Assembler;ASM
 CMP PhysVideo.PIV.VGA,Ya
 JNE @End
 XOR AX,AX
 MOV ES,AX
 MOV DX,ES:[463h]
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

Procedure FillBnk;Assembler;ASM
 MOV ES,DataVideo.MIV.SegVideo
 CMP DataVideo.MIV.Mode,vmGrf640x200c2
 JE  @FuckedLine
 MOV DI,Word Ptr aY
 MOV AL,Byte Ptr Kr
 MOV AH,AL
 MOV CX,L
 SHR CX,1
 REP STOSW
 ADC CX,CX
 REP STOSB
 JMP @End
@FuckedLine:
 XOR DX,DX
 MOV AX,Word Ptr aY
 DIV Word Ptr DataVideo.MIV.BytesPerLine
 MOV SI,AX
 XCHG BX,AX
 SHL BX,1
 MOV DI,Word Ptr RealRawY[BX]
 ADD DI,DX
 MOV CX,L
 MOV AL,Byte Ptr Kr
 CLD
@1:
 STOSB
 INC DX
 CMP DL,80
 JNE @3
 XOR DX,DX
 INC SI
 MOV BX,SI
 SHL BX,1
 MOV DI,Word Ptr RealRawY[BX]
@3:
 LOOP @1
@End:
END;

{$I GrfIcon.Inc}
{$I Done.Inc}