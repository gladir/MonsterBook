{ Cette unit‚ est destin‚ est destin‚ … effectuer des calculs de
 classe math‚matique.
}

Unit Math;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                  INTERFACE
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

{$I DEF.INC}

Uses Systex;

Const
  {Code d'erreur retourner par les fonctions math‚matique }
 fnOk=0;         { Pas d'erreur }
 fnDomain=-1;    { Erreur d'argument du domain }
 fnSing=-2;      { Fonction singulaire }
 fnOverflow=-3;  { Erreur de d‚bordement }
 fnUnderflow=-4; { Erreur de sous-d‚bordement }
 fnTLoss=-5;     { Pr‚cision total ‚gar‚ }
 fnPLoss=-6;     { Pr‚cision partiel ‚gar‚}
 fnDiv0=-10;     { Division par 0 }

 MaxNum=4.253529586E+37; { 2^126 }
 MinNum=2.350988703E-38; { 2^(-125) }

Var
 MathErr:ShortInt; { Code d'erreur retourner par la derniŠre op‚ration math‚matique }

Function  AbsInt(I:Integer):Integer;
Function  Alpha(a,b:LongInt):LongInt;
Procedure CompAdd(Var Number:Comp;AddNumber:Comp);
Procedure CompInc(Var Number:Comp);
Function  DefaultVal(ErrCode:Integer):Real;
Function  DivLong(a,b:LongInt):LongInt;
Function  DoubleToReal(X:Double):Real;
Procedure FOInit(Var Q:FormulaObject);
Function  FOCompute(Var Q:FormulaObject;Const S:String):Boolean;
Function  FOXtrkWord(Var Q:FormulaObject):String;
Function  FOPushNumber(Var Q:FormulaObject;Const X:Variant):Boolean;
Function  FOPushNumberBool(Var Q:FormulaObject;X:Boolean):Boolean;
Function  FOPushNumberLong(Var Q:FormulaObject;X:LongInt):Boolean;
Function  FOPushNumberReal(Var Q:FormulaObject;X:Real):Boolean;
{$IFNDEF Win32}
Procedure Int00h(Flags,CS,IP,AX,BX,CX,DX,SI,DI,DS,ES,BP:Word);Interrupt;
{$ENDIF}
Function  IntPower(X:Real;N:Integer):Real;
Function  IsNumber(Const S:String):Boolean;
Function  IsRealNumber(Const S:String):Boolean;
Function  LongMotorolaToIntel(Value:LongInt):LongInt;
Function  MaxByte(N,Max:Byte):Byte;
Function  MinByte(N,Max:Byte):Byte;
Function  Mul2Word(A,B:Word):LongInt;
          {$IFNDEF __Windows__}
           InLine(ciPopAX/    { POP AX }
                  ciPopDX/    { POP DX }
                  $F7/$E2);   { MUL DX }
          {$ENDIF}
Function  MulL(a,b:LongInt):LongInt;
Function  Omega(a,b:LongInt):LongInt;
Function  Power(InNumber,Exponent:Real):Real;
Procedure QuickSort2(NumberIndex:Integer;Var X:Array of Integer;Var Y:Array of Integer);
Procedure RealToDouble(X:Real;Var Y:Double);
Function  ToBcd(Number:Byte):Byte;
Function  VariantToReal(Const Q:Variant):Real;
Function  VariantToInt(Const Q:Variant):LongInt;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                IMPLEMENTATION
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses Adele,Memories,Systems;

Type
 TPReal=Record
  Exponent:Byte;
  Mantissa1:Word;
  Mantissa2:Word;
  MS:Byte;
 End;

 DoubleStruct=Record
  Mantissa1:Word;
  Mantissa2:Word;
  Mantissa3:Word;
  M4ES:Word;
 End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                             Fonction AbsInt                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction retourne la valeur absolue de la valeur entiŠre contenue
 dans la variable de param‚trage ®I¯.


 Remarques
 ÍÍÍÍÍÍÍÍÍ

  ş Attention!  Cette fonction ne supporte en aucun cas les ®LongInt¯, et
    vous devrez  donc  utilise la fonction  ®Abs¯  d'origine dans l'unit‚
    ®SYSTEM¯ du compilateur pour avoir ce mˆme effet.

  ş Utilisez la directive de compilation conditionnel  ®Compatible¯  pour
    indiquer  …  la  proc‚dure  qu'il  doit  utiliser  une  technique  de
    compatibilit‚ ind‚pendament  de la taille d'une variable entiŠre  (si
    vous pr‚f‚rez, ayant une taille pouvant ˆtre diff‚rente de 2 octets).
}

{$I \Source\Chantal\Library\AbsInt.Inc}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Fonction Alpha                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction retourne la valeur plus petite entre la variable de
 param‚trage  ®a¯ et ®b¯.  Elle souvent nomm‚  ®Min¯  par les autres
 programmes toutefois, cette fonction est utilis‚ … d'autre fin...
}

Function Alpha{a,b:LongInt):LongInt};Begin
 If(a<=b)Then Alpha:=a
         Else Alpha:=b;
