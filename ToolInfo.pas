{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                                                                         Û
 ³                    Malte Genesis/Outils d'information                   Û
 ³                                                                         Û
 ³            dition Chantal pour Mode R‚el/IV - Version 1.1              Û
 ³                              1996/11/30                                 Û
 ³                                                                         Û
 ³          Tous droits r‚serv‚s par les Chevaliers de Malte (C)           Û
 ³                                                                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Nom du programmeur
 ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

  Sylvain Maltais


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette unit‚ permet de produire … l'utilisateur de connaŒtres divers
 informations dans tous les cat‚gories sur le systŠme actuellement en
 usage.
}

Unit ToolInfo;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                INTERFACE
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

{$I DEF.INC}

Procedure CountryInfo;
Procedure DskInfo;
Function  GetStrMouse:String;
Procedure MouseInfo;
Procedure JoystickInfo;
Procedure KeyboardInfo;
Procedure ModemDoctor;
Procedure SomaryInfo;
Procedure SoundCardInfo;
Procedure WindowSommary;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                             IMPLEMENTATION
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses
 Adele,Math,
 {$IFDEF Overlay}Overlay,{$ENDIF}Dostex,Systex,Isatex,Memories,Systems,
 SysPlus,Video,Disk,Dials,Terminal,Mouse,Restex,ResLoadI,ResServI,ResServD,
 SysInter,CommBase,ToolView,Dialex,DialPlus;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ·}
{³                     Z o n e  P r i v ‚ s                    º}
{ÔÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼}

{$IFNDEF FLAT386}
 {$L CI.OBJ}

 Procedure CITest;Far;External;
 Procedure ChkCPUMhz;Far;External;
 Function GetPChrMhz:PChar;Far;External;
 Function GetPChrWaitStates:PChar;Far;External;
 Function GetPChrGeneral:PChar;Far;External;
{$ENDIF}

Function  BiosScan(a,b,Len:Wd;Var d:Wd):Boolean;Near;Forward;
Function  BusType:Byte;Near;Forward;
Function  ClusterSize(Dsk:Byte):LongInt;Near;Forward;
Function  GetConstructorBios(Var SX:Boolean):String;Near;Forward;
Function  GetMsVer:String;Near;Forward;
Function  NmCluster(Dsk:Byte):Word;Near;Forward;
Function  ReadRom(SegRom,Ofs:Word;Len:Byte):String;Near;Forward;
{Function  ReadRomAddr(Buf:Pointer;Len:Byte):String;Near;Forward;}
Procedure WEPutTxtLnSB(Var W:Window;Const S:String;B:Boolean);Near;Forward;
Procedure WEPutTxtLnSBasB(Var W:Window;Const S:String;B:Byte);Near;Forward;
Procedure WEPutTxtLnSBasBS(Var W:Window;Const S1:String;B:Byte;Const S2:String);Near;Forward;
Function  XBool(X:Bool):String;Near;Forward;
Procedure _WEPutTxtLnSBSWC(Var W:Window;Const S1:String;C:Byte);Near;Forward;

Function BiosScan;
Var
 I,XW:Word;
 Notice:String;
Begin
 BiosScan:=False;
 {$IFNDEF __Windows__}
  For I:=1to 3do Begin
   Case(I)of
    1:Notice:='(C)';
    2:Notice:='CORP.';
     Else Notice:='COPYRIGHT';
   End;
   XW:=IScan(Mem[a:b],Len,Notice);
   If XW<$FFF0Then Begin
    While(XW>b)and(IsRomanLetter(Chr(Mem[a:XW-1])))do Dec(XW);
    d:=XW;BiosScan:=True;
    Break;
   End;
  End;
 {$ENDIF}
End;

{$I \Source\Chantal\Library\Disk\Dos\ClusterS.Inc}
{$I \Source\Chantal\Library\Disk\RAM\IsRAMDrv.Inc}

{$IFNDEF __Windows__}
 {$DEFINE Macro}
{$ENDIF}

{$I \Source\Chantal\Library\Mouse\EGARegis.Inc}
{$I \Source\Chantal\Library\Mouse\MPHor.Inc}
{$I \Source\Chantal\Library\Mouse\MPVer.Inc}
{$UNDEF Macro}

Function GetConstructorBios;
{$IFDEF __Windows__}
 Begin
 End;
{$ELSE}
 Var
  i2,i1:Word;
  S,Out:String;
  i:Byte;
  Ok:Boolean;
  Data:Record
   VID:Word;
   Name:String;
  End;
 Begin
  GetConstructorBios:='';Out:='';
  Ok:=True;SX:=False;
  If(ComputerName=cnAT)Then Begin
   If ReadRom($F000,4,12)='AAAAMMMMIIII'Then Out:='American Megarends'
    Else
   Begin
    i2:=$F000;
    For I:=0to 94do Begin
     If BiosScan(i2,0,$1FFF,i1)Then Begin
      If(ReadRom(i2,i1,5)='(C)19')and(Chr(Mem[i2:i1+5])in ArabicDigit)and(Chr(Mem[i2:i1+6])in ArabicDigit)Then Begin
       Inc(i1,7);
       If(Chr(Mem[i2:i1])='-')and(Chr(Mem[i2:i1+1])in ArabicDigit)Then Begin
        Inc(i1);
        While(Chr(Mem[i2:i1])in ArabicDigit)do Inc(i1);
       End;
       While Chr(Mem[i2:i1])=' 'do Inc(i1);
      End;
      i:=80;
      For i:=1to 80do If Chr(Mem[i2:i1+i])in[#0..#31,',']Then Break;
      AddStr(Out,ReadRom(i2,i1,i));
      Break;
     End;
     Inc(i2,$80);
    End;
    If Out=''Then Out:='(Clone AT)';
   End;
  End
   Else
  Begin
   Out:=SelectField('CHANTAL:/Materiel/VIDComputer.Dat',ComputerName,1);
  End;
  GetConstructorBios:=Out+'; '+ReadRom($FFFF,5,8);
 End;
{$ENDIF}

{$I \Source\Chantal\Library\Disk\Dos\NmCluste.Inc}
{$I \Source\Chantal\Library\System\OSStr.Inc}
{$I \Source\Chantal\Library\Memories\ROM\ReadRom.Inc}

{Function ReadRomAddr;Assembler;ASM
 JMP ReadRom.Near[3]
END;}

Procedure WEPutTxtLnSB;Begin
 WESetKrBorder(W);
 WEPutTxtT(W,StrUSpc(S,35));
 WESetKrHigh(W);
 WEPutTxtTLn(W,XBool(B))
End;

Procedure WEPutTxtLnSBasB;Begin
 WEPutTxtLn(W,S+BasicStrW(B))
End;

Procedure WEPutTxtLnSBasBS;Begin
 WEPutTxtLn(W,S1+BasicStrW(B)+S2)
End;

Function XBool;Begin
 If(X)Then XBool:='Oui'Else XBool:='Non'
End;

Procedure _WEPutTxtLnSBSWC;Begin
 WEPutTxtLn(W,S1+Chr(C)+'" (ASCII'+BasicStrW(C)+')')
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ·}
{³                    Z o n e  P u b l i q u e                 º}
{ÔÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼}

