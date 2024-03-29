{\Source\Chantal\Library\System\Dos\WildMatc.Inc}

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                 Malte Genesis/Biblioth둸ue individuel                 �
 �                    릁ition Chantal/IV - Version 1.1                   �
 �                             1997/04/01                                �
 �                                                                       �
 �         Tous droits r굎erv굎 par les Chevaliers de Malte (C)          �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Nom des programmeurs
 袴袴袴袴袴袴袴袴袴袴

  Li-Hsin Huang
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

{$IFNDEF __WildCardMatch}
 {$DEFINE __WildCardMatch}

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴콘
 �                          Fonction WildCardMatch                      �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複蔔


 Description
 袴袴袴袴袴�

  Cette fonction indique si le g굈굍ique correspond au nom de fichier.
}

Function WildCardMatch(Const FileName,WildCard:String):Boolean;Var I,J:Integer;Result:Boolean;Begin
 I:=1;J:=1;
 While(I<=Length(FileName))and(J<=Length(WildCard))and(Result)do Begin
  Case WildCard[j]of
   '?':Begin;Result:=FileName[I]<>'.';Inc(I);Inc(j)End;
   '*':Begin
    While(I<=Length(FileName))and(FileName[I]<>'.')do Inc(I);
    Inc(J);
   End;
   Else Begin;Result:=FileName[I]=WildCard[J];Inc(I);Inc(J)End;
  End;
 End;
 WildCardMatch:=Result and(I=Length(FileName)+1)and(J=Length(WildCard)+1)
End;

{$ENDIF}