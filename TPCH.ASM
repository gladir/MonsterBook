
; *******************************************************
; *							*
; *     Turbo Pascal Run-time Library                   *
; *	Textfile Character Array I/O			*
; *							*
; *     Copyright (c) 1988,92 Borland International     *
; *							*
; *******************************************************

	TITLE	TPCH

	INCLUDE	SE.ASM

CODE	SEGMENT	BYTE PUBLIC

	ASSUME	CS:CODE

; Externals

	EXTRN	ReadText:NEAR,WriteBuffer:NEAR,WriteBlanks:NEAR

; Publics

	PUBLIC	ReadPChar,WritePChar

; Read standard procedure (PChar)

	ARG	FileP,DWORD,1
	ARG	StrP,DWORD,1
	ARG	StrLen,WORD,1

ReadPChar:

	ENTRY	WINFAR
	LES	BX,FileP
	MOV	AX,OFFSET CS:@@10
	MOV	CX,StrLen
	MOV	DI,StrP.ofs
	MOV	DX,StrP.seg
	CALL	ReadText
	MOV	ES,DX
	XOR	AX,AX
	STOSB
	EXIT	6
@@10:	JCXZ	@@13
@@11:	LODSB
	CMP	AL,cr
	JE	@@12
	CMP	AL,eof
	JE	@@12
	STOSB
	CMP	SI,BX
	LOOPNE	@@11
	JCXZ	@@13
	MOV	AX,OFFSET CS:@@11
	RET
@@12:	DEC	SI
@@13:	XOR	AX,AX
	RET

; Write standard procedure (PChar)

WritePChar:

	ARG	FileP,DWORD,1
	ARG	StrP,DWORD,1
	ARG	Width,WORD,1

	ENTRY	WINFAR
	MOV	AX,StrP.ofs
	OR	AX,StrP.seg
	JE	@@1
	LES	DI,StrP
	MOV	CX,0FFFFH
	XOR	AL,AL
	CLD
	REPNE	SCASB
	MOV	AX,0FFFEH
	SUB	AX,CX
@@1:	LES	BX,FileP
	OR	AX,AX
	JS	@@2
	MOV	DX,Width
	SUB	DX,AX
	JLE	@@2
	PUSH	AX
	CALL	WriteBlanks
	POP	AX
@@2:	OR	AX,AX
	JE	@@3
	MOV	SI,StrP.ofs
	MOV	DX,StrP.seg
	CALL	WriteBuffer
@@3:	EXIT	6

CODE	ENDS

	END