{$I \Source\Chantal\Library\Mouse\GetStrMs.Inc}
{$I \Source\Chantal\Library\Disk\GIHD.Inc}

Procedure LoadListDrive(Var L:LstMnu;Var Context);
Var
 I,Head,Sector:Byte;
 _CX,_DX,_DI,_ES:Word;
 Track:Word;
 Ok:Boolean;
 FloppyType:Byte;
 Size:LongInt;
 S,S2:String;
Begin
 S:='';
 For I:=$80to$7F+NmHardDsk do Begin
  ASM
   MOV AH,8
   MOV DL,I
   INT 13h
   MOV _CX,CX
   MOV _DX,DX
   MOV Ok,True
   JNC @1
   MOV Ok,No
  @1:
  END;
  If(Ok)Then Begin
   GetInfoHardDisk(I,Track,Head,Sector);
   If S<>''Then IncStr(S,';');
   Size:=Long(Track)*Long(Sector)*Long(Head)*Long(512);
   If Size>1024*1024*1024Then Begin
    { 2^30 = 1024 x 1024 x 1024 = 1 073 741 824 octets }
    ASM
      {Size:=Size shr 30;}
     MOV AL,Byte Ptr Size[3]
     {$IFOPT G+}
      ROL AL,2
     {$ELSE}
      ROL AL,1
      ROL AL,1
     {$ENDIF}
     AND AX,3
     MOV Word Ptr Size,AX
     MOV Word Ptr Size[2],0
    END;
    AddStr(S,BasicStr(Size)+'G');
   End
    Else
   If Size>1048576Then Begin
    { 2^20 = 1024 x 1024 = 1 048 576 octets }
    Size:=Size div 1048576;
    AddStr(S,BasicStr(Size)+'M');
   End
    Else
   If Size>1024Then Begin
    Size:=Size div 1024;
    AddStr(S,BasicStr(Size)+'K');
   End
    Else
   AddWdDec(S,Size);
   IncStr(S,'o');
  End;
 End;
 Case(HardDskCtrl)of
  ctrlhdNo:S2:='Absent';
  ctrlhdMFM:S2:='MFM';
  ctrlhdIDE:S2:='IDE';
  Else S2:='SCSI';
 End;
 If S<>''Then ALAddStrByte(L.List,'Dur '+S2+': '+S,0);
 S:='';
 For I:=0to NmFloppyDsk-1do Begin
  FloppyType:=GetFloppyDrvType(I);
  If(S<>'')and(FloppyType>0)Then AddStr(S,'; ');
  Case(FloppyType)of
   1:AddStr(S,'360Ko, 5¬');
   2:AddStr(S,'1'+DeSep[0]+'2Mo, 5¬');
   3:AddStr(S,'720Ko, 3«');
   4:AddStr(S,'1'+DeSep[0]+'44Mo, 3«');
   5,6:AddStr(S,'2'+DeSep[0]+'88Mo, 3«');
  End;
 End;
 If S<>''Then ALAddStrByte(L.List,'Amovible: '+S,1);
 LMRefresh(L);
End;

Procedure LoadListOther(Var L:LstMnu;Var Context);Begin
 ALAddStrByte(L.List,'Type de clavier: '+SelectField('CHANTAL:/Materiel/Clavier/Modele.Dat',KbdModel,1),5);
 ALAddStrByte(L.List,'SystŠme Op‚rateur: '+OperatingSystemStr,6);
End;

Procedure SomaryExtern(Var R:ResourceWindow;Var Context);
Var
 FreeXms,TotalMem:LongInt;
 MemConv:Word Absolute MemTotalSize;
 MemVram,FreeEms,FreeConv,FreeVram,DecLst:Word;
 LenFreeConv,LenUsedConv,LenFreeXms,LenUsedXms,LenFreeEms,NumMem,
 LenUsedEms,LenFreeVram,LenUsedVram,XPos:Byte;
 S:String;
