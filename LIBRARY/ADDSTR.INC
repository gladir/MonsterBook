{AddStr.Inc}

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

{$IFNDEF __AddStr}
 {$DEFINE __AddStr}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Proc‚dure AddStr                           Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction concatŠne une chaŒne de caractŠres ®Add¯ … une chaŒne de
 caractŠres source ®S¯.Cette proc‚dure ‚quivaut … l'op‚ration ®S:=S+Add¯.
}

Procedure AddStr(Var S:String;Const Add:String);
{$IFDEF __386__}
 Begin
  S:=S+Add;
 End;
{$ELSE}
 {$IFDEF NoAsm}
  Begin S:=S+Add;End;
 {$ELSE}
  Assembler;ASM
   PUSH DS
    LES DI,S
    LDS SI,Add
    MOV BL,ES:[DI]
    XOR BH,BH
    MOV CL,DS:[SI]
    XOR CH,CH
    MOV DX,BX
    ADD DX,CX
    OR  DH,DH
    JE  @NoTrunc
    MOV CX,255
    MOV DX,CX
    SUB CX,BX
 @NoTrunc:
    MOV ES:[DI],DL
    ADD DI,BX
    INC DI
    INC SI
    CLD
    SHR CX,1
    REP MOVSW
    ADC CX,CX
    REP MOVSB
   POP DS
  END;
 {$ENDIF}
{$ENDIF}

{$ENDIF}