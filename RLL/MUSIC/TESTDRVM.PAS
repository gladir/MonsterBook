Program TestDrvMod;

{$M 16384,0,0 }

Uses Dos,Memory;

Var TableInt : Array[0..255] of Pointer Absolute 0000:0000;

Procedure LoadOvl;
Assembler;
ASM
 MOV AH,$01;
 INT $8C;
END;

Procedure AskInit;
Assembler;
ASM
 MOV AH,$03;
 INT $8C;
END;

Procedure Initialise;
Assembler;
ASM
 MOV AH,$04;
 INT $8C;
END;

Procedure LoadModule(Name:PathStr);
Var _Seg,_Ofs : Word;
Begin
 _Seg := Seg(Name);
 _Ofs := Ofs(Name);
 ASM
  MOV DI,_Ofs;
  MOV ES,_Seg;
  MOV AH,$05;
  INT $8C;
 END;
End;

Procedure StartPlaying;
Assembler;
ASM
 MOV AH,$06;
 INT $8C;
END;

Procedure StopPlaying;
Assembler;
ASM
 MOV AH,$08;
 INT $8C;
END;

Procedure DeAlloc;
Assembler;
ASM
 MOV AH,$09;
 INT $8C;
END;

Procedure RemoveOvl;
Assembler;
ASM
 MOV AH,$0A;
 INT $8C;
END;

Function Error:Byte;
Assembler;
ASM
 MOV AX,$FEFF;
 INT $8C;
END;

Function Unload:Boolean;
Assembler;
ASM
 MOV AH,$FF;
 INT $8C;
END;

Function KeyPressed:Boolean;
Begin
 KeyPressed := Not(MemW[$0040:$001A] = MemW[$0040:$001C]);
End;

Var SizeK,SegAlloc : Word;
    T              : Integer;
    SizeFree       : LongInt;
    X              : Pointer;

Const SizeMod = 179200;

BEGIN
 ASM
  MOV AH,$48;
  MOV BX,$FFFF;
  INT $21;
  MOV SizeK,BX;
 END;
 SizeFree := (LongInt(SizeK) * 16) - (40 * 1024) - (25 * 1024) - SizeMod;
 T := (SizeFree div 16) - 64;
 If(T > 0)Then
 Begin
  ASM
   MOV AH,$48;
   MOV BX,T;
   INT $21;
   MOV SegAlloc,AX;
  END;
  HeapOrg  := Ptr(SegAlloc,0);
  FreeList := HeapOrg;
  HeapPtr  := HeapOrg;
  HeapEnd  := Ptr(SegAlloc + T - 1,0);
  GetMem(X,1000);
 End
  Else
 SegAlloc := 0;
 Exec('DRVMOD.EXE','/MALTE');
 WriteLn(DosError);
 If Not(TableInt[$8C] = NIL)Then
 Begin
  WriteLn('Chargement r‚ussit!');
  LoadOvl;
  WriteLn(Error);
  AskInit;
  Initialise;
  LoadModule('C:\MUSIC\MOD\BETWEEN.MOD');
  StartPlaying;
  Repeat Until Keypressed;
  StopPlaying;
  DeAlloc;
  RemoveOvl;
  If Not(Unload)Then WriteLn('Impossible d''Unload');
 End
  Else
 WriteLn('Impossible de charger le driver.');
 If(SegAlloc > 0)Then
 Begin
  ASM
   MOV AH,$49;
   MOV ES,SegAlloc;
   INT $21;
  END;
 End;
END.