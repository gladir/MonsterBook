{$M 30000,0,655360}

Uses Adele,Systex,Systems,Video,Dials,Dialex,DialTree,Restex,ResLoadI,ResServI,Mouse;

Var
 Q:DialogTreeObject;

BEGIN
 InitSystems(suIsabel);
 InitMemManagers;
 SetVideoModeDeluxe(vmGrf640x480c65536{vmTxtC80});
 __InitMouse;
 _InitAbsEnv(8);
 RILoadImage(MaltePath+'ICON\FOLDER.ICO',diAutoDetect,0,$FFFF,rmAllResSteady,[],FolderIcon^);
{ PutTxtXY(0,0,SelectDirectory('S‚lectionner un r‚pertoire','D:\SOURCE\',True),Red);

{ DTInitSystem(Q,1,1,50,20);
 DTRefresh(Q);
 DTRun(Q);
 DTDone(Q);}
{ ConfigSystem('Propri‚t‚ systŠme');}
 FullConfigSystem;
 DoneLuxeVideo;
 DoneMemManagers;
END.