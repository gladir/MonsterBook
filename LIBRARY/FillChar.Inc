{FillChar.Inc}

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

{$IFNDEF __FillChr}
 {$DEFINE __FillChr}

{$IFNDEF NoVoid}
 Procedure FillChr(Var X;Len:Word;Value:Byte);Assembler;
{$ENDIF}
ASM
 {$IFDEF FLAT386}
  PUSH EDI
   XCHG EDI,EAX
   MOV CH,CL
   MOV EAX,ECX
   SHL EAX,16
   MOV AX,CX
   MOV ECX,EDX
   AND ECX,0FFFFh
   SAR ECX,2
   JS  @@exit
   REP STOSD
   MOV ECX,EDX
   AND ECX,3
   REP STOSB
@@exit:
  POP EDI
 {$ELSE}
  CLD
  LES DI,X
  MOV CX,Len
  MOV AL,Value
  MOV AH,AL
  {$IFDEF __386__}
   DB  ciPushAX,ciPushAX { EAX := AX:AX }
   DW  ciPopEAX
   MOV BX,CX
   AND BX,3
   {$IFOPT G+}
    SHR CX,2
   {$ELSE}
    DB  $C1,$E9,$02          { SHR CX,2 }
   {$ENDIF}
   DB  ciREP; DW ciSTOSD    { REP STOSD }
   MOV CX,BX
   REP STOSB
  {$ELSE}
   SHR CX,1
   REP STOSW
   ADC CX,CX
   REP STOSB
  {$ENDIF}
 {$ENDIF}
END;

{$ENDIF}