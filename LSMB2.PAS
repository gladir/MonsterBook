Unit LSMB2;{Language Small Basic-Version 2}

INTERFACE
{$I DEF.INC}
Procedure ExecLSMB2(P:Pointer);

IMPLEMENTATION

Uses {$IFDEF Adele}Adele,{$ELSE}Chantal,{$ENDIF}
     Systex,Systems;

{$F+}
{$I Library\Typemati.Inc}

Procedure ExecLSMB2;Assembler;ASM
 LES DI,P
 MOV Word Ptr @Buf,DI
 MOV Word Ptr @Buf[2],ES
@0:
 CLD
 LES DI,DWord Ptr @Buf
 MOV BL,ES:[DI]
 XOR BH,BH
 MOV Word Ptr @CurrOpCode,BX
 INC DI
 SHL BX,1
 JMP Word Ptr @Label[BX]
@Finish:
 MOV BX,Word Ptr @CurrOpCode
 MOV BL,Byte Ptr @DataSize[BX]
 ADD Word Ptr @Buf,BX
 JMP @0
@CurrOpCode: DW 0
@Buf:        DD 0
@DataSize:
 DB   1,11,11,9, 9,5,3,1, 2,3,5,2, 2,3,2,3 { 00h - 0Fh }
 DB   2, 3, 2,3, 1,1,1,1, 1,1,1,1, 1,1,1,1 { 10h - 1Fh }
 DB   9, 9, 9,9, 6,6,6,6, 3,3,1,1, 0,1,1,1 { 20h - 2Fh }
 DB   2, 2, 2,2, 2,2,2,2, 2,2,2            { 30h - 3Ah }
@Label:
 DW   @End                   { 00h - Arrˆt, fin du programme!}
 DW   @MoveLeft              { 01h - MoveLeft FAR,FAR,Length }
 DW   @MoveRight             { 02h - MoveRight FAR,FAR,Length }
 DW   @FillChar              { 03h - FillChar FAR,Length,Code }
 DW   @FillClr               { 04h - FillClr FAR,Length }
 DW   @CallFar               { 05h - CALL.INTEL FAR }
 DW   @CallNear              { 06h - CALL.INTEL Near }
 DW   @Push0                 { 07h - PUSH 0 }
 DW   @PushByte              { 08h - PUSH Byte }
 DW   @PushByte              { 09h - PUSH Word }
 DW   @PushDWord             { 0Ah - PUSH DoubleWord }
 DW   @PushXByte             { 0Bh - FOR I:=1 to(X)do PUSH Byte[X+1] }
 DW   @ANDByte               { 0Ch - AND PUSHEDBYTE,? }
 DW   @ANDWord               { 0Dh - AND PUSHEDWORD,? }
 DW   @OrByte                { 0Eh - OR  PUSHEDBYTE,? }
 DW   @OrWord                { 0Fh - OR  PUSHEDWORD,? }
 DW   @XorByte               { 10h - XOR PUSHEDBYTE,? }
 DW   @XorWord               { 11h - XOR PUSHEDWORD,? }
 DW   @AddByte               { 12h - ADD PUSHEDBYTE,? }
 DW   @AddWord               { 13h - ADD PUSHEDWORD,? }
 DW   @NotByte               { 14h - NOT PUSHEDBYTE}
 DW   @NotWord               { 15h - NOT PUSHEDWORD}
 DW   @IncByte               { 16h - INC PUSHEDBYTE}
 DW   @IncWord               { 17h - INC PUSHEDWORD}
 DW   @DecByte               { 18h - DEC PUSHEDBYTE}
 DW   @DecWord               { 19h - DEC PUSHEDWORD}
 DW   @Shl1Byte              { 1Ah - SHL PUSHEDBYTE,1}
 DW   @Shl1Word              { 1Bh - SHL PUSHEDWORD,1}
 DW   @Shr1Byte              { 1Ch - SHR PUSHEDBYTE,1}
 DW   @Shr1Word              { 1Dh - SHR PUSHEDWORD,1}
 DW   @End                   { 1Eh - Inutilis‚ }
 DW   @End                   { 1Fh - Inutilis‚ }
 DW   @MoveByte              { 20h - MovByte}
 DW   @MoveWord              { 21h - MovWord}
 DW   @Move3Byte             { 22h - Move3Byte}
 DW   @MoveDWord             { 23h - MoveDWord}
 DW   @MoveByte2SD           { 24h - MOVE FAR,Byte Ptr StackData[Byte] }
 DW   @MoveWord2SD           { 25h - MOVE FAR,Word Ptr StackData[Byte] }
 DW   @MoveSD2Byte           { 26h - MOVE Byte Ptr StackData[Byte],FAR }
 DW   @MoveSD2Word           { 27h - MOVE Word Ptr StackData[Byte],FAR }
 DW   @MoveByteStack2SD      { 28h - MOVE Byte Ptr Stack[Byte],StackData[Byte] }
 DW   @MoveWordStack2SD      { 29h - MOVE Word Ptr Stack[Byte],StackData[Byte] }
 DW   @End                   { 2Ah - Inutilis‚ }
 DW   @End                   { 2Bh - Inutilis‚ }
 DW   @Repeat                { 2Ch - Repeat instruction...  }
 DW   @ExecIntel             { 2Dh - ExecIntel }
 DW   @Finish                { 2Eh - NOP }
 DW   @End                   { 2Fh - Inutilis‚ ... NOP terminant par 0 pour remarque }
 DW   @Memory                { 30h - FUNCTION.MEMORY BYTE}
 DW   @String                { 31h - FUNCTION.STRING BYTE}
 DW   @Clock                 { 32h - FUNCTION.CLOCK BYTE}
 DW   @Sound                 { 33h - FUNCTION.SOUND BYTE}
 DW   @Keyboard              { 34h - FUNCTION.KEYBOARD BYTE}
 DW   @End                   { 35h - FUNCTION.JOYSTICK BYTE}
 DW   @Disk                  { 36h - FUNCTION.DISK BYTE}
 DW   @File                  { 37h - FUNCTION.FILE BYTE}
 DW   @VideoChantal          { 38h - FUNCTION.VIDEO BYTE}
 DW   @End                   { 39h - FUNCTION.VIDEOSETUP BYTE}
 DW   @Printer               { 3Ah - FUNCTION.PRINTER BYTE}
