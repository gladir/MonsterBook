{MoveT256.Inc}

Procedure MoveText;Var I,J,L,YL1,YL2,X1a,X3a:Wd;Begin
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
  (* M‚thode Manuel *)
 X1a:=X1 shl 1;X3a:=X3 shl 1;L:=L shl 2;
 For I:=0to 3do Begin
  ASM { Plane X }
   MOV DX,03C4h
   MOV AL,2
   MOV AH,1
   MOV CL,Byte Ptr I
   SHL AH,CL
   OUT DX,AX
   MOV DX,03CEh
   MOV AL,4
   MOV AH,Byte Ptr I
   OUT DX,AX
  END;
  If(Y3<Y1)Then For J:=Y2-Y1+1downto 0do ASM
   XOR BH,BH
   MOV BL,Y1
   SUB BL,Y3
   ADD BL,Y2
   SUB BX,J
   SHL BX,1
   MOV BX,Word Ptr RawY[BX]
   MOV YL1,BX
   XOR BH,BH
   MOV BL,Y2
   SUB BX,J
   SHL BX,1
   MOV BX,Word Ptr RawY[BX]
   MOV YL2,BX
   XOR BX,BX
   PUSH DS
   MOV ES,DataVideo.MIV.SegVideo
   PUSH ES
   POP DS
   CLD
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
@@Restart:
   PUSH SI
    PUSH DI
    MOV CX,L
    {$IFDEF __386__}
     SHR CX,1
     DB ciREP;DW ciMOVSD
     ADC CX,CX
    {$ENDIF}
    REP MOVSW
    POP DI
   POP SI
   ADD DI,DataVideo.MIV.BytesPerLine
   ADD SI,DataVideo.MIV.BytesPerLine
   INC BX
   TEST BL,DataVideo.MIV.HeightChar
   JZ  @@Restart
   POP DS
  END
   Else
  For J:=Y2-Y1 downto 0do ASM
   XOR BH,BH
   MOV BL,Y1
   ADD BX,J
   SHL BX,1
   MOV BX,Word Ptr RawY[BX]
   MOV YL1,BX
   XOR BH,BH
   MOV BL,Y3
   ADD BX,J
   SHL BX,1
   MOV BX,Word Ptr RawY[BX]
   MOV YL2,BX
   XOR BX,BX
   PUSH DS
   MOV ES,DataVideo.MIV.SegVideo
   PUSH ES
   POP DS
   CLD
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
@@Restart:
   PUSH SI
    PUSH DI
    MOV CX,L
    {$IFDEF __386__}
     SHR CX,1
     DB ciREP;DW ciMOVSD
     ADC CX,CX
    {$ENDIF}
    REP MOVSW
    POP DI
   POP SI
   ADD DI,DataVideo.MIV.BytesPerLine
   ADD SI,DataVideo.MIV.BytesPerLine
   INC BX
   TEST BL,DataVideo.MIV.HeightChar
   JZ  @@Restart
   POP DS
  END;
 End;
End;