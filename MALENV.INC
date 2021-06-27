{$I DEF.INC}

Uses
  Restex,Systex,Isatex,Dialex
  {$IFDEF FullVersion}
   ,MBCortex
  {$ENDIF}
  {$IFDEF BureauVersion}
   ,MBBCrtex
  {$ENDIF};

Function  GetMaxXTaskBar(Pos:Word):Byte;
Function  GetMaxYPixelsTaskBar:Word;
Procedure PutFreeMemory;
Procedure RefreshWindow;
Procedure Run;
Function  RunFunc(Code:Word):Boolean;
Procedure SetMnuSwitch;
Function  YTaskMnu:Byte;
Procedure LoadHistoryDocument(Var LastDoc:History;Var Q:HistoryDocument);
Procedure SaveHistoryDocument(Var Q:HistoryDocument);

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                IMPLEMENTATION
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses Adele,
     Overlay,
     Memories, {Routines de m‚moire}
     Systems,  {Routines systŠme}
     Registry, {Base de registres}
     Mouse,    {Gestionnaire de souris}
     DialTree, {Dialogue en arbre}
     Video,    {Gestionnaire vid‚o suppl‚mentaire}
     ToolInfo, {Informations systŠmes}
     Tools,    {Outils divers}
     ToolVid,  {Outils vid‚o}
     Apps,     {Gestionnaire d'application}
     Arcade,   {Arcade, animation et ‚conomiseur d'‚cran}
     {$IFDEF Educative}
      Besch,   {Bescherelle (les verbes) }
     {$ENDIF}
     ToolDsk,  {Outils disque}
     ToolPrn,  {Outils d'impression}
     InfoMemo, {Information sur les composants m‚moires}
     MBIdent,  {Fiche d'Identification G‚n‚ral}
     {$IFDEF FullVersion}
      MalInit, {Initialise le recouvrement}
      MBStart, {D‚marreur du ®MonsterBook¯}
      MBAbout, {cran de pr‚sentation (A Propos...)}
      MBOpenCu,{Ouvrir au curseur...}
      MBSave,  {Sauvegarde du fichier de configuration}
      MBSDir,  {Gestionnaire de r‚pertoires}
      MBSearch,{Recherche … effectuer...}
      MBConfig,{Changement utilisateur de la configuration}
      MalLibra,{BibliothŠque d'outils}
      MBInitSc,{cran de travail du ®MonsterBook¯}
      MBShell, {Appel d'un composant ou application externe}
      MBExit,  {Terminaison du ®MonsterBook¯}
     {$ENDIF}
     {$IFDEF BureauVersion}
      MalBInit,{Initialise le recouvrement}
      MBBStart,{D‚marreur du ®MonsterBook¯}
      MBBAbout,{cran de pr‚sentation (A Propos...)}
      MBBOpenC,{Ouvrir au curseur...}
      MBBSave, {Sauvegarde du fichier de configuration}
      MBBSDir, {Gestionnaire de r‚pertoires}
      MBBSearc,{Recherche … effectuer...}
      MBBConfi,{Changement utilisateur de la configuration}
      MalBLibr,{BibliothŠque d'outils}
      MBBInitS,{cran de travail du ®MonsterBook¯}
      MBBShell,{Appel d'un composant ou application externe}
      MBBExit, {Terminaison du ®MonsterBook¯}
     {$ENDIF}
     {$IFDEF DeveloppeurVersion}
      ExplorDB,{Explorateur de Base de donn‚es }
      MalDInit,{Initialise le recouvrement}
      MBDStart,{D‚marreur du ®MonsterBook¯}
      MBDAbout,{cran de pr‚sentation (A Propos...)}
      MBDOpenC,{Ouvrir au curseur...}
      MBDSave, {Sauvegarde du fichier de configuration}
      MBDSDir, {Gestionnaire de r‚pertoires}
      MBDSearc,{Recherche … effectuer...}
      MBDConfi,{Changement utilisateur de la configuration}
      MalDLibr,{BibliothŠque d'outils}
      MBDInitS,{cran de travail du ®MonsterBook¯}
      MBDShell,{Appel d'un composant ou application externe}
      MBDExit, {Terminaison du ®MonsterBook¯}
     {$ENDIF}
     {$IFDEF Joystick}
      MBJoysti,{Gestionnaire de manettes de jeux}
     {$ENDIF}
     Numerix,  {Calculatrice programmable, conversion de donn‚es}
     Editor,   {TraŒtement de texte}
     {$IFDEF Developpeur}
      EditIcon,{Editeur d'ic“ne}
     {$ENDIF}
     Terminal, {mulateur de terminal}
     FileMana, {Gestionnaire de fichiers}
     ToolFile, {Outil associ‚ au gestionnaire de fichiers}
     PrnFileM, {Impression pour le Gestionnaire de fichiers}
     ToolTerm, {Prompt, Shell,...}
     {$IFDEF Bureau}
      MalCalc, {Tableur (chiffrier ‚lectronique)}
     {$ENDIF}
     {$IFDEF Reseau}
      TMDials, {Terminal avanc‚e}
     {$ENDIF}
     Dials,    {Dialogues de base}
     Loader,   {Menu d'application texte}
     DrawEdit, {Editeur de dessin}
     EdtBlock, {TraŒtement de texte - Gestion des blocs}
     ToolSoun, {Outils de son}
     EdtMacro, {TraŒtement de texte - Macro}
     ProgMan,  {Gestionnaire de programmes}
     DialPlus, {Suppl‚ment de dialogue}
     ResServI, {Service de ressources d'image}
     ToolTime, {Outils du temps}
     {$IFDEF Games}
      Tetris,  {Jeux Tetris}
     {$ENDIF}
     EdtLoad,  {Chargeur de document du traŒtement de texte}
     EdtDone,  {Terminaison du traŒtement de texte}
     EdtJust,  {Outils de justification du traŒtement de texte}
     EdtExtra; {Outils suppl‚mentaire du traŒtement de texte}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                    Fonction GetMaxYPixelsTaskBar              Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction retourne la position maximal vertical en pixel ou
 s'affiche la barre de tƒche
}

Function GetMaxYPixelsTaskBar:Word;Begin
 If(HelpBar)Then GetMaxYPixelsTaskBar:=Pred(GetRawY(Succ(YTaskMnu)))
            Else GetMaxYPixelsTaskBar:=GetMaxYPixels;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                      Fonction GetMaxXTaskBar                  Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction retourne la position maximal de la barre de tƒche
 sp‚cifier.
}

Function GetMaxXTaskBar(Pos:Word):Byte;
Var
 Max:Byte;
Begin
 If Pos=Windows.Lst.Count-1Then GetMaxXTaskBar:=TaskBar.MaxX+1
  Else
 Begin
  Max:=TaskBar.MaxX div Windows.Lst.Count;
  GetMaxXTaskBar:=(Max*Pos)+Max-1;
 End;
End;

{ Cette fonction retourne le num‚ro de ligne sur lequel est actuellement
 affich‚ la barre de tƒche.
}

Function YTaskMnu:Byte;Begin
 YTaskMnu:=MaxYTxts-Byte(HelpBar)
End;

Procedure StopPlayMod;Far;Forward;

Procedure PutFreeMemory;
Label WriteMemory;
Var
 GX1,GY1,GY2,XLen:Word;
 Attr:Byte;
 X:Byte;
Begin
 If Not(TaskBar.Visible)Then Exit;
 If GetNmXTxts>40Then Begin
  Attr:=GetAttr(MaxXTxts,YTaskMnu);
  If Not(IsGrf)Then Goto WriteMemory;
  Case(MemoryModel)of
   mmProgressBar:Begin
    XLen:=MemAvail shr 12;
    If(XLen<>PBLastLen)Then Begin
     GX1:=((TaskBar.MaxX+1)shl 3)+2;
     If(SoundIconOnStatus)Then Inc(GX1,24);
     If(CountryIconOnStatus)Then Inc(GX1,24);
     GY1:=GetRawY(YTaskMnu);
     GY2:=GetMaxYPixelsTaskBar-4;
     If XLen<8Then PutFillBox(GX1,GY1+3,GX1+XLen,GY2,LightRed)
      Else
     Begin
      PutFillBox(GX1,GY1+3,GX1+7,GY2,LightRed);
      If XLen<24Then PutFillBox(GX1+8,GY1+3,GX1+XLen,GY2,Yellow)
       Else
      Begin
       PutFillBox(GX1+8,GY1+3,GX1+23,GY2,Yellow);
       PutFillBox(GX1+24,GY1+3,GX1+XLen,GY2,LightGreen);
      End;
     End;
     If XLen<15*8-4Then PutFillBox(GX1+XLen,GY1+3,GetMaxXPixels-1,GY2,Attr shr 4);
     PBLastLen:=XLen;
    End;
   End;
   Else WriteMemory:Begin
    X:=TaskBar.MaxX+3;
    If(CountryIconOnStatus)Then Inc(X,3);
    If(SoundIconOnStatus)Then Inc(X,3);
    PutSmlTxtXY(X,YTaskMnu,StrUSpc(IntToStr(MemAvail),6),Attr);
   End;
  End;
 End;
End;

Procedure SetMnuSwitch;
Var
 X:Byte;
 Ptr:Pointer;
 Editor:^EditorApp Absolute Ptr;
 Tetris:^TetrisGame Absolute Ptr;
 EditDraw:^DrawEditApp Absolute Ptr;
Begin
 DoneMnu;
 If Windows.Lst.Count=0Then Begin
  FillClr(IsLine,8);
  InitMnu(0,0)
 End
  Else
 Begin
  X:=0;
  Ptr:=HPtr(Windows);
  If(HModel(Windows)=wnEdit)Then X:=TEGetViewMode({EditorApp(HPtr(Windows)^)}Editor^);
  InitMnu(HModel(Windows),X);
  Case HModel(Windows)of
   wnEdit:Begin
    IsLine:=False;
    IsBox:=False;
    IsCircle:=False;
    IsPaint:=False;
    IsTrace:=False;
    IsText:=True;
   End;
   wnDraw,wnIcon:Begin
    DrawModeB:=DWGetMode(EditDraw^);
    IsLine:=DrawModeB=drwLine;IsBox:=DrawModeB=drwBox;
    IsCircle:=DrawModeB=drwCircle;IsPaint:=DrawModeB=drwPaint;
    IsTrace:=DrawModeB=drwTrace;IsText:=DrawModeB=drwText;
   End;
   wnTetris:Begin
    IsLine:=Tetris^.InputMode=imJoystick;
    IsBox:=Tetris^.InputMode=imKeyboard;
   End;
  End;
 End;
 PMSetWinBar(0,LnsMnu,MaxXTxts);
 PMPutMnuBar;
 DefEndBar;
End;

Procedure SetDrawMode(M:Byte);Begin
 DrawModeB:=M;
 Case(HModel(Windows))of
  {$IFDEF Developpeur}
   wnIcon:IESetMode(IconEditApp(HPtr(Windows)^),DrawModeB);
  {$ENDIF}
  wnDraw:DWSetMode(DrawEditApp(HPtr(Windows)^),DrawModeB);
 End;
 IsLine:=DrawModeB=drwLine;IsBox:=DrawModeB=drwBox;
 IsCircle:=DrawModeB=drwCircle;IsPaint:=DrawModeB=drwPaint;
 IsTrace:=DrawModeB=drwTrace;IsText:=DrawModeB=drwText;
End;

Function IsValidFunc(X:Byte):Boolean;Begin
 IsValidFunc:=False;
 If(X)in(cmdDefault)Then IsValidFunc:=True
  Else
 If Not ALIsEmpty(Windows.Lst)Then Begin
  If(X)in(cmdDefaultOpen)Then IsValidFunc:=True
  else IsValidFunc:=X in cmdWn[HModel(Windows)];
 End;
End;

{PRIVATE}
Procedure TextAttrTxt(Attr:Byte);Near;
Var
 Ptr:Pointer;
 Editor:^EditorApp Absolute Ptr;
 Calc:^SuperCalcApp Absolute Ptr;
Begin
 Ptr:=HPtr(Windows);
 Case HModel(Windows)of
  wnEdit:TESetChrType(Editor^,Editor^.ChrAttr or Attr);
  wnSuperCalc:SCUnderline(Calc^);
 End;
End;

{PUBLIQUE}
Procedure BoxMode;Far;Begin
 {$IFDEF Games}
  If(HModel(Windows)=wnTetris)Then Begin
   IsLine:=False;
   IsBox:=True;
   TetrisInputMode(HPtr(Windows)^,imKeyboard);
  End
   Else
 {$ENDIF}
 SetDrawMode(drwBox)
End;

Procedure CenterText;Far;Begin
 If(HModel(Windows)=wnEdit)Then TECenterTxt(EditorApp(HPtr(Windows)^))
End;

Procedure ChangeCurrentBoard;Begin
 Case HModel(Windows)of
  wnFileManager:FMChgBoard(FileManagerApp(HPtr(Windows)^));
 End;
End;

Procedure CircleMode;Far;Begin
 SetDrawMode(drwCircle)
End;

Procedure CloseAllExit;Far;Begin
 If Windows.Lst.Count>0Then Begin
  CurrEdit:=0;
  While Windows.Lst.Count>0do If Not(ClsWn)Then Begin
   GetSysErr:=errUser;
   Exit;
  End;
 End;
End;

Procedure CloseAllWindows;Far;Begin
 If Windows.Lst.Count>0Then Begin
  CloseAllExit;
  If(GetSysErr<>errUser)Then Begin
   PutFreeMemory;
   SetMnuSwitch;
  End;
 End;
End;

Procedure SaveHistoryDocument(Var Q:HistoryDocument);Begin
 Q.Len:=514;
 CreateKeyFormat(HKEY_CURRENT_USER,'Software\Windows9X\StartMenu','Document',tdBlob,Q)
End;

Procedure LoadHistoryDocument(Var LastDoc:History;Var Q:HistoryDocument);Begin
 FillClr(Q,SizeOf(Q));
 HYInitTo(LastDoc,512,@Q.History);
 If ReadMainKey(HKEY_CURRENT_USER,'Software\Windows9X\StartMenu','Document',Q)Then Begin
  HYSetSizeBuffer(LastDoc,Q.EndCmd);
 End;
End;

Procedure CloseWindow;Far;
Var
 S:String;
 Q:HistoryDocument;
 LastDoc:History;
Begin
 S:='';
 Case HModel(Windows)of
  wnEdit:S:=EditorApp(HPtr(Windows)^).EditName;
{  wnView:S:=VA(HPtr(Windows)^).FileName;}
  wnIcon:S:=IconEditApp(HPtr(Windows)^).Name;
  wnDraw:S:=DrawEditApp(HPtr(Windows)^).FileName;
  wnDataBase:S:=DataBaseApp(HPtr(Windows)^).DataBase.FileName;
 End;
 If Not {HClose(Windows)}(ClsWn)Then Begin
  GetSysErr:=errUser;
  Exit;
 End
  Else
 If S<>''Then Begin
  LoadHistoryDocument(LastDoc,Q);
  HYQueue(LastDoc,S);
  Q.EndCmd:=HYGetSizeBuffer(LastDoc);
  SaveHistoryDocument(Q);
 End;
 SetMnuSwitch;
 PutFreeMemory;
End;

Procedure CopyBlock;Far;Begin
 TECpyBlk(EditorApp(HPtr(Windows)^))
End;

Procedure DeleteCurrLine;Far;Begin
 Case(HModel(Windows))of
  wnEdit:TEDelCurrLn(EditorApp(HPtr(Windows)^));
 End;
End;

Procedure Dn;Far;Begin
 Case HModel(Windows)of
  wnEdit:TEkDn(EditorApp(HPtr(Windows)^));
 End;
End;

Procedure DrawChangePageIcon;Begin
 {$IFDEF Developpeur}
  If(HModel(Windows)=wnIcon)Then IEChgPg(IconEditApp(HPtr(Windows)^))
 {$ELSE}
  ErrNoMsgOk(errNotFoundInDistribution);
 {$ENDIF}
End;

Procedure DrawMode;Begin
 If(HModel(Windows)=wnEdit)Then Begin
  TESetDrawMode(EditorApp(HPtr(Windows)^),Not(EditorApp(HPtr(Windows)^).DrawMode));
  SetMnuSwitch;
 End;
End;

Procedure DrawNewPageIcon;Begin
 {$IFDEF Developpeur}
  If(HModel(Windows)=wnIcon)Then IENewPg(IconEditApp(HPtr(Windows)^))
 {$ELSE}
  ErrNoMsgOk(errNotFoundInDistribution);
 {$ENDIF}
End;

Procedure EditBS;Far;Begin
 PushKey(kbBS)
End;

Procedure EditDel;Far;Begin
 PushKey(kbDel)
End;

{Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure marquer la coordonn‚e  de la fin du bloque  de traŒtement
 du texte en fonction de la position actuel du pointeur texte de la fenˆtre
 d'application courante.
}

Procedure EndBlock;Far;Begin
 TEEndBlk(EditorApp(HPtr(Windows)^))
End;

{Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de d‚place le pointeur texte … la fin de la liste
 de la fenˆtre d'application.
}

Procedure EndTxt;Far;Begin
 PushKey(kbCtrlEnd)
End;

Procedure HomeBlock;Far;Begin
 TEHomeBlk(EditorApp(HPtr(Windows)^))
End;

Procedure HomeTxt;Far;Begin
 PushKey(kbCtrlHome)
End;

Procedure InfoDocument;Far;Begin
 PushKey(kbCtrlF1)
End;

Procedure InfoVideoPrimary;Far;Begin
 VideoInfo(0)
End;

Procedure InfoVideoSecondary;Far;Begin
 VideoInfo(1)
End;

Procedure Left;Far;Begin
 Case HModel(Windows)of
  wnEdit:TEkLeft(EditorApp(HPtr(Windows)^));
 End;
End;

Procedure LnMode;Far;Begin
 {$IFDEF Games}
  If(HModel(Windows)=wnTetris)Then Begin
   IsLine:=True;
   IsBox:=False;
   TetrisInputMode(HPtr(Windows)^,imJoystick);
   {TetrisRec(HPtr(Windows)^).InputMode:=imJoystick;}
  End
   Else
 {$ENDIF}
 SetDrawMode(drwLine)
End;

Procedure NextWn;Far;Begin
 HNext(Windows);
 SetMnuSwitch;
 ClrKbd;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure PaintMode                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure le mode de peinturage dans la fenˆtre courante traŒtant
 des images.
}

Procedure PaintMode;Far;Begin
 SetDrawMode(drwPaint)
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure PgDn                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de passer … l'‚cran suivante dans la fenˆtre
 actuellement en usage s'il n'est pas rendu … la fin de la liste.
}

Procedure PgDn;Far;Begin
 Case HModel(Windows)of
  wnEdit:TEkPgDn(EditorApp(HPtr(Windows)^));
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Proc‚dure PgUp                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de passer … l'‚cran pr‚c‚dent dans la fenˆtre
 actuellement en usage.
}

Procedure PgUp;Begin
 Case HModel(Windows)of
  wnEdit:TEkPgUp(EditorApp(HPtr(Windows)^));
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Proc‚dure PreviousWindow                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de passer … la fenˆtre pr‚c‚dente dans la liste.
 S'il est d‚j… rendu … la premiŠre fenˆtre, il passe … la dernier.  Cette
 op‚ration n'est valable qu'avec 2 fenˆtres minimum.
}

Procedure PreviousWindow;Far;Begin
 HPrevious(Windows);
 SetMnuSwitch;
 ClrKbd;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure PrintDirectory                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'imprimer le contenu du r‚pertoire courant dans
 la fenˆtre courant du gestion de fichiers.
}

Procedure PrintDirectory;Far;Begin
 FMPrnDir(FileManagerApp(HPtr(Windows)^))
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure RefreshWindow                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de r‚actualiser l'affichage vid‚o de la fenˆtre
 actuellement en usage.  S'il n'y en pas d'ouverte,  il r‚actualise tout
 bonnement la toile de fond.
}

Procedure RefreshWindow;Begin
 PutAppTitleBar;
 PutToolBar;
 PBLastLen:=$FFFF;
 BarSpcHor(TaskBar.MaxX+1,YTaskMnu,MaxXTxts,CurrKrs.Menu.Normal);
 PutBarStatusMemory;
 HRefresh(Windows);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                             Proc‚dure Right                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'effectuer un mouvement vers la droite dans une
 fenˆtre supportant cette option.
}

Procedure Right;Far;Begin
 Case HModel(Windows)of
  wnEdit:TEkRight(EditorApp(HPtr(Windows)^));
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure Save                           Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet  de sauvegarder les donn‚es  contenus dans la
 fenˆtre courante sous son nom actuel. S'il n'a pas de nom, il demande
 … l'utilisateur de lui en trouver un.


 Remarque
 ÍÍÍÍÍÍÍÍ

  þ Cette proc‚dure se permet  de faire une mise … jour  du journal de
    bord lors d'une sauvegarde r‚ussi.
}

Procedure Save;Begin
 HSave(Windows);
 If(HModel(Windows)=wnEdit)Then Begin
  WriteLog('Sauvegarde '+EditorApp(HPtr(Windows)^).EditName+' taille actuel: '+
          CStr(EditorApp(HPtr(Windows)^).FileSize)+' octet(s)');
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                    Proc‚dure SetupDirectory                  Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de faire une mise … jour des r‚pertoires
 actuellement en usage dans l'environnement du programme.
}

Procedure SetupDirectory;Far;Begin
 If(SetupDir)Then SaveIni;
End;

Procedure StopPlayMod;Begin
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Proc‚dure TextBold                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet  de changer le format d'attribut des prochains
 caractŠres en mode gras devant ˆtre ‚crit dans le traŒtement de texte.
}

Procedure TextBold;Far;Begin
 TextAttrTxt(cgBold)
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure TextBoldWord                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de fixer l'attribut du mot actuel dans la fenˆtre
 actuellement  en utilisation en mode gras.  Si la fenˆtre ne supporte pas
 cette option, il ne fait rien.
}

