Program MakerPCIVendor;

Uses Adele,Systex,Systems,SysPlus,ResTex,ResServDataBase,ResSaveDataBase;

Var L:RBuf;
    Q:DataSet;
    Code:Word;

BEGIN
 InitSystems(suIsabel);
 DelFile('\MALTE\DATA\MATERIEL\PCIVDI.DAT');
 RBLoadFileASCII(L,'\SOURCE\CHANTAL\RESOURCE\HARDWARE\PCIVDI.SQL');
 WriteLn('In:',MemAvail);
 DBInit(Q,'\MALTE\DATA\MATERIEL\PCIVDI.DAT');
 DBCreateWithSQL(Q,L);
 DBDone(Q);
 DBInit(Q,'\MALTE\DATA\MATERIEL\PCIVDI.DAT');
 Code:=$8086;
 WriteLn(DBLocateAbs(Q,0,Code));
 DBDone(Q);
 WriteLn('Out:',MemAvail);
END.