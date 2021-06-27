Const TableSize=5003;
      LargestCode=4095;
      InputPos:Word=0;
Var OldCode,CurrentCode,NewCode:Array[0..TableSize]of Integer;
    Output:Array[0..16383]of Integer;
    ByteOutput:Array[0..16383]of Byte Absolute Output;
    CodeBuffer:Array[0..259]of Char;
    BitOffset,ByteOffset,BitsLeft,CodeSize,MinCodeSize,ClearCode,EofCode,FreeCode,MaxCode:Integer;

Function GetPixel:Integer;Begin
 GetPixel:=MemW[SegB800:InputPos];
 Inc(InputPos,2);
End;

Procedure InitTable(MinCodeSize:Integer);Begin
 CodeSize:=MinCodeSize+1;ClearCode:=1 shl MinCodeSize;EofCode:=ClearCode+1;
 FreeCode:=ClearCode+2;MaxCode:=1 shl CodeSize;
 FillChar(CurrentCode,SizeOf(CurrentCode),0);
End;

Procedure WriteCode(Code:Integer);Var Temp:LongInt;Begin
 ByteOffset:=BitOffset shr 3;BitsLeft:=BitOffset and 7;
{ If(ByteOffset>255)}
 If BitsLeft>0Then Begin
  Temp:=(Code shl BitsLeft)or ByteOutput[ByteOffset];
  ByteOutput[ByteOffset]:=Temp;ByteOutput[ByteOffset+1]:=Temp shr 8;
  ByteOutput[ByteOffset+2]:=Temp shr 16;
 End
  Else
 Begin;ByteOutput[ByteOffset]:=Lo(Code);ByteOutput[ByteOffset+1]:=Hi(Code)End;
 Inc(BitOffset,CodeSize)
End;

Procedure Pack;Var D,Hx,PrefixCode,SuffixChar:Integer;Begin
 InitTable(MinCodeSize);
 BitOffset:=0;
 WriteCode(ClearCode);
 SuffixChar:=GetPixel;PrefixCode:=SuffixChar;
 Repeat
  SuffixChar:=GetPixel;
  Hx:=(PrefixCode xor(SuffixChar shl 5))and TableSize;D:=1;
  While(True)do Begin
   If CurrentCode[Hx]=0Then Begin
    WriteCode(PrefixCode);
    D:=FreeCode;
    If(FreeCode<=LargestCode)Then Begin
     OldCode[Hx]:=PrefixCode;NewCode[Hx]:=SuffixChar;
     CurrentCode[Hx]:=FreeCode;Inc(FreeCode);
    End;
    If(D=MaxCode)Then Begin
     If CodeSize<12Then Begin;Inc(CodeSize);MaxCode:=MaxCode shl 1;End
      Else
     Begin
      WriteCode(ClearCode);
      InitTable(MinCodeSize);
     End;
    End;
    PrefixCode:=SuffixChar;
    Break;
   End;
   If(OldCode[Hx]=PrefixCode)and(NewCode[Hx]=SuffixChar)Then Begin
    PrefixCode:=CurrentCode[Hx];
    Break;
   End;
   Inc(Hx,D);Inc(D,2);
   If(Hx>=TableSize)Then Dec(Hx,TableSize);
  End;
 Until InputPos>=4000;{Fin?}
 WriteCode(PrefixCode);
End;

BEGIN
 MinCodeSize:=8;
 Pack;
END.