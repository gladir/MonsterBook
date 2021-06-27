Unit MALBKRES;

{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�}
                                  INTERFACE
{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�}

Uses Systex,Isatex;

Var
    FullDate:BOOLEAN;
    MtxNm:BYTE;
    Desktop:BOOLEAN;
    CurrModem:BYTE;
    SwapEms:BOOLEAN;
    NamePrimMonitor:PCHR;
    NamePrimCard:PCHR;
    PrnMarge:BOOLEAN;
    ModeTypeWriter:BOOLEAN;
    NameLPT4:PCHR;
    NameLPT3:PCHR;
    NameLPT2:PCHR;
    NameLPT1:PCHR;
    CurrPrn:PCHR;
    PathOutput:PCHR;
    PathUnit:PCHR;
    PathObject:PCHR;
    PathMacDrw:PCHR;
    PathMac:PCHR;
    PathAsmC:PCHR;
    PathCalc:PCHR;
    PathPCX:PCHR;
    PathDraw:PCHR;
    PathCatDisk:PCHR;
    PathPhoneList:PCHR;
    PathMod:PCHR;
    PathWin:PCHR;
    PathOS2:PCHR;
    PathUnix:PCHR;
    PathCountry:PCHR;
    FontInActifTitlePath:PCHR;
    FontTitlePath:PCHR;
    RegSerialCode:PCHR;
    BankRoutine:BYTE;

Procedure ReadIniFile;

{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�}
                               IMPLEMENTATION
{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�}

Uses Video,Systems,Dials,DialPlus,Terminal,Mouse,
Adele,Disk,dialex,pritex,Arcade,Editor,Protocol,Sourcer,MBCortex,ToolTerm,ResServI,CommBase;

Procedure ReadIniFile;
Const MsgChoice='Presse une touche pour continuer sans le fichier MB.INI ou <ESC> pour quitter.';
Var Handle:Hdl; SI,Str,Ext,Header:String; PChr:Array[Byte]of Char; FS,S:Long; Category:Byte;

 Function ExtractAfterEqualI(Str:String):String;Var P:Byte;Begin
  _DelAllSpcRight(Str);
  P:=Pos('=',Str);
  While(Str[P]<>'"')do Inc(P);
  If P=0Then ExtractAfterEqualI:=''Else ExtractAfterEqualI:=Copy(Str,P,255);
 End;

 Function ExtractAfterEqual(Str:String):String;Var P:Byte;Begin
  P:=Pos('=',Str);
  If P=0Then ExtractAfterEqual:=''Else ExtractAfterEqual:=Copy(Str,P+1,255);
 End;

 Function IsTrue(Str:String):Bool;Begin
  IsTrue:=(Str='YES')or(Str='TRUE')or(Str='ON');
 End;

 Function IsFalse(Str:String):Bool;Begin
  IsFalse:=(Str='NO')or(Str='FALSE')or(Str='OFF');
 End;

 Function ICmpLeft(Const Str,Cmp:String):Bool;Begin
  If Str[Length(Cmp)+1]<'@'Then ICmpLeft:=CmpLeft(Str,Cmp)
                             Else ICmpLeft:=No;
 End;

