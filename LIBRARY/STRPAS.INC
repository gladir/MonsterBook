{StrPas.Inc}

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                 Malte Genesis/Biblioth둸ue individuel                 �
 �                    릁ition Chantal/IV - Version 1.1                   �
 �                             1997/04/01                                �
 �                                                                       �
 �         Tous droits r굎erv굎 par les Chevaliers de Malte (C)          �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Nom des programmeurs
 袴袴袴袴袴袴袴袴袴袴

  Sylvain Maltais


 Description
 袴袴袴袴袴�

  Cette inclusion vise  � permettre une universialisation des donn괻s �
 compiler  ind굋endament  des conditions  sous  lequel  la fonction est
 tra똳er.  En centralisant toutes les proc괺ures au m늤e point central,
 on aboutira une technique de 췈roiser�, celle-ci permet d'굃iminer les
 bugs par le raisonnement suivant:Maintenant sa fonctionne parfaitement
 ou sa plante comme jamais avant...
}

{$IFNDEF __StrPas}
 {$DEFINE __StrPas}

 {$IFNDEF __PChr}
  {$DEFINE __PChr}
  Type PChr=^Char;
 {$ENDIF}

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                            Fonction StrPas                            �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Description
 袴袴袴袴袴�

  Cette fonction convertit la cha똭e de caract둹es de param굏rage 췚tr� de
 format ASCIIZ en une cha똭e de format "String" de Pascal.
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