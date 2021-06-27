Uses Adele,Systex,Systems;

{$I Library\CPU\Cyrix\SetCPUID.Inc}

BEGIN
 SetCPUID(True);
 InitSystems(suIsabel);
 WriteLn(CPUID);
END.