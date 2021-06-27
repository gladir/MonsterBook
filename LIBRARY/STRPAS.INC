{StrPas.Inc}

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

{$IFNDEF __StrPas}
 {$DEFINE __StrPas}

 {$IFNDEF __PChr}
  {$DEFINE __PChr}
  Type PChr=^Char;
 {$ENDIF}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Fonction StrPas                            Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction convertit la chaŒne de caractŠres de param‚trage ®Str¯ de
 format ASCIIZ en une chaŒne de format "String" de Pascal.
}

Function StrPas(Str:PChr):String;Assembler;ASM
 {$IFDEF FLAT386}
  PUSH EAX
   MOV CL,255
@@Loop:
   MOV CH,[EDX]
   INC EDX
   TEST CH,CH
   JE  @@EndLoop
   INC EAX
   MOV [EAX],CH
   DEC CL
   JNE @@loop
@@EndLoop:
  POP EDX
  SUB EAX,EDX
  MOV [EDX],AL
 {$ELSE}
  PUSH DS
   CLD
   LES DI,Str
   MOV AX,ES
   OR  AX,DI
   JZ  @Nil
   MOV CX,-1
   XOR AL,AL
   REPNE SCASB
   NOT CX
   DEC CX
   LDS SI,Str
   LES DI,@Result
   MOV AL,CL
   STOSB
   REP MOVSB
   JMP @End
 @Nil:
   LES DI,@Result
   STOSB
 {  MOV Byte Ptr ES:[DI],AL}
 @End:
  POP DS
 {$ENDIF}  
END;

{$ENDIF}