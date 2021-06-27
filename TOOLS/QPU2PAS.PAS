Program QPU2Pascal;

Uses Systex,Systems;

{$I \Source\Chantal\Library\Compiler\Pascal\QPUHeader.Inc}

Var HandleSrc,T:Hdl;Header:QPUHeader;XUses:QPUUses;I:Wd;

BEGIN
 InitSystems(suIsabel);
 HandleSrc:=Open(ParamStr(1),fmRead);
 If(HandleSrc=errHdl)Then Begin;WriteLn('Fichier introuvable!');Halt(1)End;
 _GetAbsRec(HandleSrc,0,SizeOf(Header),Header);
 If(Header.Sign<>QPUSignMicrosoft)Then Begin;WriteLn('Erreur d''entˆte de fichier!');Halt(1)End;
 T:=NewNBak(Path2NoExt(ParamStr(1))+'.PAS');
 If(T=errHdl)Then Begin;WriteLn('Erreur de cr‚ation de fichier!');Halt(1)End;
 PutFileTxtLn(T,'Unit '+Header.UnitName+';');
 PutFileLn(T);
 PutFileTxt(T,'Uses ');
 For I:=1to(Header.NmUses)do Begin
  _GetRec(HandleSrc,SizeOf(XUses),XUses);
  PutFileTxt(T,XUses.Name);
  If(I<Header.NmUses)Then PutFileTxt(T,',')
 End;
 PutFileTxtLn(T,';');
 Close(T);
 Close(HandleSrc)
END.