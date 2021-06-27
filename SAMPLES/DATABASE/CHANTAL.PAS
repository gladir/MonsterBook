Uses Adele,Systex,Systems,Video,Mouse,Dialex,Dials,
     Isatex,ResServDataBase,AppDB;

Var
 DataBase:DataBaseApp;

BEGIN
 InitSystems(suIsabel);
 SetVideoModeDeluxe(vmTxtDef{vmGrf640x480c16});
 DBInitServer(ChantalServer,MaltePath+'DATA\CHANTAL.DAT');
 __InitMouse;
 InitEnv;
 ADBOpen(DataBase,1,1,MaxXTxts-1,MaxYTxts-1,MaltePath+'DATA\CHANTAL.DAT');
 ADBRun(DataBase);
 ADBDone(DataBase);
 DoneLuxeVideo;
END.
