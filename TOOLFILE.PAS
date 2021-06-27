{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                                                                         Û
 ³                 Malte Genesis/Outils pour les fichiers                  Û
 ³                                                                         Û
 ³            dition Chantal pour Mode R‚el/IV - Version 1.1              Û
 ³                              1995/11/30                                 Û
 ³                                                                         Û
 ³          Tous droits r‚serv‚s par les Chevaliers de Malte (C)           Û
 ³                                                                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Nom du programmeur
 ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

  Sylvain Maltais


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette unit‚ offrir diff‚rent services utilisateur pour la gestion des
 fichiers.
}


{$I DEF.INC}

Unit ToolFile;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                 INTERFACE
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses Systex,Isatex;

Procedure InitCopy(Const Source,Target:String);
Function  BackCopy(Pour:Byte;Curr,Total:LongInt):Boolean;
Procedure DoneCopy;
Procedure CopyDeluxe(Const Source:String;Target:String);
Procedure CopySelect;
Function  FileMenuContext(Q:PFileManager;Const FullName:String;Const H:SearchRec;Var Refresh:Boolean):Byte;
Procedure MoveDeluxe(Const Source:String;Target:String);
Procedure DriveInfo(Drive:Byte);
Procedure FMConvSelect(Var Q:FileManagerApp;Conv:Byte);
Procedure FMCopyFiles(Var Q:FileManagerApp;Move:Boolean);
Procedure FMCopyFile2Clipboard(Var Q:FileManagerApp);
Procedure FMDeleteFiles(Var Q:FileManagerApp);
Procedure FMInverseWildCard(Var Q:FileManagerApp);
Procedure FMSelWildCard(Var Q:FileManagerApp);
Procedure FMSetAttr(Var Q:FileManagerApp);
Procedure FMUnSelWildCard(Var Q:FileManagerApp);
Procedure FMAnalyseDirectory(Var Q:FileManagerApp;Const FullDir:String);
Function  KillFile(Const FileName:String;Const H:SearchRec):Boolean;
Function  RenameEntry(Const FileName:String;Const Info:SearchRec):Boolean;
Function  SetPropriety(Const Path:String;Var X:SearchRec):Boolean;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                IMPLEMENTATION
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses
 ResServD,Adele,Memories,Systems,Video,Mouse,Dialex,Dials,DialPlus,Disk,
 UnZip,FileMana,SysInter,SysPlus,EdtLoad,EdtSave,ToolDB,ResTex,ResLoadI,
 ResServI,ResSaveI,ToolMusi,C2Pas,ToolDsk,Math,GeoTex,PrnFileM,EdtBlock,
 FMMacro;

Procedure FMRefreshCurrName(Var Q:FileManagerApp);Near;Forward;

Procedure DelSubDir(Const Path:String);Near;
Var
 H:SearchRec;
Begin
 FindFirst(SetPath4AddFile(Path)+'*.*',faAll,H);
 While SysErr=0do Begin
  If(HelpBar)Then PutTxtXYUnKr(44,MaxYTxts,StrUSpc(H.Name,12));
  If(sfaDir)in(H.Attr.Flags)Then Begin
   If Not((H.Name='.')or(H.Name='..')or(H.Name=''))Then
    DelSubDir(SetPath4AddFile(Path)+H.Name)
  End
   Else
  Begin
   If(sfaReadOnly)in(H.Attr.Flags)Then Begin
    FileSetAttr(SetPath4AddFile(Path)+H.Name,faArchive);
   End;
   DeleteFile(SetPath4AddFile(Path)+H.Name);
  End;
  FindNext(H)
 End;
 RmDir(Path);
End;

Procedure CopySubDir(Const Source,Target:String);Near;
Var
 H:SearchRec;
Begin
 FindFirst(SetPath4AddFile(Source)+'*.*',faAll,H);
 MkDir(Target);
 While SysErr=0do Begin
  If(sfaDir)in(H.Attr.Flags)Then Begin
   If Not((H.Name='.')or(H.Name='..')or(H.Name=''))Then
    CopySubDir(SetPath4AddFile(Source)+H.Name,
               SetPath4AddFile(Target)+H.Name)
  End
   Else
  Begin
   CopyDeluxe(SetPath4AddFile(Source)+H.Name,
              SetPath4AddFile(Target)+H.Name);
  End;
  If SysErr=16005Then Exit;
  FindNext(H)
 End;
End;

Procedure MoveSubDir(Const Source,Target:String);Near;
Var
 H:SearchRec;
Begin
 FindFirst(SetPath4AddFile(Source)+'*.*',faAll,H);
 MkDir(Target);
 While SysErr=0do Begin
  If(sfaDir)in(H.Attr.Flags)Then Begin
   If Not((H.Name='.')or(H.Name='..')or(H.Name=''))Then
    MoveSubDir(SetPath4AddFile(Source)+H.Name,
               SetPath4AddFile(Target)+H.Name)
  End
   Else
  Begin
   MoveDeluxe(SetPath4AddFile(Source)+H.Name,
              SetPath4AddFile(Target)+H.Name);
  End;
  If SysErr=16005Then Exit;
  FindNext(H)
 End;
 RmDir(Source);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                      Proc‚dure FMRefreshCurrName                   Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: FileManager
 Portabilit‚:  Local


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de r‚actualiser l'item courant d'un tableau de
 fichier.
}

Procedure FMRefreshCurrName;
Var
 X:SearchRec;
Begin
 BFGetFile(Q.Panel[Q.Plane].BF,Q.Panel[Q.Plane].P,X);
 FMPutBar(Q,Q.Plane,Q.Panel[Q.Plane].Y,Q.Panel[Q.Plane].P,X);
 FMSelectBar(Q,Q.Plane);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Proc‚dure InitCopy                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette routine initialise la boŒte de dialogue de mise … jour d'une copie
 de fichier en cours.
}

Procedure InitCopy(Const Source,Target:String);Begin
 WCopy:=MemAlloc(SizeOf(WCopyRec));
 WEInitO(WCopy^.W,40,12);
 WEPushWn(WCopy^.W);
 WEPutWnKrDials(WCopy^.W,'Copie');
 WEBar(WCopy^.W);
 WEPutTxtXY(WCopy^.W,0,1,'De: '+TruncName(FileExpand(Source),WCopy^.W.MaxX-3));
 WEPutTxtXY(WCopy^.W,0,2,'…: '+TruncName(FileExpand(Target),WCopy^.W.MaxX-2));
 BPInit(WCopy^.BP,0,6,WCopy^.W);
 WEPutkHorDn(WCopy^.W,'Annuler');
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Proc‚dure BackCopy                           Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette routine est appell‚e pour actualiser une boŒte de dialogue de copie
 quand c'est n‚cessaire.
}

Function BackCopy(Pour:Byte;Curr,Total:Long):Boolean;Begin
 BackCopy:=False;
 WEPutTxtXY(WCopy^.W,0,4,'Transfert de '+CStr(Curr)+' sur '+CStr(Total)+' octet(s)');
 BPProgress(WCopy^.BP,Pour);
 If(KeyPress)Then Begin
  Case(ReadKey)of
   kbEnter,kbEsc:Begin
    {If(WarningMsgYesNo('D‚sirez-vous annuler la copie?')=kbYes)Then Exit;}

    Case(InputMsg('Attention','D‚sirez-vous interrompre le processus de '+
                 'copiage de fichier?',
                 KeyYes+KeyNo+KeyAll,wfOctogone+wiExit,CurrKrs.WarningWin))of
     kbYes:Exit;
     kbAll,2:Begin
      SysErr:=16005; { Abord‚ par l'utilisateur }
      Exit;
     End;
    End;
   End;
  End;
 End;
 BackCopy:=True;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Proc‚dure DoneCopy                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette routine restitue une boŒte de dialogue destin‚ … la copie de
 fichier.
}

