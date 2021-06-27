{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                                                              Û
 ³        ..    ..  ...  ..   ..  ....  ..... ..... ......      Û
 ³        ........ .. .. ...  .. ..  ..   ..  ..  .  ..  ..     Û
 ³        .. .. .. .. .. .... ..  ....    ..  ...    .....      Û
 ³        ..    .. .. .. .. .... .. ..    ..  ..  .  .. ..      Û
 ³        ..    ..  ...  ..  ...  ...     ..  ..... .... ..     Û
 ³                                                              Û
 ³                 +++++   ++++   ++++  ++  ++                  Û
 ³                  ++ ++ ++  ++ ++  ++ ++ ++                   Û
 ³                  ++++  ++  ++ ++  ++ ++++                    Û
 ³                  ++ ++ ++  ++ ++  ++ ++ ++                   Û
 ³                 +++++   ++++   ++++  ++  ++                  Û
 ³                                                              Û
 ³                   Distribution Bureautique                   Û
 ³                                                              Û
 ³                             pour                             Û
 ³                                                              Û
 ³ L'ensemble Malte Genesis III,IV & V: Isabel, Chantal & AdŠle Û
 ³ Tous droits r‚serv‚s par les Chevaliers de Malte XXIe siŠcle Û
 ³                                                              Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Nom du programmeur
 ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

  Joseph Gabriel Sylvain Maltais


 Adaptation
 ÍÍÍÍÍÍÍÍÍÍ

  ş Vendredi 13 ao–t 1999,  dit: ®The Furor, Ressurrection and Live after
    Death¯.  En  raison  du  triste  anniversaire de la  perte de donn‚es
    majeur de l'ensemble Genesis et  reconstruit avec une fureur certaine
    de ne pas mourir … cause d'une d‚faillance mat‚riel!


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Application multi-fenˆtre  permettant l'usage  du traŒtement  de texte,
 gestionnaire de fichiers, calculatrice programmable, tableur,...


 Remarques
 ÍÍÍÍÍÍÍÍÍ

  ş Cette application est con‡u pour ˆtre compil‚s avec le Borland Pascal
    7 en mode r‚el. Il peut th‚oriquement support‚ les versions suivantes
    mais ‚tant donn‚e  qu'elles n'ont jamais ‚t‚ test‚ avec ce programme,
    il peut arriver n'importe quoi...

  ş Ce prototype ne supporte convenablement que les modes en 16,  256  et
    65536 couleurs  en mode graphiques,  les autres modes graphiques sont
    trŠs boŒteux pour une raison plus ou moins connue...

  ş Les modes graphiques VESA avec  des plages  de 4 Ko au lieu  de 64 Ko
    comme les initi‚s, ne fonctionne pas correctement dans ce programme.
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

{ Appuyez sur ®Ctrl+Enter¯ … cot‚ de ®$O¯ sur le nom afin d'ouvrir une
 fenˆtre permettant de le visualiser le fichier...
}

{$O Agenda}   {Agenda, bottin de t‚l‚phone personnel}
{$O AppDB}    {Application base de donn‚es}
{$O Arcade}   {Arcade, animation et ‚conomiseur d'‚cran}
{$O C2Pas}    {Unit‚ pour transformer le C … Pascal }
{$O CalcLoad} {Chargement des fichiers tableurs}
{$O CalcSave} {Sauvegarde des fichiers tableurs}
{$O CalcTool} {Outils du tableur }
{$O ChkMouse} {Teste de v‚rification de la souris}
{$O Compiler} {Unit‚ pour compiler avec C2Pas}
{$O DialHW}   {BoŒte de dialogue de configuration mat‚riel }
{$O DialPlus} {Suppl‚ment de dialogue}
{$O DialTree} {Arbre de dialogue}
{$O DrawEdit} {Editeur de dessin}
{$O DrawInfo} {Outil d'information sur un dessin}
{$O DrawKr}   {Traitement des couleurs }
{$O Editor}   {TraŒtement de texte}
{$O EdtBlock} {TraŒtement de texte - Gestion des blocs}
{$O EdtDone}  {Terminaison du traŒtement de texte}
{$O EdtExtra} {Outils suppl‚mentaire du traŒtement de texte}
{$O EdtJust}  {Outils de justification du traŒtement de texte}
{$O EdtLoad}  {Chargeur de document du traŒtement de texte}
{$O EdtMacro} {TraŒtement de texte - Macro}
{$O EdtSave}  {Sauvegarde de document du traŒtement de texte}
{$O EdtSearc} {Recherche dans le traŒtement de texte}
{$O FileMana} {Gestionnaire de fichiers}
{$O FontEdt}  {Editeur de police de caractŠres}
{$O FontMana} {Gestionnaire de police de caractŠres}
{$O GloDraw}  {®Global Draw¯: Visualisateur global de dessin }
{$O Goldnaxe} {Affichage de forme g‚om‚trique complexe}
{$O InfoMemo} {Information sur les composants m‚moires}
{$O Loader}   {Menu d'application texte}
{$O MalCalc}  {Tableur (chiffrier ‚lectronique)}
{$O MalBLibr} {BibliothŠque d'outils}
{$O MBBBKRes} {Chargement de fichier de configuration}
{$O MBBSDir}  {Gestionnaire de r‚pertoires}
{$O MBBAbout} {cran de pr‚sentation (A Propos...)}
{$O MBBConfi} {Changement utilisateur de la configuration}
{$O MBBExit}  {Terminaison du ®MonsterBook¯}
{$O MBBInitS} {cran de travail du ®MonsterBook¯}
{$O MBBInsta} {Installateur du ®MonsterBook¯ }
{$O MBJoysti} {Gestionnaire de manettes de jeux}
{$O MBBMenu}  {Menu programmable}
{$O MBBOpenC} {Ouvrir au curseur...}
{$O MBBSave}  {Sauvegarde du fichier de configuration}
{$O MBBSearc} {Recherche … effectuer...}
{$O MBBShell} {Appel d'un composant ou application externe}
{$O MBBStart} {D‚marreur du ®MonsterBook¯}
{$O Numerix}  {Calculatrice programmable, conversion de donn‚es}
{$O PrnFileM} {Impression du Gestionnaire de fichiers}
{$O ProgMan}  {Gestionnaire de programmes}
{$O Protocol} {Protocol de communication (ASCII, XModem,...)}
{$O QHexView} {diteur hexad‚cimal}
{$O ResLoadD} {Chargement de base de donn‚es}
{$O ResLoadI} {Chargement de ressources d'image}
{$O ResSaveD} {Sauvegarde de base de donn‚es}
{$O ResSaveI} {Sauvegarde de ressources d'image}
{{$O ResServI}{Service de ressources d'image}
{$O Show}     {Visualisateur d'image}
{$O Sourcer}  {D‚sassembleur de code machine}
{$O SysPlus}  {Suppl‚ment au systŠme d'exploitation}
{$O TechDraw} {Dessin technique}
{$O Terminal} {mulateur de terminal}
{$O TMDials}  {Terminal avanc‚e}
{$O Tools}    {Outils divers}
{$O ToolDB}   {Outils de base de donn‚es}
{$O ToolDsk}  {Outils disque}
{$O ToolFile} {Outils associ‚ au Gestionnaire de fichiers}
{$O ToolHead} {Outils d'entˆte de fichier}
{$O ToolInfo} {Informations systŠmes}
{$O ToolMusi} {Outils pour la musique}
{$O ToolPrn}  {Outils d'impression}
{$O ToolRes}  {Outils de fabrication de ressource}
{$O ToolSoun} {Outils de son}
{$O ToolTask} {Outils de gestionnaires de tƒche}
{$O ToolTerm} {Prompt, Shell,...}
{$O ToolTime} {Outils du temps}
{$O ToolVid}  {Outils vid‚o}
{$O ToolView} {Outils de visualisation ASCII}
{$O UnZip}    {D‚compression de fichiers de format ZIP }

BEGIN
 Initialize;                {D‚marreur du ®MonsterBook¯ sauf le recouvrement}
 {$IFNDEF DPMI}
  If(SwapEms)Then Begin
   If(SUP^.Verbose)Then WriteLn('V‚rification de la possibilit‚ de chargement du recouvrement en EMS/XMS...');
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
 FinishStart;               {AprŠs le chargement du recouvrement }
 Run;                       {TraŒtement pour l'utilisateur}
END.