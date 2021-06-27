Program Carnet;

Uses Systex,Systems,SysPlus,ResTex,ResLoadDataBase,ResServDataBase,ResSaveDataBase;

Var
 L:RBuf;
 Q:DataSet;

BEGIN
 InitSystems(suIsabel);
 RBLoadFileASCII(L,'\SOURCE\CHANTAL\RESOURCE\CARNET\PERSONNE.SQL');
 DBInit(Q,'\MALTE\DATA\CARNET\PERSONNE.DAT');
 DBCreateWithSQL(Q,L);
 DBDone(Q);
 RBDone(L);
 RBLoadFileASCII(L,'\SOURCE\CHANTAL\RESOURCE\CARNET\TELEPHONE.SQL');
 DBInit(Q,'\MALTE\DATA\CARNET\TELEPHONE.DAT');
 DBCreateWithSQL(Q,L);
 DBDone(Q);
 RBDone(L);
END.