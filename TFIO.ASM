
; *******************************************************
; *							*
; *     Turbo Pascal Run-time Library                   *
; *	Standard Textfile Open Routine			*
; *							*
; *     Copyright (c) 1988,92 Borland International     *
; *							*
; *******************************************************

	TITLE	TFIO

	INCLUDE	SE.ASM

CODE	SEGMENT	BYTE PUBLIC

	ASSUME	CS:CODE

; Externals

	EXTRN	FileRead:FAR,FileWrDev:FAR,FileWrite:FAR
	EXTRN	FileClose:FAR

; Publics

	PUBLIC	FileOpen

; Standard textfile open procedure

FileOpen:

	MOV	BX,SP
	PUSH	DS
	LDS	DI,SS:[BX+4]
	XOR	CX,CX
	MOV	[DI].fHandle,CX
	MOV	AX,dosOpen*256
	CMP	[DI].fMode,fmInput
	JE	@@1
	MOV	AL,2
	INC	[DI].fHandle
	CMP	[DI].fMode,fmInOut
	JE	@@1
	MOV	AH,dosCreate
@@1:	CMP	[DI].fName,0
	JE	@@2
	LEA	DX,[DI].fName
	INT	DOS
	JC	@@6
	MOV	[DI].fHandle,AX
@@2:	MOV	AX,OFFSET FileRead
	MOV	DX,SEG FileRead
	XOR	CX,CX
	XOR	BX,BX
	CMP	[DI].fMode,fmInput
	JE	@@5
	MOV	BX,[DI].fHandle
	MOV	AX,dosIOCtl*256
	INT	DOS
	TEST	DL,80H
	MOV	AX,OFFSET FileWrDev
	MOV	DX,SEG FileWrDev
	MOV	CX,AX
	MOV	BX,DX
	JNE	@@4
	CMP	[DI].fMode,fmInOut
	JNE	@@3
	CALL	FileAppend
@@3:	MOV	AX,OFFSET FileWrite
	MOV	DX,SEG FileWrite
	XOR	CX,CX
	XOR	BX,BX
@@4:	MOV	[DI].fMode,fmOutput
@@5:	MOV	[DI].fInOutProc.ofs,AX
	MOV	[DI].fInOutProc.seg,DX
	MOV	[DI].fFlushProc.ofs,CX
	MOV	[DI].fFlushProc.seg,BX
	MOV	[DI].fCloseProc.ofs,OFFSET FileClose
	MOV	[DI].fCloseProc.seg,SEG FileClose
	XOR	AX,AX
@@6:	POP	DS
	RETF	4

; Prepare textfile for appending

FileAppend:

	XOR	DX,DX
	XOR	CX,CX
	MOV	BX,[DI].fHandle
	MOV	AX,dosSeek*256+2
	INT	DOS
	SUB	AX,128
	SBB	DX,0
	JNC	@@1
	XOR	AX,AX
	XOR	DX,DX
@@1:	MOV	CX,DX
	MOV	DX,AX
	MOV	BX,[DI].fHandle
	MOV	AX,dosSeek*256
	INT	DOS
	LEA	DX,[DI].fBuffer
	MOV	CX,128
	MOV	BX,[DI].fHandle
	MOV	AH,dosRead
	INT	DOS
	JNC	@@2
	XOR	AX,AX
@@2:	XOR	BX,BX
@@3:	CMP	BX,AX
	JE	@@5
	CMP	[DI].fBuffer[BX],eof
	JE	@@4
	INC	BX
	JMP	@@3
@@4:	MOV	DX,BX
	SUB	DX,AX
	MOV	CX,-1
	MOV	BX,[DI].fHandle
	MOV	AX,dosSeek*256+2
	INT	DOS
	XOR	CX,CX
	MOV	BX,[DI].fHandle
	MOV	AH,dosWrite
	INT	DOS
@@5:	RET

CODE	ENDS

	END
