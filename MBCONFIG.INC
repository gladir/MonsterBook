{$I DEF.INC}

Procedure AssistantConfig;
Procedure ChangeCountry;
Procedure ChangeLanguage;
Procedure ChgVidMode;
Procedure ConfigBasic;
Procedure ConfigJoystick;
Procedure Control;
Procedure EdtChrType;
Procedure EdtCurrModeType;
Procedure Env;
Procedure SetApplication;
Procedure SetClock;
Procedure SetEquilizer;
Procedure SetImageBar;
Procedure SetSonVolume;
Procedure SetPaletteKr;
Procedure SetPassWord;
Procedure SetScrnSaver;
Procedure SetSoundWindows;
Procedure SetSystems;
Procedure SetWindows9X;
Procedure SetupCompress;
Procedure SetupDataBase;
Procedure SetupKeyboard;
{$IFDEF Reseau}
 Procedure SetupModem;
{$ENDIF}
Procedure SetupMouse;
Procedure SetupSecurity;
{$IFDEF Developpeur}
 Procedure SetupSourcer;
{$ENDIF}
Procedure VideoEnvironnement;
Function  _SetPassWord(Config:Boolean):ShortInt;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                IMPLEMENTATION
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses
 Sound,Adele,Math,Arcade,Registry,Systex,Isatex,
 Time,Memories,Systems,Video,Mouse,
 {$IFDEF Developpeur}
  Sourcer,
 {$ENDIF}
 Dials,Disk,Editex,Editor,
 ToolVid,
 {$IFDEF FullVersion}
  MBStart,
  MBBkRes,
  MBCortex,
  MBSave,
  MBSDir,
  MalEnv,
  MalLibra,
  MBInitSc,
 {$ENDIF}
 {$IFDEF Reseau}
  CommBase,
 {$ENDIF}
 {$IFDEF BureauVersion}
  MBBStart,
  MBBBkRes,
  MBBCrtex,
  MBBSave,
  MBBSDir,
  MalBEnv,
  MalBLibr,
  MBBInitS,
 {$ENDIF}
 EdtExtra,EdtLoad,Dialex,FontMana,ResServI,Restex,
 EdtDone,SysPlus,ToolView,ResLoadI,EdtSave,ProgMan,
 {$IFDEF Games}
  Tetris,
 {$ENDIF}
 DialPlus,ToolTerm,DrawEdit,SysInter,ResServD,Apps;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ·}
{³                     Z o n e  P r i v ‚                      º}
{ÔÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼}

Type
 ClockRec=Record
  OldClock:Byte;        { V‚rification du bon moment pour le processus }
  OldBackKbd:Procedure; { Autre processus … ex‚cuter }
  Cx,Cy,Rx,Ry:Word;     { Coordonn‚e de l'horloge et ses rayons }
  HX1,HY1,HX2,HY2:Word; { Coordonn‚e de l'aiguille des heures }
  Sec,Min,Hour:Byte;    { DerniŠre heure relev‚ pour l'horloge }
  BackKr:Byte;          { Couleur d'arriŠre plan }
  P:Byte;               { 0=Ann‚e, 1=Mois, 2=Jour, 3=Heure, 4=Minute, 5=Seconde }
  W:Window;             { BoŒte de dialogue actuellement utilis‚ }
 End;

 ScrnSaverRec=Record
  OldBackKbd:Procedure; { Autre processus … ex‚cuter }
  X1,Y1,X2,Y2:Byte;     { Position o— … lieu l'animation d'‚conomiseur d'‚cran }
  CurrScrn:Byte;        { Num‚ro de l'‚conomiseur d'‚cran courant }
  Q:Record Case Byte of
   ssAniMixingStar:(MixingStar:AniMixingStarRec);
   ssAniMystify:(Mystify:AniMystifyRec);
   ssAniStar:(Star:AniStarRec);
   ssAniStar3D:(Star3D:AniStar3DRec);
   ssAniStarPlus:(StarPlus:AniStarPlusRec);
  End;
  Data:Record
   IsGrf:Boolean;
   ScrnSaverActif:MCheckBox;
   Delay:MRadioButton;
   CurrScrn:MListBox;
   UpDateSS:Procedure(Var R:ResourceWindow;Var Context);
   ContextSS:Pointer;
   Key:Byte;
  End;
 End;

Var
 DataClock:^ClockRec Absolute CurrForm;

Function WEInpOkCancel(Var W:Window):Word;Near;Begin
 WEInpOkCancel:=WEGetkHorDn(W,'$Correcte|Annule')
End;

Procedure WEOkCancel(Var W:Window);Near;Begin
 WEPutkHorDn(W,'$Correcte|Annule')
End;

Procedure MakeAutoExec;
Var
 Handle:Hdl;
 L:ArrayList;
 BootDrv:Char;
Begin
 BootDrv:=Char(GetBootDisk+65);
 If Not FileExist(BootDrv+':\AUTOEXEC.BAT')Then Begin
  Handle:=FileCreate(BootDrv+':\AUTOEXEC.BAT');
  If(Handle<>errHdl)Then Begin
   PutFileTxtLn(Handle,'@ECHO OFF');
   PutFileTxtLn(Handle,'SET MALTE='+MaltePath);
   FileClose(Handle);
  End;
 End
  Else
 Begin
  If ALLoadFileASCII(L,BootDrv+':\AUTOEXEC.BAT')Then Begin
   ALAddStr(L,'SET MALTE='+MaltePath);
   If Not ALSaveFileASCII(L,BootDrv+':\AUTOEXEC.BAT',Ya)Then
    ErrNoMsgOk(WriteErrAutoExec);
   ALDone(L);
  End
   Else
  ErrNoMsgOk(ReadErrAutoExec);
 End;
End;

Procedure EditAutoExec;
Var
 Q:EditorApp;
 W,L:Window;
 K:Word;
 OldDescr:Boolean;
 BootDrv:Char;
Begin
 BootDrv:=Char(GetBootDisk+65);
 OldDescr:=DescrInFile;DescrInFile:=No;
 WEPushEndBar(L);
 WEInit(W,5,5,MaxXTxts-5,MaxYTxts-5);
 WEPushWn(W);
 TEOpen(Q,5,5,MaxXTxts-5,MaxYTxts-5,BootDrv+':\AUTOEXEC.BAT');
 If SysErr=0Then Begin
  TEPushStr(Q,'SET MALTE='+MaltePath);
  PushKey(kbEnter);
  WEPutLastBar('^F2^ Acceptez  ^Esc^ annuler les modifications');
  Repeat
   K:=TERun(Q);
   If(K=kbF2)Then Begin
    TESave(Q);
    Break;
   End;
  Until(K=kbEsc)or(K=kbClose);
 End;
 TEDone(Q);
 WEDone(W);
 WEDone(L);
 DescrInFile:=OldDescr;
End;

Function _SetOS:ShortInt;
Var Data:Record
 Message:String;
 Auto:MRadioButton;
 Key:Byte;
End;
Begin
 _SetOS:=1;
 FillClr(Data,SizeOf(Data));
 Data.Message:='Afin que cette application fonctionne, il est n‚cessaire '+
               'd''effectuer des modifications … l''int‚rieur du fichier '+
               '®AUTOEXEC.BAT¯ en y rajoutant l''instruction suivante: '+
               '®SET MALTE='+MaltePath+
               '¯. Quel op‚ration d‚sirez-vous effectuer?';
 ExecuteAppDPU(88,Data);
 Case(Data.Key)of
  2:_SetOS:=0;
  0,1:Begin
   If Data.Key=1Then _SetOS:=-1;
   Case(Data.Auto.Alignment)of
    0:MakeAutoExec;
    1:{Passer...};
    2:EditAutoExec;
   End;
  End;
 End;
End;

Function SetMainPath:ShortInt;
Label Restart;
Var
 Data:Record
  Path:String;
  Key:Byte;
 End;
Begin
 SetMainPath:=1;
Restart:
 FillClr(Data,SizeOf(Data));
 Data.Path:=MaltePath;
 ExecuteAppDPU(79,Data);
 Case(Data.Key)of
  2:SetMainPath:=0;
  1:Begin
   SetupDir;
   Goto Restart;
  End;
  0:If(MaltePath<>Data.Path)Then StrPCopy(PathSystems,SetPath4AddFile(Data.Path)+'SYSTEMS');
 End;
End;

Procedure ViewReadMe;
Var
 Q:ViewAsciiApp;
 W:Window;
 Path:String;
Begin
 Path:=MaltePath+'LISEZMOI.DOC';
 If FileExist(Path)Then Begin
  WEInit(W,1,5,MaxXTxts-1,MaxYTxts-5);
  WEPushWn(W);
  VAInit(Q,1,5,MaxXTxts-1,MaxYTxts-5,Path,No);
  VARun(Q);
  VADone(Q);
  WEDone(W);
 End;
End;

Function _SetDefaultMode:ShortInt;
Var
 Data:Record
  ModeVideo:Boolean;
  KeyOutput:Byte;
 End;

 Procedure ChgMode;
 Var
  X:Word;
  VideoBios:Array[0..SizeOfVideoBios-1]of Byte;
  LineBuffer:Array[0..1024]of Byte;
  IL,JL:Byte;
  BV:Word;
 Begin
  X:=SelectVideoMode(8,6,wnMax-8,wnMax-6,vmt2);
  If(X<>vmNone)Then Begin
   If SetVideoModeDeluxe(X)Then Begin
    __InitMouse;
    CurrPalette:=$FF;
    MemoryModel:=mmAutoDetect;
    StyleBarTitle:=sttNone;
    InitEnv;
    DefaultMode:=X;
    XGetAbsRec(Output.X,Output.X.Size-SizeOfVideoBios,
               SizeOfVideoBios,VideoBios);
    BV:=0;
    For IL:=0to 24do Begin
     XGetAbsRec(Output.X,BV,VideoBios[0]shl 1,LineBuffer);
     For JL:=0to VideoBios[0]-1do Begin
      SetCube(JL,IL,Char(LineBuffer[JL shl 1]),LineBuffer[(JL shl 1)+1]);
     End;
     Inc(BV,Long(VideoBios[0]shl 1));
    End;
   End;
  End;
 End;

Begin
 _SetDefaultMode:=1;
 FillClr(Data,SizeOf(Data));
 Data.ModeVideo:=True;
 ExecuteAppDPU(59,Data);
 Case(Data.KeyOutput)of
  2:_SetDefaultMode:=0;
  1:_SetDefaultMode:=-1;
  0:If(Data.ModeVideo)Then ChgMode;
 End;
End;

Function ExitSetup:Boolean;Begin
 ExitSetup:=WarningMsgYesNo('Voulez-vous vraiment sortir de '+
                            'l''assistant de configuration?')=kbYes;
End;

Function ContinueAssistantConfig:Boolean;
Var
 Form:Record
  Key:Byte;
 End;
Begin
 If FSearch(MB_INI,';'+MaltePath)<>''Then Begin
  ContinueAssistantConfig:=ExecuteAppDPU(135,Form);
 End
  Else
 Begin
  ContinueAssistantConfig:=WarningMsgYesNo('Fichier de configuration absent! SouhaŒtez-vous '+
                                           'configurer le ®MonsterBook¯ maintenant?')=kbYes;
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ·}
{³                     Z o n e  P u b l i c                    º}
{ÔÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼}

Procedure AssistantConfig;
Var
 W:Window;
 K,P:Word;
 ScrnSaver:Boolean;
 CH:Array[0..25]of Boolean;
 OldMode:Byte;

 Procedure Coche;Begin
  WESetCube(W,0,1+P,'û');
  CH[P]:=Ya;
 End;

 Procedure PutData;
 Var
  I,TP:Byte;
 Begin
  WEInit(W,(MaxXTxts-45)shr 1,0,((MaxXTxts-45)shr 1)+45,11);
  WEPushWn(W);
  WEPutWnKrDials(W,'Assistant de configuration');
  WEBar(W);
  WELn(W);
  WEPutTxtLn(W,'  S‚lection des chemins d''accŠs');
  WEPutTxtLn(W,'  SystŠme d''exploitation');
  WEPutTxtLn(W,'  Affichage par d‚faut');
  WEPutTxtLn(W,'  S‚curit‚ du ®MonsterBook¯');
  WEPutTxtLn(W,'  Enregistrer le ®MonsterBook¯');
  WEPutTxtLn(W,'  Voir ®LISEZMOI.DOC¯');
  TP:=P;
  For I:=0to 5do If CH[I]Then Begin
   P:=I;
   Coche;
  End;
  P:=TP;
  WEPutkHorDn(W,'Pr‚c‚dent|Suivant|Quitter');
 End;

Begin
 FillClr(CH,SizeOf(CH));
{ If LoadStr(Mem[$C900:$76],Length('S3 Corp. Trio64 1.0.0'))='S3 Corp. Trio64 1.0.0'Then VesaBiosBank:=True;}
 ScrnSaver:=ActifScrSave;
 ActifScrSave:=False;
 If(ContinueAssistantConfig)Then Begin
  PutData;
  P:=0;
  Repeat
   Case(P)of
    0:Begin
     Coche;
     Case(SetMainPath)of
      0:If(ExitSetup)Then Break Else P:=1;
      1:P:=1;
     End;
    End;
    1:Begin
     Coche;
     Case(_SetOS)of
      -1:P:=0;
      0:If(ExitSetup)Then Break Else P:=2;
      1:P:=2;
     End;
    End;
    2:Begin
     Coche;
     OldMode:=CurrVideoMode;
     Case(_SetDefaultMode)of
      -1:P:=1;
      0:If(ExitSetup)Then Break Else P:=3;
      1:P:=3;
     End;
     If(OldMode<>CurrVideoMode)Then PutData;
    End;
    3:Begin
     Coche;
     Case _SetPassWord(Ya)of
      -1:P:=2;
      0:If(ExitSetup)Then Break Else P:=4;
      1:P:=4;
     End;
    End;
    4:Begin
     Coche;
     Case EnregPrg(Ya)of
      -1:P:=3;
      0:If(ExitSetup)Then Break Else P:=5;
      1:P:=5;
     End;
    End;
    5:Begin
     Coche;
     ViewReadMe;
     P:=6;
    End;
    6:Begin
     K:=WEGetkHorDn(W,'Fin|Pr‚c‚dent|Annuler');
     Case(K)of
      kbAbort,kbEsc,2:Break;
      0:Begin
       SaveIni;
       Break;
      End;
      1:P:=4;
     End;
    End;
   End;
  Until No;
  WEDone(W);
 End;
 ActifScrSave:=ScrnSaver;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Proc‚dure ChgVidMode                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de modifier le format de l'‚cran (texte ou
 graphique) ainsi que sa d‚finition et son nombre de couleur.
}

Procedure ChgVidMode;
Var
 X:Word;
Begin
 If NmXTxts>=80Then X:=SelectVideoMode(8,6,wnMax-8,wnMax-6,vmt2)
	       Else X:=SelectVideoMode(0,6,wnMax,wnMax-6,vmt2);
 If(Hi(X)=$13)or((X>=4)and(X<=$13))Then Begin
  If(WarningMsgYesNo('Attention! Les modes graphiques occasionnent souvent '+
                     'des problŠmes de plantage car le concepteur n''a pas '+
                     'finit de d‚terrer les morts en ce qui concerne des '+
                     '"bugs"! D‚sirez-vous quand mˆme continuer cette '+
                     'op‚ration?')=kbNo)Then Exit;
 End;
 If(X<>vmNone)Then Begin
  RunFunc(cmdCloseAllWn);
  __DoneMouse;
  CurrPalette:=$FF;MemoryModel:=mmAutoDetect;StyleBarTitle:=sttNone;
  If(NoLuxe)Then Begin
   If SetVideoMode(X)Then Begin
    DefaultMode:=X;MtxNm:=0;
    SaveIni;
   End;
   CloseCur;
   If Not(IsGraf)Then SetBlink(No);
  End
   Else
  If SetVideoModeDeluxe(X)Then Begin
   DefaultMode:=X;MtxNm:=0;
   SaveIni;
  End;
  If(ModePH)Then _InitEnv(MtxDiablo)Else InitEnv;
  SetMnuSwitch;
  InitScr;
  If(IsGraf)Then WriteLog('Change en mode vid‚o graphique:'+BasicStrW(NmXPixels)+'x'+
			     WordToStr(NmYPixels)+' en'+BasicStrW(GetNmKr)+' couleurs')
  Else WriteLog('Change en mode vid‚o texte:'+BasicStrW(NmXTxts)+'x'+WordToStr(NmYTxts));
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Proc‚dure EdtChrType                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure offre … l'utilisateur une possibilit‚ manuel de modifier
 le format de caractŠres du traŒtement de texte.
}

Procedure EdtChrType;Begin
 Case HModel(Windows)of
  wnDraw,wnIcon:DWSelectFont(DrawEditApp(HPtr(Windows)^));
  {$IFDEF Games}
   wnTetris:TetrisStart(TetrisGame(HPtr(Windows)^));
  {$ENDIF}
  wnEdit:TEEdtChrType(EditorApp(HPtr(Windows)^));
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure EdtCurrModeType                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

   Cette proc‚dure permet … l'usager de s‚lectionner le mode de sauvegarde
  d'une l'‚diteur de texte ou de dessin.
}

