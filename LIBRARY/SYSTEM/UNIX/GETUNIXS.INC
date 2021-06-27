{GetUnixS.Inc}

{$IFNDEF __GetUnixStyleDate}
 {$DEFINE __GetUnixStyleDate}
 {$I Library\System\Unix\Month.Inc}
 {$I Library\System\Unix\SetYear.Inc}

Procedure GetUnixStyleDate(Date:LongInt;Var Year{$IFDEF DosUnit},{$ELSE}:Word;Var{$ENDIF}
                           Month,Day,Hour,Mins,Secs:{$IFDEF DosUnit}Word{$ELSE}Byte{$ENDIF});
Var RDate,T:Long;Begin
 Year:=1970;Month:=1;Dec(RDate,GMTDifference*3600);
 While RDate>0do Begin
  If Year and 3=0Then T:=31622400 Else T:=31536000;
  Dec(RDate,T);Inc(Year)
 End;
 Inc(RDate,T);Dec(Year);
 SetYear(Year);
 While RDate>0do Begin
  T:=DaysPerMonth[Month]*86400;
  Dec(RDate,T);Inc(Month)
 End;
 Inc(RDate,T);Dec(Month);
 Day:=DivLong(RDate+86399,86400);
 Dec(RDate,Long(Pred(Day))*86400);
 Hour:=DivLong(RDate,3600);
 Dec(RDate,Long(Hour)*3600);
 Mins:=DivLong(RDate,60);
 Secs:=RDate-LongInt(Mins)*60
End;

{$ENDIF}