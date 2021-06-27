{PosX2Gat1.Inc}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Fonction PosGat2X1                           Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction convertie la position physique … l'‚cran avec la position
 physique … l'int‚rieur d'une chaŒne de caractŠres.
}

Function PosX2Gat1(PC:PChr;P:Word):Word;
Var
 I,J:Word;   { Compteur de boucle }
 L:Word;     { Longueur de d‚placement }
 Ok:Boolean; { quivalent d'un caractŠre d'espacement? }
Begin
 J:=0;I:=0;L:=0;PosX2Gat1:=P;
 If IsPChrEmpty(PC)or(P=0)Then Exit;
 While PC^[I]<>#0do Begin
  Ok:=False;
  Case PC^[I]of
   #1..#31: If(Byte(PC^[I])and cgDouble=cgDouble)Then Ok:=True
                                                 Else Inc(L);
   ' '..#254: Ok:=True;
   #255:Begin
    Inc(L);Inc(I);
    Inc(L);Inc(J);
    If(J>=P)Then Begin
     PosX2Gat1:=L;
     Exit;
    End
   End;
  End;
  If(Ok)Then Begin
   Inc(L);Inc(J);
   If(J>=P)Then Begin
    If(PC^[I]<' ')and(Byte(PC^[I])and cgDouble=cgDouble)Then PosX2Gat1:=L-1
    Else PosX2Gat1:=L;
    Exit;
   End
  End;
  Inc(I)
 End;
 PosX2Gat1:=P-J+L
End;