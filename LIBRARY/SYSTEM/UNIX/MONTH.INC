{$IFNDEF __Month}
 {$DEFINE __Month}
Const
 GMTDifference:ShortInt=0;
 DaysPerMonth:Array[1..12]of Byte=(31,28,31,30,31,30,31,31,30,31,30,31);

Var
 Days4Month:Array[0..11]of Byte Absolute DaysPerMonth;
{$ENDIF}