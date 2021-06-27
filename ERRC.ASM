
; *******************************************************
; *							*
; *     Turbo Pascal Runtime Library                    *
; *	Error Check Routines				*
; *							*
; *	Copyright (C) 1988,90 Borland International	*
; *							*
; *******************************************************

	TITLE	ERRC

	INCLUDE	SE.ASM

DATA	SEGMENT WORD PUBLIC

; Externals

	EXTRN	InOutRes:WORD

    IF NOT WindowsVersion AND NOT DPMIVersion
	EXTRN	StackLimit:WORD
    ENDIF

DATA	ENDS

CODE	SEGMENT	BYTE PUBLIC

	ASSUME	CS:CODE,DS:DATA

; Externals

	EXTRN	HaltError:NEAR

; Publics

	PUBLIC	GetIORes,InOutCheck,RangeCheck,StackCheck
	PUBLIC	Overflow,RangeError

; IOResult standard function. May modify only AX.

GetIORes:

	XOR	AX,AX
	XCHG	AX,InOutRes
	RETF

; Check I/O result. Called after any I/O standard routine in
; the {$I+} state. May modify no registers.

InOutCheck:

	CMP	InOutRes,0
	JNE	@@1
	RETF
@@1:	MOV	AX,InOutRes
	JMP	HaltError

; Check range of integer value. Called to validate integer values
; in the {$R+} state. DX:AX contains value, and DI contains pointer
; to range data in callers code segment. May modify SI, DI, and ES.

RangeCheck:

	MOV	SI,SP
	MOV	ES,SS:[SI+2]
	CMP	DX,ES:[DI+2]
	JG	@@1
	JL	RangeError
	CMP	AX,ES:[DI]
	JB	RangeError
@@1:	CMP	DX,ES:[DI+6]
	JL	@@2
	JG	RangeError
	CMP	AX,ES:[DI+4]
	JA	RangeError
@@2:	RETF

; Range check error

RangeError:

	MOV	AX,201
	JMP	HaltError

; Overflow error

Overflow:

	MOV	AX,215
	JMP	HaltError

; Check for stack overflow. Called on entry to any procedure or
; function compiled in the {$S+} state. AX contains number of
; bytes to allocate. May modify only AX.

StackCheck:

    IF WindowsVersion
	ADD	AX,1024
    ELSE
	ADD	AX,512
    ENDIF
	JC	@@2
	SUB	AX,SP
	JAE	@@2
	NEG	AX
    IF WindowsVersion OR DPMIVersion
	CMP	AX,SS:pStackTop
	JB	@@2
	CMP	AX,SS:pStackMin
	JAE	@@1
	MOV	SS:pStackMin,AX
    ELSE
	CMP	AX,StackLimit
	JB	@@2
    ENDIF
@@1:	RETF
@@2:	MOV	AX,202
	JMP	HaltError

CODE	ENDS

	END
