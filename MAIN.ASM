
; *******************************************************
; *							*
; *     Turbo Pascal Run-time Library                   *
; *	Main module					*
; *							*
; *     Copyright (c) 1988,92 Borland International     *
; *							*
; *******************************************************

	TITLE	MAIN

	INCLUDE	SE.ASM

DATA	SEGMENT WORD PUBLIC

; Externals

	EXTRN	OvrHeapSize:WORD,OvrHeapOrg:WORD,OvrHeapPtr:WORD
	EXTRN	OvrHeapEnd:WORD,OvrLoadList:WORD,HeapOrg:DWORD
	EXTRN	HeapPtr:DWORD,HeapEnd:DWORD,FreeList:DWORD
	EXTRN	HeapError:DWORD,ExitProc:DWORD,ExitCode:WORD
	EXTRN	ErrorAddr:DWORD,PrefixSeg:WORD,InOutRes:WORD
	EXTRN	Input:BYTE,Output:BYTE,SaveInt00:DWORD
	EXTRN	Test8086:BYTE

DATA	ENDS

CODE	SEGMENT	BYTE PUBLIC

	ASSUME	CS:CODE,DS:DATA

; Externals

	EXTRN	AssignText:NEAR,ResetText:NEAR,RewriteText:NEAR
	EXTRN	CloseText:NEAR,ClearDSeg:NEAR

; Publics

	PUBLIC	InitTurbo,HaltTurbo,HaltError,PrintString
	PUBLIC	Terminate,LibEntry,LibExit,LibExitProc,InitTask

; Initialize runtime library. First instruction in any program
; is a call to this routine.

InitTurbo:

	MOV	DX,SEG DATA		;Initialize DS
	MOV	DS,DX
	MOV	PrefixSeg,ES		;Save PSP segment
	XOR	BP,BP			;End of stack frame chain
	CALL	ClearDSeg		;Zero fill data segment
	CALL	Check8086		;Determine CPU type
	MOV	AX,SP			;Compute first free segment
	ADD	AX,4+15			;address in AX
	MOV	CL,4
	SHR	AX,CL
	MOV	DX,SS
	ADD	AX,DX
	MOV	OvrHeapOrg,AX		;Initialize overlay manager
	MOV	OvrHeapPtr,AX		;variables
	ADD	AX,OvrHeapSize
	MOV	OvrHeapEnd,AX
	MOV	HeapOrg.seg,AX		;Initialize heap manager
	MOV	HeapPtr.seg,AX		;variables
	MOV	FreeList.seg,AX
        MOV     ES,PrefixSeg
	MOV	AX,ES:pspMemTop
	MOV	HeapEnd.seg,AX
	MOV	HeapError.ofs,OFFSET CS:HeapFailure
	MOV	HeapError.seg,CS
	MOV	DI,OFFSET SaveInt00	;Capture interrupt vectors
	MOV	SI,OFFSET SaveIntTab
	MOV	CX,SaveIntCnt
@@1:	CLD
	SEGCS	LODSB
	MOV	AH,dosGetInt
	INT	DOS
	MOV	[DI].ofs,BX
	MOV	[DI].seg,ES
	ADD	DI,4
	LOOP	@@1
	PUSH	DS			;Install interrupt handlers
	PUSH	CS
	POP	DS
	MOV	DX,OFFSET Int00Handler
	MOV	AX,dosSetInt*256+00H
	INT	DOS
	MOV	DX,OFFSET Int23Handler
	MOV	AX,dosSetInt*256+23H
	INT	DOS
	MOV	DX,OFFSET Int24Handler
	MOV	AX,dosSetInt*256+24H
	INT	DOS
	MOV	DX,OFFSET Int3FHandler
	MOV	AX,dosSetInt*256+3FH
	INT	DOS
	POP	DS
	MOV	AX,OFFSET Input		;Assign/Reset Input file
	PUSH	DS
	PUSH	AX
	PUSH	DS
	PUSH	AX
	MOV	AX,OFFSET ZeroString
	PUSH	CS
	PUSH	AX
	PUSH	CS
	CALL	AssignText
	PUSH	CS
	CALL	ResetText
	MOV	AX,OFFSET Output	;Assign/Rewrite Output file
	PUSH	DS
	PUSH	AX
	PUSH	DS
	PUSH	AX
	MOV	AX,OFFSET ZeroString
	PUSH	CS
	PUSH	AX
	PUSH	CS
	CALL	AssignText
	PUSH	CS
	CALL	RewriteText
	RETF				;Back to main program

