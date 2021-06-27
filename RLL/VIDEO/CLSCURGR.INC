{ClsCurGr.Inc}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure CloseCur                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de d‚sactiver le curseur en m‚moire BIOS en mode
 graphique.
}

Procedure CloseCur;Assembler;ASM
 MOV Word Ptr DataVideo.MIV.StartCur,02020h
(* {$IFOPT G+} { Instruction pour 80286 ou post‚rieur }
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