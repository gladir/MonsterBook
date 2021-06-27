
; *******************************************************
; *							*
; *	Turbo Pascal Runtime Library Version 5.5	*
; *	Time Pack and Unpack Routines			*
; *							*
; *	Copyright (C) 1988,89 Borland International	*
; *							*
; *******************************************************

	TITLE	PTIM

CODE	SEGMENT	BYTE PUBLIC

	ASSUME	CS:CODE

	PUBLIC	UnpackTime

UnpackTime	PROC	FAR

TimeH		EQU	(WORD PTR [BP+12])
TimeL		EQU	(WORD PTR [BP+10])
TimeRecP	EQU	(DWORD PTR [BP+6])

	PUSH	BP
	MOV	BP,SP
	LES	DI,TimeRecP
	CLD
	MOV	AX,TimeH
	MOV	CL,9
	SHR	AX,CL
	ADD	AX,1980
	STOSW
	MOV	AX,TimeH
	MOV	CL,5
	SHR	AX,CL
	AND	AX,15
	STOSW
	MOV	AX,TimeH
	AND	AX,31
	STOSW
	MOV	AX,TimeL
	MOV	CL,11
	SHR	AX,CL
	STOSW
	MOV	AX,TimeL
	MOV	CL,5
	SHR	AX,CL
	AND	AX,63
	STOSW
	MOV	AX,TimeL
	AND	AX,31
	SHL	AX,1
	STOSW
	POP	BP
	RET	8

UnpackTime	ENDP

	PUBLIC	PackTime

PackTime	PROC	FAR

TimeRecP	EQU	(DWORD PTR [BP+10])
TimeP		EQU	(DWORD PTR [BP+6])

	PUSH	BP
	MOV	BP,SP
	PUSH	DS
	LDS	SI,TimeRecP
	CLD
	LODSW
	SUB	AX,1980
	MOV	CL,9
	SHL	AX,CL
	XCHG	AX,DX
	LODSW
	MOV	CL,5
	SHL	AX,CL
	ADD	DX,AX
	LODSW
	ADD	DX,AX
	LODSW
	MOV	CL,11
	SHL	AX,CL
	XCHG	AX,BX
	LODSW
	MOV	CL,5
	SHL	AX,CL
	ADD	BX,AX
	LODSW
	SHR	AX,1
	ADD	AX,BX
	POP	DS
	LES	DI,TimeP
	STOSW
	XCHG	AX,DX
	STOSW
	POP	BP
	RET	8

PackTime	ENDP

CODE	ENDS

	END
