{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                                                                         Û
 ³                      Malte Genesis/Outil du temps                       Û
 ³            dition Chantal pour Mode R‚el/IV - Version 1.1              Û
 ³                                                                         Û
 ³       Tous droits r‚serv‚s par les Chevaliers de Malte XXIe siŠcle      Û
 ³                                                                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Nom du programmeur
 ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

  Sylvain Maltais


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette unit‚ est utilis‚ pour la gestion du temps par l'utilisateur de
 toutes les formes possible et immaginable.
}

Unit ToolTime;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                  INTERFACE
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses Systex,Isatex;

Const
 MaxXCalendar=44;
 MaxYCalendar=12;

Function  CAInit(Var Context;X1,Y1,X2,Y2:Byte):Boolean;
Procedure CAGoto(Var Context;Year:LongInt;Mouth:Byte);
Procedure CARefresh(Var Context);
Function  CARun(Var Context):Word;
Function  CATitle(Var Q;Max:Byte):String;
Procedure CAMove2(Var Context;X,Y:Byte);
Function  CADone(Var Context):Word;
Procedure WinDayInDate;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                 IMPLEMENTATION
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses
 Systems,Adele,Mouse,Video,Dialex,Dials,DialPlus,Time,
 ResServD,SysInter,ResServI;

Const
 D0=1461;          { Journ‚e par 4 ans }
 D1=146097;        { Journ‚e pour 4 siŠcles }
 D2=1721119;

Procedure WECircle(Var W:Window;CircleType:Real);
Var
 Kr:Byte;
 Quart:Boolean;
 GXC,GYC:Word;
Begin
 If Not(HoleMode)Then Begin
  Quart:=No;
  If CircleType>0.97Then Kr:=$F Else
  If CircleType<0.03Then Kr:=0 Else
  If(CircleType>0.46)and(CircleType<0.53)Then Begin
   Quart:=True;Kr:=$F;
  End
 { If(CircleType>0.72)and(CircleType<0.78)Then Begin;Quart:=Ya;Kr:=0;End Else
  If(CircleType>0.22)and(CircleType<0.28)Then Begin;Quart:=Ya;Kr:=$F;End}
                    Else Kr:=9;
  If Kr<>9Then Begin
   If(IsGrf)Then Begin
    GXC:=(WEGetRealX(W)shl 3)+4;
    GYC:=GetRawY(WEGetRealY(W))+(HeightChr shr 1);
    PutFillCircle(GXC,GYC,6,Kr);
    If(Quart)Then Begin
     If Kr=$FThen PutFillCircle(GXC+4,GYC,6,W.CurrColor shr 4)
             Else PutFillCircle(GXC-4,GYC,6,W.CurrColor shr 4)
    End;
   End
    Else
   If Not(Quart)Then SelIcon(WEGetRealX(W),WEGetRealY(W),(W.CurrColor and $F0)+Kr);
  End;
 End;
 Inc(W.X,2);
End;

Function DiffDayWithDate(Year1,Mouth1,Day1,Year2,Mouth2,Day2:Word):LongInt;

 Function Jul(mo,da,yr:SmallInt):LongInt;
 Var
  i,j,k,j2,ju:Real;
 Begin
  i:=yr;j:=mo;k:=da;
  j2:=System.Int((j-14)/12);
  ju:=k-32075+System.Int(1461*(i+4800+j2)/4);
  ju:=ju+System.Int(367*(j-2-j2*12)/12);
  ju:=ju-System.Int(3*System.Int((i+4900+j2)/100)/4);
  Jul:=Trunc(ju);
 End;

Begin
 DiffDayWithDate:=Abs(Jul(Mouth2,Day2,Year2)-Jul(Mouth1,Day1,Year1));
End;

Procedure Gregorian2JulianDN(Year:Word;Month,Day:Byte;Var JulianDN:Long);
Var
 Century,XYear:LongInt;
Begin
 If Month<=2Then Begin
  Year:=Pred(Year);
  Inc(Month,12);
 End;
 Dec(Month,3);
 Century:=Year div 100;
 XYear:=Year mod 100;
 Century:=(Century*D1)shr 2;
 XYear:=(XYear*D0)shr 2;
 JulianDN:=Trunc(((((Month*153)+2)div 5)+Day)+D2+XYear+Century);
End;

