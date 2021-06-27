{\Source\Chantal\RLL\Video\VideoMod.Inc}

{$I \Source\Chantal\Library\Video\Driver.Inc}

Const SizeOfInfo=SizeOf(MIV);

{$I \Source\Chantal\Library\Video\MalteSVM.Inc}

{$IFNDEF DPMI}
 Type
  TableIntRec=Array[0..255]of Pointer;
 Var
  TableInt:TableIntRec Absolute 0:0;
{$ENDIF}

Function SetVidModeMDAPrim(Mode:Wd;Var Q:MIV):Byte;{$IFDEF DPMI}Far{$ELSE}Near{$ENDIF};Forward;
Function SetVidModeMDASec(Mode:Wd;Var Q:MIV):Byte;{$IFDEF DPMI}Far{$ELSE}Near{$ENDIF};Forward;
Function SetVidModeHerculePrim(Mode:Wd;Var Q:MIV):Byte;{$IFDEF DPMI}Far{$ELSE}Near{$ENDIF};Forward;
Function SetVidModeHerculeSec(Mode:Wd;Var Q:MIV):Byte;{$IFDEF DPMI}Far{$ELSE}Near{$ENDIF};Forward;
Function SetVidModeHp95LXPrim(Mode:Wd;Var Q:MIV):Byte;{$IFDEF DPMI}Far{$ELSE}Near{$ENDIF};Forward;
Function SetVidModeCGAPrim(Mode:Wd;Var Q:MIV):Byte;{$IFDEF DPMI}Far{$ELSE}Near{$ENDIF};Forward;
Function SetVidModeCGASec(Mode:Wd;Var Q:MIV):Byte;{$IFDEF DPMI}Far{$ELSE}Near{$ENDIF};Forward;
Function SetVidModeGSPrim(Mode:Wd;Var Q:MIV):Byte;{$IFDEF DPMI}Far{$ELSE}Near{$ENDIF};Forward;
Function SetVidModeGSSec(Mode:Wd;Var Q:MIV):Byte;{$IFDEF DPMI}Far{$ELSE}Near{$ENDIF};Forward;
Function SetVidModeGSEmulPrim(Mode:Wd;Var Q:MIV):Byte;{$IFDEF DPMI}Far{$ELSE}Near{$ENDIF};Forward;
Function SetVidModeGSEmulSec(Mode:Wd;Var Q:MIV):Byte;{$IFDEF DPMI}Far{$ELSE}Near{$ENDIF};Forward;
Function SetVidModePCJrPrim(Mode:Wd;Var Q:MIV):Byte;{$IFDEF DPMI}Far{$ELSE}Near{$ENDIF};Forward;
Function SetVidModeTandy1000Prim(Mode:Wd;Var Q:MIV):Byte;{$IFDEF DPMI}Far{$ELSE}Near{$ENDIF};Forward;
Function SetVidModeEGAPrim(Mode:Wd;Var Q:MIV):Byte;{$IFDEF DPMI}Far{$ELSE}Near{$ENDIF};Forward;
Function SetVidModeAheadEGA2001Prim(Mode:Wd;Var Q:MIV):Byte;{$IFDEF DPMI}Far{$ELSE}Near{$ENDIF};Forward;
Function SetVidModeATT6300Prim(Mode:Wd;Var Q:MIV):Byte;{$IFDEF DPMI}Far{$ELSE}Near{$ENDIF};Forward;
Function SetVidModeEGAWonderPrim(Mode:Wd;Var Q:MIV):Byte;{$IFDEF DPMI}Far{$ELSE}Near{$ENDIF};Forward;
Function SetVidModeLavaChromeIIEGAPrim(Mode:Wd;Var Q:MIV):Byte;{$IFDEF DPMI}Far{$ELSE}Near{$ENDIF};Forward;
Function SetVidModeParadiseEGA480Prim(Mode:Wd;Var Q:MIV):Byte;{$IFDEF DPMI}Far{$ELSE}Near{$ENDIF};Forward;
Function SetVidModeTaxan565EGAPrim(Mode:Word;Var Q:MIV):Byte;{$IFDEF DPMI}Far{$ELSE}Near{$ENDIF};Forward;
Function SetVidModeUltraVisionEGAPrim(Mode:Wd;Var Q:MIV):Byte;{$IFDEF DPMI}Far{$ELSE}Near{$ENDIF};Forward;
Function SetVidModeVGAPrim(Mode:Wd;Var Q:MIV):Byte;{$IFDEF DPMI}Far{$ELSE}Near{$ENDIF};Forward;
Function SetVidModeAheadBPrim(Mode:Wd;Var Q:MIV):Byte;{$IFDEF DPMI}Far{$ELSE}Near{$ENDIF};Forward;
Function SetVidModeAllStarPeacockPrim(Mode:Wd;Var Q:MIV):Byte;{$IFDEF DPMI}Far{$ELSE}Near{$ENDIF};Forward;
Function SetVidModeASTVGAPlusPrim(Mode:Wd;Var Q:MIV):Byte;{$IFDEF DPMI}Far{$ELSE}Near{$ENDIF};Forward;
Function SetVidModeATTVDC600Prim(Mode:Wd;Var Q:MIV):Byte;{$IFDEF DPMI}Far{$ELSE}Near{$ENDIF};Forward;
Function SetVidModeCardinalPrim(Mode:Wd;Var Q:MIV):Byte;{$IFDEF DPMI}Far{$ELSE}Near{$ENDIF};Forward;
Function SetVidModeCirrusPrim(Mode:Wd;Var Q:MIV):Byte;{$IFDEF DPMI}Far{$ELSE}Near{$ENDIF};Forward;
Function SetVidModeEverexPrim(Mode:Wd;Var Q:MIV):Byte;{$IFDEF DPMI}Far{$ELSE}Near{$ENDIF};Forward;
Function SetVidModeGenoaPrim(Mode:Wd;Var Q:MIV):Byte;{$IFDEF DPMI}Far{$ELSE}Near{$ENDIF};Forward;
Function SetVidModeHPD1180APrim(Mode:Wd;Var Q:MIV):Byte;{$IFDEF DPMI}Far{$ELSE}Near{$ENDIF};Forward;
Function SetVidModeMorseVGAPrim(Mode:Wd;Var Q:MIV):Byte;{$IFDEF DPMI}Far{$ELSE}Near{$ENDIF};Forward;
Function SetVidModeOakPrim(Mode:Wd;Var Q:MIV):Byte;{$IFDEF DPMI}Far{$ELSE}Near{$ENDIF};Forward;
Function SetVidModeOrchidPrim(Mode:Wd;Var Q:MIV):Byte;{$IFDEF DPMI}Far{$ELSE}Near{$ENDIF};Forward;
Function SetVidModeOrchidProPrim(Mode:Wd;Var Q:MIV):Byte;{$IFDEF DPMI}Far{$ELSE}Near{$ENDIF};Forward;
Function SetVidModeParadisePrim(Mode:Wd;Var Q:MIV):Byte;{$IFDEF DPMI}Far{$ELSE}Near{$ENDIF};Forward;
Function SetVidModeRealtekRTVGAPrim(Mode:Wd;Var Q:MIV):Byte;{$IFDEF DPMI}Far{$ELSE}Near{$ENDIF};Forward;
Function SetVidModeSigmaPrim(Mode:Wd;Var Q:MIV):Byte;{$IFDEF DPMI}Far{$ELSE}Near{$ENDIF};Forward;
Function SetVidModeSTBPrim(Mode:Wd;Var Q:MIV):Byte;{$IFDEF DPMI}Far{$ELSE}Near{$ENDIF};Forward;
Function SetVidModeTatungVGAPrim(Mode:Wd;Var Q:MIV):Byte;{$IFDEF DPMI}Far{$ELSE}Near{$ENDIF};Forward;
Function SetVidModeTecmarVGAADPrim(Mode:Wd;Var Q:MIV):Byte;{$IFDEF DPMI}Far{$ELSE}Near{$ENDIF};Forward;
Function SetVidModeTridentPrim(Mode:Wd;Var Q:MIV):Byte;{$IFDEF DPMI}Far{$ELSE}Near{$ENDIF};Forward;
Function SetVidModeTsengET4000Prim(Mode:Wd;Var Q:MIV):Byte;{$IFDEF DPMI}Far{$ELSE}Near{$ENDIF};Forward;
Function SetVidModeTsengET4000HiColorPrim(Mode:Wd;Var Q:MIV):Byte;{$IFDEF DPMI}Far{$ELSE}Near{$ENDIF};Forward;
Function SetVidModeVGAWonderPrim(Mode:Wd;Var Q:MIV):Byte;{$IFDEF DPMI}Far{$ELSE}Near{$ENDIF};Forward;
Function SetVidModeVESAPrim(Mode:Wd;Var Q:MIV):Byte;{$IFDEF DPMI}Far{$ELSE}Near{$ENDIF};Forward;
Function SetVidModeVideo7Prim(Mode:Wd;Var Q:MIV):Byte;{$IFDEF DPMI}Far{$ELSE}Near{$ENDIF};Forward;
Function SetVidModeXGAPrim(Mode:Wd;Var Q:MIV):Byte;{$IFDEF DPMI}Far{$ELSE}Near{$ENDIF};Forward;

{$IFNDEF DPMI}
 Procedure ClearFlag;Near;Forward;
{$ELSE}
 Type ProcSetVidModType=Function(Mode:Wd;Var Q:MIV):Byte;
 Var ClearFlag:Boolean;
 Function viSetVideoModePrim(Mode:Wd;Var P:PIV;Var Q:MIV):Byte;Export;Forward;
{$ENDIF}

{$IFNDEF DPMI}
 Procedure _VideoMode;Assembler;ASM
  JMP SetVideoModePrim.Near
  JMP SetVideoSizePrim.Near
 END;
{$ENDIF}

Procedure RegTxt80x25;Near;Assembler;ASM DB $71,$50,$5A,$0A,$1F,$06,$19,$1C,$02,$07;END;
Procedure RegTxt132x25;Near;Assembler;ASM DB $B5,$84,$97,$0A,$1F,$06,$19,$1C,$02,$07;END;
Procedure RegTxt132x28;Near;Assembler;ASM DB $B5,$84,$97,$0A,$1F,$06,$1C,$1C,$02,$07;END;
Procedure Reg320x200c16;Near;Assembler;ASM DB $38,$28,$2D,$0A,$7F,$06,$64,$70,$02,$01;END;
Procedure Reg320x200c16Emul;Near;Assembler;ASM DB $36,$28,$2D,$08,$64,$06,$64,$64,$02,$07;END;
Procedure Reg640x200c16;Near;Assembler;ASM DB $70,$50,$58,$0A,$40,$06,$32,$38,$02,$03;END;
Procedure Reg640x200c16Emul;Near;Assembler;ASM DB $61,$50,$52,$08,$32,$06,$32,$32,$02,$07;END;

