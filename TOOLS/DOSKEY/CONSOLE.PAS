{ΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝ CONSOLE.PAS ΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝ}
{ ΔΔΔΔΔΔΔΔΔ  Turbo 4.0/5.0 stay-resident demonstration program  ΔΔΔΔΔΔΔΔΔ }
{                 Copyright (c) 1989  Richard W. Prescott                 }
{ This Unit provides routines for changing the cursor shape, as well as   }
{ substitutes for ReadKey, WhereX/Y, and WRITE which require less code    }
{ and do not respond to Ctrl-C and Ctrl-Break.                            }
{ΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝ}
{ This Unit was compiled and assembled using Turbo Pascal Version 5.0     }
{ and TP&Asm Version 2 α.  TP&Asm provides an integrated compile-time     }
{ assembler within the Turbo development environment (and the command     }
{ line compiler TPC), resulting in an ASSEMBLY Development Environment    }
{ which is identical to your PASCAL Development Environment.              }
{                                                                         }
{ TP&Asm Version 2.0 will be available from me for $49 plus $3 P&H.  The  }
{ current Beta Test Version 2 α is available now for $39 plus $3 P&H,     }
{ with a free upgrade to 2.0 when it becomes available.                   }
{          Please see the README file for further information.            }
{ΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝ}

Unit CONSOLE;
{$F-}
INTERFACE
VAR
  MaxColumn: BYTE; {- maximum screen column number as reported by the BIOS -}

PROCEDURE WriteSubStr(VAR S; Index,Count: WORD);
PROCEDURE WriteChar(Ch0: CHAR);

FUNCTION ReadCursor: WORD;
FUNCTION WhereX: BYTE;
FUNCTION WhereY: BYTE;
PROCEDURE SetCursor(Posn: WORD);

PROCEDURE WideCursor; 
PROCEDURE ThinCursor; 
PROCEDURE HideCursor; 


FUNCTION BiosReadKey: CHAR; {compatible with T4 ReadKey w/o CheckBreak}

{ΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝ BiosFullKey ΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝ}
{ Read keyboard without echo to screen.  (Similar to ReadKey in CRT Unit) }
{ Returns a WORD with the character read in the low byte and the Scan     }
{ code of the key in the high byte.  Returns all keys, including extended }
{ keys, in a single call.  Useful if you want to DIFFERENTIATE "Enter"    }
{ from ^M, '+' from "Grey+", etc.  Treats Ctrl-C and Ctrl-Break the same  }
{ as all other keys, returning a character and scan code without          }
{ executing a user break.                                                 }
{ΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝ BiosFullKey ΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝ}
FUNCTION BiosFullKey:Word;
 InLine($32/$E4/  { XOR AH,AH }
        $CD/$16); { INT 16h   }

{ΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝ LookAhead ΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝ}
{ Same as BiosFullKey but leave keystroke in buffer for subsequent read.  }
{ΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝ LookAhead ΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝ}
FUNCTION LookAhead:   WORD; {- Inline Directive -}
 InLine($B4/$01/  {   WaitLoop: MOV AH,1    }
        $CD/$16/  {             INT 16h     }
        $74/$FA); {             JZ WaitLoop }

{ΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝ DosReadKey ΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝ}
{ Read keyboard without echo to screen.  (Similar to ReadKey in CRT Unit) }
{ Returns the same character that would be returned by ReadKey, except    }
{ that ANSI.SYS macros are expanded and Ctrl-C and Ctrl-Break are treated }
{ as characters rather than as user break requests.                       }
{ΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝ DosReadKey ΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝ}
FUNCTION DosReadKey:  CHAR; {- Inline Directive -}
 InLine($B4/$07/  { MOV AH,7 }
        $CD/$21); { INT 21h  }

{ΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝ DefaultDrive ΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝ}
{ Returns the default drive as a capital letter.                          }
{ΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝ DefaultDrive ΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝ}
FUNCTION DefaultDrive: CHAR; {- Inline Directive -}
 InLine($B4/$19/  { MOV AH,19h }
        $CD/$21/  { INT 21h    }
        $04/$41); { ADD AL,41h }

IMPLEMENTATION
{$S-} 

{ΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝ WriteSubStr ΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝ}
{ Write a substring to the screen using DOS, without checking for a user  }
{ break.  Uses same parameters as COPY to describe the desired substring. }
{ΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝ WriteSubStr ΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝ}
Procedure WriteSubStr(Var S;Index,Count:Word);Assembler;ASM
 Mov Cx,Count
 jCXZ @Finish
 Push Ds
  Lds Si,S
  Add Si,Index
  Mov Ah,06    { Direct Console I/O }
  Cld          { set Forward }
