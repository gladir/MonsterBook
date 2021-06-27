Unit DrawTxtu;

INTERFACE

Uses Systex,Isatex;

Procedure RIPlasma(Var Q:MCanvas);
Procedure DWPlasma(Var Q:DrawEditApp);

IMPLEMENTATION

Uses Adele,Math,Restex,Systems,Video,Dials,DrawEdit;

Const
 FUZZ1=1;
 FUZZ2=1;

Function RIGetPixel(Var Q:MCanvas;X,Y:Word):Word;Near;
Var
 W:Word;
 F:LongInt;
Begin
 If(Q.BitmapInit)Then Begin
  F:=Mul2Word(Y,Q.Res.BytesPerLine)+
     Long(LocalBytesPerLine(X,Q.Res.BitsPerPixel)+SizeOf(ImageHeaderRes));
  Case(Q.Struct.BitsPerPixel)of
   9..16:Begin
    XGetAbsRec(Q.Miroir,F,SizeOf(Word),W);
    RIGetPixel:=W
   End;
   Else RIGetPixel:=0;
  End
 End
  Else
 RIGetPixel:=0;
End;

Procedure RISetPixel(Var Q:MCanvas;X,Y,Color:Word);Near;
Var
 F:LongInt;
Begin
 If(Q.BitmapInit)Then Begin
  F:=Mul2Word(Y,Q.Res.BytesPerLine)+
     Long(LocalBytesPerLine(X,Q.Res.BitsPerPixel)+SizeOf(ImageHeaderRes));
  Case(Q.Struct.BitsPerPixel)of
   9..16:XSetAbsRec(Q.Image,F,SizeOf(Word),Color);
  End;
 End;
End;

Function Clamp(X:SmallInt):Byte;Near;Begin
 If WordRec(X).Hi=0Then Clamp:=X Else
 If X<0Then Clamp:=0
       Else Clamp:=255;
End;

Function RandomColour:Word;Near;Begin
 RandomColour:=RGB2Color(Random(256),Random(256),Random(256));
End;

Function Max(A,B:SmallInt):SmallInt;Near;Begin
 If(a<b)Then Max:=b
        Else Max:=a;
End;

{Function Mid(a,b:SmallInt):SmallInt;Near;Begin
 Mid:=(a+b)shr 1;
End;}
Function Mid(a,b:SmallInt):SmallInt;Near;Assembler;ASM
 MOV AX,a
 ADD AX,b
 SHR AX,1
END;

Function RIRidge(Var Q:MCanvas;a,b,c,d:SmallInt):SmallInt;Near;
Var
 m,n:RGB;
Begin
 _Color2RGB(WIGetPixel(Q,a,b),Q.Res.BitsPerPixel,m);
 _Color2RGB(WIGetPixel(Q,c,d),Q.Res.BitsPerPixel,n);
 RIRidge:=_RGB2Color(Q.Res.BitsPerPixel,Clamp((m.R+n.R)shr 1),
                     Clamp((m.G+n.G)shr 1),Clamp((m.B+n.B)shr 1));
End;

Procedure RIQuarter(Var Q:MCanvas;l,t,r,b:Integer);Near;
Var
 mx,my,Width,Colour,Variance:SmallInt;
 m,n,o,p:RGB;
 mzr,mzg,mzb:Byte;
 vd2:SmallInt;
begin
 Width:=r-l;
 If(Width>1)or(b-t>1)Then Begin
  Variance:=Width*FUZZ1 div FUZZ2;
  vd2:=Variance shr 1;
  mx:=Mid(l,r);
  my:=Mid(t,b);
  _Color2RGB(RIGetPixel(Q,l,t),Q.Res.BitsPerPixel,m);
  _Color2RGB(RIGetPixel(Q,l,b),Q.Res.BitsPerPixel,n);
  _Color2RGB(RIGetPixel(Q,r,t),Q.Res.BitsPerPixel,o);
  _Color2RGB(RIGetPixel(Q,r,b),Q.Res.BitsPerPixel,p);
   {Mettre on/off les palettes...}
  mzr:=Clamp(((m.R+n.R+o.R+p.R)shr 2)+Random(Variance)-vd2);
  mzg:=Clamp(((m.G+n.G+o.G+p.G)shr 2)+Random(Variance)-vd2);
  mzb:=Clamp(((m.B+n.B+o.B+p.B)shr 2)+Random(Variance)-vd2);
  RISetPixel(Q,mx,my,RGB2Color(mzr,mzg,mzb));
  RISetPixel(Q,l,my,RIRidge(Q,l,t,l,b));
  RISetPixel(Q,r,my,RIRidge(Q,r,t,r,b));
  RISetPixel(Q,mx,t,RIRidge(Q,l,t,r,t));
  RISetPixel(Q,mx,b,RIRidge(Q,l,b,r,b));
  RIQuarter(Q,l,t,mx,my);
  RIQuarter(Q,l,my,mx,b);
  RIQuarter(Q,mx,t,r,my);
  RIQuarter(Q,mx,my,r,b);
 End;
End;

Procedure RIPlasma(Var Q:MCanvas);
VAr
 MaxX,MaxY:SmallInt;
Begin
 MaxX:=Q.Res.NumXPixels-1;
 MaxY:=Q.Res.NumYPixels-1;
 RISetPixel(Q,0,0,RandomColour);
 RISetPixel(Q,0,MaxY,RandomColour);
 RISetPixel(Q,MaxX,0,RandomColour);
 RISetPixel(Q,MaxX,MaxY,RandomColour);
 RISetPixel(Q,Mid(0,MaxX),0,RandomColour);
 RISetPixel(Q,Mid(0,MaxX),MaxY,RandomColour);
 RISetPixel(Q,0,Mid(0,MaxY),RandomColour);
 RISetPixel(Q,Q.Res.NumXPixels,Mid(0,MaxY),RandomColour);
 RIQuarter(Q,0,0,MaxX,MaxY);
End;

Procedure DWPlasma(Var Q:DrawEditApp);
Var
 J:SmallInt;
Begin
 If Q.Canvas.Res.BitsPerPixel<15Then ErrMsgOk('15 bits de couleurs minimum requis')
  Else
 Begin
  RIPlasma(Q.Canvas);
  For J:=0to DrawEditApp(Q).W.MaxY*HeightChr-1do Begin
   WIUpdateLn(Q.Canvas,J);
  End
 End;
End;

END.