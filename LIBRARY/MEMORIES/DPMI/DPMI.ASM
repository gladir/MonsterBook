; Nom des programmeurs
; 袴袴袴袴袴袴袴袴袴袴
;
;  Hiroya Tsubakimoto - 1992
;  Charles Sandmann - 1993
;  Sylvain Maltais - 1998

.386p
INCLUDE SEGDEFS.INC
INCLUDE TSS.INC

IFE DEBUGGER
;컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
;DGROUP group _TEXT,_DATA,_BSS  ;(tiny model only)

DPMIinfo STRUC
vers  DB ?,?
flags DW ?
cpu   DW ?
PIC   DB ?,?
DPMIinfo ENDS

DPMImemory STRUC
address     DD ?
bytes       DD ?
handle      DD ?
DPMImemory ENDS

regs STRUC
rDI    DW ?,?
rSI    DW ?,?
rBP    DW ?,?
       DD 0
rBX    DW ?,?
rDX    DW ?,?
rCX    DW ?,?
rAX    DW ?,?
rFlags DW ?
rES    DW ?
rDS    DW ?
rFS    DW ?
rGS    DW ?
rIP    DW ?
rCS    DW ?
rSP    DW ?
rSS    DW ?
regs  ENDS

;컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
start_data16

EXTRN _tss_ptr:WORD

goProtectMode  DD ? ;Position de l'appel d'une routine FAR
realRegs       regs <>
selfSP         DW ?
selfSS         DW ?

        end_data16
;컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
        start_code16

ASSUME CS:_TEXT,DS:DGROUP

numberException EQU 15 ;Nombre de handle que nous utilisons
selfDS DW ?

;컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
;        DPMI
; Syntaxe:
;        int initDPMI(DPMIinfo* info)
; Argument(s):
;        "info" sur l'h뱓re DPMI
; R굎ultat(s):
;        DPMI
;         1  0
;--------------------------------------------------------------*
PUBLIC _initDPMI
_initDPMI PROC NEAR
 PUSH BP
  MOV BP,SP
  PUSH SI
   PUSH DI
    MOV realRegs.rCS,CS ; Se souvenir des registres de segments...
    MOV realRegs.rDS,DS
    MOV realRegs.rSS,SS
    MOV AX,1687h        ; D굏ecte DPMI et demande au mode r괻l l'adresse d'entr괻 du mode prot괾�
    INT 2Fh
    AND AX,AX           ; D굏ection DPMI avec succ둺?  AX == 0 indique oui
    JNZ @@failed_initDPMI
    TEST BX,1           ; Les programmes supportant le 32 bits ont "1" dans le bit 0
    JZ   @@failed_initDPMI
    MOV Word Ptr goProtectMode[0],DI
    MOV Word Ptr goProtectMode[2],ES
    MOV BX,SI           ; Nombre de paragraphe requis pour les donn괻s l'h뱓re DPMI
    MOV AH,48h
    INT 21h
    JC  @@failed_initDPMI
    MOV ES,AX           ; Segment du mode r괻l de la r괾ion de donn괻 de l'h뱓re DPMI
    MOV AX,1            ; Nous avons une application en 32 Bits
    CALL goProtectMode
    JC Short @@failed_initDPMI
    MOV BX,CS           ; Code segment du mode prot괾�
    MOV AX,000Ah        ; Cr괻 un descripteur d'alias que nous allons 괹rire
    INT 31h
    JC Short @@failed_initDPMI
    MOV ES,AX           ; Alias pour notre segment de code
ASSUME ES:_TEXT
    MOV ES:selfDS,DS    ; Dans le mode prot괾�, on ne peut pas 괹rire dans le segment de code!
ASSUME ES:Nothing
    MOV BX,AX           ; Alias pour le segment de code que nous n'avons pas besoin
    MOV AX,0001h        ; Descripteur LDT libre
    INT 31h
    MOV selfSS,SS       ; Sauve le s굃ecteur de Segment de pile du mode prot괾괻
    MOV AX,0400h        ; Demande la version DPMI et ses drapeaux
    INT 31h
    MOV DI,Word Ptr [BP][4] ; "info"
    MOV [DI].vers[0],AH     ; Majeur
    MOV [DI].vers[1],AL     ; Mineur
    MOV [DI].flags,BX
    XOR CH,CH
    MOV [DI].cpu,CX
    MOV [DI].PIC[0],DH
    MOV [DI].PIC[1],DL
    MOV AX,0900h        ; Interruption virtuel inactive
    INT 31h
    MOV AX,1
    JMP Short @@done_initDPMI
