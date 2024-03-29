{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 � Malte Genesis/Edition Chantal pour Mode R괻l/IV - Version 1.3 �
 �                          1997/01/02                           �
 �                                                               �
 �      Tous droits r굎erv� par les Chevaliers de Malte (C)      �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Nom des programmeurs
 袴袴袴袴袴袴袴袴袴袴

  Sylvain Maltais ainsi que Dieu Tout-Puissant


 Description
 袴袴袴袴袴�
  Ce fichier d'inclusion fournit les pr괺괽initions des directives
 conditionnel  n괹essaire  au  bon  fonctionnement  de  l'ensemble
 Chantal.


 Voici quelques pr괹isions sur les directives de compilation conditionnel:
   Chantal:        D괽init l'ensemble comme le Malte Genesis IV: Chantal.
   Debug:          Autorise cette unit� � 늯re reconnue par le d괷ogueur.
   DPMI:           Interdit  les acc둺 directe en m굆oire  et les m괹anismes
                   non-support� par le mode prot괾�.
   Isabel:         D괽init l'ensemble comme le Malte Genesis III: Isabel.
   Windows:        Demande �  l'unit� d'utiliser  autant  que  possible  les
                   fonctions Windows pour la gestion de cette unit�.
   __TINY__:       D괽init cette unit�  dans des  circonstances compacte  et
                   minimum.
}

{$IFNDEF ___DEF___}
 {$DEFINE ___DEF___}

{$Define Chantal}    { D괽init l'ensemble comme 굏ant Chantal }
{$Define Adele}      { D괽init l'ensemble d'extension comme 굏ant Adele }
{$Define NoInt09h}   { Interdit la redirection de l'IRQ clavier }
{$Define OldSpooler} { Utilise l'ancienne m굏hode de spooler d'imprimante }

{$IFDEF __TINY__}    { Mod둳e compacte }
 {$Define NoInt09h}  { Interdit la redirection de l'IRQ clavier }
{$ENDIF}

{$IFDEF DPMI}        { Mode prot괾� en DPMI }
 {$G+}               { Fixe le mode processeur 80286 minimum }
 {$DEFINE NotReal}   { Indique que le mode r괻l n'existe plus }
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
   {$Y-}             { 컴컴컴컴 ATTENTION! ATTENTION! ATTENTION! 컴컴컴컴�
                       A cette directive option, le 췘uickPascal� original
                       s'arr늯e dessus et indique une erreur plut뱓 que de
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
 {$DEFINE NotReal}   { Indique que le mode r괻l n'existe plus }
 {$DEFINE Graf}      { Le graphique est support괻 }
 {$DEFINE GraphicOS} { Syst둴e d'exploitation graphique et avec fen늯res de dialogue }
 {$DEFINE NoSpooler} { Pas besoin de Spooler d'impression existant d굁�...}
 {$DEFINE NoInLine}  { Pas de code InLine }
 {$DEFINE __Windows__} { Contexte d'application en fenetres }
 {$DEFINE __386__}   { Supporte le code assembleur 80386 }
 {$DEFINE FLAT386}   { Mode de fonctionnement de la memoire en methode FLAT }
 {$DEFINE LuxeExtra}
 {$H-}
{$ENDIF}

{$IFDEF Windows}       { Application Windows }
 {$DEFINE NotReal}     { Indique que le mode r괻l n'existe plus }
 {$DEFINE Graf}        { Le graphique est support괻 }
 {$DEFINE GraphicOS}   { Syst둴e d'exploitation graphique et avec fen늯res de dialogue }
 {$DEFINE NoSpooler}   { Pas besoin de Spooler d'impression existant d굁�...}
 {$DEFINE __Windows__} { Contexte d'application en fenetres }
{$ENDIF}

{$IFNDEF NotReal}    { Si pas de mode r괻l... }
 {$DEFINE Real}      { c'est que le mode r괻l existe! }
{$ENDIF}

{$IFDEF OS2}
 {$DEFINE Graf}      { Le graphique est support괻 }
 {$DEFINE GraphicOS} { Syst둴e d'exploitation graphique et avec fen늯res de dialogue }
{$ENDIF}

{$IFDEF __Windows__}
 {$DEFINE NoInLine}
{$ENDIF}

{$IFDEF __TMT__}
 {$DEFINE NoInLine}
{$ENDIF}

{                         컴컴컴컴컴컴컴컴�
                             컴컴컴컴컴�
                                컴컴�
}

{$ENDIF}