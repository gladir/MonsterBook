{PutRect.Inc}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Proc‚dure PutRect                            Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure affiche une rectangle vide avec comme coordonn‚e sup‚rieur
 gauche  (X1,Y1)  et inf‚rieur  droite  (X2,Y2)  avec la  couleur  graphique
 courante (D‚finit … la de la fonction _SetKr).
}

Procedure PutRect(X1,Y1,X2,Y2,Kr:Integer);Var J:Wd;Begin
 PutLnHor(X1,Y1,X2,Kr);
 For J:=Y1+1to Y2-1do Begin SetPixel(X1,J,Kr);SetPixel(X2,J,Kr)End;
 PutLnHor(X1,Y2,X2,Kr);
End;