@@failed_initDPMI:
    XOR AX,AX
@@done_initDPMI:
   POP DI
  POP SI
 POP BP
 RET
_initDPMI endp

;컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
; Syntaxe:
;        void uninitDPMI(int retcode)
; Argument(s):
;        "retcode" exit()
;--------------------------------------------------------------
PUBLIC _uninitDPMI
_uninitDPMI PROC NEAR
 PUSH BP
  MOV BP,SP
  MOV AX,0901h ; Active les interruptions virtuel
  INT 31h
  MOV AX,Word Ptr [BP][4]        ; "retcode"
  MOV AH,4Ch                     ; Terminate du programme et mode prot괾괻
  INT 21h
_uninitDPMI ENDP

;--------------------------------------------------------------
; Syntaxe:
;        void DPMIrealMode(void)
;--------------------------------------------------------------
PUBLIC _DPMIrealMode
_DPMIrealMode PROC NEAR
 POP BX  ; O� est-ce que retourne cette proc괺ure
 MOV realRegs.rBX,BX
 MOV realRegs.rSI,SI
 MOV realRegs.rDI,DI
 MOV realRegs.rBP,BP
 MOV realRegs.rSP,SP
 MOV realRegs.rIP,Offset _TEXT:@@realModeEntry
 MOV realRegs.rFlags,0202h
 XOR BX,BX ;Ne pas r굀nitialiser la ligne A20 des contr뱇eurs
 XOR CX,CX ;Ne pas copier n'importe quel mots dans la pile du mode prot괾괻
 PUSH DS
 POP ES    ;ES:EDI = Selecteur:Offset de la structure d'appel du mode r괻l
 MOV EDI,Offset DGROUP:realRegs
 MOV AX,0301h ; Appel FAR � une proc괺ure en mode r괻l
 INT 31h
 MOV SI,realRegs.rSI
 MOV DI,realRegs.rDI
 MOVZX EBP,realRegs.rBP
 MOVZX ESP,realRegs.rSP
 JMP realRegs.rBX ; DPMIprotectedMode()
@@realModeEntry:
 POP goProtectMode ; Adresse � retourner pour l'appel de retour du mode r괻l
 PUSH BX
 RET ; DPMIrealMode()
_DPMIrealMode ENDP

;컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
; Syntaxe:
;        void DPMIprotectedMode(void)
;컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
PUBLIC _DPMIprotectedMode
_DPMIprotectedMode PROC NEAR
 POP BX
 MOV realRegs.rBX,BX
 MOV realRegs.rSI,SI
 MOV realRegs.rDI,DI
 MOV realRegs.rBP,BP
 MOV realRegs.rSP,SP
 JMP goProtectMode ; Sauvegarde l'adresse de retourne FAR de l'appel de retourne du mode r괻l
_DPMIprotectedMode ENDP

;컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
; Syntaxe:
;        void DPMIexecute(void)
; Note(s):
;        Nous utilisons cette appel dans 췪andlerCommon�
;컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
PUBLIC _DPMIexecute
_DPMIexecute PROC NEAR
 PUSH BP
  PUSH SI
   PUSH DI
   MOV selfSP,SP
   CALL _DPMIprotectedMode ; "Switch" du mode prot괾괻 16 bits
   MOV BX,_tss_ptr
   MOV SS,[BX].tss_ss
   MOV ESP,[BX].tss_esp
   PUSH [BX].tss_eflags        ; Drapeaux de chargement
    PUSH DWord Ptr [BX].tss_cs ; CS � l'ex괹ution (32 bit)
     PUSH [BX].tss_eip         ; EIP � l'ex괹ution (32 bit)
      MOV EAX,[BX].tss_eax
      MOV ECX,[BX].tss_ebx
      PUSH ECX
       MOV ECX,[BX].tss_ecx
       MOV EDX,[BX].tss_edx
       MOV EBP,[BX].tss_ebp
       MOV ESI,[BX].tss_esi
       MOV EDI,[BX].tss_edi
       MOV ES,[BX].tss_es
       MOV FS,[BX].tss_fs
       MOV GS,[BX].tss_gs
       MOV DS,[BX].tss_ds
      POP EBX
      PUSH EAX
       MOV AX,0901h ; Active les interruptions virtuel
       INT 31h
      POP EAX
      IRETD ; Saute en revoyant les valeurs enfonc굎 (32 bits) dans la pile
