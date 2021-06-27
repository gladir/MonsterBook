{\Source\Chantal\Library\System\Dos\WildMatc.Inc}

{�������������������������������������������������������������������������
 �                 Malte Genesis/Biblioth�que individuel                 �
 �                    �dition Chantal/IV - Version 1.1                   �
 �                             1997/04/01                                �
 �                                                                       �
 �         Tous droits r�serv�s par les Chevaliers de Malte (C)          �
 �������������������������������������������������������������������������


 Nom des programmeurs
 ��������������������

  Li-Hsin Huang
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

{$IFNDEF __WildCardMatch}
 {$DEFINE __WildCardMatch}

{������������������������������������������������������������������������
 �                          Fonction WildCardMatch                      �
 ������������������������������������������������������������������������


 Description
 �����������

  Cette fonction indique si le g�n�rique correspond au nom de fichier.
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