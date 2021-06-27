Program AVE2;

Uses Adele,Systex,Systems,Video,Mouse,Dials,FileMana,AntiVirus;

Const
 avSearchInMemory=$F001;
 avSearchInDisk=$F002;
 avExit=$F0FF;
 Sig:Array[0..9]of Byte=($E8,$00,$00,$5E,$83,$EE,$03,$B8,$CE,$7B);

Procedure SearchInDisk(Dsk:Byte);
Var
 W:Window;
 Buf1:HeaderEXE;
 Buf2:Array[0..30]of Byte;
 Hp,Cs,Ip:Word;
 Ep:LongInt;
 Infected:Integer;
 Attrib:Word;Drv:Char;

 Function Compare(B:Array Of Byte):Boolean;
 Var
  C:Byte;
  IsIt:Boolean;
 Begin
  IsIt:=Ya;C:=0;
  While(C<=9)and(IsIt)do Begin
   If B[C]<>Sig[C]Then IsIt:=No;
   Inc(C);
  End;
  Compare:=IsIt;
 End;

 Procedure FExe(N:String);Var Handle:Hdl;Begin
  If Pos('.EXE',N)<>0Then Begin
   Handle:=FileOpen(N,fmRead);
   If(Handle<>errHdl)Then Begin
    _GetAbsRec(Handle,0,SizeOf(Buf1),Buf1);
    Ep:=0;
    If Buf1.Sign='MZ'Then Begin
     Hp:=Buf1.SizeOfHeader;
     Ip:=Buf1.Ip;
     Cs:=Buf1.OfsLoad;
     Ep:=Cs+Hp;
     Ep:=((Ep shl 4)+Ip)and$FFFFF;
    End;
    _GetAbsRec(Handle,Ep,SizeOf(Buf2),Buf2);
    N:='Examine le programme '+Path2NoDir(N)+': ';
    If Compare(Buf2)Then Begin
     AddStr(N,'InfectÇe!');
     Inc(Infected);
    End
     Else
    AddStr(N,'Non contaminÇ.');
    WEPutTxtXY(W,0,3,StrUSpc(N,70));
    FileClose(Handle);
   End;
  End;
 End;

 Procedure SDir(Const SPath:String);Var S:SearchRec;Begin
  WEPutTxtXY(W,7,2,StrUSpc(Copy(SPath,3,255),70));
  FindFirst(SPath+'*.*',faAnyFile Xor faVolumeID,S);
  If S.Name='.'Then Begin
   FindNext(S);
   FindNext(S);
  End;
  If(SysErr=0)and(Not(sfaDir in S.Attr.Flags))Then Begin
   FExe(SPath+S.Name);
   FindNext(S);
  End;
  While SysErr=0do Begin
   If(sfaDir in S.Attr.Flags)Then Begin
    SDir(SPath+S.Name+'\');
    WEPutTxtXY(W,7,2,Copy(SPath,3,255));
   End
    Else
   FExe(SPath+S.Name);
   FindNext(S);
  End;
 End;

Begin
 If Dsk=0Then Drv:=GetDrv Else Drv:=Chr(64+Dsk);
 WEInitO(W,70,10);
 WEPushWn(W);
 WEPutWnKrDials(W,'Recherche de Virus sur disque');
 WEPutTxtXY(W,0,1,'UnitÇ '+Drv+':');
 WEPutTxtXY(W,0,2,'Chemin');
 Infected:=0;
 SDir(Drv+':\');
 WEDone(W);
 DialogMsgOk(IntToStr(Infected)+' fichier contaminÇ trouvÇ.')
End;

Function SearchInMemory(Prompt:Bool):Boolean;
Var
 I:Word;
 L,W:Window;
Begin
 SearchInMemory:=No;
 WEPushEndBar(L);
 WEPutLastBar('Recherche de Virus en mÇmoire en cours parmi une banque de '+
               IntToStr(MaxVirusBank)+' Virus...');
 WEInitO(W,40,4);
 WEPushWn(W);
 WEPutWnKrDials(W,'Recherche en mÇmoire de Virus');
 WEPutTxtXY(W,0,1,'Virus:');
 WESetKrHigh(W);
 For I:=0to(MaxVirusBank)do Begin
  WEPutTxtXY(W,0,2,StrUSpc(StrPas(PChr(AntiVirusBank[I].PChr)),40));
  If(AntiVirusBank[I].Func)Then Begin
   ErrMsgOk('Virus dÇtectÇ: '+StrPas(PChr(AntiVirusBank[I].PChr)));
   SearchInMemory:=Ya;
   Break;
  End;
 End;
 WEDone(W);
 If(Prompt)Then DialogMsgOk('Aucun des virus qu''AVê connaåt n''est dÇtectÇ!');
 WEDone(L);
End;

Var K:Word;

BEGIN
 InitSystems(suIsabel);
 InitMemManagers;
 SetVideoModeDeluxe(vmTxtDef);
 AppInit('Anti-Virus êva (AVê)  Version 1.1',$19,MtxBleuet);
 __InitMouse;
 PMInit;
 PMAddMnu('^D^Çtection');
  PMAddItemKey('^M^Çmoire',kbNoKey,avSearchInMemory,'Recherche en mÇmoire la prÇsence d''un virus...');
  PMAddItemKey('^D^isque',kbNoKey,avSearchInDisk,'Recherche sur disque la prÇsence d''un virus...');
  PMAddBarItem;
  PMAddItemKey('^Q^uitter',kbAltX,avExit,'Quitter l''Anti-Virus!');
 PMSetWinBar(0,1,MaxXTxts);
 PMPutMnuBar;
 SearchInMemory(No);
 __ShowMousePtr;
 ClrKbd;
 _InitKbd;
 Repeat
  {Repeat
   _BackKbd;
  Until(KeyPress)or(GetMouseButton<>0);
  If(KeyPress)Then K:=ReadKey
              Else K:=kbMouse;
  K:=_PMWaitForMnuAction(K);}
  K:=PMWaitForMnuAction;
  Case(K)of
   avSearchInMemory:SearchInMemory(Ya);
   avSearchInDisk:SearchInDisk(SelectDisk(0));
   kbAltX,avExit:Break;
  End;
 Until No;
 DoneLuxeVideo;
 DoneMemManagers;
END.
