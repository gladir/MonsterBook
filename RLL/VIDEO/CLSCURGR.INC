{ClsCurGr.Inc}

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴콘
 �                          Proc괺ure CloseCur                          �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複蔔


 Description
 袴袴袴袴袴�

  Cette proc괺ure permet de d굎activer le curseur en m굆oire BIOS en mode
 graphique.
}

Procedure CloseCur;Assembler;ASM
 MOV Word Ptr DataVideo.MIV.StartCur,02020h
(* {$IFOPT G+} { Instruction pour 80286 ou post굍ieur }
  PUSH 0
  POP ES
 {$ELSE}     { Instruction pour 8088 et 8086 }
  XOR AX,AX
  MOV ES,AX
 {$ENDIF}
 PUSHF
  CLI
  MOV Word Ptr ES:[460h],2020h
 POPF*)
END;