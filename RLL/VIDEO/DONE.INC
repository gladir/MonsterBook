{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                             Proc괺ure Done                          �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Description
 袴袴袴袴袴�

  Cette proc괺ure d굎alloue la m굆oire allou� par la proc괺ure 췏nit� du
 m늤e unit� parent.


 Remarque
 袴袴袴袴

  � La directive 췓ineExterne� indique  � la proc괺ure qu'une allocation
    ext굍ieur est utilis괻 pour la coordonn괻 physique d'une ligne. Elle
    en d괺uit donc qu'il faut la d굎allouer si elle est sp괹ifi괻.
}

Procedure Done;Assembler;ASM
 MOV ES,DataVideo.MIV.SegBuffer
 {$IFDEF Autonome}
  MOV AH,049h
  INT 021h
 {$ELSE}
  INT 09Ch
 {$ENDIF}
 {$IFDEF LineExterne}
  MOV ES,DataVideo.MIV.AddrPage
  {$IFDEF Autonome}
   MOV AH,049h
   INT 021h
  {$ELSE}
   INT 09Ch
  {$ENDIF}
 {$ENDIF}
END;