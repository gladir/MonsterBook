Function GetDiskInformationNetworkRedirect(Dir:PChar):Boolean;Assembler;ASM
 MOV AX,110Ch
 LES DI,Dir
 INT 2Fh
 JC  @Error
 MOV AL,1
 JMP @End
@Error:
 XOR AX,AX
@End:
END;

BEGIN
 If(GetDiskInformationNetworkRedirect('C:\'))Then Begin
  WriteLn('Tous va bien');
 End;
END.