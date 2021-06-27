Uses Systex,Systems,Video,ResTex,ResLoadImage,ResServImage,ResSaveImage;

Var Q,Q2:XInf;

BEGIN
 InitSystems(suIsabel);
 InitMemManagers;
 SetVideoMode(vmGrf320x200c256);
 RILoadImage('C:\MALTE\ICON\WRITE.ICO',diAutoDetect,0,$FFFF,
                     rmXms,fpNone,Q);
 RIPutImage(Q,0,0,32,32);
 RISaveImage('C:\SOURCE\CHANTAL\WRITE.ICO',Q);
 RILoadImage('C:\SOURCE\CHANTAL\WRITE.ICO',diAutoDetect,0,$FFFF,
                     rmXms,fpNone,Q2);
 RIPutImage(Q2,32,0,32,32);
 ReadKey;
 DoneMemManagers;
END.