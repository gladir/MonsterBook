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

Function  EOF:Bool;
Function  OpenInclusion(NewFile:String):Int;
Function  ReadLn:String;
Procedure RestoreAddr;
Procedure SaveAddr;
Function  SI:Char;
Function  SkipSpcInLn(Var I:Byte;Var S:String):Int;
Function  XtrkData(Var Q:Variant):Bool;
Function  XtrkFormule(Var Q:Variant;Computed:Bool;Var Reg:Byte):Bool;
Function  XtrkInteger(Var Ok:Bool):Long;
Function  XtrkLabelAsm:String;
Function  XtrkNmAsm(Var Nm:AsmNmType):Long;
Function  XtrkString(Var Out:String):Bool;
Function  XtrkWd:String;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                IMPLEMENTATION
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses Systems,PCData,PCBase,PCCompile,Math
     {$IFDEF IDE}
      ,Dials,OVIde
     {$ENDIF};

Var LastFP,ONL:Long;LastI,OldCurrCond:Byte;LastS:String;

{ Cette proc‚dure permet de restituer l'ancien position courante dans
 le fichier en traŒn d'ˆtre compil‚e.
}

Procedure RestoreAddr;Begin
 If Handle>=50Then Begin
  While(NL<>ONL)do Begin
   RBPrevious(XEdt^.List);
   Dec(NL);
  End;
 End;
 FP:=LastFP;I:=LastI;S:=LastS;NL:=ONL;CurrCond:=OldCurrCond;
End;

{ Cette proc‚dure permet de sauvegarder la position courante dans le
 fichier en traŒn d'ˆtre compil‚e.
}

Procedure SaveAddr;Begin
 LastFP:=FP;LastI:=I;LastS:=S;ONL:=NL;OldCurrCond:=CurrCond;
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
  If Handle>=50Then EOF:=NL>=XEdt^.List.NB
   Else
 {$ENDIF}
 If RBIsEmpty(Include)Then EOF:=Not(FS>=FP)Else EOF:=No
End;

Var OldTime:Byte;