{$IFDEF DPMI}
 Function viSetVideoSizePrim
{$ELSE}
 Function SetVideoSizePrim
{$ENDIF}
(Grf,Length,Height:Wd;Var P:PIV;Var Q:MIV):Byte;{$IFDEF DPMI}Export;{$ENDIF}Var Base:Wd;Begin
 Base:=vmNone;{$IFDEF DPMI}viSetVideoSizePrim{$ELSE}SetVideoSizePrim{$ENDIF}:=$FF;
 Case(Grf)of
  24:Case(Length)of
   640:Case(Length)of
    480:Base:=vmGrf640x480c16M;
   End;
  End;
  16:Case(Length)of
   320:Case(Height)of
    200:Base:=vmGrf320x200c65536;
   End;
   640:Case(Height)of
    480:Base:=vmGrf640x480c65536;
   End;
   800:Case(Height)of
    600:Base:=vmGrf800x600c65536;
   End;
  End;
  15:Case(Length)of
   320:Case(Height)of
    200:Base:=vmGrf320x200c32768;
   End;
   640:Case(Height)of
    350:Base:=vmGrf640x350c32768;
    400:Base:=vmGrf640x400c32768;
    480:Base:=vmGrf640x480c32768;
   End;
   800:Case(Height)of
    600:Base:=vmGrf800x600c32768;
   End;
   1024:Case(Height)of
    768:Base:=vmGrf1024x768c32768;
   End;
  End;
  8:Case(Length)of
   320:Case(Height)of
    200:Base:=vmGrf320x200c256;
    240:Base:=vmGrf320x240c256;
    400:Base:=vmGrf320x400c256;
    480:Base:=vmGrf320x480c256;
   End;
   360:Case(Height)of
    240:Base:=vmGrf360x240c256;
    360:Base:=vmGrf360x360c256;
    400:Base:=vmGrf360x400c256;
    480:Base:=vmGrf360x480c256;
   End;
   376:Case(Height)of
    308:Base:=vmGrf376x308c256;
    564:Base:=vmGrf376x564c256;
   End;
   512:Case(Height)of
    512:Base:=vmGrf512x512c256;
   End;
   640:Case(Height)of
    350:Base:=vmGrf640x350c256;
    400:Base:=vmGrf640x400c256;
    480:Base:=vmGrf640x480c256;
   End;
   720:Case(Height)of
    512:Base:=vmGrf720x512c256;
    540:Base:=vmGrf720x540c256;
   End;
   800:Case(Height)of
    600:Base:=vmGrf800x600c256;
   End;
   1024:Case(Height)of
    768:Base:=vmGrf1024x768c256;
   End;
   1280:Case(Height)of
    1024:Base:=vmGrf1280x1024c256;
   End;
  End;
  4:Case(Length)of
   320:Case(Height)of
    200:Base:=vmGrf320x200c16;
   End;
   512:Case(Height)of
    512:Base:=vmGrf512x512c16;
   End;
   640:Case(Height)of
    200:Base:=vmGrf640x200c16;
    350:Base:=vmGrf640x350c16;
    400:Base:=vmGrf640x400c16;
    462:Base:=vmGrf640x462c16;
    480:Base:=vmGrf640x480c16;
   End;
   720:Case(Height)of
    392:Base:=vmGrf720x392c16;
    512:Base:=vmGrf720x512c16;
    540:Base:=vmGrf720x540c16;
   End;
   752:Case(Height)of
    410:Base:=vmGrf752x410c16;
   End;
   768:Case(Height)of
    1024:Base:=vmGrf768x1024c16;
   End;
   800:Case(Height)of
    560:Base:=vmGrf800x560c16;
    600:Base:=vmGrf800x600c16;
   End;
   960:Case(Height)of
    720:Base:=vmGrf960x720c16;
   End;
   1024:Case(Height)of
    768:Base:=vmGrf1024x768c16;
   End;
   1280:Case(Height)of
    1024:Base:=vmGrf1280x1024c16;
   End;
  End;
  2:Case(Length)of
   320:Case(Height)of
    200:Base:=vmGrf320x200c4;
   End;
   640:Case(Height)of
    400:Base:=vmGrf640x200c4;
   End;
   1024:Case(Height)of
    768:Base:=vmGrf1024x768c4;
   End;
  End;
  1:Case(Length)of
   240:Case(Height)of
    128:Base:=vmGrf240x128c2;
   End;
   640:Case(Height)of
    200:Base:=vmGrf640x200c2;
    350:Base:=vmGrf640x350c2;
    400:Base:=vmGrf640x400c2;
    480:Base:=vmGrf640x480c2;
   End;
   720:Case(Height)of
    348:Base:=vmHerc;
    350:Base:=vmGrf720x350c2;
   End;
   800:Case(Height)of
    600:Base:=vmGrf800x600c2;
   End;
   1024:Case(Height)of
    768:Base:=vmGrf1024x768c2;
   End;
  End;
  Else Case(Length)of
   40:Case(Height)of
    25:Base:=vmTxtC40;
    28:Base:=vmTxtC40x28;
    43:Base:=vmTxtC40x43;
    50:Base:=vmTxtC40x50;
    Else Base:=vmTxtC40;
   End;
   80:Case(Height)of
    28:Base:=vmTxtC80x28;
    30:Base:=vmTxtC80x30;
    33:Base:=vmTxtC80x33;
    34:Base:=vmTxtC80x34;
    43:Base:=vmTxtC80x43;
    50:Base:=vmTxtC80x50;
    60:Base:=vmTxtC80x60;
    66:Base:=vmTxtC80x66;
    Else Base:=vmTxtC80;
   End;
   100:Case(Height)of
    30:Base:=vmTxtC100x30;
    37:Base:=vmTxtC100x37;
    40:Base:=vmTxtC100x40;
    50:Base:=vmTxtC100x50;
    60:Base:=vmTxtC100x60;
    75:Base:=vmTxtC100x75;
    Else Base:=vmTxtC100x37;
   End;
   120:Case(Height)of
    25:Base:=vmTxtC120x25;
    43:Base:=vmTxtC120x43;
    Else Base:=vmTxtC120x25;
   End;
   132:Case(Height)of
    28:Base:=vmTxtC132x28;
    43:Base:=vmTxtC132x43;
    44:Base:=vmTxtC132x44;
    50:Base:=vmTxtC132x50;
    60:Base:=vmTxtC132x60;
    100:Base:=vmTxtC132x100;
    Else Base:=vmTxtC132;
   End;
   160:Case(Height)of
    50:Base:=vmTxtC160x50;
    Else Base:=vmTxtC160x50;
   End;
  End;
 End;
 If(Base<>vmNone)Then
 {$IFDEF DPMI}
  viSetVideoSizePrim:=viSetVideoModePrim(Base,P,Q)
 {$ELSE}
  SetVideoSizePrim:=SetVideoModePrim(Base,P,Q)
 {$ENDIF}
End;

{$IFDEF DPMI}
 Var DataVesa:VesaInfo;
{$ELSE}
 Procedure DataVesa;Assembler;ASM
  DD 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
  DD 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
  DD 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
  DD 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
 END;
{$ENDIF}

{$IFDEF DPMI}
 Function viSetVideoModePrim(Mode:Wd;Var P:PIV;Var Q:MIV):Byte;
{$ELSE}
 Function SetVideoModePrim(Mode:Wd;Var P:PIV;Var Q:MIV):Byte;
{$ENDIF}
{$IFDEF DPMI}
Const AdrProc:Array[21..68]of ProcSetVidModType=(
   SetVidModeMDAPrim,
   SetVidModeMDASec,
   SetVidModeHerculePrim,
   SetVidModeHerculeSec,
   SetVidModeHP95LXPrim,
   SetVidModeCGAPrim,
   SetVidModeCGASec,
   SetVidModeGSPrim,
   SetVidModeGSSec,
   SetVidModeGSEmulPrim,
   SetVidModeGSEmulSec,
   SetVidModePCJrPrim,
   SetVidModeTandy1000Prim,
   SetVidModeEGAPrim,
   SetVidModeAheadEGA2001Prim,
   SetVidModeATT6300Prim,
   SetVidModeEGAWonderPrim,
   SetVidModeLavaChromeIIEGAPrim,
   SetVidModeParadiseEGA480Prim,
   SetVidModeTaxan565EGAPrim,
   SetVidModeUltraVisionEGAPrim,
   SetVidModeVGAPrim,
   SetVidModeAheadBPrim,
   SetVidModeAllStarPeacockPrim,
   SetVidModeASTVGAPlusPrim,
   SetVidModeATTVDC600Prim,
   SetVidModeCardinalPrim,
   SetVidModeCirrusPrim,
   SetVidModeEverexPrim,
   SetVidModeGenoaPrim,
   SetVidModeHPD1180APrim,
   SetVidModeMorseVGAPrim,
   SetVidModeOakPrim,
   SetVidModeOrchidPrim,
   SetVidModeOrchidProPrim,
   SetVidModeParadisePrim,
   SetVidModeRealtekRTVGAPrim,
   SetVidModeSigmaPrim,
   SetVidModeSTBPrim,
   SetVidModeTatungVGAPrim,
   SetVidModeTecmarVGAADPrim,
   SetVidModeTridentPrim,
   SetVidModeTsengET4000Prim,
   SetVidModeTsengET4000HiColorPrim,
   SetVidModeVGAWonderPrim,
   SetVidModeVESAPrim,
   SetVidModeVideo7Prim,
   SetVidModeXGAPrim);Var X:Byte;
{$ENDIF}
Begin
 ASM
  MOV AL,Byte Ptr Mode[1]
  AND AL,080h
  AND Mode,07FFFh
  MOV Byte Ptr ClearFlag,AL
 END;
 If(Mode=vmTxtDef)Then Begin
  {$IFDEF DPMI}
   If VideoPort=$3B4Then Mode:=vmTxtMono Else Mode:=vmTxtC80;
  {$ELSE}
   If MemW[0:$463]=$3B4Then Mode:=vmTxtMono Else Mode:=vmTxtC80;
  {$ENDIF}
 End;
 {$IFDEF DPMI}
  X:=AdrProc[PhysVideo.ProcSetVideoMode](Mode,Q);
 {$ENDIF}
 ASM
  {$IFNDEF DPMI}
   JMP @SkipData
@AdrProc:
   DW Offset SetVidModeMDAPrim
   DW Offset SetVidModeMDASec
   DW Offset SetVidModeHerculePrim
   DW Offset SetVidModeHerculeSec
   DW Offset SetVidModeHP95LXPrim
   DW Offset SetVidModeCGAPrim
   DW Offset SetVidModeCGASec
   DW Offset SetVidModeGSPrim
   DW Offset SetVidModeGSSec
   DW Offset SetVidModeGSEmulPrim
   DW Offset SetVidModeGSEmulSec
   DW Offset SetVidModePCJrPrim
   DW Offset SetVidModeTandy1000Prim
   DW Offset SetVidModeEGAPrim
   DW Offset SetVidModeAheadEGA2001Prim
   DW Offset SetVidModeATT6300Prim
   DW Offset SetVidModeEGAWonderPrim
   DW Offset SetVidModeLavaChromeIIEGAPrim
   DW Offset SetVidModeParadiseEGA480Prim
   DW Offset SetVidModeTaxan565EGAPrim
   DW Offset SetVidModeUltraVisionEGAPrim
   DW Offset SetVidModeVGAPrim
   DW Offset SetVidModeAheadBPrim
   DW Offset SetVidModeAllStarPeacockPrim
   DW Offset SetVidModeASTVGAPlusPrim
   DW Offset SetVidModeATTVDC600Prim
   DW Offset SetVidModeCardinalPrim
   DW Offset SetVidModeCirrusPrim
   DW Offset SetVidModeEverexPrim
   DW Offset SetVidModeGenoaPrim
   DW Offset SetVidModeHPD1180APrim
   DW Offset SetVidModeMorseVGAPrim
   DW Offset SetVidModeOakPrim
   DW Offset SetVidModeOrchidPrim
   DW Offset SetVidModeOrchidProPrim
   DW Offset SetVidModeParadisePrim
   DW Offset SetVidModeRealtekRTVGAPrim
   DW Offset SetVidModeSigmaPrim
   DW Offset SetVidModeSTBPrim
   DW Offset SetVidModeTatungVGAPrim
   DW Offset SetVidModeTecmarVGAADPrim
   DW Offset SetVidModeTridentPrim
   DW Offset SetVidModeTsengET4000Prim
   DW Offset SetVidModeTsengET4000HiColorPrim
   DW Offset SetVidModeVGAWonderPrim
   DW Offset SetVidModeVESAPrim
   DW Offset SetVidModeVideo7Prim
   DW Offset SetVidModeXGAPrim
@SkipData:
   LES DI,P
   MOV BX,ES:[DI].PIV.ProcSetVideoMode
   SUB BX,21
   SHL BX,1
   PUSH Mode
   PUSH Q.Word[2]
   PUSH Q.Word
   CALL @AdrProc.Word[BX]
  {$ELSE}
   MOV AL,X
  {$ENDIF}
  CMP AL,0FFh
  JE  @1
  LES DI,Q
  MOV Mode,BX
  MOV ES:[DI].MIV.Mode,BX
@1:MOV @Result,AL
  CMP AL,0FFh
  JNE @2
  CLD
  XOR AL,AL
  LES DI,Q
  MOV CX,SizeOfInfo
  REP STOSB
@2:
  CMP AL,drvVESA
  JNE @5
  MOV AX,4F03h
  INT 10h
  MOV CX,BX
  MOV AX,4F01h
  PUSH CS
  POP ES
  MOV DI,Offset DataVesa
  INT 10h
  CMP DataVesa.VesaInfo.Granularity,64
  JNE @4
  MOV AL,drvSVGA
  JMP @3
