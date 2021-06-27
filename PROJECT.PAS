Unit Project;

INTERFACE

Uses Systex,Isatex,Systems,Dials,DialPlus;

Const
 mpRLL=0;
 mpMex=1;
 mpTiny=2;
 mpSmall=3;
 mpMedium=4;
 mpLarge=5;
 mpHuge=6;
 mpDPMI16=7;
 mpDPMI32=8;
 mpFlat=9;
 mpWin30=10;
 mpWin31=11;
 mpWin95=12;
 mpWinNT=13;
 mpOS2=14;
 mpUnix=15;
 mpDLL=16;
 mpDBase=17;
 mpBook=18;

Type ProjectRec=Record
 W:Window;       { Fenàtre de dialogue utilisÇ pour le Projet }
 Lst:ArrayList;  { Liste des composants }
 Y:Byte;         { Position veritcal affichÇe }
 P:Word;         { Position dans la liste }
 Path,           { Nom du projet }
 CurrPath,       { RÇpertoire courant oó se trouve le projet }
 Title:String;   { Titre du projet }
 Model:Byte;     { Modäle de projet }
End;

Function  PRNew(Var Q;X1,Y1,X2,Y2:Byte):Boolean;
Procedure PROpen(Var Q;X1,Y1,X2,Y2:Byte;Const Path:String);
Function  PRRun(Var Q):Word;
Function  PRDone(Var Q):Word;
Procedure PRRefresh(Var Q);
Function  PRSave(Var Q):Boolean;
Function  PRSaveAs(Var Q;Const Path:String):Boolean;
Function  PRTitle(Var Q;Max:Byte):String;
Procedure PRSetTitle(Var Q:ProjectRec;Const Title:String);
Procedure PRNewComposant(Var Q:ProjectRec);
Function  PRCurrFile(Var Q:ProjectRec):String;

IMPLEMENTATION

Uses Adele,Mouse,Video,Editor,SysPlus,Dialex,ResServI,Memories;

