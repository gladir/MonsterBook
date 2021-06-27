{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                                                                         Û
 ³                    Malte Genesis/Arcade & Animation                     Û
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

  Cette unit‚ permet de produire des animations classique et des effets pour
 arcade dans des applications respectable ou des jeux vid‚o.
}

Unit Arcade;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                 INTERFACE
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

{$I DEF.INC}

Uses Systex;

Const
 ssRandom=0;         { Animation al‚atoire (tous combiners)}
 ssAniStar3D=1;      { Animation d'‚toiles en trois dimensions }
 ssAniMixingStar=2;  { Animation d'effet d'apparition et de disparition }
 ssAniStarPlus=3;    { Animation d'‚toiles en forme de plus }
 ssAniStar=4;        { Animation de d‚placement horizontal }
 ssAniMystify=5;     { Animation d'ondulation de B‚zier }

  {Animation d'ondulation de B‚zier}
 NumControlPoints=7;
 QueueSize=10;
 MaxDelta=15;

  {Animation d'‚toile en 3 dimensions}
 NofStars=50;

  {Animation d'effet d'apparition et de disparition d'‚toile}
 MixingMaxX=320;
 MixingMaxY=200;

 CurrScrnSaver:Byte=ssRandom;

Type
 PacManBoardRec=Array[0..16]of String[20];

  {Animation Mystify}
 BaisMatrixType=Array[0..3]of Real;
 ControlPtsType=Array[0..1]of Real;

 AniMystifyRec=Record
  X1,Y1,X2,Y2:Byte;
  NumXPixels,NumYPixels,GX1,GY1:Word;
  Index,Color:Integer;
  Vertices:Array[0..NumControlPoints]of PointType;
  Deltas:Array[0..NumControlPoints]of PointType;
  Queue:Array[0..QueueSize]of Array[0..NumControlPoints]of PointType;
 End;

  {Animation d'‚toile en 3D}
 StarRec=Record
  X,Y,Z:Integer;
 End;

 StarPos=Array[0..NofStars]of StarRec;
 StarSpd=Array[0..NofStars]of Word;

 AniStar3DRec=Record
  X1,Y1,X2,Y2:Byte;
  NumXPixels,NumYPixels,GX1,GY1:Word;
  Stars:StarPos;
  Speed:StarSpd;
  Xc,Yc,ZFactor:Word;
 End;

 AniStarRec=Record
  X1,Y1,X2,Y2:Byte;
  NumXPixels,NumYPixels,GX1,GY1:Word;
  I:Word;
  Etoiles:Array[0..500]of Record
   X,Y,Plan:Integer;
  End;
 End;

 AniStarPlusRec=Record
  X1,Y1,X2,Y2:Byte;
  NumXPixels,NumYPixels,GX1,GY1:Word;
  BitMask:Array[0..1,0..4,0..4]of Byte;
  Stars:Array[1..100]of Record
   XP,YP:Word;
   Phase,Col:Byte;
   Dur:ShortInt;
   Active:Boolean;
  End;
 End;

  {Animation d'apparition et de disparition d'‚toile}
 Arr=Array[0..1000]of LongInt;

 AniMixingStarRec=Record
  X1,Y1,X2,Y2:Byte;
  NumXPixels,NumYPixels,GX1,GY1:Word;
  Init:Boolean;
  RGB:Array[0..767]of Byte;
  TrueKr:Array[0..255]of Word;
  FX:Array[0..MixingMaxX-1]of Byte;
  FY:Array[0..MixingMaxY-1]of Byte;
  P:Array[0..1000]of^Arr;
  W,N,K,RK:Word;
  J:Byte;
 End;

Function  AniMixingStar:Boolean;
Procedure AniMystify;
Procedure AniStar;
Procedure AniStar3D;
Function  AniStarPlus:Boolean;
Procedure Ecoule;
Procedure FadeIn(Delay:Byte;Var SavePalette);
Procedure FadeOut;
Procedure PacManBoard(Const T:PacManBoardRec);
Procedure RunScrnSaver;
Procedure ScrnSaverAni;
Procedure ScrnSaverPacMan;
Procedure ScrollPage1to0;
Function  SelScrnSaver:Byte;
Procedure SetStartScreen(T:Word);
Procedure SqueezeScreen(Var Image);
Procedure TxtBox;
Procedure VPan(Y:Byte);
Procedure Wait7;
Function  YesNo(Const Msg:String):Boolean;
Function  _InitMixingStar(Var Q:AniMixingStarRec;X1,Y1,X2,Y2:Byte):Boolean;
Procedure _InitMystify(Var Q:AniMystifyRec;X1,Y1,X2,Y2:Byte);
Procedure _InitStar(Var Q:AniStarRec;X1,Y1,X2,Y2:Byte);
Procedure _InitStar3D(Var Q:AniStar3DRec;X1,Y1,X2,Y2:Byte);
Procedure _InitStarPlus(Var Q:AniStarPlusRec;X1,Y1,X2,Y2:Byte);
Procedure _AniMystify(Var Q:AniMystifyRec);
Procedure _AniMixingStar(Var Q:AniMixingStarRec);
Procedure _AniStar(Var Q:AniStarRec);
Procedure _AniStar3D(Var Q:AniStar3DRec);
Procedure _AniStarPlus(Var Q:AniStarPlusRec);
Procedure _DoneMixingStar(Var Q:AniMixingStarRec);

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                               IMPLEMENTATION
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses Adele,Memories,Systems,Video,Mouse,Dials,Tools;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Fonction _InitMixingStar                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet d'initialiser l'affichage d'un ‚conomiseur d'‚cran
 avec des ‚toiles apparaissant et disparaissant. Cependant  si l'op‚ration
 n'est vraiment pas possible alors un valeur faux est retourn‚e.
}

Function _InitMixingStar(Var Q:AniMixingStarRec;X1,Y1,X2,Y2:Byte):Boolean;
Var
 X,Y,L,I,P:Word;
Begin
 _InitMixingStar:=False;
 FillClr(Q,SizeOf(Q));
 Q.X1:=X1;Q.Y1:=Y1;Q.X2:=X2;Q.Y2:=Y2;
 If X1=0Then Begin
  ClrScrBlack;
  Q.NumXPixels:=GetNmXPixels;
  Q.NumYPixels:=GetNmYPixels;
 End
  Else
 Begin
  ClrWn(X1,Y1,X2,Y2,Black);
  Q.NumXPixels:=(X2-X1+1)shl 3;
  Q.NumYPixels:=GetRawY(Y2-Y1+1);
 End;
 Q.GX1:=X1 shl 3;Q.GY1:=GetRawY(Y1);
 For X:=0to 63do Begin
  Y:=X*3;
  Q.RGB[Y+0]:=63 shl 2;     Q.RGB[Y+1]:=(63-X)shl 2;  Q.RGB[Y+2]:=0;
  Q.RGB[Y+192]:=(63-X)shl 2;Q.RGB[Y+193]:=X shl 2;    Q.RGB[Y+194]:=0;
  Q.RGB[Y+384]:=0;          Q.RGB[Y+385]:=(63-X)shl 2;Q.RGB[Y+386]:=X shl 2;
  Q.RGB[Y+576]:=X shl 2;    Q.RGB[Y+577]:=X shl 2;    Q.RGB[Y+578]:=(63-X)shl 2;
 End;
 For X:=0to 319do Q.FX[X]:=Byte(Trunc((Sin(PI*X/(NmXPixels shr 1))+1)*200));
 For Y:=0to 199do Q.FY[Y]:=Byte(Trunc((Cos(PI*Y/(NmYPixels shr 1))+1)*100));
 Q.N:=NmXPixels*NmYPixels;
 L:=0;
 For I:=0to(Q.N)do If I mod 1000=0Then Begin
  Q.P[L]:=MemAlloc(SizeOf(Arr));
  If(Q.P[L]=NIL)Then Begin
   For I:=0to L-1do FreeMemory(Q.P[I],SizeOf(Arr));
   Exit;
  End;
  Inc(L);
 End;
 If X1=0Then SetPalRGB(Q.RGB,0,256)
  Else
 Begin
  P:=0;
  For I:=0to 255do Begin
   Q.TrueKr[I]:=RGB2Color(Q.RGB[P],Q.RGB[P+1],Q.RGB[P+2]);
   Inc(P,3);
  End;
 End;
 Q.J:=1;Q.K:=1;Q.Init:=True;_InitMixingStar:=True;
End;

Procedure _DoneMixingStar(Var Q:AniMixingStarRec);
Var
 L,I:Word;
Begin
 If(Q.Init)Then Begin
  Q.N:=NmXPixels*NmYPixels;L:=0;
  For I:=0to(Q.N)do If I mod 1000=0Then Begin
   FreeMemory(Q.P[L],SizeOf(Arr));
   Inc(L);
  End;
 End;
End;

Procedure _PutStar(Var Q:AniMixingStarRec;X,Y,Kr:Word);Near;
Var
 YP:Word;
Begin
 If(X<Q.NumXPixels)Then Begin
  If Q.NumYPixels>200Then Begin
   YP:=(Y shl 1);Kr:=Q.TrueKr[Kr and$FF];
   If(YP<Q.NumYPixels)Then SetPixel(Q.GX1+X,Q.GY1+YP,Kr);
   If(YP+1<Q.NumYPixels)Then SetPixel(Q.GX1+X,Q.GY1+YP+1,Kr);
  End
   Else
  SetPixel(Q.GX1+X,Q.GY1+Y,Kr);
 End;
End;

Procedure _AniMixingStar(Var Q:AniMixingStarRec);
Var
 i,i2:LongInt;
 X,Y:Word;
Begin
 If(Q.Init)Then Begin
   {Cycle des 6 "dessins" dans l'ordre}
  If Q.K=1Then Begin
   Q.N:=NmXPixels*NmYPixels;
   For I:=0to(Q.N)do Q.P[I div 1000]^[I mod 1000]:=I;
   Randomize;
   Q.W:=256;Q.RK:=Q.N;
  End;
  Dec(Q.N);I:=Random(Q.N);i2:=Q.P[I div 1000]^[I mod 1000];
  X:=i2 mod MixingMaxX;Y:=i2 div MixingMaxX;{Vraies coordonn‚es du point}
  Case(Q.J)of
   1:_PutStar(Q,x,y,-x+y+y+y-Q.FX[x]-Q.FX[y]+Q.FY[y]);
   2:_PutStar(Q,x,y,-Q.FX[x]-x-x+y+y+Q.FY[y]);
   3:_PutStar(Q,x,y,x+y+y+Q.FX[x]+Q.FY[y]+Q.FY[y]);
   4:_PutStar(Q,x,y,x+y-Q.FX[x]+Q.FY[y]+Q.FY[y]);
   5:_PutStar(Q,x,y,-Q.FX[x]+Q.FY[y]+Q.FY[y]-x-x+y+y);
   6:_PutStar(Q,x,y,-Q.FX[x]+Q.FY[y]+Q.FY[y]-x+y);
  End;
  MoveLeft(Q.P[Q.N div 1000]^[Q.N mod 1000],Q.P[I div 1000]^[I mod 1000],SizeOf(I));
  Dec(Q.W);
  If Q.W=0Then Begin
   Q.W:=256;
   WaitRetrace;
  End;
  Inc(Q.K);
  If(Q.K>Q.RK)Then Begin
   Q.J:=1+Q.J mod 6;Q.K:=1;
  End;
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure AniMixingStar                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure produit l'effet d'animation d'apparition et disparition
 sous forme d'‚toile.
}

Function AniMixingStar:Boolean;
Var
 Q:AniMixingStarRec;
 MX,MY,MB:Word;
Begin
 AniMixingStar:=False;
 SetVideoMode(vmGrf320x200c256);
 If Not _InitMixingStar(Q,0,0,MaxXTxts,MaxYTxts)Then Exit;
 Repeat
  _AniMixingStar(Q);
  {$IFNDEF __Windows__}
   TaskSpooler;
  {$ENDIF}
  GetMouseSwitch(MX,MY,MB);
 Until(KeyPress)or(MB>0);
 _DoneMixingStar(Q);
 AniMixingStar:=True;
End;

Procedure InitControl(Var Q:AniMystifyRec;Var Vertex,Delta:PointType);Begin
 Vertex.X:=Random(Q.NumXPixels-20)+10;
 Vertex.Y:=Random(Q.NumYPixels-20)+10;
 Delta.X:=Random(MaxDelta)+1;
 Delta.Y:=Random(MaxDelta)+1;
End;

Procedure _InitMystify;
Var
 I:Word;
Begin
 FillClr(Q,SizeOf(AniMystifyRec));
 Randomize;
 Q.X1:=X1;Q.Y1:=Y1;Q.X2:=X2;Q.Y2:=Y2;
 If X1=0Then Begin
  ClrScrBlack;
  Q.NumXPixels:=GetNmXPixels;
  Q.NumYPixels:=GetNmYPixels;
 End
  Else
 Begin
  ClrWn(X1,Y1,X2,Y2,Black);
  Q.NumXPixels:=(X2-X1+1)shl 3;
  Q.NumYPixels:=GetRawY(Y2-Y1+1);
 End;
 Q.GX1:=X1 shl 3;Q.GY1:=GetRawY(Y1);
 For I:=0to NumControlPoints-1do InitControl(Q,Q.Vertices[I],Q.Deltas[I]);
 Q.Color:=Succ(Random(15));
 If(Q.Color=DarkGray)Then Inc(Q.Color);
End;

Procedure _AniMystify;
Const
 BSplineBais:Array[0..3]of BaisMatrixType=(
  (-1.0/6, 3.0/6,-3.0/6,1.0/6),
  ( 3.0/6,-6.0/6, 3.0/6,0),
  (-3.0/6, 0.0/6, 3.0/6,0),
  ( 1.0/6, 4.0/6, 1.0/6,0)
 );

 Procedure AdvanceControl(Var Vertex,Delta:PointType);
 Var
  X,Y:Real;
 Begin
  X:=Vertex.X+Delta.X;Y:=Vertex.Y+Delta.Y;
  If X<0Then Delta.X:=Random(MaxDelta)+1;
  if(X>=Q.NumXPixels)Then Delta.X:=-(Random(MaxDelta)+1);
  if Y<0Then Delta.Y:=Random(MaxDelta)+1;
  if(Y>=Q.NumYPixels)Then delta.y:=-(Random(MaxDelta)+1);
  Inc(Vertex.X,Delta.X);Inc(Vertex.Y,Delta.Y);
 End;

 Procedure GetWeightEdPoint2(Var CoeffVector:Array of Real;
                             Var ControlPts:Array of ControlPtsType;
                             Var Point:Array of Real);Begin
  Point[0]:=CoeffVector[0]*ControlPts[0][0]+
            CoeffVector[1]*ControlPts[1][0]+
   	    CoeffVector[2]*ControlPts[2][0]+
   	    CoeffVector[3]*ControlPts[3][0];
  Point[1]:=CoeffVector[0]*ControlPts[0][1]+
            CoeffVector[1]*ControlPts[1][1]+
	    CoeffVector[2]*ControlPts[2][1]+
	    CoeffVector[3]*ControlPts[3][1];
 End;

 Procedure MulRowMatrix4x4(Var Result,Left:Array of Real;
                           Var Right:Array of BaisMatrixType);
 Var
  I:Integer;
 Begin
  For I:=0to 3do
   Result[I]:=Left[0]*Right[0][I]+Left[1]*Right[1][I]+
              Left[2]*Right[2][I]+Left[3]*Right[3][I];
 End;

 Procedure GetCoeffVector(Param:Real;Var BaisMatrix:Array of BaisMatrixType;Var CoeffVector:Real);
 Var
  TermVector:Array[0..3]of Real;
 Begin
  TermVector[0]:=Param*Param*Param;
  TermVector[1]:=Param*Param;
  TermVector[2]:=Param;
  TermVector[3]:=1;
  MulRowMatrix4x4(CoeffVector,TermVector,BaisMatrix);
 End;

 Procedure GetBSplinePoint2(Param:Real;Var ControlPts:Array of ControlPtsType;Var Pt:Real);
 Var I:Integer;T:Real;CoeffVector:BaisMatrixType;Begin
  I:=Round(Param)+2;
  T:=Param-Round(Param);
  GetCoeffVector(T,BSplineBais,CoeffVector[0]);
  GetWeightEdPoint2(CoeffVector,ControlPts[i-2],Pt);
 End;

 Procedure DrawCurve(Var a,b,c,d:PointType);
 Var
  I:Integer;
  ControlPts:Array[0..3]of ControlPtsType;
  Pt:ControlPtsType;
  CoeffVector:Array[0..3]of Real;
 Begin
  ControlPts[0][0]:=A.X;
  ControlPts[0][1]:=A.Y;
  ControlPts[1][0]:=B.X;
  ControlPts[1][1]:=B.Y;
  ControlPts[2][0]:=C.X;
  ControlPts[2][1]:=C.Y;
  ControlPts[3][0]:=D.X;
  ControlPts[3][1]:=D.Y;
  GetBSplinePoint2(0,ControlPts,pt[0]);
  _Move2(Q.GX1+Trunc(pt[0]),Q.GY1+Trunc(pt[1]));
  For I:=1to 20do Begin
   GetCoeffVector(I*0.05,BSplineBais,CoeffVector[0]);
   GetWeightEdPoint2(CoeffVector,ControlPts,Pt);
   _Ln2(Q.GX1+Trunc(Pt[0]),Q.GY1+Trunc(Pt[1]));
  End;
 End;

Var
 I:Integer;
Begin
 WaitRetrace;
 If Random(100)=0Then Begin
  Q.Color:=Succ(Random(15));
  If(Q.Color=DarkGray)Then Inc(Q.Color);
 End;
 For I:=0to NumControlPoints-1do AdvanceControl(Q.Vertices[I],Q.Deltas[I]);
 For I:=0to NumControlPoints-1do Begin
  _SetKr(0);
  DrawCurve(Q.Queue[Q.Index][I],
            Q.Queue[Q.Index][(I+1)mod NumControlPoints],
	    Q.Queue[Q.Index][(I+2)mod NumControlPoints],
	    Q.Queue[Q.Index][(I+3)mod NumControlPoints]);
 End;
 For I:=0to NumControlPoints-1do Begin
  _SetKr(Q.Color);
  DrawCurve(Q.Vertices[I],Q.Vertices[(I+1)mod NumControlPoints],
	    Q.Vertices[(I+2)mod NumControlPoints],
     	    Q.Vertices[(I+3)mod NumControlPoints]);
  Q.Queue[Q.Index][I]:=Q.Vertices[I];
 End;
 Q.Index:=(Q.Index+1)mod QueueSize;
End;

Procedure AniMystify;
Var
 Q:AniMystifyRec;
Begin
 _InitMystify(Q,0,0,MaxXTxts,MaxYTxts);
 Repeat
  {$IFNDEF __Windows__}
   TaskSpooler;
  {$ENDIF}
  _AniMystify(Q);
 Until(KeyPress)or(MouseMove);
End;

Procedure _InitStar;
Var
 I:Word;
Begin
 FillClr(Q,SizeOf(AniStarRec));
 Randomize;
 Q.X1:=X1;Q.Y1:=Y1;Q.X2:=X2;Q.Y2:=Y2;
 If X1=0Then Begin
  ClrScrBlack;
  Q.NumXPixels:=GetNmXPixels;
  Q.NumYPixels:=GetNmYPixels;
 End
  Else
 Begin
  ClrWn(X1,Y1,X2,Y2,Black);
  Q.NumXPixels:=(X2-X1+1)shl 3;
  Q.NumYPixels:=GetRawY(Y2-Y1+1);
 End;
 Q.GX1:=X1 shl 3;Q.GY1:=GetRawY(Y1);
 For I:=0to 500do Begin
  Q.Etoiles[I].X:=Random(Q.NumXPixels-1);
  Q.Etoiles[I].Y:=Random(Q.NumYPixels-1);
  Q.Etoiles[I].Plan:=Random(256);
 End;
End;

Procedure _AniStar;
Var
 Kr:Byte;
Begin
 Inc(Q.I);
 If Q.I>499Then Q.I:=0;
 With Q.Etoiles[Q.I]do Begin
  If(X>=0)and(Y>=0)and(y<Q.NumYPixels)and(x<Q.NumXPixels)Then
   SetPixel(Q.GX1+X,Q.GY1+Y,0);
  Dec(X,Plan shr 5+1);
  If X<=0Then Begin
   X:=Q.NumXPixels-1;
   Y:=Random(Q.NumYPixels-1);
   Plan:=Random(256)
  End;
  If(X>=0)and(Y>=0)and(Y<Q.NumYPixels)and(X<Q.NumXPixels)Then
   If BitsPerPixel>=15Then Begin
    Kr:=((Plan shr 4)or 192)and$FF;
    SetPixel(Q.GX1+X,Q.GY1+Y,RGB2Color(Kr,Kr,Kr))
   End
    Else
   SetPixel(Q.GX1+X,Q.GY1+Y,(Plan shr 4+16)and$FF);
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure AniStar                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure produit l'effet d'animation d'une toile d'‚toiles en 4
 plages de diff‚rente vitesse de droite vers la gauche.


 Remarque
 ÍÍÍÍÍÍÍÍ

  ş Cette proc‚dure peut ˆtre utilis‚ dans n'importe quel mode graphique
    en avec n'importe  quel dimension  ou un nombre diverses de couleurs
    mais il ne supporte vraiment pas le mode texte.
}

Procedure AniStar;
Var
 Q:AniStarRec;
 MX,MY,MB:Word;
Begin
 Q.I:=0;
 ClrScrBlack;
 Randomize;
 _InitStar(Q,0,0,MaxXTxts,MaxYTxts);
 Repeat
  _AniStar(Q);
  {$IFNDEF __Windows__}
   TaskSpooler;
  {$ENDIF}
  GetMouseSwitch(MX,MY,MB);
 Until(KeyPress)or(MouseMove)or(MB>0);
 If MB>0Then WaitMouseBut0;
End;

Procedure _InitStar3D;
Var
 I:Word;
Begin
 Q.X1:=X1;Q.Y1:=Y1;Q.X2:=X2;Q.Y2:=Y2;
 If X1=0Then Begin
  For I:=0to 50do SetPaletteRGB(I,I shl 4,I shl 4,I shl 4);
  ClrScrBlack;
  Q.NumXPixels:=GetNmXPixels;
  Q.NumYPixels:=GetNmYPixels;
 End
  Else
 Begin
  ClrWn(X1,Y1,X2,Y2,Black);
  Q.NumXPixels:=(X2-X1+1)shl 3;
  Q.NumYPixels:=GetRawY(Y2-Y1+1);
 End;
 Q.GX1:=X1 shl 3;Q.GY1:=GetRawY(Y1);
 Q.Xc:=Q.NumXPixels shr 1;Q.Yc:=Q.NumYPixels shr 1;
 If(Q.NumXPixels>Q.NumYPixels)Then Q.ZFactor:=65280div Q.NumXPixels
                              Else Q.ZFactor:=65280div Q.NumYPixels;
 Randomize;
 For I:=0to(NofStars)do begin
  Q.Stars[I].X:=Random(100)-50;
  Q.Stars[I].Y:=Random(100)-50;
  Q.Stars[I].Z:=Random(900)+200;
  Q.Speed[I]:=0;
 End;
 If X1=0Then ClrKbd;
End;

Procedure _AniStar3D;{ZFactor=200;}
Var
 X,Y,I:Integer;
 Color:Byte;

 Procedure NewStar(Num:Byte);Var X,Y:Integer;Begin
  X:=Q.Xc+Round(Q.Stars[Num].X*Q.Stars[Num].Z/Q.ZFactor);
  Y:=Q.Yc+Round(Q.Stars[Num].Y*Q.Stars[Num].Z/Q.ZFactor);
  If(X>0)and(X<Q.NumXPixels)and(Y>0)and(Y<Q.NumYPixels)Then
   SetPixel(Q.GX1+X,Q.GY1+Y,0);
  Q.Stars[Num].X:=Random(100)-50;
  Q.Stars[Num].Y:=Random(100)-50;
  Q.Stars[Num].Z:=Random({100}Q.Yc)+{200}Q.NumYPixels;
 End;

Begin
 WaitRetrace;
 SetPalBlk(0,1);
 WaitRetrace;
 For I:=0to(NofStars)do Begin
  X:=Q.Xc+round(Q.Stars[I].X*Q.Stars[I].Z/Q.ZFactor);
  Y:=Q.Yc+round(Q.Stars[I].Y*Q.Stars[I].Z/Q.ZFactor);
  SetPixel(Q.GX1+X,Q.GY1+Y,0); { Efface l'‚toile }
  X:=Q.Xc+Round(Q.Stars[I].X*(Q.Stars[I].Z+Q.Speed[I])/Q.ZFactor);
  Y:=Q.Yc+Round(Q.Stars[I].Y*(Q.Stars[I].Z+Q.Speed[I])/Q.ZFactor);
  If(X>0)and(X<Q.NumXPixels)and(Y>0)and(Y<Q.NumYPixels)Then Begin
   Color:=8+Q.Stars[I].Z div 150;
   If GetPixel(Q.GX1+X,Q.GY1+Y)=0Then SetPixel(Q.GX1+X,Q.GY1+Y,Color);
  End
   else
  NewStar(I);
  Inc(Q.Stars[I].Z,Q.Speed[I]);
  If Q.Stars[I].Z>20000Then NewStar(I);
  Q.Speed[I]:=(Q.Stars[I].Z div 150)*(5-(Abs(Q.Stars[I].X*Q.Stars[I].Y)div 500));
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Proc‚dure AniStar3D                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure produit l'effet d'animation d'une d'‚toiles en 3
 dimensions de milieu vers les c“t‚s.


 Remarque
 ÍÍÍÍÍÍÍÍ

  ş Cette proc‚dure peut ˆtre utilis‚ dans n'importe quel mode graphique
    en avec n'importe  quel dimension  ou un nombre diverses de couleurs
    mais il ne supporte vraiment pas le mode texte.
}

Procedure AniStar3D;
Var
 Q:AniStar3DRec;
Begin
 _InitStar3D(Q,0,0,MaxXTxts,MaxYTxts);
 Repeat
  _AniStar3D(Q);
  {$IFNDEF __Windows__}
   TaskSpooler;
  {$ENDIF}
 Until(Keypress)or(MouseMove);
 ClrKbd;
 SetVideoSize(NmXPixels,NmYPixels,BitsPerPixel);
 SetLuxe;
End;

Procedure _InitStarPlus(Var Q:AniStarPlusRec;X1,Y1,X2,Y2:Byte);
Const
 F=6;
Var
 S:String;
 I:Byte;
Begin
 Q.X1:=X1;Q.Y1:=Y1;Q.X2:=X2;Q.Y2:=Y2;
 If X1=0Then Begin
  For I:=0to 50do SetPaletteRGB(I,I shl 4,I shl 4,I shl 4);
  ClrScrBlack;
  Q.NumXPixels:=GetNmXPixels;
  Q.NumYPixels:=GetNmYPixels;
 End
  Else
 Begin
  ClrWn(X1,Y1,X2,Y2,Black);
  Q.NumXPixels:=(X2-X1+1)shl 3;
  Q.NumYPixels:=GetRawY(Y2-Y1+1);
 End;
 Q.GX1:=X1 shl 3;Q.GY1:=GetRawY(Y1);
 S:=#0#0#1#0#0#0#0#3#0#0#1#3#6#3#1#0#0#3#0#0#0#0#1#0#0+
    #0#0#6#0#0#0#0#3#0#0#6#3#1#3#6#0#0#3#0#0#0#0#6#0#0;
 MoveLeft(S[1],Q.BitMask,SizeOf(Q.BitMask));
 If X1=0Then For i:=1to 10do Begin
  SetPaletteRGB(i,    f*i shl 2,0   shl 2,0   shl 2);
  SetPaletteRGB(21-i, f*i shl 2,0   shl 2,0   shl 2);
  SetPaletteRGB(20+i, 0   shl 2,0   shl 2,0   shl 2);
  SetPaletteRGB(30+i, 0   shl 2,f*i shl 2,0   shl 2);
  SetPaletteRGB(51-i, 0   shl 2,f*i shl 2,0   shl 2);
  SetPaletteRGB(50+i, 0   shl 2,0   shl 2,0   shl 2);
  SetPaletteRGB(60+i, 0   shl 2,0   shl 2,f*i shl 2);
  SetPaletteRGB(81-i, 0   shl 2,0   shl 2,f*i shl 2);
  SetPaletteRGB(80+i, 0   shl 2,0   shl 2,0   shl 2);
  SetPaletteRGB(90+i, f*i shl 2,f*i shl 2,0   shl 2);
  SetPaletteRGB(111-i,f*i shl 2,f*i shl 2,0   shl 2);
  SetPaletteRGB(110+i,0   shl 2,0   shl 2,0   shl 2);
  SetPaletteRGB(120+i,0   shl 2,f*i shl 2,f*i shl 2);
  SetPaletteRGB(141-i,0   shl 2,f*i shl 2,f*i shl 2);
  SetPaletteRGB(140+i,0   shl 2,0   shl 2,0   shl 2);
  SetPaletteRGB(150+i,f*i shl 2,f*i shl 2,f*i shl 2);
  SetPaletteRGB(171-i,f*i shl 2,f*i shl 2,f*i shl 2);
  SetPaletteRGB(170+i,0   shl 2,0   shl 2,0   shl 2);
 End;
 Randomize;
 For I:=1to 100do With Q.Stars[I]do Begin
  XP:=0;YP:=0;Col:=0;Phase:=0;Dur:=Random(20);Active:=False;
 End;
End;

Procedure _AniStarPlus(Var Q:AniStarPlusRec);
Var
 I,X,Y:Word;
Begin
 WaitRetrace;WaitRetrace;
 For I:=1to 100do With Q.Stars[i]do Begin
  Dec(Dur);
  If(Not Active)and(Dur<0)Then Begin
   Active:=True;Phase:=0;Col:=30*Random(6);
   XP:=Random(Q.NumXPixels-5);YP:=Random(Q.NumYPixels-5);
  End;
 End;
 For I:=1to 100do With Q.Stars[I]do If(Active)Then Begin
  For X:=0to 4do For Y:=0to 4do Begin
   If Q.BitMask[Byte(Phase>10),x,y]>0Then
    SetPixel(Q.GX1+XP+X,Q.GY1+YP+Y,Q.BitMask[Byte(Phase>10),X,Y]+Col+Phase);
  End;
  Inc(Phase);
  If Phase=20Then Begin
   Active:=False;
   If Q.X1>0Then Begin
    For X:=0to 4do For Y:=0to 4do Begin
     If Q.BitMask[Byte(Phase>10),x,y]>0Then
      SetPixel(Q.GX1+XP+X,Q.GY1+YP+Y,Black);
    End;
   End;
   Dur:=Random(20)
  End;
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Fonction AniStarPlus                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction effectue une animation de d'‚toile en forme de plus
 apparaissant et disparaisant...
}

Function AniStarPlus:Boolean;
Var
 MX,MY,MB:Word;
 ModifiedScr:Boolean;
 Q:AniStarPlusRec;
Begin
 AniStarPlus:=False;ModifiedScr:=False;
 If BitsPerPixel<>8Then Begin
  If Not SetVideoMode(vmGrf320x200c256)Then Exit;
  ModifiedScr:=True;
 End
  Else
 ClrScrBlack;
 _InitStarPlus(Q,0,0,MaxXTxts,MaxYTxts);
 Repeat
  _AniStarPlus(Q);
  SetPaletteRGB(0,0,0,0);
  {$IFNDEF __Windows__}
   TaskSpooler;
  {$ENDIF}
  GetMouseSwitch(MX,MY,MB);
 Until(KeyPress)or(MB>0);
 If MB>0Then WaitMouseBut0;
 ClrKbd;
 If Not(ModifiedScr)Then Begin
  SetVideoSize(NmXPixels,NmYPixels,BitsPerPixel);
  SetLuxe;
 End;
 AniStarPlus:=True;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                             Proc‚dure Ecoule                            Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure ‚tire une image graphique progressivement pour produire un
 effet d'‚coulement.
}

Procedure Ecoule;
Var
 I,Old9:Byte;
 D:Word;
Begin
 {$IFNDEF __Windows__}
  D:=VideoPort;
  Port[D]:=9;
  Old9:=Port[D+1]and$80;
  For I:=2to 31do Begin
   WaitRetrace;
   Port[$3D5]:=Old9 or I;
  End;
 {$ENDIF}
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Proc‚dure FadeIn                           Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette produit un effet de couleur progressive (du noir jusqu'aux couleurs
 sp‚cifi‚ dans le tampon ®SavePalette¯.


 Remarque
 ÍÍÍÍÍÍÍÍ

  ş Cette proc‚dure  est utilis‚  par exemple  pour  la  pr‚sentation  d'un
    programme  ou  jeux  au  lancement  de  celui  en  mode  graphique.  La
    construction  est  longue,  il  fixe  les  couleurs  en  noir  et  fait
    rapparaŒtre  les   couleurs   progressivement   quand   l'op‚ration  de
    pr‚paration de l'‚cran est termin‚.
}

Procedure FadeIn;
Var
 PaletteFree:Array[Byte]of RGB;
 PSavePalette:Array[0..767]of Byte Absolute SavePalette;
 PPaletteFree:Array[0..767]of Byte Absolute PaletteFree;
 I:Word;
 J,K:Byte;
Begin
 If BitsPerPixel<=8Then Begin
  FillClr(PaletteFree,SizeOf(PaletteFree));
  For J:=0to 31do Begin
   For K:=0to(Delay)do
   For I:=0to 767do If PPaletteFree[I]<PSavePalette[I]Then Inc(PPaletteFree[I]);
   WaitRetrace;
   SetPalRGB(PaletteFree,0,256);
  End;
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Proc‚dure FadeOut                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure produit l'effet d'une fondu. Les couleurs se d‚teignent
 jusqu'… ce que toute l'‚cran soit noir.


 Remarque
 ÍÍÍÍÍÍÍÍ

  ş Cette proc‚dure existe  dans l'intension de cr‚er des effets sp‚ciaux
    dans un jeux d'arcade  ou une application spectaculaire  en d‚clin ou
    s'apprˆtant … ˆtre quitter.
}

Procedure FadeOut;
Var
 Palette:Array[Byte]of RGB;
 I,J,K:Word;
 PPalette:Array[0..767]of Byte Absolute Palette;
Begin
 If BitsPerPixel<=8Then Begin
  GetPaletteRGB(Palette,0,256);
  For J:=0to 63do Begin
   For K:=0to 3do For I:=0to 767do If PPalette[I]>0Then Dec(PPalette[I]);
   WaitRetrace;
   SetPalRGB(Palette,0,256);
  End;
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure PacManBoard                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure affiche une image repr‚sentant en genre de jeu Pac-Man.
}

Procedure PacManBoard;
Var
 Pal:Array[0..15]of RGB;
 Pastille,Robotics:String[10];
 I,J,K,L:Byte;
 GX,GY:Word;
Begin
 SetVideoMode(vmGrf320x200c256);
 Pastille:=#8#7#8#7#15#7#8#7#8;Robotics:=#23#24#25#26#27#26#25#24#0#0;
 Robotics[0]:=#0;
 For I:=0to 15do Begin Pal[I].R:=I shl 2;Pal[I].G:=I shl 4;Pal[I].B:=I shl 2;End;
 SetPalRGB(Pal[0],16,16);
 For J:=0to 16do For I:=1to Length(T[J])do Begin
  GX:=I shl 4;GY:=J*10;
  Case T[J][I]of
   '³':For K:=0to 9do ClrLnHorImg(GX+4,GY+K,8,8,Robotics[1]);
   'Ã':Begin
    For K:=0to 9do ClrLnHorImg(GX+4,GY+K,8,8,Robotics[1]);
    For K:=1to 4do ClrLnHor(GX+12-K,GY+K,4+K,Byte(Robotics[K]));
    For K:=5to 8do ClrLnHor(GX+4+K,GY+K,12-K,Byte(Robotics[K]));
   End;
   '´':Begin
    For K:=0to 9do ClrLnHorImg(GX+4,GY+K,8,8,Robotics[1]);
    For K:=1to 4do ClrLnHor(GX,GY+K,4+K,Byte(Robotics[K]));
    For K:=5to 8do ClrLnHor(GX,GY+K,12-K,Byte(Robotics[K]));
   End;
   'Ä':For K:=1to 8do ClrLnHor(GX,GY+K,16,Byte(Robotics[K]));
   'ú':PutSmlImg(GX+6,GY+4,GX+8,GY+6,Pastille[1]);
   'Ú':For K:=1to 9do Begin
    ClrLnHor(GX+K+3,GY+K,13-K,Byte(Robotics[K]));
    ClrLnHorImg(GX+4,GY+K,K,8,Robotics[1]);
   End;
   'À':For K:=1to 9do Begin
    ClrLnHor(GX+K+3,GY+9-K,13-K,Byte(Robotics[9-K]));
    ClrLnHorImg(GX+4,GY+9-K,K,8,Robotics[1]);
   End;
   'Ù':For K:=1to 9do Begin
    ClrLnHor(GX,GY+10-K,14-K,Byte(Robotics[10-K]));
    ClrLnHorImg(GX+4+9-K,GY+9-K,K,8,Robotics[10-K]);
   End;
   '¿':For K:=1to 9do Begin
    ClrLnHor(GX,GY+K,14-K,Byte(Robotics[K]));
    ClrLnHorImg(GX+4+9-K,GY+K,K,8,Robotics[10-K]);
   End;
   'Á':Begin
    For K:=1to 8do ClrLnHor(GX,GY+K,16,Byte(Robotics[K]));
    L:=1;
    For K:=5to 9do Begin
     ClrLnHorImg(GX+4+9-K,GY+9-K,L,8,Robotics[10-K]);
     Inc(L,2)
    End;
   End;
  End;
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                    Proc‚dure ScrnSaverPacMan                  Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure active en genre de jeu Pac-Man dans lequel c'est
 l'ordinateur qui joue.
}

