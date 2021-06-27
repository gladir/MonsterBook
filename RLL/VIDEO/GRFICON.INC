{GrfIcon.Inc}

Function IsLuxe:Bool;Assembler;ASM
 MOV AL,Ya { En mode graphique, le luxe est toujours disponible...}
END;

Function HeightChr:Byte;Assembler;ASM
 MOV AL,Byte Ptr DataVideo.MIV.HeightChar
END;

Procedure Buf8;Assembler;ASM
 DW 0, 8, 24, 40, 72, 80, 96, 120
END;

Procedure Buf14;Assembler;ASM
 DW 0, 8, 16, 24, 32, 40, 48, 56, 80, 88, 96, 104, 112, 120
END;

Procedure PutIcon(X,Y:Byte;Off:Word);Var J,XG,YG:Word;Buffer:^TByte;Begin
 ASM
  MOV AX,Off
  MOV Word Ptr Buffer,AX
  MOV Word Ptr Buffer[2],CS
  MOV AL,X
  XOR AH,AH
  {$IFOPT G+}
   SHL AX,3
  {$ELSE}
   SHL AX,1
   SHL AX,1
   SHL AX,1
  {$ENDIF}
  MOV XG,AX
  MOV BL,Y
  XOR BH,BH
  SHL BX,1
  MOV AX,Word Ptr RawY[BX]
  MOV YG,AX
 END;
 Case(HeightChr)of
  8:For J:=0to 7do ClrLnHorImg(XG,YG+J,16,4,Buffer^[MemW[CSeg:Ofs(Buf8)+(J shl 1)]]);
  14:For J:=0to 13do ClrLnHorImg(XG,YG+J,16,4,Buffer^[MemW[CSeg:Ofs(Buf14)+(J shl 1)]]);
  Else For J:=0to 15do Begin
   ClrLnHorImg(XG,YG+J,16,4,Buffer^);
   ASM ADD Word Ptr Buffer,8;END;
  End;
 End;
End;

Procedure CloseIconData;Assembler;ASM
 DB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$F8
 DB $FC,$CC,$CC,$CC,$CC,$CC,$CC,$C0
 DB $FC,$CC,$CC,$CC,$CC,$CC,$CC,$C0
 DB $FC,$CF,$F0,$CC,$CC,$CF,$F0,$C0
 DB $FC,$CF,$FF,$0C,$CC,$FF,$FC,$C0
 DB $FC,$CC,$FF,$F0,$CF,$FF,$0C,$C0
 DB $FC,$CC,$CF,$FF,$FF,$F0,$CC,$C0
 DB $FC,$CC,$CC,$FF,$FF,$0C,$CC,$C0
 DB $FC,$CC,$CC,$FF,$FF,$0C,$CC,$C0
 DB $FC,$CC,$CF,$FF,$FF,$F0,$CC,$C0
 DB $FC,$CC,$FF,$F0,$CF,$FF,$0C,$C0
 DB $FC,$CF,$FF,$0C,$CC,$FF,$F0,$C0
 DB $FC,$CF,$F0,$CC,$CC,$CF,$F0,$C0
 DB $FC,$CC,$CC,$CC,$CC,$CC,$CC,$C0
 DB $FC,$CC,$CC,$CC,$CC,$CC,$CC,$C0
 DB $80,$00,$00,$00,$00,$00,$00,$00
END;

Procedure CloseIcon;Begin;PutIcon(X,Y,Ofs(CloseIconData))End;

