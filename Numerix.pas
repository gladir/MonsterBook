{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                                                                         Û
 ³                          Malte Genesis/Numerix                          Û
 ³                                                                         Û
 ³            dition Chantal pour Mode R‚el/IV - Version 1.1              Û
 ³                              1995/11/30                                 Û
 ³                                                                         Û
 ³          Tous droits r‚serv‚s par les Chevaliers de Malte (C)           Û
 ³                                                                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Nom des programmeurs
 ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

  Sylvain Maltais
  Floor Naaijkens (Fonctions trigonom‚trique)
  Lou Duchez (Fonctions de calcul int‚gral et diff‚rentiel)


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette unit‚ renferme toutes les routines utiliser pour la r‚solutions des
 problŠmes math‚matiques complexes.
}


Unit Numerix;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                 INTERFACE
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

{$I DEF.INC}

Uses
 Systex,Isatex;

Const
 RadiansPerDegree=0.017453292520; { Radian par degr‚e}
 DegreesPerRadian=57.295779513;   { Degr‚e par radian }
 MinutesPerDegree=60.0;           { Minute par degr‚e }
 SecondsPerDegree=3600.0;         { Secondes par degr‚e }
 SecondsPerMinute=60.0;           { Minute par seconde }
 LnOf10=2.3025850930;             { Logarithme naturel de 10 }
 Infinity=9.9999999999E+37;

Type
 DegreeType=Record
  Degrees,Minutes,Seconds:Real;
 End;

{Formule de conversion}
Function  Fahr2Cent(FahrTemp:Real):Real;
Function  Cent2Fahr(CentTemp:Real):Real;
Function  Kelv2Cent(KelvTemp:Real):Real;
Function  Cent2Kelv(CentTemp:Real):Real;
Procedure Inch2FtIn(Inches:Real;Var ft,ins:Real);
Function  FtIn2Inch(ft,ins:Real):Real;
Function  Inch2Yard(Inches:Real):Real;
Function  Yard2Inch(Yards:Real):Real;
Function  Inch2Mile(Inches:Real):Real;
Function  Mile2Inch(Miles:Real):Real;
Function  Inch2NautMile(Inches:Real):Real;
Function  NautMile2Inch(NautMiles:Real):Real;
Function  Inch2Meter(Inches:Real):Real;
Function  Meter2Inch(Meters:Real):Real;
Function  SqInch2SqFeet(SqInches:Real):Real;
Function  SqFeet2SqInch(SqFeet:Real):Real;
Function  SqInch2SqYard(SqInches:Real):Real;
Function  SqYard2SqInch(SqYards:Real):Real;
Function  SqInch2SqMile(SqInches:Real):Real;
Function  SqMile2SqInch(SqMiles:Real):Real;
Function  SqInch2Acre(SqInches:Real):Real;
Function  Acre2SqInch(Acres:Real):Real;
Function  SqInch2SqMeter(SqInches:Real):Real;
Function  SqMeter2SqInch(SqMeters:Real):Real;
Function  CuInch2CuFeet(CuInches:Real):Real;
Function  CuFeet2CuInch(CuFeet:Real):Real;
Function  CuInch2CuYard(CuInches:Real):Real;
Function  CuYard2CuInch(CuYards:Real):Real;
Function  CuInch2CuMeter(CuInches:Real):Real;
Function  CuMeter2CuInch(CuMeters:Real):Real;
Function  FluidOz2Pint(FluidOz:Real):Real;
Function  Pint2FluidOz(Pints:Real):Real;
Function  FluidOz2ImpPint(FluidOz:Real):Real;
Function  ImpPint2FluidOz(ImpPints:Real):Real;
Function  FluidOz2Gals(FluidOz:Real):Real;
Function  Gals2FluidOz(Gals:Real):Real;
Function  FluidOz2ImpGals(FluidOz:Real):Real;
Function  ImpGals2FluidOz(ImpGals:Real):Real;
Function  FluidOz2CuMeter(FluidOz:Real):Real;
Function  CuMeter2FluidOz(CuMeters:Real):Real;
Procedure Ounce2LbOz(Ounces:Real;Var lb,oz:Real);
Function  LbOz2Ounce(lb,oz:Real):Real;
Function  Ounce2Ton(Ounces:Real):Real;
Function  Ton2Ounce(Tons:Real):Real;
Function  Ounce2LongTon(Ounces:Real):Real;
Function  LongTon2Ounce(LongTons:Real):Real;
Function  Ounce2Gram(Ounces:Real):Real;
Function  Gram2Ounce(Grams:Real):Real;

{Formule de Statistiques}
Function Factorial(Num:Integer):Real;
Function P(N,R:Integer):Real;
Function C(N,R:Integer):Real; { COMBIN }

{Formule Radians: Sin, Cos et ArcTan}
Function Tan(Radians:Real):Real;
Function ArcSin(InValue:Real):Real;
Function ArcCos(InValue:Real):Real;

{Degr‚es, expression en nombre r‚el }
Function Degrees2Radians(Degrees:Real):Real;
Function Radians2Degrees(Radians:Real):Real;
Function SinDegree(Degrees:Real):Real;
Function CosDegree(Degrees:Real):Real;
Function TanDegree(Degrees:Real):Real;
Function ArcSinDegree(Degrees:Real):Real;
Function ArcCosDegree(Degrees:Real):Real;
Function ArcTanDegree(Degrees:Real):Real;

{Degr‚es, dans Degr‚es, Minutes, et Seconds, en nombre r‚el }
Function  DegreeParts2Degrees(Degrees,Minutes,Seconds:Real):Real;
Function  DegreeParts2Radians(Degrees,Minutes,Seconds:Real):Real;
Procedure Degrees2DegreeParts(DegreesIn:Real;Var Degrees,Minutes,Seconds:Real);
Procedure Radians2DegreeParts(Radians:Real;Var Degrees,Minutes,Seconds:Real);
Function  SinDegreeParts(Degrees,Minutes,Seconds:Real):Real;
Function  CosDegreeParts(Degrees,Minutes,Seconds:Real):Real;
Function  TanDegreeParts(Degrees,Minutes,Seconds:Real):Real;
Function  ArcSinDegreeParts(Degrees,Minutes,Seconds:Real):Real;
Function  ArcCosDegreeParts(Degrees,Minutes,Seconds:Real):Real;
Function  ArcTanDegreeParts(Degrees,Minutes,Seconds:Real):Real;

{Degr‚es, expression dans DegreeType (Enregistrement avec nombres r‚els) }
Function  DegreeType2Degrees(DegreeVar:DegreeType):Real;
Function  DegreeType2Radians(DegreeVar:DegreeType):Real;
Procedure DegreeType2DegreeParts(DegreeVar:DegreeType;Var Degrees,Minutes,Seconds:Real);
Procedure Degrees2DegreeType(Degrees:Real;Var DegreeVar:DegreeType);
Procedure Radians2DegreeType(Radians:Real;Var DegreeVar:DegreeType);
Procedure DegreeParts2DegreeType(Degrees,Minutes,Seconds:Real;Var DegreeVar:DegreeType);
Function  SinDegreeType(DegreeVar:DegreeType):Real;
Function  CosDegreeType(DegreeVar:DegreeType):Real;
Function  TanDegreeType(DegreeVar:DegreeType):Real;
Function  ArcSinDegreeType(DegreeVar:DegreeType):Real;
Function  ArcCosDegreeType(DegreeVar:DegreeType):Real;
Function  ArcTanDegreeType(DegreeVar:DegreeType):Real;

{Fonctions Hyperbolique}
Function  Sinh(Invalue:Real):Real;
Function  Cosh(Invalue:Real):Real;
Function  Tanh(Invalue:Real):Real;
Function  Coth(Invalue:Real):Real;
Function  Sech(Invalue:Real):Real;
Function  Csch(Invalue:Real):Real;
Function  ArcSinh(Invalue:Real):Real;
Function  ArcCosh(Invalue:Real):Real;
Function  ArcTanh(Invalue:Real):Real;
Function  ArcCoth(Invalue:Real):Real;
Function  ArcSech(Invalue:Real):Real;
Function  ArcCsch(Invalue:Real):Real;

