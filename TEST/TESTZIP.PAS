Uses Systex,Systems,UnZip;

PROCEDURE MyReportProc( Retcode : longint; Rec : pReportRec );Begin
End;

Var
 Count:Integer;
 Q:ZipClass;

BEGIN
 InitSystems(suIsabel);
 UnzipInit(Q);
 Count:=FileUnzip(Q,'test.zip', 'c:\temp', '*.*', MyReportProc, Nil);
 UnzipDone(Q);
END.