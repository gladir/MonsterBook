{PutRect.Inc}

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                            Proc괺ure PutRect                            �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Description
 袴袴袴袴袴�

  Cette proc괺ure affiche une rectangle vide avec comme coordonn괻 sup굍ieur
 gauche  (X1,Y1)  et inf굍ieur  droite  (X2,Y2)  avec la  couleur  graphique
 courante (D괽init � la de la fonction _SetKr).
}

Procedure PutRect(X1,Y1,X2,Y2,Kr:Integer);Var J:Wd;Begin
 PutLnHor(X1,Y1,X2,Kr);
 For J:=Y1+1to Y2-1do Begin SetPixel(X1,J,Kr);SetPixel(X2,J,Kr)End;
 PutLnHor(X1,Y2,X2,Kr);
End;