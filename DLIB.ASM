
; *******************************************************
; *							*
; *     Turbo Pascal Run-time Library                   *
; *	DPMI Library Main Module			*
; *							*
; *     Copyright (c) 1988,92 Borland International     *
; *							*
; *******************************************************

	TITLE	DLIB

	INCLUDE	SE.ASM

DATA	SEGMENT WORD PUBLIC

; Externals

	EXTRN	HeapAllocFlags:WORD,ExitCode:WORD,HInstance:WORD
	EXTRN	SelectorInc:WORD,Seg0040:WORD,SegA000:WORD
	EXTRN	SegB000:WORD,SegB800:WORD,Test8086:BYTE

DATA	ENDS

; Run-time manager externals

	EXTRN	__AHIncr:ABS,__0040H:ABS,__A000H:ABS
	EXTRN	__B000H:ABS,__B800H:ABS

CODE	SEGMENT	BYTE PUBLIC

	ASSUME	CS:CODE,DS:DATA

; Externals

	EXTRN	DoExitProcs:NEAR

; Publics

	PUBLIC	LibEntry,LibExit,LibExitProc

; Library entry code. Every .DLL executable starts with a call
; to this routine.

LibEntry:

	MOV	HInstance,DI		;Save instance handle
	MOV	AX,dpmiGetVersion	;Determine CPU type
	INT	DPMI
	DEC	CL
	MOV	Test8086,CL
	MOV	HeapAllocFlags,2002H	;gmem_Moveable + gmem_DDEShare
	MOV	SelectorInc,__AHIncr	;Set selector increment
	MOV	Seg0040,__0040H		;Set predefined selectors
	MOV	SegA000,__A000H
	MOV	SegB000,__B000H
	MOV	SegB800,__B800H
	MOV	ExitCode,1		;Default exit code is 1
	RETF

; Library exit code. Every .DLL executable ends with a call to
; this routine.

LibExit:

	POP	AX			;Remove return address
	POP	AX
	MOV	AX,ExitCode		;Get exit code
	MOV	DI,HInstance		;Restore DI
	RETF				;Return to operating system

; Library exit procedure (automatically exported as 'WEP')

LibExitProc:

	PUSH	BP
	MOV	BP,SP
	PUSH	SI
	PUSH	DI
	PUSH	DS
	MOV	AX,SEG DATA
	MOV	DS,AX
	MOV	AX,[BP+6]		;Get WEP parameter
	MOV	ExitCode,AX		;Store in ExitCode
	CALL	DoExitProcs		;Execute exit procedures
	MOV	AX,1			;Successful termination
	POP	DS
	POP	DI
	POP	SI
	POP	BP
	RETF	2

CODE	ENDS

	END
