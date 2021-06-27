
; *******************************************************
; *							*
; *	Turbo Pascal Runtime Library Version 5.5	*
; *	Environment Variable Routine			*
; *							*
; *	Copyright (C) 1988,89 Borland International	*
; *							*
; *******************************************************

	TITLE	ENVV

	LOCALS	@@

DATA	SEGMENT	WORD PUBLIC

	EXTRN	PrefixSeg:WORD

DATA	ENDS

CODE	SEGMENT	BYTE PUBLIC

	ASSUME	CS:CODE,DS:DATA

	PUBLIC	GetEnv

GetEnv		PROC	FAR

EnvStrP		EQU	(DWORD PTR [BP+10])
EnvVarP		EQU	(DWORD PTR [BP+6])
VarName		EQU	(BYTE PTR [BP-32])

	PUSH	BP
	MOV	BP,SP
	SUB	SP,32
	PUSH	DS
	CLD
	LDS	SI,EnvVarP
	LEA	DI,VarName
	PUSH	SS
	POP	ES
	LODSB
	CMP	AL,31
	JBE	@@1
	MOV	AL,31
@@1:	CBW
	MOV	CX,AX
	INC	AX
	MOV	DX,AX
	JCXZ	@@4
@@2:	LODSB
	CMP	AL,'a'
	JB	@@3
	CMP	AL,'z'
	JA	@@3
	SUB	AL,20H
@@3:	STOSB
	LOOP	@@2
@@4:	MOV	AL,'='
	STOSB
	POP	DS
	PUSH	DS
	MOV	DS,PrefixSeg
	MOV	DS,DS:[2CH]
	XOR	SI,SI
@@5:	CMP	BYTE PTR [SI],0
	JE	@@7
	LEA	DI,VarName
	MOV	CX,DX
	REP	CMPSB
	JE	@@7
	DEC	SI
@@6:	LODSB
	OR	AL,AL
	JNE	@@6
	JMP	@@5
@@7:	MOV	DI,SI
	PUSH	DS
	POP	ES
	XOR	AL,AL
	MOV	CX,256
	REPNE	SCASB
	NOT	CL
	LES	DI,EnvStrP
	MOV	AL,CL
	STOSB
	REP	MOVSB
	POP	DS
	MOV	SP,BP
	POP	BP
	RET	4

GetEnv		ENDP

CODE	ENDS

	END
