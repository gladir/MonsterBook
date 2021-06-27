{ Cette unit‚ renferme une application de dessin objet exploitable …
 partir de l'unit‚ ®Apps¯. Grƒce … cette unit‚, on peut faire des dessins
 … la Corel Draw, AutoCad ou des DFDs.
}

Unit TechDraw;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                 INTERFACE
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses Systex,Isatex;

Function  TDNew(Var Context;X1,Y1,X2,Y2:Byte):Boolean;
Function  TDNewDFD(Var Context;X1,Y1,X2,Y2:Byte):Boolean;
Function  TDNewElectronic(Var Context;X1,Y1,X2,Y2:Byte):Boolean;
Procedure TDOpen(Var Context;X1,Y1,X2,Y2:Byte;Const Path:String);
Function  TDSave(Var Context):Boolean;
Function  TDSaveAs(Var Context;Const FileName:String):Boolean;
Procedure TDBackOperation(Var Context);
Procedure TDObjectPropriety(Var Q:TechDrawApp);
Procedure TDOnKeyDown(Var Context;Key:Word;Shift:ShiftState);
Procedure TDOnMouseControl(Var Context;Control:Word);
Procedure TDOnMouseDown(Var Context;X,Y:Integer;TX,TY:Byte;Shift:Word);
Procedure TDOnMouseMove(Var Context;X,Y:Integer;TX,TY:Byte);
Procedure TDRefresh(Var Context);
Function  TDTitle(Var Context;Max:Byte):String;
Function  TDDone(Var Context):Word;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                               IMPLEMENTATION
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses
 Numerix,Adele,Memories,Systems,Math,Video,Mouse,Dialex,Dials,
 DialPlus,Imagetex,Editor,DrawKr,DrawInfo,Restex,ResServD,ResSaveI,
 TechDObj;

Procedure TDPutIconAnim(Var Q:TechDrawApp);Near;Forward;
Procedure TDPutIconDFD(Var Q:TechDrawApp);Near;Forward;
Procedure TDPutIconElec(Var Q:TechDrawApp);Near;Forward;
Procedure TDInsLine(Var Q:TechDrawApp;X1,Y1,X2,Y2,Z1,Z2:Word;Curr:Boolean);Near;Forward;
Procedure TDRefreshImage(Var Q:TechDrawApp);Near;Forward;
Procedure TDSetPixel(Var Q:TechDrawApp;X,Y:Integer;Color:Word);Near;Forward;

Function SingleToReal(X:Single):Real;
Var
 SingleByte:Record
  A,B,C,D:Byte;
 End Absolute X;
 Y:Real;
 RealByte:Record
  A,B,C,D,E,F:Byte;
 End Absolute Y;
Begin
 {$IFDEF N+}
  SingleToReal:=X;
 {$ELSE}
  Y:=0.0;
  RealByte.A:=(SingleByte.D shl 1)+1+((SingleByte.C and$80)shr 6);
  If(RealByte.A and 1=1)and(SingleByte.D and$F<>$F)Then Inc(RealByte.A);
  RealByte.D:=SingleByte.A;
  RealByte.E:=SingleByte.B;
  RealByte.F:=(SingleByte.C and$7F)or(SingleByte.D and$80);
  SingleToReal:=Y;
 {$ENDIF}
End;

Function IsBoxObject(ID:Byte):Boolean;Begin
 IsBoxObject:=ID in[imiDFDProcessus,imiRealBox];
End;

Function RGBToColor(Const Q:RGB):Word;Begin
 RGBToColor:=RGB2Color(Q.R,Q.G,Q.B);
End;

Function TDGetPos(Var Q:TechDrawApp;X,Y:Integer):LongInt;
Var
 P:LongInt;
Begin
 P:=Mul2Word(Q.ResImage.BytesPerLine,Y)+SizeOf(ImageHeaderRes);
 Case(Q.ResImage.BitsPerPixel)of
  1:Inc(P,X shr 3);
  4:Inc(P,X shr 1);
  15..16:Inc(P,X shl 1);
  24:Inc(P,X*3);
  Else Inc(P,X);
 End;
 TDGetPos:=P;
End;

Function TDGetColorImage(Var Q:TechDrawApp;Color:Word):Word;
Var
 RGBColor:RGB;
Begin
 If Color<=15Then Begin
  TDGetColorImage:=_RGB2Color(Q.ResImage.BitsPerPixel,
                              DefaultRGB[Color].R,
                              DefaultRGB[Color].G,
                              DefaultRGB[Color].B);
 End
  Else
 Begin
  Color2RGB(Color,RGBColor);
  TDGetColorImage:=_RGB2Color(Q.ResImage.BitsPerPixel,RGBColor.R,RGBColor.G,RGBColor.B);
 End;
End;

Procedure TDFillClearImage(Var Q:TechDrawApp;P:LongInt;Len,Color:Word);
Var
 Image:^TByte;
 Size:Word;
Begin
 Size:=Len shl 1;
 Image:=MemAlloc(Size);
 If(Image<>NIL)Then Begin
  FillWord(Image^,Len,Color);
  XSetAbsRec(Q.Image,P,Size,Image^);
  FreeMemory(Image,Size);
 End;
End;

Procedure TDCopy8Bin(Var Q:TechDrawApp;X,Y:Integer;Masque:Byte;Background,Foreground:Word);
Var
 L:Word;
 I:Byte;
Begin
 For I:=0to 7do Begin
  If Masque and$80=$80Then L:=Foreground
                      Else L:=Background;
  TDSetPixel(Q,X,Y,L);
  Inc(X);
  ASM SHL Masque,1;END;
 End
End;

Procedure TDOutSmlTxtXY(Var Q:TechDrawApp;X,Y:Integer;Const Msg:String;Color:Word);Near;
Var
 I,J,K,L,Masque:Byte;
 Chr:Char;
 Int1Fh:^TByte Absolute {$IFNDEF FLAT386}$0000:{$ENDIF}$007C;
Begin
 If(Q.IsImage)Then Begin
  For J:=1to Length(Msg)do Begin
   Chr:=Msg[J];
   For I:=0to 8-1do Begin
    If Chr>=#$80Then
     Masque:=Int1Fh^[((Byte(Chr)and$7F)shl 3)+I]
    {$IFNDEF NotReal}
     Else
      Masque:=Mtx8x8High[(Byte(Chr)shl 3)+I]
    {$ENDIF};
    TDCopy8Bin(Q,X,Y+I,Masque,Color shr 4,Color and$F);
   End;
   Inc(X,8)
  End;
 End
  Else
 Begin
  Inc(X,Q.Screen.X1);
  Inc(Y,Q.Screen.Y1);
  If(Y<Q.Screen.Y1)or(Y+8>Q.Screen.Y2)Then Exit;
  If(X+(Length(Msg)shl 3)>Q.Screen.X2)Then Exit;
  If(X<Q.Screen.X1)Then Exit;
  OutSmlTxtXY(X,Y,Msg,Color);
 End;
End;

Procedure TDSetPixel(Var Q:TechDrawApp;X,Y:Integer;Color:Word);Begin
 If(Q.IsImage)Then Begin
  If(Y<0)or(Y>Q.ResImage.NumYPixels)or(X<0)or(X>Q.ResImage.NumXPixels)Then Exit;
  Color:=TDGetColorImage(Q,Color);
  XSetAbsRec(Q.Image,TDGetPos(Q,X,Y),SizeOf(Word),Color);
 End
  Else
 Begin
  Inc(X,Q.Screen.X1);
  Inc(Y,Q.Screen.Y1);
  If(Y<Q.Screen.Y1)Then Exit;
  If(Y>Q.Screen.Y2)or(X<Q.Screen.X1)or(X>Q.Screen.X2)Then Exit;
  SetPixel(X,Y,Color);
 End;
End;

Procedure TDPutLineHor(Var Q:TechDrawApp;X1,Y,X2:Integer;Color:Word);Near;
Var
 RGBColor:RGB;
Begin
 If(Q.IsImage)Then Begin
  If(Y<0)Then Exit;
  If(Y>Q.ResImage.NumYPixels)Then Exit;
  If(X1>X2)Then SwapInt(X1,X2);
  If(X1>Q.ResImage.NumYPixels)Then Exit;
  If(X1<0)Then X1:=0;
  If(X2>Q.ResImage.NumXPixels)Then X2:=Q.ResImage.NumYPixels;
  TDFillClearImage(Q,TDGetPos(Q,X1,Y),X2-X1+1,TDGetColorImage(Q,Color));
 End
  Else
 Begin
  Inc(Y,Q.Screen.Y1);
  Inc(X1,Q.Screen.X1);
  Inc(X2,Q.Screen.X1);
  If(Y<Q.Screen.Y1)Then Exit;
  If(Y>Q.Screen.Y2)Then Exit;
  If(X1>X2)Then SwapInt(X1,X2);
  If(X1>Q.Screen.X2)Then Exit;
  If(X1<Q.Screen.X1)Then X1:=Q.Screen.X1;
  If(X2>Q.Screen.X2)Then X2:=Q.Screen.X2;
  PutLnHor(X1,Y,X2,Color);
 End;
End;

Procedure TDPutLine(Var Q:TechDrawApp;X1,Y1,X2,Y2:Integer;Color:Word);Near;
Var
 D,DX,DY,I,J,Ainc,Binc,Ic:LongInt;
Begin
 If(Y2=Y1)Then Begin
  TDPutLineHor(Q,X1,Y1,X2,Color);
  Exit;
 End;
 If Abs(X2-X1)<Abs(Y2-Y1)Then Begin
  If(Y1>Y2)Then Begin
   SwapInt(X1,X2);
   SwapInt(Y1,Y2);
  End;
  If(X2>X1)Then Ic:=1
           Else Ic:=-1;
  DY:=Y2-Y1;
  DX:=Abs(X2-X1);
  D:=(DX shl 1)-DY;
  Ainc:=(DX-DY)shl 1;
  Binc:=DX shl 1;
  J:=X1;
  TDSetPixel(Q,X1,Y1,Color);
  I:=Y1+1;
  While(I<=Y2)do Begin
   If D>=0Then Begin
    Inc(J,Ic);
    Inc(D,Ainc)
   End
    Else
   Inc(D,Binc);
   TDSetPixel(Q,J,I,Color);
   Inc(I);
  End;
 End
  else
 Begin
  If(X1>X2)Then Begin
   SwapInt(X1,X2);
   SwapInt(Y1,Y2);
  End;
  If(Y2>Y1)Then Ic:=1
           Else Ic:=-1;
  DX:=X2-X1;
  DY:=Abs(Y2-Y1);
  D:=(DY shl 1)-DX;
  AInc:=(DY-DX)shl 1;
  BInc:=DY shl 1;
  J:=Y1;
  TDSetPixel(Q,X1,Y1,Color);
  I:=X1+1;
  While(I<=X2)do Begin
   If D>=0Then Begin
    Inc(J,Ic);
    Inc(D,Ainc)
   End
    Else
   Inc(D,Binc);
   TDSetPixel(Q,I,J,Color);
   Inc(I);
  End;
 End;
End;

Procedure TDPutRect(Var Q:TechDrawApp;X1,Y1,X2,Y2:Integer;Color:Word);Near;
Var
 J:Integer;
Begin
 If(Y1>Y2)Then SwapInt(Y1,Y2);
 TDPutLineHor(Q,X1,Y1,X2,Color);
 For J:=Y1+1to Y2-1do Begin
  TDSetPixel(Q,X1,J,Color);
  TDSetPixel(Q,X2,J,Color);
 End;
 TDPutLineHor(Q,X1,Y2,X2,Color);
End;

Procedure TDPutRoundRect(Var Q:TechDrawApp;x1,y1,x2,y2,LineWidth,b:Integer;Color:Word);Near;
Var
 a,xr,yr,x,i,j,y,xN,yN:LongInt;
 AO,BO,AO2,BO2,AO4,BO4,d:LongInt;
Begin
 If LineWidth>0Then Dec(LineWidth);
 y:=y1;y1:=y2;y2:=y;
 yr:=b;xr:=b;xN:=x2-xr;yN:=y2+yr;
 For j:=-(LineWidth shr 1)to LineWidth shr 1+(LineWidth and 1)do Begin
  TDPutLineHor(Q,x1+xr,y1-j,xN,Color);
  TDPutLineHor(Q,x1+xr,y2-j,xN,Color);
 End;
 For j:=-(LineWidth shr 1)to LineWidth shr 1+(LineWidth and 1)do Begin
  For i:=y1-yr downto(yN)do Begin
   TDSetPixel(Q,x1+j,i,Color);
   TDSetPixel(Q,x2+j,i,Color)
  End;
 End;
 Dec(b,LineWidth shr 1);a:=b;
 For i:=0to(LineWidth)do Begin
  BO:=b*b;AO:=a*a;y:=b;x:=0;
  ASM
    {AO2:=AO shl 1}
   {$IFDEF __386__}
    DB 66h;MOV AX,Word Ptr AO
    DB 66h;SHL AX,1
    DB 66h;MOV Word Ptr AO2,AX
   {$ELSE}
    LES AX,AO
    MOV DX,ES
    SHL AX,1
    RCL DX,1
    MOV Word Ptr AO2,AX
    MOV Word Ptr AO2[2],DX
   {$ENDIF}
    {AO4:=AO shl 2;}
   {$IFDEF __386__}
    DB 66h;SHL AX,1
    DB 66h;MOV Word Ptr AO4,AX
   {$ELSE}
    SHL AX,1
    RCL DX,1
    MOV Word Ptr AO4,AX
    MOV Word Ptr AO4[2],DX
   {$ENDIF}
    {BO2:=BO shl 1;}
   {$IFDEF __386__}
    DB 66h;MOV AX,Word Ptr BO
    DB 66h;SHL AX,1
    DB 66h;MOV Word Ptr BO2,AX
   {$ELSE}
    LES AX,BO
    MOV DX,ES
    SHL AX,1
    RCL DX,1
    MOV Word Ptr BO2,AX
    MOV Word Ptr BO2[2],DX
   {$ENDIF}
    {BO4:=BO shl 2;}
   {$IFDEF __386__}
    DB 66h;SHL AX,1
    DB 66h;MOV Word Ptr BO4,AX
   {$ELSE}
    SHL AX,1
    RCL DX,1
    MOV Word Ptr BO4,AX
    MOV Word Ptr BO4[2],DX
   {$ENDIF}
  END;
  {$IFDEF __386__}
   ASM
    MOV AX,Y
    DEC AX
    MUL Y
    DB ciPushDX,ciPushAX
    DW ciPopEAX
    DB 66h;IMUL Word Ptr AO2
    DB 66h;MOV BX,AX
    DB 66h;XOR AX,AX;INC AX
    DB 66h;SUB AX,Word Ptr AO
    DB 66h;DEC AX
    DB 66h;IMUL Word Ptr BO2
    DB 66h;ADD AX,BX
    DB 66h;ADD AX,Word Ptr AO
    DB 66h;MOV Word Ptr d,AX
   END;
  {$ELSE}
   d:=MulL(AO2,(y-1)*y)+AO+MulL(BO2,1-AO);
  {$ENDIF}
  While(MulL(AO,y)>MulL(BO,x))do Begin
   TDSetPixel(Q,x+xN,yN-y,Color);
   TDSetPixel(Q,x+xN,y1-yr+y,Color);
   TDSetPixel(Q,x1+xr-x,yN-y,Color);
   TDSetPixel(Q,x1+xr-x,y1-yr+y,Color);
   If d>=0Then Begin
    Dec(y);
    Dec(d,MulL(AO4,y))
   End;
   {$IFDEF __386__}
    ASM
     DB 66h;XOR AX,AX
     DB 66h;XOR BX,BX
     MOV AL,3
     MOV BX,X
     DB 66h;SHL BX,1
     DB 66h;ADD AX,BX
     DB 66h;IMUL Word Ptr BO2
     DB 66h;ADD Word Ptr D,AX
    END;
   {$ELSE}
    Inc(d,MulL(BO2,3+(x shl 1)));
   {$ENDIF}
   Inc(x);
  End;
  d:=MulL(BO2,(x+1)*x)+MulL(AO2,y*(y-2)+1)+MulL(1-AO2,BO);
  While y<>0do Begin
   TDSetPixel(Q,x+xN,yN-y,Color);
   TDSetPixel(Q,x+xN,y1-yr+y,Color);
   TDSetPixel(Q,x1+xr-x,yN-y,Color);
   TDSetPixel(Q,x1+xr-x,y1-yr+y,Color);
   If d<=0Then Begin
    Inc(x);
    Inc(d,MulL(BO4,x))
   End;
   Dec(y);
   {$IFDEF __386__}
    ASM
     DB 66h;XOR AX,AX
     DB 66h;XOR BX,BX
     MOV AL,3
     MOV BX,Y
     DB 66h;SHL BX,1
     DB 66h;SUB AX,BX
     DB 66h;IMUL Word Ptr AO2
     DB 66h;ADD Word Ptr D,AX
    END;
   {$ELSE}
    Inc(d,MulL(AO2,3-(y shl 1)));
   {$ENDIF}
  End;
  Inc(b);
  Inc(a)
 End;
