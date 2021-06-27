{ Cette unitÇ offre divers services particulier pour les bases de donnÇes
 comme par exemple permet la conversion en langage SQL de donnÇes binaires.
}

Unit ToolDB;

{$I DEF.INC}

{ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ}
                                  INTERFACE
{ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ}

Uses ResTex;

Function  DBChoice(X1,Y1,X2,Y2:Byte;Const Title,TableName:String;Column:Byte):String;
Procedure DBLInit(Var Q:DBListBox;X1,Y1,X2,Y2:Byte;Const Title,TableName:String;Column:Byte);
Procedure DBLOpen(Var Q:DBListBox;X1,Y1,X2,Y2:Byte;Const Title,PathDB,TableName:String;Column:Byte);
Procedure DBLDn(Var Q:DBListBox);
Procedure DBLEnd(Var Q:DBListBox);
Procedure DBLHome(Var Q:DBListBox);
Procedure DBLPgUp(Var Q:DBListBox);
Procedure DBLPgDn(Var Q:DBListBox);
Procedure DBLPutLine(Var Q:DBListBox);
Function  DBLReadLine(Var Q:DBListBox;P:Word):String;
Procedure DBLSearchName(Var Q:DBListBox;Const Name:String);
Procedure DBLSelectBar(Var Q:DBListBox);
Function  DBLRun(Var Q:DBListBox):Word;
Procedure DBLShowList(Var Q:DBListBox);
Procedure DBLUnSelectBar(Var Q:DBListBox);
Procedure DBLUp(Var Q:DBListBox);
Procedure DBLDone(Var Q:DBListBox);
Procedure DBSQLToDataBase(Const SourceName,TargetName:String);
Procedure DBToExcel(Const SourceName,TargetName:String);
Procedure DBToLotus(Const SourceName,TargetName:String);
Procedure DBToSQL(Const SourceName,TargetName:String);
Procedure DBToMGC(Const SourceName,TargetName:String);
Procedure DBConversionToSQL(Var Q:DataSet;Const TargetName:String);
Procedure DBConversionToExcel21(Var Q:DataSet;Const TargetName:String);
Procedure DBConversionToLotus(Var Q:DataSet;Const TargetName:String);
Procedure DBConversionToMGC(Var Q:DataSet;Const TargetName:String);

{ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ}
                                IMPLEMENTATION
{ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ}

Uses
 Isatex,Systex,Systems,Dials,Dialex,ResServD,ResSaveD,Mouse,Math,Calcex;

Procedure OnStatusCompiler(Var Q;Var Context;Line:LongInt);Far;
Var
 W:Window Absolute Context;
Begin
 WEPutTxtXY(W,33,5,CStr(Line));
End;

Procedure PutFrameDialog(Var W:Window;Const SourceName,TargetName,Title,Status:String);Begin
  WEInitO(W,60,10);
  WEPushWn(W);
  WEPutWnKrDials(W,Title);
  WEBar(W);
  WELn(W);
  WEPutTxtLn(W,'êtat                           = '+Status);
  WEPutTxtLn(W,'Source principal               = '+Path2NoDir(SourceName));
  WEPutTxtLn(W,'Source courante                = '+Path2NoDir(SourceName));
  WEPutTxtLn(W,'Nom du programme de sortie     = '+Path2NoDir(TargetName));
  WEPutTxtLn(W,'Nombre de ligne(s) compilÇ     =');
End;

Procedure DBSQLToDataBase(Const SourceName,TargetName:String);
Var
 Handle:Hdl;
 DS:DataSet;
 W:Window;
 List:ArrayList;
Begin
 FillClr(List,SizeOf(List));
 Handle:=FileOpen(SourceName,fmRead);
 If(Handle=errHdl)Then ErrNoMsgOk(errFileNotFound)
  Else
 Begin
  DBInit(DS,TargetName);
  PutFrameDialog(W,SourceName,TargetName,'Compilation','Compilation');
  DS.OnStatusCompiler:=OnStatusCompiler;
  DS.OnStatusCompilerContext:=@W;
  If Not DBCreateWithSQL(DS,List,Handle)Then ErrNoMsgOk(SQLError);
  WEPutTxtXY(W,33,1,StrUSpc('Terminer.',32));
  While WEOk(W)do;
  WEDone(W);
  DBDone(DS);
  FileClose(Handle);
 End;
End;

Procedure DBToSQL(Const SourceName,TargetName:String);
Var
 Q:DataSet;
Begin
 DBInit(Q,SourceName);
 DBConversionToSQL(Q,TargetName);
 DBDone(Q);
