
; *******************************************************
; *							*
; *     Turbo Pascal Run-time Library                   *
; *	Textfile Integer I/O				*
; *							*
; *     Copyright (c) 1988,92 Borland International     *
; *							*
; *******************************************************

	TITLE	TINT

	INCLUDE	SE.ASM

DATA	SEGMENT	WORD PUBLIC

; Externals

	EXTRN	InOutRes:WORD

DATA	ENDS

CODE	SEGMENT	BYTE PUBLIC

	ASSUME	CS:CODE,DS:DATA

; Externals

	EXTRN	Str2Int:NEAR,Int2Str:NEAR,ReadText:NEAR
	EXTRN	WriteBuffer:NEAR,WriteBlanks:NEAR

; Publics

	PUBLIC	ReadInt,WriteInt

; Read standard procedure (Integer)

ReadInt:

	ARG	FileP,DWORD,1
	LOC	NumBuf,BYTE,32

	ENTRY	WINFAR
	LES	BX,FileP
	MOV	AX,OFFSET CS:@@10
	MOV	CX,32
	LEA	DI,NumBuf
	MOV	DX,SS
	CALL	ReadText
	MOV	CX,DI
	LEA	DI,NumBuf
	SUB	CX,DI
	JE	@@2
	PUSH	SS
	POP	ES
	CALL	Str2Int
	JC	@@1
	JCXZ	@@3
@@1:	MOV	InOutRes,106
@@2:	XOR	AX,AX
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

; Write standard procedure (Integer)

WriteInt:

	ARG	FileP,DWORD,1
	ARG	Value,DWORD,1
	ARG	Width,WORD,1
	LOC	NumBuf,BYTE,32

	ENTRY	WINFAR
	MOV	AX,Value.w0
	MOV	DX,Value.w2
	LEA	DI,NumBuf[32]
	PUSH	SS
	POP	ES
	CALL	Int2Str
	LES	BX,FileP
	MOV	DX,Width
	SUB	DX,CX
	JLE	@@1
	PUSH	CX
	PUSH	DI
	CALL	WriteBlanks
	POP	DI
	POP	CX
@@1:	MOV	AX,CX
	MOV	SI,DI
	MOV	DX,SS
	CALL	WriteBuffer
	EXIT	6

CODE	ENDS

	END
