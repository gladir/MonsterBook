{scx256.Inc}

Procedure SetCube;Assembler;ASM
 MOV BL,DataVideo.MIV.NumXTexts
 MOV AL,X
 CMP AL,BL
 JB @1
 XOR AH,AH
 DIV BL
 ADD Y,AL
 MOV X,AH
 MOV AL,AH
@1:
 MOV BH,DataVideo.MIV.NumYTexts
 CMP Y,BH
 JAE @End
 XCHG AX,CX
 MOV ES,DataVideo.MIV.SegBuffer
 {$IFDEF __386__}
  DB 36h,0Fh,0B6h,05Eh,0Ah { MOVZX BX,Byte Ptr SS:[BP+0Ah] }
 {$ELSE}
  MOV BL,Y
  XOR BH,BH
 {$ENDIF}
 SHL BX,1
 MOV DI,Word Ptr RawTxtY[BX]
 MOV BL,X
 ADD DI,BX
 SHL DI,1
 MOV AL,Chr
 MOV AH,Attr
 STOSW
 XCHG AX,CX
 XOR AH,AH
 {$IFOPT G+}SHL AX,3{$ELSE}SHL AX,1;SHL AX,1;SHL AX,1{$ENDIF}
 {$IFDEF __386__}
  DB 36h,0Fh,0B6h,05Eh,0Ah { MOVZX BX,Byte Ptr SS:[BP+0Ah] }
 {$ELSE}
  XOR BH,BH
  MOV BL,Y
 {$ENDIF}
 SHL BX,1
 PUSH AX
 PUSH Word Ptr RawY[BX]
 PUSH Word Ptr Chr
 PUSH Word Ptr Attr
 PUSH CS
 CALL Near Ptr SetGCube
@End:
END;