@4:
  {$IFDEF DPMI}
   MOV ES,Seg0040
   XOR AH,AH
   MOV AL,Byte Ptr ES:[0084h]
  {$ELSE}
   XOR AX,AX
   MOV ES,AX
   MOV AL,Byte Ptr ES:[484h]
  {$ENDIF}
  INC AL
  {$IFDEF DPMI}
   MUL Byte Ptr ES:[0085h]
   MOV BX,Word Ptr ES:[004Ah]
  {$ELSE}
   MUL Byte Ptr ES:[485h]
   MOV BX,Word Ptr ES:[44Ah]
  {$ENDIF}
  {$IFOPT G+}
   SHL BX,3
  {$ELSE}
   SHL BX,1
   SHL BX,1
   SHL BX,1
  {$ENDIF}
  MUL BX
  MOV AL,drvVESA
  TEST DX,NOT 3
  JNZ @3
  MOV AL,drvVGA256
@3:
  MOV @Result,AL
@5:
 END;
 If(P.CardCat>=cvnEGA)Then Begin
  {$IFDEF DPMI}
   GetIntVec($43,Pointer(Q.TxtMtx))
  {$ELSE}
   CLI;Q.TxtMtx:=TableInt[$43];STI;
  {$ENDIF}
 End
  Else
 Q.TxtMtx:=System.Ptr($FFA6,$E);
End;

{$IFNDEF DPMI}
 Procedure ClearFlag;Assembler;ASM DB No;END;
{$ENDIF}

Function SetVideoMode0(Mode:Byte):Bool;Near;Assembler;ASM
 XOR AH,AH
 MOV AL,Mode
 OR  AL,Byte Ptr ClearFlag
 INT 010h
 {$IFDEF DPMI}
  MOV ES,Seg0040
  MOV BL,ES:[0049h]
 {$ELSE}
  XOR AX,AX
  MOV ES,AX
  MOV BL,ES:[0449h]
 {$ENDIF}
 CMP BL,Mode
 JNE @1
 MOV AL,Ya
@1:
END;

Function LoadBnkMode(OfsI,Mode:Wd):Byte;Near;Begin
 LoadBnkMode:=$FF;
 While Mem[CSeg:OfsI]<>0do Begin
  If(MemW[CSeg:OfsI]=Mode)Then Begin
   If SetVideoMode0(Mem[CSeg:OfsI+2])Then LoadBnkMode:=Mem[CSeg:OfsI+3]Else LoadBnkMode:=$FE;
   Exit;
  End;
  Inc(OfsI,4);
 End;
End;

Function SetVidModeMDAPrim;Begin
 SetVidModeMDAPrim:=drvTxt;
 If(Mode=vmTxtMaxRes80)or(Mode=vmTxtMaxRes)Then Mode:=vmTxtMono;
 ASM MOV Byte Ptr ClearFlag,No;END;
 SetVideoMode0(Mode);
End;

Function SetVidModeMDASec;Begin
 SetVidModeMDASec:=drvTxt;
 If(Mode=vmTxtMaxRes80)or(Mode=vmTxtMaxRes)Then Mode:=vmTxtMono;
 ASM
  CMP Byte Ptr ClearFlag,80h
  JNE @End
  CLD
  {$IFDEF DPMI}
   MOV ES,SegB000
  {$ELSE}
   MOV AX,0B000h
   MOV ES,AX
  {$ENDIF}
  XOR DI,DI
  MOV CX,2000
  REP STOSW
@End:
 END
End;

Function SetVidModeHerculePrim;Begin
 SetVidModeHerculePrim:=drvTxt;
 If(Mode=vmTxtMaxRes80)or(Mode=vmTxtMaxRes)Then Mode:=vmTxtMono;
  { * * * Teste le type de mode * * * }
 Case Mode of
  vmHerc:Begin SetVidModeHerculePrim:=drvHerc;Port[$3BF]:=1;End;
  vmTxtMono:Begin SetVidModeHerculePrim:=drvTxt;Port[$3BF]:=0;End;
 End;
End;

Function SetVidModeHerculeSec;Begin End;
Function SetVidModeHp95LXPrim;Begin End;

Function SetVidModeCGAPrim;Begin
 SetVidModeCGAPrim:=$FF;ASM MOV Byte Ptr ClearFlag,No;END;
 If(Mode=vmTxtMaxRes80)or(Mode=vmTxtMaxRes)Then Mode:=vmTxtC80;
 If SetVideoMode0(Mode)Then Case Mode of
  vmTxtBW40,vmTxtC40,vmTxtBW80,vmTxtC80:SetVidModeCGAPrim:=drvTxt;
  4,5:SetVidModeCGAPrim:=drv320x200c4;
  vmGrf640x200c2:SetVidModeCGAPrim:=drv2;
 End;
End;

Function SetVidModeCGASec;Begin
  { *********************************************************** }
  {                                                             }
  {                            CGA                              }
  {              * * * * * A Compläter ! * * * * *              }
  {                                                             }
  { *********************************************************** }
End;

Procedure Load16Registers;Near;Assembler;ASM { DI=Offset des Registres }
 MOV DX,03D4h
 XOR BX,BX
@1:MOV AH,CS:[DI+BX].Byte
 MOV AL,BL
 OUT DX,AX
 INC BX
 CMP BX,10
 JNE @1
 MOV AX,060Ah;OUT DX,AX
 MOV AX,070Bh;OUT DX,AX
 XOR AH,AH
 INC AX;OUT DX,AX
 INC AX;OUT DX,AX
 INC AX;OUT DX,AX
 INC AX;OUT DX,AX
END;

Procedure _SetGSRegisters(X:Byte);Near;Assembler;ASM
 MOV DX,03D8h
 MOV AL,2
 OUT DX,AL
 MOV DL,0DDh
 MOV AL,010h
 ADD AL,X
 OUT DX,AL
 MOV DL,0D8h
 MOV AL,2
 OUT DX,AL
END;

Procedure _ResetGSRegisters(X:Byte);Near;Assembler;ASM
 MOV DX,03D8h
 MOV AL,00Ah
 OUT DX,AL
 MOV AL,030h
 INC DX
 OUT DX,AL
 MOV AL,010h
 ADD AL,X
 MOV DL,0DDh
 OUT DX,AL
 MOV DL,0DFh
 MOV AL,080h
 OUT DX,AL
END;

Procedure SetGS132;Near;Assembler;ASM
 CLI
 CMP Byte Ptr ClearFlag,080h
 JNE @SkipClear
 CLD
 {$IFDEF DPMI}
  MOV ES,SegB800
 {$ELSE}
  MOV AX,0B800h
  MOV ES,AX
 {$ENDIF}
 XOR DI,DI
 MOV CX,2000h
 MOV AX,0720h
 REP STOSW
@SkipClear:
 MOV DX,03D8h
 MOV AL,2
 OUT DX,AL
 MOV DL,0DDh
 XOR AL,AL
 OUT DX,AL
 MOV DL,0D8h
 MOV AL,5
 OUT DX,AL
END;

Procedure _SetExtGS132;Near;Assembler;ASM
 CALL Load16Registers
 MOV DL,0D8h
 MOV AL,00Dh
 OUT DX,AL
 INC DX
 MOV AL,030h
 OUT DX,AL
 MOV DL,0DDh
 XOR AL,AL
 OUT DX,AL
 MOV DL,0DFh
END;

Procedure SetExtGS132;Near;Assembler;ASM
 CALL _SetExtGS132
 MOV AL,090h
 OUT DX,AL
 {$IFDEF DPMI}
  MOV ES,Seg0040
  MOV Word Ptr ES:[004Ah],132
 {$ELSE}
  XOR AX,AX
  MOV ES,AX
  MOV Word Ptr ES:[044Ah],132
 {$ENDIF}
END;

{$IFDEF DPMI}
 Var Int29h:Pointer;
{$ENDIF}

Function SetVidModeGSPrim;Begin
 SetVidModeGSPrim:=drvTxt;
 If(Mode=vmTxtMaxRes)Then Mode:=vmTxtC132x28;
 ASM
  {$IFDEF DPMI}
   MOV ES,Seg0040
   CMP Word Ptr ES:[63h],03B4h
  {$ELSE}
   XOR AX,AX
   MOV ES,AX
   CMP Word Ptr ES:[0463h],03B4h
  {$ENDIF}
  JNE @Skip
  MOV DX,03BAh
  MOV AL,080h
  OUT DX,AL
  MOV DL,0D4h
  {$IFDEF DPMI}
   MOV ES:[0063h],DX
   AND Byte Ptr ES:[0010h],11001111b
   OR  Byte Ptr ES:[0010h],32
  {$ELSE}
   MOV ES:[0463h],DX
   AND Byte Ptr ES:[0410h],11001111b
   OR  Byte Ptr ES:[0410h],32
  {$ENDIF}
@Skip:
 END;
  { * * * Teste le type de mode * * * }
 Case Mode of
  vmGrf320x200c16:Begin
   _SetGSRegisters(0);
   ASM
    MOV DI,Offset Reg320x200c16
    CALL Load16Registers
   END;
   _ResetGSRegisters(0)
  End;
  vmGrf640x200c4:Begin
   _SetGSRegisters($10);
   ASM
    MOV DI,Offset Reg320x200c16
    CALL Load16Registers
   END;
   _ResetGSRegisters($10)
  End;
  vmGrf640x200c16:ASM
   CLI
   MOV DX,03D8h
   MOV AL,2
   OUT DX,AL
   MOV DL,0DDh
   MOV AL,080h
   OUT DX,AL
   MOV DL,0D8h
   MOV AL,2
   OUT DX,AL
   MOV DL,0D4h
   MOV DI,Offset Reg640x200c16
   CALL Load16Registers
   MOV DL,0D8h
   MOV AL,00Ah
   OUT DX,AL
   INC DX
   MOV AL,030h
   OUT DX,AL
   MOV DL,0DDh
   MOV AL,080h
   OUT DX,AL
   MOV DL,0DFh
   OUT DX,AL
   STI
   CMP Byte Ptr ClearFlag,080h
   JNE @SkipClear
   CLD
   {$IFDEF DPMI}
    MOV ES,SegB000
   {$ELSE}
    MOV AX,0B000h
    MOV ES,AX
   {$ENDIF}
   XOR DI,DI
   MOV CX,08000h
   XOR AX,AX
   REP STOSW
@SkipClear:
   MOV @Result,drvGS640
   END;
  vmTxtMono,vmHerc:Begin
   {$IFDEF DPMI}
    GetIntVec($29,Int29h);
   {$ENDIF}
   ASM
    CLI
    MOV DX,03D8h
    MOV AL,8
    OUT DX,AL
    {$IFDEF DPMI}
     LES DI,Int29h
    {$ELSE}
     XOR AX,AX
     MOV ES,AX
     LES DI,ES:[0074h]
    {$ENDIF}
    ADD DI,48
    MOV DL,0B4h
    XOR BX,BX
 @1:MOV AH,ES:[DI+BX]
    MOV AL,BL
    OUT DX,AX
    INC BX
    CMP BX,16
    JNE @1
    MOV DL,0D8h
    MOV AL,8
    OUT DX,AL
    {$IFDEF DPMI}
     MOV ES,Seg0040
     MOV Byte Ptr ES:[0049h],7
     MOV Word Ptr ES:[004Ah],80
     MOV Word Ptr ES:[004Ch],4096
     MOV ES:[004Eh],AX
     MOV ES:[0062h],AL
     MOV Word Ptr ES:[0063h],03B4h
     MOV Byte Ptr ES:[0084h],24
    {$ELSE}
     XOR AX,AX
     MOV ES,AX
     MOV Byte Ptr ES:[0449h],7
     MOV Word Ptr ES:[044Ah],80
     MOV Word Ptr ES:[044Ch],4096
     MOV ES:[044Eh],AX
     MOV ES:[0462h],AL
     MOV Word Ptr ES:[0463h],03B4h
     MOV Byte Ptr ES:[0484h],24
    {$ENDIF}
    STI
   END;
   If(Mode=vmHerc)Then SetVidModeGSPrim:=drvHerc;
  End;
  vmTxtBW40,vmTxtC40:ASM
   CLI
   MOV DX,03DFh
   MOV AL,080h
   OUT DX,AL { Port[3DFh] = 80h }
   MOV AL,Byte Ptr Mode
   MOV AH,0
   INT 010h
   MOV @Result,drvTxt
  END;
  vmTxtBW80,vmTxtC80:ASM
   CLI
   MOV DX,03D8h
   MOV AL,2
   OUT DX,AL
   MOV DL,0DDh
   XOR AL,AL
   OUT DX,AL
   MOV DL,0D8h
   MOV AL,025h
   OUT DX,AL
   MOV DI,Offset RegTxt80x25
   CALL Load16Registers
   MOV DL,0D8h
   MOV AL,02Dh
   OUT DX,AL
   MOV AL,030h
   INC DX
   OUT DX,AL
   MOV DL,0DDh
   XOR AL,AL
   OUT DX,AL
   MOV DL,0DFh
   MOV AL,080h
   OUT DX,AL
   {$IFDEF DPMI}
    MOV ES,Seg0040
    MOV Byte Ptr ES:[0049h],3
    MOV Word Ptr ES:[004Ah],80
    MOV Word Ptr ES:[004Ch],4096
    MOV ES:[004Eh],AX
    MOV Byte Ptr ES:[0062h],AL
    MOV Byte Ptr ES:[0084h],24
   {$ELSE}
    XOR AX,AX
    MOV ES,AX
    MOV Byte Ptr ES:[0449h],3
    MOV Word Ptr ES:[044Ah],80
    MOV Word Ptr ES:[044Ch],4096
    MOV Word Ptr ES:[044Eh],AX
    MOV Byte Ptr ES:[0462h],AL
    MOV Byte Ptr ES:[0484h],24
   {$ENDIF}
   STI
   CMP Byte Ptr ClearFlag,080h
   JNE @SkipClear
   CLD
   {$IFDEF DPMI}
    MOV ES,SegB800
   {$ELSE}
    MOV AX,0B800h
    MOV ES,AX
   {$ENDIF}
   XOR DI,DI
   MOV CX,02000h
   MOV AX,00720h
   REP STOSW
