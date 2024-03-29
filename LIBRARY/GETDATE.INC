{GetDate.Inc}

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

{$IFNDEF __GetDate}
 {$DEFINE __GetDate}

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                            Proc괺ure GetDate                          �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


  Description
  袴袴袴袴袴�

   Cette proc괺ure renvoie la date telle qu'elle est connue par le syst둴e
  d'exploitation.


  Remarque
  袴袴袴袴

   � Rien ne permet a priori de tester  que la date du syst둴e est exacte.
     Si le probl둴e est important,  il sera donc pr괽굍able  de l'afficher
     et de permettre � l'utilisateur de la modifier � l'aide de 췚etDate�.
}

Procedure GetDate
{$IFDEF DosUnit}
 (Var Year,Month,Day,DayOfWeek:Word);
{$ELSE}
 (Var Year:Word;Var Month,Day,DayOfWeek:Byte);
{$ENDIF}
Assembler;ASM
 {$IFDEF FLAT386}
 {$ELSE}
  MOV AH,2Ah
  INT 21h
  CLD
  {$IFDEF DosUnit}
   XOR AH,AH
  {$ENDIF}
  LES DI,DayOfWeek
  {$IFDEF DosUnit}
   STOSW
  {$ELSE}
   STOSB
  {$ENDIF}
  MOV AL,DL
  LES DI,Day
  {$IFDEF DosUnit}
   STOSW
  {$ELSE}
   STOSB
  {$ENDIF}
  MOV AL,DH
  LES DI,Month
  {$IFDEF DosUnit}
   STOSW
  {$ELSE}
   STOSB
  {$ENDIF}
  XCHG AX,CX
  LES DI,Year
  STOSW
 {$ENDIF} 
END;

{$ENDIF}