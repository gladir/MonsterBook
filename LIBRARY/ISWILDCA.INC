{IsWildCard.Inc}

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

{$IFNDEF __IsWildCard}
 {$DEFINE __IsWildCard}

{�������������������������������������������������������������������
 �                       Fonction IsWildCard                       �
 �������������������������������������������������������������������


 Description
 �����������

  Cette fonction indique si le r�pertoire d�finit par la variable de
 param�trage �Path� contient un/des caract�re(s)  g�n�riques ('*' ou
 '?').
}

Function IsWildCard(Path:String):Bool;Begin
 IsWildCard:=(Pos('*',Path)>0)or(Pos('?',Path)>0)
End;

{$ENDIF}