{FillCircle.Inc}

Procedure PutFillCircle(X,Y,Rayon:Integer;Color:Word);Begin
 PutFillRoundRect(x-Rayon,y-Rayon,x+Rayon,y+Rayon,Rayon,Color);
End;