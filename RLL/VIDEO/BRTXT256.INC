{BrTxt256.Inc}

Procedure BarTxtHor(X1,Y,X2:Byte;Chr:Char;Attr:Byte);Assembler;Var L:Wd;Fore,Back:Byte;ASM
 PUSH DS
  CLD
  MOV AL,Attr
  MOV AH,AL
  AND AL,0Fh
  MOV Fore,AL
  {$IFOPT G+}SHR AH,4{$ELSE}SHR AH,1;SHR AH,1;SHR AH,1;SHR AH,1{$ENDIF}
  MOV Back,AH
  MOV BL,X2
  SUB BL,X1
  INC BL
  XOR BH,BH
  MOV L,BX
  LDS SI,DataVideo.MIV.TxtMtx
  MOV BL,Chr
  SHL BX,1
  ADD SI,Word Ptr RawY[BX]
  MOV ES,DataVideo.MIV.SegVideo
  MOV BL,Y
  XOR BH,BH
  SHL BX,1
  MOV BX,Word Ptr RawY[BX]
  SHL BX,1
  MOV DI,Word Ptr X1
  AND DI,00FFh
  SHL DI,1
  ADD DI,Word Ptr RealRawY[BX]
  {$IFNDEF __360x480c256}
   ADD DI,DataVideo.MIV.AddrPage
  {$ENDIF}
  MOV DX,3C4h
  MOV BL,DataVideo.MIV.HeightChar
  XOR BH,BH
@0:
  MOV AH,DS:[SI]
  AND AH,0Fh
  MOV AL,02h
  OUT DX,AX
  MOV AL,Fore
  MOV CX,L
@1:
  STOSB
  SCASB
  LOOP @1
  SUB DI,L
  SUB DI,L
  INC DI
  MOV AH,DS:[SI]
  {$IFOPT G+}SHR AH,4{$ELSE}SHR AH,1;SHR AH,1;SHR AH,1;SHR AH,1{$ENDIF}
  MOV AL,02h
  OUT DX,AX
  MOV AL,Fore
  MOV CX,L
@2:
  STOSB
  SCASB
  LOOP @2
  SUB DI,L
  SUB DI,L
  DEC DI
  MOV AH,DS:[SI]
  NOT AH
  AND AH,0Fh
  MOV AL,02h
  OUT DX,AX
  MOV AL,Back
  MOV CX,L
@3:
  STOSB
  SCASB
  LOOP @3
  SUB DI,L
  SUB DI,L
  INC DI
  MOV AH,DS:[SI]
  NOT AH
  {$IFOPT G+}SHR AH,4{$ELSE}SHR AH,1;SHR AH,1;SHR AH,1;SHR AH,1{$ENDIF}
  MOV AL,02h
  OUT DX,AX
  MOV AL,Back
  MOV CX,L
@4:
  STOSB
  SCASB
  LOOP @4
  SUB DI,L
  SUB DI,L
  DEC DI
  ADD DI,DataVideo.MIV.BytesPerLine
  INC SI
  DEC BX
  OR  BL,BL
  JNZ @0
 POP DS
  { Fixe dans le tampon acc‚l‚rateur... }
 MOV ES,DataVideo.MIV.SegBuffer
 MOV BL,Y
 XOR BH,BH
 SHL BX,1
 MOV DI,Word Ptr RawTxtY[BX]
 MOV BL,X1
 ADD DI,BX
 SHL DI,1
 MOV CX,L
 MOV AH,Attr
 MOV AL,Chr
 CLD
 {$IFDEF __386__}
  DB  ciPushAX,ciPushAX { EAX := AX:AX }
  DW  ciPopEAX
  SHR CX,1
  DB ciREP;DW ciSTOSD
  ADC CX,CX
 {$ENDIF}
 REP STOSW
END;