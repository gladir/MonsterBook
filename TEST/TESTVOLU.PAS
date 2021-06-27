Uses Dos,Systex,SysInterne,Systems;

Var Q:BF;NmF,I:Word;H:SearchRec;

BEGIN
 InitSystems(suIsabel);
{ BFInit(Q);}
 If MaxAvail<65520Then Q.SizeB:=MaxAvail Else Q.SizeB:=65520;
 Q.B:=MemAlloc(Q.SizeB);NmF:=0;
 LoadPathByFileImage(Q,'C:\DOWNLOAD\DRDOS703.IMG',NmF,'C:\DRDOS\*.*',faAll);
 For I:=0to NmF-1do Begin
  BFGetFile(Q,I,H);
  WriteLn(H.Name);
 End;
 WriteLn(NmF);
END.