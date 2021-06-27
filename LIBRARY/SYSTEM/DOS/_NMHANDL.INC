{_NmHandl.Inc}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                 Malte Genesis/BibliothŠque individuel                 Û
 ³                    dition Chantal/IV - Version 1.1                   Û
 ³                             1997/04/01                                Û
 ³                                                                       Û
 ³         Tous droits r‚serv‚s par les Chevaliers de Malte (C)          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Nom des programmeurs
 ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

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

{$IFNDEF ___NmHandle}
 {$DEFINE ___NmHandle}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Fonction _NmHandle                           Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction retourne le nombre de Handle utiliser par l'application en
 cours, c'est-…-dire celle-ci.


 Remarque
 ÍÍÍÍÍÍÍÍ

  ş Cette fonction r‚clame  un  systŠme d'exploitation compatible  … un DOS
    version 2 ou post‚rieurs (datant de moins mars 1983)!
}

 {$IFNDEF NoVoid}Function _NmHandle:Hdl;{$ENDIF}
 {$IFDEF __NmHandle}
  Begin
   {$IFDEF Win32}
    _NmHandle:=0;
   {$ELSE}
    _NmHandle:=NmHandle(PrefixSeg)
   {$ENDIF}
  End;
 {$ELSE}
  Var J:Byte;Begin
   ASM MOV @Result,0;END;
   If PrefixSeg<>8Then For J:=0to 19do If Not(Mem[PrefixSeg:$18+J]in[0..2,$FF])Then ASM INC @Result;END;
  End;
 {$ENDIF}

{$ENDIF}