Library Malte;

{$C FIXED PERMANENT}

Uses Dos,Systex,Dlltex;

Const
 indexProcSelBnkPgVGA=1;
 indexProcSelBnkPgAhead=2;
 indexProcSelBnkPgATI=3;
 indexProcSelBnkPgCirrus=4;
 indexProcSelBnkPgCTI=5;
 indexProcSelBnkPgEverex=6;
 indexProcSelBnkPgGenoa=7;
 indexProcSelBnkPgHeadLand=8;
 indexProcSelBnkPgOak=9;
 indexProcSelBnkPgParadise=10;
 indexProcSelBnkPgSTB=11;
 indexProcSelBnkPgTrident=12;
 indexProcSelBnkPgTsengET3000=13;
 indexProcSelBnkPgTsengET4000=14;
 indexProcSelBnkPgVesa=15;
 indexProcSelBnkPgVideo7=16;
 indexProcSelBnkPgXGA=17;
 indexProcSelBnkPgZymos=18;

{$I \Source\Chantal\Library\Video\MalteSVM.Inc}
{$I \Source\Chantal\Library\Video\Driver.Inc}

Const
 CurrDrv:Byte=$FF;

Var VesaHeader:VesaHeaderInfo;
    DataVideo:MIV;PhysVideo,PVid2:PIV;
    RawTxtY:Array[Byte]of Wd;
    RealRawY:Array[0..4095]of Long;

Procedure Init;Export;Forward;
Procedure Bar(X1,Y1,X2,Y2:Int;Kr:Wd);Export;Forward;
Procedure BarChrHor(X1,Y,X2:Byte;Chr:Char);Export;Forward;
Procedure BarChrVer(X,Y1,Y2:Byte;Chr:Char);Export;Forward;
Procedure BarSpcHor(X1,Y,X2,Attr:Byte);Export;Forward;
Procedure BarSpcVer(X,Y1,Y2,Attr:Byte);Export;Forward;
Procedure BarTxtHor(X1,Y,X2:Byte;Chr:Char;Attr:Byte);Export;Forward;
Function  BiosBlinkFound:Bool;Export;Forward;
Function  BitsPerPixel:Byte;Export;Forward;
Function  BytesPerLn:Wd;Export;Forward;
Procedure Circle(X,Y,Rayon:Int;Color:Wd);Export;Forward;
Procedure CloseCur;Export;Forward;
Procedure ClrLnHor(X,Y,L,Kr:Wd);Export;Forward;
Procedure ClrLnHorImg(X,Y,L:Wd;BitsPerPixel:Byte;Var Buffer);Export;Forward;
Procedure ClrScr(Attr:Byte);Export;Forward;
Procedure ClrWn(X1,Y1,X2,Y2,Attr:Byte);Export;Forward;
Function  ColorFound:Bool;Export;Forward;
Procedure CopT8Bin(X,Y:Wd;Value,Fore:Byte);Export;Forward;
Procedure Copy8Bin(X,Y:Wd;Value,Back,Fore:Byte);Export;Forward;
Procedure FillBnk(aY:Long;L,Kr:Wd);Export;Forward;
Procedure FillBox(X1,Y1,X2,Y2:Byte;Chr:Char;Attr:Byte);Export;Forward;
Function  FontFound:Bool;Export;Forward;
Function  GetAttr(X,Y:Byte):Byte;Export;Forward;
Function  GetChr(X,Y:Byte):Char;Export;Forward;
Function  GetCube(X,Y:Byte):Wd;Export;Forward;
Procedure GetLnHorImg(X1,Y,X2:Wd;Var Buffer);Export;Forward;
Function  GetMaxKr:Wd;Export;Forward;
Procedure GetMIV(Var X:MIV);Export;Forward;
Function  GetNmKr:Long;Export;Forward;
Function  GetNmVideoPages:Byte;Export;Forward;
Procedure GetPIV(Var X:PIV);Export;Forward;
Procedure GetPIVSec(Var X:PIV);Export;Forward;
Function  GetPixel(X,Y:Wd):Wd;Export;Forward;
Function  GetRealRawY(Y:Wd):Long;Export;Forward;
Function  GetRealRawYWord(Y:Wd):Wd;Export;Forward;
Function  GetSelPg:Byte;Export;Forward;
Function  GetSizeSmlImg(X1,Y1,X2,Y2:Wd):Wd;Export;Forward;
Procedure GetSmlImg(X1,Y1,X2,Y2:Wd;Var Buffer);Export;Forward;
Function  GetVideoBitsDAC:Byte;Export;Forward;
Function  GetVideoBitsIO:Byte;Export;Forward;
Function  GetVideoBitsROM:Byte;Export;Forward;
Function  GetVideoCard:Byte;Export;Forward;
Function  GetVideoCardCat:Byte;Export;Forward;
Function  GetVideoMem:Long;Export;Forward;
Function  GetVideoPg:Byte;Export;Forward;
Function  GetVideoMode:Wd;Export;Forward;
Function  GetVideoMonitor:Byte;Export;Forward;
Function  GetVideoScrSize:Long;Export;Forward;
Function  GetVideoSeg:Wd;Export;Forward;
Function  GetVideoSegBuf:Wd;Export;Forward;
Function  GetVideoSegROM:Wd;Export;Forward;
Function  GetVideoShowPg:Byte;Export;Forward;
Function  GetVideoSizeBnkPg:Wd;Export;Forward;
Function  GetVideoTxtAddrPg:Wd;Export;Forward;
Function  GetVideoTxtMtxPtr:Pointer;Export;Forward;
Function  HeightChr:Byte;Export;Forward;
Function  IsBlink:Bool;Export;Forward;
Function  IsEGA:Bool;Export;Forward;
Function  IsGrf:Bool;Export;Forward;
Function  IsKr:Bool;Export;Forward;
Function  IsMono:Bool;Export;Forward;
Function  IsVESA:Bool;Export;Forward;
Function  IsVGA:Bool;Export;Forward;
Function  IsVideoDirectAccess:Bool;Export;Forward;
Function  IsVideoModeBios:Bool;Export;Forward;
Function  IsVideoModeIBMLogic:Bool;Export;Forward;
Function  IsVideoSnow:Bool;Export;Forward;
Function  MaxXTxts:Byte;Export;Forward;
Function  MaxYTxts:Byte;Export;Forward;
Procedure MoveText(X1,Y1,X2,Y2,X3,Y3:Byte);Export;Forward;
Function  NmXPixels:Wd;Export;Forward;
Function  NmXTxts:Byte;Export;Forward;
Function  NmYPixels:Wd;Export;Forward;
Function  NmYTxts:Byte;Export;Forward;
Procedure PCopy(S,T:Byte);Export;Forward;
Procedure PCopy2Img(Page:Byte;X1,Y1,X2,Y2:Word);Export;Forward;
Procedure PutCharGAttr(X,Y:Byte;Chr:Char;Attr,GAttr:Byte);Export;Forward;
Procedure PutFillBox(X1,Y1,X2,Y2:Int;Kr:Wd);Export;Forward;
Procedure PutFillCircle(X,Y,Rayon:Int;Kr:Wd);Export;Forward;
Procedure PutFillRoundRect(x1,y1,x2,y2,b,Kr:Int);Export;Forward;
Procedure PutLn(X1,Y1,X2,Y2,Kr:Wd);Export;Forward;
Procedure PutLnHor(X1,Y,X2,Kr:Wd);Export;Forward;
Procedure PutRect(X1,Y1,X2,Y2,Kr:Int);Export;Forward;
Procedure PutRoundRect(X1,Y1,X2,Y2,LineWidth,B,Kr:Wd);Export;Forward;
Procedure PutSmlImg(X1,Y1,X2,Y2:Wd;Var Buffer);Export;Forward;
Procedure PutSprite(X1,Y1,X2,Y2:Wd;Var Buffer);Export;Forward;
Procedure PutTxtXY(X,Y:Byte;Str:String;Attr:Byte);Export;Forward;
Procedure PutTxtXYUnKr(X,Y:Byte;Str:String);Export;Forward;
Procedure ReadBnk(aY:Long;L:Wd;Var x0);Export;Forward;
Procedure SelBnkPg(Pg:Byte);Export;Forward;
Procedure SetAttr(X,Y,Attr:Byte);Export;Forward;
Procedure SetBackgroundColor(Kr:Byte);Export;Forward;
Procedure SetBlink(X:Bool);Export;Forward;
Procedure SetBnkPg(Pg:Byte);Export;Forward;
Procedure SetBorderColor(Kr:Byte);Export;Forward;
Procedure SetBytesPerLn(X:Wd);Export;Forward;
Procedure SetChr(X,Y:Byte;Chr:Char);Export;Forward;
Procedure SetChrWidth(L:Byte);Export;Forward;
Procedure SetCube(X,Y:Byte;Chr:Char;Attr:Byte);Export;Forward;
Procedure SetCur(A,B:Byte);Export;Forward;
Procedure SetCurPos(X,Y:Byte);Export;Forward;
Procedure SetDblMtx(X:Bool);Export;Forward;
Procedure SetExtChr(X,Y:Byte;Chr:Wd);Export;Forward;
Procedure SetExtCube(X,Y:Byte;Chr:Wd;Attr:Byte);Export;Forward;
Procedure SetGCube(X,Y:Wd;C:Chr;Attr:Byte);Export;Forward;
Procedure SetGCubeT(X,Y:Wd;C:Chr;Attr:Byte);Export;Forward;
Procedure SetHeightChr(H:Byte);Export;Forward;
Procedure SetHorizontalScale(X:Wd);Export;Forward;
Procedure SetMatrix(Palette,Height:Byte;Number,Start:Wd;Var X:TByte);Export;Forward;
Procedure SetModeMtx;Export;Forward;
Procedure SetModeScr;Export;Forward;
Procedure SetModeValue(Mode:Wd);Export;Forward;
Procedure SetPalBlk(Start,Nm:Wd);Export;Forward;
Procedure SetPaletteRGB(Start:Wd;R,G,B:Byte);Export;Forward;
Procedure SetPalRGB(Var P;Start,Num:Wd);Export;Forward;
Procedure SetPg(Pg:Byte);Export;Forward;
Procedure SetPIV(Var X:PIV);Export;Forward;
Procedure SetPixel(X,Y,Kr:Wd);Export;Forward;
Procedure SetTxtMtx(Mtx:Pointer);Export;Forward;
Procedure SetUnderline(X:Bool);Export;Forward;
Procedure SetVerticalScale(Y:Wd);Export;Forward;
Procedure SetVideoSeg(Seg:Word);Export;Forward;
Procedure SetVisualPg(Pg:Byte);Export;Forward;
Procedure SetWriteMode(Mode:Byte);Export;Forward;
Procedure SplitScreen(Y:Wd);Export;Forward;
Function  VGA320x400Found:Bool;Export;Forward;
Function  VideoFontFound:Bool;Export;Forward;
Function  VideoHerculeFound:Bool;Export;Forward;
Function  VideoMousePortFound:Bool;Export;Forward;
Function  VideoPaletteFound:Bool;Export;Forward;
Procedure WriteBnk(aY:Long;L:Wd;Var x0);Export;Forward;
Procedure Done;Export;Forward;
Function viInitVideo:Byte;Export;Forward;

