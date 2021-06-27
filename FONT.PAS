Uses Adele,Systex,Systems,Video,Dials,FontMana;

BEGIN
 InitSystems(suIsabel);
 CheckSVGA:=Ya;
 InitMemManagers;
 SetVideoModeDeluxe(vmGrf640x480c256);
 InitEnv;
 SelectFont;
 DoneMemManagers;
END.