Procedure TextBoldWord;Far;Begin
 Case HModel(Windows)of
  wnEdit:TEBoldWord(EditorApp(HPtr(Windows)^));
  wnCDPlayer:CDStop(CDPlayer(HPtr(Windows)^));
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure TextDouble                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet  de changer le format d'attribut des prochains
 caractŠres en mode double largeur devant ˆtre ‚crit dans le traŒtement
 de texte.
}

Procedure TextDouble;Far;Begin
 TextAttrTxt(cgDouble)
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Proc‚dure TextDoubleWord                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de fixer l'attribut du mot actuel dans la fenˆtre
 actuellement en utilisation  en mode double largeur.  Si  la  fenˆtre  ne
 supporte pas cette option, il ne fait rien.
}

Procedure TextDoubleWord;Far;Begin
 Case HModel(Windows)of
  wnEdit:TEDoubleWord(EditorApp(HPtr(Windows)^));
  wnCDPlayer:CDPlayPause(CDPlayer(HPtr(Windows)^));
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                      Proc‚dure TextExposantWord                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de fixer l'attribut du mot actuel dans la fenˆtre
 actuellement en utilisation  en mode exposant.  Si la fenˆtre ne supporte
 pas cette option, il ne fait rien.
}

Procedure TextExposantWord;Far;Begin
 If(HModel(Windows)=wnEdit)Then TEExposantWord(EditorApp(HPtr(Windows)^))
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Proc‚dure TextInverse                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de changer le format d'attribut des prochains
 caractŠres  en mode inverse  devant ˆtre ‚crit  dans le traŒtement de
 texte.
}

