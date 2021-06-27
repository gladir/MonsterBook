{Drv19.Inc}

Procedure RawTxtY;Forward;
Procedure RawY;Forward;
Procedure RealRawY;Forward;

Procedure _Driver19;Assembler;ASM
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
 DW 0{AddrPg:En texte, adresse en m‚moire vid‚o de la page actuel}
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
 DW    0,  40,  80, 120, 160, 200, 240, 280, 320, 360, 400, 440, 480 { 12 }
 DW  520, 560, 600, 640, 680, 720, 760, 800, 840, 880, 920, 960      { 25 }
 DW    0,  40,  80, 120, 160, 200, 240, 280, 320, 360, 400, 440, 480 { 37 }
 DW  520, 560, 600, 640, 680, 720, 760, 800, 840, 880, 920, 960      { 50 }
 DW    0,  40,  80, 120, 160, 200, 240, 280, 320, 360, 400, 440, 480
 DW  520, 560, 600, 640, 680, 720, 760, 800, 840, 880, 920, 960      { 75 }
 DW    0,  40,  80, 120, 160, 200, 240, 280, 320, 360, 400, 440, 480
 DW  520, 560, 600, 640, 680, 720, 760, 800, 840, 880, 920, 960      { 100 }
 DW    0,  40,  80, 120, 160, 200, 240, 280, 320, 360, 400, 440, 480
 DW  520, 560, 600, 640, 680, 720, 760, 800, 840, 880, 920, 960      { 125 }
 DW    0,  40,  80, 120, 160, 200, 240, 280, 320, 360, 400, 440, 480
 DW  520, 560, 600, 640, 680, 720, 760, 800, 840, 880, 920, 960      { 150 }
 DW    0,  40,  80, 120, 160, 200, 240, 280, 320, 360, 400, 440, 480
 DW  520, 560, 600, 640, 680, 720, 760, 800, 840, 880, 920, 960      { 175 }
 DW    0,  40,  80, 120, 160, 200, 240, 280, 320, 360, 400, 440, 480
 DW  520, 560, 600, 640, 680, 720, 760, 800, 840, 880, 920, 960      { 200 }
 DW    0,  40,  80, 120, 160, 200, 240, 280, 320, 360, 400, 440, 480
 DW  520, 560, 600, 640, 680, 720, 760, 800, 840, 880, 920, 960      { 225 }
 DW    0,  40,  80, 120, 160, 200, 240, 280, 320, 360, 400, 440, 480
 DW  520, 560, 600, 640, 680, 720, 760, 800, 840, 880, 920, 960      { 250 }
 DW    0,  40,  80, 120, 160, 200                                    { 256 }
 DW Offset PhysVideo
END;

