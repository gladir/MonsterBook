
; *******************************************************
; *							*
; *     Turbo Pascal Run-time Library                   *
; *	Block Move and Fill Routines			*
; *							*
; *     Copyright (c) 1988,92 Borland International     *
; *							*
; *******************************************************

	TITLE	MEMH

	INCLUDE	SE.ASM

CODE	SEGMENT	BYTE PUBLIC

	ASSUME	CS:CODE

; Publics

	PUBLIC	MoveMem,FillMem

; Move standard procedure

MoveMem:

	MOV	BX,SP
	MOV	DX,DS
	LDS	SI,SS:[BX+10]
	LES	DI,SS:[BX+6]
	MOV	CX,SS:[BX+4]
	CLD
	CMP	SI,DI
	JAE	@@1
	ADD	SI,CX
	ADD	DI,CX
	DEC	SI
	DEC	DI
	STD
@@1:	REP	MOVSB
	CLD
	MOV	DS,DX
	RETF	10

; Fill standard procedure

FillMem:

	MOV	BX,SP
	LES	DI,SS:[BX+8]
	MOV	CX,SS:[BX+6]
	MOV	AL,SS:[BX+4]
	CLD
	REP	STOSB
	RETF	8

CODE	ENDS

	END
