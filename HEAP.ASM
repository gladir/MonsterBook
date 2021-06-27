
; *******************************************************
; *							*
; *     Turbo Pascal Run-time Library                   *
; *	Heap Manager					*
; *							*
; *     Copyright (c) 1988,92 Borland International     *
; *							*
; *******************************************************

	TITLE	HEAP

	INCLUDE	SE.ASM

DATA	SEGMENT	WORD PUBLIC

; Externals

	EXTRN	HeapOrg:DWORD,HeapPtr:DWORD,HeapEnd:DWORD
	EXTRN	FreeList:DWORD,HeapError:DWORD

; Local variables

AllocSize	DW	?

DATA	ENDS

CODE	SEGMENT	BYTE PUBLIC

	ASSUME	CS:CODE,DS:DATA

; Externals

	EXTRN	HaltError:NEAR

; Publics

	PUBLIC	NewPtr,DisposePtr,MarkPtr,ReleasePtr
	PUBLIC	GetFreMem,GetFreMax,NewMemory,DisMemory

; New and GetMem standard procedures

NewPtr:

	PUSH	BP
	MOV	BP,SP
	MOV	AX,[BP+6]
	CALL	NewMemory
	POP	BP
	JC	@@1
	RETF	2
@@1:	MOV	AX,203
	JMP	HaltError

; Dispose and FreeMem standard procedures

DisposePtr:

	PUSH	BP
	MOV	BP,SP
	MOV	AX,[BP+6]
	LES	CX,[BP+8]
	MOV	BX,ES
	CALL	DisMemory
	POP	BP
	JC	@@1
	RETF	6
@@1:	MOV	AX,204
	JMP	HaltError

; Mark standard procedure

MarkPtr:

	MOV	BX,SP
	LES	DI,SS:[BX+4]
	CLD
	MOV	AX,HeapPtr.w0
	STOSW
	MOV	AX,HeapPtr.w2
	STOSW
	RETF	4

; Release standard procedure

ReleasePtr:

	MOV	BX,SP
	LES	DI,SS:[BX+4]
	LES	DI,ES:[DI]
	MOV	HeapPtr.w0,DI
	MOV	HeapPtr.w2,ES
	MOV	FreeList.w0,DI
	MOV	FreeList.w2,ES
	RETF	4

; MemAvail standard function

GetFreMem:

	MOV	BX,OFFSET CS:@@4
	JMP	SHORT GetFreHeap
@@1:	ADD	DX,1000H
	JMP	SHORT @@3
@@2:	ADD	AX,DS:[SI].mSize.w0
	JC	@@1
@@3:	ADD	DX,DS:[SI].mSize.w2
	LDS	SI,DS:[SI].mNext
@@4:	MOV	BX,DS
	CMP	BX,DI
	JNE	@@2
	RET

; MaxAvail standard function

GetFreMax:

	MOV	BX,OFFSET CS:@@4
	JMP	SHORT GetFreHeap
@@1:	CMP	DX,DS:[SI].mSize.w2
	JA	@@3
	JB	@@2
	CMP	AX,DS:[SI].mSize.w0
	JAE	@@3
@@2:	MOV	AX,DS:[SI].mSize.w0
	MOV	DX,DS:[SI].mSize.w2
@@3:	LDS	SI,DS:[SI].mNext
@@4:	MOV	BX,DS
	CMP	BX,DI
	JNE	@@1
	RET

; Common MemAvail/MaxAvail calculation

GetFreHeap:

	MOV	AX,HeapEnd.w0
	MOV	DX,HeapEnd.w2
	SUB	AX,HeapPtr.w0
	SBB	DX,HeapPtr.w2
	AND	AX,0FH
	PUSH	DS
	MOV	DI,HeapPtr.w2
	LDS	SI,FreeList
	CALL	BX
	POP	DS
	MOV	CL,4
	ROL	DX,CL
	MOV	CX,DX
	AND	CL,0F0H
	AND	DX,0FH
	ADD	AX,CX
	ADC	DX,0
	RETF

; Allocate memory
; In	AX    = Size
; Out	DX:AX = Pointer
;	CF    = 1 if error

NewMemory:

	OR	AX,AX
	JE	@@9
	MOV	AllocSize,AX
@@1:	CALL	PointerSize
	MOV	DI,OFFSET DS:FreeList
	MOV     CX,DS
	MOV	ES,CX
@@2:	MOV	CX,DI
	MOV	BX,ES
	LES	DI,ES:[DI].mNext
	MOV	SI,ES
	CMP	SI,HeapPtr.w2
	JE	@@6
	CMP	DX,ES:[DI].mSize.w2
	JA	@@2
	JB	@@3
	CMP	AX,ES:[DI].mSize.w0
	JA	@@2
