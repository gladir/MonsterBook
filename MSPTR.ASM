;********************************************************
;*                                                      *
;*                 Malte Genesis/Mouse                  *
;*           Phoenix Edition for Real Mode Only         *
;*                   II - Version 1.8                   *
;*                      1994/12/29                      *
;*                                                      *
;*      Copyiright (C) par les Chevaliers de Malte      *
;*                                                      *
;********************************************************

DATA   segment word public
DATA   ends

CODE   segment byte public

       assume CS:CODE


public     GAssHand
extrn      GMouEventHandler:Near

actif     db  0

GAssHand   proc far

           cmp  actif,0
           jne  fin
           mov  actif,1
           push ax
           push bx
           push cx
           push dx
           push di
           push si
           push bp
           push es
           push ds

           push ax
           push bx
           mov  di,cx
           push di
           push dx
           mov  ax,DATA
           mov  ds,ax
           call GMouEventHandler

           pop  ds
           pop  es
           pop  bp
           pop  si
           pop  di
           pop  dx
           pop  cx
           pop  bx
           pop  ax

           mov  actif,0

fin:       ret

GAssHand   endp

CODE       ends
           end