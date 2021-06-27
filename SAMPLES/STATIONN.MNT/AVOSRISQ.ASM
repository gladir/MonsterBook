;\Source\Chantal\Samples\Stationn.mnt\AvosRisq.Asm

;ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
;³                                                                       Û
;³                            AVOSRISQUES Inc.                           Û
;³                                                                       Û
;³                Malte Genesis/Samples de gestion de liste              Û
;³                    dition Chantal/IV - Version 1.1                   Û
;³                             1998/11/30                                Û
;³                                                                       Û
;³         Tous droits r‚serv‚s par les Chevaliers de Malte (C)          Û
;³                                                                       Û
;ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ
;
;
;Nom des programmeurs
;ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ
;
; Sylvain Maltais
; ...? Bien il y en qu'un!
;
;
;Description
;ÍÍÍÍÍÍÍÍÍÍÍ
;
;  Ce fichier  contient  le listing  d'un  fichier  de gestion  de parc de
; voiture par l'entremise d'une liste sym‚trique. A titre de d‚monstration
; il est limit‚ … la gestion de  7 voitures  dans le parc  et de 3 dans la
; rue.
;
;
;Remarque
;ÍÍÍÍÍÍÍÍ
;
; ş Je d‚dis ce listing  au ®MonsterBook¯,  alias  l'Oeuvre inhumaine afin
;   que son honneur soit  laver ainsi  qu'aux  vieux CPU 8088 et 8086 dont
;   l'arrogance  de certain permet  de les juger  d‚passer pour les tƒches
;   classique.

.8086
.MODEL TPASCAL

Include \Source\Chantal\Library\Compiler\Assemble.ur\Dialect.Inc
Include \Source\Chantal\Library\System\Dos\Constant.Mac
Include \Source\Chantal\Library\Memories\Real\RBufHead.Mac

Public AvosRisque

errHdl   Equ 0FFh ; Mauvais handle, erreur d'ouverture de fichier

; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ Constantes d'AVOSRISQUES Inc. ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
MaximumVoitureParc  Equ 7     ; Nombre maximal de voiture dans le parc
MaximumVoitureRue   Equ 3     ; Nombre maximal de voiture dans la rue

; ÄÄÄÄÄÄÄÄÄÄÄÄ Enregistrement utilis‚e pour AVOSRISQUES Inc. ÄÄÄÄÄÄÄÄÄÄÄÄ
InfoAuto STRUC
 Marque       DB 26 DUP (?)   ; Marque de la voiture
 Couleur      DB 16 DUP (?)   ; Couleur de la voiture
 Annee        DW ?            ; Ann‚e: 19xx
 Immat        DB 16 DUP (?)   ; Immat
ENDS

Extrn         MemAlloc:Far
Extrn         Free:Far

.DATA

String        DB 255 DUP (?)  ; Variable de retour de fonction
NomFichier    DB 82 DUP (?)   ; Nom du fichier par d‚faut
InfoParc      RBuf ?          ; Contient les donn‚es de la liste AVOSRISQUES
                              ; dans le parc
InfoRue       RBuf ?          ; Contient les donn‚es de la liste AVOSRISQUES
                              ; dans la rue
TempAuto      InfoAuto ?      ; Enregistrement temporaire d'auto

.CODE

RawTxtY DW     0,   80,  160,  240,  320,  400,  480,  560,  640,  720,  800,  880 ; 0 … 11
        DW   960, 1040, 1120, 1200, 1280, 1360, 1440, 1520, 1600, 1680, 1760, 1840 ; 12 … 23
        DW  1920, 2000, 2080, 2160, 2240, 2320, 2400, 2480, 2560, 2640, 2720, 2800 ; 24 … 35
        DW  2880, 2960, 3040, 3120, 3200, 3280, 3360, 3440, 3520, 3600, 3680, 3760 ; 36 … 47
        DW  3840, 3920, 4000, 4080, 4160, 4240, 4320, 4400, 4480, 4560, 4640, 4720 ; 48 … 63

; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ D‚finition utilis‚ pour le vid‚o ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
SegVideo DW 0B800h     ; Segment vid‚o
MaxYTxts DB 24         ; Position maximale d'affichage vertical
NmYTxts  DB 25         ; Nombre de ligne affichable
NmXTxts  DB 80         ; Nombre de colonne affichable

; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ Message utilis‚ dans ce programme ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
Pres1                 DB 18,"Travail Pratique 4"
Pres2                 DB  8,"fait par"
Pres3                 DB 15,"Sylvain Maltais"
Pres4                 DB 48,"Tous droits r‚serv‚s par les Chevaliers de Malte"
Pres5                 DB 10,"1998/11/06"
Pres6                 DB 11,"Description"
Pres7                 DB 11,"-----------"
Pres8                 DB 56,"Ce programme permet de g‚r‚e un stationnement de voiture"
Pres9                 DB 40,"aussi bien dans le parc que dans la rue."
Titre                 DB 38,"PARC DE STATIONNEMENT AVOSRISQUES inc."
Item1                 DB 21,"1. Arriv‚e d'une auto"
Item2                 DB 20,"2. D‚part d'une auto"
Item3                 DB 26,"3. Consultation d'une auto"
Item4                 DB 25,"4. Informations g‚n‚rales"
Item5                 DB 20,"5. Fin de la journ‚e"
StrFull               DB 57,"ChaŒne pleine! Arrˆtez dans mettre et presser sur ®ENTER¯"
StrLettreAttendu      DB 46,"Une lettre valide entre 'A' et 'Z' est attendu"
StrChiffreAttendu     DB 46,"Un chiffre valide entre '0' et '9' est attendu"
PresseUneTouche       DB 35,"Presse une touche pour continuer..."
PrendDessin           DB 40,"R‚pondez par la lettre ®O¯ ou ®N¯ S.V.P.!"
TitreDepartAuto       DB 20,"D‚part d'une voiture"
TitreArriveeAuto      DB 18,"Arriv‚e d'une auto"
TitreConsultationAuto DB 26,"Consultation d'une voiture"
TitreInformation      DB 11,"Information"
SaisieDonnee          DB 16,"Saisie de donn‚e"
FinJourneeStr         DB 14,"Fin de journ‚e"
QuesPrinc             DB 13,"Votre choix ?"
QuestionMat           DB 36,"Entrez le matricule de la voiture ? "
QuestionMarque        DB 29,"Entrez la marque du v‚hicule ?"
QuestionCouleur       DB 30,"Entrez la couleur du v‚hicule ?"
QuestionAnnee         DB 27,"Entrez l'ann‚e du v‚hicule ?"
EntrezNom             DB 25,"Entrez le nom du fichier:"
AutreFichier          DB 46,"D‚sirez-vous charger un autre fichier (O/N) ? "
QuesNewVoiture        DB 54,"D‚sirez-vous faire entrer une nouvelle voiture (O/N) ?"
Pres10                DB 45,"Voulez-vous poursuivre le traŒtement (O/N) ? "
QuesConsultNewVoiture DB 51,"D‚sirez-vous consulter une nouvelle voiture (O/N) ?"
QuesDepartNewVoiture  DB 54,"D‚sirez-vous faire partir une nouvelle voiture (O/N) ?"
SauveMsg              DB 47,"Sauvegarde des voitures du parc dans un fichier"
ParcEtRuePlein        DB 35,"Parc de stationnement et rue plein!"
VoitureExistante      DB 50,"La voiture est d‚ja dans le parc de stationnement!"
VoitureIntrouvable    DB 20,"Voiture introuvable!"
VoitureExistePas      DB 58,"Aucune voiture ne se trouve dans le parc de stationnement!"
ImpossibleCree        DB 31,"Impossible de cr‚er le fichier!"
AnneeInvalid          DB 44,"Ann‚e invalide! Dois ˆtre entre 1900 et 1999"
ChoixInvalid          DB 45,"Choix invalide! Entrez 1, 2, 3, 4 ou 5 S.V.P."
StrMarque             DB 7, "Marque:"
StrCouleur            DB 8, "Couleur:"
StrAnnee              DB 6, "Ann‚e:"
InfoParcUsed          DB 40,"Nombre d'autos stationn‚es dans le parc:"
InfoParcFree          DB 36,"Nombre de places libre dans le parc:"
InfoRueUsed           DB 37,"Nombre d'autos attendant dans la rue:"
InfoRueFree           DB 39,"Nombre de places de libres dans la rue:"
InfoVoitureParc       DB 45,"Voici la liste de(s) voiture(s) dans le parc:"
EnteteParc1           DB 63,"Marque                    Couleur         Annee Immatriculation"
EnteteParc2           DB 64,"------------------------- --------------- ----- ----------------"
TuteurAnnee           DB "9999"
AccepteTous           DB 'ş'

