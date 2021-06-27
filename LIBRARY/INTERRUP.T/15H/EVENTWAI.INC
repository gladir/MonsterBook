{Library\Interrup.t\15h\EventWai.Inc}

{$IFNDEF __EventWait}
 {$DEFINE __EventWait}

Function EventWait(Service:Byte;MicroSecond:LongInt;Var Buf):Boolean;Assembler;ASM
 MOV AH,83h
 MOV AL,Service
 LES BX,Buf
 MOV CX,Word Ptr MicroSecond
 MOV DX,Word Ptr MicroSecond[2]
 INT 15h
 MOV AL,0
 ADC AL,AL
END;

{$ENDIF}