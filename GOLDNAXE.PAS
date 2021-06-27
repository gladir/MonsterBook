{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                                                                         Û
 ³                       Malte Genesis/Golden Axe                          Û
 ³                                                                         Û
 ³            dition Chantal pour Mode R‚el/IV - Version 1.1              Û
 ³                              1995/11/30                                 Û
 ³                                                                         Û
 ³          Tous droits r‚serv‚s par les Chevaliers de Malte (C)           Û
 ³                                                                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Nom du programmeur
 ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

  Sylvain Maltais


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette unit‚ offre la possibilit‚ de manipuler … l'affichage des formes
 g‚om‚triques  trop  complexes  pour   ˆtre  g‚rer  par le  pilote vid‚o
 classique.
}

Unit GoldnAxe;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                  INTERFACE
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

{$I DEF.INC}
Uses
 Systex;

Const _LineWidth:Wd=1;
Var _Angle:Integer;

{$IFNDEF Adele}
 Procedure Circle(X,Y,Rayon:Integer;Kr:Word);
{$ENDIF}
Procedure Ellipse(x1,y1,x2,y2,LineWidth,Color:Integer);
Procedure FillArc(XO,YO,SAngle,EAngle,Radius,Kr:Word);
Procedure FillPoly(Num:Integer;Var P:Array of Integer;Color:Integer);
Procedure FloodFill(X,Y:Integer;Color:Word);
{$IFNDEF Adele}
 Procedure PutFillCircle(X,Y,Rayon:Integer;Kr:Wd);
 Procedure PutFillRoundRect(x1,y1,x2,y2,b,Kr:Integer);
{$ENDIF}
Procedure PutRotateRect(X1,Y1,X2,Y2,Kr:Integer);
{$IFNDEF Adele}
 Procedure PutRoundRect(x1,y1,x2,y2,LineWidth,b,Kr:Integer);
{$ENDIF}
Procedure Square(X,Y,L,Kr:Integer);
Procedure Triangle(X1,Y1,X2,Y2,X3,Y3,Kr:Integer);
Procedure _Arc(XO,YO,SAngle,EAngle,Radius:Word);
Procedure _Circle(X,Y,Rayon:Integer);
Procedure _PutFillCircle(X,Y,Rayon:Integer);
Procedure _PutRotateRect(X1,Y1,X2,Y2:Integer);

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                               IMPLEMENTATION
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses
 Adele,Memories,Systems,Video,Math;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Fonction Sign                           Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet d'indiquer un peu comme l'interpr‚teur BASIC le
 fesait, si un nombre entier est positif (1), n‚gatif (-1)  ou ‚gal … 0
 avec la valeur 0.
}

Function Sign(x:Integer):Integer;Near;Begin
 If x>0Then Sign:=1 Else
 If x=0Then Sign:=0
       Else Sign:=-1;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure FillPoly                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de remplir la surface d'un polygone avec une
 couleurs particuliŠre.
}

Procedure FillPoly;
Var
 dx,dy,dxabs,dyabs,i,Index,j,k,px,py,sdx,sdy,x,y,toggle,OldSDY,sy0:Integer;
 XC,YC:^TInteger;