; ÄÄÄÄÄ Module incluant les routines de gestion de liste sym‚trique ÄÄÄÄ
Include \Source\Chantal\Library\Memories\Real\RBuf.Mac

;ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
;³                           Proc‚dure ClrScr                        Û
;ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ
;
;
; Description
; ÍÍÍÍÍÍÍÍÍÍÍ
;
;  Cette proc‚dure est utilis‚ pour effacer l'‚cran de mode texte.
;
;
; Entr‚e
; ÍÍÍÍÍÍ
;
;  AH        = Attribut utilis‚ pour effacer l'‚cran
;
;
; Sortie
; ÍÍÍÍÍÍ
;
;  Registres d‚truit AX, CX, DI, ES et les drapeaux

ClrScr Proc Near
 PUSH BX
  CLD
  MOV ES,SegVideo
  XOR DI,DI
  MOV BL,NmYTxts
  XOR BH,BH
  SHL BX,1
  MOV CX,Word Ptr RawTxtY[BX]
  MOV AL,' '
  REP STOSW
 POP BX
EndProc

;ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
;³                          Proc‚dure BarTxtHor                        Û
;ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ
;
;
; Description
; ÍÍÍÍÍÍÍÍÍÍÍ
;
;  Cette proc‚dure permet de tracer une barre de texte dans une ‚cran en
; mode texte dans l'intervalle (X1,Y)-(X2,Y).
;
;
; Entr‚e
; ÍÍÍÍÍÍ
;
;  AL        = CaractŠre utilis‚ pour afficher la barre d'‚cran de texte
;  AH        = Attribut utilis‚ pour afficher la barre d'‚cran de texte
;  BL        = Coordonn‚e texte Y
;  DL        = Coordonn‚e texte X1
;  DH        = Coordonn‚e texte X2
;
;
; Sortie
; ÍÍÍÍÍÍ
;
;  Registres d‚truit AX, BX, CX, DX, DI, ES et les drapeaux

BarTxtHor Proc Near
 XOR BH,BH
 SHL BX,1
 MOV DI,Word Ptr RawTxtY[BX]
 MOV BL,DL
 ADD DI,BX
 SHL DI,1
 MOV ES,SegVideo
 XOR CH,CH
 MOV CL,DH
 SUB CL,DL
 INC CL
 CLD
 REP STOSW
EndProc

;ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
;³                          Proc‚dure _PutTxtXY                      Û
;ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ
;
;
; Description
; ÍÍÍÍÍÍÍÍÍÍÍ
;
;  Cette proc‚dure permet l'affichage  d'un message  texte … partir du
; segment de donn‚e … un endroit (X,Y) en texte d‚finit respectivement
; par les registres BH et BL.
;
;
; Entr‚e
; ÍÍÍÍÍÍ
;
;  BL        = Coordonn‚e texte Y ( XX??h )
;  BH        = Coordonn‚e texte X ( ??YYh )
;  DS        = Segment utilis‚ pour l'affichage du message (String Pascal)
;  SI        = Offset utilis‚ pour l'affichage du message (String Pascal)
;  AH        = Attribut (couleur) utilis‚ pour l'affichage du message
;
;
; Sortie
; ÍÍÍÍÍÍ
;
;  Registres d‚truit CX, DX, DI, ES et les drapeaux

_PutTxtXY Proc Near
 PUSH AX
  PUSH BX
   PUSH SI
    MOV CL,BH
    XOR BH,BH
    SHL BX,1
    MOV DI,Word Ptr RawTxtY[BX] ; DI:=RawTxtY[Y shl 1]
    MOV BL,CL
    ADD DI,BX
    SHL DI,1
    MOV ES,SegVideo
    MOV CL,DS:[SI]
    XOR CH,CH
    JCXZ @2
    INC SI
@1: LODSB
    STOSW
    LOOP @1
@2:
   POP SI
  POP BX
 POP AX
EndProc

;ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
;³                          Proc‚dure PutTxtXY                       Û
;ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ
;
;
; Description
; ÍÍÍÍÍÍÍÍÍÍÍ
;
;  Cette proc‚dure permet l'affichage  d'un message  texte … partir du
; segment de code … un endroit (X,Y)  en texte  d‚finit respectivement
; par les registres BH et BL.
;
;
; Entr‚e
; ÍÍÍÍÍÍ
;
;  BL        = Coordonn‚e texte Y ( XX??h )
;  BH        = Coordonn‚e texte X ( ??YYh )
;  CS        = Segment utilis‚ pour l'affichage du message (String Pascal)
;  SI        = Offset utilis‚ pour l'affichage du message (String Pascal)
;  AH        = Attribut (couleur) utilis‚ pour l'affichage du message
;
;
; Sortie
; ÍÍÍÍÍÍ
;
;  Registres d‚truit CX, DX, DI, ES et les drapeaux

PutTxtXY Proc Near
 PUSH DS
  _MOV_DS_CS
  CALL _PutTxtXY
 POP DS
EndProc

;ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
;³                         Proc‚dure PutTxtY                       Û
;ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ
;
;
; Description
; ÍÍÍÍÍÍÍÍÍÍÍ
;
;  Cette proc‚dure permet l'affichage  d'un message  texte centrer …
; l'‚cran … partir du segment de code … une ligne en texte Y d‚finit
; par le registres BL.
;
;
; Entr‚e
; ÍÍÍÍÍÍ
;
;  BL        = Coordonn‚e texte Y
;  CS        = Segment utilis‚ pour l'affichage du message (String Pascal)
;  SI        = Offset utilis‚ pour l'affichage du message (String Pascal)
;  AH        = Attribut (couleur) utilis‚ pour l'affichage du message
;
;
; Sortie
; ÍÍÍÍÍÍ
;
;  Registres d‚truit BX, CX, DX, DI, ES et les drapeaux

PutTxtY Proc Near
 MOV BH,NmXTxts
 SUB BH,CS:[SI]
 SHR BH,1
 CALL PutTxtXY
EndProc

;ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
;³                         Proc‚dure SetChr                        Û
;ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ
;
;
; Description
; ÍÍÍÍÍÍÍÍÍÍÍ
;
;  Cette proc‚dure permet l'affichage d'un caractŠre … la position
; texte (X,Y) d‚finit respectivement par les registres DL et DH.
;
;
; Entr‚e
; ÍÍÍÍÍÍ
;
;  DL        = Coordonn‚e texte X
;  DH        = Coordonn‚e texte Y
;  AL        = Code du caractŠre … afficher
;
;
; Sortie
; ÍÍÍÍÍÍ
;
;  Registres drapeaux d‚truit

SetChr Proc Near ; (DL,DH) AL=Char
 PUSH BX
  PUSH DI
   PUSH ES
    MOV BL,DH
    XOR BH,BH
    SHL BX,1
    MOV DI,Word Ptr RawTxtY[BX]
    MOV BL,DL
    ADD DI,BX
    SHL DI,1
    MOV ES,SegVideo
    STOSB
   POP ES
  POP DI
 POP BX
EndProc

;ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
;³                        Proc‚dure SetCurPos                      Û
;ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ
;
;
; Description
; ÍÍÍÍÍÍÍÍÍÍÍ
;
;  Cette proc‚dure permet de fixer la coordonn‚e d'‚cran de texte du
; curseur clignotant … la position (X,Y)  d‚finit respectivement par
; les registres DL et DH.
;
;
; Entr‚e
; ÍÍÍÍÍÍ
;
;  DL        = Coordonn‚e texte X
;  DH        = Coordonn‚e texte Y
;
;
; Sortie
; ÍÍÍÍÍÍ
;
; Registre d‚truit AX, BX, CX, DX, SI, DI et les registres de drapeaux

