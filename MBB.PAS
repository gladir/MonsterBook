{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴콘
 �                                                              �
 �        ..    ..  ...  ..   ..  ....  ..... ..... ......      �
 �        ........ .. .. ...  .. ..  ..   ..  ..  .  ..  ..     �
 �        .. .. .. .. .. .... ..  ....    ..  ...    .....      �
 �        ..    .. .. .. .. .... .. ..    ..  ..  .  .. ..      �
 �        ..    ..  ...  ..  ...  ...     ..  ..... .... ..     �
 �                                                              �
 �                 +++++   ++++   ++++  ++  ++                  �
 �                  ++ ++ ++  ++ ++  ++ ++ ++                   �
 �                  ++++  ++  ++ ++  ++ ++++                    �
 �                  ++ ++ ++  ++ ++  ++ ++ ++                   �
 �                 +++++   ++++   ++++  ++  ++                  �
 �                                                              �
 �                   Distribution Bureautique                   �
 �                                                              �
 �                             pour                             �
 �                                                              �
 � L'ensemble Malte Genesis III,IV & V: Isabel, Chantal & Ad둳e �
 � Tous droits r굎erv굎 par les Chevaliers de Malte XXIe si둩le �
 �                                                              �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複蔔


 Nom du programmeur
 袴袴袴袴袴袴袴袴袴

  Joseph Gabriel Sylvain Maltais


 Adaptation
 袴袴袴袴袴

  � Vendredi 13 ao뻯 1999,  dit: 췛he Furor, Ressurrection and Live after
    Death�.  En  raison  du  triste  anniversaire de la  perte de donn괻s
    majeur de l'ensemble Genesis et  reconstruit avec une fureur certaine
    de ne pas mourir � cause d'une d괽aillance mat굍iel!


 Description
 袴袴袴袴袴�

  Application multi-fen늯re  permettant l'usage  du tra똳ement  de texte,
 gestionnaire de fichiers, calculatrice programmable, tableur,...


 Remarques
 袴袴袴袴�

  � Cette application est con뇎 pour 늯re compil굎 avec le Borland Pascal
    7 en mode r괻l. Il peut th굊riquement support� les versions suivantes
    mais 굏ant donn괻  qu'elles n'ont jamais 굏� test� avec ce programme,
    il peut arriver n'importe quoi...

  � Ce prototype ne supporte convenablement que les modes en 16,  256  et
    65536 couleurs  en mode graphiques,  les autres modes graphiques sont
    tr둺 bo똳eux pour une raison plus ou moins connue...

  � Les modes graphiques VESA avec  des plages  de 4 Ko au lieu  de 64 Ko
    comme les initi굎, ne fonctionne pas correctement dans ce programme.
}

Program MonsterBookBureau;
{$I DEF.INC}
{$IFDEF DPMI}
 {$M 16384}
{$ELSE}
 {$M 32768,0,655360}
{$ENDIF}
Uses
 Adele,
 {$IFNDEF DPMI}
  Overlay,
 {$ENDIF}
 MalBInit,MBBCrtex,MBBStart,MalBEnv;

{ Appuyez sur 췈trl+Enter� � cot� de �$O� sur le nom afin d'ouvrir une
 fen늯re permettant de le visualiser le fichier...
}