End;

Procedure TDPutFillBox(Var Q:TechDrawApp;X1,Y1,X2,Y2:Integer;Color:Word);Near;
Var
 J:Integer;
 RGBColor:RGB;
Begin
 If(Q.IsImage)Then Begin
  If(Y1>Y2)Then SwapInt(Y1,Y2);
  If(Y1>=Q.ResImage.NumYPixels)or(Y2<0)Then Exit;
  If(Y1<0)Then Y1:=0;
  If(Y2>Q.ResImage.NumYPixels)Then Y2:=Q.ResImage.NumYPixels;
  If(X1>X2)Then SwapInt(X1,X2);
  If(X1>=Q.ResImage.NumXPixels)or(X2<0)Then Exit;
  If(X1<0)Then X1:=0;
  If(X2>Q.ResImage.NumXPixels)Then X2:=Q.ResImage.NumXPixels;
  Color:=TDGetColorImage(Q,Color);
  For J:=Y1 to(Y2)do Begin
   TDFillClearImage(Q,TDGetPos(Q,X1,J),X2-X1+1,Color);
  End;
 End
  Else
 Begin
  Inc(Y1,Q.Screen.Y1);
  Inc(X1,Q.Screen.X1);
  Inc(Y2,Q.Screen.Y1);
  Inc(X2,Q.Screen.X1);
  If(Y1>Y2)Then SwapInt(Y1,Y2);
  If(Y1>Q.Screen.Y2)or(Y2<Q.Screen.Y1)Then Exit;
  If(Y1<Q.Screen.Y1)Then Y1:=Q.Screen.Y1;
  If(Y2>Q.Screen.Y2)Then Y2:=Q.Screen.Y2;
  If(X1>X2)Then SwapInt(X1,X2);
  If(X1>Q.Screen.X2)or(X2<Q.Screen.X1)Then Exit;
  If(X1<Q.Screen.X1)Then X1:=Q.Screen.X1;
  If(X2>Q.Screen.X2)Then X2:=Q.Screen.X2;
  PutFillBox(X1,Y1,X2,Y2,Color);
 End;
End;

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

Procedure TDFillPoly(Var Q:TechDrawApp;Num:Integer;Var P:Array of Integer;Color:Word);
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
   TDPutLineHor(Q,XC^[I],YC^[I],XC^[I+1],Color);
   Toggle:=1;
  End
   else
  Toggle:=0;
 End;
 FreeMemory(XC,4000*SizeOf(Integer));
 FreeMemory(YC,4000*SizeOf(Integer));
End;

Procedure TDPutFillRoundRect(Var Q:TechDrawApp;x1,y1,x2,y2,b:Integer;Color:Word);
Var
 a,xr,yr,x,j,y,xN,yN:LongInt;
 AO,BO,AO2,BO2,AO4,BO4,d:LongInt;
Begin
 y:=y1;y1:=y2;y2:=y;yr:=b;xr:=b;xN:=x1+xr;yN:=y1-yr;
 If Not(y2+b>=yN)Then Begin
  TDPutFillBox(Q,x1,y2+b,x2,yN,Color);
 End;
 a:=b;BO:=b*b;AO:=a*a;y:=b;x:=0;
 ASM
   {AO2:=AO shl 1}
  {$IFDEF __386__}
   DB 66h;MOV AX,Word Ptr AO
   DB 66h;SHL AX,1
   DB 66h;MOV Word Ptr AO2,AX
  {$ELSE}
   LES AX,AO
   MOV DX,ES
   SHL AX,1
   RCL DX,1
   MOV Word Ptr AO2,AX
   MOV Word Ptr AO2[2],DX
  {$ENDIF}
   {AO4:=AO shl 2;}
  {$IFDEF __386__}
   DB 66h;SHL AX,1
   DB 66h;MOV Word Ptr AO4,AX
  {$ELSE}
   SHL AX,1
   RCL DX,1
   MOV Word Ptr AO4,AX
   MOV Word Ptr AO4[2],DX
  {$ENDIF}
   {BO2:=BO shl 1;}
  {$IFDEF __386__}
   DB 66h;MOV AX,Word Ptr BO
   DB 66h;SHL AX,1
   DB 66h;MOV Word Ptr BO2,AX
  {$ELSE}
   LES AX,BO
   MOV DX,ES
   SHL AX,1
   RCL DX,1
   MOV Word Ptr BO2,AX
   MOV Word Ptr BO2[2],DX
  {$ENDIF}
   {BO4:=BO shl 2;}
  {$IFDEF __386__}
   DB 66h;SHL AX,1
   DB 66h;MOV Word Ptr BO4,AX
  {$ELSE}
   SHL AX,1
   RCL DX,1
   MOV Word Ptr BO4,AX
   MOV Word Ptr BO4[2],DX
  {$ENDIF}
 END;
 {$IFDEF __386__}
  ASM
   MOV AX,Y
   DEC AX
   MUL Y
   DB ciPushDX,ciPushAX
   DW ciPopEAX
   DB 66h;IMUL Word Ptr AO2
   DB 66h;MOV BX,AX
   DB 66h;XOR AX,AX;INC AX
   DB 66h;SUB AX,Word Ptr AO
   DB 66h;DEC AX
   DB 66h;IMUL Word Ptr BO2
   DB 66h;ADD AX,BX
   DB 66h;ADD AX,Word Ptr AO
   DB 66h;MOV Word Ptr d,AX
  END;
 {$ELSE}
  d:=MulL(AO2,(y-1)*y)+AO+MulL(BO2,1-AO);
 {$ENDIF}
 While(MulL(AO,y)>MulL(BO,x))do Begin
  TDPutLineHor(Q,xN-y,yN+x,x2-yr+y,Color);
  TDPutLineHor(Q,xN-y,y2+xr-x,x2-yr+y,Color);
  If d>=0Then Begin
   Dec(y);
   Dec(d,MulL(AO4,y))
  End;
  {$IFDEF __386__}
   ASM
    DB 66h;XOR AX,AX
    DB 66h;XOR BX,BX
    MOV AL,3
    MOV BX,X
    DB 66h;SHL BX,1
    DB 66h;ADD AX,BX
    DB 66h;IMUL Word Ptr BO2
    DB 66h;ADD Word Ptr D,AX
   END;
  {$ELSE}
   Inc(d,MulL(BO2,3+(x shl 1)));
  {$ENDIF}
  Inc(x);
 End;
 d:=MulL(BO2,(x+1)*x)+MulL(AO2,y*(y-2)+1)+MulL(1-AO2,BO);
 While y<>0do Begin
  TDPutLineHor(Q,xN-y,x+yN,x2-yr+y,Color);
  TDPutLineHor(Q,xN-y,y2+xr-x,x2-yr+y,Color);
  If d<=0Then Begin
   Inc(x);
   Inc(d,MulL(BO4,x))
  End;
  Dec(y);
  {$IFDEF __386__}
   ASM
    DB 66h;XOR AX,AX
    DB 66h;XOR BX,BX
    MOV AL,3
    MOV BX,Y
    DB 66h;SHL BX,1
    DB 66h;SUB AX,BX
    DB 66h;IMUL Word Ptr AO2
    DB 66h;ADD Word Ptr D,AX
   END;
  {$ELSE}
   Inc(d,MulL(AO2,3-(y shl 1)));
  {$ENDIF}
 End;
End;

Function TDRestoreImage(Var Q:TechDrawApp;X1,Y1,X2,Y2:Integer;Var Img:ImgRec):Boolean;Begin
 Inc(Y1,Q.Screen.Y1);
 Inc(Y2,Q.Screen.Y1);
 Inc(X1,Q.Screen.X1);
 Inc(X2,Q.Screen.X1);
 If(Y1>Y2)Then SwapInt(Y1,Y2);
 If(Y1>Q.Screen.Y2)Then Exit;
 If(Y1<Q.Screen.Y1)Then Y1:=Q.Screen.Y1;
 If(Y2>Q.Screen.Y2)Then Y2:=Q.Screen.Y2;
 If(X1>X2)Then SwapInt(X1,X2);
 If(X1>Q.Screen.X2)Then Exit;
 If(X1<Q.Screen.X1)Then X1:=Q.Screen.X1;
 If(X2>Q.Screen.X2)Then X2:=Q.Screen.X2;
 TDRestoreImage:=RestoreImage(X1,Y1,X2,Y2,Img);
End;

Function TDSaveImage(Var Q:TechDrawApp;X1,Y1,X2,Y2:Integer;Var Img:ImgRec):Boolean;Begin
 Inc(Y1,Q.Screen.Y1);
 Inc(Y2,Q.Screen.Y1);
 Inc(X1,Q.Screen.X1);
 Inc(X2,Q.Screen.X1);
 If(Y1>Y2)Then SwapInt(Y1,Y2);
 If(Y1>Q.Screen.Y2)Then Exit;
 If(Y1<Q.Screen.Y1)Then Y1:=Q.Screen.Y1;
 If(Y2>Q.Screen.Y2)Then Y2:=Q.Screen.Y2;
 If(X1>X2)Then SwapInt(X1,X2);
 If(X1>Q.Screen.X2)Then Exit;
 If(X1<Q.Screen.X1)Then X1:=Q.Screen.X1;
 If(X2>Q.Screen.X2)Then X2:=Q.Screen.X2;
 TDSaveImage:=SaveImage(X1,Y1,X2,Y2,Img);
End;

Procedure TDGetMouseSwitch(Var Q:TechDrawApp;Var X,Y,Button:Word);Begin
 GetMouseSwitch(X,Y,Button);
 If(X>Q.Screen.X1)Then Dec(X,Q.Screen.X1)
                  Else X:=0;
 If(Y>Q.Screen.Y1)Then Dec(Y,Q.Screen.Y1)
                  Else Y:=0;
End;

Const
 ArrayMaxCoords=800;
 ArrayMaxFaces=1200;

Type
 tCoordRec=Record
  x,y,z:Real;
 End;

 tFaceRec=Record
  Z:Integer;
  L1,L2,L3:Word;
 End;

 IncludeObjectType=Array[1..10]of String;

Function Load3DSobject(FileName:String;DivFactor:Single;
                       Var IncludeObject:IncludeObjectType;
                       Var face:Array of tFaceRec;
                       Var coords:Array of tCoordRec;
                       Var FaceNr,CoordNr:Word):Boolean;
Var
{ f:File;}
 Handle:Hdl;
 LastCoordNr:Word;

 Function ParseAsciiString:String;
 Var
  Tmp:String;
  c:Char;
  Oldpos:LongInt;
 Begin
  Tmp:='';
  Repeat
   _GetRec(Handle,1,C);
   If c=#0Then Break;
   IncStr(Tmp,C);
  Until False;
  ParseAsciiString:=Tmp;
 End;

 Procedure ParseVertexList;
 Const
  MaxSize=400;
 Type
  tVertex=Record
   x,y,z:Single;
  End;
 Var
  NumCoords:Word;
  I:Integer;
  Vertex:tVertex;
 Begin
  _GetRec(Handle,SizeOf(Word),numCoords);
  If SysErr<>0Then Exit;
  For I:=1to(NumCoords)do Begin
   If(CoordNr>ArrayMaxCoords)Then Exit;
   _GetRec(Handle,SizeOf(tVertex),Vertex);
   If SysErr<>0Then Exit;
   Coords[CoordNr].X:=SingleToReal(Vertex.X);
   Coords[CoordNr].Y:=SingleToReal(Vertex.Y);
   Coords[CoordNr].Z:=SingleToReal(vertex.z);
   If(Abs(Coords[CoordNr].X)>MaxSize)or(Abs(Coords[CoordNr].Y)>MaxSize)or(Abs(coords[CoordNr].Z)>MaxSize)Then Exit;
   Inc(CoordNr);
  End;
 End;

 Procedure ParsePointList;
 Type
  tPoint=Record
   p1,p2,p3:Word;
   Flag:Word;
  End;
 Var
  N:Word;
  I,numPoints:Word;
  Point:tPoint;
 Begin
  _GetRec(Handle,SizeOf(Word),NumPoints);
  If SysErr<>0Then Exit;
  For I:=1to(NumPoints)do Begin
   If(FaceNr>ArrayMaxFaces)Then Exit;
   _GetRec(Handle,SizeOf(tPoint),Point);
   If SysErr<>0Then Exit;
   Face[FaceNr].l1:=Point.p1+LastCoordNr;
   Face[FaceNr].l2:=Point.p2+LastCoordNr;
   Face[FaceNr].l3:=Point.p3+LastCoordNr;
   Inc(FaceNr);
  End;
 End;

 Procedure ParseMaterial;
 Var
  MatName:String;
 Begin
  MatName:=StrUp(ParseAsciiString);
 End;

 Procedure ParseLight;
 Type
  tLight=Record
   X,Y,Z:Single;
  End;
 Var
  Light:tLight;
 Begin
  _GetRec(Handle,SizeOf(tLight),Light);
 End;

 Procedure ParseCamera;
 Type
  tCamera=Record
   x,y,z:Single;
   TargetX,TargetY,TargetZ:Single;
   Bank,Lens:Single;
  End;
 Var
  Camera:tCamera;
 Begin
  _GetRec(Handle,SizeOf(tCamera),Camera);
 End;

 Procedure ParseTriPolygonObjectChunk;
 Var
  Chunk:Chunk3DStudio;
  OldPos:LongInt;
 Begin
  LastCoordNr:=CoordNr;
  Repeat
   OldPos:=GetFilePos(Handle);
   _GetRec(Handle,SizeOf(Chunk3DStudio),Chunk);
   If SysErr<>0Then Break;
   If(Chunk.ID<=$4100)or(Chunk.ID>=$4200)Then Break;
   Case(Chunk.ID)of
    $4110:ParseVertexList;
    $4120:ParsePointList;
    $4130:ParseMaterial;
   End;
   SetFilePos(Handle,OldPos+Chunk.Next);
  Until False;
 End;

 Procedure ParseObjectMeshChunk;
 Var
  ObjectName:String;
  Chunk:Chunk3DStudio;
  OldPos:LongInt;
  i:Word;
 Begin
  ObjectName:=StrUp(ParseAsciiString);
  For i:=1to High(IncludeObject)do Begin
   If IncludeObject[i]=''Then Exit;
   If IncludeObject[i]='*'Then Break;
   If(IncludeObject[i]=ObjectName)Then Break;
  End;
  Repeat
   OldPos:=GetFilePos(Handle);
   _GetRec(Handle,SizeOf(Chunk3DStudio),Chunk);
   If SysErr<>0Then Break;
   If(Chunk.ID<=$4000)or(Chunk.ID>=$5000)Then Break;
   Case(Chunk.ID)of
    $4100:ParseTriPolygonObjectChunk;
    $4600:ParseLight;
    $4700:ParseCamera;
   End;
   SetFilePos(Handle,OldPos+Chunk.Next);
  Until False;
 End;

 Procedure ParsePrimaryChunk;
 Var
  Chunk:Chunk3DStudio;
  OldPos:LongInt;
 Begin
  Repeat
   OldPos:=GetFilePos(Handle);
   If(_GetRec(Handle,SizeOf(Chunk3DStudio),Chunk)=0)or(SysErr<>0)Then Break;
   Case(Chunk.ID)of
    $4000:ParseObjectMeshChunk;
    $AFFF:ParseMaterial;
    $B000:Break;
   End;
   SetFilePos(Handle,OldPos+Chunk.Next);
  Until False;
 End;

