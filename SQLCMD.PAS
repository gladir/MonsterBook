Unit SQLCmd;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                               INTERFACE
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses Isatex;

Function  SQLInit(Var Context;X1,Y1,X2,Y2:Byte):Boolean;
Function  SQLTitle(Var Context;Max:Byte):String;
Procedure SQLRefresh(Var Context);
Function  SQLRun(Var Context):Word;
Procedure SQLReSize(Var Context;X1,Y1,X2,Y2:Byte);
Procedure SQLMove2(Var Context;X,Y:Byte);
Function  SQLDone(Var Context):Word;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                              IMPLEMENTATION
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses
 Systex,Memories,Systems,Mouse,Dialex,Dials,Terminal,Numerix,Adele,Video,
 Restex,ResServD,ResSaveD,Registry,DialPlus;

Const
 LimitImage=100;         { Nombre maximal de ligne m‚moriser en m‚moire }
                         { avant de les perdres d‚finitivement! }

Procedure Ln(Var Q:SQLCommandApp);Near;Begin
 WEAnsiLn(Q.W);
  {Vide la ligne image dans la liste image}
 If Q.TmpImageLst=''Then ALAddLn(Q.ImageLst)
                    Else ALAddStr(Q.ImageLst,Q.TmpImageLst);
 If(Q.ImageLst.Count>LimitImage)Then Begin
   {Effacer la premiŠre ligne de la liste, c'est n‚cessaire la}
   {plus ancienne de cette liste.}
  ALDelBuf(Q.ImageLst,0);
 End;
 Q.TmpImageLst:='';
End;

Function PutStr(Var Q:SQLCommandApp;Const Str:String):Boolean;Near;Begin
 AddStr(Q.TmpImageLst,Str);
 PutStr:=WEPutPas(Q.W,Str)
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure PutLine                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: Wins
 Portabilit‚:  Local


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet d'afficher une ligne d'affichage de format ANSI
 dans la boŒte de dialogue de fenˆtre de l'objet ®Window¯.
}

Function PutLine(Var Q:SQLCommandApp;Const Str:String):Boolean;Near;Begin
 PutLine:=PutStr(Q,Str);
 Ln(Q)
End;

Function SQLInit(Var Context;X1,Y1,X2,Y2:Byte):Boolean;
Var
 Q:SQLCommandApp Absolute Context;
Begin
 FillClr(Q,SizeOf(Q));
 Q.Mode:=$FFFF;
 WEInit(Q.W,X1,Y1,X2,Y2);
 SQLRefresh(Context);
 SQLInit:=True;
 PutLine(Q,'Base de donn‚es SQL - Mentronix');
 PutLine(Q,'Tous droits r‚serv‚s par les Chevaliers de Malte 2000-2004');
 Ln(Q);
 DBOpenServerName(ChantalServer,'CHANTAL:/Compilateur/SQL/MotsReserves.Dat');
 DBCopyToMemory(ChantalServer,Q.Instr);
 HYInitTo(Q.H,512,@Q.History.Buffer);
 If ReadMainKey(HKEY_CURRENT_USER,'Software\SQLPrompt\History','Classic',Q.History)Then Begin
  HYSetSizeBuffer(Q.H,Q.History.EndCmd);
 End;
End;

Function SQLTitle(Var Context;Max:Byte):String;Begin
 SQLTitle:='Commande SQL';
End;

Procedure SQLRefresh(Var Context);
Var
 Q:SQLCommandApp Absolute Context;
 I,Y:Byte;
 PC:PChr;
 TDataBaseName:String[8];
