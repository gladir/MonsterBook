{ Cette unitÇ est utilisÇe afin de permettre l'interprÇtation de langage
 de programmation BASIC et de ses dÇriver comme le langage ASP, Visual
 Basic.
}

Unit BASIC;

INTERFACE

Uses Systex,Isatex;

Function  BasicInit(Var Q:BasicStruct):Boolean;
Function  BasicRun(Var Q:BasicStruct;Var Source:ArrayList):Boolean;
Function  BasicErrExitCodeStr(Var Q:BasicStruct):String;
Procedure BasicDone(Var Q:BasicStruct);
Function  ASPInit(Var Q:BasicStruct;Const TargetName:String):Boolean;
Procedure ASPDone(Var Q:BasicStruct);

IMPLEMENTATION

Uses
 Adele,Memories,Systems,Video,ResTex,ResServD,Dialex,DialPlus,Math,
 Mouse,Numerix,pritex,Dials,Time;

Const
 brBreakPressed=1;
 brSyntaxError=2;
 brErrorInstr=3;
 ExitProgramNow=-666;
 StopProgram=-777;

 EndData=0;
 DataInteger=1;
 DataLong=2;
 DataSingle=3;
 DataDouble=4;
 DataString=5;
 DataPChar=6;
 DataTLong=7;
 DataReal=8;

 DataSize:Array[EndData..DataReal]of Word=(
  0,SizeOf(Integer),SizeOf(LongInt),SizeOf(Single),
  SizeOf(Double),SizeOf(String),0,SizeOf(Pointer)+SizeOf(Word),
  SizeOf(Real)
 );

 { ProcÇdure local }
Function  AddrTLong(Var Q:BasicStruct;Var N:String;Var Size:Word):Pointer;Near;Forward;
Procedure BasicCreateForm(Var Q:BasicStruct);Near;Forward;
Function  ExtractVarName(Var Q:BasicStruct;Var VarName:String):Char;Near;Forward;
Function  Num(Var Q:BasicStruct;Var N:Variant):Boolean;Forward;
Function  OfsVar(Var Q:BasicStruct;Const N:String):Word;Near;Forward;
Function  PushVarStr2PChr(Var Q:BasicStruct;Const X:String):PChar;Near;Forward;
Function  PushVarInt(Var Q:BasicStruct;X:Integer;Const N:String):Boolean;Near;Forward;
Function  PushVarLong(Var Q:BasicStruct;X:LongInt;Const N:String):Boolean;Near;Forward;
Function  PushVarReal(Var Q:BasicStruct;X:Real;Const N:String):Boolean;Near;Forward;
{Procedure PushVarSingle(Var Q:BasicStruct;X:Single;Const N:String);Near;Forward;}
Procedure PushVarString(Var Q:BasicStruct;Const X,N:String);Near;Forward;
Function  PushVarTLong(Var Q:BasicStruct;Const N:String;T:Word):Boolean;Near;Forward;
Procedure PXtrkWord(Var Q:BasicStruct;Var W:String);Near;Forward;
Function  ReadVarInt(Var Q:BasicStruct;Const N:String):Integer;Near;Forward;
Function  ReadVarLong(Var Q:BasicStruct;Const N:String):LongInt;Near;Forward;
Function  ReadVarReal(Var Q:BasicStruct;Const N:String):Real;Near;Forward;
Function  ReadVarString(Var Q:BasicStruct;Var N:String):String;Near;Forward;
Procedure SkipSpc(Var I:Word;PC:PChr);Near;Forward;
Function VarCode(Var Q:BasicStruct;Const N:String):Byte;Near;Forward;
Function  VarExist(Var Q:BasicStruct;Const N:String):Boolean;Near;Forward;
Function  _Str2S(Var Q:BasicStruct;Var S:String):Boolean;Forward;

{$I \Source\Chantal\Library\Intr.Inc}
{$I \Source\Chantal\Library\OctWord2Str.Inc}
{$I \Source\Chantal\Library\Joystick\Button.Inc}
{$I \Source\Chantal\Library\Joystick\JoyPos.Inc}

{ Cette fonction dÇmarre le moteur de magnÇtocassette et retourne 86h si
 le cassette est absente.
}

Function CassetteMotorOn:Byte;Near;Assembler;ASM
 XOR AX,AX
 INT 15h
 JC  @End
 XOR AX,AX
@End:
END;

{ Cette fonction arràte le moteur de magnÇtocassette et retourne 86h si
 le cassette est absente.
}

Function CassetteMotorOff:Byte;Near;Assembler;ASM
 MOV AH,01h
 INT 15h
 JC  @End
 XOR AX,AX
@End:
END;

Function NumberToHandle(Var Q:BasicStruct;X:Integer):Integer;Near;Begin
 NumberToHandle:=ReadVarInt(Q,'#'+IntToStr(X))
End;

Function VariantToString(Const Q:Variant):String;Begin
 Case(Q.TypeDef)of
  dtInt:VariantToString:=IntToStr(Q.X.DataInt);
  dtLong:VariantToString:=IntToStr(Q.X.DataLong);
  dtReal:VariantToString:=RealStr(Q.X.DataReal);
  {dtSingle:VariantToString:=RealStr(A.Single);
  dtDouble:VariantToString:=RealStr(A.Double);}
  Else VariantToString:='';
 End;
End;

Procedure SplitDate(Const Date:String;Var Year:Word;Var Month:Byte;Var Day:Byte);Near;
Var
 X1,X2,X3:Word;
 P1,P2:Byte;
Begin
 P1:=Pos(DtSep[0],Date);
 If P1>0Then Begin
  X1:=StrToWord(Left(Date,P1-1));
  P2:=Pos(DtSep[0],Copy(Date,P1+1,255));
  X2:=StrToWord(Copy(Date,P1+1,P2-1));
  X3:=StrToWord(Copy(Date,P1+P2+1,255));
  Case(Adele.Date)of
   mdy:Begin;Year:=X3;Month:=X1;Day:=X2;End;
   dmy:Begin;Year:=X3;Month:=X2;Day:=X1;End;
   ymd:Begin;Year:=X1;Month:=X2;Day:=X3;End;
   myd:Begin;Year:=X2;Month:=X1;Day:=X3;End;
   dym:Begin;Year:=X2;Month:=X3;Day:=X1;End;
   ydm:Begin;Year:=X1;Month:=X3;Day:=X2;End;
  End;
 End;
