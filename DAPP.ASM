
; *******************************************************
; *							*
; *     Turbo Pascal Run-time Library                   *
; *	DPMI Application Main module			*
; *							*
; *     Copyright (c) 1988,92 Borland International     *
; *							*
; *******************************************************

	TITLE	DAPP

	INCLUDE	SE.ASM

DATA	SEGMENT WORD PUBLIC

; Externals

	EXTRN	Input:BYTE,Output:BYTE,SaveInt00:DWORD
	EXTRN	SelectorInc:WORD,Seg0040:WORD,SegA000:WORD
	EXTRN	SegB000:WORD,SegB800:WORD,RealModeRegs:BYTE
	EXTRN	ExitProc:DWORD,PrefixSeg:WORD,HInstance:WORD
	EXTRN	ExitCode:WORD,ErrorAddr:DWORD,Test8086:BYTE
	EXTRN	SaveInt21:DWORD

DATA	ENDS

; Run-time manager externals

	EXTRN	__AHIncr:ABS,__0040H:ABS,__A000H:ABS
	EXTRN	__B000H:ABS,__B800H:ABS

CODE	SEGMENT	BYTE PUBLIC

	ASSUME	CS:CODE,DS:DATA

; Externals

	EXTRN	AssignText:NEAR,ResetText:NEAR,RewriteText:NEAR
	EXTRN	CloseText:NEAR,HaltTurbo:NEAR,Terminate:NEAR

; Publics

	PUBLIC	InitTurbo

; CS-based variables for Ctrl-Break handling

Int21Vector	DD	0		;Saved INT 21H vector
CtrlBreakFlag	DB	0		;Ctrl-Break flag

; Initialize runtime library. First instruction in any program
; is a call to this routine.

InitTurbo:

	MOV	DX,SEG DATA		;Initialize DS
	MOV	DS,DX
	XOR	BP,BP			;End of stack frame chain
	MOV	PrefixSeg,ES		;Save InitTask return values
	MOV	HInstance,DI
	MOV	AX,SP
	ADD	AX,4
	MOV	SS:pStackTop,10H	;Set stack top
	MOV	SS:pStackBot,AX		;Set stack bottom
	MOV	SS:pStackMin,AX		;Set stack low water mark
	MOV	AX,dpmiGetVersion	;Determine CPU type
	INT	DPMI
	DEC	CL
	MOV	Test8086,CL
	MOV	SelectorInc,__AHIncr	;Set selector increment
	MOV	Seg0040,__0040H		;Set predefined selectors
	MOV	SegA000,__A000H
	MOV	SegB000,__B000H
	MOV	SegB800,__B800H
	MOV	DI,OFFSET SaveInt00	;Capture interrupt vectors
	MOV	SI,OFFSET SaveIntTab
	MOV	CX,SaveIntCnt
	CLD
@@1:	PUSH	CX
	SEGCS	LODSW
	MOV	BL,AH			;Interrupt/exception number
	MOV	AH,2			;AX = 0200H, 0202H, 0204H
	INT	DPMI
	MOV	[DI].ofs,DX
	MOV	[DI].seg,CX
	ADD	DI,4
	POP	CX
	LOOP	@@1
	MOV	AX,CS			;Get code segment alias
	ADD	AX,__AHIncr
	MOV	ES,AX
	MOV	AX,SaveInt21.ofs	;Copy saved INT 21H vector to CS
	MOV	ES:Int21Vector.ofs,AX
	MOV	AX,SaveInt21.seg
	MOV	ES:Int21Vector.seg,AX
	MOV	AX,dpmiSetExcept	;Install DIV 0 handler
	MOV	BL,00H
	MOV	DX,OFFSET Int00Handler
	MOV	CX,CS
	INT	DPMI
	MOV	AX,0FB43H		;If TDX is present, rely on it to
	MOV	BX,100H			;handle stack and GP faults
	INT	2FH
	CMP	BX,0FB43H		;TDX present?
	JE	@@2			;Yes, @@2
	MOV	AX,dpmiSetExcept	;Install stack fault handler
	MOV	BL,0CH
	MOV	DX,OFFSET Int0CHandler
	MOV	CX,CS
	INT	DPMI
	MOV	AX,dpmiSetExcept	;Install GP fault handler
	MOV	BL,0DH
	MOV	DX,OFFSET Int0DHandler
	MOV	CX,CS
	INT	DPMI
