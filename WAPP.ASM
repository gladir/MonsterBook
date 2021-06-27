
; *******************************************************
; *							*
; *     Turbo Pascal Run-time Library                   *
; *	Windows Application Main Module			*
; *							*
; *     Copyright (c) 1988,92 Borland International     *
; *							*
; *******************************************************

	TITLE	WAPP

	INCLUDE	SE.ASM

DATA	SEGMENT WORD PUBLIC

; Externals

	EXTRN	PrefixSeg:WORD,HPrevInst:WORD,HInstance:WORD
	EXTRN	CmdLine:DWORD,CmdShow:WORD,Input:BYTE,Output:BYTE
	EXTRN	SelectorInc:WORD,Test8086:BYTE

DATA	ENDS

; Windows entry points

	EXTRN	WaitEvent:FAR,InitApp:FAR,GetWinFlags:FAR
	EXTRN	__AHIncr:ABS

CODE	SEGMENT	BYTE PUBLIC

	ASSUME	CS:CODE,DS:DATA

; Externals

	EXTRN	DoExitProcs:NEAR

; Publics

	PUBLIC	InitTurbo

; Application entry code. Every application starts with a call
; to InitTask followed by a call to this routine.

InitTurbo:

	ENTRY	WINFAR
	OR	AX,AX			;Zero if InitTask failed
	JE	@@2
	MOV	PrefixSeg,ES		;Save InitTask return values
	MOV	HPrevInst,SI
	MOV	HInstance,DI
	MOV	CmdShow,DX
	MOV	CmdLine.ofs,BX
	MOV	CmdLine.seg,ES
	XOR	AX,AX			;Clear event that started task
	PUSH	AX
	CALL	WaitEvent
	PUSH	HInstance		;Initialize application
	CALL	InitApp
	OR	AX,AX			;Zero if InitApp failed
	JE	@@2
	CALL	GetWinFlags		;Determine CPU type
	XOR	DX,DX
	TEST	AL,0C0H			;wf_CPU086 + wf_CPU186
	JNE	@@1
	INC	DX
	TEST	AL,02H			;wf_CPU286
	JNE	@@1
	INC	DX
@@1:	MOV	Test8086,DL
	MOV	SelectorInc,__AHIncr
	EXIT
@@2:	MOV	AX,dosExit*256+0FFH
	INT	DOS

CODE	ENDS

	END
