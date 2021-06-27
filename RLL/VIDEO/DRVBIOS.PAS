Unit DrvBios;

INTERFACE

{$A-,G-,O-}
{$DEFINE BiosDriver}

Procedure _DriverBios;
Procedure EndDriverBios;
Procedure PhysVideo;
Procedure DataVideo;

IMPLEMENTATION

Uses Systex;

Procedure BarChrHor(X1,Y,X2:Byte;Chr:Char);Far;Forward;
Procedure BarChrVer(X,Y1,Y2:Byte;Chr:Char);Far;Forward;
Procedure BarSpcHor(X1,Y,X2,Attr:Byte);Far;Forward;
Procedure BarSpcVer(X,Y1,Y2,Attr:Byte);Far;Forward;
Procedure BarTxtHor(X1,Y,X2:Byte;Chr:Char;Attr:Byte);Far;Forward;
Procedure Circle(X,Y,Rayon:Int;Color:Wd);Far;Forward;
Procedure CloseCur;Far;Forward;
Procedure CloseIcon(X,Y,Attr:Byte);Far;Forward;
Procedure ClrWn(X1,Y1,X2,Y2,Attr:Byte);Far;Forward;
Procedure ClrScr(Attr:Byte);Far;Forward;
Procedure DownIcon(X,Y,Attr:Byte);Far;Forward;
Procedure FillBox(X1,Y1,X2,Y2:Byte;Chr:Char;Attr:Byte);Far;Forward;
Function  GetAttr(X,Y:Byte):Byte;Far;Forward;
Function  GetChr(X,Y:Byte):Char;Far;Forward;
Function  GetCube(X,Y:Byte):Wd;Far;Forward;
Function  GetPixel(X,Y:Wd):Wd;Far;Forward;
Function  GetSizeSmlImg(X1,Y1,X2,Y2:Wd):Wd;Far;Forward;
Procedure Init;Far;Forward;
Function  IsLuxe:Bool;Far;Forward;
Procedure LeftIcon(X,Y,Attr:Byte);Far;Forward;
Procedure MoveText(X1,Y1,X2,Y2,X3,Y3:Byte);Far;Forward;
Procedure PCopy(S,T:Byte);Far;Forward;
Procedure PutCharGAttr(X,Y:Byte;Chr:Char;Attr,GAttr:Byte);Far;Forward;
Procedure PutFillBox(X1,Y1,X2,Y2,Kr:Wd);Far;Forward;
Procedure PutFillCircle(X,Y,Rayon:Int;Color:Wd);Far;Forward;
Procedure PutFillRoundRect(x1,y1,x2,y2,b,Kr:Int);Far;Forward;
Procedure PutLn(X1,Y1,X2,Y2:Int;Kr:Wd);Far;Forward;
Procedure PutLnHor(X1,Y,X2,Kr:Wd);Far;Forward;
Procedure PutRect(X1,Y1,X2,Y2,Kr:Int);Far;Forward;
Procedure PutRoundRect(x1,y1,x2,y2,LineWidth,b,Kr:Int);Far;Forward;
Procedure PutTxtXY(X,Y:Byte;Const Str:String;Attr:Byte);Far;Forward;
Procedure PutTxtXYUnKr(X,Y:Byte;Const Str:String);Far;Forward;
Procedure RightIcon(X,Y,Attr:Byte);Far;Forward;
Procedure SelIcon(X,Y,Attr:Byte);Far;Forward;
Procedure SetAttr(X,Y,Attr:Byte);Far;Forward;
Procedure SetBackgroundColor(Kr:Byte);Far;Forward;
Procedure SetBlink(X:Bool);Far;Forward;
Procedure SetBorderColor(Kr:Byte);Far;Forward;
Procedure SetBytesPerLn(X:Wd);Far;Forward;
Procedure SetChr(X,Y:Byte;Chr:Char);Far;Forward;
Procedure SetChrWidth(L:Byte);Far;Forward;
Procedure SetCube(X,Y:Byte;Chr:Char;Attr:Byte);Far;Forward;
Procedure SetCur(A,B:Byte);Far;Forward;
Procedure SetCurPos(X,Y:Byte);Far;Forward;
Procedure SetHorizontalScale(X:Wd);Far;Forward;
Procedure SetMatrix(Palette,Height:Byte;Number,Start:Wd;Var X:TByte);Far;Forward;
Procedure SetModeMtx;Far;Forward;
Procedure SetModeScr;Far;Forward;
Procedure SetPalBlk(Start,Nm:Wd);Far;Forward;
Procedure SetPaletteRGB(Start:Wd;R,G,B:Byte);Far;Forward;
Procedure SetPalRGB(Var P;Start,Num:Wd);Far;Forward;
Procedure SetPg(Pg:Byte);Far;Forward;
Procedure SetPixel(X,Y,Kr:Wd);Far;Forward;
Procedure SetVerticalScale(Y:Wd);Far;Forward;
Procedure SetVisualPg(Pg:Byte);Far;Forward;
Procedure SplitScreen(Y:Wd);Far;Forward;
Procedure UnSelIcon(X,Y,Attr:Byte);Far;Forward;
Procedure UpIcon(X,Y,Attr:Byte);Far;Forward;

