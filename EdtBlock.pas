Unit EdtBlock;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                  INTERFACE
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

{$I DEF.INC}
Uses Isatex;

Procedure TEHomeBlk(Var Q:EditorApp);
Procedure TEEndBlk(Var Q:EditorApp);
Procedure TECpyBlk(Var Q:EditorApp);
Procedure TEInsStrBlk(Var Q:EditorApp;Const S:String);
Procedure TEWriteBlk(Var Q:EditorApp);
Procedure TEWriteBlkHTML(Var Q:EditorApp);
Procedure TEInvAttrBlk(Var Q:EditorApp;Attr:Byte);
Procedure TECpyClipBoard(Var Q:EditorApp);
Procedure TECpyHTMLClipBoard(Var Q:EditorApp);
Function  PascalToHTML(Const Source,Dest:String):Boolean;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                 IMPLEMENTATION
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses
 Adele,Systex,Memories,Systems,Video,Dialex,Dials,DialPlus,Editex,Editor,
 Restex,ResServD,EdtLoad,EdtDone;

Procedure InvGatAttr(Len:Word;PChr,TChr:PChr;P,L:Word;Attr:Byte);Near;Forward;
Procedure TESetPtr(Var Q:EditorApp);Near;Forward;
Function  TEPopCurr(Var Q:EditorApp):PChr;Near;Forward;
Procedure _TESetModified(Var Q:EditorApp);Near;Forward;
Procedure _TEWriteBlk(Var Q:EditorApp;ClipBoard:Boolean);Near;Forward;
Procedure _TEWriteBlkHTML(Var Q:EditorApp;ClipBoard:Boolean);Near;Forward;

Procedure WaitMsg;
Var
 I:Byte;
Begin
 For I:=0to 7do If(KeyPress)Then WaitRetrace;
End;

{$I \Source\Chantal\TEPOPCUR.INC}
{$I \Source\Chantal\TESETPTR.INC}
{$I \Source\Chantal\_TESETMO.INC}
{$I \Source\Chantal\POSX2GAT.INC}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Proc‚dure InvGatAttr                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'inverser une attribut particulier … une partie de
 la chaŒne de caractŠres en param‚trage ®PChr¯ et retourne dans la chaŒne de
 caractŠres ®PChrT¯.


 Remarque
 ÍÍÍÍÍÍÍÍ

  þ Les chaŒnes  de caractŠres  ®PChrT¯  doit avoir  une longueur suffisante
    pour re‡evoir  en entier  la chaŒne  de caractŠres  avec  ses  nouvelles
    attributs.
}

Procedure InvGatAttr;
Var
 I,J,K:Wd;A:Byte;
Begin
 If Len=0Then Exit;
 J:=0;
 If P>0Then Begin
  For I:=0to P-1do Case PChr^[J]of
   #0:Begin MoveLeft(PChr^,TChr^,Len+1);Exit;End;
   #1..#31:If(Byte(PChr^[J])and cgDouble=cgDouble)Then Inc(J)Else Inc(J,2);
   Else Inc(J);
  End;
  MoveLeft(PChr^,TChr^,J);
 End;
 K:=J;
 For I:=P to P+L-1do Case PChr^[J]of
  #0: Begin TChr^[K]:=#0;Exit;End;
  ' ': Begin
   {If(Attr and cgUnderline<>cgUnderline)Then TChr[K]:='_'Else} TChr^[K]:=' ';
   Inc(J);Inc(K)
  End;
  #1..#31:Begin
   A:=Byte(PChr^[J])xor Attr;
   If A=0Then Begin
    TChr^[K]:=PChr^[J+1];
    Inc(K)
   End
    Else
   Begin
    TChr^[K]:=Char(A);
    TChr^[K+1]:=PChr^[J+1];
    Inc(K,2)
   End;
   Inc(J,2);
  End;
  Else Begin
   TChr^[K]:=Char(Attr);
   TChr^[K+1]:=PChr^[J];
   Inc(J);Inc(K,2)
  End;
 End;
 If(J-1<Len)Then MoveLeft(PChr^[J],TChr^[K],Len-J+1)
