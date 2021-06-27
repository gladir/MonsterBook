{ ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ

 ³           Compilateur Pascal Niveau B57/TraŒtement de ligne          ³
                     Malte Genesis IV: Alias Chantal
 ³                                                                      ³
            Tous droits r‚serv‚s par les Chevaliers de Malte
 ³                                                                      ³

 ³                            1998 … 2000                               ³

  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ


 Nom du programmeur
 ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

  Sylvain Maltais


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette unit‚ renferme toutes les routines destin‚es au traŒtements de
 lignes du fichier source Pascal.
}

Unit PCLine;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                 INTERFACE
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses Systex,PCCortex;

Function  EOF:Boolean;
Function  OpenInclusion(NewFile:String):SmallInt;
Function  ReadLn:String;
Procedure RestoreAddr;
Procedure SaveAddr;
Function  SI:Char;
Function  SkipSpcInLn(Var I:Byte;Var S:String):SmallInt;
Function  XtrkData(Var Q:Variant):Boolean;
Function  XtrkFormule(Var Q:Variant;Computed:Boolean;Var Reg:Byte):Boolean;
Function  XtrkInteger(Var Ok:Bool):LongInt;
Function  XtrkLabelAsm:String;
Function  XtrkNmAsm(Var Nm:AsmNmType):LongInt;
Function  XtrkString(Var Out:String):Boolean;
Function  XtrkWd:String;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                IMPLEMENTATION
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses Memories,Systems,PCData,PCBase,PCCompile,Math
     {$IFDEF IDE}
      ,Dials,OVIde
     {$ENDIF};

Var
 LastFP,ONL:LongInt;
 LastI,OldCurrCond:Byte;
 LastS:String;

{ Cette proc‚dure permet de restituer l'ancien position courante dans
 le fichier en traŒn d'ˆtre compil‚e.
}

Procedure RestoreAddr;Begin
 If CurrPC.Handle>=50Then Begin
  While(CurrPC.NL<>ONL)do Begin
   ALPrevious(CurrPC.XEdt^.List);
   Dec(CurrPC.NL);
  End;
 End;
 CurrPC.FP:=LastFP;
 CurrPC.I:=LastI;
 CurrPC.S:=LastS;
 CurrPC.NL:=ONL;
 CurrPC.CurrCond:=OldCurrCond;
End;

{ Cette proc‚dure permet de sauvegarder la position courante dans le
 fichier en traŒn d'ˆtre compil‚e.
}

Procedure SaveAddr;Begin
 LastFP:=CurrPC.FP;
 LastI:=CurrPC.I;
 LastS:=CurrPC.S;
 ONL:=CurrPC.NL;
 OldCurrCond:=CurrPC.CurrCond;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                             Fonction XtrkWord                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction extraŒt d'une chaŒne de caractŠre de style Pascal ou Basic
 un mot former de lettre minuscules  ou majuscules contenant dans la chaŒne
 d'origine … la position de la variable de param‚trage ®I¯. La variable ®I¯
 se trouve ensuite  incr‚ment‚  … la fin du mot extraŒt  de fa‡on … pouvoir
 d'autres caractŠres de diff‚rents types la suivant.


 Remarque
 ÍÍÍÍÍÍÍÍ

  ş Dans  cette fonction  nous parlons  de mot litt‚raire  (regroupement de
    une / plusieurs  lettre(s)  variable)  et  non pas  au sens  des micro-
    processeurs avec 2 ou 4 octets de taille fixe.
}

Function XtrkWord(Var I:Byte;Const L:String):String;Near;
Var
 LL:Byte Absolute L;
 S:String;
