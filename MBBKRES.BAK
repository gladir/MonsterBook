Unit MBBKRES;

{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�}
                                  INTERFACE
{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�}

Uses Systex,Isatex;

Procedure ReadIniFile;

{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�}
                               IMPLEMENTATION
{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�}

Uses Video,Systems,Dials,DialPlus,Terminal,Mouse,
Adele,Disk,dialex,pritex,Arcade,Editex,Protocol,Sourcer,MBCortex,ToolTerm,ResServI,CommBase;

Function GetVideoModeBySize(Grf,Length,Height:Word):Word;Begin
 GetVideoModeBySize:=vmNone;
 Case(Grf)of
  24:Case(Length)of
   640:Case(Length)of
    480:GetVideoModeBySize:=vmGrf640x480c16M;
   End;
  End;
  16:Case(Length)of
   320:Case(Height)of
    200:GetVideoModeBySize:=vmGrf320x200c65536;
   End;
   640:Case(Height)of
    480:GetVideoModeBySize:=vmGrf640x480c65536;
   End;
   800:Case(Height)of
    600:GetVideoModeBySize:=vmGrf800x600c65536;
   End;
  End;
  15:Case(Length)of
   320:Case(Height)of
    200:GetVideoModeBySize:=vmGrf320x200c32768;
   End;
   640:Case(Height)of
    350:GetVideoModeBySize:=vmGrf640x350c32768;
    400:GetVideoModeBySize:=vmGrf640x400c32768;
    480:GetVideoModeBySize:=vmGrf640x480c32768;
   End;
   800:Case(Height)of
    600:GetVideoModeBySize:=vmGrf800x600c32768;
   End;
   1024:Case(Height)of
    768:GetVideoModeBySize:=vmGrf1024x768c32768;
   End;
  End;
  8:Case(Length)of
   320:Case(Height)of
    200:GetVideoModeBySize:=vmGrf320x200c256;
    240:GetVideoModeBySize:=vmGrf320x240c256;
    400:GetVideoModeBySize:=vmGrf320x400c256;
    480:GetVideoModeBySize:=vmGrf320x480c256;
   End;
   360:Case(Height)of
    240:GetVideoModeBySize:=vmGrf360x240c256;
    360:GetVideoModeBySize:=vmGrf360x360c256;
    400:GetVideoModeBySize:=vmGrf360x400c256;
    480:GetVideoModeBySize:=vmGrf360x480c256;
   End;
   376:Case(Height)of
    308:GetVideoModeBySize:=vmGrf376x308c256;
    564:GetVideoModeBySize:=vmGrf376x564c256;
   End;
   512:Case(Height)of
    512:GetVideoModeBySize:=vmGrf512x512c256;
   End;
   640:Case(Height)of
    350:GetVideoModeBySize:=vmGrf640x350c256;
    400:GetVideoModeBySize:=vmGrf640x400c256;
    480:GetVideoModeBySize:=vmGrf640x480c256;
   End;
   720:Case(Height)of
    512:GetVideoModeBySize:=vmGrf720x512c256;
    540:GetVideoModeBySize:=vmGrf720x540c256;
   End;
   800:Case(Height)of
    600:GetVideoModeBySize:=vmGrf800x600c256;
   End;
   1024:Case(Height)of
    768:GetVideoModeBySize:=vmGrf1024x768c256;
   End;
   1280:Case(Height)of
    1024:GetVideoModeBySize:=vmGrf1280x1024c256;
   End;
  End;
  4:Case(Length)of
   320:Case(Height)of
    200:GetVideoModeBySize:=vmGrf320x200c16;
   End;
   512:Case(Height)of
    512:GetVideoModeBySize:=vmGrf512x512c16;
   End;
   640:Case(Height)of
    200:GetVideoModeBySize:=vmGrf640x200c16;
    350:GetVideoModeBySize:=vmGrf640x350c16;
    400:GetVideoModeBySize:=vmGrf640x400c16;
    462:GetVideoModeBySize:=vmGrf640x462c16;
    480:GetVideoModeBySize:=vmGrf640x480c16;
   End;
   720:Case(Height)of
    392:GetVideoModeBySize:=vmGrf720x392c16;
    512:GetVideoModeBySize:=vmGrf720x512c16;
    540:GetVideoModeBySize:=vmGrf720x540c16;
   End;
   752:Case(Height)of
    410:GetVideoModeBySize:=vmGrf752x410c16;
   End;
   768:Case(Height)of
    1024:GetVideoModeBySize:=vmGrf768x1024c16;
   End;
   800:Case(Height)of
    560:GetVideoModeBySize:=vmGrf800x560c16;
    600:GetVideoModeBySize:=vmGrf800x600c16;
   End;
   960:Case(Height)of
    720:GetVideoModeBySize:=vmGrf960x720c16;
   End;
   1024:Case(Height)of
    768:GetVideoModeBySize:=vmGrf1024x768c16;
   End;
   1280:Case(Height)of
    1024:GetVideoModeBySize:=vmGrf1280x1024c16;
   End;
  End;
  2:Case(Length)of
   320:Case(Height)of
    200:GetVideoModeBySize:=vmGrf320x200c4;
   End;
   640:Case(Height)of
    400:GetVideoModeBySize:=vmGrf640x200c4;
   End;
   1024:Case(Height)of
    768:GetVideoModeBySize:=vmGrf1024x768c4;
   End;
  End;
  1:Case(Length)of
   240:Case(Height)of
    128:GetVideoModeBySize:=vmGrf240x128c2;
   End;
   640:Case(Height)of
    200:GetVideoModeBySize:=vmGrf640x200c2;
    350:GetVideoModeBySize:=vmGrf640x350c2;
    400:GetVideoModeBySize:=vmGrf640x400c2;
    480:GetVideoModeBySize:=vmGrf640x480c2;
   End;
   720:Case(Height)of
    348:GetVideoModeBySize:=vmHerc;
    350:GetVideoModeBySize:=vmGrf720x350c2;
   End;
   800:Case(Height)of
    600:GetVideoModeBySize:=vmGrf800x600c2;
   End;
   1024:Case(Height)of
    768:GetVideoModeBySize:=vmGrf1024x768c2;
   End;
  End;
  Else Case(Length)of
   40:Case(Height)of
    25:GetVideoModeBySize:=vmTxtC40;
    28:GetVideoModeBySize:=vmTxtC40x28;
    43:GetVideoModeBySize:=vmTxtC40x43;
    50:GetVideoModeBySize:=vmTxtC40x50;
    Else GetVideoModeBySize:=vmTxtC40;
   End;
   80:Case(Height)of
    28:GetVideoModeBySize:=vmTxtC80x28;
    30:GetVideoModeBySize:=vmTxtC80x30;
    33:GetVideoModeBySize:=vmTxtC80x33;
    34:GetVideoModeBySize:=vmTxtC80x34;
    43:GetVideoModeBySize:=vmTxtC80x43;
    50:GetVideoModeBySize:=vmTxtC80x50;
    60:GetVideoModeBySize:=vmTxtC80x60;
    66:GetVideoModeBySize:=vmTxtC80x66;
    Else GetVideoModeBySize:=vmTxtC80;
   End;
   100:Case(Height)of
    30:GetVideoModeBySize:=vmTxtC100x30;
    37:GetVideoModeBySize:=vmTxtC100x37;
    40:GetVideoModeBySize:=vmTxtC100x40;
    50:GetVideoModeBySize:=vmTxtC100x50;
    60:GetVideoModeBySize:=vmTxtC100x60;
    75:GetVideoModeBySize:=vmTxtC100x75;
    Else GetVideoModeBySize:=vmTxtC100x37;
   End;
   120:Case(Height)of
    25:GetVideoModeBySize:=vmTxtC120x25;
    43:GetVideoModeBySize:=vmTxtC120x43;
    Else GetVideoModeBySize:=vmTxtC120x25;
   End;
   132:Case(Height)of
    28:GetVideoModeBySize:=vmTxtC132x28;
    43:GetVideoModeBySize:=vmTxtC132x43;
    44:GetVideoModeBySize:=vmTxtC132x44;
    50:GetVideoModeBySize:=vmTxtC132x50;
    60:GetVideoModeBySize:=vmTxtC132x60;
    100:GetVideoModeBySize:=vmTxtC132x100;
    Else GetVideoModeBySize:=vmTxtC132;
   End;
   160:Case(Height)of
    50:GetVideoModeBySize:=vmTxtC160x50;
    Else GetVideoModeBySize:=vmTxtC160x50;
   End;
  End;
 End;