SetCurPos Proc Near ; (DL,DH)
 MOV AH,02h
 XOR BX,BX
 INT 010h
 RET
endp

;ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
;³                        Fonction OpenFile                       Û
;ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ
;
;
; Description
; ÍÍÍÍÍÍÍÍÍÍÍ
;
;  Cette fonction permet d'ouvrir un fichier de type Handle avec le
; mode sp‚cifi‚e par le registre BL (lecture, ‚criture ou combin‚).
;
;
; Entr‚e
; ÍÍÍÍÍÍ
;
;  DS        = Segment du nom du fichier (Format String Pascal)
;  DI        = Offset du nom de fichier (Format String Pascal)
;  BL        = Mode d'accŠs (lecture=0, ‚criture=1 ou combin‚=2).
;
;
; Retour
; ÍÍÍÍÍÍ
;
;  AL        = Handle allou‚
;            = FFh (errHdl) si une erreur s'est produit

OpenFile Proc Near
 MOV AX,3D40h
 OR  AL,BL
 MOV BL,DS:[DI]
 XOR BH,BH
 INC BX
 MOV DS:[DI+BX],BH
 MOV DX,DI
 INC DX
 INT 21h
 JNC @OF2
 MOV AL,errHdl
@OF2:
EndProc

;ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
;³                         Fonction DelFile                       Û
;ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ
;
;
; Description
; ÍÍÍÍÍÍÍÍÍÍÍ
;
;  Cette fonction permet d'effacer un fichier par l'entremise de la
; technique des Handle du systŠme d'exploitation DOS.
;
;
; Entr‚e
; ÍÍÍÍÍÍ
;
;  DS        = Segment du nom du fichier (Format String Pascal)
;  DI        = Offset du nom de fichier (Format String Pascal)
;
;
; Retour
; ÍÍÍÍÍÍ
;
;  AX       = 0 tous va bien
;          <> 0 une erreur s'est produit

DelFile Proc Near
 MOV BL,DS:[DI]
 INC DI
 MOV BH,0
 MOV DS:[DI+BX],BH
 MOV DX,DI
 MOV AX,04100h
 INT 021h
 JC  @DF2
 XOR AX,AX
@DF2:
 DEC DI
EndProc

;ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
;³                        Fonction NewFile                       Û
;ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ
;
;
; Description
; ÍÍÍÍÍÍÍÍÍÍÍ
;
;  Cette fonction permet de cr‚er un fichier par l'entremise de la
; technique des Handle du systŠme d'exploitation DOS.
;
;
; Entr‚e
; ÍÍÍÍÍÍ
;
;  DS        = Segment du nom du fichier (Format String Pascal)
;  DI        = Offset du nom de fichier (Format String Pascal)
;
;
; Retour
; ÍÍÍÍÍÍ
;
;  AL       = Handle
;           = FFh (errHdl) s'est qu'une erreur de cr‚ation s'est produite

NewFile Proc Near
 MOV BL,DS:[DI]
 XOR BH,BH
 INC BX
 MOV DS:[DI+BX],BH
 MOV DX,DI
 INC DX
 XOR CX,CX
 MOV AH,03Ch
 INT 021h
 JNC @NF2
 MOV AL,errHdl
@NF2:
EndProc

;ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
;³                         Fonction FileSize                      Û
;ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ
;
;
; Description
; ÍÍÍÍÍÍÍÍÍÍÍ
;
;  Cette fonction permet de connaŒtre la taille d'un fichier ouvert
; par  l'entremise  de  la   technique  des  ®Handles¯ du   systŠme
; d'exploitation DOS.
;
;
; Entr‚e
; ÍÍÍÍÍÍ
;
;  BL       = Handle
;
;
; Retour
; ÍÍÍÍÍÍ
;
;  DX:AX    = Taille du fichier en 32 bits

FileSize Proc Near
 CMP BL,errHdl
 JE  @FS1
 XOR BH,BH
 MOV AX,04202h
 XOR CX,CX
 XOR DX,DX
 INT 021h
 JNC @FS1
 MOV AX,0FFFFh
 MOV DX,AX
@FS1:
EndProc

;ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
;³                         Proc‚dure Rewind                         Û
;ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ
;
;
; Description
; ÍÍÍÍÍÍÍÍÍÍÍ
;
;  Cette proc‚dure permet de place le pointeur fichier de type Handle
; au d‚but du dit fichier sp‚cifier par le Handle.
;
;
; Entr‚e
; ÍÍÍÍÍÍ
;
;  BL       = Handle
;
;
; Sortie
; ÍÍÍÍÍÍ
;
;  Registre d‚truit AX, BX, DX, SI, DI, ES

Rewind Proc Near
 PUSH CX
  MOV AX,4200h
  XOR BH,BH
  CMP BL,errHdl
  JE  @FinRewind
  XOR DX,DX
  XOR CX,CX
  INT 21h
  JC  @ErrRewind
  XOR AX,AX
@ErrRewind:
@FinRewind:
 POP CX
EndProc

;ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
;³                         Proc‚dure _GetRec                        Û
;ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ
;
;
; Description
; ÍÍÍÍÍÍÍÍÍÍÍ
;
;  Cette proc‚dure permet de lire un enregistrement dans un fichier de
; type Handle … la position courante.
;
;
; Entr‚e
; ÍÍÍÍÍÍ
;
;  BL       = Handle
;  CX       = Taille de l'enregistrement
;  ES       = Segment de l'enregistrement
;  DI       = Offset de l'enregistrement
;
;
; Sortie
; ÍÍÍÍÍÍ
;
;  Registre d‚truit AX, BX, DX, SI, DI, ES

_GetRec Proc Near
 PUSH CX
  CLD
  XOR AX,AX
  PUSH CX
   MOV DX,DI
   SHR CX,1
   REP STOSW
   ADC CX,CX
   REP STOSB
  POP CX
  MOV AX,3F00h
  XOR BH,BH
  CMP BL,errHdl
  JE  @1GR
  PUSH DS
   _MOV_DS_ES
   INT 021h
  POP DS
  JNC @1GR
  XOR AX,AX
@1GR:
 POP CX
EndProc

;ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
;³                           Proc‚dure _SetRec                        Û
;ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ
;
;
; Description
; ÍÍÍÍÍÍÍÍÍÍÍ
;
;  Cette proc‚dure permet d'‚crire un enregistrement dans un fichier de
; type Handle … la position courante.
;
;
; Entr‚e
; ÍÍÍÍÍÍ
;
;  BL       = Handle
;  CX       = Taille de l'enregistrement
;  DS       = Segment de l'enregistrement
;  SI       = Offset de l'enregistrement
;
;
; Sortie
; ÍÍÍÍÍÍ
;
;  Registre d‚truit AX, BX, DX, SI, DI, ES

_SetRec Proc Near
 PUSH ES
  PUSH DI
   PUSH BX
    MOV BL,Handle
    XOR BH,BH
    CMP BL,errHdl
    JE  @ErrSetRec
    MOV DX,SI
    MOV AX,04000h
    INT 021h
@ErrSetRec:
    JC @FinSetRec
    XOR AX,AX
@FinSetRec:
   POP BX
  POP DI
 POP ES
EndProc

;ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
;³                           Proc‚dure CloseFile                       Û
;ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ
;
;
; Description
; ÍÍÍÍÍÍÍÍÍÍÍ
;
;  Cette proc‚dure permet de fermer un fichier de type Handle du systŠme
; d'exploitation DOS.
;
;
; Entr‚e
; ÍÍÍÍÍÍ
;
;  BL       = Handle
;
;
; Sortie
; ÍÍÍÍÍÍ
;
;  Registre d‚truit AX, BX, CX, DX, SI, DI, ES

CloseFile Proc Near
 MOV AX,03E00h
 XOR BH,BH
 INT 021h
EndProc

;ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
;³                            Fonction ReadKey                         Û
;ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ
;
;
; Description
; ÍÍÍÍÍÍÍÍÍÍÍ
;
;  Cette fonction permet de lire le dernier caractŠre avec son scan code
; enfonc‚  au clavier.  Si aucun caractŠre  n'attend dans le tampon,  il
; attend aprŠs l'utilisateur afin de retourner l'action de l'utilisateur.
;
;
; Entr‚e
; ÍÍÍÍÍÍ
;
;  Aucun
;
;
; Sortie
; ÍÍÍÍÍÍ
;
;  Registre d‚truit BX, CX, DX, SI, DI, ES
;
;
; Retour
; ÍÍÍÍÍÍ
;
;  AL       = Code de caractŠre
;  AH       = Scan Code

