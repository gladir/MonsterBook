{AbsInt.Inc}

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

{$IFNDEF __AbsInt}
 {$DEFINE __AbsInt}

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴콘
 �                             Fonction AbsInt                          �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複蔔


 Description
 袴袴袴袴袴�

  Cette fonction retourne la valeur absolue de la valeur enti둹e contenue
 dans la variable de param굏rage 췏�.


 Remarques
 袴袴袴袴�

  � Attention!  Cette fonction ne supporte en aucun cas les 췓ongInt�, et
    vous devrez  donc  utilise la fonction  췆bs�  d'origine dans l'unit�
    췚YSTEM� du compilateur pour avoir ce m늤e effet.

  � Utilisez la directive de compilation conditionnel  췈ompatible�  pour
    indiquer  �  la  proc괺ure  qu'il  doit  utiliser  une  technique  de
    compatibilit� ind굋endament  de la taille d'une variable enti둹e  (si
    vous pr괽굍ez, ayant une taille pouvant 늯re diff굍ente de 2 octets).
}

Function AbsInt(I:Integer):Integer;Assembler;ASM
 {$IFDEF __386__}
  OR AX,AX
  JGE @1
  NEG AX
@1:
 {$ELSE}
  {$DEFINE Compatible}
   MOV AX,I
   {$IFDEF Compatible}
    OR  AX,AX { Ceci c'est la m굏hode "Schtroumpf" international de }
    JGE @1    { compatibilit�...}
    NEG AX
 @1:
   {$ELSE}
    AND AX,$7FFF
  {$ENDIF}
 {$ENDIF}
END;

{$ENDIF}