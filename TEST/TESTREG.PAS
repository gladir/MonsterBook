Uses Systex,Systems,Registry;

Var
 Q:RegistryObject;
 Info:RegistrySearch;

BEGIN
 InitSystems(suIsabel);
 ROInitRegistry(Q);
 ROOpenKey(Q,'Users/Teste',True);
 ROOpenKey(Q,'Software\Test1\Test2\Test3\Test4\Test5\Test6\Test7',True);
 ROOpenKey(Q,'Software\TestA\TestB\TestC',True);
 _ROCreateKey(Q,'Software','MonsterBook');
 _ROCreateKey(Q,'Software/MonsterBook','CurrentVersion');
 RORegFindFirst(Q,{PChr(PChar('SOFTWARE'))}NIL,Info);
 Repeat
  WriteLn('Nom: ',StrPas(Info.Name));
 Until Not RORegFindNext(Q,Info);
END.