ReadKey Proc Near
 XOR AX,AX
 INT 16h
EndProc

;ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
;³                           Proc‚dure ErrMsg                          Û
;ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ
;
;
; Description
; ÍÍÍÍÍÍÍÍÍÍÍ
;
;  Cette proc‚dure permet d'afficher un message d'erreur sur la derniŠre
; ligne de couleur rouge.
;
;
; Entr‚e
; ÍÍÍÍÍÍ
;
;  DS       = Segment du message d'erreur (Format String Pascal)
;  SI       = Offset du message d'erreur (Format String Pascal)

ErrMsg Proc Near
 MOV BL,MaxYTxts
 MOV DX,0+(79 shl 8)
 MOV AX,04F20h
 CALL BarTxtHor
 MOV AH,4Eh
 MOV BX,(2 shl 8)+24
 CALL PutTxtXY
EndProc

;ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
;³                            Proc‚dure Msg                         Û
;ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ
;
;
; Description
; ÍÍÍÍÍÍÍÍÍÍÍ
;
;  Cette proc‚dure permet d'afficher un message sur la ligne r‚serv‚e
; au message utilisateur.
;
;
; Entr‚e
; ÍÍÍÍÍÍ
;
;  DS       = Segment du message (Format String Pascal)
;  SI       = Offset du message (Format String Pascal)

Msg Proc Near
 MOV BL,MaxYTxts
 DEC BL
 MOV DX,0+(79 shl 8)
 MOV AX,02F20h
 CALL BarTxtHor
 MOV AH,2Eh
 MOV BX,(2 shl 8)+24-1
 CALL PutTxtXY
 MOV DH,MaxYTxts
 DEC DH
 MOV DL,2
 ADD DL,CS:[SI]
 CALL SetCurPos
EndProc

;ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
;³                     Proc‚dure CLireChaine                      Û
;ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ
;
;
; Description
; ÍÍÍÍÍÍÍÍÍÍÍ
;
;  Cette proc‚dure permet  d'interroger l'utilisateur  en acceptant
; n'importe quel caractŠre mettant le contenu de sa r‚ponse dans le
; segment de code.
;
;
; Entr‚e
; ÍÍÍÍÍÍ
;
;  CS       = Segment du message de l'usager (Format String Pascal)
;  SI       = Offset du message de l'usager (Format String Pascal)
;  CL       = Longueur maximal de la chaŒne entrable par l'utilisateur
;  DL       = Position X de d‚part
;  DH       = Position Y de d‚part

CLireChaine Proc Near
 MOV DI,Offset AccepteTous
endp

;ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
;³                     Proc‚dure CLireChaine                      Û
;ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ
;
;
; Description
; ÍÍÍÍÍÍÍÍÍÍÍ
;
;  Cette proc‚dure permet  d'interroger l'utilisateur  en acceptant
; que  les caractŠres  conforme au tuteur  mettant le contenu de sa
; r‚ponse dans le segment de code.
;
;
; Entr‚e
; ÍÍÍÍÍÍ
;
;* CS       = Segment du message de l'usager (Format String Pascal)
;  SI       = Offset du message de l'usager (Format String Pascal)
;* CS       = Segment du tuteur
;  DI       = Offset du tuteur
;  CL       = Longueur maximal de la chaŒne entrable par l'utilisateur
;  DL       = Position X de d‚part
;  DH       = Position Y de d‚part

_CLireChaine Proc Near
 PUSH DS
  _MOV_DS_CS
  CALL _LireChaine
 POP DS
EndProc

;ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
;³                      Proc‚dure LireChaine                      Û
;ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ
;
;
; Description
; ÍÍÍÍÍÍÍÍÍÍÍ
;
;  Cette proc‚dure permet  d'interroger l'utilisateur  en acceptant
; n'importe quel caractŠre mettant le contenu de sa r‚ponse dans le
; segment de donn‚e.
;
;
; Entr‚e
; ÍÍÍÍÍÍ
;
;  DS       = Segment du message de l'usager (Format String Pascal)
;  SI       = Offset du message de l'usager (Format String Pascal)
;  CL       = Longueur maximal de la chaŒne entrable par l'utilisateur
;  DL       = Position X de d‚part
;  DH       = Position Y de d‚part

LireChaine Proc Near
 MOV DI,Offset AccepteTous
endp

;ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
;³                     Proc‚dure _LireChaine                      Û
;ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ
;
;
; Description
; ÍÍÍÍÍÍÍÍÍÍÍ
;
;  Cette proc‚dure permet  d'interroger l'utilisateur  en acceptant
; que  les caractŠres  conforme au tuteur  mettant le contenu de sa
; r‚ponse dans le segment de donn‚e.
;
;
; Entr‚e
; ÍÍÍÍÍÍ
;
;  DS       = Segment du message de l'usager (Format String Pascal)
;  SI       = Offset du message de l'usager (Format String Pascal)
;  CS       = Segment du tuteur
;  DI       = Offset du tuteur
;  CL       = Longueur maximal de la chaŒne entrable par l'utilisateur
;  DL       = Position X de d‚part
;  DH       = Position Y de d‚part

_LireChaine Proc Near
Local OldPos:Word,Buffer:Word,Max:Byte,Tuteur:Word
 MOV Buffer,SI
 MOV Tuteur,DI
 DEC CL
 MOV Max,CL
 MOV Byte Ptr DS:[SI],0   ; Initialise le tampon
 MOV OldPos,DX
 DEC DL
 PUSH DX
  MOV BL,DH
  MOV DH,DL
  ADD DH,Max
  MOV AX,07F20h
  CALL BarTxtHor
 POP DX
ReLire:
 CALL SetCurPos
 CALL ReadKey
 CMP  AL,13
 JE   FinLecture
 CMP  AL,8
 JE   BackCaract
 CMP  AL,' '
 JB   Relire
 JMP  InsereCaract
BackCaract:
 MOV BX,Buffer
 CMP Byte Ptr DS:[BX],0
 JE  Relire
 DEC Byte Ptr DS:[BX]
 MOV DX,OldPos
 ADD DL,DS:[BX]
 DEC DL
 MOV AL,' '
 CALL SetChr
 JMP ReLire
FinLecture:
 MOV SI,Buffer
 RET
InsereCaract:
 MOV DI,Tuteur
 MOV DX,OldPos
 MOV BX,Buffer
 MOV CL,DS:[BX]
 CMP CL,Max
 JA  ChainePleine
 CMP Byte Ptr CS:[DI],'ş'
 JE  Tous
 XCHG DI,AX
 ADD AL,DS:[BX]
 ADC AH,0
 XCHG DI,AX
 CMP Byte Ptr CS:[DI],'A'
 JE  TestLettre
 CMP Byte Ptr CS:[DI],'9'
 JE  TestChiffre
 JMP Tous
TestChiffre:
 CMP AL,'0'
 JB  ChiffreAttendu
 CMP AL,'9'
 JA  ChiffreAttendu
 JMP Tous
TestLettre:
 AND AL,NOT 020h
 CMP AL,'A'
 JB  LettreAttendu
 CMP AL,'Z'
 JA  LettreAttendu
Tous:
 ADD DL,DS:[BX]
 INC Byte Ptr DS:[BX]
 ADD BL,DS:[BX]
 ADC BH,0
 MOV DS:[BX],AL
 PUSH DX
  DEC DL
  CALL SetChr
 POP DX
 JMP ReLire
ChiffreAttendu:
 MOV SI,Offset StrChiffreAttendu
 JMP @LEM
LettreAttendu:
 MOV SI,Offset StrLettreAttendu
 JMP @LEM
ChainePleine:
 MOV SI,Offset StrFull
@LEM:
 CALL ErrMsg
ResetLire:
 MOV DX,OldPos
 DEC DL
 MOV BX,Buffer
 ADD DL,DS:[BX]
 JMP Relire
