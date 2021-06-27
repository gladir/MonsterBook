Uses VideoMode,Systems,Systex;

Var Source:Pointer;

BEGIN
 InitSystems(suIsabel);
 Source:=@_VideoMode;
 DeleteFile('MODES.DRV');
 SetFile('MODES.DRV',0,Ofs(EndList)+1,Source^);
 DoneSystems;
END.