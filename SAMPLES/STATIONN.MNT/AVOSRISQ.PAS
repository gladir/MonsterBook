Program AvosRisques;

Procedure AvosRisque;External;{$L AvosRisques}

Function MemAlloc(Size:Word):Pointer;Far;Var Ptr:Pointer;Begin
 MemAlloc:=NIL;
 If(Size=0)or(MaxAvail<Size)Then Exit;
 GetMem(Ptr,Size);
 MemAlloc:=Ptr;
End;

Procedure Free(x0:Pointer;Size:Word);Far;Begin
 If(Size=0)or(x0=NIL)Then Exit;
 If Ofs(x0^)>$FThen Exit;
 If Seg(x0^)<Seg(HeapOrg^)Then Exit;
 System.FreeMem(x0,Size)
End;

BEGIN
 AvosRisque;
END.