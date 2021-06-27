Function EtatClavier : Byte;
Begin
 Registre.AH := $0B;
 MsDos(Registre);
 EtatClavier := Registre.Al;
End;

Procedure VideBuffer;
Label Debut;
Begin
 Debut : If(EtatClavier=$FF)Then
 Begin
  Registre.AH := $00;
  Intr($16,Registre);
  Goto Debut;
 End;
End;

Function LitClavier : Word;
Begin
 Registre.AH := $00;
 Intr($16,Registre);
 LitClavier := Registre.AX;
End;
