{DrvVESA.Inc}

Procedure RawTxtY;Forward;
Procedure RawY;Forward;
Procedure FillBnk(aY:Long;L:Wd;Kr:Byte);Far;Forward;

Procedure _DriverVESA;Assembler;ASM
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
 DW 0
END;

Procedure PhysVideo;Assembler;ASM
 DB 0,0 {Card,Monitor:Nom de la carte vid‚o (vn????),Nom du moniteur (mn????)}
 DB 0 {CardCat:Cat‚gorie de la carte vid‚o(MDA,CGA,...)(cvn????)}
 DD 262144 {Memory:Nombre de m‚moire (en octet) dont dispose la carte vid‚o}
 DB Ya {Font:Police programmable support‚ par cette carte?}
 DB 0 {Hercule:Mode Hercule support‚ par cette carte?}
 DW $A000{Seg16C:Segment par d‚faut en 16 couleurs}
 DB Ya{Palette:Palette de couleur programme support‚?}
 DB Ya{Color:Carte de type couleur? autrement monochrome}
 DB Ya{BBlink:Le Bios supporte le mode clignotement/intensit‚?}
 DB Ya{EGA:La carte est post‚rieur ou ‚gale … l'EGA}
 DB Ya{VGA:La carte est post‚rieur ou ‚gale … la VGA}
 DB 0 {VGA320x400:Le mode VGA 320x400 est support‚ (pas toujours le cas chez les clones)}
 DB 0 {VESA:Le standard VESA support‚? }
 DW $C000 {ROM:Adresse de la ROM Bios}
 DB 0 {MousePort:Port souris inclue … la carte vid‚o?}
 DB 0 {VideoBits:Nombre d'accŠs bits au entr‚e/sortie vid‚o}
 DB 0 {ROMBits:Nombre d'accŠs bits … la ROM Bios}
 DB 6 {DACBits:Nombre de bits utilis‚ pour modifi‚ un des 3 DAC RGB}
 DB 0 {PVC:Horloge vid‚o programme?}
 DW 14{ProcSelBnkPg:Adresse d'index de la proc‚dure de changement de page de la banque}
 DW 0{ProcSetVideoMode:Adresse d'index de la proc‚dure de changement de mode vid‚o}
END;

Procedure DataVideo;Assembler;ASM
 DW 0{Mode:Mode vid‚o actuel (vm???)}
 DB Ya{IbmLogic:Mode dans la logique IBM (pas hors cas texte … la SVGA...)}
 DB Ya{BiosSupport:Mode support‚ par le Bios (Par exemple, la GS en 16 couleurs le Bios ne le connaŒt pas)}
 DB Ya{Colr:Mode couleur? Sinon monochrome for‡‚ment...}
 DB Ya{Graf:Mode graphique? Sinon texte}
 DB Ya{Direct:M‚thode directe? Sinon Bios ou Dos}
 DB No{Blink:Clignotement}
 DB No{Snow:Neige lors de l'envoie de donn‚e dans le tampon vid‚o?}
 DW $A000{SegV:Segment vid‚o (A000h,B000h,B800h,...)}
 DB 8{HeightChr:Hauteur de la police de caractŠre actuel}
 DW 320{NmXPixels:Nombre de pixels horizontal qu'affiche l'‚cran}
 DW 200{NmYPixels:Nombre de pixels vertical qu'affiche l'‚cran}
 DB 40,25{NmXTxts,NmYTxts:Nombre de caractŠre texte horizontal/vertical qu'affiche l'‚cran}
 DB 1{NmVidPgs:Nombre de page vid‚o que supporte le mode actuel}
 DD 256{NmColrs:Nombre de couleurs affich‚}
 DB 8{BitsPerPixel:Nombre de Bit(s) utilis‚ pour l'affichage d'un pixel}
 DW 320{BytesPerLn:Nombre d'octet par ligne affich‚ (trŠs relatif en VGA...)}
 DB 0{Pg:Num‚ro de la page vid‚o de travail}
 DW 4096{AddrPg:En texte, adresse en m‚moire vid‚o de la page actuel,
      Super VGA en 256: Pointeur de RealRawY}
 DB 0{ShowPg:Num‚ro de la page vid‚o actuellement affich‚}
 DD 0{TxtMtx:Pointeur sur la police de caractŠre courante}
 DD 64000{ScrSize:Taille de l'‚cran}
 DW 0{SizeBnk:Taille d'un page de la banque (0=64Ko)}
 DW 0{SegBuf:Segment du tampon d'acc‚l‚ration}
 DB 0{IsDblMtx:Y a-t-il une police de 512 caractŠres?}
 DB 0,0 {XCur,YCur:Position actuel du curseur}
 DB 0,0 {StartCur,EndCur:D‚but et fin du curseur}
END;

Procedure RawTxtY;Assembler;ASM
 DW     0,   80,  160,  240,  320,  400,  480,  560,  640,  720,  800,  880,  960, 1040, 1120, 1200 { 16 }
 DW  1280, 1360, 1440, 1520, 1600, 1680, 1760, 1840, 1920, 2000, 2080, 2160, 2240, 2320, 2400, 2480 { 32 }
 DW  2560, 2640, 2720, 2800, 2880, 2960, 3040, 3120, 3200, 3280, 3360, 3440, 3520, 3600, 3680, 3760 { 48 }
 DW  3840, 3920, 4000, 4080, 4160, 4240, 4320, 4400, 4480, 4560, 4640, 4720, 4800, 4880, 4960, 5040 { 64 }
 DW  5120, 5200, 5280, 5360, 5440, 5520, 5600, 5680, 5760, 5840, 5820, 5900, 5980, 6060, 6140, 6220 { 80 }
 DW  6300, 6380, 6460, 6540, 6620, 6700, 6780, 6860, 6940, 7020, 7100, 7180, 7260, 7340, 7420, 7500 { 96 }
 DW  7580, 7660, 7740, 7820, 7900, 7980, 8060, 8140, 8220, 8300, 8380, 8460, 8540, 8620, 8700, 8780 { 112 }
 DW  8860, 8940, 9020, 9100, 9180, 9260, 9340, 9420, 9500, 9580, 9660, 9740, 9820, 9900, 9980,10060 { 128 }
 DW 10140,10220,10300,10380,10460,10540,10620,10700,10780,10860,10940,11020,11100,11180,11260,11340 { 144 }
 DW 11420,11500,11580,11660,11740,11820,11900,11980,12060,12140,12220,12300,12380,12460,12540,12620 { 160 }
 DW 12700,12780,12860,12940,13020,13100,13180,13260,13340,13420,13500,13580,13660,13740,13820,13900 { 176 }
 DW 13980,14060,14140,14220,14300,14380,14460,14540,15620,14700,14780,14860,14940,15020,15100,15180 { 192 }
 DW 15260,15340,15420,15500,15580,15660,15740,15820,15900,15980,16060,16140,16220,16300,16380,16460 { 208 }
 DW 16540,16620,16700,16780,16860,16940,17020,17100,17180,17260,17340,17420,17500,17580,17660,17740 { 224 }
 DW 17820,17900,17980,18060,18140,18220,18300,18360,18460,18540,18620,18700,18780,18860,18940,19020 { 240 }
 DW 19100,19180,19260,19340,19420,19500,19580,19660,19740,19820,19900,19980,20060,20140,20220,20300 { 256 }
 DW Offset PhysVideo
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

Procedure BarSpcHor;Assembler;ASM
 MOV BL,Y
 XOR BH,BH
 SHL BX,1
 MOV DI,Word Ptr RawY[BX]
 MOV DX,DI
 ADD DL,DataVideo.MIV.HeightChar
 ADC DH,0
 DEC DX
 MOV AL,X1
 XOR AH,AH
 {$IFOPT G+}
  SHL AX,3
 {$ELSE}
  SHL AX,1
  SHL AX,1
  SHL AX,1
 {$ENDIF}
 MOV CX,AX
 MOV AL,X2
 XOR AH,AH
 {$IFOPT G+}
  SHL AX,3
 {$ELSE}
  SHL AX,1
  SHL AX,1
  SHL AX,1
 {$ENDIF}
 OR  AL,7
 MOV SI,AX
 XOR AH,AH
 MOV AL,Attr
 {$IFOPT G+}
  SHR AX,4
 {$ELSE}
  SHR AX,1
  SHR AX,1
  SHR AX,1
  SHR AX,1
 {$ENDIF}
 PUSH CX
 PUSH DI
 PUSH SI
 PUSH DX
 PUSH AX
 PUSH CS
 CALL Near Ptr PutFillBox
   { Fixe dans le tampon acc‚l‚rateur... }
 MOV ES,DataVideo.MIV.SegBuffer
 MOV BL,Y
 XOR BH,BH
 SHL BX,1
 MOV DI,CS:[Offset RawTxtY+BX]
 MOV CL,X1
 XOR CH,CH
 ADD DI,CX
 SHL DI,1
 MOV CL,X2
 SUB CL,X1
 INC CX
 MOV AH,Attr
 MOV AL,' '
 REP STOSW
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

Procedure ClrLnHor;Assembler;ASM
 MOV BX,Y
 {$IFOPT G+}
  SHL BX,2
 {$ELSE}
  SHL BX,1
  SHL BX,1
 {$ENDIF}
 MOV ES,DataVideo.MIV.AddrPage
 LES AX,ES:[BX]
 MOV DX,ES
 ADD AX,X
 ADC DX,0
 {$IFDEF VESA}
  PUSH DX
  PUSH AX
  PUSH L
  PUSH Word Ptr Kr
  PUSH CS
  CALL FillBnk.Near
 {$ELSE}
  {$IFDEF OldMethode}
   PUSH AX
    PUSH DX
    PUSH CS
    CALL SetBnkPg.Near
   POP DI
   CLD
   MOV AX,Kr
   MOV ES,DataVideo.MIV.SegV
   MOV CX,L
   MOV AH,AL
   SHR CX,1
   REP STOSW
   ADC CX,CX
   REP STOSB
  {$ELSE}
   PUSH AX
    PUSH DX
     PUSH DX
     PUSH CS
     CALL SetBnkPg.Near
    POP DX
   POP AX
   CLD
   MOV SI,DX
   MOV DI,AX
   MOV ES,DataVideo.MIV.SegV
   MOV CX,L
   ADD AX,CX
   ADC DX,0
   MOV AX,Kr
   MOV AH,AL
   CMP SI,DX
   JE  @End
   XOR CX,CX
   SUB CX,DI
   MOV BX,CX
   SHR CX,1
   REP STOSW
   ADC CX,CX
   REP STOSB
   PUSH AX
    PUSH DX
    PUSH CS
    CALL SetBnkPg.Near
   POP AX
   MOV CX,L
   SUB CX,BX
@End:
   SHR CX,1
   REP STOSW
   ADC CX,CX
   REP STOSB
  {$ENDIF}
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
 LES AX,ES:[BX]
 MOV DX,ES
 ADD AX,X
 ADC DX,0
 {$IFDEF WriteBnkJMP}
  MOV Y,AX
  MOV X,DX
  JMP Near Ptr WriteBnk[3]
 {$ELSE}
  PUSH DX
  PUSH AX
  PUSH L
  PUSH Word Ptr Buffer[2]
  PUSH Word Ptr Buffer
  PUSH CS
  CALL Near Ptr WriteBnk
 {$ENDIF}
END;

Procedure ClrLnHorImg;
Var
 BufPtr:Array[0..1279]of Byte;
 MX,MY,I,Base,Xa:Word;
 Ta:Byte;TBuf:TByte Absolute Buffer;
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
  1:Begin { 2 … 256 couleurs }
   For I:=0to(L-1)shr 3do Copy8Bin(X+(I shl 3),Y,TBuf[I],15,0);
   If L and 7>0Then Begin
    Ta:=TBuf[L-1]; Xa:=X+(L-1)shl 3;
    For I:=0to 7do SetPixel(Xa+I,Y,((Ta shr I)and 1)*15);
   End;
  End;
  2:Begin { 4 … 256 couleurs }
   For I:=0to(L-1)shr 2do Begin
    BufPtr[I shl 2]:=(TBuf[I]and 3)shl 2;
    BufPtr[(I shl 2)+1]:=((TBuf[I]shr 2)and 3)shl 2;
    BufPtr[(I shl 2)+2]:=((TBuf[I]shr 4)and 3)shl 2;
    BufPtr[(I shl 2)+3]:=(TBuf[I]shr 6)shl 2;
   End;
   _ClrLnHorImg(X,Y,L,BufPtr);
  End;
  4:Begin { 16 … 256 couleurs }
   For I:=0to(L-1)shr 1do Begin
    BufPtr[I shl 1]:=TBuf[I]shr 4;BufPtr[(I shl 1)+1]:=TBuf[I]and$F;
   End;
   _ClrLnHorImg(X,Y,L,BufPtr);
  End;
  8:_ClrLnHorImg(X,Y,L,Buffer);
 End;
End;

Procedure ClrWn;Assembler;ASM
 CLD
 XOR AX,AX
 MOV BL,Y1
 XOR BH,BH
 SHL BX,1
 MOV DI,CS:[Offset RawTxtY+BX]
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
 MOV BL,X1
 XOR BH,BH
 {$IFOPT G+}
  SHL BX,3
 {$ELSE}
  SHL BX,1
  SHL BX,1
  SHL BX,1
 {$ENDIF}
 PUSH BX
 MOV BL,Y1
 XOR BH,BH
 SHL BX,1
 MOV AX,CS:[Offset RawY+BX]
 PUSH AX
 MOV BL,X2
 XOR BH,BH
 INC BX
 {$IFOPT G+}
  SHL BX,3
 {$ELSE}
  SHL BX,1
  SHL BX,1
  SHL BX,1
 {$ENDIF}
 DEC BX
 PUSH BX
 MOV BL,Y2
 XOR BH,BH
 INC BX
 SHL BX,1
 MOV AX,CS:[Offset RawY+BX]
 DEC AX
 PUSH AX
 MOV AL,Attr
 XOR AH,AH
 {$IFOPT G+}
  SHR AX,4
 {$ELSE}
  MOV CL,4
  SHR AX,CL
 {$ENDIF}
 PUSH AX
 PUSH CS
 CALL Near Ptr PutFillBox
END;

Procedure ClrScr;Assembler;ASM
 XOR AX,AX
 PUSH AX
 PUSH AX
 MOV BX,DataVideo.MIV.NumXPixels
 DEC BX
 PUSH BX
 MOV BX,DataVideo.MIV.NumYPixels
 DEC BX
 PUSH BX
 MOV AL,Attr
 {$IFOPT G+}
  SHR AX,4
 {$ELSE}
  MOV CL,4
  SHR AX,CL
 {$ENDIF}
 PUSH AX
 PUSH CS
 CALL Near Ptr PutFillBox
 CLD
 XOR DI,DI
 MOV ES,DataVideo.MIV.SegBuffer
 MOV BL,DataVideo.MIV.NumYTexts
 XOR BH,BH
 SHL BX,1
 MOV CX,CS:[Offset RawTxtY+BX]
 MOV AH,Attr
 MOV AL,' '
 REP STOSW
END;

Procedure CopT8Bin;
{$IFDEF VESA}
 Var I:Wd;Begin
  For I:=0to 7do ASM
   TEST Value,080h
   JZ   @SkipSetPixel
    { SetPixel(X+I,Y,Fore);}
   MOV  AX,I
   ADD  AX,X
   PUSH AX
   PUSH Y
   PUSH Word Ptr Fore
   PUSH CS
   CALL Near Ptr SetPixel
@SkipSetPixel:
   SHL Value,1
  END;
 End;
{$ELSE}
Assembler;Var Pg:Wd;ASM
 CLD
 MOV BX,Y
 {$IFOPT G+}
  SHL BX,2
 {$ELSE}
  SHL BX,1
  SHL BX,1
 {$ENDIF}
 MOV ES,DataVideo.MIV.AddrPg
 LES DI,ES:[BX]
 MOV DX,ES
 ADD DI,X
 ADC DX,0
 MOV Pg,DX
 PUSH DX
 PUSH CS
 CALL SetBnkPg.Near
 MOV ES,DataVideo.MIV.SegV
 MOV BH,Value
 MOV AX,DI
 ADD AX,7
 JC  @@Long
 CMP BH,0
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
 MOV CX,8
@@3:
 ROL BH,1
 JC  @@4
 INC DI
 LOOP @@3
 JMP @@End
@@4:
 STOSB
 LOOP @@3
 JMP @@End
@@Long:
 MOV AH,AL
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
  CALL Near Ptr SetBnkPg
 POP DX; POP CX; POP ES; POP DI
@@Long3A:
 MOV BL,BH
 ROR BL,CL
 JC  @@Long4
 INC DI
 LOOP @@Long3
 JMP @@End
@@Long4:
 MOV AL,DH
 STOSB
 LOOP @@Long3
@@End:
END;
{$ENDIF}

Procedure BuffTmp;Assembler;ASM
 DB 0,0,0,0, 0,0,0,0
END;

Procedure Copy8Bin;
{$IFDEF VESA}
 Assembler;ASM
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
   MOV CX,8
   MOV BL,Value
   MOV SI,Offset BuffTmp
@1:MOV AL,Fore
   ROL BL,1
   JC  @2
   MOV AL,Back
@2:MOV CS:[SI],AL
   INC SI
   LOOP @1
   PUSH DX
   PUSH DI
   {$IFOPT G+}
    PUSH 8
   {$ELSE}
    MOV AX,8
    PUSH AX
   {$ENDIF}
   PUSH CS
   {$IFOPT G+}
    PUSH Offset BuffTmp
   {$ELSE}
    MOV AX,Offset BuffTmp
    PUSH AX
   {$ENDIF}
   PUSH CS
   CALL Near Ptr WriteBnk
  END;
{$ELSE}
 Assembler;Var Pg:Wd;ASM
  CLD
  MOV BX,Y
  {$IFOPT G+}
   SHL BX,2
  {$ELSE}
   SHL BX,1
   SHL BX,1
  {$ENDIF}
  MOV ES,DataVideo.MIV.AddrPg
  LES DI,ES:[BX]
  MOV DX,ES
  ADD DI,X
  ADC DX,0
  MOV Pg,DX
  PUSH DX
  PUSH CS
  CALL SetBnkPg.Near
  MOV ES,DataVideo.MIV.SegV
  MOV BH,Value
  MOV AX,DI
  ADD AX,7
  JC  @@Long
  CMP BH,0
  JE  @@1
  MOV AL,Fore
  CMP BH,$FF
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
  MOV CX,8
@@3:
  ROL BH,1
  JC  @@4
  MOV AL,DL
  STOSB
  LOOP @@3
  JMP @@End
@@4:
  MOV AL,DH
  STOSB
  LOOP @@3
  JMP @@End
@@Long:
  MOV AH,AL
  MOV DL,Back
  MOV DH,Fore
  MOV CX,8
@@Long3:
  TEST DI,$FFFF
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
  LOOP @@Long3
  JMP @@End
@@Long4:
  MOV AL,DH
  STOSB
  LOOP @@Long3
@@End:
 END;
{$ENDIF}

Procedure FillBox;Var I,J:Byte;Begin
 For J:=Y1 to(Y2)do For I:=X1 to(X2)do SetCube(I,J,Chr,Attr)
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
 LES AX,ES:[BX]
 MOV DX,ES
 ADD AX,X1
 ADC DX,0
  { ReadBnk(DX:AX,X2-X1+1,Buffer) }
 {$IFDEF CallReadBnk}
  PUSH DX
  PUSH AX
 {$ELSE}
  MOV X1,DX
  MOV Y,AX
 {$ENDIF}
 MOV AX,X2
 SUB AX,X1
 INC AX
 {$IFDEF CallReadBnk}
  PUSH AX
  PUSH Word Ptr Buffer[2]
  PUSH Word Ptr Buffer
  PUSH CS
  CALL Near Ptr ReadBnk
 {$ELSE}
  MOV X2,AX
  JMP Near Ptr ReadBnk[3]
 {$ENDIF}
END;

Function GetPixel;Assembler;ASM
 MOV BX,Y
 SHL BX,1
 SHL BX,1
 MOV ES,DataVideo.MIV.AddrPage
 LES DI,ES:[BX]
 MOV DX,ES
 ADD DI,X
 ADC DX,0
 PUSH DX
 PUSH CS
 CALL SetBnkPg.Near
 MOV ES,DataVideo.MIV.SegVideo
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

Procedure DataVesa;Assembler;ASM
 DW 0
 DB 0
END;

Procedure Init;Assembler;
Var
 L:Word;
ASM
  { Compile la taille des plages }
 MOV BX,DataVideo.MIV.AddrPage
 MOV Word Ptr DataVesa,BX
 DEC Word Ptr DataVesa
 MOV CX,15
@VesaShr:
 SHR BX,1
 TEST BX,1
 JNZ @SetVesaShr
 LOOP @VesaShr
 JMP @SkipVesaShr
@SetVesaShr:
 MOV CH,16
 SUB CH,CL
 MOV Byte Ptr DataVesa[2],CH
@SkipVesaShr:
  { Processus normale...}
 XOR AX,AX
 MOV ES,AX
 MOV AX,ES:[$43*4]
 MOV DataVideo.MIV.TxtMtx.Word,AX
 MOV AX,ES:[$43*4+2]
 MOV DataVideo.MIV.TxtMtx.Word[2],AX
 MOV BL,ES:[$485]
 CMP BL,0
 JE  @DefHeightChr
 MOV DataVideo.MIV.HeightChar,BL
@DefHeightChr:
 MOV BL,ES:[484h]
 CMP BL,0
 JE  @DefNmYTxts
 INC BL
 MOV DataVideo.MIV.NumYTexts,BL
@DefNmYTxts:
 MOV BX,ES:[44Ah]
 MOV DataVideo.MIV.NumXTexts,BL
 SHL BX,1
 SHL BX,1
 SHL BX,1
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
 MOV DataVideo.MIV.ScrSize.Word[2],DX
 MOV AL,DataVideo.MIV.NumYTexts
 MUL DataVideo.MIV.NumXTexts
 MOV L,AX
 MOV CX,256+1
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
@L2:MOV CS:[Offset RawY+BX],AX
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
 ADD AX,SI
 ADC DX,0
 MOV ES:[DI],AX
 INC DI
 INC DI
 MOV ES:[DI],DX
 INC DI
 INC DI
 LOOP @L1
{ For J:=0to(GetMaxYPixels)do Begin
   RealRawY^[J]:=L;
   Inc(L,Long(IVid.BytesPerLn))
  End
}
 MOV AL,DataVideo.MIV.NumYTexts
 MUL DataVideo.MIV.NumXTexts
 MOV L,AX
 {$IFOPT G+}
  SHR AX,3
 {$ELSE}
  SHR AX,1
  SHR AX,1
  SHR AX,1
 {$ENDIF}
 MOV BX,AX
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
 MOV CX,L
 CLD
 REP STOSW
END;

{$I MvTxtSVGA.Inc}
{{{$I DFGMVTXT.INC}

Procedure PCopy;Begin End;

{$I PutCharG.Inc}

Procedure PutFillBox;
{$IFDEF VESA}
 Var Addr1:Long;L,J:Wd;Begin
  ASM
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
   LES AX,ES:[BX]
   MOV DX,ES
   ADD AX,X1
   ADC DX,0
   MOV Word Ptr Addr1,AX
   MOV Word Ptr Addr1[2],DX
  END;
  For J:=Y1 to(Y2)do ASM
   { FillBnk(Addr1,L,Kr); }
   PUSH Word Ptr Addr1[2]
   PUSH Word Ptr Addr1
   PUSH L
   PUSH Kr
   PUSH CS
   CALL Near Ptr FillBnk
    { Inc(Addr1,BytesPerLn);}
   MOV AX,DataVideo.MIV.BytesPerLine
   ADD Word Ptr Addr1,AX
   ADC Word Ptr Addr1[2],0
  END;
 End;
{$ELSE}
Assembler;Var Addr1,Addr2:Long;L1,L:Wd;ASM
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
 MOV ES,DataVideo.MIV.AddrPg
 LES AX,ES:[BX]
 MOV DX,ES
 PUSH AX
  ADD AX,X1
  ADC DX,0
  MOV Addr1.Word,AX
  MOV Addr1.Word[2],DX
 POP AX
 MOV DX,ES
 ADD AX,X2
 ADC DX,0
 MOV Addr2.Word,AX
 MOV Addr2.Word[2],DX
 MOV CX,Y1
 MOV ES,DataVideo.MIV.SegV
@@Home:
 PUSH CX
  PUSH Addr1.Word[2]
  PUSH CS
  CALL SetBnkPg.Near
  MOV AL,Addr1.Byte[2]
  CMP AL,Addr2.Byte[2]
  JNE @@NotContinue
  MOV DI,Addr1.Word
  MOV CX,L
  MOV AL,Kr.Byte
  MOV AH,AL
  {$IFDEF __386__}
   DB  ciPushAX,ciPushAX { EAX := AX:AX }
   DW  ciPopEAX
   MOV BX,CX
   AND BX,3
   DB  $C1,$E9,$02          { SHR CX,2 }
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
  SUB CX,Addr1.Word { 0-AX n'est pas du sadomasochisme... }
  MOV L1,CX
  MOV DI,Addr1.Word
  MOV AL,Kr.Byte
  MOV AH,AL
  SHR CX,1
  REP STOSW
  ADC CX,CX
  REP STOSB
  PUSH Addr2.Word[2]
  PUSH CS
  CALL SetBnkPg.Near
  MOV CX,L
  SUB CX,L1
  XOR DI,DI
  MOV AL,Kr.Byte
  MOV AH,AL
  SHR CX,1
  REP STOSW
  ADC CX,CX
  REP STOSB
@@EndPass:
  XOR CX,CX
  MOV AX,DataVideo.MIV.BytesPerLn
  ADD Addr1.Word,AX
  ADC Addr1.Word[2],CX
  ADD Addr2.Word,AX
  ADC Addr2.Word[2],CX
 POP CX
 INC CX
 CMP Y2,CX
 JAE @@Home
END;
{$ENDIF}

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
 For J:=0to(Y2-Y1)do Begin ClrLnHorImg(X1,J+Y1,L,8,TBuf[I]);Inc(I,L)End;
End;

Procedure PutSprite;Var TBuf:TByte Absolute Buffer;J,I,L:Wd;Begin
 I:=0;L:=X2-X1+1;
 For J:=0to(Y2-Y1)do Begin ClrLnHorImg(X1,J+Y1,L,8,TBuf[I]);Inc(I,L)End;
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
 MOV AX,4F06h
 MOV BL,00
 MOV CX,X
 INT 10h
 CMP AL,4Fh
 JNE @End
 MOV DataVideo.MIV.BytesPerLine,BX
  { Fixe les longueurs des lignes... }
 XOR AX,AX
 MOV CX,DataVideo.MIV.NumYPixels { Nombre de ligne }
 MOV ES,DataVideo.MIV.AddrPage
 XOR BX,BX
 MOV DX,DataVideo.MIV.BytesPerLine
@L:
 MOV ES:[BX],AX
 INC BX
 INC BX
 ADD AX,DX
 LOOP @L
@End:
END;

Procedure SetChr;Begin SetCube(X,Y,Chr,GetAttr(X,Y))End;

Procedure SetCube;Assembler;ASM
 XOR BH,BH
 MOV ES,DataVideo.MIV.SegBuffer
 MOV BL,Y
 SHL BX,1
 MOV DI,CS:[Offset RawTxtY+BX]
 MOV BL,X
 ADD DI,BX
 SHL DI,1
 MOV AL,Chr
 MOV AH,Attr
 MOV ES:[DI],AX
 MOV BL,DataVideo.MIV.NumXTexts
 MOV AH,BL
 DEC AH
 MOV AL,X
 CMP AL,AH
 JBE @1
 DIV BL
 ADD Y,AL
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
 {$ENDiF}
 MOV X.Word,AX
 XOR BH,BH
 MOV BL,Y
 SHL BX,1
 MOV BX,CS:[Offset RawY+BX].Word
 MOV Y.Word,BX
 JMP SetGCube.Near[3]
END;

{$I GFXSETCU.INC}

Procedure SetGCube;
{$IFDEF VESA}
 Var
  J,M,Back,Fore:Byte;
  Mtx:^TByte;
  Base:Word;
 Begin
  ASM
   MOV AL,DataVideo.MIV.HeightChar
   DEC AL
   MOV M,AL
   LES DI,DataVideo.MIV.TxtMtx
   MOV Word Ptr Mtx[2],ES
   MOV Word PTr Mtx,DI
  END;
  Base:=Byte(Chr)*(M+1);Back:=Attr shr 4;Fore:=Attr and$F;
  For J:=0to(M)do Begin
   Copy8Bin(X,Y+J,Mtx^[J+Base],Back,Fore);
  End;
 End;
{$ELSE}
Assembler;ASM
 CLD
 PUSH DS
  MOV AX,DataVideo.MIV.BytesPerLn
  SUB AX,8
  MOV @BytesPerLn.Word,AX
  LDS DI,DataVideo.MIV.TxtMtx
  XOR BH,BH
  MOV BL,DataVideo.MIV.HeightChr
  MOV SI,BX
  MOV BL,Chr
  SHL BX,1
  ADD DI,CS:[Offset RawY+BX]
  MOV @PB.Word,DI
  XOR CX,CX
  MOV BX,Y
  SHL BX,1
  SHL BX,1
  MOV ES,DataVideo.MIV.AddrPg
  LES DI,ES:[BX]
  MOV DX,ES
  ADD DI,X
  ADC DX,CX
  MOV @Pg.Word,DX
  MOV ES,DataVideo.MIV.SegV
  PUSH DX
  PUSH CS
  CALL SetBnkPg.Near
  MOV DL,Attr
  MOV DH,DL
  AND DH,$F
  SHR DL,1
  SHR DL,1
  SHR DL,1
  SHR DL,1
  MOV @Back.Word,DX
@L:MOV AX,DI
  ADD AX,7
  JC  @@Long
  MOV BX,@PB.Word
  MOV BH,DS:[BX]
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
@@Long:MOV AH,AL
  MOV DX,@Back.Word
  MOV CX,8
@L3:TEST DI,$FFFF
  JNZ @L3A
{  MOV AX,@Pg.Word
  INC AX
  PUSH AX}
  INC Word Ptr @Pg
  PUSH Word Ptr @Pg

  PUSH CS
  CALL SetBnkPg.Near
  MOV DX,@Back.Word
@L3A:MOV BL,BH
  ROR BL,CL
  JC  @@Long4
  MOV AL,DL
  STOSB
  LOOP @L3
  JMP @@End
@BytesPerLn:DW 0
@PB:DW 0
@Pg:DW 0
@Back:DB 0
@Fore:DB 0
@@Long4:MOV AL,DH
  STOSB
  LOOP @L3
@@End:DEC SI
  INC @PB.Word
  TEST DI,$FFFF
  JNZ @99
  ADD DI,@BytesPerLn.Word
  JMP @99b
@99:
  ADD DI,@BytesPerLn.Word
  JNC @y9
@99b:
  INC Word Ptr @Pg
  PUSH Word Ptr @Pg
  PUSH CS
  CALL SetBnkPg.Near
  MOV DX,@Back.Word
@y9:
  CMP SI,CX
  JNE @L
 POP DS
END;
{$ENDIF}

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
  MOV PB.Word[2],ES
  MOV BL,Chr
  XOR BH,BH
  SHL BX,1
  ADD DI,CS:[Offset RawY+BX]
  MOV Word Ptr PB,DI
 END;
 For I:=0to(M)do Begin CopT8Bin(X,Y+I,PB^,Attr);Inc(Word(PB))End;
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

Procedure SetPg;Begin End;

Procedure FillBnk(aY:Long;L:Wd;Kr:Byte);Assembler;ASM
  {SPg:=Long(aY)shr Mem[CSeg:Ofs(DataVesa)+2];}
 LES AX,aY
 MOV DX,ES
 MOV CL,Byte Ptr DataVesa[2]
 {$IFDEF __386__}
  AND CL,1Fh
  DB 0Fh,0ADh,0C2h { SHRD DX:AX,CL }
 {$ELSE}
  AND CX,001Fh
  JE  @2
@1:
  SHR DX,1
  RCR AX,1
  LOOP @1
@2:
 {$ENDIF}
 PUSH AX
  PUSH AX
  PUSH CS
  CALL Near Ptr SetBnkPg
   { DX:AX:=aY+L-1;}
  LES AX,aY
  MOV DX,ES
  MOV BX,L
  DEC BX
  ADD AX,BX
  ADC DX,0
   {EPg:=Long(DX:AX)shr Mem[CSeg:Ofs(DataVesa)+2];}
  MOV CL,Byte Ptr DataVesa[2]
  {$IFDEF __386__}
   AND CL,1Fh
   DB 0Fh,0ADh,0C2h { SHRD DX:AX,CL }
  {$ELSE}
   AND CX,001Fh
   JE  @2b
@1b:
   SHR DX,1
   RCR AX,1
   LOOP @1b
@2b:
  {$ENDIF}
 POP DX
 MOV DI,Word Ptr aY
 CMP DX,AX
 JNE @Long
 MOV CX,L
 AND DI,Word Ptr DataVesa
 JMP @7
@Long:
 MOV DX,Word Ptr DataVesa
 MOV BX,DI
 AND BX,DX
 MOV CX,DX
 INC CX
 SUB CX,BX
 CLD
 PUSH CX
  MOV ES,DataVideo.MIV.SegVideo
  AND DI,DX
  PUSH AX
  MOV AL,Byte Ptr Kr
  REP STOSB
  PUSH CS
  CALL Near Ptr SetBnkPg
  MOV CX,L
 POP AX
 SUB CX,AX
 XOR DI,DI
@7:
 CLD
 MOV ES,DataVideo.MIV.SegVideo
 MOV AL,Byte Ptr Kr
 REP STOSB
@End:
END;

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
 LES DI,ES:[BX]
 MOV DX,ES
 ADD DI,X
 ADC DX,0
 {$IFDEF VESA}
  PUSH DX
  PUSH DI
  {$IFOPT G+}
   PUSH 1
  {$ELSE}
   MOV AX,1
   PUSH AX
  {$ENDIF}
  PUSH Kr
  PUSH CS
  CALL Near Ptr FillBnk
 {$ELSE}
  PUSH DX
  PUSH CS
  CALL Near Ptr SetBnkPg
  MOV ES,DataVideo.MIV.SegV
  MOV AX,Kr
  STOSB
 {$ENDIF}
@End:
END;

Procedure SetHorizontalScale;Begin End;
Procedure SetVerticalScale;Begin End;

Procedure SetVisualPg;Begin End;

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

Procedure SetBnkPg;Assembler;ASM
 MOV AX,Pg
 CMP AX,0FFFFh
 JE  @GetBnkPg
 CMP AX,Word Ptr @OldBnkPg
 JE @End
 PUSH DS
  PUSH SI
   PUSH DI
    PUSH BX
     MOV DX,AX
     MOV AX,4F05h
     XOR BX,BX
     INT 10h
    POP BX
   POP DI
  POP SI
 POP DS
 JMP @1
@GetBnkPg:
 DB 0B8h
@OldBnkPg:
 DW 0FFFFh
 JMP @End
@1:
 MOV Word Ptr @OldBnkPg,AX
@End:
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
 PUSH DS
  {SPg:=Long(aY)shr Mem[CSeg:Ofs(DataVesa)+2];}
  LES AX,aY
  MOV DX,ES
  MOV CL,Byte Ptr DataVesa[2]
  {$IFDEF __386__}
   AND CL,1Fh
   DB 0Fh,0ADh,0C2h { SHRD DX:AX,CL }
  {$ELSE}
   AND CX,001Fh
   JE  @2
@1:
   SHR DX,1
   RCR AX,1
   LOOP @1
@2:
  {$ENDIF}
  PUSH AX
   PUSH AX
   PUSH CS
   CALL Near Ptr SetBnkPg
    { DX:AX:=aY+L-1;}
   LES AX,aY
   MOV DX,ES
   MOV BX,L
   DEC BX
   ADD AX,BX
   ADC DX,0
    {EPg:=Long(DX:AX)shr Mem[CSeg:Ofs(DataVesa)+2];}
   MOV CL,Byte Ptr DataVesa[2]
   {$IFDEF __386__}
    AND CL,1Fh
    DB 0Fh,0ADh,0C2h { SHRD DX:AX,CL }
   {$ELSE}
    AND CX,001Fh
    JE  @2b
@1b:
    SHR DX,1
    RCR AX,1
    LOOP @1b
@2b:
   {$ENDIF}
  POP DX
  LES DI,x0
  MOV SI,Word Ptr aY
  CMP DX,AX
  JNE @Long
  MOV CX,L
  AND SI,Word Ptr DataVesa
  JMP @7
@Long:
  MOV DX,Word Ptr DataVesa
  MOV BX,SI
  AND BX,DX
  MOV CX,DX
  INC CX
  SUB CX,BX
  CLD
  PUSH CX
   MOV DS,DataVideo.MIV.SegVideo
   AND SI,DX
   REP MOVSB
   PUSH AX
   PUSH CS
   CALL Near Ptr SetBnkPg
   MOV CX,L
  POP AX
  SUB CX,AX
  XOR SI,SI
@7:
  CLD
  MOV DS,DataVideo.MIV.SegVideo
  REP MOVSB
 POP DS
@End:
END;

Procedure WriteBnk;Assembler;ASM
 PUSH DS
  {SPg:=Long(aY)shr Mem[CSeg:Ofs(DataVesa)+2];}
  LES AX,aY
  MOV DX,ES
  MOV CL,Byte Ptr DataVesa[2]
  {$IFDEF __386__}
   AND CL,1Fh
   DB 0Fh,0ADh,0C2h { SHRD DX:AX,CL }
  {$ELSE}
   AND CX,001Fh
   JE  @2
@1:
   SHR DX,1
   RCR AX,1
   LOOP @1
@2:
  {$ENDIF}
  PUSH AX
   PUSH AX
   PUSH CS
   CALL Near Ptr SetBnkPg
    { DX:AX:=aY+L-1;}
   LES AX,aY
   MOV DX,ES
   MOV BX,L
   DEC BX
   ADD AX,BX
   ADC DX,0
    {EPg:=Long(DX:AX)shr Mem[CSeg:Ofs(DataVesa)+2];}
   MOV CL,Byte Ptr DataVesa[2]
   {$IFDEF __386__}
    AND CL,1Fh
    DB 0Fh,0ADh,0C2h { SHRD DX:AX,CL }
   {$ELSE}
    AND CX,001Fh
    JE  @2b
@1b:
    SHR DX,1
    RCR AX,1
    LOOP @1b
@2b:
   {$ENDIF}
  POP DX
  LDS SI,x0
  MOV DI,Word Ptr aY
  CMP DX,AX
  JNE @Long
  MOV CX,L
  AND DI,Word Ptr DataVesa
  JMP @7
@Long:
  MOV DX,Word Ptr DataVesa
  AND DI,DX
  MOV CX,DX
  INC CX
  SUB CX,DI
  CLD
  PUSH CX
   MOV ES,DataVideo.MIV.SegVideo
   REP MOVSB
   PUSH AX
   PUSH CS
   CALL Near Ptr SetBnkPg
   MOV CX,L
  POP AX
  SUB CX,AX
  XOR DI,DI
@7:
  CLD
  MOV ES,DataVideo.MIV.SegVideo
  REP MOVSB
@End:
 POP DS
END;

{$I GrfIcon.Inc}
{$I Done.Inc}