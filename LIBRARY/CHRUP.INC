{ChrUp.Inc}

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                 Malte Genesis/Biblioth둸ue individuel                 �
 �                    릁ition Chantal/IV - Version 1.1                   �
 �                             1997/04/01                                �
 �                                                                       �
 �         Tous droits r굎erv굎 par les Chevaliers de Malte (C)          �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Nom des programmeurs
 袴袴袴袴袴袴袴袴袴袴

  Sylvain Maltais


 Description
 袴袴袴袴袴�

  Cette inclusion vise  � permettre une universialisation des donn괻s �
 compiler  ind굋endament  des conditions  sous  lequel  la fonction est
 tra똳er.  En centralisant toutes les proc괺ures au m늤e point central,
 on aboutira une technique de 췈roiser�, celle-ci permet d'굃iminer les
 bugs par le raisonnement suivant:Maintenant sa fonctionne parfaitement
 ou sa plante comme jamais avant...
}

{$IFNDEF __ChrUp}
 {$DEFINE __ChrUp}

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                              Fonction ChrUp                             �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Description
 袴袴袴袴袴�

  Cette fonction retourne la majuscule de la lettre sp괹ifie par la variable
 de  param굏rage  췈hr�.   Il  supporte  aussi  bien  les  accents  que  les
 minuscules,  et si c'est possible  il retourne la majuscule  avec un accent
 que celui-ci est un accent.  Il se fit pour cela  � la table des caract둹es
 굏endue standard d'IBM.
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