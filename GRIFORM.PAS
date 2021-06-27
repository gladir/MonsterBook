Program Griform;

{$M 65520,0,655360}
{$I DEF.INC}
Uses
 Adele,Systex,Isatex,Systems,Video,Mouse,
 Dials,Arcade,DialPlus,ToolView,Dialex;

Const
 DirIntr=';\ATLAS\GRIFORM\TABLEREF.ERE\INTERRUP.TIO\';
 DirBrowse='\SOURCE\CHANTAL\';
 gfInterrupt=$FF01;
 gfAsm=$FF02;
 gfBasic=$FF03;
 gfC=$FF04;
 gfPascal=$FF05;
 gfPL1=$FF06;
 gfExit=$FF07;
 gfSearchIntr=$FF08;
 gfSearchAsm=$FF09;
 gfSearchBasic=$FF0A;
 gfSearchC=$FF0B;
 gfSearchPascal=$FF0C;
 gfSearchPL1=$FF0D;
 gfBrowseUnit=$FF0E;
 Letter:Array[1..35]of Char='123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';
 MaxFiles=512;

Type
 IndRec=Record
  Title:String[242];
  Name:String[8];
  Pos:Long;
 End;
 Header=Record
  Sign:Array[0..7]of Char;
  Files:Array[0..35]of SearchRec;
 End;

 BrowseHeader=Record
  Sign:Array[0..7]of Char;
  Files:Array[0..MaxFiles]of SearchRec;
 End;

Procedure MakeMnu;Begin
 PMInit;
 PMSetWinBar(0,1,MaxXTxts);
 PMAddMnu('^G^uide');
  PMAddItemKey('^I^nterruption',kbNoKey,gfInterrupt,'Permet de connaŒtre quelques informations '+
                'sur les interruptions du standard d''IBM');
  PMAddBarItem;
  PMAddItemKey('^A^ssembleur',kbNoKey,gfAsm,'Permet de connaŒtre la liste des instructions Assembleur INTEL');
  PMAddItemKey('^B^asic',kbNoKey,gfBasic,'Permet de connaŒtre la liste des proc‚dures Basic');
  PMAddItemKey('^C^/C++',kbNoKey,gfC,'Permet de connaŒtre la liste des fonctions C/C++');
  PMAddItemKey('^P^ascal',kbNoKey,gfPascal,'Permet de connaŒtre la liste des proc‚dures Pascal');
  PMAddItemKey('PL/^1^',kbNoKey,gfPL1,'Permet de connaŒtre la liste des proc‚dures PL/1');
  PMAddBarItem;
  PMAddItemKey('^Q^uitter',kbAltX,gfExit,'Quitter le Griform');
 PMAddMnu('^B^ibliothŠque');
  PMAddItemKey('Malte Genesis V: AdŠle',kbNoKey,gfBrowseUnit,'Consultation de l''ensemble Malte Genesis V: AdŠle');
 PMAddMnu('^R^echerche');
  PMAddItemKey('^I^nterruption',kbNoKey,gfSearchIntr,'Permet de rechercher dans la liste une interruption du standard d''IBM');
  PMAddBarItem;
  PMAddItemKey('^A^ssembleur',kbNoKey,gfSearchAsm,'Permet de rechercher dans la liste une d‚finition Assembleur');
  PMAddItemKey('^B^asic',kbNoKey,gfSearchBasic,'Permet de rechercher dans la liste une d‚finition Basic');
  PMAddItemKey('^C^/C++',kbNoKey,gfSearchC,'Permet de rechercher dans la liste une d‚finition C/C++');
  PMAddItemKey('^P^ascal',kbNoKey,gfSearchPascal,'Permet de rechercher dans la liste une d‚finition Pascal');
  PMAddItemKey('PL/^1^',kbNoKey,gfSearchPL1,'Permet de rechercher dans la liste une d‚finition PL/1');
End;

