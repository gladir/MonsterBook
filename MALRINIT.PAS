Unit MalRInit;

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
  OvrInit('MBR.EXE');
  If(OvrResult<>OvrOk)Then Begin
   OvrInit('MBR.OVR');
   If(OvrResult<>OvrOk)Then Begin
    WriteLn('Fichier de recouvrement introuvable (MBR.OVR) !');
    WriteLn('R‚essaie (O/N)?');
    If Char(ReadKey)='O'Then Continue Else Halt;
   End;
  End;
 Until True;{$ENDIF}
END.