{$I Library\HexWord.Inc}

Procedure Put(X:Chr);Begin
 ASM
  MOV AH,9
  MOV AL,X
  MOV BX,$1F
  MOV CX,1
  INT $10
 END;
 Inc(Mem[Seg0040:$50]);
End;

Procedure PutMsg(Msg:String);Var I:Byte;Begin
 For I:=1to Length(Msg)do Begin
  Put(Msg[I]);
 End;
End;

Procedure _GetVideoCard(CheckSvga:Bool;Var PVid,PVid2:PIV);Export;
Const BaseCard:Array[0..103]of Byte=({D‚tection automatique de la carte vid‚o}
  indexProcSetVidModeMDAPrim,       {vnUnknown: D‚tectection automatique}
  indexProcSetVidModeEGAPrim,       {vnAhead: Ahead}
  indexProcSetVidModeAheadBPrim,    {vnAheadB: Ahead B (SVGA)}
  indexProcSetVidModeAheadBPrim,    {vnAheadBWizard3270: Ahead B-Wizard/3270 (SVGA)}
  indSVMAheadEGA2001Prim,           {vnAheadEGA2001: Ahead EGA2001 (Super EGA)}
  indSVMAllStarPeacockPrim,         {vnAllstarPeacock: Allstar Peacock (VGA)}
  indSVMASTVGAPlusPrim,             {vnASTVGAPlus: AST VGA Plus (SVGA)}
  indexProcSetVidModeCGAPrim,       {vnATT: AT&T}
  indexProcSetVidModeATT6300Prim,   {vnATT6300: AT&T 6300 (Super EGA)}
  indexProcSetVidModeATTVDC600Prim, {vnATTVDC600: AT&T VDC600 (SVGA)}
  indexProcSetVidModeCardinalPrim,  {vnCardinal: Cardinal (SVGA)}
  indexProcSetVidModeCGAPrim,       {vnCGA: CGA}
  indexProcSetVidModeVGAPrim,       {vnCirrus: Cirrus (SVGA)}
  indexProcSetVidModeCGAPrim,       {vnCompaqPortable: Compaq Portable}
  indexProcSetVidModeVGAPrim,       {vnCompaqVGA: Compaq VGA (SVGA)}
  indexProcSetVidModeVGAPrim,       {vnCTI82C451: CTI 82C451 (SVGA)}
  indexProcSetVidModeVGAPrim,       {vnCTI82C452: CTI 82C452 (SVGA)}
  indexProcSetVidModeVGAPrim,       {vnDellVGA: Dell VGA (SVGA)}
  indexProcSetVidModeEGAPrim,       {vnEGA: EGA}
  indexProcSetVidModeEGAWonderPrim, {vnEGAW800: EGA Wonder 800+ (Super EGA)}
  indexProcSetVidModeEGAWonderPrim, {vnEGAW800N18800: EGA Wonder 800+-18800 (Super EGA)}
  indexProcSetVidModeEGAWonderPrim, {vnEGAW800N18800_1: EGA Wonder 800+-18800-1 (Super EGA)}
  indexProcSetVidModeEGAWonderPrim, {vnEGAW800N28800_2: EGA Wonder 800+-28800-2 (Super EGA)}
  indexProcSetVidModeEGAWonderPrim, {vnEGAW800N28800_4: EGA Wonder 800+-28800-4 (Super EGA)}
  indexProcSetVidModeEGAWonderPrim, {vnEGAW800N28800_5: EGA Wonder 800+-28800-5 (Super EGA)}
  indexProcSetVidModeEverexPrim,    {vnEverex: Everex}
  indexProcSetVidModeEverexPrim,    {vnEverexViewPoint: Everex ViewPoint}
  indexProcSetVidModeEverexPrim,    {vnEverexUG2: Everex UltraGraphics II}
  indexProcSetVidModeEverexPrim,    {vnEverexVision: Everex Vision}
  indexProcSetVidModeEverexPrim,    {vnEverexEVGA: Everex EVGA}
  indexProcSetVidModeGenoaPrim,     {vnGenoa: Genoa}
  indexProcSetVidModeGenoaPrim,     {vnGenoa5100: Genoa 5100}
  indexProcSetVidModeGenoaPrim,     {vnGenoa5300: Genoa 5300}
  indexProcSetVidModeGenoaPrim,     {vnGenoa6100: Genoa 6100}
  indexProcSetVidModeGenoaPrim,     {vnGenoa6200: Genoa 6200}
  indexProcSetVidModeGenoaPrim,     {vnGenoa6400: Genoa 6400 (SVGA)}
  indexProcSetVidModeGSPrim,        {vnGS: Graphics Solution d'ATI (Super CGA)}
  indexProcSetVidModeVGAWonderPrim, {vnGU: Graphics Ultra d'ATI (SVGA)}
  indexProcSetVidModeVGAWonderPrim, {vnGUPlus: Graphics Ultra d'ATI (SVGA)}
  indexProcSetVidModeVGAWonderPrim, {vnGUPro: Graphics Ultra d'ATI (SVGA)}
  indexProcSetVidModeVGAPrim,       {vnHeadLand: HeadLand (SVGA)}
  indexProcSetVidModeHerculePrim,   {vnHercule: Hercule (HGC)}
  indSVMHPD1180APrim,               {vnHPD1180A: Hewlett-Packard D1180A (SVGA)}
  indexProcSetVidModeHP95LXPrim,    {vnHP95LX: HP 95LX}
  indexProcSetVidModeVGAPrim,       {vnIBM8514A: IBM 8514/AI}
  indexProcSetVidModeVGAPrim,       {vnImtec: Imtec (SVGA)}
  indSVMTsengET4000Prim,            {vnITVGA2: IT-VGA2 (SVGA)}
  indSVMLavaChrome2EGAPrim,         {vnLavaChromeIIEGA: Lava Chrome II EGA (Super EGA)}
  indexProcSetVidModeVGAPrim,       {vnLogix: Logix (SVGA)}
  indexProcSetVidModeVGAPrim,       {vnMCGA: MCGA}
  indexProcSetVidModeMDAPrim,       {vnMDA: MDA}
  indexProcSetVidModeVGAPrim,       {vnMaxxon: Maxxon}
  indexProcSetVidModeMorseVGAPrim,  {vnMorseVGA: Morse VGA (VGA)}
  indexProcSetVidModeEGAPrim,       {vnNSISmartEGA: NSI Smart EGA+ (Super EGA)}
  indexProcSetVidModeOakPrim,       {vnOak: Oak Technologies (SVGA)}
  indexProcSetVidModeOrchidPrim,    {vnOrchid: Orchid}
  indexProcSetVidModeOrchidProPrim, {vnOrchidProDesVGA: Orchid Prodesigner VGA (SVGA)}
  indexProcSetVidModeOrchidProPrim, {vnOrchidProDesIIVGA: Orichid Prodesigner II VGA (SVGA/32768 couleurs)}
  indexProcSetVidModeParadisePrim,  {vnParadise: Paradise}
  indSVMParadiseEGA480Prim,         {vnParadiseEGA480: Paradise EGA-480, Super EGA}
  indexProcSetVidModeParadisePrim,  {vnParadisePVGA1A: Paradise PVGA1A}
  indexProcSetVidModeParadisePrim,  {vnParadiseWD90C00: Paradise WD90C00}
  indexProcSetVidModeParadisePrim,  {vnParadiseWD90C10: Paradise WD90C10}
  indexProcSetVidModeParadisePrim,  {vnParadiseWD90C11: Paradise WD90C11}
  indexProcSetVidModeMDAPrim,       {vnPC3270: PC 3270}
  indexProcSetVidModeMDAPrim,       {vnPC3270G: PC 3270G}
  indexProcSetVidModeMDAPrim,       {vnPC3270GX: PC 3270GX}
  indexProcSetVidModeCGAPrim,       {vnPCJr: PC Junior}
  indexProcSetVidModeVGAPrim,       {vnPGA: PGA}
  indexProcSetVidModeVGAWonderPrim, {vnPrismElite: Prism Elite d'ATI (SVGA)}
  indexProcSetVidModeVGAPrim,       {vnQU: Quadram Ultra VGA (SVGA)}
  indexProcSetVidModeVGAPrim,       {vnSEFCOTVGA: SEFCO TVGA (SVGA)}
  indexProcSetVidModeSigmaPrim,     {vnSigma: Sigma (SVGA)}
  indexProcSetVidModeSTBPrim,       {vnSTB: STB (SVGA)}
  indexProcSetVidModeSTBPrim,       {vnSTBVGAEM16Plus: STB VGA/EM-16 Plus (SVGA)}
  indexProcSetVidModeTatungVGAPrim, {vnTatungVGA: Tatung VGA (SVGA)}
  indSVMTaxan565EGAPrim,            {vnTaxan565EGA: Taxan 565 EGA (Super EGA)}
  indSVMTecmarVGAADPrim,            {vnTecmarVGAAD: Tecmar VGA/AD (SVGA)}
  indexProcSetVidModeVGAPrim,       {vnTIGA: TIGA de Texas Instrument}
  indexProcSetVidModeTridentPrim,   {vnTrident8800BR: Trident 8800BR (SVGA)}
  indexProcSetVidModeTridentPrim,   {vnTrident8800CS: Trident 8800CS (SVGA)}
  indexProcSetVidModeTridentPrim,   {vnTrident8900: Trident 8900 (SVGA)}
  indSVMTsengET4000Prim,            {vnT3000: Tseng ET3000 (SVGA)}
  indSVMTsengET4000Prim,            {vnT4000: Tseng ET4000 (SVGA)}
  indSVMTsengET4000HiKrPrim,        {vnT4000HiColor: Tseng ET4000 HiColor (SVGA)}
  indSVMTsengET4000HiKrPrim,        {vnT4000HiColorSC: Tseng ET4000 HiColor SC (SVGA)}
  indSVMUltraVisionEGAPrim,         {vnUltraVisionEGA: Ultra Vision EGA (Super EGA)}
  indexProcSetVidModeVESAPrim,      {vnVESA: VESA}
  indexProcSetVidModeVGAPrim,       {vnVGA: VGA}
  indexProcSetVidModeVGAWonderPrim, {vnVGAW: VGA Wonder d'ATI (SVGA)}
  indexProcSetVidModeVGAWonderPrim, {vnVGAW18800: VGA Wonder d'ATI 18800 (SVGA)}
  indexProcSetVidModeVGAWonderPrim, {vnVGAW18800_1: VGA Wonder d'ATI 18800-1 (SVGA)}
  indexProcSetVidModeVGAWonderPrim, {vnVGAW28800_2: VGA Wonder d'ATI 28800-2 (SVGA)}
  indexProcSetVidModeVGAWonderPrim, {vnVGAW28800_4: VGA Wonder d'ATI 28800-4 (SVGA)}
  indexProcSetVidModeVGAWonderPrim, {vnVGAW28800_5: VGA Wonder d'ATI 28800-5 (SVGA)}
  indexProcSetVidModeVideo7Prim,    {vnV7: Video 7 (SVGA)}
  indexProcSetVidModeVideo7Prim,    {vnV7Vram: Video 7 Vram (SVGA)}
  indexProcSetVidModeVideo7Prim,    {vnV7Vega: Video 7 Vega (SVGA)}
  indexProcSetVidModeVideo7Prim,    {vnV7Ver5: Video 7 Version 5 (SVGA)}
  indexProcSetVidModeVideo7Prim,    {vnV71024i: Video 7 1024i (SVGA)}
  indexProcSetVidModeVGAWonderPrim, {vnVIP: ATI VIP (SVGA)}
  indexProcSetVidModeXGA,           {vnXGA: XGA (SVGA)}
  indexProcSetVidModeVGAPrim,       {vnZymos: Zymos (SVGA)}
  indexProcSetVidModeVGAPrim        {vnZymosPoach: Zymos Poach (SVGA)}
 );
 FirstTime:Bool=Ya;
Var CodeStandardPS,D,CardId,CurrPort,SegPVid,OfsPVid:Wd;A:Byte;Begin
 If Not(FirstTime)Then Exit;
 ASM
  MOV AX,1A00h
  INT 10h
  MOV CodeStandardPS,BX
 END;
 Case Lo(CodeStandardPS)of
  7,8:Begin
   If Lo(CodeStandardPS)=7Then PVid.Monitor:=mnAnalogMono Else PVid.Monitor:=mnAnalogKr;
   PVid.Card:=vnVGA;PVid.CardCat:=cvnVGA;PVid.Memory:=256*$10000;
   PVid.Seg16C:=SegA000;PVid.ROM:=$C000;PVid.BBlink:=Ya;PVid.Font:=Ya;
   PVid.Color:=Ya;PVid.Palette:=Ya;PVid.DacBits:=6;PVid.EGA:=Ya;PVid.VGA:=Ya;
   PVid.VGA320x400:=Ya;PVid.ProcSelBnkPg:=indexProcSelBnkPgVGA;
   If(CheckSVGA)Then Begin
    CurrPort:=VideoPort;SegPVid:=Seg(PVid);OfsPVid:=Ofs(PVid);
    ASM
     {????????????????????????????????????????????????????????????????????????
      ??                                X G A                               ??
      ????????????????????????????????????????????????????????????????????????}
     MOV ES,SegPVid
     MOV DI,OfsPVid
@@CheckXGA:
     MOV AX,0C400h
     MOV DX,-1
     PUSH ES
      PUSH DI
       INT 15h
      POP DI
     POP ES
     JC @@_EndXGA
     CMP DX,-1
     JE @@_EndXGA
     JMP @Next2
@@_EndXGA:
     JMP @@EndXGA
@Next2:
     XOR BX,BX
     MOV DX,Word Ptr D
@@RepeatXGA:
     CLI
     CMP BL,0
     JNE @@WNext
     MOV AL,0DFh
     OUT 94h,AL
     JMP @@WEnd
@@WNext:
     MOV AX,0C401h
     PUSH ES
      PUSH DI
       PUSH BX
        INT 15h
       POP BX
      POP DI
     POP ES
     MOV DX,Word Ptr D
     IN  AX,DX
     MOV CardID,AX
     INC DX
     INC DX
     IN  AL,DX
     INC DX
     IN  AL,DX
     INC DX
     IN  AL,DX
     INC DX
     IN  AL,DX
@@WEnd:
     CMP BL,0
     JNE @@XNext
     MOV AL,0FFh
     OUT 94h,AL
     JMP @@XEnd
@@XNext:
     MOV AX,0C402h
     PUSH ES
      PUSH DI
       PUSH BX
        INT 15h
       POP BX
      POP DI
     POP ES
@@XEnd:
     STI
     MOV AX,CardID
     CMP AX,8FD8h
     JB  @@IncSlot
     CMP AX,8FDBh
     JA  @@IncSlot
     AND DL,0Eh
     {$IFOPT G+}
      SHL DL,3
     {$ELSE}
      SHL DL,1
      SHL DL,1
      SHL DL,1
     {$ENDIF}
     MOV DH,21h
     MOV Word Ptr D,DX
     ADD DX,0Ah
     MOV AL,52h
     OUT DX,AL
     INC DX
     IN  AL,DX
     AND AL,0Fh
     JZ  @@IncSlot
     CMP AL,0Fh
     JNE @@XGAFound
@@IncSlot:
     INC BX
     CMP BL,9
     JA  @@EndXGA
     JMP @@RepeatXGA
@@XGAFound:
     TEST DX,1
     JZ @@EndXGA
     MOV BL,vnXGA
     MOV ES:[DI].PIV.CardCat,cvnSvga
     MOV Byte Ptr ES:[DI].PIV.Memory[2],16
     JMP @@SetCardNExit
@@EndXGA:
     {?????????????????????????????????????????????????????????????????????????
      ??                            V i d e o  7                             ??
      ?????????????????????????????????????????????????????????????????????????}
     MOV DX,CurrPort
     MOV AL,0Ch
     OUT DX,AL { 3?4h }
     INC DX
     IN  AL,DX { 3?5h }
     MOV CL,AL
     MOV AL,55h
     OUT DX,AL { 3?5h }
     IN  AL,DX { 3?5h }
     DEC DX
     MOV AL,1Fh
     OUT DX,AL { 3?4h }
     INC DX
     IN  AL,DX { 3?5h }
     MOV CH,AL
     DEC DX
     MOV AL,0Ch
     OUT DX,AL { 3?4h }
     INC DX
     MOV AL,CL
     OUT DX,AL { 3?5h }
     CMP CH,(55h xor 0EAh)
     JNE @@CheckAhead
     MOV BL,vnV7
     MOV DL,0C4h
     MOV AL,8Eh
     OUT DX,AL { 3C4h }
     INC DX
     IN  AL,DX { 3C5h }
     TEST AL,80h
     JNZ @@V7Vega
     TEST AL,20h
     JNZ @@V7Vram
     TEST AL,10h
     JNZ @@V7Ver5
     TEST AL,40h
     JZ  @@NormalV7
     MOV BL,vnV71024i
     JMP @@NormalV7
@@V7Ver5:
     MOV BL,vnV7Ver5
     JMP @@NormalV7
@@V7Vram:
     MOV AX,6F07h
     PUSH ES
      PUSH DI
       INT 10h
      POP DI
     POP ES
     TEST AH,80h
     JZ  @@NormalV7
     MOV BL,vnV7Vram
     JMP @@NormalV7
@@V7Vega:
     MOV BL,vnV7Vega
@@NormalV7:
     MOV ES:[DI].PIV.Card,BL
     MOV DX,3C4h
     MOV AL,8Eh
     OUT DX,AX
     INC DX
     IN  AL,DX
     DEC DX
     MOV AL,0FFh
     OUT DX,AL
     INC DX
     IN  AL,DX
     MOV AX,6F07h
     PUSH ES
      PUSH DI
       INT 10h
      POP DI
     POP ES
     CMP AL,6Fh
     JE  @@SetMemV7
     {$IFOPT G+}
      SHL AH,2
     {$ELSE}
      SHL AH,1
      SHL AH,1
     {$ENDIF}
     MOV Byte Ptr ES:[DI].PIV.Memory[2],AH
@@SetMemV7:
     MOV SI,indexProcSelBnkPgVideo7
     JMP @@SetBnkPgOnly
@@CheckAhead:
     {?????????????????????????????????????????????????????????????????????????
     {??                        T s e n g  L a b s                           ??
     {?????????????????????????????????????????????????????????????????????????}
@@CheckTseng:
     MOV DX,3CDh
     IN  AL,DX { 3CDh }
     MOV AH,AL
     AND AL,0C0h
     OR  AL,55h
     OUT DX,AL { 3CDh }
     IN  AL,DX { 3CDh }
     CMP AL,55h
     JNE @@CheckCirrus
     MOV AL,0AAh
     OUT DX,AL { 3CDh }
     IN  AL,DX { 3CDh }
     CMP AL,0AAh
     JNE @@CheckCirrus
      { C'est une carte Tseng Labs }
     MOV AL,AH
     OUT DX,AL { 3CDh }
     MOV ES:[DI].PIV.Card,vnT3000 { Tseng ET3000 }
     MOV DX,CurrPort
     MOV AL,33h
     OUT DX,AL { 3?4h }
     INC DX
     IN  AL,DX { 3?5h }
     PUSH AX
      XOR AL,0Fh
      MOV BH,AL
      OUT DX,AL { 3?5h }
      IN  AL,DX { 3?5h }
      MOV BL,AL
     POP AX
     OUT DX,AL
     MOV SI,indexProcSelBnkPgTsengET3000
     CMP BL,BH
     JNE @@SkipTsengET4000
     MOV ES:[DI].PIV.Card,vnT4000 { Tseng ET4000 }
     XOR AX,AX
     MOV DX,3D4h
     CMP Byte Ptr CodeStandardPS[1],AL
     JE  @@1CardTseng
     CMP CurrPort,DX
     JE  @@Color
     MOV DL,0BFh
     MOV AL,3
     JMP @@SetOutTseng
@@Color:
     MOV DL,0D8h
     MOV AL,0A0h
     JMP @@SetOutTseng
@@1CardTseng:
     MOV DL,0BFh
     MOV AL,3
     OUT DX,AL { 3BFh }
     MOV DL,0D8h { 3D8h }
     MOV AL,0A0h
@@SetOutTseng:
     OUT DX,AL
@@End1CardTseng:
     MOV AX,10F1h
     MOV BL,0
     PUSH ES
      PUSH DI
       INT 10h
      POP DI
     POP ES
     CMP AL,10h
     JE  @@FuncNotSupport
     CMP BL,0
     JE  @@FuncNotSupport
     CMP BL,0FFh
     MOV BH,vnT4000HiColorSC
     CMP BL,1
     JE  @@SetHiColor
     MOV BH,vnT4000HiColor
@@SetHiColor:
     MOV ES:[DI].PIV.Card,BH
@@FuncNotSupport:
     XOR AX,AX
     CMP CurrPort,3B4h
     JNE @@SkipMDA
     MOV DX,3BFh
     MOV AL,1
     OUT DX,AL
@@SkipMDA:
     MOV DX,CurrPort
     MOV AL,37h
     OUT DX,AL { 3?4h }
     INC DX;
     IN  AL,DX { 3?5h }
     MOV A,AL
     TEST AL,8
     JZ  @@NoMem
     AND AL,3
     CMP AL,2
     JB  @@NoMem
     TEST AL,2
     JZ @@Tseng512K
     MOV AL,16
     JMP @@TsengSetMem
@@Tseng512K:
     MOV AL,8
@@TsengSetMem:
     MOV Byte Ptr ES:[DI].PIV.Memory[2],AL
     MOV ES:[DI].PIV.CardCat,cvnSvga
@@NoMem:
      { RomBits }
     MOV BL,8
     TEST A,10h
     JZ  @@Rom8Bits
     MOV BL,16
@@Rom8Bits:
     MOV ES:[DI].PIV.RomBits,BL
      { Reset Port }
     DEC DX
     MOV AL,36h
     OUT DX,AL { 3?4h }
      { VideoBits }
     MOV BL,8
     INC DX { 3?5h }
     IN  AL,DX
     TEST AL,40h
     JZ  @@Video8Bits
     MOV BL,16
@@Video8Bits:
     MOV ES:[DI].PIV.VideoBits,BL
      { Reset Port }
     MOV DL,0C4h { 3C4h }
     MOV AL,7
     OUT DX,AL
     INC DX
     IN  AL,DX { 3C5h }
     MOV SI,indexProcSelBnkPgTsengET4000
@@SkipTsengET4000:
     JMP @@SetBnkPgOnly
     {?????????????????????????????????????????????????????????????????????????
      ??                             C i r r u s                             ??
      ?????????????????????????????????????????????????????????????????????????}
@@CheckCirrus:
     MOV DX,CurrPort
     MOV AL,0Ch
     OUT DX,AL { 3?4h }
     INC DX
     MOV AH,AL
     IN  AL,DX { 3?5h }
     XCHG AH,AL
     PUSH AX
      PUSH DX
       XOR AL,AL
       OUT DX,AL { 3?5h }
       DEC DX
       MOV AL,1Fh
       OUT DX,AL { 3?4h }
       INC DX
       IN  AL,DX { 3?5h }
       MOV AH,AL
       MOV BH,AL
       MOV CH,CL
       MOV CL,4
       MOV DL,0C4h
       MOV BL,6
       ROR BH,CL
       MOV AX,BX
       OUT DX,AL { 3C4h }
       INC DX
       IN  AL,DX { 3C5h }
       OR  AL,AL
       JNZ @@ExitCirrus
       MOV BH,AL
       DEC DX
       MOV AL,6
       OUT DX,AL { 3C4h }
       INC DX
       MOV AL,AH
       IN  AL,DX { 3C5h }
       CMP AL,1
       JNE @@ExitCirrus
       ROR BH,CL
       DEC DX
       MOV AX,BX
       OUT DX,AX { 3C4h }
       INC DX
       IN  AL,DX { 3C5h }
       CMP AL,1
       JNE @@ExitCirrus
      POP DX
      DEC DX
     POP AX
     OUT DX,AX { 3?4h }
     MOV CL,0
     JCXZ @@CheckCTI
     MOV AH,12h
     MOV BL,85h
     PUSH ES
      PUSH DI
       INT 10h
      POP DI
     POP ES
     MOV Byte Ptr ES:[DI].PIV.Memory[2],AL
     MOV SI,indexProcSelBnkPgCirrus
     MOV BH,vnCirrus
     JMP @@SetCardNBnkPg
@@ExitCirrus:
      POP DX
      DEC DX
     POP AX
     OUT DX,AX { 3?4h }
     {?????????????????????????????????????????????????????????????????????????
      ??                                C T I                                ??
      ?????????????????????????????????????????????????????????????????????????}
@@CheckCTI:
     MOV DX,46E8h
     PUSH DX
      IN  AL,DX { 46E8h }
      OR  AL,10h
      OUT DX,AL { 46E8h }
      MOV DX,103h
      IN  AL,DX { 103h }
      OR  AL,80h
      OUT DX,AL { 103h }
      INC DX
      IN  AL,DX { 104h }
      MOV AH,AL
     POP DX
     IN  AL,DX { 46E8h }
     AND AL,3Fh
     OUT DX,AL { 46E8h }
     MOV DX,3D6h
     MOV AL,0
     OUT DX,AL { 3D6h }
     INC DX
     IN  AL,DX { 3D7h }
     CMP AH,5Ah
     JNE @@CheckTrident
     AND AL,0F0h
     {$IFOPT G+}
      SHR AL,4
     {$ELSE}
      SHR AL,1
      SHR AL,1
      SHR AL,1
      SHR AL,1
     {$ENDIF}
     CMP AL,2
     JE  @@CheckTrident
     CMP AL,4
     JGE @@CheckTrident
     CMP AL,3
     JE  @@CheckTrident
     MOV AX,5F00h
     PUSH ES
      PUSH DI
       INT 10h
      POP DI
     POP ES
     INC BH
     {$IFOPT G+}
      SHL BH,2
     {$ELSE}
      SHL BH,1
      SHL BH,1
     {$ENDIF}
     MOV Byte Ptr ES:[DI].PIV.Memory[2],BH
     AND CL,1
     SHL CL,1
     MOV ES:[DI].PIV.DacBits,CL
     MOV DX,46E8h
     MOV AL,1Eh
     OUT DX,AL { 46E8h }
     PUSH DX
      PUSH DX
       MOV DX,103h
       MOV AL,80h
       OUT DX,AL { 103h }
      POP DX
      MOV AL,0Eh
      OUT DX,AL { 46E8h }
      MOV DX,3D6h
      MOV AL,0
      OUT DX,AL { 3D6h }
      INC DX
      IN  AL,DX { 3D7h }
      AND AL,0F0h
      CMP AL,10h
      JNE @@SkipCTI82
      DEC DX
      MOV AL,3Ah
      OUT DX,AL { 3D6h }
      INC DX
      IN  AL,DX { 3D7h }
      PUSH AX
       MOV AL,0AAh
       OUT DX,AL { 3D7h }
       IN  AL,DX { 3D7h }
       MOV BH,vnCTI82C452
       CMP AL,0AAh
       JE  @@IsCTI82C452
       MOV BH,vnCTI82C451
@@IsCTI82C452:
      POP AX
      OUT DX,AL { 3D7h }
@@SkipCTI82:
     POP DX
     MOV AL,1Eh
     OUT DX,AL { 46E8h }
     PUSH DX
      MOV DX,103h
      MOV AL,80h
      OUT DX,AL { 103h }
     POP DX
     MOV AL,0Eh
     OUT DX,AL { 46E8h }
     MOV DX,3D6h
     MOV AL,0
     OUT DX,AL { 3D6h }
     MOV SI,indexProcSelBnkPgCTI
     JMP @@SetCardNBnkPg
     {?????????????????????????????????????????????????????????????????????????
      ??                             T r i d e n t                           ??
      ?????????????????????????????????????????????????????????????????????????}
@@CheckTrident:
     MOV DX,3C4h
     MOV AL,0Bh
     OUT DX,AL { 3C4h }
     INC DX
     IN  AL,DX { 3C5h }
     CMP AL,0
     JE  @@CheckEverex
     CMP AL,6
     JA  @@CheckEverex
     MOV BH,vnTrident8800BR
     CMP AL,1
     JE  @@SetTridentCard
     MOV BH,vnTrident8800CS
     CMP AL,2
     JE  @@SetTridentCard
     MOV AL,1Fh
     OUT DX,AL
     INC DX
     IN  AL,DX
     AND AL,3
     DEC DX
     CMP AL,0
     JE  @@SkipSetMemTrident
     MOV BL,8
     CMP AL,1
     JE  @@SetNowMemTrident
     MOV BL,16
@@SetNowMemTrident:
     MOV Byte Ptr ES:[DI].PIV.Memory[2],BL
@@SkipSetMemTrident:
     MOV BH,vnTrident8900
@@SetTridentCard:
     MOV AL,0Fh
     OUT DX,AL
     INC DX
     IN  AL,DX
     MOV BL,8
     TEST AL,80h
     JZ  @@TridentRom8Bits
     MOV BL,16
@@TridentRom8Bits:
     MOV ES:[DI].PIV.RomBits,BL
     MOV ES:[DI].PIV.CardCat,cvnSvga
     MOV SI,indexProcSelBnkPgTrident
     JMP @@SetCardNBnkPg
     {?????????????????????????????????????????????????????????????????????????
      ??                              E v e r e x                            ??
      ?????????????????????????????????????????????????????????????????????????}
@MonitorEverex:
     DB mnMDA              { 0 }
     DB mnCGA              { 1 }
     DB mnEGA              { 2 }
     DB mnDigitalMultiSync { 3 }
     DB mnVGA              { 4 }
     DB mn8514             { 5 }
     DB mnSuperVGA         { 6 }
     DB mnAnalogMultiSync  { 7 }
     DB mnSuperMultiSync   { 8 }
     DB mnAnalogMultiSync  { 9  ~ Code sp‚culatif … partir de ce niveau... }
     DB mnAnalogMultiSync  { 10 }
     DB mnAnalogMultiSync  { 11 }
     DB mnAnalogMultiSync  { 12 }
     DB mnAnalogMultiSync  { 13 }
     DB mnAnalogMultiSync  { 14 }
     DB mnAnalogMultiSync  { 15 }
@@CheckEverex:
     MOV AX,7000h
     XOR BX,BX
     PUSH ES
      PUSH DI
       INT 10h
      POP DI
     POP ES
     CMP AL,70h
     JNE @@CheckZyMos
     MOV BX,CX
     ADD BX,000Fh
     MOV BL,Byte Ptr CS:[Offset @MonitorEverex+BX]
     MOV ES:[DI].PIV.Monitor,BL
     AND DX,0FFF0h
     MOV BH,vnEverex
     CMP DX,6780h
     JE  @@EverexViewPoint
     CMP DX,6730h
     JE  @@EverexEVGA
     CMP DX,6200h
     JE  @@EverexVision
     CMP DX,2460h
     JNE @@EverexSimple
     MOV BH,vnEverexUG2 { Everex Ultra Graphics II }
     JMP @@EverexSimple
@@EverexViewPoint:
     MOV BH,vnEverexViewPoint
     JMP @@EverexSimple
@@EverexVision:
     MOV BH,vnEverexVision
     JMP @@EverexSimple
@@EverexEVGA:
     MOV BH,vnEverexEVGA
@@EverexSimple:
     ROL CH,1
     ROL CH,1
     AND CH,3
     INC CH
     {$IFOPT G+}
      SHL CH,2
     {$ELSE}
      SHL CH,1
      SHL CH,1
     {$ENDIF}
     MOV Byte Ptr ES:[DI].PIV.Memory[2],CH
     MOV ES:[DI].PIV.CardCat,cvnSvga
     MOV SI,indexProcSelBnkPgEverex
     JMP @@SetCardNBnkPg
     {?????????????????????????????????????????????????????????????????????????
      ??                              Z y M o s                              ??
      ?????????????????????????????????????????????????????????????????????????}
@@CheckZyMos:
     MOV DX,3D4h
     MOV AL,0Bh
     OUT DX,AL { 3D4h }
     INC DX
     IN  AL,DX { 3D5h }
     AND AL,0Fh
     CMP AL,2
     JNE @@OakCheck
     MOV BH,vnZyMos
     MOV SI,indexProcSelBnkPgZyMos
     JMP @@SetCardNBnkPg
     {?????????????????????????????????????????????????????????????????????????
      ??                                 O a k                               ??
      ?????????????????????????????????????????????????????????????????????????}
@@OakCheck:
     MOV DL,0DEh
     MOV AX,0FF11h
     MOV BX,AX
     OUT DX,AL { 3DEh }
     MOV AH,AL
     INC DX
     IN  AL,DX { 3DFh }
     DEC DX
     XCHG AL,AH
     PUSH AX
      MOV AX,BX
      OUT DX,AX { 3DEh }
      OUT DX,AL { 3DEh }
      MOV AH,AL
      INC DX
      IN  AL,DX { 3DFh }
      DEC DX
      AND AL,BH
      CMP AL,BH
      JNE @@NotOak
      MOV AL,AH
      MOV AH,0
      OUT DX,AX { 3DEh }
      OUT DX,AL { 3DEh }
      MOV AH,AL
      INC DX
      IN  AL,DX { 3DFh }
      DEC DX
      AND AL,BH
      CMP AL,0
     POP AX
     JNE @@NotOak
     OUT DX,AX { 3DEh }
     MOV DX,3DEh
     MOV AL,0Dh
     OUT DX,AL { 3DEh }
     JMP @@NextInstr
@@NextInstr:
     INC DX
     IN  AL,DX { 3DFh }
     TEST AL,80h
     JZ  @@NoOakMem
     MOV Byte Ptr ES:[DI].PIV.Memory[2],8
@@NoOakMem:
     MOV SI,indexProcSelBnkPgOak
     MOV BH,vnOak
     JMP @@SetCardNBnkPg
@@NotOak:
     OUT DX,AX { 3DEh }
@@SetCardNBnkPg:
     MOV ES:[DI].PIV.Card,BH
@@SetBnkPgOnly:
     MOV ES:[DI].PIV.ProcSelBnkPg,SI
@@Vesa:
     {?????????????????????????????????????????????????????????????????????????
      ??                        D ‚ t e c t i o n  V e s a                   ??
      ?????????????????????????????????????????????????????????????????????????}
     MOV AX,4F00h
     PUSH ES
      PUSH DI
       PUSH DS
       POP ES
       MOV DI,Offset VesaHeader
       MOV SI,DI
       INT 10h
      POP DI
     POP ES
     CMP AX,004Fh
     JNE @@End
     CMP Word Ptr DS:[SI].VesaHeaderInfo.Sign[0],('V')+('E' shl 8)
     JNE @@End
     CMP Word Ptr DS:[SI].VesaHeaderInfo.Sign[2],('S')+('A' shl 8)
     JNE @@End
     MOV ES:[DI].PIV.Vesa,Ya
     CMP ES:[DI].PIV.ProcSelBnkPg,indexProcSelBnkPgVGA
     JNE @@SkipSelBnkPg
     MOV AX,CS:[SI].VesaHeaderInfo.NmBnk64K
     MOV Word Ptr ES:[DI].PIV.Memory[2],AX
     MOV ES:[DI].PIV.ProcSelBnkPg,indexProcSelBnkPgVesa
     MOV ES:[DI].PIV.CardCat,cvnVesa
@@SkipSelBnkPg:
     CMP ES:[DI].PIV.Card,vnVGA
     JNE @@SkipVesaCard
     MOV BL,vnVesa
@@SetCardNExit:
     MOV ES:[DI].PIV.Card,BL
@@SkipVesaCard:
@@End:
    END;
   End;
  End;
  Else Begin
   PutMsg('Code de carte vid‚o = ');
   PutMsg(HexWord2Str(CodeStandardPS));
   Put('h');
   PutMsg('Carte vid‚o inconnue');
   Halt;
  End;
 End;
 PVid.ProcSetVideoMode:=BaseCard[PVid.Card];FirstTime:=No;
End;

{$F+}
{$I RLL\Video\DrvTxt.Inc}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Proc‚dure Bar                           Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'afficher une boŒte pleine en mode graphique.
}

Procedure Bar;Begin;End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Proc‚dure Bar                            Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure affiche une bar horizontal avec le caractŠre sp‚cifi‚.
}

Procedure BarChrHor;Begin
 BarChrHorTxt(X1,Y,X2,Chr);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure BarChrVer                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure affiche une bar vertical avec le caractŠre sp‚cifi‚.
}

Procedure BarChrVer;Begin
 BarChrVerTxt(X,Y1,Y2,Chr);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Proc‚dure BarSpcHor                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure affiche une bar horizontal avec que des espaces.
}

Procedure BarSpcHor;Begin
 BarSpcHorTxt(X1,Y,X2,Attr)
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Proc‚dure BarSpcVer                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure affiche une bar vertical avec que des espaces.
}

Procedure BarSpcVer;Begin
 BarSpcVerTxt(X,Y1,Y2,Attr)
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure BarTxtHor                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure affiche une banderole horizontal avec un caractŠre
 particulier.
}

Procedure BarTxtHor;Begin
 BarTxtHorTxt(X1,Y,X2,Chr,Attr);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                      Fonction BiosBlinkFound                  Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction indique si le Bios supporte le mode clignotement/
 intensit‚?
}

Function BiosBlinkFound;Begin
 BiosBlinkFound:=DataVideo.Blink
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Fonction BitsPerPixel                    Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction indique le nombre de Bit(s) utilis‚ pour l'affichage
 d'un pixel
}

Function BitsPerPixel;Begin
 BitsPerPixel:=DataVideo.BitsPerPixel
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Fonction BitsPerLn                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction retourne le nombre d'octet par ligne affich‚ (trŠs
 relatif en VGA...).
}

Function BytesPerLn;Begin
 BytesPerLn:=DataVideo.BytesPerLn
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Proc‚dure Circle                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure affiche un cercle … l'‚cran.
}

Procedure Circle;Begin
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Proc‚dure CloseCur                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure efface ou fait disparaŒtre le curseur.
}

Procedure CloseCur;Begin
 CloseCurTxt;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Proc‚dure ClrLnHor                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure trace une ligne graphique de tel longueur.
}

Procedure ClrLnHor;Begin;End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Proc‚dure ClrLnHor                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure affiche une ligne image graphique de tel longueur.
}

