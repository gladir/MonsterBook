
; *******************************************************
; *							*
; *     Turbo Pascal Run-time Library                   *
; *	Command Line Parameter Routines			*
; *							*
; *     Copyright (c) 1988,92 Borland International     *
; *							*
; *******************************************************

	TITLE	PARS

	INCLUDE	SE.ASM

DATA	SEGMENT	WORD PUBLIC

; Externals

	EXTRN	PrefixSeg:WORD

DATA	ENDS

CODE	SEGMENT	BYTE PUBLIC

	ASSUME	CS:CODE,DS:DATA

; Publics

	PUBLIC	GetParStr,GetParCnt

; ParamStr standard function

GetParStr:

	ARG	StrP,DWORD,1
	ARG	Index,WORD,1

	ENTRY	FAR
	MOV	DX,Index
	OR	DX,DX
	JE	@@1
	CALL	ParStrCnt
	JMP	SHORT @@4
@@1:	MOV	AH,dosGetVersion
	INT	DOS
	CMP	AL,3
	MOV	AX,0
	JB	@@4
	MOV	ES,PrefixSeg
	MOV	ES,ES:pspEnvSeg
	XOR	DI,DI
	CLD
@@2:	CMP	AL,ES:[DI]
	JE	@@3
	MOV	CX,-1
	REPNE	SCASB
	JMP	@@2
@@3:	ADD	DI,3
	MOV	SI,DI
	MOV	CX,256
	REPNE	SCASB
	XCHG	AX,CX
	NOT	AL
@@4:	PUSH	DS
	PUSH	ES
	POP	DS
	LES	DI,StrP
	CLD
	STOSB
	XCHG	AX,CX
	REP	MOVSB
	POP	DS
	EXIT	2

; ParamCount standard function

GetParCnt:

	XOR	DX,DX
	CALL	ParStrCnt
	XCHG	AX,BX
	RETF

; Return parameter string and count
; In	DX    = Parameter string number
; Out	AX    = Parameter string length
;	BX    = Parameter string count
;	ES:SI = Parameter string pointer

ParStrCnt:

	MOV	ES,PrefixSeg
	MOV	DI,OFFSET pspCmdLine
	MOV	CL,ES:[DI]
	XOR	CH,CH
	INC	DI
	XOR	BX,BX
@@1:	JCXZ	@@3
@@2:	CMP	BYTE PTR ES:[DI],' '
	JA	@@3
	INC	DI
	LOOP	@@2
@@3:	MOV	SI,DI
	JCXZ	@@5
@@4:	CMP	BYTE PTR ES:[DI],' '
	JBE	@@5
	INC	DI
	LOOP	@@4
@@5:	MOV	AX,DI
	SUB	AX,SI
	JE	@@6
	INC	BX
	DEC	DX
	JNZ	@@1
@@6:	RET

CODE	ENDS

	END
