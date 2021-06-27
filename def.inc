{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³ Malte Genesis/Edition Chantal pour Mode R‚el/IV - Version 1.3 Û
 ³                          1997/01/02                           Û
 ³                                                               Û
 ³      Tous droits r‚serv‚ par les Chevaliers de Malte (C)      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Nom des programmeurs
 ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

  Sylvain Maltais ainsi que Dieu Tout-Puissant


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ
  Ce fichier d'inclusion fournit les pr‚d‚finitions des directives
 conditionnel  n‚cessaire  au  bon  fonctionnement  de  l'ensemble
 Chantal.


 Voici quelques pr‚cisions sur les directives de compilation conditionnel:
   Chantal:        D‚finit l'ensemble comme le Malte Genesis IV: Chantal.
   Debug:          Autorise cette unit‚ … ˆtre reconnue par le d‚bogueur.
   DPMI:           Interdit  les accŠs directe en m‚moire  et les m‚canismes
                   non-support‚ par le mode prot‚g‚.
   Isabel:         D‚finit l'ensemble comme le Malte Genesis III: Isabel.
   Windows:        Demande …  l'unit‚ d'utiliser  autant  que  possible  les
                   fonctions Windows pour la gestion de cette unit‚.
   __TINY__:       D‚finit cette unit‚  dans des  circonstances compacte  et
                   minimum.
}

{$IFNDEF ___DEF___}
 {$DEFINE ___DEF___}

{$Define Chantal}    { D‚finit l'ensemble comme ‚tant Chantal }
{$Define Adele}      { D‚finit l'ensemble d'extension comme ‚tant Adele }
{$Define NoInt09h}   { Interdit la redirection de l'IRQ clavier }
{$Define OldSpooler} { Utilise l'ancienne m‚thode de spooler d'imprimante }

{$IFDEF __TINY__}    { ModŠle compacte }
 {$Define NoInt09h}  { Interdit la redirection de l'IRQ clavier }
{$ENDIF}

{$IFDEF DPMI}        { Mode prot‚g‚ en DPMI }
 {$G+}               { Fixe le mode processeur 80286 minimum }
 {$DEFINE NotReal}   { Indique que le mode r‚el n'existe plus }
 {$DEFINE Graf}
 {$DEFINE LuxeExtra}
 {$DEFINE ShortBF}
 {$DEFINE DirectDos}
 {$DEFINE H}
{$ENDIF}

{$IFDEF VER10}
 {$IFNDEF Windows}
  {$DEFINE QuickPascal}
  {$DEFINE NoAsm}
 {$ENDIF}
{$ENDIF}

{$IFNDEF Debug}
 {$D-,L-}
 {$IFNDEF QuickPascal}
  {$IFDEF VER70}
   {$Y-}             { ÄÄÄÄÄÄÄÄ ATTENTION! ATTENTION! ATTENTION! ÄÄÄÄÄÄÄÄÄ
                       A cette directive option, le ®QuickPascal¯ original
                       s'arrˆte dessus et indique une erreur plut“t que de
                       continuer sans se poser  de question comme tous les
                       autres compilateurs de langage Pascal. }
  {$ENDIF}
 {$ENDIF}
{$ENDIF}

{$IFDEF VER70}
 {$Q-}
{$ENDIF}

{$IFDEF VER55}
 {$DEFINE NoAsm}
{$ENDIF}

{$IFDEF VER50}
 {$DEFINE NoAsm}
{$ENDIF}

{$IFDEF VER40}
 {$DEFINE NoAsm}
{$ENDIF}

{$A-,B-,F+,I-,R-,S-,X+,V-,W-}

{$IFDEF Win32}       { Application Windows 9X }
 {$DEFINE NotReal}   { Indique que le mode r‚el n'existe plus }
 {$DEFINE Graf}      { Le graphique est support‚e }
 {$DEFINE GraphicOS} { SystŠme d'exploitation graphique et avec fenˆtres de dialogue }
 {$DEFINE NoSpooler} { Pas besoin de Spooler d'impression existant d‚j…...}
 {$DEFINE NoInLine}  { Pas de code InLine }
 {$DEFINE __Windows__} { Contexte d'application en fenetres }
 {$DEFINE __386__}   { Supporte le code assembleur 80386 }
 {$DEFINE FLAT386}   { Mode de fonctionnement de la memoire en methode FLAT }
 {$DEFINE LuxeExtra}
 {$H-}
{$ENDIF}

{$IFDEF Windows}       { Application Windows }
 {$DEFINE NotReal}     { Indique que le mode r‚el n'existe plus }
 {$DEFINE Graf}        { Le graphique est support‚e }
 {$DEFINE GraphicOS}   { SystŠme d'exploitation graphique et avec fenˆtres de dialogue }
 {$DEFINE NoSpooler}   { Pas besoin de Spooler d'impression existant d‚j…...}
 {$DEFINE __Windows__} { Contexte d'application en fenetres }
{$ENDIF}

{$IFNDEF NotReal}    { Si pas de mode r‚el... }
 {$DEFINE Real}      { c'est que le mode r‚el existe! }
{$ENDIF}

{$IFDEF OS2}
 {$DEFINE Graf}      { Le graphique est support‚e }
 {$DEFINE GraphicOS} { SystŠme d'exploitation graphique et avec fenˆtres de dialogue }
{$ENDIF}

{$IFDEF __Windows__}
 {$DEFINE NoInLine}
{$ENDIF}

{$IFDEF __TMT__}
 {$DEFINE NoInLine}
{$ENDIF}

{                         ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
                             ÄÄÄÄÄÄÄÄÄÄÄ
                                ÄÄÄÄÄ
}

{$ENDIF}