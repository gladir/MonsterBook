
; *******************************************************
; *							*
; *	Turbo Pascal Runtime Library Version 5.5	*
; *	File Attribute Routines				*
; *							*
; *	Copyright (C) 1988,89 Borland International	*
; *							*
; *******************************************************

	TITLE	FATR

	LOCALS	@@

DATA	SEGMENT	WORD PUBLIC

	EXTRN	DosError:WORD

DATA	ENDS

CODE	SEGMENT	BYTE PUBLIC

	ASSUME	CS:CODE,DS:DATA

	PUBLIC	GetFAttr

GetFAttr	PROC	FAR

FileP		EQU	(DWORD PTR [BP+10])
AttrP		EQU	(DWORD PTR [BP+6])

	PUSH	BP
	MOV	BP,SP
	PUSH	DS
	LDS	DX,FileP
	ADD	DX,48
	MOV	AX,4300H
	INT	21H
	POP	DS
	JNC	@@1
	XOR	CX,CX
	JMP	SHORT @@2
@@1:	XOR	AX,AX
@@2:	MOV	DosError,AX
	LES	DI,AttrP
	XCHG	AX,CX
	STOSW
	POP	BP
	RET	8

GetFAttr	ENDP

	PUBLIC	SetFAttr

SetFAttr	PROC	FAR

FileP		EQU	(DWORD PTR [BP+8])
Attr		EQU	(WORD PTR [BP+6])

	PUSH	BP
	MOV	BP,SP
	PUSH	DS
	LDS	DX,FileP
	ADD	DX,48
	MOV	CX,Attr
	MOV	AX,4301H
	INT	21H
	POP	DS
	JC	@@1
	XOR	AX,AX
@@1:	MOV	DosError,AX
	POP	BP
	RET	6

SetFAttr	ENDP

CODE	ENDS

	END
