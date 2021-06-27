;**********************************************************************;
;*                             S O U R I S P A                        *;
;*--------------------------------------------------------------------*;
;*    Fonction       : Gestionnaire d'‚v‚nements appel‚ par le driver *;
;*                     de la souris. A int‚grer dans un programme TP  *;
;*--------------------------------------------------------------------*;
;*    Auteur         : MICHAEL TISCHER                                *;
;*    D‚velopp‚ le   : 21/04/1989                                     *;
;*    DerniŠre modif.: 21/04/1989                                     *;
;*--------------------------------------------------------------------*;
;*    Assemblage     : MASM /MX SOURISPA;   ou                        *;
;*                     TASM -MX SOURISPA;                             *;
;*                     ... combiner avec le programme PASCAL SOURISP  *;
;**********************************************************************;

;== Segment de donn‚es =================================================

DATA   segment word public
DATA   ends                          ;Pas de variables dans ce programme

;== Programme ==========================================================

CODE   segment byte public                      ;Le segment de programme

       assume CS:CODE      ;CS d‚signe le segment de code, le contenu de
                                               ;DS, SS et ES est inconnu

public     AssHand              ;Donne au programme TP la possibilit‚ de
                                   ;d‚terminer l'adresse du gestionnaire
                                                          ;en assembleur

extrn     MouEventHandler : near ;Le driver d'‚v‚nements en TP … appeler

actif     db  0           ;Indique si un appel est actuellement en cours
                                                            ;d'ex‚cution

;-----------------------------------------------------------------------
;-- AssHand : Le gestionnaire d'‚v‚nements qui est d'abord appel‚ par le
;--           driver de la souris et appelle alors … son tour la
;--           proc‚dure Turbo Pascal MouEventHandler
;-- Appel en TP : interdit !


AssHand    proc far
;- Sauvegarder tout d'abord tous les registres du processeur sur la pile

           cmp  actif,0                      ;Appel non encore termin‚ ?
           jne  fin                    ;Non --> ne pas permettre l'appel

           mov  actif,1                      ;Ne plus autoriser d'appels

           push ax
           push bx
           push cx
           push dx
           push di
           push si
           push bp
           push es
           push ds

          ;-- Placer sur la pile les arguments pour l'appel de la ------
                                                         ;-- fonction TP
                                                             ;-- Appel :
           ;--   MouEventHandler (EvFlags, ButStatus, x , y : integer );

           push ax                ;Placer flags d'‚v‚nements sur la pile
	   push bx            ;Etat des boutons de la souris sur la pile

           mov  di,cx               ;Ranger ordonn‚e horizontale dans DI
           mov  cl,3    ;Compteur de d‚calages pour num‚ro de coordonn‚e

           shr  di,cl           ;Diviser DI (ordonn‚e horizontale) par 8
           push di                                ;et placer sur la pile

           shr  dx,cl             ;Diviser DX (ordonn‚e verticale) par 8
           push dx                                ;et placer sur la pile

           mov  ax,DATA            ;Placer adresse de segment du segment
           mov  ds,ax   ;de donn‚es dans AX et de l… dans le registre DS

           call  MouEventHandler               ;Appel de la proc‚dure TP

           ;-- Retirer de la pile les registres sauvegard‚s ------------

           pop  ds
           pop  es
           pop  bp
           pop  si
           pop  di
           pop  dx
           pop  cx
           pop  bx
           pop  ax

           mov  actif,0                        ;Appel … nouveau autoris‚

fin:       ret                            ;Retour au driver de la souris

AssHand    endp

;-----------------------------------------------------------------------

CODE       ends                                  ;Fin du segment de code
           end                                         ;Fin du programme
