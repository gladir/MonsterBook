
; *******************************************************
; *							*
; *     Turbo Pascal Runtime Library                    *
; *	Real Kernel Routines				*
; *							*
; *	Copyright (C) 1988,90 Borland International	*
; *							*
; *******************************************************

	TITLE	FP48

	INCLUDE	SE.ASM

CODE	SEGMENT	BYTE PUBLIC

	ASSUME	CS:CODE

; Publics

	PUBLIC	RealAdd,RealSub,RealMul,RealDiv,RealCmp
	PUBLIC	RealFloat,RealTrunc

; The 6-byte real kernel routines operate on two floating point
; pseudo-registers, referred to as R1 and R2. Each pseudo-register
; is the concatenation of three 8086 registers. R1 is DX:BX:AX,
; and R2 is DI:SI:CX.

; Real subtraction
; In	R1 = 1st operand
;	R2 = 2nd operand
; Out	R1 = Result
;	CF = 1 if overflow
; Uses	CX,SI,DI

RealSub:

	XOR	DI,8000H

; Real addition
; In	R1 = 1st operand
;	R2 = 2nd operand
; Out	R1 = Result
;	CF = 1 if overflow
; Uses	CX,SI,DI

RealAdd:

	OR	CL,CL
	JE	@@8
	OR	AL,AL
	JE	@@9
	CMP	AL,CL
	JBE	@@1
	XCHG	AX,CX
	XCHG	BX,SI
	XCHG	DX,DI
@@1:	SUB	AL,CL
	NEG	AL
	CMP	AL,41
	JAE	@@9
	XCHG	AL,CL
	PUSH	BP
	PUSH	AX
	MOV	AH,DH
	AND	AH,80H
	MOV	BP,AX
	XOR	AX,DI
	POP	AX
	PUSHF
	MOV	AL,0
	OR	DH,80H
	OR	DI,8000H
@@2:	CMP	CL,8
	JB	@@3
	MOV	AL,AH
	MOV	AH,BL
	MOV	BL,BH
	MOV	BH,DL
	MOV	DL,DH
	XOR	DH,DH
	SUB	CL,8
	JMP	@@2
@@3:	OR	CL,CL
	JE	@@5
@@4:	SHR	DX,1
	RCR	BX,1
	RCR	AX,1
	DEC	CL
	JNE	@@4
@@5:	POPF
	JS	@@12
	ADD	AX,CX
	ADC	BX,SI
	ADC	DX,DI
	MOV	CX,BP
	POP	BP
	JNC	@@6
	RCR	DX,1
	RCR	BX,1
	RCR	AX,1
	INC	CL
	JE	@@11
@@6:	ADD	AX,80H
	ADC	BX,0
	ADC	DX,0
	JC	@@10
@@7:	MOV	AL,CL
	AND	DH,7FH
	OR	DH,CH
@@8:	RET
@@9:	MOV	AX,CX
	MOV	BX,SI
	MOV	DX,DI
	RET
@@10:	RCR	DX,1
	INC	CL
	JNE	@@7
@@11:	STC
	RET
@@12:	SUB	AX,CX
	SBB	BX,SI
	SBB	DX,DI
	MOV	CX,BP
	POP	BP
	JNC	@@13
	NOT	DX
	NOT	BX
	NEG	AX
	CMC
	ADC	BX,0
	ADC	DX,0
	XOR	CH,80H
@@13:	MOV	DI,DX
	OR	DI,BX
	OR	DI,AX
	JE	@@8
@@14:	OR	DH,DH
	JS	@@6
	SHL	AX,1
	RCL	BX,1
	RCL	DX,1
	DEC	CL
	JNE	@@14

; Return zero

ExitZero1:

	JMP	ExitZero

; Real multiplication
; In	R1 = 1st operand
;	R2 = 2nd operand
; Out	R1 = Result
;	CF = 1 if overflow
; Uses	CX,SI,DI

