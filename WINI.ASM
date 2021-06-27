
; *******************************************************
; *							*
; *     Turbo Pascal Run-time Library                   *
; *	Windows Application Main Module			*
; *							*
; *     Copyright (c) 1988,92 Borland International     *
; *							*
; *******************************************************

	TITLE	WINI

	INCLUDE	SE.ASM

DATA	SEGMENT WORD PUBLIC

; Externals

	EXTRN	ExitProc:DWORD,ExitCode:WORD,ErrorAddr:DWORD
	EXTRN	PrefixSeg:WORD,InOutRes:WORD,HPrevInst:WORD
	EXTRN	HInstance:WORD,CmdShow:WORD,Input:BYTE
	EXTRN	Output:BYTE

DATA	ENDS

; Windows entry points

	EXTRN	WaitEvent:FAR,InitApp:FAR,MessageBox:FAR
	EXTRN	_wsprintf:FAR

CODE	SEGMENT	BYTE PUBLIC

	ASSUME	CS:CODE,DS:DATA

; Externals

	EXTRN	AssignText:NEAR,ResetText:NEAR,RewriteText:NEAR
	EXTRN	CloseText:NEAR

; Publics

	PUBLIC	InitTurbo,HaltTurbo,HaltError,Terminate

; Initialize runtime library. Every program starts with a call
; to InitTask followed by a call to this routine.

InitTurbo:

	ENTRY	WINFAR
	OR	AX,AX			;Zero if InitTask failed
	JE	InitError
	MOV	PrefixSeg,ES		;Save InitTask return values
	MOV	HPrevInst,SI
	MOV	HInstance,DI
	MOV	CmdShow,DX
	XOR	AX,AX			;Clear event that started task
	PUSH	AX
	CALL	WaitEvent
	PUSH	HInstance		;Initialize application
	CALL	InitApp
	OR	AX,AX			;Zero if InitApp failed
	JE	InitError
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
	EXIT				;Back to main program

; Here in case initialization fails

InitError:

	MOV	AX,dosExit*256+0FFH
	INT	DOS

; RunError standard procedure

HaltError:

	DB	0B9H			;MOV CX,immed16

; Halt standard procedure

HaltTurbo:

	XOR	CX,CX
	MOV	BX,CX

; Terminate program and return to Windows
; In	AX = Exit code
;	CX = Non-zero if error

Terminate:

	ENTRY	WINFAR
	PUSH	SS			;Reset DS
	POP	DS
	JCXZ	@@1
	MOV	CX,[BP+2]
	MOV	BX,[BP+4]
@@1:	MOV	ExitCode,AX		;Save exit code
	MOV	ErrorAddr.ofs,CX	;Save error address
	MOV	ErrorAddr.seg,BX
@@2:	LES	BX,ExitProc		;Call exit procedures
	MOV	AX,ES
	OR	AX,BX
	JE	@@3
	XOR	AX,AX
	MOV	ExitProc.ofs,AX
	MOV	ExitProc.seg,AX
	MOV	InOutRes,AX
	MOV	AX,OFFSET @@2
	PUSH	CS
	PUSH	AX
	PUSH	ES
	PUSH	BX
	RETF
@@3:	MOV	AX,OFFSET Input		;Close Input file
	PUSH	DS
	PUSH	AX
	PUSH	CS
	CALL	CloseText
	MOV	AX,OFFSET Output	;Close Output file
	PUSH	DS
	PUSH	AX
	PUSH	CS
	CALL	CloseText
	MOV	AX,ErrorAddr.ofs
	MOV	DX,ErrorAddr.seg
	MOV	CX,AX			;Runtime error?
	OR	CX,DX
	JE	@@4			;No, @@4
	SUB	SP,64
	MOV	SI,SP
	PUSH	AX			;arguments
	PUSH	DX
	PUSH	ExitCode
	MOV	AX,OFFSET CS:ErrorStr
	PUSH	CS			;lpFormat
	PUSH	AX
	PUSH	SS			;lpOutput
	PUSH	SI
	CALL	_wsprintf
	MOV	SP,SI
	XOR	AX,AX
	PUSH	AX			;hWndParent
	PUSH	SS			;lpText
	PUSH	SI
	PUSH	AX			;lpCaption
	PUSH	AX
	MOV	AX,1010H		;MB_OK+MB_ICONHAND+MB_SYSTEMMODAL
	PUSH	AX			;wType
	CALL	MessageBox
	ADD	SP,64
@@4:	MOV	AX,ExitCode		;Exit to Windows
	MOV	AH,dosExit
	INT	DOS
	EXIT

; Runtime error format string

ErrorStr	DB	'Runtime error %d at %04X:%04X.'

; Empty string

ZeroString	DB	0

; Copyright notice

Copyright	DB	'Portions Copyright (c) 1983,90 Borland'

CODE	ENDS

	END
