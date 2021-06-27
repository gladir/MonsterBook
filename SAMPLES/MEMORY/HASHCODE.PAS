Uses Systex,Systems,Isatex;

Procedure HTCreateItem(Var Context;Var Item:HashItemPtr);Forward;
Function  HTCurrItemSize(Var Context;Item:HashItemPtr):HashItemSizeRange;Forward;
Function  HTFound(Var Context;Item:HashItemPtr):Boolean;Forward;
Function  HTHashValue(Var Context):LongInt;Forward;
Function  HTItemSize(Var Context):HashItemSizeRange;Forward;

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
 Q.Items:=0;
 HTInit:=True;
End;

Procedure HTDone(Var Q:HashTable);
Var
 P,D:HashItemPtr;
 I:Word;
Begin
 For I:=1to(Q.Buckets)do Begin
  P:=Q.HashData^[I];
  While(P<>NIL)do Begin
   D:=P;
   P:=P^.Next;
   FreeMem(D,Q.CurrItemSize(Q,D)+SizeOf(HashItemPtr));
  End;
 End;
 FreeMem(Q.HashData,Q.Buckets*SizeOf(HashItemPtr));
End;

Function HTAdd(Var Q:HashTable):Boolean;
Var
 H,A:HashItemPtr;
 V:BucketRange;
Begin
 HTAdd:=False;
 V:=Succ(Q.HashValue(Q)mod Q.Buckets);
 H:=Q.HashData^[V];A:=H;
 While(H<>NIL)do Begin
  H:=H^.Next;
  If(H<>NIL)Then A:=H;
 End;
 If(A=NIL)Then Begin
  GetMem(Q.HashData^[V],Q.ItemSize(Q)+SizeOf(HashItemPtr));
  A:=Q.HashData^[V];
  If(A=NIL)Then Exit;
 End
  else
 Begin
  GetMem(A^.Next,Q.ItemSize(Q)+SizeOf(HashItemPtr));
  If(A^.Next=Nil)Then Exit;
  A:=A^.Next;
 End;
 HTCreateItem(Q,A);
 A^.Next:=NIL;
 Inc(Q.Items);
 HTAdd:=True;
End;

Procedure HTDelete(Var Q:HashTable;Deleted:Pointer);
Var
 H,D:HashItemPtr;
 V:BucketRange;
Begin
 V:=Succ(Q.HashValue(Q)mod Q.Buckets);
 H:=Q.HashData^[V];D:=H;
 While(H<>NIL)and(Not(Q.Found(Q,H)))do Begin
  H:=H^.Next;
  If Not(Q.Found(Q,H))Then D:=H;
 End;
 If(H=Nil)Then Begin
  If(Deleted<>NIL)Then FillClr(Deleted^,Q.ItemSize(Q));
  Exit;
 End
  else
 Begin
  If(H=Q.HashData^[V])Then Q.HashData^[V]:=Q.HashData^[V]^.Next
                      Else D^.Next:=H^.Next;
  If(Deleted<>NIL)Then MoveLeft(H^.Data,Deleted^,Q.ItemSize(Q));
  FreeMem(H,Q.CurrItemSize(Q,H)+SizeOf(HashItemPtr));
 End;
 Dec(Q.Items);
End;

Function HTFirstItem(Var Q:HashTable):HashItemPtr;
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

Function HTNextItem(Var Q:HashTable):HashItemPtr;Begin
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

Function HTChange(Var Q:HashTable):Boolean;
Var
 H:HashItemPtr;
Begin
 H:=Q.HashData^[Succ(Q.HashValue(Q) mod Q.Buckets)];
 While(H<>NIL)and(Not(Q.Found(Q,H)))do H:=H^.Next;
 If(H<>NIL)Then Begin;
  HTCreateItem(Q,H);
  HTChange:=True;
 End
  Else
 HTChange:=HTAdd(Q);
End;

Function HTSearch(Var Q:HashTable):HashItemPtr;
Var
 H:HashItemPtr;
Begin
 H:=Q.HashData^[Succ(Q.HashValue(Q) mod Q.Buckets)];
 While(H<>NIL)and(Not(Q.Found(Q,H)))do H:=H^.Next;
 HTSearch:=H;
End;

Function HTHashValue(Var Context):LongInt;Begin
 HTHashValue:=1;
End;

Function HTFound(Var Context;Item:HashItemPtr):Boolean;Begin
 HTFound:=False;
End;

Procedure HTCreateItem(Var Context;Var Item:HashItemPtr);
Var
 Q:HashTable Absolute Context;
Begin
 MoveLeft(Q.Block,Item^.Data,Q.SizeBlock);
End;

Function HTItemSize(Var Context):HashItemSizeRange;
Var
 Q:HashTable Absolute Context;
Begin
 HTItemSize:=Q.DefaultItemSize;
End;

Function HTCurrItemSize(Var Context;Item:HashItemPtr):HashItemSizeRange;
Var
 Q:HashTable Absolute Context;
Begin
 HTCurrItemSize:=Q.ItemSize(Q);
End;

Procedure HTAddBlock(Var Q:HashTable;Size:Word;Const Block);Begin
 Q.Block:=@Block;
 Q.SizeBlock:=Size;
 HTAdd(Q);
End;

BEGIN
END.