End;

{ Cette proc‚dure permet d'additionner un entier de 64 bits … un autre
}

Procedure CompAdd(Var Number:Comp;AddNumber:Comp);
{$IFNDEF __Windows__}
 Assembler;ASM
  {$IFDEF __386__}
   MOV ECX,DWord Ptr AddNumber
   ADD DWord Ptr [EAX],ECX
   MOV ECX,DWord Ptr AddNumber[4]
   ADD DWord Ptr [EAX+4],ECX
  {$ELSE}
   LES DI,Number
   MOV AX,Word Ptr AddNumber[0]
   ADD Word Ptr ES:[DI],AX
   MOV AX,Word Ptr AddNumber[2]
   ADC Word Ptr ES:[DI+2],AX
   MOV AX,Word Ptr AddNumber[4]
   ADC Word Ptr ES:[DI+4],AX
   MOV AX,Word Ptr AddNumber[6]
   ADC Word Ptr ES:[DI+6],AX
  {$ENDIF}
 END;
{$ELSE}
 Begin
  Number:=Number+AddNumber;
 End;
{$ENDIF}

{ Cette proc‚dure permet d'incr‚menter un entier de 64 bits.
}

Procedure CompInc(Var Number:Comp);
{$IFNDEF __Windows__}
 Assembler;ASM
  LES DI,Number
  XOR AX,AX
  ADD Word Ptr ES:[DI],1
  ADC Word Ptr ES:[DI+2],AX
  ADC Word Ptr ES:[DI+4],AX
  ADC Word Ptr ES:[DI+6],AX
 END;
{$ELSE}
 Begin
  Number:=Number+1;
 End;
{$ENDIF}

Function DefaultVal(ErrCode:Integer):Real;Begin
 MathErr:=ErrCode;
 Case(ErrCode)of
     fnDomain:DefaultVal:=0.0;
       fnSing:DefaultVal:=MaxNum;
   fnOverflow:DefaultVal:=MaxNum;
  fnUnderflow:DefaultVal:=0.0;
  Else DefaultVal:=0.0;
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                             Fonction DivL                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet d'effectuer une division de type long et s'il y
 une erreur de division par 0 il retourne tous simplement 0.
}

Function DivLong(a,b:LongInt):LongInt;Begin
 If(a=0)or(b=0)Then Begin
  DivLong:=0;
  If b=0Then MathErr:=fnDiv0;
 End
  Else
 DivLong:=LongInt(LongInt(a)div LongInt(b));
End;

{ Cette fonction permet de convertir un nombre de format ®Double¯ en
 format ®Real¯.
}

Function DoubleToReal(X:Double):Real;
Var
 DStruct:DoubleStruct Absolute X;
 Real48:TPReal;
 Y:Real Absolute Real48;
Begin
 FillClr(Real48,SizeOf(Real48));
 Real48.Exponent:=((DStruct.M4ES and$7FF0)shr 4)-894;
 Real48.MS:=(((((DStruct.M4ES and$000F)shl 3)or
            ((DStruct.Mantissa3 and$E000)shr 13)))and$7F)or
            (Hi(DStruct.M4ES)and$80);
 Real48.Mantissa2:=(((DStruct.Mantissa3 and$1FFF)shl 3)or
                   ((DStruct.Mantissa2 and$E000)shr 13));
 Real48.Mantissa1:=(((DStruct.Mantissa2 and$1FFF)shl 3) or
                   ((DStruct.Mantissa1 and$E000)shr 13));
 DoubleToReal:=Y;
End;

{ Cette proc‚dure permet d'initialiser les routines de ®FormulaObject¯.
}

Procedure FOInit(Var Q:FormulaObject);Begin
 FillClr(Q,SizeOf(Q));
 Q.I:=1;
End;

Function FOPushNumber(Var Q:FormulaObject;Const X:Variant):Boolean;Begin
 Q.PostFixeData.Operateur:=False;
 Q.PostFixeData.Priorite:=0;
 Q.PostFixeData.Valeur:=X;
 FOPushNumber:=ALAddBlock(Q.PostFixe,SizeOf(PostFixeRec),Q.PostFixeData);
End;

Function FOPushNumberReal(Var Q:FormulaObject;X:Real):Boolean;Begin
 Q.PostFixeData.Operateur:=False;
 Q.PostFixeData.Priorite:=0;
 Q.PostFixeData.Valeur.TypeDef:=dtReal;
 Q.PostFixeData.Valeur.X.DataReal:=X;
 FOPushNumberReal:=ALAddBlock(Q.PostFixe,SizeOf(PostFixeRec),Q.PostFixeData);
End;

Function FOPushNumberLong(Var Q:FormulaObject;X:Long):Boolean;Begin
 Q.PostFixeData.Operateur:=False;
 Q.PostFixeData.Priorite:=0;
 Q.PostFixeData.Valeur.TypeDef:=dtLong;
 Q.PostFixeData.Valeur.X.DataLong:=X;
 FOPushNumberLong:=ALAddBlock(Q.PostFixe,SizeOf(PostFixeRec),Q.PostFixeData);
