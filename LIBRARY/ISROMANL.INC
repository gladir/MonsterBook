{IsRomanL.Inc}

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

{$IFNDEF __IsRomanLetter}
 {$DEFINE __IsRomanLetter}

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴콘
 �                       Fonction IsRomanLetter                     �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複蔔


 Description
 袴袴袴袴袴�

  Cette fonction indique sur le caract둹e sp괹ifi� par la variable de
 param굏rage 췈hr�  une lettre romain  (soit de A � Z en minuscule ou
 majuscule). Si oui, le r굎ultat True sinon False.
}

Function IsRomanLetter(Chr:Char):Bool;Assembler;ASM
 XOR AL,AL
 MOV CL,Chr
 AND CL,$DF
 CMP CL,'A'
 JB @1
 CMP CL,'Z'
 JA @1
 INC AL
@1:
END;

{$ENDIF}