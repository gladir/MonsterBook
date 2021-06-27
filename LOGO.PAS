{ Cette unit‚ est destin‚ … fournir une application permettant l'utilisation
 du langage de programmation LOGO.
}

Unit LOGO;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                 INTERFACE
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Function  LAInit(Var Context;X1,Y1,X2,Y2:Byte):Boolean;
Procedure LALoad(Var Context;X1,Y1,X2,Y2:Byte;Const Path:String);
Function  LARun(Var Context):Word;
Function  LADone(Var Context):Word;
Procedure LARefresh(Var Context);
Function  LAExecute(Var Context):Boolean;
Function  LASave(Var Context):Boolean;
Function  LASaveAs(Var Context;Const Path:String):Boolean;
Function  LATitle(Var Context;Max:Byte):String;
Procedure LAReSize(Var Context;X1,Y1,X2,Y2:Byte);
Procedure LAOnDeactivate(Var Context);
Procedure LAMove2(Var Context;X,Y:Byte);

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                IMPLEMENTATION
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses
 Adele,Systex,Memories,Systems,Dialex,Dials,Isatex,Editor,EdtLoad,
 EdtSave,EdtDone,Goldnaxe,Math,Numerix,ResTex,ResServD;

Const
 DataLong=2;

 brBreakPressed=1;
 brSyntaxError=2;
 brErrorInstr=3;

Function LogoFormuleOnWord(Var Obj;Const ThisWord:String;Var Context):Boolean;Forward;

Function VariantToString(Const Q:Variant):String;Begin
 Case(Q.TypeDef)of
  dtInt:VariantToString:=IntToStr(Q.X.DataInt);
  dtLong:VariantToString:=IntToStr(Q.X.DataLong);
  dtReal:If Q.X.DataReal=0.0Then VariantToString:='0'
                            Else VariantToString:=RealStr(Q.X.DataReal);
  {dtSingle:VariantToString:=RealStr(A.Single);
  dtDouble:VariantToString:=RealStr(A.Double);}
  Else VariantToString:='';
 End;
End;

Procedure PushVarLong(Var Q:LogoApp;X:LongInt;Const N:String);Near;
Label 1;
Type
 DataLongRec=Record
  TypeDef:Byte;
  Jmp:Word;
  Value:LongInt;
  Name:String;
 End;
Var
 Jmp,J,L,Ofs:Word;
