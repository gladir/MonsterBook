Uses Adele,Systex,Systems,Video,Mouse,Dials;

Var OldScr:ImgRec;

Function KeyPress:Bool;Assembler;ASM
 MOV AX,11h
 INT 16h
 MOV AL,No
 JZ  @ebKP
 MOV AL,Ya
@ebKP:
END;

BEGIN
 InitSystems(suIsabel);
{ SetVideoModeDeluxe(vmGrf320x200c256);}
 If(KeyPress)Then WriteLn('Salut');
 ReadKey;
END.