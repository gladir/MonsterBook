.MODEL TPASCAL
.286

include ..\SYSTEX.INC

.Code
extrn SetBnkPg
extrn DataVideo
extrn RawTxtY
extrn RawY
;public Copy8Bin
public PutFillBox
public SetCube
public SetGCube

;cbPg DW ?

;Copy8Bin Proc Pascal Far X,Y,Value,Back,Fore:Word
; CLD
; MOV BX,Word Ptr Y
; SHL BX,2
; MOV ES,DataVideo.MIV.AddrPg
; LES DI,ES:[BX]
; MOV DX,ES
; ADD DI,Word Ptr X
; ADC DX,0
; MOV cbPg,DX
; PUSH DX
; PUSH CS
; CALL SetBnkPg.Near
; MOV ES,DataVideo.MIV.SegV
; MOV BH,Byte Ptr Value
; MOV AX,DI
; ADD AX,7
; JC  @@Long
; CMP BH,0
; JE  @@1
; MOV AL,Byte Ptr Fore
; CMP BH,0FFh
; JNE @@2
; JMP @@1x
;@@1:
; MOV AL,Byte Ptr Back
;@@1x:
; MOV AH,AL
; STOSW
; STOSW
; STOSW
; STOSW
; JMP @@End
;@@2:
; MOV DL,Byte Ptr Back
; MOV DH,AL
; MOV CX,8
;@@3:
; ROL BH,1
; JC  @@4
; MOV AL,DL
; STOSB
; LOOP @@3
; JMP @@End
;@@4:
; MOV AL,DH
; STOSB
; LOOP @@3
; JMP @@End
;@@Long:
; MOV AH,AL
; MOV DL,Byte Ptr Back
; MOV DH,Byte Ptr Fore
; MOV CX,8
;@@Long3:
; TEST DI,0FFFFh
; JNZ @@Long3A
; PUSH DI
;  PUSH ES
;   PUSH CX
;    PUSH DX
;     MOV AX,cbPg
;     INC AL
;     PUSH AX
;     PUSH CS
;     CALL SetBnkPg.Near
;    POP DX
;   POP CX
;  POP ES
; POP DI
;@@Long3A:
; MOV BL,BH
; ROR BL,CL
; JC  @@Long4
; MOV AL,DL
; STOSB
; LOOP @@Long3
; JMP @@End
;@@Long4:
; MOV AL,DH
; STOSB
; LOOP @@Long3
;@@End:
; RET
;endp

Addr1 DD ?
Addr2 DD ?
DDKr  DD ?
L1    DW ?
L     DW ?

PutFillBox Proc Pascal Far _X1,_Y1,_X2,_Y2,_Kr:Word
 CLD
 MOV AL,Byte Ptr _Kr
 MOV AH,AL
 PUSH AX
 PUSH AX
.386
 POP DWord Ptr DDKr
.286
 MOV AX,Word Ptr _X2
 SUB AX,Word Ptr _X1
 INC AX
 MOV L,AX
 MOV BX,Word Ptr _Y1
 SHL BX,2
 MOV ES,DataVideo.MIV.AddrPg
.386
 MOV EAX,ES:[BX]
 PUSH EAX
  MOVZX EBX,Word Ptr _X1
  ADD EAX,EBX
  MOV Addr1,EAX
 POP EAX
 MOVZX EBX,Word Ptr _X2
 ADD EAX,EBX
 MOV Addr2,EAX
.286
 MOV CX,Word Ptr _Y1
 MOV ES,DataVideo.MIV.SegV
@@Home:
 PUSH CX
  PUSH Word Ptr Addr1[2]
  PUSH CS
  CALL Near Ptr SetBnkPg
  MOV AL,Byte Ptr Addr1[2]
  CMP AL,Byte Ptr Addr2[2]
  JNE @@NotContinue
  MOV DI,Word Ptr Addr1
  MOV CX,L
.386
  MOV EAX,DDKr
.286
  MOV BX,CX
  AND BX,3
  SHR CX,2
.386
  REP STOSD
.286
  MOV CX,BX
  REP STOSB
  JMP @@EndPass
@@NotContinue:
  XOR CX,CX
  SUB CX,Word Ptr Addr1  ; 0-AX n'est pas du sadomasochisme...
  MOV L1,CX
  MOV DI,Word Ptr Addr1
  MOV AX,Word Ptr DDKr
  SHR CX,1
  REP STOSW
  ADC CX,CX
  REP STOSB
  PUSH Word Ptr Addr2[2]
  PUSH CS
  CALL Near Ptr SetBnkPg
  MOV CX,L
  SUB CX,L1
  XOR DI,DI
  MOV AX,Word Ptr DDKr
  SHR CX,1
  REP STOSW
  ADC CX,CX
  REP STOSB
@@EndPass:
  XOR CX,CX