(*Fonctions Logarithmiques, Puissances et Racines*)
{ ®e¯ … la ®x¯ c'est la fonction ®Exp¯ }
{ Le logarithme naturel c'est la fonction ®ln¯ }
Function  Log10(InNumber:Real):Real;
Function  Log(Base,InNumber:Real):Real;  { Log dans n'importe quel base }
Function  Root(InNumber,TheRoot:Real):Real;

{Fonctions de calculs int‚gral et diff‚rentiel}
Function Integral(A,B,H:Real;F:Pointer):Real;
Function Derivative(X,Dx:Real;F:Pointer):Real;
Function Extremum(X,Dx,Tolerance:Real;F:Pointer):Real;

{Calcul des p‚rimŠtres, aires et des volumes}
Function TriangleArea(B,H:Real):Real;
Function EquilateralTriangleArea(S:Real):Real;
Function CircleArea(R:Real):Real;
Function EllipseArea(A,B:Real):Real;
Function SquareArea(S:Real):Real;
Function RectangleArea(X,Y:Real):Real;
Function CubeSurfaceArea(S:Real):Real;
Function RectangularPrismSurfaceArea(H,W,L:Real):Real;
Function SphereSurfaceArea(R:Real):Real;
Function CylinderSurfaceArea(R,H:Real):Real;
Function ConeSurfaceAreaWithoutBase(R,H:Real):Real;
Function ConeSurfaceAreaWithBase(R,H:Real):Real;
Function SectorArea(R,A:Real):Real;
Function TrapezoidArea(A,B,H:Real):Real;
Function CircleCircumference(R:Real):Real;
Function EllipseCircumference(A,B:Real):Real;
Function CubeVolume(S:Real):Real;
Function RectangleVolume(X,Y,Z:Real):Real;
Function SphereVolume(R:Real):Real;
Function CylinderVolume(R,H:Real):Real;
Function ConeVolume(R,H:Real):Real;
Function PrismVolume(B,H:Real):Real;
Function Distance(X1,X2,Y1,Y2:Real):Real;

{Fonctions divers}
Function Prime(N:Word):Boolean;

{R‚solution de problŠme}
Procedure Eq1erDegre;
Procedure Eq2emeDegre;
Function  RealStr(X:Real):String;
Function  RealStr2(X:Real;LenH,LenL:Byte):String;
Function  StrToReal(Const S:String):Real;
Procedure UserConversionFormula;
Function  ValExt(Var Ib:Byte;S:String;Var Lst:ArrayList):String;
Function  WWInit(Var Q;X1,Y1,X2,Y2:Byte):Boolean;
Function  WWRun(Var Q):Word;
Procedure WWRefresh(Var Q);
Function  WWTitle(Var Q;Max:Byte):String;
Procedure WWMove2(Var QX;X,Y:Byte);
Function  WWDone(Var Q):Word;
Function  _ValExt(Const S:String;Var Lst:ArrayList):String;
Function  __ValExt(Const S:String):String;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                             IMPLEMENTATION
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses
 Adele,Math,Memories,Systems,Video,Mouse,Dialex,Dials,ResTex,ResServD;

Const
 O:Array[0..10]of Char='^*/\%®¯+-ï|';
 Kc:Array[0..35]of Chr='789()%^AD'+
	               '456xö\®BE'+
		       '123-ûã¯CF'+
		       '0ñ.+ÍÍ©ïU';

Type
 FofX=Function(X:Real):Real;      { Besoin pour fonction d'‚valuation }

Function WEInpStr(Var Q:Window;Var Str:String):Word;Near;
Var
 PBuffer:Array[Byte]of Char;
 PC:PChr;
Begin
 StrPascalCopy(PBuffer,SizeOf(PBuffer),Str);
 PC:=@PBuffer;
 WEInpStr:=WEInp(Q,PC,SizeOf(String)-1,False);
 Str:=StrPas(PC);
End;

{Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä}
{                                  Radians                                  }
{Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä}

{**** Les fonctions Sin, Cos et ArcTan sont d‚j… pr‚d‚finie}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                              Fonction Tan                             Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction retourne la tangente d'un nombre radian. Elle retourne un
 nombre infinie dans les cas appropri‚e.
}

Function Tan(Radians:Real):Real;
Var
 CosineVal,TangentVal:Real;
Begin
 CosineVal:=Cos(Radians);
 If CosineVal=0.0Then Tan:=Infinity
  Else
 Begin
  TangentVal:=Sin(Radians)/CosineVal;
  If(TangentVal<-Infinity)Or(TangentVal>Infinity)Then Tan:=Infinity
                                                 Else Tan:=TangentVal;
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                             Fonction ArcSin                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de retourne l'arc sinuso‹dale d'un nombre radian.


 Remarques
 ÍÍÍÍÍÍÍÍÍ

  ş Les nombres exc‚dants les valeurs -1 et +1 cause un ®Runtime Error¯.
  ş Retourne seulement les nombres principales (-pi/2 … pi/2 en radians),
    (-90ø … +90ø).
}

Function ArcSin(InValue:Real):Real;Begin
 If Abs(InValue)=1.0Then ArcSin:=PI/2.0
                    Else ArcSin:=ArcTan(InValue/Sqrt(1-InValue*InValue));
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                             Fonction ArcCos                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de retourne l'arc cosinuso‹dale d'un nombre radian.


 Remarques
 ÍÍÍÍÍÍÍÍÍ

  ş Les nombres exc‚dants les valeurs -1 et +1 cause un ®Runtime Error¯.
  ş Retourne seulement les nombres principales (0 … pi en radians),
    (0ø … 180ø).
}

Function ArcCos(InValue:Real):Real;
Var
 Res:Real;
Begin
 If InValue=0.0Then ArcCos:=PI/2.0
  Else
 Begin
  If InValue=0.0Then Res:=0.0
                Else Res:=Arctan(Sqrt(1-InValue*InValue)/InValue);
  If InValue<0.0Then ArcCos:=Res+PI
                Else ArcCos:=Res;
 End;
End;

{Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä}
{                     Degr‚es, expression en nombre r‚el                    }
{Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä}

Function Degrees2Radians(Degrees:Real):Real;Begin
 Degrees2Radians:=Degrees*RadiansPerDegree;
End;

Function Radians2Degrees(Radians:Real):Real;Begin
 Radians2Degrees:=Radians*DegreesPerRadian;
End;

Function SinDegree(Degrees:Real):Real;Begin
 SinDegree:=Sin(Degrees2Radians(Degrees));
End;

Function CosDegree(Degrees:Real):Real;Begin
 CosDegree:=Cos(Degrees2Radians(Degrees));
End;

Function TanDegree(Degrees:Real):Real;Begin
 TanDegree:=Tan(Degrees2Radians(Degrees));
End;

Function ArcSinDegree(Degrees:Real):Real;Begin
 ArcSinDegree:=ArcSin(Degrees2Radians(Degrees));
End;

Function ArcCosDegree(Degrees:Real):Real;Begin
 ArcCosDegree:=ArcCos(Degrees2Radians(Degrees));
End;

Function ArcTanDegree(Degrees:Real):Real;Begin
 ArcTanDegree:=ArcTan(Degrees2Radians(Degrees));
End;

{Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä}
{        Degr‚es, dans Degr‚es, Minutes, et Seconds, en nombre r‚el         }
{Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä}

Function DegreeParts2Degrees(Degrees,Minutes,Seconds:Real):Real;Begin
 DegreeParts2Degrees:=Degrees+(Minutes/MinutesPerDegree)+(Seconds/SecondsPerDegree);
End;

Function DegreeParts2Radians(Degrees,Minutes,Seconds:Real):Real;Begin
 DegreeParts2Radians:=Degrees2Radians(DegreeParts2Degrees(Degrees,Minutes,Seconds));
End;

Procedure Degrees2DegreeParts(DegreesIn:Real;Var Degrees,Minutes,Seconds:Real);Begin
 Degrees:=System.Int(DegreesIn);
 Minutes:=(DegreesIn-Degrees)*MinutesPerDegree;
 Seconds:=Frac(Minutes);
 Minutes:=System.Int(Minutes);
 Seconds:=Seconds*SecondsPerMinute;
End;

Procedure Radians2DegreeParts(Radians:Real;Var Degrees,Minutes,Seconds:Real);Begin
 Degrees2DegreeParts(Radians2Degrees(Radians),Degrees,Minutes,Seconds);
End;

Function SinDegreeParts(Degrees,Minutes,Seconds:Real):Real;Begin
 SinDegreeParts:=Sin(DegreeParts2Radians(Degrees,Minutes,Seconds));
End;

Function CosDegreeParts(Degrees,Minutes,Seconds:Real):Real;Begin
 CosDegreeParts:=Cos(DegreeParts2Radians(Degrees,Minutes,Seconds));
End;

Function TanDegreeParts(Degrees,Minutes,Seconds:Real):Real;Begin
 TanDegreeParts:=Tan(DegreeParts2Radians(Degrees,Minutes,Seconds));
End;

Function ArcSinDegreeParts(Degrees,Minutes,Seconds:Real):Real;Begin
 ArcSinDegreeParts:=ArcSin(DegreeParts2Radians(Degrees,Minutes,Seconds));
End;

Function ArcCosDegreeParts(Degrees,Minutes,Seconds:Real):Real;Begin
 ArcCosDegreeParts:=ArcCos(DegreeParts2Radians(Degrees,Minutes,Seconds));
End;

Function ArcTanDegreeParts(Degrees,Minutes,Seconds:Real):Real;Begin
 ArcTanDegreeParts:=ArcTan(DegreeParts2Radians(Degrees,Minutes,Seconds));
End;

{Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä}
{  Degr‚es, expression dans DegreeType (Enregistrement avec nombres r‚els)  }
{Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä}

Function DegreeType2Degrees(DegreeVar:DegreeType):Real;Begin
 DegreeType2Degrees:=DegreeParts2Degrees(DegreeVar.Degrees,
                                         DegreeVar.Minutes,
				         DegreeVar.Seconds);
End;

Function DegreeType2Radians(DegreeVar:DegreeType):Real;Begin
 DegreeType2Radians:=Degrees2Radians(DegreeType2Degrees(DegreeVar));
End;

Procedure DegreeType2DegreeParts(DegreeVar:DegreeType;Var Degrees,Minutes,Seconds:Real);Begin
 Degrees:=DegreeVar.Degrees;
 Minutes:=DegreeVar.Minutes;
 Seconds:=DegreeVar.Seconds;
End;

Procedure Degrees2DegreeType(Degrees:Real;Var DegreeVar:DegreeType);Begin
 Degrees2DegreeParts(Degrees,DegreeVar.Degrees,DegreeVar.Minutes,DegreeVar.Seconds);
End;

Procedure Radians2DegreeType(Radians:Real;Var DegreeVar:DegreeType);Begin
 Degrees2DegreeParts(Radians2Degrees(Radians),DegreeVar.Degrees,
                     DegreeVar.Minutes,DegreeVar.Seconds);
End;

Procedure DegreeParts2DegreeType(Degrees,Minutes,Seconds:Real;
                                  Var DegreeVar:DegreeType);Begin
 DegreeVar.Degrees:=Degrees;
 DegreeVar.Minutes:=Minutes;
 DegreeVar.Seconds:=Seconds;
End;

Function SinDegreeType(DegreeVar:DegreeType):Real;Begin
 SinDegreeType:=Sin(DegreeType2Radians(DegreeVar));
End;

Function CosDegreeType(DegreeVar:DegreeType):Real;Begin
 CosDegreeType:=Cos(DegreeType2Radians(DegreeVar));
End;

Function TanDegreeType(DegreeVar:DegreeType):Real;Begin
 TanDegreeType:=Tan(DegreeType2Radians(DegreeVar));
End;

Function ArcSinDegreeType(DegreeVar:DegreeType):Real;Begin
 ArcSinDegreeType:=ArcSin(DegreeType2Radians(DegreeVar));
End;

Function ArcCosDegreeType(DegreeVar:DegreeType):Real;Begin
 ArcCosDegreeType:=ArcCos(DegreeType2Radians(DegreeVar));
End;

Function ArcTanDegreeType(DegreeVar:DegreeType):Real;Begin
 ArcTanDegreeType:=ArcTan(DegreeType2Radians(DegreeVar));
End;

{Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä}
{                           Fonctions Hyperboliques                         }
{Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä}

Function Sinh(Invalue:Real):Real;
Const
 MaxValue=88.029691931;  { ExcŠde la pr‚cision du Turbo Pascal standard }
Var
 Sign:Real;
Begin
 Sign:=1.0;
 If Invalue<0Then Begin
  Sign:=-1.0;
  Invalue:=-Invalue;
 End;
 If(Invalue>MaxValue)Then Sinh:=Infinity
                     Else Sinh:=(Exp(Invalue)-Exp(-Invalue))/2.0*Sign;
End;

Function Cosh(Invalue:Real):Real;
Const
 MaxValue=88.029691931;  { ExcŠs la pr‚cision du Turbo Pascal standard }
Begin
 Invalue:=Abs(Invalue);
 If(Invalue>MaxValue)Then Cosh:=Infinity
                     Else Cosh:=(Exp(Invalue)+Exp(-Invalue))/2.0;
End;

Function Tanh(Invalue:Real):Real;Begin
 Tanh:=Sinh(Invalue)/Cosh(Invalue);
End;

Function Coth(Invalue:Real):Real;Begin
 If Invalue=0.0Then Coth:=0.0
               Else Coth:=Cosh(Invalue)/Sinh(Invalue);
End;

Function Sech(Invalue:Real):Real;Begin
 Sech:=1.0/Cosh(Invalue);
End;

Function Csch(Invalue:Real):Real;Begin
 Csch:=1.0/Sinh(Invalue);
End;

Function ArcSinh(Invalue:Real):Real;
Var
 Sign:Real;
Begin
 Sign:=1.0;
 If Invalue<0Then Begin
  Sign:=-1.0;
  Invalue:=-Invalue;
 End;
 ArcSinh:=Ln(Invalue+Sqrt(Invalue*Invalue+1))*Sign;
End;

Function ArcCosh(Invalue:Real):Real;
Var
 Sign:Real;
Begin
 If Invalue=0.0Then Begin
  ArcCosh:=0.0;
  Exit;
 End;
 Sign:=1.0;
 If Invalue<0Then Begin
  Sign:=-1.0;
  Invalue:=-Invalue;
 End;
 ArcCosh:=Ln(Invalue+Sqrt(Invalue*Invalue-1))*Sign;
End;

Function ArcTanh(Invalue:Real):Real;
Var
 Sign:Real;
Begin
 Sign:=1.0;
 If Invalue<0Then Begin
  Sign:=-1.0;
  Invalue:=-Invalue;
 End;
 If InValue=1.0Then ArcTanH:=0.0
 Else ArcTanh:=Ln((1+Invalue)/(1-Invalue))/2.0*Sign;
End;

Function ArcCoth(Invalue:Real):Real;Begin
 If InValue=0.0Then ArcCoth:=0.0
 Else ArcCoth:=ArcTanh(1.0/Invalue);
End;

Function ArcSech(Invalue:Real):Real;Begin
 ArcSech:=ArcCosh(1.0/Invalue);
End;

Function ArcCsch(Invalue:Real):Real;Begin
 ArcCsch:=ArcSinh(1.0/Invalue);
End;

{Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä}
{                Fonctions Logarithmiques, Puissances et Racines            }
{Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä}

{ ®e¯ … la ®x¯ c'est la fonction ®Exp¯ }
{ Le logarithme naturel c'est la fonction ®ln¯ }

Function Log10(InNumber:Real):Real;Begin
 Log10:=Ln(InNumber)/LnOf10;
End;

{ Cette fonction retourne le logarithme de n'importe quel base.
}

Function Log(Base,InNumber:Real):Real;Begin
 Log:=Ln(InNumber)/Ln(Base);
End;

Function Root(InNumber,TheRoot:Real):Real;Begin
 Root:=Power(InNumber,(1.0/TheRoot));
End;

{Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä}
{               Fonctions de calculs int‚gral et diff‚rentiel               }
{Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Fonction Integral                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  La fonction int‚grales de A et B, c'est approximativement une fonction
 avec un rectangle de hauteur ®H¯.  La r‚ponse est la somme  des r‚gions
 rectangulaires,  chaque r‚gion ‚tant ®H x Y(X)¯. ®X¯ est un fragment de
 rectangle.
}

Function Integral(A,B,H:Real;F:Pointer):Real;
Var
 X,Summation:Real;
 Y:FofX;
Begin
 @Y:=F;Summation:=0;X:=a+h/2;
 While(x<b)do Begin
  Summation:=Summation+H*Y(X);
  X:=X+H;
 End;
 Integral:=Summation;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Fonction Derivative                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  La fonction d‚riv‚e de X c'est le delta Y sur delta X. Vous remplacez le
 X et le delta de X.
}

Function Derivative(X,Dx:Real;F:Pointer):Real;
Var
 Y:FofX;
Begin
 @Y:=F;
 Derivative:=(Y(X+Dx/2)-Y(X-Dx/2))/Dx;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Fonction Extremum                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction recherchant les extrˆmes invent‚e par ®DuChez¯: Prendre
 trois points, trouver la parabole la reliant et  recherche l'extrˆme de
 la fonction ‚tant le plus court vortex de la parabole.  Si ce n'est pas
 le cas, vous avez un nouveau ®X¯ … essayer...
}

Function Extremum(X,Dx,Tolerance:Real;F:Pointer):Real;
Var
 Y:FofX;
 GotAnswer,Increasing,Decreasing:Boolean;
 OldX:Real;
 Itercnt:Word;
Begin
 @Y:=F;GotAnswer:=False;Increasing:=False;Decreasing:=False;Itercnt:=1;
 Repeat
  OldX:=X;
  X:=OldX-Dx*(Y(X+Dx)-Y(X-Dx))/(2*(Y(X+Dx)-2*Y(X)+Y(X-Dx)));
  If(Abs(X-OldX)<=Tolerance)Then GotAnswer:=True Else
  If(X>Oldx)Then Begin
   If(Decreasing)Then Begin;Decreasing:=False;Dx:=Dx/2;End;
   Increasing:=True;
  End
   Else
  If(X<OldX)Then Begin
   If(Increasing)Then Begin;Increasing:=False;Dx:=Dx/2;End;
   Decreasing:=True;
  End;
 Until GotAnswer;
 Extremum:=(X+OldX)/2;
End;

{Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä}
{                 Calcul des p‚rimŠtres, aires et des volumes               }
{Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                 Fonction TriangleArea               Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de calculer l'air d'un triangle.
}

Function TriangleArea(B,H:Real):Real;Begin
 TriangleArea:=0.5*B*H;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                    Fonction EquilateralTriangleArea             Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de calculer l'air d'un triangle ‚quilat‚ral.
}

