
; *******************************************************
; *							*
; *     Turbo Pascal Run-time Library                   *
; *	8087 Binary/Decimal Routines			*
; *							*
; *     Copyright (c) 1988,92 Borland International     *
; *							*
; *******************************************************

	TITLE	DF87

	INCLUDE	SE.ASM

CODE	SEGMENT	BYTE PUBLIC

	ASSUME	CS:CODE

; Externals

	EXTRN	Str2Int:NEAR

; Publics

	PUBLIC	Float2Str,Str2Float

; Constants

DCon1E0		DD	1
DCon1E1		DD	10
DCon1E2		DD	100
DCon1E3		DD	1000
DCon1E4		DD	10000
DCon1E5		DD	100000
DCon1E6		DD	1000000
DCon1E7		DD	10000000
FCon1E8		DT	1E8
FCon1E16	DT	1E16
FCon1E32	DT	1E32
FCon1E64	DT	1E64
FCon1E128	DT	1E128
FCon1E256	DT	1E256
FCon1E512	DT	1E512
FCon1E1024	DT	1E1024
FCon1E2048	DT	1E2048
FCon1E4096	DT	1E4096
FCon1E18	DT	1E18
FConINF		DT	07FFF8000000000000000R

; 8087 control word

CWNear		DW	133FH

; Convert float to string
; In	CX    = Digit count (Float<0, Fixed>=0)
;	ES:DI = String pointer
;	ST(0) = Value
; Out	CX    = String length
;	ES:DI = String pointer

Float2Str:

	LOC	CtrlWord,WORD,1
	LOC	StatWord,WORD,1
	LOC	Digits,WORD,1
	LOC	Exponent,WORD,1
	LOC	Sign,WORD,1
	LOC	Value,TBYTE,1
	LOC	DigitBuf,BYTE,20

	ENTRY
	FSTCW	CtrlWord
	FLDCW	CWNear
	FSTP	Value
	PUSH	DI
	CMP	CX,18
	JLE	@@1
	MOV	CX,18
@@1:	CMP	CX,-18
	JGE	@@2
	MOV	CX,-18
@@2:	MOV	Digits,CX
	CLD
	FWAIT
	MOV	AX,Value.w8
	MOV	Sign,AX
	AND	AX,7FFFH
	JE	@@5
	CMP	AX,7FFFH
	JNE	@@10
	CMP	Value.w6,8000H
	JE	@@3
	MOV	AX,'AN'
	STOSW
	MOV	AL,'N'
	STOSB
	JMP	@@90
@@3:	CMP	Sign,0
	JNS	@@4
	MOV	AL,'-'
	STOSB
@@4:	MOV	AX,'NI'
	STOSW
	MOV	AL,'F'
	STOSB
	JMP	@@90
@@5:	MOV	Exponent,AX
	MOV	DigitBuf,AL
	JMP	@@30
@@10:	MOV	Value.w8,AX
	FLD	Value
	SUB	AX,3FFFH
	MOV	DX,19728
	IMUL	DX
	MOV	Exponent,DX
	MOV	AX,17
	SUB	AX,DX
	CALL	Power10
	FRNDINT
	FLD	FCon1E18
	FCOMP
	FSTSW	StatWord
	FWAIT
	TEST	StatWord,mC0+mC3
	JE	@@11
	FIDIV	DCon1E1
	INC	Exponent
@@11:
    IF WindowsVersion
	CMP	BYTE PTR CS:@@12,0CDH
	JNE	@@12
	PUSH	ES
	PUSH	DI
	LEA	DI,DigitBuf
	PUSH	SS
	POP	ES
	CALL	FStoreBCD
	POP	DI
	POP	ES
	JMP	SHORT @@20
    ENDIF
@@12:	FBSTP	Value
	LEA	BX,DigitBuf
	MOV	CL,4
	MOV	SI,9
	FWAIT
@@13:	MOV	AL,Value[SI-1].b0
	MOV	AH,AL
	SHR	AL,CL
	AND	AH,0FH
	ADD	AX,'00'
	MOV	SS:[BX],AX
	INC	BX
	INC	BX
	DEC	SI
	JNE	@@13
	MOV	SS:[BX],SI
