{PushKey.Inc}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                 Malte Genesis/BibliothŠque individuel                 Û
 ³                    dition Chantal/IV - Version 1.1                   Û
 ³                             1997/04/01                                Û
 ³                                                                       Û
 ³         Tous droits r‚serv‚s par les Chevaliers de Malte (C)          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Nom des programmeurs
 ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

  Sylvain Maltais


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette inclusion vise  … permettre une universialisation des donn‚es …
 compiler  ind‚pendament  des conditions  sous  lequel  la fonction est
 traŒter.  En centralisant toutes les proc‚dures au mˆme point central,
 on aboutira une technique de ®Croiser¯, celle-ci permet d'‚liminer les
 bugs par le raisonnement suivant:Maintenant sa fonctionne parfaitement
 ou sa plante comme jamais avant...
}

{$IFNDEF __PushKey}
 {$DEFINE __PushKey}

(*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                            Proc‚dure PushKey                           Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette proc‚dure permet d'ins‚rer un code clavier (scan) et son code ASCII
  dans le tampon clavier du BIOS peuvant ˆtre extrait par l'interruption 16h
  ou 21h par exemple.


  Remarque
  ÍÍÍÍÍÍÍÍ

   ş Voici le listing de cette proc‚dure en langage Pascal:
     ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
     ³ Procedure PushKey(K:Word);Begin                                     ³
     ³  Inline($FA); { CLI; }                                              ³
     ³  MemW[$0040:MemW[$0040:$1C]]:=K;                                    ³
     ³  Inc(MemW[$0040:$1C],2);                                            ³
     ³  If MemW[$0040:$1C]=MemW[$0040:$82]Then                             ³
     ³    MemW[$0040:$1C]:=MemW[$0040:$80];                                ³
     ³  Inline($FB); { STI; }                                              ³
     ³ End;                                                                ³
     ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

     Voici sa liste en langage C/C++:
     ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
     ³ #include <mem.h>                                                    ³
     ³ #include <dos.h>                                                    ³
     ³                                                                     ³
     ³ void PushKey(unsigned int K){                                       ³
     ³  disable();                                                         ³
     ³  poke(0x0040,peek(0x0040,0x1C),K);                                  ³
     ³  poke(0x0040,0x1C,peek(0x0040,0x1C)+2);                             ³
     ³  if(peek(0x0040,0x1C)=peek(0x0040,0x82))                            ³
     ³  poke(0x0040,0x1C,peek(0x0040,0x80));                               ³
     ³  enable();                                                          ³
     ³ }                                                                   ³
     ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
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