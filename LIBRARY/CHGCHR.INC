{ChgChr.Inc}

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

{$IFNDEF __ChgChr}
 {$DEFINE __ChgChr}

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴콘
 �                             Proc괺ure ChgChr                           �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複蔔


 Description
 袴袴袴袴袴�

  Cette  proc괺ure  cherche  un  caract둹e  sp괹ifique  et change  tous ces
 caract둹es pour un autre d굎ign� par la variable de param굏rage 췙eplace�.


 R괽굍ence
 袴袴袴袴�

   � Tirez de l'emballage de codes sources du  췛PFAST 4.0�  sous le nom de
     췈hangeChr�.
}

Procedure ChgChr(Var S:String;Search,Replace:Char);Assembler;ASM
 {$IFDEF __386__}
 {$ELSE}
  LES DI,S
  XOR DX,DX
  MOV AL,Replace
  MOV AH,Search
  XOR CX,CX
  MOV CL,ES:[DI]
  JCXZ @3
 @1:
  INC DI
  CMP ES:[DI],AH
  JNE @2
  MOV ES:[DI],AL
  INC DX
 @2:
  LOOP @1
{  OR DX,DX
  JNZ @3}
 @3:
 {$ENDIF}
END;

{$ENDIF}