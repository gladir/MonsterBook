{FreeMem.CAS}

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

{$IFNDEF __FreeMem}
 {$DEFINE __FreeMem}

(*旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴콘
  �                           Fonction FreeMem                           �
  잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複蔔


 Description
 袴袴袴袴袴�

  Cette fonction lib둹e la m굆oire pr괹괺굆ent r굎erv� par le DOS.
*)

Function FreeMem(SegX:Word):Integer;Assembler;ASM
 MOV AH,49h
 MOV ES,SegX
 INT 21h
 JC  @End
 XOR AX,AX
@End:
END;

{$ENDIF}