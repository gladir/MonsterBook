Program Termalte;

Uses Systex,Isatex,Systems,Video,Dials,ToolInfo,TMDials;

Const tmFileExit=$F010;
 mFile:Array[0..Length('^F^ichier')]of Char='^F^ichier'#0;
 mExit:Array[0..Length('^Q^uitter')]of Char='^Q^uitter'#0;

Var M:PullMnu;
    T:Term;

BEGIN
 InitSystems(suIsabel);
 InitVideoDeluxe;
 InitEnv;
 PMInit;
 PMAddMnu(@mFile);
  PMAddItemKey(@mExit,kbAltX,tmFileExit,'');
 PMPutMnuBar;
 SetAllKr($1B,$1F);
 PutLastBar(2,'^F9^ Analyse Modem  ^F10^ HostMode');
 TAInit(T,1,wnMax-1,4,'');
 Repeat
  TMRefresh(T);
  Case TARun(T)of
   kbF9: ModemDoctor;
   kbF10: TAHostMode(T);
   kbAltF3: Break;
  End;
 Until No;
 TADone(T);
 PMDone;
 DoneLuxeVideo;
 DoneSystems;
END.