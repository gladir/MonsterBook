{\Source\Chantal\RLL\Video\SetBnkPg.Inc}

{ Nom du programmeur
  ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

   Joseph Gabriel Sylvain Maltais


  Adaptation
  ÍÍÍÍÍÍÍÍÍÍ

   þ Vendredi 13 ao–t 1999,  dit: ®The Furor, Resurrection  and Live after
     Death¯.  En  raison  du  triste  anniversaire de la  perte de donn‚es
     majeur de l'ensemble Genesis et  reconstruit avec une fureur certaine
     de ne pas mourir … cause d'une d‚faillance mat‚riel!
}

Procedure SetBnkPg;Assembler;ASM
 PUSHF
 CLI
 MOV AL,Pg
 CMP AL,0FFh
 JE  @GetBnkPg
 CMP AL,Byte Ptr @OldBnkPg
 JE @End
@ReStart:
 NOP
 NOP
 NOP
 NOP
 NOP
 PUSH BX
  MOV BX,PhysVideo.PIV.ProcSelBnkPg
{   CMP BX,15
   JNE @Next
    ...
@Next:}
  SHL BX,1
  MOV BX,CS:[Offset @SetPgAddr+BX]
  MOV CS:[@ReStart].Byte,0EAh
  MOV Word Ptr CS:[@ReStart][1],BX
  MOV Word Ptr CS:[@ReStart][3],CS
  PUSH ES
   PUSH DI
    PUSH CX
     PUSH AX
      CMP PhysVideo.PIV.ProcSelBnkPg,15
      JNE @SkipVesaDirect
      MOV AX,4F03h
      INT 10h
      OR  AH,AH
      JNE @SkipVesaDirect
      SUB SP,200h
      PUSH SS
      POP ES
      XCHG BX,CX
      MOV DI,SP
      MOV AX,4F01h
      INT 10h
      OR  AH,AH
      JNE @VesaDirectFail
      LES DI,DWord Ptr ES:[DI+0Ch]
      MOV Word Ptr CS:@FastVesa1,DI
      MOV Word Ptr CS:@FastVesa2,DI
      MOV Word Ptr CS:@FastVesa1[2],ES
      MOV Word Ptr CS:@FastVesa2[2],ES
      MOV Word Ptr CS:[@ReStart][1],Offset @SelBnkPgVesaDirect
@VesaDirectFail:
      ADD SP,200h
@SkipVesaDirect:
     POP AX
    POP CX
   POP DI
  POP ES
 POP BX
 JMP @ReStart
 DB  0FFh,027h { $2E JMP CS:[BX]}
@SelBnkPgVGA:
  { MOV AL,2
  MOV AH,Pg
  MOV DX,$3C4
  OUT DX,AX}
 JMP @1
@SelBnkPgVesaDirect:
 {$IFDEF __386__}DB 66h{$ENDIF}PUSH SI
  {$IFDEF __386__}DB 66h{$ENDIF}PUSH CX
   {$IFDEF __386__}DB 66h{$ENDIF}PUSH ES
    {$IFDEF __386__}DB 66h{$ENDIF}PUSH DI
     {$IFDEF __386__}DB 66h{$ENDIF}PUSH BX
      MOV DL,AL
      XOR BX,BX
      XOR DH,DH
      PUSH DX
       DB 9Ah
@FastVesa1:
       DW 0
       DW 0
      POP DX
      MOV BX,1
      DB 9Ah
@FastVesa2:
      DW 0
      DW 0
     {$IFDEF __386__}DB 66h{$ENDIF}POP BX
    {$IFDEF __386__}DB 66h{$ENDIF}POP DI
   {$IFDEF __386__}DB 66h{$ENDIF}POP ES
  {$IFDEF __386__}DB 66h{$ENDIF}POP CX
 {$IFDEF __386__}DB 66h{$ENDIF}POP SI
 JMP @1