endp

;ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
;³                     Proc‚dure InitTitre                 Û
;ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ
;
;
; Description
; ÍÍÍÍÍÍÍÍÍÍÍ
;
;  Cette proc‚dure initialise l'‚cran comme avec ®ClrScr¯ et
; affiche un titre … la ligne sp‚cifier par le registre BL.
;
;
; Entr‚e
; ÍÍÍÍÍÍ
;
;  BL       = Position vertical du titre
;  CS       = Segment du Titre
;  SI       = Offset du Titre

InitTitre Proc Near
 MOV AH,017h
 CALL ClrScr
 PUSH AX
  MOV AX,0720h
  MOV DX,0+(79 shl 8)
  MOV BL,24
  CALL BarTxtHor
 POP AX
 MOV AH,01Eh
 CALL PutTxtY
EndProc

;ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
;³                     Proc‚dure RBGetCurrAuto                    Û
;ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ
;
;
; Propri‚taire: RBuf
;
;
; Description
; ÍÍÍÍÍÍÍÍÍÍÍ
;
;  Cette proc‚dure permet de charger dans le segment de donn‚e
; la voiture courante d'une liste sym‚trique.
;
;
; Entr‚e
; ÍÍÍÍÍÍ
;
;  ES:DI    = Adresse de la structure ®RBuf¯

RBGetCurrAuto Proc Near
 PUSH DS
  PUSH ES
   PUSH DI
    CALL RBGetCurrBuf
    CMP CX,TYPE InfoAuto
    JNE @CorruptionMemoire
    _MOV_ES_DS
    MOV DI,Offset TempAuto
    MOV DS,DX
    XCHG SI,AX
    CLD
    REP MOVSB
@CorruptionMemoire:
   POP DI
  POP ES
 POP DS
EndProc

;ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
;³                          Fonction ICompare                       Û
;ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ
;
;
; Description
; ÍÍÍÍÍÍÍÍÍÍÍ
;
;  Cette fonction compare deux chaŒnes de caractŠres en ne tenant pas
; compte des majuscules/minuscules et indique si elles sont identique
; (1) ou diff‚rente (0).
;
;
; Entr‚e
; ÍÍÍÍÍÍ
;
;  DS:SI    = Source
;  ES:DI    = Destination
;  CX       = Longueur
;
;
; Sortie
; ÍÍÍÍÍÍ
;
;  Registre d‚truit AX, BX, CX, DX et les registres drapeaux
;
;
; Retour
; ÍÍÍÍÍÍ
;
;  AX       = 0 pour des chaŒnes de caractŠres diff‚rente
;           = 1 pour des chaŒnes de caractŠres identique

ICompare Proc Near
 PUSH SI
  PUSH DI
   JCXZ @@97
   CLD
@@99:
   CMPSB
   JNE @@98
   LOOP @@99
   JMP @@100
@@98:
   DEC SI
   LODSB
   MOV AH,ES:[DI-1]
   OR  AX,2020h
   CMP AH,'a'
   JB  @@97
   CMP AH,'z'
   JA  @@97
   CMP AL,'a'
   JB  @@97
   CMP AL,'z'
   JA  @@97
   SUB AL,AH
   OR  AL,AL
   JNZ @@97
   LOOP @@99
   JMP @@0
@@100:
   JZ  @@0
@@97:
   MOV CL,1
@@0:
   XCHG AX,CX
   XOR AL,1
   MOV AH,0
  POP DI
 POP SI
EndProc

;ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
;³                        Fonction RBSearchAuto                    Û
;ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ
;
;
; Description
; ÍÍÍÍÍÍÍÍÍÍÍ
;
;  Cette  fonction  recherche  dans  une liste sym‚trique  de format
; ®RBuf¯ l'immatriculation de la voiture sp‚cifi‚e par les registres
; d'adressages DS:SI.
;
;
; Entr‚e
; ÍÍÍÍÍÍ
;
;  DS:SI    = Adresse de l'immatriculation
;  ES:DI    = Adresse de la structure ®RBuf¯
;
;
; Sortie
; ÍÍÍÍÍÍ
;
;  Registre d‚truit AX, BX, CX, DX, SI et DI et les registres drapeaux
;
;
; Retour
; ÍÍÍÍÍÍ
;
;  AX       = 0 voiture introuvable
;           > 0 position dans la liste

RBSearchAuto Proc Near
 XOR AX,AX
 MOV CX,ES:[DI].RBuf.NB
 JCXZ @FinSearch
 CALL RBSetPtrHome
@Next:
 PUSH CX
  PUSH ES
   PUSH DI
    CALL RBGetCurrBuf
    XCHG DI,AX
    ADD DI,Offset InfoAuto.Immat
    MOV ES,DX
    MOV CL,ES:[DI]
    XOR CH,CH
    XOR AX,AX
    CMP CL,DS:[SI]
    JNE @SkipCompare
    INC CX
    CALL ICompare
@SkipCompare:
   POP DI
  POP ES
  OR AX,AX
  JNZ @FinTrouve
  CALL RBNext
 POP CX
 LOOP @Next
 XOR AX,AX
 JMP @FinSearch
@FinTrouve:
 POP AX
@FinSearch:
EndProc

;ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
;³                          Fonction Menu                          Û
;ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ
;
;
; Description
; ÍÍÍÍÍÍÍÍÍÍÍ
;
;  Cette  proc‚dure  affiche  un  menu  avec 5  options  et permet …
; l'utilisateur de choisir un des options. Il retourne ensuite comme
; valeur de retour cette option sous forme de lettre '1' … '5'.
;
;
; Entr‚e
; ÍÍÍÍÍÍ
;
;  DS:SI    = Adresse de l'immatriculation
;  ES:DI    = Adresse de la structure ®RBuf¯
;
;
; Sortie
; ÍÍÍÍÍÍ
;
;  Registre d‚truit AX, BX, CX, DX, SI et DI et les registres drapeaux
;
;
; Retour
; ÍÍÍÍÍÍ
;
;  AL       = CaractŠre correspondant … l'option

Menu Proc Near
 MOV SI,Offset Titre
 MOV BL,0
 CALL InitTitre
 MOV SI,Offset Item1
 MOV BX,(5 shl 8)+5
 MOV AH,01Bh
 CALL PutTxtXY
 MOV SI,Offset Item2
 INC BX
 INC BX
 CALL PutTxtXY
 MOV SI,Offset Item3
 INC BX
 INC BX
 CALL PutTxtXY
 MOV SI,Offset Item4
 INC BX
 INC BX
 CALL PutTxtXY
 MOV SI,Offset Item5
 INC BX
 INC BX
 CALL PutTxtXY
 MOV SI,Offset QuesPrinc
 MOV BX,17
 MOV AH,01Fh
 CALL PutTxtXY
@MenuRestart:
 MOV DX,(17 shl 8)+15
 CALL SetCurPos
 CALL ReadKey
 CMP AL,'1'
 JB  @MenuErr
 CMP AL,'5'
 JA  @MenuErr
 RET
@MenuErr:
 MOV SI,Offset ChoixInvalid
 CALL ErrMsg
 JMP @MenuRestart
endp

;ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
;³                             Fonction Val                          Û
;ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ
;
;
; Description
; ÍÍÍÍÍÍÍÍÍÍÍ
;
;  Cette fonction retourne la valeur entiŠre d'une chaŒne de caractŠre
; de format num‚rique.
;
;
; Remarque
; ÍÍÍÍÍÍÍÍ
;
;  ş S'il les caractŠres contenu dans la chaŒne ne sont pas des lettres
;    aussi bien dire qu'il retournera n'importe quel valeur...
;
;
; Entr‚e
; ÍÍÍÍÍÍ
;
;  DS:SI    = ChaŒne de caractŠres contenant les nombres
;
;
; Retour
; ÍÍÍÍÍÍ
;
;  AX       = Valeur num‚rique contenu dans la chaŒne

ValTab10 DW 1, 10, 100, 1000, 10000

Val Proc Near
 PUSH DI
  XOR DI,DI
  MOV CL,DS:[SI]
  XOR CH,CH
  ADD SI,CX
  STD
  XOR BX,BX
