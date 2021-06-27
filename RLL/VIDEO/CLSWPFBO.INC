{ClearScreenWithPutFillBox.Inc}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                             Proc‚dure ClrScr                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure efface l'‚cran ainsi que son tampon d'acc‚l‚ration tout
 en utilisant la proc‚dure ®PutFillBox¯.
}

Procedure ClrScr;Assembler;ASM
 XOR AX,AX
 PUSH AX
 PUSH AX
 MOV BX,DataVideo.MIV.NumXPixels
 DEC BX
 PUSH BX
 MOV BX,DataVideo.MIV.NumYPixels
 DEC BX
 PUSH BX
 MOV AL,Attr
 {$IFOPT G+}
  SHR AX,4
 {$ELSE}
  MOV CL,4
  SHR AX,CL
 {$ENDIF}
 PUSH AX
 PUSH CS
 CALL Near Ptr PutFillBox
  { Actualise le tampon d'acc‚l‚ration...}
 CLD
 XOR DI,DI
 MOV ES,DataVideo.MIV.SegBuffer
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
  DB ciREP; DW ciSTOSD
  ADC CX,CX
  REP STOSW
 {$ELSE}
  REP STOSW
 {$ENDIF}
END;