Uses Systex,Systems,SysPlus;

Var Data:OS2StartData;

BEGIN
 FillChar(Data,SizeOf(Data),0);
 Data.LenStruct:=$32;
 Data.Process:=prNew;
 Data.Priority:=prForeground;
 Data.Title:='Ceci est un titre que je viens d''essayer!';
 Data.Name:='C:\WIN31\WIN.COM';
 Data.Args:='/3 D:\LANGAGE\BP\BIN\BPW.EXE';
{ Data.Args:='/CC:\UTILS\BP.BAT';}
{ Data.Name:='F:\LANGAGE\BC\BIN\BC.EXE';}
 Data.SessionType:=0;
{ PChr(Data.Name):=Str2PChr('C:\LANGAGE\BP\BIN\TURBO.EXE');
{ Data.Args:='/Cdir /p d:\source\chantal';}
 Data.Icon:='D:\MALTE\MB.ICO';
{ Data.Column:=80;Data.Row:=50;
{ Data.Width:=640;Data.Height:=480;}
 WriteLn(OS2Exec(Data));
END.