{ReadKey.Inc}

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

{$IFNDEF __ReadKey}
 {$DEFINE __ReadKey}

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                             Fonction ReadKey                          �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Description
 袴袴袴袴袴�

  Cette fonction permet d'extraire une touche du tampon clavier. Si aucune
 touche n'attend,  il attendra quand m늤e que l'utilisateur en est frapper
 une et pendant le temps qu'il attend,  effectuera des processus d'arri둹e
 plan.
}

Function ReadKey:Word;Assembler;ASM
 {$IFDEF Bios}
  {$IFOPT G+}
   MOV AX,$1000
  {$ELSE}
   XOR AX,AX
  {$ENDIF}
  INT $16
 {$ELSE}
  {$IFDEF DPMI}
   MOV ES,Seg0040
  {$ELSE}
   MOV AX,0040h
   MOV ES,AX
  {$ENDIF}
  {$IFNDEF NoCLI}
   CLI
  {$ENDIF}
  MOV BX,ES:[1Ah]
  MOV AX,ES:[BX]
  CMP AL,0E0h
  JE  @@NotOk
  CMP AL,0D0h
  JNE @@Ok
@@NotOk:
  CMP AH,0
  JE  @@Ok
  MOV AL,0
@@Ok:
  INC BX
  INC BX
  MOV ES:[1Ah],BX
  MOV CX,ES:[82h]
  CMP CX,BX
  JNE @End
  MOV CX,ES:[80h]
  MOV ES:[1Ah],CX
@End:
  {$IFNDEF NoCLI}
   STI
  {$ENDIF}
 {$ENDIF}
END;

{$ENDIF}