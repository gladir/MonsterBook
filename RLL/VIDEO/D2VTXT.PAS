{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �              Malte Genesis/Pilote Texte Application & Jeux              �
 �          릁ition Ad둳e pour Mode R괻l/V - Version 1.888 - 80268         �
 �                              1998/01/01                                 �
 �                                                                         �
 �          Tous droits r굎erv굎 par les Chevaliers de Malte (C)           �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Nom des programmeurs
 袴袴袴袴袴袴袴袴袴袴

  Sylvain Maltais
  Too bad, y en a juste un...


 Chemin
 袴袴袴

  �\Source\Chantal\RLL\Video\DrvTxt.Pas�


 Description
 袴袴袴袴袴�

 Ce pilote renferme une banque de proc괺ures accessible via les 췙LL� selon
 le standard du 췔alte Genesis V: Alias Ad둳e�. Elle a l'ent늯e commune aux
 gestionnaires vid굊 graphique, BIOS, VESA, SuperVGA, VGA320x400,...


 Remarques
 袴袴袴袴�

  � Cette version est de la classe Ad둳e-Surr괶lit�-Archange et n'굏ant pas
    accessible directement  par  un compilateur  car son code est  compil괻
    s굋ar굆ent pour obtenir un 췚EG:0� comme point d'entr괻.

  � Ce pilote s'adapte aussi  bien aux effets d'arcade  qu'aux applications
    professionnel dans la gestion vid굊.

  � Attention!  Cette unit� ne doit pas acc괺er 14000 octets de taille pour
    ne pas cr괻r de conflit avec l'unit� 췆dele�.

  � 릘ant donn� qu'il s'agit  d'un pilote les variables ne peuvent  qu'늯re
    que dans le segment de code (CS)  car c'est pas le mode prot괾� mais le
    mode r괻l  et il perdrait dix fois  trop temps sinon,  en plus  l'unit�
    췈hantal� le prend � sa charge dans l'CS.

  � Les  routines  de  souris   graphiques  en  mode  texte  sont  assum괻s
    parciellement par le pilote en fesant appel aux proc괺ures 췍etSmlImg�,
    췗utSmlImg�,...

  � Pour d굆arrer correctement ce pilote sans que les proc괺ures se plante,
    il faut  utiliser la proc괺ure  췏nit�  fesant  l'examen "m괺icale"  du
    syst둴e vid굊.

  � J'oubliais, un cube n'est pas un cube mais l'addition d'un caract둹e et
    de son attribut.
}

Unit D2vTxt;

INTERFACE

{$A-,G+,O-}

Uses Systex;

{$I HeaderTxt.Inc}

IMPLEMENTATION

{$I DrvTxt.Inc}

Procedure EndDriverTxt;Assembler;ASM END;

END.