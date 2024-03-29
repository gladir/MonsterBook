{様様様様様様様様様様様様様様様� DOSKEY 様様様様様様様様様様様様様様様様}
{ Nom des Programmeurs
  様様様様様様様様様様

   Richard W. Prescott  (�crit en 1989 pour le Turbo Pascal 4)
   Sylvain Maltais      (Modifi� en 1997 pour le Borland Pascal 7)

{ This program provides basic line editing and recall capability at the   }
{ DOS command line and within any program that requests keyboard input    }
{ through interrupt $21 function $0A (Buffered Input).                    }
{                                                                         }
{ The Unit DOS21_0A contains the assembly code for the basic interrupt    }
{ routine, which is installed automatically by the "Uses DOS21_0A"        }
{ clause.  This routine traps only function $0A (Buffered Input),         }
{ chaining to the original interrupt $21 vector for all other function    }
{ requests.  The assembly code issues a FAR Call via the Pointer variable }
{ PascalCode which is initialized in the MAIN block (below) to point to   }
{ the procedure ServiceProc.  ServiceProc repeatedly polls the keyboard   }
{ and calls the appropriate Proc/Function to provide the line edit and    }
{ recall facilities.                                                      }
{                                                                         }
{ The Unit DOS21_0A provides the Procedures IChain for chaining to the    }
{ original interrupt routine, and IReturn for returning directly to the   }
{ calling program.  These may be called from any point within the Pascal  }
{ code.  The user registers at interrupt entry are accessible through the }
{ record variable User^ (User^.Ax, User^.Flags, etc).  They should be     }
{ modified as necessary to simulate a successful interrupt request before }
{ calling IReturn, as illustrated in the procedure ReturnCommand.         }
{                                                                         }
{ The Unit CONSOLE provides routines for changing the cursor shape, as    }
{ well as substitutes for ReadKey, WhereX/Y, and WRITE.  (The CRT Unit    }
{ installs a considerable amount of initialization code, which is         }
{ undesirable in a resident program; the CONSOLE Unit installs no         }
{ initialization code).  The substitutes for WRITE require less code and  }
{ do not respond to Ctrl-C and Ctrl-Break.                                }

Program DosKey;

{$M $400,0,0} {- �crase la pile durant le d�veloppement du programme! -}
{$S-}         {- L'Enlever durant le d�veloppement du programme! }

{
   敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳�
   � Le  configuration   par  d�faut  cr�e  un  v�ritable  programme �
   � r�sident.  Pour cr�er un version roulant  comme un interpr�teur �
   � de commande (�COMMAND.COM Shell�) et pouvant �tre enlev� par la �
   � commande   "EXIT",   utiliser   la  directive   de  compilation �
   � conditionnel �$DEFINE� avec le symbole �SHELL� ou compiler avec �
   � le prompt  suivant: �TPC DOSKEY /DSHELL�.  C'est  dans  le  but �
   � �galement de faciliter le d�veloppement primaire du programme.  �
   青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳�
}

Uses Systex,DOS,Console,DOS21_0A;
Const DefaultMode=Ya; {Par d�faut mettre en mode insertion}
{- Constantes du Standard des SCAN Code -}
   F1 = $3B;   F2 = $3C;   F3 = $3D;   F4 = $3E;   F5 = $3F;
   F6 = $40;   F7 = $41;   F8 = $42;   F9 = $43;   F0 = $44;

   HomeKey       = $47;    CtrlHome      = $77;
   UpArrow       = $48;
   PgUp          = $49;    CtrlPgUp      = $84;
   LeftArrow     = $4B;    CtrlLeftArrow = $73;
   RtArrow       = $4D;    CtrlRtArrow   = $74;
   EndKey        = $4F;    CtrlEnd       = $75;
   DownArrow     = $50;
   PgDn          = $51;    CtrlPgDn      = $76;
   InsertKey     = $52;    DeleteKey     = $53;

{- Constantes des Caract�res Standard -}

   CtrlBkSl {^\} = #$1C;
   BackSpace     = #$08;   CtrlBsp       = #$7F;
   Enter         = #$0D;   CtrlEnter     = #$0A;
   Escape        = #$1B;   Tab           = #$09;
   Null          = #0;

Var
  CurrentLine:String;
  CurrentLineLen:Byte Absolute CurrentLine;
  MaxChars:Byte;{ Espace maximum dans le tampon pour les caract�res utilisateurs }
  LinePos,SavePos:Byte;
  InsertMode:Boolean;
  CmdQ:Array[0..$FF]of Byte; {- Queue de commande -}
  QTail,Qptr,Tptr:^String;
  QTailLen:^Byte Absolute QTail;
  QptrLen:^Byte Absolute QPtr;
  TptrLen:^Byte Absolute TPtr;
  QTailW:Word Absolute QTail;
  QptrW:Word Absolute QPtr;
  TptrW:Word Absolute TPtr;
  MarkX,MarkY:Byte;Mark:Word Absolute MarkX;
  Ch:Char;Scan:Byte;Key:Word Absolute Ch;

{$I ..\..\LIBRARY\KEYPRESS.INC}
{$I ..\..\LIBRARY\READKEY.INC}

Var SegV:Word; CtrlMode:Bool;

Procedure PutTxtXY(X,Y:Byte;Var S:String);Var I:Byte;Begin
 For I:=0to Length(S)-1do MemW[SegV:(X+I+Y*CurrNmXTxts)shl 1]:=Byte(S[I+1])+$1B00;
End;

Procedure SetCurPos(X,Y:Byte);Assembler;ASM
 MOV AH,02h
 MOV DL,X
 MOV DH,Y
 INT 10h
END;

Procedure PutTxt(Var S:String);Var B:Wd;I:Byte;Begin
 B:=YCur*CurrNmXTxts+XCur;
 For I:=0to Length(S)-1do Mem[SegV:(I+B)shl 1]:=Byte(S[I+1]);
 Inc(XCur,Length(S));
 For I:=Length(S)to CurrNmXTxts-1do Mem[SegV:(I+B)shl 1]:=32;
 SetCurPos(XCur,YCur);
End;

{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳嬬
 �                               ShowCursor                             �
 接樛樛樛樛樛樛樛樛樛樛樛樛樛樛樛樛樛樛樛樛樛樛樛樛樛樛樛樛樛樛樛樛樛樛樂


{Description
 様様様様様�

  Cette proc�dure fixe le curseur en mode d'�crassement ou d'insertion en
 fonction du drapeau d'insertion du BIOS.
}

Procedure ShowCursor;Begin
 If(InsertMode)Then WideCursor Else ThinCursor;
End;

{様様様様様様様様様様様様様様様 CursorLeft 様様様様様様様様様様様様様様様�}
{ Move cursor left (or reverse line wrap) and update GLOBAL VAR LinePos.  }
{ Cursor is moved by sending a BackSpace (#8), which allows for reverse   }
{ line wrap within windows defined under certain BIOS enhancements (e.g.  }
{ FANSI-CONSOLE).  If x position does not change, implement reverse line  }
{ wrap by decrementing y position and setting x position to the maximum   }
{ screen column as determined from the BIOS.                              }
{様様様様様様様様様様様様様様様 CursorLeft 様様様様様様様様様様様様様様様�}
Procedure CursorLeft;Begin
 If LinePos>1Then Begin
  Mark:=ReadCursor;
  WriteChar(#8);Dec(LinePos);
  If(WhereX=MarkX)Then Begin
   Dec(MarkY);MarkX:=MaxColumn;SetCursor(Mark);
  End;
 End;
End;

{様様様様様様様様様様様様様様様� WordLeft 様様様様様様様様様様様様様様様様}
{ Move cursor to preceding "word start" and update GLOBAL VAR LinePos.    }
{ A "word start" is a non-space preceded by a space (or the line start).  }
{様様様様様様様様様様様様様様様� WordLeft 様様様様様様様様様様様様様様様様}
Procedure WordLeft;Begin
 If LinePos>1Then Repeat CursorLeft Until(LinePos=1)or((CurrentLine[LinePos]<>' ')and(CurrentLine[LinePos-1]=' '))
End;

{様様様様様様様様様様様様様様様 CursorRight 様様様様様様様様様様様様様様様}
{ Move cursor right (or wrap to next line) and update GLOBAL VAR LinePos. }
{ Cursor is moved by writing the character at the current LinePos to the  }
{ console, providing automatic line wrap and scrolling as required.       }
{様様様様様様様様様様様様様様様 CursorRight 様様様様様様様様様様様様様様様}
Procedure CursorRight;Begin
 If(LinePos<=CurrentLineLen)Then Begin
  WriteChar(CurrentLine[LinePos]);
  Inc(LinePos);
 End;
End;

{様様様様様様様様様様様様様様様� WordRight 様様様様様様様様様様様様様様様�}
{ Move cursor to following "word start" and update GLOBAL VAR LinePos.    }
{ A "word start" is a non-space preceded by a space (or the line end).    }
{様様様様様様様様様様様様様様様� WordRight 様様様様様様様様様様様様様様様�}
Procedure WordRight;Begin
 If(LinePos<=CurrentLineLen)Then
  Repeat CursorRight Until(LinePos>CurrentLineLen)or((CurrentLine[LinePos]<>' ')and(CurrentLine[LinePos-1]=' '));
End;

{様様様様様様様様様様様様様様様� CursorHome 様様様様様様様様様様様様様様様}
{ Move cursor to the beginning of the line and update GLOBAL VAR LinePos. }
{様様様様様様様様様様様様様様様� CursorHome 様様様様様様様様様様様様様様様}
Procedure CursorHome;Begin
 While LinePos>1do CursorLeft;
End;

{様様様様様様様様様様様様様様様� CursorEnd 様様様様様様様様様様様様様様様�}
{ Move cursor to the end of the line and update GLOBAL VAR LinePos.       }
{様様様様様様様様様様様様様様様� CursorEnd 様様様様様様様様様様様様様様様�}
Procedure CursorEnd;Begin
 While(LinePos<=CurrentLineLen)do CursorRight;
End;

{様様様様様様様様様様様様様様様� ToggleMode 様様様様様様様様様様様様様様様}
{ Toggle cursor size and update GLOBAL Flag InsertMode.                   }
{様様様様様様様様様様様様様様様� ToggleMode 様様様様様様様様様様様様様様様}
Procedure ToggleMode;Begin
 ASM {InsertMode:=Not InsertMode;}
  XOR InsertMode,1
 END;
 ShowCursor;
End;

{様様様様様様様様様様様様様様様� InsertChar 様様様様様様様様様様様様様様様}
{ Insert character at cursor position (moving existing characters and     }
{ cursor one position right) and update GLOBAL VARs CurrentLine and       }
{ LinePos.  Uses SetCursor to restore cursor after screen update.  Note   }
{ however that the last Char written by WriteSubStr may cause the screen  }
{ to scroll, making MarkY invalid.  If WhereY (after update) = MarkY      }
{ (before update) check for scroll by sending a BackSpace; if the cursor  }
{ does not move, a scroll has occurred (decrement MarkY to correct).  If  }
{ it does move, set MarkY = WhereY in case the screen DID scroll but the  }
{ BackSpace caused a reverse line wrap (Supports FANSI-CONSOLE Windows)   }
{様様様様様様様様様様様様様様様� InsertChar 様様様様様様様様様様様様様様様}
Procedure InsertChar(Ch1:Char);Var Mark2:Word;Begin
 IF CurrentLineLen<MaxChars-1Then Begin
  Insert(Ch1,CurrentLine,LinePos);CursorRight; { Display Ch/move right }
  Mark:=ReadCursor;
  WriteSubStr(CurrentLine,LinePos,1+CurrentLineLen-LinePos);
  If(LinePos<=CurrentLineLen)and(WhereY=MarkY)Then Begin
   Mark2:=ReadCursor; WriteChar(#8);       { Envoie un BackSpace }
   If(Mark2=ReadCursor)Then Dec(MarkY)     { Scrolled: Adjust MarkY }
                       Else MarkY:=WhereY; { No Scroll or Scroll & reverse wrap }
  End;
  SetCursor(Mark);
 End;
End;

{様様様様様様様様様様様様様様様� OverWrite 様様様様様様様様様様様様様様様�}
{ Replace character at current cursor position and move right.            }
{ Updates GLOBAL VARs CurrentLine and LinePos.                            }
{様様様様様様様様様様様様様様様� OverWrite 様様様様様様様様様様様様様様様�}
Procedure OverWrite(Ch1:Char);Begin
 If(LinePos<MaxChars)Then Begin
  If(LinePos>CurrentLineLen)Then Inc(CurrentLineLen);
  WriteChar(Ch1);
  CurrentLine[LinePos]:=Ch1;Inc(LinePos);
 End;
End;

{様様様様様様様様様様様様様様様� DeleteChar 様様様様様様様様様様様様様様様}
{ Delete character at cursor position (moving trailing characters one     } 
{ one position left) and update GLOBAL VAR CurrentLine.  Cursor position  }
{ is not changed.                                                         }
{様様様様様様様様様様様様様様様� DeleteChar 様様様様様様様様様様様様様様様} 
PROCEDURE DeleteChar; BEGIN
  IF LinePos <= CurrentLineLen THEN BEGIN
    Mark := ReadCursor; Delete(CurrentLine,LinePos,1);
    WriteSubStr(CurrentLine,LinePos,1+CurrentLineLen-LinePos);
    WriteChar(' '); SetCursor(Mark);
  END; {IF LinePos <= CurrentLineLen THEN }
END; {PROCEDURE DeleteChar}

{様様様様様様様様様様様様様様様� DeleteLeft 様様様様様様様様様様様様様様様}
{ Delete character to left of cursor (moving existing characters and      }
{ cursor one position left) and update GLOBAL VARs CurrentLine and        }
{ LinePos.                                                                }
{様様様様様様様様様様様様様様様� DeleteLeft 様様様様様様様様様様様様様様様}
PROCEDURE DeleteLeft; BEGIN
  IF LinePos>1 THEN BEGIN
    CursorLeft; DeleteChar;
  END; {IF LinePos>1 THEN }
END; {PROCEDURE DeleteLeft}

{様様様様様様様様様様様様様様様� DisplayNew 様様様様様様様様様様様様様様様}
{ Replace CurrentLine with new command (Cmd), and set LinePos to end of   }
{ line.  Erase trailing characters of old line as indicated by OldLen.    }
{ Used by EraseLine, DeleteHome, DeleteEnd, PrevCommand, NextCommand,     }
{ and ClearCommand.                                                       }
{様様様様様様様様様様様様様様様� DisplayNew 様様様様様様様様様様様様様様様}
Procedure DisplayNew(Var Cmd:String;OldLen:Byte);Var n:Byte;CmdLen:Byte Absolute Cmd;Begin
 CursorHome;
 If Not(CtrlMode)Then Begin
  PutTxt(Cmd);
  If(OldLen>CmdLen)Then Begin
   Mark:=ReadCursor;
   For n:=CmdLen to OldLen-1do WriteChar(' ');
   SetCursor(Mark);
  End;
 End;
 CurrentLine:=Cmd;LinePos:=CurrentLineLen+1;
End;

{様様様様様様様様様様様様様様様� EraseLine 様様様様様様様様様様様様様様様�}
{ Erase current display line and update GLOBAL VAR CurrentLine.           }
{様様様様様様様様様様様様様様様� EraseLine 様様様様様様様様様様様様様様様�}
PROCEDURE EraseLine; BEGIN
  SavePos := CurrentLineLen;
  CurrentLineLen := 0;
  DisplayNew(CurrentLine,SavePos);
END; {PROCEDURE EraseLine; }

{様様様様様様様様様様様様様様様� DeleteHome 様様様様様様様様様様様様様様様}
{ Delete characters left of cursor and update GLOBAL VAR CurrentLine.     }
{ Cursor is placed at the beginning of the new line.                      }
{様様様様様様様様様様様様様様様� DeleteHome 様様様様様様様様様様様様様様様}
PROCEDURE DeleteHome; BEGIN
  IF LinePos>1 THEN BEGIN
    SavePos := CurrentLineLen;
    Delete(CurrentLine,1,LinePos-1);
    DisplayNew(CurrentLine,SavePos);
    CursorHome;
  END; {IF LinePos>1 THEN }
END; {PROCEDURE DeleteHome}

{様様様様様様様様様様様様様様様� DeleteEnd 様様様様様様様様様様様様様様様�} 
{ Delete characters from cursor to end of line and update GLOBAL VAR      }
{ CurrentLine.  Cursor is left at the end of the line.                    }
{様様様様様様様様様様様様様様様� DeleteEnd 様様様様様様様様様様様様様様様�} 
PROCEDURE DeleteEnd; BEGIN
  IF LinePos <= CurrentLineLen THEN BEGIN
    SavePos := CurrentLineLen;
    CurrentLineLen := LinePos-1;
    DisplayNew(CurrentLine,SavePos);
  END; {IF LinePos <= CurrentLineLen THEN }
END; {PROCEDURE DeleteEnd}

   {様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様}
   { The following five proceduress manipulate the command queue.     }
   { Commands are stored with a leading AND trailing length byte as   }
   { illustrated below:                                               }
   {       [L0]Cmd0[L0] [L1]Cmd1[L1] [L2]Cmd2[L2] [L3][L3]            }
   {        ^Ofs(CmdQ)   ^QPtr                     ^QTail             }
   { QPtr points to the currently displayed command, viewed as a      }
   { String.  QPtrLen points to the same location but refers to the   }
   { length byte only.  It is used to determine the start of the next }
   { command (Length+2 bytes forward).  QPtrW refers to the offset    }
   { portion of the pointer QPtr/QPtrLen.  It is adjusted directly to }
   { change the command referenced by QPtr.  To move backward in the  }
   { queue, QPtrW is decremented so that QPtrLen refers to the        }
   { trailing length byte of the preceding command.  The start of the }
   { command is then Length+1 bytes backward.                         }
   { The oldest command is always at offset 0 within CmdQ, while      }
   { QTail points to the next available location to store a command.  }
   { If there is not sufficient space at QTail to store a new command }
   { the oldest command is discarded and the remaining ones shifted   }
   { left so that the oldest remaining command is again at Ofs(CmdQ). }
   {様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様}

{様様様様様様様様様様様様様様様 NextCommand 様様様様様様様様様様様様様様様}
{ Advance QPtr to next command in queue and display it.  If pointer       }
{ reaches QTail, cycle back to start of CmdQ (oldest command).            }
{様様様様様様様様様様様様様様様 NextCommand 様様様様様様様様様様様様様様様}
PROCEDURE NextCommand; VAR n:BYTE; BEGIN
  IF QTail = @CmdQ THEN Exit;
  IF QPtr = QTail THEN QPtr := @CmdQ
  ELSE Inc(QPtrW, QPtrLen^ + 2);
  IF QPtr = QTail THEN QPtr := @CmdQ;
  DisplayNew(QPtr^,CurrentLineLen);
END; {PROCEDURE NextCommand}

{様様様様様様様様様様様様様様様 PrevCommand 様様様様様様様様様様様様様様様}
{ If display is blank, display current command at QPtr.  Otherwise move   }
{ QPtr back to previous command in queue and display it.  If pointer was  }
{ at start of CmdQ (oldest command), cycle to QTail before moving back.   }
{様様様様様様様様様様様様様様様 PrevCommand 様様様様様様様様様様様様様様様}
Procedure PrevCommand;Begin
 If(QTail=@CmdQ)Then Exit;
 If(QPtr=QTail)or(CurrentLineLen<>0)Then Begin
 If(Qptr=@CmdQ)Then QPtr:=QTail;
  Dec(QptrW); {Now Pointing to length of Prev Command}
  Dec(QptrW,QPtrLen^+1);
 End;
 DisplayNew(QPtr^,CurrentLineLen);
End;


{様様様様様様様様様様様様様様� ClearCommand 様様様様様様様様様様様様様様様} 
{ Remove currently displayed command from command queue.  Shift remaining }
{ commands back to fill the gap, and display the new command at QPtr (the }
{ command following the one removed).                                     }
{様様様様様様様様様様様様様様� ClearCommand 様様様様様様様様様様様様様様様} 
PROCEDURE ClearCommand; BEGIN
  IF CurrentLine <> QPtr^ THEN BEGIN EraseLine; Exit; END;
  IF (QTail = @CmdQ) OR (QPtr = QTail) THEN Exit;
  Tptr := Qptr;Inc(TPtrW, QPtrLen^ + 2);
  Move(TPtr^,QPtr^,Ofs(CmdQ)+SizeOf(CmdQ)-TPtrW);
  Dec(QTailW,TPtrW-QPtrW);
  MemW[Dseg:QTailW]:=0;
  IF QPtr = QTail THEN QPtr := @CmdQ;
  DisplayNew(QPtr^,CurrentLineLen);
END; {PROCEDURE ClearCommand}


{様様様様様様様様様様様様様様様� ClearQueue 様様様様様様様様様様様様様様様}
{ Remove all commands from command queue and display a blank line.        }
{様様様様様様様様様様様様様様様� ClearQueue 様様様様様様様様様様様様様様様}
PROCEDURE ClearQueue; BEGIN
  EraseLine;
  Qtail:=@CmdQ; QPtr:=QTail; MemW[Dseg:Ofs(CmdQ)]:=0;
END; {PROCEDURE ClearQueue}


{様様様様様様様様様様様様様様様 QueueCommand 様様様様様様様様様様様様様様�}
{ Append currently displayed command to command queue.  If sufficient     }
{ space is not available at QTail, discard oldest command(s) and move     }
{ remaining commands back until oldest remaining command is at Ofs(CmdQ). }
{様様様様様様様様様様様様様様様 QueueCommand 様様様様様様様様様様様様様様�}
PROCEDURE QueueCommand; BEGIN
  TPtr := @CmdQ;
  WHILE CurrentLineLen+2+QTailW-TPtrW>SizeOf(CmdQ)DO Inc(TPtrW,TPtrLen^+2);
  IF   TPtrW <> Ofs(CmdQ)THEN Move(TPtr^,CmdQ,Ofs(CmdQ)+SizeOf(CmdQ)-TPtrW);
  Dec(QTailW,TPtrW-Ofs(CmdQ));

  QTail^ := CurrentLine;            {- Add command string -}
  Inc(QTailW,CurrentLineLen+1);
  QTailLen^ := CurrentLineLen;      {- Add trailing length byte -}
  Inc(QTailW);                      {- Set new QTail -}
  QPtr := QTail;                    {- Set Qptr to new QTail -}
END; {PROCEDURE QueueCommand}


{様様様様様様様様様様様様様様� ReturnCommand 様様様様様様様様様様様様様様�}
{ Execute return from interrupt.  Place currently displayed command       }
{ STRING (including Length byte) at offset 1 within callers buffer at     }
{ Ds:Dx, and add trailing Carriage Return (#13, not counted in length).   }
{ This emulates the documented action of Interrupt $21 function $0A:      }
{     Input Buffer:   [BufferSize][Length][Line Returned][#13]            }
{    Caller's Ds:Dx    ^+0         ^+1     ^+2            ^+Length+2      }
{ The Buffer Size at Ds:Dx is supplied by the caller.  It is read into    }
{ MaxChars (below) and used by InsertChar and OverWrite to limit the      }
{ maximum allowable size of CommandLine.                                  }
{様様様様様様様様様様様様様様� ReturnCommand 様様様様様様様様様様様様様様�}
Procedure ReturnCommand;Begin
 CurrentLine[CurrentLineLen+1] := #13;
 Move(CurrentLine,Mem[User^.Ds:User^.Dx+1],CurrentLineLen+2);
 CursorEnd;
 ShowCursor;
 Dos21_0A.IReturn;
End;


{様様様様様様様様様様様様様様様 QueueReturn 様様様様様様様様様様様様様様様}
{ Return Command, adding it to the command queue if new or modified.      }
{ Short commands are not added to the queue.                              }
{様様様様様様様様様様様様様様様 QueueReturn 様様様様様様様様様様様様様様様}
Procedure QueueReturn;Begin
 If(CurrentLineLen>2)and(CurrentLine<>QPtr^)Then QueueCommand;
 ReturnCommand;
End;

{様様様様様様様様様様様様様様様 MacroReturn 様様様様様様様様様様様様様様様}
{ Return a predefined command if one is defined for the Scan code of the  }
{ key pressed.  Otherwise exit with no action.  Macro commands are not    }
{ added to the queue.  This feature may be removed or expanded as desired }
{様様様様様様様様様様様様様様様 MacroReturn 様様様様様様様様様様様様様様様}
Procedure MacroReturn;Begin
 SavePos:=CurrentLineLen;
 Case(Scan)of
  F2:CurrentLine:='EXIT';
  F5:CurrentLine:='DIR';
  Else Exit;
 End;
 DisplayNew(CurrentLine,SavePos);
 ReturnCommand;
End;

{様様様様様様様様様様様様様様様 DisplayPath 様様様様様様様様様様様様様様様}
{ Display current directory if caller is COMMAND.COM and default drive    }
{ is C or higher.                                                         }
{様様様様様様様様様様様様様様様 DisplayPath 様様様様様様様様様様様様様様様}
PROCEDURE DisplayPath; VAR Directory: STRING[67];  BEGIN
  IF (DefaultDrive >= 'C') AND (User^.Ds = CommandSig)AND (WhereX = 3) THEN BEGIN
    GetDir(0,Directory);
    XCur:=0;
    WriteSubStr(Directory,1,Length(Directory));
    WriteChar('>');
  END; {IF DefaultDrive >= 'C' THEN }
END; {PROCEDURE DisplayPath; }

Const
 Help1:String[40]='浜様様様様様様様� Aide 様様様様様様様様�';
 Help2:String[40]='� F1        Obtenir cette aide         �';
 Help3:String[40]='� F2        Quitter (EXIT<潰)          �';
 Help4:String[40]='� /�\       Commande Pr�c�dente        �';
 Help5:String[40]='� <陳       Reculer d''une position     �';
 Help6:String[40]='� Esc       Efface la ligne            �';
 Help7:String[40]='� Insert    Mode insertion/�craser     �';
 Help8:String[40]='� Ctrl+PgUp Efface la queue            �';
 Help9:String[40]='� Ctrl+B    Lancer le �Borland Pascal� �';
 Help10:String[40]='� Ctrl+C    Lancer le �Turbo C++�      �';
 Help11:String[40]='� Ctrl+M    Lancer le �MonsterBook�    �';
 Help12:String[40]='� Ctrl+N    Lance �Norton Commander�   �';
 Help13:String[40]='� Ctrl+W    Lancer �Windows�           �';
 Help14:String[40]='藩様様様� Presse une touche... 様様様様�';

Procedure Help;Var ScrSize:Wd Absolute 0:$44C;X:Byte;Begin
 Move(Mem[SegV:0],Mem[SegV:ScrSize],ScrSize);
 X:=(CurrNmXTxts-40)shr 1;
 PutTxtXY(X,4,Help1);
 PutTxtXY(X,5,Help2);
 PutTxtXY(X,6,Help3);
 PutTxtXY(X,7,Help4);
 PutTxtXY(X,8,Help5);
 PutTxtXY(X,9,Help6);
 PutTxtXY(X,10,Help7);
 PutTxtXY(X,11,Help8);
 PutTxtXY(X,12,Help9);
 PutTxtXY(X,13,Help10);
 PutTxtXY(X,14,Help11);
 PutTxtXY(X,15,Help12);
 PutTxtXY(X,16,Help13);
 PutTxtXY(X,17,Help14);
 Repeat Until KeyPress;
 ReadKey;
 Move(Mem[SegV:ScrSize],Mem[SegV:0],ScrSize);
End;

{様様様様様様様様様様様様様様様 ServiceProc 様様様様様様様様様様様様様様�}
{ This is the Pascal code for the interrupt service routine, called from }
{ DOS21_0A.IHook.  If Dormant, checks FIRST keystroke of each line       }
{ requested for the wakeup combination Ctrl-\.  If active, initialize    }
{ CurrentLine and cursor shape, read Caller's buffer size into MaxChars, }
{ and display current directory path (except floppy drives).  Then poll  }
{ the keyboard and execute edit requests until carriage return or macro. }
{ If Ctrl-\ is pressed while active, set Dormant flag and chain to the   }
{ original interrupt service routine.                                    }
{様様様様様様様様様様様様様様様 ServiceProc 様様様様様様様様様様様様様様�


 Remarque
 様様様様

  � Le code Pascal pour le service d'interruption doit absolument �tre une
    proc�dure �FAR�.
}

Const BPWelcome:String[28]='Lance le �Borland Pascal�...';
      TeleMateWelcome:String[22]='Lance le �TeleMate�...';
      WinWelcome:String[18]='Lance �Windows�...';

PROCEDURE ServiceProc;Far;Begin
 If VideoPort=$3D4Then SegV:=$B800 Else SegV:=$B000;
 LinePos:=1;CurrentLineLen:=0;CtrlMode:=No;
 InsertMode:=DefaultMode;ShowCursor;  {- Fixe par d�faut -}
 MaxChars:=Mem[User^.Ds:User^.Dx];
 DisplayPath;
 Repeat
  ShowCursor; {- Affiche le curseur durant l'attente d'une action utilisateur -}
  Repeat Until KeyPress;
  Key:=ReadKey;
  HideCursor;
  Case(Key)of
   kbCtrlBkSl:Begin
    EraseLine;
    ShowCursor;
    Dos21_0A.IChain;
   End;
   kbCtrlB,kbCtrlC,kbCtrlG,kbCtrlI,kbCtrlM,kbCtrlN,kbCtrlT,kbCtrlW:Begin
    CtrlMode:=Ya;SavePos:=CurrentLineLen;
    Case(Key)of
     kbCtrlB:Begin
      CurrentLine:='D:\LANGAGE\BP7\BIN\BP.EXE';
      PutTxt(BPWelcome);
     End;
     kbCtrlC:CurrentLine:='D:\LANGAGE\TURBOC3\TC.EXE';
     kbCtrlG:CurrentLine:='GEOS';
     kbCtrlI:CurrentLine:='C:\PCTOOLS\SI.EXE';
     kbCtrlM:CurrentLine:='D:\MALTE\MB.EXE';
     kbCtrlN:CurrentLine:='C:\UTILS\NC.EXE';
     kbCtrlT:Begin
      PutTxt(TeleMateWelcome);
      CurrentLine:='TM';
     End;
     kbCtrlW:Begin
      PutTxt(WinWelcome);
      ChDir('D:\WINDOWS');
      CurrentLine:='WIN.EXE';
     End;
    End;
    DisplayNew(CurrentLine,SavePos);
    ReturnCommand;
   End;
   Else Case(Ch)of
    Enter:      QueueReturn;
    Escape:     EraseLine;
    BackSpace:  DeleteLeft;
    #1..#255:   {- Caract�re affichage -}
                If(InsertMode)Then InsertChar(ch)Else OverWrite(ch);
    Null:Case(Scan)of{- Touche �tendue -}
     LeftArrow:      CursorLeft;          RtArrow:        CursorRight;
     CtrlLeftArrow:  WordLeft;            CtrlRtArrow:    WordRight;
     HomeKey:        CursorHome;          EndKey:         CursorEnd;
     CtrlHome:       DeleteHome;          CtrlEnd:        DeleteEnd;
     DeleteKey:      DeleteChar;          InsertKey:      ToggleMode;
     UpArrow:        PrevCommand;         DownArrow:      NextCommand;
     CtrlPgDn:       ClearCommand;        CtrlPgUp:       ClearQueue;
     F1:             Help;                Else            MacroReturn;
    End;
   End;
  End;
 Until No;
End;

{様様様様様様様様様様様様様様様様� Shell 様様様様様様様様様様様様様様様様�}
{ Set Sp for Exec Call to avoid our interrupt service stack, then Exec    }
{ COMMAND.COM, looking first on Drive C and then on Drive A.  One could   }
{ also scan the environment block to find the current COMSPEC (even       }
{ though the memory block has been released), but the present method is   }
{ considerably simpler.  On return from Exec, restore original interrupt. }
{様様様様様様様様様様様様様様様様� Shell 様様様様様様様様様様様様様様様様�}
{$IFDEF Shell}    {- Avoid unneeded data ErrMsg IFNDEF Shell -}
Procedure Shell;Const ErrMsg:String[27]='A:\COMMAND.COM Introuvable'#10;Begin
 SetSpLow;{ Fixe le registre processeur SP au plus bas pour assurer que la
            pile ne retourne pas un recouvrement d'ex�cutable. }
 Exec('C:\COMMAND.COM','');
 If DosError<>0Then Exec('A:\COMMAND.COM','');
 If DosError<>0Then WriteSubStr(ErrMsg,1,Length(ErrMsg));
 Dos21_0A.Irestore;
{- NOTE that Sp is restored by the standard PROCEDURE exit code -}
End;
{$ENDIF}

{様様様様様様様様様様様様様様様様様 MAIN 様様様様様様様様様様様様様様様様�}
{ Initialize Command Queue and set PascalCode Pointer to @ServiceProc.    }
{ Release unneeded environment block, then Shell or go resident.          }
{様様様様様様様様様様様様様様様様様 MAIN 様様様様様様様様様様様様様様様様�}
BEGIN {- Ajustement du programme principal -}
 Qtail:=@CmdQ;QPtr:=QTail;MemW[Dseg:Ofs(CmdQ)]:=0;
 Dos21_0A.PascalCode:=@ServiceProc;
 ASM
  MOV Es,PrefixSeg
  Mov Es,Es:[$2C] {Seg to release }
  Mov Ah,$49
  Int $21
 END;
 {$IFDEF Shell}
  Shell;
 {$ELSE}
  Keep(0);
 {$ENDIF}
END.