Begin
 WEPutWn(Q.W,SQLTitle(Context,Q.W.MaxX),CurrKrs.MalteDos.Window);
 WECloseIcon(Q.W);
 WEZoomIcon(Q.W);
 Y:=Q.W.Y;
 If Q.ImageLst.Count>0Then Begin
  WESetKr(Q.W,CurrKrs.MalteDos.Env.Default);
  If(Q.ImageLst.Count<Q.W.MaxY)Then ALSetPtr(Q.ImageLst,0)
                               Else ALSetPtr(Q.ImageLst,Q.ImageLst.Count-Q.W.MaxY);
  For I:=0to(Q.W.MaxY)do Begin
   PC:=_ALGetCurrBuf(Q.ImageLst);
   WEPutTxtXY(Q.W,0,I,StrPas(PC));
   ALNext(Q.ImageLst);
  End;
  Q.W.Y:=Y;
 End;
 WESetEndBar(Q.W,CurrKrs.Desktop.DialStatus);
 If(IsGrf)Then Begin
  BarSpcHorRelief(Q.W.T.X1,Q.W.T.Y2,Q.W.T.X1+30,CurrKrs.Desktop.DialStatus);
  BarSpcHorReliefExt(Q.W.T.X1+13,Q.W.T.Y2,Q.W.T.X1+29,CurrKrs.Desktop.DialStatus);
  BarSpcHorRelief(Q.W.T.X1+31,Q.W.T.Y2,Q.W.T.X2,CurrKrs.Desktop.DialStatus);
  LuxeBox(Q.W.T.X2-1,Q.W.T.Y2);
 End
  Else
 WESetEndBarTxtX(Q.W,30,'³',CurrKrs.Desktop.DialStatus);
 WESetEndBarTxtX(Q.W,1,'Connect‚ …',CurrKrs.Desktop.DialStatus);
 If Q.CurrDataBase=''Then TDataBaseName:='CHANTAL'
                     Else TDataBaseName:=Path2Name(Q.CurrDataBase);
 WESetEndBarTxtX(Q.W,14,TDataBaseName,CurrKrs.Desktop.DialStatus);
End;

Function XtrkName(Var Q:SQLCommandApp;Var I:Byte):String;Near;
Var
 Name:String;
