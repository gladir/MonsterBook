
; *******************************************************
; *							*
; *	Turbo Pascal Runtime Library Version 5.5	*
; *	File Name Split Routine				*
; *							*
; *	Copyright (C) 1988,89 Borland International	*
; *							*
; *******************************************************

	TITLE	SPLT

	LOCALS	@@

CODE	SEGMENT	BYTE PUBLIC

	ASSUME	CS:CODE

	PUBLIC	FSplit

FSplit		PROC	FAR

PathP		EQU	(DWORD PTR [BP+18])
DirP		EQU	(DWORD PTR [BP+14])
NameP		EQU	(DWORD PTR [BP+10])
ExtP		EQU	(DWORD PTR [BP+6])

	PUSH	BP
	MOV	BP,SP
	PUSH	DS
	CLD
	LDS	SI,PathP
	LODSB
	MOV	DL,AL
	XOR	DH,DH
	MOV	BX,DX
	OR	BX,BX
	JE	@@2
@@1:	CMP	BYTE PTR [SI+BX-1],'\'
	JE	@@2
	CMP	BYTE PTR [SI+BX-1],':'
	JE	@@2
	DEC	BX
	JNE	@@1
@@2:	MOV	AX,67
	LES	DI,DirP
	CALL	CopyString
	XOR	BX,BX
	JMP	SHORT @@4
@@3:	CMP	BYTE PTR [SI+BX],'.'
	JE	@@5
	INC	BX
@@4:	CMP	BX,DX
	JNE	@@3
@@5:	MOV	AX,8
	LES	DI,NameP
	CALL	CopyString
	MOV	BX,DX
	MOV	AX,4
	LES	DI,ExtP
	CALL	CopyString
	POP	DS
	POP	BP
	RET	16

CopyString	PROC	NEAR

	SUB	DX,BX
	CMP	AX,BX
	JB	@@1
	MOV	AX,BX
@@1:	STOSB
	MOV	CX,AX
	ADD	BX,SI
	REP	MOVSB
	MOV	SI,BX
	RET

CopyString	ENDP

FSplit		ENDP

CODE	ENDS

	END