{
  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de d‚terminer les phases de la lune (en pourcentage).

  Retour
  ÍÍÍÍÍÍ

   0,00       = Nouvelle lune
   1,00       = La pleine lune
   ...        = Due … l'arrondissement,  il est possible  que la r‚ponse soit
                erronn‚ du 15 octobre 1582 au 28 f‚vrier 4000.

  R‚f‚rence
  ÍÍÍÍÍÍÍÍÍ

   ş Les calculs  et  le  programme  BASIC  sont  disponibles  dans  le  ®119
     Practical Programs For The TRS-80 Pocket Computer¯ par John Clark Craig,
     TAB Book, 1982. Conversion en Pascal par Alan Graff, Wheelersburg, OH.
}

Function MoonPhase(Year:Word;Month,Day:Byte):Real;
Var
 J:LongInt;
 M:Real;
Begin
 Gregorian2JulianDN(Year,Month,Day,J);
 M:=(J+4.867)/29.53058;
 M:=2*(M-System.Int(M))-1;
 MoonPhase:=Abs(M);
End;

Function CalcDOW(Y:LongInt;M,D:Word):Byte;
Var
 T1,T2,T3,T4,T5,T6,T7:LongInt;
Begin
 If(M>12)or(M=0)or(D=0)Then Begin
  CalcDOW:=0;
  Exit;
 End;
 If Y<0Then Inc(Y); { L'an n'existe pas mais les mois ce compte -1 comme si
                      c'‚tait l'an 0...}
 T1:=M+12*Trunc(0.6+1/M);
 T2:=Y-Trunc(0.6+1/M);
 T3:=Trunc(13*(T1+1)/5);
 T4:=Trunc(5*T2/4);
 T5:=Trunc(T2/100);
 T6:=Trunc(T2/400);
 T7:=T3+T4-T5+T6+D-1;
 CalcDOW:=T7-7*Trunc(T7/7);
End;

Function IsWorkDay(Year:Word;Month,Day:Byte):Boolean;
Var
 WeekDay:Byte;
