
; *******************************************************
; *							*
; *     Turbo Pascal Run-time Library                   *
; *	Windows Termination Procedures Module		*
; *							*
; *     Copyright (c) 1988,92 Borland International     *
; *							*
; *******************************************************

	TITLE	WEND

	INCLUDE	SE.ASM

CONST	SEGMENT	WORD PUBLIC

; Runtime error message string

ErrorStr	DB	'Runtime error '
ErrorCodeStr	DB	'000 at '
ErrorAddrStr	DB	'0000:0000.',0

CONST	ENDS

DATA	SEGMENT WORD PUBLIC

; Externals

	EXTRN	ExitProc:DWORD,ExitCode:WORD,ErrorAddr:DWORD
	EXTRN	PrefixSeg:WORD,InOutRes:WORD

DATA	ENDS

DGROUP	GROUP	CONST,DATA

; Windows entry points

	EXTRN	MessageBox:FAR

CODE	SEGMENT	BYTE PUBLIC

	ASSUME	CS:CODE,DS:DGROUP

; Publics

	PUBLIC	HaltTurbo,HaltError,Terminate,DoExitProcs

; RunError standard procedure

HaltError:

	POP	CX
	POP	BX
	JMP	SHORT Terminate

; Halt standard procedure

HaltTurbo:

	XOR	CX,CX
	XOR	BX,BX

; Terminate program and return to Windows
; In	AX    = Exit code
;	BX:CX = Error address (or NIL)

Terminate:

	MOV	ExitCode,AX		;Save exit code
	MOV	AX,CX			;Is error address NIL?
	OR	AX,BX
	JE	@@2			;Yes, @@2
	CMP	BX,0FFFFH		;Unknown address?
	JE	@@2			;Yes, @@2
	MOV	ES,BX			;Get logical segment number
	MOV	BX,WORD PTR ES:0
@@2:	MOV	ErrorAddr.ofs,CX	;Save error address
	MOV	ErrorAddr.seg,BX
	CMP	PrefixSeg,0		;Is this a library?
	JE	@@3			;Yes, WEP will do exit procs
	CALL	DoExitProcs		;Execute exit procedures
@@3:	MOV	AX,ErrorAddr.ofs	;Runtime error?
	OR	AX,ErrorAddr.seg
	JE	@@4			;No, @@4
	MOV	CX,10
	MOV	AL,ExitCode.b0
	XOR	AH,AH
	MOV	BX,OFFSET ErrorCodeStr+3
	CALL	Num2Str
	MOV	CX,16
	MOV	AX,ErrorAddr.seg
	MOV	BX,OFFSET ErrorAddrStr+4
	CALL	Num2Str
	MOV	AX,ErrorAddr.ofs
	MOV	BX,OFFSET ErrorAddrStr+9
	CALL	Num2Str
	XOR	AX,AX
	PUSH	AX			;hWndParent
	MOV	BX,OFFSET ErrorStr
	PUSH	DS			;lpText
	PUSH	BX
	PUSH	AX			;lpCaption
	PUSH	AX
	MOV	AX,1010H		;MB_OK+MB_ICONHAND+MB_SYSTEMMODAL
	PUSH	AX			;wType
	CALL	MessageBox
@@4:	MOV	AL,ExitCode.b0		;Get exit code
	MOV	AH,dosExit		;Terminate application
	INT	DOS

; Execute exit procedures

DoExitProcs:

@@1:	LES	BX,ExitProc
	MOV	AX,ES
	OR	AX,BX
	JE	@@2
	XOR	AX,AX
	MOV	ExitProc.ofs,AX
	MOV	ExitProc.seg,AX
	MOV	InOutRes,AX
	MOV	AX,OFFSET @@1
	PUSH	CS
	PUSH	AX
	PUSH	ES
	PUSH	BX
	RETF
@@2:	RET

; Convert number to string
; In	AX = Number
;	BX = Pointer to end of buffer
;	CX = Number base

Num2Str:

@@1:	XOR	DX,DX
	DIV	CX
	ADD	DL,'0'
	CMP	DL,'0'+10
	JB	@@2
	ADD	DL,'A'-'0'-10
@@2:	DEC	BX
	MOV	[BX],DL
	OR	AX,AX
	JNE	@@1
	RET

; Copyright notice

Copyright	DB	'Portions Copyright (c) 1983,92 Borland'

CODE	ENDS

	END
