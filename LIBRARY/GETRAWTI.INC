{GetRawTimer.Inc}

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

{$IFNDEF __GetRawTimer}
 {$IFNDEF NoVoid}
  {$DEFINE __GetRawTimer}
 {$ENDIF}

 {$IFDEF __286__}
  {$I \Source\Chantal\Library\CPU\Intel\OpCode.Inc}
 {$ENDIF}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Fonction GetRawTimer                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction retourne l'heure de l'horloge ‚tant incr‚ment‚ … tous les
 18,2 par seconde.  Pour se faire il utilise une m‚thode d'accŠs directe …
 la m‚moire et prend soit de ne pas ˆtre interrompu par un IRQ.
}

{$IFNDEF NoVoid}Function GetRawTimer:LongInt;{$ENDIF}
{$IFDEF Windows}
 Var Sec100:Byte;Base:LongInt;Begin
  ASM
   MOV AH,2Ch
   INT 21h
   MOV AL,60
   MUL CH
   XOR CH,CH
   ADD AX,CX
   MOV CL,DL
   MOV DL,DH
   MOV DH,0
   MOV DI,DX
   MOV BX,60
   MUL BX
   ADD AX,DI
   ADC DX,0
   MOV Word Ptr Base,AX
   MOV Word Ptr Base[2],DX
   MOV Sec100,CL
  END;
  GetRawTimer:=((Base*100+Sec100)*47)shr 8;
 End;
{$ELSE}
 Assembler;ASM
  {$IFDEF Cmos}
   XOR AX,AX
   XOR DX,DX
   OUT 70h,AL
   IN  AL,71h
   MOV BL,AL
   MOV BH,AL
   AND BL,0Fh
   {$IFOPT G+}
    SHR BH,4
   {$ELSE}
    MOV CL,4
    SHR BH,CL
   {$ENDIF}
   MOV AL,10
   MUL BH
   ADD BL,AL
   MOV AL,18
   MUL BL
   MOV SI,AX
   MOV AL,2
   OUT 070h,AL
   IN  AL,071h
   MOV BL,AL
   MOV BH,AL
   AND BL,0Fh
   {$IFOPT G+}
    SHR BH,4
   {$ELSE}
    MOV CL,4
    SHR BH,CL
   {$ENDIF}
   MOV AL,10
   MUL BH
   ADD BL,AL
   MOV AL,182
   MUL BL
   MOV BX,6
   MUL BX
   ADD AX,SI
   ADC DX,0
   MOV SI,AX
   MOV DI,DX
   MOV AL,4
   OUT 70h,AL
   IN  AL,71h
   MOV BL,AL
   MOV BH,AL
   AND BL,0Fh
   {$IFOPT G+}
    SHR BH,4
   {$ELSE}
    MOV CL,4
    SHR BH,CL
   {$ENDIF}
   MOV AL,10
   MUL BH
   ADD BL,AL
   MOV AL,182
   MUL BL
   MOV BX,60*6
   MUL BX
   ADD AX,SI
   ADC DX,DI
  {$ELSE}
   {$IFDEF Bios}
    XOR AX,AX
    INT 01Ah
    XCHG AX,DX
    MOV DX,CX
   {$ELSE}
    {$IFDEF DPMI}
     MOV ES,Seg0040
     {$IFNDEF NoCLI}
      CLI
     {$ENDIF}
     MOV AX,ES:[6Ch]
     MOV DX,ES:[6Eh]
     {$IFNDEF NoCLI}
      STI
     {$ENDIF}
    {$ELSE}
     {$IFDEF __286__}
      DB 6Ah,00h { PUSH 0000h }
      DB ciPopES { POP ES     }
     {$ELSE}
      {$IFOPT G+}
       PUSH 0
       POP ES
      {$ELSE}
       XOR AX,AX
       MOV ES,AX
      {$ENDIF}
     {$ENDIF}
     { Pour une instruction, la logique veut que je n'est pas besoin }
     { de mettre … 0 les IRQ pendant la lecture de l'heure,  mais si }
     { j'utiliserais 2 instructions alors cela aurait eu la forme: }
     {  CLI }
     {  MOV AX,ES:[46Ch] (5 octets pour un 88 et 4 octets pour un 286) }
     {  MOV DX,ES:[46Eh] (5 octets pour un 88 et 4 octets pour un 286) }
     {  STI }
     {$IFNDEF NoCLI}
      CLI
     {$ENDIF}
     LES AX,ES:[$46C] { (5 octets) }
     {$IFDEF NoCLI}
      STI
     {$ENDIF}
     MOV DX,ES        { (2 octets) }
    {$ENDIF}
   {$ENDIF}
  {$ENDIF}
 END;
{$ENDIF}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Fonction GetRawTimerB                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette  fonction  retourne  seulement  le premier  octet  de l'heure  de
 l'horloge ‚tant incr‚ment‚ … tous les 18,2 par seconde. Pour se faire il
 utilise une m‚thode d'accŠs directe … la m‚moire et prend soit de ne pas
 ˆtre interrompu par un IRQ.
}

{$IFNDEF NoVoid}
 Function GetRawTimerB:Byte;
 {$IFDEF Windows}
  Begin
   GetRawTimerB:=GetRawTimer;
  End;
 {$ELSE}
  Assembler;ASM
   {$IFDEF Bios}
    XOR AX,AX
    INT 1Ah
    MOV AL,DL
   {$ELSE}
    {$IFDEF DPMI}
     MOV ES,Seg0040
     CLI
     MOV AL,ES:[06Ch]
     STI
    {$ELSE}
     {$IFDEF __286__}
      DB 6Ah,00h { PUSH 0000h }
      DB ciPopES { POP ES     }
     {$ELSE}
      XOR AX,AX
      MOV ES,AX
     {$ENDIF}
     CLI
     MOV AL,ES:[046Ch]
     STI
    {$ENDIF}
   {$ENDIF}
  END;
 {$ENDIF}
{$ENDIF}

{$ENDIF}