Procedure ScrnSaverPacMan;
Label BreakAll;
Var
 T:PacManBoardRec;
 XP,YP:Byte;
 XDir,YDir:ShortInt;
 J1,J2,J3,J4,F1:Array[0..149]of Byte;
 I,J,Boo:Byte;
 GX1,GY1,Score:Word;
 PalYellow:Array[0..7]of RGB;
Begin
 Randomize;
 T[0]:= 'ÚÄÄÄÄÄÄ ÄÄÄÄÄÄÄ¿X';
 T[1]:= '³úúúúúúúúúúúúúú³X';
 T[2]:= '³şÄú³úÄÄÄÄú³úÄş³X';
 T[3]:= ' úúú³úúúúúú³úúú³X';
 T[4]:= 'ÚÄúÄÙúÄÄÄÄúÀÄúÄ´X';
 T[5]:= '³úúúúúúúúúúúúúú³X';
 T[6]:= '³úÄú³úÚÄÄ¿ú³úÄú³X';
 T[7]:= '³úúú³ú³  ³ú³úúú³X';
 T[8]:= 'ÃÄúÄÙúÀÄÄÙúÀÄúÄ´X';
 T[9]:= '³úúúúúúúúúúúúúú³X';
 T[10]:='³úÄú³úÄÄÄÄú³úÄú³X';
 T[11]:='³úúú³úúúúúú³úúú³X';
 T[12]:='ÃÄúÄÙúÄÄÄÄúÀÄúÄÙX';
 T[13]:='³úúúúúúúúúúúúúú X';
 T[14]:='³şÄú³úÄÄÄÄú³úÄş³X';
 T[15]:='³úúú³úúPúúú³úúú³X';
 T[16]:='ÀÄÄÄÁÄÄÄ ÄÄÁÄÄÄÙX';
 Score:=0;
 For J:=0to 16do For I:=1to Length(T[J])do If T[J][I]='P'Then Begin
  XP:=I;YP:=J;T[J][I]:=' ';
  Goto BreakAll;
 End;
