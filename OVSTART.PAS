Unit OVStart;

INTERFACE

Procedure Start;

IMPLEMENTATION

Uses Systex,Systems,Dials,Isatex,
     OVIde,Editor,EdtSearc,DialPlus,Apps;

Procedure Start;Var Handle:Hdl;P,FS:Long;SP,SP2:Byte;XP,YP:Word;S:String;Begin
 {Configuration des extensions par d‚faut de l'‚diteur}
 ExtBas:=PChr(PChar('*.BAS'));
 ExtPas:=PChr(PChar('*.PAS;*.INC'));
 ExtAsm:=PChr(PChar('*.ASM;*.ASO;*.MAC'));
 {Charge le Desktop}
 P:=0;
 Handle:=FileOpen(MaltePath+'OVP.DSK',fmRead);
 If(Handle<>errHdl)Then Begin
  FS:=FileSize(Handle);
  If FS>0Then Begin
   WEPutLastBar('Chargement du "desktop" en cours, patientez s''il vous plaŒt,...');
   Repeat
    _GetAbsFileTxtLn(Handle,P,S);
    If GetSysErr<>0Then Break;
    Inc(P,Length(S)+2);
    If CmpLeft(S,'ED:')Then Begin
     SP:=Pos(' ',S);
     If SP=0Then SP:=255 Else Dec(SP,4);
     If(HLoad(Windows,snEdt,Copy(S,4,SP)))and(SP<>255)Then Begin
      Inc(SP,5);SP2:=Pos(',',S);
      XP:=StrToWord(Copy(S,SP,SP2-SP));
      YP:=StrToWord(Copy(S,SP2+1,255));
      TEGotoXY(EditorApp(HPtr(Windows)^),XP,YP);
     End;
    End
     Else
    Break;
   Until P>FS;
  End;
  FileClose(Handle);
 End;
End;

END.