Uses Adele,Systex,Systems,Math,Video;

Const SIZE=400;
 GAM=0.8;

Var
 X,Y:Integer;
 Green:Integer;
 Red:Integer;
 RMax:Real;
 S:XYZ;
 T:RGB;

BEGIN
 InitSystems(suIsabel);
 SetVideoMode(vmGrf640x480c256);
{ For y:=0to SIZE-1do Begin
  Green:=(y*255)div(SIZE-1);
  If Green>255Then Green:=255;
  For x:=0to SIZE-1do Begin
   red:=(x*255)div(SIZE-1);
   If Red>255Then Red:=255;
   SetPixel(X,Y,RGB2Color(Red,Green,0));
  End;
 End;}
 For y:=0to SIZE-1do Begin
  For x:=0to SIZE-1do Begin
   S.X:=X/SIZE;
   S.Y:=1.0-Y/SIZE;
   S.Z:=1.0-(S.X+S.Y);
   RMAX:=0.0000000001;
   XYZ2RGB(S,T);
   if( T.R > RMAX )Then RMAX := T.R;
   if( T.G > RMAX )Then RMAX := T.G;
   if( T.B > RMAX )Then RMAX := T.B;
   T.R:=Trunc(255.0*power( T.R/RMAX, GAM ) );
   T.G:=Trunc(255.0 * Power( T.G/RMAX, GAM ) );
   T.B:=Trunc(255.0 * power( T.B/RMAX, GAM ) );
   SetPixel(X,Y,RGB2Color(T.R,T.G,T.B));
  End;
 End;
 ReadKey;
END.