Var
 Chunk:Chunk3DStudio;
 OldPos:LongInt;
 I:Word;
Begin
 Load3DSobject:=False;
 If Pos('.', FileName)=0Then AddStr(FileName,'.3DS');
 Handle:=FileOpen(FileName,fmRead);
 If(Handle=errHdl)Then Exit;
 CoordNr:=0;
 FaceNr:=0;
 For I:=1to High(IncludeObject)do IncludeObject[i]:=StrUp(IncludeObject[i]);
 _GetRec(Handle,SizeOf(Chunk3DStudio),Chunk);
 If(Chunk.ID=$4D4D)or(SysErr=0)Then Begin
  Repeat
   OldPos:=GetFilePos(Handle);
   If(_GetRec(Handle,SizeOf(Chunk3DStudio),Chunk)=0)or(SysErr<>0)Then Break;
   Case(Chunk.ID)of
    $3D3D:ParsePrimaryChunk;
   End;
   SetFilePos(Handle,OldPos+Chunk.Next);
  Until False;
 End;
 FileClose(Handle);
 Load3DSobject:=Not((CoordNr=0)or(FaceNr=0));
End;

Function TDPutElectronicCode(Var Q:TechDrawApp;X,Y:Word;Code,Attr:Byte):Boolean;
Var
 Width,Height:Byte;
 I,J:Integer;
 XP:Word;
 Masque:Byte;
Begin
 TDPutElectronicCode:=False;
 If(IsGrf)Then Begin
  If DBLocateAbsIM(Q.Composant,0,Code,[])Then Begin
   Inc(PtrRec(Q.Composant.CurrRec.Ptr).Ofs);
   Width:=Q.Composant.CurrRec.Byte^;
   Inc(PtrRec(Q.Composant.CurrRec.Ptr).Ofs);
   Height:=Q.Composant.CurrRec.Byte^;
   Inc(PtrRec(Q.Composant.CurrRec.Ptr).Ofs);
   Inc(PtrRec(Q.Composant.CurrRec.Ptr).Ofs,Q.Composant.CurrRec.Byte^+2);
  End
   Else
  Exit;
  Inc(X,Q.Screen.X1);
  Inc(Y,Q.Screen.Y1);
  For I:=0to Height-1do Begin
   XP:=X;
   For J:=0to Width-1do Begin
    Masque:=Q.Composant.CurrRec.Byte^;
    Copy8Bin(XP,Y,Masque,Attr shr 4,Attr and$F);
    Inc(PtrRec(Q.Composant.CurrRec.Ptr).Ofs);
    Inc(XP,8);
   End;
   Inc(Y);
  End;
  TDPutElectronicCode:=True;
 End;
End;

Function TDPutElecCode(Var Q:TechDrawApp;X,Y,Code,Attr:Byte):Boolean;Begin
 If(Y>=Q.W.MaxY-4)Then Begin
  If(Q.CompPosX<>NIL)Then Begin
   Q.CompPosX^[Code]:=X;
  End;
  If(Q.CompPosY<>NIL)Then Begin
   Q.CompPosY^[Code]:=Y;
  End;
 End;
 TDPutElecCode:=TDPutElectronicCode(Q,X shl 3,GetRawY(Y),Code,Attr);
End;

Function _TDNew(Var Q:TechDrawApp;X1,Y1,X2,Y2,Mode:Byte):Boolean;Begin
 _TDNew:=True;
 FillClr(Q,SizeOf(Q));
 Q.FileInfo.Origin:=Mode;
 Case(Mode)of
  tdElectronic:Begin
   Color2RGB(GetClassicToColor(Green),
             Q.FileInfo.BackgroundColor);
   DBOpenServerName(ChantalServer,'CHANTAL:/Dessin/PieceElectronique.Dat');
   DBCopyToMemory(ChantalServer,Q.Composant);
   Q.CompSize:=256;
   Q.CompPosX:=MemNew(Q.CompSize);
   Q.CompPosY:=MemNew(Q.CompSize);
   Q.PosPalette2:=154;
  End;
  tdDFD:Begin
   Q.FileInfo.BackgroundColor.R:=255;
   Q.FileInfo.BackgroundColor.G:=255;
   Q.FileInfo.BackgroundColor.B:=220;
  End;
  Else Begin
   Color2RGB(GetClassicToColor(CurrKrs.Dialog.Env.List.Border shr 4),
             Q.FileInfo.BackgroundColor);
  End;
 End;
 Q.TrueBackgroundColor:=RGBToColor(Q.FileInfo.BackgroundColor);
 Q.FileInfo.Mode:=drwLine;
 WEInit(Q.W,X1,Y1,X2,Y2);
 TDRefresh(Q);
End;

Function TDNew(Var Context;X1,Y1,X2,Y2:Byte):Boolean;
Var
 Q:TechDrawApp Absolute Context;
Begin
 TDNew:=_TDNew(Q,X1,Y1,X2,Y2,0);
End;

Function TDNewDFD(Var Context;X1,Y1,X2,Y2:Byte):Boolean;
Var
 Q:TechDrawApp Absolute Context;
Begin
 TDNewDFD:=_TDNew(Q,X1,Y1,X2,Y2,tdDFD);
End;

Function TDNewElectronic(Var Context;X1,Y1,X2,Y2:Byte):Boolean;
Var
 Q:TechDrawApp Absolute Context;
Begin
 TDNewElectronic:=_TDNew(Q,X1,Y1,X2,Y2,tdElectronic);
End;

Procedure TDLoad3DStudio(Var Q:TechDrawApp;Var Header:ImiHeader);
Type
 DataRec=Record
  Face:Array[0..ArrayMaxFaces]of tFaceRec;
  Coords:Array[0..ArrayMaxCoords]of tCoordRec;
 End;
Var
 Data:^DataRec;
 NumFace,NumCoords,I:Word;
 IncludeObject:IncludeObjectType;
Begin
 Data:=MemAlloc(SizeOf(DataRec));
 IncludeObject[1]:='*';
 IncludeObject[2]:='';
 If(Data<>NIL)Then Load3DSobject(Q.FileName,0.5,IncludeObject,
                                 Data^.Face,Data^.Coords,NumFace,NumCoords)
              Else NumFace:=0;
 TDRefresh(Q);
 If(NumFace=0)or(NumCoords=0)Then Exit;
 For I:=1to NumCoords-1do
  TDInsLine(Q,100+Trunc(Data^.Coords[I-1].X),
              100+Trunc(Data^.Coords[I-1].Y),
              100+Trunc(Data^.Coords[I].X),
              100+Trunc(Data^.Coords[I].Y),
              100+Trunc(Data^.Coords[I-1].Z),
              100+Trunc(Data^.Coords[I].Z),False);
{ For I:=1to NumCoords-1do Begin
  TDInsLine(Q,100+Trunc(Data^.Coords[Data^.Face[I].L1].X),
              100+Trunc(Data^.Coords[Data^.Face[I].L1].Y),
              100+Trunc(Data^.Coords[Data^.Face[I].L2].X),
              100+Trunc(Data^.Coords[Data^.Face[I].L2].Y),
              100+Trunc(Data^.Coords[Data^.Face[I].L1].Z),
              100+Trunc(Data^.Coords[Data^.Face[I].L2].Z),False);
  TDInsLine(Q,100+Trunc(Data^.Coords[Data^.Face[I].L2].X),
              100+Trunc(Data^.Coords[Data^.Face[I].L2].Y),
              100+Trunc(Data^.Coords[Data^.Face[I].L3].X),
              100+Trunc(Data^.Coords[Data^.Face[I].L3].Y),
              100+Trunc(Data^.Coords[Data^.Face[I].L2].Z),
              100+Trunc(Data^.Coords[Data^.Face[I].L3].Z),False);
  TDInsLine(Q,100+Trunc(Data^.Coords[Data^.Face[I].L3].X),
              100+Trunc(Data^.Coords[Data^.Face[I].L3].Y),
              100+Trunc(Data^.Coords[Data^.Face[I].L1].X),
              100+Trunc(Data^.Coords[Data^.Face[I].L1].Y),
              100+Trunc(Data^.Coords[Data^.Face[I].L3].Z),
              100+Trunc(Data^.Coords[Data^.Face[I].L1].Z),False);
 End;}
 FreeMemory(Data,SizeOf(Data));
End;

Procedure TDLoadImi(Var Q:TechDrawApp;Var Header:ImiHeader);
Var
 P:LongInt;
 I:Integer;
 Size:Word;
 Buffer:TechDrawDFDProcessusRec;
 Handle:Hdl;
Begin
 P:=SizeOf(ImiHeader);
 Handle:=FileOpen(Q.FileName,fmRead);
 If(Handle<>errHdl)Then Begin
  Q.FileInfo:=Header;
  Inc(Q.FileInfo.NumModified);
  Q.FileInfo.BackgroundColor:=Header.BackgroundColor;
  Q.FileInfo.Mode:=Header.Mode;
  For I:=0to Header.NumObject-1do Begin
   _GetAbsRec(Handle,P,SizeOf(Buffer),Buffer);
   Repeat
    Case(Buffer.ID)of
     imiDFDProcessus:Size:=SizeOf(TechDrawDFDProcessusRec);
     imiRealLine:Size:=SizeOf(TechDrawLineRec);
     Else Break;
    End;
    ALAddBlock(Q.Lst,Size,Buffer);
    Inc(P,Size);
   Until True;
  End;
  FileClose(Handle);
  TDRefresh(Q);
  ALSetPtr(Q.Lst,Q.Lst.Count-1);
 End;
End;

Procedure TDOpen(Var Context;X1,Y1,X2,Y2:Byte;Const Path:String);
Var
 Q:TechDrawApp Absolute Context;
 Header:ImiHeader;
Begin
 FillClr(Q,SizeOf(Q));
 Color2RGB(GetClassicToColor(CurrKrs.Dialog.Env.List.Border shr 4),
           Q.FileInfo.BackgroundColor);
 Q.TrueBackgroundColor:=RGBToColor(Q.FileInfo.BackgroundColor);
 Q.FileInfo.Mode:=drwLine;
 Q.FileName:=Path;
 WEInit(Q.W,X1,Y1,X2,Y2);
 GetFile(Path,0,SizeOf(Header),Header);
 If Header.Sign='IMI'Then TDLoadIMI(Q,Header)
                     Else TDLoad3DStudio(Q,Header);
End;

Procedure TDExport(Var Q:TechDrawApp);
Var
 Name:String;
Begin
 Name:=OpenWin('*.BMP','Exporter sous');
 If Name<>''Then Begin
  Q.IsImage:=True;
  FillClr(Q.ResImage,SizeOf(Q.ResImage));
  Q.ResImage.Original:=diBitMapWindows;
  Q.ResImage.BitsPerPixel:=16;
  Q.ResImage.NumXPixels:=1024;
  Q.ResImage.NumYPixels:=1024;
  Q.ResImage.BytesPerLine:=LocalBytesPerLine(Q.ResImage.NumXPixels,Q.ResImage.BitsPerPixel);
  If XAllocMem(rmAllRes,Mul2Word(Q.ResImage.BytesPerLine,Q.ResImage.NumYPixels),Q.Image)Then Begin
   TDRefreshImage(Q);
   XSetAbsRec(Q.Image,0,SizeOf(Q.ResImage),Q.ResImage);
   RISaveImage(Name,0,Q.Image);
   XFreeMem(Q.Image);
  End;
  Q.IsImage:=False;
 End;
End;

Function TDSave(Var Context):Boolean;
Var
 Q:TechDrawApp Absolute Context;
Begin
 TDSave:=TDSaveAs(Q,Q.FileName)
End;

Function TDSaveAs(Var Context;Const FileName:String):Boolean;
Var
 Q:TechDrawApp Absolute Context;
 Path:String;
 UpDate:Boolean;
 Handle:Hdl;
 Header:ImiHeader;     { Entˆte du fichier }
 P:LongInt;
 I:Integer;
 Size:Word;
 Data:^TechDrawDFDProcessusRec;
 Buffer:TechDrawDFDProcessusRec;
