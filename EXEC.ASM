
; *******************************************************
; *							*
; *	Turbo Pascal Runtime Library Version 5.5	*
; *	Program Execution Routines			*
; *							*
; *	Copyright (C) 1988,89 Borland International	*
; *							*
; *******************************************************

	TITLE	EXEC

	LOCALS	@@

DATA	SEGMENT	WORD PUBLIC

	EXTRN	DosError:WORD,PrefixSeg:WORD

SaveSP		DW	?
SaveSS		DW	?

DATA	ENDS

CODE	SEGMENT	BYTE PUBLIC

	ASSUME	CS:CODE,DS:DATA

	PUBLIC	Exec

Exec		PROC	FAR

PathArg		EQU	DWORD PTR [BP+10]
CmdLineArg	EQU	DWORD PTR [BP+6]
FileSeg2	EQU	WORD PTR [BP-2]
FileOfs2	EQU	WORD PTR [BP-4]
FileSeg1	EQU	WORD PTR [BP-6]
FileOfs1	EQU	WORD PTR [BP-8]
CmdLineSeg	EQU	WORD PTR [BP-10]
CmdLineOfs	EQU	WORD PTR [BP-12]
EnvironSeg	EQU	WORD PTR [BP-14]
FileBlock1	EQU	BYTE PTR [BP-30]
FileBlock2	EQU	BYTE PTR [BP-46]
Path		EQU	BYTE PTR [BP-126]
CmdLine		EQU	BYTE PTR [BP-254]

	PUSH	BP
	MOV	BP,SP
	MOV	SaveSP,SP
	MOV	SaveSS,SS
	SUB	SP,254
	MOV	DS,PrefixSeg
	MOV	AX,WORD PTR DS:2CH
	MOV	EnvironSeg,AX
	PUSH	SS
	POP	ES
	CLD
	LDS	SI,PathArg
	LEA	DI,Path
	LODSB
	CMP	AL,79
	JB	@@1
	MOV	AL,79
@@1:	CBW
	XCHG	AX,CX
	REP	MOVSB
	XOR	AL,AL
	STOSB
	LDS	SI,CmdLineArg
	LEA	DI,CmdLine
	LODSB
	CMP	AL,126
	JB	@@2
	MOV	AL,126
@@2:	STOSB
	CBW
	XCHG	AX,CX
	REP	MOVSB
	MOV	AL,0DH
	STOSB
	PUSH	SS
	POP	DS
	LEA	SI,CmdLine
	MOV	CmdLineOfs,SI
	MOV	CmdLineSeg,DS
	INC	SI
	LEA	DI,FileBlock1
	MOV	FileOfs1,DI
	MOV	FileSeg1,ES
	MOV	AX,2901H
	INT	21H
	LEA	DI,FileBlock2
	MOV	FileOfs2,DI
	MOV	FileSeg2,ES
	MOV	AX,2901H
	INT	21H
	LEA	DX,Path
	LEA	BX,EnvironSeg
	MOV	AX,4B00H
	INT	21H
	JC	@@3
	XOR	AX,AX
@@3:	MOV	DX,SEG DATA
	MOV	DS,DX
	CLI
	MOV	SP,SaveSP
	MOV	SS,SaveSS
	STI
	MOV	DosError,AX
	POP	BP
	RET	8

Exec		ENDP

	PUBLIC	DosExitCode

DosExitCode	PROC	FAR

	MOV	AH,4DH
	INT	21H
	RET

DosExitCode	ENDP

CODE	ENDS

	END
