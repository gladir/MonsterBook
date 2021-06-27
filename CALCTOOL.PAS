Unit CalcTool;

INTERFACE

Uses Isatex;

Function  SCGotoPhysicalCellule(Var Q:SuperCalcApp;X,Y:Byte):Byte;
Procedure SCProprieteCellule(Var Q:SuperCalcApp);
Procedure SCTriAscendant(Var Q:SuperCalcApp);
Procedure SCTriDescendant(Var Q:SuperCalcApp);

IMPLEMENTATION

Uses Systems,Dialex,Dials,DialPlus,Numerix,MalCalc;

Function SCGotoPhysicalCellule(Var Q:SuperCalcApp;X,Y:Byte):Byte;
Var
 XC,YC:Integer;
 PX,PY:LongInt;
 I:Byte;
Begin
 SCGotoPhysicalCellule:=0;
 If WEInWindow(Q.W,X,Y)Then Begin
  XC:=X-WEGetRX1(Q.W);
  YC:=Y-WEGetRY1(Q.W)-(Q.HomeLine+1+Byte(Q.Mode=3));
  If(XC>=10)and(YC>=0)Then Begin
   PX:=Q.PX-Q.XL;
   PY:=Q.PY;
   I:=0;
   Repeat
    If(Q.ColumnX[I]<=XC)and(Q.ColumnX[I+1]>XC)Then Break;
    Inc(I);
   Until Q.ColumnX[I+1]>Q.W.MaxX;
   Inc(PX,I);
   Dec(PY,Q.YS);
   Inc(PY,YC);
   If(Q.PX<>PX)or(Q.PY<>PY)Then Begin
    SCPutUnSelect(Q);
    Q.PX:=PX;
    Q.PY:=PY;
    Q.XL:=I;
    Q.YS:=YC;
    SCPutSelect(Q);
    SCGotoPhysicalCellule:=1;
   End
    Else
   SCGotoPhysicalCellule:=2;
  End;
 End;
End;

Procedure SCProprieteCellule(Var Q:SuperCalcApp);
Var
 FormProprieteCellule:Record
  TypeCellule:MRadioButton;
  Justify:MRadioButton;
  TabbedNumber:Boolean;
  NumDec:Byte;
  Transparent:MCheckBox;
  Inverse:MCheckBox;
  Background:MColorGrid16;
  Foreground:MColorGrid16;
  Key:Byte;
 End;
 PC:PCellule;