Procedure TextInverse;Far;Begin
 TextAttrTxt(cgInverse)
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                      Proc‚dure TextInverseWord                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de fixer l'attribut du mot actuel dans la fenˆtre
 actuellement en utilisation  en mode inverse.  Si la fenˆtre  ne supporte
 pas cette option,  qu'il est dans une fenˆtre de gestionnaire de fichier,
 il inverse les deux tableaux. S'il ne s'agit pas de l'un des deux premier
 cas, alors il ne fait strictement rien.
}

Procedure TextInverseWord;Far;Begin
 Case HModel(Windows)of
  wnEdit:TEInverseWord(EditorApp(HPtr(Windows)^));
  wnFileManager:FMOldOtherBoard(FileManagerApp(HPtr(Windows)^));
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Proc‚dure TextItalic                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de changer le format d'attribut des prochains
 caractŠres  en mode italique devant ˆtre ‚crit  dans le traŒtement de
 texte.
}

Procedure TextItalic;Far;Begin
 TextAttrTxt(cgItalic)
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                      Proc‚dure TextItalicWord                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de fixer l'attribut du mot actuel dans la fenˆtre
 actuellement en utilisation en mode italique.  Si la fenˆtre  ne supporte
 pas cette option, il ne fait rien.
}

Procedure TextItalicWord;Begin
 If(HModel(Windows)=wnEdit)Then TEItalicWord(EditorApp(HPtr(Windows)^))
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure TextMode                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet  de fixer le mode  de travail  d'une image …
 l'utilisation de texte. Il faut bien entendu que la fenˆtre supporte
 cette option.
}