End;

Procedure TEHomeBlk;Begin
 Q.BX1:=Q.PX;Q.BY1:=Q.P;
 TEUpDateScr(Q)
End;

Procedure TEEndBlk;Begin
 Q.BX2:=Q.PX;Q.BY2:=Q.P;
 TEUpDateScr(Q)
End;

Procedure TECpyBlk;
Label OutMem;
Var
 TPC,PC,CpyPtr:PChr;
 PXG,L,L2,L3,I,J,BX1,P:Word;
Begin
 If(Q.BY1<=Q.BY2)Then Begin
  If(Q.BY1=Q.BY2)Then Begin
   If(Q.BX1<Q.BX2)Then Begin
    CpyPtr:=_ALGetBuf(Q.List,Q.BY1);
    If(StrLen(CpyPtr)<Q.BX1)Then Exit
    Else Begin
     If(Q.Mode=vtGat)Then Begin
      L3:=0;BX1:=PosX2Gat1(CpyPtr,Q.BX1);L:=BX1;PXG:=BX1;
      For I:=Q.BX1 to Q.BX2-1do Begin
       If CpyPtr^[L]=#0Then Break;
       If CpyPtr^[L]<' 'Then Begin
        Inc(L);
        Inc(L3)
       End;
       Inc(L);Inc(L3);
      End;
     End
      Else
     Begin
      L3:=Q.BX2-Q.BX1;
      PXG:=Q.BX1;
     End;
    End;
    PC:=TEPopCurr(Q);
    If IsPChrEmpty(PC)Then Begin
     L:=L3+Q.PX;PC:=ALSetCurrBuf(Q.List,L+1);
     If(PC=NIL)Then Goto OutMem;
     PC^[0]:=#0;StrInsBuf(PC,Q.PX,CpyPtr^[PXG],L3);
    End
     Else
    Begin
     TPC:=StrNew(PC);L:=StrLen(PC);
     If(TPC=NIL)Then Goto OutMem;
     If(Q.Mode<>vtGat)Then Q.PXG:=Q.PX
                      Else Q.PXG:=PosX2Gat1(TPC,Q.PX);
     If(Q.PXG>L)Then L2:=Q.PXG
                Else L2:=L;
     PC:=ALSetCurrBuf(Q.List,L2+L3+1);
     If(PC=NIL)Then Goto OutMem;
     StrCopy(PC,TPC);
     StrInsBuf(PC,Q.PXG,CpyPtr^[PXG],L3);
     StrDispose(TPC);
    End;
    Inc(Q.BX2,Q.PX-Q.BX1);Q.BX1:=Q.PX;Q.BY1:=Q.P;Q.BY2:=Q.P;
   End;
  End
   Else
  Begin
   PC:=TEPopCurr(Q);
   If IsPChrEmpty(PC)Then Begin
    ALSetPtr(Q.List,Q.BY1);P:=Q.P;
    CpyPtr:=_ALGetCurrBuf(Q.List);
    L:=StrLen(CpyPtr);
    PC:=ALSet(Q.List,P,L+1);
    If(PC=NIL)Then Goto OutMem;
    Inc(Q.FileSize,Long(L));
    StrCopy(PC,CpyPtr);
    Inc(P);
    ALNext(Q.List);
   End
    Else
   Begin
    ALSetPtr(Q.List,Q.BY1);P:=Q.P;
    CpyPtr:=_ALGetCurrBuf(Q.List);
    L2:=StrLen(CpyPtr);
    If(L2<Q.BX1)Then Begin
     Inc(P);
     ALNext(Q.List)
    End
     Else
    Begin
     L:=StrLen(PC);
     If(Q.Mode<>vtGat)Then Q.PXG:=Q.PX;
     If(L<=Q.PXG)Then Begin
      TPC:=StrNew(PC);
      If(TPC=NIL)Then Goto OutMem;
      PC:=ALSet(Q.List,P,L2+Q.PXG+2);
      If(PC=NIL)Then Goto OutMem;
      StrCopy(PC,TPC);
      StrIns(PC,Q.PXG,@CpyPtr^[Q.BX1]);
      StrDispose(TPC);
      Inc(P);
      ALNext(Q.List);
     End
      Else
     Exit;
    End;
   End;
   For J:=Q.BY1+1to(Q.BY2)do Begin
    CpyPtr:=_ALGetCurrBuf(Q.List);
    If Not IsPChrEmpty(CpyPtr)Then Begin
     L:=StrLen(CpyPtr);
     PC:=ALIns(Q.List,P,L+1);
     If(PC=NIL)Then Goto OutMem;
     Inc(Q.FileSize,Long(L));
     StrCopy(PC,CpyPtr);
    End
     Else
    ALInsStr(Q.List,P,'');
    Inc(P);
    ALNext(Q.List);
   End;
   TESetPtr(Q);
   Q.BX1:=Q.PX;
   Q.BY2:=Q.P+Q.BY2-Q.BY1;
   Q.BY1:=Q.P;
  End;
  TEUpDateScr(Q);
  TEUpDateInfo(Q);
  _TESetModified(Q);
 End;
 Exit;