Begin
 FreeConv:=MemAvail shr 10;
{ FreeEms:=EmmFreePage*16;}
 If(VSwpInit)Then FreeEms:=AppResFree(rmEMS)
             Else FreeEms:=0;
 FreeXms:=AppResFree(rmXms);
 MemVram:=GetVideoMemory shr 10;
 If(VSwpInit)Then FreeVram:=AppResFree(rmVram)
             Else FreeVram:=0;
 TotalMem:=Long(XmsTotalSize)+Long(MemConv)+Long(EmmTotalSize)+Long(MemVram);
 NumMem:=Byte(XmsTotalSize>0)+Byte(EmmTotalSize>0)+Byte(MemConv>0)+Byte(MemVram>0);
 LenUsedConv:=Trunc(((MemConv-FreeConv)/TotalMem)*(R.W.MaxX-NumMem*2));
 LenFreeConv:=Trunc((FreeConv/TotalMem)*(R.W.MaxX-NumMem*2));
 LenUsedVram:=Trunc(((MemVram-FreeVram)/TotalMem)*(R.W.MaxX-NumMem*2));
 LenFreeVram:=Trunc((FreeVram/TotalMem)*(R.W.MaxX-NumMem*2));
 LenUsedXms:=Trunc(((XmsTotalSize-FreeXms)/TotalMem)*(R.W.MaxX-NumMem*2));
 LenFreeXms:=Trunc((FreeXms/TotalMem)*(R.W.MaxX-NumMem*2));
 LenUsedEms:=Trunc(((EmmTotalSize-FreeEms)/TotalMem)*(R.W.MaxX-NumMem*2));
 LenFreeEms:=Trunc((FreeEms/TotalMem)*(R.W.MaxX-NumMem*2));
 If LenUsedXms+LenFreeXms>R.W.MaxX shr 1Then Begin
  LenUsedConv:=5;
  LenFreeConv:=5;
  LenUsedVram:=6;
  LenFreeVram:=6;
  LenUsedXms:=9;
  LenFreeXms:=9;
  LenUsedEms:=7;
  LenFreeEms:=7;
 End
  Else
 Begin
  If LenUsedConv+LenFreeConv<10Then Begin
   DecLst:=10;
   If(LenUsedXms>5)Then Begin
    Dec(LenUsedXms,5);
    Dec(DecLst,5)
   End;
   If(LenFreeXms>5)Then Begin
    Dec(LenFreeXms,5);
    Dec(DecLst,5)
   End;
   If DecLst=5Then Begin
    If LenFreeXms>5Then Begin
     Dec(LenFreeXms,5);
     Dec(DecLst,5)
    End;
    If LenUsedXms>5Then Begin
     Dec(LenUsedXms,5);
     Dec(DecLst,5)
    End;
   End;
   If DecLst=0Then Begin
    Inc(LenUsedConv,5);
    Inc(LenFreeConv,5);
   End;
  End;
  If LenUsedVram+LenFreeVram<10Then Begin
   DecLst:=10;
   If(LenUsedXms>5)Then Begin
    Dec(LenUsedXms,5);
    Dec(DecLst,5)
   End;
   If(LenFreeXms>5)and(DecLst>=5)Then Begin
    Dec(LenFreeXms,5);
    Dec(DecLst,5)
   End;
   If DecLst=5Then Begin
    If LenFreeXms>5Then Begin
     Dec(LenFreeXms,5);
     Dec(DecLst,5)
    End;
    If LenUsedXms>5Then Begin
     Dec(LenUsedXms,5);
     Dec(DecLst,5)
    End;
   End;
   If DecLst=0Then Begin
    Inc(LenUsedVram,5);
    Inc(LenFreeVram,5);
   End;
  End;
 End;
 XPos:=0;
 S:=WordToStr(MemConv)+'Ko';
 WEPutTxtXY(R.W,XPos,14,Left('Conventionnel',LenUsedConv+LenFreeConv-Length(S))+'.: '+S);
 WESetKr(R.W,$1F);
 WEBarSpcHorShade(R.W,XPos,15,LenUsedConv);
 WEPutTxtXY(R.W,XPos,15,Left(WordToStr(MemConv-FreeConv)+'Ko',LenUsedConv+1));
 Inc(XPos,LenUsedConv+1);
 WESetKr(R.W,$8F);
 WEBarSpcHorShade(R.W,XPos,15,XPos+LenFreeConv);
 WEPutTxtXY(R.W,XPos,15,Left(WordToStr(FreeConv)+'Ko',LenFreeConv+1));
 WESetKrBorder(R.W);
 Inc(XPos,LenFreeConv+3);
 If LenUsedVram+LenFreeVram>0Then Begin
  WEPutTxtXY(R.W,XPos,14,'Vid‚o:'+BasicStrW(MemVram)+'Ko');
 End;
 If LenUsedVram>0Then Begin
  WESetKr(R.W,$1F);
  WEBarSpcHorShade(R.W,XPos,15,XPos+LenUsedVram);
  WEPutTxtXY(R.W,XPos,15,Left(WordToStr(MemVram-FreeVram)+'Ko',LenUsedVram+1));
  Inc(XPos,LenUsedVram+1);
 End;
 If LenFreeVram>0Then Begin
  WESetKr(R.W,$8F);
  WEBarSpcHorShade(R.W,XPos,15,XPos+LenFreeVram);
  WEPutTxtXY(R.W,XPos,15,Left(WordToStr(FreeVram)+'Ko',LenFreeVram+1));
  Inc(XPos,LenFreeVram);
 End;
 If LenUsedEms+LenFreeEms>0Then Begin
  Inc(XPos,3);
  WESetKrBorder(R.W);
  WEPutTxtXY(R.W,XPos,14,'EMS:'+BasicStrW(EmmTotalSize)+'Ko');
 End;
 If LenUsedEms>0Then Begin
  WESetKr(R.W,$1F);
  WEBarSpcHorShade(R.W,XPos,15,XPos+LenUsedEms);
  WEPutTxtXY(R.W,XPos,15,Left(WordToStr(EmmTotalSize-FreeEms)+'Ko',LenUsedEms+1));
  Inc(XPos,LenUsedEms+1);
 End;
 If LenFreeEms>0Then Begin
  WESetKr(R.W,$8F);
  WEBarSpcHorShade(R.W,XPos,15,XPos+LenFreeEms);
  WEPutTxtXY(R.W,XPos,15,Left(WordToStr(FreeEms)+'Ko',LenFreeEms+1));
  Inc(XPos,LenFreeEms+1);
 End;
 If LenUsedXms+LenFreeXms>0Then Begin
  Inc(XPos,2);
  WESetKrBorder(R.W);
  WEPutTxtXY(R.W,XPos,14,'XMS:'+BasicStrW(XmsTotalSize)+'Ko');
 End;
 If LenUsedXms>0Then Begin
  WESetKr(R.W,$1F);
  WEBarSpcHorShade(R.W,XPos,15,XPos+LenUsedXms);
  WEPutTxtXY(R.W,XPos,15,Left(WordToStr(XmsTotalSize-FreeXms)+'Ko',LenUsedXms+1));
  Inc(XPos,LenUsedXms+1);
 End;
 If LenFreeXms>0Then Begin
  WESetKr(R.W,$8F);
  If(XPos+LenFreeXms<=R.W.MaxX)Then
   WEBarSpcHorShade(R.W,XPos,15,XPos+LenFreeXms);
  WEPutTxtXY(R.W,XPos,15,Left(WordToStr(FreeXms)+'Ko',LenFreeXms+1));
  Inc(XPos,LenUsedXms);
 End;
End;