Procedure TextMode;Far;Begin
 SetDrawMode(drwText)
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                      Proc‚dure TextNormalWord                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de fixer l'attribut du mot actuel dans la fenˆtre
 actuellement en utilisation en mode normal. Si la fenˆtre ne supporte pas
 cette option, il ne fait rien.
}

Procedure TextNormalWord;Far;Begin
 Case HModel(Windows)of
  wnEdit:TENormalWord(EditorApp(HPtr(Windows)^));
  {$IFDEF Games}
   wnTetris:TetrisSetLevel(TetrisGame(HPtr(Windows)^));
  {$ENDIF}
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Proc‚dure TextUnderline                    Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de changer le format d'attribut des prochains
 caractŠres en mode soulignement devant ˆtre ‚crit  dans le traŒtement
 de texte.
}

Procedure TextUnderline;Far;Begin
 TextAttrTxt(cgUnderline)
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                      Proc‚dure TextUnderlineWord                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de fixer l'attribut du mot actuel dans la fenˆtre
 actuellement  en utilisation  en mode  soulignement.  Si  la  fenˆtre  ne
 supporte pas cette option, il ne fait rien.
}

Procedure TextUnderlineWord;Far;Begin
 Case HModel(Windows)of
  wnEdit:TEUnderlineWord(EditorApp(HPtr(Windows)^));
  wnFileManager:FMInverseBoard(FileManagerApp(HPtr(Windows)^));
  wnSuperCalc:SCUnderline(SuperCalcApp(HPtr(Windows)^));
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                      Proc‚dure TraceMode                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de fixer le mode tra‡age pour les fenˆtres
 traŒtant des images graphiques.
}

