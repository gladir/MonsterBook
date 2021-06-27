{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                              Cold Boot                              Û
 ³      D‚monstrateur de d‚marrage … froid sous Pascal Niveau B57      Û
 ³                              1997/03/16                             Û
 ³                                                                     Û
 ³         Tous droits r‚serv‚s par les Chevaliers de Malte (C)        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Ce programme permet un d‚marrage … froid de la machine sous un systŠme
 d'exploitation DOS. Ce programme n'occupera que 5 octets en tout!
}

Program Boot;

ASM
 CALL 0FFFFh:0000h { Appelle directe … la ROM Bios de l'ordinateur. }
                   { Cette m‚thode  est  compatible  avec  tous les }
                   { ordinateurs PC, XT, AT, PS/1, PS/2, Aptiva,...}
END.