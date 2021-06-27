Unit Server;

INTERFACE

Uses Isatex;

Procedure SEExec(Const URL:String);

IMPLEMENTATION

Uses Systex,Memories,Systems,SysPlus,Basic;

Procedure SEExec(Const URL:String);
Var
 Q:BasicStruct;
 Source:ArrayList;
 P:Byte;
 SourceName:String;
Begin
 SourceName:=URL;
 P:=Pos('?',SourceName);
 If P>0Then Left(SourceName,P-1);
 ASPInit(Q,Path2NoExt(SourceName)+'.HTM');
 ALLoadFileASCII(Source,SourceName);
 BasicRun(Q,Source);
 ALDone(Source);
 ASPDone(Q);
End;

END.