Procedure _DriverBios;Assembler;ASM
 JMP Init.Near
 JMP BarChrHor.Near
 JMP BarChrVer.Near
 JMP BarSpcHor.Near
 JMP BarSpcVer.Near
 JMP BarTxtHor.Near
 JMP Circle.Near
 JMP CloseCur.Near
 RETF 8 {ClrLnHor(X,Y,L,Kr:Wd)}
 RETF 12{ClrLnHorImg(X,Y,L:Wd;BitsPerPixel:Byte;Var Buffer)}
 JMP ClrWn.Near
 JMP ClrScr.Near
 RETF 8 {CopT8Bin(X,Y:Wd;Value,Fore:Byte)}
 RETF 10{Copy8Bin(X,Y:Wd;Value,Back,Fore:Byte)}
 JMP FillBox.Near
 JMP GetAttr.Near
 JMP GetChr.Near
 JMP GetCube.Near
 RETF 10{GetLnHorImg(X1,Y,X2:Int;Var Buffer)}
 JMP GetPixel.Near
 JMP GetSizeSmlImg.Near
 RETF 12{GetSmlImg(X1,Y1,X2,Y2:Wd;Var Buffer)}
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
 RETF 12{PutSmlImg(X1,Y1,X2,Y2:Wd;Var Buffer)}
 RETF 12{PutSprite(X1,Y1,X2,Y2:Wd;Var Buffer)}
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
 RETF 8 {SetGCube(X,Y:Wd;Chr:Char;Attr:Byte)}
 RETF 8 {SetGCubeT(X,Y:Wd;Chr:Char;Attr:Byte)}
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
 RETF 2 {SetWriteMode(Mode:Byte)}
 JMP SplitScreen.Near
 RETF 2 {SetBnkPg(Pg:Byte)}
 RETF 10 {ReadBnk(P:Long;Size:Wd;Var x0)}
 RETF 10 {WriteBnk(P:Long;Size:Wd;Var x0)}
 RETF 8{FillBnk(aY:Long;L,Kr:Wd)}
 RETF {Done}
 NOP
 NOP
  {Gestion des Icons/Luxe}
 RETF 2 {SetLuxe(X:Bool)}
 JMP IsLuxe.Near
 JMP CloseIcon.Near
 JMP DownIcon.Near
 JMP LeftIcon.Near
 JMP RightIcon.Near
 JMP SelIcon.Near
 JMP UnSelIcon.Near
 JMP UpIcon.Near
 JMP DownIcon.Near { Zoom }
 RETF 6 {DossierDocumentIcon(X,Y,Attr:Byte)}
 RETF 6 {DossierProgramIcon(X,Y,Attr:Byte)}
  {}
 DW 0 {RawTxtY}
 DW 0 {RawY}
 DW 0 {RealRawY}
END;

{$I PhysDef.Inc}

