
; *******************************************************
; *							*
; *	Turbo Pascal Runtime Library Version 5.5	*
; *	File Search Routine				*
; *							*
; *	Copyright (C) 1988,89 Borland International	*
; *							*
; *******************************************************

	TITLE	SRCH

	LOCALS	@@

CODE	SEGMENT	BYTE PUBLIC

	ASSUME	CS:CODE

	PUBLIC	FSearch

FSearch		PROC	FAR

ResultP		EQU	(DWORD PTR [BP+14])
NameP		EQU	(DWORD PTR [BP+10])
PathP		EQU	(DWORD PTR [BP+6])

	PUSH	BP
	MOV	BP,SP
	PUSH	DS
	CLD
	LDS	SI,PathP
	LODSB
	MOV	BL,AL
	XOR	BH,BH
	ADD	BX,SI
	LES	DI,ResultP
	INC	DI
@@1:	PUSH	SI
	PUSH	DS
	LDS	SI,NameP
	LODSB
	MOV	CL,AL
	XOR	CH,CH
	REP	MOVSB
	XOR	AL,AL
	STOSB
	DEC	DI
	MOV	AX,4300H
	LDS	DX,ResultP
	INC	DX
	INT	21H
	POP	DS
	POP	SI
	JC	@@2
	TEST	CX,18H
	JE	@@5
@@2:	LES	DI,ResultP
	INC	DI
	CMP	SI,BX
	JE	@@5
	XOR	AX,AX
@@3:	LODSB
	CMP	AL,';'
	JE	@@4
	STOSB
	MOV	AH,AL
	CMP	SI,BX
	JNE	@@3
@@4:	CMP	AH,':'
	JE	@@1
	CMP	AH,'\'
	JE	@@1
	MOV	AL,'\'
	STOSB
	JMP	@@1
@@5:	MOV	AX,DI
	LES	DI,ResultP
	SUB	AX,DI
	DEC	AX
	STOSB
@@6:	POP	DS
	POP	BP
	RET	8

FSearch		ENDP

CODE	ENDS

	END
