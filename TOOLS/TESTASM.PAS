Macro pasinterruption;
 CLI
 STI
EndMacro;

ASM
 MOV AX,BX
 MOV BX,AX
 pasinterruption
 MOV [00127],BX
END.