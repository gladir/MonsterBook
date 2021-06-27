
; *******************************************************
; *							*
; *	Turbo Pascal Runtime Library Version 5.5	*
; *	File Date and Time Routines			*
; *							*
; *	Copyright (C) 1988,89 Borland International	*
; *							*
; *******************************************************

	TITLE	FTIM

	LOCALS	@@

DATA	SEGMENT	WORD PUBLIC

	EXTRN	DosError:WORD

DATA	ENDS

CODE	SEGMENT	BYTE PUBLIC

	ASSUME	CS:CODE,DS:DATA

	PUBLIC	GetFTime

GetFTime	PROC	FAR

FileP		EQU	(DWORD PTR [BP+10])
TimeP		EQU	(DWORD PTR [BP+6])

	PUSH	BP
	MOV	BP,SP
	LES	DI,FileP
	MOV	BX,ES:[DI]
	MOV	AX,5700H
	INT	21H
	JNC	@@1
	XOR	CX,CX
	XOR	DX,DX
	JMP	SHORT @@2
@@1:	XOR	AX,AX
@@2:	MOV	DosError,AX
	LES	DI,TimeP
	CLD
	XCHG	AX,CX
	STOSW
	XCHG	AX,DX
	STOSW
	POP	BP
	RET	8

GetFTime	ENDP

	PUBLIC	SetFTime

SetFTime	PROC	FAR

FileP		EQU	(DWORD PTR [BP+10])
TimeH		EQU	(WORD PTR [BP+8])
TimeL		EQU	(WORD PTR [BP+6])

	PUSH	BP
	MOV	BP,SP
	LES	DI,FileP
	MOV	BX,ES:[DI]
	MOV	CX,TimeL
	MOV	DX,TimeH
	MOV	AX,5701H
	INT	21H
	JC	@@1
	XOR	AX,AX
@@1:	MOV	DosError,AX
	POP	BP
	RET	8

SetFTime	ENDP

CODE	ENDS

	END
