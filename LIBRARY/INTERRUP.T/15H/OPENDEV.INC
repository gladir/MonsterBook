{Library\Interrup.t\15h\OpenDev.Inc}

{$IFNDEF __OpenDevice}
 {$DEFINE __OpenDevice}

Function OpenDevice(DeviceID,Process:Word):Byte;Assembler;ASM
 MOV AH,80h
 MOV BX,DeviceID
 MOV CX,Process
 INT 15h
 MOV AL,AH
End;

{$ENDIF}