Procedure TraceMode;Far;Begin
 SetDrawMode(drwTrace)
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                               Proc‚dure Up                            Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de monter le pointeur vers le haut de la fenˆtre.
 C'est en fonction du style de fenˆtre...
}

Procedure Up;Far;Begin
 If(HModel(Windows)=wnEdit)Then Begin
  TEkUp(EditorApp(HPtr(Windows)^))
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                              Proc‚dure Up2                            Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de monter le pointeur vers le haut de la fenˆtre.
 C'est  op‚ration  est  effectue  2 fois.  C'est  en fonction  du style de
 fenˆtre...
}

Procedure Up2;Far;Begin
 Up;
 Up;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure Terminate                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure fait  simplement fixer la variable  d'autorisation de
 quitter l'application ®MonsterBook¯/®PowerHacken¯. Elle n'entraŒne pas
 le d‚part imm‚diat, mais est normalement intercept‚e plus loin pour un
 avis usager: ®SouhaŒtez-vous quitter?¯.
}

Procedure Terminate;Begin
 Application.Terminated:=True;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Fonction RunFunc                           Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction ex‚cute une des quelques 250 commandes disponible sous le
 ®MonsterBook¯/®PowerHacken¯.
}

Function RunFunc(Code:Word):Boolean;
Const
 BankCmd:Array[0..cmdMax]of Procedure=(
  Ret,                                                                                     {0=Nulle}
  NewEdt,             OpenEdt,         NewGat,          OpenText,       ViewOption,        { 1 … 5}
  OpenView,           NewSuperCalc,    OpenSuperCalc,   Save,           SaveAs,            { 6 … 10}
  CpyFiles,           MoveFiles,       Delete,          SaveAll,        MakeDirectory,     {11 … 15}
  UserChDir,          Print,           DosShell,        Terminate,      NewDrw,            {16 … 20}
  OpenDrw,            NewIcnEdt,       OpenIcnEdt,      DrawNewPageIcon,DrawChangePageIcon,{21 … 25}
  Ret,                Ret,             CopyClipBoard,   PasteClipBoard, Ret,               {26 … 30}
  Ret,                EdtCurrModeType, EdtChrType,      DrawMode,       EditXChgPg,        {31 … 35}
  LnMode,             BoxMode,         CircleMode,      PaintMode,      TraceMode,         {36 … 40}
  TextMode,           FillMode,        EditDel,         EditBS,         SearchFind,        {41 … 45}
  SearchReplace,      SearchAgain,     GotoLn,          GotoRow,        HomeTxt,           {46 … 50}
  EndTxt,             SetTri,          RunFile,         Ret,                               {51 … 54}
  {$IFDEF Developpeur}
   Compile,
  {$ELSE}
   BadDistribution,
  {$ENDIF}
  CompFile,           CompFile,        Ret,             Ret,            Ret,               {56 … 60}
  Ret,                Ret,             SetFormat,       Ret,            Ret,               {61 … 65}
  SetupDirectory,     PrintersSetup,   ChgVidMode,      ChgFont,        VideoEnvironnement,{66 … 70}
  SetScrnSaver,       Env,                                                                 {71 … 72}
  {$IFDEF Reseau}
   BBSWelcome,
  {$ELSE}
   BadDistribution,
  {$ENDIF}
  Ret,                ChangeCurrentBoard,                                                  {74 … 75}
  EditMenuApplication,SetPassWord,     RunLoader,       WnFM,           WnPrompt,          {76 … 80}
  WnMUnix,            WnWatch,         NewTerm,         LookOutput,     TileWindows,       {81 … 85}
  Ret,                CloseAllWindows, RefreshWindow,   Ret,            Zoom,              {86 … 90}
  NextWn,             PreviousWindow,  CloseWindow,     LstEdt,         About,             {91 … 95}
  CountryInfo,        SomaryInfo,      InfoVideoPrimary,InfoVideoSecondary,InfoFont,       {96 … 100}
  MemInfo,            MCBInfo,         CmosInfo,        ModemDoctor,    ViewDownload,      {101 … 105}
  InfoDocument,
  {$IFDEF Reseau}
   RunBBS,
  {$ELSE}
   BadDistribution,
  {$ENDIF}
  ExecuteMacro,    OpenMacro,      DelSpc,            {108 … 110}
  DeleteCurrLine,     CenterText,      TextDoubleWord,  TextBoldWord,   TextUnderlineWord, {111 … 115}
  TextInverseWord,    InfoDocument{Autopsy},HelpOnLine, HelpKey,        OpenAssembler,     {116 … 120}
  OpenBasic,          OpenC,           OpenEuphoria,    OpenFortran,    OpenIni,           {121 … 125}
  OpenPascal,         OpenRC,          EditMainMenu,    EditFileMenu,   Ret,               {126 … 130}
  OpenAC,             OpenBasAppleII,  OpenBasCK64,     OpenBasCoco3,                      {131 … 134}
  {$IFDEF Reseau}
   OriginateMode,
  {$ELSE}
   BadDistribution,
  {$ENDIF}
  OpenCobol,          OpenMod,         _OpenDataBase,   Filtre, {136 … 139}
  {$IFDEF Educative}
   InputSearchVerb,
  {$ELSE}
   BadDistribution,
  {$ENDIF}
  RunCDPlayer,        Correcteur,      PasteOS2File,    LookLog,        StartPartition,    {141 … 145}
  SetClock,           FullScrn,        UserConversionFormula,NewProgMan,Calendar,          {146 … 150}
  SetImageBar,        WallPaper,       InsertImage,     Ret,            Ret,               {151 … 155}
  Ret,                Execute,         Ret, {156 … 158}
  {$IFDEF Developpeur}
   SQLCommand,       {159}
  {$ELSE}
   BadDistribution,  {159}
  {$ENDIF}
  XAltF1Key,         {160}
  ChangeDiskOnBoard2, Ret,             __HardDiskPark,  Ret,            DskHex,            {161 … 165}
  Format,             Ret,             Ret,             Ret,            Ret,               {166 … 170}
  InverseWildCard,    UnSelectWildCard,SelectWildCard,  Conv2Pas,       Ret,               {171 … 175}
  TextItalicWord,     DelWord,         WinGlobalDraw,   PgUp,           Ret,               {176 … 180}
  Ret,                InsCol,          Ret,             Ret,            TextBold,          {181 … 185}
  TextDouble,         TextItalic,      TextInverse,     TextUnderline,  SetColor,          {186 … 190}
  RunPlayMod,         StopPlayMod,     Ret,             DskInfo,        CloseAllWnSaved,   {191 … 195}
  PgUp,               PgDn,            Left,            Right,          Up,                {196 … 200}
  Up2,                Dn,              SoundCardInfo,   Ret,            Ret,               {201 … 205}
  {$IFDEF Educative}
   Bescherelle,
  {$ELSE}
   BadDistribution,
  {$ENDIF}
  PrintDirectory,     RenameVolume,    HomeBlock,       EndBlock,                          {207 … 210}
  CopyBlock,          Ret,             WriteBlock,      SetRead,        SetSystems,        {211 … 215}
  GotoPage,           TextExposantWord,SetupMouse,      InsFile,        SetApplication,    {216 … 220}
  TextNormalWord,     OpenFileAtCursor,FileSetAttribut,                                    {221 … 223}
  {$IFDEF Reseau}
   AnswerMode,        {224}
   HangUpPhone,       {225}
   Upload,            {226}
   Download,          {227}
  {$ELSE}
   BadDistribution,   {224}
   BadDistribution,   {225}
   BadDistribution,   {226}
   BadDistribution,   {227}
  {$ENDIF}
  SetupJoystick,      CloseAllExit,   OpenDebug,         {228 … 230}
  ClearPrinter,       DelSel,          CopySelect,      AgendaWindow,   MakeCadre,         {231 … 235}
  {$IFDEF Developpeur}
   SetupSourcer,      {236}
  {$ELSE}
   BadDistribution,   {236}
  {$ENDIF}
  SetupKeyboard,      JoystickInfo,    KeyboardInfo,    NewFont,           {237 … 240}
  OpenFont,           MouseInfo,       RunScrnSaver,    SetupSecurity,  NewElectric,       {241 … 245}
  Ret,                NewDFD,          EdtSetMtx,       SetPaletteKr,   NewTechDraw,       {246 … 250}
  SetSonVolume,       SetEquilizer,    CleanCurrDisk,   SearchProc,     OpenTechDraw,      {251 … 255}
  ChangeCase,         LineHor,         SautPage,        ConfigBasic,    SetupDataBase,     {256 … 260}
  SetupCompress,      ChangeCountry,   ManagerPeripheric,PromptDRDOS,   PromptMSDOS,       {261 … 265}
  PromptNDOS,         PromptOS2,       PromptVAX,       PromptWindows9X,NewDataBase,       {266 … 270}
  {$IFDEF Developpeur}
   NewBasic,     {271}
  {$ELSE}
   BadDistribution,
  {$ENDIF}
  ConfigJoystick, SetupModem, {272 … 273}
  {$IFDEF Developpeur}
   NewExplorerDB, {274}
  {$ELSE}
   BadDistribution, {274}
  {$ENDIF}
  EditIdentification,{275}
  AppCopyDiskToFile, { 276}
  AppMapFAT,         {277}
  AppDiskCopy,       {278}
  OpenWorkShop,      {279}
  OpenAtlas,         {280}
  PromptAmigaDOS     {281}
 );
