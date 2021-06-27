Program TestArj;

Uses Adele,Systex,Systems,Video,Dials,ResTex,ResUnPck;

Var Q:UnpackRec;

BEGIN
 InitSystems(suIsabel);
 InitVideo;
 InitEnv;

 RUInit(Q,'AC.ARJ','\ACSENDX.ASM');
 RURun(Q);
 RUDone(Q);
END.