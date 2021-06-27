
; *******************************************************
; *							*
; *     Turbo Pascal Run-time Library                   *
; *	Windows Command Line Parameter Routines		*
; *							*
; *     Copyright (c) 1988,92 Borland International     *
; *							*
; *******************************************************

	TITLE	WPAR

	INCLUDE	SE.ASM

DATA	SEGMENT	WORD PUBLIC

; Externals

	EXTRN	HInstance:WORD,CmdLine:DWORD

DATA	ENDS

; Windows entry points

	EXTRN	GetModuleFileName:FAR

CODE	SEGMENT	BYTE PUBLIC

	ASSUME	CS:CODE,DS:DATA

; Publics

	PUBLIC	GetParStr,GetParCnt

; ParamStr standard function

GetParStr:

	ARG	StrP,DWORD,1
	ARG	Index,WORD,1

	ENTRY	WINFAR
	MOV	CX,Index
	JCXZ	@@1
	PUSH	DS
	CALL	ParStrCnt
	MOV	SI,BX
	LES	DI,StrP
	STOSB
	XCHG	AX,CX
	REP	MOVSB
	POP	DS
	JMP	SHORT @@2
@@1:	PUSH	HInstance
	LES	DI,StrP
	INC	DI
	PUSH	ES
	PUSH	DI
	MOV	AX,255
	PUSH	AX
	CALL	GetModuleFileName
	LES	DI,StrP
	STOSB
@@2:	EXIT	2

; ParamCount standard function

GetParCnt:

	PUSH	DS
	XOR	CX,CX
	CALL	ParStrCnt
	XCHG	AX,CX
	NEG	AX
	POP	DS
	RETF

; Return parameter string and count
; In	CX    = Parameter string number
; Out	AX    = Parameter string length
;	CX    = Negative parameter string count
;	DS:BX = Parameter string pointer

ParStrCnt:

	LDS	SI,CmdLine
	CLD
@@1:	LODSB
	OR	AL,AL
	JE	@@2
	CMP	AL,' '
	JBE	@@1
@@2:	DEC	SI
	MOV	BX,SI
@@3:	LODSB
	CMP	AL,' '
	JA	@@3
	DEC	SI
	MOV	AX,SI
	SUB	AX,BX
	JE	@@4
	LOOP	@@1
@@4:	RET

CODE	ENDS

	END