Procedure DoneCopy;
Var
 OldSysErr:Word;
Begin
 OldSysErr:=SysErr;
 WEDone(WCopy^.W);
 FreeMemory(WCopy,SizeOf(WCopyRec));
 SysErr:=OldSysErr;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Proc‚dure CopyDeluxe                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette routine effectue la copie sp‚cifier dans le paramŠtre source vers le
 paramŠtre destinataire  en affichant  une boŒte  de dialogue pour signifier
 l'‚tat du processus en cours.
}

Procedure CopyDeluxe;
Var
 Rec:SearchRec;
 TSource,TTarget:PathStr;
Begin
 If IsWildCard(Source)Then Begin
  FindFirst(Source,fa,Rec);
  While SysErr=0do Begin
   TSource:=Path2Dir(Source)+Rec.Name;TTarget:=Src2Target(TSource,Target);
   InitCopy(TSource,TTarget);
   _CopyFile(TSource,TTarget,BackCopy);
   DoneCopy;
   If SysErr=16005Then Exit;
   FindNext(Rec);
  End;
 End
  Else
 Begin
  If IsWildCard(Target)Then Target:=Src2Target(Rec.Name,Target)
	    	       Else Target:=Src2Target(Source,Target);
  InitCopy(Source,Target);
  _CopyFile(Source,Target,BackCopy);
  DoneCopy;
 End;
End;

Procedure MoveDeluxe;
Var
 Rec:SearchRec;
 TSource,TTarget:PathStr;
Begin
 If IsWildCard(Source)Then Begin
  FindFirst(Source,fa,Rec);
  While SysErr=0do Begin
   TSource:=Path2Dir(Source)+Rec.Name;TTarget:=Src2Target(TSource,Target);
   InitCopy(TSource,TTarget);
   _MoveFile(TSource,TTarget,BackCopy);
   DoneCopy;
   If SysErr=16005Then Exit;
   FindNext(Rec);
  End;
 End
  Else
 Begin
  If IsWildCard(Target)Then Target:=Src2Target(Rec.Name,Target)
	    	       Else Target:=Src2Target(Source,Target);
  InitCopy(Source,Target);
  _MoveFile(Source,Target,BackCopy);
  DoneCopy;
 End;
End;

Function RenameEntry(Const FileName:String;Const Info:SearchRec):Boolean;
Var
 N:String;
 L:Byte;
Begin
 If NmXTxts>40Then L:=42 Else L:=40;
 RenameEntry:=False;
 N:=Path2NoDir(FileName);
 If(sfaDir)in(Info.Attr.Flags)Then Begin
  If(_WinInp(L,'R‚pertoire','Renomme le r‚pertoire ®'+N+'¯',False,N)=kbYes)Then Begin
   If Not RenDir(FileName,N)Then ErrNoMsgOk(CantRenameDir)
                            Else RenameEntry:=True;
  End;
 End
  Else
 Begin
  If(_WinInp(L,'Fichier','Renomme le fichier ®'+N+'¯',False,N)=kbYes)Then Begin
   RenameFile(FileName,N);
   If GetSysErr<>0Then ErrNoMsgOk(errErrorRenameFile)
                  Else RenameEntry:=True;
  End;
 End;
End;

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

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Proc‚dure FMCopyFiles                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: FileManager


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet  … l'utilisateur de copier  un fichier d'un tableau
 … l'autre s'il s'agit de tableau de fichier ou d'un tableau … un r‚pertoire
 entr‚e par l'utilisateur s'il n'y en a qu'un seul.
}

Procedure FMCopyFiles;
Var
 S,S2,N,N1,N2,OldPath:String;
 J:Word;
 Info:SearchRec;
 L,Err:Byte;

 Procedure Unzip(Const Source,Dest:String);
 Var
  ZipFile:String;
  W:UnpackRec;
 Begin
  UnzipInit(W.Q);
  WZ:=@W;
  InitUnPack(Source,Dest);
  W.Q.ShowPercent:=BackUnPack;
  ZipFile:=Path2Dir(Source);
  BackStr(ZipFile);
  FileUnzip(W.Q,ZipFile,Path2Dir(Dest),Path2NoDir(Source),ZipReport,NIL);
  DoneUnPack;
  UnzipDone(W.Q);
 End;

