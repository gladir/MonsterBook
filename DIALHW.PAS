{ Cette unit‚ est destin‚ … offrir des services de boŒte de dialogue sur
 de l'information mat‚riel.
}

Unit DialHW;

{$I DEF.INC}

INTERFACE

Procedure CmosSetup(Const Title:String);
Procedure ClockSetup(Const Title:String);
Procedure CPUSetup(Const Title:String);
Procedure DisketteSetup(Const Title:String);
Procedure IRQSetup(Const Title:String);
Procedure JoystickSetup(Const Title:String);
Procedure KeyboardSetup(Const Title:String);
Procedure MouseSetup(Const Title:String);
Procedure PcSpeakerSetup(Const Title:String);
Procedure SCSISetup(Const Title:String);
Procedure VideoSetup(Const Title:String;Num:Byte);

IMPLEMENTATION

Uses Systex,Restex,Dialex,Isatex,Adele,CommBase,Memories,Systems,DialPlus,
     Dials,ResLoadI,ResServI;

Function PortStr:String;Near;Begin
 PortStr:=StrUSpc('Plage d''entr‚e/sortie',29);
End;

Procedure ALPortDelta(Var List:ArrayList;PortA,PortB:Word);Near;Begin
 ALAddStr(List,StrUSpc(PortStr+HexWord2Str(PortA)+'h … '+HexWord2Str(PortB)+'h',60));
End;

Function MemStr:String;Near;Begin
 MemStr:=StrUSpc('Plage m‚moire',29);
End;

Procedure ALMemDelta(Var List:ArrayList;SegA,OfsA,SegB,OfsB:Word);Near;Begin
 ALAddStr(List,StrUSpc(MemStr+HexLong2Str((LongInt(SegA) shl 4)+OfsA)+'h … '+
                       HexLong2Str((LongInt(SegB)shl 4)+OfsB)+'h',60));
End;

Function IRQStr:String;Near;Begin
 IRQStr:=StrUSpc('Requˆte d''interruption (IRQ)',29);
End;

Function DMAStr:String;Near;Begin
 DMAStr:=StrUSpc('AccŠs directe m‚moire (DMA)',29);
End;

Procedure ChipPutIcon(X,Y:Byte;P:Word;Var Context);
Var
 L:LstMnu Absolute Context;
 Icon:XInf;
Begin
 RILoadImage('SYS:MEDIA.RLL',diAutoDetect,0,29,rmAllRes,[],Icon);
 RIPutImageScale(Icon,X shl 3,GetRawY(Y),16,HeightChr,CurrKrs.Dialog.Env.List.Border shr 4);
 XFreeMem(Icon);
End;

Procedure ResOnRefresh(Var Q;Var Context);
Var
 L:LstMnu Absolute Q;
 LT:ListTitle;
Begin
 WESetHomeLine(L.W,0);
 LTInitWithWins(LT,0,0,L.W.MaxX,'Type de ressource|ParamŠtre',L.W);
 WESetHomeLine(L.W,1);
 LTSetColumnSize(LT,0,28+(Byte(IsGrf)shl 1));
 LTRefresh(LT);
End;

Procedure ProgrammingBar(Var L:LstMnu);Begin
 L.Context:=@L;
 If(IsGrf)Then Begin
  L.IconRoutine:=ChipPutIcon;
  L.Space4Icon:=2;
 End;
 WESetHomeLine(L.W,1);
 L.OnRefresh:=ResOnRefresh;
End;

Procedure KeyboardLoadList(Var L:LstMnu;Var Context);
Var
 S:String;
Begin
 ProgrammingBar(L);
 {$IFNDEF FLAT386}
  If Port[PortCtrlIRQ0To7+1]and 2=0Then Begin
   S:='1';
  End
   Else
 {$ENDIF}
 S:='Inconnu!';
 ALAddStr(L.List,StrUSpc(IRQStr+S,60));
 ALPortDelta(L.List,KbdReadPort,KbdReadPort);
 ALPortDelta(L.List,KbdReadPort+4,KbdReadPort+4);
 {$IFNDEF __Windows__}
  ALMemDelta(L.List,_0040,MemW[_0040:$80],_0040,MemW[_0040:$82]);
 {$ENDIF}
End;

Procedure CmosLoadList(Var L:LstMnu;Var Context);Begin
 ProgrammingBar(L);
 {$IFNDEF FLAT386}
  If Port[$A1]and 1=0Then Begin
   ALAddStr(L.List,StrUSpc(IRQStr+'8',60));
  End;
 {$ENDIF}
 ALPortDelta(L.List,CmosPort,CmosPort+1);
