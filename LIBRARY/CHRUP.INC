{ChrUp.Inc}

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

{$IFNDEF __ChrUp}
 {$DEFINE __ChrUp}

{���������������������������������������������������������������������������
 �                              Fonction ChrUp                             �
 ���������������������������������������������������������������������������


 Description
 �����������

  Cette fonction retourne la majuscule de la lettre sp�cifie par la variable
 de  param�trage  �Chr�.   Il  supporte  aussi  bien  les  accents  que  les
 minuscules,  et si c'est possible  il retourne la majuscule  avec un accent
 que celui-ci est un accent.  Il se fit pour cela  � la table des caract�res
 �tendue standard d'IBM.
}

Function ChrUp(Chr:Char):Char;Begin
 Case(Chr)of
  'a'..'z': ChrUp:=Char(Byte(Chr)-32);
  '�','�': ChrUp:='C';
  '�','�','�','�','�': ChrUp:='U';
  '�','�','�','�','�': ChrUp:='E';
  '�','�','�','�','�','�','�','�': ChrUp:='A';
  '�','�','�','�': ChrUp:='I';
  '�','�','�','�','�','�': ChrUp:='O';
  '�','�': ChrUp:='N';
  '�': ChrUp:='Y';
  '�': ChrUp:='�';
  Else ChrUp:=Chr;
 End
End;

{$ENDIF}