BreakAll:
 SetVideoMode(vmGrf320x200c256);
 SetPalBlk(0,256);
  {Pac-Man Droite}
 For I:=0to 4do PutFillCircle(10,10,5-I,244+I);
 PutFillCircle(10,7,2,15);
 SetPixel(11,7,0); SetPixel(12,7,7);
 GetSmlImg(5,6,16,15,J3);
 For I:=0to 9do ClrLnHor(11+I,10+I,10,Black);
 GetSmlImg(5,6,16,15,J1);
  {Pac-Man Gauche}
 For I:=0to 4do PutFillCircle(35,10,5-I,244+I);
 PutFillCircle(35,7,2,15);
 SetPixel(34,7,0);SetPixel(33,7,7);
 GetSmlImg(30,6,41,15,J4);
 For I:=0to 9do ClrLnHor(25-I,10+I,10,Black);
 GetSmlImg(30,6,41,15,J2);
  { Fant“me }
 PutFillCircle(60,10,5,LightGreen);
 PutFillBox(60-5,10+2,60+5,10+10,Black);
 For I:=1to 4do Begin
  ClrLnHor(66-I,15-I,I,LightGreen);
  ClrLnHor(61-I,15-I,(I shl 1)-1,LightGreen);
  ClrLnHor(55,15-I,I,LightGreen);
 End;
 PutFillCircle(58,7,1,White);
 SetPixel(58,7,Black);
 PutFillCircle(62,7,1,White);
 SetPixel(62,7,Black);
 GetSmlImg(55,6,66,15,F1);
 PacManBoard(T);
 PalYellow[0].R:=$FC-70;PalYellow[0].G:=$FC-70;PalYellow[0].B:=$24-35;
 PalYellow[1].R:=$FC-60;PalYellow[1].G:=$FC-60;PalYellow[1].B:=$24-30;
 PalYellow[2].R:=$FC-50;PalYellow[2].G:=$FC-50;PalYellow[2].B:=$24-25;
 PalYellow[3].R:=$FC-40;PalYellow[3].G:=$FC-40;PalYellow[3].B:=$24-20;
 PalYellow[4].R:=$FC-30;PalYellow[4].G:=$FC-30;PalYellow[4].B:=$24-15;
 PalYellow[5].R:=$FC-20;PalYellow[5].G:=$FC-20;PalYellow[5].B:=$24-10;
 PalYellow[6].R:=$FC-10;PalYellow[6].G:=$FC-10;PalYellow[6].B:=$24-5;
 PalYellow[7].R:=$FC;PalYellow[7].G:=$FC;PalYellow[7].B:=$24;
 SetPalRGB(PalYellow,244,8);
 PutTxtXY(0,MaxYTxts-1,'En attends qu''on s''occupe de moi,',Blue);
 PutTxtXY(0,MaxYTxts,'je vais jouer un tout petit peu!',Blue);
 PutTxtXY(0,MaxYTxts-2,'Pointage:',Red);
 XDir:=1;YDir:=0;Boo:=0;
 Repeat
  If Not(T[YP+YDir][XP]in[' ','ú','ş'])Then Begin
   YDir:=0;
   If Random(2)=1Then Begin
    If T[YP][XP+1]in[' ','ú','ş']Then XDir:=1 Else XDir:=-1;
   End
    Else
   If T[YP][XP-1]in[' ','ú','ş']Then XDir:=-1 Else XDir:=1;
  End
   Else
  If Not(T[YP][XP+XDir]in[' ','ú','ş'])Then Begin
   If XP=1Then Begin
    GX1:=(XP shl 4)+2;GY1:=YP*10;
    PutFillBox(GX1,GY1,GX1+11,GY1+9,0);
    XP:=Length(T[YP])-2;YP:=13
   End
    Else
   If XP=Length(T[YP])-1Then Begin
    GX1:=(XP shl 4)+2;GY1:=YP*10;
    PutFillBox(GX1,GY1,GX1+11,GY1+9,0);
    XP:=2;YP:=3
   End
    Else
   Begin
    XDir:=0;
    If Random(2)=1Then Begin
     If T[YP+1][XP]in[' ','ú','ş']Then YDir:=1 Else YDir:=-1;
    End
     Else
    If T[YP-1][XP]in[' ','ú','ş']Then YDir:=-1 Else YDir:=1;
   End;
  End
   Else
  Begin
   Case T[YP][XP]of
    'ú':Inc(Score);
    'ş':Inc(Score,5);
   End;
   PutTxtXY(10,MaxYTxts-2,WordToStr(Score),Red);
   T[YP][XP]:=' ';
   Inc(YP,YDir);Inc(XP,XDir);
   GX1:=(XP shl 4)+2;GY1:=YP*10;
   If XDir=1Then Begin
    For I:=0to 15do Begin
     If(Boo shr 3)=1Then PutSmlImg(GX1+I-15,GY1,GX1+11+I-15,GY1+9,J1)
                    Else PutSmlImg(GX1+I-15,GY1,GX1+11+I-15,GY1+9,J3);
     PutLn(GX1+I-15-1,GY1,GX1+I-15-1,GY1+9,0);
     Boo:=(Boo+1)and$F;
     WaitRetrace;
    End;
   End
    Else
   If YDir=-1Then Begin
    For I:=0to 9do Begin
     If(Boo shr 3)=1Then PutSmlImg(GX1,GY1-I+9,GX1+11,GY1+9-I+9,J1)
                    Else PutSmlImg(GX1,GY1-I+9,GX1+11,GY1+9-I+9,J3);
     ClrLnHor(GX1-2,GY1+10-I+9,16,0);
     Boo:=(Boo+1)and$F;
     WaitRetrace;
    End;
   End
    Else
   If YDir=1Then Begin
    For I:=0to 9do Begin
     If(Boo shr 3)=1Then PutSmlImg(GX1,GY1+1+I-10,GX1+11,GY1+10+I-10,J1)
                    Else PutSmlImg(GX1,GY1+1+I-10,GX1+11,GY1+10+I-10,J3);
     ClrLnHor(GX1-2,GY1+I-10,16,0);
     Boo:=(Boo+1)and$F;
     WaitRetrace;
    End;
   End
    Else
   Begin
    For I:=0to 15do Begin
     If(Boo shr 3)=1Then PutSmlImg(GX1-I+15,GY1,GX1+11-I+15,GY1+9,J2)
                    Else PutSmlImg(GX1-I+15,GY1,GX1+11-I+15,GY1+9,J4);
     PutLn(GX1+12-I+15,GY1,GX1+12-I+15,GY1+9,0);
     Boo:=(Boo+1)and$F;
     WaitRetrace;
    End;
   End;
  End;
 Until(KeyPress)or(MouseMove);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Proc‚dure RunScrnSaver                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'activer imm‚diatement l'‚conomiseur d'‚cran
 (Screen Saver) sans attendre le d‚lai prescrit.
}