{$O Agenda}   {Agenda, bottin de t굃굋hone personnel}
{$O AppDB}    {Application base de donn괻s}
{$O Arcade}   {Arcade, animation et 괹onomiseur d'괹ran}
{$O C2Pas}    {Unit� pour transformer le C � Pascal }
{$O CalcLoad} {Chargement des fichiers tableurs}
{$O CalcSave} {Sauvegarde des fichiers tableurs}
{$O CalcTool} {Outils du tableur }
{$O ChkMouse} {Teste de v굍ification de la souris}
{$O Compiler} {Unit� pour compiler avec C2Pas}
{$O DialHW}   {Bo똳e de dialogue de configuration mat굍iel }
{$O DialPlus} {Suppl굆ent de dialogue}
{$O DialTree} {Arbre de dialogue}
{$O DrawEdit} {Editeur de dessin}
{$O DrawInfo} {Outil d'information sur un dessin}
{$O DrawKr}   {Traitement des couleurs }
{$O Editor}   {Tra똳ement de texte}
{$O EdtBlock} {Tra똳ement de texte - Gestion des blocs}
{$O EdtDone}  {Terminaison du tra똳ement de texte}
{$O EdtExtra} {Outils suppl굆entaire du tra똳ement de texte}
{$O EdtJust}  {Outils de justification du tra똳ement de texte}
{$O EdtLoad}  {Chargeur de document du tra똳ement de texte}
{$O EdtMacro} {Tra똳ement de texte - Macro}
{$O EdtSave}  {Sauvegarde de document du tra똳ement de texte}
{$O EdtSearc} {Recherche dans le tra똳ement de texte}
{$O FileMana} {Gestionnaire de fichiers}
{$O FontEdt}  {Editeur de police de caract둹es}
{$O FontMana} {Gestionnaire de police de caract둹es}
{$O GloDraw}  {췍lobal Draw�: Visualisateur global de dessin }
{$O Goldnaxe} {Affichage de forme g굊m굏rique complexe}
{$O InfoMemo} {Information sur les composants m굆oires}
{$O Loader}   {Menu d'application texte}
{$O MalCalc}  {Tableur (chiffrier 굃ectronique)}
{$O MalBLibr} {Biblioth둸ue d'outils}
{$O MBBBKRes} {Chargement de fichier de configuration}
{$O MBBSDir}  {Gestionnaire de r굋ertoires}
{$O MBBAbout} {릀ran de pr굎entation (A Propos...)}
{$O MBBConfi} {Changement utilisateur de la configuration}
{$O MBBExit}  {Terminaison du 췔onsterBook�}
{$O MBBInitS} {릀ran de travail du 췔onsterBook�}
{$O MBBInsta} {Installateur du 췔onsterBook� }
{$O MBJoysti} {Gestionnaire de manettes de jeux}
{$O MBBMenu}  {Menu programmable}
{$O MBBOpenC} {Ouvrir au curseur...}
{$O MBBSave}  {Sauvegarde du fichier de configuration}
{$O MBBSearc} {Recherche � effectuer...}
{$O MBBShell} {Appel d'un composant ou application externe}
{$O MBBStart} {D굆arreur du 췔onsterBook�}
{$O Numerix}  {Calculatrice programmable, conversion de donn괻s}
{$O PrnFileM} {Impression du Gestionnaire de fichiers}
{$O ProgMan}  {Gestionnaire de programmes}
{$O Protocol} {Protocol de communication (ASCII, XModem,...)}
{$O QHexView} {릁iteur hexad괹imal}
{$O ResLoadD} {Chargement de base de donn괻s}
{$O ResLoadI} {Chargement de ressources d'image}
{$O ResSaveD} {Sauvegarde de base de donn괻s}
{$O ResSaveI} {Sauvegarde de ressources d'image}
{{$O ResServI}{Service de ressources d'image}
{$O Show}     {Visualisateur d'image}
{$O Sourcer}  {D굎assembleur de code machine}
{$O SysPlus}  {Suppl굆ent au syst둴e d'exploitation}
{$O TechDraw} {Dessin technique}
{$O Terminal} {릑ulateur de terminal}
{$O TMDials}  {Terminal avanc괻}
{$O Tools}    {Outils divers}
{$O ToolDB}   {Outils de base de donn괻s}
{$O ToolDsk}  {Outils disque}
{$O ToolFile} {Outils associ� au Gestionnaire de fichiers}
{$O ToolHead} {Outils d'ent늯e de fichier}
{$O ToolInfo} {Informations syst둴es}
{$O ToolMusi} {Outils pour la musique}
{$O ToolPrn}  {Outils d'impression}
{$O ToolRes}  {Outils de fabrication de ressource}
{$O ToolSoun} {Outils de son}
{$O ToolTask} {Outils de gestionnaires de t긟he}
{$O ToolTerm} {Prompt, Shell,...}
{$O ToolTime} {Outils du temps}
{$O ToolVid}  {Outils vid굊}
{$O ToolView} {Outils de visualisation ASCII}
{$O UnZip}    {D괹ompression de fichiers de format ZIP }

BEGIN
 Initialize;                {D굆arreur du 췔onsterBook� sauf le recouvrement}
 {$IFNDEF DPMI}
  If(SwapEms)Then Begin
   If(SUP^.Verbose)Then WriteLn('V굍ification de la possibilit� de chargement du recouvrement en EMS/XMS...');
   {$IFDEF Overlay}
    OvrInitEms;
   {$ENDIF}
   If OvrResult=0Then Begin
    If(SUP^.Verbose)Then WriteLn('Recouvrement en EMS!');
    OverlayOn:=ooEMS;
    OvrClearBuf;
   End
    Else
   If(SUP^.XmsOvrSwap)Then Begin
    OvrInitXms;
    If OvrResult=0Then Begin
     If(SUP^.Verbose)Then WriteLn('Recouvrement en XMS!');
     OverlayOn:=ooXMS;
     OvrClearBuf;
    End;
   End;
  End;
 {$ENDIF}
 FinishStart;               {Apr둺 le chargement du recouvrement }
 Run;                       {Tra똳ement pour l'utilisateur}
END.