Procedure ClrLnHorImg;Begin;End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Proc‚dure ClrScr                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure efface l'‚cran avec l'attribut de la variable
 param‚trage ®Attr¯.
}

Procedure ClrScr;Begin
 ClrScrTxt(Attr)
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Proc‚dure ClrWn                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure efface une boŒte de caractŠres … l'‚cran.
}

Procedure ClrWn;Begin
 ClrWnTxt(X1,Y1,X2,Y2,Attr)
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Fonction ColorFound                 Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction indique si la carte de type couleur? autrement
 c'est une monochrome.
}

Function ColorFound;Begin
 ColorFound:=DataVideo.Colr
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                      Proc‚dure CopT8Bin                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure affiche une bar de 8 bits cons‚cutif et affecte
 le font s'ils sont … 1.
}

Procedure CopT8Bin;Begin;End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                    Proc‚dure Copy8Bin                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure affiche une bar de 8 bits cons‚cutif pour un
 motif...
}

Procedure Copy8Bin;Begin;End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                      Proc‚dure FillBnk                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure efface une zone de la banque de m‚moire vid‚o.
}

Procedure FillBnk;Begin
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure FillBox                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure efface une boŒte avec les caractŠres et attributs
 sp‚cifi‚.
}

Procedure FillBox;Begin
 FillBoxTxt(X1,Y1,X2,Y2,Chr,Attr)
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Fonction FondFound                    Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction indique si les polices programmable sont support‚
 par cette carte.
}

