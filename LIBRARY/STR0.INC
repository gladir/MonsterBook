{Str0.Inc}

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

{$IFNDEF __StrZero}
 {$DEFINE __StrZero}
 {$I \Source\Chantal\Library\DivL.Inc}
 {$I \Source\Chantal\Library\Str.Inc}
 {$I \Source\Chantal\Library\Zero.Inc}

{��������������������������������������������������������������������������
 �                             Fonction Str0                              �
 ��������������������������������������������������������������������������


 Description
 �����������

  Cette fonction retourne dans une cha�ne de caract�res la valeur num�rique
 enti�re  de la  variable  de  param�trage  �X�.  Des  caract�res  �0� sont
 additionn�s au d�but de la cha�ne de caract�res � renvoy� pour qu'elle est
 une longueur �gale  � celle  de la variable  de param�trage  �Len�.  Si la
 valeur est plus grande  que la longueur sugg�rer,  les chiffres en partant
 de la gauche sont �limin�es pour cadr�s avec le format.
}

Function Str0(X:Long;Len:Byte):String;Label 0;Var S:String;Begin
 If X=0Then Begin;S:='';Goto 0;End;
 Case(Len)of
    1: Str0:=Char((X mod 10)+48);
    2: Str0:=Char((DivL(X,10)mod 10)+48)+Char((X mod 10)+48);
    4: Str0:=Char(((X div 1000)mod 10)+48)+Char(((X div 100)mod 10)+48)+
	     Char(((X div 10)mod 10)+48)+Char((X mod 10)+48);
  Else Begin S:=Str(X);0:Str0:=Zero(Len-Length(S))+S;End;
 End;
End;

{$ENDIF}