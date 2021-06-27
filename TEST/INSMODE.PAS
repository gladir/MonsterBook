Uses Systems;

BEGIN
 WriteLn(GetInsMode);
 SetInsMode(False);
 WriteLn(GetInsMode);
 SetInsMode(True);
 WriteLn(GetInsMode);
 SetInsMode(False);
END.