@@20:	CMP	Digits,0
	JL	@@21
	CMP	Exponent,36
	JL	@@21
	MOV	Digits,-18
@@21:	MOV	SI,Digits
	OR	SI,SI
	JS	@@22
	ADD	SI,Exponent
	INC	SI
	JNS	@@23
	MOV	DigitBuf,0
	JMP	SHORT @@30
@@22:	NEG	SI
@@23:	CMP	SI,18
	JAE	@@30
	CMP	DigitBuf[SI],'5'
	MOV	DigitBuf[SI],0
	JB	@@30
@@24:	DEC	SI
	JS	@@25
	INC	DigitBuf[SI]
	CMP	DigitBuf[SI],'9'
	JBE	@@30
	MOV	DigitBuf[SI],0
	JMP	SHORT @@24
@@25:	MOV	DigitBuf.w0,'1'
	INC	Exponent
@@30:	XOR	SI,SI
	MOV	DX,Digits
	OR	DX,DX
	JS	@@40
	CMP	Sign,0
	JNS	@@31
	MOV	AL,'-'
	STOSB
@@31:	MOV	CX,Exponent
	OR	CX,CX
	JNS	@@32
	MOV	AL,'0'
	STOSB
	JMP	SHORT @@33
@@32:	CALL	GetDigit
	STOSB
	DEC	CX
	JNS	@@32
@@33:	OR	DX,DX
	JE	@@90
	MOV	AL,'.'
	STOSB
@@34:	INC	CX
	JE	@@35
	MOV	AL,'0'
	STOSB
	DEC	DX
	JNE	@@34
@@35:	DEC	DX
	JS	@@90
	CALL	GetDigit
	STOSB
	JMP	SHORT @@35
@@40:	MOV	AL,' '
	CMP	Sign,0
	JNS	@@46
	MOV	AL,'-'
@@46:	STOSB
	CALL	GetDigit
	STOSB
	INC	DX
	JE	@@42
	MOV	AL,'.'
	STOSB
@@41:	CALL	GetDigit
	STOSB
	INC	DX
	JNE	@@41
@@42:	MOV	AL,'E'
	STOSB
	MOV	AL,'+'
	MOV	DX,Exponent
	OR	DX,DX
	JNS	@@43
	MOV	AL,'-'
	NEG	DX
@@43:	STOSB
	MOV	AX,(100*256)+10
	XCHG	AX,DX
	DIV	DH
	MOV	DH,AH
	CBW
	DIV	DL
	ADD	AX,'00'
	STOSW
	MOV	AL,DH
	CBW
	DIV	DL
	ADD	AX,'00'
	STOSW
@@90:	MOV	CX,DI
	POP	DI
	SUB	CX,DI
	FCLEX
	FLDCW	CtrlWord
	FWAIT
	EXIT

; Get digit from digit buffer

GetDigit:

	MOV	AL,DigitBuf[SI]
	INC	SI
	OR	AL,AL
	JNE	@@1
	MOV	AL,'0'
	DEC	SI
@@1:	RET

; Convert string to float
; In	CX    = String length
;	ES:DI = String pointer
; Out	CX    = Remaining characters
;	ES:DI = Pointer past string
;	CF    = 1 if error
;	ST(0) = Value

Str2Float:

	LOC	CtrlWord,WORD,1
	LOC	TempWord,WORD,1
	LOC	SignChar,BYTE,1
	LOC	ExpoChar,BYTE,1

	ENTRY
	FSTCW	CtrlWord
	FCLEX
	FLDCW	CWNear
	FLDZ
	JCXZ	@@7
	MOV	AL,ES:[DI]
	MOV	SignChar,AL
	CMP	AL,' '
	JE	@@1
	CMP	AL,'+'
	JE	@@1
	CMP	AL,'-'
	JNE	@@2
@@1:	INC	DI
	DEC	CX
@@2:	PUSH	CX
	CALL	DigitStr
	XOR	BX,BX
	JCXZ	@@3
	MOV	AL,ES:[DI]
	CMP	AL,'.'
	JNE	@@3
	INC	DI
	DEC	CX
	CALL	DigitStr
	NEG	BX
@@3:	POP	AX
	CMP	AX,CX
	JE	@@7
	JCXZ	@@5
	MOV	AL,ES:[DI]
	CMP	AL,'E'
	JE	@@4
	CMP	AL,'e'
	JNE	@@5
