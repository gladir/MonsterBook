{PackTime.Inc}

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

{$IFNDEF __PackTime}
 {$DEFINE __PackTime}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Proc‚dure PackTime                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet  de passer  de la forme longue de la date  et de
 l'heure directement lisible, … la forme courte utilis‚, par exemple, par
 la proc‚dure  ®SetFTime¯.  Le  paramŠtre  ®T¯  est  doit  ˆtre  de  type
 ®DateTime¯ pr‚d‚fini par l'unit‚ ®Dos¯ ou ®Systex¯.
}

Procedure PackTime(Var T:DateTime;Var P:LongInt);Assembler;ASM
 {$IFDEF FLAT386}
 {$ELSE}
  PUSH DS
   LDS SI,T
   CLD
   LODSW
   SUB AX,1980
   {$IFOPT G+}
    SHL AX,9
   {$ELSE}
    MOV CL,9
    SHL AX,CL
   {$ENDIF}
   XCHG AX,DX
   {$IFDEF DosUnit}
    LODSW
   {$ELSE}
    LODSB
    XOR AH,AH
   {$ENDIF}
   {$IFOPT G+}
    SHL AX,5
   {$ELSE}
    MOV CL,5
    SHL AX,CL
   {$ENDIF}
   ADD DX,AX
   {$IFDEF DosUnit}
    LODSW
   {$ELSE}
    LODSB
    XOR AH,AH
   {$ENDIF}
   ADD DX,AX
   {$IFDEF DosUnit}
    LODSW
   {$ELSE}
    LODSB
   {$ENDIF}
   {$IFOPT G+}
    SHL AX,11
   {$ELSE}
    MOV CL,11
    SHL AX,CL
   {$ENDIF}
   XCHG AX,BX
   {$IFDEF DosUnit}
    LODSW
   {$ELSE}
    LODSB
    XOR AH,AH
   {$ENDIF}
   {$IFOPT G+}
    SHL AX,5
   {$ELSE}
    MOV CL,5
    SHL AX,CL
   {$ENDIF}
   ADD BX,AX
   {$IFDEF DosUnit}
    LODSW
   {$ELSE}
    LODSB
   {$ENDIF}
   SHR AX,1
   ADD AX,BX
  POP DS
  LES DI,P
  STOSW
  XCHG AX,DX
  STOSW
 {$ENDIF}
END;

{$ENDIF}