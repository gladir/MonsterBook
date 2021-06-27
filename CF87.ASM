
; *******************************************************
; *							*
; *     Turbo Pascal Run-time Library                   *
; *	8087 Str/Val Routines (PChar)			*
; *							*
; *     Copyright (c) 1988,92 Borland International     *
; *							*
; *******************************************************

	TITLE	CF87

	INCLUDE	SE.ASM

CODE	SEGMENT	BYTE PUBLIC

	ASSUME	CS:CODE

; Externals

	EXTRN	Float2Str:NEAR,Str2Float:NEAR

; Publics

	PUBLIC	StrFloatC,ValFloatC

; Convert float to zero-terminated string
; In	[SP+8] = Field width
;	[SP+6] = Decimal count
;	[SP+2] = String pointer
;	[SP]   = Maximum length
;	ST(0)  = Value
; Out	SP     = SP+10
;	ST     = ST+1

StrFloatC:

	ARG	Width,WORD,1
	ARG	Decimals,WORD,1
	ARG	StrP,DWORD,1
	ARG	StrLen,WORD,1
	LOC	NumStr,BYTE,64

	ENTRY	FAR
	MOV	CX,Decimals
	OR	CX,CX
	JNS	@@0
	MOV	CX,8
	SUB	CX,Width
	CMP	CX,-2
	JLE	@@0
	MOV	CX,-2
@@0:	LEA	DI,NumStr
	PUSH	SS
	POP	ES
	CALL	Float2Str
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

; Convert zero-terminated string to float
; In	[SP+4] = String pointer
;	[SP]   = Error variable pointer
; Out	ST(0)  = Value
;	SP     = SP+8

ValFloatC:

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
	CALL	Str2Float
	JC	@@1
	JCXZ	@@2
@@1:	MOV	CX,DI
	SUB	CX,StrP.ofs
	INC	CX
	FSTP	ST(0)
	FLDZ
	FWAIT
@@2:	LES	DI,ErrPosP
	MOV	ES:[DI],CX
	EXIT

CODE	ENDS

	END