Procedure EdtCurrModeType;
Var
 L:LstMnu;
 K:Word;
 Res:ImageHeaderRes;
Begin
 Case HModel(Windows)of
  wnEdit:If TEChangeView(EditorApp(HPtr(Windows)^))Then SetMnuSwitch;
  wnDraw:Begin
   LMInitKrDials(L,20,4,MaxXTxts-20,wnMax-4,'Mode de sauvegarde');
   ALAddStrByte(L.List,'BGX (Bitmap Genesis eXtrasimple)',diBGX);
   ALAddStrByte(L.List,'BMP (Bitmap Windows)',diBitMapWindows);
   ALAddStrByte(L.List,'GIF Compuserve',diGIF);
   ALAddStrByte(L.List,'PCX Paintbrush',diPCX);
   ALAddStrByte(L.List,'PPM (PPM/PGM)',diPPM);
   ALAddStrByte(L.List,'SCi (RIX)',diSCi);
   ALAddStrByte(L.List,'XBM (BitMap Unix)',diXBM);
   LMGotoPos(L,DrawEditApp(HPtr(Windows)^).Canvas.Res.Original);
   K:=LMRun(L);
   LMDone(L);
   If K=0Then Exit;
   DrawEditApp(HPtr(Windows)^).Canvas.Res.Original:=K;
   XGetAbsRec(DrawEditApp(HPtr(Windows)^).Canvas.Image,0,SizeOf(Res),Res);
   Res.Original:=K;
   XSetAbsRec(DrawEditApp(HPtr(Windows)^).Canvas.Image,0,SizeOf(Res),Res);
  End;
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure Env                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet … l'utilisateur de d‚finir les variables
 d'environnement de l'ensemble Malte Genesis IV et V:  Chantal et
 AdŠle.  Autrement dit il permet  d'autoriser un journal de bord,
 des copies de s‚curit‚s,  les descriptions et le desktop  (‚tant
 toutefois propre aux ®MonsterBook¯).
}

Procedure Env;
Var
 FormEnvironment:Record
  Log:MCheckBox;
  Desktop:MCheckBox;
  MakeBak:MCheckBox;
  DescrInFile:MCheckBox;
  LongFileName:MCheckBox;
  GeoWorks:MCheckBox;
  SWAG:MCheckBox;
  PFS:MCheckBox;
  _MOD:MCheckBox;
  Key:Byte;
 End;
Begin
 FillClr(FormEnvironment,SizeOf(FormEnvironment));
 FormEnvironment.DescrInFile.Checked:=DescrInFile;
 FormEnvironment.LongFileName.Checked:=DescrInFile;
 FormEnvironment.GeoWorks.Checked:=DescrInFile;
 FormEnvironment.SWAG.Checked:=DescrInFile;
 FormEnvironment.PFS.Checked:=DescrInFile;
 FormEnvironment._MOD.Checked:=DescrInFile;
 FormEnvironment.Log.Checked:=Log;
 FormEnvironment.Desktop.Checked:=Desktop;
 FormEnvironment.MakeBak.Checked:=MakeBak;
 If ExecuteAppDPU(47,FormEnvironment)Then Begin
  DescrInFile:=FormEnvironment.DescrInFile.Checked;
  Log:=FormEnvironment.Log.Checked;
  Desktop:=FormEnvironment.Desktop.Checked;
  MakeBak:=FormEnvironment.MakeBak.Checked;
  SaveIni;
 End;
End;

Procedure InitAni(Var SS:ScrnSaverRec);Begin
 If(IsGrf)Then Case(SS.Data.CurrScrn.ItemIndex)of
  ssAniMixingStar:_InitMixingStar(SS.Q.MixingStar,SS.X1,SS.Y1,SS.X2,SS.Y2);
  ssAniMystify:_InitMystify(SS.Q.Mystify,SS.X1,SS.Y1,SS.X2,SS.Y2);
  ssAniStar:_InitStar(SS.Q.Star,SS.X1,SS.Y1,SS.X2,SS.Y2);
  ssAniStar3D:_InitStar3D(SS.Q.Star3D,SS.X1,SS.Y1,SS.X2,SS.Y2);
  ssAniStarPlus:_InitStarPlus(SS.Q.StarPlus,SS.X1,SS.Y1,SS.X2,SS.Y2);
  Else ClrWn(SS.X1,SS.Y1,SS.X2,SS.Y2,Black);
 End;
End;

Procedure ActionScrnSaver(Var Context);Far;
Var
 DataScrnSaver:ScrnSaverRec Absolute Context;
Begin
 If(IsGrf)Then Begin
  If(DataScrnSaver.Data.CurrScrn.ItemIndex<>DataScrnSaver.CurrScrn)Then Begin
   _DoneMixingStar(DataScrnSaver.Q.MixingStar);
   InitAni(DataScrnSaver);
   DataScrnSaver.CurrScrn:=DataScrnSaver.Data.CurrScrn.ItemIndex;
  End;
  Case(DataScrnSaver.Data.CurrScrn.ItemIndex)of
   ssAniMixingStar:_AniMixingStar(DataScrnSaveR.Q.MixingStar);
   ssAniMystify:_AniMystify(DataScrnSaver.Q.Mystify);
   ssAniStar:_AniStar(DataScrnSaver.Q.Star);
   ssAniStar3D:_AniStar3D(DataScrnSaver.Q.Star3D);
   ssAniStarPlus:_AniStarPlus(DataScrnSaver.Q.StarPlus);
  End;
 End;
End;

Procedure LoadModel(Var L:LstMnu;Var Context);Begin
 ALAddStrByte(L.List,'Al‚atoire',ssRandom);
 ALAddStrByte(L.List,'toile en 3 dimensions',ssAniStar3D);
 ALAddStrByte(L.List,'Apparition/disparition d''‚toile',ssAniMixingStar);
 ALAddStrByte(L.List,'toile en plus',ssAniStarPlus);
 ALAddStrByte(L.List,'toile en mouvement horizontal',ssAniStar);
 ALAddStrByte(L.List,'Courbe/ondulation B‚zier',ssAniMystify);
 L.W.BackWait:=ActionScrnSaver;
 L.W.Context:=@Context;
End;

Procedure UpDateSS(Var R:ResourceWindow;Var Context);
Var
 SS:ScrnSaverRec Absolute Context;
Begin
 If(IsGrf)Then Begin
  SS.X1:=R.W.T.X1+35;
  SS.X2:=R.W.T.X2-2;
  SS.Y1:=R.W.T.Y1+2;
  SS.Y2:=R.W.T.Y2-4;
  InitAni(SS);
  R.W.BackWait:=ActionScrnSaver;
  R.W.Context:=@SS;
 End;
End;

Procedure DoneScrnSaver(Var SS:ScrnSaverRec);Begin
 If(IsGrf)and(SS.CurrScrn=ssAniMixingStar)Then _DoneMixingStar(SS.Q.MixingStar);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Proc‚dure SetScrnSaver                    Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de d‚finir la configuration de l'‚conomiseur
 d'‚cran, c'est-…-dire: l'activation et le temps.
}


Procedure SetScrnSaver;
Var
 SS:ScrnSaverRec;
 OldSS:Byte;
