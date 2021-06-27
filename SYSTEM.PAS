
{*******************************************************}
{                                                       }
{       Turbo Pascal Runtime Library                    }
{       System Unit                                     }
{                                                       }
{       Copyright (C) 1988,92 Borland International     }
{                                                       }
{*******************************************************}

unit System;

{ This unit implements Turbo Pascal's runtime library. When compiling
  this unit, the compiler automatically includes a boot-strap symbol
  table (SYSTEM.TPS) which declares all built-in types, procedures, and
  functions. }

{$IFDEF DPMI}
{$C FIXED PRELOAD PERMANENT}
{$ENDIF}

{$IFDEF WINDOWS}
{$C MOVEABLE PRELOAD PERMANENT}
{$ENDIF}

{$IFDEF MSDOS}

{$L MAIN.OBJ}		{ Main module }
{$L HEAP.OBJ}		{ Heap manager }
{$L ERRC.OBJ}		{ Error check routines }
{$L EI86.OBJ}		{ Software emulator initialization }
{$L EI87.OBJ}		{ Hardware emulator initialization }
{$L EM86.OBJ}		{ Software 80x87 emulator }
{$L EM87.OBJ}		{ Hardware 80x87 emulator }
{$L F87H.OBJ}		{ 80x87 support routines }

{$ENDIF}

{$IFDEF DPMI}

{$L DAPP.OBP}		{ DPMI application main module }
{$L DLIB.OBP}		{ DPMI library main module }
{$L DEND.OBP}		{ DPMI termination procedures }
{$L WMEM.OBP}		{ DPMI heap manager }
{$L ERRC.OBP}		{ Error check routines }
{$L EI86.OBP}		{ Software emulator initialization }
{$L EI87.OBP}		{ Hardware emulator initialization }
{$L EM86.OBP}		{ Software 80x87 emulator }
{$L EM87.OBP}		{ Hardware 80x87 emulator }
{$L F87H.OBP}		{ 80x87 support routines }

{$ENDIF}

{$IFNDEF Windows}

{$L OBJH.OBJ}		{ Object handling routines }
{$L DF87.OBJ}		{ 80x87 Binary/Decimal routines }
{$L TCTL.OBJ}		{ Textfile control routines }
{$L TGPC.OBJ}		{ Textfile low-level I/O }
{$L TCHR.OBJ}		{ Textfile character I/O }
{$L TPCH.OBJ}		{ Textfile character array I/O}
{$L TSTR.OBJ}		{ Textfile string I/O }
{$L TBOL.OBJ}		{ Textfile boolean I/O }
{$L TINT.OBJ}		{ Textfile integer I/O }
{$L TF48.OBJ}		{ Textfile real I/O }
{$L TF87.OBJ}		{ Textfile 80x87 I/O }
{$L TFUN.OBJ}		{ Textfile support functions }
{$L FCTL.OBJ}		{ File control routines }
{$L FDIR.OBJ}		{ File utility routines }
{$L CINT.OBJ}		{ Integer Str/Val routines }
{$L CF48.OBJ}		{ Real Str/Val routines }
{$L CF87.OBJ}		{ 80x87 Str/Val routines }
{$L PARS.OBJ}		{ Command line parameter routines }
{$L DIRH.OBJ}		{ Directory handling routines }

{$ELSE}

