{$I DEF.INC}

Procedure SaveIni;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                               IMPLEMENTATION
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses
 Adele,Disk,Systex,dialex,pritex,Systems,Video,Mouse,Arcade,
 DialPlus,Dials,Editex,
 {$IFDEF FullVersion}
  MBCortex,
 {$ENDIF}
 {$IFDEF BureauVersion}
  MBBCrtex,
 {$ENDIF}
 {$IFDEF Reseau}
  Protocol,
  CommBase,
 {$ENDIF}
 {$IFDEF Developpeur}
  Sourcer,
 {$ENDIF}
 ToolTerm,ResServI,SysInter;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Proc‚dure SaveIni                            Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure  cr‚er  un fichier  de configuration  de style ®GeoWorks¯,
 ®GemDesktop¯ ou ®Windows¯ que le MonsterBook utiliser pour sa configuration
 personnel.  Il s'agit d'un  vulgaire fichier  ASCII ‚tant cr‚er  afin qu'un
 utilisateur puisse l'‚diter avec un traitement de texte si n‚cessaire.
}

Procedure SaveIni;
Var
 Handle:Hdl;

 Procedure PutFileTxtLn(Const S:String);Begin
  Systems.PutFileTxtLn(Handle,S)
 End;

 Procedure YN(Const S:String;X:Boolean);Begin
  PutFileTxt(Handle,S);
  If(X)Then PutFileTxtLn('Yes')
       Else PutFileTxtLn('No')
 End;

 Procedure Wd(Const S:String;X:Word);Begin
  PutFileTxtLn(S+WordToStr(X))
 End;

 Procedure Str(Const S:String;P:PChr);Begin
  PutFileTxtLn(S+'="'+StrPas(P)+'"');
 End;

