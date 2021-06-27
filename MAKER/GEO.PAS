Program MakerGeo;

Uses Adele,Systex,Systems,SysPlus,ResTex,ResServD,ResSaveD;

Var
 L:ArrayList;
 Q:DataSet;
 Handle:Hdl;

BEGIN
 Jump.FlagsMethod:=stupJumperSecure;
 InitSystems(suIsabel);
 If DeleteFile('\MALTE\DATA\GEO.DAT')<>0Then Begin
  WriteLn('Impossible d''effacer l''ancienne base de donn‚es GEO');
 End;
 Handle:=FileOpen('\SOURCE\CHANTAL\RESOURCE\COUNTRY\VILLES.SQL',fmRead);
 DBInit(Q,'\MALTE\DATA\GEO.DAT');
 DBCreateWithSQL(Q,L,Handle);
 DBDone(Q);
 FileClose(Handle);
END.