Procedure SomaryInfo;
Var
 Form:Record
  Size:Boolean;
  ComputerName:String[50];
  BiosConstructor:String[50];
  CPU:String[30];
  MPU:String[30];
  VideoCard:String[50];
  MouseType:String[50];
  Disk:MListBox;
  Other:MListBox;
  Extern:MExtern;
 End;
 L:Window;
 SX:Boolean;
 Mhz:String;
 VideoCard:Byte;
Begin
 FillClr(Form,SizeOf(Form));
 WEPushEndBar(L);
 WEPutLastBar('Teste la vitesse d''horloge du processeur...');
 {$IFNDEF FLAT386}
  If(CPU<cpuCyrix5x86)Then Begin
   ChkCPUMhz;
   Mhz:=StrPas(PChr(GetPChrMhz));
  End
   Else
 {$ENDIF}
 Mhz:='?';
 WEDone(L);
 Form.Size:=kType in[ktBig,ktBubble];
 {$IFDEF NotReal}
  Form.ComputerName:='PC/AT ou Compatible';
 {$ELSE}
  Case(MachineID)of
   $FF:Form.ComputerName:='PC';
   $FE:Form.ComputerName:='PC/XT';
   $FD:Form.ComputerName:='PC Junior';
   $FC:Form.ComputerName:='PC/AT';
   Else Form.ComputerName:='PS/2';
  End;
  AddStr(Form.ComputerName,' ou Compatible');
 {$ENDIF}
 Form.BiosConstructor:=GetConstructorBios(SX);
 Form.CPU:=SelectField('CHANTAL:/Materiel/CPUModele.Dat',CPU,1);
 Case(CPU)of
  cpui486:If(SX)Then AddStr(Form.CPU,'SX (32 bits)')
   Else
  Begin
   If Test8087=0Then AddStr(Form.CPU,'SX');
   AddStr(Form.CPU,'(32 bits)');
  End;
  cpui386:If(SX)Then AddStr(Form.CPU,'SX (16 bits)');
 End;
 AddStr(Form.CPU,DaSep[0]+' '+Mhz+' Mhz');
 If Test8087<>0Then Case(CPU)of
  cpui486:Form.MPU:='80487';
  cpui386:If(SX)Then Form.MPU:='80387SX'
                Else Form.MPU:='80387';
  cpu80286:Form.MPU:='80287';
  cpu80186,cpu80188:Form.MPU:='80187';
  cpuV30,cpuV20,cpu8086,cpu8088:Form.MPU:='8087';
  Else Form.MPU:='int‚gr‚ au CPU';
 End
  Else
 Form.MPU:='Aucun';
 Form.VideoCard:=SelectField('CHANTAL:/Materiel/IDVideo.Dat',GetVideoCard,1);
 Form.MouseType:=GetStrMouse;
 __InitMouse;
 Form.Disk.LoadList:=LoadListDrive;
 Form.Other.LoadList:=LoadListOther;
 Form.Extern.Call:=SomaryExtern;
 ExecuteAppDPU(160,Form);
End;

Const
 XMax=32;
 YMax=32;

Type
 CountryDataSetRec=Record
  ID:Word;
  CountryCode:Word;
  CodePage:Word;
  Buffer:Array[0..4095]of Byte;
 End;

 CountryDials=Record
  W,LW:Window;
  OldBackKbd:Procedure;
  XI:Byte;
  CountryName,S:String;
  Data:CountryDataSetRec;
  PStr:^String;
  TableSin:Array[0..255]of Word;
  TablePos:Array[0..XMax,0..YMax]of Word;
  I:Byte;
  GX1,GY1,BackgroundColor:Word;
  ImageFound:Boolean;
 End;

Procedure Drapeau;Far;
Const
 Vitesse=2;
 Curve=125;
 NumPixels=40;
Var
 D:^CountryDials Absolute CurrForm;
 X,Y,XP,YP:Word;
 Show:Boolean;
 MX,MY:Word;

 Procedure PutPixelOfs(Offset,Color:Word);Begin
  If(Offset>=NumPixels*NumPixels)Then Exit;
  SetPixel(D^.GX1+(Offset mod NumPixels),D^.GY1+(Offset div NumPixels),Color);
 End;

 Function GetPixelImage(X,Y:Word):Word;Var Color:Word;Begin
  Color:=ConvP^[SizeOf(ImageHeaderRes)+(X shr 1)+Y*16];
  If X and 1=0Then Color:=Color shr 4
              Else Color:=Color and$F;
  GetPixelImage:=Color;
 End;

Begin
 D^.OldBackKbd;
 MX:=__GetMouseXPixels;
 MY:=__GetMouseYPixels;
 Show:=(IsShowMouse)and(MX>=D^.GX1)and(MX<=D^.GX1)and
                       (MY>=D^.GY1)and(MY<=D^.GY1);
 If(Show)Then __HideMousePtr;
 For Y:=0to(YMax)do For X:=0to(XMax)do Begin
  If(Y<5)or(Y>30)or(X<4)or(X>28)Then
   PutPixelOfs(D^.TablePos[X,Y],D^.BackgroundColor);
  XP:=X+D^.TableSin[(D^.I+Curve*X+Curve*Y  )and$FF]-28;
  YP:=Y+D^.TableSin[(D^.I+4*X    +Curve*Y+Y)and$FF]-28;
  D^.TablePos[X,Y]:=XP+YP*NumPixels;
  PutPixelOfs(D^.TablePos[X,Y],GetPixelImage(X,Y));
 End;
 If(Show)Then __ShowMousePtr;
 WaitRetrace;
 Inc(D^.I,Vitesse);
End;

Procedure CountryInfo;
Const
 SinMin=30;
 Amplitude=2;
Var
 D:CountryDials;
 I:Byte;
 Ok:Boolean;
 S:String;

 Procedure PutIconCountry(Var Q:DataSet;X1,Y1:Byte;CountryCode:Word);
 Var
  ConvL:LongInt Absolute ConvP;
  X:XInf;
 Begin
  ConvP:=@D.Data;
  DBGotoColumnAbs(Q,5,Pointer(ConvP));
  If ConvL<>0Then Begin
   D.GX1:=X1 shl 3;D.GY1:=GetRawY(Y1);
   ASM
    ADD Word Ptr ConvP,4+11
   END;
   FillClr(X,SizeOf(X));
   X.Output:=irmConvMem;
   X.Size:=621;
   D.BackgroundColor:=GetPixel(D.GX1,D.GY1);
   If(FX)Then D.ImageFound:=True
         Else RIPutImage(X,D.GX1,D.GY1,32,32);
  End;
 End;

