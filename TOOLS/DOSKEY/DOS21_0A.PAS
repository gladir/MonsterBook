{อออออออออออออออออออออออออออออ DOS21_0A.PAS ออออออออออออออออออออออออออออออ}
{ ฤฤฤฤฤฤฤฤฤ  Turbo 4.0/5.0 stay-resident demonstration program  ฤฤฤฤฤฤฤฤฤ }
{                 Copyright (c) 1989  Richard W. Prescott                 }
{ This Unit contains the assembly code for the basic interrupt routine,   }
{ which is installed automatically by the Unit Initialization code.  The  }
{ original interrupt vector is stored in the current Code segment, which  }
{ simplifies chaining to the original interrupt routine.  This routine    }
{ traps only function $0A (Buffered Input), chaining to the original      }
{ interrupt $21 vector for all other function requests.  The assembly     }
{ code issues a FAR Call via the Pointer variable PascalCode, which must  }
{ be initialized to point to an appropriate interrupt service routine.    }
{อออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออ}
{ This Unit was compiled and assembled using Turbo Pascal Version 5.0     }
{ and TP&Asm Version 2 แ.  TP&Asm provides an integrated compile-time     }
{ assembler within the Turbo development environment (and the command     }
{ line compiler TPC), resulting in an ASSEMBLY Development Environment    }
{ which is identical to your PASCAL Development Environment.              }
{                                                                         }
{ TP&Asm Version 2.0 will be available from me for $49 plus $3 P&H.  The  }
{ current Beta Test Version 2 แ is available now for $39 plus $3 P&H,     }
{ with a free upgrade to 2.0 when it becomes available.                   }
{          Please see the README file for further information.            }
{อออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออ}

Unit DOS21_0A;

INTERFACE
{$F-}
PROCEDURE IRestore;
PROCEDURE IReturn;
PROCEDURE IChain;

TYPE
  UserRegs = RECORD
    CASE INTEGER OF
      0: (Ax,Bx,Cx,Dx,Si,Ds,Di,Es,Bp,Ip,Cs,Flags: WORD);
      1: (Al,Ah,Bl,Bh,Cl,Ch,Dl,Dh : BYTE);
  END; {UserRegs}
VAR
  PascalCode: Pointer;
  UserSP,UserSS: WORD;
  User: ^UserRegs absolute UserSP;
CONST
  CommandSig: WORD = 0;

