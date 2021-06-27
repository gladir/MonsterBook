{\Source\Chantal\Library\InLst.Inc}

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

{$IFNDEF __InLst}
 {$DEFINE __InLst}

 {���������������������������������������������������������������������
  �                            Fonction InLst                         �
  ���������������������������������������������������������������������


  Description
  �����������

   Cette fonction effectue la recherche de cha�ne de caract�res dans un
  tampon d�finit par la variable de param�trage  �Buffer�.  Si elle est
  d�tect�, alors il retourne vrai, sinon faux.


  Remarque
  ��������

   � Le tampon doit contenir des suites de cha�nes de caract�res Pascal
     et le dernier doit avoir  une  longueur de  0 ou si vous pr�f�rer,
     apr�s avoir mis tous  les cha�nes de caract�res Pascal  � la suite
     des autres il doit y avoir un code ASCII 0.
 }

 Function InLst(Var Buffer;Size:Word;Item:String):Bool;Var Buf:TByte Absolute Buffer;J:Wd;L:Byte;Begin
  J:=0;InLst:=True;
  While(J<Size)do Begin
   L:=Buf[J]+1;
   If Compare(Buf[J],Item,L)Then Exit;
   Inc(J,L)
  End;
  InLst:=False
 End;

{$ENDIF}