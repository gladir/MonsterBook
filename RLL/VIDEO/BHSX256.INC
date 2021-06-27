{bhsx256.Inc}

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