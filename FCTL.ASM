
; *******************************************************
; *							*
; *     Turbo Pascal Run-time Library                   *
; *	File Control Routines				*
; *							*
; *     Copyright (c) 1988,92 Borland International     *
; *							*
; *******************************************************

	TITLE	FCTL

	INCLUDE	SE.ASM

DATA	SEGMENT	WORD PUBLIC

; Externals

	EXTRN	FileMode:BYTE,InOutRes:WORD

DATA	ENDS

    IF WindowsVersion

; Windows entry points

	EXTRN	AnsiToOem:FAR

    ENDIF

CODE	SEGMENT	BYTE PUBLIC

	ASSUME	CS:CODE,DS:DATA

; Publics

	PUBLIC	AssignFile,ResetFile,RewriteFile,TruncFile,CloseFile
	PUBLIC	ReadFile,WriteFile,ReadBlock,WriteBlock,SeekFile
	PUBLIC	AssignFileC

; Assign standard procedure (PChar)

AssignFileC:

	DB	0BAH			;MOV DX,immed

; Assign standard procedure (String)

AssignFile:

	XOR	DX,DX
	MOV	BX,SP
	PUSH	DS
	LES	DI,SS:[BX+8]
	LDS	SI,SS:[BX+4]
	CLD
	XOR	AX,AX
	STOSW
	MOV	AX,fmClosed
	STOSW
	XOR	AX,AX
	MOV	CX,(fName-fBufSize)/2
	REP	STOSW
    IF WindowsVersion
	PUSH	ES
	PUSH	DI
	PUSH	ES
	PUSH	DI
    ENDIF
	MOV	CX,79
	OR	DX,DX
	JNE	@@1
	LODSB
	CMP	CL,AL
	JBE	@@1
	MOV	CL,AL
	JCXZ	@@2
@@1:	LODSB
	OR	AL,AL
	JE	@@2
	STOSB
	LOOP	@@1
@@2:	XOR	AL,AL
	STOSB
    IF WindowsVersion
	CALL	AnsiToOem
    ENDIF
	POP	DS
	RETF	8

; Reset standard procedure

ResetFile:

	MOV	AL,FileMode
	MOV	AH,dosOpen
	XOR	DX,DX
	JMP	SHORT OpenFile

; Rewrite standard procedure

RewriteFile:

	MOV	AX,dosCreate*256
	MOV	DX,1

; Open file

OpenFile:

	ARG	FileP,DWORD,1
	ARG	RecSize,WORD,1

	ENTRY	FAR
	LES	DI,FileP
	CMP	ES:[DI].fMode,fmClosed
	JE	@@2
	CMP	ES:[DI].fMode,fmInOut
	JE	@@1
	MOV	InOutRes,102
	JMP	SHORT @@5
@@1:	PUSH	AX
	PUSH	DX
	PUSH	ES
	PUSH	DI
	PUSH	CS
	CALL	CloseFile
	POP	DX
	POP	AX
@@2:	CMP	ES:[DI].fName,0
	JE	@@3
	PUSH	DS
	LEA	DX,[DI].fName
	PUSH	ES
	POP	DS
	XOR	CX,CX
	INT	DOS
	POP	DS
	JNC	@@4
	MOV	InOutRes,AX
	JMP	SHORT @@5
@@3:	XCHG	AX,DX
@@4:	MOV	ES:[DI].fMode,fmInOut
	MOV	ES:[DI].fHandle,AX
	MOV	AX,RecSize
	MOV	ES:[DI].fBufSize,AX
@@5:	EXIT

; Truncate standard procedure

TruncFile:

	MOV	BX,SP
	LES	DI,SS:[BX+4]
	CALL	OpenCheck
	JNE	@@1
	XOR	CX,CX
	MOV	BX,ES:[DI].fHandle
	MOV	AH,dosWrite
	INT	DOS
	JNC	@@1
	MOV	InOutRes,AX
