.8086

Code Segment Public
Assume CS:Code

extrn CPU

Public CITest,ChkCPUMhz,GetPChrMhz,GetPChrWaitStates,GetPChrGeneral

cpu8088  equ 0
cpu8086  equ 1
cpu80188 equ 2
cpu80186 equ 3
cpu80286 equ 4
cpu80386 equ 5

ClockBalance    DW 0EDBh
                DW 0EDBh
                DW 0EDBh
                DW 0EDBh
                DW 0800h
                DW 0800h
                DW 0944h
                DW 0958h
                DW 0958h
                DW 0958h
                DW 0958h
                DW 0958h
                DW 0958h
                DW 0958h
ClockBalanceEnd DW 4000h
                DW 4000h
                DW 4000h
                DW 4000h
                DW 8000h
                DW 8000h
                DW 0000h
                DW 0000h
                DW 0000h
                DW 0000h
                DW 0000h
                DW 0000h
                DW 0000h
                DW 0000h
ClockBalanceSub DW 1BDAh
                DB 0DAh, 1Bh
                DW 1BDAh
                DB 0DAh, 1Bh
                DB 1Fh, 0Dh
                DB 1Fh, 0Dh
                DB 8Eh, 6
                DB 8Eh, 6
                DB 8Eh, 6
                DB 8Eh, 6
                DB 8Eh, 6
                DB 8Eh, 6
                DB 8Eh, 6
                DB 8Eh, 6
;data_7          DW 0
data_8          DW 0
data_9          DW 0
data_10         DW 0
data_11         DW 0
data_12         DW 0
data_13         DW 0
data_14         DW 0
StrNmMhz        DB 8 DUP (0)
StrWaitState    DB 12 DUP (0)
FactorRelative  DB 10 DUP (0)
data_32         DW 64h
data_33         DW 0
                DB 11 DUP (0)

CITest Proc Pascal Far
 CALL Far Ptr ChkCPUMhz
 CALL sub_5
 MOV SI,Offset StrWaitState
 CALL ComputeString
 MOV Byte Ptr CS:[SI],0
 CALL GeneralRelativeFactor
 RET
CITest endp

ChkCPUMhz Proc Pascal Far
 CLD
 CALL StartTime
 MOV BL,Byte Ptr DS:CPU
 XOR BH,BH
 SHL BX,1
 MOV CX,Word Ptr CS:ClockBalanceEnd[BX]
 XOR DX,DX
 MOV AX,DX
 MOV BX,0FFFFh
 STI
@4:
 DIV BX ; ax,dx rem=dx:ax/reg
 DIV BX ; ax,dx rem=dx:ax/reg
 DIV BX ; ax,dx rem=dx:ax/reg
 DIV BX ; ax,dx rem=dx:ax/reg
 DIV BX ; ax,dx rem=dx:ax/reg
 DIV BX ; ax,dx rem=dx:ax/reg
 DIV BX ; ax,dx rem=dx:ax/reg
 DIV BX ; ax,dx rem=dx:ax/reg
 DIV BX ; ax,dx rem=dx:ax/reg
 DIV BX ; ax,dx rem=dx:ax/reg
 DIV BX ; ax,dx rem=dx:ax/reg
 DIV BX ; ax,dx rem=dx:ax/reg
 DIV BX ; ax,dx rem=dx:ax/reg
 DIV BX ; ax,dx rem=dx:ax/reg
 DIV BX ; ax,dx rem=dx:ax/reg
 DIV BX ; ax,dx rem=dx:ax/reg
 LOOP @4 ; LOOP si CX>0
 CLI
 CALL EndTime
; STI
 MOV AX,Word Ptr CS:data_14
 MOV Word Ptr CS:data_11,AX
 MOV BL,DS:Byte Ptr CPU
 XOR BH,BH
 SHL BX,1
 MOV AX,Word Ptr CS:ClockBalance[BX]
 MOV Word Ptr CS:data_8,AX
 MOV Word Ptr CS:data_12,AX
 MOV SI,Offset StrNmMhz
 JMP @8
sub_5:
; CLI
 CALL StartTime
 PUSH DS
  XOR AX,AX
  MOV DS,AX
  MOV ES,AX
  MOV DX,40h
  STI
@6:
  MOV CX,0FFFFh
  XOR SI,SI
  MOV DI,SI
  REPNE MOVSB ; R‚pŠte zf=0+cx>0 d‚place DS:[SI] dans ES:[DI]
  DEC DX
  JNZ @6
  CLI
 POP DS
 CALL EndTime