Function FontFound;Begin
 FontFound:=PhysVideo.Font
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                     Proc‚dure GetLnHorImg                   Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure sauvegarde l'image vid‚o de la ligne sp‚cifi‚.
}

Procedure GetLnHorImg;Begin;End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Fonction GetMaxKr                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction demande le num‚ro maximum de couleur.
}


Function GetMaxKr;Begin
 GetMaxKr:=Pred(DataVideo.NmColrs)
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Proc‚dure GetMaxKr                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure charge tous les informations de mode con‡ernant
 la carte vid‚o actuel.
}

Procedure GetMIV;Begin
 Move(DataVideo,X,SizeOf(X));
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Fonction GetNmKr                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction retourne le nombre de couleurs affich‚.
}

Function GetNmKr;Begin
 GetNmKr:=DataVideo.NmColrs
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                   Fonction GetNmVideoPages                Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction retourne le nombre de page vid‚o que supporte
 le mode actuel.
}

Function GetNmVideoPages;Begin
 GetNmVideoPages:=DataVideo.NmVidPgs
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Proc‚dure GetPIV                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure charge tous les informations physique con‡ernant
 la carte vid‚o actuel.
}

Procedure GetPIV;Begin
 Move(PhysVideo,X,SizeOf(X))
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Proc‚dure GetPIVSec                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure charge tous les informations physique con‡ernant
 la carte vid‚o secondaire.
}

