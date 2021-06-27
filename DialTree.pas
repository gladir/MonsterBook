{ Cette unitÇ est utilisÇ pour gÇrer des arbres d'une boite de dialogue.
}

Unit DialTree;

{ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ}
                                  INTERFACE
{ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ}

{$I DEF.INC}

Uses Dialex;

Procedure DTInit(Var Q:DialogTreeObject;X1,Y1,X2,Y2:Byte);
Procedure DTInitBureau(Var Q:DialogTreeObject;X1,Y1,X2,Y2:Byte);
Procedure DTInitSystem(Var Q:DialogTreeObject;X1,Y1,X2,Y2:Byte);
Procedure DTRefresh(Var Q:DialogTreeObject);
Function  DTDirExist(Var Q:DialogTreeObject;Const Name:String):Boolean;
Function  DTChDir(Var Q:DialogTreeObject;Name:String):Boolean;
Function  DTMkDir(Var Q:DialogTreeObject;Const Name:String):PDialogTreeElement;
Function  DTRenCurrDir(Var Q:DialogTreeObject;Const NewName:String):Boolean;
Procedure DTRmDir(Var Q:DialogTreeObject;Const Name:String);
Procedure DTRmDirChildren(Var Q:DialogTreeObject;Const Name:String);
Function  DTGetDir(Var Q:DialogTreeObject;Const Name:String):PDialogTreeElement;
Function  DTGetLongDir(Var Q:DialogTreeObject;Pos:Word):String;
Function  DTGetShortDir(Var Q:DialogTreeObject;Pos:Word):String;
Function  DTGetBarTree(Var Q:DialogTreeObject;Pos:Word;Var PC:PDialogTreeElement):String;
Procedure DTSetDir(Var Q:DialogTreeObject;Const Name:String;Open:Boolean);
Procedure DTSetEndShortName(Var Q:DialogTreeObject;Const Name:String);
Procedure DTkUp(Var Q:DialogTreeObject);
Procedure DTkDn(Var Q:DialogTreeObject);
Function  DTRun(Var Q:DialogTreeObject):Word;
Procedure DTReSize(Var Q:DialogTreeObject;X1,Y1,X2,Y2:Byte);
Function  _DTMkDir(Var Q:DialogTreeObject;Const Name:String;Value:Word):PDialogTreeElement;
Function  DTDone(Var Q:DialogTreeObject):Word;
Function  ConfigSystem(Const Title:String):Boolean;
Function  FullConfigSystem:Boolean;
Procedure ManagerPeripheric;
Procedure RegistryEditor;
Function  SelectDirectory(Const Title,CurrPath:String;Input:Boolean):String;

{ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ}
                                 IMPLEMENTATION
{ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ}

Uses
 Adele,Video,Disk,Systex,Memories,Systems,Mouse,Dials,ResServD,
 Restex,ResLoadI,ResServI,SysPlus,DialPlus,DialHW,ToolFile,ToolDsk,
 Registry;

{$I \Source\Chantal\Library\Memories\ROM\ReadRom.Inc}

Type
 SCSIConfig=Record
  BiosMajor:SmallInt;
  BiosMinor:SmallInt;
  PCIBus:Boolean;
  Quantum:Byte;
  BiosBase:Word;
  Base:Word;
 End;

Function SCSIDetect(Cfg:SCSIConfig):Boolean;
Const
 Address:Array[0..6]of Word=(
  $C800,
  $CA00,
  $CE00,
  $DE00,
  $CC00,
  $D000,
  $E000
 );
Var
 I:SmallInt;
 Data:Record
  ID:Word;
  OffsetSig:SmallInt;
  LengthSig:SmallInt;
  BiosVersion:SmallInt;
  BiosSubVer:SmallInt;
  Flag:Byte;  { 1 = PCI bus, 2 = ISA 200S, 3 = ISA 250MG, 4 = ISA 200S }
  Signature:String;
 End;
Begin
 SCSIDetect:=False;
 FillClr(Cfg,SizeOf(Cfg));
 DBOpenServerName(ChantalServer,'CHANTAL:/Materiel/SCSI/BIOSSignature.Dat');
 DBFirst(ChantalServer);
 While Not DBEOF(ChantalServer)do Begin
  DBReadRec(ChantalServer,Data);
  For I:=0to 6do If(ReadRom(Address[I],Data.OffsetSig,Data.LengthSig)=Data.Signature)Then Begin
   Cfg.BiosMajor:=Data.BiosVersion;
   Cfg.BiosMinor:=Data.BiosSubVer;
   Cfg.PCIBus:=Data.Flag=1;
   If Data.Flag>1Then Cfg.Quantum:=Data.flag
                 Else Cfg.Quantum:=0;
   Cfg.BiosBase:=Address[I];
   {$IFDEF FLAT386}
    Cfg.Base:=0;
   {$ELSE}
    If Cfg.BiosMajor=2Then Begin
     Case(Cfg.Quantum)of
      2,3:Cfg.Base:=MemW[Cfg.BiosBase:$1FA2];{ ISA 200S, ISA 250MG }
      4:Cfg.Base:=MemW[Cfg.BiosBase:$1FA3];  { ISA 200S (un autre) }
      Else Cfg.Base:=MemW[Cfg.BiosBase:$1FCC];
     End;
    End;
   {$ENDIF}
   SCSIDetect:=True;
   Exit;
  End;
 End;
End;

Procedure DTInit(Var Q:DialogTreeObject;X1,Y1,X2,Y2:Byte);Begin
 FillClr(Q,SizeOf(Q));
 WEInit(Q.W,X1,Y1,X2,Y2+2);
 Q.W.NotFullScrnX:=False;
 Q.W.NotFullScrnY:=False;
 Q.W.Palette:=CurrKrs.Dialog.Env.List;
 WESetKrBorder(Q.W);
{ WEPutBarMsRight(Q.W);}
End;

Procedure DTReSize(Var Q:DialogTreeObject;X1,Y1,X2,Y2:Byte);Begin
 WEInit(Q.W,X1,Y1,X2,Y2+2);
 Q.W.NotFullScrnX:=False;
 Q.W.NotFullScrnY:=False;
 Q.W.Palette:=CurrKrs.Dialog.Env.List;
 WESetKrBorder(Q.W);
End;

Function GetAutoRunFileName(C:Char):String;Begin
 GetAutoRunFileName:=C+':\AUTORUN.INF';
End;

Function AutoRunFound(C:Char):Boolean;Begin
 AutoRunFound:=FileExist(GetAutoRunFileName(C));
End;

Function DTGetDirSystem(Var Q:DialogTreeObject;Code:Word):String;
Var
 Dir:String;
Begin
 Dir:='Ordinateur\';
 Case(Code)of
  $F001:AddStr(Dir,'Contrìleur de disquette');
  $F003:AddStr(Dir,'Lecteur de disque');
  { $F007:Ordinateur;}
  $F008:AddStr(Dir,'Carte graphiques');
  $F009:AddStr(Dir,'CD-ROM');
  $F00A:AddStr(Dir,'Clavier');
  $F00B:AddStr(Dir,'Contrìleur de bus USB');
  $F00C:AddStr(Dir,'Contrìleur de disque dur');
  $F00D:AddStr(Dir,'Contrìleur son, vidÇo et jeux');
  $F00E:AddStr(Dir,'êcrans');
  $F00F:AddStr(Dir,'Modem');
  $F010:AddStr(Dir,'PÇriphÇrique systäme');
  $F011:AddStr(Dir,'Ports (COM et LPT)');
  $F012:AddStr(Dir,'Souris');
  $F013:AddStr(Dir,'Carte rÇseau');
  $F014:AddStr(Dir,'Contrìleurs SCSI');
 End;
 If Dir[Length(Dir)]<>'\'Then IncStr(Dir,'\');
 DTGetDirSystem:=Dir;
