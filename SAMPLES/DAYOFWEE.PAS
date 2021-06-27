Const

  Day:Array[0..6]of String=('Dimanche','Lundi','Mardi','Mercredi','Jeudi','Vendredi','Samedi');

{Function DayOfWeek(Year:Word;Month,Day:Byte):Byte;
Var
 iAddVal:ShortInt;
Begin
 If Month<3Then iAddVal:=1
           Else iAddVal:=0;
 DayOfWeek:=((((3*Year-(7*(Year+(Month+9) div 12))
         shr 2)+(23*Month) div 9+Day+2
         +((Year-iAddVal) div 100+1)*3 div 4-16) mod 7));
End;}

{Retourne le jour de la semaine (0 = Dimanche) selon la congruence de Zeller
 dans son algorithme IZLR donnant une remarque dans l'®CACM Algorithm 398¯.
}

Function DayOfWeek(Year:Word;Month,Day:Byte):Byte;
Var
 Tmp1,Tmp2:LongInt;
Begin
 Tmp1:=Month+10;
 Tmp2:=Year+(Month-14)div 12;
 DayOfWeek:=((13*(Tmp1-Tmp1 div 13*12)-1)div 5+
              Day+77+(5*(Tmp2-Tmp2 div 100*100)shr 2)+
              Tmp2 div 400-Tmp2 div 100*2)mod 7;
End;


BEGIN
 WriteLn(Day[DayOfWeek(2004,03,31)]);
 WriteLn(Day[DayOfWeek(2004,04,03)]);
END.