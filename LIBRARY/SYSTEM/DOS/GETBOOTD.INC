{\Source\Chantal\Library\System\Dos\GetBootDisk.Inc}

{$IFNDEF __GetBootDisk}
 {$DEFINE __GetBootDisk}

 {ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                         Fonction GetBootDisk                        Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette fonction permet de connaŒtre l'unit‚ de d‚marrage sous lequel le
  systŠme d'exploitation  a ‚t‚ lanc‚e.  Si la fonction  ne r‚ussit pas …
  d‚terminer de quel unit‚ a ‚t‚ lanc‚e le systŠme,  elle renvoie l'unit‚
  0 (A:). La fonction renvoie des unit‚s correspondant … ceci: 0=A:, 1=B:,
  2=C:, 3=D:, 4=E:, 5=F:,...
 }

 Function GetBootDisk:Byte;Assembler;ASM
  MOV AX,3305h
  INT 21h
  MOV AL,DL
  OR  AL,AL
  JNZ @End
  INC AX
 @End:
  DEC AX
 END;

{$ENDIF}