@MoveLeft:   PUSH Word Ptr ES:[DI]
             PUSH Word Ptr ES:[DI+2]
             PUSH Word Ptr ES:[DI+4]
             PUSH Word Ptr ES:[DI+6]
             PUSH Word Ptr ES:[DI+8]
             CALL MoveLeft
             JMP  @Finish
@MoveRight:  PUSH Word Ptr ES:[DI]
             PUSH Word Ptr ES:[DI+2]
             PUSH Word Ptr ES:[DI+4]
             PUSH Word Ptr ES:[DI+6]
             PUSH Word Ptr ES:[DI+8]
             CALL MoveRight
             JMP  @Finish
@FillChar:   PUSH Word Ptr ES:[DI]
             PUSH Word Ptr ES:[DI+2]
             PUSH Word Ptr ES:[DI+4]
             PUSH Word Ptr ES:[DI+6]
             CALL FillChr
             JMP  @Finish
@FillClr:    PUSH Word Ptr ES:[DI]   { FAR }
             PUSH Word Ptr ES:[DI+2] { FAR }
             PUSH Word Ptr ES:[DI+4] { LENGTH }
             CALL FillClr
             JMP  @Finish
@CallFar:    CALL ES:[DI].DWord
             JMP  @Finish
@CallNear:   CALL ES:[DI].Word
             JMP  @Finish
@Push0:      XOR AX,AX
             PUSH AX
             JMP  @Finish
@PushByte:   PUSH Word Ptr ES:[DI]
             JMP  @Finish
@PushDWord:  PUSH Word Ptr ES:[DI]
             PUSH Word Ptr ES:[DI+2]
             JMP  @Finish
@PushXByte:  MOV CL,ES:[DI]
             XOR CH,CH
             MOV BX,DI
             INC BX
@pxb:        PUSH Word Ptr ES:[BX]
             INC BX
             INC Word Ptr @Buf
             LOOP @pxb
             JMP  @Finish
@AndByte:    MOV AL,ES:[DI]
             MOV BX,SP
             AND Byte Ptr SS:[BX],AL
             JMP @Finish