Begin
 GetSysErr:=0;
 If Code>=$F000Then Dec(Code,$F000);
 If(Code<=cmdMax)Then BankCmd[Code];
 RunFunc:=GetSysErr<>errUser;
End;

Procedure RunButton(BK:Byte);Begin
 Case(BK)of
   0:OpenEdt;
   1:OpenDrw;
   2:OpenIcnEdt;
   3:OpenSuperCalc;
   4:ChangeCountry;
   6:SearchFind;
   8:SearchAgain;
   9:Print;
  10:NewTerm;
  11:SetupKeyboard;
  12:RunPlayMod;
  14:WnPrompt;
  15:Begin
   {$IFDEF Developpeur}
    Compile;
   {$ELSE}
    ErrNoMsgOk(errNotFoundInDistribution);
   {$ENDIF}
  End;
  16:SomaryInfo;
  17:LstEdt;
  18:HelpOnLine;
 End;
End;

Procedure Run;
Label MainMenu,Title,ChkF,InpXit;
Var
 LK,K,I:Word;
 Path:PathStr;
 Ok:Boolean;
Begin
 LK:=0;
 Repeat
  Repeat
   K:=HRun(Windows);
   Ok:=No;LK:=PrvKey;
   For I:=0to(Application.MaxAccelerators)do Begin
    If(Application.PAccelerators^[I].KeyB=K)and(Application.PAccelerators^[I].KeyA=LK)Then Goto ChkF;
   End;
   If Not(Ok)Then For I:=0to(Application.MaxAccelerators)do
    If(Application.PAccelerators^[I].KeyB=kbNoKey)and(Application.PAccelerators^[I].KeyA=K)Then Begin
 ChkF:If IsValidFunc(Application.PAccelerators^[I].Option)Then Begin
      Ok:=Ya;LK:=0;K:=0;
      RunFunc(Application.PAccelerators^[I].Option);
      Break;
     End;
    End;
   If Not(Ok)Then Case(K)of
    7:MnuInfo;
    10:EnregPrg(No);
    kbMenuApp:RunLoader;
    kbWindows95Menu:PushKey(kbAltF);
    kbWindows95Left:PreviousWindow;
    kbWindows95Right:NextWn;
    kbMouse:Begin
     If LastMouseY=0Then Begin
      WaitMouseBut0;
      If(LastMouseX<CloseIconLen)Then Terminate
                              Else Goto Title;
     End
      Else
     If(LastMouseY=LnsMnu)Then Begin
