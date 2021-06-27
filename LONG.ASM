
; *******************************************************
; *							*
; *     Turbo Pascal Runtime Library                    *
; *	Longint Arithmetic Routines			*
; *							*
; *	Copyright (C) 1988,90 Borland International	*
; *							*
; *******************************************************

	TITLE	LONG

	INCLUDE	SE.ASM

DATA	SEGMENT	WORD PUBLIC

; Externals

	EXTRN	Test8086:BYTE

DATA	ENDS

CODE	SEGMENT	BYTE PUBLIC

	ASSUME	CS:CODE,DS:DATA

; Externals

	EXTRN	HaltError:NEAR

; Publics

	PUBLIC	LongMul,LongDiv,LongShr,LongShl

; Longint multiply
; In	DX:AX = 1st operand
;	BX:CX = 2nd operand
; Out	DX:AX = Result

LongMul:

	CMP	Test8086,2
	JB	@@1
    .386
	SHL	EAX,16
	SHRD	EAX,EDX,16
	SHL	ECX,16
	SHRD	ECX,EBX,16
	IMUL	ECX
	SHLD	EDX,EAX,16
	RETF
    .8086
@@1:	MOV	SI,AX
	MOV	DI,DX
	MUL	CX
	PUSH	AX
	PUSH	DX
	MOV	AX,SI
	MUL	BX
	MOV	BX,AX
	MOV	AX,DI
	MUL	CX
	MOV	CX,AX
	POP	DX
	POP	AX
	ADD	DX,BX
	ADD	DX,CX
	RETF

; Longint division
; In	DX:AX = 1st operand
;	BX:CX = 2nd operand
; Out	DX:AX = Result
;	BX:CX = Remainder

LongDiv:

	CMP	Test8086,2
	JB	@@0
    .386
	SHL	EAX,16
	SHRD	EAX,EDX,16
	SHL	ECX,16
	SHRD	ECX,EBX,16
	JE	SHORT @@9a
	CDQ
	IDIV	ECX
	MOV	ECX,EDX
	SHLD	EDX,EAX,16
	SHLD	EBX,ECX,16
	RETF
    .8086
@@0:	PUSH	BP
	XOR	BP,BP
	OR	DX,DX
	JNS	@@1
	INC	BP
	NEG	AX
	ADC	DX,0
	NEG	DX
@@1:	OR	BX,BX
	JE	@@5
	JNS	@@2
	INC	BP
	INC	BP
	NEG	CX
	ADC	BX,0
	NEG	BX
	JE	@@5a
@@2:	PUSH	BP
	MOV	SI,CX
	MOV	DI,BX
	XOR	BX,BX
	MOV	CX,DX
	MOV	DX,AX
	XOR	AX,AX
	MOV	BP,16
@@3:	SHL	AX,1
	RCL	DX,1
	RCL	CX,1
	RCL	BX,1
	INC	AX
	SUB	CX,SI
	SBB	BX,DI
	JNC	@@4
	DEC	AX
	ADD	CX,SI
	ADC	BX,DI
@@4:	DEC	BP
	JNE	@@3
	POP	BP
	JMP	SHORT @@6
@@9:	POP	BP
@@9a:	MOV	AX,200
	JMP	HaltError
@@5:	JCXZ	@@9
@@5a:	XCHG	AX,BX
	XCHG	AX,DX
	DIV	CX
	XCHG	AX,BX
	DIV	CX
	MOV	CX,DX
	MOV	DX,BX
	XOR	BX,BX
@@6:	SHR	BP,1
	JNC	@@7
	NEG	CX
	ADC	BX,0
	NEG	BX
	INC	BP
@@7:	DEC	BP
	JNE	@@8
	NEG	AX
	ADC	DX,0
	NEG	DX
@@8:	POP	BP
	RETF

; Longint shift right
; In	DX:AX = Value
;	CX    = Shift count
; Out	DX:AX = Result

LongShr:

	CMP	Test8086,2
	JB	@@1
    .386
	SHRD	AX,DX,CL
	SHR	DX,CL
	RETF
    .8086
@@1:	AND	CX,1FH
	JE	@@3
@@2:	SHR	DX,1
	RCR	AX,1
	LOOP	@@2
@@3:	RETF

; Longint shift left
; In	DX:AX = Value
;	CX    = Shift count
; Out	DX:AX = Result

LongShl:

	CMP	Test8086,2
	JB	@@1
    .386
	SHLD	DX,AX,CL
	SHL	AX,CL
	RETF
    .8086
@@1:	AND	CX,1FH
	JE	@@3
@@2:	SHL	AX,1
	RCL	DX,1
	LOOP	@@2
@@3:	RETF

CODE	ENDS

	END
