{\Source\Chantal\Library\InLst.Inc}

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

{$IFNDEF __InLst}
 {$DEFINE __InLst}

 {旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
  �                            Fonction InLst                         �
  잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


  Description
  袴袴袴袴袴�

   Cette fonction effectue la recherche de cha똭e de caract둹es dans un
  tampon d괽init par la variable de param굏rage  췇uffer�.  Si elle est
  d굏ect�, alors il retourne vrai, sinon faux.


  Remarque
  袴袴袴袴

   � Le tampon doit contenir des suites de cha똭es de caract둹es Pascal
     et le dernier doit avoir  une  longueur de  0 ou si vous pr괽굍er,
     apr둺 avoir mis tous  les cha똭es de caract둹es Pascal  � la suite
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