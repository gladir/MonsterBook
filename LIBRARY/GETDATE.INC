{GetDate.Inc}

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

{$IFNDEF __GetDate}
 {$DEFINE __GetDate}

{�������������������������������������������������������������������������
 �                            Proc�dure GetDate                          �
 �������������������������������������������������������������������������


  Description
  �����������

   Cette proc�dure renvoie la date telle qu'elle est connue par le syst�me
  d'exploitation.


  Remarque
  ��������

   � Rien ne permet a priori de tester  que la date du syst�me est exacte.
     Si le probl�me est important,  il sera donc pr�f�rable  de l'afficher
     et de permettre � l'utilisateur de la modifier � l'aide de �SetDate�.
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