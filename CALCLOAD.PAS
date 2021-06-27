Unit CalcLoad;

INTERFACE

Uses Isatex;

Procedure SCLoad(Var Q:SuperCalcApp;X1,Y1,X2,Y2,Model:Byte;Const Path:String);
Procedure SCLoadClassic(Var Q;X1,Y1,X2,Y2:Byte;Const Path:String);

IMPLEMENTATION

Uses
 Math,Video,Numerix,Calcex,Dialex,MalCalc,Systex,Memories,
 Systems,Editor,Dials,Restex,ResServD,DialPlus;

{$I \Source\Chantal\Library\HashTabl.Inc}
{$I \Source\Chantal\Library\App\Tableur\Column.Inc}
{$I \Source\Chantal\Library\App\Tableur\Cellule.Inc}

Procedure SCLoad;
Var
 OldActifScrn:Boolean;
 Handle:Hdl;
 FP,FS,P,Ix:LongInt;
 PC:PChr;
 PCel:PCellule;
 T,I:Byte;
 PP:Byte;
 Color:RGB;
 CurrAttribut:SmallInt;
 R:Real;                   { Variable temporaire de conversion de nombre }
 Error:Word;               { Variable d'erreur de conversion de nombre }
 Ext,Str,S2,S3:String;
 Buffer:Array[0..511]of Byte;
 Sign:Array[0..3]of Char Absolute Buffer;  { Signature: 'MGC'#26 }
 SignLotus:Record          { Enregistrement signature de Lotus 1-2-3 }
  TypeCode:Integer;
  Length:Integer;
 End Absolute Buffer;
 LabelLotus:LabelLotus123; { Enregistrement d'‚tiquette de Lotus 1-2-3 }
 IntegerLotus:IntegerLotus123 Absolute LabelLotus;
 DoubleLotus:DoubleLotus123 Absolute LabelLotus;
 SignExcel:BOFExcel Absolute Buffer;
 Label4Excel:LabelExcel Absolute Buffer;
 Integer4Excel:IntegerExcel Absolute Buffer;
 Number4Excel:NumberExcel Absolute Buffer;
 Font:DataSetInMemory;     { Pour la conversion de la police de caractŠres }
 Data:DataMGCIdRec;        { Enregistrement de donn‚es MGC }
 SpecialChar:Boolean;      { CaractŠre sp‚cial? }
 Value:Real Absolute Str;

 Procedure PutTimer;Begin
  _BackKbd;
  If GetRawTimerB and 1=0Then Begin
   If(T<>GetRawTimerB)Then Begin
    PutMemory;
    WEPutLastBar('Tableur, Chargement de la ligne: '+CStr(P));
    T:=GetRawTimerB;
   End;
  End;
 End;

Begin
 FillClr(Q,SizeOf(Q));
 COInit(Q.Column);
 CEInit(Q.Cellule);
 Q.BX1:=-1;
 Q.BY1:=-1;
 Q.BX2:=-1;
 Q.BY2:=-1;
 Q.Moved:=True;
 Q.MovedX:=True;
 Q.MovedY:=True;
 Q.HomeLine:=1;
 Case(Model)of
  3: Q.Mode:=3;
  Else Q.Mode:=2;
 End;
 WEInit(Q.W,X1,Y1,X2,Y2);
 OldActifScrn:=ActifScrSave;
 ActifScrSave:=False;
 _InitKbd;
 Ext:=Path2Ext(Path);
 Handle:=FileOpen(Path,fmRead);
 If(Handle<>errHdl)Then Begin
  FP:=0;FS:=FileSize(Handle);
  _GetAbsRec(Handle,0,SizeOf(Sign),Sign);
  If Sign='MGC'#26Then Begin
   Q.FormatMode:=tfMGC;FP:=4;
   Repeat
    _GetRec(Handle,SizeOf(Data),Data);
    Inc(FP,SizeOf(Data));
    If(Data.H.Format=cfColumn)Then Begin
     _GetRec(Handle,Data.Size,Q.Column.Curr.c);
     Q.Column.Curr.Column:=Data.Col;
     Q.Column.Curr.Header:=Data.H;
     COAdd(Q.Column);
     Inc(FP,Data.Size);
    End
     Else
    Begin
     FillClr(Q.Cellule.Curr,SizeOf(Q.Cellule.Curr));
     Q.Cellule.Curr.Column:=Data.Col;
     Q.Cellule.Curr.Row:=Data.Row;
     Q.Cellule.Curr.Header:=Data.H;
     If(Q.Cellule.Curr.Header.Format=cfValue)Then Q.Cellule.Curr.Data.v.Dec:=4;
     If(Q.Cellule.Curr.Header.Format=cfFormula)Then Begin
      _GetRec(Handle,Data.Size,Q.Cellule.Curr.Data.f.Formula);
      Q.Cellule.Curr.Data.f.Dec:=4;
     End
      Else
     _GetRec(Handle,Data.Size,Q.Cellule.Curr.Data);
     Inc(FP,Data.Size);
     Q.Cellule.Curr.Header.Format:=Q.Cellule.Curr.Header.Format and$7F;
     CEAdd(Q.Cellule);
    End;
   Until FP>=FS;
  End
   Else
  If(SignLotus.TypeCode=0)and(SignLotus.Length=2)Then Begin
   Q.FormatMode:=tfLotus;
   Repeat
    _GetAbsRec(Handle,FP,SizeOf(LabelLotus),LabelLotus);
    Case(LabelLotus.TypeCode)of
     13:Begin
      CEAddIntegerValue(Q.Cellule,IntegerLotus.Column,IntegerLotus.Row,IntegerLotus.Value);
     End;
     14:Begin
      CEAddRealValue(Q.Cellule,IntegerLotus.Column,IntegerLotus.Row,DoubleToReal(DoubleLotus.Value));
     End;
     15:Begin
      Str:=StrPas(@LabelLotus.Text);
      SpecialChar:=Str[1]in['''','^','"'];
      If(SpecialChar)Then Begin
       CEAddText(Q.Cellule,LabelLotus.Column,LabelLotus.Row,Copy(Str,2,255));
       PCel:=SCGetCellule(Q,Data.Col,Data.Row);
       If(PCel<>NIL)Then Case Str[1]of
        '''':PCel^.Header.Justify:=cLeft;
        '^':PCel^.Header.Justify:=cCenter;
        '"':PCel^.Header.Justify:=cRight;
       End;
      End
       Else
      CEAddText(Q.Cellule,LabelLotus.Column,LabelLotus.Row,Str);
     End;
    End;
    Inc(FP,LabelLotus.Length+4);
   Until FP>=FS;
  End
   Else
  If((SignExcel.TypeCode=$0209)and { Microsoft Excel 3.0 }
     (SignExcel.Length=6))or
     (SignExcel.TypeCode=$0009)Then Begin  { Microsoft Excel 2.1 }
   Q.FormatMode:=tfExcel;
   Repeat
    _GetAbsRec(Handle,FP,SizeOf(Label4Excel),Label4Excel);
    Case(SignExcel.TypeCode)of
     xltInteger:Begin
      CEAddIntegerValue(Q.Cellule,Integer4Excel.Column,Integer4Excel.Row,Integer4Excel.Value);
     End;
     xltNumber:Begin
      CEAddRealValue(Q.Cellule,Integer4Excel.Column,Integer4Excel.Row,DoubleToReal(Number4Excel.Value));
     End;
     xltLabel:Begin
      Str:=Label4Excel.Value;
      SpecialChar:=Str[1]in['''','^','"'];
      If(SpecialChar)Then Begin
       CEAddText(Q.Cellule,Label4Excel.Column,Label4Excel.Row,Copy(Str,2,255));
       PCel:=SCGetCellule(Q,Data.Col,Data.Row);
       If(PCel<>NIL)Then Case Str[1]of
        '''':PCel^.Header.Justify:=cLeft;
        '^':PCel^.Header.Justify:=cCenter;
        '"':PCel^.Header.Justify:=cRight;
       End;
      End
       Else
      CEAddText(Q.Cellule,Label4Excel.Column,Label4Excel.Row,Str);
     End;
{     Else Begin
      SignExcel.TypeCode:=SignExcel.TypeCode;
     End;}
    End;
    Inc(FP,Label4Excel.Length+4);
   Until FP>=FS;
  End
   Else
  If Ext='.HTM'Then Begin
   DBOpenServerName(ChantalServer,'CHANTAL:/Texte/Format/HTML2ASCII.Dat');
   If Not DBCopyToMemory(ChantalServer,Font)Then Begin
    __OutOfMemory;
    Exit;
   End;
   Q.FormatMode:=tfHTML;
   P:=0;Ix:=0;
   Repeat
    __GetAbsFileTxtLn(Handle,FP,Str);
    If GetSysErr<>0Then Begin
     GetSysErr:=errEdtRead;
     Break;
    End;
    I:=1;
    Repeat
     S2:='';
     SkipSpcInLn(I,Str);
     While Not(StrI(I,Str)in[#0,'<'])do Inc(I);
     If StrI(I,Str)='<'Then Inc(I);
     While Not(StrI(I,Str)in[#0,'>'])do Begin
      IncStr(S2,ChrUp(Str[I]));
      Inc(I);
     End;
     SkipSpcInLn(I,Str);
     If StrI(I,Str)='>'Then Inc(I);
     SkipSpcInLn(I,Str);
     If CmpLeft(S2,'/TR')Then Begin
      Inc(P);
      Ix:=0;
     End
      Else
     If CmpLeft(S2,'TD')Then Begin
      CurrAttribut:=-1;
      PP:=Pos('BGCOLOR=',S2);
      If PP>0Then Begin
       S2:=Copy(S2,PP+Length('BGCOLOR='),7);
       If S2[1]='#'Then S2:=Copy(S2,2,255);
       Color.R:=HexStrToInt(Copy(S2,1,2));
       Color.G:=HexStrToInt(Copy(S2,3,2));
       Color.B:=HexStrToInt(Copy(S2,5,2));
       For PP:=0to 15do Begin
        If(DefaultRGB[PP].R=Color.R)and(DefaultRGB[PP].G=Color.G)and
          (DefaultRGB[PP].B=Color.B)Then Begin
         CurrAttribut:=PP shl 4;
         Break;
        End;
       End;
      End;
      S2:='';
      While Not(StrI(I,Str)in[#0,'<'])do Begin
       If Str[I]='&'Then Begin
        S3:='';
        Inc(I);
        While Not(StrI(I,Str)in[#0,';'])do Begin
         IncStr(S3,Str[I]);
         Inc(I);
        End;
        If DBLocateAbsIM(Font,1,S3,[])Then IncStr(S2,Font.CurrRec.Char^)
       End
        Else
       IncStr(S2,Str[I]);
       Inc(I);
      End;
      If S2<>''Then Begin
       If S2[1]='='Then CEAddFormula(Q.Cellule,Ix,P,S2)
        Else
       Begin
        If IsRealNumber(S2)Then Begin
         System.Val(S2,R,Error);
         CEAddRealValue(Q.Cellule,Ix,P,R);
        End
         Else
        CEAddText(Q.Cellule,Ix,P,S2);
       End;
       If CurrAttribut<>-1Then Begin
        PCel:=SCGetCellule(Q,Ix,P);
        If(PCel<>NIL)Then PCel^.Header.Attribut:=CurrAttribut;
       End;
      End;
      Inc(Ix);
     End;
    Until I>=Length(Str);
    PutTimer;
   Until FP>=FS;
  End
   Else
  If Ext='.CSV'Then Begin
   Q.FormatMode:=tfCSV;
   P:=0;
   Repeat
    __GetAbsFileTxtLn(Handle,FP,Str);
    If GetSysErr<>0Then Begin
     GetSysErr:=errEdtRead;
     Break;
    End;
    I:=1;Ix:=0;
    Repeat
     S2:='';
     While Not(StrI(I,Str)in[#0,','])do Begin
      IncStr(S2,Str[I]);
      Inc(I)
     End;
     If StrI(I,Str)=','Then Inc(I);
     SkipSpcInLn(I,Str);
     If S2<>''Then Begin
      If S2[1]='='Then CEAddFormula(Q.Cellule,Ix,P,S2)
       Else
      If IsRealNumber(S2)Then Begin
       System.Val(S2,R,Error);
       CEAddRealValue(Q.Cellule,Ix,P,R);
      End
       Else
      CEAddText(Q.Cellule,Ix,P,S2);
     End;
     Inc(Ix);
    Until I>=Length(Str);
    Inc(P);
    PutTimer;
   Until FP>=FS;
  End
   Else
  If Ext='.LST'Then Begin
   Q.FormatMode:=tfASCII;
   P:=0;
   Repeat
    __GetAbsFileTxtLn(Handle,FP,Str);
    If GetSysErr<>0Then Begin
     GetSysErr:=errEdtRead;
     Break;
    End;
    I:=1;Ix:=0;
    Repeat
     S2:='';
     While Not(StrI(I,Str)in[#0,' '])do Begin
      IncStr(S2,Str[I]);
      Inc(I)
     End;
     SkipSpcInLn(I,Str);
     If S2<>''Then Begin
      If S2[1]='='Then CEAddFormula(Q.Cellule,Ix,P,S2)
       Else
      If IsNumber(S2)Then Begin
       System.Val(S2,R,Error);
       CEAddRealValue(Q.Cellule,Ix,P,R);
      End
       Else
      CEAddText(Q.Cellule,Ix,P,S2);
     End;
     Inc(Ix);
    Until I>=Length(Str);
    Inc(P);
    PutTimer;
   Until FP>=FS;
  End;
  FileClose(Handle);
 End;
 Q.FileName:=Path;
 SCRefresh(Q);
 ActifScrSave:=OldActifScrn;
End;

Procedure SCLoadClassic(Var Q;X1,Y1,X2,Y2:Byte;Const Path:String);Begin
 SCLoad(SuperCalcApp(Q),X1,Y1,X2,Y2,2,Path)
End;

END.