;ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
;³                 Malte Genesis/BibliothŠque individuel                 Û
;³                    dition Chantal/IV - Version 1.1                   Û
;³                             1998/01/16                                Û
;³                                                                       Û
;³         Tous droits r‚serv‚s par les Chevaliers de Malte (C)          Û
;ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ
;
;
;Nom des programmeurs
;ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ
;
; Sylvain Maltais
;
;
;Description
;ÍÍÍÍÍÍÍÍÍÍÍ
;
; Cette inclusion vise  … permettre une universialisation des donn‚es …
;compiler  ind‚pendament  des conditions  sous  lequel  la fonction est
;traŒter.  En centralisant toutes les proc‚dures au mˆme point central,
;on aboutira une technique de ®Croiser¯, celle-ci permet d'‚liminer les
;bugs par le raisonnement suivant:Maintenant sa fonctionne parfaitement
;ou sa plante comme jamais avant...
;
;  D‚finition des dialectes … partir de Macro d'assembleur pour Pseudo-
; Code plus ‚volu‚.

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