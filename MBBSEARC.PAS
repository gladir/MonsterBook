{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                                                                  Û
 ³  Malte Genesis - Bureautique/Module de Recherche pour l'diteur  Û
 ³          Edition Chantal pour Mode R‚el/IV - Version 1.0;        Û
 ³            Edition AdŠle pour Mode R‚el/V - Version 1.0          Û
 ³                             1997/01/01                           Û
 ³                                                                  Û
 ³        Tous droits r‚serv‚s par les Chevaliers de Malte (C)      Û
 ³                                                                  Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette unit‚ contient les proc‚dures et fonctions pour la recherche,
 remplacement  et les boŒtes de dialogues … cette effet pour un texte
 d'objet ®EditorApp¯ ainsi que celle de ®ViewAscii¯.
}

Unit MBBSearc;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                INTERFACE
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

{$DEFINE BureauVersion}
{$DEFINE Bureau}

{$I MBSearch.Inc}

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
BEGIN
 System.FillChar(LastSearch,SizeOf(LastSearch),0);
END.