MainMenu:
      WaitMouseBut0;
      If LastMouseB=2Then Begin
       TitleMenu
      End
       Else
      PMGetMnuBar(LastMouseX,LastMouseY);
     End
      Else
     If(LastMouseY=YTaskMnu)Then Begin
      WaitMouseBut0;
      If(LastMouseX<=TaskBar.MaxX)Then SwitchTaskBar
                                  Else MemoryMenu;
     End
      Else
     If(LastMouseY>LnsMnu+Windows.HomeYEditor)and(LastMouseY<YTaskMnu)Then Begin
      LocalMenuFont;
     End
      Else
     Begin
      WaitMouseBut0;
      RunButton(BMGetBut(But,LastMouseX,LastMouseY));
     End;
    End;
    kbInWn:OpenFileAtCursor;
    kbHexView:CallHexView;
    kbPartitionManager:OpenPartitionManager;
    kbOpenWorkShop:OpenWorkShop;
    kbRun:Begin
     {$IFDEF Developpeur}
      Compile;
     {$ELSE}
      ErrNoMsgOk(errNotFoundInDistribution);
     {$ENDIF}
    End;
    kbView:_OpenFileAtCursor(acView);
    kbLoad:_OpenFileAtCursor(acLoad);
    kbEdit:OpenX(255);
    kbEditImage:EditImage;
    kbShiftIns:PasteClipboard;
    kbCtrlIns:CopyClipboard;
    kbSendMail:SendMail;
{    kbUp:PushKey(kbAltF);}
    kbEsc:If Windows.Lst.Count<>0Then Case(HModel(Windows))of
     wnMnu:CloseWindow;
     wnHexView:If(HLastModel(Windows)=wnFileManager)Then CloseWindow;
     wnView:If(HLastModel(Windows)=wnFileManager)or(ViewAsciiApp(HPtr(Windows)^).View=Hlp)Then CloseWindow;
    End;
    kbEnter:Case HModel(Windows)of
     wnSearchFiles:OpenSearchFiles;
     wnFileListBox:_OpenSelection;
     wnMnu:ExecMenu;
     wnFileManager:CallFile(False);
     wnProgMan:Begin
      If(ProgramsManagerApp(HPtr(Windows)^).Mode=mWin9X)Then Win9XMenu(0)
      Else RunApp(ProgramsManagerApp(HPtr(Windows)^).CurrProg);
     End;
    End;
    kbClose:CloseWindow;
    kbZoom:Begin
     WaitMouseBut0;
     Zoom;
    End;
    kbTaskBar:Begin
     WaitMouseBut0;
     HInTaskBar(Windows);
    End;
    kbPrgClsIcon:Terminate;
    kbPrgTitle:Begin