@AndWord:    MOV AX,ES:[DI]
             MOV BX,SP
             AND Word Ptr SS:[BX],AX
             JMP @Finish
@OrByte:     MOV AL,ES:[DI]
             MOV BX,SP
             OR  Byte Ptr SS:[BX],AL
             JMP @Finish
@OrWord:     MOV AX,ES:[DI]
             MOV BX,SP
             OR  Word Ptr SS:[BX],AX
             JMP @Finish
@XorByte:    MOV AL,ES:[DI]
             MOV BX,SP
             XOR Byte Ptr SS:[BX],AL
             JMP @Finish
@XorWord:    MOV AX,ES:[DI]
             MOV BX,SP
             XOR Word Ptr SS:[BX],AX
             JMP @Finish
@AddByte:    MOV AL,ES:[DI]
             MOV BX,SP
             ADD Byte Ptr SS:[BX],AL
             JMP @Finish
@AddWord:    MOV AX,ES:[DI]
             MOV BX,SP
             ADD Word Ptr SS:[BX],AX
             JMP @Finish
@NotByte:    MOV BX,SP
             NOT Byte Ptr SS:[BX]
             JMP @Finish
@NotWord:    MOV BX,SP
             NOT Word Ptr SS:[BX]
             JMP @Finish
@IncByte:    MOV BX,SP
             INC Byte Ptr SS:[BX]
             JMP @Finish
@IncWord:    MOV BX,SP
             INC Word Ptr SS:[BX]
             JMP @Finish
@DecByte:    MOV BX,SP
             DEC Byte Ptr SS:[BX]
             JMP @Finish
@DecWord:    MOV BX,SP
             DEC Word Ptr SS:[BX]
             JMP @Finish
@Shl1Byte:   MOV BX,SP
             SHL Byte Ptr SS:[BX],1
             JMP @Finish
@Shl1Word:   MOV BX,SP
             SHL Word Ptr SS:[BX],1
             JMP @Finish
@Shr1Byte:   MOV BX,SP
             SHR Byte Ptr SS:[BX],1
             JMP @Finish
@Shr1Word:   MOV BX,SP
             SHR Word Ptr SS:[BX],1
             JMP @Finish
@MoveByte:   MOV AX,ES:[DI]
             MOV BX,ES:[DI+2]
             MOV CX,ES:[DI+4]
             MOV DI,ES:[DI+6]
             MOV ES,AX
             MOV DL,ES:[BX]
             MOV ES,CX
             MOV ES:[DI],DL
             JMP @Finish
@MoveWord:   MOV AX,ES:[DI]
             MOV BX,ES:[DI+2]
             MOV CX,ES:[DI+4]
             MOV DI,ES:[DI+6]
             MOV ES,AX
             MOV DX,ES:[BX]
             MOV ES,CX
             MOV ES:[DI],DX
             JMP @Finish
@Move3Byte:  MOV AX,ES:[DI]
             MOV BX,ES:[DI+2]
             MOV CX,ES:[DI+4]
             MOV DI,ES:[DI+6]
             MOV ES,AX
             MOV DX,ES:[BX]
             MOV ES,CX
             MOV ES:[DI],DX
             MOV ES,AX
             MOV DL,ES:[BX+2]
             MOV ES,CX
             MOV ES:[DI+2],DL
             JMP @Finish
@MoveDWord:  MOV AX,ES:[DI]
             MOV BX,ES:[DI+2]
             MOV CX,ES:[DI+4]
             MOV DI,ES:[DI+6]
             MOV ES,AX
             MOV DX,ES:[BX]
             MOV ES,CX
             MOV ES:[DI],DX
             MOV ES,AX
             MOV DX,ES:[BX+2]
             MOV ES,CX
             MOV ES:[DI+2],DX
             JMP @Finish
@MoveByte2SD:MOV BL,ES:[DI]
             XOR BH,BH
             LES DI,ES:[DI+1]
             MOV DL,ES:[DI]
             MOV SS:[BX],DL
             JMP @Finish
@MoveWord2SD:MOV BL,ES:[DI]
             XOR BH,BH
             LES DI,ES:[DI+1]
             MOV DX,ES:[DI]
             MOV SS:[BX],DX
             JMP @Finish
