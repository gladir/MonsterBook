
; *******************************************************
; *							*
; *     Turbo Pascal Run-time Library                   *
; *	Data Segment Initialization			*
; *							*
; *     Copyright (c) 1988,92 Borland International     *
; *							*
; *******************************************************

	TITLE	LAST

; This module must be the last one linked into the System unit. That
; way, the ConstEnd and DataEnd symbols will mark the end of the
; initialized and uninitialized portions of the data segment.

CONST	SEGMENT	WORD PUBLIC

; End of initialized portion of data segment

ConstEnd	LABEL	WORD

CONST	ENDS

DATA	SEGMENT WORD PUBLIC

; End of uninitialized portion of data segment

DataEnd		LABEL	WORD

DATA	ENDS

DGROUP	GROUP	CONST,DATA

CODE	SEGMENT	BYTE PUBLIC

	ASSUME	CS:CODE,DS:DGROUP

; Publics

	PUBLIC	ClearDSeg

; Clear uninitialized data segment

ClearDSeg:

	MOV	DI,OFFSET ConstEnd
	PUSH	DS
	POP	ES
	MOV	CX,OFFSET DataEnd
	SUB	CX,DI
	SHR	CX,1
	XOR	AX,AX
	CLD
	REP	STOSW
	RET

CODE	ENDS

	END
