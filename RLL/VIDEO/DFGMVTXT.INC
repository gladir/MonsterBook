{DefaultGraphicsMoveText.Inc}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                             Proc‚dure MoveText                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure est utilis‚ par d‚faut en mode graphique pour d‚placer la
 fenˆtre vers le haut o— le bas de celle-ci.
}

Procedure MoveText;Var L:Wd;Attr:Byte;Begin
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
 END;
 ASM
  MOV BL,Y2
  XOR BH,BH
  SHL BX,1
  MOV DI,Word Ptr RawTxtY[BX]
  MOV ES,DataVideo.MIV.SegBuffer
  SHL DI,1
  INC DI
  MOV AL,ES:[DI]
  {$IFOPT G+}
   SHR AL,4
  {$ELSE}
   SHR AL,1
   SHR AL,1
   SHR AL,1
   SHR AL,1
  {$ENDIF}
  MOV Attr,AL
  MOV AX,$0601
  MOV BL,Y1
  CMP Y3,BL
  JB  @Skip
  INC AH
@Skip:
  MOV BH,Attr
  MOV CL,X1
  MOV CH,Y3
  MOV DL,X2
  MOV DH,Y2
  CMP AH,6
  JE  @S2
  MOV CH,Y1
  ADD DH,Y3
  SUB DH,CH
@S2:
  INT 010h
 END;
End;