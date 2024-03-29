{\Source\Chantal\Library\Disk\GIHD.Inc}

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                 Malte Genesis/Biblioth둸ue individuel                 �
 �                    릁ition Chantal/IV - Version 1.1                   �
 �                             1997/04/01                                �
 �                                                                       �
 �         Tous droits r굎erv굎 par les Chevaliers de Malte (C)          �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Nom du programmeur
 袴袴袴袴袴袴袴袴袴

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

{$IFNDEF __GetInfoHardDisk}
 {$DEFINE __GetInfoHardDisk}

 {旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴콘
  �                         Proc괺ure GetInfoHardDisk                    �
  잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複蔔


  Description
  袴袴袴袴袴�

   Cette proc괺ure  d'obtenir  divers  information sur une unit� de disque
  durs en particulier comme le nombre de cylindres, de t늯e et de secteur.
 }

 Procedure GetInfoHardDisk(Number:Byte;Var Track:Word;Var Head,Sector:Byte);Var Intr:Byte;IntHD:^IntHardDiskRec;Begin
  ASM OR Number,$80;END;
  Case(Number)of
   $80:Intr:=$41;
   $81:Intr:=$46;
   Else Intr:=$41;
  End;
  GetIntVec(Intr,Pointer(IntHD));
  {$IFNDEF Windows}
   {$IFDEF Real}
    If MachineID<>$FCThen
   {$ENDIF}
   ASM
    MOV AH,8
    MOV DL,Number
    INT 13h
    AND CL,3Fh
    LES DI,Sector
    XCHG AX,CX
    STOSB
   END
   {$IFDEF Real}
    Else
   {$ENDIF}
  {$ENDIF}
  {$IFDEF Real}
   Begin
    CLI;
    Sector:=IntHD^.Sector;
    STI;
   End;
   CLI;
   Track:=IntHD^.MaxTrack;
   Head:=IntHD^.MaxHead;
   STI;
  {$ENDIF}
 End;

{$ENDIF}