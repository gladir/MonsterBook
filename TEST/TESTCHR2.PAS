Uses Adele,Systex,Systems,Math,Video;

Const WXY:Array[1..81,1..2]of Real=(
  (0.1741,0.0050), (0.1740,0.0050), (0.1738,0.0049), (0.1736,0.0049),
  (0.1733,0.0048), (0.1730,0.0048), (0.1726,0.0048), (0.1721,0.0048),
  (0.1714,0.0051), (0.1703,0.0058), (0.1689,0.0069), (0.1669,0.0086),
  (0.1644,0.0109), (0.1611,0.0138), (0.1566,0.0177), (0.1510,0.0227),
  (0.1440,0.0297), (0.1355,0.0399), (0.1241,0.0578), (0.1096,0.0868),
  (0.0913,0.1327), (0.0687,0.2007), (0.0454,0.2950), (0.0235,0.4127),
  (0.0082,0.5384), (0.0039,0.6548), (0.0139,0.7502), (0.0389,0.8120),
  (0.0743,0.8338), (0.1142,0.8262), (0.1547,0.8059), (0.1929,0.7816),
  (0.2296,0.7543), (0.2658,0.7243), (0.3016,0.6923), (0.3373,0.6589),
  (0.3731,0.6245), (0.4087,0.5896), (0.4441,0.5547), (0.4788,0.5202),
  (0.5125,0.4866), (0.5448,0.4544), (0.5752,0.4242), (0.6029,0.3965),
  (0.6270,0.3725), (0.6482,0.3514), (0.6658,0.3340), (0.6801,0.3197),
  (0.6915,0.3083), (0.7006,0.2993), (0.7079,0.2920), (0.7140,0.2859),
  (0.7190,0.2809), (0.7230,0.2770), (0.7260,0.2740), (0.7283,0.2717),
  (0.7300,0.2700), (0.7311,0.2689), (0.7320,0.2680), (0.7327,0.2673),
  (0.7334,0.2666), (0.7340,0.2660), (0.7344,0.2656), (0.7346,0.2654),
  (0.7347,0.2653), (0.7347,0.2653), (0.7347,0.2653), (0.7347,0.2653),
  (0.7347,0.2653), (0.7347,0.2653), (0.7347,0.2653), (0.7347,0.2653),
  (0.7347,0.2653), (0.7347,0.2653), (0.7347,0.2653), (0.7347,0.2653),
  (0.7347,0.2653), (0.7347,0.2653), (0.7347,0.2653), (0.7347,0.2653),
  (0.7347,0.2653));

Var
 ICV:Array[0..150,0..100,1..3]of Byte;
 M,N,L:Integer;
 I,J:Integer;
 X,Y:Real;
 Gam:Real;      { Gamma }
 YY:Real;       { Luminance }
 XX,ZZ:Real;
 SSS:Real;
 RMAX:Real;     { Facteur scalaire }
 R,G,B:Real;

 {...}
 XR,YR,XG,YG,XB,YB,XW,YW,ZR,ZG,ZB,ZW:Real;
 XC,YC,ZC:Real;
 S1,S2,T1,T2:Real;
 S:Real;
 Slope:Real;
 II,I1,I2,ITest,JJ,J1,J2,JTest,KK:Integer;

Procedure XYZTORGB(Var xr,yr,zr,xg,yg,zg,xb,yb,zb,xc,yc,zc,r,g,b:Real);
Begin
r:=(-xg*yc*zb+xc*yg*zb+xg*yb*zc-xb*yg*zc-xc*yb*zg+xb*yc*zg)/
   (+xr*yg*zb-xg*yr*zb-xr*yb*zg+xb*yr*zg+xg*yb*zr-xb*yg*zr);
g:=(+xr*yc*zb-xc*yr*zb-xr*yb*zc+xb*yr*zc+xc*yb*zr-xb*yc*zr)/
   (+xr*yg*zb-xg*yr*zb-xr*yb*zg+xb*yr*zg+xg*yb*zr-xb*yg*zr);
b:=(+xr*yg*zc-xg*yr*zc-xr*yc*zg+xc*yr*zg+xg*yc*zr-xc*yg*zr)/
   (+xr*yg*zb-xg*yr*zb-xr*yb*zg+xb*yr*zg+xg*yb*zr-xb*yg*zr);
If(R<0.0)Then R:=0.0;
If(G<0.0)Then G:=0.0;
If(B<0.0)Then B:=0.0;
If(R>1.0)Then R:=1.0;
If(G>1.0)Then G:=1.0;
If(B>1.0)Then B:=1.0;
End;

