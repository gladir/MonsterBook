Uses Adele,Systex,Systems,Video,Dials,WorkShop;

Var Q:WorkShopApp;

BEGIN
 InitSystems(suIsabel);
 {InitVideo;}
 SetVideoMode(vmTxtC80x60);
 WSLoad(Q,0,0,MaxXTxts,MaxYTxts,'..\EDITE_PE\EXPLORER.EXE');
 ReadKey;
END.