End;

Procedure DBToLotus(Const SourceName,TargetName:String);
Var
 Q:DataSet;
Begin
 DBInit(Q,SourceName);
 DBConversionToLotus(Q,TargetName);
 DBDone(Q);
End;

Procedure DBToExcel(Const SourceName,TargetName:String);
Var
 Q:DataSet;
Begin
 DBInit(Q,SourceName);
 DBConversionToExcel21(Q,TargetName);
 DBDone(Q);
End;

Procedure DBToMGC(Const SourceName,TargetName:String);
Var
 Q:DataSet;
Begin
 DBInit(Q,SourceName);
 DBConversionToMGC(Q,TargetName);
 DBDone(Q);
End;

Procedure DBConversionToSQL(Var Q:DataSet;Const TargetName:String);
Var
 Handle:Hdl;
 I,J:Integer;                { Compteur de boucle }
 Num:Boolean;                { Nombre? }
 BB:^Byte;
 BC:^Char Absolute BB;
 BI:^Integer Absolute BB;
 BL:^LongInt Absolute BB;
 BO:^Boolean Absolute BB;
 BS:^String Absolute BB;
 BW:^Word Absolute BB;
 W:Window;
 Line:LongInt;
 S:String;
 Data:Array[0..4095]of Byte;
Begin
 Line:=0;
 PutFrameDialog(W,Q.FileName,TargetName,'DÇcompilation','DÇcompilation');
 Handle:=FileCreateAndBackup(TargetName);
 If(Handle<>errHdl)Then Begin
  PutFileTxtLn(Handle,'CREATE TABLE '+Q.RealName+' (');
  For I:=0to Q.FieldRec.Num-1do Begin
   PutFileTxt(Handle,'   '+StrUSpc(StrPas(Q.FieldRec.Buffer^[I].Title),20)+' ');
   Case(Q.FieldRec.Buffer^[I].TypeDef)of
    tdBlob:PutFileTxt(Handle,'BLOB');
    tdBoolean:PutFileTxt(Handle,'BOOLEAN');
    tdByte:PutFileTxt(Handle,'BYTE');
    tdChar:Begin
     PutFileTxt(Handle,'CHAR');
     If Q.FieldRec.Buffer^[I].Len<>0Then PutFileTxt(Handle,'('+WordToStr(Q.FieldRec.Buffer^[I].Len-1)+')');
    End;
    tdDirectChar:Begin
     PutFileTxt(Handle,'CHAR');
     If Q.FieldRec.Buffer^[I].Len<>0Then PutFileTxt(Handle,'('+WordToStr(Q.FieldRec.Buffer^[I].Len)+')');
    End;
    tdDate:PutFileTxt(Handle,'DATE');
    tdDecimal:PutFileTxt(Handle,'DECIMAL');
    tdDouble:PutFileTxt(Handle,'DOUBLE');
    tdFloat:PutFileTxt(Handle,'FLOAT');
    tdInteger:PutFileTxt(Handle,'INTEGER');
    tdSmallInt:PutFileTxt(Handle,'SMALLINT');
    tdVarChar:PutFileTxt(Handle,'VARCHAR');
    tdWord:PutFileTxt(Handle,'WORD');
    tdNumeric:Begin
     PutFileTxt(Handle,'NUMERIC');
     If Q.FieldRec.Buffer^[I].Len<>0Then Begin
      PutFileTxt(Handle,'('+WordToStr(Q.FieldRec.Buffer^[I].Len-1));
      If Q.FieldRec.Buffer^[I].Decimal<>0Then Begin
       PutFileTxt(Handle,','+WordToStr(Q.FieldRec.Buffer^[I].Decimal));
      End;
      PutFileTxt(Handle,')');
     End;
    End;
   End;
   If(Q.FieldRec.Buffer^[I].PrimaryKey)Then PutFileTxt(Handle,' PRIMARY KEY');
   If(Q.FieldRec.Buffer^[I].NotNull)Then PutFileTxt(Handle,' NOT NULL');
   If I<Q.FieldRec.Num-1Then PutFileTxtLn(Handle,',')
                        Else PutFileLn(Handle);
  End;
  PutFileTxtLn(Handle,');');
  PutFileLn(Handle);
  If(dsIndex)in(Q.Attribut)Then Begin
   PutFileTxtLn(Handle,'CREATE INDEX;');
   PutFileLn(Handle);
  End;
  DBFirst(Q);
  Repeat
   DBReadRec(Q,Data);
   PutFileTxt(Handle,'INSERT INTO '+Q.RealName+' VALUES (');
   For I:=0to Q.FieldRec.Num-1do Begin
    BB:=@Data;
    DBGotoColumnAbs(Q,I,Pointer(BB));
    Case(Q.FieldRec.Buffer^[I].TypeDef)of
     tdBoolean:If BO^Then PutFileTxt(Handle,'True ')
                     Else PutFileTxt(Handle,'False');
     tdByte:PutFileTxt(Handle,'0x'+HexByte2Str(BB^));
     tdChar:Begin
      If Q.FieldRec.Buffer^[I].Len=0Then PutFileTxt(Handle,''''+BC^+'''')
       Else
      Begin
       S:='';
       For J:=1to Length(BS^)do Begin
        Case BS^[J]of
         #0..' ':IncStr(S,' ');
         '''':AddStr(S,'''''');
         Else IncStr(S,BS^[J]);
        End;
       End;
       PutFileTxt(Handle,''''+S+'''');
      End;
     End;
     tdInteger:PutFileTxt(Handle,IntToStr(BL^));
     tdSmallInt:PutFileTxt(Handle,IntToStr(BI^));
     tdVarChar:PutFileTxt(Handle,''''+BS^+'''');
     tdDirectChar:Begin
      S:=LoadStr(BS^,Q.FieldRec.Buffer^[I].Len);
      ChgChr(S,#0,' ');
      PutFileTxt(Handle,''''+S+'''');
     End;
     tdNumeric:Begin
      S:=LoadStr(BS^,Q.FieldRec.Buffer^[I].Len);
      ChgChr(S,#0,' ');
      Num:=False;
      For J:=1to Length(S)do If S[J]in['0'..'9']Then Begin
       Num:=True;
       Break;
      End;
      If Not(Num)Then S[1]:='0';
      PutFileTxt(Handle,S);
     End;
     tdWord:PutFileTxt(Handle,'0x'+HexWord2Str(BW^));
    End;
    If I<Q.FieldRec.Num-1Then PutFileTxt(Handle,',');
   End;
   PutFileTxtLn(Handle,');');
   Inc(Line);
   WEPutTxtXY(W,33,5,CStr(Line));
   If Q.CurrPos<0Then Break;
  Until DBEOF(Q);
  FileClose(Handle);
 End;
 WEPutTxtXY(W,33,1,StrUSpc('Terminer.',32));
 While WEOk(W)do;
 WEDone(W);
 Q.OnStatusCompiler:=NIL;
 Q.OnStatusCompilerContext:=NIL;
End;

Procedure DBConversionToExcel21(Var Q:DataSet;Const TargetName:String);
Var
 Handle:Hdl;
 I,J:Word;
 W:Window;
 BB:^Byte;
 BC:^Char Absolute BB;
 BI:^Integer Absolute BB;
 BL:^LongInt Absolute BB;
 BO:^Boolean Absolute BB;
 BS:^String Absolute BB;
 BW:^Word Absolute BB;
 Buffer:Array[0..511]of Byte;
 SignExcel:BOFExcel Absolute Buffer;
 Label4Excel:LabelExcel Absolute Buffer;
 Number4Excel:NumberExcel Absolute Buffer;
 Integer4Excel:IntegerExcel Absolute Buffer;
 EOF4Excel:EOFExcel Absolute Buffer;
 S:String;
 Data:Array[0..4095]of Byte;
Begin
 PutFrameDialog(W,Q.FileName,TargetName,'Exportation en Excel 2.1','Conversion');
 Handle:=FileCreateAndBackup(TargetName);
 If(Handle<>errHdl)Then Begin
   { Microsoft Excel 2.1 }
  FillClr(SignExcel,SizeOf(SignExcel));
{  SignExcel.Length:=6;
  SignExcel.TypeCode:=$0009;}
  SignExcel.Length:=6;
  SignExcel.TypeCode:=$0209;
  _SetRec(Handle,SizeOf(SignExcel),SignExcel);
   {DÇfinition de la premiäre ligne}
  For I:=0to Q.FieldRec.Num-1do Begin
   S:=StrPas(Q.FieldRec.Buffer^[I].Title);
   Case(Q.FieldRec.Buffer^[I].TypeDef)of
    tdChar:If Q.FieldRec.Buffer^[I].Len=0Then
     AddStr(S,',C,1')
    Else
     AddStr(S,',C,'+IntToStr(Q.FieldRec.Buffer^[I].Len));
   End;
   FillClr(Label4Excel,SizeOf(Label4Excel));
   Label4Excel.Column:=I;
   Label4Excel.Row:=0;
   Label4Excel.TypeCode:=xltLabel;
   Label4Excel.Length:=SizeOf(Label4Excel)-4-SizeOf(String)+Length(S)+2;
   Label4Excel.Value:=''''+S;
   _SetRec(Handle,Label4Excel.Length+4,Label4Excel);
  End;
   {êcriture du corps}
  DBFirst(Q);
  I:=0;J:=1;
  Repeat
   DBReadRec(Q,Data);
   For I:=0to Q.FieldRec.Num-1do Begin
    FillClr(Label4Excel,SizeOf(Label4Excel));
    Label4Excel.Column:=I;
    Label4Excel.Row:=J;
    BB:=@Data;
    DBGotoColumnAbs(Q,I,Pointer(BB));
    Case(Q.FieldRec.Buffer^[I].TypeDef)of
     tdVarChar:Begin
      Label4Excel.TypeCode:=xltLabel;
      Label4Excel.Length:=SizeOf(Label4Excel)-4-SizeOf(String)+Length(BS^)+2;
      Label4Excel.Value:=''''+BS^;
      _SetRec(Handle,Label4Excel.Length+4,Label4Excel);
     End;
     tdDirectChar:Begin
      S:=LoadStr(BS^,Q.FieldRec.Buffer^[I].Len);
      ChgChr(S,#0,' ');
      Label4Excel.TypeCode:=xltLabel;
      Label4Excel.Length:=SizeOf(Label4Excel)-4-SizeOf(String)+Length(BS^)+2;
      Label4Excel.Value:=''''+S;
      _SetRec(Handle,Label4Excel.Length+4,Label4Excel);
     End;
     tdInteger:Begin
      Number4Excel.TypeCode:=xltNumber;
      Number4Excel.Length:=SizeOf(Label4Excel)-4;
      RealToDouble(BL^,Number4Excel.Value);
      _SetRec(Handle,Number4Excel.Length+4,Number4Excel);
     End;
     tdWord:Begin
      Integer4Excel.TypeCode:=xltInteger;
      Integer4Excel.Length:=SizeOf(Integer4Excel)-4;
      Integer4Excel.Value:=BW^;
      _SetRec(Handle,Integer4Excel.Length+4,Integer4Excel);
     End;
    End;
   End;
   Inc(J);
   WEPutTxtXY(W,33,5,CStr(J));
  Until DBEOF(Q);
  EOF4Excel.TypeCode:=xltEOF;
  EOF4Excel.Length:=SizeOf(EOF4Excel);
  _SetRec(Handle,SizeOf(EOF4Excel),EOF4Excel);
  FileClose(Handle);
 End;
 WEPutTxtXY(W,33,1,StrUSpc('Terminer.',32));
 While WEOk(W)do;
 WEDone(W);
End;

Procedure DBConversionToLotus(Var Q:DataSet;Const TargetName:String);
Var
 Handle:Hdl;
 LLabel:LabelLotus123;
 LHeader:HeaderLotus123 Absolute LLabel;
 LEnd:EndLotus123 Absolute LHeader;
 LDouble:DoubleLotus123 Absolute LHeader;
 BB:^Byte;
 BC:^Char Absolute BB;
 BI:^Integer Absolute BB;
 BL:^LongInt Absolute BB;
 BO:^Boolean Absolute BB;
 BS:^String Absolute BB;
 BW:^Word Absolute BB;
 W:Window;
 I,J:Word;
 S:String;
 Data:Array[0..4095]of Byte;
Begin
 PutFrameDialog(W,Q.FileName,TargetName,'Exportation en Lotus 1-2-3','Conversion');
 Handle:=FileCreateAndBackup(TargetName);
 If(Handle<>errHdl)Then Begin
   {êcriture de l'entàte}
  LHeader.TypeCode:=0;
  LHeader.Length:=2;
  LHeader.Value:=1030;
  _SetRec(Handle,SizeOf(LHeader),LHeader);
   {DÇfinition de la premiäre ligne}
  For I:=0to Q.FieldRec.Num-1do Begin
   S:=StrPas(Q.FieldRec.Buffer^[I].Title);
   Case(Q.FieldRec.Buffer^[I].TypeDef)of
    tdChar:If Q.FieldRec.Buffer^[I].Len=0Then
     AddStr(S,',C,1')
    Else
     AddStr(S,',C,'+IntToStr(Q.FieldRec.Buffer^[I].Len));
   End;
   FillClr(LLabel,SizeOf(LLabel));
   LLabel.Column:=I;
   LLabel.TypeCode:=$0F;
   LLabel.Length:=Length(S)+7;
   LLabel.Format:=$FF;
   LLabel.Text[0]:='''';
   StrPascalCopy(LLabel.Text[1],239,S);
   _SetRec(Handle,Length(S)+11,LLabel);
  End;
   {êcriture du corps}
  DBFirst(Q);
  I:=0;J:=1;
  Repeat
   DBReadRec(Q,Data);
   For I:=0to Q.FieldRec.Num-1do Begin
    FillClr(LLabel,SizeOf(LLabel));
    LLabel.Column:=I;
    LLabel.Row:=J;
    BB:=@Data;
    DBGotoColumnAbs(Q,I,Pointer(BB));
    Case(Q.FieldRec.Buffer^[I].TypeDef)of
     tdVarChar:Begin
      LLabel.TypeCode:=$0F;
      LLabel.Length:=Length(BS^)+7;
      LLabel.Format:=$FF;
      LLabel.Text[0]:='''';
      StrPascalCopy(LLabel.Text[1],239,BS^);
      _SetRec(Handle,Length(BS^)+11,LLabel);
     End;
     tdChar:Begin
      If Q.FieldRec.Buffer^[I].Len=0Then S:=BC^
       Else
      Begin
       S:='';
       For J:=1to Length(BS^)do Begin
        Case BS^[J]of
         #0..' ':IncStr(S,' ');
         '''':AddStr(S,'''''');
         Else IncStr(S,BS^[J]);
        End;
       End;
      End;
      LLabel.TypeCode:=$0F;
      LLabel.Length:=Length(S)+7;
      LLabel.Format:=$FF;
      LLabel.Text[0]:='''';
      StrPascalCopy(LLabel.Text[1],239,S);
      _SetRec(Handle,Length(S)+11,LLabel);
     End;
     tdDirectChar:Begin
      S:=LoadStr(BS^,Q.FieldRec.Buffer^[I].Len);
      ChgChr(S,#0,' ');
      LLabel.TypeCode:=$0F;
      LLabel.Length:=Length(S)+7;
      LLabel.Format:=$FF;
      LLabel.Text[0]:='''';
      StrPascalCopy(LLabel.Text[1],239,S);
      _SetRec(Handle,Length(S)+11,LLabel);
     End;
     tdInteger:Begin
      LDouble.TypeCode:=$E;
      LDouble.Length:=13;
      LDouble.Format:=2 or 128;
      RealToDouble(BL^,LDouble.Value);
      _SetRec(Handle,17,LDouble);
     End;
     tdSmallInt:Begin
      LDouble.TypeCode:=$E;
      LDouble.Length:=13;
      LDouble.Format:=2 or 128;
      RealToDouble(BI^,LDouble.Value);
      _SetRec(Handle,17,LDouble);
     End;
     tdWord:Begin
      LDouble.TypeCode:=$E;
      LDouble.Length:=13;
      LDouble.Format:=2 or 128;
      RealToDouble(BW^,LDouble.Value);
      _SetRec(Handle,17,LDouble);
     End;
     tdByte:Begin
      LDouble.TypeCode:=$E;
      LDouble.Length:=13;
      LDouble.Format:=2 or 128;
      RealToDouble(BB^,LDouble.Value);
      _SetRec(Handle,17,LDouble);
     End;
    End;
   End;
   Inc(J);
   WEPutTxtXY(W,33,5,CStr(J));
  Until DBEOF(Q);
   {êcriture de la fin}
  LEnd.TypeCode:=1;
  LEnd.Length:=0;
  _SetRec(Handle,SizeOf(LEnd),LEnd);
  FileClose(Handle);
 End;
 WEPutTxtXY(W,33,1,StrUSpc('Terminer.',32));
 While WEOk(W)do;
 WEDone(W);
 Q.OnStatusCompiler:=NIL;
 Q.OnStatusCompilerContext:=NIL;
End;

Procedure DBConversionToMGC(Var Q:DataSet;Const TargetName:String);
Var
 Handle:Hdl;
 Cellule:DataMGCIdRec;
 Value:CelluleValue;
 BB:^Byte;
 BC:^Char Absolute BB;
 BI:^Integer Absolute BB;
 BL:^LongInt Absolute BB;
 BO:^Boolean Absolute BB;
 BS:^String Absolute BB;
 BW:^Word Absolute BB;
 W:Window;
 I,J:Word;
 S:String;
 Data:Array[0..4095]of Byte;
Begin
 PutFrameDialog(W,Q.FileName,TargetName,'Exportation en MGC','Conversion');
 Handle:=FileCreateAndBackup(TargetName);
 If(Handle<>errHdl)Then Begin
   {êcriture de l'entàte}
  PutFileTxt(Handle,'MGC'#26);
   {DÇfinition de la premiäre ligne}
  For I:=0to Q.FieldRec.Num-1do Begin
   S:=StrPas(Q.FieldRec.Buffer^[I].Title);
   Case(Q.FieldRec.Buffer^[I].TypeDef)of
    tdChar:If Q.FieldRec.Buffer^[I].Len=0Then
     AddStr(S,',C,1')
    Else
     AddStr(S,',C,'+IntToStr(Q.FieldRec.Buffer^[I].Len));
   End;
   FillClr(Cellule,SizeOf(Cellule));
   Cellule.Col:=I;
   Cellule.H.Format:=cfText;
   Cellule.H.Attribut:=$70;
   Cellule.Size:=Length(S)+1;
   _SetRec(Handle,SizeOf(Cellule),Cellule);
   _SetRec(Handle,Cellule.Size,S);
  End;
   {êcriture du corps}
  DBFirst(Q);
  I:=0;J:=1;
  Repeat
   DBReadRec(Q,Data);
   For I:=0to Q.FieldRec.Num-1do Begin
    FillClr(Cellule,SizeOf(Cellule));
    FillClr(Value,SizeOf(Value));
    Cellule.H.Attribut:=$F0;
    Cellule.Col:=I;
    Cellule.Row:=J;
    BB:=@Data;
    DBGotoColumnAbs(Q,I,Pointer(BB));
    Case(Q.FieldRec.Buffer^[I].TypeDef)of
     tdVarChar:Begin
      Cellule.H.Format:=cfText;
      Cellule.Size:=Length(BS^)+1;
      S:=BS^;
     End;
     tdChar:Begin
      If Q.FieldRec.Buffer^[I].Len=0Then S:=BC^
       Else
      Begin
       S:='';
       For J:=1to Length(BS^)do Begin
        Case BS^[J]of
         #0..' ':IncStr(S,' ');
         '''':AddStr(S,'''''');
         Else IncStr(S,BS^[J]);
        End;
       End;
      End;
      Cellule.H.Format:=cfText;
      Cellule.Size:=Length(S)+1;
     End;
     tdDirectChar:Begin
      S:=LoadStr(BS^,Q.FieldRec.Buffer^[I].Len);
      ChgChr(S,#0,' ');
      Cellule.H.Format:=cfText;
      Cellule.Size:=Length(S)+1;
     End;
     tdInteger:Begin
      Cellule.H.Format:=cfValue;
      Cellule.Size:=SizeOf(Value.Value);
      Value.Value:=BL^;
     End;
     tdSmallInt:Begin
      Cellule.H.Format:=cfValue;
      Cellule.Size:=SizeOf(Value.Value);
      Value.Value:=BI^;
     End;
     tdWord:Begin
      Cellule.H.Format:=cfValue;
      Cellule.Size:=SizeOf(Value.Value);
      Value.Value:=BW^;
     End;
     tdByte:Begin
      Cellule.H.Format:=cfValue;
      Cellule.Size:=SizeOf(Value.Value);
      Value.Value:=BB^;
     End;
    End;
    _SetRec(Handle,SizeOf(Cellule),Cellule);
    Case(Cellule.H.Format)of
     cfText:_SetRec(Handle,Cellule.Size,S);
     cfValue:_SetRec(Handle,Cellule.Size,Value);
    End;
   End;
   Inc(J);
   WEPutTxtXY(W,33,5,CStr(J));
  Until DBEOF(Q);
   {êcriture de la fin}
  FileClose(Handle);
 End;
 WEPutTxtXY(W,33,1,StrUSpc('Terminer.',32));
 While WEOk(W)do;
 WEDone(W);
 Q.OnStatusCompiler:=NIL;
 Q.OnStatusCompilerContext:=NIL;
End;


Function DBLReadLine(Var Q:DBListBox;P:Word):String;
Var
 PBuffer:Pointer;
 PString:^String Absolute PBuffer;
 Buffer:Array[0..1023]of Byte;
Begin
{ DBMoveTo(ChantalServer,P);
 DBReadRec(ChantalServer,Buffer);
 PBuffer:=@Buffer;
 DBGotoColumnAbs(ChantalServer,Q.ColumnNum,PBuffer);
 DBLReadLine:=PString^;}
 DBMoveTo(Q.DB,P);
 DBReadRec(Q.DB,Buffer);
 PBuffer:=@Buffer;
 DBGotoColumnAbs(Q.DB,Q.ColumnNum,PBuffer);
 DBLReadLine:=PString^;
End;

Procedure DBLSelectBar(Var Q:DBListBox);Begin
 WESetKrSel(Q.W);
 WEBarSelHor(Q.W,0,Q.Y,wnMax);
End;

Procedure DBLUnSelectBar(Var Q:DBListBox);Begin
 If(IsBanderolle)Then Begin
  WEBarSpcHorBanderolle(Q.W,Q.Y,Q.P);
  WEPutTxtXYT(Q.W,0,Q.Y,DBLReadLine(Q,Q.P));
 End
  Else
 Begin
  WESetKrBorder(Q.W);
  WEBarSelHor(Q.W,0,Q.Y,wnMax);
 End;
End;

Procedure DBLPutLine(Var Q:DBListBox);Begin
 If(IsBanderolle)Then Begin
  WEBarSpcHorBanderolle(Q.W,Q.Y,Q.P);
  WEPutTxtXYT(Q.W,0,Q.Y,DBLReadLine(Q,Q.P));
 End
  Else
 WEPutTxtXY(Q.W,0,Q.Y,DBLReadLine(Q,Q.P));
End;

Procedure DBLHome(Var Q:DBListBox);
Var
 I:Byte;
Begin
 WESetPosHome(Q.W);
 Q.P:=0;
 Q.Y:=0;
 For I:=0to(Q.W.MaxY)do Begin
  If(IsBanderolle)Then Begin
   WEBarSpcHorBanderolle(Q.W,I,I);
   WEPutTxtTLn(Q.W,DBLReadLine(Q,I));
  End
   Else
  WEPutTxtLn(Q.W,DBLReadLine(Q,I));
 End;
 DBLSelectBar(Q);
End;

Procedure DBLShowList(Var Q:DBListBox);
Var
 I:Byte;
 PT:Word;
Begin
 WEClrWnBorder(Q.W,0,0,wnMax,wnMax);
 WESetPosHome(Q.W);
 PT:=Q.P-Q.Y;
 For I:=0to(Q.W.MaxY)do Begin
  If(IsBanderolle)Then Begin
   WEBarSpcHorBanderolle(Q.W,I,PT);
   WEPutTxtTLn(Q.W,DBLReadLine(Q,PT));
  End
   Else
  WEPutTxtLn(Q.W,DBLReadLine(Q,PT));
  Inc(PT);
 End;
 DBLSelectBar(Q);
End;

Procedure DBLSearchName(Var Q:DBListBox;Const Name:String);Begin
 If DBLocateAbs(ChantalServer,2,Name,[soNotStrict])Then Begin
  Q.P:=ChantalServer.CurrLine;
  If(Q.P<Q.Y)Then Q.Y:=Q.P;
  DBLShowList(Q);
 End;
End;

Procedure DBLUp(Var Q:DBListBox);Begin
 If Q.P>0Then Begin
  Q.BufChr:='';
  DBLUnSelectBar(Q);
  Dec(Q.P);
  If Q.Y>0Then Dec(Q.Y)
   Else
  Begin
   WEScrollUp(Q.W,0,0,wnMax,wnMax);
   DBLPutLine(Q);
  End;
  DBLSelectBar(Q);
 End;
End;

Procedure DBLDn(Var Q:DBListBox);Begin
 If(Q.P<Q.MP)Then Begin
  Q.BufChr:='';
  DBLUnSelectBar(Q);
  Inc(Q.P);
  If(Q.Y<Q.W.MaxY)Then Inc(Q.Y)
   Else
  Begin
   WEScrollDn(Q.W,0,0,wnMax,wnMax);
   DBLPutLine(Q);
  End;
  DBLSelectBar(Q);
 End;
End;

Procedure DBLEnd(Var Q:DBListBox);Begin
 If(Q.P<=Q.MP)Then Begin
  Q.BufChr:='';
  Q.P:=Q.MP;
  Q.Y:=Q.W.MaxY;
  If(Q.P<=Q.W.MaxY)Then Q.Y:=Q.P;
  DBLShowList(Q);
 End;
End;

Procedure DBLPgDn(Var Q:DBListBox);Begin
 If(Q.P+(Q.W.MaxY shl 1)<Q.MP)Then Begin
  Q.BufChr:='';
  Inc(Q.P,Q.W.MaxY);
  DBLShowList(Q);
 End
  Else
 DBLEnd(Q);
End;

Procedure DBLPgUp(Var Q:DBListBox);Begin
 If(Q.P<Q.W.MaxY)Then DBLHome(Q)
  Else
 Begin
  Dec(Q.P,Q.W.MaxY);
  If(Q.P<Q.Y)Then Q.Y:=Q.P;
  DBLShowList(Q);
 End;
End;

Procedure DBLInit(Var Q:DBListBox;X1,Y1,X2,Y2:Byte;Const Title,TableName:String;Column:Byte);Begin
 FillClr(Q,SizeOf(Q));
 WEInit(Q.W,X1,Y1,X2,Y2);
 WEPushWn(Q.W);
 WEPutWn(Q.W,Title,CurrKrs.Dialog.Env.List);
 WEPutBarMsRight(Q.W);
 DBOpenServerName(ChantalServer,TableName);
 Q.MP:=DBNumRec(ChantalServer)-2;
 Q.ColumnNum:=Column;
 Q.DB:=ChantalServer;
End;

Procedure DBLOpen(Var Q:DBListBox;X1,Y1,X2,Y2:Byte;Const Title,PathDB,TableName:String;Column:Byte);Begin
 FillClr(Q,SizeOf(Q));
 WEInit(Q.W,X1,Y1,X2,Y2);
 WEPushWn(Q.W);
 WEPutWn(Q.W,Title,CurrKrs.Dialog.Env.List);
 WEPutBarMsRight(Q.W);
 DBInit(Q.DB,PathDB);
 If TableName<>''Then DBOpenServerName(Q.DB,TableName);
 Q.MP:=DBNumRec(Q.DB)-3;
 Q.ColumnNum:=Column;
End;

Procedure DBLDone(Var Q:DBListBox);Begin
 WEDone(Q.W);
End;

Function DBLRun(Var Q:DBListBox):Word;
Var
 K:Word;
 OldP:LongInt;
Begin
 Repeat
  OldP:=Q.P;
  K:=WEReadk(Q.W);
  Case(K)of
   kbHome:DBLHome(Q);
   kbRBarMsUp,kbRBarMsDn:Begin
    __HideMousePtr;
    Case(K)of
     kbRBarMsUp:DBLUp(Q);
     Else DBLDn(Q);
    End;
    DelayMousePress(100);
    __ShowMousePtr;
   End;
   kbUp:DBLUp(Q);
   kbDn:DBLDn(Q);
   kbPgUp:DBLPgUp(Q);
   kbPgDn:DBLPgDn(Q);
   kbEnd:DBLEnd(Q);
   Else If(Char(K)>#31)and(Hi(K)<$80)Then Begin
    IncStr(Q.BufChr,ChrUp(Char(K)));
    DBLSearchName(Q,Q.BufChr);
   End
    Else
   Break;
  End;
  If(OldP<>Q.P)Then Begin
   If(@Q.ShowCurrLine<>NIL)Then Q.ShowCurrLine(Q,Q.Context^);
   Old:=Q.P;
  End;
 Until False;
 DBLRun:=K;
End;

Function DBChoice(X1,Y1,X2,Y2:Byte;Const Title,TableName:String;Column:Byte):String;
Var
 R:DBListBox;
 K:Word;
Begin
 DBChoice:='';
 DBLInit(R,X1,Y1,X2,Y2,Title,TableName,Column);
 DBLHome(R);
 Repeat
  K:=WEReadk(R.W);
  Case(K)of
   kbInWn:Begin
    DBChoice:=DBLReadLine(R,R.P-R.Y+LastMouseY-WEGetRY1(R.W));
    WaitMouseBut0;
    Break;
   End;
   kbEnter:Begin
    DBChoice:=DBLReadLine(R,R.P);
    Break;
   End;
   kbHome:DBLHome(R);
   kbRBarMsUp,kbRBarMsDn:Begin
    __HideMousePtr;
    Case(K)of
     kbRBarMsUp:DBLUp(R);
     Else DBLDn(R);
    End;
    DelayMousePress(100);
    __ShowMousePtr;
   End;
   kbUp:DBLUp(R);
   kbDn:DBLDn(R);
   kbPgUp:DBLPgUp(R);
   kbPgDn:DBLPgDn(R);
   kbEnd:DBLEnd(R);
   Else If(Char(K)>#31)and(Hi(K)<$80)Then Begin
    IncStr(R.BufChr,ChrUp(Char(K)));
    DBLSearchName(R,R.BufChr);
   End
    Else
   Break;
  End;
 Until False;
 DBLDone(R);
End;

{ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ}
END.