Const
 SkipLine=7;
  {Style de code source}
 stUnknown=0;  { Style inconnu }
 stMain=1;     { Programme principal }
 stAppMDI=2;   { Application MDI }
 stDial=3;     { Boåte de dialogue }
 stUnit=4;     { UnitÇ }
  {Choix de palette}
 kcDials=0;       { Boåte de dialogue classique }
 kcFileManager=1; { Gestionnaire de fichiers }
 kcHelp=2;        { Aide }
 kcDraw=3;        { Dessin }
 kcEditIcon=4;    { Editeur d'icìne }
 kcHexView=5;     { Regarde/Editeur HexadÇcimal }
 kcViewAscii=6;   { Regarde ASCII }
 kcPJ=7;          { Journal }
 kcEditor=8;      { Traitement de texte }
 kcTerminal=9;    { Terminal }
 kcOpenWin=10;    { Ouverture de fichier }

Type
 ElemRec=Record
  Path:String;
  Source:Byte;
  Style:Byte;
 End;

 DefinitionWins=Record
  ProcName:String;
  Title:String;
  NumXTexts,NumYTexts:Byte;
  Palette:Byte;
  CloseIcon:Bool;
  UpBar:Bool;
  RightBar:Bool;
  StatusBar:Bool;
 End;

Function WEInpStr(Var Q:Window;Var Str:String):Word;Near;
Var
 PBuffer:Array[Byte]of Char;
 PC:PChr;
Begin
 StrPascalCopy(PBuffer,SizeOf(PBuffer),Str);
 PC:=@PBuffer;
 WEInpStr:=WEInp(Q,PC,SizeOf(String)-1,No);
 Str:=StrPas(PC);
End;

Function StrInitO(Var Q:DefinitionWins):String;Begin
 StrInitO:=' WEInitO(W,'+WordToStr(Q.NumXTexts)+','+WordToStr(Q.NumYTexts)+');';
End;

Function StrPutWn(Var Q:DefinitionWins):String;Begin
 Case(Q.Palette)of
  kcFileManager:StrPutWn:=' WEPutWn(W,'''+Q.Title+''',CurrKrs.FileManager.Wins);';
  kcHelp:StrPutWn:=' WEPutWn(W,'''+Q.Title+''',CurrKrs.Help.Wins);';
  kcDraw:StrPutWn:=' WEPutWn(W,'''+Q.Title+''',CurrKrs.Draw.Wins);';
  kcEditIcon:StrPutWn:=' WEPutWn(W,'''+Q.Title+''',CurrKrs.EditButt);';
  kcHexView:StrPutWn:=' WEPutWn(W,'''+Q.Title+''',CurrKrs.HexView.Wins);';
  kcViewAscii:StrPutWn:=' WEPutWn(W,'''+Q.Title+''',CurrKrs.ViewAscii.Wins);';
  kcPJ:StrPutWn:=' WEPutWn(W,'''+Q.Title+''',CurrKrs.PersonalJournal.Wins);';
  kcEditor:StrPutWn:=' WEPutWn(W,'''+Q.Title+''',CurrKrs.Editor.Wins);';
  kcTerminal:StrPutWn:=' WEPutWn(W,'''+Q.Title+''',CurrKrs.MalteDos.Wins);';
  kcOpenWin:StrPutWn:=' WEPutWn(W,'''+Q.Title+''',CurrKrs.OpenWin.Wins);';
  Else StrPutWn:=' WEPutWnKrDials(W,'''+Q.Title+''');';
 End;
End;

Procedure SelectDial(Var Q:DefinitionWins;Var NameComposant:String);
Const MaxElem=9;
Var
 I,P,K:Word;
 Y:Byte;
 W,ChildW:Window;
 S:String;

 Function Element(P:Word):String;Begin
  Case(P)of
   0:Element:='Source';
   1:Element:='ProcÇdure';
   2:Element:='Titre';
   3:Element:='Largeur texte';
   4:Element:='Hauteur texte';
   5:Element:='Couleur';
   6:Element:='Icìne fermeture';
   7:Element:='Barre du haut';
   8:Element:='Barre dÇfilement';
   9:Element:='Barre d''Çtat';
   Else Element:='';
  End;
 End;

 Function Value(P:Word):String;Begin
  Case(P)of
   0:Value:=NameComposant;
   1:Value:=Q.ProcName;
   2:Value:=Q.Title;
   3:Value:=WordToStr(Q.NumXTexts);
   4:Value:=WordToStr(Q.NumYTexts);
   5:Case(Q.Palette)of
    kcFileManager:Value:='Fichiers';
    kcHelp:Value:='Aide';
    kcDraw:Value:='Dessin';
    kcEditIcon:Value:='Icìne';
    kcHexView:Value:='HexadÇcimal';
    kcViewAscii:Value:='Regarde ASCII';
    kcPJ:Value:='Journal';
    kcEditor:Value:='Traitement de texte';
    kcTerminal:Value:='Terminal';
    kcOpenWin:Value:='Ouverture de fichier';
    Else Value:='Dialogue';
   End;
   6:If(Q.CloseIcon)Then Value:='Oui'Else Value:='Non';
   7:If(Q.UpBar)Then Value:='Oui'Else Value:='Non';
   8:If(Q.RightBar)Then Value:='Oui'Else Value:='Non';
   9:If(Q.StatusBar)Then Value:='Oui'Else Value:='Non';
   Else Value:='';
  End;
 End;

 Procedure InitChild;Begin
  WEInit(ChildW,32,5,32+Q.NumXTexts,5+Q.NumYTexts);
  WEPushWn(ChildW);
  Case(Q.Palette)of
   kcDials:WEPutWnKrDials(ChildW,Q.Title);
   kcFileManager:WEPutWn(ChildW,Q.Title,CurrKrs.FileManager.Window);
   kcHelp:WEPutWn(ChildW,Q.Title,CurrKrs.Help.Window);
   kcDraw:WEPutWn(ChildW,Q.Title,CurrKrs.Draw.Window);
   kcEditIcon:WEPutWn(ChildW,Q.Title,CurrKrs.EditButt);
   kcHexView:WEPutWn(ChildW,Q.Title,CurrKrs.HexView.Window);
   kcViewAscii:WEPutWn(ChildW,Q.Title,CurrKrs.ViewAscii.Window);
   kcPJ:WEPutWn(ChildW,Q.Title,CurrKrs.PersonalJournal.Window);
   kcEditor:WEPutWn(ChildW,Q.Title,CurrKrs.Editor.Window);
   kcTerminal:WEPutWn(ChildW,Q.Title,CurrKrs.MalteDos.Window);
   kcOpenWin:WEPutWn(ChildW,Q.Title,CurrKrs.OpenWin.Window);
  End;
  If(Q.CloseIcon)Then WECloseIcon(ChildW);
  If(Q.UpBar)Then WEBar(ChildW);
  If(Q.RightBar)Then WEPutBarMsRight(ChildW);
  If(Q.StatusBar)Then Begin
   WESetEndBarCTitle(ChildW);
   BarSpcHorRelief(ChildW.T.X1,ChildW.T.Y2,ChildW.T.X2,ChildW.Palette.Title);
  End;
 End;

 Procedure SelBar;Begin
  WESetKrSel(W);
  WEBarSelHor(W,17,Y,wnMax);
 End;

 Procedure UnselBar;Begin
  WESetKrHigh(W);
  WEBarSelHor(W,17,Y,wnMax);
 End;

 Procedure ChoicePalette;
 Var
  L:LstMnu;
  X:Byte;
 Begin
  LMInitCenter(L,40,10,'Couleur de la boåte de dialogue',CurrKrs.Dialog.Window);
  ALAddStrByte(L.List,'Boåte de dialogue classique',kcDials+1);
  ALAddStrByte(L.List,'Gestionnaire de fichiers',kcFileManager+1);
  ALAddStrByte(L.List,'Aide',kcHelp+1);
  ALAddStrByte(L.List,'Dessin',kcDraw+1);
  ALAddStrByte(L.List,'Editeur d''icìne',kcEditIcon+1);
  ALAddStrByte(L.List,'Regarde/Editeur HexadÇcimal',kcHexView+1);
  ALAddStrByte(L.List,'Regarde ASCII',kcViewAscii+1);
  ALAddStrByte(L.List,'Journal',kcPJ+1);
  ALAddStrByte(L.List,'Traitement de texte',kcEditor+1);
  ALAddStrByte(L.List,'Terminal',kcTerminal+1);
  ALAddStrByte(L.List,'Ouverture de fichier',kcOpenWin+1);
  LMGotoPos(L,Q.Palette+1);
  X:=LMRun(L);
  LMDone(L);
  If X<>0Then Begin
   Q.Palette:=X-1;
   WEDone(ChildW);
   InitChild;
   WESetPos(W,17,Y);
   WEPutTxt(W,Value(P));
   WEClrEol(W);
   SelBar;
  End;
 End;

Begin
 P:=0;Y:=0;
 WEInit(W,1,5,30,MaxYTxts-5);
 WEPushWn(W);
 WEPutWnKrDials(W,'Inspecteur d''objet');
 WECloseIcon(W);
 WEPutBarMsRight(W);
 InitChild;
 For I:=0to(W.MaxY)do Begin
  WESetKrBorder(W);
  WEPutTxt(W,Element(I));
  WESetKrHigh(W);
  W.X:=17;
  WEPutTxt(W,Value(I));
  WELn(W);
 End;
 SelBar;
 Repeat
  Case(P)of
   1:Begin
    WESetPos(W,17,Y);
    K:=WEInpStr(W,Q.ProcName);
   End;
   2:Begin
    WESetPos(W,17,Y);
    S:=Q.Title;K:=WEInpStr(W,S);
    If(S<>Q.Title)Then Begin
     Q.Title:=S;
     WEDone(ChildW);
     InitChild;
    End;
   End;
   3,4:Begin
    S:=Value(P);
    WESetPos(W,17,Y);
    K:=WEInpStr(W,S);
    I:=StrToWord(S);
    If P=3Then Begin
     If(Q.NumXTexts<>I)Then Begin
      Q.NumXTexts:=I;
      WEDone(ChildW);
      InitChild;
     End;
    End
     Else
    Begin
     If(Q.NumYTexts<>I)Then Begin
      Q.NumYTexts:=I;
      WEDone(ChildW);
      InitChild;
     End;
    End;
   End;
   Else K:=WEReadk(W);
  End;
  Case(K)of
   kbClose,kbEsc:Break;
   kbUp:If P>0Then Begin
    UnSelBar;
    Dec(P);Dec(Y);
    SelBar;
   End;
   kbDn:If(P<MaxElem)Then Begin
    UnSelBar;
    Inc(P);Inc(Y);
    SelBar;
   End;
   Else If Chr(K)=' 'Then Begin
    Case(P)of
     5:ChoicePalette;
     6..9:Begin
      Case(P)of
       6:Q.CloseIcon:=Not Q.CloseIcon;
       7:Q.UpBar:=Not Q.UpBar;
       8:Q.RightBar:=Not Q.RightBar;
       9:Q.StatusBar:=Not Q.StatusBar;
      End;
      WESetKrHigh(W);
      WEPutTxtXYU(W,17,Y,Value(P));
      WEDone(ChildW);
      InitChild;
     End;
    End;
   End;
  End;
 Until No;
 WEDone(ChildW);
 WEDone(W);
End;

Procedure PRAddElem(Var Q:ProjectRec;Const FileName:String);
Var
 Elem:ElemRec;
 E:ExtStr;
 L:ArrayList;
 S:String;
 I:Word;
 BRef,BRun,BDone:Boolean;
Begin
 FillClr(Elem,SizeOf(Elem));
 Elem.Path:=StrUp(FileName);
 Elem.Source:=0;BRef:=No;BRun:=No;BDone:=No;
 E:=Path2Ext(Elem.Path);
 If Pos(E,StrPas(ExtRC))>0Then Elem.Source:=vtRC;
 If Pos(E,StrPas(ExtPas))>0Then Elem.Source:=vtPas;
 If Pos(E,StrPas(ExtFortran))>0Then Elem.Source:=vtFortran;
 If Pos(E,StrPas(ExtEuphoria))>0Then Elem.Source:=vtEuphoria;
 If Pos(E,StrPas(ExtC))>0Then Elem.Source:=vtC;
 If Pos(E,StrPas(ExtBas))>0Then Elem.Source:=vtBas;
 If Pos(E,StrPas(ExtAsm))>0Then Elem.Source:=vtAsm;
 If Pos(E,StrPas(ExtAC))>0Then Elem.Source:=vtAC;
 If(Length(E)>=4)and(Pos(E,'.CBL')>0)Then Elem.Source:=vtCobol;
 If Pos(E,'.GAT')>0Then Elem.Source:=vtGat;
 If Pos(E,'.INI')>0Then Elem.Source:=vtIni;
 If Pos(E,'.BAT;.BTM')>0Then Elem.Source:=vtBatch;
 Case(Elem.Source)of
  vtPas:If ALLoadFileASCII(L,Elem.Path)Then Begin
   If L.Count>0Then Begin
    ALSetPtr(L,0);
    For I:=0to L.Count-1do Begin
     S:=StrUp(StrPas(_ALGetCurrBuf(L)));
     If Pos('PROGRAM ',S)>0Then Begin
      Elem.Style:=stMain;
      Break;
     End;
     If Pos('UNIT ',S)>0Then Elem.Style:=stUnit;
     If Pos(':WINS;',S)>0Then Elem.Style:=stDial;
     If(Pos('PROCEDURE',S)>0)and(Pos('REFRESH',S)>0)Then BRef:=Ya;
     If(Pos('FUNCTION',S)>0)and(Pos('RUN',S)>0)Then BRun:=Ya;
     If(Pos('FUNCTION',S)>0)and(Pos('DONE',S)>0)Then BDone:=Ya;
     ALNext(L);
    End;
   End;
   ALDone(L);
   If(BRef)and(BRun)and(BDone)Then Elem.Style:=stAppMDI;
  End;
  vtCobol:Elem.Style:=stMain;
 End;
 ALAddBlock(Q.Lst,SizeOf(ElemRec),Elem);
End;

{⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ‹
 ≥                        Fonction XtrkPasStr                       €
 ¿‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹€


 Description
 ÕÕÕÕÕÕÕÕÕÕÕ

  Cette fonction permet d'extraire une chaåne de caractäres de format
 Pascal Ö partir d'un point particulier dans une chaåne de caractäres
 de format Çgalement Pascal.
}

Function XtrkPasStr(Var I:Byte;Const L:String;Var EM:Bool):String;
Var
 S:String;
Begin
 EM:=Ya;Inc(I);S:='';
 While(L[I]<>'''')or((L[I]='''')and(StrI(I+1,L)=''''))do Begin
  If I>Length(L)Then Exit;
  IncStr(S,L[I]);
  If((L[I]='''')and(StrI(I+1,L)=''''))Then Inc(I);
  Inc(I);
 End;
 EM:=No;XtrkPasStr:=S;
End;

Function PRNew(Var Q;X1,Y1,X2,Y2:Byte):Boolean;Begin
 PRNew:=No;
 FillClr(Q,SizeOf(ProjectRec));
 WEInit(ProjectRec(Q).W,X1,Y1,X2,Y2);
 PRRefresh(Q);
 PRNew:=Ya;
End;

Procedure PROpen(Var Q;X1,Y1,X2,Y2:Byte;Const Path:String);
Var
 Handle:Hdl;
 FP,FS:LongInt;
 Str:String;
Begin
 FillClr(Q,SizeOf(ProjectRec));
 WEInit(ProjectRec(Q).W,X1,Y1,X2,Y2);
 ProjectRec(Q).Path:=Path;ProjectRec(Q).CurrPath:=Path2Dir(Path);
  {Chargement du fichier...}
 Handle:=FileOpen(Path,fmRead);
 If(Handle<>errHdl)Then Begin
  FP:=0;FS:=FileSize(Handle);
  __GetAbsFileTxtLn(Handle,FP,Str);
  ProjectRec(Q).Title:=Str;
  __GetAbsFileTxtLn(Handle,FP,Str);
  ProjectRec(Q).Model:=StrToWord(Str);
  Repeat
   __GetAbsFileTxtLn(Handle,FP,Str);
   If GetSysErr<>0Then Break;
   PRAddElem(ProjectRec(Q),Str);
  Until FP>=FS;
  FileClose(Handle);
 End;
 PRRefresh(Q);
End;

Procedure PRPutList(Var Q:ProjectRec);
Var
 I:Byte;
 PC:^ElemRec;
 S:String;
Begin
 If(Q.P>=Q.Lst.Count)Then Q.P:=Q.Lst.Count-1;
 If(Q.Y>Q.P)Then Q.Y:=Q.P;
 WESetKrBorder(Q.W);
 WESetPos(Q.W,0,SkipLine);
 ALSetPtr(Q.Lst,Q.P-Q.Y);
 For I:=0to(Q.W.MaxY)do Begin
  PC:=_ALGetCurrBuf(Q.Lst);
  If(PC=NIL)Then Break;
  WEPutTxt(Q.W,StrUSpc(TruncName(PC^.Path,50),50));
  Case(PC^.Source)of
   vtAda:S:='Ada';
   vtAsm:S:='Assembleur';
   vtBas:S:='Basic';
   vtC:S:='C/C++';
   vtCobol:S:='Cobol';
   vtEuphoria:S:='Euphoria';
   vtForth:S:='Forth';
   vtFortran:S:='Fortran';
   vtIni:S:='INItiale';
   vtMsMnu:S:='Souris';
   vtPas:S:='Pascal';
   vtRC:S:='Ressource';
   vtGAT:S:='Document';
   vtAC:S:='AC';
   vtMacro:S:='Macro';
   vtBatch:S:='Batch';
   Else S:='Inconnu';
  End;
  WEPutTxt(Q.W,StrUSpc(S,10));
  Case(PC^.Style)of
   stMain:S:='Principal';
   stAppMDI:S:='Application MDI';
   stDial:S:='Boåte de dialogue';
   stUnit:S:='UnitÇ/Bibliothäque';
   Else S:='Inconnu';
  End;
  WEPutTxt(Q.W,S);
  WELn(Q.W);
  ALNext(Q.Lst);
 End;
 WESetKrSel(Q.W);
 WEBarSelHor(Q.W,0,SkipLine+Q.Y,wnMax);
 WESetKrBorder(Q.W);
 WEClrWnBorder(Q.W,0,Q.W.Y,wnMax,wnMax);
End;

Procedure PRAddFile(Var Q:ProjectRec;Const FileName:String);Begin
 PRAddElem(Q,FileName);
 PRPutList(Q);
End;

Function PRCurrFile(Var Q:ProjectRec):String;
Var
 PC:^ElemRec;
Begin
 If Q.Lst.Count=0Then PRCurrFile:=''
  Else
 Begin
  PC:=_ALGetBuf(Q.Lst,Q.P);
  PRCurrFile:=PC^.Path;
 End;
End;

Procedure RBSetStr(Var Q:ArrayList;P:RBP;Const S:String);Var PC:PChr;Begin
 PC:=ALSet(Q,P,Length(S)+1);
 If(PC<>NIL)Then StrPCopy(PC,S);
End;

Function PREditFile(Var Q:ProjectRec;FileName:String):Boolean;
Var PC:^ElemRec;L:ArrayList;X:DefinitionWins;I:Word;J,J1,N:Byte;EM:Bool;
    S:String;Section:(sNone,sUnit,sInterface,sImplementation);
    LPutWn,LInitO:Word;
Begin
 PREditFile:=Ya;
 LPutWn:=$FFFF;LInitO:=$FFFF;
 PC:=_ALGetBuf(Q.Lst,Q.P);
 Case(PC^.Style)of
  stDial:Begin
   FillClr(X,SizeOf(X));Section:=sNone;
   If ALLoadFileASCII(L,FileName)Then Begin
    ALSetPtr(L,0);
    If L.Count>0Then For I:=0to L.Count-1do Begin
     S:=StrUp(StrPas(_ALGetCurrBuf(L)));
     If Pos('UNIT ',S)>0Then Section:=sUnit Else
     If Pos('INTERFACE',S)>0Then Section:=sInterface Else
     If Pos('IMPLEMENTATION',S)>0Then Section:=sImplementation
      Else
     If(Section)in[sNone,sImplementation]Then Begin
      If X.ProcName<>''Then Begin
       J:=Pos('WEINITO(W,',S);
       If J>0Then Begin
        LInitO:=I;
        Inc(J,Length('WEINITO(W,'));N:=0;
        For J1:=J to Length(S)do If S[J1]in(ArabicDigit)Then Inc(N)Else Break;
        X.NumXTexts:=StrToWord(Copy(S,J,N));
        Inc(J,N+1);N:=0;
        For J1:=J to Length(S)do If S[J1]in(ArabicDigit)Then Inc(N)Else Break;
        X.NumYTexts:=StrToWord(Copy(S,J,N));
       End
        Else
       If Pos('WEPUTWN',S)>0Then Begin
        LPutWn:=I;
        J:=Pos('(W,',S);Inc(J,Length('(W,'));
        EM:=No;X.Title:=XtrkPasStr(J,StrPas(_ALGetCurrBuf(L)),EM);
       End
        Else
       If Pos('WECLOSEICON(W)',S)>0Then X.CloseIcon:=Ya Else
       If Pos('WEBAR(W)',S)>0Then X.UpBar:=Ya Else
       If Pos('WEPUTBARMSRIGHT(W)',S)>0Then X.RightBar:=Ya Else
       If Pos('WESETENDBARCTITLE(W)',S)>0Then X.StatusBar:=Ya;
      End
       Else
      Begin
       J:=Pos('PROCEDURE ',S);
       If J>0Then Begin
        Inc(J,Length('PROCEDURE '));
        X.ProcName:=LTrim(Copy(StrPas(_ALGetCurrBuf(L)),J,255));
        For J:=1to Length(X.ProcName)do Begin
         If Not(X.ProcName[J]in(CoderDefLetter))Then Begin
          X.ProcName[0]:=Chr(J-1);
          Break;
         End;
        End;
       End;
      End;
     End;
     ALNext(L);
    End;
    SelectDial(X,FileName);
    If LPutWn<>$FFFFThen RBSetStr(L,LPutWn,StrPutWn(X));
    IF LInitO<>$FFFFThen RBSetStr(L,LInitO,StrInitO(X));
    ALSaveFileASCII(L,FileName,Ya);
    ALDone(L);
   End
    Else
   ErrMsgOk('Probläme de chargement!');
  End;
  Else PREditFile:=No;
 End;
End;

Procedure PRkUp(Var Q:ProjectRec);Begin
 If Q.Lst.Count=0Then Exit;
 If Q.P>0Then Begin
  Dec(Q.P);
  If Q.Y>0Then Begin
   WESetKrBorder(Q.W);
   WEBarSelHor(Q.W,0,SkipLine+Q.Y,wnMax);
   Dec(Q.Y);
   WESetKrSel(Q.W);
   WEBarSelHor(Q.W,0,SkipLine+Q.Y,wnMax);
  End
   Else
  PRPutList(Q);
 End;
End;

Procedure PRkDn(Var Q:ProjectRec);Begin
 If Q.Lst.Count=0Then Exit;
 If Q.P<Q.Lst.Count-1Then Begin
  Inc(Q.P);
  If Q.Y<(Q.W.MaxY-SkipLine)Then Begin
   WESetKrBorder(Q.W);
   WEBarSelHor(Q.W,0,SkipLine+Q.Y,wnMax);
   Inc(Q.Y);
   WESetKrSel(Q.W);
   WEBarSelHor(Q.W,0,SkipLine+Q.Y,wnMax);
  End
   Else
  PRPutList(Q);
 End;
End;

Function PRRun(Var Q):Word;Label Enter;Var K:Wd;S:String;Begin
 Repeat
  K:=WEReadk(ProjectRec(Q).W);
  Case(K)of
   kbIns:Begin
    S:=OpenWin(ProjectRec(Q).CurrPath+'*.*','Projet - Insertion');
    PRAddFile(ProjectRec(Q),S);
   End;
   kbDel:Begin
    ALDelBuf(ProjectRec(Q).Lst,ProjectRec(Q).P);
    PRPutList(ProjectRec(Q));
   End;
   kbEnter:Begin
Enter:
    If Not PREditFile(ProjectRec(Q),PRCurrFile(ProjectRec(Q)))Then Begin
     K:=kbLoad;
     Break;
    End;
   End;
   kbUp:PRkUp(ProjectRec(Q));
   kbDn:PRkDn(ProjectRec(Q));
   kbInWn:Begin
    WaitMsBut0;
    If ProjectRec(Q).Y<>LastMsY-(WEGetRY1(ProjectRec(Q).W)+7)Then Begin
     WESetKrBorder(ProjectRec(Q).W);
     WEBarSelHor(ProjectRec(Q).W,0,SkipLine+ProjectRec(Q).Y,wnMax);
     Dec(ProjectRec(Q).P,ProjectRec(Q).Y);
     ProjectRec(Q).Y:=LastMsY-(WEGetRY1(ProjectRec(Q).W)+7);
     Inc(ProjectRec(Q).P,ProjectRec(Q).Y);
     WESetKrSel(ProjectRec(Q).W);
     WEBarSelHor(ProjectRec(Q).W,0,SkipLine+ProjectRec(Q).Y,wnMax);
    End
     Else
    Goto Enter;
   End;
   Else Break;
  End;
 Until No;
 If Chr(K)=' 'Then K:=kbLoad;
 PRRun:=K;
End;

Function PRDone(Var Q):Word;Begin
 PRDone:=0;
 PRSave(Q);
 ALDone(ProjectRec(Q).Lst);
End;

Procedure PRRefresh(Var Q);Var S:String;Begin
 WEPutWnKrDials(ProjectRec(Q).W,'Projet');
 WECloseIcon(ProjectRec(Q).W);
 WEBar(ProjectRec(Q).W);
 WESetPosHome(ProjectRec(Q).W);
 WELn(ProjectRec(Q).W);
 WEPutTxt(ProjectRec(Q).W,'Titre:  ');
 If ProjectRec(Q).Title=''Then WEPutTxtLn(ProjectRec(Q).W,'Sans nom')
 Else WEPutTxtLn(ProjectRec(Q).W,ProjectRec(Q).Title);
 WEPutTxt(ProjectRec(Q).W,'Chemin: ');
 If ProjectRec(Q).Path=''Then WEPutTxtLn(ProjectRec(Q).W,'Aucun')
 Else WEPutTxtLn(ProjectRec(Q).W,ProjectRec(Q).Path);
 Case(ProjectRec(Q).Model)of
  mpRLL:S:='Bibliothäque RLL';
  mpMex:S:='ExÇcutable Mex';
  mpTiny:S:='ExÇcutable Tiny';
  mpSmall:S:='ExÇcutable Small';
  mpMedium:S:='ExÇcutable Medium';
  mpLarge:S:='ExÇcutable Large';
  mpHuge:S:='ExÇcutable Huge';
  mpDPMI16:S:='ExÇcutable DPMI 16-bits';
  mpDPMI32:S:='ExÇcutable DPMI 32-bits';
  mpFlat:S:='ExÇcutable Flat';
  mpWin30:S:='ExÇcutable Windows 3.0';
  mpWin31:S:='ExÇcutable Windows 3.1';
  mpWin95:S:='ExÇcutable Windows 95';
  mpWinNT:S:='ExÇcutable Windows NT';
  mpOS2:S:='ExÇcutable OS/2';
  mpUnix:S:='ExÇcutable Unix';
  mpDLL:S:='Bibliothäque DLL';
  mpDBase:S:='Base de donnÇe';
  mpBook:S:='Livre';
  Else S:='Inconnu';
 End;
 WEPutTxtLn(ProjectRec(Q).W,'Modäle: '+S);
 WELn(ProjectRec(Q).W);
 WEPutTxt(ProjectRec(Q).W,'Nom');
 ProjectRec(Q).W.X:=50;
 WEPutTxt(ProjectRec(Q).W,'Source');
 ProjectRec(Q).W.X:=60;
 WEPutTxtLn(ProjectRec(Q).W,'Style');
 WEPutTxtLn(ProjectRec(Q).W,MultChr('ƒ',ProjectRec(Q).W.MaxX));
 PRPutList(ProjectRec(Q));
End;

Function PRSave(Var Q):Boolean;Begin
 PRSaveAs(Q,ProjectRec(Q).Path);
End;

Function PRSaveAs(Var Q;Const Path:String):Boolean;Var Handle:Hdl;I:Word;PC:^ElemRec;Begin
 If Path=''Then ProjectRec(Q).Path:=OpenWin('*.PRP','Sauvegarde sous');
 If ProjectRec(Q).Path=''Then Exit;
 ProjectRec(Q).Path:=Path;
 Handle:=NewNBak(Path);
 If(Handle<>errHdl)Then Begin
  PutFileTxtLn(Handle,ProjectRec(Q).Title);
  PutFileTxtLn(Handle,WordToStr(ProjectRec(Q).Model));
  ALSetPtr(ProjectRec(Q).Lst,0);
  If ProjectRec(Q).Lst.Count>0Then For I:=0to ProjectRec(Q).Lst.Count-1do Begin
   PC:=_ALGetCurrBuf(ProjectRec(Q).Lst);
   If(PC<>NIL)Then PutFileTxtLn(Handle,PC^.Path);
   ALNext(ProjectRec(Q).Lst);
  End;
  FileClose(Handle);
 End;
End;

Function PRTitle(Var Q;Max:Byte):String;Const Name='Projet ';Begin
 PRTitle:=Name+TruncName(ProjectRec(Q).Path,Max-Length(Name))
End;

Procedure PRSetTitle{Var Q:ProjectRec;Const Title:String};Begin
 Q.Title:=Title;
 PRRefresh(Q);
End;

Function ToStringPascal(Const Source:String):String;Var Target:String;I:Byte;Begin
 Target:='''';
 For I:=1to Length(Source)do Case Source[I]of
  '''':AddStr(Target,'''''');
  Else IncStr(Target,Source[I]);
 End;
 ToStringPascal:=Target+'''';
End;

Procedure PRRessourceDevelopper(Var Q:ProjectRec);
Const MaxElem=9;
Type ElementText=Record
 Serial:Byte;           { NumÇro de sÇrie de l'ÇlÇment }
 X,Y:Byte;
 Msg:String;
End;
ElementCheckBox=Record
 Serial:Byte;           { NumÇro de sÇrie de l'ÇlÇment }
 X,Y:Byte;
 Len:Byte;
 Msg:String;
End;
ElementFrame=Record
 Serial:Byte;
 X1,Y1,X2,Y2:Byte;
 Title:String;
End;
ElementInput=Record
 Serial:Byte;
 X1,Y,X2:Byte;
 Len:Byte;
End;
ElementListBox=Record
 Serial:Byte;
 X1,Y1,X2,Y2:Byte;
 Shadow:Boolean;
 Title:String;
End;
ElementRadioButton=Record
 Serial:Byte;
 X,Y:Byte;
 Len:Byte;
 Title:String;
 List:String;
 SO:SwitchOption;
End;
ElementScrollBar=Record
 Serial:Byte;
 Min,Max:Word;
 X1,Y,X2:Byte;
 Attr:Byte;
 NumericCount:Boolean;
End;
Var
 W,BarW,ChildW:Window;
 TX:DefinitionWins;
 ComposantPosition,K,P,I,TP:Word;
 NumTxt,NumCheckBox,NumFrame,NumInput,NumListBox,
 NumRadioButton,NumScrollBar:Word;
 Y:Byte;
 NameComposant,S:String;
 TmpList:ArrayList;

 Procedure AddElementCheckBox(X,Y,Len:Byte;Const Msg:String);
 Var Element:ElementCheckBox;Begin
  Element.Serial:=$8F;
  Element.X:=X;
  Element.Y:=Y;
  Element.Len:=Len;
  Element.Msg:=Msg;
  ALAddBlock(TmpList,SizeOf(Element),Element);
  Inc(NumCheckBox);
 End;

 Procedure AddElementFrame(X1,Y1,X2,Y2:Byte;Const Title:String);
 Var Element:ElementFrame;Begin
  Element.Serial:=$8C;
  Element.X1:=X1;Element.Y1:=Y1;
  Element.X2:=X2;Element.Y2:=Y2;
  Element.Title:=Title;
  ALAddBlock(TmpList,SizeOf(Element),Element);
  Inc(NumFrame);
 End;

 Procedure AddElementInput(X1,Y,X2,Len,Model:Byte);
 Var Element:ElementInput;Begin
  Element.Serial:=$80+Model;
  Element.X1:=X1;
  Element.Y:=Y;
  Element.X2:=X2;
  Element.Len:=Len;
  ALAddBlock(TmpList,SizeOf(Element),Element);
  Inc(NumInput);
 End;

 Procedure AddElementListBox(X1,Y1,X2,Y2:Byte;Shadow:Boolean;Const Title:String);
 Var Element:ElementListBox;Begin
  Element.Serial:=$87;
  Element.X1:=X1;Element.Y1:=Y1;
  Element.X2:=X2;Element.Y2:=Y2;
  Element.Shadow:=Shadow;
  Element.Title:=Title;
  ALAddBlock(TmpList,SizeOf(Element),Element);
  Inc(NumListBox);
 End;

 Procedure AddElementRadioButton(X,Y,Len:Byte;Const Title,List:String);
 Var Element:ElementRadioButton;Begin
  Element.Serial:=$8D;
  Element.X:=X;Element.Y:=Y;Element.Len:=Len;
  Element.Title:=Title;Element.List:=List;
  SOInit(Element.SO,WEGetRX1(ChildW)+X,WEGetRY1(ChildW)+Y,Title,List,0);
  ALAddBlock(TmpList,SizeOf(Element),Element);
  Inc(NumRadioButton);
 End;

 Procedure AddElementText(X,Y:Byte;Const Msg:String);
 Var Element:ElementText;Begin
  Element.Serial:=7;
  Element.X:=X;
  Element.Y:=Y;
  Element.Msg:=Msg;
  ALAddBlock(TmpList,SizeOf(Element),Element);
  Inc(NumTxt);
 End;

 Procedure AddElementScrollBar(Min,Max:Word;X1,Y,X2,Attr:Byte;NumericCount:Boolean);
 Var Element:ElementScrollBar;Begin
  Element.Serial:=$88;
  Element.Min:=Min;Element.Max:=Max;
  Element.X1:=X1;Element.Y:=Y;Element.X2:=X2;
  Element.Attr:=Attr;
  Element.NumericCount:=NumericCount;
  ALAddBlock(TmpList,SizeOf(Element),Element);
  Inc(NumScrollBar);
 End;

 Procedure WriteRessource;
 Var I:Int;
     PB:^Byte;
     PT:^ElementText Absolute PB;
     PCB:^ElementCheckBox Absolute PB;
     PF:^ElementFrame Absolute PB;
     PI:^ElementInput Absolute PB;
     PLB:^ElementListBox Absolute PB;
     PRB:^ElementRadioButton Absolute PB;
     PSB:^ElementScrollBar Absolute PB;
     TL:ArrayList;     { Code source de ressource Çcrit et/ou àtre modifiÇ }
     PL:^ElemRec;
     NumberIndex:Word; { Nombre d'index }
     LineNmIndex:Word; { Ligne ou se trouve le nombre d'index }
     PC:PChr;          { Pointeur sur une chaåne ASCIIZ }
     S:String;         { Chaåne de caractäres temporaire }
 Begin
  NumberIndex:=0;LineNmIndex:=$FFFF;
  PL:=_ALGetBuf(Q.Lst,Q.P);
  ALLoadFileASCII(TL,PL^.Path);
  ALSetPtr(TL,0);
  For I:=0to TL.Count-1do Begin
   PC:=_ALGetCurrBuf(TL);
   If(PC<>NIL)Then Begin
    S:=StrUp(Trim(StrPas(PC)));
    If CmpLeft(S,'NUMBERINDEX=')Then Begin
     NumberIndex:=StrToWord(Copy(S,Length('NUMBERINDEX=')+1,255));
     LineNmIndex:=I;
     Break;
    End;
   End;
   ALNext(TL);
  End;
  If LineNmIndex<>$FFFFThen Begin
   ALDelBuf(TL,LineNmIndex);
   ALInsStr(TL,LineNmIndex,'NumberIndex='+WordToStr(NumberIndex+1));
  End
   Else
  ALAddStr(TL,'NumberIndex='+WordToStr(NumberIndex+1));
  ALSetPtr(TmpList,0);
  ALAddStr(TL,'');
  ALAddStr(TL,'IndexDialog '+WordToStr(NumberIndex));
  ALAddStr(TL,'   Size '+WordToStr(TX.NumXTexts)+','+WordToStr(TX.NumYTexts));
  ALAddStr(TL,'   WindowColorClassic '+ToStringPascal(TX.Title));
  If(TX.CloseIcon)Then ALAddStr(TL,'   CloseIcon');
  If(TX.UpBar)Then ALAddStr(TL,'   BarUp');
  For I:=0to TmpList.Count-1do Begin
   PB:=_ALGetCurrBuf(TmpList);
   Case PB^of
    7:S:='Text '+WordToStr(PT^.X)+','+WordToStr(PT^.Y)+','+ToStringPascal(PT^.Msg);
    $81:S:='Input Byte ('+WordToStr(PI^.X1)+','+WordToStr(PI^.Y)+','+
                          WordToStr(PI^.X2)+'),'+WordToStr(PI^.Len);
    $82:S:='Input Word ('+WordToStr(PI^.X1)+','+WordToStr(PI^.Y)+','+
                          WordToStr(PI^.X2)+'),'+WordToStr(PI^.Len);
    $83:S:='Input Long ('+WordToStr(PI^.X1)+','+WordToStr(PI^.Y)+','+
                          WordToStr(PI^.X2)+'),'+WordToStr(PI^.Len);
    $84:S:='Input Real ('+WordToStr(PI^.X1)+','+WordToStr(PI^.Y)+','+
                          WordToStr(PI^.X2)+'),'+WordToStr(PI^.Len);
    $86:S:='Input String ('+WordToStr(PI^.X1)+','+WordToStr(PI^.Y)+','+
                            WordToStr(PI^.X2)+'),'+WordToStr(PI^.Len);
    $87:If(PLB^.Shadow)Then
         S:='ListBox ('+WordToStr(PLB^.X1)+','+WordToStr(PLB^.Y1)+')-('+
                        WordToStr(PLB^.X2)+','+WordToStr(PLB^.Y2)+'),Shadow,'+
                        ToStringPascal(PLB^.Title)
        Else
         S:='ListBox ('+WordToStr(PLB^.X1)+','+WordToStr(PLB^.Y1)+')-('+
                        WordToStr(PLB^.X2)+','+WordToStr(PLB^.Y2)+'),'+
                        ToStringPascal(PLB^.Title);
    $88:S:='ScrollBar '+WordToStr(PSB^.Min)+':'+WordToStr(PSB^.Max)+' ('+
                        WordToStr(PSB^.X1)+','+WordToStr(PSB^.Y)+','+
                        WordToStr(PSB^.X2)+'),'+WordToStr(PSB^.Attr);
    $8C:S:='Frame ('+WordToStr(PF^.X1)+','+WordToStr(PF^.Y1)+')-('+
                     WordToStr(PF^.X2)+','+WordToStr(PF^.Y2)+'),'+ToStringPascal(PF^.Title);
    $8D:If PRB^.Len=0Then
         S:='RadioButton ('+WordToStr(PRB^.X)+','+WordToStr(PRB^.Y)+'),'+
                            ToStringPascal(PRB^.Title)+','+ToStringPascal(PRB^.List)
        Else
         S:='RadioButton ('+WordToStr(PRB^.X)+','+WordToStr(PRB^.Y)+'),'+WordToStr(PRB^.Len)+','+
                            ToStringPascal(PRB^.Title)+','+ToStringPascal(PRB^.List);
    $8F:S:='CheckBox ('+WordToStr(PCB^.X)+','+WordToStr(PCB^.Y)+'),'+
                        WordToStr(PCB^.Len)+','+ToStringPascal(PCB^.Msg);
   End;
   ALAddStr(TL,'   '+S);
   ALNext(TmpList);
  End;
  ALAddStr(TL,'End');
  ALSaveFileASCII(TL,PL^.Path,Ya);
  ALDone(TL);
 End;

 Procedure LoadRessource;
 Var
  TL:ArrayList;    { Code source de ressource Çcrit et/ou àtre modifiÇ }
  PL:^ElemRec;
 Begin
  PL:=_ALGetBuf(Q.Lst,Q.P);
  ALLoadFileASCII(TL,PL^.Path);
  ALDone(TL);
 End;

 Function SearchElement(X,Y:Byte):Integer;
 Var I:Integer;PB:^Byte;PT:^ElementText Absolute PB;
 PCB:^ElementCheckBox Absolute PB;
 PF:^ElementFrame Absolute PB;
 PI:^ElementInput Absolute PB;
 PLB:^ElementListBox Absolute PB;
 PRB:^ElementRadioButton Absolute PB;
 PSB:^ElementScrollBar Absolute PB;
 Begin
  SearchElement:=-1;
  If WEInWindow(ChildW,X,Y)Then Begin
   Dec(X,WEGetRX1(ChildW));
   Dec(Y,WEGetRY1(ChildW));
   ALSetPtr(TmpList,0);
   For I:=0to TmpList.Count-1do Begin
    PB:=_ALGetCurrBuf(TmpList);
    If(PB=NIL)Then Break;
    Case(PB^)of
     7:If(X>=PT^.X)and(PT^.Y=Y)and(X<=PT^.X+Length(PT^.Msg))Then Begin
      SearchElement:=I;
      Break;
     End;
     $81..$84,$86:If(X>=PI^.X1)and(Y=PT^.Y)and(X<=PI^.X2)Then Begin
      SearchElement:=I;
      Break;
     End;
     $87:If(X>=PLB^.X1)and(Y>=PLB^.Y1)and(X<=PLB^.X2)and(Y<=PLB^.X2)Then Begin
      SearchElement:=I;
      Break;
     End;
     $88:If(X>=PSB^.X1)and(Y=PSB^.Y)and(X<=PSB^.X2)Then Begin
      SearchElement:=I;
      Break;
     End;
     $8C:If(X>=PF^.X1)and(Y>=PF^.Y1)and(X<=PF^.X2)and(Y<=PF^.X2)Then Begin
      SearchElement:=I;
      Break;
     End;
     $8D:If(X>=PRB^.SO.X1)and(Y>=PRB^.SO.Y1)and(X<=PRB^.SO.X2)and(Y<=PRB^.SO.X2)Then Begin
      SearchElement:=I;
      Break;
     End;
     $8F:If(X>=PCB^.X)and(PCB^.Y=Y)and
           ((X<=PCB^.X+Length(PCB^.Msg))or(X<=PCB^.X+PCB^.Len))Then Begin
      SearchElement:=I;
      Break;
     End;
     Else Break;
    End;
    ALNext(TmpList);
   End;
  End;
 End;

 Function Element(P:Word):String;Begin
  Case(P)of
   0:Element:='Source';
   1:Element:='Procedure';
   2:Element:='Titre';
   3:Element:='Largeur texte';
   4:Element:='Hauteur texte';
   5:Element:='Couleur';
   6:Element:='Icone fermeture';
   7:Element:='Barre du haut';
   8:Element:='Barre defilement';
   9:Element:='Barre d''etat';
   Else Element:='';
  End;
 End;

 Function Value(P:Word):String;Begin
  Case(P)of
   0:Value:=NameComposant;
   1:Value:=TX.ProcName;
   2:Value:=TX.Title;
   3:Value:=WordToStr(TX.NumXTexts);
   4:Value:=WordToStr(TX.NumYTexts);
   5:Case(TX.Palette)of
    kcFileManager:Value:='Fichiers';
    kcHelp:Value:='Aide';
    kcDraw:Value:='Dessin';
    kcEditIcon:Value:='Icìne';
    kcHexView:Value:='HexadÇcimal';
    kcViewAscii:Value:='Regarde ASCII';
    kcPJ:Value:='Journal';
    kcEditor:Value:='Traitement de texte';
    kcTerminal:Value:='Terminal';
    kcOpenWin:Value:='Ouverture de fichier';
    Else Value:='Dialogue';
   End;
   6:If(TX.CloseIcon)Then Value:='Oui'Else Value:='Non';
   7:If(TX.UpBar)Then Value:='Oui'Else Value:='Non';
   8:If(TX.RightBar)Then Value:='Oui'Else Value:='Non';
   9:If(TX.StatusBar)Then Value:='Oui'Else Value:='Non';
   Else Value:='';
  End;
 End;

 Procedure InitChild;Var I,J:Byte;JK:Word;OldShade:Bool;
 PB:^Byte;PT:^ElementText Absolute PB;
 PCB:^ElementCheckBox Absolute PB;
 PF:^ElementFrame Absolute PB;
 PI:^ElementInput Absolute PB;
 PLB:^ElementListBox Absolute PB;
 PRB:^ElementRadioButton Absolute PB;
 PSB:^ElementScrollBar Absolute PB;
 LM:LstMnu;
 Begin
  WEInit(ChildW,32,10,32+TX.NumXTexts,10+TX.NumYTexts);
  WEPushWn(ChildW);
  Case(TX.Palette)of
   kcDials:WEPutWnKrDials(ChildW,TX.Title);
   kcFileManager:WEPutWn(ChildW,TX.Title,CurrKrs.FileManager.Window);
   kcHelp:WEPutWn(ChildW,TX.Title,CurrKrs.Help.Window);
   kcDraw:WEPutWn(ChildW,TX.Title,CurrKrs.Draw.Window);
   kcEditIcon:WEPutWn(ChildW,TX.Title,CurrKrs.EditButt);
   kcHexView:WEPutWn(ChildW,TX.Title,CurrKrs.HexView.Window);
   kcViewAscii:WEPutWn(ChildW,TX.Title,CurrKrs.ViewAscii.Window);
   kcPJ:WEPutWn(ChildW,TX.Title,CurrKrs.PersonalJournal.Window);
   kcEditor:WEPutWn(ChildW,TX.Title,CurrKrs.Editor.Window);
   kcTerminal:WEPutWn(ChildW,TX.Title,CurrKrs.MalteDos.Window);
   kcOpenWin:WEPutWn(ChildW,TX.Title,CurrKrs.OpenWin.Window);
  End;
  If(TX.CloseIcon)Then WECloseIcon(ChildW);
  If(TX.UpBar)Then WEBar(ChildW);
  If(TX.RightBar)Then WEPutBarMsRight(ChildW);
  If(TX.StatusBar)Then Begin
   WESetEndBarCTitle(ChildW);
   BarSpcHorRelief(ChildW.T.X1,ChildW.T.Y2,ChildW.T.X2,ChildW.Palette.Title);
  End;
  For J:=0to(ChildW.MaxY)do For I:=0to(ChildW.MaxX)do Begin
   WEPutTxtXYT(ChildW,I,J,'˙');
  End;
  If TmpList.Count>0Then Begin
   ALSetPtr(TmpList,0);
   For JK:=0to TmpList.Count-1do Begin
    PB:=_ALGetCurrBuf(TmpList);
    Case PB^of
     7:WEPutTxtXY(ChildW,PT^.X,PT^.Y,PT^.Msg);
     $81..$84,$86:Begin
      WESetKr(ChildW,$8F);
      WEBarSpcHorShade(ChildW,PI^.X1,PI^.Y,PI^.X2);
      WESetKrBorder(ChildW);
     End;
     $87:Begin
      WESubList(ChildW,PLB^.X1,PLB^.Y1,PLB^.X2,PLB^.Y2,PLB^.Title,LM);
      LMDone(LM);
     End;
     $88:Begin
      WESetKr(ChildW,PSB^.Attr);
      WEBarSpcHorShade(ChildW,PSB^.X1,PSB^.Y,PSB^.X2);
     End;
     $8C:Begin
      SetBorderSimple;
      OldShade:=GetShade;
      SetShade(No);
      PutFillBorder(WEGetRX1(ChildW)+PF^.X1,
                    WEGetRY1(ChildW)+PF^.Y1,
                    WEGetRX1(ChildW)+PF^.X2,
                    WEGetRY1(ChildW)+PF^.Y2,ChildW.CurrColor);
      SetBorderSimpleLuxe;
      SetShade(OldShade);
      If PF^.Title<>''Then Begin
       WESetKrHigh(ChildW);
       WEPutTxtXY(ChildW,PF^.X1+1,PF^.Y1,' '+PF^.Title+' ');
       WESetKrBorder(ChildW);
      End;
     End;
     $8D:SOInit(PRB^.SO,WEGetRX1(ChildW)+PRB^.X,WEGetRY1(ChildW)+PRB^.Y,PRB^.Title,PRB^.List,0);
     $8F:WEPutTxtXY(ChildW,PCB^.X,PCB^.Y,StrUSpc(PCB^.Msg,PCB^.Len)+'[ ]');
    End;
    ALNext(TmpList);
   End;
  End;
 End;

 Procedure SelBar;Begin
  WESetKrSel(W);
  WEBarSelHor(W,17,Y,wnMax);
 End;

 Procedure UnselBar;Begin
  W.CurrColor:=CurrKrs.Dialog.Env.List.Border;
  WEBarSpcHor(W,17,Y,wnMax);
  WEPutSmlTxtXY(W,17,Y,Value(Y));
  WEBarSpcHorRelief(W,17,Y,wnMax);
 End;

 Procedure ChoicePalette;
 Var
  L:LstMnu;
  X:Byte;
 Begin
  LMInitCenter(L,40,10,'Couleur de la boåte de dialogue',CurrKrs.Dialog.Env.List);
  ALAddStrByte(L.List,'Boåte de dialogue classique',kcDials+1);
  ALAddStrByte(L.List,'Gestionnaire de fichiers',kcFileManager+1);
  ALAddStrByte(L.List,'Aide',kcHelp+1);
  ALAddStrByte(L.List,'Dessin',kcDraw+1);
  ALAddStrByte(L.List,'Editeur d''icìne',kcEditIcon+1);
  ALAddStrByte(L.List,'Regarde/Editeur HexadÇcimal',kcHexView+1);
  ALAddStrByte(L.List,'Regarde ASCII',kcViewAscii+1);
  ALAddStrByte(L.List,'Journal',kcPJ+1);
  ALAddStrByte(L.List,'Traitement de texte',kcEditor+1);
  ALAddStrByte(L.List,'Terminal',kcTerminal+1);
  ALAddStrByte(L.List,'Ouverture de fichier',kcOpenWin+1);
  LMGotoPos(L,TX.Palette+1);
  X:=LMRun(L);
  LMDone(L);
  If X<>0Then Begin
   TX.Palette:=X-1;
   WEDone(ChildW);
   InitChild;
   WESetPos(W,17,Y);
   W.CurrColor:=CurrKrs.Dialog.Env.List.Border;
   WEBarSpcHor(W,W.X,W.Y,wnMax);
   WEPutTxt(W,Value(P));
   WEClrEol(W);
   SelBar;
  End;
 End;

 Procedure RefreshComposant;Var I:Byte;Index:Word;Begin
  For I:=0to 6do Begin
   Index:=I shl 1;
   If(I=ComposantPosition)Then Inc(Index);
   _RIViewImage('OVERCODE.RLL',Index,BarW,1,BarW.MaxX-(Succ(I)shl 2),HeightChr shl 1,32,0);
  End;
 End;

 Procedure AddTextManuel;Var Data:Record
  X,Y:Byte;
  Msg:String;
 End;
 Begin
  FillClr(Data,SizeOf(Data));
  If(TX.UpBar)Then Data.Y:=1;
  If ExecuteAppDPU(61,Data)Then Begin
   WEPutTxtXY(ChildW,Data.X,Data.Y,Data.Msg);
   AddElementText(Data.X,Data.Y,Data.Msg);
  End;
 End;

 Procedure AddCheckBoxManuel;Var Data:Record
  X,Y:Byte;
  Len:Byte;
  Msg:String;
 End;
 Begin
  FillClr(Data,SizeOf(Data));
  If(TX.UpBar)Then Data.Y:=1;
  If ExecuteAppDPU(62,Data)Then Begin
   WEPutTxtXY(ChildW,Data.X,Data.Y,StrUSpc(Data.Msg,Data.Len)+'[ ]');
   AddElementCheckBox(Data.X,Data.Y,Data.Len,Data.Msg);
  End;
 End;

 Procedure NewText;Var X,Y:Byte;Msg:String;Begin
  Msg:='texte'+WordToStr(NumTxt);
  X:=(W.MaxX-Length(Msg))shr 1;
  Y:=W.MaxY shr 1;
  WEPutTxtXY(ChildW,X,Y,Msg);
  AddElementText(X,Y,Msg);
 End;

 Procedure NewCheckBox;Var X,Y:Byte;Msg:String;Begin
  Msg:='CheckBox'+WordToStr(NumCheckBox);
  X:=(W.MaxX-Length(Msg))shr 1;
  Y:=W.MaxY shr 1;
  WEPutTxtXY(ChildW,X,Y,Msg+' [ ]');
  AddElementCheckBox(X,Y,0,Msg);
 End;

 Procedure RefreshChild;Begin
  WEDone(ChildW);
  InitChild;
 End;

 Procedure EditElement(Index:Word);
 Var PB:^Byte;
     PT:^ElementText Absolute PB;
     PCB:^ElementCheckBox Absolute PB;
     MB,K:Word;
     DX,DY,MX,MY:Byte;
     OrgX,OrgY:Integer;{ DÇcalage par rapport Ö l'origine }
     MoveElement:Bool; { L'ÇlÇment a ÇtÇ dÇplacÇ? }
 Begin
  MoveElement:=False;
  PB:=_ALGetBuf(TmpList,Index);
  Case(PB^)of
   7:Begin
    OrgX:=LastMsX-WEGetRX1(ChildW)-PT^.X;
    OrgY:=LastMsY-WEGetRY1(ChildW)-PT^.Y;
    Repeat
     __ShowMousePtr;
     Repeat
      __GetMouseTextSwitch(MX,MY,MB);
      If WEInWindow(ChildW,MX,MY)Then Begin
       DX:=MX-WEGetRX1(ChildW);
       DY:=MY-WEGetRY1(ChildW);
       If(DX<>PT^.X+OrgX)or(DY<>PT^.Y+OrgY)Then Begin
        __HideMousePtr;
        WEPutTxtXY(ChildW,PT^.X,PT^.Y,MultChr('˙',255));
        PT^.X:=DX-OrgX;PT^.Y:=DY-OrgY;
        WEPutTxtXY(ChildW,PT^.X,PT^.Y,PT^.Msg);
        __ShowMousePtr;
        MoveElement:=Ya;
       End;
      End;
     Until MB=0;
     __HideMousePtr;
     If(MoveElement)Then Break;
     WESetPos(ChildW,PT^.X,PT^.Y);
     K:=WEInpStr(ChildW,PT^.Msg);
    Until K<>kbInWn;
    RefreshChild;
   End;
   $8F:Begin
    OrgX:=LastMsX-WEGetRX1(ChildW)-PCB^.X;
    OrgY:=LastMsY-WEGetRY1(ChildW)-PCB^.Y;
    Repeat
     __ShowMousePtr;
     Repeat
      __GetMouseTextSwitch(MX,MY,MB);
      If WEInWindow(ChildW,MX,MY)Then Begin
       DX:=MX-WEGetRX1(ChildW);
       DY:=MY-WEGetRY1(ChildW);
       If(DX<>PCB^.X+OrgX)or(DY<>PCB^.Y+OrgY)Then Begin
        __HideMousePtr;
        WEPutTxtXY(ChildW,PCB^.X,PCB^.Y,MultChr('˙',255));
        PCB^.X:=DX-OrgX;PCB^.Y:=DY-OrgY;
        WEPutTxtXY(ChildW,PCB^.X,PCB^.Y,PCB^.Msg);
        __ShowMousePtr;
        MoveElement:=Ya;
       End;
      End;
     Until MB=0;
     __HideMousePtr;
     If(MoveElement)Then Break;
     WESetPos(ChildW,PCB^.X,PCB^.Y);
     K:=WEInpStr(ChildW,PCB^.Msg);
    Until K<>kbInWn;
    RefreshChild;
   End;
  End;
 End;

Begin
 ALInit(TmpList);
 P:=0;Y:=0;NameComposant:='';ComposantPosition:=6;
 NumTxt:=1;NumCheckBox:=1;NumFrame:=1;NumInput:=1;
 NumListBox:=1;NumRadioButton:=1;NumScrollBar:=1;
 FillClr(TX,SizeOf(TX));
 TX.ProcName:='Dialog';TX.Title:='Sans titre';
 TX.NumXTexts:=40;TX.NumYTexts:=15;TX.Palette:=0;
 TX.CloseIcon:=Ya;TX.UpBar:=Ya;TX.RightBar:=No;
 LoadRessource;
 WEInit(W,1,5,30,5+11);
 WEPushWn(W);
 WEPutWnKrDials(W,'Inspecteur d''objet');
 WECloseIcon(W);
 WEPutBarMsRight(W);
 WEInit(BarW,32,5,MaxXTxts-1,9);
 WEPushWn(BarW);
 WEPutWnKrDials(BarW,'Composantes');
 WECloseIcon(BarW);
 WEBar(BarW);
 RefreshComposant;
 InitChild;
 For I:=0to(W.MaxY)do Begin
  WESetKrBorder(W);
  WEPutSmlTxtXY(W,W.X,W.Y,Element(I));
  WEBarSpcHorRelief(W,0,W.Y,16);
  W.CurrColor:=CurrKrs.Dialog.Env.List.Border;
  W.X:=17;
  WEBarSpcHor(W,W.X,W.Y,wnMax);
  WEBarSpcHorRelief(W,W.X,W.Y,wnMax);
  WEPutSmlTxtXY(W,W.X,W.Y,Value(I));
  WELn(W);
 End;
 SelBar;
 Repeat
  Case(P)of
   1:Begin
    WESetPos(W,17,Y);
    K:=WEInpStr(W,TX.ProcName);
   End;
   2:Begin
    WESetPos(W,17,Y);
    S:=TX.Title;K:=WEInpStr(W,S);
    If(S<>TX.Title)Then Begin
     TX.Title:=S;
     WEDone(ChildW);
     InitChild;
    End;
   End;
   3,4:Begin
    S:=Value(P);
    WESetPos(W,17,Y);
    K:=WEInpStr(W,S);
    I:=StrToWord(S);
    If P=3Then Begin
     If(TX.NumXTexts<>I)Then Begin
      TX.NumXTexts:=I;
      WEDone(ChildW);
      InitChild;
     End;
    End
     Else
    Begin
     If(TX.NumYTexts<>I)Then Begin
      TX.NumYTexts:=I;
      WEDone(ChildW);
      InitChild;
     End;
    End;
   End;
   Else K:=WEReadk(W);
  End;
  Case(K)of
   kbClose,kbEsc:Break;
   kbMouse:If WEInWindow(BarW,LastMsX,LastMsY)Then Begin
    TP:=(LastMsX-WEGetRX1(BarW)-1)shr 2;
    If TP<7Then Begin
     If(TP<>ComposantPosition)Then Begin
      WaitMsBut0;
      ComposantPosition:=TP;
      RefreshComposant;
     End
      Else
     If LastMsB=2Then Begin
      WaitMsBut0;
      Case(TP)of
       0:AddCheckBoxManuel;
       1:;
       2:;
       3:;
       4:;
       5:;
       6:AddTextManuel;
      End;
     End
      Else
     If LastMsB=1Then Begin
      WaitMsBut0;
      Case(TP)of
       0:NewCheckBox;
       6:NewText;
      End;
     End;
    End;
   End
    Else
   If WEInWindow(ChildW,LastMsX,LastMsY)Then Begin
    TP:=SearchElement(LastMsX,LastMsY);
    If TP<>$FFFFThen Begin
     EditElement(TP);
    End;
   End;
   kbInWn:Begin
    WaitMsBut0;
    UnSelBar;
    P:=LastMsY-WEGetRY1(W);
    If(Y=P)and(Y in[5..9])Then PushKey(Byte(' '));
    Y:=P;
    SelBar;
   End;
   kbUp:If P>0Then Begin
    UnSelBar;
    Dec(P);Dec(Y);
    SelBar;
   End;
   kbDn:If(P<MaxElem)Then Begin
    UnSelBar;
    Inc(P);Inc(Y);
    SelBar;
   End;
   Else If Chr(K)=' 'Then Begin
    Case(P)of
     5:ChoicePalette;
     6..9:Begin
      Case(P)of
       6:TX.CloseIcon:=Not TX.CloseIcon;
       7:TX.UpBar:=Not TX.UpBar;
       8:TX.RightBar:=Not TX.RightBar;
       9:TX.StatusBar:=Not TX.StatusBar;
      End;
      WEPutTxtXYU(W,17,Y,Value(P));
      WEDone(ChildW);
      InitChild;
     End;
    End;
   End;
  End;
 Until No;
 WEDone(ChildW);
 WEDone(BarW);
 WEDone(W);
 WriteRessource;
 ALDone(TmpList);
End;

Procedure PRNewComposant{Var Q:ProjectRec};
Const
  {Modäle de composant}
 prcMain=$0001;   { Corps d'une application (AppInit...) }
 prcLstMnu=$0002; { SÇlection d'une option dans une liste }
 prcWins=$0003;   { Boåte de dialogue simple }
 prcAppMDI=$0004; { Fenàtre d'application MDI }

Var
 TL:ArrayList;
 NameComposant:String;
 WD:DefinitionWins;
 PC:^ElemRec;

 Procedure InsInterface;Begin
  ALAddLn(TL);
  ALAddStr(TL,'{'+MultChr('ƒ',76)+'}');
  ALAddStr(TL,Spc((78-9)shr 1)+'INTERFACE');
  ALAddStr(TL,'{'+MultChr('ƒ',76)+'}');
  ALAddLn(TL);
 End;

 Procedure InsImplementation;Begin
  ALAddLn(TL);
  ALAddStr(TL,'{'+MultChr('ƒ',76)+'}');
  ALAddStr(TL,Spc((78-14)shr 1)+'IMPLEMENTATION');
  ALAddStr(TL,'{'+MultChr('ƒ',76)+'}');
  ALAddLn(TL);
 End;

 Procedure InsEndUnit;Begin
  ALAddLn(TL);
  ALAddStr(TL,'{'+MultChr('ƒ',76)+'}');
  ALAddStr(TL,'END.');
 End;

 Function Category:Word;
 Var
  L:LstMnu;
 Begin
  LMInitCenter(L,40,10,'Type du composante',CurrKrs.Dialog.Window);
  ALAddStrByte(L.List,'Application',prcAppMDI);
  ALAddStrByte(L.List,'Boåte de dialogue',prcWins);
  ALAddStrByte(L.List,'Programme principal',prcMain);
  ALAddStrByte(L.List,'SÇlection dans une liste',prcLstMnu);
  Category:=LMRun(L);
  LMDone(L);
 End;

Begin
 PC:=_ALGetBuf(Q.Lst,Q.P);
 If(PC<>NIL)and(PC^.Source=vtRC)Then Begin
  PRRessourceDevelopper(Q);
 End
  Else
 Case(Category)of
  prcAppMDI:Begin
   NameComposant:=OpenWin('*.PAS','Sauvegarde le composant sous');
   If NameComposant<>''Then Begin
    ALInit(TL);
    ALAddStr(TL,'{ DÇvelopper par l''OverCode }');
    ALAddLn(TL);
    ALAddStr(TL,'Unit '+Path2Name(NameComposant)+';');
    InsInterface;
    ALAddStr(TL,'Function  STNew(Var Q;X1,Y1,X2,Y2:Byte):Boolean;');
    ALAddStr(TL,'Procedure STLoad(Var Q;X1,Y1,X2,Y2:Byte;Const Path:String);');
    ALAddStr(TL,'Procedure STRefresh(Var Q);');
    ALAddStr(TL,'Function  STRun(Var Q):Word;');
    ALAddStr(TL,'Function  STDone(Var Q):Word;');
    InsImplementation;
    ALAddStr(TL,'Uses Systex,Systems,Mouse,Dials;');
    ALAddLn(TL);
    ALAddStr(TL,'Function  STNew{Var Q;X1,Y1,X2,Y2:Byte):Boolean};Begin');
    ALAddStr(TL,'End;');
    ALAddLn(TL);
    ALAddStr(TL,'Procedure STLoad{Var Q;X1,Y1,X2,Y2:Byte;Const Path:String};Begin');
    ALAddStr(TL,'End;');
    ALAddLn(TL);
    ALAddStr(TL,'Procedure STRefresh{Var Q};Begin');
    ALAddStr(TL,'End;');
    ALAddLn(TL);
    ALAddStr(TL,'Function  STRun{Var Q):Word};Begin');
    ALAddStr(TL,' STRun:=ReadKey;');
    ALAddStr(TL,'End;');
    ALAddLn(TL);
    ALAddStr(TL,'Function  STDone{Var Q):Word};Begin');
    ALAddStr(TL,' STDone:=0;');
    ALAddStr(TL,'End;');
    InsEndUnit;
    ALSaveFileASCII(TL,NameComposant,Ya);
    PRAddFile(Q,NameComposant);
    ALDone(TL);
   End
    Else
   ErrMsgOk('Impossible d''enregistrer le composant!');
  End;
  prcMain:Begin
   ALInit(TL);
   ALAddStr(TL,'{ DÇvelopper par l''OverCode }');
   ALAddLn(TL);
   If Q.Title=''Then ALAddStr(TL,'Program SansTitre;')
                Else ALAddStr(TL,'Program '+DelChr(Q.Title,' ')+';');
   ALAddLn(TL);
   ALAddStr(TL,'Uses Systex,Systems,Video,Mouse,Dials;');
   ALAddLn(TL);
   ALAddStr(TL,'BEGIN');
   ALAddStr(TL,' InitSystems(suIsabel);');
   If Q.Path<>''Then ALAddStr(TL,' PathDskSwp:=FileExpand('''+Path2NoExt(Q.Path)+'.$$$'');');
   ALAddStr(TL,' InitMemManagers;');
   ALAddStr(TL,' InitVideoDeluxe;');
   ALAddStr(TL,' __InitMouse;');
   If Q.Title=''Then ALAddStr(TL,' AppInit(''ÆSans titreØ'',$78,MtxBleuet);')
                Else ALAddStr(TL,' AppInit('''+Q.Title+''',$78,MtxBleuet);');
   ALAddStr(TL,' ReadKey; { ... ChangÇ le programme ici ... }');
   ALAddStr(TL,' DoneLuxeVideo;');
   ALAddStr(TL,' DoneMemManagers;');
   ALAddStr(TL,'END.');
   NameComposant:=OpenWin('*.PAS','Sauvegarde le composant sous');
   If NameComposant<>''Then Begin
    ALSaveFileASCII(TL,NameComposant,Ya);
    PRAddFile(Q,NameComposant);
   End
    Else
   ErrMsgOk('Impossible d''enregistrer le composant!');
   ALDone(TL);
  End;
  prcLstMnu:Begin
   ALInit(TL);
   ALAddStr(TL,'{ DÇvelopper par l''OverCode }');
   ALAddLn(TL);
   ALAddStr(TL,'Unit '+Path2Name(NameComposant)+';');
   InsInterface;
   ALAddStr(TL,'Procedure ListeSansNom;');
   InsImplementation;
   ALAddStr(TL,'Uses Systex,Dials;');
   ALAddLn(TL);
   ALAddStr(TL,'Procedure ListeSansNom;Begin');
   ALAddStr(TL,' LMInitCenter(L,40,10,''Sans titre'',CurrKrs.Dialog.Wins);');
   ALAddStr(TL,' { InsÇrer ici vos item... }');
   ALAddStr(TL,' X:=LMRun(L);');
   ALAddStr(TL,' LMDone(L);');
   ALAddStr(TL,'End;');
   InsEndUnit;
   PRAddFile(Q,NameComposant);
  End;
  prcWins:Begin
   NameComposant:=OpenWin('*.PAS','Sauvegarde dans l''UnitÇ');
   If NameComposant<>''Then Begin
    WD.ProcName:='Dialog';WD.Title:='Sans titre';
    WD.NumXTexts:=40;WD.NumYTexts:=15;WD.Palette:=0;
    WD.CloseIcon:=Ya;WD.UpBar:=Ya;WD.RightBar:=No;
    SelectDial(WD,NameComposant);
    ALInit(TL);
    ALAddStr(TL,'{ DÇvelopper par l''OverCode }');
    ALAddLn(TL);
    ALAddStr(TL,'Unit '+Path2Name(NameComposant)+';');
    InsInterface;
    ALAddStr(TL,'Procedure '+WD.ProcName+';');
    InsImplementation;
    ALAddStr(TL,'Uses Systex,Dials;');
    ALAddLn(TL);
    ALAddStr(TL,'Procedure '+WD.ProcName+';Var W:Wins;Begin');
    ALAddStr(TL,StrInitO(WD));
    {' WEInitO(W,'+StrW(WD.NumXTexts)+','+StrW(WD.NumYTexts)+');');}
    ALAddStr(TL,' WEPushWn(W);');
    ALAddStr(TL,StrPutWn(WD));
{    Case(WD.Palette)of
     kcFileManager:RBAddStr(TL,' WEPutWn(W,'''+WD.Title+''',CurrKrs.FileManager.Wins);');
     kcHelp:RBAddStr(TL,' WEPutWn(W,'''+WD.Title+''',CurrKrs.Help.Wins);');
     kcDraw:RBAddStr(TL,' WEPutWn(W,'''+WD.Title+''',CurrKrs.Draw.Wins);');
     kcEditIcon:RBAddStr(TL,' WEPutWn(W,'''+WD.Title+''',CurrKrs.EditButt);');
     kcHexView:RBAddStr(TL,' WEPutWn(W,'''+WD.Title+''',CurrKrs.HexView.Wins);');
     kcViewAscii:RBAddStr(TL,' WEPutWn(W,'''+WD.Title+''',CurrKrs.ViewAscii.Wins);');
     kcPJ:RBAddStr(TL,' WEPutWn(W,'''+WD.Title+''',CurrKrs.PersonalJournal.Wins);');
     kcEditor:RBAddStr(TL,' WEPutWn(W,'''+WD.Title+''',CurrKrs.Editor.Wins);');
     kcTerminal:RBAddStr(TL,' WEPutWn(W,'''+WD.Title+''',CurrKrs.MalteDos.Wins);');
     kcOpenWin:RBAddStr(TL,' WEPutWn(W,'''+WD.Title+''',CurrKrs.OpenWin.Wins);');
     Else RBAddStr(TL,' WEPutWnKrDials(W,'''+WD.Title+''');');
    End;}
    If(WD.CloseIcon)Then ALAddStr(TL,' WECloseIcon(W);');
    If(WD.UpBar)Then ALAddStr(TL,' WEBar(W);');
    If(WD.RightBar)Then ALAddStr(TL,' WEPutBarMsRight(W);');
    If(WD.StatusBar)Then ALAddStr(TL,' WESetEndBarCTitle(W);');
    ALAddStr(TL,' WEDone(W);');
    ALAddStr(TL,'End;');
    InsEndUnit;
    ALSaveFileASCII(TL,NameComposant,Ya);
    ALDone(TL);
    PRAddFile(Q,NameComposant);
   End;
  End;
 End;
End;

END.