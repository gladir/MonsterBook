
; *******************************************************
; *							*
; *     Turbo Pascal Run-time Library                   *
; *	File Utility Routines				*
; *							*
; *     Copyright (c) 1988,92 Borland International     *
; *							*
; *******************************************************

	TITLE	FDIR

	INCLUDE	SE.ASM

DATA	SEGMENT	WORD PUBLIC

; Externals

	EXTRN	InOutRes:WORD

DATA	ENDS

    IF WindowsVersion

; Windows entry points

	EXTRN	AnsiToOem:FAR

    ENDIF

CODE	SEGMENT	BYTE PUBLIC

	ASSUME	CS:CODE,DS:DATA

; Publics

	PUBLIC	EraseFile,RenameFile,RenameFileC

; Erase standard procedure

EraseFile:

	MOV	BX,SP
	PUSH	DS
	LDS	DX,SS:[BX+4]
	ADD	DX,OFFSET fName
	MOV	AH,dosDelete
	INT	DOS
	POP	DS
	JNC	@@1
	MOV	InOutRes,AX
@@1:	RETF	4

; Rename standard procedure (PChar)

RenameFileC:

	DB	0BAH			;MOV DX,immed

; Rename standard procedure (String)

RenameFile:

	ARG	FileP,DWORD,1
	ARG	NameP,DWORD,1
	LOC	NewName,BYTE,80

	XOR	DX,DX
	ENTRY	FAR
	PUSH	DS
	LDS	SI,NameP
	LEA	DI,NewName
	PUSH	SS
	POP	ES
    IF WindowsVersion
	PUSH	ES
	PUSH	DI
	PUSH	ES
	PUSH	DI
    ENDIF
	CLD
	MOV	CX,79
	OR	DX,DX
	JNE	@@0
	LODSB
	CMP	CL,AL
	JBE	@@0
	MOV	CL,AL
	JCXZ	@@1
@@0:	LODSB
	OR	AL,AL
	JE	@@1
	STOSB
	LOOP	@@0
@@1:	XOR	AL,AL
	STOSB
    IF WindowsVersion
	CALL	AnsiToOem
    ENDIF
	LDS	DX,FileP
	ADD	DX,OFFSET fName
	LEA	DI,NewName
	MOV	AH,dosRename
	INT	DOS
	POP	DS
	JNC	@@2
	MOV	InOutRes,AX
	JMP	SHORT @@4
@@2:	PUSH	DS
	LEA	SI,NewName
	PUSH	SS
	POP	DS
	LES	DI,FileP
	ADD	DI,OFFSET fName
	CLD
@@3:	LODSB
	STOSB
	OR	AL,AL
	JNE	@@3
	POP	DS
@@4:	EXIT

CODE	ENDS

	END
