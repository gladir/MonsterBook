{Library\Disk\Bios\SB2F.Inc}

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

{$IFNDEF __CheckSB2F}
 {$DEFINE __CheckSB2F}

 {$I \Source\Chantal\Library\Memories\Rom\ReadROM.Inc}

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴콘
 �                           Fonction CheckSB2F                       �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複蔔

  Descripton
  袴袴袴袴袴

   Cette fonction teste la pr굎ence du 췚uper Bios II Formatter�. Si le
  BIOS est d굏ect� la valeur retourn� est TRUE sinon,  s'il est absent,
  il retourne FALSE.


  Remarques
  袴袴袴袴�

   � Cette fonction teste est destin�  au disque dur MFM ayant une BIOS
     suppl굆entaire contenant le 췚uperBios II Formatter�.

   � L'adresse de la signature  se trouve � l'adresse  C800h:14F9h et �
     une longueur de  22 octets.  Sa date est  situ� � l'adresse C800h:
     153Eh et � une  longueur  de 3 octets,  sa version est  contenue �
     l'adresse  C800h:1516h  et � une longueur  de 2 octets,  enfin son
     mod둳e  est situ�  � l'adresse  C800h:1528h  et � une  longueur de
     15 octets.
 }

 Function CheckSB2F:Boolean;Begin
  CheckSB2F:=ReadROM($C800,$14F9,22)='Super Bios II Formatter';
 End;

{$ENDIF}
