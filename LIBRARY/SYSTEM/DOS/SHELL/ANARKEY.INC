{Library\System\Dos\Shell\Anarkey.Inc}

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

{$IFNDEF __AnarkeyShell}
 {$DEFINE __AnarkeyShell}

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                          Fonction AnarkeyShell                      �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Description
 袴袴袴袴袴�

  Cette fonction permet de savoir si le Shell d'Anarkey est pr굎entement
 en m굆oire et s'il est actif ou inactif.  Pour ce faire il retourne une
 valeur selon le format suivant:
 旼컴컴컴컴컴컫컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 � Valeur     � Description                                            �
 팠袴袴袴袴袴曲袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴�
 �  00h       � Absent, n'est pas en m굆oire s뻭 et certain!           �
 �  FEh       � Il est pr굎ent mais n'est pas actif, en mode suspendu. �
 �  FFh       � Il est pr굎ent et actif, en op굍ation.                 �
 �  autrement � Erreur, inconnu,...?                                   �
 읕컴컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
}

Function AnarkeyShell:Byte;
{$IFDEF Macro}
 InLine($B8/$00/$E3/ { MOV AX,0E300h }
        $CD/$2F);    { INT 2Fh }
{$ELSE}
 Assembler;ASM
  MOV AX,0E300h
  INT 2Fh
 END;
{$ENDIF}

{$ENDIF}