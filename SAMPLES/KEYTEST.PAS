Program KeyTest;

{$I Library\HexWord.Inc}

Var K:Word;

BEGIN
 ASM
  XOR AX,AX
  INT 16h
  MOV K,AX
 END;
 WriteLn(HexWord2Str(K));
END.