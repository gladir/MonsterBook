{\Source\Chantal\Library\Disk\Ram\IsRamDrv.Inc}

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                 Malte Genesis/Biblioth둸ue individuel                 �
 �                    릁ition Chantal/IV - Version 1.1                   �
 �                             1997/04/01                                �
 �                                                                       �
 �         Tous droits r굎erv굎 par les Chevaliers de Malte (C)          �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Nom des programmeurs
 袴袴袴袴袴袴袴袴袴袴

  Li-Hsin Huang
  Sylvain Maltais


 Description
 袴袴袴袴袴�

  Cette inclusion vise  � permettre une universialisation des donn괻s �
 compiler  ind굋endament  des conditions  sous  lequel  la fonction est
 tra똳er.  En centralisant toutes les proc괺ures au m늤e point central,
 on aboutira une technique de 췈roiser�, celle-ci permet d'굃iminer les
 bugs par le raisonnement suivant:Maintenant sa fonctionne parfaitement
 ou sa plante comme jamais avant...
}

{$IFNDEF __IsRAMDrive}
 {$DEFINE __IsRAMDrive}

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                         Fonction IsRAMDrive                       �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Description
 袴袴袴袴袴�

  Cette fonction indique si l'unit� (0=A, 1=B, 2=C:,...) est un disque
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
   REP STOSW                      { Initialise le tampon � 0 en cas d'erreur}
   MOV AX,Drive                   { le tampon ne sera pas fon놽ment interpr굏er}
   MOV CX,1
   XOR DX,DX
   INT 25h                        { Lecture du secteur de d굆arrage }
   ADD SP,2
   JC  @@1
   MOV BX,SP
 (*  CMP Byte Ptr SS:[BX+15h],0F8h  { Rev굍ification de disque dur }
   JNE @@1*)
   CMP Byte Ptr SS:[BX+10h],1     { V굍ification d'une simple FAT }
   JNE @@1
   MOV Temp,True
 @@1:
   ADD SP,0200h
  POP DS
  MOV AL,Temp
 {$ENDIF}
END;

{$ENDIF}