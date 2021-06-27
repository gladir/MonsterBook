{DrvTxt.Inc}

{$IFNDEF DPMI}
Procedure RawTxtY;Forward;

Procedure _DriverTxt;Assembler;ASM
 JMP Init.Near
 JMP BarChrHorTxt.Near
 JMP BarChrVerTxt.Near
 JMP BarSpcHorTxt.Near
 JMP BarSpcVerTxt.Near
 JMP BarTxtHorTxt.Near
 RETF 8{Circle(X,Y,Rayon:Int;Color:Wd)}
 JMP CloseCurTxt.Near
 RETF 8 {ClrLnHor(X,Y,L,Kr:Wd)}
 RETF 12{ClrLnHorImg(X,Y,L:Wd;BitsPerPixel:Byte;Var Buffer)}
 JMP ClrWnTxt.Near
 JMP ClrScrTxt.Near
 RETF 8 {CopT8Bin(X,Y:Wd;Value,Fore:Byte)}
 RETF 10{Copy8Bin(X,Y:Wd;Value,Back,Fore:Byte)}
 JMP FillBoxTxt.Near
 JMP GetAttr.Near
 JMP GetChr.Near
 JMP GetCube.Near
 RETF 10{GetLnHorImg(X1,Y,X2:Int;Var Buffer)}
 JMP GetPixelTxt.Near
 JMP GetSizeSmlImgTxt.Near
 JMP GetSmlImgTxt.Near { Get4Char... }
 JMP MoveTextTxt.Near
 JMP PCopyTxt.Near
 RETF 10{PCopy2Img(Page:Byte;X1,Y1,X2,Y2:Word)}
 JMP PutCharGAttr.Near
 RETF 10{PutFillBox(X1,Y1,X2,Y2,Kr:Wd)}
 RETF 8{PutFillCircle(X,Y,Rayon:Int;Kr:Wd)}
 RETF 12{PutFillRoundRect(x1,y1,x2,y2,b,Kr:Int)}
 RETF 10 {PutLn(X1,Y1,X2,Y2,Kr:Wd)}
 RETF 8 {PutLnHor(X1,Y,X2,Color:Wd)}
 RETF 10{PutRect(X1,Y1,X2,Y2,Kr:Int)}
 RETF 14{PutRoundRect(x1,y1,x2,y2,LineWidth,b,Kr:Int)}
 JMP PutSmlImgTxt.Near { PutSpecialPtrMouse... }
 RETF 12{PutSprite(X1,Y1,X2,Y2:Wd;Var Buffer)}
 JMP PutTxtXYTxt.Near
 JMP PutTxtXYUnKrTxt.Near
 JMP SetAttrTxt.Near
 JMP SetBackgroundColorTxt.Near
 JMP SetBlinkTxt.Near
 JMP SetBorderColorTxt.Near
 JMP SetBytesPerLnTxt.Near
 JMP SetChrTxt.Near
 JMP SetChrWidthTxt.Near
 JMP SetCubeTxt.Near
 JMP SetCurTxt.Near
 JMP SetCurPosTxt.Near
 JMP SetDblMtx.Near
 JMP SetChrTxt.Near  {SetExtChr}
 JMP SetCubeTxt.Near {SetExtCube}
 RETF 8 {SetGCube(X,Y:Wd;Chr:Char;Attr:Byte)}
 RETF 8 {SetGCubeT(X,Y:Wd;Chr:Char;Attr:Byte)}
 JMP SetHorizontalScaleTxt.Near
 JMP SetMatrixTxt.Near
 JMP SetModeMtxTxt.Near
 JMP SetModeScrTxt.Near
 JMP SetPalBlkTxt.Near
 JMP SetPaletteRGBTxt.Near
 JMP SetPalRGBTxt.Near
 JMP SetPgTxt.Near
 RETF 6 {SetPixel(X,Y,Kr:Wd)}
 JMP SetUnderlineTxt.Near
 JMP SetVerticalScaleTxt.Near
 JMP SetVisualPgTxt.Near
 JMP SetWriteModeTxt.Near
 JMP SplitScreenTxt.Near
 RETF 2 {SetBnkPg(Pg:Byte)}
 RETF 10 {ReadBnk(P:Long;Size:Wd;Var x0)}
 RETF 10 {WriteBnk(P:Long;Size:Wd;Var x0)}
 RETF 8{FillBnk(aY:Long;L,Kr:Wd)}
 RETF {Done}
 NOP
 NOP
  {Gestion des Icons/Luxe}
 JMP SetLuxe.Near
 JMP IsLuxe.Near
 JMP CloseIconTxt.Near
 JMP DownIconTxt.Near
 JMP LeftIconTxt.Near
 JMP RightIconTxt.Near
 JMP SelIconTxt.Near
 JMP UnSelIconTxt.Near
 JMP UpIconTxt.Near
 JMP DownIconTxt.Near { Zoom }
 JMP DossierDocumentIconTxt.Near
 JMP DossierProgramIconTxt.Near
  {}
 DW Offset RawTxtY
 DW 0 {RawY}
 DW 0 {RealRawY}
END;

{$I PhysDef.Inc}

{$IFNDEF DPMI}
 Procedure DataVideo;Assembler;ASM
  DW 0{Mode:Mode vid‚o actuel (vm???)}
  DB 0{IbmLogic:Mode dans la logique IBM (pas hors cas texte … la SVGA...)}
  DB 0{BiosSupport:Mode support‚ par le Bios (Par exemple, la GS en 16 couleurs le Bios ne le connaŒt pas)}
  DB 0{Colr:Mode couleur? Sinon monochrome for‡‚ment...}
  DB 0{Graf:Mode graphique? Sinon texte}
  DB 0{Direct:M‚thode directe? Sinon Bios ou Dos}
  DB Ya{Blink:Clignotement}
  DB 0{Snow:Neige lors de l'envoie de donn‚e dans le tampon vid‚o?}
  DW $B800{SegV:Segment vid‚o (A000h,B000h,B800h,...)}
  DB 0{HeightChr:Hauteur de la police de caractŠre actuel}
  DW 640{NmXPixels:Nombre de pixels horizontal qu'affiche l'‚cran}
  DW 0{NmYPixels:Nombre de pixels vertical qu'affiche l'‚cran}
  DB 80,25{NmXTxts,NmYTxts:Nombre de caractŠre texte horizontal/vertical qu'affiche l'‚cran}
  DB 0{NmVidPgs:Nombre de page vid‚o que supporte le mode actuel}
  DD 16{NmColrs:Nombre de couleurs affich‚}
  DB 0{BitsPerPixel:Nombre de Bit(s) utilis‚ pour l'affichage d'un pixel}
  DW 160{BytesPerLn:Nombre d'octet par ligne affich‚ (trŠs relatif en VGA...)}
  DB 0{Pg:Num‚ro de la page vid‚o de travail}
  DW 0{AddrPg:En texte, adresse en m‚moire vid‚o de la page actuel}
  DB 0{ShowPg:Num‚ro de la page vid‚o actuellement affich‚}
  DD 0{TxtMtx:Pointeur sur la police de caractŠre courante}
  DD 0{ScrSize:Taille de l'‚cran}
  DW 0{SizeBnk:Taille d'un page de la banque (0=64Ko)}
  DW 0{SegBuf:Segment du tampon d'acc‚l‚ration}
  DB 0{IsDblMtx:Y a-t-il une police de 512 caractŠres?}
  DB 0,0 {XCur,YCur:Position actuel du curseur}
  DB 0,0 {StartCur,EndCur:D‚but et fin du curseur}
 END;
{$ENDIF}

Procedure _DriverTxtStandard;Assembler;Const Extra=334;ASM
 JMP Init.Near[Extra]
 JMP BarChrHorTxt.Near[Extra]
 JMP BarChrVerTxt.Near[Extra]
 JMP BarSpcHorTxt.Near[Extra]
 JMP BarSpcVerTxt.Near[Extra]
 JMP BarTxtHorTxt.Near[Extra]
 RETF 8{Circle(X,Y,Rayon:Int;Color:Wd)}
 JMP CloseCurTxt.Near[Extra]
 RETF 8 {ClrLnHor(X,Y,L,Kr:Wd)}
 RETF 12{ClrLnHorImg(X,Y,L:Wd;BitsPerPixel:Byte;Var Buffer)}
 JMP ClrWnTxt.Near[Extra]
 JMP ClrScrTxt.Near[Extra]
 RETF 8 {CopT8Bin(X,Y:Wd;Value,Fore:Byte)}
 RETF 10{Copy8Bin(X,Y:Wd;Value,Back,Fore:Byte)}
 JMP FillBoxTxt.Near[Extra]
 JMP GetAttr.Near[Extra]
 JMP GetChr.Near[Extra]
 JMP GetCube.Near[Extra]
 RETF 10{GetLnHorImg(X1,Y,X2:Int;Var Buffer)}
 JMP GetPixelTxt.Near[Extra]
 JMP GetSizeSmlImgTxt.Near[Extra]
 JMP GetSmlImgTxt.Near[Extra] { Get4Char... }
 JMP MoveTextTxt.Near[Extra]
 JMP PCopyTxt.Near[Extra]
 RETF 10{PCopy2Img(Page:Byte;X1,Y1,X2,Y2:Word)}
 JMP PutCharGAttr.Near[Extra]
 RETF 10{PutFillBox(X1,Y1,X2,Y2,Kr:Wd)}
 RETF 8{PutFillCircle(X,Y,Rayon:Int;Kr:Wd)}
 RETF 12{PutFillRoundRect(x1,y1,x2,y2,b,Kr:Int)}
 RETF 10 {PutLn(X1,Y1,X2,Y2,Kr:Wd)}
 RETF 8 {PutLnHor(X1,Y,X2,Color:Wd)}
 RETF 10{PutRect(X1,Y1,X2,Y2,Kr:Int)}
 RETF 14{PutRoundRect(x1,y1,x2,y2,LineWidth,b,Kr:Int)}
 JMP PutSmlImgTxt.Near[Extra] {PutSpecialPtrMouse...}
 RETF 12{PutSprite(X1,Y1,X2,Y2:Wd;Var Buffer)}
 JMP PutTxtXYTxt.Near[Extra]
 JMP PutTxtXYUnKrTxt.Near[Extra]
 JMP SetAttrTxt.Near[Extra]
 JMP SetBackgroundColorTxt.Near[Extra]
 JMP SetBlinkTxt.Near[Extra]
 JMP SetBorderColorTxt.Near[Extra]
 JMP SetBytesPerLnTxt.Near[Extra]
 JMP SetChrTxt.Near[Extra]
 JMP SetChrWidthTxt.Near[Extra]
 JMP SetCubeTxt.Near[Extra]
 JMP SetCurTxt.Near[Extra]
 JMP SetCurPosTxt.Near[Extra]
 JMP SetDblMtx.Near[Extra]
 JMP SetChrTxt.Near[Extra]  {SetExtChr}
 JMP SetCubeTxt.Near[Extra] {SetExtCube}
 RETF 8 {SetGCube(X,Y:Wd;Chr:Char;Attr:Byte)}
 RETF 8 {SetGCubeT(X,Y:Wd;Chr:Char;Attr:Byte)}
 JMP SetHorizontalScaleTxt.Near[Extra]
 JMP SetMatrixTxt.Near[Extra]
 JMP SetModeMtxTxt.Near[Extra]
 JMP SetModeScrTxt.Near[Extra]
 JMP SetPalBlkTxt.Near[Extra]
 JMP SetPaletteRGBTxt.Near[Extra]
 JMP SetPalRGBTxt.Near[Extra]
 JMP SetPgTxt.Near[Extra]
 RETF 6 {SetPixel(X,Y,Kr:Wd)}
 JMP SetUnderlineTxt.Near[Extra]
 JMP SetVerticalScaleTxt.Near[Extra]
 JMP SetVisualPgTxt.Near[Extra]
 JMP SetWriteModeTxt.Near[Extra]
 JMP SplitScreenTxt.Near[Extra]
 RETF 2 {SetBnkPg(Pg:Byte)}
 RETF 10 {ReadBnk(P:Long;Size:Wd;Var x0)}
 RETF 10 {WriteBnk(P:Long;Size:Wd;Var x0)}
 RETF 8{FillBnk(aY:Long;L,Kr:Wd)}
 RETF {Done}
 NOP
 NOP
  {Gestion des Icons/Luxe}
 JMP SetLuxe.Near[Extra]
 JMP IsLuxe.Near[Extra]
 JMP CloseIconTxt.Near[Extra]
 JMP DownIconTxt.Near[Extra]
 JMP LeftIconTxt.Near[Extra]
 JMP RightIconTxt.Near[Extra]
 JMP SelIconTxt.Near[Extra]
 JMP UnSelIconTxt.Near[Extra]
 JMP UpIconTxt.Near[Extra]
 JMP DownIconTxt.Near[Extra]
 JMP DossierDocumentIconTxt.Near[Extra]
 JMP DossierProgramIconTxt.Near[Extra]
END;

Procedure _DriverTxtDouble;Assembler;Const Extra=584;ASM
 JMP Init.Near[Extra]
 JMP BarChrHorDblMtx.Near[Extra]
 JMP BarChrVerTxt.Near[Extra]
 JMP BarSpcHorDblMtx.Near[Extra]
 JMP BarSpcVerDblMtx.Near[Extra]
 JMP BarTxtHorDblMtx.Near[Extra]
 RETF 8{Circle(X,Y,Rayon:Int;Color:Wd)}
 JMP CloseCurTxt.Near[Extra]
 RETF 8 {ClrLnHor(X,Y,L,Kr:Wd)}
 RETF 12{ClrLnHorImg(X,Y,L:Wd;BitsPerPixel:Byte;Var Buffer)}
 JMP ClrWnDblMtx.Near[Extra]
 JMP ClrScrDblMtx.Near[Extra]
 RETF 8 {CopT8Bin(X,Y:Wd;Value,Fore:Byte)}
 RETF 10{Copy8Bin(X,Y:Wd;Value,Back,Fore:Byte)}
 JMP FillBoxDblMtx.Near[Extra]
 JMP GetAttrDblMtx.Near[Extra]
 JMP GetChr.Near[Extra]
 JMP GetCubeDblMtx.Near[Extra]
 RETF 10{GetLnHorImg(X1,Y,X2:Int;Var Buffer)}
 JMP GetPixelTxt.Near[Extra]
 JMP GetSizeSmlImgTxt.Near[Extra]
 JMP GetSmlImgTxt.Near[Extra] { Get4Char... }
 JMP MoveTextTxt.Near[Extra]
 JMP PCopyTxt.Near[Extra]
 RETF 10{PCopy2Img(Page:Byte;X1,Y1,X2,Y2:Word)}
 JMP PutCharGAttr.Near[Extra]
 RETF 10{PutFillBox(X1,Y1,X2,Y2,Kr:Wd)}
 RETF 8{PutFillCircle(X,Y,Rayon:Int;Kr:Wd)}
 RETF 12{PutFillRoundRect(x1,y1,x2,y2,b,Kr:Int)}
 RETF 10 {PutLn(X1,Y1,X2,Y2,Kr:Wd)}
 RETF 8 {PutLnHor(X1,Y,X2,Color:Wd)}
 RETF 10{PutRect(X1,Y1,X2,Y2,Kr:Int)}
 RETF 14{PutRoundRect(x1,y1,x2,y2,LineWidth,b,Kr:Int)}
 JMP PutSmlImgTxt.Near[Extra] {PutSpecialPtrMouse...}
 RETF 12{PutSprite(X1,Y1,X2,Y2:Wd;Var Buffer)}
 JMP PutTxtXYDblMtx.Near[Extra]
 JMP PutTxtXYUnKrDblMtx.Near[Extra]
 JMP SetAttrDblMtx.Near[Extra]
 JMP SetBackgroundColorTxt.Near[Extra]
 JMP SetBlinkTxt.Near[Extra]
 JMP SetBorderColorTxt.Near[Extra]
 JMP SetBytesPerLnTxt.Near[Extra]
 JMP SetChrTxt.Near[Extra]
 JMP SetChrWidthTxt.Near[Extra]
 JMP SetCubeDblMtx.Near[Extra]
 JMP SetCurTxt.Near[Extra]
 JMP SetCurPosTxt.Near[Extra]
 JMP SetDblMtx.Near[Extra]
 JMP SetExtChrTxt.Near[Extra]
 JMP SetExtCubeTxt.Near[Extra]
 RETF 8 {SetGCube(X,Y:Wd;Chr:Char;Attr:Byte)}
 RETF 8 {SetGCubeT(X,Y:Wd;Chr:Char;Attr:Byte)}
 JMP SetHorizontalScaleTxt.Near[Extra]
 JMP SetMatrixTxt.Near[Extra]
 JMP SetModeMtxTxt.Near[Extra]
 JMP SetModeScrTxt.Near[Extra]
 JMP SetPalBlkTxt.Near[Extra]
 JMP SetPaletteRGBTxt.Near[Extra]
 JMP SetPalRGBTxt.Near[Extra]
 JMP SetPgTxt.Near[Extra]
 RETF 6 {SetPixel(X,Y,Kr:Wd)}
 JMP SetUnderlineTxt.Near
 JMP SetVerticalScaleTxt.Near[Extra]
 JMP SetVisualPgTxt.Near[Extra]
 JMP SetWriteModeTxt.Near
 JMP SplitScreenTxt.Near[Extra]
 RETF 2 {SetBnkPg(Pg:Byte)}
 RETF 10 {ReadBnk(P:Long;Size:Wd;Var x0)}
 RETF 10 {WriteBnk(P:Long;Size:Wd;Var x0)}
 RETF 8{FillBnk(aY:Long;L,Kr:Wd)}
 RETF {Done}
 NOP
 NOP
  {Gestion des Icons/Luxe}
 JMP SetLuxe.Near[Extra]
 JMP IsLuxe.Near[Extra]
 JMP CloseIconDblMtx.Near[Extra]
 JMP DownIconDblMtx.Near[Extra]
 JMP LeftIconDblMtx.Near[Extra]
 JMP RightIconDblMtx.Near[Extra]
 JMP SelIconDblMtx.Near[Extra]
 JMP UnSelIconDblMtx.Near[Extra]
 JMP UpIconDblMtx.Near[Extra]
 JMP DownIconDblMtx.Near[Extra]
 JMP DossierDocumentIconDblMtx.Near[Extra]
 JMP DossierProgramIconDblMtx.Near[Extra]
END;

Procedure RawTxtY;Assembler;ASM
 DW 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0
 DW 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0
 DW 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0
 DW 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0
 DW 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0
 DW 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0
 DW 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0
 DW 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0
END;
{$ELSE}
 Procedure SetChrTxt(X,Y:Byte;Chr:Char);Forward;
 Procedure SetCubeTxt(X,Y:Byte;Chr:Char;Attr:Byte);Forward;
 Procedure SetModeMtxTxt;Forward;
 Procedure SetModeScrTxt;Forward;
 Procedure SetPalRGBTxt(Var P;Start,Num:Wd);Forward;
 Procedure SetPgTxt(Pg:Byte);Forward;
{$ENDIF}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure BarChrHor                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure affiche une bar horizontal avec le caractŠre sp‚cifi‚.


 Remarque
 ÍÍÍÍÍÍÍÍ

  ş Voici la structure de cette proc‚dure en Pascal:
    ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
    ³ Procedure BarChrVer;Var J:Byte;Begin                             ³
    ³  For J:=Y1 to(Y2)do SetChr(X,J,Chr)                              ³
    ³ End;                                                             ³
    ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
}
Procedure BarChrHorTxt(X1,Y,X2:Byte;Chr:Char);Assembler;ASM
 {$IFDEF DPMI}
  MOV BL,Y
  XOR BH,BH
 {$ELSE}
  {$IFDEF __386__}
   DB 36h,0Fh,0B6h,05Eh,0Ah { MOVZX BX,Byte Ptr SS:[BP+0Ah] }
  {$ELSE}
   MOV BL,Y
   XOR BH,BH
  {$ENDIF}
 {$ENDIF}
 SHL BX,1
 MOV DI,Word Ptr RawTxtY[BX]
 MOV BL,X1
 ADD DI,BX
 SHL DI,1
 MOV ES,DataVideo.MIV.SegVideo
 XOR CH,CH
 MOV CL,X2
 SUB CL,X1
 INC CL
 MOV AL,Chr
 CLD
@1:
 STOSB
 INC DI
 LOOP @1
END;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                      Proc‚dure BarChrHorDblMtx                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure affiche une bar horizontal avec le caractŠre sp‚cifi‚
 d'un ‚cran de texte de 512 caractŠres.
}

Procedure BarChrHorDblMtx(X1,Y,X2:Byte;Chr:Char);Assembler;ASM
 {$IFDEF __386__}
  DB 36h,0Fh,0B6h,05Eh,0Ah { MOVZX BX,Byte Ptr SS:[BP+0Ah] }
 {$ELSE}
  MOV BL,Y
  XOR BH,BH
 {$ENDIF}
 SHL BX,1
 MOV DI,Word Ptr RawTxtY[BX]
 MOV BL,X1
 ADD DI,BX
 SHL DI,1
 MOV ES,DataVideo.MIV.SegVideo
 XOR CH,CH
 MOV CL,X2
 SUB CL,X1
 INC CL
 MOV AL,Chr
 CLD
@1:
 STOSB
 AND Byte Ptr ES:[DI],NOT 8
 INC DI
 LOOP @1
END;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure BarChrVer                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure affiche une bar vertical avec le caractŠre sp‚cifi‚.
}

Procedure BarChrVerTxt(X,Y1,Y2:Byte;Chr:Char);Var J:Byte;Begin
 For J:=Y1 to(Y2)do SetChrTxt(X,J,Chr)
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                      Proc‚dure BarSpcHor                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure affiche une bar horizontal avec que des espaces
 dans un ‚cran de texte.
}

Procedure BarSpcHorTxt(X1,Y,X2,Attr:Byte);Assembler;ASM
 {$IFDEF __386__}
  DB 36h,0Fh,0B6h,05Eh,0Ah { MOVZX BX,Byte Ptr SS:[BP+0Ah] }
 {$ELSE}
  MOV BL,Y
  XOR BH,BH
 {$ENDIF}
 SHL BX,1
 MOV DI,Word Ptr RawTxtY[BX]
 MOV BL,X1
 ADD DI,BX
 SHL DI,1
 MOV ES,DataVideo.MIV.SegVideo
 XOR CH,CH
 MOV CL,X2
 SUB CL,X1
 INC CL
 MOV AH,Attr
 MOV AL,' '
 CLD
 {$IFDEF __386__}
  DB  ciPushAX,ciPushAX { EAX := AX:AX }
  DW  ciPopEAX
  SHR CX,1
  DB  ciREP;DW ciSTOSD  { REP STOSD }
  ADC CX,CX
 {$ENDIF}
 REP STOSW
END;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                      Proc‚dure BarSpcHor                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure affiche une bar horizontal avec que des espaces
 dans un ‚cran de texte de 512 caractŠres.
}

