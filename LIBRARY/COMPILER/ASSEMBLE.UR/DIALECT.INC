;旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
;�                 Malte Genesis/Biblioth둸ue individuel                 �
;�                    릁ition Chantal/IV - Version 1.1                   �
;�                             1998/01/16                                �
;�                                                                       �
;�         Tous droits r굎erv굎 par les Chevaliers de Malte (C)          �
;잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
;
;
;Nom des programmeurs
;袴袴袴袴袴袴袴袴袴袴
;
; Sylvain Maltais
;
;
;Description
;袴袴袴袴袴�
;
; Cette inclusion vise  � permettre une universialisation des donn괻s �
;compiler  ind굋endament  des conditions  sous  lequel  la fonction est
;tra똳er.  En centralisant toutes les proc괺ures au m늤e point central,
;on aboutira une technique de 췈roiser�, celle-ci permet d'굃iminer les
;bugs par le raisonnement suivant:Maintenant sa fonctionne parfaitement
;ou sa plante comme jamais avant...
;
;  D괽inition des dialectes � partir de Macro d'assembleur pour Pseudo-
; Code plus 굒olu�.

IFNDEF __DialectAsm
 __DialectAsm Equ 1

IFEQUAL Macro exp,value,addr
 CMP exp,value
 JE  addr
EndM

_GOTO Macro addr
 JMP addr
EndM

Procedure Macro Name
 Name Proc Pascal
EndM

Function Macro Name
 Name Proc Pascal
EndM

EndFunc Macro
 RET
 EndP
EndM

EndProc Macro
 RET
 EndP
EndM

_MOV_ES_DS Macro
 PUSH DS
 POP ES
EndM

_MOV_DS_ES Macro
 PUSH ES
 POP DS
EndM

_MOV_ES_CS Macro
 PUSH CS
 POP ES
EndM

_MOV_DS_CS Macro
 PUSH CS
 POP DS
EndM

;RDMSR Macro Reg
; MOV ECX,Reg
; DB 0Fh,32h
;EndM

;WRMSR Macro Reg
; MOV ECX,Reg
; DB 0Fh,30h
;EndM

ENDIF