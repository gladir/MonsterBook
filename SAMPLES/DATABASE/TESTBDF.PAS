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
{ ADBOpen(DataBase,1,1,MaxXTxts-1,MaxYTxts-1,'\ATLAS\LISTES\INFORMAT.IC\SERIALS.DBF');}
 ADBOpen(DataBase,1,1,MaxXTxts-1,MaxYTxts-1,'TOOLS\GRIFORM\HARDDISK.DBF');
 ADBRun(DataBase);
 ADBDone(DataBase);
 DoneLuxeVideo;
END.