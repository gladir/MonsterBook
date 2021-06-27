{ Cette unit‚ est destin‚ a effectu‚ l'ex‚cution de diff‚rentes Macro du
 programme de dessin en Bitmap.
}

Unit CalcMacr{o};

INTERFACE

Uses Systex,Isatex;

Function SCChoiceMacro(Var Q:SuperCalcApp):SmallInt;
Function SCRunMacro(Var Q:SuperCalcApp;Const FileName:String):SmallInt;
Function SCExecMacro(Var Q:SuperCalcApp;Var List:ArrayList):SmallInt;

IMPLEMENTATION

Uses
 Dialex,Restex,Memories,Math,Systems,ResServD,
 Dials,DialPlus,MalCalc,SysPlus;

Procedure SkipSpc(Var I:Word;PC:PChr);Near;Assembler;ASM
  {While PC^[I]in[#9,' ']do Inc(I);}
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

Function SCExecMacro(Var Q:SuperCalcApp;Var List:ArrayList):SmallInt;
Label
 InvalidParam,Xit;
Var
 LenParam:Byte;
 CurrAttr:Byte;
 I:SmallInt;
 J:Word;
 Len:Word;
 SP:Byte;                 { Position de chaŒne de caractŠres }
 JP:Integer;              { Compteur de paramŠtres }
 IP:Word;                 { Position de variable }
 PC:PChr;
 PCel:PCellule;
 V:Array[0..7]of Variant;
 Instr:DataSetInMemory;
 S,S2:String;
 Param:^String;           { ParamŠtres }

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
 SCExecMacro:=0;
 CurrAttr:=CurrKrs.Dialog.Env.List.Border;
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
           '(':SCExecMacro:=OpenParExpected;
           ',':SCExecMacro:=VirguleExpected;
           ')':SCExecMacro:=CloseParExpected;
           '-':SCExecMacro:=MinusExpected;
           Else SCExecMacro:=SyntaxError;
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
       $01:Begin{ATTR}
        PCel:=SCGetCurrCellule(Q);
        CurrAttr:=V[0].X.DataWord+(V[1].X.DataWord shl 4);
        If(PCel<>NIL)Then PCel^.Header.Attribut:=CurrAttr;
       End;
       $40:Begin{PRINT}
        If Not _Str2S(S)Then Goto InvalidParam;
        SCPushData(Q,S);
        PCel:=SCGetCurrCellule(Q);
        If(PCel<>NIL)Then PCel^.Header.Attribut:=CurrAttr;
        SCDn(Q);
       End;
       Else Begin
        ErrMsgOk('Erreur … la ligne '+WordToStr(I+1));
        Goto Xit;
       End;
      End;
     End
      Else
     Begin
      ErrMsgOk('Instruction inconnu … la ligne '+WordToStr(I+1));
      Goto Xit;
     End;
    End;
   End;
   Inc(I);
   ALNext(List);
  End;
 End
  Else
 __OutOfMemory;
Xit:
End;

Function SCRunMacro(Var Q:SuperCalcApp;Const FileName:String):SmallInt;
Var
 L:ArrayList;
Begin
 If ALLoadFileASCII(L,FileName)Then Begin
  SCRunMacro:=SCExecMacro(Q,L);
  ALDone(L);
 End;
End;

Function SCChoiceMacro(Var Q:SuperCalcApp):SmallInt;
Var
 S:String;
Begin
 SCChoiceMacro:=0;
 S:=OpenWin('*.BAS','Ex‚cute Macro');
 If S<>''Then SCChoiceMacro:=SCRunMacro(Q,S);
End;

END.