Procedure RealRawY;Assembler;ASM
 DW     0,  320,  640,  960, 1280, 1600, 1920, 2240, 2560, 2880, 3200, 3520
 DW  3840, 4160, 4480, 4800, 5120, 5440, 5760, 6080, 6400, 6720, 7040, 7360
 DW  7680, 8000, 8320, 8640, 8960, 9280, 9600, 9920,10240,10560,10880,11200
 DW 11520,11840,12160,12480,12800,13120,13440,13760,14080,14400,14720,15040
 DW 15360,15680,16000,16320,16640,16960,17280,17600,17920,18240,18560,18880
 DW 19200,19520,19840,20160,20480,20800,21120,21440,21760,22080,22400,22720
 DW 23040,23360,23680,24000,24320,24640,24960,25280,25600,25920,26240,26560
 DW 26880,27200,27520,27840,28160,28480,28800,29120,29440,29760,30080,30400
 DW 30720,31040,31360,31680,32000,32320,32640,32960,33280,33600,33920,34240
 DW 34560,34880,35200,35520,35840,36160,36480,36800,37120,37440,37760,38080
 DW 38400,38720,39040,39360,39680,40000,40320,40640,40960,41280,41600,41920
 DW 42240,42560,42880,43200,43520,43840,44160,44480,44800,45120,45440,45760
 DW 46080,46400,46720,47040,47360,47680,48000,48320,48640,48960,49280,49600
 DW 49920,50240,50560,50880,51200,51520,51840,52160,52480,52800,53120,53440
 DW 53760,54080,54400,54720,55040,55360,55680,56000,56320,56640,56960,57280
 DW 57600,57920,58240,58560,58880,59200,59520,59840,60160,60480,60800,61120
 DW 61440,61760,62080,62400,62720,63040,63360,63680
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
 ADD DX,7
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
 CLD
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
 {$IFOPT G+}SHR AX,4{$ELSE}MOV CL,4;SHR AX,CL{$ENDIF}
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
 CLD
 MOV BX,Y
 MOV AX,DataVideo.MIV.NumYPixels
 CMP BX,AX
 JAE @End
 MOV AX,Kr
 SHL BX,1
 MOV DI,Word Ptr RealRawY[BX]
 ADD DI,X
 {$IFDEF DPMI}
  MOV ES,SegA000
 {$ELSE}
  MOV ES,DataVideo.MIV.SegVideo
 {$ENDIF}
 MOV CX,L
 MOV AH,AL
 SHR CX,1
 REP STOSW
 ADC CX,CX
 REP STOSB
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
 If BitsPerPixel<=1Then Begin
  If BitsPerPixel=0Then Begin
   MY:=TBuf[0];
   ASM INC Word Ptr Buffer;END;
   MX:=TBuf[0];
   ASM INC Word Ptr Buffer;END;
  End
   Else
  Begin
   MX:=15;MY:=0;
  End;
  For I:=0to(L-1)shr 3do Copy8Bin(X+(I shl 3),Y,TBuf[I],MX,MY);
  If L and 7>0Then Begin
   Ta:=TBuf[L-1]; Xa:=X+(L-1)shl 3;
   For I:=0to 7do Begin
    If ((Ta shr I)and 1)=1Then SetPixel(Xa+I,Y,MX)
                          Else SetPixel(Xa+I,Y,MY)
   End;
  End;
 End
  Else
 ASM
  CLD
  PUSH DS
   MOV BX,Y
   SHL BX,1
   MOV DI,Word Ptr RealRawY[BX]
   ADD DI,X
   {$IFDEF DPMI}
    MOV ES,SegA000
   {$ELSE}
    MOV ES,DataVideo.MIV.SegVideo
   {$ENDIF}
   LDS SI,Buffer
   MOV CX,L
   CMP BitsPerPixel,4
   JE  @4
   SHR CX,1
   REP MOVSW
   ADC CX,CX
   REP MOVSB
   JMP @End
@4:SHR CX,1
@Binaire: { 2 pixels par octets... }
   PUSHF
@LoopB:
    LODSB
    MOV AH,AL
    {$IFOPT G+}
     SHR AL,4
    {$ELSE}
     SHR AL,1
     SHR AL,1
     SHR AL,1
     SHR AL,1
    {$ENDIF}
    AND AH,0Fh
    STOSW
    LOOP @LoopB
   POPF
   JNC @End
   LODSB
   {$IFOPT G+}
    SHR AL,4
   {$ELSE}
    SHR AL,1
    SHR AL,1
    SHR AL,1
    SHR AL,1
   {$ENDIF}
   STOSB
@End:
  POP DS
 END;
End;

