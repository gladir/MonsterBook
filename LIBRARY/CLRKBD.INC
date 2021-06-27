{ClrKbd.Inc}

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

{$IFNDEF __ClrKbd}
 {$DEFINE __ClrKbd}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure ClrKbd                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure efface tous les caractŠres en attente dans le tampon
 clavier sans exception.


 Remarques
 ÍÍÍÍÍÍÍÍÍ

   ş Cette proc‚dure n'utilise  que des accŠs directe en m‚moire et en
     aucune fa‡on par le Bios ou le Dos. Elle est donc rapide mais pas
     n‚cessairement  compatible  avec les plus  que vieille machine du
     d‚but des ann‚es 1980.

   ş Cette proc‚dure est id‚al pour des op‚rations du genre:®Etes-vous
     certain de... ?¯.  Car l'utilisateur n'aurait pas … affronter une
     tape par erreur pr‚c‚demment enregistrer...
}

{$IFNDEF NoVoid}Procedure ClrKbd;{$ENDIF}Assembler;ASM
 {$IFDEF Dos}
@1:
  MOV AH,0Bh
  INT 21h
  OR  AL,AL
  JE  @End
  MOV AH,08h
  INT 21h
  JMP @1
@@End:
 {$ELSE}
  {$IFDEF Bios}
@1:MOV AX,1
   INT 16h
   JZ  @@End
   XOR AX,AX
   INT 16h
   JMP @1
@@End:
  {$ELSE}
   {$IFDEF DPMI}
    PUSH Seg0040
    POP ES
    PUSHF
     CLI
     MOV AX,ES:[80h]
     MOV ES:[1Ch],AX
     MOV ES:[1Ah],AX
   {$ELSE}
    XOR AX,AX
    MOV ES,AX
    PUSHF
     CLI
     MOV AX,ES:[480h]
     MOV ES:[41Ah],AX
     MOV ES:[41Ch],AX
   {$ENDIF}
   POPF
  {$ENDIF}
 {$ENDIF}
END;

{$ENDIF}