{Init.Inc}

{$IFNDEF __InitWindow}
 {$DEFINE __InitWindow}

Procedure InitWindow;Begin
 ALInit(_Windows);
 CurrEdit:=0;WinPtr:=NIL;YEditor:=2;
End;

{$ENDIF}