@SelBnkPgAhead:
 PUSH BX
 AND AL,00Fh
 MOV DX,03CEh
 XCHG BL,AL
 IN  AL,DX
 XCHG BL,AL
 MOV AH,AL
 {$IFOPT G+}SHL AL,4{$ELSE}SHL AL,1;SHL AL,1;SHL AL,1;SHL AL,1{$ENDIF}
 OR  AH,AL
 MOV AL,00Dh
 OUT DX,AX
 XCHG AL,BL
 OUT DX,AL
 POP BX
 JMP @1
@SelBnkPgATI:
 PUSH ES
  MOV ES,PhysVideo.PIV.ROM
  MOV DX,ES:[010h]
 POP ES
 MOV AL,0B2h
 OUT DX,AL
 INC DL
 IN  AL,DX
 AND AL,0E1h
 MOV AH,Pg
 AND AH,7
 SHL AH,1
 OR  AH,AL
 MOV AL,0B2h
 INC DL
 OUT DX,AX
 JMP @1
@SelBnkPgCirrus:
 PUSH BX
 MOV AH,AL
 MOV DX,03CCh
 IN  AL,DX
 AND AL,NOT 020h
 AND AH,2
 {$IFOPT G+}SHL AH,4{$ELSE}SHL AH,1;SHL AH,1;SHL AH,1;SHL AH,1{$ENDIF}
 OR  AL,AH
 MOV DX,03C2h
 OUT DX,AL
 MOV DX,03C4h
 MOV AL,0F9h
 MOV AH,Pg
 AND AH,1
 OUT DX,AX
 MOV AL,0F6h
 OUT DX,AL
 INC DX
 IN  AL,DX
 AND AL,0F0h
 MOV BL,Pg
 AND BL,00Ch
 MOV BH,BL
 {$IFOPT G+}SHR BL,2{$ELSE}SHR BL,1;SHR BL,1{$ENDIF}
 OR  AL,BH
 OR  AL,BL
 OUT DX,AL
 POP BX
 JMP @1
@SelBnkPgCTI:
{ MOV AL,2;
  MOV AH,Pg;
  MOV DX,$3C4;
  OUT DX,AX;}
 JMP @1
@SelBnkPgEverex:
 MOV BL,AL
 MOV DX,03C4h
 MOV AL,00Bh
 OUT DX,AL
 INC DL
 IN  AL,DX
 DEC DL
 MOV AL,00Eh
 OUT DX,AL
 INC DL
 IN  AL,DX
 AND AL,0F0h
 MOV AH,BL
 AND AH,00Fh
 OR  AL,AH
 XOR AL,2
 OUT DX,AL
 JMP @1
@SelBnkPgGenoa:
 AND AL,7
 MOV AH,AL
 {$IFOPT G+}SHL AL,3{$ELSE}SHL AL,1;SHL AL,1;SHL AL,1{$ENDIF}
 OR  AH,AL
 MOV DX,03C4h
 MOV AL,6
 OUT DX,AL
 INC DX
 IN  AL,DX
 AND AL,080h
 OR  AL,040h
 OR  AL,AH
 OUT DX,AL
 JMP @1
@SelBnkPgHeadland:
 PUSH BX
  MOV DX,03CCh
  IN  AL,DX
  AND AL,NOT(020h)
  AND AH,2
  {$IFOPT G+}SHL AH,4{$ELSE}SHL AH,1;SHL AH,1;SHL AH,1;SHL AH,1{$ENDIF}
  OR  AL,AH
  MOV DL,0C2h
  OUT DX,AL
  MOV DL,0C4h
  MOV AL,0F9h
  MOV AH,Pg
  AND AH,1
  OUT DX,AX
  MOV AL,0F6h
  OUT DX,AL
  INC DX
  IN  AL,DX
  AND AL,0F0h
  MOV BL,Pg
  AND BL,00Ch
  MOV BH,BL
  {$IFOPT G+}SHR BL,2{$ELSE}SHR BL,1;SHR BL,1{$ENDIF}
  OR  AL,BH
  OR  AL,BL
  OUT DX,AL
 POP BX
 JMP @1
@SelBnkPgOak:
 AND AL,15
 MOV AH,AL
 {$IFOPT G+}SHL AL,4{$ELSE}SHL AL,1;SHL AL,1;SHL AL,1;SHL AL,1{$ENDIF}
 OR  AL,AH
 MOV DX,3DFh
 OUT DX,AL
 JMP @1