End;

Procedure KeyboardSetup(Const Title:String);
Var
 FormKeyboardConfig:Record
  Title:String;
  TypePeriph:String[30];
  Exist:MCheckBox;
  Auto:MCheckBox;
  List:MListBox;
  Modified:MButton;
 End;
Begin
 FillClr(FormKeyboardConfig,SizeOf(FormKeyboardConfig));
 FormKeyboardConfig.List.LoadList:=KeyboardLoadList;
 FormKeyboardConfig.Exist.Checked:=True;
 FormKeyboardConfig.Auto.Checked:=True;
 FormKeyboardConfig.Title:=Title;
 FormKeyboardConfig.TypePeriph:='Clavier';
 If ExecuteAppDPU(124,FormKeyboardConfig)Then Begin
 End;
End;

Procedure JoystickLoadList(Var L:LstMnu;Var Context);Begin
 ProgrammingBar(L);
 ALPortDelta(L.List,JoyPort,JoyPort);
End;

Procedure JoystickSetup(Const Title:String);
Var
 FormJoystickConfig:Record
  Title:String;
  TypePeriph:String[30];
  Exist:MCheckBox;
  Auto:MCheckBox;
  List:MListBox;
  Modified:MButton;
 End;
Begin
 FillClr(FormJoystickConfig,SizeOf(FormJoystickConfig));
 FormJoystickConfig.List.LoadList:=JoystickLoadList;
 FormJoystickConfig.Exist.Checked:=True;
 FormJoystickConfig.Auto.Checked:=True;
 FormJoystickConfig.Title:=Title;
 FormJoystickConfig.TypePeriph:='Manette de jeux';
 If ExecuteAppDPU(124,FormJoystickConfig)Then Begin
 End;
End;

Procedure CmosSetup(Const Title:String);
Var
 FormCmosConfig:Record
  Title:String;
  TypePeriph:String[30];
  Exist:MCheckBox;
  Auto:MCheckBox;
  List:MListBox;
  Modified:MButton;
 End;
Begin
 FillClr(FormCmosConfig,SizeOf(FormCmosConfig));
 FormCmosConfig.List.LoadList:=CmosLoadList;
 FormCmosConfig.Exist.Checked:=True;
 FormCmosConfig.Auto.Checked:=True;
 FormCmosConfig.Title:=Title;
 FormCmosConfig.TypePeriph:='P‚riph‚rique systŠme';
 If ExecuteAppDPU(124,FormCmosConfig)Then Begin
 End;
End;

Procedure PCSpeakerLoadList(Var L:LstMnu;Var Context);Begin
 ProgrammingBar(L);
 ALPortDelta(L.List,PCSpeakerPort,PCSpeakerPort);
End;

Procedure PCSpeakerSetup(Const Title:String);
Var
 FormPCSpeakerConfig:Record
  Title:String;
  TypePeriph:String[30];
  Exist:MCheckBox;
  Auto:MCheckBox;
  List:MListBox;
  Modified:MButton;
 End;
Begin
 FillClr(FormPCSpeakerConfig,SizeOf(FormPCSpeakerConfig));
 FormPCSpeakerConfig.List.LoadList:=PCSpeakerLoadList;
 FormPCSpeakerConfig.Exist.Checked:=True;
 FormPCSpeakerConfig.Auto.Checked:=True;
 FormPCSpeakerConfig.Title:=Title;
 FormPCSpeakerConfig.TypePeriph:='Haut-parleur systŠme';
 If ExecuteAppDPU(124,FormPCSpeakerConfig)Then Begin
 End;
End;

Procedure SCSILoadList(Var L:LstMnu;Var Context);
Var
 X:Byte;
 PortAddr:Word;
Begin
 ProgrammingBar(L);
 {$IFNDEF __Windows__}
  PortAddr:=$140;
  X:=(Port[PortAddr+$A]shr 4)and 3;
  Case(X)of
   0:ALPortDelta(L.List,$140,$14F);
   1:ALPortDelta(L.List,$150,$15F);
   2:ALPortDelta(L.List,$160,$16F);
   3:ALPortDelta(L.List,$170,$17F);
  End;
  X:=Port[PortAddr+$A]shr 6;
  Case(X)of
   0:ALMemDelta(L.List,$C800,0,$C9FF,$F);
   1:ALMemDelta(L.List,$CA00,0,$CBFF,$F);
   2:ALMemDelta(L.List,$CE00,0,$CFFF,$F);
   3:ALMemDelta(L.List,$DE00,0,$DFFF,$F);
  End;
  Repeat
   X:=(Port[PortAddr+$A]shr 1)and 7;
   Case(X)of
    0:X:=3;
    1:X:=5;
    2:X:=10;
    3:X:=11;
    4:X:=12;
    5:X:=14;
    6:X:=15;
    7:Break;
   End;
   ALAddStr(L.List,StrUSpc(IRQStr+WordToStr(X),60));
  Until True;
 {$ELSE}
 {$ENDIF}
