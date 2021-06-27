Unit ExplorDB;

INTERFACE

Uses Isatex;

Function  EDBNew(Var Context;X1,Y1,X2,Y2:Byte):Boolean;
Procedure EDBRefresh(Var Context);
Function  EDBRun(Var Context):Word;
Function  EDBTitle(Var Context;Max:Byte):String;
Procedure EDBMove2(Var Context;X,Y:Byte);
Procedure EDBReSize(Var Context;X1,Y1,X2,Y2:Byte);
Function  EDBDone(Var Context):Word;

IMPLEMENTATION

Uses Mouse,Adele,Memories,Systex,Systems,Dials,Dialex,DialTree,
     Restex,ResServD,ResLoadD,AppDB;

Function EDBOnEnter(Var QX;Var Context):Boolean;
Var
 Q:ExplorerDataBaseApp Absolute Context;
 P:PDialogTreeElement;
 Path,Table:String;
Begin
 Path:=DTGetLongDir(Q.Tree,Q.Tree.P);
 Table:=Copy(Path,18,255);
 ChgChr(Table,'\','/');
 If(Table[Length(Table)]='/')Then BackStr(Table);
 P:=DTGetDir(Q.Tree,Path);
 If(P<>Nil)and(P^.ReturnCode=$F025)Then Begin
  ADBDone(Q.SpreadSheet);
  If Pos('AIDE',Table)>0Then Path:=MaltePath+'DATA\AIDE.DAT'
                        Else Path:=MaltePath+'DATA\CHANTAL.DAT';
  ADBOpen(Q.SpreadSheet,Q.W.T.X1+Q.MinX+1,Q.W.T.Y1+Q.MinY+1,
                        Q.W.T.X2-2,Q.W.T.Y1+Q.W.MaxY,
                        Path+'|'+Table);
 End;
 EDBOnEnter:=False;
End;

Function EDBLoadDataBaseObject(Var Q:ExplorerDataBaseApp):Boolean;
Var
 First:Boolean;
 Header:DataBaseServerHeader;
 Buffer:Pointer;
 Size:Word;
 DataPtr:Pointer;
 PString:^String Absolute DataPtr;
 S:String;
Begin
_GetAbsRec(Q.DataBase.Handle,0,SizeOf(Header),Header);
 Q.DataBase.StartPos:=Header.PosFAT;
  DBLoad(Q.DataBase);
 If Size=0Then Size:=4096;
 Buffer:=MemAlloc(Size);
 If(Buffer<>NIL)Then Begin
  Q.DataBase.CurrPos:=0;
  DBFirst(Q.DataBase);
  First:=True;
  While Not DBEOF(Q.DataBase)do Begin
   DBReadRec(Q.DataBase,Buffer^);
   Pointer(DataPtr):=Buffer;
   DBGotoColumn(Q.DataBase,'NomServeur',DataPtr);
   S:=PString^;
   ChgChr(S,'/','\');
   If(First)Then Begin
    _DTMkDir(Q.Tree,'Bases de donn‚es\'+Left(S,Pos(':',S)),$F004);
    First:=False;
   End;
   _DTMkDir(Q.Tree,'Bases de donn‚es\'+S,$F025);
  End;
  FreeMemory(Buffer,Size);
 End;
End;

Function EDBLoadDataBaseServer(Var Q:ExplorerDataBaseApp;Const Name:String):Boolean;Begin
 If FileExist(Name)Then Begin
  DBInit(Q.DataBase,Name);
  EDBLoadDataBaseObject(Q);
  DBDone(Q.DataBase);
 End;
End;

Function EDBNew(Var Context;X1,Y1,X2,Y2:Byte):Boolean;
Var
 Q:ExplorerDataBaseApp Absolute Context;
Begin
 EDBNew:=False;
 FillClr(Q,SizeOf(Q));
 WEInit(Q.W,X1,Y1,X2,Y2);
 Q.MinY:=1;
 Q.MinX:=20+((Q.W.MaxX+1-22)and$F);
 DTInit(Q.Tree,X1+2,Y1+2,X1+Q.MinX-1,Y1+Q.W.MaxY);
 _DTMkDir(Q.Tree,'Bases de donn‚es\',$F024);
 Q.Tree.OnEnter:=EDBOnEnter;
 Q.Tree.Context:=@Context;
 EDBLoadDataBaseServer(Q,MaltePath+'DATA\AIDE.DAT');
 Q.DataBase:=ChantalServer;
 EDBLoadDataBaseObject(Q);
 EDBRefresh(Q);
 EDBNew:=True;
End;

Procedure EDBRefresh(Var Context);
Var
 Q:ExplorerDataBaseApp Absolute Context;
Begin
 WEPutWnKrDials(Q.W,EDBTitle(Q,Q.W.MaxX));
 WEBar(Q.W);
 WECloseIcon(Q.W);
 WEZoomIcon(Q.W);
 DTRefresh(Q.Tree);
 If Q.SpreadSheet.W.T.X2<>0Then ADBRefresh(Q.SpreadSheet);
End;

Function EDBRun(Var Context):Word;
Label
 Restart,Recheck;
Var
 Q:ExplorerDataBaseApp Absolute Context;
 K:Word;
Begin
Restart:
 K:=DTRun(Q.Tree);
Recheck:
 If(K=kbMouse)Then Begin
  If WEInCloseIcon(Q.W,LastMouseX,LastMouseY)Then K:=kbClose Else
  If WEInCloseIcon(Q.SpreadSheet.W,LastMouseX,LastMouseY)Then Begin
   WaitMouseBut0;
   ADBDone(Q.SpreadSheet);
   EDBRefresh(Q);
   Goto Restart;
  End
   Else
  If WEOnWindow(Q.SpreadSheet.W,LastMouseX,LastMouseY)Then Begin
   K:=ADBRun(Q.SpreadSheet);
   Goto Recheck;
  End;
  If WEInWindow(Q.Tree.W,LastMouseX,LastMouseY)Then Goto Restart;
 End;
 EDBRun:=K;
End;

Function EDBTitle(Var Context;Max:Byte):String;Begin
 EDBTitle:=MessageByLanguage('Explorateur de Bases de donn‚es³DBExplorer');
End;

Procedure EDBMove2(Var Context;X,Y:Byte);
Var
 Q:ExplorerDataBaseApp Absolute Context;
Begin
 EDBReSize(Q,X,Y,X+Q.W.T.X2-Q.W.T.X1,Y+Q.W.T.Y2-Q.W.T.Y1);
End;

Procedure EDBReSize(Var Context;X1,Y1,X2,Y2:Byte);
Var
 Q:ExplorerDataBaseApp Absolute Context;
Begin
 WEInit(Q.W,X1,Y1,X2,Y2);
 Q.MinY:=1;
 Q.MinX:=20+((Q.W.MaxX+1-22)and$F);
 DTResize(Q.Tree,X1+2,Y1+2,X1+Q.MinX-1,Y1+Q.W.MaxY);
 ADBResize(Q.SpreadSheet,Q.W.T.X1+Q.MinX+1,Q.W.T.Y1+Q.MinY+1,
                         Q.W.T.X2-2,Q.W.T.Y1+Q.W.MaxY);
End;

Function EDBDone(Var Context):Word;
Var
 Q:ExplorerDataBaseApp Absolute Context;
Begin
 ADBDone(Q.SpreadSheet);
 DTDone(Q.Tree);
 EDBDone:=0;
End;

END.