@L0:
  LodSB
  Mov Dl,Al
  Cmp Dl,255       {  function 06 cannot display #255 }
  JNE @2
  Mov Dl,' '  { Display Space instead }
@2:
  Int 021h
  Loop @L0
 Pop Ds
@Finish:
END;

{ΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝ WriteChar ΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝ}
{ Write a single character to the screen using DOS, without checking for  }
{ a user break.                                                           }
{ΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝ WriteChar ΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝ}
Procedure WriteChar(Ch0:Char);Assembler;
ASM
 Mov Ah,06   { Direct Console I/O }
 Mov Dl,Ch0
 Cmp Dl,255  { function 06 cannot display #255 }
 JNE @1
 Mov Dl,' '  { Display Space instead }
@1:
 Int 021h
END;

{ΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝ ReadCursor ΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝ}
{ Return cursor position as a WORD with Lo byte = X and Hi byte = Y.      }
{ Sets MaxColumn to maximum screen column number as reported by the BIOS. }
{ΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝ ReadCursor ΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝ}
Function ReadCursor:Word;Assembler;ASM
 Mov Ah,0Fh
 Int 10h           { put Active Video Page into Bh }
 Mov MaxColumn,Ah
 Mov Ah,03
 Int 10h           { Get Coords }
 ADD Dh,Dl         { Use (1,1) for UpperLeft }
 Mov AX,DX { Put in Function Result by name }
END;


{ΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝ WhereX/WhereY ΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝ}
{ Provides same function as CRT unit WhereX/WhereY.                       }
{ΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝ WhereX/WhereY ΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝ}
Function WhereX:Byte;Begin;WhereX:=Lo(ReadCursor)End;
Function WhereY:Byte;Begin;WhereY:=Hi(ReadCursor)End;

{ΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝ SetCursor ΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝ}
{ Set cursor position to WORD value which specifies X position in Lo byte }
{ and Y position in Hi byte.                                              }
{ΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝ SetCursor ΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝ}
PROCEDURE SetCursor(Posn:Word);Assembler;ASM
 Mov Ah,0Fh
 Int 10h      { put Active Video Page into Bh }
 Mov Dx,Posn
 SUB Dh,Dl    { BIOS uses (0,0) for UpperLeft }
 Mov Ah,02
 Int 10h      { set Coords }
END;

{ΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝ WideCursor ΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝ}
{ Set cursor shape to indicate insert mode.                               }
{ΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝ WideCursor ΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝ}
Procedure WideCursor;Assembler;ASM
  Mov Ah,0Fh
  Int 10h     { put Active Video Page into Bh, Video mode in Al }
  Mov Cx,0507h
  Cmp Al,07h
  JNE @1
  Mov Cx,080Ch
@1:
  Mov Ah,01
  Int 10h     { Set CursorType from Cx }
END;


{ΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝ ThinCursor ΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝ}
{ Set cursor shape to indicate overwrite mode.                            }
{ΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝ ThinCursor ΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝ}
Procedure ThinCursor;Assembler;ASM
 Mov Ah,0Fh
 Int 10h      { put Active Video Page into Bh, Video mode in Al }
 Mov Cx,0707h
 Cmp Al,07h
 JNE @1
 MOV Cx,0B0Ch
@1:
 Mov Ah,01
 Int 10h     { Set CursorType from Cx }
END;


{ΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝ HideCursor ΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝ}
{ Turn off cursor display by setting starting line out of range.  This    }
{ technique may not work on all displays.                                 }
{ΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝ HideCursor ΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝ}
Procedure HideCursor;Assembler;ASM
 Mov Ah,0Fh
 Int 10h       { put Active Video Page into Bh }
 Mov Cx,02000h { set bit 5 of Ch }
 Mov Ah,01
 Int 10h       { Set CursorType from Cx }
END;

{ΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝ BiosReadKey ΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝ}
{ Read keyboard without echo to screen.  (Similar to ReadKey in CRT Unit) }
{ Returns the same character that would be returned by ReadKey, except    }
{ that Ctrl-C and Ctrl-Break are treated as characters rather than as     }
{ user break requests.  ANSI.SYS macros are not expanded.                 }
{ΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝ BiosReadKey ΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝ}
Function BiosReadKey:Char;Assembler;Const BiosSaveScan:BYTE=0;ASM {compatible with T4 ReadKey w/o CheckBreak}
 Xor Ax,Ax            { Clear Ah and Al }
 Xchg Al,BiosSaveScan { Clear SaveScan }
 Or Al,Al             { Check Prior Scan }
 jNZ @Return          { NZ, Return it }
 Int 016h             { Else Get key via function 0 }
 Or Al,Al             { Check Char }
 jNZ @Return          { NZ, Return it }
 Mov BiosSaveScan,Ah  { Else Save Scan and return 0 }
@Return:
END;

END.
