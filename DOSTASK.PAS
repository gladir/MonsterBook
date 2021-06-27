Function Dos5TaskSwitcherInstalled:Boolean;Assembler;ASM
 MOV AX,4B02h
 XOR BX,BX
 MOV ES,BX
 MOV DI,BX
 INT 2Fh
 MOV AX,ES
 OR  AX,DI
 JZ  @End
 MOV AX,1
@End:
END;

BEGIN
 WriteLn(Dos5TaskSwitcherInstalled);
END.