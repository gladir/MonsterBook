Function NetworkExist:Boolean;Assembler;ASM
 MOV AX,0B800h
 INT 2Fh
 OR  AH,AH
 JE  @End
 MOV AL,1
@End:
END;

Function GetNetBIOSMachineNumber:Byte;Assembler;ASM
 MOV AX,0B807h
 XOR CX,CX
 INT 2Fh
 MOV AL,CH
END;

Function GetLanVersion:Word;Assembler;ASM
 MOV AX,0B809h
 INT 2Fh
END;

BEGIN
 Write('R‚seau install‚: ');
 If(NetworkExist)Then WriteLn('Oui')
                 Else WriteLn('Non');
 WriteLn('LAN Version ',Lo(GetLanVersion),'.',Hi(GetLanVersion));
 WriteLn('Num‚ro de machine: ',GetNetBIOSMachineNumber);
END.