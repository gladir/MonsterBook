
; *******************************************************
; *							*
; *     Turbo Pascal Run-time Library                   *
; *	Directory Handling Routines			*
; *							*
; *     Copyright (c) 1988,92 Borland International     *
; *							*
; *******************************************************

	TITLE	DIRH

	INCLUDE	SE.ASM

DATA	SEGMENT	WORD PUBLIC

; Externals

	EXTRN	InOutRes:WORD

DATA	ENDS

    IF WindowsVersion

; Windows entry points

	EXTRN	AnsiToOem:FAR,OemToAnsi:FAR

    ENDIF

CODE	SEGMENT	BYTE PUBLIC

	ASSUME	CS:CODE,DS:DATA

; Publics

	PUBLIC	DirGet,DirSet,DirCreate,DirRemove

; GetDir standard procedure

DirGet:

	ARG	Drive,BYTE,2
	ARG	StrP,DWORD,1
	ARG	StrLen,WORD,1
	LOC	Path,BYTE,128

	ENTRY	FAR
	PUSH	DS
	LEA	SI,Path
	PUSH	SS
	POP	DS
	MOV	AL,Drive
	OR	AL,AL
	JNZ	@@1
	MOV	AH,dosGetDrive
	INT	DOS
	INC	AL
@@1:	MOV	DL,AL
	ADD	AL,'A'-1
	MOV	[SI],AL
	INC	SI
	MOV	WORD PTR [SI],'\:'
	INC	SI
	INC	SI
	MOV	AH,dosGetDir
	INT	DOS
	JNC	@@2
	MOV	BYTE PTR [SI],0
@@2:	LEA	SI,Path
    IF WindowsVersion
	PUSH	DS
	PUSH	SI
	PUSH	DS
	PUSH	SI
	CALL	OemToAnsi
    ENDIF
	LES	DI,StrP
	MOV	CX,StrLen
	XOR	BX,BX
	CLD
@@3:	LODSB
	OR	AL,AL
	JE	@@4
	INC	BX
	MOV	ES:[DI+BX],AL
	LOOP	@@3
@@4:	MOV	ES:[DI],BL
	POP	DS
	EXIT

; ChDir standard procedure

DirSet:

	ARG	StrP,DWORD,1
	LOC	Path,BYTE,128

	ENTRY	FAR
	CALL	GetPath
	MOV	AX,Path.w0
	OR	AL,AL
	JE	@@3
	CMP	AH,':'
	JNE	@@2
	AND	AL,NOT ' '
	SUB	AL,'A'
	MOV	DL,AL
	MOV	AH,dosSetDrive
	INT	DOS
	MOV	AH,dosGetDrive
	INT	DOS
	CMP	AL,DL
	JE	@@1
	MOV	InOutRes,15
	JMP	SHORT @@3
@@1:	CMP	Path[2],0
	JE	@@3
@@2:	MOV	AH,dosSetDir
	CALL	DosPath
@@3:	EXIT

; MkDir standard procedure

DirCreate:

	ARG	StrP,DWORD,1
	LOC	Path,BYTE,128

	ENTRY	FAR
	CALL	GetPath
	MOV	AH,dosCreateDir
	CALL	DosPath
	EXIT

; RmDir standard procedure

DirRemove:

	ARG	StrP,DWORD,1
	LOC	Path,BYTE,128

	ENTRY	FAR
	CALL	GetPath
	MOV	AH,dosRemoveDir
	CALL	DosPath
	EXIT

; Copy string to zero terminated path

GetPath:

	PUSH	DS
	LDS	SI,[BP+6]
	LEA	DI,[BP-128]
	PUSH	SS
	POP	ES
    IF WindowsVersion
	PUSH	ES
	PUSH	DI
	PUSH	ES
	PUSH	DI
    ENDIF
	CLD
	LODSB
	CMP	AL,127
	JB	@@1
	MOV	AL,127
@@1:	CBW
	MOV	CX,AX
	REP	MOVSB
	XOR	AL,AL
	STOSB
    IF WindowsVersion
	CALL	AnsiToOem
    ENDIF
	POP	DS
	RET

; Do DOS function on path

DosPath:

	PUSH	DS
	LEA	DX,[BP-128]
	PUSH	SS
	POP	DS
	INT	DOS
	POP	DS
	JNC	@@1
	MOV	InOutRes,AX
@@1:	RET

CODE	ENDS

	END
