{DrDosChk.Inc}

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

{$IFNDEF __DrDosChk}
 {$DEFINE __DrDosChk}

 {旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
  �                          Fonction DrDosChk                          �
  잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


  Description
  袴袴袴袴袴�

   Cette fonction teste s'il s'agit d'un DR-DOS tournant actuellement sur
  la machine en renvoyant une valeur diff굍ente � 0 si c'est le cas.
 }

Function DrDosChk:Word;
{$IFDEF Macro}
 InLine($B8/$52/$44/ { MOV AX,4452h }
        $CD/$21/     { INT 21h      }
        $73/$02/     { JNC @1       }
        $33/$C0);    { XOR AX,AX    }
                     {@1:           }
{$ELSE}
 Assembler;ASM
  MOV AX,4452h
  INT 21h
  JNC @1
  XOR AX,AX
 @1:
 END;
{$ENDIF}

{$ENDIF}