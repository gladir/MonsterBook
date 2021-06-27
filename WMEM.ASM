
; *******************************************************
; *							*
; *	Turbo Pascal Runtime Library			*
; *	Protected Mode Memory Manager			*
; *							*
; *	Copyright (C) 1988,91 Borland International	*
; *							*
; *******************************************************

	TITLE	WMEM

	INCLUDE	SE.ASM

; Heap segment header

hsSignature	EQU	(WORD PTR 0)
hsReserved	EQU	(WORD PTR 2)
hsFreeList	EQU	(BYTE PTR 4)
hsMemFree	EQU	(WORD PTR 8)
hsNextHeap	EQU	(WORD PTR 10)
hsHeapOrg	EQU	(BYTE PTR 12)

; Heap block header

hbNext		EQU	(WORD PTR 0)
hbSize		EQU	(WORD PTR 2)

    IF DPMIVersion
	.286P
    ENDIF

DATA	SEGMENT	WORD PUBLIC

; Externals

	EXTRN	HeapList:WORD,HeapLimit:WORD,HeapBlock:WORD
	EXTRN	HeapError:DWORD
    IF WindowsVersion
	EXTRN	HeapAllocFlags:WORD
    ENDIF

; Local variables

AllocSize	DW	?

DATA	ENDS

; External memory manager entry points

    IF WindowsVersion
	EXTRN	GlobalAlloc:FAR,GlobalLock:FAR,GlobalFree:FAR
	EXTRN	GlobalHandle:FAR,GlobalUnlock:FAR,GlobalCompact:FAR
	EXTRN	GetFreeSpace:FAR
    ELSE
	EXTRN	MemAllocateBlock:FAR,MemFreeBlock:FAR,MemQueryFreeMem:FAR
    ENDIF

CODE	SEGMENT	BYTE PUBLIC

	ASSUME	CS:CODE,DS:DATA

; Externals

	EXTRN	HaltError:NEAR

; Publics

	PUBLIC	NewPtr,DisposePtr,MarkPtr,ReleasePtr
	PUBLIC	GetFreMem,GetFreMax,NewMemory,DisMemory

; New and GetMem standard procedures

NewPtr:

	INC	BP
	PUSH	BP
	MOV	BP,SP
	PUSH	DS
	MOV	AX,[BP+6]
	CALL	NewMemory
	MOV	SP,BP
	POP	BP
	DEC	BP
	JC	@@1
	RETF	2
@@1:	MOV	AX,203
	JMP	HaltError

; Dispose and FreeMem standard procedures

DisposePtr:

	INC	BP
	PUSH	BP
	MOV	BP,SP
	PUSH	DS
	MOV	AX,[BP+6]
	MOV	CX,[BP+8]
	MOV	BX,[BP+10]
	CALL	DisMemory
	MOV	SP,BP
	POP	BP
	DEC	BP
	JC	MemError
	RETF	6

; Mark and Release standard procedures

MemError:
MarkPtr:
ReleasePtr:

	MOV	AX,204
	JMP	HaltError

; MemAvail standard function

GetFreMem:

	INC	BP
	PUSH	BP
	MOV	BP,SP
	PUSH	DS
    IF WindowsVersion
	MOV	AX,1000H		;GMEM_NOT_BANKED
	PUSH	AX
	CALL	GetFreeSpace
    ELSE
	PUSH	2
	PUSH	0
	CALL	MemQueryFreeMem
    ENDIF
	MOV	CX,HeapList
	JCXZ	@@2
@@1:	MOV	ES,CX
	ADD	AX,ES:hsMemFree
	ADC	DX,0
	MOV	CX,ES:hsNextHeap
	CMP	CX,HeapList
	JNE	@@1
@@2:	MOV	SP,BP
	POP	BP
	DEC	BP
	RETF

; MaxAvail standard function