@SelBnkPgParadise:
 MOV AH,AL
 MOV DX,03CDh
 AND AH,0Fh
 MOV AL,AH
 {$IFOPT G+}SHL AH,4{$ELSE}SHL AH,1;SHL AH,1;SHL AH,1;SHL AH,1{$ENDIF}
 OR  AL,AH
 OUT DX,AL
 JMP @1
@SelBnkPgSTB:
{ MOV AL,2
  MOV AH,Pg
  MOV DX,$3C4
  OUT DX,AX}
 JMP @1
@SelBnkPgTrident:
 AND AL,7
 MOV AH,AL
 XOR AH,02h
 MOV DX,03C4h
 MOV AL,$0E
 OUT DX,AL
 INC DX
 IN  AL,DX
 AND AL,$F0
 OR  AL,AH
 OUT DX,AL
 JMP @1
@SelBnkPgTsengET3000:
 MOV DX,03CDh
 AND AL,7
 MOV AH,AL
 {$IFOPT G+}SHL AH,3{$ELSE}SHL AH,1;SHL AH,1;SHL AH,1{$ENDIF}
 OR  AL,AH
 OR  AL,040h
 OUT DX,AL
 JMP @1
@SelBnkPgTsengET4000:
 MOV AH,AL
 MOV DX,03CDh
 AND AH,00Fh
 MOV AL,AH
 {$IFOPT G+}SHL AH,4{$ELSE}SHL AH,1;SHL AH,1;SHL AH,1;SHL AH,1{$ENDIF}
 OR  AL,AH
 OUT DX,AL
 JMP @1
@SelBnkPgVesa:
 PUSH BX
  MOV DL,AL
  MOV AX,04F05h
  XOR BX,BX
  XOR DH,DH
  PUSH DX
   INT 010h
  POP DX
  MOV AX,04F05h
  MOV BX,1
  INT 010h
 POP BX
 JMP @1
@SelBnkPgVideo7:
 PUSH BX
  MOV DX,$3CC
  IN  AL,DX
  AND AL,Not($20)
  MOV AH,Pg
  AND AH,2
  {$IFOPT G+}SHL AH,4{$ELSE}SHL AH,1;SHL AH,1;SHL AH,1;SHL AH,1{$ENDIF}
  OR  AL,AH
  MOV DL,$C2
  OUT DX,AL
  INC DX
  INC DX
  MOV AL,$F9
  MOV AH,Pg
  AND AH,1
  OUT DX,AX
  MOV AL,$F6
  OUT DX,AL
  INC DX
  IN  AL,DX
  AND AL,0F0h
  MOV BL,Pg
  AND BL,$0C
  MOV BH,BL
  {$IFOPT G+}SHR BL,2{$ELSE}SHR BL,1;SHR BL,1{$ENDIF}
  OR  AL,BH
  OR  AL,BL
  OUT DX,AL
 POP BX
 JMP @1
@SelBnkPgXGA:
  { MOV AL,2;
  MOV AH,Pg;
  MOV DX,$3C4;
  OUT DX,AX;}
 JMP @1
@SelBnkPgZymos:
  { MOV AL,2;
  MOV AH,Pg;
  MOV DX,$3C4;
  OUT DX,AX;}
 JMP @1
@SelBnkPgAheadA:
 PUSH CX
  MOV CH,AL
  MOV DX,3CEh
  MOV AX,200Fh
  OUT DX,AX
  MOV DL,0CCh
  IN  AL,DX
  MOV DL,0C2h
  AND AL,11011111b
  SHR CH,1
  JNC @skpa
  OR  AL,00100000b
@skpa:OUT DX,AL
  MOV DL,0CFh
  MOV AL,0
  OUT DX,AL
  INC DX
  IN  AL,DX
  DEC DX
  AND AL,11111000b
  OR  AL,CH
  MOV AH,AL
  MOV AL,0
  OUT DX,AX
 POP CX
 JMP @1
