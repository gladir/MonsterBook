
; *******************************************************
; *							*
; *	Turbo Pascal Runtime Library Version 5.5	*
; *	Software Interrupt Routines			*
; *							*
; *	Copyright (C) 1988,89 Borland International	*
; *							*
; *******************************************************

	TITLE	INTR

    IFDEF _DPMI_
	.286P
    ENDIF

DATA	SEGMENT	WORD PUBLIC

	EXTRN	SelectorInc:WORD

DATA	ENDS

CODE	SEGMENT	BYTE PUBLIC

	ASSUME	CS:CODE,DS:DATA

	PUBLIC	MsDos

MsDos		PROC	FAR

	POP	SI
	POP	DX
	POP	CX
	POP	BX
	MOV	AL,21H
	PUSH	AX
	PUSH	BX
	PUSH	CX
	PUSH	DX
	PUSH	SI

MsDos		ENDP

	PUBLIC	Intr

Intr		PROC	FAR

        PUSH    BP
        PUSH    DS
        MOV     BP,SP
    IFDEF _DPMI_
	MOV	AX,CS
	ADD	AX,SelectorInc
	MOV	DS,AX
	PUSH	WORD PTR DS:Interrupt
	PUSH	DS
	MOV	AL,[BP+12]
	MOV	BYTE PTR DS:Interrupt[1],AL
    ELSE
	PUSH	WORD PTR CS:Interrupt
	MOV	AL,[BP+12]
	MOV	BYTE PTR CS:Interrupt[1],AL
    ENDIF
	LDS	SI,[BP+8]
	CLD
	LODSW
	PUSH	AX
	LODSW
	MOV	BX,AX
	LODSW
	MOV	CX,AX
	LODSW
	MOV	DX,AX
	LODSW
	MOV	BP,AX
	LODSW
	PUSH	AX
	LODSW
	MOV	DI,AX
	LODSW
	PUSH	AX
	LODSW
    IFDEF _DPMI_
        VERR    AX
	JNZ	@@1
	MOV	ES,AX
@@1:	POP	AX
	VERR	AX
	JNZ	@@2
	MOV	DS,AX
@@2:
    ELSE
	MOV	ES,AX
	POP	DS
    ENDIF
	POP	SI
	POP	AX

Interrupt:	INT	0

	PUSHF
	PUSH	ES
	PUSH	DI
	PUSH	BP
	MOV	BP,SP
    IFDEF _DPMI_
	LES	DI,[BP+20]
    ELSE
	LES	DI,[BP+18]
    ENDIF
	CLD
	STOSW
	MOV	AX,BX
	STOSW
	MOV	AX,CX
	STOSW
	MOV	AX,DX
	STOSW
	POP	AX
	STOSW
	MOV	AX,SI
	STOSW
	POP	AX
	STOSW
	MOV	AX,DS
	STOSW
	POP	AX
	STOSW
	POP	AX
	STOSW
    IFDEF _DPMI_
	POP	DS
	POP	WORD PTR DS:Interrupt
    ELSE
	POP	WORD PTR CS:Interrupt
    ENDIF
	POP	DS
	POP	BP
	RET	6

Intr		ENDP

CODE	ENDS

	END