@MoveSD2Byte:MOV BL,ES:[DI]
             XOR BH,BH
             LES DI,ES:[DI+1]
             MOV DL,SS:[BX]
             MOV ES:[DI],DL
             JMP @Finish
@MoveSD2Word:MOV BL,ES:[DI]
             XOR BH,BH
             LES DI,ES:[DI+1]
             MOV DX,SS:[BX]
             MOV ES:[DI],DX
             JMP @Finish
@MoveByteStack2SD:
             MOV BL,ES:[DI]
             XOR BH,BH
             MOV DI,ES:[DI+1]
             AND DI,00FFh
             ADD DI,SP
             MOV DL,SS:[DI]
             MOV SS:[BX],DL
             JMP @Finish
@MoveWordStack2SD:
             MOV BL,ES:[DI]
             XOR BH,BH
             MOV DI,ES:[DI+1]
             AND DI,00FFh
             ADD DI,SP
             MOV DX,SS:[DI]
             MOV SS:[BX],DX
             JMP @Finish
             {R‚p‚tition}
@Repeat:     MOV CL,ES:[DI]
             XOR CH,CH
             INC DI
@rep1:       PUSH CX
              PUSH ES
               PUSH DI
                PUSH ES
                PUSH DI
                PUSH CS
                CALL Near Ptr ExecLSMB2
               POP DI
              POP ES
             POP  CX
             LOOP @rep1
{             CLD
             MOV CX,$FFFF
             REPNE SCASB
             MOV AX,$FFFE
             SUB AX,CX
             INC AX
             INC AX
             INC AX
             ADD Word Ptr @Buf,AX}
             INC Word Ptr @Buf
             JMP @Finish
@ExecIntel:  {$IFOPT G+}PUSH 3{$ELSE}MOV AX,3;PUSH AX{$ENDIF}
             PUSH CS
             {$IFOPT G+}PUSH Offset @Int3{$ELSE}MOV AX,Offset @Int3;PUSH AX{$ENDIF}
             CALL SetIntVec
             INC Word Ptr @Buf
             MOV AX,Word Ptr @Return
             MOV DX,Word Ptr @Return[2]
             JMP DWord Ptr @Buf
@Int3:       MOV BX,SP
             MOV AX,Word Ptr SS:[BX]
             MOV Word Ptr @Buf,AX
             MOV Word Ptr SS:[BX],Offset @Finish
             MOV SS:[BX+2],CS
             IRET
@Return:     DD 0
@SettingInterneLSMB2:
             LES DI,AltPress
             MOV Word Ptr @AltPress,DI
             MOV Word Ptr @AltPress[2],ES
             LES DI,CtrlPress
             MOV Word Ptr @CtrlPress,DI
             MOV Word Ptr @CtrlPress[2],ES
             LES DI,FillChr
             MOV Word Ptr @FillChr,DI
             MOV Word Ptr @FillChr[2],ES
             LES DI,GetIntVec
             MOV Word Ptr @GetIntVec,DI
             MOV Word Ptr @GetIntVec[2],ES
             LES DI,GetRawTimer
             MOV Word Ptr @GetRawTimer,DI
             MOV Word Ptr @GetRawTimer[2],ES
             LES DI,GetRawTimerB
             MOV Word Ptr @GetRawTimerB,DI
             MOV Word Ptr @GetRawTimerB[2],ES
             LES DI,KeyPress
             MOV Word Ptr @KeyPress,DI
             MOV Word Ptr @KeyPress[2],ES
             LES DI,LShiftPress
             MOV Word Ptr @LShiftPress,DI
             MOV Word Ptr @LShiftPress[2],ES
             LES DI,MoveLeft
             MOV Word Ptr @_MoveLeft,DI
             MOV Word Ptr @_MoveLeft[2],ES
             LES DI,PushKey
             MOV Word Ptr @PushKey,DI
             MOV Word Ptr @PushKey[2],ES
             LES DI,RawReadKey
             MOV Word Ptr @RawReadKey,DI
             MOV Word Ptr @RawReadKey[2],ES
             LES DI,RShiftPress
             MOV Word Ptr @RShiftPress,DI
             MOV Word Ptr @RShiftPress[2],ES
             LES DI,SetIntVec
             MOV Word Ptr @SetIntVec,DI
             MOV Word Ptr @SetIntVec[2],ES
             LES DI,ShiftPress
             MOV Word Ptr @ShiftPress,DI
             MOV Word Ptr @ShiftPress[2],ES
             RETF
