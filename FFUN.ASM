
; *******************************************************
; *							*
; *     Turbo Pascal Run-time Library                   *
; *	File Support Functions				*
; *							*
; *     Copyright (c) 1988,92 Borland International     *
; *							*
; *******************************************************

	TITLE	FFUN

	INCLUDE	SE.ASM

DATA	SEGMENT	WORD PUBLIC

; Externals

	EXTRN	InOutRes:WORD

DATA	ENDS

CODE	SEGMENT	BYTE PUBLIC

	ASSUME	CS:CODE,DS:DATA

; Externals

	EXTRN	LongDiv:NEAR

; Publics

	PUBLIC	GetFPos,GetFSize,GetFEof

; FilePos standard function

GetFPos:

	CALL	FileData
	JC	@@1
	MOV	CX,ES:[DI].fBufSize
	CMP	CX,1
	JE	@@1
	XOR	BX,BX
	PUSH	CS
	CALL	LongDiv
@@1:	RETF	4

; FileSize standard function

GetFSize:

	CALL	FileData
	JC	@@1
	MOV	AX,CX
	MOV	DX,BX
	MOV	CX,ES:[DI].fBufSize
	CMP	CX,1
	JE	@@1
	XOR	BX,BX
	PUSH	CS
	CALL	LongDiv
@@1:	RETF	4

; Eof standard function

GetFEof:

	CALL	FileData
	JC	@@1
	SUB	AX,CX
	SBB	DX,BX
	JC	@@1
	MOV	AL,1
	RETF	4
@@1:	XOR	AL,AL
	RETF	4

; Get file data
; Out	ES:DI = File record pointer
;	DX:AX = File position
;	BX:CX = File size
;	CF    = 1 if not open

FileData:

	MOV	BX,SP
	LES	DI,SS:[BX+6]
	CMP	ES:[DI].fMode,fmInOut
	JNE	@@1
	XOR	CX,CX
	XOR	DX,DX
	MOV	BX,ES:[DI].fHandle
	MOV	AX,dosSeek*256+1
	INT	DOS
	PUSH	DX
	PUSH	AX
	XOR	CX,CX
	XOR	DX,DX
	MOV	BX,ES:[DI].fHandle
	MOV	AX,dosSeek*256+2
	INT	DOS
	POP	BX
	POP	CX
	PUSH	DX
	PUSH	AX
	MOV	DX,BX
	MOV	BX,ES:[DI].fHandle
	MOV	AX,dosSeek*256
	INT	DOS
	POP	CX
	POP	BX
	RET
@@1:	MOV	InOutRes,103
	XOR	AX,AX
	XOR	DX,DX
	STC
	RET

CODE	ENDS

	END
