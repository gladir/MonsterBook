Unit ModInit;

INTERFACE

IMPLEMENTATION

Uses Overlay;

BEGIN
 OvrInit('MOD386.EXE');
 If(OvrResult<>OvrOk)Then Begin
  OvrInit('MOD386.OVR');
  If(OvrResult<>OvrOk)Then Begin
   WriteLn('Fichier de recouvrement introuvable (MB.OVR) !');
   Halt;
  End;
 End;
END.