Begin
 FillClr(SS,SizeOf(SS));
 SS.Data.IsGrf:=IsGrf;
 OldSS:=CurrScrnSaver;
 Case(SecSS)of
  0:SS.Data.Delay.Alignment:=0;
  1..60:SS.Data.Delay.Alignment:=1;
  61..180:SS.Data.Delay.Alignment:=2;
  181..300:SS.Data.Delay.Alignment:=3;
  Else SS.Data.Delay.Alignment:=4;
 End;
 SS.Data.CurrScrn.LoadList:=LoadModel;
 SS.Data.CurrScrn.Context:=@SS;
 SS.Data.CurrScrn.ItemIndex:=CurrScrnSaver;
 SS.Data.UpdateSS:=UpdateSS;
 SS.Data.ContextSS:=@SS;
 SS.Data.ScrnSaverActif.Checked:=ActifScrSave;
 Repeat
  ExecuteAppDPU(87,SS.Data);
  If SS.Data.Key=1Then Begin
   __HideMousePtr;
   DoneScrnSaver(SS);
   CurrScrnSaver:=SS.CurrScrn;
   RunScrnSaver;
   CurrScrnSaver:=OldSS;
   SS.CurrScrn:=$FF;
   __ShowMousePtr;
  End;
 Until SS.Data.Key<>1;
 If SS.Data.Key=0Then Begin
  CurrScrnSaver:=SS.Data.CurrScrn.ItemIndex;
  ActifScrSave:=SS.Data.ScrnSaverActif.Checked;
  Case(SS.Data.Delay.Alignment)of
   0:SecSS:=0;
   1:SecSS:=60;
   2:SecSS:=180;
   3:SecSS:=300;
   Else SecSS:=20*60;
  End;
  SaveIni;
 End;
 DoneScrnSaver(SS);
End;

Procedure SetupCompress;
Var
 Data:Record
  ARC:MCheckBox;
  ARJ:MCheckBox;
  CAB:MCheckBox;
  ICE:MCheckBox;
  LHA:MCheckBox;
  PAK:MCheckBox;
  RAR:MCheckBox;
  SWAG:MCheckBox;
  ZIP:MCheckBox;
  ZOO:MCheckBox;
 End;
Begin
 FillClr(Data,SizeOf(Data));
 Data.ARC.Checked:=True;
 Data.ARJ.Checked:=True;
 Data.CAB.Checked:=True;
 Data.ICE.Checked:=True;
 Data.LHA.Checked:=True;
 Data.PAK.Checked:=True;
 Data.RAR.Checked:=True;
 Data.SWAG.Checked:=True;
 Data.ZIP.Checked:=True;
 Data.ZOO.Checked:=True;
 If ExecuteAppDPU(127,Data)Then Begin
 End;
End;

Procedure SetupDataBase;
Var
 Data:Record
  Oracle:MCheckBox;
  MySQL:MCheckBox;
  Access:MCheckBox;
  InterBase:MCheckBox;
  Mentronix:MCheckBox;
  GlobalTable:MCheckBox;
 End;
Begin
 FillClr(Data,SizeOf(Data));
 Data.Mentronix.Checked:=True;
 Data.GlobalTable.Checked:=True;
 If ExecuteAppDPU(126,Data)Then Begin
 End;
End;

Procedure SetSystems;
Var
 Data:Record
  DirectDos:MCheckBox;
  Up32Bits:MCheckBox;
  OvrEmsXms:MCheckBox;
  UseEMS:MCheckBox;
  DetectPerBios:MCheckBox;
  DetectCmos:MCheckBox;
  DetectExtBios:MCheckBox;
  SpoolDetect:MCheckBox;
  ComputerNameDetect:MCheckBox;
  ProtectMode:MCheckBox;
  PlugNPlay:MCheckBox;
  PCIDetect:MCheckBox;
  HPFSDetect:MCheckBox;
  FAT32Detect:MCheckBox;
  DPUSupport:MCheckBox;
  RLLSupport:MCheckBox;
  SQLSupport:MCheckBox;
  HTMLSupport:MCheckBox;
  JavaScriptSupport:MCheckBox;
  JavaSupport:MCheckBox;
  ASPSupport:MCheckBox;
  PHPSupport:MCheckBox;
  MenuSupport:MCheckBox;
  FastWinSupport:MCheckBox;
  IniCompiledSupport:MCheckBox;
  BGXSupport:MCheckBox;
  WinBMPSupport:MCheckBox;
  OS2BMPSupport:MCheckBox;
  GFXSupport:MCheckBox;
  GIFSupport:MCheckBox;
  GemImgSupport:MCheckBox;
  ImiSupport:MCheckBox;
  LBMSupport:MCheckBox;
  MacPaintSupport:MCheckBox;
  PCXSupport:MCheckBox;
  PPMSupport:MCheckBox;
  SCiSupport:MCheckBox;
  TargaSupport:MCheckBox;
  TIFFSupport:MCheckBox;
  XBMSupport:MCheckBox;
  IDEDetectCDROM:MCheckBox;
  DefaultPort:Byte;
  CDROMPort:Byte;
  Key:Byte;
 End;
Begin
 FillClr(Data,SizeOf(Data));
 Data.DirectDos.Checked:=DirectDos;
 Data.Up32Bits.Checked:=Up32Bits;
 Data.OvrEmsXms.Checked:=SwapEms;
 Data.UseEMS.Checked:=Not NoEMS;
 Data.DetectPerBios.Checked:=(flgEquipPerBios)in(Jump.FlagsMethod);
 Data.DetectCmos.Checked:=Not((flgNoCmosDetect)in(Jump.FlagsMethod));
 Data.DetectExtBios.Checked:=Not((flgNoExtBiosMemDetect)in(Jump.FlagsMethod));
 Data.SpoolDetect.Checked:=Not((flgNoSpoolerDetect)in(Jump.FlagsMethod));
 Data.ComputerNameDetect.Checked:=Not((flgOnlyMem4ComputerName)in(Jump.FlagsMethod));
 Data.ProtectMode.Checked:=(flgProtectedMode)in(Jump.FlagsMethod);
 Data.DPUSupport.Checked:=True;
 Data.RLLSupport.Checked:=True;
 Data.SQLSupport.Checked:=True;
 Data.MenuSupport.Checked:=True;
 Data.FastWinSupport.Checked:=True;
 Data.IniCompiledSupport.Checked:=True;
 Data.BGXSupport.Checked:=True;
 Data.WinBMPSupport.Checked:=True;
 Data.OS2BMPSupport.Checked:=True;
 Data.GFXSupport.Checked:=True;
 Data.GIFSupport.Checked:=True;
 Data.GemImgSupport.Checked:=True;
 Data.ImiSupport.Checked:=True;
 Data.LBMSupport.Checked:=True;
 Data.MacPaintSupport.Checked:=True;
 Data.PCXSupport.Checked:=True;
 Data.PPMSupport.Checked:=True;
 Data.SCiSupport.Checked:=True;
 Data.TargaSupport.Checked:=True;
 Data.TIFFSupport.Checked:=True;
 Data.XBMSupport.Checked:=True;
 Data.IDEDetectCDROM.Checked:=False; { ... }
 Data.DefaultPort:=DefaultCDROMPort;
 If ExecuteAppDPU(58,Data)Then Begin
  DirectDos:=Data.DirectDos.Checked;
  Up32Bits:=Data.Up32Bits.Checked;
  DefaultCDROMPort:=Data.DefaultPort;
  SwapEms:=Data.OvrEmsXms.Checked;
  NoEMS:=Not Data.UseEMS.Checked;
  If(Data.DetectPerBios.Checked)Then Include(Jump.FlagsMethod,flgEquipPerBios)
                                Else Exclude(Jump.FlagsMethod,flgEquipPerBios);
  If(Data.DetectCmos.Checked)Then Exclude(Jump.FlagsMethod,flgNoCmosDetect)
                             Else Include(Jump.FlagsMethod,flgNoCmosDetect);
  If(Data.DetectExtBios.Checked)Then Exclude(Jump.FlagsMethod,flgNoExtBiosMemDetect)
                                Else Include(Jump.FlagsMethod,flgNoExtBiosMemDetect);
  If(Data.SpoolDetect.Checked)Then Exclude(Jump.FlagsMethod,flgNoSpoolerDetect)
                              Else Include(Jump.FlagsMethod,flgNoSpoolerDetect);
  If(Data.ComputerNameDetect.Checked)Then Exclude(Jump.FlagsMethod,flgOnlyMem4ComputerName)
                                     Else Include(Jump.FlagsMethod,flgOnlyMem4ComputerName);
  If(Data.DetectPerBios.Checked)Then Include(Jump.FlagsMethod,flgProtectedMode)
                                Else Exclude(Jump.FlagsMethod,flgProtectedMode);
  SaveIni;
 End;
End;

Procedure UpDateRules(OldRules,NewRules:Boolean);
Var
 TW:^WindowApp; { Pointeur sur l'‚diteur de traŒtement de texte }
 I:Integer;     { Compteur de boucle }
Begin
 If(OldRules<>NewRules)Then Begin
  For I:=0to Windows.Lst.Count-1do Begin
   TW:=_ALGetBuf(Windows.Lst,I);
   Case(TW^.Model)of
    0:Break;
    wnEdit:If(NewRules)Then Dec(TW^.P.Edit.W.MaxY)
                       Else Inc(TW^.P.Edit.W.MaxY);
   End;
 End;
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                      Proc‚dure SetEditor                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure offre … l'utilisateur d'effectuer les ajustements
 n‚cessaire au bon fonctionnement de l'‚diteur.
}

Procedure SetEditorFont(Var R:ResourceWindow;Var Context);
Var
 Name:String;
Begin
 Case(R.CurrPage)of
  0:Name:='ICON\WRITE.ICO';
  1:Name:='ICON\TABLEUR.ICO';
  Else Name:='';
 End;
 _RIViewImage(MaltePath+Name,0,R.W,4,1,GetRawY(4),$FFFF,0);
End;

Procedure SetApplication;
Var
 FormApp:Record
   { Editeur }
  MarkEnd:MCheckBox;
  Rules:MCheckBox;
  ViewOutZone:MCheckBox;
   { Tableur }
  Lotus123:MCheckBox;
  Office:MCheckBox;
  QuattroPro:MCheckBox;
  Extern:MExtern;
  Key:Byte;
 End;
Begin
 FillClr(FormApp,SizeOf(FormApp));
 FormApp.Lotus123.Checked:=True;
 FormApp.Office.Checked:=True;
 FormApp.QuattroPro.Checked:=True;
 FormApp.MarkEnd.Checked:=MarkEnd;
 FormApp.Rules.Checked:=Rules;
 FormApp.ViewOutZone.Checked:=ViewOutZone;
 FormApp.Extern.Call:=SetEditorFont;
 If ExecuteAppDPU(57,FormApp)Then Begin
  UpDateRules(Rules,FormApp.Rules.Checked);
  MarkEnd:=FormApp.MarkEnd.Checked;
  Rules:=FormApp.Rules.Checked;
  ViewOutZone:=FormApp.ViewOutZone.Checked;
  SaveIni;
  RunFunc(cmdRefreshWn);
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Proc‚dure SetPassword                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure offre … l'utilisateur de d‚finir son propre mot de
 passe avec une v‚rification.
}

Procedure SetPassWord;Begin
 _SetPassWord(False);
End;

Function _SetPassWord;
Const HD=12;
Label ReEnter,Xit;
Var
 First,Sec:String;
 H:History;
 K:Word;
 HW:Window;
Begin
 _SetPassWord:=1;
 HYInit(H,512);
 If(Config)Then Begin
  WEInit(HW,5,((NmYTxts-HD)shr 1)+HD,wnMax-5,NmYTxts-2);
  WEPushWn(HW);
  WEPutWnKrDials(HW,'');
  WEPutMsg(HW,'Permet d''entrer un mots de passe demander … chaque fois que vous '+
              'entrez dans cette application. Laissez la ligne vide si '+
              'vous ne souhaitez pas avoir de protection par mots de '+
	      'passe dans cette application.');
 End;
 Repeat
  First:='';Sec:='';