End;

          { ********************************** }
          { * Routine de base de d'affichage * }
          { ********************************** }

Function BasicGetPixel(Var Q:BasicStruct;X,Y:Word):Word;Near;Begin
 If(Q.CreateForm)Then Begin
  Inc(X,Q.Screen.X1);
  Inc(Y,Q.Screen.Y1);
 End;
 If(X>Q.Screen.X2)or(Y>Q.Screen.Y2)Then BasicGetPixel:=0
                                   Else BasicGetPixel:=GetPixel(X,Y);
End;

Function BasicGetMaxXPixels(Var Q:BasicStruct):Word;Near;Begin
 BasicGetMaxXPixels:=Q.Screen.X2-Q.Screen.X1;
End;

Function BasicGetNumXPixels(Var Q:BasicStruct):Word;Near;Begin
 BasicGetNumXPixels:=Q.Screen.X2-Q.Screen.X1+1;
End;

Function BasicGetMaxYPixels(Var Q:BasicStruct):Word;Near;Begin
 BasicGetMaxYPixels:=Q.Screen.Y2-Q.Screen.Y1;
End;

Function BasicGetNumYPixels(Var Q:BasicStruct):Word;Near;Begin
 BasicGetNumYPixels:=Q.Screen.Y2-Q.Screen.Y1;
End;

Procedure BasicSetPixel(Var Q:BasicStruct;X,Y:Integer;Color:Word);Near;Begin
 Inc(X,Q.Screen.X1);
 Inc(Y,Q.Screen.Y1);
 If(Y<Q.Screen.Y1)Then Exit;
 If(Y>Q.Screen.Y2)or(X<Q.Screen.X1)or(X>Q.Screen.X2)Then Exit;
 SetPixel(X,Y,Color);
End;

Procedure BasicPutLineHor(Var Q:BasicStruct;X1,Y,X2:Integer;Color:Word);Near;Begin
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

Procedure BasicPutLine(Var Q:BasicStruct;X1,Y1,X2,Y2:Integer;Color:Word);Near;
Var
 D,DX,DY,I,J,Ainc,Binc,Ic:Integer;
Begin
 If(Y2=Y1)Then Begin
  BasicPutLineHor(Q,X1,Y1,X2,Color);
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
  BasicSetPixel(Q,X1,Y1,Color);
  I:=Y1+1;
  While(I<=Y2)do Begin
   If D>=0Then Begin
    Inc(J,Ic);
    Inc(D,Ainc)
   End
    Else
   Inc(D,Binc);
   BasicSetPixel(Q,J,I,Color);
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
  BasicSetPixel(Q,X1,Y1,Color);
  I:=X1+1;
  While(I<=X2)do Begin
   If D>=0Then Begin
    Inc(J,Ic);
    Inc(D,Ainc)
   End
    Else
   Inc(D,Binc);
   BasicSetPixel(Q,I,J,Color);
   Inc(I);
  End;
 End;
End;

Procedure BasicPutRect(Var Q:BasicStruct;X1,Y1,X2,Y2:Integer;Color:Word);Near;
Var
 J:Integer;
Begin
 If(Y1>Y2)Then SwapInt(Y1,Y2);
 BasicPutLineHor(Q,X1,Y1,X2,Color);
 For J:=Y1+1to Y2-1do Begin
  BasicSetPixel(Q,X1,J,Color);
  BasicSetPixel(Q,X2,J,Color);
 End;
 BasicPutLineHor(Q,X1,Y2,X2,Color);
End;

Procedure BasicPutRoundRect(Var Q:BasicStruct;x1,y1,x2,y2,LineWidth,b:Integer;Color:Word);Near;
Var
 a,xr,yr,x,i,j,y,xN,yN:LongInt;
 AO,BO,AO2,BO2,AO4,BO4,d:LongInt;
Begin
 If LineWidth>0Then Dec(LineWidth);
 y:=y1;y1:=y2;y2:=y;yr:=b;xr:=b;xN:=x2-xr;yN:=y2+yr;
 For j:=-(LineWidth shr 1)to LineWidth shr 1+(LineWidth and 1)do Begin
  BasicPutLineHor(Q,x1+xr,y1-j,xN,Color);
  BasicPutLineHor(Q,x1+xr,y2-j,xN,Color);
 End;
 For j:=-(LineWidth shr 1)to LineWidth shr 1+(LineWidth and 1)do Begin
  For i:=y1-yr downto(yN)do Begin
   BasicSetPixel(Q,x1+j,i,Color);
   BasicSetPixel(Q,x2+j,i,Color)
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
   BasicSetPixel(Q,x+xN,yN-y,Color);
   BasicSetPixel(Q,x+xN,y1-yr+y,Color);
   BasicSetPixel(Q,x1+xr-x,yN-y,Color);
   BasicSetPixel(Q,x1+xr-x,y1-yr+y,Color);
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
   BasicSetPixel(Q,x+xN,yN-y,Color);
   BasicSetPixel(Q,x+xN,y1-yr+y,Color);
   BasicSetPixel(Q,x1+xr-x,yN-y,Color);
   BasicSetPixel(Q,x1+xr-x,y1-yr+y,Color);
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

Procedure BasicPutFillBox(Var Q:BasicStruct;X1,Y1,X2,Y2:Integer;Color:Word);Near;Begin
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

Procedure BasicPutFillRoundRect(Var Q:BasicStruct;x1,y1,x2,y2,b:Integer;Color:Word);
Var
 a,xr,yr,x,j,y,xN,yN:LongInt;
 AO,BO,AO2,BO2,AO4,BO4,d:LongInt;
Begin
 y:=y1;y1:=y2;y2:=y;yr:=b;xr:=b;xN:=x1+xr;yN:=y1-yr;
 If Not(y2+b>=yN)Then Begin
  BasicPutFillBox(Q,x1,y2+b,x2,yN,Color);
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
  BasicPutLineHor(Q,xN-y,yN+x,x2-yr+y,Color);
  BasicPutLineHor(Q,xN-y,y2+xr-x,x2-yr+y,Color);
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
  BasicPutLineHor(Q,xN-y,x+yN,x2-yr+y,Color);
  BasicPutLineHor(Q,xN-y,y2+xr-x,x2-yr+y,Color);
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

          { ********************************** }
          { * Instruction du langage Basic   * }
          { ********************************** }


Function BasicBoolean(X:Boolean):Integer;Near;Begin
 If(X)Then BasicBoolean:=-1
      Else BasicBoolean:=0;
End;

Function BasicScreenToAdele(X:Word):Word;Near;Begin
 BasicScreenToAdele:=$FFFF;
 Case(X)of
  0:If NmXTxts=40Then BasicScreenToAdele:=vmTxtC40
                 Else BasicScreenToAdele:=vmTxtC80;
  1:BasicScreenToAdele:=vmGrf320x200c4;
  2:BasicScreenToAdele:=vmGrf640x200c2;
  4:BasicScreenToAdele:=vmGrf640x400c2;
  7:BasicScreenToAdele:=vmGrf320x200c16;
  8:BasicScreenToAdele:=vmGrf640x200c16;
  9:BasicScreenToAdele:=vmTxtC80x43;
  10:BasicScreenToAdele:=vmGrf640x350c2;
  11:BasicScreenToAdele:=vmGrf640x350c2;
  12:BasicScreenToAdele:=vmGrf640x480c16;
  13:BasicScreenToAdele:=vmGrf320x200c256;
   {Non-standard}
  14:BasicScreenToAdele:=vmGrf320x400c256;
  15:BasicScreenToAdele:=vmGrf320x400c256;
  16:BasicScreenToAdele:=vmGrf360x480c256;
  17:BasicScreenToAdele:=vmTxtC80x28;
  18:BasicScreenToAdele:=vmTxtC80x50;
  19:BasicScreenToAdele:=vmTxtC80x60;
  20:BasicScreenToAdele:=vmTxtC100x40;
  21:BasicScreenToAdele:=vmTxtC132;
  22:BasicScreenToAdele:=vmGrf800x600c16;
  23:BasicScreenToAdele:=vmGrf640x350c256;
  24:BasicScreenToAdele:=vmGrf640x400c256;
 End;
End;

Procedure BasicCircle(Var Q:BasicStruct;X,Y,Rayon,Color:Word);Near;Begin
 If(Q.CreateForm)Then Begin
  Inc(X,Q.Screen.X1);
  Inc(Y,Q.Screen.Y1);
 End;
 Circle(X,Y,Rayon,Color);
End;

Procedure BasicCLS(Var Q:BasicStruct);Near;
Label Black;
Var
 A:Variant;
Begin
 BasicCreateForm(Q);
 If Not Num(Q,A)Then Goto Black Else
 If A.X.DataInt<=0Then Begin
Black:
  If(Q.InForm)Then WEClrWn(Q.W,0,0,wnMax,wnMax,7)
              Else ClrScrBlack;
 End
  Else
 Begin
  If(Q.InForm)Then WEClrWn(Q.W,0,0,wnMax,wnMax,A.X.DataInt shl 4)
              Else ClrScr(A.X.DataInt shl 4);
 End;
End;

Function BasicDim(Var Q:BasicStruct):Boolean;Near;
Label DefinedType;
Var
 A:Variant;
 VarName,S2:String;
Begin
 BasicDim:=False;
 A.TypeDef:=dtNoType;
 SkipSpc(Q.X,Q.PC);
 PXtrkWord(Q,VarName);
 If Q.PC^[Q.X]in['$','%','&','!','#']Then Begin
  IncStr(VarName,Q.PC^[Q.X]);
  Inc(Q.X);
 End;
 If VarExist(Q,VarName)Then Begin
  Q.ExitCode:=VarDupl;
  Exit;
 End;
 If Not(Q.PC^[Q.X]in['(','['])Then Begin
  If(Q.Mode)and(bmAsp or bmVisualBasic)>0Then Goto DefinedType;
  Q.ExitCode:=OpenParExpected;
  Exit;
 End;
 Inc(Q.X);
 If Not Num(Q,A)Then Exit;
 If Not(Q.PC^[Q.X]in[')',']'])Then Begin
  Q.ExitCode:=CloseParExpected;
  Exit;
 End;
 Inc(Q.X);
 If(Q.Mode)and(bmAsp or bmVisualBasic)>0Then Begin
DefinedType:
  SkipSpc(Q.X,Q.PC);
  PXtrkWord(Q,S2);
  If S2='AS'Then Begin
   SkipSpc(Q.X,Q.PC);
   PXtrkWord(Q,S2);
   If S2='BOOLEAN'Then PushVarInt(Q,0,VarName)Else
   If S2='BYTE'Then PushVarInt(Q,0,VarName)Else
   If S2='DOUBLE'Then PushVarReal(Q,0,VarName)Else
   If S2='INTEGER'Then PushVarInt(Q,0,VarName)Else
   If S2='WORD'Then PushVarInt(Q,0,VarName)Else
   If S2='LONG'Then PushVarLong(Q,0,VarName)Else
   If S2='SINGLE'Then PushVarReal(Q,0,VarName)Else
   If S2='STRING'Then PushVarString(Q,'',VarName)
    Else
   Begin
    { Type ÆVariantØ }
   End;
  End
   Else
  Case VarName[Length(VarName)]of
   '%':PushVarInt(Q,0,VarName);
   '&':PushVarLong(Q,0,VarName);
   '!','#':PushVarReal(Q,0,VarName);
   '$':PushVarString(Q,'',VarName);
  End;
  If(A.TypeDef=dtNoType)Then Begin
   BasicDim:=True;
   Exit;
  End;
 End;
 If Not PushVarTLong(Q,VarName,A.X.DataInt)Then Exit;
 BasicDim:=True;
End;

{⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ‹
 ≥                            ProcÇdure BasicDraw                          €
 ¿‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹€


 Description
 ÕÕÕÕÕÕÕÕÕÕÕ

  Cette procÇdure dessine une forme spÇcifiÇe par une chaåne de caractäre.


 Remarques
 ÕÕÕÕÕÕÕÕÕ

  ˛ Cette procÇdure existe essentiellement  Ö titre  de compatiblitÇ avec le
    langage Basic d'IBM (BASICA).  Pour cette raison,  il ne s'agit pas d'un
    virtuose de performance ni màme de taille.

  ˛ Cette procÇdure ne fonctionne correctement quand mode graphique car elle
    ne peut  que tracer des pixels  mais pas de caractäre sans constructions
    supplÇmentaires compliquÇes.

  ˛ ⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
    ≥ Commande    ≥ Description                                            ≥
    ∆ÕÕÕÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕµ
    ≥ B ...       ≥ Cette  commande   peut  prÇcÇder   toute  commande  de ≥
    ≥             ≥ dÇplacement. DÇplacement sans trace.                   ≥
    √ƒƒƒƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥
    ≥ C c         ≥ SÇlectionne  la  couleur  ÆcØ.  Utilise  la  procÇdure ≥
    ≥             ≥ _SetKr  de changement de couleur graphique des lignes, ≥
    ≥             ≥ Rectangle,...                                          ≥
    √ƒƒƒƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥
    ≥ D n         ≥ DÇplacement de ÆnØ points vers le bas.                 ≥
    √ƒƒƒƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥
    ≥ E n         ≥ DÇplacement de  ÆnØ points en diagonale vers le haut Ö ≥
    ≥             ≥ droite.                                                ≥
    √ƒƒƒƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥
    ≥ F n         ≥ DÇplacement de  ÆnØ  points en diagonale vers le bas Ö ≥
    ≥             ≥ droite.                                                ≥
    √ƒƒƒƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥
    ≥ G n         ≥ DÇplacement de  ÆnØ  points en diagonale vers le bas Ö ≥
    ≥             ≥ gauche.                                                ≥
    √ƒƒƒƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥
    ≥ H n         ≥ DÇplacement de  ÆnØ points en diagonale vers le haut Ö ≥
    ≥             ≥ gauche.                                                ≥
    √ƒƒƒƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥
    ≥ L n         ≥ DÇplacement de ÆnØ points vers la gauche.              ≥
    √ƒƒƒƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥
    ≥ M x,y       ≥ DÇplacement amenant au point de coordonnÇes (relatives ≥
    ≥             ≥ absolues)  ÆxØ et  ÆyØ.  Si ÆxØ est prÇcÇdÇ d'un signe ≥
    ≥             ≥ ÆplusØ (+) ou d'un signe ÆmoinsØ (-),  il s'agit d'une ≥
    ≥             ≥ coordonnÇe sous forme relative, sinon d'une coordonnÇe ≥
    ≥             ≥ absolue.                                               ≥
    √ƒƒƒƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥
    ≥ N ...       ≥ Cette  commande  peut  prÇcäder  toutes  commandes  de ≥
    ≥             ≥ dÇplacement. DÇplacement suivi du retour Ö la position ≥
    ≥             ≥ initiale.                                              ≥
    √ƒƒƒƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥
    ≥ R n         ≥ DÇplacement de ÆnØ points vers la droite.              ≥
    √ƒƒƒƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥
    ≥ U n         ≥ DÇplacement de ÆnØ points vers le haut.                ≥
    ¿ƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ


 Exemple
 ÕÕÕÕÕÕÕ

 Cette exemple affiche une petite åle  Ö l'aide  de la procÇdure  ÆDrawØ  et
 produit animation jusqu'Ö ce qu'une touche soit enfoncÇe au clavier.
 ⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
 ≥ Program Ile;                                                            ≥
 ≥                                                                         ≥
 ≥ Uses Adele,Video,Systex,Systems;                                        ≥
 ≥                                                                         ≥
 ≥ Procedure Wait;Begin                                                    ≥
 ≥  WaitRetrace;WaitRetrace;WaitRetrace;ClrScrBlack;_Move2(160,100)        ≥
 ≥ End;                                                                    ≥
 ≥                                                                         ≥
 ≥ BEGIN                                                                   ≥
 ≥  InitSystems(suIsabel);                                                 ≥
 ≥  SetVideoMode(vmGrf320x200c256);                                        ≥
 ≥  Wait;                                                                  ≥
 ≥  Repeat                                                                 ≥
 ≥   Draw('BL13E15F2NG13E5R4F18');Wait;                                    ≥
 ≥   Draw('BL18E18R4F16BH2E2F6');Wait;                                     ≥
 ≥   Draw('BL26E18R4F14G1E3F6BL1BH6H9G1BF6BR3E2F10');Wait;                 ≥
 ≥   Draw('BL33E18R4F14NG3E2F6BR12H15G7F3H5G1BR16F2E3F10');Wait;           ≥
 ≥   Draw('BL40E18R4F14NG4E2F6BR5H10G4BR9BF1E10F12BH4E3F10');Wait;         ≥
 ≥   Draw('BL47E18R4F14NG4E2NF6BF2E6F9BH1E13F9G3E7F10');Wait;              ≥
 ≥   Draw('BL6H6G6BL22E18R4F12NG3E4F6NG4E11F8NG7E3F10');Wait;              ≥
 ≥   Draw('BL10H6G6BL11E18R4F9NG8E1F3NG7E8F6NG9E1F10');Wait;               ≥
 ≥   Draw('BL13H6G6BL1E18R4F7BG3H2G10BR4E15F15BL4H10G10');Wait;            ≥
 ≥   Draw('BL28E6F6E18R4F18BL5H15G15BR3E10F10');Wait;                      ≥
 ≥   Draw('BL24E6F3NG3E7NF10BF2E7NF15BF3E6R4F18');Wait;                    ≥
 ≥   Draw('BL26E10F10BH6E9F15BR2H10G1BF3BE1E11R4F18');Wait;                ≥
 ≥   Draw('BL33E10NF7BF5E10F15BH6E4F10BH4E14R4F18');Wait;                  ≥
 ≥   Draw('BL39E10F6G2E13F15BH4E6F10E18R4F18');Wait;                       ≥
 ≥   Draw('BL32E10F5NG4E10F7G2E4F7BG3E18R4F18');Wait;                      ≥
 ≥  Until KeyPress;                                                        ≥
 ≥  DoneVideo;                                                             ≥
 ≥  DoneSystems;                                                           ≥
 ≥ END.                                                                    ≥
 ¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ}

Procedure BasicDraw(Var Q:BasicStruct;Const S:String);Near;
Var
 I:Byte;
 N:String;
 Mode:(_None_,_NoTrace_,_UnMove_);
 a,b:Integer;
 xc,yc:(NoMove,Add,Sub);

 Function ExtractNm:Integer;Near;
 Var
  N:String;
  a,b:Integer;
 Begin
  N:='';
  While(StrI(I,S)in ArabicDigit)do Begin
   IncStr(N,S[I]);
   Inc(I)
  End;
  If N=''Then a:=1
         Else Val(N,a,b);
  ExtractNm:=a;
 End;

 Function ExtractNmV:Integer;Near;Begin
  ExtractNmV:=ExtractNm*(DrawS shr 2)
 End;

 Procedure _Ln2(X,Y:Integer);Near;Begin
  If(Mode<>_NoTrace_)Then Begin
   Case(xc)of
    Add:Inc(X,VidBnkSwitch.XL);
    Sub:X:=VidBnkSwitch.XL-X;
   End;
   Case(yc)of
    Add:Inc(Y,VidBnkSwitch.YL);
    Sub:Y:=VidBnkSwitch.YL-Y;
   End;
   If(VidBnkSwitch.YL=Y)and(X<VidBnkSwitch.XL)Then BasicPutLine(Q,X,VidBnkSwitch.YL,VidBnkSwitch.XL,Y,GraphColor)
                                              Else BasicPutLine(Q,VidBnkSwitch.XL,VidBnkSwitch.YL,X,Y,GraphColor);
  End;
 End;

 Procedure SetPos(X,Y:Integer);Near;Begin
  Case(xc)of
   Add:Inc(X,VidBnkSwitch.XL);
   Sub:X:=VidBnkSwitch.XL-X;
  End;
  Case(yc)of
   Add:Inc(Y,VidBnkSwitch.YL);
   Sub:Y:=VidBnkSwitch.YL-Y;
  End;
  If(Mode<>_UnMove_)Then Begin
   VidBnkSwitch.XL:=X;
   VidBnkSwitch.YL:=Y;
  End;
  Mode:=_None_;
  xc:=NoMove;
  yc:=NoMove;
 End;

Begin
 I:=1;Mode:=_None_;
 While I<=Length(S)do Begin
  Inc(I);
  Case StrI(I-1,S)of
   'B':Mode:=_NoTrace_;
   'C':_SetKr(ExtractNm);
   'D':Begin
    a:=ExtractNmV;
    _Ln2(VidBnkSwitch.XL,VidBnkSwitch.YL+a);
    SetPos(VidBnkSwitch.XL,VidBnkSwitch.YL+a)
   End;
   'E':Begin
    a:=ExtractNmV;
    _Ln2(VidBnkSwitch.XL+a,VidBnkSwitch.YL-a);
    SetPos(VidBnkSwitch.XL+a,VidBnkSwitch.YL-a)
   End;
   'F':Begin
    a:=ExtractNmV;
    _Ln2(VidBnkSwitch.XL+a,VidBnkSwitch.YL+a);
    SetPos(VidBnkSwitch.XL+a,VidBnkSwitch.YL+a)
   End;
   'G':Begin
    a:=ExtractNmV;
    _Ln2(VidBnkSwitch.XL-a,VidBnkSwitch.YL+a);
    SetPos(VidBnkSwitch.XL-a,VidBnkSwitch.YL+a)
   End;
   'H':Begin
    a:=ExtractNmV;
    _Ln2(VidBnkSwitch.XL-a,VidBnkSwitch.YL-a);
    SetPos(VidBnkSwitch.XL-a,VidBnkSwitch.YL-a)
   End;
   'L':Begin
    a:=ExtractNmV;
    _Ln2(VidBnkSwitch.XL-a,VidBnkSwitch.YL);
    SetPos(VidBnkSwitch.XL-a,VidBnkSwitch.YL)
   End;
   'M':Begin
    If StrI(I,S)in['+','-']Then Begin
     If S[I]='+'Then xc:=Add else xc:=Sub;
     Inc(I);
    End;
    a:=ExtractNm;
    If StrI(I,S)=','Then Begin
     Inc(I);
     If StrI(I,S)in['+','-']Then Begin
      If S[I]='+'Then yc:=Add else yc:=Sub;
      Inc(I);
     End;
     b:=ExtractNm;
    End
     Else
    b:=VidBnkSwitch.YL;
    _Ln2(a,b);
    SetPos(a,b);
   End;
   'N':Mode:=_UnMove_;
   'R':Begin
    a:=ExtractNmV;
    _Ln2(VidBnkSwitch.XL+a,VidBnkSwitch.YL);
    SetPos(VidBnkSwitch.XL+a,VidBnkSwitch.YL)
   End;
   'U':Begin
    a:=ExtractNmV;
    _Ln2(VidBnkSwitch.XL,VidBnkSwitch.YL-a);
    SetPos(VidBnkSwitch.XL,VidBnkSwitch.YL-a)
   End;
' ',';':;{C'est 2 caractäres ne change rien en soit, donc...pas d'arràt!}
   Else Break;
  End
 End
End;

Function BasicFillBox(Var Q:BasicStruct;X1,Y1,X2,Y2,Style:Byte;Const Mode:String):Boolean;Near;
Var
 Ok:Boolean;
 X,Y:Byte;
Begin
 If(Q.CreateForm)Then Begin
  X:=WEGetRX1(Q.W);
  Y:=WEGetRY1(Q.W);
  Inc(X1,X);
  Inc(Y1,Y);
  Inc(X2,X);
  Inc(Y2,Y);
  If(X2>X1+Q.W.MaxX)Then X2:=X1+Q.W.MaxX;
  If(Y2>Y1+Q.W.MaxY)Then Y2:=Y1+Q.W.MaxY;
 End;
 BasicFillBox:=False;
 Ok:=GetShade;
 SetShade(No);
 If Mode='B'Then PutFillBorder(X1,Y1,X2,Y2,Style)Else
 If Mode='BD'Then Begin
  SetBorderDouble;
  PutFillBorder(X1,Y1,X2,Y2,Style)
 End
  Else
 If Mode='BL'Then Begin
  SetBorderSimpleLuxe;
  PutFillBorder(X1,Y1,X2,Y2,Style)
 End
  Else
 If Mode='BS'Then Begin
  SetBorderSimple;
  PutFillBorder(X1,Y1,X2,Y2,Style)
 End
  Else
 Begin
  Q.ExitCode:=SyntaxError;
  Exit;
 End;
 SetShade(Ok);
 BasicFillBox:=True;
End;

Procedure _BasicFillBox(Var Q:BasicStruct;X1,Y1,X2,Y2:Byte;Chr:Char;Attr:Byte);Near;
Var
 X,Y:Byte;
Begin
 If(Q.CreateForm)Then Begin
  X:=WEGetRX1(Q.W);
  Y:=WEGetRY1(Q.W);
  Inc(X1,X);
  Inc(Y1,Y);
  Inc(X2,X);
  Inc(Y2,Y);
  If(X2>X1+Q.W.MaxX)Then X2:=X1+Q.W.MaxX;
  If(Y2>Y1+Q.W.MaxY)Then Y2:=Y1+Q.W.MaxY;
 End;
 FillBox(X1,Y1,X2,Y2,Chr,Attr);
End;

Procedure BasicFillCircle(Var Q:BasicStruct;X,Y,Rayon,Color:Word);Near;Begin
 If(Q.CreateForm)Then Begin
  Inc(X,Q.Screen.X1);
  Inc(Y,Q.Screen.Y1);
 End;
 PutFillCircle(X,Y,Rayon,Color);
End;

Function BasicGet(Var Q:BasicStruct):Boolean;Near;
Label
 VirguleNotFound;
Var
 A,B,C,D,E:Variant;
 SubCall:Pointer;
 S,S2:String;
Begin
 BasicGet:=False;
 SkipSpc(Q.X,Q.PC);
 Case Q.PC^[Q.X]of
  '$':Begin
   Inc(Q.X);
   SkipSpc(Q.X,Q.PC);
   If Q.PC^[Q.X]<>'#'Then Begin
    Q.ExitCode:=DieseExpected;
    Exit;
   End;
   Inc(Q.X);
   S:='#';
   While Q.PC^[Q.X]in['0'..'9']do Begin
    IncStr(S,Q.PC^[Q.X]);
    Inc(Q.X)
   End;
   A.X.DataInt:=ReadVarInt(Q,S);
   If A.X.DataInt=0Then Begin
    Q.ExitCode:=FileNotOpen;
    Exit;
   End;
   If Q.PC^[Q.X]<>','Then Goto VirguleNotFound;
   Inc(Q.X);
   If Not Num(Q,B)Then Exit;
   If(B.X.DataInt>255)or(B.X.DataInt<1)Then Begin
    Q.ExitCode:=TooBigNumber;
    Exit;
   End;
   PXtrkWord(Q,S);
   If Q.PC^[Q.X]<>'$'Then Begin
    Q.ExitCode:=DollarExpected;
    Exit;
   End;
   IncStr(S,'$');
   Inc(Q.X);
   S2[0]:=Char(B.X.DataInt);
   If _GetRec(A.X.DataInt,B.X.DataLong,S2[1])<>0Then Begin
    Q.ExitCode:=SysErr;
    Exit;
   End;
   PushVarString(Q,S2,S);
  End;
  '(':Begin
   Inc(Q.X);
   If Not Num(Q,A)Then Exit;
   If Q.PC^[Q.X]<>','Then Goto VirguleNotFound;
   Inc(Q.X);
   If Not Num(Q,B)Then Exit;
   If Q.PC^[Q.X]<>')'Then Begin
    Q.ExitCode:=CloseParExpected;
    Exit;
   End;
   Inc(Q.X);
   SkipSpc(Q.X,Q.PC);
   If Q.PC^[Q.X]<>'-'Then Begin
    Q.ExitCode:=MinusExpected;
    Exit;
   End;
   Inc(Q.X);
   If Q.PC^[Q.X]<>'('Then Begin
    Q.ExitCode:=OpenParExpected;
    Exit;
   End;
   Inc(Q.X);
   If Not Num(Q,C)Then Exit;
   If Q.PC^[Q.X]<>','Then Goto VirguleNotFound;
   Inc(Q.X);
   If Not Num(Q,D)Then Exit;
   If Q.PC^[Q.X]<>')'Then Begin
    Q.ExitCode:=CloseParExpected;
    Exit;
   End;
   Inc(Q.X);
   SkipSpc(Q.X,Q.PC);
   If Q.PC^[Q.X]<>','Then Begin
VirguleNotFound:
    Q.ExitCode:=VirguleExpected;
    Exit;
   End;
   Inc(Q.X);
   SkipSpc(Q.X,Q.PC);
   PXtrkWord(Q,S);
   SubCall:=AddrTLong(Q,S,E.X.DataWord);
   If(SubCall=NIL)Then Begin
    Q.ExitCode:=VarNameExpected;
    Exit;
   End;
   BasicCreateForm(Q);
   If GetSizeSmlImg(A.X.DataInt,B.X.DataInt,C.X.DataInt,D.X.DataInt)+4>E.X.DataWord shl 2Then Begin
    Q.ExitCode:=ImageTooBig;
    Exit;
   End;
   ASM
    LES DI,SubCall
    MOV AX,C.X.DataInt
    SUB AX,A.X.DataInt
    STOSW
    MOV AX,D.X.DataInt
    SUB AX,B.X.DataInt
    STOSW
    ADD Word Ptr SubCall,4
   END;
   GetSmlImg(A.X.DataInt,B.X.DataInt,C.X.DataInt,D.X.DataInt,SubCall^);
  End;
  Else Begin
   Q.ExitCode:=SyntaxError;
   Exit;
  End;
 End;
 BasicGet:=True;
End;

Procedure BasicHTab(Var Q:BasicStruct;H:Word);Near;Begin
 Dec(H);
 SetPos(H,GetYTxtsPos);
 SetCurPos(H,GetYTxtsPos);
End;

Function BasicInput(Var Q:BasicStruct):Boolean;Near;
Var
 A:Variant;
 TypeVar:Char;
 VarName,S:String;
 Buffer:Array[Byte]of Char;
 PBuffer:PChr;
Begin
 BasicInput:=False;
 SkipSpc(Q.X,Q.PC);
 If Q.PC^[Q.X]='#'Then Begin
   { Lecture dans un fichier? }
  Inc(Q.X);
  S:='#';
  While Q.PC^[Q.X]in['0'..'9']do Begin
   IncStr(S,Q.PC^[Q.X]);
   Inc(Q.X)
  End;
  A.X.DataInt:=ReadVarInt(Q,S);
  If A.X.DataInt=0Then Begin
   Q.ExitCode:=FileNotOpen;
   Exit;
  End;
  SkipSpc(Q.X,Q.PC);
  If Q.PC^[Q.X]<>','Then Begin
   Q.ExitCode:=VirguleExpected;
   Exit;
  End;
  Inc(Q.X);
  S:=GetFileTxtLn(A.X.DataInt);
  TypeVar:=ExtractVarName(Q,VarName);
  Case(TypeVar)of
   '$':PushVarString(Q,S,VarName);
   '%':PushVarInt(Q,StrToInt(S),VarName);
   '&':PushVarLong(Q,StrToInt(S),VarName);
   '#','!':PushVarReal(Q,StrToReal(S),VarName);
   Else PushVarLong(Q,StrToInt(S),VarName);
  End;
 End
  Else
 Begin
   { EntrÇe au clavier }
  If _Str2S(Q,S)Then Begin
   SkipSpc(Q.X,Q.PC);
   If Q.PC^[Q.X]<>';'Then Begin
    Q.ExitCode:=VarNameExpected;
    Exit;
   End;
   Inc(Q.X);
  End
   Else
  S:='';
  BasicCreateForm(Q);
  WEPutTxt(Q.W,S+'?');
  S:='';
  FillClr(Buffer,SizeOf(Buffer));
  PBuffer:=@Buffer;
  If(WEInp(Q.W,PBuffer,255,False)=kbEsc)Then S:=''
                                        Else S:=StrPas(PBuffer);
  WELn(Q.W);
  TypeVar:=ExtractVarName(Q,VarName);
  Case(TypeVar)of
   '$':PushVarString(Q,S,VarName);
   '%':PushVarInt(Q,StrToInt(S),VarName);
   '&':PushVarLong(Q,StrToInt(S),VarName);
   '#','!':PushVarReal(Q,StrToReal(S),VarName);
   Else PushVarLong(Q,StrToInt(S),VarName);
  End;
 End;
 BasicInput:=True;
End;

Function BasicKey(Var Q:BasicStruct):Boolean;Near;
Var
 S:String;
Begin
 BasicKey:=False;
 SkipSpc(Q.X,Q.PC);
 PXtrkWord(Q,S);
 If S='ON'Then Q.Key:=True Else
 If S='OFF'Then Q.Key:=False
  Else
 Begin
  Q.ExitCode:=ValueExpected;
  Exit;
 End;
 BasicKey:=True;
End;

Procedure BasicLocate(Var Q:BasicStruct;a,b:Integer);Near;Begin
 If Not(Q.HScreen)Then Begin
  Dec(a);
  Dec(b);
 End;
 If(Q.HScreen)Then Begin
  SetCurPos(a,b);
  SetPos(a,b)
 End
  Else
 Begin
  SetCurPos(b,a);
  SetPos(b,a)
 End;
End;

Function BasicMousePtr(Var Q:BasicStruct):Boolean;Near;
Var
 S:String;
Begin
 BasicMousePtr:=False;
 SkipSpc(Q.X,Q.PC);
 PXtrkWord(Q,S);
 If S='ON'Then __ShowMousePtr Else
 If S='OFF'Then __HideMousePtr
  Else
 Begin
  Q.ExitCode:=ValueExpected;
  Exit;
 End;
 BasicMousePtr:=True;
End;

Function BasicNumLock(Var Q:BasicStruct):Boolean;Near;
Var
 S:String;
Begin
 BasicNumLock:=True;
 SkipSpc(Q.X,Q.PC);
 PXtrkWord(Q,S);
 If S='ON'Then SetNmLck(True)Else
 If S='OFF'Then SetNmLck(False)
  Else
 Begin
  BasicNumLock:=False;
  Q.ExitCode:=ValueExpected;
 End;
End;

Procedure BasicPaint(Var Q:BasicStruct;X,Y,Color,StopColor:Word);Near;

 Procedure PredLine(L,R,Y:Integer;UpDown:Byte);Near;
 Var
  X,X2:Integer;
 Begin
  If(BasicGetPixel(Q,L,Y)=StopColor)Then Begin
   While(L>0)and(BasicGetPixel(Q,L-1,Y)=StopColor)do Dec(L);
  End;
  X:=L;
  If(BasicGetPixel(Q,R,Y)=StopColor)Then Begin
   While(R<BasicGetNumXPixels(Q))and(BasicGetPixel(Q,R+1,Y)=StopColor)do Inc(R);
  End;
  While(X<=R)do Begin
   X2:=X;
   If(BasicGetPixel(Q,X,Y)=StopColor)Then Begin
    While(BasicGetPixel(Q,X+1,Y)=StopColor)and(X<BasicGetNumXPixels(Q))do Inc(X);
    BasicPutLineHor(Q,X2,Y,X,Color);
    If UpDown=2Then Begin
     If Y>0Then PredLine(X2,X,Y-1,2);
     If Y<BasicGetNumYPixels(Q)Then If(L>X2)and(R<X)Then Begin
      PredLine(X2,L-1,Y+1,1);
      PredLine(R+1,X,Y+1,1);
     End
      Else
     If(L<=X2)and(R<X)Then PredLine(R+1,X,Y+1,1)Else
     If(L>X2)and(R>=X)Then PredLine(X2,L-1,Y+1,1);
    End;
    If UpDown=1Then Begin
     If Y<BasicGetNumYPixels(Q)Then PredLine(X2,X,Y+1,1);
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
 StopColor:=BasicGetPixel(Q,X,Y);
 If Y<>0Then Dec(Y);
 PredLine(X,X,Y,2);
 PredLine(X,X,Y+1,1);
End;

Function BasicPPoint(Var Q:BasicStruct;X,Y:Word):LongInt;Near;Begin
 BasicPPoint:=BasicGetPixel(Q,X,Y);
End;

Procedure BasicPrint(Var Q:BasicStruct;Const S:String;Return:Boolean);Near;Begin
 If Not(Return)Then Begin
  If(Q.CreateForm)Then WEPutTxt(Q.W,S)
                  Else _PutTxt(S)
 End
  Else
 Begin
  If(Q.HScreen)Then Begin
   If(Q.CreateForm)Then Begin
    WEPutTxt(Q.W,S);
    WEClrEol(Q.W);
    WELn(Q.W);
   End
    Else
   Begin
    _PutTxt(S);
    ClrEol(GetKr);
    _Dn;
    VidBnkSwitch.XP:=0;
   End;
  End
   Else
  Begin
   If(Q.CreateForm)Then WEPutTxtLn(Q.W,S)
                   Else _PutTxtLn(S);
  End;
 End;
End;

Procedure BasicSendKeys(Const S:String);Near;Begin
 PushKey(Byte(S[1])+(Byte(StrI(2,S))shl 8));
End;

Function ExtractVarName(Var Q:BasicStruct;Var VarName:String):Char;
Var
 TypeVar:Char;
Begin
 SkipSpc(Q.X,Q.PC);
 PXtrkWord(Q,VarName);
 If VarName=''Then Q.ExitCode:=VarNameExpected;
 TypeVar:=Q.PC^[Q.X];
 If(TypeVar)in['%','&','!','#','$']Then Begin
  IncStr(VarName,TypeVar);
  Inc(Q.X);
 End;
 SkipSpc(Q.X,Q.PC);
 ExtractVarName:=TypeVar;
End;

Procedure PushNAddVar(Var Q:BasicStruct;Const S:String;Const A,Add:Variant);Near;Begin
 Case S[Length(S)]of
  '!','#':PushVarReal(Q,VariantToReal(A)+VariantToReal(Add),S);
  '%':PushVarInt(Q,A.X.DataInt+Add.X.DataInt,S);
  Else PushVarLong(Q,A.X.DataLong+Add.X.DataLong,S);
 End;
End;

Procedure PushVar(Var Q:BasicStruct;Const S:String;Const A:Variant);Near;Begin
 Case S[Length(S)]of
  '!','#':PushVarReal(Q,VariantToReal(A),S);
  '%':PushVarInt(Q,VariantToInt(A),S);
  '$':PushVarString(Q,A.X.DataPString^,S);
  Else Begin
   Case VarCode(Q,S)of
    DataInteger:PushVarInt(Q,VariantToInt(A),S);
    DataSingle,DataDouble,DataReal:PushVarReal(Q,VariantToReal(A),S);
    Else PushVarLong(Q,VariantToInt(A),S);
   End;
  End;
 End;
End;

Procedure ReadVar(Var Q:BasicStruct;Const S:String;Var A:Variant);Begin
 FillClr(A,SizeOf(A));
 Case S[Length(S)]of
  '%':Begin
   A.X.DataInt:=ReadVarInt(Q,S);
   A.TypeDef:=dtInt;
  End;
  '#','!':Begin
   A.X.DataReal:=ReadVarReal(Q,S);
   A.TypeDef:=dtReal;
  End;
  Else Begin
   Case VarCode(Q,S)of
    DataInteger:Begin
     A.X.DataInt:=ReadVarInt(Q,S);
     A.TypeDef:=dtInt;
    End;
    DataSingle,DataDouble,DataReal:Begin
     A.X.DataReal:=ReadVarReal(Q,S);
     A.TypeDef:=dtReal;
    End;
    Else Begin
     A.X.DataLong:=ReadVarLong(Q,S);
     A.TypeDef:=dtLong;
    End;
   End;
  End;
 End;
End;

Function BasicCmpFor(Const A,C,B:Variant):Boolean;
Var
 Neg:Boolean;
Begin
 BasicCmpFor:=False;
 Neg:=VariantToReal(C)<0;
 If(Neg)Then Begin
  Case(C.TypeDef)of
   dtReal:BasicCmpFor:=VariantToReal(A)+VariantToReal(C)<VariantToReal(B);
   dtLong:BasicCmpFor:=A.X.DataLong+C.X.DataLong<B.X.DataLong;
   Else BasicCmpFor:=A.X.DataInt+C.X.DataInt<B.X.DataInt;
  End;
 End
  Else
 Begin
  Case(C.TypeDef)of
   dtReal:BasicCmpFor:=VariantToReal(A)+VariantToReal(C)>VariantToReal(B);
   dtLong:BasicCmpFor:=A.X.DataLong+C.X.DataLong>B.X.DataLong;
   Else BasicCmpFor:=A.X.DataInt+C.X.DataInt>B.X.DataInt;
  End;
 End;
End;

Function BasicRead(Var Q:BasicStruct;Source:ArrayList):Boolean;Near;
Label
 Restart,ContinueSearch,DataFound;
Var
 TypeVar:Char;
 PC:PChr;
 VarName,Word,S:String;
Begin
 BasicRead:=False;
 If(Q.ReadDataY>Source.Count)Then Q.ExitCode:=errOutOfData
  Else
 Begin
Restart:
   { Recherche le nom de la variable }
  TypeVar:=ExtractVarName(Q,VarName);
   { Recherche une donnÇes }
ContinueSearch:
  If Q.ReadDataX=0Then Begin
   ALSetPtr(Source,Q.ReadDataY);
   Repeat
    PC:=_ALGetCurrBuf(Source);
    If Not IsPChrEmpty(PC)Then Begin
     While PC^[Q.ReadDataX]<>#0do Begin
      Case PC^[Q.ReadDataX]of
       '''':Break;
       'D','d':Begin
        Word:='';
        While ChrUp(PC^[Q.ReadDataX])in['A'..'Z']do Begin
         IncStr(Word,PC^[Q.ReadDataX]);
         Inc(Q.ReadDataX);
        End;
        If Word='DATA'Then Goto DataFound;
       End;
       'R','r':Begin
        Word:='';
        While ChrUp(PC^[Q.ReadDataX])in['A'..'Z']do Begin
         IncStr(Word,PC^[Q.ReadDataX]);
         Inc(Q.ReadDataX);
        End;
        If Word='REM'Then Break;
       End;
       Else Inc(Q.ReadDataX);
      End;
     End;
    End;
    ALNext(Source);
    Q.ReadDataX:=0;
    Inc(Q.ReadDataY);
   Until(Q.ReadDataY>=Source.Count);
   Q.ExitCode:=errOutOfData;
   Exit;
  End;
  PC:=_ALGetBuf(Source,Q.ReadDataY);
DataFound:
  SkipSpc(Q.ReadDataX,PC);
  Case(TypeVar)of
   '%':Begin
    S:='';
    If PC^[Q.ReadDataX]='-'Then Begin
     IncStr(S,'-');
     Inc(Q.ReadDataX);
    End;
    While PC^[Q.ReadDataX]in['0'..'9']do Begin
     IncStr(S,PC^[Q.ReadDataX]);
     Inc(Q.ReadDataX);
    End;
    If S=''Then Begin
     Q.ReadDataX:=0;
     Inc(Q.ReadDataY);
     Goto ContinueSearch;
    End;
    PushVarInt(Q,StrToInt(S),VarName);
   End;
   '$':Begin
    S:='';
    While Not(PC^[Q.ReadDataX]in[',',#0])do Begin
     IncStr(S,PC^[Q.ReadDataX]);
     Inc(Q.ReadDataX);
    End;
    If StrI(1,S)='"'Then S:=Copy(S,2,255);
    If StrI(Length(S),S)='"'Then BackStr(S);
    PushVarString(Q,S,VarName);
   End;
   '!','#':Begin
    S:='';
    If PC^[Q.ReadDataX]='-'Then Begin
     IncStr(S,'-');
     Inc(Q.ReadDataX);
    End;
    While PC^[Q.ReadDataX]in['0'..'9','.']do Begin
     IncStr(S,PC^[Q.ReadDataX]);
     Inc(Q.ReadDataX);
    End;
    If S=''Then Begin
     Q.ReadDataX:=0;
     Inc(Q.ReadDataY);
     Goto ContinueSearch;
    End;
    PushVarReal(Q,StrToReal(S),VarName);
   End;
   '&':Begin
    S:='';
    If PC^[Q.ReadDataX]='-'Then Begin
     IncStr(S,'-');
     Inc(Q.ReadDataX);
    End;
    While PC^[Q.ReadDataX]in['0'..'9']do Begin
     IncStr(S,PC^[Q.ReadDataX]);
     Inc(Q.ReadDataX);
    End;
    If S=''Then Begin
     Q.ReadDataX:=0;
     Inc(Q.ReadDataY);
     Goto ContinueSearch;
    End;
    PushVarLong(Q,StrToInt(S),VarName);
   End;
   Else Begin
    S:='';
    If PC^[Q.ReadDataX]='-'Then Begin
     IncStr(S,'-');
     Inc(Q.ReadDataX);
    End;
    While PC^[Q.ReadDataX]in['0'..'9']do Begin
     IncStr(S,PC^[Q.ReadDataX]);
     Inc(Q.ReadDataX);
    End;
    If S=''Then Begin
     Q.ReadDataX:=0;
     Inc(Q.ReadDataY);
     Goto ContinueSearch;
    End;
    PushVarLong(Q,StrToInt(S),VarName);
   End;
  End;
  If PC^[Q.ReadDataX]=','Then Inc(Q.ReadDataX);
  If Q.PC^[Q.X]=','Then Begin
   Inc(Q.X);
   Goto Restart;
  End;
  BasicRead:=True;
 End;
End;

Function BasicFindNCreateObject(Var Q:BasicStruct;Const Name:String):Boolean;Near;
Var
 S:String;
Begin
 BasicFindNCreateObject:=False;
 SkipSpc(Q.X,Q.PC);
 PXtrkWord(Q,S);
 If S='SERVER'Then Begin
  If Q.PC^[Q.X]<>'.'Then Begin
   Q.ExitCode:=CommaExpected;
   Exit;
  End;
  Inc(Q.X);
  PXtrkWord(Q,S);
  If S='CREATEOBJECT'Then Begin
   If Q.PC^[Q.X]<>'('Then Begin
    Q.ExitCode:=OpenParExpected;
    Exit;
   End;
   If Not _Str2S(Q,S)Then Exit;
   SkipSpc(Q.X,Q.PC);
   If Q.PC^[Q.X]<>'('Then Begin
    Q.ExitCode:=CloseParExpected;
    Exit;
   End;
    { VÇrifie la demande de crÇation d'objet }
   S:=StrUp(S);
   If S='ADODB.CONNECTION'Then Begin
    { ... ? Ö Çcrire du code objet permettant la connection Ö la base de donnÇes ?...}
   End;
  End;
 End;
 BasicFindNCreateObject:=True;
End;

Function BasicReg(Var Q:BasicStruct;NumReg:Byte;Value:Word):Boolean;Near;Begin
 BasicReg:=False;
 Case(NumReg)of
  0:Q.Regs.Flags:=Value;
  1:Q.Regs.AX:=Value;
  2:Q.Regs.BX:=Value;
  3:Q.Regs.CX:=Value;
  4:Q.Regs.DX:=Value;
  5:Q.Regs.SI:=Value;
  6:Q.Regs.DI:=Value;
  7:Q.Regs.BP:=Value;
  8:Q.Regs.DS:=Value;
  9:Q.Regs.ES:=Value;
  Else Begin
   Q.ExitCode:=InvalidFunctionCall;
   Exit;
  End;
 End;
 BasicReg:=True;
End;

Function BasicRestore(Var Q:BasicStruct;Source:ArrayList):Boolean;
Var
 I:Integer;
 PC:PChr;
 X:Word;
 A:Variant;
 S:String;
Begin
 BasicRestore:=False;
 If Num(Q,A)Then Begin
  ALSetPtr(Source,0);
  For I:=0to Source.Count-1do Begin
   PC:=_ALGetCurrBuf(Source);
   X:=0;
   If(PC<>NIL)Then Begin
    SkipSpc(X,PC);
    S:='';
    While PC^[X]in['0'..'9']do Begin
     IncStr(S,PC^[X]);
     Inc(X);
    End;
    If(StrToWord(S)=A.X.DataWord)Then Begin
     Q.ReadDataX:=0;
     Q.ReadDataY:=I;
     BasicRestore:=True;
     Exit;
    End;
   End;
   ALNext(Source);
  End;
  Q.ExitCode:=LabelExpected;
  Exit;
 End
  Else
 Begin
  Q.ReadDataX:=0;
  Q.ReadDataY:=0;
 End;
 BasicRestore:=True;
End;

Function BasicScrollLock(Var Q:BasicStruct):Boolean;Near;
Var
 S:String;
Begin
 BasicScrollLock:=True;
 SkipSpc(Q.X,Q.PC);
 PXtrkWord(Q,S);
 If S='ON'Then SetScrollLck(True)Else
 If S='OFF'Then SetScrollLck(False)
  Else
 Begin
  BasicScrollLock:=False;
  Q.ExitCode:=ValueExpected;
 End;
End;

Procedure BasicShell(Var Q:BasicStruct;Const S:String);Begin
 {$IFNDEF DPMI}
  FreeMaxHeap;
 {$ENDIF}
 Exec(GetEnv('COMSPEC'),'/C'+S);
 {$IFNDEF DMPI}
  MaxExpandHeap;
 {$ENDIF}
End;

Procedure BasicSound(Freq,Duree:Word);Near;Begin
 Sound(Freq);
 Delay(Duree);
 NoSound;
End;

Procedure BasicXChgMenu(Var Menu:PullMnu);
Var
 TMenu:PullMnu;
Begin
 TMenu:=MainMenu;
 MainMenu:=Menu;
 Menu:=TMenu;
End;

Function BasicView(Var Q:BasicStruct):Boolean;Near;
Var
 S:String;
Begin
 SkipSpc(Q.X,Q.PC);
 PXtrkWord(Q,S);
 If S='MENU'Then Begin
  Q.ViewMenu:=True;
  BasicXChgMenu(Q.Menu);
  If(Q.CreateForm)Then Begin
   PMSetWinBar(Q.W.T.X1,WEGetRY1(Q.W),Q.W.T.X2);
  End;
  PMPutMnuBar;
  BasicXChgMenu(Q.Menu);
  BasicView:=True;
  If Q.W.Y=0Then Q.W.Y:=1; { DÇplace d'une ligne pour ne pas Çcraser le menu }
 End
  Else
 Begin
  Q.ExitCode:=SyntaxError;
  BasicView:=False;
 End;
End;

Procedure BasicVTAB(Line:Word);Near;Begin
 Dec(Line);
 SetPos(GetNmXTxts,Line);
 SetCurPos(GetNmXTxts,Line);
End;

Procedure BasicCreateForm(Var Q:BasicStruct);
Var
 Title:String;
Begin
 If(Q.InForm)Then Begin
  If Not(Q.CreateForm)Then Begin
   Q.CreateForm:=True;
   Title:=Q.W.Title;
   WEInit(Q.W,5,5,MaxXTxts-5,MaxYTxts-5);
   If(Q.CreateForm)Then Begin
    Q.Screen.X1:=(WEGetRX1(Q.W)shl 3);
    Q.Screen.Y1:=GetRawY(WEGetRY1(Q.W));
    Q.Screen.X2:=Q.Screen.X1+((Q.W.MaxX+1)shl 3)-1;
    Q.Screen.Y2:=Q.Screen.Y1+GetRawY(Q.W.MaxY+1)-1
   End;
   WEPushWn(Q.W);
   WEPutWnKrDials(Q.W,Title);
  End;
 End;
End;

Function BasicWidth(Var Q:BasicStruct;Width:Word):Boolean;Near;Begin
 BasicWidth:=False;
 If(IsGrf)Then Begin
  If(CurrVideoMode=6)and(Width=40)Then SetVideoMode(vmGrf320x200c4)Else
  If(CurrVideoMode=5)and(Width=80)Then SetVideoMode(vmGrf640x200c2)Else
  If Not SetVideoSize(BitsPerPixel,Width,NmYTxts)Then Begin
   Q.ExitCode:=InvalidFunctionCall;
   Exit;
  End;
 End
  Else
 Begin
  If Not SetVideoSize(0,Width,NmYTxts)Then Begin
   Q.ExitCode:=InvalidFunctionCall;
   Exit;
  End;
  If(Q.HScreen)Then SetUnderline(True);
 End;
 Q.Screen.X1:=0;
 Q.Screen.Y1:=0;
 Q.Screen.X2:=GetMaxXPixels;
 Q.Screen.Y2:=GetMaxYPixels;
 BasicWidth:=True;
End;

Procedure BasicEndMessage(Var Q:BasicStruct);Near;Begin
 If Not(Q.InForm)Then Begin
  ClrKbd;
  PutTxtXY(0,MaxYTxts-1,'Presse une touche pour',7);
  PutTxtXY(0,MaxYTxts,'retourner au systäme...',7);
  ReadKey;
 End;
End;

Procedure SkipSpc(Var I:Word;PC:PChr);Assembler;ASM
  {While PC^[I]in[#9,' ']do Inc(I);}
 LES DI,I
 MOV BX,ES:[DI]
 LES DI,PC
 DEC BX
@1:
 INC BX
 CMP Byte Ptr ES:[DI+BX],9
 JE  @1
 CMP Byte Ptr ES:[DI+BX],' '
 JE  @1
 LES DI,I
 MOV ES:[DI],BX
END;

{⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ‹
 ≥                         Fonction PXtrkWord                       €
 ¿‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹€


 Description
 ÕÕÕÕÕÕÕÕÕÕÕ

  Cette fonction permet d'extraire une mot littÇraire d'une chaåne de
 caractäres de style ASCIIZ (langage de programmation C).
}

Procedure PXtrkWord(Var Q:BasicStruct;Var W:String);Assembler;ASM
 PUSH DS
  LDS SI,Q
  LES DI,DS:[SI].BasicStruct.PC
  ADD DI,DS:[SI].BasicStruct.X
  MOV CL,ES:[DI]
  AND CL,0DFh
  CMP CL,'A'
  JB  @Empty
  CMP CL,'Z'
  JA  @Empty
  INC Word Ptr DS:[SI].BasicStruct.X
  MOV AH,ES:[DI]
  MOV AL,1
  LES DI,W
  STOSW
@1:
  LES DI,DS:[SI].BasicStruct.PC
  ADD DI,DS:[SI].BasicStruct.X
  MOV CL,ES:[DI]
  AND CL,0DFh
  CMP CL,'A'
  JB  @Brk
  CMP CL,'Z'
  JA  @Brk
  LES BX,W
  CMP Byte Ptr ES:[BX],255
  JE  @Brk
  INC Byte Ptr ES:[BX]
  ADD BL,ES:[BX]
  ADC BH,0
  MOV ES:[BX],CL
  INC Word Ptr DS:[SI].BasicStruct.X
  JMP @1
@Empty:
  XOR AL,AL
  LES DI,W
  STOSB
@Brk:
 POP DS
END;

Function OfsVar(Var Q:BasicStruct;Const N:String):Word;
Var
 L,J:Word;
 P:Pointer;
Begin
 J:=0;
 While Q.Data[J]<>0do Begin
  L:=DataSize[Q.Data[J]]+3;
  If Compare(Q.Data[L+J],N,Length(N)+1)Then Begin
   OfsVar:=J+3;
   Exit;
  End;
  ASM
   MOV BX,J
   INC BX
   LES DI,Q
   MOV AX,Word Ptr ES:[DI].BasicStruct.Data[BX]
   MOV J,AX
  END;
 End;
 OfsVar:=$FFFF;
End;

{ Cette fonction ajoute une variable de format ÆIntegerØ et retourne comme
 rÇsultat si elle existait ou non.
}

Function PushVarInt(Var Q:BasicStruct;X:Integer;Const N:String):Boolean;
Label 1;
Var
 Jmp,J,L,Ofs:Word;
Begin
 {Recherche d'une variable existante}
 J:=0;PushVarInt:=False;
 While Q.Data[J]<>0do Begin
  L:=DataSize[Q.Data[J]]+3;
  If Compare(Q.Data[L+J],N,Length(N)+1)Then Begin
   ASM
    MOV BX,J
    ADD BX,3
    MOV Ofs,BX
   END;
   PushVarInt:=True;
   Goto 1;
  End;
  ASM
   MOV BX,J
   INC BX
   LES DI,Q
   MOV AX,Word Ptr ES:[DI].BasicStruct.Data[BX]
   MOV J,AX
  END;
 End;
 {Affectation}
 If Q.CurData+Length(N)+6>SizeOf(Q.Data)Then Exit;
 Q.Data[Q.CurData]:=DataInteger;
 Inc(Q.CurData);
 Jmp:=Q.CurData+2+SizeOf(Integer)+Length(N)+1;
 ASM
   {Fixe le Jump}
  MOV AX,Jmp
  LES DI,Q
  MOV BX,ES:[DI].BasicStruct.CurData
  MOV Word Ptr ES:[DI].BasicStruct.Data[BX],AX
  ADD ES:[DI].BasicStruct.CurData,TYPE Integer
 END;
 Ofs:=Q.CurData;
 Inc(Q.CurData,SizeOf(Integer));
 MoveLeft(N,Q.Data[Q.CurData],Length(N)+1);
 Inc(Q.CurData,Length(N)+1);
1:
 ASM
   { Copie les donnÇes }
  MOV AX,X
  MOV BX,Ofs
  LES DI,Q
  MOV Word Ptr ES:[DI].BasicStruct.Data[BX],AX
 END;
End;

{ Cette fonction ajoute une variable de format ÆLongØ et retourne comme
 rÇsultat si elle existait ou non.
}

Function PushVarLong(Var Q:BasicStruct;X:LongInt;Const N:String):Boolean;
Label 1;
Var
 Jmp,J,L,Ofs:Word;
Begin
 {Recherche d'une variable existante}
 J:=0;PushVarLong:=False;
 While Q.Data[J]<>0do Begin
  L:=DataSize[Q.Data[J]]+3;
  If Compare(Q.Data[L+J],N,Length(N)+1)Then Begin
   ASM
    MOV BX,J
    ADD BX,3
    MOV Ofs,BX
   END;
   PushVarLong:=True;
   Goto 1;
  End;
  ASM
   MOV BX,J
   INC BX
   LES DI,Q
   MOV AX,Word Ptr ES:[DI].BasicStruct.Data[BX]
   MOV J,AX
  END;
 End;
 {Affectation}
 If Q.CurData+Length(N)+8>SizeOf(Q.Data)Then Exit;
 Q.Data[Q.CurData]:=DataLong;
 Inc(Q.CurData);
 Jmp:=Q.CurData+2+SizeOf(Long)+Length(N)+1;
 ASM
   {Fixe le Jump}
  MOV AX,Jmp
  LES DI,Q
  MOV BX,ES:[DI].BasicStruct.CurData
  MOV Word Ptr ES:[DI].BasicStruct.Data[BX],AX
  ADD ES:[DI].BasicStruct.CurData,TYPE Integer
 END;
 Ofs:=Q.CurData;
 Inc(Q.CurData,SizeOf(LongInt));
 MoveLeft(N,Q.Data[Q.CurData],Length(N)+1);
 Inc(Q.CurData,Length(N)+1);
1:
 ASM
   { Copie les donnÇes }
  LES AX,X
  MOV CX,ES
  MOV BX,Ofs
  LES DI,Q
  MOV Word Ptr ES:[DI].BasicStruct.Data[BX],AX
  MOV Word Ptr ES:[DI].BasicStruct.Data[BX+2],CX
 END;
End;

Function PushVarReal(Var Q:BasicStruct;X:Real;Const N:String):Boolean;
Label 1;
Var
 Jmp,J,L,Ofs:Word;
Begin
 {Recherche d'une variable existante}
 J:=0;PushVarReal:=False;
 While Q.Data[J]<>0do Begin
  L:=DataSize[Q.Data[J]]+3;
  If Compare(Q.Data[L+J],N,Length(N)+1)Then Begin
   ASM
    MOV BX,J
    ADD BX,3
    MOV Ofs,BX
   END;
   PushVarReal:=True;
   Goto 1;
  End;
  ASM
   MOV BX,J
   INC BX
   LES DI,Q
   MOV AX,Word Ptr ES:[DI].BasicStruct.Data[BX]
   MOV J,AX
  END;
 End;
 {Affectation}
 If Q.CurData+Length(N)+8>SizeOf(Q.Data)Then Exit;
 Q.Data[Q.CurData]:=DataReal;
 Inc(Q.CurData);
 Jmp:=Q.CurData+2+SizeOf(Real)+Length(N)+1;
 ASM
   {Fixe le Jump}
  MOV AX,Jmp
  LES DI,Q
  MOV BX,ES:[DI].BasicStruct.CurData
  MOV Word Ptr ES:[DI].BasicStruct.Data[BX],AX
  ADD ES:[DI].BasicStruct.CurData,TYPE Integer
 END;
 Ofs:=Q.CurData;
 Inc(Q.CurData,SizeOf(Real));
 MoveLeft(N,Q.Data[Q.CurData],Length(N)+1);
 Inc(Q.CurData,Length(N)+1);
1:
 ASM
   { Copie les donnÇes }
  MOV AX,Word Ptr X[0]
  MOV DX,Word Ptr X[2]
  MOV CX,Word Ptr X[4]
  MOV BX,Ofs
  LES DI,Q
  MOV Word Ptr ES:[DI].BasicStruct.Data[BX],AX
  MOV Word Ptr ES:[DI].BasicStruct.Data[BX+2],DX
  MOV Word Ptr ES:[DI].BasicStruct.Data[BX+4],CX
 END;
End;

(*Procedure PushVarSingle(Var Q:BasicStruct;X:Single;Const N:String);
Label 1;
Var
 Jmp,J,L,Ofs:Word;
Begin
 {Recherche d'une variable existante}
 J:=0;
 While Q.Data[J]<>0do Begin
  L:=DataSize[Q.Data[J]]+3;
  If Compare(Q.Data[L+J],N,Length(N)+1)Then Begin
   ASM
    MOV BX,J
    ADD BX,3
    MOV Ofs,BX
   END;
   Goto 1;
  End;
  ASM
   MOV BX,J
   INC BX
   LES DI,Q
   MOV AX,Word Ptr ES:[DI].BasicStruct.Data[BX]
   MOV J,AX
  END;
 End;
 {Affectation}
 If Q.CurData+Length(N)+8>SizeOf(Q.Data)Then Exit;
 Q.Data[Q.CurData]:=DataSingle;
 Inc(Q.CurData);
 Jmp:=Q.CurData+2+SizeOf(Single)+Length(N)+1;
 ASM
   {Fixe le Jump}
  MOV AX,Jmp
  LES DI,Q
  MOV BX,ES:[DI].BasicStruct.CurData
  MOV Word Ptr ES:[DI].BasicStruct.Data[BX],AX
  ADD ES:[DI].BasicStruct.CurData,TYPE Integer
 END;
 Ofs:=Q.CurData;
 Inc(Q.CurData,SizeOf(Single));
 MoveLeft(N,Q.Data[Q.CurData],Length(N)+1);
 Inc(Q.CurData,Length(N)+1);
1:
 ASM
   { Copie les donnÇes }
  MOV AX,Word Ptr X[0]
  MOV DX,Word Ptr X[2]
  MOV BX,Ofs
  LES DI,Q
  MOV Word Ptr ES:[DI].BasicStruct.Data[BX],AX
  MOV Word Ptr ES:[DI].BasicStruct.Data[BX+2],DX
 END;
End;*)

Function PushVarStr2PChr(Var Q:BasicStruct;Const X:String):PChar;
Var
 Jmp:Word;
 P:PChr;
Begin
 If Q.CurData+Length(X)+4>SizeOf(Q.Data)Then Exit;
 Q.Data[Q.CurData]:=DataPChar;
 Inc(Q.CurData);
 Jmp:=Q.CurData+2+Length(X)+1;
 ASM
   {Fixe le Jump}
  MOV AX,Jmp
  LES DI,Q
  MOV BX,ES:[DI].BasicStruct.CurData
  MOV Word Ptr ES:[DI].BasicStruct.Data[BX],AX
  ADD ES:[DI].BasicStruct.CurData,TYPE Integer
 END;
 P:=@Q.Data[Q.CurData];
 StrPCopy(P,X);
 Inc(Q.CurData,Length(X)+1);
 PushVarStr2PChr:=PChar(P);
End;

Procedure PushVarString(Var Q:BasicStruct;Const X,N:String);
Label 1;
Var
 Jmp,J,L,Ofs:Word;
Begin
  {Recherche d'une variable existante}
 J:=0;
 While Q.Data[J]<>0do Begin
  L:=DataSize[Q.Data[J]]+3;
  If Compare(Q.Data[L+J],N,Length(N)+1)Then Begin
   ASM
    MOV BX,J
    ADD BX,3
    MOV Ofs,BX
   END;
   Goto 1;
  End;
  ASM
   MOV BX,J
   INC BX
   LES DI,Q
   MOV AX,Word Ptr ES:[DI].BasicStruct.Data[BX]
   MOV J,AX
  END;
 End;
 {Affectation}
 If Q.CurData+Length(N)+4+SizeOf(String)>SizeOf(Q.Data)Then Exit;
 Q.Data[Q.CurData]:=DataString;
 Inc(Q.CurData);
 Jmp:=Q.CurData+2+SizeOf(String)+Length(N)+1;
 ASM
   {Fixe le Jump}
  MOV AX,Jmp
  LES DI,Q
  MOV BX,ES:[DI].BasicStruct.CurData
  MOV Word Ptr Es:[DI].BasicStruct.Data[BX],AX
  ADD ES:[DI].BasicStruct.CurData,TYPE Integer
 END;
 Ofs:=Q.CurData;
 Inc(Q.CurData,SizeOf(String));
 MoveLeft(N,Q.Data[Q.CurData],Length(N)+1);
 Inc(Q.CurData,Length(N)+1);
1:
 MoveLeft(X,Q.Data[Ofs],SizeOf(String));
End;

Function PushVarTLong(Var Q:BasicStruct;Const N:String;T:Word):Boolean;
Var
 Jmp,J,L,Ofs:Word;
 P:Pointer;
Begin
  {Recherche d'une variable existante}
 J:=0;PushVarTLong:=False;
 While Q.Data[J]<>0do Begin
  L:=DataSize[Q.Data[J]]+3;
  If Compare(Q.Data[L+J],N,Length(N)+1)Then Begin
   Q.ExitCode:=VarDupl;
   Exit;
  End;
  ASM
   MOV BX,J
   INC BX
   LES DI,Q
   MOV AX,Word Ptr ES:[DI].BasicStruct.Data[BX]
   MOV J,AX
  END;
 End;
 {Affectation}
 If Q.CurData+Length(N)+8>SizeOf(Q.Data)Then Begin
  Q.ExitCode:=OutOfMemory;
  Exit;
 End;
 P:=MemNew(T shl 2);
 If(P=NIL)Then Begin
  Q.ExitCode:=OutOfMemory;
  Exit;
 End;
 Q.Data[Q.CurData]:=DataTLong;
 Inc(Q.CurData);
 Jmp:=Q.CurData+2+(SizeOf(Pointer)+2)+Length(N)+1;
 ASM
   {Fixe le Jump}
  MOV AX,Jmp
  LES DI,Q
  MOV BX,ES:[DI].BasicStruct.CurData
  MOV Word Ptr ES:[DI].BasicStruct.Data[BX],AX
  ADD ES:[DI].BasicStruct.CurData,TYPE Integer
 END;
 Ofs:=Q.CurData;
 Inc(Q.CurData,SizeOf(Pointer)+2);
 MoveLeft(N,Q.Data[Q.CurData],Length(N)+1);
 Inc(Q.CurData,Length(N)+1);
 ASM
   { Copie les donnÇes }
  LES AX,P
  MOV BX,Ofs
  LES DI,Q
  MOV Word Ptr ES:[DI].BasicStruct.Data[BX],AX
  MOV Word Ptr ES:[DI].BasicStruct.Data[BX+2],ES
  MOV AX,T
  MOV Word Ptr ES:[DI].BasicStruct.Data[BX+4],AX
 END;
 PushVarTLong:=True;
End;

Function VarExist(Var Q:BasicStruct;Const N:String):Boolean;
Var
 L,J:Word;
Begin
 J:=0;VarExist:=False;
 While Q.Data[J]<>0do Begin
  L:=DataSize[Q.Data[J]]+3;
  If Compare(Q.Data[L+J],N,Length(N)+1)Then Begin
   VarExist:=True;
   Exit;
  End;
  ASM
   MOV BX,J
   INC BX
   LES DI,Q
   MOV AX,Word Ptr ES:[DI].BasicStruct.Data[BX]
   MOV J,AX
  END;
 End;
End;

Function VarCode(Var Q:BasicStruct;Const N:String):Byte;
Var
 L,J:Word;
Begin
 J:=0;VarCode:=0;
 While Q.Data[J]<>0do Begin
  L:=DataSize[Q.Data[J]]+3;
  If Compare(Q.Data[L+J],N,Length(N)+1)Then Begin
   VarCode:=Q.Data[J];
   Exit;
  End;
  ASM
   MOV BX,J
   INC BX
   LES DI,Q
   MOV AX,Word Ptr ES:[DI].BasicStruct.Data[BX]
   MOV J,AX
  END;
 End;
End;

Function ReadVarInt(Var Q:BasicStruct;Const N:String):Integer;
Var
 L,J:Word;
Begin
 J:=0;
 While Q.Data[J]<>0do Begin
  L:=DataSize[Q.Data[J]]+3;
  If Compare(Q.Data[L+J],N,Length(N)+1)Then Begin
   ASM
    MOV BX,J
    ADD BX,3
    LES DI,Q
    MOV AX,Word Ptr ES:[DI].BasicStruct.Data[BX]
    MOV @Result,AX
   END;
   Exit;
  End;
  ASM
   MOV BX,J
   INC BX
   LES DI,Q
   MOV AX,Word Ptr ES:[DI].BasicStruct.Data[BX]
   MOV J,AX
  END;
 End;
 ReadVarInt:=0;
End;

Function ReadVarLong(Var Q:BasicStruct;Const N:String):LongInt;
Var
 L,J:Word;
Begin
 J:=0;
 While Q.Data[J]<>0do Begin
  L:=DataSize[Q.Data[J]]+3;
  If Compare(Q.Data[L+J],N,Length(N)+1)Then Begin
   ASM
    MOV BX,J
    ADD BX,3
    LES DI,Q
    LES AX,DWord Ptr ES:[DI].BasicStruct.Data[BX]
    MOV Word Ptr @Result,AX
    MOV Word Ptr @Result[2],ES
   END;
   Exit;
  End;
  ASM
   MOV BX,J
   INC BX
   LES DI,Q
   MOV AX,Word Ptr ES:[DI].BasicStruct.Data[BX]
   MOV J,AX
  END;
 End;
 ReadVarLong:=0;
End;

Function ReadVarReal(Var Q:BasicStruct;Const N:String):Real;
Var
 L,J:Word;
Begin
 J:=0;
 While Q.Data[J]<>0do Begin
  L:=DataSize[Q.Data[J]]+3;
  If Compare(Q.Data[L+J],N,Length(N)+1)Then Begin
   ASM
    MOV BX,J
    ADD BX,3
    LES DI,Q
    MOV AX,Word Ptr ES:[DI].BasicStruct.Data[BX]
    MOV Word Ptr @Result,AX
    MOV AX,Word Ptr ES:[DI].BasicStruct.Data[BX+2]
    MOV Word Ptr @Result[2],AX
    MOV AX,Word Ptr ES:[DI].BasicStruct.Data[BX+4]
    MOV Word Ptr @Result[4],AX
   END;
   Exit;
  End;
  ASM
   MOV BX,J
   INC BX
   LES DI,Q
   MOV AX,Word Ptr ES:[DI].BasicStruct.Data[BX]
   MOV J,AX
  END;
 End;
 ReadVarReal:=0.0;
End;

Function ReadVarString(Var Q:BasicStruct;Var N:String):String;
Var
 L,J:Word;
 P:Pointer;
Begin
 J:=0;
 While Q.Data[J]<>0do Begin
  L:=DataSize[Q.Data[J]]+3;
  If Compare(Q.Data[L+J],N,Length(N)+1)Then Begin
   ASM
    LES DI,@Result
    MOV Word Ptr P,DI
    MOV Word Ptr P[2],ES
   END;
   MoveLeft(Q.Data[J+3],P^,SizeOf(String));
   Exit;
  End;
  ASM
   MOV BX,J
   INC BX
   LES DI,Q
   MOV AX,Word Ptr ES:[DI].BasicStruct.Data[BX]
   MOV J,AX
  END;
 End;
 ReadVarString:='';
End;

Function AddrTLong(Var Q:BasicStruct;Var N:String;Var Size:Word):Pointer;
Var
 L,J:Word;
Begin
 J:=0;
 While Q.Data[J]<>0do Begin
  L:=DataSize[Q.Data[J]]+3;
  If(Q.Data[J]=DataTLong)and(Compare(Q.Data[L+J],N,Length(N)+1))Then Begin
   ASM
    MOV BX,J
    ADD BX,3
    LES DI,Q
    MOV AX,Word Ptr ES:[DI].BasicStruct.Data[BX]
    MOV DX,Word Ptr ES:[DI].BasicStruct.Data[BX+2]
    MOV Word Ptr @Result,AX
    MOV Word Ptr @Result[2],DX
    MOV AX,Word Ptr ES:[DI].BasicStruct.Data[BX+4]
    LES DI,Size
    STOSW
   END;
   Exit;
  End;
  ASM
   MOV BX,J
   INC BX
   LES DI,Q
   MOV AX,Word Ptr ES:[DI].BasicStruct.Data[BX]
   MOV J,AX
  END;
 End;
 AddrTLong:=NIL;
End;

Function SGN(Const V:Variant):Integer;
Var
 X:Real;
Begin
 X:=VariantToReal(V);
 If X<0.0Then SGN:=-1 Else
 If X=0.0Then SGN:=0
         Else SGN:=1;
End;

Function BasicFormuleOnWord(Var Obj;Const ThisWord:String;Var Context):Boolean;
Label
 ErrorInstr,_ABS,_ALTPRESS,_ASC,_ATN,_BUS,_BUTTON,_CAPSLOCK,_CBOOL,
 _CBYTE,_CDBL,_CLONG,_CMOS,_CMOSEXIST,_CMOSPORT,_CODEPAGE,_COLOR,
 _COMPUTERNAME,_COUNTRY,_CURRDISK,_COS,_CPU,_CSNG,_CSRLIN,_CTRLPRESS,
 _CVD,_CVI,_CVS,_DATE,_DAY,_DIGITS,_DIREXIST,_DOSVER,_EMSEXIST,
 _EMMNUMBERPAGE,_EMSSEG,_EMSSIZE,_EOF,_ERNO,_ERLIN,_EXP,_EXP2,_EXP10,_EXTSIZE,_FILEEXIST,_FIX,
 _FLOPPY,_FRE,_GRAF,_HARDDISK,_HEIGHTCHR,_INP,_INSERT,_INSTAT,_INSTR,_INT,
 _INTERRUPT,_JOYBIOS,_JOYEXIST,_JOYPORT,_JOYSTK,_KBDCTRL,_KBDMODEL,
 _KBDREADPORT,_KEYPRESS,_LEN,_LOG,_LOG2,_LOG10,_LPEEK,_LPT,_MEM,
 _MONITOR,_MONO,_MONTH,_MOUSEDRIVER,_MSBUTTON,_MSVER,_NEXTKEY,_NUMLOCK,_NUMXTEXTS,
 _NUMYTEXTS,_PEEK,_PMAP,_POINT,_POS,_PPOINT,_QBColor,_RAMCONV,_RAWTIMER,
 _READKEY,_REG,_RGB,_RND,_SCREEN,_SCROLLLOCK,_SERIAL,_SGN,_SHIFTPRESS,_SIN,
 _SOUNDMEM,_SPOOLER,_SQR,_STRIG,_SYSERR,_TAN,_TIM,_TIMER,_VAL,_VARPTR,
 _VIDEOCARD,_VARSEG,_VIDEOSTANDARD,_WIDTH,_WIDTHPIXEL,_MSGBOX,_XMSEXIST,
 _XMSSIZE,_YEAR,1,ContinueOk,_FREDefault,DefaultInStr,_MOUSE,
 _PushNumberByte,_PushNumberLong,_PushNumberWord,_PushNumberByteValue;
Var
 Q:FormulaObject Absolute Obj;
 BR:BasicStruct Absolute Context;
 L:LongInt;               { Variable temporaire entier long }
 W:Word Absolute L;       { Variable temporaire entier }
 BV:Byte Absolute L;      { Variable temporaire octet }
 LenParam:Integer;        { Nombre de paramätres }
 JP:Integer;              { Compteur de paramätres }
 IP:Word;                 { Position de variable ÆVariantØ }
 SP:Word;                 { Position de variable ÆStringØ }
 OpenPar:Boolean;         { Ouverture de parenthäse? }
 A,B,C:Variant;
 V:Array[0..7]of Variant;
 S:Array[0..1]of String;
 Ok:Boolean;
 PC2:Pointer;
 Param:^String;
Begin
 BasicFormuleOnWord:=False;
 If ThisWord=''Then Exit;
 If ThisWord='AND'Then Begin
  Q.PostFixeData.OperTitle:='Ô';
  Q.PostFixeData.Priorite:=2;
  BasicFormuleOnWord:=True;
  Exit;
 End;
 If(ThisWord='TO')or(ThisWord='OR')or(ThisWord='AND')or(ThisWord='THEN')or(ThisWord='STEP')Then Begin
  Q.StopNow:=True;
  Exit;
 End;
 If DBLocateAbsIM(BR.Fonction,2,ThisWord,[])Then Begin
  Param:=Pointer(BR.Fonction.CurrRec);
  _DBGotoColumnAbs(BR.Fonction.FieldRec,3,Pointer(Param));
  SP:=0;IP:=0;LenParam:=Length(Param^);
  If LenParam>0Then Begin
   For JP:=0to 7do V[JP].TypeDef:=dtNoType;
  End;
  OpenPar:=False;
  For JP:=1to(LenParam)do Begin
   ASM
    INC Word Ptr Param
   END;
   Case Param^[0]of
    #0:Break;
    '|':Begin
     SkipSpcInLn(Q.I,Q.Formula);
     If JP=1Then Begin
      If(Length(Q.Formula)<Q.I)Then Break;
      If StrI(Q.I,Q.Formula)<>'('Then Break;
     End;
     If StrI(Q.I,Q.Formula)=')'Then Begin
      Inc(Q.I);
      Break;
     End;
    End;
    'I','N','R','V':Begin
     BR.X:=Q.I-1;
     If Not Num(BR,V[IP])Then Begin
      If Param^[0]='V'Then Begin
       BR.X:=Q.I-1;
       If Not _Str2S(BR,S[SP])Then Exit;
       Q.I:=BR.X+1;
       Inc(SP);
       V[IP].TypeDef:=dtString;
      End
       Else
      Exit;
     End;
     Q.I:=BR.X+1;
     Case Param^[0]of
      'I':Begin
       V[IP].X.DataLong:=VariantToInt(V[IP]);
       V[IP].TypeDef:=dtInt;
      End;
      'R':Begin
       V[IP].X.DataReal:=VariantToReal(V[IP]);
       V[IP].TypeDef:=dtReal;
      End;
     End;
     Inc(IP);
     If IP>7Then Break;
    End;
    'S':Begin
     BR.X:=Q.I-1;
     If Not _Str2S(BR,S[SP])Then Exit;
     Q.I:=BR.X+1;
     Inc(SP);
    End;
    Else Begin
     SkipSpcInLn(Q.I,Q.Formula);
     If StrI(Q.I,Q.Formula)<>Param^[0]Then Begin
      Case Param^[0]of
       '(':Goto ContinueOk;
       ',':BR.ExitCode:=VirguleExpected;
       ')':If(OpenPar)Then BR.ExitCode:=CloseParExpected
                      Else Goto ContinueOk;
       '-':BR.ExitCode:=MinusExpected;
       Else BR.ExitCode:=SyntaxError;
      End;
      Exit;
     End
      Else
     If Param^[0]='('Then OpenPar:=True;
     Inc(Q.I);
ContinueOk:
    End;
   End;
  End;
  ASM
   LES DI,BR
   LES DI,ES:[DI].BasicStruct.Fonction.CurrRec
   MOV BL,ES:[DI]
   JMP @Next
@Label:
   DW Offset ErrorInstr     { 0 }
   DW Offset _ABS           { 1 }
   DW Offset _ALTPRESS      { 2 }
   DW Offset _ASC           { 3 }
   DW Offset _BUS           { 4 }
   DW Offset _BUTTON        { 5 }
   DW Offset _CAPSLOCK      { 6 }
   DW Offset _CMOS          { 7 }
   DW Offset _CMOSEXIST     { 8 }
   DW Offset _CMOSPORT      { 9 }
   DW Offset _CODEPAGE      { A }
   DW Offset _COLOR         { B }
   DW Offset _COMPUTERNAME  { C }
   DW Offset _COUNTRY       { D }
   DW Offset _CURRDISK      { E }
   DW Offset _COS           { F }
   DW Offset _CPU           { 10 }
   DW Offset _CSRLIN        { 11 }
   DW Offset _CTRLPRESS     { 12 }
   DW Offset _DATE          { 13 }
   DW Offset _DIGITS        { 14 }
   DW Offset _DIREXIST      { 15 }
   DW Offset _DOSVER        { 16 }
   DW Offset _EMSEXIST      { 17 }
   DW Offset _EMMNUMBERPAGE { 18 }
   DW Offset _EMSSEG        { 19 }
   DW Offset _EMSSIZE       { 1A }
   DW Offset _EXTSIZE       { 1B }
   DW Offset _FILEEXIST     { 1C }
   DW Offset _FLOPPY        { 1D }
   DW Offset _FRE           { 1E }
   DW Offset _GRAF          { 1F }
   DW Offset _HARDDISK      { 20 }
   DW Offset _HEIGHTCHR     { 21 }
   DW Offset _INP           { 22 }
   DW Offset _INSERT        { 23 }
   DW Offset _INSTAT        { 24 }
   DW Offset _INSTR         { 25 }
   DW Offset _INTERRUPT     { 26 }
   DW Offset _JOYBIOS       { 27 }
   DW Offset _JOYEXIST      { 28 }
   DW Offset _JOYPORT       { 29 }
   DW Offset _KBDCTRL       { 2A }
   DW Offset _KBDMODEL      { 2B }
   DW Offset _KBDREADPORT   { 2C }
   DW Offset _KEYPRESS      { 2D }
   DW Offset _LEN           { 2E }
   DW Offset _LPT           { 2F }
   DW Offset _MONITOR       { 30 }
   DW Offset _MONO          { 31 }
   DW Offset _MOUSEDRIVER   { 32 }
   DW Offset _MSBUTTON      { 33 }
   DW Offset _MSVER         { 34 }
   DW Offset _NEXTKEY       { 35 }
   DW Offset _NUMLOCK       { 36 }
   DW Offset _NUMXTEXTS     { 37 }
   DW Offset _NUMYTEXTS     { 38 }
   DW Offset _CBOOL         { 39 }
   DW Offset _POINT         { 3A }
   DW Offset _RAMCONV       { 3B }
   DW Offset _RAWTIMER      { 3C }
   DW Offset _READKEY       { 3D }
   DW Offset _REG           { 3E }
   DW Offset _SCREEN        { 3F }
   DW Offset _SCROLLLOCK    { 40 }
   DW Offset _SERIAL        { 41 }
   DW Offset _SHIFTPRESS    { 42 }
   DW Offset _SIN           { 43 }
   DW Offset _SOUNDMEM      { 44 }
   DW Offset _SPOOLER       { 45 }
   DW Offset _SYSERR        { 46 }
   DW Offset _TAN           { 47 }
   DW Offset _TIMER         { 48 }
   DW Offset _VAL           { 49 }
   DW Offset _VARPTR        { 4A }
   DW Offset _VIDEOCARD     { 4B }
   DW Offset _VARSEG        { 4C }
   DW Offset _VIDEOSTANDARD { 4D }
   DW Offset _WIDTH         { 4E }
   DW Offset _WIDTHPIXEL    { 4F }
   DW Offset _XMSEXIST      { 50 }
   DW Offset _XMSSIZE       { 51 }
   DW Offset _MSGBOX        { 52 }
   DW Offset _RGB           { 53 }
   DW Offset _ATN           { 54 }
   DW Offset ErrorInstr     { 55: BRK }
   DW Offset _CDBL          { 56 }
   DW Offset _DAY           { 57 }
   DW Offset ErrorInstr     { 58: COM }
   DW Offset _CSNG          { 59 }
   DW Offset _CVD           { 5A }
   DW Offset _CVI           { 5B }
   DW Offset _CVS           { 5C }
   DW Offset ErrorInstr     { 5D: DBL }
   DW Offset _EOF           { 5E: EOF }
   DW Offset _ERLIN         { 5F: ERLIN }
   DW Offset _ERNO          { 60: ERNO }
   DW Offset ErrorInstr     { 61: ERR }
   DW Offset ErrorInstr     { 62: ERROR }
   DW Offset _EXP           { 63 }
   DW Offset _FIX           { 64 }
   DW Offset _QBColor       { 65 }
   DW Offset _INT           { 66 }
   DW Offset _JOYSTK        { 67 }
   DW Offset ErrorInstr     { 68: LOC }
   DW Offset ErrorInstr     { 69: LOF }
   DW Offset _LOG           { 6A }
   DW Offset _LPEEK         { 6B }
   DW Offset ErrorInstr     { 6C: LPOS }
   DW Offset _MEM           { 6D }
   DW Offset _PEEK          { 6E }
   DW Offset _PMAP          { 6F }
   DW Offset _POS           { 70 }
   DW Offset _PPOINT        { 71 }
   DW Offset _RND           { 72 }
   DW Offset _SGN           { 73 }
   DW Offset _SQR           { 74 }
   DW Offset _STRIG         { 75 }
   DW Offset ErrorInstr     { 76: TAB }
   DW Offset ErrorInstr     { 77: USR }
   DW Offset _CBYTE         { 78 }
   DW Offset _CLONG         { 79 }
   DW Offset _EXP10         { 7A }
   DW Offset _EXP2          { 7B }
   DW Offset _LOG10         { 7C }
   DW Offset _LOG2          { 7D }
   DW Offset _TIM           { 7E }
   DW Offset _YEAR          { 7F }
   DW Offset _MONTH         { 80 }
   DW Offset _MOUSE         { 81 }
@Next:
   AND BX,000FFh
   SHL BX,1
   JMP @Label.Word[BX]
  END;
ErrorInstr:
  BR.ExitCode:=brErrorInstr;
  Exit;
_ABS:
  Case(V[0].TypeDef)of
   dtReal:FOPushNumberReal(Q,Abs(V[0].X.DataReal));
   dtLong:FOPushNumberLong(Q,Abs(V[0].X.DataLong));
   Else FOPushNumberLong(Q,Abs(V[0].X.DataInt));
  End;
  Goto 1;
_ALTPRESS:
  ASM
   CALL AltPress
   JMP _PushNumberByteValue
  END;
_ASC:
  BV:=Byte(StrI(1,S[0]));
  Goto _PushNumberByte;
_ATN:
  FOPushNumberReal(Q,ArcTan(V[0].X.DataReal));
  Goto 1;
_BUS:
  ASM
   MOV AL,Bus
   JMP _PushNumberByteValue
  END;
_BUTTON:
  BV:=Byte(Button(V[0].X.DataInt));
  Goto _PushNumberByte;
_CAPSLOCK:
  ASM
   CALL GetCapsLck
   JMP _PushNumberByteValue
  END;
_CBOOL:
  Case(V[0].TypeDef)of
   dtBool:FOPushNumberBool(Q,V[0].X.DataBool);
   dtReal:FOPushNumberBool(Q,Trunc(V[0].X.DataReal)=0);
   Else FOPushNumberBool(Q,V[0].X.DataLong=0);
  End;
  Goto 1;
_CBYTE:
  Case(V[0].TypeDef)of
   dtBool:BV:=BasicBoolean(V[0].X.DataBool);
   dtReal:BV:=Byte(Trunc(V[0].X.DataReal));
   dtString:BV:=Byte(StrToInt(S[0]));
   Else BV:=Byte(V[0].X.DataLong);
  End;
  Goto _PushNumberByte;
_CDBL:
_CSNG:
  FOPushNumberReal(Q,V[0].X.DataReal);
  Goto 1;
_CLONG:
  Case(V[0].TypeDef)of
   dtBool:L:=BasicBoolean(V[0].X.DataBool);
   dtString:L:=StrToInt(S[0]);
   Else L:=VariantToInt(V[0]);
  End;
  Goto _PushNumberLong;
_CMOS:
  ASM
   MOV AL,CtrlCmos
   JMP _PushNumberByteValue
_CMOSEXIST:
   CALL CmosExist
   JMP _PushNumberByteValue
  END;
_CMOSPORT:
  W:=CmosPort;
  Goto _PushNumberWord;
_CODEPAGE:
  W:=CodePage;
  Goto _PushNumberWord;
_COLOR:
  If(IsKr)Then BV:=Byte(GetNmColors)
          Else BV:=0;
  Goto _PushNumberByte;
_COMPUTERNAME:
  W:=ComputerName;
  Goto _PushNumberWord;
_COUNTRY:
  W:=CountryCode;
  Goto _PushNumberWord;
_CURRDISK:
  ASM
    { GetDsk }
   MOV AH,19h
   INT 21h
   JMP _PushNumberByteValue
  END;
_COS:
  FOPushNumberReal(Q,Cos(V[0].X.DataReal));
  Goto 1;
_CPU:
  ASM
   MOV AL,CPU
   JMP _PushNumberByteValue
_CSRLIN:
   CALL GetYTxtsPos
   JMP _PushNumberByteValue
_CTRLPRESS:
   CALL CtrlPress
   JMP _PushNumberByteValue
  END;
_CVD:
_CVS:
  L:=StrToInt(S[0]);
  Goto _PushNumberLong;
_CVI:
  W:=StrToWord(S[0]);
  Goto _PushNumberWord;
_DATE:
  ASM
   CALL Date
   JMP _PushNumberByteValue
  END;
_DAY:
  Case(V[0].TypeDef)of
   dtLong:BV:=V[0].X.DataInt;
   dtString:SplitDate(S[0],A.X.DataWord,B.X.DataByte,BV);
   Else BV:=0;
  End;
  Goto _PushNumberByte;
_DIGITS:
  ASM
   MOV AL,Digits
   JMP _PushNumberByteValue
  END;
_DIREXIST:
  BV:=Byte(DirExist(S[0]));
  Goto _PushNumberByte;
_DOSVER:
  W:=GetDosVer;
  Goto _PushNumberWord;
_EMSEXIST:
  ASM
   MOV AL,EmmExist
   JMP _PushNumberByteValue
  END;
_EMMNUMBERPAGE:
  W:=EmmNumPage;
  Goto _PushNumberWord;
_EMSSEG:
  W:=EmmSeg;
  Goto _PushNumberWord;
_EMSSIZE:
  W:=EmmTotalSize;
  Goto _PushNumberWord;
_EOF:
  V[1].X.DataInt:=NumberToHandle(BR,V[0].X.DataInt);
  BV:=Byte(GetFilePos(V[1].X.DataInt)>=FileSize(V[1].X.DataInt));
  Goto _PushNumberByte;
_ERLIN:
  W:=BR.ErrLine;
  Goto _PushNumberWord;
_ERNO:
  W:=BR.ExitCode;
  Goto _PushNumberWord;
_EXP:
  FOPushNumberReal(Q,Exp(V[0].X.DataReal));
  Goto 1;
_EXP2:
  FOPushNumberReal(Q,IntPower(V[0].X.DataReal,2));
  Goto 1;
_EXP10:
  FOPushNumberReal(Q,IntPower(V[0].X.DataReal,10));
  Goto 1;
_EXTSIZE:
  W:=ExtBiosSizeK;
  Goto _PushNumberWord;
_FILEEXIST:
  BV:=Byte(FileExist(S[0]));
  Goto _PushNumberByte;
_FIX:
  L:=Round(V[0].X.DataReal);
  Goto _PushNumberLong;
_FLOPPY:
  ASM
   MOV AL,NmFloppyDsk
   JMP _PushNumberByteValue
  END;
_FRE:
  If(V[0].TypeDef=dtNoType)Then Goto _FREDefault;
  Case(V[0].X.DataInt)of
   -115:L:=AppResFree(rmExtBios);
   -114:L:=AppResFree(rmVram);
   -113:L:=AppResFree(rmXms);
   -112:L:=AppResFree(rmEms);
   -111:L:=AppResFree(rmDsk);
   -110:L:=AppResFree(rmAllRes);
   -101:L:=MaxAvail;
   -100:L:=MemAvail;
   -2:ASM
    MOV Word Ptr L[0],SP
    MOV Word Ptr L[2],0
   END;
   Else _FREDefault:L:=SizeOf(BR.Data)-BR.CurData;
  End;
  Goto _PushNumberLong;
_GRAF:
  ASM
   CALL IsGraf
   JMP _PushNumberByteValue
_HARDDISK:
   MOV AL,NmHardDsk
   JMP _PushNumberByteValue
_HEIGHTCHR:
   CALL HeightChr
   JMP _PushNumberByteValue
_INP:
   MOV DX,V[0].Variant.X.DataInt
   IN AL,DX
   JMP _PushNumberByteValue
_INSERT:
   CALL GetModeIns
   JMP _PushNumberByteValue
  END;
_INSTR:
  Case(V[0].TypeDef)of
   dtLong:If V[0].X.DataLong=1Then BV:=Pos(StrUp(S[1]),StrUp(S[0]))
                              Else Goto DefaultInStr;
   dtString:Goto DefaultInStr;
   Else DefaultInStr:BV:=Pos(S[1],S[0]);
  End;
  Goto _PushNumberByte;
_INSTAT:
  If(KeyPress)Then L:=-1
              Else L:=0;
  Goto _PushNumberLong;
_INT:
  Case(V[0].TypeDef)of
   dtString:L:=StrToInt(S[0]);
   dtLong:L:=V[0].X.DataLong;
   Else L:=Trunc(V[0].X.DataReal);
  End;
  {L:=Trunc(V[0].X.DataReal);}
  Goto _PushNumberLong;
_INTERRUPT:
  GetIntVec(V[0].X.DataInt,Pointer(PC2));
  L:=LongInt(PC2);
  Goto _PushNumberLong;
_JOYBIOS:
  ASM
   MOV AL,BiosJoy
   JMP _PushNumberByteValue
_JOYEXIST:
   MOV AL,JoyExist
   JMP _PushNumberByteValue
  END;
_JOYPORT:
  W:=JoyPort;
  Goto _PushNumberWord;
_JOYSTK:
  L:=JoyPos(V[0].X.DataInt);
  Goto _PushNumberLong;
_KBDCTRL:
  ASM
   MOV AL,KbdCtrl
   JMP _PushNumberByteValue
_KBDMODEL:
   MOV AL,KbdModel
   JMP _PushNumberByteValue
  END;
_KBDREADPORT:
  W:=KbdReadPort;
  Goto _PushNumberWord;
_KEYPRESS:
  ASM
   CALL KeyPress
   JMP _PushNumberByteValue
  END;
_LEN:
  BV:=Length(S[0]);
  Goto _PushNumberByte;
_LOG:
  FOPushNumberReal(Q,LN(V[0].X.DataReal));
  Goto 1;
_LOG2:
  FOPushNumberReal(Q,Log(2,V[0].X.DataReal));
  Goto 1;
_LOG10:
  FOPushNumberReal(Q,Log10(V[0].X.DataReal));
  Goto 1;
_LPEEK:
  BV:=Mem[V[0].X.IntHi shl 12:V[0].X.DataInt];
  Goto _PushNumberByte;
_LPT:
  ASM
   MOV AL,NmLPT
   JMP _PushNumberByteValue
  END;
_MEM:
  W:=SizeOf(BR.Data)-BR.CurData;
  Goto _PushNumberWord;
_MONITOR:
  ASM
   CALL GetVideoMonitor
   JMP _PushNumberByteValue
_MONO:
   CALL IsMono
   JMP _PushNumberByteValue
  END;
_MONTH:
  Case(V[0].TypeDef)of
   dtLong:BV:=V[0].X.DataInt;
   dtString:SplitDate(S[0],A.X.DataWord,BV,B.X.DataByte);
   Else BV:=0;
  End;
  Goto _PushNumberByte;
_MOUSE:
  Case(V[0].X.DataInt)of
   0:W:=Byte(__GetMouseButton<>0);
   5:W:=__GetMouseXPixels;
   6:W:=__GetMouseYPixels;
  End;
  Goto _PushNumberWord;
_MOUSEDRIVER:
  ASM
   MOV AL,Adele.Mouse
   JMP _PushNumberByteValue
  END;
_MSBUTTON:
  W:=MsButton;
  Goto _PushNumberWord;
_MSGBOX:
  Case(V[0].X.DataInt)of
   1:A.X.DataByte:=KeyOk+KeyCancel;
   2:A.X.DataByte:=KeyRetry+KeyIgnore+KeyAbort;
   3:A.X.DataByte:=KeyYes+KeyNo+KeyCancel;
   4:A.X.DataByte:=KeyYes+KeyNo;
   5:A.X.DataByte:=KeyRetry+KeyAbort;
   Else A.X.DataByte:=KeyOk;
  End;
  W:=InputMsg(S[1],S[0],A.X.DataByte,0,CurrKrs.RemWin);
  Case(W)of
   kbOk:W:=1;
   kbCancel:W:=2;
   kbAbort:W:=3;
   kbRetry:W:=4;
   kbIgnore:W:=5;
   kbYes:W:=6;
   kbNo:W:=7;
  End;
  Goto _PushNumberWord;
_MSVER:
  W:=MouseVer;
  Goto _PushNumberWord;
_NEXTKEY:
  W:=NxtKey;
  Goto _PushNumberWord;
_NUMLOCK:
  ASM
   CALL GetNmLck
   JMP _PushNumberByteValue
_NUMXTEXTS:
   CALL NmXTxts
   JMP _PushNumberByteValue
_NUMYTEXTS:
   CALL NmYTxts
   JMP _PushNumberByteValue
  END;
_PEEK:
  BV:=Mem[BR.SegBas:V[0].X.DataInt];
  Goto _PushNumberByte;
_PMAP:
  Case Word(V[1].X.DataInt)of
   0:Inc(V[0].X.DataInt,WEGetRX1(BR.W)shl 3);
   1:Inc(V[0].X.DataInt,GetRawY(WEGetRY1(BR.W)));
   2:Dec(V[0].X.DataInt,WEGetRX1(BR.W)shl 3);
   3:Dec(V[0].X.DataInt,GetRawY(WEGetRY1(BR.W)));
  End;
  L:=V[0].X.DataInt;
  Goto _PushNumberLong;
_POINT:
  If(V[1].TypeDef<>dtNoType)Then Begin
   W:=GetPixel(V[0].X.DataInt,V[1].X.DataInt);
  End
   Else
  Case Word(V[0].X.DataInt)of
   0,2:W:=VidBnkSwitch.XL;
   1,3:W:=VidBnkSwitch.YL;
  End;
  Goto _PushNumberWord;
_POS:
  Case(V[0].X.DataInt)of
   0:L:=GetXCurPos; { Ecran }
   {-2: Imprimante }
   Else L:=-1;
  End;
  Goto _PushNumberLong;
_PPOINT:
  L:=BasicPPoint(BR,V[0].X.DataInt,V[1].X.DataInt);
  Goto _PushNumberLong;
_QBColor:
  L:=GetClassicToColor(V[0].X.DataInt);
  Goto _PushNumberLong;
_RAMCONV:
  W:=MemTotalSize;
  Goto _PushNumberWord;
_RAWTIMER:
  L:=GetRawTimer;
  Goto _PushNumberLong;
_READKEY:
  If(BR.ViewMenu)Then BasicXChgMenu(BR.Menu);
  W:=PMWaitForMnuAction;
  If(BR.ViewMenu)Then BasicXChgMenu(BR.Menu);
  Goto _PushNumberWord;
_REG:
  Case(V[0].X.DataInt)of
   0:W:=BR.Regs.Flags;
   1:W:=BR.Regs.AX;
   2:W:=BR.Regs.BX;
   3:W:=BR.Regs.CX;
   4:W:=BR.Regs.DX;
   5:W:=BR.Regs.SI;
   6:W:=BR.Regs.DI;
   7:W:=BR.Regs.BP;
   8:W:=BR.Regs.DS;
   9:W:=BR.Regs.ES;
   Else Begin
    BR.ExitCode:=InvalidFunctionCall;
    Exit;
   End;
  End;
  Goto _PushNumberWord;
_RGB:
  L:=RGB2Color(V[0].X.DataInt,V[1].X.DataInt,V[2].X.DataInt);
  Goto _PushNumberLong;
_RND:
  If(V[0].TypeDef=dtNoType)Then FOPushNumberReal(Q,Random(10000)/10000)
   Else
  Begin
   FOPushNumberLong(Q,Random(V[0].X.DataInt));
  End;
  Goto 1;
_SCREEN:
  If(V[2].TypeDef<>dtNoType)Then Begin
   If V[2].X.DataInt<>0Then BV:=GetAttr(V[0].X.DataInt,V[1].X.DataInt)
                       Else BV:=Byte(GetChr(V[0].X.DataInt,V[1].X.DataInt));
  End
   Else
  BV:=Byte(GetChr(V[0].X.DataInt,V[1].X.DataInt));
  Goto _PushNumberByte;
_SCROLLLOCK:
  ASM
   CALL GetScrollLck
   JMP _PushNumberByteValue
  END;
_SERIAL:
  L:=NmSerial;
  Goto _PushNumberLong;
_SGN:
  L:=Sgn(V[0]);
  Goto _PushNumberLong;
_SHIFTPRESS:
  ASM
   CALL ShiftPress
   JMP _PushNumberByteValue
  END;
_SIN:
  FOPushNumberReal(Q,Sin(V[0].X.DataReal));
  Goto 1;
_SOUNDMEM:
  W:=SoundMem;
  Goto _PushNumberWord;
_SPOOLER:
  ASM
   MOV AL,Spooler
   JMP _PushNumberByteValue
  END;
_SQR:
  FOPushNumberReal(Q,Sqrt(V[0].X.DataReal));
  Goto 1;
_STRIG:
  L:=BasicBoolean(Button(V[0].X.DataInt shr 1));
  Goto _PushNumberLong;
_SYSERR:
  W:=SysErr;
  Goto _PushNumberWord;
_TAN:
  If V[0].X.DataReal=0.0Then A.X.DataReal:=0.0
  Else A.X.DataReal:=Sin(V[0].X.DataReal)/Cos(V[0].X.DataReal);
  FOPushNumberReal(Q,A.X.DataReal);
  Goto 1;
_TIM:
  GetDate(V[1].X.DataWord,V[2].X.DataByte,V[3].X.DataByte,V[4].X.DataByte);
  GetTime(V[5].X.DataByte,V[6].X.DataByte,A.X.DataByte,B.X.DataByte);
  Case(V[0].X.DataInt)of
   0:W:=V[6].X.DataByte;
   1:W:=V[5].X.DataByte;
   2:W:=DayOfYear(V[1].X.DataWord,V[2].X.DataByte,V[3].X.DataByte);
   3:W:=V[1].X.DataWord;
   4:W:=A.X.DataByte;
   5:W:=V[2].X.DataByte;
   6:W:=V[3].X.DataByte;
   7:W:=V[4].X.DataByte;
   8:W:=B.X.DataByte;
   Else W:=0;
  End;
  Goto _PushNumberWord;
_TIMER:
  L:=(GetRawTimer*901)shr 14;
  Goto _PushNumberLong;
_VAL:
  L:=StrToInt(S[0]);
  Goto _PushNumberLong;
_VARPTR:
  SkipSpcInLn(Q.I,Q.Formula);
  If Q.Formula[Q.I]='('Then Inc(Q.I);
  BR.X:=Q.I-1;
  ExtractVarName(BR,S[0]);
  If Q.Formula[Q.I]=')'Then Inc(Q.I);
  BR.X:=Q.I-1;
  L:=OfsVar(BR,S[0]);
  Goto _PushNumberLong;
_VIDEOCARD:
  W:=GetVideoCard;
  Goto _PushNumberWord;
_VARSEG:
  If Q.Formula[Q.I]='('Then Inc(Q.I);
  BR.X:=Q.I-1;
  ExtractVarName(BR,S[0]);
  If Q.Formula[Q.I]=')'Then Inc(Q.I);
  L:=DSeg;
  Goto _PushNumberLong;
_VIDEOSTANDARD:
  ASM
   CALL GetVideoCardCat
   JMP _PushNumberByteValue
_WIDTH:
   CALL GetNmXTxts
   JMP _PushNumberByteValue
  END;
_WIDTHPIXEL:
  W:=BasicGetNumXPixels(BR);
  Goto _PushNumberWord;
_YEAR:
  Case(V[0].TypeDef)of
   dtLong:W:=V[0].X.DataInt;
   dtString:SplitDate(S[0],W,A.X.DataByte,B.X.DataByte);
   Else W:=0;
  End;
  Goto _PushNumberWord;
_XMSEXIST:
  ASM
   MOV AL,XmsExist
_PushNumberByteValue:
   MOV BV,AL
  END;
_PushNumberByte:
  ASM
   MOV Byte Ptr L[1],0
  END;
_PushNumberWord:
  ASM
   MOV Word Ptr L[2],0
  END;
_PushNumberLong:
  FOPushNumberLong(Q,L);
  Goto 1;
_XMSSIZE:
  W:=XmsTotalSize;
  Goto _PushNumberWord;
 End
  Else
 Begin
  S[0]:=ThisWord;
  Case Q.Formula[Q.I]of
   '&','!','#':Begin
    IncStr(S[0],Q.Formula[Q.I]);
    Inc(Q.I);
    ReadVar(BR,S[0],A);
    FOPushNumber(Q,A);
   End;
   '%':Begin
    Inc(Q.I);
    IncStr(S[0],'%');
    FOPushNumberLong(Q,ReadVarInt(BR,S[0]));
   End;
   '$':Begin
    BR.ExitCode:=TypeMistmatch;
    Exit;
   End;
'(','[':Begin
    BR.X:=Q.I;
    Inc(Q.I);
    A.TypeDef:=dtLong;
    If Not Num(BR,A)Then Exit;
    PC2:=AddrTLong(BR,S[0],C.X.DataWord);
    If(PC2=NIL)Then Begin
     BR.ExitCode:=VarNotFound;
     Exit;
    End;
    ASM
     LES DI,PC2
     MOV BX,A.X.DataInt
     {$IFOPT G+}
      SHL BX,2
     {$ELSE}
      SHL BX,1
      SHL BX,1
     {$ENDIF}
     LES AX,ES:[DI+BX]
     MOV Word Ptr A.X.DataLong,AX
     MOV Word Ptr A.X.DataLong[2],ES
    END;
    If Not(Q.Formula[Q.I]in[')',']'])Then Begin
     BR.ExitCode:=CloseParExpected;
     Exit;
    End;
    Inc(Q.I);
    FOPushNumberLong(Q,A.X.DataLong);
   End;
   Else Begin
    ReadVar(BR,S[0],A);
    FOPushNumber(Q,A);
    {FOPushNumberLong(Q,ReadVarLong(BR,S[0]));}
   End;
  End;
1:While StrI(Q.I,Q.Formula)in[#9,' ']do Inc(Q.I);
 End;
 BR.X:=Q.I-1;
 BasicFormuleOnWord:=True;
End;

Function Num(Var Q:BasicStruct;Var N:Variant):Boolean;
Var
 X:FormulaObject;
Begin
 FOInit(X);
 X.Option:=[foNumberBasic,foExpBasic];
 X.StopChar:=[',',':',';','''','<','=','>'];
 X.OnWord:=BasicFormuleOnWord;
 X.Context:=@Q;
 X.I:=Q.X+1;
 Num:=FOCompute(X,StrPas(Q.PC));
 Q.X:=X.I-1;
 N:=X.Result;
End;

Function BasicGetCurrDate:String;Near;
Var
 R:String;
 Year:Word;
 Month,Day,DayOfWeek:Byte;
Begin
 GetDate(Year,Month,Day,DayOfWeek);
 R:=Str0(Month,2);
 IncStr(R,'-');
 AddStr(R,Str0(Day,2));
 IncStr(R,'-');
 BasicGetCurrDate:=R+IntToStr(Year);
End;

Function _Str2S(Var Q:BasicStruct;Var S:String):Boolean;
Label
 0,1,ErrorInstr,_APP,_BIN,_CHR,_CURDIR,_DATE,_ENVIRON,_HEX,_INKEY,_LCASE,
 _FILELISTBOX,_LEFT,_LTRIM,_MID,_MKI,_MKL,_OCT,_REQUEST,_RIGHT,_RTRIM,
 _SPACE,_STR,_STRCONV,_STRING,_UCASE,_INPUTBOX,_TRIM,_ERDESCR,VarCheck;
Var
 T,T2:Variant;
 OI:Integer;
 V:Array[0..7]of Variant;
 ST:String;
 SR:Array[0..1]of String; { Paramätres rÇsultat }
 Param:^String;           { Paramätres }
 LenParam:Integer;        { Nombre de paramätres }
 JP:Integer;              { Compteur de paramätres }
 IP:Word;                 { Position de variable ÆVariantØ }
 SP:Word;                 { Position de variable ÆStringØ }
Begin
 _Str2S:=False;ST:='';
0:SkipSpc(Q.X,Q.PC);
 If Q.PC^[Q.X]='"'Then Begin
  Inc(Q.X);
  While Not(Q.PC^[Q.X]in[#0,'"'])do Begin
   IncStr(ST,Q.PC^[Q.X]);
   Inc(Q.X)
  End;
  Inc(Q.X)
 End
  Else
 Begin
  OI:=Q.X;
  PXtrkWord(Q,S);
  If S<>''Then Begin
   If Q.PC^[Q.X]='$'Then Begin
    Inc(Q.X);
    IncStr(S,'$');
   End;
   If DBLocateAbsIM(Q.FoncStr,1,S,[])Then Begin
    Param:=Pointer(Q.FoncStr.CurrRec);
    _DBGotoColumnAbs(Q.FoncStr.FieldRec,2,Pointer(Param));
    SP:=0;IP:=0;LenParam:=Length(Param^);
    If LenParam>0Then Begin
     For JP:=0to 7do V[JP].TypeDef:=dtNoType;
    End;
    For JP:=1to(LenParam)do Begin
     ASM
      INC Word Ptr Param
     END;
     Case Param^[0]of
      #0:Break;
      '|':Begin
       SkipSpc(Q.X,Q.PC);
       If Q.PC^[Q.X]=')'Then Begin
        Inc(Q.X);
        Break;
       End;
      End;
      'I','N','R':Begin
       If Not Num(Q,V[IP])Then Exit;
       Case Param^[0]of
        'I':Begin
         V[IP].X.DataLong:=VariantToInt(V[IP]);
         V[IP].TypeDef:=dtInt;
        End;
        'R':Begin
         V[IP].X.DataReal:=VariantToReal(V[IP]);
         V[IP].TypeDef:=dtReal;
        End;
       End;
       Inc(IP);
       If IP>7Then Break;
      End;
      'S':Begin
       If Not _Str2S(Q,SR[SP])Then Begin
        Q.X:=OI;
        Exit;
       End;
       Inc(SP);
      End;
      Else Begin
       SkipSpc(Q.X,Q.PC);
       If Q.PC^[Q.X]<>Param^[0]Then Begin
        Case Param^[0]of
         '(':Q.ExitCode:=OpenParExpected;
         ',':Q.ExitCode:=VirguleExpected;
         ')':Q.ExitCode:=CloseParExpected;
         '-':Q.ExitCode:=MinusExpected;
         '.':Q.ExitCode:=CommaExpected;
         Else Q.ExitCode:=SyntaxError;
        End;
        Q.X:=OI;
        Exit;
       End;
       Inc(Q.X);
      End;
     End;
    End;
    ASM
     LES DI,Q
     LES DI,ES:[DI].BasicStruct.FoncStr.CurrRec
     MOV BL,ES:[DI]
     JMP @Next
@Label:
     DW Offset ErrorInstr     { 0 }
     DW Offset _BIN           { 1 }
     DW Offset _CHR           { 2 }
     DW Offset _ENVIRON       { 3 }
     DW Offset _HEX           { 4 }
     DW Offset _INKEY         { 5 }
     DW Offset _LEFT          { 6 }
     DW Offset _MID           { 7 }
     DW Offset _OCT           { 8 }
     DW Offset _RIGHT         { 9 }
     DW Offset _SPACE         { A }
     DW Offset _STR           { B }
     DW Offset _STRING        { C }
     DW Offset _LCASE         { D }
     DW Offset _UCASE         { E }
     DW Offset _LTRIM         { F }
     DW Offset _RTRIM         { 10 }
     DW Offset _INPUTBOX      { 11 }
     DW Offset _APP           { 12 }
     DW Offset _FILELISTBOX   { 13 }
     DW Offset _MKI           { 14 }
     DW Offset _MKL           { 15 }
     DW Offset ErrorInstr     { 16 }
     DW Offset ErrorInstr     { 17 }
     DW Offset _REQUEST       { 18 }
     DW Offset _CURDIR        { 19 }
     DW Offset _STRCONV       { 1A }
     DW Offset _TRIM          { 1B }
     DW Offset _DATE          { 1C }
     DW Offset _ERDESCR       { 1D }
     DW Offset ErrorInstr     { 1E }
     DW Offset ErrorInstr     { 1F }
     DW Offset ErrorInstr     { 20 }
     DW Offset ErrorInstr     { 21 }
     DW Offset ErrorInstr     { 22 }
     DW Offset ErrorInstr     { 23 }
     DW Offset ErrorInstr     { 24 }
     DW Offset ErrorInstr     { 25 }
     DW Offset ErrorInstr     { 26 }
     DW Offset ErrorInstr     { 27 }
     DW Offset ErrorInstr     { 28 }
     DW Offset ErrorInstr     { 29 }
     DW Offset ErrorInstr     { 2A }
     DW Offset ErrorInstr     { 2B }
     DW Offset ErrorInstr     { 2C }
     DW Offset ErrorInstr     { 2D }
     DW Offset ErrorInstr     { 2E }
     DW Offset ErrorInstr     { 2F }
     DW Offset ErrorInstr     { 30 }
     DW Offset ErrorInstr     { 31 }
     DW Offset ErrorInstr     { 32 }
     DW Offset ErrorInstr     { 33 }
     DW Offset ErrorInstr     { 34 }
     DW Offset ErrorInstr     { 35 }
     DW Offset ErrorInstr     { 36 }
     DW Offset ErrorInstr     { 37 }
     DW Offset ErrorInstr     { 38 }
     DW Offset ErrorInstr     { 39 }
     DW Offset ErrorInstr     { 3A }
     DW Offset ErrorInstr     { 3B }
     DW Offset ErrorInstr     { 3C }
     DW Offset ErrorInstr     { 3D }
     DW Offset ErrorInstr     { 3E }
     DW Offset ErrorInstr     { 3F }
@Next:
     AND BX,003Fh
     SHL BX,1
     JMP @Label.Word[BX]
    END;
ErrorInstr:
    Q.ExitCode:=brErrorInstr;
    Exit;
_APP:
    PXtrkWord(Q,S);
    If S='EXENAME'Then AddStr(ST,Q.MainSource)Else
    If S='TITLE'Then AddStr(ST,Q.W.Title)
     Else
    Begin
     Q.ExitCode:=UnknownIdentifier;
     Exit;
    End;
    Goto 1;
_BIN:
    AddStr(ST,BinByte2Str(Hi(V[0].X.DataInt))+BinByte2Str(Lo(V[0].X.DataInt)));
    Goto 1;
_CHR:IncStr(ST,Chr(V[0].X.DataInt));
    Goto 1;
_CURDIR:
    GetDir(Drv2Dsk(StrI(1,SR[0])),SR[1]);
    AddStr(ST,SR[1]);
    Goto 1;
_DATE:
    AddStr(ST,BasicGetCurrDate);
    Goto 1;
_ENVIRON:
    AddStr(ST,GetEnv(SR[0]));
    Goto 1;
_ERDESCR:
    AddStr(ST,GetErrMsg(Q.ExitCode));
    Goto 1;
_FILELISTBOX:
    ST:=OpenWin(SR[0],SR[1]);
    Goto 1;
_HEX:
    AddStr(ST,HexWord2Str(V[0].X.DataInt));
    Goto 1;
_INKEY:
    If Q.InKeyB<>-1Then Begin
     IncStr(ST,Chr(Q.InKeyB));
     Q.InKeyB:=-1;
    End
     Else
    If(KeyPress)Then Begin
     OI:=ReadKey;
     IncStr(ST,Chr(OI));
     If Lo(OI)=0Then Q.InKeyB:=Hi(OI)
                Else Q.InKeyB:=-1;
    End;
    Goto 1;
_INPUTBOX:
    S:='';
    _WinInp(40,SR[1],SR[0],False,S);
    AddStr(ST,S);
    Goto 1;
_LCASE:
    AddStr(ST,StrDn(SR[0]));
    Goto 1;
_LEFT:
    AddStr(ST,Left(SR[0],V[0].X.DataInt));
    Goto 1;
_LTRIM:
    AddStr(ST,LTrim(SR[0]));
    Goto 1;
_MID:
    If(V[1].TypeDef=dtNoType)Then V[1].X.DataInt:=255;
    AddStr(ST,Copy(SR[0],V[0].X.DataInt,V[1].X.DataInt));
    Goto 1;
_MKI:
    AddStr(ST,IntToStr(V[0].X.DataInt));
    Goto 1;
_MKL:
    AddStr(ST,IntToStr(V[0].X.DataLong));
    Goto 1;
_OCT:
    AddStr(ST,OctWord2Str(V[0].X.DataInt));
    Goto 1;
_REQUEST:
  If Q.PC^[Q.X]='.'Then Begin
   Inc(Q.X);
   PXtrkWord(Q,SR[0]);
   If SR[0]='SERVERVARIABLES'Then Begin
    If _Str2S(Q,SR[1])Then Begin
     If SR[1]='URL'Then AddStr(ST,Q.MainSource);
    End;
   End;
  End;
  Goto 1;
_RIGHT:
    AddStr(ST,Copy(SR[0],Length(SR[0])-V[0].X.DataInt,V[0].X.DataInt));
    Goto 1;
_RTRIM:
    AddStr(ST,RTrim(SR[0]));
    Goto 1;
_SPACE:
    AddStr(ST,Spc(V[0].X.DataInt));
    Goto 1;
_STR:
    AddStr(ST,IntToStr(V[0].X.DataLong));
    Goto 1;
_STRCONV:
    Case(V[0].X.DataInt)of
     1:AddStr(ST,StrUp(SR[0]));
     2:AddStr(ST,StrDn(SR[0]));
    End;
    Goto 1;
_STRING:
    If Q.PC^[Q.X]<>'('Then Begin
     Q.X:=OI;
     Q.ExitCode:=OpenParExpected;
     Exit;
    End;
    Inc(Q.X);
    If Not Num(Q,T)Then Exit;
    If Q.PC^[Q.X]<>','Then Begin
     Q.X:=OI;
     Q.ExitCode:=VirguleExpected;
     Exit;
    End;
    Inc(Q.X);
    If Not _Str2S(Q,SR[0])Then Begin
     If Not Num(Q,T2)Then Exit;
     SR[0]:=Chr(T2.X.DataInt);
    End;
    If Q.PC^[Q.X]<>')'Then Begin
     Q.X:=OI;
     Q.ExitCode:=CloseParExpected;
     Exit;
    End;
    Inc(Q.X);
    AddStr(ST,MultChr(SR[0][1],T.X.DataInt));
    Goto 1;
   End
    Else
   If S[Length(S)]='$'Then Begin
    ST:=ReadVarString(Q,S);
   End
    Else
   Begin
    Q.X:=OI;
    Q.ExitCode:=SyntaxError;
    Exit;
   End;
   Goto 1;
_TRIM:
    AddStr(ST,Trim(SR[0]));
    Goto 1;
_UCASE:
   AddStr(ST,StrDn(S));
   {Goto 1;}
1:End
   Else
  Begin
   Q.X:=OI;
   Q.ExitCode:=SyntaxError;
   Exit;
  End;
 End;
 SkipSpc(Q.X,Q.PC);
 If Q.PC^[Q.X]in['&','+']Then Begin
  Inc(Q.X);
  Goto 0;
 End;
 S:=ST;
 _Str2S:=True;
End;

Function BasicInit(Var Q:BasicStruct):Boolean;Begin
 BasicInit:=False;
 FillClr(Q,SizeOf(Q));
 Q.InForm:=True;
 Q.Output:=errHdl;
 Q.Mode:=bmAll;
 Q.InKeyB:=-1;
 WEInit(Q.W,0,0,MaxXTxts,MaxYTxts);
 If(Q.CreateForm)Then Begin
  Q.Screen.X1:=0;
  Q.Screen.Y1:=0;
  Q.Screen.X2:=GetMaxXPixels;
  Q.Screen.Y2:=GetMaxYPixels;
 End;
 Q.W.Title:='Feuille Basic';
 DBOpenServerName(ChantalServer,'CHANTAL:/Compilateur/Basic/Instruction.Dat');
 If DBCopyToMemory(ChantalServer,Q.Instr)Then Begin
  DBOpenServerName(ChantalServer,'CHANTAL:/Compilateur/Basic/Fonction.Dat');
  If DBCopyToMemory(ChantalServer,Q.Fonction)Then Begin
   DBOpenServerName(ChantalServer,'CHANTAL:/Compilateur/Basic/FonctionString.Dat');
   BasicInit:=DBCopyToMemory(ChantalServer,Q.FoncStr);
  End;
 End;
End;

Function ASPInit(Var Q:BasicStruct;Const TargetName:String):Boolean;Begin
 ASPInit:=BasicInit(Q);
 Q.Mode:=bmASP;
 Q.NothingZone:=True;
 Q.Output:=FileCreate(TargetName);
End;

Procedure BasicSetMode(Var Q:BasicStruct);Begin
 If(Q.InForm)Then Begin
  WEPopWn(Q.W);
  Q.InForm:=False;
  __HideMousePtr;
  Q.OldMode:=CurrVideoMode;
  DialTimer:=False;
  {$IFDEF HeapVram}
   OldHeapVram:=HeapVram;
  {$ENDIF}
  __HideMousePtr;
  PushScr(Q.MS);
  {$IFDEF HeapVram}
   HeapVram:=False;
  {$ENDIF}
  PopScr(Output);
  If Not(IsGraf)Then SetBlink(False);
  ClrScrBlack;
  SetPosHome;
  SetCurPos(0,0);
  PushCur;
  SimpleCur;
 End;
End;

Procedure BasicUnsetMode(Var Q:BasicStruct);Begin
 If Not(Q.InForm)Then Begin
  SetUnderline(False);
  PushScr(Output);
  {$IFDEF HeapVram}
   HeapVram:=OldHeapVram;
  {$ENDIF}
  PopScr(Q.MS);
  __ShowMousePtr;
  DialTimer:=True;
 End;
 If(Q.InForm)and(Q.CreateForm)Then WEDone(Q.W);
End;

Function BasicRun(Var Q:BasicStruct;Var Source:ArrayList):Boolean;
Label
 _ATTR,_BAR,_BEEP,_BLOAD,_BORDER,_BSAVE,_BYE,_BYTESPERLINE,_CALL,
 _CAPSLOCK,_CHDIR,_CIRCLE,_CLEAR,_CLOSE,_CLS,_COLOR,_COPY,_CURSOR,
 _DATA,_DEF,_DELAY,_DIM,_DO,_DRAW,_ELSE,_END,_ERROR,_FOR,_FILECOPY,
 _FILLBOX,_FLASH,_GET,_GOSUB,_GOTO,_GR,_HOME,_HSCALE,_HTAB,_HCOLOR,
 _HPAINT,_HPRINT,_HRESET,_HPLOT,_HSET,_IF,_INPUT,_ITEM,_KEY,_KILL,
 _LET,_LOCATE,_LOOP,_LPRINT,_MENU,_MKDIR,_MLOAD,_MOTOR,_MOUSEPTR,
 _MOVETEXT,_NEXT,_NAME,_NEW,_NORMAL,_NUMLOCK,_ON,
 _OPEN,_OPTION,_OUT,_PAGE,_PALETTE,_PAINT,_PCOPY,_POKE,_PRESET,_PRINT,
 _PSET,_PUT,_RANDOMIZE,_READ,_REG,_REM,_RENDIR,_RESPONSE,_RESTORE,_RETURN,
 _RMDIR,_SCREEN,_SCROLLLOCK,_SEEK,_SENDKEYS,_SHELL,_SOUND,_SPLITSCREEN,
 _STOP,_SYSTEM,_VERTICALSCALE,_VIEW,_VISUALPAGE,_VTAB,_WAITRETRACE,_WEND,
 _WIDTH,_SET,_WHILE,_WRITE,_HSCREEN,_HLINE,NextLine,G1,G2,ErrorInstr,Xit,
 Whil1,UnknownInstr,1,_NextPrint,NoLineArg,VirguleNotFound,
 NormalRun,ASPNothingZone;
Var
 Size:Word;
 LabelStr:String[10];
 S,S2:String;
 A,B,C,D,E,F,G:Variant;
 V:Array[0..7]of Variant;
 SubCall:Pointer;
 Ok:Boolean;
 PC2,PC3:Pointer;
 IO,JO:Word;
 Param:^String;           { Paramätres }
 LenParam:Integer;        { Nombre de paramätres }
 SP:Byte;                 { Position de chaåne de caractäres }
 JP:Integer;              { Compteur de paramätres }
 IP:Word;                 { Position de variable }

 Function Test:Boolean;
 Label Restart;
 Var
  OI:Word;
  Op:(Nada,_And,_Or,_Xor);
  OkT:Boolean;
 Begin
  Test:=False;
  Op:=Nada;
  Ok:=False;
Restart:
  If _Str2S(Q,S)Then Begin
   Case Q.PC^[Q.X]of
    '=':Begin
     Inc(Q.X);
     If Not _Str2S(Q,S2)Then System.Exit;
     OkT:=S=S2;
    End;
    '>':Begin
     Inc(Q.X);
     If Q.PC^[Q.X]='='Then Begin
      Inc(Q.X);
      If Not _Str2S(Q,S2)Then System.Exit;
      OkT:=S>=S2;
     End
     Else Begin
      If Not _Str2S(Q,S2)Then System.Exit;
      OkT:=S>S2;
     End;
    End;
    '<':Begin
     Inc(Q.X);
     Case Q.PC^[Q.X]of
      '>':Begin
       Inc(Q.X);
       If Not _Str2S(Q,S2)Then System.Exit;
       OkT:=S<>S2;
      End;
      '=':Begin
       Inc(Q.X);
       If Not _Str2S(Q,S2)Then System.Exit;
       Okt:=S<=S2;
      End;
      Else Begin
       If Not _Str2S(Q,S2)Then System.Exit;
       OkT:=S<S2;
      End;
     End;
    End;
    Else Begin
     Q.ExitCode:=SyntaxError;
     System.Exit;
    End;
   End;
  End
   Else
  Begin
   If Not Num(Q,A)Then System.Exit;
   Case Q.PC^[Q.X]of
    '=':Begin
     Inc(Q.X);
     If Not Num(Q,B)Then System.Exit;
     OkT:=A.X.DataInt=B.X.DataInt;
    End;
    '>':Begin
     Inc(Q.X);
     If Q.PC^[Q.X]='='Then Begin
      Inc(Q.X);
      If Not Num(Q,B)Then System.Exit;
      OkT:=A.X.DataInt>=B.X.DataInt;
     End
     Else Begin
      If Not Num(Q,B)Then System.Exit;
      OkT:=A.X.DataInt>B.X.DataInt;
     End;
    End;
    '<':Begin
     Inc(Q.X);
     Case Q.PC^[Q.X]of
      '>':Begin
       Inc(Q.X);
       If Not Num(Q,B)Then System.Exit;
       OkT:=A.X.DataInt<>B.X.DataInt;
      End;
      '=':Begin
       Inc(Q.X);
       If Not Num(Q,B)Then System.Exit;
       Okt:=A.X.DataInt<=B.X.DataInt;
      End;
      Else Begin
       If Not Num(Q,B)Then System.Exit;
       OkT:=A.X.DataInt<B.X.DataInt;
      End;
     End;
    End;
    Else OkT:=A.X.DataInt<>0;
   End;
  End;
  Case(Op)of
   _And:Ok:=Ok and OkT;
   _Or:Ok:=Ok or OkT;
   _Xor:Ok:=Ok xor OkT;
   Else Ok:=OkT;
  End;
  OI:=Q.X;
  PXtrkWord(Q,S);
  If S<>''Then Begin
   If S='AND'Then Begin
    Op:=_And;
    Goto Restart;
   End;
   If S='OR'Then Begin
    Op:=_Or;
    Goto Restart;
   End;
   If S='XOR'Then Begin
    Op:=_Xor;
    Goto Restart;
   End;
   Q.X:=OI;
  End;
  Test:=True;
 End;

Begin
 BasicRun:=False;
 If Source.Count>0Then Begin
  ALSetPtr(Source,0);
  Repeat
   Q.PC:=ALGetCurrBuf(Source,Size);
   Q.X:=0;Q._Else:=0;
   If(Q.NothingZone)Then Begin
    If(Q.PC<>NIL)Then Begin
     While Not((Q.PC^[Q.X]='<')and(Q.PC^[Q.X+1]='%'))do Begin
      PutFileTxt(Q.Output,Q.PC^[Q.X]);
      Inc(Q.X);
ASPNothingZone:
      If Q.PC^[Q.X]=#0Then Break;
     End;
     If Q.PC^[Q.X]='<'Then Begin
      Inc(Q.X,2);
      Q.NothingZone:=False;
      Goto NormalRun;
     End;
    End;
    PutFileLn(Q.Output);
   End
    Else
   If(Q.PC<>NIL)Then Begin
NormalRun:
    SkipSpc(Q.X,Q.PC);
    LabelStr:='';
    While Q.PC^[Q.X]in['0'..'9']do Begin
     IncStr(LabelStr,Q.PC^[Q.X]);
     Inc(Q.X);
    End;
  1:SkipSpc(Q.X,Q.PC);
    While(Q.X<Size)do Begin
     If(BrkOn)Then ASM
      MOV @Result,brBreakPressed
      JMP Xit
     END;
     If IsRomanLetter(Q.PC^[Q.X])Then Begin
      PXtrkWord(Q,S);
      If DBLocateAbsIM(Q.Instr,2,S,[])Then Begin
       ASM
        LES DI,Q
        MOV AX,ES:[DI].BasicStruct.Mode
        LES DI,ES:[DI].BasicStruct.Instr.CurrRec
        AND AX,ES:[DI+1]
        JZ  UnknownInstr
       END;
       Param:=Pointer(Q.Instr.CurrRec);
       _DBGotoColumnAbs(Q.Instr.FieldRec,3,Pointer(Param));
       IP:=0;SP:=0;LenParam:=Length(Param^);
       For JP:=1to(LenParam)do Begin
        ASM
         INC Word Ptr Param
        END;
        Case Param^[0]of
         #0:Break;
         'I':Begin
          If Not Num(Q,V[IP])Then Goto Xit;
          Inc(IP);
          If IP>7Then Break;
         End;
         'S':Begin
          Case(SP)of
           1:If Not _Str2S(Q,S2)Then Goto Xit;
           Else If Not _Str2S(Q,S)Then Goto Xit;
          End;
          Inc(SP);
         End;
         Else Begin
          SkipSpc(Q.X,Q.PC);
          If Q.PC^[Q.X]<>Param^[0]Then Begin
           Case Param^[0]of
            '(':Q.ExitCode:=OpenParExpected;
            ',':Q.ExitCode:=VirguleExpected;
            ')':Q.ExitCode:=CloseParExpected;
            '-':Q.ExitCode:=MinusExpected;
            Else Q.ExitCode:=SyntaxError;
           End;
           Goto Xit;
          End;
          Inc(Q.X);
         End;
        End;
       End;
       ASM
        LES DI,Q
        LES DI,ES:[DI].BasicStruct.Instr.CurrRec
        MOV BL,ES:[DI]
        JMP @Next
 @Label:DW Offset ErrorInstr     { 0 }
        DW Offset _ATTR          { 1 }
        DW Offset _BAR           { 2 }
        DW Offset _BEEP          { 3 }
        DW Offset _BLOAD         { 4 }
        DW Offset _BORDER        { 5 }
        DW Offset _BSAVE         { 6 }
        DW Offset _BYE           { 7 }
        DW Offset _BYTESPERLINE  { 8 }
        DW Offset _CALL          { 9 }
        DW Offset _CAPSLOCK      { A }
        DW Offset _CHDIR         { B }
        DW Offset _CIRCLE        { C }
        DW Offset _CLEAR         { D }
        DW Offset _CLOSE         { E }
        DW Offset _CLS           { F }
        DW Offset _COLOR         { 10 }
        DW Offset _COPY          { 11 }
        DW Offset _CURSOR        { 12 }
        DW Offset _DATA          { 13 }
        DW Offset _DEF           { 14 }
        DW Offset _DELAY         { 15 }
        DW Offset _DIM           { 16 }
        DW Offset _DO            { 17 }
        DW Offset _DRAW          { 18 }
        DW Offset _ELSE          { 19 }
        DW Offset _END           { 1A }
        DW Offset _FOR           { 1B }
        DW Offset _FILLBOX       { 1C }
        DW Offset _FLASH         { 1D }
        DW Offset _GET           { 1E }
        DW Offset _GOSUB         { 1F }
        DW Offset _GOTO          { 20 }
        DW Offset _GR            { 21 }
        DW Offset _HOME          { 22 }
        DW Offset _HSCALE        { 23 }
        DW Offset _HTAB          { 24 }
        DW Offset _HCOLOR        { 25 }
        DW Offset _HPRINT        { 26 }
        DW Offset _HRESET        { 27 }
        DW Offset _HSET          { 28 }
        DW Offset _IF            { 29 }
        DW Offset _ITEM          { 2A }
        DW Offset _KILL          { 2B }
        DW Offset _LOCATE        { 2C }
        DW Offset _LOOP          { 2D }
        DW Offset _LPRINT        { 2E }
        DW Offset _MENU          { 2F }
        DW Offset _MKDIR         { 30 }
        DW Offset _MLOAD         { 31 }
        DW Offset _MOUSEPTR      { 32 }
        DW Offset _MOVETEXT      { 33 }
        DW Offset _NEXT          { 34 }
        DW Offset _NAME          { 35 }
        DW Offset _NEW           { 36 }
        DW Offset _NORMAL        { 37 }
        DW Offset _NUMLOCK       { 38 }
        DW Offset _OPEN          { 39 }
        DW Offset _OUT           { 3A }
        DW Offset _PAGE          { 3B }
        DW Offset _PALETTE       { 3C }
        DW Offset _PCOPY         { 3D }
        DW Offset _POKE          { 3E }
        DW Offset _PRESET        { 3F }
        DW Offset _PRINT         { 40 }
        DW Offset _PSET          { 41 }
        DW Offset _PUT           { 42 }
        DW Offset _RANDOMIZE     { 43 }
        DW Offset _REG           { 44 }
        DW Offset _REM           { 45 }
        DW Offset _RENDIR        { 46 }
        DW Offset _RETURN        { 47 }
        DW Offset _RMDIR         { 48 }
        DW Offset _SCREEN        { 49 }
        DW Offset _SCROLLLOCK    { 4A }
        DW Offset _SEEK          { 4B }
        DW Offset _SHELL         { 4C }
        DW Offset _SOUND         { 4D }
        DW Offset _SPLITSCREEN   { 4E }
        DW Offset _STOP          { 4F }
        DW Offset _SYSTEM        { 50 }
        DW Offset _VERTICALSCALE { 51 }
        DW Offset _VIEW          { 52 }
        DW Offset _VISUALPAGE    { 53 }
        DW Offset _VTAB          { 54 }
        DW Offset _WAITRETRACE   { 55 }
        DW Offset _WEND          { 56 }
        DW Offset _WIDTH         { 57 }
        DW Offset _WHILE         { 58 }
        DW Offset _WRITE         { 59 }
        DW Offset _HSCREEN       { 5A }
        DW Offset _HLINE         { 5B }
        DW Offset ErrorInstr     { 5C }
        DW Offset ErrorInstr     { 5D }
        DW Offset ErrorInstr     { 5E }
        DW Offset ErrorInstr     { 5F }
        DW Offset ErrorInstr     { 60 }
        DW Offset ErrorInstr     { 61 }
        DW Offset ErrorInstr     { 62 }
        DW Offset ErrorInstr     { 63 }
        DW Offset ErrorInstr     { 64 }
        DW Offset ErrorInstr     { 65 }
        DW Offset ErrorInstr     { 66 }
        DW Offset ErrorInstr     { 67 }
        DW Offset _ERROR         { 68: ERROR }
        DW Offset ErrorInstr     { 69 }
        DW Offset ErrorInstr     { 6A }
        DW Offset ErrorInstr     { 6B }
        DW Offset ErrorInstr     { 6C }
        DW Offset _HPAINT        { 6D }
        DW Offset _HPLOT         { 6E }
        DW Offset ErrorInstr     { 6F }
        DW Offset ErrorInstr     { 70 }
        DW Offset _INPUT         { 71 }
        DW Offset ErrorInstr     { 72 }
        DW Offset ErrorInstr     { 73 }
        DW Offset _KEY           { 74 }
        DW Offset _LET           { 75 }
        DW Offset ErrorInstr     { 76 }
        DW Offset ErrorInstr     { 77 }
        DW Offset ErrorInstr     { 78 }
        DW Offset ErrorInstr     { 79 }
        DW Offset ErrorInstr     { 7A }
        DW Offset ErrorInstr     { 7B }
        DW Offset ErrorInstr     { 7C }
        DW Offset ErrorInstr     { 7D }
        DW Offset ErrorInstr     { 7E }
        DW Offset _MOTOR         { 7F }
        DW Offset ErrorInstr     { 80 }
        DW Offset ErrorInstr     { 81 }
        DW Offset _PAINT         { 82 }
        DW Offset ErrorInstr     { 83 }
        DW Offset ErrorInstr     { 84 }
        DW Offset ErrorInstr     { 85 }
        DW Offset ErrorInstr     { 86 }
        DW Offset ErrorInstr     { 87 }
        DW Offset ErrorInstr     { 88 }
        DW Offset ErrorInstr     { 89 }
        DW Offset _READ          { 8A }
        DW Offset ErrorInstr     { 8B }
        DW Offset ErrorInstr     { 8C }
        DW Offset ErrorInstr     { 8D }
        DW Offset ErrorInstr     { 8E }
        DW Offset _RESTORE       { 8F }
        DW Offset ErrorInstr     { 90 }
        DW Offset ErrorInstr     { 91 }
        DW Offset ErrorInstr     { 92 }
        DW Offset _SET           { 93 }
        DW Offset ErrorInstr     { 94 }
        DW Offset ErrorInstr     { 95 }
        DW Offset ErrorInstr     { 96 }
        DW Offset ErrorInstr     { 97 }
        DW Offset ErrorInstr     { 98 }
        DW Offset ErrorInstr     { 99 }
        DW Offset ErrorInstr     { 9A }
        DW Offset ErrorInstr     { 9B }
        DW Offset ErrorInstr     { 9C }
        DW Offset ErrorInstr     { 9D }
        DW Offset ErrorInstr     { 9E }
        DW Offset ErrorInstr     { 9F }
        DW Offset ErrorInstr     { A0 }
        DW Offset ErrorInstr     { A1 }
        DW Offset _RESPONSE      { A2 }
        DW Offset _OPTION        { A3 }
        DW Offset _FILECOPY      { A4 }
        DW Offset _SENDKEYS      { A5 }
        DW Offset _ON            { A6: ON }
        DW Offset ErrorInstr     { A7 }
        DW Offset ErrorInstr     { A8 }
        DW Offset ErrorInstr     { A9 }
        DW Offset ErrorInstr     { AA }
        DW Offset ErrorInstr     { AB }
        DW Offset ErrorInstr     { AC }
        DW Offset ErrorInstr     { AD }
        DW Offset ErrorInstr     { AE }
        DW Offset ErrorInstr     { AF }
        DW Offset ErrorInstr     { B0 }
        DW Offset ErrorInstr     { B1 }
        DW Offset ErrorInstr     { B2 }
        DW Offset ErrorInstr     { B3 }
        DW Offset ErrorInstr     { B4 }
        DW Offset ErrorInstr     { B5 }
        DW Offset ErrorInstr     { B6 }
        DW Offset ErrorInstr     { B7 }
        DW Offset ErrorInstr     { B8 }
        DW Offset ErrorInstr     { B9 }
        DW Offset ErrorInstr     { BA }
        DW Offset ErrorInstr     { BB }
        DW Offset ErrorInstr     { BC }
        DW Offset ErrorInstr     { BD }
        DW Offset ErrorInstr     { BE }
        DW Offset ErrorInstr     { BF }
        DW Offset ErrorInstr     { C0 }
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
        DW Offset ErrorInstr     { D0 }
        DW Offset ErrorInstr     { D1 }
        DW Offset ErrorInstr     { D2 }
        DW Offset ErrorInstr     { D3 }
        DW Offset ErrorInstr     { D4 }
        DW Offset ErrorInstr     { D5 }
        DW Offset ErrorInstr     { D6 }
        DW Offset ErrorInstr     { D7 }
        DW Offset ErrorInstr     { D8 }
        DW Offset ErrorInstr     { D9 }
        DW Offset ErrorInstr     { DA }
        DW Offset ErrorInstr     { DB }
        DW Offset ErrorInstr     { DC }
        DW Offset ErrorInstr     { DD }
        DW Offset ErrorInstr     { DE }
        DW Offset ErrorInstr     { DF }
        DW Offset ErrorInstr     { E0 }
        DW Offset ErrorInstr     { E1 }
        DW Offset ErrorInstr     { E2 }
        DW Offset ErrorInstr     { E3 }
        DW Offset ErrorInstr     { E4 }
        DW Offset ErrorInstr     { E5 }
        DW Offset ErrorInstr     { E6 }
        DW Offset ErrorInstr     { E7 }
        DW Offset ErrorInstr     { E8 }
        DW Offset ErrorInstr     { E9 }
        DW Offset ErrorInstr     { EA }
        DW Offset ErrorInstr     { EB }
        DW Offset ErrorInstr     { EC }
        DW Offset ErrorInstr     { ED }
        DW Offset ErrorInstr     { EE }
        DW Offset ErrorInstr     { EF }
        DW Offset ErrorInstr     { F0 }
        DW Offset ErrorInstr     { F1 }
        DW Offset ErrorInstr     { F2 }
        DW Offset ErrorInstr     { F3 }
        DW Offset ErrorInstr     { F4 }
        DW Offset ErrorInstr     { F5 }
        DW Offset ErrorInstr     { F6 }
        DW Offset ErrorInstr     { F7 }
        DW Offset ErrorInstr     { F8 }
        DW Offset ErrorInstr     { F9 }
        DW Offset ErrorInstr     { FA }
        DW Offset ErrorInstr     { FB }
        DW Offset ErrorInstr     { FC }
        DW Offset ErrorInstr     { FD }
        DW Offset ErrorInstr     { FE }
        DW Offset ErrorInstr     { FF }
  @Next:XOR BH,BH
        SHL BX,1
        JMP @Label.Word[BX]
       END;
 _ATTR:If(Q.HScreen)Then Begin
        V[0].X.DataInt:=V[0].X.DataInt and 7;
        V[1].X.DataInt:=V[1].X.DataInt and 7;
        If Q.PC^[Q.X]=','Then Begin
         Inc(Q.X);
         PXtrkWord(Q,S);
         If Not((S='B')or(S='U'))Then Begin
          Q.ExitCode:=SyntaxError;
          Goto Xit;
         End;
         Case S[1]of
          'B':V[1].X.DataInt:=V[1].X.DataInt or 8;
          'U':V[0].X.DataInt:=V[0].X.DataInt or 8;
         End;
         If Q.PC^[Q.X]=','Then Begin
          Inc(Q.X);
          PXtrkWord(Q,S2);
          If Not((S2='B')or(S2='U'))Then Begin
           Q.ExitCode:=SyntaxError;
           Goto Xit;
          End;
          Case S2[1]of
          'B':V[1].X.DataInt:=V[1].X.DataInt or 8;
          'U':V[0].X.DataInt:=V[0].X.DataInt or 8;
          End;
         End;
        End;
       End;
       SetKr(V[0].X.DataInt+(V[1].X.DataInt shl 4));
       Goto 1;
 _BAR: BasicCreateForm(Q);
       SkipSpc(Q.X,Q.PC);
       PXtrkWord(Q,S);
       If S='SELECT'Then Begin
        If Not Num(Q,A)Then Goto Xit;
        If Q.PC^[Q.X]<>','Then Goto VirguleNotFound;
        Inc(Q.X);
        If Not Num(Q,B)Then Goto Xit;
        If Q.PC^[Q.X]<>','Then Goto VirguleNotFound;
        Inc(Q.X);
        If Not Num(Q,C)Then Goto Xit;
        If Q.PC^[Q.X]<>','Then Begin
VirguleNotFound:
         Q.ExitCode:=VirguleExpected;
         Goto Xit;
        End;
        Inc(Q.X);
        If Not Num(Q,D)Then Goto Xit;
        BarSelHor(A.X.DataInt,B.X.DataInt,C.X.DataInt,D.X.DataInt)
       End
        Else
       If(S='SPACE')or(S='SPC')Then Begin
        If Not Num(Q,A)Then Goto Xit;
        If Q.PC^[Q.X]<>','Then Goto VirguleNotFound;
        Inc(Q.X);
        If Not Num(Q,B)Then Goto Xit;
        If Q.PC^[Q.X]<>','Then Goto VirguleNotFound;
        Inc(Q.X);
        If Not Num(Q,C)Then Goto Xit;
        If Q.PC^[Q.X]<>','Then Goto VirguleNotFound;
        Inc(Q.X);
        If Not Num(Q,D)Then Goto Xit;
        BarSpcHor(A.X.DataInt,B.X.DataInt,C.X.DataInt,D.X.DataInt);
       End
        Else
       Begin
        Q.ExitCode:=ValueExpected;
        Goto Xit;
       End;
       Goto 1;
 _BEEP:Beep;
       Goto 1;
_BLOAD:If Q.PC^[Q.X]=','Then Begin
        Inc(Q.X);
        If Not Num(Q,A)Then Goto Xit;
        GetFile(S,0,GetFileSize(S),Mem[Q.SegBas:A.X.DataInt]);
       End
        Else
       GetFile(S,0,GetFileSize(S),Mem[Q.SegBas:0]);
       Goto 1;
_BORDER:
       SetBorderColor(V[0].X.DataInt);
       Goto 1;
_BSAVE:If(B.TypeDef=dtInt)Then B.X.IntHi:=0;
       SetFile(S,0,V[1].X.DataLong,Mem[Q.SegBas:V[0].X.DataInt]);
       Goto 1;
 _BYE: TimeOnLine:=GetRawTimer-TimeOnLine;
       A.X.DataInt:=DivLong(TimeOnLine,60*60);
       B.X.DataInt:=Word(DivLong(TimeOnLine,60))mod 60;
       C.X.DataInt:=TimeOnLine mod 60;
       _PutTxtLn(CStrTimeDos(A.X.DataInt,B.X.DataInt,C.X.DataInt)+' temps dans le programme');
       Q.ExitCode:=ExitProgramNow;
       Goto Xit;
_BYTESPERLINE:
       SetBytesPerLn(V[0].X.DataInt);
       Goto 1;
 _CALL:SkipSpc(Q.X,Q.PC);
       PXtrkWord(Q,S);
       If S='INTERRUPT'Then Begin
        If Not Num(Q,A)Then Goto Xit;
        Intr(A.X.DataInt,Q.Regs);
       End
        Else
       Begin
        If Q.PC^[Q.X]in['%','&','!','#','$']Then Begin
         IncStr(S,Q.PC^[Q.X]);
         Inc(Q.X)
        End;
        A.X.DataInt:=OfsVar(Q,S);
        If A.X.DataWord=$FFFFThen Begin
         Q.ExitCode:=VarNotFound;
         Goto Xit
        End;
        SubCall:=Ptr(DSeg,A.X.DataInt);
        ASM
         CALL SubCall;
        END;
       End;
       Goto 1;
_CAPSLOCK:
       SkipSpc(Q.X,Q.PC);
       PXtrkWord(Q,S);
       If S='ON'Then SetCapsLck(True)Else
       If S='OFF'Then SetCapsLck(False)
        Else
       Begin
        Q.ExitCode:=ValueExpected;
        Goto Xit;
       End;
       Goto 1;
_CHDIR:ChDir(S);
       Goto 1;
_CIRCLE:
       BasicCreateForm(Q);
       If Q.PC^[Q.X]=','Then Begin { Couleur }
        Inc(Q.X);
        If Not Num(Q,V[3])Then V[3].X.DataInt:=GraphColor;
       End
        Else
       V[3].X.DataInt:=GraphColor;
       If Q.PC^[Q.X]=','Then Begin
        Inc(Q.X);
        SkipSpc(Q.X,Q.PC);
        IO:=Q.X;
        PXtrkWord(Q,S);
        If S='F'Then Begin
         BasicFillCircle(Q,V[0].X.DataInt,V[1].X.DataInt,
                           V[2].X.DataInt,V[3].X.DataInt);
        End
         Else
        Begin
         Q.X:=IO;
         If Not Num(Q,V[4])Then V[4].X.DataInt:=0;
         SkipSpc(Q.X,Q.PC);
         If Q.PC^[Q.X]=','Then Begin
          Inc(Q.X);
          If Not Num(Q,V[5])Then V[5].X.DataInt:=0;
          If Q.PC^[Q.X]=','Then Begin
           Inc(Q.X);
           If Not Num(Q,V[6])Then V[6].X.DataInt:=0;
           BasicCircle(Q,V[0].X.DataInt,V[1].X.DataInt,V[2].X.DataInt,V[3].X.DataInt);
          End;
         End;
        End;
       End
        Else
       BasicCircle(Q,V[0].X.DataInt,V[1].X.DataInt,V[2].X.DataInt,V[3].X.DataInt);
       Goto 1;
_CLEAR:PXtrkWord(Q,S);
       If(S='KEYBOARD')or(S='KBD')Then Begin
        ClrKbd;
        Goto 1;
       End;
       If(S='MEMORY')or(S='MEM')Then Begin
        If Not Num(Q,A)Then Goto Xit;
        If Q.PC^[Q.X]<>','Then Goto VirguleNotFound;
        Inc(Q.X);
        If Not Num(Q,B)Then Goto Xit;
        FillClr(Mem[Q.SegBas:A.X.DataInt],B.X.DataInt);
        Goto 1
       End;
       Q.ExitCode:=EndOfCommandExpected;
       Goto Xit;
_CLOSE:SkipSpc(Q.X,Q.PC);
       If Q.PC^[Q.X]<>'#'Then Begin
        Q.ExitCode:=DieseExpected;
        Goto Xit;
       End;
       Inc(Q.X);
       S:='#';
       While Q.PC^[Q.X]in['0'..'9']do Begin
        IncStr(S,Q.PC^[Q.X]);
        Inc(Q.X)
       End;
       A.X.DataInt:=ReadVarInt(Q,S);
       If A.X.DataInt=0Then Begin
        Q.ExitCode:=FileNotOpen;
        Goto Xit;
       End;
       FileClose(Hdl(A.X.DataInt));
       PushVarInt(Q,0,S);
       Goto 1;
 _CLS: BasicCLS(Q);
       Goto 1;
_COLOR:If Q.PC^[Q.X]=','Then Begin
        Inc(Q.X);
        If Not Num(Q,B)Then Goto Xit;
        If(IsGrf)Then _SetKr(V[0].X.DataInt);
        SetKr(V[0].X.DataInt+(B.X.DataInt shl 4));
       End
        Else
       Begin
        If(IsGrf)Then _SetKr(V[0].X.DataInt);
        SetKr(GetKr and$F+V[0].X.DataInt);
       End;
       Goto 1;
 _COPY:If _Str2S(Q,S)Then Begin
        If Q.PC^[Q.X]=','Then Inc(Q.X);
        If Not Num(Q,C)Then Goto Xit;
        D.X.DataInt:=Q.SegBas;
        If Q.PC^[Q.X]=':'Then Begin
         Inc(Q.X);
         D.X.DataInt:=C.X.DataInt;
         If Not Num(Q,C)Then Goto Xit;
        End;
        If Q.PC^[Q.X]<>','Then Goto VirguleNotFound;
        Inc(Q.X);
        If Not Num(Q,E)Then Goto Xit;
        If GetFile(S,0,Mem[D.X.DataInt:C.X.DataInt],E.X.DataInt)<>0Then Begin
         Q.ExitCode:=SysErr;
         Goto Xit;
        End;
       End
        Else
       Begin
        If Not Num(Q,A)Then Goto Xit;
        B.X.DataWord:=Q.SegBas;
        If Q.PC^[Q.X]=':'Then Begin
         Inc(Q.X);
         B:=A;
         If Not Num(Q,A)Then Goto Xit;
        End;
        If Q.PC^[Q.X]<>','Then Goto VirguleNotFound;
        Inc(Q.X);
        If Not Num(Q,C)Then Goto Xit;
        D.X.DataWord:=Q.SegBas;
        If Q.PC^[Q.X]=':'Then Begin
         Inc(Q.X);
         D.X.DataInt:=C.X.DataInt;
         If Not Num(Q,C)Then Goto Xit;
        End;
        If Q.PC^[Q.X]<>','Then Goto VirguleNotFound;
        Inc(Q.X);
        If Not Num(Q,E)Then Goto Xit;
        MoveLeft(Mem[B.X.DataWord:A.X.DataWord],Mem[D.X.DataWord:C.X.DataWord],E.X.DataWord)
       End;
       Goto 1;
_CURSOR:
       SkipSpc(Q.X,Q.PC);
       PXtrkWord(Q,S);
       If S='ON'Then SimpleCur Else
       If S='OFF'Then CloseCur
        Else
       Begin
        Q.ExitCode:=ValueExpected;
        Goto Xit;
       End;
       Goto 1;
 _DATA:While Not(Q.PC^[Q.X]in[#0,':'])do Inc(Q.X);
       Goto 1;
 _DEF: SkipSpc(Q.X,Q.PC);
       PXtrkWord(Q,S);
       If S='SEG'Then Begin
        If Q.PC^[Q.X]='='Then Begin
         Inc(Q.X);
         SkipSpc(Q.X,Q.PC);
         PXtrkWord(Q,S);
         If S=''Then Begin
          If Not Num(Q,A)Then Goto Xit;
          If Not(A.TypeDef in[dtInt,dtLong])Then Goto Xit;
          Q.SegBas:=A.X.DataWord;
         End
          Else
         If S='EMS'Then Q.SegBas:=EmmSeg Else
         If S='VIDEO'Then Q.SegBas:=GetVideoSeg Else
         If S='VIDEOROM'Then Q.SegBas:=GetVideoSegRom Else
         If S='VIDEOTEXT'Then Q.SegBas:=GetVideoSegBuf
          Else
         ASM MOV AX,SyntaxError;JMP Xit;END;
        End
         Else
        Q.SegBas:=DSeg;
        Goto 1;
       End;
       Q.ExitCode:=EndOfCommandExpected;
       Goto Xit;
_DELAY:Delay(V[0].X.DataInt);
       Goto 1;
 _DIM: If Not BasicDim(Q)Then Goto Xit;
       Goto 1;
 _DO:  Inc(Q.BouclePos);
       If Q.BouclePos>63Then Begin
        Q.ExitCode:=TooManyBoucle;
        Goto Xit;
       End;
       Q.Boucle[Q.BouclePos].Model:=BDo;
       Q.Boucle[Q.BouclePos].X:=Q.X;
       Q.Boucle[Q.BouclePos].Y:=Q.Line;
       Goto 1;
 _DRAW:BasicCreateForm(Q);
       BasicDraw(Q,S);
       Goto 1;
 _ELSE:If Q._ELSE>0Then Goto NextLine
        Else
       Begin
        Q.ExitCode:=MisplacedElse;
        Goto Xit;
       End;
_ERROR:Q.ExitCode:=V[0].X.DataInt;
       Goto Xit;
_FILECOPY:
       CopyFile(S,S2);
       Goto 1;
 _FOR: Inc(Q.BouclePos);
       If Q.BouclePos>63Then Begin
        Q.ExitCode:=TooManyBoucle;
        Goto Xit;
       End;
       SkipSpc(Q.X,Q.PC);
       Q.Boucle[Q.BouclePos].Model:=BFor;
       Q.Boucle[Q.BouclePos].X:=Q.X;
       Q.Boucle[Q.BouclePos].Y:=Q.Line;
       ExtractVarName(Q,S);
       SkipSpc(Q.X,Q.PC);
       If Q.PC^[Q.X]<>'='Then Begin
        Q.ExitCode:=EqualExpected;
        Goto Xit;
       End;
       Inc(Q.X);
       If Not Num(Q,A)Then Goto Xit;
       PushVar(Q,S,A);
       PXtrkWord(Q,S);
       If S<>'TO'Then Begin
        Q.ExitCode:=ToExpected;
        Goto Xit;
       End;
       Q.Boucle[Q.BouclePos].X2:=Q.X;
       If Not Num(Q,B)Then Goto Xit;
       PXtrkWord(Q,S);
       If Length(S)>0Then Begin
        If S<>'STEP'Then Begin
         Q.ExitCode:=SyntaxError;
         Goto Xit;
        End;
        Q.Boucle[Q.BouclePos].X3:=Q.X;
        If Not Num(Q,C)Then Goto Xit;
       End
        Else
       Q.Boucle[Q.BouclePos].X3:=0;
       Goto 1;
_FILLBOX:
       BasicCreateForm(Q);
       If Q.PC^[Q.X]=','Then Begin
        Inc(Q.X);
        If _Str2S(Q,S)Then Begin
         _BasicFillBox(Q,V[0].X.DataInt,V[1].X.DataInt,V[2].X.DataInt,
                       V[3].X.DataInt,S[1],V[4].X.DataInt)
        End
         Else
        Begin
         PXtrkWord(Q,S);
         If Not BasicFillBox(Q,V[0].X.DataInt,V[1].X.DataInt,V[2].X.DataInt,
                             V[3].X.DataInt,V[4].X.DataInt,S)Then Goto Xit;
        End;
       End
        Else
       ClrWn(V[0].X.DataInt,V[1].X.DataInt,V[2].X.DataInt,
             V[3].X.DataInt,V[4].X.DataInt);
       Goto 1;
_FLASH:SetKr(GetKr or$80);
       Goto 1;
 _GET: If Not BasicGet(Q)Then Goto Xit;
       Goto 1;
_GOSUB:Inc(Q.GosubPos);
       If Q.GosubPos>63Then Begin
        Q.ExitCode:=TooManyGosub;
        Goto Xit;
       End;
       If Not Num(Q,A)Then Goto Xit;
       C.X.DataWord:=Q.Line;
       Q.Gosub[Q.GosubPos].X:=Q.X;
       Q.Gosub[Q.GosubPos].Y:=Q.Line;
       Q.Line:=0;
       ALSetPtr(Source,0);
       For B.X.DataWord:=0to Source.Count-1do Begin
        Q.PC:=ALGetCurrBuf(Source,Size);Q.X:=0;
        If(Q.PC<>NIL)Then Begin
         SkipSpc(Q.X,Q.PC);
         S:='';
         While Q.PC^[Q.X]in['0'..'9']do Begin
          IncStr(S,Q.PC^[Q.X]);
          Inc(Q.X);
         End;
         If(StrToWord(S)=A.X.DataWord)Then Begin
          Q.X:=0;
          Q._ELSE:=0;
          Goto 1;
         End;
        End;
        ALNext(Source);Inc(Q.Line)
       End;
       Q.Line:=C.X.DataWord;
       Q.ExitCode:=LabelExpected;
       Goto Xit;
 _GOTO:
 G1:   If Not Num(Q,A)Then Goto Xit;
 G2:   C.X.DataWord:=Q.Line;Q.Line:=0;
       ALSetPtr(Source,0);
       For B.X.DataWord:=0to Source.Count-1do Begin
        Q.PC:=ALGetCurrBuf(Source,Size);
        Q.X:=0;
        If(Q.PC<>NIL)Then Begin
         SkipSpc(Q.X,Q.PC);
         S:='';
         While Q.PC^[Q.X]in['0'..'9']do Begin
          IncStr(S,Q.PC^[Q.X]);
          Inc(Q.X);
         End;
         If(StrToWord(S)=A.X.DataWord)Then Begin
          Q._ELSE:=0;
          Goto 1;
         End;
        End;
        ALNext(Source);
        Inc(Q.Line)
       End;
       Q.Line:=C.X.DataWord;
       Q.ExitCode:=LabelExpected;
       Goto Xit;
 _GR:  BasicSetMode(Q);
       If Not SetVideoMode(vmGrf640x200c2)Then Begin
        Q.ExitCode:=InvalidFunctionCall;
        Goto Xit;
       End;
       Goto 1;
_HLINE:BasicCreateForm(Q);
       SkipSpc(Q.X,Q.PC);
       Case Q.PC^[Q.X]of
        ',':Inc(Q.X);
        #0,':':Goto NoLineArg;
        Else Begin
         Q.ExitCode:=VirguleExpected;
         Goto Xit;
        End;
       End;
       IO:=Q.X;
       PXtrkWord(Q,S);
       If S='PRESET'Then E.X.DataWord:=0 Else
       If S='PSET'Then E.X.DataWord:=GraphColor
        Else
       Begin
        Q.X:=IO;
        If Not Num(Q,E)Then Begin
NoLineArg:
         E.TypeDef:=dtLong;
         E.X.DataLong:=GraphColor;
        End;
       End;
       If Q.PC^[Q.X]=','Then Begin
        Inc(Q.X);
        SkipSpc(Q.X,Q.PC);
        PXtrkWord(Q,S);
        If S='B'Then Begin
         If Q.PC^[Q.X]=','Then Begin
          Inc(Q.X);
          If Not Num(Q,F)Then Goto Xit;
          If Q.PC^[Q.X]=','Then Begin
           Inc(Q.X);
           If Not Num(Q,G)Then Goto Xit;
           BasicPutRoundRect(Q,V[0].X.DataWord,V[1].X.DataWord,V[2].X.DataWord,
                       V[3].X.DataWord,G.X.DataWord,F.X.DataWord,E.X.DataWord)
          End
           Else
          BasicPutRoundRect(Q,V[0].X.DataWord,V[1].X.DataWord,V[2].X.DataWord,
                       V[3].X.DataWord,1,F.X.DataWord,E.X.DataWord)
         End
          Else
         BasicPutRect(Q,V[0].X.DataWord,V[1].X.DataWord,V[2].X.DataWord,
                   V[3].X.DataWord,E.X.DataWord)
        End
         Else
        If(S='BF')or(S='FB')Then Begin
         If Q.PC^[Q.X]=','Then Begin
          Inc(Q.X);
          SkipSpc(Q.X,Q.PC);
          IF Not Num(Q,F)Then Goto Xit;
          BasicPutFillRoundRect(Q,V[0].X.DataWord,V[1].X.DataWord,
                           V[2].X.DataWord,V[3].X.DataWord,
                           F.X.DataWord,E.X.DataWord)
         End
          Else
         BasicPutFillBox(Q,V[0].X.DataWord,V[1].X.DataWord,
                         V[2].X.DataWord,V[3].X.DataWord,E.X.DataWord)
        End
         Else
        If(S<>'')and(S<>'F')Then Begin
         Q.ExitCode:=SyntaxError;
         Goto Xit;
        End;
        If Q.PC^[Q.X]=','Then Begin
         Inc(Q.X);
         Num(Q,V[4]);
        End;
        BasicPutLine(Q,V[0].X.DataWord,V[1].X.DataWord,V[2].X.DataWord,
                       V[3].X.DataWord,E.X.DataWord);
       End
        Else
       BasicPutLine(Q,V[0].X.DataWord,V[1].X.DataWord,V[2].X.DataWord,
                      V[3].X.DataWord,E.X.DataWord);
       Goto 1;
 _HOME:BasicCreateForm(Q);
       ClrScrBlack;
       Goto 1;
_HSCALE:
       SetHorizontalScale(V[0].X.DataWord);
       Goto 1;
 _HTAB:BasicHTab(Q,V[0].X.DataWord);
       Goto 1;
 _HCOLOR:
       GraphColor:=V[0].X.DataWord;
       Goto 1;
_HPRINT:
       BasicCreateForm(Q);
       If Not _Str2S(Q,S)Then Begin
        If Not Num(Q,C)Then Goto Xit;
        If A.TypeDef in[dtInt,dtLong,dtReal]Then S:=VariantToString(A)
         Else
        Begin
         Q.ExitCode:=InternalError;
         Goto Xit;
        End;
       End;
       If(IsGrf)Then Begin
        V[1].X.DataWord:=V[1].X.DataWord*HeightChr;
        V[0].X.DataWord:=V[0].X.DataWord shl 3;
        SkipSpc(Q.X,Q.PC);
        If Q.PC^[Q.X]=','Then Begin
         Inc(Q.X);
         PXtrkWord(Q,S2);
         If S2<>'SHADOW'Then Begin
          Q.ExitCode:=SyntaxError;
          Goto Xit;
         End;
         OutSTxtXY(V[0].X.DataWord,V[1].X.DataWord,S,GraphColor);
        End
         Else
        For C.X.DataWord:=1to Length(S)do Begin
         SetGCubeT(V[0].X.DataWord,V[1].X.DataWord,
                   S[C.X.DataWord],GraphColor);
         Inc(A.X.DataWord,8)
        End;
       End
        Else
       PutTxtXY(V[0].X.DataWord,V[1].X.DataWord,S,GetKr);
       Goto 1;
_INPUT:If Not BasicInput(Q)Then Goto Xit;
       Goto 1;
  _KEY:If Not BasicKey(Q)Then Goto Xit;
       Goto 1;
_LET:  SkipSpc(Q.X,Q.PC);
       PXtrkWord(Q,S);
       Goto UnknownInstr;
_PRESET:
_HRESET:
       BasicCreateForm(Q);
       BasicSetPixel(Q,V[0].X.DataWord,V[1].X.DataWord,0);
       Goto 1;
_HPLOT:BasicCreateForm(Q);
       BasicSetPixel(Q,V[0].X.DataWord,V[1].X.DataWord,GraphColor);
       Goto 1;
_HSCREEN:
       Case(V[0].X.DataWord)of
        0:If NmXTxts>40Then B.X.DataWord:=vmTxtC80
                       Else B.X.DataWord:=vmTxtC40;
        1:B.X.DataWord:=vmGrf320x200c4;
        2:B.X.DataWord:=vmGrf320x200c256;
        3:B.X.DataWord:=vmGrf640x200c2;
        4:B.X.DataWord:=vmGrf640x200c16;
        Else Begin
         Q.ExitCode:=InvalidFunctionCall;
         Goto Xit;
        End;
       End;
       BasicSetMode(Q);
       SetVideoMode(B.X.DataWord);
       Q.Screen.X1:=0;
       Q.Screen.Y1:=0;
       Q.Screen.X2:=GetMaxXPixels;
       Q.Screen.Y2:=GetMaxYPixels;
       If V[0].X.DataWord=0Then Begin
        SetUnderline(True);
        SetKr(7)
       End;
       Q.HScreen:=True;
       Goto 1;
 _PSET:
 _HSET:BasicCreateForm(Q);
       If(V[1].X.DataWord<NmYPixels)Then
        BasicSetPixel(Q,V[0].X.DataWord,V[1].X.DataWord,V[2].X.DataWord);
       Goto 1;
 _IF:  If Not(Test)Then Goto Xit;
       PXtrkWord(Q,S);
       If(Ok)Then Inc(Q._ELSE);
       SkipSpc(Q.X,Q.PC);
       If S='GOTO'Then Begin
        If(Ok)Then Goto G1;
       End
        Else
       If S='THEN'Then Begin
        If(Ok)and(Q.PC^[Q.X]in['0'..'9'])Then Goto G1;
       End
        Else
       Begin
        Q.ExitCode:=ThenExpected;
        Goto Xit;
       End;
       If Not(Ok)Then Begin
        While Q.PC^[Q.X]<>#0do Begin
         If Q.PC^[Q.X]='E'Then Begin
          PXtrkWord(Q,S);
          If S='ELSE'Then Break;
         End
          Else
         Inc(Q.X);
        End;
       End;
       Goto 1;
 _ITEM:PC2:=PushVarStr2PChr(Q,S);
       If Q.PC^[Q.X]=','Then Begin
        Inc(Q.X);
        If Not Num(Q,B)Then Goto Xit;
        If Q.PC^[Q.X]=','Then Begin
         Inc(Q.X);
         If Not _Str2S(Q,S)Then Goto Xit;
         PC3:=PushVarStr2PChr(Q,S);
        End
         Else
        PC3:=NIL;
       End
        Else
       Begin
        B.X.DataWord:=kbNoKey;
        PC3:=NIL;
       End;
       BasicXChgMenu(Q.Menu);
       PMAddItemKey(PC2,B.X.DataWord,V[0].X.DataWord,PC3);
       BasicXChgMenu(Q.Menu);
       Goto 1;
 _KILL:DeleteFile(S);
       Goto 1;
_LOCATE:
       BasicLocate(Q,V[0].X.DataInt,V[1].X.DataInt);
       Goto 1;
 _LOOP:SkipSpc(Q.X,Q.PC);
       If Not(Test)Then Goto Xit;
       If(Ok)Then Begin
        Dec(Q.BouclePos);
        Goto 1;
       End;
       If(Q.Boucle[Q.BouclePos].Y<>Q.Line)Then Begin
        Q.Line:=Q.Boucle[Q.BouclePos].Y;
        ALSetPtr(Source,Q.Line);
        Q.PC:=ALGetCurrBuf(Source,Size);
       End;
       Q.X:=Q.Boucle[Q.BouclePos].X;
       Goto 1;
_LPRINT:
       Prn(S);
       If Q.PC^[Q.X]=';'Then Inc(Q.X)
                        Else PrnLn;
       Goto 1;
 _MENU:BasicXChgMenu(Q.Menu);
       PMAddMnu(PushVarStr2PChr(Q,S));
       BasicXChgMenu(Q.Menu);
       Goto 1;
_MKDIR:MkDir(S);
       Goto 1;
_MLOAD:If Not LoadMtx(S)Then Begin
        Q.ExitCode:=FileNotFound;
        Goto Xit;
       End;
       Goto 1;
_MOTOR:
       SkipSpc(Q.X,Q.PC);
       PXtrkWord(Q,S);
       If S='ON'Then CassetteMotorOn Else
       If S='OFF'Then CassetteMotorOff
        Else
       Begin
        Q.ExitCode:=ValueExpected;
        Goto Xit;
       End;
       Goto 1;
_MOUSEPTR:
       If Not BasicMousePtr(Q)Then Goto Xit;
       Goto 1;
_MOVETEXT:
       BasicCreateForm(Q);
       MoveText(V[0].X.DataInt,V[1].X.DataInt,V[2].X.DataInt,
                V[3].X.DataInt,V[4].X.DataInt,V[5].X.DataInt);
       Goto 1;
 _NEXT:If Q.BouclePos=0Then Begin
        Q.ExitCode:=NextWithoutFor;
        Goto Xit;
       End;
       If(Q.Boucle[Q.BouclePos].Model<>BFor)Then Begin
        Q.ExitCode:=MisplacedNext;
        Goto Xit;
       End;
       ExtractVarName(Q,S); { Extrait le nom de la variable: NEXT ÆvariableØ }
       IO:=Q.X;JO:=Q.Line;
       If(Q.Boucle[Q.BouclePos].Y<>Q.Line)Then Begin
        Q.Line:=Q.Boucle[Q.BouclePos].Y;
        ALSetPtr(Source,Q.Line);
        Q.PC:=ALGetCurrBuf(Source,Size);
       End;
       Q.X:=Q.Boucle[Q.BouclePos].X;
       ExtractVarName(Q,S);
       ReadVar(Q,S,A);
       Q.X:=Q.Boucle[Q.BouclePos].X2;
       Num(Q,B);
       If(B.TypeDef=dtInt)Then B.X.IntHi:=0;
       If Q.Boucle[Q.BouclePos].X3>0Then Begin
        Q.X:=Q.Boucle[Q.BouclePos].X3;
        Num(Q,C);
        If(C.TypeDef=dtInt)Then C.X.IntHi:=0;
       End
        Else
       Begin
        C.X.DataLong:=1;
        C.TypeDef:=dtLong;
       End;
       If BasicCmpFor(A,C,B)Then Begin
        Q.Line:=JO;
        ALSetPtr(Source,Q.Line);
        Q.PC:=ALGetCurrBuf(Source,Size);
        Q.X:=IO;
        Dec(Q.BouclePos);
        Goto 1;
       End;
       PushNAddVar(Q,S,A,C);
       Goto 1;
 _NAME:SkipSpc(Q.X,Q.PC);
       PXtrkWord(Q,S2);
       If S2<>'AS'Then Begin
        Q.ExitCode:=AsExpected;
        Goto Xit;
       End;
       If Not _Str2S(Q,S2)Then Goto Xit;
       RenameFile(S,S2);
       Goto 1;
 _NEW: Goto Xit;
_NORMAL:
       SetKr(GetKr and$7F);
       Goto 1;
_NUMLOCK:
       If Not BasicNumLock(Q)Then Goto Xit;
       Goto 1;
_ON:   SkipSpc(Q.X,Q.PC);
       PXtrkWord(Q,S);
       If S='ERROR'Then Begin
        SkipSpc(Q.X,Q.PC);
        PXtrkWord(Q,S);
        If S='GOTO'Then Begin
         If Not Num(Q,A)Then Goto Xit;
         Q.OnError.Active:=True;
         Q.OnError.Y:=A.X.DataInt;
         Q.OnError.InOnError:=False;
        End
         Else
        Begin
         Q.ExitCode:=SyntaxError;
         Goto Xit;
        End;
       End
        Else
       Begin
        Q.ExitCode:=UnknownIdentifier;
        Goto Xit;
       End;
       Goto 1;
 _OPEN:S:=StrUp(S);
       If S='B'Then A.X.DataInt:=fmDef Else
       If S='O'Then A.X.DataInt:=fmWrite Else
       If S='I'Then A.X.DataInt:=fmRead Else
       If S='R'Then A.X.DataInt:=fmDef
        Else
       Begin
        Q.ExitCode:=SyntaxError;
        Goto Xit;
       End;
       SkipSpc(Q.X,Q.PC);
       If Q.PC^[Q.X]<>'#'Then Begin
        Q.ExitCode:=DieseExpected;
        Goto Xit;
       End;
       Inc(Q.X);
       S:='#';
       While Q.PC^[Q.X]in['0'..'9']do Begin
        IncStr(S,Q.PC^[Q.X]);
        Inc(Q.X)
       End;
       SkipSpc(Q.X,Q.PC);
       If Q.PC^[Q.X]<>','Then Goto VirguleNotFound;
       Inc(Q.X);
       If Not _Str2S(Q,S2)Then Goto Xit;
       B.X.DataInt:=FileOpen(S2,A.X.DataInt);
       If(B.X.DataInt=hdlErr)Then Begin
        Q.ExitCode:=SysErr;
        Goto Xit;
       End;
       PushVarInt(Q,B.X.DataInt,S);
       Goto 1;
_OPTION:
       SkipSpc(Q.X,Q.PC);
       PXtrkWord(Q,S);
       If S='EXPLICIT'Then Include(Q.Option,boExplicit)
        Else
       Begin
        Q.ExitCode:=SyntaxError;
        Goto Xit;
       End;
       Goto 1;
_OUT: Port[V[0].X.DataWord]:=V[1].X.DataInt;
       Goto 1;
 _PAGE:SetPage(V[0].X.DataInt);
       Goto 1;
_HPAINT:
_PAINT:If Q.PC^[Q.X]=','Then Begin
        Inc(Q.X);
        If Not Num(Q,V[2])Then Goto Xit;
        If Q.PC^[Q.X]=','Then Begin
         Inc(Q.X);
         If Not Num(Q,A)Then Goto Xit;
        End
         Else
        A.X.DataInt:=GraphColor;
       End
        Else
       V[2].X.DataInt:=GraphColor;
       BasicPaint(Q,V[0].X.DataInt,V[1].X.DataInt,V[2].X.DataInt,A.X.DataInt);
       Goto 1;
_PALETTE:
       If Q.PC^[Q.X]=','Then Begin
        Inc(Q.X);
        If Not Num(Q,C)Then Goto Xit;
        If Q.PC^[Q.X]<>','Then Goto VirguleNotFound;
        Inc(Q.X);
        If Not Num(Q,D)Then Goto Xit;
        SetPaletteRGB(V[0].X.DataInt,V[1].X.DataInt,C.X.DataInt,D.X.DataInt);
       End
        Else
       SetPaletteRGB(V[0].X.DataInt,(V[1].X.DataInt shr 4)shl 6,((V[1].X.DataInt shr 2)and 3)shl 6,(B.X.DataInt and 3)shl 6);
       Goto 1;
_PCOPY:SkipSpc(Q.X,Q.PC);
       PXtrkWord(Q,S);
       If S<>'TO'Then Begin
        Q.ExitCode:=ToExpected;
        Goto Xit;
       End;
       If Not Num(Q,B)Then Goto Xit;
       PCopy(V[0].X.DataInt,B.X.DataInt);
       Goto 1;
 _POKE:Mem[Q.SegBas:V[0].X.DataWord]:=V[1].X.DataInt;
       Goto 1;
_PRINT:BasicCreateForm(Q);
_NextPrint:
       If Not _Str2S(Q,S)Then Begin
        Case Q.PC^[Q.X]of
         '#':Begin
          Inc(Q.X);
          S:='#';
          While Q.PC^[Q.X]in['0'..'9']do Begin
           IncStr(S,Q.PC^[Q.X]);
           Inc(Q.X)
          End;
          A.X.DataInt:=ReadVarInt(Q,S);
          If A.X.DataInt=0Then Begin
           Q.ExitCode:=FileNotOpen;
           Goto Xit;
          End;
          SkipSpc(Q.X,Q.PC);
          If Q.PC^[Q.X]<>','Then Goto VirguleNotFound;
          Inc(Q.X);
          If Not _Str2S(Q,S2)Then Goto Xit;
          If Q.PC^[Q.X]=';'Then Begin
           Inc(Q.X);
           PutFileTxt(A.X.DataInt,S2)
          End
           Else
          PutFileTxtLn(A.X.DataInt,S2);
          Goto 1;
         End;
         '@':Begin
          Inc(Q.X);
          If Not Num(Q,A)Then Goto Xit;
          If Q.PC^[Q.X]<>','Then Goto VirguleNotFound;
          If Not _Str2S(Q,S)Then Goto Xit;
          SetPos(A.X.DataWord mod NmXTxts,B.X.DataWord div NmXTxts);
          SetCurPos(A.X.DataWord mod NmXTxts,B.X.DataWord div NmXTxts);
         End;
         Else Begin
          IO:=Q.X;
          If Not Num(Q,A)Then Goto Xit;
          If(IO=Q.X)Then S:=''
           Else
          Begin
           If A.TypeDef in[dtInt,dtLong,dtReal]Then S:=VariantToString(A)
            Else
           Begin
            Q.ExitCode:=InternalError;
            Goto Xit;
           End;
           S:=' '+S;
          End;
         End;
        End;
       End;
       Ok:=Q.PC^[Q.X]=';';
       If(Ok)Then Inc(Q.X)
        Else
       Begin
        Ok:=Q.PC^[Q.X]=',';
        BasicPrint(Q,S,Not Ok);
        If(Ok)Then Begin
         Inc(Q.X);
         If Q.W.X and$F>0Then Begin
          WEClrEol(Q.W);
          Q.W.X:=(Q.W.X and$F0)+$10;
         End;
         If Not(Q.PC^[Q.X]in[':',#0])Then Goto _NextPrint;
        End;
        Goto 1;
       End;
       BasicPrint(Q,S,Not Ok);
       If(Ok)and(Not(Q.PC^[Q.X]in[':',#0]))Then Goto _NextPrint;
       Goto 1;
  _PUT:BasicCreateForm(Q);
       If Q.PC^[Q.X]<>','Then Goto VirguleNotFound;
       Inc(Q.X);
       PXtrkWord(Q,S);
       PC2:=AddrTLong(Q,S,E.X.DataWord);
       If(PC2=NIL)Then Begin
        Q.ExitCode:=TypeMistmatch;
        Goto Xit;
       End;
       A:=V[0];B:=V[1];
       ASM
        LES DI,PC2
        MOV AX,ES:[DI]
        ADD AX,A.X.DataInt
        MOV C.X.DataInt,AX
        MOV AX,ES:[DI+2]
        ADD AX,B.X.DataInt
        MOV D.X.DataInt,AX
        ADD Word Ptr PC2,4
       END;
       PutSmlImg(V[0].X.DataInt,V[1].X.DataInt,C.X.DataInt,D.X.DataInt,PC2^);
       Goto 1;
_RANDOMIZE:
       Randomize;
       Goto 1;
 _READ:If Not BasicRead(Q,Source)Then Goto Xit;
       Goto 1;
  _REG:If Not BasicReg(Q,V[0].X.DataInt,V[1].X.DataWord)Then Goto Xit;
       Goto 1;
 _REM: Goto NextLine;
_RENDIR:
       SkipSpc(Q.X,Q.PC);
       PXtrkWord(Q,S2);
       If S2<>'AS'Then Begin
        Q.ExitCode:=AsExpected;
        Goto Xit;
       End;
       If Not _Str2S(Q,S2)Then Goto Xit;
       RenDir(S,S2);
       Goto 1;
_RESPONSE: { ASP - VBScript }
       If Q.PC^[Q.X]<>'.'Then Begin
        Q.ExitCode:=CommaExpected;
        Goto Xit;
       End;
       Inc(Q.X);
       PXtrkWord(Q,S);
       If S='WRITE'Then Begin
        If Not _Str2S(Q,S2)Then Goto Xit;
        PutFileTxt(Q.Output,S2);
       End;
       Goto 1;
_RESTORE:
       If Not BasicRestore(Q,Source)Then Goto Xit;
       Goto 1;
_RETURN:
       If Q.GosubPos=0Then Begin
        Q.ExitCode:=ReturnWithoutGosub;
        Goto Xit;
       End;
       If Num(Q,A)Then Begin
        Dec(Q.GosubPos);
        Goto G2;
       End;
       Q.X:=Q.Gosub[Q.GosubPos].X;
       Q.Line:=Q.Gosub[Q.GosubPos].Y;
       ALSetPtr(Source,Q.Line);
       Q.PC:=ALGetCurrBuf(Source,Size);
       Dec(Q.GosubPos);
       Goto 1;
_RMDIR:RmDir(S);
       Goto 1;
_SCREEN:
       SkipSpc(Q.X,Q.PC);
       IO:=Q.X;
       PXtrkWord(Q,S);
       If(S='LUXE')or(S='DELUXE')Then Begin
        {BasicSetMode(Q);}
        SetVideoModeDeluxe(vmTxtC80);
        Q.Screen.X1:=0;
        Q.Screen.Y1:=0;
        Q.Screen.X2:=GetMaxXPixels;
        Q.Screen.Y2:=GetMaxYPixels;
        Q.HScreen:=True;
       End
        Else
       Begin
        Q.X:=IO;
        If Not Num(Q,A)Then Goto Xit;
        BasicSetMode(Q);
        B.X.DataWord:=BasicScreenToAdele(A.X.DataWord);
        If B.X.DataWord<>$FFFFThen Begin
         If Not SetVideoMode(B.X.DataWord)Then Begin
          Q.ExitCode:=InvalidFunctionCall;
          Goto Xit;
         End;
         Case(GetBitsPerPixel)of
          1:GraphColor:=1;
          2:GraphColor:=3;
          Else GraphColor:=15;
         End;
         Q.Screen.X1:=0;
         Q.Screen.Y1:=0;
         Q.Screen.X2:=GetMaxXPixels;
         Q.Screen.Y2:=GetMaxYPixels;
         If A.X.DataWord=14Then SetChrWidth(0);
         SetPos(0,0);
         SetCurPos(0,0);
         Q.HScreen:=False;
        End
         Else
        Begin
         Q.ExitCode:=InvalidFunctionCall;
         Goto Xit
        End;
       End;
       Goto 1;
_SCROLLLOCK:
       If Not BasicScrollLock(Q)Then Goto Xit;
       Goto 1;
 _SEEK:SkipSpc(Q.X,Q.PC);
       If Q.PC^[Q.X]<>'#'Then Begin
        Q.ExitCode:=DieseExpected;
        Goto Xit;
       End;
       Inc(Q.X);
       S:='#';
       While Q.PC^[Q.X]in['0'..'9']do Begin
        IncStr(S,Q.PC^[Q.X]);
        Inc(Q.X)
       End;
       A.X.DataInt:=ReadVarInt(Q,S);
       If A.X.DataInt=0Then Begin
        Q.ExitCode:=FileNotOpen;
        Goto Xit;
       End;
       SkipSpc(Q.X,Q.PC);
       If Q.PC^[Q.X]<>','Then Goto VirguleNotFound;
       Inc(Q.X);
       If Not Num(Q,B)Then Goto Xit;
       If(B.TypeDef=dtInt)Then B.X.IntHi:=0;
       SetFilePos(A.X.DataInt,B.X.DataLong);
       Goto 1;
_SENDKEYS:
       BasicSendKeys(S);
       Goto 1;
  _SET:{ A dÇvelopper ... Exemple: Set X=Server.CreateObject("ADODB.Connection") }
       PXtrkWord(Q,S);
       SkipSpc(Q.X,Q.PC);
       If Q.PC^[Q.X]<>'='Then Begin
        Q.ExitCode:=EqualExpected;
        Goto Xit;
       End;
       BasicFindNCreateObject(Q,S);
       Goto 1;
_SHELL:BasicShell(Q,S);
       Goto 1;
_SOUND:BasicSound(V[0].X.DataWord,V[1].X.DataWord);
       Goto 1;
_SPLITSCREEN:
       SplitScreen(V[0].X.DataWord);
       Goto 1;
 _STOP:Q.ExitCode:=StopProgram;
       Goto Xit;
_SYSTEM:
       Q.ExitCode:=ExitProgramNow;
       Goto Xit;
_VERTICALSCALE:
       SetVerticalScale(V[0].X.DataWord);
       Goto 1;
 _VIEW:If Not BasicView(Q)Then Goto Xit;
       Goto 1;
_VISUALPAGE:
       SetVisualPg(V[0].X.DataWord);
       Goto 1;
 _VTAB:BasicVTAB(V[0].X.DataWord);
       Goto 1;
_WAITRETRACE:
       WaitRetrace;
       Goto 1;
 _WEND:If(Q.Boucle[Q.BouclePos].Model<>BWhile)Then Begin
        Q.ExitCode:=MisplacedWend;
        Goto Xit;
       End;
       Q.X:=Q.Boucle[Q.BouclePos].X;
       If(Q.Line<>Q.Boucle[Q.BouclePos].Y)Then Begin
        Q.Line:=Q.Boucle[Q.BouclePos].Y;
        ALSetPtr(Source,Q.Line);
        Q.PC:=ALGetCurrBuf(Source,Size);
       End;
       Goto Whil1;
_WIDTH:BasicSetMode(Q);
       If Not BasicWidth(Q,V[0].X.DataWord)Then Goto Xit;
       Goto 1;
_WHILE:Inc(Q.BouclePos);
       If Q.BouclePos>63Then Begin
        Q.ExitCode:=TooManyBoucle;
        Goto Xit;
       End;
       SkipSpc(Q.X,Q.PC);
       Q.Boucle[Q.BouclePos].Model:=BWhile;
       Q.Boucle[Q.BouclePos].X:=Q.X;
       Q.Boucle[Q.BouclePos].Y:=Q.Line;
 Whil1:If Not(Test)Then Goto Xit;
       If(Ok)Then Goto 1;
       Repeat
        While Q.PC^[Q.X]<>#0do Begin
         If Q.PC^[Q.X]='W'Then Begin
          PXtrkWord(Q,S);
          If S='WEND'Then Begin
           Dec(Q.BouclePos);
           Goto 1;
          End;
         End
          Else
         Inc(Q.X);
        End;
        ALNext(Source);
        Inc(Q.Line);
        Q.PC:=ALGetCurrBuf(Source,Size);
        Q.X:=0;
       Until Q.Line>=Source.Count;
       Q.ExitCode:=WhileWithoutWend;
       Goto Xit;
_WRITE:BasicCreateForm(Q);
       If Not _Str2S(Q,S)Then Begin
        Case Q.PC^[Q.X]of
         '#':Begin
          Inc(Q.X);S:='#';
          While Q.PC^[Q.X]in['0'..'9']do Begin
           IncStr(S,Q.PC^[Q.X]);
           Inc(Q.X)
          End;
          A.X.DataInt:=ReadVarInt(Q,S);
          If A.X.DataInt=0Then Begin
           Q.ExitCode:=FileNotOpen;
           Goto Xit;
          End;
          SkipSpc(Q.X,Q.PC);
          If Q.PC^[Q.X]<>','Then Goto VirguleNotFound;
          Inc(Q.X);
          If Not _Str2S(Q,S2)Then Goto Xit;
          S2:='"'+S2;
          IncStr(S2,'"');
          If Q.PC^[Q.X]=';'Then Begin
           Inc(Q.X);
           PutFileTxt(A.X.DataInt,S2)
          End
           Else
          PutFileTxtLn(A.X.DataInt,S2);
          Goto 1;
         End;
         Else Goto Xit;
        End;
       End;
       _PutTxt('"');
       IncStr(S,'"');
       If Q.PC^[Q.X]=';'Then Begin
        Inc(Q.X);
        _PutTxt(S)
       End
        Else
       _PutTxtLn(S);
       Goto 1;
ErrorInstr:
       Q.ExitCode:=brErrorInstr;
       Goto Xit;
      End
       Else
      Begin
UnknownInstr:
       SkipSpc(Q.X,Q.PC);
       Case Q.PC^[Q.X]of
        '=':Begin
         Inc(Q.X);
         If Not Num(Q,A)Then Goto Xit;
         PushVar(Q,S,A);
         Goto 1;
        End;
        '%':Begin
         Inc(Q.X);
         SkipSpc(Q.X,Q.PC);
         If Q.PC^[Q.X]='='Then Begin
          Inc(Q.X);
          If Not Num(Q,A)Then Goto Xit;
          IncStr(S,'%');
          PushVar(Q,S,A);
          Goto 1;
         End
          Else
         Begin
          Q.ExitCode:=SyntaxError;
          Goto Xit;
         End;
        End;
        '&':Begin
         Inc(Q.X);
         SkipSpc(Q.X,Q.PC);
         If Q.PC^[Q.X]='='Then Begin
          Inc(Q.X);
          If Not Num(Q,A)Then Goto Xit;
          IncStr(S,'&');
          PushVar(Q,S,A);
          Goto 1;
         End
          Else
         Begin
          Q.ExitCode:=SyntaxError;
          Goto Xit;
         End;
        End;
        '!':Begin
         Inc(Q.X);
         SkipSpc(Q.X,Q.PC);
         If Q.PC^[Q.X]='='Then Begin
          Inc(Q.X);
          If Not Num(Q,A)Then Goto Xit;
          IncStr(S,'!');
          PushVar(Q,S,A);
          Goto 1;
         End
          Else
         Begin
          Q.ExitCode:=SyntaxError;
          Exit;
         End;
        End;
        '#':Begin
         Inc(Q.X);
         SkipSpc(Q.X,Q.PC);
         If Q.PC^[Q.X]='='Then Begin
          Inc(Q.X);
          If Not Num(Q,A)Then Goto Xit;
          IncStr(S,'#');
          PushVar(Q,S,A);
          Goto 1;
         End
          Else
         Begin
          Q.ExitCode:=SyntaxError;
          Goto Xit;
         End;
        End;
        '$':Begin
         Inc(Q.X);
         SkipSpc(Q.X,Q.PC);
         If Q.PC^[Q.X]='='Then Begin
          Inc(Q.X);
          If Not _Str2S(Q,S2)Then Goto Xit;
          IncStr(S,'$');
          If S='INKEY$'Then Case Length(S2)of
           0:;
           1:PushKey(Byte(S2[1]));
           2:PushKey(Byte(S2[1])+(Byte(S2[2])shl 8));
          End
           Else
          PushVarString(Q,S2,S);
          Goto 1;
         End;
        End;
  '(','[':Begin
         Inc(Q.X);
         If Not Num(Q,A)Then Goto Xit;
         PC2:=AddrTLong(Q,S,C.X.DataWord);
         If(PC2=NIL)Then Begin
          Q.ExitCode:=VarNotFound;
          Goto Xit;
         End;
         If Not(Q.PC^[Q.X]in[')',']'])Then Begin
          Q.ExitCode:=CloseParExpected;
          Goto Xit;
         End;
         Inc(Q.X);
         If Q.PC^[Q.X]<>'='Then Begin
          Q.ExitCode:=SyntaxError;
          Goto Xit;
         End;
         Inc(Q.X);
         If Not Num(Q,B)Then Goto Xit;
         If(B.TypeDef=dtInt)Then B.X.IntHi:=0;
         ASM
          LES DI,PC2
          MOV BX,A.X.DataInt
          {$IFOPT G+}
           SHL BX,2
          {$ELSE}
           SHL BX,1
           SHL BX,1
          {$ENDIF}
          ADD DI,BX
          MOV AX,Word Ptr B.X.DataLong
          STOSW
          MOV AX,Word Ptr B.X.DataLong[2]
          STOSW
         END;
         Goto 1;
        End;
        Else Begin
         Q.ExitCode:=SyntaxError;
         Goto Xit;
        End;
       End;
      End;
     End;
     If Q.PC^[Q.X]in[#0,'''']Then Goto NextLine;
     If(Q.Mode=bmASP)and(Q.PC^[Q.X]='%')and(Q.PC^[Q.X+1]='>')Then Begin
      Inc(Q.X,2);
      Q.NothingZone:=True;
      Goto ASPNothingZone;
     End;
     If Q.PC^[Q.X]<>':'Then ASM
      MOV @Result,brSyntaxError
      JMP Xit;
     END;
     Inc(Q.X);
     SkipSpc(Q.X,Q.PC);
    End;
   End;
NextLine:
   ALNext(Source);
   Inc(Q.Line);
  Until Q.Line>=Source.Count;
 End;
_END:
 BasicEndMessage(Q);
 BasicRun:=True;
Xit:
 If(Q.ExitCode<>0)and(Q.OnError.Active)Then Begin
  If Not(Q.OnError.InOnError)Then Begin
   Q.OnError.InOnError:=True;
   Q.ErrLine:=StrToInt(LabelStr);
   A.X.DataInt:=Q.OnError.Y;
   Goto G2;
  End;
 End;
 BasicUnsetMode(Q);
End;

Procedure BasicDone(Var Q:BasicStruct);Begin
  { A faire: LibÇrer les tableaux TLong,...}
  { A faire: LibÇrer les Handles #1,..}
 DBDispose(Q.FoncStr);
 DBDispose(Q.Fonction);
 DBDispose(Q.Instr);
End;

Procedure ASPDone(Var Q:BasicStruct);Begin
 FileClose(Q.Output);
 BasicDone(Q);
End;

Function BasicErrExitCodeStr(Var Q:BasicStruct):String;Begin
 If Q.ExitCode<>0Then Begin
  BasicErrExitCodeStr:=GetErrMsg(Q.ExitCode);
 End;
End;

END.