{Unhack1.Inc}

ASM
 PUSH AX
  JMP @NoStep+2
@NoStep:
  MOV DS:Byte Ptr [06EBh],0
  MOV AX,4C01h
  INT 21h
 POP AX
END;