Procedure GetPIVSec;Begin
 Move(PVid2,X,SizeOf(X));
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Fonction GetPixel                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction inspir‚ de Borland demande la couleur du Pixel se
 trouvant aux coordonn‚es (X,Y).
}

Function GetPixel;Begin;End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                     Fonction GetRealRawY                   Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction retourne retourne l'‚quivalence physique d'une
 ligne d'‚cran.
}

Function GetRealRawY;Begin
 GetRealRawY:=RealRawY[Y]
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Fonction GetRealRawYWord                  Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction retourne retourne la partie basse d'une ‚quivalence
 physique d'une ligne d'‚cran.
}

Function GetRealRawYWord;Begin
 GetRealRawYWord:=Word(RealRawY[Y])
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                      Fonction GetSelPg                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cettte fonction demande le num‚ro de banque de la page courant.
}

Function GetSelPg;Begin
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                      Fonction GetSizeSmlImg                  Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

 Cette fonction demande la taille que demande l'image sp‚cifi‚.
}

Function GetSizeSmlImg;Begin;End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                     Proc‚dure GetSmlImg                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure sauvegarde dans un tampon l'image d‚finit dans
 (X1,Y1)-(X2,Y2).
}

Procedure GetSmlImg;Begin;End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                     Fonction GetVideoBitsDAC                Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction retourne le nombre de bits utilis‚ pour modifi‚
 un des 3 DAC RGB.
}

