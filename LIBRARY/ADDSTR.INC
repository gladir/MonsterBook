{AddStr.Inc}

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

{$IFNDEF __AddStr}
 {$DEFINE __AddStr}

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴콘
 �                           Proc괺ure AddStr                           �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複蔔


 Description
 袴袴袴袴袴�

  Cette fonction concat둵e une cha똭e de caract둹es 췆dd� � une cha똭e de
 caract둹es source 췚�.Cette proc괺ure 굌uivaut � l'op굍ation 췚:=S+Add�.
}

Procedure AddStr(Var S:String;Const Add:String);
{$IFDEF __386__}
 Begin
  S:=S+Add;
 End;
{$ELSE}
 {$IFDEF NoAsm}
  Begin S:=S+Add;End;
 {$ELSE}
  Assembler;ASM
   PUSH DS
    LES DI,S
    LDS SI,Add
    MOV BL,ES:[DI]
    XOR BH,BH
    MOV CL,DS:[SI]
    XOR CH,CH
    MOV DX,BX
    ADD DX,CX
    OR  DH,DH
    JE  @NoTrunc
    MOV CX,255
    MOV DX,CX
    SUB CX,BX
 @NoTrunc:
    MOV ES:[DI],DL
    ADD DI,BX
    INC DI
    INC SI
    CLD
    SHR CX,1
    REP MOVSW
    ADC CX,CX
    REP MOVSB
   POP DS
  END;
 {$ENDIF}
{$ENDIF}

{$ENDIF}