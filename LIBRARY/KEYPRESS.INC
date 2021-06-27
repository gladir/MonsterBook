{KeyPress.Inc}

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

{$IFNDEF __KeyPress}
 {$DEFINE __KeyPress}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                              Fonction KeyPress                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction retourne la valeur True si le tampon clavier … au moins une
 touche en r‚serve et dans le cas contraire False.


 Remarque
 ÍÍÍÍÍÍÍÍ

   ş Voici son code en langage Pascal s'il s'agit du mode r‚el:
    ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
    ³ Function Keypressed:Boolean;                                         ³
    ³ Begin                                                                ³
    ³  Inline($FA); (* CLI *)                                              ³
    ³  Keypressed:=MemW[$0040:$1A]<>MemW[$0040:$1C];                       ³
    ³  Inline($FB); (* STI *)                                              ³
    ³ End;                                                                 ³
    ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
}

Function KeyPress:Boolean;Assembler;ASM
 {$IFDEF Dos}
  MOV AH,0Bh
  INT 21h
  AND AL,1
 {$ELSE}
  {$IFDEF Bios}
   MOV AX,1
   INT $16
   MOV AL,No
   JZ  @@End
   MOV AL,Ya
  {$ELSE}
   {$IFDEF DPMI}
    XOR AX,AX
    MOV ES,Seg0040
    MOV DX,ES:[1Ah]
    MOV BX,ES:[1Ch]
   {$ELSE}
    XOR AX,AX
    MOV ES,AX
    {$IFNDEF NoCLI}
     CLI
    {$ENDIF}
    LES DX,ES:[41Ah]
    {$IFNDEF NoCLI}
     STI
    {$ENDIF}
    MOV BX,ES
   {$ENDIF}
   CMP BX,DX
   JE  @@End
   MOV AL,True
  {$ENDIF}
 {$ENDIF}
@@End:
END;

{$ENDIF}