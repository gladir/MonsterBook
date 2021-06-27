
; *******************************************************
; *							*
; *     Turbo Pascal Runtime Library                    *
; *	Longint Arithmetic with Overflow Checks		*
; *							*
; *	Copyright (C) 1988,92 Borland International	*
; *							*
; *******************************************************

	TITLE	LOVF

	INCLUDE	SE.ASM

DATA	SEGMENT	WORD PUBLIC

; Externals

	EXTRN	Test8086:BYTE

DATA	ENDS

CODE	SEGMENT	BYTE PUBLIC

	ASSUME	CS:CODE,DS:DATA

; Externals

	EXTRN	Overflow:NEAR

; Publics

	PUBLIC	LongMulOvf

; Longint multiply with overflow check
; In	DX:AX = 1st operand
;	BX:CX = 2nd operand
; Out	DX:AX = Result

LongMulOvf:

	CMP	Test8086,2
	JB	@@0
    .386
	SHL	EAX,16
	SHRD	EAX,EDX,16
	SHL	ECX,16
	SHRD	ECX,EBX,16
	IMUL	ECX
	JC	@@5
	SHLD	EDX,EAX,16
	RETF
    .8086
@@0:	MOV	SI,DX
	XOR	SI,BX
	OR	DX,DX
	JNS	@@1
	NEG	AX
	ADC	DX,0
	NEG	DX
@@1:	OR	BX,BX
	JNS	@@2
	NEG	CX
	ADC	BX,0
	NEG	BX
@@2:	OR	DX,DX
	JE	@@3
	XCHG	AX,CX
	XCHG	DX,BX
	OR	DX,DX
	JNE	@@5
@@3:	MOV	DI,AX
	MUL	BX
	JC	@@5
	XCHG	AX,DI
	MUL	CX
	ADD	DX,DI
	JC	@@5
	OR	SI,SI
	JNS	@@4
	NEG	AX
	ADC	DX,0
	NEG	DX
@@4:	XOR	SI,DX
	JS	@@5
	RETF
@@5:	JMP	Overflow

CODE	ENDS

	END
