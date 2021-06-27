Uses Sess86,Adele,Systex,Systems,Dialex,ResServD,Sourcer,Video,Dials;

Var Q:Session8086;

BEGIN
 InitSystems(suIsabel);
 InitMemManagers;
 DBInitServer(ChantalServer,MaltePath+'DATA\CHANTAL.DAT');
 SetVideoMode(vmTxtC80);
 InitEnv;
 S86InitBootFloppy(Q,0,0,79,24);
 Q.Log:=NewNBak('SESSION.LOG');
 OpCodeFormat:=fAsm;
 OpCodeCPU:=fINTEL;
 Q.CPU:=cpui386;
 Q.Sourcer:=True;
 Repeat
  S86BackOperation(Q);
  If Q.Fault<>0Then Break;
 Until KeyPress;
 S86Done(Q);
 DoneMemManagers;
END.