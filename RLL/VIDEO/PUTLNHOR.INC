{\Source\Chantal\RLL\Video\PutLnHor.Inc}

{ Cette proc‚dure  est la m‚thode classique  permettant le tra‡age d'une
 ligne par l'interm‚diaire de la proc‚dure ClrLnHor. Elle est totalement
 blind‚.
}

Procedure PutLnHor;Assembler;ASM
 MOV BX,DataVideo.MIV.NumYPixels
 CMP Y,BX
 JAE @End
 MOV BX,DataVideo.MIV.NumXPixels
 DEC BX
 MOV AX,X1
 MOV DX,X2
 TEST AX,8000h
 JZ  @0
 TEST DX,8000h
 JNZ @End
 XOR AX,AX
 MOV X1,AX
@0:
 CMP AX,BX
 JA  @End
 CMP AX,DX
 JB  @1
 XCHG AX,DX
 MOV X1,AX
@1:
 CMP DX,BX
 JNA @2
 MOV DX,BX
@2:
 SUB DX,AX
 INC DX
 MOV X2,DX
 JMP ClrLnHor.Near[3]
@End:
END;