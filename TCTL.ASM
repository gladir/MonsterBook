
; *******************************************************
; *							*
; *     Turbo Pascal Run-time Library                   *
; *	Textfile Control Routines			*
; *							*
; *     Copyright (c) 1988,92 Borland International     *
; *							*
; *******************************************************

	TITLE	TCTL

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

; Externals

	EXTRN	FileOpen:FAR

; Publics

	PUBLIC	AssignText,ResetText,RewriteText,AppendText
	PUBLIC	FlushText,CloseText,BufferText,FileRead
	PUBLIC	FileWrDev,FileWrite,FileClose,AssignTextC

; Assign standard procedure (PChar)

AssignTextC:

	DB	0BAH			;MOV DX,immed

; Assign standard procedure (String)

AssignText:

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
	MOV	AX,128
	STOSW
	XOR	AX,AX
	STOSW
	STOSW
	STOSW
	LEA	AX,[DI].fBuffer-fBufPtr
	STOSW
	MOV	AX,ES
	STOSW
	MOV	AX,OFFSET FileOpen
	STOSW
	MOV	AX,SEG FileOpen
	STOSW
	XOR	AX,AX
	MOV	CX,(fName-fInOutProc)/2
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

; SetTextBuf standard procedure

BufferText:

	MOV	BX,SP
	LES	DI,SS:[BX+10]
	MOV	AX,SS:[BX+4]
	MOV	ES:[DI].fBufSize,AX
	MOV	AX,SS:[BX+6].ofs
	MOV	ES:[DI].fBufPtr.ofs,AX
	MOV	AX,SS:[BX+6].seg
	MOV	ES:[DI].fBufPtr.seg,AX
	XOR	AX,AX
	MOV	ES:[DI].fBufPos,AX
	MOV	ES:[DI].fBufEnd,AX
	RETF	10

; Reset standard procedure

ResetText:

	MOV	DX,fmInput
	JMP	SHORT OpenText

; Rewrite standard procedure

RewriteText:

	MOV	DX,fmOutput
	JMP	SHORT OpenText

; Append standard procedure

AppendText:

	MOV	DX,fmInOut

; Open textfile

OpenText:

	ARG	FileP,DWORD,1

	ENTRY	WINFAR
	LES	DI,FileP
	MOV	AX,ES:[DI].fMode
	CMP	AX,fmInput
	JE	@@1
	CMP	AX,fmOutput
	JE	@@1
	CMP	AX,fmClosed
	JE	@@2
	MOV	InOutRes,102
	JMP	SHORT @@3
@@1:	PUSH	DX
	PUSH	ES
	PUSH	DI
	PUSH	CS
	CALL	CloseText
	POP	DX
@@2:	XOR	AX,AX
	MOV	ES:[DI].fMode,DX
	MOV	ES:[DI].fBufPos,AX
	MOV	ES:[DI].fBufEnd,AX
	MOV	BX,OFFSET fOpenProc
	CALL	DoFunction
	JE	@@3
	MOV	ES:[DI].fMode,fmClosed
@@3:	EXIT

; Flush standard procedure

FlushText:

	MOV	AL,0
	JMP	SHORT FlushClose

; Close standard procedure

CloseText:

	MOV	AL,1

; Flush or Close textfile

FlushClose:

	ARG	FileP,DWORD,1

	ENTRY	WINFAR
	LES	DI,FileP
	CMP	ES:[DI].fMode,fmInput
	JE	@@2
	CMP	ES:[DI].fMode,fmOutput
	JE	@@1
	MOV	InOutRes,103
	JMP	SHORT @@3
@@1:	PUSH	AX
	MOV	BX,OFFSET fInOutProc
	CALL	DoFunction
	POP	AX
@@2:	OR	AL,AL
	JE	@@3
	MOV	BX,fCloseProc
	CALL	DoFunction
	MOV	ES:[DI].fMode,fmClosed
@@3:	EXIT

; Do textfile function call

DoFunction:

	PUSH	ES
	PUSH	DI
	PUSH	ES
	PUSH	DI
	CALL	DWORD PTR ES:[DI+BX]
	OR	AX,AX
	JE	@@1
	MOV	InOutRes,AX
@@1:	POP	DI
	POP	ES
	RET

; Standard textfile read procedure

FileRead:

	MOV	BX,SP
	PUSH	DS
	LES	DI,SS:[BX+4]
	LDS	DX,ES:[DI].fBufPtr
	MOV	CX,ES:[DI].fBufSize
	MOV	BX,ES:[DI].fHandle
	MOV	AH,dosRead
	INT	DOS
	JC	@@2
	MOV	ES:[DI].fBufEnd,AX
	XOR	AX,AX
@@1:	MOV	ES:[DI].fBufPos,0
	POP	DS
	RETF	4
@@2:	MOV	ES:[DI].fBufEnd,0
	JMP	SHORT @@1

; Standard textfile disk write procedure

FileWrite:

	MOV	BX,SP
	PUSH	DS
	LES	DI,SS:[BX+4]
	LDS	DX,ES:[DI].fBufPtr
	XOR	CX,CX
	XCHG	CX,ES:[DI].fBufPos
	MOV	BX,ES:[DI].fHandle
	MOV	AH,dosWrite
	INT	DOS
	JC	@@1
	SUB	AX,CX
	JE	@@1
	MOV	AX,101
@@1:	POP	DS
	RETF	4

; Standard textfile device write procedure

FileWrDev:

	MOV	BX,SP
	PUSH	DS
	LES	DI,SS:[BX+4]
	LDS	DX,ES:[DI].fBufPtr
	XOR	CX,CX
	XCHG	CX,ES:[DI].fBufPos
	MOV	BX,ES:[DI].fHandle
	MOV	AH,dosWrite
	INT	DOS
	JC	@@1
	XOR	AX,AX
@@1:	POP	DS
	RETF	4

; Standard textfile close procedure

FileClose:

	MOV	BX,SP
	LES	DI,SS:[BX+4]
	MOV	BX,ES:[DI].fHandle
	CMP	BX,4
	JBE	@@1
	MOV	AH,dosClose
	INT	DOS
	JC	@@2
@@1:	XOR	AX,AX
@@2:	RETF	4

CODE	ENDS

	END
