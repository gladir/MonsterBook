Uses Systex,VideoMode;

Var M:MIV;P:PIV;

BEGIN
 P.ProcSetVideoMode:={63}66;
 WriteLn(SetVideoModePrim({vmTxtC80x60}vmGrf640x480c256,P,M));
END.