@@3:	PUSH	ES
	PUSH	DI
	PUSH	BX
	PUSH	CX
	MOV	CX,ES:[DI].mNext.w0
	MOV	BX,ES:[DI].mNext.w2
	JE	@@4
	PUSH	BX
	PUSH	CX
	MOV	CX,ES:[DI].mSize.w0
	MOV	BX,ES:[DI].mSize.w2
	SUB	CX,AX
	SBB	BX,DX
	AND	CX,0FH
	ADD	AX,DI
	ADD	DX,SI
	ADD	AL,0F0H
	ADC	DX,0
	AND	AL,0FH
	MOV	DI,AX
	MOV	ES,DX
	POP	ES:[DI].mNext.w0
	POP	ES:[DI].mNext.w2
	MOV	ES:[DI].mSize.w0,CX
	MOV	ES:[DI].mSize.w2,BX
	MOV	CX,DI
	MOV	BX,ES
@@4:	POP	DI
	POP	ES
	MOV	ES:[DI].mNext.w0,CX
	MOV	ES:[DI].mNext.w2,BX
	POP	AX
	POP	DX
	CLC
@@5:	RET
@@9:	XOR	AX,AX
	CWD
	RET
@@6:	ADD	AX,DI
	ADD	DX,SI
	ADD	AL,0F0H
	ADC	DX,0
	AND	AL,0FH
	CMP	DX,HeapEnd.w2
	JB	@@7
	JA	@@8
	CMP	AX,HeapEnd.w0
	JA	@@8
@@7:	PUSH	ES
	PUSH	DI
	MOV	DI,CX
	MOV	ES,BX
	MOV	HeapPtr.w0,AX
	MOV	HeapPtr.w2,DX
	MOV	ES:[DI].mNext.w0,AX
	MOV	ES:[DI].mNext.w2,DX
	XOR	AX,AX
	PUSH	AX
	CALL	HeapError
	POP	AX
	POP	DX
	CLC
	RET
@@8:	PUSH	AllocSize
	CALL	HeapError
	CMP	AL,1
	JB	@@5
	JE	@@9
	MOV	AX,AllocSize
	JMP	@@1

; Dispose memory
; In	AX    = Size
;	BX:CX = Pointer
; Out	CF    = 1 if error

DisMemory:

	OR	AX,AX
	JE	@@6
	TEST	CX,0FFF7H
	JNE	@@5
	CMP	BX,HeapOrg.w2
	JA	@@1
	JB	@@5
	CMP	CX,HeapOrg.w0
	JB	@@5
@@1:	CMP	BX,HeapPtr.w2
	JB	@@2
	JA	@@5
	CMP	CX,HeapPtr.w0
	JAE	@@5
@@2:	CALL	PointerSize
	MOV	DI,CX
	MOV	ES,BX
	MOV	ES:[DI].mSize.w0,AX
	MOV	ES:[DI].mSize.w2,DX
	MOV	DI,OFFSET DS:FreeList
	MOV	AX,DS
	MOV	ES,AX
@@3:	MOV	AX,DI
	MOV	DX,ES
	LES	DI,ES:[DI].mNext
	MOV	SI,ES
	CMP	BX,SI
	JA	@@3
	JB	@@4
	CMP	CX,DI
	JA	@@3
	JE	@@5
@@4:	PUSH	DX
	PUSH	AX
	CALL	MergeCheck
	POP	CX
	POP	BX
	CALL	MergeCheck
	CLC
	RET
@@5:	STC
@@6:	RET

; Merge adjacent blocks
; In	BX:CX = Target block pointer
;	ES:DI = Next block pointer
; Out	ES:DI = Target block pointer

MergeCheck:

        MOV	AX,DI
	MOV	DX,ES
	MOV	DI,CX
	MOV	ES,BX
	ADD	CX,ES:[DI].mSize.w0
	ADD	BX,ES:[DI].mSize.w2
	ADD	CL,0F0H
	ADC	BX,0
	AND	CL,0FH
	CMP	BX,DX
	JNE	@@2
	CMP	CX,AX
	JNE	@@2
	CMP	DX,HeapPtr.w2
	JNE	@@1
	CMP	AX,HeapPtr.w0
	JNE	@@1
	MOV	HeapPtr.w0,DI
	MOV	HeapPtr.w2,ES
	RET
@@1:	PUSH	DS
	PUSH	DI
	MOV	SI,AX
	MOV	DS,DX
	CLD
	MOVSW
	MOVSW
	LODSW
	XCHG	AX,DX
	LODSW
	XCHG	AX,DX
	ADD	AX,ES:[DI].w0
	ADD	DX,ES:[DI].w2
	ADD	AL,0F0H
	ADC	DX,0
	AND	AL,0FH
	STOSW
	XCHG	AX,DX
	STOSW
	POP	DI
	POP	DS
	RET
@@2:	MOV	ES:[DI].mNext.w0,AX
	MOV	ES:[DI].mNext.w2,DX
	RET

; Convert word size to pointer size
; In	AX    = Word size
; Out	DX:AX = Pointer size

PointerSize:

	ADD	AX,7
	MOV	DX,AX
	RCR	DX,1
	SHR	DX,1
	SHR	DX,1
	SHR	DX,1
	AND	AX,8
	RET

CODE	ENDS

	END
