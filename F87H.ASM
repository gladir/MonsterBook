
; *******************************************************
; *							*
; *     Turbo Pascal Run-time Library                   *
; *	8087 Support Routines				*
; *							*
; *     Copyright (c) 1988,92 Borland International     *
; *							*
; *******************************************************

	TITLE	F87H

	INCLUDE	SE.ASM

; Shortcut opcodes

scSin		EQU	90ECH
scCos		EQU	90EEH
scTan		EQU	90F0H
scArcTan	EQU	90F2H
scLog		EQU	90F4H
scLog2		EQU	90F6H
scLog10		EQU	90F8H
scExp		EQU	90FAH
scExp2		EQU	90FCH
scExp10		EQU	90FEH

    IF DPMIVersion
	EXTRN	__AHIncr:ABS
    ENDIF

DATA	SEGMENT	WORD PUBLIC

; Externals

	EXTRN	PrefixSeg:WORD,Test8087:BYTE,SaveInt02:DWORD

; Local workspace

CWDefault	DW	?		;Default control word
TempWord	LABEL	WORD		;Temporary word
TempLong	DD	?		;Temporary longword
EnvBuffer	LABEL	BYTE		;Environment buffer
CtrlWord	DW	?		;Saved control word
StatWord	DW	?		;Saved status word
TagWord		DW	?		;Saved tag word
Instruction	DD	?		;Saved instruction pointer
Operand		DD	?		;Saved operand pointer

DATA	ENDS

CODE	SEGMENT	BYTE PUBLIC

	ASSUME	CS:CODE,DS:DATA

; Externals

	EXTRN	HaltTurbo:NEAR,HaltError:NEAR,Terminate:NEAR

; Publics

	PUBLIC	FTrunc,FRound,FInt,FSqrt,FSin,FCos,FArcTan,FLn,FExp
	PUBLIC	FFrac,FRealExt,FExtReal,Check8087,Init8087

; Chop rounding control word

CWChop		DW	1F3FH

; Floating point infinity

FConINF		DT	07FFF8000000000000000R

; Turn off emulation for 8087 presence test

	NOEMUL

; Check if 8087 is present
; Out	AL = 8087 flag (0/1/2/3)

Check8087:

; Start out by scanning the environment for an 87=Y/N entry.

	MOV	BX,OFFSET TempWord	;Point BX to TempWord
	XOR	DI,DI			;Point ES:DI to environment
	MOV	ES,PrefixSeg
	MOV	ES,ES:pspEnvSeg
	MOV	CX,7FFFH		;Max environment length
	CLD
@@1:	MOV	AX,ES:[DI].w0		;Get first 2 chars of env string
	OR	AL,AL			;End of environment?
	JE	@@3			;Yes, @@3
	CMP	AX,'78'			;Is it '87' variable?
	JNE	@@2			;No, @@2
	MOV	AX,ES:[DI].w2		;Get next 2 chars
	CMP	AL,'='			;Is '87' followed by '='?
	JNE	@@2			;No, @@2
	AND	AH,NOT ' '		;Convert to upper case
	CMP	AH,'Y'			;Compare to 'Y'
	JMP	SHORT @@4
@@2:	XOR	AX,AX			;Find next environment string
	REPNE	SCASB
	JE	@@1

; There was no 87 variable in the environment. To check for 80x87
; presence, instruct the processor to store its control word in
; memory, and then check if it actually did it.

@@3:	XOR	AX,AX			;Clear 80287 BUSY latch
	OUT	0F0H,AL
	FNINIT				;Initialize 80x87
	MOV	[BX],AX			;Clear status word
	FNSTCW	[BX]			;Store status word
	MOV	CX,20			;Wait for a while
	LOOP	THIS NEAR
	MOV	AX,[BX]			;Pick up saved status word
	AND	AX,0F3FH		;Mask out unwanted bits
	CMP	AX,033FH		;Compare to 80x87 default

; The zero flag now indicates whether an 80x87 is present. If there
; is an 80x87, determine which. The 80387 defaults to affine infinity,
; whereas the 8087 and 80287 default to projective.