ReEnter:
  K:=WinInpH(40,'Protection','Entrez le mot de passe',CurrKrs.Draw.Window,True,First,H,Config);
  Case(Config)of
   Ya:Begin
    Case(K)of
     kbAbort,kbEsc:Begin
      _SetPassWord:=0;
      Goto Xit;
     End;
     0:Begin
      _SetPassWord:=-1;
      Goto Xit;
     End;
     1:If First=''Then Goto Xit;
    End;
   End;
   Else If(K<>kbOk)Then Goto Xit;
  End;
  First:=StrUp(First);
  K:=WinInpH(40,'V‚rification','V‚rification du mot de passe',CurrKrs.Draw.Window,True,Sec,H,Config);
  Case(Config)of
   Ya:Begin
    Case(K)of
     kbAbort:Begin
      _SetPassWord:=0;
      Goto Xit;
     End;
     0:Goto ReEnter;
    End;
   End;
   Else If(K<>kbOk)Then Goto Xit;
  End;
  Sec:=StrUp(Sec);
  If(First<>Sec)Then ErrNoMsgOk(InvalidConfirmPassword);
 Until First=Sec;
 EditorApp(HPtr(Windows)^).PassWord:=First;
 If Not(EditorApp(HPtr(Windows)^).Modified)Then TESave(EditorApp(HPtr(Windows)^));
Xit:
 If(Config)Then WEDone(HW);
End;

{$I Library\Typemati.inc}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                      Proc‚dure SetupKeyboard                   Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure offre … l'utilisateur d'effectuer les ajustements
 n‚cessaire au bon fonctionnement du clavier.
}

Type
 MFormSetupKeyboard=Record
  Speed:MScrollBar;
  Wait:MScrollBar;
  Test:String;
  NewWindows95KeyBoard:MCheckBox;
  KeyOutput:Byte;
 End;

Procedure OnSpeed(Var R:ResourceWindow;Var Context);
Var
 Q:MFormSetupKeyboard Absolute Context;
 S:String;
Begin
 Case($1F-Q.Speed.Position)of
  $00:S:='30'+DeSep[0]+'0';
  $01:S:='26'+DeSep[0]+'7';
  $02:S:='24'+DeSep[0]+'0';
  $03:S:='21'+DeSep[0]+'8';
  $04:S:='20'+DeSep[0]+'0';
  $05:S:='18'+DeSep[0]+'5';
  $06:S:='17'+DeSep[0]+'1';
  $07:S:='16'+DeSep[0]+'0';
  $08:S:='15'+DeSep[0]+'0';
  $09:S:='13'+DeSep[0]+'3';
  $0A:S:='12'+DeSep[0]+'0';
  $0B:S:='10'+DeSep[0]+'9';
  $0C:S:='10'+DeSep[0]+'0';
  $0D:S:='9'+DeSep[0]+'2';
  $0E:S:='8'+DeSep[0]+'6';
  $0F:S:='8'+DeSep[0]+'0';
  $10:S:='7'+DeSep[0]+'5';
  $11:S:='6'+DeSep[0]+'7';
  $12:S:='6'+DeSep[0]+'0';
  $13:S:='5'+DeSep[0]+'5';
  $14:S:='5'+DeSep[0]+'0';
  $15:S:='4'+DeSep[0]+'6';
  $16:S:='4'+DeSep[0]+'3';
  $17:S:='4'+DeSep[0]+'0';
  $18:S:='3'+DeSep[0]+'7';
  $19:S:='3'+DeSep[0]+'3';
  $1A:S:='3'+DeSep[0]+'0';
  $1B:S:='2'+DeSep[0]+'7';
  $1C:S:='2'+DeSep[0]+'5';
  $1D:S:='2'+DeSep[0]+'3';
  $1E:S:='2'+DeSep[0]+'1';
  $1F:S:='2'+DeSep[0]+'0';
 End;
 R.W.Y:=2;
 WESetKrBorder(R.W);
 WEPutOTxt(R.W,StrUSpc(S+' caractŠres/seconde',30));
 If Not SetTypm(((3-Q.Wait.Position)shl 5)+($1F-Q.Speed.Position))Then
  ErrNoMsgOk(errSetKeyboard);
End;

Procedure OnWait(Var R:ResourceWindow;Var Context);
Var
 Q:MFormSetupKeyboard Absolute Context;
 S:String;
Begin
 Case(3-Q.Wait.Position)of
  $00:S:='0'+DeSep[0]+'250';
  $01:S:='0'+DeSep[0]+'500';
  $02:S:='0'+DeSep[0]+'750';
  $03:S:='1';
 End;
 R.W.Y:=7;
 WESetKrBorder(R.W);
 WEPutOTxt(R.W,StrUSpc('Attente: '+S+' secondes',30));
 If Not SetTypm(((3-Q.Wait.Position)shl 5)+($1F-Q.Speed.Position))Then
  ErrNoMsgOk(errSetKeyboard);
End;

Procedure SetupKeyboard;
Label SetK;
Var
 FormSetupKeyboard:MFormSetupKeyboard;
Begin
 FillClr(FormSetupKeyboard,SizeOf(FormSetupKeyboard));
 FormSetupKeyboard.Speed.OnScroll:=OnSpeed;
 FormSetupKeyboard.Speed.OnScrollContext:=@FormSetupKeyboard;
 FormSetupKeyboard.Wait.OnScroll:=OnWait;
 FormSetupKeyboard.Wait.OnScrollContext:=@FormSetupKeyboard;
 If KeyWait=$FFThen KeyWait:=(1 shl 5)+$B;
 FormSetupKeyboard.Speed.Position:=$1F-(KeyWait and $1F);
 FormSetupKeyboard.Wait.Position:=3-((KeyWait shr 5)and 3);
 If ExecuteAppDPU(45,FormSetupKeyboard)Then Begin
  KeyWait:=((3-FormSetupKeyboard.Wait.Position)shl 5)+($1F-FormSetupKeyboard.Speed.Position);
SetK:SetTypm(Not KeyWait); { Reset Clavier! }
  SaveIni;
 End
  Else
 If FormSetupKeyboard.KeyOutput=1Then Begin
  KeyWait:=0;
  Goto SetK;
 End;
 If Not SetTypm(KeyWait)Then ErrNoMsgOk(errSetKeyboard);
End;

Procedure ImageOnPress(Var R:ResourceWindow;Var Context);
Var
 S:String;
Begin
 S:=_OpenWinModel('*.*','Choisir le pointeur souris',H,omDraw);
 If S<>''Then Begin
  Application.MousePointerFileName:=Str2PChr(S);
  InitMouseImage;
 End;
End;

{$IFDEF Reseau}
 Type
  FormModem=Record
   Port:Byte;
   DataBits:Byte;
   Parity:Byte;
   StopBits:Byte;
   CurrModel:Word;
   LoadModemList:Procedure(Var L:LstMnu;Var Context);
   OnMoveModem:Procedure(Var L:LstMnu;Var Context);
   ContextModemList:Pointer;
  End;

 Procedure LoadModemList(Var L:LstMnu;Var Context);
 Var
  Form:FormModem Absolute Context;
  CurrModel:Word;
  Data:Record
   X:Word;
   S:String;
  End;
 Begin
  If Not ReadMainKey(HKEY_CURRENT_CONFIG,'System\Modem','CurrModel',CurrModel)Then CurrModel:=$1330;
  DBOpenServerName(ChantalServer,'CHANTAL:/Modem/Index.Dat');
  DBFirst(ChantalServer);
  Repeat
   DBReadRec(ChantalServer,Data);
   ALAddStrWord(L.List,Data.S,Data.X);
   If(Data.X=CurrModel)Then Begin
    Form.CurrModel:=L.List.Count-1;
   End;
  Until DBEOF(ChantalServer);
 End;

 Procedure SetupModem;
 Var
  Form:FormModem;
 Begin
  FillClr(Form,SizeOf(Form));
  Form.Port:=CurrModem;
  Case(DataBits)of
   8:Form.DataBits:=1;
   Else Form.DataBits:=0;
  End;
  Case ChrUp(Parity)of
   'N':Form.Parity:=0;
   'P':Form.Parity:=1;
   'I':Form.Parity:=2;
  End;
  Case(StopBits)of
   1:Form.StopBits:=0;
   Else Form.StopBits:=1;
  End;
  Form.LoadModemList:=LoadModemList;
  Form.ContextModemList:=@Form;
  If ExecuteAppDPU(146,Form)Then Begin
   CurrModem:=Form.Port;
   CreateKeyFormat(HKEY_CURRENT_CONFIG,'System\Modem','CurrModel',tdWord,Form.CurrModel);
   SaveIni;
  End;
 End;
{$ENDIF}


{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                      Proc‚dure SetupMouse                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure offre … l'utilisateur d'effectuer les ajustements
 n‚cessaire au bon fonctionnement de la souris.
}

Procedure SetupMouse;
Var
 FormSetupMouse:Record
  MouseTextGraphic:MCheckBox;
  OS2Look:MCheckBox;
  LeftMouse:MCheckBox;
  Driver:MRadioButton;
  Image:MButton;
  Foreground:MColorGrid;
 End;
Begin
 FillClr(FormSetupMouse,SizeOf(FormSetupMouse));
 FormSetupMouse.Foreground.Color:=ColorMouse;
 FormSetupMouse.Image.OnPress:=ImageOnPress;
 If(ColorMouse=0)and(BorderColorMouse>0)Then Begin
  FormSetupMouse.OS2Look.Checked:=True;
  FormSetupMouse.Foreground.Color:=BorderColorMouse;
 End;
 FormSetupMouse.MouseTextGraphic.Checked:=MouseTxtGrf;
 FormSetupMouse.LeftMouse.Checked:=LeftMouse;
 Case(Adele.Mouse)of
  msPS2:FormSetupMouse.Driver.Alignment:=1;
  msCOM:FormSetupMouse.Driver.Alignment:=2;
  msNoMouse:FormSetupMouse.Driver.Alignment:=3;
  Else FormSetupMouse.Driver.Alignment:=0;
 End;
 If ExecuteAppDPU(46,FormSetupMouse)Then Begin
  CLI;
  If(FormSetupMouse.OS2Look.Checked)Then Begin
   BorderColorMouse:=FormSetupMouse.Foreground.Color;
   ColorMouse:=0;
  End
   Else
  Begin
   ColorMouse:=FormSetupMouse.Foreground.Color;
   BorderColorMouse:=0;
  End;
  LeftMouse:=FormSetupMouse.LeftMouse.Checked;
  MouseTxtGrf:=FormSetupMouse.MouseTextGraphic.Checked;
  Case(FormSetupMouse.Driver.Alignment)of
   0:Adele.Mouse:=msLogitech;
   1:Adele.Mouse:=msPS2;
   2:Adele.Mouse:=msCOM;
   3:Adele.Mouse:=msNoMouse;
  End;
  STI;
  __InitMouse;
  InitMouseImage;
  SaveIni;
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                     Proc‚dure SetupSecurity                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'entrer … l'utilisateur d'entrer un mot de
 passe centrale.
}

Procedure SetupSecurity;
Var
 First,Sec:String;
 T:Array[Byte]of Char;
Begin
 Repeat
  First:='';Sec:='';
  If(WinInp(40,'Protection centrale','Entrez le mot de passe',CurrKrs.Draw.Window,Ya,First)<>kbOk)Then Exit;
  First:=StrUp(First);
  If First=''Then Break;
  If(WinInp(40,'V‚rification centrale','V‚rification du mot de passe',CurrKrs.Draw.Window,Ya,Sec)<>kbOk)Then Exit;
  Sec:=StrUp(Sec);
  If(First<>Sec)Then ErrNoMsgOk(InvalidConfirmPassword);
 Until First=Sec;
 If Not IsPChrEmpty(MasterPassWord)Then Begin
  StrDispose(MasterPassWord);
  If First=''Then WarningMsgOk('Mot de passe centrale d‚truit!');
 End;
 StrPCopy(@T,First);
 MasterPassWord:=StrNew(@T);
 SaveIni;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                      Proc‚dure SetupSourcer                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet … l'utilisateur de s‚lectionner le modŠle de
 d‚sassembleur devant ˆtre exploiter par la machine.
}

{$IFDEF Developpeur}
 Procedure SetupSourcer;
 Var
  FormSetupSourcer:Record
   OpCodeFormat:MRadioButton;
   OpCodeCPU:MRadioButton;
  End;
 Begin
  FormSetupSourcer.OpCodeFormat.Alignment:=OpCodeFormat;
  FormSetupSourcer.OpCodeCPU.Alignment:=OpCodeCPU;
  If ExecuteAppDPU(36,FormSetupSourcer)Then Begin
   OpCodeFormat:=FormSetupSourcer.OpCodeFormat.Alignment;
   OpCodeCPU:=FormSetupSourcer.OpCodeCPU.Alignment;
   SaveIni;
  End;
 End;
{$ENDIF}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure SetPaletteKr                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet … l'utilisateur de s‚lectionner une des diff‚rentes
 palettes de couleurs disponible pour l'environnement.
}

