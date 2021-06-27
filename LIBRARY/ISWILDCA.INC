{IsWildCard.Inc}

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

{$IFNDEF __IsWildCard}
 {$DEFINE __IsWildCard}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Fonction IsWildCard                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction indique si le r‚pertoire d‚finit par la variable de
 param‚trage ®Path¯ contient un/des caractŠre(s)  g‚n‚riques ('*' ou
 '?').
}

Function IsWildCard(Path:String):Bool;Begin
 IsWildCard:=(Pos('*',Path)>0)or(Pos('?',Path)>0)
End;

{$ENDIF}