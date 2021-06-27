{\Source\Chantal\Library\App\Tableur\Cellule.Inc}

Procedure CECreateItem(Var Context;Var Item:HashItemPtr);Forward;
Function  CECurrItemSize(Var Context;Item:HashItemPtr):Word;Forward;
Function  CEFound(Var Context;Item:HashItemPtr):Boolean;Forward;
Function  CEHashValue(Var Context):Word;Forward;
Function  CEItemSize(Var Context):Word;Forward;

Function CEInit(Var Q:CelluleObject):Boolean;Begin
 FillClr(Q,SizeOf(Q));
 CEInit:=HTInit(Q.List,256);
 Q.List.Context:=@Q;
 Q.List.CreateItem:=CECreateItem;
 Q.List.CurrItemSize:=CECurrItemSize;
 Q.List.Found:=CEFound;
 Q.List.HashValue:=CEHashValue;
 Q.List.ItemSize:=CEItemSize;
End;

Procedure CEDone(Var Q:CelluleObject);Near;Begin
 HTDone(Q.List);
End;

{Function CEAdd(Var Q:CelluleObject):Boolean;Begin
 CEAdd:=HTAdd(Q.List);
End;}
Function CEAdd(Var Q:CelluleObject):Boolean;Assembler;ASM
 LES DI,Q
 ADD DI,Offset CelluleObject.List
 PUSH ES
 PUSH DI
 CALL HTAdd
END;

Function CEAddEmpty(Var Q:CelluleObject;Column,Row:LongInt):Boolean;Begin
 If Not CEDelete(Q,Column,Row)Then Begin
  FillClr(Q.Curr,SizeOf(Q.Curr));
  Q.Curr.Column:=Column;
  Q.Curr.Row:=Row;
  Q.Curr.Header.Attribut:=CurrKrs.Dialog.Env.List.Border;
 End;
 Q.Curr.Header.Format:=cfEmpty;
 Q.Curr.Header.Justify:=cLeft;
 CEAddEmpty:=CEAdd(Q);
End;

Function CEAddRealValue(Var Q:CelluleObject;Column,Row:LongInt;Value:Real):Boolean;Begin
 If Not CEDelete(Q,Column,Row)Then Begin
  FillClr(Q.Curr,SizeOf(Q.Curr));
  Q.Curr.Data.v.Dec:=4;
  Q.Curr.Column:=Column;
  Q.Curr.Row:=Row;
  Q.Curr.Header.Attribut:=CurrKrs.Dialog.Env.List.Border;
 End;
 Q.Curr.Header.Format:=cfValue;
 Q.Curr.Header.Justify:=cRight;
 Q.Curr.Data.v.Value:=Value;
 CEAddRealValue:=CEAdd(Q);
End;

Function CEAddIntegerValue(Var Q:CelluleObject;Column,Row:LongInt;Value:LongInt):Boolean;Begin
 If Not CEDelete(Q,Column,Row)Then Begin
  FillClr(Q.Curr,SizeOf(Q.Curr));
  Q.Curr.Column:=Column;
  Q.Curr.Row:=Row;
  Q.Curr.Header.Attribut:=CurrKrs.Dialog.Env.List.Border;
 End;
 Q.Curr.Header.Format:=cfValue;
 Q.Curr.Header.Justify:=cRight;
 Q.Curr.Data.v.Value:=Value;
 CEAddIntegerValue:=CEAdd(Q);
End;

Function CEAddText(Var Q:CelluleObject;Column,Row:LongInt;Const S:String):Boolean;Begin
 If Not CEDelete(Q,Column,Row)Then Begin
  FillClr(Q.Curr,SizeOf(Q.Curr));
  Q.Curr.Column:=Column;
  Q.Curr.Row:=Row;
  Q.Curr.Header.Attribut:=CurrKrs.Dialog.Env.List.Border;
 End;
 Q.Curr.Header.Format:=cfText;
 Q.Curr.Header.Justify:=cLeft;
 Q.Curr.Data.t.Text:=S;
 CEAddText:=CEAdd(Q);
End;