Begin
 Index:=0;I:=Num shl 1;
 P[I]:=P[0];P[I+1]:=P[1];
 If I<=5Then Exit;
 XC:=MemAlloc(4000*SizeOf(Integer));
 YC:=MemAlloc(4000*SizeOf(Integer));
 px:=P[0];py:=P[1];
 If P[1]=P[3]Then Begin
  XC^[Index]:=PX;
  YC^[Index]:=PY;
  Inc(Index)
 End;
 J:=0;
 While j<i-2do Begin
  dx:=P[j+2]-P[j];dy:=P[j+3]-P[j+1];
  sdx:=Sign(dx);sdy:=Sign(dy);
  If j=0Then Begin
   OldSDY:=sdy;
   sy0:=sdy;
  End;
  dxabs:=AbsInt(dx);dyabs:=AbsInt(dy);
  x:=0;y:=0;
  If(dxabs>=dyabs)Then Begin
   For k:=0to dxabs-1do Begin
    Inc(y,dyabs);
    If(y>=dxabs)Then Begin
     Dec(y,dxabs);Inc(py,sdy);
     If(OldSDY<>sdy)Then Begin
      OldSDY:=sdy;
      Dec(Index)
     End;
     XC^[Index]:=px+sdx;
     YC^[index]:=py;
     Inc(Index)
    End;
    Inc(px,sdx);
{    SetPixel(px,py,Kr)}
   End;
  End
   else
  Begin
   For k:=0to dyabs-1do Begin
    Inc(x,dxabs);
    If(x>=dyabs)Then Begin
     Dec(x,dyabs);
     Inc(px,sdx)
    End;
    Inc(py,sdy);
    If(OldSDY<>sdy)Then Begin
     OldSDY:=sdy;
     If sdy<>0Then Dec(Index)
    End;
{    SetPixel(px,py,Kr);}
    XC^[Index]:=px;
    YC^[Index]:=py;
    Inc(Index)
   End;
  End;
  Inc(j,2)
 End;
 Dec(Index);
 If sy0+sdy=0Then Dec(Index);
 QuickSort2(Index,XC^,YC^);
 Toggle:=0;
 For I:=0to Index-1do Begin
  If(YC^[I]=YC^[I+1])and(Toggle=0)Then Begin
   PutLnHor(XC^[I],YC^[I],XC^[I+1],Color);
   Toggle:=1;
  End
   else
  Toggle:=0;
 End;
 FreeMemory(XC,4000*SizeOf(Integer));
 FreeMemory(YC,4000*SizeOf(Integer));
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure Circle                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de tracer un cercle en utilisant la formule
 math‚matique des ®SIN¯ et des ®COS¯.


 Remarque
 ÍÍÍÍÍÍÍÍ

  ş A  partir  de  l'ensemble  Malte Genesis V:  Alias AdŠle,  cette
    routine est directement inclus dans le pilote vid‚o et n'utilise
    la fameuse formule SIN et COS  mais celle des carr‚es de Beziers
    afin d'obtenir des meilleures performances et de ne pas utiliser
    le coprocesseur math‚matique.
}

{$IFNDEF Adele}
Procedure Circle;
{$IFDEF RealMethode}
 Var
  _End,Step,I:Real;
  A,B:Integer;
{$ENDIF}
Begin
 If(IsGraf)Then Begin
  {$IFDEF RealMethode}
   _End:=11/7;Step:=_End/(Rayon shl 1);I:=0;
   Repeat
    A:=Trunc(Cos(I)*Rayon);
    B:=Trunc(Sin(I)*Rayon);
    SetPixel(X+A,Y+B,Kr);
    SetPixel(X+A,Y-B,Kr);
    SetPixel(X-A,Y+B,Kr);
    SetPixel(X-A,Y-B,Kr);
    I:=I+Step;
   Until I>_End;
  {$ELSE}
   PutRoundRect(x-Rayon,y-Rayon,x+Rayon,y+Rayon,1,Rayon,Kr);
  {$ENDIF}
 End;
End;
{$ENDIF}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Proc‚dure Ellipse                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'afficher un ellipse totalement vide avec
 la couleur sp‚cifier.
}

Procedure Ellipse(x1,y1,x2,y2,LineWidth,Color:Integer);
Var
 B,A:Integer;
Begin
 B:=AbsInt(X2-X1)shr 1;A:=AbsInt(Y2-Y1)shr 1;
 If(A<B)Then B:=A;
 PutRoundRect(x1,y1,x2,y2,LineWidth,B,Color);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Proc‚dure PutFillCircle                   Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet  de tracer un  cercle totalement remplis en
 utilisant la formule math‚matique des ®SIN¯ et des ®COS¯.


 Remarque
 ÍÍÍÍÍÍÍÍ

  ş A  partir  de  l'ensemble  Malte Genesis V:  Alias AdŠle,  cette
    routine est directement inclus dans le pilote vid‚o et n'utilise
    la fameuse formule SIN et COS  mais celle des carr‚es de Beziers
    afin d'obtenir des meilleures performances et de ne pas utiliser
    le coprocesseur math‚matique.
}

{$IFNDEF Adele}
Procedure PutFillCircle;
{$IFDEF RealMethode}
 Var
  _End,Step,I:Real;
  A,B:Integer;
{$ENDIF}
Begin
 If(IsGraf)Then Begin
  {$IFDEF RealMethode}
   _End:=11/7; Step:=_End/(Rayon shl 1); I:=0;
   Repeat
    A:=Trunc(Cos(I)*Rayon); B:=Trunc(Sin(I)*Rayon);
    PutLnHor(X-A,Y-B,X+A,Kr);
    PutLnHor(X-A,Y+B,X+A,Kr);
    I:=I+Step;
   Until I>_End;
  {$ELSE}
   PutFillRoundRect(x-Rayon,y-Rayon,x+Rayon,y+Rayon,Rayon,Kr);
  {$ENDIF}
 End;
