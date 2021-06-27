Uses Sess86,Adele,Systex,Systems,Sourcer,Video,Dials,Dialex,ResServDataBase;

Var
 Q:Session8086;

BEGIN
 InitSystems(suIsabel);
 InitMemManagers;
 DBInitServer(ChantalServer,MaltePath+'DATA\CHANTAL.DAT');
 SetVideoModeDeluxe(vmTxtC80);
 InitEnv;
{ S86LoadCom(Q,1,1,78,23,'G:\OS2\MDOS\COMMAND.COM');}
 S86LoadCom(Q,1,1,78,23,'TOOLS\TESTPROC.COM');
{ S86LoadCom(Q,1,1,78,23,'TOOLS\TESTVAR.COM');}
{ S86LoadCom(Q,1,1,78,23,'TOOLS\HELLO.COM');}
 Q.Log:=NewNBak('SESSION.LOG');
 OpCodeFormat:=fAsm;
 OpCodeCPU:=fINTEL;
 Q.CPU:=cpu80286;
 Q.Sourcer:=True;
 Q.CodeBrk:=$CD;
 S86Refresh(Q);
 Repeat
  S86BackOperation(Q);
  If(Q.Fault=sfBreakPoint)Then Begin
   S86OpenWatches(Q);
   S86RunWatches(Q);
   S86CloseWatches(Q);
  End
   Else
  If Q.Fault<>0Then Break;
{  If Q.NumInstr=78Then Begin
   Q.NumInstr:=Q.NumInstr;
  End;}
 Until KeyPress;
 S86Done(Q);
{ DoneLuxeVideo;}
 DoneMemManagers;
END.