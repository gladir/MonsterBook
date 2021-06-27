
; *******************************************************
; *							*
; *     Turbo Pascal Run-time Library                   *
; *	Textfile Real I/O				*
; *							*
; *     Copyright (c) 1988,92 Borland International     *
; *							*
; *******************************************************

	TITLE	TF48

	INCLUDE	SE.ASM

DATA	SEGMENT	WORD PUBLIC

; Externals

	EXTRN	InOutRes:WORD

DATA	ENDS

CODE	SEGMENT	BYTE PUBLIC

	ASSUME	CS:CODE,DS:DATA

; Externals

	EXTRN	Str2Real:NEAR,Real2Str:NEAR,ReadText:NEAR
	EXTRN	WriteBuffer:NEAR,WriteBlanks:NEAR

; Publics

	PUBLIC	ReadReal,WriteReal

; Read standard procedure (Real)

ReadReal:

	ARG	FileP,DWORD,1
	LOC	NumBuf,BYTE,64

	ENTRY	WINFAR
	LES	BX,FileP
	MOV	AX,OFFSET CS:@@10
	MOV	CX,64
	LEA	DI,NumBuf
	MOV	DX,SS
	CALL	ReadText
	MOV	CX,DI
	LEA	DI,NumBuf
	SUB	CX,DI
	JE	@@2
	PUSH	SS
	POP	ES
	CALL	Str2Real
	JC	@@1
	JCXZ	@@3
@@1:	MOV	InOutRes,106
@@2:	XOR	AX,AX
	MOV	BX,AX
	MOV	DX,AX
@@3:	EXIT	0
@@10:	LODSB
	CMP	AL,' '
	JA	@@12
	CMP	AL,eof
	JE	@@13
	CMP	SI,BX
	JNE	@@10
	MOV	AX,OFFSET CS:@@10
	RET
@@11:	LODSB
	CMP	AL,' '
	JBE	@@13
@@12:	STOSB
	CMP	SI,BX
	LOOPNE	@@11
	JCXZ	@@14
	MOV	AX,OFFSET CS:@@11
	RET
@@13:	DEC	SI
@@14:	XOR	AX,AX
	RET

; Write standard procedure (Real)

WriteReal:

	ARG	FileP,DWORD,1
	ARG	Value,BYTE,6
	ARG	Width,WORD,1
	ARG	Decimals,WORD,1
	LOC	NumBuf,BYTE,64

	ENTRY	WINFAR
	MOV	AX,Value.w0
	MOV	BX,Value.w2
	MOV	DX,Value.w4
	MOV	CX,Decimals
	OR	CX,CX
	JNS	@@1
	MOV	CX,6
	SUB	CX,Width
	CMP	CX,-2
	JLE	@@1
	MOV	CX,-2
@@1:	LEA	DI,NumBuf
	PUSH	SS
	POP	ES
	CALL	Real2Str
	LES	BX,FileP
	MOV	DX,Width
	SUB	DX,CX
	JLE	@@2
	PUSH	CX
	CALL	WriteBlanks
	POP	CX
@@2:	MOV	AX,CX
	LEA	SI,NumBuf
	MOV	DX,SS
	CALL	WriteBuffer
	EXIT	10

CODE	ENDS

	END