OutMem:
 __OutOfMemory;
End;

Procedure TEInvAttrBlk(Var Q:EditorApp;Attr:Byte);
Var
 J:RBP;
 PC,NewPChr:PChr;
 L,I,N,RL:Word;
 W:Window;
Begin
 WEPushEndBar(W);
 WEPutLastBar('Un instant S.V.P., conversion en cours...');
 If(Q.BY1=Q.BY2)Then Begin
  PC:=_ALGetBuf(Q.List,Q.BY1);
  L:=StrLen(PC);N:=L;
  NewPChr:=MemAlloc(L+N+1);
  If(NewPChr=NIL)Then Begin
   WEDone(W);
   __OutOfMemory;
   Exit;
  End;
  InvGatAttr(L,PC,NewPChr,Q.BX1,Q.BX2-Q.BX1,Attr);
  RL:=StrLen(NewPChr)+1;
  PC:=ALSet(Q.List,Q.BY1,RL);
  If(PC=NIL)Then Begin
   WEDone(W);
   __OutOfMemory;
   Exit;
  End;
  Q.CurrPtr:=ALPushCurrPtr(Q.List);
  MoveLeft(NewPChr^,PC^,RL);
  FreeMemory(NewPChr,L+N+1)
 End
  Else
 For J:=Q.BY1 to(Q.BY2)do Begin
  PC:=_ALGetBuf(Q.List,J);
  L:=StrLen(PC);
  N:=L;
  NewPChr:=MemAlloc(L+N+1);
  If(NewPChr=NIL)Then Begin
   WEDone(W);
   __OutOfMemory;
   Exit;
  End;
  If(J=Q.BY2)Then InvGatAttr(L,PC,NewPChr,0,Q.BX2,Attr)Else
  If(J=Q.BY1)Then InvGatAttr(L,PC,NewPChr,Q.BX1,N,Attr)
             Else InvGatAttr(L,PC,NewPChr,0,N,Attr);
  RL:=StrLen(NewPChr)+1;
  PC:=ALSet(Q.List,J,RL);
  If(PC=NIL)Then Begin
   WEDone(W);
   __OutOfMemory;
   Exit;
  End;
  Q.CurrPtr:=ALPushCurrPtr(Q.List);
  MoveLeft(NewPChr^,PC^,RL);
  FreeMemory(NewPChr,L+N+1)
 End;
 WEDone(W);
 PutMemory;
 TESetPtr(Q);
 _TESetModified(Q)
End;

