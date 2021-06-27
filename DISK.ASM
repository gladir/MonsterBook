
; *******************************************************
; *							*
; *	Turbo Pascal Runtime Library Version 5.5	*
; *	Disk Status Routines				*
; *							*
; *	Copyright (C) 1988,89 Borland International	*
; *							*
; *******************************************************

	TITLE	DISK

	LOCALS	@@

CODE	SEGMENT	BYTE PUBLIC

	ASSUME	CS:CODE

	PUBLIC	DiskFree

DiskFree	PROC	FAR

Drive		EQU	(BYTE PTR [BP+6])

	PUSH	BP
	MOV	BP,SP
	MOV	DL,Drive
	MOV	AH,36H
	INT	21H
	MOV	DX,AX
	CMP	AX,0FFFFH
	JE	@@1
	MUL	CX
	MUL	BX
@@1:	POP	BP
	RET	2

DiskFree	ENDP

	PUBLIC	DiskSize

DiskSize	PROC	FAR

Drive		EQU	(BYTE PTR [BP+6])

	PUSH	BP
	MOV	BP,SP
	MOV	DL,Drive
	MOV	AH,36H
	INT	21H
	MOV	BX,DX
	MOV	DX,AX
	CMP	AX,0FFFFH
	JE	@@1
	MUL	CX
	MUL	BX
@@1:	POP	BP
	RET	2

DiskSize	ENDP

CODE	ENDS

	END
