{\Source\Chantal\Malte\Volume\ExecAdel.Inc}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                 Malte Genesis/BibliothŠque individuel                 Û
 ³                      dition AdŠle/IV - Version 1.1                   Û
 ³                             1998/07/08                                Û
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

{$IFNDEF __ExecAdele}
 {$DEFINE __ExecAdele}

{ Cette enregistrement est le format Standard du Malte Genesis V: AdŠle
 d'un item de fichier interne  se trouvant  dans l'ex‚cutable lui-mˆme.
 Le d‚but de l'entr‚e se nomme:  ®DBUT¯ et le dernier se nomme: ®FIN¯.
 La table des matiŠres est … l'envers.
}

Type FileItemAdele=Record
 AbsolutePosition:LongInt; { Position absolue dans l'ex‚cutable }
 Size:LongInt;             { Taille du fichier interne }
 Name:String[39];          { Nom du fichier interne }
End;

{$ENDIF}