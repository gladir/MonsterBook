{Library\Interrup.t\15h\JoyPos.Inc}

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

{$IFNDEF __GetJoyPos}
 {$DEFINE __GetJoyPos}

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                     Proc괺ure GetJoyPos                   �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Description
 袴袴袴袴袴�

  Cette fonction  retourne  les coordonn괻s  des deux manettes
 de jeux (Premi둹e manette (X1,Y1), Deuxi둴e manette (X2,Y2)).
}

Procedure GetJoyPos(Var X1,Y1,X2,Y2:Word);Assembler;ASM
 MOV AH,84h
 MOV DX,0001h
 INT 15h
 LES DI,X1
 STOSW
 LES DI,Y1
 XCHG AX,BX
 STOSW
 LES DI,X2
 XCHG AX,CX
 STOSW
 LES DI,Y2
 XCHG AX,DX
 STOSW
END;

{$ENDIF}