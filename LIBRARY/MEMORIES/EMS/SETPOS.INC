{Library\Memories\EMS\SetPos.Inc}

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

{$IFNDEF __SetPosEms}
 {$DEFINE __SetPosEms}

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴콘
 �                       Proc괺ure SetPos                         �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複蔔


 Description
 袴袴袴袴袴�

  Cette  fonction  permet  de  faire  incruster   l'une  des  pages
 pr괹괺emment allou괻s � l'aide de l'interruption 67h, Fonction 43h
 d'EMS (Open) dans l'une des 4 pages physiques du Page Frame.
}

Procedure SetPos(Handle,LogicPage:Word;PhysicalPage:Byte);Assembler;ASM
 MOV AH,44h
 MOV AL,PhysicalPage
 MOV BX,LogicPage
 MOV DX,Handle
 INT 67h
 {$IFDEF SaveError}
  MOV EmsErr,AH
 {$ENDIF}
END;

{$ENDIF}