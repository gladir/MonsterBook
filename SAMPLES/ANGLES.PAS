Uses Systex,Systems,Numerix;

Var
 I:Byte;
 Handle:Hdl;
 S:String;

BEGIN
 Handle:=FileCreate('ANGLES.LST');
 If(Handle<>errHdl)Then Begin
  For I:=0to 90do Begin
   S:='INSERT INTO Angle VALUES ('+WordToStr(I)+'/*ø*/,';
   AddStr(S,RealStr2(SinDegree(I),1,4)+',');
   AddStr(S,RealStr2(CosDegree(I),1,4)+',');
   AddStr(S,RealStr2(TanDegree(I),1,4)+');');
   PutFileTxtLn(Handle,S);
  End;
  FileClose(Handle);
 End;
END.