{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                                                                         Û
 ³                    Malte Genesis/Outils de disque                       Û
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

  Cette unit‚ permet de faire effectuer … l'utilisateur toutes sortes
 d'op‚ration disque.
}

Unit ToolDsk;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                   INTERFACE
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

{$I DEF.INC}
Uses
 Systex,Isatex,Dialex;

Procedure AppCopyDiskToFile;
Procedure AppDiskCopy;
Procedure AppMapFAT;
Procedure CleanCurrDisk;
Procedure CleanDisk(Dsk:Byte);
Procedure CopyDiskToFile(Dsk:Byte;Const FileName:String);
Procedure CopyFileToDisk(Const FileName:String;Dsk:Byte);
Procedure DiskCopy(DskSource,DskTarget:Byte);
Procedure MapFAT(Dsk:Byte);
Procedure Format;
Function  GetFileInfo(Drive:Char;Var Info:FileInfoType;Var Size,NB:Word):Pointer;
Function  PMAChangedDisk(Var Q:PartitionManagerApp;Disk:Byte):Boolean;
Function  PMADone(Var Context):Word;
Function  PMAInit(Var Context;X1,Y1,X2,Y2:Byte):Boolean;
Procedure PMAOpen(Var Context;X1,Y1,X2,Y2:Byte;Const Path:String);
Procedure PMARefresh(Var Context);
Procedure PMAReSize(Var Context;X1,Y1,X2,Y2:Byte);
Function  PMARun(Var Context):Word;
Function  PMATitle(Var Context;Max:Byte):String;
Function  RenameDiskName(Dsk:Byte):String;
Procedure ViewPartition;
Function  WSFInit4Search(Var QX;X1,Y1,X2,Y2:Byte):Bool;
Procedure WSFMove2(Var QX;X,Y:Byte);
Procedure WSFRefresh(Var QX);
Procedure WSFSearchNames(Var QX);
Procedure WSFReSize(Var QX;X1,Y1,X2,Y2:Byte);
Function  WSFRun(Var QX):Word;
Function  WSFTitle(Var QX;Max:Byte):String;
Function  WSFDone(Var QX):Word;
Procedure __HardDiskPark;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                               IMPLEMENTATION
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

{$F-}

Uses
 Adele,Math,SysInter,
 {$IFDEF Windows}
  WinProcs,WinTypes,
 {$ENDIF}
 Volumex,Memories,Systems,Video,Terminal,Mouse,Dials,FileMana,
 QHexView,DialPlus,ResTex,Disk,ResServD;

Type
 FormatDPU69=Record
  UnitFormat:Word;
  LoadUnitFormat:Procedure(Var L:LstMnu;Var Context);
  OnMoveUnitFormat:Procedure(Var L:LstMnu;Var Context);
  ContextUnitFormat:Pointer;
  UnitDrive:Word;
  LoadUnitDrive:Procedure(Var L:LstMnu;Var Context);
  OnMoveUnitDrive:Procedure(Var L:LstMnu;Var Context);
  ContextUnitDrive:Pointer;
  Verify:Boolean;
  Resume:Boolean;
 End;

{$I \Source\Chantal\Library\DskReset.Inc}
{$I \Source\Chantal\Library\Intr.Inc}

Procedure LoadUnitDrive(Var L:LstMnu;Var Context);Far;
Var
 I:Byte; { Compteur de boucle }
Begin
 For I:=0to 25do Begin
  If(DiskExist(I)and(Not DiskFixed(I+1)))and
    (Not IsCDROM(I))Then ALAddStrByte(L.List,Char(I+65)+':',I+1);
 End;
End;

Procedure LoadUnitFormat(Var L:LstMnu;Var Context);Far;
Var
 Data:FormatDPU69 Absolute Context;
Begin
 ALAddStrWord(L.List,'360 Ko',360);
 ALAddStrWord(L.List,'720 Ko',720);
 ALAddStrWord(L.List,'1,2 Mo',1200);
 ALAddStrWord(L.List,'1,44 Mo',1440);
End;

{Procedure OnMoveUnitDrive(Var L:LstMnu;Var Context);Far;
Var
 Data:FormatDPU69 Absolute Context;
 Pos:Word;
Begin
 Case GetFloppyDrvType(0)of
  0:Pos:=360;
  1:Pos:=720;
  2:Pos:=1200;
  Else Pos:=1440;
 End;
 LMGotoPos(L,Pos);
End;}