GetFreMax:

	INC	BP
	PUSH	BP
	MOV	BP,SP
	PUSH	DS
    IF WindowsVersion
	XOR	AX,AX
	PUSH	AX
	PUSH	AX
	CALL	GlobalCompact
    ELSE
	PUSH	2
	PUSH	0
	CALL	MemQueryFreeMem
    ENDIF
	OR	DX,DX
	JNE	@@3
	MOV	CX,HeapList
	JCXZ	@@3
@@1:	MOV	ES,CX
	CMP	AX,ES:hsMemFree
	JAE	@@2
	MOV	AX,ES:hsMemFree
@@2:	MOV	CX,ES:hsNextHeap
	CMP	CX,HeapList
	JNE	@@1
@@3:	MOV	SP,BP
	POP	BP
	DEC	BP
	RETF

; Allocate memory
; In	AX    = Size in bytes
; Out	DX:AX = Block pointer
;	CF    = 1 if error

NewMemory:

	OR	AX,AX
	JE	@@7
	MOV	AllocSize,AX
@@1:	CMP	AX,HeapLimit
	JB	@@2
	CALL	NewGlobal
	JNC	@@6
	CMP	HeapLimit,0
	JE	@@4
	MOV	AX,AllocSize
	MOV	BX,HeapBlock
	SUB	BX,OFFSET hsHeapOrg
	CMP	AX,BX
	JA	@@4
	CALL	NewHeapMem
	JMP	SHORT @@3
@@2:	CALL	NewHeapMem
	JNC	@@6
	MOV	AX,AllocSize
	CALL	NewGlobal
@@3:	JNC	@@6
@@4:	MOV	AX,HeapError.ofs
	OR	AX,HeapError.seg
	JE	@@5
	PUSH	AllocSize
	CALL	HeapError
@@5:	CMP	AX,1
	MOV	AX,AllocSize
	JA	@@1
	JB	@@6
@@7:	XOR	AX,AX
	CWD
@@6:	RET

; Allocate global block
; In	AX    = Block size
; Out	DX:AX = Block pointer
;	CF    = 1 if error

NewGlobal:

    IF WindowsVersion
	PUSH	HeapAllocFlags
	XOR	DX,DX
	PUSH	DX
	PUSH	AX
	CALL	GlobalAlloc
	CMP	AX,1
	JB	@@1
	PUSH	AX
	CALL	GlobalLock
	CLC
    ELSE
	PUSH	0
	MOV	DX,SP
	PUSH	0			;heapHandle
	PUSH	AX			;size
	PUSH	2			;attributes
	PUSH	0			;eventProc
	PUSH	0
	PUSH	SS			;selector
	PUSH	DX
	CALL	MemAllocateBlock
	POP	DX
	OR	AX,AX
	JE	@@1
	STC
    ENDIF
@@1:	RET

; Allocate heap block
; In	AX    = Block size
; Out	DX:AX = Block pointer
;	CF    = 1 if error

NewHeapMem:

	ADD	AX,3
	AND	AL,0FCH
	MOV	CX,HeapList
	JCXZ	@@2
@@1:	MOV	ES,CX
	CALL	NewBlock
	JNC	@@3
	MOV	CX,ES:hsNextHeap
	CMP	CX,HeapList
	JNE	@@1
@@2:	CALL	NewSegment
	JC	@@4
	CALL	NewBlock
@@3:	MOV	HeapList,ES
	MOV	AX,BX
	MOV	DX,ES
@@4:	RET

; Allocate heap segment
; Out	ES = Heap segment
;	CF = 1 if error

NewSegment:

	PUSH	AX
	MOV	AX,HeapBlock
	CALL	NewGlobal
	JC	@@2
	MOV	ES,DX
	XOR	DI,DI
	CLD
	MOV	AX,'PT'			;hsSignature
	STOSW
	XOR	AX,AX			;hsReserved
	STOSW
	MOV	AX,OFFSET hsHeapOrg
	STOSW				;hsFreeList.hbNext
	XOR	AX,AX
	STOSW				;hsFreeList.hbSize
	MOV	AX,HeapBlock
	SUB	AX,OFFSET hsHeapOrg
	STOSW				;hsMemFree
	PUSH	AX
	MOV	AX,ES
	MOV	CX,HeapList
	JCXZ	@@1
	PUSH	DS
	MOV	DS,CX
	XCHG	AX,DS:hsNextHeap
	POP	DS