@PtrChantal: DD Chantal.Init
@VideoChantal:MOV AL,ES:[DI]
             XOR AH,AH
             MOV BX,AX
             ADD BX,AX
             ADD BX,AX
             MOV Word Ptr @PtrChantal,BX
             CALL DWord Ptr @PtrChantal
@ReadFunc:   MOV Word Ptr @Return,AX
             MOV Word Ptr @Return[2],DX
             JMP @Finish
@MemoryAddr: DD AbsInt                  { 00h }
             DD AddrExt2Conv            { 01h }
             DD AddrRPtr2Ext            { 02h }
             DD AllocFont               { 03h }
             DD AllocFunc               { 04h }
             DD AllocLangFunc           { 05h }
             DD AppResFree              { 06h }
             DD AppResSize              { 07h }
             DD Compare                 { 08h }
             DD DoneMemManagers         { 09h }
             DD EmmNumPage              { 0Ah }
             DD ExtBiosCopy             { 0Bh }
             DD ExtBiosRead             { 0Ch }
             DD ExtBiosWrite            { 0Dh }
             DD FillBool                { 0Eh }
             DD FillBoolAt              { 0Fh }
@FillChr:    DD 0                       { 10h }
             DD FillClr                 { 11h }
             DD FillSpc                 { 12h }
             DD FillWord                { 13h }
             DD FreeAllHeap             { 14h }
             DD FreeHeap                { 15h }
             DD FreeMaxHeapBy           { 16h }
             DD FreeMem                 { 17h }
             DD _FreeMem                { 18h }
@GetIntVec:  DD 0                       { 19h }
             DD InitMemManagers         { 1Ah }
             DD MaxByte                 { 1Bh }
             DD MaxExpandHeap           { 1Ch }
             DD MemAlloc                { 1Dh }
             DD MemNew                  { 1Eh }
             DD MinByte                 { 1Fh }
@_MoveLeft:  DD 0                       { 20h }
             DD MoveRight               { 21h }
             DD NewBlock                { 22h }
             DD RBAdd                   { 23h }
             DD RBAddLn                 { 24h }
             DD RBAddPChr               { 25h }
             DD RBAddPChrByte           { 26h }
             DD RBAddPChrWord           { 27h }
             DD RBAddSpcUStr            { 28h }
             DD RBAddStr                { 29h }
             DD RBAddStrByte            { 2Ah }
             DD RBAddStrWord            { 2Bh }
             DD RBDelBuf                { 2Ch }
             DD RBDelBufNSize           { 2Dh }
             DD RBDone                  { 2Eh }
             DD RBGetBuf                { 2Fh }
             DD _RBGetBuf               { 30h }
             DD RBGetCurrBuf            { 31h }
             DD _RBGetCurrBuf           { 32h }
             DD _RBGetStr               { 33h }
             DD RBInit                  { 34h }
             DD RBIns                   { 35h }
             DD RBInsStr                { 36h }
             DD RBInsStrWord            { 37h }
             DD RBIsEmpty               { 38h }
             DD RBMaxBuf                { 39h }
             DD RBNext                  { 3Ah }
             DD RBPopCurrPtr            { 3Bh }
             DD RBPrevious              { 3Ch }
             DD RBPushCurrPtr           { 3Dh }
             DD RBSet                   { 3Eh }
             DD RBSetCurrBuf            { 3Fh }
             DD RBSetPtr                { 40h }
             DD RBXChgBuf               { 41h }
@SetIntVec:  DD 0                       { 42h }
             DD XAllocMem               { 43h }
             DD XFreeMem                { 44h }
             DD XGetPos                 { 45h }
             DD XGetAbsRec              { 46h }
             DD XGetRec                 { 47h }
             DD _XGetRec                { 48h }
             DD XReAllocMem             { 49h }
             DD XSetAbsRec              { 4Ah }
             DD XSetPos                 { 4Bh }
             DD XSetRec                 { 4Ch }
             DD _XSetRec                { 4Dh }
             DD @SettingInterneLSMB2    { 4Eh }