RealMul:

	OR	AL,AL
	JE	ExitZero1
	OR	CL,CL
	JE	ExitZero1
	PUSH	BP
	MOV	BP,DX
	XOR	DX,DI
	AND	DX,8000H
	XCHG	DL,AL
	ADD	DL,CL
	ADC	DH,AL
	MOV	CL,AL
	OR	BP,8000H
	OR	DI,8000H
	PUSH	DX
	OR	AH,AH
	JNE	@@1
	OR	BX,BX
	JE	@@2
@@1:	OR	CH,CH
	JNE	@@3
	OR	SI,SI
	JNE	@@3
	XCHG	AX,CX
	XCHG	BX,SI
	XCHG	BP,DI
@@2:	MOV	AX,CX
	MUL	BP
	MOV	BX,DX
	MOV	AX,SI
	MUL	BP
	ADD	BX,AX
	ADC	DX,0
	MOV	CX,DX
	MOV	AX,DI
	MUL	BP
	ADD	AX,CX
	ADC	DX,0
	JMP	@@4
@@3:	PUSH	DI
	PUSH	SI
	PUSH	CX
	PUSH	BP
	PUSH	BX
	PUSH	AX
	MOV	BP,SP
	XOR	CX,CX
	MOV	AL,[BP].b1		;1
	MUL	[BP+6].b1
	MOV	SI,AX
	MOV	DI,CX
	MOV	BX,CX
	MOV	AX,[BP].w0		;2
	MUL	[BP+6].w2
	ADD	SI,AX
	ADC	DI,DX
	ADC	BX,CX
	MOV	AX,[BP].w2
	MUL	[BP+6].w0
	ADD	SI,AX
	ADC	DI,DX
	ADC	BX,CX
	MOV	SI,CX
	MOV	AX,[BP].w0		;3
	MUL	[BP+6].w4
	ADD	DI,AX
	ADC	BX,DX
	ADC	SI,CX
	MOV	AX,[BP].w2
	MUL	[BP+6].w2
	ADD	DI,AX
	ADC	BX,DX
	ADC	SI,CX
	MOV	AX,[BP].w4
	MUL	[BP+6].w0
	ADD	DI,AX
	ADC	BX,DX
	ADC	SI,CX
	MOV	DI,CX
	MOV	AX,[BP].w2		;4
	MUL	[BP+6].w4
	ADD	BX,AX
	ADC	SI,DX
	ADC	DI,CX
	MOV	AX,[BP].w4
	MUL	[BP+6].w2
	ADD	BX,AX
	ADC	SI,DX
	ADC	DI,CX
	MOV	AX,[BP].w4		;5
	MUL	[BP+6].w4
	ADD	AX,SI
	ADC	DX,DI
	ADD	SP,12
@@4:	XCHG	AX,BX
	POP	CX
	POP	BP
	OR	DH,DH
	JS	@@5
	SHL	AX,1
	RCL	BX,1
	RCL	DX,1
	DEC	CX
@@5:	SUB	CX,8081H

; Common exit from multiply and divide

ExitMulDiv:

	ADD	AX,80H
	ADC	BX,0
	ADC	DX,0
	JNC	@@1
	RCR	DX,1
	INC	CX
@@1:	TEST	CH,40H
	JNE	ExitZero
	INC	CX
	MOV	AL,CL
	XOR	DH,CH
	SHR	CH,1
	RET

; Return zero

ExitZero:

	XOR	AX,AX
	MOV	BX,AX
	MOV	DX,AX
	RET

; Real division
; In	R1 = 1st operand
;	R2 = 2nd operand
; Out	R1 = Result
;	CF = 1 if overflow
; Uses	CX,SI,DI

RealDiv:

	OR	AL,AL
	JE	ExitZero
	PUSH	BP
	MOV	BP,DX
	XOR	DX,DI
	OR	DI,8000H
	OR	BP,8000H
	AND	DX,8000H
	XCHG	AL,DL
	SUB	DL,CL
	SBB	DH,AL
	PUSH	DX
	MOV	AL,2
	MOV	DX,1
@@1:	CMP	BP,DI
	JNE	@@2
	CMP	BX,SI
	JNE	@@2
	CMP	AH,CH
@@2:	JC	@@3
	SUB	AH,CH
	SBB	BX,SI
	SBB	BP,DI
