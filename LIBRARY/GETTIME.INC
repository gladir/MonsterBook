{GetTime.Inc}

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

{$IFNDEF __GetTime}
 {$DEFINE __GetTime}

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴콘
 �                           Proc괺ure GetTime                          �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複蔔


 Description
 袴袴袴袴袴�

  Cette proc괺ure renvoie l'heure telle qu'elle est connue par le syst둴e
  d'exploitation.  Tous les param둻res  retourn굎 sont des intervalles de
  mot  (sous standard  de  l'unit�  췉OS�)  ou d'octet: 0 � 23,  minutes,
  seconde: 0 � 59, centi둴e de seconde: 0 � 59.
}

Procedure GetTime(Var Hour,Minute,Second,Sec100:Byte);Assembler;ASM
 {$IFDEF FLAT386}
 {$ELSE}
  MOV AH,2Ch
  INT 21h
  CLD
  XCHG AX,DX
  LES DI,Sec100
  STOSB
  MOV AL,AH
  LES DI,Second
  STOSB
  XCHG AX,CX
  LES DI,Minute
  STOSB
  MOV AL,AH
  LES DI,Hour
  STOSB
 {$ENDIF}
END;

{$ENDIF}