@SkipClear:
   MOV @Result,drvTxt
  END;
  vmTxtC132:ASM
   CALL SetGS132
   MOV DI,Offset RegTxt132x25
   CALL SetExtGS132
   {$IFDEF DPMI}
    MOV ES,Seg0040
    MOV Byte Ptr ES:[084h],24
   {$ELSE}
    XOR AX,AX
    MOV ES,AX
    MOV Byte Ptr ES:[0484h],24
   {$ENDIF}
   STI
   MOV @Result,drvTxt
  END;
  vmTxtC132x28:ASM
   CALL SetGS132
   MOV DI,Offset RegTxt132x28
   CALL SetExtGS132
   {$IFDEF DPMI}
    MOV ES,Seg0040
    MOV Byte Ptr ES:[084h],24
   {$ELSE}
    XOR AX,AX
    MOV ES,AX
    MOV Byte Ptr ES:[0484h],24
   {$ENDIF}
   STI
   MOV @Result,drvTxt
  END;
  vmGrf640x200c2:ASM
   CLI
   MOV DX,03D8h
   MOV AL,016h
   OUT DX,AL
   MOV DI,Offset Reg320x200c16
   CALL Load16Registers
   MOV DL,0D8h
   MOV AL,01Eh
   OUT DX,AL
   INC DX { DX = 3D9h }
   MOV AL,15
   OUT DX,AL
   MOV DL,0DFh
   MOV AL,080h
   OUT DX,AL { Port[3DFh] := 80h }
   STI
   CMP Byte Ptr ClearFlag,080h
   JNE @SkipClear
   CLD
   {$IFDEF DPMI}
    MOV ES,SegB800
   {$ELSE}
    MOV AX,0B800h
    MOV ES,AX
   {$ENDIF}
   XOR DI,DI
   MOV CX,04000h
   XOR AX,AX
   REP STOSW
@SkipClear:
   MOV @Result,drv2
  END;
  Else SetVidModeCGAPrim(Mode,Q);
 End;  { * * * Fin du Teste de type de mode * * * }
 ASM
  CMP @Result,drvTxt
  JNE @NoTxt
  {$IFDEF DPMI}
   MOV ES,Seg0040
   MOV Word Ptr ES:[0050h],0 { X,Y = (0,0) }
   MOV DX,ES:[0063h]
  {$ELSE}
   XOR AX,AX
   MOV ES,AX
   MOV ES:[0450h],AX { X,Y = (0,0) }
   MOV DX,ES:[0463h]
  {$ENDIF}
  MOV AX,060Ah
  OUT DX,AX
  INC AL
  MOV AH,7
  OUT DX,AX
@NoTxt:
 END;
End;

Function SetVidModeGSSec;Begin
  { *********************************************************** }
  {                                                             }
  {                      Graphic Solutions                      }
  {              * * * * * A Compläter ! * * * * *              }
  {                                                             }
  { *********************************************************** }
End;

Procedure SetGSRegisters(X:Byte);Near;Assembler;ASM
 MOV DX,03D8h
 MOV AL,2
 OUT DX,AL
 MOV DL,0DDh
 MOV AL,010h
 ADD AL,X
 OUT DX,AL
 MOV DL,0DFh
 MOV AL,0A2h
 OUT DX,AL
 MOV DL,0D8h
 MOV AL,2
 OUT DX,AL
END;

Procedure ResetGSRegisters(X:Byte);Near;Assembler;ASM
 MOV DX,03D8h
 MOV AL,00Ah
 OUT DX,AL
 INC DX
 MOV AL,030h
 OUT DX,AL
 MOV DL,0DFh
 MOV AL,0A0h
 OUT DX,AL
 MOV AL,010h
 ADD AL,X
 MOV DL,0DDh
 OUT DX,AL
END;

Function SetVidModeGSEmulPrim;Begin
 SetVidModeGSEmulPrim:=$FF;
 If(Mode=vmTxtMaxRes)Then Mode:=vmTxtC132;
 Case Mode of
  vmGrf320x200c16:Begin
   SetGSRegisters(0);
   ASM
    MOV DI,Offset Reg320x200c16Emul
    CALL Load16Registers
   END;
   ResetGSRegisters(0)
  End;
  vmGrf640x200c4:Begin
   SetGSRegisters($10);
   ASM
    MOV DI,Offset Reg320x200c16Emul
    CALL Load16Registers
   END;
   ResetGSRegisters($10)
  End;
  vmGrf640x200c16:ASM
   CLI
   MOV DX,03D8h
   MOV AL,2
   OUT DX,AL
   MOV AL,080h
   MOV DL,0DDh
   OUT DX,AL
   MOV AL,0A2h
   MOV DL,0DFh
   OUT DX,AL
   MOV AL,002h
   MOV DL,0D8h
   OUT DX,AL
   MOV DI,Offset Reg640x200c16Emul
   CALL Load16Registers
   MOV DL,0D8h
   MOV AL,00Ah
   OUT DX,AL
   INC DX
   MOV AL,030h
   OUT DX,AL
   MOV AL,0A0h
   MOV DL,0DFh
   OUT DX,AL
   MOV DL,0DDh
   MOV AL,080h
   OUT DX,AL
   STI
   CMP Byte Ptr ClearFlag,080h
   JNE @SkipClear
   CLD
   {$IFDEF DPMI}
    MOV ES,SegB000
   {$ELSE}
    MOV AX,0B000h
    MOV ES,AX
   {$ENDIF}
   XOR DI,DI
   MOV CX,08000h
   XOR AX,AX
   REP STOSW
@SkipClear:
   MOV @Result,drvGS640
  END;
  vmTxtC132:ASM
   CALL SetGS132
   MOV DI,Offset RegTxt132x25
   CALL _SetExtGS132
   MOV AL,0A8h
   OUT DX,AL
   {$IFDEF DPMI}
    MOV ES,Seg0040
    MOV Word Ptr ES:[004Ah],132
    MOV Byte Ptr ES:[0084],24
   {$ELSE}
    XOR AX,AX
    MOV ES,AX
    MOV Word Ptr ES:[044Ah],132
    MOV Byte Ptr ES:[0484h],24
   {$ENDIF}
   STI
   MOV @Result,drvTxt
  END;
  Else {$IFDEF DPMI}
   SetVidModeGSEmulPrim:=SetVidModeGSPrim(Mode,Q)
  {$ELSE}
   ASM JMP SetVidModeGSPrim.Near[3];END;
  {$ENDIF}
 End;
End;

Function SetVidModeGSEmulSec;Begin
  { *********************************************************** }
  {                                                             }
  {                      Graphic Solutions                      }
  {              * * * * * A Compläter ! * * * * *              }
  {                                                             }
  { *********************************************************** }
End;

Function SetVidModePCJrPrim;Begin
  { *********************************************************** }
  {                                                             }
  {                         PC Junior                           }
  {              * * * * * A Compläter ! * * * * *              }
  {                                                             }
  { *********************************************************** }
 {$IFDEF DPMI}
  SetVidModePCJrPrim:=SetVidModeCGAPrim(Mode,Q)
 {$ELSE}
  ASM JMP SetVidModeCGAPrim.Near[3];END;
 {$ENDIF}
End;

Function SetVidModeTandy1000Prim;Begin
  { *********************************************************** }
  {                                                             }
  {                         Tandy 1000                          }
  {              * * * * * A Compläter ! * * * * *              }
  {                                                             }
  { *********************************************************** }
 {$IFDEF DPMI}
  SetVidModeTandy1000Prim:=SetVidModeCGAPrim(Mode,Q)
 {$ELSE}
  ASM JMP SetVidModeCGAPrim.Near[3];END;
 {$ENDIF}
End;

Function SetVidModeEGAPrim;Var MW:Byte;Begin
 SetVidModeEGAPrim:=$FF;
 Case(Mode)of
 vmTxtMaxRes80,vmTxtMaxRes:
  {$IFDEF DPMI}
   If VideoPort=$3D4Then Mode:=vmTxtC80x43 Else Mode:=vmTxtMono80x43;
  {$ELSE}
   If MemW[0:$463]=$3D4Then Mode:=vmTxtC80x43 Else Mode:=vmTxtMono80x43;
  {$ENDIF}
 End;
 ASM
  JMP @Next
@DataMode:
  DW 4;               DB 4,drv320x200c4
  DW 5;               DB 5,drv320x200c4
  DW vmGrf320x200c4;  DB 4,drv320x200c4
  DW vmGrf640x200c2;  DB 6,drv2
  DW vmGrf320x200c16; DB $0D,drv16
  DW vmGrf640x200c16; DB $0E,drv16
  DW vmGrf640x350c16; DB $10,drv16
  DB 0 { Fin de liste }
@Next:
  MOV AX,Offset @DataMode
  PUSH AX
  PUSH Mode
  CALL LoadBnkMode
  MOV MW,AL
  MOV @Result,AL
 END;
 If MW=$FFThen Case Mode of
  vmTxtBW40,vmTxtBW80,vmTxtC40,vmTxtC80,vmTxtMono,vmTxtC40x43,vmTxtC80x43,vmTxtMono80x43:Begin
   Case Lo(Mode)of
    Lo(vmTxtBW40),Lo(vmTxtC40):MW:=1;
    Lo(vmTxtMono): MW:=7;
    Else MW:=3;
   End;
   ASM
    MOV AX,01201h
    MOV BL,030h
    INT 010h
   END;
   If SetVideoMode0(MW)Then Begin
    If Lo(Mode)in[Lo(vmTxtC40x43),Lo(vmTxtC80x43),Lo(vmTxtMono80x43)]Then ASM
     MOV AX,01112h
     MOV BL,0
     INT 010h
    END
     Else
    ASM
     MOV AX,01114h
     MOV BL,0
     INT 010h
    END;
    SetVidModeEGAPrim:=drvTxt;
   End;
  End;
 End;
End;

Function SetVidModeAheadEGA2001Prim;Var MW:Byte;Begin
 If(Mode=vmTxtMaxRes)Then Begin
  {$IFDEF DPMI}
   If VideoPort=$3D4Then Mode:=vmTxtC132x44 Else Mode:=vmTxtMono80x43;
  {$ELSE}
   If MemW[0:$463]=$3D4Then Mode:=vmTxtC132x44 Else Mode:=vmTxtMono80x43;
  {$ENDIF}
 End;
 ASM
  JMP @Next
@DataMode:
  DW vmTxtC132x44;    DB 022h,drvTxt
  DW vmGrf640x480c16; DB 026h,drv16
  DW vmTxtMono132;    DB 050h,drvTxt
  DW vmTxtMono132x44; DB 052h,drvTxt
  DB 0 { Fin de liste }
@Next:
  MOV AX,Offset @DataMode
  PUSH AX
  PUSH Mode
  CALL LoadBnkMode
  MOV MW,AL
  MOV @Result,AL
 END;
 If MW=$FFThen
 {$IFDEF DPMI}
  SetVidModeAheadEGA2001Prim:=SetVidModeEGAPrim(Mode,Q)
 {$ELSE}
  ASM JMP SetVidModeEGAPrim.Near[3];END;
 {$ENDIF}
End;

Function SetVidModeATT6300Prim;Var MW:Byte;Begin
 ASM
  JMP @Next
@DataMode:
  DW vmGrf640x400c2;  DB 040h,drv2
  DW vmGrf640x400c16; DB 042h,drv16
  DB 0 { Fin de liste }
