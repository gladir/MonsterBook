
; *******************************************************
; *							*
; *	Turbo Pascal Runtime Library Version 5.5	*
; *	Directory Search Routines			*
; *							*
; *	Copyright (C) 1988,89 Borland International	*
; *							*
; *******************************************************

	TITLE	FIND

	LOCALS	@@

DATA	SEGMENT	WORD PUBLIC

	EXTRN	DosError:WORD

DATA	ENDS

CODE	SEGMENT	BYTE PUBLIC

	ASSUME	CS:CODE,DS:DATA

	PUBLIC	FindFirst

FindFirst	PROC	FAR

PathP		EQU	(DWORD PTR [BP+12])
Attr		EQU	(WORD PTR [BP+10])
SearchP		EQU	(DWORD PTR [BP+6])
PathBuf		EQU	(BYTE PTR [BP-80])

	PUSH	BP
	MOV	BP,SP
	SUB	SP,80
	PUSH	DS
	LDS	SI,PathP
	LEA	DI,PathBuf
	PUSH	SS
	POP	ES
	CLD
	LODSB
	CMP	AL,79
	JB	@@1
	MOV	AL,79
@@1:	CBW
	XCHG	AX,CX
	REP	MOVSB
	XOR	AL,AL
	STOSB
	LDS	DX,SearchP
	MOV	AH,1AH
	INT	21H
	LEA	DX,PathBuf
	PUSH	SS
	POP	DS
	MOV	CX,Attr
	MOV	AH,4EH
	INT	21H
	POP	DS
	LES	DI,SearchP
	CALL	FindExit
	MOV	SP,BP
	POP	BP
	RET	10

FindFirst	ENDP

	PUBLIC	FindNext

FindNext	PROC	FAR

SearchP		EQU	(DWORD PTR [BP+6])

	PUSH	BP
	MOV	BP,SP
	PUSH	DS
	LDS	DX,SearchP
	MOV	AH,1AH
	INT	21H
	POP	DS
	MOV	AH,4FH
	INT	21H
	LES	DI,SearchP
	CALL	FindExit
	POP	BP
	RET	4

FindNext	ENDP

FindExit	PROC	NEAR

	JC	@@1
	ADD	DI,30
	PUSH	DS
	PUSH	ES
	POP	DS
	XOR	AL,AL
	MOV	CX,256
	CLD
	REPNE	SCASB
	NOT	CL
	MOV	AL,CL
	DEC	DI
	MOV	SI,DI
	DEC	SI
	STD
	REP	MOVSB
	STOSB
	CLD
	POP	DS
	XOR	AX,AX
@@1:	MOV	DosError,AX
	RET

FindExit	ENDP

CODE	ENDS

	END
