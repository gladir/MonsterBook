{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                        Proc괺ure SetCur                         �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Description
 袴袴袴袴袴�

  Cette proc괺ure fixe le format de d괷ut et de fin du curseur en un
 mode graphique quelconques du syst둴e vid굊.
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

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                          Proc괺ure SetCurPos                        �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Description
 袴袴袴袴袴�

  Cette proc괺ure fixe la position en texte du curseur sur la page vid굊
 courante du syst둴e vid굊.
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