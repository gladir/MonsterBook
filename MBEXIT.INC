{$DEFINE ShareWare}
{$I DEF.INC}

Uses
 Systex;

Procedure SmallXit(X:Boolean);
Function  Xit:Boolean;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                               IMPLEMENTATION
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses
 Adele,Memories,Systems,Video,Mouse,Arcade,Dialex,Dials,Tools,Isatex,
 {$IFDEF FullVersion}
  MBCortex,
  MalLibra,
  MalEnv,
  MBBoot,
 {$ENDIF}
 {$IFDEF BureauVersion}
  MBBCrtex,
  MalBLibr,
  MalBEnv,
  MBBBoot,
 {$ENDIF}
 ToolTerm,SysPlus,
 ResServD;

Procedure SmallXit;Begin
 UninstallRebootManager;
 __DoneMouse;
 DoneSpooler;
 If(X)Then DoneLuxeVideo;
 PopScr(Output);
 {$IFDEF Int8Dh}
  DoneDials;
 {$ENDIF}
 DoneTools;
 DBDone(ChantalServer);
 DoneMemManagers;
 DoneSystems;
 {$IFNDEF NotReal}
  DoneExtendHeap;
 {$ENDIF}
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Fonction Xit                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction effectue toutes les op‚rations de terminaisons, de
 restitution  vid‚o,  de desktop  et de  fermeture  des fenˆtres si
 l'utilisateur ne l'interrompt pas.
}

Function Xit;
Var
 Handle:Hdl;
 I,Size:Word;
 TW:^WindowApp;
 S,PathDesktop:String;
 PStr:^String;
Begin
 Xit:=No;
 {Sauvegarde le Desktop}
 If(Desktop)Then Begin
  PathDesktop:=MaltePath+'MB.DSK';
   { Recherche une demande de desktop particulier...}
  For I:=1to(ParamCount)do Begin
   S:=ParamStr(I);
   If S[1]in['/','-']Then S:=Copy(S,2,255);
   If CmpLeft(S,'DSK:')Then Begin
    PathDesktop:=Copy(S,5,255);
    Break;
   End;
  End;
   { Cr‚ation du desktop }
  If StrUp(PathDesktop)<>'NONE'Then Begin
   If Windows.Lst.Count=0Then DeleteFile(PathDesktop) { Pas fenˆtre donc pas desktop...}
    Else
   Begin
    Handle:=FileCreate(PathDesktop);
    If(Handle=errHdl)Then ErrNoMsgOk(CantCreateDesktop)
     Else
    Begin
     For I:=0to Windows.Lst.Count-1do Begin
{      TW:=RBGetBuf(_Windows,I,Size);}
      TW:=ALGetBuf(Windows.Lst,I,Size);
      If(TW=NIL)Then Break;
      Case(TW^.Model)of
       0:Break;
       wnAgenda:PutFileTxtLn(Handle,'AP:');
       wnEdit:PutFileTxtLn(Handle,'ED:'+TW^.P.Edit.EditName+' '+
			   WordToStr(TW^.P.Edit.PX)+','+WordToStr(TW^.P.Edit.P));
       wnView:PutFileTxtLn(Handle,'VW:'+TW^.P.ViewAscii.FileName);
       wnIcon:PutFileTxtLn(Handle,'IC:'+TW^.P.IcnEdt.Name);
       wnDraw:PutFileTxtLn(Handle,'DW:'+TW^.P.DrawEdit.FileName);
       wnSuperCalc:PutFileTxtLn(Handle,'CE:'+TW^.P.Lotus.FileName);
       wnFileManager:If(TW^.P.FM.Explorer)Then
        PutFileTxtLn(Handle,'FM:EXPLORER')
       Else
        PutFileTxtLn(Handle,'FM:'+TW^.P.FM.Panel[0].Path+','+TW^.P.FM.Panel[1].Path);
       wnPrmpt:PutFileTxtLn(Handle,'PR:');
       wnTerm:PutFileTxtLn(Handle,'TE:');
       wnPC:PutFileTxtLn(Handle,'PC:');
       wnCalculator:PutFileTxtLn(Handle,'CA:');
       wnCalendar:PutFileTxtLn(Handle,'CL:'+Str0(TW^.P.Calendar.Month,2)+
                                 ','+IntToStr(TW^.P.Calendar.Year));
       wnHexView:PutFileTxtLn(Handle,'HV:'+TW^.P.HexVw.ViewName);
       wnUnix:PutFileTxtLn(Handle,'UN:');
       wnMnu:PutFileTxtLn(Handle,'MA:');
       wnDataBase:PutFileTxtLn(Handle,'BD:'+TW^.P.DataBase.DataBase.FileName);
       wnFont:PutFileTxtLn(Handle,'FE:'+TW^.P.Font.FileName);
       wnProgMan:Begin
        If(TW^.P.ProgMan.Mode=mWin9X)Then PutFileTxtLn(Handle,'PM:D')Else
        If Pos('PROGMAN',TW^.P.ProgMan.Path)=0Then
         PutFileTxtLn(Handle,'PM:'+TW^.P.ProgMan.Path)
        Else
         PutFileTxtLn(Handle,'PM:');
       End;
       wnTetris:PutFileTxtLn(Handle,'TS:');
       wnCDPlayer:PutFileTxtLn(Handle,'CD:');
       wnTechDraw:PutFileTxtLn(Handle,'TD:'+TW^.P.TechDraw.FileName);
       wnLogo:PutFileTxtLn(Handle,'LG:'+TW^.P.Logo.Source.EditName);
      End;
     End;
     FileClose(Handle);
    End;
   End;
  End;
 End;
 {D‚branche tous les joujoux...}
 If Not RunFunc(cmdCloseAllExit)Then Begin
  Exit;
 End;
 RunFunc(cmdStopPlayMod);
 PStr:=Ptr(PrefixSeg,$80);
 If(Pos('NOPRESENTATION',PStr^)=0)and(FX)Then FadeOut;
 WriteLog('Quitte le '+NamePrg);
 SmallXit(Ya);
 If(OS2)Then OS2SetTitle(NIL);
 Xit:=Ya;
 {$IFDEF ShareWare}
 If(RegUserName=NIL)Then Begin
  WriteLn;
  WriteLn(MultChr('*',79));
  WriteLn;
  WriteLn('Version "FreeWare" du programme ®MonsterBook¯ Version ',VerPrg);
  WriteLn;
  WriteLn('Ce programme est gratuit. Il est le fruit de mes efforts depuis');
  WriteLn('les dix derniŠres ann‚es. Si vous voulez m''aider … poursuivre le');
  WriteLn('d‚veloppement de se logiciel vous pouvez me faire parvenir un 20$');
  WriteLn('… l''adresse mentionn‚:');
  WriteLn;
  WriteLn(' Les Chevaliers de Malte');
  WriteLn(' ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ');
  WriteLn(' Sylvain Maltais');
  WriteLn;
  WriteLn(MultChr('*',79));
 End;
 {$ENDIF}
 Case(ExitLevel)of
  xlRestart:Begin
   PushKey(kbF3);
   PushKey(kbEnter);
  End;
  xlBoot:Begin
   MemW[_0040:$72]:=$1234;
   ASM
    INT 19h
   END;
  End;
 End;
End;
