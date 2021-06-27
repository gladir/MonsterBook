{\Source\Chantal\Library\System\Malte\ExecFile\GetGatLen.Inc}

{�������������������������������������������������������������������������
 �                          Fonction GetGatLen                           �
 �������������������������������������������������������������������������


 Description
 �����������

  Cette fonction retourne la longueur d'affichage que prendra la cha�ne de
 caract�res de format �GAT� devrant th�oriquement  prendre la cha�ne � son
 affichage � l'�cran.
}

Function GetGatLen(PChr:PChr):Word;
Var
 I:Word; { Variable compteur de boucle }
 L:Word; { Longueur logique de la cha�ne de caract�res de format GAT }
Begin
 I:=0;L:=0;
 If(PChr=NIL)Then Begin
  GetGatLen:=0;
  Exit;
 End;
 While PChr^[I]<>#0do Begin
  If PChr^[I]in[' '..#254]Then Inc(L)else
  If(PChr^[I]<' ')and(Byte(PChr^[I])and cgDouble=cgDouble)Then Inc(L)Else
  If PChr^[I]=#255Then Begin
   If PChr^[I+1]<>#0Then Begin
    Inc(I);Inc(L)
   End;
  End;
  Inc(I)
 End;
 GetGatLen:=L
End;