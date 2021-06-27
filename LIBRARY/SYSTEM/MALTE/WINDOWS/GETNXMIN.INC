{Library\System\Malte\Windows\GetNxMin.Inc}

{$IFNDEF __GetNextWnMin}
 {$DEFINE __GetNextWnMin}

 {$I \Source\Chantal\Library\System\Malte\Windows\GetNxPos.Inc}

Function GetNextWnMin(L,H:Byte;Var X,Y:Byte;SizeOf:Wd;Model:Byte):Pointer;Var X1,Y1,X2,Y2:Byte;Begin
 {$IFDEF H}SaveBack;{$ENDIF}
 GetNextWnMin:=GetNextWnPos(X1,Y1,X2,Y2,SizeOf,Model);
 If(X2-X1<L)Then X:=MaxXTxts-L Else X:=X1;
 If(Y2-Y1<H)Then Y:=MaxYTxts-H-2 Else Y:=Y1;
End;

{$ENDIF}