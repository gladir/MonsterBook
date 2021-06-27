{\Source\Chantal\Library\Compiler\C\C2Pas.Inc}

Const
 PathHeader='D:\BP\INCLUDE';
 {$IFDEF TABLEEXTENSION}
  ProcBuffer:Array[0..46,0..1]of PChar=(
   ('AcosAsin','[x{bits16}>d]d'),
   ('abs','[i]i'),
   ('acos','[d]d'),
   ('bdos','[BwB]i'),
   ('bdosptr','[B<B]i'),
   ('country_','[B>{COUNTRY}]{PCOUNTRY}'),
   ('bioscom','[BBi]i'),
   ('biosdisk','[BcBwB<]'),
   ('biosequip','[]i'),
   ('biosmemory','[]i'),
   ('biosprint','[BBi]b'),
   ('chdir','[x]i'),
   ('dosexterr','[>{DOSERROR}]i'),
   ('farcoreleft','[]l'),
   ('free','[>p]'),
   ('getcurdir','[cx]i]'),
   ('isalnum','[c]b'),
   ('isalpha','[c]b'),
   ('iscntrl','[c]b'),
   ('isdigit','[c]b'),
   ('islower','[c]b'),
   ('isprint','[c]b'),
   ('ispunct','[c]b'),
   ('isspace','[c]b'),
   ('isupper','[c]b'),
   ('isxdigit','[c]b'),
   ('lock','[ill]i'),
   ('malloc','[w]p'),
   ('memchr','[<xw]b'),
   ('memcpy','[<<w]'),
   ('setftime','[i>{ftime}]i'),
   ('strupr','[x]x'),
   ('swab','[>B>Bi]'),
   ('toascii','[c]c'),
   ('tolower','[c]c'),
   ('toupper','[c]c'),
   ('Funlink','[x]i'),
   ('Funlock','[ill]i'),
   ('_chmod','[xBi]i'),
   ('_clear87','[]w'),
   ('_control87','[ww]w'),
   ('_dos_getftime','[i>w>w]w'),
   ('_dos_read','[i<w>w]w'),
   ('_dos_setftime','[iww]w'),
   ('_status87','[]w'),
   ('F_tolower','[c]c'),
   ('_toupper','[c]c'));
  {$ENDIF}

Type
 BooleanDirectivePtr=^BooleanDirectiveRecord;
 BooleanDirectiveRecord=Record
  Name:PChr;
  Value:Boolean;
 End;

Function BDAdd(Var Inf:ArrayList;Const Name:String;Value:Boolean):Boolean;Forward;
Function BDSearchValue(Var Inf:ArrayList;Const Name:String):Boolean;Forward;
Function BWWordExist(Var Inf:ArrayList;Const Name:String):Boolean;Forward;

Type
 BankVarPtr=^BankVarRec;
 BankVarRec=Record
  Name,TypeVar:PChr;
  Previous,Next:BankVarPtr;
 End;

 BankVar=Record
  List,EndList:BankVarPtr;
 End;

 SwitchC2Pascal=Record
  HandleC:Text;
  HandlePas:Hdl;
  NameC,PathHeader,Output:String;
  L:LongInt;
  I:Byte;
  WarPos:Byte;
  Mode:ModeType;
  Warning:Array[Byte]of Record
   Line:Word;
   War:Integer;
  End;
  SourceName:String;
  Line:String;
  BoolDir:ArrayList;
  SYS_Types,StdDef:Boolean;
  WarningMsg,Rem:Boolean;
  CondIf,OvrEndIf:Byte;
  Beg:Word;
  {$IFNDEF CONSOLE}
   W:Window;
  {$ENDIF}
 End;

 PackProcPtr=^PackProcRecord;
 PackProcRecord=Record
  Name:PChr;
  Func:Boolean;
  FuncType:PChr;
  Previous,Next:PackProcPtr;
 End;

 PackProc=Record
  List:PackProcPtr;
  EndList:PackProcPtr;
 End;

Var
 {$IFDEF TABLEEXTENSION}
  LineNum:LongInt;
 {$ENDIF}
 WarnNum:LongInt;

Procedure BVInit(Var Q:BankVar);Near;Forward;
Function  BVAdd(Var Q:BankVar;Const Name,TypeVar:String):Boolean;Near;Forward;
Function  BVWordExist(Var Q:BankVar;Const Name:String):Boolean;Near;Forward;
Function  BVGetMaxWord(Var Q:BankVar):Integer;Near;Forward;
Procedure BVGetWord(Var Q:BankVar;N:Word;Var Name,TypeVar:String);Near;Forward;
Procedure BVDone(Var Q:BankVar);Near;Forward;
Procedure PPInit(Var K:PackProc);Near;Forward;
Procedure PPPushProc(Var K:PackProc;Q:SwitchC2Pascal;Const Name:String);Near;Forward;
Procedure PPPushFunc(Var K:PackProc;Q:SwitchC2Pascal;Const Name:String;FuncType:String);Near;Forward;
Function  PPGetLastProcName(Var K:PackProc):String;Near;Forward;
Procedure PPDone(Var K:PackProc);Near;Forward;

{$IFNDEF CONSOLE}
 Procedure PutInfo(Var Q:SwitchC2Pascal);Begin
  Q.W.Y:=2;
  WEPutTxtLn(Q.W,'Programme principal            = '+Path2NoDir(Q.SourceName));
  WEPutTxtLn(Q.W,'Source courante                = '+Path2NoDir(Q.NameC));
  WEPutTxtLn(Q.W,'Nom du source de sortie        = '+Path2Name(Q.SourceName)+'.PAS');
  WEPutTxtLn(Q.W,'Nombre de ligne(s) compil‚     = '+CStr(Q.L));
  WEPutTxtLn(Q.W,'Nombre de messages d''Attention = '+CStr(Q.WarPos));
  WEPutTxtLn(Q.W,'Nombre directive conditionnel  = '+CStr(Q.BoolDir.Count));
  WEPutTxtLn(Q.W,'Position de bloc               = '+CStr(Q.Beg));
  WEPutTxtLn(Q.W,'M‚moire disponible en octet(s) = '+CStr(MemAvail));
  WEPutTxtLn(Q.W,'Temps de compilation           = '+GetStrTimeInPrg);
 End;
{$ENDIF}

Function BDAdd;
Var
 Ptr:Pointer;
 BMC:BooleanDirectiveRecord;
 PName:PChr;
Begin
 BDAdd:=False; PName:=MemAlloc(Length(Name)+1);
 If(PName=NIL)Then Exit;
 StrPCopy(PName,Name);BMC.Name:=PName;BMC.Value:=Value;
 Ptr:=ALAdd(Inf,SizeOf(BMC));
 If(Ptr=NIL)Then Exit;
 MoveLeft(BMC,Ptr^,SizeOf(BMC));
 BDAdd:=True;
End;

Function BDSearchValue;
Var
 TMC:BooleanDirectivePtr;
 I:LongInt;
Begin
 BDSearchValue:=False;
 For I:=0to ALMax(Inf)do Begin
  TMC:=_ALGetBuf(Inf,I);
  If(StrPas(TMC^.Name)=Name)Then Begin
   BDSearchValue:=TMC^.Value;
   Exit;
  End;
 End;
End;

Function BWWordExist;
Var
 I:LongInt;
 S:PChr;
Begin
 BWWordExist:=False;
 For I:=0to ALMax(Inf)do Begin
  S:=_ALGetBuf(Inf,I);
  If Name=StrPas(S)Then Begin
   BWWordExist:=True;
   Exit;
  End;
 End;
End;

Procedure BVInit;Begin
 FillClr(Q,SizeOf(Q));
End;

Function BVAdd;
Var
 PBV:BankVarPtr;
 BV:BankVarRec;
 PName,PTypeVar:PChr;
Begin
 BVAdd:=False;
 PName:=MemAlloc(Length(Name)+1);
 If(PName=NIL)Then Exit;
 StrPCopy(PName,Name);
 BV.Name:=PName; PTypeVar:=MemAlloc(Length(TypeVar)+1);
 If(PTypeVar=NIL)Then Exit;
 StrPCopy(PTypeVar,TypeVar);
 BV.TypeVar:=PTypeVar;
 BV.Previous:=NIL;
 BV.Next:=NIL;
 PBV:=Q.List;
 If(PBV<>NIL)Then Begin
  While(PBV^.Next<>NIL)do PBV:=PBV^.Next;
  BV.Previous:=PBV;
  PBV^.Next:=MemAlloc(SizeOf(Q.List^));
  Q.EndList:=PBV^.Next;
  If(PBV^.Next=NIL)Then Exit;
  Move(BV,PBV^.Next^,SizeOf(Q.List^));
 End
  Else
 Begin
  PBV:=MemAlloc(SizeOf(Q.List^));
  If(PBV=NIL)Then Exit;
  Q.List:=PBV;
  Q.EndList:=Q.List;
  Move(BV,PBV^,SizeOf(Q.List^));
 End;
 BVAdd:=True;
End;

Function BVWordExist;
Var
 BV:BankVarPtr;
Begin
 BVWordExist:=False;
 BV:=Q.EndList;
 If(StrPas(Q.EndList^.Name)=Name)Then BVWordExist:=True
  Else
 Begin
  While(BV^.Previous<>NIL)do Begin
   BV:=BV^.Previous;
   If Name=StrPas(BV^.Name)Then Begin
    BVWordExist:=True;
    Exit;
   End;
  End;
 End;
End;

Function BVGetMaxWord;
Var
 I:Integer;
 BV:BankVarPtr;
Begin
 I:=0;BV:=Q.List;
 While(BV<>NIL)do Begin
  Inc(I);
  BV:=BV^.Next;
 End;
 Dec(I);
 BVGetMaxWord:=I
End;

Procedure BVGetWord;
Var
 I:Word;
 BV:BankVarPtr;
Begin
 Name:='';
 TypeVar:='';
 If(Q.List=NIL)Then Exit;
 I:=0; BV:=Q.List;
 If N>0Then For I:=1to(N)do BV:=BV^.Next;
 Name:=StrPas(BV^.Name);
 TypeVar:=StrPas(BV^.TypeVar)
End;

Procedure BVDone;Begin
End;

Function CommentC2Pascal(Var Info:SwitchC2Pascal;Put:Boolean):Boolean;Forward;
Function ExtractLine(Var I:Byte;Var Line:String;Var Handle:Text;Var L:LongInt):Boolean;Forward;
Function SkipSpcRem(Var Info:SwitchC2Pascal;Put:Boolean):Boolean;Forward;
Function VarC2Pas(Str:String;Signed:Boolean):String;Forward;

Function FormuleC2Pascal(Var Info:SwitchC2Pascal;Put:Boolean):Integer;
Var
 Open:Word;
 Ok:Boolean;
 Str,WordC:String;
 BufDec:ArrayList;
 I:Word;
 Ptr:Boolean;
Begin
 FormuleC2Pascal:=0;
 If Info.Line[Info.I]<>'('Then Begin
  FormuleC2Pascal:=OpenParExpected;
  Exit; (* '(' expected. *)
 End;
 ALInit(BufDec);
 Open:=0;
 Repeat
  Case Info.Line[Info.I]of
   '(':Inc(Open);
   ')':Dec(Open);
  End;
  If(Put)Then PutFileTxt(Info.HandlePas,Info.Line[Info.I]);
  Inc(Info.I);
  If Open>0Then Begin
   While Info.I>Length(Info.Line)do Begin
    If EOF(Info.HandleC)Then Exit;
    If(Put)Then PutFileLn(Info.HandlePAS);
    If Not(ExtractLine(Info.I,Info.Line,Info.HandleC,Info.L))Then Begin
     FormuleC2Pascal:=EndOfSourceExpected;
     Exit;
    End;
   End;
  End;
  Case Info.Line[Info.I]of
   '0':Begin
    Str:=XtrkCNm2Pas(Info.I,Info.Line);
    PutFileTxt(Info.HandlePas,Str);
   End;
   '-':Begin
    Case Info.Line[Info.I+1]of
     '>':Begin
      Inc(Info.I,Length('->'));
      PutFileTxt(Info.HandlePas,'.');
     End;
     '-':Begin
      Inc(Info.I,Length('--'));Ptr:=False;WordC:='';
      If Info.Line[Info.I]='('Then Begin
       Inc(Info.I,Length('('));
       If Info.Line[Info.I]='*'Then Begin
        Inc(Info.I,Length('*'));
        Ptr:=True;
       End;
       While Info.Line[Info.I]<>')'do Begin
        IncStr(WordC,Info.Line[Info.I]);Inc(Info.I);
       End;
       Inc(Info.I,Length(')'));
      End;
      AddStr(WordC,XtrkWord(Info.I,Info.Line));
      While(Info.Line[Info.I]='-')and(Info.Line[Info.I+1]='>')do Begin
       Inc(Info.I,Length('->'));
       AddStr(WordC,'.'+XtrkWord(Info.I,Info.Line));
      End;
      If(Ptr)Then ALAddStr(BufDec,WordC+'^')Else ALAddStr(BufDec,WordC);
      PutFileTxt(Info.HandlePas,WordC);
     End;
    End;
   End;
   '&','|':If Open>0Then Begin
    Ok:=False;
    Case Info.Line[Info.I]of
     '&':PutFileTxt(Info.HandlePas,' and ');
     '|':PutFileTxt(Info.HandlePas,' or ');
    End;
    Inc(Info.I);
    While Info.I>Length(Info.Line)do Begin
     If EOF(Info.HandleC)Then Exit;
     If(Put)Then PutFileLn(Info.HandlePas);
     If Not(ExtractLine(Info.I,Info.Line,Info.HandleC,Info.L))Then Begin
      FormuleC2Pascal:=EndOfSourceExpected;
      Exit; (* Fin du source attendu. *)
     End;
    End;
   End;
   Else Ok:=Open=0;
  End;
 Until Ok;
 If Not(ALIsEmpty(BufDec))Then Begin
  PutFileTxtLn(Info.HandlePas,';');
  PutFileTxt(Info.HandlePas,Spc(1));
  For I:=0to ALMax(BufDec)do
   PutFileTxtLn(Info.HandlePas,' Dec('+_ALGetStr(BufDec,I)+');');
 End;
