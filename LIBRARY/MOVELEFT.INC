{MoveLeft.Inc}

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

{$IFNDEF __MoveLeft}
 {$DEFINE __MoveLeft}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Proc‚dure MoveLeft                            Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure copie un bloc de m‚moire (Source) dans le bloc destinataire
 (Dest). La longueur de ce bloc est sp‚cifi‚ par la variable ®Count¯.
}

Procedure MoveLeft(Const Source;Var Dest;Count:Word);Assembler;ASM
 {$IFDEF FLAT386}
  OR EDX,EDX
  JZ @@End
  OR EAX,EAX
  JZ @@End
  PUSH ESI
   PUSH EDI
    MOV ESI,EAX
    MOV EDI,EDX
    MOV EAX,ECX
    CMP EDI,ESI
    JG  @@down
    JE  @@exit
    SAR ECX,2
    JS  @@exit
    REP MOVSD
    MOV ECX,EAX
    AND ECX,03H
    REP MOVSB
    JMP @@exit
@@down:
    LEA ESI,[ESI+ECX-4]
    LEA EDI,[EDI+ECX-4]
    SAR ECX,2
    JS  @@exit
    STD
    REP MOVSD
    MOV ECX,EAX
    AND ECX,03H
    ADD ESI,4-1
    ADD EDI,4-1
    REP MOVSB
    CLD
@@exit:
   POP EDI
  POP ESI
@@End:
 {$ELSE}
  CLD
  PUSH DS
   LDS SI,Source
   LES DI,Dest
   MOV CX,Count
   {$IFDEF __386__}
    MOV BX,CX
    AND BX,3
    {$IFOPT G+}
     SHR CX,2
    {$ELSE}
     DB 0C1h,0E9h,02h { SHR CX,2 }
    {$ENDIF}
    DB  ciREP; DW ciMOVSD
    XCHG CX,BX
    REP MOVSB
   {$ELSE}
     { Transfert 16 bits...}
    SHR CX,1
    REP MOVSW
    ADC CX,CX
    REP MOVSB
   {$ENDIF}
  POP DS
 {$ENDIF}
END;

{$ENDIF}