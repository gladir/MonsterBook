{PushKey.Inc}

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

{$IFNDEF __PushKey}
 {$DEFINE __PushKey}

(*旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴콘
  �                            Proc괺ure PushKey                           �
  잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複蔔


  Description
  袴袴袴袴袴�

   Cette proc괺ure permet d'ins굍er un code clavier (scan) et son code ASCII
  dans le tampon clavier du BIOS peuvant 늯re extrait par l'interruption 16h
  ou 21h par exemple.


  Remarque
  袴袴袴袴

   � Voici le listing de cette proc괺ure en langage Pascal:
     旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
     � Procedure PushKey(K:Word);Begin                                     �
     �  Inline($FA); { CLI; }                                              �
     �  MemW[$0040:MemW[$0040:$1C]]:=K;                                    �
     �  Inc(MemW[$0040:$1C],2);                                            �
     �  If MemW[$0040:$1C]=MemW[$0040:$82]Then                             �
     �    MemW[$0040:$1C]:=MemW[$0040:$80];                                �
     �  Inline($FB); { STI; }                                              �
     � End;                                                                �
     읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

     Voici sa liste en langage C/C++:
     旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
     � #include <mem.h>                                                    �
     � #include <dos.h>                                                    �
     �                                                                     �
     � void PushKey(unsigned int K){                                       �
     �  disable();                                                         �
     �  poke(0x0040,peek(0x0040,0x1C),K);                                  �
     �  poke(0x0040,0x1C,peek(0x0040,0x1C)+2);                             �
     �  if(peek(0x0040,0x1C)=peek(0x0040,0x82))                            �
     �  poke(0x0040,0x1C,peek(0x0040,0x80));                               �
     �  enable();                                                          �
     � }                                                                   �
     읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
*)

Procedure PushKey(K:Word);Assembler;ASM
 {$IFDEF FLAT386}
 {$ELSE}
  {$IFDEF Bios}
   MOV AX,$0005
   MOV CX,K
   INT $16
  {$ELSE}
   {$IFDEF DPMI}
    MOV ES,Seg0040
   {$ELSE}
    MOV AX,$0040
    MOV ES,AX
   {$ENDIF}
   {$IFDEF ProtectedInterrupt}
    PUSHF
    CLI
   {$ELSE}
    CLI
   {$ENDIF}
   MOV BX,ES:[001Ch]
   MOV AX,K
   MOV ES:[BX],AX
   INC BX
   INC BX
   MOV ES:[$1C],BX
   MOV AX,ES:[0082h]
   CMP AX,BX
   JNE @@End
   MOV AX,ES:[0080h]
   MOV ES:[001Ch],AX
  @@End:
   {$IFDEF ProtectedInterrupt}
    POPF
   {$ELSE}
    STI
   {$ENDIF}
  {$ENDIF}
 {$ENDIF} 
END;

{$ENDIF}