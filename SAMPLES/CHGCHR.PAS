Program ChrChr;

Uses Systex,Systems;

Var
 Buffer:Array[0..1023]of Char;
 I,Len:Word;
 J:Long;
 Handle:Hdl;
 HW:Hdl;

BEGIN
 InitSystems(suIsabel);
 Handle:=Open('E:\SYSTEM.DAT',fmRead);
 If(Handle<>errHdl)Then Begin
  HW:=New('E:\SYSTEM.CHG');
  If(HW<>errHdl)Then Begin
   SetFilePos(HW,0);
   For J:=0to FileSize(Handle)div SizeOf(Buffer)do Begin
    Len:=_GetAbsRec(Handle,Long(SizeOf(Buffer))*Long(J),SizeOf(Buffer),Buffer);
    For I:=0to SizeOf(Buffer)-2do If(Buffer[I]in['H','h'])and(Buffer[I+1]=':')and(Buffer[I+2]='\')Then Begin
     Buffer[I]:='C';
    End;
    _SetRec(HW,Len{SizeOf(Buffer)},Buffer);
   End;
   Close(HW);
  End;
  Close(Handle);
 End;
END.