End;
{$ENDIF}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Proc‚dure PutRotateRect                    Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'afficher un rectangle sous un cercle angle
 particulier (en degr‚s).
}

Procedure PutRotateRect;
Var
 nx1,nx2,nx3,nx4,ny1,ny2,ny3,ny4,x1C,y1C,x2C,y2C,LineWidth2:Integer;
 Angle,AngleCos,AngleSin,CosX1,SinX1,CosX2,SinX2:Real;
Begin
 Angle:=0.01745329*(360-_Angle);
 AngleCos:=Cos(Angle);
 AngleSin:=Sin(Angle);
 CosX1:=x1C*AngleCos; SinX1:=x1C*AngleSin; CosX2:=x2C*AngleCos; SinX2:=x2C*AngleSin;
 x1C:=x1-VidBnkSwitch.XL; y1C:=y1-VidBnkSwitch.YL;
 x2C:=x2-VidBnkSwitch.XL; y2C:=y2-VidBnkSwitch.YL;
 nx1:=Trunc(CosX1-y1C*AngleSin+VidBnkSwitch.XL);
 ny1:=Trunc(SinX1+y1C*AngleCos+VidBnkSwitch.YL);
 nx3:=Trunc(CosX2-y2C*AngleSin+VidBnkSwitch.XL);
 ny3:=Trunc(SinX2+y2C*AngleCos+VidBnkSwitch.YL);
 nx2:=Trunc(CosX2-y2C*AngleSin+VidBnkSwitch.XL);
 ny2:=Trunc(SinX2+y2C*AngleCos+VidBnkSwitch.YL);
 nx4:=Trunc(CosX1-y1C*AngleSin+VidBnkSwitch.XL);
 ny4:=Trunc(SinX1+y1C*AngleCos+VidBnkSwitch.YL);
 LineWidth2:=_LineWidth shr 1;
 PutLn(nx1-LineWidth2,ny1,nx2+LineWidth2,ny2,Kr);
 PutLn(nx2-LineWidth2,ny2,nx3+LineWidth2,ny3,Kr);
 PutLn(nx3,ny3+LineWidth2,nx4,ny4-LineWidth2,Kr);
 PutLn(nx4,ny4+LineWidth2,nx1,ny1-LineWidth2,Kr);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Proc‚dure PutRoundRect                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure offre la possibilit‚ d'afficher un rectangle vide avec les
 coins totalement rond.


 Remarque
 ÍÍÍÍÍÍÍÍ

  ş A  partir  de  l'ensemble  Malte Genesis V:  Alias AdŠle,  cette routine
    est  directement  inclus  dans le  pilote vid‚o  et n'utilise la fameuse
    formule SIN et COS  mais celle des carr‚es de Beziers afin d'obtenir des
    meilleures   performances  et   de  ne   pas  utiliser  le  coprocesseur
    math‚matique.
}

Procedure PutRoundRect(x1,y1,x2,y2,LineWidth,b,Kr:Integer);
Var
 a,xr,yr,x,i,j,y,xN,yN:Integer;
 AO,BO,AO2,BO2,AO4,BO4,d:LongInt;
