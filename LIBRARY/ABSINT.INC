{AbsInt.Inc}

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

{$IFNDEF __AbsInt}
 {$DEFINE __AbsInt}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                             Fonction AbsInt                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction retourne la valeur absolue de la valeur entiŠre contenue
 dans la variable de param‚trage ®I¯.


 Remarques
 ÍÍÍÍÍÍÍÍÍ

  ş Attention!  Cette fonction ne supporte en aucun cas les ®LongInt¯, et
    vous devrez  donc  utilise la fonction  ®Abs¯  d'origine dans l'unit‚
    ®SYSTEM¯ du compilateur pour avoir ce mˆme effet.

  ş Utilisez la directive de compilation conditionnel  ®Compatible¯  pour
    indiquer  …  la  proc‚dure  qu'il  doit  utiliser  une  technique  de
    compatibilit‚ ind‚pendament  de la taille d'une variable entiŠre  (si
    vous pr‚f‚rez, ayant une taille pouvant ˆtre diff‚rente de 2 octets).
}

Function AbsInt(I:Integer):Integer;Assembler;ASM
 {$IFDEF __386__}
  OR AX,AX
  JGE @1
  NEG AX
@1:
 {$ELSE}
  {$DEFINE Compatible}
   MOV AX,I
   {$IFDEF Compatible}
    OR  AX,AX { Ceci c'est la m‚thode "Schtroumpf" international de }
    JGE @1    { compatibilit‚...}
    NEG AX
 @1:
   {$ELSE}
    AND AX,$7FFF
  {$ENDIF}
 {$ENDIF}
END;

{$ENDIF}