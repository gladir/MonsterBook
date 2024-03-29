{InvByte.Inc}

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

{$IFNDEF __InvByte}
 {$DEFINE __InvByte}

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                             Fonction InvByte                          �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Description
 袴袴袴袴袴�

  Cette fonction inverse les bits d'un octets. Le bits du haut se d굋lacer
 vers le bas et vice-versa.
}

Function InvByte(X:Byte):Byte;Assembler;ASM
 MOV BH,0
 MOV BL,X     { 旼컫컴쩡컫컴쩡컫컴쩡컫컴�}
 MOV CH,BH    { � 0� 1� 2� 3� 4� 5� 6� 7�}
 MOV DX,8001h { 읕컨컴좔컨컴좔컨컴좔컨컴�}
 XOR AX,AX    {  �^ �^ �^ �^ �^ �^ �^ �^ }
 MOV CL,1     {  냅�))�))�))�))�))�))켸� }
@@Restart:    {  읕�))�))�))�))�))�))컴� }
 MOV AL,BL    {     냅�))�))�))�))켸�    }
 ROR AL,CL    {     읕�))�))�))�))컴�    }
 AND AL,DH    {        냅�))�))켸�       }
 OR  CH,AL    {        읕�))�))컴�       }
 MOV AL,BL    {           냅켸�          }
 ROL AL,CL    {           읕컴�          }
 AND AL,DL
 OR  CH,AL
 ADD CL,2
 SHR DH,1
 SHL DL,1
 CMP CL,9
 JNE @@Restart
 MOV AL,CH
END;

{$ENDIF}