Function EquilateralTriangleArea(S:Real):Real;Begin
 EquilateralTriangleArea:=(SQRT(3)*(S*S))/4;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                 Fonction CircleArea               Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de calculer l'air d'un cercle.
}

Function CircleArea(R:Real):Real;Begin
 CircleArea:=Pi*(R*R);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                 Fonction EllipseArea               Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de calculer l'air d'un ‚llipse.
}

Function EllipseArea(A,B:Real):Real;Begin
 EllipseArea:=Pi*A*B;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                Fonction SquareArea               Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de calculer l'air d'un carr‚.
}

Function SquareArea(S:Real):Real;Begin
 SquareArea:=S*S;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                 Fonction RectangleArea               Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de calculer l'air d'un rectangle.
}

Function RectangleArea(X,Y:Real):Real;Begin
 RectangleArea:=X*Y;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Fonction CubeSurfaceArea                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de calculer l'air de la surface d'un cube (seulement
 c'est 6 faces et non pas son int‚rieur).
}

Function CubeSurfaceArea(S:Real):Real;Begin
 CubeSurfaceArea:=6*S*S;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                 Fonction RectangularPrismSurfaceArea           Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de calculer l'air de la surface d'un prisme
 rectangulaire.
}

Function RectangularPrismSurfaceArea(H,W,L:Real):Real;Begin
 RectangularPrismSurfaceArea:=(2*H*W)+(2*H*L)+(2*L*W);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                     Fonction SphereSurfaceArea                    Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de calculer l'aire de la surface d'une sphŠre.
}

Function SphereSurfaceArea(R:Real):Real;Begin
 SphereSurfaceArea:=4*Pi*(R*R);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                     Fonction CylinderSurfaceArea                  Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de calculer l'air de la surface d'un cylindre.
}

Function CylinderSurfaceArea(R,H:Real):Real;Begin
 CylinderSurfaceArea:=(2*Pi*R*H)+(2*Pi*(R*R));
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                  Fonction ConeSurfaceAreaWithoutBase              Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de calculer l'air de la surface d'un c“ne sans
 toutefois la base.
}

Function ConeSurfaceAreaWithoutBase(R,H:Real):Real;Begin
 ConeSurfaceAreaWithoutBase:=Pi*R*SQRT((R*R)+(H*H));
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                  Fonction ConeSurfaceAreaWithBase                 Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de calculer l'air de la surface d'un c“ne avec
 sa base.
}

Function ConeSurfaceAreaWithBase(R,H:Real):Real;Begin
 ConeSurfaceAreaWithBase:=(Pi*R*SQRT((R*R)+(H*H)))+(Pi*(R*R));
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                  Fonction SectorArea               Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de calculer l'air d'un secteur.
}

Function SectorArea(R,A:Real):Real;Begin
 SectorArea:=0.5*(R*R)*A;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                  Fonction TrapezoidArea            Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de calculer l'air d'un trapŠze.
}

Function TrapezoidArea(A,B,H:Real):Real;Begin
 TrapezoidArea:=(H/2)*(A+B);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                    Fonction CircleCircumference              Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de calculer la circonf‚rence d'un cercle.
}

Function CircleCircumference(R:Real):Real;Begin
 CircleCircumference:=2*Pi*R;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                    Fonction EllipseCircumference               Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de calculer la circonf‚rence d'une ‚llipse.
}

Function EllipseCircumference(A,B:Real):Real;Begin
 EllipseCircumference:=(2*Pi)*(SQRT(((A*A)+(B*B))/2));
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                    Fonction CubeVolume              Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de calculer le volume d'un cube.
}

Function CubeVolume(S:Real):Real;Begin
 CubeVolume:=S*S*S;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                    Fonction RectangleVolume              Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de calculer le volume d'un rectangle.
}

Function RectangleVolume(X,Y,Z:Real):Real;Begin
 RectangleVolume:=X*Y*Z;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                   Fonction SphereVolume                Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de calculer le volume d'une sphŠre.
}

Function SphereVolume(R:Real):Real;Begin
 SphereVolume:=(4/3)*Pi*(R*R*R);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                   Fonction CylinderVolume               Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de calculer le volume d'un cylindre.
}

Function CylinderVolume(R,H:Real):Real;Begin
 CylinderVolume:=Pi*(R*R)*H;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                      Fonction ConeVolume                Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de calculer le volume d'un c“ne.
}

Function ConeVolume(R,H:Real):Real;Begin
 ConeVolume:=(Pi*(R*R)*H)/3;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                    Fonction PrismVolume               Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de calculer le volume d'un prisme.
}

Function PrismVolume(B,H:Real):Real;Begin
 PrismVolume:=B*H;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Fonction Distance                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de calculer une distance en deux couples.
}

Function Distance(X1,X2,Y1,Y2:Real):Real;Begin
 Distance:=Sqrt(Sqr(Y2-Y1)+Sqr(X2-X1));
End;

{Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä}
{                             Fonctions Divers                              }
{Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                             Fonction Prime                           Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction indique s'il s'agit d'un nombre naturel sp‚cifier est un
 nombre premier (True) ou non (False).
}

Function Prime(N:Word):Boolean;
Var
 I:Word;
Begin
 If N=1Then Prime:=False Else
 If N=2Then Prime:=True
  Else
 Begin { N > 2 }
  Prime:=True; {Recherche}
  For I:=2 to N-1do If N mod I=0Then Prime:=False;
 End;
End;

{Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä}
{                           Formule de Statistiques                         }
{Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Fonction Factorial                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de retourner le factoriel d'un nombre entier.
}

Function Factorial(Num:Integer):Real;
Var
 I:Integer;
 Total:Real;
Begin
 Total:=1;
 For I:=2to(Num)do Total:=Total*I;
 Factorial:=Total;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                             Fonction P                           Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de retourner la permutation d'un nombre entier.
 Comme par exemple  pour savoir  combien de chance  a-t-on de trouver 5
 carte dans un main dans un total de 52 cartes … jouer.
}

Function P(N,R:Integer):Real;Begin
 P:=Factorial(N)/Factorial(N-R);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                             Fonction C                           Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de retourner la combinaison d'un nombre entier.
}

Function C(N,R:Integer):Real;Begin
 C:=Factorial(N)/(Factorial(N-R)*Factorial(R));