Function CEAddFormula(Var Q:CelluleObject;Column,Row:LongInt;Const S:String):Boolean;Begin
 If Not CEDelete(Q,Column,Row)Then Begin
  FillClr(Q.Curr,SizeOf(Q.Curr));
  Q.Curr.Data.f.Dec:=4;
  Q.Curr.Column:=Column;
  Q.Curr.Row:=Row;
  Q.Curr.Header.Attribut:=CurrKrs.Dialog.Env.List.Border;
 End;
 Q.Curr.Header.Format:=cfFormula;
 Q.Curr.Header.Justify:=cRight;
 Q.Curr.Data.f.Formula:=S;
 Q.Curr.Data.f.Compute:=False;
 CEAddFormula:=CEAdd(Q);
End;

Function CEDelete(Var Q:CelluleObject;Column,Row:LongInt):Boolean;Begin
 Q.Curr.Column:=Column;
 Q.Curr.Row:=Row;
 CEDelete:=HTDelete(Q.List,@Q.Curr);
End;

Function CESearch(Var Q:CelluleObject;Column,Row:LongInt):PCellule;Near;
Var
 I:HashItemPtr;
Begin
 Q.Curr.Column:=Column;
 Q.Curr.Row:=Row;
 I:=HTSearch(Q.List);
 If(I=NIL)Then CESearch:=NIL
          Else CESearch:=@I^.Data;
End;

Function CEHashValue(Var Context):Word;
Var
 Q:CelluleObject Absolute Context;
Begin
 CEHashValue:=Q.Curr.Column+Q.Curr.Row;
End;

Function CEFound(Var Context;Item:HashItemPtr):Boolean;
Var
 Q:CelluleObject Absolute Context;
Begin
 CEFound:=Compare(Item^.Data,Q.Curr,SizeOf(LongInt)*2);
End;

Procedure CECreateItem(Var Context;Var Item:HashItemPtr);
Var
 Q:CelluleObject Absolute Context;
Begin
 MoveLeft(Q.Curr,Item^.Data,CEItemSize(Q));
End;

Function CECurrItemSize(Var Context;Item:HashItemPtr):Word;
Var
 Q:CelluleObject Absolute Context;
 P:PCellule;
Begin
 P:=@Item^.Data;
 Case(P^.Header.Format)of
  cfValue:CECurrItemSize:=SizeOf(LongInt)*2+SizeOf(CelluleHeader)+SizeOf(CelluleValue);
  cfText:CECurrItemSize:=SizeOf(LongInt)*2+SizeOf(CelluleHeader)+Length(P^.Data.t.Text)+1;
  cfFormula:CECurrItemSize:=SizeOf(LongInt)*2+SizeOf(CelluleHeader)+
                        SizeOf(CelluleFormula)-SizeOf(String)+Length(P^.Data.f.Formula)+1;
  cfEmpty:CECurrItemSize:=SizeOf(LongInt)*2+SizeOf(CelluleHeader);
  Else CECurrItemSize:=SizeOf(CelluleRec);
 End;
End;

Function CEItemSize(Var Context):Word;
Var
 Q:CelluleObject Absolute Context;
Begin
 Case(Q.Curr.Header.Format)of
  cfValue:CEItemSize:=SizeOf(LongInt)*2+SizeOf(CelluleHeader)+SizeOf(CelluleValue);
  cfText:CEItemSize:=SizeOf(LongInt)*2+SizeOf(CelluleHeader)+Length(Q.Curr.Data.t.Text)+1;
  cfFormula:CEItemSize:=SizeOf(LongInt)*2+SizeOf(CelluleHeader)+
                        SizeOf(CelluleFormula)-SizeOf(String)+Length(Q.Curr.Data.f.Formula)+1;
  cfEmpty:CEItemSize:=SizeOf(LongInt)*2+SizeOf(CelluleHeader);
  Else CEItemSize:=SizeOf(CelluleRec);
 End;
End;

Function CENumLine(Var Q:CelluleObject):LongInt;Near;
Var
 I:HashItemPtr;
 C:PCellule;
Begin
 Q.X1:=$7FFFFFFF;Q.X2:=0;
 Q.Y1:=$7FFFFFFF;Q.Y2:=0;
 I:=HTFirstItem(Q.List);
 While(I<>NIL)do Begin
  C:=@I^.Data;
  If(C^.Row<Q.Y1)Then Q.Y1:=C^.Row;
  If(C^.Row>Q.Y2)Then Q.Y2:=C^.Row;
  I:=HTNextItem(Q.List);
 End;
 CENumLine:=Q.Y2-Q.Y1+1;
