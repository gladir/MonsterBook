
; *******************************************************
; *							*
; *     Turbo Pascal Run-time Library                   *
; *	Windows Library Main Module			*
; *							*
; *     Copyright (c) 1988,92 Borland International     *
; *							*
; *******************************************************

	TITLE	WLIB

	INCLUDE	SE.ASM

DATA	SEGMENT WORD PUBLIC

; Externals

	EXTRN	ExitCode:WORD,HInstance:WORD,CmdLine:DWORD
	EXTRN	HeapAllocFlags:WORD,Input:BYTE,Output:BYTE
	EXTRN	SelectorInc:WORD,Test8086:BYTE

DATA	ENDS

; Windows entry points

	EXTRN	LocalInit:FAR,GetWinFlags:FAR,__AHIncr:ABS

CODE	SEGMENT	BYTE PUBLIC

	ASSUME	CS:CODE,DS:DATA

; Externals

	EXTRN	DoExitProcs:NEAR

; Publics

	PUBLIC	LibEntry,LibExit,LibExitProc

; Library entry code. Every .DLL executable starts with a call
; to this routine.

LibEntry:

	ENTRY	WINFAR
	MOV	HInstance,DI		;Save library parameters
	MOV	CmdLine.ofs,SI
	MOV	CmdLine.seg,ES
	JCXZ	@@1			;Skip if no local heap
	XOR	AX,AX			;Initialize local heap
	PUSH	DS
	PUSH	AX
	PUSH	CX
	CALL	LocalInit
	OR	AX,AX			;Exit if it failed
	JE	@@3
@@1:	CALL	GetWinFlags		;Determine CPU type
	XOR	DX,DX
	TEST	AL,0C0H			;wf_CPU086 + wf_CPU186
	JNE	@@2
	INC	DX
	TEST	AL,02H			;wf_CPU286
	JNE	@@2
	INC	DX
@@2:	MOV	Test8086,DL
	MOV	HeapAllocFlags,2002H	;gmem_Moveable + gmem_DDEShare
	MOV	SelectorInc,__AHIncr
	MOV	ExitCode,1		;Default exit code is 1
	EXIT
@@3:	MOV	BP,SP			;Remove stack frame
	POP	BP
	DEC	BP
	POP	CX			;Remove return address
	POP	CX
	RETF				;Return to Windows

; Library exit code. Every .DLL executable ends with a call to
; this routine.

LibExit:

	POP	AX			;Remove return address
	POP	AX
	MOV	AX,ExitCode		;Get exit code
	MOV	DI,HInstance		;Restore DI
	RETF				;Return to windows

; Library exit procedure (automatically exported as 'WEP')

LibExitProc:

	MOV	AX,DS			;Exported function
	NOP
	INC	BP
	PUSH	BP
	MOV	BP,SP
	PUSH	DS
	PUSH	SI
	PUSH	DI
	MOV	DS,AX
	MOV	AX,[BP+6]		;Get WEP parameter
	MOV	ExitCode,AX		;Store in ExitCode
	CALL	DoExitProcs		;Execute exit procedures
	MOV	AX,1			;Successful termination
	POP	DI
	POP	SI
	POP	DS
	POP	BP
	DEC	BP
	RETF	2

CODE	ENDS

	END