Begin
 If NmXTxts>40Then L:=42
              Else L:=40;
 FMGetFile(Q,Q.Panel[Q.Plane].P,Info);
 If(FMNumSel(Q)=0)and((sfaDir)in(Info.Attr.Flags))Then Begin
  If Not(Move)Then Begin
   S:=Path2Dir(Q.Panel[Q.Plane].Path)+Info.Name;
   If(Q.Panel[Q.Plane xor 1].Board=BoardFile)Then N:=Path2Dir(Q.Panel[Q.Plane xor 1].Path)+Info.Name
                                       Else N:='';
   If N=''Then ErrNoMsgOk(errInvalidCopyTargetFile)
          Else CopySubDir(S,N);
  End
   Else
  If Not RenameEntry(Path2Dir(Q.Panel[Q.Plane].Path)+Info.Name,Info)Then Exit;
 End
  Else
 Begin
  If(Q.Panel[Q.Plane xor 1].Board=BoardFile)Then N:=Path2Dir(Q.Panel[Q.Plane xor 1].Path)Else
  If(Move)Then N:=FMGetCurrName(Q)
          Else N:='';
  If FMNumSel(Q)=0Then Begin
   Case(Move)of
    True:Begin
     S:='D‚placer/Renommer un Fichier';
     S2:='Entrez la forme destinataire';
    End;
    Else Begin
     S:='Copier un Fichier';
     S2:='Entrez le nom du r‚pertoire destinataire';
    End;
   End;
   If(N<>'')and(Q.Panel[Q.Plane xor 1].Board=BoardFile)Then Begin
    If N[Length(N)]<>'\'Then IncStr(N,'\');
    AddStr(N,Path2NoDir(FMGetCurrName(Q)));
   End;
   If(_WinInp(L,S,S2,False,N)=kbYes)Then Begin
    S:=Path2Dir(N)+Path2NoDir(FMGetCurrName(Q));
    If FileExist(N)Then Begin
     If Not(__InputOverwriteFile(N))Then Exit;
     DeleteFile(N);
    End;
    BFGetFile(Q.Panel[Q.Plane].BF,Q.Panel[Q.Plane].P,Info);
    OldPath:=GetCurrentDir;
    S:=Path2Dir(FMGetCurrName(Q));
    If(KeyPress)and(ReadKey=kbEsc)Then Begin
     If(InputMsg('Attention','D‚sirez-vous interrompre le processus de '+
                 'copiage de fichier?',
                 KeyYes+KeyNo,wfOctogone+wiExit,CurrKrs.WarningWin)=kbYes)Then Exit;
    End;
    ChDir(S);
    S2:=FMGetCurrName(Q);
    If(Q.Panel[Q.Plane].BF.Compressed)Then UnZip(S2,N)
     Else
    Begin
     If Info.Attr.Value and faDir=0Then Begin
      InitCopy(S2,N);
      Case(Move)of
       True:Err:=_MoveFile(S2,N,BackCopy);
      Else Err:=_CopyFile(S2,N,BackCopy);
      End;
      If(DescrInFile)Then Begin
       N1:=SearchDescription(S2);
       If N1<>''Then SetDescription(N,N1);
      End;
      If Err>0Then ErrNoMsgOk(Err);
      DoneCopy;
     End
      Else
     Case(Move)of
       True: MoveSubDir(S2,N);
      Else CopySubDir(S2,N);
     End;
    End;
    ChDir(OldPath);
   End
    Else
   Exit;
  End
   Else
  Begin
   N:=Path2Dir(N);
   If Length(N)>3Then BackStr(N);
   Case(Move)of
    True:S:='D‚placer des Fichier(s)';
    Else S:='Copier des Fichier(s)';
   End;
   If(_WinInp(L,S,'Entrez le nom du r‚pertoire destinataire',False,N)=kbYes)Then Begin
    For J:=0to BFMaxFiles(Q.Panel[Q.Plane].BF)do If Q.Panel[Q.Plane].Select^[J]Then Begin
     N2:=SetPath4AddFile(N);
     FMGetFile(Q,J,Info);
     AddStr(N2,Info.Name);
     If FileExist(N2)Then Begin
      If Not(__InputOverwriteFile(N2))Then Continue;
      DeleteFile(N2);
     End;
     N1:=Path2Dir(FMGetPath(Q))+Info.Name;
     OldPath:=GetCurrentDir;
     S:=Path2Dir(FMGetCurrName(Q));
     If(KeyPress)and(ReadKey=kbEsc)Then Begin
      If(InputMsg('Attention','D‚sirez-vous interrompre le processus de '+
                  'copiage de fichier?',
                  KeyYes+KeyNo,wfOctogone+wiExit,CurrKrs.WarningWin)=kbYes)Then Exit;
     End;
     ChDir(S);
     If(Q.Panel[Q.Plane].BF.Compressed)Then UnZip(N1,N2)
      Else
     Begin
      If Info.Attr.Value and faDir=0Then Begin
       InitCopy(N1,N2);
       Case(Move)of
        True: Err:=_MoveFile(N1,N2,BackCopy);
        Else Err:=_CopyFile(N1,N2,BackCopy);
       End;
       If Err>0Then ErrNoMsgOk(Err);
       DoneCopy;
      End
       Else
      Case(Move)of
        True: MoveSubDir(N1,N2);
       Else CopySubDir(N1,N2);
      End;
     End;
     ChDir(OldPath);
     Q.Panel[Q.Plane].Select^[J]:=False;
    End;
   End
    Else
   Exit;
  End;
 End;
 Q.FreeDsk:=-1;
 FMReadFiles(Q,Q.Plane);
 If(Q.Panel[Q.Plane xor 1].Board=BoardFile)Then FMReadFiles(Q,Q.Plane xor 1);
End;

Function KillFile(Const FileName:String;Const H:SearchRec):Boolean;
Var
 W:Window;                 { BoŒte de dialogue }
Begin
 KillFile:=False;
 ClrKbd;
 If(WarningMsgYesNo('Etes-vous certain de vouloir effacer "'+H.Name+'" ?')=kbYes)Then Begin
  If(sfaDir)in(H.Attr.Flags)Then Begin
   RmDir(FileName);
   GetSysErr:=IoResult;
   If GetSysErr=5Then Begin { AccŠs refus‚? }
    GetSysErr:=0;
    If(ErrMsg('R‚pertoire non vide! Etes-vous vraiment certain de '+
              'vouloir effacer le contenu du r‚pertoire "'+H.Name+'" ?',KeyYes+KeyNo)=kbYes)Then Begin
     WEPushEndBar(W);
     WEPutLastBar('Un instant S.V.P., je vide le r‚pertoire:');
     DelSubDir(FileName);
     WEDone(W);
    End;
   End;
  End
   Else
  Begin
   If(sfaReadOnly)in(H.Attr.Flags)Then Begin
    If(ErrMsg('Fichier Prot‚g‚! Etes-vous vraiment certain de vouloir effacer "'+H.Name+'" ?',KeyYes+KeyNo)=kbYes)Then Begin
     FileSetAttr(FileName,faArchive);
     DeleteFile(FileName)
    End;
   End
    Else
   DeleteFile(FileName);
  End;
  If GetSysErr<>0Then ErrNoMsgOk(GetSysErr)
                 Else KillFile:=True;
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure FMDeleteFiles                    Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: FileManager
 Portabilit‚:  Globale


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'effacer  un/des fichier(s) s‚lectionner ou le
 fichier pointer advenant aucun s‚lectionner. Il demande … l'utilisateur
 s'il est certain de son acte et si oui,  il le fait:  Il  efface  le(s)
 fichier(s).
}

Procedure FMDeleteFiles;Label UpDateData;
Var
 H:SearchRec;               { Information sur le fichier courant }
 K,J:Word;
 NumFiles,NumDir:Word;      { Nombre de fichiers et de r‚pertoires }
 Msg:String;                { Bout de message "x r‚pertoire et y fichiers"}
 Path:String;               { Chemin }
 W:Window;                  { BoŒte de dialogue }
 OldP:RBP;                  { Ancienne position }
 OldY:Byte;                 { Ancienne position vertical affich‚e }
 SkipInput:Boolean;
 Ok:Boolean;                { Processus accepter? }
Begin
 OldP:=Q.Panel[Q.Plane].P;OldY:=Q.Panel[Q.Plane].Y;SkipInput:=False;
 If FMNumSel(Q)=0Then Begin
  FMGetCurrFile(Q,H);
  If KillFile(Path2Dir(FMGetPath(Q))+H.Name,H)Then Goto UpDateData;
 End
  Else
 Begin
  ClrKbd;
  NumDir:=Q.Panel[Q.Plane].DirSelFiles;
  NumFiles:=FMNumSel(Q)-NumDir;   { Calcul le nombre r‚el de fichiers s‚lectionn‚e }
  If NumDir>0Then Begin
   If NumFiles=0Then Begin
    Msg:={$IFDEF Real}WordToStr{$ELSE}IntToStr{$ENDIF}(NumDir)+' r‚pertoires?';
   End
    Else
   Msg:={$IFDEF Real}WordToStr{$ELSE}IntToStr{$ENDIF}(NumDir)+' r‚pertoires et '+
        {$IFDEF Real}WordToStr{$ELSE}IntToStr{$ENDIF}(NumFiles)+' fichiers ?';
  End
   Else
  Msg:={$IFDEF Real}WordToStr{$ELSE}IntToStr{$ENDIF}(NumFiles)+' fichiers ?';
  Ok:=WarningMsgYesNo('Etes-vous certain de vouloir effacer '+Msg)<>kbYes;
  If(Ok)Then Exit;
  ClrKbd;
  Ok:=ErrMsg('Etes-vous vraiment certain de vouloir effacer '+Msg,KeyYes+KeyNo)=kbYes;
  If(Ok)Then Begin
   For J:=0to BFMaxFiles(Q.Panel[Q.Plane].BF)do Begin
    If Q.Panel[Q.Plane].Select^[J]Then Begin
     FMGetFile(Q,J,H);
     If(sfaDir)in(H.Attr.Flags)Then Begin
      WEPushEndBar(W);
      WEPutLastBar('Un instant S.V.P., je vide le r‚pertoire:');
      DelSubDir(Path2Dir(FMGetPath(Q))+H.Name);
      WEDone(W);
     End
      Else
     Begin
      If(sfaReadOnly)in(H.Attr.Flags)Then Begin
       If Not(SkipInput)Then Begin
        ClrKbd;
        K:=ErrMsg('Fichier Prot‚g‚! Etes-vous vraiment certain de '+
                  'vouloir effacer "'+H.Name+'" ?',KeyYes+KeyNo+KeyAll);
        Case(K)of
         kbNo:Break;
         kbAll:SkipInput:=True;
        End;
       End;
       FileSetAttr(Path2Dir(FMGetPath(Q))+H.Name,faArchive)
      End;
      DeleteFile(Path2Dir(FMGetPath(Q))+H.Name);
     End;
    End;
   End;
  End;
