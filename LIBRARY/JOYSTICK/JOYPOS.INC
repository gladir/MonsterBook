{JoyPos.Inc}

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                 Malte Genesis/Biblioth둸ue individuel                 �
 �                    릁ition Chantal/IV - Version 1.1                   �
 �                             1997/04/01                                �
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

{$IFNDEF __JoyPos}
 {$DEFINE __JoyPos}

Function JoyPos(Axe:Byte):Word;Assembler;ASM
 {$IFDEF Bios}
  MOV AH,$84
  MOV DX,$1
  INT $15
  CMP Axe,0
  JE  @@End
  MOV BX,AX
  CMP Axe,1
  MOV CX,AX
  CMP Axe,2
  JE  @@End
  MOV DX,AX
@@End:
 {$ELSE}
  MOV CL,Axe
  MOV BX,1
  SHL BX,CL
  MOV CX,$FFFF
  XOR AX,AX
  XOR SI,SI
  MOV DX,$0201
  CLI
  OUT DX,AL
@@Next:
  IN   AL,DX
  TEST AL,BL
  JE   @@Done
  INC  SI
  LOOP @@Next
@@Done:
  STI
  MOV AX,SI
@@End:
 {$ENDIF}
END;

{$ENDIF}