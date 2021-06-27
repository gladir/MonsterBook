
; *******************************************************
; *							*
; *	Turbo Pascal Runtime Library Version 5.5	*
; *	File Name Expansion Routine			*
; *							*
; *	Copyright (C) 1988,89 Borland International	*
; *							*
; *******************************************************

	TITLE	EXPN

	LOCALS	@@

CODE	SEGMENT	BYTE PUBLIC

	ASSUME	CS:CODE

	PUBLIC	FExpand

FExpand		PROC	FAR

ResultP		EQU	(DWORD PTR [BP+10])
PathP		EQU	(DWORD PTR [BP+6])

	PUSH	BP
	MOV	BP,SP
	PUSH	DS
	CLD
	LDS	SI,PathP
	LODSB
	MOV	CL,AL
	XOR	CH,CH
	ADD	CX,SI
	LES	DI,ResultP
	INC	DI
	LODSW
	CMP	SI,CX
	JA	@@1
	CMP	AH,':'
	JNE	@@1
	CMP	AL,'a'
	JB	@@2
	CMP	AL,'z'
	JA	@@2
	SUB	AL,20H
	JMP	SHORT @@2
@@1:	DEC	SI
	DEC	SI
	MOV	AH,19H			;Get current drive
	INT	21H
	ADD	AL,'A'
	MOV	AH,':'
@@2:	STOSW
	CMP	SI,CX
	JE	@@21
	CMP	BYTE PTR [SI],'\'
	JE	@@3
@@21:	SUB	AL,'A'-1
	MOV	DL,AL
	MOV	AL,'\'
	STOSB
	PUSH	SI
	PUSH	DS
	MOV	AH,47H			;Get current directory
	MOV	SI,DI
	PUSH	ES
	POP	DS
	INT	21H
	POP	DS
	POP	SI
	JC	@@3
	CMP	BYTE PTR ES:[DI],0
	JE	@@3
	PUSH	CX
	MOV	CX,-1
	XOR	AL,AL
	REPNE	SCASB
	DEC	DI
	MOV	AL,'\'
	STOSB
	POP	CX
@@3:	SUB	CX,SI
	REP	MOVSB
	XOR	AL,AL
	STOSB
	LDS	SI,ResultP
	INC	SI
	MOV	DI,SI
	PUSH	DI
@@4:	LODSB
	OR	AL,AL
	JE	@@6
	CMP	AL,'\'
	JE	@@6
	CMP	AL,'a'
	JB	@@5
	CMP	AL,'z'
	JA	@@5
	SUB	AL,20H
@@5:	STOSB
	JMP	@@4
@@6:	CMP	WORD PTR [DI-2],'.\'
	JNE	@@7
	DEC	DI
	DEC	DI
	JMP	SHORT @@9
@@7:	CMP	WORD PTR [DI-2],'..'
	JNE	@@9
	CMP	BYTE PTR [DI-3],'\'
	JNE	@@9
	SUB	DI,3
	CMP	BYTE PTR [DI-1],':'
	JE	@@9
@@8:	DEC	DI
	CMP	BYTE PTR [DI],'\'
	JNE	@@8
@@9:	OR	AL,AL
	JNE	@@5
	CMP	BYTE PTR [DI-1],':'
	JNE	@@10
	MOV	AL,'\'
	STOSB
@@10:	MOV	AX,DI
	POP	DI
	SUB	AX,DI
	DEC	DI
	STOSB
	POP	DS
	POP	BP
	RET	4

FExpand		ENDP

CODE	ENDS

	END