UpDateData:
  Q.FreeDsk:=-1;
  FMReadFiles(Q,Q.Plane);
  If(Q.Panel[Q.Plane xor 1].Board=BoardInfo)Then FMPutDisk(Q,Q.Plane xor 1);
  If OldP<BFMaxFiles(Q.Panel[Q.Plane].BF)Then Begin
   Q.Panel[Q.Plane].P:=OldP;Q.Panel[Q.Plane].Y:=OldY;
   FMUpdateBoard(Q,Q.Plane);
  End;
 End;
End;

Procedure CopyPIFStr(Var Target;Size:Byte;Const Source:String);
Var
 I:Integer;
 PTarget:^TByte Absolute Target;
Begin
 FillClr(Target,Size);
 StrPascalCopy(Target,Size,Source);
 For I:=0to Size-1do PTarget^[I]:=Byte(' ');
End;

{ Cette fonction fixe les propri‚t‚s  d'attributs correspondant au fichier
 entr‚e comme paramŠtres. Si l'op‚ration … r‚ussi et donc qu'un changement
 dans le  r‚pertoire  … une lieu  (un rafrachissement)  la valeur vrai est
 retourner.
}

Function SetPropriety(Const Path:String;Var X:SearchRec):Boolean;
Const
 NmItem=4;
Var
 FormPropriety:Record
  Name:String[30];
  FileType:String[30];
  Size:String[30];
  NameDOS:String[12];
  Date:String[20];
  Time:String[20];
  TB:Array[0..NmItem-1]of Boolean; { Information correspondant aux attributs }
  IfProgram:Boolean;
  Title:String[30];
  Command:String[63];
  StartUpDir:String[64];
  Parameters:String[64];
  DoNotClose:Boolean;
  Session:Boolean;
  MPU:MCheckBox;
  WaitState:MCheckBox;
  CPUID:MCheckBox;
  MMX:MCheckBox;
  MalteLib:MCheckBox;
  Kebecup:MCheckBox;
  Video:MRadioButton;
  Key:Byte;
 End;
 SearchPChr:Record
  Fill:Array[0..16]of Char;
  PC:PChr;
 End Absolute X;
 Data:Array[0..511]of Char;
 PIF:Record
  Reserved:Byte;
  Checksum:Byte;
  Title:Array[0..29]of Char;
  MaximumProgramMemory:Word;
  MinimumProgramMemory:Word;
  Command:Array[0..62]of Char;
  DoNotClose:Byte;
  DefaultDrive:Byte;
  StartUpDir:Array[0..63]of Char;
  Parameters:Array[0..63]of Char;
 End Absolute Data;
 PStr:^String;
 Ext:ExtStr;
Begin
 SetPropriety:=False;
 FillClr(FormPropriety,SizeOf(FormPropriety));
 DBOpenServerName(ChantalServer,'CHANTAL:/Fichier/Index.Dat');
 Ext:=Path2Ext(X.Name);
 If DBLocateAbs(ChantalServer,0,Ext,[])Then Begin
  DBReadRec(ChantalServer,Data);
  PStr:=@Data;
  DBGotoColumnAbs(ChantalServer,1,Pointer(PStr));
  FormPropriety.FileType:=PStr^;
 End
  Else
 FormPropriety.FileType:='Inconnu';
 FormPropriety.Name:=StrPas(SearchPChr.PC);
 If FormPropriety.Name=''Then FormPropriety.Name:=X.Name;
 FormPropriety.Size:=CStr(X.Size)+' octets';
 FormPropriety.NameDOS:=X.Name;
 FormPropriety.Date:=CStrDate(X.Time);
 FormPropriety.Time:=CStrTime(X.Time);
 FormPropriety.TB[0]:=sfaReadOnly in X.Attr.Flags;
 FormPropriety.TB[1]:=sfaHidden in X.Attr.Flags;
 FormPropriety.TB[2]:=sfaSysFile in X.Attr.Flags;
 FormPropriety.TB[3]:=sfaArchive in X.Attr.Flags;
 FormPropriety.IfProgram:=Ext='.PIF';
 If(FormPropriety.IfProgram)Then Begin
  GetFile(Path,0,SizeOf(PIF),PIF);
  FormPropriety.Title:=RTrim(LoadStr(PIF.Title,30));
  FormPropriety.Command:=RTrim(LoadStr(PIF.Command,63));
  FormPropriety.StartUpDir:=RTrim(LoadStr(PIF.StartUpDir,64));
  FormPropriety.Parameters:=RTrim(LoadStr(PIF.Parameters,64));
  If PIF.DoNotClose and$10>0Then FormPropriety.DoNotClose:=True;
 End;
 FormPropriety.Session:=(Ext='.COM')or(Ext='.EXE')or(Ext='.BAT')or(Ext='.BTM');
 FormPropriety.MPU.Checked:=True;
 If ExecuteAppDPU(20,FormPropriety)Then Begin
  X.Attr.Value:=(Byte(FormPropriety.TB[0])*faReadOnly+
                 Byte(FormPropriety.TB[1])*faHidden+
                 Byte(FormPropriety.TB[2])*faSysFile+
                 Byte(FormPropriety.TB[3])*faArchive);
  If FileSetAttr(Path,X.Attr.Value)=0Then SetPropriety:=True
  Else ErrNoMsgOk(errCantModifiedFileAttr);
  If(FormPropriety.IfProgram)Then Begin
   CopyPIFStr(PIF.Title,30,FormPropriety.Title);
   CopyPIFStr(PIF.Command,63,FormPropriety.Command);
   CopyPIFStr(PIF.StartUpDir,64,FormPropriety.StartUpDir);
   CopyPIFStr(PIF.Parameters,64,FormPropriety.Parameters);
   If(FormPropriety.DoNotClose)Then PIF.DoNotClose:=PIF.DoNotClose or$10
                               Else PIF.DoNotClose:=PIF.DoNotClose and Not($10);
   SetFile(Path,0,SizeOf(PIF),PIF);
  End;
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                      Fonction FMSetAttr                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: FileManager


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet la modification de l'attribut du fichier
 courant si le tableau est d‚fini aux fichiers.
}

Procedure FMSetAttr;
Const
 NmItem=4;
Var
 X:SearchRec;
 Path:String;
 TB:Array[0..NmItem-1]of Boolean;
