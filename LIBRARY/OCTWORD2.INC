{OctWord2.Inc}

{�������������������������������������������������������������������������
 �                 Malte Genesis/Biblioth�que individuel                 �
 �                    �dition Chantal/IV - Version 1.1                   �
 �                             1997/12/12                                �
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

{$IFNDEF __OctWord2Str}
 {$DEFINE __OctWord2Str}

 {���������������������������������������������������������������������
  �                        Fonction OctWord2Str                       �
  ���������������������������������������������������������������������


  Description
  �����������

   Cette fonction retourne une cha�ne de caract�res contenant la valeur
  Octale d'une valeur num�rique.
 }

 Function OctWord2Str(X:Word):String;Begin
  OctWord2Str:=Chr(48+(X shr 15))+
               Chr(48+((X shr 12)and 7))+
               Chr(48+((X shr 9)and 7))+
               Chr(48+((X shr 6)and 7))+
               Chr(48+((X shr 3)and 7))+
               Chr(48+X and 7);
 End;

{$ENDIF}