@Val:
  LODSB
  SUB AL,'0'
  XOR AH,AH
  MUL ValTab10[BX]
  ADD DI,AX
  INC BX
  INC BX
  LOOP @Val
  XCHG AX,DI
 POP DI
EndProc

;ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
;³                          Fonction LireOuiNon                        Û
;ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ
;
;
; Description
; ÍÍÍÍÍÍÍÍÍÍÍ
;
;  Cette fonction demande  … l'utilisateur  de r‚pondre par une lettre O
; ou N  en  majuscule  ou  minuscule  il  ne  fait  pas  la  diff‚rence.
; Toutefois si vous r‚pondez  une autre lettre que ces 2 alors il repose
; la question … l'utilisateur en lui affichant un message pour lui faire
; comprendre sa grossiŠre erreur de concentration.
;
;
; Entr‚e
; ÍÍÍÍÍÍ
;
;  Aucun
;
;
; Retour
; ÍÍÍÍÍÍ
;
;  AL       = CaractŠre correspondant … O ou N seulement

LireOuiNon Proc Near
@ReLireOuiNon:
 CALL ReadKey
 AND  AL,NOT 20h
 CMP  AL,'O'
 JE   @FinOuiNon
 CMP  AL,'N'
 JE   @FinOuiNon
 MOV  SI,Offset PrendDessin
 CALL ErrMsg
 JMP  @ReLireOuiNon
@FinOuiNon:
EndProc

;ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
;³                        Proc‚dure ArriveeAuto                      Û
;ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ
;
;
; Description
; ÍÍÍÍÍÍÍÍÍÍÍ
;
;  Cette proc‚dure demande  … l'utilisateur d'entr‚e  une voiture s'il
; existe  de la  place  dans le  parc  ou la  rue  et v‚rifie  que son
; immatriculation ne corresponde pas d‚j… … une voiture existante dans
; le parc.
;
;
; Entr‚e
; ÍÍÍÍÍÍ
;
;  Aucun
;
;
; Sortie
; ÍÍÍÍÍÍ
;
;  Registre d‚truit AX, BX, CX, DX, SI, DI et les drapeaux

ArriveeAuto Proc Near
@ArriveeAuto:
 MOV SI,Offset TitreArriveeAuto
 MOV BL,0
 CALL InitTitre
 MOV SI,Offset QuestionMat
 MOV BX,5
 MOV AH,01Bh
 CALL PutTxtXY
 MOV AX,InfoParc.NB
 ADD AX,InfoRue.NB
 CMP AX,MaximumVoitureParc+MaximumVoitureRue
 JAE @ParcEtRuePlein
 MOV DX,37+(5 shl 8)
 MOV CL,15
 MOV SI,Offset TempAuto.Immat
 CALL LireChaine
 CMP InfoParc.NB,0
 JE  @LectureDonnee
 MOV DI,Offset InfoParc
 MOV SI,Offset TempAuto.Immat
 _MOV_ES_DS
 CALL RBSearchAuto
 OR  AX,AX
 JZ  @LectureDonnee
 MOV SI,Offset VoitureExistante
 CALL ErrMsg
 JMP @ArriveeAutre
@ParcEtRuePlein:
 MOV SI,Offset ParcEtRuePlein
 CALL ErrMsg
 MOV SI,Offset PresseUneTouche
 CALL Msg
 CALL ReadKey
 RET
@LectureDonnee:
 MOV SI,Offset QuestionMarque
 MOV BX,7
 MOV AH,01Bh
 CALL PutTxtXY
 MOV DX,37+(7 shl 8)
 MOV CL,25
 MOV SI,Offset TempAuto.Marque
 CALL LireChaine
 MOV SI,Offset QuestionCouleur
 MOV BX,8
 MOV AH,01Bh
 CALL PutTxtXY
 MOV DX,37+(8 shl 8)
 MOV CL,15
 MOV SI,Offset TempAuto.Couleur
 CALL LireChaine
 MOV SI,Offset QuestionAnnee
 MOV BX,9
 MOV AH,01Bh
 CALL PutTxtXY
@RelireAnnee:
 MOV DX,37+(9 shl 8)
 MOV CL,4
 MOV SI,Offset String
 MOV DI,Offset TuteurAnnee
 CALL _LireChaine
 CALL Val
 CMP AX,1900
 JB  @MauvaiseAnnee
 CMP AX,1999
 JNA @AnneeValide
@MauvaiseAnnee:
 MOV SI,Offset AnneeInvalid
 CALL ErrMsg
 JMP @RelireAnnee
@AnneeValide:
 MOV TempAuto.Annee,AX
 MOV CX,TYPE InfoAuto
 _MOV_ES_DS
 CMP InfoParc.NB,MaximumVoitureParc
 JNE @Parc
 MOV DI,Offset InfoRue
 JMP @SkipParc
@Parc:
 MOV DI,Offset InfoParc
@SkipParc:
 MOV SI,Offset TempAuto
 CALL RBAdd
@ArriveeAutre:
 MOV SI,Offset QuesNewVoiture
 CALL Msg
 CALL LireOuiNon
 CMP AL,'N'
 JE  @FinArrivee
 JMP @ArriveeAuto
@FinArrivee:
EndProc

;ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
;³                           Fonction AChiffre                       Û
;ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ
;
;
; Description
; ÍÍÍÍÍÍÍÍÍÍÍ
;
;  Cette fonction retourne une valeur num‚rique contenu par le registre
; BX dans une chaŒne de caractŠres nomm‚ ®String¯.
;
;
; Entr‚e
; ÍÍÍÍÍÍ
;
;  BL       = Valeur
;
;
; Sortie
; ÍÍÍÍÍÍ
;
;  Registre d‚truit AX, BX, CX, DX, SI, DI et les drapeaux
;
;
; Retour
; ÍÍÍÍÍÍ
;
;  String   = Contient une chaŒne de caractŠres num‚rique contenant la valeur
;             du registre BX

AChiffre Proc Near
 CLD
 MOV DI,Offset String
 PUSH DS
 POP ES
 CMP BX,10000
 JAE @10000
 CMP BX,1000
 JAE @1000
 CMP BX,100
 JAE @100
 CMP BX,10
 JAE @10
 MOV AL,1
 MOV AH,BL
 ADD AH,'0'
 STOSW
 JMP @FinChiffre
@10:
 MOV AL,2
 STOSB
 XCHG AX,BX
@Dump10:
 MOV DL,10
 DIV DL
 ADD AL,'0'
 ADD AH,'0'
 STOSW
 JMP @FinChiffre
@100:
 MOV AL,3
 STOSB
 XCHG AX,BX
@Dump100:
 MOV DL,100
 DIV DL
 ADD AL,'0'
 STOSB
 MOV AL,AH
 MOV AH,0
 JMP @Dump10
@1000:
 MOV AL,4
 STOSB
 XCHG AX,BX
@Dump1000:
 XOR DX,DX
 MOV CX,1000
 DIV CX
 ADD AL,'0'
 STOSB
 XCHG AX,DX
 JMP @Dump100
@10000:
 MOV AL,5
 STOSB
 XCHG AX,BX
 XOR DX,DX
 MOV CX,10000
 DIV CX
 ADD AL,'0'
 STOSB
 XCHG AX,DX
 JMP @Dump1000
@FinChiffre:
EndProc

;ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
;³                     Proc‚dure Information                     Û
;ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ
;
;
; Description
; ÍÍÍÍÍÍÍÍÍÍÍ
;
;  Cette proc‚dure informe l'utilisateur sur l'‚tat global du parc
; ainsi que les nombres de place prise dans le parc et la rue.
;
;
; Entr‚e
; ÍÍÍÍÍÍ
;
;  Aucun
;
;
; Sortie
; ÍÍÍÍÍÍ
;
;  Registre d‚truit AX, BX, CX, DX, SI, DI et les drapeaux