Function ReadLn:String;Var S:String;XT:Byte;PC:PChr;Begin
 XT:=GetRawTimerB and$F8;
 If(XT<>OldTime)Then Begin
  {$IFDEF IDE}
   WEPutTxtXY(WC,33,4,StrUSpc(CStr(NL),12));
   WEPutTxtXY(WC,33,5,CStr(Macro.NB));
   WEPutTxtXY(WC,33,6,CStr(ReDef.NB+GhostConst));
   WEPutTxtXY(WC,33,7,CStr(VarBk.NB));
   WEPutTxtXY(WC,33,8,CStr(TypeDef.NB));
   WEPutTxtXY(WC,33,9,CStr(ProcBk.NB));
   WEPutTxtXY(WC,33,10,CStr(GhostCode+IP-Org));
   WEPutTxtXY(WC,33,11,StrUSpc(CStr(MemAvail),12));
   WEPutTxtXY(WC,33,12,GetStrTimeInPrg);
  {$ELSE}
   S:='('+Str(NL)+')';
   Write(S+MultChr(#8,Length(S)));
  {$ENDIF}
  OldTime:=XT;
 End;
 {$IFDEF IDE}
  If Handle>=50Then Begin
   PC:=_RBGetCurrBuf(XEdt^.List);S:=StrPas(PC);
   RBNext(XEdt^.List);
  End
   Else
 {$ENDIF}
 __GetAbsFileTxtLn(Handle,FP,S);
 I:=1;Inc(NL);
 While S=''do Begin
  {$IFDEF IDE}
   If Handle>=50Then Begin
    PC:=_RBGetCurrBuf(XEdt^.List);S:=StrPas(PC);
    RBNext(XEdt^.List);
   End
    Else
  {$ENDIF}
  __GetAbsFileTxtLn(Handle,FP,S);Inc(NL);
  If(FP>=FS)Then Begin
   If RBIsEmpty(Include)Then Break
    Else
   Begin
     { Fermer le fichier ‚tant actuellemenent utilis‚ (puisque de }
     { toute fa‡on il vient d'ˆtre complŠtement lus...).}
    FileClose(Handle);
     { Restauration des donn‚es }
    PInclude:=_RBGetBuf(Include,Include.NB-1);
    If(PInclude=NIL)Then Break;
    MainFile:=PInclude^.Path;
    FP:=PInclude^.FP;FS:=PInclude^.FS;
    I:=PInclude^.I;S:=PInclude^.Line;
     { liminer les donn‚es venant d'ˆtre extraŒte... }
    If Not RBDelBuf(Include,Include.NB-1)Then Break;
     { Ouvre le fichier avec les donn‚es venant d'ˆtre restaurer }
    Handle:=FileOpen(MainFile,fmRead);
    If(Handle=errHdl)Then Break;
   End;
  End;
 End;
 If(EOF)Then GetSysErr:=errEOF;
 ReadLn:=S;
End;

Function OpenInclusion;Begin
 PInclude:=RBAdd(Include,SizeOf(IncludeRec));
 If(PInclude=NIL)Then OpenInclusion:=OutOfMemory
  Else
 Begin
  PInclude^.Path:=MainFile;
  PInclude^.FP:=FP;PInclude^.FS:=FS;
  PInclude^.I:=I;PInclude^.Line:=S;
  FileClose(Handle);
  Handle:=FileOpen(NewFile,fmRead);
  If(Handle=errHdl)Then OpenInclusion:=FileNotFound
   Else
  Begin
   FP:=0;FS:=FileSize(Handle);I:=1;CurrFile:=NewFile;
   __GetAbsFileTxtLn(Handle,FP,S);
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
Label Restart,SInclude,Param,FinishBigRem;Var S2:String;BigRem,Ok:Bool;l:Long;Begin
 SkipSpcInLn:=0;
Restart:
 Systems.SkipSpcInLn(I,S);
 If Not(InRem)Then Case StrI(I,S)of
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
   W:=I;Inc(I);
   If(I>=Length(S))and(Not IsRomanLetter(StrI(I,S)))Then I:=W
    Else
   Begin
    S2:=XtrkWd;
    If S2='INCLUDE'Then Begin
     Systems.SkipSpcInLn(I,S);
     S3:=Copy(S,I,255);
     If S3=''Then Begin;SkipSpcInLn:=IdentifierExpected;Exit;End;
     OpenInclusion(S3);
     Goto Restart;
    End
     Else
    I:=W;
   End;
  End;
  '(':If StrI(I+1,S)='*'Then Begin
   InRem:=Ya;Inc(I,2);BigRem:=Ya;
   If StrI(I,S)='$'Then Goto Param;
FinishBigRem:
   Repeat
    Inc(I);
    If StrI(I,S)=#0Then Begin
     S:=ReadLn;I:=1;
     If(GetSysErr=errEOF)Then Exit;
    End;
   Until(StrI(I,S)='*')and(StrI(I+1,S)=')');
   Inc(I,2);InRem:=No;
   Goto Restart;
  End;
  '{':Begin
   InRem:=Ya;Inc(I);BigRem:=No;
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
         W:=OpenInclusion(S2);
         If W<>0Then Begin;SkipSpcInLn:=W;Exit;End Else Goto Restart;
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
          Else Begin;SkipSpcInLn:=SyntaxError;Exit;End;
         End;
         If(Ok)Then Begin;ArrayCond[CurrCond]:=cEndIf;Inc(CurrCond);End
          Else
         Begin
          Inc(I);ArrayCond[CurrCond]:=cElse;
          If SI<>'}'Then Begin;SkipSpcInLn:=CloseParExpected;Exit;End;
          Inc(I);l:=0;
          If(ArrayCond[CurrCond]=cEndIf)Then Begin
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
          If l=0Then Inc(CurrCond);
         End;
        End;
       End;
      End
       Else
      If S2='ELSE'Then Begin
       If(CurrCond>0)and(ArrayCond[CurrCond-1]=cEndIf)Then Begin
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
        Dec(CurrCond);
       End
        Else
       Begin;SkipSpcInLn:=SyntaxError;Exit;End;
       Dec(I);
      End
       Else
      If S2='ENDIF'Then Begin
       If CurrCond>0Then Dec(CurrCond)Else Begin;SkipSpcInLn:=SyntaxError;Exit;End;
       Dec(I);
      End
       Else
      If S2='ORIGINE'Then Begin
       l:=XtrkInteger(Ok);
       If Not(Ok)Then Begin;SkipSpcInLn:=SyntaxNumber;Exit;End;
       If l>65520Then Begin;SkipSpcInLn:=TooBigNumber;Exit;End;
       Org:=l;IP:=Org+3;
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
   Inc(I);InRem:=No;
   Goto Restart;
  End;
 End;
End;

Function SearchMacro(Const Name:String):MacroPtr;Var PMac:MacroPtr;Begin
 If Macro.NB>0Then Begin
  RBSetPtr(Macro,0);
  Repeat
   PMac:=_RBGetCurrBuf(Macro);
   If(PMac^.Name=Name)Then Begin;SearchMacro:=PMac;Exit;End;
   RBNext(Macro);
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
 SkipSpcInLn(I,S);XtrkWd:='';
 While(I>Length(S))or((FP>=FS)and(Include.NB>0))do Begin
  If(EOF)Then Exit;
  S:=ReadLn;
  If SkipSpcInLn(I,S)<>0Then Exit;
 End;
 W:=XtrkWord(I,S);
 PMac:=SearchMacro(W);
 If(PMac<>NIL)Then Begin
  If SI<>';'Then Exit;
  Inc(I);
  PInclude:=RBAdd(Include,SizeOf(IncludeRec));
  If(PInclude=NIL)Then Exit
   Else
  Begin
   PInclude^.Path:=CurrFile;
   PInclude^.FP:=FP;PInclude^.FS:=FS;
   PInclude^.I:=I;PInclude^.Line:=S;
   FileClose(Handle);
   Handle:=FileOpen(PMac^.Path,fmRead);
   If(Handle=errHdl)Then Exit
    Else
   Begin
    FP:=PMac^.FB;FS:=PMac^.FE;I:=1;CurrFile:=PMac^.Path;
    __GetAbsFileTxtLn(Handle,FP,S);
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

Function XtrkAsm(Var I:Byte;Const L:String):String;Var LL:Byte Absolute L;S:String;Begin
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

Function XtrkLabelAsm:String;Label Home;Var W:String;PMac:MacroPtr;Begin
Home:
 SkipSpcInLn(I,S); XtrkLabelAsm:='';
 While(I>Length(S))or((FP>=FS)and(Include.NB>0))do Begin
  If(EOF)Then Exit;
  S:=ReadLn;
  If SkipSpcInLn(I,S)<>0Then Exit;
 End;
 W:=XtrkAsm(I,S);{W:=XtrkWord(I,S);}PMac:=SearchMacro(W);
 If(PMac<>NIL)Then Begin
  PInclude:=RBAdd(Include,SizeOf(IncludeRec));
  If(PInclude=NIL)Then Exit
   Else
  Begin
   PInclude^.Path:=CurrFile;
   PInclude^.FP:=FP;PInclude^.FS:=FS;
   PInclude^.I:=I;PInclude^.Line:=S;
   FileClose(Handle);
   Handle:=FileOpen(PMac^.Path,fmRead);
   If(Handle=errHdl)Then Exit
    Else
   Begin
    FP:=PMac^.FB;FS:=PMac^.FE;I:=1;CurrFile:=PMac^.Path;
    __GetAbsFileTxtLn(Handle,FP,S);
    Goto Home;
   End;
  End;
 End
  Else
 XtrkLabelAsm:=W
End;

Function SI:Char;Begin
 SkipSpcInLn(I,S); SI:=#0;
 While I>Length(S)do Begin
  If(EOF)Then Exit;
  S:=ReadLn;
  If SkipSpcInLn(I,S)<>0Then Exit;
 End;
 SI:=StrI(I,S);
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
 XtrkData:=No;OldI:=I;
 FillClr(Q,SizeOf(Q));
 If SkipSpcInLn(I,S)<>0Then Exit;
 Q.TypeDef:=tLong;
 Case(SI)of
  '$':Begin
   Inc(I);T:=XtrkHexNm(I,S);
   If T=''Then Exit;
   Q.X.DataLong:=HexStrToInt(T);
  End;
  '-':Begin
   Inc(I);
   T:='-'+XtrkDecNm(I,S);
   Q.X.DataLong:=StrToInt(T)
  End;
  Else Begin
   T:='';
   If StrI(I,S)in['0'..'9']Then T:=XtrkHexNm(I,S);
   If T=''Then Begin
    T:=XtrkWd;
    If Not RBIsEmpty(ReDef)Then Begin
     RBSetPtr(ReDef,0);
     For J:=0to ReDef.NB-1do Begin
      PCst:=_RBGetCurrBuf(ReDef);
      If(PCst^.Name=T)Then Begin
       Q:=PCst^.Q;XtrkData:=Ya;Exit;
      End;
      RBNext(ReDef);
     End;
    End;
    If SearchConstList(T,Format)Then Begin
     Q:=Format.Q;XtrkData:=Ya;
     Exit;
    End;
    I:=OldI;
    Exit;
   End;
   Case StrI(I,S)of
    'o','O':Begin
     Inc(I);
     For J:=1to Length(T)do If Not(T[J]in['0'..'7'])Then Exit;
     Q.X.DataLong:=OctStr2Nm(T)
    End;
    'b','B':Begin
     Inc(I);
     For J:=1to Length(T)do If Not(T[J]in['0','1'])Then Exit;
     Q.X.DataLong:=BinStr2Nm(T)
    End;
    'h','H':Begin
     Inc(I);
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

Function XtrkInteger;Var Q:Variant;Begin
 Ok:=XtrkData(Q);XtrkInteger:=Q.X.DataLong;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Fonction XtrkFormule                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet d'extraire une formule math‚matiques ‚crite en
 langage Pascal et de la transformer en code machine.
}

Function XtrkFormule;Label 1,2,Exit;
Type PostFixeRec=Record
 Operateur:Boolean; { Op‚rateur sinon nombre...}
 Position:(xNone,xVariable,xRegister,xStack);
 Reg:Byte;          { Num‚ro de registre si dans registre }
 OperTitle:Char;    { Titre de l'op‚rateur }
 Valeur:Variant;    { Valeur contenu dans l'expression }
 VarData:VarRec;    { Donner sur la variable }
 Priorite:Integer;  { Niveau de priorit‚ }
End;
PostFixePtr=^PostFixeRec;
Var Pile,PostFixe:RBuf;PPostFixe,PPostFixe2:PostFixePtr;Ok:Boolean;PVar:^VarRec;
J,Paren:Int;PostFixeA,PostFixeB,PostFixePile,PostFixeData:PostFixeRec;T,SOper:String;

 Procedure PopPile;Begin
  PPostFixe:=_RBGetBuf(Pile,Pile.NB-1);PostFixePile:=PPostFixe^;
  RBDelBuf(Pile,Pile.NB-1);
 End;

 Function AsmOper(Code:Byte):Bool;Begin
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
 RBInit(PostFixe);RBInit(Pile);
  { D‚composition de la formule }
 PostFixeData.Operateur:=Ya;
 PostFixeData.Priorite:=-1;
 PostFixeData.Reg:=0;
 PPostFixe:=RBAdd(Pile,SizeOf(PostFixeRec));
 If(PPostFixe=NIL)Then Goto Exit;
 PPostFixe^:=PostFixeData;
 Repeat
  PostFixeData.Operateur:=Ya;
  Case(SI)of
   '(':Begin
    PostFixeData.OperTitle:=SI;Inc(I);PostFixeData.Priorite:=0;
    PPostFixe:=RBAdd(Pile,SizeOf(PostFixeRec));
    If(PPostFixe=NIL)Then Goto Exit;
    PPostFixe^:=PostFixeData;
    Inc(Paren);
   End;
   ')':If Paren=0Then Break
    Else
   Begin
    Inc(I);Dec(Paren);
    Repeat
     PopPile;
     If PostFixePile.OperTitle='('Then Break;
     PPostFixe:=RBAdd(PostFixe,SizeOf(PostFixeRec));
     If(PPostFixe=NIL)Then Goto Exit;
     PPostFixe^:=PostFixePile;
    Until Pile.NB=0;
   End;
   '+','-':Begin
    If(PostFixe.NB=0)and(SI='-')Then Goto 2;
    PostFixeData.OperTitle:=SI;
    Inc(I);PostFixeData.Priorite:=1;
   End;
   '*','/':Begin
    PostFixeData.OperTitle:=SI;
    Inc(I);PostFixeData.Priorite:=2;
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
  2:PostFixeData.Operateur:=No;PostFixeData.Priorite:=0;
    PostFixeData.Position:=xNone;
    If Not XtrkData(PostFixeData.Valeur)Then Begin
     If Not(Computed)Then Goto Exit;
     Ok:=No;T:=XtrkWd;
     If Not RBIsEmpty(VarBk)Then Begin
      RBSetPtr(VarBk,0);
      For J:=0to VarBk.NB-1do Begin
       PVar:=_RBGetCurrBuf(VarBk);
       If(PVar^.Name=T)Then Begin
        PostFixeData.Position:=xVariable;
        PostFixeData.VarData:=PVar^;
        PostFixeData.Valeur.TypeDef:=PostFixeData.VarData.TypeDef;
        Ok:=Ya;Break;
       End;
       RBNext(VarBk);
      End;
     End;
     If Not(Ok)Then Goto Exit;
    End;
    PPostFixe:=RBAdd(PostFixe,SizeOf(PostFixeRec));
    If(PPostFixe=NIL)Then Goto Exit;
    PPostFixe^:=PostFixeData;
   End;
  End;
  If PostFixeData.Priorite>0Then Begin
 1:PopPile;
   If(PostFixePile.Priorite<PostFixeData.Priorite)Then Begin
    PPostFixe:=RBAdd(Pile,SizeOf(PostFixeRec));
    If(PPostFixe=NIL)Then Goto Exit;
    PPostFixe^:=PostFixePile;
    PPostFixe:=RBAdd(Pile,SizeOf(PostFixeRec));
    If(PPostFixe=NIL)Then Goto Exit;
    PPostFixe^:=PostFixeData;
   End
    Else
   Begin
    PPostFixe:=RBAdd(PostFixe,SizeOf(PostFixeRec));
    If(PPostFixe=NIL)Then Goto Exit;
    PPostFixe^:=PostFixePile;
    Goto 1;
   End;
  End;
 Until No;
 While Pile.NB>1do Begin
  PopPile;
  PPostFixe:=RBAdd(PostFixe,SizeOf(PostFixeRec));
  If(PPostFixe=NIL)Then Goto Exit;
  PPostFixe^:=PostFixePile;
 End;
 PopPile;
  { valuation du PostFixe }
 RBSetPtr(PostFixe,0);
 For J:=0to PostFixe.NB-1do Begin
  PPostFixe2:=_RBGetCurrBuf(PostFixe);
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
        If(CodePrg^[PrevIP]=$66)and(CodePrg^[PrevIP+1]=$50)Then Begin
         IP:=PrevIP;PrevIP:=$FFFF;
        End
         Else
        PushInstr(#$66#58)
       End
        Else
       PushInstr(#$58#$5A); { POP AX, POP DX }
      End
       Else
      Begin
       If CodePrg^[PrevIP]=$50Then Begin;IP:=PrevIP;PrevIP:=$FFFF;End
       Else PushByte($58); { POP AX }
      End;
      PostFixeA.Reg:=0;PostFixeA.Position:=xRegister;
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
   PPostFixe:=RBAdd(Pile,SizeOf(PostFixeRec));
   If(PPostFixe=NIL)Then Goto Exit;
   PPostFixe^:=PostFixeData;
  End
   Else
  Begin
   PPostFixe:=RBAdd(Pile,SizeOf(PostFixeRec));
   If(PPostFixe=NIL)Then Goto Exit;
   PPostFixe^:=PPostFixe2^;
  End;
  RBNext(PostFixe);
 End;
 If Pile.NB=0Then Goto Exit;
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
  IP:=PrevIP;PrevIP:=$FFFF;Reg:=PostFixePile.Reg;
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
 RBDone(Pile);
 RBDone(PostFixe);
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

Function XtrkNmAsm(Var Nm:AsmNmType):Long;Var S7:String;J:Byte;Ok:Bool;Begin
 Nm:=aError;
 If SkipSpcInLn(I,S)<>0Then Exit;
 S7:='';
 While StrI(I,S)in['0'..'9','A'..'F','a'..'f']do Begin
  IncStr(S7,S[I]);
  Inc(I)
 End;
 If S7=''Then Exit;
 Case(SI)of
  'h':Begin
   Inc(I);
   Ok:=Ya;
   Nm:=aHex;
   XtrkNmAsm:=HexStrToInt(S7)
  End;
  'b':Begin
   Inc(I);Ok:=Ya;
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

Function XtrkString;Var EM:Bool;Begin
 SkipSpcInLn(I,S);
 XtrkString:=No;
 While I>Length(S)do Begin
  If(EOF)Then Exit;
  S:=ReadLn;
  If SkipSpcInLn(I,S)<>0Then Exit;
 End;
 Out:=XtrkPasStr(I,S,EM);
 XtrkString:=Not EM;
 If Not(EM)Then Inc(I);
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
END.