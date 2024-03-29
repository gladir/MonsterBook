{\Source\Chantal\Library\MulL.Inc}

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

{$IFNDEF __MulL}
 {$DEFINE __MulL}

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                           Fonction MulL                           �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�

 Description
 袴袴袴袴袴�

  Cette fonction permet d'effectuer une multiplication de deux nombres
 32 bits sans assistance d'un micro-processeur sp괹ifique.
}

Function MulL(a,b:LongInt):LongInt;Assembler;ASM
 {$IFDEF FLAT386}
  IMUL EDX
 {$ELSE}
  LES AX,a
  MOV DX,ES
  LES CX,b
  MOV BX,ES
  {$IFDEF __386__}
   DB 66h,0C1h,0E0h,010h     { SHL  EAX,10h     }
   DB 66h,00Fh,0ACh,0D0h,10h { SHRD EAX,EDX,10h }
   DB 66h,0C1h,0E1h,010h     { SHL  ECX,10h     }
   DB 66h,00Fh,0ACh,0D9h,10h { SHRD ECX,EBX,10h }
   DB 66h,0F7h,0E9h          { IMUL ECX         }
   DB 66h,00Fh,0A4h,0C2h,10h { SHLD EDX,EAX,10h }
  {$ELSE}
   MOV SI,AX
   MOV DI,DX
   MUL CX
   PUSH AX
    PUSH DX
     MOV AX,SI
     MUL BX
     MOV BX,AX
     MOV AX,DI
     MUL CX
     MOV CX,AX
    POP DX
   POP AX
   ADD DX,BX
   ADD DX,CX
  {$ENDIF}
 {$ENDIF}
END;

{$ENDIF}