Begin
 FMGetCurrFile(Q,X);
 If CmpLeft(X.Name,'..')Then Begin
  ErrNoMsgOk(errCantModifiedEntryAttr);
  Exit;
 End;
 Path:=FMGetCurrName(Q);
 If SetPropriety(Path,X)Then Begin
  BFSetAttr(Q.Panel[Q.Plane].BF,Q.Panel[Q.Plane].P,X.Attr.Value);
  FMRefreshCurrName(Q);
 End;
End;

Procedure FMCopyFile2Clipboard(Var Q:FileManagerApp);
Var
 Handle:Hdl;
 NM:Word;
 Size,I,ND,M:LongInt;
 Buf:Array[0..4095]of Byte;
 W:Window;
 Pour:Byte;
Begin
 Handle:=FileOpen(FMGetCurrName(Q),fmRead);
 If(Handle<>errHdl)Then Begin
  Size:=FileSize(Handle);
  MakeClipboard(Size);
  WEInitO(W,40,9);
  WEPushWn(W);
  WEPutWnKrDials(W,'Copie');
  WEBar(W);
  WEPutTxtXY(W,0,1,'De: '+TruncName(FMGetCurrName(Q),W.MaxX-3));
  WEPutTxtXY(W,0,2,'…:  Presse-papier');
  W.CurrColor:=$1F;
  WEBarSpcHorShade(W,0,6,wnMax);
  ND:=Size div SizeOf(Buf);
  NM:=Size mod SizeOf(Buf);M:=0;
  For I:=0to ND-1do Begin
   _GetAbsRec(Handle,M,SizeOf(Buf),Buf);
   SetAbsClipboard(M,SizeOf(Buf),Buf);
   Inc(M,Long(SizeOf(Buf)));
   Pour:=(Long(M)*100)div Long(Size);
   WESetKrBorder(W);
   WEPutTxtXY(W,0,4,CStr(M)+'/'+CStr(Size));
   WESetPos(W,0,6);
   WEPutOTxtU(W,IntToStr(Pour)+'%');
   W.CurrColor:=$F0;
   WEBarSelHor(W,0,6,(Pour*(W.MaxX-1))div 100);
  End;
  If NM>0Then Begin
   _GetAbsRec(Handle,M,NM,Buf);
   SetAbsClipboard(M,NM,Buf);
  End;
  FileClose(Handle);
  WEDone(W);
 End;
End;

Procedure FMInverseWildCard(Var Q:FileManagerApp);
Var
 I:Word;
 H:SearchRec;
Begin
 If(Q.Panel[Q.Plane].Board=BoardFile)Then Begin
  For I:=0to BFMaxFiles(Q.Panel[Q.Plane].BF)do Begin
   BFGetFile(Q.Panel[Q.Plane].BF,I,H);
   If H.Attr.Value and faDir=0Then Begin
    If WildCardMatch(H.Name,Q.WildCard)Then Begin
     If Not Q.Panel[Q.Plane].Select^[I]Then Begin
      Q.Panel[Q.Plane].Select^[I]:=True;
      Inc(Q.Panel[Q.Plane].SelFiles);
      Inc(Q.Panel[Q.Plane].SizeFileSel,H.Size);
     End
      Else
     Begin
      Q.Panel[Q.Plane].Select^[I]:=False;
      Dec(Q.Panel[Q.Plane].SelFiles);
      Dec(Q.Panel[Q.Plane].SizeFileSel,H.Size);
     End;
    End;
   End;
  End;
  {_FMRefresh(Q);}
  FMUpdateBoard(Q,Q.Plane);
 End;
End;

Procedure FMSelWildCard(Var Q:FileManagerApp);
Var
 I:Word;
 H:SearchRec;
Begin
 If(Q.Panel[Q.Plane].Board=BoardFile)Then Begin
  If(WinInpH(40,'S‚lection','Entrez votre s‚lection:',CurrKrs.Dialog.Window,
                False,Q.WildCard,Q.HWildCard,False)=kbEnter)Then Begin
   Q.WildCard:=StrUp(Q.WildCard);
   For I:=0to BFMaxFiles(Q.Panel[Q.Plane].BF)do Begin
    BFGetFile(Q.Panel[Q.Plane].BF,I,H);
    If H.Attr.Value and faDir=0Then Begin
     If WildCardMatch(H.Name,Q.WildCard)Then Begin
      If Not Q.Panel[Q.Plane].Select^[I]Then Begin
       Q.Panel[Q.Plane].Select^[I]:=True;
       Inc(Q.Panel[Q.Plane].SelFiles);
       Inc(Q.Panel[Q.Plane].SizeFileSel,H.Size);
      End;
     End;
    End;
   End;
   {_FMRefresh(Q);}
   FMUpdateBoard(Q,Q.Plane);
  End;
 End;
End;

Procedure FMUnSelWildCard(Var Q:FileManagerApp);
Var
 I:Word;
 H:SearchRec;
Begin
 If(Q.Panel[Q.Plane].Board=BoardFile)Then Begin
  If(WinInpH(40,'Des‚lection','Entrez votre des‚lection:',CurrKrs.Dialog.Window,
             False,Q.WildCard,Q.HWildCard,False)=kbEnter)Then Begin
   Q.WildCard:=StrUp(Q.WildCard);
   For I:=0to BFMaxFiles(Q.Panel[Q.Plane].BF)do Begin
    BFGetFile(Q.Panel[Q.Plane].BF,I,H);
    If H.Attr.Value and faDir=0Then Begin
     If WildCardMatch(H.Name,Q.WildCard)Then Begin
      If Q.Panel[Q.Plane].Select^[I]Then Begin
       Q.Panel[Q.Plane].Select^[I]:=False;
       Dec(Q.Panel[Q.Plane].SelFiles);
       Dec(Q.Panel[Q.Plane].SizeFileSel,H.Size);
      End;
     End;
    End;
   End;
   {_FMRefresh(Q);}
   FMUpdateBoard(Q,Q.Plane);
  End;
 End;
End;

Procedure CopySelect;
Var
 Data:Record
  S,T:String;
 End;
Begin
 FillClr(Data,SizeOf(Data));
 If ExecuteAppDPU(19,Data)Then CopyDeluxe(Data.S,Data.T);
End;

{$F-}
{$I \Source\Chantal\Library\Disk\Dos\ClusterS.Inc}
{$I \Source\Chantal\Library\Disk\Dos\NmCluste.Inc}
{$F+}

Procedure DriveInfo(Drive:Byte);
Var
 Data:Record
  Volume:String[12];
  TypeDsk:String[20];
  Serial:String[9];
  Used:String[30];
  Free:String[30];
  Size:String[30];
  SectorBytes:String[8];
  ClusterSize:String[8];
  NmCluster:String[8];
  DegreeFree:Word;
 End;
 Free,Size:LongInt;
Begin
 FillClr(Data,SizeOf(Data));
 Data.Volume:=GetDskLabel(Drive);
 If DiskFixed(Drive)Then Data.TypeDsk:='Disque dur'
                    Else Data.TypeDsk:='Unit‚ de disquette';
 Data.Serial:=GetSerialNmStr(Drive-1);
 Size:=DiskSize(Drive);
 Free:=DiskFree(Drive);
 Data.Used:=ComputeSizeStr(DiskUsed(Drive));
 Data.Free:=ComputeSizeStr(Free);
 Data.Size:=ComputeSizeStr(Size);
 Data.SectorBytes:=WordToStr(512);
 Data.ClusterSize:=WordToStr(ClusterSize(Drive)shr 9);
 Data.NmCluster:=WordToStr(NmCluster(Drive));
 If Size<=0Then Data.DegreeFree:=0
           Else Data.DegreeFree:=Trunc((Free/Size)*360);
 ExecuteAppDPU(82,Data);