@@1:	STOSW				;hsNextHeap
	XOR	AX,AX
	STOSW				;hbNext
	POP	AX
	STOSW				;hbSize
@@2:	POP	AX
	RET

; Allocate block from heap segment
; In	AX = Block size
;	ES = Heap segment
; Out	BX = Block offset
;	CF = 1 if error

NewBlock:

	MOV	BX,OFFSET hsFreeList
@@1:	MOV	SI,BX
	MOV	BX,ES:[BX].hbNext
	CMP	BX,1
	JB	@@3
	MOV	DX,ES:[BX].hbSize
	SUB	DX,AX
	JB	@@1
	MOV	CX,ES:[BX].hbNext
	JE	@@2
	MOV	DI,BX
	ADD	DI,AX
	MOV	ES:[DI].hbNext,CX
	MOV	ES:[DI].hbSize,DX
	MOV	CX,DI
@@2:	MOV	ES:[SI].hbNext,CX
	SUB	ES:hsMemFree,AX
	CLC
@@3:	RET

; Dispose memory
; In	AX    = Block size
;	BX:CX = Block pointer
; Out	CF    = 1 if error

DisMemory:

	OR	AX,AX
	JE	@@4
	JCXZ	@@6
	ADD	AX,3
	AND	AL,0FCH
	MOV	ES,BX
	MOV	BX,CX
	CMP	ES:hsSignature,'PT'
	JNE	@@5
	TEST	BL,3
	JNE	@@5
	MOV	SI,OFFSET hsFreeList
@@1:	MOV	DI,SI
	MOV	SI,ES:[SI].hbNext
	OR	SI,SI
	JE	@@2
	CMP	BX,SI
	JA	@@1
	JE	@@5
@@2:	MOV	ES:[BX].hbNext,SI
	MOV	ES:[BX].hbSize,AX
	ADD	AX,ES:hsMemFree
	MOV	ES:hsMemFree,AX
	ADD	AX,OFFSET hsHeapOrg
	CMP	AX,HeapBlock
	JE	@@7
	CALL	@@3
	MOV	ES:[DI].hbNext,BX
	MOV	BX,DI
@@3:	MOV	SI,BX
	ADD	SI,ES:[BX].hbSize
	CMP	SI,ES:[BX].hbNext
	JNE	@@4
	MOV	AX,ES:[SI].hbNext
	MOV	ES:[BX].hbNext,AX
	MOV	AX,ES:[SI].hbSize
	ADD	ES:[BX].hbSize,AX
@@4:	CLC
	RET
@@5:	STC
	RET
@@6:	MOV	AX,DS
	CMP	AX,BX
	JE	@@5
    IF WindowsVersion
	PUSH	BX
	CALL	GlobalHandle
	OR	AX,AX
	JE	@@5
	PUSH	AX
	PUSH	AX
	CALL	GlobalUnlock
	CALL	GlobalFree
    ELSE
	PUSH	BX
	CALL	MemFreeBlock
    ENDIF
	CLC
	RET
@@7:	XOR	AX,AX
	MOV	BX,ES
	MOV	DX,ES:hsNextHeap
	CMP	BX,DX
	JE	@@9
	MOV	AX,HeapList
@@8:	MOV	ES,AX
	MOV	AX,ES:hsNextHeap
	CMP	AX,BX
	JNE	@@8
	MOV	ES:hsNextHeap,DX
	MOV	AX,ES
@@9:	MOV	HeapList,AX
	JMP	@@6

CODE	ENDS

	END
