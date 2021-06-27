{\Source\Chantal\System\Linux\Detect.Inc}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                 Malte Genesis/BibliothŠque individuel                 Û
 ³                    dition Chantal/IV - Version 1.1                   Û
 ³                             2000/07/08                                Û
 ³                                                                       Û
 ³         Tous droits r‚serv‚s par les Chevaliers de Malte (C)          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Nom des programmeurs
 ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

  Sylvain Maltais


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette inclusion vise  … permettre une universialisation des donn‚es …
 compiler  ind‚pendament  des conditions  sous  lequel  la fonction est
 traŒter.  En centralisant toutes les proc‚dures au mˆme point central,
 on aboutira une technique de ®Croiser¯, celle-ci permet d'‚liminer les
 bugs par le raisonnement suivant:Maintenant sa fonctionne parfaitement
 ou sa plante comme jamais avant...
}

{$IFNDEF __DetectLinuxEmuDos}
 {$DEFINE __DetectLinuxEmuDos}

 {ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                  Fonction InLinuxEmuDos             Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette function indique si l'application DOS fonctionne
  actuellement sous la boŒte de compatibilit‚ de Linux.}

 Function InLinuxEmuDos:Boolean;Assembler;ASM
  {$IFDEF FLAT386}
  {$ELSE}
   PUSH DS
     { V‚rification de la date du BIOS }
    MOV AX,0F000h
    MOV DS,AX
    MOV BX,0FFF5h
    MOV AX,'20'
    CMP Word Ptr DS:[BX],'20'
    JNE @No_DosEmu
    CMP Word Ptr DS:[BX+2],'2/'
    JNE @No_DosEmu
    CMP Word Ptr DS:[BX+4],'/5'
    JNE @No_DosEmu
    CMP Word Ptr DS:[BX+6],'39'
    JNE @No_DosEmu
     { Initialisation de l'interruption 0E6h … un ®IRET¯ }
    XOR AX,AX
    MOV DS,AX
    MOV BX,$E6*4
    LES DI,DS:[BX]
    MOV BL,ES:[DI]
    MOV Byte Ptr ES:[DI],0CFh { Mettre un instruction ®IRET¯ }
     { Appel la v‚rification d'installation (Int 0E6h avec AH=0) }
    XOR AH,AH
    INT 0E6h
    MOV ES:[DI],BL  { Restaure l'ancienne instruction }
    CMP AX,0AA55h
    JNE @No_DosEmu
    MOV AX,01h
    JMP @End
 @No_DosEmu:
    XOR AX,AX
 @End:
    POP DS
  {$ENDIF}
 END;

{$ENDIF}