{Intr.Inc}

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

{$IFNDEF __Intr}
 {$DEFINE __Intr}

Const
  fCarry=$0001;
  fParity=$0004;
  fAuxiliary=$0010;
  fZero=$0040;
  fSign=$0080;
  fOverflow=$0800;

Procedure Intr(IntNo:Byte;Var Regs:Registers);Assembler;ASM
 PUSH DS
 {$IFDEF ProtectedMode}
  {$IFDEF Windows}
   PUSH CS
   CALL AllocCSToDSAlias
  {$ELSE}
   MOV AX,CS
   ADD AX,SelectorInc
  {$ENDIF}
  MOV DS,AX
  CLI
  PUSH Word Ptr DS:@@Int
  PUSH DS
  MOV AL,IntNo
  MOV Byte Ptr DS:@@Int+1,AL
 {$ELSE}
  PUSH Word Ptr CS:@@Int
  MOV AL,IntNo
  MOV Byte Ptr CS:@@Int+1,AL
 {$ENDIF}
 {$IFDEF FLAT386}
  LEA ESI,DWord Ptr Regs
 {$ELSE}
  LDS SI,Regs
 {$ENDIF}
 CLD
 LODSW
 PUSH AX
 LODSW
 XCHG AX,BX
 LODSW
 XCHG AX,CX
 LODSW
 XCHG AX,DX
 LODSW
 XCHG AX,BP
 LODSW
 PUSH AX
 LODSW
 XCHG AX,DI
 LODSW
 PUSH AX
 LODSW
 {$IFDEF DPMI}
  VERR AX
  JNZ  @@1
  MOV  ES,AX
@@1:
  POP AX
  VERR AX
  JNZ @@2
  MOV DS,AX
@@2:
  {$ELSE}
   MOV ES,AX
   POP DS
  {$ENDIF}
  POP SI
  POP AX
@@Int:
  INT 0
  STI
  PUSHF
  PUSH ES
  PUSH DI
  PUSH BP
  MOV BP,SP
  {$IFDEF ProtectedMode}
   LES DI,Regs+14
  {$ELSE}
   LES DI,Regs+12
  {$ENDIF}
  CLD
  STOSW
  XCHG AX,BX
  STOSW
  XCHG AX,CX
  STOSW
  XCHG AX,DX
  STOSW
  POP AX
  STOSW
  XCHG AX,SI
  STOSW
  POP AX
  STOSW
  MOV AX,DS
  STOSW
  POP AX
  STOSW
  POP AX
  STOSW
  {$IFDEF ProtectedMode}
   POP DS
   POP Word Ptr DS:@@Int
  {$ELSE}
   POP Word Ptr CS:@@Int
  {$ENDIF}
  {$IFDEF Windows}
   MOV AX,DS
   POP DS
   PUSH	AX
   CALL	FreeSelector
  {$ELSE}
  POP DS
 {$ENDIF}
END;

{$ENDIF}