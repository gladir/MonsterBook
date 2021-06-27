
; *******************************************************
; *							*
; *     Turbo Pascal Run-time Library                   *
; *	Random Number Generator				*
; *							*
; *     Copyright (c) 1988,92 Borland International     *
; *							*
; *******************************************************

	TITLE	RAND

	INCLUDE	SE.ASM

DATA	SEGMENT	WORD PUBLIC

; Externals

	EXTRN	RandSeed:DWORD

DATA	ENDS

CODE	SEGMENT	BYTE PUBLIC

	ASSUME	CS:CODE,DS:DATA

; Publics

	PUBLIC	RandInt,RandReal,RandFloat,InitRand

; Random standard function (Integer)

RandInt:

	CALL	NextRand
	MOV	BX,SP
	MOV	CX,DX
	MUL	WORD PTR SS:[BX+4]
	MOV	AX,CX
	MOV	CX,DX
	MUL	WORD PTR SS:[BX+4]
	ADD	AX,CX
	ADC	DX,0
	MOV	AX,DX
	RETF	2

; Random standard function (Real)

RandReal:

	CALL	NextRand
	XCHG	AX,BX
	MOV	AX,80H
	MOV	CX,32
@@1:	TEST	DH,80H
	JNE	@@2
	SHL	BX,1
	RCL	DX,1
	DEC	AL
	LOOP	@@1
	XOR	AL,AL
@@2:	AND	DH,7FH
	RETF

; Random standard function (8087)

RandFloat:

	CALL	NextRand		;Compute next random number
	FILD	CS:ConstScale		;Load -32
	FILD	RandSeed		;Load 32-bit random integer
	FADD	CS:ConstDelta		;Scale to 32-bit positive integer
	FSCALE				;Scale so 0<=ST<1
	FSTP	ST(1)			;Remove scaling factor
	FWAIT				;Wait for result
	RETF

; Scaling constants

ConstDelta	DD	2147483648.0
ConstScale	DW	-32

; Compute next random number
; New := 8088405H * Old + 1
; Out	DX:AX = Next random number

NextRand:

	MOV	AX,RandSeed.w0
	MOV	BX,RandSeed.w2
	MOV	CX,AX
	MUL	CS:Factor		;New = Old.w0 * 8405H
	SHL	CX,1			;New.w2 += Old.w0 * 808H
	SHL	CX,1
	SHL	CX,1
	ADD	CH,CL
	ADD	DX,CX
	ADD	DX,BX			;New.w2 += Old.w2 * 8405H
	SHL	BX,1
	SHL	BX,1
	ADD	DX,BX
	ADD	DH,BL
	MOV	CL,5
	SHL	BX,CL
	ADD	DH,BL
	ADD	AX,1			;New += 1
	ADC	DX,0
	MOV	RandSeed.w0,AX
	MOV	RandSeed.w2,DX
	RET

; Multiplication factor

Factor		DW	8405H

; Randomize standard procedure

InitRand:

	MOV	AH,dosGetTime
	INT	DOS
	MOV	RandSeed.w0,CX
	MOV	RandSeed.w2,DX
	RETF

CODE	ENDS

	END