@Memory:     MOV BL,ES:[DI]
             XOR BH,BH
             {$IFOPT G+}SHL BX,2{$ELSE}SHL BX,1;SHL BX,1{$ENDIF}
             CALL DWord Ptr @MemoryAddr[BX]
             JMP @ReadFunc
@StringAddr: DD AddStr                  { 00h }
             DD AddWdDec                { 01h }
             DD BackStr                 { 02h }
             DD BasicStrW               { 03h }
             DD BasicStr                { 04h }
             DD BinByte2Str             { 05h }
             DD BinStr2Nm               { 06h }
             DD CenterStr               { 07h }
             DD ChgChr                  { 08h }
             DD ChrDn                   { 09h }
             DD ChrUp                   { 0Ah }
             DD CmpLeft                 { 0Bh }
             DD CmpStr                  { 0Ch }
             DD Copy                    { 0Dh }
             DD CStr                    { 0Eh }
             DD CStr2                   { 0Fh }
             DD CStrBasic               { 10h }
             DD _DelAllSpcRight         { 11h }
             DD DelAllSpcLeft           { 12h }
             DD DelAllSpcRight          { 13h }
             DD DelChr                  { 14h }
             DD DelChrAt                { 15h }
             DD DelRightSpc             { 16h }
             DD DelStr                  { 17h }
             DD GetNxtChr               { 18h }
             DD HexByte2Str             { 19h }
             DD HexLong2Str             { 1Ah }
             DD HexStr2Nm               { 1Bh }
             DD HexWord2Str             { 1Ch }
             DD IinStr                  { 1Dh }
             DD IncStr                  { 1Eh }
             DD InsStr                  { 1Fh }
             DD IsArabicNumber          { 20h }
             DD IsPChrEmpty             { 21h }
             DD IsRomanLetter           { 22h }
             DD Left                    { 23h }
             DD _Left                   { 24h }
             DD LeftJustifyStr          { 25h }
             DD LoadStr                 { 26h }
             DD MultChr                 { 27h }
             DD OctStr2Nm               { 28h }
             DD PadChr                  { 29h }
             DD PXtrkWord               { 2Ah }
             DD RightJustifyStr         { 2Bh }
             DD SkipSpcInLn             { 2Ch }
             DD Spc                     { 2Dh }
             DD SpcTab                  { 2Eh }
             DD Str                     { 2Fh }
             DD Str0                    { 30h }
             DD Str2                    { 31h }
             DD Str2PChr                { 32h }
             DD StrCat                  { 33h }
             DD StrCatPas               { 34h }
             DD StrComp                 { 35h }
             DD StrCopy                 { 36h }
             DD StrDel                  { 37h }
             DD StrDispose              { 38h }
             DD StrDn                   { 39h }
             DD StrECopy                { 3Ah }
             DD StrEnd                  { 3Bh }
             DD StrI                    { 3Ch }
             DD StrIComp                { 3Dh }
             DD StrIns                  { 3Eh }
             DD StrInsChr               { 3Fh }
             DD StrInsBuf               { 40h }
             DD StrLCat                 { 41h }
             DD StrLComp                { 42h }
             DD StrLCopy                { 43h }
             DD StrLen                  { 44h }
             DD StrLIComp               { 45h }
             DD StrLower                { 46h }
             DD StrMove                 { 47h }
             DD StrNew                  { 48h }
             DD StrPas                  { 49h }
             DD StrPCopy                { 4Ah }
             DD StrPos                  { 4Bh }
             DD StrRomanUp              { 4Ch }
             DD StrRScan                { 4Dh }
             DD StrScan                 { 4Eh }
             DD StrUp                   { 4Fh }
             DD StrUpper                { 50h }
             DD StrUSpc                 { 51h }
             DD StrW                    { 52h }
             DD _StrW                   { 53h }
             DD Trim                    { 54h }
             DD ValW                    { 55h }
             DD ValL                    { 56h }
             DD Zero                    { 57h }
@String:     MOV BL,ES:[DI]
             XOR BH,BH
             {$IFOPT G+}SHL BX,2{$ELSE}SHL BX,1;SHL BX,1{$ENDIF}
             CALL DWord Ptr @StringAddr[BX]
             JMP @ReadFunc