Procedure ClrWn;Assembler;{$IFDEF FAST}Var OldReg4:Byte;BytesPerLn,_Y2:Wd;{$ENDIF}ASM
 {$IFDEF FAST}
  CLD
   {D‚finit les registres}
  MOV DX,3C4h
  MOV AL,4
  OUT DX,AL
  INC DX
  IN  AL,DX
  MOV OldReg4,AL
  AND AL,0F7h
  OR  AL,4h
  OUT DX,AL
   {Affiche la boŒte}
  MOV AX,DataVideo.MIV.BytesPerLn
  {$IFOPT G+}
   SHR AX,2
  {$ELSE}
   SHR AX,1
   SHR AX,1
  {$ENDIF}
  MOV BytesPerLn,AX
  MOV AL,X2
  SUB AL,X1
  XOR AH,AH
  INC AX
  MOV SI,AX
  MOV BL,Y1
  XOR BH,BH
  SHL BX,1
  MOV BX,Word Ptr RawY[BX]
  SHL BX,1
  MOV BX,Word Ptr RealRawY[BX]
  {$IFOPT G+}
   SHR BX,2
  {$ELSE}
   SHR BX,1
   SHR BX,1
  {$ENDIF}
  MOV DL,X1
  XOR DH,DH
  SHL DX,1
  ADD BX,DX
  MOV DL,Y2
  SUB DL,Y1
  XOR DH,DH
  INC DX
  {$IFOPT G+}
   SHL DX,3
  {$ELSE}
   SHL DX,1
   SHL DX,1
   SHL DX,1
  {$ENDIF}
  MOV AL,Attr
  {$IFOPT G+}
   SHR AL,4
  {$ELSE}
   SHR AL,1
   SHR AL,1
   SHR AL,1
   SHR AL,1
  {$ENDIF}
  MOV AH,AL
  {$IFDEF DPMI}
   MOV ES,SegA000
  {$ELSE}
   MOV ES,DataVideo.MIV.SegV
  {$ENDIF}
 @@Home:
  MOV DI,BX
  MOV CX,SI
  REP STOSW
  ADD BX,BytesPerLn
  DEC DX
  OR DX,DX
  JNE @@Home
   {Registre 4}
  MOV DX,3C4h
  MOV AL,4
  MOV AH,OldReg4
  OUT DX,AX
 {$ELSE}
  MOV BL,X1
  XOR BH,BH
  SHL BX,1
  PUSH Word Ptr RawY[BX]
  MOV BL,Y1
  XOR BH,BH
  SHL BX,1
  PUSH Word Ptr RawY[BX]
  MOV BL,X2
  XOR BH,BH
  INC BX
  SHL BX,1
  MOV AX,Word Ptr RawY[BX]
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
  {$IFOPT G+}
   SHR AX,4
  {$ELSE}
   MOV CL,4
   SHR AX,CL
  {$ENDIF}
  PUSH AX
  PUSH CS
  CALL Near Ptr PutFillBox
 {$ENDIF}
 CLD
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

Procedure ClrScr;Assembler;ASM
 CLD
 MOV AL,Attr
 MOV CL,4
 SHR AL,CL
 MOV AH,AL
 MOV CX,32000
 XOR DI,DI
 MOV ES,DataVideo.MIV.SegVideo
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

Procedure CopT8Bin;Assembler;ASM
 CLD
 MOV CX,8
 MOV AX,DataVideo.MIV.NumYPixels
 MOV BX,Y
 CMP BX,AX
 JAE @@End
 SHL BX,1
 MOV DI,Word Ptr RealRawY[BX]
 ADD DI,X
 MOV ES,DataVideo.MIV.SegVideo
 MOV BH,Value
 OR  BH,BH
 JZ  @@End
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
 ROL BH,1
 JC  @@4
 INC DI
 LOOP @@2
 JMP @@End
@@4:
 STOSB
 LOOP @@2
@@End:
END;

Procedure Copy8Bin;Assembler;ASM
 CLD
 MOV CX,8
 MOV AX,DataVideo.MIV.NumYPixels
 MOV BX,Y
 CMP BX,AX
 JAE @@End
 SHL BX,1
 MOV DI,Word Ptr RealRawY[BX]
 ADD DI,X
 MOV ES,DataVideo.MIV.SegVideo
 MOV BH,Value
 OR  BH,BH { Vaut 0?}
 JZ  @@1
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
@@End:
END;

Procedure FillBox;Var I,J:Byte;Begin
 For J:=Y1 to(Y2)do For I:=X1 to(X2)do SetCube(I,J,Chr,Attr)
End;

{$I GFXGETCH.INC}

Procedure GetLnHorImg;Assembler;ASM
 CLD
 PUSH DS
  MOV BX,Y
  MOV AX,DataVideo.MIV.NumYPixels
  CMP BX,AX
  JAE @End
  SHL BX,1
  MOV SI,Word Ptr RealRawY[BX]
  ADD SI,X1
  MOV DS,DataVideo.MIV.SegVideo
  LES DI,Buffer
  MOV CX,ES
  OR  CX,DI
  JZ  @End
  MOV CX,X2
  SUB CX,X1
  INC CX
  SHR CX,1
  REP MOVSW
  ADC CX,CX
  REP MOVSB
@End:
 POP DS
END;

Function GetPixel;Assembler;ASM
 MOV ES,DataVideo.MIV.SegVideo
 MOV BX,Y
 SHL BX,1
 MOV DI,Word Ptr RealRawY[BX]
 ADD DI,X
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

