{Library\Interrup.t\15h\JoyPos.Inc}

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

{$IFNDEF __GetJoyPos}
 {$DEFINE __GetJoyPos}

{�������������������������������������������������������������
 �                     Proc�dure GetJoyPos                   �
 �������������������������������������������������������������


 Description
 �����������

  Cette fonction  retourne  les coordonn�es  des deux manettes
 de jeux (Premi�re manette (X1,Y1), Deuxi�me manette (X2,Y2)).
}

Procedure GetJoyPos(Var X1,Y1,X2,Y2:Word);Assembler;ASM
 MOV AH,84h
 MOV DX,0001h
 INT 15h
 LES DI,X1
 STOSW
 LES DI,Y1
 XCHG AX,BX
 STOSW
 LES DI,X2
 XCHG AX,CX
 STOSW
 LES DI,Y2
 XCHG AX,DX
 STOSW
END;

{$ENDIF}