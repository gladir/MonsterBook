{Header.Inc}

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

{$IFNDEF __HeaderMalte}
 {$DEFINE __HeaderMalte}
 {$I \Source\Chantal\Library\System\Malte\HeaderBi.Inc}

 Type
  Chr=Char;    {Raccourci populaire}
  Wd=Word;     {Synonyme de la Convention Unix...}
  Int=Integer; {Synonyme de la Convention C/C++...}
  Long=LongInt;{Synonyme de la Convention C/C++...}
  {$IFNDEF __Windows__}
   SmallInt=Integer; { Entier d'intervalle entre -32768 � 32767 }
  {$ENDIF}
  {$IFDEF __TMT__}
   Comp=Array[0..7]of Byte;
  {$ENDIF}
{$ENDIF}