Procedure GetSmlImg;Assembler;ASM
 PUSH DS
  LES DI,Buffer
  MOV CX,ES
  OR  CX,DI
  JZ  @End
  MOV AX,X2
  SUB AX,X1
  INC AX
  MOV BX,Y1
  SHL BX,1
  MOV BX,Word Ptr RealRawY[BX]
  ADD BX,X1
  MOV DX,Y1
  CLD
  MOV DS,DataVideo.MIV.SegVideo
@@Home:
  MOV SI,BX
  MOV CX,AX
  PUSH AX
   SHR CX,1
   REP MOVSW
   ADC CX,CX
   REP MOVSB
  POP AX
  ADD BX,DataVideo.MIV.BytesPerLine
  INC DX
  CMP Y2,DX
  JAE @@Home
@End:
 POP DS
END;

Procedure Init;Assembler;ASM
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

Procedure MoveText;Var J,L,YL1,YL2,X1a,X3a,Lx:Wd;Attr:Byte;Begin
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
   CMP DL,0
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
 ASM SHL L,1;END;
 X1a:=X1 shl 3;X3a:=X3 shl 3;Lx:=L shl 2;
 If(Y3<Y1)Then For J:=Y2-Y1+1downto 0do Begin
  YL1:=Y2+(Y1-Y3)-J;YL2:=Y2-J;
  ASM
   XOR BX,BX
   PUSH DS
   MOV ES,DataVideo.MIV.SegVideo
   PUSH ES
   POP DS
   CLD
@@Restart:
   MOV SI,YL1
   {$IFOPT G+}
    SHL SI,3
   {$ELSE}
    SHL SI,1
    SHL SI,1
    SHL SI,1
   {$ENDIF}
   ADD SI,BX
   SHL SI,1
   MOV SI,Word Ptr RealRawY[SI]
   ADD SI,X1a
   MOV DI,YL2
   {$IFOPT G+}
    SHL DI,3
   {$ELSE}
    SHL DI,1
    SHL DI,1
    SHL DI,1
   {$ENDIF}
   ADD DI,BX
   SHL DI,1
   MOV DI,Word Ptr RealRawY[DI]
   ADD DI,X3a
   MOV CX,Lx
   SHR CX,1
   REP MOVSW
   ADC CX,CX
   REP MOVSB
   INC BX
   TEST BL,DataVideo.MIV.HeightChar
   JZ  @@Restart
   POP DS
  END;
 End
  Else
 For J:=Y2-Y1 downto 0do Begin
  YL1:=(J+Y1)shl 3;YL2:=(J+Y3)shl 3;
  ASM
   XOR BX,BX
   PUSH DS
    {$IFDEF DPMI}
     MOV ES,SegA000
    {$ELSE}
     MOV ES,DataVideo.MIV.SegVideo
    {$ENDIF}
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
    MOV CX,Lx
    SHR CX,1
    REP MOVSW
    ADC CX,CX
    REP MOVSB
    INC BX
    TEST BL,DataVideo.MIV.HeightChar
    JZ  @@Restart
   POP DS
  END;
 End;
End;

Procedure PCopy;Var A,B:Wd;OldReg4:Byte;Begin
 ASM
  {D‚finit les registres}
  MOV DX,3C4h
  MOV AL,4
  OUT DX,AL
  INC DX
  IN  AL,DX
  MOV OldReg4,AL
  AND AL,0F7h
  OR  AL,4h
  OUT DX,AL
  AND S,3
  AND T,3
 END;
 A:=S*16000;B:=T*16000;
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
   MOV DL,0CEh
   MOV AX,4+(0 shl 8)
   OUT DX,AX
    { Transfert le contenu m‚moire}
   MOV SI,A
   MOV DI,B
   {$IFDEF __386__}
    MOV CX,16000 shr 2
    DB ciREP;DW ciMOVSD
   {$ELSE}
    MOV CX,16000 shr 1
    REP MOVSW
   {$ENDIF}
    { Fixe la plage 1 }
   MOV DL,0C4h
   MOV AX,2+(2 shl 8)
   OUT DX,AX
   MOV DL,0CEh
   MOV AX,4+(1 shl 8)
   OUT DX,AX
    { Transfert le contenu m‚moire}
   MOV SI,A
   MOV DI,B
   {$IFDEF __386__}
    MOV CX,16000 shr 2
    DB ciREP;DW ciMOVSD
   {$ELSE}
    MOV CX,16000 shr 1
    REP MOVSW
   {$ENDIF}
    { Fixe la plage 2 }
   MOV DL,0C4h
   MOV AX,2+(4 shl 8)
   OUT DX,AX
   MOV DL,0CEh
   MOV AX,4+(2 shl 8)
   OUT DX,AX
    { Transfert le contenu m‚moire}
   MOV SI,A
   MOV DI,B
   {$IFDEF __386__}
    MOV CX,16000 shr 2
    DB ciREP;DW ciMOVSD
   {$ELSE}
    MOV CX,16000 shr 1
    REP MOVSW
   {$ENDIF}
    { Fixe la plage 3 }
   MOV DL,0C4h
   MOV AX,2+(8 shl 8)
   OUT DX,AX
   MOV DL,0CEh
   MOV AX,4+(3 shl 8)
   OUT DX,AX
    { Transfert le contenu m‚moire}
   MOV SI,A
   MOV DI,B
   {$IFDEF __386__}
    MOV CX,16000 shr 2
    DB ciREP;DW ciMOVSD
   {$ELSE}
    MOV CX,16000 shr 1
    REP MOVSW
   {$ENDIF}
    { R‚tablie les plages comme avant }
   MOV DL,0C4h
   MOV AX,2+(15 shl 8)
   OUT DX,AX
   MOV DL,0CEh
   MOV AX,4+(0 shl 8)
   OUT DX,AX
   {Registre 4}
   MOV DL,0C4h
   MOV AL,4
   MOV AH,OldReg4
   OUT DX,AX
  POP DS
 END;