Begin
 {Recherche d'une variable existante}
 J:=0;
 While Q.Data[J]<>0do Begin
  Case Q.Data[J]of
   0:L:=3;
   DataLong:L:=SizeOf(LongInt)+3;
   Else Break;
  End;
  If Compare(Q.Data[L+J],N,Length(N)+1)Then Begin
   ASM
    MOV BX,J
    ADD BX,3
    MOV Ofs,BX
   END;
   Goto 1;
  End;
  ASM
   MOV BX,J
   INC BX
   LES DI,Q
   MOV AX,Word Ptr ES:[DI].LogoApp.Data[BX]
   MOV J,AX
  END;
 End;
 {Affectation}
 If Q.CurData+Length(N)+8>SizeOf(Q.Data)Then Exit;
 Q.Data[Q.CurData]:=DataLong;
 Inc(Q.CurData);
 Jmp:=Q.CurData+2+SizeOf(LongInt)+Length(N)+1;
 ASM
   {Fixe le Jump}
  MOV AX,Jmp
  LES DI,Q
  MOV BX,ES:[DI].LogoApp.CurData
  MOV Word Ptr ES:[DI].LogoApp.Data[BX],AX
  ADD ES:[DI].LogoApp.CurData,TYPE Integer
 END;
 Ofs:=Q.CurData;
 Inc(Q.CurData,SizeOf(LongInt));
 MoveLeft(N,Q.Data[Q.CurData],Length(N)+1);
 Inc(Q.CurData,Length(N)+1);
1:
 ASM
   { Copie les donn‚es }
  LES AX,X
  MOV BX,Ofs
  LES DI,Q
  MOV Word Ptr ES:[DI].LogoApp.Data[BX],AX
  MOV Word Ptr ES:[DI].LogoApp.Data[BX+2],ES
 END;
End;

Function ReadVarLong(Var Q:LogoApp;Const N:String):LongInt;Near;
Var
 L,J:Word;
Begin
 J:=0;
 While Q.Data[J]<>0do Begin
  Case Q.Data[J]of
   0:L:=3;
   DataLong:L:=SizeOf(LongInt)+3;
   Else Break;
  End;
  If Compare(Q.Data[L+J],N,Length(N)+1)Then Begin
   ASM
    MOV BX,J
    ADD BX,3
    LES DI,Q
    LES AX,DWord Ptr ES:[DI].LogoApp.Data[BX]
    MOV Word Ptr @Result,AX
    MOV Word Ptr @Result[2],ES
   END;
   Exit;
  End;
  ASM
   MOV BX,J
   INC BX
   LES DI,Q
   MOV AX,Word Ptr ES:[DI].LogoApp.Data[BX]
   MOV J,AX
  END;
 End;
 ReadVarLong:=0;
End;

Procedure LAInternalInit(Var Q:LogoApp);Near;Begin
 FillClr(Q,SizeOf(Q));
 Q.Angle:=-PI/2;
 DBOpenServerName(ChantalServer,'CHANTAL:/Compilateur/Logo/Fonction.Dat');
 If DBCopyToMemory(ChantalServer,Q.Fonction)Then Begin
 End;
End;

Function LAInit(Var Context;X1,Y1,X2,Y2:Byte):Boolean;
Var
 Q:LogoApp Absolute Context;
Begin
 LAInternalInit(Q);
 WEInit(Q.W,X1,Y1,X2,Y2);
 WESubWins(Q.W,0,0,Q.W.MaxX-20,Q.W.MaxY-7,Q.TurtleW);
 Q.TurtleW.Palette:=CurrKrs.Dialog.Env.List;
 TENew(Q.Source,X1+1,Y2-7,X2-1,Y2-1);
 LARefresh(Q);
End;

Procedure LALoad(Var Context;X1,Y1,X2,Y2:Byte;Const Path:String);
Var
 Q:LogoApp Absolute Context;
Begin
 LAInternalInit(Q);
 WEInit(Q.W,X1,Y1,X2,Y2);
 WESubWins(Q.W,0,0,Q.W.MaxX-20,Q.W.MaxY-7,Q.TurtleW);
 Q.TurtleW.Palette:=CurrKrs.Dialog.Env.List;
 TEOpen(Q.Source,X1+1,Y2-7,X2-1,Y2-1,Path);
 LARefresh(Q);
End;

Function LARun(Var Context):Word;
Var
 Q:LogoApp Absolute Context;
 K:Word;
Begin
 K:=TERun(Q.Source);
 Case(K)of
  kbMouse:Begin
   K:=WEReadk(Q.W);
   If(K=kbInWn)Then Begin
    If WEGetkHor(Q.W,Q.W.MaxX-18,Q.W.MaxY-9,15,'Ex‚cuter')=0Then Begin
     If Not LAExecute(Q)Then K:=kbClose;
    End;
   End;
  End;
 End;
 LARun:=K;
End;

Function LADone(Var Context):Word;
Var
 Q:LogoApp Absolute Context;
Begin
 DBDispose(Q.Fonction);
 LADone:=TEDone(Q.Source);
End;

Procedure LAPutTurtle(Var Q:LogoApp);
Var
 X:Array[0..9]of Integer;

 Function FindY(X,Y:Integer):Integer;Begin
  FindY:=GetRawY(WEGetRY1(Q.TurtleW))+Q.Y+Round(Y*Sin(Q.Angle)+X*Cos(Q.Angle));
 End;

 Function FindX(X,Y:Integer):Integer;Begin
  FindX:=(WEGetRX1(Q.TurtleW)shl 3)+Q.X+Round(Y*Cos(Q.Angle)-X*Sin(Q.Angle))
 End;

Begin
 FillClr(X,SizeOf(X));
 X[0]:=FindX(0,12);
 X[1]:=FindY(0,12);
 X[2]:=FindX(-6,0);
 X[3]:=FindY(-6,0);
 X[4]:=FindX(6,0);
 X[5]:=FindY(6,0);
 X[6]:=X[0];
 X[7]:=X[1];
 FillPoly(4,X,Green);
{ WEPutLine(Q.TurtleW,X[0],X[1],X[2],X[3],Green);
 WEPutLine(Q.TurtleW,X[2],X[3],X[4],X[5],Green);
 WEPutLine(Q.TurtleW,X[4],X[5],X[0],X[1],Green);}
 WEPutTxtXY(Q.W,Q.W.MaxX-18,1,'Position X: '+StrUSpc(IntToStr(-(Q.XC-Q.X)),9));
 WEPutTxtXY(Q.W,Q.W.MaxX-18,3,'Position Y: '+StrUSpc(IntToStr(Q.YC-Q.Y),9));
 WEPutTxtXY(Q.W,Q.W.MaxX-18,5,'Angle: '+StrUSpc(IntToStr(Trunc(-(Q.Angle*DegreesPerRadian))),9));
End;

Procedure LARefresh(Var Context);
Var
 Q:LogoApp Absolute Context;
Begin
 WEPutWnKrDials(Q.W,'Logo');
 WECloseIcon(Q.W);
 WEZoomIcon(Q.W);
 WEBar(Q.W);
 WESetKrBorder(Q.TurtleW);
 WEClrScr(Q.TurtleW);
 Q.XC:=Q.TurtleW.MaxX shl 2;
 Q.YC:=GetRawY(Q.TurtleW.MaxY)shr 1;
 Q.X:=Q.XC;
 Q.Y:=Q.YC;
 LAPutTurtle(Q);
 WEPutkHor(Q.W,Q.W.MaxX-18,Q.W.MaxY-9,15,'Ex‚cuter');
 TERefresh(Q.Source);
End;

Function XtrkNumber(Var Q:LogoApp):Integer;
Var
 F:FormulaObject;
Begin
 While Q.PC^[Q.I]=' 'do Inc(Q.I);
 FOInit(F);
 F.OnWord:=LogoFormuleOnWord;
 F.Context:=@Q;
 F.I:=Q.I+1;
 If FOCompute(F,StrPas(Q.PC))Then Begin
  XtrkNumber:=VariantToInt(F.Result);
  Q.I:=F.I-1;
 End
  Else
 XtrkNumber:=-1;
End;

Function Num(Var Q:LogoApp;Var N:Variant):Boolean;
Var
 F:FormulaObject;
Begin
 FOInit(F);
 F.OnWord:=LogoFormuleOnWord;
 F.Context:=@Q;
 F.I:=Q.I+1;
 Num:=FOCompute(F,StrPas(Q.PC));
 Q.I:=F.I-1;
 N:=F.Result;
End;

Function LogoFormuleOnWord(Var Obj;Const ThisWord:String;Var Context):Boolean;
Label
 1,_PushNumberByte,_PushNumberWord,_PushNumberLong,ErrorInstr,ContinueOk,
 _COS,_SIN,_XCOR,_YCOR;
Var
 Q:FormulaObject Absolute Obj;
 BR:LogoApp Absolute Context;
 L:LongInt;               { Variable temporaire entier long }
 LI:Integer Absolute L;   { Variable temporaire entier }
 W:Word Absolute L;       { Variable temporaire entier }
 BV:Byte Absolute L;      { Variable temporaire octet }
 LenParam:Integer;        { Nombre de paramŠtres }
 JP:Integer;              { Compteur de paramŠtres }
 IP:Word;                 { Position de variable ®Variant¯ }
 SP:Word;                 { Position de variable ®String¯ }
 OpenPar:Boolean;         { Ouverture de parenthŠse? }
 A,B,C:Variant;
 V:Array[0..7]of Variant;
 S:Array[0..1]of String;
 Ok:Boolean;
 PC2:Pointer;
 Param:^String;
Begin
 LogoFormuleOnWord:=False;
 If ThisWord='DO'Then Begin
  Q.StopNow:=True;
  Exit;
 End;

 If DBLocateAbsIM(BR.Fonction,1,ThisWord,[])Then Begin
  Param:=Pointer(BR.Fonction.CurrRec);
  _DBGotoColumnAbs(BR.Fonction.FieldRec,2,Pointer(Param));
  SP:=0;IP:=0;LenParam:=Length(Param^);
  If LenParam>0Then Begin
   For JP:=0to 7do V[JP].TypeDef:=dtNoType;
  End;
  OpenPar:=False;
  For JP:=1to(LenParam)do Begin
   ASM
    INC Word Ptr Param
   END;
   Case Param^[0]of
    #0:Break;
    '|':Begin
     SkipSpcInLn(Q.I,Q.Formula);
     If JP=1Then Begin
      If(Length(Q.Formula)<Q.I)Then Break;
      If StrI(Q.I,Q.Formula)<>'('Then Break;
     End;
     If StrI(Q.I,Q.Formula)=')'Then Begin
      Inc(Q.I);
      Break;
     End;
    End;
    'I','N','R','V':Begin
     BR.I:=Q.I-1;
     If Not Num(BR,V[IP])Then Begin
      If Param^[0]='V'Then Begin
       BR.I:=Q.I;
       {If Not _Str2S(BR,S[SP])Then} Exit;
       Q.I:=BR.I;
       Inc(SP);
       V[IP].TypeDef:=dtString;
      End
       Else
      Exit;
     End;
     Q.I:=BR.I+1;
     Case Param^[0]of
      'I':Begin
       V[IP].X.DataLong:=VariantToInt(V[IP]);
       V[IP].TypeDef:=dtInt;
      End;
      'R':Begin
       V[IP].X.DataReal:=VariantToReal(V[IP]);
       V[IP].TypeDef:=dtReal;
      End;
     End;
     Inc(IP);
     If IP>7Then Break;
    End;
    {'S':Begin
     BR.X:=Q.I-1;
     If Not _Str2S(BR,S[SP])Then Exit;
     Q.I:=BR.X+1;
     Inc(SP);
    End;}
    Else Begin
     SkipSpcInLn(Q.I,Q.Formula);
     If StrI(Q.I,Q.Formula)<>Param^[0]Then Begin
      Case Param^[0]of
       '(':Goto ContinueOk;
       ',':BR.ExitCode:=VirguleExpected;
       ')':If(OpenPar)Then BR.ExitCode:=CloseParExpected
                      Else Goto ContinueOk;
       '-':BR.ExitCode:=MinusExpected;
       Else BR.ExitCode:=SyntaxError;
      End;
      Exit;
     End
      Else
     If Param^[0]='('Then OpenPar:=True;
     Inc(Q.I);
ContinueOk:
    End;
   End;
  End;
  ASM
   LES DI,BR
   LES DI,ES:[DI].LogoApp.Fonction.CurrRec
   MOV BL,ES:[DI]
   JMP @Next
@Label:
   DW Offset ErrorInstr     { 0 }
   DW Offset _COS           { 1 }
   DW Offset _SIN           { 2 }
   DW Offset _XCOR          { 3 }
   DW Offset _YCOR          { 4 }
   DW Offset ErrorInstr     { 5 }
   DW Offset ErrorInstr     { 6 }
   DW Offset ErrorInstr     { 7 }
   DW Offset ErrorInstr     { 8 }
   DW Offset ErrorInstr     { 9 }
   DW Offset ErrorInstr     { A }
   DW Offset ErrorInstr     { B }
   DW Offset ErrorInstr     { C }
   DW Offset ErrorInstr     { D }
   DW Offset ErrorInstr     { E }
   DW Offset ErrorInstr     { F }
@Next:
   AND BX,000Fh
   SHL BX,1
   JMP @Label.Word[BX]
  END;
ErrorInstr:
  BR.ExitCode:=brErrorInstr;
  Exit;
_COS:
  FOPushNumberReal(Q,Cos(V[0].X.DataInt*0.017453292520));
  Goto 1;
_SIN:
  FOPushNumberReal(Q,Sin(V[0].X.DataInt*0.017453292520));
  Goto 1;
_XCOR:
 L:=-(BR.XC-BR.X);
 Goto _PushNumberLong;
_YCOR:
 L:=BR.YC-BR.Y;
 Goto _PushNumberLong;
_PushNumberByte:
  ASM
   MOV Byte Ptr L[1],0
  END;
_PushNumberWord:
  ASM
   MOV Word Ptr L[2],0
  END;
_PushNumberLong:
  FOPushNumberLong(Q,L);
1:While StrI(Q.I,Q.Formula)in[#9,' ']do Inc(Q.I);
  BR.I:=Q.I+1;
 End
  Else
{ If ThisWord='ABS'Then Begin
  BR.I:=Q.I;
  FOPushNumberLong(Q,Abs(XtrkNumber(BR)));
  Q.I:=BR.I;
 End
  Else}
 FOPushNumberLong(Q,ReadVarLong(BR,ThisWord));
 LogoFormuleOnWord:=True;
End;

{Function LogoFormuleOnWord(Var Obj;Const ThisWord:String;Var Context):Boolean;
Var
 Q:FormulaObject Absolute Obj;
 BR:LogoApp Absolute Context;
Begin
 LogoFormuleOnWord:=False;
 If ThisWord='DO'Then Begin
  Q.StopNow:=True;
  Exit;
 End;
 If ThisWord='ABS'Then Begin
  BR.I:=Q.I;
  FOPushNumberLong(Q,Abs(XtrkNumber(BR)));
  Q.I:=BR.I;
 End
  Else
 FOPushNumberLong(Q,ReadVarLong(BR,ThisWord));
 LogoFormuleOnWord:=True;
End;}

Function LAExecute(Var Context):Boolean;
Label Xit,NextLine;
Var
 Q:LogoApp Absolute Context;
 S:String;
 ST:String;
 IO,JO:Word;
 Val,ValB:Integer;    { Variable temporaire }
 V:Variant;           { Variable de type Variant }
 XMove,YMove:Integer; { D‚placement demander }
 Instr:DataSetInMemory;

 Procedure SkipSpcInLine;Begin
  While Q.PC^[Q.I]=' 'do Inc(Q.I);
 End;

 Function XtrkWord:String;Begin
  SkipSpcInLine;
  XtrkWord:=StrUp(PXtrkWord(Q.I,Q.PC));
 End;

Begin
 LAExecute:=True;
 DBOpenServerName(ChantalServer,'CHANTAL:/Compilateur/Logo/Instruction.Dat');
 DBCopyToMemory(ChantalServer,Instr);
 WEClrScr(Q.TurtleW);
 Q.PenDown:=True;
 Q.Angle:=-PI/2;
 Q.X:=Q.TurtleW.MaxX shl 2;
 Q.Y:=GetRawY(Q.TurtleW.MaxY)shr 1;
 Q.BouclePos:=0;
 ALSetPtr(Q.Source.List,0);
 Q.Line:=0;
 While Q.Line<=Q.Source.List.Count-1do Begin
  Q.PC:=_ALGetCurrBuf(Q.Source.List);
  Q.I:=0;
NextLine:
  If(Q.PC<>NIL)Then Begin
   S:=XtrkWord;
   If DBLocateAbsIM(Instr,1,S,[])Then Case(Instr.CurrRec.Byte^)of
    $01:Begin { QUITTER }
     LAExecute:=False;
     Goto Xit;
    End;
    $02:Begin { GAUCHE }
     Val:=XtrkNumber(Q);
     If Val=-1Then Val:=90;
     Q.Angle:=Q.Angle+(360-Val)*0.017453292520;
    End;
    $03:Begin { DROITE }
     Val:=XtrkNumber(Q);
     If Val=-1Then Val:=90;
     Q.Angle:=Q.Angle+Val*0.017453292520;
    End;
    $04:Begin { AVANCER }
     Val:=XtrkNumber(Q);
     XMove:=Trunc(Cos(Q.Angle)*Val);
     YMove:=Trunc(Sin(Q.Angle)*Val);
     If(Q.PenDown)Then WEPutLine(Q.TurtleW,Q.X,Q.Y,Q.X+XMove,Q.Y+YMove,Black);
     Inc(Q.X,XMove);
     Inc(Q.Y,YMove);
    End;
    $05:Begin { ARRIERE }
     Val:=-XtrkNumber(Q);
     XMove:=Trunc(Cos(Q.Angle)*Val);
     YMove:=Trunc(Sin(Q.Angle)*Val);
     If(Q.PenDown)Then WEPutLine(Q.TurtleW,Q.X,Q.Y,Q.X+XMove,Q.Y+YMove,Black);
     Inc(Q.X,XMove);
     Inc(Q.Y,YMove);
    End;
    $06:Begin { LEVER-CRAYON }
     Q.PenDown:=False;
    End;
    $08:Begin { BAISSER-CRAYON }
     Q.PenDown:=True;
    End;
    $09:Begin { DEBUT }
    End;
    $0A:Begin { CACHER }
    End;
    $0B:Begin { AFFICHER }
     If Num(Q,V)Then WEPutTxtLn(Q.TurtleW,VariantToString(V));
     {WEPutTxtLn(Q.TurtleW,IntToStr(XtrkNumber(Q)));}
    End;
    $0C:Begin { COULEUR }
    End;
    $0E:Begin { POSX }
    End;
    $0F:Begin { POSY }
    End;
    $10:Begin { ANGLE }
     Val:=XtrkNumber(Q);
     Q.Angle:=Q.Angle+Val*0.017453292520;
    End;
    $13:Begin { FOR }
     Inc(Q.BouclePos);
     If Q.BouclePos>63Then Begin
      {Q.ExitCode:=TooManyBoucle;}
      Goto Xit;
     End;
     Q.Boucle[Q.BouclePos].Model:=blFor;
     Q.Boucle[Q.BouclePos].X:=Q.I;
     Q.Boucle[Q.BouclePos].Y:=Q.Line;
     S:=XtrkWord;
     ST:=XtrkWord;
     If(ST='TO')or(ST='A')Then Begin
      XtrkNumber(Q);
      PushVarLong(Q,0,S);
      ST:=XtrkWord;
      If Not((ST='DO')or(ST='FAIT')or(ST='FAIRE'))Then Begin
       {Q.ExitCode:=SyntaxError;}
       Goto Xit;
      End;
      Q.Boucle[Q.BouclePos].X2:=Q.I;
     End;
    End;
    $14:Begin { OD }
     If Q.BouclePos=0Then Begin
      Q.ExitCode:=NextWithoutFor;
      Goto Xit;
     End;
     If(Q.Boucle[Q.BouclePos].Model<>blFor)Then Begin
      Q.ExitCode:=MisplacedNext;
      Goto Xit;
     End;
     IO:=Q.Line;JO:=Q.I;
     If(Q.Boucle[Q.BouclePos].Y<>Q.Line)Then Begin
      Q.Line:=Q.Boucle[Q.BouclePos].Y;
      ALSetPtr(Q.Source.List,Q.Line);
      Q.PC:=_ALGetCurrBuf(Q.Source.List);
     End;
     Q.I:=Q.Boucle[Q.BouclePos].X;
     S:=XtrkWord;
     ST:=XtrkWord;
     ValB:=XtrkNumber(Q);
     Val:=ReadVarLong(Q,S);
     Inc(Val);
     If(Val<ValB)Then Begin
      Q.I:=Q.Boucle[Q.BouclePos].X2;
      PushVarLong(Q,Val,S);
      Goto NextLine;
     End;
     Q.I:=JO;Q.Line:=IO;
     ALSetPtr(Q.Source.List,Q.Line);
     Q.PC:=_ALGetCurrBuf(Q.Source.List);
     Dec(Q.BouclePos);
    End;
   End
    Else
   Begin
    If Q.PC^[Q.I]='='Then Begin
     Inc(Q.I);
     Val:=XtrkNumber(Q);
     PushVarLong(Q,Val,S);
    End;
   End;
  End;
  ALNext(Q.Source.List);
  Inc(Q.Line);
 End;
Xit:
 DBDispose(Instr);
 LAPutTurtle(Q);
End;

Function LASave(Var Context):Boolean;
Var
 Q:LogoApp Absolute Context;
Begin
 LASave:=TESave(Q.Source);
End;

Function LASaveAs(Var Context;Const Path:String):Boolean;
Var
 Q:LogoApp Absolute Context;
Begin
 LASaveAs:=TESaveAs(Q.Source,Path);
End;

Function LATitle(Var Context;Max:Byte):String;Begin
 LATitle:='Logo';
End;

Procedure LAReSize(Var Context;X1,Y1,X2,Y2:Byte);Begin
End;

Procedure LAOnDeactivate(Var Context);Begin
End;

Procedure LAMove2(Var Context;X,Y:Byte);Begin
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
END.