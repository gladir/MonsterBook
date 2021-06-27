Program TruncTxt;

Uses Systex,Systems;

Var Handle,Target:Hdl;
    S:String;
    P,L,FP,FS:Long;

BEGIN
 InitSystems(suIsabel);
 WriteLn('Tronqueur de texte ayant trop de ligne');
 WriteLn('Limite fix‚ … 1 000');
 Handle:=Open(ParamStr(1),fmRead);
 If(Handle=errHdl)Then Begin
  WriteLn('Erreur: Fichier introuvable!');
  Halt(1);
 End;
 FP:=0;FS:=FileSize(Handle);L:=0;P:=0;
 Target:=New(Path2NoExt(ParamStr(1))+'.'+StrW(P));
 If(Target=errHdl)Then Begin
  WriteLn('Erreur de cr‚ation de fichier');
  Halt(2);
 End;
 Repeat
  __GetAbsFileTxtLn(Handle,FP,S);
  PutFileTxtLn(Target,S);
  Inc(L);
  If L>=1000Then Begin
   Inc(P);L:=0;
   Close(Target);
   Target:=New(Path2NoExt(ParamStr(1))+'.'+StrW(P));
   If(Target=errHdl)Then Begin
    WriteLn('Erreur de cr‚ation de fichier');
    Halt(2);
   End;
  End;
 Until FP>=FS;
 Close(Target);
 Close(Handle);
END.