@@2:	MOV	AX,dpmiSetInt		;Install INT 21H handler
	MOV	BL,21H
	MOV	DX,OFFSET Int21Handler
	MOV	CX,CS
	INT	DPMI
	MOV	BL,23H			;Install Ctrl-Break handler
	MOV	SI,OFFSET Int23Handler
	CALL	SetRealInt
	MOV	BL,24H			;Install critical error handler
	MOV	SI,OFFSET Int24Handler
	CALL	SetRealInt
	MOV	AX,OFFSET Input		;Assign/Reset Input file
	PUSH	DS
	PUSH	AX
	PUSH	DS
	PUSH	AX
	MOV	AX,OFFSET ZeroString
	PUSH	CS
	PUSH	AX
	PUSH	CS
	CALL	AssignText
	PUSH	CS
	CALL	ResetText
	MOV	AX,OFFSET Output	;Assign/Rewrite Output file
	PUSH	DS
	PUSH	AX
	PUSH	DS
	PUSH	AX
	MOV	AX,OFFSET ZeroString
	PUSH	CS
	PUSH	AX
	PUSH	CS
	CALL	AssignText
	PUSH	CS
	CALL	RewriteText
	MOV	ExitProc.ofs,OFFSET ExitTurbo ;Install exit procedure
	MOV	ExitProc.seg,CS
	RETF				;Back to main program

; Set real mode interrupt
; In	BL = Interrupt number
;	SI = Handler offset

SetRealInt:

	MOV	AX,dpmiGetRMCB		;Create real mode call-back
	MOV	DI,OFFSET RealModeRegs
	PUSH	DS
	POP	ES
	PUSH	CS
	POP	DS
	INT	DPMI
	PUSH	ES
	POP	DS
	MOV	AX,dpmiSetRealInt	;Set real mode interrupt
	INT	DPMI
	RET

; Runtime library exit procedure. This is the last exit procedure to
; get executed when an application terminates.

ExitTurbo:

	MOV	AX,OFFSET Input		;Close Input file
	PUSH	DS
	PUSH	AX
	PUSH	CS
	CALL	CloseText
	MOV	AX,OFFSET Output	;Close Output file
	PUSH	DS
	PUSH	AX
	PUSH	CS
	CALL	CloseText
	MOV	DI,OFFSET SaveInt00	;Restore interrupt vectors
	MOV	SI,OFFSET SaveIntTab
	MOV	CX,SaveIntCnt
	CLD
@@1:	PUSH	CX
	SEGCS	LODSW
	MOV	BL,AH
	MOV	AH,2
	INC	AX			;AX = 0201H, 0203H, 0205H
	MOV	DX,[DI].ofs
	MOV	CX,[DI].seg
	INT	DPMI
	ADD	DI,4
	POP	CX
	LOOP	@@1
	RETF

; Divide by zero exception handler

Int00Handler:

	PUSH	AX
	MOV	AX,200
	JMP	SHORT Exception

; Stack fault exception handler

Int0CHandler:

	PUSH	AX
	MOV	AX,202
	JMP	SHORT Exception

; General protection fault handler

Int0DHandler:

	PUSH	AX
	MOV	AX,216

; Common exception handler. Saves off the error code and error address
; and modifies the exception handler stack frame to return to the
; ExceptHalt routine. 

Exception:

	PUSH	DS
	PUSH	BP
	MOV	BP,SEG DATA
	MOV	DS,BP
	MOV	BP,SP
	MOV	ExitCode,AX
	MOV	AX,[BP+12].ofs
	MOV	ErrorAddr.ofs,AX
	MOV	AX,[BP+12].seg
	MOV	ErrorAddr.seg,AX
	MOV	[BP+12].ofs,OFFSET ExceptHalt
	MOV	[BP+12].seg,CS
	CMP	[BP+18].ofs,1024
	JAE	@@1
	MOV	[BP+18].ofs,1024
@@1:	POP	BP
	POP	DS
	POP	AX
	RETF

; Here on return from exception handler. Restores the error code and
; error address and terminates the application.

ExceptHalt:

	MOV	AX,SEG DATA
	MOV	DS,AX
	MOV	AX,ExitCode
	MOV	CX,ErrorAddr.ofs
	MOV	BX,ErrorAddr.seg
	JMP	Terminate