End;

Procedure ConversionTextBin(Const Source,Dest:String);
Var
 SHandle,DHandle:Hdl;
 Buffer:Array[0..1023]of Byte;
 Size:Word;
 I:Integer;
 FP:LongInt;
Begin
 SHandle:=FileOpen(Source,fmRead);
 If(SHandle<>errHdl)Then Begin
  DHandle:=FileCreate(Dest);
  FP:=0;
  If(DHandle<>errHdl)Then Begin
   Repeat
    Size:=_GetAbsRec(SHandle,FP,SizeOf(Buffer),Buffer);
    For I:=0to Size-1do Begin
     PutFileTxtLn(DHandle,BinByte2Str(Buffer[I]));
    End;
    If Size<SizeOf(Buffer)Then Break;
    Inc(FP,Size);
   Until False;
   FileClose(DHandle);
  End;
  FileClose(SHandle);
 End;
End;

Procedure FMSaveListDirectory(Var Q:FileManagerApp;Const FileName:String);Near;
Var
 Handle:Hdl;
 I,MX:SmallInt;
 H:SearchRec;
Begin
 Handle:=FileCreate(FileName);
 If(Handle<>errHdl)Then Begin
  MX:=BFMaxFiles(Q.Panel[Q.Plane].BF);
  For I:=0to(MX)do Begin
   BFGetFile(Q.Panel[Q.Plane].BF,I,H);
   PutFileTxtLn(Handle,H.Name);
  End;
  FileClose(Handle);
 End;
End;

Function IsGeoWorks(Const Buffer):Boolean;
Var
 Geos:GeosHeader Absolute Buffer;
Begin
 IsGeoWorks:=(Geos.ID=GeosSignID)or(Geos.ID=Geos2SignID);
End;

Function ExtractZipHere(Const CurrDir,FullName:String):Boolean;
Var
 W:UnpackRec;
Begin
 UnzipInit(W.Q);
 WZ:=@W;
 W.Q.ShowPercent:=BackUnPack;
 InitUnPack(FullName,CurrDir);
 FileUnzip(W.Q,FullName,CurrDir,'*.*',ZipReport,NIL);
 DoneUnPack;
 ExtractZipHere:=True;
End;

Function FileMenuContext(Q:PFileManager;Const FullName:String;Const H:SearchRec;Var Refresh:Boolean):Byte;
Const
 fmCopy=$F001;
 fmRename=$F002;
 fmDelete=$F003;
 fmAttr=$F004;
 fmPrint=$F005;
 fmOpen=$F006;
 fmDescription=$F007;
 fmView=$F008;
 fmEdit=$F009;
 fmInfo=$F00A;
 fmConvBGX=$F00B;
 fmConvBMP=$F00C;
 fmConvClipboard=$F00D;
 fmConvPCX=$F00E;
 fmConvPPM=$F00F;
 fmConvSCi=$F010;
 fmConvXBM=$F011;
 fmCopyClipboard=$F012;
 fmConvWAV=$F013;
 fmMount=$F014;
 fmConvAdeleIcon=$F015;
 fmConvHTML=$F016;
 fmConvRTF=$F017;
 fmConvPremierChoix=$F018;
 fmViewHex=$F019;
 fmViewASCII=$F01A;
 fmC2Pas=$F01B;
 fmConvSQL=$F01C;
 fmConvGIF=$F01D;
 fmConvTextBin=$F01E;
 fmConvLotus=$F01F;
 fmPartitionManager=$F020;
 fmCopyDisk=$F021;
 fmAnalyserDir=$F022;
 fmWorkShop=$F023;
 fmSaveList=$F024;
 fmExtractHere=$F025;
 fmConvExcel=$F026;
 fmConvMGC=$F027;
 fmPrintList=$F028;
 fmConvHTMLType=$F029;
 fmExecMacro=$F02A;
