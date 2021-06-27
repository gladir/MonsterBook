{GetIntVec.Inc}

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

{$IFNDEF __GetIntVec}
 {$DEFINE __GetIntVec}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Fonction GetIntVec                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction  retourne  l'adresse  de l'interruption d‚finit  par la
 variable de param‚trage ®IntNo¯ dans le vecteur d‚finit par la variable
 de param‚trage ®Vector¯.

 Remarque
 ÍÍÍÍÍÍÍÍ

  ş Voici sa forme en langage Pascal en mode r‚el:
    ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
    ³ Procedure GetIntVec(IntNo:Byte;Var Vector:Pointer);              ³
    ³ Type TableIntRec=Array[0..255]of Pointer;                        ³
    ³ Var TableInt:TableIntRec Absolute$0000:$0000;                    ³
    ³ Begin                                                            ³
    ³  Inline($FA); (* CLI; *)                                         ³
    ³  Vector:=TableInt[IntNo];                                        ³
    ³  Inline($FB); (* STI; *)                                         ³
    ³ End;                                                             ³
    ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
}

Procedure GetIntVec(IntNo:Byte;Var Vector:Pointer);Assembler;ASM
 {$IFDEF FLAT386}
  AND EAX,0FFh
  SHL EAX,2
  MOV EAX,[EAX]
  MOV [EDX],EAX
 {$ELSE}
  {$IFDEF DPMI}
   MOV AL,IntNo
   MOV AH,$35
   INT $21
   MOV AX,ES
   LES DI,Vector
   CLD
   XCHG AX,BX
   STOSW
   XCHG AX,BX
   STOSW
  {$ELSE}
   XOR BX,BX
   MOV ES,BX
   MOV BL,IntNo
   {$IFDEF __286__}
    DB $C1,$E3,$02   { SHL BX,2 }
   {$ELSE}
    {$IFOPT G+}
     SHL BX,2
    {$ELSE}
     SHL BX,1
     SHL BX,1
    {$ENDIF}
   {$ENDIF}
   CLI
   {$IFDEF __386__}
    DB $26,$66,$8B,$07 { MOV EAX,ES:[BX] }
   {$ELSE}
    MOV AX,ES:[BX]   { Vector.Ofs := MemW[0:IntNo shl 2] }
    MOV DX,ES:[BX+2] { Vector.Seg := MemW[0:(IntNo shl 2)+2] }
   {$ENDIF}
   STI
   LES DI,Vector
   {$IFDEF __386__}
    {$IFDEF SlomoXtrk}
     DB $26,$66,$89,$05 { MOV ES:[DI],EAX }
    {$ELSE}
     CLD
     DW ciSTOSD
    {$ENDIF}
   {$ELSE}
    {$IFDEF SlomoXtrk}
     MOV ES:[DI],AX
     MOV ES:[DI+2],DX
    {$ELSE}
     CLD
     STOSW
     XCHG AX,DX
     STOSW
    {$ENDIF}
   {$ENDIF}
  {$ENDIF}
 {$ENDIF}
END;

{$ENDIF}