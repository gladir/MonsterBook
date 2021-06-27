Uses Systems;

Var
 S:String;

BEGIN
 WriteLn;
 S:='ABCDEF';
 _Left(S,2);
 WriteLn(S);
 S:='ABCDEF';
 _Left(S,10);
 WriteLn(S);
 S:='ABCDEF';
 _Left(S,1);
 WriteLn(S);
 S:='ABCDEF';
 _Left(S,6);
 WriteLn(S);
 S:='ABCDEF';
 _Left(S,7);
 WriteLn(S);
 S:='ABCDEF';
 _Left(S,0);
 WriteLn(S);
END.