Information Proc Near
 MOV SI,Offset TitreInformation
 MOV BL,0
 CALL InitTitre
 MOV SI,Offset InfoParcUsed
 MOV BX,(4 shl 8)+3
 MOV AH,01Fh
 CALL PutTxtXY
 MOV SI,Offset InfoParcFree
 INC BX
 CALL PutTxtXY
 MOV SI,Offset InfoRueUsed
 INC BX
 CALL PutTxtXY
 MOV SI,Offset InfoRueFree
 INC BX
 CALL PutTxtXY
 MOV BX,InfoParc.NB
 CALL AChiffre
 MOV SI,Offset String
 MOV BX,(45 shl 8)+3
 MOV AH,1Bh
 CALL _PutTxtXY
 MOV BX,MaximumVoitureParc
 SUB BX,InfoParc.NB
 CALL AChiffre
 MOV SI,Offset String
 MOV BX,(45 shl 8)+4
 MOV AH,1Bh
 CALL _PutTxtXY
 MOV BX,InfoRue.NB
 CALL AChiffre
 MOV SI,Offset String
 MOV BX,(45 shl 8)+5
 MOV AH,1Bh
 CALL _PutTxtXY
 MOV BX,MaximumVoitureRue
 SUB BX,InfoRue.NB
 CALL AChiffre
 MOV SI,Offset String
 MOV BX,(45 shl 8)+6
 MOV AH,1Bh
 CALL _PutTxtXY
 MOV SI,Offset PresseUneTouche
 CALL Msg
 CMP InfoParc.NB,0
 JE  @PersonneDansParc
 MOV SI,Offset InfoVoitureParc
 MOV BX,(0 shl 8)+8
 MOV AH,01Fh
 CALL PutTxtXY
 MOV SI,Offset EnteteParc1
 MOV BX,(0 shl 8)+10
 MOV AH,01Fh
 CALL PutTxtXY
 MOV SI,Offset EnteteParc2
 MOV BX,(0 shl 8)+11
 MOV AH,01Fh
 CALL PutTxtXY
 _MOV_ES_DS
 MOV DI,Offset InfoParc
 CALL RBSetPtrHome
 MOV CX,InfoParc.NB
 MOV BL,12
@AfficheLigne:
 PUSH CX
  CALL RBGetCurrAuto
  MOV SI,Offset TempAuto.Marque
  MOV BH,0
  MOV AH,01Bh
  CALL _PutTxtXY
  MOV SI,Offset TempAuto.Couleur
  MOV BH,26
  MOV AH,01Bh
  CALL _PutTxtXY
  PUSH BX
   MOV BX,TempAuto.Annee
   CALL AChiffre
  POP BX
  MOV SI,Offset String
  MOV BH,42
  MOV AH,01Bh
  CALL _PutTxtXY
  MOV SI,Offset TempAuto.Immat
  MOV BH,48
  MOV AH,01Bh
  CALL _PutTxtXY
  _MOV_ES_DS
  MOV DI,Offset InfoParc
  CALL RBNext
  INC BX
 POP CX
 LOOP @AfficheLigne
@PersonneDansParc:
 CALL ReadKey
EndProc

;ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
;³                        Proc‚dure DepartVoiture                    Û
;ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ
;
;
; Description
; ÍÍÍÍÍÍÍÍÍÍÍ
;
;  Cette  proc‚dure  permet  …  l'utilisateur  de  faire  quitter  une
; voiture du parc de voiture. Pour se faire il demande … l'utilisateur
; d'entr‚e le num‚ro  d'immatriculation  et si la voiture  est trouv‚e
; alors il l'efface de la liste sym‚trique.
;
;
; Entr‚e
; ÍÍÍÍÍÍ
;
;  Aucun
;
;
; Sortie
; ÍÍÍÍÍÍ
;
;  Registre d‚truit AX, BX, CX, DX, SI, DI et les drapeaux

DepartVoiture Proc Near
@Depart:
 MOV SI,Offset TitreDepartAuto
 MOV BL,0
 CALL InitTitre
 CMP InfoParc.NB,0
 JE  @DVoitureExistePas
 MOV SI,Offset QuestionMat
 MOV BX,5
 MOV AH,01Bh
 CALL PutTxtXY
 MOV DX,37+(5 shl 8)
 MOV CL,15
 MOV SI,Offset TempAuto.Immat
 CALL LireChaine
 MOV DI,Offset InfoParc
 MOV SI,Offset TempAuto.Immat
 _MOV_ES_DS
 CALL RBSearchAuto
 OR  AX,AX
 JNZ @DVoiturePresent
 MOV SI,Offset VoitureIntrouvable
 CALL ErrMsg
 JMP @DepartAutre
@DVoitureExistePas:
 MOV SI,Offset VoitureExistePas
 CALL ErrMsg
 MOV SI,Offset PresseUneTouche
 CALL Msg
 CALL ReadKey
 RET
@DVoiturePresent:
 CALL RBGetCurrAuto
 MOV SI,Offset StrMarque
 MOV BX,7
 MOV AH,01Bh
 CALL PutTxtXY
 MOV BH,37
 MOV SI,Offset TempAuto.Marque
 CALL _PutTxtXY
 MOV SI,Offset StrCouleur
 MOV BX,8
 MOV AH,01Bh
 CALL PutTxtXY
 MOV BH,37
 MOV SI,Offset TempAuto.Couleur
 CALL _PutTxtXY
 MOV SI,Offset StrAnnee
 MOV BX,9
 MOV AH,01Bh
 CALL PutTxtXY
 MOV BX,TempAuto.Annee
 CALL AChiffre
 MOV SI,Offset String
 MOV AH,01Bh
 MOV BX,(37 shl 8)+9
 CALL _PutTxtXY
 MOV DI,Offset InfoParc
 _MOV_ES_DS
 CALL RBDelCurrBuf
 CMP InfoRue.NB,0
 JE  @DepartAutre
 CMP InfoParc.NB,MaximumVoitureParc
 JNB @DepartAutre
 _MOV_ES_DS
 MOV DI,Offset InfoRue
 CALL RBSetPtrHome
 CALL RBGetCurrAuto
 CALL RBDelCurrBuf
 MOV DI,Offset InfoParc
 MOV SI,Offset TempAuto
 MOV CX,TYPE InfoAuto
 CALL RBAdd
@DepartAutre:
 MOV SI,Offset QuesDepartNewVoiture
 CALL Msg
 CALL LireOuiNon
 CMP AL,'N'
 JE  @FinDepart
 JMP @Depart
@FinDepart:
EndProc

;ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
;³                       Proc‚dure Consultation                     Û
;ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ
;
;
; Description
; ÍÍÍÍÍÍÍÍÍÍÍ
;
;  Cette proc‚dure permet … l'utilisateur de consulter une voiture du
; parc de voiture.  Pour se faire il demande … l'utilisateur d'entr‚e
; le num‚ro d'immatriculation  et si la voiture  est trouv‚e alors il
; l'efface de la liste sym‚trique.
;
;
; Entr‚e
; ÍÍÍÍÍÍ
;
;  Aucun
;
;
; Sortie
; ÍÍÍÍÍÍ
;
;  Registre d‚truit AX, BX, CX, DX, SI, DI et les drapeaux

Consultation Proc Near
@Consultation:
 MOV SI,Offset TitreConsultationAuto
 MOV BL,0
 CALL InitTitre
 CMP InfoParc.NB,0
 JE  @VoitureExistePas
 MOV SI,Offset QuestionMat
 MOV BX,5
 MOV AH,01Bh
 CALL PutTxtXY
 MOV DX,37+(5 shl 8)
 MOV CL,15
 MOV SI,Offset TempAuto.Immat
 CALL LireChaine
 MOV DI,Offset InfoParc
 MOV SI,Offset TempAuto.Immat
 _MOV_ES_DS
 CALL RBSearchAuto
 OR  AX,AX
 JNZ @VoiturePresent
@VoitureExistePas:
 MOV SI,Offset VoitureExistePas
 CALL ErrMsg
 MOV SI,Offset PresseUneTouche
 CALL Msg
 CALL ReadKey
 RET
@VoiturePresent:
 CALL RBGetCurrAuto
 MOV SI,Offset StrMarque
 MOV BX,7
 MOV AH,01Bh
 CALL PutTxtXY
 MOV BH,37
 MOV SI,Offset TempAuto.Marque
 CALL _PutTxtXY
 MOV SI,Offset StrCouleur
 MOV BX,8
 MOV AH,01Bh
 CALL PutTxtXY
 MOV BH,37
 MOV SI,Offset TempAuto.Couleur
 CALL _PutTxtXY
 MOV SI,Offset StrAnnee
 MOV BX,9
 MOV AH,01Bh
 CALL PutTxtXY
 MOV BX,TempAuto.Annee
 CALL AChiffre
 MOV SI,Offset String
 MOV AH,01Bh
 MOV BX,(37 shl 8)+9
 CALL _PutTxtXY
