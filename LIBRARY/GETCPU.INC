{GetCPU.Inc}

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

{$IFNDEF __GetCPU}
 {$DEFINE __GetCPU}

Function GetCPU:Word;Assembler;ASM
 PUSHF
  XOR AX,AX
  PUSH AX
  POPF
  PUSHF
  POP AX
  AND AX,0F000h
  CMP AX,0F000h
  JE  @@inferieur286
  MOV  DL,cpu80286
  MOV  AX,07000h
  PUSH AX
  POPF
  PUSHF
  POP AX
  AND AX,07000h
  JE  @@pfin
  INC DL
  CLI
  DB 066h,08Bh,0DCh         { MOV    EBX,ESP}
  DB 066h,083h,0E4h,0FCh    { AND    ESP,0FFFCh}
  DB 066h,09Ch              { PUSHFD}
  DB 066h,058h              { POP    EAX}
  DB 066h,08Bh,0C8h         { MOV    ECX,EAX}
  DB 066h,035h,000h,0h,4h,0h{ XOR    EAX,1 shl 18}
  DB 066h,050h              { PUSH   EAX}
  DB 066h,09Dh              { POPFD}
  DB 066h,09Ch              { PUSHFD}
  DB 066h,058h              { POP    EAX}
  DB 066h,051h              { PUSH   ECX}
  DB 066h,09Dh              { POPFD}
  DB 066h,033h,0C1h         { XOR    EAX,ECX}
  DB 066h,0C1h,0E8h,012h    { SHR    EAX,18}
  DB 066h,083h,0E0h,001h    { AND    EAX,1h}
  DB 066h,08Bh,0E3h         { MOV    ESP,EBX}
  STI
  ADD DL,AL
  JMP @@pfin
@@inferieur286:
  MOV DL,cpu80188
  MOV AL,0FFh
  MOV CL,021h
  SHR AL,CL
  JNE @@t88_86
  MOV DL,cpuV20
  STI
  MOV SI,0
  MOV CX,0FFFFh
  DB  0F3h,026h,0ACh
  OR  CX,CX
  JE  @@t88_86
  MOV DL,cpu8088
@@t88_86:
  PUSH CX
  POP  ES
  STD
  MOV DI,Offset @@q2_end
  MOV AL,0FBh
  MOV CX,3
  CLI
  REP STOSB
  CLD
  NOP
  NOP
  NOP
  INC DX
  NOP
@@q2_end:
  STI
@@pfin:
 POPF
 XOR DH,DH
 MOV AX,DX
END;

{$ENDIF}