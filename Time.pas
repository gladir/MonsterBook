{ Cette unit� contient des fonctions de base pour la manipulation du
 concept de Temps (Heure et Date).
}

Unit Time;

{$I DEF.INC}

{�������������������������������������������������������������������������}
                                  INTERFACE
{�������������������������������������������������������������������������}

Procedure DateOfEaster(Year:Word;Var Month,Day:Byte);
Function  DayOfWeek(Year:Word;Month,Day:Byte):Byte;
Function  DayOfYear(Year:Word;Month,Day:Byte):Word;
Function  EasternDay(Year:Word):Word;
Procedure GetTime(Var Hour,Minute,Second,Sec100:Byte);
Function  IsLeapYear(Year:Word):Boolean;
Procedure SetTime(Hour,Minute,Second,Sec100:Byte);
Function  TimeDiff(Timer1,Timer2:LongInt):LongInt;
Function  TimeDiffH(Timer1,Timer2:LongInt):LongInt;
Function  TimeOfDay:LongInt;
Function  TimeOfDayH:LongInt;

{�������������������������������������������������������������������������}
                                IMPLEMENTATION
{�������������������������������������������������������������������������}

{ Retourne la mois et le jour de paque d'une ann�e sp�cifier par la
 variable Year.
}

Procedure DateOfEaster(Year:Word;Var Month,Day:Byte);
Var
 G,C,X,Z,D,E,N:Word;
Begin
 G:=Year mod 19+1;
 C:=Year div 100+1;
 X:=(3*C) div 4-12;
 Z:=(8*C+5) div 25-5;
 D:=(5*Year) div 4-X-10;
 E:=(11*G+20+Z-X)mod 30;
 If E<0Then Inc(E,30);
 If((E=25)and(G>11))or(E=24)Then Inc(E);
 N:=44-E;
 If N<21Then Inc(N,30);
 Inc(N,7-((D+N)mod 7));
 If N>31Then Begin
  Month:=4;
  Day:=N-31;
 End
  Else
 Begin
  Month:=3;
  Day:=N;
 End
End;