Begin
 FillClr(FormProprieteCellule,SizeOf(FormProprieteCellule));
 PC:=SCGetCurrCellule(Q);
 If(PC<>NIL)Then Begin
  FormProprieteCellule.TabbedNumber:=PC^.Header.Format in[cfValue,cfFormula];
  If(FormProprieteCellule.TabbedNumber)Then Begin
   If(PC^.Header.Format=cfValue)Then FormProprieteCellule.NumDec:=PC^.Data.v.Dec
                                Else FormProprieteCellule.NumDec:=PC^.Data.f.Dec;
  End;
  FormProprieteCellule.TypeCellule.Alignment:=PC^.Header.Format;
  FormProprieteCellule.Justify.Alignment:=Byte(PC^.Header.Justify);
  FormProprieteCellule.Background.Color:=PC^.Header.Attribut shr 4;
  FormProprieteCellule.Foreground.Color:=PC^.Header.Attribut and$F;
 End;
 FormProprieteCellule.Transparent.Checked:=True;
 If ExecuteAppDPU(104,FormProprieteCellule)Then Begin
  If(PC^.Header.Format<>FormProprieteCellule.TypeCellule.Alignment)Then Begin
   Case(FormProprieteCellule.TypeCellule.Alignment)of
    cfEmpty:CEAddEmpty(Q.Cellule,Q.PX,Q.PY);
    cfValue:Case(PC^.Header.Format)of
     cfText:CEAddRealValue(Q.Cellule,Q.PX,Q.PY,StrToReal(PC^.Data.t.Text));
     Else CEAddRealValue(Q.Cellule,Q.PX,Q.PY,0.0);
    End;
    cfText:Case(PC^.Header.Format)of
     cfValue:CEAddText(Q.Cellule,Q.PX,Q.PY,RealStr(PC^.Data.v.Value));
     cfFormula:CEAddText(Q.Cellule,Q.PX,Q.PY,PC^.Data.f.Formula);
     Else CEAddText(Q.Cellule,Q.PX,Q.PY,'');
    End;
    cfFormula:Case(PC^.Header.Format)of
     cfText:CEAddFormula(Q.Cellule,Q.PX,Q.PY,PC^.Data.t.Text);
     cfValue:CEAddFormula(Q.Cellule,Q.PX,Q.PY,RealStr(PC^.Data.v.Value));
     Else CEAddFormula(Q.Cellule,Q.PX,Q.PY,'');
    End;
   End;
   SCPutData(Q,Q.XL,Q.YS,Q.PX,Q.PY,False);
   PC:=SCGetCurrCellule(Q);
  End;
  If(PC=NIL)Then Begin
   SCPushData(Q,'');
   PC:=SCGetCurrCellule(Q);
   If(PC=NIL)Then Begin
    __OutOfMemory;
    Exit;
   End;
  End;
  If(PC^.Header.Format=cfValue)Then Begin
   If(PC^.Data.v.Dec<>FormProprieteCellule.NumDec)Then Begin
    PC^.Data.v.Dec:=FormProprieteCellule.NumDec;
    SCPutData(Q,Q.XL,Q.YS,Q.PX,Q.PY,False);
   End;
  End;
  If(PC^.Header.Format=cfFormula)Then Begin
   If(PC^.Data.f.Dec<>FormProprieteCellule.NumDec)Then Begin
    PC^.Data.f.Dec:=FormProprieteCellule.NumDec;
    SCPutData(Q,Q.XL,Q.YS,Q.PX,Q.PY,False);
   End;
  End;
  Byte(PC^.Header.Justify):=FormProprieteCellule.Justify.Alignment;
  If(FormProprieteCellule.Inverse.Checked)Then Begin
   PC^.Header.Attribut:=FormProprieteCellule.Background.Color and$F;
   PC^.Header.Attribut:=PC^.Header.Attribut or(FormProprieteCellule.Foreground.Color shl 4);
  End
   Else
  Begin
   PC^.Header.Attribut:=FormProprieteCellule.Background.Color shl 4;
   PC^.Header.Attribut:=PC^.Header.Attribut or(FormProprieteCellule.Foreground.Color and$F);
  End;
 End;
End;

Function SCCompSup(Var Q:SuperCalcApp;X1,Y1,X2,Y2:LongInt):Boolean;Near;
Var
 PC1,PC2:PCellule;   { Pointeur sur une cellule }
 V1,V2:Real;
 V1Set,V2Set:Boolean;
 S1,S2:String;
Begin
 PC1:=SCGetCellule(Q,X1,Y1);
 PC2:=SCGetCellule(Q,X2,Y2);
 S1:='';
 V1Set:=False;
 V2Set:=False;
 If(PC1<>NIL)Then Begin
  Case(PC1^.Header.Format)of
   cfFormula:Begin
    S1:=RealStr2(PC1^.Data.f.Value,4,PC1^.Data.v.Dec);
    V1:=PC1^.Data.v.Value;
    V1Set:=True;
   End;
   cfValue:Begin
    S1:=RealStr2(PC1^.Data.v.Value,4,PC1^.Data.v.Dec);
    V1:=PC1^.Data.v.Value;
    V1Set:=True;
   End;
   cfText:S1:=PC1^.Data.t.Text;
  End;
 End;
 S2:='';
 If(PC2<>NIL)Then Begin
  Case(PC2^.Header.Format)of
   cfFormula:Begin
    S2:=RealStr2(PC2^.Data.f.Value,4,PC2^.Data.v.Dec);
    V2:=PC2^.Data.v.Value;
    V2Set:=True;
   End;
   cfValue:Begin
    S2:=RealStr2(PC2^.Data.v.Value,4,PC2^.Data.v.Dec);
    V2:=PC2^.Data.v.Value;
    V2Set:=True;
   End;
   cfText:S2:=PC1^.Data.t.Text;
  End;
 End;
 If(V1Set and V2Set)Then SCCompSup:=V1>V2
                    Else SCCompSup:=S1>S2;