Procedure SetPaletteKr;
Var
 FormSetupPaletteColor:Record
  Palette:MRadioButton;
 End;
 Path:String;
Begin
 FillClr(FormSetupPaletteColor,SizeOf(FormSetupPaletteColor));
 FormSetupPaletteColor.Palette.Alignment:=CurrPalette;
 If ExecuteAppDPU(35,FormSetupPaletteColor)Then Begin
  CurrPalette:=FormSetupPaletteColor.Palette.Alignment;
  If FileExist('ISABEL.COL')Then Path:=''
                            Else Path:=MaltePath;
  GetFile(Path+'ISABEL.COL',CurrPalette,SizeOf(CurrKrs),CurrKrs);
  SaveIni;
  PMPutMnuBar;
  RefreshWindow;
  HRefreshBackground(Windows);
  DefEndBar;
 End;
End;

{ Cette proc‚dure affiche une boŒte de dialogue permettant de choisir une
 des diff‚rentes langues support‚ par le systŠme.
}

Procedure ChangeLanguage;
Var
 FormLanguage:Record
  Language:MRadioButton;
 End;
Begin
 FillClr(FormLanguage,SizeOf(FormLanguage));
 FormLanguage.Language.Alignment:=DefaultLanguage;
 If ExecuteAppDPU(148,FormLanguage)Then Begin
  DefaultLanguage:=FormLanguage.Language.Alignment;
  Case(DefaultLanguage)of
   0:MenuClassicFrancais;
   1:MenuClassicEnglish;
  End;
  RefreshWindow;
 End;
End;

{ Cette fonction permet de s‚lectionner la m‚thode de fonctionnement de la
 manette de jeux.
}

Procedure ConfigJoystick;
Var
 FormConfigJoystick:Record
  Method:MRadioButton;
 End;
 X:Boolean;
Begin
 FillClr(FormConfigJoystick,SizeOf(FormConfigJoystick));
 If ReadMainKey(HKEY_CURRENT_CONFIG,'System\Joystick','Direct',X)Then Begin
  If(X)Then FormConfigJoystick.Method.Alignment:=2
       Else FormConfigJoystick.Method.Alignment:=1;
 End;
 If ExecuteAppDPU(138,FormConfigJoystick)Then Begin
  Repeat
   Case(FormConfigJoystick.Method.Alignment)of
    1:X:=False;
    2:X:=True;
    Else Break;
   End;
   CreateKeyFormat(HKEY_CURRENT_CONFIG,'System\Joystick','Direct',tdBoolean,X)
  Until True;
 End;
End;

Type
 VolumeBarRec=Record
  W:^Window;
  X,Y,H:Byte;
 End;

Procedure VBItem(Var Q:VolumeBarRec;Y:Byte);
Var
 X1,Y1,X2:Byte;
 GX1,GY1:Word;
Begin
 If(IsGrf)Then Begin
  X1:=6+Q.X;X2:=X1+2;Y1:=15-Y+1;
  WEBarSpcHor(Q.W^,X1,Y1,X2);
  WEBarSpcHorRelief(Q.W^,X1,Y1,X2);
  GX1:=((X1+WEGetRX1(Q.W^))shl 3)+4;
  GY1:=GetRawY(Y1+WEGetRY1(Q.W^))+((HeightChr-6)shr 1);
  GraphBoxRelief(GX1,GY1,GX1+14,GY1+6,0);
 End
  Else
 Begin
  Q.W^.CurrColor:=((Q.W^.CurrColor and$F)shl 4)+(Q.W^.CurrColor shr 4);
  WEPutTxtXY(Q.W^,5+Q.X,15-Y+1,' ÄÄÄ ');
  WESetKrBorder(Q.W^);
 End;
End;

Procedure VBRestoreItem(Var Q:VolumeBarRec;Y:Byte);
Var
 X1,Y1:Byte;
 GX1,GY1,GY2:Word;
Begin
 WESetKrBorder(Q.W^);
 If(IsGrf)Then Begin
  X1:=7+Q.X;Y1:=Q.H-1-Y+Q.Y;
  GX1:=X1 shl 3;
  GY1:=GetRawY(Y1);
  GY2:=GY1+HeightChr-1;
  WEBarSpcHor(Q.W^,X1-1,Y1,X1+1);
  WEPutRect(Q.W^,GX1+3,GY1,GX1+4,GY2,Black);
  WEPutLine(Q.W^,GX1+5,GY1,GX1+5,GY2,White);
 End
  Else
 Begin
  If(Y)mod 5=0Then WEPutTxtXY(Q.W^,5+Q.X,15-Y+1,'ÄÄÅÄÄ')
              Else WEPutTxtXY(Q.W^,5+Q.X,15-Y+1,' ÄÅÄ ')
 End;
End;

Procedure VBInit(Var Q:VolumeBarRec;Var W:Window;X,Y,H,T:Byte);Near;
Var
 J:Byte;
 XT,YT:Byte;
 GX1,GY1,GX2,GY2:Word;
Begin
 FillClr(Q,SizeOf(Q));
 Q.W:=@W;
 Q.X:=X;Q.Y:=Y;Q.H:=H;
 WESetKrBorder(W);
 If(IsGrf)Then For J:=0to H-1do Begin
  GX1:=(WEGetRX1(W)+X+5)shl 3;
  GY1:=GetRawY(WEGetRY1(W)+Y+(H-1)-J)+(HeightChr shr 1);
  GX2:=GX1+32;
  If(J)mod 5=0Then Begin
   ClrLnHor(GX1,GY1-1,8,DarkGray);
   ClrLnHor(GX1,GY1,8,Black);
   ClrLnHor(GX1,GY1+1,8,White);
   ClrLnHor(GX2,GY1-1,8,DarkGray);
   ClrLnHor(GX2,GY1,8,Black);
   ClrLnHor(GX2,GY1+1,8,White);
  End
   Else
  Begin
   ClrLnHor(GX1+4,GY1,4,Black);
   ClrLnHor(GX1+4,GY1+1,4,White);
   ClrLnHor(GX2,GY1,4,Black);
   ClrLnHor(GX2,GY1+1,4,White);
  End;
 End
  Else
 For J:=0to H-1do Begin
  If(J)mod 5=0Then WEPutTxtXY(W,X+5,H-1-J+Y,'ÄÄÅÄÄ')
              Else WEPutTxtXY(W,X+6,H-1-J+Y,'ÄÅÄ');
 End;
 WESetKrHigh(W);
 WEPutSmlTxtXY(W,X+7,H+Y,WordToStr(T));
 If(IsGrf)Then Begin
  XT:=WEGetRX1(W)+X;YT:=WEGetRY1(W);
  BarSpcHorReliefExt(XT+1,YT+H+Y,XT+14,W.CurrColor);
  GX1:=((XT+7)shl 3)+2;GY1:=GetRawY(YT+1);
  GX2:=GX1+3;GY2:=GetRawY(YT+H+Y);
  PutRect(GX1+1,GY1+1,GX2-1,GY2-1,Black);
  GraphBoxRelief(GX1,GY1,GX2,GY2,2);
 End;
 WESetKrBorder(W);
 VBItem(Q,T);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure SetSonVolume                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet … l'utilisateur de faire les ajustements souhaŒter
 sur la console de son de l'ordinateur.
}

Procedure SetSonVolume;
Var
 W:Window;
 K:Word;
 J,I,T,P,NP:Byte;
 TV,TL,TR:Array[0..4]of Byte;
 Ok:Boolean;
 Q:Array[0..4]of VolumeBarRec;

 Procedure Bar;Begin
  WEBarSelHor(W,P shl 4,0,(P shl 4)+15)
 End;

Begin
 If Not(IsSoundBlaster)Then Begin
  ErrNoMsgOk(errSoundBlasterRequered);
  Exit;
 End;
 WEInitO(W,80,19);
 WEPushWn(W);
 WEPutWnKrDials(W,'Console de son');
 WECloseIcon(W);
 WEPutTxtXY(W,3,0,'Microphone');
 WEPutTxtXY(W,23,0,'FM');
 WEPutTxtXY(W,32,0,'Disque Compacte');
 WEPutTxtXY(W,53,0,'Ligne');
 WEPutTxtXY(W,68,0,'Volume');
 WESetKrSel(W);
 Bar;
 FillClr(TV,SizeOf(TV));
 P:=0;
 TV[0]:=GetMicVolume;
 TV[1]:=GetFMVolume;
 TV[2]:=GetCDVolume;
 TV[3]:=GetLineVolume;
 TV[4]:=GetMasterVolume;
 For I:=0to 4do Begin
  TL[I]:=(TV[I]shr 5)and$7;
  TR[I]:=(TV[I]shr 1)and$7;
  VBInit(Q[I],W,I shl 4,1,16,((TV[I]shr 1)and$7)+((TV[I]shr 5)and$7));
 End;
 Repeat
  K:=WEReadk(W);
  Case(K)of
   kbInWn:Begin
    Case LastMouseY-WEGetRY1(W)of
     0:Begin
      WaitMouseBut0;
      WESetKrBorder(W);
      Bar;
      P:=(LastMouseX-WEGetRX1(W))shr 4;
      WESetKrSel(W);
      Bar;
     End;
     2..16:Begin
      WaitMouseBut0;
      Ok:=Ya;
      I:=15-(LastMouseY-WEGetRY1(W)-1);
      Dec(LastMouseX,WEGetRX1(W));
      Case(LastMouseX)of
       5..9:NP:=0;
       21..25:NP:=1;
       37..41:NP:=2;
       53..57:NP:=3;
       69..73:NP:=4;
       Else Ok:=No;
      End;
      If(Ok)Then Begin
       If(P<>NP)Then Begin
        WESetKrBorder(W);
        Bar;
        P:=NP;
        WESetKrSel(W);
        Bar;
       End;
       T:=((TV[P]shr 1)and$7)+((TV[P]shr 5)and$7);
       VBRestoreItem(Q[P],T);
       TR[P]:=(I shr 1)+(I and$1);TL[P]:=I shr 1;
       TV[P]:=(TV[P]and$1)or((TL[P]and 7)shl 5)or((TR[P]and 7)shl 1);
       T:=((TV[P]shr 1)and$7)+((TV[P]shr 5)and$7);
       Case(LastMouseX)of
        5..9:SetMicVolume(TV[0]);
        21..25:SetFMVolume(TV[1]);
        37..41:SetCDVolume(TV[2]);
        53..57:SetLineVolume(TV[3]);
        69..73:SetMasterVolume(TV[4]);
       End;
       VBItem(Q[P],T);
       WESetKrHigh(W);
       WEPutSmlTxtXY(W,7+(P shl 4),17,WordToStr(T)+'  ');
      End;
     End;
    End;
   End;
   kbLeft:Begin
    WESetKrBorder(W);
    Bar;
    P:=MinByte(P,4);
    WESetKrSel(W);
    Bar;
   End;
   kbRight,kbTab:Begin
    WESetKrBorder(W);
    Bar;
    P:=MaxByte(P,4);
    WESetKrSel(W);
    Bar;
   End;
   kbDn:Begin
    T:=((TV[P]shr 1)and$7)+((TV[P]shr 5)and$7);
    VBRestoreItem(Q[P],T);
    If TR[P]>TL[P]Then Dec(TR[P])Else
    If TL[P]>0Then Dec(TL[P]);
    TV[P]:=(TV[P]and$1)or((TL[P]and 7)shl 5)or((TR[P]and 7)shl 1);
    T:=((TV[P]shr 1)and$7)+((TV[P]shr 5)and$7);
    VBItem(Q[P],T);
    Case(P)of
     0:SetMicVolume(TV[0]);
     1:SetFMVolume(TV[1]);
     2:SetCDVolume(TV[2]);
     3:SetLineVolume(TV[3]);
     4:SetMasterVolume(TV[4]);
    End;
    WESetKrHigh(W);
    WEPutSmlTxtXY(W,7+(P shl 4),17,WordToStr(T)+'  ');
   End;
   kbUp:Begin
    T:=((TV[P]shr 1)and$7)+((TV[P]shr 5)and$7);
    VBRestoreItem(Q[P],T);
    If TL[P]<TR[P]Then Inc(TL[P])Else
    If TR[P]<7Then Inc(TR[P]);
    TV[P]:=(TV[P]and$1)or((TL[P]and 7)shl 5)or((TR[P]and 7)shl 1);
    T:=((TV[P]shr 1)and$7)+((TV[P]shr 5)and$7);
    VBItem(Q[P],T);
    Case(P)of
     0:SetMicVolume(TV[0]);
     1:SetFMVolume(TV[1]);
     2:SetCDVolume(TV[2]);
     3:SetLineVolume(TV[3]);
     4:SetMasterVolume(TV[4]);
    End;
    WESetKrHigh(W);
    WEPutSmlTxtXY(W,7+(P shl 4),17,WordToStr(T)+'  ');
   End;
   kbClose,kbEnter:Begin
    CreateKeyFormat(HKEY_CURRENT_CONFIG,'System\Sound\Volume','Microphone',tdByte,TV[0]);
    CreateKeyFormat(HKEY_CURRENT_CONFIG,'System\Sound\Volume','FM',tdByte,TV[1]);
    CreateKeyFormat(HKEY_CURRENT_CONFIG,'System\Sound\Volume','CD',tdByte,TV[2]);
    CreateKeyFormat(HKEY_CURRENT_CONFIG,'System\Sound\Volume','Line',tdByte,TV[3]);
    CreateKeyFormat(HKEY_CURRENT_CONFIG,'System\Sound\Volume','Master',tdByte,TV[4]);
    Break;
   End;
   kbEsc:Break;
  End;
 Until False;
 WEDone(W);
