{$I DEF.INC}

Uses
 Isatex,Systex,Editex;

{$IFDEF Educative}
 Procedure InputSearchVerb;
{$ENDIF}
Procedure SearchAgain;
Procedure SearchFind;
Procedure SearchReplace;
Procedure SearchProc;
Function  WinSearchData(Mode:SearchDataMode;Var XData:SearchDataRec):Boolean;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                               IMPLEMENTATION
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses
 Adele,Mouse,ToolTime,Systems,Video,Dials,DialPlus,Editor,
 {$IFDEF FullVersion}
  MBCortex,
  MalEnv,
 {$ENDIF}
 {$IFDEF BureauVersion}
  MBBCrtex,
  MalBEnv,
 {$ENDIF}
 {$IFDEF Educative}
  Besch,
 {$ENDIF}
 ToolView,ToolTerm,Agenda,Apps,EdtSearc,Registry,Restex;

{$I \Source\Chantal\Library\Scan.Inc}
{$I \Source\Chantal\Library\IScan.Inc}

Procedure LoadSearchInfo(Var Search:SearchInfo);Near;Begin
 FillClr(Search,SizeOf(Search));
 ReadMainKey(HKEY_CURRENT_USER,'Software\Text\Search','Find',Search);
End;

Procedure SaveSearchInfo(Var Search:SearchInfo);Near;Begin
 Search.Len:=SizeOf(Search)-2;
 CreateKeyFormat(HKEY_CURRENT_USER,'Software\Text\Search','Find',tdBlob,Search);
End;

Function WinSearchData;
Label UpdateReg;
Var
 DataReplace:Record
  Find:String;
  New:String;
  CaseSensitive:Boolean;
  WholeWdOnly:Boolean;
  RegularExpression:Boolean;
  Direction:Byte;
  Scope:Byte;
  Origin:Byte;
 End;
 DataFind:Record
  Find:String;
  CaseSensitive:Boolean;
  WholeWdOnly:Boolean;
  RegularExpression:Boolean;
  Direction:Byte;
  Scope:Byte;
  Origin:Byte;
 End Absolute DataReplace;
 Search:SearchInfo;
Begin
 WinSearchData:=No;
 FillClr(DataReplace,SizeOf(DataReplace));
 If(Mode=sdReplace)Then Begin
  DataReplace.CaseSensitive:=XData.CaseSensitive;
  DataReplace.WholeWdOnly:=XData.WholeWdOnly;
  DataReplace.RegularExpression:=XData.RegularExpression;
  DataReplace.Origin:=Byte(XData.Origin);
  If ExecuteAppDPU(33,DataReplace)Then Begin
   WinSearchData:=True;
   XData.CaseSensitive:=DataReplace.CaseSensitive;
   XData.WholeWdOnly:=DataReplace.WholeWdOnly;
   XData.RegularExpression:=DataReplace.RegularExpression;
   Byte(XData.Origin):=DataReplace.Origin;
   XData.Data:=DataReplace.Find;
   XData.NewData:=DataReplace.New;
   Goto UpdateReg;
  End;
 End
  Else
 Begin
  DataFind.CaseSensitive:=XData.CaseSensitive;
  DataFind.WholeWdOnly:=XData.WholeWdOnly;
  DataFind.RegularExpression:=XData.RegularExpression;
  DataFind.Origin:=Byte(XData.Origin);
  If ExecuteAppDPU(32,DataFind)Then Begin
   WinSearchData:=True;
   XData.CaseSensitive:=DataFind.CaseSensitive;
   XData.WholeWdOnly:=DataFind.WholeWdOnly;
   XData.RegularExpression:=DataFind.RegularExpression;
   Byte(XData.Origin):=DataFind.Origin;
   XData.Data:=DataFind.Find;
UpdateReg:
   Search.Last:=XData;
   SaveSearchInfo(Search);
  End;
 End;
End;

Procedure StrUpX(Var InBuf,OutBuf;L:Word);
Var
 I,J:Word;
 IB:TChar Absolute InBuf;
 OB:TChar Absolute OutBuf;
