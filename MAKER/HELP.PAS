Program Chantal;

Uses Adele,Systex,Systems,SysPlus,ResTex,ResServD,ResSaveD,Memories;

Var
 Q:DataSet;
 Code:Word;

Procedure OnStatusCompiler(Var X;Var Context;Line:LongInt);
Var
 Q:DataSet Absolute X;
Begin
 If Q.ErrCode>0Then Begin
  WriteLn('Erreur … la ligne ',Line,': ',HexWord2Str(Q.ErrCode));
  WriteLn(PChar(Q.PC));
  WriteLn(Spc(Q.ReadX),'^');
  Q.ErrCode:=0;
 End;
End;

Procedure Add(Const Source,Dest:String);
Var
 L:ArrayList;
Begin
 WriteLn('Traitement du Source: ',Source);
 DBOpenServerName(Q,Dest);
 ALLoadFileASCII(L,Source);
 If Not DBCreateWithSQL(Q,L,errHdl)Then WriteLn('Erreur pendant la compilation des donn‚es.');
 ALDone(L);
End;

Procedure AddFile(Const Source,Dest:String);
Var
 Handle:Hdl;
 L:ArrayList;
Begin
 FillClr(L,SizeOf(L));
 Handle:=FileOpen(Source,fmRead);
 If(Handle=errHdl)Then WriteLn('Fichier introuvable: '+Source)
  Else
 Begin
  WriteLn('Traitement du Source: ',Source);
  DBOpenServerName(Q,Dest);
  If Not DBCreateWithSQL(Q,L,Handle)Then WriteLn('Erreur pendant la compilation');
  FileClose(Handle);
 End;
End;

BEGIN
 InitSystems(suIsabel);
 DeleteFile('\MALTE\DATA\AIDE.DAT');
 DBInitServer(Q,'\MALTE\DATA\AIDE.DAT');
 Q.OnStatusCompiler:=OnStatusCompiler;
 DBLogin(Q,'ADMINISTRATOR','SYSTEM');
 AddFile('\SOURCE\CHANTAL\RESOURCE\COMPILER\ASM\INTRFUNC.SQL','AIDE:/Compilateur/Assembleur/InterruptionFonction.Dat');
 AddFile('\SOURCE\CHANTAL\RESOURCE\COMPILER\BASIC\HELPINST.SQL','AIDE:/Compilateur/Basic/Instruction.Dat');
 Add('\SOURCE\CHANTAL\RESOURCE\COMPILER\BASIC\HELPFONC.SQL','AIDE:/Compilateur/Basic/Fonction.Dat');
 Add('\SOURCE\CHANTAL\RESOURCE\NETWORKS\STARTVAR.SQL','AIDE:/Reseau/Novell/IDDemarrage.Dat');
 DBDone(Q);
END.