{$L WAPP.OBW}		{ Windows application main module }
{$L WLIB.OBW}		{ Windows library main module }
{$L WEND.OBW}		{ Windows termination procedures }
{$L WMEM.OBW}		{ Windows heap manager }
{$L ERRC.OBW}		{ Error check routines }
{$L OBJH.OBW}		{ Object handling routines }
{$L DF87.OBW}		{ 80x87 Binary/Decimal routines }
{$L TCTL.OBW}		{ Textfile control routines }
{$L TGPC.OBW}		{ Textfile low-level I/O }
{$L TCHR.OBW}		{ Textfile character I/O }
{$L TSTR.OBW}		{ Textfile string I/O }
{$L TPCH.OBW}		{ Textfile character array I/O}
{$L TBOL.OBW}		{ Textfile boolean I/O }
{$L TINT.OBW}		{ Textfile integer I/O }
{$L TF48.OBW}		{ Textfile real I/O }
{$L TF87.OBW}		{ Textfile 80x87 I/O }
{$L TFUN.OBW}		{ Textfile support functions }
{$L FCTL.OBW}		{ File control routines }
{$L FDIR.OBW}		{ File utility routines }
{$L CINT.OBW}		{ Integer Str/Val routines }
{$L CF48.OBW}		{ Real Str/Val routines }
{$L CF87.OBW}		{ 80x87 Str/Val routines }
{$L WPAR.OBW}		{ Command line parameter routines }
{$L DIRH.OBW}		{ Directory handling routines }
{$L WI87.OBW}		{ 80x87 initialization }
{$L WX87.OBW}		{ 80x87 exception handler }
{$L WE87.OBW}		{ 80x87 support routines }
{$L WF87.OBJ}		{ 80x87 transcendental routines }

{$ENDIF}

{$L VARH.OBJ}		{ Variable support routines }
{$L LONG.OBJ}		{ Longint arithmetic routines }
{$L LOVF.OBJ}		{ Longint arith with overflow checks }
{$L STRH.OBJ}		{ String support routines }
{$L SETH.OBJ}		{ Set support routines }
{$L TFIO.OBJ}		{ Textfile open routine }
{$L FP48.OBJ}		{ Real kernel routines }
{$L F48H.OBJ}		{ Real support routines }
{$L F48F.OBJ}		{ Real standard functions }
{$L RAND.OBJ}		{ Random number generator }
{$L DINT.OBJ}		{ Integer Binary/Decimal routines }
{$L DF48.OBJ}		{ Real Binary/Decimal routines }
{$L SINT.OBJ}		{ Integer Str/Val routines }
{$L SF48.OBJ}		{ Real Str/Val routines }
{$L SF87.OBJ}		{ 80x87 Str/Val routines }
{$L FFUN.OBJ}		{ File support functions }
{$L MEMH.OBJ}		{ Block move and fill routines }
{$L CHAR.OBJ}		{ Character handling routines }
{$L DMTH.OBJ}		{ Dynamic method call dispatcher }

{$IFDEF MSDOS}

{$L LAST.OBJ}		{ Data segment initialization }

{$ENDIF}

interface

{ Initialized public variables. The compiler depends upon the order
  of declaration of the following typed constants, so it must not be
  changed. In addition, the following declaration section must be the
  first "const" section in this unit. }

const

{$IFDEF MSDOS}

  OvrCodeList: Word = 0;	{ Overlay code segment list }
  OvrHeapSize: Word = 0;	{ Initial overlay buffer size }
  OvrDebugPtr: Pointer = nil;	{ Overlay debugger hook }
  OvrHeapOrg: Word = 0;		{ Overlay buffer origin }
  OvrHeapPtr: Word = 0;		{ Overlay buffer pointer }
  OvrHeapEnd: Word = 0;		{ Overlay buffer end }
  OvrLoadList: Word = 0;	{ Loaded overlays list }
  OvrDosHandle: Word = 0;	{ Overlay DOS handle }
  OvrEmsHandle: Word = $FFFF;	{ Overlay EMS handle }
  HeapOrg: Pointer = nil;	{ Heap origin }
  HeapPtr: Pointer = nil;	{ Heap pointer }
  HeapEnd: Pointer = nil;	{ Heap end }
  FreeList: Pointer = nil;	{ Free list pointer }
  FreeZero: Pointer = nil;	{ Must be zero }
  HeapError: Pointer = nil;	{ Heap error function }
  ExitProc: Pointer = nil;	{ Exit procedure }
  ExitCode: Integer = 0;	{ Exit code }
  ErrorAddr: Pointer = nil;	{ Runtime error address }
  PrefixSeg: Word = 0;		{ Program segment prefix }
  StackLimit: Word = 0;		{ Stack pointer low limit }
  InOutRes: Integer = 0;	{ I/O result buffer }
  RandSeed: Longint = 0;	{ Random seed }
  SelectorInc: Word = $1000;	{ Selector increment }
  Seg0040: Word = $0040;	{ Selector for segment $0040 }
  SegA000: Word = $A000;	{ Selector for segment $A000 }
  SegB000: Word = $B000;	{ Selector for segment $B000 }
  SegB800: Word = $B800;	{ Selector for segment $B800 }
  Test8086: Byte = 0;		{ 80x86 test result }
  Test8087: Byte = 0;		{ 80x87 test result }
  FileMode: Byte = 2;		{ File open mode }

