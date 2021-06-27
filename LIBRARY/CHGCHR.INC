{ChgChr.Inc}

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

{$IFNDEF __ChgChr}
 {$DEFINE __ChgChr}

{��������������������������������������������������������������������������
 �                             Proc�dure ChgChr                           �
 ��������������������������������������������������������������������������


 Description
 �����������

  Cette  proc�dure  cherche  un  caract�re  sp�cifique  et change  tous ces
 caract�res pour un autre d�sign� par la variable de param�trage �Replace�.


 R�f�rence
 ���������

   � Tirez de l'emballage de codes sources du  �TPFAST 4.0�  sous le nom de
     �ChangeChr�.
}

Procedure ChgChr(Var S:String;Search,Replace:Char);Assembler;ASM
 {$IFDEF __386__}
 {$ELSE}
  LES DI,S
  XOR DX,DX
  MOV AL,Replace
  MOV AH,Search
  XOR CX,CX
  MOV CL,ES:[DI]
  JCXZ @3
 @1:
  INC DI
  CMP ES:[DI],AH
  JNE @2
  MOV ES:[DI],AL
  INC DX
 @2:
  LOOP @1
{  OR DX,DX
  JNZ @3}
 @3:
 {$ENDIF}
END;

{$ENDIF}