Function GetVideoBitsDAC;Begin
 GetVideoBitsDAC:=PhysVideo.DacBits
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                      Fonction GetVideoBitsIO                 Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction retourne le nombre d'accŠs bits au entr‚e/sortie
 vid‚o.
}

Function GetVideoBitsIO;Begin
 GetVideoBitsIO:=PhysVideo.VideoBits
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                    Fonction GetVideoBitsROM                Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction retourne le nombre d'accŠs bits … la ROM Bios.
}

Function GetVideoBitsROM;Begin
 GetVideoBitsROM:=PhysVideo.RomBits
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                    Fonction GetVideoCard                   Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction demande le nom de la carte vid‚o (vn????).
}

Function GetVideoCard;Begin
 GetVideoCard:=PhysVideo.Card
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                  Fonction GetVideoCardCat                Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction demande la cat‚gorie de la carte vid‚o (MDA,
 CGA,...)(cvn????).
}

Function GetVideoCardCat;Begin
 GetVideoCardCat:=PhysVideo.CardCat
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                      Fonction GetVideoPg                    Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction retourne le num‚ro de la page vid‚o de travail.
}

Function GetVideoPg;Begin
 GetVideoPg:=DataVideo.Pg
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                     Fonction GetVideoMem                  Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction retourne le nombre de m‚moire (en octet) dont
 dispose la carte vid‚o.
}

Function GetVideoMem;Begin
 GetVideoMem:=PhysVideo.Memory
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                     Fonction GetVideoMode                 Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction demande le mode vid‚o actuel (vm???).
}

Function GetVideoMode;Begin
 GetVideoMode:=DataVideo.Mode
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Fonction GetVideoMoniteur                    Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction demande le nom du moniteur (mn????) sous format num‚rique.
}

Function GetVideoMonitor;Begin
 GetVideoMonitor:=PhysVideo.Monitor
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Fonction GetVideoScrSize                    Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction demande la taille de l'‚cran en octets.
}

Function GetVideoScrSize;Begin
 GetVideoScrSize:=DataVideo.ScrSize
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Fonction GetVideoSeg                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction retourne le segment vid‚o (A000h,B000h,B800h,...).
}

Function GetVideoSeg;Var X:Wd;Begin
 Case(DataVideo.SegV)of
  $0040:X:=Seg0040;
  $A000:X:=SegA000;
  $B000:X:=SegB000;
  $B800:X:=SegB800;
  Else Begin
   {$IFDEF HaltNow}
    WriteLn('Segment Vid‚o = ',HexWord2Str(IVid.SegV),'h');
    WriteLn('Segment Vid‚o Invalide!');
    Halt;
   {$ELSE}
    If VideoPort=$3D4Then X:=SegB800 Else X:=SegB000;
   {$ENDIF}
  End;
 End;
 GetVideoSeg:=X;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Fonction GetVideoSegBuf                    Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction retourne, en mode graphique, le segment du tampon de
 l'acc‚lateur.
}

Function GetVideoSegBuf;Begin
 GetVideoSegBuf:=DataVideo.SegBuf
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                      Fonction GetVideoSegROM                    Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction demande l'adresse de segment en mode r‚el de la ROM
 Bios.
}

Function GetVideoSegROM;Begin
 GetVideoSegROM:=PhysVideo.ROM
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                     Fonction GetVideoShowPg                   Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette focnction retourne le num‚ro de la page vid‚o actuellement
 affich‚.
}

Function GetVideoShowPg;Begin
 GetVideoShowPg:=DataVideo.ShowPg
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                      Fonction GetVideoSizeBnkPg                 Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction retourne le taille d'un page de la banque (0=64Ko).
}

Function GetVideoSizeBnkPg;Begin
 GetVideoSizeBnkPg:=DataVideo.SizeBnk
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                      Fonction GetVideoTxtAddrPg                 Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction retourne, en mode texte, l'adresse en m‚moire vid‚o
 de la page actuel.
}

Function GetVideoTxtAddrPg;Begin
 GetVideoTxtAddrPg:=DataVideo.AddrPg
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                  Fonction GetVideoTxtAddrPg                 Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction retourne un pointeur sur la police de caractŠre
 courante.
}

Function GetVideoTxtMtxPtr;Begin
 GetVideoTxtMtxPtr:=DataVideo.TxtMtx
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Fonction HeightChr                  Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction retourne la hauteur de la police de caractŠre
 actuel.
}

Function HeightChr;Begin
 HeightChr:=DataVideo.HeightChr;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Fonction IsBlink                    Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction si le clignotement est actuellement actif.
}

Function IsBlink;Begin
 IsBlink:=DataVideo.Blink
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Fonction IsEGA                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction indique si la carte EGA est sup‚rieur ou ‚gale
 est install‚.
}

Function IsEGA;Begin
 IsEGA:=PhysVideo.EGA
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Fonction IsGrf                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction indique s'il s'agit d'un mode graphique. Si la
 valeur retourn‚ est fausse alors il s'agit d'un mode texte.
}

Function IsGrf;Begin
 IsGrf:=DataVideo.Graf
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Fonction IsKr                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction indique s'il s'agit d'un mode couleur. Sinon c'est
 for‡‚ment un mode monochrome.
}

Function IsKr;Begin
 IsKr:=DataVideo.Colr
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Fonction IsMono                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction indique s'il s'agit d'un mode monochrome sinon
 for‡‚ment couleur.
}

Function IsMono;Begin
 IsMono:=Not(DataVideo.Colr)
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Fonction IsVESA                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction indique si le standard VESA est support‚ par la
 carte vid‚o.
}

Function IsVESA;Begin
 IsVESA:=PhysVideo.VESA
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                      Fonction IsVGA                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction indique si la carte vid‚o VGA ou sup‚rieur est
 install‚e.
}

Function IsVGA;Begin
 IsVGA:=PhysVideo.VGA
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                      Fonction IsVideoDirectAccess                    Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction indique si la m‚thode d'accŠs directe est support‚ sinon
 il utilise le Bios ou Dos.
}

Function IsVideoDirectAccess;Begin
 IsVideoDirectAccess:=DataVideo.Direct
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                      Fonction IsVideoModeBios                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction indique si le mode est support‚ par le Bios (Par exemple,
 la GS en 16 couleurs le Bios ne le connaŒt pas, le VGA 320x400 non plus).
}

Function IsVideoModeBios;Begin
 IsVideoModeBios:=DataVideo.BiosSupport
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                     Fonction IsVideoModeIBMLogic                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction indique si le mode est dans la logique IBM (pas hors cas
 texte … la SVGA...).
}

Function IsVideoModeIBMLogic;Begin
 IsVideoModeIBMLogic:=DataVideo.IbmLogic
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Fonction IsVideoSnow                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction indique si le mode vid‚o est un risque d'avoir de la
 neige lors de l'envoie de donn‚e dans le tampon vid‚o.
}

Function IsVideoSnow;Begin
 IsVideoSnow:=DataVideo.Snow
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Fonction MaxXTxts                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

 Cette fonction demande la coordonn‚e texte X maximal.
}

Function MaxXTxts;Begin
 MaxXTxts:=Pred(DataVideo.NmXTxts)
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Fonction MaxYTxts                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

 Cette fonction demande la coordonn‚e texte Y maximal.
}

Function MaxYTxts;Begin
 MaxYTxts:=Pred(DataVideo.NmYTxts)
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Proc‚dure MoveText                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de d‚place une fenˆtre texte vers la haut,
 le bas, la droite &/ou la gauche. (X1,Y1) repr‚sente la coordonn‚e
 du coin sup‚rieur gauche de la fenˆtre contenant le texte … copier.
 (X2,Y2) rep‚sente la coordonn‚e du coin inf‚rieur droit de ce mˆme
 de la fenˆtre.  (X3,Y3)  repr‚sente le coin sup‚rieur gauche de la
 fenˆtre destin‚ … recevoir le texte.
}

