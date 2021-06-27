{Library\Interrup.t\15h\Wait.Inc}

{$IFNDEF __Wait}
 {$DEFINE __Wait}

Function Wait(MicroSecond:LongInt):Boolean;Assembler;ASM
 MOV AH,86h
 MOV CX,Word Ptr MicroSecond
 MOV DX,Word Ptr MicroSecond[2]
 INT 15h
 MOV AL,0
 CMC
 ADC AL,AL
END;

{$ENDIF}