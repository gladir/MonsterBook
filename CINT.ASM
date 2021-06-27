
; *******************************************************
; *							*
; *     Turbo Pascal Run-time Library                   *
; *	Integer Str/Val	Routines (PChar)		*
; *							*
; *     Copyright (c) 1988,92 Borland International     *
; *							*
; *******************************************************

	TITLE	CINT

	INCLUDE	SE.ASM

CODE	SEGMENT	BYTE PUBLIC

	ASSUME	CS:CODE

; Externals

	EXTRN	Int2Str:NEAR,Str2Int:NEAR

; Publics

	PUBLIC	StrIntC,ValIntC

; Str standard procedure (Integer)

StrIntC:

	ARG	Value,DWORD,1
	ARG	Width,WORD,1
	ARG	StrP,DWORD,1
	ARG	StrLen,WORD,1
	LOC	NumStr,BYTE,32

	ENTRY	FAR
	MOV	AX,Value.w0
	MOV	DX,Value.w2
	LEA	DI,NumStr[32]
	PUSH	SS
	POP	ES
	CALL	Int2Str
	PUSH	DS
	MOV	SI,DI
	PUSH	SS
	POP	DS
	LES	DI,StrP
	MOV	DX,StrLen
	MOV	AX,Width
	CMP	AX,DX
	JLE	@@1
	MOV	AX,DX
@@1:	CMP	CX,DX
	JLE	@@2
	MOV	CX,DX
@@2:	CMP	AX,CX
	JGE	@@3
	MOV	AX,CX
@@3:	CLD
	SUB	AX,CX
	JE	@@4
	PUSH	CX
	MOV	CX,AX
	MOV	AL,' '
	REP	STOSB
	POP	CX
@@4:	REP	MOVSB
	XOR	AL,AL
	STOSB
	POP	DS
	EXIT

; Val standard procedure (Integer)

ValIntC:

	ARG	StrP,DWORD,1
	ARG	ErrPosP,DWORD,1

	ENTRY	FAR
	LES	DI,StrP
	MOV	CX,0FFFFH
	MOV	AL,' '
	CLD
	REPE	SCASB
	DEC	DI
	MOV	CX,0FFFFH
	XOR	AL,AL
	REPNE	SCASB
	NOT	CX
	SUB	DI,CX
	DEC	CX
	CALL	Str2Int
	JC	@@1
	JCXZ	@@2
@@1:	MOV	CX,DI
	SUB	CX,StrP.ofs
	INC	CX
	XOR	AX,AX
	MOV	DX,AX
@@2:	LES	DI,ErrPosP
	MOV	ES:[DI],CX
	EXIT

CODE	ENDS

	END