Procedure MoveText;Begin
 MoveTextTxt(X1,Y1,X2,Y2,X3,Y3)
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Fonction NmXPixels                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction retourne le nombre de pixels horizontal qu'affiche
 l'‚cran.
}

Function NmXPixels;Begin
 NmXPixels:=DataVideo.NmXPixels
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Fonction NmXTxts                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction retourne le nombre de caractŠre texte horizontal
 qu'affiche l'‚cran.
}

Function NmXTxts;Begin
 NmXTxts:=DataVideo.NmXTxts
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Fonction NmYPixels                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction retourne le nombre de pixels vertical qu'affiche
 l'‚cran.
}

Function NmYPixels;Begin
 NmYPixels:=DataVideo.NmYPixels
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Fonction NmXTxts                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction retourne le nombre de caractŠre texte vertical
 qu'affiche l'‚cran.
}

Function NmYTxts;Begin
 NmYTxts:=DataVideo.NmYTxts
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                      Proc‚dure PCopy                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure, inspir‚ du Basic, permet de copier une page
 vid‚o dans une autres.
}

Procedure PCopy;Begin
 PCopyTxt(S,T)
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                     Proc‚dure PCopy2Img                   Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure copie une page dans une image d'‚cran vid‚o.
}

Procedure PCopy2Img;Begin;End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Proc‚dure PutCharGAttr                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'afficher un caractŠre sous le format d'attribut
 typ‚ du traŒtement de texte ®GAT¯.
}

{Procedure PutCharGAttr;Begin
 PutCharGAttr(X,Y,Chr,Attr,GAttr);
End;}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Proc‚dure PutFillBox                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure affiche une boŒte de couleur sp‚cifi‚ de (X1,Y1)-
 (X2,Y2).
}

Procedure PutFillBox;Begin;End;
Procedure PutFillCircle;Begin;End;
Procedure PutFillRoundRect;Begin;End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure PutLn                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure affiche une ligne … l'‚cran.
}

Procedure PutLn;Begin;End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure PutLnHor                    Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction affiche une ligne horizontal … l'‚cran.
}

Procedure PutLnHor;Begin;End;

Procedure PutRect;Begin;End;
Procedure PutRoundRect;Begin;End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Proc‚dure PutSmlImg                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure affiche … l'‚cran l'image contenu dans un tampon.
}

Procedure PutSmlImg;Begin;End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Proc‚dure PutTxtXY                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure affiche un message … l'‚cran aux coordonn‚es texte
 (X,Y) avec l'attribut ®Attr¯.
}

Procedure PutSprite;Begin;End;

Procedure PutTxtXY;Begin
 PutTxtXYTxt(X,Y,Str,Attr)
End;

Procedure PutTxtXYUnKr;Begin{Affiche un message … (X,Y) sans affecter les couleurs}
 PutTxtXYUnKrTxt(X,Y,Str);
End;

Procedure ReadBnk;Begin;End;{Lit des donn‚es dans la banque vid‚o Super VGA}
Procedure SelBnkPg;Begin;End;{Fixe le plane de la banque vid‚o Super VGA}

Procedure SetAttr;Begin{Fixe un attribut … (X,Y)}
 SetAttrTxt(X,Y,Attr)
End;

Procedure SetBackgroundColor;Begin
 SetBackgroundColorTxt(Kr)
End;

