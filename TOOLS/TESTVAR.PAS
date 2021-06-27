Uses B57;

Var X:Byte;Y:Word;

Procedure GotoXY(X,Y:Byte);Register;Assembler;ASM
 MOV DL,X { Ces deux instructions sont remplac‚es par l'instruction }
 MOV DH,Y { ®XCHG AX,DX¯ de l'assembleur. }
 OR  DX,DX
 IF NZ SUB DX,101h
 XOR BH,BH
 MOV AH,02h
 INT 10h
END;

BEGIN
 X:=0;
 Y:=$1234;
 X:=X;
 X:=Y+1-80;
 CmosXT;
END.