Begin
  WeekDay:=DayOfWeek(Year,Month,Day);
  IsWorkDay:=Not((WeekDay=0)or(WeekDay=6)or{Fin de semaine?}
                ((Day=1)and(Month=1))or    {Jour de l'an}
                ((Day=25)and(Month=12))or  {Jour de noel}
                ((Day=26)and(Month=12)));   {Lendemain de Noel}
End;


Procedure CAShowCountry(Var Q:CalendarApp;X,Y:Byte;Country:Word);
Var
 Data:CountryDataSetRec;
 ConvL:LongInt Absolute ConvP;
 Res:XInf;
 GX1,GY1:Word;
Begin
 DBOpenServerName(ChantalServer,'CHANTAL:/Country/Country.Dat');
 If(DBLocateAbs(ChantalServer,0,Country,[]))Then Begin
  DBReadRec(ChantalServer,Data);
  ConvP:=@Data;
  DBGotoColumnAbs(ChantalServer,5,Pointer(ConvP));
  If ConvL<>0Then Begin
   ASM
    ADD Word Ptr ConvP,4+11
   END;
   FillClr(Res,SizeOf(Res));
   Res.Output:=irmConvMem;
   Res.Size:=621;
   GX1:=(WEGetRX1(Q.W)+X)shl 3;
   GY1:=GetRawY(WEGetRY1(Q.W)+Y);
   RIPutImageScale(Res,GX1,GY1,28,HeightChr,CurrKrs.Dialog.Env.List.Border);
  End;
 End;
End;

Procedure CAPutCalendar(Var Q:CalendarApp);
Var
 D,I:Byte;
 Days:Array[0..12]of Byte;
 SDays:String[12]Absolute Days;
 GX1,GY1,Year:Word;
 CurrMonth,CurrDay,CurrDayOfWeek:Byte;
 CurrYear,Century,Yr:Word;
 EasternMonth,EasternDay:Byte;
 IsDay:Boolean;
 IsGrayDay:Boolean;
 IsFlag:Boolean;
 S:String;
Begin
 WESetKrBorder(Q.W);
 Year:=Q.Year;
 GetDate(CurrYear,CurrMonth,CurrDay,CurrDayOfWeek);
 WEClrScr(Q.W);
 WEBar(Q.W);
 WELn(Q.W);
 Case(Q.MonthMode)of
  3:Case(Q.Month)of
   1:S:='Janus';
   2:S:='Purification';
   3:S:='Mars';
   4:S:='Aphrodite';
   5:S:='Maia';
   6:S:='Junon';
   7:S:='Jules C‚sar';
   8:S:='Auguste';
   9:S:='SeptiŠme';
   10:S:='HuitiŠme';
   11:S:='NeuviŠme';
   12:S:='DixiŠme';
   Else S:='Inconnu';
  End;
  2:Case(Q.Month)of
   1:S:='Januaris';
   2:S:='Februarus';
   3:S:='Martius';
   4:S:='Aprilis';
   5:S:='Maius';
   6:S:='Junius';
   7:S:='Julius';
   8:S:='Augustus';
   9:S:='September';
   10:S:='October';
   11:S:='November';
   12:S:='December';
   Else S:='Inconnu';
  End;
  Else Begin
   Case(Q.Month)of
    1:S:='Janvier³January³Enero';
    2:S:='F‚vrier³February³Febrero';
    3:S:='Mars³March³Marzo';
    4:S:='Avril³April³Abril';
    5:S:='Mai³May³Mayo';
    6:S:='Juin³June³Junio';
    7:S:='Juillet³July³Julio';
    8:S:='Ao–t³August³Agosto';
    9:S:='Septembre³September³Septiembre';
    10:S:='Octobre³October³Octubre';
    11:S:='Novembre³November³Noviembre';
    12:S:='D‚cembre³December³Deciembre';
    Else S:='Inconnu';
   End;
   S:=MessageByLanguage(S);
  End;
 End;
 IncStr(S,' ');
 AddStr(S,IntToStr(Q.Year));
 If(IsGrf)Then Begin
  For I:=1to Length(S)do WEPutChrGAttr(Q.W,S[I],cgDouble+cgBold);
  WELn(Q.W);
 End
  Else
 WEPutTxtLn(Q.W,S);
 WELn(Q.W);
 SDays:=#31#28#31#30#31#30#31#31#30#31#30#31;
 If IsLeapYear(Year)Then Days[2]:=29;
 D:=CalcDOW(Q.Year,Q.Month,1);
 Case(Q.WeekDayMode)of
  4:Begin {Jour de semaine du calendrier Indon‚sien}
   {Minggu, Senin, Selasa, Rabu, Kamis, Jumat, Sabtu}
   WEPutTxtLn(Q.W,'Mingg Senin Selas Rabu  Kamis Jumat Sabtu');
  End;
  2:Begin
   {Dies dominicus, Lunae, Martis, Mercoris, Jovis, Veneris, Sambati}
   WEPutTxtLn(Q.W,'Dies  Lunae Marti Merco Jovis Vener Sambati');
  End;
  1:Begin
   WEPutTxtLn(Q.W,'Solei Lune  Mars  Mercu Jupit V‚nus Sabbat');
  End;
  Else WEPutTxtLn(Q.W,MessageByLanguage(
        'Diman Lundi Mardi Mercr Jeudi Vendr Samedi³'+
        'Sunda Monda Tuesd Wedne Thurs Frida Saturday³'+
        'Domin Lunes Marte Mi‚rc Jueve Viern S bado'
       ));
 End;
 WEPutTxtLn(Q.W,'ÄÄÄÄÄ ÄÄÄÄÄ ÄÄÄÄÄ ÄÄÄÄÄ ÄÄÄÄÄ ÄÄÄÄÄ ÄÄÄÄÄÄ');
 WESetKrHigh(Q.W);
 For I:=1to(D)do WEPutTxt(Q.W,'      ');
 DateOfEaster(Q.Year,EasternMonth,EasternDay);
 For I:=1to Days[Q.Month]do Begin
  IsFlag:=False;
  IsDay:=(Q.Year=CurrYear)and(Q.Month=CurrMonth)and(I=CurrDay);
  IsGrayDay:=Not IsWorkDay(Q.Year,Q.Month,I);
  If(IsDay)Then WESetKrSel(Q.W)Else
  If(IsGrayDay)Then Q.W.CurrColor:=$83
               Else WESetKrHigh(Q.W);
  WEPutTxt(Q.W,Str2(I,2));
  If(EasternMonth=Q.Month)and(I=EasternDay)Then Begin
   Q.W.CurrColor:=(Q.W.CurrColor and$F0)+LightRed;
   WEPutTxt(Q.W,'é');
  End
   Else
  If(Q.Month=2)and(I=14)Then Begin { Saint-Valentin? }
   Q.W.CurrColor:=(Q.W.CurrColor and$F0)+LightRed;
   If(IsGrf)Then WEPutTxt(Q.W,#3)
            Else WEPutTxt(Q.W,'V');
  End
   Else
  If(Q.Month=3)and(I=17)Then Begin { Saint-Patrick }
   Q.W.CurrColor:=(Q.W.CurrColor and$F0)+Green;
   If(IsGrf)Then WEPutTxt(Q.W,#5)
            Else WEPutTxt(Q.W,'P');
  End
   Else
  If(Q.Month=6)and(I=11)Then Begin {Fˆte du Saguenay-Lac-Saint-Jean }
   If(IsGrf)Then Begin
    CAShowCountry(Q,Q.W.X,Q.W.Y,6050);
    Inc(Q.W.X,2);
    IsFlag:=True;
   End;
  End
   Else
  If(Q.Month=6)and(I=24)Then Begin { Saint-Jean-Baptiste? }
   If(IsGrf)Then Begin
    CAShowCountry(Q,Q.W.X,Q.W.Y,5700);
    Inc(Q.W.X,2);
    IsFlag:=True;
   End
    Else
    Begin
    Q.W.CurrColor:=(Q.W.CurrColor and$F0)+LightBlue;
    WEPutTxt(Q.W,'Q');
   End;
  End
   Else
   WEPutTxt(Q.W,' ');
  If(IsDay)or(IsGrayDay)and(Not IsFlag)Then Begin
   WEPutTxt(Q.W,'  ');
   Dec(Q.W.X,2);
  End;
  If(Q.Month=2)and(I=16)and(Q.Year=1974)Then Begin { Naissance de l'auteur du MonsterBook }
   _RIViewImage('SYS:MEDIA.RLL',39,Q.W,Q.W.Y,Q.W.MaxX-Q.W.X-1,HeightChr,16,0);
   Inc(Q.W.X,2);
  End
   Else
  WECircle(Q.W,MoonPhase(Q.Year,Q.Month,I));
  If(IsDay)or(IsGrayDay)Then WESetKrHigh(Q.W);
  If Not(IsFlag)Then WEPutTxt(Q.W,' ');
  If Not((D+I)mod 7>0)Then WELn(Q.W);
 End;
 If(IsGrf)and(Cadril)and Not(HoleMode)Then Begin
  _SetKr(Q.W.Palette.Sel shr 4);
  GX1:=WEGetRX1(Q.W)shl 3;
  GY1:=GetRawY(WEGetRY1(Q.W));
  For I:=1to 6do Begin
   _Ln(GX1+(Pred(I*6)shl 3)+3,GY1+GetRawY(3),
       GX1+(Pred(I*6)shl 3)+3,GY1+GetRawY(12)-8);
  End;
  For I:=1to 5do Begin
   _Ln(GX1,GY1+GetRawY(5+I)-1,GX1+((Q.W.MaxX+1)shl 3),GY1+GetRawY(5+I)-1);
  End;
 End;
End;

Procedure CARefresh{Var Q};
Var
 Q:CalendarApp Absolute Context;
Begin
 WEPutWnKrDials(Q.W,CATitle(Q,Q.W.MaxX));
 WECloseIcon(Q.W);
 WEPutBarMsRight(Q.W);
 CAPutCalendar(Q);
End;

Function CAInit{Var Q;X1,Y1,X2,Y2:Byte};
Var
 Q:CalendarApp Absolute Context;
 Y:Word;
Begin
 GetDate(Y,Q.Month,Q.Day,Q.DayOfWeek);
 Q.Year:=Y;
 If(X2-X1>MaxXCalendar)Then X2:=X1+MaxXCalendar;
 If(Y2-Y1>MaxYCalendar)Then Y2:=Y1+MaxYCalendar;
 WEInit(Q.W,X1,Y1,X2,Y2);
 CARefresh(Q);
 CAInit:=True;
End;

Function CARun{Var Context):Word};
Label
 UpdateMonth;
Var
 Day:Byte;
 K:Word;
 Q:CalendarApp Absolute Context;
Begin
 Repeat
  K:=WEReadk(Q.W);
  Case(K)of
   kbInWn:If LastMouseB=2Then Begin
    K:=RunMenuApp(56);
    Case(K)of
     $F001:WinDayInDate;
     $F011..$F01C:Begin
      Q.Month:=K and$F;
      Goto UpdateMonth;
     End;
     $F01D:Begin
      DateOfEaster(Q.Year,Q.Month,Day);
      Goto UpdateMonth;
     End;
     $F01E:Begin
      Q.Year:=1974;
      Q.Month:=2;
      Goto UpdateMonth;
     End;
     $F030..$F03F:Begin
      Q.WeekDayMode:=K and$F;
      Goto UpdateMonth;
     End;
     $F040..$F04F:Begin
      Q.MonthMode:=K and$F;
UpdateMonth:
      CAPutCalendar(Q);
     End;
    End;
   End;
   kbRBarMsUp,kbPgUp:Begin
    If(K=kbRBarMsUp)Then DelayMousePress(500);
    If Q.Month=1Then Begin
     Dec(Q.Year);
     Q.Month:=12;
     If Q.Year=0Then Q.Year:=-1;
    End
     Else
    Dec(Q.Month);
    CAPutCalendar(CalendarApp(Q));
   End;
   kbRBarMsDn,kbPgDn:Begin
    If(K=kbRBarMsDn)Then DelayMousePress(500);
    If Q.Month=12Then Begin
     Q.Month:=1;
     Inc(Q.Year);
     If Q.Year=0Then Q.Year:=1;
    End
     Else
    Inc(Q.Month);
    CAPutCalendar(Q);
   End;
   kbCtrlPgUp,kbRBarMsPgUp:Begin
    If(K=kbRBarMsPgUp)Then DelayMousePress(500);
    Dec(Q.Year);
    If Q.Year=0Then Q.Year:=-1;
    CAPutCalendar(Q);
   End;
   kbCtrlPgDn,kbRBarMsPgDn:Begin
    If(K=kbRBarMsPgDn)Then DelayMousePress(500);
    Inc(Q.Year);
    If Q.Year=0Then Q.Year:=1;
    CAPutCalendar(Q);
   End;
   Else Break;
  End;
 Until No;
 CARun:=K;
End;

Procedure CAGoto{Var Q;Year:LongInt;Mouth:Byte};
Var
 Q:CalendarApp Absolute Context;
Begin
 If Year=0Then Begin
  ErrMsgOk('D‚sol‚! mais l''an 0 n''existe pas dans notre calendrier... '+
           'Notre calendrier commence … l''an 1!');
 End
  Else
 Begin
  Q.Year:=Year;
  Q.Month:=Mouth;
  CAPutCalendar(Q);
 End;
End;

Procedure CAMove2{Var Context;X,Y:Byte};
Var
 Q:CalendarApp Absolute Context;
 MX,MY:Byte;
Begin
 MX:=Q.W.T.X2-Q.W.T.X1;MY:=Q.W.T.Y2-Q.W.T.Y1;
 Q.W.T.X1:=X;Q.W.T.X2:=X+MX;
 Q.W.T.Y1:=Y;Q.W.T.Y2:=Y+MY;
 CARefresh(Q);
End;

Function CATitle(Var Q;Max:Byte):String;Begin
 CATitle:=MessageByLanguage('Calendrier³Calendar');
End;

Function CADone{Var Context):Word};
Var
 Q:CalendarApp Absolute Context;
Begin
 WEDone(Q.W);
 CADone:=0;
End;

Procedure WinDayInDate;
Var
 FormDate:Record
  Sep1:String[1];
  Sep2:String[1];
  Sep3:String[1];
  Sep4:String[1];
  Year1:Word;
  Mouth1:Byte;
  Day1:Byte;
  Year2:Word;
  Mouth2:Byte;
  Day2:Byte;
 End;
 DOW:Byte;
Begin
 FillClr(FormDate,SizeOf(FormDate));
 GetDate(FormDate.Year1,FormDate.Mouth1,FormDate.Day1,DOW);
 GetDate(FormDate.Year2,FormDate.Mouth2,FormDate.Day2,DOW);
 FillWord(FormDate,4,(Byte(DtSep[0])shl 8)+$1);
 If ExecuteAppDPU(145,FormDate)Then Begin
  DialogMsgOk('Il y a '+
              IntToStr(DiffDayWithDate(FormDate.Year1,FormDate.Mouth1,FormDate.Day1,
                                       FormDate.Year2,FormDate.Mouth2,FormDate.Day2))+
              ' jours entre les deux dates!');
 End;
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
END.