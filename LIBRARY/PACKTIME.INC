{PackTime.Inc}

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

{$IFNDEF __PackTime}
 {$DEFINE __PackTime}

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴콘
 �                           Proc괺ure PackTime                         �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複蔔


 Description
 袴袴袴袴袴�

  Cette proc괺ure permet  de passer  de la forme longue de la date  et de
 l'heure directement lisible, � la forme courte utilis�, par exemple, par
 la proc괺ure  췚etFTime�.  Le  param둻re  췛�  est  doit  늯re  de  type
 췉ateTime� pr괺괽ini par l'unit� 췉os� ou 췚ystex�.
}

Procedure PackTime(Var T:DateTime;Var P:LongInt);Assembler;ASM
 {$IFDEF FLAT386}
 {$ELSE}
  PUSH DS
   LDS SI,T
   CLD
   LODSW
   SUB AX,1980
   {$IFOPT G+}
    SHL AX,9
   {$ELSE}
    MOV CL,9
    SHL AX,CL
   {$ENDIF}
   XCHG AX,DX
   {$IFDEF DosUnit}
    LODSW
   {$ELSE}
    LODSB
    XOR AH,AH
   {$ENDIF}
   {$IFOPT G+}
    SHL AX,5
   {$ELSE}
    MOV CL,5
    SHL AX,CL
   {$ENDIF}
   ADD DX,AX
   {$IFDEF DosUnit}
    LODSW
   {$ELSE}
    LODSB
    XOR AH,AH
   {$ENDIF}
   ADD DX,AX
   {$IFDEF DosUnit}
    LODSW
   {$ELSE}
    LODSB
   {$ENDIF}
   {$IFOPT G+}
    SHL AX,11
   {$ELSE}
    MOV CL,11
    SHL AX,CL
   {$ENDIF}
   XCHG AX,BX
   {$IFDEF DosUnit}
    LODSW
   {$ELSE}
    LODSB
    XOR AH,AH
   {$ENDIF}
   {$IFOPT G+}
    SHL AX,5
   {$ELSE}
    MOV CL,5
    SHL AX,CL
   {$ENDIF}
   ADD BX,AX
   {$IFDEF DosUnit}
    LODSW
   {$ELSE}
    LODSB
   {$ENDIF}
   SHR AX,1
   ADD AX,BX
  POP DS
  LES DI,P
  STOSW
  XCHG AX,DX
  STOSW
 {$ENDIF}
END;

{$ENDIF}