{Circle.Inc}

{Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de tracer  un cercle … l'‚cran  avec comme
 centre la position (X,Y) en comme rayon (diamŠtre/2) naturellement
 la variable ®Rayon¯. La couleur est d‚fini par la variable ®Color¯.
}

Procedure Circle(X,Y,Rayon:Integer;Color:Word);Begin
 PutRoundRect(x-Rayon,y-Rayon,x+Rayon,y+Rayon,1,Rayon,Color);
End;