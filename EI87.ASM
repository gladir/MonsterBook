
; *******************************************************
; *							*
; *     Turbo Pascal Run-time Library                   *
; *	Hardware Emulator Initialization		*
; *							*
; *     Copyright (c) 1988,92 Borland International     *
; *							*
; *******************************************************

	TITLE	EI87

	INCLUDE	SE.ASM

CODE	SEGMENT	BYTE PUBLIC

	ASSUME	CS:CODE

; Externals

	EXTRN	E087_Entry:NEAR,E087_Shortcut:NEAR
	EXTRN	Check8087:NEAR,Init8087:NEAR,HaltTurbo:NEAR

; Publics

	PUBLIC	InitEM87

; Initialize hardware emulator. Called right after main startup
; code by programs compiled in the {$N+,E-} state.

InitEM87:

	CALL	Check8087
	OR	AL,AL
	JE	@@1
	MOV	SI,OFFSET E087_Entry
	MOV	DI,OFFSET E087_Shortcut
	JMP	Init8087
@@1:	PUSH	DS
	MOV	DX,OFFSET CS:ErrorStr
	PUSH	CS
	POP	DS
	MOV	AH,9
	INT	DOS
	POP	DS
	MOV	AX,255
	JMP	HaltTurbo

; 8087 error string

ErrorStr	DB	'Numeric co-processor required',cr,lf,'$'

CODE	ENDS

	END