Procedure DownIconData;Assembler;ASM
 DB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$F8
 DB $F9,$99,$99,$99,$99,$99,$99,$90
 DB $F9,$99,$99,$FF,$FF,$09,$99,$90
 DB $F9,$99,$99,$FF,$FF,$09,$99,$90
 DB $F9,$99,$99,$FF,$FF,$09,$99,$90
 DB $F9,$99,$99,$FF,$FF,$09,$99,$90
 DB $F9,$99,$99,$FF,$FF,$09,$99,$90
 DB $F9,$99,$99,$FF,$FF,$09,$99,$90
 DB $F9,$FF,$FF,$FF,$FF,$FF,$FF,$00
 DB $F9,$9F,$FF,$FF,$FF,$FF,$F0,$90
 DB $F9,$99,$FF,$FF,$FF,$FF,$09,$90
 DB $F9,$99,$9F,$FF,$FF,$F0,$99,$90
 DB $F9,$99,$99,$FF,$FF,$09,$99,$90
 DB $F9,$99,$99,$9F,$F0,$99,$99,$90
 DB $F9,$99,$99,$99,$99,$99,$99,$90
 DB $80,$00,$00,$00,$00,$00,$00,$00
END;

Procedure DownIcon;Begin;PutIcon(X,Y,Ofs(DownIconData))End;

Procedure LeftIconData;Assembler;ASM
 DB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$F8
 DB $F9,$99,$99,$99,$99,$99,$99,$90
 DB $F9,$99,$99,$9F,$09,$99,$99,$90
 DB $F9,$99,$99,$FF,$09,$99,$99,$90
 DB $F9,$99,$9F,$FF,$09,$99,$99,$90
 DB $F9,$99,$FF,$FF,$09,$99,$99,$90
 DB $F9,$9F,$FF,$FF,$FF,$FF,$F0,$90
 DB $F9,$FF,$FF,$FF,$FF,$FF,$F0,$90
 DB $F9,$FF,$FF,$FF,$FF,$FF,$F0,$90
 DB $F9,$9F,$FF,$FF,$FF,$FF,$F0,$90
 DB $F9,$99,$FF,$FF,$09,$99,$99,$90
 DB $F9,$99,$9F,$FF,$09,$99,$99,$90
 DB $F9,$99,$99,$FF,$09,$99,$99,$90
 DB $F9,$99,$99,$9F,$09,$99,$99,$90
 DB $F9,$99,$99,$99,$99,$99,$99,$90
 DB $80,$00,$00,$00,$00,$00,$00,$00
END;

Procedure LeftIcon;Begin;PutIcon(X,Y,Ofs(LeftIconData))End;

Procedure RightIconData;Assembler;ASM
 DB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$F8
 DB $F9,$99,$99,$99,$99,$99,$99,$90
 DB $F9,$99,$99,$9F,$09,$99,$99,$90
 DB $F9,$99,$99,$9F,$F0,$99,$99,$90
 DB $F9,$99,$99,$9F,$FF,$09,$99,$90
 DB $F9,$99,$99,$9F,$FF,$F0,$99,$90
 DB $F9,$FF,$FF,$FF,$FF,$FF,$09,$90
 DB $F9,$FF,$FF,$FF,$FF,$FF,$F0,$90
 DB $F9,$FF,$FF,$FF,$FF,$FF,$F0,$90
 DB $F9,$FF,$FF,$FF,$FF,$FF,$09,$90
 DB $F9,$99,$99,$9F,$FF,$F0,$99,$90
 DB $F9,$99,$99,$9F,$FF,$09,$99,$90
 DB $F9,$99,$99,$9F,$F0,$99,$99,$90
 DB $F9,$99,$99,$9F,$09,$99,$99,$90
 DB $F9,$99,$99,$99,$99,$99,$99,$90
 DB $80,$00,$00,$00,$00,$00,$00,$00
END;

Procedure RightIcon;Var J,XG,YG:Word;Buffer:Pointer;Begin
 PutIcon(X,Y,Ofs(RightIconData))
End;

Procedure UnselIcon16x8;Near;Assembler;ASM
 DB 00000111B,11100000B { 0 }
 DB 00111000B,00011100B { 1 }
 DB 01000000B,00000010B { 2 }
 DB 11000000B,00000011B { 3 }
 DB 11000000B,00000011B { 4 }
 DB 01000000B,00000010B { 5 }
 DB 00111000B,00011100B { 6 }
 DB 00000111B,11100000B { 7 }