End;

Procedure SCSwapCellule(Var Q:SuperCalcApp;X1,Y1,X2,Y2:LongInt);Near;
Var
 PC1,PC2:PCellule;   { Pointeur sur une cellule }
 TCell:Array[0..1]of CelluleRec;
Begin
 PC1:=SCGetCellule(Q,X1,Y1);
 PC2:=SCGetCellule(Q,X2,Y2);
 FillClr(TCell,SizeOf(TCell));
 If(PC1<>NIL)and(PC2<>NIL)Then Begin
  MoveLeft(PC1^,TCell[0],SizeOf(TCell[0]));
  MoveLeft(PC2^,TCell[1],SizeOf(TCell[1]));
  SwapLong(TCell[0].Column,TCell[1].Column);
  SwapLong(TCell[0].Row,TCell[1].Row);
 End
  Else
 If(PC1<>NIL)Then Begin
  MoveLeft(PC1^,TCell[0],SizeOf(TCell[0]));
  TCell[0].Column:=X2;
  TCell[0].Row:=Y2;
 End
  Else
 Begin
  MoveLeft(PC2^,TCell[1],SizeOf(TCell[1]));
  TCell[1].Column:=X1;
  TCell[1].Row:=Y1;
 End;
 CEDelete(Q.Cellule,X1,Y1);
 CEDelete(Q.Cellule,X2,Y2);
 Q.Cellule.Curr:=TCell[0];
 If(PC1<>NIL)Then CEAdd(Q.Cellule);
 Q.Cellule.Curr:=TCell[1];
 If(PC2<>NIL)Then CEAdd(Q.Cellule);
End;

Procedure SCTriAscendant(Var Q:SuperCalcApp);
Var
 Ecart,M,I,J,K:LongInt;
 NumLine:LongInt;
 IL:LongInt;
 Inversion:Boolean;
Begin
 NumLine:=Q.BY2-Q.BY1;
 Ecart:=NumLine;
 Repeat
  Ecart:=Ecart shr 1;
  J:=0;K:=NumLine-Ecart;
  Repeat
   I:=J;
   Repeat
    If SCCompSup(Q,Q.BX1,Q.BY1+I,Q.BX1,Q.BY1+I+Ecart)Then Begin
     For IL:=Q.BX1 to(Q.BX2)do Begin
      SCSwapCellule(Q,IL,Q.BY1+I,IL,Q.BY1+I+Ecart);
     End;
     Dec(I,Ecart);
    End
     Else
    Break;
   Until I<1;
   Inc(J);
  Until J>K;
 Until Ecart=1;
 SCRefreshSpreadSheet(Q);
End;

Procedure SCTriDescendant(Var Q:SuperCalcApp);
Var
 Ecart,M,I,J,K:LongInt;
 NumLine:LongInt;
 IL:LongInt;
 Inversion:Boolean;
Begin
 NumLine:=Q.BY2-Q.BY1;
 Ecart:=NumLine;
 Repeat
  Ecart:=Ecart shr 1;
  J:=0;K:=NumLine-Ecart;
  Repeat
   I:=J;
   Repeat
    If Not SCCompSup(Q,Q.BX1,Q.BY1+I,Q.BX1,Q.BY1+I+Ecart)Then Begin
     For IL:=Q.BX1 to(Q.BX2)do Begin
      SCSwapCellule(Q,IL,Q.BY1+I,IL,Q.BY1+I+Ecart);
     End;
     Dec(I,Ecart);
    End
     Else
    Break;
   Until I<1;
   Inc(J);
  Until J>K;
 Until Ecart=1;
 SCRefreshSpreadSheet(Q);
End;

END.