{$ENDIF}

{$IFDEF DPMI}

  HInstance: Word = 0;		{ Module instance handle }
  HeapList: Word = 0;		{ Heap segment list }
  HeapLimit: Word = 1024;	{ Heap small block limit }
  HeapBlock: Word = 8192;	{ Heap block size }
  HeapAllocFlags: Word = 2;	{ Heap allocation flags, gmem_Moveable }
  HeapError: Pointer = nil;	{ Heap error function }
  ExitProc: Pointer = nil;	{ Exit procedure }
  ExitCode: Integer = 0;	{ Exit code }
  ErrorAddr: Pointer = nil;	{ Runtime error address }
  PrefixSeg: Word = 0;		{ Program segment prefix }
  InOutRes: Integer = 0;	{ I/O result buffer }
  RandSeed: Longint = 0;	{ Random seed }
  SelectorInc: Word = 0;	{ Selector increment }
  Seg0040: Word = 0;		{ Selector for segment $0040 }
  SegA000: Word = 0;		{ Selector for segment $A000 }
  SegB000: Word = 0;		{ Selector for segment $B000 }
  SegB800: Word = 0;		{ Selector for segment $B800 }
  Test8086: Byte = 0;		{ 80x86 test result }
  Test8087: Byte = 0;		{ 80x87 test result }
  FileMode: Byte = 2;		{ File open mode }

{$ENDIF}

{$IFDEF Windows}

  HPrevInst: Word = 0;		{ Handle of previous instance }
  HInstance: Word = 0;		{ Handle of this instance }
  CmdShow: Integer = 0;		{ CmdShow parameter for CreateWindow }
  CmdLine: PChar = nil;		{ Command line pointer }
  HeapList: Word = 0;		{ Heap segment list }
  HeapLimit: Word = 1024;	{ Heap small block limit }
  HeapBlock: Word = 8192;	{ Heap block size }
  HeapAllocFlags: Word = 2;	{ Heap allocation flags, gmem_Moveable }
  HeapError: Pointer = nil;	{ Heap error function }
  ExitProc: Pointer = nil;	{ Exit procedure }
  ExitCode: Integer = 0;	{ Exit code }
  ErrorAddr: Pointer = nil;	{ Runtime error address }
  PrefixSeg: Word = 0;		{ Program segment prefix }
  InOutRes: Integer = 0;	{ I/O result buffer }
  RandSeed: Longint = 0;	{ Random seed }
  SelectorInc: Word = 0;	{ Selector increment }
  Test8086: Byte = 0;		{ 80x86 test result }
  FileMode: Byte = 2;		{ File open mode }

{$ENDIF}

{ Uninitialized public variables. The compiler depends upon the	order
  of declaration of the following variables, so it must not be changed.
  In addition, the following declaration section must be the first "var"
  section in this unit. }

var

  Input: Text;			{ Input standard file }
  Output: Text;			{ Output standard file }