End;

{$I PutCharG.Inc}

Procedure PutFillBox;Assembler;ASM
 MOV SI,X2
 SUB SI,X1
 INC SI
 MOV BX,Y1
 MOV AX,DataVideo.MIV.NumYPixels
 CMP BX,AX
 JAE @@End
 CMP Y2,AX
 JNAE @1
 DEC AX
 MOV Y2,AX
@1:
 SHL BX,1
 MOV BX,Word Ptr RealRawY[BX]
 ADD BX,X1
 MOV DX,Y1
 CLD
 MOV AL,Byte Ptr Kr
 MOV AH,AL
 {$IFDEF DPMI}
  MOV ES,SegA000
 {$ELSE}
  MOV ES,DataVideo.MIV.SegVideo
 {$ENDIF}
@@Home:
 MOV DI,BX
 MOV CX,SI
 SHR CX,1
 REP STOSW
 ADC CX,CX
 REP STOSB
 ADD BX,DataVideo.MIV.BytesPerLine
 INC DX
 CMP Y2,DX
 JAE @@Home
@@End:
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

{$I PutLnHor.Inc}
{$I PutRect.Inc}
{$I PutRndRe.Inc}

Procedure PutSmlImg;Assembler;ASM
 PUSH DS
  LDS SI,Buffer
  MOV AX,X2
  SUB AX,X1
  INC AX
  MOV BX,Y1
  SHL BX,1
  MOV BX,Word Ptr RealRawY[BX]
  ADD BX,X1
  MOV DX,Y1
  CLD
  {$IFDEF DPMI}
   MOV ES,SegA000
  {$ELSE}
   MOV ES,DataVideo.MIV.SegVideo
  {$ENDIF}
@@Home:
  MOV DI,BX
  MOV CX,AX
  PUSH AX
   {$IFDEF __386__}
    PUSH BX
     MOV BX,CX
     AND BX,3
     {$IFOPT G+}
      SHR CX,2
     {$ELSE}
      DB 0C1h,0E9h,02h { SHR CX,2 }
     {$ENDIF}
     DB  ciREP; DW ciMOVSD
     XCHG CX,BX
     REP MOVSB
    POP BX
   {$ELSE}
    SHR CX,1
    REP MOVSW
    ADC CX,CX
    REP MOVSB
   {$ENDIF}
  POP AX
  ADD BX,DataVideo.MIV.BytesPerLine
  INC DX
  CMP Y2,DX
  JAE @@Home
 POP DS
END;

Procedure PutSprite;Assembler;ASM
 PUSH DS
  LDS SI,Buffer
  MOV AX,X2
  SUB AX,X1
  INC AX
  MOV BX,Y1
  SHL BX,1
  MOV BX,Word Ptr RealRawY[BX]
  ADD BX,X1
  MOV DX,Y1
  CLD
  {$IFDEF DPMI}
   MOV ES,SegA000
  {$ELSE}
   MOV ES,DataVideo.MIV.SegVideo
  {$ENDIF}
