
; *******************************************************
; *							*
; *     Turbo Pascal Run-time Library                   *
; *	Dynamic Method Call Dispatcher			*
; *							*
; *     Copyright (c) 1989,92 Borland International     *
; *							*
; *******************************************************

	TITLE	DMTH

	INCLUDE	SE.ASM

; Virtual method table layout

vmtInstSize	EQU	(WORD PTR 0)
vmtInstCheck	EQU	(WORD PTR 2)
vmtDMTPtr	EQU	(WORD PTR 4)
vmtReserved	EQU	(WORD PTR 6)
vmtEntryTable	EQU	(DWORD PTR 8)

; Dynamic method table layout

dmtParent	EQU	(WORD PTR 0)
dmtCacheIndex	EQU	(WORD PTR 2)
dmtCacheEntry	EQU	(WORD PTR 4)
dmtEntryCount	EQU	(WORD PTR 6)
dmtEntryTable	EQU	(WORD PTR 8)

CODE	SEGMENT	BYTE PUBLIC

	ASSUME	CS:CODE

; Externals

	EXTRN	HaltError:NEAR

; Publics

	PUBLIC	FindMethod,CallMethod

; Find dynamic method

FindMethod:

	CALL	GetMethod
	RETF

; Call dynamic method

CallMethod:

	CALL	GetMethod
	JMP	DWORD PTR [DI]

; Find dynamic method
; In	AX = Dynamic method index
;	DI = Virtual method table pointer
; Out	DI = Pointer to method vector

GetMethod:

	MOV	BX,[DI].vmtDMTPtr
	CMP	AX,[BX].dmtCacheIndex
	JNE	@@1
	MOV	DI,[BX].dmtCacheEntry
	RET
@@1:	MOV	SI,DS
	MOV	ES,SI
	MOV	SI,BX
	CLD
@@2:	MOV	CX,[BX].dmtEntryCount
	MOV	DX,CX
	LEA	DI,[BX].dmtEntryTable
	REPNE	SCASW
	JE	@@3
	MOV	BX,ES:[BX].dmtParent
	OR	BX,BX
	JNE	@@2
	POP	AX
	MOV	AX,210
	JMP	HaltError
@@3:	DEC	DX
	SHL	DX,1
	SUB	DX,CX
	SHL	DX,1
	ADD	DI,DX
	MOV	[SI].dmtCacheIndex,AX
	MOV	[SI].dmtCacheEntry,DI
	RET

CODE	ENDS

	END