{$IFDEF MSDOS}

  SaveInt00: Pointer;		{ Saved interrupt $00 }
  SaveInt02: Pointer;		{ Saved interrupt $02 }
  SaveInt1B: Pointer;		{ Saved interrupt $1B }
  SaveInt21: Pointer;		{ Saved interrupt $21 }
  SaveInt23: Pointer;		{ Saved interrupt $23 }
  SaveInt24: Pointer;		{ Saved interrupt $24 }
  SaveInt34: Pointer;		{ Saved interrupt $34 }
  SaveInt35: Pointer;		{ Saved interrupt $35 }
  SaveInt36: Pointer;		{ Saved interrupt $36 }
  SaveInt37: Pointer;		{ Saved interrupt $37 }
  SaveInt38: Pointer;		{ Saved interrupt $38 }
  SaveInt39: Pointer;		{ Saved interrupt $39 }
  SaveInt3A: Pointer;		{ Saved interrupt $3A }
  SaveInt3B: Pointer;		{ Saved interrupt $3B }
  SaveInt3C: Pointer;		{ Saved interrupt $3C }
  SaveInt3D: Pointer;		{ Saved interrupt $3D }
  SaveInt3E: Pointer;		{ Saved interrupt $3E }
  SaveInt3F: Pointer;		{ Saved interrupt $3F }
  SaveInt75: Pointer;		{ Saved interrupt $75 }

{$ENDIF}

{$IFDEF DPMI}

  SaveInt00: Pointer;		{ Saved exception $00 }
  SaveInt02: Pointer;		{ Saved interrupt $02 }
  SaveInt0C: Pointer;		{ Saved exception $0C }
  SaveInt0D: Pointer;		{ Saved exception $0D }
  SaveInt1B: Pointer;		{ Saved interrupt $1B }
  SaveInt21: Pointer;		{ Saved interrupt $21 }
  SaveInt23: Pointer;		{ Saved real mode interrupt $23 }
  SaveInt24: Pointer;		{ Saved real mode interrupt $24 }
  SaveInt34: Pointer;		{ Saved interrupt $34 }
  SaveInt35: Pointer;		{ Saved interrupt $35 }
  SaveInt36: Pointer;		{ Saved interrupt $36 }
  SaveInt37: Pointer;		{ Saved interrupt $37 }
  SaveInt38: Pointer;		{ Saved interrupt $38 }
  SaveInt39: Pointer;		{ Saved interrupt $39 }
  SaveInt3A: Pointer;		{ Saved interrupt $3A }
  SaveInt3B: Pointer;		{ Saved interrupt $3B }
  SaveInt3C: Pointer;		{ Saved interrupt $3C }
  SaveInt3D: Pointer;		{ Saved interrupt $3D }
  SaveInt3E: Pointer;		{ Saved interrupt $3E }
  SaveInt3F: Pointer;		{ Saved interrupt $3F }
  SaveInt75: Pointer;		{ Saved interrupt $75 }

  RealModeRegs: array[0..49] of Byte; { Real mode call-back registers }

{$ENDIF}

implementation

{ The following external routines implement all	Turbo Pascal standard
  procedures, functions, and operators. The compiler depends upon the
  order of declaration of these routines, so it must not be changed.
  In addition, these routines must be the first declared by this unit,
  so no procedures and functions can be declared in the interface part.
  The comment following each external directive specifies the .ASM
  module that contains the routine. }

