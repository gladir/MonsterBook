{ Cette unit‚ est destin‚ a effectu‚ l'ex‚cution de diff‚rentes Macro du
 programme de dessin en Bitmap.
}

Unit DrawMacr{o};

INTERFACE

Uses Systex,Isatex;

Function DWChoiceMacro(Var Q:DrawEditApp):SmallInt;
Function DWRunMacro(Var Q:DrawEditApp;Const FileName:String):SmallInt;
Function DWExecMacro(Var Q:DrawEditApp;Var List:ArrayList):SmallInt;

IMPLEMENTATION

Uses
 Dialex,Restex,Memories,Math,Systems,ResServD,
 Dials,DialPlus,DrawEdit,SysPlus;

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

Function DWExecMacro(Var Q:DrawEditApp;Var List:ArrayList):SmallInt;
Label
 InvalidParam,Xit;
Var
 LenParam:Byte;
 I:SmallInt;
 J:Word;
 Len:Word;
 SP:Byte;                 { Position de chaŒne de caractŠres }
 JP:Integer;              { Compteur de paramŠtres }
 IP:Word;                 { Position de variable }
 PC:PChr;
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
 DWExecMacro:=0;
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
           '(':DWExecMacro:=OpenParExpected;
           ',':DWExecMacro:=VirguleExpected;
           ')':DWExecMacro:=CloseParExpected;
           '-':DWExecMacro:=MinusExpected;
           Else DWExecMacro:=SyntaxError;
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
       $0F:Begin{CLS}
        DWClearImage(Q);
       End;
       $18:Begin{DRAW}
        WIDraw(Q.Canvas,S);
       End;
       $40:Begin{PRINT}
        If Not _Str2S(S)Then Goto InvalidParam;
        Len:=DWPutFont(Q,Q.XText,Q.YText,S);
        Inc(Q.XText,Len);
       End;
       $5B:Begin{LINE}
        WIPutLine(Q.Canvas,V[0].X.DataWord,V[1].X.DataWord,V[2].X.DataWord,
                       V[3].X.DataWord);
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
  DBDispose(Instr);
 End
  Else
 __OutOfMemory;
Xit:
End;

Function DWRunMacro(Var Q:DrawEditApp;Const FileName:String):SmallInt;
Var
 L:ArrayList;
Begin
 If ALLoadFileASCII(L,FileName)Then Begin
  DWRunMacro:=DWExecMacro(Q,L);
  ALDone(L);
 End;
End;

Function DWChoiceMacro(Var Q:DrawEditApp):SmallInt;
Var
 S:String;
Begin
 DWChoiceMacro:=0;
 S:=OpenWin('*.BAS','Ex‚cute Macro');
 If S<>''Then DWChoiceMacro:=DWRunMacro(Q,S);
End;

END.