Procedure BarSpcHorDblMtx(X1,Y,X2,Attr:Byte);Assembler;ASM
 {$IFDEF __386__}
  DB 36h,0Fh,0B6h,05Eh,0Ah { MOVZX BX,Byte Ptr SS:[BP+0Ah] }
 {$ELSE}
  MOV BL,Y
  XOR BH,BH
 {$ENDIF}
 SHL BX,1
 MOV DI,Word Ptr RawTxtY[BX]
 MOV BL,X1
 ADD DI,BX
 SHL DI,1
 MOV ES,DataVideo.MIV.SegVideo
 XOR CH,CH
 MOV CL,X2
 SUB CL,X1
 INC CL
 MOV AH,Attr
 AND AH,NOT 8
 MOV AL,' '
 CLD
 {$IFDEF __386__}
  DB  ciPushAX,ciPushAX { EAX := AX:AX }
  DW  ciPopEAX
  SHR CX,1
  DB  ciREP;DW ciSTOSD  { REP STOSD }
  ADC CX,CX
 {$ENDIF}
 REP STOSW
END;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Proc‚dure BarSpcVerTxt                   Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure affiche une bar vertical avec que des espaces dans
 un ‚cran de texte.
}

Procedure BarSpcVerTxt(X,Y1,Y2,Attr:Byte);Assembler;ASM
 CLD
 XOR AX,AX
 {$IFDEF __386__}
  DB 36h,0Fh,0B6h,05Eh,0Ah { MOVZX BX,Byte Ptr SS:[BP+0Ah] }
 {$ELSE}
  MOV BL,Y1
  XOR BH,BH
 {$ENDIF}
 SHL BX,1
 MOV DI,Word Ptr RawTxtY[BX]
 MOV AL,DataVideo.MIV.NumXTexts
 MOV ES,DataVideo.MIV.SegVideo
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

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Proc‚dure BarSpcVerDblMtx                 Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure affiche une bar vertical avec que des espaces dans
 un ‚cran de texte de 512 caractŠres.
}

Procedure BarSpcVerDblMtx(X,Y1,Y2,Attr:Byte);Assembler;ASM
 CLD
 XOR AX,AX
 {$IFDEF __386__}
  DB 36h,0Fh,0B6h,05Eh,0Ah { MOVZX BX,Byte Ptr SS:[BP+0Ah] }
 {$ELSE}
  MOV BL,Y1
  XOR BH,BH
 {$ENDIF}
 SHL BX,1
 MOV DI,Word Ptr RawTxtY[BX]
 MOV AL,DataVideo.MIV.NumXTexts
 MOV ES,DataVideo.MIV.SegVideo
 DEC AX
 SHL AX,1
 MOV SI,AX
 MOV BL,X
 ADD DI,BX
 SHL DI,1
 MOV AL,' '
 MOV AH,Attr
 AND AH,NOT 8
 MOV CL,Y1
 MOV CH,Y2
@@Loop:
 STOSW
 ADD DI,SI
 INC CL
 CMP CL,CH
 JBE @@Loop
END;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Proc‚dure BarTxtHorTxt                   Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure affiche une banderole horizontal avec un caractŠre
 particulier dans un ‚cran de texte.
}

Procedure BarTxtHorTxt(X1,Y,X2:Byte;Chr:Char;Attr:Byte);Assembler;ASM
 MOV BL,Y
 XOR BH,BH
 SHL BX,1
 MOV DI,Word Ptr RawTxtY[BX]
 MOV BL,X1
 ADD DI,BX
 SHL DI,1
 MOV ES,DataVideo.MIV.SegVideo
 XOR CH,CH
 MOV CL,X2
 SUB CL,X1
 INC CL
 MOV AH,Attr
 MOV AL,Chr
 CLD
 {$IFDEF __386__}
  DB  ciPushAX,ciPushAX { EAX := AX:AX }
  DW  ciPopEAX
  SHR CX,1
  DB  ciREP;DW ciSTOSD  { REP STOSD }
  ADC CX,CX
 {$ENDIF}
 REP STOSW
END;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Proc‚dure BarTxtHorTxt                   Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure affiche une banderole horizontal avec un caractŠre
 particulier dans un ‚cran de texte avec 512 caractŠres.
}

Procedure BarTxtHorDblMtx(X1,Y,X2:Byte;Chr:Char;Attr:Byte);Assembler;ASM
 MOV BL,Y
 XOR BH,BH
 SHL BX,1
 MOV DI,Word Ptr RawTxtY[BX]
 MOV BL,X1
 ADD DI,BX
 SHL DI,1
 MOV ES,DataVideo.MIV.SegVideo
 XOR CH,CH
 MOV CL,X2
 SUB CL,X1
 INC CL
 MOV AH,Attr
 AND AH,NOT 8
 MOV AL,Chr
 CLD
 {$IFDEF __386__}
  DB  ciPushAX,ciPushAX { EAX := AX:AX }
  DW  ciPopEAX
  SHR CX,1
  DB  ciREP;DW ciSTOSD  { REP STOSD }
  ADC CX,CX
 {$ENDIF}
 REP STOSW
END;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                     Proc‚dure CloseCurTxt                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure efface ou fait disparaŒtre le curseur d'un ‚cran
 de texte.
}

Procedure CloseCurTxt;Assembler;ASM
 {$IFDEF Windows}
  {$IFOPT G+}
   PUSH False
  {$ELSE}
   MOV AX,False
   PUSH AX
  {$ENDIF}
  CALL ShowCursor { ShowCursor(False) }
 {$ELSE}
  {$IFDEF Bios}
   MOV CX,2020h
   MOV AH,01h
   INT 10h
  {$ELSE}
   {$IFDEF PortColor}
    MOV DX,3D4h
   {$ELSE}
    {$IFDEF PortMono}
     MOV DX,3B4h
    {$ELSE}
     {$IFDEF DPMI}
      MOV ES,Seg0040
      MOV DX,ES:[63h]
     {$ELSE}
      {$IFOPT G+}
       PUSH 0
       POP ES
      {$ELSE}
       XOR AX,AX
       MOV ES,AX
      {$ENDIF}
      MOV DX,ES:[463h]
     {$ENDIF}
    {$ENDIF}
   {$ENDIF}
   MOV AX,200Ah
   OUT DX,AX
   INC AL
   OUT DX,AX
(*   MOV AL,20h
   {$IFNDEF NoUpDateInRamBios}
    {$IFDEF DPMI}
     MOV ES:[60h],AX
    {$ELSE}
     MOV ES:[460h],AX
    {$ENDIF}
   {$ENDIF}*)
   MOV Word Ptr DataVideo.MIV.StartCur,02020h
  {$ENDIF}
 {$ENDIF}
END;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                    Proc‚dure ClrScrTxt                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure efface l'‚cran de texte avec l'attribut de la
 variable param‚trage ®Attr¯.
}

Procedure ClrScrTxt(Attr:Byte);Assembler;ASM
 CLD
 MOV ES,DataVideo.MIV.SegVideo
 MOV DI,DataVideo.MIV.AddrPage
 MOV BL,DataVideo.MIV.NumYTexts
 XOR BH,BH
 SHL BX,1
 MOV CX,Word Ptr RawTxtY[BX]
 MOV AH,Attr
 MOV AL,' '
 {$IFDEF __386__}
  DB  ciPushAX,ciPushAX { EAX := AX:AX }
  DW  ciPopEAX
  SHR CX,1
  DB  ciREP;DW ciSTOSD  { REP STOSD }
  ADC CX,CX
 {$ENDIF}
 REP STOSW
END;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                     Proc‚dure ClrScrTxt                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure efface l'‚cran de texte de 512 caractŠres avec
 l'attribut de la variable param‚trage ®Attr¯.
}

Procedure ClrScrDblMtx(Attr:Byte);Assembler;ASM
 CLD
 MOV ES,DataVideo.MIV.SegVideo
 MOV DI,DataVideo.MIV.AddrPage
 MOV BL,DataVideo.MIV.NumYTexts
 XOR BH,BH
 SHL BX,1
 MOV CX,Word Ptr RawTxtY[BX]
 MOV AH,Attr
 AND AH,NOT 8
 MOV AL,' '
 {$IFDEF __386__}
  DB  ciPushAX,ciPushAX { EAX := AX:AX }
  DW  ciPopEAX
  SHR CX,1
  DB  ciREP;DW ciSTOSD  { REP STOSD }
  ADC CX,CX
 {$ENDIF}
 REP STOSW
END;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                     Proc‚dure ClrWnTxt                    Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure efface une boŒte de caractŠres de l'‚cran de
 texte.
}

Procedure ClrWnTxt(X1,Y1,X2,Y2,Attr:Byte);Assembler;ASM
 CLD
 MOV BL,Y1
 XOR BH,BH
 SHL BX,1
 MOV DI,Word Ptr RawTxtY[BX]
 MOV ES,DataVideo.MIV.SegVideo
 MOV SI,DataVideo.MIV.BytesPerLine
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
 PUSH CX;PUSH DI
   MOV CX,DX
   {$IFDEF __386__}
    DB  ciPushAX,ciPushAX { EAX := AX:AX }
    DW  ciPopEAX
    SHR CX,1
    DB  ciREP;DW ciSTOSD  { REP STOSD }
    ADC CX,CX
   {$ENDIF}
   REP STOSW
 POP DI;POP CX
 ADD DI,SI
 INC CL
 CMP CL,CH
 JBE @@Loop
END;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                  Proc‚dure ClrWnDblMtx                    Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure efface une boŒte de caractŠres de l'‚cran de
 texte de 512 caractŠres.
}

Procedure ClrWnDblMtx(X1,Y1,X2,Y2,Attr:Byte);Assembler;ASM
 CLD
 MOV BL,Y1
 XOR BH,BH
 SHL BX,1
 MOV DI,Word Ptr RawTxtY[BX]
 MOV ES,DataVideo.MIV.SegVideo
 MOV SI,DataVideo.MIV.BytesPerLine
 MOV BL,X1
 ADD DI,BX
 SHL DI,1
 MOV AL,' '
 MOV AH,Attr
 AND AH,NOT 8
 MOV CL,Y1
 MOV CH,Y2
 MOV DL,X2
 SUB DL,X1
 MOV DH,0
 INC DX
@@Loop:
 PUSH CX;PUSH DI
   MOV CX,DX
   {$IFDEF __386__}
    DB  ciPushAX,ciPushAX { EAX := AX:AX }
    DW  ciPopEAX
    SHR CX,1
    DB  ciREP;DW ciSTOSD  { REP STOSD }
    ADC CX,CX
   {$ENDIF}
   REP STOSW
 POP DI;POP CX
 ADD DI,SI
 INC CL
 CMP CL,CH
 JBE @@Loop
END;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                      Proc‚dure FillBoxTxt                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure efface une boŒte avec les caractŠres et attributs
 sp‚cifi‚ d'un ‚cran de texte.
}

Procedure FillBoxTxt(X1,Y1,X2,Y2:Byte;Chr:Char;Attr:Byte);Assembler;ASM
 CLD
 MOV BL,Y1
 XOR BH,BH
 SHL BX,1
 MOV DI,Word Ptr RawTxtY[BX]
 MOV SI,DataVideo.MIV.BytesPerLine
 MOV BL,X1
 ADD DI,BX
 SHL DI,1
 MOV AL,Chr
 MOV AH,Attr
 MOV CL,Y2
 SUB CL,Y1
 XOR CH,CH
 INC CX
 MOV DL,X2
 SUB DL,BL
 MOV DH,0
 INC DX
 MOV ES,DataVideo.MIV.SegVideo
@Loop:
 PUSH CX;PUSH DI
  MOV CX,DX
  {$IFDEF __386__}
   DB  ciPushAX,ciPushAX { EAX := AX:AX }
   DW  ciPopEAX
   SHR CX,1
   DB  ciREP;DW ciSTOSD  { REP STOSD }
   ADC CX,CX
  {$ENDIF}
  REP STOSW
 POP DI;POP CX
 ADD DI,SI
 LOOP @Loop
END;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                      Proc‚dure FillBoxDblMtx                   Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure efface une boŒte avec les caractŠres et attributs
 sp‚cifi‚ d'un ‚cran de texte de 512 caractŠres.
}

Procedure FillBoxDblMtx(X1,Y1,X2,Y2:Byte;Chr:Char;Attr:Byte);Assembler;ASM
 CLD
 MOV BL,Y1
 XOR BH,BH
 SHL BX,1
 MOV DI,Word Ptr RawTxtY[BX]
 MOV SI,DataVideo.MIV.BytesPerLine
 MOV BL,X1
 ADD DI,BX
 SHL DI,1
 MOV AL,Chr
 MOV AH,Attr
 AND AH,NOT 8
 MOV CL,Y2
 SUB CL,Y1
 XOR CH,CH
 INC CX
 MOV DL,X2
 SUB DL,BL
 MOV DH,0
 INC DX
 MOV ES,DataVideo.MIV.SegVideo
@Loop:
 PUSH CX;PUSH DI
  MOV CX,DX
  {$IFDEF __386__}
   DB  ciPushAX,ciPushAX { EAX := AX:AX }
   DW  ciPopEAX
   SHR CX,1
   DB  ciREP;DW ciSTOSD  { REP STOSD }
   ADC CX,CX
  {$ENDIF}
  REP STOSW
 POP DI;POP CX
 ADD DI,SI
 LOOP @Loop
END;

{$I \Source\Chantal\RLL\Video\GFXGETCH.INC}

Function GetAttrDblMtx(X,Y:Byte):Byte;Assembler;ASM
 CALL MakeAddr
 INC SI
 MOV AL,ES:[SI]
 AND AL,NOT 8
END;

Function GetCubeDblMtx(X,Y:Byte):Wd;Assembler;ASM
 CALL MakeAddr
 MOV AX,ES:[SI]
 AND AH,NOT 8
END;

Function GetPixelTxt(X,Y:Wd):Wd;Assembler;ASM XOR AX,AX;END;
Function GetSizeSmlImgTxt(X1,Y1,X2,Y2:Wd):Wd;Assembler;ASM XOR AX,AX;END;

Procedure GetSmlImgTxt(X1,Y1,X2,Y2:Wd;Var Buffer);Var C:Array[1..4]of Byte Absolute Buffer;Begin
 C[1]:=Byte(GetChr(X1,Y1));C[2]:=Byte(GetChr(X1+1,Y1));
 C[3]:=Byte(GetChr(X1,Y1+1));C[4]:=Byte(GetChr(X1+1,Y1+1));
End;

