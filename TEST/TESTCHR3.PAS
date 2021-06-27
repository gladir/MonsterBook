Uses Adele,Systex,Systems,Math,Video;

Const
 XR=0.64;
 YR=0.33;
 XG=0.29;
 YG=0.60;
 XB=0.15;
 YB=0.06;
 XW=0.3127;
 YW=0.3291;
 GAM=0.8;
 ZR=1.0-(XR+YR);
 ZG=1.0-(XG+YG);
 ZB=1.0-(XB+YB);
 ZW=1.0-(XW+YW);

 M=400{100};
 N=400{100};
 wxy:Array[0..81]of Record
  X,Y:Real;
 End=(
  (X:0.1741;Y:0.0050),
  (X:0.1740;Y:0.0050),
  (X:0.1738;Y:0.0049),
  (X:0.1736;Y:0.0049),
  (X:0.1733;Y:0.0048),
  (X:0.1730;Y:0.0048),
  (X:0.1726;Y:0.0048),
  (X:0.1721;Y:0.0048),
  (X:0.1714;Y:0.0051),
  (X:0.1703;Y:0.0058 ),
  (X:0.1689;Y:0.0069 ),
  (X:0.1669;Y:0.0086 ),
  (X:0.1644;Y:0.0109 ),
  (X:0.1611;Y:0.0138 ),
  (X:0.1566;Y:0.0177 ),
  (X:0.1510;Y:0.0227 ),
  (X:0.1440;Y:0.0297 ),
  (X:0.1355;Y:0.0399 ),
  (X:0.1241;Y:0.0578 ),
  (X:0.1096;Y:0.0868 ),
  (X:0.0913;Y:0.1327 ),
  (X:0.0687;Y:0.2007 ),
  (X:0.0454;Y:0.2950 ),
  (X:0.0235;Y:0.4127 ),
  (X:0.0082;Y:0.5384 ),
  (X:0.0039;Y:0.6548 ),
  (X:0.0139;Y:0.7502 ),
  (X:0.0389;Y:0.8120 ),
  (X:0.0743;Y:0.8338 ),
  (X:0.1142;Y:0.8262 ),
  (X:0.1547;Y:0.8059 ),
  (X:0.1929;Y:0.7816 ),
  (X:0.2296;Y:0.7543 ),
  (X:0.2658;Y:0.7243 ),
  (X:0.3016;Y:0.6923 ),
  (X:0.3373;Y:0.6589 ),
  (X:0.3731;Y:0.6245 ),
  (X:0.4087;Y:0.5896 ),
  (X:0.4441;Y:0.5547 ),
  (X:0.4788;Y:0.5202 ),
  (X:0.5125;Y:0.4866 ),
  (X:0.5448;Y:0.4544 ),
  (X:0.5752;Y:0.4242 ),
  (X:0.6029;Y:0.3965 ),
  (X:0.6270;Y:0.3725 ),
  (X:0.6482;Y:0.3514 ),
  (X:0.6658;Y:0.3340 ),
  (X:0.6801;Y:0.3197 ),
  (X:0.6915;Y:0.3083 ),
  (X:0.7006;Y:0.2993 ),
  (X:0.7079;Y:0.2920 ),
  (X:0.7140;Y:0.2859 ),
  (X:0.7190;Y:0.2809 ),
  (X:0.7230;Y:0.2770 ),
  (X:0.7260;Y:0.2740 ),
  (X:0.7283;Y:0.2717 ),
  (X:0.7300;Y:0.2700 ),
  (X:0.7311;Y:0.2689 ),
  (X:0.7320;Y:0.2680 ),
  (X:0.7327;Y:0.2673 ),
  (X:0.7334;Y:0.2666 ),
  (X:0.7340;Y:0.2660 ),
  (X:0.7344;Y:0.2656 ),
  (X:0.7346;Y:0.2654 ),
  (X:0.7347;Y:0.2653 ),
  (X:0.7347;Y:0.2653 ),
  (X:0.7347;Y:0.2653 ),
  (X:0.7347;Y:0.2653 ),
  (X:0.7347;Y:0.2653 ),
  (X:0.7347;Y:0.2653 ),
  (X:0.7347;Y:0.2653 ),
  (X:0.7347;Y:0.2653 ),
  (X:0.7347;Y:0.2653 ),
  (X:0.7347;Y:0.2653 ),
  (X:0.7347;Y:0.2653 ),
  (X:0.7347;Y:0.2653 ),
  (X:0.7347;Y:0.2653 ),
  (X:0.7347;Y:0.2653 ),
  (X:0.7347;Y:0.2653 ),
  (X:0.7347;Y:0.2653 ),
  (X:0.7347;Y:0.2653 ),
  (X:0.1741;Y:0.0050 )
 );

