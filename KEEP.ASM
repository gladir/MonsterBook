
; *******************************************************
; *							*
; *	Turbo Pascal Runtime Library Version 5.5	*
; *	TSR Support Routine				*
; *							*
; *	Copyright (C) 1988,89 Borland International	*
; *							*
; *******************************************************

	TITLE	KEEP

DATA	SEGMENT	WORD PUBLIC

	EXTRN	PrefixSeg:WORD

DATA	ENDS

CODE	SEGMENT	BYTE PUBLIC

	ASSUME	CS:CODE,DS:DATA

	PUBLIC	Keep

Keep		PROC	FAR

ExitCode	EQU	(BYTE PTR [BP+6])

	PUSH	BP
	MOV	BP,SP
	MOV	AX,PrefixSeg
	MOV	ES,AX
	MOV	DX,WORD PTR ES:2
	SUB	DX,AX
	MOV	AL,ExitCode
	MOV	AH,31H
	INT	21H
	POP	BP
	RET	2

Keep		ENDP

CODE	ENDS

	END
