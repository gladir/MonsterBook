
; *******************************************************
; *							*
; *	Turbo Pascal Runtime Library			*
; *	Textfile String I/O				*
; *							*
; *	Copyright (C) 1988,92 Borland International	*
; *							*
; *******************************************************

	TITLE	TSTR

	INCLUDE	SE.ASM

CODE	SEGMENT	BYTE PUBLIC

	ASSUME	CS:CODE

; Externals

	EXTRN	ReadText:NEAR,WriteBlanks:NEAR,WriteBuffer:NEAR

; Publics

	PUBLIC	ReadStr,WriteStr

; Read standard procedure (String)

	ARG	FileP,DWORD,1
	ARG	StrP,DWORD,1
	ARG	StrLen,WORD,1

ReadStr:

	ENTRY	WINFAR
	LES	BX,FileP
	MOV	AX,OFFSET CS:@@10
	MOV	CX,StrLen
	MOV	DI,StrP.ofs
	MOV	DX,StrP.seg
	INC	DI
	CALL	ReadText
	MOV	AX,DI
	LES	DI,StrP
	SUB	AX,DI
	DEC	AX
	STOSB
	EXIT	6
@@10:	LODSB
	CMP	AL,cr
	JE	@@11
	CMP	AL,eof
	JE	@@11
	STOSB
	CMP	SI,BX
	LOOPNE	@@10
	JCXZ	@@12
	MOV	AX,OFFSET CS:@@10
	RET
@@11:	DEC	SI
@@12:	XOR	AX,AX
	RET

; Write standard procedure (String)

WriteStr:

	ARG	FileP,DWORD,1
	ARG	StrP,DWORD,1
	ARG	Width,WORD,1

	ENTRY	WINFAR
	LES	BX,StrP
	MOV	AL,ES:[BX]
	XOR	AH,AH
	LES	BX,FileP
	MOV	DX,Width
	SUB	DX,AX
	JLE	@@1
	PUSH	AX
	CALL	WriteBlanks
	POP	AX
@@1:	OR	AX,AX
	JE	@@2
	MOV	SI,StrP.ofs
	MOV	DX,StrP.seg
	INC	SI
	CALL	WriteBuffer
@@2:	EXIT	6

CODE	ENDS

	END