@@4:	INC	DI
	DEC	CX
	PUSH	BX
	CALL	Str2Int
	POP	BX
	JC	@@7
	MOV	SI,DX
	CWD
	CMP	SI,DX
	JNE	@@7
	CMP	AX,4999
	JGE	@@7
	CMP	AX,-4999
	JLE	@@7
	ADD	BX,AX
@@5:	MOV	AX,BX
	CALL	Power10
	CMP	SignChar,'-'
	JNE	@@6
	FCHS
@@6:	FSTSW	TempWord
	FWAIT
	TEST	TempWord,mIE+mOE
	JE	@@8
@@7:	STC
@@8:	FCLEX
	FLDCW	CtrlWord
	FWAIT
	EXIT

; Process string of digits
; Out	BX = Digit count

DigitStr:

	XOR	BX,BX
@@1:	JCXZ	@@2
	MOV	AL,ES:[DI]
	SUB	AL,'0'+10
	ADD	AL,10
	JNC	@@2
	FIMUL	DCon1E1
	CBW
	MOV	TempWord,AX
	FIADD	TempWord
	INC	BX
	INC	DI
	DEC	CX
	JMP	@@1
@@2:	RET

; Multiply ST(0) by 10^AX
; In	AX = Power of 10

Power10:

	CMP	AX,4096
	JLE	@@1
	FLD	FCon1E4096
	FMUL
	SUB	AX,4096
@@1:	CMP	AX,-4096
	JGE	@@2
	FLD	FCon1E4096
	FDIV
	ADD	AX,4096
@@2:	MOV	BX,AX
	OR	AX,AX
	JE	@@8
	JNS	@@3
	NEG	AX
@@3:	MOV	SI,AX
	AND	SI,7
	SHL	SI,1
	SHL	SI,1
	FILD	DCon1E0[SI]
	SHR	AX,1
	SHR	AX,1
	SHR	AX,1
	MOV	SI,OFFSET FCon1E8
	JMP	SHORT @@6
@@4:	SHR	AX,1
	JNC	@@5
	FLD	TBYTE PTR CS:[SI]
	FMUL
@@5:	ADD	SI,10
@@6:	OR	AX,AX
	JNE	@@4
	OR	BX,BX
	JS	@@7
	FMUL
	RET
@@7:	FDIV
@@8:	RET

    IF WindowsVersion

; Store ST(0) as 18 decimal digits
; In	ES:DI = Digit buffer pointer

FStoreBCD:

	ADD	DI,18
	XOR	AX,AX
	STD
	STOSW
	SUB	SP,8
	MOV	SI,SP
	FISTP	QWORD PTR SS:[SI]
	FWAIT
	POP	BX
	POP	CX
	POP	AX
	POP	DX
	MOV	SI,10000
	DIV	SI		;CX:BX:AX = DX:AX:CX:BX div 10000
	XCHG	AX,CX
	DIV	SI
	XCHG	AX,BX
	DIV	SI
	CALL	StoreDigits
	XOR	DX,DX		;BX:CX:AX = CX:BX:AX div 10000
	XCHG	AX,CX
	DIV	SI
	XCHG	AX,BX
	DIV	SI
	XCHG	AX,CX
	DIV	SI
	CALL	StoreDigits
	MOV	DX,BX		;CX:AX = BX:CX:AX div 10000
	XCHG	AX,CX
	DIV	SI
	XCHG	AX,CX
	DIV	SI
	CALL	StoreDigits
	MOV	DX,CX		;AX = CX:AX div 10000
	DIV	SI
	CALL	StoreDigits
	AAM
	XCHG	AL,AH
	ADD	AX,'00'
	STOSW
	CLD
	RET

; Store four BCD digits

StoreDigits:

	PUSH	AX
	MOV	AL,100
	XCHG	AX,DX
	DIV	DL
	MOV	DL,AH
	AAM
	ADD	AX,'00'
	XCHG	AL,AH
	XCHG	AX,DX
	AAM
	ADD	AX,'00'
	XCHG	AL,AH
	STOSW
	XCHG	AX,DX
	STOSW
	POP	AX
	RET

    ENDIF

CODE	ENDS

	END