Var
 K:Word;
 Res:ImageHeaderRes;
 Conv:Boolean;
 Buffer:Array[0..79]of Char;
 ZipSign:LongInt Absolute Buffer;
 Handle:Hdl;
 Img:XInf;
 Err:Word;
 PL:Record
  Play:Boolean;
  Exec:Boolean;
  Files:Boolean;
  ConvBitmap:Boolean;
  ConvDoc:Boolean;
  ConvSound:Boolean;
  ConvPascal:Boolean;
  ConvDataBase:Boolean;
  ConvFont:Boolean;
  ConvHTMLType:Boolean;
  IsZip:Boolean;
  Clipboard:Boolean;
  ClipboardImage:Boolean;
  MountVolume:Boolean;
  PartitionManager:Boolean;
  AnalyserDir:Boolean;
 End;
 Drv:Byte;
 Editor:EditorApp;           { Objet d'‚dition temporaire }
 Ext:ExtStr;                 { Extension du fichier }
 T:String;                   { Description }
 OkSel:Boolean;              { S'agit-il d'une s‚lection multiple? }
Begin
 FileMenuContext:=0;
 Refresh:=False;
 FillClr(PL,SizeOf(PL));
 Conv:=False;
 Ext:=Path2Ext(H.Name);
 PL.Play:=(Ext='.WAV')or(Ext='.VOC');
 PL.Exec:=(Ext='.EXE')or(Ext='.DLL');
 PL.Files:=H.Attr.Value and faDir=0;
 Handle:=FileOpen(FullName,fmRead);
 If(Handle<>errHdl)Then Begin
  _GetAbsRec(Handle,0,SizeOf(Buffer),Buffer);
  PL.IsZip:=ZipSign=$04034B50;
  PL.MountVolume:=IsMountDrive(Buffer);
  If(Not PL.Exec)Then PL.Exec:=IsGeoWorks(Buffer);
  If Not(PL.MountVolume)Then Begin
   If(Buffer[0]='T')and(Buffer[1]='D')Then PL.MountVolume:=True Else { Image TeleDisk? }
   If(Buffer[0]=#$AA)and(Buffer[1]=#$59)Then PL.MountVolume:=True { Image IBM OS/2 }
   Else PL.MountVolume:=(Ext='.144')or(Ext='.IMA')or(Ext='.IMG')or(Ext='.DSK');
  End
   Else
  PL.PartitionManager:=True;
  PL.ConvBitmap:=RIDefaultImage(Handle,Buffer)>0;
  If(PL.ConvBitmap)Then Conv:=True;
  FileClose(Handle);
 End;
 PL.ConvDoc:=Ext='.GAT';
  { Fichier sonore }
 PL.ConvSound:=Ext='.SND';
  { Fichier Pascal }
 PL.ConvPascal:=Pos(Path2Ext(H.Name),StrPas(ExtC))>0;
 If(PL.ConvPascal)Then PL.ConvBitmap:=False;
  { Fichier base de donn‚es }
 PL.ConvDataBase:=(Ext='.DAT')or(Ext='.DBF');
  { Fichier de police de caractŠres (.FNT) }
 PL.ConvFont:=Ext='.FNT';
 PL.ConvHTMLType:=(Ext='.ASM')or(Ext='.PAS');
  { Presse-papier }
 PL.Clipboard:=H.Attr.Value and faDir=0;
 PL.ClipboardImage:=Conv;
 PL.AnalyserDir:=H.Attr.Value and faDir<>0;
 K:=_RunMenuApp(26,PL);
 Case(K)of
  fmCopy:FileMenuContext:=6;
  fmRename:FileMenuContext:=7;
  fmDelete:FileMenuContext:=8;
  fmAttr:FileMenuContext:=9;
  fmPrint:FileMenuContext:=10;
  fmOpen:FileMenuContext:=1;
  fmView:FileMenuContext:=2;
  fmEdit:FileMenuContext:=3;
  fmDescription:FileMenuContext:=5;
  fmInfo:FileMenuContext:=4;
  fmCopyClipboard:FileMenuContext:=11;
  fmViewASCII:FileMenuContext:=2;
  fmViewHex:FileMenuContext:=12;
  fmC2Pas:C2Pascal(FullName);
  fmConvWav:Begin
   Snd2Wav(FullName,Path2NoExt(FullName)+'.WAV');
   Refresh:=True;
  End;
  fmConvSQL:Begin
   DBToSQL(FullName,Path2NoExt(FullName)+'.SQL');
   Refresh:=True;
  End;
  fmConvLotus:Begin
   DBToLotus(FullName,Path2NoExt(FullName)+'.WK1');
   Refresh:=True;
  End;
  fmConvExcel:Begin
   DBToExcel(FullName,Path2NoExt(FullName)+'.XLS');
   Refresh:=True;
  End;
  fmConvMGC:Begin
   DBToMGC(FullName,Path2NoExt(FullName)+'.MGC');
   Refresh:=True;
  End;
  fmConvHTML..fmConvPremierChoix:Begin
   TELoad2Save(Editor,FullName);
   Case(K)of
    fmConvHTML:Begin
     Editor.ModeSub:=vtsHTML;
     TESaveAs(Editor,Path2NoExt(FullName)+'.HTM');
    End;
    fmConvRTF:Begin
     Editor.ModeSub:=vtsRTF;
     TESaveAs(Editor,Path2NoExt(FullName)+'.RTF');
    End;
    fmConvPremierChoix:Begin
     Editor.ModeSub:=vtsFirstChoice;
     TESaveAs(Editor,Path2NoExt(FullName)+'.DOC');
    End;
   End;
   FileClose(Editor.Handle);
   Refresh:=True;
  End;
  fmConvBGX..fmConvXBM,fmConvAdeleIcon,fmConvGIF:Begin
   Err:=RILoadImage(FullName,diAutoDetect,0,$FFFF,rmAllRes,
                    [fpProgressBar,fpUserInterrupt],Img);
   If Err>0Then ErrMsgRes(Err)
    Else
   Begin
    Ext:='';
    OkSel:=(Q<>NIL)and(Q^.Panel[Q^.Plane].SelFiles>0);
    XGetAbsRec(Img,0,SizeOf(Res),Res);
    Case(K)of
     fmConvBGX:Begin
      Res.Original:=diBGX;
      If(OkSel)Then FileMenuContext:=20;
     End;
     fmConvBMP:Begin
      Res.Original:=diBitMapWindows;
      If(OkSel)Then FileMenuContext:=21;
     End;
     fmConvAdeleIcon:Begin
      Res.Original:=diIconAdele;
      If(OkSel)Then FileMenuContext:=22;
     End;
     fmConvGIF:Begin
      Res.Original:=diGIF;
      If(OkSel)Then FileMenuContext:=27;
     End;
     fmConvPCX:Begin
      Res.Original:=diPCX;
      If(OkSel)Then FileMenuContext:=23;
     End;
     fmConvPPM:Begin
      Res.Original:=diPPM;
      If(OkSel)Then FileMenuContext:=24;
     End;
     fmConvSCI:Begin
      Res.Original:=diSCi;
      If(OkSel)Then FileMenuContext:=25;
     End;
     fmConvXBM:Begin
      Res.Original:=diXBM;
      If(OkSel)Then FileMenuContext:=26;
     End;
    End;
    If(K=fmConvClipboard)Then RICopy2Clipboard(Img)
     Else
    Begin
     XSetAbsRec(Img,0,SizeOf(Res),Res);
     ErrMsgRes(RISaveImage(Path2NoExt(FullName),0,Img));
    End;
    XFreeMem(Img);
    Refresh:=True;
   End;
  End;
  fmMount:Begin
   Drv:=SelectNewDisk($FF);
   If Drv<>$FFThen Begin
    If Not MountVolume(FullName,Dsk2Drv(Drv))Then ErrNoMsgOk(errCantMountVolume);
    Refresh:=True;FileMenuContext:=199+Drv;
   End;
  End;
  fmPartitionManager:FileMenuContext:=13;
  fmCopyDisk:Begin
   Drv:=SelectDisk(1);
   If Drv<>$FFThen CopyFileToDisk(FullName,Pred(Drv));
  End;
  fmConvTextBin:Begin
   ConversionTextBin(FullName,Path2NoExt(FullName)+'.TXT');
   Refresh:=True;
  End;
  fmAnalyserDir:FMAnalyseDirectory(Q^,FullName);
  fmWorkShop:FileMenuContext:=30;
  fmSaveList:Begin
   T:=OpenWin('','Sauvegarde sous');
   If T<>''Then FMSaveListDirectory(Q^,T);
  End;
  fmExtractHere:Begin
   ExtractZipHere(Path2Dir(FullName),FullName);
   Refresh:=True;
  End;
  fmPrintList:FMPrnDir(Q^);
  fmConvHTMLType:Refresh:=PascalToHTML(FullName,Path2NoExt(FullName)+'.HTM');
  fmExecMacro:FMChoiceMacro(Q^);
 End;
End;

Procedure FMConvSelect(Var Q:FileManagerApp;Conv:Byte);
Var
 Err:Word;            { Code d'erreur de retour }
 FullName:String;     { Nom de l'image courante }
 Dir:String;          { Chemin du r‚pertoire courant }
 Img:XInf;            { Objet d'image }
 Res:ImageHeaderRes;  { Information d'entˆte de l'image }
 Info:SearchRec;      { Information sur le fichier courant }
 J:Integer;           { Compteur de boucle }
Begin
 If Q.Panel[Q.Plane].SelFiles>0Then Begin
  Dir:=SetPath4AddFile(Path2Dir(Q.Panel[Q.Plane].Path));
  For J:=0to BFMaxFiles(Q.Panel[Q.Plane].BF)do If Q.Panel[Q.Plane].Select^[J]Then Begin
   FMGetFile(Q,J,Info);
   FullName:=Dir+Info.Name;
   Err:=RILoadImage(FullName,diAutoDetect,0,$FFFF,rmAllRes,
                    [fpProgressBar,fpUserInterrupt],Img);
   If Err>0Then ErrMsgRes(Err)
    Else
   Begin
    XGetAbsRec(Img,0,SizeOf(Res),Res);
    Case(Conv)of
     20:Res.Original:=diBGX;
     21:Res.Original:=diBitMapWindows;
     22:Res.Original:=diIconAdele;
     23:Res.Original:=diPCX;
     24:Res.Original:=diPPM;
     25:Res.Original:=diSCi;
     26:Res.Original:=diXBM;
     27:Res.Original:=diGIF;
    End;
    XSetAbsRec(Img,0,SizeOf(Res),Res);
    ErrMsgRes(RISaveImage(Path2NoExt(FullName),0,Img));
    XFreeMem(Img);
   End;
  End;
 End;
End;

{$I \Source\Chantal\Library\Scan.Inc}
{$I \Source\Chantal\Library\IScan.Inc}
{$I \Source\Chantal\Library\XtrkWdIn.Inc}
{$I \Source\Chantal\Library\XtrkLong.Inc}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Fonction CountLn                           Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction retourne le nombre de retour de ligne situ‚ … l'int‚rieur
 d'une zone tampon sp‚cifi‚e.


 Entr‚e
 ÍÍÍÍÍÍ

  ®Buffer¯         Tampon dans lequel la recherche doit ˆtre effectu‚e
  ®Size¯           Taille du tampon de recherche


 Sortie
 ÍÍÍÍÍÍ

  ®LastOff¯        Position de la derniŠre ligne dans le tampon (Offset)
}

Function CountLn(Const Buffer;Size:Word;Var LastOff:Word):Word;Assembler;ASM
 {$IFDEF FLAT386}
 {$ELSE}
  LES DI,Buffer
  MOV CX,Size
  XOR DX,DX
  XOR BX,BX
  MOV AL,13
@1:
  SCASB
  JNZ @2
  INC DX
  MOV BX,DI
@2:
  DEC CX
  JNZ @1
  OR  BX,BX
  JZ  @3
  DEC BX
@3:
  LES DI,LastOff
  XCHG AX,BX
  STOSW
  XCHG AX,DX
 {$ENDIF}
END;

Procedure FMAnalyseDirectory(Var Q:FileManagerApp;Const FullDir:String);
Var
 W:Window;
 Option:Set of (
  Page,        { Compte le nombre de page dans les documents de format GAT }
  SubDirectory,{ Recherche dans les sous-r‚pertoires }
  MinMaj       { Sans distinction majuscule/minuscule }
 );
 Line:LongInt;    { Ligne de texte }
 J:Word;          { Compteur de recherche }
 Tranche:LongInt; { Position courante du pointeur de fichier }
 Handle:Hdl;      { Handle du fichier courant }
 NPage:LongInt;   { Nombre global de page }
 NmFiles:LongInt; { Nombre totale de fichiers balayer}
 NmBytes:LongInt; { Nombre totale d'octets pour les fichiers}
 OP,PX:Word;      { Position d'offset, position de recherche }
 Buffer:PChr;     { Tampon pour la recherche }
 SizeBuf,         { Taille du tampon de recherche }
 SizeBufX,        { Taille d'entˆte du tampon de recherche }
 XW1:Word;        { Marge gauche du document }
 YW1:Word;        { Marge sup‚rieur du document }
 XW2:Word;        { Marge droite du document }
 YW2:Word;        { Marge inf‚rieur du document }
 TW:Array[0..3]of {$IFDEF Real}PWord{$ELSE}PLong{$ENDIF};

 Procedure SearchDir(Const S:String);
 Label Cls;
 Var
  Descr:SearchRec;
  LPage,LN:LongInt;
  TL:Word;
 Begin
  FindFirst(Path2Dir(S)+'*.*',faAll,Descr);
  While SysErr=0do Begin
   If(Descr.Name<>'..')and(Descr.Name<>'.')Then Begin
    If WildCardMatch(Descr.Name,Path2NoDir(S))Then Begin
     Handle:=FileOpen(Path2Dir(S)+Descr.Name,fmRead);
     Tranche:=0;LN:=1;
     If(Handle<>errHdl)Then Begin
      Inc(NmFiles);Inc(NmBytes,Descr.Size);
      Begin
       __GetAbsFilePTxtLn(Handle,Tranche,Buffer,SizeBufX);
       TW[0]:=@XW1;TW[1]:=@YW1;TW[2]:=@XW2;TW[3]:=@YW2;
       {$IFDEF Real}
        J:=XtrkWdInStr(StrPas(Buffer),4,TW);
       {$ELSE}
        J:=XtrkLongInStr(StrPas(Buffer),4,TW);
       {$ENDIF}
       If J=0Then Begin;YW1:=6;YW2:=60;End;
       J:=0;Dec(YW2,YW1);LPage:=0;
       Repeat
        _GetAbsRec(Handle,Tranche,SizeBuf,Buffer^);
        TL:=CountLn(Buffer^,SizeBuf,OP);
        Inc(Line,LongInt(TL));
        Inc(LPage,LongInt(TL));
        Inc(Tranche,SizeBuf);
       Until Tranche>=Descr.Size;
       If(LPage>0)and(YW2>0)Then Begin
        J:=LPage mod YW2;
        LPage:=LPage div YW2;
        If J>0Then Inc(LPage);
       End
        Else
       Begin
        J:=LPage mod 54;
        LPage:=LPage div 54;
        If J>0Then Inc(LPage);
       End;
       Inc(NPage,LPage);
       WEPutTxtXY(W,33,1,StrUSpc(TruncName(Path2Dir(S)+Descr.Name,36),36));
      End;
  Cls:FileClose(Handle);
     End;
    End;
    If((SubDirectory)in(Option))and((sfaDir)in(Descr.Attr.Flags))Then Begin
     SearchDir(Path2Dir(S)+Descr.Name+'\'+Path2NoDir(S));
    End;
   End;
   FindNext(Descr);
   If(KeyPress)Then Exit;
  End;
 End;

Begin
 Option:=[Page,SubDirectory];
 NmFiles:=0;NmBytes:=0;NPage:=0;Line:=0;
 WEInitO(W,70,11);
 WEPushWn(W);
 WEPutWnKrDials(W,'Analyseur');
 WEBar(W);
 WEPutTxtXY(W,1,1,'Fichier courant:');
 WEPutTxtXY(W,1,2,'Nombre de page(s) globale:');
 WEPutTxtXY(W,1,3,'Nombre de ligne(s) globale:');
 WEPutTxtXY(W,1,4,'Nombre totale d''octets:');
 WEPutTxtXY(W,1,5,'Moyenne d''octets par fichiers:');
 WEPutTxtXY(W,1,6,'Moyenne de pages par fichiers:');
 If MaxAvail>65520Then SizeBuf:=65520 Else SizeBuf:=MaxAvail;
 Buffer:=MemAlloc(SizeBuf);
 If SizeBuf>256Then SizeBufX:=256 Else SizeBufX:=SizeBuf;
 If(Buffer=NIL)Then Begin
  __OutOfMemory;
  WEDone(W);
  Exit;
 End;
 SearchDir(FullDir+'\*.*');
 FreeMemory(Buffer,SizeBuf);
 WEPutTxtXY(W,33,2,CStr(NPage)+' contenu dans '+CStr(NmFiles)+' fichier(s)');
 WEPutTxtXY(W,33,3,CStr(Line));
 WEPutTxtXY(W,33,4,CStr(NmBytes));
 If(NmFiles>1)and(NmBytes>0)and(NPage>0)Then Begin
  WEPutTxtXY(W,33,5,CStr(DivLong(NmBytes,NmFiles)));
  WEPutTxtXY(W,33,6,CStr(DivLong(NPage,NmFiles)));
 End;
 WEPutTxtXY(W,1,1,'R‚pertoire courant:');
 WEPutTxtXY(W,33,1,StrUSpc(TruncName(FullDir,36),36));
 While WEOk(W)do;
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
END.