@@1:	RETF	4

; Close standard procedure

CloseFile:

	MOV	BX,SP
	LES	DI,SS:[BX+4]
	CALL	OpenCheck
	JNE	@@2
	MOV	BX,ES:[DI].fHandle
	CMP	BX,4
	JBE	@@1
	MOV	AH,dosClose
	INT	DOS
	JNC	@@1
	MOV	InOutRes,AX
@@1:	MOV	ES:[DI].fMode,fmClosed
@@2:	RETF	4

; Check that file is open

OpenCheck:

	CMP	ES:[DI].fMode,fmInOut
	JE	@@1
	MOV	InOutRes,103
@@1:	RET

; Read standard procedure

ReadFile:

	MOV	AH,dosRead
	MOV	DX,100
	JMP	SHORT InOutFile

; Write standard procedure

WriteFile:

	MOV	AH,dosWrite
	MOV	DX,101

; Typed file I/O

InOutFile:

	ARG	FileP,DWORD,1
	ARG	BufferP,DWORD,1

	ENTRY	FAR
	LES	DI,FileP
	CALL	OpenCheck
	JNE	@@2
	PUSH	DS
	PUSH	DX
	LDS	DX,BufferP
	MOV	CX,ES:[DI].fBufSize
	MOV	BX,ES:[DI].fHandle
	INT	DOS
	POP	DX
	POP	DS
	JC	@@1
	CMP	AX,CX
	JE	@@2
	MOV	AX,DX
@@1:	MOV	InOutRes,AX
@@2:	EXIT	4

; BlockRead standard procedure

ReadBlock:

	MOV	BL,dosRead
	MOV	CX,100
	JMP	SHORT InOutBlock

; BlockWrite standard procedure

WriteBlock:

	MOV	BL,dosWrite
	MOV	CX,101

; Untyped file I/O

InOutBlock:

	ARG	FileP,DWORD,1
	ARG	BufferP,DWORD,1
	ARG	Count,WORD,1
	ARG	ResultP,DWORD,1

	ENTRY	FAR
	LES	DI,FileP
	CALL	OpenCheck
	JNE	@@4
	MOV	AX,Count
	OR	AX,AX
	JE	@@1
	PUSH	DS
	PUSH	CX
	MUL	ES:[DI].fBufSize
	MOV	CX,AX
	LDS	DX,BufferP
	MOV	AH,BL
	MOV	BX,ES:[DI].fHandle
	INT	DOS
	POP	CX
	POP	DS
	JC	@@3
	XOR	DX,DX
	DIV	ES:[DI].fBufSize
@@1:	LES	DI,ResultP
	MOV	DX,ES
	OR	DX,DI
	JE	@@2
	MOV	ES:[DI],AX
	JMP	SHORT @@5
@@2:	CMP	AX,Count
	JE	@@5
	MOV	InOutRes,CX
	JMP	SHORT @@5
@@3:	MOV	InOutRes,AX
@@4:	LES	DI,ResultP
	MOV	DX,ES
	OR	DX,DI
	JE	@@5
	XOR	AX,AX
	MOV	ES:[DI],AX
@@5:	EXIT

; Seek standard procedure

SeekFile:

	ARG	FileP,DWORD,1
	ARG	FilePos,DWORD,1

	ENTRY	FAR
	LES	DI,FileP
	CALL	OpenCheck
	JNE	@@1
	MOV	AX,FilePos.w2
	MUL	ES:[DI].fBufSize
	MOV	CX,AX
	MOV	AX,FilePos.w0
	MUL	ES:[DI].fBufSize
	ADD	CX,DX
	MOV	DX,AX
	MOV	BX,ES:[DI].fHandle
	MOV	AX,dosSeek*256
	INT	DOS
	JNC	@@1
	MOV	InOutRes,AX
@@1:	EXIT

CODE	ENDS

	END
