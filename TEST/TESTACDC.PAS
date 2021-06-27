{$M 32768,0,655360}

Uses Adele,Systex,Systems,Video,Dials,Isatex,GloDraw;

Var Q:GlobalDraw;

BEGIN
 InitSystems(suIsabel);
 InitMemManagers;
 SetVideoMode(vmGrf800x600c32768{vmGrf640x480c256});
 InitEnv;
 GDInit(Q,0,1,MaxXTxts,MaxYTxts-1);
 GDRun(Q);
 GDDone(Q);
 DoneMemManagers;
END.