Procedure TEInsStrBlk;
Var
 J:RBP;
 PC,NewPChr:
 PChr;
 L,I,N,RL:Word;
 W:Window;
Begin
 WEPushEndBar(W);
 WEPutLastBar('Un instant S.V.P., insertion de la chaŒne en cours...');
 For J:=Q.BY1 to(Q.BY2)do Begin
  PC:=_ALGetBuf(Q.List,J);
  L:=StrLen(PC);
  N:=Length(S)+2;
  NewPChr:=MemAlloc(L+N+1);
  If(NewPChr=NIL)Then Begin
   WEDone(W);
   __OutOfMemory;
   Exit;
  End;
  StrPCopy(NewPChr,S);
  StrCat(NewPChr,PC);
  RL:=StrLen(NewPChr)+1;
  PC:=ALSet(Q.List,J,RL);
  If(PC=NIL)Then Begin
   WEDone(W);
   __OutOfMemory;
   Exit;
  End;
  Q.CurrPtr:=ALPushCurrPtr(Q.List);
  MoveLeft(NewPChr^,PC^,RL);
  FreeMemory(NewPChr,L+N+1)
 End;
 WEDone(W);
 PutMemory;
 TESetPtr(Q);
 _TESetModified(Q);
 TERefresh(Q)
End;

Function TEGetFileTxtLn(Var Q:EditorApp):PChr;Near;Begin
 SetFilePos(Q.Handle,Q.TmpBufferP);
 Inc(Q.TmpBufferP,_GetFilePTxtLn(Q.Handle,Q.TmpBuffer,Q.SizeTmpBuffer)+2);
 TEGetFileTxtLn:=Q.TmpBuffer;
End;

Procedure QPutFileTxt(Handle:Hdl;Const S:String);Begin
 If(Handle=hdlClipBoard)Then PutClipBoardTxt(S)
                        Else PutFileTxt(Handle,S)
End;

Procedure _QSetRec(Handle:Hdl;Size:Wd;Var X);Begin
 If(Handle=hdlClipBoard)Then _SetRecClipBoard(Size,X)
                        Else _SetRec(Handle,Size,X);
End;

Procedure QPutFileLn(Handle:Hdl);Begin
 If(Handle=hdlClipBoard)Then PutClipBoardTxt(CRLF)Else PutFileLn(Handle);
End;

Procedure QPutFileTxtLn(Handle:Hdl;Const S:String);Begin
 If(Handle=hdlClipBoard)Then PutClipBoardTxt(S)
                        Else PutFileTxt(Handle,S);
 QPutFileLn(Handle);
End;

Procedure _TEWriteBlk;
Var
 Path:String;
 Chr:Char;
 Handle:Hdl;
 J,PXG,PXG2:Wd;
 PC:PChr;
 L:Window;

 Procedure ClearEndOfClipBoard;
 Var Buffer:Array[0..2047]of Byte; { Tampon temporaire }
 Begin
  FillClr(Buffer,SizeOf(Buffer));
  Repeat
   _SetRecClipboard(SizeOf(Buffer),Buffer);
  Until ClipPos>=SizeOfClipboard;
 End;