@SelBnkPgAheadB:
 PUSH CX
  MOV AH,AL
  MOV CH,AL
  MOV DX,3CEh
  MOV AX,200Fh
  OUT DX,AX
  MOV AH,CH
  MOV CL,4
  SHL AH,CL
  OR  AH,CH
  MOV AL,0Dh
  OUT DX,AX
 POP CX
 JMP @1
@SelBnkPgATI_GNU:
 MOV AH,AL
 AND AH,07h
 {$IFOPT G+}ROR AH,3{$ELSE}ROR AH,1;ROR AH,1;ROR AH,1{$ENDIF}
 AND AL,07h
 SHL AL,1
 OR  AH,AL
 MOV DX,01CEh
 MOV AL,0B2h
 OUT DX,AX
 JMP @1
@SelBnkPgChips:
 PUSH CX
  MOV AH,AL
  MOV CX,AX
  MOV DX,46E8h
  MOV AX,1Eh
  OUT DX,AX
  MOV DX,103h
  MOV AX,0080h
  OUT DX,AX
  MOV DX,46E8h
  MOV AX,0Eh
  OUT DX,AX
  MOV AH,CL
  {$IFOPT G+}SHL AH,2{$ELSE}SHL AH,1;SHL AH,1{$ENDIF}
  MOV AL,10h
  MOV DX,3D6h
  OUT DX,AX
 POP CX
 JMP @1
@SelBnkPgTrident89:
 PUSH CX
  MOV AH,AL
  MOV CX,AX
  MOV DX,3CEh
  MOV AL,6
  OUT DX,AL
  INC DL
  IN  AL,DX
  DEC DL
  OR  AL,4
  MOV AH,AL
  MOV AL,6
  OUT DX,AL
  INC DX
  XCHG AH,AL
  OUT DX,AL
  DEC DX
  MOV DL,0C4h
  MOV AX,000Bh
  OUT DX,AL
  INC DX
  XCHG	AH,AL
  OUT DX,AL
  DEC DX
  IN  AL,DX
  MOV AH,CL
  XOR AH,2
  MOV DX,3C4h
  MOV AL,0Eh
  OUT DX,AL
  INC DX
  XCHG	AH,AL
  OUT DX,AL
  DEC DX
 POP CX
 JMP @1
@SelBnkPgATIGUPro:
 MOV AH,AL
 AND AH,0Fh
 OR  AH,1
 {$IFOPT G+}
  ROR AH,2
 {$ELSE}
  ROR AH,1
  ROR AH,1
 {$ENDIF}
 AND AL,0Fh
 SHL AL,1
 OR  AH,AL
 MOV DX,01CEh
 MOV AL,0B2h
 OUT DX,AX
 JMP @1
@SelBnkPgATI16MD:
 PUSH BX
  MOV AH,AL
  MOV BX,AX
  AND AL,30h
  {$IFOPT G+}
   SHR AL,4
  {$ELSE}
   SHR AL,1
   SHR AL,1
   SHR AL,1
   SHR AL,1
  {$ENDIF}
  AND AH,30h
  {$IFOPT G+}
   SHR AH,2
  {$ELSE}
   SHR AH,1
   SHR AH,1
  {$ENDIF}
  OR  AH,AL
  MOV DX,01CEh
  MOV AL,0AEh
  OUT DX,AL
  INC DX
  IN  AL,DX
  AND AL,0F0h
  OR  AL,AH
  OUT DX,AL
  AND BH,0Fh
  MOV AH,BH
  {$IFOPT G+}
   SHR AH,3
   SHL BH,5
  {$ELSE}
   SHR AH,1
   SHR AH,1
   SHR AH,1
   SHL BH,1
   SHL BH,1
   SHL BH,1
   SHL BH,1
   SHL BH,1
  {$ENDIF}
  OR  AH,BH
  AND BL,0Fh
  SHL BL,1
  OR  AH,BL
  MOV DX,01CEh
  MOV AL,0B2h
  OUT DX,AX
 POP BX
 JMP @1
@SelBnkPgAcumos:
 MOV AH,AL
 {$IFOPT G+}
  SHL AH,4
 {$ELSE}
  SHL AH,1
  SHL AH,1
  SHL AH,1
  SHL AH,1
 {$ENDIF}
 MOV DX,03CEh
 MOV AL,9
 OUT DX,AL
 INC DX
 MOV AL,AH
 OUT DX,AL
 MOV AL,8
 DEC DX
 OUT DX,AL
 JMP @1
