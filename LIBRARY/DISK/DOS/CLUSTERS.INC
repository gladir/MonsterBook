{ClusterS.Inc}

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

{$IFNDEF __ClusterSize}
 {$DEFINE __ClusterSize}

 {���������������������������������������������������������������
  �                    Fonction ClusterSize                     �
  ���������������������������������������������������������������


  Description
  �����������

   Cette fonction retourne la taille d'un cluster d'une unit� DOS
  sp�cifi� par la variable de param�trage �Dsk�.
 }

Function ClusterSize(Dsk:Byte):LongInt;Assembler;ASM
 MOV DL,Dsk
 MOV AH,36h
 INT 21h
 MOV BX,DX
 MOV DX,AX
 CMP AX,-1
 JE  @1
 MUL CX
@1:
END;

{$ENDIF}