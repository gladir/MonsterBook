{$N+}

Uses Systems;

Type
 TPReal=Record
  Exponent:Byte;
  Mantissa1:Word;
  Mantissa2:Word;
  MS:Byte;
 End;

DoubleStruct=Record
 Mantissa1:Word;
 Mantissa2:Word;
 Mantissa3:Word;
 M4ES:Word;
End;

Function DoubleToReal(X:Double):Real;
Var
 DStruct:DoubleStruct Absolute X;
 Real48:TPReal;
 Y:Real Absolute Real48;
Begin
 FillClr(Real48,SizeOf(Real48));
 Real48.Exponent:=((DStruct.M4ES and$7FF0)shr 4)-894;
 Real48.MS:=(((((DStruct.M4ES and$000F)shl 3)or
            ((DStruct.Mantissa3 and$E000)shr 13)))and$7F)or
            (Hi(DStruct.M4ES)and$80);
 Real48.Mantissa2:=(((DStruct.Mantissa3 and$1FFF)shl 3)or
                   ((DStruct.Mantissa2 and$E000)shr 13));
 Real48.Mantissa1:=(((DStruct.Mantissa2 and$1FFF)shl 3) or
                   ((DStruct.Mantissa1 and$E000)shr 13));
 DoubleToReal:=Y;
End;

(*Function DoubleToReal(X:Double):Real;
Var
 DoubleData:Record
  A,B,C,D,E,F,G,H:Byte;
 End Absolute X;
 DoubleInt:Record
  A:Word;
  D:Word;
  X:Word;
  E:Word;
 End Absolute X;
 DoubleLong:LongInt Absolute X;
 Y:Real;
 RealByte:Record
  A,B,C,D,E,F:Byte;
 End Absolute Y;
 RealData:Record
  Exp:Byte;
  A:LongInt;
  E:Byte;
 End Absolute Y;
Begin
 Y:=0.0;
 RealByte.A:=((DoubleData.E and$7FFF)shr 4)+1;
 If(RealByte.A and 1=1)and(DoubleData.D and$F<>$F)Then Inc(RealByte.A);
 {SingleData.D and$F=$F}
 RealByte.D:=DoubleData.A;
 RealByte.E:=DoubleData.B;
 RealByte.F:=(DoubleData.G and$7F)or(DoubleData.H and$80);
 DoubleToReal:=Y;
End;*)

Var R,R2:Real;
T:Array[0..5] of Byte Absolute R;
T2:Array[0..5] of Byte Absolute R2;
S:Double;
SS:Array[0..7]of Byte Absolute S;
I:Byte;

BEGIN
 R:=0.0;
{ T[5]:=$FF;
 T[4]:=$FF;
 T[2]:=$FF;}
 T[0]:=$FF;
 R:=-R;
 SS[0]:=$FF;
 R:=-4.00;
 S:=R;
{ R:=S;}
 R2:=DoubleToReal(-4.00);
 For I:=0to 5do Write(BinByte2Str(T2[I]),' ');
 WriteLn;
 WriteLn(R2);
 For I:=0to 5do Write(BinByte2Str(T[I]),' ');
 WriteLn;
 WriteLn(R);
{ SS[2]:=SS[2]xor 128;}
 For I:=0to 3do Write(BinByte2Str(SS[I]),' ');
 WriteLn;
 WriteLn(S);
END.