@SelBnkPgCirrus54:
 MOV AH,AL
 {$IFOPT G+}
  SHL AH,4
 {$ELSE}
  SHL AH,1
  SHL AH,1
  SHL AH,1
  SHL AH,1
 {$ENDIF}
 MOV DX,03CEh
 MOV AL,9
 OUT DX,AL
 INC DX
 MOV AL,AH
 OUT DX,AL
 MOV AL,8
 DEC DX
 OUT DX,AL
 JMP @1
@SelBnkPgCL5426:
 MOV AH,AL
 {$IFOPT G+}
  SHL AH,4
 {$ELSE}
  SHL AH,1
  SHL AH,1
  SHL AH,1
  SHL AH,1
 {$ENDIF}
 MOV DX,03CEh
 MOV AL,9
 OUT DX,AL
 INC DX
 MOV AL,AH
 OUT DX,AL
 MOV AL,8
 DEC DX
 OUT DX,AL
 JMP @1
@SelBnkPgSS24X:
 PUSH BX
  MOV AH,AL
  {$IFOPT G+}
   SHL AX,4
  {$ELSE}
   SHL AX,1
   SHL AX,1
   SHL AX,1
   SHL AX,1
  {$ENDIF}
  MOV BH,AL
  MOV BL,0Ah
  MOV AL,09h
  MOV DX,03CEh
  OUT DX,AX
  XCHG AX,BX
  OUT DX,AX
 POP BX
 JMP @1
@SelBnkPgRealTek:
 PUSH CX
  MOV AH,AL
  XCHG CX,AX
  MOV DX,3D6h
  MOV AL,CH
  OUT DX,AL
  INC DX
  MOV AL,CL
  OUT DX,AL
 POP CX
 JMP @1
@SelBnkPgS3805_1M:
 PUSH CX
  MOV CL,AL
  MOV AX,4838h
  MOV DX,3D4h
  OUT DX,AX
  MOV AX,0A539h
  OUT DX,AX
  MOV AL,31h
  OUT DX,AL
  INC DX
  IN  AL,DX
  OR  AL,1
  OUT DX,AL
  DEC DX
  MOV AL,35h
  OUT DX,AL
  INC DX
  IN  AL,DX
  AND AL,0F0h
  MOV AH,CL
  AND AH,0Fh
  OR  AL,AH
  OUT DX,AL
  DEC DX
  MOV AL,51h
  OUT DX,AL
  INC DX
  IN  AL,DX
  AND AL,0F3h
  MOV AH,CL
  AND AH,030h
  {$IFOPT G+}
   SHR AH,2
  {$ELSE}
   SHR AH,1
   SHR AH,1
  {$ENDIF}
  OR  AL,AH
  OUT DX,AL
  MOV AX,0038h
  DEC DX
  OUT DX,AX
  MOV AX,5A39h
  OUT DX,AX
 POP CX
 JMP @1
@SelBnkPgSParadise:
 PUSH CX
  MOV AH,AL
  XCHG AX,CX
  MOV DX,3CEh
  MOV AX,50Fh
  OUT DX,AX
  MOV AH,CL
  {$IFOPT G+}
   SHL AH,4
  {$ELSE}
   SHL AH,1
   SHL AH,1
   SHL AH,1
   SHL AH,1
  {$ENDIF}
  MOV AL,9
  OUT DX,AX
 POP CX
 JMP @1
@SelBnkPgVESAS3:
 PUSH CX
  MOV CL,AL
  MOV AX,4838h
  MOV DX,3D4h
  OUT DX,AX
  MOV AL,31h
  OUT DX,AL
  INC DX
  IN  AL,DX
  OR  AL,1
  OUT DX,AL
  DEC DX
  MOV AL,35h
  OUT DX,AL
  INC DX
  IN  AL,DX
  AND AL,0F0h
  OR  AL,CL
  OUT DX,AL
  MOV AX,0038h
  DEC DX
  OUT DX,AX
 POP CX
 JMP @1