_DPMIexecute  ENDP

;컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
;
; Syntaxe:
;        int DPMIalloc(DPMImemory* mem, word32 bytes)
; Argument(s):
;        "mem"
;        "bytes"
; R굎ultat(s):
;         1 0
;         "mem"
; Note(s):
;        DPMIfree()
;컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
PUBLIC _DPMIalloc
_DPMIalloc PROC NEAR
 PUSH BP
  MOV BP,SP
  PUSH SI
   PUSH DI
    MOV AX,0501h ; Allocation de bloc de m굆oire
alloc_common:
    MOV CX,Word Ptr [BP][4+2][0] ; "octets" � allou�
    MOV BX,Word Ptr [BP][4+2][2]
    INT 31h                      ; retournes BX:CX SI:DI
    JC Short @@failed_DPMIalloc
    PUSH BX                      ; sauve pour plut tard
     MOV BX,Word Ptr [BP][4]     ; adresse "mem"
     MOV Word Ptr [BX].handle[0],DI
     MOV Word Ptr [BX].handle[2],SI
     MOV Word Ptr [BX].address[0],CX
    POP AX
    MOV Word Ptr [BX].address[2],AX
    MOV ECX,DWord Ptr [BP][4+2]  ; Copie des "octets" dans la structure
    MOV [BX].bytes,ECX
    MOV AX,1                     ; succ둺
    JMP Short @@done_DPMIalloc
@@failed_DPMIalloc:
    XOR AX,AX                    ; 릀hec
@@done_DPMIalloc:
   POP DI
  POP SI
 POP BP
 RET
_DPMIalloc ENDP

;컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
;
; Syntaxe:
;        int DPMIrealloc(DPMImemory* mem, word32 bytes)
; Argument(s):
;        "mem"
;        "bytes"
; R굎ultat(s):
;         1 0
;         "mem"
; Note(s):
;        DPMIfree()
;컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
PUBLIC _DPMIrealloc
_DPMIrealloc PROC NEAR
 PUSH BP
  MOV BP,SP
   PUSH SI
    PUSH DI
     MOV BX,Word Ptr [BP][4]             ; Adresse "mem"
     MOV DI,Word Ptr [BX].handle[0]
     MOV SI,Word Ptr [BX].handle[2]
     MOV AX,0503h                        ; Red괽init la taille m굆oire du bloc
     JMP Short alloc_common
_DPMIrealloc ENDP

;컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
;
; Syntaxe:
;        void DPMIfree(DPMImemory* mem)
; Argument(s):
;        "mem"
; Note(s):
;        DPMIalloc(), DPMIrealloc()
;
;컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
PUBLIC _DPMIfree
_DPMIfree PROC NEAR
 PUSH BP
  MOV BP,SP
  PUSH SI
   PUSH DI
    MOV BX,Word Ptr [BP][4] ; Adresse "mem"
    MOV DI,Word ptr [BX].handle[0]
    MOV SI,Word ptr [BX].handle[2]
    MOV AX,0502h            ; Bloc m굆oire de libre
    INT 31h
   POP DI
  POP SI
 POP BP
 RET
_DPMIfree ENDP

;컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
;
; Syntaxe:
;        word16 DPMIselector(word16 number)
; Argument(s):
;        "number"
; Result(s):
;
;컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
PUBLIC _DPMIselector
_DPMIselector PROC NEAR
 PUSH BP
  MOV BP,SP
  MOV CX,Word Ptr [BP][4] ; "nombre" d'allouement
  MOV AX,0000h            ; Alloue des descripteurs LDT
  INT 31h                 ; retourne AX
  JNC Short @@done_DPMIselector
  XOR AX,AX
@@done_DPMIselector:
 POP BP
 RET