Begin
 If(Q.BY1>Q.BY2)Then Exit;
 If(Q.BY1=Q.BY2)and(Q.BX1>=Q.BX2)Then Exit;
 If Not(ClipBoard)Then Begin
  If(Q.Mode=vtGat)Then Path:=SetPath4AddFile(StrPas(PathGat))+'*.GAT'
                  Else Path:='';
  Path:=OpenWin(Path,'Sauvegarde le bloque sous');
 End;
 If(Path<>'')or(ClipBoard)Then Begin
  WEPushEndBar(L);
  If(ClipBoard)Then Begin
   WEPutLastBar('Sauvegarde dans le presse-papier en cours...');
   MakeClipBoard(Q.FileSize);
   Handle:=hdlClipBoard;
  End
   Else
  Begin
   WEPutLastBar('Sauvegarde du bloque en cours...');
   Handle:=FileCreate(Path);
  End;
  If(Handle=errHdl)Then ErrNoMsgOk(CannotCreateFile)
   Else
  Begin
   If(Path2Ext(Path)='.GAT')or((ClipBoard)and(Q.Mode=vtGat))Then Begin
    QPutFileTxt(Handle,':'+BasicStr(Q.SheetFormat.X1)+
                           BasicStr(Q.SheetFormat.Y1)+
                           BasicStr(Q.SheetFormat.X2)+
                           BasicStr(Q.SheetFormat.Y2)+' ');
    Case(Q.PageNumIn)of
     ptLeft:Chr:='L';
     ptRight:Chr:='R';
     ptAltern:Chr:='A';
     Else Chr:='N';
    End;
    QPutFileTxt(Handle,Chr);
    QPutFileTxt(Handle,BasicStr(Long(Q.PageNumStart)));
    QPutFileLn(Handle);
   End;
   ALSetPtr(Q.List,Q.BY1);
   For J:=Q.BY1 to(Q.BY2)do Begin
    PC:=_ALGetCurrBuf(Q.List);
    If(Q.BY1=J)Then Begin
     If(Q.Mode=vtGat)Then Begin
      QPutFileTxt(Handle,Spc(Q.SheetFormat.X1));
      PXG:=PosX2Gat1(PC,Q.BX1);
     End
      Else
     PXG:=Q.BX1;
     If Not IsPChrEmpty(PC)Then Begin
      If(Q.BY1=Q.BY2)Then Begin
       If(Q.Mode=vtGat)Then PXG2:=PosX2Gat1(PC,Q.BX2)Else PXG2:=Q.BX2;
       _QSetRec(Handle,PXG2-PXG-1,PC^[PXG]);
      End
       Else
      _QSetRec(Handle,StrLen(PC)-PXG,PC^[PXG]);
     End;
    End
     Else
    If(Q.BY2=J)Then Begin
     PXG:=StrLen(PC);
     If(Q.Mode=vtGat)Then PXG2:=PosX2Gat1(PC,Q.BX2)
                     Else PXG2:=Q.BX2;
     If(PXG2>PXG)Then PXG2:=PXG;
     _QSetRec(Handle,PXG2,PC^);
    End
     Else
    _QSetRec(Handle,StrLen(PC),PC^);
    QPutFileLn(Handle);
    ALNext(Q.List);
   End;
   If(Handle<>hdlClipBoard)Then FileClose(Handle)
                           Else ClearEndOfClipBoard;
  End;
  WaitMsg;
  WEDone(L);
 End;
End;

Procedure TEWriteBlk;Begin
 _TEWriteBlk(Q,False)
End;

Procedure TECpyClipBoard;Begin
 _TEWriteBlk(Q,True)
End;