@SelBnkPgViper:
 AND AL,1Fh
 OR  AL,20h
 MOV DX,03CDh
 OUT DX,AL
 JMP @1
@SelBnkPgMatrox:
 MOV AH,AL
 MOV DX,03DEh
 MOV AL,04h
 OUT DX,AX
 JMP @1
@SelBnkPgWDVanila:
 MOV AH,AL
 {$IFOPT G+}
  SHL AH,4
 {$ELSE}
  SHL AH,1
  SHL AH,1
  SHL AH,1
  SHL AH,1
 {$ENDIF}
 MOV AL,09h
 MOV DX,03CEh
 OUT DX,AL
 MOV AL,AH
 MOV DX,03CFh
 OUT DX,AL
 JMP @1
@SetPgAddr:
  DW 0                               { 0 - Non support‚ (r‚serv‚ pour l'AutoDetect) }
  DW Offset @SelBnkPgVGA             { 1 - VGA }
  DW Offset @SelBnkPgAhead           { 2 - Ahead }
  DW Offset @SelBnkPgATI             { 3 - ATI }
  DW Offset @SelBnkPgCirrus          { 4 - Cirrus }
  DW Offset @SelBnkPgCTI             { 5 - CTI }
  DW Offset @SelBnkPgEverex          { 6 - Everex }
  DW Offset @SelBnkPgGenoa           { 7 - Genoa }
  DW Offset @SelBnkPgHeadland        { 8 - Headland }
  DW Offset @SelBnkPgOak             { 9 - Oak }
  DW Offset @SelBnkPgParadise        { 10 - Paradise }
  DW Offset @SelBnkPgSTB             { 11 - STB }
  DW Offset @SelBnkPgTrident         { 12 - Trident }
  DW Offset @SelBnkPgTsengET3000     { 13 - Tseng Labs ET3000 }
  DW Offset @SelBnkPgTsengET4000     { 14 - Tseng Labs ET4000 }
  DW Offset @SelBnkPgVesa            { 15 - Vesa avec accŠs directe }
  DW Offset @SelBnkPgVideo7          { 16 - Video Seven }
  DW Offset @SelBnkPgXGA             { 17 - XGA }
  DW Offset @SelBnkPgZymos           { 18 - Zymos }
  DW Offset @SelBnkPgAheadA          { 19 - Ahead A }
  DW Offset @SelBnkPgAheadB          { 20 - Ahead B }
  DW Offset @SelBnkPgATI_GNU         { 21 - ATI selon la m‚thode GNU...}
  DW Offset @SelBnkPgChips           { 22 - Chips & Technologie }
  DW Offset @SelBnkPgTrident89       { 23 - Trident 8900 }
  DW Offset @SelBnkPgVesa            { 24 - Vesa en passant par l'interruption BIOS }
  DW Offset @SelBnkPgATIGUPro        { 25 - ATI GU Pro/Ultra }
  DW Offset @SelBnkPgATI16MD         { 26 - ATI 16 MD }
  DW Offset @SelBnkPgAcumos          { 27 - Acumos }
  DW Offset @SelBnkPgCirrus54        { 28 - Cirrus 54 }
  DW Offset @SelBnkPgCL5426          { 29 - CL5426 }
  DW Offset @SelBnkPgSS24X           { 30 - SS24X/WD90C3x }
  DW Offset @SelBnkPgRealTek         { 31 - RealTek }
  DW Offset @SelBnkPgS3805_1M        { 32 - S3805 - 1M / S3864 - 2M }
  DW Offset @SelBnkPgSParadise       { 33 - SParadise }
  DW Offset @SelBnkPgVESAS3          { 34 - VESA S3 }
  DW Offset @SelBnkPgViper           { 35 - Viper }
  DW Offset @SelBnkPgWDVanila        { 36 - WD Vanila / WD90C31 }
  DW Offset @SelBnkPgMatrox          { 37 - Matrox }
@GetBnkPg:
  DB $B0
@OldBnkPg:
  DB $FF
  JMP @End
@1:MOV @OldBnkPg.Byte,AL
@End:
 POPF
END;