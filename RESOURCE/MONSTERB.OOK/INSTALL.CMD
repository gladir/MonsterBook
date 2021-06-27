/*
   Nouveau scripte d'installation pour le MonsterBook
   Tous droits r‚serv‚s XXIe siŠcle par les Chevaliers de Malte
*/

SIGNAL ON HALT NAME UserAbort

/* Charge l'extensions ®RexxUtil¯ */
IF RxFuncQuery("SysLoadFuncs") THEN DO
    SAY "Chargement des extensions ®RexxUtil¯..."
    CALL RxFuncAdd "SysLoadFuncs","RexxUtil","SysLoadFuncs"
    IF result \= "0" THEN
      CALL FatalError 'Impossible de charger ®RexxUtil.dll¯.'

    CALL SysLoadFuncs
END


/*****************************************************************/
/*                       Routine principal                       */
/*****************************************************************/

installdir = directory() /* R‚pertoire par d‚faut pour l'installation
                            mais peut changer */
CALL greeting
DO forever
  CALL mainmenu
  SELECT
    WHEN option = '1' THEN /* Pleine installation automatique */
      DO
        CALL filemv
        IF installdir <> '' THEN
          DO
            CALL iconcreate
            CALL configedit
            CALL done
          END
        ELSE
          NOP
      END
    WHEN option = '2' THEN /* Copie l'ensemble d'installation au r‚pertoire d'installation */
      CALL filemv
    WHEN option = '3' THEN /* Cr‚ation des ic“nes sur le bureau */
      CALL iconcreate
    WHEN option = '4' THEN /* Edition de l'AUTOEXEC.BAT pour ajouter les r‚pertoires */
      CALL configedit
    WHEN option = '5' THEN /* EXIT */
      CALL MenuExit
    OTHERWISE
      NOP
  END /* select */
END /* do */



/* ----------------------------------------------------------- Show greeting */
Greeting:
CALL SysCls
SAY ''
SAY ' ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿'
SAY ' ³                              MonsterBook                                 ³'
SAY ' ³       Tous droits r‚serv‚s par les Chevaliers de Malte XXIe siŠcle       ³'
SAY ' ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ'
SAY
SAY '  Bienvenue dans l''installation du MonsterBook sous OS/2. Logiciel tous'
SAY '  terrain visant … fonctionner sous n''importe quel systŠme d''exploitation '
SAY '  supportant le mode DOS. AprŠs avoir enfonc‚ la touche ®ENTER¯, nous vous'
SAY '  pr‚senterons la liste des options pour l''installation.'
SAY
SAY '  Si vous voulez une installation sans aucune intervention, choisie le premier'
SAY '  option (l''option 1), sinon vous pouvez choisir les options de 2 … 5 pour'
SAY '  obtenir un plus grand contr“le.'
SAY
CALL DoPause 'Enfoncez une touche pour passer au Menu Principal, ou Ctrl+C pour Quitter.'
RETURN


/*****************************************************************************/
/*                                 Menu Principal                            */
/*****************************************************************************/

mainmenu:
CALL SysCls
SAY ''
SAY ' ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿'
SAY ' ³                              MonsterBook                                 ³'
SAY ' ³       Tous droits r‚serv‚s par les Chevaliers de Malte XXIe siŠcle       ³'
SAY ' ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ'
SAY
SAY '  1.  Installation totalement automatiser (cette option copie les fichiers,'
SAY '      cr‚e les ic“nes, et ‚dite l''®AUTOEXEC.BAT¯.'
SAY
SAY '  2.  Copie les fichiers d''installation du MonsterBook au r‚pertoire'
SAY '      d''installation.'
SAY
SAY '  3.  Cr‚er un dossier et les ic“nes pour le MonsterBook.'
SAY
SAY '  4.  Editer l''®AUTOEXEC.BAT¯ et ajoute une commande ®PATH¯ et ®SET¯ pour'
SAY '      utiliser le MonsterBook sous une ligne de commande.'
SAY
SAY '  5.  Quitter.'
SAY
rc=CHAROUT( ,'  S.V.P. entrez votre choix:  ')
option = SysGetKey('ECHO')
RETURN


