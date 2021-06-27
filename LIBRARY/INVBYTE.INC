{InvByte.Inc}

{�������������������������������������������������������������������������
 �                 Malte Genesis/Biblioth�que individuel                 �
 �                    �dition Chantal/IV - Version 1.1                   �
 �                             1997/04/01                                �
 �                                                                       �
 �         Tous droits r�serv�s par les Chevaliers de Malte (C)          �
 �������������������������������������������������������������������������


 Nom des programmeurs
 ��������������������

  Sylvain Maltais


 Description
 �����������

  Cette inclusion vise  � permettre une universialisation des donn�es �
 compiler  ind�pendament  des conditions  sous  lequel  la fonction est
 tra�ter.  En centralisant toutes les proc�dures au m�me point central,
 on aboutira une technique de �Croiser�, celle-ci permet d'�liminer les
 bugs par le raisonnement suivant:Maintenant sa fonctionne parfaitement
 ou sa plante comme jamais avant...
}

{$IFNDEF __InvByte}
 {$DEFINE __InvByte}

{�������������������������������������������������������������������������
 �                             Fonction InvByte                          �
 �������������������������������������������������������������������������


 Description
 �����������

  Cette fonction inverse les bits d'un octets. Le bits du haut se d�placer
 vers le bas et vice-versa.
}

Function InvByte(X:Byte):Byte;Assembler;ASM
 MOV BH,0
 MOV BL,X     { �����������������������Ŀ}
 MOV CH,BH    { � 0� 1� 2� 3� 4� 5� 6� 7�}
 MOV DX,8001h { �������������������������}
 XOR AX,AX    {  �^ �^ �^ �^ �^ �^ �^ �^ }
 MOV CL,1     {  ���))�))�))�))�))�))�ٳ }
@@Restart:    {  ���))�))�))�))�))�))��� }
 MOV AL,BL    {     ���))�))�))�))�ٳ    }
 ROR AL,CL    {     ���))�))�))�))���    }
 AND AL,DH    {        ���))�))�ٳ       }
 OR  CH,AL    {        ���))�))���       }
 MOV AL,BL    {           ���ٳ          }
 ROL AL,CL    {           �����          }
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