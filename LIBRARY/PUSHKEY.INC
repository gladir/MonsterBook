{PushKey.Inc}

{�������������������������������������������������������������������������
 �                 Malte Genesis/Biblioth�que individuel                 �
 �                    �dition Chantal/IV - Version 1.1                   �
 �                             1997/04/01                                �
 �                                                                       �
 �         Tous droits r�serv�s par les Chevaliers de Malte (C)          �
 �������������������������������������������������������������������������


 Nom des programmeurs
 ��������������������

  Sylvain Maltais


 Description
 �����������

  Cette inclusion vise  � permettre une universialisation des donn�es �
 compiler  ind�pendament  des conditions  sous  lequel  la fonction est
 tra�ter.  En centralisant toutes les proc�dures au m�me point central,
 on aboutira une technique de �Croiser�, celle-ci permet d'�liminer les
 bugs par le raisonnement suivant:Maintenant sa fonctionne parfaitement
 ou sa plante comme jamais avant...
}

{$IFNDEF __PushKey}
 {$DEFINE __PushKey}

(*��������������������������������������������������������������������������
  �                            Proc�dure PushKey                           �
  ��������������������������������������������������������������������������


  Description
  �����������

   Cette proc�dure permet d'ins�rer un code clavier (scan) et son code ASCII
  dans le tampon clavier du BIOS peuvant �tre extrait par l'interruption 16h
  ou 21h par exemple.


  Remarque
  ��������

   � Voici le listing de cette proc�dure en langage Pascal:
     ���������������������������������������������������������������������Ŀ
     � Procedure PushKey(K:Word);Begin                                     �
     �  Inline($FA); { CLI; }                                              �
     �  MemW[$0040:MemW[$0040:$1C]]:=K;                                    �
     �  Inc(MemW[$0040:$1C],2);                                            �
     �  If MemW[$0040:$1C]=MemW[$0040:$82]Then                             �
     �    MemW[$0040:$1C]:=MemW[$0040:$80];                                �
     �  Inline($FB); { STI; }                                              �
     � End;                                                                �
     �����������������������������������������������������������������������

     Voici sa liste en langage C/C++:
     ���������������������������������������������������������������������Ŀ
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
     �����������������������������������������������������������������������
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