Procedure RunScrnSaver;
Var
 M:ImgRec;
 Cur:Boolean;
 TXCur,TYCur:Byte;
 MX,MY,MB:Word;
Begin
 GetMouseSwitch(MX,MY,MB);
 __HideMousePtr;
 {$IFNDEF Windows}
  TXCur:=GetXCurPos;TYCur:=GetYCurPos;
  Cur:=Hi(GetCur)<>$20;
 {$ENDIF}
 PushScr(M);
 ResetMouseMove;
 {$IFDEF Int8Dh}
  {$IFNDEF DPMI}FreeMaxHeap;{$ENDIF}
   Exec('\OUTPUT\SSSTAR.EXE','');
  {$IFNDEF DPMI}MaxExpandHeap;{$ENDIF}
 {$ELSE}
  ScrnSaverAni;
 {$ENDIF}
 PopScr(M);
 {$IFNDEF Windows}
  If(IsGraf)and(Cur)Then SimpleCur;
  GotoXY(TXCur,TYCur);
 {$ENDIF}
 SetMousePos(MX,MY);
 __ShowMousePtr;
 ClrKbd
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Proc‚dure ScrnSaverIni                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de s‚lectionner un ‚conomiseur d'‚cran (Screen
 Saver) appropri‚ en fonction du mode en cours: texte ou graphique.
}

