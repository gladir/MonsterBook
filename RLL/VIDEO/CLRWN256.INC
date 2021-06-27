{ClrWn256.Inc}

Procedure ClrWn;Assembler;ASM
 CLD
  { Fixe les 4 bits }
 MOV DX,03C4h
 MOV AX,2+(15 shl 8)
 OUT DX,AX
  {Affiche la boåte}
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
 MOV DL,X1
 XOR DH,DH
 SHL DX,1
 ADD BX,DX
 {$IFNDEF __360x480c256}
  ADD BX,DataVideo.MIV.AddrPage
 {$ENDIF}
 MOV DL,Y2
 SUB DL,Y1
 XOR DH,DH
 INC DX
 MOV DI,DX
 SHL DI,1
 MOV DX,Word Ptr RawY[DI]
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
  MOV ES,DataVideo.MIV.SegVideo
 {$ENDIF}
@@Home:
 MOV DI,BX
 MOV CX,SI
 REP STOSW
 ADD BX,DataVideo.MIV.BytesPerLine
 DEC DX
 OR  DX,DX
 JNE @@Home
 MOV BL,Y1
 XOR BH,BH
 SHL BX,1
 MOV DI,Word Ptr RawTxtY[BX]
 MOV DL,DataVideo.MIV.NumXTexts
 MOV ES,DataVideo.MIV.SegBuffer
 SHL DX,1
 MOV SI,DX
 MOV BL,X1
 ADD DI,BX
 SHL DI,1
 MOV AL,' '
 MOV AH,Attr
 {$IFDEF __386__}
  DB ciPushAX,ciPushAX
  DW ciPopEAX
 {$ENDIF}
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
   {$IFDEF __386__}
    SHR CX,1
    DB ciREP;DW ciSTOSD
    ADC CX,CX
   {$ENDIF}
   REP STOSW
  POP DI
 POP CX
 ADD DI,SI
 INC CL
 CMP CL,CH
 JBE @@Loop
END;