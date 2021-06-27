Uses Systex,Systems,Restex,Registry;

Var
 Q:RegistryObject;
 X:Byte;

BEGIN
 InitSystems(suIsabel);
 DeleteFile('MALTEREG.REG');
 ROOpen(Q,'MALTEREG.REG');
 ROCreateKeyFormat(Q,HKEY_CURRENT_USER,'Users/Teste','',tdDirectory,Q);
 ROCreateKeyFormat(Q,HKEY_CURRENT_USER,'Users/Teste','XYZ',tdDirectory,Q);
 ROCreateKeyFormat(Q,HKEY_CURRENT_USER,'Users/Teste','XYZ',tdDirectory,Q);
 ROCreateKeyFormat(Q,HKEY_CURRENT_USER,'Users/Poke','XY',tdDirectory,Q);
 ROCreateKeyFormat(Q,HKEY_CURRENT_USER,'Users/Poke','XY',tdDirectory,Q);
 ROCreateKeyFormat(Q,HKEY_CURRENT_USER,'Users/Poke','XY',tdDirectory,Q);
 X:=14;
 ROCreateKeyFormat(Q,HKEY_CURRENT_USER,'Users/Poke','XY1',tdByte,X);
 X:=0;
 ROReadKey(Q,HKEY_CURRENT_USER,'Users/Poke','XY1',X);
 WriteLn(X);
(* ROOpenKey(Q,'Software\Test1\Test2\Test3\Test4\Test5\Test6\Test7',True);
 ROOpenKey(Q,'Software\TestA\TestB\TestC',True);
 _ROCreateKey(Q,'Software','MonsterBook');
 _ROCreateKey(Q,'Software/MonsterBook','CurrentVersion');
 RORegFindFirst(Q,{PChr(PChar('SOFTWARE'))}NIL,Info);
 Repeat
  WriteLn('Nom: ',StrPas(Info.Name));
 Until Not RORegFindNext(Q,Info);*)
 RODone(Q);
END.