Procedure DataVideo;Assembler;ASM
 DW 0{Mode:Mode vid‚o actuel (vm???)}
 DB 0{IbmLogic:Mode dans la logique IBM (pas hors cas texte … la SVGA...)}
 DB 0{BiosSupport:Mode support‚ par le Bios (Par exemple, la GS en 16 couleurs le Bios ne le connaŒt pas)}
 DB 0{Colr:Mode couleur? Sinon monochrome for‡‚ment...}
 DB 0{Graf:Mode graphique? Sinon texte}
 DB 0{Direct:M‚thode directe? Sinon Bios ou Dos}
 DB No{Blink:Clignotement}
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
 DB 0{IsDblMtx}
 DB 0,0 {XCur,YCur:Position actuel du curseur}
 DB 0,0 {StartCur,EndCur:D‚but et fin du curseur}
 DW Offset PhysVideo
END;

Procedure BarChrHor;Var I:Byte;Begin
 For I:=X1 to(X2)do SetChr(I,Y,Chr)
End;

Procedure BarChrVer;Var J:Byte;Begin
 For J:=Y1 to(Y2)do SetChr(X,J,Chr)
End;

Procedure BarSpcHor;Assembler;ASM
 MOV AH,2
 MOV BH,DataVideo.MIV.Page
 MOV DL,X1
 MOV DH,Y
 INT 10h
 MOV AX,0920h
 MOV BH,DataVideo.MIV.Page
 MOV BL,Attr
 MOV CL,X2
 SUB CL,X1
 INC CL
 XOR CH,CH
 INT 010h
END;

Procedure BarSpcVer;Var J:Byte;Begin
 For J:=Y1 to(Y2)do SetCube(X,J,' ',Attr)
End;

Procedure BarTxtHor;Assembler;ASM
 MOV AH,2
 MOV BH,DataVideo.MIV.Page
 MOV DL,X1
 MOV DH,Y
 INT 10h
 MOV AH,09h
 MOV AL,Chr
 MOV BH,DataVideo.MIV.Page
 MOV BL,Attr
 MOV CL,X2
 SUB CL,X1
 INC CL
 XOR CH,CH
 INT 010h
END;

{$I Circle.Inc}

Procedure CloseCur;Assembler;ASM
 MOV CX,2020h
 MOV Word Ptr DataVideo.MIV.StartCur,CX
 MOV AH,01h
 INT 10h
END;

Procedure ClrScr;Assembler;ASM
 MOV AX,0600h
 MOV BH,Attr
 XOR CX,CX
 MOV DL,DataVideo.MIV.NumXTexts
 DEC DL
 MOV DH,DataVIdeo.MIV.NumYTexts
 DEC DH
 INT 10h
END;

Procedure ClrWn;Assembler;ASM
 MOV AX,0600h
 MOV BH,Attr
 MOV CL,X1
 MOV CH,Y1
 MOV DL,X2
 MOV DH,Y2
 INT $10
END;

Procedure FillBox;Assembler;ASM
 MOV CL,Y1
 MOV CH,Y2
@@Loop:
 PUSH CX
  PUSH DI
   MOV AH,2
   MOV BH,DataVideo.MIV.Page
   MOV DL,X1
   MOV DH,CL
   INT 010h
   MOV AH,9
   MOV AL,Chr
   MOV BL,Attr
   MOV BH,DataVideo.MIV.Page
   MOV CL,X2
   SUB CL,X1
   XOR CH,CH
   INC CX
   INT $10
  POP DI
 POP CX
 ADD DI,SI
 INC CL
 CMP CL,CH
 JBE @@Loop
END;

Procedure MakeAddr;Near;Assembler;ASM
 MOV AH,2
 MOV BH,DataVideo.MIV.Page
 MOV DL,SS:[BP+8]
 MOV DH,SS:[BP+6]
 INT 010h
 MOV AH,8
 INT 010h
END;

Function GetAttr;Assembler;ASM
 CALL MakeAddr
 MOV AL,AH
END;

Function GetChr;Assembler;ASM CALL MakeAddr;END;
Function GetCube;Assembler;ASM CALL MakeAddr;END;
Function GetPixel;Assembler;ASM XOR AX,AX;END;
Function GetSizeSmlImg;Assembler;ASM XOR AX,AX;END;