Begin
 XtrkWord:='';
 If(I>LL)or Not(L[I]in['A'..'Z','a'..'z','_',#128..#255])Then Exit;
 S:='';
 While(I<=LL)do If(L[I]in['A'..'Z','a'..'z','0'..'9','_',#128..#255])Then Begin
  Case L[I]of
   '‡','€':IncStr(S,'C');
   '‚','':IncStr(S,'E');
   Else IncStr(S,ChrUp(L[I]));
  End;
  Inc(I);
 End
  Else
 Break;
 XtrkWord:=S;
End;

Function EOF:Boolean;Begin
 {$IFDEF IDE}
  If CurrPC.Handle>=50Then EOF:=CurrPC.NL>=CurrPC.XEdt^.List.Count
   Else
 {$ENDIF}
 If ALIsEmpty(CurrPC.Include)Then EOF:=Not(CurrPC.FS>=CurrPC.FP)
                             Else EOF:=False
End;

Var OldTime:Byte;

Function ReadLn:String;
Var
 S:String;
 XT:Byte;
 PC:PChr;
Begin
 XT:=GetRawTimerB and$F8;
 If(XT<>OldTime)Then Begin
  {$IFDEF IDE}
   WEPutTxtXY(CurrPC.WC,33,4,StrUSpc(CStr(CurrPC.NL),12));
   WEPutTxtXY(CurrPC.WC,33,5,CStr(CurrPC.Macro.Count));
   WEPutTxtXY(CurrPC.WC,33,6,CStr(CurrPC.ReDef.Count+CurrPC.GhostConst));
   WEPutTxtXY(CurrPC.WC,33,7,CStr(CurrPC.VarBk.Count));
   WEPutTxtXY(CurrPC.WC,33,8,CStr(CurrPC.TypeDef.Count));
   WEPutTxtXY(CurrPC.WC,33,9,CStr(CurrPC.ProcBk.Count));
   WEPutTxtXY(CurrPC.WC,33,10,CStr(CurrPC.GhostCode+CurrPC.IP-CurrPC.Org));
   WEPutTxtXY(CurrPC.WC,33,11,StrUSpc(CStr(MemAvail),12));
   WEPutTxtXY(CurrPC.WC,33,12,GetStrTimeInPrg);
  {$ELSE}
   S:='('+Str(CurrPC.NL)+')';
   Write(S+MultChr(#8,Length(S)));
  {$ENDIF}
  OldTime:=XT;
 End;
 {$IFDEF IDE}
  If CurrPC.Handle>=50Then Begin
   PC:=_ALGetCurrBuf(CurrPC.XEdt^.List);S:=StrPas(PC);
   ALNext(CurrPC.XEdt^.List);
  End
   Else
 {$ENDIF}
 __GetAbsFileTxtLn(CurrPC.Handle,CurrPC.FP,S);
 CurrPC.I:=1;
 Inc(CurrPC.NL);
 While S=''do Begin
  {$IFDEF IDE}
   If CurrPC.Handle>=50Then Begin
    PC:=_ALGetCurrBuf(CurrPC.XEdt^.List);S:=StrPas(PC);
    ALNext(CurrPC.XEdt^.List);
   End
    Else
  {$ENDIF}
  __GetAbsFileTxtLn(CurrPC.Handle,CurrPC.FP,S);
  Inc(CurrPC.NL);
  If(CurrPC.FP>=CurrPC.FS)Then Begin
   If ALIsEmpty(CurrPC.Include)Then Break
    Else
   Begin
     { Fermer le fichier ‚tant actuellemenent utilis‚ (puisque de }
     { toute fa‡on il vient d'ˆtre complŠtement lus...).}
    FileClose(CurrPC.Handle);
     { Restauration des donn‚es }
    CurrPC.PInclude:=_ALGetBuf(CurrPC.Include,CurrPC.Include.Count-1);
    If(CurrPC.PInclude=NIL)Then Break;
    CurrPC.MainFile:=CurrPC.PInclude^.Path;
    CurrPC.FP:=CurrPC.PInclude^.FP;CurrPC.FS:=CurrPC.PInclude^.FS;
    CurrPC.I:=CurrPC.PInclude^.I;S:=CurrPC.PInclude^.Line;
     { liminer les donn‚es venant d'ˆtre extraŒte... }
    If Not ALDelBuf(CurrPC.Include,CurrPC.Include.Count-1)Then Break;
     { Ouvre le fichier avec les donn‚es venant d'ˆtre restaurer }
    CurrPC.Handle:=FileOpen(CurrPC.MainFile,fmRead);
    If(CurrPC.Handle=errHdl)Then Break;
   End;
  End;
 End;
 If(EOF)Then GetSysErr:=errEOF;
 ReadLn:=S;
End;

Function OpenInclusion;Begin
 CurrPC.PInclude:=ALAdd(CurrPC.Include,SizeOf(IncludeRec));
 If(CurrPC.PInclude=NIL)Then OpenInclusion:=OutOfMemory
  Else
 Begin
  CurrPC.PInclude^.Path:=CurrPC.MainFile;
  CurrPC.PInclude^.FP:=CurrPC.FP;CurrPC.PInclude^.FS:=CurrPC.FS;
  CurrPC.PInclude^.I:=CurrPC.I;
  CurrPC.PInclude^.Line:=CurrPC.S;
  FileClose(CurrPC.Handle);
  CurrPC.Handle:=FileOpen(NewFile,fmRead);
  If(CurrPC.Handle=errHdl)Then OpenInclusion:=FileNotFound
   Else
  Begin
   CurrPC.FP:=0;CurrPC.FS:=FileSize(CurrPC.Handle);
   CurrPC.I:=1;CurrPC.CurrFile:=NewFile;
   __GetAbsFileTxtLn(CurrPC.Handle,CurrPC.FP,CurrPC.S);
  End;
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Fonction SkipSpcInLn                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet  de passer  toutes les espaces,  commentaires et
 directives conditions avant les prochaines instructions proprement dite
 de langage Pascal.
}

Function SkipSpcInLn(Var I:Byte;Var S:String):Int;
Label
 Restart,SInclude,Param,FinishBigRem;
Var
 S2:String;
 BigRem,Ok:Boolean;
 l:LongInt;
Begin
 SkipSpcInLn:=0;
Restart:
 Systems.SkipSpcInLn(I,S);
 If Not(CurrPC.InRem)Then Case StrI(I,S)of
  #0:Begin
   S:=ReadLn;I:=1;
   If(GetSysErr=errEOF)Then Exit;
   Goto Restart;
  End;
  '/':If(CSyntax)and(StrI(I+1,S)='/')Then Begin { // Remarque de C/C++ ? }
   S:=ReadLn;I:=1;
   If(GetSysErr=errEOF)Then Exit;
   Goto Restart;
  End;
  '#':If(CSyntax)Then Begin
   CurrPC.W:=I;Inc(I);
   If(I>=Length(S))and(Not IsRomanLetter(StrI(I,S)))Then I:=CurrPC.W
    Else
   Begin
    S2:=XtrkWd;
    If S2='INCLUDE'Then Begin
     Systems.SkipSpcInLn(I,S);
     CurrPC.S3:=Copy(S,I,255);
     If CurrPC.S3=''Then Begin;SkipSpcInLn:=IdentifierExpected;Exit;End;
     OpenInclusion(CurrPC.S3);
     Goto Restart;
    End
     Else
    I:=CurrPC.W;
   End;
  End;
  '(':If StrI(I+1,S)='*'Then Begin
   CurrPC.InRem:=Ya;Inc(I,2);BigRem:=Ya;
   If StrI(I,S)='$'Then Goto Param;
FinishBigRem:
   Repeat
    Inc(I);
    If StrI(I,S)=#0Then Begin
     S:=ReadLn;I:=1;
     If(GetSysErr=errEOF)Then Exit;
    End;
   Until(StrI(I,S)='*')and(StrI(I+1,S)=')');
   Inc(I,2);CurrPC.InRem:=No;
   Goto Restart;
  End;
  '{':Begin
   CurrPC.InRem:=Ya;Inc(I);BigRem:=No;
   If StrI(I,S)='$'Then Begin
Param:Inc(I);
    Case(SI)of
     '2':Begin
      Inc(I);
      Case StrI(I,S)of
       '+': InstrFormat:=p286;
       '-': InstrFormat:=p88;
       Else Begin;SkipSpcInLn:=SyntaxError;Exit;End;
      End;
     End;
     '3':Begin
      Inc(I);
      Case StrI(I,S)of
       '+': InstrFormat:=p386;
       '-': InstrFormat:=p88;
       Else Begin;SkipSpcInLn:=SyntaxError;Exit;End;
      End;
     End;
     '4':Begin
      Inc(I);
      Case StrI(I,S)of
       '+': InstrFormat:=p486;
       '-': InstrFormat:=p88;
       Else Begin;SkipSpcInLn:=SyntaxError;Exit;End;
      End;
     End;
     '5':Begin
      Inc(I);
      Case StrI(I,S)of
       '+': InstrFormat:=p586;
       '-': InstrFormat:=p88;
       Else Begin;SkipSpcInLn:=SyntaxError;Exit;End;
      End;
     End;
     '6':Begin
      Inc(I);
      Case StrI(I,S)of
       '+': InstrFormat:=p686;
       '-': InstrFormat:=p88;
       Else Begin;SkipSpcInLn:=SyntaxError;Exit;End;
      End;
     End;
     Else Begin
      S2:=XtrkWd;
      If(S2='C')or(S2='COMMENTARY')Then Begin
       Systems.SkipSpcInLn(I,S);
       S2:='';
       While Not(StrI(I,S)in['}',#0])do IncStr(S2,S[I]);
       PushInstr(S2);
      End
       Else
      If(S2='F')or(S2='FAR')Then Begin
       Case StrI(I,S)of
        '+': CurrPointer:=cmwpFar;
        '-': CurrPointer:=cmwpNear;
        Else Begin;SkipSpcInLn:=SyntaxError;Exit;End;
       End;
      End
       Else
      If S2='G'Then Begin
       Case StrI(I,S)of
        '+': InstrFormat:=p286;
        '-': InstrFormat:=p88;
        Else Begin;SkipSpcInLn:=SyntaxError;Exit;End;
       End;
      End
       Else
      If S2='I'Then Begin
       Case StrI(I,S)of
        '+','-':;
        Else Begin
 SInclude:
         Systems.SkipSpcInLn(I,S);
         S2:='';
         While Not(StrI(I,S)in['}',#0])do IncStr(S2,S[I]);
 {        l:=0;}
         CurrPC.W:=OpenInclusion(S2);
         If CurrPC.W<>0Then Begin
          SkipSpcInLn:=CurrPC.W;
          Exit;
         End
          Else
         Goto Restart;
         {W:=CompileFile(S2,l);
         If W<>0Then Begin NL:=l;SkipSpcInLn:=W;Exit;End;}
        End;
       End;
      End
       Else
      If S2='IFOPT'Then Begin
       Case(SI)of
        '1'..'6':Begin
         Case(SI)of
          '1':Ok:=InstrFormat>=p186;
          '2','G':Ok:=InstrFormat>=p286;
          '3':Ok:=InstrFormat>=p386;
          '4':Ok:=InstrFormat>=p486;
          '5':Ok:=InstrFormat>=p586;
          '6':Ok:=InstrFormat>=p686;
          'F':Ok:=CurrPointer=cmwpFar;
         End;
         Inc(I);
         Case(SI)of
          '+':;
          '-':Ok:=Not Ok;
          Else Begin
           SkipSpcInLn:=SyntaxError;
           Exit;
          End;
         End;
         If(Ok)Then Begin
          CurrPC.ArrayCond[CurrPC.CurrCond]:=cEndIf;
          Inc(CurrPC.CurrCond);
         End
          Else
         Begin
          Inc(I);CurrPC.ArrayCond[CurrPC.CurrCond]:=cElse;
          If SI<>'}'Then Begin;SkipSpcInLn:=CloseParExpected;Exit;End;
          Inc(I);l:=0;
          If(CurrPC.ArrayCond[CurrPC.CurrCond]=cEndIf)Then Begin
           Repeat
            Case(SI)of
             '{':Begin
              Inc(I);
              If SI='$'Then Begin
               Inc(I);S2:=XtrkWd;
               If(S2='IFOPT')or(S2='IFDEF')Then Inc(l)Else
               If S2='ENDIF'Then Dec(l)Else
               If S2='ELSE'Then Begin
                If l=0Then Break;
               End
                Else
               Exit;
              End;
              While SI<>'}'do Begin
               Inc(I);
               If(EOF)Then Begin;SkipSpcInLn:=CloseParExpected;Exit;End;
              End;
             End;
             Else Inc(I);
            End;
           Until l=-1;
          End;
          If l=0Then Inc(CurrPC.CurrCond);
         End;
        End;
       End;
      End
       Else
      If S2='ELSE'Then Begin
       If(CurrPC.CurrCond>0)and(CurrPC.ArrayCond[CurrPC.CurrCond-1]=cEndIf)Then Begin
        While SI<>'}'do Begin
         Inc(I);
         If(EOF)Then Begin;SkipSpcInLn:=CloseParExpected;Exit;End;
        End;
        l:=0;
        Repeat
         Case(SI)of
          '{':Begin
           Inc(I);
           If SI='$'Then Begin
            Inc(I);S2:=XtrkWd;
            If(S2='IFOPT')or(S2='IFDEF')Then Inc(l)Else
            If S2='ENDIF'Then Dec(l)Else
            If S2='ELSE'Then Begin
             If l=0Then Break;
            End
             Else
            Begin;SkipSpcInLn:=SyntaxError;Exit;End;
           End;
           While SI<>'}'do Begin
            Inc(I);
            If(EOF)Then Begin;SkipSpcInLn:=CloseParExpected;Exit;End;
           End;
          End;
          Else Inc(I);
         End;
        Until l=-1;
        Dec(CurrPC.CurrCond);
       End
        Else
       Begin
        SkipSpcInLn:=SyntaxError;
        Exit;
       End;
       Dec(I);
      End
       Else
      If S2='ENDIF'Then Begin
       If CurrPC.CurrCond>0Then Dec(CurrPC.CurrCond)
        Else
       Begin
        SkipSpcInLn:=SyntaxError;
        Exit;
       End;
       Dec(I);
      End
       Else
      If S2='ORIGINE'Then Begin
       l:=XtrkInteger(Ok);
       If Not(Ok)Then Begin
        SkipSpcInLn:=SyntaxNumber;
        Exit;
       End;
       If l>65520Then Begin
        SkipSpcInLn:=TooBigNumber;
        Exit;
       End;
       CurrPC.Org:=l;CurrPC.IP:=CurrPC.Org+3;
      End
       Else
      If S2='M'Then Begin
       StackSize:=XtrkInteger(Ok);
       If Not(Ok)Then Begin;SkipSpcInLn:=SyntaxNumber;Exit;End;
       If StrI(I,S)<>','Then Begin;SkipSpcInLn:=VirguleExpected;Exit;End;
       Inc(I);
       MinParag:=XtrkInteger(Ok);
       If Not(Ok)Then Begin;SkipSpcInLn:=SyntaxNumber;Exit;End;
       If StrI(I,S)<>','Then Begin;SkipSpcInLn:=VirguleExpected;Exit;End;
       Inc(I);
       MaxParag:=XtrkInteger(Ok);
       If Not(Ok)Then Begin;SkipSpcInLn:=SyntaxNumber;Exit;End;
      End
       Else
      If S2='INCLUDE'Then Goto SInclude Else
      If S2='MOT_CLEF'Then Begin
       If(Body<>bPRELUDE)Then Begin
        SkipSpcInLn:=MisplacedCondDirective;
        Exit;
       End;
       S2:=XtrkWd;Ok:=No;
       l:=XtrkInteger(Ok);
       If(l>cmwpMax)Then Begin
        SkipSpcInLn:=InvalidNumber;
        Exit;
       End;
       If Not AddResWord(S2,l)Then Begin
        SkipSpcInLn:=OutOfMemory;
        Exit;
       End;
       Dec(I);
      End
       Else
      If S2='COMPILE_CLEF'Then Begin
       MakeResWord;
       Dec(I);
      End
       Else
      If S2='BOOT'Then ProgramFormat:=fBOOT;
     End;
    End;
   End;
   If(BigRem)Then Goto FinishBigRem;
   Repeat
    Inc(I);
    If StrI(I,S)=#0Then Begin
     S:=ReadLn;I:=1;
     If(GetSysErr=errEOF)Then Exit;
    End;
   Until StrI(I,S)='}';
   Inc(I);
   CurrPC.InRem:=No;
   Goto Restart;
  End;
 End;
End;

Function SearchMacro(Const Name:String):MacroPtr;
Var
 PMac:MacroPtr;
Begin
 If CurrPC.Macro.Count>0Then Begin
  ALSetPtr(CurrPC.Macro,0);
  Repeat
   PMac:=_ALGetCurrBuf(CurrPC.Macro);
   If(PMac^.Name=Name)Then Begin;SearchMacro:=PMac;Exit;End;
   ALNext(CurrPC.Macro);
  Until PMac=NIL;
 End;
 SearchMacro:=NIL;
End;

Function XtrkWd:String;
Label Home;
Var
 W:String;
 PMac:MacroPtr;
Begin
Home:
 SkipSpcInLn(CurrPC.I,CurrPC.S);
 XtrkWd:='';
 While(CurrPC.I>Length(CurrPC.S))or((CurrPC.FP>=CurrPC.FS)and(CurrPC.Include.Count>0))do Begin
  If(EOF)Then Exit;
  CurrPC.S:=ReadLn;
  If SkipSpcInLn(CurrPC.I,CurrPC.S)<>0Then Exit;
 End;
 W:=XtrkWord(CurrPC.I,CurrPC.S);
 PMac:=SearchMacro(W);
 If(PMac<>NIL)Then Begin
  If SI<>';'Then Exit;
  Inc(CurrPC.I);
  CurrPC.PInclude:=ALAdd(CurrPC.Include,SizeOf(IncludeRec));
  If(CurrPC.PInclude=NIL)Then Exit
   Else
  Begin
   CurrPC.PInclude^.Path:=CurrPC.CurrFile;
   CurrPC.PInclude^.FP:=CurrPC.FP;
   CurrPC.PInclude^.FS:=CurrPC.FS;
   CurrPC.PInclude^.I:=CurrPC.I;
   CurrPC.PInclude^.Line:=CurrPC.S;
   FileClose(CurrPC.Handle);
   CurrPC.Handle:=FileOpen(PMac^.Path,fmRead);
   If(CurrPC.Handle=errHdl)Then Exit
    Else
   Begin
    CurrPC.FP:=PMac^.FB;
    CurrPC.FS:=PMac^.FE;
    CurrPC.I:=1;CurrPC.CurrFile:=PMac^.Path;
    __GetAbsFileTxtLn(CurrPC.Handle,CurrPC.FP,CurrPC.S);
    Goto Home;
   End;
  End;
 End
  Else
 XtrkWd:=W
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Fonction XtrkAsm                           Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet d'extraire un  identificateur d'assembleur dans un
 bloc  de  code  source  Pascal contenu  dans une  chaŒne de caractŠres de
 format Pascal.
}

Function XtrkAsm(Var I:Byte;Const L:String):String;
Var
 LL:Byte Absolute L;
 S:String;
Begin
 XtrkAsm:='';
 If(I>LL)or Not(L[I]in['@','A'..'Z','a'..'z','_',#128..#255])Then Exit;
 S:='';
 While(I<=LL)do If(L[I]in['@','A'..'Z','a'..'z','0'..'9','_',#128..#255])Then Begin
  Case L[I]of
   '‡','€':IncStr(S,'C');
   '‚','':IncStr(S,'E');
   Else IncStr(S,ChrUp(L[I]));
  End;
  Inc(I);
 End
  Else
 Break;
 XtrkAsm:=S;
End;

Function XtrkLabelAsm:String;
Label
 Home;
Var
 W:String;
 PMac:MacroPtr;
Begin
Home:
 SkipSpcInLn(CurrPC.I,CurrPC.S);
 XtrkLabelAsm:='';
 While(CurrPC.I>Length(CurrPC.S))or((CurrPC.FP>=CurrPC.FS)and(CurrPC.Include.Count>0))do Begin
  If(EOF)Then Exit;
  CurrPC.S:=ReadLn;
  If SkipSpcInLn(CurrPC.I,CurrPC.S)<>0Then Exit;
 End;
 W:=XtrkAsm(CurrPC.I,CurrPC.S);{W:=XtrkWord(I,S);}PMac:=SearchMacro(W);
 If(PMac<>NIL)Then Begin
  CurrPC.PInclude:=ALAdd(CurrPC.Include,SizeOf(IncludeRec));
  If(CurrPC.PInclude=NIL)Then Exit
   Else
  Begin
   CurrPC.PInclude^.Path:=CurrPC.CurrFile;
   CurrPC.PInclude^.FP:=CurrPC.FP;
   CurrPC.PInclude^.FS:=CurrPC.FS;
   CurrPC.PInclude^.I:=CurrPC.I;
   CurrPC.PInclude^.Line:=CurrPC.S;
   FileClose(CurrPC.Handle);
   CurrPC.Handle:=FileOpen(PMac^.Path,fmRead);
   If(CurrPC.Handle=errHdl)Then Exit
    Else
   Begin
    CurrPC.FP:=PMac^.FB;
    CurrPC.FS:=PMac^.FE;
    CurrPC.I:=1;CurrPC.CurrFile:=PMac^.Path;
    __GetAbsFileTxtLn(CurrPC.Handle,CurrPC.FP,CurrPC.S);
    Goto Home;
   End;
  End;
 End
  Else
 XtrkLabelAsm:=W
End;

Function SI:Char;Begin
 SkipSpcInLn(CurrPC.I,CurrPC.S); SI:=#0;
 While CurrPC.I>Length(CurrPC.S)do Begin
  If(EOF)Then Exit;
  CurrPC.S:=ReadLn;
  If SkipSpcInLn(CurrPC.I,CurrPC.S)<>0Then Exit;
 End;
 SI:=StrI(CurrPC.I,CurrPC.S);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Fonction XtrkData                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet d'extraire une donn‚e de n'importe quel format
 (nombre, chaŒnes de caractŠres,...).
}

Function XtrkData;
Var
 T:String;
 J:RBP;
 OldI:Byte;
 PCst:^CstRec;
 Format:CstRec;
Begin
 XtrkData:=No;OldI:=CurrPC.I;
 FillClr(Q,SizeOf(Q));
 If SkipSpcInLn(CurrPC.I,CurrPC.S)<>0Then Exit;
 Q.TypeDef:=tLong;
 Case(SI)of
  '$':Begin
   Inc(CurrPC.I);
   T:=XtrkHexNm(CurrPC.I,CurrPC.S);
   If T=''Then Exit;
   Q.X.DataLong:=HexStrToInt(T);
  End;
  '-':Begin
   Inc(CurrPC.I);
   T:='-'+XtrkDecNm(CurrPC.I,CurrPC.S);
   Q.X.DataLong:=StrToInt(T)
  End;
  Else Begin
   T:='';
   If StrI(CurrPC.I,CurrPC.S)in['0'..'9']Then T:=XtrkHexNm(CurrPC.I,CurrPC.S);
   If T=''Then Begin
    T:=XtrkWd;
    If Not ALIsEmpty(CurrPC.ReDef)Then Begin
     ALSetPtr(CurrPC.ReDef,0);
     For J:=0to CurrPC.ReDef.Count-1do Begin
      PCst:=_ALGetCurrBuf(CurrPC.ReDef);
      If(PCst^.Name=T)Then Begin
       Q:=PCst^.Q;XtrkData:=Ya;Exit;
      End;
      ALNext(CurrPC.ReDef);
     End;
    End;
    If SearchConstList(T,Format)Then Begin
     Q:=Format.Q;
     XtrkData:=Ya;
     Exit;
    End;
    CurrPC.I:=OldI;
    Exit;
   End;
   Case StrI(CurrPC.I,CurrPC.S)of
    'o','O':Begin
     Inc(CurrPC.I);
     For J:=1to Length(T)do If Not(T[J]in['0'..'7'])Then Exit;
     Q.X.DataLong:=OctStr2Nm(T)
    End;
    'b','B':Begin
     Inc(CurrPC.I);
     For J:=1to Length(T)do If Not(T[J]in['0','1'])Then Exit;
     Q.X.DataLong:=BinStr2Nm(T)
    End;
    'h','H':Begin
     Inc(CurrPC.I);
     For J:=1to Length(T)do If Not(T[J]in['0'..'9','A'..'F','a'..'f'])Then Exit;
     Q.X.DataLong:=HexStrToInt(T)
    End;
    Else Begin
     For J:=1to Length(T)do If Not(T[J]in['0'..'9'])Then Exit;
     Q.X.DataLong:=StrToInt(T)
    End;
   End;
  End;
 End;
 XtrkData:=Ya;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Fonction XtrkInteger                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet d'extraire un nombre de format entier (Integer).
}

Function XtrkInteger;
Var
 Q:Variant;
Begin
 Ok:=XtrkData(Q);
 XtrkInteger:=Q.X.DataLong;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Fonction XtrkFormule                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet d'extraire une formule math‚matiques ‚crite en
 langage Pascal et de la transformer en code machine.
}

Function XtrkFormule;
Label
 1,2,Exit;
Type
 PostFixeRec=Record
  Operateur:Boolean; { Op‚rateur sinon nombre...}
  Position:(xNone,xVariable,xRegister,xStack);
  Reg:Byte;          { Num‚ro de registre si dans registre }
  OperTitle:Char;    { Titre de l'op‚rateur }
  Valeur:Variant;    { Valeur contenu dans l'expression }
  VarData:VarRec;    { Donner sur la variable }
  Priorite:Integer;  { Niveau de priorit‚ }
 End;
 PostFixePtr=^PostFixeRec;
Var
 Pile,PostFixe:ArrayList;
 PPostFixe,PPostFixe2:PostFixePtr;
 Ok:Boolean;
 PVar:^VarRec;
 J,Paren:SmallInt;
 PostFixeA,PostFixeB,PostFixePile,PostFixeData:PostFixeRec;
 T,SOper:String;

 Procedure PopPile;Begin
  PPostFixe:=_ALGetBuf(Pile,Pile.Count-1);
  PostFixePile:=PPostFixe^;
  ALDelBuf(Pile,Pile.Count-1);
 End;

 Function AsmOper(Code:Byte):Boolean;Begin
  AsmOper:=No;
  Case(PostFixeA.Valeur.TypeDef)of
   tLong:If(PostFixeA.Position=xRegister)Then Begin
     Case(PostFixeB.Position)of
      xRegister:If(InstrFormat>=p386)Then Push3Byte($66,Code+1,$C0+PostFixeA.Reg+(PostFixeB.Reg shl 3))
       Else
      Begin
       Push2Byte(Code+1,$C3); { AND AX,BX }
       Push2Byte(Code+1,$D1); { AND DX,CX }
      End;
      xNone:Begin
       If(InstrFormat>=p286)and(PostFixeA.Reg=0)Then
        Push3Byte(Code+5,PostFixeB.Valeur.X.DataByte,Hi(PostFixeB.Valeur.X.DataWord))
       Else
        PushInstr(#$81+Chr($C0+Code+PostFixeB.Reg)+Chr(PostFixeB.Valeur.X.DataByte)+
                  Chr(Hi(PostFixeB.Valeur.X.DataWord)));
       PushInstr(#$81+Chr($C2+Code)+Chr(LongRec(PostFixeB.Valeur.X.DataLong).Hi)+
                  Chr(Hi(LongRec(PostFixeB.Valeur.X.DataLong).Hi))); { AND DX,HighLong}
      End;
      Else System.Exit;
     End;
    End
     Else
    Case(Code)of
     $30:PostFixeData.Valeur.X.DataLong:=PostFixeA.Valeur.X.DataWord xor PostFixeB.Valeur.X.DataLong;
     $28:PostFixeData.Valeur.X.DataLong:=PostFixeA.Valeur.X.DataWord-PostFixeB.Valeur.X.DataLong;
     $20:PostFixeData.Valeur.X.DataLong:=PostFixeA.Valeur.X.DataWord and PostFixeB.Valeur.X.DataLong;
     8:PostFixeData.Valeur.X.DataLong:=PostFixeA.Valeur.X.DataWord or PostFixeB.Valeur.X.DataLong;
     0:PostFixeData.Valeur.X.DataLong:=PostFixeA.Valeur.X.DataWord+PostFixeB.Valeur.X.DataLong;
     Else System.Exit;
    End;
   tInt,tWord:If(PostFixeA.Position=xRegister)Then Begin
     If(Code=0)and(PostFixeB.Valeur.X.DataLong=1)Then PushByte($40+PostFixeA.Reg)
      Else
     Case(PostFixeB.Position)of
      xRegister:Push2Byte(Code+1,$C0+PostFixeA.Reg+(PostFixeB.Reg shl 3));
      xNone:If(InstrFormat>=p286)and(PostFixeA.Reg=0)Then
       Push3Byte(Code+5,PostFixeB.Valeur.X.DataByte,Hi(PostFixeB.Valeur.X.DataWord))
      Else
       PushInstr(#$81+Chr($C0+Code+PostFixeB.Reg)+Chr(PostFixeB.Valeur.X.DataByte)+
                 Chr(Hi(PostFixeB.Valeur.X.DataWord)));
      Else System.Exit;
     End;
    End
     Else
    Case(Code)of
     $30:PostFixeData.Valeur.X.DataWord:=PostFixeA.Valeur.X.DataWord xor PostFixeB.Valeur.X.DataWord;
     $28:PostFixeData.Valeur.X.DataWord:=PostFixeA.Valeur.X.DataWord-PostFixeB.Valeur.X.DataWord;
     $20:PostFixeData.Valeur.X.DataWord:=PostFixeA.Valeur.X.DataWord and PostFixeB.Valeur.X.DataWord;
     8:PostFixeData.Valeur.X.DataWord:=PostFixeA.Valeur.X.DataWord or PostFixeB.Valeur.X.DataWord;
     0:PostFixeData.Valeur.X.DataWord:=PostFixeA.Valeur.X.DataWord+PostFixeB.Valeur.X.DataWord;
     Else System.Exit;
    End;
   tShort,tBool,tByte:If(PostFixeA.Position=xRegister)Then Begin
     If(Code=0)and(PostFixeB.Valeur.X.DataLong=1)Then Push2Byte($FE,$C0+PostFixeA.Reg)
      Else
     Case(PostFixeB.Position)of
      xRegister:Push2Byte(Code,$C0+PostFixeA.Reg+(PostFixeB.Reg shl 3));
      xNone:If(InstrFormat>=p286)and(PostFixeA.Reg=0)Then
       Push2Byte(Code+4,PostFixeB.Valeur.X.DataByte)
      Else
       Push3Byte($80,$C0+Code+PostFixeB.Reg,PostFixeB.Valeur.X.DataByte);
      Else System.Exit;
     End;
    End
     Else
    Case(Code)of
     $30:PostFixeData.Valeur.X.DataByte:=PostFixeA.Valeur.X.DataByte xor PostFixeB.Valeur.X.DataByte;
     $28:PostFixeData.Valeur.X.DataByte:=PostFixeA.Valeur.X.DataByte-PostFixeB.Valeur.X.DataByte;
     $20:PostFixeData.Valeur.X.DataByte:=PostFixeA.Valeur.X.DataByte and PostFixeB.Valeur.X.DataByte;
     8:PostFixeData.Valeur.X.DataByte:=PostFixeA.Valeur.X.DataByte or PostFixeB.Valeur.X.DataByte;
     0:PostFixeData.Valeur.X.DataByte:=PostFixeA.Valeur.X.DataByte+PostFixeB.Valeur.X.DataByte;
     Else System.Exit;
    End;
   Else System.Exit;
  End;
  AsmOper:=Ya;
 End;

Begin
 XtrkFormule:=No;Reg:=$FF;Paren:=0;
 ALInit(PostFixe);
 ALInit(Pile);
  { D‚composition de la formule }
 PostFixeData.Operateur:=Ya;
 PostFixeData.Priorite:=-1;
 PostFixeData.Reg:=0;
 PPostFixe:=ALAdd(Pile,SizeOf(PostFixeRec));
 If(PPostFixe=NIL)Then Goto Exit;
 PPostFixe^:=PostFixeData;
 Repeat
  PostFixeData.Operateur:=Ya;
  Case(SI)of
   '(':Begin
    PostFixeData.OperTitle:=SI;
    Inc(CurrPC.I);
    PostFixeData.Priorite:=0;
    PPostFixe:=ALAdd(Pile,SizeOf(PostFixeRec));
    If(PPostFixe=NIL)Then Goto Exit;
    PPostFixe^:=PostFixeData;
    Inc(Paren);
   End;
   ')':If Paren=0Then Break
    Else
   Begin
    Inc(CurrPC.I);
    Dec(Paren);
    Repeat
     PopPile;
     If PostFixePile.OperTitle='('Then Break;
     PPostFixe:=ALAdd(PostFixe,SizeOf(PostFixeRec));
     If(PPostFixe=NIL)Then Goto Exit;
     PPostFixe^:=PostFixePile;
    Until Pile.Count=0;
   End;
   '+','-':Begin
    If(PostFixe.Count=0)and(SI='-')Then Goto 2;
    PostFixeData.OperTitle:=SI;
    Inc(CurrPC.I);PostFixeData.Priorite:=1;
   End;
   '*','/':Begin
    PostFixeData.OperTitle:=SI;
    Inc(CurrPC.I);PostFixeData.Priorite:=2;
   End;
   'A'..'Z','a'..'z':Begin
    SaveAddr;
    SOper:=XtrkWd;
    Case GetCodeMainWordPas(SOper)of
     cmwpAND:Begin
      PostFixeData.OperTitle:='ï';
      PostFixeData.Priorite:=2;
     End;
     cmwpDIV:Begin
      PostFixeData.OperTitle:='\';
      PostFixeData.Priorite:=2;
     End;
     cmwpMOD:Begin
      PostFixeData.OperTitle:='%';
      PostFixeData.Priorite:=2;
     End;
     cmwpNOT:Begin
      PostFixeData.OperTitle:='!';
      PostFixeData.Priorite:=3;
     End;
     cmwpOR:Begin
      PostFixeData.OperTitle:='U';
      PostFixeData.Priorite:=1;
     End;
     cmwpSHL:Begin
      PostFixeData.OperTitle:='¯';
      PostFixeData.Priorite:=2;
     End;
     cmwpSHR:Begin
      PostFixeData.OperTitle:='®';
      PostFixeData.Priorite:=2;
     End;
     cmwpXOR:Begin
      PostFixeData.OperTitle:='X';
      PostFixeData.Priorite:=1;
     End;
     Else Begin
      RestoreAddr;
      Goto 2;
     End;
    End;
   End;
   ',',';',':',#0:Break;
   Else Begin
  2:PostFixeData.Operateur:=No;
    PostFixeData.Priorite:=0;
    PostFixeData.Position:=xNone;
    If Not XtrkData(PostFixeData.Valeur)Then Begin
     If Not(Computed)Then Goto Exit;
     Ok:=No;T:=XtrkWd;
     If Not ALIsEmpty(CurrPC.VarBk)Then Begin
      ALSetPtr(CurrPC.VarBk,0);
      For J:=0to CurrPC.VarBk.Count-1do Begin
       PVar:=_ALGetCurrBuf(CurrPC.VarBk);
       If(PVar^.Name=T)Then Begin
        PostFixeData.Position:=xVariable;
        PostFixeData.VarData:=PVar^;
        PostFixeData.Valeur.TypeDef:=PostFixeData.VarData.TypeDef;
        Ok:=Ya;Break;
       End;
       ALNext(CurrPC.VarBk);
      End;
     End;
     If Not(Ok)Then Goto Exit;
    End;
    PPostFixe:=ALAdd(PostFixe,SizeOf(PostFixeRec));
    If(PPostFixe=NIL)Then Goto Exit;
    PPostFixe^:=PostFixeData;
   End;
  End;
  If PostFixeData.Priorite>0Then Begin
 1:PopPile;
   If(PostFixePile.Priorite<PostFixeData.Priorite)Then Begin
    PPostFixe:=ALAdd(Pile,SizeOf(PostFixeRec));
    If(PPostFixe=NIL)Then Goto Exit;
    PPostFixe^:=PostFixePile;
    PPostFixe:=ALAdd(Pile,SizeOf(PostFixeRec));
    If(PPostFixe=NIL)Then Goto Exit;
    PPostFixe^:=PostFixeData;
   End
    Else
   Begin
    PPostFixe:=ALAdd(PostFixe,SizeOf(PostFixeRec));
    If(PPostFixe=NIL)Then Goto Exit;
    PPostFixe^:=PostFixePile;
    Goto 1;
   End;
  End;
 Until No;
 While Pile.Count>1do Begin
  PopPile;
  PPostFixe:=ALAdd(PostFixe,SizeOf(PostFixeRec));
  If(PPostFixe=NIL)Then Goto Exit;
  PPostFixe^:=PostFixePile;
 End;
 PopPile;
  { valuation du PostFixe }
 ALSetPtr(PostFixe,0);
 For J:=0to PostFixe.Count-1do Begin
  PPostFixe2:=_ALGetCurrBuf(PostFixe);
  If(PPostFixe2=NIL)Then Goto Exit;
  If(PPostFixe2^.Operateur)Then Begin
   If PPostFixe2^.OperTitle<>'!'Then Begin
    PopPile;
    PostFixeB:=PostFixePile;
   End;
   PopPile;
   PostFixeA:=PostFixePile;
   PostFixeData.Valeur.TypeDef:=PostFixeA.Valeur.TypeDef;
   PostFixeData.Operateur:=No;
   If(Computed)Then Begin
    Case(PostFixeA.Position)of
     xStack:Begin
      If PostFixeA.VarData.Size=4Then Begin
       If(InstrFormat>=p386)Then Begin
        If(CurrPC.CodePrg^[CurrPC.PrevIP]=$66)and(CurrPC.CodePrg^[CurrPC.PrevIP+1]=$50)Then Begin
         CurrPC.IP:=CurrPC.PrevIP;CurrPC.PrevIP:=$FFFF;
        End
         Else
        PushInstr(#$66#58)
       End
        Else
       PushInstr(#$58#$5A); { POP AX, POP DX }
      End
       Else
      Begin
       If CurrPC.CodePrg^[CurrPC.PrevIP]=$50Then Begin
        CurrPC.IP:=CurrPC.PrevIP;
        CurrPC.PrevIP:=$FFFF;
       End
       Else PushByte($58); { POP AX }
      End;
      PostFixeA.Reg:=0;
      PostFixeA.Position:=xRegister;
     End;
     xVariable:Begin
      Case(PostFixeA.VarData.Size)of
       1:PushInstrOffset(#$A0,PostFixeA.VarData.Ofs); { MOV AL,Variable }
       2:PushInstrOffset(#$A1,PostFixeA.VarData.Ofs); { MOV AX,Variable }
       4:If(InstrFormat>=p386)Then PushInstrOffset(#$66#$A1,PostFixeA.VarData.Ofs) { MOV EAX,Variable }
          Else
         Begin
          PushInstrOffset(#$C4#$06,PostFixeA.VarData.Ofs); { LES AX,Variable }
          PushInstr(#$8C#$C2); { MOV DX,ES }
         End;
       Else Goto Exit;
      End;
      PostFixeA.Reg:=0;PostFixeA.Position:=xRegister;
     End;
    End;
    If PPostFixe2^.OperTitle<>'!'Then Case(PostFixeB.Position)of
     xStack:If(PostFixeA.Position=xNone)Then Begin
      If PostFixeA.VarData.Size=4Then PushInstr(#$58#$5A) { POP AX, POP DX }
                                 Else PushByte($58); { POP AX }
      PostFixeB.Reg:=0;PostFixeB.Position:=xRegister;
     End
      Else
     Begin
      If PostFixeA.VarData.Size=4Then Begin
       PushInstr(#$5B#$59); { POP BX, POP CX }
       PostFixeB.Reg:=3;PostFixeB.Position:=xRegister;
      End
       Else
      Begin
       PushByte($5B); { POP BX }
       PostFixeB.Reg:=3;PostFixeB.Position:=xRegister;
      End;
     End;
     xVariable:If(PostFixeA.Position=xNone)Then Begin
      Case(PostFixeA.VarData.Size)of
       1:PushInstrOffset(#$A0,PostFixeA.VarData.Ofs); { MOV AL,Variable }
       2:PushInstrOffset(#$A1,PostFixeA.VarData.Ofs); { MOV AX,Variable }
       Else Goto Exit;
      End;
      PostFixeB.Reg:=0;PostFixeB.Position:=xRegister;
     End
      Else
     Begin
      Case(PostFixeB.VarData.Size)of
       1:Begin
        PushInstrOffset(#$8A#$26,PostFixeA.VarData.Ofs); { MOV AH,Variable }
        PostFixeB.Reg:=4;PostFixeB.Position:=xRegister;
       End;
       2:Begin
        PushInstrOffset(#$8B#$16,PostFixeA.VarData.Ofs); { MOV DX,Variable }
        PostFixeB.Reg:=2;PostFixeB.Position:=xRegister;
       End;
       Else Goto Exit;
      End;
     End
    End;
   End;
   Case(PPostFixe2^.OperTitle)of
    '*':Case(PostFixeA.Valeur.TypeDef)of
     tByte,tShort,tInt,tWord,tLong:
      PostFixeData.Valeur.X.DataLong:=PostFixeA.Valeur.X.DataLong*PostFixeB.Valeur.X.DataLong;
     Else Goto Exit;
    End;
    '/':PostFixeData.Valeur.X.DataLong:=Trunc(PostFixeA.Valeur.X.DataLong/PostFixeB.Valeur.X.DataLong);
    '\':PostFixeData.Valeur.X.DataLong:=DivLong(PostFixeA.Valeur.X.DataLong,PostFixeB.Valeur.X.DataLong);
    '%':PostFixeData.Valeur.X.DataLong:=PostFixeA.Valeur.X.DataLong mod PostFixeB.Valeur.X.DataLong;
    '+':If Not AsmOper(0)Then Goto Exit;
    '-':If Not AsmOper($28)Then Goto Exit;
    'ï':If Not AsmOper($20)Then Goto Exit;
    'U':If Not AsmOper(8)Then Goto Exit;
    'X':If Not AsmOper($30)Then Goto Exit;
    '®':PostFixeData.Valeur.X.DataLong:=PostFixeA.Valeur.X.DataLong shr PostFixeB.Valeur.X.DataLong;
    '¯':PostFixeData.Valeur.X.DataLong:=PostFixeA.Valeur.X.DataLong shl PostFixeB.Valeur.X.DataLong;
    '!':Case(PostFixeA.Valeur.TypeDef)of
      tShort,tByte:Case(PostFixeA.Position)of
       xRegister:Push2Byte($F6,$D0+PostFixeA.Reg);
       Else PostFixeData.Valeur.X.DataByte:=Not PostFixeA.Valeur.X.DataByte;
      End;
      tInt,tWord:Case(PostFixeA.Position)of
       xRegister:Push2Byte($F7,$D0+PostFixeA.Reg);
       Else PostFixeData.Valeur.X.DataWord:=Not PostFixeA.Valeur.X.DataWord;
      End;
      tLong:Case(PostFixeA.Position)of
       xRegister:If(InstrFormat>=p386)Then Push3Byte($66,$F7,$D0+PostFixeA.Reg)
        Else
       Begin
        Push2Byte($F7,$D0+PostFixeA.Reg);
        Push2Byte($F7,$D2);
       End;
       Else PostFixeData.Valeur.X.DataLong:=Not PostFixeA.Valeur.X.DataLong;
      End;
      tBool:Case(PostFixeA.Position)of
       xRegister:If(PostFixeA.Reg=0)and(InstrFormat>=p286)Then Push2Byte($34,$01)
                 Else Push3Byte($80,$F0+PostFixeA.Reg,$01);
       Else PostFixeData.Valeur.X.DataBool:=Not PostFixeA.Valeur.X.DataBool;
      End;
      Else Goto Exit;
    End;
    Else Goto Exit;
   End;
   If(Computed)and((Ord(PostFixeA.Position)or Ord(PostFixeB.Position))<>Ord(xNone))Then Begin
    PostFixeData.Reg:=0;
    Case(PostFixeData.Valeur.TypeDef)of
     tLong:If(InstrFormat>=p386)Then PushInstr(#$66#$50) { PUSH EAX }
           Else PushInstr(#$52#$50);{ PUSH DX, PUSH AX }
     Else PushByte($50); { PUSH AX }
    End;
    PostFixeData.Position:=xStack;
   End;
   PPostFixe:=ALAdd(Pile,SizeOf(PostFixeRec));
   If(PPostFixe=NIL)Then Goto Exit;
   PPostFixe^:=PostFixeData;
  End
   Else
  Begin
   PPostFixe:=ALAdd(Pile,SizeOf(PostFixeRec));
   If(PPostFixe=NIL)Then Goto Exit;
   PPostFixe^:=PPostFixe2^;
  End;
  ALNext(PostFixe);
 End;
 If Pile.Count=0Then Goto Exit;
 PopPile;
 If(PostFixePile.Operateur)Then Goto Exit;
 If(PostFixePile.Position=xVariable)Then Begin
  Case(PostFixePile.VarData.Size)of
   1:PushInstrOffset(#$A0,PostFixePile.VarData.Ofs); { MOV AL,Variable }
   2:PushInstrOffset(#$A1,PostFixePile.VarData.Ofs); { MOV AX,Variable }
   4:If(InstrFormat>=p386)Then PushInstrOffset(#$66#$A1,PostFixePile.VarData.Ofs) { MOV EAX,Variable }
      Else
     Begin
      PushInstrOffset(#$C4#$06,PostFixePile.VarData.Ofs); { LES AX,Variable }
      PushInstr(#$8C#$C2); { MOV DX,ES }
     End;
   Else Goto Exit;
  End;
  Reg:=0;
 End
  Else
 If(PostFixePile.Position=xStack)Then Begin
  CurrPC.IP:=CurrPC.PrevIP;CurrPC.PrevIP:=$FFFF;Reg:=PostFixePile.Reg;
 End
  Else
 Begin
  Q:=PostFixePile.Valeur;
  Case(Q.TypeDef)of
   tLong:Begin
    If LongRec(Q.X.DataLong).Hi=0Then Begin
     If Q.X.DataLong>32767Then Begin;Q.TypeDef:=tWord;Q.X.DataWord:=Q.X.DataLong;End Else
     If(Q.X.DataLong>=0)and(Q.X.DataLong<=255)Then Begin;Q.TypeDef:=tByte;Q.X.DataByte:=Q.X.DataLong;End Else
     If(Q.X.DataLong>=-128)and(Q.X.DataLong<0)Then Begin;Q.TypeDef:=tShort;Q.X.DataShort:=Q.X.DataLong;End
      Else
     Begin
      Q.TypeDef:=tInt;
      Q.X.DataInt:=Q.X.DataLong;
     End;
    End;
   End;
   tWord:If Hi(Q.X.DataWord)=0Then Q.TypeDef:=tByte;
   tInt:Begin
    If(Q.X.DataInt>=0)and(Q.X.DataInt<=255)Then Begin;Q.TypeDef:=tByte;Q.X.DataByte:=Q.X.DataInt;End Else
    If(Q.X.DataInt>=-128)and(Q.X.DataInt<0)Then Begin;Q.TypeDef:=tShort;Q.X.DataShort:=Q.X.DataInt;End;
   End;
  End;
  Case(Q.TypeDef)of
   tBool,tChar,tShort,tByte:For J:=1to 3do Q.X.DirectByte[J]:=0;
   tInt,tWord:For J:=2to 3do Q.X.DirectByte[J]:=0;
  End;
 End;
Exit:
 ALDone(Pile);
 ALDone(PostFixe);
 XtrkFormule:=Ya;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Fonction XtrkNmAsm                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet d'extraire un nombre ‚crit dans un bloc assembleur
 du source de langage Pascal.
}

Function XtrkNmAsm(Var Nm:AsmNmType):Long;
Var
 S7:String;
 J:Byte;
 Ok:Boolean;
Begin
 Nm:=aError;
 If SkipSpcInLn(CurrPC.I,CurrPC.S)<>0Then Exit;
 S7:='';
 While StrI(CurrPC.I,CurrPC.S)in['0'..'9','A'..'F','a'..'f']do Begin
  IncStr(S7,CurrPC.S[CurrPC.I]);
  Inc(CurrPC.I)
 End;
 If S7=''Then Exit;
 Case(SI)of
  'h':Begin
   Inc(CurrPC.I);
   Ok:=Ya;
   Nm:=aHex;
   XtrkNmAsm:=HexStrToInt(S7)
  End;
  'b':Begin
   Inc(CurrPC.I);
   Ok:=Ya;
   For J:=1to Length(S7)do If Not(S7[J]in['0','1'])Then Ok:=No;
   If(Ok)Then Begin;Nm:=aBin;XtrkNmAsm:=BinStr2Nm(S7)End Else Nm:=aError;
  End;
  Else Begin
   Ok:=Ya;
   For J:=1to Length(S7)do If Not(S7[J]in['0'..'9'])Then Ok:=No;
   If(Ok)Then Begin
    XtrkNmAsm:=StrToInt(S7);
    Nm:=aDec;
   End
    Else
   Nm:=aError;
  End;
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Fonction XtrkPasStr                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet d'extraire une chaŒne de caractŠres de format
 Pascal … partir d'un point particulier dans une chaŒne de caractŠres
 de format ‚galement Pascal.
}

Function XtrkPasStr(Var I:Byte;Const L:String;Var EM:Bool):String;Var S:String;Begin
 EM:=Ya;Inc(I);S:='';
 While(L[I]<>'''')or((L[I]='''')and(StrI(I+1,L)=''''))do Begin
  If I>Length(L)Then Exit;
  IncStr(S,L[I]);
  If((L[I]='''')and(StrI(I+1,L)=''''))Then Inc(I);
  Inc(I);
 End;
 EM:=No;XtrkPasStr:=S;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Fonction XtrkString                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet d'extraire une chaŒne de caractŠres de format de
 langage Pascal classique.
}

Function XtrkString;
Var
 EM:Boolean;
Begin
 SkipSpcInLn(CurrPC.I,CurrPC.S);
 XtrkString:=No;
 While CurrPC.I>Length(CurrPC.S)do Begin
  If(EOF)Then Exit;
  CurrPC.S:=ReadLn;
  If SkipSpcInLn(CurrPC.I,CurrPC.S)<>0Then Exit;
 End;
 Out:=XtrkPasStr(CurrPC.I,CurrPC.S,EM);
 XtrkString:=Not EM;
 If Not(EM)Then Inc(CurrPC.I);
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
END.