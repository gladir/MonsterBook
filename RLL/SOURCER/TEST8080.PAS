Uses SR8080A,Systex,Systems;

Const TabTest:Array[0..0]of Byte=($08);
Const Adr:Pointer=NIL;I:Word=0;
Var J:Word;Sourcer:Procedure(Var Buf;Var I:Wd;Var S:String);
    X:PtrRec Absolute Sourcer;
    S:String;

BEGIN
 PtrRec(Adr).Seg:=Seg(TabTest);
 I:=Ofs(TabTest);
 For J:=0to 15do Begin
  Sourcer8080(Adr^,I,S);
  WriteLn(S);
 End;
{ InitSystems(suIsabel);
 X.Seg:=AllocDrv(0,'DEBUG.*');
 If X.Seg=0Then Halt;
 X.Ofs:=0;
 For J:=0to 15do Begin
  Sourcer(Adr^,I,S);
  WriteLn(S);
 End;}
END.