{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                                                                       Û
 ³                     Malte Genesis/Editeur-Macro                       Û
 ³                                                                       Û
 ³            dition Chantal pour Mode R‚el/IV - Version 1.1            Û
 ³                              1995/11/30                               Û
 ³                                                                       Û
 ³          Tous droits r‚serv‚s par les Chevaliers de Malte (C)         Û
 ³                                                                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Nom du programmeur
 ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

  Sylvain Maltais


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette unit‚ s'occupe de g‚rer les macros devant s'ex‚cuter sous le
 traŒtement de texte.
}

Unit EdtMacro;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                 INTERFACE
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

{$I DEF.INC}

Uses Systex,Isatex;

Function TEExecMacro(Var Q:EditorApp;Const Path:String):Word;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                               IMPLEMENTATION
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses
 Adele,Memories,Systems,Video,Dialex,Dials,DialPlus,Numerix,Editor,
 Math,Restex,ResServD;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure TEExecMacro                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure ex‚cute un macro contenue dans un fichier et l'applique
 sur le texte en cours d'‚dition.
}

Function TEExecMacro(Var Q:EditorApp;Const Path:String):Word;
Label
 Break,Break2,Xit,InvalidParam;
Var
 L:ArrayList;
 Handle:Hdl;
 J,a,b,c:Word;
 I,xJ:Byte;
 FP,MS:LongInt;
 Variable:ArrayList;
 Instr:DataSetInMemory;
 Param:^String;           { ParamŠtres }
 SP:Byte;                 { Position de chaŒne de caractŠres }
 JP:Integer;              { Compteur de paramŠtres }
 IP:Word;                 { Position de variable }
 LenParam:Byte;
 Vr:Array[0..7]of Variant;
 V,S,E,SU,S2:String;

 Function StrIInc(Chr:Char):Boolean;Begin
  If Chr=StrI(I,S)Then Begin
   Inc(I);
   StrIInc:=Ya;
  End
   Else
  StrIInc:=No;
 End;

 Procedure PageNm;Begin
  SkipSpcInLn(I,S);
  Q.PageNumStart:=StrToInt(XtrkDecNm(I,S))
 End;

 Function ReadNm:Wd;Begin
  Inc(I);
  SkipSpcInLn(I,S);
  ReadNm:=StrToWord(XtrkDecNm(I,S));
  SkipSpcInLn(I,S)
 End;

 Procedure PageFormat;Begin
  SkipSpcInLn(I,S);
  Q.SheetFormat.X1:=StrToWord(XtrkDecNm(I,S));
  SkipSpcInLn(I,S);
  If S[I]=','Then Begin
   Q.SheetFormat.Y1:=ReadNm;
   If S[I]=','Then Begin
    Q.SheetFormat.X2:=ReadNm;
    If S[I]=','Then Q.SheetFormat.Y2:=ReadNm;
   End;
  End;
 End;

 Procedure cPut;
 Label Break,Break2;
 Var
  k,J,x3,x4:Wd;
  E,E2:String;
 Begin
  Repeat
   SkipSpcInLn(I,S);
   Case StrI(I,S)of
    '#':Begin
     Inc(I);
     If StrIInc('B')Then Begin
      If StrIInc('(')Then Begin
       E2:=XtrkDecNm(I,S);
       If StrIInc(':')Then Begin
        J:=I;
	While S[J]<>')'do Begin
	 If J>Length(S)Then Exit;
	 Inc(J);
	End;
	TEPushStr(Q,BinByte2Str(StrToWord(ValExt(I,Left(S,J),Variable))));
	StrIInc(')');
	TEkRight(Q);
       End;
      End;
     End
      Else
     If StrIInc('H')Then Begin
      If StrIInc('(')Then Begin
       E2:=XtrkDecNm(I,S);
       If StrIInc(':')Then Begin
        TEPushStr(Q,HexByte2Str(StrToWord(ValExt(I,S,Variable))));
	StrIInc(')');
	TEkRight(Q);
       End;
      End;
     End
      Else
     If StrIInc('(')Then Begin
      TESetThisChr(Q,Char(StrToWord(ValExt(I,S,Variable))));
      StrIInc(')');
      TEkRight(Q);
     End;
    End;
    '>':If StrI(I+1,S)='>'Then Begin
     Inc(I,Length('>>'));
     TEPushStr(Q,Spc(StrToWord(XtrkDecNm(I,S))));
    End;
    '(':Begin
     E:='';Inc(I);
     If StrI(I,S)='"'Then Begin
      Inc(I);
      While StrI(I,S)<>#0do Begin
       If StrIInc('"')Then Goto Break;
       IncStr(E,S[I]);Inc(I);
      End;
      Break:
      SkipSpcInLn(I,S);
      If StrIInc('*')Then Begin
       SkipSpcInLn(I,S);
       k:=StrToWord(ValExt(I,SU,Variable));
       E2:='';
       For J:=1to(k)div Length(E)do AddStr(E2,E);
       TEPushStr(Q,E2);
      End;
      StrIInc(')');
     End;
    End;
    '"':Begin
     Inc(I);E:='';
     While StrI(I,S)<>#0do Begin
      If StrIInc('"')Then Goto Break2;
      IncStr(E,S[I]);Inc(I)
     End;
