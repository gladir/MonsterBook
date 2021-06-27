{FillChar.Inc}

{�������������������������������������������������������������������������
 �                 Malte Genesis/Biblioth�que individuel                 �
 �                    �dition Chantal/IV - Version 1.1                   �
 �                             1997/04/01                                �
 �                                                                       �
 �         Tous droits r�serv�s par les Chevaliers de Malte (C)          �
 �������������������������������������������������������������������������


 Nom des programmeurs
 ��������������������

  Sylvain Maltais


 Description
 �����������

  Cette inclusion vise  � permettre une universialisation des donn�es �
 compiler  ind�pendament  des conditions  sous  lequel  la fonction est
 tra�ter.  En centralisant toutes les proc�dures au m�me point central,
 on aboutira une technique de �Croiser�, celle-ci permet d'�liminer les
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