Function SCSIExist:Boolean;Assembler;ASM
 XOR CX,CX
 MOV ES,CX
 MOV CL,ES:[0475h]
@1:
 PUSH CX
  MOV AL,18h
  MOV DL,80h
  ADD DL,CL
  DEC DL
  STC
  INT 13h
 POP CX
 MOV AL,True
 JNC @End
 LOOP @1
 MOV AL,False
@End:
END;

Var
 X:Byte;

BEGIN
 WriteLn(SCSIExist);
 X:=Port[$145];
 WriteLn(X);
 X:=Port[$146];
 WriteLn(X);
 X:=Port[$14A]shr 6;
 Case(X)of
  0:WriteLn('C8000h-C9FFFh');
  1:WriteLn('CA000h-CBFFFh');
  2:WriteLn('CE000h-CFFFFh');
  3:WriteLn('DE000h-DFFFFh');
 End;
 X:=(Port[$14A]shr 4)and 3;
 Case(X)of
  0:WriteLn('140h-14Fh');
  1:WriteLn('150h-15Fh');
  2:WriteLn('160h-16Fh');
  3:WriteLn('170h-17Fh');
 End;
 X:=(Port[$14A]shr 1)and 7;
 Case(X)of
  0:WriteLn('IRQ3');
  1:WriteLn('IRQ5');
  2:WriteLn('IRQ10');
  3:WriteLn('IRQ11');
  4:WriteLn('IRQ12');
  5:WriteLn('IRQ14');
  6:WriteLn('IRQ15');
  7:WriteLn('Pas d''IRQ');
 End;
END.