Unit DllTex;

INTERFACE

Uses Systex;

Const
 mfStartUp=1;
 mf_AutoDetect=2;
 mf_GetVideoCard=3;
 mfInit=4;
 mfBar=5;
 mfBarChrHor=6;
 mfBarChrVer=7;
 mfBarSpcHor=8;
 mfBiosBlinkFound=9;
 mfBitsPerPixel=10;
 mfBytesPerLn=11;
 mfCloseCur=12;
 mfClrLnHor=13;
 mfClrLnHorImg=14;
 mfClrScr=15;
 mfClrWn=16;
 mfColorFound=17;
 mfCopT8Bin=18;
 mfCopy8Bin=19;
 mfFillBox=20;
 mfFontFound=21;
 mfGetAttr=22;
 mfGetChr=23;
 mfGetCube=24;
 mfGetLnHorImg=25;
 mfGetMaxKr=26;
 mfGetMIV=27;
 mfGetNmKr=28;
 mfGetNmVideoPages=29;
 mfGetPIV=30;
 mfGetPIVSec=31;
 mfGetPixel=32;
 mfGetRealRawY=33;
 mfGetRealRawYWord=34;
 mfGetSelPg=35;
 mfGetSizeSmlImg=36;
 mfGetSmlImg=37;
 mfGetVideoBitsDac=38;
 mfGetVideoBitsIO=39;
 mfGetVideoBitsROM=40;
 mfGetVideoCard=41;
 mfGetVideoCardCat=42;
 mfGetVideoMem=43;
 mfGetVideoMode=44;
 mfGetVideoPg=45;
 mfGetVideoMonitor=46;
 mfGetVideoScrSize=47;
 mfGetVideoSeg=48;
 mfGetVideoSegBuf=49;
 mfGetVideoSegROM=50;
 mfGetVideoShowPg=51;
 mfGetVideoSizeBnkPg=52;
 mfGetVideoTxtAddrPg=53;
 mfGetVideoTxtMtxPtr=54;
 mfHeightChr=55;
 mfIsBlink=56;
 mfIsEGA=57;
 mfIsGrf=58;
 mfIsKr=59;
 mfIsMono=60;
 mfIsVESA=61;
 mfIsVGA=62;
 mfIsVideoDirectAccess=63;
 mfIsVideoModeBios=64;
 mfIsVideoModeIBMLogic=65;
 mfIsVideoSnow=66;
 mfMaxXPixels=67;
 mfMaxXTxts=68;
 mfMaxYPixels=69;
 mfMaxYTxts=70;
 mfMoveText=71;
 mfNmXPixels=72;
 mfNmXTxts=73;
 mfNmYPixels=74;
 mfNmYTxts=75;
 mfPCopy=76;
 mfPutFillBox=77;
 mfPutLn=78;
 mfPutLnHor=79;
 mfPutSmlImg=80;
 mfPutTxtXY=81;
 mfPutTxtXYUnKr=82;
 mfReadBnk=83;
 mfSelBnkPg=84;
 mfSetAttr=85;
 mfSetBlink=86;
 mfSetBnkPg=87;
 mfSetChr=88;
 mfSetChrWidth=89;
 mfSetCube=90;
 mfSetCur=91;
 mfSetCurPos=92;
 mfSetGCube=93;
 mfSetGCubeT=94;
 mfSetHeightChr=95;
 mfSetMatrix=96;
 mfSetModeMtx=97;
 mfSetModeScr=98;
 mfSetModeValue=99;
 mfSetPg=100;
 mfSetPIV=101;
 mfSetPixel=102;
 mfSetTxtMtx=103;
 mfSetVisualPg=104;
 mfVGA320x400Found=105;
 mfVideoFontFound=106;
 mfVideoHerculeFound=107;
 mfVideoMousePortFound=108;
 mfVideoPaletteFound=109;
 mfWriteBnk=110;
 mfviSetVideoModePrim=111;
 mfDone=112;
 mfClrScrBlack=113;
 mfviInitVideo=114;
 mfSetPalBlk=115;
 mfSetPalRGB=116;
 mfBarTxtHor=117;
 mfSetVideoSize=118;
 mfBarSpcVer=119;
 mfCircle=120;
 mfFillBnk=121;
 mfPCopy2Img=122;
 mfPutCharGAttr=123;
 mfPutFillCircle=124;
 mfPutFillRoundRect=125;
 mfPutRect=126;
 mfPutRoundRect=127;
 mfPutSprite=128;
 mfSetBackgroundColor=129;
 mfSetBorderColor=130;
 mfSetBytesPerLn=131;
 mfSetDblMtx=132;
 mfSetExtChr=133;
 mfSetExtCube=134;
 mfSetHorizontalScale=135;
 mfSetUnderline=136;
 mfSetVerticalScale=137;
 mfSetPaletteRGB=138;
 mfSetVideoSeg=139;
 mfSetWriteMode=140;
 mfSplitScreen=141;
 mfIsMalte=1000;

