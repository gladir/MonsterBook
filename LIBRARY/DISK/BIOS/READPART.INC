{\Source\Chantal\Library\Disk\Bios\ReadPart.Inc}

{Descrition
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction copie un secteur de partition du disque dur dans un
 tampon.


 Entr‚e
 ÍÍÍÍÍÍ

  Lecteur       Code BIOS du lecteur (80h, 81h,...)
  Tete          Num‚ro de la tˆte de lecture/‚criture
  SecCyl        Num‚ro de secteur et de cylindre au format BIOS
  Tamp          Tampon dans lequel le secteur est charg‚
}

Function ReadPartSec(Lecteur,Tete:Byte;SecCyl:Word;Var Tamp):Boolean;Assembler;ASM
 MOV AX,0201h
 MOV DL,Lecteur
 MOV DH,Tete
 MOV CX,SecCyl
 LES BX,Tamp
 INT 13h
 CMC
 MOV AL,0
 ADC AL,AL
END;