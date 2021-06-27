
; *******************************************************
; *							*
; *	Turbo Pascal Runtime Library			*
; *	Windows Emulator Initialization			*
; *							*
; *	Copyright (C) 1988,92 Borland International	*
; *							*
; *******************************************************

	TITLE	WI87

	INCLUDE	SE.ASM

; Windows entry points

	EXTRN	__FPMath:FAR

CODE	SEGMENT	BYTE PUBLIC

	ASSUME	CS:CODE

; Externals

	EXTRN	Exception:NEAR

; Publics

	PUBLIC	InitEM86,InitEM87

; Initialize 8087 emulator. Called right after main startup code
; by programs compiled in the {$N+} state.

InitEM86:
InitEM87:

	ENTRY	WINFAR
	XOR	BX,BX
	CALL	__FPMath
	MOV	BX,3
	MOV	AX,OFFSET Exception
	MOV	DX,SEG Exception
	CALL	__FPMath
	EXIT

CODE	ENDS

	END