Begin
 FillClr(D,SizeOf(D));
 CurrForm:=@D;
 DBOpenServerName(ChantalServer,'CHANTAL:/Country/Country.Dat');
 If MalteCountryCode=0Then Ok:=DBLocateAbs(ChantalServer,1,CountryCode,[])
                      Else Ok:=DBLocateAbs(ChantalServer,0,MalteCountryCode,[]);
 If(Ok)Then Begin
  DBReadRec(ChantalServer,D.Data);
  D.PStr:=@D.Data;
  DBGotoColumnAbs(ChantalServer,4,Pointer(D.PStr));
  D.CountryName:=D.PStr^;
 End
  Else
 Begin
  D.CountryName:='Inconnu';
 End;
 WEPushEndBar(D.LW);
 WEInitO(D.W,70,11);
 WEPushWn(D.W);
 WEPutWnKrDials(D.W,'Information Pays ou de R‚gion');
 WEPutLastBar('^F1^ Aide ³ Information sur la configuration du pays actuellement en usage');
 WELn(D.W);
 WEBar(D.W);
 WEPutTxt(D.W,'Nom du pays (ou de la r‚gion):');
 D.W.X:=31;
 WESetKrHigh(D.W);
 AddStr(D.CountryName,', ('+Str0(CountryCode,3)+')');
 WEPutTxtLn(D.W,D.CountryName);
 WESetKrBorder(D.W);
 D.XI:=31+Length(D.CountryName)+2;
 If(D.XI+4>D.W.MaxX)Then D.XI:=D.W.MaxX-5;
 If(IsGrf)Then
  PutIconCountry(ChantalServer,D.XI+WEGetRX1(D.W),WEGetRY1(D.W)+1,CountryCode);
 If(FX)Then Begin
  For I:=0to 255do D.TableSin[I]:=Round(Sin(i*4*PI/255)*Amplitude)+SinMin;
  D.OldBackKbd:=_BackKbd;_BackKbd:=Drapeau;
 End;
 WEPutTxt(D.W,'Code de page:');
 D.W.X:=31;
 WESetKrHigh(D.W);WEPutTxtLn(D.W,Str0(CodePage,3));WESetKrBorder(D.W);
 WEPutTxt(D.W,'Format du temps: ');
 D.W.X:=31;
 WESetKrHigh(D.W);
 S:=SelectField('CHANTAL:/Systeme/Date.Dat',Date,1);
 ChgChr(S,'/',DtSep[0]);
 WEPutTxt(D.W,S);
 D.S:='';AddPChr(D.S,@DaSep);IncStr(D.S,' ');
 Case(Time)of
  AmPm:AddWdDec(D.S,12);
  Military:AddWdDec(D.S,24);
 End;
 AddPChr(D.S,@TmSep);
 WEPutTxt(D.W,D.S+'00');
 If(Time=AmPm)Then WEPutTxt(D.W,'am');
 WELn(D.W);
 WESetKrBorder(D.W);
 WEPutTxt(D.W,'Syntaxe de la monnaie:');
 D.W.X:=31;
 WESetKrHigh(D.W);
 WEPutTxtLn(D.W,StrPas(@Curr)+CStr(1000)+StrPas(@DeSep)+Zero(Digits));
 WESetKrBorder(D.W);
 WEPutTxt(D.W,'Format des nombres:');
 D.W.X:=31;
 WESetKrHigh(D.W);
 WEPutTxtLn(D.W,CStr(1234567)+StrPas(@DeSep)+CStr(890123));
 WESetKrBorder(D.W);
 WEPutTxt(D.W,'S‚parateur de donn‚e:');
 WESetKrHigh(D.W);
 D.W.X:=31;
 WEPutTxtLn(D.W,'"'+StrPas(@DaSep)+'"');
 While WEOk(D.W)do QHlp('INFPAYS.HLP');
 WEDone(D.LW);
 If(D.ImageFound)Then _BackKbd:=D.OldBackKbd;
End;

Procedure ModemDoctor;
Var
 W,LW:Window;
 C:Byte;
 ReadValue:Byte;
 Reg:String;
 Data:Record
  Code:Byte;
  Mode:Byte;
  Description:String;
 End;

 Function Read(Const Cmd:String):Byte;
 Var
  S,Sx:String;
  Chr:Char;
  I:Byte;
 Begin
  {$IFNDEF __Windows__}
   Read:=0;
   SendModemCmd(Cmd+'|');
   S:=''; I:=0;
   Repeat
    If ACReceive(Chr)Then IncStr(S,Chr);
    If Chr=#13Then Begin
     Inc(I);
     If I=3Then Begin
      Sx:=Copy(S,Length(S)-3,3);
      Read:=StrToWord(Sx);
     End;
    End;
    If(NxtKey=kbEsc)Then Exit;
   Until I=5;
   Repeat Until ACReceive(Chr);
  {$ENDIF}
 End;

Begin
 WEPushEndBar(LW);
 WEPutLastBar('Un instant S.V.P., j''analyse votre modem...');
 WEInitO(W,70,17);
 WEPushWn(W);
 WEPutWnKrDials(W,'Docteur Modem');
 WEBar(W);
 WELn(W);
 DBOpenServerName(ChantalServer,'CHANTAL:/Modem/Registers.Dat');
 DBFirst(ChantalServer);
 While Not DBEOF(ChantalServer)do Begin
  DBReadRec(ChantalServer,Data);
  Reg:=' (S'+WordToStr(Data.Code)+') '+Data.Description+':';
  ReadValue:=Read('AT S'+WordToStr(Data.Code)+'?');
  Case(Data.Mode)of
   0:WEPutTxtLnSBasB(W,Reg,ReadValue);
   1:WEPutTxtLnSBasBS(W,Reg,ReadValue,' seconde(s)');
   2:Begin
    C:=Read('AT S10?');
    WEPutTxtLnSBasBS(W,Reg,C div 10,StrPas(@DeSep)+WordToStr(C mod 10)+' seconde(s)');
   End;
   3:WEPutTxtLnSBasBS(W,Reg,ReadValue,' milliseconde(s)');
   4:WEPutTxtLnSBasBS(W,Reg,ReadValue,'/50 seconde(s)');
   5:_WEPutTxtLnSBSWC(W,Reg+' "',ReadValue);
  End;
 End;
 WEPutLastBar('Docteur de modem');
 While WEOk(W)do;
 WEDone(LW);