End;

{Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä}
{                          Conversion de temp‚rature                        }
{Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                             Fonction Fahr2Cent                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de convertir la temp‚rature fahrenheit … Celcius.
}

Function Fahr2Cent(FahrTemp:Real):Real;Begin
 Fahr2Cent:=(FahrTemp+40.0)*(5.0/9.0)-40.0;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Fonction Cent2Fahr                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de convertir la temp‚rature Celcius … Fahrenheit
 (Cø … Fø).
}

Function Cent2Fahr(CentTemp:Real):Real;Begin
 Cent2Fahr:=(CentTemp+40.0)*(9.0/5.0)-40.0;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Fonction Kelv2Fahr                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de convertir la temp‚rature Kelvin … Celcius
 (Kø … Cø).
}

Function Kelv2Cent(KelvTemp:Real):Real;Begin
 Kelv2Cent:=KelvTemp-273.16;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Fonction Cent2Kelv                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de convertir la temp‚rature Celcius … Kelvin
 (Cø … Kø).
}

Function Cent2Kelv(CentTemp:Real):Real;Begin
 Cent2Kelv:=CentTemp+273.16;
End;

{Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä}
{                         Mesure de conversion lin‚aire                     }
{Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Proc‚dure Inch2FtIn                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de convertir la mesure de distance de pouce …
 pied.
}

Procedure Inch2FtIn(Inches:Real;Var ft,ins:Real);Begin
 ft:=System.Int(Inches/12.0);
 ins:=Inches-ft*12.0;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Fonction FtIn2Inch                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de convertir la mesure de distance de pied …
 pouce.
}

Function FtIn2Inch(ft,ins:Real):Real;Begin
 FtIn2Inch:=ft*12.0+ins;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Fonction Inch2Yard                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de convertir la mesure de distance de pouce …
 une verge.
}

Function Inch2Yard(Inches:Real):Real;Begin
 Inch2Yard:=Inches/36.0;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Fonction Yard2Inch                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de convertir la mesure de distance de verge …
 aux pouces.
}

Function Yard2Inch(Yards:Real):Real;Begin
 Yard2Inch:=Yards*36.0;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Fonction Inch2Mile                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de convertir la mesure de distance de pouce aux
 miles.
}

Function Inch2Mile(Inches:Real):Real;Begin
 Inch2Mile:=Inches/63360.0;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Fonction Mile2Inch                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de convertir la mesure de distance de miles aux
 pouces.
}

Function Mile2Inch(Miles:Real):Real;Begin
 Mile2Inch:=Miles*63360.0;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Fonction Inch2NautMile                    Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de convertir la mesure de distance de pouces …
 miles nautique.
}

Function Inch2NautMile(Inches:Real):Real;Begin
 Inch2NautMile:=Inches/72960.0;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                      Fonction NautMile2Inch                    Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de convertir la mesure de distance de miles
 nautique … pouces.
}

Function NautMile2Inch(NautMiles:Real):Real;Begin
 NautMile2Inch:=NautMiles*72960.0;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                     Fonction Inch2Meter                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de convertir la mesure de pouce … mŠtre.
}

Function Inch2Meter(Inches:Real):Real;Begin
 Inch2Meter:=Inches*0.0254;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                     Fonction Meter2Inch                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de convertir la mesure de mŠtre … pouce.
}

Function Meter2Inch(Meters:Real):Real;Begin
 Meter2Inch:=Meters/0.0254;
End;

{Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä}
{                             Conversion de r‚gion                          }
{Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                     Fonction SqInch2SqFeet                   Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de convertir la mesure de pouceı … piedı.
}

Function SqInch2SqFeet(SqInches:Real):Real;Begin
 SqInch2SqFeet:=SqInches/144.0;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                     Fonction SqFeet2SqInch                   Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de convertir la mesure de piedı … pouceı.
}

Function SqFeet2SqInch(SqFeet:Real):Real;Begin
 SqFeet2SqInch:=SqFeet*144.0;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                      Fonction SqInch2SqYard                   Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de convertir la mesure de pouceı … vergeı.
}

Function SqInch2SqYard(SqInches:Real):Real;Begin
 SqInch2SqYard:=SqInches/1296.0;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                      Fonction SqYard2SqInch                   Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de convertir la mesure de vergeı … pouceı.
}

Function SqYard2SqInch(SqYards:Real):Real;Begin
 SqYard2SqInch:=SqYards*1296.0;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                      Fonction SqInch2SqMile                   Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de convertir la mesure de pouceı … mileı.
}

Function SqInch2SqMile(SqInches:Real):Real;Begin
 SqInch2SqMile:=SqInches/4.0144896E9;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                     Fonction SqMile2SqInch                   Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de convertir la mesure de mileı … pouceı.
}

Function SqMile2SqInch(SqMiles:Real):Real;Begin
 SqMile2SqInch:=SqMiles*4.0144896E9;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                    Fonction SqInch2SqAcre                   Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de convertir la mesure de pouceı … acre.
}

Function SqInch2Acre(SqInches:Real):Real;Begin
 SqInch2Acre:=SqInches/6272640.0;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                    Fonction Acre2SqInch                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de convertir la mesure de acre … pouceı.
}

Function Acre2SqInch(Acres:Real):Real;Begin
 Acre2SqInch:=Acres*6272640.0;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                      Fonction SqInch2SqMeter                  Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de convertir la mesure de pouceı … mŠtreı.
}

Function SqInch2SqMeter(SqInches:Real):Real;Begin
 SqInch2SqMeter:=SqInches/1550.016;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                      Fonction SqMeter2SqInch                  Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de convertir la mesure de mŠtreı … pouceı.
}

Function SqMeter2SqInch(SqMeters:Real):Real;Begin
 SqMeter2SqInch:=SqMeters*1550.016;
End;

{Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä}
{                             Conversion de volume                          }
{Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                    Fonction CuInch2CuFeet                   Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de convertir la mesure de pouce cube aux
 pieds cube.
}

Function CuInch2CuFeet(CuInches:Real):Real;Begin
 CuInch2CuFeet:=CuInches/1728.0;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                    Fonction CuFeet2CuInch                  Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de convertir la mesure de pied cube aux
 pouces cube.
}

Function CuFeet2CuInch(CuFeet:Real):Real;Begin
 CuFeet2CuInch:=CuFeet*1728.0;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Fonction CuInch2CuYard                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de convertir la mesure de pouces cube aux verges
 cube.
}

Function CuInch2CuYard(CuInches:Real):Real;Begin
 CuInch2CuYard:=CuInches/46656.0;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Fonction CuYard2CuInch                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de convertir la mesure de verges cube aux pouces
 cube.
}

Function CuYard2CuInch(CuYards:Real):Real;Begin
 CuYard2CuInch:=CuYards*46656.0;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Fonction CuInch2CuMeter                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de convertir la mesure de pouces cube aux mŠtres
 cube.
}

Function CuInch2CuMeter(CuInches:Real):Real;Begin
 CuInch2CuMeter:=CuInches/61022.592;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Fonction CuMeter2CuInch                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de convertir la mesure de mŠtres cube aux pouces
 cube.
}

Function CuMeter2CuInch(CuMeters:Real):Real;Begin
 CuMeter2CuInch:=CuMeters*61022.592;
End;

{Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä}
{                          Mesure de conversion liquide                     }
{Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Fonction FluidOz2Pint                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de convertir la mesure de oz liquide … pinte.
}

Function FluidOz2Pint(FluidOz:Real):Real;Begin
 FluidOz2Pint:=FluidOz/16.0;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Fonction Pint2FluidOz                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de convertir la mesure de pinte … oz liquide.
}

Function Pint2FluidOz(Pints:Real):Real;Begin
 Pint2FluidOz:=Pints*16.0;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                      Fonction FluidOz2ImpPint                   Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de convertir la mesure de liquide oz … pinte
 imp‚rial.
}

Function FluidOz2ImpPint(FluidOz:Real):Real;Begin
 FluidOz2ImpPint:=FluidOz/20.0;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                     Fonction ImpPint2FluidOz                  Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de convertir la mesure de pinte imp‚rial …
 liquide oz.
}

Function ImpPint2FluidOz(ImpPints:Real):Real;Begin
 ImpPint2FluidOz:=ImpPints*20.0;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Fonction FluidOz2Gals                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de convertir la mesure de oz liquide … gallons.
}

Function FluidOz2Gals(FluidOz:Real):Real;Begin
 FluidOz2Gals:=FluidOz/128.0;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Fonction Gals2FluidOz                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de convertir la mesure de gallons … oz liquide.
}

Function Gals2FluidOz(Gals:Real):Real;Begin
 Gals2FluidOz:=Gals*128.0;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Fonction FluidOz2ImpGals                   Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de convertir la mesure de oz liquide … gallons.
}

Function FluidOz2ImpGals(FluidOz:Real):Real;Begin
 FluidOz2ImpGals:=FluidOz/160.0;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Fonction ImpGals2FluidOz                   Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de convertir la mesure de gallons … oz liquide.
}

Function ImpGals2FluidOz(ImpGals:Real):Real;Begin
 ImpGals2FluidOz:=ImpGals*160.0;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Fonction FluidOz2CuMeter                   Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de convertir la mesure de oz liquide … gallons.
}

Function FluidOz2CuMeter(FluidOz:Real):Real;Begin
 FluidOz2CuMeter:=FluidOz/33820.0;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Fonction CuMeter2FluidOz                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de convertir la mesure de mŠtre cube … oz liquide.
}

Function CuMeter2FluidOz(CuMeters:Real):Real;Begin
 CuMeter2FluidOz:=CuMeters*33820.0;
End;

{Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä}
{                            Conversion de poids                            }
{Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Fonction Ounce2LbOz                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de convertir la mesure de poids d'once … oz Lb.
}

Procedure Ounce2LbOz(Ounces:Real;Var lb,oz:Real);Begin
 lb:=System.Int(Ounces/16.0);
 oz:=Ounces-lb*16.0;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Fonction LbOz2Ounce                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de convertir la mesure de poids d'oz Lb … once.
}

Function LbOz2Ounce(lb,oz:Real):Real;Begin
 LbOz2Ounce:=lb*16.0+oz;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Fonction Ounce2Ton                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de convertir la mesure de poids d'once … tonne
 courte (tonne normal, par d‚faut,...).
}

Function Ounce2Ton(Ounces:Real):Real;Begin
 Ounce2Ton:=Ounces/32000.0;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Fonction Ton2Ounce                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de convertir la mesure de poids de tonne courte
 (tonne normal, par d‚faut,...) … once.
}

Function Ton2Ounce(Tons:Real):Real;Begin
 Ton2Ounce:=Tons*32000.0;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Fonction Ounce2LongTon                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de convertir la mesure de poids de onze … tonne
 forte.
}

Function Ounce2LongTon(Ounces:Real):Real;Begin
 Ounce2LongTon:=Ounces/35840.0;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Fonction LongTon2Ounce                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de convertir la mesure de poids de tonne forte …
 onze.
}

Function LongTon2Ounce(LongTons:Real):Real;Begin
 LongTon2Ounce:=LongTons*35840.0;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Fonction Ounce2Gram                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de convertir la mesure de poids once … gramme.
}

