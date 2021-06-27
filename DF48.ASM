
; *******************************************************
; *							*
; *     Turbo Pascal Run-time Library                   *
; *	Real Binary/Decimal Routines			*
; *							*
; *     Copyright (c) 1988,92 Borland International     *
; *							*
; *******************************************************

	TITLE	DF48

	INCLUDE	SE.ASM

CODE	SEGMENT	BYTE PUBLIC

	ASSUME	CS:CODE

; Externals

	EXTRN	RealAdd:NEAR,RealMul:NEAR,RealDiv:NEAR
	EXTRN	RealFloat:NEAR,Str2Int:NEAR

; Publics

	PUBLIC	Real2Str,Str2Real

; Convert real to string
; In	R1    = Value
;	CX    = Digit count (Float<0, Fixed>=0)
;	ES:DI = String pointer
; Out	CX    = String length
;	ES:DI = String pointer

Real2Str:

	LOC	Digits,WORD,1
	LOC	Sign,BYTE,2
	LOC	Exponent,WORD,1
	LOC	DigitBuf,BYTE,14

	ENTRY
	PUSH	DI
	CMP	CX,11
	JLE	@@1
	MOV	CX,11
@@1:	CMP	CX,-11
	JGE	@@2
	MOV	CX,-11
@@2:	MOV	Digits,CX
	MOV	Sign,DH
	PUSH	ES
	PUSH	DI
	LEA	DI,DigitBuf
	PUSH	SS
	POP	ES
	CALL	Real2Dec
	POP	DI
	POP	ES
	MOV	Exponent,CX
@@10:	MOV	SI,Digits
	OR	SI,SI
	JS	@@11
	ADD	SI,Exponent
	INC	SI
	JNS	@@12
	MOV	DigitBuf,0
	JMP	SHORT @@20
@@11:	NEG	SI
@@12:	CMP	SI,12
	JB	@@15
	MOV	SI,11
@@15:	CMP	DigitBuf[SI],'5'
	MOV	DigitBuf[SI],0
	JB	@@20
@@13:	DEC	SI
	JS	@@14
	INC	DigitBuf[SI]
	CMP	DigitBuf[SI],'9'
	JBE	@@20
	MOV	DigitBuf[SI],0
	JMP	@@13
@@14:	MOV	DigitBuf.w0,'1'
	INC	Exponent
@@20:	XOR	SI,SI
	CLD
	MOV	DX,Digits
	OR	DX,DX
	JS	@@40
	TEST	Sign,80H
	JE	@@31
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
	TEST	Sign,80H
	JE	@@46
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
	MOV	AX,DX
	MOV	DL,10
	IDIV	DL
	ADD	AX,'00'
	STOSW
@@90:	MOV	CX,DI
	POP	DI
	SUB	CX,DI
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

; Convert real to 12 decimal digits
; In	ES:DI = Digit buffer pointer
; Out	CX    = Exponent

Real2Dec:

	OR	AL,AL
	JNZ	@@1
	MOV	CX,6
	MOV	AX,'00'
	CLD
	REP	STOSW
	XOR	AL,AL
	STOSB
	RET
@@1:	AND	DH,7FH
	PUSH	AX
	SUB	AL,80H
	MOV	AH,77
	IMUL	AH
	ADD	AX,5
	MOV	AL,AH
	CBW
	MOV	CX,AX
	POP	AX
	CMP	CX,-39
	JNE	@@2
	INC	CX
@@2:	PUSH	CX
	PUSH	DI
	NEG	CX
	CALL	Power10
	POP	DI
	POP	CX
	CMP	AL,81H
	JAE	@@3
	CALL	Times10
	DEC	CX
@@3:	PUSH	CX
	OR	DH,80H
	MOV	CL,84H
	SUB	CL,AL
	MOV	AL,0
	JZ	@@5
@@4:	SHR	DX,1
	RCR	BX,1
	RCR	AX,1
	DEC	CL
	JNZ	@@4
@@5:	MOV	SI,12
@@6:	MOV	CH,DH
	MOV	CL,4
	SHR	CH,CL
	ADD	CH,'0'
	MOV	ES:[DI],CH
	AND	DH,0FH
	PUSH	DX
	PUSH	BX
	PUSH	AX
	SHL	AX,1
	RCL	BX,1
	RCL	DX,1
	SHL	AX,1
	RCL	BX,1
	RCL	DX,1
	POP	CX
	ADD	AX,CX
	POP	CX
	ADC	BX,CX
	POP	CX
	ADC	DX,CX
	SHL	AX,1
	RCL	BX,1
	RCL	DX,1
	INC	DI
	DEC	SI
	JNZ	@@6
	MOV	BYTE PTR ES:[DI],0
	POP	CX
	RET

; Convert string to real
; In	CX    = String length
;	ES:DI = String pointer
; Out	R1    = Value
;	CX    = Remaining characters
;	ES:DI = Pointer past string
;	CF    = 1 if error

Str2Real:

	LOC	SignChar,BYTE,2
	LOC	Value,BYTE,6

	ENTRY
	XOR	AX,AX
	MOV	Value.w0,AX
	MOV	Value.w2,AX
	MOV	Value.w4,AX
	JCXZ	@@5
	MOV	AL,ES:[DI]
	MOV	SignChar,AL
	CMP	AL,' '
	JE	@@0
	CMP	AL,'+'
	JE	@@0
	CMP	AL,'-'
	JNE	@@1
@@0:	INC	DI
	DEC	CX
