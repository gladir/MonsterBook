
; *******************************************************
; *							*
; *     Turbo Pascal Run-time Library                   *
; *	Integer Str/Val	Routines			*
; *							*
; *     Copyright (c) 1988,92 Borland International     *
; *							*
; *******************************************************

	TITLE	SINT

	INCLUDE	SE.ASM

CODE	SEGMENT	BYTE PUBLIC

	ASSUME	CS:CODE

; Externals

	EXTRN	Int2Str:NEAR,Str2Int:NEAR

; Publics

	PUBLIC	StrInt,ValInt

; Str standard procedure (Integer)

StrInt:

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
	STOSB
	SUB	AX,CX
	JE	@@4
	PUSH	CX
	MOV	CX,AX
	MOV	AL,' '
	REP	STOSB
	POP	CX
@@4:	REP	MOVSB
	POP	DS
	EXIT

; Val standard procedure (Integer)

ValInt:

	ARG	StrP,DWORD,1
	ARG	ErrPosP,DWORD,1

	ENTRY	FAR
	LES	DI,StrP
	MOV	CL,ES:[DI]
	XOR	CH,CH
	INC	DI
	JCXZ	@@2
@@1:	CMP	BYTE PTR ES:[DI],' '
	JNE	@@2
	INC	DI
	LOOP	@@1
@@2:	CALL	Str2Int
	JC	@@3
	JCXZ	@@4
@@3:	MOV	CX,DI
	SUB	CX,StrP.ofs
	XOR	AX,AX
	XOR	DX,DX
@@4:	LES	DI,ErrPosP
	MOV	ES:[DI],CX
	EXIT

CODE	ENDS

	END
