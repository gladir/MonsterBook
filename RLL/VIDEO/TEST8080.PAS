Uses SR8080A;

Var J,I:Word;P:Pointer;

BEGIN
 Mem[$0040:$51]:=0;
 FillChar(Mem[$B800:0],4000,0);
 I:=0;P:=Ptr(0040,0000);
 For J:=0to 15do WriteLn(Sourcer8080(P,I));
END.