@Next:
  MOV AX,Offset @DataMode
  PUSH AX
  PUSH Mode
  CALL LoadBnkMode
  MOV MW,AL
  MOV @Result,AL
 END;
 If MW=$FFThen
 {$IFDEF DPMI}
  SetVidModeATT6300Prim:=SetVidModeEGAPrim(Mode,Q)
 {$ELSE}
  ASM JMP SetVidModeEGAPrim.Near[3];END;
 {$ENDIF}
End;

Function SetVidModeEGAWonderPrim;Var MW:Byte;Begin
 ASM
  JMP @Next
@DataMode:
  DW vmTxtC80x30;     DB 05Bh,drvTxt
  DW vmTxtC80x33;     DB 058h,drvTxt
  DW vmTxtC80x66;     DB 055h,drvTxt
  DW vmTxtMono132;    DB 027h,drvTxt
  DW vmTxtMono132x44; DB 037h,drvTxt
  DW vmTxtC132x44;    DB 033h,drvTxt
  DW vmTxtMono132x28; DB 023h,drvTxt
  DW vmTxtC132;       DB 023h,drvTxt
  DW vmTxtC132x28;    DB 023h,drvTxt
  DW vmGrf640x480c16; DB 012h,drv16
  DW vmGrf752x410c16; DB 052h,drv16
  DW vmGrf800x560c16; DB 053h,drv16
  DW vmGrf800x600c16; DB 054h,drv16
  DB 0 { Fin de liste }
@Next:
  MOV AX,Offset @DataMode
  PUSH AX
  PUSH Mode
  CALL LoadBnkMode
  MOV MW,AL
  MOV @Result,AL
 END;
 If MW=$FFThen
 {$IFDEF DPMI}
  SetVidModeEGAWonderPrim:=SetVidModeEGAPrim(Mode,Q)
 {$ELSE}
  ASM JMP SetVidModeEGAPrim.Near[3];END;
 {$ENDIF}
End;

Function SetVidModeLavaChromeIIEGAPrim;Var MW:Byte;Begin
 ASM
  JMP @Next
@DataMode:
  DW vmTxtC80x34;     DB 050h,drvTxt
  DW vmTxtMono80x34;  DB 050h,drvTxt
  DW vmTxtC80x30;     DB 051h,drvTxt
  DW vmTxtMono80x30;  DB 051h,drvTxt
  DW vmTxtC80x60;     DB 052h,drvTxt
  DW vmTxtMono80x60;  DB 052h,drvTxt
  DW vmTxtC132x43;    DB 053h,drvTxt
  DW vmTxtMono132x43; DB 053h,drvTxt
  DW vmTxtC132;       DB 054h,drvTxt
  DW vmTxtMono132;    DB 054h,drvTxt
  DB 0 { Fin de liste }
@Next:
  MOV AX,Offset @DataMode
  PUSH AX
  PUSH Mode
  CALL LoadBnkMode
  MOV MW,AL
  MOV @Result,AL
 END;
 If MW=$FFThen
 {$IFDEF DPMI}
  SetVidModeLavaChromeIIEGAPrim:=SetVidModeEGAPrim(Mode,Q)
 {$ELSE}
  ASM JMP SetVidModeEGAPrim.Near[3];END;
 {$ENDIF}
End;

Function SetVidModeParadiseEGA480Prim;Var MW:Byte;Begin
 ASM
  JMP @Next
@DataMode:
  DW vmTxtC80x30;     DB 051h,drvTxt
  DW vmTxtMono80x30;  DB 051h,drvTxt
  DW vmTxtC132;       DB 054h,drvTxt
  DW vmTxtMono132;    DB 054h,drvTxt
  DW vmTxtC132x43;    DB 055h,drvTxt
  DW vmTxtMono132x43; DB 055h,drvTxt
  DW vmGrf640x480c16; DB 050h,drv16
  DB 0 { Fin de liste }
@Next:
  MOV AX,Offset @DataMode
  PUSH AX
  PUSH Mode
  CALL LoadBnkMode
  MOV MW,AL
  MOV @Result,AL
 END;
 If MW=$FFThen
 {$IFDEF DPMI}
  SetVidModeParadiseEGA480Prim:=SetVidModeEGAPrim(Mode,Q)
 {$ELSE}
  ASM JMP SetVidModeEGAPrim.Near[3];END;
 {$ENDIF}
End;

Function SetVidModeTaxan565EGAPrim;Var MW:Byte;Begin
 ASM
  JMP @Next
@DataMode:
  DW vmTxtC132x43;    DB 054h,drvTxt
  DW vmTxtC132;       DB 055h,drvTxt
  DW vmTxtMono132x43; DB 056h,drvTxt
  DW vmTxtMono132;    DB 057h,drvTxt
  DB 0 { Fin de liste }
@Next:
  MOV AX,Offset @DataMode
  PUSH AX
  PUSH Mode
  CALL LoadBnkMode
  MOV MW,AL
  MOV @Result,AL
 END;
 If MW=$FFThen
 {$IFDEF DPMI}
  SetVidModeTaxan565EGAPrim:=SetVidModeEGAPrim(Mode,Q)
 {$ELSE}
  ASM JMP SetVidModeEGAPrim.Near[3];END;
 {$ENDIF}
End;

Function SetVidModeUltraVisionEGAPrim;Var MW:Byte;Begin
 SetVidModeUltraVisionEGAPrim:=$FF;
 If(Mode=vmGrf640x480c16)Then Begin
  If SetVideoMode0($12)Then SetVidModeUltraVisionEGAPrim:=drv16
 End
 Else
 {$IFDEF DPMI}
  SetVidModeUltraVisionEGAPrim:=SetVidModeEGAPrim(Mode,Q)
 {$ELSE}
  ASM JMP SetVidModeEGAPrim.Near[3];END;
 {$ENDIF}
End;

Function SetVidModeVGAPrim;Label 2;Var MW:Wd;Begin
 SetVidModeVGAPrim:=$FF;
 Case(Mode)of
 vmTxtMaxRes80,vmTxtMaxRes:
 {$IFDEF DPMI}
  If VideoPort=$3D4Then Mode:=vmTxtC80x50 Else Mode:=vmTxtMono80x50;
 {$ELSE}
  If MemW[0:$463]=$3D4Then Mode:=vmTxtC80x50 Else Mode:=vmTxtMono80x50;
 {$ENDIF}
 vmMinKrMode320x200:Mode:=vmGrf320x200c4;
 vmMaxKrMode320x200:Mode:=vmGrf320x200c256;
 vmMinKrMode640x200:Mode:=vmGrf640x200c2;
 vmMaxKrMode640x200:Mode:=vmGrf640x200c16;
 vmMinKrMode640x350:Mode:=vmGrf640x350c16;
 vmMaxKrMode640x350: Mode:=vmGrf640x350c16;
 End;
 ASM
  JMP @Next
@DataMode:
  DW vmGrf320x200c16; DB 00Dh,drv16
  DW vmGrf640x200c16; DB 00Eh,drv16
  DW vmGrf640x350c2;  DB 00Fh,drv2
  DW vmGrf640x350c16; DB 010h,drv16
  DW vmGrf640x480c2;  DB 011h,drv2
  DW vmGrf640x480c16; DB 012h,drv16
  DB 0 { Fin de liste }
@Next:
  MOV AX,Offset @DataMode
  PUSH AX
  PUSH Mode
  CALL LoadBnkMode
  XOR AH,AH
  MOV MW,AX
  MOV @Result,AL
 END;
 If MW=$FFThen Case(Mode)of
  vmGrf320x200c256,vmGrf320x400c256,vmGrf360x240c256,vmGrf360x480c256:Begin
   ASM
    MOV AX,00012h
    INT 010h
   END;
   If SetVideoMode0($13)Then Begin
    If(Mode=vmGrf360x240c256)Then Begin
     Q.BiosSupport:=No;
     ASM
      { 360x240 en 256 couleurs }
      MOV DX,03C4h
      MOV AX,0604h
      OUT DX,AX
      MOV AX,0100h
      OUT DX,AX
      MOV DX,03C2h
      MOV AL,0E7h
      OUT DX,AL
      MOV DX,03C4h
      MOV AX,0300h
      OUT DX,AX
      MOV DX,03D4h
      MOV AL,011h
      OUT DX,AL
      INC DX
      IN  AL,DX
      AND AL,07Fh
      OUT DX,AL
      MOV DX,03D4h
      CLD
      JMP @Next
@DataSq:DW 06B00h    { Horizontal total          }
      DW 05901h    { Horizontal displayed      }
      DW 05A02h    { Start horizontal blanking }
      DW 08E03h    { end horizontal blanking   }
      DW 05E04h    { Start H sync.             }
      DW 08A05h    { end H sync.               }
      DW 00D06h    { Vertical total            }
      DW 03E07h    { Overflow                  }
      DW 04109h    { Cell height               }
      DW 0EA10h    { V sync. start             }
      DW 0AC11h    { V sync. end/Prot CR0 CR7  }
      DW 0DF12h    { Vertical displayed        }
      DW 02D13h    { offset                    }
      DW 00014h    { DWord mode off            }
      DW 0E715h    { V Blank start             }
      DW 00616h    { V Blank end               }
      DW 0E317h    { Turn on Byte mode         }
@Next:MOV SI,Offset @DataSq
      MOV CX,17
      PUSH DS
       PUSH CS
       POP DS
   @@1:LODSW
       OUT DX,AX
       LOOP @@1
      POP DS
     END;
     MemW[0:$44A]:=45;
     Mem[0:$484]:=30;
     Mem[0:$485]:=8;
     SetVidModeVGAPrim:=drvVGA256;
    End
     Else
    If(Mode=vmGrf360x480c256)Then Begin
     Q.BiosSupport:=No;
     SetVidModeVGAPrim:=drv360x480c256;
    End
     Else
    If(Mode=vmGrf320x400c256)Then Begin
     Q.BiosSupport:=No;
     SetVidModeVGAPrim:=drv320x400c256;
    End
     Else
    SetVidModeVGAPrim:=drv19;
   End;
  End;
  vmGrf320x200c4,4,5,vmGrf640x200c2:
  {$IFDEF DPMI}
   SetVidModeVGAPrim:=SetVidModeEGAPrim(Mode,Q);
  {$ELSE}
   ASM JMP SetVidModeEGAPrim.Near[3];END;
  {$ENDIF}
  vmTxtBW40,vmTxtBW80,vmTxtC40,vmTxtC80,vmTxtMono,vmTxtC40x28,
  vmTxtC80x28,vmTxtMono80x28,vmTxtC40x43,vmTxtC80x43,vmTxtMono80x43,
  vmTxtC40x50,vmTxtC80x50,vmTxtMono80x50:Begin
   Case Lo(Mode)of
    Lo(vmTxtBW40),Lo(vmTxtC40):MW:=1;
    Lo(vmTxtMono):MW:=7;
    Else MW:=3;
   End;
   Case Lo(Mode)of
    Lo(vmTxtC40x28),Lo(vmTxtC80x28),Lo(vmTxtMono80x28):Begin
     Q.NumYPixels:=400;
     ASM
      MOV AX,01202h
      MOV BL,030h
      INT 010h
      MOV AX,MW
      INT 010h
      MOV AX,01111h
      MOV BL,0
      INT 010h
     END;
    End;
    Lo(vmTxtC40x43),Lo(vmTxtC80x43),Lo(vmTxtMono80x43):Begin
     Q.NumYPixels:=350;
     ASM
      MOV AX,01201h
      MOV BL,030h
      INT 010h
     END;
     Goto 2;
    End;
    Lo(vmTxtC40x50),Lo(vmTxtC80x50),Lo(vmTxtMono80x50):Begin
     Q.NumYPixels:=400;
     ASM
      MOV AX,01202h
      MOV BL,030h
      INT 010h
     END;
   2:ASM
      MOV AX,MW
      INT 010h
      MOV AX,01112h
      MOV BL,0
      INT 010h
     END;
     If Lo(Mode)in[Lo(vmTxtC40x50),Lo(vmTxtC80x50),Lo(vmTxtMono80x50)]Then
      Mem[0:$484]:=50
     Else
      Mem[0:$484]:=43;
     Mem[0:$485]:=8;
    End;
    Else Begin
     Q.NumYPixels:=400;
     ASM
      MOV AX,01202h
      MOV BL,030h
      INT 010h
      MOV AX,MW
      INT 010h
      MOV AX,01114h
      MOV BL,0
      INT 010h
     END;
    End;
   End;
   {$IFDEF DPMI}
    If(CurrVideoMode=MW)Then
   {$ELSE}
    If(Mem[0:$449]=MW)Then
   {$ENDIF}
    SetVidModeVGAPrim:=drvTxt;
  End;
  vmHerc:SetVidModeHerculePrim(Mode,Q);
 End;