END;

Procedure UnselIcon16x14;Near;Assembler;ASM
 DB 00000000B,00000000B { 0 }
 DB 00000111B,11100000B { 1 }
 DB 00011100B,00111000B { 2 }
 DB 00110000B,00001100B { 3 }
 DB 01100000B,00000110B { 4 }
 DB 01000000B,00000010B { 5 }
 DB 11000000B,00000011B { 6 }
 DB 11000000B,00000011B { 7 }
 DB 01000000B,00000010B { 8 }
 DB 01100000B,00000110B { 9 }
 DB 00110000B,00001100B { 10 }
 DB 00011100B,00111000B { 11 }
 DB 00000111B,11100000B { 12 }
 DB 00000000B,00000000B { 13 }
END;

Procedure UnselIcon16x16;Near;Assembler;ASM
 DB 00000000B,00000000B { 0 }
 DB 00000000B,00000000B { 1 }
 DB 00000111B,11100000B { 2 }
 DB 00011100B,00111000B { 3 }
 DB 00110000B,00001100B { 4 }
 DB 01100000B,00000110B { 5 }
 DB 01000000B,00000010B { 6 }
 DB 11000000B,00000011B { 7 }
 DB 11000000B,00000011B { 8 }
 DB 01000000B,00000010B { 9 }
 DB 01100000B,00000110B { 10 }
 DB 00110000B,00001100B { 11 }
 DB 00011100B,00111000B { 12 }
 DB 00000111B,11100000B { 13 }
 DB 00000000B,00000000B { 14 }
 DB 00000000B,00000000B { 15 }
END;

Procedure DossierIcon(X,Y,Attr:Byte;Off:Wd);Near;Var J,XG,YG:Word;Buffer:^TByte;Begin
 ASM
  MOV AX,Off
  MOV Word Ptr Buffer,AX
  MOV Word Ptr Buffer[2],CS
  MOV AL,X
  XOR AH,AH
  {$IFOPT G+}
   SHL AX,3
  {$ELSE}
   SHL AX,1
   SHL AX,1
   SHL AX,1
  {$ENDIF}
  MOV XG,AX
  MOV BL,Y
  XOR BH,BH
  SHL BX,1
  MOV AX,Word Ptr RawY[BX]
  MOV YG,AX
 END;
 For J:=0to HeightChr-1do Begin
  Copy8Bin(XG,YG+J,Buffer^[0],Attr shr 4,Attr and$F);
  ASM INC Word Ptr Buffer;END;
  Copy8Bin(XG+8,YG+J,Buffer^[0],Attr shr 4,Attr and$F);
  ASM INC Word Ptr Buffer;END;
 End;
End;

Procedure UnSelIcon;Begin
 Case(HeightChr)of
  8:DossierIcon(X,Y,Attr,Ofs(UnselIcon16x8));
  14:DossierIcon(X,Y,Attr,Ofs(UnselIcon16x14));
  Else DossierIcon(X,Y,Attr,Ofs(UnselIcon16x16));
 End;
End;

Procedure SelIcon;
Var
 J,XG,YG,H:Word;
 KC:Byte;
Begin
 ASM
  MOV AL,DataVideo.MIV.HeightChar
  XOR AH,AH
  MOV H,AX
  MOV AL,X
  XOR AH,AH
  {$IFOPT G+}
   SHL AX,3
  {$ELSE}
   SHL AX,1
   SHL AX,1
   SHL AX,1
  {$ENDIF}
  MOV XG,AX
  MOV BL,Y
  XOR BH,BH
  SHL BX,1
  MOV AX,Word Ptr RawY[BX]
  MOV YG,AX
 END;
 UnSelIcon(X,Y,Attr);
 KC:=Attr and$7;
 If KC=0Then Case(Attr shr 4)of
  7:KC:=$B;
  $F:KC:=7;
 End;
 PutFillCircle(XG+8,YG+(H shr 1)-1,H shr 2,KC);
 If HeightChr>=15Then Begin
  {SetPixel(XG+5,YG+5,$F);}SetPixel(XG+6,YG+5,$F);SetPixel(XG+7,YG+5,$F);
  SetPixel(XG+5,YG+6,$F);SetPixel(XG+6,YG+6,$F);SetPixel(XG+7,YG+6,$F);
  SetPixel(XG+5,YG+7,$F);SetPixel(XG+6,YG+7,$F);{SetPixel(XG+7,YG+7,$F);}
 End;