Procedure ScrnSaverAni;
Var
 Choice:Byte;
Begin
 If(IsGraf)Then Begin
  Randomize;
  If(CurrScrnSaver=ssRandom)Then Choice:=Random(5)+1
                            Else Choice:=CurrScrnSaver;
  Case(Choice)of
   ssAniStar3D:AniStar3D;
   ssAniMixingStar:If Not(AniMixingStar)Then AniStar;
   ssAniStarPlus:If Not(AniStarPlus)Then AniStar;
   ssAniMystify:AniMystify;
   Else AniStar;
  End;
  ChkMasterPassWord;
 End
  Else
 TxtBox;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Proc‚dure ScrollPage1to0                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure produit un effet de d‚filement vertical de la page 1 … la
 page 0 sans friture.
}

Procedure ScrollPage1to0;
Var
 J:Word;
Begin
 If Not(IsVideoDirectAccess)Then Exit;
 If(IsGraf)Then For J:=NmYPixels-1downto 0do Begin
  SetStartScreen(NmXTxts*J);
  WaitRetrace;
 End
  Else
 For J:=NmYPixels shr 1downto 0do SetVerticalScale(J shl 1);
End;

Function SelScrnSaver:Byte;Begin
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                     Proc‚dure SetStartScreen                    Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure fixe d'offset de point de d‚part de l'affichage de
 l'image vid‚o.
}

