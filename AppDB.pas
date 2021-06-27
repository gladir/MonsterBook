Unit AppDB;

INTERFACE

{$I DEF.INC}

Uses Isatex;

Function  ADBNew(Var Context;X1,Y1,X2,Y2:Byte):Boolean;
Procedure ADBOpen(Var Context;X1,Y1,X2,Y2:Byte;Const Path:String);
Procedure ADBRefresh(Var Context);
Function  ADBRun(Var Context):Word;
Function  ADBTitle(Var Context;Max:Byte):String;
Procedure ADBMove2(Var Context;X,Y:Byte);
Procedure ADBReSize(Var Context;X1,Y1,X2,Y2:Byte);
Function  ADBDone(Var Context):Word;
Procedure PrnDBase(Const Path:String);

IMPLEMENTATION

Uses
 Adele,Systex,Memories,Systems,Math,Pritex,Video,Mouse,Dialex,Dials,
 DialPlus,Restex,ResLoadD,ResServD,ResSaveD,ToolDB,Numerix;

{
 Mode  Description
 ----- -----------------------------------------
  0    Navigation sous forme de grille
  20   Edition de la base de donn‚es
  21   Navigation dans le r‚pertoire des tables
}


{ Cette fonction retourne la longueur stricte d'une chaŒne de caractŠres,
 c'est-…-dire ni une longueur ni une longueur inf‚rieur … celle sp‚cifier
 et donc toujours ‚gale … celle d‚finit par le paramŠtre d'appel ®Len¯.
}

Function StrictLenStr(Const Str:String;Len:Byte):String;
Var
 S:String;
Begin
 S:=Left(StrUSpc(Str,Len),Len);
 StrictLenStr:=S;
End;

Function DBTypeDef(Const Q:FieldDataBaseRec):String;
Var
 S:String;
Begin
 Case(Q.TypeDef)of
  tdNone:DBTypeDef:='Aucun';
  tdBlob:DBTypeDef:='BLOB';
  tdChar:Begin
   S:='CaractŠres';
   If Q.Len>0Then AddStr(S,'('+WordToStr(Q.Len)+')');
   DBTypeDef:=S;
  End;
  tdDate:DBTypeDef:='Date';
  tdDecimal:DBTypeDef:='D‚cimal';
  tdDouble:DBTypeDef:='R‚el double de 1,7x10ñ308';
  tdFloat:DBTypeDef:='R‚el';
  tdInteger:DBTypeDef:='Entier long';
  tdNumeric:DBTypeDef:='Num‚rique';
  tdSmallInt:DBTypeDef:='Entier';
  tdVarChar:DBTypeDef:='ChaŒne de caractŠres variable';
  tdWord:DBTypeDef:='Mot';
  tdByte:DBTypeDef:='Octet';
  tdBoolean:DBTypeDef:='Bool‚en';
  tdDirectChar:Begin
   S:='ChaŒne de caractŠres directe';
   If Q.Len>0Then AddStr(S,'('+WordToStr(Q.Len)+')');
   DBTypeDef:=S;
  End;
  tdVarCharRS:DBTypeDef:='ChaŒne de caractŠres variable RS';
  Else DBTypeDef:='Inconnu';
 End;
End;

Function DBAttribut(Const Q:FieldDataBaseRec):String;
Var
 S:String;
Begin
 S:='';
 If(Q.PrimaryKey)Then S:='Cl‚ primaire';
 If(Q.Unique)Then Begin
  If S<>''Then AddStr(S,', ');
  AddStr(S,'Unique');
 End;
 If(Q.NotNull)Then Begin
  If S<>''Then AddStr(S,', ');
  AddStr(S,'Non-nulle');
 End;
 DBAttribut:=S;
End;

Function ADBMoveTo(Var Q:DataBaseApp;P:LongInt):Boolean;Begin
 If Q.Mode=21Then Begin
  If(P>=Q.NumRec)Then Begin
   Q.DataBase.CurrPos:=Q.DataBase.EndPos;
   ADBMoveTo:=False;
  End
   Else
  Begin
   Q.DataBase.CurrPos:=Q.IndexPos^[P]+Q.DataBase.StartPos;
   ADBMoveTo:=True;
  End;
 End
  Else
 ADBMoveTo:=DBMoveTo(Q.DataBase,P);
End;

Procedure ADBFreeField(Var Q:DataBaseApp);
Var
 I:Integer;
 PField:^FieldDataBaseRec;
Begin
 ALSetPtr(Q.ListField,0);
 For I:=0to Q.ListField.Count-1do Begin
  PField:=_ALGetCurrBuf(Q.ListField);
  If(PField=NIL)Then Break;
  StrDispose(PField^.Title);
  ALNext(Q.ListField);
 End;
 ALDone(Q.ListField);
End;

Procedure ADBReloadCurrField(Var Q:DataBaseApp);
Var
 PField:^FieldDataBaseRec;
Begin
 PField:=_ALGetBuf(Q.ListField,Q.P);
 If(PField<>NIL)Then Begin
  MoveLeft(PField^,Q.CurrField,SizeOf(FieldDataBaseRec));
 End
  Else
 FillClr(Q.CurrField,SizeOf(FieldDataBaseRec));
End;

{ Calcul la largeur des colonnes th‚oriques }

Procedure ADBComputeColumn(Var Q:DataBaseApp);
Var
 I:Integer;
 NL,L:Word;
Begin
 FreeMemory(Q.Column,Q.SizeColumn);
 Q.SizeColumn:=Q.DataBase.FieldRec.Num;
 Q.Column:=MemNew(Q.SizeColumn);
 If(Q.Column<>NIL)Then Begin
  For I:=0to Q.DataBase.FieldRec.Num-1do Begin
   NL:=Length(StrPas(Q.DataBase.FieldRec.Buffer^[I].Title))+1;
   Case(Q.DataBase.FieldRec.Buffer^[I].TypeDef)of
    tdVarCharRS:L:=25;
    tdVarChar:If I=Q.DataBase.FieldRec.Num-1Then L:=Q.W.MaxX
                                            Else L:=25;
    tdInteger:If I=Q.DataBase.FieldRec.Num-1Then L:=Q.W.MaxX
                                            Else L:=6;
    tdFloat:L:=10;
    tdWord,tdSmallInt:L:=6;
    tdByte:L:=4;
    Else L:=Q.DataBase.FieldRec.Buffer^[I].Len;
   End;
   If(L>NL)Then NL:=L;
   Q.Column^[I]:=NL;
  End;
 End;
End;

Procedure ADBCopyField2DataBase(Var Q:DataBaseApp);
Var
 I:Integer;                { Compteur de boucle }
 PField:^FieldDataBaseRec; { Pointeur sur un champs }
Begin
 Q.DataBase.FieldRec.Buffer:=MemAlloc(SizeOf(FieldDataBaseRec)*Q.ListField.Count);
 If(Q.DataBase.FieldRec.Buffer<>NIL)Then Begin
  Q.DataBase.FieldRec.Num:=Q.ListField.Count;
  ALSetPtr(Q.ListField,0);
  For I:=0to Q.ListField.Count-1do Begin
   PField:=_ALGetCurrBuf(Q.ListField);
   If(PField=NIL)Then Break;
   Q.DataBase.FieldRec.Buffer^[I]:=PField^;
   ALNext(Q.ListField);
  End;
  ALDone(Q.ListField);
  ADBComputeColumn(Q);
  Q.XP:=0;Q.Y:=1;Q.P:=0;Q.YP:=0;
 End;
End;

Procedure ADBCopyDataBase2Field(Var Q:DataBaseApp);
Var
 I:Integer;                { Compteur de boucle }