Procedure _TEWriteBlkHTML;
Label PS,InRemShort,InRemLong;
Var
 IsHandle:Boolean;
 Path,UStr,Str:String;
 Chr:Char;
 Handle:Hdl;
 I,J,PXG,PXG2:Word;
 PC:PChr;
 L:Window;
 Font:DataSetInMemory;    { Pour la conversion de la police de caractŠres }
 InRem:(irNone,irShort,irLong);

 Procedure ClearEndOfClipBoard;
 Var
  Buffer:Array[0..2047]of Byte; { Tampon temporaire }
 Begin
  FillClr(Buffer,SizeOf(Buffer));
  Repeat
   _SetRecClipboard(SizeOf(Buffer),Buffer);
  Until ClipPos>=SizeOfClipboard;
 End;

 Procedure __Put;Begin
  If DBLocateAbsIM(Font,0,PC^[I],[])Then Begin
   Inc(PtrRec(Font.CurrRec).Ofs);
   QPutFileTxt(Handle,Font.CurrRec.Str^);
  End
   Else
  Case PC^[I]of
   ' ':QPutFileTxt(Handle,'&nbsp;');
   Else QPutFileTxt(Handle,PC^[I]);
  End;
  Inc(I);
 End;

 Procedure __PutText(Const S:String);
 Var
  I:Byte;
 Begin
  For I:=1to Length(S)do Begin
   If DBLocateAbsIM(Font,0,S[I],[])Then Begin
    Inc(PtrRec(Font.CurrRec).Ofs);
    QPutFileTxt(Handle,Font.CurrRec.Str^);
   End
    Else
   Case S[I]of
    ' ':QPutFileTxt(Handle,'&nbsp;');
    Else QPutFileTxt(Handle,S[I]);
   End;
  End;
 End;

 Procedure SetKrRem;Begin
  QPutFileTxt(Handle,'<FONT color=#ffff00>');
 End;

 Procedure SetKrDef;Begin
  QPutFileTxt(Handle,'<FONT color=#66ff99>');
 End;

 Procedure SetKrChar;Begin
  QPutFileTxt(Handle,'<FONT color=#ff0000>');
 End;

 Procedure SetKrNumber;Begin
  QPutFileTxt(Handle,'<FONT color=#6600ff>');
 End;

 Procedure SetKrResWd;Begin
  QPutFileTxt(Handle,'<FONT color=#ffffff>');
 End;

 Procedure SetKrItem;Begin
  QPutFileTxt(Handle,'<FONT color=#B000FC>');
 End;

 Procedure PutSymbol;Begin
  QPutFileTxt(Handle,'<FONT color=#66ffff>');
  __Put;
  SetKrDef;
 End;

 Procedure PutZ;Begin
  QPutFileTxt(Handle,'<FONT color=#66ffff>');
  QPutFileTxt(Handle,'E');
  Inc(I);
  SetKrDef;
 End;

 Procedure PutAsmCString;
 Label
  Break;
 Begin
  J:=I;
  SetKrChar;
  __Put;
  While PC^[I]<>'"'do Begin
   If PC^[I]=#0Then Goto Break;
   __Put;
  End;
