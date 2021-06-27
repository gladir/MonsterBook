Program Lotus;
{$I DEF.INC}
Uses {$IFDEF Adele}Adele,{$ELSE}Chantal,{$ENDIF}
     Systex,Systems,Video,Mouse,Dials,Calc;

Var W:Calc.Lotus;

BEGIN
 InitSystems(suIsabel);
 InitVideoDeluxe;
 InitEnv;
 __InitMouse;
 SCInit(W);
 SCRun(W);
 SCDone(W);
 DoneLuxeVideo;
END.