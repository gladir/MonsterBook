{Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Ce programme permet de coder en n'importe quel langage de programmation
 sans avoir recours … des instruments de compilation externe. Il comprend
 donc des compilateurs Pascal, Basic, C, Algol, Euphoria, Assembleur, ...
 ainsi qu'un d‚bogueur.
}

Program OverCode;
{$M 32768,0,655360}
{$I DEF.INC}
Uses {$IFDEF Adele}Adele,{$ELSE}Chantal,{$ENDIF}Isatex,
     Systex,Systems,Video,Mouse,Dials,DialPlus,
     Editor,EdtLoad,EdtDone,EdtExtra,ResTex,ResLoadI,ResServI,
     Pas2Lam,Project,OVLibrary,Apps;

Var I:Byte;Path:String;
    IconFolder:XInf;

BEGIN
 InitSystems(suIsabel);
 PathDskSwp:=FileExpand('OVERCODE.$$$');
 InitMemManagers;
 If IsPChrEmpty(ExtAC)Then ExtAC:=Str2PChr('*.AC');
 If IsPChrEmpty(ExtAsm)Then ExtAsm:=Str2PChr('*.ASM;*.ASO;*.MAC;*.INC');
 If IsPChrEmpty(ExtBas)Then ExtBas:=Str2PChr('*.BAS;*.FRM');
 If IsPChrEmpty(ExtC)Then ExtC:=Str2PChr('*.C;*.CAS;*.CC;*.CPP;*.H;*.HPP');
 If IsPChrEmpty(ExtEuphoria)Then ExtEuphoria:=Str2PChr('*.E;*.EX');
 If IsPChrEmpty(ExtFortran)Then ExtFortran:=Str2PChr('*.FOR;*.F77');
 If IsPChrEmpty(ExtIni)Then ExtIni:=Str2PChr('*.INI');
 If IsPChrEmpty(ExtMsMnu)Then ExtMsMnu:=Str2PChr('*.MNU;*.DEF');
 If IsPChrEmpty(ExtPas)Then ExtPas:=Str2PChr('*.PAS;*.INC;*.DPR');
 If IsPChrEmpty(ExtRC)Then ExtRC:=Str2PChr('*.RC;*.RES');
 SetVideoModeDeluxe({vmTxtDef}vmGrf640x480c65536);
 RILoadImage(MaltePath+'ICON\FOLDER.ICO',
             diAutoDetect,0,$FFFF,rmAllResSteady,[],IconFolder);
 FolderIcon:=@IconFolder;
 __InitMouse;
 MakeMnu;
 AppInit('®OverCode¯',$4C,MtxOS2Win95);
 BarSpcHor(0,MaxYTxts-1,MaxXTxts,$7F);
 BarSpcHor(0,MaxYTxts,MaxXTxts,$1F);
 BarSpcHorRelief(0,MaxYTxts-1,MaxXTxts,$7F);
 HInit(Windows);
 For I:=0to 1do HAddNewModel(Windows,LstHWin[I]);
 Repeat
  Case HRun(Windows)of
   kbF3,ocOpen:Begin
    Path:=OpenWin('*.*','Ouvre un fichier');
    If Path<>''Then HLoad(Windows,snEdt,Path);
    ResetMenu;
   End;
   kbLoad:LoadCurrFile;
   kbAltX,ocExit,kbPrgClsIcon:Begin
    WaitMsBut0;
    Break;
   End;
   kbAltF3,kbClose,ocWindowClose:Begin
    HClose(Windows);
    ResetMenu;
   End;
   kbAlt0,ocWindowList:Begin
    HGotoWin(Windows);
    ResetMenu;
   End;
   kbF6,ocWindowNext:Begin
    HNext(Windows);
    ResetMenu;
   End;
   kbShiftF6,ocWindowPrevious:Begin
    HPrevious(Windows);
    ResetMenu;
   End;
   ocNewPrj:Begin
    HNew(Windows,snPrj);
    ResetMenu;
   End;
   ocPrjTitle:Begin
    If(HModel(Windows)=snPrj)Then SetTitleProject;
   End;
   ocPrjComposant:Begin
    If(HModel(Windows)=snPrj)Then NewComposantProject;
   End;
   ocOpenProject:Begin
    OpenProject;
    ResetMenu;
   End;
   ocSaveProject:HSave(Windows);
   ocSaveAsProject:HSaveAs(Windows);
  End;
 Until No;
 HSaveAll(Windows);
 HDone(Windows);
 DoneLuxeVideo;
 DoneMemManagers;
END.