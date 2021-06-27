
; *******************************************************
; *							*
; *     Turbo Pascal Run-time Library                   *
; *	Integer Binary/Decimal Routines			*
; *							*
; *     Copyright (c) 1988,92 Borland International     *
; *							*
; *******************************************************

	TITLE	DINT

	INCLUDE	SE.ASM

CODE	SEGMENT	BYTE PUBLIC

	ASSUME	CS:CODE

; Publics

	PUBLIC	Int2Str,Str2Int

; Convert integer to string
; In	DX:AX = Value
;	ES:DI = String end pointer
; Out	CX    = String length
;	ES:DI = String pointer

Int2Str:

	MOV	CX,DI
	MOV	SI,10
	MOV	BX,DX
	OR	BX,BX
	JNS	@@1
	NEG	BX
	NEG	AX
	SBB	BX,0
	CALL	@@1
	DEC	DI
	MOV	ES:[DI].b0,'-'
	INC	CX
	RET
@@1:	XOR	DX,DX
	XCHG	AX,BX
	DIV	SI
	XCHG	AX,BX
	DIV	SI
	ADD	DL,'0'
	CMP	DL,'0'+10
	JB	@@2
	ADD	DL,'A'-'0'-10
@@2:	DEC	DI
	MOV	ES:[DI],DL
	MOV	DX,AX
	OR	DX,BX
	JNE	@@1
	SUB	CX,DI
	RET

; Convert string to integer
; In	CX    = String length
;	ES:DI = String pointer
; Out	DX:AX = Value
;	CX    = Remaining characters
;	ES:DI = Pointer past string
;	CF    = 1 if error

Str2Int:

	XOR	AX,AX
	XOR	DX,DX
	XOR	SI,SI
	JCXZ	@@6
	CMP	BYTE PTR ES:[DI],'+'
	JE	@@1
	CMP	BYTE PTR ES:[DI],'-'
	JNE	@@2
	DEC	SI
@@1:	INC	DI
	DEC	CX
	JE	@@6
@@2:	CMP	BYTE PTR ES:[DI],'$'
	JE	@@7
@@3:	MOV	BL,ES:[DI]
	SUB	BL,'0'+10
	ADD	BL,10
	JNC	@@4
	TEST	DH,0F0H
	JNE	@@6
	PUSH	BX
	SHL	AX,1
	RCL	DX,1
	PUSH	DX
	PUSH	AX
	SHL	AX,1
	RCL	DX,1
	SHL	AX,1
	RCL	DX,1
	POP	BX
	ADD	AX,BX
	POP	BX
	ADC	DX,BX
	POP	BX
	XOR	BH,BH
	ADD	AX,BX
	ADC	DX,0
	INC	DI
	LOOP	@@3
@@4:	MOV	BX,AX
	OR	BX,DX
	JE	@@5a
	OR	SI,SI
	JNS	@@5
	NEG	DX
	NEG	AX
	SBB	DX,0
@@5:	XOR	SI,DX
	JS	@@6
@@5a:	RET
@@6:	STC
	RET
@@7:	INC	DI
	DEC	CX
	JE	@@6
@@8:	MOV	BL,ES:[DI]
	CMP	BL,'a'
	JB	@@9
	SUB	BL,32
@@9:	SUB	BL,'0'+10
	ADD	BL,10
	JC	@@10
	SUB	BL,7+16
	ADD	BL,6
	JNC	@@4
	ADD	BL,10
@@10:	MOV	BH,4
@@11:	SHL	AX,1
	RCL	DX,1
	JC	@@6
	DEC	BH
	JNE	@@11
	OR	AL,BL
	INC	DI
	LOOP	@@8
	OR	SI,SI
	JNS	@@12
	NEG	DX
	NEG	AX
	SBB	DX,0
@@12:	CLC
	RET

CODE	ENDS

	END
