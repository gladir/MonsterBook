Unit MalCalc;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                  INTERFACE
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

{$V-}
Uses
 Systex,Isatex;

Procedure SCInit(Var Q:SuperCalcApp;X1,Y1,X2,Y2,Model:Byte);
Function  SCNew(Var Q;X1,Y1,X2,Y2:Byte):Boolean;
Procedure SCRefresh(Var Context);
Procedure SCCopyClipboard(Var Q:SuperCalcApp);
Procedure SCGotoLine(Var Q:SuperCalcApp;Line:LongInt);
Procedure SCGotoRow(Var Q:SuperCalcApp;Row:LongInt);
Function  SCGetCellule(Var Q:SuperCalcApp;PX,PY:LongInt):PCellule;
Function  SCGetCurrCellule(Var Q:SuperCalcApp):PCellule;
Procedure SCPasteClipboard(Var Q:SuperCalcApp);
Procedure SCPushData(Var Q:SuperCalcApp;S:String);
Procedure SCPutData(Var Q:SuperCalcApp;XL,YS:Byte;PX,PY:LongInt;TrueColor:Boolean);
Procedure SCPutUnselect(Var Q:SuperCalcApp);
Procedure SCPutSelect(Var Q:SuperCalcApp);
Procedure SCRefreshSpreadSheet(Var Q:SuperCalcApp);
Procedure SCUpdateStatusBar(Var Q:SuperCalcApp);
Procedure SCDn(Var Q:SuperCalcApp);
Function  SCRun(Var Context):Word;
Function  SCTitle(Var Q;Max:Byte):String;
Procedure SCUnderline(Var Q:SuperCalcApp);
Procedure SCMove2(Var Context;X,Y:Byte);
Procedure SCReSize(Var Context;X1,Y1,X2,Y2:Byte);
Function  SCDone(Var Context):Word;
Function  CEInit(Var Q:CelluleObject):Boolean;
Function  CEAdd(Var Q:CelluleObject):Boolean;
Function  CEAddEmpty(Var Q:CelluleObject;Column,Row:LongInt):Boolean;
Function  CEAddFormula(Var Q:CelluleObject;Column,Row:LongInt;Const S:String):Boolean;
Function  CEAddRealValue(Var Q:CelluleObject;Column,Row:LongInt;Value:Real):Boolean;
Function  CEAddText(Var Q:CelluleObject;Column,Row:LongInt;Const S:String):Boolean;
Function  CEDelete(Var Q:CelluleObject;Column,Row:LongInt):Boolean;
Function  HTInit(Var Q:HashTable;InitBuckets:BucketRange):Boolean;
Procedure COInit(Var Q:ColumnObject);
Function  COAdd(Var Q:ColumnObject):Boolean;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                               IMPLEMENTATION
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses
 Adele,Video,Memories,Systems,Dials,Editor,DialPlus,Dialex,Math,Numerix,
 Mouse,Restex,ResServD,ResLoadD,ResSaveD,Calcex,CalcTool,Time,ToolDB,
 CalcSave,CalcMacr;

Procedure SCComputeScreenColumn(Var Q:SuperCalcApp);Near;Forward;
Procedure SCLeft(Var Q:SuperCalcApp);Near;Forward;
Procedure SCPutSelErr(Var Q:SuperCalcApp);Near;Forward;
Procedure SCPutCurrInputLine(Var Q:SuperCalcApp);Near;Forward;
Procedure SCUp(Var Q:SuperCalcApp);Near;Forward;
Function  SCXtrkFormule(Var SC:SuperCalcApp;Const S:String;Var I:Byte;Var Q:Variant):Boolean;Near;Forward;

