{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                             Proc‚dure Done                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure d‚salloue la m‚moire allou‚ par la proc‚dure ®Init¯ du
 mˆme unit‚ parent.


 Remarque
 ÍÍÍÍÍÍÍÍ

  ş La directive ®LineExterne¯ indique  … la proc‚dure qu'une allocation
    ext‚rieur est utilis‚e pour la coordonn‚e physique d'une ligne. Elle
    en d‚duit donc qu'il faut la d‚sallouer si elle est sp‚cifi‚e.
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