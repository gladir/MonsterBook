Program ToStrBin;

Uses Systex,Systems;

Var Source,Target:Hdl;
    Path:String;
    Buffer:Array[0..2047]of Byte;
    P:Long;I:Word;Letter:Char;

BEGIN
 InitSystems(suIsabel);
 Path:=ParamStr(1);Source:=Open(Path,fmRead);
 If(Source=errHdl)Then Begin;WriteLn('Fichier introuvable!');Halt(1)End;
 Letter:='A';Target:=NewNBak(Path2NoExt(Path)+Letter+'.SBN');
 If(Target=errHdl)Then Begin;WriteLn('Erreur de cr‚ation de fichier!');Halt(2)End;
 P:=0;
 Repeat
  _GetAbsRec(Source,P,SizeOf(Buffer),Buffer);
  For I:=0to SizeOf(Buffer)-1do PutFileTxtLn(Target,BinByte2Str(Buffer[I]));
  Inc(P,SizeOf(Buffer));
  If P>16384Then Begin
   Close(Target);
   Inc(Letter);
   Target:=NewNBak(Path2NoExt(Path)+Letter+'.SBN');
  End;
 Until P>FileSize(Source);
 Close(Target);
 Close(Source);
 DoneSystems;
END.