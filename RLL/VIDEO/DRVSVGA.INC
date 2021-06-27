{DrvSVGA.Inc}

Procedure RawTxtY;Forward;
Procedure RawY;Forward;

Procedure {$IFDEF __386__}_DriverSVGA3;{$ELSE}_DriverSVGA;{$ENDIF}Assembler;ASM
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
 RET 2 {SetChrWidth(L:Byte)}
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
 JMP SetBnkPg.Near
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
 DW 0
END;

Procedure PhysVideo;Assembler;ASM
 DB 0,0 {Card,Monitor:Nom de la carte vidÇo (vn????),Nom du moniteur (mn????)}
 DB 0 {CardCat:CatÇgorie de la carte vidÇo(MDA,CGA,...)(cvn????)}
 DD 262144 {Memory:Nombre de mÇmoire (en octet) dont dispose la carte vidÇo}
 DB Ya {Font:Police programmable supportÇ par cette carte?}
 DB 0 {Hercule:Mode Hercule supportÇ par cette carte?}
 DW $A000{Seg16C:Segment par dÇfaut en 16 couleurs}
 DB Ya{Palette:Palette de couleur programme supportÇ?}
 DB Ya{Color:Carte de type couleur? autrement monochrome}
 DB Ya{BBlink:Le Bios supporte le mode clignotement/intensitÇ?}
 DB Ya{EGA:La carte est postÇrieur ou Çgale Ö l'EGA}
 DB Ya{VGA:La carte est postÇrieur ou Çgale Ö la VGA}
 DB 0 {VGA320x400:Le mode VGA 320x400 est supportÇ (pas toujours le cas chez les clones)}
 DB 0 {VESA:Le standard VESA supportÇ? }
 DW $C000 {ROM:Adresse de la ROM Bios}
 DB 0 {MousePort:Port souris inclue Ö la carte vidÇo?}
 DB 0 {VideoBits:Nombre d'accäs bits au entrÇe/sortie vidÇo}
 DB 0 {ROMBits:Nombre d'accäs bits Ö la ROM Bios}
 DB 6 {DACBits:Nombre de bits utilisÇ pour modifiÇ un des 3 DAC RGB}
 DB 0 {PVC:Horloge vidÇo programme?}
 DW 14{ProcSelBnkPg:Adresse d'index de la procÇdure de changement de page de la banque}
 DW 0{ProcSetVideoMode:Adresse d'index de la procÇdure de changement de mode vidÇo}
END;

Procedure DataVideo;Assembler;ASM
 DW 0{Mode:Mode vidÇo actuel (vm???)}
 DB Ya{IbmLogic:Mode dans la logique IBM (pas hors cas texte Ö la SVGA...)}
 DB Ya{BiosSupport:Mode supportÇ par le Bios (Par exemple, la GS en 16 couleurs le Bios ne le connaåt pas)}
 DB Ya{Colr:Mode couleur? Sinon monochrome foráÇment...}
 DB Ya{Graf:Mode graphique? Sinon texte}
 DB Ya{Direct:MÇthode directe? Sinon Bios ou Dos}
 DB No{Blink:Clignotement}
 DB No{Snow:Neige lors de l'envoie de donnÇe dans le tampon vidÇo?}
 DW $A000{SegV:Segment vidÇo (A000h,B000h,B800h,...)}
 DB 8{HeightChr:Hauteur de la police de caractäre actuel}
 DW 320{NmXPixels:Nombre de pixels horizontal qu'affiche l'Çcran}
 DW 200{NmYPixels:Nombre de pixels vertical qu'affiche l'Çcran}
 DB 40,25{NmXTxts,NmYTxts:Nombre de caractäre texte horizontal/vertical qu'affiche l'Çcran}
 DB 1{NmVidPgs:Nombre de page vidÇo que supporte le mode actuel}
 DD 256{NmColrs:Nombre de couleurs affichÇ}
 DB 8{BitsPerPixel:Nombre de Bit(s) utilisÇ pour l'affichage d'un pixel}
 DW 320{BytesPerLn:Nombre d'octet par ligne affichÇ (träs relatif en VGA...)}
 DB 0{Pg:NumÇro de la page vidÇo de travail}
 DW 0{AddrPg:En texte, adresse en mÇmoire vidÇo de la page actuel,
      Super VGA en 256: Pointeur de RealRawY}
 DB 0{ShowPg:NumÇro de la page vidÇo actuellement affichÇ}
 DD 0{TxtMtx:Pointeur sur la police de caractäre courante}
 DD 64000{ScrSize:Taille de l'Çcran}
 DW 0{SizeBnk:Taille d'un page de la banque (0=64Ko)}
 DW 0{SegBuf:Segment du tampon d'accÇlÇration}
 DB 0{IsDblMtx:Y a-t-il une police de 512 caractäres?}
 DB 0,0 {XCur,YCur:Position actuel du curseur}
 DB 0,0 {StartCur,EndCur:DÇbut et fin du curseur}
END;

Procedure RawTxtY;Assembler;ASM
 DW    0,  80, 160, 240, 320, 400, 480, 560, 640, 720, 800, 880, 960,1040,1120,1200 {0}
 DW 1280,1360,1440,1520,1600,1680,1760,1840,1920,2000,2080,2160,2240,2320,2400,2480 {1}
 DW 2560,2640,2720,2800,2880,2960,3040,3120,3200,3280,3360,3440,3520,3600,3680,3760 {2}
 DW 3840,3920,4000,4080,4160,4240,4320,4400,4480,4560,4640,4720,4800,4880,4960,5040 {3}
 DW 5120,5200,5280,5360,5440,5520,5600,5680,5760,5840,5820,5900,5980,6060,6140,6220 {4}
 DW    0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0 {5}
 DW    0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0 {6}
 DW    0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0 {7}
 DW    0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0 {8}
 DW    0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0 {9}
 DW    0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0 {10}
 DW    0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0 {11}
 DW    0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0 {12}
 DW    0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0 {13}
 DW    0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0 {14}
 DW    0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0 {15}
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

{⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ‹
 ≥                          ProcÇdure BarChrHor                        €
 ¿‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹€


 Description
 ÕÕÕÕÕÕÕÕÕÕÕ

  Cette procÇdure affiche une bar horizontal avec le caractäre spÇcifiÇ.
}

Procedure BarChrHor;Var I:Byte;Begin
 For I:=X1 to(X2)do SetChr(I,Y,Chr)
End;

{⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ‹
 ≥                          ProcÇdure BarChrVer                        €
 ¿‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹€


 Description
 ÕÕÕÕÕÕÕÕÕÕÕ

  Cette procÇdure affiche une bar vertical avec le caractäre spÇcifiÇ.
}

Procedure BarChrVer;Var J:Byte;Begin
 For J:=Y1 to(Y2)do SetChr(X,J,Chr)
End;

{⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ‹
 ≥                      ProcÇdure BarSpcHor                     €
 ¿‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹€


 Description
 ÕÕÕÕÕÕÕÕÕÕÕ

  Cette procÇdure affiche une bar horizontal avec que des espaces
 dans un Çcran graphique Super VGA Ö 256 couleurs.
}

Procedure BarSpcHor;Assembler;ASM
 {$IFDEF __386__}
  DB 36h,0Fh,0B6h,05Eh,0Ah { MOVZX BX,Byte Ptr SS:[BP+0Ah] }
 {$ELSE}
  MOV BL,Y
  XOR BH,BH
 {$ENDIF}
 SHL BX,1
 MOV DI,Word Ptr RawY[BX]
 MOV DX,DI
 ADD DL,DataVideo.MIV.HeightChar
 ADC DH,0
 DEC DX
 {$IFDEF __386__}
  DB 36h,0Fh,0B6h,046h,0Ch { MOVZX AX,Byte Ptr SS:[BP+0Ch] }
 {$ELSE}
  MOV AL,X1
  XOR AH,AH
 {$ENDIF}
 {$IFOPT G+}SHL AX,3{$ELSE}SHL AX,1;SHL AX,1;SHL AX,1{$ENDIF}
 MOV CX,AX
 {$IFDEF __386__}
  DB 36h,0Fh,0B6h,046h,08h { MOVZX AX,Byte Ptr SS:[BP+08h] }
 {$ELSE}
  MOV AL,X2
  XOR AH,AH
 {$ENDIF}
 {$IFOPT G+}SHL AX,3{$ELSE}SHL AX,1;SHL AX,1;SHL AX,1{$ENDIF}
 OR  AL,7
 MOV SI,AX
 {$IFDEF __386__}
  DB 36h,0Fh,0B6h,046h,06h { MOVZX AX,Byte Ptr SS:[BP+06h] }
 {$ELSE}
  XOR AH,AH
  MOV AL,Attr
 {$ENDIF}
 {$IFOPT G+}SHR AX,4{$ELSE}SHR AX,1;SHR AX,1;SHR AX,1;SHR AX,1{$ENDIF}
 PUSH CX
 PUSH DI
 PUSH SI
 PUSH DX
 PUSH AX
 PUSH CS
 CALL Near Ptr PutFillBox
   { Fixe dans le tampon accÇlÇrateur... }
 MOV ES,DataVideo.MIV.SegBuffer
 MOV BL,Y
 XOR BH,BH
 SHL BX,1
 MOV DI,Word Ptr RawTxtY[BX]
 MOV CL,X1
 XOR CH,CH
 ADD DI,CX
 SHL DI,1
 MOV CL,X2
 SUB CL,X1
 INC CX
 MOV AH,Attr
 MOV AL,' '
 {$IFDEF __386__}
  DB  ciPushAX,ciPushAX { EAX := AX:AX }
  DW  ciPopEAX
  SHR CX,1
  DB ciREP; DW ciSTOSD
  ADC CX,CX
  REP STOSW
 {$ELSE}
  REP STOSW
 {$ENDIF}
END;

{⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ‹
 ≥                        ProcÇdure BarSpcVer                      €
 ¿‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹€


 Description
 ÕÕÕÕÕÕÕÕÕÕÕ

  Cette procÇdure affiche une bar vertical avec que des espaces dans
 un Çcran graphiques Super VGA Ö 256 couleurs.
}

Procedure BarSpcVer;Assembler;ASM
 MOV AL,X
 XOR AH,AH
 {$IFOPT G+}SHL AX,3{$ELSE}SHL AX,1;SHL AX,1;SHL AX,1{$ENDIF}
 PUSH AX
 MOV BL,Y1
 XOR BH,BH
 SHL BX,1
 PUSH Word Ptr RawY[BX]
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
 {Mise Ö jour du tampon d'accÇlÇration}
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

Procedure ClrLnHor;Assembler;ASM
 MOV BX,Y
 {$IFOPT G+}
  SHL BX,2
 {$ELSE}
  SHL BX,1
  SHL BX,1
 {$ENDIF}
 MOV ES,DataVideo.MIV.AddrPage
 {$IFDEF __386__}
  DB 66h; MOV DI,ES:[BX]      { MOV EDI,ES:[BX] }
  MOV AX,X                    { MOV AX,X }
  DB 66h; AND AX,0FFFFh; DW 0 { AND EAX,00000FFFFh }
  DB 66h; ADD DI,AX           { ADD EDI,EAX }
  DB 66h; PUSH DI             { PUSH EDI }
  ADD SP,2                    { ADD SP,2 }
 {$ELSE}
  LES AX,ES:[BX]
  MOV DX,ES
  ADD AX,X
  ADC DX,0
  PUSH AX
   PUSH DX
    PUSH DX
 {$ENDIF}
   PUSH CS
   CALL SetBnkPg.Near
 {$IFNDEF __386__}
   POP DX
  POP BX
  MOV DI,BX
 {$ELSE}
  DB 66h; MOV BX,DI { MOV EBX,EDI }
 {$ENDIF}
 CLD
 MOV ES,DataVideo.MIV.SegVideo
 MOV CX,L
 MOV AX,Kr
 MOV AH,AL
 ADD BX,CX
 JNC @End
 {$IFNDEF __386__}
  INC DX
 {$ENDIF}
 XOR CX,CX
 SUB CX,DI
 MOV BX,CX
 SHR CX,1
 REP STOSW
 ADC CX,CX
 REP STOSB
 PUSH AX
  {$IFDEF __386__}
   DEC DI
   DB 66h; INC DI
   DB 66h; PUSH DI        { PUSH EDI }
   ADD SP,2
  {$ELSE}
   PUSH DX
  {$ENDIF}
  PUSH CS
  CALL Near Ptr SetBnkPg
 POP AX
 MOV CX,L
 SUB CX,BX
@End:
 {$IFDEF __386__}
  DB  ciPushAX,ciPushAX { EAX := AX:AX }
  DW  ciPopEAX
  MOV BX,CX
  AND BX,3
  SHR CX,2
  DB  ciREP; DW ciSTOSD    { REP STOSD }
  MOV CX,BX
  REP STOSB
 {$ELSE}
  SHR CX,1
  REP STOSW
  ADC CX,CX
  REP STOSB
 {$ENDIF}
END;

Procedure _ClrLnHorImg(X,Y,L:Wd;Var Buffer);Near;Assembler;ASM
 MOV BX,Y
 {$IFOPT G+}
  SHL BX,2
 {$ELSE}
  SHL BX,1
  SHL BX,1
 {$ENDIF}
 MOV ES,DataVideo.MIV.AddrPage
 {$IFDEF __386__}
  MOV AX,X                    { MOV AX,X }
  DB 66h; AND AX,0FFFFh; DW 0 { AND EAX,0000FFFFh }
  DB 66h; ADD AX,ES:[BX]      { ADD EAX,ES:[BX] }
  DB 66h; PUSH AX             { PUSH EAX }
 {$ELSE}
  LES AX,ES:[BX]
  MOV DX,ES
  ADD AX,X
  ADC DX,0
  PUSH DX
  PUSH AX
 {$ENDIF}
 PUSH L
 {$IFDEF __386__}
  DB 66h; PUSH Word Ptr Buffer
 {$ELSE}
  PUSH Word Ptr Buffer[2]
  PUSH Word Ptr Buffer
 {$ENDIF}
 PUSH CS
 CALL Near Ptr WriteBnk
END;

Procedure ClrLnHorImg;
Label _0,_1,_2,_4,_8,_Xit;
Var
 BufPtr:Array[0..1279]of Byte;
 MX,MY,I,Base,Xa:Word;
 Ta:Byte;
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
 ASM
  MOV BL,BitsPerPixel
  AND BX,001Fh
  SHL BX,1
  JMP @Label.Word[BX]
@Label:
  DW Offset _0   { 0 - 1 }
  DW Offset _1   { 1 - 2 }
  DW Offset _2   { 2 - 4 }
  DW Offset _Xit { 3 - 8 }
  DW Offset _4   { 4 - 16 }
  DW Offset _Xit { 5 - 32 }
  DW Offset _Xit { 6 - 64 }
  DW Offset _Xit { 7 - 128 }
  DW Offset _8   { 8 - 256 }
  DW Offset _Xit { 9 - 512 }
  DW Offset _Xit { 10 - 1024 }
  DW Offset _Xit { 11 - 2048 }
  DW Offset _Xit { 12 - 4096 }
  DW Offset _Xit { 13 - 8192 }
  DW Offset _Xit { 14 - 16384 }
  DW Offset _Xit { 15 - 32768 }
  DW Offset _Xit { 16 - 65536 }
  DW Offset _Xit { 17 - 132072 }
  DW Offset _Xit { 18 - 264144 }
  DW Offset _Xit { 19 - ... }
  DW Offset _Xit { 20 - ... }
  DW Offset _Xit { 21 - ... }
  DW Offset _Xit { 22 - ... }
  DW Offset _Xit { 23 - ... }
  DW Offset _Xit { 24 - ... }
  DW Offset _Xit { 25 - ... }
  DW Offset _Xit { 26 - ... }
  DW Offset _Xit { 27 - ... }
  DW Offset _Xit { 28 - ... }
  DW Offset _Xit { 29 - ... }
  DW Offset _Xit { 30 - ... }
  DW Offset _Xit { 31 - ... }
 END;
 _0:
  MY:=TBuf[0];
  ASM INC Word Ptr Buffer;END;
  MX:=TBuf[0];
  ASM INC Word Ptr Buffer;END;
  For I:=0to(L-1)shr 3do Begin
   Copy8Bin(X,Y,TBuf[I],MX,MY);
   Inc(X,8)
  End;
  If L and 7>0Then Begin
   Ta:=TBuf[L-1];
   For I:=0to 7do Begin
    If ((Ta shr I)and 1)=1Then SetPixel(X+I,Y,MX)
                          Else SetPixel(X+I,Y,MY)
   End;
  End;
  Exit;
 _1:{ 2 Ö 256 couleurs }
  For I:=0to(L-1)shr 3do Copy8Bin(X+(I shl 3),Y,TBuf[I],0,15);
  If L and 7>0Then Begin
   Ta:=TBuf[L-1]; Xa:=X+(L-1)shl 3;
   For I:=0to 7do SetPixel(Xa+I,Y,((Ta shr I)and 1)*15);
  End;
  Exit;
 _2:{ 4 Ö 256 couleurs }
  For I:=0to(L-1)shr 2do Begin
   BufPtr[I shl 2]:=(TBuf[I]and 3)shl 2;
   BufPtr[(I shl 2)+1]:=((TBuf[I]shr 2)and 3)shl 2;
   BufPtr[(I shl 2)+2]:=((TBuf[I]shr 4)and 3)shl 2;
   BufPtr[(I shl 2)+3]:=(TBuf[I]shr 6)shl 2;
  End;
  _ClrLnHorImg(X,Y,L,BufPtr);
  Exit;
 _4:{ 16 Ö 256 couleurs }
   For I:=0to(L-1)shr 1do Begin
    BufPtr[I shl 1]:=TBuf[I]shr 4;BufPtr[(I shl 1)+1]:=TBuf[I]and$F;
   End;
   _ClrLnHorImg(X,Y,L,BufPtr);
  Exit;
 _8:_ClrLnHorImg(X,Y,L,Buffer);
_Xit:
End;

{⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ‹
 ≥                     ProcÇdure ClrWn                       €
 ¿‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹€


 Description
 ÕÕÕÕÕÕÕÕÕÕÕ

  Cette procÇdure efface une boåte de caractäres de l'Çcran de
 graphiques Super VGA en 256 couleurs.
}

Procedure ClrWn;Assembler;ASM
 CLD
 XOR AX,AX
 {$IFDEF __386__}
  DB 36h,0Fh,0B6h,05Eh,0Ch { MOVZX BX,Byte Ptr SS:[BP+0Ch] }
 {$ELSE}
  MOV BL,Y1
  XOR BH,BH
 {$ENDIF}
 SHL BX,1
 MOV DI,Word Ptr RawTxtY[BX]
 MOV AL,DataVideo.MIV.NumXTexts
 MOV ES,DataVideo.MIV.SegBuffer
 SHL AX,1
 MOV SI,AX
 {$IFDEF __386__}
  DB 36h,0Fh,0B6h,046h,0Eh { MOVZX AX,Byte Ptr SS:[BP+0Eh] }
 {$ELSE}
  MOV AL,X1
  XOR AH,AH
 {$ENDIF}
 ADD DI,AX
 {$IFOPT G+}SHL AX,3{$ELSE}SHL AX,1;SHL AX,1;SHL AX,1{$ENDIF}
 PUSH AX
 SHL DI,1
 MOV AL,' '
 MOV AH,Attr
 MOV CL,Y2
 XOR CH,CH
 SUB CL,Y1
 INC CX
 MOV DL,X2
 SUB DL,X1
 MOV DH,0
 INC DX
@@Loop:
 PUSH CX
  PUSH DI
   MOV CX,DX
   {$IFDEF __386__}
    DB  ciPushAX,ciPushAX { EAX := AX:AX }
    DW  ciPopEAX
    SHR CX,1
    DB ciREP; DW ciSTOSD
    ADC CX,CX
    REP STOSW
   {$ELSE}
    REP STOSW
   {$ENDIF}
  POP DI
 POP CX
 ADD DI,SI
 {$IFDEF __386__}
  DEC CX
  JNZ @@Loop
 {$ELSE}
  LOOP @@Loop
 {$ENDIF}
 PUSH Word Ptr RawY[BX]
 {$IFDEF __386__}
  DB 36h,0Fh,0B6h,046h,0Ah { MOVZX AX,Byte Ptr SS:[BP+0Ah] }
 {$ELSE}
  MOV AL,X2
  XOR AH,AH
 {$ENDIF}
 INC AX
 {$IFOPT G+}SHL AX,3{$ELSE}SHL AX,1;SHL AX,1;SHL AX,1{$ENDIF}
 DEC AX
 PUSH AX
 {$IFDEF __386__}
  DB 36h,0Fh,0B6h,05Eh,08h { MOVZX BX,Byte Ptr SS:[BP+08h] }
 {$ELSE}
  MOV BL,Y2
  XOR BH,BH
 {$ENDIF}
 INC BX
 SHL BX,1
 MOV AX,Word Ptr RawY[BX]
 DEC AX
 PUSH AX
 {$IFDEF __386__}
  DB 36h,0Fh,0B6h,046h,06h { MOVZX AX,Byte Ptr SS:[BP+06h] }
 {$ELSE}
  MOV AL,Attr
  XOR AH,AH
 {$ENDIF}
 {$IFOPT G+}SHR AX,4{$ELSE}SHR AX,1;SHR AX,1;SHR AX,1;SHR AX,1{$ENDIF}
 PUSH AX
 PUSH CS
 CALL Near Ptr PutFillBox
END;

{$I CLSWPFBO.INC}

Procedure CopT8Bin;Assembler;{$IFNDEF __386__}Var Pg:Wd;{$ENDIF}ASM
 CLD
 MOV BX,Y
 {$IFOPT G+}
  SHL BX,2
 {$ELSE}
  SHL BX,1
  SHL BX,1
 {$ENDIF}
 MOV ES,DataVideo.MIV.AddrPage
 {$IFDEF __386__}
  DB 66h; MOV DI,ES:[BX]      { MOV EDI,ES:[BX] }
  MOV AX,X                    { MOV AX,X }
  DB 66h; AND AX,0FFFFh; DW 0 { AND EAX,00000FFFFh }
  DB 66h; ADD DI,AX           { ADD EDI,EAX }
  DB 66h; PUSH DI             { PUSH EDI }
  ADD SP,2                    { ADD SP,2 }
 {$ELSE}
  LES DI,ES:[BX]
  MOV DX,ES
  ADD DI,X
  ADC DX,0
  MOV Pg,DX
  PUSH DX
 {$ENDIF}
 PUSH CS
 CALL Near Ptr SetBnkPg
 MOV AX,X
 MOV CX,8
 ADD AX,CX
 CMP AX,DataVideo.MIV.NumXPixels
 JBE @@1
 SUB AX,DataVideo.MIV.NumXPixels
 SUB CX,AX
 JCXZ @@End
 JS  @@End
@@1:
 MOV ES,DataVideo.MIV.SegVideo
 MOV BH,Value
 MOV AX,DI
 ADD AX,7
 JC  @@Long
 OR  BH,BH
 JE  @@End
 MOV AL,Fore
 CMP BH,0FFh
 JNE @@2
 MOV AH,AL
 STOSW
 STOSW
 STOSW
 STOSW
 JMP @@End
@@2:
@@3:
 ROL BH,1
 JC  @@4
 INC DI
 {$IFDEF __386__}
  DEC CX
  JNZ @@3
 {$ELSE}
  LOOP @@3
 {$ENDIF}
 JMP @@End
@@4:
 STOSB
 {$IFDEF __386__}
  DEC CX
  JNZ @@3
 {$ELSE}
  LOOP @@3
 {$ENDIF}
 JMP @@End
@Pg:
 DW 0
@@Long:
 {$IFDEF __386__}
  DB 66h; PUSH DI        { PUSH EDI }
  ADD SP,2
  POP Word Ptr @Pg
 {$ENDIF}
 MOV AH,AL
 MOV DH,Fore
@@Long3:
 TEST DI,0FFFFh
 JNZ @@Long3A
(* {$IFDEF __386__}
  DB 66h; PUSH DI
 {$ELSE}*)
  PUSH DI
(* {$ENDIF}*)
 PUSH ES; PUSH CX; PUSH DX
(*  {$IFDEF __386__}
   DEC DI
   DB 66h; INC DI
   DB 66h; PUSH DI        { PUSH EDI }
   ADD SP,2
  {$ELSE}*)
   {$IFDEF __386__}
    MOV AX,Word Ptr @Pg
   {$ELSE}
    MOV AX,Pg
   {$ENDIF}
   INC AL
   PUSH AX
(*  {$ENDIF}*)
  PUSH CS
  CALL Near Ptr SetBnkPg
 POP DX; POP CX; POP ES
(* {$IFDEF __386__}
  DB 66h; POP DI
  DEC DI
  DB 66h; INC DI
 {$ELSE}*)
  POP DI
(* {$ENDIF}*)
@@Long3A:
 MOV BL,BH
 ROR BL,CL
 JC  @@Long4
 INC DI
 {$IFDEF __386__}
  DEC CX
  JNZ @@Long3
 {$ELSE}
  LOOP @@Long3
 {$ENDIF}
 JMP @@End
@@Long4:
 MOV AL,DH
 STOSB
 {$IFDEF __386__}
  DEC CX
  JNZ @@Long3
 {$ELSE}
  LOOP @@Long3
 {$ENDIF}
@@End:
END;

Procedure Copy8Bin;Assembler;Var Pg:Wd;ASM
 CLD
 MOV BX,Y
 {$IFOPT G+}SHL BX,2{$ELSE}SHL BX,1;SHL BX,1{$ENDIF}
 MOV ES,DataVideo.MIV.AddrPage
 LES DI,ES:[BX]
 MOV DX,ES
 ADD DI,X
 ADC DX,0
 MOV Pg,DX
 PUSH DX
 PUSH CS
 CALL Near Ptr SetBnkPg
 MOV ES,DataVideo.MIV.SegVideo
 MOV BH,Value
 MOV AX,DI
 ADD AX,7
 JC  @@Long
 OR  BH,BH
 JE  @@1
 MOV AL,Fore
 CMP BH,0FFh
 JNE @@2
 JMP @@1x
@@1:
 MOV AL,Back
@@1x:
 MOV AH,AL
 STOSW
 STOSW
 STOSW
 STOSW
 JMP @@End
@@2:
 MOV DL,Back
 MOV DH,AL
 ROL BH,1
 MOV AX,DX
 JNC @x1
 MOV AL,DH
@x1:
 ROL BH,1
 JC  @x2
 MOV AH,DL
@x2:
 STOSW
 ROL BH,1
 MOV AX,DX
 JNC @x3
 MOV AL,DH
@x3:
 ROL BH,1
 JC  @x4
 MOV AH,DL
@x4:
 STOSW
 ROL BH,1
 MOV AX,DX
 JNC @x5
 MOV AL,DH
@x5:
 ROL BH,1
 JC  @x6
 MOV AH,DL
@x6:
 STOSW
 ROL BH,1
 MOV AX,DX
 JNC @x7
 MOV AL,DH
@x7:
 ROL BH,1
 JC  @x8
 MOV AH,DL
@x8:
 STOSW
 JMP @@End
@@Long:
 MOV AH,AL
 MOV DL,Back
 MOV DH,Fore
 MOV CX,8
@@Long3:
 TEST DI,0FFFFh
 JNZ @@Long3A
 PUSH DI; PUSH ES; PUSH CX; PUSH DX
  MOV AX,Pg
  INC AL
  PUSH AX
  PUSH CS
  CALL SetBnkPg.Near
 POP DX; POP CX; POP ES; POP DI
@@Long3A:
 MOV BL,BH
 ROR BL,CL
 JC  @@Long4
 MOV AL,DL
 STOSB
 {$IFDEF __386__}
  DEC CX
  JNZ @@Long3
 {$ELSE}
  LOOP @@Long3
 {$ENDIF}
 JMP @@End
@@Long4:
 MOV AL,DH
 STOSB
 {$IFDEF __386__}
  DEC CX
  JNZ @@Long3
 {$ELSE}
  LOOP @@Long3
 {$ENDIF}
@@End:
END;

{ ⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ‹
  ≥                            Routine AsmSetCube                        €
  ¿‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹€


  Description
  ÕÕÕÕÕÕÕÕÕÕÕ

   Cette procÇdure permet d'affiche un caractäre Ö l'endroit spÇcifier par
  le couple de registre  (CL,CH)  avec un attribut dÇfinit par le registre
  AH pareillement Ö un Çcran de texte sauf qu'il s'applique seulement Ö un
  Çcran graphique Super VGA en 256 couleurs.


  Paramätre d'entrÇe
  ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕ

   AL      = Caractäre
   AH      = Attribut
   CL      = X
   CH      = Y
}

Procedure AsmSetCube;Near;Assembler;ASM
 MOV ES,DataVideo.MIV.SegBuffer
 {$IFDEF __386__}
  DB 0Fh,0B6h,0DDh { MOVZX BX,CH }
 {$ELSE}
  MOV BL,CH
  XOR BH,BH
 {$ENDIF}
 SHL BX,1
 MOV SI,BX
 MOV DI,Word Ptr RawTxtY[BX]
 MOV BL,CL
 ADD DI,BX
 SHL DI,1
 STOSW
 XCHG AX,DX
 MOV BL,DataVideo.MIV.NumXTexts
 MOV AH,BL
 DEC AH
 MOV AL,CL
 CMP AL,AH
 JBE @1
 DIV BL
 ADD CH,AL
 MOV BL,CH
 SHL BX,1
 MOV SI,BX
 MOV CL,AH
 MOV AL,AH
@1:
 {$IFDEF __386__}
  DB 66h; AND AX,0FFh; DW 0 { AND EAX,0FFh }
 {$ELSE}
  XOR AH,AH
 {$ENDIF}
 {$IFOPT G+}
  SHL AX,3
 {$ELSE}
  SHL AX,1
  SHL AX,1
  SHL AX,1
 {$ENDIF}
 CLD
 PUSH DS
  PUSH BP
   MOV BP,Word Ptr RawY[SI]
   {$IFOPT G+}
    SHL BP,2
   {$ELSE}
    SHL BP,1
    SHL BP,1
   {$ENDIF}
   MOV SI,DataVideo.MIV.BytesPerLine
   SUB SI,8
   {$IFDEF __386__}
    DB 8Eh,0EEh { MOV GS,SI }
   {$ELSE}
    MOV Word Ptr @BytesPerLn,SI
   {$ENDIF}
   LDS SI,DataVideo.MIV.TxtMtx
   {$IFDEF __386__}
    DB 2Eh,0Fh,0B6h,0Eh {MOVZX AX,Byte Ptr CS:[Offset DataVideo.MIV.HeightChr]}
    DW Offset DataVideo.MIV.HeightChar
   {$ELSE}
    XOR CH,CH
    MOV CL,DataVideo.MIV.HeightChar
   {$ENDIF}
   MOV BL,DL
   SHL BX,1
   ADD SI,Word Ptr RawY[BX]
   MOV ES,DataVideo.MIV.AddrPage
   PUSH DX
    {$IFDEF __386__}
     DB 26h,66h,8Bh,7Eh,00h  { MOV EDI,ES:[BP] }
     DB 66h; ADD DI,AX       { ADD EDI,EAX }
     DW ciPushEDI
     DB ciPopAX
     DW ciPopFS
     DW ciPushEDI            { PUSH EDI }
     ADD SP,2
    {$ELSE}
     LES DI,ES:[BP]
     MOV DX,ES
     ADD DI,AX
     ADC DX,0
     MOV Word Ptr @Pg,DX
     PUSH DX
    {$ENDIF}
    PUSH CS
    CALL Near Ptr SetBnkPg
   POP DX
   MOV ES,DataVideo.MIV.SegVideo
   MOV DL,DH
   AND DH,0Fh
   {$IFOPT G+}
    SHR DL,4
   {$ELSE}
    SHR DL,1
    SHR DL,1
    SHR DL,1
    SHR DL,1
   {$ENDIF}
   MOV BP,CX
   MOV CX,DX
   {$IFDEF __386__}
    MOV AX,DX
    MOV AH,AL
    DB  ciPushAX,ciPushAX { EAX := DX:DX }
    DW  ciPopEAX
   {$ENDIF}
@L:LODSB
   OR  AL,AL
   JE  @xxxx
   MOV BH,AL
   ROL BH,1
   MOV AX,DX
   JNC @x1
   MOV AL,DH
@x1:
   ROL BH,1
   JC  @x2
   MOV AH,DL
@x2:
   STOSW
   ROL BH,1
   MOV AX,DX
   JNC @x3
   MOV AL,DH
@x3:
   ROL BH,1
   JC  @x4
   MOV AH,DL
@x4:
   STOSW
   ROL BH,1
   MOV AX,DX
   JNC @x5
   MOV AL,DH
@x5:
   ROL BH,1
   JC  @x6
   MOV AH,DL
@x6:
   STOSW
   ROL BH,1
   MOV AX,DX
   JNC @x7
   MOV AL,DH
@x7:
   ROL BH,1
   JC  @x8
   MOV AH,DL
@x8:
   STOSW
   JMP @@End
    {Ligne vide...}
@xxxx:
   MOV AL,CL
   MOV AH,AL
   {$IFDEF __386__}
    DW ciSTOSD
    DW ciSTOSD
   {$ELSE}
    STOSW
    STOSW
    STOSW
    STOSW
   {$ENDIF}
{$IFNDEF __386__}
   JMP @@End
 @BytesPerLn:DW 0
 @Pg:DW 0
{$ENDIF}
@@End:
   DEC BP
   OR  DI,DI
   JNZ @99
   {$IFDEF __386__}
    DB 8Ch,0EBh         { MOV BX,GS }
    DB 66h; ADD DI,BX   { ADD EDI,EBX }
   {$ELSE}
    ADD DI,Word Ptr @BytesPerLn
   {$ENDIF}
   JMP @99b
@99:
   {$IFDEF __386__}
    DB 8Ch,0EBh { MOV BX,GS }
    ADD DI,BX
   {$ELSE}
    ADD DI,Word Ptr @BytesPerLn
   {$ENDIF}
   JNC @y9
@99b:
   {$IFDEF __386__}
    DB 8Ch,0E0h  { MOV AX,FS }
    INC AX
    PUSH AX
(*    DB 66h,81h,0C7h,00h,00h,01h,00h { ADD EDI,10000h}
    DW ciPushEDI                    { PUSH EDI }
    ADD SP,2*)
   {$ELSE}
    INC Word Ptr @Pg
    PUSH Word Ptr @Pg
   {$ENDIF}
   PUSH CS
   CALL SetBnkPg.Near
   MOV DX,CX
@y9:
   OR  BP,BP
   JNE @L
@Over:
  POP BP
 POP DS
END;

{⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ‹
 ≥                         ProcÇdure FillBox                      €
 ¿‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹€


 Description
 ÕÕÕÕÕÕÕÕÕÕÕ

  Cette procÇdure efface une boåte avec les caractäres et attributs
 spÇcifiÇ d'un Çcran de graphique Super VGA en 256 couleurs.
}

Procedure FillBox;Var I,J:Byte;Begin
 For J:=Y1 to(Y2)do For I:=X1 to(X2)do ASM
  MOV CL,I
  MOV CH,J
  MOV AL,Chr
  MOV AH,Attr
  CALL AsmSetCube
{  SetCube(I,J,Chr,Attr)}
 END;
End;

{$I GFXGETCH.INC}

Procedure GetLnHorImg;Assembler;ASM
 MOV BX,Y
 {$IFOPT G+}
  SHL BX,2
 {$ELSE}
  SHL BX,1
  SHL BX,1
 {$ENDIF}
 MOV ES,DataVideo.MIV.AddrPage
 {$IFDEF __386__}
  MOV AX,X1                   { MOV AX,X }
  MOV CX,AX                   { MOV BX,AX }
  DB 66h; AND AX,0FFFFh; DW 0 { AND EAX,0000FFFFh }
  DB 66h; ADD AX,ES:[BX]      { ADD EAX,ES:[BX] }
  DB 66h; PUSH AX             { PUSH EAX }
 {$ELSE}
  LES AX,ES:[BX]
  MOV DX,ES
  MOV CX,X1
  ADD AX,CX
  ADC DX,0
  PUSH DX
  PUSH AX
 {$ENDIF}
 MOV AX,X2
 SUB AX,CX
 INC AX
 PUSH AX
 {$IFDEF __386__}
  DB 66h; PUSH Word Ptr Buffer
 {$ELSE}
  PUSH Word Ptr Buffer[2]
  PUSH Word Ptr Buffer
 {$ENDIF}
 PUSH CS
 CALL Near Ptr ReadBnk 
END;

Function GetPixel;Assembler;ASM
 MOV BX,Y
 {$IFOPT G+}
  SHL BX,2
 {$ELSE}
  SHL BX,1
  SHL BX,1
 {$ENDIF}
 MOV ES,DataVideo.MIV.AddrPage
 LES DI,ES:[BX]
 MOV DX,ES
 ADD DI,X
 ADC DX,0
 PUSH DX
 PUSH CS
 CALL SetBnkPg.Near
 MOV ES,DataVideo.MIV.SegVideo
 {$IFDEF __386__}
  DB 26h,0Fh,0B6h,05h { MOVZX AX,ES:[DI] }
 {$ELSE}
  MOV AL,ES:[DI]
  XOR AH,AH
 {$ENDIF}
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

Procedure Init;Assembler;Var L:Wd;ASM
 {$IFOPT G+}
  PUSH 0
  POP ES
 {$ELSE}
  XOR AX,AX
  MOV ES,AX
 {$ENDIF}
 MOV AX,ES:[$43*4]
 MOV CS:Word Ptr DataVideo.MIV.TxtMtx,AX
 MOV AX,ES:[$43*4+2]
 MOV CS:Word Ptr DataVideo.MIV.TxtMtx[2],AX
 MOV BL,ES:[$485]
 OR  BL,BL
 JE  @DefHeightChr
 MOV DataVideo.MIV.HeightChar,BL
@DefHeightChr:
 MOV BL,ES:[0484h]
 OR  BL,BL
 JE  @DefNmYTxts
 INC BL
 MOV DataVideo.MIV.NumYTexts,BL
@DefNmYTxts:
 MOV BX,ES:[044Ah]
 MOV DataVideo.MIV.NumXTexts,BL
 {$IFOPT G+}
  SHL BX,3
 {$ELSE}
  SHL BX,1
  SHL BX,1
  SHL BX,1
 {$ENDIF}
 MOV DataVideo.MIV.NumXPixels,BX
 MOV DataVideo.MIV.BytesPerLine,BX
 MOV AL,DataVideo.MIV.NumYTexts
 MUL DataVideo.MIV.HeightChar
 CMP AX,592
 JNE @No600
 ADD AX,8
@No600:
 MOV DataVideo.MIV.NumYPixels,AX
 MUL DataVideo.MIV.NumXPixels
 MOV Word Ptr DataVideo.MIV.ScrSize,AX
 MOV Word Ptr DataVideo.MIV.ScrSize[2],DX
 MOV AL,DataVideo.MIV.NumYTexts
 MUL DataVideo.MIV.NumXTexts
 MOV L,AX
 MOV CX,80
 XOR AX,AX
 XOR BX,BX
 MOV DL,DataVideo.MIV.NumXTexts
{ CMP DL,80
 JE @NoCompute}
 XOR DH,DH
@L:MOV Word Ptr RawTxtY[BX],AX
 INC BX
 INC BX
 ADD AX,DX
 CMP AX,L
 JB  @Skip
 XOR AX,AX
@Skip:
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
 MOV BX,4096/16
 {$IFDEF Autonome}
  MOV AH,$48
  INT $21
 {$ELSE}
  INT $9B
 {$ENDIF}
 MOV ES,AX
 MOV DataVideo.MIV.AddrPage,AX
 MOV CX,1024
 XOR AX,AX
 XOR DX,DX
 MOV SI,DataVideo.MIV.BytesPerLine
 XOR DI,DI
@L1:
 MOV ES:[DI],AX
 INC DI
 INC DI
 MOV ES:[DI],DX
 INC DI
 INC DI
 ADD AX,SI
 ADC DX,0
 LOOP @L1
{ For J:=0to(GetMaxYPixels)do Begin RealRawY^[J]:=L;Inc(L,Long(IVid.BytesPerLn))End}
 MOV AX,L
 {$IFOPT G+}
  SHR AX,3
 {$ELSE}
  SHR AX,1
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

{$I MvTxtSVGA.Inc}

Procedure PCopy;Begin End;

{$I PutCharG.Inc}

Procedure PutFillBox;Assembler;Var {$IFNDEF __386__}Addr1,{$ENDIF}Addr2:Long;L1,L:Wd;ASM
 CLD
 MOV AX,X2
 SUB AX,X1
 INC AX
 MOV L,AX
 MOV BX,Y1
 {$IFOPT G+}
  SHL BX,2
 {$ELSE}
  SHL BX,1
  SHL BX,1
 {$ENDIF}
 MOV ES,DataVideo.MIV.AddrPage
 {$IFDEF __386__}
  DB 66h; MOV AX,ES:[BX]        { MOV EAX,ES:[BX] }
  DB 66h; MOV SI,AX             { MOV ESI,EAX }
  MOV BX,Word Ptr X1            { MOV BX,Word Ptr X1 }
  DB 66h; AND BX,0FFFFh; DW 0   { AND EBX,0000FFFFh }
  DB 66h; ADD SI,BX             { ADD ESI,EBX }
  MOV BX,Word Ptr X2            { MOV BX,Word Ptr X2 }
  DB 66h; ADD AX,BX             { ADD EAX,EBX }
  DB 66h; MOV Word Ptr Addr2,AX { MOV Addr2,EAX }
 {$ELSE}
  LES AX,ES:[BX]
  MOV DX,ES
  PUSH AX
   ADD AX,X1
   ADC DX,0
   MOV Word Ptr Addr1,AX
   MOV Word Ptr Addr1[2],DX
  POP AX
  MOV DX,ES
  ADD AX,X2
  ADC DX,0
  MOV Word Ptr Addr2,AX
  MOV Word Ptr Addr2[2],DX
 {$ENDIF}
 MOV CX,Y2
 SUB CX,Y1
 INC CX
 MOV ES,DataVideo.MIV.SegVideo
@@Home:
 PUSH CX
  {$IFDEF __386__}
   DB 66h; PUSH SI { PUSH ESI }
   ADD SP,2        { ADD SP,2 }
  {$ELSE}
   PUSH Word Ptr Addr1[2]
  {$ENDIF}
  PUSH CS
  CALL SetBnkPg.Near
  {$IFDEF __386__}
   DB 66h; MOV AX,SI      { MOV EAX,ESI }
   DB 66h; SHR AX,16      { SHR EAX,16 }
  {$ELSE}
   MOV AL,Byte Ptr Addr1[2]
  {$ENDIF}
  CMP AL,Byte Ptr Addr2[2]
  JNE @@NotContinue
  {$IFDEF __386__}
   MOV DI,SI
  {$ELSE}
   MOV DI,Word Ptr Addr1
  {$ENDIF}
  MOV CX,L
  MOV AL,Byte Ptr Kr
  MOV AH,AL
  {$IFDEF __386__}
   DB  ciPushAX,ciPushAX { EAX := AX:AX }
   DW  ciPopEAX
   MOV BX,CX
   AND BX,3
   DB  0C1h,0E9h,002h       { SHR CX,2 }
   DB  ciREP; DW ciSTOSD    { REP STOSD }
   MOV CX,BX
   REP STOSB
  {$ELSE}
   SHR CX,1
   REP STOSW
   ADC CX,CX
   REP STOSB
  {$ENDIF}
  JMP @@EndPass
@@NotContinue:
  XOR CX,CX
  {$IFDEF __386__}
   SUB CX,SI
  {$ELSE}
   SUB CX,Word Ptr Addr1 { 0-AX n'est pas du sadomasochisme... }
  {$ENDIF}
  MOV L1,CX
  {$IFDEF __386__}
   MOV DI,SI
  {$ELSE}
   MOV DI,Word Ptr Addr1
  {$ENDIF}
  MOV AL,Byte Ptr Kr
  MOV AH,AL
  SHR CX,1
  REP STOSW
  ADC CX,CX
  REP STOSB
  PUSH Word Ptr Addr2[2]
  PUSH CS
  CALL SetBnkPg.Near
  MOV CX,L
  SUB CX,L1
  XOR DI,DI
  MOV AL,Byte Ptr Kr
  MOV AH,AL
  SHR CX,1
  REP STOSW
  ADC CX,CX
  REP STOSB
@@EndPass:
  {$IFDEF __386__}
   DB 66h; AND AX,0FFFFh; DW 0      { AND EAX,00000FFFFh }
   MOV AX,DataVideo.MIV.BytesPerLine{ MOV AX,DataVideo.MIV.BytesPerLine }
   DB 66h; ADD SI,AX                { ADD ESI,EAX }
   DB 66h; ADD Word Ptr Addr2,AX    { ADD Addr2,EAX }
  {$ELSE}
   XOR CX,CX
   MOV AX,DataVideo.MIV.BytesPerLine
   ADD Word Ptr Addr1,AX
   ADC Word Ptr Addr1[2],CX
   ADD Word Ptr Addr2,AX
   ADC Word Ptr Addr2[2],CX
  {$ENDIF}
 POP CX
 {$IFDEF __386__}
  DEC CX
  JNZ @@Home
 {$ELSE}
  LOOP @@Home
 {$ENDIF}
END;

{$F-}
{$I \Source\Chantal\Library\AbsInt.Inc}
{$F+}

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
 JB  @1
 XCHG AX,X2
 MOV X1,AX
@1:
 SUB X2,AX
 INC X2
 JMP ClrLnHor.Near[3]
@End:
END;

{$I PutRect.Inc}
{$I PutRndRe.Inc}

Procedure PutSmlImg;Var TBuf:TByte Absolute Buffer;J,I,L:Wd;Begin
 I:=0;L:=X2-X1+1;
 For J:=0to Y2-Y1 do Begin ClrLnHorImg(X1,J+Y1,L,8,TBuf[I]);Inc(I,L)End;
End;

Procedure ClrLnHorSprite(X,Y,L:Word;Var Buf);Near;Assembler;ASM
 PUSH DS
  MOV BX,Y
  {$IFOPT G+}
   SHL BX,2
  {$ELSE}
   SHL BX,1
   SHL BX,1
  {$ENDIF}
  MOV ES,DataVideo.MIV.AddrPage
  {$IFDEF __386__}
   DB 66h; MOV DI,ES:[BX]      { MOV EDI,ES:[BX] }
   MOV AX,X                    { MOV AX,X }
   DB 66h; AND AX,0FFFFh; DW 0 { AND EAX,00000FFFFh }
   DB 66h; ADD DI,AX           { ADD EDI,EAX }
   DB 66h; PUSH DI             { PUSH EDI }
   ADD SP,2                    { ADD SP,2 }
  {$ELSE}
   LES AX,ES:[BX]
   MOV DX,ES
   ADD AX,X
   ADC DX,0
   PUSH AX
    PUSH DX
     PUSH DX
  {$ENDIF}
    PUSH CS
    CALL SetBnkPg.Near
  {$IFNDEF __386__}
    POP DX
   POP BX
   MOV DI,BX
  {$ELSE}
   DB 66h; MOV BX,DI { MOV EBX,EDI }
  {$ENDIF}
  CLD
  MOV ES,DataVideo.MIV.SegVideo
  MOV CX,L
  LDS SI,Buf
  ADD BX,CX
  JNC @End
  {$IFDEF __386__}
   DB 66h; PUSH DI        { PUSH EDI }
   ADD SP,2
   POP DX
  {$ENDIF}
  INC DX
  XOR CX,CX
  SUB CX,DI
  MOV BX,CX
@1a:LODSB
   OR AL,AL
   JE @2a
   STOSB
   LOOP @1a
   JMP @3a
@2a:INC DI
   LOOP @1a
@3a:
  PUSH ES
   PUSH SI
    PUSH AX
     PUSH BX
      PUSH DX
      PUSH CS
      CALL Near Ptr SetBnkPg
     POP BX
    POP AX
   POP SI
  POP ES
  XOR DI,DI
  MOV CX,L
  SUB CX,BX
  JCXZ @3b
@End:
@1b:LODSB
   OR AL,AL
   JE @2b
   STOSB
   LOOP @1b
   JMP @3b
@2b:INC DI
   LOOP @1b
@3b:
 POP DS
END;

Procedure PutSprite;
Var
 TBuf:TByte Absolute Buffer;
 J,I,L,PL,MX,MY:Word;
Begin
 I:=0;L:=X2-X1+1;PL:=L;
 ASM
  MOV AX,DataVideo.MIV.NumXPixels
  MOV MX,AX
  MOV AX,DataVideo.MIV.NumYPixels
  MOV MY,AX
 END;
 If(MY<Y1)Then Exit;
 If(MY<Y2)Then MY:=Y2;
 If(MX<X1+PL)Then PL:=MX-X1;
 For J:=0to(Y2-Y1)do Begin
  ClrLnHorSprite(X1,J+Y1,PL,TBuf[I]);
  Inc(I,L)
 End;
End;

{⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ‹
 ≥                        ProcÇdure PutTxtXY                      €
 ¿‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹€


 Description
 ÕÕÕÕÕÕÕÕÕÕÕ

  Cette procÇdure affiche un message Ö l'Çcran de graphiques en 256
 couleurs aux coordonnÇes texte (X,Y) avec l'attribut ÆAttrØ.
}

Procedure PutTxtXY;Var TblOfs:Array[0..127]of Word;
Img:Array[0..1023]of Byte;GX,GY,Len:Word;Begin
  { La routine suivante est Çlaborer selon la technique d'affichage
   linÇaire afin  d'accÇlÇrer  les performances  du BIOS VESA Çtant
   träs lent!  Cela signifie  qu'il  affiche la  premiäre  ligne de
   chacun  des  caractäres,  ensuite,  la deuxiäme  de  chacun  des
   caractäres et ainsi de suite jusqu'Ö la derniäre...
  }
 Len:=Length(Str);
 If Len>127Then Len:=127;
 ASM
  CLD
  MOV AL,X
  XOR AH,AH
  {$IFOPT G+}
   SHL AX,3
  {$ELSE}
   SHL AX,1
   SHL AX,1
   SHL AX,1
  {$ENDIF}
  MOV GX,AX
  MOV BL,Y
  XOR BH,BH
  SHL BX,1
  MOV AX,Word Ptr RawY[BX]
  MOV GY,AX
  PUSH DS
   MOV CX,Len
   OR  CX,CX
   JZ  @End
   MOV DI,Offset TblOfs
   ADD DI,BP
   PUSH SS
   POP ES
   LDS SI,Str
@LoopAddr:
   INC SI
   MOV BL,DS:[SI]
   XOR BH,BH
   SHL BX,1
   MOV AX,Word Ptr RawY[BX]
   ADD AX,Word Ptr DataVideo.MIV.TxtMtx
   STOSW
   LOOP @LoopAddr
   MOV BL,Attr
   MOV BH,BL
   AND BL,$F
   {$IFOPT G+}
    SHR BH,4
   {$ELSE}
    SHR BH,1
    SHR BH,1
    SHR BH,1
    SHR BH,1
   {$ENDIF}
   MOV CL,DataVideo.MIV.HeightChar
   XOR CH,CH
@PutLine:
   PUSH CX
    MOV CX,Len
    PUSH CX
     XOR DX,DX
     MOV DI,Offset Img
     ADD DI,BP
     PUSH SS
     POP ES
     MOV DS,Word Ptr DataVideo.MIV.TxtMtx[2]
@LinearMtx:
     MOV SI,Offset TblOfs
     ADD SI,BP
     ADD SI,DX
     MOV SI,SS:[SI]
     LODSB
  @1:SHL AL,1
     JNC @B1
     XCHG AX,BX
     STOSB
     XCHG AX,BX
     JMP  @E1
 @B1:XCHG AL,BH
     STOSB
     XCHG AL,BH
 @E1:SHL AL,1
     JNC @B2
     XCHG AX,BX
     STOSB
     XCHG AX,BX
     JMP  @E2
 @B2:XCHG AL,BH
     STOSB
     XCHG AL,BH
 @E2:SHL AL,1
     JNC @B3
     XCHG AX,BX
     STOSB
     XCHG AX,BX
     JMP  @E3
 @B3:XCHG AL,BH
     STOSB
     XCHG AL,BH
 @E3:SHL AL,1
     JNC @B4
     XCHG AX,BX
     STOSB
     XCHG AX,BX
     JMP  @E4
 @B4:XCHG AL,BH
     STOSB
     XCHG AL,BH
 @E4:SHL AL,1
     JNC @B5
     XCHG AX,BX
     STOSB
     XCHG AX,BX
     JMP  @E5
 @B5:XCHG AL,BH
     STOSB
     XCHG AL,BH
 @E5:SHL AL,1
     JNC @B6
     XCHG AX,BX
     STOSB
     XCHG AX,BX
     JMP  @E6
 @B6:XCHG AL,BH
     STOSB
     XCHG AL,BH
 @E6:SHL AL,1
     JNC @B7
     XCHG AX,BX
     STOSB
     XCHG AX,BX
     JMP  @E7
 @B7:XCHG AL,BH
     STOSB
     XCHG AL,BH
 @E7:SHL AL,1
     JNC @B8
     XCHG AX,BX
     STOSB
     XCHG AX,BX
     JMP @B9
 @B8:XCHG AL,BH
     STOSB
     XCHG AL,BH
 @B9:INC DX
     INC DX
     DEC CX
     JNZ @LinearMtx
    POP CX
    MOV DI,Offset TblOfs
    ADD DI,BP
    MOV SI,DI
    PUSH SS
    POP DS
@Loop:
    LODSW
    INC AX
    STOSW
    LOOP @Loop
     {_ClrLnHorImg(GX,GY,Len shl 3,Img[8]);}
    PUSH BX
     PUSH GX
     PUSH GY
     MOV AX,Len
     {$IFOPT G+}
      SHL AX,3
     {$ELSE}
      SHL AX,1
      SHL AX,1
      SHL AX,1
     {$ENDIF}
     PUSH AX
     PUSH SS
     MOV DI,Offset Img
     ADD DI,BP
     PUSH DI
     CALL _ClrLnHorImg
    POP BX
    INC GY
   POP CX
   DEC CX
   JNZ @PutLine
    { Mise Ö jour de l'accÇlÇrateur de donnÇes }
   MOV BL,Y
   XOR BH,BH
   SHL BX,1
   MOV DI,Word Ptr RawTxtY[BX] {DI:=RawTxtY[Y shl 1]}
   MOV BL,X
   ADD DI,BX
   SHL DI,1
   MOV ES,DataVideo.MIV.SegBuffer
   LDS SI,Str
   LODSB
   MOV CL,AL
   XOR CH,CH
   JCXZ @End
   MOV AH,Attr
@L:LODSB
   STOSW
   LOOP @L
@End:
  POP DS
 END;
End;

(*Procedure PutTxtXY;Var I,J:Byte;Begin
 If Attr and$F=Attr shr 4Then BarSpcHor(X,Y,X+Length(Str)-1,Attr)
  Else
 For I:=1to Length(Str)do Begin
  If Str[I]=' 'Then Begin
   J:=I;
   For I:=J to Length(Str)do If Str[I]<>' 'Then Break;
   BarSpcHor(X+J-1,Y,X+I-1,Attr)
  End;
  ASM
    {SetCube(X+I-1,Y,Str[I],Attr)}
   MOV BL,I
   XOR BH,BH
   MOV CL,X
   ADD CL,BL
   DEC CL
   MOV CH,Y
   LES DI,Str
   MOV AL,ES:[DI+BX]
   MOV AH,Attr
   CALL AsmSetCube
  END;
 End;
End;*)

Procedure PutTxtXYUnKr;Var I,J:Byte;Begin
 J:=X;
 For I:=1to Length(Str)do Begin
  SetCube(J,Y,Str[I],GetAttr(J,Y));
  Inc(J)
 End;
End;

Procedure SetAttr;Begin
 SetCube(X,Y,GetChr(X,Y),Attr)
End;

Procedure SetBackgroundColor;Begin End;
Procedure SetBlink;Begin End;

Procedure SetBorderColor;Assembler;ASM
 MOV AX,1001h
 MOV BH,Kr
 INT 10h
END;

Procedure SetBytesPerLn;Assembler;ASM
 MOV AX,X
 MOV DataVideo.MIV.BytesPerLine,AX
 SHR AX,1
 MOV AH,AL
 MOV DX,3D4h
 MOV AL,13h
 OUT DX,AX
  { Fixe les longueurs des lignes... }
 MOV ES,DataVideo.MIV.AddrPage
 MOV CX,1024
 XOR AX,AX
 XOR DX,DX
 MOV SI,DataVideo.MIV.BytesPerLine
 XOR DI,DI
@L1:
 MOV ES:[DI],AX
 INC DI
 INC DI
 MOV ES:[DI],DX
 INC DI
 INC DI
 ADD AX,SI
 ADC DX,0
 LOOP @L1
END;

Procedure SetChr;Assembler;ASM
 {SetCube(X,Y,Chr,GetAttr(X,Y));}
 {$IFDEF __386__}
  DB 36h,0Fh,0B6h,05Eh,08h { MOVZX BX,Byte Ptr SS:[BP+8] }
 {$ELSE}
  MOV BL,Y
  XOR BH,BH
 {$ENDIF}
 MOV DL,BL
 SHL BX,1
 MOV SI,Word Ptr RawTxtY[BX]
 MOV CL,X
 XOR CH,CH
 ADD SI,CX
 SHL SI,1
 MOV ES,DataVideo.MIV.SegBuffer
 MOV AX,ES:[SI]
 MOV AL,Chr
 MOV CH,DL
 CALL AsmSetCube
END;

Procedure SetCube;Assembler;ASM
 MOV CL,X
 MOV CH,Y
 MOV AL,Chr
 MOV AH,Attr
 CALL AsmSetCube
END;
(*Assembler;ASM
 MOV ES,DataVideo.MIV.SegBuf
 {$IFDEF __386__}
  DB 36h,0Fh,0B6h,05Eh,0Ah { MOVZX BX,Byte Ptr SS:[BP+0Ah] }
 {$ELSE}
  MOV BL,Y
  XOR BH,BH
 {$ENDIF}
 SHL BX,1
 MOV SI,BX
 MOV DI,Word Ptr RawTxtY[BX]
 MOV BL,X
 ADD DI,BX
 SHL DI,1
 MOV AL,Chr
 MOV AH,Attr
 STOSW
 MOV BL,DataVideo.MIV.NmXTxts
 MOV AH,BL
 DEC AH
 MOV AL,X
 CMP AL,AH
 JBE @1
 DIV BL
 ADD Y,AL
 MOV BL,Y
 SHL BX,1
 MOV SI,BX
 MOV X,AH
 MOV AL,AH
@1:
 XOR AH,AH
 {$IFOPT G+}
  SHL AX,3
 {$ELSE}
  SHL AX,1
  SHL AX,1
  SHL AX,1
 {$ENDIF}
 MOV Word Ptr X,AX
 MOV AX,Word Ptr RawY[SI]
 MOV Word Ptr Y,AX
 JMP SetGCube.Near[3]
END;*)

{$I GFXSETCU.INC}

Procedure SetGCube;Assembler;ASM
 CLD
 PUSH DS
  MOV AX,DataVideo.MIV.BytesPerLine
  SUB AX,8
  MOV Word Ptr @BytesPerLn,AX
  LDS SI,DataVideo.MIV.TxtMtx
  {$IFDEF __386__}
   DB 2Eh,0Fh,0B6h,01Eh {MOVZX BX,Byte Ptr CS:[Offset DataVideo.MIV.HeightChar]}
   DW Offset DataVideo.MIV.HeightChar
  {$ELSE}
   XOR BH,BH
   MOV BL,DataVideo.MIV.HeightChar
  {$ENDIF}
  MOV CX,BX
  MOV BL,Chr
  SHL BX,1
  ADD SI,Word Ptr RawY[BX]
  MOV BX,Y
  {$IFOPT G+}
   SHL BX,2
  {$ELSE}
   SHL BX,1
   SHL BX,1
  {$ENDIF}
  MOV ES,DataVideo.MIV.AddrPage
  LES DI,ES:[BX]
  MOV DX,ES
  ADD DI,X
  ADC DX,0
  MOV Word Ptr @Pg,DX
  PUSH DX
  PUSH CS
  CALL SetBnkPg.Near
  MOV ES,DataVideo.MIV.SegVideo
  MOV DL,Attr
  MOV DH,DL
  AND DH,0Fh
  {$IFOPT G+}
   SHR DL,4
  {$ELSE}
   SHR DL,1
   SHR DL,1
   SHR DL,1
   SHR DL,1
  {$ENDIF}
  MOV Word Ptr @Back,DX
  PUSH BP
   MOV BP,CX
@L:MOV AX,DI
   ADD AX,7
   JC  @@Long
   LODSB
   OR  AL,AL
   JE  @xxxx
   MOV BH,AL
   ROL BH,1
   MOV AX,DX
   JNC @x1
   MOV AL,DH
@x1:
   ROL BH,1
   JC  @x2
   MOV AH,DL
@x2:
   STOSW
   ROL BH,1
   MOV AX,DX
   JNC @x3
   MOV AL,DH
@x3:
   ROL BH,1
   JC  @x4
   MOV AH,DL
@x4:
   STOSW
   ROL BH,1
   MOV AX,DX
   JNC @x5
   MOV AL,DH
@x5:
   ROL BH,1
   JC  @x6
   MOV AH,DL
@x6:
   STOSW
   ROL BH,1
   MOV AX,DX
   JNC @x7
   MOV AL,DH
@x7:
   ROL BH,1
   JC  @x8
   MOV AH,DL
@x8:
   STOSW
   JMP @@End
@@Long:
   MOV AH,AL
   MOV DX,Word Ptr @Back
   MOV CX,8
@L3:
   TEST DI,0FFFFh
   JNZ @L3A
   MOV AX,Word Ptr @Pg
   INC AX
   PUSH AX
   PUSH CS
   CALL SetBnkPg.Near
   MOV DX,Word Ptr @Back
@L3A:
   MOV BL,BH
   ROR BL,CL
   JC  @@Long4
   MOV AL,DL
   STOSB
   {$IFDEF __386__}
    DEC CX
    JNZ @L3
   {$ELSE}
    LOOP @L3
   {$ENDIF}
   JMP @@End
    {Ligne vide...}
@xxxx:
   MOV AL,Byte Ptr @Back
   MOV AH,AL
   STOSW
   STOSW
   STOSW
   STOSW
   JMP @@End
@BytesPerLn:DW 0
@Pg:DW 0
@Back:DB 0
@Fore:DB 0
@@Long4:MOV AL,DH
   STOSB
   {$IFDEF __386__}
    DEC CX
    JNZ @L3
   {$ELSE}
    LOOP @L3
   {$ENDIF}
@@End:
   DEC BP
   TEST DI,0FFFFh
   JNZ @99
   ADD DI,Word Ptr @BytesPerLn
   JMP @99b
@99:
   ADD DI,Word Ptr @BytesPerLn
   JNC @y9
@99b:
   INC Word Ptr @Pg
   PUSH Word Ptr @Pg
   PUSH CS
   CALL SetBnkPg.Near
   MOV DX,Word Ptr @Back
@y9:
   OR BP,BP
   JNE @L
  POP BP
 POP DS
END;

Procedure SetGCubeT;
Var
 I,M:Word;
 PB:^Byte;
Begin
 ASM
  MOV AL,DataVideo.MIV.HeightChar
  XOR AH,AH
  DEC AX
  MOV M,AX
  LES DI,DataVideo.MIV.TxtMtx
  MOV Word Ptr PB[2],ES
  MOV BL,Chr
  XOR BH,BH
  SHL BX,1
  ADD DI,Word Ptr RawY[BX]
  MOV Word Ptr PB,DI
 END;
 For I:=0to(M)do Begin
  CopT8Bin(X,Y+I,PB^,Attr);
  Inc(Word(PB))
 End;
End;

Procedure SetMatrix;Begin End;

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
 {$IFDEF __386__}
  DEC CX
  JNZ @2
 {$ELSE}
  LOOP @2
 {$ENDIF}
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
  {$IFDEF __386__}
   DEC CX
   JNZ @2
  {$ELSE}
   LOOP @2
  {$ENDIF}
 POP DS
END;

Procedure SetPg;Begin End;

Procedure SetPixel;Assembler;ASM
 TEST X,8000h
 JNZ @End
 MOV BX,Y
 {$IFOPT G+}
  SHL BX,2
 {$ELSE}
  SHL BX,1
  SHL BX,1
 {$ENDIF}
 MOV ES,DataVideo.MIV.AddrPage
 {$IFDEF __386__}
  MOV DI,X                     { MOV DI,X }
  DB 66h; AND DI,0FFFFh; DW 0  { AND EDI,00000FFFFh }
  DB 66h; ADD DI,ES:[BX]       { ADD EDI,ES:[BX] }
  DB 66h; PUSH DI              { PUSH EDI }
  ADD SP,2                     { ADD SP,2 }
 {$ELSE}
  LES DI,ES:[BX]
  MOV DX,ES
  ADD DI,X
  ADC DX,0
  PUSH DX
 {$ENDIF}
 PUSH CS
 CALL SetBnkPg.Near
 MOV ES,DataVideo.MIV.SegVideo
 MOV AX,Kr
 STOSB
@End:
END;

Procedure SetHorizontalScale;Begin End;
Procedure SetVerticalScale;Begin End;
Procedure SetVisualPg;Begin End;

{$I SetBnkPg.Inc}

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

Procedure ReadBnk;Assembler;ASM
 PUSH Word Ptr aY[2]
 PUSH CS
 CALL SetBnkPg.Near
 CLD
 PUSH DS
  LES DI,x0
  MOV SI,Word Ptr aY
  LDS AX,aY
  MOV DX,DS
  MOV DS,DataVideo.MIV.SegVideo
  MOV CX,L
  ADD AX,CX
  ADC DX,0
  CMP Byte Ptr aY[2],DL
  JE  @End
  XOR CX,CX
  SUB CX,SI
  MOV BX,CX
  {$IFDEF __386__}
   MOV AX,CX
   AND AX,3
   {$IFOPT G+}
    SHR CX,2
   {$ELSE}
    DB $C1,$E9,$02 { SHR CX,2 }
   {$ENDIF}
   DB  ciREP; DW ciMOVSD
   XCHG AX,CX
   REP MOVSB
  {$ELSE}
   SHR CX,1
   REP MOVSW
   ADC CX,CX
   REP MOVSB
  {$ENDIF}
  PUSH DX
  PUSH CS
  CALL SetBnkPg.Near
  MOV CX,L
  SUB CX,BX
@End:
  {$IFDEF __386__}
   MOV AX,CX
   AND AX,3
   {$IFOPT G+}
    SHR CX,2
   {$ELSE}
    DB $C1,$E9,$02 { SHR CX,2 }
   {$ENDIF}
   DB  ciREP; DW ciMOVSD
   XCHG CX,AX
   REP MOVSB
  {$ELSE}
   SHR CX,1
   REP MOVSW
   ADC CX,CX
   REP MOVSB
  {$ENDIF}
 POP DS
END;

Procedure FillBnk;Assembler;ASM
 PUSH Word Ptr aY[2]
 PUSH CS
 CALL SetBnkPg.Near
 CLD
 MOV DI,Word Ptr aY
 LES AX,aY
 MOV DX,ES
 MOV ES,DataVideo.MIV.SegVideo
 MOV CX,L
 ADD AX,CX
 ADC DX,0
 CMP Byte Ptr aY[2],DL
 JE  @End
 XOR CX,CX
 SUB CX,DI
 MOV BX,CX
 MOV AL,Byte Ptr Kr
 MOV AH,AL
 {$IFDEF __386__}
  DB  ciPushAX,ciPushAX { EAX := AX:AX }
  DW  ciPopEAX
  MOV BX,CX
  AND BX,3
  {$IFOPT G+}
   SHR CX,2
  {$ELSE}
   DB  $C1,$E9,$02          { SHR CX,2 }
  {$ENDIF}
  DB  ciREP; DW ciSTOSD    { REP STOSD }
  MOV CX,BX
  REP STOSB
 {$ELSE}
  SHR CX,1
  REP STOSW
  ADC CX,CX
  REP STOSB
 {$ENDIF}
 PUSH DX
 PUSH CS
 CALL SetBnkPg.Near
 MOV CX,L
 SUB CX,BX
@End:
 MOV AL,Byte Ptr Kr
 MOV AH,AL
 {$IFDEF __386__}
  DB  ciPushAX,ciPushAX { EAX := AX:AX }
  DW  ciPopEAX
  MOV BX,CX
  AND BX,3
  {$IFOPT G+}
   SHR CX,2
  {$ELSE}
   DB  $C1,$E9,$02          { SHR CX,2 }
  {$ENDIF}
  DB  ciREP; DW ciSTOSD    { REP STOSD }
  MOV CX,BX
  REP STOSB
 {$ELSE}
  SHR CX,1
  REP STOSW
  ADC CX,CX
  REP STOSB
 {$ENDIF}
END;

Procedure WriteBnk;Assembler;ASM
 PUSH Word Ptr aY[2]
 PUSH CS
 CALL SetBnkPg.Near
 CLD
 PUSH DS
  LDS SI,x0
  MOV DI,Word Ptr aY
  LES AX,aY
  MOV DX,ES
  MOV ES,DataVideo.MIV.SegVideo
  MOV CX,L
  ADD AX,CX
  ADC DX,0
  CMP Byte Ptr aY[2],DL
  JE  @End
  XOR CX,CX
  SUB CX,DI
  MOV BX,CX
  {$IFDEF __386__}
   MOV AX,CX
   AND AX,3
   {$IFOPT G+}
    SHR CX,2
   {$ELSE}
    DB $C1,$E9,$02 { SHR CX,2 }
   {$ENDIF}
   DB  ciREP; DW ciMOVSD
   XCHG AX,CX
   REP MOVSB
  {$ELSE}
   SHR CX,1
   REP MOVSW
   ADC CX,CX
   REP MOVSB
  {$ENDIF}
  PUSH DX
  PUSH CS
  CALL SetBnkPg.Near
  MOV CX,L
  SUB CX,BX
@End:
  {$IFDEF __386__}
   MOV AX,CX
   AND AX,3
   {$IFOPT G+}
    SHR CX,2
   {$ELSE}
    DB $C1,$E9,$02 { SHR CX,2 }
   {$ENDIF}
   DB  ciREP; DW ciMOVSD
   XCHG AX,CX
   REP MOVSB
  {$ELSE}
   SHR CX,1
   REP MOVSW
   ADC CX,CX
   REP MOVSB
  {$ENDIF}
 POP DS
END;

{$I GrfIcon.Inc}
{$I Done.Inc}

Procedure {$IFDEF __386__}EndDriverSVGA3;{$ELSE}EndDriverSVGA;{$ENDIF}Assembler;ASM END;