Procedure Init;Begin
 ASM
  XOR AX,AX
  MOV MIV(DataVideo).IbmLogic,Ya
  MOV MIV(DataVideo).BiosSupport,Ya
  MOV MIV(DataVideo).BitsPerPixel,AL
  MOV ES,AX
  MOV CH,ES:[044Ah]
  MOV DL,ES:[0463h]
  MOV BX,ES:[0484h]
  MOV CL,6
  SHR DL,CL
  AND DX,1
  MOV DataVideo.MIV.Color,DL
  MOV DataVideo.MIV.Graphics,AL
  MOV CL,11
  SHL DX,CL
  ADD DX,0B000h
  MOV DataVideo.MIV.SegVideo,DX
  CMP BH,0
  JNE @HeightNot0
  MOV BX,24+(8 shl 8)
@HeightNot0:
  MOV DataVideo.MIV.HeightChar,BH
  INC BL
  MOV DataVideo.MIV.NumYTexts,BL
  MOV DataVideo.MIV.NumXTexts,CH
  MOV AL,CH
  SHL AX,1
  MOV DataVideo.MIV.BytesPerLine,AX
  SHL AX,1
  SHL AX,1
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
 SetPg(0);
 ASM
  MOV AL,DataVideo.MIV.NumYTexts
  MUL DataVideo.MIV.NumXTexts
  MOV Word Ptr DataVideo.MIV.ScrSize,AX
 END;
End;

Procedure MoveText;Var L:Wd;Begin
 If(X2<X1)or(Y2<Y1)Then Exit;
 ASM
  MOV AL,X2
  SUB AL,X1
  XOR AH,AH
  INC AX
  SHL AX,1
  MOV L,AX
  CLD
  PUSH DataVideo.MIV.SegVideo
  POP ES
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
  PUSH DS
   PUSH ES
   POP DS
   REP MOVSB
  POP DS
  RETN
@@End:
 END;
End;

Procedure PCopy;Var A,B,C:Wd;Begin
 ASM
  MOV CX,MIV(DataVideo).ScrSize.Word
  MOV C,CX
 END;
 A:=C*S;B:=C*T;
 ASM
  CLD
  PUSH DS
   MOV DS,MIV(DataVideo).SegVideo
   MOV SI,A
   PUSH DS
   POP ES
   MOV DI,B
   MOV CX,C
   SHR CX,1
   REP MOVSW
  POP DS
 END;
End;

{$I PutCharG.Inc}

Procedure PutFillBox;Var I,J:Wd;Begin
 For J:=Y1 to(Y2)do For I:=X1 to(X2)do SetPixel(I,J,Kr);
End;

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

Procedure PutLnHor;Var I:Wd;Begin
 ASM
  MOV AX,X1
  CMP AX,X2
  JB  @1
  XCHG AX,X2
  MOV X1,AX
@1:
 END;
 For I:=X1 to(X2)do SetPixel(I,Y,Kr)
End;

{$I PutRect.Inc}
{$I PutRndRe.Inc}

Procedure PutTxtXY;
Type
 CARec=Record
  Chr:Char;
  Attr:Byte;
 End;
Var
 I:Byte;
 P:CARec;
Begin
 ASM
  MOV AH,2
  MOV BH,DataVideo.MIV.Page
  MOV DL,X
  MOV DH,Y
  INT $10
 END;
 For I:=1to Length(Str)do Begin
  P.Chr:=Str[I];P.Attr:=Attr;
  ASM
   MOV AH,9
   MOV AL,P.Chr
   MOV BH,DataVideo.MIV.Page
   MOV BL,P.Attr
   MOV CX,1
   INT 010h
  END;
 End;
End;

Procedure PutTxtXYUnKr;
Var
 I:Byte;
 P:Char;
