{WaitRetr.Inc}

{$IFNDEF __WaitRetrace}
 {$DEFINE __WaitRetrace}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure WaitRetrace                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure attend un rafraŒchissement et un d‚fraŒchissement de
 l'‚cran avant de ce termine.
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