Const
 XInputPosCalc=3; { Position X de d‚part de l'entr‚e du tableur }

 PI=3.14159265358979323846;          { Pi }
 LN2=0.69314718055994530942;         { Ln(2) }
 LN10=2.30258509299404568402;        { Ln(10) }
 LNPI=1.14472988584940017414;        { Ln(Pi) }
 INVLN2=1.44269504088896340736;      { 1/Ln(2) }
 INVLN10=0.43429448190325182765;     { 1/Ln(10) }
 TWOPI=6.28318530717958647693;       { 2*Pi }
 PIDIV2=1.57079632679489661923;      { Pi/2 }
 SQRTPI=1.77245385090551602730;      { Sqrt(Pi) }
 SQRT2PI=2.50662827463100050242;     { Sqrt(2*Pi) }
 INVSQRT2PI=0.39894228040143267794;  { 1/Sqrt(2*Pi) }
 LNSQRT2PI=0.91893853320467274178;   { Ln(Sqrt(2*Pi)) }
 LN2PIDIV2=0.91893853320467274178;   { Ln(2*Pi)/2 }
 SQRT2=1.41421356237309504880;       { Sqrt(2) }
 SQRT2DIV2=0.70710678118654752440;   { Sqrt(2)/2 }
 GOLD=1.61803398874989484821;        { Golden Mean = (1 + Sqrt(5))/2 }
 CGOLD=0.38196601125010515179;       { 2 - GOLD }

 MACHEP=1.818989404E-12;             { 2^(-39) }
 MaxLog=8.664339757E+01;
 MinLog=-4.253529586E+01;
 MaxFac=33;
 MaxGam=34.64809785;
 MaxLGM=1.038324114E+36;

  { Utilis‚ pour la IGamma et IBeta }
 Big=9.223372036854775808E18;
 BigInv=1.084202172485504434007E-19;

Function Binomial(N,K:Integer):Real;Near;Forward;    { Binomial coef. C(N,K) }
function DNorm(X:Real):Real;Near;Forward;
Function Erf(X:Real):Real;Near;Forward;
Function Expo(X:Real):Real;Near;Forward;
Function FNorm(X:Real):Real;Near;Forward;
Function Gamma(X:Real):Real;Near;Forward;            { Fonction Gamma }
Function GamSmall(X1,Z:Real):Real;Near;Forward;
Function IBeta(A,B,X:Real):Real;Near;Forward;        { Fonction de Bˆta incomplŠte }
Function IGamma(A,X:Real):Real;Near;Forward;         { Fonction Gamma incomplŠte }
Function JGamma(A,X:Real):Real;Near;Forward;         { Compl‚ment de IGamma }
function LnGamma(X:Real):Real;Near;Forward;          { Log(|Gamma(X)|) }
Function P1Evl(Var X:Real;Var Coef:TabCoef;N:Integer):Real;Near;Forward;
Function PolEvl(Var X:Real;Var Coef:TabCoef;N:Integer):Real;Near;Forward;
Function PSeries(A,B,X:Real):Real;Near;Forward;
Function SgnGamma(X:Real):Integer;Near;Forward;      { Sign de la fonction Gamma }
Function Stirf(X:Real):Real;Near;Forward;
Function StirfL(X:Real):Real;Near;Forward;
Function PPoisson(Mu:Real;K:Integer):Real;Near;Forward;  { Prob(X = K) }
Function FPoisson(Mu:Real;K:Integer):Real;Near;Forward;  { Prob(X <= K) }

  (************************************************************)
  (*                   Fonctions math‚matique                 *)
  (************************************************************)

{Continue l'expension de la fraction #1 pour le bˆta int‚gral incomplet }
Function CFrac1(A,B,X:Real):Real;Near;
Label CDone;
Var
 Xk,Pk,Pkm1,Pkm2,Qk,Qkm1,Qkm2,K1,K2,K3,K4,K5,K6,K7,K8,R,T,Ans,Thresh:Real;
 N:Integer;
Begin
 K1:=A;
 K2:=A+B;
 K3:=A;
 K4:=A+1.0;
 K5:=1.0;
 K6:=B-1.0;
 K7:=K4;
 K8:=A+2.0;
 Pkm2:=0.0;
 Qkm2:=1.0;
 Pkm1:=1.0;
 Qkm1:=1.0;
 Ans:=1.0;
 R:=1.0;
 N:=0;
 Thresh:=3.0*MACHEP;
 Repeat
  Xk:=-(X*K1*K2)/(K3*K4);
  Pk:=Pkm1+Pkm2*Xk;
  Qk:=Qkm1+Qkm2*Xk;
  Pkm2:=Pkm1;
  Pkm1:=Pk;
  Qkm2:=Qkm1;
  Qkm1:=Qk;
  Xk:=(X*K5*K6)/(K7*K8);
  Pk:=Pkm1+Pkm2*Xk;
  Qk:=Qkm1+Qkm2*Xk;
  Pkm2:=Pkm1;
  Pkm1:=Pk;
  Qkm2:=Qkm1;
  Qkm1:=Qk;
  If Qk<>0.0Then R:=Pk/Qk;
  If R<>0.0Then Begin
   T:=Abs((Ans-R)/R);
   Ans:=R;
  End
   Else
  T:=1.0;
  If(T<Thresh)Then Goto CDone;
  K1:=K1+1.0;
  K2:=K2+1.0;
  K3:=K3+2.0;
  K4:=K4+2.0;
  K5:=K5+1.0;
  K6:=K6-1.0;
  K7:=K7+2.0;
  K8:=K8+2.0;
  If(Abs(Qk)+Abs(Pk)>BIG)Then Begin
   Pkm2:=Pkm2*BigInv;
   Pkm1:=Pkm1*BigInv;
   Qkm2:=Qkm2*BigInv;
   Qkm1:=Qkm1*BigInv;
  End;
  If(Abs(Qk)<BigInv)or(Abs(Pk)<BigInv)Then Begin
   Pkm2:=Pkm2*BIG;
   Pkm1:=Pkm1*BIG;
   Qkm2:=Qkm2*BIG;
   Qkm1:=Qkm1*BIG;
  End;
  Inc(N);
 Until N>400;
 MathErr:=fnPLOSS;
CDone:
 CFrac1:=Ans;
End;

{Continue l'expension de la fraction #2 pour le bˆta int‚gral incomplet }
Function CFrac2(A,B,X:Real):Real;Near;
Label CDone;
Var
 Xk,Pk,Pkm1,Pkm2,Qk,Qkm1,Qkm2,K1,K2,K3,K4,K5,K6,K7,K8,R,T,Z,Ans,Thresh:Real;
 N:Integer;
Begin
 K1:=A;
 K2:=B-1.0;
 K3:=A;
 K4:=A+1.0;
 K5:=1.0;
 K6:=A+B;
 K7:=A+1.0;
 K8:=A+2.0;
 Pkm2:=0.0;
 Qkm2:=1.0;
 Pkm1:=1.0;
 Qkm1:=1.0;
 Z:=X/(1.0-X);
 Ans:=1.0;
 R:=1.0;
 N:=0;
 Thresh:=3.0*MACHEP;
 Repeat
  Xk:=-(Z*K1*K2)/(K3*K4);
  Pk:=Pkm1+Pkm2*Xk;
  Qk:=Qkm1+Qkm2*Xk;
  Pkm2:=Pkm1;
  Pkm1:=Pk;
  Qkm2:=Qkm1;
  Qkm1:=Qk;
  Xk:=(Z*K5*K6)/(K7*K8);
  Pk:=Pkm1+Pkm2*Xk;
  Qk:=Qkm1+Qkm2*Xk;
  Pkm2:=Pkm1;
  Pkm1:=Pk;
  Qkm2:=Qkm1;
  Qkm1:=Qk;
  If Qk<>0.0Then R:=Pk/Qk;
  If R<>0.0Then Begin
   T:=Abs((Ans-R)/R);
   Ans:=R;
  End
   Else
  T:=1.0;
  If(T<Thresh)Then Goto CDone;
  K1:=K1+1.0;
  K2:=K2-1.0;
  K3:=K3+2.0;
  K4:=K4+2.0;
  K5:=K5+1.0;
  K6:=K6+1.0;
  K7:=K7+2.0;
  K8:=K8+2.0;
  If(Abs(Qk)+Abs(Pk)>BIG)Then Begin
   Pkm2:=Pkm2*BigInv;
   Pkm1:=Pkm1*BigInv;
   Qkm2:=Qkm2*BigInv;
   Qkm1:=Qkm1*BigInv;
  End;
  If(Abs(Qk)<BigInv)or(Abs(Pk)<BigInv)Then Begin
   Pkm2:=Pkm2*BIG;
   Pkm1:=Pkm1*BIG;
   Qkm2:=Qkm2*BIG;
   Qkm1:=Qkm1*BIG;
  End;
  Inc(N);
 Until N>400;
 MathErr:=fnPLOSS;
CDone:
 CFrac2:=Ans;
End;

Function DNorm(X:Real):Real;Begin
 DNorm:=InvSqrt2PI*Expo(-0.5*Sqr(X));
End;

{Fonction d'erreur}
Function Erf(X:Real):Real;
Var
 Result:Real;
Begin
 Result:=IGamma(0.5,Sqr(X));
 If X<0.0Then Erf:=-Result
         Else Erf:=Result;
End;

Function Expo(X:Real):Real;Begin
 MathErr:=fnOk;
 If(X<MINLOG)Then Expo:=DefaultVal(fnUnderflow)Else
 If(X>MAXLOG)Then Expo:=DefaultVal(fnOverflow)
             Else Expo:=Exp(X);
End;

Function FNorm(X:Real):Real;Begin
 FNorm:=0.5*(1.0+Erf(X*SQRT2DIV2));
End;

Function Gamma(X:Real):Real;
Const
 P:TabCoef=(
  4.212760487471622013093E-5,
  4.542931960608009155600E-4,
  4.092666828394035500949E-3,
  2.385363243461108252554E-2,
  1.113062816019361559013E-1,
  3.629515436640239168939E-1,
  8.378004301573126728826E-1,
  1.000000000000000000009E0,
  0, 0);
 Q:TabCoef=(
  - 1.397148517476170440917E-5,
    2.346584059160635244282E-4,
  - 1.237799246653152231188E-3,
  - 7.955933682494738320586E-4,
    2.773706565840072979165E-2,
  - 4.633887671244534213831E-2,
  - 2.243510905670329164562E-1,
    4.150160950588455434583E-1,
    9.999999999999999999908E-1,
    0);
Var
 SgnGam,N:Integer;
 A,X1,Z:Real;
Begin
 MathErr:=fnOk;
 SgnGam:=SgnGamma(X);
 If(X=0.0)or((X<0.0)and(Frac(X)=0.0))Then Begin
  Gamma:=SgnGam*DefaultVal(fnSing);
  Exit;
 End;
 If(X>MaxGam)Then Begin
  Gamma:=DefaultVal(fnOverflow);
  Exit;
 End;
 A:=Abs(X);
 If A>13.0Then Begin
  If X<0.0Then Begin
   N:=Trunc(A);
   Z:=A-N;
   If Z>0.5Then Begin
    Inc(N);
    Z:=A-N;
   End;
   Z:=Abs(A*Sin(PI*Z))*Stirf(A);
   If(Z<=PI/MaxNum)Then Begin
    Gamma:=SgnGam*DefaultVal(fnOverflow);
    Exit;
   End;
   Z:=PI/Z;
  End
   Else
  Z:=Stirf(X);
  Gamma:=SgnGam*Z;
 End
  Else
 Begin
  Z:=1.0;
  X1:=X;
  While X1>=3.0do Begin
   X1:=X1-1.0;
   Z:=Z*X1;
  End;
  While X1<-0.03125do Begin
   Z:=Z/X1;
   X1:=X1+1.0;
  End;
  If X1<=0.03125Then Gamma:=GamSmall(X1,Z)
   Else
  Begin
   While X1<2.0do Begin
    Z:=Z/X1;
    X1:=X1+1.0;
   End;
   If(X1=2.0)or(X1=3.0)Then Gamma:=Z
    Else
   Begin
    X1:=X1-2.0;
    Gamma:=Z*PolEvl(X1,P,7)/PolEvl(X1,Q,8);
   End;
  End;
 End;
End;

 { Fonction Gamma pour les petites valeurs d'argument }
Function GamSmall(X1,Z:Real):Real;
Const
 S:TabCoef=(
  - 1.193945051381510095614E-3,
    7.220599478036909672331E-3,
  - 9.622023360406271645744E-3,
  - 4.219773360705915470089E-2,
    1.665386113720805206758E-1,
  - 4.200263503403344054473E-2,
  - 6.558780715202540684668E-1,
    5.772156649015328608253E-1,
    1.000000000000000000000E0,
    0);
 SN:TabCoef=(
    1.133374167243894382010E-3,
    7.220837261893170325704E-3,
    9.621911155035976733706E-3,
  - 4.219773343731191721664E-2,
  - 1.665386113944413519335E-1,
  - 4.200263503402112910504E-2,
    6.558780715202536547116E-1,
    5.772156649015328608727E-1,
  - 1.000000000000000000000E0,
    0);
Var
 P:Real;
Begin
 If X1=0.0Then Begin
  GamSmall:=DefaultVal(fnSing);
  Exit;
 End;
 If X1<0.0Then Begin
  X1:=-X1;
  P:=PolEvl(X1,SN,8);
 End
  Else
 P:=PolEvl(X1,S,8);
 GamSmall:=Z/(X1*P);
End;

Function IGamma(A,X:Real):Real;
Var
 Ans,Ax,C,R:Real;
Begin
 MathErr:=fnOk;
 If(X<=0.0)or(A<=0.0)Then Begin
  IGamma:=0.0;
  Exit;
 End;
 If(X>1.0)and(X>A)Then Begin
  IGamma:=1.0-JGamma(A,X);
  Exit;
 End;
 Ax:=A*Ln(X)-X-LnGamma(A);
 If(Ax<MinLog)Then Begin
  IGamma:=DefaultVal(fnUnderflow);
  Exit;
 End;
 Ax:=Exp(Ax);
  { Puissance de la s‚rie }
 R:=A;
 C:=1.0;
 Ans:=1.0;
 Repeat
  R:=R+1.0;
  C:=C*X/R;
  Ans:=Ans+C;
 Until C/Ans<=MACHEP;
 IGamma:=Ans*Ax/A;
End;

Function JGamma(A,X:Real):Real;
Var
 Ans,C,Yc,Ax,Y,Z,R,T,Pk,Pkm1,Pkm2,Qk,Qkm1,Qkm2:Real;
Begin
 MathErr:=fnOk;
 If(X<=0.0)or(A<=0.0)Then Begin
  JGamma:=1.0;
  Exit;
 End;
 If(X<1.0)or(X<A)Then Begin
  JGamma:=1.0-IGamma(A,X);
  Exit;
 End;
 Ax:=A*Ln(X)-X-LnGamma(A);
 If(Ax<MINLOG)Then Begin
  JGamma:=DefaultVal(fnUnderflow);
  Exit;
 End;
 Ax:=Exp(Ax);
  { Continue la fraction }
 Y:=1.0-A;
 Z:=X+Y+1.0;
 C:=0.0;
 Pkm2:=1.0;
 Qkm2:=X;
 Pkm1:=X+1.0;
 Qkm1:=Z*X;
 Ans:=Pkm1/Qkm1;
 Repeat
  C:=C+1.0;
  Y:=Y+1.0;
  Z:=Z+2.0;
  Yc:=Y*C;
  Pk:=Pkm1*Z-Pkm2*Yc;
  Qk:=Qkm1*Z-Qkm2*Yc;
  If Qk<>0.0Then Begin
   R:=Pk/Qk;
   T:=Abs((Ans-R)/R);
   Ans:=R;
  End
   Else
  T:=1.0;
  Pkm2:=Pkm1;
  Pkm1:=Pk;
  Qkm2:=Qkm1;
  Qkm1:=Qk;
  If(Abs(Pk)>BIG)Then Begin
   Pkm2:=Pkm2/BIG;
   Pkm1:=Pkm1/BIG;
   Qkm2:=Qkm2/BIG;
   Qkm1:=Qkm1/BIG;
  End;
 Until T<=MACHEP;
 JGamma:=Ans*Ax;
End;

Function LnGamma(X:Real):Real;
Const
 P:TabCoef=(
  - 2.163690827643812857640E3,
  - 8.723871522843511459790E4,
  - 1.104326814691464261197E6,
  - 6.111225012005214299996E6,
  - 1.625568062543700591014E7,
  - 2.003937418103815175475E7,
  - 8.875666783650703802159E6,
    0, 0, 0);
 Q:TabCoef=(
  - 5.139481484435370143617E2,
  - 3.403570840534304670537E4,
  - 6.227441164066219501697E5,
  - 4.814940379411882186630E6,
  - 1.785433287045078156959E7,
  - 3.138646407656182662088E7,
  - 2.099336717757895876142E7,
    0, 0, 0);
Var
 N:Integer;
 A,X1,Z:Real;
Begin
 MathErr:=fnOk;
 If(X=0.0)or((X<0.0)and(Frac(X)=0.0))Then Begin
  LnGamma:=DefaultVal(fnSing);
  Exit;
 End;
 If(X>MaxLGM)Then Begin
  LnGamma:=DefaultVal(fnOverflow);
  Exit;
 End;
 A:=Abs(X);
 If A>34.0Then Begin
  If X<0.0Then Begin
   N:=Trunc(A);
   Z:=A-N;
   If Z>0.5Then Begin
    Inc(N);
    Z:=N-A;
   End;
   Z:=A*Sin(PI*Z);
   If Z=0.0Then Begin
    LnGamma:=DefaultVal(fnOverflow);
    Exit;
   End;
   Z:=LNPI-Ln(Z)-StirfL(A);
  End
   Else
  Z:=StirfL(X);
  LnGamma:=Z;
 End
  Else
 If X<13.0Then Begin
  Z:=1.0;
  X1:=X;
  While X1>=3do Begin
   X1:=X1-1.0;
   Z:=Z*X1;
  End;
  While X1<2.0do Begin
   If Abs(X1)<=0.03125Then Begin
    LnGamma:=Ln(Abs(GamSmall(X1,Z)));
    Exit;
   End;
   Z:=Z/X1;
   X1:=X1+1.0;
  End;
  If Z<0.0Then Z:=-Z;
  If X1=2.0Then LnGamma:=Ln(Z)
   Else
  Begin
   X1:=X1-2.0;
   LnGamma:=X1*PolEvl(X1,P,6)/P1Evl(X1,Q,7)+Ln(Z);
  End;
 End
  Else
 LnGamma:=StirfL(X);
End;

Function DGamma(A,B,X:Real):Real;Near;
Var
 L:Real;
Begin
 MathErr:=fnOk;
 If(A<=0.0)or(B<=0.0)or(X<0.0)Then DGamma:=DefaultVal(fnDomain)
  Else
 If X=0.0Then
  If A<1.0Then DGamma:=DefaultVal(fnSing)Else
  If A=1.0Then DGamma:=B
          Else DGamma:=0.0
  Else
 Begin
  L:=A*Ln(B)-LnGamma(A)+(A-1.0)*Ln(X)-B*X;
  DGamma:=Expo(L);
 End;
End;

Function FGamma(A,B,X:Real):Real;Near;Begin
 FGamma:=IGamma(A,B*X);
End;

{Evaluation du polynome de degr‚e N:

		      2	   N
  y  =  C  + C x + C x  +...+ C x
	 0	1     2 	 N

Les coefficients sont stock‚ dans l'ordre inverse:

Coef[0] = C  , ..., Coef[N] = C
           N                   0}
Function PolEvl(Var X:Real;Var Coef:TabCoef;N:Integer):Real;
Var
 Ans:Real;
 I:Integer;
Begin
 Ans:=Coef[0];
 For I:=1to(N)do Ans:=Ans*X+Coef[I];
 PolEvl:=Ans;
End;

{ Evalue le polynome quand le coefficient de X vaut 1,0.
}
Function P1Evl(Var X:Real;Var Coef:TabCoef;N:Integer):Real;
Var
 Ans:Real;
 I:Integer;
Begin
 Ans:=X+Coef[0];
 For I:=1to N-1do Ans:=Ans*X+Coef[I];
 P1Evl:=Ans;
End;

{ Puissance de la s‚rie pour la bˆta int‚gral incomplŠte.
  Utilis‚ avec B * X quand il est petit }
Function PSeries(A,B,X:Real):Real;
Var
 S,T,U,V,T1,Z,Ai:Real;
 N:Integer;
Begin
 Ai:=1.0/A;
 U:=(1.0-B)*X;
 V:=U/(A+1.0);
 T1:=V;
 T:=U;
 N:=2;
 S:=0.0;
 Z:=MACHEP*Ai;
 While(Abs(V)>Z)do Begin
  U:=(N-B)*X/N;
  T:=T*U;
  V:=T/(A+N);
  S:=S+V;
  Inc(N);
 End;
 S:=S+T1;
 S:=S+Ai;
 U:=A*Ln(X);
 If(A+B<MaxGam)and(Abs(U)<MaxLog)Then Begin
  T:=Gamma(A+B)/(Gamma(A)*Gamma(B));
  S:=S*T*Power(X,A);
 End
  Else
 Begin
  T:=LnGamma(A+B)-LnGamma(A)-LnGamma(B)+U+Ln(S);
  If(T<MinLog)Then S:=0.0
              Else S:=Exp(T);
 End;
 PSeries:=S;
End;

Function IBeta(A,B,X:Real):Real;
Label Done;
Var
 A1,B1,X1,T,W,Xc,Y:Real;
 Flag:Boolean;
Begin
 MathErr:=fnOk;
 If(A<=0.0)or(B<=0.0)or(X<0.0)or(X>1.0)Then Begin
  IBeta:=DefaultVal(fnDomain);
  Exit;
 End;
 If(X=0.0)or(X=1.0)Then Begin
  IBeta:=X;
  Exit;
 End;
 Flag:=False;
 If(B*X<=1.0)and(X<=0.95)Then Begin
  T:=PSeries(A,B,X);
  Goto Done;
 End;
 W:=1.0-X;
  { Inverse A et B si X est sup‚rieur … celui-ci }
 If X>A/(A+B)Then Begin
  Flag:=True;
  A1:=B;
  B1:=A;
  Xc:=X;
  X1:=W;
 End
  Else
 Begin
  A1:=A;
  B1:=B;
  Xc:=W;
  X1:=X;
 End;
 If(Flag)and(B1*X1<=1.0)and(X1<=0.95)Then Begin
  T:=PSeries(A1,B1,X1);
  Goto Done;
 End;
  { Choisie l'expension pour la convergence optimal }
 Y:=X1*(A1+B1-2.0)-(A1-1.0);
 If Y<0.0Then W:=CFrac1(A1,B1,X1)
         Else W:=CFrac2(A1,B1,X1)/Xc;
  { Multiplie W par le facteur
   a      b   _             _     _
  x  (1-x)   | (a+b) / ( a | (a) | (b) ) }
 Y:=A1*Ln(X1);
 T:=B1*Ln(Xc);
 If(A1+B1<MaxGam)and(Abs(Y)<MaxLog)and(Abs(T)<MaxLog)Then Begin
  T:=Power(Xc,B1);
  T:=T*Power(X1,A1);
  T:=T/A1;
  T:=T*W;
  T:=T*Gamma(A1+B1)/(Gamma(A1)*Gamma(B1));
 End
  Else
 Begin
   { Resort pour logarithmes }
  Y:=Y+T+LnGamma(A1+B1)-LnGamma(A1)-LnGamma(B1)+Ln(W/A1);
  If(Y<MinLog)Then T:=0.0
              Else T:=Exp(Y);
 End;
Done:
 If(Flag)Then
  If(T<=MACHEP)Then T:=1.0-MACHEP
               Else T:=1.0-T;

 IBeta:=T;
End;

Function SgnGamma(X:Real):Integer;Begin
 If X>0.0Then SgnGamma:=1 Else
 If Odd(Trunc(Abs(X)))Then SgnGamma:=1
                      Else SgnGamma:=-1;
End;

{ Formule Stirling pour la fonction Gamma.
   Gamma(x) = Sqrt(2*Pi) x^(x-.5) exp(-x) (1 + 1/x P(1/x))
  O— P(x) est un polynome
}

Function Stirf(X:Real):Real;
Const
 STIR:TabCoef=(
    7.147391378143610789273E-4,
  - 2.363848809501759061727E-5,
  - 5.950237554056330156018E-4,
    6.989332260623193171870E-5,
    7.840334842744753003862E-4,
  - 2.294719747873185405699E-4,
  - 2.681327161876304418288E-3,
    3.472222222230075327854E-3,
    8.333333333333331800504E-2,
    0);
Var
 W,P:Real;
Begin
 W:=1.0/X;
 If X>1024.0Then Begin
  P:=6.97281375836585777429E-5*W+7.84039221720066627474E-4;
  P:=P*W-2.29472093621399176955E-4;
  P:=P*W-2.68132716049382716049E-3;
  P:=P*W+3.47222222222222222222E-3;
  P:=P*W+8.33333333333333333333E-2;
 End
  Else
 P:=PolEvl(W,STIR,8);
 Stirf:=SQRT2PI*Exp((X-0.5)*Ln(X)-X)*(1.0+W*P);
End;

 { Approximation de Ln(Gamma) par la formule de Stirling, pour X >= 13 }
Function StirfL(X:Real):Real;
Const
 P:TabCoef=(
    4.885026142432270781165E-3,
  - 1.880801938119376907179E-3,
    8.412723297322498080632E-4,
  - 5.952345851765688514613E-4,
    7.936507795855070755671E-4,
  - 2.777777777750349603440E-3,
    8.333333333333331447505E-2,
    0, 0, 0);
Var
 Q,W:Real;
Begin
 Q:=Ln(X)*(X-0.5)-X;
 Q:=Q+LNSQRT2PI;
 If X>1.0E+10Then StirfL:=Q
  Else
 Begin
  W:=1.0/Sqr(X);
  StirfL:=Q+PolEvl(W,P,6)/X;
 End;
End;

Function Binomial(N,K:Integer):Real;
Var
 I,N1:Integer;
 Prod:Real;
Begin
 MathErr:=fnOk;
 If K<0Then Binomial:=0.0 Else
 If(K=0)or(K=N)Then Binomial:=1.0 Else
 If(K=1)or(K=N-1)Then Binomial:=N
  Else
 Begin
  If(K>N-K)Then K:=N-K;
  N1:=Succ(N);
  Prod:=N;
  For I:=2to(K)do Prod:=Prod*(System.Int(N1-I)/System.Int(I));
  Binomial:=System.Int(0.5+Prod);
 End;
End;

Function PBinom(N:Integer;P:Real;K:Integer):Real;Near;Begin
 MathErr:=fnOk;
 If(P<0.0)or(P>1.0)or(N<=0)or(N<K)Then PBinom:=DefaultVal(fnDomain)Else
 If K=0Then PBinom:=IntPower(1.0-P,N)Else
 If(K=N)Then PBinom:=IntPower(P,N)
        Else PBinom:=Binomial(N,K)*IntPower(P,K)*IntPower(1.0-P,N-K);
End;

Function FBinom(N:Integer;P:Real;K:Integer):Real;Near;Begin
 MathErr:=fnOk;
 If(P<0.0)or(P>1.0)or(N<=0)or(N<K)Then FBinom:=DefaultVal(fnDomain)Else
 If K=0Then FBinom:=IntPower(1.0-P,N)Else
 If(K=N)Then FBinom:=1.0
        Else FBinom:=1.0-IBeta(K+1,N-K,P);
End;

Function PPoisson(Mu:Real;K:Integer):Real;
Var
 P:Real;
 I:Integer;
Begin
 MathErr:=fnOk;
 If(Mu<=0.0)or(K<0)Then PPoisson:=DefaultVal(fnDomain)Else
 If K=0Then PPoisson:=Expo(-Mu)
  Else
 Begin
  P:=Mu;
  For I:=2to(K)do P:=P*Mu/I;
  PPoisson:=Expo(-Mu)*P;
 End;
End;

Function FPoisson(Mu:Real;K:Integer):Real;Begin
 MathErr:=fnOk;
 If(Mu<=0.0)or(K<0)Then FPoisson:=DefaultVal(fnDomain)Else
 If K=0Then FPoisson:=Expo(-Mu)
       Else FPoisson:=JGamma(K+1,Mu);
End;

Function DStudent(Nu:Integer;X:Real):Real;Near;
Var
 L,P,Q:Real;
Begin
 MathErr:=fnOk;
 If Nu<1Then DStudent:=DefaultVal(fnDomain)
  Else
 Begin
  P:=0.5*(Nu+1);
  Q:=0.5*Nu;
  L:=LnGamma(P)-LnGamma(Q)-0.5*Ln(Nu*PI)-P*Ln(1.0+Sqr(X)/Nu);
  DStudent:=Expo(L);
 End;
End;

Function FStudent(Nu:Integer;X:Real):Real;Near;Begin
 MathErr:=fnOk;
 If Nu<1Then FStudent:=DefaultVal(fnDomain)
        Else FStudent:=1.0-IBeta(0.5*Nu,0.5,Nu/(Nu+Sqr(X)));
End;

Function PStudent(Nu:Integer;X:Real):Real;Near;Begin
 MathErr:=fnOk;
 If Nu<1Then PStudent:=DefaultVal(fnDomain)
        Else PStudent:=IBeta(0.5*Nu,0.5,Nu/(Nu+Sqr(X)));
End;

Function DKhi2(Nu:Integer;X:Real):Real;Near;Begin
 MathErr:=fnOk;
 DKhi2:=DGamma(0.5*Nu,0.5,X);
End;

Function FKhi2(Nu:Integer;X:Real):Real;Near;Begin
 MathErr:=fnOk;
 If(Nu<1)or(X<=0.0)Then FKhi2:=DefaultVal(fnDomain)
                   Else FKhi2:=IGamma(0.5*Nu,0.5*X);
End;

Function PKhi2(Nu:Integer;X:Real):Real;Near;Begin
 MathErr:=fnOk;
 If(Nu<1)or(X<=0.0)Then PKhi2:=DefaultVal(fnDomain)
                   Else PKhi2:=JGamma(0.5*Nu,0.5*X);
End;

  (************************************************************)
  (*                   Fonctions financiŠre                   *)
  (************************************************************)

Function Term(Payment,Taux,FutureValue:Real):Real;Near;Begin
 Term:=Ln(1+FutureValue/(Taux*Payment))/Ln(1+Taux);
End;

Function DDB(Cost,Salvage,Life,Period:Real):Real;Near;
Var
 X:Real;
 N:Integer;
Begin
 X:=0;N:=0;
 While(Period>N)do begin
  X:=2*Cost/Life;
  If(Cost-X)<Salvage Then X:=Cost-Salvage;
  If X<0Then X:=0;
  Cost:=Cost-X;
  Inc(N);
 End;
 DDB:=X;
End;

Function Rate(FutureValue,PresentValue:Real;Term:Byte):Real;Near;Begin
 Rate:=Power(FutureValue/PresentValue,1/Term)-1;
End;

Function FV(Pmt,Rate,Nper:Real):Real;Near;Begin
 If Abs(Rate)>1E-6Then FV:=Pmt*(Exp(NPer*Ln(1+Rate))-1)/Rate
                  Else FV:=Pmt*NPer*(1+(NPer-1)*Rate/2);
End;

Function FVal(Rate,Nper,Pmt,PV,PType:Real):Real;Near;
Var
 F:Real;
Begin
 F:=Exp(NPer*Ln(1+Rate));
 If Abs(Rate)<1E-6Then
  FVal:=-Pmt*Nper*(1+(Nper-1)*Rate/2)*(1+Rate*PType)-PV*F
 Else
  FVal:=Pmt*(1-F)*(1/Rate+PType)-PV*F;
End;

Function PV(Pmt,Rate,Nper:Real):Real;Near;Begin
 If Abs(Rate)>1E-6Then PV:=Pmt*(1-Exp(-NPer*ln(1+Rate)))/Rate
                  Else PV:=Pmt*NPer*(1+(NPer-1)*Rate/2)/(1+NPer*Rate)
End;

Function PVal(Rate,NPer,Pmt,FV,PType:Real):Real;Near;
Var
 F:Real;
Begin
 If Abs(Rate)>1E-6Then Begin
  F:=Exp(NPer*Ln(1+Rate));
  PVal:=(Pmt*(1/Rate+PType)*(1-F)-FV)/F;
 End
  Else
 PVal:=-(Pmt*(1+Rate*PType)*NPer+FV)/(1+NPer*Rate)
End;

Function Paymt(Rate,NPer,PV,FV,PType:Real):Real;Near;
Var
 F:Real;
Begin
 F:=Exp(Nper*Ln(1+Rate));
 Paymt:=(FV+PV*F)*Rate/((1+Rate*PType)*(1-F));
End;

Function NPer(Rate,Pmt,PV,FV,PType:Real):Real;Near;
Var
 F:Real;
Begin
 F:=Pmt*(1+Rate*PType);
 If Abs(Rate)>1E-6Then NPer:=Ln((F-Rate*FV)/(PV*Rate+F))/Ln(1+Rate)
                  Else NPer:=-(FV+PV)/(PV*Rate+F);
End;

Function IPAYMT(Rate,Per,NPer,PV,FV,PType:Real):Real;Near;Begin
 IPayMt:=Rate*FVal(Rate,Per-PType-1,PayMt(Rate,NPer,PV,FV,PType),PV,PType);
End;

Function PPaymt(Rate,Per,NPer,PV,FV,PType:Real):Real;Near;
Var
 F:Real;
Begin
 F:=Paymt(Rate,NPer,PV,FV,PType);
 PPaymt:=F-Rate*FVal(Rate,Per-PType-1,F,PV,PType);
End;

Function IRate(NPer,Pmt,PV,FV,PType:Real):Real;Near;
Var
 Rate,x0,x1,y0,y1:Real;

 Function Y:Real;
 Var
  F:Real;
 Begin
  If Abs(Rate)<1E-6Then Y:=PV*(1+NPer*Rate)+Pmt*(1+Rate*PType)*NPer+FV
   Else
  Begin
   F:=Exp(NPer*ln(1+Rate));
   Y:=PV*F+Pmt*(1/Rate+PType)*(F-1)+FV;
  End;
 End;

Begin
 Rate:=0;
 y0:=pv+pmt*nper+fv;
 x0:=Rate;
 rate:=exp(1/nper)-1;
 y1:=y;
 x1:=Rate;
 While Abs(y0-y1)>1E-6do Begin
  Rate:=(y1*x0-y0*x1)/(y1-y0);
  x0:=x1;
  x1:=Rate;
  y0:=y1;
  y1:=y;
 End;
 IRate:=Rate;
End;

Function CleanString(Const Str:String):String;Near;
Var
 Target:String;
 I:Byte;
Begin
 Target:='';
 For I:=1to Length(Str)do Begin
  If Str[I]in[' '..#126]Then IncStr(Target,Str[I]);
 End;
 CleanString:=Target;
End;

  (************************************************************)
  (*                   Fonctions de temps                     *)
  (************************************************************)

Function Temps(Heure,Minute,Seconde:Real):Real;Near;Begin
 Temps:=(Heure*3600+Minute*60+Seconde)/86400;
End;

Function Heure(Temps:Real):LongInt;Near;Begin
 Heure:=Trunc((86400*Temps)/3600);
End;

Function Minute(Temps:Real):LongInt;Near;Begin
 Minute:=Trunc(((86400*Temps)/60))mod 60;
End;

Function Seconde(Temps:Real):LongInt;Near;Begin
 Seconde:=Trunc(86400*Temps)mod 60;
End;

Function Cot(Value:Real):Real;Near;
Var
 X:Real;
Begin
 X:=Tan(Value);
 If X=0.0Then Cot:=0.0
         Else Cot:=1/X;
End;

Function ArcCot(Value:Real):Real;Near;
Var
 X:Real;
Begin
 If Value=0.0Then X:=0.0
             Else X:=1/Value;
 ArcCot:=ArcTan(X);
End;

Function ToHex(X:Real;Num:Byte):String;Near;
Var
 S:String;
Begin
 S:=HexLong2Str(Trunc(X));
 While StrI(1,S)='0'do S:=DelStr(S,1,1);
 If S=''Then S:='0';
 If(Length(S)<Num)Then S:=MultChr('0',Num-Length(S))+S;
 ToHex:=S;
End;

Function OctLong2Str(X:LongInt):String;Near;
Var
 I:Byte;
 Result:String;
Begin
 Result[0]:=#11;
 For I:=0to 10do Begin
  Result[11-I]:=Chr(((X shr(I*3))and 7)+Byte('0'));
 End;
 OctLong2Str:=Result;
End;

Function ToOct(X:Real;Num:Byte):String;Near;
Var
 S:String;
Begin
 S:=OctLong2Str(Trunc(X));
 While StrI(1,S)='0'do S:=DelStr(S,1,1);
 If S=''Then S:='0';
 If(Length(S)<Num)Then S:=MultChr('0',Num-Length(S))+S;
 ToOct:=S;
End;

Function Tab2Str(X:LongInt):String;Near;
Var
 S:String;
Begin
 Inc(X);
 If X>9999Then Begin
  S:=IntToStr((Word(X)mod 10000)*10000);
  If Wd(X)mod 10000>0Then IncStr(S,'+');
 End
  Else
 S:='';
 AddStr(S,Left(MultChr('M',(Wd(X)mod 10000)div 1000),9));
 Case(Wd(X)mod 1000)div 100of
  9: AddStr(S,'CM');
  8: AddStr(S,'DCCC');
  7: AddStr(S,'DCC');
  6: AddStr(S,'DC');
  5: IncStr(S,'D');
  4: AddStr(S,'CD');
  3: AddStr(S,'CCC');
  2: AddStr(S,'CC');
  1: IncStr(S,'C');
 End;
 Case(Wd(X)mod 100)div 10of
  9: AddStr(S,'XC');
  8: AddStr(S,'LXXX');
  7: AddStr(S,'LXX');
  6: AddStr(S,'LX');
  5: IncStr(S,'L');
  4: AddStr(S,'XL');
  3: AddStr(S,'XXX');
  2: AddStr(S,'XX');
  1: IncStr(S,'X');
 End;
 Case Wd(X)mod 10of
  9: AddStr(S,'IX');
  8: AddStr(S,'VIII');
  7: AddStr(S,'VII');
  6: AddStr(S,'VI');
  5: IncStr(S,'V');
  4: AddStr(S,'IV');
  3: AddStr(S,'III');
  2: AddStr(S,'II');
  1: IncStr(S,'I');
 End;
 Tab2Str:=S;
End;

Function Col2Str(C:LongInt):String;Near;
Var
 S:String[6];
Begin
 Inc(C);
 If C>308915802Then S:=Char(Byte('A')+DivLong(C-308915803,308915776))
	       Else S:='';
 If C>11881402Then IncStr(S,Char(Byte('A')+DivLong(C-11881403,11881376)));
 If C>457002Then IncStr(S,Char(Byte('A')+DivLong(C-457003,456976)));
 If C>18278Then IncStr(S,Char(Byte('A')+DivLong(C-18279,17576)));
 If C>702Then IncStr(S,Char(Byte('A')+DivLong(Word(C-703)mod 17576,676)));
 If C>26Then IncStr(S,Char(Byte('A')+DivLong(Word(C-27)mod 676,26)));
 IncStr(S,Char(Byte('A')+(Word(C-1)mod 26)));
 Col2Str:=S;
End;

{$I \Source\Chantal\Library\HashTabl.Inc}
{$I \Source\Chantal\Library\App\Tableur\Column.Inc}
{$I \Source\Chantal\Library\App\Tableur\Cellule.Inc}

  (************************************************************)
  (*                     Routine du tableur                   *)
  (************************************************************)

Procedure SCInit;Begin
 FillClr(Q,SizeOf(Q));
 COInit(Q.Column);
 CEInit(Q.Cellule);
 Q.BX1:=-1;
 Q.BY1:=-1;
 Q.BX2:=-1;
 Q.BY2:=-1;
 Q.MovedX:=True;
 Q.HomeLine:=1;
 Case(Model)of
  3: Q.Mode:=3;
  Else Q.Mode:=2;
 End;
 WEInit(Q.W,X1,Y1,X2,Y2);
 SCRefresh(Q);
End;

Function SCHeightSpreadsheet(Var Q:SuperCalcApp):Byte;Near;Begin
 SCHeightSpreadsheet:=Q.W.MaxY-(1+Byte(Q.Mode=3)+Q.HomeLine);
End;

Procedure SCRefreshSpreadSheet(Var Q:SuperCalcApp);
Var
 PX,PY:LongInt;
 I,J:Byte;
Begin
 PY:=Q.PY-Q.YS;
 For J:=0to SCHeightSpreadsheet(Q)do Begin
  PX:=Q.PX-Q.XL;
  For I:=0to Q.MaxColumnX-1do Begin
   SCPutData(Q,I,J,PX,PY,True);
   Inc(PX);
  End;
  Inc(PY);
 End;
End;

Function SCInBlock(Var Q:SuperCalcApp;X,Y:LongInt):Boolean;Near;Begin
 SCInBlock:=(Q.BX1<=X)and(Q.BX2>=X)and(Q.BY1<=Y)and(Q.BY2>=Y);
End;

Procedure SCRefreshSelected(Var Q:SuperCalcApp);Near;
Var
 PX,PY:LongInt;
 I,J:Byte;
Begin
 If(Q.BX1=-1)or(Q.BX2=-1)or(Q.BY1=-1)or(Q.BY2=-1)Then Exit;
 PY:=Q.PY-Q.YS;
 For J:=0to SCHeightSpreadsheet(Q)do Begin
  PX:=Q.PX-Q.XL;
  For I:=0to Q.MaxColumnX-1do Begin
   If SCInBlock(Q,PX,PY)Then SCPutData(Q,I,J,PX,PY,True);
   Inc(PX);
  End;
  Inc(PY);
 End;
End;

Procedure SCRefreshSpreadSheetLine(Var Q:SuperCalcApp);Near;
Var
 J:LongInt;
 H:Byte;
Begin
 WESetKr(Q.W,$B0);
 H:=1+Byte(Q.Mode=3)+Q.HomeLine;
 WESetPos(Q.W,0,H);
 For J:=Q.PY-Q.YS to Q.PY-Q.YS+(Q.W.MaxY-H)do Begin
  WEPutTxtLn(Q.W,Str2(J,10));
  WEBarSpcHorRelief(Q.W,0,Q.W.Y-1,9);
 End;
End;

Function SCGetColumnWidth(Var Q:SuperCalcApp;XL:Byte):Byte;Near;Assembler;ASM
 { Width:=Q.ColumnX[XL+1]-Q.ColumnX[XL]; }
 LES DI,Q
 MOV BL,XL
 XOR BH,BH
 MOV AX,Word Ptr ES:[DI].SuperCalcApp.ColumnX[BX]
 SUB AH,AL
 MOV AL,AH
END;

Procedure SCRefreshSpreadSheetColumn(Var Q:SuperCalcApp);Near;
Var
 J:Byte;
 PX:LongInt;
Begin
 WESetKr(Q.W,$B0);
 WESetPos(Q.W,10,Q.HomeLine+Byte(Q.Mode=3));
 SCComputeScreenColumn(Q);
 PX:=Q.PX-Q.XL;
 For J:=0to Q.MaxColumnX-1do Begin
  WEPutTxt(Q.W,CenterStr(Col2Str(PX),SCGetColumnWidth(Q,J)));
  WEBarSpcHorRelief(Q.W,Q.ColumnX[J],Q.W.Y,Q.ColumnX[J+1]-1);
  Inc(PX);
 End;
End;

Procedure SCUpdateStatusBar(Var Q:SuperCalcApp);
Var
 S:String;
Begin
 WESetEndBar(Q.W,CurrKrs.Desktop.DialStatus);
 Case(Q.FormatMode)of
  tfMGC:S:='MGC';
  tfASCII:S:='ASCII';
  tfLotus:S:='Lotus 1-2-3';
  tfQuattroPro:S:='Quattro Pro';
  tfExcel:S:='Excel';
  tfCSV:S:='CSV';
  tfHTML:S:='HTML';
  Else S:='Ind‚fini';
 End;
 WESetEndBarTxtX(Q.W,1,S,CurrKrs.Desktop.DialStatus);
 WESetEndBarTxtX(Q.W,15,Q.FileName,CurrKrs.Desktop.DialStatus);
 If(IsGrf)Then Begin
  BarSpcHorRelief(Q.W.T.X1,Q.W.T.Y2,Q.W.T.X2,CurrKrs.Desktop.DialStatus);
  BarSpcHorReliefExt(Q.W.T.X1+1,Q.W.T.Y2,Q.W.T.X1+13,CurrKrs.Desktop.DialStatus);
  BarSpcHorReliefExt(Q.W.T.X1+15,Q.W.T.Y2,Q.W.T.X2-2,CurrKrs.Desktop.DialStatus);
  LuxeBox(Q.W.T.X2-1,Q.W.T.Y2);
 End;
End;

Procedure SCRefresh;
Var
 Q:SuperCalcApp Absolute Context;
 J:Byte;
Begin
 WEPutWnKrDials(Q.W,SCTitle(Q.W,0));
 WECloseIcon(Q.W);
 WEZoomIcon(Q.W);
 WEPutBarMsRight(Q.W);
 SCUpdateStatusBar(Q);
 WESetPos(Q.W,1,0);
 WEPutCube(Q.W,'=');
 WEBarSpcHorRelief(Q.W,0,0,2);
 WESetKr(Q.W,$70);
 Case(Q.Mode)of
  3: WEPutTxtXY(Q.W,0,Q.HomeLine,'3Dimension');
Else WEPutTxtXY(Q.W,0,Q.HomeLine,'2Dimension');
 End;
 WEBarSpcHorRelief(Q.W,0,1,9);
 SCRefreshSpreadSheetColumn(Q);
 SCRefreshSpreadSheetLine(Q);
 SCRefreshSpreadSheet(Q);
 SCPutSelect(Q);
 PutMemory;
End;

Procedure FreeVariant(Var Q:Variant);Near;Begin
 If(Q.TypeDef=dtString)Then Begin
  FreeMemory(Q.X.DataPString,Length(Q.X.DataPString^)+1);
  Q.TypeDef:=dtEnum;
 End;
End;

Procedure CopyString2Variant(Var Q:Variant;Const Str:String);Near;Begin
 FreeVariant(Q);
 Q.X.DataPString:=MemAlloc(Length(Str)+1);
 If(Q.X.DataPString<>NIL)Then Begin
  Q.X.DataPString^:=Str;
  Q.TypeDef:=dtString;
 End;
End;

Function GetCodeMainWordPas(Const Oper:String):Word;Near;Begin
 If Oper='AND'Then GetCodeMainWordPas:=cmwpAnd Else
 If Oper='DIV'Then GetCodeMainWordPas:=cmwpDiv Else
 If Oper='OR'Then GetCodeMainWordPas:=cmwpOr Else
 If Oper='MOD'Then GetCodeMainWordPas:=cmwpMod Else
 If Oper='NOT'Then GetCodeMainWordPas:=cmwpNot Else
 If Oper='SHL'Then GetCodeMainWordPas:=cmwpShl Else
 If Oper='SHR'Then GetCodeMainWordPas:=cmwpShr Else
 If Oper='XOR'Then GetCodeMainWordPas:=cmwpXor
              Else GetCodeMainWordPas:=$FFFF;
End;

Type
 FuncDataSetRec=Record
  ID:Word;
  Buffer:Array[0..4095]of Byte;
 End;

Function GetCodeFunc(Const Name:String;Var Param:String):Word;Near;
Var
 Data:FuncDataSetRec;
 PStr:^String;
Begin
 DBOpenServerName(ChantalServer,'CHANTAL:/Math/Calc.Dat');
 If DBLocateAbs(ChantalServer,2,Name,[])Then Begin
  DBReadRec(ChantalServer,Data);
  GetCodeFunc:=Data.ID;
  PStr:=@Data;
  DBGotoColumnAbs(ChantalServer,3,Pointer(PStr));
  Param:=PStr^;
 End
  Else
 GetCodeFunc:=$FFFF;
End;

Function SCGetCurrCellule(Var Q:SuperCalcApp):PCellule;Begin
 SCGetCurrCellule:=CESearch(Q.Cellule,Q.PX,Q.PY);
End;

Function SCGetCellule(Var Q:SuperCalcApp;PX,PY:LongInt):PCellule;Begin
 SCGetCellule:=CESearch(Q.Cellule,PX,PY);
End;

Function Carree(R:Real):Real;Near;Begin
 Carree:=R*R;
End;

Function SCGetCelluleSum(Var Q:SuperCalcApp;X1,Y1,X2,Y2:LongInt;Operation:Word):Real;Near;
Var
 X:Real;        { R‚sultat accumul‚ }
 Moyenne:Real;  { Moyenne des cellules }
 V:Real;        { Valeur de la cellule }
 IL,JL:LongInt; { Compteur de boucle }
 N:LongInt;     { Nombre d'‚l‚ments }
 PC:PCellule;   { Pointeur sur la cellule en v‚rification }
Begin
 X:=0.0;N:=0;
 Case(Operation)of
  cmfpVar,cmfpVars,
  cmfpEcartTypeP,cmfpVarP:Moyenne:=SCGetCelluleSum(Q,X1,Y1,X2,Y2,cmfpMoyenne);
  cmfpProduit:X:=1.0;
 End;
 For JL:=Y1 to(Y2)do For IL:=X1 to(X2)do Begin
  PC:=SCGetCellule(Q,IL,JL);
  If(PC=NIL)Then V:=0.0
   Else
  Case(PC^.Header.Format)of
   cfFormula:V:=PC^.Data.f.Value;
   cfValue:V:=PC^.Data.v.Value;
  End;
  Case(Operation)of
   cmfpVar,cmfpVars,
   cmfpEcartTypeP,cmfpVarP:X:=X+Carree(V-Moyenne);
   cmfpProduit:X:=X*V;
   Else X:=X+V;
  End;
  Inc(N);
 End;
 Case(Operation)of
  cmfpVar,cmfpVars,
  cmfpMoyenne,cmfpEcartTypeP,cmfpVarP:Begin
   If N=0Then X:=0.0 Else
   If(Operation=cmfpVars)Then X:=X/(N-1)
                         Else X:=X/N;
   If(Operation=cmfpEcartTypeP)Then X:=Sqrt(X);
  End;
 End;
 SCGetCelluleSum:=X;
End;

Function _SCGetCelluleSum(Var Q:SuperCalcApp;Const X:Variant;Operation:Word):Real;Near;Begin
 _SCGetCelluleSum:=SCGetCelluleSum(Q,X.X.CelX1,X.X.CelY1,X.X.CelX2,X.X.CelY2,Operation);
End;

Function SCGetFirstCelluleString(Var Q:SuperCalcApp;X1,Y1,X2,Y2:LongInt):String;Near;
Var
 IL,JL:LongInt; { Compteur de boucle }
 PC:PCellule;   { Pointeur sur la cellule en v‚rification }
Begin
 SCGetFirstCelluleString:='';
 For JL:=Y1 to(Y2)do For IL:=X1 to(X2)do Begin
  PC:=SCGetCellule(Q,IL,JL);
  If(PC<>NIL)Then Case(PC^.Header.Format)of
   cfText:Begin
    SCGetFirstCelluleString:=PC^.Data.t.Text;
    Exit;
   End;
{   cfFormula:Begin
    ...
   End;}
  End;
 End;
End;

Function Str2Col(S:String;MaxCols:Word):Word;Near;
Var
 L:Byte;
 C:LongInt;
Begin
 Str2Col:=0;L:=Length(S);
 If L=0Then Exit;
 S:=StrUp(S);
 For C:=1to(L)do If Not(S[C]in ['A'..'Z'])Then Begin
  L:=Pred(C);
  Break;
 End;
 C:=Byte(S[L])-Byte('@');
 If L>1Then Inc(C,(Byte(S[Pred(L)])-Byte('@'))*26);
 If L>2Then Inc(C,(Byte(S[L-2])-Byte('@'))*676);
 If L>3Then Inc(C,LongInt(Byte(S[L-3])-Byte('@'))*17576);
 If L>4Then Inc(C,LongInt(Byte(S[L-4])-Byte('@'))*456976);
 If L>5Then Inc(C,LongInt(Byte(S[L-5])-Byte('@'))*11881376);
 If(C>MaxCols)Then Exit;
 Str2Col:=Pred(C);
End;

Function Str2Row(Const S:String;MaxRows:Word):Word;Near;
Var
 R:LongInt;
 Err:Integer;
 I:Byte;
Begin
 Str2Row:=0;
 If S=''Then Exit;
 For I:=1to Length(S)do If S[I]in['0'..'9']Then Break;
 Val(Copy(S,I,255),R,Err);
 If(Err=0)and(R<=MaxRows)Then Str2Row:=R;
End;

Function NomPropre(S:String):String;Near;
Var
 I:Byte;
 First:Boolean;
Begin
 First:=True;
 For I:=1to Length(S)do Begin
  If(First)Then Begin
   S[I]:=ChrUp(S[I]);
   First:=False;
  End
   Else
  S[I]:=ChrDn(S[I]);
  If Not IsRomanLetter(S[I])Then First:=True;
 End;
 NomPropre:=S;
End;

{ Cette fonction indique si la chaŒne de caractŠres correspond … une cellule.
}

Function IsCellule(Const S:String):Boolean;Near;
Var
 I:Byte;
Begin
 IsCellule:=False;
 If S=''Then Exit;
 I:=1;
 If S[I]='$'Then Inc(I);
 While I<=Length(S)do Begin
  If S[I]in['0'..'9']Then Break;
  If Not(S[I]in['A'..'Z','a'..'z'])Then Exit;
  Inc(I);
 End;
 If S[I]='$'Then Inc(I);
 If Not(S[I]in['0'..'9'])Then Exit;
 While I<=Length(S)do Begin
  If Not(S[I]in['0'..'9'])Then Break;
  Inc(I);
 End;
 IsCellule:=True;
End;

Function SCGetCelluleName(Var Q:SuperCalcApp;Const Name:String):PCellule;Near;
Var
 X,Y:LongInt;
Begin
 X:=Str2Col(Name,$FFFF);
 Y:=Str2Row(Name,$FFFF);
 SCGetCelluleName:=SCGetCellule(Q,X,Y);
End;

Function Right(Const S:String;Num:Byte):String;Near;Begin
 If(Length(S)<=Num)Then Right:=S
                   Else Right:=Copy(S,Length(S)-Num+1,Num);
End;

Function MultStr(Const S:String;Num:Byte):String;Near;
Var
 T:String;
 I:Integer;
Begin
 T:='';
 For I:=0to Num-1do Begin
  AddStr(T,S);
 End;
 MultStr:=T;
End;

Function CountNotEmpty(Var Q:SuperCalcApp;Const Block:Variant):LongInt;Near;
Var
 PC:PCellule;   { Pointeur sur une cellule }
 Count:LongInt; { Compte le nombre de cellule non-vide }
 JL,IL:LongInt; { Compteur de boucle }
Begin
 Count:=0;
 For JL:=Block.X.CelY2 downto(Block.X.CelY1)do
  For IL:=Block.X.CelX2 downto(Block.X.CelX1)do Begin
   PC:=SCGetCellule(Q,IL,JL);
   If(PC<>NIL)Then Begin
    If(PC^.Header.Format<>cfEmpty)Then Inc(Count);
   End;
  End;
 CountNotEmpty:=Count;
End;

Function HLookUp(Var Q:SuperCalcApp;Inferieur:Real;Const Block:Variant;Line:Word):Real;Near;
Var
 PC1:PCellule; { Pointeur sur une cellule }
 IL:LongInt;   { Compteur de boucle }
Begin
 For IL:=Block.X.CelX1 to(Block.X.CelX2)do Begin
  PC1:=SCGetCellule(Q,IL,Block.X.CelY1);
  If(PC1<>NIL)Then Begin
   Case(PC1^.Header.Format)of
    cfFormula:If(PC1^.Data.f.Value>Inferieur)Then Break;
    cfValue:If(PC1^.Data.v.Value>Inferieur)Then Break;
   End;
  End;
 End;
 If(IL=Block.X.CelX1)Then HLookUp:=-1.0
  Else
 Begin
  PC1:=SCGetCellule(Q,IL-1,Block.X.CelY1+Line);
  Case(PC1^.Header.Format)of
   cfFormula:HLookUp:=PC1^.Data.f.Value;
   cfValue:HLookUp:=PC1^.Data.v.Value;
   Else HLookUp:=0.0;
  End;
 End;
End;

Function VLookUp(Var Q:SuperCalcApp;Inferieur:Real;Const Block:Variant;Colonne:Word):Real;Near;
Var
 PC1:PCellule; { Pointeur sur une cellule }
 JL:LongInt;   { Compteur de boucle }
Begin
 For JL:=Block.X.CelY1 to Block.X.CelY2+1do Begin
  PC1:=SCGetCellule(Q,Block.X.CelX1,JL);
  If(PC1<>NIL)Then Begin
   Case(PC1^.Header.Format)of
    cfFormula:If(PC1^.Data.f.Value>Inferieur)Then Break;
    cfValue:If(PC1^.Data.v.Value>Inferieur)Then Break;
   End;
  End;
 End;
 If(JL=Block.X.CelY1)Then VLookUp:=-1.0
  Else
 Begin
  PC1:=SCGetCellule(Q,Block.X.CelX1+Colonne,JL-1);
  Case(PC1^.Header.Format)of
   cfFormula:VLookUp:=PC1^.Data.f.Value;
   cfValue:VLookUp:=PC1^.Data.v.Value;
   Else VLookUp:=0.0;
  End;
 End;
End;

Function ProdScal(Var Q:SuperCalcApp;Const Block1,Block2:Variant):Real;Near;
Var
 PC1,PC2:PCellule; { Pointeur sur une cellule }
 JL,IL:LongInt;    { Compteur de boucle }
 V1,V2:Real;       { Les deux valeurs des cellules }
 Total:Real;       { Somme total }
Begin
 Total:=0.0;
 For JL:=Block1.X.CelY2 downto(Block1.X.CelY1)do
  For IL:=Block1.X.CelX2 downto(Block1.X.CelX1)do Begin
   PC1:=SCGetCellule(Q,IL,JL);
   PC2:=SCGetCellule(Q,IL-Block1.X.CelX1+Block2.X.CelX1,
                       JL-Block1.X.CelY1+Block2.X.CelY1);
   If(PC1<>NIL)and(PC2<>NIL)Then Begin
    Case(PC1^.Header.Format)of
     cfFormula:V1:=PC1^.Data.f.Value;
     cfValue:V1:=PC1^.Data.v.Value;
     Else V1:=0.0;
    End;
    Case(PC2^.Header.Format)of
     cfFormula:V2:=PC2^.Data.f.Value;
     cfValue:V2:=PC2^.Data.v.Value;
     Else V2:=0.0;
    End;
    Total:=Total+(V1*V2);
   End;
  End;
 ProdScal:=Total;
End;

Procedure QSortReal(Var Tableau;L,R:Word);Near;
Var
 X:^TReal Absolute Tableau;
 I,J:Integer;
 U,V:Real;
Begin
 I:=L;
 J:=R;
 U:=X^[(L+R)shr 1];
 Repeat
  While X^[I]<U do Inc(I);
  While U<X^[J]do Dec(J);
  If(I<=J)Then Begin
   V:=X^[I];
   X^[I]:=X^[J];
   X^[J]:=V;
   Inc(I);
   Dec(J);
  End;
 Until I>J;
 If(L<J)Then QSortReal(Tableau,L,J);
 If(I<R)Then QSortReal(Tableau,I,R);
End;

Function Mediane(Var Q:SuperCalcApp;Const Block:Variant):Real;Near;
Var
 Tableau:^TReal;
 NumElement,N2:Word;
 SizeTab:Word;
 PC:PCellule;        { Pointeur sur une cellule }
 JL,IL,I:LongInt;    { Compteur de boucle }
 V:Real;             { Nombre r‚el }
Begin
 NumElement:=(Block.X.CelX2-Block.X.CelX1+1)*(Block.X.CelY2-Block.X.CelY1+1);
 SizeTab:=NumElement*SizeOf(Real);
 Tableau:=MemAlloc(SizeTab);
 If(Tableau<>NIL)Then Begin
  I:=0;
  For JL:=Block.X.CelY2 downto(Block.X.CelY1)do
   For IL:=Block.X.CelX2 downto(Block.X.CelX1)do Begin
    PC:=SCGetCellule(Q,IL,JL);
    V:=0.0;
    If(PC<>NIL)Then Begin
     Case(PC^.Header.Format)of
      cfFormula:V:=PC^.Data.f.Value;
      cfValue:V:=PC^.Data.v.Value;
     End;
    End;
    Tableau^[I]:=V;
    Inc(I);
    If(I>=NumElement)Then Break;
   End;
  QSortReal(Tableau,0,NumElement-1);
  N2:=NumElement shr 1;
  If Odd(NumElement)Then Mediane:=Tableau^[N2]
                    Else Mediane:=0.5*(Tableau^[N2]+Tableau^[N2-1]);
  FreeMemory(Tableau,SizeTab);
 End
  Else
 Mediane:=0.0;
End;

Function IRR(Var Q:SuperCalcApp;Guess:Real;Const Block:Variant):Real;Near;
Var
 PC:PCellule;   { Pointeur sur une cellule }
 ORate,Rate:Real;

 Function DRate(Rate:Real):Real;
 Var
  NPV,NPVPrime,BlockValueI:Real;
  I,JL,IL:LongInt;
 Begin
  NPV:=0;
  NPVPrime:=0;
  Rate:=1/(1+Rate);
  For JL:=Block.X.CelY2 downto(Block.X.CelY1)do
   For IL:=Block.X.CelX2 downto(Block.X.CelX1)do Begin
    PC:=SCGetCellule(Q,IL,JL);
    I:=JL*(Block.X.CelX2-Block.X.CelX1+1)+IL;
    Case(PC^.Header.Format)of
     cfFormula:Begin
      BlockValueI:=PC^.Data.f.Value;
      NPV:=NPV*Rate+BlockValueI;
      NPVPrime:=(NPVPrime+BlockValueI*I)*Rate;
     End;
     cfValue:Begin
      BlockValueI:=PC^.Data.v.Value;
      NPV:=NPV*Rate+BlockValueI;
      NPVPrime:=(NPVPrime+BlockValueI*I)*Rate;
     End;
    End;
   End;
  If Abs(NPVPrime)<1E-6Then DRate:=NPV*1E-6
                       Else DRate:=NPV/NPVPrime;
 End;

Begin
 ORate:=Guess;
 Rate:=ORate+DRate(ORate);
 While Abs(Rate-ORate)>1E-6do Begin
   { Trouve la racine de Newton-Raphson }
  ORate:=Rate;
  Rate:=Rate+DRate(Rate);
  If(NxtKey=kbEsc)Then Begin
   ReadKey;
   Break;
  End;
 End;
 IRR:=Rate;
End;

Function Adresse(A,B:LongInt;Format:Word;A1:Boolean):String;Near;
Var
 Result:String;
Begin
 Result:='';
 Case(Format)of
  2:If Not(A1)Then Result:='L';
  3:If(A1)Then Result:='$'
          Else Result:='L(';
  4:If Not(A1)Then Result:='L(';
  Else Begin
   If(A1)Then Result:='$'
         Else Result:='L';
  End;
 End;
 If(A1)Then AddStr(Result,Col2Str(B-1))
       Else AddStr(Result,IntToStr(A));
 Case(Format)of
  2:If(A1)Then IncStr(Result,'$')
          Else AddStr(Result,'C(');
  3:If Not(A1)Then AddStr(Result,')C');
  4:If Not(A1)Then AddStr(Result,')C(');
  Else Begin
   If(A1)Then IncStr(Result,'$')
         Else IncStr(Result,'C');
  End;
 End;
 If(A1)Then AddStr(Result,IntToStr(A))
       Else AddStr(Result,IntToStr(B));
 If((Format)in[2,4])and Not(A1)Then IncStr(Result,')');
 Adresse:=Result;
End;

(*Function Adresse(A,B:LongInt;Format:Word;A1:Boolean):String;Near;
Var
 Result:^String;
Begin
 ASM
  MOV SP,BP
  PUSH SS
  PUSH WORD PTR @RESULT
 END;
 Result^:='';
 Case(Format)of
  2:If Not(A1)Then Result^:='L';
  3:If(A1)Then Result^:='$'
          Else Result^:='L(';
  4:If Not(A1)Then Result^:='L(';
  Else Begin
   If(A1)Then Result^:='$'
         Else Result^:='L';
  End;
 End;
 If(A1)Then AddStr(Result^,Col2Str(B-1))
       Else AddStr(Result^,IntToStr(A));
 Case(Format)of
  2:If(A1)Then IncStr(Result^,'$')
          Else AddStr(Result^,'C(');
  3:If Not(A1)Then AddStr(Result^,')C');
  4:If Not(A1)Then AddStr(Result^,')C(');
  Else Begin
   If(A1)Then IncStr(Result^,'$')
         Else IncStr(Result^,'C');
  End;
 End;
 If(A1)Then AddStr(Result^,IntToStr(A))
       Else AddStr(Result^,IntToStr(B));
 If((Format)in[2,4])and Not(A1)Then IncStr(Result^,')');
End;*)

Function ExtractDate(Const S:String;Var Year:Word;Var Month,Day:Byte):Boolean;Begin
 Year:=StrToWord(Copy(S,1,4));
 Month:=StrToWord(Copy(S,6,2));
 Day:=StrToWord(Copy(S,9,2));
 ExtractDate:=True;
End;

Function DimancheDePaque(Year:Word):String;Near;
Var
 Month,Day:Byte;
Begin
 DateOfEaster(Year,Month,Day);
 DimancheDePaque:=_CStrDate(Year,Month,Day,$FFFF);
End;

Function LotusDateValue(Year:Word;Month,Day:Byte):LongInt;Near;Begin
 If Year>1900Then Dec(Year,1900);
 LotusDateValue:=Round(Year*365.264)-1+DayOfYear(Year,Month,Day);
End;

Function StrLotusDateValue(Const Date:String):LongInt;Near;
Var
 Year:Word;
 Month,Day:Byte;
Begin
 ExtractDate(Date,Year,Month,Day);
 StrLotusDateValue:=LotusDateValue(Year,Month,Day);
End;


Function SCFormuleOnWord(Var Obj;Const ThisWord:String;Var Context):Boolean;
Label
 ReadCellule,ErrorInstr,_ABS,_ACOS,_ACTUEL,_ALEAT,_AMORANN,_AMORDEG,
 _AMORLIN,_AMORT,_ANNEE,_ARRONDI,_ASIN,_ATAN,_ATAN2,_AUJOURDHUI,
 _BCOMPTE,_BMAX,_BMIN,_BMOYENNE,_BSOMME,_BSTD,_BSTDS,_BVAR,_BVARS,_C,
 _CAR,_CELLINDEX,_CELLULE,_CHAINE,_CHERCHE,_CHOIX,_CODE,_COL,_COMPTE,
 _CONSH,_CONSV,_COS,_COT,_DATE,_DATVAL,_DEBUT,_DEG,_DUREE,_DUREECOMP,
 _EGAL,_ENT,_EPURE,_ERR,_ESTCHAINE,_ESTERR,_ESTND,_ESTNUM,_EXP,
 _FAUX,_FICHIEREXISTE,_FIN,_HEURE,_HEURVAL,_HEXANUM,_INDEX,_INTERET,
 _ISAAF,_ISAPP,_JOUR,_LIGNES,_LN,_LOG10,_LONG,_MAJUSC,_MAX,_MEMDISPO,
 _MEMMEMSDISPO,_MILIEU,_MIN,_MINUSC,_MINUTE,_MOD,_MOIS,_MOYENNE,
 _N,_ND,_NOMPROPRE,_NPER,_NUMAHEX,_PI,_POINTCELL,_PRINCIPAL,_PRODSCAL,
 _RACINE,_RAD,_REMB,_REMBOUR,_REPETE,_SECONDE,_SI,_SIN,_SOMME,_STD,
 _STDS,_SUBSTITUE,_SUPRESPACE,_TAN,_TAUX,_TAUXINT,_TEMPS,_VACT,_VALACT,
 _VALEUR,_VALEUROPTION,_VALFUT,_VAN,_VAR,_VARS,_VERSION,_VFUT,_VRAI,
 _ACOSH,_ADRESSE,_ALEAENTREBORNES,_ASINH,_ATANH,_BIN2DEC,_BIN2HEX,
 _BIN2OCT,_COLONNE,_COMBIN,_ACOTH,_ASECH,_ACSCH,_COTH,_ECARTTYPEP,
 _VARP,_LOIBINOMIALE,_LOIPOISSON,_LOINORMALESTANDARD,_INFO,_LIGNE,
 _LOG,_FACT,_FACTLN,_ACOT,_LOIKHIDEUX,_LOISTUDENT,_PRODUIT,_MEDIANE,
 _ESTIMPAIR,_ESTPAIR,_LNGAMMA,_LOIGAMMAINVERSE,_LOIGAMMA,_COSH,_SINH,
 _SECH,_TANH,1,PushNumberReal,PushNumberLong,FastPushNumberLong,
 PushNumberResultReal,FastPushNumberReal,PushNumberResultLong,
 _JOURSEM,__JOUR,_STXT,__MOIS,_DIMANCHEDEPAQUE;
Var
 Q:FormulaObject Absolute Obj;
 SC:SuperCalcApp Absolute Context;
 ResultReal:Real;
 ResultLong:LongInt;
 ID:Word;
 Ok:Boolean;
 ReadParam:Array[0..7]of Boolean;
 Param:Array[0..7]of Variant;
 Params:String;
 T:String;
 Str:String;    { ChaŒne de caractŠres de travail}
 J:Integer;     { Compteur de boucle }
 PC:PCellule;   { Pointeur sur une cellule }
 IL,JL:LongInt; { Compteur de boucle pour les cellules }
 Year:Word;
 Month,Day,WeekDay:Byte;

 Function SI:Char;Begin
  SkipSpcInLn(Q.I,Q.Formula);
  SI:=StrI(Q.I,Q.Formula);
 End;

 Function XtrkString:String;
 Var
  T:String;
  EM:Boolean;
 Begin
  EM:=True;T:='';
  Case Q.Formula[Q.I]of
   '"':Begin
    Inc(Q.I);
    While(Q.Formula[Q.I]<>'"')or((Q.Formula[Q.I]='"')and(StrI(Q.I-1,Q.Formula)='\'))do Begin
     If Q.I>Length(Q.Formula)Then Exit;
     IncStr(T,Q.Formula[Q.I]);
     If((Q.Formula[Q.I]='\')and(StrI(Q.I+1,Q.Formula)='"'))Then Inc(Q.I);
     Inc(Q.I);
    End;
    If StrI(Q.I,Q.Formula)='"'Then Inc(Q.I);
   End;
   '''':Begin
    Inc(Q.I);
    While(Q.Formula[Q.I]<>'''')or((Q.Formula[Q.I]='''')and(StrI(Q.I+1,Q.Formula)=''''))do Begin
     If Q.I>Length(Q.Formula)Then Exit;
     IncStr(T,Q.Formula[Q.I]);
     If((Q.Formula[Q.I]='''')and(StrI(Q.I+1,Q.Formula)=''''))Then Inc(Q.I);
     Inc(Q.I);
    End;
   End;
  End;
  EM:=False;
  XtrkString:=T;
 End;

 Function PushVariant(Const X:Variant):Boolean;Begin
  PushVariant:=False;
  If Not FOPushNumber(Q,X)Then Exit;
  If StrI(Q.I,Q.Formula)<>')'Then Exit;
  Inc(Q.I);
  PushVariant:=True;
 End;

 Function GetNumberParam(Num:Byte):Real;Begin
  GetNumberParam:=VariantToReal(Param[Num]);
 End;

 Function PushString(Const S:String):Boolean;
 Var
  PostFixeData:PostFixeRec;
 Begin
  PushString:=False;
  PostFixeData.Operateur:=False;
  PostFixeData.Priorite:=0;
  CopyString2Variant(PostFixeData.Valeur,S);
  If Not ALAddBlock(Q.PostFixe,SizeOf(PostFixeRec),PostFixeData)Then Exit;
  If StrI(Q.I,Q.Formula)<>')'Then Exit;
  Inc(Q.I);
  PushString:=True;
 End;

Begin
 SCFormuleOnWord:=False;
 If StrI(Q.I,Q.Formula)='$'Then Begin
  T:='';
  Inc(Q.I);
  While ChrUp(Q.Formula[Q.I])in['A'..'Z']do Begin
   IncStr(T,Q.Formula[Q.I]);
   Inc(Q.I);
  End;
  If StrI(Q.I,Q.Formula)='$'Then Inc(Q.I);
  While ChrUp(Q.Formula[Q.I])in['0'..'9']do Begin
   IncStr(T,Q.Formula[Q.I]);
   Inc(Q.I);
  End;
  PC:=SCGetCelluleName(SC,T);
  Goto ReadCellule;
 End
  Else
 If(StrI(Q.I,Q.Formula)<>'(')and IsCellule(ThisWord)Then Begin { Cellule volatile? }
  PC:=SCGetCelluleName(SC,ThisWord);
ReadCellule:
  ResultReal:=0.0;
  Repeat
   If(PC<>NIL)Then Case(PC^.Header.Format)of
    cfValue:ResultReal:=PC^.Data.v.Value;
    cfFormula:ResultReal:=PC^.Data.f.Value;
    cfText:Begin
     PushString(PC^.Data.t.Text);
     Break;
    End;
   End;
   Goto FastPushNumberReal
  Until True;
 End
  Else
 Begin
  ID:=GetCodeFunc(ThisWord,Params);
  If(ID<>$FFFF)and(Params<>'')Then Begin
   FillClr(ReadParam,SizeOf(ReadParam));
   If SI='('Then Begin
    Inc(Q.I);
    For J:=1to Length(Params)do Begin
     Case Params[J]of
      'B':Begin
       If Not SCXtrkFormule(SC,Q.Formula,Q.I,Param[J-1])Then Exit;
      End;
      'C':Begin
       Param[J-1].TypeDef:=dtCellule;
       Str:=FOXtrkWord(Q);
       If Not IsCellule(Str)Then Exit;
       Param[J-1].X.CelX1:=Str2Col(Str,$FFFF);
       Param[J-1].X.CelY1:=Str2Row(Str,$FFFF);
       If StrI(Q.I,Q.Formula)in['.',':']Then Begin
        If(StrI(Q.I,Q.Formula)='.')and(StrI(Q.I+1,Q.Formula)='.')Then Inc(Q.I,2)Else
        If(StrI(Q.I,Q.Formula)=':')Then Inc(Q.I)
                                   Else Exit;
        Str:=FOXtrkWord(Q);
        If Not IsCellule(Str)Then Exit;
        Param[J-1].X.CelX2:=Str2Col(Str,$FFFF);
        Param[J-1].X.CelY2:=Str2Row(Str,$FFFF);
       End
        Else
       Begin
        Param[J-1].X.CelX2:=Param[J-1].X.CelX1;
        Param[J-1].X.CelY2:=Param[J-1].X.CelY1;
       End;
      End;
      'N':If Not SCXtrkFormule(SC,Q.Formula,Q.I,Param[J-1])Then Exit;
      'S':CopyString2Variant(Param[J-1],XtrkString);
      'V':Begin
       If StrI(Q.I,Q.Formula)in['"','''']Then CopyString2Variant(Param[J-1],XtrkString)Else
       If Not SCXtrkFormule(SC,Q.Formula,Q.I,Param[J-1])Then Exit;
      End;
      'b':Begin
       T:='';
       While Q.Formula[Q.I]in['0','1']do Begin
        IncStr(T,Q.Formula[Q.I]);
        Inc(Q.I);
       End;
       Param[J-1].TypeDef:=dtReal;
       Param[J-1].X.DataReal:=BinStr2Nm(T);
      End;
     End;
     ReadParam[J-1]:=True;
     If J<Length(Params)Then Begin
      If SI=')'Then Begin
       While J<Length(Params)do Begin
        Param[J].X.DataReal:=0.0;
        Param[J].TypeDef:=dtReal;
        Inc(J);
       End;
       Break;
      End;
      If SI<>';'Then Exit;
      Inc(Q.I);
     End;
    End;
    ResultReal:=GetNumberParam(0);
    ResultLong:=Trunc(ResultReal);
   End
    Else
   Exit;
  End;
  ASM
   MOV BX,ID
   JMP @Next
@Label:
   DW Offset ErrorInstr     { 0 }
   DW Offset _ABS           { 1 }
   DW Offset _ACOS          { 2 }
   DW Offset _ACTUEL        { 3 }
   DW Offset _ALEAT         { 4 }
   DW Offset _AMORANN       { 5 }
   DW Offset _AMORDEG       { 6 }
   DW Offset _AMORLIN       { 7 }
   DW Offset _AMORT         { 8 }
   DW Offset _ANNEE         { 9 }
   DW Offset _ARRONDI       { A }
   DW Offset _ASIN          { B }
   DW Offset _ATAN          { C }
   DW Offset _ATAN2         { D }
   DW Offset _AUJOURDHUI    { E }
   DW Offset _BCOMPTE       { F }
   DW Offset _BMAX          { 10 }
   DW Offset _BMIN          { 11 }
   DW Offset _BMOYENNE      { 12 }
   DW Offset _BSOMME        { 13 }
   DW Offset _BSTD          { 14 }
   DW Offset _BSTDS         { 15 }
   DW Offset _BVAR          { 16 }
   DW Offset _BVARS         { 17 }
   DW Offset _C             { 18 }
   DW Offset _CAR           { 19 }
   DW Offset _CELLINDEX     { 1A }
   DW Offset _CELLULE       { 1B }
   DW Offset _CHAINE        { 1C }
   DW Offset _CHERCHE       { 1D }
   DW Offset _CHOIX         { 1E }
   DW Offset _CODE          { 1F }
   DW Offset _COL           { 20 }
   DW Offset _COMPTE        { 21 }
   DW Offset _CONSH         { 22 }
   DW Offset _CONSV         { 23 }
   DW Offset _COS           { 24 }
   DW Offset _DATE          { 25 }
   DW Offset _DATVAL        { 26 }
   DW Offset _DEBUT         { 27 }
   DW Offset _DEG           { 28 }
   DW Offset _DUREE         { 29 }
   DW Offset _DUREECOMP     { 2A }
   DW Offset _EGAL          { 2B }
   DW Offset _ENT           { 2C }
   DW Offset _EPURE         { 2D }
   DW Offset _ERR           { 2E }
   DW Offset _ESTCHAINE     { 2F }
   DW Offset _ESTERR        { 30 }
   DW Offset _ESTND         { 31 }
   DW Offset _ESTNUM        { 32 }
   DW Offset _EXP           { 33 }
   DW Offset _FAUX          { 34 }
   DW Offset _FICHIEREXISTE { 35 }
   DW Offset _FIN           { 36 }
   DW Offset _HEURE         { 37 }
   DW Offset _HEURVAL       { 38 }
   DW Offset _HEXANUM       { 39 }
   DW Offset _INDEX         { 3A }
   DW Offset _INTERET       { 3B }
   DW Offset _ISAAF         { 3C }
   DW Offset _ISAPP         { 3D }
   DW Offset _JOUR          { 3E }
   DW Offset _LIGNES        { 3F }
   DW Offset _LN            { 40 }
   DW Offset _LOG10         { 41 }
   DW Offset _LONG          { 42 }
   DW Offset _MAJUSC        { 43 }
   DW Offset _MAX           { 44 }
   DW Offset _MEMDISPO      { 45 }
   DW Offset _MEMMEMSDISPO  { 46 }
   DW Offset _MILIEU        { 47 }
   DW Offset _MIN           { 48 }
   DW Offset _MINUSC        { 49 }
   DW Offset _MINUTE        { 4A }
   DW Offset _MOD           { 4B }
   DW Offset _MOIS          { 4C }
   DW Offset _MOYENNE       { 4D }
   DW Offset _N             { 4E }
   DW Offset _ND            { 4F }
   DW Offset _NOMPROPRE     { 50 }
   DW Offset _NPER          { 51 }
   DW Offset _NUMAHEX       { 52 }
   DW Offset _PI            { 53 }
   DW Offset _POINTCELL     { 54 }
   DW Offset _PRINCIPAL     { 55 }
   DW Offset _PRODSCAL      { 56 }
   DW Offset _RACINE        { 57 }
   DW Offset _RAD           { 58 }
   DW Offset _REMB          { 59 }
   DW Offset _REMBOUR       { 5A }
   DW Offset _REPETE        { 5B }
   DW Offset _SECONDE       { 5C }
   DW Offset _SI            { 5D }
   DW Offset _SIN           { 5E }
   DW Offset _SOMME         { 5F }
   DW Offset _STD           { 60 }
   DW Offset _STDS          { 61 }
   DW Offset _SUBSTITUE     { 62 }
   DW Offset _SUPRESPACE    { 63 }
   DW Offset _TAN           { 64 }
   DW Offset _TAUX          { 65 }
   DW Offset _TAUXINT       { 66 }
   DW Offset _TEMPS         { 67 }
   DW Offset _VACT          { 68 }
   DW Offset _VALACT        { 69 }
   DW Offset _VALEUR        { 6A }
   DW Offset _VALEUROPTION  { 6B }
   DW Offset _VALFUT        { 6C }
   DW Offset _VAN           { 6D }
   DW Offset _VAR           { 6E }
   DW Offset _VARS          { 6F }
   DW Offset _VERSION       { 70 }
   DW Offset _VFUT          { 71 }
   DW Offset _VRAI          { 72 }
   DW Offset ErrorInstr     { 73 }
   DW Offset ErrorInstr     { 74 }
   DW Offset _ACOSH         { 75 }
   DW Offset _ADRESSE       { 76 }
   DW Offset _ALEAENTREBORNES{77 }
   DW Offset ErrorInstr     { 78 }
   DW Offset ErrorInstr     { 79 }
   DW Offset ErrorInstr     { 7A }
   DW Offset ErrorInstr     { 7B }
   DW Offset ErrorInstr     { 7C }
   DW Offset ErrorInstr     { 7D }
   DW Offset _ASINH         { 7E }
   DW Offset _ATANH         { 7F }
   DW Offset ErrorInstr     { 80 }
   DW Offset ErrorInstr     { 81 }
   DW Offset ErrorInstr     { 82 }
   DW Offset ErrorInstr     { 83 }
   DW Offset ErrorInstr     { 84 }
   DW Offset ErrorInstr     { 85 }
   DW Offset ErrorInstr     { 86 }
   DW Offset ErrorInstr     { 87 }
   DW Offset ErrorInstr     { 88 }
   DW Offset ErrorInstr     { 89 }
   DW Offset ErrorInstr     { 8A }
   DW Offset ErrorInstr     { 8B }
   DW Offset ErrorInstr     { 8C }
   DW Offset ErrorInstr     { 8D }
   DW Offset ErrorInstr     { 8E }
   DW Offset ErrorInstr     { 8F }
   DW Offset ErrorInstr     { 90 }
   DW Offset _BIN2DEC       { 91 }
   DW Offset _BIN2HEX       { 92 }
   DW Offset _BIN2OCT       { 93 }
   DW Offset ErrorInstr     { 94 }
   DW Offset ErrorInstr     { 95 }
   DW Offset ErrorInstr     { 96 }
   DW Offset ErrorInstr     { 97 }
   DW Offset ErrorInstr     { 98 }
   DW Offset ErrorInstr     { 99 }
   DW Offset ErrorInstr     { 9A }
   DW Offset ErrorInstr     { 9B }
   DW Offset _COLONNE       { 9C }
   DW Offset ErrorInstr     { 9D }
   DW Offset _COMBIN        { 9E }
   DW Offset _ACOTH         { 9F }
   DW Offset _ASECH         { A0 }
   DW Offset _ACSCH         { A1 }
   DW Offset _COTH          { A2 }
   DW Offset _ECARTTYPEP    { A3 }
   DW Offset _VARP          { A4 }
   DW Offset _LOIBINOMIALE  { A5 }
   DW Offset _LOIPOISSON    { A6 }
   DW Offset _LOINORMALESTANDARD    { A7 }
   DW Offset _INFO          { A8 }
   DW Offset _LIGNE         { A9 }
   DW Offset _LOG           { AA }
   DW Offset _FACT          { AB }
   DW Offset _FACTLN        { AC }
   DW Offset _ACOT          { AD }
   DW Offset _LOIKHIDEUX    { AE }
   DW Offset _LOISTUDENT    { AF }
   DW Offset _PRODUIT       { B0 }
   DW Offset _MEDIANE       { B1 }
   DW Offset _ESTIMPAIR     { B2 }
   DW Offset _ESTPAIR       { B3 }
   DW Offset _LNGAMMA       { B4 }
   DW Offset _LOIGAMMAINVERSE{ B5 }
   DW Offset _LOIGAMMA      { B6 }
   DW Offset _COSH          { B7 }
   DW Offset _SINH          { B8 }
   DW Offset _SECH          { B9 }
   DW Offset _TANH          { BA }
   DW Offset _COT           { BB }
   DW Offset _JOURSEM       { BC }
   DW Offset __JOUR         { BD }
   DW Offset _STXT          { BE }
   DW Offset __MOIS         { BF }
   DW Offset _DIMANCHEDEPAQUE{C0 }
   DW Offset ErrorInstr     { C1 }
   DW Offset ErrorInstr     { C2 }
   DW Offset ErrorInstr     { C3 }
   DW Offset ErrorInstr     { C4 }
   DW Offset ErrorInstr     { C5 }
   DW Offset ErrorInstr     { C6 }
   DW Offset ErrorInstr     { C7 }
   DW Offset ErrorInstr     { C8 }
   DW Offset ErrorInstr     { C9 }
   DW Offset ErrorInstr     { CA }
   DW Offset ErrorInstr     { CB }
   DW Offset ErrorInstr     { CC }
   DW Offset ErrorInstr     { CD }
   DW Offset ErrorInstr     { CE }
   DW Offset ErrorInstr     { CF }
@Next:
   CMP BX,0CFh
   JA  ErrorInstr
   SHL BX,1
   JMP @Label.Word[BX]
  END;
_ABS:
  ResultReal:=Abs(ResultReal);
  Goto PushNumberReal;
_Acos:
  {ResultReal:=ArcCos(ResultReal);
  Goto PushNumberReal;}
  ASM
   PUSH Word Ptr ResultReal[4]
   PUSH Word Ptr ResultReal[2]
   PUSH Word Ptr ResultReal
   CALL ArcCos
   JMP PushNumberResultReal
  END;
_AcosH:
  {ResultReal:=ArcCosH(ResultReal);
  Goto PushNumberReal;}
  ASM
   PUSH Word Ptr ResultReal[4]
   PUSH Word Ptr ResultReal[2]
   PUSH Word Ptr ResultReal
   CALL ArcCosH
   JMP PushNumberResultReal
  END;
_ACot:
  {ResultReal:=ArcCot(ResultReal);
  Goto PushNumberReal;}
  ASM
   PUSH Word Ptr ResultReal[4]
   PUSH Word Ptr ResultReal[2]
   PUSH Word Ptr ResultReal
   CALL ArcCot
   JMP PushNumberResultReal
  END;
_AcotH:
  {ResultReal:=ArcCotH(ResultReal);
  Goto PushNumberReal;}
  ASM
   PUSH Word Ptr ResultReal[4]
   PUSH Word Ptr ResultReal[2]
   PUSH Word Ptr ResultReal
   CALL ArcCotH
   JMP PushNumberResultReal
  END;
_AcscH:
  {ResultReal:=ArcCscH(ResultReal);
  Goto PushNumberReal;}
  ASM
   PUSH Word Ptr ResultReal[4]
   PUSH Word Ptr ResultReal[2]
   PUSH Word Ptr ResultReal
   CALL ArcCscH
   JMP PushNumberResultReal
  END;
_Actuel:
   { A compl‚ter ... }
  Goto 1;
_Adresse:
  If Not ReadParam[3]Then Param[3].X.DataBool:=True
   Else
  Begin
   Param[3].X.DataBool:=Param[3].X.DataReal<>0.0;
  End;
  If Not PushString(Adresse(ResultLong,Trunc(GetNumberParam(1)),
                            Trunc(GetNumberParam(2)),Param[3].X.DataBool))Then Exit;
  Goto 1;
_AleaEntreBornes:
  If(GetNumberParam(1)<ResultReal)Then Exit;
  ResultLong:=Random(Trunc(GetNumberParam(1)-ResultReal))+ResultLong;
  Goto PushNumberLong;
_Aleat:
  If Not FOPushNumberReal(Q,Random(65520)/65520)Then Exit;{Ne pas utiliser PushNumber...}
  Goto 1;
_Amorann:
  ResultReal:=(ResultReal-GetNumberParam(1))*
              (GetNumberParam(2)-GetNumberParam(3)+1);
  Param[5].X.DataReal:=GetNumberParam(2)*(GetNumberParam(2)+1)/2;
  If Param[5].X.DataReal<>0.0Then
   ResultReal:=ResultReal/Param[5].X.DataReal;
  Goto PushNumberReal;
_AmorDeg:
  ResultReal:=DDB(ResultReal,GetNumberParam(1),
                  GetNumberParam(2),GetNumberParam(3));
  Goto PushNumberReal;
_Amorlin:
  ResultReal:=ResultReal-GetNumberParam(1);
  Param[4].X.DataReal:=GetNumberParam(2);
  If Param[4].X.DataReal<>0.0Then
   ResultReal:=ResultReal/Param[4].X.DataReal;
  Goto PushNumberReal;
_Amort:
  ResultReal:=IRR(SC,ResultReal,Param[1]);
  Goto PushNumberReal;
_Annee:
 ResultLong:=Trunc(ResultReal/365.264);
 Goto PushNumberLong;
_Arrondi:
  ResultLong:=Round(ResultReal);
  Goto PushNumberLong;
_ASecH:
  {ResultReal:=ArcSecH(ResultReal);
  Goto PushNumberReal;}
  ASM
   PUSH Word Ptr ResultReal[4]
   PUSH Word Ptr ResultReal[2]
   PUSH Word Ptr ResultReal
   CALL ArcSecH
   JMP PushNumberResultReal
  END;
_ASin:
  {ResultReal:=ArcSin(ResultReal);
  Goto PushNumberReal;}
 ASM
   PUSH Word Ptr ResultReal[4]
   PUSH Word Ptr ResultReal[2]
   PUSH Word Ptr ResultReal
   CALL ArcSin
   JMP PushNumberResultReal
  END;
_ASinH:
  {ResultReal:=ArcSinH(ResultReal);
  Goto PushNumberReal;}
  ASM
   PUSH Word Ptr ResultReal[4]
   PUSH Word Ptr ResultReal[2]
   PUSH Word Ptr ResultReal
   CALL ArcSinH
   JMP PushNumberResultReal
  END;
_ATan2:
  If ResultReal<>0.0Then ResultReal:=GetNumberParam(1)/ResultReal;
  {ResultReal:=ArcTan(ResultReal);
  Goto PushNumberReal;}
_ATan:
  ResultReal:=ArcTan(ResultReal);
  Goto PushNumberReal;
_ATanH:
  {ResultReal:=ArcTanH(ResultReal);
  Goto PushNumberReal;}
  ASM
   PUSH Word Ptr ResultReal[4]
   PUSH Word Ptr ResultReal[2]
   PUSH Word Ptr ResultReal
   CALL ArcTanH
   JMP PushNumberResultReal
  END;
_Aujourdhui:
  GetDate(Year,Month,Day,WeekDay);
  ResultReal:=LotusDateValue(Year,Month,Day);
  Goto FastPushNumberReal;
_BCompte:
  { A completer }
  Goto 1;
_Bin2Dec:
  {ResultReal:=ResultReal;}
  Goto PushNumberReal;
_Bin2Hex:
  PushString(ToHex(ResultReal,Trunc(GetNumberParam(1))));
  Goto 1;
_Bin2Oct:
  PushString(ToOct(ResultReal,Trunc(GetNumberParam(1))));
  Goto 1;
_BMax:
   { A completer... }
  Goto 1;
_BMin:
   { A completer ... }
  Goto 1;
_BMoyenne:
   { A completer ... }
  Goto 1;
_BSomme:
   { A completer ... }
  Goto 1;
_BStd:
   { A completer ... }
  Goto 1;
_BStds:
   { A completer ... }
  Goto 1;
_BVar:
   { A completer ... }
  Goto 1;
_BVars:
   { A completer ... }
  Goto 1;
_C:
  PushString(SCGetFirstCelluleString(SC,Param[0].X.CelX1,Param[0].X.CelY1,
                                        Param[0].X.CelX2,Param[0].X.CelY2));
  Goto 1;
_Car:
  PushString(Char(ResultLong));
  Goto 1;
_CellIndex:
   { A completer ... }
  Goto 1;
_Cellule:
  Param[0].X.DataPString^:=StrUp(Param[0].X.DataPString^);
  If Param[0].X.DataPString^='ADRESSE'Then Begin
   If Not PushString(Adresse(Param[1].X.CelY1,Param[1].X.CelX1,0,True))Then Exit;
  End
   Else
  If Param[0].X.DataPString^='LARGEUR'Then Begin
   ResultLong:=SCGetColumnWidth(SC,Param[1].X.CelX1);
   Goto PushNumberLong;
  End
   Else
  Exit;
  Goto 1;
_Chaine:
  PushString(RealStr2(ResultReal,0,Trunc(GetNumberParam(1))));
  Goto 1;
_Cherche:
  ResultLong:={Trunc(GetNumberParam(2))+}Pos(Param[0].X.DataPString^,
   {Copy(}Param[1].X.DataPString^{,Trunc(GetNumberParam(2)),255)});
  Goto PushNumberLong;
_Choix:
   { A compl‚ter ... }
  Goto 1;
_Code:
  ResultLong:=Byte(StrI(1,Param[0].X.DataPString^));
  Goto PushNumberLong;
_Col:
  ResultLong:=Param[0].X.CelX2-Param[0].X.CelX1+1;
  Goto PushNumberLong;
_Colonne:
  ResultLong:=Param[0].X.CelX1+1;
  Goto PushNumberLong;
_Combin:
  ResultReal:=C(ResultLong,Trunc(GetNumberParam(1)));
  Goto PushNumberReal;
_Compte:
  ResultLong:=CountNotEmpty(SC,Param[0]);
  Goto PushNumberLong;
_ConsH:
 ResultReal:=HLookUp(SC,ResultReal,Param[1],Trunc(GetNumberParam(2)));
 Goto PushNumberReal;
_ConsV:
 ResultReal:=VLookUp(SC,ResultReal,Param[1],Trunc(GetNumberParam(2)));
 Goto PushNumberReal;
_Cos:
  ResultReal:=Cos(ResultReal);
  Goto PushNumberReal;
_CosH:
  {ResultReal:=CosH(ResultReal);
   Goto PushNumberReal;}
  ASM
   PUSH Word Ptr ResultReal[4]
   PUSH Word Ptr ResultReal[2]
   PUSH Word Ptr ResultReal
   CALL CosH
   JMP PushNumberResultReal
  END;
_Cot:
  {ResultReal:=Cot(ResultReal);
   Goto PushNumberReal;}
  ASM
   PUSH Word Ptr ResultReal[4]
   PUSH Word Ptr ResultReal[2]
   PUSH Word Ptr ResultReal
   CALL Cot
   JMP PushNumberResultReal
  END;
_CotH:
   {ResultReal:=CotH(ResultReal);}
  ASM
   PUSH Word Ptr ResultReal[4]
   PUSH Word Ptr ResultReal[2]
   PUSH Word Ptr ResultReal
   CALL CotH
   JMP PushNumberResultReal
  END;
_Date:
  ResultReal:=LotusDateValue(Trunc(GetNumberParam(0)),Trunc(GetNumberParam(1)),Trunc(GetNumberParam(2)));
  Goto PushNumberReal;
_DatVal:
  ResultReal:=StrLotusDateValue(Param[0].X.DataPString^);
  Goto PushNumberReal;
_Debut:
  PushString(Left(Param[0].X.DataPString^,Trunc(GetNumberParam(1))));
  Goto 1;
_Deg:
  {ResultReal:=Radians2Degrees(ResultReal);
  Goto PushNumberReal;}
  ASM
   PUSH Word Ptr ResultReal[4]
   PUSH Word Ptr ResultReal[2]
   PUSH Word Ptr ResultReal
   CALL Radians2Degrees
PushNumberResultReal:
   MOV Word Ptr ResultReal,AX
   MOV Word Ptr ResultReal[2],BX
   MOV Word Ptr ResultReal[4],DX
  END;
  Goto PushNumberReal;
_Duree:
   {???? R‚ponse incorrecte ????}
   {Formule de Quattro Pro:
   ln(1+Vfut/pmt Taux/ln(1+Taux))}
  ResultReal:=Term(ResultReal,GetNumberParam(1),GetNumberParam(2));
  Goto PushNumberReal;
_DimancheDePaque:
  If Not(PushString(DimancheDePaque(Trunc(GetNumberParam(0)))))Then Exit;
  Goto 1;
_DureeComp:
  If Param[2].X.DataReal=0.0Then ResultReal:=0.0
  Else ResultReal:=Ln(GetNumberParam(1)/GetNumberParam(2));
  Param[4].X.DataReal:=Ln(1+GetNumberParam(0));
  If Param[4].X.DataReal<>0.0Then
   ResultReal:=ResultReal/Param[4].X.DataReal;
  Goto PushNumberReal;
  {cmfpEcartTypeP:mixer avec cmfpMoyenne}
_Egal:
  ResultLong:=Byte(Param[0].X.DataPString^=Param[1].X.DataPString^);
  Goto PushNumberLong;
_EPure:
  PushString(CleanString(Param[0].X.DataPString^));
  Goto 1;
_Err:
   { A completer ... }
  Goto 1;
_EstChaine:
  If(Param[0].TypeDef<>dtString)Then ResultLong:=0
   Else
  Begin
   ResultLong:=Byte(Length(Param[0].X.DataPString^)>0);
  End;
  Goto PushNumberLong;
_EstErr:
   { A completer ... }
  Goto 1;
_EstImpair:
   {ResultLong:=Byte(Odd(ResultLong));}
  ASM
   AND Word Ptr ResultLong,1
   MOV Word Ptr ResultLong[2],0
  END;
  Goto PushNumberLong;
_EstND:
   { A completer ... }
  Goto 1;
_EstNum:
  ResultLong:=Byte(Param[0].TypeDef in[dtLong,dtReal]);
  Goto PushNumberLong;
_EstPair:
  {ResultLong:=Byte(Not Odd(ResultLong));}
  ASM
   MOV AX,1
   AND Word Ptr ResultLong,AX
   XOR Word Ptr ResultLong,AX
   DEC AX
   MOV Word Ptr ResultLong[2],AX
  END;
  Goto PushNumberLong;
_Exp:
  ResultReal:=Exp(ResultReal);
  Goto PushNumberReal;
_Fact:
  {ResultReal:=Factorial(ResultLong);
  Goto PushNumberReal;}
  ASM
   PUSH Word Ptr ResultLong
   CALL Factorial
   JMP PushNumberResultReal
  END;
_FactLn:
  ResultReal:=Ln(Factorial(ResultLong));
  Goto PushNumberReal;
_Faux:
  {ResultLong:=0;}
  ASM
   XOR AX,AX
   MOV Word Ptr ResultLong[2],AX
   MOV Word Ptr ResultLong,AX
  END;
  Goto FastPushNumberLong;
_FichierExiste:
  ResultLong:=Byte(FileExist(Param[0].X.DataPString^));
  Goto PushNumberLong;
_Fin:
  If Not(PushString(Right(Param[0].X.DataPString^,Trunc(GetNumberParam(1)))))Then Exit;
  Goto 1;
_Heure:
  {ResultLong:=Heure(ResultReal);
  Goto PushNumberLong;}
  ASM
   PUSH Word Ptr ResultReal[4]
   PUSH Word Ptr ResultReal[2]
   PUSH Word Ptr ResultReal
   CALL Heure
   JMP PushNumberResultLong
  END;
_HeurVal:
   { A completer ... }
  Goto 1;
_HexANum:
  ResultLong:=HexStrToInt(Param[0].X.DataPString^);
  Goto PushNumberLong;
_Index:
   { A completer ... }
  Goto 1;
_Info:
  Param[0].X.DataPString^:=StrUp(Param[0].X.DataPString^);
  If Param[0].X.DataPString^='MEMDISPO'Then Begin
   ResultLong:=MemAvail;
   Goto PushNumberLong;
  End
   Else
  If Param[0].X.DataPString^='MEMTOT'Then Begin
   {ResultLong:=LongInt(SizeOfRAMConv)shl 10;
   Goto PushNumberLong;}
   ASM
    XOR DX,DX
    MOV ES,DX
    MOV AX,ES:[0413h]
    SHL AX,1
    SHL AX,1
    MOV DL,AH
    MOV AH,AL
    MOV AL,0
    JMP PushNumberResultLong
   END;
  End
   Else
  If Param[0].X.DataPString^='MEMUTIL'Then Begin
   ResultLong:=(LongInt(SizeOfRAMConv)shl 10)-MemAvail;
   Goto PushNumberLong;
  End
   Else
  If Param[0].X.DataPString^='REPERTOIRE'Then PushString(GetCurrentDir)Else
  If Param[0].X.DataPString^='SYSTEXPL'Then PushString('pcdos');
  Goto 1;
_Interet:
  ResultReal:=IPAYMT(ResultReal,GetNumberParam(1),GetNumberParam(2),
                     GetNumberParam(3),GetNumberParam(4),GetNumberParam(5));
  Goto PushNumberReal;
_ISAAF:
   { A completer ... }
  Goto 1;
_ISApp:
   { A completer ... }
  Goto 1;
_Jour:
   { A completer ... }
  Goto 1;
__JOUR:
  ExtractDate(Param[0].X.DataPString^,Year,Month,Day);
  ResultLong:=Day;
  Goto PushNumberLong;
_JourSem:
  ExtractDate(Param[0].X.DataPString^,Year,Month,Day);
  ResultLong:=Succ(DayOfWeek(Year,Month,Day));
  Goto PushNumberLong;
_Ligne:
  ResultLong:=Param[0].X.CelY1;
  Goto PushNumberLong;
_Lignes:
  ResultLong:=Param[0].X.CelY2-Param[0].X.CelY1+1;
  Goto PushNumberLong;
_Ln:
  ResultReal:=Ln(ResultReal);
  Goto PushNumberReal;
_LnGamma:
  {ResultReal:=LnGamma(ResultReal);
  Goto PushNumberReal;}
  ASM
   PUSH Word Ptr ResultReal[4]
   PUSH Word Ptr ResultReal[2]
   PUSH Word Ptr ResultReal
   CALL LnGamma
   JMP PushNumberResultReal
  END;
_Log:
  ResultReal:=Log(GetNumberParam(1),ResultReal);
  Goto PushNumberReal;
_Log10:
  {ResultReal:=Log10(ResultReal);
  Goto PushNumberReal;}
  ASM
   PUSH Word Ptr ResultReal[4]
   PUSH Word Ptr ResultReal[2]
   PUSH Word Ptr ResultReal
   CALL Log10
   JMP PushNumberResultReal
  END;
_LoiBinomiale:
  If Param[3].X.DataReal=0.0Then
   ResultReal:=PBinom(Trunc(GetNumberParam(1)),GetNumberParam(2),ResultLong)
  Else
   ResultReal:=FBinom(Trunc(GetNumberParam(1)),GetNumberParam(2),ResultLong);
  Goto PushNumberReal;
_LoiGamma:
  Case Trunc(GetNumberParam(3))of
   0:ResultReal:=DGamma(GetNumberParam(1),GetNumberParam(2),ResultReal);
   1:ResultReal:=FGamma(GetNumberParam(1),GetNumberParam(2),ResultReal);
   Else Exit;
  End;
  Goto PushNumberReal;
_LoiGammaInverse:
   { Sa retourne pas la bonne r‚ponse...}
  ResultReal:=DGamma(GetNumberParam(1),GetNumberParam(2),ResultReal);
  Goto PushNumberReal;
_LoiKhiDeux:
  ResultReal:=PKhi2(Trunc(GetNumberParam(1)),ResultReal);
  Goto PushNumberReal;
_LoiNormaleStandard:
  {ResultReal:=FNorm(ResultReal);
  Goto PushNumberReal;}
  ASM
   PUSH Word Ptr ResultReal[4]
   PUSH Word Ptr ResultReal[2]
   PUSH Word Ptr ResultReal
   CALL FNorm
   JMP PushNumberResultReal
  END;
_LoiPoisson:
  If Param[2].X.DataReal=0.0Then ResultReal:=PPoisson(GetNumberParam(1),ResultLong)
                            Else ResultReal:=FPoisson(GetNumberParam(1),ResultLong);
  Goto PushNumberReal;
_LoiStudent:
  Case Trunc(GetNumberParam(2))of
   1:{If Not(PushNumber(DStudent(Trunc(GetNumberParam(1)),Trunc(GetNumberParam(0)))))Then} Exit;
   2:Begin
    ResultReal:=PStudent(Trunc(GetNumberParam(1)),ResultLong);
    Goto PushNumberReal;
   End;
   Else Exit;
  End;
_Long:
  ResultLong:=Length(Param[0].X.DataPString^);
  Goto PushNumberLong;
_Majusc:
  PushString(StrUp(Param[0].X.DataPString^));
  Goto 1;
_Max:
  ResultReal:=0.0;
  Ok:=False;
  For JL:=Param[0].X.CelY1 to(Param[0].X.CelY2)do
   For IL:=Param[0].X.CelX1 to(Param[0].X.CelX2)do Begin
    PC:=SCGetCellule(SC,IL,JL);
    Case(PC^.Header.Format)of
     cfFormula:Begin
      If(Not(Ok))or(ResultReal<PC^.Data.f.Value)Then
       ResultReal:=PC^.Data.f.Value;
      Ok:=True;
     End;
     cfValue:Begin
      If(Not(Ok))or(ResultReal<PC^.Data.v.Value)Then
       ResultReal:=PC^.Data.v.Value;
      Ok:=True;
     End;
    End;
   End;
  Goto PushNumberReal;
_Mediane:
  ResultReal:=Mediane(SC,Param[0]);
  Goto PushNumberReal;
_MemDispo:
  ResultLong:=MemAvail;
  Goto FastPushNumberLong;
_MemMemsDispo:
   { A completer ... }
  Goto 1;
_Milieu:
  If Not PushString(Copy(Param[0].X.DataPString^,Trunc(GetNumberParam(1))+1,Trunc(GetNumberParam(2))))Then Exit;
  Goto 1;
_Min:
  ResultReal:=0.0;
  Ok:=False;
  For JL:=Param[0].X.CelY1 to(Param[0].X.CelY2)do
   For IL:=Param[0].X.CelX1 to(Param[0].X.CelX2)do Begin
    PC:=SCGetCellule(SC,IL,JL);
    Case(PC^.Header.Format)of
     cfFormula:Begin
      If(Not(Ok))or(ResultReal>PC^.Data.f.Value)Then
       ResultReal:=PC^.Data.f.Value;
      Ok:=True;
     End;
     cfValue:Begin
      If(Not(Ok))or(ResultReal>PC^.Data.v.Value)Then
       ResultReal:=PC^.Data.v.Value;
      Ok:=True;
     End;
    End;
   End;
  Goto PushNumberReal;
_Minusc:
  PushString(StrDn(Param[0].X.DataPString^));
  Goto 1;
_Minute:
  {ResultLong:=Minute(ResultReal);
  Goto PushNumberLong;}
  ASM
   PUSH Word Ptr ResultReal[4]
   PUSH Word Ptr ResultReal[2]
   PUSH Word Ptr ResultReal
   CALL Minute
   JMP PushNumberResultLong
  END;
_Mod:
  ResultLong:=ResultLong mod Trunc(GetNumberParam(1));
  Goto PushNumberLong;
_Mois:
   { A completer ... }
  Goto 1;
__MOIS:
  ExtractDate(Param[0].X.DataPString^,Year,Month,Day);
  ResultLong:=Month;
  Goto PushNumberLong;
_Moyenne:_EcartTypeP:_Somme:_VarP:_Var:_Vars:_Produit:
  ResultReal:=_SCGetCelluleSum(SC,Param[0],ID);
  Goto PushNumberReal;
_NomPropre:
  PushString(NomPropre(Param[0].X.DataPString^));
  Goto 1;
_N:
   { A completer ... }
  Goto 1;
_ND:
   { A completer ... }
  Goto 1;
_NPer:
  ResultReal:=NPer(ResultReal,GetNumberParam(1),
                   GetNumberParam(2),GetNumberParam(3),
                   GetNumberParam(4));
  Goto PushNumberReal;
_NumAHex:
   { A completer ... }
  Goto 1;
_Pi:
  ResultReal:=PI;
  Goto FastPushNumberReal;
_PointCell:
   { A completer ... }
  Goto 1;
_Principal:
  ResultReal:=PPaymt(ResultReal,GetNumberParam(1),GetNumberParam(2),
                     GetNumberParam(3),GetNumberParam(4),GetNumberParam(5));
  Goto PushNumberReal;
_ProdScal:
  ResultReal:=ProdScal(SC,Param[0],Param[1]);
  Goto PushNumberReal;
_Racine:
  ResultReal:=Sqrt(ResultReal);
  Goto PushNumberReal;
_Rad:
  {ResultReal:=Degrees2Radians(ResultReal);
  Goto PushNumberReal;}
  ASM
   PUSH Word Ptr ResultReal[4]
   PUSH Word Ptr ResultReal[2]
   PUSH Word Ptr ResultReal
   CALL Degrees2Radians
   JMP PushNumberResultReal
  END;
_Remb:
  ResultReal:=Paymt(ResultReal,GetNumberParam(1),GetNumberParam(2),
                    GetNumberParam(3),GetNumberParam(4));
  Goto PushNumberReal;
_Rembour:
  {Param[3].X.DataReal:=(GetNumberParam(0)*GetNumberParam(1));
  Param[4].X.DataReal:=(1-Power(1+GetNumberParam(1),-GetNumberParam(2)));
  If Param[4].X.DataReal<>0.0Then
   Param[3].X.DataReal:=Param[3].X.DataReal/Param[4].X.DataReal;
  If Not(PushNumber(Param[3].X.DataReal))Then Exit;
  Goto 1;}
  ResultReal:=(ResultReal*GetNumberParam(1));
  Param[4].X.DataReal:=(1-Power(1+GetNumberParam(1),-GetNumberParam(2)));
  If Param[4].X.DataReal<>0.0Then
   ResultReal:=ResultReal/Param[4].X.DataReal;
  Goto PushNumberReal;
_Repete:
  If Not PushString(MultStr(Param[0].X.DataPString^,Trunc(GetNumberParam(1))))Then Exit;
  Goto 1;
_SecH:
  {ResultReal:=SecH(ResultReal);
  Goto PushNumberReal;}
  ASM
   PUSH Word Ptr ResultReal[4]
   PUSH Word Ptr ResultReal[2]
   PUSH Word Ptr ResultReal
   CALL SecH
   JMP PushNumberResultReal
  END;
_Seconde:
  {ResultLong:=Seconde(ResultReal);
  Goto PushNumberLong;}
  ASM
   PUSH Word Ptr ResultReal[4]
   PUSH Word Ptr ResultReal[2]
   PUSH Word Ptr ResultReal
   CALL Seconde
PushNumberResultLong:
   MOV Word Ptr ResultLong,AX
   MOV Word Ptr ResultLong[2],DX
   JMP PushNumberLong
  END;
_SI:
  If(Param[0].X.DataBool)Then Begin
   If Not PushVariant(Param[1])Then Exit;
  End
   Else
  Begin
   If Not PushVariant(Param[2])Then Exit;
  End;
  Goto 1;
_Sin:
  ResultReal:=Sin(ResultReal);
  Goto PushNumberReal;
_SinH:
  {ResultReal:=SinH(ResultReal);
  Goto PushNumberReal;}
  ASM
   PUSH Word Ptr ResultReal[4]
   PUSH Word Ptr ResultReal[2]
   PUSH Word Ptr ResultReal
   CALL SinH
   JMP PushNumberResultReal
  END;
  {_Somme:mixer avec cmfpMoyenne}
_Std:
   { A completer ... }
  Goto 1;
_Stds:
   { A completer ... }
  Goto 1;
_STXT:
 PushString(Copy(Param[0].X.DataPString^,Trunc(GetNumberParam(1)),Trunc(GetNumberParam(2))));
 Goto 1;
_Substitue:
   { A completer ... }
  Goto 1;
_SuprEspace:
  PushString(Trim(Param[0].X.DataPString^));
  Goto 1;
_Tan:
  {ResultReal:=Tan(ResultReal);
  Goto PushNumberReal;}
  ASM
   PUSH Word Ptr ResultReal[4]
   PUSH Word Ptr ResultReal[2]
   PUSH Word Ptr ResultReal
   CALL Tan
   JMP PushNumberResultReal
  END;
_TanH:
  {ResultReal:=TanH(ResultReal);
  Goto PushNumberReal;}
  ASM
   PUSH Word Ptr ResultReal[4]
   PUSH Word Ptr ResultReal[2]
   PUSH Word Ptr ResultReal
   CALL TanH
   JMP PushNumberResultReal
  END;
  {_VarP:mixer avec cmfpMoyenne}
_Taux:
  ResultReal:=Rate(ResultReal,GetNumberParam(1),Trunc(GetNumberParam(2)));
  Goto PushNumberReal;
_TauxInt:
  ResultReal:=IRate(ResultReal,GetNumberParam(1),GetNumberParam(2),
                    GetNumberParam(3),GetNumberParam(4));
  Goto PushNumberReal;
_Temps:
  ResultReal:=Temps(ResultReal,GetNumberParam(1),Trunc(GetNumberParam(2)));
  Goto PushNumberReal;
_Vact:
  ResultReal:=PVal(ResultReal,GetNumberParam(1),GetNumberParam(2),
                   GetNumberParam(3),GetNumberParam(4));
  Goto PushNumberReal;
_Valact:
  ResultReal:=PV(ResultReal,GetNumberParam(1),GetNumberParam(2));
  Goto PushNumberReal;
_Valeur:
  ChgChr(Param[0].X.DataPString^,',','.');
  Val(Trim(Param[0].X.DataPString^),ResultReal,Param[1].X.DataInt);
  Goto PushNumberReal;
_ValeurOption:
   { A completer ... }
  Goto 1;
_ValFut:
  ResultReal:=FV(ResultReal,GetNumberParam(1),GetNumberParam(2));
  Goto PushNumberReal;
_Van:
  {Function NPV(Rate:Real;Var Block:BlockType;PType:Real):Real;
  Var
   X:Extended;
   I:LongInt;
  Begin
   X:=0;
   Rate:=1/(1+Rate);
   For I:=Block.Count downto 1 do X:=X*Rate+Block.Value(i);
   NPV:=X*Exp((1-PType)*Ln(Rate));
  End;}
  Param[3].X.DataReal:=0.0;{X}
  Param[0].X.DataReal:=1/(1+Param[0].X.DataReal);
  For JL:=Param[1].X.CelY2 downto(Param[1].X.CelY1)do
   For IL:=Param[1].X.CelX2 downto(Param[1].X.CelX1)do Begin
    PC:=SCGetCellule(SC,IL,JL);
    Case(PC^.Header.Format)of
     cfFormula:Begin
      Param[3].X.DataReal{X}:=Param[3].X.DataReal{X}*Param[0].X.DataReal+PC^.Data.f.Value;
     End;
     cfValue:Begin
      Param[3].X.DataReal{X}:=Param[3].X.DataReal{X}*Param[0].X.DataReal+PC^.Data.v.Value;
     End;
    End;
   End;
  ResultReal:=Param[3].X.DataReal{X}*Exp((1-Param[2].X.DataReal)*
              Ln(Param[0].X.DataReal));
  Goto PushNumberReal;
_Version:
   { A completer ... }
  Goto 1;
_VFut:
  ResultReal:=FVal(ResultReal,GetNumberParam(1),GetNumberParam(2),
                   GetNumberParam(3),GetNumberParam(4));
  Goto PushNumberReal;
_Vrai:
  ResultLong:=1;
  Goto FastPushNumberLong;
_Ent:
PushNumberLong:
  If StrI(Q.I,Q.Formula)<>')'Then Exit;
  Inc(Q.I);
FastPushNumberLong:
  If Not FOPushNumberLong(Q,ResultLong)Then Exit;
  Goto 1;
PushNumberReal:
  If StrI(Q.I,Q.Formula)<>')'Then Exit;
  Inc(Q.I);
FastPushNumberReal:
  If Not FOPushNumberReal(Q,ResultReal)Then Exit;
  Goto 1;
ErrorInstr:
  Case GetCodeMainWordPas(ThisWord)of
   cmwpAND:Begin
    Q.PostFixeData.OperTitle:='ï';
    Q.PostFixeData.Priorite:=2;
   End;
   cmwpDIV:Begin
    Q.PostFixeData.OperTitle:='\';
    Q.PostFixeData.Priorite:=2;
   End;
   cmwpMOD:Begin
    Q.PostFixeData.OperTitle:='%';
    Q.PostFixeData.Priorite:=2;
   End;
   cmwpNOT:Begin
    Q.PostFixeData.OperTitle:='!';
    Q.PostFixeData.Priorite:=3;
   End;
   cmwpOR:Begin
    Q.PostFixeData.OperTitle:='U';
    Q.PostFixeData.Priorite:=1;
   End;
   cmwpSHL:Begin
    Q.PostFixeData.OperTitle:='¯';
    Q.PostFixeData.Priorite:=2;
   End;
   cmwpSHR:Begin
    Q.PostFixeData.OperTitle:='®';
    Q.PostFixeData.Priorite:=2;
   End;
   cmwpXOR:Begin
    Q.PostFixeData.OperTitle:='X';
    Q.PostFixeData.Priorite:=1;
   End;
   Else Exit;
  End;
1:
   { Lib‚rer la m‚moire des Variant String }
  For J:=Length(Params)-1downto 0do Begin
   FreeVariant(Param[J]);
  End;
 End;
 SCFormuleOnWord:=True;
End;

Function SCXtrkFormule(Var SC:SuperCalcApp;Const S:String;Var I:Byte;Var Q:Variant):Boolean;
Var
 F:FormulaObject;
Begin
 FOInit(F);
 F.I:=I;
 F.Option:=[foNumberC,foExpBasic,foStringPascal,foStringC,foPourcent,foBoolean,
            foIntDiv];
 F.StopChar:=[':',';'];
 F.OnWord:=SCFormuleOnWord;
 F.Context:=@SC;
 SCXtrkFormule:=FOCompute(F,S);
 Q:=F.Result;
 I:=F.I;
End;

Procedure SCPutInputLine(Var Q:SuperCalcApp;PC:PCellule);Near;
Var
 OldKr:Byte;
Begin
 OldKr:=Q.W.CurrColor;
 WESetKrBorder(Q.W);
 WESetPos(Q.W,XInputPosCalc,0);
 If(PC<>NIL)Then Case(PC^.Header.Format)of
  cfFormula:WEPutTxt(Q.W,PC^.Data.f.Formula);
  cfText:WEPutTxt(Q.W,PC^.Data.t.Text);
  cfValue:WEPutTxt(Q.W,RealStr2(PC^.Data.v.Value,4,PC^.Data.v.Dec));
 End;
 WEClrEol(Q.W);
 Q.W.CurrColor:=OldKr;
End;

Procedure SCPutCurrInputLine(Var Q:SuperCalcApp);
Var
 PC:PCellule;
Begin
 PC:=SCGetCellule(Q,Q.PX,Q.PY);
 SCPutInputLine(Q,PC);
End;

Procedure SCPutData;
Label ND,Xit;
Var
 PC:PCellule;
 InBlock:Boolean;
 XV:Variant;
 I:Byte;
 Y:Byte;
 Width:Byte;
 S:String;
 GX,GY:Word;
Begin
 InBlock:=SCInBlock(Q,Q.PX,Q.PY);
 PC:=SCGetCellule(Q,PX,PY);
 Y:=Q.HomeLine+YS+1+Byte(Q.Mode=3);
 If(PC<>NIL)Then Begin
  Width:=SCGetColumnWidth(Q,XL);
  Case(PC^.Header.Format)of
   cfText:S:=PC^.Data.t.Text;
   cfValue:S:=RealStr2(PC^.Data.v.Value,4,PC^.Data.v.Dec);
   cfFormula:Begin
    If Not(PC^.Data.f.Compute)Then Begin
     I:=2;
     PC^.Data.f.Error:=Not SCXtrkFormule(Q,PC^.Data.f.Formula,I,XV);
     Case(XV.TypeDef)of
      dtString:Begin
       S:=XV.X.DataPString^;
       Goto ND;
      End;
      Else PC^.Data.f.Value:=VariantToReal(XV);
     End;
     PC^.Data.f.Compute:=PC^.Data.f.Error=False;
    End;
    If(PC^.Data.f.Error)Then S:='ERREUR'
                        Else S:=RealStr2(PC^.Data.f.Value,4,PC^.Data.f.Dec);
ND:End;
   Else S:='';
  End;
  If(Length(S)<Width)Then Case(PC^.Header.Justify)of
   cLeft:S:=StrUSpc(S,Width);
   cCenter:S:=Spc((Width-Length(S))shr 1)+S;
   cRight:S:=Spc(Width-Length(S))+S;
  End;
  If(TrueColor)Then Begin
   If(InBlock)Then WESetKr(Q.W,Not PC^.Header.Attribut)
              Else WESetKr(Q.W,PC^.Header.Attribut);
  End;
  WEPutTxtXY(Q.W,Q.ColumnX[XL],Y,S);
  If(IsGrf)Then Begin
   GX:=(Q.ColumnX[XL])shl 3;
   GY:=GetRawY(Y+1)-2;
   If PC^.Header.GAttr and 2=2Then WEClrLnHor(Q.W,GX,GY,Length(S)shl 3,Black);
  End;
  If(InBlock)and(TrueColor)Then WESetKr(Q.W,PC^.Header.Attribut);
 End
  Else
 Begin
  If(TrueColor)Then Begin
   If(InBlock)Then WESetKr(Q.W,Not CurrKrs.Dialog.Env.List.Border)
              Else WESetKr(Q.W,CurrKrs.Dialog.Env.List.Border);
  End;
  WEBarSpcHor(Q.W,Q.ColumnX[XL],Y,Q.ColumnX[XL+1]-1);
  If(InBlock)and(TrueColor)Then WESetKr(Q.W,CurrKrs.Dialog.Env.List.Border);
 End;
Xit:
 If(Cadril)and(IsGrf)and(TrueColor)Then Begin
  Width:=SCGetColumnWidth(Q,XL);
  GX:=(Q.ColumnX[XL])shl 3;
  GY:=GetRawY(Y+1)-1;
  WEClrLnHor(Q.W,GX,GY,Width shl 3,LightGray);
  WEPutLine(Q.W,GX,GY-HeightChr,GX,GY,LightGray);
 End;
End;

Procedure SCPutSelect;Begin
 WESetKr(Q.W,$1F);
 SCPutData(Q,Q.XL,Q.YS,Q.PX,Q.PY,False);
 WEBarSelHor(Q.W,Q.ColumnX[Q.XL],Q.HomeLine+Q.YS+1+Byte(Q.Mode=3),Q.ColumnX[Q.XL+1]-1);
 WESetKrBorder(Q.W);
 SCPutCurrInputLine(Q);
End;

Procedure SCPutUnSelect;Begin
 SCPutData(Q,Q.XL,Q.YS,Q.PX,Q.PY,True);
End;

Procedure SCPutSelErr;Begin
 Q.W.CurrColor:=$C0;
 WEBarSelHor(Q.W,Q.ColumnX[Q.XL],Q.HomeLine+Q.YS+1+Byte(Q.Mode=3),Q.ColumnX[Q.XL+1]-1);
End;

Procedure SCPushData;
Var
 Err:Word;
 Value:Real;
Begin
 S:=LTrim(S);
 If S=''Then CEAddEmpty(Q.Cellule,Q.PX,Q.PY)Else
 If StrI(1,S)='='Then CEAddFormula(Q.Cellule,Q.PX,Q.PY,S)Else
 If IsNumber(S)Then Begin
  System.Val(S,Value,Err);
  CEAddRealValue(Q.Cellule,Q.PX,Q.PY,Value);
 End
  Else
 CEAddText(Q.Cellule,Q.PX,Q.PY,S);
 Q.GlobalModified:=True;
End;

Procedure SCComputeScreenColumn(Var Q:SuperCalcApp);
Var
 XE:Integer;
 PX:LongInt;
 Curr:PColumn;
Begin
 If(Q.MovedX)Then Begin
  FillChr(Q.ColumnX,SizeOf(Q.ColumnX),Q.W.MaxX+1);
  PX:=Q.PX-Q.XL;
  XE:=10;Q.MaxColumnX:=0;
  Repeat
   Curr:=COGetColumn(Q.Column,PX);
   Q.ColumnX[Q.MaxColumnX]:=XE;
   Inc(Q.MaxColumnX);
   If Q.MaxColumnX>=60Then Break;
   If(Curr=NIL)Then Inc(XE,10)
               Else Inc(XE,Curr^.c.Length);
   If(XE>Q.W.MaxX)Then Break;
   Inc(PX);
  Until(XE>Q.W.MaxX);
 End;
End;

Procedure SCInsertColumn(Var Q:SuperCalcApp;PX:LongInt);Near;Begin
 COInsertColumn(Q.Column,PX);
 CEInsertColumn(Q.Cellule,PX);
 SCRefreshSpreadSheetColumn(Q);
 SCRefreshSpreadSheet(Q);
 SCPutSelect(Q);
End;

Procedure SCDeleteColumn(Var Q:SuperCalcApp;PX:LongInt);Near;Begin
 CODeleteColumn(Q.Column,PX);
 CEDeleteColumn(Q.Cellule,PX);
 SCRefreshSpreadSheetColumn(Q);
 SCRefreshSpreadSheet(Q);
 SCPutSelect(Q);
 If(Q.PX>=PX)Then SCLeft(Q);
End;

Procedure SCInsertRow(Var Q:SuperCalcApp;PY:LongInt);Near;Begin
 CEInsertRow(Q.Cellule,PY);
 SCRefreshSpreadSheetLine(Q);
 SCRefreshSpreadSheet(Q);
 SCPutSelect(Q);
End;

Procedure SCDeleteRow(Var Q:SuperCalcApp;PY:LongInt);Near;Begin
 CEDeleteRow(Q.Cellule,PY);
 SCRefreshSpreadSheetLine(Q);
 SCRefreshSpreadSheet(Q);
 SCPutSelect(Q);
 If(Q.PY>=PY)Then SCUp(Q);
End;

Function SCActionPhysicalColumn(Var Q:SuperCalcApp;X,Y:Byte):Boolean;Near;
Label Width;
Var
 XC,YC:Integer;
 PX:LongInt;
 I:Byte;
 K:Word;
 S:String;
 Update:Boolean;
 Curr:PColumn;
Begin
 SCActionPhysicalColumn:=False;
 If WEInWindow(Q.W,X,Y)Then Begin
  XC:=X-WEGetRX1(Q.W);
  YC:=Y-WEGetRY1(Q.W)-(Q.HomeLine+Byte(Q.Mode=3));
  If(YC=0)and(XC>=10)Then Begin
   PX:=Q.PX-Q.XL;
   I:=0;
   Repeat
    If(Q.ColumnX[I]<=XC)and(Q.ColumnX[I+1]>XC)Then Break;
    Inc(I);
    Inc(PX);
   Until Q.ColumnX[I+1]>Q.W.MaxX;
   Update:=COSearch(Q.Column,PX);
   If LastMouseB=2Then Begin
    WaitMouseBut0;
    K:=RunMenuApp(139);
    Case(K)of
     $F001:SCInsertColumn(Q,PX);
     $F002:SCDeleteColumn(Q,PX);
     $F003:Goto Width;
    End;
   End
    Else
   Begin
    WaitMouseBut0;
Width:
    S:=IntToStr(Q.Column.Curr.c.Length);
    If(_WinInp(50,'Largeur de la colonne','Entrez la largeur de la colonne (3 … 255)',False,S)=kbYes)Then Begin
     Q.Column.Curr.c.Length:=StrToInt(S);
     If Q.Column.Curr.c.Length<3Then ErrMsgOk('La valeur minimal est 3')Else
     If Q.Column.Curr.c.Length>255Then ErrMsgOk('La valeur maximal est 255')
      Else
     Begin
      If(UpDate)Then COUpdate(Q.Column)
                Else COAdd(Q.Column);
      Q.MovedX:=True;
      SCRefreshSpreadSheetColumn(Q);
      SCRefreshSpreadSheet(Q);
      SCPutSelect(Q);
     End;
    End;
   End;
   SCActionPhysicalColumn:=True;
  End;
 End;
End;

Function SCActionPhysicalRow(Var Q:SuperCalcApp;X,Y:Byte):Boolean;Near;
Var
 XC,YC:Integer;
 PY:LongInt;
 K:Word;
Begin
 XC:=X-WEGetRX1(Q.W);
 YC:=Y-WEGetRY1(Q.W)-(Q.HomeLine+1+Byte(Q.Mode=3));
 If(XC<=10)and(YC>=0)Then Begin
  PY:=Q.PY-Q.YS+YC;
  If LastMouseB=2Then Begin
   WaitMouseBut0;
   K:=RunMenuApp(140);
   Case(K)of
    $F001:SCInsertRow(Q,PY);
    $F002:SCDeleteRow(Q,PY);
   End;
  End;
 End;
End;

Procedure SCGotoLine(Var Q:SuperCalcApp;Line:LongInt);Begin
 Q.PY:=Line;
 If Q.PY<=SCHeightSpreadsheet(Q)Then Q.YS:=Line
                                Else Q.YS:=SCHeightSpreadsheet(Q)shr 1;
 SCRefresh(Q);
End;

Procedure SCGotoRow(Var Q:SuperCalcApp;Row:LongInt);Begin
 Q.PX:=Row;
 Q.XL:=0;
 SCRefresh(Q);
End;

Procedure SCReset(Var Q:SuperCalcApp);Near;Begin
 SCComputeScreenColumn(Q);
 Q.Moved:=False;
 Q.MovedX:=False;
 Q.MovedY:=False;
 Q.BufChr:='';
 Q.Modified:=False;
 Q.CellPos:=0;
End;

Procedure SCMoved(Var Q:SuperCalcApp);Near;Begin
 Q.Moved:=True;
 Q.Modified:=False;
 Q.CellPos:=0;
 If Q.BufChr<>''Then Begin
  SCPutData(Q,Q.XL,Q.YS,Q.PX,Q.PY,True);
  Q.BufChr:='';
 End;
End;

Procedure SCLeft(Var Q:SuperCalcApp);Begin
 If(Q.Modified)Then Begin
  If Q.CellPos>0Then Dec(Q.CellPos);
 End
  Else
 If Q.PX>0Then Begin
  SCMoved(Q);
  Q.MovedX:=True;
  SCPutUnSelect(Q);
  Dec(Q.PX);
  If Q.XL>0Then Dec(Q.XL)
   Else
  Begin
   SCRefreshSpreadSheetColumn(Q);
   SCRefreshSpreadSheet(Q);
  End;
  SCPutSelect(Q);
 End
  Else
 Begin
  SCPutSelErr(Q);
  Beep;
  SCPutSelect(Q);
 End;
End;

Procedure SCUp(Var Q:SuperCalcApp);
Var
 I:Byte;
Begin
 If Q.PY>0Then Begin
  SCMoved(Q);
  Q.MovedY:=True;
  SCPutUnSelect(Q);
  Dec(Q.PY);
  If Q.YS>0Then Dec(Q.YS)
   Else
  Begin
   WEScrollUp(Q.W,0,Q.HomeLine+1+Byte(Q.Mode=3),wnMax,wnMax);
   WESetKr(Q.W,$B0);
   WEPutTxtXY(Q.W,0,Q.HomeLine+1+Byte(Q.Mode=3),Str2(Q.PY,10));
   WEBarSpcHorRelief(Q.W,0,Q.W.Y,9);
   WESetKrBorder(Q.W);
   For I:=0to Q.MaxColumnX-1do Begin
    SCPutData(Q,I,Q.YS,Q.PX-Q.XL+I,Q.PY,True);
   End;
  End;
  SCPutSelect(Q);
 End
  Else
 Begin
  SCPutSelErr(Q);
  Beep;
  SCPutSelect(Q);
 End;
End;

Procedure SCRecalcCurrCellule(Var Q:SuperCalcApp);Near;
Var
 PC:PCellule;
Begin
 PC:=SCGetCurrCellule(Q);
 If(PC<>NIL)and(PC^.Header.Format=cfFormula)Then Begin
  PC^.Data.f.Compute:=False;
  SCPutData(Q,Q.XL,Q.YS,Q.PX,Q.PY,False);
 End;
End;

Procedure SCClearCellule(Var Q:SuperCalcApp);Near;Begin
 CEAddEmpty(Q.Cellule,Q.PX,Q.PY);
 SCPutSelect(Q);
End;

Function SCChoiceFormula(Var Q:SuperCalcApp):String;Near;Begin
 SCChoiceFormula:=DBChoice(Q.W.T.X1,WEGetRY1(Q.W)+1,Q.W.T.X1+15,wnMax,'Formule','CHANTAL:/Math/Calc.Dat',2);
End;

Procedure SCDn(Var Q:SuperCalcApp);
Var
 I:Byte;
Begin
 If Q.PY<2147483647Then Begin
  SCMoved(Q);
  Q.MovedY:=True;
  SCPutUnSelect(Q);
  Inc(Q.PY);
  If Q.YS<SCHeightSpreadsheet(Q)Then Inc(Q.YS)
   Else
  Begin
   WEScrollDn(Q.W,0,Q.HomeLine+1+Byte(Q.Mode=3),wnMax,wnMax);
   WESetKr(Q.W,$B0);
   WEPutTxtXY(Q.W,0,Q.W.MaxY,Str2(Q.PY,10));
   WEBarSpcHorRelief(Q.W,0,Q.HomeLine+Q.W.Y,9);
   WESetKrBorder(Q.W);
   For I:=0to Q.MaxColumnX-1do Begin
    SCPutData(Q,I,Q.YS,Q.PX-Q.XL+I,Q.PY,True);
   End;
  End;
  SCPutSelect(Q);
 End
  Else
 Begin
  SCPutSelErr(Q);
  Beep;
  SCPutSelect(Q);
 End;
End;

Function SCIsContactBlock(Var Q:SuperCalcApp;X,Y:LongInt):Boolean;Near;
Var
 InBlock:Boolean;
Begin
 If(Q.BX1>Q.BX2)Then SwapLong(Q.BX1,Q.BX2);
 If(Q.BY1>Q.BY2)Then SwapLong(Q.BY1,Q.BY2);
 SCIsContactBlock:=False;
 If(Q.BX1-1<=X)and(Q.BX2+1>=X)and
   (Q.BY1-1<=Y)and(Q.BY2+1>=Y)Then Begin
  If(Q.BX1-1=X)and(Q.BY1-1=Y)Then Exit;
  If(Q.BX2+1=X)and(Q.BY1-1=Y)Then Exit;
  If(Q.BX1-1=X)and(Q.BY2+1=Y)Then Exit;
  If(Q.BX2+1=X)and(Q.BY2+1=Y)Then Exit;
  SCIsContactBlock:=True;
 End;
End;

Const
 scdLeft=0;
 scdRight=1;
 scdUp=2;
 scdDn=3;

Procedure SCSelected(Var Q:SuperCalcApp;Direction:Byte);
Var
 ManyCellule:Boolean;
Begin
 If(ShiftPress)Then Begin
  ManyCellule:=False;
  If Not SCIsContactBlock(Q,Q.PX,Q.PY)Then Begin
   Q.BX1:=-1;
   Q.BY1:=-1;
   Q.BX2:=-1;
   Q.BY2:=-1;
  End;
  If Q.BX1<0Then Q.BX1:=Q.PX;
  If Q.BY1<0Then Q.BY1:=Q.PY;
  If Q.BX2<0Then Q.BX2:=Q.PX;
  If(Direction<=scdRight)Then Begin { Horizontal }
   If(Q.BX1>Q.PX)Then Q.BX1:=Q.PX;
   If(Q.BX2<Q.PX)Then Q.BX2:=Q.PX;
   ManyCellule:=Q.BY2<>Q.BY1;
  End
   Else
  Begin { Vertical }
   If(Q.BY1>Q.PX)Then Q.BX1:=Q.PX;
   If(Q.BY2<Q.PY)Then Q.BY2:=Q.PY;
   ManyCellule:=Q.BX2<>Q.BX1;
  End;
  Case(Direction)of
   scdUp:If Q.PY>0Then Q.BY1:=Q.PY-1;
   scdDn:Q.BY2:=Q.PY+1;
   scdLeft:If Q.PX>0Then Q.BX1:=Q.PX-1;
   scdRight:Q.BX2:=Q.PX+1;
  End;
  If(ManyCellule)Then SCRefreshSelected(Q);
 End;
End;

Function SCRun;
Label Dn,Up,PgDn,PgUp;
Var
 Q:SuperCalcApp Absolute Context;
 K:Word;
 I:Byte;
 PC:PCellule;
 MenuCellule:Record
  Recalc:Boolean;
 End;
 S:String;
Begin
 Repeat
  If(Q.Modified)Then Begin
   SimpleCur;
   WESetPos(Q.W,XInputPosCalc+Q.CellPos,0);
   WESetCurPos(Q.W,XInputPosCalc+Q.CellPos,0);
   If(IsGraf)Then WEPushCur(Q.W);
  End;
  K:=WEReadk(Q.W);
  If(Q.Modified)Then Begin
   CloseCur;
   If(IsGraf)Then WEPopCur(Q.W);
  End;
  Case(K)of
   kbClose,kbMouse:Break;
   kbInWn:Begin
    If LastMouseY=WEGetRY1(Q.W)Then Begin
      { S‚lectionne la ligne de commande }
     If(LastMouseX<WEGetRX1(Q.W)+XInputPosCalc)Then Begin
      WaitMouseBut0;
      S:=SCChoiceFormula(Q);
      If S<>''Then Begin
       Q.Moved:=False;
       IncStr(Q.BufChr,'=');
       AddStr(Q.BufChr,S);
       {IncStr(Q.BufChr,'(');}
       Q.CellPos:=Length(Q.BufChr);
       WEPutTxtXY(Q.W,XInputPosCalc,0,StrUSpc(Q.BufChr,Q.W.MaxX));
       Q.Modified:=True;
      End;
     End
      Else
     Begin
      SCReset(Q);
      PC:=SCGetCurrCellule(Q);
      If(PC<>NIL)Then Case(PC^.Header.Format)of
       cfFormula:Q.BufChr:=PC^.Data.f.Formula;
       cfValue:Q.BufChr:=RealStr(PC^.Data.v.Value);
       cfText:Q.BufChr:=PC^.Data.t.Text;
      End;
      If Length(Q.BufChr)>=LastMouseX-WEGetRX1(Q.W)Then Begin
       Q.CellPos:=LastMouseX-WEGetRX1(Q.W)-XInputPosCalc;
      End;
      Q.Modified:=True;
     End;
    End
     Else
    If Not SCActionPhysicalColumn(Q,LastMouseX,LastMouseY)Then Begin
     If Not SCActionPhysicalRow(Q,LastMouseX,LastMouseY)Then Begin
      If LastMouseB=2Then Begin
       WaitMouseBut0;
       If SCGotoPhysicalCellule(Q,LastMouseX,LastMouseY)>0Then Begin
        PC:=SCGetCurrCellule(Q);
        FillClr(MenuCellule,SizeOf(MenuCellule));
        If(PC<>NIL)Then MenuCellule.Recalc:=PC^.Header.Format=cfFormula;
        Case _RunMenuApp(141,MenuCellule)of
         $F001:SCRecalcCurrCellule(Q);
         $F002:SCClearCellule(Q);
         $F003:SCProprieteCellule(Q);
         $F021:SCChoiceMacro(Q);
        End;
       End;
      End
       Else
      Begin
       WaitMouseBut0;
       If SCGotoPhysicalCellule(Q,LastMouseX,LastMouseY)=2Then SCProprieteCellule(Q);
      End;
      SCMoved(Q);
     End;
    End;
   End;
   kbLeft:Begin
    SCSelected(Q,scdLeft);
    SCLeft(Q);
   End;
   kbUp:Up:Begin
    SCSelected(Q,scdUp);
    If Q.PY>0Then Begin
     SCMoved(Q);
     Q.MovedY:=True;
     SCPutUnSelect(Q);
     Dec(Q.PY);
     If Q.YS>0Then Dec(Q.YS)
      Else
     Begin
      WEScrollUp(Q.W,0,Q.HomeLine+1+Byte(Q.Mode=3),wnMax,wnMax);
      WESetKr(Q.W,$B0);
      WEPutTxtXY(Q.W,0,Q.HomeLine+1+Byte(Q.Mode=3),Str2(Q.PY,10));
      WEBarSpcHorRelief(Q.W,0,Q.W.Y,9);
      WESetKrBorder(Q.W);
      For I:=0to Q.MaxColumnX-1do Begin
       SCPutData(Q,I,Q.YS,Q.PX-Q.XL+I,Q.PY,True);
      End;
     End;
     SCPutSelect(Q);
    End
     Else
    Begin
     SCPutSelErr(Q);
     Beep;
     SCPutSelect(Q);
    End;
   End;
   kbRight:Begin
    SCSelected(Q,scdRight);
    If(Q.Modified)Then Begin
     If Q.CellPos<=Length(Q.BufChr)Then Inc(Q.CellPos);
    End
     Else
    If Q.PX<2147483647Then Begin
     SCMoved(Q);
     Q.MovedX:=True;
     SCPutUnSelect(Q);
     Inc(Q.PX);
     If(Q.ColumnX[Q.XL+1]<Q.W.MaxX)Then Inc(Q.XL)
      Else
     Begin
      SCRefreshSpreadSheetColumn(Q);
      SCRefreshSpreadSheet(Q);
     End;
     SCPutSelect(Q);
    End
     Else
    Begin
     SCPutSelErr(Q);
     Beep;
     SCPutSelect(Q);
    End;
   End;
  kbPgDn:PgDn:If Q.PY-SCHeightSpreadsheet(Q)<2147483647Then Begin
   SCMoved(Q);
   Q.MovedY:=True;
   Inc(Q.PY,SCHeightSpreadsheet(Q));
   SCRefreshSpreadSheetLine(Q);
   SCRefreshSpreadSheet(Q);
   SCPutSelect(Q);
  End;
  kbPgUp:PgUp:If Q.PY>0Then Begin
   SCMoved(Q);
   Q.MovedY:=True;
   Dec(Q.PY,SCHeightSpreadsheet(Q));
   If Q.PY<0Then Begin
    Q.PY:=0;
    If(Q.PY<Q.YS)Then Q.PY:=Q.YS;
   End;
   SCRefreshSpreadSheetLine(Q);
   SCRefreshSpreadSheet(Q);
   SCPutSelect(Q);
  End;
  kbRBarMsUp:Begin
   WaitRetrace;
   WaitRetrace;
   Goto Up;
  End;
  kbRBarMsDn:Begin
   WaitRetrace;
   WaitRetrace;
   Goto Dn;
  End;
  kbRBarMsPgUp:Begin
   WaitRetrace;
   WaitRetrace;
   Goto PgUp;
  End;
  kbRBarMsPgDn:Begin
   WaitRetrace;
   WaitRetrace;
   Goto PgDn;
  End;
  kbDn:Dn:Begin
   SCSelected(Q,scdDn);
   SCDn(Q);
  End;
  kbDel:If Not(Q.Modified)Then SCClearCellule(Q)
   Else
  Begin
   DelChrAt(Q.BufChr,Q.CellPos+1);
   WEPutTxtXY(Q.W,XInputPosCalc,0,StrUSpc(Q.BufChr,Q.W.MaxX));
  End;
  kbEnd:If(Q.Modified)Then Begin
   Q.CellPos:=Length(Q.BufChr);
  End;
  kbHome:If(Q.Modified)Then Begin
   Q.CellPos:=0;
  End;
  kbBS:If(Q.Moved)Then SCReset(Q)
   Else
  If Q.CellPos>0Then Begin
   BackStr(Q.BufChr);
   Dec(Q.CellPos);
   WEPutTxtXY(Q.W,XInputPosCalc,0,StrUSpc(Q.BufChr,Q.W.MaxX));
   Q.GlobalModified:=True;
  End;
  kbEnter:Begin
   SCPushData(Q,Q.BufChr);
   Goto Dn;
  End;
  Else
  If(Char(K)>#31)and(Hi(K)<$80)Then Begin
   Q.Modified:=True;
   If(Q.Moved)Then SCReset(Q);
   InsStr(Q.BufChr,Q.CellPos+1,Chr(K));
   Inc(Q.CellPos);
   WEPutTxtXY(Q.W,XInputPosCalc,0,StrUSpc(Q.BufChr,Q.W.MaxX));
   Q.GlobalModified:=True;
  End
   Else
  Break;
  End;
 Until False;
 SCRun:=K;
End;

Procedure SCCopyClipboard(Var Q:SuperCalcApp);
Var
 PC:PCellule;
 Size:LongInt;
 I,J:LongInt;
 S:String;
Begin
 If(Q.BX1=-1)or(Q.BY1=-1)or(Q.BX2=-1)or(Q.BY2=-1)Then Begin
  If Q.BufChr=''Then Begin
   S:='';
   PC:=SCGetCurrCellule(Q);
   If(PC<>NIL)Then Case(PC^.Header.Format)of
    cfFormula:S:=PC^.Data.f.Formula;
    cfValue:S:=RealStr(PC^.Data.v.Value);
    cfText:S:=PC^.Data.t.Text;
   End;
   PushClipboardTxt(S);
  End
   Else
  PushClipboardTxt(Q.BufChr);
 End
  Else
 Begin
  Size:=(Q.BY2-Q.BY1+1)*2; { Ligne*CRLF }
  For J:=Q.BY1 to(Q.BY2)do For I:=Q.BX1 to(Q.BX2)do Begin
   PC:=SCGetCellule(Q,I,J);
   If(PC<>NIL)Then Case(PC^.Header.Format)of
    cfFormula:Inc(Size,Length(PC^.Data.f.Formula)+2);
    cfValue:Inc(Size,Succ(Length(RealStr2(PC^.Data.v.Value,4,PC^.Data.v.Dec))));
    cfText:Inc(Size,Succ(Length(PC^.Data.t.Text)));
   End;
  End;
  MakeClipBoard(Size);
  For J:=Q.BY1 to(Q.BY2)do Begin
   For I:=Q.BX1 to(Q.BX2)do Begin
    PC:=SCGetCellule(Q,I,J);
    If(PC<>NIL)Then Case(PC^.Header.Format)of
     cfFormula:PutClipBoardTxt('='+PC^.Data.f.Formula+' ');
     cfValue:PutClipBoardTxt(RealStr2(PC^.Data.v.Value,4,PC^.Data.v.Dec)+' ');
     cfText:PutClipBoardTxt(PC^.Data.t.Text+' ');
    End;
   End;
   PutClipBoardTxt(CRLF);
  End;
 End;
End;

Procedure SCPasteClipboard(Var Q:SuperCalcApp);
Var
 I:Byte;
 PX,PY:LongInt;
 R:Real;
 Error:Word;
 S,S2:String;
Begin
 If Pos(CRLF,GetClipboardTxt)>0Then Begin
  ClipPos:=0;
  S:='';
  PX:=Q.PX;
  PY:=Q.PY;
  Repeat
   S[0]:=Char(GetAbsClipboard(ClipPos,SizeOf(S)-1,S[1]));
   If S=''Then Break;
   I:=1;
   Repeat
    S2:='';
    SkipSpcInLn(I,S);
    While Not(StrI(I,S)in[#0,#10,#13,' '])do Begin
     IncStr(S2,S[I]);
     Inc(I)
    End;
    If S2=''Then Break;
    SkipSpcInLn(I,S);
    If S2<>''Then Begin
     If S2[1]='='Then CEAddFormula(Q.Cellule,PX,PY,S2)
      Else
     If IsNumber(S2)Then Begin
      System.Val(S2,R,Error);
      CEAddRealValue(Q.Cellule,PX,PY,R);
     End
      Else
     CEAddText(Q.Cellule,PX,PY,S2);
     Q.Modified:=True;
     Inc(PX);
    End;
    If S[I]=#13Then Begin
     PX:=Q.PX;
     Inc(PY);
     Inc(I);
    End;
    If S[I]=#10Then Inc(I);
   Until I>=Length(S);
  Until False;
  SCRefreshSpreadSheet(Q);
 End
  Else
 Begin
  SCPushData(Q,GetClipboardTxt);
 End;
 SCPutSelect(Q);
End;

Procedure SCUnderline(Var Q:SuperCalcApp);
Var
 PC:PCellule;
Begin
 PC:=SCGetCurrCellule(Q);
 If(PC<>NIL)Then Begin
  PC^.Header.GAttr:=PC^.Header.GAttr xor 2;
  SCPutSelect(Q);
 End;
End;

Function SCNew{Var Q;X1,Y1,X2,Y2:Byte):Boolean};Begin
 SCInit(SuperCalcApp(Q),X1,Y1,X2,Y2,2);
 SCNew:=True;
End;

Function SCTitle(Var Q;Max:Byte):String;
Const
 Name='Chiffrier ‚lectronique ³Spread Sheet ';
Begin
 If Max=0Then SCTitle:=MessageByLanguage(Name)
         Else SCTitle:=MessageByLanguage(Name)+TruncName(SuperCalcApp(Q).FileName,Max-Length(Name));
End;

Procedure SCMove2{Var Context;X,Y:Byte};
Var
 Q:SuperCalcApp Absolute Context;
 MX,MY:Byte;
Begin
 MX:=Q.W.T.X2-Q.W.T.X1;
 MY:=Q.W.T.Y2-Q.W.T.Y1;
 Q.W.T.X1:=X;Q.W.T.X2:=X+MX;
 Q.W.T.Y1:=Y;Q.W.T.Y2:=Y+MY;
 SCRefresh(Q);
End;

Procedure SCReSize(Var Context;X1,Y1,X2,Y2:Byte);
Var
 Q:SuperCalcApp Absolute Context;
Begin
 WEInit(Q.W,X1,Y1,X2,Y2);
 SCRefresh(Q);
End;

Function SCDone;
Var
 Q:SuperCalcApp Absolute Context;
 K:Word;
Begin
 If(Q.GlobalModified)Then Begin
  K:=WarningMsgYesNo('Le tableur '+Q.FileName+' n''a pas ‚t‚ sauvegard‚! Dois-je le sauver ?');
  Case(K)of
   kbYes:SCSave(Q);{L'utilisateur le supplie de sauvegarder...}
   0,kbAbort:Begin
    SCDone:=kbAbort; {Abandon utilisateur,il ne voulait }
    Exit;            {pas r‚ellement quitter...}
   End;
  End;
 End;
 CODone(Q.Column);
 CEDone(Q.Cellule);
 WEDone(Q.W);
 SCDone:=0;
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
END.