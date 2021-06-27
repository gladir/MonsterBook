{$N+}

Uses Systems;

Function SingleToReal(X:Single):Real;
Var
 SingleData:Record
  A,B,C,D:Byte;
 End Absolute X;
 SingleInt:Record
  A:Word;
  D:Word;
 End Absolute X;
 SingleLong:LongInt Absolute X;
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
(* RealData.Exp:={(SingleData.D shr 6)and$FF}(SingleInt.A and $7FFF)-$03F7E;
 RealData.E:=SingleData.D and 128;
 RealData.A:=((LongInt(SingleLong)and$7FFFFF));*)
 RealByte.A:=(SingleData.D shl 1)+1{+2}+((SingleData.C and$80)shr 6);
 If(RealByte.A and 1=1)and(SingleData.D and$F<>$F)Then Inc(RealByte.A);
 {SingleData.D and$F=$F}
 RealByte.D:=SingleData.A;
 RealByte.E:=SingleData.B;
 RealByte.F:=(SingleData.C and$7F)or(SingleData.D and$80);
 SingleToReal:=Y;
End;

{Function SingleToReal(X:Single):Real;Assembler;ASM
LES    DX,X
MOV    AX,ES
XOR    BX,BX
XOR    CX,CX
mov    di,ax
and    ax,07FFFh
sub    ax,03F7Eh
jbe    @Zero
or     ah,ah
jne    @Error
mov    ah,ch
shl    cl,1
adc    ah,00
adc    bx,0000
adc    dx,0000
jb     @Infini
@Finish:
shl    dx,1
shl    di,1
rcr    dx,1
JMP    @end
@Infini:
inc    al
jNE    @Finish
@Error:
@Zero:
 (* DX:BX:AX *)
xor    ax,ax
xor    bx,bx
xor    dx,dx
@End:
END;}

Var R,R2:Real;
T:Array[0..5] of Byte Absolute R;
T2:Array[0..5] of Byte Absolute R2;
S:Single;
SS:Array[0..3]of Byte Absolute S;
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
 R2:=SingleToReal(-4.00);
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