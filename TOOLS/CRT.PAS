{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                                                                       �
 �                          U n i t �  C R T                             �
 �                                                                       �
 �                Biblioth둸ue du compilateur Pascal B57                 �
 �         Enemble Malte Genesis IV & V: Alias Chantal & Ad둳e           �
 �                                                                       �
 �    Tous droits r굎erv굎 par les Chevaliers de Malte (C) 1998, 1999    �
 �                                                                       �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Nom du programmeur
 袴袴袴袴袴袴袴袴袴

  Sylvain Maltais


 Description
 袴袴袴袴袴�

  Cette unit� est r굎erv� exclusivement � la gestion de la console d'괹ran
 de texte. Elle n'existe pas  pour prouv� la force de l'ensemble 췍enesis�
 mais plut뱓 � titre de compatibilit� avec l'environnement de Turbo Pascal
 de Borland International.
}

Unit Crt;

INTERFACE

Procedure GotoXY(X,Y:Byte);Register;

IMPLEMENTATION

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                         Proc괺ure GotoXY                          �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Description
 袴袴袴袴袴�

  Cette proc괺ure permet le d굋lacement du curseur � un endroit pr괹is
 de l'괹ran. Les coordonn괻s de d굋art, texte, sont (1,1).
}

Procedure GotoXY(X,Y:Byte);Assembler;ASM
 MOV DL,X { Ces deux instructions sont remplac괻s par l'instruction }
 MOV DH,Y { 췟CHG AX,DX� de l'assembleur. }
 OR  DX,DX
 IF NZ SUB DX,101h
 XOR BH,BH
 MOV AH,02h
 INT 10h
END;

END.