{UnPackTi.Inc}

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

{$IFNDEF __UnPackTime}
 {$DEFINE __UnPackTime}

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                          Proc괺ure UnPackTime                         �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Description
 袴袴袴袴袴�

  Cette proc괺ure  permet  de passer  de la forme courte de la date  et de
 l'heure,  utilis� par exemple  par le Dos,  � la forme longue directement
 lisible.
}

Procedure UnPackTime(P:LongInt;Var T:DateTime);Assembler;ASM
 {$IFDEF FLAT386}
 {$ELSE}
  LES DI,T
  CLD
  MOV AX,Word Ptr P[2]
  {$IFOPT G+}
   SHR AX,9
  {$ELSE}
   MOV CL,9
   SHR AX,CL
  {$ENDIF}
  ADD AX,1980
  STOSW
  MOV AX,Word Ptr P[2]
  {$IFOPT G+}
   SHR AX,5
  {$ELSE}
   MOV CL,5
   SHR AX,CL
  {$ENDIF}
  AND AX,15
  {$IFDEF DosUnit}
   STOSW
  {$ELSE}
   STOSB
  {$ENDIF}
  MOV AX,Word Ptr P[2]
  AND AX,31
  {$IFDEF DosUnit}
   STOSW
  {$ELSE}
   STOSB
  {$ENDIF}
  MOV AX,Word Ptr P
  {$IFOPT G+}
   SHR AX,11
  {$ELSE}
   MOV CL,11
   SHR AX,CL
  {$ENDIF}
  {$IFDEF DosUnit}
   STOSW
  {$ELSE}
   STOSB
  {$ENDIF}
  MOV AX,Word Ptr P
  {$IFOPT G+}
   SHR AX,5
  {$ELSE}
   MOV CL,5
   SHR AX,CL
  {$ENDIF}
  AND AX,63
  {$IFDEF DosUnit}
   STOSW
  {$ELSE}
   STOSB
  {$ENDIF}
  MOV AX,Word Ptr P
  AND AX,31
  SHL AX,1
  {$IFDEF DosUnit}
   STOSW
  {$ELSE}
   STOSB
  {$ENDIF}
 {$ENDIF} 
END;

{$ENDIF}