/*****************************************************************************/
/*                  Copie les fichiers au r‚pertoire d'installation          */
/*****************************************************************************/

filemv:
CALL SysCls
SAY ''
SAY ' ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿'
SAY ' ³                              MonsterBook                                 ³'
SAY ' ³       Tous droits r‚serv‚s par les Chevaliers de Malte XXIe siŠcle       ³'
SAY ' ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ'
SAY ''
SAY '  Entrez l''unit‚ et le r‚pertoire dans lequel vous d‚sirez installer'
SAY '  le ®MonsterBook¯ (Laissez la ligne blanche si vous annuler l'op‚ration).
SAY
installdir = STRIP(LINEIN())
IF installdir = "" THEN
  RETURN

installdir = STRIP(installdir, "T", "\")

/* V‚rifier le r‚pertoire d'installation */
CALL SysCls
SAY ''
SAY ' ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿'
SAY ' ³                              MonsterBook                                 ³'
SAY ' ³       Tous droits r‚serv‚s par les Chevaliers de Malte XXIe siŠcle       ³'
SAY ' ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ'
SAY ''
SAY '  Le ®MonsterBook¯ va ˆtre install‚ dans "' || installdir ||'".'
SAY
CALL DoPause 'Enfoncez une touche pour l''installation ou Ctrl+C pour quitter.'

/* V‚rifie si le r‚pertoire existe, sinon, le cr‚er */
IF installdir <> "." THEN
  DO
    CALL SysFileTree installdir, "srch", "D"
    IF srch.0 = 0 THEN DO
      rc = SysMkDir(installdir)
      IF rc <> 0 THEN
        CALL FatalError 'Impossible de cr‚er le r‚pertoire "' || installdir || '".'
  END
END

/* Copie le MonsterBook dans le r‚pertoire d'installation */
IF installdir <> "." THEN DO
  '@copy MB.EXE "' || installdir || '" >nul'
  '@copy MB.ICO "' || installdir || '" >nul'
  '@copy MBFOLDER.ICO "' || installdir || '" >nul'
  '@copy MBW.ICO "' || installdir || '" >nul'
  '@copy FRANCAIS.MNB "' || installdir || '" >nul'
  '@copy PROGMAN.INI "' || installdir || '" >nul'
  '@copy ASSISTAN.RLL "' || installdir || '" >nul'
  '@copy ELECTRIC.FNT "' || installdir || '" >nul'
  '@copy FM.BAT "' || installdir || '" >nul'
  '@copy INSTALL.CMD "' || installdir || '" >nul'
  '@copy ISABEL.COL "' || installdir || '" >nul'
  '@copy ISABEL.KEY "' || installdir || '" >nul'
  '@copy LISEZMOI.DOC "' || installdir || '" >nul'
  '@copy MALTE.BMP "' || installdir || '" >nul'
  '@copy MANUEL.RLL "' || installdir || '" >nul'
  '@copy NIII.WAV  "' || installdir || '" >nul'
  '@copy PROUTE.WAV "' || installdir || '" >nul'
  rc = SysMkDir(installdir || "\SYSTEMS")
  IF rc <> 0 THEN
     CALL FatalError 'Impossible de cr‚er le r‚pertoire "' || installdir || '\SYSTEMS".'
  '@copy SYSTEMS\ADELE.RLL "' || installdir || '\SYSTEMS" > nul'
  '@copy SYSTEMS\APP7ILES.RC "' || installdir || '\SYSTEMS" > nul'
  '@copy SYSTEMS\DEBUG.RLL "' || installdir || '\SYSTEMS" > nul'
  '@copy SYSTEMS\EDITOR.RLL "' || installdir || '\SYSTEMS" > nul'
  '@copy SYSTEMS\ENGLISH.GIF "' || installdir || '\SYSTEMS" > nul'
  '@copy SYSTEMS\EXTENSIO.DAT "' || installdir || '\SYSTEMS" > nul'
  '@copy SYSTEMS\FONTS.RLL "' || installdir || '\SYSTEMS" > nul'
  '@copy SYSTEMS\FRANCAIS.GIF "' || installdir || '\SYSTEMS" > nul'
  '@copy SYSTEMS\FRANCAIS.RLL "' || installdir || '\SYSTEMS" > nul'
  '@copy SYSTEMS\KEYTXT.FNT "' || installdir || '\SYSTEMS" > nul'
  '@copy SYSTEMS\MALBOO2.ICN "' || installdir || '\SYSTEMS" > nul'
  '@copy SYSTEMS\MALBOOK.ICN "' || installdir || '\SYSTEMS" > nul'
  '@copy SYSTEMS\MBDRAW.ICN "' || installdir || '\SYSTEMS" > nul'
  '@copy SYSTEMS\MBFM.ICN "' || installdir || '\SYSTEMS" > nul'
  '@copy SYSTEMS\MEDIA.RLL "' || installdir || '\SYSTEMS" > nul'
  '@copy SYSTEMS\MODEM.RLL "' || installdir || '\SYSTEMS" > nul'
  '@copy SYSTEMS\SETUP.INI "' || installdir || '\SYSTEMS" > nul'
  rc = SysMkDir(installdir || "\SPELL")
  IF rc <> 0 THEN
     CALL FatalError 'Impossible de cr‚er le r‚pertoire "' || installdir || '\SPELL".'
  '@copy SPELL\SPELL.DAT "' || installdir || '\SPELL" > nul'
  '@copy SPELL\VERBES.DTA "' || installdir || '\SPELL" > nul'
  IF rc <> 0 THEN
     CALL FatalError 'Impossible de cr‚er le r‚pertoire "' || installdir || '\ICON".'
  '@copy ICON\*.ICO "' || installdir || '\ICON" > nul'
  IF rc <> 0 THEN
     CALL FatalError 'Impossible de cr‚er le r‚pertoire "' || installdir || '\ICON\SETUP".'
  '@copy ICON\SETUP\*.ICO "' || installdir || '\ICON\SETUP" > nul'
  IF rc <> 0 THEN
     CALL FatalError 'Impossible de cr‚er le r‚pertoire "' || installdir || '\HLP".'
  '@copy HLP\*.HLP "' || installdir || '\HLP" > nul'
  IF rc <> 0 THEN
     CALL FatalError 'Impossible de cr‚er le r‚pertoire "' || installdir || '\FONT".'
  '@copy FONT\*.* "' || installdir || '\FONT" > nul'
END

IF installdir = "." THEN
  installdir = directory()

RETURN


/*****************************************************************************/
/*                          Cr‚e les objets du Bureau                        */
/*****************************************************************************/

iconcreate:
CALL SysCls
SAY ''
SAY ' ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿'
SAY ' ³                              MonsterBook                                 ³'
SAY ' ³       Tous droits r‚serv‚s par les Chevaliers de Malte XXIe siŠcle       ³'
SAY ' ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ'
SAY
SAY '  Pr‚paration des objets de Bureau pour le MonsterBook et les associations'
SAY '  de fichiers avec les extensions GAT'
SAY
CALL DoPause 'Presse une touche pour continuer ou Ctrl+C pour quitter.'

rc = SysCreateObject('WPFolder',,
                     'MonsterBook',,
                     '<WP_DESKTOP>',,
                     'OBJECTID=<MonsterBook_FOLDER>;',
                     ';ALWAYSSORT=NO;',
                     ';OPEN=ICON;',
                     ';ICONFILE=' || installdir || '\MBFOLDER.ICO',,
                      'replace')
IF (rc <> 1) THEN
  CALL FatalError 'Impossible de cr‚er le Dossier ®MonsterBook¯.'

rc = SysCreateObject('WPProgram',,
                     'MonsterBook',,
                     '<MonsterBook_FOLDER>',,
                     'PROGTYPE=VDM;EXENAME='||installdir||'\MB.EXE;',
                     ';OBJECTID=<MonsterBook>;',
                     'ICONFILE=' || installdir || '\MB.ICO',
                     ';SET DOS_FILES=30',
                     ';SET DOS_HIGH=1',
                     ';SET DOS_UMB=1',
                     ';SET HW_ROM_TO_RAM=1',
                     ';SET VIDEO_RETRACE_EMULATION=1',
                     ';SET XMS_MEMORY_LIMIT=8192',
                     ';ASSOCFILTER=*.GAT',
                     ';PARAMETERS=/UMB',
                     ';STARTUPDIR=' || installdir || ';',,
                     'replace')
IF (rc <> 1) THEN
  CALL FatalError 'Impossible de cr‚er l''objet ®MonsterBook¯.'

rc = SysCreateObject('WPProgram',,
                     'Gestionnaire de fichiers',,
                     '<MonsterBook_FOLDER>',,
                     'PROGTYPE=VDM;EXENAME=' || installdir ||'\FM.BAT;',
                     ';ICONFILE=' || installdir || '\ICON\WINFILE.ICO',
                     ';STARTUPDIR=' || installdir || ';',,
                     'replace')
IF (rc <> 1) THEN
  CALL FatalError 'Impossible de cr‚er le ®Gestionnaire de fichiers¯.'

rc = SysCreateObject('WPProgram',,
                     'Page du MonsterBook',,
                     '<MonsterBook_FOLDER>',,
                     'EXENAME=NETSCAPE.EXE;',
                     ';PARAMETERS=' || 'http://www3.sympatico.ca/dinosaure/monster.htm;',,
                     'replace');
IF (rc <> 1) THEN
  CALL FatalError 'Impossible de cr‚er la page du ®MonsterBook¯.'

rc = SysCreateObject('WPProgram',,
                     'Page des Chevaliers de Malte',,
                     '<MonsterBook_FOLDER>',,
                     'EXENAME=NETSCAPE.EXE;',
                     ';PARAMETERS=' || 'http://www3.sympatico.ca/dinosaure/',,
                     'replace');
IF (rc <> 1) THEN
  CALL FatalError 'Impossible de cr‚er la page des ®Chevaliers de Malte¯.'

RETURN

/*****************************************************************************/
/*                             diter l'®AUTOEXEC.BAT¯                       */
/*****************************************************************************/

configedit:
PARSE UPPER VALUE VALUE( "PATH",, "OS2ENVIRONMENT" ) WITH "\OS2\SYSTEM" -2 bdrive +2
CALL SysCls
SAY ''
SAY ' ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿'
SAY ' ³                              MonsterBook                                 ³'
SAY ' ³       Tous droits r‚serv‚s par les Chevaliers de Malte XXIe siŠcle       ³'
SAY ' ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ'
SAY
SAY '  Pr‚paration de l'‚dition de l''®AUTOEXEC.BAT¯.
SAY
CALL DoPause 'Presse une touche pour continuer ou Ctrl+C pour quitter.'

/*'@attrib -r -s -h ' || bdrive || '\autoexec.bat >nul'
'@copy ' || bdrive || '\autoexec.bat "' || installdir ||'" >nul'
'@copy ' || bdrive || '\autoexec.bat ' || bdrive || '\autoexec.bak >nul'
'@del '|| bdrive || '\autoexec.bat >nul'

configsys=bdrive || '\config.bak'
newconfig=bdrive || '\config.sys'

rc = STREAM(configsys,'c','open read')
IF (rc \= 'READY:') THEN
  CALL FatalError 'Could not open "' || configsys || '" (rc=' || rc || ')'

rc = STREAM(newconfig,'c','open write')
IF (rc \= 'READY:') THEN
  CALL FatalError 'Could not open "' || newconfig || '" (rc=' || rc || ')'

DO WHILE LINES( configsys )
  configline=LINEIN( configsys )
  PARSE UPPER VAR configline editline
  PARSE UPPER VAR installdir cinstalldir
  IF LEFT( editline, 7) = 'LIBPATH' THEN
    DO
      IF POS( cinstalldir, editline ) = 0 THEN
        DO
          configline = STRIP(configline, "T", " ")
          configline = STRIP(configline, "T", ";")
          rc=LINEOUT( newconfig, configline || ';' || installdir || ';' )
        END
      ELSE
        rc=LINEOUT( newconfig, configline )
    END
  ELSE
    IF LEFT( editline, 8) = 'SET PATH' THEN
      DO
        IF POS( cinstalldir, editline ) = 0 THEN
          DO
            configline = STRIP(configline, "T", " ")
            configline = STRIP(configline, "T", ";")
            rc=LINEOUT( newconfig, configline || ';' || installdir || ';' )
          END
        ELSE
          rc=LINEOUT( newconfig, configline )
      END
    ELSE
      rc=LINEOUT( newconfig, configline )
END
rc=STREAM( configsys, 'c', 'close' )
rc=STREAM( newconfig, 'c', 'close' )

CALL CheckConfig*/
RETURN


/* -------------------------------------------------------------------- Done */
Done:
CALL SysCls
SAY ''
SAY ' ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿'
SAY ' ³                              MonsterBook                                 ³'
SAY ' ³       Tous droits r‚serv‚s par les Chevaliers de Malte XXIe siŠcle       ³'
SAY ' ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ'
CALL CheckConfig
SAY
SAY '  Installation du MonsterBook est compl‚ter, si vous avez effectuer une mise'
SAY '  … jour de l''®AUTOEXEC.BAT¯, red‚marrer la session.'
SAY
CALL DoPause 'Presse une touche pour finir.'
EXIT


/* ---------------------------------------------------------- Exit from menu */
MenuExit:
CALL SysCls
SAY ''
SAY ' ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿'
SAY ' ³                              MonsterBook                                 ³'
SAY ' ³       Tous droits r‚serv‚s par les Chevaliers de Malte XXIe siŠcle       ³'
SAY ' ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ'
SAY
SAY '  Bonne journ‚e!'
SAY
EXIT


UserAbort:
  SAY
  SAY
  SAY '  *** Installation du MonsterBook abord‚e ***'
  CALL CheckConfig
  EXIT

FatalError:
  PARSE ARG msg
  SAY
  SAY ''
  SAY '  Error: ' || msg
  CALL CheckConfig
  EXIT

CheckConfig:
/*  PARSE UPPER VALUE VALUE( "PATH",, "OS2ENVIRONMENT" ) WITH "\OS2\SYSTEM" -2 bdrive +2
  cfgerror = 0
  IF (STREAM( bdrive || '\config.sys', 'c', 'Query Exists' ) = '' ) THEN
    cfgerror = 1
  ELSE
    IF (STREAM( bdrive || '\config.sys', 'c', 'Query Size' ) < 100 ) THEN
      cfgerror = 2

  IF (cfgerror > 0) THEN DO
    SAY
    SAY 'DO NOT REBOOT NOW!!!'
    SAY

    IF (cfgerror = 1) THEN
      SAY 'Something went very wrong, your config.sys is gone...'
    ELSE
      SAY 'Something went very wrong, your config.sys is very small...'

    SAY
    SAY 'There should be two backups of your config.sys file:'
    SAY ' 1) A config.amp file in the root directory of your boot drive.'
    SAY ' 2) A copy of your config.sys in the directory where you chose to install'
    SAY '    WarpAMP.'
    SAY
    SAY 'To restore your config.sys, locate one of the backups and copy it to'
    SAY 'config.sys in the root directory of your boot drive. Remeber, YOU MUST'
    SAY 'RESTORE IT BEFORE YOU REBOOT!!!'
    SAY
    CALL DoPause 'Press any key when you have read the above information.'
    EXIT
  END
*/
RETURN

DoPause:
  PARSE ARG msg
  DO WHILE (CHARS() > 0)
    pk = SysGetKey('NOECHO')
  END
  rc = CHAROUT(,'  ' || msg);
  pk = SysGetKey('NOECHO')
  SAY

  RETURN