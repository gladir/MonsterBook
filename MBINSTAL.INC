{$I DEF.INC}

Procedure Install;
Procedure InstallSelective;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                IMPLEMENTATION
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses
 Adele,UnZip,Systex,Systems,Video,Mouse,Dialex,Dials,DialPlus,
 {$IFDEF FullVersion}
  MBCortex,
  MBSave,
  MBSDir,
 {$ENDIF}
 {$IFDEF BureauVersion}
  MBBCrtex,
  MBBSave,
  MBBSDir,
 {$ENDIF}
 FileMana,Editex,
 {$IFDEF Reseau}
  Protocol,
 {$ENDIF}
 ToolFile;

Var
 PathMalte:PChr;

Procedure Install;
Var
 Dsk:Byte;
 HardBoot:Boolean;

 Function Welcome:Boolean;
 Var
  W,EndBar:Window;
  K:Word;
 Begin
  WEPushEndBar(EndBar);
  WEInitO(W,70,15);
  WEPushWn(W);
  WEPutWnKrDials(W,'Bienvenue');
  WELn(W);
  WEPutTxtLn(W,'Ceci est un programme d''installation pour le Monster Book. Le Monster');
  WEPutTxtLn(W,'est  une application  destin‚  …  traiter  des  masses  d''information');
  WEPutTxtLn(W,'essentiel:  Traitement de texte, Chiffrier ‚l‚tronique,  Programme de');
  WEPutTxtLn(W,'dessin, Editeur Hexad‚cimal, Editeur d''Icon,...   Il permet ‚galement');
  WEPutTxtLn(W,'l''orientation  de  l''information:  Menu  d''Application,  Gestionnaire');
  WEPutTxtLn(W,'de fichiers, Terminal, Prompt Dos/Unix et SystŠme Information.');
  WELn(W);
  WEPutTxtLn(W,'Remarque:  Cette Application r‚clame  1,5 Mo d''espace libre sur votre');
  WEPutTxtLn(W,'           Disque Dur. Si vous n''avez pas assez d''espace, s‚lectionn‚');
  WEPutTxtLn(W,'           Quitter.');
  PutLastBar(2,'Appuyez sur ^Continue^ pour poursuivre ou ^Quitter^ pour terminer.');
  K:=WEGetkHorDn(W,'Continue|Quitter');
  Case(K)of
   0: Welcome:=True;
 Else Welcome:=False;
  End;
  WEDone(EndBar);
  WEDone(W);
 End;

 Function ChoiceDrvInstall:Boolean;
 Var
  L:Window;
 Begin
  WEPushEndBar(L);
  PutLastBar(2,'S‚lectionn‚ le disque o— doit ˆtre install‚ l''Application');
  Dsk:=RawSelectDisk(3);
  WEDone(L);
  If DiskFree(Dsk)<1048576Then Begin
   WarningMsg('D‚sol‚! l''installation du systŠme est impossible … cause du manque d''espace disque...',KeyOk);
   ChoiceDrvInstall:=False;
  End
   Else
  ChoiceDrvInstall:=True;
 End;

 Function SetPath:Boolean;
 Var
  K:Word;
  Handle:Hdl;
  W,L:Window;
  SPathMalte:String;
  PPath:PChrAByte;
  I:Byte;
  Info:SearchRec;

  Procedure CopyFile(Path:PChr;FileName:String);Begin
   InitCopy(SetPath4AddFile(GetCurrentDir)+FileName,SetPath4AddFile(StrPas(Path))+FileName);
   _CopyFile(SetPath4AddFile(GetCurrentDir)+FileName,SetPath4AddFile(StrPas(Path))+FileName,BackCopy);
   DoneCopy;
  End;

 Begin
  SetPath:=False;
  WEPushEndBar(L);
  SPathMalte:=Char(Dsk+64)+':\MALTE';
  PutLastBar(2,'Entrez le r‚pertoire');
  Repeat
   K:=WinInp(70,'R‚pertoire Central',
      'Entrez le nouveau r‚pertoire principal de l''Application MonsterBook:',
       CurrKrs.Dial.Window,No,SPathMalte);
  Until(K=kbEsc)or(K=kbEnter);
  PathMalte:=Str2PChr(SPathMalte);
  WEDone(L);
  If(K=kbEsc)Then Exit;
  PathSystems:=Str2PChr(SetPath4AddFile(StrPas(PathMalte))+'SYSTEMS');
  PathResource:=Str2PChr(SetPath4AddFile(StrPas(PathMalte))+'RESOURCE');
  PathCountry:=Str2PChr(SetPath4AddFile(StrPas(PathMalte))+'COUNTRY');
  PathUnix:=Str2PChr(SetPath4AddFile(StrPas(PathMalte))+'UNIX');
  PathOS2:=Str2PChr(SetPath4AddFile(StrPas(PathMalte))+'OS2');
  PathWin:=Str2PChr('?:\WINDOWS');
  For I:=3to 26do If DirExist(Char(I+64)+':\WINDOWS')Then
  Begin
   PathWin^[0]:=Char(I);
   Break;
  End;
  {PathAdams:=Str2PChr(SetPath4AddFile(StrPas(PathMalte))+'ADAMS');
  PathAmiga:=Str2PChr(SetPath4AddFile(StrPas(PathMalte))+'AMIGA');
  PathAppleII:=Str2PChr(SetPath4AddFile(StrPas(PathMalte))+'APPLEII');
  PathAppleMac:=Str2PChr(SetPath4AddFile(StrPas(PathMalte))+'APPLEMAC');
  PathAtari2600:=Str2PChr(SetPath4AddFile(StrPas(PathMalte))+'ATARI2600');
  PathTRS80:=Str2PChr(SetPath4AddFile(StrPas(PathMalte))+'TRS80');
  PathCoco3:=Str2PChr(SetPath4AddFile(StrPas(PathMalte))+'COCO3');
  PathCommodore64:=Str2PChr(SetPath4AddFile(StrPas(PathMalte))+'CK64');
  PathVIC20:=Str2PChr(SetPath4AddFile(StrPas(PathMalte))+'VIC20');}
  PathMod:=Str2PChr(SetPath4AddFile(StrPas(PathMalte))+'MOD');
  PathBBS:=Str2PChr(SetPath4AddFile(StrPas(PathMalte))+'BBS');
  PathPhoneList:=Str2PChr(SetPath4AddFile(StrPas(PathMalte))+'BBS');
  {$IFDEF Reseau}
   PathDownload:=Str2PChr(SetPath4AddFile(StrPas(PathMalte))+'DOWNLOAD');
   PathUpload:=Str2PChr(SetPath4AddFile(StrPas(PathMalte))+'UPLOAD');
  {$ENDIF}
  PathCatDisk:=Str2PChr(SetPath4AddFile(StrPas(PathMalte))+'CATDISK');
  PathDraw:=Str2PChr(SetPath4AddFile(StrPas(PathMalte))+'DRAW');
  PathCalc:=Str2PChr(SetPath4AddFile(StrPas(PathMalte))+'CALC');
  PathAsmC:=Str2PChr(SetPath4AddFile(StrPas(PathMalte))+'AC');
  PathMAC:=Str2PChr(SetPath4AddFile(StrPas(PathMalte))+'MAC');
  PathMAC:=Str2PChr(SetPath4AddFile(StrPas(PathMalte))+'MACTXT');
  PathMacDrw:=Str2PChr(SetPath4AddFile(StrPas(PathMalte))+'MACDRW');
  PathObject:=Str2PChr(SetPath4AddFile(StrPas(PathMalte))+'OBJECT');
  PathUnit:=Str2PChr(SetPath4AddFile(StrPas(PathMalte))+'UNIT');
  PathOutput:=Str2PChr(SetPath4AddFile(StrPas(PathMalte))+'OUTPUT');
  PathGat:=Str2PChr(SetPath4AddFile(StrPas(PathMalte))+'TEXT');
  PathAda:=Str2PChr(SetPath4AddFile(StrPas(PathMalte))+'ADA');
  PathAsm:=Str2PChr(SetPath4AddFile(StrPas(PathMalte))+'ASM');
  PathBAS:=Str2PChr(SetPath4AddFile(StrPas(PathMalte))+'BAS');
  PathC:=Str2PChr(SetPath4AddFile(StrPas(PathMalte))+'C');
  PathCobol:=Str2PChr(SetPath4AddFile(StrPas(PathMalte))+'COBOL');
  PathEuphoria:=Str2PChr(SetPath4AddFile(StrPas(PathMalte))+'EUPHORIA');
  PathForth:=Str2PChr(SetPath4AddFile(StrPas(PathMalte))+'FORTH');
  PathFortran:=Str2PChr(SetPath4AddFile(StrPas(PathMalte))+'FORTRAN');
  PathPas:=Str2PChr(SetPath4AddFile(StrPas(PathMalte))+'PASCAL');
  For I:=3to 26do Begin
   If DirExist(Char(I+64)+':\BP')Then Begin{ Borland Pascal ? }
    StrPCopy(@PPath,'?:\BP');
    PathPas:=StrNew(@PPath); PathPas^[0]:=Char(I+64);
    Break;
   End;
   If DirExist(Char(I+64)+':\TP')Then Begin{ Turbo Pascal ? }
    PathPas:=Str2PChr('?:\TP'); PathPas^[0]:=Char(I+64);
    Break;
   End;
  End;
  WEInit(W,0,3,wnMax-1,wnMax-3);
  WEPushWn(W);
  WEPutWnKrDials(W,'R‚pertoires');
  WEPutTxtLn(W,'Centrale:         '+StrPas(PathMalte));
  WEPutTxtLn(W,'SystŠme (RLL):    '+StrPas(PathSystems));
  WEPutTxtLn(W,'Pays:             '+StrPas(PathCountry));
  WEPutTxtLn(W,'Texte (GAT):      '+StrPas(PathGat));
  WEPutTxtLn(W,'Macro texte:      '+StrPas(PathMac));
  WEPutTxtLn(W,'Dessin:           '+StrPas(PathDraw));
  WEPutTxtLn(W,'Macro dessin:     '+StrPas(PathMacDrw));
  WELn(W);
  WEPutTxtLn(W,'Windows:          '+StrPas(PathWin));
  WEPutTxtLn(W,'Source Assembler: '+StrPas(PathAsm));
  WEPutTxtLn(W,'Source Basic:     '+StrPas(PathBas));
  WEPutTxtLn(W,'Source C/C++:     '+StrPas(PathC));
  WEPutTxtLn(W,'Source Pascal:    '+StrPas(PathPas));
  Repeat
   K:=WEGetkHorDn(W,'Continue|Modifie|Quitter');
   Case K of
    1:SetupDir;
    2:Begin
       WEDone(W);
       Exit;
      End;
   End;
  Until K=0;
  WEDone(W);
  WEPutLastBar('Cr‚ation des r‚pertoires...');
  CreateDir(PathMalte);
  CreateDir(PathSystems);
  CreateDir(PathCountry);
  CreateDir(PathGat);
  CreateDir(PathMac);
  CreateDir(PathDraw);
  CreateDir(PathMacDrw);
  StrCopy(@PPath,PathMalte);StrCat(@PPath,PChr(PChar('\FONT')));
  CreateDir(@PPath);
  StrCopy(@PPath,PathMalte);StrCat(@PPath,PChr(PChar('\SPELL')));
  CreateDir(@PPath);
  StrCopy(@PPath,PathMalte);StrCat(@PPath,PChr(PChar('\DATA')));
  CreateDir(@PPath);
  WEPutLastBar('Cr‚ation du fichier configuration...');
  SaveIni;
  WEPutLastBar('TransfŠre les fichiers en cours...');
  CopyFile(PathSystems,'ADELE.RLL');
  CopyFile(PathSystems,'FONTS.RLL');
  CopyFile(PathSystems,'GOLDPLAY.OVL');
  CopyFile(PathMalte,'ISABEL.KEY');
  CopyFile(PathMalte,'ISABEL.COL');
  CopyFile(PathSystems,'VIDEO.DRC');
  CopyFile(PathSystems,'MALBOOK.ICN');
  CopyFile(PathSystems,'MBDRAW.ICN');
  StrCopy(@PPath,PathMalte);StrCat(@PPath,PChr(PChar('\COUNTRY\')));
  CopyFile(@PPath,'FLAGS.ICN');
  StrCopy(@PPath,PathMalte);StrCat(@PPath,PChr(PChar('\SPELL\')));
  CopyFile(@PPath,'VERBES.DTA');
  StrCopy(@PPath,PathMalte);StrCat(@PPath,PChr(PChar('\DATA\')));
  CopyFile(@PPath,'CHANTAL.DAT');
   { Change de disquette }
  If Not(FileExist(SetPath4AddFile(GetCurrentDir)+'MB.EXE'))Then
   WarningMsg('S.V.P. Ins‚rez la disquette #2 - Programme',KeyOk);
  CopyFile(PathMalte,'MB.EXE');
  If Not(FileExist(SetPath4AddFile(GetCurrentDir)+'CALPROG.HLP'))Then
   WarningMsg('S.V.P. Ins‚rez la disquette #3 - Compl‚mentaire',KeyOk);
  CopyFile(PathMalte,'MANUEL.RLL');
  StrCopy(@PPath,PathMalte);StrCat(@PPath,PChr(PChar('\FONT\')));
  FindFirst('*.FNT',fa,Info);
  While SysErr=0do Begin
   CopyFile(@PPath,Info.Name);
   FindNext(Info)
  End;
  FindFirst('*.POL',fa,Info);
  While SysErr=0do Begin
   CopyFile(@PPath,Info.Name);
   FindNext(Info)
  End;
  WEPutLastBar('Cr‚ation du Fichier Batch...');
  HardBoot:=DiskExist(3);
  If(HardBoot)Then Begin
   Handle:=FileCreate('C:\MB.BAT');
   PutFileTxtLn(Handle,'SET MALTE='+StrPas(PathMalte));
   PutFileTxt(Handle,SetPath4AddFile(StrPas(PathMalte))+'MB.EXE');
   FileClose(Handle);
  End;
  SetPath:=True;
 End;

 Procedure HardMessage;
 Var
  W,EndBar:Window;
  K:Word;
 Begin
  WEPushEndBar(EndBar);
  WEInitO(W,40,6);
  WEPushWn(W);
  WEPutWnKrDials(W,'Remarque');
  WELn(W);
  WEPutTxtLn(W,'Installation du MonsterBook complet‚!');
  WELn(W);
  WEPutTxtLn(W,'Lors du prochain d‚marrage vous');
  WEPutTxtLn(W,'devrez entrez au prompt du DOS:');
  WELn(W);
  WEPutTxtLn(W,' C:MB<ENTER>');
  PutLastBar(2,'Appuyez sur ^Continue^ pour terminer.');
  While WEOk(W)do;
  WEDone(EndBar);
 End;

 {$I Library\System\Malte\Presenta.tio\PutTapis.Inc}

Begin
 HardBoot:=False;
 InitSystems(suIsabel);
 SetVideoModeDeluxe(vmTxtDef);
 __InitMouse;
 InitEnv;
 PutTapis(0,MaxYTxts,$19);
 BarSpcHor(0,MaxYTxts-1,MaxXTxts,$7F);
 BarSpcHor(0,0,MaxXTxts,$1F);
 PutCloseIcon(0,0,$F);
 PutTxtCenter(0,__Justified__,'Installation - MonsterBook (L''Oeuvre inhumaine)',$1F);
 BarSpcHor(0,MaxYTxts,MaxXTxts,$1F);
 SetAllKr($1B,$1F);
 WriteLog('Demande d''installation du MonsterBook');
 If(Welcome)Then Begin
  If(ChoiceDrvInstall)Then SetPath;
  If(HardBoot)Then HardMessage;
  SetVideoMode(vmTxtDef);
  WriteLn('Lors du prochain d‚marrage vous devrez entrez au prompt du DOS:');
  WriteLn;
  WriteLn(' C:MB<ENTER>');
  WriteLog('Installation r‚ussie');
 End
  Else
 Begin
  SetVideoMode(vmTxtDef);
  WriteLn('Installation abord‚e!');
  WriteLog('Installation abord‚e!');
 End;
End;

Const
 dirMalte=0;
 dirHlp=1;       { HLP\ }
 dirIcon=2;      { ICON\ }
 dirSpell=3;     { SPELL\ }
 dirSystems=4;   { SYSTEMS\ }

Type
 UnPackRec=Record
  W:Window;
  BP:BarProgress;
  Q:ZipClass;
 End;

Var
 WZ:^UnPackRec Absolute CurrForm;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Proc‚dure InitUnPack                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette routine initialise la boŒte de dialogue de mise … jour d'une
  d‚compression de fichier en cours.
}

Procedure InitUnPack(Const Source,Target:String);Begin
 WEInitO(WZ^.W,40,9);
 WEPushWn(WZ^.W);
 WEPutWnKrDials(WZ^.W,'D‚compression');
 WEBar(WZ^.W);
 WEPutTxtXY(WZ^.W,0,1,'De: '+TruncName(FileExpand(Source),WZ^.W.MaxX-3));
 WEPutTxtXY(WZ^.W,0,2,'…: '+TruncName(FileExpand(Target),WZ^.W.MaxX-2));
 BPInit(WZ^.BP,0,6,WZ^.w);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Proc‚dure BackUnPack                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette routine est appell‚e pour actualiser une boŒte de dialogue de
 d‚compression quand c'est n‚cessaire.
}

Procedure BackUnPack(Pour:Byte);Begin
 WEPutTxtXY(WZ^.W,0,4,'D‚compression de '+CStr(WZ^.Q.ReachedSize)+' sur '+CStr(WZ^.Q.CompSize)+' octet(s)');
 BPProgress(WZ^.BP,Pour);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Proc‚dure DoneCopy                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette routine restitue une boŒte de dialogue destin‚ … la copie de
 fichier.
}

Procedure DoneUnPack;Begin
 WEDone(WZ^.W);
End;

Procedure ZipReport(Retcode:LongInt;Rec:PReportRec);Begin
 If RetCode<16000Then Exit;
 If RetCode>=17000Then Exit;
 ErrNoMsgOk(RetCode);
End;

Function FullNameInstall(Dir:Byte;Name:String):String;Begin
 Case(Dir)of
  dirHlp:Name:='HLP\'+Name;
  dirIcon:Name:='ICON\'+Name;
  dirSpell:Name:='SPELL\'+Name;
  dirSystems:Name:='SYSTEMS\'+Name;
 End;
 FullNameInstall:=MaltePath+Name;
End;

Function FileIsFound(Dir:Byte;Name:String):LongInt;Begin
 FileIsFound:=-1;
 Name:=FullNameInstall(Dir,Name);
 If FileExist(Name)Then FileIsFound:=GetFileSize(Name);
End;

Function FilesIsFound(Dir:Byte;Name:String):LongInt;
Var
 N,NT:LongInt;
 I:Byte;
 S:String;
Begin
 FilesIsFound:=-1;
 N:=0;
 If Pos(';',Name)>0Then Begin
  S:='';
  For I:=1to Length(Name)do If Name[I]=';'Then Begin
   NT:=FileIsFound(Dir,S);
   If NT=-1Then Exit;
   Inc(N,LongInt(NT));
   S:='';
  End
   Else
  IncStr(S,Name[I]);
 End
  Else
 S:=Name;
 NT:=FileIsFound(Dir,S);
 If NT=-1Then Exit;
 Inc(N,LongInt(NT));
 FilesIsFound:=N;
End;

Procedure CheckFile(Dir:Byte;Const Name:String;Var Output:String;Var Ok:Boolean);
Var
 N:LongInt;
Begin
 N:=FilesIsFound(Dir,Name);
 Ok:=N>0;
 If N>0Then Output:='('+ComputeSizeStr(N)+')'
       Else Output:='';
End;

Function FindInstallDir(Const Name:String):String;
Var
 I:Char;
 Dir:String;
 Found:Boolean;
Begin
 If(InstallDir=NIL)Then Begin
  Found:=False;
  For I:='C'to'Z'do Begin
   Dir:=I+':\';
   If FileExist(Dir+Name)Then Begin
    Found:=True;
    Break;
   End;
  End;
  If Not(Found)Then Begin
   Dir:=OpenWin(Name,'Fichier d''installation');
   If Dir<>''Then Begin
    FindInstallDir:=Dir;
    Dir:=Path2Dir(Dir);
   End;
  End;
  InstallDir:=Str2PChr(Dir);
 End;
 FindInstallDir:=StrPas(InstallDir)+Name;
End;

Procedure CopyFiles(Dir:Byte;Const Name:String;Copy:Boolean);
Var
 S:String;
 I:Byte;

 Procedure Unzip(Const Source,Dest:String);
 Var
  W:UnpackRec;
 Begin
  UnzipInit(W.Q);
  WZ:=@W;
  InitUnPack(Source,Dest);
  W.Q.ShowPercent:=BackUnPack;
  FileUnzip(W.Q,Source,MaltePath,Systems.Copy(Dest,Length(MaltePath)+1,255),ZipReport,NIL);
  DoneUnPack;
  UnzipDone(W.Q);
 End;

 Procedure ActionFile(Dir:Byte;Name:String);Begin
  Name:=FullNameInstall(Dir,Name);
  If(Copy)Then Begin
   If Not FileExist(Name)Then Begin
    UnZip(FindInstallDir('MALTE.ZIP'),Name);
   End;
  End
   Else
  DeleteFile(Name);
 End;

Begin
 If Pos(';',Name)>0Then Begin
  S:='';
  For I:=1to Length(Name)do If Name[I]=';'Then Begin
   ActionFile(Dir,S);
   S:='';
  End
   Else
  IncStr(S,Name[I]);
 End
  Else
 S:=Name;
 ActionFile(Dir,S);
End;

Procedure InstallSelective;
Type
 FormInstall=Record
   {SystŠme}
  ImageDemarrage:Boolean;      { MALTE.BMP }
  Extensior:Boolean;           { SYSTEMS\EXTENSIO.DAT }
  BibliothequeImage:Boolean;   { SYSTEMS\MEDIA.RLL }
  FichiersSonore:Boolean;      { PROUTE.WAV, NIII.WAV }
  AssistantMultiMedia:Boolean; { ASSISTAN.RLL }
  ReadMe:Boolean;              { LISEZMOI.DOC, README.TXT }
  ManuelInstruction:Boolean;   { MANUEL.RLL }
  AideDOSnUnix:Boolean;        { HLP\DOS.HLP, HLP\UNIX.HLP }
  App7IlesRC:Boolean;          { SYSTEMS\APP7ILES.RC }
  CoderIcon:Boolean;           { ICON\ASM.ICO,
                                 ICON\COBOL.ICO,
                                 ICON\CPP.ICO,
                                 ICON\PASCAL.ICO }
  ImageDemarrageString:String[10];
  ExtensiorString:String[10];
  BibliothequeImageString:String[10];
  FichiersSonoreString:String[10];
  AssistantMultiMediaString:String[10];
  ReadMeString:String[10];
  ManuelInstructionString:String[10];
  AideDOSnUnixString:String[10];
  App7IlesRCString:String[10];
  CoderIconString:String[10];
   {Application}
  Dictionnaire:Boolean;        { SPELL\SPELL.DAT }
  Bescherelle:Boolean;         { SPELL\VERBES.DTA }
  CloneCommander:Boolean;      { ICON\NC.ICO }
  FileManager:Boolean;         { ICON\WINFILE.ICO }
  ACDSee:Boolean;              { ICON\ACDSEE.ICO }
  DictionnaireString:String[10];
  BescherelleString:String[10];
  CloneCommanderString:String[10];
  FileManagerString:String[10];
  ACDSeeString:String[10];
 End;
Var
 Data:FormInstall;
 OldInstall:FormInstall;
 N:LongInt;
 I:Byte;
 Diff:Boolean;
Begin
 FillClr(Data,SizeOf(Data));
 CheckFile(dirSpell,'SPELL.DAT',Data.DictionnaireString,Data.Dictionnaire);
 CheckFile(dirSpell,'VERBES.DTA',Data.BescherelleString,Data.Bescherelle);
 CheckFile(dirMalte,'MALTE.BMP',Data.ImageDemarrageString,Data.ImageDemarrage);
 CheckFile(dirSystems,'EXTENSIO.DAT',Data.ExtensiorString,Data.Extensior);
 CheckFile(dirSystems,'MEDIA.RLL',Data.BibliothequeImageString,Data.BibliothequeImage);
 CheckFile(dirMalte,'PROUTE.WAV;NIII.WAV',Data.FichiersSonoreString,Data.FichiersSonore);
 CheckFile(dirMalte,'ASSISTAN.RLL',Data.AssistantMultiMediaString,Data.AssistantMultiMedia);
 CheckFile(dirMalte,'LISEZMOI.DOC;README.TXT',Data.ReadMeString,Data.ReadMe);
 CheckFile(dirMalte,'MANUEL.RLL',Data.ManuelInstructionString,Data.ManuelInstruction);
 CheckFile(dirHLP,'DOS.HLP;UNIX.HLP',Data.AideDOSnUnixString,Data.AideDOSnUnix);
 CheckFile(dirSystems,'APP7ILES.RC',Data.App7IlesRCString,Data.App7IlesRC);
 CheckFile(dirIcon,'ASM.ICO;COBOL.ICO;CPP.ICO;LOGO.ICO;PASCAL.ICO',Data.CoderIconString,Data.CoderIcon);
 CheckFile(dirIcon,'NC.ICO',Data.CloneCommanderString,Data.CloneCommander);
 CheckFile(dirIcon,'WINFILE.ICO',Data.FileManagerString,Data.FileManager);
 CheckFile(dirIcon,'ACDSEE.GIF',Data.ACDSeeString,Data.ACDSee);
 OldInstall:=Data;
 If ExecuteAppDPU(101,Data)Then Begin
  ASM
   PUSH DS
    PUSH SS
    POP ES
    MOV DI,Offset OldInstall
    ADD DI,BP
    PUSH SS
    POP DS
    MOV SI,Offset Data
    ADD SI,BP
    MOV CX,TYPE OldInstall
    MOV AL,False
@1: CMPSB
    JNE @2
    LOOP @1
    JMP @3
@2: MOV AL,True
@3:POP DS
   MOV Diff,AL
  END;
  If(Diff)Then Begin
   CopyFiles(dirSpell,'SPELL.DAT',Data.Dictionnaire);
   CopyFiles(dirSpell,'VERBES.DTA',Data.Bescherelle);
   CopyFiles(dirMalte,'MALTE.BMP',Data.ImageDemarrage);
   CopyFiles(dirSystems,'EXTENSIO.DAT',Data.Extensior);
   CopyFiles(dirSystems,'MEDIA.RLL',Data.BibliothequeImage);
   CopyFiles(dirMalte,'PROUTE.WAV;NIII.WAV',Data.FichiersSonore);
   CopyFiles(dirMalte,'ASSISTAN.RLL',Data.AssistantMultiMedia);
   CopyFiles(dirMalte,'LISEZMOI.DOC;README.TXT',Data.ReadMe);
   CopyFiles(dirMalte,'MANUEL.RLL',Data.ManuelInstruction);
   CopyFiles(dirHLP,'DOS.HLP;UNIX.HLP',Data.AideDOSnUnix);
   CopyFiles(dirSystems,'APP7ILES.RC',Data.App7IlesRC);
   CopyFiles(dirIcon,'ASM.ICO;COBOL.ICO;CPP.ICO;LOGO.ICO;PASCAL.ICO',Data.CoderIcon);
   CopyFiles(dirIcon,'NC.ICO',Data.CloneCommander);
   CopyFiles(dirIcon,'WINFILE.ICO',Data.FileManager);
   CopyFiles(dirIcon,'ACDSEE.GIF',Data.ACDSee);
   DialogMsgOk('Installation/d‚sinstallation termin‚.');
  End;
 End;
End;
