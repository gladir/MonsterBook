{\Source\Chantal\Library\App\Tableur\Column.Inc}

{Function COHashValue(Var Context):Word;
Var
 Q:ColumnObject Absolute Context;
Begin
 COHashValue:=Q.Curr.Column;
End;}
Function COHashValue(Var Context):Word;Assembler;ASM
 LES DI,Context
 MOV AX,Word Ptr ES:[DI].ColumnObject.Curr.Column
END;

Function COFound(Var Context;Item:HashItemPtr):Boolean;
Type
 ColumnHashItem=Record
  Next:HashItemPtr;
  Data:ColumnRec;
 End;
Var
 Q:ColumnObject Absolute Context;
 C:^ColumnHashItem Absolute Item;
Begin
 COFound:=Q.Curr.Column=C^.Data.Column;
End;

Procedure COCreateItem(Var Context;Var Item:HashItemPtr);
Var
 Q:ColumnObject Absolute Context;
Begin
 MoveLeft(Q.Curr,Item^.Data,SizeOf(ColumnRec));
End;

{Function COItemSize(Var Context):Word;Begin
 COItemSize:=SizeOf(ColumnRec)
End;}
Function COItemSize(Var Context):Word;Assembler;ASM
 MOV AX,TYPE ColumnRec
END;

Procedure COInit(Var Q:ColumnObject);Begin
 FillClr(Q,SizeOf(Q));
 Q.List.Context:=@Q;
 HTInit(Q.List,64);
 Q.List.CreateItem:=COCreateItem;
 Q.List.Found:=COFound;
 Q.List.HashValue:=COHashValue;
 Q.List.ItemSize:=COItemSize;
End;

{Function COAdd(Var Q:ColumnObject):Boolean;Near;Begin
 COAdd:=HTAdd(Q.List);
End;}
Function COAdd(Var Q:ColumnObject):Boolean;Assembler;ASM
 LES DI,Q
 ADD DI,ColumnObject.List
 PUSH ES
 PUSH DI
 CALL HTAdd
END;

Procedure CODelete(Var Q:ColumnObject;Column:LongInt);Near;Begin
 Q.Curr.Column:=Column;
 HTDelete(Q.List,NIL);
End;

Function COGetColumn(Var Q:ColumnObject;Column:LongInt):PColumn;Near;
Var
 I:HashItemPtr;
 W:Byte;
Begin
 Q.Curr.Column:=Column;
 I:=HTSearch(Q.List);
 If(I=NIL)Then COGetColumn:=NIL
          Else COGetColumn:=@I^.Data;
End;

Function COGetColumnWidth(Var Q:ColumnObject;Column:LongInt):Word;Near;
Var
 PC:PColumn;
Begin
 PC:=COGetColumn(Q,Column);
 If(PC=NIL)Then COGetColumnWidth:=10
           Else COGetColumnWidth:=PC^.c.Length;
End;

Function COSearch(Var Q:ColumnObject;Column:LongInt):Boolean;Near;
Var
 I:HashItemPtr;
 W:Byte;
Begin
 Q.Curr.Column:=Column;
 I:=HTSearch(Q.List);
 If(I=NIL)Then Begin
  COSearch:=False;
  FillClr(Q.Curr,SizeOf(ColumnRec));
  Q.Curr.c.Length:=10;
  Q.Curr.Column:=Column;
 End
  Else
 Begin
  MoveLeft(I^.Data,Q.Curr,SizeOf(ColumnRec));
  COSearch:=True;
 End;
End;

Function COUpdate(Var Q:ColumnObject):Boolean;Near;
Var
 I:HashItemPtr;
 W:Byte;
Begin
 I:=HTSearch(Q.List);
 If(I=NIL)Then COUpdate:=False
  Else
 Begin
  MoveLeft(Q.Curr,I^.Data,SizeOf(ColumnRec));
  COUpdate:=True;
 End;
End;

Function COFirstItem(Var Q:ColumnObject):PColumn;Near;
Var
 I:HashItemPtr;
Begin
 I:=HTFirstItem(Q.List);
 If(I=NIL)Then COFirstItem:=NIL
          Else COFirstItem:=@I^.Data;
End;

Function CONextItem(Var Q:CelluleObject):PColumn;Near;
Var
 I:HashItemPtr;
Begin
 I:=HTNextItem(Q.List);
 If(I=NIL)Then CONextItem:=NIL
          Else CONextItem:=@I^.Data;
End;

Procedure CODone(Var Q:ColumnObject);Near;Begin
 HTDone(Q.List);
End;

Procedure COInsertColumn(Var Q:ColumnObject;Column:LongInt);Near;
Var
 New:ColumnObject;
 P:PColumn;
Begin
 COInit(New);
 P:=COFirstItem(Q);
 While(P<>NIL)do Begin
  New.Curr:=P^;
  If(New.Curr.Column>=Column)Then Inc(New.Curr.Column);
  COAdd(New);
  CODelete(Q,P^.Column);
  P:=COFirstItem(Q);
 End;
 CODone(Q);
 Q:=New;
End;

Procedure CODeleteColumn(Var Q:ColumnObject;Column:LongInt);Near;
Var
 New:ColumnObject;
 P:PColumn;
Begin
 COInit(New);
 P:=COFirstItem(Q);
 While(P<>NIL)do Begin
  New.Curr:=P^;
  If(New.Curr.Column>=Column)Then Dec(New.Curr.Column);
  If(P^.Column<>Column)Then COAdd(New);
  CODelete(Q,P^.Column);
  P:=COFirstItem(Q);
 End;
 CODone(Q);
 Q:=New;
End;
