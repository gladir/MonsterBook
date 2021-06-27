; Malte Genesis IV: Ad둳e
; Module d'Identification d'existance d'imprimante
; Tous droits r굎erv굎 par les Chevaliers de Malte
; 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

.8086

Code Segment Public
Assume CS:Code

Public LPT1Exist,LPT2Exist,LPT3Exist,LPT4Exist

LPT4Exist Proc Far
 MOV DI,040Eh
 JMP Near Ptr @@1
EndP

LPT3Exist Proc Far
 MOV DI,040Ch
 JMP Near Ptr @@1
EndP

LPT2Exist Proc Far
 MOV DI,040Ah
 JMP Near Ptr @@1
EndP

LPT1Exist Proc Far
 MOV DI,0408h
@@1:
 XOR AX,AX
 MOV ES,AX
 SCASW ; CMP ES:[DI],AX
 JZ  @@End
 INC AX
@@End:
 RET
EndP

Code EndS
End