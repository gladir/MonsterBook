Unit MalInit;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                  INTERFACE
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                 IMPLEMENTATION
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses {$IFDEF Overlay}Overlay,{$ENDIF}Systex;

 Function ReadKey:Word;Near;Assembler;ASM
  XOR AX,AX
  INT 016h
 END;

BEGIN
 {$IFDEF Overlay}Repeat
  OvrInit('MB.EXE');
  If(OvrResult<>OvrOk)Then Begin
   OvrInit('MB.OVR');
   If(OvrResult<>OvrOk)Then Begin
    WriteLn('Fichier de recouvrement introuvable (MB.OVR) !');
    WriteLn('R‚essaie (O/N)?');
    If Char(ReadKey)='O'Then Continue Else Halt;
   End;
  End;
 Until True;{$ENDIF}
END.