Break2:If StrIInc('*')Then Begin
      SkipSpcInLn(I,S);
      k:=StrToWord(ValExt(I,SU,Variable));E2:='';
      For J:=1to(k)div Length(E)do AddStr(E2,E);
      TEPushStr(Q,E2);
     End
      Else
     TEPushStr(Q,E);
    End;
    'A'..'Z','a'..'z','_':Begin
     x3:=StrToWord(ValExt(I,S,Variable));
     StrIInc(':');
     TEPushStr(Q,Str2(x3,StrToInt(ValExt(I,S,Variable))));
    End;
   End;
   SkipSpcInLn(I,S);
  Until Not StrIInc(',');
 End;

 Procedure cPutLn;Begin
  cPut;
  TEkEnterIns(Q)
 End;

 Function XtrkNumber(Var N:Variant):Boolean;
 Var
  F:FormulaObject;
 Begin
  SkipSpcInLn(I,S);
  FOInit(F);
  F.Option:=[foNumberBasic,foExpBasic];
  F.StopChar:=[',',':',';','''','<','=','>'];
 { F.OnWord:=LogoFormuleOnWord;
  F.Context:=@Q;}
  F.I:=I;
  If FOCompute(F,S)Then Begin
   N:=F.Result;
   I:=F.I;
   XtrkNumber:=True;
  End
   Else
  XtrkNumber:=False;
 End;

 Function _Str2S(Var S:String):Boolean;
 Label 0;
 Var
  ST:String;
 Begin
  _Str2S:=False;ST:='';
0:SkipSpcInLn(I,S);
  If StrI(I,S)='"'Then Begin
   Inc(I);
   While Not(StrI(I,S)in[#0,'"'])do Begin
    IncStr(ST,S[I]);
    Inc(I)
   End;
   Inc(I)
  End
   Else
  Begin
   XtrkNumber(Vr[0]);
   Str(VariantToReal(Vr[0]):0:0,ST);
  End;
  SkipSpcInLn(I,S);
  If S[I]in['&','+']Then Begin
   Inc(I);
   Goto 0;
  End;
  S:=ST;
  _Str2S:=True;
 End;

Begin
 TEExecMacro:=0;
 DBOpenServerName(ChantalServer,'CHANTAL:/Compilateur/Basic/Instruction.Dat');
 If DBCopyToMemory(ChantalServer,Instr)Then Begin
  ALInit(Variable);
  a:=Q.SheetFormat.X2-Q.SheetFormat.X1;
  If a>65500Then a:=NmXTxts;
  ALAddStr(Variable,'NMXTXTS='+WordToStr(a));
  Handle:=FileOpen(Path,fmRead);V:='';
  If(Handle<>errHdl)Then Begin
   MS:=FileSize(Handle); FP:=0;
   ALInit(L);
   Repeat
    __GetAbsFileTxtLn(Handle,FP,S);
    If GetSysErr<>0Then Begin
     ErrMsgOk('Erreur de lecture du scripte');
     Goto Break;
    End;
    ALAddStr(L,S);
   Until FP>=MS;
 Break:
   FileClose(Handle);
   For J:=0to L.Count-1do Begin
    S:=_ALGetStr(L,J);
    SU:=StrUp(S);
    For I:=1to Length(S)do Begin
     If IsRomanLetter(S[I])Then Begin
      E:=XtrkWord(I,SU);
      If DBLocateAbsIM(Instr,2,E,[])Then Begin
       Param:=Pointer(Instr.CurrRec);
       _DBGotoColumnAbs(Instr.FieldRec,3,Pointer(Param));
       IP:=0;SP:=0;LenParam:=Length(Param^);
       If(Instr.CurrRec.Byte^<>$42{Put})Then For JP:=1to(LenParam)do Begin
        ASM
         INC Word Ptr Param
        END;
        Case Param^[0]of
         #0:System.Break;
         'I':Begin
          If Not XtrkNumber(Vr[IP])Then Goto Xit;
          Inc(IP);
          If IP>7Then System.Break;
         End;
         'S':Begin
          Case(SP)of
           1:If Not _Str2S(S2)Then Goto Xit;
           Else If Not _Str2S(S)Then Goto Xit;
          End;
          Inc(SP);
         End;
         Else Begin
          SkipSpcInLn(I,S);
          If StrI(I,S)<>Param^[0]Then Begin
           Case Param^[0]of
            '(':TEExecMacro:=OpenParExpected;
            ',':TEExecMacro:=VirguleExpected;
            ')':TEExecMacro:=CloseParExpected;
            '-':TEExecMacro:=MinusExpected;
            Else TEExecMacro:=SyntaxError;
           End;
InvalidParam:
           ErrMsgOk('ParamŠtre invalide … la ligne '+WordToStr(I+1));
           Goto Xit;
          End;
          Inc(J);
         End;
        End;
       End;
       Case(Instr.CurrRec.Byte^)of
        $1B:Begin{FOR}
         SkipSpcInLn(I,S);
         StrIInc('(');
         V:=XtrkWord(I,S);
         StrIInc('=');
         a:=StrToWord(XtrkDecNm(I,S));
         StrIInc(';');
         b:=StrToWord(XtrkDecNm(I,S));
         StrIInc(')');
         SkipSpcInLn(I,S);
         c:=a; xJ:=I;
         For a:=c to(b)do Begin
          ALAddStr(Variable,V+'='+IntToStr(a));
          I:=xJ; E:=XtrkWord(I,SU);
          If(E='PUTLN')or(E='ECRITLIGNE')Then cPutLn;
          If(E='PUT')or(E='ECRIT')Then cPut;
          ALDelBuf(Variable,Variable.Count-1);
         End;
        End;
        $40:Begin{PRINT}
         If Not _Str2S(S)Then Goto InvalidParam;
         TEPushStr(Q,S);
        End;
        $42:Begin{PUT}
         cPut;
        End;
        $66:Begin{DEL, DELETE}
         TEkDel(Q);
        End;
        Else Begin
         ErrMsgOk('Erreur … la ligne '+WordToStr(I+1));
         Goto Xit;
        End;
       End;
      End
       Else
      If(E='SETBOLDCHAR')or
        (E='SETBOLDCHR')THen TESetChrType(Q,cgBold)Else
      If E='SETNORCHR'Then TESetChrType(Q,cgNormal)Else
      If E='SETNORMALCHAR'Then TESetChrType(Q,cgNormal)Else
      If E='SETNORMALCHR'Then TESetChrType(Q,cgNormal)Else
      If E='SETDBLCHR'Then TESetChrType(Q,cgDouble)Else
      If E='SETEXPCHR'Then TESetChrType(Q,cgExposant)Else
      If E='WORDEXPCHR'Then TEExposantWord(Q)Else
      If E='WORDDBLCHR'Then TEBoldWord(Q)Else
      If E='RIGHT'Then TEkRight(Q)Else
      If E='PAGEFORMAT'Then PageFormat Else
      If E='PAGENM'Then PageNm Else
      If E='LN'Then TEkEnterIns(Q)Else
      If E='LEFT'Then TEkLeft(Q)Else
      If(E='PUTLN')or(E='ECRITLIGNE')Then cPutLn Else
      If E='ECRIT'Then cPut Else
      Goto Break2;
     End
      Else
     Begin
      ErrMsgOk('Erreur de syntaxe dans le macro!');
      Goto Break2;
     End;
     If I>Length(S)Then System.Break;
    End;
   End;
 Break2:
   ALDone(L);
   TERefresh(Q);
  End
   Else
  __FileNotFound(Path);
Xit:
  ALDone(Variable);
  DBDispose(Instr);
 End;
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
END.