Procedure GetVideoCard(CheckSvga:Bool;Var PVid,PVid2:PIV);
Procedure StartUpChantal(Var Jump:Jumper;Var StartUp:StartUpRec);
{$IFDEF Windows}
 Function GetDosEnv:System.PChar;
 Function _WClose(Handle:Int):Int;
 Function _WGetRec(FileHandle:Int;Buffer:PChar;Bytes:Int):Wd;
 Function _WNew(PathName:PChar;Attr:Int):Int;
 Function _WSetFilePos(Handle:Int;Ofs:Long;Origin:Int):Long;
 Function _WOpen(PathName:PChar;ReadWrite:Int):Int;
 Function _WSetRec(FileHandle:Int;Buffer:PChar;Bytes:Int):Wd;
{$ENDIF}

IMPLEMENTATION

Uses DosTex,Adele
     {$IFDEF Windows}
      ,SysUtils,WinProcs,WinTypes
     {$ENDIF};

Procedure GetVideoCard;
{$IFDEF DPMI}
 External'MALTE'Index mf_GetVideoCard;
{$ELSE}
 Begin
 End;
{$ENDIF}
Procedure StartUpChantal;
{$IFDEF Windows}
 Var Ver:Long;SysFlags:Word;Begin
  FillChar(StartUp,SizeOf(StartUp),0);
  Case(Test8086)of
   0:StartUp.CPU:=cpu8086;
   1:StartUp.CPU:=cpu80286;
   2:StartUp.CPU:=cpui386;
   3:StartUp.CPU:=cpui486;
   Else StartUp.CPU:=cpui486;
  End;
  StartUp.Up32Bits:=StartUp.CPU>cpu80286;
  StartUp.HandleExist:=Ya;
  Ver:=GetVersion;
  StartUp.GetDosVer:=LongRec(Ver).Hi;
  StartUp.WinLoVer:=Lo(Ver);
  StartUp.WinHiVer:=Hi(Ver);
  SysFlags:=GetWinFlags;
  StartUp.Win:=winNo;
  If WordBool(SysFlags and WF_ENHANCED)Then StartUp.Win:=winEnhanced Else
  If WordBool(SysFlags and WF_STANDARD)Then StartUp.Win:=winStandard Else
  If WordBool(SysFlags and WF_PMODE)Then StartUp.Win:=winReal;
  Case GetKeyboardType(1)of
     1: StartUp.KbdModel:=kbXT;
     3: StartUp.KbdModel:=kbAT;
   2,4: StartUp.KbdModel:=kbMF;
   Else StartUp.KbdModel:=kbPC;
  End;
  StartUp.CodePage:=GetKBCodePage;
  StrPCopy(@Curr,CurrencyString);
  CurrStyle:=CurrencyFormat;
  ThSep[0]:=ThousandSeparator;ThSep[1]:=#0;
  DeSep[0]:=DecimalSeparator; DeSep[1]:=#0;
  Digits:=CurrencyDecimals;
  DtSep[0]:=DateSeparator;    DtSep[1]:=#0;
  Adele.Time:=Dostex.Military;
  TmSep[0]:=TimeSeparator;    TmSep[1]:=#0;
 End;
{$ELSE}
 External'STARTUP'Index mfStartUp;
{$ENDIF}
{$IFDEF Windows}
 Function GetDosEnv;External'KERNEL'Index 131;
 Function _WClose;External'KERNEL'Index 81;
 Function _WGetRec;External'KERNEL'Index 82;
 Function _WNew;External'KERNEL'Index 83;
 Function _WSetFilePos;External'KERNEL'Index 84;
 Function _WOpen;External'KERNEL'Index 85;
 Function _WSetRec;External'KERNEL'Index 86;
{$ENDIF}

END.