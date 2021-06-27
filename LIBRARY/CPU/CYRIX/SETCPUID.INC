{$IFNDEF __SetCPUIDCyrix}
 {$DEFINE __SetCPUIDCyrix}

{ Cette proc‚dure permet de fixer le micro-processeur pour qu'il supporte
 oui ou non l'instruction du Pentium ®CPUID¯.
}

 Procedure SetCPUID(X:Boolean);Assembler;ASM
  MOV  DX,0022h { Port de contr“le de configuration }
  MOV  AL,0C3h  { Registres de contr“le de configuration CCR3 }
  OUT  DX,AL
  INC  DX
  IN   AL,DX
  MOV  CL,AL    { Sauvegarde dans CL la valeur CCR3 }
   { Fixe les bits 4 … 7 du registre CCR3 … 1 pour autoriser une modification }
  AND  AL,0Fh
  OR   AL,010h
  XCHG AL,AH
  DEC  DX
  MOV  AL,0C3h  { Registre CCR3 }
  OUT  DX,AL
  INC  DX
  XCHG AL,AH
  OUT  DX,AL
  DEC  DX
  MOV  AL,0E8h
  OUT  DX,AL
  INC  DX
  IN   AL,DX
   { Ajuste le 7 bits du registre … la valeur de ®X¯ }
  CMP  X,True
  JE   @2
  AND  AL,LOW(NOT 80h)
  JMP  @3
 @2:
  OR   AL,80h
 @3:
  XCHG AL,AH
  DEC  DX
  MOV  AL,0E8h
  OUT  DX,AL
  INC  DX
  XCHG AL,AH
  OUT  DX,AL
  DEC  DX
   { Restitution de la valeur original du CCR3 }
  MOV  AL,0C3h  { Registre CCR3 }
  OUT  DX,AL
  INC  DX
  MOV  AL,CL
  OUT  DX,AL
 END;

{$ENDIF}