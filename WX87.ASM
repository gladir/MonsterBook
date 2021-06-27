
; *******************************************************
; *							*
; *	Turbo Pascal Runtime Library			*
; *	Windows Emulator Exception Handler		*
; *							*
; *	Copyright (C) 1988,91 Borland International	*
; *							*
; *******************************************************

	TITLE	WX87

	INCLUDE	SE.ASM

CODE	SEGMENT	BYTE PUBLIC

	ASSUME	CS:CODE

; Externals

	EXTRN	Terminate:NEAR

; Publics

	PUBLIC	Exception

; Floating point exception handler

Exception:

	PUSH	SS			;Restore DS
	POP	DS
	MOV	DX,200			;Division by zero
	CMP	AL,83H
	JE	@@1
	MOV	DX,205			;Overflow
	CMP	AL,84H
	JE	@@1
	MOV	DX,206			;Underflow
	CMP	AL,85H
	JE	@@1
	MOV	DX,207			;Invalid FP operation
@@1:	XCHG	AX,DX
	MOV	CX,0FFFFH
	MOV	BX,CX
	JMP	Terminate

CODE	ENDS

	END
