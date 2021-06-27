{\Source\Chantal\Library\Sound\Blaster\GetCDVolume.Inc}

{ Cette fonction permet de connaŒtre le volume actuel attribu‚ au lecteur
 de disque compacte.
}

Function GetCDVolume:Byte;Assembler;ASM
 MOV DX,SoundPort
 ADD DX,4
 MOV AL,28h
 OUT DX,AL
 INC DX
 IN  AL,DX
END;