{Fixe l'affichage … Clignotement ou Intensit‚}
Procedure SetBlink;Begin
 If CurrDrv in[drvBios,drvTxt]Then SetBlinkTxt(X);
End;

Procedure SetBnkPg;Begin;End;{Fixe le plane de la banque vid‚o Super VGA}

Procedure SetBorderColor;Begin
 SetBorderColorTxt(Kr)
End;

Procedure SetBytesPerLn;Begin
 SetBytesPerLnTxt(X)
End;

Procedure SetChr;Begin;SetChrTxt(X,Y,Chr)End;

Procedure SetChrWidth;Begin
 SetChrWidthTxt(L);
End;

{Fixe un caractŠre et son attribut … (X,Y)}
Procedure SetCube;Begin SetCubeTxt(X,Y,Chr,Attr)End;

Procedure SetCur;Begin SetCurTxt(A,B)End;

Procedure SetCurPosBios(X,Y:Byte);Assembler;ASM
 MOV AH,$02
 MOV DL,X
 MOV DH,Y
 MOV BH,DataVideo.Pg
 INT $10
END;

Procedure SetCurPos;
Const _SetCurPos:Array[drvBios..drvTxt]of Procedure(X,Y:Byte)=(
       SetCurPosBios,
       SetCurPosTxt
      );
Begin
 _SetCurPos[CurrDrv](X,Y)
End;

{Procedure SetDblMtx;Begin;SetDblMtxTxt(X)End;}
Procedure SetExtChr;Begin;SetExtChr(X,Y,Chr)End;
Procedure SetExtCube;Begin;SetExtCube(X,Y,Chr,Attr)End;

Procedure SetHorizontalScale;Begin
 SetHorizontalScaleTxt(X);
End;

Procedure SetHeightChr;Begin;End;{Fixe la hauteur des caractŠres}
Procedure SetGCube;Begin;End;{Affiche un caractŠre et son attribut … la position (X,Y) en pixel}
Procedure SetGCubeT;Begin;End;{Affiche un caractŠre et son attribut … la position (X,Y) en pixel sans changer le fond}

Procedure SetMatrix;Begin{Charge une police en m‚moire vid‚o}
 SetMatrixTxt(Palette,Height,Number,Start,X);
End;

Procedure SetModeMtx;Begin{Fixe le contr“leur vid‚o … la m‚moire des polices}
 SetModeMtxTxt;
End;

Procedure SetModeScr;Begin{Fixe le contr“leur vid‚o … la m‚moire des polices}
 SetModeScrTxt;
End;

Procedure SetModeValue;Begin;End;{Fixe le seulement le code du mode vid‚o actuel}

Procedure SetPaletteRGB;Begin;SetPaletteRGBTxt(Start,R,G,B)End;

Procedure SetPg;Begin;End;{Fixe la page de travail}
Procedure SetPixel;Begin;End;{Fixe un pixel … l'‚cran}
Procedure SetPIV;Begin;End;{Fixe tous les informations physique con‡ernant la carte vid‚o actuel}
Procedure SetTxtMtx;Begin;End;{Fixe l'adresse de la nouvelle police texte}

Procedure SetUnderline;Begin;SetUnderlineTxt(X)End;
Procedure SetVerticalScale;Begin;SetVerticalScaleTxt(Y)End;

Procedure SetVisualPg;Begin;End;{Fixe le num‚ro de la page actuellement affich‚}

Function VGA320x400Found;Begin{Le mode VGA 320x400 est support‚ (pas toujours le cas chez les clones)?}
 VGA320x400Found:=PhysVideo.VGA320x400
End;

Function VideoFontFound;Begin{Police programme support‚ par cette carte?}
 VideoFontFound:=PhysVideo.Font
End;

Function VideoHerculeFound;Begin{Mode Hercule support‚ par cette carte?}
 VideoHerculeFound:=PhysVideo.Hercule
End;

Function VideoMousePortFound;Begin{Port souris inclue … la carte vid‚o?}
 VideoMousePortFound:=PhysVideo.MousePort
End;

Function VideoPaletteFound;Begin{Palette de couleur programme support‚?}
 VideoPaletteFound:=PhysVideo.Palette
End;

Procedure WriteBnk;Begin;End;{crit des donn‚es dans la banque vid‚o Super VGA}
Procedure Done;Begin;End;{D‚branche tous les services entraŒner par le pilote}

{Initialise le pilote charg‚ en m‚moire}
Procedure Init;Var I:Byte;X:Wd;S:String;Begin;
 FillChar(DataVideo,SizeOf(DataVideo),0);
 If CurrDrv=$FFThen CurrDrv:=viInitVideo;
 Case(CurrDrv)of
  drvTxt:Begin
   DataVideo.Colr:=VideoPort=$3D4;
   If(DataVideo.Colr)Then Begin
    DataVideo.SegV:=SegB800;
    DataVideo.NmColrs:=16;
   End
    Else
   Begin
    DataVideo.SegV:=SegB000;
    DataVideo.NmColrs:=4;
   End;
   DataVideo.SegBuf:=DataVideo.SegV;
   DataVideo.NmXTxts:=CurrNmXTxts;DataVideo.NmYTxts:=CurrMaxYTxts+1;
   DataVideo.BytesPerLn:=DataVideo.NmXTxts shl 1;DataVideo.NmXPixels:=DataVideo.BytesPerLn shl 2;
   DataVideo.IbmLogic:=Ya;DataVideo.BiosSupport:=Ya;DataVideo.Graf:=No;DataVideo.NmVidPgs:=1;
   DataVideo.HeightChr:=CurrHeightChr;DataVideo.Direct:=Ya;
   DataVideo.NmYPixels:=DataVideo.HeightChr*DataVideo.NmYTxts;X:=0;
   For I:=0to 255do Begin
    If X>=32767Then X:=0;
    RawTxtY[I]:=X;Inc(X,DataVideo.NmXTxts)
   End;
   Str(CurrDrv,S);
   PutTxtXY(10,10,S,$1F);
  End;
 End;
End;

{$I \Source\Chantal\RLL\Video\VideoMod.Inc}

Procedure _AutoDetect(CheckSVGA:Bool);Export;Begin
 _GetVideoCard(CheckSVGA,PhysVideo,PVid2)
End;

Function MaxXPixels:Wd;Export;Begin
 MaxXPixels:=Pred(DataVideo.NmXPixels);
End;

Function MaxYPixels:Wd;Export;Begin
 MaxYPixels:=Pred(DataVideo.NmXPixels);
End;

Function viInitVideo:Byte;Begin
 Case(CurrVideoMode)of
  $13:viInitVideo:=drv19;
  0..3:Begin
   DataVideo.Graf:=No;
   If VideoPort=$3D4Then DataVideo.SegV:=_B800 Else DataVideo.SegV:=_B000;
   viInitVideo:=drvTxt;
  End;
  Else Begin
  End;
 End;
End;
(* XOR AX,AX
 MOV ES,AX
 MOV AL,ES:[449h]
 CMP AL,13h
 JE  @vi0b
 CMP AL,7
 JE  @vi0
 CMP AL,6
 JE  @vi0c
 CMP AL,4
 JNB @vi1
@vi0:
 MOV BL,No
 JMP @vi2
@vi0b:
 MOV AL,5
 JMP @viEnd9
@vi0c:
 MOV AL,2
 JMP @viEnd9
  { C'est un mode Graphiques ? }
@vi1:
 MOV AH,0Dh
 XOR BH,BH
 XOR CX,CX
 XOR DX,DX
 INT 10h
 PUSH AX
  MOV AX,0C01h
  INT 10h
  MOV AH,0Dh
  INT 10h
  MOV BL,AL
  MOV AH,0Ch
 POP AX
 INT 10h
@vi2:
 MOV CS:[adrDataVideo].MIV.Graf,BL ; Init
 CMP BL,Ya
 JE  @vi7
 XOR AX,AX
 MOV ES,AX
 MOV AH,0B0h
 CMP Word Ptr ES:[463h],3D4h
 JNE @vi3
 MOV AH,0B8h
@vi3:
 MOV ES,AX
 PUSH ES
  MOV AH,3
  MOV BH,0
  INT 10h
  PUSH DX
   MOV AH,2
   XOR DX,DX
   INT 10h
  POP  DX
  MOV AH,8
  INT 10h
 POP ES
 CMP AX,ES:[0]
 MOV AH,2
 JNE @vi5
 INT 10h
 MOV AL,Ya
 JMP @vi6
@vi5:
 INT 10h
 MOV AL,No
@vi6:
 MOV CS:[adrDataVideo].MIV.Direct,AL
 JMP @viEnd9
@vi7:
 MOV AH,1Bh
 XOR BX,BX
 PUSH CS
 POP ES
 MOV DI,Offset @viData
 INT 10h
 CMP AL,1Bh
 JNE @viBios
 MOV AX,Word Ptr CS:[Offset @viData+27h]
 CMP AX,2
 JE  @viEnd9
 MOV BX,AX
 MOV AL,4
 CMP BX,16
 JE  @viEnd9
 MOV AL,6
 JE  @viEnd9
@viBios:
 XOR AX,AX
@viEnd9:
End;*)

Procedure ClrScrBlack;Export;Begin
 ClrScr(7)
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure SetPalBlk                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure fixe un nombre d‚terminer de pallette en couleur noir.
}

Procedure SetPalBlk(Start,Nm:Wd);Begin
 SetPalBlkTxt(Start,Nm);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                              Proc‚dure SetPalRGB                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure fixe une palette de style Rouge-Vert-Bleu. Peut importe la
 carte install‚, si elle supporte des palettes de couleurs, il fait avec!
}

Procedure SetPalRGB(Var P;Start,Num:Wd);Begin
 SetPalRGBTxt(P,Start,Num);
End;

Procedure SetVideoSeg(Seg:Word);Begin;End;

Procedure SetWriteMode;Begin;SetWriteModeTxt(Mode)End;
Procedure SplitScreen;Begin;SplitScreenTxt(Y)End;

Exports
 _GetVideoCard       index mf_GetVideoCard,
 _AutoDetect         index mf_AutoDetect,
 Init                index mfInit,
 Bar                 index mfBar,
 BarChrHor           index mfBarChrHor,
 BarChrVer           index mfBarChrVer,
 BarSpcHor           index mfBarSpcHor,
 BiosBlinkFound      index mfBiosBlinkFound,
 BitsPerPixel        index mfBitsPerPixel,
 BytesPerLn          index mfBytesPerLn,
 CloseCur            index mfCloseCur,
 ClrLnHor            index mfClrLnHor,
 ClrLnHorImg         index mfClrLnHorImg,
 ClrScr              index mfClrScr,
 ClrWn               index mfClrWn,
 ColorFound          index mfColorFound,
 CopT8Bin            index mfCopT8Bin,
 Copy8Bin            index mfCopy8Bin,
 FillBox             index mfFillBox,
 FontFound           index mfFontFound,
 GetAttr             index mfGetAttr,
 GetChr              index mfGetChr,
 GetCube             index mfGetCube,
 GetLnHorImg         index mfGetLnHorImg,
 GetMaxKr            index mfGetMaxKr,
 GetMIV              index mfGetMIV,
 GetNmKr             index mfGetNmKr,
 GetNmVideoPages     index mfGetNmVideoPages,
 GetPIV              index mfGetPIV,
 GetPIVSec           index mfGetPIVSec,
 GetPixel            index mfGetPixel,
 GetRealRawY         index mfGetRealRawY,
 GetRealRawYWord     index mfGetRealRawYWord,
 GetSelPg            index mfGetSelPg,
 GetSizeSmlImg       index mfGetSizeSmlImg,
 GetSmlImg           index mfGetSmlImg,
 GetVideoBitsDAC     index mfGetVideoBitsDAC,
 GetVideoBitsIO      index mfGetVideoBitsIO,
 GetVideoBitsROM     index mfGetVideoBitsROM,
 GetVideoCard        index mfGetVideoCard,
 GetVideoCardCat     index mfGetVideoCardCat,
 GetVideoMem         index mfGetVideoMem,
 GetVideoMode        index mfGetVideoMode,
 GetVideoPg          index mfGetVideoPg,
 GetVideoMonitor     index mfGetVideoMonitor,
 GetVideoScrSize     index mfGetVideoScrSize,
 GetVideoSeg         index mfGetVideoSeg,
 GetVideoSegBuf      index mfGetVideoSegBuf,
 GetVideoSegROM      index mfGetVideoSegROM,
 GetVideoShowPg      index mfGetVideoShowPg,
 GetVideoSizeBnkPg   index mfGetVideoSizeBnkPg,
 GetVideoTxtAddrPg   index mfGetVideoTxtAddrPg,
 GetVideoTxtMtxPtr   index mfGetVideoTxtMtxPtr,
 HeightChr           index mfHeightChr,
 IsBlink             index mfIsBlink,
 IsEGA               index mfIsEGA,
 IsGrf               index mfIsGrf,
 IsKr                index mfIsKr,
 IsMono              index mfIsMono,
 IsVESA              index mfIsVESA,
 IsVGA               index mfIsVGA,
 IsVideoDirectAccess index mfIsVideoDirectAccess,
 IsVideoModeBios     index mfIsVideoModeBios,
 IsVideoModeIBMLogic index mfIsVideoModeIBMLogic,
 IsVideoSnow         index mfIsVideoSnow,
 MaxXPixels          index mfMaxXPixels,
 MaxXTxts            index mfMaxXTxts,
 MaxYPixels          index mfMaxYPixels,
 MaxYTxts            index mfMaxYTxts,
 MoveText            index mfMoveText,
 NmXPixels           index mfNmXPixels,
 NmXTxts             index mfNmXTxts,
 NmYPixels           index mfNmYPixels,
 NmYTxts             index mfNmYTxts,
 PCopy               index mfPCopy,
 PutFillBox          index mfPutFillBox,
 PutLn               index mfPutLn,
 PutLnHor            index mfPutLnHor,
 PutSmlImg           index mfPutSmlImg,
 PutTxtXY            index mfPutTxtXY,
 PutTxtXYUnKr        index mfPutTxtXYUnKr,
 ReadBnk             index mfReadBnk,
 SelBnkPg            index mfSelBnkPg,
 SetAttr             index mfSetAttr,
 SetBlink            index mfSetBlink,
 SetBnkPg            index mfSetBnkPg,
 SetChr              index mfSetChr,
 SetChrWidth         index mfSetChrWidth,
 SetCube             index mfSetCube,
 SetCur              index mfSetCur,
 SetCurPos           index mfSetCurPos,
 SetGCube            index mfSetGCube,
 SetGCubeT           index mfSetGCubeT,
 SetHeightChr        index mfSetHeightChr,
 SetMatrix           index mfSetMatrix,
 SetModeMtx          index mfSetModeMtx,
 SetModeScr          index mfSetModeScr,
 SetModeValue        index mfSetModeValue,
 SetPg               index mfSetPg,
 SetPIV              index mfSetPIV,
 SetPixel            index mfSetPixel,
 SetTxtMtx           index mfSetTxtMtx,
 SetVisualPg         index mfSetVisualPg,
 VGA320x400Found     index mfVGA320x400Found,
 VideoFontFound      index mfVideoFontFound,
 VideoHerculeFound   index mfVideoHerculeFound,
 VideoMousePortFound index mfVideoMousePortFound,
 VideoPaletteFound   index mfVideoPaletteFound,
 WriteBnk            index mfWriteBnk,
 viSetVideoModePrim  index mfviSetVideoModePrim,
 Done                index mfDone,
 ClrScrBlack         index mfClrScrBlack,
 viInitVideo         index mfviInitVideo,
 SetPalBlk           index mfSetPalBlk,
 SetPalRGB           index mfSetPalRGB,
 BarTxtHor           index mfBarTxtHor,
 viSetVideoSizePrim  index mfSetVideoSize,
 BarSpcVer           index mfBarSpcVer,
 Circle              index mfCircle,
 FillBnk             index mfFillBnk,
 PCopy2Img           index mfPCopy2Img,
 PutCharGAttr        index mfPutCharGAttr,
 PutFillCircle       index mfPutFillCircle,
 PutFillRoundRect    index mfPutFillRoundRect,
 PutRect             index mfPutRect,
 PutRoundRect        index mfPutRoundRect,
 PutSprite           index mfPutSprite,
 SetBackgroundColor  index mfSetBackgroundColor,
 SetBorderColor      index mfSetBorderColor,
 SetBytesPerLn       index mfSetBytesPerLn,
 SetDblMtx           index mfSetDblMtx,
 SetExtChr           index mfSetExtChr,
 SetExtCube          index mfSetExtCube,
 SetHorizontalScale  index mfSetHorizontalScale,
 SetUnderline        index mfSetUnderline,
 SetVerticalScale    index mfSetVerticalScale,
 SetPaletteRGB       index mfSetPaletteRGB,
 SetVideoSeg         index mfSetVideoSeg,
 SetWriteMode        index mfSetWriteMode,
 SplitScreen         index mfSplitScreen;

BEGIN
END.