Uses Adele,Systex,Systems,Video,Goldnaxe;

BEGIN
 InitSystems(suIsabel);
 SetVideoMode(vmGrf640x480c256);
 FillArc(50,50,0,180,50,Yellow);
 FillArc(150,50,270,360,50,Blue);
 FillArc(250,50,170,360,50,Green);
 FillArc(350,50,0,360,50,Cyan);
 FillArc(450,50,90,360,50,LightCyan);
 FillArc(550,50,0,290,50,LightRed);
 ReadKey;
END.