Begin
 For I:=0to Q.DataBase.FieldRec.Num-1do Begin
  If Not ALAddBlock(Q.ListField,SizeOf(FieldDataBaseRec),Q.DataBase.FieldRec.Buffer^[I])Then Break;
 End;
 FreeMemory(Q.DataBase.FieldRec.Buffer,Q.DataBase.FieldRec.Num*SizeOf(FieldDataBaseRec));
 Q.DataBase.FieldRec.Buffer:=NIL;
 Q.DataBase.FieldRec.Num:=0;
 Q.XP:=0;Q.Y:=1;Q.P:=0;Q.YP:=0;
 FreeMemory(Q.Column,Q.SizeColumn);
 Q.SizeColumn:=0;
 Q.Column:=NIL;
 ADBReloadCurrField(Q);
End;

Procedure ADBOpenDataBase(Var Q:DataBaseApp;Const Path:String);
Begin
 FillClr(Q,SizeOf(Q));
 DBInit(Q.DataBase,Path);
 Q.ExternDataBaseName:=DBGetExternFileNameDataBase(Q.DataBase);
 Q.ExternDataBaseOffset.Long:=Q.DataBase.StartRec;
 Q.NumRec:=DBNumRec(Q.DataBase);
 ADBComputeColumn(Q);
End;

Procedure ADBLoadServerDirectory(Var Q:DataBaseApp);
Var
 Header:DataBaseServerHeader;
 I:Integer;
Begin
 If(dsServer)in(Q.DataBase.Option)Then Begin
  Q.Mode:=21;
  _GetAbsRec(Q.DataBase.Handle,0,SizeOf(Header),Header);
  Q.DataBase.StartPos:=Header.PosFAT;
  DBLoad(Q.DataBase);
  ADBComputeColumn(Q);
  Q.NumRec:=-1;Q.DataBase.CurrPos:=0;
  DBFirst(Q.DataBase);
  While Not DBEOF(Q.DataBase)do Begin
   If Not DBNext(Q.DataBase)Then Break;
   Inc(Q.NumRec);
  End;
  Q.IndexPos:=MemAlloc(Q.NumRec shl 1);
  If(Q.IndexPos<>NIL)Then Begin
   DBFirst(Q.DataBase);
   For I:=0to Q.NumRec-1do Begin
    Q.IndexPos^[I]:=Q.DataBase.CurrPos-Q.DataBase.StartPos;
    If Not DBNext(Q.DataBase)Then Break;
   End;
  End
   Else
  __OutOfMemory;
 End;
End;

Procedure ADBOpen(Var Context;X1,Y1,X2,Y2:Byte;Const Path:String);
Var
 Q:DataBaseApp Absolute Context;
 P:Byte;
 FileName,Table:String;
Begin
 Table:='';
 FileName:=Path;
 P:=Pos('|',Path);
 If P>0Then Begin
  FileName:=Left(Path,P-1);
  Table:=Copy(Path,P+1,255);
 End;
 ADBOpenDataBase(Q,FileName);
 WEInit(Q.W,X1,Y1,X2,Y2);
 Q.Y:=1;
 Q.ReadOnly:=True;
 If Table<>''Then Begin
  DBOpenServerName(Q.DataBase,Table);
  FreeMemory(Q.IndexPos,Q.NumRec shl 1);
  Q.NumRec:=DBNumRec(Q.DataBase);
  Q.IndexPos:=NIL;
  Q.Mode:=0;Q.P:=0;Q.Y:=1;Q.XP:=0;Q.YP:=0;
  DBMoveTo(Q.DataBase,0);
  ADBComputeColumn(Q);
 End
  Else
 ADBLoadServerDirectory(Q);
 ADBRefresh(Q);
End;

Function ADBNew(Var Context;X1,Y1,X2,Y2:Byte):Boolean;
Var
 Q:DataBaseApp Absolute Context;