End;

Function GetEquilizerRegister(X:Byte):Byte;Assembler;ASM
 MOV DX,SoundPort
 ADD DX,4
 MOV AL,68h
 ADD AL,X
 OUT DX,AL
 INC DX
 IN  AL,DX
 {$IFOPT G+}
  SHR AL,4
 {$ELSE}
  SHR AL,1
  SHR AL,1
  SHR AL,1
  SHR AL,1
 {$ENDIF}
END;

Procedure SetEquilizerRegister(X,V:Byte);Assembler;ASM
 MOV DX,SoundPort
 ADD DX,4
 MOV AL,68h
 ADD AL,X
 MOV AH,V
 {$IFOPT G+}
  SHR AH,4
 {$ELSE}
  SHR AH,1
  SHR AH,1
  SHR AH,1
  SHR AH,1
 {$ENDIF}
 OUT DX,AX
END;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure SetEquilizer                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet … l'utilisateur de faire les ajustements souhaŒter
 sur l'‚galisateur de fr‚quence de son de l'ordinateur.
}

Procedure SetEquilizer;
Var
 W:Window;
 K:Word;
 J,I,T,P:Byte;
 TV,TL,TR:Array[0..4]of Byte;
 Q:Array[0..4]of VolumeBarRec;

 Procedure Bar;Begin
  WEBarSelHor(W,P shl 4,0,(P shl 4)+15)
 End;

Begin
 If Not(IsSoundBlaster)Then Begin
  ErrNoMsgOk(errSoundBlasterRequered);
  Exit;
 End;
 WEInitO(W,64,19);
 WEPushWn(W);
 WEPutWnKrDials(W,'galisateur de fr‚quences');
 WECloseIcon(W);
 WEPutTxtXY(W,1,0,'Treble gauche');
 WEPutTxtXY(W,17,0,'Treble droite');
 WEPutTxtXY(W,34,0,'Basse gauche');
 WEPutTxtXY(W,50,0,'Basse droite');
 WESetKrSel(W);
 Bar;
 FillClr(TV,SizeOf(TV));
 P:=0;
 For I:=0to 3do Begin
  TV[I]:=GetEquilizerRegister(I);
  VBInit(Q[I],W,I shl 4,1,16,TV[I]);
 End;
 Repeat
  K:=WEReadk(W);
  Case(K)of
   kbLeft:Begin
    WESetKrBorder(W);
    Bar;
    P:=MinByte(P,3);
    WESetKrSel(W);
    Bar;
   End;
   kbRight,kbTab:Begin
    WESetKrBorder(W);
    Bar;
    P:=MaxByte(P,3);
    WESetKrSel(W);
    Bar;
   End;
   kbDn:Begin
    T:=TV[P];
    VBRestoreITem(Q[P],T);
    If TV[P]>0Then Dec(TV[P]);
    T:=TV[P];
    VBItem(Q[P],T);
    SetEquilizerRegister(P,T);
    WESetKrHigh(W);
    WEPutSmlTxtXY(W,7+(P shl 4),17,WordToStr(T)+'  ');
   End;
   kbUp:Begin
    T:=TV[P];
    VBRestoreItem(Q[P],T);
    If TV[P]<15Then Inc(TV[P]);
    T:=TV[P];
    VBItem(Q[P],T);
    SetEquilizerRegister(P,T);
    WESetKrHigh(W);
    WEPutSmlTxtXY(W,7+(P shl 4),17,WordToStr(T)+'  ');
   End;
   kbClose,kbEsc,kbEnter:Break;
  End;
 Until No;
 WEDone(W);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure ActionClock                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure est en faŒte un processus d'arriŠre plan s'avertuant …
 toujours afficher l'heure exacte de l'horloge … digital ainsi que celle
 num‚rique.
}

Procedure ActionClock;Far;
Var
 Curr,Hour,Min,Sec:Byte;
 Time:LongInt;
 Tx,Ty:Word;
 R:Real;
Begin
 DataClock^.OldBackKbd;
 Curr:=GetRawTimerB and$F0;
 If(Curr<>DataClock^.OldClock)Then Begin
  DataClock^.OldClock:=Curr;
  Time:=GetRawTimer;
  If Time<>0Then Begin
   Time:=(Time*901)shr 14; {C'est plus rapide  que d'utiliser la longue
                            formule ®(Time*10)/182¯ prenant des siŠcles
                            au processeur … s'ex‚cuter.  Car vous savez
                            s–rement comme moi qu'effectue une division
                            sur un micro-processeur de la famille INTEL
                            prend tellement  de cycle  d'horloge  qu'un
                            humain compte plus vite que lui … la main.}
   Hour:=DivLong(Time,60*60);
   Min:=Word(DivLong(Time,60))mod 60;{Il y a 1440 minutes par jours au maximum,
                                 mettont  1500,  malgr‚  tous,  la  valeur
                                 reste suffisament petite  pour rester sur
                                 2 octets et  donc le tronquage  en un mot
                                 de 2  octets  par ®Wd¯  est  parfaitement
                                 possible ici.}
   Sec:=Time mod 60; { Ce cas si est diff‚rent du calcul des minutes,
                       ainsi, la partie … diviser pour en extraire la
                       partie restante  doit ˆtre  un entier long  (4
                       octets)  et non pas un mot  de 2 octets  comme
                       dans le  cas  de  ®Min¯...  Si vous  tentez la
                       division  restante  avec  2 octets,  vous vous
                       retrouverez  avec un d‚calage  d'une vingtaine
                       de seconde  avec les minutes...  Donc  laisser
                       cette ligne tranquille!!!!}
   If(IsGrf)Then Begin
    If(Min<>DataClock^.Min)or(Hour<>DataClock^.Hour)Then Begin
     If DataClock^.HX1<>0Then Begin
      PutLine(DataClock^.HX1,DataClock^.HY1,
              DataClock^.HX2,DataClock^.HY2,DataClock^.BackKr);
     End;
     R:=Pi*(DataClock^.Min/30+1.5);
     PutLine(DataClock^.Cx,DataClock^.Cy,
             Trunc(Cos(R)*(DataClock^.Rx-20))+DataClock^.Cx,
             Trunc(Sin(R)*(DataClock^.Ry-20))+DataClock^.Cy,
             DataClock^.BackKr);
    End;
    R:=Pi*(DataClock^.Sec/30+1.5);
    PutLine(DataClock^.Cx,DataClock^.Cy,
            Trunc(Cos(R)*(DataClock^.Rx-25))+DataClock^.Cx,
            Trunc(Sin(R)*(DataClock^.Ry-25))+DataClock^.Cy,DataClock^.BackKr);
   End;
   If(IsGrf)Then Begin
    R:=Pi*((30*Hour+(Min shr 1))/180+1.5);
    DataClock^.HX1:=DataClock^.Cx;DataClock^.HY1:=DataClock^.Cy;
    DataClock^.HX2:=Trunc(Cos(R)*(DataClock^.Rx-35))+DataClock^.Cx;
    DataClock^.HY2:=Trunc(Sin(R)*(DataClock^.Ry-35))+DataClock^.Cy;
    PutLine(DataClock^.HX1,DataClock^.HY1,
            DataClock^.HX2,DataClock^.HY2,LightRed);
    R:=Pi*(Min/30+1.5);
    PutLine(DataClock^.Cx,DataClock^.Cy,
            Trunc(Cos(R)*(DataClock^.Rx-20))+DataClock^.Cx,
            Trunc(Sin(R)*(DataClock^.Ry-20))+DataClock^.Cy,Yellow);
    R:=Pi*(Sec/30+1.5);
    PutLine(DataClock^.Cx,DataClock^.Cy,
            Trunc(Cos(R)*(DataClock^.Rx-25))+DataClock^.Cx,
            Trunc(Sin(R)*(DataClock^.Ry-25))+DataClock^.Cy,LightGreen);
   End;
   If(Hour<>DataClock^.Hour)Then Begin
    If DataClock^.P<>3Then Begin
     DataClock^.W.CurrColor:=$8F;
     WEPutTxtXY(DataClock^.W,6,3,Str0(Hour,2));
    End;
    DataClock^.Hour:=Hour;
   End;
   If(Min<>DataClock^.Min)Then Begin
    If DataClock^.P<>4Then Begin
     DataClock^.W.CurrColor:=$8F;
     WEPutTxtXY(DataClock^.W,9,3,Str0(Min,2));
    End;
    DataClock^.Min:=Min;
   End;
   If DataClock^.P<>5Then Begin
    DataClock^.W.CurrColor:=$8F;
    WEPutTxtXY(DataClock^.W,12,3,Str0(Sec,2));
   End;
   DataClock^.Sec:=Sec;
  End;
 End;
End;

Procedure SetClock;
Var
 Year,K:Word;
 PBuffer:Array[0..63]of Char;
 PC:PChr;
 Mouth,Day,DayOfWeek,OldHour,OldMin,OldSec,Sec100:Byte;
 Ok:Boolean;
 L,H:Byte;
 I,Tx,Ty:Word;
 R:Real;
 S:String;
 Q:ClockRec;

 Procedure MouseAction;
 Var
  OP,MX,MY:Byte;
 Begin
  MX:=LastMouseX-WEGetRX1(Q.W);
  MY:=LastMouseY-WEGetRY1(Q.W);
  OP:=Q.P;
  Case(MY)of
   1:Case(MX)of
    6..9:Q.P:=0;
    11..12:Q.P:=1;
    14..wnMax:Q.P:=2;
   End;
   3:Case(MX)of
    6..7:Q.P:=3;
    9..10:Q.P:=4;
    12..13:Q.P:=5;
   End;
   5..20:Q.P:=6;
  End;
  If(Q.P<>OP)and(MY<4)Then WaitMouseBut0;
 End;

 Procedure UpDateData;Begin
  WEPutTxtXY(Q.W,6,1,Str0(Year,4));
  WESetCube(Q.W,10,1,DtSep[0]);
  WEPutTxtXY(Q.W,11,1,Str0(Mouth,2));
  WESetCube(Q.W,13,1,DtSep[0]);
  WEPutTxtXY(Q.W,14,1,Str0(Day,2));
  WEBarSpcHorShade(Q.W,6,3,13);
  WEPutTxtXY(Q.W,6,3,Str0(Q.Hour,2));
  WESetCube(Q.W,8,3,TmSep[0]);
  WEPutTxtXY(Q.W,9,3,Str0(Q.Min,2));
  WESetCube(Q.W,11,3,TmSep[0]);
  WEPutTxtXY(Q.W,12,3,Str0(Q.Sec,2));
 End;

