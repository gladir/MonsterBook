{Spc.Inc}

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

{$IFNDEF __Spc}
 {$DEFINE __Spc}

{�������������������������������������������������������������������������
 �                             Fonction Spc                              �
 �������������������������������������������������������������������������


 Description
 �����������

  Cette fonction retourne une cha�ne de caract�res d'espace de la longueur
 d�finie par la variable de param�trage �Len�.
}

Function Spc(Len:Byte):String;Assembler;ASM
 {$IFDEF FLAT386}
 {$ELSE}
  LES DI,@Result
  MOV CL,Len
  MOV CH,0
  MOV ES:[DI],CL
  JCXZ @1
  CLD
  INC DI
  MOV AL,' '
  REP STOSB
 @1:
 {$ENDIF}
END;

{$ENDIF}