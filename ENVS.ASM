
; *******************************************************
; *							*
; *	Turbo Pascal Runtime Library Version 5.5	*
; *	Environment String Routines			*
; *							*
; *	Copyright (C) 1988,89 Borland International	*
; *							*
; *******************************************************

	TITLE	ENVS

	LOCALS	@@

DATA	SEGMENT	WORD PUBLIC

	EXTRN	PrefixSeg:WORD

DATA	ENDS

CODE	SEGMENT	BYTE PUBLIC

	ASSUME	CS:CODE,DS:DATA

	PUBLIC	EnvCount

EnvCount	PROC	FAR

	XOR	DX,DX
	CALL	EnvStrCnt
	XCHG	AX,DX
	NEG	AX
	RET

EnvCount	ENDP

	PUBLIC	EnvStr

EnvStr		PROC	FAR

EnvStrP		EQU	(DWORD PTR [BP+8])
EnvIndex	EQU	(WORD PTR [BP+6])

	PUSH	BP
	MOV	BP,SP
	PUSH	DS
	MOV	DX,EnvIndex
	CALL	EnvStrCnt
	MOV	SI,DI
	PUSH	ES
	POP	DS
	XOR	AL,AL
	MOV	CX,256
	REPNE	SCASB
	NOT	CL
	LES	DI,EnvStrP
	MOV	AL,CL
	STOSB
	REP	MOVSB
	POP	DS
	POP	BP
	RET	2

EnvStr		ENDP

EnvStrCnt	PROC	NEAR

	MOV	ES,PrefixSeg
	MOV	ES,ES:[2CH]
	XOR	DI,DI
	CLD
@@1:	XOR	AL,AL
	CMP	AL,ES:[DI]
	JE	@@2
	DEC	DX
	JE	@@2
	MOV	CX,-1
	REPNE	SCASB
	JMP	@@1
@@2:	RET

EnvStrCnt	ENDP

CODE	ENDS

	END
