
; *******************************************************
; *							*
; *     Turbo Pascal Run-time Library                   *
; *	Set Support Routines				*
; *							*
; *     Copyright (c) 1988,92 Borland International     *
; *							*
; *******************************************************

	TITLE	SETH

	INCLUDE	SE.ASM

CODE	SEGMENT	BYTE PUBLIC

	ASSUME	CS:CODE

; Publics

	PUBLIC	ZLoad,ZStore,ZBitMask,ZWordLoad,ZAddComp,ZAddRange
	PUBLIC	ZUnion,ZDifference,ZIntersect,ZEqual,ZRelation

; Load set
; In	[SP+6] = Destination pointer
;	[SP+2] = Source pointer
;	[SP]   = Set data
; Out	SP     = SP+6

ZLoad:

	CLD
	MOV	BX,SP
	MOV	DX,DS
	LES	DI,SS:[BX+10]
	LDS	SI,SS:[BX+6]
	MOV	BX,SS:[BX+4]
	MOV	CL,BH
	XOR	CH,CH
	XOR	AL,AL
	REP	STOSB
	MOV	CL,BL
	REP	MOVSB
	MOV	CL,32
	SUB	CL,BL
	SUB	CL,BH
	REP	STOSB
	MOV	DS,DX
	RETF	6

; Load word sized set
; In	[SP+2] = Destination pointer
;	[SP]   = Word set
; Out	SP     = SP+2

ZWordLoad:

	CLD
	MOV	BX,SP
	LES	DI,SS:[BX+6]
	MOV	AX,SS:[BX+4]
	STOSW
	MOV	CX,15
	XOR	AX,AX
	REP	STOSW
	RETF	2

; Add set component
; In	[SP+2] = Destination pointer
;	[SP]   = Component number
; Out	SP     = SP+2

ZAddComp:

	MOV	BX,SP
	LES	DI,SS:[BX+6]
	MOV	AL,SS:[BX+4]
	MOV	BL,AL
	XOR	BH,BH
	MOV	CL,3
	SHR	BX,CL
	MOV	CL,AL
	AND	CL,7
	MOV	AL,1
	SHL	AL,CL
	OR	ES:[DI+BX],AL
	RETF	2

; Add set range
; In	[SP+4] = Destination pointer
;	[SP+2] = First component number
;	[SP]   = Last component number
; Out	SP     = SP+4

ZAddRange:

	MOV	BX,SP
	LES	DI,SS:[BX+8]
	MOV	AL,SS:[BX+6]
	MOV	DL,SS:[BX+4]
	SUB	DL,AL
	JC	@@2
	INC	DL
	MOV	BL,AL
	XOR	BH,BH
	MOV	CL,3
	SHR	BX,CL
	MOV	CL,AL
	AND	CL,7
	MOV	AL,1
	SHL	AL,CL
@@1:	OR	ES:[DI+BX],AL
	ROL	AL,1
	ADC	BX,0
	DEC	DL
	JNE	@@1
@@2:	RETF	4

; Store set
; In	[SP+6] = Source pointer
;	[SP+2] = Destination pointer
;	[SP]   = Set data
; Out	SP     = SP+10

ZStore:

	CLD
	MOV	BX,SP
	MOV	DX,DS
	LDS	SI,SS:[BX+10]
	LES	DI,SS:[BX+6]
	MOV	BX,SS:[BX+4]
	MOV	CL,BH
	XOR	CH,CH
	ADD	SI,CX
	MOV	CL,BL
	REP	MOVSB
	MOV	DS,DX
	RETF	10

; Compute set offset and bit mask
; In	AL = Element number
;	AH = 01H or 0FEH
;	DL = Number of bytes in set
;	DH = Offset of first byte in set
; Out	AL = Bit mask
;	DX = Byte offset

ZBitMask:

	MOV	CH,AL
	MOV	CL,3
	SHR	CH,CL
	SUB	CH,DH
	JB	@@1
	CMP	CH,DL
	JAE	@@1
	MOV	DL,CH
	XOR	DH,DH
	AND	AL,7
	MOV	CL,AL
	MOV	AL,AH
	ROL	AL,CL
	RETF
@@1:	CWD
	XCHG	AX,DX
	XOR	DX,DX
	RETF

; Set union
; In	[SP+4] = Destination pointer
;	[SP]   = Source pointer
; Out	SP     = SP+4

ZUnion:

	CLD
	MOV	BX,SP
	MOV	DX,DS
	LES	DI,SS:[BX+8]
	LDS	SI,SS:[BX+4]
	MOV	CX,16
@@1:	LODSW
	OR	AX,ES:[DI]
	STOSW
	LOOP	@@1
	MOV	DS,DX
	RETF	4

; Set difference
; In	[SP+4] = Destination pointer
;	[SP]   = Source pointer
; Out	SP     = SP+4

ZDifference:

	CLD
	MOV	BX,SP
	MOV	DX,DS
	LES	DI,SS:[BX+8]
	LDS	SI,SS:[BX+4]
	MOV	CX,16
@@1:	LODSW
	NOT	AX
	AND	AX,ES:[DI]
	STOSW
	LOOP	@@1
	MOV	DS,DX
	RETF	4

; Set intersection
; In	[SP+4] = Destination pointer
;	[SP]   = Source pointer
; Out	SP     = SP+4

ZIntersect:

	CLD
	MOV	BX,SP
	MOV	DX,DS
	LES	DI,SS:[BX+8]
	LDS	SI,SS:[BX+4]
	MOV	CX,16
@@1:	LODSW
	AND	AX,ES:[DI]
	STOSW
	LOOP	@@1
	MOV	DS,DX
	RETF	4

; Set equality test
; In	[SP+4] = Destination pointer
;	[SP]   = Source pointer
; Out	SP     = SP+8
;	ZF     = 1 if Dest=Source

ZEqual:

	CLD
	MOV	BX,SP
	MOV	DX,DS
	LES	DI,SS:[BX+8]
	LDS	SI,SS:[BX+4]
	MOV	CX,16
	REP	CMPSW
	MOV	DS,DX
	RETF	8

; Set relation test
; In	[SP+4] = Destination pointer
;	[SP]   = Source pointer
; Out	SP     = SP+8
;	ZF     = 1 if Dest>=Source

ZRelation:

	CLD
	MOV	BX,SP
	MOV	DX,DS
	LES	DI,SS:[BX+8]
	LDS	SI,SS:[BX+4]
	MOV	CX,16
@@1:	LODSW
	OR	AX,ES:[DI]
	SCASW
	JNE	@@2
	LOOP	@@1
@@2:	MOV	DS,DX
	RETF	8

CODE	ENDS

	END