{Initialise l'unit‚ de disquette}
Procedure InitDsk(Drive:Byte;PData:PhysDataType);Var _CH,_CL:Byte;Begin
 _CH:=PData.Tracks-1;
 _CL:=PData.Sec;
 ASM
  MOV AH,18h
  MOV CL,_CL
  MOV CH,_CH
  MOV DL,Drive
  INT 13h
 END;
End;

{Formatage d'une piste}
Function FormatTrack(Drv,Face,Track,Nm:Byte):Byte;
Type
 FormatTyp=Record
  DTrack,DFace,DI,DLen:Byte;
 End;
Var
 Regs:Registers;
 AreaData:Array[1..18]of FormatTyp;
 I,_Try:Byte;
Begin
 For I:=1to Nm do
 With AreaData[I]do Begin
  DTrack:=Track;
  DFace:=Face;
  DI:=I;
  DLen:=2;
 End;
 _Try:=dTryMax;
 Repeat
  With Regs do Begin
   ah:=5;
   al:=Nm;
   {$IFNDEF FLAT386}
    es:=Seg(AreaData);
    bx:=Ofs(AreaData);
   {$ENDIF}
   dh:=Face;
   dl:=Drv;
   ch:=Track;
  End;
  Intr($13,Regs);
  If Regs.flags and fcarry=1Then DskReset;
  Dec(_Try);
 Until(Regs.flags and fcarry=0)or(_Try=0);
 Formattrack:=Regs.ah;
End;

{V‚rification d'une piste}
Function VerifyTrack(Lecteur,Face,Piste,Secteurs:Byte):Byte;
Var
 _Try:Byte;
 Regs:Registers;
 TamponPiste:TrackBufType;
Begin
 _Try:=dTryMax;
 Repeat
  With Regs do
  Begin
   ah:=$04;              { Num‚ro de fonction pour appel interruption }
   al:=Secteurs;         { Nombre Secteurs par Piste }
   ch:=Piste;            { Num‚ro de Piste }
   cl:=1;                { Commencer par le secteur 1 }
   dl:=Lecteur;          { Num‚ro de lecteur }
   dh:=Face;             { Num‚ro de la face }
   {$IFNDEF FLAT386}
    es:=Seg(TamponPiste);{ Adresse du tampon }
    bx:=Ofs(TamponPiste);
   {$ENDIF}
  End;
  Intr($13,Regs);
  If Regs.flags and fcarry=1Then DskReset;
  Dec(_Try);
 Until(Regs.flags and fcarry=0)or(_Try=0);
 VerifyTrack:=Regs.ah;
End;

{Lecture d'une piste}
Function ReadTrack(Lecteur,Face,Piste,Start,Nombre:Byte;Var Buffer):Byte;
Var
 Essais:Byte;
 Regs:Registers;
Begin
 essais:=dTryMax;
 Repeat
  With Regs do Begin
   ah:=$02;        { Num‚ro de fonction pour appel interruption }
   al:=Nombre;     { Nombre Secteurs par Piste }
   ch:=Piste;      { Num‚ro de Piste }
   cl:=Start;      { Commencer par le secteur 1 }
   dl:=Lecteur;    { Num‚ro de lecteur }
   dh:=Face;       { Num‚ro de la face }
   {$IFNDEF FLAT386}
    es:=Seg(Buffer);{ Adresse pour tampon }
    bx:=Ofs(Buffer);
   {$ENDIF}
  End;
  Intr($13,Regs);
  If Regs.flags and fcarry=1Then DskReset;
  Dec(essais);
 Until(Regs.flags and fcarry=0)or(Essais=0);
 ReadTrack:=Regs.ah;
End;

{criture d'une piste}
Function WriteTrack(Lecteur,Face,Piste,Start,Nombre:Byte;Var Buffer):Byte;
Var
 Essais:Byte;
 Regs:Registers;
Begin
 essais:=dTryMax;
 Repeat
  With Regs do Begin
   ah:=$03;        { Num‚ro de fonction pour appel interruption }
   al:=Nombre;     { Nombre Secteurs par Piste }
   ch:=Piste;      { Num‚ro de Piste }
   cl:=Start;      { Commencer par le secteur 1 }
   dl:=Lecteur;    { Num‚ro de lecteur }
   dh:=Face;       { Num‚ro de la face }
   {$IFNDEF FLAT386}
    es:=Seg(Buffer);{ Adresse pour tampon }
    bx:=Ofs(Buffer);
   {$ENDIF}
  End;
  Intr($13,Regs);
  If Regs.flags and fcarry=1Then DskReset;
  Dec(essais);
 Until(Regs.flags and fcarry=0)or(Essais=0);
 WriteTrack:=Regs.ah;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Proc‚dure Format                            Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure offre … l'utilisateur de formater une unit‚ de disquette
 utilisable par un systŠme d'exploitation comme ®DOS¯,  ®OS/2¯ ou ®Windows
 95¯, c'est-…-dire utilisant une FAT.
}

Procedure Format;
Var
 AktDrv:Byte;         { Num‚ro du lecteur … formater 0, 1 }
 AktDrvType:Byte;     { Type du lecteur de disquettes courant }
 PData:PhysDataType;  { Informations physiques de formatage }
 LData:LogDataType;   { Informations logiques de formatage }
 AncDDPT:Pointer;     { Pointeur sur ancien DDPT }
 Ok:Boolean;          { Drapeau pour ex‚cution du programme }
 EndCode:Word;        { Valeur retourn‚e au process appel‚ }
 SerialNumber:LongInt;{ Num‚ro de s‚rie du volume }
 NumSector:LongInt;   { Nombre de secteur }
 SectorPerCluster:Byte;{Secteur par unit‚ d'allocation}
 K:Word;
 Verify:Boolean;      { V‚rifie chaque piste formater }
 Resume:Boolean;      { Afficher le r‚sum‚ … la fin }
 W,LW:Window;

 {D‚finition des paramŠtres du formatage}
 Function Get4matParam(S:Wd;DrvType:Byte;Var PData:PhysDataType;Var LData:LogDataType):Bool;
 Const
  DDPT360:DdptType=($DF,$02,$25,$02,$09,$2A,$FF,$50,$F6,$0F,$08);
  DDPT1200:DdptType=($DF,$02,$25,$02,$0F,$1B,$FF,$54,$F6,$0F,$08);
  DDPT720:DdptType=($DF,$02,$25,$02,$09,$2A,$FF,$50,$F6,$0F,$08);
  DDPT1440:DdptType=($DF,$02,$25,$02,$12,$1B,$FF,$6C,$F6,$0F,$08);
  LOG360:LogDataType=(Media:$FD;Cluster:2;FAT:2;RootSize:$70);
  LOG1200:LogDataType=(Media:$F9;Cluster:1;FAT:7;RootSize:$E0);
  LOG720:LogDataType=(Media:$F9;Cluster:2;FAT:3;RootSize:$70);
  LOG1440:LogDataType=(Media:$F0;Cluster:1;FAT:9;RootSize:$E0);
  PHYS360:PhysDataType=(Faces:2;Tracks:40;Sec:9;DDPT:@DDPT360);
  PHYS1200:PhysDataType=(Faces:2;Tracks:80;Sec:15; DDPT:@DDPT1200);
  PHYS1440:PhysDataType=(Faces:2;Tracks:80;Sec:18; DDPT:@DDPT1440);
  PHYS720:PhysDataType=(Faces:2;Tracks:80;Sec:9;DDPT:@DDPT720);
 Begin
  Get4matParam:=True;
  If S=1200Then
   If(DrvType=dtHD525)Then Begin
    PData:=PHYS1200;
    LData:=LOG1200;
   End
    Else
   Get4matParam:=False
   Else
  If S=360Then
   If(DrvType=dtHD525)or(DrvType=dtDD525)Then Begin
    PData:=PHYS360;
    LData:=LOG360;
   End
    Else
   Get4matParam:=False
   Else
  If S=1440Then
   If(DrvType=dtHD35)Then Begin
    PData:=PHYS1440;
    LData:=LOG1440;
   End
    Else
   Get4matParam:=False
   Else
  If S=720Then Begin
 {  If StrUp(ParamStr(3))='/F'Then} Begin
   PData:=PHYS720;
   LData:=LOG720;
  End
   {Else
   If(DrvType=dtHD35)or(DrvType=dtDD35)Then Begin PData:=PHYS720; LData:=LOG720; End
				       Else Get4matParam:=No}
  End
   Else
  Get4matParam:=False;
 End;

 {Formatage physique}
 Function Phys4mat(Drv:Byte;PData:PhysDataType):Boolean;
 Var
  _Try,T,F,Status,Pour:Byte;
  Q:BarProgress;
 Begin
  BPInit(Q,0,3,W);
  WESetKrBorder(W);
  For T:=0to PData.Tracks-1do For F:=0to PData.Faces-1do Begin
   If(T=0)and(F=0)Then Pour:=0
    Else
   Begin
    Pour:=Long((T*PData.Faces+F)*100)div Long(PData.Tracks*PData.Faces);
   End;
   BPProgress(Q,Pour);
   WESetKrBorder(W);
   WEPutTxtXY(W,0,1,'Piste: '+Str2(T,2)+'  Face: '+Str2(F,2));
   _Try:=dTryMax;
   Repeat
    Status:=FormatTrack(Drv,F,T,PData.Sec);
    If Status=3Then Begin
     Phys4mat:=False;
     ErrNoMsgOk(errDiskWriteProtect);
     Exit;
    End;
    If(Status=0)and Verify Then
    Status:=VerifyTrack(Drv,F,T,PData.Sec);
    Dec(_Try);
    If Status>0Then DskReset;
   Until(Status=0)or(_Try=0);
   If Status>0Then Begin
    Phys4mat:=False;
    ErrNoMsgOk(errTrack);
    Exit;
   End;
  End;
  Phys4mat:=True;
 End;

 {Formatage logique}
 Function Logical4mat(Drive:Byte;PData:PhysDataType;LData:LogDataType):Boolean;
 Var
  Status:Byte;
  I,AktSec,AktSide,AktTrack:Byte;
  Nm:Integer;
  TrackBuf:TrackBufType;
  Boot:BootRec Absolute TrackBuf;
 Begin
  FillClr(TrackBuf,Word(PData.Sec)*512);{Vide tampon}
   { Secteur de boot: Partie fixe }
  StrPCopy(@TrackBuf,
    #$EB#$35+              { 0000   JMP 0037        }
    Char(ciNOP)+           { 0002   NOP             }
  {-- Donn‚es des BPB --------------------------------}
    #$50#$43#$2D#$4D#$41#$4C#$54#$45+
    #$00#$00#$00#$01#$00#$00#$00#$00+
    #$00#$00#$00#$00#$00#$00#$00#$00+
    #$00#$00#$00#$00#$00#$00#$00#$00+
    #$00#$00#$00#$00#$00#$00#$00#$00+
    #$00#$00#$00#$00#$00#$00#$00#$00+
    #$00#$00#$00#$00+
  {-- Programme de chargement ----------------------}
    Char(ciCLI)+           { 0037   CLI             }
    #$B8#$30#$00+          { 0038   MOV     AX,0030 }
    #$8E#$D0+              { 003B   MOV     SS,AX   }
    #$BC#$FC#$00+          { 003D   MOV     SP,00FC }
    Char(ciSTI)+           { 0040   STI             }
    Char(ciPushCS)+        { 0041   PUSH    CS      }
    Char(ciPopDS)+         { 0042   POP     DS      }
    #$BE#$66#$7C+          { 0043   MOV     SI,7C66 }
    #$B4#$0E+              { 0046   MOV     AH,0E   }
    Char(ciCLD)+           { 0048   CLD             }
    Char(ciLODSB)+         { 0049   LODSB           }
    #$0A#$C0+              { 004A   OR      AL,AL   }
    #$74#$04+              { 004C   JZ      0052    }
    Char(ciInt)+#$10+      { 004E   INT     10      }
    #$EB#$F7+              { 0050   JMP     0049    }
    #$B4#$01+              { 0052   MOV     AH,01   }
    Char(ciInt)+#$16+      { 0054   INT     16      }
    #$74#$06+              { 0056   JZ      005E    }
    #$B4#$00+              { 0058   MOV     AH,00   }
    Char(ciInt)+#$16+      { 005A   INT     16      }
    #$EB#$F4+              { 005C   JMP     0052    }
    #$B4#$00+              { 005E   MOV     AH,00   }
    Char(ciInt)+#$16+      { 0060   INT     16      }
    #$33#$D2+              { 0062   XOR     DX,DX   }
    Char(ciInt)+#$19       { 0064   INT     19      });
  StrPCopy(@TrackBuf[1,102],#13#10'4MAT - (C) Les Chevaliers de Malte'#13#10+
           #13#10'Disquette non systŠme ou d‚fectueuse!'#13#10+
           'Veuillez changer de disquette et taper une touche'#13#10);
  TrackBuf[1,510]:=$55;
  TrackBuf[1,511]:=$AA;
   { Secteur de boot: Partie variable }
  NumSector:=PData.Tracks*PData.Sec*Pdata.Faces;
  Boot.BytesPerSec:=512;          { Nombre d'octets par secteur }
  SectorPerCluster:=LData.Cluster;
  TrackBuf[1,13]:=LData.Cluster;  { Longueur Cluster }
  TrackBuf[1,16]:=2;              { Nombre de FATs }
  TrackBuf[1,17]:=LData.RootSize; { Nombre d'entr‚es des r‚pertoires racine }
  Boot.NmTotSec:=NumSector;       { Nombre total de secteur sur la disquette }
  TrackBuf[1,21]:=LData.Media;    { descripteur support }
  TrackBuf[1,22]:=LData.FAT;      { Longueur des FAT }
  TrackBuf[1,24]:=PData.Sec;      { Secteurs par piste }
  TrackBuf[1,26]:=PData.Faces;    { Nombre de faces }
  Boot.HughNmSec:=NumSector;      { Nombre total de secteur sur la disquette }
  LongRec(SerialNumber).Lo:=Random(65535);
  LongRec(SerialNumber).Hi:=Random(65535);
  Boot.SerialNm:=SerialNumber;
  Dec(NumSector,(LData.FAT shl 1)+(LData.RootSize shr 4)+1);
   { Cr‚er FAT et sa copie (contient 00) }
  TrackBuf[2,0]:=LData.Media;
  TrackBuf[2,1]:=$FF;
  TrackBuf[2,2]:=$FF;
  TrackBuf[LData.FAT+2,0]:=LData.Media;
  TrackBuf[LData.FAT+2,1]:=$FF;
  TrackBuf[LData.FAT+2,2]:=$FF;
  Status:=WriteTrack(Drive,0,0,1,PData.Sec,TrackBuf);
  If Status<>0Then Logical4mat:=False
   else
  Begin
   FillClr(TrackBuf,512);
   AktSec:=PData.Sec;
   AktTrack:=0;
   AktSide:=0;
   Nm:=LData.FAT*2+(LData.Rootsize*32div 512)+1-PData.Sec; I:=1;
   Repeat
    Inc(AktSec);
    If(AktSec>PData.Sec)Then Begin
     AktSec:=1;
     Inc(AktSide);
     If(AktSide=PData.Faces)Then Begin
      AktSide:=0;
      Inc(AktTrack);
     End;
    End;
    Status:=WriteTrack(Drive,AktSide,AktTrack,AktSec,1,TrackBuf);
    Inc(i);
   Until(i>Nm)or(Status<>0);
   Logical4mat:=Status=0;
  End;
 End;

 {BoŒte de dialogue de l'‚tat du formatage}
 Function WinHeader:Word;
 Var
  Data:FormatDPU69;
 Begin
  WinHeader:=$FFFF;
  FillClr(Data,SizeOf(Data));
  Data.Verify:=True;
  Data.Resume:=True;
  Data.LoadUnitFormat:=LoadUnitFormat;
  Data.LoadUnitDrive:=LoadUnitDrive;
{  Data.ContextUnitDrive:=@Data;
  Data.OnMoveUnitDrive:=OnMoveUnitDrive;}
  If ExecuteAppDPU(69,Data)Then Begin
   AktDrv:=Data.UnitDrive;
   WinHeader:=Data.UnitFormat;
   Verify:=Data.Verify;
   Resume:=Data.Resume;
  End;
 End;

 Procedure Status;
 Var
  Form:Record
   Size:String[20];
   UsedSys:String[20];
   DefSize:String[20];
   Free:String[20];
   Sector:String[10];
   Cluster:String[20];
   Serial:String[15];
  End;
 Begin
  If(Resume)Then Begin
   FillClr(Form,SizeOf(Form));
   Form.Size:=CStr(NumSector*512);
   Form.Size:=Spc(20-Length(Form.Size))+Form.Size;
   Form.UsedSys:=CStr(0);
   Form.UsedSys:=Spc(20-Length(Form.UsedSys))+Form.UsedSys;
   Form.DefSize:=CStr(0);
   Form.DefSize:=Spc(20-Length(Form.DefSize))+Form.DefSize;
   Form.Free:=Form.Size;
   Form.Sector:=WordToStr(512);
   Form.Sector:=Spc(10-Length(Form.Sector))+Form.Sector;
   If SectorPerCluster=0Then Form.Cluster:='0'
   Else Form.Cluster:=CStr(NumSector div SectorPerCluster);
   Form.Cluster:=Spc(20-Length(Form.Cluster))+Form.Cluster;
   Form.Serial:=_GetSerialNmStr(SerialNumber);
   Form.Serial:=Spc(15-Length(Form.Serial))+Form.Serial;
   ExecuteAppDPU(65,Form);
  End;
 End;

Begin
 WEPushEndBar(LW);
 K:=WinHeader;
 If K<>$FFFFThen
 If(WarningMsgYesNo('Cette op‚ration d‚truira toutes informations '+
                    'sur la disquette s''il y en existe! D‚sirez-vous '+
                    'continuer de toute fa‡on?')<>kbYes)Then K:=$FFFF;
 Dec(AktDrv);
 If K=$FFFFThen Begin
  WEDone(LW);
  Exit;
 End;
 AktDrvType:=GetFloppyDrvType(AktDrv);
 If AktDrvType>0Then Begin
  If Get4matParam(K,AktDrvType,PData,LData)Then Begin
   InitDsk(AktDrv,PData);
   GetIntVec($1E,AncDDPT);
   SetIntVec($1E,PData.DDPT);
   WEInitO(W,30,6);
   WEPushWn(W);
   WEPutWnKrDials(W,'Formatage');
   WEBar(W);
   Ok:=Phys4mat(AktDrv,PData);
   If(Ok)Then Begin
    WEPutLastBar('criture du secteur de d‚marrage et des FATs');
    Ok:=Logical4mat(AktDrv,PData,LData)
   End;
   If(Ok)Then WEPutLastBar('Formatage en cours...')
         Else ErrNoMsgOk(errFormat);
   SetIntVec($1E,AncDDPT);
   WEDone(W);
   Status;
  End
   else
  ErrNoMsgOk(errFormatIncompatible);
 End
  else
 ErrNoMsgOk(errInvalidUnitDisk);
 WEDone(LW);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Proc‚dure CopyFileToDisk                   Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de copier un fichier image disquette sur une
 v‚ritable disquette.
}

Procedure CopyFileToDisk(Const FileName:String;Dsk:Byte);
Var
 Handle:Hdl;
 CurrPos,FileSize:LongInt;
 W:Window;
 BP:BarProgress;
 Pour:Byte;
 Status:Byte;
 ID:Byte;
 CurrSec,CurrSide,CurrTrack:Byte;
 Buffer:Array[0..511]of Byte;
 Boot:BootRec;
Begin
 Handle:=FileOpen(FileName,fmRead);
 If(Handle<>errHdl)Then Begin
  WEInitO(W,40,6);
  WEPushWn(W);
  WEPutWnKrDials(W,'Copie le fichier … la disquette');
  WEBar(W);
  BPInit(BP,0,3,W);
  WESetKrBorder(W);
  SearchStartImageDisk(Handle,True,FileSize,CurrPos,ID);
  _GetAbsRec(Handle,CurrPos,SizeOf(Boot),Boot);
  CurrSec:=0;
  CurrTrack:=0;
  CurrSide:=0;
  Repeat
   If CurrPos=0Then Pour:=0
               Else Pour:=LongInt((CurrPos)*100)div LongInt(FileSize);
   BPProgress(BP,Pour);
   WESetKrBorder(W);
   WEPutTxtXY(W,0,1,'Piste: '+Str2(CurrTrack,2)+'  Face: '+Str2(CurrSide,2));
   _GetAbsRec(Handle,CurrPos,SizeOf(Buffer),Buffer);
   Inc(CurrPos,LongInt(512));
   Inc(CurrSec);
   If(CurrSec>=Boot.SecPerTrk)Then Begin
    CurrSec:=0;
    Inc(CurrSide);
    If(CurrSide=Boot.NmHeads)Then Begin
     CurrSide:=0;
     Inc(CurrTrack);
    End;
   End;
   Status:=WriteTrack(Dsk,CurrSide,CurrTrack,CurrSec,1,Buffer);
  Until(CurrPos>=FileSize)or(Status<>0);
  WEDone(W);
  FileClose(Handle);
 End;
End;

Procedure DiskCopy(DskSource,DskTarget:Byte);
Var
 NumTrack:Word;
 W:Window;
 BP1,BP2:BarProgress;
 Pour:Byte;
 I,Size,CurrPos:LongInt;
 NumSector:LongInt;
 CurrSec,CurrSide,CurrTrack:Byte;
 Status:Byte;
 Q:XInf;
 Buffer:Array[0..511]of Byte;
 Boot:BootRec;
Begin
 WEInitO(W,40,8);
 WEPushWn(W);
 WEPutWnKrDials(W,'Copieur de Disquette');
 WEBar(W);
 BPInit(BP1,0,3,W);
 BPInit(BP2,0,5,W);
 WESetKrBorder(W);
 Status:=ReadTrack(DskSource,0,0,1,1,Boot);
 If Boot.Media=$FDThen NumTrack:=40
                  Else NumTrack:=80;
 CurrSec:=0;
 CurrTrack:=0;
 CurrSide:=0;
 If(DskSource=DskTarget)Then Begin { Copie de disquette en utilisant le mˆme unit‚? }
  NumSector:=Mul2Word(Boot.SecPerTrk*Boot.NmHeads,NumTrack);
  Size:=512*NumSector;
  CurrPos:=0;
  If(XAllocMem(rmAllRes,Size,Q))Then Begin
   For I:=0To NumSector-1do Begin
    If CurrTrack=0Then Pour:=0
                  Else Pour:=LongInt((I)*100)div LongInt(NumSector);
    BPProgress(BP1,Pour);
    WESetKrBorder(W);
    WEPutTxtXY(W,0,1,'Piste: '+Str2(CurrTrack,2)+'  Face: '+Str2(CurrSide,2));
    Inc(CurrSec);
    If(CurrSec>=Boot.SecPerTrk)Then Begin
     CurrSec:=0;
     Inc(CurrSide);
     If(CurrSide=Boot.NmHeads)Then Begin
      CurrSide:=0;
      Inc(CurrTrack);
     End;
    End;
    Status:=ReadTrack(DskSource,CurrSide,CurrTrack,CurrSec,1,Buffer);
    XSetAbsRec(Q,CurrPos,SizeOf(Buffer),Buffer);
    Inc(CurrPos,LongInt(512));
    If Status<>0Then Break;
   End;
   If(WarningMsgYesNo('Ins‚rer la disquette destinataire et appuyer sur ®Oui¯ pour continuer.')=kbYes)Then Begin
    CurrPos:=0;
    CurrSec:=0;
    CurrTrack:=0;
    CurrSide:=0;
    For I:=0To NumSector-1do Begin
     If CurrTrack=0Then Pour:=0
                   Else Pour:=LongInt((I)*100)div LongInt(NumSector);
     WESetKrBorder(W);
     WEPutTxtXY(W,0,1,'Piste: '+Str2(CurrTrack,2)+'  Face: '+Str2(CurrSide,2));
     Inc(CurrSec);
     If(CurrSec>=Boot.SecPerTrk)Then Begin
      CurrSec:=0;
      Inc(CurrSide);
      If(CurrSide=Boot.NmHeads)Then Begin
       CurrSide:=0;
       Inc(CurrTrack);
      End;
     End;
     XGetAbsRec(Q,CurrPos,SizeOf(Buffer),Buffer);
     Inc(CurrPos,LongInt(512));
     BPProgress(BP2,Pour);
     Status:=WriteTrack(DskTarget,CurrSide,CurrTrack,CurrSec,1,Buffer);
     If Status<>0Then Break;
    End;
   End;
   XFreeMem(Q);
  End;
 End
  Else
 Begin
  For I:=0To NumTrack-1do Begin
   If CurrTrack=0Then Pour:=0
                 Else Pour:=LongInt((CurrTrack)*100)div LongInt(NumTrack);
   BPProgress(BP1,Pour);
   WESetKrBorder(W);
   WEPutTxtXY(W,0,1,'Piste: '+Str2(CurrTrack,2)+'  Face: '+Str2(CurrSide,2));
   Inc(CurrSec);
   If(CurrSec>=Boot.SecPerTrk)Then Begin
    CurrSec:=0;
    Inc(CurrSide);
    If(CurrSide=Boot.NmHeads)Then Begin
     CurrSide:=0;
     Inc(CurrTrack);
    End;
   End;
   Status:=ReadTrack(DskSource,CurrSide,CurrTrack,CurrSec,1,Buffer);
   BPProgress(BP2,Pour);
   Status:=WriteTrack(DskTarget,CurrSide,CurrTrack,CurrSec,1,Buffer);
   If Status<>0Then Break;
  End;
 End;
 WEDone(W);
End;

Procedure AppDiskCopy;
Var
 DiskCopyForm:Record
  UnitDriveSource:Word;
  LoadUnitDriveSource:Procedure(Var L:LstMnu;Var Context);
  OnMoveUnitDriveSource:Procedure(Var L:LstMnu;Var Context);
  ContextUnitDriveSource:Pointer;
  UnitDriveTarget:Word;
  LoadUnitDriveTarget:Procedure(Var L:LstMnu;Var Context);
  OnMoveUnitDriveTarget:Procedure(Var L:LstMnu;Var Context);
  ContextUnitDriveTarget:Pointer;
  Verify:Boolean;
  Resume:Boolean;
 End;
Begin
 FillClr(DiskCopyForm,SizeOf(DiskCopyForm));
 DiskCopyForm.Verify:=True;
 DiskCopyForm.Resume:=True;
 DiskCopyForm.LoadUnitDriveSource:=LoadUnitDrive;
 DiskCopyForm.LoadUnitDriveTarget:=LoadUnitDrive;
 If ExecuteAppDPU(158,DiskCopyForm)Then Begin
  If DiskCopyForm.UnitDriveSource>0Then Dec(DiskCopyForm.UnitDriveSource);
  If DiskCopyForm.UnitDriveTarget>0Then Dec(DiskCopyForm.UnitDriveTarget);
  If DiskCopyForm.UnitDriveTarget=255Then DiskCopyForm.UnitDriveTarget:=0;
  DiskCopy(DiskCopyForm.UnitDriveSource,DiskCopyForm.UnitDriveTarget);
  {Verify:=Data.Verify;
  Resume:=Data.Resume;}
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Proc‚dure CopyDiskToFile                   Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de copier un disque dans un fichier image disque.
}

Procedure CopyDiskToFile(Dsk:Byte;Const FileName:String);
Var
 Handle:Hdl;
 CurrPos,I:LongInt;
 Q:FileSystemObject;
 W:Window;
 BP:BarProgress;
 Pour:Byte;
 Buffer:Array[0..511]of Byte;
Begin
 Handle:=FileCreate(FileName);
 If(Handle<>errHdl)Then Begin
  WEInitO(W,40,6);
  WEPushWn(W);
  WEPutWnKrDials(W,'Copie le disque dans un fichier');
  WEBar(W);
  BPInit(BP,0,3,W);
  FSInit(Q);
  Q.Dsk:=Dsk;
  FSReadDsk(Q,0,1,Buffer);
  FSBootAnalysers(Q,Buffer);
  CurrPos:=0;
  For I:=0to Q.NumTotalSector-1do Begin
   If I=0Then Pour:=0
         Else Pour:=LongInt((I)*100)div LongInt(Q.NumTotalSector);
   BPProgress(BP,Pour);
   WESetKrBorder(W);
   WEPutTxtXY(W,0,1,'Secteur: '+IntToStr(I));
   FSReadDsk(Q,I,1,Buffer);
   _SetAbsRec(Handle,CurrPos,SizeOf(Buffer),Buffer);
   Inc(CurrPos,SizeOf(Buffer));
  End;
  FileClose(Handle);
  WEDone(W);
 End;
End;

Procedure AppCopyDiskToFile;
Var
 Drv:Byte;
 FileName:String;
Begin
 Drv:=SelectDisk(1);
 If Drv<>$FFThen Begin
  FileName:=OpenWin('*.IMA','Cr‚er une image disque');
  If FileName<>''Then CopyDiskToFile(Drv-1,FileName);
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Fonction HardDskPark                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction indique si l'op‚ration de stationnement des tˆtes de
 lecture d'une unit‚ de disque dur a ‚t‚ r‚ussi.
}

Function HardDskPark:Boolean;Near;Assembler;
Var
 D3,D4:Byte;
 Drive:Word;
ASM
 XOR CX,CX
 MOV Word Ptr D4,CX
 MOV AX,8000h
 MOV DX,AX
 XCHG DL,DH
 MOV Drive,DX
 INT 13h
 JC  @3
 CMP DL,0
 JE  @3
 MOV D3,DL
 CMP DL,2
 JBE @2
 MOV D3,2
@2:
 CALL @20
 INC Drive
 DEC D3
 JNZ @2
@3:
 TEST D4,80h
 JZ  @4
 MOV AL,True
 JMP @99
@4:
 MOV AL,False
 JMP @99
@20: { Procedure PosHardDsk(Drive:Word); }
 MOV AX,1100h
 XOR CX,CX
 MOV DX,Drive
 INT 13h
 JC  @7
 OR  D4,80h
 MOV AX,0C00h
 XOR CX,CX
 MOV DX,Drive
 PUSH DX
  INT 13h
 POP DX
 MOV AX,$800
 XOR CX,CX
 PUSH DX
  INT 13h
 POP DX
 MOV AX,0C00h
 INT 13h
@7:
 RETN
@99:
END;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Proc‚dure __HardDiskPark                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure offre … l'utilisateur de stationner les tˆtes de lectures
 des disques dur du systŠme.
}

Procedure __HardDiskPark;Begin
 If(HardDskPark)Then Begin
  DialogMsgOk('Disque(s) dur stationner avec succŠs. '+
   'Vous pouvez maintenant fermer l''ordinateur ou '+
   'continuer en pressant une touche.')
 End
  Else
 If(HardDskExist)Then ErrNoMsgOk(errParkHardDisk)
                 Else ErrNoMsgOk(errHardDiskNotFound)
End;

Procedure _WSFInit(Var Q:WinsSearchFiles;ListY:Byte;Center:Boolean;X1,Y1,X2,Y2:Byte);Begin
 FillClr(Q,SizeOf(Q));
 If(Center)Then WEInitO(Q.W,X1,Y1)
           Else WEInit(Q.W,X1,Y1,X2,Y2);
 Q.ListY:=ListY;
 LTInitWithWins(Q.LT,0,ListY,Q.W.MaxX,'Nom|Taille|Date',Q.W);
End;

Procedure WSFInit(Var Q:WinsSearchFiles;ListY:Byte);Begin
 _WSFInit(Q,ListY,True,76,22,0,0);
End;

Function WSFInit4Search(Var QX;X1,Y1,X2,Y2:Byte):Bool;
Var
 Q:WinsSearchFiles Absolute QX;
Begin
 _WSFInit(Q,5,False,X1,Y1,X2,Y2);
 Q.SearchMode:=True;
 Q.Drive:=#255;
 WSFInit4Search:=True;
 WSFRefresh(Q);
End;

Procedure WSFReSize{Var QX;X1,Y1,X2,Y2:Byte};
Var
 Q:WinsSearchFiles Absolute QX;
Begin
 WEDone(Q.W);
 WEInit(Q.W,X1,Y1,X2,Y2);
 WSFRefresh(Q);
End;

Procedure WSFMove2(Var QX;X,Y:Byte);
Var
 Q:WinsSearchFiles Absolute QX;
Begin
 WSFReSize(Q,X,Y,X+Q.W.T.X2-Q.W.T.X1,Y+Q.W.T.Y2-Q.W.T.Y1);
End;

Function WSFTitle(Var QX;Max:Byte):String;
Var Q:WinsSearchFiles Absolute QX;
Begin
 If(Q.SearchMode)Then WSFTitle:='Rechercher fichier(s) ou dossier(s)'
                 Else WSFTitle:='M‚nagŠre de disque';
End;

Procedure WSFPutStatusDrive(Var Q:WinsSearchFiles);
Var
 S:String;
Begin
 If(Q.SearchMode)Then Begin
  If Q.Drive=#255Then S:='Tous les unit‚s disponibles (A:,B:,C:,D:,...)'
                 Else S:=StrUSpc(Q.Drive+':',46);
  WESetKr(Q.W,$8F);
  WEPutTxtXY(Q.W,16,3,S);
  WESetKrBorder(Q.W);
  PutDownIcon(Q.W.T.X2-3-UpIconLen,WEGetRY1(Q.W)+3,
              CurrKrs.OpenWin.Window.Icon);
 End;
End;

Procedure WSFSetDrive(Var Q:WinsSearchFiles);
Var
 L:LstMnu;
 J:Char;
 K:Word;
Begin
 LMInitKrDials(L,WEGetRX1(Q.W)+16,WEGetRY1(Q.W)+4,Q.W.T.X2-3,MaxYTxts-3,
               'Choisir l''unit‚ de recherche');
 For J:='A'to 'Z'do If DrvExist(J)Then ALAddStrByte(L.List,J+':',Byte(J));
 ALAddStrByte(L.List,'Tous les unit‚s disponibles',255);
 K:=LMRun(L);
 If K<>0Then Q.Drive:=Chr(K);
 LMDone(L);
 WSFPutStatusDrive(Q);
End;

Function WSFPutLn(Var Q:WinsSearchFiles):Bool;
Var
 Size:Word;
Begin
 WSFPutLn:=False;
 If(Q.X=NIL)Then Exit;
 WESetKrBorder(Q.W);
 If Q.X^.H.Fill[1]=0Then Q.W.CurrColor:=Q.W.CurrColor and$F7;
 WEPutTxt(Q.W,StrUSpc(TruncName(Q.X^.S+Q.X^.H.Name,49),50));
 WEPutTxt(Q.W,StrUSpc(CStr(Q.X^.H.Size),10));
 WEPutTxt(Q.W,CStrDate(Q.X^.H.Time));
 WSFPutLn:=True
End;

Procedure WSFSelHor(Var Q:WinsSearchFiles);Begin
 WEBarSelHor(Q.W,0,Q.Y+1+Q.ListY,wnMax)
End;

Procedure WSFSelBar(Var Q:WinsSearchFiles);Begin
 WESetKrSel(Q.W);
 If Q.X^.H.Fill[1]=0Then Q.W.CurrColor:=Q.W.CurrColor and$F7;
 WSFSelHor(Q);
 WESelRightBarPos(Q.W,Q.P,Q.R.Count-2)
End;

Procedure WSFRefresh(Var QX);
Var
 Q:WinsSearchFiles Absolute QX;
 I:Word; { Compteur de boucle }
Begin
 WEPutWn(Q.W,WSFTitle(Q,Q.W.MaxX),CurrKrs.Dialog.Env.List);
 WECloseIcon(Q.W);
 If(Q.SearchMode)Then WEZoomIcon(Q.W);
 WESetEndBar(Q.W,CurrKrs.Desktop.DialStatus);
 LTSetColumnSize(Q.LT,0,49);
 LTSetColumnSize(Q.LT,1,9);
 LTRefresh(Q.LT);
 If(Q.SearchMode)and(Q.ListY>0)Then Begin
  WEClrWn(Q.W,0,0,wnMax,Q.ListY-1,CurrKrs.Dialog.Window.Border);
  WEBar(Q.W);
  WESetKr(Q.W,CurrKrs.Dialog.Window.Border);
  WEPutTxtXY(Q.W,1,1,'Nomm‚');
  WEPutTxtXY(Q.W,1,3,'Recherche dans');
  WESetKr(Q.W,$8F);
  Q.W.Palette.kShade:=CurrKrs.Dialog.Window.kShade;
  WEBarSpcHorShade(Q.W,16,1,Q.W.MaxX-4);
  WEPutTxtXY(Q.W,16,1,Q.SearchWildCard);
  WEBarSpcHorShade(Q.W,16,3,Q.W.MaxX-4);
  WSFPutStatusDrive(Q);
 End;
 If(IsGrf)Then Begin
  BarSpcHorRelief(Q.W.T.X1,Q.W.T.Y2,Q.W.T.X2,CurrKrs.Desktop.DialStatus);
  BarSpcHorReliefExt(Q.W.T.X1+1,Q.W.T.Y2,Q.W.T.X1+48,CurrKrs.Desktop.DialStatus);
  BarSpcHorReliefExt(Q.W.T.X1+50,Q.W.T.Y2,Q.W.T.X2-2,CurrKrs.Desktop.DialStatus);
  LuxeBox(Q.W.T.X2-1,Q.W.T.Y2);
 End
  Else
 WESetEndBarTxtX(Q.W,49,'³',CurrKrs.Desktop.DialStatus);
 WEPutBarMsRight(Q.W);
 WESetEndBarTxtX(Q.W,50,'0 octet(s)',CurrKrs.Desktop.DialStatus);
 If Q.R.Count>0Then Begin
  Q.W.X:=0;Q.W.Y:=1+Q.ListY;
  If(Q.Y>Q.P)Then Q.Y:=0;
  ALSetPtr(Q.R,Q.P-Q.Y);
  For I:=0to Q.R.Count-1do Begin
   Q.X:=_ALGetCurrBuf(Q.R);
   If(Q.X=NIL)Then Break;
   WSFPutLn(Q);
   WELn(Q.W);
   ALNext(Q.R);
   If(Q.W.Y>Q.W.MaxY)Then Break;
  End;
  ALSetPtr(Q.R,Q.P);
  Q.X:=_ALGetCurrBuf(Q.R);
  Q.W.Y:=1+Q.ListY+Q.Y;
  WSFSelBar(Q);
 End;
End;

Procedure WSFPutEolLn(Var Q:WinsSearchFiles);Begin
 If WSFPutLn(Q)Then Begin
  WEClrEol(Q.W);
  WELn(Q.W)
 End;
End;

Procedure WSFSearchNames(Var QX);
Label BreakSearch,Start,10,20;
Var
 Q:WinsSearchFiles Absolute QX;
 H:SearchRec;
 OldPath,Path,TmpName:String;
 Ptr:^TByte;
 Y:Byte;
 J:Char;
Begin
 ALInit(Q.R);
 Q.Total:=0;
 OldPath:=GetCurrentDir;
 J:=Q.Drive;
 If Q.Drive=#255Then J:='A';
 Path:=J+':\';Y:=1+Q.ListY;
 WEPutLastBar('Recherche des noms correspondants...');
Start:
 FindFirst(Path+'*.*',faAll,H);
10:
 WESetEndBarTxtX(Q.W,1,Left(StrUSpc(TruncName(Path,48),48),48),CurrKrs.Desktop.DialStatus);
 While SysErr=0do Begin
  If(KeyPress)and(ReadKey=kbEsc)Then Begin
   If(InputMsg('Attention','D‚sirez-vous interrompre le processus de recherche '+
               'avant d''avoir fouill‚e tous les r‚pertoires?',
               KeyYes+KeyNo,wfOctogone+wiExit,CurrKrs.WarningWin)=kbYes)Then Goto BreakSearch;
  End;
  If(sfaDir)in(H.Attr.Flags)Then Begin
   If(H.Name<>'.')and(H.Name<>'..')Then Begin
    If Length(Path)+Length(H.Name)+1<=255Then Begin
     AddStr(Path,H.Name+'\');
     Goto Start;
    End;
   End;
  End
   else
  If WildCardMatch(H.Name,Q.SearchWildCard)Then Begin
   Q.X:=ALAdd(Q.R,SizeOf(SearchRec)+Length(Path)+1);
   If(Q.X=NIL)Then Exit;
   MoveLeft(H,Q.X^,SizeOf(SearchRec));
   Ptr:=Pointer(Q.X);
   Ptr^[0]:=1;Inc(Q.Total,H.Size);
   MoveLeft(Path,Ptr^[SizeOf(SearchRec)],Length(Path)+1);
   Q.W.X:=0;Q.W.Y:=Y;
   If(Y<=Q.W.MaxY)Then Begin
    WSFPutLn(Q);
    Inc(Y);
   End
    Else
   Begin
    WEScrollDn(Q.W,0,Q.ListY+1,wnMax,wnMax);
    Q.W.Y:=Q.W.MaxY;Q.W.X:=0;
    WSFPutEolLn(Q);
   End;
   If(Q.SearchMode)Then
    WESetEndBarTxtX(Q.W,50,CStr(Q.R.Count)+' fichier(s)',CurrKrs.Desktop.DialStatus)
   Else
    WESetEndBarTxtX(Q.W,50,CStr(Q.Total)+' octet(s)',CurrKrs.Desktop.DialStatus);
  End;
  FindNext(H)
 End;
 If Length(Path)>3Then Begin
20:TmpName:='';
  BackStr(Path);
  While Path[Length(Path)]<>'\'do Begin
   TmpName:=Path[Length(Path)]+TmpName;
   BackStr(Path);
  End;
  FindFirst(Path+'*.*',faAll,H);
  If SysErr<>0Then Goto 20;
  While(H.Name<>TmpName)do Begin
   FindNext(H);
   If SysErr<>0Then Goto 20;
  End;
  FindNext(H);
  Goto 10
 End;
 If(J<Q.Drive)Then Begin
  Inc(J);
  If J<='Z'Then Begin
   Path:=J+':\';
   Goto Start;
  End;
 End;
BreakSearch:
 ChDir(OldPath);
End;

Procedure WSFSelBarInactive(Var Q:WinsSearchFiles);Begin
 Q.W.CurrColor:=$8F;
 WSFSelHor(Q);
End;

Procedure WSFUnSelBar(Var Q:WinsSearchFiles);Begin
 WESetKrBorder(Q.W);
 If Q.X^.H.Fill[1]=0Then Q.W.CurrColor:=Q.W.CurrColor and$F7;
 WSFSelHor(Q);
End;

Procedure WSFkHome(Var Q:WinsSearchFiles);Var I:Byte;Begin
 WEClrWnBorder(Q.W,0,1+Q.ListY,wnMax,wnMax);
 Q.W.X:=0;Q.W.Y:=1+Q.ListY;
 ALSetPtr(Q.R,0);
 For I:=0to Q.R.Count-1do Begin
  Q.X:=_ALGetCurrBuf(Q.R);
  If(Q.X=NIL)Then Break;
  WSFPutEolLn(Q);
  ALNext(Q.R);
  If(Q.W.Y>Q.W.MaxY)Then Break;
 End;
 ALSetPtr(Q.R,0);
 Q.P:=0;Q.Y:=0;
 WSFSelBar(Q);
End;

Procedure WSFkUp(Var Q:WinsSearchFiles);
Var
 Size:Word;
Begin
 If Q.P>0Then Begin
  WSFUnSelBar(Q);
  Dec(Q.P);
  ALPrevious(Q.R);
  Q.X:=_ALGetCurrBuf(Q.R);
  If Q.Y>0Then Dec(Q.Y)
   Else
  Begin
   Q.W.Y:=1+Q.ListY;
   WEScrollUp(Q.W,0,Q.W.Y,wnMax,wnMax);
   Q.W.X:=0;
   WSFPutEolLn(Q);
  End;
  WSFSelBar(Q);
 End;
End;

Procedure WSFkDn(Var Q:WinsSearchFiles);
Var
 Size:Word;
 L:Byte;
Begin
 If Q.P<Q.R.Count-1Then Begin
  WSFUnSelBar(Q);
  Inc(Q.P);L:=1+Q.ListY;
  ALNext(Q.R);
  Q.X:=_ALGetCurrBuf(Q.R);
  If(Q.Y<Q.W.MaxY-L)Then Inc(Q.Y)
   Else
  Begin
   WEScrollDn(Q.W,0,L,wnMax,wnMax);
   Q.W.Y:=Q.W.MaxY;Q.W.X:=0;
   WSFPutEolLn(Q);
  End;
  WSFSelBar(Q)
 End
End;

Function WSFRun(Var QX):Word;
Label MsAction;
Var
 Q:WinsSearchFiles Absolute QX;
 K:Word;
 TP,TY:Word;

 Procedure SelDrive;Begin
  WESetKr(Q.W,CurrKrs.OpenWin.Env.Input);
  WEBarSelHor(Q.W,16,3,Q.W.MaxX-4);
 End;

 Procedure UnSelDrive;Begin
  WESetKr(Q.W,$8F);
  WEBarSelHor(Q.W,16,3,Q.W.MaxX-4);
 End;

Begin
 Repeat
  Case(Q.Section)of
   0:Begin
    K:=WEInputString(Q.W,16,1,Q.W.MaxX-2,255,Q.SearchWildCard);
    Q.SearchWildCard:=StrUp(Q.SearchWildCard);
    Case(K)of
     kbTab,kbDn:Inc(Q.Section);
     kbShiftTab,kbUp:Q.Section:=2;
     kbInWn:If(LastMouseY>WEGetRY1(Q.W)+Q.ListY)Then Goto MsAction Else
            If LastMouseY>=WEGetRY1(Q.W)+3Then Begin
             Q.Section:=1;
             WaitMouseBut0;
            End;
     0,kbEnter:Begin
      WSFSearchNames(Q);
      WSFkHome(Q);
      Q.Section:=2;
     End;
     Else Begin
      WSFRun:=K;
      Exit;
     End;
    End;
   End;
   1:Begin
    SelDrive;
    K:=WEReadk(Q.W);
    Case(K)of
     kbTab:Inc(Q.Section);
     kbShiftTab,kbUp:Dec(Q.Section);
     kbEnter,kbDn:WSFSetDrive(Q);
     kbInWn:If(LastMouseY>WEGetRY1(Q.W)+Q.ListY)Then Begin
             UnSelDrive;
             Goto MsAction;
            End
             Else
            If LastMouseY<WEGetRY1(Q.W)+3Then Q.Section:=0 Else
            If(LastMouseY=WEGetRY1(Q.W)+3)Then
             WSFSetDrive(Q);
     Else If Chr(K)=' 'Then WSFSetDrive(Q)
      Else
     Begin
      WSFRun:=K;
      Exit;
     End;
    End;
    UnSelDrive;
   End;
   Else Begin
    K:=WEReadk(Q.W);
    Case(K)of
     kbTab:Q.Section:=0;
     kbShiftTab:Q.Section:=1;
     kbDn:WSFkDn(Q);
     kbUp:WSFkUp(Q);
     kbHome:WSFkHome(Q);
     kbInWn:If(LastMouseY>WEGetRY1(Q.W)+Q.ListY)Then Begin
MsAction:
      WaitMouseBut0;
      TP:=Q.P;TY:=Q.Y;
      Dec(TP,TY);
      TY:=LastMouseY-(WEGetRY1(Q.W)+Q.ListY+1);
      Inc(TP,TY);
      If(TP<>Q.P)Then Begin
       WSFUnSelBar(Q);
       Q.P:=TP;Q.Y:=TY;Q.W.Y:=Q.ListY+1+TY;
       ALSetPtr(Q.R,Q.P);
       Q.X:=_ALGetCurrBuf(Q.R);
       WSFSelBar(Q);
      End
       Else
      If LastMouseB=1Then Begin
       WSFRun:=kbEnter;
       Exit;
      End;
      If LastMouseB=2Then Begin
       K:=RunMenuApp(90);
       Case(K)of
        $F001:Begin
         WSFRun:=kbEnter;
         Exit;
        End;
        $F002:PushClipboardTxt(Q.X^.S+Q.X^.H.Name);
        kbMouse:WaitMouseBut0;
       End;
      End;
     End;
     Else Begin
      WSFRun:=K;
      Exit;
     End;
    End;
   End;
  End;
 Until False;
End;

Function WSFDone(Var QX):Word;
Var
 Q:WinsSearchFiles Absolute QX;
Begin
 WEDone(Q.W);
 ALDone(Q.R);
 WSFDone:=0;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Proc‚dure CleanDsk                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure offre … l'utilisateur de nettoyer un unit‚ sp‚cifique de
 ces copies de s‚curit‚ (.BAK).
}

Procedure CleanDisk(Dsk:Byte);
Var
 L:Window;
 I:Byte;
 Q:WinsSearchFiles;

 Procedure KillFile(Const Name:String;Const H:SearchRec);Begin
  WEPutLastBar('Efface le fichier '+Name);
  If(H.Attr.Value)and Not(faArchive)>0Then FileSetAttr(Name,faArchive);
  DeleteFile(Name);
 End;

Begin
 If Dsk=$FFThen Exit;
 WSFInit(Q,0);
 WEPushWn(Q.W);
 WSFRefresh(Q);
 WEPushEndBar(L);
 Q.SearchWildCard:='*.BAK;*.{*;*.~*';
 Q.Drive:=Chr(Dsk+64);
 WSFSearchNames(Q);
 If Q.R.Count>0Then Begin
  WEPutLastBar('^Ins^  Addition/soustrait un fichier de la liste  '+
               '^Enter^ Accepte  '+
               '^Esc^  Annuler');
  WSFkHome(Q);
  Repeat
   Case WEReadk(Q.W)of
    kbRBarMsUp:Begin
     WSFkUp(Q);
     DelayMousePress(100);
    End;
    kbRBarMsDn:Begin
     WSFkDn(Q);
     DelayMousePress(100);
    End;
    kbUp:WSFkUp(Q);
    kbDn:WSFkDn(Q);
    kbIns:Begin
     Q.X:=_ALGetBuf(Q.R,Q.P);
     Q.X^.H.Fill[1]:=Q.X^.H.Fill[1]xor 1;
     WSFkDn(Q);
    End;
    kbClose,kbEsc:Break;
    kbEnter:Begin
     ALSetPtr(Q.R,0);
     For I:=0to Q.R.Count-1do Begin
      Q.X:=_ALGetCurrBuf(Q.R);
      If(Q.X=NIL)Then Break;
      If Q.X^.H.Fill[1]=1Then KillFile(Q.X^.S+Q.X^.H.Name,Q.X^.H);
      ALNext(Q.R)
     End;
     Break;
    End;
   End;
  Until False;
 End
  Else
 ErrNoMsgOk(NoFileSelectFound);
 WEDone(L);
 WSFDone(Q);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Proc‚dure CleanCurrDisk                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure offre … l'utilisateur la possibilit‚ de nettoyer l'unit‚
 Courante de ces copies de s‚curit‚ (.BAK).
}

Procedure CleanCurrDisk;Begin
 CleanDisk(SelectDisk(GetDsk+1));
End;

{$I \Source\Chantal\Library\Disk\Bios\ReadPart.Inc}
{$I \Source\Chantal\Library\Disk\GIHD.Inc}

Function GetPartitionTypeName(PartTyp:Byte):String;
Var
 Data:Record
  ID:Byte;
  System:String;
 End;
Begin
 FillClr(Data,SizeOf(Data));
 If DBLocateAbs(ChantalServer,0,PartTyp,[])Then Begin
  DBReadRec(ChantalServer,Data);
  GetPartitionTypeName:=Data.System;
 End
  Else
 GetPartitionTypeName:='Inconnu';
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Proc‚dure WEPutPartition                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure interprŠte les donn‚es de partitions et les affichages
 dans une boŒte de dialogue classique.
}

Procedure PMAPutPartition(Var Q:PartitionManagerApp);
Var
 Tete,SectCyl:Byte;
 Entry,Secteur:Byte;
 Cylindre:Word;
 S:String;
 Data:Record
  ID:Byte;
  System:String;
 End;
Begin
 GetInfoHardDisk(Q.LC,Cylindre,Tete,Secteur);
 WEClrScr(Q.W);
 WEBar(Q.W);
 WELn(Q.W);
 If Not(Q.TechFlag)Then Begin
  LTInitWithWins(Q.LT1,0,3,Q.W.MaxX,'|||D‚but|Fin|Distance|Taille en',Q.W);
  LTInitWithWins(Q.LT2,0,4,Q.W.MaxX,'Nø|Boot|Type|Tˆte cyl. sec.|Tˆte cyl. sec.|BootSec.|KiloOctet(s)',Q.W);
 End
  Else
 Begin
  LTInitWithWins(Q.LT1,0,3,Q.W.MaxX,'|||D‚but|Fin|Distance|',Q.W);
  LTInitWithWins(Q.LT2,0,4,Q.W.MaxX,'Nø|Boot|Type|Tˆte cyl. sec.|Tˆte cyl. sec.|BootSec.|Nombre',Q.W);
 End;
 LTSetColumnSize(Q.LT1,0,2);
 LTSetColumnSize(Q.LT1,1,4);
 LTSetColumnSize(Q.LT1,2,19);
 LTSetColumnSize(Q.LT1,3,14);
 LTSetColumnSize(Q.LT1,4,14);
 LTSetColumnSize(Q.LT1,5,8);
 LTSetColumnSize(Q.LT2,0,2);
 LTSetColumnSize(Q.LT2,1,4);
 LTSetColumnSize(Q.LT2,2,19);
 LTSetColumnSize(Q.LT2,3,14);
 LTSetColumnSize(Q.LT2,4,14);
 LTSetColumnSize(Q.LT2,5,8);
 LTRefresh(Q.LT1);
 LTRefresh(Q.LT2);
 S:='';
 If Length(Q.FileName)=0Then S:='Lecteur '+CStr(Q.LC-$80)+': ';
 AddStr(S,CStr(Tete)+' tˆtes avec '+CStr(Cylindre)+' cylindres de '+
    CStr(Secteur)+' secteurs');
 WEPutTxtLn(Q.W,S);
 WEPutTxtLn(Q.W,'Table des partitions dans le secteur de partition');
 Q.W.Y:=5;
 DBOpenServerName(ChantalServer,'CHANTAL:/Disque/Partition.Dat');
 For Entry:=0to 3do { parcourt table des entr‚es }
  With Q.ParSec.PartTable[Entry]do Begin
  WEPutTxt(Q.W,' '+WordToStr(Entry)+' ');
  If Status=$80Then WEPutTxt(Q.W,'Oui ')
               Else WEPutTxt(Q.W,'Non ');
  WEPutTxt(Q.W,' ');
  If DBLocateAbs(ChantalServer,0,PartTyp,[])Then Begin
   DBReadRec(ChantalServer,Data);
   WEPutTxt(Q.W,Data.System);
  End
   Else
  WEPutTxt(Q.W,'Inconnu ('+HexByte2Str(PartTyp)+'h)');
  Q.W.X:=27;
  GetSectCyl(StartSec.SectCyl,Secteur,Cylindre);
  WEPutTxt(Q.W,' '+Str2(StartSec.Tete,2)+' '+Str2(Cylindre,5)+'  '+Str2(Secteur,3));
  GetSectCyl(EndSec.SectCyl,Secteur,Cylindre);
  WEPutTxt(Q.W,'  '+Str2(EndSec.Tete,3)+' '+Str2(Cylindre,5)+' '+Str2(Secteur,3));
  WEPutTxt(Q.W,'  '+Str2(SecOfs,8)+' ');
  If(Q.TechFlag)Then WEPutTxt(Q.W,Str2(NbreSec,7))
                Else WEPutTxt(Q.W,Str2(NbreSec shr 1,7));
  WELn(Q.W);
 End;
 If(Q.TechFlag)Then WEPutLastBar('^F4^ Regarde Hex  ^F10^ Regarde simplifi‚  ^Esc^ Quitter')
               Else WEPutLastBar('^F4^ Regarde Hex  ^F10^ Regarde technique  ^Esc^ Quitter');
End;

Function SizeKbToString(SizeK:LongInt):String;
Var
 S:String;
Begin
 If SizeK>=1073741824Then SizeKbToString:=CStr(LongInt(SizeK)div 1073741824)+' To'Else
 If SizeK>=1048576Then SizeKbToString:=CStr(LongInt(SizeK)div 1048576)+' Go'Else
 If SizeK>=1024Then Begin
  S:=CStr(LongInt(SizeK)div 1024);
  If Length(S)=1Then Begin
   IncStr(S,DeSep[0]);
   AddStr(S,Left(WordToStr(LongInt(SizeK)mod 1024),1));
  End;
  SizeKbToString:=S+' Mo';
 End
  Else
 Begin
  SizeKbToString:=CStr(SizeK)+' Ko';
 End;
End;

Procedure PMAMapFAT(Var Q:PartitionManagerApp;Dsk:Byte);
Var
 Part:PartEntry;
 DOSAccess:Boolean;
 W:Window;
 FS:FileSystemObject;
 UsedCluster:Word;
 Cluster:Word;
 State:Boolean;
 Buffer:Array[0..511]of Byte;
 BufferWord:Array[0..255]of Word Absolute Buffer;
 Boot:BootRec Absolute Buffer;
 CurrCluster:LongInt;
 UsedColor:Byte;
 I,J:Word;
 NumElement:LongInt;
 NumSec:LongInt;
 SizeElement:Word;
 FragElement:Word;
 IntElement:Word;
 K:Byte;
 GX,GY,X,Y:Word;
 CurrColor:Word;

 Procedure PutElement(State:Boolean);
 Var
  I:SmallInt;
  YR:Word;
 Begin
  If(State)Then CurrColor:=UsedColor
           Else CurrColor:=White;
  If SizeElement=0Then Begin
   Inc(IntElement);
   If(IntElement>FragElement)Then Begin
    IntElement:=0;
    SetPixel(GX+X,GY+Y,CurrColor);
    Inc(X);
    If X>=256Then Begin
     X:=0;
     Inc(Y,2);
    End;
   End;
  End
   Else
  For I:=0to SizeElement-1do Begin
   SetPixel(GX+X,GY+Y,CurrColor);
   Inc(X);
   If X>=256Then Begin
    X:=0;
    Inc(Y,2);
   End;
  End;
 End;

Begin
 DOSAccess:=Length(Q.FileName)=0;
 Part:=Q.ParSec.PartTable[Q.Partition];
 FSInit(FS);
 WEInitO(W,35,23);
 WEPushWn(W);
 WEPutWnKrDials(W,'Carte de la partition FAT');
 WEBar(W);
 GX:=Succ(WEGetRX1(W)) shl 3;
 GY:=(WEGetRY1(W)+1)*HeightChr;
 If Length(Q.FileName)>0Then FSOpen(FS,Q.FileName,False);
 If(FS.Handle<>errHdl)or(DOSAccess)Then Begin
  If(DOSAccess)Then FSReadDsk(FS,0,1,Buffer)
               Else FSReadDsk(FS,Part.SecOfs,1,Buffer);
  FSBootAnalysers(FS,Buffer);
  If(FS.SectorsPerFat=0)or(FS.BytesPerSector>512)or(FS.NumberOfFATs>3)Then Begin
   ErrNoMsgOk($2013);
   If(Not DOSAccess)Then FileClose(FS.Handle);
   WEDone(W);
   Exit;
  End;
  NumElement:=Mul2Word((32*8*16)shr 1,HeightChr);
  NumSec:=Mul2Word(FS.SectorsPerFat,FS.SectorsPerCluster)*LongInt(FS.ClusterByFatSector);
  If(NumElement<NumSec)Then Begin
   SizeElement:=0;
   FragElement:=NumSec div NumElement;
  End
   Else
  SizeElement:=NumElement div NumSec;
  X:=0;Y:=0;UsedCluster:=0;IntElement:=0;
  CurrCluster:=0;
  UsedColor:=LightRed;
  For I:=0to(FS.SectorsPerFat*FS.NumberOfFATs-1)do PutElement(True);
  UsedColor:=LightBlue;
  For I:=0to(FS.SectorsPerFat-1)do Begin
   If(DOSAccess)Then FSReadDsk(FS,FS.FirstFAT+I,1,Buffer)
                Else FSReadDsk(FS,Part.SecOfs+FS.FirstFAT+I,1,Buffer);
   For J:=0to FS.ClusterByFatSector-1do Begin
    Case(FS.FatBits)of
     32:State:=BufferWord[J]<$FFFFFFF8;
     16:State:=(BufferWord[J]>0)and(BufferWord[J]<$FFF8);
     Else Begin
      Cluster:=Buffer[(3*J)shr 1]+(Buffer[((3*J)shr 1)+1]shl 8);
      If Odd(J)Then Cluster:=Cluster shr 4
               Else Cluster:=Cluster and $0FFF;
      State:=(Cluster>0)and(Cluster<$FF8);
     End;
    End;
    For K:=0to FS.SectorsPerCluster-1do PutElement(State);
    If(State)Then Inc(UsedCluster);
    Inc(CurrCluster);
   End;
  End;
  If(Not DOSAccess)Then FileClose(FS.Handle);
  WEPutTxtXY(W,0,18,'Espace utilis‚: '+SizeKbToString(Mul2Word(UsedCluster,FS.SizeCluster)shr 10));
 End;
 While WEOk(W)do;
End;

Procedure MapFAT(Dsk:Byte);
Var
 Q:PartitionManagerApp;
Begin
 FillClr(Q,SizeOf(Q));
 PMAMapFAT(Q,Dsk);
End;

Procedure AppMapFAT;
Var
 Drv:Byte;
Begin
 Drv:=SelectDisk(1);
 If Drv<>$FFThen MapFAT(Drv-1);
End;

Procedure PMAInfoPartition(Var Q:PartitionManagerApp;Dsk:Byte;Var Part:Isatex.PartEntry);
Var
 SectCyl:Byte;
 Secteur:Byte;
 Cylindre:Word;
 Handle:Hdl;
 Buffer:Array[0..511]of Byte;
 Boot:BootRec Absolute Buffer;
 Data:Record
  PartitionType:String[50];
  SerialNumber:String[20];
  FirstPhysicalSector:String[50];
  LastPhysicalSector:String[50];
  TotalPhysicalSector:String[50];
  PhysicalGeometry:String[50];
 End;
Begin
  { Lecture du secteur de d‚marrage de la partition }
 If Length(Q.FileName)>0Then Begin
  Handle:=FileOpen(Q.FileName,fmRead);
  If(Handle<>errHdl)Then Begin
   _GetAbsRec(Handle,Q.StartPos+LongInt(Part.SecOfs)*LongInt(512),SizeOf(Buffer),Buffer);
   FileClose(Handle);
  End;
 End
  Else
 ReadPartSec(Dsk,Part.StartSec.Tete,Part.StartSec.SectCyl,Buffer);
 FillClr(Data,SizeOf(Data));
 Data.PartitionType:=HexByte2Str(Part.PartTyp)+' (Hex) '+GetPartitionTypeName(Part.PartTyp);
 GetSectCyl(Part.StartSec.SectCyl,Secteur,Cylindre);
 Data.FirstPhysicalSector:=CStr2(Part.SecOfs,12)+' (Cyl '+
                          CStr(Cylindre)+',Tˆte '+CStr(Part.StartSec.Tete)+',Sect '+CStr(Secteur)+')';
 GetSectCyl(Part.EndSec.SectCyl,Secteur,Cylindre);
 Data.LastPhysicalSector:=CStr2(LongInt(Part.SecOfs)+LongInt(Part.NbreSec)-1,12)+' (Cyl '+
                          CStr(Cylindre)+',Tˆte '+CStr(Part.EndSec.Tete)+',Sect '+CStr(Secteur)+')';
 Data.TotalPhysicalSector:=CStr2(LongInt(Part.NbreSec),12)+' ('+SizeKbToString(LongInt(Part.NbreSec)shr 1)+')';
 Data.SerialNumber:=_GetSerialNmStr(Boot.SerialNm);
 ExecuteAppDPU(147,Data);
End;

Function PMAChangedDisk(Var Q:PartitionManagerApp;Disk:Byte):Boolean;Begin
 If(Disk>=NmHardDsk)Then Disk:=0;
 Q.HardDisk:=Disk;
 Q.LC:=$80+Disk; { Pr‚pare num‚ro lecteur pour le BIOS }
 PMAChangedDisk:=ReadPartSec(Q.LC,0,1,Q.ParSec);
 Q.Partition:=0;
End;

Function PMAInit(Var Context;X1,Y1,X2,Y2:Byte):Boolean;
Var
 Q:PartitionManagerApp Absolute Context;
Begin
 FillClr(Q,SizeOf(Q));
 WEInit(Q.W,X1,Y1,X2,Y2);
 WEPushEndBar(Q.L);
 WEPutLastBar('Lecture des informations...');
 If PMAChangedDisk(Q,0)Then Begin
  PMARefresh(Q);
  PMAInit:=True;
 End
  Else
 Begin
  ErrNoMsgOk($2013);
  PMAInit:=False;
 End;
End;

Procedure PMAOpen(Var Context;X1,Y1,X2,Y2:Byte;Const Path:String);
Var
 Q:PartitionManagerApp Absolute Context;
 FS:FileSystemObject;
Begin
 FillClr(Q,SizeOf(Q));
 WEInit(Q.W,X1,Y1,X2,Y2);
 Q.FileName:=Path;
 If FSOpen(FS,Path,False)Then Begin
  FSReadDsk(FS,0,1,Q.ParSec);
  FileClose(FS.Handle);
 End;
 PMARefresh(Q);
End;

Procedure PMASelectBar(Var Q:PartitionManagerApp);Near;Begin
 WESetKrSel(Q.W);
 WEBarSelHor(Q.W,0,Q.Partition+5,wnMax);
 WESetKrBorder(Q.W);
End;

Function PMATitle(Var Context;Max:Byte):String;Begin
 PMATitle:='Gestionnaire de partitions';
End;

Procedure PMARefresh(Var Context);
Var
 Q:PartitionManagerApp Absolute Context;
Begin
 WEPutWnKrDials(Q.W,PMATitle(Q,Q.W.MaxX));
 WECloseIcon(Q.W);
 PMAPutPartition(Q);
 PMASelectBar(Q);
End;

Procedure PMAReSize(Var Context;X1,Y1,X2,Y2:Byte);
Var
 Q:PartitionManagerApp Absolute Context;
Begin
 WEInit(Q.W,X1,Y1,X2,Y2);
 PMARefresh(Q);
End;

Procedure PMAUnSelectBar(Var Q:PartitionManagerApp);Near;Begin
 WESetKrBorder(Q.W);
 WEBarSelHor(Q.W,0,Q.Partition+5,wnMax);
End;

Procedure PMASavePartition(Var Q:PartitionManagerApp);
Var
 FileName:String;
Begin
 FileName:=OpenWin('*.DAT','Sauvegarde sous');
 If FileName<>''Then Begin
  SetFile(FileName,0,SizeOf(PartSec),Q.ParSec);
 End;
End;

Procedure PMASetActivePartition(Var Q:PartitionManagerApp);
Var
 I:Byte;
Begin
 If Q.ParSec.PartTable[Q.Partition].Status=$80Then ErrMsgOk('Cette partition est d‚j… active!')Else
 If Q.ParSec.PartTable[Q.Partition].PartTyp=0Then ErrMsgOk('Cette partition n''est pas valide!')
  Else
 Begin
  For I:=0to 3do Q.ParSec.PartTable[I].Status:=$00;
  Q.ParSec.PartTable[Q.Partition].Status:=$80;
  Q.Changed:=True;
  PMARefresh(Q);
 End;
End;

Procedure PMADeletePartition(Var Q:PartitionManagerApp);Begin
 If(WarningMsgYesNo('Etes-vous vraiment certain de vouloir effacer cette partition?')=kbYes)Then Begin
  FillClr(Q.ParSec.PartTable[Q.Partition],SizeOf(Q.ParSec.PartTable[Q.Partition]));
  Q.Changed:=True;
  PMARefresh(Q);
 End;
End;

Procedure PMACreatePartition(Var Q:PartitionManagerApp;PartType:Byte;SizeKb:LongInt;InBegin:Boolean);
Label BreakAll;
Var
 FreeEntry:Byte;
Begin
 Repeat
  For FreeEntry:=0to 3do If Q.ParSec.PartTable[FreeEntry].PartTyp=0Then Goto BreakAll;
  ErrMsgOk('Aucune entr‚e de partition de libre!');
  Exit;
 Until True;
BreakAll:
 FillClr(Q.ParSec.PartTable[FreeEntry],SizeOf(Q.ParSec.PartTable[FreeEntry]));
 Q.ParSec.PartTable[FreeEntry].PartTyp:=PartType;
 Q.ParSec.PartTable[FreeEntry].NbreSec:=LongInt(SizeKb)shl 1;
End;

Procedure PMAFormatFAT(Var Q:PartitionManagerApp);
Var
 Boot:BootRec;
 Buffer:Array[0..511]of Byte;
 StartPos:LongInt;
 I:Word;
 J:Byte;
Begin
 FillClr(Boot,SizeOf(Boot));
 Boot.Media:=dskMediaHardDsk;
 Boot.BytesPerSec:=512;
 If LongRec(Q.ParSec.PartTable[Q.Partition].NbreSec).Hi<>0Then
  Boot.HughNmSec:=Q.ParSec.PartTable[Q.Partition].NbreSec
 Else
  Boot.NmTotSec:=Q.ParSec.PartTable[Q.Partition].NbreSec;
 Boot.SecPerCluster:=(Q.ParSec.PartTable[Q.Partition].NbreSec shr 16);
 If Q.ParSec.PartTable[Q.Partition].NbreSec and $FFFF>0Then Inc(Boot.SecPerCluster);
 StartPos:=Q.ParSec.PartTable[Q.Partition].SecOfs;
 FSWriteDsk(Q.FS,StartPos,1,Boot);
 For J:=0to Boot.NmFAT-1do For I:=0to Boot.SecPerFAT-1do Begin
  FillClr(Buffer,SizeOf(Buffer));
  If I=0Then Begin
   Buffer[0]:=$FF;
   Buffer[1]:=$FF;
  End;
  FSWriteDsk(Q.FS,StartPos,1,Buffer);
  Inc(StartPos,512);
 End;
End;

Function PMARun(Var Context):Word;
Label
 ChangeTechFlag;
Var
 Q:PartitionManagerApp Absolute Context;
 K:Word;
 QP:^HexEditApp;
 PL:Record
  TechMode:Boolean;
 End;
Begin
 Repeat
  K:=WEReadk(Q.W);
  Case(K)of
   kbF2:PMASavePartition(Q);
   kbF4:Begin
    PMARun:=kbHexView;
    Break;
   End;
   kbF9:PMAMapFAT(Q,Q.LC);
   kbF10:Goto ChangeTechFlag;
   kbTab:Begin
    PMAChangedDisk(Q,Q.HardDisk+1);
    PMAPutPartition(Q);
    PMASelectBar(Q);
   End;
   kbEnter:PMAInfoPartition(Q,Q.LC,Q.ParSec.PartTable[Q.Partition]);
   kbUp:Begin
    PMAUnSelectBar(Q);
    Q.Partition:=(Q.Partition-1)and 3;
    PMASelectBar(Q);
   End;
   kbDn:Begin
    PMAUnSelectBar(Q);
    Q.Partition:=(Q.Partition+1)and 3;
    PMASelectBar(Q);
   End;
   kbInWn:If LastMouseB=2Then Begin
    WaitMouseBut0;
    PL.TechMode:=Q.TechFlag;
    Case _RunMenuApp(152,PL)of
     $F101:PMAInfoPartition(Q,Q.LC,Q.ParSec.PartTable[Q.Partition]);
     $F102:PMASavePartition(Q);
     $F103:ChangeTechFlag:Begin
      Q.TechFlag:=Not(Q.TechFlag);
      PMAPutPartition(Q);
      PMASelectBar(Q);
     End;
     $F104:Begin
      PMARun:=kbHexView;
      Break;
     End;
     $F105:PMASetActivePartition(Q);
     $F106:PMADeletePartition(Q);
    End;
   End;
   Else Begin
    PMARun:=K;
    Break;
   End;
  End;
 Until False;
End;

Procedure PMASaveAllChanged(Var Q:PartitionManagerApp);Begin
 FSWriteDsk(Q.FS,0,1,Q.ParSec);
End;

Function PMADone(Var Context):Word;
Var
 Q:PartitionManagerApp Absolute Context;
Begin
 If(Q.Changed)Then Begin
  Case WarningMsgYesNo('Les modifications sur les partitions n''ont pas ‚t‚ sauvegard‚! Dois-je le sauver ?')of
   kbYes:PMASaveAllChanged(Q);
   kbAbort:Begin
    PMADone:=kbAbort; {Abandon utilisateur,il ne voulait}
    Exit;             {pas r‚ellement quitter...}
   End;
  End;
 End;
 WEDone(Q.L);
 PMADone:=0;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Proc‚dure ViewPartition                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure offre la possibilit‚ … l'utilisateur de visualiser les
 partitions du disque dur primaire.
}

Procedure ViewPartition;
Var
 Q:PartitionManagerApp;
 K:Word;
Begin
 If PMAInit(Q,0,5,MaxXTxts,MaxYTxts-5)Then Begin
  K:=PMARun(Q);
  WEDone(Q.W);
 End
  Else
 ErrNoMsgOk(errReadBootSector);
 PMADone(Q);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                     Proc‚dure GetFileInfo                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de charger tous les r‚pertoires de l'unit‚
 sp‚cifier.
}

Function GetFileInfo;
Label Start,10,20;
Var
 Ptr:Pointer;
 PT:TreePtr Absolute Ptr;
 H:SearchRec;
 OldPath,Path:String;
 TmpName:String[12];
 SizeSec,I,P,MI:Word;
 W:Window;
Begin
 GetFileInfo:=NIL;
 SizeSec:=SectorSize(Drv2Dsk(Drive));
 FillClr(Info,SizeOf(Info));
 OldPath:=GetCurrentDir;
 I:=1;P:=0;
 Path:=Drive+':\';
 WEInitO(W,32,4);
 WEPushWn(W);
 WEPutWnKrDials(W,'');
 WEPutTxtXY(W,0,1,'D‚compte de r‚pertoire:');
 WESetKrHigh(W);
 {$IFNDEF FLAT386}
  If MaxAvail<65520Then Size:=MaxAvail
                   Else Size:=65520;
 {$ENDIF}
 Ptr:=MemAlloc(Size);
 If(Ptr=NIL)Then Exit;
 FillSpc(PT^[0].Name,11);
 PT^[0].Name[0]:='\';
 PT^[0].Nm:=0;
 MI:=Size div 12;
Start:
 FindFirst(Path+'*.*',faAll,H);
10:
 While SysErr=0do Begin
  If(sfaDir)in(H.Attr.Flags)Then Begin
   If(H.Name<>'.')and(H.Name<>'..')Then Begin
    Inc(Info.Directory); AddStr(Path,H.Name+'\');
    {$IFDEF __Windows__}
     StrPCopy(@H.Name,SetFullName(H.Name));
    {$ELSE}
     H.Name:=SetFullName(H.Name);
     DelChrAt(H.Name,9);
    {$ENDIF}
    MoveLeft(H.Name[1],PT^[I].Name,11);PT^[I].Nm:=P;Inc(P);
    WEPutTxtXY(W,24,1,CStr(I));
    Inc(I);
    If(I>MI)Then Begin
     ErrMsgOk('C''est inimaginable, vous avez plus de r‚pertoire que mon '+
	      'cr‚ateur! Je ne peux supporter plus de '+CStr(MI)+
	      ' r‚pertoires sur un mˆme unit‚.');
     Break;
    End;
    Goto Start;
   End;
  End
   else
  Begin
   Inc(Info.Size,Long(H.Size));
   Inc(Info.NmSector,Long(H.Size)div Long(SizeSec));
   If Long(H.Size)mod Long(SizeSec)<>0Then Inc(Info.NmSector);
   Inc(Info.NmFile);
   If(sfaArchive)in(H.Attr.Flags)Then Begin
    Inc(Info.SizeArchive,Long(H.Size));
    Inc(Info.ArchiveFile)
   End;
   If(sfaHidden)in(H.Attr.Flags)Then Begin
    Inc(Info.SizeHidden,Long(H.Size));
    Inc(Info.HiddenFile)
   End;
   If(sfaReadOnly)in(H.Attr.Flags)Then Begin
    Inc(Info.SizeReadOnly,Long(H.Size));
    Inc(Info.ReadOnlyFile)
   End;
   If(sfaSysFile)in(H.Attr.Flags)Then Begin
    Inc(Info.SizeSys,Long(H.Size));
    Inc(Info.SysFile)
   End;
  End;
  FindNext(H)
 End;
 If Length(Path)>3Then Begin
20:TmpName:='';BackStr(Path);Dec(P);
  While Path[Length(Path)]<>'\'do Begin
   TmpName:=Path[Length(Path)]+TmpName;
   BackStr(Path);
  End;
  FindFirst(Path+'*.*',faAll,H);
  While(H.Name<>TmpName)do Begin
   FindNext(H);
   If SysErr<>0Then Goto 20;
  End;
  FindNext(H);
  Goto 10;
 End;
 WEDone(W);
 ChDir(OldPath);
 GetFileInfo:=Ptr;
 Inc(PtrRec(Ptr).Seg,((I+2)*12)shr 4);
 FreeMemory(Ptr,Size-(((((I+2)*12)shr 4))shl 4));
 Size:=I*12;NB:=I;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure RenameDiskName                    Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet … l'utilisateur de changer le volume d'un unit‚
 en particulier. Elle retourne le nouveau nom du volume.
}

Function RenameDiskName(Dsk:Byte):String;
Var
 S:String;
Begin
 S:=GetDskLabel(Dsk);
 If(_WinInp(40,'Volume','Changer le nom du volume (disque)',False,S)=kbOk)Then Begin
  If Not SetDskLabel(Dsk,S)Then ErrNoMsgOk(errErrorRenameVolume)
                           Else RenameDiskName:=S;
 End
  Else
 RenameDiskName:=S;
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
END.