Begin
 Category:=0;FS:=0;Handle:=FileOpen('MB.INI',fmRead);
 If(Handle=errHdl)Then Begin
  Handle:=FileOpen(MaltePath+'MB.INI',fmRead);
 End;
 If(Handle=errHdl)Then Exit;
 S:=FileSize(Handle);
 __GetAbsFileTxtLn(Handle,FS,SI);
 While(FS<S)do Begin
  Str:=DelChr(StrUp(SI),' ');
  If Not((Str='')or(Str[1]='/'))Then
  Begin
   If(Str[1]='[')Then Begin
    If Str[Length(Str)]<>']'Then Begin
     WriteLn('Erreur MB.INI: '']'' attendue.');
     WriteLn(MsgChoice);
     If(ReadKey=kbEsc)Then Halt;
     Exit;
    End;
    Header:=Copy(Str,2,Length(Str)-2);
    If Header='USER'Then Category:=1 Else
    If Header='DISK'Then Category:=2 Else
    If Header='PRINTERS'Then Category:=3 Else
    If Header='SOUND'Then Category:=4 Else
    If Header='VIDEO'Then Category:=5 Else
    If Header='SYSTEMS'Then Category:=6 Else
    If Header='MODEM'Then Category:=7
     Else
    Break;
   End
    Else
   Case Category of
    1 : Begin
         If ICmpLeft(Str,'USERNAME')Then Begin
          Ext:=ExtractAfterEqualI(SI);
          If(Ext[1]='"')And(Ext[Length(Ext)]='"')Then Begin
           RegUserName:=Str2PChr(Copy(Ext,2,Length(Ext)-2));
          End;
         End;
         If ICmpLeft(Str,'SERIALCODE')Then Begin
          Ext:=ExtractAfterEqual(Str);
          If(Ext[1]='"')And(Ext[Length(Ext)]='"')Then Begin
           RegSerialCode:=Str2PChr(Copy(Ext,2,Length(Ext)-2));
          End;
         End;
         If ICmpLeft(Str,'MASTERPASSWORD')Then Begin
          Ext:=ExtractAfterEqual(Str);
          If(Ext[1]='"')And(Ext[Length(Ext)]='"')Then Begin
           MasterPassWord:=Str2PChr(Copy(Ext,2,Length(Ext)-2));
          End;
         End;
         If ICmpLeft(Str,'COUNTRYCODE')Then Begin
          Ext:=ExtractAfterEqual(Str);
          MalteCountryCode:=StrToWord(Ext);
         End;
         If ICmpLeft(Str,'COUNTRYICONONSTATUS')Then Begin
          Ext:=ExtractAfterEqual(Str);
          If IsTrue(Ext)Then CountryIconOnStatus:=True Else
          If IsFalse(Ext)Then CountryIconOnStatus:=False
                         Else Break;
         End;
        End;
    2 : Begin
         If ICmpLeft(Str,'CDROM')Then Begin
          Ext:=ExtractAfterEqual(Str);
          DefaultCDROMPort:=StrToWord(Ext);
         End;
         If ICmpLeft(Str,'ASMFILES')Then Begin
          Ext:=ExtractAfterEqual(Str);
          If(Ext[1]='"')And(Ext[Length(Ext)]='"')Then Begin
           ExtAsm:=Str2PChr(Copy(Ext,2,Length(Ext)-2));
          End;
         End;
         If ICmpLeft(Str,'ASMCFILES')Then Begin
          Ext:=ExtractAfterEqual(Str);
          If(Ext[1]='"')And(Ext[Length(Ext)]='"')Then Begin
           ExtAC:=Str2PChr(Copy(Ext,2,Length(Ext)-2));
          End;
         End;
         If ICmpLeft(Str,'BASFILES')Then Begin
          Ext:=ExtractAfterEqual(Str);
          If(Ext[1]='"')And(Ext[Length(Ext)]='"')Then Begin
           ExtBas:=Str2PChr(Copy(Ext,2,Length(Ext)-2));
          End;
         End;
         If ICmpLeft(Str,'CFILES')Then Begin
          Ext:=ExtractAfterEqual(Str);
          If(Ext[1]='"')And(Ext[Length(Ext)]='"')Then Begin
           ExtC:=Str2PChr(Copy(Ext,2,Length(Ext)-2));
          End;
         End;
         If ICmpLeft(Str,'EUPHFILES')Then Begin
          Ext:=ExtractAfterEqual(Str);
          If(Ext[1]='"')And(Ext[Length(Ext)]='"')Then Begin
           ExtEuphoria:=Str2PChr(Copy(Ext,2,Length(Ext)-2));
          End;
         End;
         If ICmpLeft(Str,'FORFILES')Then Begin
          Ext:=ExtractAfterEqual(Str);
          If(Ext[1]='"')And(Ext[Length(Ext)]='"')Then Begin
           ExtFortran:=Str2PChr(Copy(Ext,2,Length(Ext)-2));
          End;
         End;
         If ICmpLeft(Str,'INIFILES')Then Begin
          Ext:=ExtractAfterEqual(Str);
          If(Ext[1]='"')And(Ext[Length(Ext)]='"')Then Begin
           ExtIni:=Str2PChr(Copy(Ext,2,Length(Ext)-2));
          End;
         End;
         If ICmpLeft(Str,'MOUSEMENUFILES')Then Begin
          Ext:=ExtractAfterEqualI(SI);
          If(Ext[1]='"')And(Ext[Length(Ext)]='"')Then Begin
           ExtMsMnu:=Str2PChr(Copy(Ext,2,Length(Ext)-2));
          End;
         End;
         If ICmpLeft(Str,'PASFILES')Then Begin
          Ext:=ExtractAfterEqual(Str);
          If(Ext[1]='"')And(Ext[Length(Ext)]='"')Then Begin
           ExtPas:=Str2PChr(Copy(Ext,2,Length(Ext)-2));
          End;
         End;
         If ICmpLeft(Str,'RESOURCEFILES')Then Begin
          Ext:=ExtractAfterEqual(Str);
          If(Ext[1]='"')And(Ext[Length(Ext)]='"')Then Begin
           ExtRC:=Str2PChr(Copy(Ext,2,Length(Ext)-2));
          End;
         End;
         If ICmpLeft(Str,'DIRSYSTEMS')Then Begin
          Ext:=ExtractAfterEqual(Str);
          If(Ext[1]='"')And(Ext[Length(Ext)]='"')Then Begin
           PathSystems:=Str2PChr(Copy(Ext,2,Length(Ext)-2));
          End;
         End;
         If ICmpLeft(Str,'DIRCOUNTRY')Then Begin
          Ext:=ExtractAfterEqual(Str);
          If(Ext[1]='"')And(Ext[Length(Ext)]='"')Then Begin
           PathCountry:=Str2PChr(Copy(Ext,2,Length(Ext)-2));
          End;
         End;
         If ICmpLeft(Str,'DIRUNIX')Then Begin
          Ext:=ExtractAfterEqual(Str);
          If(Ext[1]='"')And(Ext[Length(Ext)]='"')Then Begin
           PathUnix:=Str2PChr(Copy(Ext,2,Length(Ext)-2));
          End;
         End;
         If ICmpLeft(Str,'DIROS2')Then Begin
          Ext:=ExtractAfterEqual(Str);
          If(Ext[1]='"')And(Ext[Length(Ext)]='"')Then Begin
           PathOS2:=Str2PChr(Copy(Ext,2,Length(Ext)-2));
          End;
         End;
         If ICmpLeft(Str,'DIRWINDOWS')Then Begin
          Ext:=ExtractAfterEqual(Str);
          If(Ext[1]='"')And(Ext[Length(Ext)]='"')Then Begin
           PathWin:=Str2PChr(Copy(Ext,2,Length(Ext)-2));
          End;
         End;
         If ICmpLeft(Str,'DIRMUSICMOD')Then Begin
          Ext:=ExtractAfterEqual(Str);
          If(Ext[1]='"')And(Ext[Length(Ext)]='"')Then Begin
           PathMod:=Str2PChr(Copy(Ext,2,Length(Ext)-2));
          End;
         End;
         If ICmpLeft(Str,'DIRBBS')Then Begin
          Ext:=ExtractAfterEqual(Str);
          If(Ext[1]='"')And(Ext[Length(Ext)]='"')Then Begin
           PathBBS:=Str2PChr(Copy(Ext,2,Length(Ext)-2));
          End;
         End;
         If ICmpLeft(Str,'DIRPHONELIST')Then Begin
          Ext:=ExtractAfterEqual(Str);
          If(Ext[1]='"')And(Ext[Length(Ext)]='"')Then Begin
           PathPhoneList:=Str2PChr(Copy(Ext,2,Length(Ext)-2));
          End;
         End;
         If ICmpLeft(Str,'DIRPHONEDOWNLOAD')Then Begin
          Ext:=ExtractAfterEqual(Str);
          If(Ext[1]='"')And(Ext[Length(Ext)]='"')Then Begin
           PathDownload:=Str2PChr(Copy(Ext,2,Length(Ext)-2));
          End;
         End;
         If ICmpLeft(Str,'DIRPHONEUPLOAD')Then Begin
          Ext:=ExtractAfterEqual(Str);
          If(Ext[1]='"')And(Ext[Length(Ext)]='"')Then Begin
           PathUpload:=Str2PChr(Copy(Ext,2,Length(Ext)-2));
          End;
         End;
         If ICmpLeft(Str,'DIRCATALOGDISK')Then Begin
          Ext:=ExtractAfterEqual(Str);
          If(Ext[1]='"')And(Ext[Length(Ext)]='"')Then Begin
           PathCatDisk:=Str2PChr(Copy(Ext,2,Length(Ext)-2));
          End;
         End;
         If ICmpLeft(Str,'DIRDRAW')Then Begin
          Ext:=ExtractAfterEqual(Str);
          If(Ext[1]='"')And(Ext[Length(Ext)]='"')Then Begin
           PathDraw:=Str2PChr(Copy(Ext,2,Length(Ext)-2));
          End;
         End;
         If ICmpLeft(Str,'DIRPCX')Then Begin
          Ext:=ExtractAfterEqual(Str);
          If(Ext[1]='"')And(Ext[Length(Ext)]='"')Then Begin
           PathPCX:=Str2PChr(Copy(Ext,2,Length(Ext)-2));
          End;
         End;
         If ICmpLeft(Str,'DIRSUPERCALC')Then Begin
          Ext:=ExtractAfterEqual(Str);
          If(Ext[1]='"')And(Ext[Length(Ext)]='"')Then Begin
           PathCalc:=Str2PChr(Copy(Ext,2,Length(Ext)-2));
          End;
         End;
         If ICmpLeft(Str,'DIRGAT')Then Begin
          Ext:=ExtractAfterEqual(Str);
          If(Ext[1]='"')And(Ext[Length(Ext)]='"')Then Begin
           PathGat:=Str2PChr(Copy(Ext,2,Length(Ext)-2));
          End;
         End;
         If ICmpLeft(Str,'DIRMACROTXT')Then Begin
          Ext:=ExtractAfterEqual(Str);
          If(Ext[1]='"')And(Ext[Length(Ext)]='"')Then Begin
           PathMac:=Str2PChr(Copy(Ext,2,Length(Ext)-2));
          End;
         End;
         If ICmpLeft(Str,'DIRMACRODRW')Then Begin
          Ext:=ExtractAfterEqual(Str);
          If(Ext[1]='"')And(Ext[Length(Ext)]='"')Then Begin
           PathMacDrw:=Str2PChr(Copy(Ext,2,Length(Ext)-2));
          End;
         End;
         If ICmpLeft(Str,'DIRSOURCEADA')Then Begin
          Ext:=ExtractAfterEqual(Str);
          If(Ext[1]='"')And(Ext[Length(Ext)]='"')Then Begin
           PathAda:=Str2PChr(Copy(Ext,2,Length(Ext)-2));
          End;
         End;
         If ICmpLeft(Str,'DIRSOURCEASM')Then Begin
          Ext:=ExtractAfterEqual(Str);
          If(Ext[1]='"')And(Ext[Length(Ext)]='"')Then Begin
           PathAsm:=Str2PChr(Copy(Ext,2,Length(Ext)-2));
          End;
         End;
         If ICmpLeft(Str,'DIRSOURCEASMC')Then Begin
          Ext:=ExtractAfterEqual(Str);
          If(Ext[1]='"')And(Ext[Length(Ext)]='"')Then Begin
           PathAsmC:=Str2PChr(Copy(Ext,2,Length(Ext)-2));
          End;
         End;
         If ICmpLeft(Str,'DIRSOURCEBAS')Then Begin
          Ext:=ExtractAfterEqual(Str);
          If(Ext[1]='"')And(Ext[Length(Ext)]='"')Then Begin
           PathBas:=Str2PChr(Copy(Ext,2,Length(Ext)-2));
          End;
         End;
         If ICmpLeft(Str,'DIRSOURCEC')Then Begin
          Ext:=ExtractAfterEqual(Str);
          If(Ext[1]='"')And(Ext[Length(Ext)]='"')Then Begin
           PathC:=Str2PChr(Copy(Ext,2,Length(Ext)-2));
          End;
         End;
         If ICmpLeft(Str,'DIRSOURCECOBOL')Then Begin
          Ext:=ExtractAfterEqual(Str);
          If(Ext[1]='"')And(Ext[Length(Ext)]='"')Then Begin
           PathCobol:=Str2PChr(Copy(Ext,2,Length(Ext)-2));
          End;
         End;
         If ICmpLeft(Str,'DIRSOURCEEUPHORIA')Then Begin
          Ext:=ExtractAfterEqual(Str);
          If(Ext[1]='"')And(Ext[Length(Ext)]='"')Then Begin
           PathEuphoria:=Str2PChr(Copy(Ext,2,Length(Ext)-2));
          End;
         End;
         If ICmpLeft(Str,'DIRSOURCEFORTH')Then Begin
          Ext:=ExtractAfterEqual(Str);
          If(Ext[1]='"')And(Ext[Length(Ext)]='"')Then Begin
           PathForth:=Str2PChr(Copy(Ext,2,Length(Ext)-2));
          End;
         End;
         If ICmpLeft(Str,'DIRSOURCEFORTRAN')Then Begin
          Ext:=ExtractAfterEqual(Str);
          If(Ext[1]='"')And(Ext[Length(Ext)]='"')Then Begin
           PathFortran:=Str2PChr(Copy(Ext,2,Length(Ext)-2));
          End;
         End;
         If ICmpLeft(Str,'DIRSOURCEPAS')Then Begin
          Ext:=ExtractAfterEqual(Str);
          If(Ext[1]='"')And(Ext[Length(Ext)]='"')Then Begin
           PathPas:=Str2PChr(Copy(Ext,2,Length(Ext)-2));
          End;
         End;
         If ICmpLeft(Str,'DIRRESOURCE')Then Begin
          Ext:=ExtractAfterEqual(Str);
          If(Ext[1]='"')And(Ext[Length(Ext)]='"')Then Begin
           PathResource:=Str2PChr(Copy(Ext,2,Length(Ext)-2));
          End;
         End;
         If ICmpLeft(Str,'DIROBJECT')Then Begin
          Ext:=ExtractAfterEqual(Str);
          If(Ext[1]='"')And(Ext[Length(Ext)]='"')Then Begin
           PathObject:=Str2PChr(Copy(Ext,2,Length(Ext)-2));
          End;
         End;
         If ICmpLeft(Str,'DIRUNIT')Then Begin
          Ext:=ExtractAfterEqual(Str);
          If(Ext[1]='"')And(Ext[Length(Ext)]='"')Then Begin
           PathUnit:=Str2PChr(Copy(Ext,2,Length(Ext)-2));
          End;
         End;
         If ICmpLeft(Str,'DIROUTPUT')Then Begin
          Ext:=ExtractAfterEqual(Str);
          If(Ext[1]='"')And(Ext[Length(Ext)]='"')Then Begin
           PathOutput:=Str2PChr(Copy(Ext,2,Length(Ext)-2));
          End;
         End;
        End;
    3 : Begin
         If ICmpLeft(Str,'CURRPRN')Then Begin
          Ext:=ExtractAfterEqual(Str);
          PrnOutput:=StrToWord(Ext);
         End;
         If ICmpLeft(Str,'CURRPRINTER')Then Begin
          Ext:=ExtractAfterEqual(Str);
          If(Ext[1]='"')And(Ext[Length(Ext)]='"')Then Begin
           CurrPrn:=Str2PChr(Copy(Ext,2,Length(Ext)-2));
          End;
         End;
         If ICmpLeft(Str,'NAMELPT1')Then Begin
          Ext:=ExtractAfterEqual(Str);
          If(Ext[1]='"')And(Ext[Length(Ext)]='"')Then Begin
           NameLPT1:=Str2PChr(Copy(Ext,2,Length(Ext)-2));
          End;
         End;
         If ICmpLeft(Str,'NMMODELLPT1DOS')Then Begin
          Ext:=ExtractAfterEqual(Str);
          PrnSetup[poLPT1Dos].Code:=StrToWord(Ext);
         End;
         If ICmpLeft(Str,'NMMODELLPT2DOS')Then Begin
          Ext:=ExtractAfterEqual(Str);
          PrnSetup[poLPT2Dos].Code:=StrToWord(Ext);
         End;
         If ICmpLeft(Str,'NMMODELLPT3DOS')Then Begin
          Ext:=ExtractAfterEqual(Str);
          PrnSetup[poLPT3Dos].Code:=StrToWord(Ext);
         End;
         If ICmpLeft(Str,'NMMODELLPT4DOS')Then Begin
          Ext:=ExtractAfterEqual(Str);
          PrnSetup[poLPT4Dos].Code:=StrToWord(Ext);
         End;
         If ICmpLeft(Str,'NMMODELLPT1')Then Begin
          Ext:=ExtractAfterEqual(Str);
          PrnSetup[poLPT1].Code:=StrToWord(Ext);
         End;
         If ICmpLeft(Str,'NMMODELLPT2')Then Begin
          Ext:=ExtractAfterEqual(Str);
          PrnSetup[poLPT2].Code:=StrToWord(Ext);
         End;
         If ICmpLeft(Str,'NMMODELLPT3')Then Begin
          Ext:=ExtractAfterEqual(Str);
          PrnSetup[poLPT3].Code:=StrToWord(Ext);
         End;
         If ICmpLeft(Str,'NMMODELLPT4')Then Begin
          Ext:=ExtractAfterEqual(Str);
          PrnSetup[poLPT4].Code:=StrToWord(Ext);
         End;
         If ICmpLeft(Str,'NMMODELFILE')Then Begin
          Ext:=ExtractAfterEqual(Str);
          PrnSetup[poFile].Code:=StrToWord(Ext);
         End;
         If ICmpLeft(Str,'HEIGHTPAPERLPT1')Then Begin
          Ext:=ExtractAfterEqual(Str);
          PrnSetup[poLPT1].PHeight:=StrToWord(Ext);
         End;
         If ICmpLeft(Str,'NAMELPT2')Then Begin
          Ext:=ExtractAfterEqual(Str);
          If(Ext[1]='"')And(Ext[Length(Ext)]='"')Then Begin
           NameLPT2:=Str2PChr(Copy(Ext,2,Length(Ext)-2));
          End;
         End;
         If ICmpLeft(Str,'NAMELPT3')Then Begin
          Ext:=ExtractAfterEqual(Str);
          If(Ext[1]='"')And(Ext[Length(Ext)]='"')Then Begin
           NameLPT3:=Str2PChr(Copy(Ext,2,Length(Ext)-2));
          End;
         End;
         If ICmpLeft(Str,'NAMELPT4')Then Begin
          Ext:=ExtractAfterEqual(Str);
          If(Ext[1]='"')And(Ext[Length(Ext)]='"')Then Begin
           NameLPT4:=Str2PChr(Copy(Ext,2,Length(Ext)-2));
          End;
         End;
         If ICmpLeft(Str,'MODETYPEWRITER')Then Begin
          Ext:=ExtractAfterEqual(Str);
          If IsTrue(Ext)Then ModeTypeWriter:=True Else
          If IsFalse(Ext)Then ModeTypeWriter:=False
                         Else Break;
         End;
         If ICmpLeft(Str,'PRNMARGEAUTORISED')Then Begin
          Ext:=ExtractAfterEqual(Str);
          If IsTrue(Ext)Then PrnMarge:=True Else
          If IsFalse(Ext)Then PrnMarge:=False
                         Else Break;
         End;
         If ICmpLeft(Str,'PAPER2PAPER')Then Begin
          Ext:=ExtractAfterEqual(Str);
          If IsTrue(Ext)Then PrnSetup[poLPT1].P2P:=True Else
          If IsFalse(Ext)Then PrnSetup[poLPT1].P2P:=False
                         Else Break;
         End;
         If ICmpLeft(Str,'BORDERPIXEL')Then Begin
          Ext:=ExtractAfterEqual(Str);
          If IsTrue(Ext)Then PrnSetup[poLPT1].BorderPixel:=True Else
          If IsFalse(Ext)Then PrnSetup[poLPT1].BorderPixel:=False
                         Else Break;
         End;
        End;
    4 : Begin
         If ICmpLeft(Str,'STARTUP')Then Begin
          Ext:=ExtractAfterEqual(Str);
          If(Ext[1]='"')And(Ext[Length(Ext)]='"')Then Begin
           SoundPlay[sndStartUp]:=Str2PChr(Copy(Ext,2,Length(Ext)-2));
          End;
         End;
         If ICmpLeft(Str,'ERROR')Then Begin
          Ext:=ExtractAfterEqual(Str);
          If(Ext[1]='"')And(Ext[Length(Ext)]='"')Then Begin
           SoundPlay[sndError]:=Str2PChr(Copy(Ext,2,Length(Ext)-2));
          End;
         End;
         If ICmpLeft(Str,'WARNING')Then Begin
          Ext:=ExtractAfterEqual(Str);
          If(Ext[1]='"')And(Ext[Length(Ext)]='"')Then Begin
           SoundPlay[sndWarning]:=Str2PChr(Copy(Ext,2,Length(Ext)-2));
          End;
         End;
         If ICmpLeft(Str,'INFO')Then Begin
          Ext:=ExtractAfterEqual(Str);
          If(Ext[1]='"')And(Ext[Length(Ext)]='"')Then Begin
           SoundPlay[sndInfo]:=Str2PChr(Copy(Ext,2,Length(Ext)-2));
          End;
         End;
         If ICmpLeft(Str,'OPENWIN')Then Begin
          Ext:=ExtractAfterEqual(Str);
          If(Ext[1]='"')And(Ext[Length(Ext)]='"')Then Begin
           SoundPlay[sndOpenWin]:=Str2PChr(Copy(Ext,2,Length(Ext)-2));
          End;
         End;
         If ICmpLeft(Str,'CLOSEWIN')Then Begin
          Ext:=ExtractAfterEqual(Str);
          If(Ext[1]='"')And(Ext[Length(Ext)]='"')Then Begin
           SoundPlay[sndCloseWin]:=Str2PChr(Copy(Ext,2,Length(Ext)-2));
          End;
         End;
         If ICmpLeft(Str,'EXIT')Then Begin
          Ext:=ExtractAfterEqual(Str);
          If(Ext[1]='"')And(Ext[Length(Ext)]='"')Then Begin
           SoundPlay[sndExit]:=Str2PChr(Copy(Ext,2,Length(Ext)-2));
          End;
         End;
         If ICmpLeft(Str,'SOUNDICONONSTATUS')Then Begin
          Ext:=ExtractAfterEqual(Str);
          If IsTrue(Ext)Then SoundIconOnStatus:=True Else
          If IsFalse(Ext)Then SoundIconOnStatus:=False
                         Else Break;
         End;
        End;
    5 : Begin
         If ICmpLeft(Str,'CHECKSVGA')Then Begin
          Ext:=ExtractAfterEqual(Str);
          If IsTrue(Ext)Then CheckSvga:=True Else
          If IsFalse(Ext)Then CheckSvga:=False
                         Else Break;
         End;
         If ICmpLeft(Str,'NAMEPRIMCARD')Then Begin
          Ext:=ExtractAfterEqual(Str);
          If(Ext[1]='"')And(Ext[Length(Ext)]='"')Then Begin
           NamePrimCard:=Str2PChr(Copy(Ext,2,Length(Ext)-2));
          End;
         End;
         If ICmpLeft(Str,'NAMEPRIMONITOR')Then Begin
          Ext:=ExtractAfterEqual(Str);
          If(Ext[1]='"')And(Ext[Length(Ext)]='"')Then Begin
           NamePrimMonitor:=Str2PChr(Copy(Ext,2,Length(Ext)-2));
          End;
         End;
         If ICmpLeft(Str,'DEFAULTMODE')Then Begin
          Ext:=ExtractAfterEqual(Str);
          DefaultMode:=StrToWord(Ext);
         End;
         If ICmpLeft(Str,'MTXNM')Then Begin
          Ext:=ExtractAfterEqual(Str);
          MtxNm:=StrToWord(Ext);
         End;
         If ICmpLeft(Str,'FULLDATE')Then Begin
          Ext:=ExtractAfterEqual(Str);
          If IsTrue(Ext)Then FullDate:=True Else
          If IsFalse(Ext)Then FullDate:=False
                         Else Break;
         End;
         If ICmpLeft(Str,'CURRPALETTE')Then Begin
          Ext:=ExtractAfterEqual(Str);
          CurrPalette:=StrToWord(Ext);
         End;
         If ICmpLeft(Str,'PAPIERPEINT')Then Begin
          Ext:=ExtractAfterEqual(Str);
          If(Ext[1]='"')And(Ext[Length(Ext)]='"')Then Begin
           FontAppPath:=Str2PChr(Copy(Ext,2,Length(Ext)-2));
          End;
         End;
         If ICmpLeft(Str,'STYLEPAPIERPEINT')Then Begin
          Ext:=ExtractAfterEqual(Str);
          WallPaperConfig:=StrToWord(Ext);
         End;
         If ICmpLeft(Str,'FONTTITLE')Then Begin
          Ext:=ExtractAfterEqual(Str);
          If(Ext[1]='"')And(Ext[Length(Ext)]='"')Then Begin
           FontTitlePath:=Str2PChr(Copy(Ext,2,Length(Ext)-2));
          End;
         End;
         If ICmpLeft(Str,'FONTINACTIFTITLE')Then Begin
          Ext:=ExtractAfterEqual(Str);
          If(Ext[1]='"')And(Ext[Length(Ext)]='"')Then Begin
           FontInActifTitlePath:=Str2PChr(Copy(Ext,2,Length(Ext)-2));
          End;
         End;
         If ICmpLeft(Str,'VESABIOSBANK')Then Begin
          Ext:=ExtractAfterEqual(Str);
          If IsTrue(Ext)Then VesaBiosBank:=True Else
          If IsFalse(Ext)Then VesaBiosBank:=False
                         Else Break;
         End;
         If ICmpLeft(Str,'IMAGEINDIALOG')Then Begin
          Ext:=ExtractAfterEqual(Str);
          If IsTrue(Ext)Then MediaSupport:=True Else
          If IsFalse(Ext)Then MediaSupport:=False
                         Else Break;
         End;
         If ICmpLeft(Str,'EXTENSIOR')Then Begin
          Ext:=ExtractAfterEqual(Str);
          If IsTrue(Ext)Then UseExtensior:=True Else
          If IsFalse(Ext)Then UseExtensior:=False
                         Else Break;
         End;
         If ICmpLeft(Str,'CADRILLAGE')Then Begin
          Ext:=ExtractAfterEqual(Str);
          If IsTrue(Ext)Then Cadril:=True Else
          If IsFalse(Ext)Then Cadril:=False
                         Else Break;
         End;
         If ICmpLeft(Str,'BANKROUTINE')Then Begin
          Ext:=ExtractAfterEqual(Str);
          BankRoutine:=StrToWord(Ext);
         End;
         If ICmpLeft(Str,'MEMORYMODEL')Then Begin
          Ext:=ExtractAfterEqual(Str);
          MemoryModel:=StrToWord(Ext);
         End;
         If ICmpLeft(Str,'VIEWTOOLBAR')Then Begin
          Ext:=ExtractAfterEqual(Str);
          If IsTrue(Ext)Then ViewToolBar:=True Else
          If IsFalse(Ext)Then ViewToolBar:=False
                         Else Break;
         End;
         If ICmpLeft(Str,'HELPBAR')Then Begin
          Ext:=ExtractAfterEqual(Str);
          If IsTrue(Ext)Then HelpBar:=True Else
          If IsFalse(Ext)Then HelpBar:=False
                         Else Break;
         End;
         If ICmpLeft(Str,'DESKTOPICONONSTARTMODE')Then Begin
          Ext:=ExtractAfterEqual(Str);
          If IsTrue(Ext)Then DesktopIconOnStartMode:=True Else
          If IsFalse(Ext)Then DesktopIconOnStartMode:=False
                         Else Break;
         End;
         If ICmpLeft(Str,'FX')Then Begin
          Ext:=ExtractAfterEqual(Str);
          If IsTrue(Ext)Then FX:=True Else
          If IsFalse(Ext)Then FX:=False
                         Else Break;
         End;
        End;
    6 : Begin
         If ICmpLeft(Str,'KEYWAIT')Then Begin
          Ext:=ExtractAfterEqual(Str);
          KeyWait:=StrToWord(Ext);
         End;
         If ICmpLeft(Str,'OVREMS')Then Begin
          Ext:=ExtractAfterEqual(Str);
          If IsTrue(Ext)Then SwapEms:=True Else
          If IsFalse(Ext)Then SwapEms:=False
                         Else Break;
         End;
         If ICmpLeft(Str,'SWAPEMS')Then Begin
          Ext:=ExtractAfterEqual(Str);
          If IsTrue(Ext)Then NoEms:=True Else
          If IsFalse(Ext)Then NoEms:=False
                         Else Break;
         End;
         If ICmpLeft(Str,'DESCRINFILE')Then Begin
          Ext:=ExtractAfterEqual(Str);
          If IsTrue(Ext)Then DescrInFile:=True Else
          If IsFalse(Ext)Then DescrInFile:=False
                         Else Break;
         End;
         If ICmpLeft(Str,'LOG')Then Begin
          Ext:=ExtractAfterEqual(Str);
          If IsTrue(Ext)Then Log:=True Else
          If IsFalse(Ext)Then Log:=False
                         Else Break;
         End;
         If ICmpLeft(Str,'SCRSAVER')Then Begin
          Ext:=ExtractAfterEqual(Str);
          If IsTrue(Ext)Then ActifScrSave:=True Else
          If IsFalse(Ext)Then ActifScrSave:=False
                         Else Break;
         End;
         If ICmpLeft(Str,'SCRTIME')Then Begin
          Ext:=ExtractAfterEqual(Str);
          SecSS:=StrToWord(Ext);
         End;
         If ICmpLeft(Str,'SCRSAVERMODEL')Then Begin
          Ext:=ExtractAfterEqual(Str);
          CurrScrnSaver:=StrToWord(Ext);
         End;
         If ICmpLeft(Str,'DIRECTDOS')Then Begin
          Ext:=ExtractAfterEqual(Str);
          If IsTrue(Ext)Then DirectDos:=True Else
          If IsFalse(Ext)Then DirectDos:=False
                         Else Break;
         End;
         If ICmpLeft(Str,'MOUSETXTGRF')Then Begin
          Ext:=ExtractAfterEqual(Str);
          If IsTrue(Ext)Then MsTxtGrf:=True Else
          If IsFalse(Ext)Then MsTxtGrf:=False
                         Else Break;
         End;
         If ICmpLeft(Str,'DESKTOP')Then Begin
          Ext:=ExtractAfterEqual(Str);
          If IsTrue(Ext)Then Desktop:=True Else
          If IsFalse(Ext)Then Desktop:=False
                         Else Break;
         End;
         If ICmpLeft(Str,'MARKEND')Then Begin
          Ext:=ExtractAfterEqual(Str);
          If IsTrue(Ext)Then MarkEnd:=True Else
          If IsFalse(Ext)Then MarkEnd:=False
                         Else Break;
         End;
         If ICmpLeft(Str,'RULES')Then Begin
          Ext:=ExtractAfterEqual(Str);
          If IsTrue(Ext)Then Rules:=True Else
          If IsFalse(Ext)Then Rules:=False
                         Else Break;
         End;
         If ICmpLeft(Str,'VIEWOUTZONE')Then Begin
          Ext:=ExtractAfterEqual(Str);
          If IsTrue(Ext)Then ViewOutZone:=True Else
          If IsFalse(Ext)Then ViewOutZone:=False
                         Else Break;
         End;
         If ICmpLeft(Str,'MAKEBAK')Then Begin
          Ext:=ExtractAfterEqual(Str);
          If IsTrue(Ext)Then MakeBak:=True Else
          If IsFalse(Ext)Then MakeBak:=False
                         Else Break;
         End;
         If ICmpLeft(Str,'SOURCER')Then Begin
          Ext:=ExtractAfterEqual(Str);
          OpCodeFormat:=StrToWord(Ext);
         End;
         If ICmpLeft(Str,'OPCODE')Then Begin
          Ext:=ExtractAfterEqual(Str);
          OpCodeCPU:=StrToWord(Ext);
         End;
        End;
    7 : Begin
         If ICmpLeft(Str,'CURRMODEM')Then Begin
          Ext:=ExtractAfterEqual(Str);
          CurrModem:=StrToWord(Ext);
         End;
         If ICmpLeft(Str,'BAUDRATE')Then Begin
          Ext:=ExtractAfterEqual(Str);
          BaudRate:=StrToWord(Ext);
         End;
         If ICmpLeft(Str,'MODEMCMDDELAY')Then Begin
          Ext:=ExtractAfterEqual(Str);
          ModemCmdDelay:=StrToWord(Ext);
         End;
         If ICmpLeft(Str,'BUSY')Then Begin
          Ext:=ExtractAfterEqual(Str);
          If(Ext[1]='"')And(Ext[Length(Ext)]='"')Then Begin
           ModemBusy:=Str2PChr(Copy(Ext,2,Length(Ext)-2));
          End;
         End;
         If ICmpLeft(Str,'CONNECT')Then Begin
          Ext:=ExtractAfterEqual(Str);
          If(Ext[1]='"')And(Ext[Length(Ext)]='"')Then Begin
           ModemConnect:=Str2PChr(Copy(Ext,2,Length(Ext)-2));
          End;
         End;
         If ICmpLeft(Str,'NOCARRIER')Then Begin
          Ext:=ExtractAfterEqual(Str);
          If(Ext[1]='"')And(Ext[Length(Ext)]='"')Then Begin
           ModemNoCarrier:=Str2PChr(Copy(Ext,2,Length(Ext)-2));
          End;
         End;
        End;
   End;
  End;
  __GetAbsFileTxtLn(Handle,FS,SI);
 End;
 FileClose(Handle);
End;

{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�}
END.