End;

Function SetVidModeAheadBPrim;Var MW:Byte;Begin
 ASM
  JMP @Next
@DataMode:
  DW vmTxtC132x44;     DB 022h,drvTxt
  DW vmTxtC132x28;     DB 024h,drvTxt
  DW vmTxtC160x50;     DB 02Fh,drvTxt
  DW vmTxtC80x34;      DB 032h,drvTxt
  DW vmTxtC80x66;      DB 034h,drvTxt
  DW vmTxtC132;        DB 050h,drvTxt
  DW vmGrf640x400c256; DB 060h,drvSVGA
  DW vmGrf640x480c256; DB 061h,drvSVGA
  DW vmGrf800x600c256; DB 062h,drvSVGA
  DW vmGrf1024x768c256;DB 063h,drvSVGA
  DW vmGrf720x392c16;  DB 070h,drv16
  DW vmGrf800x600c16;  DB 071h,drv16
  DW vmGrf1024x768c16; DB 074h,drv16
  DW vmGrf1024x768c4;  DB 075h,drvBios
  DW vmGrf1024x768c2;  DB 076h,drv2
  DB 0 { Fin de liste }
@Next:
  MOV AX,Offset @DataMode
  PUSH AX
  PUSH Mode
  CALL LoadBnkMode
  MOV MW,AL
  MOV @Result,AL
 END;
 If MW=$FFThen
 {$IFDEF DPMI}
  SetVidModeAheadBPrim:=SetVidModeVGAPrim(Mode,Q)
 {$ELSE}
  ASM JMP SetVidModeVGAPrim.Near[3];END;
 {$ENDIF}
End;

Function SetVidModeAllStarPeacockPrim;Var MW:Byte;Begin
 ASM
  JMP @Next
@DataMode:
  DW vmTxtC132x43;     DB 022h,drvTxt
  DW vmTxtMono132x43;  DB 022h,drvTxt
  DW vmTxtC132x28;     DB 023h,drvTxt
  DW vmTxtMono132x28;  DB 023h,drvTxt
  DW vmTxtC132;        DB 024h,drvTxt
  DW vmTxtMono132;     DB 024h,drvTxt
  DW vmTxtC80x60;      DB 026h,drvTxt
  DW vmTxtMono80x60;   DB 026h,drvTxt
  DW vmGrf800x600c16;  DB 029h,drv16
  DW vmTxtC100x40;     DB 02Ah,drvTxt
  DW vmTxtMono100x40;  DB 02Ah,drvTxt
  DB 0 { Fin de liste }
@Next:
  MOV AX,Offset @DataMode
  PUSH AX
  PUSH Mode
  CALL LoadBnkMode
  MOV MW,AL
  MOV @Result,AL
 END;
 If MW=$FFThen
 {$IFDEF DPMI}
  SetVidModeAllStarPeacockPrim:=SetVidModeVGAPrim(Mode,Q)
 {$ELSE}
  ASM JMP SetVidModeVGAPrim.Near[3];END;
 {$ENDIF}
End;

Function SetVidModeASTVGAPlusPrim;Var MW:Byte;Begin
 ASM
  JMP @Next
@DataMode:
  DW vmTxtC132;        DB 054h,drvTxt
  DW vmTxtMono132;     DB 054h,drvTxt
  DW vmTxtC132x43;     DB 055h,drvTxt
  DW vmTxtMono132x43;  DB 055h,drvTxt
  DW vmGrf640x400c256; DB 05Eh,drvSVGA
  DW vmGrf640x480c256; DB 05Fh,drvSVGA
  DB 0 { Fin de liste }
@Next:
  MOV AX,Offset @DataMode
  PUSH AX
  PUSH Mode
  CALL LoadBnkMode
  MOV MW,AL
  MOV @Result,AL
 END;
 If MW=$FFThen
 {$IFDEF DPMI}
  SetVidModeASTVGAPlusPrim:=SetVidModeVGAPrim(Mode,Q)
 {$ELSE}
  ASM JMP SetVidModeVGAPrim.Near[3];END;
 {$ENDIF}
End;

Function SetVidModeATTVDC600Prim;Var MW:Byte;Begin
 ASM
  JMP @Next
@DataMode:
  DW vmGrf640x400c16;  DB 042h,drv16
  DW vmGrf800x600c16;  DB 047h,drv16
  DW vmTxtC132x43;     DB 054h,drvTxt
  DW vmTxtC132;        DB 055h,drvTxt
  DW vmTxtMono132x43;  DB 056h,drvTxt
  DW vmTxtMono132;     DB 057h,drvTxt
  DW vmGrf640x400c256; DB 05Eh,drvSVGA
  DW vmGrf640x480c256; DB 05Fh,drvSVGA
  DB 0 { Fin de liste }
@Next:
  MOV AX,Offset @DataMode
  PUSH AX
  PUSH Mode
  CALL LoadBnkMode
  MOV MW,AL
  MOV @Result,AL
 END;
 If MW=$FFThen
 {$IFDEF DPMI}
  SetVidModeATTVDC600Prim:=SetVidModeVGAPrim(Mode,Q)
 {$ELSE}
  ASM JMP SetVidModeVGAPrim.Near[3];END;
 {$ENDIF}
End;

Function SetVidModeCardinalPrim;Var MW:Byte;Begin
 ASM
  JMP @Next
@DataMode:
  DW vmGrf800x600c16;  DB 070h,drv16
  DW vmGrf1024x768c16; DB 072h,drv16
  DW vmGrf640x400c256; DB 078h,drvSVGA
  DW vmGrf640x480c256; DB 079h,drvSVGA
  DW vmGrf720x540c256; DB 07Ah,drvSVGA
  DW vmGrf800x600c256; DB 07Bh,drvSVGA
  DB 0 { Fin de liste }
@Next:
  MOV AX,Offset @DataMode
  PUSH AX
  PUSH Mode
  CALL LoadBnkMode
  MOV MW,AL
  MOV @Result,AL
 END;
 If MW=$FFThen
 {$IFDEF DPMI}
  SetVidModeCardinalPrim:=SetVidModeVGAPrim(Mode,Q)
 {$ELSE}
  ASM JMP SetVidModeVGAPrim.Near[3];END;
 {$ENDIF}
End;

Function SetVidModeCirrusPrim;Var MW:Wd;Begin
  { *********************************************************** }
  {                                                             }
  {                           Cirrus                            }
  {              * * * * * A Compläter ! * * * * *              }
  {                                                             }
  { *********************************************************** }
 {$IFDEF DPMI}
  SetVidModeCirrusPrim:=SetVidModeVGAPrim(Mode,Q)
 {$ELSE}
  ASM JMP SetVidModeVGAPrim.Near[3];END;
 {$ENDIF}
End;

Function SetVidModeEverexPrim;Var MW:Wd;Begin
  { *********************************************************** }
  {                                                             }
  {                           Everex                            }
  {              * * * * * A Compläter ! * * * * *              }
  {                                                             }
  { *********************************************************** }
 {$IFDEF DPMI}
  SetVidModeEverexPrim:=SetVidModeVGAPrim(Mode,Q)
 {$ELSE}
  ASM JMP SetVidModeVGAPrim.Near[3];END;
 {$ENDIF}
End;

Function SetVidModeGenoaPrim;Var MW:Byte;Begin
 ASM
  JMP @Next
@DataMode:
  DW vmGrf720x512c16;  DB 027h,drv16
  DW vmGrf800x600c16;  DB 029h,drv16
  DW vmGrf720x512c256; DB 02Fh,drvSVGA
  DW vmGrf800x600c256; DB 030h,drvSVGA
  DW vmGrf1024x768c16; DB 037h,drv16
  DW vmGrf512x512c16;  DB 07Ch,drv16
  DW vmGrf512x512c256; DB 07Dh,drvSVGA
  DB 0 { Fin de liste }
@Next:
  MOV AX,Offset @DataMode
  PUSH AX
  PUSH Mode
  CALL LoadBnkMode
  MOV MW,AL
  MOV @Result,AL
 END;
 If MW=$FFThen
 {$IFDEF DPMI}
  SetVidModeGenoaPrim:=SetVidModeVGAPrim(Mode,Q)
 {$ELSE}
  ASM JMP SetVidModeVGAPrim.Near[3];END;
 {$ENDIF}
End;

Function SetVidModeHPD1180APrim;Var MW:Byte;Begin
 ASM
  JMP @Next
@DataMode:
  DW vmTxtC132x43;     DB 054h,drvTxt
  DW vmTxtMono132x43;  DB 054h,drvTxt
  DW vmTxtC132x28;     DB 055h,drvTxt
  DW vmTxtMono132x28;  DB 055h,drvTxt
  DW vmGrf800x600c2;   DB 059h,drv2
  DW vmGrf640x480c256; DB 05Fh,drvSVGA
  DB 0 { Fin de liste }
@Next:
  MOV AX,Offset @DataMode
  PUSH AX
  PUSH Mode
  CALL LoadBnkMode
  MOV MW,AL
  MOV @Result,AL
 END;
 If MW=$FFThen
 {$IFDEF DPMI}
  SetVidModeHPD1180APrim:=SetVidModeVGAPrim(Mode,Q)
 {$ELSE}
  ASM JMP SetVidModeVGAPrim.Near[3];END;
 {$ENDIF}
End;

Function SetVidModeMorseVGAPrim;Var MW:Byte;Begin
 ASM
  JMP @Next
@DataMode:
  DW vmTxtC100x30;     DB 040h,drvTxt
  DW vmTxtC100x50;     DB 041h,drvTxt
  DW vmTxtC100x60;     DB 042h,drvTxt
  DW vmTxtC100x75;     DB 043h,drvTxt
  DW vmTxtC132x30;     DB 050h,drvTxt
  DW vmTxtC132x50;     DB 051h,drvTxt
  DW vmTxtC132x60;     DB 052h,drvTxt
  DW vmTxtC80x60;      DB 053h,drvTxt
  DW vmGrf720x540c16;  DB 063h,drv16
  DW vmGrf800x600c16;  DB 064h,drv16
  DB 0 { Fin de liste }
@Next:
  MOV AX,Offset @DataMode
  PUSH AX
  PUSH Mode
  CALL LoadBnkMode
  MOV MW,AL
  MOV @Result,AL
 END;
 If MW=$FFThen
 {$IFDEF DPMI}
  SetVidModeMorseVGAPrim:=SetVidModeVGAPrim(Mode,Q)
 {$ELSE}
  ASM JMP SetVidModeVGAPrim.Near[3];END;
 {$ENDIF}
End;

Function SetVidModeOakPrim;Var MW:Byte;Begin
 ASM
  JMP @Next
@DataMode:
  DW vmTxtC132;        DB 050h,drvTxt
  DW vmTxtC132x43;     DB 051h,drvTxt
  DW vmGrf800x600c16;  DB 052h,drv16
  DW vmGrf640x480c256; DB 053h,drvSVGA
  DW vmGrf800x600c256; DB 054h,drvSVGA
  DW vmGrf1024x768c16; DB 056h,drv16
  DW vmGrf1024x768c256;DB 059h,drvSVGA
  DB 0 { Fin de liste }
@Next:
  MOV AX,Offset @DataMode
  PUSH AX
  PUSH Mode
  CALL LoadBnkMode
  MOV MW,AL
  MOV @Result,AL
 END;
 If MW=$FFThen
 {$IFDEF DPMI}
  SetVidModeOakPrim:=SetVidModeVGAPrim(Mode,Q)
 {$ELSE}
  ASM JMP SetVidModeVGAPrim.Near[3];END;
 {$ENDIF}
End;

Function SetVidModeOrchidPrim;Var MW:Byte;Begin
 ASM
  JMP @Next
@DataMode:
  DW vmGrf800x600c16;  DB 029h,drv16
  DW vmGrf640x350c256; DB 02Dh,drvSVGA
  DW vmGrf640x480c256; DB 02Eh,drvSVGA
  DW vmGrf800x600c256; DB 030h,drvSVGA
  DW vmGrf1024x768c16; DB 037h,drv16
  DB 0 { Fin de liste }
