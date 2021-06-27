{Library\Interrup.t\15h\SysReqst.Inc}

{$IFNDEF __GetSystemRequest}
 {$DEFINE __GetSystemRequest}

Function GetSystemRequest(Service:Byte):Byte;Assembler;ASM
 MOV AH,85h
 MOV AL,Service
 INT 15h
 JNC @1
 MOV AL,0FFh
 JMP @2
@1:
 MOV AL,AH
@2:
End;

{$ENDIF}