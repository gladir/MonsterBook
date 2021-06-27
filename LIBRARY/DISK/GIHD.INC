{\Source\Chantal\Library\Disk\GIHD.Inc}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                 Malte Genesis/BibliothŠque individuel                 Û
 ³                    dition Chantal/IV - Version 1.1                   Û
 ³                             1997/04/01                                Û
 ³                                                                       Û
 ³         Tous droits r‚serv‚s par les Chevaliers de Malte (C)          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Nom du programmeur
 ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

  Sylvain Maltais


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette inclusion vise  … permettre une universialisation des donn‚es …
 compiler  ind‚pendament  des conditions  sous  lequel  la fonction est
 traŒter.  En centralisant toutes les proc‚dures au mˆme point central,
 on aboutira une technique de ®Croiser¯, celle-ci permet d'‚liminer les
 bugs par le raisonnement suivant:Maintenant sa fonctionne parfaitement
 ou sa plante comme jamais avant...
}

{$IFNDEF __GetInfoHardDisk}
 {$DEFINE __GetInfoHardDisk}

 {ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                         Proc‚dure GetInfoHardDisk                    Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette proc‚dure  d'obtenir  divers  information sur une unit‚ de disque
  durs en particulier comme le nombre de cylindres, de tˆte et de secteur.
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