
; *******************************************************
; *							*
; *     Turbo Pascal Run-time Library                   *
; *	Windows Emulator Interface			*
; *							*
; *     Copyright (c) 1988,92 Borland International     *
; *							*
; *******************************************************

	TITLE	WE87

	INCLUDE	SE.ASM

DATA	SEGMENT	WORD PUBLIC

; Local workspace

TempLong	DD	?		;Temporary longword
CtrlWord	DW	?		;Saved control word

DATA	ENDS

CODE	SEGMENT	BYTE PUBLIC

	ASSUME	CS:CODE,DS:DATA

; Externals

	EXTRN	HaltError:NEAR,__F87_Sine:NEAR,__F87_Cosine:NEAR
	EXTRN	__F87_ArcTan:NEAR,__F87_Log:NEAR,__F87_Exp:NEAR

; Publics

	PUBLIC	FTrunc,FRound,FInt,FSqrt,FSin,FCos,FArcTan,FLn
	PUBLIC	FExp,FFrac,FRealExt,FExtReal

; Chop rounding control word

CWChop		DW	1F3FH

; Convert Real to Extended

FRealExt:

	OR	AL,AL
	JE	@@1
	XOR	CL,CL
	MOV	CH,AH
	MOV	AH,DH
	AND	AH,80H
	ADD	AX,3F7EH
	OR	DH,80H
	PUSH	AX
	PUSH	DX
	PUSH	BX
	PUSH	CX
	XOR	CX,CX
	PUSH	CX
	MOV	BX,SP
	FLD	TBYTE PTR SS:[BX]
	FWAIT
	ADD	SP,10
	RETF
@@1:	FLDZ
	RETF

; Convert Extended to Real

FExtReal:

	SUB	SP,10
	MOV	BX,SP
	FSTP	TBYTE PTR SS:[BX]
	FWAIT
	ADD	SP,2
	POP	CX
	POP	BX
	POP	DX
	POP	AX
	MOV	DI,AX
	AND	AX,7FFFH
	SUB	AX,3F7EH
	JBE	@@2
	OR	AH,AH
	JNE	@@4
	MOV	AH,CH
	SHL	CL,1
	ADC	AH,0
	ADC	BX,0
	ADC	DX,0
	JC	@@3
@@1:	SHL	DX,1
	SHL	DI,1
	RCR	DX,1
	RETF
@@2:	XOR	AX,AX
	XOR	BX,BX
	XOR	DX,DX
	RETF
@@3:	INC	AL
	JNE	@@1
@@4:	MOV	AX,205
	JMP	HaltError

; Trunc function

FTrunc:

	FSTCW	CtrlWord
	FLDCW	CWChop
	FISTP	TempLong
	FWAIT				;486 needs FWAIT before FLDCW
	FLDCW	CtrlWord
	MOV	AX,TempLong.w0
	MOV	DX,TempLong.w2
	RETF

; Round function

FRound:

	FISTP	TempLong
	FWAIT
	MOV	AX,TempLong.w0
	MOV	DX,TempLong.w2
	RETF

; Int function

FInt:

	FSTCW	CtrlWord
	FLDCW	CWChop
	FRNDINT
	FWAIT				;486 needs FWAIT before FLDCW
	FLDCW	CtrlWord
	RETF

; Frac function

FFrac:

	FSTCW	CtrlWord
	FLDCW	CWChop
	FLD	ST(0)
	FRNDINT
	FSUB
	FWAIT				;486 needs FWAIT before FLDCW
	FLDCW	CtrlWord
	RETF

; Sqrt function

FSqrt:

	FSQRT
	RETF

; Sin function

FSin:

	CALL	__F87_Sine
	RETF

; Cos function

FCos:

	CALL	__F87_Cosine
	RETF

; ArcTan function

FArcTan:

	CALL	__F87_ArcTan
	RETF

; Ln function

FLn:

	CALL	__F87_Log
	RETF

; Exp function

FExp:

	CALL	__F87_Exp
	RETF

CODE	ENDS

	END
