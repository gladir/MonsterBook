{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                                                                         �
 �                         UnCode - Version 1.1                            �
 �                              1998/05/15                                 �
 �                                                                         �
 �                                 pour                                    �
 �                    L'ensemble Malte Genesis V: Ad둳e                    �
 �                                                                         �
 �          Tous droits r굎erv굎 par les Chevaliers de Malte (C)           �
 �                                                                         �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Nom du programmeur
 袴袴袴袴袴袴袴袴袴

  Sylvain Maltais


 Description
 袴袴袴袴袴�

  Ce petit programme est un d괹ompilateur de code machine de la famille des
 micro-processeur 80x86.


 Param둻res
 袴袴袴袴袴

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