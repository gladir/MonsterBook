{Library\Interrup.t\15h\CloseDev.Inc}

{$IFNDEF __CloseDevice}
 {$DEFINE __CloseDevice}

Function CloseDevice(DeviceID,Process:Word):Byte;Assembler;ASM
 MOV AH,81h
 MOV BX,DeviceID
 MOV CX,Process
 INT 15h
 MOV AL,AH
End;

{$ENDIF}