Function Ounce2Gram(Ounces:Real):Real;Begin
 Ounce2Gram:=Ounces*28.35;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Fonction Gram2Ounce                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de convertir la mesure de poids gramme … once.
}

Function Gram2Ounce(Grams:Real):Real;Begin
 Gram2Ounce:=Grams/28.35;
End;

{Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä}
{                           R‚solution de problŠme                          }
{Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä Ä}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Fonction RealStr                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction retourne  une valeur num‚rique  r‚el indiquer par la
 variable de param‚trage ®X¯ … l'int‚rieur d'une chaŒne de caractŠre.


 Remarques
 ÍÍÍÍÍÍÍÍÍ

  ş Cette  fonction  ne retourne  pas les nombres d‚cimal  et si vous
    souhaitez  vraiment  qu'ils les  retournent,  faite  appelle … la
    fonction ®RealStr2¯.

  ş Cette fonction fait appelle la fonction ®Str¯ de l'unit‚ ®System¯.

}

Function RealStr;
Var
 S:String;
Begin
 System.Str(X,S);
 RealStr:=S;
End;

Function StrToReal(Const S:String):Real;
Var
 R:Real;
 Err:Integer;
Begin
 Val(S,R,Err);
 StrToReal:=R;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Fonction RealStr2                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction retourne  une valeur num‚rique  r‚el indiquer par la
 variable de param‚trage ®X¯ … l'int‚rieur d'une chaŒne de caractŠre.


 Remarques
 ÍÍÍÍÍÍÍÍÍ

  ş Cette  fonction ne  retourne les  nombres  d‚cimal  et si vous ne
    souhaitez pas vraiment qu'ils les retournent,  faite appelle … la
    fonction ®RealStr¯.

  ş Cette fonction fait appelle la fonction ®Str¯ de l'unit‚ ®System¯.

}

Function RealStr2;
Var
 S:String;
Begin
 System.Str(X:LenH:LenL,S);
 RealStr2:=S;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                              Fonction ValExt                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de r‚soudre une formule math‚matique contenu dans
 une chaŒne de caractŠres  en tenant  compte de variable contenu dans une
 liste  et  d'une  position pr‚d‚finie  dans la chaŒne de caractŠres.  La
 compr‚hension s'effectue … partir d'une position particuliŠre.
}

Function VEOnWord(Var Obj;Const ThisWord:String;Var Context):Boolean;Forward;

Function GetStr(Var S:String;Var I:Byte;Var Lst:ArrayList;All:Boolean):String;
Label Break4,BreakUntil;
Var
 a,b,L:Word;
 LErr,bErr:Integer;
 J:Word;
 T,Num,Word:String;
 Ok,NotFirst:Boolean;
 OI,Ik:Byte;

 Function IfChrInc(Cmp:Char):Boolean;Begin
  If Cmp=StrI(I,S)Then Begin
   Inc(I);
   IfChrInc:=True;
  End
   Else
  IfChrInc:=False;
 End;

 Function IsSN(Cmp:Char):Boolean;Begin
  SkipSpcInLn(I,S);
  If IfChrInc(Cmp)Then IsSN:=True
   Else
  Begin
   ASM MOV GetSysErr,ErrSN;END;
   IsSN:=False;
  End;
 End;

 Function IfChrIncNNm(Cmp:Char):Boolean;Begin
  IfChrIncNNm:=False;
  If IfChrInc(Cmp)Then Begin
   IncStr(Num,Cmp);
   IfChrIncNNm:=True;
  End;
 End;

 Function IsEmptyFC(Const S:String):Boolean;Begin
  If S=''Then Begin
   ASM MOV GetSysErr,ErrFC;END;
   IsEmptyFC:=True;
  End
   Else
  IsEmptyFC:=False;
 End;

Begin
 GetStr:='';
 Word:='';
 NotFirst:=False;
 Repeat
  If(NotFirst)Then Begin
   IfChrInc('+');
   SkipSpcInLn(I,S)
  End;
  Case StrI(I,S)of
   '"':Begin
    Inc(I,Length('"'));
    While Not(StrI(I,S)in[#0,'"'])do Begin
     IncStr(Word,S[I]);
     Inc(I)
    End;
    IfChrInc('"');
   End;
   'A'..'Z':Begin
    OI:=I;T:=XtrkWord(I,S);
    Case StrI(I,S)of
     '$':Begin
      Inc(I);IncStr(T,'$');Ik:=0;
      If T='STR$'Then Ik:=1 Else
      If T='RIGHT$'Then Ik:=2 Else
      If T='HEX$'Then Ik:=3 Else
      If T='CHR$'Then Ik:=4;
      If Ik>0Then Begin
       If Not IsSN('(')Then Exit;
       If Ik<=2Then SkipSpcInLn(I,S);
       If Ik in[1,3,4]Then Num:=ValExt(I,S,Lst);
      End;
      Case Ik of
       1:AddStr(Word,Num);
       2:Begin
	T:=GetStr(S,I,Lst,False);
	If Not IsSN(',')Then Exit;
	SkipSpcInLn(I,S);
	Num:=ValExt(I,S,Lst);
	Val(Num,a,LErr);
        AddStr(Word,Copy(T,Length(T)-a+1,a));
       End;
       3:Begin
	If IsEmptyFC(Num)Then Exit;
	Val(Num,L,bErr);
	If L>$FFFFThen AddStr(Word,HexLong2Str(L))Else
	If L>$FFThen AddStr(Word,HexWord2Str(L))
                Else AddStr(Word,HexByte2Str(L));
       End;
       4:Begin
	If IsEmptyFC(Num)Then Exit;
	Val(Num,a,bErr);
        IncStr(Word,Char(a));
       End;
       Else If Lst.Count>0Then For J:=0to Lst.Count-1do Begin
	Num:=StrPas(_ALGetBuf(Lst,J));
	If CmpLeft(Num,T+':')Then Begin
	 AddStr(Word,Copy(Num,Length(T)+2,255));
	 Goto Break4;
	End;
       End;
      End;
      If Ik in[1..4]Then If Not IsSN(')')Then Exit;
Break4:
     End;
     Else
     Begin
      I:=OI;
      AddStr(Word,ValExt(I,S,Lst));
      Goto BreakUntil;
     End;
    End;
   End;
   '-','(','0'..'9','.':
   If(All)Then Begin
    AddStr(Word,ValExt(I,S,Lst));
    Goto BreakUntil;
   End
    Else
   Begin
    ASM
     MOV GetSysErr,ErrTM
    END;
    Exit;
   End;
   Else
   Begin
    ASM
     MOV GetSysErr,ErrSN
    END;
    Exit;
   End;
  End;
  SkipSpcInLn(I,S);
  NotFirst:=True;
 Until StrI(I,S)<>'+';
BreakUntil:
 GetStr:=Word;
End;

Function VEOnSymbol(Var Obj;Symbol:Char;Var Context):Boolean;
Var
 Q:FormulaObject Absolute Obj;
 Lst:ArrayList Absolute Context;
 TF:FormulaObject;
 Cx,Cx2:Char;
Begin
 VEOnSymbol:=False;
 Case(Symbol)of
  'ã':Begin
   Inc(Q.I);
   FOPushNumberReal(Q,PI)
  End;
  '[','³':Begin
   Cx:=StrI(Q.I,Q.Formula);
   Inc(Q.I);
   FOInit(TF);
   TF.StopChar:=[']','³'];
   TF.OnWord:=VEOnWord;
   TF.OnSymbol:=VEOnSymbol;
   Q.Context:=@Lst;
   TF.I:=Q.I;
   FOCompute(TF,Q.Formula);
   Q.I:=TF.I;
   Case(Cx)of
    '[':Begin
     FOPushNumberLong(Q,VariantToInt(TF.Result));
     Cx2:=']';
    End;
    '³':Begin
     If(TF.Result.TypeDef=dtReal)Then
      FOPushNumberReal(Q,System.Abs(TF.Result.X.DataReal))
     Else
      FOPushNumberLong(Q,Abs(TF.Result.X.DataLong));
     Cx2:='³';
    End;
   End;
   SkipSpcInLn(Q.I,Q.Formula);
   If(StrI(Q.I,Q.Formula)<>Cx2)Then Begin
    ASM
     MOV GetSysErr,ErrSN
    END;
    Exit;
   End;
   Inc(Q.I);
  End;
  Else Exit;
 End;
 VEOnSymbol:=True;
End;

Function VEOnWord(Var Obj;Const ThisWord:String;Var Context):Boolean;
Label Finish;
Var
 Q:FormulaObject Absolute Obj;
 Lst:ArrayList Absolute Context;
 TF:FormulaObject;
 Num:String;
 Func:Byte;
 J:Integer;
Begin
 VEOnWord:=False;
 Func:=0;
 If ThisWord='ABS'Then Func:=1 Else
 If ThisWord='ASC'Then Func:=2 Else
 If ThisWord='ATN'Then Func:=3 Else
 If ThisWord='COS'Then Func:=4 Else
 If ThisWord='INT'Then Func:=5 Else
{$IFDEF Joystick}If ThisWord='JOYSTK'Then Func:=6 Else{$ENDIF}
 If ThisWord='LEN'Then Func:=7 Else
 If ThisWord='LOG'Then Func:=8 Else
 If ThisWord='RND'Then Func:=9 Else
 If ThisWord='SGN'Then Func:=10 Else
 If ThisWord='SIN'Then Func:=11 Else
 If ThisWord='SQR'Then Func:=12 Else
 If ThisWord='TAN'Then Func:=13 Else
 If ThisWord='VAL'Then Func:=14;
 If Func>0Then Begin
  SkipSpcInLn(Q.I,Q.Formula);
  If StrI(Q.I,Q.Formula)<>'('Then Exit;
  Inc(Q.I);
  If(Func)in[1,3..6,8..13]Then Begin
   FOInit(TF);
   TF.OnWord:=VEOnWord;
   TF.OnSymbol:=VEOnSymbol;
   Q.Context:=@Lst;
   TF.I:=Q.I;
   FOCompute(TF,Q.Formula);
   Q.I:=TF.I;
   If StrI(Q.I,Q.Formula)<>')'Then Exit;
   Inc(Q.I);
  End;
 End;
 Case(Func)of
  1:Begin
   Case(TF.Result.TypeDef)of
    dtLong:TF.Result.X.DataLong:=Abs(TF.Result.X.DataLong);
    Else TF.Result.X.DataReal:=Abs(VariantToReal(TF.Result));
   End;
  End;
  2:Begin
   SkipSpcInLn(Q.I,Q.Formula);
   Num:=GetStr(Q.Formula,Q.I,Lst,False);
   TF.Result.TypeDef:=dtLong;
   TF.Result.X.DataLong:=Byte(StrI(1,Num));
   If StrI(Q.I,Q.Formula)<>')'Then Exit;
   Inc(Q.I);
  End;
  3:Begin
   TF.Result.X.DataReal:=ArcTan(VariantToReal(TF.Result));
   TF.Result.TypeDef:=dtReal;
  End;
  4:Begin
   TF.Result.X.DataReal:=Cos(VariantToReal(TF.Result));
   TF.Result.TypeDef:=dtReal;
  End;
  5:Begin
   TF.Result.X.DataLong:=VariantToInt(TF.Result);
   TF.Result.TypeDef:=dtLong;
  End;
  6:Begin
   {$IFDEF Joystick}
    If Not(TF.Result.X.DataLong in[0..3])Then Begin
     ASM
      MOV GetSysErr,ErrDN
     END;
     Exit;
    End;
    TF.Result.X.DataLong:=JoyPos(TF.Result.X.DataLong);
    TF.Result.TypeDef:=dtLong;
   {$ENDIF}
  End;
  7:Begin
   TF.Result.TypeDef:=dtLong;
   TF.Result.X.DataLong:=Length(GetStr(Q.Formula,Q.I,Lst,False));
   If StrI(Q.I,Q.Formula)<>')'Then Exit;
   Inc(Q.I);
  End;
  8:Begin
   TF.Result.X.DataReal:=Ln(VariantToReal(TF.Result));
   TF.Result.TypeDef:=dtReal;
  End;
  9:Begin
   TF.Result.X.DataLong:=Random(VariantToInt(TF.Result));
   TF.Result.TypeDef:=dtLong;
  End;
  10:Case(TF.Result.TypeDef)of
   dtLong:Begin
    If TF.Result.X.DataLong<0Then TF.Result.X.DataLong:=-1 Else
    If TF.Result.X.DataLong=0Then TF.Result.X.DataLong:=0
                             Else TF.Result.X.DataLong:=1
   End;
   Else Begin
    TF.Result.TypeDef:=dtLong;
    If TF.Result.X.DataReal<0.0Then TF.Result.X.DataLong:=-1 Else
    If TF.Result.X.DataReal=0.0Then TF.Result.X.DataLong:=0
                               Else TF.Result.X.DataLong:=1
   End;
  End;
  11:Begin
   TF.Result.X.DataReal:=Sin(VariantToReal(TF.Result));
   TF.Result.TypeDef:=dtReal;
  End;
  12:Begin
   TF.Result.X.DataReal:=Sqr(VariantToReal(TF.Result));
   TF.Result.TypeDef:=dtReal;
  End;
  13:Begin
   TF.Result.X.DataReal:=Tan(VariantToReal(TF.Result));
   TF.Result.TypeDef:=dtReal;
  End;
  14:Begin
   Num:=GetStr(Q.Formula,Q.I,Lst,False);
   TF.Result.X.DataLong:=StrToInt(Num);
   If(Pos('.',Num)>0)or(TF.Result.X.DataLong=0)Then Begin
    Val(Num,TF.Result.X.DataReal,J);
    TF.Result.TypeDef:=dtReal;
   End
    Else
   TF.Result.TypeDef:=dtLong;
   If StrI(Q.I,Q.Formula)<>')'Then Exit;
   Inc(Q.I);
  End;
  Else If Lst.Count>0Then Begin
   For J:=0to Lst.Count-1do Begin
    Num:=StrPas(_ALGetBuf(Lst,J));
    If CmpLeft(Num,ThisWord+'=')Then Begin
     FOInit(TF);
     TF.I:=Length(ThisWord)+2;
     TF.OnSymbol:=VEOnSymbol;
     TF.OnWord:=VEOnWord;
     Q.Context:=@Lst;
     VEOnWord:=FOCompute(TF,Num);
     Goto Finish;
    End;
   End;
   Exit;
  End;
 End;
Finish:
 Case(TF.Result.TypeDef)of
  dtLong:FOPushNumberLong(Q,TF.Result.X.DataLong);
  Else FOPushNumberReal(Q,TF.Result.X.DataReal);
 End;
 VEOnWord:=True;
End;

Function ValExt(Var Ib:Byte;S:String;Var Lst:ArrayList):String;
Var
 Q:FormulaObject;
Begin
 ChgChr(S,'ú','*');
 ChgChr(S,'ù','*');
 ChgChr(S,'ö','/');
 FOInit(Q);
 Q.Option:=[foHexPascal,foNumberC,foNumberBasic,foExpBasic,
            foStringPascal,foStringC,foPourcent,foIntDiv];
 Q.I:=Ib;
 Q.OnSymbol:=VEOnSymbol;
 Q.OnWord:=VEOnWord;
 Q.Context:=@Lst;
 FOCompute(Q,S);
 Ib:=Q.I;
 Case(Q.Result.TypeDef)of
  dtLong:ValExt:=IntToStr(Q.Result.X.DataLong);
  Else ValExt:=RealStr(Q.Result.X.DataReal);
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                               Proc‚dure WWInit                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure initialise l'objet de calculatrice programmable utilisable
 de fa‡on concrŠte par un utilisateur.
}

Function WWInit;
Var
 Inf:WatchWin Absolute Q;
Begin
 ALInit(Inf.V);
 WEInit(Inf.W,X1,Y1,X2,Y2);
 {$IFNDEF H}WEPushWn(Inf.W);{$ENDIF}
 Inf.Sub:=Inf.W;
 Dec(Inf.Sub.T.Y2,9);Dec(Inf.Sub.MaxY,9);
 WWRefresh(Inf);
 WEPutTxt(Inf.Sub,'Calculatrice Programmable: MBP-16');
 If Test8087>0Then WEPutTxt(Inf.Sub,WordToStr(Test8087))
              Else WEPutTxt(Inf.Sub,'E');
 WELn(Inf.Sub);
 WEPutTxtLn(Inf.Sub,'Prˆt!');
 WWInit:=True;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                             Fonction WWRun                             Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de connaŒtre  la r‚action utilisateur … l'int‚rieur
 de l'objet de calculatrice programmable, de l'appliquer si possible, sinon
 de retourne le code correspondant … sa r‚action.
}

