{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                                                                         Û
 ³                         UnCode - Version 1.1                            Û
 ³                              1998/05/15                                 Û
 ³                                                                         Û
 ³                                 pour                                    Û
 ³                    L'ensemble Malte Genesis V: AdŠle                    Û
 ³                                                                         Û
 ³          Tous droits r‚serv‚s par les Chevaliers de Malte (C)           Û
 ³                                                                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Nom du programmeur
 ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

  Sylvain Maltais


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Ce petit programme est un d‚compilateur de code machine de la famille des
 micro-processeur 80x86.


 ParamŠtres
 ÍÍÍÍÍÍÍÍÍÍ

  Param1       Nom du fichier de code machine.
}

Program Uncode;

Uses Systex,Systems,Sourcer;

Var Name,XS,TStr,St:String;S,O,O2,IO:Wd;Dump,FS:Long;Handle:Hdl;

BEGIN
 InitSystems(suIsabel);
 Sourcer.OpCodeFormat:=fAsm;
 Name:=ParamStr(1);S:=Seg(XS);O:=Ofs(XS);
 Dump:=0;Handle:=Open(Name,fmRead);
 If(Handle<>errHdl)Then Begin
  _GetAbsRec(Handle,Dump,SizeOf(XS),XS);
  FS:=FileSize(Handle);
 End
  Else
 Begin
  WriteLn('Fichier introuvable!');
  Halt(1);
 End;
 Repeat
  St:=HexLong2Str(Dump)+'h  ';O2:=O;TStr:=Decode(Mem[S:0],O);Inc(Dump,O-O2);
  For IO:=0to O-O2-1do Begin
   AddStr(St,HexByte2Str(Mem[S:O2+IO]));
   IncStr(St,' ');
  End;
  St:=StrUSpc(St,40);
  AddStr(St,TStr);
  WriteLn(St);
  If O>Ofs(XS)+200Then Begin
   _GetAbsRec(Handle,Dump,SizeOf(XS),XS);
   S:=Seg(XS);O:=Ofs(XS);
  End;
 Until Dump>=FS;
 Close(Handle);
END.