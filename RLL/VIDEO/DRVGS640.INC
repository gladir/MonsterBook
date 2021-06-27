{DrvGS640.Inc}

Procedure RawTxtY;Forward;
Procedure RawY;Forward;
Procedure RealRawY;Forward;

Procedure _DriverGS640;Assembler;ASM
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
 JMP SetMatrix.Near
 JMP SetModeMtx.Near
 JMP SetModeScr.Near
 RETF 4 {SetPalBlk(Start,Nm:Wd)}
 RETF 8 {SetPaletteRGB(Start:Wd;R,G,B:Byte)}
 RETF 8 {SetPalRGB(Var P;Start,Num:Wd)}
 JMP SetPg.Near
 JMP SetPixel.Near
 RETF 2 {SetUnderline(X:Bool)}
 JMP SetVerticalScale.Near
 JMP SetVisualPg.Near
 RETF 2 {SetWriteMode(Mode:Byte)}
 RETF 2 {SplitScreen(Y:Wd)}
 RETF 2 {SetBnkPg(Pg:Byte)}
 RETF 10 {ReadBnk(P:Long;Size:Wd;Var x0)}
 RETF 10 {WriteBnk(P:Long;Size:Wd;Var x0)}
 RETF 8{FillBnk(aY:Long;L,Kr:Wd)}
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
 DW $B000{SegV:Segment vid‚o (A000h,B000h,B800h,...)}
 DB 8{HeightChr:Hauteur de la police de caractŠre actuel}
 DW 640{NmXPixels:Nombre de pixels horizontal qu'affiche l'‚cran}
 DW 200{NmYPixels:Nombre de pixels vertical qu'affiche l'‚cran}
 DB 80,25{NmXTxts,NmYTxts:Nombre de caractŠre texte horizontal/vertical qu'affiche l'‚cran}
 DB 1{NmVidPgs:Nombre de page vid‚o que supporte le mode actuel}
 DD 16{NmColrs:Nombre de couleurs affich‚}
 DB 4{BitsPerPixel:Nombre de Bit(s) utilis‚ pour l'affichage d'un pixel}
 DW 160{BytesPerLn:Nombre d'octet par ligne affich‚ (trŠs relatif en VGA...)}
 DB 0{Pg:Num‚ro de la page vid‚o de travail}
 DW $B800{AddrPg:En texte, adresse en m‚moire vid‚o de la page actuel,
	  GS:Segment vid‚o, partie haute}
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
 DW 1280,1360,1440,1520,1600,1680,1760,1840,1920,2000,2080,2160,Offset PhysVideo
END;

Procedure RealRawY;Assembler;ASM
 DW     0, 8192,16384,24576,  160, 8352,16544,24736,  320, 8512,16704,24896
 DW   480, 8672,16864,25056,  640, 8832,17024,25216,  800, 8992,17184,25376
 DW   960, 9152,17344,25536, 1120, 9312,17504,25696, 1280, 9472,17664,25856
 DW  1440, 9632,17824,26016, 1600, 9792,17984,26176, 1760, 9952,18144,26336
 DW  1920,10112,18304,26496, 2080,10272,18464,26656, 2240,10432,18624,26816
 DW  2400,10592,18784,26976, 2560,10752,18944,27136, 2720,10912,19104,27296
 DW  2880,11072,19264,27456, 3040,11232,19424,27616, 3200,11392,19584,27776
 DW  3360,11552,19744,27936, 3520,11712,19904,28096, 3680,11872,20064,28256
 DW  3840,12032,20224,28416, 4000,12192,20384,28576, 4160,12352,20544,28736
 DW  4320,12512,20704,28896, 4480,12672,20864,29056, 4640,12832,21024,29216
 DW  4800,12992,21184,29376, 4960,13152,21344,29536, 5120,13312,21504,29696
 DW  5280,13472,21664,29856, 5440,13632,21824,30016, 5600,13792,21984,30176
 DW  5760,13952,22144,30336, 5920,14112,22304,30496, 6080,14272,22464,30656
 DW  6240,14432,22624,30816, 6400,14592,22784,30976, 6560,14752,22944,31136
 DW  6720,14912,23104,31296, 6880,15072,23264,31456, 7040,15232,23424,31616
 DW  7200,15392,23584,31776, 7360,15552,23744,31936, 7520,15712,23904,32096
 DW  7680,15872,24064,32256, 7840,16032,24224,32416
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

Procedure RawXv;Assembler;ASM
 DB 6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0
 DB 6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0
 DB 6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0
 DB 6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0
 DB 6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0
 DB 6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0
 DB 6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0
 DB 6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0
 DB 6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0
 DB 6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0
 DB 6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0
 DB 6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0
 DB 6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0
 DB 6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0
 DB 6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0
 DB 6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0
 DB 6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0
 DB 6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0
 DB 6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0
 DB 6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0,6,4,2,0
END;

Procedure RawKrLo;Assembler;ASM
 DB 0,0,1,1,2,2,3,3,0,0,1,1,2,2,3,3,0,1,1,2,2,3,3,0,0,1,1,2,2,3,3,0,1,1,2,2,3,3
 DB 0,0,1,1,2,2,3,3,0,0,1,2,2,3,3,0,0,1,1,2,2,3,3,0,0,1,2,2,3,3,0,0,1,1,2,2,3,3
 DB 0,0,1,1,2,3,3,0,0,1,1,2,2,3,3,0,0,1,1,2,3,3,0,0,1,1,2,2,3,3,0,0,1,1,2,2,3,0
 DB 0,1,1,2,2,3,3,0,0,1,1,2,2,3,0,0,1,1,2,2,3,3,0,0,1,1,2,2,3,3,0,1,1,2,2,3,3,0
 DB 0,1,1,2,2,3,3,0,1,1,2,2,3,3,0,0,1,1,2,2,3,3,0,0,1,2,2,3,3,0,0,1,1,2,2,3,3,0
 DB 0,1,2,2,3,3,0,0,1,1,2,2,3,3,0,0,1,1,2,3,3,0,0,1,1,2,2,3,3,0,0,1,1,2,3,3,0,0
 DB 1,1,2,2,3,3,0,0,1,1,2,2,3,0,0,1,1,2,2,3,3,0,0,1,1,2,2,3
END;

Procedure RawKrHi;Assembler;ASM
 DB 0,2,0,2,0,2,0,2,1,3,1,3,1,3,1,3,2,0,2,0,2,0,2,0,3,1,3,1,3,1,3,1,0,2,0,2,0,2
 DB 0,2,1,3,1,3,1,3,1,3,2,0,2,0,2,0,2,0,3,1,3,1,3,1,3,1,0,2,0,2,0,2,0,2,1,3,1,3
 DB 1,3,1,3,2,0,2,0,2,0,2,0,3,1,3,1,3,1,3,1,0,2,0,2,0,2,0,2,1,3,1,3,1,3,1,3,2,0
 DB 2,0,2,0,2,0,3,1,3,1,3,1,3,1,0,2,0,2,0,2,0,2,1,3,1,3,1,3,1,3,2,0,2,0,2,0,2,0
 DB 3,1,3,1,3,1,3,1,0,2,0,2,0,2,0,2,1,3,1,3,1,3,1,3,2,0,2,0,2,0,2,0,3,1,3,1,3,1
 DB 3,1,0,2,0,2,0,2,0,2,1,3,1,3,1,3,1,3,2,0,2,0,2,0,2,0,3,1,3,1,3,1,3,1,0,2,0,2
 DB 0,2,0,2,1,3,1,3,1,3,1,3,2,0,2,0,2,0,2,0,3,1,3,1,3,1,3,1
END;

Procedure BarChrHor;Var I:Byte;Begin
 For I:=X1 to(X2)do SetChr(I,Y,Chr)
End;

Procedure BarChrVer;Var J:Byte;Begin
 For J:=Y1 to(Y2)do SetChr(X,J,Chr)
End;

Procedure BarSpcHor;Assembler;ASM
  { SI := (Y2 * 8) + 7 }
 MOV AL,Y
 MOV AH,0
 SHL AX,1
 SHL AX,1
 SHL AX,1
 ADD AX,7
 MOV SI,AX
  { BH := (Attr shr 4) and 15 }
 MOV DL,Attr
 MOV CL,4
 SHR DL,CL
 MOV DH,DL
 AND DH,7
 SHL DH,1
 SHR DL,1
 SHR DL,1
 SHR DL,1
 ADD DL,DH
  { C2 }
 MOV BL,DL
 AND BL,3
 MOV AL,BL { 0 }
 SHL BL,1
 SHL BL,1
 OR  AL,BL { 1 }
 SHL BL,1
 SHL BL,1
 OR  AL,BL { 2 }
 SHL BL,1
 SHL BL,1
 OR  AL,BL { 3 }
 MOV BL,AL
  { C1 }
 SHR DL,1
 SHR DL,1
 MOV AL,DL { 0 }
 SHL DL,1
 SHL DL,1
 OR  AL,DL { 1 }
 SHL DL,1
 SHL DL,1
 OR  AL,DL { 2 }
 SHL DL,1
 SHL DL,1
 OR  AL,DL { 3 }
 MOV BH,AL
  { ES := $B800 }
 MOV ES,DataVideo.MIV.SegVideo
 CLD
  { CX := Y1 * 8 }
 MOV AL,Y
 MOV AH,0
 SHL AX,1
 SHL AX,1
 SHL AX,1
 MOV CX,AX
  { DX := ((X2 - X1) + 1) shl 1 }
 MOV DL,X2
 SUB DL,X1
 MOV DH,0
 INC DX
 SHL DX,1
@@Boucle:
 PUSH CX
  MOV DI,CX
  SHR DI,1
  SHR DI,1
  MOV AX,160
  PUSH DX
   MUL DI
  POP DX
  MOV DI,AX
  MOV AX,CX
  AND AX,3
  MOV CL,13
  SHL AX,CL
  ADD DI,AX
  MOV AL,X1
  MOV AH,0
  SHL AX,1
  ADD DI,AX
  MOV AL,BH
  MOV CX,DX
  PUSH DI
   PUSH CX
    MOV AH,AL
    SHR CX,1
    REP STOSW
    ADC CX,CX
    REP STOSB
   POP CX
  POP DI
  MOV AL,BL
  ADD DI,08000h
  MOV AH,AL
  SHR CX,1
  REP STOSW
  ADC CX,CX
  REP STOSB
 POP CX
 INC CX
 CMP CX,SI
 JLE @@Boucle
END;

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

{$I BTHDef.Inc}
{$I Circle.Inc}
{$I ClsCurGr.Inc}

Procedure ClrLnHor;Begin
 PutLnHor(X,Y,X+L-1,Kr)
End;

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
   For I:=0to(L-1)shr 3do Copy8Bin(X+(I shl 3),Y,TBuf[I],MX,MY);
   If L and 7>0Then Begin
    Ta:=TBuf[L-1]; Xa:=X+(L-1)shl 3;
    For I:=0to 7do Begin
     If ((Ta shr I)and 1)=1Then SetPixel(Xa+I,Y,MX)
                           Else SetPixel(Xa+I,Y,MY)
    End;
   End;
  End;
  Else For I:=0to L-1do SetPixel(X+I,Y,TBuf[I])
 End;
End;

Procedure ClrWn;Assembler;ASM
  { SI := (Y2 * 8) + 7 }
 MOV AL,Y2
 MOV AH,0
 SHL AX,1
 SHL AX,1
 SHL AX,1
 ADD AX,7
 MOV SI,AX
  { BH := (Attr shr 4) and 15 }
 MOV DL,Attr
 MOV CL,4
 SHR DL,CL
 MOV DH,DL
 AND DH,7
 SHL DH,1
 SHR DL,1
 SHR DL,1
 SHR DL,1
 ADD DL,DH
  { C2 }
 MOV BL,DL
 AND BL,3
 MOV AL,BL { 0 }
 SHL BL,1
 SHL BL,1
 OR  AL,BL { 1 }
 SHL BL,1
 SHL BL,1
 OR  AL,BL { 2 }
 SHL BL,1
 SHL BL,1
 OR  AL,BL { 3 }
 MOV BL,AL
  { C1 }
 SHR DL,1
 SHR DL,1
 MOV AL,DL { 0 }
 SHL DL,1
 SHL DL,1
 OR  AL,DL { 1 }
 SHL DL,1
 SHL DL,1
 OR  AL,DL { 2 }
 SHL DL,1
 SHL DL,1
 OR  AL,DL { 3 }
 MOV BH,AL
  { ES := $B800 }
 MOV ES,MIV(DataVideo).SegVideo
 CLD;
  { CX := Y1 * 8 }
 MOV AL,Y1
 MOV AH,0
 SHL AX,1
 SHL AX,1
 SHL AX,1
 MOV CX,AX
  { DX := ((X2 - X1) + 1) shl 1 }
 MOV DL,X2
 SUB DL,X1
 MOV DH,0
 INC DX
 SHL DX,1
@@Boucle:
 PUSH CX
  MOV DI,CX
  SHR DI,1
  SHR DI,1
  MOV AX,160
  PUSH DX
   MUL DI
  POP DX
  MOV DI,AX
  MOV AX,CX
  AND AX,3
  MOV CL,13
  SHL AX,CL
  ADD DI,AX
  MOV AL,X1
  MOV AH,0
  SHL AX,1
  ADD DI,AX
  MOV AL,BH
  MOV CX,DX
  PUSH DI
   PUSH CX
    MOV AH,AL
    SHR CX,1
    REP STOSW
    ADC CX,CX
    REP STOSB
   POP CX
  POP DI
  MOV AL,BL
  ADD DI,08000h
  MOV AH,AL
  SHR CX,1
  REP STOSW
  ADC CX,CX
  REP STOSB
 POP CX
 INC CX
 CMP CX,SI
 JLE @@Boucle
END;

Procedure ClrScr;Assembler;ASM
 CLD
 MOV CX,0FFF0h shr 1
 MOV ES,DataVideo.MIV.SegVideo
 XOR DI,DI
 XOR AX,AX
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

Procedure CopT8Bin;Var I:Word;Begin
 For I:=0to 7do Begin
  If Value and$80=$80Then SetPixel(X+I,Y,Fore);
  ASM SHL Value,1;END;
 End
End;

Procedure Copy8Bin;Var I,L:Word;Begin
 For I:=0to 7do Begin
  If Value and$80=$80Then L:=Fore Else L:=Back;
  SetPixel(X+I,Y,L);
  ASM SHL Value,1;END;
 End
End;

Procedure FillBox;Var I,J:Byte;Begin
 For J:=Y1 to(Y2)do For I:=X1 to(X2)do SetCube(I,J,Chr,Attr);
End;

{$I GFXGETCH.INC}

Procedure GetLnHorImg;Var I:Wd;BP:TByte Absolute Buffer;Begin
 For I:=0to(X2-X1)do BP[I]:=GetPixel(I+X1,Y)
End;

Function GetPixel;Assembler;ASM
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
 MOV SI,X
 MOV CL,Byte Ptr RawXv[SI]
 MOV DL,3
 SHL DL,CL
 NOT DL
 MOV ES,DataVideo.MIV.SegVideo
 MOV AL,ES:[DI]
 AND AL,DL
 SHR AL,CL
 {$IFOPT G+}
  SHL AL,2
 {$ELSE}
  SHL AL,1
  SHL AL,1
 {$ENDIF}
 ADD DI,8000h
 MOV AH,ES:[DI]
 AND AH,DL
 SHR AH,CL
 OR  AL,AH
 MOV AH,AL
 AND AH,1
 {$IFOPT G+}
  SHL AH,4
 {$ELSE}
  SHL AH,1
  SHL AH,1
  SHL AH,1
  SHR AL,1
 {$ENDIF}
 OR  AL,AH
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

Procedure Init;Begin
 ASM
  MOV BX,4000
  {$IFDEF Autonome}
   MOV AH,$48
   INT $21
  {$ELSE}
   INT $9B
  {$ENDIF}
  MOV ES,AX
  MOV DataVideo.MIV.SegBuffer,AX
  XOR DI,DI
  MOV AX,' '+(7 shl 8)
  MOV CX,4000
  CLD
  REP STOSW
 END;
End;

Procedure MoveText;Var I,J,L,L2,L1,YL1,YL2,X1a,X3a,Lx:Wd;Begin
 If(X2<X1)or(Y2<Y1)Then Exit;
 ASM
  MOV AL,X2
  SUB AL,X1
  XOR AH,AH
  INC AX
  SHL AX,1
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
  CALL @@SubText
  CMP DL,0
  JNE @@Loop
  JMP @@End
@@Inc:
  MOV DH,Y2
  SUB DH,AL
  INC DH
  MOV DL,0
@@LoopInc:
  CALL @@SubText
  INC DL
  CMP DL,DH
  JNE @@LoopInc
  JMP @@End
@@SubText:
  MOV AL,Y1
  ADD AL,DL
  MUL DataVideo.MIV.NumXTexts
  MOV BL,X1
  XOR BH,BH
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
  PUSH DS
   PUSH ES
   POP DS
   REP MOVSB
  POP DS
  RETN
@@End:
 END;
 X1a:=X1;X3a:=X3;Lx:=L shr 1;
 If(Y3<Y1)Then For J:=0to(Y2-Y1)do For I:=0to 7do Begin
  YL1:=((J+Y1)shl 3)+I;YL2:=((J+Y3)shl 3)+I;
  ASM
   CLD
   PUSH DS
   MOV SI,YL1
   SHL SI,1
   MOV SI,CS:[Offset RealRawY+SI]
   MOV AL,X1
   XOR AH,AH
   {$IFOPT G+}
    SHR AX,2
   {$ELSE}
    SHR AX,1
    SHR AX,1
   {$ENDIF}
   ADD SI,AX
   MOV DI,YL2
   SHL DI,1
   MOV DI,CS:[Offset RealRawY+DI]
   MOV AL,X3
   XOR AH,AH
   SHR AX,1
   SHR AX,1
   ADD DI,AX
   MOV ES,DataVideo.MIV.SegVideo
   PUSH ES
   POP DS
   MOV CX,L
   REP MOVSW
   MOV ES,DataVideo.MIV.AddrPage {SegVý}
   PUSH ES
   POP DS
   MOV CX,L
   REP MOVSW
   POP DS
  END;
 End
  Else
 For J:=Y2-Y1 downto 0do Begin
  YL1:=(J+Y1)shl 3;YL2:=(J+Y3)shl 3;
  ASM
   CLD
   PUSH DS
   MOV SI,YL1
   SHL SI,1
   MOV SI,CS:[Offset RealRawY+SI]
   MOV AL,X1
   XOR AH,AH
   SHR AX,1
   SHR AX,1
   ADD SI,AX
   MOV DI,YL2
   SHL DI,1
   MOV DI,CS:[Offset RealRawY+DI]
   MOV AL,X3
   XOR AH,AH
   SHR AX,1
   SHR AX,1
   ADD DI,AX
   MOV ES,DataVideo.MIV.SegVideo
   PUSH ES
   POP DS
   MOV CX,L
   REP MOVSW
   MOV ES,DataVideo.MIV.AddrPage {SegVý}
   PUSH ES
   POP DS
   MOV CX,L
   REP MOVSW
   POP DS
  END;
 End;
End;

Procedure PCopy;Begin End;

{$I PutCharG.Inc}

Procedure PutFillBox;Var J:Wd;Begin For J:=Y1 to(Y2)do PutLnHor(X1,J,X2,Kr)End;

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

Procedure PutLnHor;Label _End;Var I:Wd;Begin
 ASM
  MOV AX,X1
  TEST AX,8000h
  JZ  @0
  TEST X2,8000h
  JNZ _End
  XOR AX,AX
  MOV X1,AX
@0:
  CMP AX,X2
  JB  @1
  XCHG AX,X2
  MOV X1,AX
@1:
 END;
 For I:=X1 to(X2)do SetPixel(I,Y,Color);
_End:
End;

{$I PutRect.Inc}
{$I PutRndRe.Inc}

Procedure PutSmlImg;Var TBuf:TByte Absolute Buffer;J,I,I2,L:Wd;Begin
 L:=X2-X1+1;I2:=0;
 For J:=0to Y2-Y1 do For I:=0to L-1do Begin SetPixel(X1+I,Y1+J,TBuf[I2]);Inc(I2)End;
End;

Procedure PutSprite;Var TBuf:TByte Absolute Buffer;J,I,I2,L:Wd;Begin
 L:=X2-X1+1;I2:=0;
 For J:=0to Y2-Y1 do For I:=0to L-1do Begin
  If TBuf[I2]<>0Then SetPixel(X1+I,Y1+J,TBuf[I2]);
  Inc(I2)
 End;
End;

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
Procedure SetBackgroundColor;Begin;End;
Procedure SetBlink;Begin End;

Procedure SetBorderColor;Assembler;ASM
 MOV DX,03D9h
 MOV AL,Kr
 AND AL,0Fh
 OUT DX,AL
END;

Procedure SetBytesPerLn;Begin
End;

Procedure SetChr;Begin
 SetCube(X,Y,Chr,GetAttr(X,Y))
End;

Procedure SetChrWidth;Begin
End;

Procedure SetCube;
Var
 YR:Word;
 M,Mx:Byte;
Begin
 ASM
  MOV AL,DataVideo.MIV.NumXTexts
  MOV M,AL
  DEC AL
  MOV Mx,AL
  MOV BL,Y
  XOR BH,BH
  SHL BX,1
  MOV AX,CS:[Offset RawY]
  MOV YR,AX
 END;
 If(X>Mx)Then Begin Inc(Y,X div M);X:=X mod M;End;
 SetGCube(X shl 3,YR,Chr,Attr);
End;

Procedure SetCur;Assembler;ASM
 XOR AX,AX
 MOV ES,AX
 MOV AL,B
 MOV AH,A
 MOV ES:[$460],AX
END;

Procedure SetCurPos;Assembler;ASM
 XOR BX,BX
 MOV ES,BX
 MOV AH,Y
 MOV BL,ES:[$462]
 AND BL,7
 SHL BX,1
 MOV AL,X
 MOV ES:[$0450+BX],AX
END;

Procedure SetGCube;Assembler;Var Masque,Fore,Back:Byte;Base:Wd;ASM
 MOV AL,Attr
 MOV AH,AL
 AND AH,$F
 MOV Fore,AH
 MOV CL,4
 SHR AL,CL
 MOV Back,AL
 MOV BL,Chr
 XOR BH,BH
 SHL BX,1
 MOV AX,CS:[Offset RawY+BX]
 MOV Base,AX
 MOV DX,$800
@@Home:
 XOR CX,CX
 MOV BL,DL
 XOR BH,BH
 ADD BX,Base
 LES DI,MIV(DataVideo).TxtMtx
 MOV AL,ES:[DI+BX]
 MOV Masque,AL
@@Loop:
 PUSH DX
  PUSH CX
   PUSH SI
    MOV AX,X
    ADD AX,CX
    PUSH AX
    MOV AL,DL
    XOR AH,AH
    ADD AX,Y
    PUSH AX
    MOV AL,Back
    TEST Masque,$80
    JZ @@Back
    MOV AL,Fore
@@Back:
    PUSH AX
    PUSH CS
    CALL Near Ptr SetPixel
   POP SI
  POP CX
 POP DX
 SHL Masque,1
 INC CX
 CMP CL,DataVideo.MIV.HeightChar
 JNE @@Loop
@@End:
 INC DL
 CMP DL,DH
 JNE @@Home
END;

Procedure SetGCubeT;Assembler;Var Masque:Byte;Base:Wd;ASM
 AND Attr,$F
 MOV BL,Chr
 XOR BH,BH
 SHL BX,1
 MOV AX,Word Ptr RawY[BX]
 MOV Base,AX
@@Home:
 XOR CX,CX
 MOV BL,DL
 XOR BH,BH
 ADD BX,Base
 LES DI,MIV(DataVideo).TxtMtx
 MOV AL,ES:[DI+BX]
 MOV Masque,AL
@@Loop:
 PUSH DX
  PUSH CX
   PUSH SI
    TEST Masque,$80
    JZ @@Skip
    MOV AX,X
    ADD AX,CX
    PUSH AX
    MOV AL,DL
    XOR AH,AH
    ADD AX,Y
    PUSH AX
    PUSH Attr.Word
    PUSH CS
    CALL Near Ptr SetPixel
@@Skip:
   POP SI
  POP CX
 POP DX
 SHL Masque,1
 INC CX
 CMP CL,DataVideo.MIV.HeightChar
 JNE @@Loop
@@End:
 INC DL
 CMP DL,DH
 JNE @@Home
END;

Procedure SetMatrix;Begin End;
Procedure SetModeMtx;Begin End;
Procedure SetModeScr;Begin End;
Procedure SetPg;Begin End;

Procedure SetPixel;Assembler;ASM
 TEST X,8000h
 JNZ @End
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
 MOV SI,X
 MOV CL,Byte Ptr RawXv[SI]
 MOV DL,3
 SHL DL,CL
 NOT DL
 MOV ES,DataVideo.MIV.SegVideo
 MOV SI,Kr
 MOV BL,Byte Ptr RawKrLo[SI]
 SHL BL,CL
 MOV AL,ES:[DI]
 AND AL,DL
 OR  AL,BL
 MOV ES:[DI],AL
 MOV ES,DataVideo.MIV.AddrPage { SegVý }
 MOV BL,Byte Ptr RawKrHi[SI]
 SHL BL,CL
 MOV AL,ES:[DI]
 AND AL,DL
 OR  AL,BL
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

{$I GrfIcon.Inc}
{$I Done.Inc}