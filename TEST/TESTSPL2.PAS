Uses Dos;

Var
 Path,D,N,E:String;

BEGIN
 Path:='D:\MALTE\SYSTEMS';
 FSplit(Path,D,N,E);
 WriteLn(Path);
 WriteLn(D);
 WriteLn(N);
 WriteLn(E);
END.