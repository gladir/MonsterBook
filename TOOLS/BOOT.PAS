{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                              Cold Boot                              �
 �      D굆onstrateur de d굆arrage � froid sous Pascal Niveau B57      �
 �                              1997/03/16                             �
 �                                                                     �
 �         Tous droits r굎erv굎 par les Chevaliers de Malte (C)        �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Description
 袴袴袴袴袴�

  Ce programme permet un d굆arrage � froid de la machine sous un syst둴e
 d'exploitation DOS. Ce programme n'occupera que 5 octets en tout!
}

Program Boot;

ASM
 CALL 0FFFFh:0000h { Appelle directe � la ROM Bios de l'ordinateur. }
                   { Cette m굏hode  est  compatible  avec  tous les }
                   { ordinateurs PC, XT, AT, PS/1, PS/2, Aptiva,...}
END.