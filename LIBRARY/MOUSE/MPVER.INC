{Library\Mouse\MPVer.Inc}

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

{$IFNDEF __MickeysPixelVertical}
 {$DEFINE __MickeysPixelVertical}

 {旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
  �                   Fonction MickeysPixelVertical               �
  잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


  Description
  袴袴袴袴袴�

    Cette fonction retourne le nombre de mickeys/pixel d괽init pour
   la souris sur l'axe vertical.
  }

Function MickeysPixelVertical:Word;
{$IFDEF Macro}
 InLine($B8/$1B/$00/ { MOV AX,001Bh }
        $CD/$33/     { INT 33h }
        $91);        { XCHG AX,CX }
{$ELSE}
 Assembler;ASM
  MOV AX,001Bh
  INT 33h
  XCHG AX,CX
 END;
{$ENDIF}

{$ENDIF}