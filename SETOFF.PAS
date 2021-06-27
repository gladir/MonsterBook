Uses Systex,Systems;

Function SetAPMMode(Mode:Word):Boolean;Assembler;ASM
 MOV AX,5307h
 mov BX,1
 MOV CX,Mode
 INT 15h
 MOV AL,0
 JC  @Error
 MOV AL,Ya
 JMP @End
@Error:
 MOV Byte Ptr SysErr,AH
 MOV Byte Ptr SysErr[1],03h
@End:
END;

BEGIN
 ASM
  MOV AX,5301h
  XOR BX,BX
  INT 15h
 MOV AX,530Eh
 XOR BX,BX
 MOV CX,0101h
 INT 15h
 END;
 If Not SetAPMMode(3)Then WriteLn(SysErr);
END.