Function WWRun;
Label Enter;
Var
 P,K:Word;
 Ok:Boolean;
 NameVar,Calcul:String;
 L:Window;
 X,Y,Yx,Z:Byte;
 Inf:WatchWin Absolute Q;
Begin
 Calcul:='';
 WEPushEndBar(L);
 WEPutLastBar('^F1^ Aide  ^Insert^ Entrez le calcul');
 Repeat
  Ok:=False;
  WESetKr(Inf.Sub,CurrKrs.Dialog.Window.Border shr 4+CurrKrs.Dialog.Window.Border shl 4);
  WEBarSelHor(Inf.Sub,0,Inf.Sub.Y,wnMax);
  WESetKrBorder(Inf.Sub);
  K:=WEReadk(Inf.W);
  WEBarSelHor(Inf.Sub,0,Inf.Sub.Y,wnMax);
  Case(K)of
   kbInWn:Begin
    X:=LastMouseX-WEGetRX1(Inf.W);
    Y:=LastMouseY-WEGetRY1(Inf.W);
    Yx:=Y-(Inf.W.MaxY-7);
    If(Yx)in[0,2,4,6]Then Begin
     If(X)in[0..2,4..6,8..10,12..14,16..18,20..22,24..26,28..30,32..34]Then Begin
      Z:=(X shr 2)+(Yx shr 1)*9;
      Case Kc[Z]of
       'Í':Begin
        WaitMouseMove;
        Goto Enter;
       End;
       'x':IncStr(Calcul,'*');
       Else IncStr(Calcul,Kc[Z]);
      End;
      Inf.Sub.X:=0;
      WEPutTxt(Inf.Sub,Calcul+'?');
      Inf.Sub.X:=0;
      WaitMouseMove;
     End;
    End;
   End;
   kbIns:Begin
    ChgChr(Calcul,'.',DeSep[0]);
    K:=_WinInp(MaxXTxts-20,'Calculatrice Programme',
              'Entrez le calcul … r‚soudre:',False,Calcul);
    WEPutTxt(Inf.Sub,Calcul+'?');
Enter:
    _WELn(Inf.Sub);
    ChgChr(Calcul,DeSep[0],'.');
    P:=Pos('=',Calcul);
    If P>0Then Begin
     Calcul:=StrUp(Calcul);
     NameVar:=Left(Calcul,P);
     If Not ALIsEmpty(Inf.V)Then
      For P:=0to Inf.V.Count-1do If CmpLeft(NameVar,_ALGetStr(Inf.V,P))Then ALDelBuf(Inf.V,P);
     ALAddStr(Inf.V,Calcul);
     ChgChr(Calcul,'.',DeSep[0]);
     WEPutTxt(Inf.Sub,'M‚morise: '+Calcul);
    End
     Else
    Begin
     NameVar:=_ValExt(StrUp(Calcul),Inf.V);
     If GetSysErr>0Then Begin
      WESetKr(Inf.Sub,$C);
      WEPutTxt(Inf.Sub,'Erreur de '+GetErrMsg(GetSysErr));
      WESetKrBorder(Inf.Sub);
     End
      Else
     Begin
      ChgChr(NameVar,'.',DeSep[0]);
      WEPutTxt(Inf.Sub,NameVar);
      If Pos(DeSep[0],NameVar)=0Then Begin
       WEPutTxt(Inf.Sub,', Binaire: '+BinByte2Str(StrToInt(NameVar)));
       WEPutTxt(Inf.Sub,', Hexad‚cimal: '+HexLong2Str(StrToInt(NameVar)));
      End;
     End;
    End;
    _WELn(Inf.Sub);
   End;
   Else Ok:=True;
  End;
 Until Ok;
 WWRun:=K;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                     Proc‚dure WWRefresh                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de raffraŒchir l'affichage de l'objet de
 calculatrice programmable.
}

Procedure WWRefresh;
Const
 Mode:Array[0..11]of Chr='BINOCTHEXDEC';
 Func:Array[0..11]of Chr='sincostanlog';
 Func2:Array[0..3]of String[5]=('sin-1','cos-1','tan-1',' 10ü ');
 Func3:Array[0..3]of String[3]=('RND','EXP','ABS','INT');
 Func4:Array[0..3]of String[3]=(' xı',' Yx','3û ','1/x');
Var
 I:Byte;
 Inf:WatchWin Absolute Q;
Begin
 WEPutWn(Inf.W,'Calculatrice Programmable',CurrKrs.MalteDos.Window);
 Inf.Sub.Palette:=Inf.W.Palette;
 WECloseIcon(Inf.W);
 WEPutTxtXY(Inf.W,0,wnMax-8,MultChr('Ä',Inf.W.MaxX));
 I:=0;
 While I<=35do Begin
  If I mod 9>=6Then WESetKr(Inf.W,$B0)Else
  WESetKr(Inf.W,CurrKrs.Dialog.Window.Border shr 4+CurrKrs.Dialog.Window.Border shl 4);
  If(Kc[I]='Í')and(Kc[I+1]='Í')Then Begin
   WEPutTxtXY(Inf.W,(I mod 9)shl 2,wnMax-7+(I div 9)shl 1,'   =   ');
   Inc(I);
  End
   Else
  If Kc[I]='^'Then WEPutTxtXY(Inf.W,(I mod 9)shl 2,wnMax-7,'XOR')Else
  WEPutTxtXY(Inf.W,(I mod 9)shl 2,wnMax-7+(I div 9)shl 1,' '+Kc[I]+' ');
  Inc(I);
 End;
 WESetKr(Inf.W,$B1);
 For I:=0to 3do WEPutTxtXY(Inf.W,36,wnMax-7+I shl 1,Mode[I*3]+Mode[I*3+1]+Mode[I*3+2]);
 WESetKr(Inf.W,$A0);
 For I:=0to 3do WEPutTxtXY(Inf.W,40,wnMax-7+I shl 1,Func[I*3]+Func[I*3+1]+Func[I*3+2]);
 For I:=0to 3do WEPutTxtXY(Inf.W,44,wnMax-7+I shl 1,Func2[I]);
 For I:=0to 3do WEPutTxtXY(Inf.W,50,wnMax-7+I shl 1,Func3[I]);
 For I:=0to 3do WEPutTxtXY(Inf.W,54,wnMax-7+I shl 1,Func4[I]);
