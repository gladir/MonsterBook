{IsRomanL.Inc}

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

{$IFNDEF __IsRomanLetter}
 {$DEFINE __IsRomanLetter}

{��������������������������������������������������������������������
 �                       Fonction IsRomanLetter                     �
 ��������������������������������������������������������������������


 Description
 �����������

  Cette fonction indique sur le caract�re sp�cifi� par la variable de
 param�trage �Chr�  une lettre romain  (soit de A � Z en minuscule ou
 majuscule). Si oui, le r�sultat True sinon False.
}

Function IsRomanLetter(Chr:Char):Bool;Assembler;ASM
 XOR AL,AL
 MOV CL,Chr
 AND CL,$DF
 CMP CL,'A'
 JB @1
 CMP CL,'Z'
 JA @1
 INC AL
@1:
END;

{$ENDIF}