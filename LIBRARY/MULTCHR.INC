{MultChr.Inc}

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

{$IFNDEF __MultChr}
 {$DEFINE __MultChr}

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴콘
 �                            Fonction MultChr                            �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複蔔


 Description
 袴袴袴袴袴�

  Cette fonction retourne une cha똭e de caract둹es avec le m늤e caract둹e �
 la quantit� sp괹ifi괻 par la variable de param굏rage 췓en�.


 Remarque
 袴袴袴袴

  � Si  la variable  de param굏rage  췓en�  est 괾ale � 0,  il retourne une
    cha똭e de caract둹es vide.
}

Function MultChr(Value:Char;Len:Byte):String;Assembler;ASM
 {$IFDEF FLAT386}
 {$ELSE}
  CLD
  LES DI,@Result
  MOV CL,Len
  MOV ES:[DI],CL
  INC DI
  MOV AL,Value
  MOV CH,0
  REP STOSB
 {$ENDIF}
END;

{$ENDIF}