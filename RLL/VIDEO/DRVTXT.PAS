{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³              Malte Genesis/Pilote Texte Application & Jeux              Û
 ³             dition AdŠle pour Mode R‚el/V - Version 1.888              Û
 ³                              1998/01/01                                 Û
 ³                                                                         Û
 ³          Tous droits r‚serv‚s par les Chevaliers de Malte (C)           Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Nom des programmeurs
 ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

  Sylvain Maltais
  Too bad, y en a juste un...


 Chemin
 ÍÍÍÍÍÍ

  ®\Source\Chantal\RLL\Video\DrvTxt.Pas¯


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

 Ce pilote renferme une banque de proc‚dures accessible via les ®RLL¯ selon
 le standard du ®Malte Genesis V: Alias AdŠle¯. Elle a l'entˆte commune aux
 gestionnaires vid‚o graphique, BIOS, VESA, SuperVGA, VGA320x400,...


 Remarques
 ÍÍÍÍÍÍÍÍÍ

  ş Cette version est de la classe AdŠle-Surr‚alit‚-Archange et n'‚tant pas
    accessible directement  par  un compilateur  car son code est  compil‚e
    s‚par‚ment pour obtenir un ®SEG:0¯ comme point d'entr‚e.

  ş Ce pilote s'adapte aussi  bien aux effets d'arcade  qu'aux applications
    professionnel dans la gestion vid‚o.

  ş Attention!  Cette unit‚ ne doit pas acc‚der 14000 octets de taille pour
    ne pas cr‚er de conflit avec l'unit‚ ®Adele¯.

  ş tant donn‚ qu'il s'agit  d'un pilote les variables ne peuvent  qu'ˆtre
    que dans le segment de code (CS)  car c'est pas le mode prot‚g‚ mais le
    mode r‚el  et il perdrait dix fois  trop temps sinon,  en plus  l'unit‚
    ®Chantal¯ le prend … sa charge dans l'CS.

  ş Les  routines  de  souris   graphiques  en  mode  texte  sont  assum‚es
    parciellement par le pilote en fesant appel aux proc‚dures ®GetSmlImg¯,
    ®PutSmlImg¯,...

  ş Pour d‚marrer correctement ce pilote sans que les proc‚dures se plante,
    il faut  utiliser la proc‚dure  ®Init¯  fesant  l'examen "m‚dicale"  du
    systŠme vid‚o.

  ş J'oubliais, un cube n'est pas un cube mais l'addition d'un caractŠre et
    de son attribut.
}

Unit DrvTxt;

INTERFACE

{$A-,G-,O-}
Uses Systex;

{$I HeaderTxt.Inc}

IMPLEMENTATION

{$I DrvTxt.Inc}

Procedure EndDriverTxt;Assembler;ASM END;

END.