Procedure SetStartScreen;Assembler;ASM
 {$IFNDEF __Windows__}
  XOR AX,AX
  MOV ES,AX
  MOV DX,ES:[0463h]
  MOV AL,0Ch
  MOV AH,Byte Ptr T[1]
  OUT DX,AX
  MOV AL,0Dh
  MOV AH,Byte Ptr T
  OUT DX,AX
 {$ENDIF} 
END;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure SqueezeScreen                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure produit l'effet d'animation d'une ouverture de porte. La
 partie du haut d'un image descend et ainsi que la partie du bas monte.
}

Procedure SqueezeScreen;
Var
 ImgBuf:TByte Absolute Image;
Begin
 {$IFNDEF __Windows__}
  MoveLeft(Image,Mem[_A000:32000],32000);
  MoveLeft(ImgBuf[32000],Mem[_A000:0],32000);
  ASM
   MOV SI,200*80
   MOV DI,199
 @1:
   PUSH DI
    PUSH SI
     CALL WaitRetrace
     PUSH DI
     CALL SplitScreen
    POP SI
    PUSH SI
     PUSH SI
     CALL SetStartScreen
    POP SI
   POP DI
   SUB SI,80
   DEC DI
   CMP DI,99
   JAE @1
  END;
 {$ENDIF}
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Proc‚dure TxtBox                           Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure produit d'abord une disparition par carr‚ de l'image en
 cours.  Ensuite  une  petite balle  se promŠne un peu partout  … l'‚cran
 jusqu'… ce que l'utilisateur appuie sur le clavier ou d‚place la souris.
 Enfin,  il restaure l'‚cran d'origine avec affiche progressive de chaque
 ligne vertical (progression en 8 ‚tapes) de chaque caractŠre jusqu'… une
 restauration total.


 Remarque
 ÍÍÍÍÍÍÍÍ

  ş Il n‚cessite  une  carte  EGA  ou  post‚rieurs  (VGA, SVGA,...)  pour
    produire l'effet satisfesant  … chacune de  3 parties sinon  il saute
    des processus.

  ş Cette proc‚dure est destin‚ … l'usage exclusif de l'‚cran de texte et
    se comporte trŠs mal en mode graphique.
}