@@1:	CALL	DigitStr
	JC	@@5
	OR	BX,BX
	JE	@@2
	XOR	BX,BX
	JCXZ	@@3
	CMP	BYTE PTR ES:[DI],'.'
	JNE	@@3
@@2:	JCXZ	@@5
	CMP	BYTE PTR ES:[DI],'.'
	JNE	@@5
	INC	DI
	DEC	CX
	CALL	DigitStr
	JC	@@5
	NEG	BX
@@3:	JCXZ	@@6
	MOV	AL,ES:[DI]
	CMP	AL,'E'
	JE	@@4
	CMP	AL,'e'
	JNE	@@6
@@4:	INC	DI
	DEC	CX
	PUSH	BX
	CALL	Str2Int
	POP	BX
	JC	@@5
	ADD	BX,AX
	MOV	SI,DX
	CWD
	CMP	SI,DX
	JNE	@@5
	CMP	AX,64
	JGE	@@5
	CMP	AX,-64
	JG	@@6
@@5:	STC
	JMP	SHORT @@8
@@6:	PUSH	CX
	PUSH	DI
	MOV	CL,BL
	MOV	AX,Value.w0
	MOV	BX,Value.w2
	MOV	DX,Value.w4
	CMP	CL,-36
	JGE	@@7
	PUSH	CX
	MOV	CL,-36
	CALL	Power10
	POP	CX
	ADD	CL,36
@@7:	CALL	Power10
	POP	DI
	POP	CX
	JC	@@8
	OR	AL,AL
	JE	@@8
	CMP	SignChar,'-'
	CLC
	JNE	@@8
	OR	DH,80H
@@8:	EXIT

; Process string of digits
; Out	BX = Digit count
;	CF = 1 if overflow

DigitStr:

	XOR	BX,BX
@@1:	JCXZ	@@3
	MOV	AL,ES:[DI]
	SUB	AL,'0'+10
	ADD	AL,10
	JNC	@@3
	INC	BX
	INC	DI
	DEC	CX
	PUSH	BX
	PUSH	CX
	PUSH	DI
	CBW
	CWD
	CALL	RealFloat
	MOV	CX,AX
	MOV	SI,BX
	MOV	DI,DX
	MOV	AX,Value.w0
	MOV	BX,Value.w2
	MOV	DX,Value.w4
	CALL	Times10
	JC	@@2
	CALL	RealAdd
	MOV	Value.w0,AX
	MOV	Value.w2,BX
	MOV	Value.w4,DX
@@2:	POP	DI
	POP	CX
	POP	BX
	JNC	@@1
@@3:	RET

; Multiply R1 by 10^CL
; Uses	CX,SI,DI

Power10:

	CMP	CL,-38
	JL	@@5
	CMP	CL,38
	JG	@@5
	PUSH	DX
	PUSH	BX
	PUSH	AX
	OR	CL,CL
	PUSHF
	JNS	@@1
	NEG	CL
@@1:	MOV	BL,CL
	AND	BL,0FCH
	MOV	BH,BL
	SHR	BL,1
	ADD	BL,BH
	XOR	BH,BH
	LEA	DI,Power10Tab[BX]
	MOV	AX,CS:[DI].w0
	MOV	BX,CS:[DI].w2
	MOV	DX,CS:[DI].w4
	AND	CL,3
	JZ	@@3
@@2:	CALL	Times10
	DEC	CL
	JNZ	@@2
@@3:	MOV	CX,AX
	MOV	SI,BX
	MOV	DI,DX
	POPF
	POP	AX
	POP	BX
	POP	DX
	JS	@@4
	JMP	RealMul
@@4:	JMP	RealDiv
@@5:	STC
	RET

; Constant powers of 10

Power10Tab:

	DB	081H,000H,000H,000H,000H,000H	;1E00
	DB	08EH,000H,000H,000H,040H,01CH	;1E04
	DB	09BH,000H,000H,020H,0BCH,03EH	;1E08
	DB	0A8H,000H,010H,0A5H,0D4H,068H	;1E12
	DB	0B6H,004H,0BFH,0C9H,01BH,00EH	;1E16
	DB	0C3H,0ACH,0C5H,0EBH,078H,02DH	;1E20
	DB	0D0H,0CDH,0CEH,01BH,0C2H,053H	;1E24
	DB	0DEH,0F9H,078H,039H,03FH,001H	;1E28
	DB	0EBH,02BH,0A8H,0ADH,0C5H,01DH	;1E32
	DB	0F8H,0C9H,07BH,0CEH,097H,040H	;1E36

; Fast multiply R1 by 10
; Uses	None

Times10:

	OR	AL,AL
	JE	@@4
	PUSH	CX
	PUSH	SI
	OR	DH,80H
	MOV	CL,AL
	XOR	AL,AL
	PUSH	DX
	PUSH	BX
	PUSH	AX
	SHR	DX,1
	RCR	BX,1
	RCR	AX,1
	SHR	DX,1
	RCR	BX,1
	RCR	AX,1
	POP	SI
	ADD	AX,SI
	POP	SI
	ADC	BX,SI
	POP	SI
	ADC	DX,SI
	JNC	@@1
	RCR	DX,1
	RCR	BX,1
	RCR	AX,1
	ADD	CL,1
	JC	@@3
@@1:	ADD	AX,80H
	ADC	BX,0
	ADC	DX,0
	JNC	@@2
	RCR	DX,1
	ADD	CL,1
	JC	@@3
@@2:	AND	DH,7FH
	MOV	AL,CL
	ADD	AL,3
@@3:	POP	SI
	POP	CX
@@4:	RET

CODE	ENDS

	END