@@4:	MOV	DX,1330H		;8087/80287 control word
	MOV	AL,0			;Indicate no 80x87
	JNE	@@5
	PUSH	SP			;Check 8088/8086
	POP	AX
	CMP	AX,SP			;Not equal on 8088/8086
	MOV	AL,1			;Indicate 8087
	JNE	@@5
	FINIT				;Initialize
	FLD1				;Generate +INF
	FLDZ
	FDIV
	FLD	ST(0)			;Generate -INF
	FCHS
	FCOMPP				;Compare infinities
	FSTSW	[BX]			;Store status
	FWAIT
	MOV	AX,[BX]			;Status to flags
	SAHF
	MOV	AL,2			;Indicate 80287
	JE	@@5
	MOV	DX,1332H		;80387 control word
	MOV	AL,3			;Indicate 80387
@@5:	MOV	Test8087,AL		;Save 80x87 indicator
	MOV	CWDefault,DX		;Save default control word
	RET

; Turn emulation back on

	EMUL

; Initialize 8087 emulator
; In	SI = Emulator entry offset
;	DI = Shortcut entry offset

Init8087:

	PUSH	DS
	PUSH	CS
	POP	DS
	MOV	AX,dosSetInt*256+34H	;Emulator interrupt handlers
	MOV	CX,10
	MOV	DX,SI
@@1:	INT	DOS
	INC	AX
	LOOP	@@1
	MOV	DX,DI			;Shortcut interrupt handler
	INT	DOS
	MOV	DX,OFFSET Int02Handler	;8087 interrupt handler
	MOV	AL,02H
	INT	DOS
	MOV	DX,OFFSET Int75Handler	;80287 interrupt handler
	MOV	AL,75H
	INT	DOS
	POP	DS
    IF DPMIVersion
	MOV	AX,CS			;Get code segment alias
	ADD	AX,__AHIncr
	MOV	ES,AX
	MOV	AX,SaveInt02.ofs	;Initialize INT 2 jump vector
	MOV	ES:JumpInt02.ofs,AX
	MOV	AX,SaveInt02.seg
	MOV	ES:JumpInt02.seg,AX
    ELSE
	MOV	AX,SaveInt02.ofs	;Initialize INT 2 jump vector
	MOV	CS:JumpInt02.ofs,AX
	MOV	AX,SaveInt02.seg
	MOV	CS:JumpInt02.seg,AX
    ENDIF
	FINIT				;Initialize 8087
	FLDCW	CWDefault		;Load default control word
	RETF

