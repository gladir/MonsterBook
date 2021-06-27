
; *******************************************************
; *							*
; *     Turbo Pascal Run-time Library                   *
; *	Textfile Boolean I/O				*
; *							*
; *     Copyright (c) 1988,92 Borland International     *
; *							*
; *******************************************************

	TITLE	TBOL

	INCLUDE	SE.ASM

CONST	SEGMENT	WORD PUBLIC

; TRUE and FALSE strings

TrueStr		DB	4,'TRUE'
FalseStr	DB	5,'FALSE'

CONST	ENDS

CODE	SEGMENT	BYTE PUBLIC

	ASSUME	CS:CODE,DS:CONST

; Externals

	EXTRN	WriteStr:NEAR

; Publics

	PUBLIC	WriteBool

; Write standard procedure (Boolean)

WriteBool:

	ARG	FileP,DWORD,1
	ARG	Value,BYTE,2
	ARG	Width,WORD,1

	ENTRY	WINFAR
	PUSH	FileP.seg
	PUSH	FileP.ofs
	MOV	AX,OFFSET DS:TrueStr
	CMP	Value,0
	JNE	@@1
	MOV	AX,OFFSET DS:FalseStr
@@1:	PUSH	DS
	PUSH	AX
	PUSH	Width
	PUSH	CS
	CALL	WriteStr
	ADD	SP,4
	EXIT	4

CODE	ENDS

	END
