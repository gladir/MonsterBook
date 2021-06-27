{\Source\Chantal\Library\HashTable.Inc}

  (************************************************************)
  (*                     Routine du HashCode                  *)
  (************************************************************)

Procedure HTCreateItem(Var Context;Var Item:HashItemPtr);Forward;
Function  HTCurrItemSize(Var Context;Item:HashItemPtr):Word;Forward;
Function  HTFound(Var Context;Item:HashItemPtr):Boolean;Forward;
Function  HTHashValue(Var Context):Word;Forward;
Function  HTItemSize(Var Context):Word;Forward;

Function HTInit(Var Q:HashTable;InitBuckets:BucketRange):Boolean;Begin
 HTInit:=False;
 FillClr(Q,SizeOf(Q));
 Q.CreateItem:=HTCreateItem;
 Q.CurrItemSize:=HTCurrItemSize;
 Q.Found:=HTFound;
 Q.ItemSize:=HTItemSize;
 Q.HashValue:=HTHashValue;
 GetMem(Q.HashData,InitBuckets*SizeOf(HashItemPtr));
 If(Q.HashData=NIL)Then Exit;
 Q.Buckets:=InitBuckets;
 FillClr(Q.HashData^,Q.Buckets*SizeOf(HashItemPtr));
 HTInit:=True;
End;

Procedure HTDone(Var Q:HashTable);Near;
Var
 P,D:HashItemPtr;
 I:Word;
Begin
 For I:=1to(Q.Buckets)do Begin
  P:=Q.HashData^[I];
  While(P<>NIL)do Begin
   D:=P;
   P:=P^.Next;
   FreeMemory(D,Q.CurrItemSize(Q,D)+SizeOf(HashItemPtr));
  End;
 End;
 FreeMemory(Q.HashData,Q.Buckets*SizeOf(HashItemPtr));
End;

Function HTAdd(Var Q:HashTable):Boolean;Near;
Var
 H,A:HashItemPtr;
 V:BucketRange;
Begin
 HTAdd:=False;
 V:=Succ(Q.HashValue(Q{Q.Context})mod Q.Buckets);
 H:=Q.HashData^[V];A:=H;
 While(H<>NIL)do Begin
  H:=H^.Next;
  If(H<>NIL)Then A:=H;
 End;
 If(A=NIL)Then Begin
  GetMem(Q.HashData^[V],Q.ItemSize(Q{Q.Context})+SizeOf(HashItemPtr));
  A:=Q.HashData^[V];
  If(A=NIL)Then Exit;
 End
  else
 Begin
  GetMem(A^.Next,Q.ItemSize(Q{Q.Context})+SizeOf(HashItemPtr));
  If(A^.Next=NIL)Then Exit;
  A:=A^.Next;
 End;
 Q.CreateItem(Q{Q.Context},A);
 A^.Next:=NIL;
 Inc(Q.Items);
 HTAdd:=True;
End;

Function HTDelete(Var Q:HashTable;Deleted:Pointer):Boolean;Near;
Var
 H,D:HashItemPtr;
 V:BucketRange;
Begin
 V:=Succ(Q.HashValue(Q{Q.Context^})mod Q.Buckets);
 H:=Q.HashData^[V];D:=H;
 While(H<>NIL)and(Not(Q.Found(Q{Q.Context^},H)))do Begin
  H:=H^.Next;
  If Not(Q.Found(Q{Q.Context^},H))Then D:=H;
 End;
 If(H=NIL)Then Begin
  If(Deleted<>NIL)Then FillClr(Deleted^,Q.ItemSize(Q{Q.Context^}));
  HTDelete:=False;
  Exit;
 End
  Else
 Begin
  If(H=Q.HashData^[V])Then Q.HashData^[V]:=Q.HashData^[V]^.Next
                      Else D^.Next:=H^.Next;
  If(Deleted<>NIL)Then MoveLeft(H^.Data,Deleted^,Q.ItemSize(Q{Q.Context^}));
  FreeMemory(H,Q.CurrItemSize(Q{Q.Context^},H)+SizeOf(HashItemPtr));
 End;
 Dec(Q.Items);
 HTDelete:=True;
End;

Function HTFirstItem(Var Q:HashTable):HashItemPtr;Near;
Var
 I:Word;
Begin
 For I:=1to(Q.Buckets)do Begin
  Q.CurrBucket:=I;
  Q.CurrItem:=Q.HashData^[I];
  If(Q.CurrItem<>NIL)Then Begin
   HTFirstItem:=Q.CurrItem;
   Exit;
  End;
 End;
 HTFirstItem:=NIL;
End;

Function HTNextItem(Var Q:HashTable):HashItemPtr;Near;Begin
 Q.CurrItem:=Q.CurrItem^.Next;
 If(Q.CurrItem<>NIL)Then Begin
  HTNextItem:=Q.CurrItem;
  Exit;
 End;
 While(Q.CurrBucket<Q.Buckets)do Begin
  Inc(Q.CurrBucket);
  Q.CurrItem:=Q.HashData^[Q.CurrBucket];
  If(Q.CurrItem<>NIL)Then Begin
   HTNextItem:=Q.CurrItem;
   Exit;
  End;
 End;
 HTNextItem:=NIL;
End;

Function HTChange(Var Q:HashTable):Boolean;Near;
Var
 H:HashItemPtr;
Begin
 H:=Q.HashData^[Succ(Q.HashValue(Q{Q.Context^}) mod Q.Buckets)];
 While(H<>NIL)and(Not(Q.Found(Q{Q.Context^},H)))do H:=H^.Next;
 If(H<>NIL)Then Begin;
  Q.CreateItem(Q{Q.Context^},H);
  HTChange:=True;
 End
  Else
 HTChange:=HTAdd(Q);
End;

Function HTSearch(Var Q:HashTable):HashItemPtr;Near;
Var
 H:HashItemPtr;
Begin
 H:=Q.HashData^[Succ(Q.HashValue(Q{Q.Context^})mod Q.Buckets)];
 While(H<>NIL)and(Not(Q.Found(Q{Q.Context^},H)))do H:=H^.Next;
 HTSearch:=H;
End;

{Function HTHashValue(Var Context):Word;Begin
 HTHashValue:=1;
End;}
Function HTHashValue(Var Context):Word;Assembler;ASM
 MOV AX,1
END;

{Function HTFound(Var Context;Item:HashItemPtr):Boolean;Begin
 HTFound:=False;
End;}
Function HTFound(Var Context;Item:HashItemPtr):Boolean;Assembler;ASM
 MOV AL,False
END;

Procedure HTCreateItem(Var Context;Var Item:HashItemPtr);Begin
End;

{Function HTItemSize(Var Context):Word;
Var
 Q:HashTable Absolute Context;
Begin
 HTItemSize:=Q.DefaultItemSize;
End;}
Function HTItemSize(Var Context):Word;Assembler;ASM
 LES DI,Context
 MOV AX,ES:[DI].HashTable.DefaultItemSize;
END;

Function HTCurrItemSize(Var Context;Item:HashItemPtr):Word;
Var
 Q:HashTable Absolute Context;
Begin
 HTCurrItemSize:=Q.ItemSize(Q{Q.Context^});
End;