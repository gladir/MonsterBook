{\Source\Chantal\Library\Sound\Blaster\SetCDVolume.Inc}

{ Cette proc‚dure permet de fixer le volume actuel attribu‚ au lecteur
 de disque compacte.
}

Procedure SetCDVolume(X:Byte);Near;Assembler;ASM
 MOV DX,SoundPort
 ADD DX,4
 MOV AL,28h
 MOV AH,X
 OUT DX,AX
END;