Begin
 FillClr(Q,SizeOf(Q));
 If(IsGrf)Then Begin
  L:=48;H:=20;
 End
  Else
 Begin
  L:=30;H:=9;
 End;
 WEInitO(Q.W,L,H);
 WEPushWn(Q.W);
 WEPutWnKrDials(Q.W,'Ajustement de l''Horloge');
 WECloseIcon(Q.W);
 WELn(Q.W);
 WEBar(Q.W);
 WEPutTxtLn(Q.W,'Date');
 WELn(Q.W);
 WEPutTxtLn(Q.W,'Heure');
 Q.P:=0;PC:=@PBuffer;Ok:=No;
 WESetKr(Q.W,$8F);
 WEBarSpcHorShade(Q.W,6,1,15);
 GetDate(Year,Mouth,Day,DayOfWeek);
 If Not(IsGrf)Then Begin
  GetTime(Q.Hour,Q.Min,Q.Sec,Sec100);
  OldHour:=Q.Hour;OldMin:=Q.Min;OldSec:=OldSec;
 End
  Else
 Begin
  GetTime(OldHour,OldMin,OldSec,Sec100);
 End;
 UpDateData;
 WESetKrBorder(Q.W);
 DataClock:=@Q;
 Q.OldBackKbd:=_BackKbd;_BackKbd:=ActionClock;
  { Si Graphique: Cr‚ation du dessin de l'horloge: }
 If(IsGrf)Then Begin
  Q.BackKr:=Q.W.CurrColor shr 4;
  Q.Cx:=(WEGetRX1(Q.W)+30)shl 3;Q.Cy:=GetRawY(WEGetRY1(Q.W)+8);
  Q.Rx:=30shl 2;Q.Ry:=GetRawY(15)shr 1;
  For I:=0to 59do Begin
   R:=I*Pi/30;
   Tx:=Trunc(Cos(R)*Q.Rx)+Q.Cx;Ty:=Trunc(Sin(R)*Q.Ry)+Q.Cy;
   PutFillBox(Tx,Ty,Tx+2,Ty+2,0);
   PutFillBox(Tx-1,Ty-1,Tx-1+2,Ty-1+2,Q.W.CurrColor and$F);
  End;
  For I:=0to 11do Begin
   R:=I*Pi/6;
   Tx:=Trunc(Cos(R)*Q.Rx)+Q.Cx;Ty:=Trunc(Sin(R)*Q.Ry)+Q.Cy;
   PutFillBox(Tx,Ty,Tx+4,Ty+4,0);
   PutFillBox(Tx-1,Ty-1,Tx-1+4,Ty-1+4,Q.W.CurrColor and$F);
   S:=IntToStr((I+2) mod 12+1);
   OutTxtXY(Trunc(Cos(R)*(Q.Rx-10))+Q.Cx-2,Trunc(Sin(R)*(Q.Ry-10))+Q.Cy-3,S,0);
   OutTxtXY(Trunc(Cos(R)*(Q.Rx-10))+Q.Cx-3,Trunc(Sin(R)*(Q.Ry-10))+Q.Cy-4,S,Q.W.CurrColor and$F);
  End;
 End;
 WEOkCancel(Q.W);
 Repeat
  Case(Q.P)of
   0:Begin
    StrPascalCopy(PBuffer,SizeOf(PBuffer),Str0(Year,4));
    WESetInpColors(Q.W,$8F,Q.W.Palette.Sel);
    K:=_WEInput(Q.W,6,1,9,4,PC);
    WESetKr(Q.W,$8F);
    Year:=StrToWord(StrPas(PC));
    UpDateData;
    Case(K)of
     kbInWn:MouseAction;
     kbClose:Break;
     kbEsc:Break;
     kbDn:Q.P:=3;
     kbRight,kbTab:Q.P:=1;
     kbUp,kbLeft,kbEnter,kbShiftTab:Q.P:=6;
    End;
   End;
   1:Begin
    StrPascalCopy(PBuffer,SizeOf(PBuffer),Str0(Mouth,2));
    WESetInpColors(Q.W,$8F,Q.W.Palette.Sel);
    K:=_WEInput(Q.W,11,1,12,2,PC);
    WESetKr(Q.W,$8F);
    Mouth:=StrToWord(StrPas(PC));
    UpDateData;
    Case(K)of
     kbInWn:MouseAction;
     kbClose,kbEsc:Break;
     kbDn:Q.P:=4;
     kbRight,kbTab:Q.P:=2;
     kbLeft,kbShiftTab:Q.P:=0;
     kbUp,kbEnter:Q.P:=6;
    End;
   End;
   2:Begin
    StrPascalCopy(PBuffer,SizeOf(PBuffer),Str0(Day,2));
    WESetInpColors(Q.W,$8F,Q.W.Palette.Sel);
    K:=_WEInput(Q.W,14,1,15,2,PC);
    WESetKr(Q.W,$8F);
    Day:=StrToWord(StrPas(PC));
    UpDateData;
    Case(K)of
     kbInWn:MouseAction;
     kbClose,kbEsc:Break;
     kbDn:Q.P:=5;
     kbRight,kbTab:Q.P:=3;
     kbLeft,kbShiftTab:Q.P:=1;
     kbUp,kbEnter:Q.P:=6;
    End;
   End;
   3:Begin
    StrPascalCopy(PBuffer,SizeOf(PBuffer),Str0(Q.Hour,2));
    WESetInpColors(Q.W,$8F,Q.W.Palette.Sel);
    K:=_WEInput(Q.W,6,3,7,2,PC);
    WESetKr(Q.W,$8F);
    Q.Hour:=StrToWord(StrPas(PC));
    SetTime(Q.Hour,Q.Min,Q.Sec,0);
    UpDateData;
    Case(K)of
     kbInWn:MouseAction;
     kbClose,kbEsc:Break;
     kbUp:Q.P:=0;
     kbDn,kbRight,kbTab:Q.P:=4;
     kbLeft,kbShiftTAb:Q.P:=2;
     kbEnter:Q.P:=6;
    End;
   End;
   4:Begin
    StrPascalCopy(PBuffer,SizeOf(PBuffer),Str0(Q.Min,2));
    WESetInpColors(Q.W,$8F,Q.W.Palette.Sel);
    K:=_WEInput(Q.W,9,3,10,2,PC);
    WESetKr(Q.W,$8F);
    Q.Min:=StrToWord(StrPas(PC));
    SetTime(Q.Hour,Q.Min,Q.Sec,0);
    UpDateData;
    Case(K)of
     kbInWn:MouseAction;
     kbClose,kbEsc:Break;
     kbUp:Q.P:=1;
     kbDn,kbRight,kbTab:Q.P:=5;
     kbLeft,kbShiftTab:Q.P:=3;
     kbEnter:Q.P:=6;
    End;
   End;
   5:Begin
    StrPascalCopy(PBuffer,SizeOf(PBuffer),Str0(Q.Sec,2));
    WESetInpColors(Q.W,$8F,Q.W.Palette.Sel);
    K:=_WEInput(Q.W,12,3,13,2,PC);
    WESetKr(Q.W,$8F);
    Q.Sec:=StrToWord(StrPas(PC));
    SetTime(Q.Hour,Q.Min,Q.Sec,0);
    UpDateData;
    Case(K)of
     kbInWn:MouseAction;
     kbClose,kbEsc:Break;
     kbUp:Q.P:=2;
     kbDn,kbRight,kbTab,kbEnter:Q.P:=6;
     kbLeft,kbShiftTab:Q.P:=4;
    End;
   End;
   6:Case WEInpOkCancel(Q.W)of
    kbInWn:MouseAction;
    kbAbort,kbEsc,1:Break;
    kbShiftTab:Q.P:=5;
    kbTab:Q.P:=0;
    0:Begin
     Ok:=True;
     Break;
    End;
   End;
  End;
 Until No;
 If(Ok)Then Begin
  SetDate(Year,Mouth,Day);
  OldYear:=0;
 End
  Else
 SetTime(OldHour,OldMin,OldSec,0);
 _BackKbd:=Q.OldBackKbd;
 WEDone(Q.W);
End;

Function SetCountryCode(Code:Word):Boolean;Assembler;ASM
 MOV AX,038FFh
 MOV DX,0FFFFh
 MOV BX,Code
 INT 21h
 MOV AL,0
 JC  @End
 MOV AX,Code
 MOV CountryCode,AX
 MOV AL,1
@End:
END;

Type
 FormChangeCountryRec=Record
  Country:MListBox;
  Extern:MExtern;
  Data:CountryDataSetRec;
  RX1,RY1:Byte;
  LM:^LstMnu;             { Liste de dialogue }
 End;

Procedure CCOnMove(Var L:LstMnu;Var Context);
Label 1;
Var
 Q:FormChangeCountryRec Absolute Context;
 ConvL:LongInt Absolute ConvP;
 X:XInf;
 GX1,GY1:Word;
Begin
 GX1:=(Q.RX1+34)shl 3;GY1:=GetRawY(Q.RY1+14);
 If DBMoveTo(ChantalServer,L.P)Then Begin
  DBReadRec(ChantalServer,Q.Data);
  ConvP:=@Q.Data;
  DBGotoColumnAbs(ChantalServer,5,Pointer(ConvP));
  If ConvL<>0Then Begin
   ASM
    ADD Word Ptr ConvP,4+11
   END;
   FillClr(X,SizeOf(X));
   X.Output:=irmConvMem;
   X.Size:=621;
   RIPutImage(X,GX1,GY1,32,32);
  End
   Else
  Goto 1;
 End
  Else
1:PutFillBox(GX1,GY1,GX1+31,GY1+31,Black);
 PutTxtXYUnKr(Q.RX1+1,Q.RY1+14,'Code de pays: '+StrUSpc(WordToStr(Q.Data.CountryCode),5));
End;

Procedure CCPutIcon(X,Y:Byte;P:Word;Var Context);
Label 1;
Var
 Q:FormChangeCountryRec Absolute Context;
 ConvL:LongInt Absolute ConvP;
 Res:XInf;
 GX1,GY1:Word;
 Data:CountryDataSetRec;
Begin
 GX1:=X shl 3;GY1:=GetRawY(Y);
 If DBMoveTo(ChantalServer,P)Then Begin
  DBReadRec(ChantalServer,Data);
  ConvP:=@Data;
  DBGotoColumnAbs(ChantalServer,5,Pointer(ConvP));
  If ConvL<>0Then Begin
   ASM
    ADD Word Ptr ConvP,4+11
   END;
   FillClr(X,SizeOf(X));
   Res.Output:=irmConvMem;
   Res.Size:=621;
   RIPutImageScale(Res,GX1,GY1,24,HeightChr,CurrKrs.Dialog.Env.List.Border);
  End
   Else
  Goto 1;
 End
  Else
1:PutFillBox(GX1,GY1,GX1+23,GY1+HeightChr-1,Black);
End;

Procedure CCLoadList(Var L:LstMnu;Var Context);
Var
 Q:FormChangeCountryRec Absolute Context;
 PName:^String; { Pointeur sur le nom de pays }
Begin
 If(IsGrf)and(MediaSupport)Then Begin
  L.Space4Icon:=3;
  L.Context:=@Q;
  L.IconRoutine:=CCPutIcon;
  Q.LM:=@L;
 End;
 DBFirst(ChantalServer);
 While Not DBEOF(ChantalServer)do Begin
  DBReadRec(ChantalServer,Q.Data);
  PName:=@Q.Data;
  DBGotoColumnAbs(ChantalServer,4,Pointer(PName));
  If Not ALAddStrWord(L.List,PName^,Q.Data.CountryCode)Then Exit;
  If(Q.Data.ID=MalteCountryCode)or
    ((MalteCountryCode=0)and(Q.Data.CountryCode=CountryCode))Then Begin
   Q.Country.ItemIndex:=L.List.Count-1;
  End;
 End;
End;

Procedure CCExtern(Var R:ResourceWindow;Var Context);
Var
 Q:FormChangeCountryRec Absolute Context;
 GX1,GY1:Word;
Begin
 Q.RX1:=WEGetRX1(R.W);
 Q.RY1:=WEGetRY1(R.W);
 GX1:=(Q.RX1+34)shl 3;GY1:=GetRawY(Q.RY1+14);
 GraphBoxRelief(GX1-1,GY1-1,GX1+32,GY1+32,Black);
End;

Procedure ChangeCountry;
Var
 FormChangeCountry:FormChangeCountryRec;
Begin
 DBOpenServerName(ChantalServer,'CHANTAL:/Country/Country.Dat');
 FillClr(FormChangeCountry,SizeOf(FormChangeCountry));
 FormChangeCountry.Country.LoadList:=CCLoadList;
 FormChangeCountry.Country.OnMove:=CCOnMove;
 FormChangeCountry.Country.Context:=@FormChangeCountry;
 FormChangeCountry.Extern.Call:=CCExtern;
 FormChangeCountry.Extern.Context:=@FormChangeCountry;
 If ExecuteAppDPU(110,FormChangeCountry)Then Begin
  MalteCountryCode:=FormChangeCountry.Data.ID;
  SaveIni;
  If Not SetCountryCode(FormChangeCountry.Country.ItemIndex)Then Begin
   ErrNoMsgOk(errCanChangedCountry)
  End;
  LoadMalteCountry;
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure Control                           Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'acc‚der … un panneau de configuration avec des
 ic“nes accessibles par l'utilisateur via la souris et le clavier.
}

