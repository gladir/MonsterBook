{\Source\Chantal\Library\Disk\Ram\IsRamDrv.Inc}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                 Malte Genesis/BibliothŠque individuel                 Û
 ³                    dition Chantal/IV - Version 1.1                   Û
 ³                             1997/04/01                                Û
 ³                                                                       Û
 ³         Tous droits r‚serv‚s par les Chevaliers de Malte (C)          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Nom des programmeurs
 ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

  Li-Hsin Huang
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

{$IFNDEF __IsRAMDrive}
 {$DEFINE __IsRAMDrive}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Fonction IsRAMDrive                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction indique si l'unit‚ (0=A, 1=B, 2=C:,...) est un disque
 virtuel de type RAM.
}

Function IsRAMDrive(Drive:Integer):Boolean;Assembler;
Var
 Temp:Boolean;
ASM
 {$IFDEF FLAT386}
 {$ELSE}
  MOV Temp,False
  PUSH DS
   MOV BX,SS
   MOV DS,BX
   SUB SP,0200h
   MOV BX,SP
   CLD
   MOV AX,DS
   MOV ES,AX
   MOV DI,BX
   MOV CX,0100h
   XOR AX,AX
   REP STOSW                      { Initialise le tampon … 0 en cas d'erreur}
   MOV AX,Drive                   { le tampon ne sera pas fon‡ement interpr‚ter}
   MOV CX,1
   XOR DX,DX
   INT 25h                        { Lecture du secteur de d‚marrage }
   ADD SP,2
   JC  @@1
   MOV BX,SP
 (*  CMP Byte Ptr SS:[BX+15h],0F8h  { Rev‚rification de disque dur }
   JNE @@1*)
   CMP Byte Ptr SS:[BX+10h],1     { V‚rification d'une simple FAT }
   JNE @@1
   MOV Temp,True
 @@1:
   ADD SP,0200h
  POP DS
  MOV AL,Temp
 {$ENDIF}
END;

{$ENDIF}