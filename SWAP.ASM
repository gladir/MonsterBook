.8086

code segment public
assume cs:code

;include systex.inc

public SwapInt,SwapWord

SwapWord Proc
endp

SwapInt Proc Pascal Far a,b:DWord
 PUSH DS
  LES DI,DWord Ptr A
  LDS SI,DWord Ptr B
  MOV AX,ES:[DI]
  XCHG AX,DS:[SI]
  MOV ES:[DI],AX
 POP DS
 RET
endp

code ends
end