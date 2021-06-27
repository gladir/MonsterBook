{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Proc‚dure SetCur                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure fixe le format de d‚but et de fin du curseur en un
 mode graphique quelconques du systŠme vid‚o.
}

Procedure SetCur;Assembler;ASM
 MOV AL,B
 MOV AH,A
 MOV Word Ptr DataVideo.MIV.StartCur,AX
(* {$IFOPT G+}
  PUSH 0
  POP ES
 {$ELSE}
  XOR AX,AX
  MOV ES,AX
 {$ENDIF}
 MOV AL,B
 MOV AH,A
 PUSHF
  CLI
  MOV ES:[$460],AX
 POPF*)
END;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure SetCurPos                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure fixe la position en texte du curseur sur la page vid‚o
 courante du systŠme vid‚o.
}

Procedure SetCurPos;Assembler;ASM
 MOV AL,X
 MOV AH,Y
 MOV Word Ptr DataVideo.MIV.XCur,AX
(* PUSHF
  CLI
  {$IFOPT G+}
   PUSH 0
   POP ES
   MOV AH,Y
   MOV BL,ES:[$462]
   AND BX,7
  {$ELSE}
   XOR BX,BX
   MOV ES,BX
   MOV AH,Y
   MOV BL,ES:[$462]
   AND BL,7
  {$ENDIF}
  SHL BX,1
  MOV AL,X
  MOV ES:[$0450+BX],AX
 POPF*)
END;