Begin
 TDSaveAs:=False;
 Path:=FileName;
 UpDate:=Q.FileName='';
 If Path=''Then Begin
  Path:=OpenWin(Path,'Sauvegarde sous');
  If Path=''Then Exit;
  Q.FileName:=Path;
 End;
 If Path<>''Then Begin
  Path:=StrUp(FileExpand(Path));
  If(Q.FileName<>Path)Then Begin{ Existe toujours ? }
   UpDate:=True;
   If FileExist(Path)Then Begin
    If Not __InputOverwriteFile(Path)Then Exit;
   End;
   Q.FileName:=Path
  End;
  Q.Modified:=False;
   {Sauvegarde les informations}
  Handle:=FileCreateAndBackup(Q.FileName);
  If(Handle<>errHdl)Then Begin
   Header:=Q.FileInfo;
   Header.Sign:='IMI';
   If Header.NumXPixels=0Then Header.NumXPixels:=1024;
   If Header.NumYPixels=0Then Header.NumYPixels:=1024;
   If Header.ScaleX=0.0Then Header.ScaleX:=100;
   If Header.ScaleY=0.0Then Header.ScaleY:=100;
   Header.CurrObject:=Q.CurrPosObject;
   Header.NumObject:=Q.Lst.Count;
   Inc(Q.FileInfo.NumModified);
   _SetAbsRec(Handle,0,SizeOf(Header),Header);
   P:=SizeOf(Header);
   ALSetPtr(Q.Lst,0);
   For I:=0to Q.Lst.Count-1do Begin
    Data:=_ALGetCurrBuf(Q.Lst);
    Case(Data^.ID)of
     imiDFDProcessus:Size:=SizeOf(TechDrawDFDProcessusRec);
     imiRealBox:Size:=SizeOf(TechDrawRectRec);
     imiRealLine:Size:=SizeOf(TechDrawLineRec);
    End;
    MoveLeft(Data^,Buffer,Size);
    _SetAbsRec(Handle,P,Size,Buffer);
    Inc(P,Size);
    ALNext(Q.Lst);
   End;
   FileClose(Handle);
  End;
   {Fin de la sauvegarde des informations}
  If(UpDate)or(Q.FileName<>Path)Then Begin
   Q.FileName:=Path;
   _WESetTitle(Q.W,Q.FileName);
  End;
  TDSaveAs:=True;
 End;
End;

Procedure TDConversScrnToRealCoord(Var Q:TechDrawApp;X1,Y1,X2,Y2:Integer;Var Data:Array of Real);Near;
Var
 CenterX,CenterY:Word;
Begin
 If Q.FileInfo.ScaleX=0.0Then Q.FileInfo.ScaleX:=100.0;
 If Q.FileInfo.ScaleY=0.0Then Q.FileInfo.ScaleY:=100.0;
 CenterX:=((Q.Screen.X2-Q.Screen.X1)shr 1)+Q.Screen.X1;
 CenterY:=((Q.Screen.Y2-Q.Screen.Y1)shr 1)+Q.Screen.Y1;
 Data[0]:=(X1-CenterX+Q.XScroll)/Q.FileInfo.ScaleX;
 Data[1]:=(Y1-CenterY+Q.YScroll)/Q.FileInfo.ScaleY;
 Data[2]:=(X2-CenterX+Q.XScroll)/Q.FileInfo.ScaleX;
 Data[3]:=(Y2-CenterY+Q.YScroll)/Q.FileInfo.ScaleY;
End;

Procedure TDConversZToRealCoord(Var Q:TechDrawApp;Z1,Z2:Integer;Var Data:Array of Real);Near;
Var
 CenterZ:Word;
Begin
 If Q.FileInfo.ScaleZ=0.0Then Q.FileInfo.ScaleZ:=100.0;
 CenterZ:=0;
 Data[0]:=(Z1-CenterZ)/Q.FileInfo.ScaleZ;
 Data[1]:=(Z2-CenterZ)/Q.FileInfo.ScaleZ;
End;

Procedure TDConversRealToScrnCoord(Var Q:TechDrawApp;X,Y:Real;Var XW,YW:Word);Near;
Var
 CenterX,CenterY:Word;
Begin
 If Q.FileInfo.ScaleX=0.0Then Q.FileInfo.ScaleX:=100.0;
 If Q.FileInfo.ScaleY=0.0Then Q.FileInfo.ScaleY:=100.0;
 CenterX:=((Q.Screen.X2-Q.Screen.X1)shr 1)+Q.Screen.X1;
 CenterY:=((Q.Screen.Y2-Q.Screen.Y1)shr 1)+Q.Screen.Y1;
 XW:=Trunc(X*Q.FileInfo.ScaleX+CenterX-Q.XScroll);
 YW:=Trunc(Y*Q.FileInfo.ScaleY+CenterY-Q.YScroll);
End;

Procedure TDConversRealToZCoord(Var Q:TechDrawApp;Z:Real;Var ZW:Word);Near;
Var
 CenterZ:Word;
Begin
 If Q.FileInfo.ScaleZ=0.0Then Q.FileInfo.ScaleZ:=100.0;
 CenterZ:=0;
 ZW:=Trunc(Z*Q.FileInfo.ScaleZ+CenterZ-Q.ZScroll);
End;

Procedure TDPutDFDFlux(Var Q:TechDrawApp;X1,Y1,X2,Y2:Integer;CurrColor:Word;D:DirectionType);Near;
Var
 Angle{,Rayon}:Real;
 Xx,Yy:LongInt;
 X:Array[0..9]of Integer;

 Function FindY(Angle:Real;XG,YG,X,Y:Integer):Integer;Begin
  FindY:=YG+Round(Y*Sin(Angle)+X*Cos(Angle));
 End;

 Function FindX(Angle:Real;XG,YG,X,Y:Integer):Integer;Begin
  FindX:=XG+Round(Y*Cos(Angle)-X*Sin(Angle))
 End;

Begin
 TDPutLine(Q,X1,Y1,X2,Y2,CurrColor);
 FillClr(X,SizeOf(X));
 Yy:=Y2-Y1+1;
 If Yy<>0Then Begin
  Xx:=X2-X1+1;
  {Rayon:=Sqrt(Sqr(Xx)+Sqr(Yy));}
  If xx=0.0Then Angle:=0.0
           Else Angle:=ArcTan(yy/xx);
  If xx<0.0Then Angle:=Angle+PI;
 End
  Else
 Angle:=0;
 If(dFirst)in(D)Then Begin
  X[0]:=FindX(Angle,X1,Y1,0,12);
  X[1]:=FindY(Angle,X1,Y1,0,12);
  X[2]:=FindX(Angle,X1,Y1,-6,0);
  X[3]:=FindY(Angle,X1,Y1,-6,0);
  X[4]:=FindX(Angle,X1,Y1,6,0);
  X[5]:=FindY(Angle,X1,Y1,6,0);
 End;
 If(dSecond)in(D)Then Begin
  X[0]:=FindX(Angle,X2,Y2,0,12);
  X[1]:=FindY(Angle,X2,Y2,0,12);
  X[2]:=FindX(Angle,X2,Y2,-6,0);
  X[3]:=FindY(Angle,X2,Y2,-6,0);
  X[4]:=FindX(Angle,X2,Y2,6,0);
  X[5]:=FindY(Angle,X2,Y2,6,0);
 End;
 X[6]:=X[0];
 X[7]:=X[1];
 TDFillPoly(Q,4,X,CurrColor);
End;

