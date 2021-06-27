Program MakerGraph;

Uses Adele,Systex,Systems,SysPlus,ResTex,ResServDataBase,ResSaveDataBase;

Var L:RBuf;
    Q:DataSet;
    Code:Word;

BEGIN
 InitSystems(suIsabel);
 DelFile('\MALTE\DATA\GRAPH\TIFF.DAT');
 RBLoadFileASCII(L,'\SOURCE\CHANTAL\RESOURCE\GRAPH\TIFF.SQL');
 DBInit(Q,'\MALTE\DATA\GRAPH\TIFF.DAT');
 WriteLn(DBCreateWithSQL(Q,L));
 DBDone(Q);
END.