End;

Procedure SCSISetup(Const Title:String);
Var
 FormSCSIConfig:Record
  Title:String;
  TypePeriph:String[30];
  Exist:MCheckBox;
  Auto:MCheckBox;
  List:MListBox;
  Modified:MButton;
 End;
Begin
 FillClr(FormSCSIConfig,SizeOf(FormSCSIConfig));
 FormSCSIConfig.List.LoadList:=SCSILoadList;
 FormSCSIConfig.Exist.Checked:=True;
 FormSCSIConfig.Auto.Checked:=True;
 FormSCSIConfig.Title:=Title;
 FormSCSIConfig.TypePeriph:='Contr“leurs SCSI';
 If ExecuteAppDPU(124,FormSCSIConfig)Then Begin
 End;
End;

Procedure MouseLoadList(Var L:LstMnu;Var Context);Begin
 ProgrammingBar(L);
 {$IFNDEF __Windows__}
  If(Adele.Mouse=msCOM)Then Begin
   ALPortDelta(L.List,ComBase[ComLCR]and$FFF0,ComBase[ComLCR]or$F);
  End;
 {$ENDIF}
 ALAddStr(L.List,StrUSpc(IRQStr+WordToStr(IRQIntNumMouse),60));
End;

Procedure MouseSetup(Const Title:String);
Var
 FormMouseConfig:Record
  Title:String;
  TypePeriph:String[30];
  Exist:MCheckBox;
  Auto:MCheckBox;
  List:MListBox;
  Modified:MButton;
 End;
Begin
 FillClr(FormMouseConfig,SizeOf(FormMouseConfig));
 FormMouseConfig.List.LoadList:=MouseLoadList;
 FormMouseConfig.Exist.Checked:=True;
 FormMouseConfig.Auto.Checked:=True;
 FormMouseConfig.Title:=Title;
 FormMouseConfig.TypePeriph:='Souris';
 If ExecuteAppDPU(124,FormMouseConfig)Then Begin
 End;
End;

Procedure Video0LoadList(Var L:LstMnu;Var Context);
Var
 Port:Word;
 _PVid:Array[0..1]of PIV;
 Seg:Word;
 Size:Word;
Begin
 ProgrammingBar(L);
 GetPIV(_PVid[0]);
 GetPIVSec(_PVid[1]);
 Port:=VideoPort and$FFF0;
 ALPortDelta(L.List,Port,Port or$F);
 If(IsEGA)Then ALPortDelta(L.List,$3C0,$3CF);
 If(IsVGA)and(_PVid[1].Card=0)Then Begin
  ALPortDelta(L.List,Port xor $60,(Port xor $60)or$F);
 End;
 If GetVideoSeg shr 12=$BThen Size:=$7FFF
                         Else Size:=$FFFF;
 ALMemDelta(L.List,GetVideoSeg,0,GetVideoSeg,Size);
 ALMemDelta(L.List,_PVid[0].ROM,0,_PVid[0].ROM,$7FFF);
End;

Procedure Video1LoadList(Var L:LstMnu;Var Context);
Var
 Port:Word;
Begin
 ProgrammingBar(L);
 Port:=(VideoPort xor $60)and$FFF0;
 ALPortDelta(L.List,Port,Port+$F);
End;

Procedure VideoSetup(Const Title:String;Num:Byte);
Var
 FormVideoConfig:Record
  Title:String;
  TypePeriph:String[30];
  Exist:MCheckBox;
  Auto:MCheckBox;
  List:MListBox;
  Modified:MButton;
 End;
Begin
 FillClr(FormVideoConfig,SizeOf(FormVideoConfig));
 If Num=1Then FormVideoConfig.List.LoadList:=Video1LoadList
         Else FormVideoConfig.List.LoadList:=Video0LoadList;
 FormVideoConfig.Exist.Checked:=True;
 FormVideoConfig.Auto.Checked:=True;
 FormVideoConfig.Title:=Title;
 FormVideoConfig.TypePeriph:='Carte graphiques';
 If ExecuteAppDPU(124,FormVideoConfig)Then Begin
 End;