End;

Procedure DskInfo;
Var
 W,L:Window;
 I,Dsk:Byte;
 DskExst:Array[0..25]of Boolean;
 H,H2:ShortInt;
 K:Word;

 Procedure ReadMsg;Begin
  WEPutLastBar('Lecture d''information logique en cours...')
 End;

 Procedure UpDate;
 Var
  S:String;
  Serial,TS:LongInt;
  I,Len:Byte;
 Begin
  {$IFDEF Adele}
   If(IsLuxe)Then Len:=2
             Else Len:=1;
  {$ELSE}
   Len:=Length(LeftIcon);
  {$ENDIF}
  ReadMsg;
  WESetKrHigh(W);
  S:=GetDskLabel(Dsk+1);
  If S=''Then S:='Absent';
  If(IsGrf)Then I:=40 Else I:=wnMax;
  WEClrWnBorder(W,22,2,I,wnMax);
  WEPutTxtXY(W,22,2,S);
  WEPutTxtXY(W,22,3,GetSerialNmStr(Dsk));
  If IsCDROM(Dsk)Then WEPutTxtXY(W,22,4,'CD-ROM')Else
  If IsRAMDrive(Dsk)Then WEPutTxtXY(W,22,4,'RAM Virtuel')Else
  If DiskFixed(Dsk+1)Then WEPutTxtXY(W,22,4,'Fixe')
                     Else WEPutTxtXY(W,22,4,'Amovible');
  Serial:=DiskSize(Dsk+1);
  If Serial=-1Then For I:=5to 9do WEPutTxtXY(W,22,I,'Unit‚ non prˆte')
   Else
  Begin
   If Serial=0Then S:='0 octet'
              Else S:=CStr(Serial)+' octets';
   WEPutTxtXY(W,22,5,S);
   TS:=DiskUsed(Dsk+1);
   If TS=0Then S:='0 octet'
          Else S:=CStr(TS)+' octets';
   WEPutTxtXY(W,22,6,S);
   TS:=DiskFree(Dsk+1);
   If TS=0Then S:='0 octet'
          Else S:=CStr(TS)+' octets';
   WEPutTxtXY(W,22,7,S);
   TS:=ClusterSize(Dsk+1);
   If TS=0Then S:='0 octet'
          Else S:=CStr(TS)+' octets';
   WEPutTxtXY(W,22,8,S);
   TS:=NmCluster(Dsk+1);
   If TS=0Then S:='0 octet'
          Else S:=CStr(TS)+' octets';
   WEPutTxtXY(W,22,9,S);
  End;
  If(HelpBar)Then Begin
   SetAllKr($1B,$1F);
   WEPutLastBar('^'+Spc(Len)+'^ Pr‚c‚dent  ^'+Spc(Len)+
 	      '^ Prochain  ^Esc^ Sortir^');
   {$IFDEF Adele}
    LeftIcon(2,MaxYTxts,$1B);
    RightIcon(16,MaxYTxts,$1B);
   {$ELSE}
    _PutTxtXY(2,MaxYTxts,LeftIcon);
    _PutTxtXY(16,MaxYTxts,RightIcon);
   {$ENDIF}
  End;
 End;

 Procedure Bar;Begin
  H:=Dsk*3-1;H2:=H+2;If H<0Then H:=0;
  WEBarSelHor(W,H,0,H2);
 End;

 Procedure SelBar;Begin
  WESetKrSel(W);
  Bar;
 End;

 Procedure UnSelBar;Begin
  If DskExst[Dsk]Then WESetKrHigh(W)
                 Else WESetKrBorder(W);
  Bar;
 End;

Begin
 WEPushEndBar(L);
 ReadMsg;
 WEInitO(W,77,11);
 WEPushWn(W);
 WEPutWnKrDials(W,'Information Disque Logique');
 WECloseIcon(W);
 Dsk:=GetDsk;
 For I:=0to 25do Begin
  DskExst[I]:=DiskExist(I);
  If DskExst[I]Then WESetKrHigh(W)Else WESetKrBorderF(W,$8);
  WESetCube(W,I*3,0,Chr(I+65));
  If(Dsk=I)Then SelBar;
 End;
 WESetKrBorder(W);
 WEPutTxtXY(W,0,1,MultChr('Ä',W.MaxX+1));
 WELn(W);
 WEPutTxtLn(W,'Nom du volume:');
 WEPutTxtLn(W,'Num‚ro de s‚rie:');
 WEPutTxtLn(W,'Type de disque:');
 WEPutTxtLn(W,'Taille du disque:');
 WEPutTxtLn(W,'Espace utilis‚:');
 WEPutTxtLn(W,'Espace de libre:');
 WEPutTxtLn(W,'Taille d''une unit‚ a.:');
 WEPutTxtLn(W,'Nombre d''unit‚ all.:');
 UpDate;
 RIMediaImage(imDrive,W,1,0,GetRawY(9),8);
 Repeat
  K:=WEReadk(W);
  Case(K)of
   kbInWn:Begin
    If LastMouseB>0Then Begin
     Dec(LastMouseY,WEGetRY1(W));
     Dec(LastMouseX,WEGetRX1(W));
     If LastMouseY=0Then Begin
      WaitMouseBut0;
      I:=(LastMouseX+1)div 3;
      If DskExst[I]Then Begin
       UnSelBar;
       Dsk:=I;
       SelBar;
       UpDate;
      End;
     End;
    End;
   End;
   kbLeft:Begin
    UnSelBar;
    Repeat
     If Dsk=0Then Dsk:=25
             Else Dec(Dsk)
    Until DskExst[Dsk];
    SelBar;
    UpDate;
   End;
   kbRight:Begin
    UnSelBar;
    Repeat
     Inc(Dsk);
     If Dsk>25Then Dsk:=0
    Until DskExst[Dsk];
    SelBar;
    UpDate;
   End;
   kbEsc,kbClose:Break;
  End;
 Until No;
 WEDone(W);
 WEDone(L);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                    Proc‚dure SoundCardInfo                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction retourne des informations con‡ernant les cartes de
 son install‚.
}

