{Dos16MCh.Inc}

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

{$IFNDEF __Dos16MCheck}
 {$DEFINE __Dos16MCheck}

 {旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴콘
  �                    Fonction Dos16MCheck                    �
  잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複蔔


  Description
  袴袴袴袴袴�

   Cette fonction v굍ifie si la pr굎ence du DOS/16M (un genre de
  DOS-Extender/DPMI,... en plus "chip") est d굏ect� en m굆oire.
 }

 Function Dos16MCheck:Word;
 {$IFDEF Macro}
  InLine($B8/$02/$BF/ { MOV AX,$BF02 }
         $33/$D2/     { XOR DX,DX }
         $CD/$15/     { INT 15h }
         $92);        { XCHG AX,DX}
 {$ELSE}
  Assembler;ASM
   MOV AX,0BF02h
   XOR DX,DX
   INT 15h
   XCHG AX,DX
  END;
 {$ENDIF}

{$ENDIF}