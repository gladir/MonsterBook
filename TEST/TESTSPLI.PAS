Uses Systex,Systems;

var
 P: PathStr;
 D: DirStr;
 N: NameStr;
 E: ExtStr;
begin
 WriteLn(GetEnv('MALTE'));
 WriteLn('Y: ',FSearch('MBX.INI;MB.INI',MaltePath));
 P:='D:\SOURCE\CHANTAL.E\TEST.EXE';
{ P:='D:\MALTE\SYSTEMS';}
{ P:='NAME.EXT';}
 FSplit(P,D,N,E);
 WriteLn(D);
 WriteLn(N);
 WriteLn(E);
end.

