
; *******************************************************
; *							*
; *     Turbo Pascal Run-time Library                   *
; *	Variable Support Routines			*
; *							*
; *     Copyright (c) 1988,92 Borland International     *
; *							*
; *******************************************************

	TITLE	VARH

	INCLUDE	SE.ASM

CODE	SEGMENT	BYTE PUBLIC

	ASSUME	CS:CODE

; Publics

	PUBLIC	BlockMove

; Move standard procedure

BlockMove:

	MOV	BX,SP
	MOV	DX,DS
	LDS	SI,SS:[BX+10]
	LES	DI,SS:[BX+6]
	MOV	CX,SS:[BX+4]
	CLD
	REP	MOVSB
	MOV	DS,DX
	RETF	10

CODE	ENDS

	END