@FileAddr:   DD AddRec                  { 00h }
             DD BBSPath                 { 01h }
             DD BFDone                  { 02h }
             DD BFGetAddr               { 03h }
             DD BFGetFile               { 04h }
             DD BFInit                  { 05h }
             DD BFSelPath               { 06h }
             DD BFSizeFiles             { 07h }
             DD BFMaxFiles              { 08h }
             DD BFNoFile                { 09h }
             DD ChDir                   { 0Ah }
             DD Close                   { 0Bh }
             DD CopyFile                { 0Ch }
             DD _CopyFile               { 0Dh }
             DD CreateDir               { 0Eh }
             DD DelFile                 { 0Fh }
             DD Dir2DateNTimeStr        { 10h }
             DD DirExist                { 11h }
             DD Dos2UnixPath            { 12h }
             DD DosPath                 { 13h }
             DD FileExist               { 14h }
             DD FileExpand              { 15h }
             DD FileSize                { 16h }
             DD FSearch                 { 17h }
             DD GetAbsFileTxtLn         { 18h }
             DD _GetAbsFileTxtLn        { 19h }
             DD __GetAbsFileTxtLn       { 1Ah }
             DD _GetAbsRec              { 1Bh }
             DD GetFile                 { 1Ch }
             DD _GetFile                { 1Dh }
             DD GetFileSize             { 1Eh }
             DD GetFileTime             { 1Fh }
             DD GetFileTxtLn            { 20h }
             DD _GetFileTxtLn           { 21h }
             DD GetPath                 { 22h }
             DD GetRec                  { 23h }
             DD _GetRec                 { 24h }
             DD GetStrComRLL            { 25h }
             DD GetStrLangRLL           { 26h }
             DD IsAllCard               { 27h }
             DD IsWildCard              { 28h }
             DD MaltePath               { 29h }
             DD MoveFile                { 2Ah }
             DD _MoveFile               { 2Bh }
             DD New                     { 2Ch }
             DD NewNBak                 { 2Dh }
             DD New_                    { 2Eh }
             DD NmHandle                { 2Fh }
             DD _NmHandle               { 30h }
             DD Open                    { 31h }
             DD _Open                   { 32h }
             DD OpenSearchPath          { 33h }
             DD OpenSearchPathNDos      { 34h }
             DD Path2Dir                { 35h }
             DD Path2Drv                { 36h }
             DD Path2Dsk                { 37h }
             DD Path2Ext                { 38h }
             DD Path2Name               { 39h }
             DD Path2NoDir              { 3Ah }
             DD Path2NoExt              { 3Bh }
             DD PrgPath                 { 3Ch }
             DD _PrgPath                { 3Dh }
             DD PutFileLn               { 3Eh }
             DD _PutFileLn              { 3Fh }
             DD PutFileTxt              { 40h }
             DD _PutFileTxt             { 41h }
             DD PutFileTxtLn            { 42h }
             DD _PutFileTxtLn           { 43h }
             DD ReadChr                 { 44h }
             DD Ren                     { 45h }
             DD RenDir                  { 46h }
             DD SearchFile              { 47h }
             DD _SetAbsRec              { 48h }
             DD SelAllIfNoExt           { 49h }
             DD SetFile                 { 4Ah }
             DD SetFilePos              { 4Bh }
             DD _SetFilePos             { 4Ch }
             DD SetFileTime             { 4Dh }
             DD SetFirstRec             { 4Eh }
             DD SetFullName             { 4Fh }
             DD SetPath4AddFile         { 50h }
             DD SetRec                  { 51h }
             DD _SetRec                 { 52h }
             DD Src2Target              { 53h }
             DD Unix2DosPath            { 54h }
@File:       MOV BL,ES:[DI]
             XOR BH,BH
             {$IFOPT G+}SHL BX,2{$ELSE}SHL BX,1;SHL BX,1{$ENDIF}
             CALL DWord Ptr @FileAddr[BX]
             JMP @ReadFunc
@DiskAddr:   DD Drv2Dsk                 { 00h }
             DD DrvExist                { 01h }
             DD DskExist                { 02h }
             DD DskFixed                { 03h }
             DD DskFree                 { 04h }
             DD DskSize                 { 05h }
             DD DskUsed                 { 06h }
             DD GetDrv                  { 07h }
             DD GetDskLabel             { 08h }
             DD GetSerialNm             { 09h }
             DD GetSerialNmStr          { 0Ah }
             DD _GetSerialNmStr         { 0Bh }
             DD ReadDsk                 { 0Ch }
             DD SetDskLabel             { 0Dh }
