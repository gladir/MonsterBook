Uses Systex,Adele,Systems,Video;

BEGIN
 InitSystems(suIsabel);
 SetVideoModeDeluxe(vmGrf640x480c256);
 ClrScr($F0);
 PutTxtFade(0,0,'Test....test...test...',$0);
 ReadKey;
END.