Begin
 Name:=StrUp(XtrkWord(I,Q.Param));
 If Name=''Then Begin
  If Q.Param[I]='"'Then Begin
   Inc(I);
   While Not(Q.Param[I]in[#0,'"'])do Begin
    IncStr(Name,Q.Param[I]);
    Inc(I);
   End;
   If Q.Param[I]='"'Then Inc(I);
  End;
 End;
 XtrkName:=Name;
End;

Function SQLSelect(Var Q:SQLCommandApp):Boolean;
Var
 I:Byte;
 AllField:Boolean;
 Word:String;
Begin
 SQLSelect:=False;
 Q.Request:=scNone;
 I:=7;AllField:=False;
 SkipSpcInLn(I,Q.Param);
 If Q.Param[I]='*'Then Begin
  Inc(I);
  AllField:=True;
 End;
 SkipSpcInLn(I,Q.Param);
 Word:=StrUp(XtrkWord(I,Q.Param));
 If Word<>'FROM'Then Begin
  Q.Error:=errFromExpected;
  Exit;
 End;
 SkipSpcInLn(I,Q.Param);
 Q.TableName:=XtrkName(Q,I);
 If Q.TableName=''Then Begin
  Q.Error:=errTableNameExpected;
  Exit;
 End;
 Q.Request:=scSELECT;
 SQLSelect:=True;
End;

Function DBGetString(TypeDef:Byte;Len:Word;Const Buffer):String;
Var
 DataPtr:Pointer Absolute Buffer;
 PString:^String Absolute Buffer;
 PInt:^Integer Absolute Buffer;
 PLong:^LongInt Absolute Buffer;
 PByte:^Byte Absolute Buffer;
 PChar:^Char Absolute Buffer;
 PBoolean:^Boolean Absolute Buffer;
 PReal:^Real Absolute Buffer;
Begin
 Case(TypeDef)of
  tdChar:Begin
   If Len=0Then DBGetString:=PChar^
           Else DBGetString:=PString^;
  End;
  tdVarChar:DBGetString:=PString^;
  tdBoolean:Begin
   If PByte^=$FFThen DBGetString:=''Else
   If PBoolean^Then DBGetString:='Vrai'
               Else DBGetString:='Faux';
  End;
  tdByte:DBGetString:=WordToStr(PByte^);
  tdSmallInt:DBGetString:=IntToStr(PInt^);
  tdWord:DBGetString:=WordToStr(PInt^);
  tdInteger:DBGetString:=IntToStr(PLong^);
  tdFloat:DBGetString:=RealStr2(PReal^,1,4);
  Else DBGetString:=LoadStr(DataPtr^,Len);
 End;
End;

Function DBGetLength(Const Q:FieldDataBaseRec):Word;
Var
 L,TL:Word;
Begin
 Case(Q.TypeDef)of
  tdVarChar:L:=Q.Len;
  tdInteger:L:=6;
  tdFloat:L:=10;
  tdWord,tdSmallInt:L:=6;
  tdByte:L:=4;
  tdBoolean:L:=4;
  Else L:=Q.Len;
 End;
 TL:=StrLen(Q.Title);
 If(L<TL)Then L:=TL;
 DBGetLength:=L;
End;

Procedure SQLShowTable(Var Q:SQLCommandApp;Var DataBase:DataSet);
Var
 I,L:Integer;
 Buffer:Pointer;
 Size:Word;
 DataPtr:Pointer;
 NumLine:LongInt;
Begin
 For I:=0to DataBase.FieldRec.Num-1do Begin
  PutStr(Q,StrUSpc(StrPas(DataBase.FieldRec.Buffer^[I].Title),DBGetLength(DataBase.FieldRec.Buffer^[I]))+' ');
 End;
 PutLine(Q,'');
 For I:=0to DataBase.FieldRec.Num-1do Begin
  PutStr(Q,MultChr('=',DBGetLength(DataBase.FieldRec.Buffer^[I]))+' ');
 End;
 PutLine(Q,'');
 DBFirst(DataBase);
 Size:=DataBase.SizeRec;
 If Size=0Then Size:=4096;
 Buffer:=MemAlloc(Size);
 If(Buffer<>NIL)Then Begin
  NumLine:=0;
  While Not DBEOF(DataBase)do Begin
   DBReadRec(DataBase,Buffer^);
   For I:=0to DataBase.FieldRec.Num-1do Begin
    Pointer(DataPtr):=Buffer;
    DBGotoColumn(DataBase,StrPas(DataBase.FieldRec.Buffer^[I].Title),DataPtr);
    PutStr(Q,StrUSpc(DBGetString(DataBase.FieldRec.Buffer^[I].TypeDef,
                                 DataBase.FieldRec.Buffer^[I].Len,DataPtr),
                                 DBGetLength(DataBase.FieldRec.Buffer^[I]))+' ');
   End;
   PutLine(Q,'');
   Inc(NumLine);
  End;
  FreeMemory(Buffer,Size);
  If(sCount)in(Q.Option)Then PutLine(Q,CStr(NumLine)+' ligne(s) retourn‚e(s)');
 End;
End;

Procedure SQLDump(Var Q:SQLCommandApp);
Var
 DataBase:DataSet;
Begin
 Case(Q.Request)of
  scSELECT:Begin
   FillClr(DataBase,SizeOf(DataBase));
   If Q.TableName<>''Then Begin
    If(Pos('/',Q.TableName)>0)or(Pos(':',Q.TableName)>0)Then Begin
     If CmpLeft(StrUp(Q.TableName),'CHANTAL')Then Begin
      DBOpenServerName(ChantalServer,Q.TableName);
      DataBase:=ChantalServer;
     End
      Else
     DataBase:=Q.ObjDataBase;
    End
     Else
    If StrUp(Q.TableName)='ALL_OBJECTS'Then Begin
     If Q.CurrDataBase<>''Then DataBase:=Q.ObjDataBase
                          Else DataBase:=ChantalServer;
     DBLoadTableIndex(DataBase);
    End;
    SQLShowTable(Q,DataBase);
   End;
  End;
  scSHOW:Begin
   If Q.CurrDataBase<>''Then DataBase:=Q.ObjDataBase
                        Else DataBase:=ChantalServer;
   DBLoadTableIndex(DataBase);
   SQLShowTable(Q,DataBase);
  End;
 End;
End;

Function SQLShow(Var Q:SQLCommandApp):Boolean;
Var
 I:Byte;
Begin
 SQLShow:=False;
 I:=5;
 SkipSpcInLn(I,Q.Param);
 If XtrkName(Q,I)='TABLES'Then Begin
  Q.Request:=scSHOW;
  SQLShow:=True;
 End;
End;

Function SQLConnect(Var Q:SQLCommandApp):Boolean;
Var
 I:Byte;
 UserName:String;
Begin
 I:=8;SQLConnect:=False;
 SkipSpcInLn(I,Q.Param);
 Q.CurrDataBase:=XtrkName(Q,I);
 SkipSpcInLn(I,Q.Param);
 If Q.Param[I]='/'Then Begin
  Inc(I);
  SkipSpcInLn(I,Q.Param);
 End;
 UserName:=StrUp(XtrkWord(I,Q.Param));
 If Path2Ext(Q.CurrDataBase)=''Then AddStr(Q.CurrDataBase,'.DAT');
 DBInitServer(Q.ObjDataBase,Q.CurrDataBase);
 SQLConnect:=True;
End;

Function SQLSet(Var Q:SQLCommandApp):Boolean;
Var
 I:Byte;
 Word,Switch:String;
 Flags:Boolean;
Begin
 I:=4;SQLSet:=False;
 SkipSpcInLn(I,Q.Param);
 Word:=StrUp(XtrkWord(I,Q.Param));
 If Word<>''Then Begin
  SkipSpcInLn(I,Q.Param);
  Switch:=StrUp(XtrkWord(I,Q.Param));
  If Switch='ON'Then Flags:=True Else
  If Switch='OFF'Then Flags:=False
   Else
  Begin
   Q.Error:=errInvalidCommand;
   Exit;
  End;
  If Word='AUTODDL'Then Begin
   If(Flags)Then Include(Q.Option,sAutoDDL)
            Else Exclude(Q.Option,sAutoDDL);
  End
   Else
  If Word='COUNT'Then Begin
   If(Flags)Then Include(Q.Option,sCount)
            Else Exclude(Q.Option,sCount);
  End
   Else
  If Word='ECHO'Then Begin
   If(Flags)Then Include(Q.Option,sEcho)
            Else Exclude(Q.Option,sEcho);
  End
   Else
  If Word='LIST'Then Begin
   If(Flags)Then Include(Q.Option,sList)
            Else Exclude(Q.Option,sList);
  End
   Else
  If Word='PLAN'Then Begin
   If(Flags)Then Include(Q.Option,sPlan)
            Else Exclude(Q.Option,sPlan);
  End
   Else
  If Word='STATS'Then Begin
   If(Flags)Then Include(Q.Option,sStats)
            Else Exclude(Q.Option,sStats);
  End
   Else
  If Word='TIME'Then Begin
   If(Flags)Then Include(Q.Option,sTime)
            Else Exclude(Q.Option,sTime);
  End
   Else
  Begin
   Q.Error:=errInvalidCommand;
   Exit;
  End;
 End
  Else
 Begin
  Q.Error:=errInvalidCommand;
  Exit;
 End;
 SQLSet:=True;
End;

Procedure SQLOnCommand(Var ObjRaw;Var Context;Const CmdName:String);
Var
 Obj:DataSet Absolute ObjRaw;
 Q:SQLCommandApp Absolute Context;
Begin
 If DBLocateAbsIM(Q.Instr,2,CmdName,[soNoCaseSensitive])Then Begin
  If(Obj.PC<>NIL)Then Q.Param:=StrPas(Obj.PC);
  Case(Q.Instr.CurrRec.Byte^)of
   6:If SQLConnect(Q)Then Exit;
   23:If SQLSelect(Q)Then Begin
    SQLDump(Q);
    Exit;
   End;
   24:If SQLSet(Q)Then Exit;
   scSHOW:If SQLShow(Q)Then Begin
    SQLDump(Q);
    Exit;
   End;
   Else Q.Error:=errUnknownCommand;
  End;
 End;
End;

Procedure SQLExecuteCommand(Var Q:SQLCommandApp);
Var
 I:Byte;
Begin
 I:=1;
 SQLOnCommand(Q.ObjDataBase,Q,XtrkWord(I,Q.Param));
End;

Procedure SQLExecuteFile(Var Q:SQLCommandApp;Const FileName:String);
Var
 Handle:Hdl;
 Obj:DataSet;
 L:ArrayList;
 Option:OptionPromptSQL;
Begin
 Option:=Q.Option;
 Obj:=ChantalServer;
 Obj.OnExternCommand:=SQLOnCommand;
 Obj.OnExternCommandContext:=@Q;
 ALInit(L);
 Handle:=FileOpen(FileName,fmRead);
 If(Handle<>errHdl)Then Begin
  DBCreateWithSQL(Obj,L,Handle);
  FileClose(Handle);
 End;
 Q.Option:=Option;
End;

Procedure SQLPutCommand(Var Q:SQLCommandApp);Begin
 PutStr(Q,Q.Param);
 Ln(Q);
End;

Function SQLRun(Var Context):Word;
Label Restart;
Var
 Q:SQLCommandApp Absolute Context;
 Buffer:Array[0..512]of Chr; { Tampon de l'entr‚e utilisateur }
 PBuffer:PChr;               { Pointeur sur l'entr‚e utilisateur }
 K:Word;

 Function RunContextMenu:Boolean;
 Var
  K:Word;
 Begin
  RunContextMenu:=True;
  K:=RunMenuApp(161);
  Case(K)of
   $F001:Begin
    Q.Param:='SHOW TABLES;';
    SQLPutCommand(Q);
    SQLExecuteCommand(Q);
   End;
   kbMouse:Begin
    WaitMouseBut0;
    RunContextMenu:=False;
   End;
  End;
 End;

Begin
Restart:
 _WEHL(Q.W);
 PutStr(Q,'SQL>');
 WESetKr(Q.W,CurrKrs.MalteDos.Env.Default);
 Buffer[0]:=#0;PBuffer:=@Buffer;
 Repeat
  K:=WEInp(Q.W,PBuffer,SizeOf(Buffer)-1,False);
  Q.Param:=Trim(StrPas(@Buffer));
  Case(K)of
   kbPgUp,kbPgDn:StrPCopy(@Buffer,HYChoice(Q.H,WEGetRX1(Q.W)+Q.W.MaxX-2,WEGetRY1(Q.W)+1));
   kbUp:StrPCopy(@Buffer,HYPrev(Q.H));
   kbDn:StrPCopy(@Buffer,HYNext(Q.H));
   kbEnter:Begin
    HYQueue(Q.H,Q.Param);
    Q.W.X:=0;Q.TmpImageLst:='';
    PutStr(Q,'SQL>');
    WESetKrSel(Q.W);
    PutLine(Q,Q.Param);
    WESetKr(Q.W,CurrKrs.MalteDos.Env.Default);
    If StrI(1,Q.Param)='@'Then Begin { Un fichier? }
     SQLExecuteFile(Q,Copy(Q.Param,2,255));
    End
     Else
    SQLExecuteCommand(Q);
    Goto Restart;
   End;
   kbInWn:If LastMouseB=2Then Begin
    RunContextMenu;
    Goto Restart;
   End;
   Else Begin
    HYQueue(Q.H,Q.Param);
    Break;
   End;
  End;
 Until No;
 SQLRun:=K;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure SQLReSize                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: SQLCommandApp


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

   Cette proc‚dure permet de change la taille de la fenˆtre du prompt
  SQL de l'objet ®SQLCommandApp¯.
}

Procedure SQLReSize(Var Context;X1,Y1,X2,Y2:Byte);
Var
 Y:Byte;
 Q:SQLCommandApp Absolute Context;
Begin
 Y:=Q.W.Y;
 WEDone(Q.W);
 WEInit(Q.W,X1,Y1,X2,Y2);
 If Q.W.MaxY<Q.ImageLst.Count-1Then Y:=Q.W.MaxY;
 Q.W.Y:=Y;
 SQLRefresh(Q);
End;

Procedure SQLMove2(Var Context;X,Y:Byte);
Var
 Q:SQLCommandApp Absolute Context;
Begin
 SQLReSize(Q,X,Y,X+Q.W.T.X2-Q.W.T.X1,Y+Q.W.T.Y2-Q.W.T.Y1);
End;

Function SQLDone(Var Context):Word;
Var
 Q:SQLCommandApp Absolute Context;
Begin
 Q.History.Len:=514;
 Q.History.EndCmd:=HYGetSizeBuffer(Q.H);
 If Q.History.EndCmd>0Then Begin
  CreateKeyFormat(HKEY_CURRENT_USER,'Software\SQLPrompt\History','Classic',tdBlob,Q.History);
 End;
 DBDispose(Q.Instr);
 DBDone(Q.ObjDataBase);
 HYDone(Q.H);
 SQLDone:=0;
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
END.