Procedure TxtBox;
Label Break,Xit;
Const
 CharBytes=32;
Var
 I,J,X,Y,Y1,R,LI:Byte;
 SW:Word;
 XB,YB:ShortInt;
 W,Font:^TByte;
 Rand:Array[0..199]of Byte;
 S:String;
Begin
 ClsCur;
 {$IFNDEF __Windows__}
  If(FontFound)and Not(IsMono)Then Begin
   Font:=MemAlloc(HeightChr*256);
   If(Font=NIL)Then Goto Xit;
   SetModeMtx;
   For I:=0to 255do MoveLeft(Mem[_A000:I*CharBytes],Font^[I*HeightChr],HeightChr);
   SetModeScr;
  End;
 {$ENDIF}
 SW:=SizeBoxTxt(0,0,MaxXTxts,MaxYTxts);
 W:=MemAlloc(SW);
 If(W=NIL)Then Begin
  FreeMemory(Font,HeightChr*256);
  Goto Xit;
 End;
 CopyBoxTxt(0,0,MaxXTxts,MaxYTxts,W^);
 If NmXTxts=80Then Begin
  {$IFDEF __Windows__}
   SetLength(S,200);
  {$ELSE}
   S[0]:=#200;
  {$ENDIF}
  For I:=0to 199do S[I+1]:=Char(I);
  For I:=0to 199do Begin R:=Random(Length(S))+1;Rand[I]:=Byte(S[R]);DelChrAt(S,R);End;
  For I:=0to 199do Begin
   X:=(Rand[I]div 20)shl 2;Y1:=Rand[I]and 15;
   BarSpcHor(X,Y1,X+3,7);
   BarSpcHor(76-X,Y1,79-X,7);
   Y:=MaxYTxts-Y1;
   If(Y<=MaxYTxts)Then Begin BarSpcHor(X,Y,X+3,7);BarSpcHor(76-X,Y,79-X,7)End;
   If(KeyPress)or(MouseMove)Then Goto Break;
   If I and 15=0Then Delay(10);{Wait7;}
  End;
 End;