@Next:
  MOV AX,Offset @DataMode
  PUSH AX
  PUSH Mode
  CALL LoadBnkMode
  MOV MW,AL
  MOV @Result,AL
 END;
 If MW=$FFThen
 {$IFDEF DPMI}
  SetVidModeOrchidPrim:=SetVidModeVGAPrim(Mode,Q)
 {$ELSE}
  ASM JMP SetVidModeVGAPrim.Near[3];END;
 {$ENDIF}
End;

Function SetVidModeOrchidProPrim;Var MW:Byte;Begin
 ASM
  JMP @Next
@DataMode:
  DW vmTxtC132x44; DB 022h,drvTxt
  DW vmTxtC132x28; DB 023h,drvTxt
  DW vmTxtC132;    DB 024h,drvTxt
  DW vmTxtC80x60;  DB 026h,drvTxt
  DW vmTxtC100x40; DB 02Ah,drvTxt
  DB 0 { Fin de liste }
@Next:
  MOV AX,Offset @DataMode
  PUSH AX
  PUSH Mode
  CALL LoadBnkMode
  MOV MW,AL
  MOV @Result,AL
 END;
 If MW=$FFThen
 {$IFDEF DPMI}
  SetVidModeOrchidProPrim:=SetVidModeVGAPrim(Mode,Q)
 {$ELSE}
  ASM JMP SetVidModeVGAPrim.Near[3];END;
 {$ENDIF}
End;

Function SetVidModeParadisePrim;Var MW:Byte;Begin
 ASM
  JMP @Next
@DataMode:
  DW vmTxtC132x43;    DB 054h,drvTxt
  DW vmTxtC132;       DB 055h,drvTxt
  DW vmTxtMono132x43; DB 056h,drvTxt
  DW vmTxtMono132;    DB 057h,drvTxt
  DW vmGrf800x600c16; DB 058h,drv16
  DW vmGrf800x600c2;  DB 059h,drv2
  DW vmGrf640x400c256;DB 05Eh,drvSVGA
  DW vmGrf640x480c256;DB 05Fh,drvSVGA
  DB 0 { Fin de liste }
@Next:
  MOV AX,Offset @DataMode
  PUSH AX
  PUSH Mode
  CALL LoadBnkMode
  MOV MW,AL
  MOV @Result,AL
 END;
 If MW=$FFThen
 {$IFDEF DPMI}
  SetVidModeParadisePrim:=SetVidModeVGAPrim(Mode,Q)
 {$ELSE}
  ASM JMP SetVidModeVGAPrim.Near[3];END;
 {$ENDIF}
End;

Function SetVidModeRealtekRTVGAPrim;Var MW:Wd;Begin
  { *********************************************************** }
  {                                                             }
  {                        Realtek RTVGA                        }
  {              * * * * * A Compläter ! * * * * *              }
  {                                                             }
  { *********************************************************** }
 {$IFDEF DPMI}
  SetVidModeRealtekRTVGAPrim:=SetVidModeVGAPrim(Mode,Q)
 {$ELSE}
  ASM JMP SetVidModeVGAPrim.Near[3];END;
 {$ENDIF}
End;

Function SetVidModeSigmaPrim;Var MW:Byte;Begin
 ASM
  JMP @Next
@DataMode:
  DW vmGrf800x600c16; DB 029h,drv16
  DW vmGrf800x600c256;DB 030h,drvSVGA
  DW vmGrf1024x768c16;DB 037h,drv16
  DB 0 { Fin de liste }
@Next:
  MOV AX,Offset @DataMode
  PUSH AX
  PUSH Mode
  CALL LoadBnkMode
  MOV MW,AL
  MOV @Result,AL
 END;
 If MW=$FFThen
 {$IFDEF DPMI}
  SetVidModeSigmaPrim:=SetVidModeVGAPrim(Mode,Q)
 {$ELSE}
  ASM JMP SetVidModeVGAPrim.Near[3];END;
 {$ENDIF}
End;

Function SetVidModeSTBPrim;Var MW:Byte;Begin
 ASM
  JMP @Next
@DataMode:
  DW vmGrf800x600c16; DB 029h,drv16
  DW vmGrf640x480c256;DB 02Eh,drvSVGA
  DW vmGrf800x600c256;DB 030h,drvSVGA
  DW vmGrf960x720c16; DB 036h,drv16
  DW vmGrf1024x768c16;DB 037h,drv16
  DB 0 { Fin de liste }
@Next:
  MOV AX,Offset @DataMode
  PUSH AX
  PUSH Mode
  CALL LoadBnkMode
  MOV MW,AL
  MOV @Result,AL
 END;
 If MW=$FFThen
 {$IFDEF DPMI}
  SetVidModeSTBPrim:=SetVidModeVGAPrim(Mode,Q)
 {$ELSE}
  ASM JMP SetVidModeVGAPrim.Near[3];END;
 {$ENDIF}
End;

Function SetVidModeTatungVGAPrim;Var MW:Byte;Begin
 ASM
  JMP @Next
@DataMode:
  DW vmTxtC132;       DB 041h,drvTxt
  DW vmTxtMono132;    DB 041h,drvTxt
  DW vmTxtC132x43;    DB 042h,drvTxt
  DW vmTxtMono132x43; DB 042h,drvTxt
  DW vmTxtC80x60;     DB 043h,drvTxt
  DW vmTxtMono80x60;  DB 043h,drvTxt
  DW vmTxtC100x60;    DB 044h,drvTxt
  DW vmTxtMono100x60; DB 044h,drvTxt
  DW vmTxtC132x28;    DB 045h,drvTxt
  DW vmTxtMono132x28; DB 045h,drvTxt
  DW vmGrf752x410c16; DB 061h,drv16
  DW vmGrf800x600c16; DB 062h,drv16
  DW vmGrf640x400c256;DB 065h,drvSVGA
  DB 0 { Fin de liste }
@Next:
  MOV AX,Offset @DataMode
  PUSH AX
  PUSH Mode
  CALL LoadBnkMode
  MOV MW,AL
  MOV @Result,AL
 END;
 If MW=$FFThen
 {$IFDEF DPMI}
  SetVidModeTatungVGAPrim:=SetVidModeVGAPrim(Mode,Q)
 {$ELSE}
  ASM JMP SetVidModeVGAPrim.Near[3];END;
 {$ENDIF}
End;

Function SetVidModeTecmarVGAADPrim;Var MW:Byte;Begin
 ASM
  JMP @Next
@DataMode:
  DW vmGrf640x400c16; DB 014h,drv16
  DW vmGrf800x600c16; DB 016h,drv16
  DW vmTxtC132;       DB 017h,drvTxt
  DW vmTxtMono132;    DB 017h,drvTxt
  DW vmGrf1024x768c16;DB 018h,drv16
  DW vmGrf640x350c256;DB 01Ah,drvSVGA
  DW vmGrf640x400c256;DB 01Bh,drvSVGA
  DW vmGrf640x480c256;DB 01Ch,drvSVGA
  DW vmGrf800x600c256;DB 01Dh,drvSVGA
  DB 0 { Fin de liste }
@Next:
  MOV AX,Offset @DataMode
  PUSH AX
  PUSH Mode
  CALL LoadBnkMode
  MOV MW,AL
  MOV @Result,AL
 END;
 If MW=$FFThen
 {$IFDEF DPMI}
  SetVidModeTecmarVGAADPrim:=SetVidModeVGAPrim(Mode,Q)
 {$ELSE}
  ASM JMP SetVidModeVGAPrim.Near[3];END;
 {$ENDIF}
End;

Function SetVidModeTridentPrim;Var MW:Byte;Begin
 Case(Mode)of
 vmTxtMaxRes80:
 {$IFDEF DPMI}
  If VideoPort=$3D4Then Mode:=vmTxtC80x60 Else Mode:=vmTxtMono80x50;
 {$ELSE}
  If MemW[0:$463]=$3D4Then Mode:=vmTxtC80x60 Else Mode:=vmTxtMono80x50;
 {$ENDIF}
 vmTxtMaxRes:
 {$IFDEF DPMI}
  If VideoPort=$3D4Then Mode:=vmTxtC132x60 Else Mode:=vmTxtMono80x50;
 {$ELSE}
  If MemW[0:$463]=$3D4Then Mode:=vmTxtC132x60 Else Mode:=vmTxtMono80x50;
 {$ENDIF}
 End;
 ASM
  JMP @Next
@DataMode:
  DW vmTxtC80x30;       DB 050h,drvTxt
  DW vmTxtC80x60;       DB 052h,drvTxt
  DW vmTxtC132;         DB 053h,drvTxt
  DW vmTxtC132x30;      DB 054h,drvTxt
  DW vmTxtC132x43;      DB 055h,drvTxt
  DW vmTxtC132x60;      DB 056h,drvTxt
  DW vmGrf640x400c256;  DB 05Ch,drvSVGA
  DW vmGrf640x480c256;  DB 05Dh,drvSVGA
  DW vmGrf800x600c256;  DB 05Eh,drvSVGA
  DW vmGrf1024x768c16;  DB 05Fh,drv16
  DW vmGrf768x1024c16;  DB 061h,drv16
  DW vmGrf1024x768c256; DB 062h,drvSVGA
  DB 0 { Fin de liste }
@Next:
  MOV AX,Offset @DataMode
  PUSH AX
  PUSH Mode
  CALL LoadBnkMode
  MOV MW,AL
  MOV @Result,AL
 END;
 If MW=$FFThen
 {$IFDEF DPMI}
  SetVidModeTridentPrim:=SetVidModeVGAPrim(Mode,Q)
 {$ELSE}
  ASM JMP SetVidModeVGAPrim.Near[3];END;
 {$ENDIF}
End;

Function SetVidModeTsengET4000Prim;Label 3;Var MW:Byte;Begin
 SetVidModeTsengET4000Prim:=$FF;
 Case Mode of
 vmTxtMaxRes80:
 {$IFDEF DPMI}
  If VideoPort=$3D4Then Mode:=vmTxtC80x60;
 {$ELSE}
  If MemW[0:$463]=$3D4Then Mode:=vmTxtC80x60;
 {$ENDIF}
 vmTxtMaxRes:
 {$IFDEF DPMI}
  If VideoPort=$3D4Then Mode:=vmTxtC100x75;
 {$ELSE}
  If MemW[0:$463]=$3D4Then Mode:=vmTxtC100x75;
 {$ENDIF}
 vmMaxKrMode640x350: Mode:=vmGrf640x350c256;
 vmMinKrMode640x400: Mode:=vmGrf640x400c16;
 vmMaxKrMode640x400: Mode:=vmGrf640x400c256;
 vmMaxKrMode640x480: Mode:=vmGrf640x480c256;
 vmMinKrMode800x600: Mode:=vmGrf800x600c16;
 vmMaxKrMode800x600: Mode:=vmGrf800x600c256;
 vmMinKrMode1024x768: Mode:=vmGrf1024x768c16;
 vmMaxKrMode1024x768: Mode:=vmGrf1024x768c256;
 End;
 ASM
  JMP @Next
@DataMode:
  DW vmTxtMono132x44;   DB 018h,drvTxt
  DW vmTxtMono132;      DB 019h,drvTxt
  DW vmTxtMono132x28;   DB 01Ah,drvTxt
  DW vmTxtC132x44;      DB 022h,drvTxt
  DW vmTxtC132;         DB 023h,drvTxt
  DW vmTxtC80x60;       DB 026h,drvTxt
  DW vmGrf800x600c16;   DB 029h,drv16
  DW vmGrf640x350c256;  DB 02Dh,drvSVGA
  DW vmGrf640x480c256;  DB 02Eh,drvSVGA
  DW vmGrf640x400c256;  DB 02Fh,drvSVGA
  DW vmGrf800x600c256;  DB 030h,drvSVGA
  DW vmGrf1024x768c16;  DB 037h,drv16
  DW vmGrf1024x768c256; DB 038h,drvSVGA
  DB 0 { Fin de liste }