Begin
 Handle:=FileCreateAndBackup(MaltePath+MB_INI);
 If(RegUserName<>NIL)Then Begin
  PutFileTxtLn('[User]');
  PutFileLn(Handle);
  PutFileTxtLn('UserName="'+StrPas(RegUserName)+'"');
  PutFileTxtLn('SerialCode="'+StrPas(RegSerialCode)+'"');
  If Not IsPChrEmpty(MasterPassWord)Then Str('MasterPassWord',MasterPassWord);
  If MalteCountryCode<>0Then Wd('CountryCode=',MalteCountryCode);
  YN('CountryIconOnStatus=',CountryIconOnStatus);
  PutFileLn(Handle);
 End;
 PutFileTxtLn('[Disk]');
 PutFileLn(Handle);
 Wd('CDROM=',DefaultCDROMPort);
 If IsPChrEmpty(ExtAsm)Then PutFileTxtLn('AsmFiles="*.ASM;*.ASO;*.MAC;*.INC"')
 Else Str('AsmFiles',ExtAsm);
 If IsPChrEmpty(ExtBas)Then PutFileTxtLn('BasFiles="*.BAS;*.FRM"')
 Else Str('BasFiles',ExtBas);
 If IsPChrEmpty(ExtC)Then PutFileTxtLn('CFiles="*.C;*.CAS;*.CC;*.CPP;*.H;*.HPP"')
 Else Str('CFiles',ExtC);
 If IsPChrEmpty(ExtEuphoria)Then PutFileTxtLn('EuphFiles="*.E;*.EX"')
 Else Str('EuphFiles',ExtEuphoria);
 If IsPChrEmpty(ExtFortran)Then PutFileTxtLn('ForFiles="*.FOR;*.F77"')
 Else Str('ForFiles',ExtFortran);
 If IsPChrEmpty(ExtIni)Then PutFileTxtLn('IniFiles="*.INI"')
 Else Str('IniFiles',ExtIni);
 If IsPChrEmpty(ExtMsMnu)Then PutFileTxtLn('MouseMenuFiles="*.MNU;*.DEF"')
 Else Str('MouseMenuFiles',ExtMsMnu);
 If IsPChrEmpty(ExtPas)Then PutFileTxtLn('PasFiles="*.PAS;*.INC;*.DPR"')
 Else Str('PasFiles',ExtPas);
 If IsPChrEmpty(ExtRC)Then PutFileTxtLn('ResourceFiles="*.RC;*.RES"')
 Else Str('ResourceFiles',ExtRC);
 If IsPChrEmpty(PathSystems)Then Begin
  If DirExist('\MALTE\SYSTEMS')Then PutFileTxtLn('DirSystems="\MALTE\SYSTEMS"')Else
  If DirExist('\MALTE')Then PutFileTxtLn('DirSystems="\MALTE"')
  Else Str('DirSystems',NIL);
 End
 Else Str('DirSystems',PathSystems);
 If IsPChrEmpty(PathCountry)Then Begin
  If DirExist('\MALTE\COUNTRY')Then PutFileTxtLn('DirCountry="\MALTE\COUNTRY"')Else
  If DirExist('\MALTE')Then PutFileTxtLn('DirCountry="\MALTE"')
  Else Str('DirCountry',NIL);
 End
 Else Str('DirCountry',PathCountry);
 Str('DirOS2',PathOS2);
 If IsPChrEmpty(PathUnix)Then PutFileTxtLn('DirUnix="\MALTE\UNIX"')
 Else Str('DirUnix',PathUnix);
 If IsPChrEmpty(PathWin)Then PutFileTxtLn('DirWindows="\WINDOWS"')
 Else Str('DirWindows',PathWin);
 If IsPChrEmpty(PathBBS)Then PutFileTxtLn('DirBBS="\MALTE\BBS"')
 Else Str('DirBBS',PathBBS);
 Str('DirMusicMod',PathMod);
 If IsPChrEmpty(PathPhoneList)Then PutFileTxtLn('DirPhoneList="\TELEMATE"')
 Else Str('DirPhoneList',PathPhoneList);
 {$IFDEF Reseau}
  If IsPChrEmpty(PathDownload)Then PutFileTxtLn('DirPhoneDownload="\DOWNLOAD"')
  Else Str('DirPhoneDownload',PathDownload);
  If IsPChrEmpty(PathUpLoad)Then PutFileTxtLn('DirPhoneUpLoad="\UPLOAD"')
  Else Str('DirPhoneUpLoad',PathUpload);
 {$ENDIF}
 If IsPChrEmpty(PathCatDisk)Then PutFileTxtLn('DirCatalogDisk="\MALTE\CATALOG"')
 Else Str('DirCatalogDisk',PathCatDisk);
 Str('DirDraw',PathDraw);
 Str('DirPCX',PathPCX);
 If IsPChrEmpty(PathCalc)Then PutFileTxtLn('DirSuperCalc="\MALTE\CALC"')
 Else Str('DirSuperCalc',PathCalc);
 If IsPChrEmpty(PathGat)Then PutFileTxtLn('DirGat="\MALTE\TEXT"')
 Else Str('DirGat',PathGat);
 If IsPChrEmpty(PathMac)Then PutFileTxtLn('DirMacroTxt="\MALTE\MACTXT"')
 Else Str('DirMacroTxt',PathMac);
 If IsPChrEmpty(PathMacDrw)Then PutFileTxtLn('DirMacroDrw="\MALTE\MACDRW"')
 Else Str('DirMacroDrw',PathMacDrw);
 Str('DirSourceADA',PathAda);
 Str('DirSourceASMC',PathAsmC);
 Str('DirSourceASM',PathAsm);
 Str('DirSourceBAS',PathBas);
 Str('DirSourceCobol',PathCobol);
 Str('DirSourceC',PathC);
 Str('DirSourceEuphoria',PathEuphoria);
 Str('DirSourceForth',PathForth);
 Str('DirSourceFortran',PathFortran);
 Str('DirSourcePAS',PathPas);
 Str('DirResource',PathResource);
 Str('DirObject',PathObject);
 Str('DirUnit',PathUnit);
 Str('DirOutput',PathOutput);
 PutFileLn(Handle);
 PutFileTxtLn('[Printers]');
 PutFileLn(Handle);
 Wd('CurrPrn=',PrnOutput);
 Wd('NmModelLPT1=',PrnSetup[poLPT1].Code);
 Wd('NmModelLPT2=',PrnSetup[poLPT2].Code);
 Wd('NmModelLPT3=',PrnSetup[poLPT3].Code);
 Wd('NmModelLPT4=',PrnSetup[poLPT4].Code);
 Wd('NmModelLPT1Dos=',PrnSetup[poLPT1Dos].Code);
 Wd('NmModelLPT2Dos=',PrnSetup[poLPT2Dos].Code);
 Wd('NmModelLPT3Dos=',PrnSetup[poLPT3Dos].Code);
 Wd('NmModelLPT4Dos=',PrnSetup[poLPT4Dos].Code);
 Wd('NmModelFile=',PrnSetup[poFile].Code);
 Wd('HeightPaperLPT1=',PrnSetup[poLPT1].PHeight);
 PutFileTxt(Handle,'ModeTypeWriter=');
 If(ModeTypeWriter)Then PutFileTxtLn('On')Else PutFileTxtLn('Off');
 PutFileTxt(Handle,'PrnMargeAutorised=');
 If(PrnMarge)Then PutFileTxtLn('On')Else PutFileTxtLn('Off');
 YN('Paper2Paper=',PrnSetup[PrnOutput].P2P);
 YN('BorderPixel=',PrnSetup[PrnOutput].BorderPixel);
 PutFileLn(Handle);
 PutFileTxtLn('[Sound]');
 Str('StartUp',SoundPlay[sndStartUp]);
 Str('Error',SoundPlay[sndError]);
 Str('Warning',SoundPlay[sndWarning]);
 Str('Info',SoundPlay[sndInfo]);
 Str('OpenWin',SoundPlay[sndOpenWin]);
 Str('CloseWin',SoundPlay[sndCloseWin]);
 Str('Exit',SoundPlay[sndExit]);
 YN('SoundIconOnStatus=',SoundIconOnStatus);
 PutFileLn(Handle);
 PutFileTxtLn('[Video]');
 PutFileLn(Handle);
 YN('CheckSVGA=',CheckSvga);
 Str('NamePrimCard',NamePrimCard);
 Str('NamePrimMonitor',NamePrimMonitor);
 Wd('DefaultMode=',DefaultMode);
 Wd('MtxNm=',MtxNm);
 YN('FullDate=',FullDate);
 Wd('CurrPalette=',CurrPalette);
 Str('PapierPeint',FontAppPath);
 Wd('StylePapierPeint=',WallPaperConfig);
 Str('FontTitle',FontTitlePath);
 Str('FontInActifTitle',FontInActifTitlePath);
 YN('VesaBiosBank=',VesaBiosBank);
 YN('ImageInDialog=',MediaSupport);
 YN('Extensior=',UseExtensior);
 YN('Cadrillage=',Cadril);
 Wd('BankRoutine=',BankRoutine);
 Wd('MemoryModel=',MemoryModel);
 YN('ViewToolBar=',ViewToolBar);
 YN('HelpBar=',HelpBar);
 YN('DesktopIconOnStartMode=',DesktopIconOnStartMode);
 YN('FX=',FX);
 PutFileLn(Handle);
 PutFileTxtLn('[Systems]');
 PutFileLn(Handle);
 If KeyWait<>$FFThen Wd('KeyWait=',KeyWait);
 YN('OvrEms=',SwapEms);
 YN('SwapEms=',NoEMS);
 YN('DescrInFile=',DescrInFile);
 YN('ScrSaver=',ActifScrSave);
 Wd('ScrTime=',SecSS);
 Wd('ScrSaverModel=',CurrScrnSaver);
 YN('DirectDos=',DirectDos);
 YN('MouseTxtGrf=',MouseTxtGrf);
 YN('Log=',Log);
 YN('Desktop=',Desktop);
 YN('MarkEnd=',MarkEnd);
 YN('Rules=',Rules);
 YN('ViewOutZone=',ViewOutZone);
 YN('MakeBak=',MakeBak);
 {$IFDEF Developpeur}
  Wd('Sourcer=',OpCodeFormat);
  Wd('OpCode=',OpCodeCPU);
 {$ENDIF}
 PutFileLn(Handle);
 PutFileTxtLn('[Modem]');
 PutFileLn(Handle);
 Wd('CurrModem=',CurrModem);
 {$IFDEF Reseau}
  Wd('BaudRate=',BaudRate);
  If IsPChrEmpty(ModemBusy)Then PutFileTxtLn('Busy="Occup‚"')
  Else Str('Busy',ModemBusy);
  If IsPChrEmpty(ModemConnect)Then PutFileTxtLn('Connect="Connect‚"')
  Else Str('Connect',ModemConnect);
  If IsPChrEmpty(ModemNoCarrier)Then PutFileTxtLn('NoCarrier="Ligne coup‚"')
  Else Str('NoCarrier',ModemNoCarrier);
  Wd('ModemCmdDelay=',ModemCmdDelay);
 {$ENDIF}
 FileClose(Handle);
 WriteLog('Change la configuration');
End;