End;

Function CEFindLine(Var Q:CelluleObject;YP:LongInt):PCellule;Near;
Var
 I:HashItemPtr;
 C:PCellule;
Begin
 Q.X1:=$7FFFFFFF;Q.X2:=0;
 Q.Y1:=YP;Q.Y2:=YP;
 I:=HTFirstItem(Q.List);
 While(I<>NIL)do Begin
  C:=@I^.Data;
  If(C^.Row=YP)Then Begin
   If(C^.Column<Q.X1)Then Q.X1:=C^.Column;
   If(C^.Column>Q.X2)Then Q.X2:=C^.Column;
  End;
  I:=HTNextItem(Q.List);
 End;
 CEFindLine:=CESearch(Q,Q.X1,YP);
 If Q.X1>=0Then Inc(Q.X1);
End;

Function CEFirstItem(Var Q:CelluleObject):PCellule;Near;
Var
 I:HashItemPtr;
Begin
 Q.X1:=$FFFFFFFF;
 I:=HTFirstItem(Q.List);
 If(I=NIL)Then CEFirstItem:=NIL
          Else CEFirstItem:=@I^.Data;
End;

Function CENextItem(Var Q:CelluleObject):PCellule;Near;
Var
 I:HashItemPtr;
Begin
 If Q.X1<0Then Begin
  I:=HTNextItem(Q.List);
  If(I=NIL)Then CENextItem:=NIL
           Else CENextItem:=@I^.Data;
 End
  Else
 Begin
  If(Q.X1>Q.X2)Then CENextItem:=NIL
   Else
  Begin
   CENextItem:=CESearch(Q,Q.X1,Q.Y1);
   Inc(Q.X1);
  End;
 End;
End;

Procedure CEInsertColumn(Var Q:CelluleObject;Column:LongInt);Near;
Var
 New:CelluleObject;
 P:PCellule;
Begin
 CEInit(New);
 P:=CEFirstItem(Q);
 While(P<>NIL)do Begin
  New.Curr:=P^;
  If(New.Curr.Column>=Column)Then Inc(New.Curr.Column);
  CEAdd(New);
  CEDelete(Q,P^.Column,P^.Row);
  P:=CEFirstItem(Q);
 End;
 CEDone(Q);
 Q:=New;
End;

Procedure CEInsertRow(Var Q:CelluleObject;Row:LongInt);Near;
Var
 New:CelluleObject;
 P:PCellule;
Begin
 CEInit(New);
 P:=CEFirstItem(Q);
 While(P<>NIL)do Begin
  New.Curr:=P^;
  If(New.Curr.Row>=Row)Then Inc(New.Curr.Row);
  CEAdd(New);
  CEDelete(Q,P^.Column,P^.Row);
  P:=CEFirstItem(Q);
 End;
 CEDone(Q);
 Q:=New;
End;

Procedure CEDeleteColumn(Var Q:CelluleObject;Column:LongInt);Near;
Var
 New:CelluleObject;
 P:PCellule;
Begin
 CEInit(New);
 P:=CEFirstItem(Q);
 While(P<>NIL)do Begin
  New.Curr:=P^;
  If(New.Curr.Column>=Column)Then Dec(New.Curr.Column);
  If(P^.Column<>Column)Then CEAdd(New);
  CEDelete(Q,P^.Column,P^.Row);
  P:=CEFirstItem(Q);
 End;
 CEDone(Q);
 Q:=New;
End;

Procedure CEDeleteRow(Var Q:CelluleObject;Row:LongInt);Near;
Var
 New:CelluleObject;
 P:PCellule;
Begin
 CEInit(New);
 P:=CEFirstItem(Q);
 While(P<>NIL)do Begin
  New.Curr:=P^;
  If(New.Curr.Row>=Row)Then Dec(New.Curr.Row);
  If(P^.Row<>Row)Then CEAdd(New);
  CEDelete(Q,P^.Column,P^.Row);
  P:=CEFirstItem(Q);
 End;
 CEDone(Q);
 Q:=New;
End;