End;

Procedure UpIconData;Assembler;ASM
 DB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$F8
 DB $F9,$99,$99,$99,$99,$99,$99,$90
 DB $F9,$99,$99,$9F,$F0,$99,$99,$90
 DB $F9,$99,$99,$FF,$FF,$09,$99,$90
 DB $F9,$99,$9F,$FF,$FF,$F0,$99,$90
 DB $F9,$99,$FF,$FF,$FF,$FF,$09,$90
 DB $F9,$9F,$FF,$FF,$FF,$FF,$F0,$90
 DB $F9,$FF,$FF,$FF,$FF,$FF,$FF,$00
 DB $F9,$99,$99,$FF,$FF,$09,$99,$90
 DB $F9,$99,$99,$FF,$FF,$09,$99,$90
 DB $F9,$99,$99,$FF,$FF,$09,$99,$90
 DB $F9,$99,$99,$FF,$FF,$09,$99,$90
 DB $F9,$99,$99,$FF,$FF,$09,$99,$90
 DB $F9,$99,$99,$FF,$FF,$09,$99,$90
 DB $F9,$99,$99,$99,$99,$99,$99,$90
 DB $80,$00,$00,$00,$00,$00,$00,$00
END;

Procedure UpIcon;Begin;PutIcon(X,Y,Ofs(UpIconData))End;

Procedure ZoomIconData;Assembler;ASM
 DB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$F8
 DB $F9,$99,$99,$99,$99,$99,$99,$90
 DB $F9,$88,$88,$88,$88,$88,$89,$90
 DB $F9,$80,$00,$00,$00,$00,$80,$90
 DB $F9,$80,$99,$99,$99,$99,$80,$90
 DB $F9,$80,$99,$99,$99,$99,$80,$90
 DB $F9,$80,$99,$99,$99,$99,$80,$90
 DB $F9,$80,$99,$99,$99,$99,$80,$90
 DB $F9,$80,$99,$99,$99,$99,$80,$90
 DB $F9,$80,$99,$99,$99,$99,$80,$90
 DB $F9,$80,$99,$99,$99,$99,$80,$90
 DB $F9,$80,$99,$99,$99,$99,$80,$90
 DB $F9,$88,$88,$88,$88,$88,$80,$90
 DB $F9,$90,$00,$00,$00,$00,$00,$90
 DB $F9,$99,$99,$99,$99,$99,$99,$90
 DB $80,$00,$00,$00,$00,$00,$00,$00
END;

Procedure ZoomIcon;Begin;PutIcon(X,Y,Ofs(ZoomIconData))End;

Procedure IconProgram16x8;Assembler;ASM
 DB 00000000B,00000000B { 0 }
 DB 00000000B,00000000B { 1 }
 DB 00000000B,01111000B { 2 }
 DB 00111111B,10000100B { 3 }
 DB 01000000B,00000010B { 4 }
 DB 01000000B,00000010B { 5 }
 DB 00111111B,11111100B { 6 }
 DB 00000000B,00000000B { 7 }
End;

Procedure IconDocument16x8;Assembler;ASM
 DB 00000000B,10000000B { 0 }
 DB 00000000B,01111100B { 1 }
 DB 00111111B,10000010B { 2 }
 DB 01000000B,00000001B { 3 }
 DB 01011101B,01101101B { 4 }
 DB 01000000B,00000001B { 5 }
 DB 00111111B,11111110B { 6 }
 DB 00000000B,00000000B { 7 }
