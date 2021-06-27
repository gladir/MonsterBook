{$I DEF.INC}

Unit C2Pas;

{ДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДД}
                                  INTERFACE
{ДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДД}

Procedure C2Pascal(Const Source:String);

{ДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДД}
                                 IMPLEMENTATION
{ДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДД}

Uses Systex,Memories,Systems,Compiler,Dials,DialPlus;

{$I \Source\Chantal\Library\Compiler\C\C2Pas.Inc}

Procedure C2Pascal(Const Source:String);
Var
 Q:SwitchC2Pascal;
Begin
 InitC2Pas(Q);
 WEInitO(Q.W,55,15);
 WEPushWn(Q.W);
 WEPutWnKrDials(Q.W,'Conversion C … Pascal');
 WEBar(Q.W);
 WELn(Q.W);
 WEPutTxtLn(Q.W,'ђtat                           = Conversion');
 WEPutkHorDn(Q.W,'Annuler');
{ TimeIn:=GetRawTimer;}
 Q.NameC:=Source;
 Q.SourceName:=Source;
 Q.HandlePas:=FileCreateAndBackup(Path2NoExt(Source)+'.PAS');
 If(Q.HandlePas<>errHdl)Then SetFilePos(Q.HandlePas,0);
 PutInfo(Q);
 ConvFile(Q,Source);
 DoneC2Pas(Q);
 PutInfo(Q);
 WEPutTxtXY(Q.W,33,1,StrUSpc('Terminer.',32));
 While WEOk(Q.W)do;
 WEDone(Q.W);
End;

{ДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДДД}
END.
