
; *******************************************************
; *							*
; *     Turbo Pascal Runtime Library                    *
; *	String Support Routines				*
; *							*
; *	Copyright (C) 1988,90 Borland International	*
; *							*
; *******************************************************

	TITLE	STRH

	INCLUDE	SE.ASM

CODE	SEGMENT	BYTE PUBLIC

	ASSUME	CS:CODE

; Publics

	PUBLIC	SLoad,SStore,SCopy,SConcat,SPos,SCompare
	PUBLIC	SChar,SPacked,SInsert,SDelete

; Load string
; In	[SP+4] = Destination pointer
;	[SP]   = Source pointer
; Out	SP     = SP+4

SLoad:

	CLD
	MOV	BX,SP
	MOV	DX,DS
	LES	DI,SS:[BX+8]
	LDS	SI,SS:[BX+4]
	LODSB
	STOSB
	MOV	CL,AL
	XOR	CH,CH
	REP	MOVSB
	MOV	DS,DX
	RETF	4

; Store string
; In	[SP+6] = Source pointer
;	[SP+2] = Destination pointer
;	[SP]   = Maximum length
; Out	SP     = SP+10

SStore:

	CLD
	MOV	BX,SP
	MOV	DX,DS
	LDS	SI,SS:[BX+10]
	LES	DI,SS:[BX+6]
	MOV	CX,SS:[BX+4]
	LODSB
	CMP	AL,CL
	JBE	@@1
	MOV	AL,CL
@@1:	STOSB
	MOV	CL,AL
	XOR	CH,CH
	REP	MOVSB
	MOV	DS,DX
	RETF	10

; Copy standard function
; In	[SP+8] = Destination pointer
;	[SP+4] = Source pointer
;	[SP+2] = Index
;	[SP]   = Length
; Out	SP     = SP+8

SCopy:

	CLD
	MOV	BX,SP
	MOV	DX,DS
	LES	DI,SS:[BX+12]
	LDS	SI,SS:[BX+8]
	MOV	AL,[SI]
	XOR	AH,AH
	MOV	CX,SS:[BX+6]
	OR	CX,CX
	JG	@@1
	MOV	CX,1
@@1:	ADD	SI,CX
	SUB	AX,CX
	JB	@@3
	INC	AX
	MOV	CX,SS:[BX+4]
	OR	CX,CX
	JGE	@@2
	XOR	CX,CX
@@2:	CMP	AX,CX
	JBE	@@4
	MOV	AX,CX
	JMP	SHORT @@4
@@3:	XOR	AX,AX
@@4:	STOSB
	MOV	CX,AX
	REP	MOVSB
	MOV	DS,DX
	RETF	8

; Concat standard function
; In	[SP+4] = Destination pointer
;	[SP]   = Source pointer
; Out	SP     = SP+4

SConcat:

	CLD
	MOV	BX,SP
	MOV	DX,DS
	LES	DI,SS:[BX+8]
	LDS	SI,SS:[BX+4]
	MOV	CL,ES:[DI]
	XOR	CH,CH
	LODSB
	ADD	ES:[DI],AL
	JNC	@@1
	MOV	BYTE PTR ES:[DI],255
	MOV	AL,CL
	NOT	AL
@@1:	ADD	DI,CX
	INC	DI
	MOV	CL,AL
	REP	MOVSB
	MOV	DS,DX
	RETF	4

; Pos standard function
; In	[SP+4] = Source pointer
;	[SP]   = Destination pointer
; Out	AX     = Position
;	SP     = SP+8

SPos:

	ARG	SourceP,DWORD,1
	ARG	DestP,DWORD,1

	ENTRY	FAR
	PUSH	DS
	LDS	SI,SourceP
	CLD
	LODSB
	OR	AL,AL
	JE	@@2
	MOV	DL,AL
	XOR	DH,DH
	LES	DI,DestP
	MOV	CL,ES:[DI]
	XOR	CH,CH
	SUB	CX,DX
	JB	@@2
	INC	CX
	INC	DI
@@1:	LODSB
	REPNE	SCASB
	JNE	@@2
	MOV	AX,DI
	MOV	BX,CX
	MOV	CX,DX
	DEC	CX
	REPE	CMPSB
	JE	@@3
	MOV	DI,AX
	MOV	CX,BX
	MOV	SI,SourceP.ofs
	INC	SI
	JMP	@@1
@@2:	XOR	AX,AX
	JMP	SHORT @@4
@@3:	DEC	AX
	SUB	AX,DestP.ofs
@@4:	POP	DS
	EXIT

