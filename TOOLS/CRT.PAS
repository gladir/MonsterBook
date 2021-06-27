{�������������������������������������������������������������������������
 �                                                                       �
 �                          U n i t �  C R T                             �
 �                                                                       �
 �                Biblioth�que du compilateur Pascal B57                 �
 �         Enemble Malte Genesis IV & V: Alias Chantal & Ad�le           �
 �                                                                       �
 �    Tous droits r�serv�s par les Chevaliers de Malte (C) 1998, 1999    �
 �                                                                       �
 �������������������������������������������������������������������������


 Nom du programmeur
 ������������������

  Sylvain Maltais


 Description
 �����������

  Cette unit� est r�serv� exclusivement � la gestion de la console d'�cran
 de texte. Elle n'existe pas  pour prouv� la force de l'ensemble �Genesis�
 mais plut�t � titre de compatibilit� avec l'environnement de Turbo Pascal
 de Borland International.
}

Unit Crt;

INTERFACE

Procedure GotoXY(X,Y:Byte);Register;

IMPLEMENTATION

{���������������������������������������������������������������������
 �                         Proc�dure GotoXY                          �
 ���������������������������������������������������������������������


 Description
 �����������

  Cette proc�dure permet le d�placement du curseur � un endroit pr�cis
 de l'�cran. Les coordonn�es de d�part, texte, sont (1,1).
}

Procedure GotoXY(X,Y:Byte);Assembler;ASM
 MOV DL,X { Ces deux instructions sont remplac�es par l'instruction }
 MOV DH,Y { �XCHG AX,DX� de l'assembleur. }
 OR  DX,DX
 IF NZ SUB DX,101h
 XOR BH,BH
 MOV AH,02h
 INT 10h
END;

END.