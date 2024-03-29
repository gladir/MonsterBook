{\Source\Chantal\System\Linux\Detect.Inc}

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                 Malte Genesis/Biblioth둸ue individuel                 �
 �                    릁ition Chantal/IV - Version 1.1                   �
 �                             2000/07/08                                �
 �                                                                       �
 �         Tous droits r굎erv굎 par les Chevaliers de Malte (C)          �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Nom des programmeurs
 袴袴袴袴袴袴袴袴袴袴

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

{$IFNDEF __DetectLinuxEmuDos}
 {$DEFINE __DetectLinuxEmuDos}

 {旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
  �                  Fonction InLinuxEmuDos             �
  잔複複複複複複複複複複複複複複複複複複複複複複複複複複�


  Description
  袴袴袴袴袴�

   Cette function indique si l'application DOS fonctionne
  actuellement sous la bo똳e de compatibilit� de Linux.}

 Function InLinuxEmuDos:Boolean;Assembler;ASM
  {$IFDEF FLAT386}
  {$ELSE}
   PUSH DS
     { V굍ification de la date du BIOS }
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
     { Initialisation de l'interruption 0E6h � un 췏RET� }
    XOR AX,AX
    MOV DS,AX
    MOV BX,$E6*4
    LES DI,DS:[BX]
    MOV BL,ES:[DI]
    MOV Byte Ptr ES:[DI],0CFh { Mettre un instruction 췏RET� }
     { Appel la v굍ification d'installation (Int 0E6h avec AH=0) }
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