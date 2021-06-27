Program ShellDos;

Uses Adele,Systex,Systems,Isatex,Video,Dials,ToolTerm;

Var Q:Prompt;

BEGIN
 InitSystems(suIsabel);
 InitVideoDeluxe;
 InitEnv;
 PDInit(Q,0,0,MaxXTxts,MaxYTxts);
 PDRun(Q);
 PDDone(Q);
 Unluxe;
END.