Begin
 If LineWidth>0Then Dec(LineWidth);
 y:=y1;y1:=y2;y2:=y;yr:=b;xr:=b;xN:=x2-xr;yN:=y2+yr;
 For j:=-(LineWidth shr 1)to LineWidth shr 1+(LineWidth and 1)do Begin
  PutLnHor(x1+xr,y1-j,xN,Kr);
  PutLnHor(x1+xr,y2-j,xN,Kr);
 End;
 For j:=-(LineWidth shr 1)to LineWidth shr 1+(LineWidth and 1)do Begin
  For i:=y1-yr downto(yN)do Begin
   Plot(x1+j,i,Kr);
   Plot(x2+j,i,Kr)
  End;
 End;
 Dec(b,LineWidth shr 1);a:=b;
 For i:=0to(LineWidth)do Begin
  BO:=b*b;AO:=a*a;y:=b;x:=0;
  ASM
    {AO2:=AO shl 1}
   LES AX,AO
   MOV DX,ES
   SHL AX,1
   RCL DX,1
   MOV Word Ptr AO2,AX
   MOV Word Ptr AO2[2],DX
    {AO4:=AO shl 2;}
   SHL AX,1
   RCL DX,1
   MOV Word Ptr AO4,AX
   MOV Word Ptr AO4[2],DX
    {BO2:=BO shl 1;}
   LES AX,BO
   MOV DX,ES
   SHL AX,1
   RCL DX,1
   MOV Word Ptr BO2,AX
   MOV Word Ptr BO2[2],DX
    {BO4:=BO shl 2;}
   SHL AX,1
   RCL DX,1
   MOV Word Ptr BO4,AX
   MOV Word Ptr BO4[2],DX
  END;
  d:=MulL(AO2,(y-1)*y)+AO+MulL(BO2,1-AO);
  While(MulL(AO,y)>MulL(BO,x))do Begin
   Plot(x+xN,yN-y,Kr);
   Plot(x+xN,y1-yr+y,Kr);
   Plot(x1+xr-x,yN-y,Kr);
   Plot(x1+xr-x,y1-yr+y,Kr);
   If d>=0Then Begin
    Dec(y);
    Dec(d,MulL(AO4,y))
   End;
   Inc(d,MulL(BO2,3+(x shl 1)));Inc(x);
  End;
  d:=MulL(BO2,(x+1)*x)+MulL(AO2,y*(y-2)+1)+MulL(1-AO2,BO);
  While y<>0do Begin
   Plot(x+xN,yN-y,Kr);
   Plot(x+xN,y1-yr+y,Kr);
   Plot(x1+xr-x,yN-y,Kr);
   Plot(x1+xr-x,y1-yr+y,Kr);
   if d<=0Then Begin
    Inc(x);
    Inc(d,MulL(BO4,x))
   End;
   Dec(y);Inc(d,MulL(AO2,3-(y shl 1)));
  End;
  Inc(b);Inc(a);
 End;
End;

{$IFNDEF Adele}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Proc‚dure PutFillRoundRect                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure offre la  possibilit‚  d'afficher  un rectangle plein avec
 les coins totalement rond.


 Remarque
 ÍÍÍÍÍÍÍÍ

  ş A  partir  de  l'ensemble  Malte Genesis V:  Alias AdŠle,  cette routine
    est  directement  inclus  dans le  pilote vid‚o  et n'utilise la fameuse
    formule SIN et COS  mais celle des carr‚es de Beziers afin d'obtenir des
    meilleures   performances  et   de  ne   pas  utiliser  le  coprocesseur
    math‚matique.
}

Procedure PutFillRoundRect(x1,y1,x2,y2,b,Kr:Int);
Var
 a,xr,yr,x,i,j,y,xN,yN:Integer;
 AO,BO,AO2,BO2,AO4,BO4,d:LongInt;
Begin
 y:=y1;y1:=y2;y2:=y;yr:=b;xr:=b;xN:=x1+xr;yN:=y1-yr;
 If Not(y2+b>=yN)Then PutFillBox(x1,y2+b,x2,yN,Kr);
 Dec(b,0);a:=b;
 For i:=0to 0do Begin
  BO:=b*b;AO:=a*a;y:=b;x:=0;
  ASM
    {AO2:=AO shl 1}
   LES AX,AO
   MOV DX,ES
   SHL AX,1
   RCL DX,1
   MOV Word Ptr AO2,AX
   MOV Word Ptr AO2[2],DX
    {AO4:=AO shl 2;}
   SHL AX,1
   RCL DX,1
   MOV Word Ptr AO4,AX
   MOV Word Ptr AO4[2],DX
    {BO2:=BO shl 1;}
   LES AX,BO
   MOV DX,ES
   SHL AX,1
   RCL DX,1
   MOV Word Ptr BO2,AX
   MOV Word Ptr BO2[2],DX
    {BO4:=BO shl 2;}
   SHL AX,1
   RCL DX,1
   MOV Word Ptr BO4,AX
   MOV Word Ptr BO4[2],DX
  END;
  d:=MulL(AO2,(y-1)*y)+AO+MulL(BO2,1-AO);
  While(MulL(AO,y)>MulL(BO,x))do Begin
   PutLnHor(xN-y,yN+x,x2-yr+y,Kr);
   PutLnHor(xN-y,y2+xr-x,x2-yr+y,Kr);
   If d>=0Then Begin;Dec(y);Dec(d,MulL(AO4,y))End;
   Inc(d,MulL(BO2,3+(x shl 1)));Inc(x);
  End;
  d:=MulL(BO2,(x+1)*x)+MulL(AO2,y*(y-2)+1)+MulL(1-AO2,BO);
  While y<>0do Begin
   PutLnHor(xN-y,x+yN,x2-yr+y,Kr);
   PutLnHor(xN-y,y2+xr-x,x2-yr+y,Kr);
   if d<=0Then Begin
    Inc(x);
    Inc(d,MulL(BO4,x))
   End;
   Dec(y);
   Inc(d,MulL(AO2,3-(y shl 1)));
  End;
  Inc(b);Inc(a);
 End;