; INT 21H handler. DPMI does not allow a Ctrl-Break handler to terminate
; an application, so the Ctrl-Break handler sets a flag which is then
; checked in this INT 21H hook.

Int21Handler:

	STI				;Re-enable interrupts
	PUSHF				;Chain to original INT 21H handler
	CALL	Int21Vector
	PUSHF				;Save flags
	CMP	CtrlBreakFlag,0		;Ctrl-Break detected?
	JNE	@@1			;Yes, @@1
	POPF				;Restore flags
	RETF	2			;Return
@@1:	MOV	AX,CS			;Get code segment alias
	ADD	AX,__AHIncr
	MOV	DS,AX
	MOV	DS:CtrlBreakFlag,0	;Clear Ctrl-Break flag
	MOV	AX,255			;Terminate application
	JMP	HaltTurbo

; Ctrl-Break interrupt handler. Control arrives here through a real mode
; call-back when DOS detects a Ctrl-C or Ctrl-Break. Since a Ctrl-Break
; handler is not allowed to terminate an application under DPMI, the
; handler sets a flag which is then checked by the INT 21H hook.

Int23Handler:

	CALL	RealModeIRET		;Simulate real mode IRET
	MOV	AX,CS			;Get code segment alias
	ADD	AX,__AHIncr
	MOV	DS,AX
	MOV	DS:CtrlBreakFlag,1	;Set Ctrl-Break flag
	IRET				;Return from call-back
	
; Critical error interrupt handler. Control arrives here when DOS
; encounters a critical error. The handler converts the critical error
; code to a Turbo Pascal I/O error code.

Int24Handler:

	MOV	AH,54H			;Dummy function call to get DOS
	INT	21H			;into a stable state
	ADD	SI,6			;Discard IRET from real mode stack
	CLD
	LODSW				;Pop AX from real mode stack
	MOV	DX,ES:[DI].realDI.w0	;Get critical error code
	AND	DX,1FH			;Return AX=150..181
	ADD	DX,150
	CMP	AH,39H			;DOS 2.0 style function?
	JAE	@@1			;Yes, @@1
	MOV	DX,0FFFFH		;Return AX=0FFFFH
@@1:	MOV	ES:[DI].realAX.w0,DX	;Save return AX
	LODSW				;Restore other registers
	MOV	ES:[DI].realBX.w0,AX
	LODSW
	MOV	ES:[DI].realCX.w0,AX
	LODSW
	MOV	ES:[DI].realDX.w0,AX
	LODSW
	MOV	ES:[DI].realSI.w0,AX
	LODSW
	MOV	ES:[DI].realDI.w0,AX
	LODSW
	MOV	ES:[DI].realBP.w0,AX
	LODSW
	MOV	ES:[DI].realDS,AX
	LODSW
	MOV	ES:[DI].realES,AX
	ADD	ES:[DI].realSP,24	;Adjust real mode SP
	CALL	RealModeIRET		;Simulate real mode IRET
	OR	ES:[DI].realFlags,1	;Set CF in return flags
	IRET				;Return from call-back

; Simulate an IRET in a real mode call-back

RealModeIRET:

	CLD
	LODSW
	MOV	ES:[DI].realIP,AX
	LODSW
	MOV	ES:[DI].realCS,AX
	LODSW
	MOV	ES:[DI].realFlags,AX
	ADD	ES:[DI].realSP,6
	RET

; Saved interrupt and exception numbers. The first byte of each entry
; is the low byte of the 02xxH DPMI function code to use when modifying
; the vector. 0 means real mode interrupt, 2 means protected mode
; exception, and 4 means protected mode interrupt.

SaveIntTab	LABEL	BYTE

	DB	2,00H
	DB	4,02H
	DB	2,0CH
	DB	2,0DH
	DB	4,1BH
	DB	4,21H
	DB	0,23H
	DB	0,24H
	DB	4,34H
	DB	4,35H
	DB	4,36H
	DB	4,37H
	DB	4,38H
	DB	4,39H
	DB	4,3AH
	DB	4,3BH
	DB	4,3CH
	DB	4,3DH
	DB	4,3EH
	DB	4,3FH
	DB	4,75H

SaveIntCnt	EQU	($-SaveIntTab)/2

; Empty string

ZeroString	DB	0

CODE	ENDS

	END