End;

Procedure DisketteLoadList(Var L:LstMnu;Var Context);Begin
 ProgrammingBar(L);
 ALAddStr(L.List,StrUSpc(DMAStr+WordToStr(DisketteDMA),60));
 ALPortDelta(L.List,DiskettePort,DiskettePort+3);
 ALAddStr(L.List,StrUSpc(IRQStr+WordToStr(DisketteIRQ),60));
End;

Procedure DisketteSetup(Const Title:String);
Var
 FormDisketteConfig:Record
  Title:String;
  TypePeriph:String[30];
  Exist:MCheckBox;
  Auto:MCheckBox;
  List:MListBox;
  Modified:MButton;
 End;
Begin
 FillClr(FormDisketteConfig,SizeOf(FormDisketteConfig));
 FormDisketteConfig.List.LoadList:=DisketteLoadList;
 FormDisketteConfig.Exist.Checked:=True;
 FormDisketteConfig.Auto.Checked:=True;
 FormDisketteConfig.Title:=Title;
 FormDisketteConfig.TypePeriph:='Contr“leur de disquette';
 If ExecuteAppDPU(124,FormDisketteConfig)Then Begin
 End;
End;

Procedure IRQLoadList(Var L:LstMnu;Var Context);Begin
 ProgrammingBar(L);
 ALAddStr(L.List,StrUSpc(IRQStr+WordToStr(IRQCtrlIRQ),60));
 ALPortDelta(L.List,PortCtrlIRQ0To7,PortCtrlIRQ0To7+1);
 {$IFNDEF __Windows__}
  If MachineID<=$FCThen
   ALPortDelta(L.List,PortCtrlIRQ8To15,PortCtrlIRQ8To15+1);
 {$ENDIF}
End;

Procedure IRQSetup(Const Title:String);
Var
 FormIRQConfig:Record
  Title:String;
  TypePeriph:String[30];
  Exist:MCheckBox;
  Auto:MCheckBox;
  List:MListBox;
  Modified:MButton;
 End;
Begin
 FillClr(FormIRQConfig,SizeOf(FormIRQConfig));
 FormIRQConfig.List.LoadList:=IRQLoadList;
 FormIRQConfig.Exist.Checked:=True;
 FormIRQConfig.Auto.Checked:=True;
 FormIRQConfig.Title:=Title;
 FormIRQConfig.TypePeriph:='P‚riph‚rique systŠme';
 If ExecuteAppDPU(124,FormIRQConfig)Then Begin
 End;
End;

Procedure ClockLoadList(Var L:LstMnu;Var Context);Begin
 ProgrammingBar(L);
 ALAddStr(L.List,StrUSpc(IRQStr+WordToStr(IRQClock),60));
 ALPortDelta(L.List,PortClock,PortClock+3);
End;

Procedure ClockSetup(Const Title:String);
Var
 FormClockConfig:Record
  Title:String;
  TypePeriph:String[30];
  Exist:MCheckBox;
  Auto:MCheckBox;
  List:MListBox;
  Modified:MButton;
 End;
Begin
 FillClr(FormClockConfig,SizeOf(FormClockConfig));
 FormClockConfig.List.LoadList:=ClockLoadList;
 FormClockConfig.Exist.Checked:=True;
 FormClockConfig.Auto.Checked:=True;
 FormClockConfig.Title:=Title;
 FormClockConfig.TypePeriph:='P‚riph‚rique systŠme';
 If ExecuteAppDPU(124,FormClockConfig)Then Begin
 End;
End;

Procedure CPULoadList(Var L:LstMnu;Var Context);Begin
 ProgrammingBar(L);
 If(CPUVendor=cvCyrix)Then ALPortDelta(L.List,$22,$23);
End;

Procedure CPUSetup(Const Title:String);
Var
 FormCPUConfig:Record
  Title:String;
  TypePeriph:String[30];
  Exist:MCheckBox;
  Auto:MCheckBox;
  List:MListBox;
  Modified:MButton;
 End;
Begin
 FillClr(FormCPUConfig,SizeOf(FormCPUConfig));
 FormCPUConfig.List.LoadList:=CPULoadList;
 FormCPUConfig.Exist.Checked:=True;
 FormCPUConfig.Auto.Checked:=True;
 FormCPUConfig.Title:=Title;
 FormCPUConfig.TypePeriph:='P‚riph‚rique systŠme';
 If ExecuteAppDPU(124,FormCPUConfig)Then Begin
 End;
End;

END.