.386
  MOVZX EAX,Word Ptr DataVideo.MIV._BytesPerLn
  ADD Addr1,EAX
  ADD Addr2,EAX
.286
 POP CX
 INC CX
 CMP Word Ptr _Y2,CX
.386
 JAE @@Home
.286
 RET
Endp

@BytesPerLn DW 0
@PB         DW 0
@Pg         DW 0
@Back       DB 0
@Fore       DB 0

SetCube Proc Pascal Far X,Y,Chr,Attr:Word
 MOV ES,DataVideo.MIV.SegBuf
.386
 MOVZX BX,Byte Ptr Y
.286
 SHL BX,1
 MOV DI,CS:[Offset RawTxtY+BX]
 MOV BL,Byte Ptr X
 ADD DI,BX
 SHL DI,1
 MOV AL,Byte Ptr Chr
 MOV AH,Byte Ptr Attr
 MOV ES:[DI],AX
 MOV BL,Byte Ptr DataVideo.MIV._NmXTxts
 MOV AH,BL
 DEC AH
 MOV AL,Byte Ptr X
 CMP AL,AH
 JBE @1
 DIV BL
 ADD Byte Ptr Y,AL
 MOV Byte Ptr X,AH
 MOV AL,AH
@1:
 XOR AH,AH
 SHL AX,3
 MOV Word Ptr X,AX
.386
 MOVZX BX,Byte Ptr Y
.286
 SHL BX,1
 MOV BX,Word Ptr CS:[Offset RawY+BX]
 MOV Word Ptr Y,BX
 JMP @SetGCube
endp

SetGCube Proc Pascal Far X,Y,Chr,Attr:Word
@SetGCube:
 CLD
 MOV AX,DataVideo.MIV._BytesPerLn
 SUB AX,8
 MOV @BytesPerLn,AX
.386
 LGS DI,DataVideo.MIV.TxtMtx
 MOVZX BX,Byte Ptr DataVideo.MIV._HeightChr
.286
 MOV SI,BX
 MOV BL,Byte Ptr Chr
 SHL BX,1
 ADD DI,RawY[BX]
 MOV @PB,DI
 XOR CX,CX
 MOV BX,Y
 SHL BX,2
 MOV ES,DataVideo.MIV.SegV
.386
 MOV FS,DataVideo.MIV.AddrPg
 LFS DI,FS:[BX]
 MOV DX,FS
.286
 ADD DI,X
 ADC DX,CX
 MOV Word Ptr @Pg,DX
 PUSH DX
 PUSH CS
 CALL Near Ptr SetBnkPg
 MOV DL,Byte Ptr Attr
 MOV DH,DL
 AND DH,0Fh
 SHR DL,4
 MOV Word Ptr @Back,DX
@L:
 MOV AX,DI
 ADD AX,7
 JC  @@Long
 MOV BX,Word Ptr @PB
.386
 MOV BH,GS:[BX]
.286
 ROL BH,1
 MOV AX,DX
 JNC @x1
 MOV AL,DH
@x1:
 ROL BH,1
 JC  @x2
 MOV AH,DL
@x2:
 STOSW
 ROL BH,1
 MOV AX,DX
 JNC @x3
 MOV AL,DH
@x3:
 ROL BH,1
 JC  @x4
 MOV AH,DL
@x4:
 STOSW
 ROL BH,1
 MOV AX,DX
 JNC @x5
 MOV AL,DH
@x5:
 ROL BH,1
 JC  @x6
 MOV AH,DL
@x6:
 STOSW
 ROL BH,1
 MOV AX,DX
 JNC @x7
 MOV AL,DH
@x7:
 ROL BH,1
 JC  @x8
 MOV AH,DL
@x8:
 STOSW
 JMP @@End
@@Long:
 MOV AH,AL
 MOV DX,Word Ptr @Back
 MOV CX,8
@L3:
 TEST DI,0FFFFh
 JNZ @L3A
 MOV AX,Word Ptr @Pg
 INC AX
 PUSH AX
 PUSH CS
 CALL Near Ptr SetBnkPg
 MOV DX,Word Ptr @Back
@L3A:
 MOV BL,BH
 ROR BL,CL
 JC  @@Long4
 MOV AL,DL
 STOSB
 LOOP @L3
 JMP @@End
@@Long4:
 MOV AL,DH
 STOSB
 LOOP @L3
@@End:
 DEC SI
 INC Word Ptr @PB
 TEST DI,0FFFFh
 JNZ @99
 ADD DI,Word Ptr @BytesPerLn
 JMP @99b
@99:
 ADD DI,Word Ptr @BytesPerLn
 JNC @y9
@99b:
 INC Word Ptr @Pg
 PUSH Word Ptr @Pg
 PUSH CS
 CALL Near Ptr SetBnkPg
 MOV DX,Word Ptr @Back
@y9:
 CMP SI,CX
.386
 JNE @L
.286
 RET
endp

code ends
end