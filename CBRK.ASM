
; *******************************************************
; *							*
; *	Turbo Pascal Runtime Library Version 5.5	*
; *	Ctrl-Break Flag Handling			*
; *							*
; *	Copyright (C) 1988,89 Borland International	*
; *							*
; *******************************************************

	TITLE	CBRK

CODE	SEGMENT	BYTE PUBLIC

	ASSUME	CS:CODE

	PUBLIC	GetCBreak

GetCBreak	PROC	FAR

BreakP		EQU	(DWORD PTR [BP+6])

	PUSH	BP
	MOV	BP,SP
	MOV	AX,3300H
	INT	21H
	LES	DI,BreakP
	MOV	ES:[DI],DL
	POP	BP
	RET	4

GetCBreak	ENDP

	PUBLIC	SetCBreak

SetCBreak	PROC	FAR

Break		EQU	(BYTE PTR [BP+6])

	PUSH	BP
	MOV	BP,SP
	MOV	DL,Break
	MOV	AX,3301H
	INT	21H
	POP	BP
	RET	2

SetCBreak	ENDP

CODE	ENDS

	END
