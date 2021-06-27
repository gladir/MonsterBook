{Library\System\Malte\Windows\Model.Inc}

{$IFNDEF __WindowsModel}
 {$DEFINE __WindowsModel}

Function Model:Byte;Begin
 {$IFDEF UnitH}
  If ALIsEmpty(_Windows)Then Model:=0 else Model:=WinPtr^.Model;
 {$ELSE}
  Model:=HModel(Windows)
 {$ENDIF}
End;

{$ENDIF}