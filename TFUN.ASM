
; *******************************************************
; *							*
; *     Turbo Pascal Run-time Library                   *
; *	Textfile Support Functions			*
; *							*
; *     Copyright (c) 1988,92 Borland International     *
; *							*
; *******************************************************

	TITLE	TFUN

	INCLUDE	SE.ASM

CODE	SEGMENT	BYTE PUBLIC

	ASSUME	CS:CODE

; Externals

	EXTRN	ReadText:NEAR

; Publics

	PUBLIC	GetSEoln,GetSEof,GetTEoln,GetTEof

; SeekEoln standard function

GetSEoln:

	MOV	CX,0301H
	JMP	SHORT TextStatus

; SeekEof standard function

GetSEof:

	MOV	CX,0201H
	JMP	SHORT TextStatus

; Eoln standard function

GetTEoln:

	MOV	CX,0101H
	JMP	SHORT TextStatus

; Eof standard function

GetTEof:

	MOV	CX,0001H

TextStatus:

	ARG	FileP,DWORD,1

	ENTRY	WINFAR
	LES	BX,FileP
	MOV	AX,OFFSET CS:@@10
	XOR	DX,DX
	CALL	ReadText
	MOV	AL,CL
	EXIT
@@10:	LODSB
	CMP	AL,eof
	JE	@@13
	TEST	CH,1
	JE	@@11
	CMP	AL,cr
	JE	@@13
@@11:	TEST	CH,2
	JE	@@12
	CMP	AL,' '
	JA	@@12
	CMP	SI,BX
	JNE	@@10
	MOV	AX,OFFSET CS:@@10
	RET
@@12:	DEC	CX
@@13:	DEC	SI
	XOR	AX,AX
	RET

CODE	ENDS

	END