Begin
 FillClr(Q,SizeOf(Q));
 Q.DataBase.Handle:=errHdl;
 Q.Y:=1;
 Q.Mode:=20;
 WEInit(Q.W,X1,Y1,X2,Y2);
 ADBRefresh(Q);
 ADBNew:=True;
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
 ResultValue:String;
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
  tdVarCharRS:Begin
   ResultValue:=LoadStr(DataPtr^,255);
   DBGetString:=Left(ResultValue,Pos(#$1E,ResultValue)-1);
  End;
  Else DBGetString:=LoadStr(DataPtr^,Len);
 End;
End;

Function ADBGetFieldValue(Var Q:DataBaseApp;Const FieldName:String):String;
Var
 Buffer:Pointer;
 Size:Word;
 DataPtr:Pointer;
Begin
 Size:=Q.DataBase.SizeRec;
 If Size=0Then Size:=4096;
 Buffer:=MemAlloc(Size);
 If(Buffer<>NIL)Then Begin
  ADBMoveTo(Q,Q.P);
  DBReadRec(Q.DataBase,Buffer^);
  Pointer(DataPtr):=Buffer;
  DBGotoColumn(Q.DataBase,FieldName,DataPtr);
  ADBGetFieldValue:=DBGetString(tdVarChar,0,DataPtr);
  FreeMemory(Buffer,Size);
 End
  Else
 ADBGetFieldValue:='';
End;

Function ADBGetString(Var Q:DataBaseApp):String;
Var
 Buffer:Pointer;
 Size:Word;
 DataPtr:Pointer;
Begin
 Size:=Q.DataBase.SizeRec;
 If Size=0Then Size:=4096;
 Buffer:=MemAlloc(Size);
 If(Buffer<>NIL)Then Begin
  ADBMoveTo(Q,Q.P);
  DBReadRec(Q.DataBase,Buffer^);
  Pointer(DataPtr):=Buffer;
  DBGotoColumnAbs(Q.DataBase,Q.XP,DataPtr);
  ADBGetString:=DBGetString(Q.DataBase.FieldRec.Buffer^[Q.XP].TypeDef,
                            Q.DataBase.FieldRec.Buffer^[Q.XP].Len,DataPtr);
  FreeMemory(Buffer,Size);
 End
  Else
 ADBGetString:='';
End;

Procedure _ADBPutLine(Var Q:DataBaseApp;Buffer:Pointer);
Var
 I:Integer;
 DataPtr:Pointer;
 XP:Word;
 GX,GY,Width:Word;
 Empty:Boolean;
Begin
 Empty:=DBEOF(Q.DataBase);
 If Not(Empty)Then DBReadRec(Q.DataBase,Buffer^);
 If Not(Q.Mode in[0,21])Then Begin
  Q.W.Y:=0;
  XP:=Q.XP-Q.YP;
 End
  Else
 XP:=Q.XP;
 If(Cadril)and(IsGrf)Then Begin
  GY:=GetRawY(Q.W.Y+1)-1;
 End;
 If Not(Empty)Then For I:=XP to Q.DataBase.FieldRec.Num-1do Begin
  Pointer(DataPtr):=Buffer;
  DBGotoColumnAbs(Q.DataBase,I,DataPtr);
  If Not(Q.Mode in[0,21])Then Begin
   WESetKr(Q.W,CurrKrs.Dialog.Env.List.Border);
   Q.W.X:=12;
  End;
  GX:=Q.W.X;
  WEPutTxt(Q.W,StrictLenStr(DBGetString(Q.DataBase.FieldRec.Buffer^[I].TypeDef,
               Q.DataBase.FieldRec.Buffer^[I].Len,DataPtr),Q.Column^[I]));
  If Not(Q.Mode in[0,21])Then Begin
   WEClrEol(Q.W);
   WELn(Q.W);
  End
   Else
  If(Cadril)and(IsGrf)Then Begin
   If(GX<Q.W.MaxX)and(Q.W.Y<=Q.W.MaxY)Then Begin
    GX:=GX shl 3;
    Width:=Q.Column^[I];
    If(Width>Q.W.MaxX)Then Width:=Q.W.MaxX;
    WEPutLine(Q.W,GX,GY-HeightChr,GX,GY,LightGray);
   End;
  End;
  If(Q.W.Y>Q.W.MaxY)Then Break;
 End;
 If Q.Mode in[0,21]Then Begin
  WEClrEol(Q.W);
  WELn(Q.W);
  If(Cadril)and(IsGrf)Then Begin
   WEClrLnHor(Q.W,0,GY,(Q.W.MaxX+1)shl 3,LightGray);
  End;
 End;
End;

Procedure ADBPutLine(Var Q:DataBaseApp;P:LongInt);
Var
 Buffer:Pointer;
 Size:Word;
 PField:^FieldDataBaseRec;
 GX1,GY,GX2:Word;
Begin
 If Q.Mode=20Then Begin
  PField:=_ALGetBuf(Q.ListField,P);
  Q.W.X:=0;
  If(PField<>NIL)Then Begin
   WEPutTxt(Q.W,StrPas(PField^.Title));
   Q.W.X:=20;
   WEPutTxt(Q.W,DBTypeDef(PField^));
   Q.W.X:=55;
   WEPutTxt(Q.W,DBAttribut(PField^));
  End;
  WEClrEol(Q.W);
  If(Cadril)and(IsGrf)Then Begin
   GY:=GetRawY(Q.W.Y+1)-1;
   WEClrLnHor(Q.W,0,GY,(Q.W.MaxX+1)shl 3,LightGray);
   GX1:=(20 shl 3)-1;
   GX2:=(55 shl 3)-1;
   WEPutLine(Q.W,GX1,GY-HeightChr,GX1,GY,LightGray);
   WEPutLine(Q.W,GX2,GY-HeightChr,GX2,GY,LightGray);
  End;
  WELn(Q.W);
 End
  Else
 Begin
  Size:=Q.DataBase.SizeRec;
  If Size=0Then Size:=4096;
  Buffer:=MemAlloc(Size);
  If(Buffer<>NIL)Then Begin
   If ADBMoveTo(Q,Q.P)Then _ADBPutLine(Q,Buffer);
   FreeMemory(Buffer,Size);
  End;
 End;
End;

Procedure ADBSelHor(Var Q:DataBaseApp);
Var
 X:Byte; { Position X }
 L:Byte; { Longueur du champs }
 GX1,GY,GX2:Word;
Begin
 Case(Q.Mode)of
  0,21:Begin
   If(Q.ReadOnly)Then L:=wnMax
                 Else L:=Q.Column^[Q.XP]-1;
   WEBarSelHor(Q.W,0,Q.Y,L);
  End;
  20:Begin
   Case(Q.XP)of
    0:Begin
     X:=0;
     L:=19;
    End;
    1:Begin
     X:=20;
     L:=54;
    End;
    Else Begin
     X:=55;
     L:=wnMax;
    End;
   End;
   WEBarSelHor(Q.W,X,Q.Y,L);
   If(Cadril)and(IsGrf)Then Begin
    GX1:=X shl 3;
    GY:=GetRawY(Q.Y+1)-1;
    GX2:=Pred(Succ(L)shl 3);
    WEPutLnHor(Q.W,GX1,GY,GX2,LightGray);
    If(L<Q.W.MaxX)Then Begin
     WEPutLine(Q.W,GX2,GY-HeightChr,GX2,GY,LightGray);
    End;
   End;
  End;
  Else WEBarSelHor(Q.W,12,Q.YP,wnMax);
 End;
End;

Procedure ADBSelBar(Var Q:DataBaseApp);Begin
 WESetKrSel(Q.W);
 ADBSelHor(Q);
 If(Q.Mode=20)and(Q.XP=1)Then PutDownIcon(WEGetRX1(Q.W)+53,WEGetRY1(Q.W)+Q.Y,$0F);
 WESelRightBarPos(Q.W,Q.P,Q.NumRec-1);
End;

Procedure ADBUnSelBar(Var Q:DataBaseApp);
Var
 X,Y:Byte;
 I:Integer;
 GX,GY,Width:Word;
Begin
 WESetKr(Q.W,CurrKrs.Dialog.Env.List.Border);
 X:=WEGetRX1(Q.W)+53;
 Y:=WEGetRY1(Q.W)+Q.Y;
 If(Q.Mode=20)and(Q.XP=1)Then BarChrHor(X,Y,X+1,' ');
 ADBSelHor(Q);
 If(Cadril)and(IsGrf)and(Q.Mode in[0,21])Then Begin
  If(Q.Y<=Q.W.MaxY)Then Begin
   GY:=GetRawY(Q.Y+1)-1;Q.W.X:=0;
   For I:=Q.XP to Q.DataBase.FieldRec.Num-1do Begin
    Inc(Q.W.X,Q.Column^[I]);
    If(Q.W.X>=Q.W.MaxX)Then Break;
    GX:=Q.W.X shl 3;
    WEPutLine(Q.W,GX,GY-HeightChr,GX,GY,LightGray);
   End;
   WEClrLnHor(Q.W,0,GY,(Q.W.MaxX+1)shl 3,LightGray);
  End;
 End;
End;

Procedure ADBRefreshField(Var Q:DataBaseApp);
Var
 I:Integer;
 X1,X2:Byte;
Begin
 WESetPos(Q.W,0,0);
 If(Q.Mode)in[0,21]Then WESetKr(Q.W,CurrKrs.Desktop.DialStatus)
                   Else WESetKrBorder(Q.W);
 For I:=Q.XP-Q.YP to Q.DataBase.FieldRec.Num-1do Begin
  X1:=Q.W.X;X2:=Q.Column^[I];
  WEPutTxt(Q.W,StrictLenStr(StrPas(Q.DataBase.FieldRec.Buffer^[I].Title),X2));
  If Not(Q.Mode in[0,21])Then Begin
   WEClrEol(Q.W);
   WELn(Q.W);
  End
   Else
  WEBarSpcHorRelief(Q.W,X1,Q.W.Y,X1+X2-1);
  If(Q.W.Y>Q.W.MaxY)Then Break;
 End;
End;

Procedure ADBRefreshFieldNTable(Var Q:DataBaseApp);
Var
 P:Word;
 I:Integer;
 J:Byte;
 Grf:Byte;
 SizeBuffer:Word;
 Buffer:^TChar;
 DataPtr:Pointer;
 PField:^FieldDataBaseRec;
Begin
 WESetPos(Q.W,0,0);
 If Q.Mode=20Then Begin
  WESetKr(Q.W,CurrKrs.Desktop.DialStatus);
  WEClrEol(Q.W);
  WEBarSpcHorRelief(Q.W,0,0,19);
  WEBarSpcHorRelief(Q.W,20,0,54);
  WEBarSpcHorRelief(Q.W,55,0,wnMax);
  Grf:=Byte(IsGrf);
  WEPutSmlTxtXY(Q.W,Grf,0,'Nom du champs');
  WEPutSmlTxtXY(Q.W,20+Grf,0,'Format');
  WEPutSmlTxtXY(Q.W,55+Grf,0,'Attribut');
  WELn(Q.W);
  WESetKr(Q.W,CurrKrs.Dialog.Env.List.Border);
  WEClrWn(Q.W,0,1,wnMax,wnMax,Q.W.CurrColor);
  P:=Q.P;
  For I:=0to Q.ListField.Count-1do Begin
   ADBPutLine(Q,P);
   Inc(P);
  End;
 End
  Else
 Begin
  SizeBuffer:=Q.DataBase.SizeRec;
  If SizeBuffer=0Then SizeBuffer:=4096;
  Buffer:=MemAlloc(SizeBuffer);
  If(Buffer<>NIL)Then Begin
   P:=Q.P-(Q.Y-1);
   ADBRefreshField(Q);
   ADBMoveTo(Q,P);
   If(Q.Mode)in[0,21]Then Begin
    WEClrEol(Q.W);
    WELn(Q.W);
    WESetKr(Q.W,CurrKrs.Dialog.Env.List.Border);
    For J:=1to(Q.W.MaxY)do Begin
     _ADBPutLine(Q,Buffer);
     If Q.Mode<>21Then Inc(P);
     If DBEOF(Q.DataBase)Then Begin
      Q.NumRec:=P;
      WEClrWnBorder(Q.W,0,Q.W.Y,wnMax,wnMax);
      Break;
     End
      Else
     If Q.Mode=21Then Inc(P);
    End;
   End
    Else
   Begin
    WEClrWnBorder(Q.W,0,Q.W.Y,wnMax,wnMax);
    _ADBPutLine(Q,Buffer);
   End;
   FreeMemory(Buffer,SizeBuffer);
  End;
  WESetPos(Q.W,0,Q.Y);
 End;
End;

Procedure ADBPutRecord(Var Q:DataBaseApp);Begin
 If Q.Mode<>20Then Begin
  WESetEndBarTxtX(Q.W,16,StrUSpc(IntToStr(Succ(Q.P)),10),CurrKrs.Desktop.DialStatus);
 End;
End;

Function ADBTitle(Var Context;Max:Byte):String;
Var
 Q:DataBaseApp Absolute Context;
Begin
 If Q.DataBase.RealName<>''Then ADBTitle:='Table: '+Q.DataBase.RealName Else
 If Q.DataBase.FileName<>''Then ADBTitle:='Table: '+TruncName(Q.DataBase.FileName,Max-7)
                           Else ADBTitle:='Base de donn‚es';
End;

Procedure ADBSetRecord(Var Q:DataBaseApp);Begin
 If Q.Mode<>20Then Begin
  WESetEndBarTxtX(Q.W,1,'Enregistrement',CurrKrs.Desktop.DialStatus);
  ADBPutRecord(Q);
 End
  Else
 WESetEndBarTxtX(Q.W,1,Spc(28),CurrKrs.Desktop.DialStatus);
End;

Procedure ADBPutOrigin(Var Q:DataBaseApp);
Var
 S:String;
Begin
 Case(Q.DataBase.Origin)of
  0:If(dsServer)in(Q.DataBase.Option)Then S:='Serveur Mentronix'
                                     Else S:='Mentronix';
  3:S:='DBase III+';
  Else S:='Base de donn‚es non d‚fini';
 End;
 WESetEndBarTxtX(Q.W,46,S,CurrKrs.Desktop.DialStatus);
End;

Procedure ADBPutModifiable(Var Q:DataBaseApp);
Var
 S:String;
Begin
 If Not(Q.ReadOnly)Then S:='Modifiable'
                   Else S:='';
 WESetEndBarTxtX(Q.W,32,StrUSpc(S,12),CurrKrs.Desktop.DialStatus);
End;

Procedure ADBRefresh(Var Context);
Var
 Q:DataBaseApp Absolute Context;
Begin
 WEPutWnKrDials(Q.W,ADBTitle(Q,Q.W.MaxX));
 WECloseIcon(Q.W);
 WEZoomIcon(Q.W);
 WEPutBarMsRight(Q.W);
 ADBRefreshFieldNTable(Q);
 ADBSelBar(Q);
 WESetEndBar(Q.W,CurrKrs.Desktop.DialStatus);
 If(IsGrf)Then Begin
  BarSpcHorRelief(Q.W.T.X1,Q.W.T.Y2,Q.W.T.X1+29,CurrKrs.Desktop.DialStatus);
  BarSpcHorReliefExt(Q.W.T.X1+1,Q.W.T.Y2,Q.W.T.X1+28,CurrKrs.Desktop.DialStatus);
  BarSpcHorRelief(Q.W.T.X1+30,Q.W.T.Y2,Q.W.T.X1+44,CurrKrs.Desktop.DialStatus);
  BarSpcHorReliefExt(Q.W.T.X1+31,Q.W.T.Y2,Q.W.T.X1+43,CurrKrs.Desktop.DialStatus);
  BarSpcHorRelief(Q.W.T.X1+30,Q.W.T.Y2,Q.W.T.X2,CurrKrs.Desktop.DialStatus);
  BarSpcHorReliefExt(Q.W.T.X1+45,Q.W.T.Y2,Q.W.T.X2-2,CurrKrs.Desktop.DialStatus);
  LuxeBox(Q.W.T.X2-1,Q.W.T.Y2);
 End
  Else
 Begin
  WESetEndBarTxtX(Q.W,30,'³',CurrKrs.Desktop.DialStatus);
  WESetEndBarTxtX(Q.W,45,'³',CurrKrs.Desktop.DialStatus);
 End;
 ADBSetRecord(Q);
 ADBPutOrigin(Q);
 ADBPutModifiable(Q);
End;

Procedure ADBUp(Var Q:DataBaseApp);
Label
 PutStat;
Var
 PField:^FieldDataBaseRec;
Begin
 If Q.Mode=20Then Begin
  If Q.P>0Then Begin
   If(Q.P=Q.ListField.Count)and(Not IsPChrEmpty(Q.CurrField.Title))Then Begin
    PField:=ALSet(Q.ListField,Q.P,SizeOf(FieldDataBaseRec));
    If(PField<>NIL)Then Begin
     MoveLeft(Q.CurrField,PField^,SizeOf(FieldDataBaseRec));
    End;
   End;
   FillClr(Q.CurrField,SizeOf(FieldDataBaseRec));
   ADBUnSelBar(Q);
   Dec(Q.P);
   If Q.Y>1Then Dec(Q.Y)
    Else
   Begin
    WESetPos(Q.W,0,1);
    WEScrollUp(Q.W,0,1,wnMax,wnMax);
    ADBPutLine(Q,Q.P);
   End;
   ADBSelBar(Q);
   ADBReloadCurrField(Q);
  End;
 End
  Else
 If(Q.Mode>0)and(Q.Mode<21)Then Begin
  If Q.XP>0Then Begin
   ADBUnSelBar(Q);
   Dec(Q.XP);
   If Q.YP>0Then Dec(Q.YP)
    Else
   Begin
    ADBRefreshField(Q);
    ADBPutLine(Q,Q.P);
   End;
   ADBSelBar(Q);
  End;
 End
  Else
 If Q.P>0Then Begin
  ADBUnSelBar(Q);
  Dec(Q.P);
  If Q.Y>1Then Dec(Q.Y)
   Else
  Begin
   WESetPos(Q.W,0,1);
   WEScrollUp(Q.W,0,1,wnMax,wnMax);
   ADBPutLine(Q,Q.P);
  End;
  If(NxtKey<>kbUp)Then Begin
PutStat:
   ADBSelBar(Q);
   ADBPutRecord(Q);
  End
   Else
  If Q.P=0Then Goto PutStat;
 End;
End;

Procedure ADBPgUp(Var Q:DataBaseApp);Begin
 If Not(Q.Mode in[0,21])Then Begin
  If Q.P>0Then Begin
   ADBUnSelBar(Q);
   Dec(Q.P);
   ADBPutLine(Q,Q.P);
   ADBSelBar(Q);
   ADBPutRecord(Q);
  End;
 End
  Else
 Begin
  Dec(Q.P,Q.W.MaxY-1);
  If Q.P<0Then Begin
   Q.P:=0;
   Q.Y:=1;
  End;
  If Q.Y>Q.P+1Then Q.Y:=Q.P+1;
  ADBRefreshFieldNTable(Q);
  ADBSelBar(Q);
  ADBPutRecord(Q);
 End;
End;

Procedure ADBPgDn(Var Q:DataBaseApp);Begin
 If Not(Q.Mode in[0,21])Then Begin
  If Q.P<Q.NumRec-1Then Begin
   ADBUnSelBar(Q);
   Inc(Q.P);
   ADBPutLine(Q,Q.P);
   If Q.NumRec=65535Then Begin
    If DBEOF(Q.DataBase)Then Q.NumRec:=Q.P+1;
   End;
   ADBSelBar(Q);
   ADBPutRecord(Q);
  End;
 End
  Else
 Begin
  If Q.P+Q.W.MaxY-1<Q.NumRec-1Then Begin
   Inc(Q.P,Q.W.MaxY-2);
  End
   Else
  Begin
   Q.P:=Q.NumRec-1;
   Q.Y:=Q.P+1;
   If(Q.Y>Q.W.MaxY)Then Q.Y:=Q.W.MaxY;
  End;
  ADBRefreshFieldNTable(Q);
  ADBSelBar(Q);
  ADBPutRecord(Q);
 End;
End;

Procedure ADBDn(Var Q:DataBaseApp);
Label
 PutStat;
Var
 PField:^FieldDataBaseRec;
Begin
 If Q.Mode=20Then Begin
  If(Q.P-1<=Q.ListField.Count)and(Not IsPChrEmpty(Q.CurrField.Title))Then Begin
   PField:=ALSet(Q.ListField,Q.P,SizeOf(FieldDataBaseRec));
   If(PField<>NIL)Then Begin
    MoveLeft(Q.CurrField,PField^,SizeOf(FieldDataBaseRec));
    FillClr(Q.CurrField,SizeOf(FieldDataBaseRec));
   End;
   ADBUnSelBar(Q);
   Inc(Q.P);
   If(Q.Y<Q.W.MaxY)Then Inc(Q.Y)
    Else
   Begin
    WEScrollDn(Q.W,0,1,wnMax,wnMax);
    Q.W.Y:=Q.W.MaxY;
    Q.W.X:=0;
    ADBPutLine(Q,Q.P);
   End;
   ADBSelBar(Q);
   ADBReloadCurrField(Q);
  End;
 End
  Else
 If(Q.Mode>0)and(Q.Mode<21)Then Begin
  If Q.XP<Q.DataBase.FieldRec.Num-1Then Begin
   ADBUnSelBar(Q);
   Inc(Q.XP);
   If(Q.YP<Q.W.MaxY)Then Inc(Q.YP)
    Else
   Begin
    ADBRefreshField(Q);
    ADBPutLine(Q,Q.P);
   End;
   ADBSelBar(Q);
  End;
 End
  Else
 If Q.P<Q.NumRec-1Then Begin
  ADBUnSelBar(Q);
  Inc(Q.P);
  If(Q.Y<Q.W.MaxY)Then Inc(Q.Y)
   Else
  Begin
   WEScrollDn(Q.W,0,1,wnMax,wnMax);
   Q.W.Y:=Q.W.MaxY;
   Q.W.X:=0;
   ADBPutLine(Q,Q.P);
   If Q.NumRec=65535Then Begin
    If DBEOF(Q.DataBase)Then Q.NumRec:=Q.P+1;
   End;
  End;
  If(NxtKey<>kbDn)Then Begin
PutStat:
   ADBSelBar(Q);
   ADBPutRecord(Q);
  End
   Else
  If Q.P=Q.NumRec-1Then Goto PutStat;
 End
End;

Procedure ADBLeft(Var Q:DataBaseApp);Begin
 If Q.Mode=20Then Begin
  ADBUnselBar(Q);
  Q.XP:=MinByte(Q.XP,2);
  ADBSelBar(Q);
 End
  Else
 If Q.XP>0Then Begin
  Dec(Q.XP);
  ADBRefreshFieldNTable(Q);
  ADBSelBar(Q);
 End;
End;

Procedure ADBRight(Var Q:DataBaseApp);Begin
 If Q.Mode=20Then Begin
  ADBUnselBar(Q);
  Q.XP:=MaxByte(Q.XP,2);
  ADBSelBar(Q);
 End
  Else
 If Q.XP<Q.DataBase.FieldRec.Num-1Then Begin
  Inc(Q.XP);
  ADBRefreshFieldNTable(Q);
  ADBSelBar(Q);
 End;
End;

Procedure ADBPrintWorksheet(Var Q:DataBaseApp);
Var
 I:LongInt;
 J:Integer;
 SizeBuffer:Word;
 Buffer:Pointer;
 DataPtr:Pointer;
Begin
 SizeBuffer:=Q.DataBase.SizeRec;
 If SizeBuffer=0Then SizeBuffer:=4096;
 Buffer:=MemAlloc(SizeBuffer);
 If(Buffer<>NIL)Then Begin
  For J:=1to Q.DataBase.FieldRec.Num-1do Begin
   Prn(StrUSpc(StrPas(Q.DataBase.FieldRec.Buffer^[J].Title),Q.Column^[J]));
  End;
  PrnLn;
  For J:=1to Q.DataBase.FieldRec.Num-1do Begin
   Prn(MultChr('Í',Q.Column^[J]-1)+' ');
  End;
  PrnLn;
  DBFirst(Q.DataBase);
  For I:=0to Q.NumRec-1do Begin
   DBReadRec(Q.DataBase,Buffer^);
   For J:=1to Q.DataBase.FieldRec.Num-1do Begin
    Prn(StrUSpc(StrPas(Q.DataBase.FieldRec.Buffer^[J].Title),Q.Column^[J]));
    Pointer(DataPtr):=Buffer;
    DBGotoColumnAbs(Q.DataBase,I,DataPtr);
    Prn(DBGetString(Q.DataBase.FieldRec.Buffer^[I].TypeDef,
                    Q.DataBase.FieldRec.Buffer^[I].Len,DataPtr));
   End;
   PrnLn;
   If DBEOF(Q.DataBase)Then Begin
    If Q.NumRec=65535Then Q.NumRec:=Q.P+1;
    Break;
   End;
  End;
 End;
End;

Procedure ADBPrintColumn(Var Q:DataBaseApp;Formulaire:Boolean);
Var
 I:LongInt;
 J:Integer;
 SizeBuffer:Word;
 Buffer:Pointer;
 DataPtr:Pointer;
Begin
 SizeBuffer:=Q.DataBase.SizeRec;
 If SizeBuffer=0Then SizeBuffer:=4096;
 Buffer:=MemAlloc(SizeBuffer);
 If(Buffer<>NIL)Then Begin
  DBFirst(Q.DataBase);
  For I:=0to Q.NumRec-1do Begin
   DBReadRec(Q.DataBase,Buffer^);
   Prn('Enregistrement:'+CStrBasic(I));
   PrnLn;
   PrnLn;
   If Not(Formulaire)Then Begin
    Prn('Nom champ  Description');
    PrnLn;
    Prn(MultChr('Í',10)+' '+MultChr('Í',55));
    PrnLn;
   End;
   For J:=1to Q.DataBase.FieldRec.Num-1do Begin
    Prn(StrUSpc(StrPas(Q.DataBase.FieldRec.Buffer^[J].Title),11));
    If(Formulaire)Then PrnLn;
    Pointer(DataPtr):=Buffer;
    DBGotoColumnAbs(Q.DataBase,J,DataPtr);
    Prn(DBGetString(Q.DataBase.FieldRec.Buffer^[I].TypeDef,
                    Q.DataBase.FieldRec.Buffer^[I].Len,DataPtr));
    PrnLn;
   End;
   Prn(MultChr('Ä',66));
   PrnLn;
   If DBEOF(Q.DataBase)Then Begin
    If Q.NumRec=65535Then Q.NumRec:=Q.P+1;
    Break;
   End;
  End;
 End;
End;

Procedure PrnDBase(Const Path:String);
Var
 Q:DataBaseApp;
Begin
 ADBOpenDataBase(Q,Path);
 ADBPrintColumn(Q,False);
 ADBDone(Q);
End;

Procedure ADBFilter(Var Q:DataBaseApp;Mode:Byte);
Var
 Font:DataSetInMemory;
 I:LongInt;
 J:Integer;
 K:Integer;
 SizeBuffer:Word;
 Buffer:Pointer;
 DataPtr:Pointer;
 PString:^String Absolute DataPtr;
Begin
 If(WarningMsgYesNo('Cette op‚ration modifiera physiquement '+
                    'sur le disque les informations. D‚sirez-vous continuer?')=kbYes)Then Begin
  Case(Mode)of
   6:DBOpenServerName(ChantalServer,'CHANTAL:/Country/Ansi2ASCII.Dat');
   7:DBOpenServerName(ChantalServer,'CHANTAL:/Country/ASCII2Ansi.Dat');
   Else Begin
    ErrMsgOk('Erreur de format');
    Exit;
   End;
  End;
  If Not DBCopyToMemory(ChantalServer,Font)Then Begin
   __OutOfMemory;
   Exit;
  End;
  SizeBuffer:=Q.DataBase.SizeRec;
  If SizeBuffer=0Then SizeBuffer:=4096;
  Buffer:=MemAlloc(SizeBuffer);
  If(Buffer<>NIL)Then Begin
   DBFirst(Q.DataBase);
   For I:=0to Q.NumRec-1do Begin
    ADBMoveTo(Q,I);
    DBReadRec(Q.DataBase,Buffer^);
    For J:=1to Q.DataBase.FieldRec.Num-1do Begin
     Pointer(DataPtr):=Buffer;
     DBGotoColumnAbs(Q.DataBase,J,DataPtr);
     Case(Q.DataBase.FieldRec.Buffer^[J].TypeDef)of
      tdChar,tdVarChar:For K:=1to Length(PString^)do Begin
       If DBLocateAbsIM(Font,0,PString^[K],[])Then Begin
        Inc(PtrRec(Font.CurrRec).Ofs);
        PString^[K]:=Font.CurrRec.Str^[1];
       End;
      End;
      tdDirectChar:For K:=0to Q.DataBase.FieldRec.Buffer^[J].Len-1do Begin
       If DBLocateAbsIM(Font,0,PString^[K],[])Then Begin
        Inc(PtrRec(Font.CurrRec).Ofs);
        PString^[K]:=Font.CurrRec.Str^[1];
       End;
      End;
     End;
    End;
    ADBMoveTo(Q,I);
    DBWriteRec(Q.DataBase,Buffer^);
    If DBEOF(Q.DataBase)Then Begin
     If Q.NumRec=65535Then Q.NumRec:=Q.P+1;
     Break;
    End;
   End;
   ADBRefreshFieldNTable(Q);
   ADBSelBar(Q);
  End;
  DBDispose(Font);
 End;
End;

Procedure ADBContextMenu(Var Q:DataBaseApp);
Var
 Menu:Record
  EditStruct:Boolean;
  SizeField:Boolean;
  ExternDataBase:Boolean;
  ReadOnly:^Boolean;
 End;
 S:String;
 PField:^FieldDataBaseRec;      { Pointeur sur le champs courant }
 K:Word;
 H:History;
 TP,TY:Byte;
Begin
 FillClr(H,SizeOf(H));
 Menu.EditStruct:=Q.Mode=20;
 Menu.ExternDataBase:=Q.ExternDataBaseName<>'';
 Menu.SizeField:=(Q.Mode=20)and(Q.CurrField.TypeDef in[tdChar,tdDirectChar]);
 Menu.ReadOnly:=@Q.ReadOnly;
 K:=_RunMenuApp(132,Menu);
 Case(K)of
  0..$F000:;
  $F001:Begin
   ADBUnselBar(Q);
   Q.ReadOnly:=Not Q.ReadOnly;
   ADBPutModifiable(Q);
   ADBSelBar(Q);
  End;
  $F002:ADBPrintWorksheet(Q);
  $F003:ADBPrintColumn(Q,False);
  $F004:ADBPrintColumn(Q,True);
  $F005:DBConversionToSQL(Q.DataBase,Path2NoExt(Q.DataBase.FileName)+'.SQL');
  $F008:If Q.Mode=21Then ErrMsgOk('Ce mode n''est pas support‚ dans l''index des tables.')
   Else
  Begin
   Q.Mode:=0;Q.YP:=0;
   ADBRefreshFieldNTable(Q);
   ADBSelBar(Q);
  End;
  $F009:If Q.Mode=21Then ErrMsgOk('Ce mode n''est pas support‚ dans l''index des tables.')
   Else
  Begin
   Q.Mode:=1;Q.YP:=0;
   ADBRefreshFieldNTable(Q);
   ADBSelBar(Q);
  End;
  $F010:Begin
   If(Q.DataBase.Handle=errHdl)Then Begin
    If Q.DataBase.FileName=''Then Begin
     Q.DataBase.FileName:=_OpenWinModel('','Sauvegarde sous',H,omBase);
    End;
    If Q.DataBase.FileName=''Then Exit;
    If Path2Ext(Q.DataBase.FileName)=''Then Case(Q.DataBase.Origin)of
     0:AddStr(Q.DataBase.FileName,'.DAT');
     Else AddStr(Q.DataBase.FileName,'.DBF');
    End
     Else
    If Pos('.DBF',StrUp(Q.DataBase.FileName))>0Then Q.DataBase.Origin:=3;
   End;
   ADBCopyField2DataBase(Q);
   If Q.ExternDataBaseName<>''Then Begin
    FileClose(Q.DataBase.Handle);
    DeleteFile(Q.DataBase.FileName);
    DBCreate(Q.DataBase);
    DBSetExternFileNameDataBase(Q.DataBase,Q.ExternDataBaseName);
    DBSetExternOffsetDataBase(Q.DataBase,Q.ExternDataBaseOffset.Long);
   End
    Else
   If(Q.DataBase.Handle=errHdl)Then DBCreate(Q.DataBase);
   Q.Mode:=0;
   ADBRefreshFieldNTable(Q);
   ADBSetRecord(Q);
   ADBSelBar(Q);
  End;
  $F011:Begin
   ADBCopyDataBase2Field(Q);
   Q.Mode:=20;
   Q.ReadOnly:=False;
   ADBPutModifiable(Q);
   ADBRefreshFieldNTable(Q);
   ADBSetRecord(Q);
   ADBSelBar(Q);
  End;
  $F012:Begin
   S:=IntToStr(Q.CurrField.Len);
   If(_WinInp(40,'Champs','D‚finissez la taille du champs',False,S)=kbYes)Then Begin
    Q.CurrField.Len:=StrToInt(S);
    PField:=ALSet(Q.ListField,Q.P,SizeOf(FieldDataBaseRec));
    If(PField<>NIL)Then Begin
     MoveLeft(Q.CurrField,PField^,SizeOf(FieldDataBaseRec));
    End;
   End;
  End;
  $F013:Begin
   Q.ExternDataBaseName:=OpenWin('','Donn‚es Externe');
  End;
  $F014:Q.ExternDataBaseName:='';
  $F015:Begin
   If(WinInpNmWord(40,'D‚placement','La valeur',CurrKrs.Dialog.Window,0,65535,Q.ExternDataBaseOffset.Word)=kbEnter)Then Begin
   End;
  End;
  $F016:Begin
   ALDelBuf(Q.ListField,Q.P);
   TP:=Q.P;TY:=Q.Y;
   Q.P:=0;Q.Y:=1;
   ADBRefreshFieldNTable(Q);
   Q.P:=TP;Q.Y:=TY;
   ADBSelBar(Q);
  End;
  $F017:Begin
   PField:=ALIns(Q.ListField,Q.P,SizeOf(FieldDataBaseRec));
   If(PField<>NIL)Then Begin
    FillClr(Q.CurrField,SizeOf(FieldDataBaseRec));
    Q.CurrField.Title:=Str2PChr('sansnom');
    MoveLeft(Q.CurrField,PField^,SizeOf(FieldDataBaseRec));
   End;
   TP:=Q.P;TY:=Q.Y;
   Q.P:=0;Q.Y:=1;
   ADBRefreshFieldNTable(Q);
   Q.P:=TP;Q.Y:=TY;
   ADBSelBar(Q);
  End;
  $F018:DBConversionToLotus(Q.DataBase,Path2NoExt(Q.DataBase.FileName)+'.WK1');
  $F019:DBConversionToExcel21(Q.DataBase,Path2NoExt(Q.DataBase.FileName)+'.XLS');
  $F01A:DBConversionToMGC(Q.DataBase,Path2NoExt(Q.DataBase.FileName)+'.MGC');
  kbMouse:WaitMouseBut0;
  Else ADBFilter(Q,K);
 End;
End;

Function ADBAttribut(Var Q:DataBaseApp):Boolean;
Var
 FormAttribut:Record
  PrimaryKey:Boolean;{ Cl‚ primaire?}
  Unique:Boolean;    { Unique? }
  NotNull:Boolean;   { Non-nulle? }
 End;
Begin
 ADBAttribut:=False;
 FillClr(FormAttribut,SizeOf(FormAttribut));
 FormAttribut.PrimaryKey:=Q.CurrField.PrimaryKey;
 FormAttribut.Unique:=Q.CurrField.Unique;
 FormAttribut.NotNull:=Q.CurrField.NotNull;
 If ExecuteAppDPU(136,FormAttribut)Then Begin
  Q.CurrField.PrimaryKey:=FormAttribut.PrimaryKey;
  Q.CurrField.Unique:=FormAttribut.Unique;
  Q.CurrField.NotNull:=FormAttribut.NotNull;
  ADBAttribut:=True;
 End;
End;

Procedure ADBUpdateField(Var Q:DataBaseApp);
Var
 PField:^FieldDataBaseRec;
Begin
 PField:=ALSet(Q.ListField,Q.P,SizeOf(FieldDataBaseRec));
 If(PField<>NIL)Then Begin
  MoveLeft(Q.CurrField,PField^,SizeOf(FieldDataBaseRec));
 End;
End;

Function ADBRead(Var Q:DataBaseApp):Word;
Var
 K:Word;                        { R‚ponse de l'entr‚e }
 X1,Y,X2:Byte;                  { Coordonn‚es de l'entr‚e }
 PBuffer:Array[Byte]of Char;    { Tampon de r‚ponse de l'entr‚e }
 Str:PChr;                      { Pointeur sur l'entr‚e }
 Size:Word;                     { Taille d'un enregistrement }
 Buffer:Pointer;                { Pointeur sur l'enregistrement courant }
 DataPtr:Pointer;               { Pointeur sur le champs courant de l'enregistrement courant }
 PString:^String Absolute DataPtr;
 PByte:^Byte Absolute DataPtr;
 PSmallInt:^Integer Absolute DataPtr;
 PWord:^Word Absolute DataPtr;
 PLong:^LongInt Absolute DataPtr;
 PField:^FieldDataBaseRec;      { Pointeur sur le champs courant }
 TypeDef:LstMnu;                { Type de format }
Begin
 FillClr(PBuffer,SizeOf(PBuffer));
 Str:=@PBuffer;
 If Q.Mode=20Then Begin
  StrCopy(Str,Q.CurrField.Title);
 End
  Else
 StrPascalCopy(PBuffer,SizeOf(PBuffer),ADBGetString(Q));
 WESetInpColors(Q.W,$8F,Q.W.Palette.Sel);
 X2:=Q.Column^[Q.XP]-1;
 Case(Q.Mode)of
  0,21:Begin
   X1:=0;Y:=Q.Y;
  End;
  20:Begin
   X1:=0;Y:=Q.Y;X2:=19;
  End;
  Else Begin
   X1:=12;
   Y:=Q.XP;
  End;
 End;
 If(Q.Mode=20)and(Q.XP=1)Then Begin
  X1:=WEGetRX1(Q.W);
  Y:=WEGetRY1(Q.W);
  LMInitKrDials(TypeDef,X1+20,Y+1+Q.Y,X1+60,Q.W.T.Y2-1,'Type de champs');
  ALAddStrByte(TypeDef.List,'BLOB (Graphiques, textes,...)',tdBLOB);
  ALAddStrByte(TypeDef.List,'Bool‚en (vrai ou faux)',tdBoolean);
  ALAddStrByte(TypeDef.List,'CaractŠres … longueur fixe',tdChar);
  ALAddStrByte(TypeDef.List,'CaractŠres … longueur fixe DBase',tdDirectChar);
  ALAddStrByte(TypeDef.List,'CaractŠres … longueur variable',tdVarChar);
  ALAddStrByte(TypeDef.List,'CaractŠres … longueur variable RS',tdVarCharRS);
  ALAddStrByte(TypeDef.List,'Date',tdDate);
  ALAddStrByte(TypeDef.List,'Nombre entre 0 et 255',tdByte);
  ALAddStrByte(TypeDef.List,'Nombre entre -32768 et 32767',tdSmallInt);
  ALAddStrByte(TypeDef.List,'Nombre entre 0 et 65535',tdWord);
  ALAddStrByte(TypeDef.List,'Nombre entre -2147483648 … 2147483647',tdInteger);
  ALAddStrByte(TypeDef.List,'Num‚rique',tdNumeric);
  LMGotoPos(TypeDef,Q.CurrField.TypeDef);
  If(KeyPress)Then Begin
   K:=ReadKey;
   If Lo(K)<>0Then Case ChrUp(Char(K))of
    'B':LMGotoPos(TypeDef,tdBlob);
    'C':LMGotoPos(TypeDef,tdChar);
    'D':LMGotoPos(TypeDef,tdDate);
    'I':LMGotoPos(TypeDef,tdInteger);
    'N':LMGotoPos(TypeDef,tdNumeric);
    'O':LMGotoPos(TypeDef,tdByte);
    'R':LMGotoPos(TypeDef,tdVarCharRS);
    'S':LMGotoPos(TypeDef,tdSmallInt);
    'V':LMGotoPos(TypeDef,tdVarChar);
    'W':LMGotoPos(TypeDef,tdWord);
   End;
  End;
  K:=LMRun(TypeDef);
  LMDone(TypeDef);
  Case(K)of
   0:K:=kbEsc;
   Else Begin
    Q.CurrField.TypeDef:=K;
   End;
  End;
  WEPutTxtXY(Q.W,20,Q.Y,StrUSpc(DBTypeDef(Q.CurrField),33));
  ADBUpdateField(Q);
 End
  Else
 If(Q.Mode=20)and(Q.XP=2)Then Begin
  ClrKbd;
  If ADBAttribut(Q)Then Begin
   WEPutTxtXY(Q.W,55,Q.Y,DBAttribut(Q.CurrField));
   K:=kbEnter;
  End
   Else
  K:=kbEsc;
 End
  Else
 K:=_WEInput(Q.W,X1,Y,X2,255,Str);
 Case(K)of
  kbEsc:If Q.Mode<>20Then Begin
   WEPutTxtXY(Q.W,X1,Y,Left(ADBGetString(Q),Q.Column^[Q.XP]));
  End;
  kbInWn,kbMouse:;
  kbEnter,kbUp,kbDn,kbTab:If Q.Mode=20Then Begin
   If Q.XP=0Then Begin
    StrDispose(Q.CurrField.Title);
    Q.CurrField.Title:=StrNew(Str);
   End;
   If Not IsPChrEmpty(Q.CurrField.Title)Then Begin
    PField:=ALSet(Q.ListField,Q.P,SizeOf(FieldDataBaseRec));
    If(PField<>NIL)Then Begin
     MoveLeft(Q.CurrField,PField^,SizeOf(FieldDataBaseRec));
    End;
   End;
  End
   Else
  Begin
   Size:=Q.DataBase.SizeRec;
   If Size=0Then Size:=4096;
   Buffer:=MemAlloc(Size);
   If(Buffer<>NIL)Then Begin
    ADBMoveTo(Q,Q.P);
    DBReadRec(Q.DataBase,Buffer^);
    Pointer(DataPtr):=Buffer;
    DBGotoColumnAbs(Q.DataBase,Q.XP,DataPtr);
    Case(Q.DataBase.FieldRec.Buffer^[Q.XP].TypeDef)of
     tdChar,tdVarChar:StrCopy(DataPtr,Str);
     tdByte:PByte^:=StrToWord(StrPas(Str));
     tdSmallInt,tdWord:PWord^:=StrToWord(StrPas(Str));
     tdInteger:PLong^:=StrToInt(StrPas(Str));
     Else Begin
      MoveLeft(PBuffer,DataPtr^,Q.DataBase.FieldRec.Buffer^[Q.XP].Len);
     End;
    End;
    ADBMoveTo(Q,Q.P);
    DBWriteRec(Q.DataBase,Buffer^);
    FreeMemory(Buffer,Size);
   End;
   Case(K)of
    kbShiftTab:K:=kbLeft;
    kbTab:K:=kbRight;
   End;
  End;
 End;
 ADBRead:=K;
End;

Function ADBGetXPZone(Var Q:DataBaseApp;X:Byte):Word;
Var
 I:Integer;
 XS:Word;
Begin
 Dec(X,WEGetRX1(Q.W));
 Case(Q.Mode)of
  20:Begin
   If X<20Then ADBGetXPZone:=0 Else
   If X<55Then ADBGetXPZone:=1
          Else ADBGetXPZone:=2;
  End;
  0:Begin
   ADBGetXPZone:=Q.XP;
   XS:=0;
   For I:=Q.XP to Q.DataBase.FieldRec.Num-1do Begin
    Inc(XS,Q.Column^[I]);
    If(X<XS)Then Begin
     ADBGetXPZone:=I;
     Exit;
    End;
   End;
  End;
  Else ADBGetXPZone:=0;
 End;
End;

Function ADBRun(Var Context):Word;
Label
 EnterTable;
Var
 Q:DataBaseApp Absolute Context;{ Objet courant de l'application }
 K:Word;                        { Code clavier de retour }
 Max:LongInt;                   { Position maximal }
 Y1:Byte;                       { Coordonn‚e vertical minimum }
 XP:Word;                       { Extimer du XP }
 TP:Word;                       { Position du compat }
Begin
 Repeat
  K:=WEReadk(Q.W);
  Case(K)of
   kbClose:Break;
   kbPgUp:ADBPgUp(Q);
   kbPgDn:ADBPgDn(Q);
   kbRBarMsPgDn:Begin
    DelayMousePress(100);
    ADBPgDn(Q);
   End;
   kbRBarMsPgUp:Begin
    DelayMousePress(100);
    ADBPgUp(Q);
   End;
   kbRBarMsUp:Begin
    ADBUp(Q);
    DelayMousePress(100);
   End;
   kbRBarMsDn:Begin
    ADBDn(Q);
    DelayMousePress(100);
   End;
   kbCompat:If(Q.Mode)in[0,21]Then Begin
    TP:=WEGetCompatPosition(Q.W,Q.NumRec);
    If(Q.P<>TP)Then Begin
     ADBRefreshFieldNTable(Q);
     Q.P:=TP;
     If(Q.P<Q.W.MaxY)Then Q.Y:=Q.P+1
                     Else Q.Y:=Q.W.MaxY;
     ADBSelBar(Q);
     ADBPutRecord(Q);
    End;
   End;
   kbUp:ADBUp(Q);
   kbDn:ADBDn(Q);
   kbLeft:ADBLeft(Q);
   kbRight:ADBRight(Q);
   kbCtrlIns:PushClipboardTxt(ADBGetString(Q));
   kbShiftTab:If Q.Mode=20Then Begin
    If Q.XP>0Then ADBLeft(Q)
     Else
    If Q.P>0Then Begin
     Q.XP:=0;
     ADBUp(Q);
    End;
   End;
   kbTab:If Q.Mode=20Then Begin
    If Q.XP<2Then ADBRight(Q)
     Else
    Begin
     Q.XP:=0;
     ADBDn(Q);
    End;
   End;
   kbEsc:If((dsServer)in(Q.DataBase.Option))and(Q.Mode=0)Then Begin
    Q.P:=Q.OldP;
    Q.Y:=Q.OldY;
    Q.XP:=Q.OldXP;
    Q.YP:=0;
    If(Q.P<0)or(Q.Y<1)Then Begin
     Q.P:=0;
     Q.Y:=1;
    End;
    ADBLoadServerDirectory(Q);
    ADBRefresh(Q);
   End
    Else
   Break;
   kbEnter:If Q.Mode=21Then Begin
EnterTable:
    DBOpenServerName(Q.DataBase,ADBGetFieldValue(Q,'NomServeur'));
    FreeMemory(Q.IndexPos,Q.NumRec shl 1);
    Q.NumRec:=DBNumRec(Q.DataBase);
    Q.IndexPos:=NIL;
    Q.OldY:=Q.Y;Q.OldP:=Q.P;Q.OldXP:=Q.XP;
    Q.Mode:=0;Q.P:=0;Q.Y:=1;Q.XP:=0;Q.YP:=0;
    DBMoveTo(Q.DataBase,0);
    ADBComputeColumn(Q);
    ADBRefresh(Q);
   End
    Else
   Break;
   kbInWn:If LastMouseB=2Then ADBContextMenu(Q)
    Else
   Begin
    Y1:=WEGetRY1(Q.W);
    XP:=ADBGetXPZone(Q,LastMouseX-WEGetRX1(Q.W));
    If(Q.Y<>LastMouseY-Y1)or(Q.XP<>XP)Then Begin
     __HideMousePtr;
     ADBUnSelBar(Q);
     If(Q.Mode)in[0,20,21]Then Begin
      Dec(Q.P,Q.Y);
      Q.Y:=LastMouseY-Y1;
      Inc(Q.P,Q.Y);
     End
      Else
     Begin
      Dec(Q.XP,Q.YP);
      Q.YP:=LastMouseY-Y1;
      Inc(Q.XP,Q.YP);
     End;
     If Q.Mode=20Then Max:=Q.ListField.Count
                 Else Max:=Q.NumRec;
     If(Q.Mode)in[0,20,21]Then Begin
      If(Q.P>=Max)Then Begin
       Q.P:=Max-1;
       Q.Y:=Q.P;
      End
       Else
      ADBPutRecord(Q);
     End;
     If(Q.Mode in[0,21])and(Q.XP<>XP)Then Begin
      Q.XP:=XP;
      ADBRefreshFieldNTable(Q);
     End
      Else
     If Q.Mode=20Then Q.XP:=XP;
     ADBSelBar(Q);
     __ShowMousePtr;
     WaitMouseBut0;
     If Q.Mode=20Then ADBReloadCurrField(Q);
    End
     Else
    Begin
     If Q.Mode=21Then Begin
      WaitMouseBut0;
      Goto EnterTable;
     End;
     K:=ADBRead(Q);
    End;
   End;
   Else If(Not(Q.ReadOnly))and(Chr(K)>=#32)Then Begin
    PushKey(K);
    K:=ADBRead(Q);
    Case(K)of
     kbMouse,kbTitle:Begin
      ClrKbd;
      Break;
     End;
    End;
   End
    Else
   Break;
  End;
 Until False;
 ADBRun:=K;
End;

Procedure ADBReSize;
Var
 Q:DataBaseApp Absolute Context;
Begin
 WEDone(Q.W);
 WEInit(Q.W,X1,Y1,X2,Y2);
 ADBRefresh(Q);
End;

Procedure ADBMove2{Var Q;X,Y:Byte};
Var
 Q:DataBaseApp Absolute Context;
Begin
 ADBReSize(Q,X,Y,Q.W.T.X2-Q.W.T.X1,Y+Q.W.T.Y2-Q.W.T.Y1);
End;

Function ADBDone(Var Context):Word;
Var
 Q:DataBaseApp Absolute Context;
Begin
 FreeMemory(Q.IndexPos,Q.NumRec shl 1);
 FreeMemory(Q.Column,Q.SizeColumn);
 ADBFreeField(Q);
 DBDone(Q.DataBase);
 FillClr(Q,SizeOf(Q));
 ADBDone:=0;
End;

END.