{WaitRetr.Inc}

{$IFNDEF __WaitRetrace}
 {$DEFINE __WaitRetrace}

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                         Proc괺ure WaitRetrace                     �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Description
 袴袴袴袴袴�

  Cette proc괺ure attend un rafra똠hissement et un d괽ra똠hissement de
 l'괹ran avant de ce termine.
}

Procedure WaitRetrace;Assembler;ASM
 MOV DX,03DAh
@1:
 IN AL,DX
 TEST AL,8
 JNZ @1
@2:
 IN AL,DX
 TEST AL,8
 JZ @2
END;
{$ENDIF}