procedure InitTurbo;		external {MAIN/DAPP/WAPP};
procedure HaltError;		external {MAIN/DEND/WEND};
procedure HaltTurbo;		external {MAIN/DEND/WEND};
procedure BlockMove;		external {VARH};
procedure LongMul;		external {LONG};
procedure LongDiv;		external {LONG};
procedure LongShr;		external {LONG};
procedure LongShl;		external {LONG};
procedure LongMulOvf;		external {LOVF};
procedure Overflow;		external {ERRC};
procedure SLoad;		external {STRH};
procedure SStore;		external {STRH};
procedure RangeError;		external {ERRC};
procedure SCopy;		external {STRH};
procedure SConcat;		external {STRH};
procedure SPos;			external {STRH};
procedure SCompare;		external {STRH};
procedure SChar;		external {STRH};
procedure SPacked;		external {STRH};
procedure SInsert;		external {STRH};
procedure SDelete;		external {STRH};
procedure ZLoad;		external {SETH};
procedure ZStore;		external {SETH};
procedure ZBitMask;		external {SETH};
procedure FTrunc;		external {F87H/WE87};
procedure FRound;		external {F87H/WE87};
procedure FInt;			external {F87H/WE87};
procedure FSqrt;		external {F87H/WE87};
procedure FSin;			external {F87H/WE87};
procedure FCos;			external {F87H/WE87};
procedure FArcTan;		external {F87H/WE87};
procedure FLn;			external {F87H/WE87};
procedure FExp;			external {F87H/WE87};
procedure NewPtr;		external {HEAP/WMEM};
procedure DisposePtr;		external {HEAP/WMEM};
procedure MarkPtr;		external {HEAP/WMEM};
procedure ReleasePtr;		external {HEAP/WMEM};
procedure GetFreMem;		external {HEAP/WMEM};
procedure GetFreMax;		external {HEAP/WMEM};
procedure ZWordLoad;		external {SETH};
procedure ZAddComp;		external {SETH};
procedure ZAddRange;		external {SETH};
procedure ZUnion;		external {SETH};
procedure ZDifference;		external {SETH};
procedure ZIntersect;		external {SETH};
procedure ZEqual;		external {SETH};
procedure ZRelation;		external {SETH};
procedure GetParCnt;		external {PARS/WPAR};
procedure GetIORes;		external {ERRC};
procedure InOutCheck;		external {ERRC};
procedure RangeCheck;		external {ERRC};
procedure StackCheck;		external {ERRC};
procedure WriteFloat;		external {TF87};
procedure WriteStr;		external {TSTR};
procedure WriteInt;		external {TINT};
procedure WriteBool;		external {TBOL};
procedure WriteChar;		external {TCHR};
procedure WriteLine;		external {TCTL};
procedure WriteEnd;		external {TCTL};
procedure WriteFile;		external {FCTL};
procedure ReadFloat;		external {TF87};
procedure ReadStr;		external {TSTR};
procedure ReadInt;		external {TINT};
procedure ReadChar;		external {TCHR};
procedure ReadLine;		external {TCTL};
procedure ReadEnd;		external {TCTL};
procedure ReadFile;		external {FCTL};
procedure InitRand;		external {RAND};
procedure AssignText;		external {TCTL};
procedure ResetText;		external {TCTL};
procedure RewriteText;		external {TCTL};
procedure CloseText;		external {TCTL};
procedure AssignFile;		external {FCTL};
procedure ResetFile;		external {FCTL};
procedure RewriteFile;		external {FCTL};
procedure CloseFile;		external {FCTL};
procedure EraseFile;		external {FDIR};
procedure RenameFile;		external {FDIR};
procedure GetSEoln;		external {TFUN};
procedure GetSEof;		external {TFUN};
procedure GetTEoln;		external {TFUN};
procedure GetTEof;		external {TFUN};
procedure ReadBlock;		external {FCTL};
procedure WriteBlock;		external {FCTL};
procedure SeekFile;		external {FCTL};
procedure GetFPos;		external {FFUN};
procedure GetFSize;		external {FFUN};
procedure GetFEof;		external {FFUN};
procedure FFrac;		external {F87H/WE87};
procedure UpperCase;		external {CHAR};
procedure TruncFile;		external {FCTL};
procedure FillMem;		external {MEMH};
procedure RandInt;		external {RAND};
procedure RandFloat;		external {RAND};
procedure GetParStr;		external {PARS/WPAR};
procedure MoveMem;		external {MEMH};
procedure StrInt;		external {SINT};
procedure ValInt;		external {SINT};
procedure StrFloat;		external {SF87};
procedure ValFloat;		external {SF87};
procedure DirGet;		external {DIRH};
procedure DirSet;		external {DIRH};
procedure DirCreate;		external {DIRH};
procedure DirRemove;		external {DIRH};
procedure AppendText;		external {TCTL};
procedure FlushText;		external {TCTL};
procedure BufferText;		external {TCTL};
procedure FRealExt;		external {F87H/WE87};
procedure FExtReal;		external {F87H/WE87};
procedure RAdd;			external {F48H};
procedure RSub;			external {F48H};
procedure RMul;			external {F48H};
procedure RDiv;			external {F48H};
procedure RCmp;			external {F48H};
procedure RFloat;		external {F48H};
procedure RTrunc;		external {F48H};
procedure RRound;		external {F48H};
procedure RSqr;			external {F48H};
procedure WriteReal;		external {TF48};
procedure ReadReal;		external {TF48};
procedure StrReal;		external {SF48};
procedure ValReal;		external {SF48};
procedure RInt;			external {F48F};
procedure RFrac;		external {F48F};
procedure RSqrt;		external {F48F};
procedure RSin;			external {F48F};
procedure RCos;			external {F48F};
procedure RLn;			external {F48F};
procedure RExp;			external {F48F};
procedure RArcTan;		external {F48F};
procedure RandReal;		external {RAND};
procedure InitEM86;		external {EI86/WI87};
procedure InitEM87;		external {EI87/WI87};
procedure Construct;		external {OBJH};
procedure Destruct;		external {OBJH};
procedure CopyObject;		external {OBJH};
procedure MethodCheck;		external {OBJH};
procedure FindMethod;		external {DMTH};
procedure CallMethod;		external {DMTH};
procedure ReadPChar;		external {TPCH};
procedure WritePChar;		external {TPCH};
procedure AssignTextC;		external {TCTL};
procedure AssignFileC;		external {FCTL};
procedure RenameFileC;		external {FDIR};
procedure StrIntC;		external {CINT};
procedure ValIntC;		external {CINT};
procedure StrFloatC;		external {CF87};
procedure ValFloatC;		external {CF87};
procedure StrRealC;		external {CF48};
procedure ValRealC;		external {CF48};

