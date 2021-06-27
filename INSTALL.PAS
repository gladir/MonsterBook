Program Install;

{{{$DEFINE Prototype}
{$I DEF.INC}
{$C-,E-,G-,N-,O-,P-,T-,V-}

Uses Adele,Systex,Systems,Video,Mouse,Dialex,Dials,FileMana,
     Editor,MalBkRes,InsSDir,SaveCfg,Protocol;

Var
 Dsk:Byte;
 WCopy:Window;
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
 Case K of
  0: Welcome:=Ya;
Else Welcome:=No;
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
  ChoiceDrvInstall:=No;
 End
  Else
 ChoiceDrvInstall:=Ya;
End;

Procedure InitCopy(Source,Target:PathStr);Begin
 WEInitO(WCopy,40,9);
 WEPushWn(WCopy);
 WEPutWnKrDials(WCopy,'Copie');
 WEPutTxtXY(WCopy,0,1,'De: '+FileExpand(Source));
 WEPutTxtXY(WCopy,0,2,'…: '+FileExpand(Target));
 WESetKr(WCopy,$1F);
 WEBarSpcHorShade(WCopy,0,6,wnMax-1);
 WESetKrBorder(WCopy);
End;

Procedure BackCopy(Pour:Byte;Curr,Total:Long);Begin
 WEPutTxtXY(WCopy,0,4,IntToStr(Curr)+'/'+IntToStr(Total));
 WESetPos(WCopy,0,6);
 WEPutOTxtU(WCopy,IntToStr(Pour)+'%');
 WESetKr(WCopy,$F0);
 WEBarSelHor(WCopy,0,6,Trunc(Pour*((WCopy.MaxX-1)/100)));
 WESetKrBorder(WCopy);
End;

Procedure DoneCopy;Begin
 WEDone(WCopy);
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
 SetPath:=No;
 WEPushEndBar(L);
 SPathMalte:=Char(Dsk+64)+':\MALTE';
 PutLastBar(2,'Entrez le r‚pertoire');
 Repeat
  K:=WinInp(70,'R‚pertoire Central',
     'Entrez le nouveau r‚pertoire principal de l''Application MonsterBook:',
      CurrKrs.Dial.Wins,False,SPathMalte);
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
 PathDownload:=Str2PChr(SetPath4AddFile(StrPas(PathMalte))+'DOWNLOAD');
 PathUpload:=Str2PChr(SetPath4AddFile(StrPas(PathMalte))+'UPLOAD');
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
 WEPutLastBar('Cr‚ation du fichier configuration...');
 SaveIni;
 WEPutLastBar('TransfŠre les fichiers en cours...');
 CopyFile(PathSystems,'FONTS.RLL');
 CopyFile(PathSystems,'FRANCAIS.RLL');
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
 SetPath:=Ya;
End;

{$I Library\System\Malte\Presenta.tio\PutTapis.Inc}

BEGIN
 HardBoot:=No;
 InitSystems(suIsabel);
 SetVideoModeDeluxe(vmTxtDef);
 __InitMouse;
 InitEnv;
 PutTapis(0,MaxYTxts,$19);
 BarSpcHor(0,MaxYTxts-1,MaxXTxts,$7F);
 BarSpcHor(0,0,MaxXTxts,$1F);
 PutCloseIcon(0,0,$F);
 {$IFDEF Prototype}
  PutTxtCenter(0,__Justified__,'Programme d''Installation - MonsterBook (Version Prototype)',$1F);
 {$ELSE}
  PutTxtCenter(0,__Justified__,'Programme d''Installation - MonsterBook',$1F);
 {$ENDIF}
 BarSpcHor(0,MaxYTxts,MaxXTxts,$1F);
 SetAllKr($1B,$1F);
 If(Welcome)Then Begin
  If(ChoiceDrvInstall)Then SetPath;
 End;
 DoneLuxeVideo;
 If(HardBoot)Then Begin
  WriteLn('Installation du MonsterBook complet‚!');
  WriteLn;
  WriteLn('Entrez au prompt du Dos:');
  WriteLn(' C:MB');
 End;
 DoneSystems;
END.