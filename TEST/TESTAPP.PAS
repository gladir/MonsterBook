{ D‚velopper par l'OverCode }

Program Testdeprojet;

Uses Systex,Systems,Video,Mouse,Dials;

BEGIN
 InitSystems(suIsabel);
 PathDskSwp:=FileExpand('F:\SOURCE\CHANTAL\TEST.$$$');
 InitMemManagers;
 InitVideoDeluxe;
 __InitMouse;
 AppInit('Test de projet',$78,MtxBleuet);
 ReadKey; { ... Chang‚ le programme ici ... }
 DoneLuxeVideo;
 DoneMemManagers;
END.
