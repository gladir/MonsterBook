{Library\LongCall.Inc}

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

{$IFNDEF __LongCall}
 {$DEFINE __LongCall}

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                       Proc괺ure LongCall                        �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Description
 袴袴袴袴袴�

  Cette proc괺ure permet d'effectuer un appel � un adresse pr괹is en
 pr굎ervant les registres comme s'il s'agissait d'une interruption.
}

Procedure LongCall(Addr:LongInt;Var RegAddr:Registers);Assembler;ASM
 PUSH DS
  LES AX,Addr
  MOV Word Ptr @Address,AX
  MOV Word Ptr @Address[2],ES
  LDS SI,RegAddr
  MOV Word Ptr @DSsave,DS
  MOV Word Ptr @SIsave,SI
  CLD
  LODSW
  PUSH AX
   LODSW
   XCHG BX,AX
   LODSW
   XCHG CX,AX
   LODSW
   XCHG DX,AX
   LODSW
   XCHG BP,AX
   LODSW
   PUSH AX
    LODSW
    XCHG DI,AX
    LODSW
    PUSH AX
     LODSW
     MOV ES,AX
     LODSW
     AND AX,008D5h
     PUSH BX
      MOV BX,AX
      PUSHF
      POP AX
      AND AX,0F72Ah
      OR  AX,BX
      PUSH AX
      POPF
     POP BX
    POP DS
   POP SI
  POP AX
  CALL DWord Ptr @Address
  PUSHF
   PUSH ES
    PUSH DI
     MOV ES,Word Ptr @DSsave
     MOV DI,Word Ptr @SIsave
     CLD
     STOSW
     XCHG AX,BX
     STOSW
     XCHG AX,CX
     STOSW
     XCHG AX,DX
     STOSW
     XCHG AX,BP
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
 POP DS
 JMP @End
@address:DD 0
@DSsave:DW 0
@SIsave:DW 0
@End:
END;

{$ENDIF}