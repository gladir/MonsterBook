Uses Adele,Systex,Systems,Math,Video;

Var
 M,N,L:Integer;
 I,J:Integer;
 X,Y:Real;
 Gam:Real;      { Gamma }
 YY:Real;       { Luminance }
 XX,ZZ:Real;
 SSS:Real;
 RMAX:Real;     { Facteur scalaire }
 R,G,B:Real;

BEGIN
 InitSystems(suIsabel);
 SetVideoMode(vmGrf640x480c65536);
 M:=300;
 N:=200;
 L:=255;
 GAM:=1.0;
 YY:=1.0;
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
 End;
 ReadKey;
END.