; STI
 MOV AX,Word Ptr CS:data_14
 MUL Word Ptr CS:data_12
 DIV Word Ptr CS:data_11
 MOV BL,DS:Byte Ptr CPU
 XOR BH,BH
 SHL BX,1
 SUB AX,Word Ptr CS:ClockBalanceSub[BX]
 JBE @5
 XOR DX,DX
 MOV BX,347h
 DIV BX ; ax,dx rem=dx:ax/reg
 RET
@5:
 XOR AL,AL
 RET
endp

GeneralRelativeFactor Proc Near
; CLI
 CALL StartTime
 PUSH CS
 POP ES
 ;MOV SI,CS:data_33
 MOV SI,Offset data_33
 MOV DI,SI
 XOR CX,CX
; STI
@7:
 MOV AX,ES:[SI]
 OR  ES:[DI],AX
 DEC DX
 INC DX
 MOV AX,ES:[SI]
 OR  ES:[DI],AX
 DEC DX
 INC DX
 MOV AX,ES:[SI]
 OR  ES:[DI],AX
 DEC DX
 INC DX
 MOV AX,ES:[SI]
 OR  ES:[DI],AX
 DEC DX
 INC DX
 MOV AX,ES:[SI]
 OR  ES:[DI],AX
 DEC DX
 INC DX
 MOV AX,ES:[SI]
 OR ES:[DI],AX
 DEC DX
 INC DX
 LOOP @7 ; LOOP si cx > 0
; CLI
 CALL EndTime
; STI
 MOV Word Ptr CS:data_8,228h
 MOV SI,Offset FactorRelative
@8:
 MOV AX,Word Ptr CS:data_8
 XOR DX,DX
 DIV Word Ptr CS:data_14
 MOV Word Ptr CS:data_9,AX
 MOV AX,DX
 MUL Word Ptr CS:data_32
 DIV Word Ptr CS:data_14
 AAM
 CMP AL,5
 JB @9
 INC AH
 CMP AH,0Ah
 JB @9
 XOR AH,AH
 ADD Word Ptr CS:data_9,1
@9:
 MOV AL,AH
 XOR AH,AH
 MOV Word Ptr CS:data_10,AX
 MOV AX,Word Ptr CS:data_9
 CALL ComputeString
 MOV Byte Ptr CS:[SI],','
 INC SI
 MOV AX,Word Ptr CS:data_10
 CALL ComputeString
 MOV Byte Ptr CS:[SI],0
 RET
endp

ComputeString Proc Near
 MOV BX,64h
 XOR DX,DX
 DIV BX
 XCHG AX,DX
 AAM
 MOV CX,AX
 MOV AX,DX
 XOR DX,DX
 DIV BX
 XCHG AX,DX
 AAM
 MOV BX,AX
 OR  DL,DL
 JNZ @11
 OR  BH,BH
 JNZ @12
 OR  BL,BL
 JNZ @13
 OR  CH,CH
 JNZ @14
@10:
 ADD CL,30h ; '0'
 MOV CS:[SI],CL
 INC SI
 RET
@11:
 ADD DL,30h ; '0'
 MOV CS:[SI],DL
 INC SI
@12:
 ADD BH,30h ; '0'
 MOV CS:[SI],BH
 INC SI
@13:
 ADD BL,30h ; '0'
 MOV CS:[SI],BL
 INC SI
@14:
 ADD CH,30h ; '0'
 MOV CS:[SI],CH
 INC SI
 JMP Short @10
ComputeString endp

GetMillisecondsTimer Proc Near
 XOR AX,AX
 MOV ES,AX
 CLI
 MOV AX,ES:[46Ch]
 STI
 MOV BX,88
 MUL BX
 MOV CL,4
 SHR AX,4
 MOV CL,12
 SHL DX,CL
 OR  AX,DX
 RET
GetMillisecondsTimer endp

tmptime DW 0

StartTime Proc Near
 CALL GetMillisecondsTimer
 MOV tmptime,AX
waitnoset:
 CALL GetMillisecondsTimer
 CMP AX,tmptime
 JE  waitnoset
 MOV CS:data_13,AX
 RET
StartTime endp

EndTime Proc Near
 CALL GetMillisecondsTimer
 CMP AX,CS:data_13
 JAE @15
 ADD AX,1770h
@15:
 SUB AX,CS:data_13
 MOV Word Ptr CS:data_14,AX
 RET
EndTime endp

GetPChrMhz Proc Far
 MOV DX,CS
 MOV AX,Offset StrNmMhz
 RET
GetPChrMhz endp

GetPChrWaitStates Proc Far
 MOV DX,CS
 MOV AX,Offset StrWaitState
 RET
GetPChrWaitStates endp

GetPChrGeneral Proc Far
 MOV DX,CS
 MOV AX,Offset FactorRelative
 RET
GetPChrGeneral endp

code ends
end