Title:
     If LastMouseB=2Then TitleMenu Else
     If(LnsMnu=0)and(LastMouseB=1)Then Goto MainMenu Else
     If(LastMouseX>=Dialex.TimeX)Then SetClock
                                 Else About;
    End;
    kbRefresh:Begin
     HRefreshOtherWindows(Windows);
     HRefreshBackground(Windows);
    End;
    kbRefreshTaskBar,$FFFF:SetMnuSwitch;
    Else Begin
     If(Hi(K)>=$F0)and(K<=mbMax)Then RunFunc(K)Else
     If IsAltCode(K)Then Begin
      If(HModel(Windows)=wnEdit)Then Begin
       Path:=SetPath4AddFile(StrPas(PathMac))+'ALT'+AltCode2ASCII(K)+'.MAC';
       If Not FileExist(Path)Then MakeMacro(Path)
       Else TEExecMacro(EditorApp(HPtr(Windows)^),Path);
      End;
     End;
    End;
   End;
   If(Application.Terminated)Then Begin
    If(Application.FastFinish)and(ExitLevel=xlRestart)Then Break;
 InpXit:If __InputExit('Etes-vous certain de quitter ?')Then Break
     Else
    Begin
     K:=0;ExitLevel:=xlNormal;
     Application.Terminated:=False; { Abandonner l'op‚ration de quitter }
    End;
   End;
   LK:=K;
  Until No;
 Until Xit;
End;
