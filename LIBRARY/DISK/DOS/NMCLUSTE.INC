{NmCluste.Inc}

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

{$IFNDEF __NmCluster}
 {$DEFINE __NmCluster}
 {旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴콘
  �                        Fonction NmCluster                        �
  잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複蔔


  Description
  袴袴袴袴袴�

   Cette fonction retourne le nombre de cluster que contient une unit�
  du DOS d괽init par la variable de param굏rage 췉sk�.
 }

Function NmCluster(Dsk:Byte):Word;Assembler;ASM
 MOV DL,Dsk
 MOV AH,36h
 INT 21h
 CMP AX,-1
 JE  @1
 MOV AX,DX
 JMP @2
@1:
 XOR AX,AX
@2:
END;

{$ENDIF}