End;

Function FinderVideoMode(Const Ext:String):Word;
Var
 I:Byte;
 CmdX,CmdY:Word;
 CmdBPP:Byte;
Begin
 If(Pos(',',Ext)>0)or(Pos('X',Ext)>0)Then Begin
  I:=1;
  CmdX:=StrToWord(XtrkDecNm(I,Ext));
  CmdY:=0;
  CmdBPP:=0;
  If StrI(I,Ext)in[',','X']Then Begin
   Inc(I);
   CmdY:=StrToWord(XtrkDecNm(I,Ext));
   If StrI(I,Ext)in[',','X']Then Begin
    Inc(I);
    CmdBPP:=StrToWord(XtrkDecNm(I,Ext));
    If CmdBPP=256Then CmdBPP:=8;
   End;
  End;
  FinderVideoMode:=GetVideoModeBySize(CmdBPP,CmdX,CmdY);
 End
  Else
 FinderVideoMode:=StrToWord(Ext);
End;

Procedure ReadIniFile;
Const MsgChoice='Presse une touche pour continuer sans le fichier MB.INI ou <ESC> pour quitter.';
Var
 Handle:Hdl;
 SI,Str,Ext,Header:String;
 PChr:Array[Byte]of Char;
 FS,S:Long;
 Category:Byte;

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
          DefaultMode:=FinderVideoMode(ExtractAfterEqual(Str));
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
          If IsTrue(Ext)Then MouseTxtGrf:=True Else
          If IsFalse(Ext)Then MouseTxtGrf:=False
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
