Uses Adele,Systex,Systems,Video,Keyboard;

Var
 I:Byte;

BEGIN
 InitSystems(suIsabel);
 InitVideo;
 InitInt09;
 Repeat
  For I:=0to 127do Begin
   SetChr(I,0,Char(Key[I]));
   If Key[I]Then PutTxtXY(0,4,HexByte2Str(I)+'h',LightRed);
  End;
  If(KeyPress)Then Begin
   Case(ReadKey)of
    kbAltEnter:PutTxtXY(0,10,'Key',Yellow);
    kbEsc:Break;
   End;
  End;
 Until False;
 RestoreInt09;
END.