@ConsultationAutre:
 MOV SI,Offset QuesConsultNewVoiture
 CALL Msg
 CALL LireOuiNon
 CMP AL,'N'
 JE  @FinConsultation
 JMP @Consultation
@FinConsultation:
EndProc

;ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
;³                       Proc‚dure FinJournee                       Û
;ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ
;
;
; Description
; ÍÍÍÍÍÍÍÍÍÍÍ
;
;  Cette proc‚dure permet de sauvegarder les voitures contenu dans le
; parc de voiture et d'en faire par … l'utilisateur.
;
;
; Entr‚e
; ÍÍÍÍÍÍ
;
;  Aucun
;
;
; Sortie
; ÍÍÍÍÍÍ
;
;  Registre d‚truit AX, BX, CX, DX, SI, DI et les drapeaux

FinJournee Proc Near
Local Handle:Byte
 MOV SI,Offset FinJourneeStr
 MOV BL,0
 CALL InitTitre
 MOV SI,Offset SauveMsg
 MOV BX,5
 MOV AH,01Bh
 CALL PutTxtXY
 MOV DI,Offset NomFichier
 CALL DelFile
 CALL NewFile
 CMP AL,errHdl
 JNE @FichierOuvert
 MOV SI,Offset ImpossibleCree
 CALL ErrMsg
 JMP @FinJournee
@FichierOuvert:
 MOV Handle,AL
 _MOV_ES_DS
 MOV DI,Offset InfoParc
 CALL RBSetPtrHome
 MOV CX,InfoParc.NB
@SauveEnreg:
 PUSH CX
  CALL RBGetCurrAuto
  MOV CX,TYPE InfoAuto
  MOV BL,Handle
  MOV SI,Offset TempAuto
  CALL _SetRec
  CALL RBNext
 POP CX
 LOOP @SauveEnreg
 MOV BL,Handle
 CALL CloseFile
@FinJournee:
 MOV SI,Offset PresseUneTouche
 CALL Msg
 CALL ReadKey
EndProc

;ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
;³                         Fonction Presentation                    Û
;ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ
;
;
; Description
; ÍÍÍÍÍÍÍÍÍÍÍ
;
;  Cette affiche un message de pr‚sentation … l'utilisateur et lui
; demande s'il veut continuer. Lorsque l'usager a pris sa d‚cision
; alors la fonction retourne une lettre O ou N.
;
;
; Entr‚e
; ÍÍÍÍÍÍ
;
;  Aucun
;
;
; Sortie
; ÍÍÍÍÍÍ
;
;  Registre d‚truit AX, BX, CX, DX, SI, DI et les drapeaux
;
;
; Retour
; ÍÍÍÍÍÍ
;
;  AL     = O s'il veut continuer le processus
;           N s'il ne veut pas continuer le processus

Presentation Proc Far
 MOV AH,17h
 CALL ClrScr
 MOV AX,0720h
 MOV DX,0+(79 shl 8)
 MOV BL,24
 CALL BarTxtHor
 MOV BL,3
 MOV AH,01Eh
 MOV SI,Offset Pres1
 CALL PutTxtY
 MOV BL,5
 MOV AH,01Fh
 MOV SI,Offset Pres2
 CALL PutTxtY
 MOV BL,7
 MOV SI,Offset Pres3
 CALL PutTxtY
 MOV BL,10
 MOV AH,01Ch
 MOV SI,Offset Pres4
 CALL PutTxtY
 MOV BL,12
 MOV AH,01Fh
 MOV SI,Offset Pres5
 CALL PutTxtY
 MOV BX,15+(2 shl 8)
 MOV SI,Offset Pres6
 CALL PutTxtXY
 INC BX
 MOV SI,Offset Pres7
 CALL PutTxtXY
 INC BX
 INC BX
 MOV SI,Offset Pres8
 CALL PutTxtXY
 INC BX
 MOV SI,Offset Pres9
 CALL PutTxtXY
 MOV SI,Offset Pres10
 CALL Msg
 CALL LireOuiNon
EndProc

;ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
;³                      Proc‚dure LectureFichier                   Û
;ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ
;
;
; Description
; ÍÍÍÍÍÍÍÍÍÍÍ
;
;  Cette proc‚dure permet de lire … partir d'un fichier et de mettre
; le contenu lu dans une liste sym‚trique.
;
;
; Entr‚e
; ÍÍÍÍÍÍ
;
;  Aucun
;
;
; Sortie
; ÍÍÍÍÍÍ
;
;  Registre d‚truit AX, BX, CX, DX, SI, DI et les drapeaux

LectureFichier Proc Near
Local Handle:Byte
 MOV SI,Offset SaisieDonnee
 MOV BL,0
 CALL InitTitre
 MOV SI,Offset EntrezNom
 MOV BX,4
 CALL PutTxtXY
@RedemandeFichier:
 MOV DX,(5 shl 8)+1
 MOV CL,80
 MOV SI,Offset NomFichier
 CALL LireChaine
 CMP Byte Ptr NomFichier,0
 JE  @Continue
 MOV BL,fmRead
 MOV DI,Offset NomFichier
 CALL OpenFile
 CMP AL,errHdl
 JNE @FichierPret
 CALL DelFile
 CALL NewFile
 CMP AL,errHdl
 JNE @FichierPret
 MOV SI,Offset ImpossibleCree
 CALL ErrMsg
 JMP @RedemandeFichier
@FichierPret:
 MOV Handle,AL
 MOV BL,AL
 CALL FileSize
 OR  AX,AX
 JE  @EndFile
 MOV BX,TYPE InfoAuto
 DIV BX
 XCHG AX,CX
 MOV BL,Handle
 CALL Rewind
@ReadAuto:
 PUSH CX
  _MOV_ES_DS
  MOV BL,Handle
  MOV DI,Offset TempAuto
  MOV CX,TYPE InfoAuto
  CALL _GetRec
  _MOV_ES_DS
  MOV DI,Offset InfoParc
  MOV SI,Offset TempAuto
  CALL RBAdd
 POP CX
 LOOP @ReadAuto
@EndFile:
 MOV BL,Handle
 CALL CloseFile
@Continue:
EndProc

;ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
;³                           Proc‚dure AvosRisque                      Û
;ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ
;
;
; Description
; ÍÍÍÍÍÍÍÍÍÍÍ
;
;  Cette proc‚dure lance le programme lui-mˆme. Il s'agit d'un programme
; de gestion de parc de voiture dans le font du rue *perdue.
;
;
; Entr‚e
; ÍÍÍÍÍÍ
;
;  Aucun
;
;
; Sortie
; ÍÍÍÍÍÍ
;
;  Registre d‚truit AX, BX, CX, DX, SI, DI et les drapeaux

@Choix:
DW Offset ArriveeAuto, Offset DepartVoiture, Offset Consultation
DW Offset Information, Offset FinJournee

AvosRisque Proc Far
 MOV AX,3
 INT 10h
 _MOV_ES_DS
 MOV DI,Offset InfoParc
 CALL RBInit
 MOV DI,Offset InfoRue
 CALL RBInit
 CALL Presentation
 CMP  AL,'N'
 JE   @FinAR
@AutreFichier:
 CALL LectureFichier
@AR:
 CALL Menu
 PUSH AX
  XCHG AX,BX
  XOR BH,BH
  SUB BL,'1'
  SHL BX,1
  CALL Word Ptr @Choix[BX]
 POP AX
 CMP AL,'5'
 JNE @AR
 _MOV_ES_DS
 MOV DI,Offset InfoParc
 CALL RBDone
 MOV DI,Offset InfoRue
 CALL RBDone
 MOV SI,Offset AutreFichier
 CALL Msg
 CALL LireOuiNon
 CMP AL,'O'
 JE  @AutreFichier
@FinAR:
 MOV AX,3
 INT 10h
EndProc

code ends
end