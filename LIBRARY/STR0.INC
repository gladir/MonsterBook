{Str0.Inc}

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

{$IFNDEF __StrZero}
 {$DEFINE __StrZero}
 {$I \Source\Chantal\Library\DivL.Inc}
 {$I \Source\Chantal\Library\Str.Inc}
 {$I \Source\Chantal\Library\Zero.Inc}

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴콘
 �                             Fonction Str0                              �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複蔔


 Description
 袴袴袴袴袴�

  Cette fonction retourne dans une cha똭e de caract둹es la valeur num굍ique
 enti둹e  de la  variable  de  param굏rage  췟�.  Des  caract둹es  �0� sont
 additionn굎 au d괷ut de la cha똭e de caract둹es � renvoy� pour qu'elle est
 une longueur 괾ale  � celle  de la variable  de param굏rage  췓en�.  Si la
 valeur est plus grande  que la longueur sugg굍er,  les chiffres en partant
 de la gauche sont 굃imin괻s pour cadr굎 avec le format.
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