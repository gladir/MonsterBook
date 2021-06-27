Uses Adele,Systex,Systems,Video,Mouse,Dials,Session;

Var S:SessionRec;

BEGIN
 InitSystems(suIsabel);
 SetVideoModeDeluxe(vmGrf640x480c65536);
 InitEnv;
 __InitMouse;
 SessionOpen(S,2,2,MaxXTxts-2,MaxYTxts-3,'G:\DRDOS\COMMAND.COM');
{ SessionOpen(S,2,2,MaxXTxts-2,MaxYTxts-3,'C:\SYMANTEC\NC3\NC.EXE');}
END.