End;
{$ENDIF}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Proc‚dure Square                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'afficher un carr‚ vide parfait au point de vue
 pixel mais pas n‚cessairement au point de vue de l'oeil.
}

Procedure Square;Begin
 PutRect(X,Y,X+L-1,Y+L-1,Kr)
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure Triangle                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure offre la possibilit‚ d'afficher un triangle vide d'une
 couleur sp‚cifier par la variable de param‚trage ®Kr¯.
}

Procedure Triangle;Begin
 PutLn(X1,Y1,X2,Y2,Kr);
 PutLn(X2,Y2,X3,Y3,Kr);
 PutLn(X3,Y3,X1,Y1,Kr);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure _Circle                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure offre la possibilit‚ d'afficher un cercle vide avec la
 couleur graphique courante.
}

Procedure _Circle;Begin
 Circle(X,Y,Rayon,GraphColor)
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure _PutFillCircle                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure offre la possibilit‚ d'afficher un cercle plein avec la
 couleur graphique courante.
}

Procedure _PutFillCircle;Begin
 PutFillCircle(X,Y,Rayon,GraphColor)
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Proc‚dure _PutRotateRect                   Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'afficher un rectangle sous un cercle angle
 particulier (en degr‚s) avec la couleur graphique courante.
}

Procedure _PutRotateRect;Begin
 PutRotateRect(X1,Y1,X2,Y2,GraphColor)
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Proc‚dure _Arc                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de tracer l'arc d'un cercle dans un intervalle
 radian donn‚e.
}

Procedure _Arc{XO,YO,SAngle,EAngle,Radius:Word};
Const
 RadToDeg=180/Pi;
Var
 p:Integer;
 x,y:Word;
 Alpha:Real;
Begin
 If Radius=0Then Begin
  _SetPixel(XO,YO);
  Exit;
 End;
 Inc(SAngle,271);Inc(EAngle,271);
 SAngle:=SAngle mod 361;
 EAngle:=EAngle mod 361;
 If(SAngle>EAngle)Then Begin
  SAngle:=SAngle Xor EAngle;
  EAngle:=EAngle Xor SAngle;
  SAngle:=EAngle Xor SAngle;
 End;
 x:=0;y:=Radius;p:=3-2*Radius;
 While(x<=y)do Begin
  Alpha:=RadToDeg*Arctan(x/y);
  If(Alpha>=SAngle)and(Alpha<=EAngle)Then _SetPixel(XO-x,YO-y);
  If(90-Alpha>=SAngle)and(90-Alpha<=EAngle)Then _SetPixel(XO-y,YO-x);
  If(90+Alpha>=SAngle)and(90+Alpha<=EAngle)Then _SetPixel(XO-y,YO+x);
  If(180-Alpha>=SAngle)and(180-Alpha<=EAngle)Then _SetPixel(XO-x,YO+y);
  If(180+Alpha>=SAngle)and(180+Alpha<=EAngle)Then _SetPixel(XO+x,YO+y);
  If(270-Alpha>=SAngle)and(270-Alpha<=EAngle)Then _SetPixel(XO+y,YO+x);
  If(270+Alpha>=SAngle)and(270+Alpha<=EAngle)Then _SetPixel(XO+y,YO-x);
  If(360-Alpha>=SAngle)and(360-Alpha<=EAngle)Then _SetPixel(XO+x,YO-y);
  If p<0Then Inc(p,4*x+6)
        Else Begin;Inc(p,4*(x-y)+10);Dec(y)End;
  Inc(x);
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Proc‚dure FillArc                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de tracer l'arc d'un cercle dans un intervalle
 radian  donn‚e  de fa‡on  pleine  et ainsi  il rejoindre  le centre du
 centre tel une pointe de tarte.
}