Procedure SoundCardInfo;
Var
 W:Window;
 X,Y,I,J:Word;
 Color:Byte;
Begin
 If(IsAdLib)or(IsGravis)or(IsRoland)or(IsSoundBlaster)or(IsTandyDigital)Then Begin
  WEInitO(W,40,14);
  WEPushWn(W);
  WEPutWnKrDials(W,'Information sur la Carte de son');
  If BitsPerPixel>=4Then Begin
   LoadQQF('GLYPHS.QQF|glyphs 18');
   X:=WEGetRX1(W)shl 3;Y:=WEGetRY1(W)*HeightChr;
   Color:=(W.CurrColor and$F0)+((W.CurrColor shr 4)and 7);
   For J:=0to(W.MaxY*HeightChr)div 40do
    For I:=0to W.MaxX shr 2do
     OutTextXY(X+(I shl 5),Y+J*40,'G',Color);
   For J:=0to((W.MaxY*HeightChr)div 40)-1do
    For I:=0to(W.MaxX shr 2)-1do
     OutTextXY(X+(I shl 5)+16,Y+J*40+20,'G',Color);
  End;
  WELn(W);
  WEBar(W);
  WEPutTxtLnSB(W,'Supporte le mode AdLib:',IsAdLib);
  WEPutTxtLnSB(W,'Supporte le mode Gravis:',IsGravis);
  WEPutTxtLnSB(W,'Supporte le mode Roland/Midi:',IsRoland);
  WEPutTxtLnSB(W,'Supporte le mode SoundBlaster:',IsSoundBlaster);
  WEPutTxtLnSB(W,'Supporte le mode digital de Tandy:',IsTandyDigital);
  WELn(W);WESetKrBorder(W);
  WEPutTxtT(W,'Adresse de base du port E/S: ');
  WESetKrHigh(W);
  WEPutTxtTLn(W,HexWord2Str(SoundPort)+'h');
  WESetKrBorder(W);
  WEPutTxtT(W,'Canal DMA utilis‚:           ');
  WESetKrHigh(W);
  WEPutTxtTLn(W,WordToStr(DMAChannel));
  WESetKrBorder(W);
  WEPutTxtT(W,'M‚moire sur la carte de son:');
  WESetKrHigh(W);
  WEPutTxtTLn(W,BasicStrW(SoundMem)+' Ko');
  While WEOk(W)do;
 End
  Else
 ErrNoMsgOk(errSoundCardRequered);
End;

Procedure MouseExternProc(Var R:ResourceWindow;Var Context);Begin
 RIMediaImage(imMouse,R.W,1,1,GetRawY(10),0);
 __InitMouse;
End;

Procedure MouseInfo;
Var
 _AX23,_BX23,_AX:Word;
 _CL:Byte;
 P:^TByte;
 FormMouse:Record
  Size:MSizeRelative;
  Modele:String[30];
  TypeBus:String[30];
  VersionStr:String[20];
  Langage:Boolean;
  LangageStr:String[30];
  Button:String[20];
  Interruption:Boolean;
  InterruptionStr:String[30];
  RegistreEGA:String[20];
  Version:Boolean;
  RegEGAVersion:String[30];
  MickeysPixelH:String[20];
  MickeysPixelV:String[20];
  Proc:MExtern;
 End;
Begin
 If Adele.Mouse=0Then ErrNoMsgOk(errMouseNotFound)
  Else
 Begin
  FillClr(FormMouse,SizeOf(FormMouse));
  P:=EGARegister;
  FormMouse.Version:=PtrRec(P).Ofs<>0;
  ASM
   MOV AX,0023h
   INT 33h
   MOV _AX23,AX
   MOV _BX23,BX
   MOV AX,0024h
   INT 33h
   MOV _AX,AX
   MOV _CL,CL
  END;
  If(IsGrf)Then FormMouse.Size.Length:=56
           Else FormMouse.Size.Length:=40;
  FormMouse.Langage:=_AX23<$FFFF;
  FormMouse.Interruption:=_AX<$FFFF;
  FormMouse.Size.Height:=12+Byte(FormMouse.Interruption)+Byte(FormMouse.Langage)+Byte(FormMouse.Version);
  Case(Adele.Mouse)of
   msLogitech:FormMouse.Modele:='Logitech';
   msMicrosoft:FormMouse.Modele:='Microsoft';
   msSmooth:FormMouse.Modele:='Smooth d''Andy Hakim';
   msZNIX:FormMouse.Modele:='Z-NIX';
   msGenius:FormMouse.Modele:='Genius';
   msPS2:FormMouse.Modele:='PS2';
   Else FormMouse.Modele:='Inconnu';
  End;
  Case(BusType)of
   $01:FormMouse.TypeBus:='Bus';
   $02:FormMouse.TypeBus:='S‚rie';
   $03:FormMouse.TypeBus:='Inport';
   $04:FormMouse.TypeBus:='PS/2';
   $05:FormMouse.TypeBus:='HP';
   Else If(VideoMousePortFound)Then FormMouse.TypeBus:='S‚rie sur carte vid‚o'
                               Else FormMouse.TypeBus:='S‚rie';
  End;
  FormMouse.VersionStr:=GetMsVer;
  If(FormMouse.Langage)Then Begin
   FormMouse.LangageStr:=SelectField('CHANTAL:/Systeme/Langues.Dat',_BX23,1);
  End;
  If MsButton=0Then FormMouse.Button:='Inconnu'
               Else FormMouse.Button:=WordToStr(MsButton);
  If(FormMouse.Interruption)Then Begin
   Case(_CL)of
    $00:FormMouse.InterruptionStr:='PS/2';
    $02..$05,$07:FormMouse.InterruptionStr:='IRQ'+WordToStr(_CL);
    Else FormMouse.InterruptionStr:='inconnu: '+HexByte2Str(_CL)+'h';
   End;
  End;
  If(FormMouse.Version)Then Begin
   FormMouse.RegistreEGA:='Support‚';
   FormMouse.RegEGAVersion:=WordToStr(ToBCD(P^[0]))+DeSep[0]+WordToStr(ToBCD(P^[1]));
  End
   Else
  FormMouse.RegistreEGA:='Non-support‚';
  FormMouse.MickeysPixelH:=WordToStr(MickeysPixelHorizontal);
  FormMouse.MickeysPixelV:=WordToStr(MickeysPixelVertical);
  If(MediaSupport)Then FormMouse.Proc.Call:=MouseExternProc;
  ExecuteAppDPU(131,FormMouse);
 End;