{$IFDEF MSDOS}

procedure LibEntry;		external {MAIN};
procedure LibExit;		external {MAIN};
procedure LibExitProc;		external {MAIN};
procedure InitTask;		external {MAIN};

{$ELSE}

procedure LibEntry;		external {DLIB/WLIB};
procedure LibExit;		external {DLIB/WLIB};
procedure LibExitProc; export;	external {DLIB/WLIB};
procedure InitTask; far;	external 'KERNEL' index $005B;

{$ENDIF}

{ The following routines are used by the runtime library, but they are not
  referenced by the compiler. No particular order of declaration is needed,
  and more routines can be added if required. }

{$IFDEF DPMI}

procedure __AHIncr; far;	external 'KERNEL' index $0072;
procedure __0040H; far;		external 'KERNEL' index $00C1;
procedure __A000H; far;		external 'KERNEL' index $00AE;
procedure __B000H; far;		external 'KERNEL' index $00B5;
procedure __B800H; far;		external 'KERNEL' index $00B6;
procedure MEMallocateBlock; far; external 'RTM' index $0005;
procedure MEMfreeBlock; far;	external 'RTM' index $0006;
procedure MEMqueryFreeMem; far;	external 'RTM' index $0015;

{$ENDIF}

{$IFDEF Windows}

procedure LocalInit; far;	external 'KERNEL' index $0004;
procedure GlobalAlloc; far;	external 'KERNEL' index $000F;
procedure GlobalFree; far;	external 'KERNEL' index $0011;
procedure GlobalLock; far;	external 'KERNEL' index $0012;
procedure GlobalUnlock; far;	external 'KERNEL' index $0013;
procedure GlobalHandle; far;	external 'KERNEL' index $0015;
procedure GlobalCompact; far;	external 'KERNEL' index $0019;
procedure WaitEvent; far;	external 'KERNEL' index $001E;
procedure GetModuleFileName; far; external 'KERNEL' index $0031;
procedure __AHIncr; far;	external 'KERNEL' index $0072;
procedure GetWinFlags; far;	external 'KERNEL' index $0084;
procedure GetFreeSpace; far;	external 'KERNEL' index $00A9;
procedure MessageBox; far;	external 'USER' index $0001;
procedure InitApp; far;		external 'USER' index $0005;
procedure __FPMath; far;	external 'WIN87EM' index $0001;
procedure AnsiToOem; far;	external 'KEYBOARD' index $0005;
procedure OemToAnsi; far;	external 'KEYBOARD' index $0006;

{$ENDIF}

end.