End;

Function FOPushNumberBool(Var Q:FormulaObject;X:Boolean):Boolean;Begin
 Q.PostFixeData.Operateur:=False;
 Q.PostFixeData.Priorite:=0;
 Q.PostFixeData.Valeur.TypeDef:=dtBool;
 Q.PostFixeData.Valeur.X.DataBool:=X;
 FOPushNumberBool:=ALAddBlock(Q.PostFixe,SizeOf(PostFixeRec),Q.PostFixeData);
End;

Function FOXtrkWord(Var Q:FormulaObject):String;
Var
 T:String;
Begin
 SkipSpcInLn(Q.I,Q.Formula);
 T:='';
 If StrI(Q.I,Q.Formula)='@'Then Begin
  IncStr(T,'@');
  Inc(Q.I);
 End;
 AddStr(T,StrUp(XtrkWord(Q.I,Q.Formula)));
 While(StrI(Q.I,Q.Formula)='.')and(StrI(Q.I+1,Q.Formula)<>'.')do Begin
  IncStr(T,'.');
  Inc(Q.I);
  AddStr(T,StrUp(XtrkWord(Q.I,Q.Formula)));
 End;
 FOXtrkWord:=T;
End;

Function FOStrI(Var Q:FormulaObject):Char;Near;Begin
 SkipSpcInLn(Q.I,Q.Formula);
 FOStrI:=StrI(Q.I,Q.Formula);
End;

Procedure FOSaveAddr(Var Q:FormulaObject);Near;Begin
 Q.OldI:=Q.I;
End;

Procedure FORestoreAddr(Var Q:FormulaObject);Near;Begin
 Q.I:=Q.OldI;
End;

Function FOXtrkData(Var Q:FormulaObject;Var Value:Variant;Basic:Boolean):Boolean;Near;
Label
 NumberBasic,ClassicNumber,XN;
