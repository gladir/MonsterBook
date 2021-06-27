Unit CalcSave;

INTERFACE

Function  SCSave(Var Q):Boolean;
Function  SCSaveAs(Var Context;Const FileName:String):Boolean;

IMPLEMENTATION

Uses Video,Math,Numerix,Systex,Memories,Systems,Isatex,Calcex,Dialex,Dials,
     DialPlus,MalCalc,ResTex,ResServD;

{$I \Source\Chantal\Library\HashTabl.Inc}
{$I \Source\Chantal\Library\App\Tableur\Column.Inc}
{$I \Source\Chantal\Library\App\Tableur\Cellule.Inc}

Function GetColorClassicHTML(Color:Byte):String;Near;Begin
 GetColorClassicHTML:='#'+HexByte2Str(DefaultRGB[Color].R)+HexByte2Str(DefaultRGB[Color].G)+HexByte2Str(DefaultRGB[Color].B);
End;

Function SCSaveAs;
Var
 Q:SuperCalcApp Absolute Context;
 J,I:LongInt;
 K:Byte;
 Handle:Hdl;
 Size:Word;
 PC:PCellule;
 First:Boolean;
 UpDate:Boolean;
 H:HashItemPtr;
 S,Path:String;
 STarget:String;
 Color:String[15];
 LW:Window;
 Font:DataSetInMemory; { Pour la conversion de la police de caractäres }
 Data:DataMGCIdRec;
 Buffer:Array[0..511]of Byte;
 LLabel:LabelLotus123 Absolute Buffer;
 LHeader:HeaderLotus123 Absolute LLabel;
 LEnd:EndLotus123 Absolute LHeader;
 LDouble:DoubleLotus123 Absolute LHeader;
 SignExcel:BOFExcel Absolute Buffer;
 Label4Excel:LabelExcel Absolute Buffer;
 Integer4Excel:IntegerExcel Absolute Buffer;
 Number4Excel:NumberExcel Absolute Buffer;
 EOF4Excel:EOFExcel Absolute Buffer;

 Procedure SaveName;
 Var
  R:FileListBox; { Objet pour l'entrÇe d'un nom de document }
  H:History;     { Histoire retenu pour cette objet }
  Format:Byte;
  K:Word;
 Begin
  HYInit(H,0);
  FLInitModel(R,Path,'Sauvegarde sous',H,False,False,True,omCalc);
  Case(Q.FormatMode)of
   tfMGC:Format:=cfoMGC;
   tfLotus:Format:=cfoLotus123;
   tfExcel:Format:=cfoExcel21;
   tfASCII:Format:=cfoLst;
   tfCSV:Format:=cfoCSV;
   tfHTML:Format:=cfoHTML;
   Else Format:=cfoMGC;
  End;
  FLUpDateFormat(R,Format);
  Repeat
   K:=FLRun(R);
  Until(K=kbEsc)or(K=kbClose)or(K=kbEnter);
  If(K=kbEnter)Then Begin
   Case FLFormat(R)of
    cfoMGC:Q.FormatMode:=tfMGC;
    cfoLotus123:Q.FormatMode:=tfLotus;
    cfoExcel21:Q.FormatMode:=tfExcel;
    cfoLst:Q.FormatMode:=tfASCII;
    cfoCSV:Q.FormatMode:=tfCSV;
    cfoHTML:Q.FormatMode:=tfHTML;
    Else Q.FormatMode:=tfMGC;
   End;
   Path:=R.Path;
  End;
  FLDone(R);
 End;

 Procedure AddLotusFormula(C,F:Integer;S:String);
 Type
  Formula=Record
   TypeCode:Integer;      { Code d'identification = 16 }
   Length:Integer;        { Longueur des donnÇes }
   Format:Byte;           { Format }
   Column:Integer;        { Colonne }
   Row:Integer;           { Ligne }
   Res:Double;
   Tma:Integer;
   Formula:Array[1..2048]of Byte;
  End;
  Symbol=(Cellule,num,arr,mas,men,por,dvs,pot,pa1,pa2);
  ConSym=Set of Symbol;

 Var
  Formato:Array[1..2067]of Byte;
  Registro:Formula Absolute Formato;
  FAbs:Boolean;
  V,nro:String;
  cfml,ffml:Word;
  nfml,i,ii,Index,j,Ret,Len,Lens:Integer;
  Sym:Symbol;
  SymSig,
  SymIniFac:ConSym;
  z:Byte;

  Procedure CalculaDir(Var Reg:Formula);
  Var
   Veces:Integer;
  Begin
   With Reg do Begin
    If v[I]='$'Then Begin
     Inc(I);
     cfml:=Byte(v[i])-Byte('A');
     Inc(I);
     While(v[i]in['A'..'Z'])and(Len>=i)do Begin
      cfml:=(cfml+1)*26+ord(v[i])-ord('A');
      Inc(i);
     End;
    End
     Else
    Begin
     If(Byte(v[i])-Byte('A')<Column)Then Begin
      cfml:=49152-Column+(Byte(v[i])-Byte('A'));
      Inc(i);
      Veces:=1;
      While(v[i]in['A'..'Z'])and(Len>=i)do Begin
       cfml:=49152-Column+(26*veces)+(ord(v[i])-ord('A'));
       cfml:=cfml+((ord(v[i-1])-ord('A'))*26);
       Inc(i);
       Inc(veces);
      End;
     End
      Else
     Begin
      cfml:=Byte(v[i])-Byte('A');
      Inc(I);
      While(v[i]in['A'..'Z'])and(Len>=i)do Begin
       cfml:=(cfml+1)*26+Byte(v[i])-Byte('A');
       Inc(i);
      End;
      cfml:=cfml+32768-Column;
     End;
    End;
    Formula[Index]:=Lo(cfml);
    Inc(Index);
    Formula[Index]:=Hi(cfml);
    Inc(Index);
    If v[I]='$'Then Begin
     Inc(I);
     Fabs:=True;
    End
     Else
    FAbs:=False;
    j:=i;
    While(v[i]in['0'..'9'])and(Len>=i)do Inc(I);
    nro:=Copy(v,j,i-j);
    Val(nro,ffml,ret);
    If(FAbs)Then Begin
     If ffml>0Then ffml:=ffml-1;
    End
     Else
    Begin
     If(Row<ffml)Then Begin
      ffml:=32768+Abs(ffml-Row)-1;
     End
      Else
     Begin
      ffml:=49152-Abs(ffml-Row)-1;
     End;
    End;
    Formula[Index]:=Lo(ffml);
    Inc(Index);
    Formula[Index]:=Hi(ffml);
    Inc(Index);
   End;
  End;

  Procedure CalculaNum(Var Reg:Formula);
  Var
   VDoble:Array[1..8]of Byte;
   dfml:Double Absolute VDoble;
   d:Real;
   esreal:Boolean;
   k:Byte;
   Numero:LongInt;
   codigo:Integer;
  Begin
   With Reg do Begin
    Esreal:=False;
    j:=i;
    While(v[I]in['0'..'9','.'])and(Len>=I)do Begin
     If v[I]='.'Then Esreal:=True;
     Inc(I);
    End;
    nro:=Copy(v,j,i-j);
    Val(nro,Numero,Codigo);
    EsReal:=Not((Codigo=0)and(Numero>=-32768)and(Numero<=32767));
    If(EsReal)Then Begin
     Val(nro,d,ret);
     D:=DoubleToReal(dfml);
     Formula[Index]:=0;
     Inc(Index);
     For k:=1to 8do Begin
      Formula[Index]:=VDoble[k];
      Inc(Index);
     End;
    End
     Else
    Begin
     Val(nro,nfml,ret);
     Formula[Index]:=5;
     Inc(Index);
     Formula[Index]:=Lo(nfml);
     Inc(Index);
     Formula[Index]:=Hi(nfml);
     Inc(Index);
    End;
    Dec(I);
   End;
  End;

  Procedure CalculaRan(Var Reg:Formula);Begin
   With Reg do Begin
    Formula[Index]:=2;
    Inc(Index);
    CalculaDir(Reg);
    Inc(I,2);
    CalculaDir(Reg);
   End;
  End;

   {** Les codes @TRUE,@FALSE,@SUM(COL1FIL1..COL2FIIL2) **}
  Procedure CalculaArr(Var Reg:Formula);
  Var
   Func,Dir:String;
   NArg,nc:Byte;
  Begin
   With Reg do Begin
    Inc(i);
    Case v[i]of
     'F':nc:=51;
     'T':nc:=52;
     'S':nc:=80;
    End;
    While(v[i]in['A'..'Z'])and(Len>=I)do Inc(I);
    Inc(I);
    If nc=80Then Begin
     CalculaRan(Reg);
     NArg:=1;
    End;
    Formula[Index]:=nc;
    Inc(Index);
    If nc=80Then Begin
     Formula[Index]:=NArg;
     Inc(Index);
    End;
   End;
  End;

  Procedure TraerChar;Begin
   Inc(I);
   If(Len>=i)Then Begin
    Case v[i]of
     'A'..'Z','$':Sym:=Cellule;
     '0'..'9','.':Sym:=num;
     '@':Sym:=arr;
     '+':Sym:=mas;
     '-':Sym:=men;
     '*':Sym:=por;
     '/':Sym:=dvs;
     '^':Sym:=pot;
     '(':Sym:=pa1;
     ')':Sym:=pa2;
    End;
   End;
  End;

  Procedure Expresion(SymSig:ConSym;Var Reg:Formula);
  Var
   OpSuma:Symbol;

   Procedure Termino(SymSig:ConSym;Var Reg:Formula);
   Var
    OpMul:Symbol;

    Procedure Factor(SymSig:ConSym;Var Reg:Formula);
    Var
     OpExp:Symbol;

     Procedure Exponente(SymSig:ConSym;Var Reg:Formula);Begin
      While(Sym in SymIniFac)and(Len>=i)do Begin
       Case(sym)of
        Num:Begin
         CalculaNum(Registro);
         TraerChar;
        End;
        Cellule:Begin
         Reg.Formula[Index]:=1;
         Inc(Index);
         CalculaDir(Registro);
         Dec(I);
         TraerChar;
        End;
        Arr:Begin
         CalculaArr(Registro);
         TraerChar;
        End;
        Else Begin
         If(Sym=pa1)Then Begin
          TraerChar;
          Expresion([pa2]+SymSig,Registro);
          If(Sym=pa2)Then Begin
           Reg.Formula[Index]:=4;       {4 = symbole '(' }
           Inc(Index);
           TraerChar;
          End;
         End;
        End;
       End;
      End;
     End;

    Begin
     Exponente(SymSig+[Pot],Registro);
     While(Sym=Pot)and(Len>=I)do Begin
      OpExp:=Sym;
      TraerChar;
      Exponente(SymSig+[Pot],Registro);
      If(OpExp=Pot)Then Begin
       Reg.Formula[index]:=13; {13 = symbole '^' }
       Inc(Index);
      End;
     End;
    End;

   Begin
    Factor(SymSig+[por,dvs],Registro);
    While(Sym in[por,dvs])and(Len>=I)do Begin
     OpMul:=Sym;
     TraerChar;
     Factor(symsig+[por,dvs],Registro);
     If(OpMul=por)or(Opmul=dvs)Then Begin
      If(OpMul=por)Then Reg.Formula[Index]:=11   {11 = symbole '*' }
                   Else Reg.Formula[Index]:=12;  {12 = symbole '/' }
      Inc(Index);
     End;
    End;
   End;

  Begin
   If(Sym)in[mas,men]Then Begin
    OpSuma:=Sym;
    TraerChar;
    Termino(SymSig+[Mas,Men],Registro);
    If(opsuma=men)Then Begin
     Reg.Formula[index]:=8;  {8 = symbole '-' unair}
     Inc(Index);
    End;
   End
    Else
   Termino(SymSig+[Mas,Men],Registro);
   While(Sym in[Mas,Men])and(Len>=i)do Begin
    OpSuma:=Sym;
    TraerChar;
    Termino(SymSig+[Mas,Men],Registro);
    If(OpSuma=mas)or(OpSuma=Men)Then Begin
     If(OpSuma=mas)Then Reg.Formula[index]:=9   { 9 = symbole '+' }
                   Else Reg.Formula[index]:=10; {10 = symbole '-' }
     Inc(Index);
    End;
   End;
  End;

 Begin
  FillClr(Registro,SizeOf(Registro));
  Registro.TypeCode:=16;                     { 16 = Formule }
  Registro.Column:=c;
  Registro.Row:=f;
  Registro.Format:=0;
  Registro.Length:=Length(S);
  S:=StrUp(S);
  I:=1;
  V:='';
  For ii:=1to(Lens)do Begin
   If S[ii]<>' 'Then Begin
    IncStr(V,s[ii]);
    Inc(I);
   End;
  End;
  Len:=I-1;
  I:=0;
  Index:=1;
  SymIniFac:=[Cellule,Num,Arr,pa1];
  SymSig:=SymIniFac;
  TraerChar;
  Expresion(SymSig,Registro);
  Registro.Formula[index]:=3;
  Registro.Tma:=index;
  Registro.Length:=15+Registro.Tma;
  _SetRec(Handle,19+index,Formato[1]);
 End;

Begin
 SCSaveAs:=False;Path:=FileName;
 If Path=''Then SaveName;
 UpDate:=Q.FileName<>Path;
 If(UpDate)Then Begin{ Existe toujours ? }
  If FileExist(Path)Then If Not __InputOverwriteFile(Path)Then Exit;
  Q.FileName:=StrUp(Path);
 End;
 WEPushEndBar(LW);
 WEPutLastBar('Sauvegarde en cours...');
 Case(Q.FormatMode)of
  tfMGC:Path:=Path2NoExt(Path)+'.MGC';
  tfLotus:Path:=Path2NoExt(Path)+'.WK1';
  tfExcel:Path:=Path2NoExt(Path)+'.XLS';
  tfCSV:Path:=Path2NoExt(Path)+'.CSV';
  tfHTML:Path:=Path2NoExt(Path)+'.HTM';
  tfASCII:Path:=Path2NoExt(Path)+'.LST';
 End;
 Handle:=FileCreateAndBackup(Path);
 If(Handle=errHdl)Then Begin
  ErrNoMsgOk(CannotCreateFile);
  WEDone(LW);
  Exit;
 End;
 Case(Q.FormatMode)of
  tfMGC:Begin
   PutFileTxt(Handle,'MGC'#26);
    { êcritures des colonnes }
   H:=HTFirstItem(Q.Column.List);
   While(H<>NIL)do Begin
    FillClr(Data,SizeOf(Data));
    MoveLeft(H^.Data,Q.Column.Curr,SizeOf(ColumnRec));
    Data.Col:=Q.Column.Curr.Column;
    Data.H:=Q.Column.Curr.Header;
    Data.H.Format:=cfColumn;
    Data.Size:=SizeOf(ColumnHeader);
    _SetRec(Handle,SizeOf(Data),Data);
    _SetRec(Handle,Data.Size,Q.Column.Curr.c);
    H:=HTNextItem(Q.Column.List);
   End;
    { êcriture des cellules }
   H:=HTFirstItem(Q.Cellule.List);
   While(H<>NIL)do Begin
    MoveLeft(H^.Data,Q.Cellule.Curr,SizeOf(CelluleRec));
    FillClr(Data,SizeOf(Data));
    Data.Col:=Q.Cellule.Curr.Column;
    Data.Row:=Q.Cellule.Curr.Row;
    Data.H:=Q.Cellule.Curr.Header;
    Case(Q.Cellule.Curr.Header.Format)of
     cfText:Data.Size:=Length(Q.Cellule.Curr.Data.t.Text)+1;
     cfValue:Begin
      Data.Size:=SizeOf(Q.Cellule.Curr.Data.v.Value);
      If Q.Cellule.Curr.Data.v.Dec<>4Then Begin
       Inc(Data.Size);
       Data.H.Format:=Data.H.Format or$80;
      End;
     End;
     cfFormula:Data.Size:=Length(Q.Cellule.Curr.Data.f.Formula)+1;
    End;
    _SetRec(Handle,SizeOf(Data),Data);
    Case(Q.Cellule.Curr.Header.Format)of
     cfText:_SetRec(Handle,Data.Size,Q.Cellule.Curr.Data.t.Text);
     cfValue:_SetRec(Handle,Data.Size,Q.Cellule.Curr.Data.v.Value);
     cfFormula:_SetRec(Handle,Data.Size,Q.Cellule.Curr.Data.f.Formula);
    End;
    H:=HTNextItem(Q.Cellule.List);
   End;
  End;
  tfLotus:Begin
    {êcriture de l'entàte}
   LHeader.TypeCode:=0;
   LHeader.Length:=2;
   LHeader.Value:=1030;
   _SetRec(Handle,SizeOf(LHeader),LHeader);
    {êcriture du corps}
   H:=HTFirstItem(Q.Cellule.List);
   While(H<>NIL)do Begin
    MoveLeft(H^.Data,Q.Cellule.Curr,SizeOf(CelluleRec));
    FillClr(LLabel,SizeOf(LLabel));
    LLabel.Column:=Q.Cellule.Curr.Column;
    LLabel.Row:=Q.Cellule.Curr.Row;
    Data.H:=Q.Cellule.Curr.Header;
    Case(Q.Cellule.Curr.Header.Format)of
     cfText:Begin
      LLabel.TypeCode:=$0F;
      LLabel.Length:=Length(Q.Cellule.Curr.Data.t.Text)+7;
      LLabel.Format:=$FF;
      Case(Q.Cellule.Curr.Header.Justify)of
       cCenter:LLabel.Text[0]:='^';
       cRight:LLabel.Text[0]:='"';
       Else LLabel.Text[0]:='''';
      End;
      StrPascalCopy(LLabel.Text[1],239,Q.Cellule.Curr.Data.t.Text);
     End;
     cfValue:Begin
      LDouble.TypeCode:=$E;
      LDouble.Length:=13;
      LDouble.Format:=2 or 128;
      RealToDouble(Q.Cellule.Curr.Data.v.Value,LDouble.Value);
     End;
    End;
    Case(Q.Cellule.Curr.Header.Format)of
     cfText:_SetRec(Handle,Length(Q.Cellule.Curr.Data.t.Text)+11,LLabel);
     cfValue:_SetRec(Handle,17,LDouble);
     cfFormula:AddLotusFormula(Q.Cellule.Curr.Column,Q.Cellule.Curr.Row,Q.Cellule.Curr.Data.f.Formula);
    End;
    H:=HTNextItem(Q.Cellule.List);
   End;
    {êcriture de la fin}
   LEnd.TypeCode:=1;
   LEnd.Length:=0;
   _SetRec(Handle,SizeOf(LEnd),LEnd);
  End;
  tfExcel:Begin
    {êcriture de l'entàte}
   FillClr(SignExcel,SizeOf(SignExcel));
   SignExcel.Length:=6;
   SignExcel.TypeCode:=$0009;
   _SetRec(Handle,SizeOf(SignExcel),SignExcel);
    {êcriture du corps}
   H:=HTFirstItem(Q.Cellule.List);
   While(H<>NIL)do Begin
    MoveLeft(H^.Data,Q.Cellule.Curr,SizeOf(CelluleRec));
    FillClr(Label4Excel,SizeOf(Label4Excel));
    Label4Excel.Column:=Q.Cellule.Curr.Column;
    Label4Excel.Row:=Q.Cellule.Curr.Row;
    Data.H:=Q.Cellule.Curr.Header;
    Case(Q.Cellule.Curr.Header.Format)of
     cfText:Begin
      Label4Excel.TypeCode:=xltLabel;
      Label4Excel.Length:=SizeOf(Label4Excel)-4-SizeOf(String)+Length(Q.Cellule.Curr.Data.t.Text)+2;
      Case(Q.Cellule.Curr.Header.Justify)of
       cCenter:Label4Excel.Value:='^';
       cRight:Label4Excel.Value:='"';
       Else Label4Excel.Value:='''';
      End;
      AddStr(Label4Excel.Value,Q.Cellule.Curr.Data.t.Text);
     End;
     cfValue:Begin
      Number4Excel.TypeCode:=xltNumber;
      Number4Excel.Length:=SizeOf(Label4Excel)-4;
      RealToDouble(Q.Cellule.Curr.Data.v.Value,Number4Excel.Value);
     End;
    End;
    _SetRec(Handle,Number4Excel.Length+4,Buffer);
    H:=HTNextItem(Q.Cellule.List);
   End;
    {êcriture de la fin}
   EOF4Excel.TypeCode:=xltEOF;
   EOF4Excel.Length:=0;
   _SetRec(Handle,SizeOf(EOF4Excel),EOF4Excel);
  End;
  tfCSV:Begin
   CENumLine(Q.Cellule);
   For J:=Q.Cellule.Y1 to(Q.Cellule.Y2)do Begin
    PC:=CEFindLine(Q.Cellule,J);
    If(PC=NIL)Then S:=''
     Else
    Begin
     First:=True;
     For I:=0to(Q.Cellule.X2)do Begin
      PC:=SCGetCellule(Q,I,J);
      If(PC=NIL)Then Break;
      S:='';
      Case(PC^.Header.Format)of
       cfText:S:=PC^.Data.t.Text;
       cfValue:S:=RealStr(PC^.Data.v.Value);
       cfFormula:S:='='+PC^.Data.f.Formula;
      End;
      If Not(First)Then PutFileTxt(Handle,',');
      PutFileTxt(Handle,S);
      First:=False;
     End;
    End;
    PutFileLn(Handle);
   End;
  End;
  tfHTML:Begin
   DBOpenServerName(ChantalServer,'CHANTAL:/Texte/Format/ASCII2HTML.Dat');
   If Not DBCopyToMemory(ChantalServer,Font)Then Begin
    __OutOfMemory;
    Exit;
   End;
   CENumLine(Q.Cellule);
   PutFileTxt(Handle,'<HTML><BODY><TABLE>');
   For J:=Q.Cellule.Y1 to(Q.Cellule.Y2)do Begin
    PutFileTxt(Handle,'<TR>');
    PC:=CEFindLine(Q.Cellule,J);
    If(PC=NIL)Then S:=''
     Else
    Begin
     First:=True;
     For I:=0to(Q.Cellule.X2)do Begin
      PC:=SCGetCellule(Q,I,J);
      If(PC=NIL)Then Break;
      S:='';
      Case(PC^.Header.Format)of
       cfText:S:=PC^.Data.t.Text;
       cfValue:S:=RealStr(PC^.Data.v.Value);
       cfFormula:S:=RealStr(PC^.Data.f.Value);
      End;
      If Not(First)Then PutFileTxt(Handle,'</TD>');
      PutFileTxt(Handle,'<TD');
      Case(PC^.Header.Justify)of
       cCenter:PutFileTxt(Handle,' Align=Center');
       cRight:PutFileTxt(Handle,' Align=Right');
      End;
      If PC^.Header.Attribut shr 4<>$FThen Begin
       PutFileTxt(Handle,' BgColor='+GetColorClassicHTML(PC^.Header.Attribut shr 4));
      End;
      PutFileTxt(Handle,'>');
      If PC^.Header.Attribut and $F<>0Then Begin
       PutFileTxt(Handle,'<FONT Color='+GetColorClassicHTML(PC^.Header.Attribut and$F)+'>');
      End;
      STarget:='';
      For K:=1to Length(S)do Begin
       If DBLocateAbsIM(Font,0,S[K],[])Then Begin
        Inc(PtrRec(Font.CurrRec).Ofs);
        AddStr(STarget,Font.CurrRec.Str^);
       End
        Else
       IncStr(STarget,S[K]);
      End;
      PutFileTxt(Handle,STarget);
      First:=False;
     End;
     PutFileTxt(Handle,'</TD>');
    End;
    PutFileTxtLn(Handle,'</TR>');
   End;
   PutFileTxt(Handle,'</TABLE></BODY></HTML>');
   DBDispose(Font);
  End;
  Else Begin
   CENumLine(Q.Cellule);
   For J:=Q.Cellule.Y1 to(Q.Cellule.Y2)do Begin
    PC:=CEFindLine(Q.Cellule,J);
    If(PC=NIL)Then S:=''
     Else
    Begin
     For I:=0to(Q.Cellule.X2)do Begin
      PC:=SCGetCellule(Q,I,J);
      If(PC=NIL)Then Break;
      S:='';
      Case(PC^.Header.Format)of
       cfText:S:=PC^.Data.t.Text;
       cfValue:S:=RealStr(PC^.Data.v.Value);
       cfFormula:S:=PC^.Data.f.Formula;
      End;
      PutFileTxt(Handle,StrUSpc(S,COGetColumnWidth(Q.Column,I)));
     End;
    End;
    PutFileLn(Handle);
   End;
  End;
 End;
 FileClose(Handle);
 If(Q.FileName='')or(UpDate)Then Begin
  Q.FileName:=StrUp(Path);
  SCUpdateStatusBar(Q);
 End;
 WEDone(LW);
 Q.GlobalModified:=False;
 SCSaveAs:=True;
End;

Function SCSave;Begin
 SCSave:=SCSaveAs(Q,SuperCalcApp(Q).FileName)
End;

END.