@@Home:
  MOV DI,BX
  MOV CX,AX
  PUSH AX
@1:LODSB
   OR AL,AL
   JE @2
   STOSB
   LOOP @1
   JMP @3
@2:INC DI
   LOOP @1
@3:
  POP AX
  ADD BX,DataVideo.MIV.BytesPerLine
  INC DX
  CMP Y2,DX
  JAE @@Home
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
 MOV DX,3DAh
 IN  AL,DX                  { active le mode index de l'ATC }
 MOV DL,0C0h
 MOV AL,11h or 32;          { s‚lectionne le registre 11h }
 OUT DX,AL
 MOV AL,Kr                  { Envoie la couleur }
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
  MOV CX,200 { Nombre de ligne }
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

Procedure SetChrWidth;Begin End;

Procedure SetCube;Assembler;ASM
 XOR BH,BH
 MOV ES,DataVideo.MIV.SegBuffer
 MOV BL,Y
 SHL BX,1
 MOV DI,Word Ptr RawTxtY[BX]
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
 {$ENDIF}
 MOV Word Ptr X,AX
 XOR BH,BH
 MOV BL,Y
 SHL BX,1
 MOV BX,Word Ptr RawY[BX]
 MOV Word Ptr Y,BX
 JMP SetGCube.Near[3]
END;

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
 MOV ES:[0460h],AX
END;

Procedure SetCurPos;Assembler;ASM
 XOR BX,BX
 MOV ES,BX
 MOV AH,Y
 MOV BL,ES:[0462h]
 AND BL,7
 SHL BX,1
 MOV AL,X
 MOV ES:[0450h+BX],AX
END;

Procedure SetGCube;
{$IFDEF __TINY__}
 Var I,M:Byte;PB:^Byte;Begin
  ASM
   MOV AL,DataVideo.MIV.HeightChr
   DEC AL
   MOV M,AL
  END;
  If(Chr in[#0,' ',#255])or(Attr and$F=Attr shr 4)Then
   PutFillBox(X,Y,X+7,Y+M,Attr shr 4)
   Else
  Begin
   ASM
    LES DI,DataVideo.MIV.TxtMtx
    MOV Word Ptr PB[2],ES
    MOV BL,Chr
    XOR BH,BH
    SHL BX,1
    ADD DI,Word Ptr RawY[BX]
    MOV Word Ptr PB,DI
   END;
   For I:=0to(M)do Begin Copy8Bin(X,Y+I,PB^,Attr shr 4,Attr and 15);Inc(Word(PB))End;
  End;
 End;
{$ELSE}
 Assembler;ASM
  CLD
  PUSH DS
   LDS DI,DataVideo.MIV.TxtMtx
   XOR BH,BH
   MOV BL,DataVideo.MIV.HeightChar
   MOV SI,BX
   MOV BL,Chr
   SHL BX,1
   ADD DI,Word Ptr RawY[BX]
   MOV BX,DI
   MOV DI,Y
   CMP DI,DataVideo.MIV.NumYPixels
   JAE @End
   SHL DI,1
   MOV DI,Word Ptr RealRawY[DI]
   ADD DI,X
   {$IFDEF DPMI}
    MOV ES,SegA000
   {$ELSE}
    MOV ES,DataVideo.MIV.SegVideo
   {$ENDIF}
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
@L:MOV CH,DS:[BX]
   ROL CH,1
   MOV AX,DX
   JNC @x1
   MOV AL,DH
@x1:ROL CH,1
   JC  @x2
   MOV AH,DL
@x2:STOSW
   ROL CH,1
   MOV AX,DX
   JNC @x3
   MOV AL,DH
@x3:ROL CH,1
   JC  @x4
   MOV AH,DL
@x4:STOSW
   ROL CH,1
   MOV AX,DX
   JNC @x5
   MOV AL,DH
@x5:ROL CH,1
   JC  @x6
   MOV AH,DL
@x6:STOSW
   ROL CH,1
   MOV AX,DX
   JNC @x7
   MOV AL,DH
@x7:ROL CH,1
   JC  @x8
   MOV AH,DL
@x8:STOSW
   DEC SI
   INC BX
   ADD DI,312
   OR  SI,SI
   JNE @L
@End:
  POP DS
 END;
{$ENDIF}

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
 For I:=0to(M)do Begin
  CopT8Bin(X,Y+I,PB^,Attr);
  Inc(Word(PB))
 End;
End;

Procedure SetMatrix;Begin End;
Procedure SetModeMtx;Begin End;
Procedure SetModeScr;Begin End;

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

Procedure SetPg;Begin End;

Procedure SetPixel;Assembler;ASM
 TEST X,8000h
 JNZ @End
 MOV ES,DataVideo.MIV.SegVideo
 MOV DI,Y
 SHL DI,1
 MOV DI,Word Ptr RealRawY[DI]
 ADD DI,X
 MOV AL,Byte Ptr Kr
 STOSB
@End:
END;

Procedure HoriData;Assembler;ASM DW 0;END;
Procedure VertData;Assembler;ASM DW 0;END;

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

Procedure PgPos;Assembler;ASM
 DW 0
 DW 16000
 DW 32000
 DW 48000
END;

Procedure SetVisualPg;Assembler;ASM
 MOV BL,Pg
 AND BX,3
 MOV DataVideo.MIV.ShowPage,BL
 SHL BX,1
 MOV BX,Word Ptr PgPos[BX]
 MOV DX,3D4h
 MOV AL,12
 OUT DX,AL
 INC DX
 MOV AL,BH
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
 SHL Y,1
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

Procedure Plane0;Assembler;ASM DB 0,3,2,1;END;
Procedure Plane1;Assembler;ASM DB 1,0,3,2;END;
Procedure Plane2;Assembler;ASM DB 2,1,0,3;END;
Procedure Plane3;Assembler;ASM DB 3,2,1,0;END;

Procedure ReadBnk;Assembler;Var Start,StartPlane:Wd;Len:Int;OldReg4:Byte;ASM
 PUSH DS
  {D‚finit les registres}
  MOV DX,3C4h
  MOV AL,4
  OUT DX,AL
  INC DX
  IN  AL,DX
  MOV OldReg4,AL
  AND AL,0F7h
  OR  AL,4h
  OUT DX,AL
  {Fin des pr‚d‚finition registres}
  MOV AX,L
  {$IFOPT G+}SHR AX,2{$ELSE}SHR AX,1;SHR AX,1{$ENDIF}
  MOV Len,AX
  DEC L
  LES AX,aY
  MOV DX,ES
  MOV BX,AX
  AND BX,3
  MOV StartPlane,BX
  {$IFDEF __386__}
   DB 0Fh,0ACh,0C2h,02h {SHRD DX,AX,2}
  {$ELSE}
   SHR DX,1;RCR AX,1;SHR DX,1;RCR AX,1
  {$ENDIF}
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
   {Restaure les plages}
  {...?...}
   {Registre 4}
  MOV DX,3C4h
  MOV AL,4
  MOV AH,OldReg4
  OUT DX,AX
 POP DS
END;

Procedure WriteBnk;Assembler;Var Start,StartPlane:Wd;Len:Int;OldReg4:Byte;ASM
 PUSH DS
  {D‚finit les registres}
  MOV DX,3C4h
  MOV AL,4
  OUT DX,AL
  INC DX
  IN  AL,DX
  MOV OldReg4,AL
  AND AL,0F7h
  OR  AL,4h
  OUT DX,AL
  {Fin des pr‚d‚finition registres}
  MOV AX,L
  {$IFOPT G+}SHR AX,2{$ELSE}SHR AX,1;SHR AX,1{$ENDIF}
  MOV Len,AX
  DEC L
  LES AX,aY
  MOV DX,ES
  MOV BX,AX
  AND BX,3
  MOV StartPlane,BX
  {$IFDEF __386__}
   DB 0Fh,0ACh,0C2h,02h {SHRD DX,AX,2}
  {$ELSE}
   SHR DX,1
   RCR AX,1
   SHR DX,1
   RCR AX,1
  {$ENDIF}
  SUB AX,BX
  MOV Start,AX
  MOV ES,DataVideo.MIV.SegVideo
  CLD
@Restart:
   { Fixe la plage 0 }
  MOV DX,03C4h
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
   { Restaure les plages }
  MOV DX,03C4h
  MOV AX,2+(15 shl 8)
  OUT DX,AX
   {Registre 4}
  MOV DX,3C4h
  MOV AL,4
  MOV AH,OldReg4
  OUT DX,AX
 POP DS
END;

{$I GrfIcon.Inc}

{$I Done.Inc}