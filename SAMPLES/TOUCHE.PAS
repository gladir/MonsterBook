Uses Systex,Systems;

Var K:Word;

BEGIN
 InitSystems(suIsabel);
 Repeat
  K:=ReadKey;
  WriteLn(HexWord2Str(K));
 Until K=kbEsc;
 DoneSystems;
END.