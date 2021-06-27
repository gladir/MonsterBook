{Button.Inc}

{�������������������������������������������������������������������������
 �                 Malte Genesis/Biblioth�que individuel                 �
 �                    �dition Chantal/IV - Version 1.1                   �
 �                             1997/12/15                                �
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

{$IFNDEF __Button}
 {$DEFINE __Button}

{������������������������������������������������������������������������
 �                             Fonction Button                          �
 ������������������������������������������������������������������������


 Description
 �����������

  Cette fonction est �quivalente � la fonction de l'interpr�teur du Basic
 du Coco 3. Cette donne 1 si vous pressez le bouton de la manette de jeux
 �B� et 0 si vous le pressez pas. �B� peut correspondre �:
 ����������������������������������������������������������������������Ŀ
 � �B� � Description                                                    �
 ����������������������������������������������������������������������͵
 �  0  � Manette de jeux de droite, bouton 1                            �
 �  1  � Manette de jeux de droite, bouton 2                            �
 �  2  � Manette de jeux de gauche, bouton 1                            �
 �  3  � Manette de jeux de gauche, bouton 2                            �
 ������������������������������������������������������������������������
}

Function Button(B:Byte):Boolean;Assembler;ASM
 MOV DX,201h
 IN  AL,DX
 NOT AL
 MOV CL,B
 SHR AL,CL
 AND AL,1
END;

{$ENDIF}