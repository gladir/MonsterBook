
; *******************************************************
; *							*
; *     Turbo Pascal Run-time Library                   *
; *	Real Support Routines				*
; *							*
; *     Copyright (c) 1988,92 Borland International     *
; *							*
; *******************************************************

	TITLE	F48H

	INCLUDE	SE.ASM

CODE	SEGMENT	BYTE PUBLIC

	ASSUME	CS:CODE

; Externals

	EXTRN	RealAdd:NEAR,RealSub:NEAR,RealMul:NEAR,RealDiv:NEAR
	EXTRN	RealCmp:NEAR,RealFloat:NEAR,RealTrunc:NEAR
	EXTRN	HaltError:NEAR

; Publics

	PUBLIC	RAdd,RSub,RMul,RDiv,RCmp,RFloat,RTrunc
	PUBLIC	RRound,RSqr

; Add

RAdd:

	CALL	RealAdd
	JC	ROverflow
	RETF

; Subtract

RSub:

	CALL	RealSub
	JC	ROverflow
	RETF

; Square

RSqr:

	MOV	CX,AX
	MOV	SI,BX
	MOV	DI,DX

; Multiply

RMul:

	CALL	RealMul
	JC	ROverflow
	RETF

; Divide

RDiv:

	OR	CL,CL
	JZ	RDivZero
	CALL	RealDiv
	JC	ROverflow
	RETF

; Compare

RCmp:

	CALL	RealCmp
	RETF

; Float

RFloat:

	CALL	RealFloat
	RETF

; Trunc function

RTrunc:

	MOV	CH,0
	CALL	RealTrunc
	JC	RRangeError
	RETF

; Round function

RRound:

	MOV	CH,1
	CALL	RealTrunc
	JC	RRangeError
	RETF

; Trunc or Round range error

RRangeError:

	MOV	AX,207
	JMP	HaltError

; Overflow error

ROverflow:

	MOV	AX,205
	JMP	HaltError

; Divide by zero error

RDivZero:

	MOV	AX,200
	JMP	HaltError

CODE	ENDS

	END
