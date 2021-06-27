{ Cette unit� est destin� a effectu� l'ex�cution de diff�rentes Macro du
 programme de gestionnaire de fichiers.
}

Unit FMMacro;

{$I DEF.INC}

INTERFACE

Uses Systex,Isatex;

Function FMChoiceMacro(Var Q:FileManagerApp):SmallInt;
Function FMRunMacro(Var Q:FileManagerApp;Const FileName:String):SmallInt;
Function FMExecMacro(Var Q:FileManagerApp;Var List:ArrayList):SmallInt;

IMPLEMENTATION

Uses
 Memories,Math,Systems,SysPlus,DialPlus,ResTex,ResServD,Dials,Dialex,
 FileMana;

Procedure SkipSpc(Var I:Word;PC:PChr);Near;
{$IFNDEF Real}
 Begin
  While PC^[I]in[#9,' ']do Inc(I);
 End;
{$ELSE}
 Assembler;ASM
  LES DI,I
  MOV BX,ES:[DI]
  LES DI,PC
  DEC BX
 @1:
  INC BX
  CMP Byte Ptr ES:[DI+BX],9
  JE  @1
  CMP Byte Ptr ES:[DI+BX],' '
  JE  @1
  LES DI,I
  MOV ES:[DI],BX
 END;
{$ENDIF}

Function FMExecMacro(Var Q:FileManagerApp;Var List:ArrayList):SmallInt;
Label
 InvalidParam,Xit;
Var
 LenParam:Byte;
 I:SmallInt;
 J:Word;
 Len:Word;
 SP:Byte;                 { Position de cha�ne de caract�res }
 JP:Integer;              { Compteur de param�tres }
 IP:Word;                 { Position de variable }
 PC:PChr;
 V:Array[0..7]of Variant;
 Instr:DataSetInMemory;
 S,S2:String;
 Param:^String;           { Param�tres }

 Procedure SkipSpcInLine;Begin
  While PC^[J]=' 'do Inc(J);
 End;

 Function XtrkWord:String;Begin
  SkipSpcInLine;
  XtrkWord:=StrUp(PXtrkWord(J,PC));
 End;

 Function XtrkNumber(Var N:Variant):Boolean;
 Var
  F:FormulaObject;
 Begin
  SkipSpcInLine;
  FOInit(F);
  F.Option:=[foNumberBasic,foExpBasic];
  F.StopChar:=[',',':',';','''','<','=','>'];
 { F.OnWord:=LogoFormuleOnWord;
  F.Context:=@Q;}
  F.I:=J+1;
  If FOCompute(F,StrPas(PC))Then Begin
   N:=F.Result;
   J:=F.I-1;
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
0:SkipSpc(J,PC);
  If PC^[J]='"'Then Begin
   Inc(J);
   While Not(PC^[J]in[#0,'"'])do Begin
    IncStr(ST,PC^[J]);
    Inc(J)
   End;
   Inc(J)
  End
   Else
  Begin
   XtrkNumber(V[0]);
   Str(VariantToReal(V[0]):0:0,ST);
  End;
  SkipSpc(J,PC);
  If PC^[J]in['&','+']Then Begin
   Inc(J);
   Goto 0;
  End;
  S:=ST;
  _Str2S:=True;
 End;

Begin
 FMExecMacro:=0;
 DBOpenServerName(ChantalServer,'CHANTAL:/Compilateur/Basic/Instruction.Dat');
 If DBCopyToMemory(ChantalServer,Instr)Then Begin
  ALSetPtr(List,0);
  I:=0;
  While I<=List.Count-1do Begin
   PC:=_ALGetCurrBuf(List);
   J:=0;
   If(PC<>NIL)Then Begin
    While PC^[J]<>#0do Begin
     S:=XtrkWord;
     If DBLocateAbsIM(Instr,2,S,[])Then Begin
      Param:=Pointer(Instr.CurrRec);
      _DBGotoColumnAbs(Instr.FieldRec,3,Pointer(Param));
      IP:=0;SP:=0;LenParam:=Length(Param^);
      For JP:=1to(LenParam)do Begin
       ASM
        INC Word Ptr Param
       END;
       Case Param^[0]of
        #0:Break;
        'I':Begin
         If Not XtrkNumber(V[IP])Then Goto Xit;
         Inc(IP);
         If IP>7Then Break;
        End;
        'S':Begin
         Case(SP)of
          1:If Not _Str2S(S2)Then Goto Xit;
          Else If Not _Str2S(S)Then Goto Xit;
         End;
         Inc(SP);
        End;
        Else Begin
         SkipSpc(J,PC);
         If PC^[J]<>Param^[0]Then Begin
          Case Param^[0]of
           '(':FMExecMacro:=OpenParExpected;
           ',':FMExecMacro:=VirguleExpected;
           ')':FMExecMacro:=CloseParExpected;
           '-':FMExecMacro:=MinusExpected;
           Else FMExecMacro:=SyntaxError;
          End;
InvalidParam:
          ErrMsgOk('Param�tre invalide � la ligne '+WordToStr(I+1));
          Goto Xit;
         End;
         Inc(J);
        End;
       End;
      End;
      Case(Instr.CurrRec.Byte^)of
       $0B:Begin{CHDIR}
        FMChangeCurrDirectory(Q,S);
       End;
       $30:Begin{MKDIR}
        MkDir(S);
       End;
       $A4:Begin{FILECOPY}
        CopyFile(S,S2);
       End;
       Else Begin
        ErrMsgOk('Erreur � la ligne '+WordToStr(I+1));
        Goto Xit;
       End;
      End;
     End
      Else
     Begin
      ErrMsgOk('Instruction inconnu � la ligne '+WordToStr(I+1));
      Goto Xit;
     End;
    End;
   End;
   Inc(I);
   ALNext(List);
  End;
  DBDispose(Instr);
 End
  Else
 __OutOfMemory;
Xit:
End;

Function FMRunMacro(Var Q:FileManagerApp;Const FileName:String):SmallInt;
Var
 L:ArrayList;
Begin
 If ALLoadFileASCII(L,FileName)Then Begin
  FMRunMacro:=FMExecMacro(Q,L);
  ALDone(L);
 End;
End;

Function FMChoiceMacro(Var Q:FileManagerApp):SmallInt;
Var
 S:String;
Begin
 FMChoiceMacro:=0;
 S:=OpenWin('*.BAS','Ex�cute Macro');
 If S<>''Then FMChoiceMacro:=FMRunMacro(Q,S);
End;

END.