Procedure MakeIntr;
Var
 HT:Hdl;
 Path,Source:String;
 P:Long;
 L:Window;
 LP:Byte;
 Head:Header;
 X:SearchRec;
 Ok:Boolean;

 Procedure MakeFile(Const FileName:String);
 Label 1;
 Var
  HS:Hdl;
  FP,FS:LongInt;
  S,Wd,W2,W3,WT:String;
  Ind:IndRec;
  I:Byte;
 Begin
  HS:=FileOpen(FileName,fmRead);
  If(HS=errHdl)Then Begin
   __FileNotFound(FileName);
   Exit;
  End;
  FillClr(Ind,SizeOf(Ind));
  FP:=0;FS:=FileSize(HS);Ind.Name:=Path2Name(FileName);
  Repeat
   __GetAbsFileTxtLn(HS,FP,S);
   I:=1;
   SkipSpcInLn(I,S);
   If StrI(I,S)in[#1..#31]Then Begin
    Ind.Pos:=FP-Length(S)-2;Wd:='';
    While StrI(I,S)in[#1..' ']do Begin
     If S[I]=' 'Then Begin;IncStr(Wd,' ');Inc(I)End
                Else Begin;IncStr(Wd,S[I+1]);Inc(I,2)End;
    End;
  1:__GetAbsFileTxtLn(HS,FP,S);
    I:=1;W2:='';
    SkipSpcInLn(I,S);
    While StrI(I,S)in[#1..' ']do Begin
     If S[I]=' 'Then Begin;IncStr(W2,' ');Inc(I)End
                Else Begin;IncStr(W2,S[I+1]);Inc(I,2)End;
    End;
    If CmpLeft(StrUp(Wd),'LISTE DES INTERRUPTIONS - ')Then Begin
     If Not CmpLeft(StrUp(W2),'INTERRUPTION')Then Begin
      If W2<>' 'Then IncStr(Wd,' ');
      AddStr(Wd,W2);
      Goto 1;
     End;
     WT:=W2+':'+Copy(Wd,26,255);
     __GetAbsFileTxtLn(HS,FP,S);
     I:=1;W3:='';
     SkipSpcInLn(I,S);
     While StrI(I,S)in[#1..' ']do Begin
      If S[I]=' 'Then Begin;IncStr(W3,' ');Inc(I)End
                 Else Begin;IncStr(W3,S[I+1]);Inc(I,2)End;
     End;
     If W3<>''Then Begin
      If W3[1]<>'_'Then AddStr(WT,' ('+W3+')');
     End;
     Ind.Title:=WT;
     _SetAbsRec(HT,(P shl 8)+SizeOf(Head),SizeOf(Ind),Ind);
     Inc(P);
    End;
   End;
  Until FP>=FS;
  FileClose(HS);
 End;

Begin
 GetFile('INTERRUP.IND',0,SizeOf(Head),Head);
 If Head.Sign='GRIFORM'#26Then Begin
  Ok:=Ya;
  For LP:=1to 35do Begin
   Source:=FSearch('INTERRU'+Letter[LP]+'.GAT',DirIntr);
   FindFirst(Source,fa,X);
   If(SysErr=0)and(X.Time<>Head.Files[LP].Time)Then Ok:=No;
  End;
  If(Ok)Then Exit;
 End;
 DeleteFile('INTERRUP.IND');
 WEPushEndBar(L);
 WEPutLastBar('Un instant S.V.P. je suis en train de cr‚er le dictionnaire du Griform...');
 HT:=FileCreate('INTERRUP.IND');
 P:=0;
 FillClr(Head,SizeOf(Head));
 Head.Sign:='GRIFORM'#26;
 If(HT=hdlErr)Then Begin;ErrMsgOk('Erreur de cr‚ation d''index');Exit;End;
 For LP:=1to 35do Begin
  Source:=FSearch('INTERRU'+Letter[LP]+'.GAT',DirIntr);
  FindFirst(Source,fa,Head.Files[LP]);
  If FileExist(Source)Then MakeFile(Source);
 End;
 _SetAbsRec(HT,0,SizeOf(Header),Head);
 FileClose(HT);
 WEDone(L);
End;

Procedure ViewIntr(StartPos:Long);
Var
 Handle:Hdl;
 NR,P:Long;
 W,W2:Window;
 Y:Byte;
 Ind:IndRec;
 K:Word;
 V:ViewAsciiApp;

 Procedure SelHor;Begin WEBarSelHor(W,0,Y,wnMax)End;
 Procedure SelBar;Begin;WESetKrSel(W);SelHor;WESelRightBarPos(W,P,NR-1)End;
 Procedure UnSelBar;Begin
  WESetKrBorder(W);SelHor;
  {WEUnSelRightBarPos(W,P,NR-1)}
 End;

 Procedure PutHome;Var J:Long;Begin
  WESetPosHome(W);WESetKrBorder(W);
  For J:=0to(W.MaxY)do Begin
   _GetAbsRec(Handle,((P-Y+J)shl 8)+SizeOf(Header),SizeOf(Ind),Ind);
   WEPutTxt(W,Ind.Title);WEClrEol(W);WELn(W)
  End;
  SelBar;
 End;

 Procedure Up;Begin
  If P>0Then Begin
   UnSelBar;
   Dec(P);
   If Y>0Then Dec(Y)
    else
   Begin
    W.Y:=0;
    WEScrollUp(W,0,W.Y,wnMax,wnMax);
    W.X:=0;
    _GetAbsRec(Handle,(P shl 8)+SizeOf(Header),SizeOf(Ind),Ind);
    WEPutTxt(W,Ind.Title);WEClrEol(W);
   End;
   SelBar
  End;
 End;

 Procedure Dn;Begin
  If P<NR-1Then Begin
   UnSelBar;
   Inc(P);
   If(Y<W.MaxY)Then Inc(Y)Else Begin
    WEScrollDn(W,0,0,wnMax,wnMax);
    W.Y:=W.MaxY;W.X:=0;
    _GetAbsRec(Handle,(P shl 8)+SizeOf(Header),SizeOf(Ind),Ind);
    WEPutTxt(W,Ind.Title);WEClrEol(W);
   End;
   SelBar
  End
 End;

Begin
 MakeIntr;
 WEInitO(W,129,19);
 WEPushWn(W);
 WEPutWnKrDials(W,'Index d''Interruption');
 Handle:=FileOpen('INTERRUP.IND',fmRead);
 If(Handle=errHdl)Then Begin;__FileNotFound('INTERRUP.IND');Exit;End;
 NR:=(FileSize(Handle)-SizeOf(Header))shr 8;P:=StartPos;Y:=0;
 PutHome;
 Repeat
  K:=WEReadk(W);
  Case(K)of
   kbUp:Up;
   kbDn:Dn;
   kbHome:Begin;P:=0;Y:=0;PutHome;End;
   kbPgUp:If(P<W.MaxY)Then PushKey(kbHome)
    Else
   Begin
    Dec(P,W.MaxY);
    If(P<Y)Then Y:=P;
    PutHome;
   End;
   kbPgDn:If P+(W.MaxY shl 1)<NR-1Then Begin;Inc(P,W.MaxY);PutHome;End Else PushKey(kbEnd);
   kbEnd:If P<NR-1Then Begin
    P:=NR-1;Y:=W.MaxY;
    If(P<=W.MaxY)Then Y:=P;
    PutHome;
   End;
   kbEnter:Begin
    _GetAbsRec(Handle,(P shl 8)+SizeOf(Header),SizeOf(Ind),Ind);
    WEInit(W2,0,4,MaxXTxts,MaxYTxts-3);
    WEPushWn(W2);
    VAInit(V,0,4,MaxXTxts,MaxYTxts-3,FSearch(Ind.Name+'.GAT',DirIntr),No);
    VAGotoFilePos(V,Ind.Pos);
    VARun(V);
    VADone(V);
    WEDone(W2)
   End;
  End;
 Until K=kbEsc;
 FileClose(Handle);
 WEDone(W);
End;

Procedure MakeBrowse;
Var
 HT:Hdl;
 Path,Source:String;
 P:LongInt;
 L:Window;
 LP,J:Word;
 Head:BrowseHeader;
 X:SearchRec;
 Ok:Boolean;

 Procedure MakeFile(Const FileName:String);
 Label 1;
 Var
  HS:Hdl;
  FP,FS:Long;
  S:String;
  Ind:IndRec;
  I,IP:Byte;
  H,E:Chr;
 Begin
  HS:=FileOpen(FileName,fmRead);
  If(HS=errHdl)Then Begin
   __FileNotFound(FileName);
   Exit;
  End;
  FillClr(Ind,SizeOf(Ind));
  FP:=0;FS:=FileSize(HS);Ind.Name:=Path2Name(FileName);
  Repeat
   __GetAbsFileTxtLn(HS,FP,S);Ind.Pos:=FP-Length(S)-2;
   If CmpLeft(S,'{ÚÄÄÄÄÄÄÄÄÄ')or CmpLeft(S,'{ ÚÄÄÄÄÄÄÄÄ')Then Begin
    If S[3]='Ú'Then IP:=3 Else IP:=2;
    __GetAbsFileTxtLn(HS,FP,S);H:=S[IP];E:=S[Length(S)];
    BackStr(S);
    S:=LTrim(Copy(RTrim(S),IP+1,255));
    If(S<>'')and(H='³')and(E='Û')Then Begin
     Ind.Title:=S+' ('+Path2Name(FileName)+')';
     _SetAbsRec(HT,(P shl 8)+SizeOf(Head),SizeOf(Ind),Ind);
     Inc(P);
    End;
   End;
  Until FP>=FS;
  FileClose(HS);
 End;

Begin
 GetFile('ADELE.IND',0,SizeOf(Head),Head);
 If Head.Sign='GRIFORM'#26Then Begin
  Ok:=Ya;
  For LP:=0to(MaxFiles)do Begin
   Source:=FSearch(Head.Files[LP].Name,DirBrowse);
   FindFirst(Source,fa,X);
   If(SysErr=0)and(X.Time<>Head.Files[LP].Time)Then Ok:=No;
  End;
  If(Ok)Then Exit;
 End;
 DeleteFile('ADELE.IND');
 WEPushEndBar(L);
 WEPutLastBar('Un instant S.V.P. je suis en train de cr‚er le dictionnaire du Griform...');
 HT:=FileCreate('ADELE.IND');
 P:=0;
 FillClr(Head,SizeOf(Head));
 Head.Sign:='GRIFORM'#26;
 If(HT=hdlErr)Then Begin;ErrMsgOk('Erreur de cr‚ation d''index');Exit;End;
 LP:=0;Source:=DirBrowse+'*.PAS';
 FindFirst(Source,fa,X);
 While SysErr=0do Begin
  Head.Files[LP]:=X;
  Source:=DirBrowse+Head.Files[LP].Name;
  MakeFile(Source);
  Inc(LP);
  If(LP>MaxFiles)Then Break;
  FindNext(X);
 End;
 _SetAbsRec(HT,0,SizeOf(Header),Head);
 FileClose(HT);
 WEDone(L);
End;

Procedure ViewBrowse(StartPos:Long);
Var
 Handle:Hdl;
 NR,P:LongInt;
 W,W2:Window;
 Y:Byte;
 Ind:IndRec;
 K:Word;
 V:ViewAsciiApp;

 Procedure SelHor;Begin
  WEBarSelHor(W,0,Y,wnMax)
 End;

 Procedure SelBar;Begin
  WESetKrSel(W);
  SelHor;
  WESelRightBarPos(W,P,NR-1)
 End;

 Procedure UnSelBar;Begin
  WESetKrBorder(W);SelHor;
 {WEUnSelRightBarPos(W,P,NR-1)}
 End;

 Procedure PutHome;
 Var
  J:Long;
 Begin
  WESetPosHome(W);
  WESetKrBorder(W);
  For J:=0to(W.MaxY)do Begin
   _GetAbsRec(Handle,((P-Y+J)shl 8)+SizeOf(BrowseHeader),SizeOf(Ind),Ind);
   WEPutTxt(W,Ind.Title);WEClrEol(W);WELn(W)
  End;
  SelBar;
 End;

 Procedure Up;Begin
  If P>0Then Begin
   UnSelBar;
   Dec(P);
   If Y>0Then Dec(Y)
    else
   Begin
    W.Y:=0;
    WEScrollUp(W,0,W.Y,wnMax,wnMax);
    W.X:=0;
    _GetAbsRec(Handle,(P shl 8)+SizeOf(BrowseHeader),SizeOf(Ind),Ind);
    WEPutTxt(W,Ind.Title);WEClrEol(W);
   End;
   SelBar
  End;
 End;

 Procedure Dn;Begin
  If P<NR-1Then Begin
   UnSelBar;
   Inc(P);
   If(Y<W.MaxY)Then Inc(Y)Else Begin
    WEScrollDn(W,0,0,wnMax,wnMax);
    W.Y:=W.MaxY;W.X:=0;
    _GetAbsRec(Handle,(P shl 8)+SizeOf(BrowseHeader),SizeOf(Ind),Ind);
    WEPutTxt(W,Ind.Title);WEClrEol(W);
   End;
   SelBar
  End
 End;

Begin
 MakeBrowse;
 WEInitO(W,129,19);
 WEPushWn(W);
 WEPutWnKrDials(W,'Index du Malte Genesis V: Alias AdŠle');
 Handle:=FileOpen('ADELE.IND',fmRead);
 If(Handle=errHdl)Then Begin
  __FileNotFound('ADELE.IND');
  Exit;
 End;
 NR:=(FileSize(Handle)-SizeOf(BrowseHeader))shr 8;
 P:=StartPos;Y:=0;
 WESetEndBar(W,W.Palette.Title);
 WESetEndBarTxtX(W,2,CStrBasic(NR)+' item(s)',W.Palette.Title);
 PutHome;
 Repeat
  K:=WEReadk(W);
  Case(K)of
   kbUp:Up;
   kbDn:Dn;
   kbHome:Begin;P:=0;Y:=0;PutHome;End;
   kbPgUp:If(P<W.MaxY)Then PushKey(kbHome)
    Else
   Begin
    Dec(P,W.MaxY);
    If(P<Y)Then Y:=P;
    PutHome;
   End;
   kbPgDn:If P+(W.MaxY shl 1)<NR-1Then Begin;Inc(P,W.MaxY);PutHome;End Else PushKey(kbEnd);
   kbEnd:If P<NR-1Then Begin
    P:=NR-1;Y:=W.MaxY;
    If(P<=W.MaxY)Then Y:=P;
    PutHome;
   End;
   kbEnter:Begin
    _GetAbsRec(Handle,(P shl 8)+SizeOf(BrowseHeader),SizeOf(Ind),Ind);
    WEInit(W2,0,4,MaxXTxts,MaxYTxts-3);
    WEPushWn(W2);
    VAInit(V,0,4,MaxXTxts,MaxYTxts-3,FSearch(Ind.Name+'.PAS',DirBrowse),No);
    VAGotoFilePos(V,Ind.Pos);
    VARun(V);
    VADone(V);
    WEDone(W2)
   End;
  End;
 Until K=kbEsc;
 FileClose(Handle);
 WEDone(W);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Proc‚dure SearchIntr                           Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de rechercher une interruption avec ou sans fonction
 sp‚cifique.  Elle demande … l'utilisateur d'entr‚e l'interruption,  elle est
 effectue  ensuite  une  recherche  ®diochotomique¯  … l'int‚rieur du fichier
 ®INTERRUP.IND¯ en ordre croissant.


 Remarque
 ÍÍÍÍÍÍÍÍ

  þ La m‚thode ®Diochotomique¯ utilis‚ est tir‚ du livre ®Turbo Pascal et ses
    fichiers:  Version 4 et 5¯,  par Jacques Boisgontier et Christophe Donay,
    ‚dition P.S.I., 1989.
}

Procedure SearchIntr;
Const
 XInp=24;
Var
 W:Window;
 P:Byte;
 K,Err:Word;
 Ok:Boolean;
 Handle:Hdl;
 Inf,Sup,M,Pos:LongInt;
 KChr:Char Absolute K;
 PBuffer:Array[0..63]of Char;
 PC:PChr;
 S:Array[0..4]of String;
 Ind:IndRec;
Begin
 WEInitO(W,50,13);
 WEPushWn(W);
 WEPutWnKrDials(W,'Recherche d''Interruption');
 WELn(W);
 WEPutTxtLn(W,'Num‚ro d''Interruption');
 WELn(W);
 WEPutTxtLn(W,'Fonction');
 WELn(W);
 WEPutTxtLn(W,'Sous-Fonction');
 WELn(W);
 WEPutTxtLn(W,'Sous-Sous-Fonction');
 WESetKr(W,$8F);
 WEBarSpcHorShade(W,XInp,1,wnMax-1);
 WEBarSpcHorShade(W,XInp,3,wnMax-1);
 WEBarSpcHorShade(W,XInp,5,wnMax-1);
 WEBarSpcHorShade(W,XInp,7,wnMax-1);
 P:=0;Ok:=No;FillClr(S,SizeOf(S));
 WEPutkHorDn(W,'Correct|Annule');
 PC:=@PBuffer;
 Repeat
  Case(P)of
   0:Begin
    StrPCopy(@PBuffer,S[0]);
    WESetInpColors(W,$8F,W.Palette.Sel);
    K:=_WEInput(W,XInp,1,wnMax-1,12,PC);
    WESetKr(W,$8F);
    WEBarSelHor(W,XInp,1,wnMax-1);
    S[0]:=StrPas(PC);
    Case(K)of
     kbEsc:Break;
     kbUp:P:=4;
     kbDn,kbTab:P:=1;
     kbEnter:P:=4;
    End;
   End;
   1:Begin
    StrPCopy(@PBuffer,S[1]);
    WESetInpColors(W,$8F,W.Palette.Sel);
    K:=_WEInput(W,XInp,3,wnMax-1,12,PC);
    WESetKr(W,$8F);
    WEBarSelHor(W,XInp,3,wnMax-1);
    S[1]:=StrPas(PC);
    Case(K)of
     kbEsc:Break;
     kbUp:P:=0;
     kbDn,kbTab:P:=2;
     kbEnter:P:=4;
    End;
   End;
   2:Begin
    StrPCopy(@PBuffer,S[2]);
    WESetInpColors(W,$8F,W.Palette.Sel);
    K:=_WEInput(W,XInp,5,wnMax-1,12,PC);
    WESetKr(W,$8F);
    WEBarSelHor(W,XInp,5,wnMax-1);
    S[2]:=StrPas(PC);
    Case(K)of
     kbEsc:Break;
     kbUp:P:=1;
     kbDn,kbTab:P:=3;
     kbEnter:P:=4;
    End;
   End;
   3:Begin
    StrPCopy(@PBuffer,S[3]);
    WESetInpColors(W,$8F,W.Palette.Sel);
    K:=_WEInput(W,XInp,7,wnMax-1,12,PC);
    WESetKr(W,$8F);
    WEBarSelHor(W,XInp,7,wnMax-1);
    S[3]:=StrPas(PC);
    Case(K)of
     kbEsc:Break;
     kbUp:P:=2;
     kbDn,kbTab:P:=4;
     kbEnter:P:=4;
    End;
   End;
   4:Case WEGetkHorDn(W,'Correct|Annule')of
    kbEsc,1:Break;
    kbTab:P:=0;
    0:Begin;Ok:=Ya;Break;End;
   End;
  End;
 Until No;
 WEDone(W);
 If(Ok)Then Begin
  WEPushEndBar(W);
  WEPutLastBar('Un instant S.V.P., je recherche dans la liste...');
  Handle:=FileOpen('INTERRUP.IND',fmRead);
  If(Handle<>errHdl)Then Begin
   S[4]:='INTERRUPTION '+StrUp(S[0]);
   If S[4][Length(S[4])]<>'H'Then IncStr(S[4],'H');
   If S[1]<>''Then Begin
    AddStr(S[4],', FONCTION ');
    AddStr(S[4],StrUp(S[1]));
    If S[4][Length(S[4])]<>'H'Then IncStr(S[4],'H');
   End;
   If S[2]<>''Then Begin
    AddStr(S[4],', SOUS-FONCTION ');
    AddStr(S[4],StrUp(S[2]));
    If S[4][Length(S[4])]<>'H'Then IncStr(S[4],'H');
   End;
   If S[3]<>''Then Begin
    AddStr(S[4],', OPTION ');
    AddStr(S[4],StrUp(S[3]));
    If S[4][Length(S[4])]<>'H'Then IncStr(S[4],'H');
   End;
   {Effectue une recherche ®dichotomique¯}
   Sup:=(FileSize(Handle)-SizeOf(Header))shr 8;Ok:=No;
   If Sup=0Then Pos:=0
    Else
   Begin
    Inf:=0;Dec(Sup);
    While(Inf<=Sup)and(Not(Ok))do Begin
     M:=(Inf+Sup)shr 1;
     _GetAbsRec(Handle,(M shl 8)+SizeOf(Header),SizeOf(Ind),Ind);
     If CmpLeft(StrUp(Ind.Title),S[4])Then Begin;Pos:=M;Ok:=Ya;End
      Else
     Begin
      If S[4]>Left(StrUp(Ind.Title),Length(S[4]))Then Inf:=M+1 Else Sup:=M-1;
     End;
    End;
    If S[4]>Left(StrUp(Ind.Title),Length(S[4]))Then Pos:=M+1 Else Pos:=M-1;
   End;
  End;
  If Not(Ok)Then Begin
   WEDone(W);
   ErrMsgOk('D‚sol‚, votre interruption est introuvable!')
  End
   Else
  Begin
   Repeat
    _GetAbsRec(Handle,(Pos shl 8)+SizeOf(Header),SizeOf(Ind),Ind);
    Ok:=CmpLeft(StrUp(Ind.Title),S[4]);
    If(Ok)Then Dec(Pos);
   Until Not(Ok);
   WEDone(W);
   PushKey(kbEnter);ViewIntr(Pos+1)
  End;
  FileClose(Handle);
 End;
End;

Procedure Make(Const Path,FName,Name:String;Multi:Boolean);
Var
 HT:Hdl;
 Source:String;
 P:Long;
 L:Window;
 LP:Byte;
 Head:Header;
 X:SearchRec;
 Ok:Boolean;

 Procedure MakeFile(Const FileName:String);
 Var
  HS:Hdl;
  FP,FS:Long;
  S,Wd,W2,W3,WT:String;
  Ind:IndRec;
  I:Byte;
 Begin
  HS:=FileOpen(FileName,fmRead);
  If(HS=errHdl)Then Begin
   __FileNotFound(FileName);
   Exit;
  End;
  FillClr(Ind,SizeOf(Ind));
  FP:=0;FS:=FileSize(HS);Ind.Name:=Path2Name(FileName);
  Repeat
   __GetAbsFileTxtLn(HS,FP,S);
   I:=1;
   SkipSpcInLn(I,S);
   If StrI(I,S)in[#1..#31]Then Begin
    Ind.Pos:=FP-Length(S)-2;Wd:='';
    While StrI(I,S)in[#1..' ']do Begin
     If S[I]=' 'Then Begin;IncStr(Wd,' ');Inc(I)End
                Else Begin;IncStr(Wd,S[I+1]);Inc(I,2)End;
    End;
    __GetAbsFileTxtLn(HS,FP,S);
    I:=1;W2:='';
    SkipSpcInLn(I,S);
    While StrI(I,S)in[#1..' ']do Begin
     If S[I]=' 'Then Begin;IncStr(W2,' ');Inc(I)End
                Else Begin;IncStr(W2,S[I+1]);Inc(I,2)End;
    End;
    If CmpLeft(StrUp(Wd),'LANGAGE '+StrUp(Name))Then Begin
     WT:=Copy(Wd,12+Length(Name),255)+': '+W2;
     __GetAbsFileTxtLn(HS,FP,S);
     I:=1;W3:='';
     SkipSpcInLn(I,S);
     While StrI(I,S)in[#1..' ']do Begin
      If S[I]=' 'Then Begin;IncStr(W3,' ');Inc(I)End
                 Else Begin;IncStr(W3,S[I+1]);Inc(I,2)End;
     End;
     If W3<>''Then Begin
      If P=0Then WT:=W3 Else
      If W3[1]<>'_'Then AddStr(WT,' ('+W3+')');
     End;
     Ind.Title:=WT;
     _SetAbsRec(HT,(P shl 8)+SizeOf(Head),SizeOf(Ind),Ind);
     Inc(P);
    End;
   End;
  Until FP>=FS;
  FileClose(HS);
 End;

Begin
 GetFile(FName+'.IND',0,SizeOf(Head),Head);
 If Head.Sign='GRIFORM'#26Then Begin
  Ok:=Ya;
  For LP:=1to 35do Begin
   Source:=FSearch(FName+Letter[LP]+'.GAT',Path);
   FindFirst(Source,fa,X);
   If(SysErr=0)and(X.Time<>Head.Files[LP].Time)Then Ok:=No;
  End;
  If(Ok)Then Exit;
 End;
 DeleteFile(FName+'.IND');
 WEPushEndBar(L);
 WEPutLastBar('Un instant S.V.P. je suis en train de cr‚er le dictionnaire du Griform...');
 HT:=FileCreate(FName+'.IND');P:=0;
 FillClr(Head,SizeOf(Head));
 Head.Sign:='GRIFORM'#26;
 If(HT=hdlErr)Then Begin;ErrMsgOk('Erreur de cr‚ation d''index');Exit;End;
 If(Multi)Then For LP:=1to 35do Begin
  Source:=FSearch(FName+Letter[LP]+'.GAT',Path);
  FindFirst(Source,fa,Head.Files[LP]);
  If FileExist(Source)Then MakeFile(Source);
 End
  Else
 Begin
  Source:=FSearch(FName+'.GAT',Path);
  FindFirst(Source,fa,Head.Files[1]);
  If FileExist(Source)Then MakeFile(Source);
 End;
 _SetAbsRec(HT,0,SizeOf(Header),Head);
 FileClose(HT);
 WEDone(L);
End;

Procedure View(Const Path,FName,Name:String;Multi:Boolean;StartPos:LongInt);
Var
 Handle:Hdl;
 NR,P:Long;
 W,W2:Window;
 Y:Byte;
 Ind:IndRec;
 K:Word;
 V:ViewAsciiApp;

 Procedure SelHor;Begin WEBarSelHor(W,0,Y,wnMax)End;
 Procedure SelBar;Begin;WESetKrSel(W);SelHor;WESelRightBarPos(W,P,NR-1)End;
 Procedure UnSelBar;Begin
  WESetKrBorder(W);SelHor;
  {WEUnSelRightBarPos(W,P,NR-1)}
 End;

 Procedure PutHome;Var J:Long;Begin
  WESetPosHome(W);WESetKrBorder(W);
  For J:=0to(W.MaxY)do Begin
   _GetAbsRec(Handle,((P-Y+J)shl 8)+SizeOf(Header),SizeOf(Ind),Ind);
   WEPutTxt(W,Ind.Title);WEClrEol(W);WELn(W)
  End;
  SelBar;
 End;

 Procedure Up;Begin
  If P>0Then Begin
   UnSelBar;
   Dec(P);
   If Y>0Then Dec(Y)
    else
   Begin
    W.Y:=0;
    WEScrollUp(W,0,W.Y,wnMax,wnMax);
    W.X:=0;
    _GetAbsRec(Handle,(P shl 8)+SizeOf(Header),SizeOf(Ind),Ind);
    WEPutTxt(W,Ind.Title);WEClrEol(W);
   End;
   SelBar
  End;
 End;

 Procedure Dn;Begin
  If P<NR-1Then Begin
   UnSelBar;
   Inc(P);
   If(Y<W.MaxY)Then Inc(Y)Else Begin
    WEScrollDn(W,0,0,wnMax,wnMax);
    W.Y:=W.MaxY;W.X:=0;
    _GetAbsRec(Handle,(P shl 8)+SizeOf(Header),SizeOf(Ind),Ind);
    WEPutTxt(W,Ind.Title);WEClrEol(W);
   End;
   SelBar
  End
 End;

Begin
 Make(Path,FName,Name,Multi);
 WEInitO(W,129,19);
 WEPushWn(W);
 WEPutWnKrDials(W,'Index '+Name);
 Handle:=FileOpen(FName+'.IND',fmRead);
 If(Handle=errHdl)Then Begin;__FileNotFound(FName+'.IND');Exit;End;
 NR:=(FileSize(Handle)-SizeOf(Header))shr 8;P:=StartPos;Y:=0;
 PutHome;
 Repeat
  K:=WEReadk(W);
  Case(K)of
   kbUp:Up;
   kbDn:Dn;
   kbHome:Begin;P:=0;Y:=0;PutHome;End;
   kbPgUp:If(P<W.MaxY)Then PushKey(kbHome)
    Else
   Begin
    Dec(P,W.MaxY);
    If(P<Y)Then Y:=P;
    PutHome;
   End;
   kbPgDn:If P+(W.MaxY shl 1)<NR-1Then Begin;Inc(P,W.MaxY);PutHome;End Else PushKey(kbEnd);
   kbEnd:If P<NR-1Then Begin
    P:=NR-1;Y:=W.MaxY;
    If(P<=W.MaxY)Then Y:=P;
    PutHome;
   End;
   kbEnter:Begin
    _GetAbsRec(Handle,(P shl 8)+SizeOf(Header),SizeOf(Ind),Ind);
    WEInit(W2,0,4,MaxXTxts,MaxYTxts-3);
    WEPushWn(W2);
    VAInit(V,0,4,MaxXTxts,MaxYTxts-3,FSearch(Ind.Name+'.GAT',Path),No);
    VAGotoFilePos(V,Ind.Pos);
    VARun(V);
    VADone(V);
    WEDone(W2)
   End;
  End;
 Until K=kbEsc;
 FileClose(Handle);
 WEDone(W);
End;

Procedure Search(Const Title,Path,FName,Name:String;Multi:Boolean);
Const
 XInp=24;
Var
 W:Window;
 P,P2:Byte;
 K,Err:Word;
 Ok:Boolean;
 Handle:Hdl;
 Inf,Sup,M,Pos:LongInt;
 KChr:Char Absolute K;
 PBuffer:Array[0..63]of Char;
 PC:PChr;
 S:Array[0..4]of String;
 Ind:IndRec;
Begin
 S[0]:='';
 If(WinInp(50,Title,'Nom',CurrKrs.Dial.Window,No,S[0])<>kbEnter)Then Exit;
 WEPushEndBar(W);
 WEPutLastBar('Un instant S.V.P., je recherche dans la liste...');
 Handle:=FileOpen(FName+'.IND',fmRead);
 If(Handle<>errHdl)Then Begin
  S[4]:=StrUp(Trim(S[0]));
  If S[4][Length(S[4])]='*'Then BackStr(S[4])Else IncStr(S[4],':');
  {Effectue une recherche ®dichotomique¯}
  Sup:=(FileSize(Handle)-SizeOf(Header))shr 8;Ok:=No;
  If Sup=0Then Pos:=0
   Else
  Begin
   Inf:=0;Dec(Sup);
   While(Inf<=Sup)and(Not(Ok))do Begin
    M:=(Inf+Sup)shr 1;
    _GetAbsRec(Handle,(M shl 8)+SizeOf(Header),SizeOf(Ind),Ind);
    P2:=1;SkipSpcInLn(P2,Ind.Title);
    For P:=P2 to Length(Ind.Title)do Begin
     If Ind.Title[P]=' 'Then Break;
    End;
    If Ind.Title[P]=' 'Then Begin
     Ind.Title:=Copy(Ind.Title,P+1,255);
     If CmpLeft(Ind.Title,'de compilation … bascule')Then Ind.Title:=DelStr(Ind.Title,1,25);
     If CmpLeft(Ind.Title,'de compilation … param‚trage')Then Ind.Title:=DelStr(Ind.Title,1,29);
     If CmpLeft(Ind.Title,'conditionnel')Then Ind.Title:=DelStr(Ind.Title,1,13);
     If CmpLeft(Ind.Title,'r‚serv‚')Then Ind.Title:=DelStr(Ind.Title,1,8);
    End;
    If CmpLeft(StrUp(Ind.Title),S[4])Then Begin;Pos:=M;Ok:=Ya;End
     Else
    Begin
     If S[4]>Left(StrUp(Ind.Title),Length(S[4]))Then Inf:=M+1 Else Sup:=M-1;
    End;
   End;
   If S[4]>Left(StrUp(Ind.Title),Length(S[4]))Then Pos:=M+1 Else Pos:=M-1;
  End;
 End;
 WEDone(W);
 FileClose(Handle);
 If Not(Ok)Then ErrMsgOk('D‚sol‚, votre d‚finition est introuvable!')
  Else
 Begin
  PushKey(kbEnter);View(Path,FName,Name,Multi,Pos+1)
 End;
End;

{$I Library\System\Malte\Presenta.tio\PutTapis.Inc}

Var Output:ImgRec;K:Wd;

BEGIN
 InitSystems(suIsabel);
 If StrUp(ParamStr(1))<>'/NOSVGA'Then CheckSVGA:=Ya;
 PathDskSwp:=FileExpand('GRIFORM.$$$');
 InitMemManagers;
 PushScr(Output);
 SetVideoModeDeluxe(vmTxtC132);
 _InitEnv(MtxDiablo);
 InitDials;
 PutTapis(0,MaxYTxts,$4C);
 ConMacro('C'#0+Chr(CurrKrs.LastBar.Normal)+ { BarSpcHor(0,0,MaxXTxts,CurrKrs.LastBar.Normal); }
	  'I'+                               { PutCloseIcon(0,0,$F);}
	  'TO'#0+Chr(CurrKrs.LastBar.Normal)+'Griform'+'$'+
	  'C'#$FF+Chr(CurrKrs.Menu.Normal)); { BarSpcHor(0,MaxYTxts,MaxXTxts,CurrKrs.Menu.Normal);}
 SetPosDate(MaxXTxts-10,0);
 SetPosTime(MaxXTxts-20,0);
 MakeMnu;
 PMPutMnuBar;
 DialTimer:=Ya;
 Repeat
  K:=PMWaitForMnuAction;
  Case(K)of
   gfInterrupt:ViewIntr(0);
   gfAsm:View(';\ATLAS\GRIFORM\LANGAGE\ASSEMBLE.UR\','ASSEMBL','Assembleur',Ya,0);
   gfBasic:View(';\ATLAS\GRIFORM\LANGAGE\BASIC\','BASIC','Basic',Ya,0);
   gfC:View(';\ATLAS\GRIFORM\LANGAGE\C\','C','C/C++',Ya,0);
   gfPascal:View(';\ATLAS\GRIFORM\LANGAGE\PASCAL\','PASCAL','Pascal',Ya,0);
   gfPL1:View(';\ATLAS\GRIFORM\LANGAGE\PL1\','PL1','PL/1',No,0);
   gfSearchIntr:SearchIntr;
   gfSearchAsm:Search('Recherche une d‚finition Assembleur',';\ATLAS\GRIFORM\LANGAGE\ASSEMBLE.UR\','ASSEMBL','Assembleur',Ya);
   gfSearchBasic:Search('Recherche une d‚finition Basic',';\ATLAS\GRIFORM\LANGAGE\BASIC\','BASIC','Basic',Ya);
   gfSearchC:Search('Recherche une d‚finition C/C++',';\ATLAS\GRIFORM\LANGAGE\C\','C','C/C++',Ya);
   gfSearchPascal:Search('Recherche une d‚finition Pascal',';\ATLAS\GRIFORM\LANGAGE\PASCAL\','PASCAL','Pascal',Ya);
   gfSearchPL1:Search('Recherche une d‚finition PL/1',';\ATLAS\GRIFORM\LANGAGE\PL1\','PL1','PL/1',No);
   gfBrowseUnit:ViewBrowse(0);
   kbAltX,kbEsc:K:=gfExit;
  End;
 Until K=gfExit;
 FadeOut;
 DoneLuxeVideo;
 PopScr(Output);
 DoneMemManagers;
 DoneSystems;
END.