; CPU detection routine. Sets the Test8086 variable according to the
; type of CPU detected.

Check8086:

	XOR	AX,AX			;0 means 8088/8086
	PUSHF				;BX = Flags
	POP	BX
	AND	BH,0FH			;Clear bits 12-15
	PUSH	BX			;Flags = BX
	POPF
	PUSHF				;CX = Flags
	POP	CX
	AND	CH,0F0H			;Bits 12-15 set?
	CMP	CH,0F0H
	JE	@@1			;Yes, 8086
	INC	AX			;1 means 80286
	OR	BH,0F0H			;Set bits 12-15
	PUSH	BX			;Flags = BX
	POPF
	PUSHF				;CX = Flags
	POP	CX
	AND	CH,0F0H			;Bits 12-15 cleared?
	JE	@@1			;Yes, 80286
	INC	AX			;2 means 80386
@@1:	MOV	Test8086,AL		;Save CPU test result
	RET

; Default heap error handler. Return 0 to indicate run-time error.

HeapFailure:

	XOR	AX,AX
	RETF	2

; Critical error interrupt handler. Control arrives here when
; DOS encounters a "critical error". Convert critical error code
; to Turbo Pascal I/O error code, and return.

Int24Handler:

	STI				;Enable interrupts
	ADD	SP,6			;Remove INT 24H return info
	POP	AX			;Get INT 21H AX register
	AND	DI,01FH			;Return AX=150..181
	ADD	DI,150
	CMP	AH,39H			;DOS 2.0 style function?
	JAE	@@1			;Yes, @@1
	MOV	DI,0FFFFH		;Return AX=0FFFFH
@@1:	PUSH	DI			;Save error code
	MOV	AH,54H			;Dummy function call to get
	INT	DOS			;DOS into a stable state
	MOV	BP,SP			;Set CF in return flags
	OR	BYTE PTR [BP+22],1
	POP	AX			;Restore registers
	POP	BX
	POP	CX
	POP	DX
	POP	SI
	POP	DI
	POP	BP
	POP	DS
	POP	ES
	IRET				;Return to caller

; Overlay interrupt handler. Control arrives here if the program
; calls an overlay procedure before initializing the overlay manager.

Int3FHandler:

	MOV	AX,208
	ADD	SP,6
	JMP	SHORT HaltError

; Divide by zero interrupt handler. Control arrives here upon
; executing a DIV or IDIV instruction with a zero divisor.

Int00Handler:

	MOV	AX,200

; RunError standard procedure

HaltError:

	POP	CX
	POP	BX
	JMP	SHORT Terminate

; Dummy entry points

LibEntry:
LibExit:
LibExitProc:
InitTask:

; Control-C interrupt handler. Control arrives here when DOS
; detects a Ctrl-C or Ctrl-Break.

Int23Handler:

	MOV	AX,255

; Halt standard procedure

HaltTurbo:

	XOR	CX,CX
	XOR	BX,BX

; Terminate program and return to DOS
; In	AX    = Exit code
;	BX:CX = Error address (or NIL)

Terminate:

	MOV	DX,SEG DATA		;Reset DS
	MOV	DS,DX
	STI				;Enable interrupts
	MOV	ExitCode,AX		;Save exit code
	MOV	AX,CX			;Is error address NIL?
	OR	AX,BX
	JE	@@4			;Yes, @@4
	MOV	AX,OvrLoadList		;Convert physical overlay
@@0:	OR	AX,AX			;address to virtual address
	JE	@@3
	MOV	ES,AX
	MOV	AX,ES:ovSegment
	OR	AX,AX
	JE	@@1
	SUB	AX,BX
	JA	@@1
	NEG	AX
	CMP	AX,1000H
	JAE	@@1
	MOV	DX,16
	MUL	DX
	ADD	AX,CX
	JC	@@1
	CMP	AX,ES:ovCodeSize
	JB	@@2
