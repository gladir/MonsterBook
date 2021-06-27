Program MouseBallPoint;

Procedure BallPoint;Assembler;ASM
 MOV AX,0030h
 XOR BX,BX
 XOR CX,CX
 INT 33h
END;

Function HotSpot:Word;Assembler;ASM
 MOV AX,002Ah
 INT 33h
 OR CX,BX
 XCHG AX,CX
END;

Function Direction:Word;Assembler;ASM
 MOV AX,1D6Ch
 INT 33h
 XCHG AX,BX
END;

Function KeyPress:Boolean;Assembler;ASM
 XOR AX,AX
 MOV ES,AX
 PUSHF
  CLI
  LES DX,ES:[041Ah]
 POPF
 MOV BX,ES
 CMP BX,DX
 JE  @End
 MOV AL,True
@End:
END;

BEGIN
 BallPoint;
 Repeat
  WriteLn(Direction);
 Until Keypress;
END.