
; *******************************************************
; *							*
; *     Turbo Pascal Run-time Library                   *
; *	Textfile Character I/O				*
; *							*
; *     Copyright (c) 1988,92 Borland International     *
; *							*
; *******************************************************

	TITLE	TCHR

	INCLUDE	SE.ASM

DATA	SEGMENT	WORD PUBLIC

; Externals

	EXTRN	InOutRes:WORD

DATA	ENDS

CODE	SEGMENT	BYTE PUBLIC

	ASSUME	CS:CODE,DS:DATA

; Externals

	EXTRN	InOutProc:NEAR,WriteBlanks:NEAR

; Publics

	PUBLIC	ReadChar,WriteChar

; Read standard procedure (Char)

ReadChar:

	ARG	FileP,DWORD,1

	ENTRY	WINFAR
	CMP	InOutRes,0
	JNE	@@4
	LES	BX,FileP
	CMP	ES:[BX].fMode,fmInput
	JNE	@@3
	MOV	DI,ES:[BX].fBufPos
	CMP	DI,ES:[BX].fBufEnd
	JNE	@@1
	CALL	InOutProc
	LES	BX,FileP
	MOV	DI,ES:[BX].fBufPos
	CMP	DI,ES:[BX].fBufEnd
	JE	@@4
@@1:	INC	ES:[BX].fBufPos
	LES	BX,ES:[BX].fBufPtr
	MOV	AL,ES:[BX+DI]
@@2:	EXIT	0
@@3:	MOV	InOutRes,104
@@4:	MOV	AL,eof
	JMP	@@2

; Write standard procedure (Char)

WriteChar:

	ARG	FileP,DWORD,1
	ARG	Value,BYTE,2
	ARG	Width,WORD,1

	ENTRY	WINFAR
	LES	BX,FileP
	MOV	DX,Width
	DEC	DX
	JLE	@@1
	CALL	WriteBlanks
@@1:	CMP	InOutRes,0
	JNE	@@2
	CMP	ES:[BX].fMode,fmOutput
	JNE	@@3
	INC	ES:[BX].fBufPos
	MOV	DI,ES:[BX].fBufPos
	MOV	DX,ES:[BX].fBufSize
	LES	BX,ES:[BX].fBufPtr
	MOV	AL,Value
	MOV	ES:[BX+DI-1],AL
	CMP	DI,DX
	JNE	@@2
	LES	BX,FileP
	CALL	InOutProc
@@2:	EXIT	4
@@3:	MOV	InOutRes,105
	JMP	@@2

CODE	ENDS

	END