Var
 T:String;
 J:Integer;
 OldI:Byte;
 Err:Integer;  { Code d'erreur de valeur }
 Pour:Boolean; { Pourcentage? }
Begin
 Pour:=False;
 FOXtrkData:=False;
 OldI:=Q.I;
 FillClr(Value,SizeOf(Value));
 Value.TypeDef:=dtReal;
 If(Basic)Then Begin
  T:='0';
  Goto NumberBasic;
 End;
 Case FOStrI(Q)of
  '$':If(foHexPascal in Q.Option)Then Begin
   Inc(Q.I);
   T:=XtrkHexNm(Q.I,Q.Formula);
   If T=''Then Exit;
   Value.X.DataLong:=HexStrToInt(T);
   Value.TypeDef:=dtLong;
  End;
  '-':Begin
   Inc(Q.I);
   T:='-'+XtrkDecNm(Q.I,Q.Formula);
   Goto XN;
  End;
  '%':If(foPourcent in Q.Option)Then Begin
   Inc(Q.I);
   Pour:=True;
   T:=XtrkDecNm(Q.I,Q.Formula);
   Goto XN;
  End
   Else
  Exit;
  Else Begin
   T:='';
   If StrI(Q.I,Q.Formula)in['0'..'9']Then T:=XtrkHexNm(Q.I,Q.Formula);
   If T=''Then Exit;
XN:If(Not((StrI(Q.I,Q.Formula)in Q.StopChar))and
     ((StrI(Q.I,Q.Formula)=DeSep[0])or(StrI(Q.I,Q.Formula)='.')))Then Begin
    IncStr(T,'.');
    Inc(Q.I);
    AddStr(T,XtrkHexNm(Q.I,Q.Formula));
    If(T[Length(T)]='E')and(StrI(Q.I,Q.Formula)in['+','-'])Then Begin
     IncStr(T,Q.Formula[Q.I]);
     Inc(Q.I);
     AddStr(T,XtrkDecNm(Q.I,Q.Formula));
    End;
    Val(T,Value.X.DataReal,Err);
    Value.TypeDef:=dtReal;
   End
    Else
   If(foNumberC in Q.Option)Then Begin
NumberBasic:
    Repeat
     Case StrI(Q.I,Q.Formula)of
      'o','O','q','Q':If T<>'0'Then Exit
       Else
      Begin
       Inc(Q.I);
       Value.X.DataReal:=OctStr2Nm(XtrkOctNm(Q.I,Q.Formula));
      End;
      'b','B':If T<>'0'Then Exit
       Else
      Begin
       Inc(Q.I);
       Value.X.DataLong:=BinStr2Nm(XtrkBinNm(Q.I,Q.Formula));
      End;
      'h','H','x','X':If T<>'0'Then Exit
       Else
      Begin
       Inc(Q.I);
       Value.X.DataLong:=HexStrToInt(XtrkHexNm(Q.I,Q.Formula));
      End;
      Else Begin
ClassicNumber:
       If Not(T[1]in['0'..'9','-'])Then Exit;
       For J:=2to Length(T)do If Not(T[J]in['0'..'9'])Then Exit;
       If Pos('.',T)=0Then Begin
        Value.X.DataLong:=StrToInt(T);
       End
        Else
       Begin
        Value.X.DataReal:=StrToInt(T);
        Break;
       End;
      End;
     End;
     Value.TypeDef:=dtLong;
    Until True;
   End
    Else
   Goto ClassicNumber;
   If(foPourcent in Q.Option)and(StrI(Q.I,Q.Formula)='%')Then Begin
    Pour:=True;
    Inc(Q.I);
   End;
  End;
 End;
 If(Pour)Then Begin
  Value.X.DataReal:=VariantToReal(Value)/100;
  Value.TypeDef:=dtReal;
 End;
 FOXtrkData:=True;
End;

Procedure FOPostFixeBoolean(Var Q:FormulaObject;Expression:Boolean);Near;Begin
 Q.PostFixeData.Valeur.X.DataBool:=Expression;
 Q.PostFixeData.Valeur.TypeDef:=dtBool;
End;

Procedure FOPostFixeLong(Var Q:FormulaObject;Value:LongInt);Near;Begin
 Q.PostFixeData.Valeur.X.DataLong:=Value;
 Q.PostFixeData.Valeur.TypeDef:=dtLong;
End;

Procedure FOPostFixeReal(Var Q:FormulaObject;Value:Real);Near;Begin
 Q.PostFixeData.Valeur.X.DataReal:=Value;
 Q.PostFixeData.Valeur.TypeDef:=dtReal;
End;

Function FOCompute(Var Q:FormulaObject;Const S:String):Boolean;
Label
 1,2,Continue,ReadWord,Xit;
Var
 PPostFixe2:PostFixePtr;
 Ok:Boolean;
 J,Paren:Integer;
 PostFixeA,PostFixeB:PostFixeRec;
 PostFixePile:PostFixeRec;
 CurrChar:Char;
 TR:Real;

 Procedure PopPile;
 Var
  PPostFixe:PostFixePtr;
 Begin
  PPostFixe:=_ALGetBuf(Q.Pile,Q.Pile.Count-1);
  If(PPostFixe=NIL)Then FillClr(PostFixePile,SizeOf(PostFixePile))
                   Else PostFixePile:=PPostFixe^;
  ALDelBuf(Q.Pile,Q.Pile.Count-1);
 End;

Begin
 FOCompute:=False;
 Paren:=0;
 Q.Formula:=S;
 ALInit(Q.PostFixe);
 ALInit(Q.Pile);
  { D‚composition de la formule }
 Q.PostFixeData.Operateur:=True;
 Q.PostFixeData.Priorite:=-1;
 If Not ALAddBlock(Q.Pile,SizeOf(PostFixeRec),Q.PostFixeData)Then Goto Xit;
 Repeat
  Q.PostFixeData.Operateur:=True;
  CurrChar:=FOStrI(Q);
  If(CurrChar in Q.StopChar)Then Break;
  Case(CurrChar)of
   '(':Begin
    Q.PostFixeData.OperTitle:=FOStrI(Q);
    Inc(Q.I);
    Q.PostFixeData.Priorite:=0;
    If Not ALAddBlock(Q.Pile,SizeOf(PostFixeRec),Q.PostFixeData)Then Goto Xit;
    Inc(Paren);
   End;
   ')':If Paren=0Then Break
    Else
   Begin
    Inc(Q.I);
    Dec(Paren);
    Repeat
     PopPile;
     If PostFixePile.OperTitle='('Then Break;
     If Not ALAddBlock(Q.PostFixe,SizeOf(PostFixeRec),PostFixePile)Then Goto Xit;
    Until Q.Pile.Count=0;
    If(Paren=0)and(FOStrI(Q)in['@'..'Z','a'..'z'])Then Break;
   End;
   '+','-':Begin
    If(Q.PostFixe.Count=0)and(CurrChar='-')Then Goto 2;
    If StrI(Q.I-1,S)in['+','-','*','/']Then Goto 2;
    Q.PostFixeData.OperTitle:=CurrChar;
    Inc(Q.I);Q.PostFixeData.Priorite:=1;
   End;
   '=','<','>','ó','ò':If(foBoolean in Q.Option)Then Begin
    Q.PostFixeData.OperTitle:=FOStrI(Q);
    Inc(Q.I);
    If(Q.PostFixeData.OperTitle='<')Then Begin
     Case FOStrI(Q)of
      '>':Begin
       Q.PostFixeData.OperTitle:='ğ';
       Inc(Q.I);
      End;
      '=':Begin
       Q.PostFixeData.OperTitle:='ó';
       Inc(Q.I);
      End;
     End;
    End
     Else
    If(Q.PostFixeData.OperTitle='>')and(FOStrI(Q)='=')Then Begin
     Q.PostFixeData.OperTitle:='ò';
     Inc(Q.I);
    End;
    Q.PostFixeData.Priorite:=1;
   End
    Else
   Goto 2;
   '*','/':Begin
    Q.PostFixeData.OperTitle:=CurrChar;
    Inc(Q.I);
    Q.PostFixeData.Priorite:=2;
   End;
   '\':If(foIntDiv in Q.Option)Then Begin
    Q.PostFixeData.OperTitle:=FOStrI(Q);
    Inc(Q.I);
    Q.PostFixeData.Priorite:=2;
   End
    Else
   Goto 2;
   '^':If(foExpBasic in Q.Option)Then Begin
    Q.PostFixeData.OperTitle:=FOStrI(Q);
    Inc(Q.I);
    Q.PostFixeData.Priorite:=3;
   End
    Else
   Goto 2;
   '&':If(foNumberBasic in Q.Option)Then Begin
    Inc(Q.I);
    Q.PostFixeData.Operateur:=False;
    Q.PostFixeData.Priorite:=0;
    If Not FOXtrkData(Q,Q.PostFixeData.Valeur,True)Then Goto Xit;
    If Not ALAddBlock(Q.PostFixe,SizeOf(PostFixeRec),Q.PostFixeData)Then Goto Xit;
   End
    Else
   Goto 2;
   '$':If(foHexPascal in Q.Option)Then Goto 2
                                  Else Goto ReadWord;
   '@'..'Z','a'..'z':Begin
ReadWord:
    FOSaveAddr(Q);
    If(@Q.OnWord<>NIL)Then Begin
     If Not(Q.OnWord(Q,FOXtrkWord(Q),Q.Context^))Then Begin
      FORestoreAddr(Q);
      If(Q.StopNow)Then Break;
      Goto 2;
     End;
    End
     Else
    Break;
   End;
   #0:Break;
   Else Begin
  2:Q.PostFixeData.Operateur:=False;
    Q.PostFixeData.Priorite:=0;
    If Not FOXtrkData(Q,Q.PostFixeData.Valeur,False)Then Begin
     If(@Q.OnSymbol<>NIL)Then Begin
      If(Q.OnSymbol(Q,CurrChar,Q.Context^))Then Begin
       If(Q.StopNow)Then Break;
       Goto Continue;
      End;
     End;
     Goto Xit;
    End;
    If Not ALAddBlock(Q.PostFixe,SizeOf(PostFixeRec),Q.PostFixeData)Then Goto Xit;
   End;
  End;
Continue:
  If Q.PostFixeData.Priorite>0Then Begin
 1:PopPile;
   If(PostFixePile.Priorite<Q.PostFixeData.Priorite)Then Begin
    If Not ALAddBlock(Q.Pile,SizeOf(PostFixeRec),PostFixePile)Then Goto Xit;
    If Not ALAddBlock(Q.Pile,SizeOf(PostFixeRec),Q.PostFixeData)Then Goto Xit;
   End
    Else
   Begin
    If Not ALAddBlock(Q.PostFixe,SizeOf(PostFixeRec),PostFixePile)Then Goto Xit;
    Goto 1;
   End;
  End;
 Until False;
 While Q.Pile.Count>1do Begin
  PopPile;
  If Not ALAddBlock(Q.PostFixe,SizeOf(PostFixeRec),PostFixePile)Then Goto Xit;
 End;
 PopPile;
  { valuation du PostFixe }
 ALSetPtr(Q.PostFixe,0);
 For J:=0to Q.PostFixe.Count-1do Begin
  PPostFixe2:=_ALGetCurrBuf(Q.PostFixe);
  If(PPostFixe2=NIL)Then Goto Xit;
  If(PPostFixe2^.Operateur)Then Begin
   If PPostFixe2^.OperTitle<>'!'Then Begin
    PopPile;
    PostFixeB:=PostFixePile;
   End;
   PopPile;
   PostFixeA:=PostFixePile;
   Q.PostFixeData.Valeur.TypeDef:=PostFixeA.Valeur.TypeDef;
   Q.PostFixeData.Operateur:=False;
   Case(PPostFixe2^.OperTitle)of
    '*':Begin
     If(PostFixeA.Valeur.TypeDef=dtLong)and(PostFixeB.Valeur.TypeDef=dtLong)Then Begin
      FOPostFixeLong(Q,PostFixeA.Valeur.X.DataLong*PostFixeB.Valeur.X.DataLong);
     End
      Else
     FOPostFixeReal(Q,VariantToReal(PostFixeA.Valeur)*VariantToReal(PostFixeB.Valeur));
    End;
    '^':Begin
     If(PostFixeA.Valeur.TypeDef=dtLong)and(PostFixeB.Valeur.TypeDef=dtLong)Then Begin
      FOPostFixeReal(Q,IntPower(PostFixeA.Valeur.X.DataLong,PostFixeB.Valeur.X.DataLong));
     End
      Else
     FOPostFixeReal(Q,Power(VariantToReal(PostFixeA.Valeur),VariantToReal(PostFixeB.Valeur)));
    End;
    '/':Begin
     TR:=VariantToReal(PostFixeB.Valeur);
     If TR=0.0Then Q.PostFixeData.Valeur.X.DataReal:=0.0
     Else Q.PostFixeData.Valeur.X.DataReal:=VariantToReal(PostFixeA.Valeur)/TR;
     Q.PostFixeData.Valeur.TypeDef:=dtReal;
    End;
    '\':Begin
     FOPostFixeLong(Q,DivLong(VariantToInt(PostFixeA.Valeur),VariantToInt(PostFixeB.Valeur)));
    End;
    '%':Begin
     FOPostFixeLong(Q,VariantToInt(PostFixeA.Valeur)mod VariantToInt(PostFixeB.Valeur));
    End;
    '+':Begin
     If(PostFixeA.Valeur.TypeDef=dtLong)and(PostFixeB.Valeur.TypeDef=dtLong)Then Begin
      FOPostFixeLong(Q,PostFixeA.Valeur.X.DataLong+PostFixeB.Valeur.X.DataLong);
     End
      Else
     FOPostFixeReal(Q,VariantToReal(PostFixeA.Valeur)+VariantToReal(PostFixeB.Valeur));
    End;
    '-':Begin
     If(PostFixeA.Valeur.TypeDef=dtLong)and(PostFixeB.Valeur.TypeDef=dtLong)Then Begin
      Q.PostFixeData.Valeur.X.DataLong:=PostFixeA.Valeur.X.DataLong-PostFixeB.Valeur.X.DataLong;
     End
      Else
     FOPostFixeReal(Q,VariantToReal(PostFixeA.Valeur)-VariantToReal(PostFixeB.Valeur));
    End;
    'ï':FOPostFixeLong(Q,VariantToInt(PostFixeA.Valeur)and VariantToInt(PostFixeB.Valeur));
    'U':FOPostFixeLong(Q,VariantToInt(PostFixeA.Valeur)or VariantToInt(PostFixeB.Valeur));
    'X':FOPostFixeLong(Q,VariantToInt(PostFixeA.Valeur)xor VariantToInt(PostFixeB.Valeur));
    '®':FOPostFixeLong(Q,VariantToInt(PostFixeA.Valeur)shr VariantToInt(PostFixeB.Valeur));
    '¯':FOPostFixeLong(Q,VariantToInt(PostFixeA.Valeur)shl VariantToInt(PostFixeB.Valeur));
    '=':Begin
     If(PostFixeA.Valeur.TypeDef=dtReal)or(PostFixeB.Valeur.TypeDef=dtReal)Then Begin
      FOPostFixeBoolean(Q,VariantToReal(PostFixeA.Valeur)=VariantToReal(PostFixeB.Valeur));
     End
      Else
     FOPostFixeBoolean(Q,VariantToInt(PostFixeA.Valeur)=VariantToInt(PostFixeB.Valeur));
    End;
    '>':Begin
     If(PostFixeA.Valeur.TypeDef=dtReal)or(PostFixeB.Valeur.TypeDef=dtReal)Then Begin
      FOPostFixeBoolean(Q,VariantToReal(PostFixeA.Valeur)>VariantToReal(PostFixeB.Valeur));
     End
      Else
     FOPostFixeBoolean(Q,VariantToInt(PostFixeA.Valeur)>VariantToInt(PostFixeB.Valeur));
    End;
    '<':Begin
     If(PostFixeA.Valeur.TypeDef=dtReal)or(PostFixeB.Valeur.TypeDef=dtReal)Then Begin
      FOPostFixeBoolean(Q,VariantToReal(PostFixeA.Valeur)<VariantToReal(PostFixeB.Valeur));
     End
      Else
     FOPostFixeBoolean(Q,VariantToInt(PostFixeA.Valeur)<VariantToInt(PostFixeB.Valeur));
    End;
    'ò':Begin
     If(PostFixeA.Valeur.TypeDef=dtReal)or(PostFixeB.Valeur.TypeDef=dtReal)Then Begin
      FOPostFixeBoolean(Q,VariantToReal(PostFixeA.Valeur)>=VariantToReal(PostFixeB.Valeur));
     End
      Else
     FOPostFixeBoolean(Q,VariantToInt(PostFixeA.Valeur)>=VariantToInt(PostFixeB.Valeur));
    End;
    'ó':Begin
     If(PostFixeA.Valeur.TypeDef=dtReal)or(PostFixeB.Valeur.TypeDef=dtReal)Then Begin
      FOPostFixeBoolean(Q,VariantToReal(PostFixeA.Valeur)<=VariantToReal(PostFixeB.Valeur));
     End
      Else
     FOPostFixeBoolean(Q,VariantToInt(PostFixeA.Valeur)<=VariantToInt(PostFixeB.Valeur));
    End;
    'ğ':Begin
     If(PostFixeA.Valeur.TypeDef=dtReal)or(PostFixeB.Valeur.TypeDef=dtReal)Then Begin
      FOPostFixeBoolean(Q,VariantToReal(PostFixeA.Valeur)<>VariantToReal(PostFixeB.Valeur));
     End
      Else
     FOPostFixeBoolean(Q,VariantToInt(PostFixeA.Valeur)<>VariantToInt(PostFixeB.Valeur));
    End;
    '!':Case(PostFixeA.Valeur.TypeDef)of
     dtReal:Q.PostFixeData.Valeur.X.DataReal:=Not Trunc(PostFixeA.Valeur.X.DataReal);
     dtLong:Q.PostFixeData.Valeur.X.DataLong:=Not PostFixeA.Valeur.X.DataLong;
     dtBool:Q.PostFixeData.Valeur.X.DataBool:=Not PostFixeA.Valeur.X.DataBool;
    End;
    Else Goto Xit;
   End;
   If Not ALAddBlock(Q.Pile,SizeOf(PostFixeRec),Q.PostFixeData)Then Goto Xit;
  End
   Else
  Begin
   If Not ALAddBlock(Q.Pile,SizeOf(PostFixeRec),PPostFixe2^)Then Goto Xit;
  End;
  ALNext(Q.PostFixe);
 End;
 If Q.Pile.Count=0Then Goto Xit;
 PopPile;
 If(PostFixePile.Operateur)Then Goto Xit;
 Q.Result:=PostFixePile.Valeur;
 FOCompute:=True;
Xit:
 ALDone(Q.Pile);
 ALDone(Q.PostFixe);
End;

{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                        Interruption Int00h                       Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette interruption est une adaptation de la routine de division par
  d‚faut utilis‚ par l'ensemble Malte Genesis,  plut“t que de terminer
  le programme  lors  d'une  division  par 0,  cette interruption fait
  retourner 0 dans le registre AX  et le programme  continue … moi que
  cette appel n'est  pas ‚t‚ faite pour l'appel  d'une division par 0,
  l…  il  terminera  le  programme  comme   n'importe  quel  programme
  classique.
}

{$IFNDEF Win32}
 Procedure Int00h(Flags,CS,IP,AX,BX,CX,DX,SI,DI,DS,ES,BP:Word);Begin
  If Mem[CS:IP]shr 4=$FThen Begin
   If Mem[CS:IP+1]in[$70..$77]Then Inc(IP)Else
   If Mem[CS:IP+1]in[$36,$3E,$B0..$B7]Then Inc(IP,2);
   Inc(IP,2);AX:=0
  End
   Else
  Halt(200)
 End;
{$ENDIF}

 { Calcul X^N par r‚p‚tition de multiplications }
Function IntPower(X:Real;N:Integer):Real;
Var
 M:Integer;
 T:Real;
Begin
 MathErr:=fnOk;
 If X=0.0Then Begin { 0^0 = lim  x^x = 1 }
  If N=0Then IntPower:=1.0 Else { x -> 0 }
  If N>0Then IntPower:=0.0   { 0^N = 0 }
        Else IntPower:=DefaultVal(fnSing);
  Exit;
 End;
 If N=0Then Begin
  IntPower:=1.0;
  Exit;
 End;
  { Algorithme l‚gendaire permettant de minimiser le nombre de multipliations }
 T:=1.0;
 M:=Abs(N);
 Repeat
  If Odd(M)Then Begin
   Dec(M);
   T:=T*X;
  End
   Else
  Begin
   M:=M shr 1;
   X:=Sqr(X);
  End;
 Until M=0;
 If N>0Then IntPower:=T
       Else IntPower:=1.0/T;
End;

Function IsNumber(Const S:String):Boolean;
Var
 I:Byte;
Begin
 IsNumber:=True;
 For I:=1to Length(S)do Begin
  If Not((S[I]in['0'..'9','.'])or(S[I]=ThSep[0])or(S[I]=DeSep[0]))Then Begin
   IsNumber:=False;
   Exit;
  End;
 End;
End;

Function IsRealNumber(Const S:String):Boolean;
Var
 I:Byte;
Begin
 IsRealNumber:=True;
 For I:=1to Length(S)do Begin
  If Not((S[I]in['0'..'9','.','E','+','-'])or(S[I]=ThSep[0])or(S[I]=DeSep[0]))Then Begin
   IsRealNumber:=False;
   Exit;
  End;
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Fonction MaxByte                           Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction retourne la valeur  de la variable de param‚trage  ®N¯ en
 l'incr‚mentant si elle est plus petit que la variable de param‚tage ®Max¯
 autrement elle retourne 0.
}

