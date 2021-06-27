Unit Keyboard;

INTERFACE

Var
 Key:Array[0..127]of Boolean;

Procedure InitInt09;
Procedure RestoreInt09;

IMPLEMENTATION

Uses Systex,Systems;

Var
 AnyPressed:Boolean;
 OldInt09:Pointer;

Procedure RestoreInt09;Begin
 SetIntVec($09,OldInt09);
End;

Procedure ExternProcessus;
Const
 MaxKeyTable=93;
 KeyTable:Array[0..MaxKeyTable]of Word=(
  0,                { 00 - Nulle }
  kbEsc,            { 01 - Escape }
  Byte('1'),        { 02 - 1 }
  Byte('2'),        { 03 - 2 }
  Byte('3'),        { 04 - 3 }
  Byte('4'),        { 05 - 4 }
  Byte('5'),        { 06 - 5 }
  Byte('6'),        { 07 - 6 }
  Byte('7'),        { 08 - 7 }
  Byte('8'),        { 09 - 8 }
  Byte('9'),        { 0A - 9 }
  Byte('0'),        { 0B - 0 }
  Byte('-'),        { 0C - - }
  Byte('='),        { 0D - = }
  kbBS,             { 0E - BackSpace }
  kbTab,            { 0F - Tabulation }
  Byte('Q'),        { 10 - Q }
  Byte('W'),        { 11 - W }
  Byte('E'),        { 12 - E }
  Byte('R'),        { 13 - R }
  Byte('T'),        { 14 - T }
  Byte('Y'),        { 15 - Y }
  Byte('U'),        { 16 - U }
  Byte('I'),        { 17 - I }
  Byte('O'),        { 18 - O }
  Byte('P'),        { 19 - P }
  Byte('['),        { 1A - ] }
  Byte(']'),        { 1B - ] }
  kbEnter,          { 1C - Enter }
  0,                { 1D - Ctrl }
  Byte('A'),        { 1E - A }
  Byte('S'),        { 1F - S }
  Byte('D'),        { 20 - D }
  Byte('F'),        { 21 - F }
  Byte('G'),        { 22 - G }
  Byte('H'),        { 23 - H }
  Byte('J'),        { 24 - J }
  Byte('K'),        { 25 - K }
  Byte('L'),        { 26 - L }
  Byte(';'),        { 27 - ; }
  Byte(''''),       { 28 - ' }
  Byte('`'),        { 29 - ` }
  0,                { 2A - Shift de gauche }
  0,                { 2B - Nulle }
  Byte('Z'),        { 2C - Z }
  Byte('X'),        { 2D - X }
  Byte('C'),        { 2E - C }
  Byte('V'),        { 2F - V }
  Byte('B'),        { 30 - B }
  Byte('N'),        { 31 - N }
  Byte('M'),        { 32 - M }
  Byte(','),        { 33 - , }
  Byte('.'),        { 34 - . }
  Byte('/'),        { 35 - / }
  0,                { 36 - Shift de droite }
  Byte('*'),        { 37 - * }
  0,                { 38 - Alt }
  Byte(' '),        { 39 - Barre d'espacement }
  0,                { 3A - CapsLock }
  kbF1,             { 3B - F1 }
  kbF2,             { 3C - F2 }
  kbF3,             { 3D - F3 }
  kbF4,             { 3E - F4 }
  kbF5,             { 3F - F5 }
  kbF6,             { 40 - F6 }
  kbF7,             { 41 - F7 }
  kbF8,             { 42 - F8 }
  kbF9,             { 43 - F9 }
  kbF10,            { 44 - F10 }
  0,                { 45 - NumLock }
  0,                { 46 - ScrollLock }
  kbHome,           { 47 - Home }
  kbUp,             { 48 - Up }
  kbPgUp,           { 49 - PageUp }
  0,                { 4A - Nulle }
  kbLeft,           { 4B - Gauche }
  kbKeypad5,        { 4C - 5 du bloc num‚rique }
  kbRight,          { 4D - Droite }
  kbGrayPlus,       { 4E - + }
  kbEnd,            { 4F - End }
  kbDn,             { 50 - Bas }
  kbPgDn,           { 51 - PageDown }
  kbIns,            { 52 - Insert }
  kbDel,            { 53 - Delete }
  0,                { 54 - SysReq }
  0,                { 55 - Nulle }
  Byte('\'),        { 56 - \ (101/102 touches seulement) }
  kbF11,            { 57 - F11 (101/102 touches seulement) }
  kbF12,            { 58 - F12 (101/102 touches seulement) }
  0,                { 59 - Nulle }
  0,                { 5A - PA1 (122 touches seulement) }
  kbWindows95Left,  { 5B - F13 (122 touches seulement) ou Windows Left }
  kbWindows95Right, { 5C - F14 (122 touches seulement) ou Windows Right }
  kbWindows95Menu   { 5D - F15 (122 touches seulement) ou Windows Menu }
 );
 KeyTableAlt:Array[0..MaxKeyTable]of Word=(
  0,                { 00 - Nulle }
  kbAltEsc,         { 01 - Escape }
  kbAlt1,           { 02 - 1 }
  kbAlt2,           { 03 - 2 }
  kbAlt3,           { 04 - 3 }
  kbAlt4,           { 05 - 4 }
  kbAlt5,           { 06 - 5 }
  kbAlt6,           { 07 - 6 }
  kbAlt7,           { 08 - 7 }
  kbAlt8,           { 09 - 8 }
  kbAlt9,           { 0A - 9 }
  kbAlt0,           { 0B - 0 }
  kbAltMinus,       { 0C - - }
  kbAltEqual,       { 0D - = }
  kbAltBS,          { 0E - BackSpace }
  kbTab,            { 0F - Tabulation }
  kbAltQ,           { 10 - Q }
  kbAltW,           { 11 - W }
  kbAltE,           { 12 - E }
  kbAltR,           { 13 - R }
  kbAltT,           { 14 - T }
  kbAltY,           { 15 - Y }
  kbAltU,           { 16 - U }
  kbAltI,           { 17 - I }
  kbAltO,           { 18 - O }
  kbAltP,           { 19 - P }
  kbAltOpenBox,     { 1A - ] }
  kbAltOpenBox,     { 1B - ] }
  kbAltEnter,       { 1C - Enter }
  0,                { 1D - Ctrl }
  kbAltA,           { 1E - A }
  kbAltS,           { 1F - S }
  kbAltD,           { 20 - D }
  kbAltF,           { 21 - F }
  kbAltG,           { 22 - G }
  kbAltH,           { 23 - H }
  kbAltJ,           { 24 - J }
  kbAltK,           { 25 - K }
  kbAltL,           { 26 - L }
  Byte(';'),        { 27 - ; }
  kbAltQuote,       { 28 - ' }
  kbAltEnviron,     { 29 - ` }
  0,                { 2A - Shift de gauche }
  0,                { 2B - Nulle }
  kbAltZ,           { 2C - Z }
  kbAltX,           { 2D - X }
  kbAltC,           { 2E - C }
  kbAltV,           { 2F - V }
  kbAltB,           { 30 - B }
  kbAltN,           { 31 - N }
  kbAltM,           { 32 - M }
  kbAltLess,        { 33 - , }
  kbAltGreat,       { 34 - . }
  kbAltQuestion,    { 35 - / }
  0,                { 36 - Shift de droite }
  kbAltMult,        { 37 - * }
  0,                { 38 - Alt }
  kbAltSpc,         { 39 - Barre d'espacement }
  0,                { 3A - CapsLock }
  kbAltF1,          { 3B - F1 }
  kbAltF2,          { 3C - F2 }
  kbAltF3,          { 3D - F3 }
  kbAltF4,          { 3E - F4 }
  kbAltF5,          { 3F - F5 }
  kbAltF6,          { 40 - F6 }
  kbAltF7,          { 41 - F7 }
  kbAltF8,          { 42 - F8 }
  kbAltF9,          { 43 - F9 }
  kbAltF10,         { 44 - F10 }
  0,                { 45 - NumLock }
  0,                { 46 - ScrollLock }
  kbHome,           { 47 - Home }
  kbUp,             { 48 - Up }
  kbPgUp,           { 49 - PageUp }
  0,                { 4A - Nulle }
  kbLeft,           { 4B - Gauche }
  kbKeypad5,        { 4C - 5 du bloc num‚rique }
  kbRight,          { 4D - Droite }
  kbAltGrayMinus,   { 4E - + }
  kbEnd,            { 4F - End }
  kbDn,             { 50 - Bas }
  kbPgDn,           { 51 - PageDown }
  kbIns,            { 52 - Insert }
  kbDel,            { 53 - Delete }
  0,                { 54 - SysReq }
  0,                { 55 - Nulle }
  kbAltBkSl,        { 56 - \ (101/102 touches seulement) }
  kbAltF11,         { 57 - F11 (101/102 touches seulement) }
  kbAltF12,         { 58 - F12 (101/102 touches seulement) }
  0,                { 59 - Nulle }
  0,                { 5A - PA1 (122 touches seulement) }
  kbWindows95Left,  { 5B - F13 (122 touches seulement) ou Windows Left }
  kbWindows95Right, { 5C - F14 (122 touches seulement) ou Windows Right }
  kbAltWindows95Menu{ 5D - F15 (122 touches seulement) ou Windows Menu }
 );
 KeyTableCtrl:Array[0..MaxKeyTable]of Word=(
  0,                { 00 - Nulle }
  kbCtrlEsc,        { 01 - Escape }
  Byte('1'),        { 02 - 1 }
  kbCtrl2,          { 03 - 2 }
  Byte('3'),        { 04 - 3 }
  Byte('4'),        { 05 - 4 }
  Byte('5'),        { 06 - 5 }
  Byte('6'),        { 07 - 6 }
  Byte('7'),        { 08 - 7 }
  Byte('8'),        { 09 - 8 }
  Byte('9'),        { 0A - 9 }
  Byte('0'),        { 0B - 0 }
  kbCtrlMinus,      { 0C - - }
  Byte('='),        { 0D - = }
  kbCtrlBS,         { 0E - BackSpace }
  kbTab,            { 0F - Tabulation }
  kbCtrlQ,          { 10 - Q }
  kbCtrlW,          { 11 - W }
  kbCtrlE,          { 12 - E }
  kbCtrlR,          { 13 - R }
  kbCtrlT,          { 14 - T }
  kbCtrlY,          { 15 - Y }
  kbCtrlU,          { 16 - U }
  kbCtrlI,          { 17 - I }
  kbCtrlO,          { 18 - O }
  kbCtrlP,          { 19 - P }
  kbCtrlOpenBox,    { 1A - ] }
  kbCtrlOpenBox,    { 1B - ] }
  kbCtrlEnter,      { 1C - Enter }
  0,                { 1D - Ctrl }
  kbCtrlA,          { 1E - A }
  kbCtrlS,          { 1F - S }
  kbCtrlD,          { 20 - D }
  kbCtrlF,          { 21 - F }
  kbCtrlG,          { 22 - G }
  kbCtrlH,          { 23 - H }
  kbCtrlJ,          { 24 - J }
  kbCtrlK,          { 25 - K }
  kbCtrlL,          { 26 - L }
  Byte(';'),        { 27 - ; }
  Byte(''''),       { 28 - ' }
  Byte('`'),        { 29 - ` }
  0,                { 2A - Shift de gauche }
  0,                { 2B - Nulle }
  kbCtrlZ,          { 2C - Z }
  kbCtrlX,          { 2D - X }
  kbCtrlC,          { 2E - C }
  kbCtrlV,          { 2F - V }
  kbCtrlB,          { 30 - B }
  kbCtrlN,          { 31 - N }
  kbCtrlM,          { 32 - M }
  Byte(','),        { 33 - , }
  Byte('.'),        { 34 - . }
  Byte('/'),        { 35 - / }
  0,                { 36 - Shift de droite }
  Byte('*'),        { 37 - * }
  0,                { 38 - Alt }
  Byte(' '),        { 39 - Barre d'espacement }
  0,                { 3A - CapsLock }
  kbCtrlF1,         { 3B - F1 }
  kbCtrlF2,         { 3C - F2 }
  kbCtrlF3,         { 3D - F3 }
  kbCtrlF4,         { 3E - F4 }
  kbCtrlF5,         { 3F - F5 }
  kbCtrlF6,         { 40 - F6 }
  kbCtrlF7,         { 41 - F7 }
  kbCtrlF8,         { 42 - F8 }
  kbCtrlF9,         { 43 - F9 }
  kbCtrlF10,        { 44 - F10 }
  0,                { 45 - NumLock }
  0,                { 46 - ScrollLock }
  kbCtrlHome,       { 47 - Home }
  kbCtrlUp,         { 48 - Up }
  kbCtrlPgUp,       { 49 - PageUp }
  0,                { 4A - Nulle }
  kbCtrlLeft,       { 4B - Gauche }
  kbKeypad5,        { 4C - 5 du bloc num‚rique }
  kbRight,          { 4D - Droite }
  Byte('+'),        { 4E - + }
  kbCtrlEnd,        { 4F - End }
  kbCtrlDn,         { 50 - Bas }
  kbCtrlPgDn,       { 51 - PageDown }
  kbCtrlIns,        { 52 - Insert }
  kbCtrlDel,        { 53 - Delete }
  0,                { 54 - SysReq }
  0,                { 55 - Nulle }
  kbCtrlBkSl,       { 56 - \ (101/102 touches seulement) }
  kbCtrlF11,        { 57 - F11 (101/102 touches seulement) }
  kbCtrlF12,        { 58 - F12 (101/102 touches seulement) }
  0,                { 59 - Nulle }
  0,                { 5A - PA1 (122 touches seulement) }
  kbWindows95Left,  { 5B - F13 (122 touches seulement) ou Windows Left }
  kbWindows95Right, { 5C - F14 (122 touches seulement) ou Windows Right }
  kbCtrlWindows95Menu{5D - F15 (122 touches seulement) ou Windows Menu }
 );
 KeyTableShift:Array[0..MaxKeyTable]of Word=(
  0,                { 00 - Nulle }
  kbShiftEsc,       { 01 - Escape }
  Byte('!'),        { 02 - 1 }
  Byte('@'),        { 03 - 2 }
  Byte('#'),        { 04 - 3 }
  Byte('$'),        { 05 - 4 }
  Byte('%'),        { 06 - 5 }
  Byte('^'),        { 07 - 6 }
  Byte('&'),        { 08 - 7 }
  Byte('*'),        { 09 - 8 }
  Byte('('),        { 0A - 9 }
  Byte(')'),        { 0B - 0 }
  Byte('_'),        { 0C - - }
  Byte('+'),        { 0D - = }
  kbBS,             { 0E - BackSpace }
  kbShiftTab,       { 0F - Tabulation }
  Byte('Q'),        { 10 - Q }
  Byte('W'),        { 11 - W }
  Byte('E'),        { 12 - E }
  Byte('R'),        { 13 - R }
  Byte('T'),        { 14 - T }
  Byte('Y'),        { 15 - Y }
  Byte('U'),        { 16 - U }
  Byte('I'),        { 17 - I }
  Byte('O'),        { 18 - O }
  Byte('P'),        { 19 - P }
  Byte('{'),        { 1A - [ }
  Byte('}'),        { 1B - ] }
  kbEnter,          { 1C - Enter }
  0,                { 1D - Ctrl }
  Byte('A'),        { 1E - A }
  Byte('S'),        { 1F - S }
  Byte('D'),        { 20 - D }
  Byte('F'),        { 21 - F }
  Byte('G'),        { 22 - G }
  Byte('H'),        { 23 - H }
  Byte('J'),        { 24 - J }
  Byte('K'),        { 25 - K }
  Byte('L'),        { 26 - L }
  Byte(':'),        { 27 - ; }
  Byte('"'),        { 28 - ' }
  Byte('~'),        { 29 - ` }
  0,                { 2A - Shift de gauche }
  0,                { 2B - Nulle }
  Byte('Z'),        { 2C - Z }
  Byte('X'),        { 2D - X }
  Byte('C'),        { 2E - C }
  Byte('V'),        { 2F - V }
  Byte('B'),        { 30 - B }
  Byte('N'),        { 31 - N }
  Byte('M'),        { 32 - M }
  Byte('<'),        { 33 - , }
  Byte('>'),        { 34 - . }
  Byte('/'),        { 35 - / }
  0,                { 36 - Shift de droite }
  Byte('*'),        { 37 - * }
  0,                { 38 - Alt }
  Byte(' '),        { 39 - Barre d'espacement }
  0,                { 3A - CapsLock }
  kbShiftF1,        { 3B - F1 }
  kbShiftF2,        { 3C - F2 }
  kbShiftF3,        { 3D - F3 }
  kbShiftF4,        { 3E - F4 }
  kbShiftF5,        { 3F - F5 }
  kbShiftF6,        { 40 - F6 }
  kbShiftF7,        { 41 - F7 }
  kbShiftF8,        { 42 - F8 }
  kbShiftF9,        { 43 - F9 }
  kbShiftF10,       { 44 - F10 }
  0,                { 45 - NumLock }
  0,                { 46 - ScrollLock }
  kbHome,           { 47 - Home }
  kbUp,             { 48 - Up }
  kbPgUp,           { 49 - PageUp }
  0,                { 4A - Nulle }
  kbLeft,           { 4B - Gauche }
  kbKeypad5,        { 4C - 5 du bloc num‚rique }
  kbRight,          { 4D - Droite }
  Byte('+'),        { 4E - + }
  kbEnd,            { 4F - End }
  kbDn,             { 50 - Bas }
  kbPgDn,           { 51 - PageDown }
  kbShiftIns,       { 52 - Insert }
  kbShiftDel,       { 53 - Delete }
  0,                { 54 - SysReq }
  0,                { 55 - Nulle }
  Byte('|'),        { 56 - \ (101/102 touches seulement) }
  kbShiftF11,       { 57 - F11 (101/102 touches seulement) }
  kbShiftF12,       { 58 - F12 (101/102 touches seulement) }
  0,                { 59 - Nulle }
  0,                { 5A - PA1 (122 touches seulement) }
  kbWindows95Left,  { 5B - F13 (122 touches seulement) ou Windows Left }
  kbWindows95Right, { 5C - F14 (122 touches seulement) ou Windows Right }
  kbShiftWindows95Menu{5D - F15 (122 touches seulement) ou Windows Menu }
 );