End;

Function WWTitle(Var Q;Max:Byte):String;Begin
 WWTitle:='Calculatrice programmable';
End;

Procedure WWMove2{Var QX;X,Y:Byte};
Var
 Q:WatchWin Absolute QX;
 MX,MY:Byte;
Begin
 MX:=Q.W.T.X2-Q.W.T.X1;MY:=Q.W.T.Y2-Q.W.T.Y1;
 Q.W.T.X1:=X;Q.W.T.X2:=X+MX;
 Q.W.T.Y1:=Y;Q.W.T.Y2:=Y+MY;
 WWRefresh(Q);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                             Proc‚dure WWDone                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de restituer l'affichage et la m‚moire utiliser
 par l'objet de calculatrice programmable.
}

Function WWDone;
Var
 Inf:WatchWin Absolute Q;
Begin
 WEDone(Inf.W);
 ALDone(Inf.V);
 WWDone:=0;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Fonction _ValExt                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de r‚soudre une formule math‚matique contenu dans
 une chaŒne de caractŠres  en tenant  compte de variable contenu dans une
 liste  et  d'une  position pr‚d‚finie  dans la chaŒne de caractŠres.  La
 compr‚hension se fait … partir du d‚but de la chaŒne de caractŠres.
}

Function _ValExt;
Var
 I:Byte;
Begin
 I:=1;_ValExt:=ValExt(I,S,Lst);
 If I<=Length(S)Then GetSysErr:=errSN;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Fonction __ValExt                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de r‚soudre une formule math‚matique contenu dans
 une chaŒne de caractŠres sans tenir  compte de variable contenu dans une
 liste  et  d'une  position pr‚d‚finie  dans la chaŒne de caractŠres.  La
 compr‚hension se fait … partir du d‚but de la chaŒne de caractŠres.
}

Function __ValExt;
Var
 Lst:ArrayList;
Begin
 ALInit(Lst);
 __ValExt:=_ValExt(S,Lst)
End;

Function Convers(X:Real;Const Formula:String):Real;
Var
 Lst:ArrayList;
Begin
 ALInit(Lst);
 ALAddStr(Lst,'X='+RealStr(X));
 Convers:=StrToReal(_ValExt(Formula,Lst))
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                      Proc‚dure UserConversionFormula                 Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet … l'utilisateur d'effectuer une conversion d'une
 unit‚ de mesure … un autre.
}

Procedure UserConversionFormula;
Const
 mF2C=1;
 mC2F=2;
 mKelv2Cent=3;
 mCent2Kelv=4;
 mInch2FtIn=5;
 mFtIn2Inch=6;
 mInch2Yard=7;
 mYard2Inch=8;
 mInch2Mile=9;
 mMile2Inch=10;
 mInch2NautMile=11;
 mNautMile2Inch=12;
 mInch2Meter=13;
 mMeter2Inch=14;
 mSqInch2SqFeet=15;
 mSqFeet2SqInch=16;
 mSqInch2SqYard=17;
 mSqYard2SqInch=18;
 mSqInch2SqMile=19;
 mSqMile2SqInch=20;
 mSqInch2Acre=21;
 mAcre2SqInch=22;
 mSqInch2SqMeter=23;
 mSqMeter2SqInch=24;
 mCuInch2CuFeet=25;
 mCuFeet2CuInch=26;
 mCuInch2CuYard=27;
 mCuYard2CuInch=28;
 mCuInch2CuMeter=29;
 mCuMeter2CuInch=30;
 mFluidOz2Pint=31;
 mPint2FluidOz=32;
 mFluidOz2ImpPint=33;
 mImpPint2FluidOz=34;
 mFluidOz2Gals=35;
 mGals2FluidOz=36;
 mFluidOz2ImpGals=37;
 mImpGals2FluidOz=38;
 mFluidOz2CuMeter=39;
 mCuMeter2FluidOz=40;
 mOunce2LbOz=41;
 mLbOz2Ounce=42;
 mOunce2Ton=43;
 mTon2Ounce=44;
 mOunce2LongTon=45;
 mLongTon2Ounce=46;
 mOunce2Gram=47;
 mGram2Ounce=48;
 mComputeASCII=49;
 mComputeRoman=50;

Var
 P:Word;
 L:LstMnu;
 W:Window;

 Procedure ComputeRoman;
 Var
  W:Window;
  K,I:Word;
  Sm:LongInt;
  PC:PChr;
  PBuf:Array[Byte]of Char;
  S:String;
 Begin
  WEInitO(W,60,11);
  WEPushWn(W);
  WEPutWnKrDials(W,'Sommation Romaine');
  PC:=@PBuf;
  FillClr(PBuf,SizeOf(PBuf));
  WEPutTxtLn(W,'Entrez la chaŒne de caractŠres … analyser:');
  WEBarSpcHorShade(W,0,2,wnMax);
  WESetInpColors(W,$8F,W.Palette.Sel);
  K:=_WEInput(W,0,2,wnMax-1,200,PC);
  If(K=kbEsc)Then Begin
   WEDone(W);
   Exit;
  End;
  WESetKr(W,$8F);
  WEBarSelHor(W,0,2,wnMax-1);
  WESetKrHigh(W);
  S:=StrUp(StrPas(PC));Sm:=0;W.Y:=5;
  For I:=1to Length(S)do If IsRomanLetter(S[I])Then Inc(Sm,Byte(UpCase(S[I]))-64);
  S:=IntToStr(Sm);Sm:=0;
  For I:=1to Length(S)do Inc(Sm,Byte(S[I])-48);
  WEPutTxtLn(W,'La somme est '+S);
  WEPutTxt(W,'D‚composition de la somme est ');
  For I:=1to Length(S)do Begin
   WEPutCube(W,S[I]);
   If I<>Length(S)Then WEPutCube(W,'+');
  End;
  WEPutCube(W,'=');
  WEPutTxt(W,IntToStr(Sm));
  While WEOk(W)do;
 End;

 Procedure ComputeASCII;
 Var
  W:Window;
  K,I:Word;
  Sm:LongInt;
  PC:PChr;
  PBuf:Array[Byte]of Char;
  S:String;
 Begin
  WEInitO(W,60,11);
  WEPushWn(W);
  WEPutWnKrDials(W,'Sommation ASCII');
  PC:=@PBuf;FillClr(PBuf,SizeOf(PBuf));
  WEPutTxtLn(W,'Entrez la chaŒne de caractŠres … analyser:');
  WEBarSpcHorShade(W,0,2,wnMax);
  WESetInpColors(W,$8F,W.Palette.Sel);
  K:=_WEInput(W,0,2,wnMax-1,200,PC);
  If(K=kbEsc)Then Begin
   WEDone(W);
   Exit;
  End;
  WESetKr(W,$8F);
  WEBarSelHor(W,0,2,wnMax-1);
  WESetKrHigh(W);
  S:=StrPas(PC);Sm:=0;W.Y:=5;
  For I:=1to Length(S)do Inc(Sm,Byte(S[I]));
  S:=IntToStr(Sm);Sm:=0;
  For I:=1to Length(S)do Inc(Sm,Byte(S[I])-48);
  WEPutTxtLn(W,'La somme est '+S);
  WEPutTxt(W,'D‚composition de la somme est ');
  For I:=1to Length(S)do Begin
   WEPutCube(W,S[I]);
   If I<>Length(S)Then WEPutCube(W,'+');
  End;
  WEPutCube(W,'=');
  WEPutTxt(W,IntToStr(Sm));
  While WEOk(W)do;
 End;

 Procedure Conversion(P:Word);
 Var
  W:Window;
  R,RE:Real;
  I:Word;
  K:Integer;
  PC:PChr;
  PBuf:Array[0..511]of Char;
  Ptr:Pointer;
  PStr:^String Absolute Ptr;
  S:String;
  SB:PStrByte;
  Entrez,InStr,OutStr,Formula:String;
 Begin
  If DBLocateAbs(ChantalServer,0,P,[])Then Begin
   DBReadRec(ChantalServer,PBuf);
   Ptr:=@PBuf;
   DBGotoColumnAbs(ChantalServer,2,Ptr);
   Entrez:=PStr^;
   Ptr:=@PBuf;
   DBGotoColumnAbs(ChantalServer,3,Ptr);
   InStr:=PStr^;
   Ptr:=@PBuf;
   DBGotoColumnAbs(ChantalServer,4,Ptr);
   OutStr:=PStr^;
   Ptr:=@PBuf;
   DBGotoColumnAbs(ChantalServer,5,Ptr);
   Formula:=PStr^;
  End
   Else
  Begin
   Entrez:='';
   InStr:='';
   OutStr:='';
   Formula:='';
  End;
  WEInitO(W,60,11);
  WEPushWn(W);
  SB:=_ALGetBuf(L.List,P-1);
  WEPutWnKrDials(W,'Conversion de '+StrPas(SB^.PChr));
  WECloseIcon(W);
  PC:=@PBuf;
  FillClr(PBuf,SizeOf(PBuf));
  WEPutTxtLn(W,Entrez);
  WEBarSpcHorShade(W,0,2,wnMax);
  WESetInpColors(W,$8F,W.Palette.Sel);
  K:=_WEInput(W,0,2,wnMax-1,200,PC);
  If(K=kbEsc)or(K=kbClose)Then Begin
   WEDone(W);
   Exit;
  End;
  WESetKr(W,$8F);
  WEBarSelHor(W,0,2,wnMax-1);
  WESetKrHigh(W);
  S:=StrPas(PC);W.Y:=5;Val(S,R,K);RE:=0.0;
  WEPutTxtLn(W,InStr+RealStr2(R,4,1));
  If(Formula='')Then Case(P)of
   mInch2FtIn:Inch2FtIn(R,R,RE);
   mOunce2LbOz:Ounce2LbOz(R,R,RE);
  End
   Else
  R:=Convers(R,Formula);
  If RE=0.0Then WEPutTxtLn(W,OutStr+RealStr2(R,8,5))
           Else WEPutTxtLn(W,OutStr+RealStr2(R,4,0)+DeSep[0]+RealStr2(RE,4,0));
  While WEOk(W)do;
 End;