Procedure IFillArc(XO,YO,SAngle,EAngle,Radius,Kr:Word;UpDate:Bool);
Const RadToDeg=180/Pi;DegToRad=Pi/180;
Var
 p:Integer;
 x,y,SX,MX:Word;
 Alpha:Real;
 XC,YC:Array[0..1999]of Integer;
 J,I,Index:Integer;

 Procedure PutLn(X1,Y1,X2,Y2:Word);
 Var
  D,DX,DY,I,J,Ainc,Binc,Ic:Integer;
 Begin
  If(Y2=Y1)Then Begin
   XC[Index]:=X1;YC[Index]:=Y1;Inc(Index);
   XC[Index]:=X2;YC[Index]:=Y2;Inc(Index);
   Exit;
  End;
  If AbsInt(X2-X1)<AbsInt(Y2-Y1)Then Begin
   If(Y1>Y2)Then ASM
    MOV AX,X1
    XCHG AX,X2
    MOV X1,AX
    MOV AX,Y1
    XCHG AX,Y2
    MOV Y1,AX
   END;
   If(X2>X1)Then Ic:=1
            Else Ic:=-1;
   DY:=Y2-Y1;DX:=AbsInt(X2-X1);D:=(DX shl 1)-DY;Ainc:=(DX-DY)shl 1;Binc:=DX shl 1;J:=X1;
   XC[Index]:=X1;YC[Index]:=Y1;Inc(Index);
   I:=Y1+1;
   While(I<=Y2)do Begin
    If D>=0Then Begin
     Inc(J,Ic);
     Inc(D,Ainc)
    End
     Else
    Inc(D,Binc);
    XC[Index]:=J;YC[Index]:=I;Inc(Index);
    Inc(I);
   End;
  End
   else
  Begin
   If(X1>X2)Then ASM
    MOV AX,X1
    XCHG AX,X2
    MOV X1,AX
    MOV AX,Y1
    XCHG AX,Y2
    MOV Y1,AX
   END;
   If(Y2>Y1)Then Ic:=1 else Ic:=-1;
   DX:=X2-X1;DY:=AbsInt(Y2-Y1);D:=(DY shl 1)-DX;AInc:=(DY-DX)shl 1;BInc:=DY shl 1;J:=Y1;
   XC[Index]:=X1;YC[Index]:=Y1;Inc(Index);
   I:=X1+1;
   While(I<=X2)do Begin
    If D>=0Then Begin Inc(J,Ic);Inc(D,Ainc)End else Inc(D,Binc);
    XC[Index]:=I;YC[Index]:=J;Inc(Index);
    Inc(I);
   End;
  End;
 End;