; Interrupt 75H handler (AT's, 80287)

Int75Handler:

	PUSH	AX
	XOR	AL,AL			;Clear BUSY latch
	OUT	0F0H,AL
	MOV	AL,20H			;End-of-interrupt
	OUT	0A0H,AL
	OUT	20H,AL
	POP	AX

; Interrupt 02H handler (PC's, 8087)

Int02Handler:

	PUSH	AX			;Save registers
	PUSH	DS
	MOV	AX,SEG DATA		;Reset DS
	MOV	DS,AX
	CMP	Test8087,0		;8087 present?
	JNE	@@1			;Yes, @@1
	FSTENV	EnvBuffer		;Store environment
	JMP	SHORT @@2
	NOEMUL				;Can't emulate no-wait opcode
@@1:	FNSTENV	EnvBuffer		;No wait, store environment
	FWAIT				;Wait for it
	EMUL				;Turn emulation back on
@@2:	MOV	AL,CtrlWord.b0		;Unmasked exceptions to AL
	NOT	AL
	AND	AL,StatWord.b0
	JS	Exception		;IR=1 if 8087 caused interrupt
	POP	DS			;Restore registers
	POP	AX

; Jump to saved INT 2 handler

		DB	0EAH		;JMP FAR
JumpInt02	DD	?

; 8087 exception handler

Exception:

	STI				;Enable interrupts
	TEST	AL,3FH-mDE		;Anything but denormal exception
	JE	FixDenormal		;is an error
	FINIT				;Initialize 8087
	FLDCW	CWDefault
	POP	CX			;Remove saved registers
	POP	CX
	POP	CX			;Get interrupt return address
	POP	BX
	CMP	Test8087,0		;8087 present
	JE	@@1			;No, @@1
    IF DPMIVersion
	MOV	CX,Instruction.ofs	;Get instruction address
	MOV	BX,Instruction.seg
    ELSE
	MOV	DX,Instruction.ofs	;Get normalized instruction
	MOV	CL,4			;address
	SHR	DX,CL
	MOV	BX,Instruction.seg
	AND	BX,0F000H
	ADD	BX,DX
	MOV	CX,Instruction.ofs
	AND	CX,0FH
    ENDIF
@@1:	TEST	AL,mIE			;Convert exception mask to
	JNE	@@2			;run-time error number
	MOV	DX,200
	TEST	AL,mZE
	JNE	@@3
	MOV	DX,205
	TEST	AL,mOE
	JNE	@@3
	MOV	DX,206
	TEST	AL,mUE
	JNE	@@3
@@2:	MOV	DX,207
@@3:	XCHG	AX,DX			;Error code to AX
	JMP	Terminate		;Run-time error

; Denormal exceptions never occur with the emulator

	NOEMUL

; Retry subroutine

Retry:

	PUSH	DS			;Save DS
	LDS	BX,Operand		;Pick up operand
	WAIT

RetryOpcode 	DW	9090H		;Fxxx DS:[BX]

	POP	DS			;Restore DS
	RET

; Fix denormal operands

FixDenormal:

	PUSH	BX			;Save BX
    IF DPMIVersion
	PUSH	ES			;Save ES
	LES	BX,Instruction		;Get instruction address
	TEST	ES:[BX].b0,80H		;Prefix?
	JNE	@@0			;No, @@0
	INC	BX			;Skip prefix byte
@@0:	MOV	AX,ES:[BX]		;Get instruction
	XCHG	AL,AH			;Bytes reversed in FSTENV image
	MOV	BX,CS			;Construct CS alias in ES
	ADD	BX,__AHIncr
	MOV	ES,BX
    ELSE
	MOV	AX,Instruction.w2	;Pick up opcode
    ENDIF
	MOV	BL,AL			;Memory operand?
	AND	BL,0C0H
	CMP	BL,0C0H
	JE	@@1			;No, @@1
	AND	AL,38H			;Change EA to DS:[BX]
	OR	AL,7
@@1:	XCHG	AL,AH			;Swap low and high
	AND	AL,7			;Convert to ESC opcode
	OR	AL,0D8H
    IF DPMIVersion
	MOV	ES:RetryOpcode,AX	;Store opcode
    ELSE
	MOV	CS:RetryOpcode,AX	;Store opcode
    ENDIF
	CMP	AX,07D9H		;FLD DWORD
	JE	@@4
	CMP	AX,07DDH		;FLD QWORD
	JE	@@4
	CMP	AX,2FDBH		;FLD TBYTE
	JE	@@4
	CMP	AX,17D8H		;FCOM DWORD
	JE	@@5
	CMP	AX,17DCH		;FCOM QWORD
	JE	@@5
	CMP	AX,1FD8H		;FCOMP DWORD
	JE	@@5
	CMP	AX,1FDCH		;FCOMP QWORD
	JE	@@5
	CMP	AX,37D8H		;FDIV DWORD
	JE	@@2
	CMP	AX,37DCH		;FDIV QWORD
	JE	@@2
	FCLEX				;Clear exceptions
	CALL	Retry			;Retry arithmetic operation
	JMP	SHORT @@3
@@2:
    IF DPMIVersion
	SUB	ES:RetryOpcode,37D8H-07D9H ;Convert FDIV to FLD
    ELSE
	SUB	CS:RetryOpcode,37D8H-07D9H ;Convert FDIV to FLD
    ENDIF
	CALL	Retry			;Load operand
	CALL	Normalize		;Normalize operand
	FCLEX				;Clear exceptions
	FDIV				;Do divide
@@3:	FSTSW	TempWord		;Store status
	FWAIT
	MOV	AL,TempWord.b0		;Add new exceptions to saved
	OR	StatWord.b0,AL		;status word
@@4:	CALL	Normalize		;Normalize result
@@5:	FCLEX				;Must do this before FLDENV
	AND	StatWord.b0,NOT mDE	;Clear denormal exception
	FLDENV	EnvBuffer		;Reload environment
    IF DPMIVersion
	POP	ES
    ENDIF
	POP	BX			;Restore and return
	POP	DS
	POP	AX
	IRET

; Examine ST and normalize if required

Normalize:

	FXAM				;Examine
	FSTSW	TempWord		;Status word to AX
	FWAIT
	MOV	AX,TempWord
	TEST	AX,mC3+mC2+mC0		;Unnormal?
	JE	@@1			;Yes, @@1
	TEST	AX,mC3			;Normal, NAN, or INF?
	JE	@@2			;Yes, @@2
	TEST	AX,mC2			;Zero?
	JE	@@2			;Yes, @@2
	FSTP	ST(0)			;Denormal becomes zero
	FLDZ
	RET
@@1:	FLD	FConINF			;Normalize unnormal
	FXCH
	FPREM
	FSTP	ST(1)
@@2:	RET

; Turn emulation back on

	EMUL

; Convert Real to Extended

FRealExt:

	OR	AL,AL
	JE	@@1
	XOR	CL,CL
	MOV	CH,AH
	MOV	AH,DH
	AND	AH,80H
	ADD	AX,3F7EH
	OR	DH,80H
	PUSH	AX
	PUSH	DX
	PUSH	BX
	PUSH	CX
	XOR	CX,CX
	PUSH	CX
	MOV	BX,SP
	FLD	TBYTE PTR SS:[BX]
	FWAIT
	ADD	SP,10
	RETF
@@1:	FLDZ
	RETF

; Convert Extended to Real

FExtReal:

	SUB	SP,10
	MOV	BX,SP
	FSTP	TBYTE PTR SS:[BX]
	FWAIT
	ADD	SP,2
	POP	CX
	POP	BX
	POP	DX
	POP	AX
	MOV	DI,AX
	AND	AX,7FFFH
	SUB	AX,3F7EH
	JBE	@@2
	OR	AH,AH
	JNE	@@4
	MOV	AH,CH
	SHL	CL,1
	ADC	AH,0
	ADC	BX,0
	ADC	DX,0
	JC	@@3
@@1:	SHL	DX,1
	SHL	DI,1
	RCR	DX,1
	RETF
@@2:	XOR	AX,AX
	XOR	BX,BX
	XOR	DX,DX
	RETF
@@3:	INC	AL
	JNE	@@1
@@4:	MOV	AX,205
	JMP	HaltError

; Trunc function

FTrunc:

	FSTCW	CtrlWord
	FLDCW	CWChop
	FISTP	TempLong
	FWAIT				;486 needs FWAIT before FLDCW
	FLDCW	CtrlWord
	MOV	AX,TempLong.w0
	MOV	DX,TempLong.w2
	RETF

; Round function

FRound:

	FISTP	TempLong
	FWAIT
	MOV	AX,TempLong.w0
	MOV	DX,TempLong.w2
	RETF

; Int function

FInt:

	FSTCW	CtrlWord
	FLDCW	CWChop
	FRNDINT
	FWAIT				;486 needs FWAIT before FLDCW
	FLDCW	CtrlWord
	RETF

; Frac function

FFrac:

	FSTCW	CtrlWord
	FLDCW	CWChop
	FLD	ST(0)
	FRNDINT
	FSUB
	FWAIT				;486 needs FWAIT before FLDCW
	FLDCW	CtrlWord
	RETF

; Sqrt function

FSqrt:

	FSQRT
	RETF

; Sin function

FSin:

	INT	3EH
	DW	scSin
	RETF

; Cos function

FCos:

	INT	3EH
	DW	scCos
	RETF

; ArcTan function

FArcTan:

	INT	3EH
	DW	scArcTan
	RETF

; Ln function

FLn:

	INT	3EH
	DW	scLog
	RETF

; Exp function

FExp:

	INT	3EH
	DW	scExp
	RETF

CODE	ENDS

	END