Var
 K:Word;
 I:Byte;
 ShiftState:Byte;
Begin
 K:=0;
 ShiftState:=Mem[_0040:$17];
 If Key[rqkCtrl]and Key[rqkAlt]Then Begin
  If Key[rqkDel]Then ASM
   INT 19h
  END;
  If Key[rqkEsc]Then K:=kbCtrlAltEsc;
 End
  Else
 If Key[rqkAlt]Then Begin
  For I:=1to(MaxKeyTable)do Begin
   If Key[I]Then K:=K or KeyTableAlt[I];
  End;
 End
  Else
 If Key[rqkCtrl]Then Begin
  For I:=1to(MaxKeyTable)do Begin
   If Key[I]Then K:=K or KeyTableCtrl[I];
  End;
 End
  Else
 If Key[rqkShiftLeft]or Key[rqkShiftRight]Then Begin
  For I:=1to(MaxKeyTable)do Begin
   If Key[I]Then K:=K or KeyTableShift[I];
  End;
 End
  Else
 Begin
  For I:=1to(MaxKeyTable)do Begin
   If Key[I]Then K:=K or KeyTable[I];
  End;
  If(Char(K)in['A'..'Z'])and
    (Not((ShiftState and $40=$40)xor((ShiftState and 3)>0)))Then Inc(K,32);
 End;
 If K>0Then PushKey(K);
End;

Procedure NewInt09;Interrupt;Assembler;ASM
 STI
 XOR CH,CH
 MOV DX,060h
 IN  AL,DX
 MOV CL,AL
 AND CL,07Fh
 MOV BX,Offset Key
 ADD BX,CX
 MOV SI,BX
 {$IFOPT G+}
  SHR AL,7
 {$ELSE}
  ROL AL,1
  AND AL,1
 {$ENDIF}
 XOR AL,1
 MOV [SI],AL
 MOV AnyPressed,AL
 MOV DX,061h
 IN  AL,DX
 MOV CL,AL
 OR  AL,080h
 OUT DX,AL
 MOV AL,CL
 OUT DX,AL
 MOV AX,020h
 MOV DX,AX
 OUT DX,AX
 CALL ExternProcessus
 CLI
END;

Procedure InitInt09;Begin
 GetIntVec($09,OldInt09);
 SetIntVec($09,@NewInt09);
 FillClr(Key,SizeOf(Key));
End;

END.