{�������������������������������������������������������������������
 �                       Fonction DayOfWeek                        �
 �������������������������������������������������������������������


Description
�����������

Cette fonction retourne le jour de la semaine en prenant pour acquis
que le 0 est Dimanche.

Remarque
��������

 � Utilise la congruence de Zeller dans son algorithme IZLR donnant une
   remarque dans l'�CACM Algorithm 398�.
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

{ Cette fonction calculer la journ�e (1 � 366) dans l'ann�e � partir d'une
 date conventionnelle.
}

Function DayOfYear(Year:Word;Month,Day:Byte):Word;
{$IFDEF Real}
 Assembler;ASM
  MOV BX,Year
  MOV CL,Day
  XOR CH,CH
  MOV DI,CX
  MOV CL,Month
  DEC CX
 {if Month>2 then  }
  CMP  CX,1
  JLE  @janfeb
 { S:=((Year mod 4) + 3) div 4 + (4 * Month + 23) div 10 - 1 }
  AND BX,3
  ADD BX,3
  {$IFOPT G+}
   SHR BX,2
  {$ELSE}
   SHR BX,1
   SHR BX,1
  {$ENDIF}
  MOV AX,CX
  INC AX
  {$IFOPT G+}
   SHL AX,2
  {$ELSE}
   SHL AX,1
   SHL AX,1
  {$ENDIF}
  ADD AX,23
  CWD
  PUSH CX
   MOV CX,10
   DIV CX
  POP CX
  DEC AX
  ADD BX,AX
  JMP @eif
 { else }
 @janfeb:
 { S := 0;}
  XOR BX,BX
 @eif:
 { DayNo:=31*(Month-1)+Day-S;}
  MOV AX,CX
  MOV CX,31
  MUL CX
  ADD AX,DI
  SUB AX,BX
 END;
{$ELSE}
 Const
  Days:Array[1..12]of Byte=(31,28,31,30,31,30,31,31,30,31,30,31);
 Var
  I:Byte;
  ResultReturn:Word;
 Begin
  If((Year mod 4=0)and(Year mod 100<>0))or(Year mod 400=0)Then Days[2]:=29
                                                          Else Days[2]:=28;
  ResultReturn:=0;
  For I:=1to Month-1do Inc(Result,Days[I]);
  DayOfYear:=ResultReturn+Day;
 End;
{$ENDIF}

Function EasternDay(Year:Word):Word;Assembler;ASM
 MOV AX,Year
 CMP AX,99
 JG  @noadd
 CMP AX,80
 JG  @not2000
 ADD AX,100
@not2000:
 ADD AX,1900
@noadd:
 MOV BX,AX
 CWD
 MOV CX,19
 DIV CX
 MOV AX,DX
 MUL CX
 ADD AX,24
 MOV CX,30
 DIV CX
 MOV SI,DX
 MOV AX,BX
 AND AX,3
 SHL AX,1
 MOV DI,AX
 MOV AX,BX
 CWD
 MOV CX,7
 DIV CX
 MOV AX,DX
 {$IFOPT G+}
  SHL AX,2
 {$ELSE}
  SHL AX,1
  SHL AX,1
 {$ENDIF}
 ADD DI,AX
 MOV AX,SI
 SHL AX,1
 ADD AX,SI
 SHL AX,1
 ADD AX,5
 ADD AX,DI
 CWD
 DIV CX
 ADD DX,SI
 ADD DX,81
 AND BX,3
 JNE @no29
 INC DX
@no29:
 MOV AX,DX
END;


{���������������������������������������������������������������������
 �                         Fonction IsLeapYear                       �
 ���������������������������������������������������������������������


 Description
 �����������

  Cette fonction indique s'il s'agit d'une ann�e bissextile.
}

Function IsLeapYear(Year:Word):Boolean;Begin
 IsLeapYear:=((Year and 3=0)and(Year mod 100<>0))or(Year mod 400=0);
End;

{������������������������������������������������������������������������
 �                           Proc�dure GetTime                          �
 ������������������������������������������������������������������������


 Description
 �����������

  Cette proc�dure renvoie l'heure telle qu'elle est connue par le syst�me
  d'exploitation.  Tous les param�tres  retourn�s sont des intervalles de
  mot  (sous standard  de  l'unit�  �DOS�)  ou d'octet: 0 � 23,  minutes,
  seconde: 0 � 59, centi�me de seconde: 0 � 59.
}

{$I \Source\Chantal\Library\GetTime.Inc}
{$I \Source\Chantal\Library\SetTime.Inc}

{����������������������������������������������������������������������
 �                         Fonction TimeDiff                          �
 ����������������������������������������������������������������������


 Description
 �����������

  Cette fonction  retourne la diff�rence  de temps entre 2 compteurs en
 secondes et retourne naturellement le r�sultat en secondes.
}

Function TimeDiff{Timer1,Timer2:LongInt):LongInt};
Var
 TDiff:LongInt;
Begin
 TDiff:=Timer2-Timer1;
 If TDiff<0Then Inc(TDiff,86400);
 TimeDiff:=TDiff;
End;

{����������������������������������������������������������������������
 �                         Fonction TimeDiffH                         �
 ����������������������������������������������������������������������


 Description
 �����������

  Cette fonction  retourne la diff�rence  de temps entre 2 compteurs en
 milli�me de secondes et retourne naturellement le r�sultat en milli�me
 de secondes.
}

Function TimeDiffH{Timer1,Timer2:LongInt):LongInt};
Var
 TDiff:LongInt;
Begin
 TDiff:=Timer2-Timer1;
 If Tdiff<0Then Inc(Tdiff,8640000);
 TimeDiffH:=Tdiff;
End;


{������������������������������������������������������������������������
 �                           Fonction TimeOfDay                         �
 ������������������������������������������������������������������������


 Description
 �����������

  Cette fonction permet � partir de l'heure,  les minutes et des secondes
 de retourner le nombre de seconde qu'elle comprend en tous et partout en
 tenant compte de l'heure, minute,... au total.
}

Function TimeOfDay:LongInt;
Var
 Hours,Minutes,Seconds,SecHun:
  {$IFDEF DosUnit}
   Word
  {$ELSE}
   Byte
 {$ENDIF};
Begin
 GetTime(Hours,Minutes,Seconds,SecHun);
 TimeOfDay:=LongInt(Hours)*3600+Minutes*60+Seconds
End;

{������������������������������������������������������������������������
 �                           Fonction TimeOfDayH                        �
 ������������������������������������������������������������������������


 Description
 �����������

  Cette fonction permet � partir de l'heure, les minutes, les secondes et
 les milli�mes de secondes de retourner le nombre de milliseconde qu'elle
 comprend en tous et partout en tenant compte  de l'heure,  minute,... au
 total.
}

Function TimeOfDayH:LongInt;
Var
 Hours,Minutes,Seconds,SecHun:
 {$IFDEF DosUnit}
  Word
 {$ELSE}
  Byte
 {$ENDIF};
Begin
 GetTime(Hours,Minutes,Seconds,SecHun);
 TimeOfDayH:=LongInt(Hours)*360000+Minutes*6000+Seconds*100+SecHun
End;

END.