End;

Procedure _DTMkDirSystem(Var Q:DialogTreeObject;Const Name:String;Code:Word);
Var
 Dir:String;
Begin
 Dir:=DTGetDirSystem(Q,Code);
 If Code=$F001Then Code:=$F00C;
 _DTMkDir(Q,Dir+Name,Code);
 If Name<>''Then DTSetDir(Q,Dir,False);
End;

Type
 SearchPChr=Record
  Fill:Array[0..16]of Char;
  PC:PChr;
 End;

Function DTOnEnterDir(Var Obj;Var Context):Boolean;
Label Load;
Var
 Q:DialogTreeObject Absolute Obj;
 PC:PDialogTreeElement;
 S:String;
 Name:String;
 Open:Boolean;
 B:BF;
 X:SearchRec;
 XL:SearchPChr Absolute X;
 NumDir,I:Integer;

 Function IsOpen:Boolean;
 Var
  SC,SN:String;
 Begin
  SC:=DTGetShortDir(Q,Q.P);
  SN:=DTGetShortDir(Q,Q.P+1);
  IsOpen:=CmpLeft(SN,SC)and(Length(SN)>Length(SC));
 End;

Begin
 DTOnEnterDir:=False;
 S:=DTGetBarTree(Q,Q.P,PC);
 If(PC<>NIL)Then Begin
  Open:=IsOpen;
  If Not(Open)Then Begin
   If(PC^.Level>=2)and(Pos('+',S)>0)Then Begin
    S:=DTGetShortDir(Q,Q.P);
    DTRmDirChildren(Q,S);
   End;
   S:=PC^.ShortName;
   BFInit(B);
   B.Tri:=fName;
   If(Length(S)=2)and(IsRomanLetter(S[1])and(S[2]=':'))Then Begin
    IncStr(S,'\');
    BFSelPathExt(B,S+'*.*',faAll);
    Goto Load;
   End
    Else
   If PC^.ReturnCode=0Then Begin
    S:=DTGetShortDir(Q,Q.P);
{    S:=Copy(S,3,255);}
    BFSelPathExt(B,S+'*.*',faAll);
Load:
    NumDir:=BFMaxFiles(B);
    For I:=0to(NumDir)do Begin
     BFGetFile(B,I,X);
     If((sfaDir)in(X.Attr.Flags))and(X.Name<>'..')Then Begin
      If(XL.PC=NIL)Then Name:=X.Name
                   Else Name:=StrPas(XL.PC);
      PC:=DTMkDir(Q,'Bureau\Poste de travail\'+S+Name);
      PC^.ShortName:=X.Name;
     End;
    End;
    DTOnEnterDir:=True;
   End;
   BFDone(B);
  End
   Else
  Begin
   S:=DTGetShortDir(Q,Q.P);
   DTRmDirChildren(Q,S);
  End;
 End;
End;

Function DTOnEnterDirSystem(Var Obj;Var Context):Boolean;
Var
 Q:DialogTreeObject Absolute Obj;
 PC:PDialogTreeElement;
 S:String;
Begin
 DTOnEnterDirSystem:=False;
 S:=DTGetBarTree(Q,Q.P,PC);
 If PC^.ShortName='CMOS'Then CmosSetup(PC^.LongName);
 If PC^.ShortName='CLOCK'Then ClockSetup(PC^.LongName);
 If PC^.ShortName='CPU'Then CPUSetup(PC^.LongName);
 If PC^.ShortName='DISKETTE'Then DisketteSetup(PC^.LongName);
 If PC^.ShortName='IRQ'Then IRQSetup(PC^.LongName);
 If PC^.ShortName='JOYSTICK'Then JoystickSetup(PC^.LongName);
 If PC^.ShortName='KEYBOARD'Then KeyboardSetup(PC^.LongName);
 If PC^.ShortName='MOUSE'Then MouseSetup(PC^.LongName);
 If PC^.ShortName='SCSI'Then SCSISetup(PC^.LongName);
 If PC^.ShortName='SPEAKER'Then PCSpeakerSetup(PC^.LongName);
 If CmpLeft(PC^.ShortName,'VIDEO')and(IsArabicNumber(PC^.ShortName[6]))Then Begin
  VideoSetup(PC^.LongName,Byte(PC^.ShortName[6])-Byte('0'));
 End;
End;

Function DTOnDirNotExist(Var Obj;Var Context;Const CurrName,Next2Create:String):Boolean;
Label Reload;
Var
 Q:DialogTreeObject Absolute Obj;
 PC:PDialogTreeElement;
 S:String;
 NextName:String;
 Name:String;
 B:BF;
 X:SearchRec;
 XL:SearchPChr Absolute X;
 NumDir,J:Integer;
 I:Byte;
Begin
 DTOnDirNotExist:=False;
 I:=1;S:=CurrName;
 BFInit(B);
 B.Tri:=fName;
Reload:
 NextName:='';
 If Next2Create[I]='\'Then Begin
  IncStr(NextName,Next2Create[I]);
  Inc(I);
 End;
 While I<=Length(Next2Create)do Begin
  IncStr(NextName,Next2Create[I]);
  If Next2Create[I]='\'Then Begin
   Inc(I);
   Break;
  End;
  Inc(I);
 End;
 If Not BFSelPathExt(B,S+'*.*',faAll)Then Exit;
 NumDir:=BFMaxFiles(B);
 For J:=0to(NumDir)do Begin
  BFGetFile(B,J,X);
  If((sfaDir)in(X.Attr.Flags))and(X.Name<>'..')Then Begin
   If(XL.PC=NIL)Then Name:=X.Name
                Else Name:=StrPas(XL.PC);
   PC:=DTMkDir(Q,'Bureau\Poste de travail\'+S+Name);
   If(PC<>NIL)Then PC^.ShortName:=X.Name;
  End;
 End;
 If I>=Length(Next2Create)Then Begin
  BFDone(B);
  DTOnDirNotExist:=True;
  Exit;
 End;
 AddStr(S,NextName);
 Goto Reload;
End;

Procedure DTSetEndShortName(Var Q:DialogTreeObject;Const Name:String);
Var
 PC:PDialogTreeElement;
Begin
 PC:=_ALGetBuf(Q.Tree,Q.InsP);
 If(PC<>NIL)Then Begin
  PC^.ShortName:=Name;
 End;
End;

Function DTRenCurrDir(Var Q:DialogTreeObject;Const NewName:String):Boolean;
Var
 Element:DialogTreeElement;
 PC:PDialogTreeElement;
 Size:Word;
Begin
 DTRenCurrDir:=False;
 PC:=_ALGetBuf(Q.Tree,Q.P);
 If(PC<>NIL)Then Begin
  MoveLeft(PC^,Element,SizeOf(Element));
  Element.LongName:=NewName;
  Size:=SizeOf(Element)-SizeOf(String)+Length(NewName)+1;
  PC:=ALSet(Q.Tree,Q.P,Size);
  If(PC<>NIL)Then Begin
   MoveLeft(Element,PC^,Size);
   DTRenCurrDir:=True;
  End;
 End;
End;

Function DTOnContextMenuBureau(Var Obj;Var Context):Boolean;
Var
 Q:DialogTreeObject Absolute Obj;
 PC:PDialogTreeElement;
 S:String;
 ThisDisk:Byte;
Begin
 DTOnContextMenuBureau:=False;
 S:=DTGetBarTree(Q,Q.P,PC);
 If PC^.ShortName[Length(PC^.ShortName)]=':'Then Begin
  ThisDisk:=Drv2Dsk(PC^.ShortName[1]);
  Case RunMenuApp(151)of
   $F101:DriveInfo(ThisDisk);
   $F102:CleanDisk(ThisDisk);
   $F103:DTRenCurrDir(Q,RenameDiskName(ThisDisk));
  End;
  DTOnContextMenuBureau:=True;
 End;
End;

Procedure DTInitBureau(Var Q:DialogTreeObject;X1,Y1,X2,Y2:Byte);
Var
 I:Byte;
 J:Char;
 Name:String;
 Code:Word;
Begin
 DTInit(Q,X1,Y1,X2,Y2);
 Q.OnEnter:=DTOnEnterDir;
 Q.OnDirNotExist:=DTOnDirNotExist;
 _DTMkDir(Q,'Bureau',$F001);
 DTSetEndShortName(Q,'');
 _DTMkDir(Q,'Bureau\Poste de travail\',$F006);
 DTSetEndShortName(Q,'');
 If(FloppyDskExist)Then For I:=0to NmFloppyDsk-1do Begin
  _DTMkDir(Q,'Bureau\Poste de travail\Disquette ('+Chr(65+I)+':)',$F003);
  DTSetEndShortName(Q,Chr(65+I)+':');
 End;
 For J:='C'to'Z'do If DrvExist(J)Then Begin
  If DiskFixed(Byte(J)-64)Then Begin
   Name:=GetDskLabel(Byte(J)-64);
   If Name=''Then Name:='Disque dur'
    Else
   Begin
    For I:=2to Length(Name)do Name[I]:=ChrDn(Name[I]);
   End;
   Code:=$F004;
   If AutoRunFound(J)Then Code:=$FD00+Byte(J);
   _DTMkDir(Q,'Bureau\Poste de travail\'+Name+' ('+J+':)',Code);
  End
   Else
  If IsCDROM(Byte(J)-65)Then Begin
   _DTMkDir(Q,'Bureau\Poste de travail\CD-ROM ('+J+':)',$F005);
  End
   Else
  Begin
   _DTMkDir(Q,'Bureau\Poste de travail\Disque amovible ('+J+':)',$F003);
  End;
  DTSetEndShortName(Q,J+':');
 End;
 _DTMkDir(Q,'Bureau\Corbeil\',$F002);
 Q.OnContextMenu:=DTOnContextMenuBureau;
End;

Procedure DTLoadSystem(Var Q:DialogTreeObject);
Var
 I:Byte;
 _PVid:Array[0..1]of PIV;
 SCSI:Boolean;
 {$IFNDEF __Windows__}
  PortAddr:Word;
  Code:Byte;
 {$ENDIF}
 Cfg:SCSIConfig;
Begin
 Q.OnEnter:=DTOnEnterDirSystem;
 _DTMkDirSystem(Q,'',$F007);
 _DTMkDirSystem(Q,'',$F008);
 _DTMkDirSystem(Q,'',$F013);
 For I:=$9to$C do _DTMkDirSystem(Q,'',$F000+I);
 _DTMkDirSystem(Q,'',$F001);
 _DTMkDirSystem(Q,'',$F00D);
 _DTMkDirSystem(Q,'',$F00E);
 _DTMkDirSystem(Q,'',$F003);
 For I:=$Fto$11 do _DTMkDirSystem(Q,'',$F000+I);
 SCSI:=SCSIDetect(Cfg);
 If(SCSI)Then Begin
  _DTMkDirSystem(Q,'',$F014);
  DTSetEndShortName(Q,'SCSI');
 End;
 _DTMkDirSystem(Q,'',$F012);
 GetPIV(_PVid[0]);
 GetPIVSec(_PVid[1]);
 For I:=0to 1do If _PVid[I].Card<>0Then Begin
  _DTMkDirSystem(Q,SelectField('CHANTAL:/Materiel/IDVideo.Dat',_PVid[I].Card,1),$F008);
  DTSetEndShortName(Q,'VIDEO'+WordToStr(I));
 End;
 _DTMkDirSystem(Q,'Clavier '+SelectField('CHANTAL:/Materiel/Clavier/Modele.Dat',KbdModel,1),$F00A);
 DTSetEndShortName(Q,'KEYBOARD');
 _DTMkDirSystem(Q,'Manette de jeu pour port de jeux',$F00D);
 DTSetEndShortName(Q,'JOYSTICK');
 _DTMkDirSystem(Q,'Contrìleur de lecteur de disquette standard',$F001);
 DTSetEndShortName(Q,'DISKETTE');
 _DTMkDirSystem(Q,'(êcran inconnu)',$F00E);
 _DTMkDirSystem(Q,'BIOS Plug & Play',$F010);
 _DTMkDirSystem(Q,'Bus PCI',$F010);
 _DTMkDirSystem(Q,'Carte d''extension pour BIOS Plug-and-Play',$F010);
 _DTMkDirSystem(Q,'Carte systäme',$F010);
 _DTMkDirSystem(Q,'Contrìleur d''accäs directe en mÇmoire',$F010);
 _DTMkDirSystem(Q,'Contrìleur d''interruption programmable',$F010);
 DTSetEndShortName(Q,'IRQ');
 _DTMkDirSystem(Q,'Coprocesseur mathÇmatique',$F010);
 _DTMkDirSystem(Q,'Haut-parleur systäme',$F010);
 DTSetEndShortName(Q,'SPEAKER');
 _DTMkDirSystem(Q,'Horloge systäme',$F010);
 DTSetEndShortName(Q,'CLOCK');
 If(CmosExist)Then Begin
  _DTMkDirSystem(Q,'Horloge systäme CMOS/Temps rÇel',$F010);
  DTSetEndShortName(Q,'CMOS');
 End;
 _DTMkDirSystem(Q,'Prise en charge du processeur',$F010);
 DTSetEndShortName(Q,'CPU');
 _DTMkDirSystem(Q,'Ressource de la carte märe',$F010);
 For I:=0to 3do Begin
  If ComExist(I)Then _DTMkDirSystem(Q,'Port de communication (COM'+Chr(I+49)+')',$F011);
 End;
 {$IFNDEF __Windows__}
  If(SCSI)Then Begin
   PortAddr:=$140;
   For I:=0to 3do Begin
    Code:=Port[PortAddr+6];
    Case(Code)of
     $60:Begin
      _DTMkDirSystem(Q,'Carte hìte TMC-18C50/18C30',$F014);
      DTSetEndShortName(Q,'SCSI');
     End;
     $61:Begin
      _DTMkDirSystem(Q,'Carte hìte TMC-1800',$F014);
      DTSetEndShortName(Q,'SCSI');
     End;
    End;
    Inc(PortAddr,$10);
   End;
  End;
 {$ENDIF}
 Repeat
  Case(Adele.Mouse)of
   msPS2:_DTMkDirSystem(Q,'Port souris compatible PS/2',$F012);
   msCOM:_DTMkDirSystem(Q,'Port souris par port sÇrie',$F012);
   msNoMouse:Break;
   Else _DTMkDirSystem(Q,'Port souris par pilote du systäme d''exploitation',$F012);
  End;
  DTSetEndShortName(Q,'MOUSE');
 Until True;
End;

Procedure DTInitSystem(Var Q:DialogTreeObject;X1,Y1,X2,Y2:Byte);Begin
 DTInit(Q,X1,Y1,X2,Y2);
 DTLoadSystem(Q);
End;

Function DTGetBarTree(Var Q:DialogTreeObject;Pos:Word;Var PC:PDialogTreeElement):String;
Var
 P:Word;
 Level:Byte;
 J,I:Integer;
 TC,TC2:^DialogTreeElement;
 S:String;
 TmpTree:ArrayList;
 Open:Boolean;                 { EntrÇe ouverte? }
Begin
 DTGetBarTree:='';
 PC:=NIL;
 If Q.Tree.Count=0Then Exit;
 ALSetPtr(Q.Tree,0);
 P:=0;
 For I:=0to(Pos)do Begin
  Repeat
   PC:=_ALGetCurrBuf(Q.Tree);
   If(PC=NIL)Then Exit;
   ALNext(Q.Tree);
   Inc(P);
  Until PC^.Open;
 End;
 If PC^.Level>0Then Begin
  S:=Spc(PC^.Level)+'¿';
  TmpTree:=Q.Tree;
  ALSetPtr(Q.Tree,Q.Tree.Count-1);
  For J:=TmpTree.Count-1downto(P)do Begin
   TC:=_ALGetCurrBuf(Q.Tree);
   ALPrevious(Q.Tree);
   Level:=TC^.Level;
   If(TC<>NIL)and(Level>0)and(J>=P)Then Begin
    Inc(Level);
    ALSetPtr(TmpTree,J-1);
    For I:=J-1downto 0do Begin
     If I=P-1Then Begin
      If S[Level]in['≥','¿']Then S[Level]:='√'
                            Else S[Level]:='≥';
     End;
     TC2:=_ALGetCurrBuf(TmpTree);
     ALPrevious(TmpTree);
     If(TC2^.Level<=TC^.Level)Then Break;
    End;
   End;
  End;
  Open:=True;
  TC2:=_ALGetBuf(TmpTree,P);
  If(TC2<>NIL)and(TC2^.Level>PC^.Level)and(Not TC^.Open)Then Open:=False;
  If(Open)Then IncStr(S,'-')
          Else IncStr(S,'+');
 End
  Else
 S:='';
 DTGetBarTree:=S;
End;

Function DTGetLongDir(Var Q:DialogTreeObject;Pos:Word):String;
Var
 P:Word;
 Level:Byte;
 I:Integer;
 PC,TC:^DialogTreeElement;
 S:String;
Begin
 DTGetLongDir:='';
 If Q.Tree.Count=0Then Exit;
 PC:=NIL;
 ALSetPtr(Q.Tree,0);
 P:=0;
 For I:=0to(Pos)do Begin
  Repeat
   PC:=_ALGetCurrBuf(Q.Tree);
   If(PC=NIL)Then Exit;
   ALNext(Q.Tree);
   Inc(P);
  Until PC^.Open;
 End;
 S:=PC^.LongName+'\';
 If PC^.Level>0Then Begin
  Level:=PC^.Level;
  ALSetPtr(Q.Tree,P-1);
  For I:=P-1downto 0do Begin
   TC:=_ALGetCurrBuf(Q.Tree);
   ALPrevious(Q.Tree);
   If(TC^.Level<Level)Then Begin
    Dec(Level);
    S:=TC^.LongName+'\'+S;
    If Level=0Then Break;
   End;
  End;
 End;
 DTGetLongDir:=S;
End;

Function DTGetShortDir(Var Q:DialogTreeObject;Pos:Word):String;
Var
 P:Word;
 Level:Byte;
 I:Integer;
 PC,TC:^DialogTreeElement;
 S:String;
Begin
 DTGetShortDir:='';
 If Q.Tree.Count=0Then Exit;
 PC:=NIL;
 ALSetPtr(Q.Tree,0);
 P:=0;
 For I:=0to(Pos)do Begin
  Repeat
   PC:=_ALGetCurrBuf(Q.Tree);
   If(PC=NIL)Then Exit;
   ALNext(Q.Tree);
   Inc(P);
  Until PC^.Open;
 End;
 S:=PC^.ShortName+'\';
 If PC^.Level>0Then Begin
  Level:=PC^.Level;
  ALSetPtr(Q.Tree,P-1);
  For I:=P-1downto 0do Begin
   TC:=_ALGetCurrBuf(Q.Tree);
   ALPrevious(Q.Tree);
   If(TC^.Level<Level)Then Begin
    Dec(Level);
    S:=TC^.ShortName+'\'+S;
    If Level=0Then Break;
   End;
  End;
 End;
 While CmpLeft(S,'\\')do S:=Copy(S,3,255);
 DTGetShortDir:=S;
End;

Procedure DTPutIcon(Var Q:DialogTreeObject;X,Y,Code:Word);
Label Put;
Var
 Icon:XInf;
 Num:Word;
 L:ArrayList;
 S:String;
 I:Integer;
 J:Byte;
Begin
 Case(Code)of
  $F001..$F013:Num:=Code-$F001+10;
  $F014:Num:=34;
  $F024..$F025:Num:=Code and$00FF;
  $FD41..$FD5A:Begin
   Num:=0;
   If ALLoadFileASCII(L,GetAutoRunFileName(Chr(Code)))Then Begin
    For I:=0to L.Count-1do Begin
     S:=StrUp(_ALGetStr(L,I));
     If CmpLeft(S,'ICON=')Then Begin
      S:=Copy(S,6,255);
      For J:=1to Length(S)do If S[J]=','Then Begin
       S[0]:=Chr(J-1);
       Break;
      End;
      If StrI(2,S)<>':'Then S:=Chr(Code)+':'+S;
      RILoadImage(S,diAutoDetect,0,Num,rmAllResSteady,[],Icon);
      ALDone(L);
      Goto Put;
     End;
    End;
    ALDone(L);
   End;
   RIPutImageScale(FolderIcon^,X,Y,16,HeightChr,Q.W.CurrColor shr 4);
   Exit;
  End;
  Else Exit;
 End;
 RILoadImage('SYS:MEDIA.RLL',diAutoDetect,0,Num,rmAllResSteady,[],Icon);
Put:
 RIPutImageScale(Icon,X,Y,16,HeightChr,Q.W.CurrColor shr 4);
 XFreeMem(Icon);
End;

Function DTPutBarTree(Var Q:DialogTreeObject;Y:Byte;P:Word):Boolean;
Var
 S:String;
 I:Byte;
 Ok:Boolean;
 GX1,GY1:Word;
 PC:PDialogTreeElement;
Begin
 DTPutBarTree:=False;
 If Q.Tree.Count=0Then Exit;
 S:=DTGetBarTree(Q,P,PC);
 If(PC=NIL)Then Exit;
 If(MediaSupport)and(IsGrf)Then AddStr(S,'  ');
 WESetKrBorder(Q.W);
 WEPutTxtXY(Q.W,0,Y,S);
 If(P=Q.P)Then WESetKrSel(Q.W)
          Else WESetKrBorder(Q.W);
 WEPutTxtXY(Q.W,Length(S),Y,PC^.LongName);
 If(MediaSupport)and(IsGrf)Then Begin
  Ok:=False;
  For I:=1to Length(S)do If S[I]in['+','-']Then Begin
   Ok:=True;
   Break;
  End;
  If Not(Ok)Then I:=0;
  GX1:=(WEGetRX1(Q.W)+I-1)shl 3;
  GY1:=GetRawY(WEGetRY1(Q.W)+Y);
  If(Ok)Then Begin
   PutRect(GX1,GY1+2,GX1+7,GY1+HeightChr-4,LightGray);
  End;
  If PC^.ReturnCode<>0Then DTPutIcon(Q,GX1+8,GY1,PC^.ReturnCode)
  Else RIPutImageScale(FolderIcon^,GX1+8,GY1,16,HeightChr,Q.W.CurrColor shr 4);
 End;
 WESetKrBorder(Q.W);
 WEClrEOL(Q.W);
 DTPutBarTree:=True;
End;

Procedure DTRefresh(Var Q:DialogTreeObject);
Var
 IY:Word;
 P:Word;
Begin
 If Q.Tree.Count=0Then Exit;
 WEPutBarMsRight(Q.W);
 P:=Q.P-Q.Y;
 For IY:=0to(Q.W.MaxY)do Begin
  If Not DTPutBarTree(Q,IY,P+IY)Then Begin
   WEClrWnBorder(Q.W,0,IY,wnMax,wnMax);
   Exit;
  End;
 End;
End;

Function DTDirExist(Var Q:DialogTreeObject;Const Name:String):Boolean;
Label NextLevel;
Var
 I:Byte;
 S:String;
 Level:Byte;
 PC:^DialogTreeElement;
 P:Word;
Begin
 DTDirExist:=False;
 If Q.Tree.Count=0Then Exit;
 P:=0;Level:=0;I:=1;
 ALSetPtr(Q.Tree,0);
NextLevel:
 If Name[I]='\'Then Inc(I);
 S:='';
 While I<=Length(Name)do Begin
  If Name[I]='\'Then Break;
  IncStr(S,Name[I]);
  Inc(I);
 End;
 Repeat
  PC:=_ALGetCurrBuf(Q.Tree);
  If(PC^.Level<Level)Then Exit;
  ALNext(Q.Tree);
  Inc(P);
  If(PC^.ShortName=S)or(PC^.LongName=S)Then Begin
   If I>=Length(Name)Then Begin
    DTDirExist:=True;
    Exit;
   End
    Else
   Begin
    Inc(Level);
    Goto NextLevel;
   End;
  End;
 Until P>=Q.Tree.Count;
End;

Function _DTMkDir(Var Q:DialogTreeObject;Const Name:String;Value:Word):PDialogTreeElement;
Label NextLevel,Restart;
Var
 Element:DialogTreeElement;
 I:Byte;
 S:String;
 Level:Byte;
 PC:PDialogTreeElement;
 P:Word;
 Size:Word;
Begin
 _DTMkDir:=NIL;
 If DTDirExist(Q,Name)Then Exit;
 P:=0;Level:=0;I:=1;
 ALSetPtr(Q.Tree,0);
NextLevel:
 If Name[I]='\'Then Inc(I);
 S:='';
 While I<=Length(Name)do Begin
  If Name[I]='\'Then Break;
  IncStr(S,Name[I]);
  Inc(I);
 End;
 Repeat
  PC:=_ALGetCurrBuf(Q.Tree);
  If(PC=NIL)Then Goto Restart;
  If(PC^.Level<Level)Then Begin
ReStart:
   FillClr(Element,SizeOf(Element));
   Element.Level:=Level;
   Element.Open:=True;
   Element.ShortName:=S;
   Element.LongName:=S;
   If I>=Length(Name)Then Element.ReturnCode:=Value;
   Size:=SizeOf(Element)-SizeOf(String)+Length(Name)+1;
   Q.InsP:=P;
   PC:=ALIns(Q.Tree,P,Size);
   Inc(P);
   If(PC<>NIL)Then Begin
    _DTMkDir:=PC;
    MoveLeft(Element,PC^,Size);
    If Name[I]='\'Then Inc(I);
    S:='';
    If I>Length(Name)Then Exit;
    While I<=Length(Name)do Begin
     If Name[I]='\'Then Begin
      Inc(Level);
      Goto Restart;
     End;
     IncStr(S,Name[I]);
     Inc(I);
    End;
    Inc(Level);
    Goto Restart;
   End;
   Exit;
  End;
  ALNext(Q.Tree);
  Inc(P);
  If(PC^.ShortName=S)or(PC^.LongName=S)Then Begin
   If I>=Length(Name)Then Exit
    Else
   Begin
    Inc(Level);
    Goto NextLevel;
   End;
  End;
 Until P>=Q.Tree.Count;
 Goto Restart;
End;

Function DTMkDir(Var Q:DialogTreeObject;Const Name:String):PDialogTreeElement;Begin
 DTMkDir:=_DTMkDir(Q,Name,0);
End;

Procedure _DTRmDir(Var Q:DialogTreeObject;Const Name:String;OnlyChildren:Boolean);
Label NextLevel,Restart;
Var
 I:Byte;
 S:String;
 P:Word;
 Level:Byte;
 PC:^DialogTreeElement;
Begin
 If Not DTDirExist(Q,Name)Then Exit;
 P:=0;Level:=0;I:=1;
 ALSetPtr(Q.Tree,0);
NextLevel:
 If Name[I]='\'Then Inc(I);
 S:='';
 While I<=Length(Name)do Begin
  If Name[I]='\'Then Break;
  IncStr(S,Name[I]);
  Inc(I);
 End;
 Repeat
  PC:=_ALGetCurrBuf(Q.Tree);
  If(PC=NIL)Then Exit;
  ALNext(Q.Tree);
  Inc(P);
  If(PC^.ShortName=S)or(PC^.LongName=S)Then Begin
   If I>=Length(Name)Then Begin
    If(OnlyChildren)Then Begin
     Inc(P);
     Inc(Level);
    End
     Else
    Begin
      {Efface le rÇpertoire}
     ALDelBuf(Q.Tree,P-1);
    End;
     {Efface ses rÇpertoires rÇcurant }
    PC:=_ALGetBuf(Q.Tree,P-1);
    While(PC<>NIL)and(Level+1<PC^.Level)do Begin
     ALDelBuf(Q.Tree,P-1);
     PC:=_ALGetBuf(Q.Tree,P-1);
    End;
    Exit
   End
    Else
   Begin
    Inc(Level);
    Goto NextLevel;
   End;
  End;
 Until P>=Q.Tree.Count;
End;

Procedure DTRmDir(Var Q:DialogTreeObject;Const Name:String);Begin
 _DTRmDir(Q,Name,False);
End;

Procedure DTRmDirChildren(Var Q:DialogTreeObject;Const Name:String);Begin
 _DTRmDir(Q,Name,True);
End;

Procedure DTSetDir(Var Q:DialogTreeObject;Const Name:String;Open:Boolean);
Label NextLevel;
Var
 I:Byte;
 S:String;
 P:Word;
 Level:Byte;
 PC:^DialogTreeElement;
Begin
 If Not DTDirExist(Q,Name)Then Exit;
 P:=0;Level:=0;I:=1;
 ALSetPtr(Q.Tree,0);
NextLevel:
 If Name[I]='\'Then Inc(I);
 S:='';
 While I<=Length(Name)do Begin
  If Name[I]='\'Then Break;
  IncStr(S,Name[I]);
  Inc(I);
 End;
 Repeat
  PC:=_ALGetCurrBuf(Q.Tree);
  If(PC=NIL)Then Exit;
  ALNext(Q.Tree);
  Inc(P);
  If(PC^.ShortName=S)or(PC^.LongName=S)Then Begin
   If I>=Length(Name)Then Begin
    PC:=_ALGetBuf(Q.Tree,P-1);
    If(PC<>NIL)Then Begin
     If(Open)Then Begin
      PC:=_ALGetBuf(Q.Tree,P);
      While(PC<>NIL)and(Level<PC^.Level)do Begin
       If(Level+1=PC^.Level)Then PC^.Open:=True;
       PC:=_ALGetBuf(Q.Tree,P);
       Inc(P);
      End;
     End
      Else
     Begin
      PC:=_ALGetBuf(Q.Tree,P);
      While(PC<>NIL)and(Level<PC^.Level)do Begin
       PC^.Open:=False;
       PC:=_ALGetBuf(Q.Tree,P);
       Inc(P);
      End;
     End;
    End;
    Exit;
   End
    Else
   Begin
    Inc(Level);
    Goto NextLevel;
   End;
  End;
 Until P>=Q.Tree.Count;
End;

Function DTChDir(Var Q:DialogTreeObject;Name:String):Boolean;
Label NextLevel,Restart;
Var
 I:Byte;
 S:String;
 P:Word;
 Level:Byte;
 PC:^DialogTreeElement;
Begin
 DTChDir:=False;
 If Name=''Then Name:=GetCurrentDir;
 If(Name='*:')or(Name='*:\')Then Name:='Poste de travail';
 If Copy(Name,Length(Name)-2,3)='*.*'Then _Left(Name,Length(Name)-3);
 P:=0;Level:=0;I:=1;
 ALSetPtr(Q.Tree,0);
NextLevel:
 If Name[I]='\'Then Inc(I);
 S:='';
 While I<=Length(Name)do Begin
  If Name[I]='\'Then Break;
  IncStr(S,Name[I]);
  Inc(I);
 End;
 Repeat
  PC:=_ALGetCurrBuf(Q.Tree);
  If(PC=NIL)Then Goto Restart;
  If(PC^.Level<Level)Then Begin
ReStart:
   Dec(I,Length(S));
   S:=Left(Name,I-1);
   If(@Q.OnDirNotExist<>NIL)Then Begin
    If Q.OnDirNotExist(Q,Q.Context^,S,Copy(Name,I,255))Then Begin
     DTChDir:=DTChDir(Q,Name);
    End;
   End
    Else
   DTChDir:=DTChDir(Q,S);
   Exit;
  End;
  ALNext(Q.Tree);
  Inc(P);
  If(PC^.ShortName=S)or(PC^.LongName=S)Then Begin
   If I>=Length(Name)Then Begin
    Q.P:=P-1;
    Q.Y:=Q.P;
    If(Q.Y>Q.W.MaxY)Then Q.Y:=Q.W.MaxY;
    DTChDir:=True;
    Exit;
   End
    Else
   Begin
    Inc(Level);
    Goto NextLevel;
   End;
  End;
 Until P>=Q.Tree.Count;
 Goto Restart;
End;

Function DTGetDir(Var Q:DialogTreeObject;Const Name:String):PDialogTreeElement;
Label NextLevel,Restart;
Var
 I:Byte;
 S:String;
 P:Word;
 Level:Byte;
 PC:^DialogTreeElement;
Begin
 DTGetDir:=NIL;
 If Not DTDirExist(Q,Name)Then Exit;
 P:=0;Level:=0;I:=1;
 ALSetPtr(Q.Tree,0);
NextLevel:
 If Name[I]='\'Then Inc(I);
 S:='';
 While I<=Length(Name)do Begin
  If Name[I]='\'Then Break;
  IncStr(S,Name[I]);
  Inc(I);
 End;
 Repeat
  PC:=_ALGetCurrBuf(Q.Tree);
  If(PC=NIL)Then Exit;
  ALNext(Q.Tree);
  Inc(P);
  If(PC^.ShortName=S)or(PC^.LongName=S)Then Begin
   If I>=Length(Name)Then Begin
    DTGetDir:=_ALGetBuf(Q.Tree,P-1);
    Exit;
   End
    Else
   Begin
    Inc(Level);
    Goto NextLevel;
   End;
  End;
 Until P>=Q.Tree.Count;
End;

Procedure DTkUp(Var Q:DialogTreeObject);
Var
 OldP:Word;
 OldY:Byte;
Begin
 If Q.P>0Then Begin
  OldY:=Q.Y;OldP:=Q.P;
  Dec(Q.P);
  If Q.Y>0Then Begin
   Dec(Q.Y);
   DTPutBarTree(Q,OldY,OldP);
   DTPutBarTree(Q,Q.Y,Q.P);
  End
   Else
  DTRefresh(Q);
 End;
End;

Procedure DTkDn(Var Q:DialogTreeObject);
Var
 OldP:Word;
 OldY:Byte;
 PC:PDialogTreeElement;
Begin
 If DTGetBarTree(Q,Q.P+1,PC)<>''Then Begin
  OldY:=Q.Y;OldP:=Q.P;
  Inc(Q.P);
  If(Q.Y<Q.W.MaxY)Then Begin
   Inc(Q.Y);
   DTPutBarTree(Q,OldY,OldP);
   DTPutBarTree(Q,Q.Y,Q.P);
  End
   Else
  DTRefresh(Q);
 End;
End;

Procedure DTkEnd(Var Q:DialogTreeObject);
Var
 I:Integer;
 PC:PDialogTreeElement;
Begin
 For I:=Q.Tree.Count-1downto 0do Begin
  DTGetBarTree(Q,I,PC);
  If(PC<>NIL)Then Begin
   Q.P:=I;
   Q.Y:=I;
   If(Q.Y>Q.W.MaxY)Then Q.Y:=Q.W.MaxY;
   DTRefresh(Q);
   Exit;
  End;
 End;
End;

Function DTRun(Var Q:DialogTreeObject):Word;
Label Enter;
Var
 K:Word;
 PC:PDialogTreeElement;
 S:String;
 OldP:Word;
 OldY:Byte;
Begin
 __ShowMousePtr;
 Repeat
  K:=WEReadk(Q.W);
  Case(K)of
   kbInWn:Begin
    WaitMouseBut0;
    OldY:=Q.Y;OldP:=Q.P;
    Dec(Q.P,Q.Y);
    Q.Y:=LastMouseY-WEGetRY1(Q.W);
    Inc(Q.P,Q.Y);
    S:=DTGetBarTree(Q,Q.P,PC);
    If(PC=NIL)Then Begin
     Q.Y:=OldY;Q.P:=OldP;
    End
     Else
    Begin
     If(OldY=Q.Y)and(OldP=Q.P)Then Begin
      If LastMouseB=2Then Begin
       If(@Q.OnContextMenu<>NIL)and(Q.OnContextMenu(Q,Q.Context^))Then Begin
        DTRefresh(Q);
       End;
      End
       Else
      Goto Enter;
     End;
     DTPutBarTree(Q,OldY,OldP);
     DTPutBarTree(Q,Q.Y,Q.P);
    End;
   End;
   kbUp:DTkUp(Q);
   kbDn:DTkDn(Q);
   kbRBarMsDn:Begin
    __HideMousePtr;
    DTkDn(Q);
    DelayMousePress(100);
    __ShowMousePtr;
   End;
   kbRBarMsUp:Begin
    __HideMousePtr;
    DTkUp(Q);
    DelayMousePress(100);
    __ShowMousePtr;
   End;
   kbHome:Begin
    Q.Y:=0;Q.P:=0;
    DTRefresh(Q);
   End;
   kbEnd:DTkEnd(Q);
   kbEnter:Begin
Enter:
    If(@Q.OnEnter<>NIL)and(Q.OnEnter(Q,Q.Context^))Then Begin
     DTRefresh(Q);
    End
     Else
    Begin
     S:=DTGetBarTree(Q,Q.P,PC);
     If S<>''Then Begin
      DTSetDir(Q,DTGetLongDir(Q,Q.P),Pos('+',S)>0);
      DTRefresh(Q);
     End;
    End;
    If(dtEnterExit)in(Q.Option)Then Begin
     DTRun:=kbEnter;
     Break;
    End;
   End;
   Else Begin
    DTRun:=K;
    Break;
   End;
  End;
 Until False;
 __HideMousePtr;
End;

Function DTDone(Var Q:DialogTreeObject):Word;Begin
 ALDone(Q.Tree);
 DTDone:=0;
End;

Function SelectDirectory(Const Title,CurrPath:String;Input:Boolean):String;
Var
 W:Window;
 Q:DialogTreeObject;
 X,Y:Byte;
 T:TextBoxRec;
 G:GraphBoxRec;
 P:Byte;
 K:Word;
 InputString:String;
Begin
 SelectDirectory:='';
 WEInitO(W,40,20);
 WEPushWn(W);
 WEPutWnKrDials(W,Title);
 WECloseIcon(W);
 WEBar(W);
 X:=WEGetRX1(W);
 Y:=WEGetRY1(W);
 T.X1:=X+1;
 T.Y1:=Y+1+(Byte(Input)shl 1);
 T.X2:=X+W.MaxX-1;
 T.Y2:=Y+W.MaxY-3;
 DTInitBureau(Q,T.X1,T.Y1,T.X2,T.Y2);
 CoordTxt2Graph(T,G);
 Dec(G.X1);
 Dec(G.Y1);
 __GraphBoxRelief(G,0);
 DTChDir(Q,CurrPath);
 DTRefresh(Q);
 If(Input)Then WEBarSpcHorShade(W,0,1,37);
 WEPutkHorDn(W,'$Correcte|Annuler');
 P:=0;
 InputString:=CurrPath;
 Repeat
  Case(P)of
   0:If Not(Input)Then Begin
    K:=$FFFF;
    Inc(P);
   End
    Else
   Begin
    K:=WEInputString(W,0,1,37,255,InputString);
    If DirExist(InputString)Then Begin
     DTChDir(Q,InputString);
     DTRefresh(Q);
    End;
   End;
   1:Begin
    K:=DTRun(Q);
    InputString:=DTGetShortDir(Q,Q.P);
   End;
   2:K:=WEGetkHorDn(W,'$Correcte|Annuler');
  End;
  Case(K)of
   1,kbEsc,kbClose:Break;
   kbInWn,kbMouse,kbDataBar:If P=2Then P:=0
                                  Else Inc(P);
   kbTab:If P=2Then P:=0
               Else Inc(P);
   0:Begin
    SelectDirectory:=InputString;
    Break;
   End;
  End;
 Until False;
 DTDone(Q);
 WEDone(W);
End;

Function ConfigSystem(Const Title:String):Boolean;
Var
 W:Window;
 Q:DialogTreeObject;
 X,Y:Byte;
 T:TextBoxRec;
 G:GraphBoxRec;
 P:Byte;
 K:Word;
 InputString:String;
Begin
 ConfigSystem:=False;
 WEInitO(W,40,20);
 WEPushWn(W);
 WEPutWnKrDials(W,Title);
 WECloseIcon(W);
 WEBar(W);
 X:=WEGetRX1(W);
 Y:=WEGetRY1(W);
 T.X1:=X+1;
 T.Y1:=Y+1;
 T.X2:=X+W.MaxX-1;
 T.Y2:=Y+W.MaxY-3;
 DTInitSystem(Q,T.X1,T.Y1,T.X2,T.Y2);
 CoordTxt2Graph(T,G);
 Dec(G.X1);
 Dec(G.Y1);
 __GraphBoxRelief(G,0);
 DTRefresh(Q);
 WEPutkHorDn(W,'$Correcte|Annuler');
 P:=0;
 Repeat
  Case(P)of
   0:Begin
    K:=DTRun(Q);
    InputString:=DTGetShortDir(Q,Q.P);
   End;
   1:K:=WEGetkHorDn(W,'$Correcte|Annuler');
  End;
  Case(K)of
   1,kbEsc,kbClose:Break;
   kbInWn,kbMouse,kbDataBar:P:=P xor 1;
   kbTab:P:=P xor 1;
   0:Begin
    ConfigSystem:=True;
    Break;
   End;
  End;
 Until False;
 DTDone(Q);
 WEDone(W);
End;

Function ROReadElement(Var Q:DialogTreeObject;Var Reg:RegistryObject;Const Path:String;Pos:LongInt):Boolean;
Var
 Noeud:NoeudRec;
Begin
 ROReadElement:=False;
 _GetAbsRec(Reg.Handle,Pos,SizeOf(Noeud),Noeud);
 If(Noeud.Prev>0)and(Noeud.Prev<FileSize(Reg.Handle))Then ROReadElement:=ROReadElement(Q,Reg,Path,Noeud.Prev);
 DTMkDir(Q,Path+Noeud.Name);
 If(Noeud.Next>0)and(Noeud.Prev<FileSize(Reg.Handle))Then ROReadElement:=ROReadElement(Q,Reg,Path,Noeud.Next);
{ ROReadElement:=True;}
End;

Function ROGetRootKeyName(RootKey:Byte):String;Begin
 Case(RootKey)of
  HKEY_CLASSES_ROOT:ROGetRootKeyName:='HKEY_CLASSES_ROOT';
  HKEY_CURRENT_USER:ROGetRootKeyName:='HKEY_CURRENT_USER';
  HKEY_LOCAL_MACHINE:ROGetRootKeyName:='HKEY_LOCAL_MACHINE';
  HKEY_USERS:ROGetRootKeyName:='HKEY_USERS';
  HKEY_PERFORMANCE_DATA:ROGetRootKeyName:='HKEY_PERFORMANCE_DATA';
  HKEY_CURRENT_CONFIG:ROGetRootKeyName:='HKEY_CURRENT_CONFIG';
  HKEY_DYN_DATA:ROGetRootKeyName:='HKEY_DYN_DATA';
  HKEY_SYSTEM:ROGetRootKeyName:='HKEY_SYSTEM';
  HKEY_DEVELOPPER:ROGetRootKeyName:='HKEY_DEVELOPPER';
 End;
End;

Function ROGetRootKeyNumber(Const RootKeyName:String):Byte;
Var
 I:Byte;
Begin
 ROGetRootKeyNumber:=255;
 For I:=0to 15do Begin
  If CmpLeft(RootKeyName,ROGetRootKeyName(I))Then Begin
   ROGetRootKeyNumber:=I;
   Exit;
  End;
 End;
End;

Procedure DTMakeRegistryParent(Var Q:DialogTreeObject;Reg:RegistryObject;RootKey:Byte);
Var
 Dir:String;
 Info:SearchRegistryRec;
Begin
 Dir:='Poste de travail\'+ROGetRootKeyName(RootKey)+'\';
 DTMkDir(Q,Dir);
 DTSetEndShortName(Q,'MAINKEY');
 If ROFindFirst(Reg,RootKey,'',Info)Then Begin
  ROOpenMain(Reg);
  ROOpenFile(Reg);
  ROReadElement(Q,Reg,Dir,Info.Pos);
  DTSetDir(Q,Dir,False);
  RODone(Reg);
 End;
End;

Procedure DTMakeRegistrySubParent(Var Q:DialogTreeObject;Reg:RegistryObject;Const Dir:String;RootKey:Byte);
Var
 Info:SearchRegistryRec;
 Path:String;
Begin
 Path:=Copy(Dir,Length('Poste de travail\'+ROGetRootKeyName(RootKey)+'\')+1,255);
 If ROFindFirst(Reg,RootKey,Path,Info)Then Begin
  ROOpenMain(Reg);
  ROOpenFile(Reg);
  ROReadElement(Q,Reg,Dir,Info.Pos);
  DTSetDir(Q,Dir,True);
  RODone(Reg);
 End;
End;

Function DTOnEnterRegistry(Var Obj;Var Context):Boolean;
Var
 Q:DialogTreeObject Absolute Obj;
 PC:PDialogTreeElement;
 RootKey:Byte;
 Reg:RegistryObject;
 S:String;
Begin
 S:=DTGetBarTree(Q,Q.P,PC);
 If(PC<>NIL)Then Begin
  If(PC^.ShortName<>'MAINKEY')and(PC^.ShortName<>'')Then Begin
   ROOpenMain(Reg);
   S:=DTGetLongDir(Q,Q.P);
   DTSetDir(Q,DTGetLongDir(Q,Q.P),True);
   RootKey:=ROGetRootKeyNumber(DelStr(S,1,Length('Poste de travail\')));
   DTMakeRegistrySubParent(Q,Reg,S,RootKey);
   RODone(Reg);
  End
   Else
  Begin
   DTSetDir(Q,DTGetLongDir(Q,Q.P),Pos('+',S)>0);
   DTRefresh(Q);
  End;
 End;
 DTOnEnterRegistry:=True;
End;

Procedure DTInitRegistry(Var Q:DialogTreeObject;X1,Y1,X2,Y2:Byte);
Var
 Reg:RegistryObject;
Begin
 ROOpenMain(Reg);
 DTInit(Q,X1,Y1,X2,Y2);
 _DTMkDir(Q,'Poste de travail\',$F006);
 DTSetEndShortName(Q,'');
 DTMakeRegistryParent(Q,Reg,HKEY_CLASSES_ROOT);
 DTMakeRegistryParent(Q,Reg,HKEY_CURRENT_USER);
 DTMakeRegistryParent(Q,Reg,HKEY_LOCAL_MACHINE);
 DTMakeRegistryParent(Q,Reg,HKEY_USERS);
 DTMakeRegistryParent(Q,Reg,HKEY_PERFORMANCE_DATA);
 DTMakeRegistryParent(Q,Reg,HKEY_CURRENT_CONFIG);
 DTMakeRegistryParent(Q,Reg,HKEY_DYN_DATA);
 DTMakeRegistryParent(Q,Reg,HKEY_SYSTEM);
 DTMakeRegistryParent(Q,Reg,HKEY_DEVELOPPER);
 RODone(Reg);
 Q.OnEnter:=DTOnEnterRegistry;
End;

Procedure RegistryEditor;
Var
 W:Window;
 Q:DialogTreeObject;
 X,Y:Byte;
 T:TextBoxRec;
 G:GraphBoxRec;
 P:Byte;
 K:Word;
 InputString:String;
Begin
 WEInitO(W,40,20);
 WEPushWn(W);
 WEPutWnKrDials(W,'Base de registres');
 WECloseIcon(W);
 WEBar(W);
 X:=WEGetRX1(W);
 Y:=WEGetRY1(W);
 T.X1:=X+1;
 T.Y1:=Y+1;
 T.X2:=X+W.MaxX-1;
 T.Y2:=Y+W.MaxY-3;
 DTInitRegistry(Q,T.X1,T.Y1,T.X2,T.Y2);
 CoordTxt2Graph(T,G);
 Dec(G.X1);
 Dec(G.Y1);
 __GraphBoxRelief(G,0);
 DTRefresh(Q);
 WEPutkHorDn(W,'$Correcte|Annuler');
 P:=0;
 Repeat
  Case(P)of
   0:Begin
    K:=DTRun(Q);
    InputString:=DTGetShortDir(Q,Q.P);
   End;
   1:K:=WEGetkHorDn(W,'$Correcte|Annuler');
  End;
  Case(K)of
   1,kbEsc,kbClose:Break;
   kbInWn,kbMouse,kbDataBar:P:=P xor 1;
   kbTab:P:=P xor 1;
   0:Begin
    Break;
   End;
  End;
 Until False;
 DTDone(Q);
 WEDone(W);
End;


Procedure DTLoadTreeSystem(Var T:DialogTreeObject;Var Context);Begin
 DTLoadSystem(T);
End;

Function FullConfigSystem:Boolean;
Var
 FormConfigSystem:Record
  Tree:MTree;
  Memory:String[20];
  PourRessource:String[12];
  MemoryVirtual:String[10];
 End;
 Free,Total:LongInt;
Begin
 FullConfigSystem:=False;
 FillClr(FormConfigSystem,SizeOf(FormConfigSystem));
 FormConfigSystem.Tree.LoadTree:=DTLoadTreeSystem;
 FormConfigSystem.Memory:=WordToStr(MemTotalSize)+' Ko';
 Free:=AppResFree(rmAllRes);
 Total:=AppResSize(rmAllRes);
 If Total>0Then FormConfigSystem.PourRessource:=WordToStr(Trunc(Free/Total*100))+'% libre';
 If(Up32Bits)Then FormConfigSystem.MemoryVirtual:='32 bits'
             Else FormConfigSystem.MemoryVirtual:='16 bits';
 If ExecuteAppDPU(123,FormConfigSystem)Then Begin
  FullConfigSystem:=True;
 End;
End;

Procedure ManagerPeripheric;Begin
 FullConfigSystem;
End;

{ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ}
END.