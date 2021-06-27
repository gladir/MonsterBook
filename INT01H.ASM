.8086

Code Segment Public
Assume CS:Code

Extrn DebAX,DebBX,DebCX,DebDX,DebSI,DebDI,DebDS,DebES,DebBP,DebSS,DebSP,DebFlags
Extrn DebugSkip,PrgInstr,EndPoint

Public Int01h

Addr DD DebugSkip

Int01h Proc
 PUSH SP
 PUSH AX
 PUSH BX
 PUSH CX
 PUSH DX
 PUSH SI
 PUSH DI
 PUSH DS
 PUSH ES
 PUSH BP
 MOV BP,SP
 MOV DS,Word Ptr Addr[2]
 XOR Byte Ptr DS:DebugSkip,1
 JZ  @2
 MOV AX,[BP+16h]
 MOV DS:Word Ptr PrgInstr[2],AX
 MOV AX,[BP+14h]
 MOV DS:Word Ptr PrgInstr,AX
 MOV AX,[BP+18h]
 MOV DS:DebFlags,AX
 MOV AX,[BP+12h]
 MOV DS:DebSP,AX
 MOV AX,[BP+10h]
 MOV DS:DebAX,AX
 MOV AX,[BP+0Eh]
 MOV DS:DebBX,AX
 MOV AX,[bp+0Ch]
 MOV DS:DebCX,AX
 MOV AX,[BP+0Ah]
 MOV DS:DebDX,AX
 MOV AX,[BP+8]
 MOV DS:DebSI,AX
 MOV AX,[BP+6]
 MOV DS:DebDI,AX
 MOV AX,[BP+4]
 MOV DS:DebDS,AX
 MOV AX,[BP+2]
 MOV DS:DebES,AX
 MOV AX,[BP]
 MOV DS:DebBP,AX
 MOV AX,SS
 MOV DS:DebSS,AX
 MOV AX,[BP+18h]
 AND AX,0FEFFh
 MOV [BP+18h],AX
 MOV AX,CS
 MOV [BP+16h],AX
 MOV AX,Offset EndPoint
 ADD AX,3
 MOV [BP+14h],AX
@2:
 POP BP
 POP ES
 POP DS
 POP DI
 POP SI
 POP DX
 POP CX
 POP BX
 POP AX
 POP SP
 IRET
endp

;;Description
;;ÍÍÍÍÍÍÍÍÍÍÍ
;;
;; Cette interruption peut ˆtre utilis‚  en cas d'urgence si la pile ne
;;fournit pas assez de place pour … peine 26 octets en m‚moire. Elle en
;;utilise seulement 6 octets.
;
;_SP DW 0
;_AX DW 0
;_BX DW 0
;_CX DW 0
;_DX DW 0
;_SI DW 0
;_DI DW 0
;_DS DW 0
;_ES DW 0
;_BP DW 0
; SubStack equ 20 ; 14h
;Int01h Proc
; MOV CS:Word Ptr _SP,SP
; MOV CS:Word Ptr _AX,AX
; MOV CS:Word Ptr _BX,BX
; MOV CS:Word Ptr _CX,CX
; MOV CS:Word Ptr _DX,DX
; MOV CS:Word Ptr _SI,SI
; MOV CS:Word Ptr _DI,DI
; MOV CS:Word Ptr _DS,DS
; MOV CS:Word Ptr _ES,ES
; MOV CS:Word Ptr _BP,BP
; MOV BP,SP
; MOV DS,Word Ptr Addr[2]
; XOR Byte Ptr DS:DebugSkip,1
; JZ  @2
; MOV AX,[BP+(16h-SubStack)]
; MOV DS:Word Ptr PrgInstr[2],AX
; MOV AX,[BP+(14h-SubStack)]
; MOV DS:Word Ptr PrgInstr,AX
; MOV AX,[BP+(18h-SubStack)]
; MOV DS:DebFlags,AX
; MOV AX,CS:_SP
; MOV DS:DebSP,AX
; MOV AX,CS:_AX
; MOV DS:DebAX,AX
; MOV AX,CS:_BX
; MOV DS:DebBX,AX
; MOV AX,CS:_CX
; MOV DS:DebCX,AX
; MOV AX,CS:_DX
; MOV DS:DebDX,AX
; MOV AX,CS:_SI
; MOV DS:DebSI,AX
; MOV AX,CS:_DI
; MOV DS:DebDI,AX
; MOV AX,CS:_DS
; MOV DS:DebDS,AX
; MOV AX,CS:_ES
; MOV DS:DebES,AX
; MOV AX,CS:_BP
; MOV DS:DebBP,AX
; MOV AX,SS
; MOV DS:DebSS,AX
; MOV AX,[BP+(18h-SubStack)]
; AND AX,0FEFFh
; MOV [BP+(18h-SubStack)],AX
; MOV AX,CS
; MOV [BP+(16h-SubStack)],AX
; MOV AX,Offset EndPoint
; ADD AX,3
; MOV [BP+(14h-SubStack)],AX
;@2:
; MOV BP,CS Word Ptr _BP
; MOV ES,CS Word Ptr _ES
; MOV DS,CS Word Ptr _DS
; MOV DI,CS Word Ptr _DI
; MOV SI,CS Word Ptr _SI
; MOV DX,CS Word Ptr _DX
; MOV CX,CS Word Ptr _CX
; MOV BX,CS Word Ptr _BX
; MOV AX,CS Word Ptr _AX
; MOV SP,CS Word Ptr _SP
; IRET
;endp

code ends
end