@@1:	MOV	AX,ES:ovNext
	JMP	@@0
@@2:	MOV	CX,AX
	MOV	BX,ES
@@3:	SUB	BX,PrefixSeg		;Adjust address
	SUB	BX,10H
@@4:	MOV	ErrorAddr.ofs,CX	;Save error address
	MOV	ErrorAddr.seg,BX
@@5:	LES	BX,ExitProc		;Call exit procedures
	MOV	AX,ES
	OR	AX,BX
	JE	@@10
	XOR	AX,AX
	MOV	ExitProc.ofs,AX
	MOV	ExitProc.seg,AX
	MOV	InOutRes,AX
	MOV	AX,OFFSET @@5
	PUSH	CS
	PUSH	AX
	PUSH	ES
	PUSH	BX
	RETF
@@10:	MOV	AX,OFFSET Input		;Close Input file
	PUSH	DS
	PUSH	AX
	PUSH	CS
	CALL	CloseText
	MOV	AX,OFFSET Output	;Close Output file
	PUSH	DS
	PUSH	AX
	PUSH	CS
	CALL	CloseText
	MOV	DI,OFFSET SaveInt00	;Restore interrupt vectors
	MOV	SI,OFFSET SaveIntTab
	MOV	CX,SaveIntCnt
@@11:	CLD
	SEGCS	LODSB
	MOV	AH,dosSetInt
	PUSH	DS
	LDS	DX,[DI]
	INT	DOS
	POP	DS
	ADD	DI,4
	LOOP	@@11
	MOV	AX,ErrorAddr.ofs	;Runtime error?
	OR	AX,ErrorAddr.seg
	JE	@@12			;No, @@12
	MOV	BX,OFFSET ErrorStr1	;Print error message
	CALL	PrintString
	MOV	AX,ExitCode
	CALL	PrintDec
	MOV	BX,OFFSET ErrorStr2
	CALL	PrintString
	MOV	AX,ErrorAddr.seg
	CALL	PrintHex
	MOV	AL,':'
	CALL	PrintChar
	MOV	AX,ErrorAddr.ofs
	CALL	PrintHex
	MOV	BX,OFFSET ErrorStr3
	CALL	PrintString
@@12:	MOV	AX,ExitCode		;Exit to DOS
	MOV	AH,dosExit
	INT	DOS

; Print string
; In	CS:BX = String pointer

PrintString:

@@1:	MOV	AL,CS:[BX]
	OR	AL,AL
	JE	@@2
	CALL	PrintChar
	INC	BX
	JMP	SHORT @@1
@@2:	RET

; Print byte in decimal
; In	AL = Value

PrintDec:

	MOV	CL,100
	CALL	@@1
	MOV	CL,10
	CALL	@@1
	JMP	SHORT @@2
@@1:	XOR	AH,AH
	DIV	CL
@@2:	ADD	AL,'0'
	PUSH	AX
	CALL	PrintChar
	POP	AX
	MOV	AL,AH
	RET

; Print word in hex
; In	AX = Value

PrintHex:

	PUSH	AX
	MOV	AL,AH
	CALL	@@1
	POP	AX
@@1:	PUSH	AX
	MOV	CL,4
	SHR	AL,CL
	CALL	@@2
	POP	AX
	AND	AL,0FH
@@2:	ADD	AL,'0'
	CMP	AL,'0'+10
	JB	PrintChar
	ADD	AL,'A'-'0'-10

; Print character
; In	AL = Character

PrintChar:

	MOV	DL,AL
	MOV	AH,6
	INT	DOS
	RET

; Saved interrupt numbers

SaveIntTab	DB	00H,02H,1BH,21H,23H,24H,34H,35H,36H,37H
		DB	38H,39H,3AH,3BH,3CH,3DH,3EH,3FH,75H
SaveIntCnt	EQU	$-SaveIntTab

; Error strings

ErrorStr1	DB	'Runtime error ',0
ErrorStr2	DB	' at ',0
ErrorStr3	DB	'.',cr,lf

; Empty string

ZeroString	DB	0

; Copyright notice

Copyright	DB	'Portions Copyright (c) 1983,92 Borland'

CODE	ENDS

	END
