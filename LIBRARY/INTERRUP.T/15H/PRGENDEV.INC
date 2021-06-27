{Library\Interrup.t\15h\PrgEnDev.Inc}

{$IFNDEF __ProgramDeviceTerminate}
 {$DEFINE __ProgramDeviceTerminate}

Function ProgramDeviceTerminate(DeviceID:Word):Byte;Assembler;ASM
 MOV AH,82h
 MOV BX,DeviceID
 INT 15h
 MOV AL,AH
End;

{$ENDIF}