End;

Procedure JoyExternProc(Var R:ResourceWindow;Var Context);
Var
 YE:Byte;
Begin
 If HeightChr>8Then YE:=HeightChr-8
               Else YE:=0;
 RIMediaImage(imJoystick,R.W,0,0,GetRawY(8)+YE,0);
End;

Procedure JoystickInfo;
Var
 Data:Record
  IsGrf:Boolean;
  CaptionJoyExist:String[3];
  CaptionBiosJoy:String[3];
  CaptionJoyPort:String[5];
  CaptionJoyPotentioMeter:String[10];
  Proc:MExtern;
 End;
Begin
 FillClr(Data,SizeOf(Data));
 Data.IsGrf:=IsGrf;
 If(JoyExist)Then Data.CaptionJoyExist:='Oui'
             Else Data.CaptionJoyExist:='Non';
 If(MediaSupport)Then Data.Proc.Call:=JoyExternProc;
 If(BiosJoy)Then Data.CaptionBiosJoy:='Oui'
            Else Data.CaptionBiosJoy:='Non';
 Data.CaptionJoyPort:=HexWord2Str(JoyPort);
 IncStr(Data.CaptionJoyPort,'h');
 Data.CaptionJoyPotentioMeter:=WordToStr(JoyPotentioMeter);
 ExecuteAppDPU(66,Data);
End;

Procedure KeyboardInfo;
Var
 Data:Record
  IsGrf:Boolean;
  CaptionKbdModel:String[35];
  CaptionKbdCtrl:String[30];
  CaptionKbdReadPort:String[5];
  CaptionSizeMem:String[20];
  CaptionAddrMem:String[20];
  CaptionBreak:String[20];
  CaptionBiosKbdEnh:String[3];
  CaptionIRQ:String[20];
  CaptionIntr:String[20];
 End;
Begin
 FillClr(Data,SizeOf(Data));
 Data.IsGrf:=IsGrf;
 Case(KbdModel)of
  kbConterm:Data.CaptionKbdModel:='Conterm Max/int‚gr‚ au boŒtier';
  kbPC:Data.CaptionKbdModel:='PC';
  kbXT:Data.CaptionKbdModel:='XT';
  kbAT:Data.CaptionKbdModel:='AT (84 touches)';
  kbMF:Data.CaptionKbdModel:='MF (101 … 104 touches)';
  Else Data.CaptionKbdModel:='';
 End;
 Case(KbdCtrl)of
  ctrlkbNo:Data.CaptionKbdCtrl:='Pas de contr“leur!';
  ctrlkbUnknown:Data.CaptionKbdCtrl:='Inconnu';
  ctrlkb8048:Data.CaptionKbdCtrl:='PC, XT, PC Junior (8048)';
  ctrlkb8042:Data.CaptionKbdCtrl:='AT, PS/1, PS/2 (8042)';
 End;
 Data.CaptionKbdReadPort:=HexWord2Str(KbdReadPort);
 IncStr(Data.CaptionKbdReadPort,'h');
 Data.CaptionSizeMem:={$IFDEF __Windows__}
                       '16'+
                      {$ELSE}
                       WordToStr(MemW[_0040:$82]-MemW[_0040:$80])+
                      {$ENDIF}
                      ' octets';
 Data.CaptionAddrMem:='0040h:'+
                      {$IFDEF __Windows__}
                       '????'+
                      {$ELSE}
                       HexWord2Str(MemW[_0040:$80])+
                      {$ENDIF}
                      'h';
 {$IFDEF __Windows__}
  Data.CaptionBreak:='Inconnu';
 {$ELSE}
  If Mem[_0040:$71]and$80=$80Then Data.CaptionBreak:='Oui'
                             Else Data.CaptionBreak:='Non';
 {$ENDIF}
 If(BiosKbdEnh)Then Data.CaptionBiosKbdEnh:='Oui'
               Else Data.CaptionBiosKbdEnh:='Non';
 {$IFNDEF FLAT386}
  If Port[$21]and 2=0Then Begin
   Data.CaptionIRQ:='IRQ1';
   Data.CaptionIntr:='09h';
  End
   Else
 {$ENDIF}
 Begin
  Data.CaptionIRQ:='Introuvable!';
  Data.CaptionIntr:='Introuvable!';
 End;
 ExecuteAppDPU(67,Data);
End;

Procedure WindowSommary;
Var
 PLM:LstMnu;
 S:String;
 I:Integer;
Begin
 LMInitKrDials(PLM,20,5,MaxXTxts-20,MaxYTxts-5,'Port d''entr‚e/Sortie');
 S:=HexWord2Str(KbdReadPort)+'h  Contr“leur clavier ';
 Case(KbdCtrl)of
  ctrlkbNo:AddStr(S,'pas de contr“leur!');
  ctrlkbUnknown:AddStr(S,'inconnu');
  ctrlkb8048:AddStr(S,'8048');
  ctrlkb8042:AddStr(S,'8042');
 End;
 ALAddStr(PLM.List,S);
 ALAddStr(PLM.List,HexWord2Str(CmosPort)+'h  Horloge sur pile CMOS');
 ALAddStr(PLM.List,HexWord2Str(JoyPort)+'h  Contr“leur de manette de jeux');
 ALAddStr(PLM.List,HexWord2Str(SoundPort)+'h  Contr“leur de carte de son');
 For I:=0to NmSerial-1do Begin
  ALAddStr(PLM.List,HexWord2Str(ComPortAddr(I))+'h  Port de communication s‚rie '+Chr(49+I));
 End;
 ALTri(PLM.List);
 LMRun(PLM);
 LMDone(PLM);
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
END.