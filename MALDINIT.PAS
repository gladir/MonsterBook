Unit MalDInit;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                  INTERFACE
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Procedure OvrInitXMS;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                 IMPLEMENTATION
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses {$IFDEF Overlay}Overlay,{$ENDIF}Systex;

Procedure OvrInitXMS;External;{$L OVERXMS.OBJ }

 Function ReadKey:Word;Near;Assembler;ASM
  XOR AX,AX
  INT 016h
 END;

BEGIN
 {$IFDEF Overlay}Repeat
  OvrInit('MBD.EXE');
  If(OvrResult<>OvrOk)Then Begin
   OvrInit('MBD.OVR');
   If(OvrResult<>OvrOk)Then Begin
    WriteLn('Fichier de recouvrement introuvable (MBD.OVR) !');
    WriteLn('R‚essaie (O/N)?');
    If Char(ReadKey)='O'Then Continue Else Halt;
   End;
  End;
 Until True;{$ENDIF}
END.