Break:
  If PC^[I]<>#0Then __Put;
  SetKrDef;
 End;

 Procedure PutCChar;Begin
  J:=I;
  SetKrChar;
  __Put;
  While PC^[I]<>''''do Begin
   If PC^[I]=#0Then Break;
   If(PC^[I]='\')and(PC^[I+1]='''')Then Begin
    __Put;
    __Put;
   End
   Else __Put;
  End;
  If PC^[I]<>#0Then __Put;
  SetKrDef;
 End;

 Procedure ResWd;
 Label
  NotMainWord;
 Begin
  If(Q.Mode=vtPas)and((Q.ModeSub=0)or(Q.ModeSub and pmPascalB57>0))Then Begin
   If Not(PC^[I]in['A'..'Z','a'..'z','_',#128..#255])Then Exit;
   Str:=PC^[I];UStr:=Str;
   Inc(I);
   While PC^[I]<>#0do Begin
    If(PC^[I]in['A'..'Z','a'..'z','0'..'9','_',#128..#255])Then Begin
     IncStr(Str,PC^[I]);
     Case PC^[I]of
      '‡','€':IncStr(UStr,'C');
      '‚','':IncStr(UStr,'E');
      Else IncStr(UStr,ChrUp(PC^[I]));
     End;
     Inc(I);
     If I=255Then Break;
    End
     Else
    Break;
   End;
  End
   Else
  Begin
   Str:=PXtrkWord(I,PC);
   UStr:=StrUp(Str);
  End;
  If DBLocateAbsIM(Q.DBMainWord,2,UStr,[])Then Begin
   If Q.ModeSub>0Then Begin
    If Q.DBMainWord.CurrRec.Word^ and Q.ModeSub=0Then Goto NotMainWord;
   End;
   SetKrResWd;
  End
   Else
  Begin
   NotMainWord:SetKrItem;
  End;
  __PutText(Str);
  SetKrDef;
 End;

 Procedure PutPascalString;
 Label
  Break;
 Begin
  J:=I;
  SetKrChar;
  __Put;
  While PC^[I]<>''''do Begin
   If PC^[I]=''''Then Begin
    QPutFileTxt(Handle,'''');
    Inc(I)
   End;
   If PC^[I]=#0Then Goto Break;
   __Put;
  End;
Break:
  If PC^[I]<>#0Then __Put;
  SetKrDef;
 End;

Begin
 InRem:=irNone;
 IsHandle:=False;
 If(Q.BY1>Q.BY2)Then Exit;
 If(Q.BY1=Q.BY2)and(Q.BX1>=Q.BX2)Then Exit;
 If Not(ClipBoard)Then Begin
  If(Q.Handle<>errHdl)and(Q.Handle<>0)Then Begin
   IsHandle:=True;
   Path:=Path2NoExt(Q.EditName)+'.HTM';
  End
   Else
  Begin
   If(Q.Mode=vtGat)Then Path:=SetPath4AddFile(StrPas(PathGat))+'*.GAT'Else Path:='';
   Path:=OpenWin(Path,'Sauvegarde le bloque sous');
  End;
 End;
 DBOpenServerName(ChantalServer,'CHANTAL:/Texte/Format/ASCII2HTML.Dat');
 If Not DBCopyToMemory(ChantalServer,Font)Then Begin
  __OutOfMemory;
  Exit;
 End;
 If(Path<>'')or(ClipBoard)Then Begin
  WEPushEndBar(L);
  If(ClipBoard)Then Begin
   WEPutLastBar('Sauvegarde dans le presse-papier en cours...');
   MakeClipBoard(Q.FileSize);
   Handle:=hdlClipBoard;
  End
   Else
  Begin
   WEPutLastBar('Sauvegarde du bloque en cours...');
   Handle:=FileCreate(Path);
  End;
  If(Handle=errHdl)Then ErrNoMsgOk(CannotCreateFile)
   Else
  Begin
   QPutFileTxtLn(Handle,'<HTML>');
   QPutFileTxtLn(Handle,'<BODY TEXT="#ffffff" BGCOLOR="#000000" LINK="#0000ee" VLINK="#551a8b" ALINK="#ff0000">');
   If Not(IsHandle)Then ALSetPtr(Q.List,Q.BY1);
   Case(Q.Mode)of
    vtAsm:Begin
     For J:=Q.BY1 to(Q.BY2)do Begin
      If(IsHandle)Then PC:=TEGetFileTxtLn(Q)
                  Else PC:=_ALGetCurrBuf(Q.List);
      I:=0;
      While PC^[I]<>#0do Begin
       Case PC^[I]of
        ';':Begin
         SetKrRem;
         While PC^[I]<>#0do __Put;
         SetKrDef;
        End;
        '@',':',',','.','(',')','[',']','=','$','+','-','#','!','?','&','*','%','/':PutSymbol;
        '"':PutAsmCString;
        '0'..'9':Begin
         SetKrNumber;
         __Put;
         While(PC^[I]in ArabicXDigit)do __Put;
         If PC^[I]in['B','b','O','o','H','h']Then __Put;
         SetKrDef;
        End;
        '''':PutCChar;
        'A'..'Z','a'..'z','_':Begin
         Str:=PXtrkWord(I,PC);
         UStr:=StrUp(Str);
         If DBLocateAbsIM(Q.DBFunc,2,UStr,[])Then QPutFileTxt(Handle,'<FONT color=#669900>')Else
         If DBLocateAbsIM(Q.DBMainWord,2,UStr,[])Then SetKrResWd Else
         If DBLocateAbsIM(Q.DBInstr,2,UStr,[])Then QPutFileTxt(Handle,'<FONT color=#66ff99>')
                                              Else SetKrDef;
         QPutFileTxt(Handle,Str);
         SetKrDef;
        End;
        Else __Put;
       End;
      End;
      QPutFileTxtLn(Handle,'<BR>');
      If(IsHandle)Then Begin
       If(Q.TmpBufferP>=Q.FileSize)Then Break;
      End
       Else
      ALNext(Q.List);
     End;
    End;
    vtPas:Begin
     For J:=Q.BY1 to(Q.BY2)do Begin
      If(IsHandle)Then PC:=TEGetFileTxtLn(Q)
                  Else PC:=_ALGetCurrBuf(Q.List);
      I:=0;
      If PC^[I]<>#0Then Case(InRem)of
       irShort:Goto InRemShort;
       irLong:Goto InRemLong;
      End;
      While PC^[I]<>#0do Begin
       Case PC^[I]of
        '{':Begin
         SetKrRem;
InRemShort:
         While Not(PC^[I]in[#0,'}'])do __Put;
         If PC^[I]='}'Then Begin
          __Put;
          SetKrDef;
          InRem:=irNone;
         End
          Else
         InRem:=irShort;
        End;
        '(':Begin
         If PC^[I+1]='*'Then Begin
          SetKrRem;
          Inc(I,2);
          QPutFileTxt(Handle,'(*');
          InRem:=irLong;
InRemLong:While PC^[I]<>#0do Begin
	   If(PC^[I]='*')and(PC^[I+1]=')')Then Begin
	    Inc(I,2);
	    QPutFileTxt(Handle,'*)');
            InRem:=irNone;
	    Break;
	   End;
	   __Put;
          End;
         End
          Else
         PutSymbol;
        End;
        '[',']','\','/','-','<','>','*','+','^','&',')','.',',','?','=','%','@',':',';':
        PutSymbol;
        '#':Begin
         SetKrChar;
         __Put;
         Case PC^[I]of
          '$': Goto PS;
          Else While(PC^[I]in ArabicDigit)do __Put;
         End;
         SetKrDef;
        End;
        '$':Begin
         SetKrNumber;
      PS:__Put;
         While(PC^[I]in ArabicXDigit)do __Put;
         SetKrDef;
        End;
        '0'..'9':Begin
         SetKrNumber;
         __Put;
         SetKrDef;
        End;
        '''':PutPascalString;
        'A'..'Z','a'..'z','_':ResWd;
        ^Z:PutZ;
        Else __Put;
       End;
      End;
      PutFileTxtLn(Handle,'<BR>');
      If(IsHandle)Then Begin
       If(Q.TmpBufferP>=Q.FileSize)Then Break;
      End
       Else
      ALNext(Q.List);
     End;
    End;
   End;
   QPutFileTxtLn(Handle,'</HTML>');
   If(Handle<>hdlClipBoard)Then FileClose(Handle)
                           Else ClearEndOfClipBoard;
  End;
  WaitMsg;
  WEDone(L);
 End;
 DBDispose(Font);
End;

Procedure TEWriteBlkHTML;Begin
 _TEWriteBlkHTML(Q,False)
End;

Procedure TECpyHTMLClipBoard;Begin
 _TEWriteBlkHTML(Q,True)
End;

{ Convertie un code source en format typer de format HTML }

Function PascalToHTML(Const Source,Dest:String):Boolean;
Var
 Q:EditorApp;
 Buffer:Array[0..4095]of Char;
Begin
 PascalToHTML:=False;
 TELoad2Save(Q,Source);
 If(Q.Handle<>errHdl)Then Begin
  TEInitLang(Q);
  Q.TmpBuffer:=@Buffer;
  Q.SizeTmpBuffer:=SizeOf(Buffer);
  TEWriteBlkHTML(Q);
  FileClose(Q.Handle);
  TEDone(Q);
  PascalToHTML:=True;
 End
  Else
 ErrNoMsgOk(errFileNotFound);
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
END.