Begin
 If Radius=0Then Begin
  SetPixel(XO,YO,Kr);
  Exit;
 End;
 Index:=0;
 If(UpDate)Then Begin
  Inc(SAngle,271);
  Inc(EAngle,271)
 End;
 SAngle:=SAngle mod 361;
 EAngle:=EAngle mod 361;
 If(SAngle>EAngle)Then Begin
  SAngle:=SAngle Xor EAngle;
  EAngle:=EAngle Xor SAngle;
  SAngle:=EAngle Xor SAngle;
 End;
 x:=0;y:=Radius;p:=3-2*Radius;
 While(x<=y)do Begin
  Alpha:=RadToDeg*Arctan(x/y);
  If(Alpha>=SAngle)and(Alpha<=EAngle)Then Begin
   XC[Index]:=XO-x;YC[Index]:=YO-y;Inc(Index)
  End;
  If(90-Alpha>=SAngle)and(90-Alpha<=EAngle)Then Begin
   XC[Index]:=XO-y;YC[Index]:=YO-x;Inc(Index)
  End;
  If(90+Alpha>=SAngle)and(90+Alpha<=EAngle)Then Begin
   XC[Index]:=XO-y;YC[Index]:=YO+x;Inc(Index)
  End;
  If(180-Alpha>=SAngle)and(180-Alpha<=EAngle)Then Begin
   XC[Index]:=XO-x;YC[Index]:=YO+y;Inc(Index)
  End;
  If(180+Alpha>=SAngle)and(180+Alpha<=EAngle)Then Begin
   XC[Index]:=XO+x;YC[Index]:=YO+y;Inc(Index)
  End;
  If(270-Alpha>=SAngle)and(270-Alpha<=EAngle)Then Begin
   XC[Index]:=XO+y;YC[Index]:=YO+x;Inc(Index)
  End;
  If(270+Alpha>=SAngle)and(270+Alpha<=EAngle)Then Begin
   XC[Index]:=XO+y;YC[Index]:=YO-x;Inc(Index)
  End;
  If(360-Alpha>=SAngle)and(360-Alpha<=EAngle)Then Begin
   XC[Index]:=XO+x;YC[Index]:=YO-y;Inc(Index)
  End;
  If p<0Then Inc(p,(x shl 2)+6)
   Else
  Begin
   Inc(p,((x-y)shl 2)+10);
   Dec(y)
  End;
  Inc(x);
 End;
 PutLn(XO,YO,XO-Trunc(Sin(DegToRad*SAngle)*Radius),
       YO-Trunc(Cos(DegToRad*SAngle)*Radius));
 PutLn(XO,YO,XO-Trunc(Sin(DegToRad*EAngle)*Radius),
       YO-Trunc(Cos(DegToRad*EAngle)*Radius));
 QuickSort2(Index-1,XC,YC);
 I:=0;
 While(I<Index)do Begin
  If YC[I]=YC[I+1]Then Begin
   J:=I+1;MX:=XC[I];SX:=XC[I];
   While(YC[I]=YC[J])and(J<Index)do Begin
    If SX>XC[J]Then SX:=XC[J];
    If MX<XC[J]Then MX:=XC[J];
    Inc(J);
   End;
   PutLnHor(XC[I],YC[I],MX,Kr);
   I:=J;
  End
   Else
  Inc(I);
 End;
End;

Procedure FillArc{XO,YO,SAngle,EAngle,Radius,Kr:Word};Begin
 If(SAngle=0)and(EAngle=360)Then PutFillCircle(XO,YO,Radius,Kr)
  Else
 IFillArc(XO,YO,SAngle,EAngle,Radius,Kr,True);
End;

Procedure FloodFill{X,Y:Integer;Color:Word};
Var
 C2:Word;

 Procedure PredLine(L,R,Y:Integer;UpDown:Byte);Near;
 Var
  X,X2:Integer;
 Begin
  If(GetPixel(L,Y)=C2)Then While(L>0)and(GetPixel(L-1,Y)=C2)do Dec(L);
  X:=L;
  If(GetPixel(R,Y)=C2)Then While(R<GetNumXPixels)and(GetPixel(R+1,Y)=C2)do Inc(R);
  While(X<=R)do Begin
   X2:=X;
   If(GetPixel(X,Y)=C2)Then Begin
    While(GetPixel(X+1,Y)=C2)and(X<GetNumXPixels)do Inc(X);
    PutLineHori(X2,Y,X,Color);
    If UpDown=2Then Begin
     If Y>0Then PredLine(X2,X,Y-1,2);
     If(Y<GetNumYPixels)Then If(L>X2)and(R<X)Then Begin
      PredLine(X2,L-1,Y+1,1);
      PredLine(R+1,X,Y+1,1);
     End
      Else
     If(L<=X2)and(R<X)Then PredLine(R+1,X,Y+1,1)Else
     If(L>X2)and(R>=X)Then PredLine(X2,L-1,Y+1,1);
    End;
    If UpDown=1Then Begin
     If(Y<GetNumYPixels)Then PredLine(X2,X,Y+1,1);
     If Y>0Then If(L>X2)and(R<X)Then Begin
      PredLine(X2,L-1,Y-1,2);
      PredLine(R+1,X,Y-1,2);
     End
      Else
     If(L<=X2)and(R<X)Then PredLine(R+1,X,Y-1,2)Else
     If(L>X2)and(R>=X)Then PredLine(X2,L-1,Y-1,2);
    End;
   End;
   Inc(X);
  End;
 End;

Begin
 C2:=GetPixel(X,Y);
 If Y<>0Then Dec(Y);
 PredLine(X,X,Y,2);
 PredLine(X,X,Y+1,1);
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
END.