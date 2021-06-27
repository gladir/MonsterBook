{\Source\Chantal\Library\Files\Images\FlbEntry.Inc}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                 Malte Genesis/BibliothŠque individuel                 Û
 ³                    dition Chantal/IV - Version 1.1                   Û
 ³                             1998/03/15                                Û
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

{$IFNDEF __FLBEntry}
 {$DEFINE __FLBEntry}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Enregistrement FLBEntry                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette enregistrement est le format  d'une entr‚e d'un fichier  "*.FLB"
 (Font LiBrary) du NewsMaster (un traŒtement de texte dat‚e de 1986 avec
 multi-dimension polices de caractŠres)  version 1.0 d'Unison World, une
 division de  Kyocera Unison.  Cette  enregistrement  … une taille de 80
 octets  et  commence  imm‚diatement  au  d‚but  du  fichier sans entˆte
 d'identification sinon son extension "FLB".


 Remarques
 ÍÍÍÍÍÍÍÍÍ

  ş Les polices de cette bibliothŠque sont monochromes ou en 2 couleurs,
    il ne supporte pas directement d'autres ‚cran que ceux-ci.

  ş Dans le fichier  d'origine o—  l'exp‚rimentation  de d‚compilation a
    ‚t‚,  il n'y avait que 34 enregistrements  d'entˆte et le fichier se
    nommait ®NEWS.FLB¯.
}

Type FLBEntry=Record
 Data1:Array[0..5]of Byte;    { Donn‚es r‚serv‚??? Possiblement 3 mots... }
 PosAbs:LongInt;              { Position absolue dans le fichier de l'image}
                              { suivit par la police (256+SizeImg). Dans la}
                              { partie de taille de 256 caractŠres, il }
                              { contient une table de 128 mots contenant}
                              { des adresses de chacun des 128 caractŠres}
                              { contenu dans cette police.}
 Name:Array[0..49]of Char;    { Nom de la police de caractŠre }
 SizeImg:Word;                { Taille de l'image }
 Data2:Array[62..75]of Byte;  { Donn‚es r‚serv‚??? }
 Height:Word;                 { Hauteur des caractŠres }
 Data3:Word;                  { Donn‚es r‚serv‚??? }
End;

{$ENDIF}