_DPMIselector ENDP

;컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
;
; Syntaxe:
;        void DPMIassignSelector(word16 selector, word16 type, word32 base, word32 limit)
; Argument(s):
;        "selector"
;        "type"
;        "base"
;        "limit"
;컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
PUBLIC _DPMIassignSelector
_DPMIassignSelector PROC NEAR
 PUSH BP
  MOV BP,SP
  MOV BX,Word Ptr [BP][4]             ; "selector"
  MOV DX,Word Ptr [BP][4+2+2][0]
  MOV CX,Word Ptr [BP][4+2+2][2]      ; "base"
  MOV AX,0007h                        ; Fixe le segment de base
  INT 31h
  JC Short @@err_DPMIassignSelector
  LAR AX,BX                           ; Demande le niveau priv� du selecteur BX
  AND AH,60h                          ; Masque tous les exceptions CPL
  MOV CX,Word Ptr [BP][4+2]           ; "type"
  AND CL,9Fh                          ; Efface le CPL pass�
  OR  CL,AH                           ; Ins둹e le CPL du selecteur
  MOV AX,0009h                        ; Fixe correctement les acc둺 du descripteur
  INT 31h
  JC  Short @@err_DPMIassignSelector
  MOV DX,Word Ptr [BP][4+2+2+4][0]
  MOV CX,Word Ptr [BP][4+2+2+4][2]    ; "limit"
  MOV AX,0008h                        ; Fixe les limites du segment
  INT 31h
  JC  Short @@err_DPMIassignSelector
  MOV AX,1
  JMP Short @@done_DPMIassignSelector
@@err_DPMIassignSelector:
  XOR AX,AX
@@done_DPMIassignSelector:
 POP BP
 RET
_DPMIassignSelector ENDP

;컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
;
; Syntaxe:
;        void DPMIchangeException(word8 no, DPMIaddress* handler)
; Argument(s):
;        "no"
;        "handler"
;컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
PUBLIC _DPMIchangeException
_DPMIchangeException PROC NEAR
 PUSH BP
  MOV BP,SP
  MOV AX,0202h                ; Demande le vecteur du handle d'exception
  MOV BX,Word Ptr [BP][4]     ; "no"
  INT 31h                     ; Retourne la valeur dans CX:EDX
  MOV AX,0203h                ; Fixe le vecteur du handle d'exception
change_common:
  PUSH CX                     ; Sauve pour plus tard
   PUSH EDX
   MOV BX,Word Ptr [BP][4+2]  ; Adresse de la structure "handle"
   MOV EDX,DWord Ptr [BX][0]
   MOV CX,Word Ptr [BX][4]
   MOV BX,Word Ptr [BP][4]    ; "no"
   INT 31h                    ; Ne pas changer!
   MOV BX,Word Ptr [BP][4+2]  ; Adresse de la struture "handle"
   POP EDX                    ; Offset du "handle" original
   MOV DWord Ptr [BX][0],EDX
  POP CX                      ; Segment du "handle" original
  MOV Word Ptr [BX][4],CX
 POP BP
 RET
_DPMIchangeException ENDP

;컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
;
; Syntax:
;        void DPMIchangeInterrupt(word8 no, DPMIaddress* handler)
; Argument(s):
;        "no"
;        "handler"
;컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
PUBLIC _DPMIchangeInterrupt
_DPMIchangeInterrupt PROC NEAR
 PUSH BP
  MOV BP,SP
  MOV AX,0204h                ; Demande le vecteur d'interruption du mode prot괾�
  MOV BX,Word Ptr [BP][4]     ; "no"
  INT 31h                     ; Retourne la valeur dans CX:EDX
  MOV AX,0205h                ; Fixe l'interruption du mode prot괾�
  JMP Short change_common
_DPMIchangeInterrupt ENDP

;컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
;
; Syntaxe:
;        void DPMIhandler(word8 no, DPMIaddress* handler)
; Argument(s):
;        "no"
;        "handler"
; Notes:
;      Ce sont des ensembles de handle "no" pour les interruptions et les
;      exceptions utilis� contenu dans une table collective. C'est un bug,
;      mais depuis toujours les exceptions ne travail pas dans le m늤e 
;      point.
;컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
PUBLIC _DPMIhandler
_DPMIhandler PROC NEAR
 PUSH BP
  MOV BP,SP
  MOV AX,Word Ptr [BP][4]        ; "no"
  XOR AH,AH
  MOV DX,sizeOfHandler
  MUL DX
  ADD AX,Offset _TEXT:handlerTable
  MOV BX,Word Ptr [BP][4+2]      ; "handler"
  MOV Word Ptr [BX][0],AX
  MOV Word Ptr [BX][2],DX
  MOV Word Ptr [BX][4],CS
 POP BP
 RET

handler MACRO n
 PUSH EAX
 MOV AL,n
 JMP handlerCommon
ENDM

handlerTable:
 handler 0
sizeOfHandler EQU $-Offset handlerTable
 x = 1
 rept 255
 handler x
 x = x + 1
ENDM
_DPMIhandler ENDP

;
;
; Note(s):
;        DPMIexecute()
;
handlerCommon PROC NEAR
 PUSH AX
  MOV AX,0900h ;D굎active les interruptions virtuels
  INT 31h
 POP AX
 PUSH EBX      ;TSS
  PUSH DS
    MOV DS,CS:selfDS
    MOV BX,_tss_ptr
    MOV [BX].tss_irqn,AL
   POP AX
   MOV [BX].tss_ds,AX
   MOV [BX].tss_es,ES
   MOV [BX].tss_fs,FS
   MOV [BX].tss_gs,GS
   MOV [BX].tss_esi,ESI
   MOV [BX].tss_edi,EDI
   MOV [BX].tss_ebp,EBP
   MOV [BX].tss_edx,EDX
   MOV [BX].tss_ecx,ECX
  POP [BX].tss_ebx
 POP [BX].tss_eax
 MOV AL,[BX].tss_irqn
 CMP AL,numberException
 JAE @@handlerCommon_interrupt
 PUSH EBP
  MOV EBP,ESP
  MOV EAX,DWord Ptr [EBP][12]
  MOV [BX].tss_error,EAX
  MOV EAX,DWord Ptr [EBP][12+4]
  MOV [bx].tss_eip,EAX
  MOV AX,Word Ptr [EBP][12+4+4]
  MOV [BX].tss_cs,AX
  MOV EAX,DWord Ptr [EBP][12+4+4+4]
  MOV [BX].tss_eflags,EAX
  MOV DWord Ptr [EBP][16],Offset _TEXT:@@handlerCommon_done
  MOV Word Ptr [EBP][16+4],CS
 POP EBP
 DB 66h
 RETF
@@handlerCommon_interrupt:
      POP [BX].tss_eip
     POP DWord Ptr [BX].tss_cs
    POP [BX].tss_eflags
@@handlerCommon_done:
    MOV DS,CS:selfDS
    MOV BX,_tss_ptr
    MOV [BX].tss_ss,SS
    MOV [BX].tss_esp,ESP
    MOV SS,selfSS
    MOVZX ESP,selfSP
    XOR EBP,EBP
    CALL _DPMIrealMode
   POP DI                ; Le C demande de sauver ces registres
  POP SI
 POP BP
 RET                     ; DPMIexecute() return point
handlerCommon ENDP

;--------------------------------------------------------------
;
; Syntaxe:
;        void Pmemget(word16 sel, word32 off, void* addr, word16 bytes)
; Argument(s):
;        "sel"
;        "off"
;        "addr"
;        "bytes"
;--------------------------------------------------------------
PUBLIC _Pmemget
_Pmemget PROC NEAR
 PUSH BP
  MOV BP,SP
  PUSH SI
   PUSH DI
    CALL _DPMIprotectedMode
    PUSH DS
     PUSH ES
      MOV AX,DS   ; ES = DS courant (r괾ion de 16 bit)
      MOV ES,AX
      MOV DS,Word Ptr [BP][4]          ; D굋lacement de 32 bit du "sel" � DS
      MOV ESI,DWord Ptr [BP][4+2]      ; D굋lacement de 32 bit de l'"off" � ESI
      MOVZX EDI,word ptr [BP][4+2+4]   ; 16 bit "addr" (ES:EDI)
