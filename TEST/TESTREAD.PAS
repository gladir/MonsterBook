Var Value:Word;

BEGIN
 ASM
  XOR AX,AX
  INT 16h
  MOV Value,AX
 END;
 WriteLn(Value);
END.