Procedure Control;Begin
 HLoad(Windows,wnProgMan,'SYS:SETUP.INI|Panneau de Configuration');
 SetMnuSwitch;
 DefEndBar;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure SetImageBar                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'afficher une boŒte de dialogue permettant de
 modifier les barres de textures des boŒtes de dialogues.
}

Type
 FormSetImageBarRec=Record
  MacBar:MCheckBox;
  PathActif:String;
  Actif:MButton;
  PathInactif:String;
  Inactif:MButton;
 End;

Procedure SIUpDateTitle(Var Q:FormSetImageBarRec;Const Name:String);
Label Ok;
Var
 Inf:MCanvas;
 I:Char;
Begin
 If(StrI(1,Name)in['*','?'])and(StrI(2,Name)=':')Then For I:='C'to'Z'do Begin
  If FileExist(I+Copy(Name,2,255))Then Goto Ok;
 End;
 If(Name<>'')and(FileExist(Name))Then Begin
Ok:
  StrDispose(FontTitlePath);
  FontTitlePath:=Str2PChr(Name);
  If Not IsPChrEmpty(FontTitlePath)Then Begin
   XFreeMem(FontTitle);
   If(RILoadImage(Name,diAutoDetect,0,$FFFF,
                   rmAllResSteady,[],FontTitle)=eriNone)Then Begin
    RIRes2WnImg(FontTitle,Inf);
    RIMakeDoublon(FontTitle,rmAllResSteady,True,Inf);
    XFreeMem(FontTitle);
    FontTitle:=Inf.Miroir;
   End;
  End;
 End;
End;

Procedure SIImageTitle(Var R:ResourceWindow;Var Context);
Var
 Q:FormSetImageBarRec Absolute Context;
Begin
 SIUpDateTitle(Q,_OpenWinModel(Path2Dir(StrPas(FontTitlePath))+'*.*',
                 'Image de fond du titre',H,omDraw));
 Q.PathActif:=StrPas(FontTitlePath);
 WESetKr(R.W,$8F);
 WEPutTxtXY(R.W,1,6,Q.PathActif);
 WESetKrBorder(R.W);
 _WESetTitle(R.W,R.W.Title);
End;

Procedure SIUpDateInActifTitle(Var Q:FormSetImageBarRec;Const Name:String);
Label Ok;
Var
 Inf:MCanvas;
 I:Char;
Begin
 If(StrI(1,Name)in['*','?'])and(StrI(2,Name)=':')Then For I:='C'to'Z'do Begin
  If FileExist(I+Copy(Name,2,255))Then Goto Ok;
 End;
 If(Name<>'')and(FileExist(Name))Then Begin
Ok:
  StrDispose(FontInActifTitlePath);
  FontInActifTitlePath:=Str2PChr(Name);
  If Not IsPChrEmpty(FontInActifTitlePath)Then Begin
   XFreeMem(FontInActifTitle);
   If(RILoadImage(Name,diAutoDetect,0,$FFFF,
                   rmAllResSteady,[],FontInActifTitle)=eriNone)Then Begin
    RIRes2WnImg(FontInActifTitle,Inf);
    RIMakeDoublon(FontInActifTitle,rmAllResSteady,True,Inf);
    XFreeMem(FontInActifTitle);
    FontInActifTitle:=Inf.Miroir;
   End;
  End;
 End;
End;

Procedure SIImageInActifTitle(Var R:ResourceWindow;Var Context);
Var
 Q:FormSetImageBarRec Absolute Context;
Begin
 SIUpDateInActifTitle(Q,_OpenWinModel(Path2Dir(StrPas(FontInActifTitlePath))+'*.*',
                         'Image de fond du titre inactif',H,omDraw));
 Q.PathInActif:=StrPas(FontInActifTitlePath);
 WESetKr(R.W,$8F);
 WEPutTxtXY(R.W,1,12,Q.PathInActif);
 WESetKrBorder(R.W);
End;

Procedure SetImageBar;
Var
 OldActif,OldInActif:String;
 FormSetImageBar:FormSetImageBarRec;
Begin
 OldActif:=StrPas(FontTitlePath);
 OldInActif:=StrPas(FontInActifTitlePath);
 FillClr(FormSetImageBar,SizeOf(FormSetImageBar));
 FormSetImageBar.MacBar.Checked:=StyleBarTitle=sttMacintosh;
 FormSetImageBar.PathActif:=OldActif;
 FormSetImageBar.Actif.OnPress:=SIImageTitle;
 FormSetImageBar.Actif.Context:=@FormSetImageBar;
 FormSetImageBar.PathInactif:=OldInActif;
 FormSetImageBar.Inactif.OnPress:=SIImageInActifTitle;
 FormSetImageBar.Inactif.Context:=@FormSetImageBar;
 If ExecuteAppDPU(89,FormSetImageBar)Then Begin
  If FormSetImageBar.PathActif<>StrPas(FontTitlePath)Then Begin
   SIUpDateTitle(FormSetImageBar,FormSetImageBar.PathActif);
  End;
  If FormSetImageBar.PathInActif<>StrPas(FontInActifTitlePath)Then Begin
   SIUpDateInActifTitle(FormSetImageBar,FormSetImageBar.PathInActif);
  End;
  SaveIni;
  If(FormSetImageBar.MacBar.Checked)Then StyleBarTitle:=sttMacintosh
                                    Else StyleBarTitle:=sttNone;
  CreateKeyFormat(HKEY_CURRENT_USER,'Window','TitleType',tdByte,StyleBarTitle);
 End
  Else
 Begin
  SIUpDateTitle(FormSetImageBar,OldActif);
  SIUpDateInActifTitle(FormSetImageBar,OldInActif);
 End;
End;

Procedure SetWindows9X;
Var
 FormSetupWindows9X:Record
  DesktopIconOnStartMode:MCheckBox;
  SoundIconOnStatus:MCheckBox;
  CountryIconOnStatus:MCheckBox;
  AssociatedMenuIcon:MCheckBox;
  BannerName:MCheckBox;
  TaskBarVisible:MRadioButton;
  TaskMgr:MCheckBox;
 End;
Begin
 FillClr(FormSetupWindows9X,SizeOf(FormSetupWindows9X));
 FormSetupWindows9X.DesktopIconOnStartMode.Checked:=DesktopIconOnStartMode;
 FormSetupWindows9X.SoundIconOnStatus.Checked:=SoundIconOnStatus;
 FormSetupWindows9X.CountryIconOnStatus.Checked:=CountryIconOnStatus;
 FormSetupWindows9X.AssociatedMenuIcon.Checked:=True;
 FormSetupWindows9X.TaskBarVisible.Alignment:=Byte(TaskBar.Visible);
 FormSetupWindows9X.TaskMgr.Checked:=TaskMgrInTaskBar;
 If ExecuteAppDPU(92,FormSetupWindows9X)Then Begin
  DesktopIconOnStartMode:=FormSetupWindows9X.DesktopIconOnStartMode.Checked;
  SoundIconOnStatus:=FormSetupWindows9X.SoundIconOnStatus.Checked;
  CountryIconOnStatus:=FormSetupWindows9X.CountryIconOnStatus.Checked;
  TaskBar.Visible:=Boolean(FormSetupWindows9X.TaskBarVisible.Alignment);
  CreateKeyFormat(HKEY_CURRENT_USER,'Software\Windows9X\TaskBar','Visible',tdBoolean,TaskBar.Visible);
  TaskMgrInTaskBar:=FormSetupWindows9X.TaskMgr.Checked;
  SaveIni;
  PBLastLen:=$FFFF;
  PutFrameTaskBar;
  DefEndBar;
 End;
End;

Type
 FormSoundWindowRec=Record
  PathOpen:String;
  Open:MButton;
  PathClose:String;
  Close:MButton;
 End;

Procedure SWOpenWindows(Var R:ResourceWindow;Var Context);
Var
 Q:FormSoundWindowRec Absolute Context;
Begin
 Q.PathOpen:=_OpenWinModel(Path2Dir(Q.PathOpen)+'*.*',
                 'Image de fond du titre',H,omSound);
 WESetKr(R.W,$8F);
 WEPutTxtXY(R.W,1,3,Q.PathOpen);
 WESetKrBorder(R.W);
End;

Procedure SWCloseWindows(Var R:ResourceWindow;Var Context);
Var
 Q:FormSoundWindowRec Absolute Context;
Begin
 Q.PathClose:=_OpenWinModel(Path2Dir(Q.PathClose)+'*.*',
                         'Son de fermeture de fenˆtre',H,omSound);
 WESetKr(R.W,$8F);
 WEPutTxtXY(R.W,1,9,Q.PathClose);
 WESetKrBorder(R.W);
End;

Procedure SetSoundWindows;
Var
 OldOpen,OldClose:String;
 FormSoundWindow:FormSoundWindowRec;
Begin
 OldOpen:=StrPas(SoundPlay[sndOpenWin]);
 OldClose:=StrPas(SoundPlay[sndCloseWin]);
 FillClr(FormSoundWindow,SizeOf(FormSoundWindow));
 FormSoundWindow.PathOpen:=OldOpen;
 FormSoundWindow.Open.OnPress:=SWOpenWindows;
 FormSoundWindow.Open.Context:=@FormSoundWindow;
 FormSoundWindow.PathClose:=OldClose;
 FormSoundWindow.Close.OnPress:=SWCloseWindows;
 FormSoundWindow.Close.Context:=@FormSoundWindow;
 If ExecuteAppDPU(109,FormSoundWindow)Then Begin
  StrDispose(SoundPlay[sndOpenWin]);
  SoundPlay[sndOpenWin]:=Str2PChr(FormSoundWindow.PathOpen);
  StrDispose(SoundPlay[sndCloseWin]);
  SoundPlay[sndCloseWin]:=Str2PChr(FormSoundWindow.PathClose);
  SaveIni;
 End;
End;

Procedure ConfigBasic;
Var
 FormConfigBasic:Record
  Check:Array[0..10]of MCheckBox;
  Mode:LongInt;
 End;
 I:Byte;
Begin
 FillClr(FormConfigBasic,SizeOf(FormConfigBasic));
 If ReadMainKey(HKEY_CURRENT_USER,'Software\Basic','DefaultMode',FormConfigBasic.Mode)Then Begin
  For I:=0to 10do Begin
   If(FormConfigBasic.Mode shr I)and 1>0Then FormConfigBasic.Check[I].Checked:=True;
  End;
 End
  Else
 For I:=0to 10do Begin
  FormConfigBasic.Check[I].Checked:=True;
 End;
 If ExecuteAppDPU(118,FormConfigBasic)Then Begin
  FormConfigBasic.Mode:=0;
  For I:=0to 10do Begin
   If(FormConfigBasic.Check[I].Checked)Then Begin
    FormConfigBasic.Mode:=FormConfigBasic.Mode or(1 shl I);
   End;
  End;
  CreateKeyFormat(HKEY_CURRENT_USER,'Software\Basic','DefaultMode',tdInteger,FormConfigBasic.Mode);
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                     Proc‚dure VideoEnvironnement                Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de fixer la configuration de la carte vid‚o
 primaire  et  sauvegarder  la  configuration  dans  le  fichier  de
 configuration.
}

Procedure VideoEnvironnement;Begin
 If(VideoSetup)Then Begin
  CreateKeyFormat(HKEY_CURRENT_USER,'Window','ButtonType',tdByte,kType);
  CreateKeyFormat(HKEY_CURRENT_USER,'Window','InputType',tdByte,InputType);
  SaveIni;
 End;
End;