@Next:
  MOV AX,Offset @DataMode
  PUSH AX
  PUSH Mode
  CALL LoadBnkMode
  MOV MW,AL
  MOV @Result,AL
 END;
 If MW<$FEThen Exit;
 If Hi(Mode)=Hi(vmTxtMono132)Then Case Lo(Mode)of
  Lo(vmTxtC132x100),Lo(vmTxtC132x60),Lo(vmTxtC132x28):Begin MW:=$24;Goto 3;End;
  Lo(vmTxtC80x30),Lo(vmTxtC80x34):Begin MW:=$26;Goto 3;End;
  Lo(vmTxtC100x37),Lo(vmTxtC100x40),Lo(vmTxtC100x75):Begin
   MW:=$2A;
 3:If SetVideoMode0(MW)Then Begin
    Case Lo(Mode)of
     Lo(vmTxtC80x30):ASM
      MOV AX,01114h
      MOV BL,0
      INT 010h
     END;
     Lo(vmTxtC80x34):ASM
      MOV AX,01111h
      MOV BL,0
      INT 010h
     END;
     Lo(vmTxtC100x37):ASM
      MOV AX,01114h
      MOV BL,0
      INT 010h
     END;
     Lo(vmTxtC100x75):ASM
      MOV AX,01112h
      MOV BL,0
      INT 010h
     END;
     Lo(vmTxtC132x60),Lo(vmTxtC132x100):ASM
      MOV AX,01112h
      MOV BL,0
      INT 010h
      CLI
      MOV DX,03D4h
      MOV CL,59
      CMP Mode,vmTxtC132x100
      JNE @No132x100
      MOV CL,99
      MOV AX,07806h;OUT DX,AX{ 6-120 }
      MOV AX,0F007h;OUT DX,AX{ 7-240 }
      MOV AX,05C10h;OUT DX,AX{10h-92 }
      MOV AX,08E11h;OUT DX,AX{11h-142}
      MOV AX,05712h;OUT DX,AX{12h-87 }
      MOV AX,05B15h;OUT DX,AX{15h-91 }
      MOV AX,07516h;OUT DX,AX{16h-117 }
     @No132x100:
      XOR AX,AX
      MOV ES,AX
      MOV ES:[0484h].Byte,CL
      MOV AX,04509h;OUT DX,AX{9-69}
      MOV AX,0040Ah;OUT DX,AX{10-4}
      MOV AX,0050Bh;OUT DX,AX{11-5}
      MOV Word Ptr ES:[0485h],6
      STI
     END;
    End;
    SetVidModeTsengET4000Prim:=drvTxt;
   End;
   Exit;
  End;
 End;
 {$IFDEF DPMI}
  SetVidModeTsengET4000Prim:=SetVidModeVGAPrim(Mode,Q)
 {$ELSE}
  ASM JMP SetVidModeVGAPrim.Near[3];END;
 {$ENDIF}
End;

Function SetVidModeTsengET4000HiColorPrim;Label 2;Var MW,_AX:Wd;Begin
 SetVidModeTsengET4000HiColorPrim:=$FF;
 Case(Mode)of
 vmMaxKrMode320x200: Mode:=vmGrf320x200c32768;
 vmMaxKrMode640x350: Mode:=vmGrf640x350c32768;
 vmMaxKrMode640x400: Mode:=vmGrf640x400c32768;
 vmMaxKrMode640x480: Mode:=vmGrf640x480c32768;
 vmMaxKrMode800x600: Mode:=vmGrf800x600c32768;
 vmMaxKrMode1024x768: Mode:=vmGrf1024x768c256;
 End;
 Case(Mode)of
  vmGrf640x350c32768:Begin MW:=$2D;Goto 2;End;
  vmGrf640x480c32768:Begin MW:=$2E;Goto 2;End;
  vmGrf640x400c32768:Begin MW:=$2F;Goto 2;End;
  vmGrf800x600c32768:Begin MW:=$30;Goto 2;End;
  vmGrf1024x768c32768:Begin MW:=$38;Goto 2;End;
  vmGrf320x200c32768:Begin
   MW:=$13;
 2:ASM
    MOV AX,010F0h
    MOV BX,MW
    INT 010h
    MOV _AX,AX
   END;
   If _AX=0Then SetVidModeTsengET4000HiColorPrim:=drvSVGAWord;
  End;
  Else
  {$IFDEF DPMI}
   SetVidModeTsengET4000HiColorPrim:=SetVidModeTsengET4000Prim(Mode,Q)
  {$ELSE}
   ASM JMP SetVidModeTsengET4000Prim.Near[3];END;
  {$ENDIF}
 End;
End;

Function SetVidModeVGAWonderPrim;Var MW:Byte;Begin
 SetVidModeVGAWonderPrim:=$FF;
 Case(Mode)of
 vmTxtMaxRes:
 {$IFDEF DPMI}
  If VideoPort=$3D4Then Mode:=vmTxtC100x75 Else Mode:=vmTxtMono80x50;
 {$ELSE}
  If MemW[0:$463]=$3D4Then Mode:=vmTxtC100x75 Else Mode:=vmTxtMono80x50;
 {$ENDIF}
 vmMinKrMode640x400: Mode:=vmGrf640x400c16;
 vmMaxKrMode640x400: Mode:=vmGrf640x400c256;
 vmMinKrMode640x480: Mode:=vmGrf640x480c16;
 vmMaxKrMode640x480: Mode:=vmGrf640x480c256;
 vmMinKrMode800x600: Mode:=vmGrf800x600c16;
 vmMaxKrMode800x600: Mode:=vmGrf800x600c256;
 End;
 ASM
  JMP @Next
@DataMode:
  DW vmGrf800x600c16;   DB 054h,drv16
  DW vmGrf1024x768c16;  DB 055h,drv16
  DW vmGrf640x400c256;  DB 061h,drvSVGA
  DW vmGrf640x480c256;  DB 062h,drvSVGA
  DW vmGrf800x600c256;  DB 063h,drvSVGA
  DW vmGrf1024x768c256; DB 064h,drvSVGA
  DB 0 { Fin de liste }
@Next:
  MOV AX,Offset @DataMode
  PUSH AX
  PUSH Mode
  CALL LoadBnkMode
  MOV MW,AL
  MOV @Result,AL
 END;
 If MW=$FFThen Begin
  If Hi(Mode)=$12Then {$IFDEF DPMI}
                       SetVidModeVGAWonderPrim:=SetVidModeEGAWonderPrim(Mode,Q)
                      {$ELSE}
                       ASM JMP SetVidModeEGAWonderPrim.Near[3];END
                      {$ENDIF}
		 Else {$IFDEF DPMI}
                       SetVidModeVGAWonderPrim:=SetVidModeVGAPrim(Mode,Q)
                      {$ELSE}
                       ASM JMP SetVidModeVGAPrim.Near[3];END;
                      {$ENDIF}
 End;
End;

Function SetVidModeVESAPrim;Label 2,3,4;Var MW:Wd;Vesa:VesaInfo;VesaPtr:^VesaInfo;Begin
 SetVidModeVESAPrim:=$FF;
 Case(Mode)of
  vmTxtMaxRes:ASM
   MOV BX,0010Ch
   CALL @Sub1
   JNE @TestC132x50
   MOV AX,vmTxtC132x60
   JMP @End
@Sub1:
   MOV AX,04F02h
   INT 010h
   CMP AL,04Fh
   RETN
@TestC132x50:
   MOV BX,0010Bh
   CALL @Sub1
   JNE @TestC132x43
   MOV AX,vmTxtC132x50
   JMP @End
@TestC132x43:
   MOV BX,010Ah
   CALL @Sub1
   JNE @TestC80x60
   MOV AX,vmTxtC132x43
   JMP @End
@TestC80x60:
   MOV BX,0108h
   CALL @Sub1
   JNE @TestC132
   MOV AX,vmTxtC80x60
   JMP @End
@TestC132:
   MOV BX,0109h
   CALL @Sub1
   JE  @SetC132
   MOV AX,3
   INT 010h
   MOV AX,vmTxtC80
   JMP @End
@SetC132:
   MOV AX,vmTxtC132
 @End:
   MOV @Result,drvTxt
  END;
  vmTxtC132:Begin;MW:=$109;Goto 2;End;
  vmTxtC132x43:Begin;MW:=$10A;Goto 2;End;
  vmTxtC132x50:Begin;MW:=$10B;Goto 2;End;
  vmTxtC132x60:Begin;MW:=$10C;Goto 2;End;
  vmTxtC80x30,vmTxtC80x34,vmTxtC80x60:Begin
   MW:=$108;
 2:ASM
    MOV AX,04F02h
    MOV BX,MW
    INT 010h
   END;
   Case Lo(Mode)of
    Lo(vmTxtC80x30):ASM
     MOV AX,01114h
     MOV BL,0
     INT 010h
    END;
    Lo(vmTxtC80x34):ASM
     MOV AX,01111h
     MOV BL,0
     INT 010h
    END;
   End;
   SetVidModeVESAPrim:=drvTxt;
  End;
  vmGrf640x400c256:Begin;MW:=$100;Goto 3;End;
  vmGrf640x480c256:Begin;MW:=$101;Goto 3;End;
  vmGrf800x600c256:Begin;MW:=$103;Goto 3;End;
  vmGrf1024x768c256:Begin;MW:=$105;Goto 3;End;
  vmGrf1280x1024c256:Begin
   MW:=$107;
 3:ASM
    MOV AX,04F02h
    MOV BX,MW
    INT 010h
   END;
   SetVidModeVESAPrim:=drvVESA;VesaPtr:=@Vesa;
   ASM
    MOV AX,04F01h
    MOV CX,MW
    LES DI,VesaPtr
    INT 010h
   END;
   Q.AddrPage:=Vesa.WindowSize;
   Case(MW)of
    $100:Begin;Mem[$0040:$85]:=16;Mem[$0040:$84]:=24;End;
    $101:Begin;Mem[$0040:$85]:=16;Mem[$0040:$84]:=29;End;
    $103:Begin;Mem[$0040:$85]:=16;Mem[$0040:$84]:=36;End;
    $105:Begin;Mem[$0040:$85]:=16;Mem[$0040:$84]:=47;End;
   End;
  End;
  vmGrf320x200c32768:Begin
   MW:=$10D;
   Goto 4;
  End;
  vmGrf320x200c65536:Begin
   MW:=$10E;
   Goto 4;
  End;
  vmGrf640x480c32768:Begin
   MW:=$110;
   Goto 4;
  End;
  vmGrf640x480c65536:Begin
   MW:=$111;
   Goto 4;
  End;
  vmGrf800x600c32768:Begin
   MW:=$113;
   Goto 4;
  End;
  vmGrf800x600c65536:Begin
   MW:=$114;
   Goto 4;
  End;
  vmGrf1024x768c32768:Begin
   MW:=$116;
   Goto 4;
  End;
  vmGrf1024x768c65536:Begin
   MW:=$117;
   Goto 4;
  End;
  vmGrf1280x1024c32768:Begin
   MW:=$119;
   Goto 4;
  End;
  vmGrf1280x1024c65536:Begin
   MW:=$11A;
 4:ASM
    MOV AX,04F02h
    MOV BX,MW
    INT 010h
   END;
   SetVidModeVESAPrim:=drvSVGA65536;VesaPtr:=@Vesa;
   ASM
    MOV AX,04F01h
    MOV CX,MW
    LES DI,VesaPtr
    INT 010h
   END;
   Q.AddrPage:=Vesa.WindowSize;
  End;
  Else SetVidModeVESAPrim:=SetVidModeVGAPrim(Mode,Q)
 End;
End;

Function SetVidModeVideo7Prim;Var MW:Byte;Begin
  { *********************************************************** }
  {                                                             }
  {                           Video 7                           }
  {              * * * * * A Compläter ! * * * * *              }
  {                                                             }
  { *********************************************************** }
 ASM
  JMP @Next
@DataMode:
  DW vmTxtC132;       DB 041h,drvTxt
  DW vmTxtC132x43;    DB 042h,drvTxt
  DW vmGrf720x540c16; DB 061h,drv16
  DW vmGrf800x600c16; DB 062h,drv16
  DW vmGrf640x480c256;DB 067h,drvSVGA
  DB 0 { Fin de liste }
@Next:
  MOV AX,Offset @DataMode
  PUSH AX
  PUSH Mode
  CALL LoadBnkMode
  MOV MW,AL
  MOV @Result,AL
 END;
 If MW=$FFThen
 {$IFDEF DPMI}
  SetVidModeVideo7Prim:=SetVidModeVGAPrim(Mode,Q)
 {$ELSE}
  ASM JMP SetVidModeVGAPrim.Near[3];END;
 {$ENDIF}
End;

Function SetVidModeXGAPrim;Var MW:Wd;Begin
  { *********************************************************** }
  {                                                             }
  {                            XGA                              }
  {              * * * * * A Compläter ! * * * * *              }
  {                                                             }
  { *********************************************************** }
 {$IFDEF DPMI}
  SetVidModeXGAPrim:=SetVidModeVGAPrim(Mode,Q)
 {$ELSE}
  ASM JMP SetVidModeVGAPrim.Near[3];END;
 {$ENDIF}
End;

{$IFNDEF DPMI}
 Procedure EndList;Begin;End;
{$ENDIF}