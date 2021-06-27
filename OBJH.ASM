
; *******************************************************
; *							*
; *     Turbo Pascal Run-time Library                   *
; *	Object Handling Routines			*
; *							*
; *     Copyright (c) 1989,92 Borland International     *
; *							*
; *******************************************************

	TITLE	OBJH

	INCLUDE	SE.ASM

CODE	SEGMENT	BYTE PUBLIC

	ASSUME	CS:CODE

; Externals

	EXTRN	NewMemory:NEAR,DisMemory:NEAR,HaltError:NEAR

; Publics

	PUBLIC	Construct,Destruct,CopyObject,MethodCheck

; Constructor support routine
; In	DI = Method field offset
;	BP = Constructor stack frame
; Out	ZF = 1 if failed

Construct:

	MOV	SI,[BP+10]		;SI = VMT offset
	CMP	SI,1			;Inherited constructor call?
	JB	@@2			;Yes, exit with ZF = 0
	LES	BX,[BP+6]		;ES:BX = Self
	MOV	AX,ES			;Self = nil?
	OR	AX,BX
	JE	@@3			;Yes, allocate
	MOV	WORD PTR [BP+10],0	;No deallocation on Fail
@@1:	MOV	ES:[BX+DI],SI		;Store VMT link in object
@@2:	RETF				;Exit
@@3:	MOV	AX,[SI]			;AX = Object size
    IF WindowsVersion
	INC	BP			;Setup stack frame
	PUSH	BP
	MOV	BP,SP
	PUSH	DS
    ELSE
	PUSH	BP			;Setup stack frame
	MOV	BP,SP
    ENDIF
	PUSH	SI
	PUSH	DI
	CALL	NewMemory		;Allocate dynamic object
	POP	DI
	POP	SI
    IF WindowsVersion
	MOV	SP,BP			;Remove stack frame
	POP	BP
	DEC	BP
    ELSE
	POP	BP
    ENDIF
	JC	@@4			;Error if allocation failed
	MOV	CX,AX			;Out of memory?
	OR	CX,DX
	JE	@@2			;Yes, exit with ZF = 1
	MOV	[BP+6],AX		;Store in Self pointer
	MOV	[BP+8],DX
	MOV	ES,DX			;ES:BX = Self
	MOV	BX,AX
	JMP	@@1			;Init and exit with ZF = 0
@@4:	MOV	SP,BP			;Remove callers stack frame
	POP	BP
    IF WindowsVersion
	DEC	BP
    ENDIF
	MOV	AX,203
	JMP	HaltError

; Destructor support routine
; In	DI = Method field offset
;	BP = Destructor stack frame

Destruct:

	CMP	WORD PTR [BP+10],0	;Inherited destructor call?
	JE	@@1			;Yes, exit
	LES	BX,[BP+6]		;ES:BX = Self
	MOV	SI,ES:[BX+DI]		;SI = VMT offset
	MOV	AX,[SI]			;AX = Object size
	MOV	CX,BX			;BX:CX = Self
	MOV	BX,ES
    IF WindowsVersion
	INC	BP			;Setup stack frame
	PUSH	BP
	MOV	BP,SP
	PUSH	DS
    ELSE
	PUSH	BP			;Setup stack frame
	MOV	BP,SP
    ENDIF
	CALL	DisMemory		;Dispose dynamic object
    IF WindowsVersion
	MOV	SP,BP			;Remove Windows stack frame
	POP	BP
	DEC	BP
    ELSE
	POP	BP			;Remove Windows stack frame
    ENDIF
	JC	@@2			;Error if deallocation failed
@@1:	XOR	AX,AX			;Self = nil
	MOV	[BP+6],AX
	MOV	[BP+8],AX
	RETF
@@2:	MOV	SP,BP			;Remove callers stack frame
	POP	BP
    IF WindowsVersion
	DEC	BP
    ENDIF
	MOV	AX,204
	JMP	HaltError

; Object assignment support routine

CopyObject:

	PUSH	BP
	MOV	BP,SP
	LES	DI,[BP+8]
	MOV	BX,[BP+6]
	ADD	BX,DI
	MOV	AX,ES:[BX]
	MOV	SI,AX
	MOV	CX,DS:[SI]
	MOV	DX,DS
	LDS	SI,[BP+12]
	CLD
	REP	MOVSB
	MOV	DS,DX
	MOV	ES:[BX],AX
	POP	BP
	RETF	10

; Check method table

MethodCheck:

	MOV	CX,[DI]
	JCXZ	@@1
	ADD	CX,[DI+2]
	JNE	@@1
	RETF
@@1:	MOV	AX,210
	JMP	HaltError

CODE	ENDS

	END