Begin
 I:=0;J:=0;
 For I:=0to L{-1}do If Not(IB[I]in[#1..#31])Then Begin
  OB[J]:=UpCase(IB[I]);
  Inc(J)
 End;
End;

Procedure SearchReplace;
Var
 Search:SearchInfo;
Begin
 If(HModel(Windows)=wnEdit)Then Begin
  LoadSearchInfo(Search);
  Search.Last.Data:='';
  If WinSearchData(sdReplace,Search.Last)Then
   TESearchWord(EditorApp(HPtr(Windows)^));
   SaveSearchInfo(Search);
 End;
End;

Procedure VASearchWord(Var Q:ViewAsciiApp;Again:Boolean);
Label Cls;
Var
 Tranche:LongInt;
 Handle:Hdl;
 PX:Word;
 Buffer:Array[0..2047]of Byte;
 Search:SearchInfo;
Begin
 Handle:=FileOpen(Q.FileName,fmRead);
 LoadSearchInfo(Search);
 If(Again)Then Tranche:=Q.PBnk^[0]+1 Else
 If(Search.Last.Origin=sdFromCur)Then Tranche:=Q.PBnk^[0]
                                 Else Tranche:=0;
 If(Handle=errHdl)Then Begin
  __FileNotFound(Q.FileName);
  Exit;
 End;
 Repeat
  _GetAbsRec(Handle,Tranche,SizeOf(Buffer),Buffer);
  If Not(Search.Last.CaseSensitive)Then PX:=IScan(Buffer,SizeOf(Buffer),Search.Last.Data)
  Else PX:=Scan(Buffer,SizeOf(Buffer),Search.Last.Data);
  If PX<>$FFFFThen Begin
   Q.PBnk^[0]:=Tranche+PX;
   VARefresh(Q);
   Goto Cls;
  End;
  Inc(Tranche,SizeOf(Buffer)-Length(Search.Last.Data));
 Until Tranche>=Q.FileSize;
 ErrNoMsgOk(ErrSearchBad);
Cls:
 FileClose(Handle);
End;

Procedure SearchFind;
Var
 Ptr:Pointer;
 Agenda:^AgendaApp Absolute Ptr;
 Editor:^EditorApp Absolute Ptr;
 Prmpt:^Prompt Absolute Ptr;
 ViewAscii:^ViewAsciiApp Absolute Ptr;
 Search:SearchInfo;
Begin
 Ptr:=HPtr(Windows);
 Case HModel(Windows)of
  wnEdit,wnView:Begin
   LoadSearchInfo(Search);
   Search.Last.Data:='';
   If(HModel(Windows)=wnEdit)and(Editor^.P>=Editor^.List.Count-5)Then Search.Last.Origin:=sdEntireScope;
   If WinSearchData(sdFind,Search.Last)Then Begin
    Case HModel(Windows)of
     wnView:VASearchWord(ViewAscii^,False);
     wnEdit:TESearchWord(Editor^);
    End;
   End;
   SaveSearchInfo(Search);
  End;
  wnCalendar:WinDayInDate;
  wnPrmpt:PDWinFind(Prmpt^);
  wnAgenda:APSearchPerson(Agenda^);
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Proc‚dure SearchAgain                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de continuer la recherche … partir de la position
 du curseur.
}

Procedure SearchAgain;Begin
 Case HModel(Windows)of
  wnEdit:TESearchAgain(EditorApp(HPtr(Windows)^));
  wnView:VASearchWord(ViewAsciiApp(HPtr(Windows)^),True);
 End;
End;

Procedure SearchProc;
Var
 Name:String;
 K:Word;
Begin
 If(HModel(Windows)=wnEdit)and(EditorApp(HPtr(Windows)^).Mode in[vtAsm,vtBas,vtC,vtPas])Then Begin
  K:=_WinInp(40,'Recherche de Proc‚dure','Entrez son nom',No,Name);
  If(K=kbEnter)Then Begin
   TESearchProc(EditorApp(HPtr(Windows)^),Name);
  End;
 End
  Else
 ErrNoMsgOk(ErrInvalidCommand);
End;

{$IFDEF Educative}
 Procedure InputSearchVerb;
 Var
  Name:String;
  K:Word;
 Begin
  K:=_WinInp(40,'Recherche d''un verbe','Entrez votre verbe',No,Name);
  If(K=kbEnter)Then SearchVerb(Name);
 End;
{$ENDIF}
