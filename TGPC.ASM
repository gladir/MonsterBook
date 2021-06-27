
; *******************************************************
; *							*
; *	Turbo Pascal Runtime Library			*
; *	Textfile Low-level I/O				*
; *							*
; *	Copyright (C) 1988,92 Borland International	*
; *							*
; *******************************************************

	TITLE	TGPC

	INCLUDE	SE.ASM

CONST	SEGMENT	WORD PUBLIC

; Newline string

NewLineStr	DB	cr,lf

CONST	ENDS

DATA	SEGMENT	WORD PUBLIC

; Externals

	EXTRN	InOutRes:WORD

DATA	ENDS

DGROUP	GROUP	CONST,DATA

CODE	SEGMENT	BYTE PUBLIC

	ASSUME	CS:CODE,DS:DGROUP

; Publics

	PUBLIC	ReadLine,ReadEnd,WriteLine,WriteEnd
	PUBLIC	ReadText,WriteBuffer,WriteBlanks,InOutProc

; Read from textfile
; In	AX    = Callback procedure pointer
;	CX    = Callback CX
;	DX:DI = Callback ES:DI
;	ES:BX = File pointer
; Out	ZF    = 1 if no error

ReadText:

	CMP	InOutRes,0
	JNE	@@2
	CMP	ES:[BX].fMode,fmInput
	JNE	@@3
	MOV	SI,ES:[BX].fBufPos
	CMP	SI,ES:[BX].fBufEnd
	JE	@@4
@@1:	PUSH	DS
	PUSH	ES
	PUSH	BX
	PUSH	DX
	LDS	DX,ES:[BX].fBufPtr
	MOV	BX,ES:[BX].fBufEnd
	POP	ES
	ADD	BX,DX
	ADD	SI,DX
	CLD
	CALL	AX
	SUB	SI,DX
	MOV	DX,ES
	POP	BX
	POP	ES
	POP	DS
	MOV	ES:[BX].fBufPos,SI
	OR	AX,AX
	JNE	@@4
@@2:	RET
@@3:	MOV	InOutRes,104
	RET
@@4:	PUSH	AX
	PUSH	CX
	PUSH	DX
	PUSH	DI
	PUSH	ES
	PUSH	BX
	CALL	InOutProc
	POP	BX
	POP	ES
	POP	DI
	POP	DX
	POP	CX
	POP	AX
	MOV	SI,ES:[BX].fBufPos
	CMP	SI,ES:[BX].fBufEnd
	JNE	@@1
	RET

; Write blanks to textfile
; In	DX    = Count
;	ES:BX = File pointer
; Out	ZF    = 1 if no error

WriteBlanks:

	CMP	InOutRes,0
	JNE	@@4
	CMP	ES:[BX].fMode,fmOutput
	JNE	@@5
@@1:	MOV	CX,ES:[BX].fBufSize
	MOV	DI,ES:[BX].fBufPos
	SUB	CX,DI
	SUB	DX,CX
	JAE	@@2
	ADD	CX,DX
	XOR	DX,DX
@@2:	PUSH	ES
	LES	SI,ES:[BX].fBufPtr
	ADD	DI,SI
	MOV	AL,' '
	CLD
	REP	STOSB
	SUB	DI,SI
	POP	ES
	MOV	ES:[BX].fBufPos,DI
	CMP	DI,ES:[BX].fBufSize
	JNE	@@3
	PUSH	DX
	PUSH	ES
	PUSH	BX
	CALL	InOutProc
	POP	BX
	POP	ES
	POP	DX
@@3:	OR	DX,DX
	JNE	@@1
@@4:	RET
@@5:	MOV	InOutRes,105
	RET

; Write buffer to textfile
; In	AX    = Count
;	DX:SI = Buffer pointer
;	ES:BX = File pointer
; Out	ZF    = 1 if no error

WriteBuffer:

	CMP	InOutRes,0
	JNE	@@4
	CMP	ES:[BX].fMode,fmOutput
	JNE	@@5
@@1:	MOV	CX,ES:[BX].fBufSize
	MOV	DI,ES:[BX].fBufPos
	SUB	CX,DI
	SUB	AX,CX
	JAE	@@2
	ADD	CX,AX
	XOR	AX,AX
@@2:	PUSH	DS
	PUSH	ES
	PUSH	BX
	MOV	DS,DX
	LES	BX,ES:[BX].fBufPtr
	ADD	DI,BX
	CLD
	REP	MOVSB
	SUB	DI,BX
	POP	BX
	POP	ES
	POP	DS
	MOV	ES:[BX].fBufPos,DI
	CMP	DI,ES:[BX].fBufSize
	JNE	@@3
	PUSH	AX
	PUSH	DX
	PUSH	SI
	PUSH	ES
	PUSH	BX
	CALL	InOutProc
	POP	BX
	POP	ES
	POP	SI
	POP	DX
	POP	AX
@@3:	OR	AX,AX
	JNE	@@1
@@4:	RET
@@5:	MOV	InOutRes,105
	RET

; ReadLn standard procedure

ReadLine:

	ARG	FileP,DWORD,1

	ENTRY	WINFAR
	LES	BX,FileP
	MOV	AX,OFFSET CS:@@10
	XOR	DX,DX
	CALL	ReadText
	JNE	@@1
	CMP	ES:[BX].fFlushProc.seg,0
	JE	@@1
	CALL	FlushProc
@@1:	EXIT
@@10:	LODSB
	CMP	AL,cr
	JE	@@11
	CMP	AL,eof
	JE	@@13
	CMP	SI,BX
	JNE	@@10
	MOV	AX,OFFSET CS:@@10
	RET
@@11:	CMP	SI,BX
	JE	@@15
@@12:	LODSB
	CMP	AL,lf
	JE	@@14
@@13:	DEC	SI
@@14:	XOR	AX,AX
	RET
@@15:	MOV	AX,OFFSET CS:@@12
	RET

; WriteLn standard procedure

WriteLine:

	ARG	FileP,DWORD,1

	ENTRY	WINFAR
	LES	BX,FileP
	MOV	AX,2
	MOV	SI,OFFSET DS:NewLineStr
	MOV	DX,DS
	CALL	WriteBuffer
	JNE	@@1
	CMP	ES:[BX].fFlushProc.seg,0
	JE	@@1
	CALL	FlushProc
@@1:	EXIT

; End of Read or Write

ReadEnd:
WriteEnd:

	ARG	FileP,DWORD,1

	ENTRY	WINFAR
	LES	BX,FileP
	CMP	ES:[BX].fFlushProc.seg,0
	JE	@@1
	CMP	InOutRes,0
	JNE	@@1
	CALL	FlushProc
@@1:	EXIT

; Call textfile InOutProc
; In	ES:BX = File pointer

InOutProc:

	PUSH	ES
	PUSH	BX
	CALL	ES:[BX].fInOutProc
	OR	AX,AX
	JE	@@1
	MOV	InOutRes,AX
@@1:	RET

; Call textfile FlushProc
; In	ES:BX = File pointer

FlushProc:

	PUSH	ES
	PUSH	BX
	CALL	ES:[BX].fFlushProc
	OR	AX,AX
	JE	@@1
	MOV	InOutRes,AX
@@1:	RET

CODE	ENDS

	END