move_common:
      CLD
      MOVZX ECX,Word Ptr [BP][4+2+4+2] ; "bytes"
      SHR CX,2                         ; R괹lame un multiple de 4
      JCXZ Short @@little_Pmemmove
      DB 67h                           ; Utilise ESI, EDI (32 bit)
      REP MOVSD
@@little_Pmemmove:
      MOVZX ECX,Word Ptr [BP][4+2+4+2] ; "bytes"
      AND CX,3                         ; Demande le modulo de 4
      JCXZ Short @@done_Pmemmove
      DB 67h                           ; Use esi, edi (32 bit)
      REP MOVSB
@@done_Pmemmove:
     POP ES
    POP DS
    CALL _DPMIrealMode
   POP DI
  POP SI
 POP BP
 RET
_Pmemget ENDP

;--------------------------------------------------------------
;
; Syntaxe:
;        void Pmemput(word16 sel, word32 off, const void* addr, word16 bytes)
; Argument(s):
;        "sel"
;        "off"
;        "addr"
;        "bytes"
;--------------------------------------------------------------
PUBLIC _Pmemput
_Pmemput PROC NEAR
 PUSH BP
  MOV BP,SP
  PUSH SI
   PUSH DI
    CALL _DPMIprotectedMode
    PUSH DS                                ; Ne pas modifier mais peut "poper"
     PUSH ES
      MOV ES,Word Ptr [BP][4]              ; D굋lacement de 32 bit du "sel" � ES
      MOV EDI,DWord Ptr [BP][4+2]          ; D굋lacemetn de 32 bit de l'"off" � EDI
      MOVZX ESI,Word Ptr [BP][4+2+4]       ; 16 bit "addr" (DS:ESI)
      JMP Short move_common
_Pmemput ENDP

;--------------------------------------------------------------
;
; Syntaxe:
;        void Pmemset(word16 sel, word32 off, word8 value, word32 bytes)
;        "sel"
;        "off"
;        "value"
;        "bytes"
;--------------------------------------------------------------
PUBLIC _Pmemset
_Pmemset PROC NEAR
 PUSH BP
  MOV BP,SP
  PUSH DI
   CALL _DPMIprotectedMode
   PUSH ES
    MOV ES,Word Ptr [BP][4]        ; "sel"
    MOV EDI,DWord Ptr [BP][4+2]    ; "off"
    MOV AX,Word Ptr [BP][4+2+4]    ; "value"
    MOV AH,AL
    PUSH AX
    PUSH AX
    POP EAX
    CLD
    MOV ECX,DWord Ptr [BP][4+2+4+2] ; "bytes"
    SHR ECX,2
    JECXZ Short @@little_Pmemset
    DB 67h                ; EDI
    REP STOSD
@@little_Pmemset:
    MOV ECX,DWord Ptr [BP][4+2+4+2] ; "bytes"
    AND ECX,3
    JCXZ Short @@done_Pmemset
    DB 67h                ; EDI
    REP STOSB
@@done_Pmemset:
   POP ES
   CALL _DPMIrealMode
  POP DI
 POP BP
 RET
_Pmemset ENDP

;컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
;
; Syntaxe:
;        word16 Pmemscan(word16 sel, word32 off, word8 value, word16 bytes)
;        "sel"
;        "off"
;        "value"
;        "bytes"
;컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
PUBLIC _Pmemscan
_Pmemscan PROC NEAR
 PUSH BP
  MOV BP,SP
  PUSH DI
   CALL _DPMIprotectedMode
   PUSH ES
    MOV ES,Word Ptr [BP][4]        ; "sel"
    MOV EDI,DWord Ptr [BP][4+2]    ; "off"
    MOV AX,Word Ptr [BP][4+2+4]    ; "value"
    CLD
    MOVZX ECX,Word Ptr [BP][4+2+4+2] ; "bytes"
    DB 67h                           ; EDI
    REPNE SCASB
    MOV DI,0
    JNE Short @@done_Pmemscan
    MOV DI,Word Ptr [BP][4+2+4+2]   ; "bytes"
    SUB DI,CX
@@done_Pmemscan:
   POP ES
   CALL _DPMIrealMode
   XCHG AX,DI
  POP DI
 POP BP
 RET
_Pmemscan ENDP

end_code16
ENDIF
END
