Program MonsterBookForWindows;

{Uses Systex,Systems,Adele,WinTypes,WinProcs;

Var Handle:Hdl;FS,FP:Long;S:String;}

BEGIN
{ StrPCopy(@WindowTitle,'Monster Book pour Windows (L''Oeuvre inhumaine)');}
 InitSystems(suIsabel);
{ InitWinCrt;
 SetBkColor(DC,$00FF00);
 SetTextColor(DC,$FF0000);
 WriteLn(MaxAvail);
 PutTxtXY(5,5,'Salut',$1F);
 PutTxtXY(7,6,'Merde',$C3);
 ReadKey;
 Handle:=Open('D:\SOURCE\CHANTAL\DRV.ASM',fmRead);
 If(Handle<>errHdl)Then Begin
  FP:=0;FS:=FileSize(Handle);
  Repeat
   __GetAbsFileTxtLn(Handle,FP,S);
   WRiteLn(S);
   If(KeyPress)Then Break;
  Until FP>=FS;
  Systems.Close(Handle)
 End
  Else
 WriteLn('Impossible d''ouvrir!');
 ReadKey;
 DoneWinCrt;}
END.