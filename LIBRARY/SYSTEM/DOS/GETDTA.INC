{GetDTA.Inc}

(*旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
  �                 Malte Genesis/Biblioth둸ue individuel                 �
  �                    릁ition Chantal/IV - Version 1.1                   �
  �                             1997/10/12                                �
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
*)

{$IFNDEF __GetDTA}
 {$DEFINE __GetDTA}

(*旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
  �                         Fonction GetDTA                           �
  잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


   Description
   袴袴袴袴袴�

    Cette fonction un pointeur sur la DTA du syst둴e d'exploitation DOS.
*)

Function GetDTA:Pointer;Assembler;ASM
 MOV AH,02Fh
 INT 021h
 MOV DX,ES
 XCHG AX,BX
END;

{$ENDIF}