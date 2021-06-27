.8086

Code Segment Public
Assume CS:Code

Include SYSTEX.INC

Extrn ACSend:Far,ACSendNow:Far
public ACSendACK,ACSendBS,ACSendCAN,ACSendCR,ACSendDLE,ACSendEOT,ACSendFFh
public ACSendNAK,ACSendNowXON,ACSendNowXOFF,ACSendNUL,ACSendSOH,ACSendSUB
public ACSendSYN,ACSendXOFF,ACSendXON

ACSendXON Proc Far
 MOV AL,caXON
 JMP Near Ptr @@1
endp

ACSendXOFF Proc Far
 MOV AL,caXOFF
 JMP Near Ptr @@1
endp

ACSendSYN Proc Far
 MOV AL,caSYN
 JMP Near Ptr @@1
endp

ACSendSUB Proc Far
 MOV AL,caSUB
 JMP Near Ptr @@1
endp

ACSendSOH Proc Far
 MOV AL,caSOH
 JMP Near Ptr @@1
endp

ACSendNUL Proc Far
 MOV AL,caNUL
 JMP Near Ptr @@1
endp

ACSendNAK Proc Far
 MOV AL,caNAK
 JMP Near Ptr @@1
endp

ACSendFFh Proc Far
 MOV AL,caFFh
 JMP Near Ptr @@1
endp

ACSendEOT Proc Far
 MOV AL,caEOT
 JMP Near Ptr @@1
endp

ACSendDLE Proc Far
 MOV AL,caDLE
 JMP Near Ptr @@1
endp

ACSendCR Proc Far
 MOV AL,caCR
 JMP Near Ptr @@1
endp

ACSendCAN Proc Far
 MOV AL,caCAN
 JMP Near Ptr @@1
endp

ACSendBS Proc Far
 MOV AL,caBS
 JMP Near Ptr @@1
endp

ACSendACK Proc Far
 MOV AL,caACK
@@1:
 PUSH AX
 PUSH CS
 CALL Near Ptr ACSend
 RETF
endp

ACSendNowXOFF Proc Far
 MOV AL,caXOFF
 JMP Near Ptr @@2
endp

ACSendNowXON Proc Far
 MOV AL,caXON
@@2:
 PUSH AX
 PUSH CS
 CALL Near Ptr ACSendNow
 RET
endp

code ends
end