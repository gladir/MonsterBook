Function DayofTheYear(LeapYear:Boolean;Month:Byte;DAY:Real):Integer;
Var
 N:Integer;
Begin
 If(LeapYear)Then N:=1
             Else N:=2;
 DayofTheYear:=275*Month div 9-N*((Month+9)div 12)+TRUNC(Day)-30;
End;

BEGIN
END.