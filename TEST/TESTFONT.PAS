Uses Adele,Systex,Systems,Video;

Var S:String;I:Byte;

BEGIN
 InitSystems(suIsabel);
 CheckSVGA:=Ya;
 SetVideoModeDeluxe(vmGrf1024x768c256);
 If Not LoadQQF('News 60')Then Halt(1);
 S[I]:=#255;
 For I:=1to 255do S[I]:=Chr(I);
 OutTextXY(0,0,S,$FC);
 ReadKey;
END.