Function MaxByte{N,Max:Byte):Byte};Begin
 If(N<Max)Then MaxByte:=N+1
          Else MaxByte:=0
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                             Fonction MinByte                            Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction  retourne la valeur  de la variable de  param‚trage  ®N¯ en
 la d‚cr‚mentant si elle est plus grande que la variable de param‚tage ®Max¯
 autrement elle retourne la variable de param‚trage ®Max¯.
}

Function MinByte{N,Max:Byte):Byte};Begin
 If N>0Then MinByte:=N-1
       Else MinByte:=Max
End;

{ Cette fonction permet de multiplier deux nombres entiers de fa‡on
 … donner un entier long.
}

{$IFDEF __Windows__}
 Function Mul2Word(A,B:Word):LongInt;Assembler;ASM
  {$IFDEF __386__}
   MOVZX EAX,A
   MOVZX EDX,B
   MUL EDX
  {$ELSE}
   MOV AX,A
   MOV DX,B
   MUL DX
  {$ENDIF}
 END;
{$ENDIF}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Fonction MulL                           Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ

 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet d'effectuer une multiplication de deux nombres
 32 bits sans assistance d'un micro-processeur sp‚cifique.
}

{$I \Source\Chantal\Library\MulL.Inc}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Fonction Omega                           Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction retourne le plus grand des 2 nombres entre ®a¯ et ®b¯.


 Remarques
 ÍÍÍÍÍÍÍÍÍ

  ş Dans la plupart des applications modernes, il utilise plut“t le nom
    ®Max¯ pour d‚finir la mˆme op‚ration que cette fonction,  toutefois
    la fonction  ®Max¯  est utilis‚ … d'autre fin  et il n'est donc pas
    possible  d'en  cr‚er une  pour  une compatibilit‚  avec les autres
    programmes.

  ş Sa r‚ciproque est la fonction ®Alpha¯.
}

