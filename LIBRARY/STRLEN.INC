{StrLen.Inc}

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

{$IFNDEF __StrLen}
 {$DEFINE __StrLen}

 {$IFNDEF __PChr}
  {$DEFINE __PChr}
  Type PChr=^Char;
 {$ENDIF}

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                        Fonction StrLen                        �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Description
 袴袴袴袴袴�

  Cette fonction retourne le nombre de caract둹es que la cha똭e de
 caract둹es ASCIIZ contient.  Si elle pointe sur NIL,  la longueur
 retourner est 0.
}

Function StrLen(Str:PChr):Word;Assembler;ASM
 {$IFDEF FLAT386}
  OR  EAX,EAX
  JZ  @End
  MOV EDX,EDI
  MOV EDI,EAX
  MOV ECX,0FFFFFFFFH
  XOR AL,AL
  REPNE SCASB
  MOV EAX,0FFFFFFFEH
  SUB EAX,ECX
  MOV EDI,EDX
@End:
 {$ELSE}
  XOR AX,AX
  LES DI,Str
  MOV CX,ES
  OR  CX,DI
  JCXZ @1
  CLD
  MOV CX,$FFFF
  REPNE SCASB
  MOV AX,$FFFE
  SUB AX,CX
@1:
 {$ENDIF}
END;

{$ENDIF}