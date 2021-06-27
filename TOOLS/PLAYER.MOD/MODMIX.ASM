.386
.MODEL TPascal
  b equ byte ptr
  w equ word ptr
  d equ dword ptr


.DATA

extrn voix_actuelle       : word;
extrn calc_size           : word;
extrn Mixed_data          : dword;
extrn Mixed_posi          : word;
extrn Mixed_data_st       : dword;

extrn Mixingproc_voix     : dword;
extrn Voixvide            : dword;

extrn Longueur_voix       : dword
extrn Position_voix       : dword
extrn Loop_Longueur_voix  : dword
extrn Loop_Start_Voix   : dword
extrn Segment_Voix      : dword
extrn Notvol_Voix       : dword
extrn Incval_Voix       : dword

.CODE

public Voix_normale
Voix_normale proc pascal ;voix_actuelle : word;
 PUSHA
 MOV SI,voix_actuelle
 DEC SI
 SHL SI,2                    ; AccŠs au DWord     
 MOV CX,calc_size

@Loop_Charge:

; La voix est parvenue … son terme ?
  MOV BX,w Longueur_voix[SI]
  SUB BX,20
  CMP BX,word ptr Position_voix[SI+2]
  JA  @Voix_non_au_terme

; Voix … son terme entre-t-elle dans un loop ?
  CMP Loop_Longueur_voix[SI],10
  JAE @Voix_en_boucle

; Voix au terme et non en boucle  => on sort
  MOV EAX,Voixvide
  MOV Mixingproc_voix[SI],EAX
  MOV Notvol_Voix[SI],0
  JMP @fin_Voix_normal
; ParamŠtres pour voix1 au d‚but de la boucle
@Voix_en_boucle:
  MOV BX,w Loop_Start_Voix[SI]
  MOV word ptr Position_voix[SI+2],BX
; Charge un octet … partir du sample Voix1
@Voix_non_au_terme:
  MOV BX,w Segment_Voix[SI]
  MOV ES,BX
  MOV BX,word ptr Position_voix[SI+2]
  MOV AL,ES:[BX]
  SUB AL,128
  MUL b Notvol_Voix[SI]
  SHR AX,6
@Voix_Sortie:
  LES DI,mixed_data
  ADD DI,mixed_posi
  ADD ES:[DI],AX
  ADD mixed_posi,2
; Red‚finir le pointeur
  MOV EBX,Incval_Voix[SI]
  ADD dword ptr Position_voix[SI],EBX
  LOOP @Loop_Charge
@fin_Voix_normal:
  POPA
  RET
Voix_normale endp

public Voix_normale_st
Voix_normale_st proc pascal
 PUSHA
 MOV SI,voix_actuelle
 DEC SI
 SHL SI,2   
 MOV CX,calc_size
@loop_Charge_st:
; La voix est parvenue … son terme ?
  MOV BX,w Longueur_voix[SI]
  SUB BX,20
  CMP BX,word ptr Position_voix[SI+2]
  JA  @Voix_non_au_terme_st

; Voix … son terme entre-t-elle dans un loop ?
  CMP Loop_Longueur_voix[SI],10
  JAE @Voix_en_boucle_st

; Voix au terme et non en boucle  => on sort
  MOV EAX,Voixvide
  MOV Mixingproc_voix[SI],EAX
  MOV AX,127
  MOV Notvol_Voix[SI],0
  JMP @fin_Voix_normale_st
; {ParamŠtres pour voix1 au d‚but de la boucle }
@Voix_en_boucle_st:
  MOV BX,w Loop_Start_Voix[SI]
  MOV word ptr Position_voix[SI+2],BX

; {Charge un octet … partir du sample Voix1 }
@Voix_non_au_terme_st:
  MOV BX,w Segment_Voix[SI]
  MOV ES,BX
  MOV BX,word ptr Position_voix[SI+2]
  MOV AL,ES:[BX]
  SUB AL,128
  MUL b Notvol_Voix[SI]
  SHR AX,6
@Voix_Sortie_st:
  LES DI,mixed_data_st
  ADD DI,mixed_posi
  ADD ES:[DI],AX
  ADD mixed_posi,2

; Red‚finir le pointeur
  MOV EBX,Incval_Voix[SI]
  ADD dword ptr Position_voix[SI],EBX
  LOOP @loop_Charge_st
@fin_Voix_normale_st:
  POPA
  RET
Voix_normale_st endp

public Voix_vide
Voix_vide proc pascal
 RET
Voix_vide endp

END
