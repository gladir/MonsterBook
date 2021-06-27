{Drv400.Inc}

Procedure RawTxtY;Forward;
Procedure RawY;Forward;
Procedure RealRawY;Forward;

Procedure _Driver400;Assembler;ASM
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
 JMP PutSprite.Near
 JMP PutTxtXY.Near
 JMP PutTxtXYUnKr.Near
 JMP SetAttr.Near
 JMP SetBackgroundColor.Near
 RETF 2 {SetBlink(X:Bool)}
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
 JMP SetPg.Near
 JMP SetPixel.Near
 RETF 2 {SetUnderline(X:Bool)}
 JMP SetVerticalScale.Near
 JMP SetVisualPg.Near
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
 DW 0A000h{SegV:Segment vid‚o (A000h,B000h,B800h,...)}
 DB 16{HeightChr:Hauteur de la police de caractŠre actuel}
 DW 320{NmXPixels:Nombre de pixels horizontal qu'affiche l'‚cran}
 DW 400{NmYPixels:Nombre de pixels vertical qu'affiche l'‚cran}
 DB 40,25{NmXTxts,NmYTxts:Nombre de caractŠre texte horizontal/vertical qu'affiche l'‚cran}
 DB 2{NmVidPgs:Nombre de page vid‚o que supporte le mode actuel}
 DD 256{NmColrs:Nombre de couleurs affich‚}
 DB 8{BitsPerPixel:Nombre de Bit(s) utilis‚ pour l'affichage d'un pixel}
 DW 80{BytesPerLn:Nombre d'octet par ligne affich‚ (trŠs relatif en VGA...)}
 DB 0{Pg:Num‚ro de la page vid‚o de travail}
 DW 0{AddrPg:En texte, adresse en m‚moire vid‚o de la page actuel}
 DB 0{ShowPg:Num‚ro de la page vid‚o actuellement affich‚}
 DD 0{TxtMtx:Pointeur sur la police de caractŠre courante}
 DD 128000{ScrSize:Taille de l'‚cran}
 DW 0{SizeBnk:Taille d'un page de la banque (0=64Ko)}
 DW 0{SegBuf:Segment du tampon d'acc‚l‚ration}
 DB 0{IsDblMtx:Y a-t-il une police de 512 caractŠres?}
 DB 0,0 {XCur,YCur:Position actuel du curseur}
 DB 0,0 {StartCur,EndCur:D‚but et fin du curseur}
END;

Procedure RawTxtY;Assembler;ASM
    {  0    1    2    3    4    5    6    7    8    9   10   11   12}
 DW    0,  40,  80, 120, 160, 200, 240, 280, 320, 360, 400, 440, 480 { 0 … 12 }
 DW  520, 560, 600, 640, 680, 720, 760, 800, 840, 880, 920, 960      { 12 … 24 }
 DW    0,  40,  80, 120, 160, 200, 240, 280, 320, 360, 400, 440, 480
 DW  520, 560, 600, 640, 680, 720, 760, 800, 840, 880, 920, 960
 DW    0,  40,  80, 120, 160, 200, 240, 280, 320, 360, 400, 440, 480
 DW  520, 560, 600, 640, 680, 720, 760, 800, 840, 880, 920, 960
 DW    0,  40,  80, 120, 160, 200, 240, 280, 320, 360, 400, 440, 480
 DW  520, 560, 600, 640, 680, 720, 760, 800, 840, 880, 920, 960
 DW Offset PhysVideo
END;

Procedure RealRawY;Assembler;ASM
  {0 … 199}
 DW     0,   80,  160,  240,  320,  400,  480,  560,  640,  720,  800,  880{0 … 11}
 DW   960, 1040, 1120, 1200, 1280, 1360, 1440, 1520, 1600, 1680, 1760, 1840{12 … 23}
 DW  1920, 2000, 2080, 2160, 2240, 2320, 2400, 2480, 2560, 2640, 2720, 2800{24 … 35}
 DW  2880, 2960, 3040, 3120, 3200, 3280, 3360, 3440, 3520, 3600, 3680, 3760{36 … 47}
 DW  3840, 3920, 4000, 4080, 4160, 4240, 4320, 4400, 4480, 4560, 4640, 4720{48 … 63}
 DW  4800, 4880, 4960, 5040, 5120, 5200, 5280, 5360, 5440, 5520, 5600, 5680{64 … 75}
 DW  5760, 5840, 5920, 6000, 6080, 6160, 6240, 6320, 6400, 6480, 6560, 6640{76 … 87}
 DW  6720, 6800, 6880, 6960, 7040, 7120, 7200, 7280, 7360, 7440, 7520, 7600{88 … 95}
 DW  7680, 7760, 7840, 7920, 8000, 8080, 8160, 8240, 8320, 8400, 8480, 8560{96 … 107}
 DW  8640, 8720, 8800, 8880, 8960, 9040, 9120, 9200, 9280, 9360, 9440, 9520{108 … 119}
 DW  9600, 9680, 9760, 9840, 9920,10000,10080,10160,10240,10320,10400,10480{120 … 131}
 DW 10560,10640,10720,10800,10880,10960,11040,11120,11200,11280,11360,11440{132 … 143}
 DW 11520,11600,11680,11760,11840,11920,12000,12080,12160,12240,12320,12400{144 … 155}
 DW 12480,12560,12640,12720,12800,12880,12960,13040,13120,13200,13280,13360{156 … 167}
 DW 13440,13520,13600,13680,13760,13840,13920,14000,14080,14160,14240,14320{168 … 179}
 DW 14400,14480,14560,14640,14720,14800,14880,14960,15040,15120,15200,15280{180 … 191}
 DW 15360,15440,15520,15600,15680,15760,15840,15920
  { 200 … 399 }
 DW 16000,16080,16160,16240,16320,16400,16480,16560,16640,16720,16800,16880
 DW 16960,17040,17120,17200,17280,17360,17440,17520,17600,17680,17760,17840
 DW 17920,18000,18080,18160,18240,18320,18400,18480,18560,18640,18720,18800
 DW 18880,18960,19040,19120,19200,19280,19360,19440,19520,19600,19680,19760
 DW 19840,19920,20000,20080,20160,20240,20320,20400,20480,20560,20640,20720
 DW 20800,20880,20960,21040,21120,21200,21280,21360,21440,21520,21600,21680
 DW 21760,21840,21920,22000,22080,22160,22240,22320,22400,22480,22560,22640
 DW 22720,22800,22880,22960,23040,23120,23200,23280,23360,23440,23520,23600
 DW 23680,23760,23840,23920,24000,24080,24160,24240,24320,24400,24480,24560
 DW 24640,24720,24800,24880,24960,25040,25120,25200,25280,25360,25440,25520
 DW 25600,25680,25760,25840,25920,26000,26080,26160,26240,26320,26400,26480
 DW 26560,26640,26720,26800,26880,26960,27040,27120,27200,27280,27360,27440
 DW 27520,27600,27680,27760,27840,27920,28000,28080,28160,28240,28320,28400
 DW 28480,28560,28640,28720,28800,28880,28960,29040,29120,29200,29280,29360
 DW 29440,29520,29600,29680,29760,29840,29920,30000,30080,30160,30240,30320
 DW 30400,30480,30560,30640,30720,30800,30880,30960,31040,31120,31200,31280
 DW 31360,31440,31520,31600,31680,31760,31840,31920
  { 400 … 599 }
 DW 32000,32080,32160,32240,32320,32400,32480,32560,32640,32720,32800,32880
 DW 32960,33040,33120,33200,33280,33360,33440,33520,33600,33680,33760,33840
 DW 33920,34000,34080,34160,34240,34320,34400,34480,34560,34640,34720,34800
 DW 34880,34960,35040,35120,35200,35280,35360,35440,35520,35600,35680,35760
 DW 35840,35920,36000,36080,36160,36240,36320,36400,36480,36560,36640,36720
 DW 36800,36880,36960,37040,37120,37200,37280,37360,37440,37520,37600,37680
 DW 37760,37840,37920,38000,38080,38160,38240,38320,38400,38480,38560,38640
 DW 38720,38800,38880,38960,39040,39120,39200,39280,39360,39440,39520,39600
 DW 39680,39760,39840,39920,40000,40080,40160,40240,40320,40400,40480,40560
 DW 40640,40720,40800,40880,40960,41040,41120,41200,41280,41360,41440,41520
 DW 41600,41680,41760,41840,41920,42000,42080,42160,42240,42320,42400,42480
 DW 42560,42640,42720,42800,42880,42960,43040,43120,43200,43280,43360,43440
 DW 43520,43600,43680,43760,43840,43920,44000,44080,44160,44240,44320,44400
 DW 44480,44560,44640,44720,44800,44880,44960,45040,45120,45200,45280,45360
 DW 45440,45520,45600,45680,45760,45840,45920,46000,46080,46160,46240,46320
 DW 46400,46480,46560,46640,46720,46800,46880,46960,47040,47120,47200,47280
 DW 47360,47440,47520,47600,47680,47760,47840,47920
  { 600 … 799 }
 DW 48000,48080,48160,48240,48320,48400,48480,48560,48640,48720,48800,48880
 DW 48960,49040,49120,49200,49280,49360,49440,49520,49600,49680,49760,49840
 DW 49920,50000,50080,50160,50240,50320,50400,50480,50560,50640,50720,50800
 DW 50880,50960,51040,51120,51200,51280,51360,51440,51520,51600,51680,51760
 DW 51840,51920,52000,52080,52160,52240,52320,52400,52480,52560,52640,52720
 DW 52800,52880,52960,53040,53120,53200,53280,53360,53440,53520,53600,53680
 DW 53760,53840,53920,54000,54080,54160,54240,54320,54400,54480,54560,54640
 DW 54720,54800,54880,54960,55040,55120,55200,55280,55360,55440,55520,55600
 DW 55680,55760,55840,55920,56000,56080,56160,56240,56320,56400,56480,56560
 DW 56640,56720,56800,56880,56960,57040,57120,57200,57280,57360,57440,57520
 DW 57600,57680,57760,57840,57920,58000,58080,58160,58240,58320,58400,58480
 DW 58560,58640,58720,58800,58880,58960,59040,59120,59200,59280,59360,59440
 DW 59520,59600,59680,59760,59840,59920,60000,60080,60160,60240,60320,60400
 DW 60480,60560,60640,60720,60800,60880,60960,61040,61120,61200,61280,61360
 DW 61440,61520,61600,61680,61760,61840,61920,62000,62080,62160,62240,62320
 DW 62400,62480,62560,62640,62720,62800,62880,62960,63040,63120,63200,63280
 DW 63360,63440,63520,63600,63680,63760,63840,63920
  { 800 … 819 }
 DW 64000,64080,64160,64240,64320,64400,64480,64560,64640,64720,64800,64880
 DW 64960,65040,65120,65200,65280,65360,65440,65520
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

Procedure BarChrHor;Var I:Byte;Begin
 For I:=X1 to(X2)do SetChr(I,Y,Chr)
End;

Procedure BarChrVer;Var J:Byte;Begin
 For J:=Y1 to(Y2)do SetChr(X,J,Chr)
End;

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
 ADD AX,DataVideo.MIV.AddrPage
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
   ADD AX,DataVideo.MIV.AddrPage
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

Procedure ClrScrSize;Assembler;ASM
 DW 32000/2
END;

Procedure ClrScr;Assembler;ASM
 CLD
 MOV AX,0F02h
 MOV DX,03C4h
 OUT DX,AX
 MOV ES,DataVideo.MIV.SegVideo
 MOV DI,DataVideo.MIV.AddrPage
 MOV AL,Attr
 {$IFOPT G+}
  SHR AL,4
 {$ELSE}
  MOV CL,4
  SHR AL,CL
 {$ENDIF}
 MOV AH,AL
 MOV CX,Word Ptr ClrScrSize
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
 ADD AX,DataVideo.MIV.AddrPage
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
 MOV ES,DataVideo.MIV.SegVideo
 MOV CX,X
 AND CX,3
 MOV AH,CL
 MOV DX,03CEh
 MOV AL,4
 OUT DX,AX
 MOV DI,Y
 SHL DI,1
 MOV DI,Word Ptr RealRawY[DI]
 MOV AX,X
 {$IFOPT G+}SHR AX,2{$ELSE}SHR AX,1;SHR AX,1{$ENDIF}
 ADD DI,AX
 ADD DI,DataVideo.MIV.AddrPage
(* {$IFDEF __386__}
  DB 26h,0Fh,0B6h,05h {MOVZX AX,Byte Ptr ES:[DI]}
 {$ELSE}*)
  MOV AL,ES:[DI]
  XOR AH,AH
(* {$ENDIF}*)
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

Procedure GetSmlImg;Var J,L:Wd;Begin
 L:=X2-X1+1;
 For J:=0to(Y2-Y1)do Begin
  GetLnHorImg(X1,J+Y1,X2,Buffer);
  ASM MOV AX,L;ADD Word Ptr Buffer,AX;END;
 End;
End;

Procedure OldRegister9;Assembler;ASM
 DB 0
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
 MOV DX,3D4h
 MOV AL,9
 OUT DX,AL
 INC DX
 IN  AL,DX
 MOV Byte Ptr OldRegister9,AL
 AND AL,01110000b
 OUT DX,AL
 MOV BX,4000/16 { BUG: Le nombre doit ˆtre (40x25)x2=2000/16 paragraphes
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
 MOV CX,2000 {1000}  {2000/2=1000}
 CLD
 REP STOSW
@2:
END;

{$I MoveT256.Inc}

Procedure PCopy;Var A,B:Wd;Begin
 ASM
  AND S,1
  AND T,1
 END;
 A:=S*32000;B:=T*32000;
 ASM
  PUSH DS
   MOV ES,DataVideo.MIV.SegVideo
   PUSH ES
   POP DS
   CLD
    { Fixe la plage 0 }
   MOV DX,3C4h
   MOV AX,2+(1 shl 8)
   OUT DX,AX
   MOV DX,3CEh
   MOV AX,4+(0 shl 8)
   OUT DX,AX
    { Transfert le contenu m‚moire}
   MOV SI,A
   MOV DI,B
   MOV CX,32000 shr 1
   REP MOVSW
    { Fixe la plage 1 }
   MOV DX,3C4h
   MOV AX,2+(2 shl 8)
   OUT DX,AX
   MOV DX,3CEh
   MOV AX,4+(1 shl 8)
   OUT DX,AX
    { Transfert le contenu m‚moire}
   MOV SI,A
   MOV DI,B
   MOV CX,32000 shr 1
   REP MOVSW
    { Fixe la plage 2 }
   MOV DX,3C4h
   MOV AX,2+(4 shl 8)
   OUT DX,AX
   MOV DX,3CEh
   MOV AX,4+(2 shl 8)
   OUT DX,AX
    { Transfert le contenu m‚moire}
   MOV SI,A
   MOV DI,B
   MOV CX,32000 shr 1
   REP MOVSW
    { Fixe la plage 3 }
   MOV DX,3C4h
   MOV AX,2+(8 shl 8)
   OUT DX,AX
   MOV DX,3CEh
   MOV AX,4+(3 shl 8)
   OUT DX,AX
    { Transfert le contenu m‚moire}
   MOV SI,A
   MOV DI,B
   MOV CX,32000 shr 1
   REP MOVSW
  POP DS
 END;
End;

{$I PutCharG.Inc}

Procedure PutFillBox;Assembler;ASM
 {$IFDEF __320x400c256}
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
 {$ELSE}
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
  MOV ES,DataVideo.MIV.SegV
@@Home:
  MOV DI,BX
  MOV CX,SI
  REP STOSB
  ADD BX,DataVideo.MIV.BytesPerLn
  INC DX
  CMP Y2,DX
  JAE @@Home
 {$ENDIF}
END;

Function AbsInt(I:Int):Int;Near;Assembler;ASM MOV AX,I;OR AX,AX;JGE @1;NEG AX;@1:END;

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

Procedure PutSmlImg;Var J,L:Wd;Begin
 L:=X2-X1+1;
 For J:=0to(Y2-Y1)do Begin
  ClrLnHorImg(X1,J+Y1,L,8,Buffer);
  ASM MOV AX,L;ADD Word Ptr Buffer,AX;END;
 End;
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

Procedure SetAttr;Begin
 SetCube(X,Y,GetChr(X,Y),Attr)
End;

Procedure SetBackgroundColor;Begin
End;

Procedure SetBorderColor;Assembler;ASM
 MOV DX,3DAh
 IN  AL,DX                  { active le mode index de l'ATC }
 MOV DL,0C0h
 MOV AL,011h or 32           { s‚lectionne le registre 11h }
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
  MOV CX,820 { Nombre de ligne }
  MOV BX,Offset RealRawY
 POP DX
@L:
 MOV CS:[BX],AX
 INC BX
 INC BX
 ADD AX,DX
 LOOP @L
END;

Procedure SetChr;Begin SetCube(X,Y,Chr,GetAttr(X,Y))End;

Procedure SetChrWidth;Label X;Begin
 Case(L)of
  0:ASM{320x200x256}
   MOV Word Ptr ClrScrSize,16000/2
   MOV DX,3D4h
   MOV AL,9
   OUT DX,AL
   INC DX
   MOV AL,Byte Ptr OldRegister9
   OUT DX,AL
   MOV BX,200
   MOV AX,64000 AND 0FFFFh
   MOV DX,64000 SHR 16
   JMP X
  END;
  1:ASM{320x400x256}
   MOV Word Ptr ClrScrSize,32000/2
   MOV DX,3D4h
   MOV AL,9
   OUT DX,AL
   INC DX
   MOV AL,Byte Ptr OldRegister9
   AND AL,01110000b
   OUT DX,AL
   MOV BX,400
   MOV AX,128000 AND 0FFFFh
   MOV DX,128000 SHR 16
X: MOV DataVideo.MIV.NumYPixels,BX
   MOV Word Ptr DataVideo.MIV.ScrSize,AX
   MOV Word Ptr DataVideo.MIV.ScrSize[2],DX
  END;
 End;
End;

{$I scx256.Inc}

Procedure SetCur;Assembler;ASM
 {$IFOPT G+}
  PUSH 0
  POP ES
 {$ELSE}
  XOR AX,AX
  MOV ES,AX
 {$ENDIF}
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
 {$IFOPT G+}SHR AL,2{$ELSE}SHR AL,1;SHR AL,1{$ENDIF}
 OUT DX,AL
 MOV AL,G
 {$IFOPT G+}SHR AL,2{$ELSE}SHR AL,1;SHR AL,1{$ENDIF}
 OUT DX,AL
 MOV AL,B
 {$IFOPT G+}SHR AL,2{$ELSE}SHR AL,1;SHR AL,1{$ENDIF}
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
  {$IFOPT G+}SHR AL,2{$ELSE}SHR AL,1;SHR AL,1{$ENDIF}
  OUT DX,AL
  LOOP @2
 POP DS
END;

Procedure SetPg;Assembler;ASM
 MOV BL,Pg
 AND BL,1
 MOV DataVideo.MIV.Pg,BL
 XOR AX,AX
 OR  BL,BL
 JZ  @1
 MOV AH,32000 shr 8
@1:
 MOV DataVideo.MIV.AddrPage,AX
END;

Procedure SetPixel;Assembler;ASM
 TEST X,8000h
 JNZ @End
 MOV ES,DataVideo.MIV.SegVideo
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
 {$IFOPT G+}SHR CX,3{$ELSE}SHR CX,1;SHR CX,1;SHR CX,1{$ENDIF}
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

Procedure SetVisualPg;Assembler;ASM
 MOV BL,Pg
 AND BL,1
 MOV DataVideo.MIV.ShowPage,BL
 XOR AX,AX
 OR  BL,BL
 JZ  @1
 MOV AH,32000 shr 8
@1:
 MOV BL,AL
 MOV DX,3D4h
 MOV AL,12
 OUT DX,AL
 INC DX
 MOV AL,AH
 OUT DX,AL
 DEC DX
 MOV AL,13
 OUT DX,AL
 INC DX
 MOV AL,BL
 OUT DX,AL
END;

Procedure WriteMode;Assembler;ASM DB 0;END;

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
 {$IFOPT G+}SHR CX,4{$ELSE}SHR CX,1;SHR CX,1;SHR CX,1;SHR CX,1{$ENDIF}
 AND CL,16
 OR  AL,CL
 OUT DX,AL
 DEC DX
 MOV AL,09h
 OUT DX,AL
 INC DX
 IN  AL,DX
 AND AL,10111111b
 {$IFOPT G+}SHR BL,3{$ELSE}SHR BL,1;SHR BL,1;SHR BL,1{$ENDIF}
 AND BL,64
 OR  AL,BL
 OUT DX,AL
 DEC DX
 MOV AL,18h
 MOV AH,Byte Ptr Y
 OUT DX,AX
@End:
END;

Procedure ReadBnk;Assembler;Var Start,StartPlane:Wd;Len:Int;ASM
 LES AX,x0
 MOV CX,ES
 OR  CX,AX
 JZ  @End
 PUSH DS
  MOV AX,L
  {$IFOPT G+}SHR AX,2{$ELSE}SHR AX,1;SHR AX,1{$ENDIF}
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
  MOV DX,$3CE
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
@2:LODSB
  STOSB
  INC DI
  INC DI
  INC DI
  LOOP @2
@3:
   { Fixe la plage 1 }
  MOV DX,$3CE
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
@2b:LODSB
  STOSB
  INC DI
  INC DI
  INC DI
  LOOP @2b
@3b:
   { Fixe la plage 2 }
  MOV DX,$3CE
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
@2c:LODSB
  STOSB
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
@2d:LODSB
  STOSB
  INC DI
  INC DI
  INC DI
  LOOP @2d
@3d:
 POP DS
@End:
END;

Procedure WriteBnk;Assembler;Var Start,StartPlane:Wd;Len:Int;ASM
 PUSH DS
  MOV AX,L
  {$IFOPT G+}SHR AX,2{$ELSE}SHR AX,1;SHR AX,1{$ENDIF}
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

Procedure FillBnk;Assembler;Var Start,StartPlane:Wd;Len:Int;ASM
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
@1:{For J:=0to(Len)do Begin;Mem[_A000:P1]:=Kr;Inc(P1)End;}
 ADD CX,Len
 MOV AL,Byte Ptr Kr
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
  {For J:=0to(Len)do Begin;Mem[_A000:P1]:=Kr;Inc(P1)End;}
 ADD CX,Len
 MOV AL,Byte Ptr Kr
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
 ADD CX,Len
 MOV AL,Byte Ptr Kr
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