@Disk:       MOV BL,ES:[DI]
             XOR BH,BH
             {$IFOPT G+}SHL BX,2{$ELSE}SHL BX,1;SHL BX,1{$ENDIF}
             CALL DWord Ptr @DiskAddr[BX]
             JMP @ReadFunc
@KeyboardAddr:DD AltCode2ASCII          { 00h }
@AltPress:   DD 0                       { 01h }
             DD Ascii2AltCode           { 02h }
             DD CtrlCode2Ascii          { 03h }
@CtrlPress:  DD 0                       { 04h }
             DD GetCapsLck              { 05h }
             DD GetModeIns              { 06h }
             DD GetNmLck                { 07h }
             DD GetScrollLck            { 08h }
             DD IsAltCode               { 09h }
             DD IsUpKey                 { 0Ah }
@KeyPress:   DD 0                       { 0Bh }
@LShiftPress:DD 0                       { 0Ch }
             DD NxtKey                  { 0Dh }
@PushKey:    DD 0                       { 0Eh }
@RawReadKey: DD 0                       { 0Fh }
             DD ReadKey                 { 10h }
@RShiftPress:DD 0                       { 11h }
             DD SetCapsLck              { 12h }
             DD SetInsMode              { 13h }
             DD SetNmLck                { 14h }
             DD SetScrollLck            { 15h }
             DD SetTypm                 { 16h }
@ShiftPress: DD 0                       { 17h }
@Keyboard:   MOV BL,ES:[DI]
             XOR BH,BH
             {$IFOPT G+}SHL BX,2{$ELSE}SHL BX,1;SHL BX,1{$ENDIF}
             CALL DWord Ptr @KeyboardAddr[BX]
             JMP @ReadFunc
@ClockAddr:  DD CStrDate                { 00h }
             DD _CStrDate               { 01h }
             DD CStrTime                { 02h }
             DD CStrTimeDos             { 03h }
             DD Delay                   { 04h }
             DD _Delay                  { 05h }
             DD GetDate                 { 06h }
@GetRawTimerB:DD 0                      { 07h }
@GetRawTimer:DD 0                       { 08h }
             DD GetTime                 { 09h }
             DD PackTime                { 0Ah }
             DD TimeDiff                { 0Bh }
             DD TimeDiffH               { 0Ch }
             DD TimeOfDay               { 0Dh }
             DD TimeOfDayH              { 0Eh }
             DD UnpackTime              { 0Fh }
@Clock:      MOV BL,ES:[DI]
             XOR BH,BH
             {$IFOPT G+}SHL BX,2{$ELSE}SHL BX,1;SHL BX,1{$ENDIF}
             CALL DWord Ptr @ClockAddr[BX]
             JMP @ReadFunc
@PrinterAddr:DD ChkPrint                { 00h }
             DD DoneSpooler             { 01h }
             DD InitSpooler             { 02h }
             DD LPT1Exist               { 03h }
             DD LPT2Exist               { 04h }
             DD LPT3Exist               { 05h }
             DD LPT4Exist               { 06h }
             DD Print                   { 07h }
             DD PrintChr                { 08h }
             DD Prn                     { 09h }
             DD PrnLn                   { 0Ah }
             DD PrnStepBit              { 0Bh }
             DD PushStrSpooler          { 0Ch }
             DD __SetPrnCompress        { 0Dh }
@Printer:    MOV BL,ES:[DI]
             XOR BH,BH
             {$IFOPT G+}SHL BX,2{$ELSE}SHL BX,1;SHL BX,1{$ENDIF}
             CALL DWord Ptr @PrinterAddr[BX]
             JMP @ReadFunc
@SoundAddr:  DD Beep                    { 00h }
             DD InitSound               { 01h }
             DD NoSound                 { 02h }
             DD Sound                   { 03h }
@Sound:      MOV BL,ES:[DI]
             XOR BH,BH
             {$IFOPT G+}SHL BX,2{$ELSE}SHL BX,1;SHL BX,1{$ENDIF}
             CALL DWord Ptr @SoundAddr[BX]
             JMP @ReadFunc
@End:
END;

END.