{อออออออออออออออออออออออออออออออ SetSpLow ออออออออออออออออออออออออออออออออ}
{ Simple inline directive used in Shell to insure that "resident" stack   }
{ doesn't overlay the Exec Return.                                        }
{อออออออออออออออออออออออออออออออ SetSpLow ออออออออออออออออออออออออออออออออ}
PROCEDURE SetSpLow;InLine($BC/$80/$01); { Mov Sp,$180 }

{อออออออออออออออออออออออออออออ DefaultDrive ออออออออออออออออออออออออออออออ}
{ Returns the default drive as a capital letter.                          }
{อออออออออออออออออออออออออออออ DefaultDrive ออออออออออออออออออออออออออออออ}
FUNCTION DefaultDrive: CHAR;   {- Inline Directive -}
 InLine($B4/$19/  { MOV AH,19h }
        $CD/$21/  { INT 21h    }
        $04/$41); { ADD AL,41h }

{อออออออออออออออออออออออออ FreeEnvironmentBlock ออออออออออออออออออออออออออ}
{ Reduces resident memory usage by freeing the environment block for use  }
{ by the next process.                                                    }
{อออออออออออออออออออออออออ FreeEnvironmentBlock ออออออออออออออออออออออออออ}
(*PROCEDURE FreeEnvironmentBlock;  {- Inline Directive -}
 InLine($3E/$FF/$36/>PrefixSeg/ { Push PrefixSeg }
        $07/                    { Pop Es         }
        $BB/$2C/$00/            { Mov Bx,$2C  ;Addr of Environment Seg }
        $26/$8E/$09/            { Mov Es,Es:[Bx] ;Seg to release }
        $B4/$49/                { Mov Ah,$49     }
        $CD/$21);               { Int $21        }*)

IMPLEMENTATION

CONST
  ActiveFlag: BOOLEAN = FALSE;

{ออออออออออออออออออออออออออออออออ CsData อออออออออออออออออออออออออออออออออ}
{ The CSDATA construct is used to store data in the current Code Segment. }
{ The original interrupt address Dos21Vec MUST be stored in this Code     }
{ Segment to allow Chaining to the original interrupt routine with all of }
{ the User Registers intact. (The remaining variables COULD be stored in  }
{ the Data Segment and referenced after "Mov Ax,SEG Data" & "Mov Ds,Ax"). }
{ CsData Variables are available throughout the current Unit.             }
{ออออออออออออออออออออออออออออออออ CsData อออออออออออออออออออออออออออออออออ}
Type CsDataRec=Record
 Dos21Vec:LongInt;
 OurDs:Word;
 OurSs:Word;
 OurSp:Word;
 OurBp:Word;
End;

Procedure CsData;Assembler;ASM
{  Dos21Vec} Dd 0
{  OurDs} Dw 0
{  OurSs} Dw 0
{  OurSp} Dw 0
{  OurBp} Dw 0
END; {CsData}

{อออออออออออออออออออออออออออออออออ IHook อออออออออออออออออออออออออออออออออ}
{ This is the assembly portion of the interrupt service routine.          }
{ For function requests other than $0A, chain to the original interrupt   }
{ using an indirect jump to the address Dos21Vec stored in this Code      }
{ Segment.  For $0A, save registers, then restore Ds (stored in this Code }
{ Segment) and check ActiveFlag to avoid re-entrancy.  If not active,     }
{ save user stack frame and restore the Turbo program stack frame.        }
{ Finally, issue an indirect call to the address stored in the Pointer    }
{ PascalCode.  An ordinary return from PascalCode results in an automatic }
{ chain to the original interrupt.  (But see also IReturn and IChain).    }
{ ฤฤ The Pascal code for the Interrupt Service must be a FAR Procedure ฤฤ }
{อออออออออออออออออออออออออออออออออ IHook อออออออออออออออออออออออออออออออออ}
PROCEDURE IHook;Near;Assembler;ASM
  Cmp Ah,0Ah
  JE  @1
  Jmp CsData.CsDataRec.Dos21Vec {- (TP&Asm generates an automatic Cs override)}
@1:
  Push Bp;PUSH Es;PUSH Di;PUSH Ds;PUSH Si;PUSH Dx;PUSH Cx;PUSH Bx;PUSH Ax

  Mov Ax,Ds        { Store user signature in Ax}

  Mov Ds,CsData.CsDataRec.OurDs     { Restore Our Ds}

  Cmp CommandSig,0 { First Call is from COMMAND.COM ... Store Signature}
  JNZ @2
  Mov CommandSig,Ax
@2:
  Cmp ActiveFlag,0 {NOW check Flag stored in our DS}
  jNZ @Chain
  Inc ActiveFlag   { =1 until Resume}
  Mov UserSS,Ss    { Save User Stack Ss:Sp in Our Ds}
  Mov UserSP,Sp    {  (other registers stored on User Stack)}
  Mov Ss,CsData.CsDataRec.OurSs     { Switch to Our Stack Frame}
  Mov Sp,CsData.CsDataRec.OurSp
  Mov Bp,CsData.CsDataRec.OurBp
  Call PascalCode  { pointer to Pascal Service Routine}
  Mov Ss,UserSS    { Restore User Stack Ss:Sp From Our Ds}
  Mov Sp,UserSP
  Mov ActiveFlag,0 { Reset Flag stored in our DS}
@Chain:
  Pop  Ax;POP Bx;POP Cx;POP Dx;POP Si;POP Ds;POP Di;POP Es;POP Bp  {Restore user registers}
  Jmp CsData.CsDataRec.Dos21Vec
END;


{อออออออออออออออออออออออออออออออออ IInit อออออออออออออออออออออออออออออออออ}
{ Store Turbo program registers Ds, Ss, Sp, and Bp, and the current value }
{ of the interrupt $21 vector, in the current Code Segment.  Set the new  }
{ value of the interrupt $21 vector to point to INTERNAL Procedure IHook. }
{อออออออออออออออออออออออออออออออออ IInit อออออออออออออออออออออออออออออออออ}
PROCEDURE IInit;Assembler;ASM
  Mov CsData.CsDataRec.OurDs,Ds
  Mov CsData.CsDataRec.OurSs,Ss
  Mov CsData.CsDataRec.OurSp,Sp
  Mov CsData.CsDataRec.OurBp,Bp

  Mov Ax,03521h         { Get Interrupt into Es:Bx}
  Int 021h              {-Store in Code Seg to allow Chaining}
  Mov Word Ptr CsData.CsDataRec.Dos21Vec,Bx     { This Assembly Reference will link in CsData}
  Mov Word Ptr CsData.CsDataRec.Dos21Vec+2,Es

  Mov Ax,02521h         { Set Interrupt to Ds:Dx}
  Push Cs
  Pop Ds
  Mov Dx,Offset IHook   { This Assembly Reference will link in IHook}
  Int 021h
  Mov Ds,CsData.CsDataRec.OurDs
END;


{อออออออออออออออออออออออออออออออ IRestore ออออออออออออออออออออออออออออออออ}
{ Restore the interrupt $21 vector to the value saved during IInit.  See  }
{ the Procedure Shell in CMDQ.PAS.                                        }
{อออออออออออออออออออออออออออออออ IRestore ออออออออออออออออออออออออออออออออ}
PROCEDURE IRestore;Assembler;ASM
 Mov Ax,02521h  { Set Interrupt to Ds:Dx}
 Push Ds
  Lds Dx,CsData.CsDataRec.Dos21Vec
  Int 021h
 Pop Ds
END;

{ออออออออออออออออออออออออออออออออ IReturn ออออออออออออออออออออออออออออออออ}
{ Set Inactive Flag, restore user registers, and return from interrupt.   }
{ May be called from within nested procedures.  User registers may be     }
{ inspected/modified before return via the User^ record (User^.Bx, etc).  }
{ออออออออออออออออออออออออออออออออ IReturn ออออออออออออออออออออออออออออออออ}
PROCEDURE IReturn;Assembler;ASM
 Mov Ss,UserSS  { Restore User Stack Ss:Sp From Our Ds}
 Mov Sp,UserSP
 Mov ActiveFlag,0                {Reset Flag stored in our DS}
 Pop Ax;POP Bx;POP Cx;POP Dx;POP Si;POP Ds;POP Di;POP Es;POP Bp  {Restore user registers}
 IRET
END;

{ออออออออออออออออออออออออออออออออ IChain อออออออออออออออออออออออออออออออออ}
{ Set Inactive Flag, restore user registers, and jump to old interrupt.   }
{ May be called from within nested procedures.  User registers may be     }
{ inspected/modified before chain via the User^ record (User^.Bx, etc).   }
{ออออออออออออออออออออออออออออออออ IChain อออออออออออออออออออออออออออออออออ}
Procedure IChain;Assembler;ASM
 Mov Ss,UserSS                   {Restore User Stack Ss:Sp From Our Ds}
 Mov Sp,UserSP
 Mov ActiveFlag,0                {Reset Flag stored in our DS}
 Pop Ax;POP Bx;POP Cx;POP Dx;POP Si;POP Ds;POP Di;POP Es;POP Bp  {Restore user registers}
 Jmp CsData.CsDataRec.Dos21Vec
END;


{อออออออออออออออออออออออออออออ Initialiation อออออออออออออออออออออออออออออ}
{ Automatically install interrupt system.                                 }
{อออออออออออออออออออออออออออออ Initialiation อออออออออออออออออออออออออออออ}
BEGIN
 IInit;
END.