@@3:	RCL	DX,1
	JC	@@5
@@4:	SHL	AH,1
	RCL	BX,1
	RCL	BP,1
	JNC	@@1
	SUB	AH,CH
	SBB	BX,SI
	SBB	BP,DI
	CLC
	JMP	@@3
@@5:	DEC	AL
	JS	@@6
	PUSH	DX
	MOV	DX,1
	JNE	@@4
	MOV	DL,40H
	JMP	@@4
@@6:	MOV	AX,DX
	MOV	CL,6
	SHL	AX,CL
	POP	BX
	POP	DX
	POP	CX
	POP	BP
	NOT	AX
	NOT	BX
	XOR	DX,0FFFFH
	JS	@@7
	RCL	AX,1
	RCL	BX,1
	RCL	DX,1
	DEC	CX
@@7:	ADD	CX,8080H
	JMP	ExitMulDiv

; Real compare
; In	R1 = 1st operand
;	R2 = 2nd operand
; Out	ZF = Set if R1=R2
;	CF = Set if R1<R2
; Uses	None

RealCmp:

	PUSH	DX
	XOR	DX,DI
	POP	DX
	JNS	@@1
	PUSH	DX
	RCL	DX,1
	POP	DX
	RET
@@1:	TEST	DH,80H
	JZ	@@2
	CALL	@@2
	JE	@@3
	CMC
	RET
@@2:	CMP	AL,CL
	JNE	@@3
	OR	AL,AL
	JZ	@@3
	CMP	DX,DI
	JNE	@@3
	CMP	BX,SI
	JNE	@@3
	CMP	AH,CH
@@3:	RET

; Convert integer to real
; In	DX:AX = Integer value
; Out	R1    = Real value
; Uses	CX

RealFloat:

	MOV	BX,AX
	OR	BX,DX
	JE	@@5
	MOV	CH,DH
	OR	DX,DX
	JNS	@@1
	NEG	DX
	NEG	AX
	SBB	DX,0
@@1:	MOV	BX,AX
	MOV	AX,0A0H
	OR	DX,DX
	JNZ	@@2
	XCHG	DX,BX
	MOV	AL,90H
	OR	DH,DH
	JNZ	@@2
	XCHG	DH,DL
	MOV	AL,88H
@@2:	OR	DX,DX
	JS	@@4
@@3:	DEC	AL
	ADD	BX,BX
	ADC	DX,DX
	JNS	@@3
@@4:	OR	CH,CH
	JS	@@5
	AND	DH,7FH
@@5:	RET

; Convert real to integer
; In	R1    = real value
;	CH    = Non-zero for round
; Out	DX:AX = Integer value
;	CF    = 1 if overflow
; Uses	BX,CX

RealTrunc:

	XCHG	AX,BX
	MOV	CL,80H+32
	SUB	CL,BL
	JC	@@7
	MOV	BL,DH
	OR	DH,80H
	CMP	CL,32
	JAE	@@8
	CMP	CL,16
	JB	@@1
	MOV	BH,AH
	MOV	AX,DX
	XOR	DX,DX
	SUB	CL,16
@@1:	CMP	CL,8
	JB	@@2
	MOV	BH,AL
	MOV	AL,AH
	MOV	AH,DL
	MOV	DL,DH
	XOR	DH,DH
	SUB	CL,8
@@2:	OR	CL,CL
	JE	@@4
@@3:	SHR	DX,1
	RCR	AX,1
	RCR	BH,1
	DEC	CL
	JNE	@@3
@@4:	OR	CH,CH
	JE	@@5
	ADD	BH,BH
	ADC	AX,0
	ADC	DX,0
	JC	@@7
@@5:	MOV	CX,AX
	OR	CX,DX
	JE	@@7
	OR	BL,BL
	JNS	@@6
	NEG	DX
	NEG	AX
	SBB	DX,0
@@6:	XOR	BL,DH
	ADD	BL,BL
@@7:	RET
@@8:	MOV	BH,DH
	MOV	AX,0
	MOV	DX,0
	JE	@@4
	RET

CODE	ENDS

	END