End;

Procedure IconProgram16x14;Assembler;ASM
 DB 00000000B,00000000B { 0 }
 DB 00000000B,00000000B { 1 }
 DB 00000000B,00111100B { 2 }
 DB 00000000B,01000010B { 3 }
 DB 00111111B,10000001B { 4 }
 DB 01000000B,00000001B { 5 }
 DB 01000000B,00000001B { 6 }
 DB 01000000B,00000001B { 7 }
 DB 01000000B,00000001B { 8 }
 DB 01000000B,00000001B { 9 }
 DB 01000000B,00000001B { 10 }
 DB 01000000B,00000001B { 11 }
 DB 00111111B,11111110B { 12 }
 DB 00000000B,00000000B { 13 }
End;

Procedure IconDocument16x14;Assembler;ASM
 DB 00000000B,00000000B { 0 }
 DB 00000000B,00000000B { 1 }
 DB 00000000B,00111100B { 2 }
 DB 00000000B,01000010B { 3 }
 DB 00111111B,10000001B { 4 }
 DB 01000000B,00000001B { 5 }
 DB 01011111B,11111101B { 6 }
 DB 01000000B,00000001B { 7 }
 DB 01011111B,11111101B { 8 }
 DB 01000000B,00000001B { 9 }
 DB 01011111B,11111101B { 10 }
 DB 01000000B,00000001B { 11 }
 DB 00111111B,11111110B { 12 }
 DB 00000000B,00000000B { 13 }
END;

Procedure IconProgram16x16;Assembler;ASM
 DB 00000000B,00000000B { 0 }
 DB 00000000B,00000000B { 1 }
 DB 00000000B,01111000B { 2 }
 DB 00000000B,10000100B { 3 }
 DB 00111111B,00000010B { 4 }
 DB 01000000B,00000010B { 5 }
 DB 01000000B,00000010B { 6 }
 DB 01000000B,00000010B { 7 }
 DB 01000000B,00000010B { 8 }
 DB 01000000B,00000010B { 9 }
 DB 01000000B,00000010B { 10 }
 DB 01000000B,00000010B { 11 }
 DB 01000000B,00000010B { 12 }
 DB 01000000B,00000010B { 13 }
 DB 00111111B,11111100B { 14 }
 DB 00000000B,00000000B { 15 }
END;

Procedure IconDocument16x16;Assembler;ASM
 DB 00000000B,00000000B { 0 }
 DB 00000000B,00000000B { 1 }
 DB 00000000B,01111000B { 2 }
 DB 00000000B,10000100B { 3 }
 DB 00111111B,00000010B { 4 }
 DB 01000000B,00000010B { 5 }
 DB 01011111B,11111010B { 6 }
 DB 01000000B,00000010B { 7 }
 DB 01011111B,11111010B { 8 }
 DB 01000000B,00000010B { 9 }
 DB 01011111B,11111010B { 10 }
 DB 01000000B,00000010B { 11 }
 DB 01011111B,11111010B { 12 }
 DB 01000000B,00000010B { 13 }
 DB 00111111B,11111100B { 14 }
 DB 00000000B,00000000B { 15 }
END;

Procedure DossierDocumentIcon(X,Y,Attr:Byte);Begin
 Case(HeightChr)of
  8:DossierIcon(X,Y,Attr,Ofs(IconDocument16x8));
  14:DossierIcon(X,Y,Attr,Ofs(IconDocument16x14));
  Else DossierIcon(X,Y,Attr,Ofs(IconDocument16x16));
 End;
End;

Procedure DossierProgramIcon(X,Y,Attr:Byte);Begin
 Case(HeightChr)of
  8:DossierIcon(X,Y,Attr,Ofs(IconProgram16x8));
  14:DossierIcon(X,Y,Attr,Ofs(IconProgram16x14));
  Else DossierIcon(X,Y,Attr,Ofs(IconProgram16x16));
 End;
End;