Begin
 WEInit(W,20,2,MaxXTxts-20,MaxYTxts-2);
 WEPushWn(W);
 LMInitKrDials(L,20,2,MaxXTxts-20,MaxYTxts-2,'Conversion de formule');
 DBOpenServerName(ChantalServer,'CHANTAL:/Math/Convers.Dat');
 DBAddStrByte(ChantalServer,L.List);
 Repeat
  P:=LMRun(L);
  Case(P)of
   mComputeASCII:ComputeASCII;
   mComputeRoman:ComputeRoman;
   0:P:=kbEsc;
   Else Begin
    Conversion(P);
   End;
  End;
 Until P=kbEsc;
 WEDone(W);
End;

Type
 GraphObj=Record
  X1,Y1,X2,Y2:Byte;           { Position de la boŒte }
  NumXPixels,NumYPixels:Real; { Nombre de pixels horizontal et vertical attribu‚}
  PhysNumXPixels:Word;        { Nombre physique de pixel horizontal }
  PhysNumYPixels:Word;        { Nombre physique de pixel vertical }
  XRatio,YRatio:Real;         { Nombre de pixels par pixel }
  XCenter,YCenter:Word;       { Centre du graphique en pixels }
  XStart,YStart:Word;         { Position absolue de d‚part en pixels }
 End;

Procedure WGInit(Var Q:GraphObj;X1,Y1,X2,Y2:Byte;NumXPixels,NumYPixels:Real);Begin
 Q.X1:=X1;Q.Y1:=Y1;Q.X2:=X2;Q.Y2:=Y2;
 Q.NumXPixels:=Abs(NumXPixels);
 Q.NumYPixels:=Abs(NumYPixels);
 Q.PhysNumXPixels:=(X2-X1+1)shl 3;
 Q.PhysNumYPixels:=GetRawY(Y2-Y1+1);
 Q.XRatio:=Q.PhysNumXPixels;
 Q.XRatio:=Abs(Q.XRatio/(NumXPixels*2));
 Q.YRatio:=Q.PhysNumYPixels;
 Q.YRatio:=Abs(Q.YRatio/(NumYPixels*2));
 Q.XStart:=(Q.X1 shl 3);Q.YStart:=GetRawY(Q.Y1);
 Q.XCenter:=Q.XStart+(Q.PhysNumXPixels shr 1);
 Q.YCenter:=Q.YStart+(Q.PhysNumYPixels shr 1);
End;

Procedure WGPutFrame(Var Q:GraphObj);
Var
 I,Y,X,Xtra:Byte;
 S:String;
Begin
 For I:=Q.X1+1to Q.X1+(Q.PhysNumXPixels shr 4)-1do Begin
  If(BitsPerPixel>=4)and(Cadril)Then Begin
   PutLn(Q.XStart+(I shl 4),Q.YStart,Q.XStart+(I shl 4),Q.YStart+Q.PhysNumYPixels-1,DarkGray);
  End;
  _Ln(Q.XStart+(I shl 4),Q.YCenter-4,Q.XStart+(I shl 4),Q.YCenter+4);
 End;
 Xtra:=0;
 If(Q.Y2-Q.Y1+1)and 1=1Then Xtra:=HeightChr shr 1;
 For I:=Q.Y1 to(Q.Y2)do Begin
  If(BitsPerPixel>=4)and(Cadril)Then Begin
   ClrLnHor(Q.XStart,GetRawY(I)+Xtra,Q.PhysNumXPixels,DarkGray);
  End;
  ClrLnHor(Q.XCenter-4,GetRawY(I)+Xtra,9,GraphColor);
 End;
 ClrLnHor(Q.XStart,Q.YCenter,Q.PhysNumXPixels,GraphColor);
 _Ln(Q.XCenter,Q.YStart,Q.XCenter,Pred(Q.YStart+Q.PhysNumYPixels));
 X:=Q.X1+((Q.X2-Q.X1+1)shr 1)+1;
 Y:=Q.Y1+((Q.Y2-Q.Y1+1)shr 1)+1;
 S:=RealStr2(Q.NumXPixels,1,2);
 PutTxtXYT(Q.X1,Y,'-'+S,GraphColor and$F);
 PutTxtXYT(Q.X2-Length(S),Y,S,GraphColor and$F);
 S:=RealStr2(Q.NumYPixels,1,2);
 PutTxtXYT(X,Q.Y1,S,GraphColor and$F);
 PutTxtXYT(X,Q.Y2,'-'+S,GraphColor and$F);
End;

Procedure WGPutPixel(Var Q:GraphObj;X,Y:Real);Begin
 _SetPixel(Q.XCenter+Trunc(X*Q.XRatio),Q.YCenter-Trunc(Y*Q.YRatio));
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Proc‚dure Eq1reDegre                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ


  Cette proc‚dure permet … l'utilisateur d'obtenir la r‚ponse d'une ‚quation
 de premier degr‚.
}

Procedure Eq1erDegre;
Var
 W:Window;
 a,b,x:Real;
 Err:Integer;
 S:String;

 Procedure Graph;
 Var
  S:ImgRec;
  Ok:Boolean;
  MX,MY:Word;
  Q:GraphObj;
  _as,bs:String;
  t:Real;
  I:Word;
 Begin
  PushScr(S);
  Ok:=False;
  If(IsGrf)Then Begin
   Ok:=True;
   ClrScrBlack;
  End
   Else
  If SetVideoModeDeluxe(vmGrf640x480c2)Then Begin
   Ok:=True;
  End
   Else
  If SetVideoModeDeluxe(vmGrf640x200c2)Then Begin
   Ok:=True;
  End
   Else
  ErrNoMsgOk(errHardwareIncompatible);
  If(Ok)Then Begin
    {Affichage du graphique...}
   BarSpcHor(0,0,MaxXTxts,$F0);
   _as:=LTrim(RealStr2(a,5,2));
   While _as[Length(_as)]='0'do BackStr(_as);
   If _as[Length(_as)]='.'Then BackStr(_as);
   bs:=LTrim(RealStr2(b,5,2));
   While bs[Length(bs)]='0'do BackStr(bs);
   If bs[Length(bs)]='.'Then BackStr(bs);
   PutTxtXY(2,0,'quation: f(x)='+_as+'x+'+bs,$F0);
   _SetKr(White);
   WGInit(Q,0,1,MaxXTxts,MaxYTxts,x,a*x);
   WGPutFrame(Q);
   If BitsPerPixel>=4Then _SetKr(LightBlue);
   For I:=1to(Q.PhysNumXPixels shr 1)-1do Begin
    t:=(x/(Q.PhysNumXPixels shr 1))*i;
    WGPutPixel(Q,t,a*t+b);
   End;
   _SetKr(LightRed);
   WGPutPixel(Q,x,0);
   ReadKey;
  End;
  PopScr(S);
 End;

Begin
 WEInitO(W,40,15);
 WEPushWn(W);
 WEPutWnKrDials(W,'Equation du 1er degr‚');
 WECloseIcon(W);
 WELn(W);
 WEBar(W);
 WEPutTxtLn(W,'R‚solution de ®ax + b = 0¯');
 WELn(W);
 WEPutTxt(W,'Introduisez la valeur de ®a¯: ');
 S:='';
 Case WEInpStr(W,S)of
  kbEnter,kbTab,kbShiftTab:;
  Else Begin
   WEDone(W);
   Exit;
  End;
 End;
 System.Val(S,a,Err);
 WELn(W);WELn(W);
 WEPutTxt(W,'Introduisez la valeur de ®b¯: ');
 S:='';
 Case WEInpStr(W,S)of
  kbEnter,kbTab,kbShiftTab:;
  Else Begin
   WEDone(W);
   Exit;
  End;
 End;
 System.Val(S,b,Err);
 WELn(W);
 WELn(W);
 WEPutTxtLn(W,'R‚sultat:');
 WELn(W);
 If a=0Then Begin
  If b=0Then WEPutTxtLn(W,'quation ind‚termin‚e!')
        Else WEPutTxtLn(W,'quation impossible … r‚soudre!');
  While WEOk(W)do;
 End
  Else
 Begin
  x:=-b/a;
  WEPutTxtLn(W,'x = '+RealStr2(x,5,2));
  Repeat
   Case WEGetkHorDn(W,'Correcte|Graphique')of
    kbEsc,kbAbort,0:Break;
    1:Graph;
   End;
  Until False;
  WEDone(W);
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Proc‚dure Eq2emeDegre                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ


  Cette proc‚dure permet … l'utilisateur d'obtenir la r‚ponse d'une ‚quation
 de deuxiŠme degr‚.
}

Procedure Eq2emeDegre;
Var
 W:Window;
 a,b,c,Delta:Real;
 Err:Integer;
 S:String;
Begin
 WEInitO(W,60,16);
 WEPushWn(W);
 WEPutWnKrDials(W,'Equation du 2Šme degr‚');
 WECloseIcon(W);
 WELn(W);
 WEBar(W);
 WEPutTxtLn(W,'R‚solution de ®axı + bx + c = 0¯');
 WELn(W);
 WEPutTxt(W,'Introduisez la valeur de ®a¯: ');
 S:='';
 Case WEInpStr(W,S)of
  kbEnter,kbTab,kbShiftTab:;
  Else Begin
   WEDone(W);
   Exit;
  End;
 End;
 System.Val(S,a,Err);
 WELn(W);
 WELn(W);
 WEPutTxt(W,'Introduisez la valeur de ®b¯: ');
 S:='';
 Case WEInpStr(W,S)of
  kbEnter,kbTab,kbShiftTab:;
  Else Begin
   WEDone(W);
   Exit;
  End;
 End;
 System.Val(S,b,Err);
 WELn(W);
 WELn(W);
 WEPutTxt(W,'Introduisez la valeur de ®c¯: ');
 S:='';
 Case WEInpStr(W,S)of
  kbEnter,kbTab,kbShiftTab:;
  Else Begin
   WEDone(W);
   Exit;
  End;
 End;
 System.Val(S,c,Err);
 WELn(W);
 WELn(W);
 WEPutTxtLn(W,'R‚sultat:');
 WELn(W);
 If a=0Then Begin
  If b=0Then WEPutTxtLn(W,'quation ind‚termin‚e!')
        Else WEPutTxtLn(W,'quation impossible … r‚soudre!');
 End
  Else
 Begin
  Delta:=b*b-4*a*c;
  If Delta>0Then Begin
   WEPutTxtLn(W,'Deux racines r‚elles: '+RealStr2((-b+Sqrt(Delta))/(2*a),5,2)+','+
                                         RealStr2((-b-Sqrt(Delta))/(2*a),5,2))
  End
   Else
  If Delta=0Then Begin
   WEPutTxtLn(W,'Une racine r‚elles: '+RealStr2((-b)/(2*a),5,2));
  End
   Else
  Begin
   WEPutTxtLn(W,'Deux racines complexes conjugu‚es: '+
                RealStr2((-b)/(2*a),5,2)+'ñi'+RealStr2(Sqrt(-Delta)/(2*a),5,2));
  End;
 End;
 While WEOk(W)do;
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
END.