Procedure TDPutObjectPhysical(Var Q:TechDrawApp;Var Context;X1,Y1,X2,Y2:Integer);Near;
Var
 Data:^TDObject Absolute Context;
 Msg:String;
 CurrColor:Word;

 Procedure PutMsg(Const Msg:String);
 Var
  XL:Integer;
  XS,AX,LAX,I,J:Integer;
  Spacing:Integer;
  TS:String;
 Begin
  XL:=(X2-X1-(Length(Msg)shl 3));
  Inc(Y1,HeightChr+(HeightChr shr 2));
  If XL<0Then Begin
   XL:=X2-X1+1;
   XS:=((X2-X1)shr 3)+1;AX:=0;LAX:=$7FFF;
   While(Length(Msg)-AX>=XS)do Begin
    I:=AX+XS;
    While(Msg[I-1]>' ')and(Not(Msg[I-1]in['-','\','/']))and(I>AX)do Dec(I);
    TS:=Trim(Copy(Msg,AX+1,I-1-AX));
    Spacing:=(XL-(Length(TS)shl 3))shr 1;
    TDOutSmlTxtXY(Q,X1+Spacing,Y1,TS,
                 White shl 4);
    If(LAX=AX)Then Break;
    LAX:=AX;AX:=I-1;
    Inc(Y1,8);
   End;
   TS:=Trim(Copy(Msg,AX+1,255));
   Spacing:=(XL-(Length(TS)shl 3))shr 1;
   TDOutSmlTxtXY(Q,X1+Spacing,Y1,TS,
                 White shl 4);
  End
   Else
  Begin
   ASM
    SHR XL,1
   END;
   TDOutSmlTxtXY(Q,X1+XL,Y1,Msg,
                 White shl 4);
  End;
 End;

 Function FindY(Angle:Real;XG,YG,X,Y:Integer):Integer;Begin
  FindY:=YG+Round(Y*Sin(Angle)+X*Cos(Angle));
 End;

 Function FindX(Angle:Real;XG,YG,X,Y:Integer):Integer;Begin
  FindX:=XG+Round(Y*Cos(Angle)-X*Sin(Angle))
 End;

Begin
 CurrColor:=RGBToColor(Data^.DrawLine.Color);
 Case(Data^.DrawLine.ID)of
  imiRealLine:Begin
   TDPutLine(Q,X1,Y1,X2,Y2,CurrColor);
  End;
  imiRealBox:Begin
   If Not(Data^.DrawRect.Transparent)Then
    TDPutFillBox(Q,X1,Y1,X2,Y2,RGBToColor(Data^.DrawRect.Background));
   TDPutRect(Q,X1,Y1,X2,Y2,CurrColor);
  End;
  imiDFDFlux:Begin
   TDPutDFDFlux(Q,X1,Y1,X2,Y2,CurrColor,[dSecond]);
  End;
  imiDFDProcessus:Begin
   TDPutFillRoundRect(Q,X1,Y1,X2,Y2,7,White);
   TDPutRoundRect(Q,X1,Y1,X2,Y2,3,7,CurrColor);
   TDPutLineHor(Q,X1,Y1+HeightChr,X2,CurrColor);
   TDPutLineHor(Q,X1,Y2-HeightChr,X2,CurrColor);
   Msg:=WordToStr(Data^.DFDProcessus.NumID);
   TDOutSmlTxtXY(Q,X1+((X2-X1-(Length(Msg)shl 3))shr 1),
                 Y1+(HeightChr shr 2),Msg,
                 White shl 4);
   PutMsg(Data^.DFDProcessus.Name);
  End;
  imiDFDDepot:Begin
   TDPutLineHor(Q,X1,Y1,X2,CurrColor);
   TDPutLine(Q,X1,Y1,X2,Y1,CurrColor);
   TDPutLineHor(Q,X1,Y2,X2,CurrColor);
  End;
 End;
End;

Procedure TDPutObject(Var Q:TechDrawApp;Var Context);Near;
Var
 DataLine:^TechDrawLineRec Absolute Context;
 X1,Y1,X2,Y2:Word;
 Msg:String;
Begin
 TDConversRealToScrnCoord(Q,DataLine^.X1,DataLine^.Y1,X1,Y1);
 TDConversRealToScrnCoord(Q,DataLine^.X2,DataLine^.Y2,X2,Y2);
 TDPutObjectPhysical(Q,Context,X1,Y1,X2,Y2);
End;

Procedure TDPutBox(Var Q:TechDrawApp;X,Y:Integer;Select:Boolean);Near;
Var
 Color:Word;
Begin
 If(Select)Then Color:=Black
           Else Color:=Q.TrueBackgroundColor;
 TDPutRect(Q,X-4,Y-4,X+4,Y+4,Color);
End;

Function TDInBox(Var Q:TechDrawApp;XB,YB,X,Y:Integer):Boolean;Near;Begin
 TDInBox:=(X>=XB-4)and(X<XB+4)and(Y>=YB-4)and(Y<YB+4);
End;

Procedure TDPutBoxRect(Var Q:TechDrawApp;X1,Y1,X2,Y2:Word;Curr:Boolean);Begin
 TDPutBox(Q,X1,Y1,Curr);
 TDPutBox(Q,X2,Y2,Curr);
 TDPutBox(Q,X2,Y1,Curr);
 TDPutBox(Q,X1,Y2,Curr);
 TDPutBox(Q,X1+(X2-X1)shr 1,Y1,Curr);
 TDPutBox(Q,X1,Y1+(Y2-Y1)shr 1,Curr);
 TDPutBox(Q,X2,Y1+(Y2-Y1)shr 1,Curr);
 TDPutBox(Q,X1+(X2-X1)shr 1,Y2,Curr);
End;

Procedure TDUnActiveBox(Var Q:TechDrawApp);Near;
Var
 DataLine:^TechDrawLineRec;
 X1,Y1,X2,Y2:Word;
Begin
 DataLine:=_ALGetCurrBuf(Q.Lst);
 TDConversRealToScrnCoord(Q,DataLine^.X1,DataLine^.Y1,X1,Y1);
 TDPutBox(Q,X1,Y1,False);
 TDConversRealToScrnCoord(Q,DataLine^.X2,DataLine^.Y2,X2,Y2);
 TDPutBox(Q,X2,Y2,False);
 If IsBoxObject(DataLine^.ID)Then TDPutBoxRect(Q,X1,Y1,X2,Y2,False);
 TDPutObject(Q,DataLine);
End;

Function TDInActifBox(Var Q:TechDrawApp;X,Y:Integer):Boolean;Near;
Var
 DataLine:^TechDrawLineRec;
 X1,Y1,X2,Y2:Word;
Begin
 TDInActifBox:=True;
 DataLine:=_ALGetCurrBuf(Q.Lst);
 TDConversRealToScrnCoord(Q,DataLine^.X1,DataLine^.Y1,X1,Y1);
 Q.Encrage:=etUpLeft;
 If TDInBox(Q,X1,Y1,X,Y)Then Exit;
 TDConversRealToScrnCoord(Q,DataLine^.X2,DataLine^.Y2,X2,Y2);
 Q.Encrage:=etDownRight;
 If TDInBox(Q,X2,Y2,X,Y)Then Exit;
 If IsBoxObject(DataLine^.ID)Then Begin
  Q.Encrage:=etUpRight;
  If TDInBox(Q,X2,Y1,X,Y)Then Exit;
  Q.Encrage:=etDownLeft;
  If TDInBox(Q,X1,Y2,X,Y)Then Exit;
  Q.Encrage:=etUp;
  If TDInBox(Q,X1+(X2-X1)shr 1,Y1,X,Y)Then Exit;
  Q.Encrage:=etLeft;
  If TDInBox(Q,X1,Y1+(Y2-Y1)shr 1,X,Y)Then Exit;
  Q.Encrage:=etRight;
  If TDInBox(Q,X2,Y1+(Y2-Y1)shr 1,X,Y)Then Exit;
  Q.Encrage:=etDown;
  If TDInBox(Q,X1+(X2-X1)shr 1,Y2,X,Y)Then Exit;
 End;
 TDInActifBox:=False;
End;

Function TDFindObject(Var Q:TechDrawApp;X,Y:Integer):Boolean;Near;
Var
 Curr:Pointer;
 K:Word;
 GR:GraphBoxRec; { Position r‚el afficher }
 GS:GraphBoxRec; { Position de surface de recherche }
 Intervalle:Integer;
 D,DX,DY,I,J,Ainc,Binc,Ic:Integer;

 Function FindObject(XC,YC:Word):Boolean;Begin
  FindObject:=(X>=XC-Intervalle)and(X<=XC+Intervalle)and
              (Y>=YC-Intervalle)and(Y<=YC+Intervalle);
 End;

Begin
 TDFindObject:=True;
 If Q.Lst.Count>0Then Begin
  Intervalle:=5; { 5 Pixels }
  Curr:=ALPushCurrPtr(Q.Lst);
  ALSetPtr(Q.Lst,0);
  For K:=0to Q.Lst.Count-1do Begin
   Q.CurrObject:=_ALGetCurrBuf(Q.Lst);
   Q.CurrPosObject:=K;
   TDConversRealToScrnCoord(Q,Q.CurrObject^.DrawLine.X1,Q.CurrObject^.DrawLine.Y1,GS.X1,GS.Y1);
   TDConversRealToScrnCoord(Q,Q.CurrObject^.DrawLine.X2,Q.CurrObject^.DrawLine.Y2,GS.X2,GS.Y2);
   GR:=GS;
   If(GS.X1<=GS.X2)Then Begin
    Dec(GS.X1,Intervalle);
    Inc(GS.X2,Intervalle);
   End
    Else
   Begin
    Inc(GS.X1,Intervalle);
    Dec(GS.X2,Intervalle);
   End;
   If(GS.Y1<=GS.Y2)Then Begin
    Dec(GS.Y1,Intervalle);
    Inc(GS.Y2,Intervalle);
   End
    Else
   Begin
    Inc(GS.Y1,Intervalle);
    Dec(GS.Y2,Intervalle);
   End;
   Case(Q.CurrObject^.DrawLine.ID)of
    imiDFDProcessus,imiRealBox:Begin
     If(X>=GS.X1)and(X<=GS.X2)and(Y>=GS.Y1)and(Y<=GS.Y2)Then Begin
      TDPutBoxRect(Q,GR.X1,GR.Y1,GR.X2,GR.Y2,True);
      Exit;
     End;
    End;
    imiRealLine,imiDFDFlux:Begin
     {If(X>=GS.X1)and(X<=GS.X2)and(Y>=GS.Y1)and(Y<=GS.Y2)Then} Begin
       { Algorithme de B‚zier adapter au circonstance... }
      {If(GS.Y2=GS.Y1)or(GS.X2=GS.X1)Then Begin
       TDPutBox(Q,GR.X1,GR.Y1,True);
       TDPutBox(Q,GR.X2,GR.Y2,True);
       Exit;
      End;}
      If(GR.Y2=GR.Y1)or(GR.X2=GR.X1)Then Begin
       If(GS.X1>GS.X2)Then SwapWord(GS.X1,GS.X2);
       If(GS.Y1>GS.Y2)Then SwapWord(GS.Y1,GS.Y2);
       If(X>=GS.X1)and(X<=GS.X2)and(Y>=GS.Y1)and(Y<=GS.Y2)Then Begin
        TDPutBox(Q,GR.X1,GR.Y1,True);
        Exit;
       End;
      End;
      If Abs(GR.X2-GR.X1)<Abs(GR.Y2-GR.Y1)Then Begin
       If(GR.Y1>GR.Y2)Then Begin
        SwapWord(GR.X1,GR.X2);
        SwapWord(GR.Y1,GR.Y2);
       End;
       If(GR.X2>GR.X1)Then Ic:=1
                      Else Ic:=-1;
       DY:=Integer(GR.Y2)-Integer(GR.Y1);
       DX:=Abs(Integer(GR.X2)-Integer(GR.X1));
       D:=(DX shl 1)-DY;
       Ainc:=(DX-DY)shl 1;
       Binc:=DX shl 1;
       J:=GR.X1;
       If FindObject(GR.X1,GR.Y1)Then Begin
        TDPutBox(Q,GR.X1,GR.Y1,True);
        TDPutBox(Q,GR.X2,GR.Y2,True);
        Exit;
       End;
       I:=GR.Y1+1;
       While(I<=GR.Y2)do Begin
        If D>=0Then Begin
         Inc(J,Ic);
         Inc(D,Ainc)
        End
         Else
        Inc(D,Binc);
        {TDSetPixel(Q,J,I,Red);{}
        If FindObject(J,I)Then Begin
         TDPutBox(Q,GR.X1,GR.Y1,True);
         TDPutBox(Q,GR.X2,GR.Y2,True);
         Exit;
        End;
        Inc(I);
       End;
      End
       else
      Begin
       If(GR.X1>GR.X2)Then Begin
        SwapWord(GR.X1,GR.X2);
        SwapWord(GR.Y1,GR.Y2);
       End;
       If(GR.Y2>GR.Y1)Then Ic:=1
                      Else Ic:=-1;
       DX:=Integer(GR.X2)-Integer(GR.X1);
       DY:=Abs(Integer(GR.Y2)-Integer(GR.Y1));
       D:=(DY shl 1)-DX;
       AInc:=(DY-DX)shl 1;
       BInc:=DY shl 1;
       J:=GR.Y1;
       If FindObject(GR.X1,GR.Y1)Then Begin
        TDPutBox(Q,GR.X1,GR.Y1,True);
        TDPutBox(Q,GR.X2,GR.Y2,True);
        Exit;
       End;
       I:=GR.X1+1;
       While(I<=GR.X2)do Begin
        If D>=0Then Begin
         Inc(J,Ic);
         Inc(D,Ainc)
        End
         Else
        Inc(D,Binc);
        {TDSetPixel(Q,I,J,LightRed);{}
        If FindObject(I,J)Then Begin
         TDPutBox(Q,GR.X1,GR.Y1,True);
         TDPutBox(Q,GR.X2,GR.Y2,True);
         Exit;
        End;
        Inc(I);
       End;
      End;
     End;
    End;
   End;
   ALNext(Q.Lst);
  End;
  ALPopCurrPtr(Q.Lst,Curr);
 End;
 TDFindObject:=False;
End;

Procedure TDRefreshImage(Var Q:TechDrawApp);
Var
 Curr,Obj:Pointer;
 I,J:Word;
 Len,Height:Byte;
 XG,YG:Word;
Begin
 Q.TrueBackgroundColor:=RGB2Color(Q.FileInfo.BackgroundColor.R,
                                  Q.FileInfo.BackgroundColor.G,
                                  Q.FileInfo.BackgroundColor.B);
 If(Q.IsImage)Then Begin
  TDPutFillBox(Q,0,0,Q.ResImage.NumXPixels-1,Q.ResImage.NumYPixels-1,
                        Q.TrueBackgroundColor);
 End
  Else
 PutFillBox(Q.Screen.X1,Q.Screen.Y1,Q.Screen.X2,Q.Screen.Y2,Q.TrueBackgroundColor);
 If(Q.FileInfo.Origin=tdElectronic)Then Begin
  Len:=(Q.Screen.X2-Q.Screen.X1)shr 3;
  Height:=(Q.Screen.Y2-Q.Screen.Y1)div HeightChr;
  YG:=HeightChr shr 1;
  For J:=0to(Height)do Begin
   XG:=4;
   For I:=0to(Len)do Begin
    TDSetPixel(Q,XG,YG,LightGreen);
    Inc(XG,8);
   End;
   Inc(YG,HeightChr);
  End;
 End;
 If Q.Lst.Count>0Then Begin
  Curr:=ALPushCurrPtr(Q.Lst);
  ALSetPtr(Q.Lst,0);
  For I:=0to Q.Lst.Count-1do Begin
   Obj:=_ALGetCurrBuf(Q.Lst);
   TDPutObject(Q,Obj);
   ALNext(Q.Lst);
  End;
  ALPopCurrPtr(Q.Lst,Curr);
 End;
End;

Procedure TDComputeGraphCoord(Var Q:TechDrawApp);Begin
 CoordTxt2Graph(Q.W.T.X1,Q.Screen.X1);
 If(Q.W.NotFullScrnX)Then Inc(Q.Screen.X1,8);
 Inc(Q.Screen.Y1,HeightChr);
 Dec(Q.Screen.X2,16);
 Dec(Q.Screen.Y2,HeightChr);
 Case(Q.FileInfo.Origin)of
  tdElectronic,tdDFD:Dec(Q.Screen.Y2,HeightChr*5);
 End;
End;

Procedure TDRefresh(Var Context);
Var
 Q:TechDrawApp Absolute Context;
Begin
 Q.W.NotFullScrnX:=True;
 WEPutWnKrDials(Q.W,TDTitle(Q,Q.W.MaxX));
 WECloseIcon(Q.W);
 WEZoomIcon(Q.W);
 WEPutBarMsRight(Q.W);
 TDComputeGraphCoord(Q);
 WESetEndBar(Q.W,CurrKrs.Desktop.DialStatus);
 If(IsGrf)Then Begin
  BarSpcHorRelief(Q.W.T.X1,Q.W.T.Y2,Q.W.T.X1+45,CurrKrs.Desktop.DialStatus);
  BarSpcHorReliefExt(Q.W.T.X1+1,Q.W.T.Y2,Q.W.T.X1+44,CurrKrs.Desktop.DialStatus);
  BarSpcHorRelief(Q.W.T.X1+46,Q.W.T.Y2,Q.W.T.X1+52,CurrKrs.Desktop.DialStatus);
  BarSpcHorReliefExt(Q.W.T.X1+47,Q.W.T.Y2,Q.W.T.X1+51,CurrKrs.Desktop.DialStatus);
  BarSpcHorRelief(Q.W.T.X1+53,Q.W.T.Y2,Q.W.T.X2,CurrKrs.Desktop.DialStatus);
  BarSpcHorReliefExt(Q.W.T.X1+54,Q.W.T.Y2,Q.W.T.X2-2,CurrKrs.Desktop.DialStatus);
  LuxeBox(Q.W.T.X2-1,Q.W.T.Y2);
 End
  Else
 WESetEndBarTxtX(Q.W,36,'³',CurrKrs.Desktop.DialStatus);
 If(Q.Mode=tdmAnim)Then TDPutIconAnim(Q);
 Case(Q.FileInfo.Origin)of
  tdDFD:TDPutIconDFD(Q);
  tdElectronic:TDPutIconElec(Q);
 End;
 TDRefreshImage(Q);
End;

Function TDTitle(Var Context;Max:Byte):String;
Var
 Q:TechDrawApp Absolute Context;
 S:String;
Begin
 Case(Q.FileInfo.Origin)of
  tdElectronic:S:='Dessin Electronique';
  tdDFD:If Max<28Then S:='DFD'
                 Else S:='Diagramme de flux de donn‚es';
  Else S:='Dessin Vectorielle';
 End;
 If Q.FileName<>''Then Begin
  AddStr(S,' - '+Q.FileName);
 End;
 TDTitle:=S;
End;

Procedure TDInsLine(Var Q:TechDrawApp;X1,Y1,X2,Y2,Z1,Z2:Word;Curr:Boolean);
Var
 Data:TechDrawLineRec;
Begin
 FillClr(Data,SizeOf(Data));
 Data.ID:=imiRealLine;
 TDConversScrnToRealCoord(Q,X1,Y1,X2,Y2,Data.X1);
 If Z1 or Z2<>0Then TDConversZToRealCoord(Q,Z1,Z2,Data.Z1);
 TDConversScrnToRealCoord(Q,X1,Y1,X2,Y2,Data.X1);
 TDConversRealToScrnCoord(Q,Data.X1,Data.Y1,X1,Y1);
 TDConversRealToScrnCoord(Q,Data.X2,Data.Y2,X2,Y2);
 TDPutLine(Q,X1,Y1,X2,Y2,Q.CurrColor);
 If(Curr)Then Begin
  TDPutBox(Q,X1,Y1,True);
  TDPutBox(Q,X2,Y2,True);
 End;
 ALAddBlock(Q.Lst,SizeOf(Data),Data);
 ALSetPtr(Q.Lst,Q.Lst.Count-1);
End;

Procedure TDInsBox(Var Q:TechDrawApp;X1,Y1,X2,Y2:Word;Curr:Boolean);
Var
 Data:TechDrawRectRec;
 PData:Pointer;
Begin
 FillClr(Data,SizeOf(Data));
 Data.ID:=imiRealBox;
 Data.Transparent:=True;
 If(X1>X2)Then SwapWord(X1,X2);
 If(Y1>Y2)Then SwapWord(Y1,Y2);
 If X2-X1<40Then X2:=X1+40;
 If Y2-Y1<48Then Y2:=Y1+48;
 TDConversScrnToRealCoord(Q,X1,Y1,X2,Y2,Data.X1);
 TDConversRealToScrnCoord(Q,Data.X1,Data.Y1,X1,Y1);
 TDConversRealToScrnCoord(Q,Data.X2,Data.Y2,X2,Y2);
 PData:=@Data;
 TDPutObjectPhysical(Q,PData,X1,Y1,X2,Y2);
 If(Curr)Then TDPutBoxRect(Q,X1,Y1,X2,Y2,True);
 ALAddBlock(Q.Lst,SizeOf(Data),Data);
 ALSetPtr(Q.Lst,Q.Lst.Count-1);
End;

Procedure TDInsDFDProcessus(Var Q:TechDrawApp;X1,Y1,X2,Y2:Word;Curr:Boolean);
Var
 Data:TechDrawDFDProcessusRec;
 PData:Pointer;
 Msg:String;
Begin
 FillClr(Data,SizeOf(Data));
 Data.ID:=imiDFDProcessus;
 Inc(Q.ProcessusID);
 Data.NumID:=Q.ProcessusID;
 If(X1>X2)Then SwapWord(X1,X2);
 If(Y1>Y2)Then SwapWord(Y1,Y2);
 If X2-X1<40Then X2:=X1+40;
 If Y2-Y1<48Then Y2:=Y1+48;
 TDConversScrnToRealCoord(Q,X1,Y1,X2,Y2,Data.X1);
 TDConversRealToScrnCoord(Q,Data.X1,Data.Y1,X1,Y1);
 TDConversRealToScrnCoord(Q,Data.X2,Data.Y2,X2,Y2);
 PData:=@Data;
 TDPutObjectPhysical(Q,PData,X1,Y1,X2,Y2);
 If(Curr)Then TDPutBoxRect(Q,X1,Y1,X2,Y2,True);
 ALAddBlock(Q.Lst,SizeOf(Data),Data);
 ALSetPtr(Q.Lst,Q.Lst.Count-1);
End;

Procedure TDInsFlux(Var Q:TechDrawApp;X1,Y1,X2,Y2:Word;Curr:Boolean);
Var
 Data:TechDrawDFDFluxRec;
 PData:Pointer;
 Msg:String;
Begin
 FillClr(Data,SizeOf(Data));
 Data.ID:=imiDFDFlux;
 Data.Direction:=[dSecond];
 Inc(Q.FluxID);
 TDConversScrnToRealCoord(Q,X1,Y1,X2,Y2,Data.X1);
 TDConversScrnToRealCoord(Q,X1,Y1,X2,Y2,Data.X1);
 TDConversRealToScrnCoord(Q,Data.X1,Data.Y1,X1,Y1);
 TDConversRealToScrnCoord(Q,Data.X2,Data.Y2,X2,Y2);
 {TDPutLine(}TDPutDFDFlux(Q,X1,Y1,X2,Y2,Q.CurrColor,Data.Direction);
 If(Curr)Then Begin
  TDPutBox(Q,X1,Y1,True);
  TDPutBox(Q,X2,Y2,True);
 End;
 ALAddBlock(Q.Lst,SizeOf(Data),Data);
 ALSetPtr(Q.Lst,Q.Lst.Count-1);
End;

Procedure TDDFDProcessusPropriety(Var Q:TechDrawApp);Near;
Var
 FormDFDProcessusPropriety:Record
  NumID:Word;           { Num‚ro d'identification }
  IdAlpha:String;       { Identificateur alphanum‚rique }
  Name:String;          { Nom du processus de DFD }
  Alias:String;         { Alias du processus de DFD }
  NameCode:String;      { Nom cod‚ de processus de DFD }
  RegleSynch:String;    { RŠgle de synchronisation }
  EnsComposant:String;  { Ensemble de composant }
 End;
 DataProcessus:^TechDrawDFDProcessusRec;
Begin
 FillClr(FormDFDProcessusPropriety,SizeOf(FormDFDProcessusPropriety));
 DataProcessus:=_ALGetCurrBuf(Q.Lst);
 MoveLeft(DataProcessus^.NumID,FormDFDProcessusPropriety,
          SizeOf(Word)+SizeOf(String)*6);
 If ExecuteAppDPU(114,FormDFDProcessusPropriety)Then Begin
  MoveLeft(FormDFDProcessusPropriety,DataProcessus^.NumID,
           SizeOf(Word)+SizeOf(String)*6);
  TDPutObject(Q,DataProcessus);
 End;
End;

Procedure SwapReal(Var A,B:Real);Near;
Var
 C:Real;
Begin
 C:=A;A:=B;B:=C;
End;

Procedure TDRealBoxPropriety(Var Q:TechDrawApp);Near;
Var
 Form:Record
  X1,Y1,X2,Y2:Real;
 End;
 DataBox:^TechDrawRectRec;
Begin
 DataBox:=_ALGetCurrBuf(Q.Lst);
 FillClr(Form,SizeOf(Form));
 MoveLeft(DataBox^.X1,Form,SizeOf(Form));
 If ExecuteAppDPU(162,Form)Then Begin
  If(Form.X1>Form.X2)Then SwapReal(Form.X1,Form.X2);
  If(Form.Y1>Form.Y2)Then SwapReal(Form.Y1,Form.Y2);
  MoveLeft(Form,DataBox^.X1,SizeOf(Form));
  TDRefreshImage(Q);
 End;
End;

Procedure RelativeAngle(X1,Y1,X2,Y2:Real;Var Degrees,Minutes,Seconds:Word);
Const
 DegreesPerRadian=57.295779513; { Degr‚e par radian }
 MinutesPerDegree=60.0;           { Minute par degr‚e }
 SecondsPerDegree=3600.0;         { Secondes par degr‚e }
 SecondsPerMinute=60.0;           { Minute par seconde }
Var
 Result,RDegrees,RMinutes:Real;
 Theta:Real;
 XDelta,YDelta:Real;
Begin
 Degrees:=0;
 Minutes:=0;
 Seconds:=0;
 XDelta:=X2-X1;
 YDelta:=Y1-Y2;
 If(XDelta=0.0)and(YDelta=0.0)Then Exit;
 If YDelta=0Then Theta:=ArcTan(XDelta)
            Else Theta:=ArcTan(XDelta/YDelta);
 Result:=Theta*57.295779513;
 If(Y2>=Y1)Then Begin
  If(X2>=X1)Then Result:=90+(90-Result){Quadrant = 2}
            Else Result:=180+Result;   {Quadrant = 3}
 End
  Else
 If(X2<=X1)Then Result:=270+90-Result;{Quadrant = 4}
 RDegrees:=System.Int(Result);
 RMinutes:=(Result-RDegrees)*MinutesPerDegree;
 Degrees:=Trunc(RDegrees);
 Seconds:=Trunc(Frac(RMinutes)*SecondsPerMinute);
 Minutes:=Trunc(System.Int(RMinutes));
End;

Type
 FormRealLinePropriety=Record
  X1,Y1,X2,Y2:MInputReal;
  X,Y,Rayon:MInputReal;
  Angle,Minute,Second:MInputWord;
  Image:MExtern;
  GX1,GY1,GX2,GY2:Word;
 End;

Procedure FRLGraphPolaire(Var R:ResourceWindow;Var Context);
Var
 Q:FormRealLinePropriety Absolute Context;
 Rayon:Word;
 Angle:Real;
Begin
 If R.CurrPage<>1Then Exit;
 If Q.GY2<>0Then Begin
  WEPutLine(R.W,Q.GX1,Q.GY1,Q.GX2,Q.GY2,R.W.Palette.Border shr 4);
 End;
 Angle:=(PI/180)*(360-(Q.Angle.Value+(Q.Minute.Value/60)+(Q.Second.Value/360)));
 Rayon:=HeightChr shl 1;
 Q.GX1:=29*8;
 Q.GY1:=10*HeightChr;
 Q.GX2:=Q.GX1+Trunc(Cos(Angle)*Rayon);
 Q.GY2:=Q.GY1+Trunc(Sin(Angle)*Rayon);
 WEPutLine(R.W,Q.GX1,Q.GY1,Q.GX2,Q.GY2,Black);
 Circle(Q.GX1+(WEGetRX1(R.W)shl 3),GetRawY(WEGetRY1(R.W))+Q.GY1,Rayon,Black);
End;

Procedure ComputeAngle(Var Form:FormRealLinePropriety);Begin
 Form.Rayon.Value:=Sqrt(Sqr(Form.X2.Value-Form.X1.Value)+Sqr(Form.Y2.Value-Form.Y1.Value));
 RelativeAngle(Form.X1.Value,Form.Y1.Value,Form.X2.Value,Form.Y2.Value,Form.Angle.Value,Form.Minute.Value,Form.Second.Value);
End;

Function ComputeSommet(Var R:ResourceWindow;Var Context):Boolean;
Var
 Q:FormRealLinePropriety Absolute Context;
 Angle:Real;
Begin
 Angle:=(PI/180)*(360-(Q.Angle.Value+(Q.Minute.Value/60)+(Q.Second.Value/360)));
 Q.X2.Value:=Q.X1.Value+(Cos(Angle)*Q.Rayon.Value);
 Q.Y2.Value:=Q.Y1.Value+(Sin(Angle)*Q.Rayon.Value);
 FRLGraphPolaire(R,Context);
 ComputeSommet:=True;
End;

Function FRLOnChangeX1(Var R:ResourceWindow;Var Context):Boolean;
Var
 Q:FormRealLinePropriety Absolute Context;
Begin
 Q.X.Value:=Q.X1.Value;
 ComputeAngle(Q);
 FRLOnChangeX1:=True;
End;

Function FRLOnChangeY1(Var R:ResourceWindow;Var Context):Boolean;
Var
 Q:FormRealLinePropriety Absolute Context;
Begin
 Q.Y.Value:=Q.Y1.Value;
 ComputeAngle(Q);
 FRLOnChangeY1:=True;
End;

Function FRLOnChangeX(Var R:ResourceWindow;Var Context):Boolean;
Var
 Q:FormRealLinePropriety Absolute Context;
Begin
 Q.X1.Value:=Q.X.Value;
 ComputeSommet(R,Q);
 FRLOnChangeX:=True;
End;

Function FRLOnChangeY(Var R:ResourceWindow;Var Context):Boolean;
Var
 Q:FormRealLinePropriety Absolute Context;
Begin
 Q.Y1.Value:=Q.Y.Value;
 ComputeSommet(R,Q);
 FRLOnChangeY:=True;
End;

Function FRLOnChangeXY2(Var R:ResourceWindow;Var Context):Boolean;
Var
 Q:FormRealLinePropriety Absolute Context;
Begin
 ComputeAngle(Q);
 FRLOnChangeXY2:=True;
End;

Procedure TDRealLinePropriety(Var Q:TechDrawApp);Near;
Var
 Form:FormRealLinePropriety;
 DataBox:^TechDrawRectRec;
Begin
 DataBox:=_ALGetCurrBuf(Q.Lst);
 FillClr(Form,SizeOf(Form));
 Form.X1.Value:=DataBox^.X1;
 Form.X1.OnChange:=FRLOnChangeX1;
 Form.X1.Context:=@Form;
 Form.Y1.Value:=DataBox^.Y1;
 Form.Y1.OnChange:=FRLOnChangeY1;
 Form.Y1.Context:=@Form;
 Form.X2.Value:=DataBox^.X2;
 Form.X2.OnChange:=FRLOnChangeXY2;
 Form.X2.Context:=@Form;
 Form.Y2.Value:=DataBox^.Y2;
 Form.Y2.OnChange:=FRLOnChangeXY2;
 Form.Y2.Context:=@Form;
 Form.X.Value:=DataBox^.X1;
 Form.X.OnChange:=FRLOnChangeX;
 Form.X.Context:=@Form;
 Form.Y.Value:=DataBox^.Y1;
 Form.Y.OnChange:=FRLOnChangeY;
 Form.Y.Context:=@Form;
 Form.Angle.Context:=@Form;
 Form.Angle.OnChange:=ComputeSommet;
 Form.Minute.Context:=@Form;
 Form.Minute.OnChange:=ComputeSommet;
 Form.Second.Context:=@Form;
 Form.Second.OnChange:=ComputeSommet;
 Form.Image.Call:=FRLGraphPolaire;
 Form.Image.Context:=@Form;
 ComputeAngle(Form);
 If ExecuteAppDPU(165,Form)Then Begin
  DataBox^.X1:=Form.X1.Value;
  DataBox^.Y1:=Form.Y1.Value;
  DataBox^.X2:=Form.X2.Value;
  DataBox^.Y2:=Form.Y2.Value;
  TDRefreshImage(Q);
 End;
End;

Procedure TDClearPaletteDFD(Var Q:TechDrawApp);Near;Begin
 WEClrWnBorder(Q.W,0,Q.W.MaxY-4,wnMax,wnMax);
End;

Procedure TDUpdatePalette(Var Q:TechDrawApp);Near;Begin
 If(Q.FileInfo.Origin=tdDFD)Then Begin
  TDClearPaletteDFD(Q);
  TDPutIconDFD(Q);
 End;
End;

Procedure TDObjectPropriety(Var Q:TechDrawApp);
Var
 DataLine:^TechDrawLineRec;
Begin
 DataLine:=_ALGetCurrBuf(Q.Lst);
 Case(DataLine^.ID)of
  imiDFDProcessus:TDDFDProcessusPropriety(Q);
  imiRealBox:TDRealBoxPropriety(Q);
  imiRealLine:TDRealLinePropriety(Q);
 End;
End;

Procedure TDMenu(Var Q:TechDrawApp;OnObject:Boolean);
Var
 DataLine:^TechDrawLineRec;
Begin
 DataLine:=_ALGetCurrBuf(Q.Lst);
 Case _RunMenuApp(112,OnObject)of
  $F001:TDObjectPropriety(Q);{Begin
   Case(DataLine^.ID)of
    imiDFDProcessus:TDDFDProcessusPropriety(Q);
    imiRealBox:TDRealBoxPropriety(Q);
   End;
  End;}
  $F002:Begin
   ChoiceRGBColor(DataLine^.Color);
   TDRefresh(Q);
  End;
  $F003:Begin
   Q.FileInfo.Mode:=drwDFDProcessus;
   TDUpdatePalette(Q);
  End;
  $F004:Begin
   Q.FileInfo.Mode:=drwLine;
   TDUpdatePalette(Q);
  End;
  $F005:Begin
   ALDelBuf(Q.Lst,Q.CurrPosObject);
   TDRefresh(Q);
  End;
  $F006:TDProprieties(Q);
  $F007:Begin
   ChoiceRGBColor(Q.FileInfo.BackgroundColor);
   TDRefresh(Q);
  End;
  $F008:Begin
   Q.FileInfo.Mode:=drwBox;
   TDUpdatePalette(Q);
  End;
  $F009:Begin
   Q.FileInfo.Mode:=drwDFDFlux;
   TDUpdatePalette(Q);
  End;
  $F00A:TDExport(Q);
  $F00B:TDShowObjectList(Q);
 End;
 __ShowMousePtr;
End;

Procedure TDMoveObject(Var Q:TechDrawApp;X,Y:Integer);
Var
 Data:^TechDrawDFDProcessusRec;
 G:GraphBoxRec;
Begin
 Data:=_ALGetCurrBuf(Q.Lst);
 If(Data<>NIL)Then Begin
  TDConversRealToScrnCoord(Q,Data^.X1,Data^.Y1,G.X1,G.Y1);
  TDConversRealToScrnCoord(Q,Data^.X2,Data^.Y2,G.X2,G.Y2);
  Inc(G.X1,X);Inc(G.X2,X);
  Inc(G.Y1,Y);Inc(G.Y2,Y);
  TDConversScrnToRealCoord(Q,G.X1,G.Y1,G.X2,G.Y2,Data^.X1);
  TDRefresh(Q);
 End;
End;

Procedure TDReSizeObject(Var Q:TechDrawApp;Width,Height:Integer);
Var
 Data:^TechDrawDFDProcessusRec;
 G:GraphBoxRec;
Begin
 Data:=_ALGetCurrBuf(Q.Lst);
 If(Data<>NIL)Then Begin
  TDConversRealToScrnCoord(Q,Data^.X1,Data^.Y1,G.X1,G.Y1);
  TDConversRealToScrnCoord(Q,Data^.X2,Data^.Y2,G.X2,G.Y2);
  G.X2:=G.X1+Width;
  G.Y2:=G.Y1+Height;
  TDConversScrnToRealCoord(Q,G.X1,G.Y1,G.X2,G.Y2,Data^.X1);
  TDRefresh(Q);
 End;
End;

Procedure TDCoordObject(Var Q:TechDrawApp;Const Coord:GraphBoxRec);
Var
 Data:^TechDrawDFDProcessusRec;
Begin
 Data:=_ALGetCurrBuf(Q.Lst);
 If(Data<>NIL)Then Begin
  TDConversScrnToRealCoord(Q,Coord.X1,Coord.Y1,Coord.X2,Coord.Y2,Data^.X1);
  TDRefresh(Q);
 End;
End;

Procedure TDCurrPhysObjetPos(Var Q:TechDrawApp;Var G:GraphBoxRec);
Var
 Data:^TechDrawDFDProcessusRec;
Begin
 Data:=_ALGetCurrBuf(Q.Lst);
 If(Data<>NIL)Then Begin
  TDConversRealToScrnCoord(Q,Data^.X1,Data^.Y1,G.X1,G.Y1);
  TDConversRealToScrnCoord(Q,Data^.X2,Data^.Y2,G.X2,G.Y2);
 End;
End;

Procedure TDScrollDn(Var Q:TechDrawApp);Begin
 Inc(Q.YScroll,HeightChr);
 TDRefreshImage(Q);
End;

Procedure TDScrollUp(Var Q:TechDrawApp);Begin
 Dec(Q.YScroll,HeightChr);
 TDRefreshImage(Q);
End;

Procedure TDPutHelpBar(Var Q:TechDrawApp;Code:Word);Begin
 If DBLocateAbsIM(Q.Composant,0,Code,[])Then Begin
  Inc(PtrRec(Q.Composant.CurrRec.Ptr).Ofs,3);
  WEDone(Q.HelpBar);
  WEPushEndBar(Q.HelpBar);
  WEPutLastBar(Q.Composant.CurrRec.Str^);
 End;
End;

Function TDFindCompPos(Var Q:TechDrawApp;TX,TY:Byte):SmallInt;
Var
 I:Byte;
Begin
 TDFindCompPos:=-1;
 For I:=0to 255do Begin
  If(Q.CompPosX^[I]=TX)and(Q.CompPosY^[I]=TY)Then Begin
   TDFindCompPos:=I;
   Exit;
  End;
 End;
End;

Procedure TDOnMouseMove(Var Context;X,Y:Integer;TX,TY:Byte);
Var
 I:Byte;
 S:String;
 Q:TechDrawApp Absolute Context;
 Data:Array[0..3]of Real;
Begin
 If(Q.FileInfo.Origin=tdElectronic)Then Begin
  If(TY>=Q.W.MaxY-4)Then Begin
   If(Q.OldCompPosX=TX)and(Q.OldCompPosY=TY)Then Exit;
   For I:=0to 255do Begin
    If(Q.CompPosX^[I]=TX)and(Q.CompPosY^[I]=TY)Then Begin
     TDPutHelpBar(Q,I);
     Q.OldCompPosX:=TX;
     Q.OldCompPosY:=TY;
     Exit;
    End;
   End;
   Q.OldCompPosX:=0;
   Q.OldCompPosY:=0;
   WEDone(Q.HelpBar);
   Exit;
  End;
 End;
 TDConversScrnToRealCoord(Q,X,Y,X,Y,Data);
 S:='('+RealStr2(Data[0],0,4);
 If DeSep[0]=','Then IncStr(S,';')
                Else IncStr(S,',');
 AddStr(S,RealStr2(Data[1],0,4)+')');
 ChgChr(S,'.',DeSep[0]);
 Q.LenCoord:=Length(S);
 WESetEndBarTxtX(Q.W,1,StrUSpc(S,24),CurrKrs.Desktop.DialStatus);
End;

Procedure TDOnMouseControl(Var Context;Control:Word);
Var
 Q:TechDrawApp Absolute Context;
Begin
 Case(Control)of
  kbRBarMsUp:Begin
   TDScrollUp(Q);
   DelayMousePress(100);
  End;
  kbRBarMsDn:Begin
   TDScrollDn(Q);
   DelayMousePress(100);
  End;
 End;
End;

Procedure TDClearPalette1Electric(Var Q:TechDrawApp);Begin
 WEClrWnBorder(Q.W,0,Q.W.MaxY-4,wnMax-11,wnMax);
End;

Procedure TDClearPalette2Electric(Var Q:TechDrawApp);Begin
 WEClrWnBorder(Q.W,Q.W.MaxX-5,Q.W.MaxY-4,wnMax-2,wnMax);
End;

Procedure TDPutAngle(Var Q:TechDrawApp;X1,Y1,X2,Y2:Integer);
Var
 Angle:Real;
 X,Y:SmallInt;
 AngleDegree:LongInt;
Begin
 X:=-(X2-X1+1);
 If Y<>0Then Begin
  Y:=-(Y2-Y1+1);
  If Y=0Then Angle:=0.0
        Else Angle:=ArcTan(X/Y);
  If Y<0Then Angle:=Angle+PI;
 End
  Else
 Angle:=0.0;
 AngleDegree:=Trunc((PI/2+Angle)*DegreesPerRadian);
 WESetEndBarTxtX(Q.W,47,StrUSpc(IntToStr(AngleDegree)+'ø',5),CurrKrs.Desktop.DialStatus);
End;

Procedure TDPutToPoint(Var Q:TechDrawApp;X,Y:Integer);Near;
Var
 S:String;
 Data:Array[0..3]of Real;
Begin
 TDConversScrnToRealCoord(Q,X,Y,X,Y,Data);
 S:='-('+RealStr2(Data[0],0,4);
 If DeSep[0]=','Then IncStr(S,';')
                Else IncStr(S,',');
 AddStr(S,RealStr2(Data[1],0,4)+')');
 ChgChr(S,'.',DeSep[0]);
 WESetEndBarTxtX(Q.W,Q.LenCoord+1,StrUSpc(S,20),CurrKrs.Desktop.DialStatus);
End;

Procedure TDClearToPoint(Var Q:TechDrawApp);Near;Begin
 WESetEndBarTxtX(Q.W,Q.LenCoord+1,Spc(20),CurrKrs.Desktop.DialStatus);
End;

Procedure TDClearAngle(Var Q:TechDrawApp);Begin
 WESetEndBarTxtX(Q.W,47,Spc(5),CurrKrs.Desktop.DialStatus);
End;

Procedure TDOnMouseDown(Var Context;X,Y:Integer;TX,TY:Byte;Shift:Word);
Var
 Img:ImgRec;
 O:GraphBoxRec;
 X1,Y1,X2,Y2:Word;
 XO,YO:Word;
 BX,BY:Word;
 XL,YL,XL1,XL2,YL1,YL2:Word;
 T:GraphBoxRec;
 MX,MY,MB:Word;
 OldCurrObject:Word;
 K:Word;
 SelectComp:SmallInt;
 Q:TechDrawApp Absolute Context;

 Procedure PutObject;Begin
  TDSaveImage(Q,O.X1,O.Y1,O.X2,O.Y2,Img);
  If IsBoxObject(Q.CurrObject^.DrawLine.ID)Then Begin
   TDPutRect(Q,O.X1,O.Y1,O.X2,O.Y2,Q.CurrColor)
  End
   Else
  Begin
   TDPutLine(Q,O.X1,O.Y1,O.X2,O.Y2,Q.CurrColor);
  End;
  __ShowMousePtr;
  XO:=MX;
  YO:=MY;
 End;

Begin
 If(Q.FileInfo.Origin=tdElectronic)Then Begin
  If TY>=Q.W.MaxY-4Then Begin
   If TX<=Q.W.MaxX-13Then Begin
    {If(TY=Q.W.MaxY-3)Then Begin}
     SelectComp:=TDFindCompPos(Q,TX,TY);
     If SelectComp<>-1Then Begin
      Q.FileInfo.Mode:=drwMatrix;
      Q.CurrMatrix:=SelectComp;
      WaitMouseBut0;
     End;
     Exit;
    { Q.FileInfo.Mode:=drwMatrix;
     Q.CurrMatrix:=(TX shr 1);
     WaitMouseBut0;
     Exit;
    End;}
   End
    Else
   Begin
    K:=WEBackReadk(Q.PaletteBar1);
    Case(K)of
     kbRBarMsUp:Begin
      Q.PosPalette1:=0;
      TDClearPalette1Electric(Q);
      TDPutIconElec(Q);
      WaitMouseBut0;
      Exit;
     End;
     kbRBarMsDn:Begin
      If Q.LastPalette<255Then Begin
       Q.PosPalette1:=Q.LastPalette;
       TDClearPalette1Electric(Q);
       TDPutIconElec(Q);
      End;
      WaitMouseBut0;
      Exit;
     End;
    End;
    K:=WEBackReadk(Q.PaletteBar2);
    Case(K)of
     kbRBarMsUp:Begin
      If Q.PosPalette2>154Then Begin
       Dec(Q.PosPalette2);
       __HideMousePtr;
       TDClearPalette2Electric(Q);
       TDPutIconElec(Q);
       TDPutHelpBar(Q,Q.PosPalette2);
       __ShowMousePtr;
      End;
      WaitMouseBut0;
      Exit;
     End;
     kbRBarMsDn:Begin
      If Q.PosPalette2<164Then Begin
       Inc(Q.PosPalette2);
       __HideMousePtr;
       TDClearPalette2Electric(Q);
       TDPutIconElec(Q);
       TDPutHelpBar(Q,Q.PosPalette2);
       __ShowMousePtr;
      End;
      WaitMouseBut0;
      Exit;
     End;
    End;
   End;
  End;
 End;
 If(Q.Mode=tdmEdit)Then Begin
  If Shift=1Then Begin
   If Q.Lst.Count>0Then TDUnActiveBox(Q);
   OldCurrObject:=Q.CurrPosObject;
   If(Q.FileInfo.Mode=drwMatrix)Then Begin
    __HideMousePtr;
    TDPutElectronicCode(Q,X,Y,Q.CurrMatrix,(Green shl 4)+LightGreen);
    WaitMouseBut0;
    __ShowMousePtr;
   End
    Else
   Begin
    TDGetMouseSwitch(Q,XO,YO,MB);
    If TDFindObject(Q,XO,YO)Then Begin
     FillClr(Img,SizeOf(Img));
     TDCurrPhysObjetPos(Q,T);
     X2:=XO;
     Y2:=YO;
     O.X1:=$FFFF;
     O.Y1:=$FFFF;
     O.X2:=$FFFF;
     O.Y2:=$FFFF;
     XL:=T.X2-T.X1;
     YL:=T.Y2-T.Y1;
     XL1:=XO-T.X1;
     YL1:=YO-T.Y1;
     If(OldCurrObject=Q.CurrPosObject)and(TDInActifBox(Q,XO,YO))Then Begin
       { Changement de taille? }
      O:=T;
      Repeat
       TDGetMouseSwitch(Q,MX,MY,MB);
       If(XO<>MX)or(YO<>MY)Then Begin
        __HideMousePtr;
        TDRestoreImage(Q,O.X1,O.Y1,O.X2,O.Y2,Img);
        Case(Q.Encrage)of
         etLeft:O.X1:=MX;
         etUpLeft:Begin
          O.X1:=MX;
          O.Y1:=MY;
         End;
         etUp:O.Y1:=MY;
         etUpRight:Begin
          O.X2:=MX;
          O.Y1:=MY;
         End;
         etDownLeft:Begin
          O.X1:=MX;
          O.Y2:=MY;
         End;
         etDown:O.Y2:=MY;
         etDownRight:Begin
          O.X2:=MX;
          O.Y2:=MY;
         End;
         etRight:O.X2:=MX;
        End;
        If Not IsBoxObject(Q.CurrObject^.DrawLine.ID)Then Begin
         TDPutToPoint(Q,O.X2,O.Y2);
         TDPutAngle(Q,O.X1,O.Y1,O.X2,O.Y2);
        End;
        PutObject;
       End;
      Until MB=0;
      TDRestoreImage(Q,O.X1,O.Y1,O.X2,O.Y2,Img);
      TDClearAngle(Q);
      __HideMousePtr;
      TDCoordObject(Q,O);
     End
      Else
     Begin
      Repeat
       TDGetMouseSwitch(Q,MX,MY,MB);
       If(XO<>MX)or(YO<>MY)Then Begin
        __HideMousePtr;
        TDRestoreImage(Q,O.X1,O.Y1,O.X2,O.Y2,Img);
        T.X1:=MX-XL1;
        T.Y1:=MY-YL1;
        T.X2:=T.X1+XL;
        T.Y2:=T.Y1+YL;
        O:=T;
        PutObject;
       End;
      Until MB=0;
      TDRestoreImage(Q,O.X1,O.Y1,O.X2,O.Y2,Img);
      TDClearToPoint(Q);
      TDClearAngle(Q);
      If(MX=X2)and(MY=Y2)Then TDMenu(Q,True)
       Else
      Begin
       __HideMousePtr;
       TDMoveObject(Q,MX-X2,MY-Y2);
      End;
     End;
     TDGetMouseSwitch(Q,MX,MY,MB);
     TDFindObject(Q,MX,MY);
     __ShowMousePtr;
     Q.Modified:=True;
    End
     Else
    Begin
      { Cr‚ation d'un objet }
     FillClr(Img,SizeOf(Img));
     O.X1:=$FFFF;
     O.Y1:=$FFFF;
     O.X2:=$FFFF;
     O.Y2:=$FFFF;
     X1:=XO;
     Y1:=YO;
     Repeat
      TDGetMouseSwitch(Q,X2,Y2,MB);
      If(O.X1<>X1)or(O.Y1<>Y1)or(O.X2<>X2)or(O.Y2<>Y2)Then Begin
       __HideMousePtr;
       TDRestoreImage(Q,O.X1,O.Y1,O.X2,O.Y2,Img);
       TDSaveImage(Q,X1,Y1,X2,Y2,Img);
       T.X1:=X1;
       T.Y1:=Y1;
       T.X2:=X2;
       T.Y2:=Y2;
       Case(Q.FileInfo.Mode)of
 {       drwDFDFlux:TDPutDFDFlux(Q,T.X1,T.Y1,T.X2,T.Y2,Random(65520));}
        drwLine,drwDFDFlux:Begin
         TDPutAngle(Q,T.X1,T.Y1,T.X2,T.Y2);
         TDPutToPoint(Q,T.X2,T.Y2);
         TDPutLine(Q,T.X1,T.Y1,T.X2,T.Y2,Q.CurrColor);
        End;
        Else TDPutRect(Q,T.X1,T.Y1,T.X2,T.Y2,Q.CurrColor);
       End;
       __ShowMousePtr;
       O.X1:=X1;
       O.Y1:=Y1;
       O.X2:=X2;
       O.Y2:=Y2;
      End;
     Until MB=0;
     __HideMousePtr;
     TDRestoreImage(Q,O.X1,O.Y1,O.X2,O.Y2,Img);
     TDClearAngle(Q);
     TDClearToPoint(Q);
     Case(Q.FileInfo.Mode)of
      drwBox:TDInsBox(Q,XO,YO,O.X2,O.Y2,True);
      drwLine:TDInsLine(Q,XO,YO,O.X2,O.Y2,0,0,True);
      drwDFDFlux:TDInsFlux(Q,XO,YO,O.X2,O.Y2,True);
      Else TDInsDFDProcessus(Q,XO,YO,O.X2,O.Y2,True);
     End;
     __ShowMousePtr;
     Q.CurrPosObject:=Q.Lst.Count-1;
     Q.Modified:=True;
     PutMemory;
    End;
   End;
  End
   Else
  TDMenu(Q,False);
 End;
End;

Procedure TDBackOperation(Var Context);
Const
 Speed=1;
Var
 N:Integer; { Compteur de boucle }
 X1,Y1,Z1,X2,Y2,Z2,X3,Y3,Z3,X4,Y4,Z4:Word;
 Data:^TDObject;
 Q:TechDrawApp Absolute Context;

 { Cette proc‚dure compile une coordonn‚e tridimensionnel contenu
  dans (X,Y,Z) vers une coordonn‚e bi-dimension (X,Y). }

 Procedure ComputeXYZ(Var X,Y:Word;Z:Word);
 Var
  T:Integer;
  ZR,YR,XR:LongInt;
 Begin
  T:=Y;
  YR:=((T*LongInt(Q.Cos[Q.CurrFrame]))-(Q.SensX*Z*Long(Q.Sin[Q.CurrFrame])))div Delta;
  ZR:=((Q.SensX*T*LongInt(Q.Sin[Q.CurrFrame]))+(Z*Long(Q.Cos[Q.CurrFrame])))div Delta;
  T:=X;
  XR:=((T*LongInt(Q.Cos[Q.CurrFrame]))-(Q.SensY*ZR*LongInt(Q.Sin[Q.CurrFrame])))div Delta;
  ZR:=((Q.SensX*T*Long(Q.Sin[Q.CurrFrame]))+(ZR*LongInt(Q.Cos[Q.CurrFrame])))div Delta;
  T:=XR;
  XR:=((T*LongInt(Q.Cos[Q.CurrFrame]))-(Q.SensZ*YR*LongInt(Q.Sin[Q.CurrFrame])))div Delta;
  YR:=((Q.SensZ*T*Long(Q.Sin[Q.CurrFrame]))+(YR*LongInt(Q.Cos[Q.CurrFrame])))div Delta;
  X:=DivLong(PROFONDEUR*XR,Isatex.DISTANCE+ZR)+Q.XCenter;
  Y:=DivLong(PROFONDEUR*YR,Isatex.DISTANCE+ZR)+Q.YCenter;
 End;

Begin
 If(Q.Mode=tdmAnim)Then Begin
  PutFillBox(Q.Screen.X1,Q.Screen.Y1,Q.Screen.X2,Q.Screen.Y2,Q.TrueBackgroundColor);
  If(Q.CurrFrame<359-Speed)Then Inc(Q.CurrFrame,Speed)
                           Else Q.CurrFrame:=0;
  ALSetPtr(Q.Lst,0);
  For N:=0to Q.Lst.Count-1do Begin
   Data:=_ALGetCurrBuf(Q.Lst);
   If(Data<>NIL)Then Begin
    Case(Data^.DrawLine.ID)of
     imiRealLine:Begin
      TDConversRealToScrnCoord(Q,Data^.DrawLine.X1,Data^.DrawLine.Y1,X1,Y1);
      TDConversRealToZCoord(Q,Data^.DrawLine.Z1,Z1);
      ComputeXYZ(X1,Y1,Z1);
      TDConversRealToScrnCoord(Q,Data^.DrawLine.X2,Data^.DrawLine.Y2,X2,Y2);
      TDConversRealToZCoord(Q,Data^.DrawLine.Z2,Z2);
      ComputeXYZ(X2,Y2,Z2);
      TDPutLine(Q,X1,Y1,X2,Y2,RGBToColor(Data^.DrawLine.Color));
     End;
     imiRealBox,imiDFDProcessus:Begin
      TDConversRealToScrnCoord(Q,Data^.DrawLine.X1,Data^.DrawLine.Y1,X1,Y1);
      TDConversRealToZCoord(Q,Data^.DrawLine.Z1,Z1);
      ComputeXYZ(X1,Y1,Z1);
      TDConversRealToScrnCoord(Q,Data^.DrawLine.X2,Data^.DrawLine.Y1,X2,Y2);
      TDConversRealToZCoord(Q,Data^.DrawLine.Z2,Z2);
      ComputeXYZ(X2,Y2,Z2);
      TDPutLine(Q,X1,Y1,X2,Y2,RGBToColor(Data^.DrawLine.Color));
      TDConversRealToScrnCoord(Q,Data^.DrawLine.X1,Data^.DrawLine.Y2,X3,Y3);
      TDConversRealToZCoord(Q,Data^.DrawLine.Z1,Z3);
      ComputeXYZ(X3,Y3,Z3);
      TDConversRealToScrnCoord(Q,Data^.DrawLine.X2,Data^.DrawLine.Y2,X4,Y4);
      TDConversRealToZCoord(Q,Data^.DrawLine.Z2,Z4);
      ComputeXYZ(X4,Y4,Z4);
      TDPutLine(Q,X1,Y1,X3,Y3,RGBToColor(Data^.DrawLine.Color));
      TDPutLine(Q,X2,Y2,X4,Y4,RGBToColor(Data^.DrawLine.Color));
      TDPutLine(Q,X3,Y3,X4,Y4,RGBToColor(Data^.DrawLine.Color));
     End;
    End;
   End;
   ALNext(Q.Lst);
  End;
  WaitRetrace;
  _BackKbd;
 End;
End;

Procedure WEPutBox(Var Q:Window;X1,Y1,X2,Y2:Word);Begin
 WEPutLnHor(Q,X1,Y1,X2,White);
 WEPutLine(Q,X1,Y1,X1,Y2,White);
 WEPutLnHor(Q,X1,Y2,X2,Black);
 WEPutLine(Q,X2,Y1,X2,Y2,Black);
End;

Procedure TDPutIconElec(Var Q:TechDrawApp);
Label
 BreakAll;
Var
 I,J:Byte;
 K,X:Byte;
 GY1,GX2,GY2,GY:Word;
Begin
 If(Q.CompPosX<>NIL)Then Begin
  FillClr(Q.CompPosX^,Q.CompSize);
 End;
 If(Q.CompPosY<>NIL)Then Begin
  FillClr(Q.CompPosY^,Q.CompSize);
 End;
 X:=1;
 GY1:=GetRawY(Q.W.MaxY-4);
 GY2:=GetRawY(Q.W.MaxY+1)-1;
 GX2:=((Q.W.MaxX+1)shl 3)-1;
 WEPutBox(Q.W,0,GY1,GX2,GY2);
 WEPutBox(Q.W,2,GY1+4,4,GY2-4);
 WEPutBox(Q.W,GX2-(8 shl 3)+2,GY1+4,GX2-(8 shl 3)+4,GY2-4);
 GY:=GetRawY(Q.W.MaxY-3);
 K:=Q.PosPalette1;
 For J:=0to 1do Begin
  For I:=0to(Q.W.MaxX-15)shr 1do Begin
   While(K)in[0,26..40,45..52,54..55,69..123,152..153,154..164]do Begin
    Inc(K);
    If K>=255Then Goto BreakAll;
   End;
   If Not TDPutElecCode(Q,X+(I shl 1)+1,Q.W.MaxY-3+(J shl 1),K,CurrKrs.Desktop.DialStatus)Then Begin
    K:=255;
    Goto BreakAll;
   End;
   WEPutBox(Q.W,(X shl 3)+(I shl 4)+4,GY-7,(X shl 3)+(I shl 4)+19,GY+24);
   Inc(K);
   If K>=255Then Goto BreakAll;
  End;
  Inc(GY,32);
 End;
BreakAll:
 Q.LastPalette:=K;
 WESubWins(Q.W,Q.W.MaxX-9,Q.W.MaxY-5,Q.W.MaxX-8,Q.W.MaxY,Q.PaletteBar1);
 Inc(Q.PaletteBar1.T.Y2);
 WEPutBarMsRight(Q.PaletteBar1);
 WESubWins(Q.W,Q.W.MaxX-1,Q.W.MaxY-5,Q.W.MaxX,Q.W.MaxY,Q.PaletteBar2);
 WEPutBox(Q.W,((Q.W.MaxX-6)shl 3)+4,GY1+8,
          ((Q.W.MaxX-4)shl 3)+19,GY2-8);
 TDPutElecCode(Q,Q.W.MaxX-5,Q.W.MaxY-3,Q.PosPalette2,CurrKrs.Desktop.DialStatus);
 Inc(Q.PaletteBar2.T.Y2);
 WEPutBarMsRight(Q.PaletteBar2);
 WESelRightBarPos(Q.PaletteBar2,Q.PosPalette2-154,(164-154-1)shr 1);
End;

Procedure WEPutIconProcessus(Var Q:Window;X,Y:Byte);
Var
 T:TextBoxRec;
 G:GraphBoxRec;
 CurrColor:Word;
Begin
 CurrColor:=0;
 T.X1:=WEGetRX1(Q)+X;
 T.Y1:=WEGetRY1(Q)+Y;
 T.X2:=T.X1+3;
 T.Y2:=T.Y1+2;
 CoordTxt2Graph(T,G);
 PutFillRoundRect(G.X1,G.Y1,G.X2,G.Y2,7,White);
 PutRoundRect(G.X1,G.Y1,G.X2,G.Y2,3,7,CurrColor);
 PutLnHor(G.X1,G.Y1+8,G.X2,CurrColor);
 PutLnHor(G.X1,G.Y2-8,G.X2,CurrColor);
End;

Procedure WEPutIconEntite(Var Q:Window;X,Y:Byte);
Var
 T:TextBoxRec;
 G:GraphBoxRec;
 CurrColor:Word;
Begin
 CurrColor:=0;
 T.X1:=WEGetRX1(Q)+X;
 T.Y1:=WEGetRY1(Q)+Y;
 T.X2:=T.X1+3;
 T.Y2:=T.Y1+1;
 CoordTxt2Graph(T,G);
 Inc(G.Y2,8);
 PutFillBox(G.X1+4,G.Y1+4,G.X2+4,G.Y2+4,Black);
 PutFillBox(G.X1,G.Y1,G.X2,G.Y2,White);
 PutRect(G.X1,G.Y1,G.X2,G.Y2,Black);
End;

Procedure WEPutIconDepot(Var Q:Window;X,Y:Byte);
Var
 T:TextBoxRec;
 G:GraphBoxRec;
 CurrColor:Word;
Begin
 CurrColor:=0;
 T.X1:=WEGetRX1(Q)+X;
 T.Y1:=WEGetRY1(Q)+Y+1;
 T.X2:=T.X1+3;
 T.Y2:=T.Y1;
 CoordTxt2Graph(T,G);
 PutFillBox(G.X1,G.Y1,G.X2,G.Y2,White);
 PutLnHor(G.X1,G.Y1,G.X2,Black);
 PutLn(G.X1,G.Y1,G.X1,G.Y2,Black);
 PutLn(G.X1+8,G.Y1,G.X1+8,G.Y2,Black);
 PutLnHor(G.X1,G.Y2,G.X2,Black);
End;

Procedure TDPutIconDFD(Var Q:TechDrawApp);
Var
 I:Byte;
 GY1,GX2,GY2:Word;
Begin
 GY1:=GetRawY(Q.W.MaxY-4);
 GY2:=GetRawY(Q.W.MaxY+1)-1;
 GX2:=((Q.W.MaxX+1)shl 3)-1;
 WEPutBox(Q.W,0,GY1,GX2,GY2);
 WEPutBox(Q.W,2,GY1+4,4,GY2-4);
 If(Q.FileInfo.Mode=drwDFDProcessus)Then Begin
  WEPutFillBox(Q.W,8,GY1+8,55,GY2-8,CurrKrs.Menu.Select);
 End;
 For I:=0to 2do Begin
  WEPutBox(Q.W,(I*6+1)shl 3,GY1+8,(((I*6)+7)shl 3)-1,GY2-8);
 End;
  { Processus }
 WEPutIconProcessus(Q.W,2,Q.W.MaxY-3);
 WEPutIconEntite(Q.W,8,Q.W.MaxY-3);
 WEPutIconDepot(Q.W,14,Q.W.MaxY-3);
End;

Procedure TDPutIconAnim(Var Q:TechDrawApp);
Var
 Color:Byte;
 MaxY:Byte;
 Y2:Word;

 Procedure PutBox(X1,Y1,X2,Y2:Word);Begin
  WEPutLnHor(Q.W,X1,Y1,X2,White);
  WEPutLine(Q.W,X1,Y1,X1,Y2,White);
  WEPutLnHor(Q.W,X1,Y2,X2,Black);
  WEPutLine(Q.W,X2,Y1,X2,Y2,Black);
 End;

 Procedure PutBoxInverse(X1,Y1,X2,Y2:Word);Begin
  WEPutLnHor(Q.W,X1,Y1,X2,Black);
  WEPutLine(Q.W,X1,Y1,X1,Y2,Black);
  WEPutLnHor(Q.W,X1,Y2,X2,White);
  WEPutLine(Q.W,X2,Y1,X2,Y2,White);
 End;

 Procedure PutFleche(Y:Byte);
 Var
  YG:Word;
 Begin
  PutBox(8,Y*HeightChr,32,Pred(HeightChr*(Y+2)));
  YG:=(Y+1)*HeightChr;
  TDOutSmlTxtXY(Q,10,YG+(HeightChr shr 2),#17,Color);
  TDOutSmlTxtXY(Q,23,YG+(HeightChr shr 2),#16,Color);
  PutBox(9,YG,19,YG+HeightChr-2);
  PutBox(20,YG,31,YG+HeightChr-2);
  PutBoxInverse(8,(Y+2)*HeightChr,32,(Y+3)*HeightChr-1);
 End;

Begin
 TDComputeGraphCoord(Q);
 If BitsPerPixel=1Then Color:=$F0
                  Else Color:=CurrKrs.Desktop.DialStatus;
 Y2:=Q.Screen.Y2-Q.Screen.Y1;
 Case(Q.FileInfo.Origin)of
  tdElectronic,tdDFD:MaxY:=wnMax-5 ;
  Else MaxY:=wnMax;
 End;
 WEClrWn(Q.W,0,0,4,MaxY,Color);
 PutBox(0,0,39,Y2);
 WEPutSmlTxtXY(Q.W,2,3,IntToStr(Q.SensX));
 PutFleche(1);
 WEPutSmlTxtXY(Q.W,2,1,'X');
 PutFleche(5);
 WEPutSmlTxtXY(Q.W,2,7,IntToStr(Q.SensY));
 WEPutSmlTxtXY(Q.W,2,5,'Y');
 PutFleche(9);
 WEPutSmlTxtXY(Q.W,2,11,IntToStr(Q.SensZ));
 WEPutSmlTxtXY(Q.W,2,9,'Z');
 Inc(Q.Screen.X1,40);
End;

Procedure TDAnim(Var Q:TechDrawApp);
Var
 N:Integer; { Compteur de boucle }
Begin
 If(Q.Mode=tdmEdit)Then Begin
  Q.Mode:=tdmAnim;
  For N:=0to 359do Begin
   Q.Cos[N]:=Trunc(Cos(N*3.141592654/180)*Delta);
   Q.Sin[N]:=Trunc(Sin(N*3.141592654/180)*Delta);
  End;
  Q.CurrFrame:=0;
  Q.SensX:=1;
  Q.SensY:=1;
  Q.SensZ:=1;
  TDPutIconAnim(Q);
  Q.XCenter:=(Q.Screen.X2-Q.Screen.X1)shr 1;
  Q.YCenter:=(Q.Screen.Y2-Q.Screen.Y1)shr 1;
  _InitKbd;
 End
  Else
 Begin
  TDComputeGraphCoord(Q);
  Q.Mode:=tdmEdit;
  TDRefreshImage(Q);
 End;
End;

Procedure TDOnKeyDown(Var Context;Key:Word;Shift:ShiftState);
Var
 Q:TechDrawApp Absolute Context;
Begin
 Case(Key)of
  kbCtrlF9:TDAnim(Q);
 End;
End;

Function TDDone(Var Context):Word;
Var
 Q:TechDrawApp Absolute Context;
Begin
 WEDone(Q.HelpBar);
 FreeMemory(Q.CompPosX,Q.CompSize);
 FreeMemory(Q.CompPosY,Q.CompSize);
 DBDispose(Q.Composant);
 If(Q.Modified)Then Begin
  If(WarningMsgYesNo('Le dessin n''a pas ‚t‚ sauvegard‚! Dois-je le sauver ?')=kbYes)Then TDSave(Q);
  Q.Modified:=False
 End;
 ALDone(Q.Lst);
 TDDone:=0;
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
END.