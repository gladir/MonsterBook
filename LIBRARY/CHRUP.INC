{ChrUp.Inc}

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

{$IFNDEF __ChrUp}
 {$DEFINE __ChrUp}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                              Fonction ChrUp                             Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction retourne la majuscule de la lettre sp‚cifie par la variable
 de  param‚trage  ®Chr¯.   Il  supporte  aussi  bien  les  accents  que  les
 minuscules,  et si c'est possible  il retourne la majuscule  avec un accent
 que celui-ci est un accent.  Il se fit pour cela  … la table des caractŠres
 ‚tendue standard d'IBM.
}

Function ChrUp(Chr:Char):Char;Begin
 Case(Chr)of
  'a'..'z': ChrUp:=Char(Byte(Chr)-32);
  '€','‡': ChrUp:='C';
  '','–','—','š','£': ChrUp:='U';
  '‚','ˆ','‰','Š','': ChrUp:='E';
  'ƒ','„','…','†','','',' ','¦': ChrUp:='A';
  '‹','Œ','','¡': ChrUp:='I';
  '“','”','•','™','¢','§': ChrUp:='O';
  '¤','¥': ChrUp:='N';
  '˜': ChrUp:='Y';
  '‘': ChrUp:='’';
  Else ChrUp:=Chr;
 End
End;

{$ENDIF}