; String compare
; In	[SP+4] = Source pointer
;	[SP]   = Destination pointer
; Out	ZF     = 1 if Source = Dest
;	CF     = 1 if Source < Dest
;	SP     = SP+8

SCompare:

	CLD
	MOV	BX,SP
	MOV	DX,DS
	LDS	SI,SS:[BX+8]
	LES	DI,SS:[BX+4]
	LODSB
	MOV	AH,ES:[DI]
	INC	DI
	MOV	CL,AL
	CMP	CL,AH
	JBE	@@1
	MOV	CL,AH
@@1:	OR	CL,CL
	JE	@@2
	XOR	CH,CH
	REP	CMPSB
	JNE	@@3
@@2:	CMP	AL,AH
@@3:	MOV	DS,DX
	RETF	8

; Convert character to string
; In	[SP+2] = Destination pointer
;	[SP]   = Character
; Out	SP     = SP+2

SChar:

	CLD
	MOV	BX,SP
	LES	DI,SS:[BX+6]
	MOV	AL,1
	STOSB
	MOV	AL,SS:[BX+4]
	STOSB
	RETF	2

; Convert packed string to string
; In	[SP+6] = Destination pointer
;	[SP+2] = Source pointer
;	[SP]   = Length
; Out	SP     = SP+6

SPacked:

	CLD
	MOV	BX,SP
	MOV	DX,DS
	LES	DI,SS:[BX+10]
	LDS	SI,SS:[BX+6]
	MOV	AX,SS:[BX+4]
	STOSB
	MOV	CX,AX
	REP	MOVSB
	MOV	DS,DX
	RETF	6

; Insert standard procedure
; Insert(S,D,I) = Copy(D,1,I-1) + S + Copy(D,I,255)

SInsert:

	ARG	SourceP,DWORD,1
	ARG	DestP,DWORD,1
	ARG	DestLen,WORD,1
	ARG	Index,WORD,1
	LOC	Temp1,BYTE,256
	LOC	Temp2,BYTE,256

	ENTRY	FAR
	CMP	Index,1
	JGE	@@1
	MOV	Index,1
@@1:	LEA	DI,Temp1
	PUSH	SS
	PUSH	DI
	LES	DI,DestP
	PUSH	ES
	PUSH	DI
	MOV	AX,1
	PUSH	AX
	MOV	AX,Index
	DEC	AX
	PUSH	AX
	PUSH	CS
	CALL	SCopy
	LES	DI,SourceP
	PUSH	ES
	PUSH	DI
	PUSH	CS
	CALL	SConcat
	LEA	DI,Temp2
	PUSH	SS
	PUSH	DI
	LES	DI,DestP
	PUSH	ES
	PUSH	DI
	PUSH	Index
	MOV	AX,255
	PUSH	AX
	PUSH	CS
	CALL	SCopy
	PUSH	CS
	CALL	SConcat
	LES	DI,DestP
	PUSH	ES
	PUSH	DI
	PUSH	DestLen
	PUSH	CS
	CALL	SStore
	EXIT

; Delete standard procedure
; Delete(S,I,N) = Copy(S,1,I-1) + Copy(S,I+N,255)

SDelete:

	ARG	StrP,DWORD,1
	ARG	Index,WORD,1
	ARG	Count,WORD,1
	LOC	Temp1,BYTE,256
	LOC	Temp2,BYTE,256

	ENTRY	FAR
	CMP	Count,0
	JLE	@@2
	CMP	Index,0
	JLE	@@2
	CMP	Index,255
	JG	@@2
	CMP	Count,255
	JLE	@@1
	MOV	Count,255
@@1:	LEA	DI,Temp1
	PUSH	SS
	PUSH	DI
	LES	DI,StrP
	PUSH	ES
	PUSH	DI
	MOV	AX,1
	PUSH	AX
	MOV	AX,Index
	DEC	AX
	PUSH	AX
	PUSH	CS
	CALL	SCopy
	LEA	DI,Temp2
	PUSH	SS
	PUSH	DI
	LES	DI,StrP
	PUSH	ES
	PUSH	DI
	MOV	AX,Index
	ADD	AX,Count
	PUSH	AX
	MOV	AX,255
	PUSH	AX
	PUSH	CS
	CALL	SCopy
	PUSH	CS
	CALL	SConcat
	LES	DI,StrP
	PUSH	ES
	PUSH	DI
	MOV	AX,255
	PUSH	AX
	PUSH	CS
	CALL	SStore
@@2:	EXIT

CODE	ENDS

	END
