Uses Sr8080A,Systems,Systex;

Var Source:Pointer;

BEGIN
 InitSystems(suIsabel);
 Source:=@Sourcer8080;
 DelFile('SR8080A.DRV');
 WriteLn(Ofs(Source^));
 SetFile('SR8080A.DRV',0,Ofs(EndSourcer8080)+1,Source^);
 DoneSystems;
END.