Begin
 ASM
  MOV AH,2
  MOV BH,DataVideo.MIV.Page
  MOV DL,X
  MOV DH,Y
  INT 010h
 END;
 For I:=1to Length(Str)do Begin
  P:=Str[I];
  ASM
   MOV AH,0Ah
   MOV AL,P
   MOV BH,DataVideo.MIV.Page
   MOV CX,1
   INT 010h
  END;
 End;
End;

Procedure SetAttr;Begin SetCube(X,Y,GetChr(X,Y),Attr)End;

Procedure SetBackgroundColor;Assembler;ASM
END;

Procedure SetBlink;Assembler;ASM
 MOV AX,$1003
 MOV BL,X
 MOV MIV(DataVideo).Blink,BL
 INT $10
END;

Procedure SetBorderColor;Assembler;ASM
 MOV AH,0Bh
 MOV BL,Kr
 AND BX,000Fh
 INT 10h
END;

Procedure SetBytesPerLn;Begin End;
Procedure SetChr;Begin SetCube(X,Y,Chr,GetAttr(X,Y))End;
Procedure SetChrWidth;Begin End;

Procedure SetCube;Assembler;ASM
 MOV AH,2
 MOV BH,DataVideo.MIV.Page
 MOV DL,X
 MOV DH,Y
 INT 010h
 MOV AH,9
 MOV BH,DataVideo.MIV.Page
 MOV AL,Chr
 MOV BL,Attr
 MOV CX,1
 INT 010h
END;

Procedure SetCur;Assembler;ASM
 MOV CL,A
 MOV CH,B
 MOV Word Ptr DataVideo.MIV.StartCur,CX
 MOV AH,01h
 INT 010h
END;

Procedure SetCurPos;Assembler;ASM
 MOV AH,02h
 MOV DL,X
 MOV DH,Y
 MOV Word Ptr DataVideo.MIV.XCur,DX
 MOV BH,DataVideo.MIV.Page
 INT 010h
END;

Procedure SetMatrix;Assembler;ASM
 PUSH BP
  MOV AX,$1100
  MOV BL,Palette
  MOV BH,Height
  MOV DX,Start
  MOV CX,Number
  LES BP,X
  INT $10
 POP BP
END;

Procedure SetModeMtx;Begin End;
Procedure SetModeScr;Begin End;
Procedure SetPalBlk;Begin End;
Procedure SetPaletteRGB;Begin End;
Procedure SetPalRGB;Begin End;

Procedure SetPg;Assembler;ASM
 MOV Pg,AL
 MOV AL,DataVideo.MIV.Pg
END;

Procedure SetPixel;Assembler;ASM
 MOV AH,0Ch
 MOV AL,Kr.Byte
 MOV BH,DataVideo.MIV.Page
 MOV CX,X
 MOV DX,Y
 INT 010h
END;

Procedure SetHorizontalScale;Begin
End;

Procedure SetVerticalScale;Begin
End;

Procedure SetVisualPg;Assembler;ASM
 MOV AH,5
 MOV AL,DataVideo.MIV.Page
 INT 010h
END;

Procedure SplitScreen;Begin End;

Function IsLuxe;Assembler;ASM
 MOV AL,No { Toujours faux}
END;

Procedure CloseIcon;Begin
 SetCube(X,Y,' ',Attr);
 SetCube(X+1,Y,'-',Attr);
 SetCube(X+2,Y,' ',Attr);
End;

Procedure DownIcon;Begin
 SetCube(X,Y,#$19,Attr);
End;

Procedure LeftIcon;Begin
 SetCube(X,Y,'<',Attr);
End;

Procedure RightIcon;Begin
 SetCube(X,Y,'>',Attr);
End;

Procedure SelIcon;Begin
 SetCube(X,Y,'(',Attr);
 SetCube(X+1,Y,' ',Attr);
 SetCube(X+2,Y,')',Attr);
End;

Procedure UnSelIcon;Begin
 SetCube(X,Y,'(',Attr);
 SetCube(X+1,Y,#7,Attr);
 SetCube(X+2,Y,')',Attr);
End;

Procedure UpIcon;Begin
 SetCube(X,Y,#$18,Attr);
End;

Procedure EndDriverBios;Assembler;ASM END;

END.