Function JISign(Inc,Value:Integer):Integer;Begin
 If Value<0Then JISign:=-Inc
           Else JISign:=Inc;
End;

BEGIN
 InitSystems(suIsabel);
 FillClr(ICV,SizeOf(ICV));
 SetVideoMode(vmGrf640x480c65536);
 XR:=0.64;
 YR:=0.33;
 XG:=0.29;
 YG:=0.60;
 XB:=0.15;
 YB:=0.06;
 XW:=0.3127;
 YW:=0.3291;
 ZR:=1.0-(XR+YR);
 ZG:=1.0-(XG+YG);
 ZB:=1.0-(XB+YB);
 ZW:=1.0-(XW+YW);
 M:=100;
 N:=100;
 L:=255;
 GAM:=0.8;

 For J:=1to 81do Begin
  S1:=M*WXY[J,1];
  S2:=M*WXY[J+1,1];
  T1:=N*(1.0-WXY[J,2]);
  T2:=N*(1.0-WXY[J+1,2]);
  SLOPE:=(T2-T1)/(S2-S1);
  I1:=Trunc(S1);
  I2:=Trunc(S2);
  II:=0;
  While(II<I2)do Begin
   S:=II;
   J1:=J2;
   J2:=Trunc(T1+SLOPE*(S-S1));
   If(J1<>0)and(J2<>0)Then Begin
    JJ:=0;
    While(JJ<J2)do Begin
     For KK:=1to 3do Begin
      ICV[II,JJ,KK]:=1;
     End;
     Inc(JJ,JISIGN(1,J2-J1));
    End;
   End;
   Inc(II,JISign(1,I2-I1));
  End;
 End;

 For J:=1to(N)do Begin
  JTEST:=0;
  For I:=1to(M)do Begin
   If((ICV[I,J,1]=1)AND(ICV[I+1,J,1]=0))Then Inc(JTEST);
  End;
  If JTEST=2Then Begin
   ITEST:=0;
   For I:=1to M do Begin
    If((ICV[I,J,1]=1)AND(ICV[I+1,J,1]=0))Then Inc(ITEST);
    If ITEST=1Then Begin
     XC:=(1.0*I/M);
     YC:=(1.0-1.0*J/N);
     ZC:=1.0-(XC+YC);
     XYZTORGB(XR,YR,ZR,XG,YG,ZG,XB,YB,ZB,XC,YC,ZC,R,G,B);
     RMAX:=1.0-10;
     IF(R>RMAX)Then RMAX:=R;
     IF(G>RMAX)Then RMAX:=G;
     IF(B>RMAX)Then RMAX:=B;
     ICV[I,J,1]:=Trunc(L*Power((R/RMAX),GAM));
     ICV[I,J,2]:=Trunc(L*Power((G/RMAX),GAM));
     ICV[I,J,3]:=Trunc(L*Power((B/RMAX),GAM));
     R:=ICV[I,J,1];
     G:=ICV[I,J,2];
     B:=ICV[I,J,3];
     SetPixel(I,J,RGB2Color(Trunc(R*75),Trunc(G*75),Trunc(B*75)));
    End;
   End;
  End;
 End;


 {YY:=1.0;
 RMAX:=0.0;
 For J:=1to N do Begin
  For I:=1to M do Begin
   X:=(1.0*I/M);
   Y:=(1.0*(N-J)/N)+0.00001;
   XX:=X*YY/Y;
   ZZ:=(1.0-X-Y)*YY/Y;
   R:=(1.910*XX)-(0.532*YY)-(0.288*ZZ);
   G:=-(0.985*XX)+(1.999*YY)-(0.028*ZZ);
   B:=(0.058*XX)-(0.118*YY)+(0.898*ZZ);
   SSS:=(R+G+B)/3.0;
   R:=R/SSS;
   G:=G/SSS;
   B:=B/SSS;
   If(R<0)or(G<0)or(B<0)Then Begin
    R:=0.0;
    G:=0.0;
    B:=0.0;
   End;
   R:=Power(R,GAM);
   G:=Power(G,GAM);
   B:=Power(B,GAM);
   If(R>RMAX)Then RMAX:=R;
   If(G>RMAX)Then RMAX:=G;
   If(B>RMAX)Then RMAX:=B;
   SetPixel(I,J,RGB2Color(Trunc(R*75),Trunc(G*75),Trunc(B*75)));
  End;
 End;}
 ReadKey;
END.
