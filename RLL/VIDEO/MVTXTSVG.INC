{MvTxtSVG.Inc}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                             Proc‚dure MoveText                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure est utilis‚ par d‚faut en mode graphique Super VGA et VESA
 256 couleurs pour d‚placer la fenˆtre vers le haut o— le bas de celle-ci.
}

Procedure MoveText;
Var GX1,GX2,L,L2,J,YL,YL2,TB1,TB2,TB3,I:Wd;H,Attr:Byte;
    BytesPerLine:Word;Buffer:Array[0..4095]of Byte;
Begin
 If(X2<X1)or(Y2<Y1)Then Exit;
 ASM
  PUSH DS
    {Calcule la longueur d'une ligne en texte }
   MOV AL,X2
   SUB AL,X1
   XOR AH,AH
   INC AX
   MOV L,AX
    {Calcule la longueur d'une ligne en pixels }
   MOV CL,3
   SHL AX,CL
   MOV L2,AX
    {Calcule la coordonn‚e X1 texte en pixels}
   MOV AL,X1
   XOR AH,AH
   SHL AX,CL
   MOV GX1,AX
    {Calcule la coordonn‚e X2 texte en pixels}
   MOV AL,X2
   XOR AH,AH
   SHL AX,CL
   OR  AL,7
   MOV GX2,AX
    {M‚canisme lui-mˆme de d‚placement dans le tampon d'acc‚l‚ration}
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
   {$IFDEF __386__}
    SHR CX,1
    DB ciREP;DW ciMOVSD
    ADC CX,CX
   {$ENDIF}
   REP MOVSW
   OR  DL,DL
   JNZ @@Loop
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
   {$IFDEF __386__}
    SHR CX,1
    DB ciREP;DW ciMOVSD
    ADC CX,CX
   {$ENDIF}
   REP MOVSW
   INC DL
   CMP DL,DH
   JNE @@LoopInc
@@End:
  POP DS
  MOV AL,DataVideo.MIV.HeightChar
  MOV H,AL
 END;
 TB1:=0;TB2:=0;
 {$IFDEF Graf65536}
  BytesPerLine:=L2 shl 1;
 {$ELSE}
  BytesPerLine:=L2;
 {$ENDIF}
 While TB2+BytesPerLine<=SizeOf(Buffer)do Begin
  Inc(TB2,BytesPerLine);
  Inc(TB1);
 End;
 If(Y3<Y1)Then Begin
  {YL:=(((Y1-Y3)+Y2)-(Y2-Y1+1))*H;YL2:=(Y2-(Y2-Y1+1))*H;}
  YL:=(((Y1-Y3)+Y2)-(Y2-Y1+1));YL2:=(Y2-(Y2-Y1+1));
  ASM
   MOV BX,YL
   SHL BX,1
   MOV AX,Word Ptr RawY[BX]
   MOV YL,AX
   MOV BX,YL2
   SHL BX,1
   MOV AX,Word Ptr RawY[BX]
   MOV YL2,AX
  END;
  J:=(Y2-Y1+1)*H;
  While J<>0do Begin
   TB3:=0;
   For I:=0to TB1-1do Begin
    GetLnHorImg(GX1,YL,GX2,Buffer[TB3]);
    Inc(TB3,BytesPerLine);Inc(YL);
   End;
   TB3:=0;
   For I:=0to TB1-1do Begin
    _ClrLnHorImg(GX1,YL2,L2,Buffer[TB3]);
    Inc(TB3,BytesPerLine);Inc(YL2);Dec(J);
    If J=0Then Break;
   End;
  End;
(*  For J:=(Y2-Y1+1)*H-1downto 0do Begin
   GetLnHorImg(GX1,YL,GX2,Buffer);
   {$IFDEF Graf65536}
    ClrLnHorImg(GX1,YL2,L2,16,Buffer);
   {$ELSE}
    ClrLnHorImg(GX1,YL2,L2,8,Buffer);
   {$ENDIF}
   Inc(YL2);Inc(YL)
  End*)
 End
  Else
 Begin
  {YL:=(Y1+(Y2-Y1+1))*H-1;YL2:=(Y3+(Y2-Y1+1))*H-1;}
  YL:=Y1+(Y2-Y1+1);YL2:=Y3+(Y2-Y1+1);
  ASM
   MOV BX,YL
   SHL BX,1
   MOV AX,Word Ptr RawY[BX]
   DEC AX
   MOV YL,AX
   MOV BX,YL2
   SHL BX,1
   MOV AX,Word Ptr RawY[BX]
   DEC AX
   MOV YL2,AX
  END;
(*  For J:=(Y2-Y1+1)*H-1downto 0do Begin
   GetLnHorImg(GX1,YL,GX2,Buffer);
   {$IFDEF Graf65536}
    ClrLnHorImg(GX1,YL2,L2,16,Buffer);
   {$ELSE}
    ClrLnHorImg(GX1,YL2,L2,8,Buffer);
   {$ENDIF}
   Dec(YL2);Dec(YL)
  End;*)
  J:=(Y2-Y1+1)*H;
  While J<>0do Begin
   TB3:=0;
   For I:=0to TB1-1do Begin
    GetLnHorImg(GX1,YL,GX2,Buffer[TB3]);
    Inc(TB3,BytesPerLine);Dec(YL);
   End;
   TB3:=0;
   For I:=0to TB1-1do Begin
    _ClrLnHorImg(GX1,YL2,L2,Buffer[TB3]);
    Inc(TB3,BytesPerLine);Dec(YL2);Dec(J);
    If J=0Then Break;
   End;
  End;
 End;
End;