Function Omega{a,b:LongInt):LongInt};Begin
 If(a>=b)Then Omega:=a
         Else Omega:=b
End;

Function Power(InNumber,Exponent:Real):Real;Begin
 If InNumber>0.0Then Power:=Exp(Exponent*Ln(InNumber))Else
 If InNumber=0.0Then Power:=1.0 Else
  {Nous ne for‡ons pas un ®Runtime Error¯, nous d‚finisons une fonction
   pour les logarithme n‚gatif}
 If Exponent=Trunc(Exponent)Then
  Power:=(-2*(Trunc(Exponent)mod 2)+1)*Exp(Exponent*Ln(-InNumber))
 Else
 Power:=Trunc(1/(Exponent-Exponent));
  { Maintenant nous g‚n‚rons un ®Runtime error¯ }
End;

Procedure RealToDouble(X:Real;Var Y:Double);
Var
 DStruct:DoubleStruct Absolute Y;
 Real48:TPReal Absolute X;
Begin
 DStruct.M4ES:=((Real48.MS and$80)shl 8);
 DStruct.M4ES:=DStruct.M4ES or((Real48.Exponent+894)shl 4);
 DStruct.M4ES:=DStruct.M4ES or((Real48.MS and$7F)shr 3);
 DStruct.Mantissa3:=((Real48.MS and$7F)shl 13)or(Real48.Mantissa2 shr 3);
 DStruct.Mantissa2:=(Real48.Mantissa2 shl 13)or(Real48.Mantissa1 shr 3);
 DStruct.Mantissa1:=Real48.Mantissa1 shl 13;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure QuickSort2                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure effectue un tri des nombres entiers contenu dans deux
 tableaux en fonction d'un remplissage de polyg“ne.
}

