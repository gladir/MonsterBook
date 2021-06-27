Uses Systems;

BEGIN
 WriteLn(GetCapsLck);
 SetCapsLck(False);
 WriteLn(GetCapsLck);
 SetCapsLck(True);
 WriteLn(GetCapsLck);
 SetCapsLck(False);
END.