Var
 Range:Array[0..N,0..1]of Integer;
{ ICV:Array[0..N,0..M]of Integer;}
 R, G, B:Real;


Procedure UpdateRange(I,J:Integer);Begin
 Dec(i);
 Dec(j);
 If(Range[i][0]>j)Then range[i][0]:=j;
 if(Range[i][1]<j)Then range[i][1]:=j;
End;

Procedure Compute;
Const
 BK=128;
Var
 i, j, ii, jj, i1, i2, j1, j2, itest, jtest:Integer;
 s, s1, s2, t1, t2, slope, RMAX:Real;
 c:XYZ;
 Q:RGB;
 ired, igreen, iblue:Integer;
 Kr:Word;
Begin
 j2:=0;
 For i:=0to M-1do Begin
  Range[i][0]:=10000;
  Range[i][1]:=-10000;
{  For j:=0to N-1do icv[i][j]:=0;}
 End;
 For j:=0to 80do Begin
  s1:=M*wxy[j].x;
  s2:=M*wxy[j+1].x;
  t1:=N*(1.0-wxy[j].y);
  t2:=N*(1.0-wxy[j+1].y);
  If s2-s1=0Then slope:=0.0
            Else slope:=(t2-t1)/(s2-s1);
  i1:=Trunc(s1+0.5);
  i2:=Trunc(s2+0.5);
  If(i1<i2)Then Begin
   For ii:=i1 to i2 do Begin
    s:=ii;
    j1:=j2;
    j2:=Trunc(t1+slope*(s-s1)+0.5);
    If(j1<>0)and(j2<>0)Then Begin
     If(j1<j2)Then Begin
      For jj:=j1 to j2 do Begin
       {icv[ii-1][jj-1]:=RGB2Color( 1*BK, 1*BK, 1*BK ); {was 255,1,1}
       SetPixel(ii-1,jj-1,RGB2Color( 1*BK, 1*BK, 1*BK ));
       UpdateRange(ii,jj);
      End
     End
      Else
     Begin
      For jj:=j2 to j1 do Begin
      { icv[ii-1][jj-1]:=RGB2Color(1*BK,1*BK,1*BK); { was 1,255,1}
       SetPixel(ii-1,jj-1,RGB2Color(1*BK,1*BK,1*BK));
       UpdateRange(ii,jj);
      End;
     End;
    End;
   End;
  End
   Else
  Begin
   For ii:=i1 downto i2+1do Begin
    s:=ii;
    j1:=j2;
    j2:=Trunc(t1+slope*(s-s1)+0.5);
    If(j1<>0)and(j2<>0)Then Begin
     If(j1<j2)Then Begin
      For jj:=j1 to j2 do Begin
       {icv[ii-1][jj-1]:=RGB2Color( 1*BK, 1*BK, 1*BK ); {was 200,200,0}
       SetPIxel(ii-1,jj-1,RGB2Color( 1*BK, 1*BK, 1*BK ));
       UpdateRange( ii, jj );
      End;
     End
      Else
     Begin
      For jj:=j2 to j1 do Begin
       {icv[ii-1][jj-1]:=RGB2Color( 1*BK, 1*BK, 1*BK ); {was 1, 1, 255}
       SetPixel(ii-1,jj-1,RGB2Color( 1*BK, 1*BK, 1*BK ));
       UpdateRange( ii, jj );
      End;
     End;
    End;
   End;
  End;
 End;
  { Calculate RGB Values for x and y coordinates}
 For j:=1to N do Begin
  jtest:=0;
  For i:=1to M do Begin
   Color2RGB(GetPixel(I-1,J-1),Q);
   If Q.R{<>0}=BK Then Begin
    Color2RGB(GetPixel(I,J-1),Q);
    If Q.R=0Then Inc(JTest);
   End;
   {If(((icv[i-1][j-1]and(255shl 16))=(1shl 16))and
     ((icv[i][j-1] and(255shl 16))=0))Then Inc(jtest);}
  End;
  If jtest=2Then Begin
   itest:=0;
   For i:=1to M do Begin
    {If(((icv[i-1][j-1]and(255shl 16))=(1shl 16))and
      ((icv[i][j-1] and(255shl 16))=0))Then Inc(jtest);}
   Color2RGB(GetPixel(I-1,J-1),Q);
   If Q.R=BK{<>0}Then Begin
    Color2RGB(GetPixel(I,J-1),Q);
    If Q.R=0Then Inc(JTest);
   End;

    If({itest}1=1)Then Begin
     C.x:=i/M;
     C.y:=1.0-j/N;
     C.z:=1.0-(C.x+C.y);
     xyz2rgb(C,Q);
     R:=Q.R;G:=Q.G;B:=Q.B;
     RMAX:=0.0000000001;
     if( R > RMAX )Then RMAX := R;
     if( G > RMAX )Then RMAX := G;
     if( B > RMAX )Then RMAX := B;
     ired :=Trunc(255.0*power( R/RMAX, GAM ) );
     igreen:=Trunc(255.0 * Power( G/RMAX, GAM ) );
     iblue:=Trunc(255.0 * power( B/RMAX, GAM ) );
     {icv[i-1][j-1] := RGB2Color( ired, igreen, iblue );}
     Kr:=RGB2Color( ired, igreen, iblue );
     {If Kr<>$FFDFThen{?} SetPixel(i-1,j-1,Kr);
    End;
   End;
  End;
 End;
End;

BEGIN
 InitSystems(suIsabel);
 SetVideoMode(vmGrf640x480c65536);
 Compute;
{ PutSmlImg(0,0,M-1,N-1,ICV);}
 ReadKey;
END.


      private int toRGB( int red, int green, int blue ) {
      return ( (255<<24) | (red<<16) | (green<<8) | blue );
      }


     /**
      * Checks if a point belongs to the chromaticity diagram.
      * @param i the absciss pixel number [0,m]
      * @param j the ordinate pixel number [0,n]
      * @return true if pixel belongs to the chromaticity diagram;
      * false otherwise.
      */
      public boolean isInRange( int i, int j ) {
      if( i < 0 || i >= M )
      return false;
              if( j < range[i][0] || j > range[i][1] )
              return false;
              return true;
              }


              private void xyz2rgb( float xc, float yc, float zc ) {

              R=(-XG*yc*ZB+xc*YG*ZB+XG*YB*zc-XB*YG*zc-xc*YB*ZG+XB*yc*ZG)/
              ( XR*YG*ZB-XG*YR*ZB-XR*YB*ZG+XB*YR*ZG+XG*YB*ZR-XB*YG*ZR);
              G=( XR*yc*ZB-xc*YR*ZB-XR*YB*zc+XB*YR*zc+xc*YB*ZR-XB*yc*ZR)/
              ( XR*YG*ZB-XG*YR*ZB-XR*YB*ZG+XB*YR*ZG+XG*YB*ZR-XB*YG*ZR);
              B=( XR*YG*zc-XG*YR*zc-XR*yc*ZG+xc*YR*ZG+XG*yc*ZR-xc*YG*ZR)/
              ( XR*YG*ZB-XG*YR*ZB-XR*YB*ZG+XB*YR*ZG+XG*YB*ZR-XB*YG*ZR);

              if( R < 0 ) R=0.f;
              if( G < 0 ) G=0.f;
              if( B < 0 ) B=0.f;
              if( R > 1 ) R=1.f;
              if( G > 1 ) G=1.f;
              if( B > 1 ) B=1.f;
              }


              }
