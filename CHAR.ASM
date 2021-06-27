
; *******************************************************
; *							*
; *     Turbo Pascal Run-time Library                   *
; *	Character Handling Routines			*
; *							*
; *     Copyright (c) 1988,92 Borland International     *
; *							*
; *******************************************************

	TITLE	CHAR

	INCLUDE	SE.ASM

CODE	SEGMENT	BYTE PUBLIC

	ASSUME	CS:CODE

; Publics

	PUBLIC	UpperCase

; UpCase standard function

UpperCase:

	MOV	BX,SP
	MOV	AL,SS:[BX+4]
	CMP	AL,'a'
	JB	@@1
	CMP	AL,'z'
	JA	@@1
	SUB	AL,'a'-'A'
@@1:	RETF	2

CODE	ENDS

	END
