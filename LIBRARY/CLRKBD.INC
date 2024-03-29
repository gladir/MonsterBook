{ClrKbd.Inc}

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                 Malte Genesis/Biblioth둸ue individuel                 �
 �                    릁ition Chantal/IV - Version 1.1                   �
 �                             1997/04/01                                �
 �                                                                       �
 �         Tous droits r굎erv굎 par les Chevaliers de Malte (C)          �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Nom des programmeurs
 袴袴袴袴袴袴袴袴袴袴

  Sylvain Maltais


 Description
 袴袴袴袴袴�

  Cette inclusion vise  � permettre une universialisation des donn괻s �
 compiler  ind굋endament  des conditions  sous  lequel  la fonction est
 tra똳er.  En centralisant toutes les proc괺ures au m늤e point central,
 on aboutira une technique de 췈roiser�, celle-ci permet d'굃iminer les
 bugs par le raisonnement suivant:Maintenant sa fonctionne parfaitement
 ou sa plante comme jamais avant...
}

{$IFNDEF __ClrKbd}
 {$DEFINE __ClrKbd}

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                         Proc괺ure ClrKbd                          �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Description
 袴袴袴袴袴�

  Cette proc괺ure efface tous les caract둹es en attente dans le tampon
 clavier sans exception.


 Remarques
 袴袴袴袴�

   � Cette proc괺ure n'utilise  que des acc둺 directe en m굆oire et en
     aucune fa뇇n par le Bios ou le Dos. Elle est donc rapide mais pas
     n괹essairement  compatible  avec les plus  que vieille machine du
     d괷ut des ann괻s 1980.

   � Cette proc괺ure est id괶l pour des op굍ations du genre:췊tes-vous
     certain de... ?�.  Car l'utilisateur n'aurait pas � affronter une
     tape par erreur pr괹괺emment enregistrer...
}

{$IFNDEF NoVoid}Procedure ClrKbd;{$ENDIF}Assembler;ASM
 {$IFDEF Dos}
@1:
  MOV AH,0Bh
  INT 21h
  OR  AL,AL
  JE  @End
  MOV AH,08h
  INT 21h
  JMP @1
@@End:
 {$ELSE}
  {$IFDEF Bios}
@1:MOV AX,1
   INT 16h
   JZ  @@End
   XOR AX,AX
   INT 16h
   JMP @1
@@End:
  {$ELSE}
   {$IFDEF DPMI}
    PUSH Seg0040
    POP ES
    PUSHF
     CLI
     MOV AX,ES:[80h]
     MOV ES:[1Ch],AX
     MOV ES:[1Ah],AX
   {$ELSE}
    XOR AX,AX
    MOV ES,AX
    PUSHF
     CLI
     MOV AX,ES:[480h]
     MOV ES:[41Ah],AX
     MOV ES:[41Ch],AX
   {$ENDIF}
   POPF
  {$ENDIF}
 {$ENDIF}
END;

{$ENDIF}