
; *******************************************************
; *							*
; *     Turbo Pascal Run-time Library                   *
; *	Software Emulator Initialization		*
; *							*
; *     Copyright (c) 1988,92 Borland International     *
; *							*
; *******************************************************

	TITLE	EI86

	INCLUDE	SE.ASM

; Size of emulator data in stack segment

emDataSize	EQU	230

DATA	SEGMENT	WORD PUBLIC

; Externals

    IF NOT DPMIVersion
	EXTRN	StackLimit:WORD
    ENDIF

DATA	ENDS

CODE	SEGMENT	BYTE PUBLIC

	ASSUME	CS:CODE,DS:DATA

; Externals

	EXTRN	E086_Entry:NEAR,E086_Shortcut:NEAR
	EXTRN	E087_Entry:NEAR,E087_Shortcut:NEAR
	EXTRN	Check8087:NEAR,Init8087:NEAR

; Publics

	PUBLIC	InitEM86

; Initialize software emulator. Called right after main startup
; code by programs compiled in the {$N+,E+} state.

InitEM86:

	CALL	Check8087
	MOV	SI,OFFSET E087_Entry
	MOV	DI,OFFSET E087_Shortcut
	OR	AL,AL
	JNE	@@1
    IF DPMIVersion
	MOV	SS:pStackTop,emDataSize+10H
    ELSE
	MOV	StackLimit,emDataSize
    ENDIF
	MOV	SI,OFFSET E086_Entry
	MOV	DI,OFFSET E086_Shortcut
@@1:	JMP	Init8087

CODE	ENDS

	END
