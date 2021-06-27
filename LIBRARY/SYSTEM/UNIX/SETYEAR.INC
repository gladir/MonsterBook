{SetYear.Inc}

{$IFNDEF __UnixLocalSetYear}
 {$DEFINE __UnixLocalSetYear}

{$I Library\System\Unix\Month.Inc}

Procedure SetYear(Year:Word);Assembler;ASM
 MOV AL,28
 TEST Byte Ptr Year,3
 JNZ @1
 INC AL
@1:
 MOV Byte Ptr DaysPerMonth[1],AL
END;

{$ENDIF}