Program PrnGat;

Uses Systex,Systems,Video,Mouse,Dials,Isatex,ToolPrn;

Var Q:Edt;

BEGIN
 WriteLn('PrnGat Version 2.0 - Imprimeur de fichier de format Gat');
 InitSystems(suIsabel);
 InitVideo;
 __InitMouse;
 InitEnv;
 FillClr(Q,SizeOf(Q));PrnOutput:=0;
 WriteLn;
 Q.EditName:=ParamStr(1);
 If(Q.EditName='')or(Q.EditName='/?')Then Begin
  WriteLn('Veuillez sp‚cifier le fichier … imprimer:');
  WriteLn;
  WriteLn(' PrnGat [nom de fichier]');
  WriteLn;
  WriteLn('o— nom de fichier est le nom du fichier de format Gat … faire imprimer.');
  Halt;
 End;
 If Path2NoExt(Q.EditName)=''Then AddStr(Q.EditName,'.GAT');
 WriteLn;
 WriteLn(' Impression du fichier: ',Q.EditName);
 PrnGatEdt(Q);
END.