End;

Function SkipSpc(Var Info:SwitchC2Pascal;Put:Boolean):Boolean;Begin
 SkipSpc:=False;
 While Info.I>Length(Info.Line)do Begin
  If EOF(Info.HandleC)Then Exit;
  If(Put)Then PutFileLn(Info.HandlePas);
  If Not(ExtractLine(Info.I,Info.Line,Info.HandleC,Info.L))Then Exit;
 End;
 While Info.Line[Info.I]in[' ',#9]do Begin
  If(Put)Then PutFileTxt(Info.HandlePas,Info.Line[Info.I]);
  Inc(Info.I);
  While Info.I>Length(Info.Line)do Begin
   If(EOF(Info.HandleC))Then Exit;
   If(Put)Then PutFileLn(Info.HandlePas);
   If Not(ExtractLine(Info.I,Info.Line,Info.HandleC,Info.L))Then Exit;
  End;
 End;
 SkipSpc:=True;
End;

Function CondC2Pascal(Var Info:SwitchC2Pascal):Integer;
Var
 WordC,UWordC,Msg,Arg,Str:String;
 Value,Par:Integer;
 Defined,EndMissing:Boolean;
 D:DirStr;
 N:NameStr;
 E:ExtStr;
 J:Byte;

 Procedure _And;Begin
  If Info.Line[Info.I]='&'Then Begin
   Inc(Info.I);
   If Info.Line[Info.I]='&'Then Inc(Info.I);
   PutFileTxt(Info.HandlePAS,' and ');
  End;
 End;

 Procedure _Or;Begin
  If Info.Line[Info.I]='|'Then Begin
   Inc(Info.I);
   If Info.Line[Info.I]='|'Then Inc(Info.I);
   PutFileTxt(Info.HandlePAS,' or ');
  End;
 End;

 Procedure _Shl;Begin
  If(Info.Line[Info.I]='<')and(Info.Line[Info.I+1]='<')Then Begin
   Inc(Info.I,Length('<<'));
   PutFileTxt(Info.HandlePAS,' shl ');
  End
   Else
  Begin
   PutFileTxt(Info.HandlePAS,'<');
   Inc(Info.I);
  End;
 End;

 Procedure _Shr;Begin
  If(Info.Line[Info.I]='>')and(Info.Line[Info.I+1]='>')Then Begin
   Inc(Info.I,Length('>>'));
   PutFileTxt(Info.HandlePAS,' shr ');
  End
   Else
  Begin
   PutFileTxt(Info.HandlePAS,'>');
   Inc(Info.I);
  End;
 End;

 Function DumpEnd:Integer;Var TStr:String;Begin
  DumpEnd:=0;
  While Info.I<=Length(Info.Line)do Begin
   Case Info.Line[Info.I]of
    '/': If Not(CommentC2Pascal(Info,True))Then Begin
     DumpEnd:=EndOfCommentExpected;
     Exit;
    End;
    '<':_Shl;
    '>':_Shr;
    '|':_Or;
    '&':_And;
    '-':Begin
     Inc(Info.I);
     Case Info.Line[Info.I]of
      '>':Begin
       PutFileTxt(Info.HandlePAS,'.');
       Inc(Info.I);
      End;
       Else
      PutFileTxt(Info.HandlePAS,'-');
     End;
    End;
    '0':Begin
     TStr:=XtrkCNm2Pas(Info.I,Info.Line);
     If TStr<>''Then PutFileTxt(Info.HandlePAS,TStr)
      Else
     Begin
      PutFileTxt(Info.HandlePAS,Info.Line[Info.I]);
      Inc(Info.I);
     End;
    End;
    Else Begin
     PutFileTxt(Info.HandlePAS,Info.Line[Info.I]);
     Inc(Info.I);
    End;
   End;
  End;
 End;

Begin
 CondC2Pascal:=NumExpected;
 If Info.Line[Info.I]<>'#'Then Exit;
 Inc(Info.I);
 If Not(IinStr(Info.I,Info.Line))Then Begin
  CondC2Pascal:=DirectiveCommandExpected;
  Exit;
 End;
 SkipSpc(Info,True);
 WordC:=XtrkWord(Info.I,Info.Line);UWordC:=StrUp(WordC);
 {* * * * * * * * * * * * * * * * * * * * * * * * *}
 {*                     DEFINE                    *}
 {* * * * * * * * * * * * * * * * * * * * * * * * *}
 If UWordC='DEFINE'Then Begin
  SkipSpcInLn(Info.I,Info.Line);
  WordC:=XtrkWord(Info.I,Info.Line);
  If StrUp(WordC)='SIZEOF'Then Begin{ Execption ? }
   Info.Warning[Info.WarPos].War:=SkipDefineSizeOf;
   Info.Warning[Info.WarPos].Line:=Info.L;
   If Info.WarPos=255Then Begin
    CondC2Pascal:=TooManyWarning;
    Exit;
   End
    Else
   Inc(Info.WarPos);
   SkipSpcInLn(Info.I,Info.Line);
   WordC:=XtrkWord(Info.I,Info.Line);
   If(IinStr(Info.I,Info.Line))and(Info.Line[Info.I]='(')Then Begin{ Function ? }
    Inc(Info.I);
    While Info.Line[Info.I]<>')'do Begin
     Inc(Info.I);
     If Not(IinStr(Info.I,Info.Line))Then Begin
      CondC2Pascal:=EndOfFunctionExpected;
      Exit;
     End;
    End;
    Inc(Info.I);
    SkipSpcRem(Info,False);
    If(IsLangChrWord(Info.Line[Info.I]))Then XtrkWord(Info.I,Info.Line);
    Value:=FormuleC2Pascal(Info,False);
    If Value<0Then Begin
     CondC2Pascal:=Value;
     Exit;
    End;
   End
    Else
   Begin
    CondC2Pascal:=SyntaxError;
    Exit;
   End;
  End
   Else
  If(IinStr(Info.I,Info.Line))and(Info.Line[Info.I]='(')Then Begin{ Function ? }
   Info.Mode:=_None_;
   PutFileTxt(Info.HandlePAS,'Function '+WordC+'(');
   Inc(Info.I,Length('('));
   Arg:='';
   While Info.Line[Info.I]<>')'do Begin
    IncStr(Arg,Info.Line[Info.I]);
    PutFileTxt(Info.HandlePAS,Info.Line[Info.I]);
    Inc(Info.I);
    If Not(IinStr(Info.I,Info.Line))Then Begin
     CondC2Pascal:=EndOfFunctionExpected;
     Exit;
    End;
   End;
   Inc(Info.I,Length(')'));
   SkipSpcRem(Info,False);
   If IsLangChrWord(Info.Line[Info.I])Then Begin
    PutFileTxtLn(Info.HandlePAS,':?):?;');
    PutFileTxtLn(Info.HandlePAS,'Begin');
    Str:=XtrkWord(Info.I,Info.Line);
    If AutoUp(Str)=AutoUp(Arg)Then Begin
     PutFileTxtLn(Info.HandlePas,' '+WordC+' := '+Arg+';');
     PutFileTxtLn(Info.HandlePas,'End;');
     CondC2Pascal:=0;
     Exit;
    End;
    If AutoUp(Str)=AutoUp('do')Then Begin
     PutFileTxtLn(Info.HandlePAS,' Repeat');
     PutFileTxt(Info.HandlePAS,' ');
     SkipSpcRem(Info,True);
     If Info.Line[Info.I]='{'Then Begin
      Inc(Info.I,Length('{'));
      Repeat
       SkipSpcRem(Info,True);
       Str:=XtrkWord(Info.I,Info.Line);
       If Str=''Then Begin
        CondC2Pascal:=SyntaxError;
        Exit;
       End;
       PutFileTxt(Info.HandlePAS,Str);
       SkipSpcRem(Info,True);
       If Info.Line[Info.I]=';'Then Begin
	Inc(Info.I,Length(';'));
	SkipSpcRem(Info,True);
       End;
      Until Info.Line[Info.I]='}';
      Inc(Info.I,Length('}'));
      SkipSpcRem(Info,True);
      Str:=XtrkWord(Info.I,Info.Line);
      If AutoUp(Str)=AutoUp('while')Then Begin
       SkipSpcRem(Info,True);
       Par:=1;
       PutFileLn(Info.HandlePas);
       PutFileTxt(Info.HandlePas,' Until (');
       Inc(Info.I,Length('('));
       If(Info.Line[Info.I]='0')and(Info.Line[Info.I+1]=')')Then Begin
	Inc(Info.I,Length('0)'));
	PutFileTxt(Info.HandlePas,'False)');
       End
	Else
       While Par>0do Begin
	SkipSpcRem(Info,False);
	Case Info.Line[Info.I]of
	 '(': Inc(Par);
	 ')': Dec(Par);
	End;
	PutFileTxt(Info.HandlePAS,Info.Line[Info.I]);
	Inc(Info.I);
       End;
       PutFileTxt(Info.HandlePas,';');
       PutFileTxt(Info.HandlePas,'End;');
       CondC2Pascal:=0;
       Exit;
      End
       Else
      Begin
       CondC2Pascal:=whileExpected; {"while" expected.}
       Exit;
      End;
     End
      Else
     Begin
      CondC2Pascal:=OpenEnsExpected; {'{' expected.}
      Exit;
     End;
    End
     else
    PutFileTxt(Info.HandlePAS,' '+Str);
    SkipSpcRem(Info,False);
   End
    Else
   Begin
    PutFileTxtLn(Info.HandlePAS,':LongInt):LongInt;');
    PutFileTxtLn(Info.HandlePAS,'Begin');
    PutFileTxt(Info.HandlePAS,' '+WordC+' := ');
   End;
   Value:=FormuleC2Pascal(Info,True);
   If Value<0Then Begin
    CondC2Pascal:=Value;
    Exit;
   End;
   SkipSpcRem(Info,False);
   If(IsLangChrWord(Info.Line[Info.I]))Then Begin
    J:=Info.I; Str:=XtrkWord(Info.I,Info.Line);
    If Pos(Str,Arg)>0Then PutFileTxt(Info.HandlePAS,Str)
                     Else Info.I:=J;
   End;
   If(Info.Line[Info.I]='(')and(Info.Line[Info.I+1]=')')Then Begin
    Inc(Info.I,Length('()'));
    PutFileTxt(Info.HandlePAS,'()');
   End;
   If Info.I>1Then PutFileTxtLn(Info.HandlePas,';');
   PutFileTxtLn(Info.HandlePAS,'End;');
   PutFileLn(Info.HandlePas);
  End
   Else
  Begin
   SkipSpcInLn(Info.I,Info.Line);
   If Not(IinStr(Info.I,Info.Line))Then Begin
    If BDSearchValue(Info.BoolDir,WordC)Then Begin
     Info.Warning[Info.WarPos].War:=DuplicateDefineSymbol; { Duplicate define symbol. }
     Info.Warning[Info.WarPos].Line:=Info.L;
     If Info.WarPos=255Then Begin
      CondC2Pascal:=TooManyWarning;
      Exit;
     End
      Else
     Inc(Info.WarPos);
    End;
    PutFileTxtLn(Info.HandlePAS,Spc(Info.CondIf)+'{$DEFINE '+WordC+'}');
    BDAdd(Info.BoolDir,WordC,True);
   End
    Else
   Case Info.Line[Info.I]of
    '(':Begin
     PutFileTxtLn(Info.HandlePAS,'Function '+WordC+':LongInt;');
     PutFileTxtLn(Info.HandlePAS,'Begin');
     PutFileTxt(Info.HandlePAS,' '+WordC+':=');
     SkipSpcInLn(Info.I,Info.Line);
     Value:=FormuleC2Pascal(Info,True);
     If Value<0Then Begin
      CondC2Pascal:=Value;
      Exit;
     End;
     PutFileTxtLn(Info.HandlePAS,';');
     Info.I:=Length(Info.Line)+1;
     PutFileTxtLn(Info.HandlePAS,'End;');
     Info.Mode:=_None_;
    End;
    'A'..'Z','a'..'z','_':Begin
     Msg:=XtrkWord(Info.I,Info.Line);
     If(StrUp(WordC)='FAR')and(StrUp(Msg)='FAR')Then Begin
      Info.Warning[Info.WarPos].War:=SkipDefineFar; { Skip define "far". }
      Info.Warning[Info.WarPos].Line:=Info.L;
      If Info.WarPos=255Then Begin
       CondC2Pascal:=TooManyWarning;
       Exit;
      End
       Else
      Inc(Info.WarPos)
     End
      Else
     Begin
      If(Info.Mode<>_Const_)Then Begin
       PutFileTxtLn(Info.HandlePAS,'Const');
       PutFileLn(Info.HandlePAS);
      End;
      PutFileTxt(Info.HandlePAS,Spc(6)+WordC+' = '+Msg+';');
      Info.Mode:=_Const_;
     End;
    End;
    '0'..'9':Begin
     Msg:=XtrkCNm2Pas(Info.I,Info.Line);
     If(Info.Mode<>_Const_)Then Begin
      PutFileTxtLn(Info.HandlePAS,'Const');
      PutFileLn(Info.HandlePAS);
     End;
     PutFileTxt(Info.HandlePAS,Spc(6)+WordC+' = '+Msg+';');
     Info.Mode:=_Const_;
    End;
    Else Begin
     If BDSearchValue(Info.BoolDir,WordC)Then Begin
      Info.Warning[Info.WarPos].War:=DuplicateDefineSymbol; { Duplicate define symbol. }
      Info.Warning[Info.WarPos].Line:=Info.L;
      If Info.WarPos=255Then Begin
       CondC2Pascal:=TooManyWarning;
       Exit;
      End
       Else
      Inc(Info.WarPos)
     End;
     PutFileTxtLn(Info.HandlePAS,Spc(Info.CondIf)+'{$DEFINE '+WordC+'}');
     BDAdd(Info.BoolDir,WordC,True);
    End;
   End;
  End;
 End
  Else
 {* * * * * * * * * * * * * * * * * * * * * * * * *}
 {*                      ELIF                     *}
 {* * * * * * * * * * * * * * * * * * * * * * * * *}
 If UWordC='ELIF'Then Begin
  Inc(Info.OvrEndIf);
  PutFileTxtLn(Info.HandlePAS,Spc(Info.CondIf-1)+'{$ELSE}');
  Inc(Info.CondIf);
  Info.Mode:=_None_;
  SkipSpc(Info,True);
  WordC:=StrUp(XtrkWord(Info.I,Info.Line));
  Defined:=False;
  If WordC=''Then Begin
   If Info.Line[Info.I]='!'Then Begin
    Inc(Info.I); WordC:=StrUp(XtrkWord(Info.I,Info.Line));
    If WordC='DEFINED'Then Begin
     If Info.Line[Info.I]='('Then Begin
      Inc(Info.I,Length('('));
      SkipSpc(Info,True);
      WordC:=XtrkWord(Info.I,Info.Line);
     End
      Else
     Begin
      CondC2Pascal:=OpenParExpected; { '(' expected. }
      Exit;
     End;
     Defined:=True;
    End;
    If WordC=''Then Begin
     CondC2Pascal:=IfDirectNameExpected;
     Exit; { "if" directive name expected. }
    End;
    PutFileTxt(Info.HandlePAS,Spc(Info.CondIf)+'{$IFNDEF '+WordC);
   End;
  End
   Else
  Begin
   If WordC='DEFINED'Then
   Case Info.Line[Info.I]of
    '(':Begin
     Inc(Info.I,Length('('));
     SkipSpc(Info,True);
     WordC:=XtrkWord(Info.I,Info.Line); Defined:=True;
    End;
    ';':Begin
     CondC2Pascal:=MisplacedPointComma; { Misplaced ';'. }
     Exit;
    End;
    Else Begin
     CondC2Pascal:=OpenParExpected; { '(' expected.  }
     Exit;
    End;
   End;
   PutFileTxt(Info.HandlePAS,Spc(Info.CondIf)+'{$IFDEF'+WordC);
  End;
  If(Defined)Then Begin
   SkipSpc(Info,True);
   If Info.Line[Info.I]<>')'Then Begin
    CondC2Pascal:=CloseParExpected; { ')' expected. }
    Exit;
   End;
   Inc(Info.I,Length(')'));
  End;
  Inc(Info.CondIf);
  DumpEnd;
  PutFileTxt(Info.HandlePAS,'}');
 End
  Else
 {* * * * * * * * * * * * * * * * * * * * * * * * *}
 {*                      ELSE                     *}
 {* * * * * * * * * * * * * * * * * * * * * * * * *}
 If UWordC='ELSE'Then Begin
  Info.Mode:=_None_;
  If Info.CondIf=0Then Begin
   CondC2Pascal:=MisplacedCondDirective;
   Exit; { Misplaced conditional directive. }
  End;
  PutFileTxt(Info.HandlePAS,Spc(Info.CondIf-1+Info.OvrEndIf)+'{$ELSE}');
 End
  else
 {* * * * * * * * * * * * * * * * * * * * * * * * *}
 {*                      ENDIF                    *}
 {* * * * * * * * * * * * * * * * * * * * * * * * *}
 If UWordC='ENDIF'Then Begin
  Info.Mode:=_None_;
  If Info.CondIf>0Then Begin
   Dec(Info.CondIf);
   PutFileTxt(Info.HandlePAS,Spc(Info.CondIf)+'{$ENDIF}');
   While Info.OvrEndIf>0do Begin
    PutFileLn(Info.HandlePAS);
    PutFileTxt(Info.HandlePAS,Spc(Info.CondIf+Info.OvrEndIf)+'{$ENDIF}');
    Dec(Info.OvrEndIf);
   End;
  End
   Else
  Begin
   CondC2Pascal:=MisplacedCondDirective;
   Exit; { Misplaced conditional directive. }
  End;
 End
  else
 {* * * * * * * * * * * * * * * * * * * * * * * * *}
 {*                    ERROR                      *}
 {* * * * * * * * * * * * * * * * * * * * * * * * *}
 If UWordC='ERROR'Then Begin
  PutFileTxt(Info.HandlePAS,Spc(Info.CondIf)+'''Erreur: '+Copy(Info.Line,Info.I,255)+'''');
  Info.I:=Length(Info.Line)+1;
 End
  Else
 {* * * * * * * * * * * * * * * * * * * * * * * * *}
 {*                        IF                     *}
 {* * * * * * * * * * * * * * * * * * * * * * * * *}
 If UWordC='IF'Then Begin
  Info.Mode:=_None_;
  SkipSpc(Info,True);
  WordC:=StrUp(XtrkWord(Info.I,Info.Line)); Defined:=False;
  If WordC=''Then Begin
   If Info.Line[Info.I]='!'Then Begin
    Inc(Info.I); WordC:=StrUp(XtrkWord(Info.I,Info.Line));
    If WordC='DEFINED'Then Begin
     Case Info.Line[Info.I]of
      '(':Begin
       Inc(Info.I,Length('('));
       SkipSpc(Info,True);
       WordC:=XtrkWord(Info.I,Info.Line);
      End;
      ';':Begin
       CondC2Pascal:=MisplacedPointComma;
       Exit; { Misplaced ';'. }
      End;
      Else Begin
       CondC2Pascal:=OpenParExpected;
       Exit; { '(' expected.  }
      End;
     End;
     Defined:=True;
    End;
    If WordC=''Then Begin
     CondC2Pascal:=IfDirectNameExpected;
     Exit;
    End;
    If WordC='_Windows'Then WordC:='WINDOWS'; { C/C++ -> _Windows: Pascal -> WINDOWS }
    PutFileTxt(Info.HandlePAS,Spc(Info.CondIf)+'{$IFNDEF'+Spc(1)+WordC);
   End
    else
   Begin
    CondC2Pascal:=SyntaxError;
    Exit;
   End;
  End
   Else
  Begin
   If WordC='DEFINED'Then Begin
    If Info.Line[Info.I]='('Then Begin
     Inc(Info.I,Length('('));
     SkipSpc(Info,True);
     WordC:=XtrkWord(Info.I,Info.Line);
     Defined:=True;
    End;
   End;
   If WordC='_Windows'Then WordC:='WINDOWS'; { C/C++ -> _Windows: Pascal -> WINDOWS }
   PutFileTxt(Info.HandlePAS,Spc(Info.CondIf)+'{$IFDEF'+Spc(1)+WordC);
  End;
  If(Defined)Then Begin
   SkipSpc(Info,True);
   If Info.Line[Info.I]<>')'Then Begin
    CondC2Pascal:=CloseParExpected; { ')' expected. }
    Exit;
   End;
   Inc(Info.I,Length(')'));
  End;
  Inc(Info.CondIf); Value:=DumpEnd;
  If Value<0Then Begin
   CondC2Pascal:=Value;
   Exit;
  End;
  PutFileTxt(Info.HandlePAS,'}');
 End
  Else
 {* * * * * * * * * * * * * * * * * * * * * * * * *}
 {*                      IFDEF                    *}
 {* * * * * * * * * * * * * * * * * * * * * * * * *}
 If UWordC='IFDEF'Then Begin
  Info.Mode:=_None_;
  PutFileTxt(Info.HandlePAS,Spc(Info.CondIf)+'{$IFDEF');
  Inc(Info.CondIf);
  SkipSpc(Info,True);
  WordC:=XtrkWord(Info.I,Info.Line);
  If WordC=''Then Begin
   CondC2Pascal:=IfDefDirectNameExpected;
   Exit; { "ifdef" directive name expected. }
  End;
  If WordC='_Windows'Then WordC:='WINDOWS'; { C/C++ -> _Windows: Pascal -> WINDOWS }
  PutFileTxt(Info.HandlePAS,WordC+'}');
 End
  Else
 {* * * * * * * * * * * * * * * * * * * * * * * * *}
 {*                     IFNDEF                    *}
 {* * * * * * * * * * * * * * * * * * * * * * * * *}
 If UWordC='IFNDEF'Then Begin
  Info.Mode:=_None_;
  PutFileTxt(Info.HandlePAS,Spc(Info.CondIf+Info.OvrEndIf)+'{$IFNDEF');
  Inc(Info.CondIf);
  SkipSpc(Info,True);
  WordC:=XtrkWord(Info.I,Info.Line);
  If WordC=''Then Begin
   CondC2Pascal:=IfNDefDirectNameExpected;
   Exit; { "ifndef" directive name expected. }
  End;
  PutFileTxt(Info.HandlePAS,WordC+'}');
 End
  Else
 {* * * * * * * * * * * * * * * * * * * * * * * * *}
 {*                     INCLUDE                   *}
 {* * * * * * * * * * * * * * * * * * * * * * * * *}
 If UWordC='INCLUDE'Then Begin
  SkipSpc(Info,False);
  Case Info.Line[Info.I]of
   '<':Begin
    EndMissing:=False;Inc(Info.I);WordC:='';
    While Info.Line[Info.I]<>'>'do Begin
     IncStr(WordC,Info.Line[Info.I]); Inc(Info.I);
     If Not(IinStr(Info.I,Info.Line))Then Begin
      CondC2Pascal:=GrExpected;
      Exit; { '>' expected. }
     End;
    End;
   End;
   '"':WordC:=XtrkCStr(Info.I,Info.Line,EndMissing);
   Else Begin
    CondC2Pascal:=IncludeFileNameExpected;
    Exit;
   End;
  End;
  If(EndMissing)Then Begin
   CondC2Pascal:=EndOfStringExpected;
   Exit;
  End;
  UWordC:=StrUp(WordC);
  If(UWordC='SYS\TYPES.H')or(UWordC='SYS/TYPES.H')Then Begin
   If Not(Info.SYS_Types)Then Begin
    PutFileTxtLn(Info.HandlePAS,'Type Time_T=LongInt;{Type C/C++ pour l''heure.}');
    Info.SYS_Types:=True;
   End;
  End
   Else
  If UWordC='STDDEF.H'Then Begin
   If Not(Info.StdDef)Then Begin
    PutFileTxtLn(Info.HandlePas,'Const');
    PutFileLn(Info.HandlePas);
    PutFileTxtLn(Info.HandlePas,Spc(6)+'Null=NIL;');
    PutFileLn(Info.HandlePas);
    PutFileTxtLn(Info.HandlePas,'Type');
    PutFileLn(Info.HandlePas);
    PutFileTxtLn(Info.HandlePas,Spc(5)+'WChar_T=Char;');
    PutFileTxtLn(Info.HandlePas,Spc(5)+'Size_T=Word;');
    PutFileTxtLn(Info.HandlePas,Spc(5)+'PtrDiff_T=Pointer;');
    Info.StdDef:=True;
   End;
  End
   Else
  If UWordC='DOS.H'Then PutFileTxt(Info.HandlePAS,'Uses Crt,DOS;')else
  If UWordC='DIR.H'Then PutFileTxt(Info.HandlePAS,'Uses DOS;')else
  If UWordC='STRING.H'Then PutFileTxt(Info.HandlePAS,'Uses Strings;')else
  If UWordC='STRINGS.H'Then PutFileTxt(Info.HandlePAS,'Uses Strings;')else
  If UWordC='ALLOC.H'Then PutFileTxt(Info.HandlePAS,'Uses Memory;')else
  If UWordC='PROCESS.H'Then PutFileTxt(Info.HandlePAS,'Uses DOS;')else
  If UWordC='STDIO.H'Then PutFileTxt(Info.HandlePAS,'Uses Crt,DOS;')else
  If UWordC='CONIO.H'Then PutFileTxt(Info.HandlePAS,'Uses Crt;')else
  If UWordC='IO.H'Then PutFileTxt(Info.HandlePAS,'Uses DOS;')else
  If UWordC='STDLIB.H'Then PutFileTxt(Info.HandlePAS,'Uses Memory;')else
  If UWordC='GRAPH.H'Then PutFileTxt(Info.HandlePAS,'Uses Graph;')
   else
  Begin
   FSplit(Info.NameC,D,N,E);
   Info.Output:=D+';'+Info.PathHeader+';'+GetEnv('PATH');
   Info.Output:=StrUp(FSearch(WordC,Info.Output));
   If Info.Output=''Then Info.Output:=WordC;
   CondC2Pascal:=IncludeFile;
   Exit;
  End;
  Inc(Info.I);
 End
  Else
 {* * * * * * * * * * * * * * * * * * * * * * * * *}
 {*                      UNDEF                    *}
 {* * * * * * * * * * * * * * * * * * * * * * * * *}
 If UWordC='UNDEF'Then Begin
  SkipSpc(Info,False);
  WordC:=XtrkWord(Info.I,Info.Line);
  UWordC:=StrUp(WordC);
  If UWordC='SIZEOF'Then Begin
   Info.Warning[Info.WarPos].War:=SkipDefineSizeOf; { Skip define "sizeof". }
   Info.Warning[Info.WarPos].Line:=Info.L;
   If Info.WarPos=255Then Begin
    CondC2Pascal:=TooManyWarning;
    Exit; { Too many warning. }
   End
    Else
   Inc(Info.WarPos);
  End
   Else
  Begin
   If BDSearchValue(Info.BoolDir,WordC)Then Begin
    Info.Warning[Info.WarPos].War:=WrongValueInDefineDirective; { Wrong value in define directive. }
    Info.Warning[Info.WarPos].Line:=Info.L;
    If Info.WarPos=255Then Begin
     CondC2Pascal:=TooManyWarning;
     Exit;
    End
     Else
    Inc(Info.WarPos)
   End;
   PutFileTxtLn(Info.HandlePAS,Spc(Info.CondIf)+'{$UNDEF '+WordC+'}');
   BDAdd(Info.BoolDir,WordC,False);
  End;
 End
  Else
 PutFileTxt(Info.HandlePAS,'#'+WordC);
 CondC2Pascal:=0;
End;

Function StructC2Pascal(Var Info:SwitchC2Pascal):Int;
Var
 TypeStruct,VarName,WordC,Name,TypeVar:String;
 NameLen:Byte Absolute Name;
 Ok,_Ptr:Boolean;BV:BankVar;
 J,Par:Integer;
 ML:Byte;
Begin
 StructC2Pascal:=0; ML:=0;
 If Not(SkipSpcRem(Info,False))Then Begin
  StructC2Pascal:=EndOfSourceExpected;
  Exit;
 End;
 TypeStruct:=XtrkWord(Info.I,Info.Line);
 If TypeStruct=''Then Begin
  StructC2Pascal:=TypeVarExpected;
  Exit;
 End;
 If Not(SkipSpcRem(Info,False))Then Begin
  StructC2Pascal:=EndOfSourceExpected;
  Exit;
 End;
 Case Info.Line[Info.I]of
  '{':Begin
   Inc(Info.I,Length('{'));
   BVInit(BV);
   Ok:=False;
   Repeat
    If Not(SkipSpcRem(Info,False))Then Begin
     StructC2Pascal:=EndOfSourceExpected;
     Exit;
    End;
    TypeVar:=XtrkWord(Info.I,Info.Line);
    If TypeVar=''Then Begin
     StructC2Pascal:=TypeVarExpected;
     Exit;
    End;
    If Not(SkipSpcRem(Info,False))Then Begin
     StructC2Pascal:=EndOfSourceExpected;
     Exit;
    End;
    _Ptr:=False;
    Case Info.Line[Info.I]of
     '*':Begin
      _Ptr:=True;
      Inc(Info.I,Length('*'));
      If Not(SkipSpcRem(Info,False))Then Begin
       StructC2Pascal:=EndOfSourceExpected;
       Exit;
      End;
      Name:=XtrkWord(Info.I,Info.Line);
     End;
     '(':Begin
      Name:='';Par:=1;Inc(Info.I,Length('('));
      While Par>0do Begin
       SkipSpcRem(Info,False);
       Case Info.Line[Info.I]of
        '(':Inc(Par);
	')':Dec(Par);
       End;
       IncStr(Name,Info.Line[Info.I]);Inc(Info.I);
      End;
     End;
     Else Name:=XtrkWord(Info.I,Info.Line);
    End;
    If Name=''Then Begin
     StructC2Pascal:=VarNameExpected;
     Exit;
    End;
    Case Info.Line[Info.I]of
     '[':Begin
      Inc(Info.I,Length('['));
      Case Info.Line[Info.I]of
       '0'..'9':WordC:=XtrkCNm2Pas(Info.I,Info.Line);
       'A'..'Z','a'..'z','_':WordC:=XtrkWord(Info.I,Info.Line);
       Else WordC:='';
      End;
      If WordC=''Then Begin
       StructC2Pascal:=NumberOfArrayExpected;
       Exit;
      End;
      If Info.Line[Info.I]<>']'Then Begin
       StructC2Pascal:=CloseArrayExpected;
       Exit; (* ']' expected. *)
      End;
      Inc(Info.I,Length(']'));
      If Info.Line[Info.I]<>';'Then Begin
       StructC2Pascal:=PointCommaExpected;
       Exit; (* ';' expected. *)
      End;
      TypeVar:='Array[0..'+WordC+'] of '+VarC2Pas(TypeVar,True);
     End;
     ';':;
     '}':Begin
      StructC2Pascal:=PointCommaExpected;
      Exit; (* ';' expected. *)
     End;
     Else Begin
      StructC2Pascal:=SyntaxError;
      Exit; (* Syntax error *)
     End;
    End;
    If(_Ptr)Then TypeVar:='^'+TypeVar;
    Inc(Info.I);
    {If(BV.WordExist(Name))Then Begin
     TypeStructC2Pascal := VarStructDupl;
     Exit; (* Variable structure duplicated. *)
    End;}
    If IsReservedWordPascal(Name)Then Begin
     StructC2Pascal:=UsePascalReservedWordForVar;
     Exit; (* Mot r‚serv‚ Pascal utilis‚ comme variable. *)
    End;
    If(NameLen>ML)Then ML:=NameLen;
    BVAdd(BV,Name,TypeVar);
    If Not(SkipSpcRem(Info,False))Then Begin
     StructC2Pascal:=EndOfSourceExpected;
     Exit; (* Fin du source attendu. *)
    End;
    Ok:=Info.Line[Info.I]='}';
   Until Ok;
   Inc(Info.I,Length('}'));
   If Not(SkipSpcRem(Info,False))Then Begin
    StructC2Pascal:=EndOfSourceExpected;
    Exit; (* Fin du source attendu. *)
   End;
   VarName:=XtrkWord(Info.I,Info.Line);
   If Not(SkipSpcRem(Info,False))Then Begin
    StructC2Pascal:=EndOfSourceExpected;
    Exit; (* Fin du source attendu. *)
   End;
   If Info.Line[Info.I]<>';'Then Begin
    StructC2Pascal:=PointCommaExpected;
    Exit; (* ';' attendu. *)
   End;
   Inc(Info.I,Length(';'));
   If(Info.Mode<>_Type_)Then Begin
    PutFileTxtLn(Info.HandlePas,'Type');
    PutFileLn(Info.HandlePas);
    Info.Mode:=_Type_;
   End;
   PutFileTxtLn(Info.HandlePAS,Spc(5)+TypeStruct+'=Record');
   For J:=0to BVGetMaxWord(BV)do Begin
    BVGetWord(BV,J,Name,TypeVar);
    PutFileTxtLn(Info.HandlePAS,Spc(10+Length(TypeStruct))+StrUSpc(Name,ML)+' : '+VarC2Pas(TypeVar,True)+';');
   End;
   PutFileTxtLn(Info.HandlePAS,Spc(8+Length(TypeStruct))+'End;');
   BVDone(BV);
   If VarName<>''Then Begin
    Info.Mode:=_Var_;
    PutFileTxtLn(Info.HandlePas,'Var');
    PutFileLn(Info.HandlePas);
    PutFileTxtLn(Info.HandlePas,Spc(4)+VarName+' : '+TypeStruct);
   End;
  End;
  'A'..'Z','a'..'z','_':Begin
   VarName:=XtrkWord(Info.I,Info.Line);
   If VarName=''Then Begin
    StructC2Pascal:=VarNameExpected;
    Exit; (* Nom de variable attendu. *)
   End;
   If Info.Line[Info.I]<>';'Then Begin
    StructC2Pascal:=PointCommaExpected;
    Exit;
   End;
   Inc(Info.I,Length(';'));
   If(Info.Mode<>_Var_)Then Begin
    PutFileTxtLn(Info.HandlePas,'Var');
    PutFileLn(Info.HandlePas);
    Info.Mode:=_Var_;
   End;
   PutFileTxtLn(Info.HandlePAS,Spc(4)+VarName+' : '+TypeStruct+';');
  End;
  Else Begin
   StructC2Pascal:=SyntaxError;
   Exit;
  End;
 End;
End;

Function VarC2Pas(Str:String;Signed:Boolean):String;Begin
 VarC2Pas:=Str;Str:=StrUp(Str);
 Case Signed of
	  {* * * * * * * * * * * * * * * * * * * * * *}
	  {*               unsigned                  *}
	  {* * * * * * * * * * * * * * * * * * * * * *}
False:Begin
       If Str='SHORT'Then VarC2Pas:='Word';
       If Str='INT'Then VarC2Pas:='Word';
       If Str='LONG'Then VarC2Pas:='LongInt';
       If Str='FLOAT'Then VarC2Pas:='Real';
       If Str='DOUBLE'Then VarC2Pas:='Double';
       If Str='CHAR'Then VarC2Pas:='Char';
      End;
      {* * * * * * * * * * * * * * * * * * * * * *}
      {*                 signed                  *}
      {* * * * * * * * * * * * * * * * * * * * * *}
 Else Begin
       If Str='SHORT'Then VarC2Pas:='Integer';
       If Str='INT'Then VarC2Pas:='Integer';
       If Str='LONG'Then VarC2Pas:='LongInt';
       If Str='FLOAT'Then VarC2Pas:='Real';
       If Str='DOUBLE'Then VarC2Pas:='Double';
       If Str='CHAR'Then VarC2Pas:='Char';
      End;
 End;
End;

Function TypeStructC2Pascal(Var Info:SwitchC2Pascal):Int;
Var Ok:Bool;BV:BankVar;J:Int;WordC,Name,TypeVar:String;
NameLen:Byte Absolute Name;WordCLen:Byte Absolute WordC;ML:Byte;Begin
 TypeStructC2Pascal:=0; ML:=0;
 If Not(SkipSpcRem(Info,False))Then Begin
  TypeStructC2Pascal:=EndOfSourceExpected;
  Exit;
 End;
 If IsLangChrWord(Info.Line[Info.I])Then Begin
  TypeVar:=XtrkWord(Info.I,Info.Line);
  If Not(SkipSpcRem(Info,False))Then Begin
   TypeStructC2Pascal:=EndOfSourceExpected;
   Exit;
  End;
  If Info.Line[Info.I]<>'*'Then Begin
   TypeStructC2Pascal:=AsterixExpected;
   Exit; (* '*' attendu. *)
  End;
  Inc(Info.I,Length('*'));
  If Not(SkipSpcRem(Info,False))Then Begin
   TypeStructC2Pascal:=EndOfSourceExpected;
   Exit;
  End;
  Name:=XtrkWord(Info.I,Info.Line);
  If Not(SkipSpcRem(Info,False))Then Begin
   TypeStructC2Pascal:=EndOfSourceExpected;
   Exit;
  End;
  If Info.Line[Info.I]<>';'Then Begin
   TypeStructC2Pascal:=PointCommaExpected;
   Exit; (* ';' attendu.' *)
  End;
  Inc(Info.I,Length(';'));
  PutFileTxtLn(Info.HandlePas,Spc(6)+Name+' = ^'+TypeVar+';');
  Exit;
 End;
 If Info.Line[Info.I]<>'{'Then Begin
  TypeStructC2Pascal:=OpenEnsExpected;
  Exit; (* '{' attendu. *)
 End;
 Inc(Info.I,Length('}'));
 If Info.Line[Info.I]='}'Then Begin
  TypeStructC2Pascal:=StructEmpty;
  Exit;
 End;
 BVInit(BV);
 Ok:=False;
 Repeat
  If Not(SkipSpcRem(Info,False))Then Begin
   TypeStructC2Pascal:=EndOfSourceExpected;
   Exit;
  End;
  TypeVar:=XtrkWord(Info.I,Info.Line);
  If TypeVar=''Then Begin TypeStructC2Pascal:=TypeVarExpected;Exit;End;
  If Not(SkipSpcRem(Info,False))Then Begin
   TypeStructC2Pascal:=EndOfSourceExpected;
   Exit;
  End;
  Name:=XtrkWord(Info.I,Info.Line);
  If Name=''Then Begin
   TypeStructC2Pascal:=VarNameExpected;
   Exit;
  End;
  Case Info.Line[Info.I]of
   '[': Begin
	 Inc(Info.I,Length('['));
	 WordC:=XtrkCNm2Pas(Info.I,Info.Line);
	 If WordC=''Then Begin
          TypeStructC2Pascal:=NumberOfArrayExpected;
          Exit;
         End;
	 If Info.Line[Info.I]<>']'Then Begin
	  TypeStructC2Pascal:=CloseArrayExpected;
	  Exit; (* ']' attendu. *)
	 End;
	 Inc(Info.I,Length(']'));
	 If Info.Line[Info.I]<>';'Then Begin
	  TypeStructC2Pascal:=PointCommaExpected;
	  Exit; (* ';' attendu. *)
	 End;
	 TypeVar:='Array[0..'+WordC+'] of '+VarC2Pas(TypeVar,True);
	End;
   ';':;
   '}': Begin
	 TypeStructC2Pascal:=PointCommaExpected;
	 Exit; (* ';' attendu. *)
	End;
   Else Begin
	 TypeStructC2Pascal:=SyntaxError;
	 Exit; (* Erreur de syntaxe *)
	End;
  End;
  Inc(Info.I);
{  If(BV.WordExist(Name))Then Begin
   TypeStructC2Pascal:=VarStructDupl;
   Exit; (* Duplication de structure de variable. *)
  End;}
  If IsReservedWordPascal(Name)Then Begin
   TypeStructC2Pascal:=UsePascalReservedWordForVar;
   Exit; (* Mot Pascal r‚serv‚ utilis‚ comme variable. *)
  End;
  If(NameLen>ML)Then ML:=NameLen;
  BVAdd(BV,Name,TypeVar);
  If Not(SkipSpcRem(Info,False))Then Begin
   TypeStructC2Pascal:=EndOfSourceExpected;
   Exit;
  End;
  Ok:=Info.Line[Info.I]='}';
 Until Ok;
 Inc(Info.I,Length('}'));
 If Not(SkipSpcRem(Info,False))Then Begin
  TypeStructC2Pascal:=EndOfSourceExpected;
  Exit;
 End;
 WordC:=XtrkWord(Info.I,Info.Line);
 If Not(SkipSpcRem(Info,False))Then Begin
  TypeStructC2Pascal:=EndOfSourceExpected;
  Exit;
 End;
 If Info.Line[Info.I]<>';'Then Begin
  TypeStructC2Pascal:=PointCommaExpected;
  Exit; (* ';' attendu. *)
 End;
 Inc(Info.I,Length(';'));
 If(Info.Mode<>_Type_)Then Begin
  Info.Mode:=_Type_;
  PutFileTxtLn(Info.HandlePas,'Type');
  PutFileLn(Info.HandlePas);
 End;
 PutFileTxtLn(Info.HandlePAS,Spc(5)+WordC+'=Record');
 For J:=0to BVGetMaxWord(BV)do Begin
  BVGetWord(BV,J,Name,TypeVar);
  PutFileTxtLn(Info.HandlePas,Spc(10+WordCLen)+StrUSpc(Name,ML)+':'+VarC2Pas(TypeVar,True)+';');
 End;
 PutFileTxtLn(Info.HandlePas,Spc(8+WordCLen)+'End;');
 BVDone(BV);
End;

Function SkipSpcRem(Var Info:SwitchC2Pascal;Put:Boolean):Boolean;Begin
 SkipSpcRem:=False;
 While Info.I>Length(Info.Line)do Begin
  If EOF(Info.HandleC)Then Exit;
  If(Put)Then PutFileLn(Info.HandlePas);
  If Not(ExtractLine(Info.I,Info.Line,Info.HandleC,Info.L))Then Exit;
 End;
 If Info.Line[Info.I]='/'Then Begin
  If Length(Info.Line)>=Info.I+1Then Begin
   If Info.Line[Info.I+1]in['/','*']Then Begin
    If Not(CommentC2Pascal(Info,Put))Then Exit;
    While Info.I>Length(Info.Line)do Begin
     If(EOF(Info.HandleC))Then Exit;
     If(Put)Then PutFileLn(Info.HandlePas);
     If Not(ExtractLine(Info.I,Info.Line,Info.HandleC,Info.L))Then Exit;
    End;
   End;
  End;
 End;
 While Info.Line[Info.I]in[' ',#9]do Begin
  If(Put)Then PutFileTxt(Info.HandlePas,Info.Line[Info.I]);
  Inc(Info.I);
  While Info.I>Length(Info.Line)do Begin
   If EOF(Info.HandleC)Then Exit;
   If(Put)Then PutFileLn(Info.HandlePAS);
   If Not(ExtractLine(Info.I,Info.Line,Info.HandleC,Info.L))Then Exit;
  End;
  If Info.Line[Info.I]='/'Then Begin
   If Length(Info.Line)>=Info.I+1Then Begin
    If Info.Line[Info.I+1]in['/','*']Then Begin
     If Not(CommentC2Pascal(Info,Put))Then Exit;
     While Info.I>Length(Info.Line)do Begin
      If EOF(Info.HandleC)Then Exit;
      If(Put)Then PutFileLn(Info.HandlePas);
      If Not(ExtractLine(Info.I,Info.Line,Info.HandleC,Info.L))Then Exit;
     End;
    End;
   End;
  End;
 End;
 SkipSpcRem:=True;
End;

Function TypeEnumC2Pascal(Var Info:SwitchC2Pascal):Integer;
Var
 Ok:Boolean;
 BW:ArrayList;
 J:Integer;
 WordC:String;
Begin
 TypeEnumC2Pascal:=0;
 If Not(SkipSpcRem(Info,False))Then Begin
  TypeEnumC2Pascal:=EndOfSourceExpected;
  Exit;
 End;
 If Info.Line[Info.I]<>'{'Then Begin
  TypeEnumC2Pascal:=OpenEnsExpected;
  Exit;{'{' attendu.}
 End;
 Inc(Info.I,Length('{'));
 If Not(SkipSpcRem(Info,False))Then Begin
  TypeEnumC2Pascal:=EndOfSourceExpected;
  Exit;
 End;
 If Info.Line[Info.I]='}'Then Begin
  TypeEnumC2Pascal:=EnumEmpty;
  Exit;
 End;
 ALInit(BW);
 Ok:=False;
 Repeat
  If Not(SkipSpcRem(Info,False))Then Begin
   TypeEnumC2Pascal:=EndOfSourceExpected;
   Exit;
  End;
  WordC:=XtrkWord(Info.I,Info.Line);
  If WordC=''Then Begin
   TypeEnumC2Pascal:=EnumExpected;
   Exit;
  End;
{  If(BW.WordExist(WordC))Then Begin
   TypeEnumC2Pascal:=EnumDupl;
   Exit; (* Duplication d'‚numeration. *)
  End;}
  ALAddStr(BW,WordC);
  If Not(SkipSpcRem(Info,False))Then Begin
   TypeEnumC2Pascal:=EndOfSourceExpected;
   Exit;
  End;
  Case Info.Line[Info.I]of
   ',': ;
   '}': Ok:=True;
   Else Begin
    TypeEnumC2Pascal:=SyntaxError;
    Exit;
   End;
  End;
  Inc(Info.I);
 Until Ok;
 If Not(SkipSpcRem(Info,False))Then Begin
  TypeEnumC2Pascal:=EndOfSourceExpected;
  Exit;
 End;
 WordC:=XtrkWord(Info.I,Info.Line);
 If Not(SkipSpcRem(Info,False))Then Begin
  TypeEnumC2Pascal:=EndOfSourceExpected;
  Exit;
 End;
 If Info.Line[Info.I]<>';'Then Begin
  TypeEnumC2Pascal:=PointCommaExpected;
  Exit; (* ';' attendu.*)
 End;
 Inc(Info.I,Length(';'));
 If(Info.Mode<>_Type_)Then Begin
  Info.Mode:=_Type_;
  PutFileTxtLn(Info.HandlePas,'Type');
  PutFileLn(Info.HandlePas);
 End;
 PutFileTxtLn(Info.HandlePas,Spc(5)+WordC+' = (');
 For J:=0to ALMax(BW)do Begin
  PutFileTxt(Info.HandlePas,Spc(6)+_ALGetStr(BW,J));
  If(ALMax(BW)<>J)Then PutFileTxt(Info.HandlePas,',');
  PutFileLn(Info.HandlePas);
 End;
 PutFileTxtLn(Info.HandlePas,Spc(5)+');');
 ALDone(BW);
End;

Function ExtractLine(Var I:Byte;Var Line:String;Var Handle:Text;Var L:Long):Boolean;Begin ExtractLine:=False;
 If EOF(Handle)Then Exit;
 FillClr(Line,SizeOf(Line));
 ReadLn(Handle,Line);
 Inc(L);I:=1;
 ExtractLine:=True;
End;

Function CommentC2Pascal(Var Info:SwitchC2Pascal;Put:Bool):Bool;Begin
 CommentC2Pascal:=False;
 Inc(Info.I);
 If Info.I<=Length(Info.Line)Then Begin
  Case Info.Line[Info.I]of
   '/':Begin
    If(Put)Then PutFileTxt(Info.HandlePAS,'{'+Copy(Info.Line,Info.I+1,255)+'}');
    Info.I:=Length(Info.Line)+1;
   End;
   '*':Begin
    If(Put)Then PutFileTxt(Info.HandlePAS,'(*');
    Inc(Info.I);
    While Info.I>Length(Info.Line)do Begin
     If(EOF(Info.HandleC))Then Exit;
     If(Put)Then PutFileLn(Info.HandlePas);
     If Not(ExtractLine(Info.I,Info.Line,Info.HandleC,Info.L))Then Exit;
    End;
    While Not((Info.Line[Info.I]='*')and(Info.Line[Info.I+1]='/'))do Begin
     If(Put)Then PutFileTxt(Info.HandlePAS,Info.Line[Info.I]);
     Inc(Info.I);
     While Info.I>Length(Info.Line)do Begin
      If EOF(Info.HandleC)Then Exit;
      If(Put)Then PutFileLn(Info.HandlePAS);
      If Not(ExtractLine(Info.I,Info.Line,Info.HandleC,Info.L))Then Exit;
     End;
    End;
    If(Put)Then PutFileTxt(Info.HandlePAS,'*)');
    Inc(Info.I,Length('*)'));
   End;
   Else
   Begin
    If(Put)Then PutFileTxt(Info.HandlePAS,'/');
    Inc(Info.I);
   End;
  End;
 End
  Else
 Begin
  If(Put)Then PutFileTxt(Info.HandlePAS,'/');
 End;
 CommentC2Pascal:=True;
End;

Procedure HaltMsg(Var Q:SwitchC2Pascal;Const Msg:String);Begin
 {$IFDEF CONSOLE}
  System.WriteLn('Erreur ',Q.NameC,' ',Q.L,': ',Msg);
  If(Q.WarningMsg)Then System.WriteLn('*** ',WarnNum,' attention(s) ***');
  System.WriteLn('*** 1 erreur       ***');
  System.WriteLn;
  System.WriteLn('      M‚moire disponible ',MemAvail);
  System.WriteLn;
  Close(Q.HandlePas);
  Halt;
 {$ENDIF}
End;

Procedure HaltOutOfMemory(Var Q:SwitchC2Pascal);Begin
 HaltMsg(Q,'Manque de m‚moire.');
End;

Procedure Warning(Var Q:SwitchC2Pascal;Const Msg:String);Begin
 If(Q.WarningMsg)Then Begin
  {$IFDEF CONSOLE}
   System.WriteLn('Attention ',Q.NameC,' ',Q.L,': ',Msg);
  {$ELSE}
{   WEPutTxtXY(Q.W,0,20,'Attention '+Q.NameC+' '+Str(Q.L)+': '+Msg);}
  {$ENDIF}
  Inc(WarnNum);
 End;
End;

{$IFDEF CONSOLE}
 Procedure StartUpC2Pas(Var Q:SwitchC2Pascal);Var I:Byte;Str:String;

  Procedure Help;Begin
   System.WriteLn('Syntaxe : C2PAS [fichier[.C]] [ option ]');
   System.WriteLn(' * = par d‚faut');
   System.WriteLn;
   System.WriteLn(' /?     Retourne ces messages');
   System.WriteLn(' /NR    Pas de remarque');
   System.WriteLn(' /NU    Distinction entre les Minuscule/Majuscule');
   System.WriteLn(' /NW    Pas de message d''attention');
   System.WriteLn(' /R   * Remarque');
   System.WriteLn(' /U   * Pas de distinction entre les Majuscules/Minuscule');
   System.WriteLn(' /W   * Message d''attention');
   System.WriteLn;
   System.WriteLn;
   Halt;
  End;

 Begin
  System.WriteLn('Convertisseur de fichier .C … .PAS Version 1.0');
  System.WriteLn('Tous droit r‚serv‚ par les Chevaliers de Malte (C) 1993, 1996');
  System.WriteLn;
  If ParamCount=0Then Help;
  For I:=1to ParamCount do Begin
   Str:=StrUp(ParamStr(I));
   If Str[1]='/'Then Begin
    If Str='/?'Then Help else
    If Str='/NR'Then Q.Rem:=No else
    If Str='/NU'Then NoUpper:=Ya else
    If Str='/NW'Then Q.WarningMsg:=No else
    If Str='/R'Then Q.Rem:=Ya else
    If Str='/U'Then NoUpper:=No else
    If Str='/W'Then Q.WarningMsg:=Ya
     Else
    Begin
     System.WriteLn('Erreur: ParamŠtre non-reconnue "',ParamStr(I),'".');
     Halt;
    End;
   End
    Else
   Q.SourceName:=Str;
  End;
  If(Q.Rem)Then System.WriteLn(' þ Plein de remarque');
  If Not(NoUpper)Then System.WriteLn(' þ Pas de distinction majuscule/minuscule');
  If(Q.WarningMsg)Then System.WriteLn(' þ Retourne les messages d''attention');
  {$IFOPT G+}
   System.WriteLn(' þ Edition sp‚cial pour les processeurs 80286');
  {$ENDIF}
  System.WriteLn;
 End;
{$ENDIF}

Procedure PPInit;Begin
 FillClr(K,SizeOf(K));
End;

Procedure PPPushProc;Begin
 PPPushFunc(K,Q,Name,'');
End;

Procedure PPPushFunc;
Var
 TMC:PackProcPtr;
 BMC:PackProcRecord;
 PName,PFuncType:PChr;
Begin
 PName:=MemAlloc(Length(Name)+1);
 If(PName=NIL)Then HaltOutOfMemory(Q);
 StrPCopy(PName,Name);
 If FuncType<>''Then Begin
  PFuncType:=MemAlloc(Length(FuncType)+1);
  If(PFuncType=NIL)Then HaltOutOfMemory(Q);
  StrPCopy(PFuncType,FuncType);
 End
  Else
 PFuncType:=NIL;
 BMC.Name:=PName; BMC.Func:=FuncType<>''; BMC.FuncType:=PFuncType;
 BMC.Previous:=NIL;
 BMC.Next:=NIL;
 TMC:=K.List;
 If(TMC<>NIL)Then Begin
  While(TMC^.Next<>NIL)do TMC:=TMC^.Next;
  BMC.Previous:=TMC;
  TMC^.Next:=MemAlloc(SizeOf(K.List^));
  K.EndList:=TMC^.Next;
  If(TMC^.Next=NIL)Then Exit;
  Move(BMC,TMC^.Next^,SizeOf(K.List^));
 End
  Else
 Begin
  TMC:=MemAlloc(SizeOf(K.List^));
  If(TMC=NIL)Then Exit;
  K.List:=TMC;
  K.EndList:=K.List;
  Move(BMC,TMC^,SizeOf(K.List^));
 End;
End;

Function PPGetLastProcName;Begin
 If(K.EndList<>NIL)Then PPGetLastProcName:=StrPas(K.EndList^.Name)
                   Else PPGetLastProcName:='';
End;

Procedure PPDone;Begin
End;

Var
 Proc:PackProc;

Procedure InitC2Pas(Var Q:SwitchC2Pascal);
Var
 I:Byte;
Begin
 FillClr(Q,SizeOf(Q));
 Q.WarningMsg:=True;
 NoUpper:=False;
 Q.Rem:=True;Q.Beg:=0;
 PPInit(Proc);
 {$IFDEF TABLEEXTENSION}
  LineNum:=0;
  For I:=0to 45do Proc.PushFunc(Q,StrPas(@ProcBuffer[I,0]),StrPas(@ProcBuffer[I,1]));
 {$ENDIF}
End;

Function Error(Var Q:SwitchC2Pascal;Err:Integer):Boolean;Begin
 Error:=Err>0;
 If Err>0Then HaltMsg(Q,GetErrMsg(Err));
End;

Procedure DumpWarning(Var Q:SwitchC2Pascal);
Var
 I:Byte;
Begin
 For I:=1to(Q.WarPos)do Begin
  Q.L:=Q.Warning[Q.WarPos-1].Line;
  Case Q.Warning[Q.WarPos-1].War of
   SkipDefineFar: Warning(Q,'D‚finition "far" non sp‚cifi‚.');
   SkipDefineSizeOf: Warning(Q,'D‚finition "sizeof" non d‚clar‚.');
   DuplicateDefineSymbol: Warning(Q,'Duplicate de symbole de definition.');
   WrongValueInDefineDirective: Warning(Q,'Valeur incompatible dans la d‚finition de la directive.');
  End;
 End;
End;

Procedure ConvFile(Var Q:SwitchC2Pascal;Const FileName:String);
Var
 WordC,UWordC,ProcName,Msg:String;
 InProc,EndMissing,SkipBeg,Signed,Defined:Boolean;
 TPath:PathStr;D:DirStr;
 N:NameStr;E:ExtStr;
 Err:Integer;

 Procedure ExtractLine;Begin
  FillClr(Q.Line,SizeOf(Q.Line));
  ReadLn(Q.HandleC,Q.Line);
  Inc(Q.L);
  Q.I:=1;
  {$IFNDEF CONSOLE}
   PutInfo(Q);
  {$ENDIF}
 End;

 Function ConvComment(Put:Boolean):Boolean;Begin
  ConvComment:=True;
  If Not(CommentC2Pascal(Q,Put))Then ConvComment:=Not Error(Q,EndOfCommentExpected);
 End;

 Procedure SkipSpcRem(Put:Boolean);Begin
  If Q.I>Length(Q.Line)Then Begin
   If(Put)Then PutFileLn(Q.HandlePas);
   ExtractLine;
  End;
  If Q.Line[Q.I]='/'Then Begin
   If Length(Q.Line)>=Q.I+1Then Begin
    If Q.Line[Q.I]in['/','*']Then ConvComment(False);
    If Q.I>Length(Q.Line)Then Begin
     If(Put)Then PutFileLn(Q.HandlePas);
     ExtractLine;
    End;
   End;
  End;
  While Q.Line[Q.I]in[' ',#9]do Begin
   If(Put)Then PutFileTxt(Q.HandlePas,Q.Line[Q.I]);
   Inc(Q.I);
   If Q.I>Length(Q.Line)Then Begin
    If EOF(Q.HandleC)Then Begin
     If Error(Q,EndOfCommandExpected)Then Exit;{ Fin de commande attendu. }
    End;
    If(Put)Then PutFileLn(Q.HandlePas);
    ExtractLine;
   End;
   If Q.Line[Q.I]='/'Then Begin
    If Length(Q.Line)>=Q.I+1Then Begin
     If Q.Line[Q.I]in['/','*']Then Begin
      If Not ConvComment(False)Then Exit;
     End;
     If Q.I>Length(Q.Line)Then Begin
      If EOF(Q.HandleC)Then Begin
       If Error(Q,EndOfCommandExpected)Then Exit;{ Fin de commande attendu. }
      End;
      If(Put)Then PutFileLn(Q.HandlePas);
      ExtractLine;
     End;
    End;
   End;
  End;
 End;

 Procedure GotoPointVirgule;Begin
  If Q.I>Length(Q.Line)Then Begin
   PutFileLn(Q.HandlePas);
   ExtractLine;
  End;
  While Q.Line[Q.I]<>';'do Begin
   Case Q.Line[Q.I]of
    '-': Begin
	  Inc(Q.I);
	  Case Q.Line[Q.I]of
	   '>': PutFileTxt(Q.HandlePas,'.');
	   Else PutFileTxt(Q.HandlePas,'-'+Q.Line[Q.I]);
	  End;
	 End;
    Else PutFileTxt(Q.HandlePas,Q.Line[Q.I]);
   End;
   Inc(Q.I);
   If Q.I>Length(Q.Line)Then Begin
    If EOF(Q.HandleC)Then Error(Q,EndOfCommentExpected); { Fin de commentaire attendu. }
    PutFileLn(Q.HandlePAS);
    ExtractLine;
   End;
  End;
 End;

 Function ExtractCWord:String;Begin
  While(Q.Line[Q.I]='-')and(Q.Line[Q.I+1]='>')do Begin
   Inc(Q.I,Length('->'));
   AddStr(WordC,'.'+XtrkWord(Q.I,Q.Line));
  End;
  UWordC:=AutoUp(WordC);
 End;

 Procedure ExtractFuncArg;
 Var
  UHeader,Header,VarName:String;
 Begin
  SkipSpcRem(False);
  If Q.Line[Q.I]='('Then Begin
   PutFileTxt(Q.HandlePas,'(');
   Inc(Q.I);
   If Q.I>Length(Q.Line)Then Exit;
   While Q.Line[Q.I]<>')'do Begin
    SkipSpcRem(False);
    If Q.Line[Q.I]=','Then Begin
     PutFileTxt(Q.HandlePas,';');
     Inc(Q.I);
     SkipSpcRem(False);
    End;
    If IsLangChrWord(Q.Line[Q.I])Then Begin
     Header:=XtrkWord(Q.I,Q.Line);
     SkipSpcRem(False);
    End;
    Case Q.Line[Q.I]of
     '/': ConvComment(True);
     ')': Begin PutFileTxt(Q.HandlePas,Header);Break;End;
     '{': Error(Q,MisplacedBeginSymbol); { Symbole de d‚but mal plac‚. }
     ';': Error(Q,MisplacedPointComma);  { ';' mal plac‚. }
     Else Begin
	   If Q.Line[Q.I]='*'Then Begin
	    PutFileTxt(Q.HandlePas,'^');
	    Inc(Q.I);
	   End;
	   VarName:=XtrkWord(Q.I,Q.Line);
	   PutFileTxt(Q.HandlePas,VarName+':');
	   UHeader:=StrUp(UHeader);
	   If UHeader='UNSIGNED'Then Begin
	    SkipSpcRem(False);
	    Header:=XtrkWord(Q.I,Q.Line);
            UHeader:=StrUp(Header);
	    If UHeader='UNSIGNED'Then HaltMsg(Q,'Variable illogique 2 fois non-sign‚...') else
	    If UHeader='SHORT'Then PutFileTxt(Q.HandlePas,'Word') else
	    If UHeader='INT'Then PutFileTxt(Q.HandlePas,'Word') else
	    If UHeader='LONG'Then PutFileTxt(Q.HandlePas,'LongInt{Word}') else
	    If UHeader='FLOAT'Then PutFileTxt(Q.HandlePas,'Real') else
	    If UHeader='DOUBLE'Then PutFileTxt(Q.HandlePas,'Double') else
	    If UHeader='CHAR'Then PutFileTxt(Q.HandlePas,'Char')
	     else
	    PutFileTxt(Q.HandlePas,Header);
	   End
	    Else
	   If UHeader='SHORT'Then PutFileTxt(Q.HandlePas,'Integer')else
	   If UHeader='INT'Then PutFileTxt(Q.HandlePas,'Integer')else
	   If UHeader='LONG'Then PutFileTxt(Q.HandlePas,'LongInt')else
	   If UHeader='FLOAT'Then PutFileTxt(Q.HandlePas,'Real')else
	   If UHeader='DOUBLE'Then PutFileTxt(Q.HandlePas,'Double')else
	   If UHeader='CHAR'Then PutFileTxt(Q.HandlePas,'Char')
	    else
	   PutFileTxt(Q.HandlePas,Header);
	  End;
    End;
    If Q.I>Length(Q.Line)Then Begin
     If EOF(Q.HandleC)Then Error(Q,EndOfArgumentExpected);
     PutFileLn(Q.HandlePas);
     ExtractLine;
    End;
   End;
   Inc(Q.I);
   PutFileTxt(Q.HandlePas,')');
  End;
 End;

 Function FuncVar(Name,NamePascal:String):Bool;Begin
  FuncVar:=UWordC=Name;
  If(UWordC=Name)Then Begin
   SkipSpcRem(False);
   WordC:=XtrkWord(Q.I,Q.Line);
   Case Q.Line[Q.I]of
    '/': ConvComment(True);
    '=': Begin
	  If(Q.Mode<>_Const_)Then Begin
	   PutFileLn(Q.HandlePas);
	   PutFileTxtLn(Q.HandlePas,'Const');
	   PutFileLn(Q.HandlePas);
	   Q.Mode:=_Const_;
	  End;
	  PutFileTxt(Q.HandlePas,Spc(6)+WordC+'='+XtrkWord(Q.I,Q.Line));
	  If Q.Line[Q.I]=','Then Inc(Q.I,Length(','));
	 End;
    ',': Begin
	  If(Q.Mode<>_Var_)Then Begin
	   PutFileLn(Q.HandlePas);
	   PutFileTxtLn(Q.HandlePas,'Var');
	   PutFileLn(Q.HandlePas);
	   Q.Mode:=_Var_;
	  End;
	  PutFileTxtLn(Q.HandlePas,Spc(4)+WordC+':'+NamePascal+';');
	  Inc(Q.I);
	  While Q.Line[Q.I]<>';'do Begin
	   SkipSpcRem(False);
	   WordC:=XtrkWord(Q.I,Q.Line);
	   PutFileTxt(Q.HandlePas,WordC+':');
	   If Q.Line[Q.I]='['Then Begin
	    Inc(Q.I,Length('['));
	    WordC:=XtrkDecNm(Q.I,Q.Line);
	    PutFileTxtLn(Q.HandlePas,Spc(4)+WordC+'Array[0..'+
			 XtrkDecNm(Q.I,Q.Line)+']of '+NamePascal+';');
	    Inc(Q.I,Length(']'));
	    SkipSpcRem(False);
	    If Q.Line[Q.I]=','Then Inc(Q.I,Length(','));
	   End
	    Else
	   Begin
	    PutFileTxtLn(Q.HandlePas,Spc(4)+NamePascal+';');
	    SkipSpcRem(False);
	    If Q.Line[Q.I]=','Then Inc(Q.I,Length(','));
	   End;
	   If Q.Line[Q.I]='='Then Begin
	    PutFileTxt(Q.HandlePas,'='+XtrkWord(Q.I,Q.Line));
	    If Q.Line[Q.I]=','Then Inc(Q.I,Length(','));
	   End;
	  End;
	  Inc(Q.I);
	 End;
    ';': Begin
	  If(Q.Mode<>_Var_)Then Begin
	   PutFileLn(Q.HandlePas);
	   PutFileTxtLn(Q.HandlePas,'Var');
	   PutFileLn(Q.HandlePas);
	   Q.Mode:=_Var_;
	  End;
	  PutFileTxt(Q.HandlePas,Spc(4)+WordC+':'+NamePascal+';');
	  Inc(Q.I);
	 End;
    '[': Begin
	  If(Q.Mode<>_Var_)Then Begin
	   PutFileLn(Q.HandlePas);
	   PutFileTxtLn(Q.HandlePas,'Var');
	   PutFileLn(Q.HandlePas);
	   Q.Mode:=_Var_;
	  End;
	  Inc(Q.I);
	  PutFileTxtLn(Q.HandlePas,Spc(4)+WordC+':Array[0..'+
		       XtrkDecNm(Q.I,Q.Line)+']of '+NamePascal+';');
	  Inc(Q.I,Length('];'));
	 End;
    Else If Q.Beg>0Then PutFileTxt(Q.HandlePas,'{'+NamePascal+'}')
	  Else
	 Begin
	  Q.Mode:={_Func_}_None_;
	  PutFileTxt(Q.HandlePas,'Function '+WordC);
	  If WordC=''Then HaltMsg(Q,'Nom de la fonction attendue.');
	  PPPushFunc(Proc,Q,WordC,NamePascal);
	  InProc:=True;
	  ExtractFuncArg;
	  PutFileTxt(Q.HandlePas,':'+NamePascal+';');
	 End;
   End;
  End
 End;

 Function ExtractCNum:String;Begin
  ExtractCNum:=XtrkCNm2Pas(Q.I,Q.Line);
 End;

 Procedure _And;Begin
  If Q.Line[Q.I]='&'Then Begin
   Inc(Q.I);
   If Q.Line[Q.I]='&'Then Inc(Q.I);
   PutFileTxt(Q.HandlePas,' and ');
  End;
 End;

 Procedure _Or;Begin
  If Q.Line[Q.I]='|'Then Begin
   Inc(Q.I);
   If Q.Line[Q.I]='|'Then Inc(Q.I);
   PutFileTxt(Q.HandlePas,' or ');
  End;
 End;

 Procedure _Shl;Begin
  If(Q.Line[Q.I]='<')and(Q.Line[Q.I+1]='<')Then Begin
   Inc(Q.I,Length('<<'));
   PutFileTxt(Q.HandlePas,' shl ');
  End
   Else
  Begin
   PutFileTxt(Q.HandlePas,'<');
   Inc(Q.I);
  End;
 End;

 Procedure _Shr;Begin
  If(Q.Line[Q.I]='>')and(Q.Line[Q.I+1]='>')Then Begin
   Inc(Q.I,Length('>>'));
   PutFileTxt(Q.HandlePas,' shr ');
  End
   Else
  Begin
   PutFileTxt(Q.HandlePas,'>');
   Inc(Q.I);
  End;
 End;

 Procedure DumpEnd;
 Var
  TStr:String;
 Begin
  While Q.I<=Length(Q.Line)do Begin
   Case Q.Line[Q.I]of
     '/': ConvComment(True);
     '<': _Shl;
     '>': _Shr;
     '|': _Or;
     '&': _And;
     '-': Begin
	   Inc(Q.I);
	   Case Q.Line[Q.I]of
	    '>': Begin
		  PutFileTxt(Q.HandlePas,'.');
		  Inc(Q.I);
		 End;
	     Else PutFileTxt(Q.HandlePas,'-');
	    End;
	   End;
     '0': Begin
	   TStr:=ExtractCNum;
	   If TStr<>''Then PutFileTxt(Q.HandlePas,TStr)
	    Else
	   Begin
	    PutFileTxt(Q.HandlePas,Q.Line[Q.I]);
	    Inc(Q.I);
	   End;
	  End;
     Else Begin
	   PutFileTxt(Q.HandlePas,Q.Line[Q.I]);
	   Inc(Q.I);
	  End;
   End;
  End;
 End;

 Procedure ConvShl;Begin
  Inc(Q.I);
  If Q.Line[Q.I]='<'Then Begin
   Inc(Q.I);
   Case Q.Line[Q.I]of
    '=':Begin
     PutFileTxt(Q.HandlePas,WordC+':='+WordC+' shl ');
     Inc(Q.I);
    End;
    Else PutFileTxt(Q.HandlePAS,WordC+' shl ');
   End;
  End
   Else
  PutFileTxt(Q.HandlePas,WordC+'<');
 End;

 Procedure ConvShr;Begin
  Inc(Q.I);
  If Q.Line[Q.I]='>'Then Begin
   Inc(Q.I);
   Case Q.Line[Q.I]of
    '=': Begin
	  PutFileTxt(Q.HandlePas,WordC+':='+WordC+' shr ');
	  Inc(Q.I);
	 End;
    Else PutFileTxt(Q.HandlePas,WordC+' shr ');
   End;
  End
   Else
  PutFileTxt(Q.HandlePas,WordC+'<');
 End;

 Procedure TypeEnum;Begin
  Error(Q,TypeEnumC2Pascal(Q));
 End;

 Procedure TypeStruct;Begin
  Error(Q,TypeStructC2Pascal(Q));
 End;

Begin
 Q.NameC:=FileName;
{ Q.OvrEndIf:=0;Q.CondIf:=0;}
 Q.Mode:=_None_;Q.PathHeader:=PathHeader;
{ Q.L:=0;}
{ Q.WarPos:=0;}InProc:=False;
 Assign(Q.HandleC,Q.NameC);
 Reset(Q.HandleC);
 If IOResult<>0Then Begin
  {$IFNDEF CONSOLE}
   __FileNotFound(Q.NameC);
   Exit;
  {$ELSE}
   System.WriteLn('Erreur: Fichier ''',Q.NameC,''' introuvable.');
   Halt;
  {$ENDIF}
 End;
 FSplit(Q.NameC,D,N,E);
 {$IFDEF CONSOLE}
  WriteLn;
  WriteLn(N+E,':');
 {$ENDIF}
 Repeat
  ExtractLine;
  While Q.I<=Length(Q.Line)do Begin
   Case Q.Line[Q.I]of
    {* * * * * * * * * * * * * * * * * * * * * *}
    {*               Comment(s)                *}
    {* * * * * * * * * * * * * * * * * * * * * *}
    '/' : ConvComment(True);
    {* * * * * * * * * * * * * * * * * * * * * *}
    {*               And (&,&&)                *}
    {* * * * * * * * * * * * * * * * * * * * * *}
    '&': _And;
    '<': Begin WordC:='';ConvShl;End;
    '>': Begin WordC:='';ConvShr;End;
    {* * * * * * * * * * * * * * * * * * * * * *}
    {*                 String                  *}
    {* * * * * * * * * * * * * * * * * * * * * *}
    '"':Begin
     WordC:=XtrkCStr(Q.I,Q.Line,EndMissing);
     PutFileTxt(Q.HandlePas,'''' + WordC + '''');
     Inc(Q.I);
    End;
    {* * * * * * * * * * * * * * * * * * * * * *}
    {*                   Word(s)               *}
    {* * * * * * * * * * * * * * * * * * * * * *}
    'A'..'Z','a'..'z','_':Begin
     WordC:=XtrkWord(Q.I,Q.Line);
     UWordC:=AutoUp(WordC);
     {* * * * * * * * * * * * * * * * * * * * * *}
     {*                 TypeDef                 *}
     {* * * * * * * * * * * * * * * * * * * * * *}
     If UWordC='TYPEDEF'Then Begin
      If(Q.Mode<>_Type_)Then Begin
       PutFileLn(Q.HandlePAS);
       PutFileTxtLn(Q.HandlePAS,'Type');
       PutFileLn(Q.HandlePAS);
       Q.Mode:=_Type_
      End;
      SkipSpcRem(False);
      If IsLangChrWord(Q.Line[Q.I])Then Begin
       WordC:=XtrkWord(Q.I,Q.Line);
       If WordC=''Then Error(Q,TypedefNameExpected);
       UWordC:=AutoUp(WordC);
       If UWordC=AutoUp('enum')Then TypeEnum else
       If UWordC=AutoUp('struct')Then TypeStruct
	else
       Begin
	Signed:=True;
	If UWordC='UNSIGNED'Then Begin
	 Signed:=False;
	 SkipSpcRem(False);
	 If IsLangChrWord(Q.Line[Q.I])Then Begin
	  WordC:=XtrkWord(Q.I,Q.Line); UWordC:=StrUp(WordC);
	  If(WordC='SIGNED')or(WordC='UNSIGNED')Then HaltMsg(Q,'Format de variable non-logique.');
	 End;
	End
	 Else
	If UWordC='SIGNED'Then Begin
	 Signed:=True;
	 SkipSpcRem(False);
	 If IsLangChrWord(Q.Line[Q.I])Then Begin
	  WordC:=XtrkWord(Q.I,Q.Line); UWordC:=StrUp(WordC);
	  If(UWordC='SIGNED')or(UWordC='UNSIGNED')Then HaltMsg(Q,'Format de variable non-logique.');
	 End;
	End;
	Msg:=VarC2Pas(WordC,Signed);
	If Msg<>''Then WordC:=Msg;
	PutFileTxt(Q.HandlePas,Spc(5));
	SkipSpcRem(False);
	GotoPointVirgule;
	PutFileTxt(Q.HandlePAS,' = '+WordC);
	PutFileTxtLn(Q.HandlePAS,';');
	Inc(Q.I);
       End;
      End
       Else
      HaltMsg(Q,'Erreur de syntax dans la d‚finition de "typedef".');
     End
      Else
     If UWordC='STRUCT'Then Error(Q,StructC2Pascal(Q))
     {* * * * * * * * * * * * * * * * * * * * * *}
     {*                 Extern                  *}
     {* * * * * * * * * * * * * * * * * * * * * *}
      Else
     If UWordC='EXTERN'Then Begin
      WordC:=XtrkWord(Q.I,Q.Line); UWordC:=StrUp(WordC);
      If UWordC='VOID'Then Begin
       Q.Mode:={_Func_}_None_;
       PutFileTxt(Q.HandlePas,'Procedure ');
       SkipSpcRem(False);
       ProcName:=XtrkWord(Q.I,Q.Line);
       If ProcName=''Then HaltMsg(Q,'Nom de la fonction attendue.');
       PPPushProc(Proc,Q,ProcName);
       PutFileTxt(Q.HandlePas,ProcName+' External;');
{      SkipSpc;
      ExtractFuncArg;}
      End;
     End
     {* * * * * * * * * * * * * * * * * * * * * *}
     {*                  Void                   *}
     {* * * * * * * * * * * * * * * * * * * * * *}
      Else
     If UWordC='VOID'Then Begin
      Q.Mode:={_Func_}_None_;
      PutFileTxt(Q.HandlePAS,'Procedure ');
      SkipSpcRem(False);
      ProcName:=XtrkWord(Q.I,Q.Line);
      If ProcName=''Then HaltMsg(Q,'Nom de la fonction attendue.');
      PPPushProc(Proc,Q,ProcName);
      PutFileTxt(Q.HandlePAS,ProcName);
{      SkipSpc;
      ExtractFuncArg;}
      InProc:=True;
     End
     {* * * * * * * * * * * * * * * * * * * * * *}
     {*                 Return                  *}
     {* * * * * * * * * * * * * * * * * * * * * *}
      Else
     If UWordC='RETURN'Then Begin
      If(InProc)Then Begin
       Q.Mode:={_Func_}_None_;
       PutFileTxt(Q.HandlePas,PPGetLastProcName(Proc)+' := ');
      End
       Else
      HaltMsg(Q,'Retour de fonction ind‚sirable.');
     End
      Else
     If FuncVar('SHORT','Integer')Then Q.Mode:={_Func_}_None_
     {* * * * * * * * * * * * * * * * * * * * * *}
     {*                Register                 *}
     {* * * * * * * * * * * * * * * * * * * * * *}
      Else
     If UWordC='REGISTER'Then Begin
      SkipSpcRem(False);
      WordC:=XtrkWord(Q.I,Q.Line); UWordC:=StrUp(WordC); Msg:=WordC;
      If UWordC='FILE'Then Msg:='File';
      SkipSpcRem(False);
      If Q.Line[Q.I]='*'Then Begin Msg:='^'+Msg; Inc(Q.I); End;
      FuncVar(WordC,Msg);
     End
      Else
     If FuncVar('LONG','LongInt')Then Q.Mode:={_Func_}_None_
     {* * * * * * * * * * * * * * * * * * * * * *}
     {*                  Local                  *}
     {* * * * * * * * * * * * * * * * * * * * * *}
      Else
     If UWordC='LOCAL'Then PutFileTxt(Q.HandlePAS,'{ * * LOCAL * * }')Else
     If FuncVar('INT','Integer')Then Q.Mode:={_Func_}_None_ Else
     If UWordC='GLOBAL'Then PutFileTxt(Q.HandlePAS,'{ * * GLOBAL * * }')Else
     If FuncVar('CHAR','Char')Then Q.Mode:={_Func_}_None_
      Else
     Begin
      Error(Q,UnknownIdentifier); { Unknown identifier. }
      If(SkipBeg)Then Begin
       PutFileTxtLn(Q.HandlePas,'Begin');
       SkipBeg:=False;
      End;
      If(Q.Line[Q.I]='-')and(Q.Line[Q.I+1]='>')Then ExtractCWord;
      SkipSpcRem(False);
      Case Q.Line[Q.I]of
       '<': ConvShl;
       '>': ConvShr;
	    {* * * * * * * * * * * * * * * * * * * * * *}
	    {*                   Dec                   *}
	    {* * * * * * * * * * * * * * * * * * * * * *}
       '-': Begin
	     Inc(Q.I);
	     Case Q.Line[Q.I]of
	      '=': Begin
		    Inc(Q.I);
		    PutFileTxt(Q.HandlePAS,'Dec('+WordC+',');
		    GotoPointVirgule;
		    PutFileTxt(Q.HandlePAS,');');
		    Inc(Q.I);
		   End;
	      '-': Begin
		    PutFileTxt(Q.HandlePas,'Dec('+WordC+')');
		    Inc(Q.I);
		   End;
	      '>': Begin
		    PutFileTxt(Q.HandlePAS,WordC+'.');
		    Inc(Q.I);
		   End;
	      Else PutFileTxt(Q.HandlePas,WordC+'-'+Q.Line[Q.I]);
	     End;
	    End;
	    {* * * * * * * * * * * * * * * * * * * * * *}
	    {*                   Inc                   *}
	    {* * * * * * * * * * * * * * * * * * * * * *}
       '+': Begin
	     Inc(Q.I);
	     Case Q.Line[Q.I]of
	      '=': Begin
		    Inc(Q.I);
		    PutFileTxt(Q.HandlePas,'Inc('+WordC+',');
		    GotoPointVirgule;
		    PutFileTxt(Q.HandlePas,');');
		    Inc(Q.I);
		   End;
	      '+': Begin
		    PutFileTxt(Q.HandlePAS,'Inc('+WordC+')');
		    Inc(Q.I);
		   End;
	      Else PutFileTxt(Q.HandlePas,WordC+'+'+Q.Line[Q.I]);
	     End;
	    End;
       Else PutFileTxt(Q.HandlePas,WordC);
      End;
     End;
    End;
    {* * * * * * * * * * * * * * * * * * * * * *}
    {*             Special Number (Hex)        *}
    {* * * * * * * * * * * * * * * * * * * * * *}
    '0':Begin
     Msg:=ExtractCNum;
     If Msg<>''Then PutFileTxt(Q.HandlePAS,Msg)
               Else Error(Q,SyntaxNumber);
    End;
    {* * * * * * * * * * * * * * * * * * * * * *}
    {*         Conditionnel Directive          *}
    {* * * * * * * * * * * * * * * * * * * * * *}
    '#':Begin
     Err:=CondC2Pascal(Q);
     DumpWarning(Q);
     Q.WarPos:=0;
     Error(Q,Err);
     If(Err=IncludeFile)Then Begin
      If Q.Output=''Then
       HaltMsg(Q,'Le fichier: '''+Q.Output+''' est introuvable.');
      Warning(Q,'Inclusion du fichier '+Q.Output+' dans le fichier principale.');
      ConvFile(Q,Q.Output);
      {$IFDEF CONSOLE}
       WriteLn;
       WriteLn(Q.NameC,':');
      {$ENDIF}
     End;
    End;
    {* * * * * * * * * * * * * * * * * * * * * *}
    {*                   Begin                 *}
    {* * * * * * * * * * * * * * * * * * * * * *}
    '{':Begin
    (* If Not(InProc)Then Begin
      {* * * * * * * * * * * * * * * * * * * * * *}
      {*            Enumeration Variable         *}
      {* * * * * * * * * * * * * * * * * * * * * *}
      Inc(I,Length('}'));
      SkipSpc(No);
      ReadEnum;
     End
      Else*)
     Begin
      SkipBeg:=False;
      If Q.Beg>0Then PutFileTxt(Q.HandlePas,'Begin ')
                     Else SkipBeg:=True;
      Inc(Q.I,Length('{'));
      Inc(Q.Beg);
     End;
    End;
    {* * * * * * * * * * * * * * * * * * * * * *}
    {*                    End                  *}
    {* * * * * * * * * * * * * * * * * * * * * *}
    '}' :Begin
     PutFileTxt(Q.HandlePas,'End;');
     Inc(Q.I,Length('}'));
     If Q.Beg=0Then Error(Q,MisplacedEndSymbol);
     Dec(Q.Beg);
     If Q.Beg=0Then InProc:=False;
    End;
    {* * * * * * * * * * * * * * * * * * * * * *}
    {*             Symbole Record/-            *}
    {* * * * * * * * * * * * * * * * * * * * * *}
    '-':Begin
     Inc(Q.I,Length('-'));
     If Q.I<=Length(Q.Line)Then Begin
      Case Q.Line[Q.I]of
       '>':Begin
        PutFileTxt(Q.HandlePas,'.');
	Inc(Q.I);
       End;
       Else PutFileTxt(Q.HandlePas,'-');
      End;
     End;
    End;
    {* * * * * * * * * * * * * * * * * * * * * *}
    {*                 Execption               *}
    {* * * * * * * * * * * * * * * * * * * * * *}
    Else
    Begin
     PutFileTxt(Q.HandlePAS,Q.Line[Q.I]);
     Inc(Q.I);
    End;
   End;
  End;
  PutFileLn(Q.HandlePas);
 Until EOF(Q.HandleC);
 Close(Q.HandleC);
End;

Procedure DoneC2Pas(Var Q:SwitchC2Pascal);Begin
 ALDone(Q.BoolDir);
 FileClose(Q.HandlePas);
End;

{$IFDEF CONSOLE}
 Procedure Main;
 Var
  MainName:PathStr;
  D:DirStr;
  N:NameStr;
  E:ExtStr;
  NamePAS:PathStr;
  I:Byte;
  Q:SwitchC2Pascal;
 Begin
  InitC2Pas(Q);
  StartUpC2Pas(Q);
  WarnNum:=0;
  If Q.SourceName=''Then Begin
   System.WriteLn('Erreur: Pas de nom de fichier dans les paramŠtres');
   Halt;
  End;
  MainName:=Q.SourceName;
  FSplit(MainName,D,N,E);
  NamePAS:=D+N+'.PAS';
  If FileExist(NamePas)Then Begin
   If(Q.WarningMsg)Then Begin
    System.WriteLn('Attention: Fichier existant ''',NamePAS,''', puis ‚craser');
    Inc(WarnNum);
   End;
  End;
  Q.HandlePas:=New(NamePas);
  If(Q.Rem)Then Begin
   PutFileTxtLn(Q.HandlePas,'{'+MultChr('.',60)+'}');
   PutFileTxtLn(Q.HandlePas,'{:                    Fichier Pascal                        :}');
   PutFileTxtLn(Q.HandlePas,'{:'+MultChr('.',58)+':}');
  End;
  PutFileLn(Q.HandlePas);
  ConvFile(Q,MainName);
  Proc.Done;
  Close(Q.HandlePas);
  If(Q.WarningMsg)Then System.WriteLn('*** ',WarnNum,' attention(s) ***');
  System.WriteLn;
  System.WriteLn('      M‚moire disponible ',MemAvail);
 End;
{$ENDIF}