Break:
 ClrScrBlack;
 X:=0;Y:=0;XB:=3;YB:=1;
 {$IFDEF Adele}
  If(IsLuxe)Then LI:=2 Else LI:=3;
 {$ENDIF}
 While Not((KeyPress)or(MouseMove))do Begin
  PutTxtXYUnCol(X,Y,Spc(LI));
  If(X=0)and(XB<0)Then XB:=-XB;
  If(Y=0)and(YB<0)Then YB:=-YB;
  X:=X+XB;Y:=Y+YB;
  If(X+XB>=MaxXTxts)Then XB:=-XB;
  If(Y+YB>=MaxYTxts)Then YB:=-YB;
  {$IFDEF Adele}
   SelIcon(X,Y,7);
  {$ELSE}
   PutTxtXYUnCol(X,Y,SelIcon);
  {$ENDIF}
  {$IFNDEF __Windows__}
   TaskSpooler;
  {$ENDIF}
  Delay(10);{Wait7;}
 End;
 ChkMasterPassWord;
 {$IFNDEF __Windows__}
  If(FontFound)and Not(IsMono)and{$IFDEF Adele}(IsLuxe){$ELSE}(Length(CloseIcon)=2){$ENDIF}Then Begin
   For J:=0to 8do Begin
    If J=1Then Begin
     PutBoxTxt(0,0,MaxXTxts,MaxYTxts,W^);
     For I:=0to(MaxYTxts)do BarSelHor(0,I,MaxXTxts,7);
    End;
    SetModeMtx;
    For I:=0to 255do
     MoveLeft(Font^[I*HeightChr],Mem[_A000:I*CharBytes],HeightChr);
    ASM
     JMP @0
 @M: DB 0,1,3,7,15,31,63,127,$FF
 @0: MOV CX,_A000
     MOV ES,CX
     MOV CH,$20
     MOV BH,0
     MOV BL,J
     MOV SI,Offset @M
     MOV AL,CS:[BX+SI]
     XOR DI,DI
 @1: AND ES:[DI],AL
     INC DI
     LOOP @1
    END;
    SetModeScr;
    TaskSpooler;
    Delay(100);
   End;
   FreeMemory(Font,HeightChr*256);
  End;
 {$ENDIF}
 PutBoxTxt(0,0,MaxXTxts,MaxYTxts,W^);
 FreeMemory(W,SW);
Xit:
 SimpleCur;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Proc‚dure VPan                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet  de fixer la position vertical  au pixel prŠs
 des caractŠres affich‚es … l'‚cran.


 Remarque
 ÍÍÍÍÍÍÍÍ

  ş Le panoramique vertical autoriser se situe entre la formule ®0¯ et
    ®GetHeightChr-1¯.
}

Procedure VPan;Assembler;ASM
 MOV DX,$3D4
 MOV AL,8
 MOV AH,Y
 OUT DX,AX
END;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                             Proc‚dure Wait7                            Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'attendre environ 1/10 de seconde par l'entremise
 du signal vid‚o.
}

Procedure Wait7;Begin
 WaitRetrace;WaitRetrace;WaitRetrace;
 WaitRetrace;WaitRetrace;WaitRetrace;
 WaitRetrace;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Fonction YesNo                            Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction affiche un mesesage et permet … l'utilisateur de choisir
 entre un ®Oui¯ ou un ®Non¯ et retourne le choix de l'utilisateur.
}

Function YesNo;
Label 0;
Const
 Max=1;
 KS:Array[0..1]of String[3]=(
  'Oui','Non'
 );
Var
 X:Byte;
 K,BM,XM,YM,P:Word;
 OldkType,W:Byte;
 T:TextBoxRec;

 Procedure UndoBar;Begin
  X:=MaxXTxts shr 1;
  If P=0Then Dec(X,7)Else Inc(X,2);
  PutKeyHori(X,T.Y1+4,X+6,KS[P],$F0,$11);
 End;

 Procedure PutBar;
 Var
  X:Byte;
 Begin
  X:=MaxXTxts shr 1;
  If P=0Then Dec(X,7)Else Inc(X,2);
  Case(W)of
   0:PutKeyHori(X,T.Y1+4,X+6,KS[P],$FE,$11);
   $10:PutKeyHori(X,T.Y1+4,X+6,KS[P],$FB,$11);
  End;
  W:=(W+1)and$1F;
 End;

Begin
 SetMouseMoveAreaX(0,8);
 X:=Length(Msg)+3;
 YesNo:=False;
 OldkType:=kType;kType:=ktBig;
 W:=0;
 __GetCenterTxt(X,7,T);
 ClrWn(T.X1,T.Y1,T.X2,T.Y2,$1F);
 PutRect(T.X1*8,T.Y1*GetHeightChr,T.X2*8+7,(T.Y2+1)*GetHeightChr-1,$F);
 PutTxtCenter(T.Y1+1,__Justified__,Msg,$1F);
 For P:=1downto 0do UndoBar;
 Repeat
  Repeat
   WaitRetrace;
   PutBar;
   GetMouseSwitch(XM,YM,BM);
   If(XM shr 3<>P)Then Begin
    UndoBar;
    P:=XM shr 3;
    PutBar;
   End;
   If BM>0Then Goto 0;
  Until KeyPress;
  K:=ReadKey;
  Case(K)of
   kbHome:Begin
    UndoBar;
    P:=0;
    SetMousePos(0,0);
    PutBar;
   End;
   kbUp,kbLeft,kbDn,kbTab,kbRight:Begin
    UndoBar;
    ASM XOR P,1;END;
    SetMousePos(P*8,0);
    PutBar;
   End;
   kbEnd:Begin
    UndoBar;
    P:=Max;SetMousePos(8,0);
    PutBar;
   End;
   kbEnter:0:Begin
    YesNo:=Not Boolean(P);
    Break;
   End;
   kbEsc:Break;
  End;
 Until False;
 kType:=OldkType;
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

END.