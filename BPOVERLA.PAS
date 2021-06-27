Unit BPOverlay;

INTERFACE

IMPLEMENTATION

Uses Overlay,Systex;

 Function ReadKey:Word;Near;Assembler;ASM
  XOR AX,AX
  INT $16;
 END;

BEGIN
 Repeat
  OvrInit('BASICPRO.EXE');
  If(OvrResult<>OvrOk)Then Begin
   OvrInit('BASICPRO.OVR');
   If(OvrResult<>OvrOk)Then Begin
    WriteLn('Fichier de recouvrement introuvable (BASICPRO.OVR) !');
    WriteLn('R‚essaie (O/N)?');
    If Char(ReadKey)='O'Then Continue Else Halt;
   End;
  End;
 Until Ya;
END.