Procedure Matrix6x6;Assembler;ASM
 DB   0,  0,  0,  0,  0,  0 {#0}
 DB   0,216,  0,248,112,  0 {#1}
 DB 248,168,248,136,216,248 {#2}
 DB   0, 80,248,248,112, 32 {#3}
 DB   0, 32,112,248,112, 32 {#4}
 DB  32,112,216,248, 32,112 {#5}
 DB  32,112,248,248, 32,112 {#6}
 DB   0, 32,216,216, 32,  0 {#7}
 DB 248,216,168,168,216,248 {#8}
 DB   0,112,200,152,112,  0 {#9}
 DB 248,136,168,168,136,248 {#10}
 DB  56, 24, 32,112,136,112 {#11}
 DB 112,136,112, 32,248, 32 {#12}
 DB  56, 40, 32, 32,224,224 {#13}
 DB   0,120, 72,120, 72,216 {#14}
 DB   0, 32,168, 80,168, 32 {#15}
 DB   0,128,224,248,224,128 {#16}
 DB   0,  8, 56,248, 56,  8 {#17}
 DB  32,112,168,168,112, 32 {#18}
 DB   0,216,216,216,  0,216 {#19}
 DB   0,120,168,104, 40, 40 {#20}
 DB  24, 32, 16, 40,144, 96 {#21}
 DB   0,  0,  0,  0,248,248 {#22}
 DB  32,112, 32,112, 32,248 {#23}
 DB   0, 32,112,248, 32, 32 {#24}
 DB   0, 32, 32,248,112, 32 {#25}
 DB   0, 32, 16,248, 16, 32 {#26}
 DB   0, 32, 64,248, 64, 32 {#27}
 DB   0,  0,192,248,  0,  0 {#28}
 DB   0,  0, 80,248, 80,  0 {#29}
 DB   0,  0,  0, 32,112,248 {#30}
 DB   0,  0,248,112, 32,  0 {#31}
 DB   0,  0,  0,  0,  0,  0 { }
 DB   0, 48, 48, 48,  0, 48 {!}
 DB   0, 80, 80,  0,  0,  0 {"}
 DB   0, 80,248, 80,248, 80 {#}
 DB  32,120,160,112, 40,240 { $}
 DB   0,200, 16, 32, 64,152 {%}
 DB   0,112,216,112,152,104 {&}
 DB   0, 16, 32,  0,  0,  0 {'}
 DB   0,112,192,192,192,112 {(}
 DB   0,224, 48, 48, 48,224 {)}
 DB   0, 80, 32,248, 32, 80 {*}
 DB   0,  0, 32,248, 32,  0 {+}
 DB   0,  0,  0, 32, 32, 64 {,}
 DB   0,  0,  0,248,  0,  0 {-}
 DB   0,  0,  0,  0, 48,  0 {.}
 DB   4,  8, 16, 32, 64,128 {/}
 DB   0,112,152,168,200,112 {0}
 DB   0, 48,112, 48, 48,120 {1}
 DB   0,240, 24,112,192,248 {2}
 DB   0,240, 24,112, 24,240 {3}
 DB   0,192,208,248, 48, 48 {4}
 DB   0,248,192,240, 24,240 {5}
 DB   0,248,128,248,136,248 {6}
 DB   0,248, 24, 48, 96, 96 {7}
 DB   0,112,216,112,216,112 {8}
 DB   0,112,136,120,  8,112 {9}
 DB   0,  0, 32,  0, 32,  0 {:}
 DB   0,  0, 32,  0, 32, 64 {;}
 DB   0, 24, 48, 96, 48, 24 {<}
 DB   0,  0,248,  0,248,  0 {=}
 DB   0, 96, 48, 24, 48, 96 {>}
 DB 112,136, 16, 32,  0, 32 {?}
 DB   0,112,136,184,128,120 {@}
 DB   0,112,200,248,200,200 {A}
 DB   0,240,200,240,200,240 {B}
 DB   0,120,192,192,192,120 {C}
 DB   0,240,216,200,216,240 {D}
 DB   0,248,192,240,192,248 {E}
 DB   0,248,192,240,192,192 {F}
 DB   0,120,192,216,200,120 {G}
 DB   0,200,200,248,200,200 {H}
 DB   0,120, 48, 48, 48,120 {I}
 DB   0,248,  8,  8,200,112 {J}
 DB   0,200,208,224,208,200 {K}
 DB   0,192,192,192,192,248 {L}
 DB   0,136,216,168,136,136 {M}
 DB   0,136,200,168,152,136 {N}
 DB   0,112,200,200,200,112 {O}
 DB   0,240,200,240,192,192 {P}
 DB   0, 96,208,208,208,104 {Q}
 DB   0,240,136,240,208,200 {R}
 DB   0,248,192,248, 24,248 {S}
 DB   0,248, 96, 96, 96, 96 {T}
 DB   0,200,200,200,200,248 {U}
 DB   0,200,200,200,200, 48 {V}
 DB   0,136,136,168,248, 80 {W}
 DB   0,136,216,112,216,136 {X}
 DB   0,200,200,112, 48, 48 {Y}
 DB   0,248, 24,112,192,248 {Z}
 DB   0,120, 96, 96, 96,120 {[}
 DB 128, 64, 32, 16,  8,  4 {\}
 DB   0,120, 24, 24, 24,120 {]}
 DB  32, 80,136,  0,  0,  0 {^}
 DB   0,  0,  0,  0,  0,255 {_}
 DB  64, 32,  0,  0,  0,  0 {`}
 DB   0,  0,112,200,200,120 {a}
 DB   0,128,240,136,136,240 {b}
 DB   0,  0,120,192,192,120 {c}
 DB   0,  8,120,136,136,120 {d}
 DB   0,  0,112,248,128,112 {e}
 DB   0, 24, 32,120, 32, 32 {f}
 DB   0,112,136,120,  8,112 {g}
 DB   0,192,240,200,200,200 {h}
 DB  48,  0, 48, 48, 48, 48 {i}
 DB  24,  0, 24, 24,216,112 {j}
 DB   0,192,208,224,216,216 {k}
 DB   0, 96, 96, 96, 96, 56 {l}
 DB   0,  0,208,248,168,136 {m}
 DB   0,  0,240,200,200,200 {n}
 DB   0,  0,112,200,200,112 {o}
 DB   0,  0,240,200,240,192 {p}
 DB   0,  0,112,152,120, 24 {q}
 DB   0,  0,176,104, 96, 96 {r}
 DB   0, 56, 64, 48,136,112 {s}
 DB   0, 96,248, 96,104, 48 {t}
 DB   0,  0,200,200,200,120 {u}
 DB   0,  0,200,200,200,112 {v}
 DB   0,  0,136,168,168,112 {w}
 DB   0,  0,216, 96, 48,216 {x}
 DB   0,  0,200,248,  8,112 {y}
 DB   0,  0,240, 48,192,248 {z}
 DB   0, 56, 96,192, 96, 56 (*{*)
 DB   0, 16, 16,  0, 16, 16 {|}
 DB   0,224, 48, 24, 48,224 (*}*)
 DB   0,104,144,  0,  0,  0 {~}
 DB   0, 32, 80,136,248,  0 {#127}
 DB 112,200,128,200,112,192 {#128}
 DB   0,200,  0,200,200,120 {#129}
 DB  24, 32,112,248,128,112 {#130}
 DB  16, 40,  0,120,196,124 {#131}
 DB 104,  0,112,200,200,120 {#132}
 DB  48,  8,112,136,136,120 {#133}
 DB  16, 40, 16,112,200,120 {#134}
 DB   0,120,192,120, 16, 96 {#135}
 DB 112,  0,112,248,192,112 {#136}
 DB  80,  0,112,248,128,112 {#137}
 DB  48,  8,112,248,192,112 {#138}
 DB 104,  0, 48, 48, 48, 48 {#139}
 DB  48, 72,  0, 48, 48, 48 {#140}
 DB  96, 16,  0, 48, 48, 48 {#141}
 DB 200,  0,112,200,248,200 {#142}
 DB  48,  0,112,200,248,200 {#143}
 DB 112,248,192,240,192,248 {#144}
 DB   0,208, 40,112,160, 88 {#145}
 DB   0, 56, 80,248,144,152 {#146}
 DB  32, 80,  0,112,200,112 {#147}
 DB  80,  0,112,200,200,112 {#148}
 DB  96, 16,  0,112,200,112 {#149}
 DB  32, 80,  0,200,200,120 {#150}
 DB  96, 16,  0,200,200,120 {#151}
 DB  80,  0,200,248,  8,112 {#152}
 DB  80,  0,112,200,200,112 {#153}
 DB 200,  0,200,200,200,248 {#154}
 DB  16,120,128,128,120, 16 {#155}
 DB  48, 72,224, 64,136,248 {#156}
 DB 216, 32,248, 32,248, 32 {#157}
 DB 192,160,208,184,144,152 {#158}
 DB  48, 40, 96, 48,160, 96 {#159}
 DB  48, 64,  0,112,136,120 {#160}
 DB  48, 64,  0, 32, 32, 32 {#161}
 DB  48, 64,  0,112,200,112 {#162}
 DB  48, 64,  0,200,200,120 {#163}
 DB 104,144,  0,176, 72, 72 {#164}
 DB 104,144,  0,200,168,152 {#165}
 DB 112,144,104,  0,248,  0 {#166}
 DB 112,136,112,  0,248,  0 {#167}
 DB  32,  0, 32, 64,136,112 {#168}
 DB   0,  0,252,192,  0,  0 {#169}
 DB   0,  0,252, 12,  0,  0 {#170}
 DB  72, 80, 32, 64,168, 40 {#171}
 DB  72, 80, 32, 80,152,  8 {#172}
 DB  48,  0, 48, 48, 48,  0 {#173}
 DB  40, 80,160, 80, 40,  0 {#174}
 DB 160, 80, 40, 80,160,  0 {#175}
 DB  84,168, 84,168, 84,168 {#176}
 DB 252,252,252,252,252,252 {#177}
 DB 168, 84,168, 84,168, 84 {#178}
 DB  16, 16, 16, 16, 16, 16 {#179}
 DB  16, 16, 16,240, 16, 16 {#180}
 DB  16, 16,240, 16,240, 16 {#181}
 DB  40, 40, 40,232, 40, 40 {#182}
 DB   0,  0,  0,248, 40, 40 {#183}
 DB   0,  0,240, 16,240, 16 {#184}
 DB  40, 40,232,  8,232, 40 {#185}
 DB  40, 40, 40, 40, 40, 40 {#186}
 DB   0,  0,248,  8,232, 40 {#187}
 DB  40, 40,232,  8,248,  0 {#188}
 DB  40, 40, 40,248,  0,  0 {#189}
 DB  16, 16,240, 16,240,  0 {#190}
 DB   0,  0,  0,240, 16, 16 {#191}
 DB  16, 16, 16, 31,  0,  0 {#192}
 DB  16, 16, 16,255,  0,  0 {#193}
 DB   0,  0,  0,255, 16, 16 {#194}
 DB  16, 16, 16, 28, 16, 16 {#195}
 DB   0,  0,  0,255,  0,  0 {#196}
 DB  16, 16, 16,255, 16, 16 {#197}
 DB  16, 16, 31, 16, 31, 16 {#198}
 DB  40, 40, 40, 47, 40, 40 {#199}
 DB  40, 40, 47, 32, 63,  0 {#200}
 DB   0,  0, 63, 32, 47, 40 {#201}
 DB  40, 40,239,  0,255,  0 {#202}
 DB   0,  0,255,  0,239, 40 {#203}
 DB  40, 40, 47, 32, 47, 40 {#204}
 DB   0,  0,255,  0,255,  0 {#205}
 DB  40, 40,239,  0,239, 40 {#206}
 DB  16, 16,255,  0,255,  0 {#207}
 DB  40, 40, 40,255,  0,  0 {#208}
 DB   0,  0,255,  0,255, 16 {#209}
 DB   0,  0,  0,255, 40, 40 {#210}
 DB  40, 40, 40, 63,  0,  0 {#211}
 DB  16, 16, 31, 16, 31,  0 {#212}
 DB   0,  0, 31, 16, 31, 16 {#213}
 DB   0,  0,  0, 63, 40, 40 {#214}
 DB  40, 40, 40,255, 40, 40 {#215}
 DB  16, 16,255, 16,255, 16 {#216}
 DB  16, 16, 16,240,  0,  0 {#217}
 DB   0,  0,  0, 31, 16, 16 {#218}
 DB 255,255,255,255,255,255 {#219}
 DB   0,  0,  0,255,255,255 {#220}
 DB 192,192,192,192,192,192 {#221}
 DB  15, 15, 15, 15, 15, 15 {#222}
 DB 255,255,255,  0,  0,  0 {#223}
 DB   0,  0,104,144,144,104 {#224}
 DB   0,112,152,176,136,176 {#225}
 DB   0,248,136,128,128,128 {#226}
 DB   0,  0,248, 80, 80, 80 {#227}
 DB 248, 72, 32, 64,136,248 {#228}
 DB   0,  0,120,144,144, 96 {#229}
 DB   0, 72, 72,120, 64,192 {#230}
 DB   0,  0,104,176, 32, 32 {#231}
 DB   0,248, 32, 80, 32,248 {#232}
 DB   0,112,136,248,136,112 {#233}
 DB   0,112,136,136, 80,216 {#234}
 DB  56, 64, 32,112,136,112 {#235}
 DB   0,  0, 80,168, 80,  0 {#236}
 DB   0,  8, 80,168, 80,128 {#237}
 DB   0,120,128,248,128,120 {#238}
 DB   0,  0,112,136,136,136 {#239}
 DB   0,248,  0,248,  0,248 {#240}
 DB   0, 32,112, 32,  0,248 {#241}
 DB  64, 32, 16, 32, 64,248 {#242}
 DB  16, 32, 64, 32, 16,248 {#243}
 DB  16, 40, 32, 32, 32, 32 {#244}
 DB  32, 32, 32, 32,160, 64 {#245}
 DB   0, 32,  0,248,  0, 32 {#246}
 DB 104,144,  0,104,144,  0 {#247}
 DB  96,144, 96,  0,  0,  0 {#248}
 DB   0,  0,  0, 48,  0,  0 {#249}
 DB   0,  0,  0, 16,  0,  0 {#250}
 DB  60, 32, 32,160, 96, 32 {#251}
 DB 176, 72, 72,  0,  0,  0 {#252}
 DB 224, 16, 96,128,240,  0 {#253}
 DB   0,  0,112,112,  0,  0 {#254}
 DB   0,  0,  0,  0,  0,  0 {#255}
END;

{$IFNDEF DPMI}
Procedure Init;Begin
 ASM
  CMP PhysVideo.PIV.VGA,No
  JE @NoEmulCursor
  MOV AX,1201h
  MOV BL,34h
  INT 10h
@NoEmulCursor:
  XOR AX,AX
  MOV DataVideo.MIV.IbmLogic,Ya
  MOV DataVideo.MIV.BiosSupport,Ya
  MOV DataVideo.MIV.BitsPerPixel,AL
  MOV ES,AX
  MOV CH,ES:[44Ah]
  MOV DL,ES:[463h]
  MOV BX,ES:[484h]
  MOV CL,6
  SHR DL,CL
  AND DX,1
  MOV DataVideo.MIV.Color,DL
  MOV DataVideo.MIV.Graphics,AL
  MOV CL,11
  SHL DX,CL
  ADD DX,0B000h
  MOV DataVideo.MIV.SegVideo,DX
  OR  BH,BH
  JNZ @HeightNot0
  MOV BX,24+(8 shl 8)
@HeightNot0:
  MOV DataVideo.MIV.HeightChar,BH
  INC BL
  MOV DataVideo.MIV.NumYTexts,BL
  MOV DataVideo.MIV.NumXTexts,CH
  MOV AL,CH
  SHL AX,1
  MOV DataVideo.MIV.BytesPerLine,AX
  {$IFOPT G+}
   SHL AX,2
  {$ELSE}
   SHL AX,1
   SHL AX,1
  {$ENDIF}
  MOV DataVideo.MIV.NumXPixels,AX
  MOV DataVideo.MIV.NumVideoPages,1
  MOV DataVideo.MIV.Direct,True
  MOV AL,BH
  MUL BL
  MOV DataVideo.MIV.NumYPixels,AX
  MOV AX,16
  CMP DataVideo.MIV.Color,True
  JE  @NoMono
  MOV AL,4
@NoMono:
  MOV Word Ptr DataVideo.MIV.NumColors,AX
  MOV Word Ptr DataVideo.MIV.NumColors[2],0
 END;
 SetPgTxt(0);
 ASM
  MOV BL,DataVideo.MIV.NumYTexts
  XOR BH,BH
  SHL BX,1
  MOV AX,Word Ptr RawTxtY[BX]
  SHL AX,1
  MOV Word Ptr DataVideo.MIV.ScrSize,AX
  MOV Word Ptr DataVideo.MIV.ScrSize[2],AX
 END;
End;
{$ENDIF}

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

Procedure MoveTextTxt(X1,Y1,X2,Y2,X3,Y3:Byte);Var L:Wd;Begin
 If(X2<X1)or(Y2<Y1)Then Exit;
 ASM
  PUSH DS
  MOV AL,X2
  SUB AL,X1
  XOR AH,AH
  INC AX
  MOV L,AX
  CLD
  MOV ES,DataVideo.MIV.SegVideo
  MOV AL,Y1
  CMP Y3,AL;JB @@Inc
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
  PUSH ES;POP DS
  {$IFDEF __386__}
   SHR CX,1
   DB  ciREP;DW ciMOVSD  { REP MOVSD }
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
  PUSH ES;POP DS
  REP MOVSW
  INC DL
  CMP DL,DH;JNE @@LoopInc
@@End:
  POP DS
 END;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                     Proc‚dure PCopyTxt                    Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure, inspir‚ du Basic, permet de copier une page
 vid‚o d'‚cran de texte dans une autre d'‚cran texte.
}

Procedure PCopyTxt(S,T:Byte);Var A,B,C:Wd;Begin
 ASM
  MOV CX,Word Ptr DataVideo.MIV.ScrSize
  MOV C,CX
 END;
 A:=C*S;B:=C*T;
 ASM
  CLD
  PUSH DS
   MOV DS,DataVideo.MIV.SegVideo
   MOV SI,A
   PUSH DS;POP ES
   MOV DI,B
   MOV CX,C
   SHR CX,1
   REP MOVSW
  POP DS
 END;
End;

{$I \Source\Chantal\RLL\Video\PutCharG.Inc}

Procedure PtrMs;Assembler;ASM
 DB 00111111b
 DB 00011111b
 DB 00001111b
 DB 00000111b
 DB 00000011b
 DB 00000001b
 DB 00000000b
 DB 00000000b
 DB 00000000b
 DB 00000000b
 DB 00000001b
 DB 00010000b
 DB 00110000b
 DB 11111000b
 DB 11111000b
 DB 11111100b

 DB 00000000b
 DB 01000000b
 DB 01100000b
 DB 01110000b
 DB 01111000b
 DB 01111100b
 DB 01111110b
 DB 01111111b
 DB 01111111b
 DB 01111100b
 DB 01101100b
 DB 01000110b
 DB 00000110b
 DB 00000011b
 DB 00000011b
 DB 00000000b
END;

Procedure PutSmlImgTxt(X1,Y1,X2,Y2:Wd;Var Buffer);
Var
 D,J,H:Byte;
 CT:Array[1..4]of Byte Absolute Buffer;
 CWd:Array[1..4]of Word;
Begin
 ASM
  MOV AL,DataVideo.MIV.HeightChar
  DEC AL
  MOV H,AL
 END;
 SetChrTxt(X2,Y2,#0);
 SetChrTxt(X2+1,Y2,#28);
 SetChrTxt(X2,Y2+1,#18);
 SetChrTxt(X2+1,Y2+1,#255);
 SetModeMtxTxt;
 For J:=1to 4do CWd[J]:=CT[J]shl 5;
 For J:=0to(H)do Begin
  If(Y1>J)Then D:=0
   Else
  ASM
    {D:=PtrMs[16+J-Y1];}
   MOV BX,16
   ADD BL,J
   ADC BH,BH
   SUB BX,Y1
   MOV AL,Byte Ptr PtrMs[BX]
   MOV D,AL
  END;
  Mem[_A000:J]:=Mem[_A000:CWd[1]+J]or(D shr X1);
  Mem[_A000:J+28*32]:=Mem[_A000:CWd[2]+J]or((D shl 8)shr X1);
  If Not(Y1>J)Then D:=0
   Else
  ASM
    {D:=PtrMs[16+15+J-Y1];}
   MOV BX,16+15
   ADD BL,J
   ADC BH,BH
   SUB BX,Y1
   MOV AL,Byte Ptr PtrMs[BX]
   MOV D,AL
  END;
  Mem[_A000:J+18*32]:=Mem[_A000:CWd[3]+J]or(D shr X1);
  Mem[_A000:J+255*32]:=Mem[_A000:CWd[4]+J]or((D shl 8)shr X1);
 End;
 SetModeScrTxt;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure PutTxtXYTxt                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure affiche un message … l'‚cran de texte aux coordonn‚es
 texte (X,Y) avec l'attribut ®Attr¯.
}

Procedure PutTxtXYTxt(X,Y:Byte;Const Str:String;Attr:Byte);Assembler;ASM
 PUSH DS
  MOV BL,Y;XOR BH,BH;SHL BX,1;MOV DI,Word Ptr RawTxtY[BX]{DI:=RawTxtY[Y shl 1]}
  MOV BL,X
  ADD DI,BX
  SHL DI,1
(*  {$IFDEF DPMI}
   MOV ES,SegB800
  {$ELSE}*)
   MOV ES,DataVideo.MIV.SegVideo
(*  {$ENDIF}*)
  LDS SI,Str
  MOV CL,DS:[SI];XOR CH,CH;JCXZ @2
  INC SI
  MOV AH,Attr
@1:LODSB
  STOSW
  LOOP @1
@2:
 POP DS
END;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Proc‚dure PutTxtXYDblMtx                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure affiche un message … l'‚cran de texte de 512 caractŠres
 aux coordonn‚es texte (X,Y) avec l'attribut ®Attr¯.
}

Procedure PutTxtXYDblMtx(X,Y:Byte;Const Str:String;Attr:Byte);Assembler;ASM
 PUSH DS
  MOV BL,Y
  XOR BH,BH
  SHL BX,1
  MOV DI,Word Ptr RawTxtY[BX]{DI:=RawTxtY[Y shl 1]}
  MOV BL,X
  ADD DI,BX
  SHL DI,1
  MOV ES,DataVideo.MIV.SegVideo
  LDS SI,Str
  MOV CL,DS:[SI]
  XOR CH,CH
  JCXZ @2
  INC SI
  MOV AH,Attr
  AND AH,NOT 8
@1:LODSB
  STOSW
  LOOP @1
@2:
 POP DS
END;

Procedure PutTxtXYUnKrTxt(X,Y:Byte;Const Str:String);Assembler;ASM
 PUSH DS
  MOV BL,Y;XOR BH,BH;SHL BX,1;MOV DI,Word Ptr RawTxtY[BX]{DI:=RawTxtY[Y shl 1]}
  MOV BL,X
  ADD DI,BX
  SHL DI,1
  MOV ES,DataVideo.MIV.SegVideo
  LDS SI,Str
  MOV CL,DS:[SI]
  XOR CH,CH
  JCXZ @2
  INC SI
@1:LODSB
  STOSB
  INC DI
  LOOP @1
@2:
 POP DS
END;

Procedure PutTxtXYUnKrDblMtx(X,Y:Byte;Const Str:String);Assembler;ASM
 PUSH DS
  MOV BL,Y;XOR BH,BH;SHL BX,1;MOV DI,Word Ptr RawTxtY[BX]{DI:=RawTxtY[Y shl 1]}
  MOV BL,X
  ADD DI,BX
  SHL DI,1
  MOV ES,DataVideo.MIV.SegVideo
  LDS SI,Str
  MOV CL,DS:[SI]
  XOR CH,CH
  JCXZ @2
  INC SI
@1:LODSB
  STOSB
  AND Byte Ptr ES:[DI],NOT 8
  INC DI
  LOOP @1
@2:
 POP DS
END;

Procedure SetAttrTxt(X,Y,Attr:Byte);Assembler;ASM
 MOV BL,Y
 XOR BH,BH
 SHL BX,1
 MOV DI,Word Ptr RawTxtY[BX]
 MOV BL,X
 ADD DI,BX
 SHL DI,1
 MOV ES,DataVideo.MIV.SegVideo
 MOV AL,Attr
 INC DI
 STOSB
END;

Procedure SetAttrDblMtx(X,Y,Attr:Byte);Assembler;ASM
 MOV BL,Y
 XOR BH,BH
 SHL BX,1
 MOV DI,Word Ptr RawTxtY[BX]
 MOV BL,X
 ADD DI,BX
 SHL DI,1
 MOV ES,DataVideo.MIV.SegVideo
 MOV AL,Attr
 AND AL,NOT 8
 INC DI
 STOSB
END;

Procedure SetBackgroundColorTxt(Kr:Byte);Assembler;ASM
 MOV CX,Word Ptr DataVideo.MIV.ScrSize
 SHR CX,1
 MOV ES,DataVideo.MIV.SegVideo
 XOR DI,DI
 MOV AL,Kr
 {$IFOPT G+}SHL AL,4{$ELSE}SHL AL,1;SHL AL,1;SHL AL,1;SHL AL,1{$ENDIF}
@1:
 INC DI
 AND Byte Ptr ES:[DI],0Fh
 OR  ES:[DI],AL
 INC DI
 LOOP @1
END;

Procedure SetBlinkTxt(X:Bool);Assembler;ASM
 MOV AX,1003h
 MOV BL,X
 MOV DataVideo.MIV.Blink,BL
 INT 10h
 CMP PhysVideo.PIV.EGA,Ya
 JE @@End
 {$IFDEF DPMI}
  MOV ES,Seg0040
  MOV DX,[63h]
 {$ELSE}
  {$IFOPT G+}
   PUSH 0
   POP  ES
  {$ELSE}
   XOR AX,AX
   MOV ES,AX
  {$ENDIF}
  MOV DX,ES:[0463h]
 {$ENDIF}
 ADD DX,4
 MOV AL,X
 {$IFOPT G+}ROR AL,2{$ELSE}ROR AL,1;ROR AL,1{$ENDIF}
 MOV BL,AL
 ADD AL,09h
 OUT DX,AL
@@End:
END;

Procedure SetBorderColorTxt(Kr:Byte);Assembler;ASM
 MOV AH,0Bh
 MOV BL,Kr
 AND BX,000Fh
 INT 10h
END;

Procedure SetBytesPerLnTxt(X:Word);Assembler;ASM
 CMP PhysVideo.PIV.VGA,True
 JNE @End
 {$IFOPT G+}
  PUSH 0
  POP ES
 {$ELSE}
  XOR AX,AX
  MOV ES,AX
 {$ENDIF}
 MOV DX,ES:[0463h]
 MOV AX,X
 MOV DataVideo.MIV.BytesPerLine,AX
 {$IFOPT G+}
  SHR AX,2
 {$ELSE}
  SHR AX,1
  SHR AX,1
 {$ENDIF}
 MOV AH,AL
 MOV AL,13h { Registre de bande }
 OUT DX,AX
 PUSH Word Ptr DataVideo.MIV.Page
 PUSH CS
 CALL Near Ptr SetPgTxt
@End:
END;

Procedure SetChrTxt(X,Y:Byte;Chr:Char);Assembler;ASM
 MOV BL,Y
 XOR BH,BH
 SHL BX,1
 MOV DI,Word Ptr RawTxtY[BX]
 MOV BL,X
 ADD DI,BX
 SHL DI,1
 MOV ES,DataVideo.MIV.SegVideo
 MOV AL,Chr
 STOSB
END;

Procedure SetChrWidthTxt(L:Byte);Assembler;ASM
 CMP PhysVideo.PIV.CardCat,cvnVGA
 JB @End
 CMP DataVideo.MIV.NumXTexts,80
 JA @End
 MOV DX,03CCh
 IN  AL,DX
 AND AL,Not(4+8)
 MOV BX,0001h
 CMP L,8;JE @1
 OR  AL,4
 MOV BX,0800h
@1:
 MOV DL,0C2h
 OUT DX,AL
 CLI
 MOV DL,0C4h;MOV AX,0100h;OUT DX,AX
 MOV AL,01h
 MOV AH,BL
 CMP DataVideo.MIV.NumXTexts,40
 JNE @2
 OR  AH,8
@2:
 OUT DX,AX
 MOV AX,0300h;OUT DX,AX
 STI
 MOV AH,10h
 MOV BL,13h
 INT 10h
@End:
END;

Procedure SetCubeTxt(X,Y:Byte;Chr:Char;Attr:Byte);Assembler;ASM
 MOV BL,Y
 XOR BH,BH
 SHL BX,1
 MOV DI,Word Ptr RawTxtY[BX]
 MOV BL,X
 ADD DI,BX
 SHL DI,1
 MOV ES,DataVideo.MIV.SegVideo
 MOV AL,Chr
 MOV AH,Attr
 STOSW
END;

Procedure SetCubeDblMtx(X,Y:Byte;Chr:Char;Attr:Byte);Assembler;ASM
 MOV BL,Y
 XOR BH,BH
 SHL BX,1
 MOV DI,Word Ptr RawTxtY[BX]
 MOV BL,X
 ADD DI,BX
 SHL DI,1
 MOV ES,DataVideo.MIV.SegVideo
 MOV AL,Chr
 MOV AH,Attr
 AND AH,NOT 8
 STOSW
END;

Procedure SetCurTxt(A,B:Byte);Assembler;ASM
 {$IFDEF DPMI}
  MOV ES,Seg0040
  MOV DX,ES:[63h]
 {$ELSE}
  XOR AX,AX
  MOV ES,AX
  MOV DX,ES:[0463h]
 {$ENDIF}
 MOV AL,0Ah
 MOV AH,A
 {$IFDEF DPMI}
  MOV ES:[61h],AH
 {$ELSE}
  MOV ES:[0461h],AH
 {$ENDIF}
 OUT DX,AX
 INC AL
 MOV AH,B
 {$IFDEF DPMI}
  MOV ES:[60h],AH
 {$ELSE}
  MOV ES:[0460h],AH
 {$ENDIF}
 OUT DX,AX
END;

Procedure SetCurPosTxt(X,Y:Byte);Assembler;ASM
 MOV BL,Y
 XOR BH,BH
 SHL BX,1
 MOV AX,Word Ptr RawTxtY[BX]
 MOV BL,X
 ADD AX,BX
 {$IFDEF DPMI}
  MOV ES,Seg0040
  MOV DX,ES:[63h]
 {$ELSE}
  XOR DX,DX
  MOV ES,DX
  MOV DX,ES:[0463h]
 {$ENDIF}
 MOV BX,AX
 MOV AL,0Eh
 OUT DX,AX
 INC AL
 MOV AH,BL
 OUT DX,AX
 MOV AL,Y
 {$IFDEF DPMI}
  MOV BL,ES:[62h]
 {$ELSE}
  MOV BL,ES:[0462h]
 {$ENDIF}
 AND BL,7
 MOV BH,0
 SHL BX,1
 {$IFDEF DPMI}
  MOV ES:[51h+BX],AL
 {$ELSE}
  MOV ES:[0451h+BX],AL
 {$ENDIF}
 MOV AL,X
 {$IFDEF DPMI}
  MOV ES:[50h+BX],AL
 {$ELSE}
  MOV ES:[0450h+BX],AL
 {$ENDIF}
 MOV AL,X
 MOV AH,Y
 MOV Word Ptr DataVideo.MIV.XCur,AX
END;

Procedure SetDblMtx(X:Bool);Assembler;ASM
 CMP PhysVideo.PIV.CardCat,cvnEGA;JB @1
 MOV AX,1103h
 MOV BL,X
 AND BL,1
 MOV Byte Ptr DataVideo.MIV.IsDoubleMtx,BL
 {$IFOPT G+}
  SHL BL,2
 {$ELSE}
  SHL BL,1
  SHL BL,1
 {$ENDIF}
 INT 10h
 PUSH DS
  CLD
  PUSH CS
  POP DS
  PUSH CS
  POP ES
  XOR DI,DI
  {$IFNDEF DPMI}
   MOV SI,Offset _DriverTxtStandard
  {$ENDIF}
  CMP Byte Ptr DataVideo.MIV.IsDoubleMtx,0
  JE  @2
  {$IFNDEF DPMI}
   MOV SI,Offset _DriverTxtDouble
  {$ENDIF}
@2:
  MOV CX,Offset PhysVideo-1-6
  SHR CX,1
  REP MOVSW
  ADC CX,CX
  REP MOVSB
 POP DS
@1:
END;

Procedure SetExtChrTxt(X,Y:Byte;Chr:Wd);Assembler;ASM
 MOV BL,Y
 XOR BH,BH
 SHL BX,1
 MOV DI,Word Ptr RawTxtY[BX]
 MOV BL,X
 ADD DI,BX
 SHL DI,1
 MOV ES,DataVideo.MIV.SegVideo
 MOV BL,ES:[DI+1]
 AND BL,NOT 8
 MOV AX,Chr
 {$IFOPT G+}
  SHL AH,3
 {$ELSE}
  SHL AH,1
  SHL AH,1
  SHL AH,1
 {$ENDIF}
 OR AH,BL
 STOSW
END;

Procedure SetExtCubeTxt(X,Y:Byte;Chr:Wd;Attr:Byte);Assembler;ASM
 MOV BL,Y
 XOR BH,BH
 SHL BX,1
 MOV DI,Word Ptr RawTxtY[BX]
 MOV BL,X
 ADD DI,BX
 SHL DI,1
 MOV ES,DataVideo.MIV.SegVideo
 MOV BL,Attr
 AND BL,NOT 8
 MOV AX,Chr
 {$IFOPT G+}SHL AH,3{$ELSE}SHL AH,1;SHL AH,1;SHL AH,1{$ENDIF}
 OR  AH,BL
 STOSW
END;

Procedure OffsetMtx;Assembler;ASM
 DW 0
 DW 16384
 DW 32768
 DW 49152
 DW 8192
 DW 24576
 DW 40960
 DW 57344
END;

Procedure SetMatrixTxt(Palette,Height:Byte;Number,Start:Wd;Var X:TByte);Begin
 SetModeMtxTxt;
 ASM{Valeur par d‚faut B=0}
  MOV BL,Palette
  AND BX,7
  SHL BX,1
  MOV BX,Word Ptr OffsetMtx[BX]
  CLD
  PUSH DS
   MOV DX,Number
   LDS SI,X
   {$IFDEF DPMI}
    MOV ES,SegA000
   {$ELSE}
    MOV AX,0A000h
    MOV ES,AX
   {$ENDIF}
@Restart:
   MOV DI,Number
   SUB DI,DX
   ADD DI,Start
   MOV CL,5
   SHL DI,CL
   ADD DI,BX
   MOV CL,Height;XOR CH,CH
   ADD Word Ptr X,CX
   REP MOVSB
   DEC DX
   OR  DX,DX
   JNZ @Restart
  POP DS
 END;
 SetModeScrTxt;
End;

Procedure SetModeMtxTxt;Assembler;ASM
 MOV DX,3CEh
 MOV AX,0204h;OUT DX,AX
 MOV AX,0005h;OUT DX,AX
 MOV AX,0406h;OUT DX,AX
 MOV DL,0C4h
 MOV AX,0100h;OUT DX,AX
 MOV AX,0402h;OUT DX,AX
 MOV AX,0704h;OUT DX,AX
 MOV AX,0300h;OUT DX,AX
END;

Procedure SetModeScrTxt;Assembler;ASM
 MOV DX,3C4h
 MOV AX,0100h;OUT DX,AX
 MOV AX,0302h;OUT DX,AX
 MOV AL,4;OUT DX,AX
 XOR AL,AL;OUT DX,AX
 MOV DL,0CEh
 MOV AX,0004h;OUT DX,AX
 MOV AX,1005h;OUT DX,AX
 MOV AX,0E06h;OUT DX,AX
END;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure SetPalBlk                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure fixe un nombre d‚terminer de pallette en couleur noir.
}

Procedure SetPalBlkTxt(Start,Nm:Wd);Assembler;ASM
 CMP PhysVideo.PIV.VGA,Ya;JE  @VGA
 CMP PhysVideo.PIV.EGA,Ya;JNE @End
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
 OUT DX,AL;OUT DX,AL;OUT DX,AL
 LOOP @Loop2
@End:
END;

Procedure TmpRGB;Assembler;ASM;DW 0;END;

Procedure SetPaletteRGBTxt(Start:Wd;R,G,B:Byte);Assembler;ASM
 MOV AL,R;MOV AH,G;MOV Word Ptr TmpRGB,AX
 MOV BL,B;MOV Byte Ptr TmpRGB[2],BL
 PUSH CS
 {$IFOPT G+}PUSH Offset TmpRGB{$ELSE}MOV AX,Offset TmpRGB;PUSH AX{$ENDIF}
 PUSH Start
 {$IFOPT G+}PUSH 1{$ELSE}MOV AX,1;PUSH AX{$ENDIF}
 PUSH CS;CALL Near Ptr SetPalRGBTxt
END;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                              Proc‚dure SetPalRGB                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure fixe une palette de style Rouge-Vert-Bleu. Peut importe la
 carte install‚, si elle supporte des palettes de couleurs, il fait avec!
}

Procedure SetPalRGBTxt(Var P;Start,Num:Wd);Assembler;ASM
 PUSH DS
  CLD
  LDS SI,P
  CMP PhysVideo.PIV.CardCat,cvnVGA;JB @1
  MOV AL,Byte Ptr Start
  MOV BL,AL
  XOR BH,BH
  CMP AL,8
  JNAE @A
  OR AL,30h
  MOV BH,1
@A:
  MOV DX,03C8h
  OUT DX,AL
  INC DX
  XOR AX,AX
  MOV CX,Num
@Loop2:
  CMP BH,1
  JE  @C
  CMP BL,8
  JB  @C
  DEC DX
  MOV AL,BL
  OR  AL,30h
  OUT DX,AL
  INC DX
  MOV BH,1
@C:
  LODSB
  {$IFOPT G+}SHR AL,2{$ELSE}SHR AL,1;SHR AL,1{$ENDIF}
  OUT DX,AL
  LODSB
  {$IFOPT G+}SHR AL,2{$ELSE}SHR AL,1;SHR AL,1{$ENDIF}
  OUT DX,AL
  LODSB
  {$IFOPT G+}SHR AL,2{$ELSE}SHR AL,1;SHR AL,1{$ENDIF}
  OUT DX,AL
  INC BH
  LOOP @Loop2
  JMP @End
@1:
  MOV CX,Num
  MOV DX,03C0h
  MOV BL,Byte Ptr Start
@2:LODSB {Rouge}
  {$IFOPT G+}SHR AL,2{$ELSE}SHR AL,1;SHR AL,1{$ENDIF}
  MOV AH,AL
  AND AH,32
  {$IFOPT G+}SHR AL,2{$ELSE}SHR AL,1;SHR AL,1{$ENDIF}
  AND AL,4
  OR  AH,AL
  LODSB {Vert}
  {$IFOPT G+}SHR AL,3{$ELSE}SHR AL,1;SHR AL,1;SHR AL,1{$ENDIF}
  MOV BH,AL
  AND BH,16
  OR  AH,BH
  {$IFOPT G+}SHR AL,2{$ELSE}SHR AL,1;SHR AL,1{$ENDIF}
  AND AL,2
  OR  AH,AL
  LODSB{Bleu}
  {$IFOPT G+}SHR AL,4{$ELSE}SHR AL,1;SHR AL,1;SHR AL,1;SHR AL,1{$ENDIF}
  MOV BH,AL
  AND BH,8
  OR  AH,BH
  {$IFOPT G+}SHR AL,2{$ELSE}SHR AL,1;SHR AL,1{$ENDIF}
  MOV BH,AL
  AND AL,1
  OR  AH,AL
  CMP PhysVideo.PIV.EGA,Ya;JE @EGA
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

Procedure VPan14;Assembler;ASM
 DB 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13  { 14 }
 DB 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13  { 28 }
 DB 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13  { 42 }
 DB 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13  { 56 }
 DB 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13  { 70 }
 DB 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13  { 84 }
 DB 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13  { 98 }
 DB 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13  { 112 }
 DB 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13  { 126 }
 DB 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13  { 140 }
 DB 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13  { 154 }
 DB 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13  { 168 }
 DB 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13  { 182 }
 DB 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13  { 196 }
 DB 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13  { 210 }
 DB 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13  { 224 }
 DB 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13  { 238 }
 DB 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13  { 252 }
 DB 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13  { 266 }
 DB 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13  { 280 }
 DB 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13  { 294 }
 DB 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13  { 308 }
 DB 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13  { 322 }
 DB 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13  { 336 }
 DB 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13  { 350 }
 DB 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13  { 364 }
 DB 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13  { 378 }
 DB 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13  { 392 }
 DB 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13  { 406 }
 DB 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13  { 420 }
 DB 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13  { 434 }
 DB 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13  { 448 }
 DB 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13  { 462 }
 DB 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13  { 476 }
 DB 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13  { 490 }
 DB 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13  { 504 }
END;

Procedure VPanLn14;Assembler;ASM
 DB 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  0,  0,  0   { 14 }
 DB 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,  1,  1,  1   { 28 }
 DB 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2,  2,  2,  2   { 42 }
 DB 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3,  3,  3,  3   { 56 }
 DB 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4,  4,  4,  4   { 70 }
 DB 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5,  5,  5,  5   { 84 }
 DB 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6,  6,  6,  6   { 98 }
 DB 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7,  7,  7,  7   { 112 }
 DB 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8,  8,  8,  8   { 126 }
 DB 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9,  9,  9,  9   { 140 }
 DB 10,10,10,10,10,10,10,10,10,10,10, 10, 10, 10  { 154 }
 DB 11,11,11,11,11,11,11,11,11,11,11, 11, 11, 11  { 168 }
 DB 12,12,12,12,12,12,12,12,12,12,12, 12, 12, 12  { 182 }
 DB 13,13,13,13,13,13,13,13,13,13,13, 13, 13, 13  { 196 }
 DB 14,14,14,14,14,14,14,14,14,14,14, 14, 14, 14  { 210 }
 DB 15,15,15,15,15,15,15,15,15,15,15, 15, 15, 15  { 224 }
 DB 16,16,16,16,16,16,16,16,16,16,16, 16, 16, 16  { 238 }
 DB 17,17,17,17,17,17,17,17,17,17,17, 17, 17, 17  { 252 }
 DB 18,18,18,18,18,18,18,18,18,18,18, 18, 18, 18  { 266 }
 DB 19,19,19,19,19,19,19,19,19,19,19, 19, 19, 19  { 280 }
 DB 20,20,20,20,20,20,20,20,20,20,20, 20, 20, 20  { 294 }
 DB 21,21,21,21,21,21,21,21,21,21,21, 21, 21, 21  { 308 }
 DB 22,22,22,22,22,22,22,22,22,22,22, 22, 22, 22  { 322 }
 DB 23,23,23,23,23,23,23,23,23,23,23, 23, 23, 23  { 336 }
 DB 24,24,24,24,24,24,24,24,24,24,24, 24, 24, 24  { 350 }
 DB 25,25,25,25,25,25,25,25,25,25,25, 25, 25, 25  { 364 }
 DB 26,26,26,26,26,26,26,26,26,26,26, 26, 26, 26  { 378 }
 DB 27,27,27,27,27,27,27,27,27,27,27, 27, 27, 27  { 392 }
 DB 28,28,28,28,28,28,28,28,28,28,28, 28, 28, 28  { 406 }
 DB 29,29,29,29,29,29,29,29,29,29,29, 29, 29, 29  { 420 }
 DB 30,30,30,30,30,30,30,30,30,30,30, 30, 30, 30  { 434 }
 DB 31,31,31,31,31,31,31,31,31,31,31, 31, 31, 31  { 448 }
 DB 32,32,32,32,32,32,32,32,32,32,32, 32, 32, 32  { 462 }
 DB 33,33,33,33,33,33,33,33,33,33,33, 33, 33, 33  { 476 }
 DB 34,34,34,34,34,34,34,34,34,34,34, 34, 34, 34  { 490 }
 DB 35,35,35,35,35,35,35,35,35,35,35, 35, 35, 35  { 504 }
END;

Procedure HoriData;Assembler;ASM;DW 0;DB 0;END;
Procedure Start;Assembler;ASM;DW 0,0;END;
Procedure Stool;Assembler;ASM;DW 0;END;

(*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                       Proc‚dure SetVerticalScaleTxt                  Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette proc‚dure permet d'effectuer un d‚filement de l'‚cran en ‚cran de
  texte pixel par pixel si une carte VGA est install‚e sur la machine.


  Remarques
  ÍÍÍÍÍÍÍÍÍ

   ş Pour ‚viter d'affronter une division par 0 … l'int‚rieur d'un Pilote,
     ainsi que pour augmenter les performances  (avec un 8088 une division
     prend quelque chose comme  194 cycles d'horloge contre ñ20 pour SHR),
     j'utilise des d‚calages de bits  et des constantes pour contourner le
     problŠme,  mais  soyez sans crainte, l'unit‚ peut cependant supporter
     jusqu'… 12000 octets  sans  que cela  ne cause problŠme  avec l'unit‚
     ®AdŠle¯.

   ş Grosomodo, la technique pour produire l'effet est la combinaison de 3
     registre d'entr‚e/sortie: 0Ch, 0Dh et 08h, par le port 3?4h/3?5h.  Le
     reste c'est juste au forme  de compatibilit‚ avec les  autres  effets
     d'animations simultan‚es  (genre la page  de fond  bouge en diagonale,
     pendant qu'une fenˆtre par dessus monte et descend avec 2 curseurs...).

     En Pascal ‡a aurait la forme suivante:
     ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
     ³ Procedure SetVerticaleScale(Y:Word);Var Offset:Word;Begin         ³
     ³  Offset:=Y*MemW[$0040:$4A];                                       ³
     ³  Port[MemW[$0040:$63]]:=$0C;                                      ³
     ³  Port[MemW[$0040:$63]+1]:=Hi(Offset);                             ³
     ³  Port[MemW[$0040:$63]]:=$0D;                                      ³
     ³  Port[MemW[$0040:$63]+1]:=Lo(Offset);                             ³
     ³  Repeat Until Port[MemW[$0040:$63]+6]and 8=8; { WaitRetrace;}     ³
     ³  Port[MemW[$0040:$63]]:=8;                                        ³
     ³  Port[MemW[$0040:$63]+1]:=Y mod Mem[$0040:$84];                   ³
     ³ End;                                                              ³
     ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

     En Turbo Basic/QBasic/QuickBasic:
     ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
     ³ DECLARE SUB SetVerticaleScale(Y)                                  ³
     ³  DEF SEG=&H0040:DEF FNPeekW(X)=PEEK(X)+PEEK(X+1)*256              ³
     ³  Offset=Y*FNPeekW(&H4A)                                           ³
     ³  OUT FNPeekW(&H63),&H0C:OUT FNPeekW(&H63)+1,Offset DIV 256        ³
     ³  OUT FNPeekW(&H63),&H0D:OUT FNPeekW(&H63)+1,Offset AND &HFF       ³
     ³  Ok=INP(FNPeekW(&H63)+6))                                         ³
     ³  WHILE Ok AND 8:Ok=INP(FNPeekW(&H63)+6)):WEND                     ³
     ³  OUT FNPeekW(&H0x63),8                                            ³
     ³  OUT FNPeekW(&H63)+1,Y MOD PEEK(&H84))                            ³
     ³ END SUB                                                           ³
     ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

     Tandis qu'en C/C++:
     ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
     ³ void SetVerticaleScale(unsigned Y){                               ³
     ³  unsigned Offset=Y*peek(0x0040,0x4A);                             ³
     ³  outportb(peek(0x0040,0x63),0x0C);                                ³
     ³  outportb(peek(0x0040,0x63)+1,Offset<<8);                         ³
     ³  outportb(peek(0x0040,0x63),0x0D);                                ³
     ³  outportb(peek(0x0040,0x63)+1,Offset&0xFF);                       ³
     ³  while{} do inportb(peek(0x0040,0x63)+6)&8==8; // WaitRetrace;    ³
     ³  outportb(peek(0x0040,0x63),8);                                   ³
     ³  outportb(peek(0x0040,0x63)+1,Y%peekb(0x0040,0x84));              ³
     ³ }                                                                 ³
     ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*)

Procedure SetVerticalScaleTxt(Y:Word);Assembler;ASM
 {$IFNDEF OptimizeSize}
 MOV BL,DataVideo.MIV.HeightChar
 XOR BH,BH
 SHL BX,1
 JMP @CharScale.Word[BX]
@CharScale:
 DW Offset @End, Offset @End, Offset @2,  Offset @3, Offset @4,  Offset @3
 DW Offset @3,   Offset @3,   Offset @8,  Offset @3, Offset @3,  Offset @3
 DW Offset @3,   Offset @3,   Offset @14, Offset @3, Offset @16, Offset @3
 DW Offset @3,   Offset @3,   Offset @3,  Offset @3, Offset @3,  Offset @3
 DW Offset @3,   Offset @3,   Offset @3,  Offset @3, Offset @3,  Offset @3
 DW Offset @3,   Offset @3,   Offset @3,  Offset @3
@2:
 {$IFDEF DPMI}
  MOV ES,Seg0040
  MOV DX,ES:[0063h]
 {$ELSE}
  {$IFOPT G+}
   PUSH 0
   POP ES
  {$ELSE}
   XOR AX,AX
   MOV ES,AX
  {$ENDIF}
  MOV DX,ES:[463h]
 {$ENDIF}
 MOV BX,Y
 AND BL,0FEh
 MOV CX,Word Ptr RawTxtY[BX];MOV Word Ptr Start[2],CX
 ADD CX,Word Ptr HoriData;   MOV Word Ptr Start,CX
 MOV AL,0Ch;MOV AH,CH;OUT DX,AX
 MOV AL,0Dh;MOV AH,CL;OUT DX,AX
 ADD DX,6
@2z:
 IN  AL,DX
 TEST AL,8;JZ @2z
 SUB DX,6
 MOV BX,Y
 MOV AL,8;MOV AH,BL
 AND AH,1
 CMP PhysVideo.PIV.EGA,0;JE @2b
 OUT DX,AX
@2b:
 JMP @End
 {$ENDIF}
@3: { @Default}
 {$IFDEF DPMI}
  MOV ES,Seg0040
  MOV DX,ES:[0063h]
 {$ELSE}
  {$IFOPT G+}PUSH 0;POP ES{$ELSE}XOR AX,AX;MOV ES,AX{$ENDIF}
  MOV DX,ES:[463h]
 {$ENDIF}
 MOV BX,Y
 MOV AX,BX
 DIV DataVideo.MIV.HeightChar
 MOV AL,8
 MOV CL,AL
 MOV AL,DataVideo.MIV.NumXTexts
 MUL CL
 MOV CX,AX
 MOV Word Ptr Start[2],CX
 ADD CX,Word Ptr HoriData
 MOV Word Ptr Start,CX
 MOV AL,0Ch
 MOV AH,CH
 OUT DX,AX
 MOV AL,0Dh
 MOV AH,CL
 OUT DX,AX
 ADD DX,6
@3z:
 IN  AL,DX
 TEST AL,8
 JZ @3z
 SUB DX,6
 MOV BX,Y
 MOV AX,BX
 DIV DataVideo.MIV.HeightChar
 MOV AL,8
 MOV CL,AL
 CMP PhysVideo.PIV.EGA,0
 JE @3b
 OUT DX,AX
 {$IFNDEF OptimizeSize}
@3b:
 JMP @End
@4:
 {$IFDEF DPMI}
  MOV ES,Seg0040
  MOV DX,ES:[0063h]
 {$ELSE}
  {$IFOPT G+}
   PUSH 0
   POP ES
  {$ELSE}
   XOR AX,AX
   MOV ES,AX
  {$ENDIF}
  MOV DX,ES:[463h]
 {$ENDIF}
 MOV BX,Y
 {$IFOPT G+}
  SHR BX,3
 {$ELSE}
  SHR BX,1
  SHR BX,1
  SHL BX,1
 {$ENDIF}
 MOV CX,Word Ptr RawTxtY[BX]
 MOV Word Ptr Start[2],CX
 ADD CX,Word Ptr HoriData
 MOV Word Ptr Start,CX
 MOV AL,0Ch
 MOV AH,CH
 OUT DX,AX
 MOV AL,0Dh
 MOV AH,CL
 OUT DX,AX
 ADD DX,6
@4z:
 IN AL,DX
 TEST AL,8;JZ @4z
 SUB DX,6
 MOV BX,Y
 MOV AL,8
 MOV AH,BL
 AND AH,3
 CMP PhysVideo.PIV.EGA,0;JE @4b
 OUT DX,AX
@4b:
 JMP @End
@8:
 {$IFDEF DPMI}
  MOV ES,Seg0040
  MOV DX,ES:[0063h]
 {$ELSE}
  {$IFOPT G+}PUSH 0;POP ES{$ELSE}XOR AX,AX;MOV ES,AX{$ENDIF}
  MOV DX,ES:[463h]
 {$ENDIF}
 MOV BX,Y
 {$IFOPT G+}SHR BX,3{$ELSE}SHR BX,1;SHR BX,1;SHR BX,1{$ENDIF}
 SHL BX,1
 MOV CX,Word Ptr RawTxtY[BX];MOV Word Ptr Start[2],CX
 ADD CX,Word Ptr HoriData;   MOV Word Ptr Start,CX
 MOV AL,0Ch;MOV AH,CH;OUT DX,AX
 MOV AL,0Dh;MOV AH,CL;OUT DX,AX
 ADD DX,6
@8z:
 IN AL,DX
 TEST AL,8;JZ @8z
 SUB DX,6
 MOV BX,Y
 MOV AL,8
 MOV AH,BL
 AND AH,7
 CMP PhysVideo.PIV.EGA,0;JE @8b
 OUT DX,AX
@8b:
 JMP @End
@14:
 {$IFDEF DPMI}
  MOV ES,Seg0040
  MOV DX,ES:[0063h]
 {$ELSE}
  {$IFOPT G+}PUSH 0;POP ES{$ELSE}XOR AX,AX;MOV ES,AX{$ENDIF}
  MOV DX,ES:[463h]
 {$ENDIF}
 MOV BX,Y
 MOV BL,Byte Ptr VPanLn14[BX];XOR BH,BH
 SHL BX,1
 MOV CX,Word Ptr RawTxtY[BX];MOV Word Ptr Start[2],CX
 ADD CX,Word Ptr HoriData;   MOV Word Ptr Start,CX
 MOV AL,0Ch;MOV AH,CH;OUT DX,AX
 MOV AL,0Dh;MOV AH,CL;OUT DX,AX
 ADD DX,6
@14z:
 IN AL,DX
 TEST AL,8;JZ @14z
 SUB DX,6
 MOV BX,Y
 MOV AL,8;MOV AH,Byte Ptr VPan14[BX]
 CMP PhysVideo.PIV.EGA,0;JE @14b
 OUT DX,AX
@14b:
 JMP @End
@16:
  {$IFDEF DPMI}
  MOV ES,Seg0040
  MOV DX,ES:[0063h]
 {$ELSE}
  {$IFOPT G+}PUSH 0;POP ES{$ELSE}XOR AX,AX;MOV ES,AX{$ENDIF}
  MOV DX,ES:[463h]
 {$ENDIF}
 MOV BX,Y
 {$IFOPT G+}SHR BX,4{$ELSE}MOV CL,4;SHR BX,CL{$ENDIF}
 SHL BX,1
 MOV CX,Word Ptr RawTxtY[BX];MOV Word Ptr Start[2],CX
 ADD CX,Word Ptr HoriData;   MOV Word Ptr Start,CX
 MOV AL,0Ch;MOV AH,CH;OUT DX,AX
 MOV AL,0Dh;MOV AH,CL;OUT DX,AX
 ADD DX,6
@16z:
 IN AL,DX
 TEST AL,8;JZ @16z
 SUB DX,6
 MOV BX,Y
 MOV AL,8;MOV AH,BL
 AND AH,0Fh
 CMP PhysVideo.PIV.EGA,0;JE @16b
 OUT DX,AX
@16b:
 {$ENDIF}
@End:
 ADD DX,6
@zz:
 IN AL,DX
 TEST AL,8;JNZ @zz
 CLI;MOV AX,ES:[046Ch];STI
 MOV Word Ptr Stool,AX
END;

Procedure Nine;Assembler;ASM
 DB 0,0,0,0,0,0,0,0,0, 1,1,1,1,1,1,1,1,1, 2,2,2,2,2,2,2,2,2 { 27 }
 DB 3,3,3,3,3,3,3,3,3, 4,4,4,4,4,4,4,4,4, 5,5,5,5,5,5,5,5,5 { 54 }
 DB 6,6,6,6,6,6,6,6,6, 7,7,7,7,7,7,7,7,7, 8,8,8,8,8,8,8,8,8 { 81 }
 DB 9,9,9,9,9,9,9,9,9                                       { 90 }
 DB 10,10,10,10,10,10,10,10,10, 11,11,11,11,11,11,11,11,11  { 108 }
 DB 12,12,12,12,12,12,12,12,12, 13,13,13,13,13,13,13,13,13  { 126 }
 DB 14,14,14,14,14,14,14,14,14, 15,15,15,15,15,15,15,15,15  { 144 }
 DB 16,16,16,16,16,16,16,16,16, 17,17,17,17,17,17,17,17,17  { 162 }
 DB 18,18,18,18,18,18,18,18,18, 19,19,19,19,19,19,19,19,19  { 180 }
 DB 20,20,20,20,20,20,20,20,20, 21,21,21,21,21,21,21,21,21  { 198 }
 DB 22,22,22,22,22,22,22,22,22, 23,23,23,23,23,23,23,23,23  { 216 }
 DB 24,24,24,24,24,24,24,24,24, 25,25,25,25,25,25,25,25,25  { 234 }
 DB 26,26,26,26,26,26,26,26,26, 27,27,27,27,27,27,27,27,27  { 252 }
 DB 28,28,28,28,28,28,28,28,28, 29,29,29,29,29,29,29,29,29  { 270 }
 DB 30,30,30,30,30,30,30,30,30, 31,31,31,31,31,31,31,31,31  { 288 }
 DB 32,32,32,32,32,32,32,32,32, 33,33,33,33,33,33,33,33,33  { 306 }
 DB 34,34,34,34,34,34,34,34,34, 35,35,35,35,35,35,35,35,35  { 324 }
 DB 36,36,36,36,36,36,36,36,36, 37,37,37,37,37,37,37,37,37  { 342 }
 DB 38,38,38,38,38,38,38,38,38, 39,39,39,39,39,39,39,39,39  { 360 }
 DB 40,40,40,40,40,40,40,40,40, 41,41,41,41,41,41,41,41,41  { 378 }
 DB 42,42,42,42,42,42,42,42,42, 43,43,43,43,43,43,43,43,43  { 396 }
 DB 44,44,44,44,44,44,44,44,44, 45,45,45,45,45,45,45,45,45  { 414 }
 DB 46,46,46,46,46,46,46,46,46, 47,47,47,47,47,47,47,47,47  { 432 }
 DB 48,48,48,48,48,48,48,48,48, 49,49,49,49,49,49,49,49,49  { 450 }
 DB 50,50,50,50,50,50,50,50,50, 51,51,51,51,51,51,51,51,51  { 468 }
 DB 52,52,52,52,52,52,52,52,52, 53,53,53,53,53,53,53,53,53  { 486 }
 DB 54,54,54,54,54,54,54,54,54, 55,55,55,55,55,55,55,55,55  { 504 }
 DB 56,56,56,56,56,56,56,56,56, 57,57,57,57,57,57,57,57,57  { 522 }
 DB 58,58,58,58,58,58,58,58,58, 59,59,59,59,59,59,59,59,59  { 540 }
 DB 60,60,60,60,60,60,60,60,60, 61,61,61,61,61,61,61,61,61  { 558 }
 DB 62,62,62,62,62,62,62,62,62, 63,63,63,63,63,63,63,63,63  { 576 }
 DB 64,64,64,64,64,64,64,64,64, 65,65,65,65,65,65,65,65,65  { 594 }
 DB 66,66,66,66,66,66,66,66,66, 67,67,67,67,67,67,67,67,67  { 612 }
 DB 68,68,68,68,68,68,68,68,68, 69,69,69,69,69,69,69,69,69  { 630 }
 DB 70,70,70,70,70,70,70,70,70, 71,71,71,71,71,71,71,71,71  { 648 }
 DB 72,72,72,72,72,72,72,72,72, 73,73,73,73,73,73,73,73,73  { 666 }
 DB 74,74,74,74,74,74,74,74,74, 75,75,75,75,75,75,75,75,75  { 684 }
 DB 76,76,76,76,76,76,76,76,76, 77,77,77,77,77,77,77,77,77  { 702 }
 DB 78,78,78,78,78,78,78,78,78, 79,79,79,79,79,79,79,79,79  { 720 }
 DB 80,80,80,80,80,80,80,80,80, 81,81,81,81,81,81,81,81,81  { 738 }
 DB 82,82,82,82,82,82,82,82,82, 83,83,83,83,83,83,83,83,83  { 738 }
 DB 84,84,84,84,84,84,84,84,84, 85,85,85,85,85,85,85,85,85  { 756 }
 DB 86,86,86,86,86,86,86,86,86, 87,87,87,87,87,87,87,87,87  { 774 }
 DB 88,88,88,88,88,88,88,88,88, 89,89,89,89,89,89,89,89,89  { 792 }
 DB 90,90,90,90,90,90,90,90,90, 91,91,91,91,91,91,91,91,91  { 810 }
 DB 92,92,92,92,92,92,92,92,92, 93,93,93,93,93,93,93,93,93  { 828 }
 DB 94,94,94,94,94,94,94,94,94, 95,95,95,95,95,95,95,95,95  { 846 }
 DB 96,96,96,96,96,96,96,96,96, 97,97,97,97,97,97,97,97,97  { 864 }
 DB 98,98,98,98,98,98,98,98,98, 99,99,99,99,99,99,99,99,99  { 882 }
 DB 100,100,100,100,100,100,100,100,100, 101,101,101,101,101,101,101,101,101 { 900 }
 DB 102,102,102,102,102,102,102,102,102, 103,103,103,103,103,103,103,103,103 { 918 }
 DB 104,104,104,104,104,104,104,104,104, 105,105,105,105,105,105,105,105,105 { 936 }
 DB 106,106,106,106,106,106,106,106,106, 107,107,107,107,107,107,107,107,107 { 954 }
 DB 108,108,108,108,108,108,108,108,108, 109,109,109,109,109,109,109,109,109 { 972 }
 DB 110,110,110,110,110,110,110,110,110, 111,111,111,111,111,111,111,111,111 { 990 }
 DB 112,112,112,112,112,112,112,112,112, 113,113,113,113,113,113,113,113,113 { 1008}
 DB 114,114,114,114,114,114,114,114,114, 115,115,115,115,115,115,115,115,115 { 1026}
 DB 116,116,116,116,116,116,116,116,116, 117,117,117,117,117,117,117,117,117 { 1044}
 DB 118,118,118,118,118,118,118,118,118, 119,119,119,119,119,119,119,119,119 { 1062}
 DB 120,120,120,120,120,120,120,120,120, 121,121,121,121,121,121,121,121,121 { 1080}
 DB 122,122,122,122,122,122,122,122,122, 123,123,123,123,123,123,123,123,123 { 1098}
 DB 124,124,124,124,124,124,124,124,124, 125,125,125,125,125,125,125,125,125 { 1116}
 DB 126,126,126,126,126,126,126,126,126, 127,127,127,127,127,127,127,127,127 { 1134}
 DB 128,128,128,128,128,128,128,128,128, 129,129,129,129,129,129,129,129,129 { 1152}
 DB 130,130,130,130,130,130,130,130,130, 131,131,131,131,131,131,131,131,131 { 1170}
 DB 132,132,132,132,132,132,132,132,132, 133,133,133,133,133,133,133,133,133 { 1188}
 DB 134,134,134,134,134,134,134,134,134, 135,135,135,135,135,135,135,135,135 { 1206}
 DB 136,136,136,136,136,136,136,136,136, 137,137,137,137,137,137,137,137,137 { 1224}
 DB 138,138,138,138,138,138,138,138,138, 139,139,139,139,139,139,139,139,139 { 1242}
 DB 140,140,140,140,140,140,140,140,140, 141,141,141,141,141,141,141,141,141 { 1260}
 DB 142,142,142,142,142,142,142,142,142, 143,143,143,143,143,143,143,143,143 { 1278}
 DB 144,144,144,144,144,144,144,144,144, 145,145,145,145,145,145,145,145,145 { 1296}
 DB 146,146,146,146,146,146,146,146,146, 147,147,147,147,147,147,147,147,147 { 1314}
END;

Procedure ResteNine;Assembler;ASM
 DB 8
 DB 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8 { 28 }
 DB 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8 { 55 }
 DB 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8 { 82 }
 DB 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8 { 109 }
 DB 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8 { 136 }
 DB 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8 { 163 }
 DB 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8 { 190 }
 DB 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8 { 217 }
 DB 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8 { 244 }
 DB 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8 { 271 }
 DB 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8 { 298 }
 DB 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8 { 325 }
 DB 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8 { 352 }
 DB 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8 { 379 }
 DB 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8 { 406 }
 DB 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8 { 433 }
 DB 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8 { 460 }
 DB 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8 { 487 }
 DB 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8 { 514 }
 DB 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8 { 541 }
 DB 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8 { 568 }
 DB 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8 { 595 }
 DB 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8 { 622 }
 DB 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8 { 649 }
 DB 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8 { 676 }
 DB 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8 { 703 }
 DB 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8 { 730 }
 DB 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8 { 757 }
 DB 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8 { 784 }
 DB 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8 { 811 }
 DB 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8 { 838 }
 DB 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8 { 865 }
 DB 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8 { 892 }
 DB 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8 { 919 }
 DB 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8 { 946 }
 DB 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8 { 973 }
 DB 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8 { 1000}
 DB 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8 { 1028}
 DB 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8 { 1055}
 DB 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8 { 1082}
 DB 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8 { 1109}
 DB 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8 { 1136}
 DB 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8 { 1163}
 DB 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8 { 1190}
 DB 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8 { 1217}
 DB 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8 { 1244}
 DB 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8 { 1271}
 DB 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8 { 1298}
 DB 0,1,2,3,4,5,6,7,8, 0,1,2,3,4,5,6,7,8                    { 1316}
END;

Procedure SetHorizontalScaleTxt(X:Wd);Assembler;ASM
 MOV BX,X
 MOV AL,Byte Ptr Nine[BX];MOV Byte Ptr HoriData,AL
 {$IFDEF DPMI}
  MOV ES,Seg0040
 {$ELSE}
  {$IFOPT G+}PUSH 0;POP ES{$ELSE}XOR BX,BX;MOV ES,BX{$ENDIF}
 {$ENDIF}
 MOV BX,Word Ptr Stool
 CLI
 {$IFDEF DPMI}
  CMP BX,ES:[006Ch]
 {$ELSE}
  CMP BX,ES:[046Ch]
 {$ENDIF}
 STI
 JE @1
 XOR AH,AH
 ADD AX,Word Ptr Start[2]
 MOV CX,AX
 {$IFDEF DPMI}
  MOV DX,ES:[0063h]
 {$ELSE}
  MOV DX,ES:[0463h]
 {$ENDIF}
 ADD DX,6
@W1:
 IN AL,DX
 TEST AL,8;JNZ @W1
 SUB DX,6
 MOV AL,0Ch
 MOV AH,CH
 OUT DX,AX
 MOV AL,0Dh
 MOV AH,CL
 OUT DX,AX
 ADD DX,6
@W2:
 IN AL,DX
 TEST AL,8;JZ @W2
@1:
 MOV DX,3C0h                 {Index/Data Port de l'ATC}
 MOV AL,13h or 32d           {s‚lectionne le registre 13h (Horizontal Pixel Paning)}
 OUT DX,AL                   {met … 1 le bit 5 (Palette RAM Address Source)}
 MOV BX,X                    { pour ne pas couper l'‚cran }
 MOV AL,Byte Ptr ResteNine[BX]
 OR  AL,32d                  {fixe le d‚placement panoramique }
 OUT DX,AL
END;

Procedure SetPgTxt(Pg:Byte);Assembler;ASM
 MOV BL,Pg
 MOV BH,0
 MOV DataVideo.MIV.Pg,BL
 MOV AL,DataVideo.MIV.NumXTexts
 MUL DataVideo.MIV.NumYTexts
 MUL BX
 SHL AX,1
 MOV DataVideo.MIV.AddrPage,AX
 MOV Word Ptr Start[2],AX
 MOV CX,128
 MOV BX,Offset RawTxtY
 MOV DX,DataVideo.MIV.BytesPerLine
 SHR DX,1
@L:
 MOV CS:[BX],AX
 INC BX
 INC BX
 ADD AX,DX
 AND AX,07FFFh
 LOOP @L
END;

Procedure Underline;Assembler;ASM
 DB 0
END;

Procedure SetUnderlineTxt(X:Bool);Assembler;ASM
 CMP PhysVideo.PIV.CardCat,cvnEGA
 JB @1
 CMP DataVideo.MIV.Color,True
 JNE @1
 MOV AX,1103h
 MOV BL,X
 AND BL,1
 MOV Byte Ptr Underline,BL
 {$IFOPT G+}SHL BL,2{$ELSE}SHL BL,1;SHL BL,1{$ENDIF}
 INT 10h
 PUSH DS
  CLD
  PUSH CS
  POP DS
  PUSH CS
  POP ES
  XOR DI,DI
  {$IFNDEF DPMI}
   MOV SI,Offset _DriverTxtStandard
  {$ENDIF}
  CMP Byte Ptr Underline,0
  JE  @2
  {$IFNDEF DPMI}
   MOV SI,Offset _DriverTxtStandard
  {$ENDIF}
@2:
  {$IFNDEF DPMI}
   MOV CX,Offset PhysVideo-1-6
   SHR CX,1
   REP MOVSW
   ADC CX,CX
   REP MOVSB
  {$ENDIF}
 POP DS
 CMP Byte Ptr Underline,0
 JE  @1
 PUSH CS
 CALL Near Ptr SetModeMtxTxt
 {Copie la matrice}
 PUSH DS
  CLD
  MOV CX,(256*32)SHR 1
  {$IFDEF DPMI}
   MOV ES,SegA000
   PUSH ES
   POP DS
  {$ELSE}
   MOV AX,0A000h
   MOV ES,AX
   MOV DS,AX
  {$ENDIF}
  XOR SI,SI
  MOV DI,4000h
  REP MOVSW
 POP DS
 {Effectue le soulignement}
 MOV DL,DataVideo.MIV.HeightChar
 XOR DH,DH
 DEC DX
 MOV DI,DX
 {$IFDEF DPMI}
  MOV ES,SegA000
  ADD DI,04000h
 {$ELSE}
  MOV AX,0A400h
  MOV ES,AX
 {$ENDIF}
 MOV CX,256
 MOV AL,0FFh
@3:
 STOSB
 ADD DI,31
 LOOP @3
 PUSH CS
 CALL Near Ptr SetModeScrTxt
 {Fixe … 8 pixels de large}
 {$IFOPT G+}
  PUSH 8
 {$ELSE}
  MOV AX,8
  PUSH AX
 {$ENDIF}
 PUSH CS
 CALL Near Ptr SetChrWidthTxt
@1:
END;

Procedure SetVisualPgTxt(Pg:Byte);Assembler;ASM
 MOV BL,Pg
 MOV DataVideo.MIV.ShowPage,BL
 MOV BH,0
 MOV AL,DataVideo.MIV.NumXTexts
 MUL DataVideo.MIV.NumYTexts
 MUL BX
 MOV BL,AL
 MOV DH,03h
 MOV DL,DataVideo.MIV.Color
 MOV CL,5
 SHL DL,CL
 ADD DL,0B4h
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

Procedure WriteMode;Assembler;ASM
 DB 0
END;

Procedure SetWriteModeTxt(Mode:Byte);Assembler;ASM
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

Procedure SplitScreenTxt(Y:Wd);Assembler;ASM
 CMP PhysVideo.PIV.VGA,Ya;JNE @End
 {$IFOPT G+}PUSH 0;POP ES{$ELSE}XOR AX,AX;MOV ES,AX{$ENDIF}
 MOV DX,ES:[463h]
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
 MOV AL,18h;MOV AH,Byte Ptr Y;OUT DX,AX
@End:
END;

{Routine d'Icon/Luxe}
Procedure Matrix8x6Luxe;Assembler;ASM
  { #00 }
 DB 00000000B { 0 }
 DB 00000000B { 1 }
 DB 00000000B { 2 }
 DB 00000000B { 3 }
 DB 00000000B { 4 }
 DB 00000000B { 5 }
  { #01 }
 DB 10000000B { 0 }
 DB 10000000B { 1 }
 DB 10000000B { 2 }
 DB 10000000B { 3 }
 DB 10000000B { 4 }
 DB 10000000B { 5 }
  { #02 }
 DB 00000001B { 0 }
 DB 00000001B { 1 }
 DB 00000001B { 2 }
 DB 00000001B { 3 }
 DB 00000001B { 4 }
 DB 00000001B { 5 }
  { #03 }
 DB 11111111B { 0 }
 DB 00000000B { 1 }
 DB 00000000B { 2 }
 DB 00000000B { 3 }
 DB 00000000B { 4 }
 DB 00000000B { 5 }
  { #04 }
 DB 00000000B { 0 }
 DB 00000000B { 1 }
 DB 00000000B { 2 }
 DB 00000000B { 3 }
 DB 00000000B { 4 }
 DB 11111111B { 5 }
  { #05 }
 DB 10000000B { 0 }
 DB 10000000B { 1 }
 DB 10000000B { 2 }
 DB 10000000B { 3 }
 DB 10000000B { 4 }
 DB 11111111B { 5 }
  { #06 }
 DB 00000001B { 0 }
 DB 00000001B { 1 }
 DB 00000001B { 2 }
 DB 00000001B { 3 }
 DB 00000001B { 4 }
 DB 11111111B { 5 }
  { #07 }
 DB 11111111B { 0 }
 DB 00000001B { 1 }
 DB 00000001B { 2 }
 DB 00000001B { 3 }
 DB 00000001B { 4 }
 DB 00000001B { 5 }
  { #08 }
 DB 11111111B { 0 }
 DB 10000000B { 1 }
 DB 10011111B { 2 }
 DB 10011111B { 3 }
 DB 10000000B { 4 }
 DB 11111111B { 5 }
  { #09 }
 DB 11111111B { 0 }
 DB 00000001B { 1 }
 DB 11111001B { 2 }
 DB 11111001B { 3 }
 DB 00000001B { 4 }
 DB 11111111B { 5 }
  { #10 }
 DB 11111111B { 0 }
 DB 10000001B { 1 }
 DB 10000011B { 2 }
 DB 10000111B { 3 }
 DB 10000001B { 4 }
 DB 11111111B { 5 }
  { #11 }
 DB 11111111B { 0 }
 DB 10000001B { 1 }
 DB 11000001B { 2 }
 DB 11100001B { 3 }
 DB 10000001B { 4 }
 DB 11111111B { 5 }
  { #12 }
 DB 11111111B { 0 }
 DB 10000001B { 1 }
 DB 10000111B { 2 }
 DB 10000011B { 3 }
 DB 10000001B { 4 }
 DB 11111111B { 5 }
  { #13 }
 DB 11111111B { 0 }
 DB 10000001B { 1 }
 DB 11100001B { 2 }
 DB 11000001B { 3 }
 DB 10000001B { 4 }
 DB 11111111B { 5 }
  { #14 }
 DB 00011000B { 0 }
 DB 10011001B { 1 }
 DB 11100111B { 2 }
 DB 11100111B { 3 }
 DB 10111101B { 4 }
 DB 00011000B { 5 }
  { #15 }
 DB 11111111B { 0 }
 DB 10000001B { 1 }
 DB 11000001B { 2 }
 DB 11000001B { 3 }
 DB 10000001B { 4 }
 DB 11111111B { 5 }
  { #16 }
 DB 11111111B { 0 }
 DB 11100001B { 1 }
 DB 11111001B { 2 }
 DB 11111001B { 3 }
 DB 11100001B { 4 }
 DB 11111111B { 5 }
  { #17 }
 DB 11111111B { 0 }
 DB 10000111B { 1 }
 DB 10011111B { 2 }
 DB 10011111B { 3 }
 DB 10000111B { 4 }
 DB 11101111B { 5 }
  { #18 }
 DB 00011000B { 0 }
 DB 00111100B { 1 }
 DB 01111110B { 2 }
 DB 00011000B { 3 }
 DB 01111110B { 4 }
 DB 00011000B { 5 }
  { #19 }
 DB 00000111B { 0 }
 DB 00111000B { 1 }
 DB 01000000B { 2 }
 DB 01000000B { 3 }
 DB 00111000B { 4 }
 DB 00000111B { 5 }
  { #20 }
 DB 11100000B { 0 }
 DB 00011100B { 1 }
 DB 00000010B { 2 }
 DB 00000010B { 3 }
 DB 00011100B { 4 }
 DB 11100000B { 5 }
  { #21 }
 DB 00000111B { 0 }
 DB 00111000B { 1 }
 DB 01000111B { 2 }
 DB 01000111B { 3 }
 DB 00111000B { 4 }
 DB 00000111B { 5 }
  { #22 }
 DB 11100000B { 0 }
 DB 00011100B { 1 }
 DB 11100010B { 2 }
 DB 11100010B { 3 }
 DB 00011100B { 4 }
 DB 11100000B { 5 }
  { #23 }
 DB 11111111B { 0 }
 DB 10000001B { 1 }
 DB 10000011B { 2 }
 DB 10000011B { 3 }
 DB 10000001B { 4 }
 DB 11111111B { 5 }
  { #24 }
 DB 00000000B { 0 }
 DB 00000000B { 1 }
 DB 01111111B { 2 }
 DB 10000000B { 3 }
 DB 10000000B { 4 }
 DB 01111111B { 5 }
  { #25 }
 DB 00000000B { 0 }
 DB 01111100B { 1 }
 DB 10000010B { 2 }
 DB 00000001B { 3 }
 DB 00000001B { 4 }
 DB 11111110B { 5 }
  { #26 }
 DB 00000000B { 0 }
 DB 00000000B { 1 }
 DB 01111111B { 2 }
 DB 10110110B { 3 }
 DB 10000000B { 4 }
 DB 01111111B { 5 }
  { #27 }
 DB 00000000B { 0 }
 DB 01111100B { 1 }
 DB 10000010B { 2 }
 DB 01101101B { 3 }
 DB 00000001B { 4 }
 DB 11111110B { 5 }
  { #28 }
 DB 11111111B { 0 }
 DB 11111111B { 1 }
 DB 11111111B { 2 }
 DB 11111111B { 3 }
 DB 11111111B { 4 }
 DB 11111000B { 5 }
  { #29 }
 DB 00100001B { 0 }
 DB 00000101B { 1 }
 DB 00100100B { 2 }
 DB 00110010B { 3 }
 DB 00010000B { 4 }
 DB 01000010B { 5 }
  { #30 }
 DB 00001000B { 0 }
 DB 01100011B { 1 }
 DB 00010010B { 2 }
 DB 00000110B { 3 }
 DB 01000010B { 4 }
 DB 00001100B { 5 }
  { #31 }
 DB 11111111B { 0 }
 DB 10000000B { 1 }
 DB 10000000B { 2 }
 DB 10000000B { 3 }
 DB 10000000B { 4 }
 DB 10000000B { 5 }
END;

Procedure Matrix8x8Luxe;Assembler;ASM
  { #00 }
 DB 00000000B { 0 }
 DB 00000000B { 1 }
 DB 00000000B { 2 }
 DB 00000000B { 3 }
 DB 00000000B { 4 }
 DB 00000000B { 5 }
 DB 00000000B { 6 }
 DB 00000000B { 7 }
  { #01 }
 DB 10000000B { 0 }
 DB 10000000B { 1 }
 DB 10000000B { 2 }
 DB 10000000B { 3 }
 DB 10000000B { 4 }
 DB 10000000B { 5 }
 DB 10000000B { 6 }
 DB 10000000B { 7 }
  { #02 }
 DB 00000001B { 0 }
 DB 00000001B { 1 }
 DB 00000001B { 2 }
 DB 00000001B { 3 }
 DB 00000001B { 4 }
 DB 00000001B { 5 }
 DB 00000001B { 6 }
 DB 00000001B { 7 }
  { #03 }
 DB 11111111B { 0 }
 DB 00000000B { 1 }
 DB 00000000B { 2 }
 DB 00000000B { 3 }
 DB 00000000B { 4 }
 DB 00000000B { 5 }
 DB 00000000B { 6 }
 DB 00000000B { 7 }
  { #04 }
 DB 00000000B { 0 }
 DB 00000000B { 1 }
 DB 00000000B { 2 }
 DB 00000000B { 3 }
 DB 00000000B { 4 }
 DB 00000000B { 5 }
 DB 00000000B { 6 }
 DB 11111111B { 7 }
  { #05 }
 DB 10000000B { 0 }
 DB 10000000B { 1 }
 DB 10000000B { 2 }
 DB 10000000B { 3 }
 DB 10000000B { 4 }
 DB 10000000B { 5 }
 DB 10000000B { 6 }
 DB 11111111B { 7 }
  { #06 }
 DB 00000001B { 0 }
 DB 00000001B { 1 }
 DB 00000001B { 2 }
 DB 00000001B { 3 }
 DB 00000001B { 4 }
 DB 00000001B { 5 }
 DB 00000001B { 6 }
 DB 11111111B { 7 }
  { #07 }
 DB 11111111B { 0 }
 DB 00000001B { 1 }
 DB 00000001B { 2 }
 DB 00000001B { 3 }
 DB 00000001B { 4 }
 DB 00000001B { 5 }
 DB 00000001B { 6 }
 DB 00000001B { 7 }
  { #08 }
 DB 11111111B { 0 }
 DB 10000000B { 1 }
 DB 10000000B { 2 }
 DB 10011111B { 3 }
 DB 10011111B { 4 }
 DB 10000000B { 5 }
 DB 10000000B { 6 }
 DB 11111111B { 7 }
  { #09 }
 DB 11111111B { 0 }
 DB 00000001B { 1 }
 DB 00000001B { 2 }
 DB 11111001B { 3 }
 DB 11111001B { 4 }
 DB 00000001B { 5 }
 DB 00000001B { 6 }
 DB 11111111B { 7 }
  { #10 }
 DB 11111111B { 0 }
 DB 10000000B { 1 }
 DB 10000001B { 2 }
 DB 10000011B { 3 }
 DB 10000111B { 4 }
 DB 10000001B { 5 }
 DB 10000000B { 6 }
 DB 11111111B { 7 }
  { #11 }
 DB 11111111B { 0 }
 DB 00000001B { 1 }
 DB 10000001B { 2 }
 DB 11000001B { 3 }
 DB 11100001B { 4 }
 DB 10000001B { 5 }
 DB 00000001B { 6 }
 DB 11111111B { 7 }
  { #12 }
 DB 11111111B { 0 }
 DB 10000000B { 1 }
 DB 10000001B { 2 }
 DB 10000111B { 3 }
 DB 10000011B { 4 }
 DB 10000001B { 5 }
 DB 10000000B { 6 }
 DB 11111111B { 7 }
  { #13 }
 DB 11111111B { 0 }
 DB 00000001B { 1 }
 DB 10000001B { 2 }
 DB 11100001B { 3 }
 DB 11000001B { 4 }
 DB 10000001B { 5 }
 DB 00000001B { 6 }
 DB 11111111B { 7 }
  { #14 }
 DB 00011000B { 0 }
 DB 10011001B { 1 }
 DB 01111110B { 2 }
 DB 11100111B { 3 }
 DB 01100110B { 4 }
 DB 11100111B { 5 }
 DB 00111100B { 6 }
 DB 00011000B { 7 }
  { #15 }
 DB 11111111B { 0 }
 DB 00000001B { 1 }
 DB 10000001B { 2 }
 DB 11000001B { 3 }
 DB 11000001B { 4 }
 DB 10000001B { 5 }
 DB 00000001B { 6 }
 DB 11111111B { 7 }
  { #16 }
 DB 11111111B { 0 }
 DB 00000001B { 1 }
 DB 11100001B { 2 }
 DB 11111001B { 3 }
 DB 11111001B { 4 }
 DB 11100001B { 5 }
 DB 00000001B { 6 }
 DB 11111111B { 7 }
  { #17 }
 DB 11111111B { 0 }
 DB 10000000B { 1 }
 DB 10000111B { 2 }
 DB 10011111B { 3 }
 DB 10011111B { 4 }
 DB 10000111B { 5 }
 DB 10000000B { 6 }
 DB 11101111B { 7 }
  { #18 }
 DB 00011000B { 0 }
 DB 00111100B { 1 }
 DB 01111110B { 2 }
 DB 00011000B { 3 }
 DB 00011000B { 4 }
 DB 01111110B { 5 }
 DB 00111100B { 6 }
 DB 00011000B { 7 }
  { #19 }
 DB 00000111B { 0 }
 DB 00111000B { 1 }
 DB 01000000B { 2 }
 DB 11000000B { 3 }
 DB 11000000B { 4 }
 DB 01000000B { 5 }
 DB 00111000B { 6 }
 DB 00000111B { 7 }
  { #20 }
 DB 11100000B { 0 }
 DB 00011100B { 1 }
 DB 00000010B { 2 }
 DB 00000011B { 3 }
 DB 00000011B { 4 }
 DB 00000010B { 5 }
 DB 00011100B { 6 }
 DB 11100000B { 7 }
  { #21 }
 DB 00000111B { 0 }
 DB 00111000B { 1 }
 DB 01000011B { 2 }
 DB 11011111B { 3 }
 DB 11011111B { 4 }
 DB 01000011B { 5 }
 DB 00111000B { 6 }
 DB 00000111B { 7 }
  { #22 }
 DB 11100000B { 0 }
 DB 00011100B { 1 }
 DB 11000010B { 2 }
 DB 11111011B { 3 }
 DB 11111011B { 4 }
 DB 11000010B { 5 }
 DB 00011100B { 6 }
 DB 11100000B { 7 }
  { #23 }
 DB 11111111B { 0 }
 DB 10000000B { 1 }
 DB 10000001B { 2 }
 DB 10000011B { 3 }
 DB 10000011B { 4 }
 DB 10000001B { 5 }
 DB 10000000B { 6 }
 DB 11111111B { 7 }
  { #24 }
 DB 00000000B { 0 }
 DB 00000000B { 1 }
 DB 00000000B { 2 }
 DB 00111111B { 3 }
 DB 01000000B { 4 }
 DB 01000000B { 5 }
 DB 00111111B { 6 }
 DB 00000000B { 7 }
  { #25 }
 DB 00000000B { 0 }
 DB 00000000B { 1 }
 DB 01111000B { 2 }
 DB 10000100B { 3 }
 DB 00000010B { 4 }
 DB 00000010B { 5 }
 DB 11111100B { 6 }
 DB 00000000B { 7 }
  { #26 }
 DB 00000000B { 0 }
 DB 00000000B { 1 }
 DB 00111111B { 2 }
 DB 01000000B { 3 }
 DB 01011101B { 4 }
 DB 01000000B { 5 }
 DB 00111111B { 6 }
 DB 00000000B { 7 }
  { #27 }
 DB 10000000B { 0 }
 DB 01111100B { 1 }
 DB 10000010B { 2 }
 DB 00000001B { 3 }
 DB 01101101B { 4 }
 DB 00000001B { 5 }
 DB 11111110B { 6 }
 DB 00000000B { 7 }
  { #28 }
 DB 11111111B { 0 }
 DB 11111111B { 1 }
 DB 11111111B { 2 }
 DB 11111111B { 3 }
 DB 11111111B { 4 }
 DB 11111111B { 5 }
 DB 11111000B { 6 }
 DB 10000000B { 7 }
  { #29 }
 DB 01000100B { 0 }
 DB 00100001B { 1 }
 DB 00000101B { 2 }
 DB 00100100B { 3 }
 DB 00110010B { 4 }
 DB 00010000B { 5 }
 DB 00001000B { 6 }
 DB 01000010B { 7 }
  { #30 }
 DB 00001000B { 0 }
 DB 10001000B { 1 }
 DB 01100011B { 2 }
 DB 00010010B { 3 }
 DB 00000110B { 4 }
 DB 00100010B { 5 }
 DB 01000010B { 6 }
 DB 00001100B { 7 }
  { #31 }
 DB 11111111B { 0 }
 DB 10000000B { 1 }
 DB 10000000B { 2 }
 DB 10000000B { 3 }
 DB 10000000B { 4 }
 DB 10000000B { 5 }
 DB 10000000B { 6 }
 DB 10000000B { 7 }
END;

Procedure Matrix8x14Luxe;Assembler;ASM
  { #00 }
 DB 00000000B { 0 }
 DB 00000000B { 1 }
 DB 00000000B { 2 }
 DB 00000000B { 3 }
 DB 00000000B { 4 }
 DB 00000000B { 5 }
 DB 00000000B { 6 }
 DB 00000000B { 7 }
 DB 00000000B { 8 }
 DB 00000000B { 9 }
 DB 00000000B { 10 }
 DB 00000000B { 11 }
 DB 00000000B { 12 }
 DB 00000000B { 13 }
  { #01 }
 DB 10000000B { 0 }
 DB 10000000B { 1 }
 DB 10000000B { 2 }
 DB 10000000B { 3 }
 DB 10000000B { 4 }
 DB 10000000B { 5 }
 DB 10000000B { 6 }
 DB 10000000B { 7 }
 DB 10000000B { 8 }
 DB 10000000B { 9 }
 DB 10000000B { 10 }
 DB 10000000B { 11 }
 DB 10000000B { 12 }
 DB 10000000B { 13 }
  { #02 }
 DB 00000001B { 0 }
 DB 00000001B { 1 }
 DB 00000001B { 2 }
 DB 00000001B { 3 }
 DB 00000001B { 4 }
 DB 00000001B { 5 }
 DB 00000001B { 6 }
 DB 00000001B { 7 }
 DB 00000001B { 8 }
 DB 00000001B { 9 }
 DB 00000001B { 10 }
 DB 00000001B { 11 }
 DB 00000001B { 12 }
 DB 00000001B { 13 }
  { #03 }
 DB 11111111B { 0 }
 DB 00000000B { 1 }
 DB 00000000B { 2 }
 DB 00000000B { 3 }
 DB 00000000B { 4 }
 DB 00000000B { 5 }
 DB 00000000B { 6 }
 DB 00000000B { 7 }
 DB 00000000B { 8 }
 DB 00000000B { 9 }
 DB 00000000B { 10 }
 DB 00000000B { 11 }
 DB 00000000B { 12 }
 DB 00000000B { 13 }
  { #04 }
 DB 00000000B { 0 }
 DB 00000000B { 1 }
 DB 00000000B { 2 }
 DB 00000000B { 3 }
 DB 00000000B { 4 }
 DB 00000000B { 5 }
 DB 00000000B { 6 }
 DB 00000000B { 7 }
 DB 00000000B { 8 }
 DB 00000000B { 9 }
 DB 00000000B { 10 }
 DB 00000000B { 11 }
 DB 00000000B { 12 }
 DB 11111111B { 13 }
  { #05 }
 DB 10000000B { 0 }
 DB 10000000B { 1 }
 DB 10000000B { 2 }
 DB 10000000B { 3 }
 DB 10000000B { 4 }
 DB 10000000B { 5 }
 DB 10000000B { 6 }
 DB 10000000B { 7 }
 DB 10000000B { 8 }
 DB 10000000B { 9 }
 DB 10000000B { 10 }
 DB 10000000B { 11 }
 DB 10000000B { 12 }
 DB 11111111B { 13 }
  { #06 }
 DB 00000001B { 0 }
 DB 00000001B { 1 }
 DB 00000001B { 2 }
 DB 00000001B { 3 }
 DB 00000001B { 4 }
 DB 00000001B { 5 }
 DB 00000001B { 6 }
 DB 00000001B { 7 }
 DB 00000001B { 8 }
 DB 00000001B { 9 }
 DB 00000001B { 10 }
 DB 00000001B { 11 }
 DB 00000001B { 12 }
 DB 11111111B { 13 }
  { #07 }
 DB 11111111B { 0 }
 DB 00000001B { 1 }
 DB 00000001B { 2 }
 DB 00000001B { 3 }
 DB 00000001B { 4 }
 DB 00000001B { 5 }
 DB 00000001B { 6 }
 DB 00000001B { 7 }
 DB 00000001B { 8 }
 DB 00000001B { 9 }
 DB 00000001B { 10 }
 DB 00000001B { 11 }
 DB 00000001B { 12 }
 DB 00000001B { 13 }
  { #08 }
 DB 11111111B { 0 }
 DB 10000000B { 1 }
 DB 10000000B { 2 }
 DB 10000000B { 3 }
 DB 10000000B { 4 }
 DB 10000000B { 5 }
 DB 10011111B { 6 }
 DB 10011111B { 7 }
 DB 10000000B { 8 }
 DB 10000000B { 9 }
 DB 10000000B { 10 }
 DB 10000000B { 11 }
 DB 10000000B { 12 }
 DB 11111111B { 13 }
  { #09 }
 DB 11111111B { 0 }
 DB 00000001B { 1 }
 DB 00000001B { 2 }
 DB 00000001B { 3 }
 DB 00000001B { 4 }
 DB 00000001B { 5 }
 DB 11111001B { 6 }
 DB 11111001B { 7 }
 DB 00000001B { 8 }
 DB 00000001B { 9 }
 DB 00000001B { 10 }
 DB 00000001B { 11 }
 DB 00000001B { 12 }
 DB 11111111B { 13 }
  { #10 }
 DB 11111111B { 0 }
 DB 10000000B { 1 }
 DB 10000001B { 2 }
 DB 10000011B { 3 }
 DB 10000111B { 4 }
 DB 10001111B { 5 }
 DB 10011111B { 6 }
 DB 10000001B { 7 }
 DB 10000001B { 8 }
 DB 10000001B { 9 }
 DB 10000001B { 10 }
 DB 10000001B { 11 }
 DB 10000000B { 12 }
 DB 11111111B { 13 }
  { #11 }
 DB 11111111B { 0 }
 DB 00000001B { 1 }
 DB 10000001B { 2 }
 DB 11000001B { 3 }
 DB 11100001B { 4 }
 DB 11110001B { 5 }
 DB 11111001B { 6 }
 DB 10000001B { 7 }
 DB 10000001B { 8 }
 DB 10000001B { 9 }
 DB 10000001B { 10 }
 DB 10000001B { 11 }
 DB 00000001B { 12 }
 DB 11111111B { 13 }
  { #12 }
 DB 11111111B { 0 }
 DB 10000000B { 1 }
 DB 10000001B { 2 }
 DB 10000001B { 3 }
 DB 10000001B { 4 }
 DB 10000001B { 5 }
 DB 10000001B { 6 }
 DB 10011111B { 7 }
 DB 10001111B { 8 }
 DB 10000111B { 9 }
 DB 10000011B { 10 }
 DB 10000001B { 11 }
 DB 10000000B { 12 }
 DB 11111111B { 13 }
  { #13 }
 DB 11111111B { 0 }
 DB 00000001B { 1 }
 DB 10000001B { 2 }
 DB 10000001B { 3 }
 DB 10000001B { 4 }
 DB 10000001B { 5 }
 DB 10000001B { 6 }
 DB 11111001B { 7 }
 DB 11110001B { 8 }
 DB 11100001B { 9 }
 DB 11000001B { 10 }
 DB 10000001B { 11 }
 DB 00000001B { 12 }
 DB 11111111B { 13 }
  { #14 }
 DB 00011000B { 0 }
 DB 00011000B { 1 }
 DB 10111101B { 2 }
 DB 01111110B { 3 }
 DB 11111111B { 4 }
 DB 01100110B { 5 }
 DB 11100111B { 6 }
 DB 01100110B { 7 }
 DB 11111111B { 8 }
 DB 01111110B { 9 }
 DB 00111100B { 10 }
 DB 00011000B { 11 }
 DB 00011000B { 12 }
 DB 00000000B { 13 }
  { #15 }
 DB 11111111B { 0 }
 DB 00000001B { 1 }
 DB 10000001B { 2 }
 DB 11000001B { 3 }
 DB 11100001B { 4 }
 DB 11110001B { 5 }
 DB 11000001B { 6 }
 DB 11000001B { 7 }
 DB 11110001B { 8 }
 DB 11100001B { 9 }
 DB 11000001B { 10 }
 DB 10000001B { 11 }
 DB 00000001B { 12 }
 DB 11111111B { 13 }
  { #16 }
 DB 11111111B { 0 }
 DB 00000001B { 1 }
 DB 10000001B { 2 }
 DB 11000001B { 3 }
 DB 11100001B { 4 }
 DB 11110001B { 5 }
 DB 11111001B { 6 }
 DB 11111001B { 7 }
 DB 11110001B { 8 }
 DB 11100001B { 9 }
 DB 11000001B { 10 }
 DB 10000001B { 11 }
 DB 00000001B { 12 }
 DB 11111111B { 13 }
  { #17 }
 DB 11111111B { 0 }
 DB 10000000B { 1 }
 DB 10000001B { 2 }
 DB 10000011B { 3 }
 DB 10000111B { 4 }
 DB 10001111B { 5 }
 DB 10011111B { 6 }
 DB 10011111B { 7 }
 DB 10001111B { 8 }
 DB 10000111B { 9 }
 DB 10000011B { 10 }
 DB 10000001B { 11 }
 DB 10000000B { 12 }
 DB 11111111B { 13 }
  { #18 }
 DB 00000000B { 0 }
 DB 00011000B { 1 }
 DB 00111100B { 2 }
 DB 01111110B { 3 }
 DB 11111111B { 4 }
 DB 00111100B { 5 }
 DB 00111100B { 6 }
 DB 00111100B { 7 }
 DB 00111100B { 8 }
 DB 11111111B { 9 }
 DB 01111110B { 10 }
 DB 00111100B { 11 }
 DB 00011000B { 12 }
 DB 00000000B { 13 }
  { #19 }
 DB 00000000B { 0 }
 DB 00000111B { 1 }
 DB 00011100B { 2 }
 DB 00110000B { 3 }
 DB 01100000B { 4 }
 DB 01000000B { 5 }
 DB 11000000B { 6 }
 DB 11000000B { 7 }
 DB 01000000B { 8 }
 DB 01100000B { 9 }
 DB 00110000B { 10 }
 DB 00011100B { 11 }
 DB 00000111B { 12 }
 DB 00000000B { 13 }
  { #20 }
 DB 00000000B { 0 }
 DB 11100000B { 1 }
 DB 00111000B { 2 }
 DB 00001100B { 3 }
 DB 00000110B { 4 }
 DB 00000010B { 5 }
 DB 00000011B { 6 }
 DB 00000011B { 7 }
 DB 00000010B { 8 }
 DB 00000110B { 9 }
 DB 00001100B { 10 }
 DB 00111000B { 11 }
 DB 11100000B { 12 }
 DB 00000000B { 13 }
  { #21 }
 DB 00000000B { 0 }
 DB 00000111B { 1 }
 DB 00011100B { 2 }
 DB 00110001B { 3 }
 DB 01100111B { 4 }
 DB 01001111B { 5 }
 DB 11011111B { 6 }
 DB 11011111B { 7 }
 DB 01001111B { 8 }
 DB 01100111B { 9 }
 DB 00110001B { 10 }
 DB 00011100B { 11 }
 DB 00000111B { 12 }
 DB 00000000B { 13 }
  { #22 }
 DB 00000000B { 0 }
 DB 11100000B { 1 }
 DB 00111000B { 2 }
 DB 10001100B { 3 }
 DB 11100110B { 4 }
 DB 11110010B { 5 }
 DB 11111011B { 6 }
 DB 11111011B { 7 }
 DB 11110010B { 8 }
 DB 11100110B { 9 }
 DB 10001100B { 10 }
 DB 00111000B { 11 }
 DB 11100000B { 12 }
 DB 00000000B { 13 }
  { #23 }
 DB 11111111B { 0 }
 DB 10000000B { 1 }
 DB 10000001B { 2 }
 DB 10000011B { 3 }
 DB 10000111B { 4 }
 DB 10001111B { 5 }
 DB 10000011B { 6 }
 DB 10000011B { 7 }
 DB 10001111B { 8 }
 DB 10000111B { 9 }
 DB 10000011B { 10 }
 DB 10000001B { 11 }
 DB 10000000B { 12 }
 DB 11111111B { 13 }
  { #24 }
 DB 00000000B { 0 }
 DB 00000000B { 1 }
 DB 00000000B { 2 }
 DB 00000000B { 3 }
 DB 00111111B { 4 }
 DB 01000000B { 5 }
 DB 01000000B { 6 }
 DB 01000000B { 7 }
 DB 01000000B { 8 }
 DB 01000000B { 9 }
 DB 01000000B { 10 }
 DB 01000000B { 11 }
 DB 00111111B { 12 }
 DB 00000000B { 13 }
  { #25 }
 DB 00000000B { 0 }
 DB 00000000B { 1 }
 DB 00111100B { 2 }
 DB 01000010B { 3 }
 DB 10000001B { 4 }
 DB 00000001B { 5 }
 DB 00000001B { 6 }
 DB 00000001B { 7 }
 DB 00000001B { 8 }
 DB 00000001B { 9 }
 DB 00000001B { 10 }
 DB 00000001B { 11 }
 DB 11111110B { 12 }
 DB 00000000B { 13 }
  { #26 }
 DB 00000000B { 0 }
 DB 00000000B { 1 }
 DB 00000000B { 2 }
 DB 00000000B { 3 }
 DB 00111111B { 4 }
 DB 01000000B { 5 }
 DB 01011111B { 6 }
 DB 01000000B { 7 }
 DB 01011111B { 8 }
 DB 01000000B { 9 }
 DB 01011111B { 10 }
 DB 01000000B { 11 }
 DB 00111111B { 12 }
 DB 00000000B { 13 }
  { #27 }
 DB 00000000B { 0 }
 DB 00000000B { 1 }
 DB 00111100B { 2 }
 DB 01000010B { 3 }
 DB 10000001B { 4 }
 DB 00000001B { 5 }
 DB 11111101B { 6 }
 DB 00000001B { 7 }
 DB 11111101B { 8 }
 DB 00000001B { 9 }
 DB 11111101B { 10 }
 DB 00000001B { 11 }
 DB 11111110B { 12 }
 DB 00000000B { 13 }
  { #28 }
 DB 11111111B { 0 }
 DB 11111111B { 1 }
 DB 11111111B { 2 }
 DB 11111111B { 3 }
 DB 11111111B { 4 }
 DB 11111111B { 5 }
 DB 11111111B { 6 }
 DB 11111111B { 7 }
 DB 11111111B { 8 }
 DB 11111111B { 9 }
 DB 11111111B { 10 }
 DB 11111100B { 11 }
 DB 11110000B { 12 }
 DB 00000000B { 13 }
  { #29 }
 DB 10011100B { 0 }
 DB 01000010B { 1 }
 DB 00010010B { 2 }
 DB 01000100B { 3 }
 DB 00101000B { 4 }
 DB 00001001B { 5 }
 DB 10001101B { 6 }
 DB 01001001B { 7 }
 DB 00000100B { 8 }
 DB 00111001B { 9 }
 DB 00000000B { 10 }
 DB 00000110B { 11 }
 DB 00110001B { 12 }
 DB 10000111B { 13 }
  { #30 }
 DB 01000110B { 0 }
 DB 00111001B { 1 }
 DB 00110100B { 2 }
 DB 11110110B { 3 }
 DB 00100100B { 4 }
 DB 01000011B { 5 }
 DB 00011100B { 6 }
 DB 01110010B { 7 }
 DB 00000010B { 8 }
 DB 00001111B { 9 }
 DB 00001100B { 10 }
 DB 11100001B { 11 }
 DB 00001111B { 12 }
 DB 01111000B { 13 }
  { #31 }
 DB 11111111B { 0 }
 DB 10000000B { 1 }
 DB 10000000B { 2 }
 DB 10000000B { 3 }
 DB 10000000B { 4 }
 DB 10000000B { 5 }
 DB 10000000B { 6 }
 DB 10000000B { 7 }
 DB 10000000B { 8 }
 DB 10000000B { 9 }
 DB 10000000B { 10 }
 DB 10000000B { 11 }
 DB 10000000B { 12 }
 DB 10000000B { 13 }
END;

Procedure Matrix8x16Luxe;Assembler;ASM
  { #00 }
 DB 00000000B { 0 }
 DB 00000000B { 1 }
 DB 00000000B { 2 }
 DB 00000000B { 3 }
 DB 00000000B { 4 }
 DB 00000000B { 5 }
 DB 00000000B { 6 }
 DB 00000000B { 7 }
 DB 00000000B { 8 }
 DB 00000000B { 9 }
 DB 00000000B { 10 }
 DB 00000000B { 11 }
 DB 00000000B { 12 }
 DB 00000000B { 13 }
 DB 00000000B { 14 }
 DB 00000000B { 15 }
  { #01 }
 DB 10000000B { 0 }
 DB 10000000B { 1 }
 DB 10000000B { 2 }
 DB 10000000B { 3 }
 DB 10000000B { 4 }
 DB 10000000B { 5 }
 DB 10000000B { 6 }
 DB 10000000B { 7 }
 DB 10000000B { 8 }
 DB 10000000B { 9 }
 DB 10000000B { 10 }
 DB 10000000B { 11 }
 DB 10000000B { 12 }
 DB 10000000B { 13 }
 DB 10000000B { 14 }
 DB 10000000B { 15 }
  { #02 }
 DB 00000001B { 0 }
 DB 00000001B { 1 }
 DB 00000001B { 2 }
 DB 00000001B { 3 }
 DB 00000001B { 4 }
 DB 00000001B { 5 }
 DB 00000001B { 6 }
 DB 00000001B { 7 }
 DB 00000001B { 8 }
 DB 00000001B { 9 }
 DB 00000001B { 10 }
 DB 00000001B { 11 }
 DB 00000001B { 12 }
 DB 00000001B { 13 }
 DB 00000001B { 14 }
 DB 00000001B { 15 }
  { #03 }
 DB 11111111B { 0 }
 DB 00000000B { 1 }
 DB 00000000B { 2 }
 DB 00000000B { 3 }
 DB 00000000B { 4 }
 DB 00000000B { 5 }
 DB 00000000B { 6 }
 DB 00000000B { 7 }
 DB 00000000B { 8 }
 DB 00000000B { 9 }
 DB 00000000B { 10 }
 DB 00000000B { 11 }
 DB 00000000B { 12 }
 DB 00000000B { 13 }
 DB 00000000B { 14 }
 DB 00000000B { 15 }
  { #04 }
 DB 00000000B { 0 }
 DB 00000000B { 1 }
 DB 00000000B { 2 }
 DB 00000000B { 3 }
 DB 00000000B { 4 }
 DB 00000000B { 5 }
 DB 00000000B { 6 }
 DB 00000000B { 7 }
 DB 00000000B { 8 }
 DB 00000000B { 9 }
 DB 00000000B { 10 }
 DB 00000000B { 11 }
 DB 00000000B { 12 }
 DB 00000000B { 13 }
 DB 00000000B { 14 }
 DB 11111111B { 15 }
  { #05 }
 DB 10000000B { 0 }
 DB 10000000B { 1 }
 DB 10000000B { 2 }
 DB 10000000B { 3 }
 DB 10000000B { 4 }
 DB 10000000B { 5 }
 DB 10000000B { 6 }
 DB 10000000B { 7 }
 DB 10000000B { 8 }
 DB 10000000B { 9 }
 DB 10000000B { 10 }
 DB 10000000B { 11 }
 DB 10000000B { 12 }
 DB 10000000B { 13 }
 DB 10000000B { 14 }
 DB 11111111B { 15 }
  { #06 }
 DB 00000001B { 0 }
 DB 00000001B { 1 }
 DB 00000001B { 2 }
 DB 00000001B { 3 }
 DB 00000001B { 4 }
 DB 00000001B { 5 }
 DB 00000001B { 6 }
 DB 00000001B { 7 }
 DB 00000001B { 8 }
 DB 00000001B { 9 }
 DB 00000001B { 10 }
 DB 00000001B { 11 }
 DB 00000001B { 12 }
 DB 00000001B { 13 }
 DB 00000001B { 14 }
 DB 11111111B { 15 }
  { #07 }
 DB 11111111B { 0 }
 DB 00000001B { 1 }
 DB 00000001B { 2 }
 DB 00000001B { 3 }
 DB 00000001B { 4 }
 DB 00000001B { 5 }
 DB 00000001B { 6 }
 DB 00000001B { 7 }
 DB 00000001B { 8 }
 DB 00000001B { 9 }
 DB 00000001B { 10 }
 DB 00000001B { 11 }
 DB 00000001B { 12 }
 DB 00000001B { 13 }
 DB 00000001B { 14 }
 DB 00000001B { 15 }
  { #08 }
 DB 11111111B { 0 }
 DB 10000000B { 1 }
 DB 10000000B { 2 }
 DB 10000000B { 3 }
 DB 10000000B { 4 }
 DB 10000000B { 5 }
 DB 10000000B { 6 }
 DB 10011111B { 7 }
 DB 10011111B { 8 }
 DB 10000000B { 9 }
 DB 10000000B { 10 }
 DB 10000000B { 11 }
 DB 10000000B { 12 }
 DB 10000000B { 13 }
 DB 10000000B { 14 }
 DB 11111111B { 15 }
  { #09 }
 DB 11111111B { 0 }
 DB 00000001B { 1 }
 DB 00000001B { 2 }
 DB 00000001B { 3 }
 DB 00000001B { 4 }
 DB 00000001B { 5 }
 DB 00000001B { 6 }
 DB 11111001B { 7 }
 DB 11111001B { 8 }
 DB 00000001B { 9 }
 DB 00000001B { 10 }
 DB 00000001B { 11 }
 DB 00000001B { 12 }
 DB 00000001B { 13 }
 DB 00000001B { 14 }
 DB 11111111B { 15 }
  { #10 }
 DB 11111111B { 0 }
 DB 10000000B { 1 }
 DB 10000001B { 2 }
 DB 10000011B { 3 }
 DB 10000111B { 4 }
 DB 10001111B { 5 }
 DB 10011111B { 6 }
 DB 10000001B { 7 }
 DB 10000001B { 8 }
 DB 10000001B { 9 }
 DB 10000001B { 10 }
 DB 10000001B { 11 }
 DB 10000001B { 12 }
 DB 10000001B { 13 }
 DB 10000000B { 14 }
 DB 11111111B { 15 }
  { #11 }
 DB 11111111B { 0 }
 DB 00000001B { 1 }
 DB 10000001B { 2 }
 DB 11000001B { 3 }
 DB 11100001B { 4 }
 DB 11110001B { 5 }
 DB 11111001B { 6 }
 DB 10000001B { 7 }
 DB 10000001B { 8 }
 DB 10000001B { 9 }
 DB 10000001B { 10 }
 DB 10000001B { 11 }
 DB 10000001B { 12 }
 DB 10000001B { 13 }
 DB 00000001B { 14 }
 DB 11111111B { 15 }
  { #12 }
 DB 11111111B { 0 }
 DB 10000000B { 1 }
 DB 10000001B { 2 }
 DB 10000001B { 3 }
 DB 10000001B { 4 }
 DB 10000001B { 5 }
 DB 10000001B { 6 }
 DB 10000001B { 7 }
 DB 10000001B { 8 }
 DB 10011111B { 9 }
 DB 10001111B { 10 }
 DB 10000111B { 11 }
 DB 10000011B { 12 }
 DB 10000001B { 13 }
 DB 10000000B { 14 }
 DB 11111111B { 15 }
  { #13 }
 DB 11111111B { 0 }
 DB 00000001B { 1 }
 DB 10000001B { 2 }
 DB 10000001B { 3 }
 DB 10000001B { 4 }
 DB 10000001B { 5 }
 DB 10000001B { 6 }
 DB 10000001B { 7 }
 DB 10000001B { 8 }
 DB 11111001B { 9 }
 DB 11110001B { 10 }
 DB 11100001B { 11 }
 DB 11000001B { 12 }
 DB 10000001B { 13 }
 DB 00000001B { 14 }
 DB 11111111B { 15 }
  { #14 }
 DB 00000000B { 0 }
 DB 00000000B { 1 }
 DB 00000000B { 2 }
 DB 00011000B { 3 }
 DB 00011000B { 4 }
 DB 11011011B { 5 }
 DB 00111100B { 6 }
 DB 11100111B { 7 }
 DB 00111100B { 8 }
 DB 11011011B { 9 }
 DB 00011000B { 10 }
 DB 00011000B { 11 }
 DB 00000000B { 12 }
 DB 00000000B { 13 }
 DB 00000000B { 14 }
 DB 00000000B { 15 }
  { #15 }
 DB 11111111B { 0 }
 DB 00000001B { 1 }
 DB 10000001B { 2 }
 DB 11000001B { 3 }
 DB 11100001B { 4 }
 DB 11110001B { 5 }
 DB 10000001B { 6 }
 DB 10000001B { 7 }
 DB 10000001B { 8 }
 DB 10000001B { 9 }
 DB 11110001B { 10 }
 DB 11100001B { 11 }
 DB 11000001B { 12 }
 DB 10000001B { 13 }
 DB 00000001B { 14 }
 DB 11111111B { 15 }
  { #16 }
 DB 11111111B { 0 }
 DB 00000001B { 1 }
 DB 10000001B { 2 }
 DB 11000001B { 3 }
 DB 11100001B { 4 }
 DB 11110001B { 5 }
 DB 11111001B { 6 }
 DB 11111101B { 7 }
 DB 11111101B { 8 }
 DB 11111001B { 9 }
 DB 11110001B { 10 }
 DB 11100001B { 11 }
 DB 11000001B { 12 }
 DB 10000001B { 13 }
 DB 00000001B { 14 }
 DB 11111111B { 15 }
  { #17 }
 DB 11111111B { 0 }
 DB 10000000B { 1 }
 DB 10000001B { 2 }
 DB 10000011B { 3 }
 DB 10000111B { 4 }
 DB 10001111B { 5 }
 DB 10011111B { 6 }
 DB 10111111B { 7 }
 DB 10111111B { 8 }
 DB 10011111B { 9 }
 DB 10001111B { 10 }
 DB 10000111B { 11 }
 DB 10000011B { 12 }
 DB 10000001B { 13 }
 DB 10000000B { 14 }
 DB 11111111B { 15 }
  { #18 }
 DB 00000000B { 0 }
 DB 00000000B { 1 }
 DB 00011000B { 2 }
 DB 00111100B { 3 }
 DB 01111110B { 4 }
 DB 11111111B { 5 }
 DB 00111100B { 6 }
 DB 00111100B { 7 }
 DB 00111100B { 8 }
 DB 00111100B { 9 }
 DB 11111111B { 10 }
 DB 01111110B { 11 }
 DB 00111100B { 12 }
 DB 00011000B { 13 }
 DB 00000000B { 14 }
 DB 00000000B { 15 }
  { #19 }
 DB 00000000B { 0 }
 DB 00000000B { 1 }
 DB 00000111B { 2 }
 DB 00011100B { 3 }
 DB 00110000B { 4 }
 DB 01100000B { 5 }
 DB 01000000B { 6 }
 DB 11000000B { 7 }
 DB 11000000B { 8 }
 DB 01000000B { 9 }
 DB 01100000B { 10 }
 DB 00110000B { 11 }
 DB 00011100B { 12 }
 DB 00000111B { 13 }
 DB 00000000B { 14 }
 DB 00000000B { 15 }
  { #20 }
 DB 00000000B { 0 }
 DB 00000000B { 1 }
 DB 11100000B { 2 }
 DB 00111000B { 3 }
 DB 00001100B { 4 }
 DB 00000110B { 5 }
 DB 00000010B { 6 }
 DB 00000011B { 7 }
 DB 00000011B { 8 }
 DB 00000010B { 9 }
 DB 00000110B { 10 }
 DB 00001100B { 11 }
 DB 00111000B { 12 }
 DB 11100000B { 13 }
 DB 00000000B { 14 }
 DB 00000000B { 15 }
  { #21 }
 DB 00000000B { 0 }
 DB 00000000B { 1 }
 DB 00000111B { 2 }
 DB 00011100B { 3 }
 DB 00110001B { 4 }
 DB 01100111B { 5 }
 DB 01001111B { 6 }
 DB 11011111B { 7 }
 DB 11011111B { 8 }
 DB 01001111B { 9 }
 DB 01100111B { 10 }
 DB 00110001B { 11 }
 DB 00011100B { 12 }
 DB 00000111B { 13 }
 DB 00000000B { 14 }
 DB 00000000B { 15 }
  { #22 }
 DB 00000000B { 0 }
 DB 00000000B { 1 }
 DB 11100000B { 2 }
 DB 00111000B { 3 }
 DB 10001100B { 4 }
 DB 11100110B { 5 }
 DB 11110010B { 6 }
 DB 11111011B { 7 }
 DB 11111011B { 8 }
 DB 11110010B { 9 }
 DB 11100110B { 10 }
 DB 10001100B { 11 }
 DB 00111000B { 12 }
 DB 11100000B { 13 }
 DB 00000000B { 14 }
 DB 00000000B { 15 }
  { #23 }
 DB 11111111B { 0 }
 DB 10000000B { 1 }
 DB 10000001B { 2 }
 DB 10000011B { 3 }
 DB 10000111B { 4 }
 DB 10001111B { 5 }
 DB 10000001B { 6 }
 DB 10000001B { 7 }
 DB 10000001B { 8 }
 DB 10000001B { 9 }
 DB 10001111B { 10 }
 DB 10000111B { 11 }
 DB 10000011B { 12 }
 DB 10000001B { 13 }
 DB 10000000B { 14 }
 DB 11111111B { 15 }
  { #24 }
 DB 00000000B { 0 }
 DB 00000000B { 1 }
 DB 00000000B { 2 }
 DB 00000000B { 3 }
 DB 00111111B { 4 }
 DB 01000000B { 5 }
 DB 01000000B { 6 }
 DB 01000000B { 7 }
 DB 01000000B { 8 }
 DB 01000000B { 9 }
 DB 01000000B { 10 }
 DB 01000000B { 11 }
 DB 01000000B { 12 }
 DB 01000000B { 13 }
 DB 00111111B { 14 }
 DB 00000000B { 15 }
  { #25 }
 DB 00000000B { 0 }
 DB 00000000B { 1 }
 DB 01111000B { 2 }
 DB 10000100B { 3 }
 DB 00000010B { 4 }
 DB 00000010B { 5 }
 DB 00000010B { 6 }
 DB 00000010B { 7 }
 DB 00000010B { 8 }
 DB 00000010B { 9 }
 DB 00000010B { 10 }
 DB 00000010B { 11 }
 DB 00000010B { 12 }
 DB 00000010B { 13 }
 DB 11111100B { 14 }
 DB 00000000B { 15 }
  { #26 }
 DB 00000000B { 0 }
 DB 00000000B { 1 }
 DB 00000000B { 2 }
 DB 00000000B { 3 }
 DB 00111111B { 4 }
 DB 01000000B { 5 }
 DB 01011111B { 6 }
 DB 01000000B { 7 }
 DB 01011111B { 8 }
 DB 01000000B { 9 }
 DB 01011111B { 10 }
 DB 01000000B { 11 }
 DB 01011111B { 12 }
 DB 01000000B { 13 }
 DB 00111111B { 14 }
 DB 00000000B { 15 }
  { #27 }
 DB 00000000B { 0 }
 DB 00000000B { 1 }
 DB 01111000B { 2 }
 DB 10000100B { 3 }
 DB 00000010B { 4 }
 DB 00000010B { 5 }
 DB 11111010B { 6 }
 DB 00000010B { 7 }
 DB 11111010B { 8 }
 DB 00000010B { 9 }
 DB 11111010B { 10 }
 DB 00000010B { 11 }
 DB 11111010B { 12 }
 DB 00000010B { 13 }
 DB 11111100B { 14 }
 DB 00000000B { 15 }
  { #28 }
 DB 11111111B { 0 }
 DB 11111111B { 1 }
 DB 11111111B { 2 }
 DB 11111111B { 3 }
 DB 11111111B { 4 }
 DB 11111111B { 5 }
 DB 11111111B { 6 }
 DB 11111111B { 7 }
 DB 11111111B { 8 }
 DB 11111111B { 9 }
 DB 11111111B { 10 }
 DB 11111111B { 11 }
 DB 11111111B { 12 }
 DB 11111110B { 13 }
 DB 11111100B { 14 }
 DB 11110000B { 15 }
  { #29 }
 DB 10011100B { 0 }
 DB 01000010B { 1 }
 DB 00010010B { 2 }
 DB 01000100B { 3 }
 DB 00101000B { 4 }
 DB 00001001B { 5 }
 DB 10001101B { 6 }
 DB 01001001B { 7 }
 DB 00000100B { 8 }
 DB 00111001B { 9 }
 DB 00000000B { 10 }
 DB 00000110B { 11 }
 DB 00110001B { 12 }
 DB 10000111B { 13 }
 DB 01110000B { 14 }
 DB 01001111B { 15 }
  { #30 }
 DB 01000110B { 0 }
 DB 00111001B { 1 }
 DB 00110100B { 2 }
 DB 11110110B { 3 }
 DB 00100100B { 4 }
 DB 01000011B { 5 }
 DB 00011100B { 6 }
 DB 01110010B { 7 }
 DB 00000010B { 8 }
 DB 00001111B { 9 }
 DB 00001100B { 10 }
 DB 11100001B { 11 }
 DB 00001111B { 12 }
 DB 01111000B { 13 }
 DB 11100111B { 14 }
 DB 00111100B { 15 }
  { #31 }
 DB 11111111B { 0 }
 DB 10000000B { 1 }
 DB 10000000B { 2 }
 DB 10000000B { 3 }
 DB 10000000B { 4 }
 DB 10000000B { 5 }
 DB 10000000B { 6 }
 DB 10000000B { 7 }
 DB 10000000B { 8 }
 DB 10000000B { 9 }
 DB 10000000B { 10 }
 DB 10000000B { 11 }
 DB 10000000B { 12 }
 DB 10000000B { 13 }
 DB 10000000B { 14 }
 DB 10000000B { 15 }
END;

Procedure Luxe;Assembler;ASM
 DB No  { Luxe := No }
END;

Function GetCurrMtx(Var Height:Byte):Pointer;Near;Var _BH,H:Byte;Begin
 ASM
  MOV AL,DataVideo.MIV.HeightChar
  MOV H,AL
 END;
 Case(H)of
  0..7:Exit;
  8..10:_BH:=$03;
  13..14:_BH:=$02;
  15..16:_BH:=$06;
 End;
 ASM
  MOV AX,01130h
  MOV BH,_BH
  PUSH BP
   INT 010h
   MOV BX,BP
  POP BP
  MOV @Result.Word,BX
  MOV @Result.Word[2],ES
  LES DI,Height
  MOV ES:[DI],CL
 END;
End;

Procedure HeightLuxeAddr;Near;Assembler;ASM
 DW Offset Matrix8x16Luxe   { Hauteur 0 }
 DW Offset Matrix8x16Luxe   { Hauteur 1 }
 DW Offset Matrix8x16Luxe   { Hauteur 2 }
 DW Offset Matrix8x16Luxe   { Hauteur 3 }
 DW Offset Matrix8x6Luxe    { Hauteur 4 }
 DW Offset Matrix8x6Luxe    { Hauteur 5 }
 DW Offset Matrix8x6Luxe    { Hauteur 6 }
 DW Offset Matrix8x8Luxe    { Hauteur 7 }
 DW Offset Matrix8x8Luxe    { Hauteur 8 }
 DW Offset Matrix8x8Luxe    { Hauteur 9 }
 DW Offset Matrix8x8Luxe    { Hauteur 10 }
 DW Offset Matrix8x8Luxe    { Hauteur 11 }
 DW Offset Matrix8x8Luxe    { Hauteur 12 }
 DW Offset Matrix8x14Luxe   { Hauteur 13 }
 DW Offset Matrix8x14Luxe   { Hauteur 14 }
 DW Offset Matrix8x16Luxe   { Hauteur 15 }
END;

Procedure HAddr;Near;Assembler;ASM
 DB 16,16,16,16,6,6,6,8,8,8,8,8,8,14,14,16
END;

Procedure SetLuxe(X:Bool);Label _Exit;Var H:Byte;Addr:PTByte;FontFound:Bool;Begin
 ASM
  CMP DataVideo.MIV.Color,True
  JNE _Exit
  MOV AL,PhysVideo.PIV.Font
  MOV FontFound,AL
 END;
 If(X)Then Begin
  SetBlinkTxt(No);
  If(FontFound)Then Begin
   ASM
    MOV DX,3DAh
 @1:IN AL,DX;TEST AL,8;JNZ @1
   END;
   SetChrWidthTxt(8);
   ASM
    MOV AL,DataVideo.MIV.HeightChar
    PUSH AX
     CMP AL,6
     JNE @Not6x6
     XOR CX,CX
     PUSH CX
     PUSH AX
     MOV  AX,256
     PUSH AX
     PUSH CX
     PUSH CS
     {$IFOPT G+}
      PUSH Offset Matrix6x6
     {$ELSE}
      MOV AX,Offset Matrix6x6
      PUSH AX
     {$ENDIF}
     PUSH CS
     CALL Near Ptr SetMatrixTxt
@Not6x6:
    POP BX
    AND BX,000Fh
    MOV DL,Byte Ptr HAddr[BX]
    SHL BX,1
    MOV AX,Word Ptr HeightLuxeAddr[BX]
    XOR CX,CX
    PUSH CX
    PUSH DX
    {$IFOPT G+}
     PUSH 32
    {$ELSE}
     MOV  DI,32
     PUSH DI
    {$ENDIF}
    PUSH CX
    PUSH CS
    PUSH AX
    PUSH CS
    CALL Near Ptr SetMatrixTxt
   END;
  End;
  CloseCurTxt;
 End
  Else
 Begin
  SetBlinkTxt(Ya);
  If(FontFound)Then Begin
   SetChrWidthTxt(9);
   Addr:=GetCurrMtx(H);
   SetMatrixTxt(0,H,32,0,Addr^)
  End;
 End;
 ASM
  MOV AL,FontFound
  MOV Byte Ptr Luxe,AL
 END;
_Exit:
End;

Function IsLuxe:Boolean;Assembler;ASM
 MOV AL,Byte Ptr Luxe
END;

Procedure CloseIconTxt(X,Y,Attr:Byte);Assembler;ASM
 CLD
 MOV BL,Y
 XOR BH,BH
 SHL BX,1
 MOV DI,Word Ptr RawTxtY[BX]
 MOV BL,X
 ADD DI,BX
 SHL DI,1
 MOV ES,DataVideo.MIV.SegVideo
 MOV AH,Attr
 CMP Byte Ptr Luxe,True
 JNE @Normal
@Luxe:
 MOV AL,8 { Code 1:CloseIcon }
 STOSW
 MOV AL,9 { Code 2:CloseIcon }
 STOSW
 JMP @End
@Normal:
 MOV AL,' '
 STOSW
 MOV AL,'-'
 STOSW
 MOV AL,' '
 STOSW
@End:
END;

Procedure CloseIconDblMtx(X,Y,Attr:Byte);Assembler;ASM
 CLD
 MOV BL,Y
 XOR BH,BH
 SHL BX,1
 MOV DI,Word Ptr RawTxtY[BX]
 MOV BL,X
 ADD DI,BX
 SHL DI,1
 MOV ES,DataVideo.MIV.SegVideo
 MOV AH,Attr
 AND AH,NOT 8
 CMP Byte Ptr Luxe,True
 JNE @Normal
@Luxe:
 MOV AL,8 { Code 1:CloseIcon }
 STOSW
 MOV AL,9 { Code 2:CloseIcon }
 STOSW
 JMP @End
@Normal:
 MOV AL,' '
 STOSW
 MOV AL,'-'
 STOSW
 MOV AL,' '
 STOSW
@End:
END;

Procedure DownIconTxt(X,Y,Attr:Byte);Assembler;ASM
 CLD
 MOV BL,Y
 XOR BH,BH
 SHL BX,1
 MOV DI,Word Ptr RawTxtY[BX]
 MOV BL,X
 ADD DI,BX
 SHL DI,1
 MOV ES,DataVideo.MIV.SegVideo
 MOV AH,Attr
 CMP Byte Ptr Luxe,True
 JNE @Normal
@Luxe:
 MOV AL,12 { Code 1:DownIcon }
 STOSW
 MOV AL,13 { Code 2:DownIcon }
 STOSW
 JMP @End
@Normal:
 MOV AL,$19
 STOSW
@End:
END;

Procedure DownIconDblMtx(X,Y,Attr:Byte);Assembler;ASM
 CLD
 MOV BL,Y
 XOR BH,BH
 SHL BX,1
 MOV DI,Word Ptr RawTxtY[BX]
 MOV BL,X
 ADD DI,BX
 SHL DI,1
 MOV ES,DataVideo.MIV.SegVideo
 MOV AH,Attr
 AND AH,NOT 8
 CMP Byte Ptr Luxe,True
 JNE @Normal
@Luxe:
 MOV AL,12 { Code 1:DownIcon }
 STOSW
 MOV AL,13 { Code 2:DownIcon }
 STOSW
 JMP @End
@Normal:
 MOV AL,$19
 STOSW
@End:
END;

Procedure LeftIconTxt(X,Y,Attr:Byte);Assembler;ASM
 CLD
 MOV BL,Y
 XOR BH,BH
 SHL BX,1
 MOV DI,Word Ptr RawTxtY[BX]
 MOV BL,X
 ADD DI,BX
 SHL DI,1
 MOV ES,DataVideo.MIV.SegVideo
 MOV AH,Attr
 CMP Byte Ptr Luxe,Ya
 JNE @Normal
@Luxe:
 MOV AL,17 { Code 1:LeftIcon }
 STOSW
 MOV AL,9  { Code 2:LeftIcon }
 STOSW
 JMP @End
@Normal:
 MOV AL,'<'
 STOSW
@End:
END;

Procedure LeftIconDblMtx(X,Y,Attr:Byte);Assembler;ASM
 CLD
 MOV BL,Y
 XOR BH,BH
 SHL BX,1
 MOV DI,Word Ptr RawTxtY[BX]
 MOV BL,X
 ADD DI,BX
 SHL DI,1
 MOV ES,DataVideo.MIV.SegVideo
 MOV AH,Attr
 AND AH,NOT 8
 CMP Byte Ptr Luxe,Ya
 JNE @Normal
@Luxe:
 MOV AL,17 { Code 1:LeftIcon }
 STOSW
 MOV AL,9  { Code 2:LeftIcon }
 STOSW
 JMP @End
@Normal:
 MOV AL,'<'
 STOSW
@End:
END;

Procedure RightIconTxt(X,Y,Attr:Byte);Assembler;ASM
 CLD
 MOV BL,Y
 XOR BH,BH
 SHL BX,1
 MOV DI,Word Ptr RawTxtY[BX]
 MOV BL,X
 ADD DI,BX
 SHL DI,1
 MOV ES,DataVideo.MIV.SegVideo
 MOV AH,Attr
 CMP Byte Ptr Luxe,True
 JNE @Normal
@Luxe:
 MOV AL,8 { Code 1:RightIcon }
 STOSW
 MOV AL,16 { Code 2:RightIcon }
 STOSW
 JMP @End
@Normal:
 MOV AL,'>'
 STOSW
@End:
END;

Procedure RightIconDblMtx(X,Y,Attr:Byte);Assembler;ASM
 CLD
 MOV BL,Y
 XOR BH,BH
 SHL BX,1
 MOV DI,Word Ptr RawTxtY[BX]
 MOV BL,X
 ADD DI,BX
 SHL DI,1
 MOV ES,DataVideo.MIV.SegVideo
 MOV AH,Attr
 AND AH,NOT 8
 CMP Byte Ptr Luxe,True
 JNE @Normal
@Luxe:
 MOV AL,8 { Code 1:RightIcon }
 STOSW
 MOV AL,16 { Code 2:RightIcon }
 STOSW
 JMP @End
@Normal:
 MOV AL,'>'
 STOSW
@End:
END;

Procedure SelIconTxt(X,Y,Attr:Byte);Assembler;ASM
 CLD
 MOV BL,Y
 XOR BH,BH
 SHL BX,1
 MOV DI,Word Ptr RawTxtY[BX]
 MOV BL,X
 ADD DI,BX
 SHL DI,1
 MOV ES,DataVideo.MIV.SegVideo
 MOV AH,Attr
 CMP Byte Ptr Luxe,True
 JNE @Normal
@Luxe:
 MOV AL,21 { Code 1:SelIcon }
 STOSW
 MOV AL,22 { Code 2:SelIcon }
 STOSW
 JMP @End
@Normal:
 MOV AL,'('
 STOSW
 MOV AL,7
 STOSW
 MOV AL,')'
 STOSW
@End:
END;

Procedure SelIconDblMtx(X,Y,Attr:Byte);Assembler;ASM
 CLD
 MOV BL,Y
 XOR BH,BH
 SHL BX,1
 MOV DI,Word Ptr RawTxtY[BX]
 MOV BL,X
 ADD DI,BX
 SHL DI,1
 MOV ES,DataVideo.MIV.SegVideo
 MOV AH,Attr
 AND AH,NOT 8
 CMP Byte Ptr Luxe,True
 JNE @Normal
@Luxe:
 MOV AL,21 { Code 1:SelIcon }
 STOSW
 MOV AL,22 { Code 2:SelIcon }
 STOSW
 JMP @End
@Normal:
 MOV AL,'('
 STOSW
 MOV AL,7
 STOSW
 MOV AL,')'
 STOSW
@End:
END;

Procedure UnSelIconTxt(X,Y,Attr:Byte);Assembler;ASM
 CLD
 MOV BL,Y
 XOR BH,BH
 SHL BX,1
 MOV DI,Word Ptr RawTxtY[BX]
 MOV BL,X
 ADD DI,BX
 SHL DI,1
 MOV ES,DataVideo.MIV.SegVideo
 MOV AH,Attr
 CMP Byte Ptr Luxe,True
 JNE @Normal
@Luxe:
 MOV AL,19 { Code 1:UnSelIcon }
 STOSW
 MOV AL,20 { Code 2:UnSelIcon }
 STOSW
 JMP @End
@Normal:
 MOV AL,'('
 STOSW
 MOV AL,' '
 STOSW
 MOV AL,')'
 STOSW
@End:
END;

Procedure UnSelIconDblMtx(X,Y,Attr:Byte);Assembler;ASM
 CLD
 MOV BL,Y
 XOR BH,BH
 SHL BX,1
 MOV DI,Word Ptr RawTxtY[BX]
 MOV BL,X
 ADD DI,BX
 SHL DI,1
 MOV ES,DataVideo.MIV.SegVideo
 MOV AH,Attr
 AND AH,NOT 8
 CMP Byte Ptr Luxe,True
 JNE @Normal
@Luxe:
 MOV AL,19 { Code 1:UnSelIcon }
 STOSW
 MOV AL,20 { Code 2:UnSelIcon }
 STOSW
 JMP @End
@Normal:
 MOV AL,'('
 STOSW
 MOV AL,' '
 STOSW
 MOV AL,')'
 STOSW
@End:
END;

Procedure UpIconTxt(X,Y,Attr:Byte);Assembler;ASM
 CLD
 MOV BL,Y
 XOR BH,BH
 SHL BX,1
 MOV DI,Word Ptr RawTxtY[BX]
 MOV BL,X
 ADD DI,BX
 SHL DI,1
 MOV ES,DataVideo.MIV.SegVideo
 MOV AH,Attr
 CMP Byte Ptr Luxe,True
 JNE @Normal
@Luxe:
 MOV AL,10 { Code 1:UpIcon }
 STOSW
 MOV AL,11 { Code 2:UpIcon }
 STOSW
 JMP @End
@Normal:
 MOV AL,$18
 STOSW
@End:
END;

Procedure UpIconDblMtx(X,Y,Attr:Byte);Assembler;ASM
 CLD
 MOV BL,Y
 XOR BH,BH
 SHL BX,1
 MOV DI,Word Ptr RawTxtY[BX]
 MOV BL,X
 ADD DI,BX
 SHL DI,1
 MOV ES,DataVideo.MIV.SegVideo
 MOV AH,Attr
 AND AH,NOT 8
 CMP Byte Ptr Luxe,True
 JNE @Normal
@Luxe:
 MOV AL,10 { Code 1:UpIcon }
 STOSW
 MOV AL,11 { Code 2:UpIcon }
 STOSW
 JMP @End
@Normal:
 MOV AL,$18
 STOSW
@End:
END;

Procedure DossierDocumentIconTxt(X,Y,Attr:Byte);Assembler;ASM
 CMP Byte Ptr Luxe,Ya
 JNE @End
 CLD
 MOV BL,Y
 XOR BH,BH
 SHL BX,1
 MOV DI,Word Ptr RawTxtY[BX]
 MOV BL,X
 ADD DI,BX
 SHL DI,1
 MOV ES,DataVideo.MIV.SegVideo
 MOV AH,Attr
 MOV AL,26 { Code 1:DossierDocumentIcon }
 STOSW
 MOV AL,27 { Code 2:DossierDocumentIcon }
 STOSW
@End:
END;

Procedure DossierDocumentIconDblMtx(X,Y,Attr:Byte);Assembler;ASM
 CMP Byte Ptr Luxe,Ya
 JNE @End
 CLD
 MOV BL,Y
 XOR BH,BH
 SHL BX,1
 MOV DI,Word Ptr RawTxtY[BX]
 MOV BL,X
 ADD DI,BX
 SHL DI,1
 MOV ES,DataVideo.MIV.SegVideo
 MOV AH,Attr
 AND AH,NOT 8
 MOV AL,26 { Code 1:DossierDocumentIcon }
 STOSW
 MOV AL,27 { Code 2:DossierDocumentIcon }
 STOSW
@End:
END;

Procedure DossierProgramIconTxt(X,Y,Attr:Byte);Assembler;ASM
 CMP Byte Ptr Luxe,Ya
 JNE @End
 CLD
 MOV BL,Y
 XOR BH,BH
 SHL BX,1
 MOV DI,Word Ptr RawTxtY[BX]
 MOV BL,X
 ADD DI,BX
 SHL DI,1
 MOV ES,DataVideo.MIV.SegVideo
 MOV AH,Attr
 MOV AL,24 { Code 1:DossierProgramIcon }
 STOSW
 MOV AL,25 { Code 2:DossierProgramIcon }
 STOSW
@End:
END;

Procedure DossierProgramIconDblMtx(X,Y,Attr:Byte);Assembler;ASM
 CMP Byte Ptr Luxe,Ya
 JNE @End
 CLD
 MOV BL,Y
 XOR BH,BH
 SHL BX,1
 MOV DI,Word Ptr RawTxtY[BX]
 MOV BL,X
 ADD DI,BX
 SHL DI,1
 MOV ES,DataVideo.MIV.SegVideo
 MOV AH,Attr
 AND AH,NOT 8
 MOV AL,24 { Code 1:DossierProgramIcon }
 STOSW
 MOV AL,25 { Code 2:DossierProgramIcon }
 STOSW
@End:
END;