{MultChr.Inc}

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

{$IFNDEF __MultChr}
 {$DEFINE __MultChr}

{��������������������������������������������������������������������������
 �                            Fonction MultChr                            �
 ��������������������������������������������������������������������������


 Description
 �����������

  Cette fonction retourne une cha�ne de caract�res avec le m�me caract�re �
 la quantit� sp�cifi�e par la variable de param�trage �Len�.


 Remarque
 ��������

  � Si  la variable  de param�trage  �Len�  est �gale � 0,  il retourne une
    cha�ne de caract�res vide.
}

Function MultChr(Value:Char;Len:Byte):String;Assembler;ASM
 {$IFDEF FLAT386}
 {$ELSE}
  CLD
  LES DI,@Result
  MOV CL,Len
  MOV ES:[DI],CL
  INC DI
  MOV AL,Value
  MOV CH,0
  REP STOSB
 {$ENDIF}
END;

{$ENDIF}