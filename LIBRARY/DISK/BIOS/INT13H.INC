{Int13h.Inc}

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

{$IFNDEF __Int13h}
 {$DEFINE __Int13h}

Const
 {Constante de type de disque (Interruption 13h)}
 dtNoDrive=0;{Lecteur introuvable}
 dtDD525=1;{Lecteur: 5,25" Double Densit�}
 dtHD525=2;{Lecteur: 5,25" Haute Densit�}
 dtDD35=3;{Lecteur: 3,5" Double Densit�}
 dtHD35=4;{Lecteur: 3,5" Haute Densit�}

 {Officieusement...}
 dTryMax=5;{Nombre d'essais maximal}
{$ENDIF}