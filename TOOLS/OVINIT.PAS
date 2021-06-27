Unit OVInit;

INTERFACE

IMPLEMENTATION

Uses {$IFDEF Overlay}Overlay,{$ENDIF}Systex;
 Function ReadKey:Word;Near;Assembler;ASM XOR AX,AX;INT $16;END;
BEGIN
 {$IFDEF Overlay}Repeat
  OvrInit('OVP.EXE');
  If(OvrResult<>OvrOk)Then Begin
   OvrInit('OVP.OVR');
   If(OvrResult<>OvrOk)Then Begin
    WriteLn('Fichier de recouvrement introuvable (OVP.OVR) !');
    WriteLn('R‚essaie (O/N)?');
    If Char(ReadKey)='O'Then Continue Else Halt;
   End;
  End;
 Until Ya;{$ENDIF}
END.