Procedure QuickSort2(NumberIndex:Integer;Var X:Array of Integer;Var Y:Array of Integer);
Var
 D,I,J,K,T:Integer;
Begin
 D:=4;
 While(D<=NumberIndex)do D:=D shl 1;
 Dec(D);
 While D>1do Begin
  D:=D shr 1;
  For J:=0to(NumberIndex-D)do Begin
   I:=J;
   While(I>=0)do Begin
    If(Y[I+D]<Y[I])or((Y[I+D]=Y[I])and(X[I+D]<=X[I]))Then Begin
     SwapInt(Y[I],Y[I+D]);
     SwapInt(X[I],X[I+D]);
    End;
    Dec(I,D)
   End;
  End;
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                             Fonction ToBCD                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de convertir un nombre de taille octet en format
 BCD en un format normal.
}

Function ToBcd(Number:Byte):Byte;Begin
 ToBcd:=(Number shr 4)*10+(Number and$F)
End;

Function VariantToReal(Const Q:Variant):Real;Begin
 Case(Q.TypeDef)of
  dtReal:VariantToReal:=Q.X.DataReal;
  dtLong:VariantToReal:=Q.X.DataLong;
  dtInt:VariantToReal:=Q.X.DataInt;
  dtByte,dtBool:VariantToReal:=Q.X.DataByte;
  Else VariantToReal:=0.0;
 End;
End;

Function VariantToInt(Const Q:Variant):LongInt;Begin
 Case(Q.TypeDef)of
  dtReal:VariantToInt:=Trunc(Q.X.DataReal);
  dtLong:VariantToInt:=Q.X.DataLong;
  dtInt:VariantToInt:=Q.X.DataInt;
  dtByte,dtBool:VariantToInt:=Q.X.DataByte;
  Else VariantToInt:=0;
 End;
End;

Function LongMotorolaToIntel(Value:LongInt):LongInt;Assembler;ASM
 {$IFDEF __386__}
  PUSH EAX
  POP DX
  POP AX
  XCHG AX,DX
  XCHG AL,AH
  XCHG DL,DH
 {$ELSE}
  LES AX,Value
  MOV DX,ES
  XCHG AX,DX
  XCHG AL,AH
  XCHG DL,DH
 {$ENDIF}
END;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
END.