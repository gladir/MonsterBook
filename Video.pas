{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                Malte Genesis/Module de gestion du Vid‚o               Û
 ³        dition Chantal & AdŠle pour Mode R‚el/IV - Version 1.27       Û
 ³                              1998/02/14                               Û
 ³                                                                       Û
 ³          Tous droits r‚serv‚s par les Chevaliers de Malte (C)         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Nom du programmeur
 ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

  Sylvain Maltais


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette unit‚ est un support d'appoint pour la gestion de l'‚cran vid‚o de
 l'ordinateur. Il passe toutefois par l'unit‚ ®Chantal¯ pour permettre son
 exploitation.


 Remarque
 ÍÍÍÍÍÍÍÍ

  ş Bien qu'il utilise l'unit‚  ®Chantal¯  ou ®Adele¯,  il n'est pas moins
    important que celles-ci car elle mˆme de peut correctement fonctionner
    dans ce monde sans la pr‚sence de cette unit‚!
}

Unit Video;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                 INTERFACE
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

{$I DEF.INC}

Uses Systex;

Const
 DrawS:Byte=4;                          { chelle de grandeur (DRAW)}
 GraphColor:Word=White;                 { Couleur d'affiche graphique courante }
 LastColor:Byte=White+(Black shl 4);    { ATTENTION! Ne pas d‚placer}
 NorColor:Byte=LightGray+(Black shl 4); { ATTENTION! Ne pas d‚placer}
 WinType:WinModelType=Robotic; { Format des bordures en graphique }
 kType:Byte=ktElvis;           { Format des boutons de dialogue }
 InputType:Byte=itElvis;       { Format des entr‚es }
 VidBnkSwitch:VidBnkSwitchRec=({ Donn‚e vid‚o de base }
  {$IFDEF NotReal}Shade:Ya;{$ENDIF}{ Ombrage des cadres autoris‚ (Oui/Non) }
  XP:0;                        { Position texte horizontale courante }
  YP:0;                        { Position texte verticale courante }
  XL:0;                        { Position graphique horizontale courante }
  YL:0);                       { Position graphique verticale courante }
 CurBuf:^TByte=NIL;            { Tampon temporaire du curseur }
 CurBufSize:Word=0;            { Taille du tampon temporaire du curseur }
 DefaultRGB:Array[0..15]of RGB=({ Palette RVB par d‚faut }
  (R:$00;G:$00;B:$00), { 00h (0): Palette RVB Noir par d‚faut }
  (R:$00;G:$00;B:$70), { 01h (1): Palette RVB Bleu par d‚faut }
  (R:$00;G:$70;B:$00), { 02h (2): Palette RVB Vert par d‚faut }
  (R:$00;G:$70;B:$70), { 03h (3): Palette RVB Cyan par d‚faut }
  (R:$70;G:$00;B:$00), { 04h (4): Palette RVB Rouge par d‚faut }
  (R:$70;G:$00;B:$70), { 05h (5): Palette RVB Magenta par d‚faut }
  (R:$70;G:$48;B:$00), { 06h (6): Palette RVB Brun par d‚faut }
  (R:$C4;G:$C4;B:$C4), { 07h (7): Palette RVB Gris clair par d‚faut }
  (R:$34;G:$34;B:$34), { 08h (8): Palette RVB Gris fonc‚ par d‚faut }
  (R:$00;G:$00;B:$FF), { 09h (9): Palette RVB Bleu claire par d‚faut }
  (R:$24;G:$FC;B:$24), { 0Ah (10): Palette RVB Vert claire par d‚faut }
  (R:$00;G:$FC;B:$FC), { 0Bh (11): Palette RVB Cyan claire par d‚faut }
  (R:$FC;G:$14;B:$14), { 0Ch (12): Palette RVB Rouge claire par d‚faut }
  (R:$B0;G:$00;B:$FC), { 0Dh (13): Palette RVB Magenta claire par d‚faut }
  (R:$FC;G:$FC;B:$24), { 0Eh (14): Palette RVB Jaune par d‚faut }
  (R:$FF;G:$FF;B:$FF));{ 0Fh (15): Palette RVB blanc par d‚faut }

 MotorolaColor:Array[0..15]of Byte=(
  Black,     Red,          Green,      Brown,
  Blue,      Magenta,      Cyan,       LightGray,
  DarkGray,  LightRed,     LightGreen, Yellow,
  LightBlue, LightMagenta, LightCyan,  White
 );

 curCoco3Attr:Array[0..3]of Byte=($0F,$C0,$90,$E0);
 QQF:^TByte=NIL;        { Pointeur sur la police QQF courante }
 QQFSize:Word=0;        { Taille de la police QQF courante }
 QQFHeight:Byte=0;      { Hauteur de la polite QQF courante }
 SetVideoSizeInit:Procedure=NIL;

 {$IFDEF Adele}
  Inv:Boolean=False;    { Inversion des bits d'affichage requis? }
 {$ENDIF}

Var
 {$IFNDEF Adele}
  UnSelIcon,            { Icon de d‚s‚lection }
  SelIcon,              { Icon de s‚lection }
  CloseIcon,            { Icon de fermeture }
  ZoomIcon,             { Icon de "Zoom" agrandissement/raptissement }
  LeftIcon,             { Icon de flŠche vers la Gauche }
  RightIcon,            { Icon de flŠche vers la Droite }
  UpIcon,               { Icon de flŠche vers le haut }
  DownIcon:{$IFDEF Real}
   StrIcon
  {$ELSE}
   String
  {$ENDIF};     { Icon de flŠche vers le bas }
 {$ELSE}
  UnSelIconLen,         { Largeur en caractŠre de l'ic“ne de d‚s‚lection }
  SelIconLen,           { Largeur en caractŠre de l'ic“ne de s‚lection }
  CloseIconLen,         { Largeur en caractŠre de l'ic“ne de fermeture }
  ZoomIconLen,          { Largeur en caractŠre de l'ic“ne de Zooming }
  LeftIconLen,          { Largeur en caractŠre de l'ic“ne de flŠche gauche }
  RightIconLen,         { Largeur en caractŠre de l'ic“ne de flŠche droite }
  UpIconLen,            { Largeur en caractŠre de l'ic“ne de flŠche haut }
  DownIconLen:Byte;     { Largeur en caractŠre de l'ic“ne de flŠche bas }
 {$ENDIF}
 CurBorder:BorderType; { Format des bordures de cadre de boŒte }
 CurrCube:Word;        { Format   de   caractŠre   et   d'attribut  …  la }
                       { position du curseur (seulement si le curseur est }
                       { de format Coco 3)}
 CurrMtx:String{$IFDEF Real}[8]{$ENDIF};{ Nom de la police systŠme courante }
 DegradLen:Word;       { Longueur de d‚gradation }
 FontDegraded:Boolean; { D‚gradation support‚ par le mode vid‚o }
 SizeMulFont:Byte;
 PathFont:{$IFDEF NotReal}
  String
 {$ELSE}
  PathStr
 {$ENDIF};{ R‚pertoire de la police graphique courante }
 DefaultMode:Word;     { Mode de lancement par d‚faut }

Procedure AniCur;Far;
Procedure BarHorDials(X1,Y,X2,Attr:Byte);
Procedure BarSelHor(X1,Y,X2,Attr:Byte);
Procedure BarSelVer(X,Y1,Y2,Attr:Byte);
Procedure BarSpcHorRelief(X1,Y,X2,Attr:Byte);
Procedure BarSpcHorReliefExt(X1,Y,X2,Attr:Byte);
Procedure BarSpcHorShade(X1,Y,X2,Attr,BackAttr:Byte);
{$IFNDEF Adele}Procedure BarSpcVer(X,Y1,Y2,Attr:Byte);
Procedure BarTxtHor(X1,Y,X2:Byte;Chr:Char;Attr:Byte);{$ENDIF}
Procedure BarTxtVer(X,Y1,Y2:Byte;Chr:Char;Attr:Byte);
Procedure BoldIcon(X,Y:Word;Attr:Byte);
Procedure BoxRelief(X1,Y1,X2,Y2,Attr:Byte);
Procedure ClrBoxTxt(X1,Y1,X2,Y2:Byte);
Procedure ClrEol(Attr:Byte);
Procedure ClrLn(Y:Byte;Chr:Char;Attr:Byte);
Procedure ClrScrBlack;
Procedure CMY2CMYK(Source:CMY;Var Target:CMYK);
Procedure CMY2RGB(Source:CMY;Var Target:RGB);
Procedure CMYK2RGB(C,Y,M,K:Byte;Var Q:RGB);
Procedure Color2RGB(Color:Word;Var Q:RGB);
Procedure Conv4BitsMotorola2IntelKr(BytesPerLine:Word;Var Line:Array of Byte);
Function  Conv4Planes2BitMap(BytesPerLine:Word;Var Line:Array of Byte):Boolean;
Procedure Conv4To8BitsKr(Const Source;Var Dest;Len:Word);
Procedure Conv8To4BitsKr(Const Source;Var Dest;Len:Word);
Procedure CoordTxt2Graph(Const Txt;Var Graph);
Procedure CoordGraph(Var Graph;X1,Y1,X2,Y2:SmallInt);
Procedure CopyBoxTxt(X1,Y1,X2,Y2:Byte;Var Buffer);
Function  DegradSupport:Boolean;
Procedure DoneLuxeVideo;
Procedure DoneVideo;
Procedure DoubleIcon(X,Y:Word;Attr:Byte);
Procedure DrawIcon(X,Y:Word;Attr:Byte);
Procedure DrawPoly(Num:Word;Var P:TPointType;Kr:Word);
Procedure FillLosange(X,Y,Rayon,Kr:Word);
Procedure FillOctogone(X,Y,Arrete,Kr:Word);
Procedure FullCur;
Procedure GetBorder(Var Border:BorderType);
Function  GetVideoBufPtr(X,Y:Byte):Pointer;
Function  GetCenterBox(X1,X2:Byte;Center:CenterType;Const Msg:String):Byte;
Procedure GetCenterTxt(L,H:Byte;Var X1,Y1,X2,Y2:Byte);
Function  GetClassicToColor(Color:Byte):Word;
Function  GetCurrMtx(Var Height:Byte):Pointer;
Function  GetCurType:Byte;
Function  GetForeground(Attribut:Byte):Byte;
          {$IFNDEF __Windows__}
           Inline(ciPopAX/      { POP AX }
                  $80/$0E/$0F); { AND AL,0Fh}
          {$ENDIF}
Function  GetGrayColor(Value:Byte):Word;
Function  GetGreyColor(Color:Word):Word;
Function  GetHoriCenter(L:Byte):Byte;
Function  GetKeyKr:Byte;
Function  GetKeySelKr:Byte;
Function  GetKr:Byte;
Function  GetLastKr:Byte;
Function  GetNegativeColor(Color:Word):Word;
Function  GetNmLnMsg(X1,X2:Byte;Const Msg:String):Byte;
Function  GetPalette(Var Palette;Num:Word):Word;
Procedure GetPaletteRGB(Var Pal;Start,Num:Word);
Function  GetSaturationColor(Color:Word;Factor:Word):Word;
Function  GetShade:Boolean;
Function  GetVertCenter(H:Byte):Byte;
Function  GetWidthTxts(Const S:String):Word;
Function  GetXTxtsPos:Byte;
Function  GetYTxtsPos:Byte;
Procedure GraphBoxRelief(GX1,GY1,GX2,GY2:Word;Attr:Byte);
Procedure HSI2RGB(H,S,I:Real;Var C:RGB);
Procedure HSV2RGB(H,S,V:Real;Var Target:RGB);
Procedure InitVideo;
Procedure InitVideoDeluxe;
Procedure InverseOrderLine(Var Buffer;Size,BytesPerLine,NumYPixels:Word);
Function  IsSVGA:Boolean;
Procedure ItalicIcon(X,Y:Word;Attr:Byte);
Procedure JustifyCenterIcon(X,Y:Word;Attr:Byte);
Procedure LAB2XYZ(L,A,B:Real;Var Target:XYZ);
Procedure LeftCenterIcon(X,Y:Word;Attr:Byte);
Function  LenTyping(Msg:PChr):Word;
Function  LoadMtx(Path:String):Boolean;
Function  LoadGlyphs24:Boolean;
Function  LoadQQF(Name:String):Boolean;
Function  LocalBytesPerLine(NumXPixels:Word;BitsPerPixel:Byte):Word;
Procedure LuxeBox(X,Y:Byte);
Procedure MakePaletteColorToWhite(Color:Byte;Num:Word;Var Palette);
Procedure MakePaletteColorTo(Color:Byte;Num:Word;Inverse:Boolean;Var Palette);
Procedure MakePaletteWhiteToColor(Color:Byte;Num:Word;Var Palette);
Procedure Octogone(X,Y,Arrete,Kr:Word);
Procedure OutFTxtXY(X,Y:Word;Const S:String;Kr:Word);
Procedure OutSmlTxtXY(X,Y:Word;Const S:String;Attr:Byte);
Procedure OutSTxtXY(X,Y:Word;Const S:String;Attr:Byte);
Procedure OutTxtXY(X,Y:Word;Const S:String;Attr:Byte);
Procedure OutTextXY(X,Y:Word;Const S:String;Attr:Byte);
Procedure PopCur;
Procedure PuceAlphaIcon(X,Y:Word;Attr:Byte);
Procedure PuceBlockIcon(X,Y:Word;Attr:Byte);
Procedure PuceNumberIcon(X,Y:Word;Attr:Byte);
Procedure PuceRomanIcon(X,Y:Word;Attr:Byte);
Procedure PushCur;
Procedure PutAiguillon(X,Y:Byte);
Procedure PutBorderUnKr(X1,Y1,X2,Y2:Byte);
Procedure PutBoxOnlyShade(X1,Y1,X2,Y2:Byte);
Procedure PutBoxRect(X,Y:Byte;Var Q:BoxRectRec);
Procedure PutBoxTxt(X1,Y1,X2,Y2:Byte;Var Buffer);
Procedure PutFillBorder(X1,Y1,X2,Y2,Attr:Byte);
Procedure PutFont(Const S:String);
Procedure PutGTxtXY(X,Y:Word;Const S:String;Attr:Byte);
Procedure PutKeyHori(X1,Y,X2:Byte;Const Msg:String;Attr,Shade:Byte);
Procedure PutMsg(X1,Y1,X2:Byte;Const Msg:String;Attr:Byte);
Procedure PutOTxtU(Y:Byte;Center:CenterType;Const Msg:String;Attr:Byte);
Procedure PutPCharXY(X,Y:Byte;Str:PChr;Attr:Byte);
{$IFNDEF Adele}Procedure PutRect(X1,Y1,X2,Y2,Color:Int);{$ENDIF}
Procedure PutFillRoundRectZone(x1,y1,x2,y2,b,Kr:Integer;Zone:ZoneType);
Procedure PutSmlTxtXY(X,Y:Byte;Const S:String;Attr:Byte);
Procedure PutSmlTxtXYT(X,Y:Byte;Const S:String;Attr:Byte);
Procedure PutTaskBarIcon(X,Y,Attr:Byte);
Procedure PutTxtCenter(Y:Byte;Center:CenterType;Const Msg:String;Attr:Byte);
Procedure PutTxtLuxe(X,Y:Byte;Const S:String;Attr:Byte);
Procedure PutTxtFade(X,Y:Byte;Const S:String;Attr:Byte;Border:Boolean);
Procedure PutTxtXYT(X,Y:Byte;Const Str:String;Attr:Byte);
Procedure PutTxtZUnKr(Z:Word;Const Str:String);
Procedure PutTyping(Const Msg:String);
Procedure PutTypingXY(X,Y:Byte;Const Msg:String);
Procedure ReSaveBoxRect(X,Y:Byte;Var Q:BoxRectRec);
Procedure RestoreBoxRect(Var Q:BoxRectRec);
Procedure RGB2CMY(Source:RGB;Var Target:CMY);
{$IFDEF __Windows__}
 Function RGB2Color(R,G,B:Byte):LongInt;
{$ELSE}
 Function RGB2Color(R,G,B:Byte):Word;
{$ENDIF}
Procedure RGB2HSV(Source:RGB;Var H,S,V:Real);
Procedure RGB2XYZ(Source:RGB;Var Target:XYZ);
Procedure RGB2YCrCb(Source:RGB;Var Y,Cr,Cb:Real);
Procedure RGB2YIQ(Source:RGB;Var Target:YIQ);
Procedure RGB2YUV(Source:RGB;Var Target:YUV);
Procedure RightCenterIcon(X,Y:Word;Attr:Byte);
Function  SaveBoxRect(X1,Y1,X2,Y2:Byte;Var Q:BoxRectRec):Boolean;
Function  SearchHigh(Msg:PChr):String;
Procedure SetAllKr(Last,New:Byte);
Procedure SetBorderAvenger;
Procedure SetBorderDouble;
Procedure SetBorderSimple;
Procedure SetBorderSimpleLuxe;
Procedure SetCurType(X:Byte);
Procedure SetFontName(Name:String);
Procedure SetKr(Color:Byte);
Procedure SetLuxe;
Procedure SetPos(X,Y:Byte);
Procedure SetPosHome;
Procedure SetShade(X:Boolean);
Procedure SetSpc(X,Y,Attr:Byte);
Function  SetVideoMode(Mode:Word):Boolean;
Function  SetVideoModeDeluxe(Mode:Word):Boolean;
Function  SetVideoSize(Grf,Length,Height:Word):Boolean;
Procedure SimpleCur;
Procedure SimpleLineIcon(X,Y:Word;Attr:Byte);
Procedure DoubleLineIcon(X,Y:Word;Attr:Byte);
Function  SizeBoxTxt(X1,Y1,X2,Y2:Byte):Word;
Procedure UnderlineIcon(X,Y:Word;Attr:Byte);
Procedure UnLuxe;
Procedure Update4BitsKrShadow(Const Shadow;Var Buffer;Len:Word;Kr:Byte);
Procedure WaitRetrace;
Procedure Word2Graph(Z:Word;Var Q);
Procedure WordTxt2Graph(Var Q);
Procedure XYZ2LAB(Source:XYZ;Var L,A,B:Real);
Function  XYZ2RGB(Source:XYZ;Var Target:RGB):LongInt;
Procedure YCrCb2RGB(Y,Cr,Cb:Real;Var Target:RGB);
Function  YIQ2RGB(Source:YIQ;Var Target:RGB):Boolean;
Procedure _BarSelectHori(X1,Y,X2:Byte);
Procedure _BarSpcHor(X1,Y,X2:Byte);
Procedure _Color2RGB(Color:Word;BitsPerPixel:Byte;Var Q:RGB);
Procedure _Dn;{$IFNDEF __Windows__}
           InLine($FE/$06/>VidBnkSwitch+
                  {$IFDEF NotReal}2{$ELSE}1{$ENDIF});{INC VidBnkSwitch.YP}
          {$ENDIF}
Procedure _DrawPoly(Num:Word;Var P);
Procedure _Left;
Procedure _LineBox2Line(X1,Y,X2:Byte);
Procedure _LineBox2LineStyle(X1,Y,X2:Byte;Color1,Color2:Word);
Procedure _Ln(X1,Y1,X2,Y2:Integer);
Procedure _Ln2(X,Y:Integer);
Procedure _LnHor(X1,Y,X2:Integer);
Procedure _Move2(X,Y:Integer);
Procedure _OutTextXY(X,Y:Word;Const S:String;Attr:Byte);
Procedure _PutBoxRect(Var Q:BoxRectRec);
Procedure _PutFillBox(X1,Y1,X2,Y2:Word);
Procedure _PutPCharXY(X,Y:Byte;Str:PChr);
Procedure _PutRect(X1,Y1,X2,Y2:Word);
Procedure _PutTxt(Const Msg:String);
Procedure _PutTxtLn(Const Msg:String);
Procedure _PutTxtXY(X,Y:Byte;Const Msg:String);
Function  _RGB2Color(BitsPerPixel,R,G,B:Byte):Word;
Procedure _Right;
Function  _SaveBoxRect(Const X;Var Q:BoxRectRec):Boolean;
Procedure _SetChr(Chr:Char);
Procedure _SetKr(Color:Word);
          {$IFNDEF __Windows__}
           InLine($8F/$06/>GraphColor);
          {$ENDIF}
Procedure _SetCube(Chr:Char);
Procedure _SetPixel(X,Y:Integer);
Procedure _Up;
          {$IFNDEF __Windows__}
           InLine($FE/$0E/>VidBnkSwitch+
              {$IFDEF NotReal}2{$ELSE}1{$ENDIF});{DEC VidBnkSwitch.YP}
          {$ENDIF}
Procedure _WaitRetrace;
Procedure _WaitDisplay;
Procedure __GetCenterTxt(L,H:Byte;Var Q);
Function  __GetSizeSmlImg(Var Q):Word;
Procedure __GetSmlImg(Const Context;Var Buffer);
Procedure __GraphBoxRelief(Const Q;Attr:Byte);
Procedure __PutBorderUnKr(Const Context);
Procedure __PutFillBox2Line(Var Q);
Procedure __PutLnHor(Const Coord;Kr:Word);
Procedure __PutRect(Const Coord;Kr:Word);
Procedure __PutSmlImg(Const Context;Var Buffer);

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                             IMPLEMENTATION
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses Adele,Math,Memories,Systems,Mouse,Dialex;

{$IFDEF Real}
 {{{$DEFINE External}
{$ENDIF}

{M‚canisme de localisation des donn‚es des pilotes}
Const
 BorderDouble:BorderType='ÉÍ»ººÈÍ¼';
 BorderSimple:BorderType='ÚÄ¿³³ÀÄÙ';
 DrvLoad:Boolean=False;                 { Pilote charger? }
 FirstTime:Boolean=True;                { C'est la premiŠre fois
                                          que le pilote est lanc‚e?}
 LuxeMtx:^TByte=NIL;                    { Pointeur sur la police de luxe }
 MtxSize:Word=0;                        { Taille de la police standard }
 DriverModel:Byte=$FF;                  { Code de pilote }
 LuxeMtxSize:Word=0;                    { Taille de la police de luxe }

{$I Library\Video\Driver.Inc}

Var
 OldTime,CurType:Byte;                  { Ancienne tic d'heure et
                                          style de curseur}
 OldBackKbd:Procedure;                  { Adresse de l'ancienne routine
                                          de clavier en arriŠre plan }

{****Proc‚dures et fonctions priv‚e }
Procedure PutChr(X,Y:Word;Len,Height:Byte;Var Buffer:Array of Byte);Near;Forward;
{$IFNDEF Adele}
 Procedure SetDefaultGraphIcon;Near;Forward;
 Procedure SetDefaultIcon;Near;Forward;
{$ENDIF}

(*{$IFNDEF Windows}
 Function Focused:Bool;Assembler;ASM
  PUSHF
   CLI
   {$IFDEF DPMI}
    MOV ES,_0040
   {$ELSE}
    {$IFOPT G+}
     PUSH _0040
     POP ES
    {$ELSE}
     MOV AX,_0040
     MOV ES,AX
    {$ENDIF}
   {$ENDIF}
   MOV AL,0
   CMP Byte Ptr ES:[0061h],20h
   JE  @End
   MOV AL,1
@End:
  POPF
 END;
{$ENDIF}*)

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Proc‚dure AniCur                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure affiche le curseur en fonction  de l'‚tat courant de
 l'heure. 4 fois par seconde (2 fois pour le curseur Commodore 64K) la
 couleur  du curseur sera chang‚  si vous appellez r‚guliŠrement cette
 proc‚dure.
}

Procedure AniCur;
Var
 Time:Byte;
 Show:Boolean;
 XB,YB,MB:Word;
 {$IFDEF Win32}
  CharCurrCube:Char Absolute CurrCube;
 {$ENDIF}
Begin
 OldBackKbd;
 If(Focused)Then Begin{ Curseur ouvert ? }
  Time:=(GetRawTimerB and$F)shr 1;
  If(CurType=curCK64)Then Time:=Time and 1;
  {$IFDEF Win32}
   CharCurrCube:=GetChr(GetXCurPos,GetYCurPos);
  {$ELSE}
   Char(CurrCube):=GetChr(GetXCurPos,GetYCurPos);
  {$ENDIF}
  If(OldTime<>Time)Then Begin
   GetMouseSwitch(XB,YB,MB);
   Show:=(IsShowMouse)and(LastMouseX=GetXCurPos)and(LastMouseY=GetYCurPos);
   If(Show)Then __HideMousePtr;
   Case(CurType)of
    curCoco3:PutTxtLuxe(GetXCurPos,GetYCurPos,Char(CurrCube),curCoco3Attr[Time]);
             {SetAttr(XCur,YCur,curCoco3Attr[Time]);}
    curCK64:Case(Time)of
     0:If Char(CurrCube)in[#0,' ',#255]Then SetChr(GetXCurPos,GetYCurPos,'Û')
                                       Else SetChr(GetXCurPos,GetYCurPos,' ');
     1:SetChr(GetXCurPos,GetYCurPos,Char(CurrCube));
    End;
   End;
   If(Show)Then __ShowMousePtr;
   OldTime:=Time;
  End;
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Proc‚dure DoneDrv                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de de r‚initialiser le pilote de mode vid‚o
 actuellement utilis‚.


 Remarque
 ÍÍÍÍÍÍÍÍ

   ş Dans un mode en  256 couleurs,  les couleurs de 0 … 63 et 252 …
     255 sont r‚serv‚es lan‡ant disponible un nombre de 188 couleurs
     entre 64 et 251 aux applications dans lequel 128 sont … nouveau
     r‚serv‚ afin d'offrir la possibilit‚ de ®TrueColor¯ en 7 bits …
     partir de l'emplacement 64 … 191. Donc les besoins personnelles
     ne peuvent ˆtre que de 192 … 251!
}

Procedure DoneDrv;
Const
 PaletteBlue:Array[0..3]of RGB=(
  (R:0;G:0;B:64),
  (R:0;G:0;B:128),
  (R:0;G:0;B:192),
  (R:0;G:0;B:255)
 );
 PalBlue:Array[0..15]of RGB=(
  (R:$F0;G:$F0;B:$F0),
  (R:224;G:224;B:232),
  (R:208;G:208;B:224),
  (R:192;G:192;B:216),
  (R:176;G:176;B:208),
  (R:160;G:160;B:200),
  (R:144;G:144;B:192),
  (R:128;G:128;B:184),
  (R:112;G:112;B:176),
  (R:96; G:96; B:168),
  (R:80; G:80; B:160),
  (R:64; G:64; B:152),
  (R:48; G:48; B:144),
  (R:32; G:32; B:132),
  (R:16; G:16; B:128),
  (R:0;  G:0;  B:120)
 );
Var
 I:Byte;
 W:Word;
 L:LongInt;
 Pal:Array[0..15]of RGB;
Begin
{$IFDEF Autonome}
  FreeHeap(32768 shr 4);
  ASM
   MOV AX,$5800
   INT $21
   MOV W,BX
   MOV AX,$5801
   MOV BX,2
   INT $21
  END;
 {$ENDIF}
 {$IFDEF Adele}Adele.{$ELSE}Chantal.{$ENDIF}Init;
 {$IFDEF Autonome}
  ASM
   MOV AX,05801h
   MOV BX,W
   INT 021h
  END;
  {$IFDEF Real}
   MaxExpandHeap;
  {$ENDIF}
 {$ENDIF}
 {$IFNDEF Adele}
  SetDefaultIcon;
 {$ENDIF}
 {$IFNDEF __Windows__}
  VramSetOff;
 {$ENDIF}
 CurrMtx:='';
 _FreeMemory(Pointer(CurBuf),CurBufSize);
 If(IsEGA)Then Begin
  If(IsGraf)Then Begin
   { ATTENTION! Il est trŠs important de reprogrammer les palettes des 16
    premiŠres couleurs … partir de la carte EGA ou post‚rieur ‚tant donn‚
    que la plupart des cartes vid‚os de la fin des ann‚es 1990, ne le font
    pas...
   }
   SetPalRGB(DefaultRGB,0,16);
   If GetBitsPerPixel>=8Then Begin{InitPalVGA}
    SetPalRGB(PalBlue,16,16);
    For I:=0to 15do Begin
     Pal[I].R:=I shl 4;
     Pal[I].G:=I shl 4;
     Pal[I].B:=I shl 4;
    End;
    SetPalRGB(Pal[0],32,16);
    For I:=0to 15do Begin
     Pal[I].R:=(15-I)shl 4;
     Pal[I].G:=(15-I)shl 4;
     Pal[I].B:=(I shl 4)+(15-I)shl 4;
    End;
    SetPalRGB(Pal[0],48,16);
      { Simulation d'une palette en 7 bits: 3 verts + 2 rouges + 2 bleues }
     {  7 6 5 4 3 2 1 0          }
     { ÚÄÂÄÂÄÂÄÂÄÂÄÂÄÂÄ¿         }
     { ³0³ ³ ³ ³ ³ ³ ³ ³         }
     { ÀÄÁÂÁÂÁÂÁÂÁÂÁÂÁÂÙ         }
     {    ³ ³ ³ ³ ³ ÀÄÁÄÄ> Bleu  }
     {    ³ ³ ÀÄÁÄÁÄÄÄÄÄÄ> Vert  }
     {    ÀÄÁÄÄÄÄÄÄÄÄÄÄÄÄ> Rouge }
    For I:=0to 127do Begin
     SetPaletteRGB(64+I,(I and$60)shl 1,(I shr 2)shl 5,I shl 6);
    End;
    SetPalRGB(PaletteBlue,252,4);
     { End InitPalVGA}
    L:=Mul2Word(BytesPerLine,NmYPixels);
    If(GetVideoMemory shr 16>4)and(NmXPixels>360)Then Begin
     If Not(OS2)Then Begin { Sous le systŠme d'exploitation OS/2, il
                             n'y a aucun restitution de la partie invisible
                             du mode vid‚o et donc la partie que
                             l'application utiliserait normalement pour
                             sauvegarder des images se retrouve perdu!!!!}
      If Win=0Then Begin
       {$IFNDEF __Windows__}
        If(DriverModel=drvVGA256)Then DefineVram(262144shr 16,L)
                                 Else DefineVram(GetVideoMemory shr 16,L);
       {$ENDIF}
      End;
     End;
    End;
   End;
  End;
 End
  Else
 Begin
  {$IFDEF FLAT386}
  {$ELSE}
   If Seg(GetVideoTxtMtxPtr^)shr 12=$FThen SetTxtMtx(AllocFont(4,MtxSize))
    Else
   Begin
    {$IFNDEF HaltErr}SetTxtMtx(Ptr($FFA6,$E));{$ENDIF}
    GetSysErr:=errMtxOutOfMem;
   End;
  {$ENDIF} 
 End;
 If(IsGraf)Then Begin
  CurBufSize:=GetSizeSmlImg(0,0,31,31);
  CurBuf:=MemNew(CurBufSize);
  If(CurBuf=NIL)Then GetSysErr:=errVidAllocCur;
  If BitsPerPixel=1Then CurType:=curCK64
                   Else CurType:=curCoco3
 End
  Else
 CurType:=curTxt;
 If(FirstTime)Then Begin
  { Si c'est la premiŠre fois, il faut fixer la routine permettant le
    clignotement du curseur...}
  OldBackKbd:=_BackKbd;
  _BackKbd:=AniCur;
 End;
 FirstTime:=False;
 DrvLoad:=True;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Fonction GetCurrMtx                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de connaŒtre l'adresse d'une police de caractŠres
 se trouvant dans le BIOS des cartes vid‚os EGA, VGA ou SVGA.


 Remarque
 ÍÍÍÍÍÍÍÍ

  ş Certaine  carte  vid‚o  comme  ®Matrox¯  et  ®ATI¯ ne  supportent pas
    correctement cette fonction et retourne soit l'adresse d'une mauvaise
    police  ou  carr‚ment  une  adresse  incorrecte.  Il  peut  donc ˆtre
    pr‚f‚rable de charger  une police manuellement  en m‚moire plut“t que
    d'utiliser cette fonction.
}

Function GetCurrMtx(Var Height:Byte):Pointer;
Var
 _BH:Byte;
Begin
 {$IFDEF FLAT386}
 {$ELSE}
  Case(Height)of
   0..7: Exit;
   8..10: _BH:=$03;
   13..14: _BH:=$02;
   15..16: _BH:=$06;
  End;
  ASM
   MOV AX,$1130
   MOV BH,_BH
   PUSH BP
    INT $10
    MOV BX,BP
   POP BP
   MOV @Result.Word,BX
   MOV @Result.Word[2],ES
   LES DI,Height
   MOV ES:[DI],CL
  END;
 {$ENDIF} 
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Fonction GetPaletteVGA                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de connaŒtre les valeurs des palettes RGB de la
 carte vid‚o VGA ou SVGA dans un mode 2 … 256 couleurs.
}

Procedure GetPaletteVGA(Var Palette:RGB;Start,Num:Word);Near;Assembler;ASM
 {$IFDEF FLAT386}
 {$ELSE}
  MOV AX,01017h
  LES DX,Palette
  MOV BX,Start
  MOV CX,Num
  INT 010h
 {$ENDIF}
END;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure InitDrv                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'initialiser le pilote vid‚o de l'ensemble
 Malte Genesis IV et  V: Alias  Chantal  et AdŠle  en fonction de la
 carte vid‚o actuellement en usage sur la machine.
}

{$IFDEF External}
 Procedure InitDrv;External;
{$ELSE}
 Procedure InitDrv;Begin
  AutoDetect;
  If(DrvLoad)Then Done;
  DrvLoad:=False;
 End;
{$ENDIF}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure LoadDRC                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure charge un pilote sp‚cifi‚ en m‚moire code prˆt … ˆtre
 ex‚cut‚.
}

{$IFDEF Real}
 Procedure LoadDRC(X:Word;x0:Pointer);Near;
 Var
  Handle:Hdl;
  Pos:Array[1..2]of LongInt;
 Begin
  Handle:=FileOpen('SYS:ADELE.RLL',fmRead);
  If(Handle=errHdl)Then Begin
   WriteLn('BibliothŠque ADELE.RLL introuvable!');
   Halt;
  End;
  Inc(X);
  _GetAbsRec(Handle,X shl 2,SizeOf(LongInt)shl 1,Pos);
  _GetAbsRec(Handle,Pos[1],Pos[2]-Pos[1],x0^);
  FileClose(Handle)
 End;
{$ENDIF}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                             Fonction pCenter                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure retourne la coordonn‚e texte X de d'une longueur centrer
 selon l'une des 3 formats choisie.
}

Function pCenter(Len:Byte;Center:CenterType):Byte;Near;
{$IFDEF __Windows__}
 Begin
  Case(Center)of
   __Left__:pCenter:=0;
   __Justified__:pCenter:=(NmXTxts-Len)shr 1;
   __Right__:pCenter:=MaxXTxts-Len;
  End;
 End;
{$ELSE}
 Assembler;ASM
  CALL NmXTxts
  MOV CL,Len
  MOV BL,Center
  AND BX,3
  SHL BX,1
  JMP @Label.Word[BX]
 @Label:
  DW Offset @Left
  DW Offset @Justified
  DW Offset @Right
  DW Offset @End
 @Left:
  XOR AX,AX
  JMP @End
 @Justified:
  SUB AL,CL
  SHR AL,1
  JMP @End
 @Right:
  DEC AX
  SUB AL,CL
 @End:
 END;
{$ENDIF}


Function GetCenterBox(X1,X2:Byte;Center:CenterType;Const Msg:String):Byte;
{$IFDEF __Windows__}
 Begin
  Case(Center)of
   __Left__:GetCenterBox:=X1;
   __Justified__:GetCenterBox:=X1+(((X2-X1+1)-Length(Msg))shr 1);
   __Right__:GetCenterBox:=X2-Length(Msg);
  End;
 End;
{$ELSE}
 Assembler;ASM
  LES DI,Msg
  MOV CL,ES:[DI]
  MOV BL,Center
  AND BX,3
  SHL BX,1
  JMP @Label.Word[BX]
 @Label:
  DW Offset @Left
  DW Offset @Justified
  DW Offset @Right
  DW Offset @End
 @Left:
  MOV AL,X1
  JMP @End
 @Justified:
  MOV BL,X1
  MOV AL,X2
  SUB AL,BL
  CMP CL,AL
  JA  @1
  INC AL
  SUB AL,CL
  SHR AL,1
  ADD AL,BL
  JMP @End
 @1:
  MOV AL,BL
  JMP @End
 @Right:
  MOV AL,X2
  SUB AL,CL
 @End:
 END;
{$ENDIF}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure PutChr                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure est la sous-traŒtance de la proc‚dure ®PutFont¯, elle
 affiche un caractŠre contenu dans un tampon.
}

Procedure PutChr;
Var
 I,J,K,L,Kr:Byte;
Begin
 For I:=0to 2do For J:=0to Len-1do For K:=0to 7do If(Buffer[I*Len+J]shr K)and 1=1Then Begin
  L:=((2-I)shl 3)+K;
  If Not(FontDegraded)Then Kr:=0 Else
  If DegradLen=8Then Kr:=L div 3 else Kr:=(L shl 1)div 3;
  PutFillBox(X+J*SizeMulFont,Y+(Height-L)*SizeMulFont,
             X+(J+1)*SizeMulFont-1,Y+(Height-L+1)*SizeMulFont-1,
             GraphColor+Kr);
 End;
End;

{$IFNDEF Adele}
{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Proc‚dure PutIcon                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'afficher un ic“ne sp‚cifier … l'‚cran avec
 la couleur sp‚cifier … la position d‚sir‚e.
}

Procedure PutIcon(X,Y:Byte;Const S:String;Attr:Byte);Near;Begin
 PutTxtLuxe(X,Y,S,Attr)
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                      Proc‚dure SetDefaultGraphIcon                Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure fixe les ic“nes graphiques en ‚cran texte … utiliser
 par d‚faut lorsqu'on  appellera  les  proc‚dures  filles  d'affichage
 d'Ic“ne.
}

Procedure SetDefaultGraphIcon;Begin
 UnselIcon:=#19#20;        { Ic“ne de d‚selection }
 SelIcon:=#21#22;          { Ic“ne de s‚lection }
 CloseIcon:=#8#9;          { Ic“ne de fermeture }
 ZoomIcon:=#12#13;         { Ic“ne de d'expansion }
 UpIcon:=#10#11;           { Ic“ne de flŠche vers le haut }
 DownIcon:=#12#13;         { Ic“ne de flŠche vers le bas }
 LeftIcon:=#17#9;          { Ic“ne de flŠche vers la gauche }
 RightIcon:=#8#16;         { Ic“ne de flŠche vers la droite }
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Proc‚dure SetDefaultIcon                   Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure fixe les ic“nes d'‚cran texte … utiliser par d‚faut
 lorsqu'on appellera les proc‚dures filles d'affichage d'Ic“ne.
}

Procedure SetDefaultIcon;Begin
 UnselIcon:='( )';         { Ic“ne de d‚selection }
 SelIcon:='('#7')';        { Ic“ne de s‚lection }
 CloseIcon:=' - ';         { Ic“ne de fermeture }
 ZoomIcon:=' '#31' ';      { Ic“ne de d'expansion }
 LeftIcon:='<';            { Ic“ne de flŠche vers la gauche }
 RightIcon:='>';           { Ic“ne de flŠche vers la droite }
 UpIcon:=#$18;             { Ic“ne de flŠche vers le haut }
 DownIcon:=#$19;           { Ic“ne de flŠche vers le bas }
End;
{$ENDIF}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure UpDatePos                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Portabilit‚: Local


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'effectuer une mise … jour de la position du
 pointeur d'‚cran texte.
}

Procedure UpDatePos;Near;Begin
 If(VidBnkSwitch.XP>MaxXTxts)Then ASM
  CALL NmXTxts
  MOV BH,AL
  MOV AL,VidBnkSwitch.XP
  XOR AH,AH
  DIV BH
  ADD VidBnkSwitch.YP,AL
  MOV VidBnkSwitch.XP,AH
 END;
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ Proc‚dures et fonctions publique ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure BarSelHor                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Portabilit‚: Global


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure d'afficher une barre de s‚lection horizontal avec la
 couleur d'attribut sp‚cifier aux coordonn‚es sp‚cifi‚e.
}

Procedure BarSelHor;
Var
 I:Byte;
Begin
 For I:=X1 to(X2)do PutTxtLuxe(I,Y,GetChr(I,Y),Attr)
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Proc‚dure BarSelVer                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Portabilit‚: Global


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure d'afficher une barre de s‚lection vertical avec la
 couleur d'attribut sp‚cifier aux coordonn‚es sp‚cifi‚e.
}

Procedure BarSelVer;
Var
 J:Byte;
Begin
 For J:=Y1 to(Y2)do SetAttr(X,J,Attr)
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Proc‚dure BarSpcHorRelief                Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Portabilit‚: Global


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de tracer une barre de relief … la position
 texte sp‚cifier en tenant conte de l'attribut sp‚cifi‚e.
}

Procedure BarSpcHorRelief;Begin
 BoxRelief(X1,Y,X2,Y,Attr);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Proc‚dure GraphBoxRelief              Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Portabilit‚: Global


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de tracer une boŒte de relief … la position
 texte sp‚cifier en tenant conte de l'attribut sp‚cifi‚e.
}

Procedure GraphBoxRelief(GX1,GY1,GX2,GY2:Word;Attr:Byte);Begin
 Case Attr and$F0of
  $70,$B0:_SetKr($F);
  0:If Attr and$F=2Then _SetKr(7)
                   Else _SetKr(8);
  Else _SetKr(7);
 End;
 _Ln(GX1,GY1,GX1,GY2);
 _LnHor(GX1,GY1,GX2);
 Case Attr and$F0of
  $B0:_SetKr(3);
  0:If Attr and$F=1Then _SetKr(8)
                   Else _SetKr($F);
  Else _SetKr(8);
 End;
 _Ln(GX2,GY1+1,GX2,GY2);
 _LnHor(GX1+1,GY2,GX2);
End;

Procedure LuxeBox(X,Y:Byte);
Var
 R:TextBoxRec;
 G:GraphBoxRec; { Coordonn‚e graphique }
Begin
 ASM
   {R.X1:=X;R.Y1:=Y;R.Y2:=Y;}
  MOV AL,X
  MOV AH,Y
  MOV Word Ptr R.X1,AX
  MOV Word Ptr R.X2,AX
 END;
 CoordTxt2Graph(R,G);
 GraphBoxRelief(G.X1+2,G.Y1+2,G.X1+13,G.Y2-2,0);
 GraphBoxRelief(G.X1+5,G.Y1+5,G.X1+10,G.Y2-5,0);
End;

Procedure BoxRelief;
Var
 G:GraphBoxRec;
 T:TextBoxRec;
Begin
 While(X1>NmXTxts)do Begin
  Dec(X1,NmXTxts);
  Dec(X2,NmXTxts);
  Inc(Y1)
 End;
 ASM
   {T.X1:=X1;T.Y1:=Y1;T.X2:=X2;T.Y2:=Y2;}
  MOV AL,X1
  MOV AH,Y1
  MOV Word Ptr T.X1,AX
  MOV AL,X2
  MOV AH,Y2
  MOV Word Ptr T.X2,AX
 END;
 CoordTxt2Graph(T,G);
 __GraphBoxRelief(G,Attr);
End;

Procedure BarSpcHorReliefExt(X1,Y,X2,Attr:Byte);
Var
 T:TextBoxRec;
 G:GraphBoxRec;
Begin
 If(IsGrf)and(HeightChr>8)Then Begin
  ASM
   {T.X1:=X1;T.Y1:=Y;T.X2:=X2;T.Y2:=Y;}
   MOV AL,X1
   MOV AH,Y
   MOV Word Ptr T.X1,AX
   MOV AL,X2
   MOV Word Ptr T.X2,AX
  END;
  CoordTxt2Graph(T,G);
  Dec(G.X1);Inc(G.Y1,((HeightChr-8)shr 1)-2);
  Inc(G.X2);G.Y2:=G.Y1+11;
  Case Attr and$F0of
   $B0:_SetKr(3);
   Else _SetKr(8);
  End;
  _Ln(G.X1,G.Y1,G.X1,G.Y2);
  _LnHor(G.X1,G.Y1,G.X2);
  Case Attr and$F0of
   $70,$B0:_SetKr($F);
   Else _SetKr(7);
  End;
  _Ln(G.X2,G.Y1+1,G.X2,G.Y2);
  _LnHor(G.X1+1,G.Y2,G.X2);
 End;
End;

Procedure BarSpcHorShade;Begin
 BarSpcHor(X1,Y,X2,Attr);
 SetCube(X2+1,Y,'Ü',BackAttr);
 {$IFNDEF Adele}Video.{$ENDIF}BarTxtHor(X1+1,Y+1,X2+1,'ß',BackAttr)
End;

{$IFNDEF Adele}
 Procedure BarSpcVer;
 Var
  J:Byte;
 Begin
  If(IsGraf)Then PutFillBox(X shl 3,GetRawY(Y1),(X shl 3)+7,GetRawY(Y2+1)-1,Attr shr 4)
  Else For J:=Y1 to Y2 do SetSpc(X,J,Attr)
 End;

 Procedure BarTxtHor;
 Var
  I:Byte;
 Begin
  For I:=X1 to(X2)do SetCube(I,Y,Chr,Attr)
 End;
{$ENDIF}

Procedure BarTxtVer;
Var
 J:Byte;
Begin
 For J:=Y1 to(Y2)do SetCube(X,J,Chr,Attr)
End;

{Procedure ClrEol;Begin
 BarSpcHor(VidBnkSwitch.XP,VidBnkSwitch.YP,MaxXTxts,Attr)
End;}

Procedure ClrEol;Assembler;ASM
 MOV AX,Word Ptr VidBnkSwitch.XP
 PUSH AX
 MOV AL,AH
 PUSH AX
 CALL MaxXTxts
 PUSH AX
 PUSH Word Ptr Attr
 CALL BarSpcHor
END;

Procedure ClrLn;Begin
 BarTxtHor(0,Y,MaxXTxts,Chr,Attr)
End;

{ Cette proc‚dure permet d'effacer l'‚cran avec la couleur d'affichage
 noir sans toutefois effacer les autres pages.
}

{$IFDEF Real}
 Procedure ClrScrBlack;Assembler;ASM
  {$IFOPT G+}
   PUSH 7
  {$ELSE}
   MOV AX,7
   PUSH AX
  {$ENDIF}
  CALL ClrScr
 END;
{$ELSE}
 Procedure ClrScrBlack;
 {$IFDEF DPMI}
  External'MALTE'index mfClrScrBlack;
 {$ELSE}
  Begin
   ClrScr(7);
  End;
 {$ENDIF}
{$ENDIF}

Procedure CopyBoxTxt;
Var
 J:Byte;                         { Compteur de boucle }
 Delta:Word;                     { Distance … parcourir }
 ScrPtr:Pointer;                 { Pointeur sur la m‚moire d'‚cran }
 ScrOffset:Word Absolute ScrPtr; { Offset temporaire de la m‚moire d'‚cran }
Begin
 {$IFDEF FLAT386}
 {$ELSE}
  If(IsVideoDirectAccess)or(IsGrf)Then Begin
   Delta:=(X2-X1+1)shl 1;
   ScrOffset:=(X1+(Y1*NmXTxts))shl 1;
   ASM
    {If(IsGrf)Then ScrPtr:=Ptr(GetVideoSegBuf,ScrOffset)
              Else ScrPtr:=Ptr(GetVideoSeg,ScrOffset);}
    CALL IsGrf
    OR  AL,AL
    JZ  @2
    CALL GetVideoSegBuf { Graphique }
    JMP @3
@2: CALL GetVideoSeg    { Texte }
@3: MOV Word Ptr ScrPtr[2],AX
   END;
   For J:=0to(Y2-Y1)do Begin
    MoveLeft(ScrPtr^,Buffer,Delta);
    ASM
     CALL NmXTxts
     SHL AX,1
     ADD Word Ptr ScrPtr,AX
     MOV AX,Delta
     ADD Word Ptr Buffer[0],AX
    END;
   End;
  End;
 {$ENDIF}
End;

Procedure ClrBoxTxt(X1,Y1,X2,Y2:Byte);
Var
 J:Byte;                         { Compteur de boucle }
 Delta:Word;                     { Distance … parcourir }
 ScrPtr:Pointer;                 { Pointeur sur la m‚moire d'‚cran }
 ScrOffset:Word Absolute ScrPtr; { Offset temporaire de la m‚moire d'‚cran }
Begin
 {$IFDEF FLAT386}
 {$ELSE}
  If(IsVideoDirectAccess)or(IsGrf)Then Begin
   Delta:=(X2-X1+1)shl 1;
   ScrOffset:=(X1+(Y1*NmXTxts))shl 1;
   ASM
    {If(IsGrf)Then ScrPtr:=Ptr(GetVideoSegBuf,ScrOffset)
              Else ScrPtr:=Ptr(GetVideoSeg,ScrOffset);}
    CALL IsGrf
    OR  AL,AL
    JZ  @2
    CALL GetVideoSegBuf { Graphique }
    JMP @3
@2: CALL GetVideoSeg    { Texte }
@3: MOV Word Ptr ScrPtr[2],AX
   END;
   For J:=0to(Y2-Y1)do Begin
    FillClr(ScrPtr^,Delta);
    ASM
     CALL NmXTxts
     SHL AX,1
     ADD Word Ptr ScrPtr,AX
     MOV AX,Delta
    END;
   End;
  End;
 {$ENDIF}
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure DoneLuxeVideo                    Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de mettre fin au mode d'affichage texte de luxe
 supportant des caractŠres sp‚ciaux d'application.
}

Procedure DoneLuxeVideo;
Var
 Font:Boolean;
 HeightChr:Byte;
Begin
 Font:=VideoFontFound;
 HeightChr:=GetHeightChr;
 If(IsKr)Then ASM
  MOV AX,1101h
  MOV BL,0
  CMP Font,BL
  JE  @End
  MOV DH,HeightChr
  CMP DH,8
  JNE @8
  MOV AL,2
@8:
  CMP DH,16
  JNE @16
  MOV AL,4
@16:
  INT 10h
@End:
 END;
 SetVideoMode(vmTxtDef);
 DoneVideo;
 ASM
  CALL IsVGA
  CMP AL,False
  JE  @NoEmulCursor
  MOV AX,1200h
  MOV BL,34h
  INT 10h
@NoEmulCursor:
 END;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure DoneVideo                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de mettre fin au module d'affichage courant.
}

Procedure DoneVideo;Begin
 InitDrv;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Proc‚dure DrawPoly                             Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  La proc‚dure ®DrawPoly¯  permet de dessiner les contours d'un polygone.  Le
 1ier paramŠtre indique que le nombre de pixels … joindre, le 2iŠme donne les
 coordonn‚es de ces points. Il a la forme: ®P:Array[1..Num]of TPointType¯. Le
 type ®TPointType¯ est d‚fini  dans l'unit‚ ®Systex¯:  ®TPointType=Record  X,
 Y:Word;End;¯. Le 3iŠme et dernier paramŠtre permet de d‚finir la couleur des
 lignes trac‚s … l'‚cran.


 Remarques
 ÍÍÍÍÍÍÍÍÍ

  ş Il n'est pas  n‚cessaire  de fournir un point  de plus  le nombre de
    sommets car le dernier point et joint au 1ier.

  ş Cette proc‚dure existe surtout  pour permettre une portabilit‚  avec  les
    autres interfaces graphiques disponible sur le march‚.
}

Procedure DrawPoly;
Var
 J:Integer;
Begin
 For J:=0to Num-1do PutLn(P[J].X,P[J].Y,P[J+1].X,P[J+1].Y,Kr);
 PutLn(P[0].X,P[0].Y,P[Num-1].X,P[Num-1].Y,Kr);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Proc‚dure FillLosange                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de tracer un losange plein avec comme largeur …
 partir de son centre le rayon d‚finit par la variable de param‚trage de
 mˆme nom. La figure est un losange r‚gulier parfaitement sym‚trique.
}

Procedure FillLosange(X,Y,Rayon,Kr:Word);
Var
 I:Word;
Begin
 Dec(Y,Rayon);
 For I:=0to Rayon-1do Begin
  PutLnHor(X-I,Y,X+I,Kr);
  Inc(Y)
 End;
 While Rayon>0do Begin
  PutLnHor(X-Rayon,Y,X+Rayon,Kr);
  Inc(Y);Dec(Rayon)
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure FillOctogone                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de tracer un octogone plein avec une des arrŠtes
 de longueur d‚finit par la variable de param‚trage  ®Arrete¯.  La figure
 est un octogone r‚gulier parfaitement sym‚trique.
}

Procedure FillOctogone(X,Y,Arrete,Kr:Word);
Var
 Height,Half,X1,X2,J:Word;
Begin
 Half:=Arrete shr 1;
 Height:=Arrete+Half;
 Dec(Y,Height);
 X1:=X-Half;X2:=X+Half;
 For J:=0to Half-1do Begin
  PutLnHor(X1,Y,X2,Kr);
  Dec(X1);Inc(X2);Inc(Y)
 End;
 For J:=0to Arrete-1do Begin
  PutLnHor(X1,Y,X2,Kr);
  Inc(Y)
 End;
 For J:=0to Half-1do Begin
  PutLnHor(X1,Y,X2,Kr);
  Inc(X1);Dec(X2);Inc(Y)
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure FullCur                           Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure affiche un curseur plein lorsqu'il s'agit d'un ‚cran de
 texte.


 Remarques
 ÍÍÍÍÍÍÍÍÍ

  ş Cette proc‚dure est inactif en mode graphique, il est donc obliger de
    manipuler le  curseur d'une  autre fa‡on,  il le fixe  donc en format
    du Commodore 64K.

  ş Cette proc‚dure n'affecte  pas la forme du curseur lorsque le curseur
    est en  mode Coco 3 (curCoco3) ou  Commodore 64 Ko (curCK64)  en mode
    texte.
}

Procedure FullCur;Begin
 If(IsGraf)Then CurType:=curCK64;
 SetCur(0,HeightChr-1)
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure GetBorder                           Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure change le format de la bordure du cadre … ˆtre utilis‚.


 Remarque
 ÍÍÍÍÍÍÍÍ

  ş Le format ins‚r‚ par cette proc‚dure affectera la prochaine utilisation
    des proc‚dures ®PutBorderUnKr¯ et ®PutFillBorder¯.
}

Procedure GetBorder;Assembler;ASM
 {$IFDEF FLAT386}
 {$ELSE}
  LES DI,Border
  CLD
  MOV SI,Offset CurBorder
  {$IFDEF G+}
   MOV CX,(TYPE BorderType)shr 1
   REP MOVSW
  {$ELSE}
   MOV CX,TYPE BorderType
   REP MOVSB
  {$ENDIF}
 {$ENDIF} 
END;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Proc‚dure GetCenterTxt                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure retourne les coordonn‚es centrer au centre de l'‚cran d'une
 boŒte de largeur  ®L¯  et de hauteur  ®H¯  dans les couples sup‚rieur gauche
 (X1,Y1) et inf‚rieur droite (X2,Y2).


 Procedure GetCenterTxt;Begin
  X1:=(NmXTxts-L)shr 1;
  X2:=X1+L;
  Y1:=(NmYTxts-H)shr 1;
  Y2:=Y1+H;
 End;
}

Procedure GetCenterTxt;
{$IFDEF FLAT386}
 Begin
  X1:=(NmXTxts-L)shr 1;
  X2:=X1+L;
  Y1:=(NmYTxts-H)shr 1;
  Y2:=Y1+H;
 End;
{$ELSE}
 Assembler;ASM
  CALL NmYTxts
  MOV AH,AL
  CALL NmXTxts
  MOV BL,L
  MOV BH,H
  SUB AX,BX
  AND AH,NOT 1
  SHR AX,1
  MOV CX,AX
  LES DI,X1
  STOSB
  LES DI,Y1
  MOV AL,AH
  STOSB
  XCHG AX,CX
  ADD AX,BX
  LES DI,X2
  STOSB
  MOV AL,AH
  LES DI,Y2
  STOSB
 END;
{$ENDIF}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Proc‚dure __GetCenterTxt                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure retourne les coordonn‚es centrer au centre de l'‚cran d'une
 boŒte de largeur  ®L¯  et de hauteur  ®H¯  dans les couples sup‚rieur gauche
 (X1,Y1) et inf‚rieur droite (X2,Y2).


 Procedure __GetCenterTxt(L,H:Byte;Var Q:TextBoxRec);Begin
  Q.X1:=(NmXTxts-L)shr 1;
  Q.X2:=Q.X1+L;
  Q.Y1:=(NmYTxts-H)shr 1;
  Q.Y2:=Q.Y1+H;
 End;
}

Procedure __GetCenterTxt;
{$IFDEF FLAT386}
 Begin
  TextBoxRec(Q).X1:=(NmXTxts-L)shr 1;
  TextBoxRec(Q).X2:=TextBoxRec(Q).X1+L;
  TextBoxRec(Q).Y1:=(NmYTxts-H)shr 1;
  TextBoxRec(Q).Y2:=TextBoxRec(Q).Y1+H;
 End;
{$ELSE}
 Assembler;ASM
  CALL NmYTxts
  MOV AH,AL
  CALL NmXTxts
  MOV BL,L
  MOV BH,H
  SUB AX,BX
  AND AH,NOT 1
  SHR AX,1
  MOV CX,AX
  CLD
  LES DI,Q
  STOSW
  XCHG AX,CX
  ADD AX,BX
  STOSW
 END;
{$ENDIF}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Proc‚dure GetCurType                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction retourne le type de curseur affich‚ … l'‚cran parmi les
 constantes suivantes contenu dans l'unit‚ ®Systex¯:
 ÚÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³ Constante  ³ Description                                            ³
 ÆÍÍÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍµ
 ³ curTxt=0   ³ D‚signe le curseur par d‚faut du mode texte.           ³
 ³ curCoco3=1 ³ D‚signe le curseur par d‚faut du mode graphique (genre ³
 ³            ³ de l'ordinateur couleur 3 (Coco 3)).                   ³
 ³ curCK64=2  ³ D‚signe le curseur de type ®Commodore 64K¯, un curseur ³
 ³            ³ de type bloc.                                          ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}

Function GetCurType;Assembler;ASM
 MOV AL,CurType
END;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Fonction GetKr                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction demande quel est la couleur courante actuellement en
 usage con‡ernant l'affichage des caractŠres en style texte.
}

Function GetKr;Assembler;ASM
 MOV AL,NorColor
END;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Fonction GetLastKr                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction demande quel est l'ancienne couleur courante ayant ‚t‚
 en usage pour l'affichage des caractŠres en style ‚cran de texte.
}

Function GetLastKr;Assembler;ASM
 MOV AL,LastColor
END;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Fonction GetNmLnMsg                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de calculer le nombre de ligne estimer d'une
 chaŒne de caractŠres devant entr‚e dans une fenˆtre.
}

Function GetNmLnMsg;
Var
 XS,a,la,I:Byte;
Begin
 XS:=(X2-X1)+1;
 ASM
  MOV @Result,0
 END;
 a:=0;la:=$FF;
 While(Length(Msg)-a>=XS)do Begin
  I:=a+XS;
  While((Msg[I-1]>' ')and(Not(Msg[I-1]in['-','\','/'])))and(I>a)do Dec(I);
  If(la=a)Then Break;
  la:=a;a:=I-1;
  ASM
   INC @Result
  END;
 End;
 ASM
  INC @Result
 END;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Fonction GetShade                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de connaŒtre l'‚tat de l'indicateur d'ombre,
 s'il est autoris‚ d'afficher  une ombre  … la droite et en bas d'un
 cadre.
}

Function GetShade;Assembler;ASM
 {$IFDEF Real}
  MOV AL,True
 {$ELSE}
  MOV AL,VidBnkSwitch.Shade
 {$ENDIF}
END;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure SetShade                  Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de fixer l'‚tat de l'indicateur d'ombre.
 Celui-ci permet d'afficher automatiquement une ombre … la droite
 et en bas d'un cadre.
}

Procedure SetShade;Assembler;ASM
 MOV AL,X
 {$IFDEF Real}
  MOV Byte Ptr GetShade[1],AL
 {$ELSE}
  MOV VidBnkSwitch.Shade,AL
 {$ENDIF}
END;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure GetPaletteRGB                    Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de connaŒtre la valeur des palettes de couleurs
 … partir d'une position sp‚cifier et en copiant le nombre sp‚cifier.
}

Procedure GetPaletteRGB;
Var
 I:Word;
Begin
 If BitsPerPixel>=15Then MoveLeft(DefaultRGB[Start],Pal,Num*3)
  Else
 Begin
  If(PrimCardCat>=cvnVGA)Then GetPaletteVGA(RGB(Pal),Start,Num)
	 		 Else MoveLeft(DefaultRGB[Start],Pal,Num*3);
  If Not(GetVideoBitsDac in[0,8])Then For I:=Start to Start+(Num-1)do Begin
   TRGB(Pal)[I].R:=TRGB(Pal)[I].R shl(8-GetVideoBitsDac);
   TRGB(Pal)[I].G:=TRGB(Pal)[I].G shl(8-GetVideoBitsDac);
   TRGB(Pal)[I].B:=TRGB(Pal)[I].B shl(8-GetVideoBitsDac);
  End;
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Fonction GetXTxtsPos                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de connaŒtre la position horizontal courante du
 pointeur d'affichage texte.
}

Function GetXTxtsPos;Assembler;ASM
 MOV AL,VidBnkSwitch.XP;
END;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Fonction GetYTxtsPos                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de connaŒtre la position vertical courante du
 pointeur d'affichage texte.
}

Function GetYTxtsPos;Assembler;ASM
 MOV AL,VidBnkSwitch.YP;
END;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure InitVideo                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'initialiser le pilote d'affichage en fonction
 du mode vid‚o actuellement en utilisation.
}

Procedure InitVideo;
Var
 Info1:PIV;
 M:Byte;
 {OldMtx:Pointer; }
Begin
 {$IFDEF __Windows__}
  InitWinCrt;
 {$ELSE}

{  OldMtx:=GetVideoTxtMtxPtr;
  FreeMem(OldMtx,MtxSize);
  InitMouse;}

  InitDrv;
  {$IFDEF Real}
   GetPhysicalInfoVideo(Info1);
  {$ENDIF}
  M:=viInitVideo;
  {$IFDEF Adele}
   If(M>drvBios)Then Begin
    If(CPU>=cpu80286)Then Inc(M);
    If(CPU>=cpui386)Then Inc(M);
   End;
  {$ELSE}
   If(M=drvSVGA)and(Up32Bits)Then Inc(M);
  {$ENDIF}
  DriverModel:=M;
  {$IFDEF Real}
   LoadDRC(M,@{$IFDEF Adele}Adele{$ELSE}Chantal{$ENDIF}.Init);
   SetPhysicalInfoVideo(Info1);
  {$ENDIF}
  DoneDrv;
 {$ENDIF}
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure InitVideoDeluxe                  Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'initialiser le pilote d'affichage en fonction
 du  mode  vid‚o  actuellement en utilisation  en utilisant  en plus les
 polices d'application sp‚cial.
}

Procedure InitVideoDeluxe;Begin
 InitVideo;
 SetLuxe;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Fonction LenTyping                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de savoir si la carte d‚tecter peut ˆtre consid‚r‚
 comme de classe Super VGA. Pour une VGA simple ou Super VGA ne supportant
 aucune mode de plus que la VGA, il retourne Faux.
}

Function IsSVGA;Begin
 IsSVGA:=GetVideoCardCat>=cvnSvga;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                             Fonction LenTyping                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction retourne la longueur d'une chaine de caractŠres ASCIIZ sans
 calculer les caractŠres: ®^¯, ®|¯, ®~¯ ou inf‚rieur au code ASCII 32.
}

Function LenTyping;
Var
 I:Word;
Begin
 ASM
  XOR AX,AX
  MOV I,AX
  MOV @Result,AX
 END;
 While Msg^[I]<>#0do Begin
  If Not(Msg^[I]in[#1..#31,'|','^','~'])Then ASM
   INC @Result;
  END;
  Inc(I);
  If I>4096Then Break;
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                             Fonction LoadMtx                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet  de charger  une nouvelle sorte de police de texte
 standard dans la m‚moire de la carte vid‚o si en mode texte ou en m‚moire
 conventionnel s'il s'agit d'un mode graphique.
}

Function LoadMtx;
Var
 Handle:Hdl;
 I,S,Sz,H:Word;
 TPtr:^TByte;
 HeightChr:Byte;
Begin
 {$IFNDEF __Windows__}
 LoadMtx:=False;
 TPtr:=GetVideoTxtMtxPtr;
 If PtrRec(TPtr).Seg<$A000Then FreeMemory(GetVideoTxtMtxPtr,HeightChr shl 8);
 If Path2Name(Path)<>'STD'Then
  Path:=FSearch(Path,';'+Path2Dir(FileExpand(Path))+';'+MaltePath+'FNT;'+MaltePath+'FONT');
 If(IsGrf)Then Begin
  If Path2Name(Path)='STD'Then Begin
   HeightChr:=GetHeightChr;
   If(Inv)Then Begin
    Sz:=4096;
    TPtr:=GetCurrMtx(HeightChr);
    SetTxtMtx(NewBlock(TPtr^,Sz));
    HeightChr:=GetHeightChr;
   End
    Else
   SetTxtMtx(GetCurrMtx(HeightChr));
   GetSysErr:=0;LoadMtx:=True;
   SetHeightChr(HeightChr);
  End
   Else
  Begin
   Sz:=GetFileSize(Path)+16;
   HeightChr:=Sz shr 8;
   SetHeightChr(HeightChr);
   SetTxtMtx(MemAlloc(Sz));
   If(GetVideoTxtMtxPtr=NIL)Then Exit;
   GetFile(Path,0,Sz,GetVideoTxtMtxPtr^);
   LoadMtx:=GetSysErr=0;
  End;
  If(Inv)Then ASM
    PUSH DS
     CALL GetVideoTxtMtxPtr
     MOV ES,DX
     PUSH ES
     POP DS
     MOV DI,AX
     MOV SI,AX
     MOV CX,Sz
     CLD
@1:  LODSB
     XOR AH,AH
     PUSH CX
      MOV CX,8
@2:   RCL AL,1
      RCR AH,1
      LOOP @2
     POP CX
     MOV AL,AH
     STOSB
     LOOP @1
    POP DS
   END;
  If GetSysErr=0Then CurrMtx:=Path2Name(Path);
 End
  Else
 If(GetVideoCardCat>=cvnEGA)Then Begin
  If Not(IsLuxe)Then S:=0
                Else S:=32;
  If Path2Name(Path)='STD'Then Begin
   TPtr:=GetCurrMtx(Byte(H));
   ASM
    MOV H.Byte[1],0;
   END;
   SetModeMtx;
   For I:=S to 255do Begin
    MoveLeft(TPtr^[I*H],Mem[_A000:I shl 5],H);
    FillClr(Mem[_A000:(I shl 5)+H],32-H);
   End;
  End
   Else
  Begin
   Handle:=FileOpen(Path,fmRead);
   If(Handle=errHdl)Then Exit;
   SetModeMtx;
   Sz:=FileSize(Handle);
   H:=Sz shr 8;
   For I:=S to 255do Begin
    GetRec(Handle,I,H,Mem[_A000:I shl 5]);
    FillClr(Mem[_A000:(I shl 5)+H],32-H);
    If I in[176..223]Then ASM
     MOV AX,_A000
     MOV ES,AX
     MOV BX,I
     MOV CL,5
     SHL BX,CL
     MOV AX,ES:[BX+12]
     MOV ES:[BX+14],AX
    END;
   End;
   FileClose(Handle);
  End;
  SetModeScr;
  CurrMtx:=Path2Name(Path);
  LoadMtx:=True;
 End;
 {$ENDIF}
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Fonction LoadQQF                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de charger une police de caractŠres de format
 complexe … l'int‚rieur de la m‚moire.
}

Function LoadQQF;
Label 1;
Var
 Path:String;
 Index:FontIndexRecord;
 F:SearchRec;
 Handle:Hdl;
 FP:LongInt;
 I:Byte;
Begin
 LoadQQF:=False;
 If(PathFont=Name)Then Begin
  LoadQQF:=True;
  Exit;
 End;
 PathFont:=Name;
 Path:=WildCardSearch('*.QQF',MaltePath+'FONT;'+MaltePath+'FNT;'+MaltePath+';\MALTE\FONT;');
 If Path=''Then Exit;
 I:=Pos('|',Name);
 If I>0Then Begin
  Handle:=FileOpen(Path2Dir(Path)+Left(Name,I-1),fmRead);
  If(Handle<>errHdl)Then Begin
   Name:=Copy(Name,I+1,255);Goto 1
  End
   Else
  Exit;
 End;
 FindFirst(Path,fa,F);
 While SysErr=0do Begin
  Handle:=FileOpen(Path2Dir(Path)+F.Name,fmRead);
  If(Handle<>errHdl)Then Begin
 1:FP:=4;
   _GetAbsRec(Handle,FP,SizeOf(FontIndexRecord),Index);
   Repeat
    If StrUp(Index.Name)=StrUp(Name)Then Begin
     FreeMemory(QQF,QQFSize);
     QQFSize:=Index.Size;QQF:=MemAlloc(QQFSize);
     If(QQF=NIL)Then Exit;
     _GetAbsRec(Handle,Index.PosAbs,Index.Size,QQF^);
     QQFHeight:=Index.Height;LoadQQF:=True;
     FileClose(Handle);
     Exit;
    End;
    Inc(FP,SizeOf(FontIndexRecord));
    _GetAbsRec(Handle,FP,SizeOf(FontIndexRecord),Index);
   Until Index.Name='FIN';
   FileClose(Handle)
  End;
  FindNext(F);
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Proc‚dure Octogone                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de tracer un octogone  vide avec une des arrŠtes
 de longueur d‚finit par la variable de param‚trage  ®Arrete¯.  La figure
 est un octogone r‚gulier parfaitement sym‚trique.
}

Procedure Octogone(X,Y,Arrete,Kr:Word);Var Height,Half,X1,X2,J:Word;Begin
 Half:=Arrete shr 1;Height:=Arrete+Half;Dec(Y,Height);X1:=X-Half;X2:=X+Half;
 PutLnHor(X1,Y,X2,Kr);Inc(Y);Dec(X1);Inc(X2);
 For J:=1to Half-1do Begin
  SetPixel(X1,Y,Kr);SetPixel(X2,Y,Kr);
  Dec(X1);Inc(X2);Inc(Y)
 End;
 For J:=0to Arrete-1do Begin
  SetPixel(X1,Y,Kr);SetPixel(X2,Y,Kr);
  Inc(Y)
 End;
 For J:=0to Half-2do Begin
  SetPixel(X1,Y,Kr);SetPixel(X2,Y,Kr);
  Inc(X1);Dec(X2);Inc(Y)
 End;
 PutLnHor(X1,Y,X2,Kr)
End;

Procedure OutFTxtXY(X,Y:Word;Const S:String;Kr:Word);Begin
 _Move2(X,Y);
 _SetKr(Kr);
 PutFont(S)
End;

Procedure OutSmlTxtXY(X,Y:Word;Const S:String;Attr:Byte);
Var
 I,J,K,L,Masque:Byte;
 Chr:Char;
 W,B:Word;
 Int1Fh:^TByte Absolute {$IFNDEF FLAT386}$0000:{$ENDIF}$007C;
Begin
 If(IsGrf)Then Begin
  {If(Y>=NmYPixels)Then B:=0
  Else} B:=((Y div HeightChr)*NmXTxts+(X shr 3))shl 1;
  For J:=1to Length(S)do Begin
   Chr:=S[J];
   For I:=0to 8-1do Begin
    If Chr>=#$80Then
     Masque:=Int1Fh^[((Byte(Chr)and$7F)shl 3)+I]
    {$IFNDEF NotReal}
     Else
      Masque:=Mtx8x8High[(Byte(Chr)shl 3)+I]
    {$ENDIF};
    Copy8Bin(X,Y+I,Masque,Attr shr 4,Attr and$F);
   End;
   TextCube(W).Chr:=Chr;
   TextCube(W).Attr:=Attr;
   {$IFDEF FLAT386}
   {$ELSE}
    MemW[GetVideoSegBuf:B]:=W;
   {$ENDIF}
   Inc(B,2);Inc(X,8)
  End;
 End;
End;

Procedure OutSmlTxtXYT(X,Y:Word;Const S:String;Attr:Byte);
Var
 I,J,K,L,Masque:Byte;
 Chr:Char;
 W,B:Word;
 Int1Fh:^TByte Absolute {$IFNDEF FLAT386}$0000:{$ENDIF}$007C;
Begin
 If(IsGrf)Then Begin
  {If(Y>=NmYPixels)Then B:=0
  Else} B:=((Y div HeightChr)*NmXTxts+(X shr 3))shl 1;
  For J:=1to Length(S)do Begin
   Chr:=S[J];
   For I:=0to 8-1do Begin
    If Chr>=#$80Then
     Masque:=Int1Fh^[((Byte(Chr)and$7F)shl 3)+I]
    {$IFNDEF NotReal}
     Else
      Masque:=Mtx8x8High[(Byte(Chr)shl 3)+I]
    {$ENDIF};
    CopT8Bin(X,Y+I,Masque,Attr and$F);
   End;
   TextCube(W).Chr:=Chr;
   TextCube(W).Attr:=Attr;
   {$IFDEF FLAT386}
   {$ELSE}
    MemW[GetVideoSegBuf:B]:=W;
   {$ENDIF}
   Inc(B,2);Inc(X,8)
  End;
 End;
End;


Procedure OutSTxtXY;
Var
 I,J:Byte;
Begin
 For I:=2downto 0do Begin
  J:=2-I;
  OutTxtXY(X+I,Y+I,S,Attr and(7*J+(J shr 1)))
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure OutTxtXY                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'afficher la police de caractŠres systŠmes par
 d‚faut (8 x 8, 14 ou 16)  sans affectation la couleur de fond mais avec
 la couleur d'‚criture sp‚cifi‚e … une position texte sp‚cifi‚e.
}

Procedure OutTxtXY;
Var
 I:Byte;
Begin
 For I:=0to Length(S)-1do SetGCubeT(X+(I shl 3),Y,S[I+1],Attr)
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                      Proc‚dure PutQQFCube                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'afficher un caractŠre avec la police de
 caractŠres de  format  ®QQF¯ courante  en ‚cran graphique avec un
 attribut  de  couleur  d'‚criture  et  de fond comme en  ‚cran de
 texte.
}

Procedure PutQQFCube(Var X,Y:Word;Chr:Char;Attr:Byte);Near;
Var
 I,J,XN,YN,B,XG,YG,MX:Word;
 QQFW:^TWord Absolute QQF;
Begin
 B:=QQFW^[Byte(Chr)];
 If B=0Then Exit;
 MX:=QQF^[B];XN:=MX shr 3;XG:=X;YG:=Y;
 If(X+QQF^[B]>NmXPixels)Then Begin
  X:=QQF^[B];Inc(Y,QQFHeight);XG:=0;YG:=Y;
 End
  Else
 Inc(X,QQF^[B]);
 If QQF^[B]and 7<>0Then Begin
  MX:=(XN+1)shl 3;
  Inc(XN)
 End;
 Inc(B);YN:=QQF^[B];Inc(B);
 If QQF^[B]<>0Then Begin
  PutFillBox(XG,YG,XG+MX-1,YG+QQF^[B]-1,Attr shr 4);
  Inc(YG,QQF^[B])
 End;
 Inc(B);
 For J:=0to YN-1do Begin
  For I:=0to XN-1do Begin
   Copy8Bin(XG,YG,QQF^[B],Attr shr 4,Attr and$F);
   Inc(B);Inc(XG,8)
  End;
  Dec(XG,XN shl 3);
  Inc(YG)
 End;
 If(YG<=Y+QQFHeight)Then PutFillBox(XG,YG,XG+MX-1,Y+QQFHeight,Attr shr 4);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure OutTextXY                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'afficher un chaŒne de caractŠres avec la police
 de  caractŠres  de  format  ®QQF¯  courante  en  ‚cran  graphique avec un
 attribut de couleur d'‚criture et de fond comme en ‚cran de texte.
}

Procedure OutTextXY;
Var
 I:Byte;
Begin
 For I:=0to Length(S)-1do PutQQFCube(X,Y,S[I+1],Attr)
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                      Proc‚dure _PutQQFCube                    Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'afficher un caractŠre avec la police de
 caractŠres de  format  QQF courante  en ‚cran  graphique de fa‡on
 transparente (sans affecter le fond).
}

Procedure _PutQQFCube(Var X,Y:Word;Chr:Char;Attr:Byte);Near;
Var
 I,J,XN,YN,B,XG,YG,MX:Word;
 QQFW:^TWord Absolute QQF;
Begin
 B:=QQFW^[Byte(Chr)];
 If B=0Then Exit;
 MX:=QQF^[B];XN:=MX shr 3;XG:=X;YG:=Y;
 If(X+QQF^[B]>NmXPixels)Then Begin
  X:=QQF^[B];Inc(Y,QQFHeight);XG:=0;YG:=Y;
 End
  Else
 Inc(X,QQF^[B]);
 If QQF^[B]and 7<>0Then Begin
  MX:=(XN+1)shl 3;Inc(XN)
 End;
 Inc(B);YN:=QQF^[B];Inc(B);
 If QQF^[B]<>0Then Inc(YG,QQF^[B]);
 Inc(B);
 For J:=0to YN-1do Begin
  For I:=0to XN-1do Begin
   CopT8Bin(XG,YG,QQF^[B],Attr);
   Inc(B);Inc(XG,8)
  End;
  Dec(XG,XN shl 3);
  Inc(YG)
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure _OutTextXY                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'afficher un chaŒne de caractŠres avec la police
 de  caractŠres  de  format  ®QQF¯ courante  en ‚cran  graphique  de fa‡on
 transparente (sans affecter le fond).
}

Procedure _OutTextXY;
Var
 I:Byte;
Begin
 For I:=0to Length(S)-1do _PutQQFCube(X,Y,S[I+1],Attr)
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure PopCur                           Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de restaur‚ une partie cubique de l'‚cran o— se
 trouvait le curseur ayant ‚t‚ sauvegard‚e par la proc‚dure ®PushCur¯.
}

Procedure PopCur;
Var
 CC:TextCube Absolute CurrCube;
 T:TextBoxRec;
 G:GraphBoxRec;
Begin
 If(IsGrf)Then Begin
  ASM
   CALL GetYCurPos
   MOV AH,AL
   CALL GetXCurPos
   MOV Word Ptr T.X1,AX
   MOV Word Ptr T.X2,AX
  END;
  CoordTxt2Graph(T,G);
  __PutSmlImg(G,CurBuf^);
  {$IFDEF FLAT386}
  {$ELSE}
   Mem[GetVideoSegBuf:(GetXCurPos+(GetYCurPos)*NmXTxts)shl 1+1]:=CC.Attr;
  {$ENDIF}
 End
  Else
 SetCube(GetXCurPos,GetYCurPos,CC.Chr,CC.Attr);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure PushCur                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure sauvegarde le contenu du cube o— se trouve le curseur.
 Elle pourra n'ˆtre r‚‚crit en utilisant son pendont ®PopCur¯.
}

Procedure PushCur;
Var
 T:TextBoxRec;
 G:GraphBoxRec;
Begin
 CurrCube:=GetCube(GetXCurPos,GetYCurPos);
 If(IsGraf)Then Begin
  ASM
   CALL GetYCurPos
   MOV AH,AL
   CALL GetXCurPos
   MOV Word Ptr T.X1,AX
   MOV Word Ptr T.X2,AX
  END;
  CoordTxt2Graph(T,G);
  __GetSmlImg(G,CurBuf^);
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                    Proc‚dure PutBorderUnKr                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure affiche un cadre de format courant d'une boŒte de
 dialogue.
}

Procedure PutBorderUnKr;
Var
 G:GraphBoxRec;
 T:TextBoxRec;
 HH:Word;
 Level,Kr,SK:Byte;
Begin
 Level:=0;
 If(IsGrf)Then Begin
  If(CurBorder=BorderSimple)Then Level:=1;
  If(CurBorder=BorderDouble)Then Level:=2;
 End;
 If Level>0Then Begin
  HH:=HeightChr shr 1;Kr:=GetAttr(X1,Y1);
  ASM
    {T.X1:=X1;T.Y1:=Y1;T.X2:=X2;T.Y2:=Y2;}
   MOV AL,X1
   MOV AH,Y1
   MOV Word Ptr T.X1,AX
   MOV AL,X2
   MOV AH,Y2
   MOV Word Ptr T.X2,AX
  END;
  CoordTxt2Graph(T,G);
  If(Kr shr 4=$F)or(Kr and$F=$F)Then SK:=7 Else
  If Kr shr 4>8Then SK:=Kr shr 5
               Else SK:=$F;
  BarSpcHor(X1,Y1,X2,Kr);
  BarSpcVer(X1,Y1+1,Y2-1,Kr);
  BarSpcVer(X2,Y1+1,Y2-1,Kr);
  BarSpcHor(X1,Y2,X2,Kr);
  ASM AND Kr,0Fh;END; { Ce d‚barrasser de la couleur de fond }
  Inc(G.Y1,HH);Dec(G.Y2,HH);
  If Level=1Then Begin
   PutRect(G.X1+5,G.Y1+1,G.X2-3,G.Y2+1,SK);
   PutRect(G.X1+4,G.Y1,G.X2-4,G.Y2,Kr);
  End
   Else
  Begin
   PutRect(G.X1+4,G.Y1,G.X2-4,G.Y2,SK);
   If Kr=$FThen PutRect(G.X1+7,G.Y1+3,G.X2-1,G.Y2+3,SK)
           Else PutRect(G.X1+6,G.Y1+2,G.X2-2,G.Y2+2,SK);
   PutRect(G.X1+3,G.Y1-1,G.X2-5,G.Y2-1,Kr);
   If Kr=$FThen PutRect(G.X1+6,G.Y1+2,G.X2-2,G.Y2+2,Kr)
           Else PutRect(G.X1+5,G.Y1+1,G.X2-3,G.Y2+1,Kr);
  End;
 End
  Else
 Begin
  BarChrVer(X1,Y1+1,Y2-1,CurBorder[3]);
  BarChrVer(X2,Y1+1,Y2-1,CurBorder[4]);
  BarChrHor(X1+1,Y1,X2-1,CurBorder[1]);
  BarChrHor(X1+1,Y2,X2-1,CurBorder[6]);
  SetChr(X1,Y1,CurBorder[0]);
  SetChr(X1,Y2,CurBorder[5]);
  SetChr(X2,Y1,CurBorder[2]);
  SetChr(X2,Y2,CurBorder[7]);
 End;
End;

{Procedure __PutBorderUnKr(Const Context);Var Q:TextBoxRec Absolute Context;Begin
 PutBorderUnKr(Q.X1,Q.Y1,Q.X2,Q.Y2);
End;}

Procedure __PutBorderUnKr(Const Context);
{$IFDEF FLAT386}
 Var
  Q:TextBoxRec Absolute Context;
 Begin
  PutBorderUnKr(Q.X1,Q.Y1,Q.X2,Q.Y2);
 End;
{$ELSE}
 Assembler;ASM
  MOV DX,DS
  LDS SI,Context
  CLD
  LODSB
  PUSH AX
  LODSB
  PUSH AX
  LODSB
  PUSH AX
  LODSB
  PUSH AX
  MOV DS,DX
  PUSH CS
  CALL Near Ptr PutBorderUnKr
 END;
{$ENDIF}

Procedure __GetSmlImg(Const Context;Var Buffer);
{$IFDEF FLAT386}
 Var
  Q:TextBoxRec Absolute Context;
 Begin
  GetSmlImg(Q.X1,Q.Y1,Q.X2,Q.Y2,Buffer);
 End;
{$ELSE}
 Assembler;ASM
  MOV DX,DS
  LDS SI,Context
  CLD
  LODSW
  PUSH AX
  LODSW
  PUSH AX
  LODSW
  PUSH AX
  LODSW
  PUSH AX
  MOV DS,DX
  PUSH Word Ptr Buffer[2]
  PUSH Word Ptr Buffer[0]
  CALL GetSmlImg
 END;
{$ENDIF}

Procedure __PutSmlImg(Const Context;Var Buffer);
{$IFDEF FLAT386}
 Var
  Q:TextBoxRec Absolute Context;
 Begin
  GetSmlImg(Q.X1,Q.Y1,Q.X2,Q.Y2,Buffer);
 End;
{$ELSE}
 Assembler;ASM
  MOV DX,DS
  LDS SI,Context
  CLD
  LODSW
  PUSH AX
  LODSW
  PUSH AX
  LODSW
  PUSH AX
  LODSW
  PUSH AX
  MOV DS,DX
  LES DI,Buffer
  PUSH ES
  PUSH DI
  CALL PutSmlImg
 END;
{$ENDIF}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Proc‚dure PutBoxOnlyShade                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure affiche seulement l'ombre de taille demi-caractŠre d'une
 boŒte figurer.
}

Procedure PutBoxOnlyShade;
Var
 I,x3:Byte;
Begin
 If(GetShade)Then Begin
  If(X2<NmXTxts)Then Begin
   If Y2>NmYTxts-3Then Dec(Y2)
                  Else BarSelHor(X1+2,Y2+1,X2,7);
   x3:=X2+1;
   While(x3<NmXTxts)do Begin
    BarSelVer(x3,Y1+1,Y2+1,7);
    Inc(x3);
    If x3>X2+2Then Break;
   End;
  End;
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure PutBoxTxt                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure copie un tampon d'image texte dans la m‚moire vid‚o si
 c'est un mode texte  ou le tampon d'acc‚l‚ration  s'il s'agit d'un mode
 graphique.
}

Procedure PutBoxTxt;
Var
 J:Byte;
 I,DXS:Word;
 TBuf:TByte Absolute Buffer;
 ScrPtr:Word;
Begin
 If(IsVideoDirectAccess)or(IsGrf)Then Begin
  DXS:=(X2-X1+1)shl 1;I:=0;
  If(IsGraf)Then ScrPtr:=GetVideoSegBuf
            Else ScrPtr:=GetVideoSeg;
  For J:=0to(Y2-Y1)do Begin
   {$IFDEF FLAT386}
   {$ELSE}
    MoveLeft(TBuf[I],Mem[ScrPtr:(X1+(Y1+J)*NmXTxts)shl 1],DXS);
   {$ENDIF} 
   Inc(I,DXS)
  End;
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Proc‚dure PutFillBorder                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure affiche une cadre plein (sans trou dans le milieu) …
 partir  des coordonn‚es  texte  (X1,Y1)-(X2,Y2).  Il utilise le cadre
 courant charger en m‚moire.
}

Procedure PutFillBorder;Begin
 If(X1<>X2)and(Y1<>Y2)Then Begin
  ClrWn(X1,Y1,X2,Y2,Attr);
  PutBorderUnKr(X1,Y1,X2,Y2);
  PutBoxOnlyShade(X1,Y1,X2,Y2);
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure PutFont                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure affiche une chaŒne de caractŠre … partir d'une police
 graphique d‚finit par la proc‚dure ®SetFontName¯.
}

Procedure PutFont;
Var
 I2:Byte;
 Handle:Hdl;
 P:Word;
 x0:Record
  Height,Len:Byte;
  Mtx:Array[0..125]of Byte;
 End;
Begin
 Handle:=FileOpen(PathFont,fmRead);
 If(Handle=errHdl)Then Exit;
 For I2:=1to Length(S)do Begin
  GetRec(Handle,Byte(S[I2]),SizeOf(P),P);
  _GetAbsRec(Handle,P,SizeOf(x0),x0);
  If(VidBnkSwitch.XL+x0.Len>NmXPixels)Then Begin
   VidBnkSwitch.XL:=0;
   Inc(VidBnkSwitch.YL,x0.Height)
  End;
  If(VidBnkSwitch.YL+x0.Height>NmYPixels)Then Break;
  PutChr(VidBnkSwitch.XL,VidBnkSwitch.YL,x0.Len,x0.Height,x0.Mtx);
  Inc(VidBnkSwitch.XL,x0.Len*SizeMulFont+1);
 End;
 FileClose(Handle);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Proc‚dure PutGTxtXY                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'afficher un texte standard … la position
 graphique sp‚cifier et avec l'attribut sp‚cifier.
}

Procedure PutGTxtXY;
Var
 I:Byte;
Begin
 For I:=1to Length(S)do Begin
  SetGCube(X,Y,S[I],Attr);
  Inc(X,8);
 End;
End;

Const
TaskIconImage:Array[0..8*6-1]of Byte=(
 $FF,$FF,$FF,$FF,$FF,$FF,$FF,$F8,
 $F9,$99,$99,$99,$99,$99,$99,$90,
 $F9,$88,$88,$88,$88,$88,$80,$90,
 $F9,$90,$00,$00,$00,$00,$00,$90,
 $F9,$99,$99,$99,$99,$99,$99,$90,
 $80,$00,$00,$00,$00,$00,$00,$00
);

Procedure PutTaskBarIcon(X,Y,Attr:Byte);
Var
 Buffer:Pointer;
 G:GraphPointRec;
 J:Word;
Begin
 If(IsGrf)Then Begin
  {$IFDEF FLAT386}
   G.X:=X shl 3;G.Y:=GetRawY(Y);
  {$ELSE}
   ASM
     {G.X:=X shl 3;G.Y:=GetRawY(Y);}
    MOV AL,X
    MOV AH,Y
    PUSH AX
    PUSH SS
    MOV SI,Offset G
    ADD SI,BP
    PUSH SI
    PUSH CS
    CALL Near Ptr Word2Graph
   END;
  {$ENDIF}
  Buffer:=@TaskIconImage;
  ClrLnHorImg(G.X,G.Y,16,4,Buffer^);
  Inc(G.Y);
  ASM ADD Word Ptr Buffer,8;END;
  For J:=1to HeightChr-5do Begin
   ClrLnHorImg(G.X,G.Y,16,4,Buffer^);
   Inc(G.Y);
  End;
  For J:=0to 3do Begin
   ASM ADD Word Ptr Buffer,8;END;
   ClrLnHorImg(G.X,G.Y,16,4,Buffer^);
   Inc(G.Y);
  End;
 End;
End;

Procedure ConstUnderlineIcon;Assembler;ASM
 DB 00111100b
 DB 01100111b
 DB 11000011b
 DB 01100110b
 DB 00110000b
 DB 00011100b
 DB 00000110b
 DB 00000011b
 DB 01110011b
 DB 11000011b
 DB 11100111b
 DB 00111100b
 DB 00000000b
 DB 11111111b
END;

Procedure ConstItalicIcon;Assembler;ASM
 DB 00111111b
 DB 00001100b
 DB 00001100b
 DB 00001100b
 DB 00001100b
 DB 00011000b
 DB 00011000b
 DB 00011000b
 DB 00110000b
 DB 00110000b
 DB 00110000b
 DB 11111100b
 DB 00000000b
 DB 00000000b
END;

Procedure ConstBoldIcon;Assembler;ASM
 DB 00111100b
 DB 01111110b
 DB 11100111b
 DB 11100011b
 DB 11100000b
 DB 11100000b
 DB 11101111b
 DB 11101111b
 DB 11100111b
 DB 11100111b
 DB 01111110b
 DB 00111100b
 DB 00000000b
 DB 00000000b
END;

Procedure ConstDouble1Icon;Assembler;ASM
 DB 11111111b
 DB 01111111b
 DB 01111111b
 DB 01111100b
 DB 01111100b
 DB 01111100b
 DB 01111100b
 DB 01111100b
 DB 01111100b
 DB 01111111b
 DB 01111111b
 DB 11111111b
 DB 00000000b
 DB 00000000b
END;

Procedure ConstDouble2Icon;Assembler;ASM
 DB 11111100b
 DB 11111110b
 DB 11111110b
 DB 00111111b
 DB 00011111b
 DB 00011111b
 DB 00011111b
 DB 00011111b
 DB 00111111b
 DB 11111110b
 DB 11111110b
 DB 11111100b
 DB 00000000b
 DB 00000000b
END;

Procedure ConstDraw1Icon;Assembler;ASM
 DB 11111111b
 DB 10000000b
 DB 10000000b
 DB 10000000b
 DB 10000100b
 DB 10001010b
 DB 11111111b
 DB 00100000b
 DB 01000000b
 DB 11111111b
 DB 00000000b
 DB 00000000b
 DB 00000000b
 DB 00000000b
END;

Procedure ConstDraw2Icon;Assembler;ASM
 DB 11001100b
 DB 01010010b
 DB 01100001b
 DB 01100001b
 DB 01010010b
 DB 01001100b
 DB 11000000b
 DB 10000000b
 DB 01000000b
 DB 11100000b
 DB 00001100b
 DB 00010010b
 DB 00010010b
 DB 00001100b
END;

Procedure ConstLeft1Icon;Assembler;ASM
 DB 11111111b
 DB 00000000b
 DB 11111111b
 DB 00000000b
 DB 11111111b
 DB 00000000b
 DB 11111111b
 DB 00000000b
 DB 11111111b
 DB 00000000b
 DB 11111111b
 DB 00000000b
 DB 00000000b
 DB 00000000b
END;

Procedure ConstLeft2Icon;Assembler;ASM
 DB 11111111b
 DB 00000000b
 DB 11111100b
 DB 00000000b
 DB 11111110b
 DB 00000000b
 DB 11111000b
 DB 00000000b
 DB 11111110b
 DB 00000000b
 DB 11111111b
 DB 00000000b
 DB 00000000b
 DB 00000000b
END;

Procedure ConstRight1Icon;Assembler;ASM
 DB 11111111b
 DB 00000000b
 DB 00111111b
 DB 00000000b
 DB 01111111b
 DB 00000000b
 DB 00011111b
 DB 00000000b
 DB 01111111b
 DB 00000000b
 DB 11111111b
 DB 00000000b
 DB 00000000b
 DB 00000000b
END;

Procedure ConstSimpleLineIcon;Assembler;ASM
 DB 11111111b
 DB 00000000b
 DB 11111111b
 DB 00000000b
 DB 00000000b
 DB 00000000b
 DB 00000000b
 DB 00000000b
 DB 00000000b
 DB 00000000b
 DB 00000000b
 DB 00000000b
 DB 00000000b
 DB 00000000b
END;

Procedure ConstDoubleLineIcon;Assembler;ASM
 DB 11111111b
 DB 00000000b
 DB 00000000b
 DB 11111111b
 DB 00000000b
 DB 00000000b
 DB 00000000b
 DB 00000000b
 DB 00000000b
 DB 00000000b
 DB 00000000b
 DB 00000000b
 DB 00000000b
 DB 00000000b
END;

Procedure ConstPuceBlock1Icon;Assembler;ASM
 DB 00000000b
 DB 11110000b
 DB 11110101b
 DB 11110000b
 DB 00000000b
 DB 00000000b
 DB 11110000b
 DB 11110101b
 DB 11110000b
 DB 00000000b
 DB 00000000b
 DB 11110000b
 DB 11110101b
 DB 11110000b
END;

Procedure ConstPuceBlock2Icon;Assembler;ASM
 DB 00000000b
 DB 00000000b
 DB 11111111b
 DB 00000000b
 DB 00000000b
 DB 00000000b
 DB 00000000b
 DB 11111111b
 DB 00000000b
 DB 00000000b
 DB 00000000b
 DB 00000000b
 DB 11111111b
 DB 00000000b
END;

Procedure ConstPuceRoman1Icon;Assembler;ASM
 DB 00000000b
 DB 00100000b
 DB 00100010b
 DB 00100000b
 DB 00000000b
 DB 00000000b
 DB 01010000b
 DB 01010010b
 DB 01010000b
 DB 00000000b
 DB 00000000b
 DB 10101000b
 DB 10101010b
 DB 10101000b
END;

Procedure ConstPuceNumber1Icon;Assembler;ASM
 DB 00000000b
 DB 01100000b
 DB 00100010b
 DB 01110000b
 DB 00000000b
 DB 01110000b
 DB 00110000b
 DB 01100010b
 DB 01110000b
 DB 00000000b
 DB 11110000b
 DB 01110000b
 DB 01110010b
 DB 11110000b
END;

Procedure ConstPuceAlpha1Icon;Assembler;ASM
 DB 00110000b
 DB 01001000b
 DB 01111010b
 DB 01001000b
 DB 00000000b
 DB 11110000b
 DB 01111000b
 DB 01001010b
 DB 11110000b
 DB 00000000b
 DB 01111000b
 DB 10000000b
 DB 10000010b
 DB 01111000b
END;

Type
 IconArray=Array[0..13]of Byte;

Procedure PutBinIcon(X,Y:Word;Attr:Byte;Icn:Pointer);
Var
 J:Word;
 Icon:^IconArray Absolute Icn;
Begin
 ASM
  AND Attr,0Fh
 END;
 For J:=0to 13do Begin
  CopT8Bin(X,Y,Icon^[J],Attr);
  Inc(Y);
 End;
End;

Procedure BoldIcon(X,Y:Word;Attr:Byte);Begin
 PutBinIcon(X,Y,Attr,@ConstBoldIcon);
End;

Procedure ItalicIcon(X,Y:Word;Attr:Byte);Begin
 PutBinIcon(X,Y,Attr,@ConstItalicIcon);
End;

Procedure UnderlineIcon(X,Y:Word;Attr:Byte);Begin
 PutBinIcon(X,Y,Attr,@ConstUnderlineIcon);
End;

Procedure DoubleIcon(X,Y:Word;Attr:Byte);Begin
 PutBinIcon(X,Y,Attr,@ConstDouble1Icon);
 PutBinIcon(X+8,Y,Attr,@ConstDouble2Icon);
End;

Procedure DrawIcon(X,Y:Word;Attr:Byte);Begin
 PutBinIcon(X,Y,Attr,@ConstDraw1Icon);
 PutBinIcon(X+8,Y,Attr,@ConstDraw2Icon);
End;

Procedure LeftCenterIcon(X,Y:Word;Attr:Byte);Begin
 PutBinIcon(X,Y,Attr,@ConstLeft1Icon);
 PutBinIcon(X+8,Y,Attr,@ConstLeft2Icon);
End;

Procedure JustifyCenterIcon(X,Y:Word;Attr:Byte);Begin
 PutBinIcon(X,Y,Attr,@ConstLeft1Icon);
 PutBinIcon(X+8,Y,Attr,@ConstLeft1Icon);
End;

Procedure RightCenterIcon(X,Y:Word;Attr:Byte);Begin
 PutBinIcon(X,Y,Attr,@ConstRight1Icon);
 PutBinIcon(X+8,Y,Attr,@ConstLeft1Icon);
End;

Procedure SimpleLineIcon(X,Y:Word;Attr:Byte);Begin
 PutBinIcon(X,Y,Attr,@ConstSimpleLineIcon);
 PutBinIcon(X+8,Y,Attr,@ConstSimpleLineIcon);
End;

Procedure DoubleLineIcon(X,Y:Word;Attr:Byte);Begin
 PutBinIcon(X,Y,Attr,@ConstDoubleLineIcon);
 PutBinIcon(X+8,Y,Attr,@ConstDoubleLineIcon);
End;

Procedure PuceBlockIcon(X,Y:Word;Attr:Byte);Begin
 PutBinIcon(X,Y,Attr,@ConstPuceBlock1Icon);
 PutBinIcon(X+8,Y,Attr,@ConstPuceBlock2Icon);
End;

Procedure PuceRomanIcon(X,Y:Word;Attr:Byte);Begin
 PutBinIcon(X,Y,Attr,@ConstPuceRoman1Icon);
 PutBinIcon(X+8,Y,Attr,@ConstPuceBlock2Icon);
End;

Procedure PuceNumberIcon(X,Y:Word;Attr:Byte);Begin
 PutBinIcon(X,Y,Attr,@ConstPuceNumber1Icon);
 PutBinIcon(X+8,Y,Attr,@ConstPuceBlock2Icon);
End;

Procedure PuceAlphaIcon(X,Y:Word;Attr:Byte);Begin
 PutBinIcon(X,Y,Attr,@ConstPuceAlpha1Icon);
 PutBinIcon(X+8,Y,Attr,@ConstPuceBlock2Icon);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Proc‚dure PutKeyHori                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure affiche … l'‚cran un bouton cliquable par une souris. Il
 rajoute des effets en mode graphique.
}

Procedure PutKeyHori;Label 1;
Const Matrix:Array[0..15,0..3]of Byte=(
	     ($77,$77,$77,$77),
	     ($77,$77,$77,$70),
	     ($78,$88,$88,$80),
	     ($78,$88,$88,$80),
	     ($78,$89,$88,$80),
	     ($78,$8E,$98,$80),
	     ($78,$8E,$E8,$80),
	     ($7E,$EE,$EE,$80),
	     ($71,$EE,$EE,$E0),
	     ($78,$EE,$E8,$80),
	     ($78,$89,$E8,$80),
	     ($78,$88,$98,$80),
	     ($78,$88,$88,$80),
	     ($78,$88,$88,$80),
	     ($70,$00,$00,$00),
	     ($00,$00,$00,$00));
Var
 G:GraphBoxRec;
 T:TextBoxRec;
 J,Kr:Word;
 At,X:Byte;
Begin
 X:=X1+1+((X2-X1-Length(Msg))shr 1);
 If(IsGrf)Then Begin
  ASM
    {T.X1:=X1;T.Y1:=Y;T.X2:=X2;T.Y2:=Y;}
   MOV AL,X1
   MOV AH,Y
   MOV Word Ptr T.X1,AX
   MOV AL,X2
   MOV Word Ptr T.X2,AX
  END;
  CoordTxt2Graph(T,G);
  Inc(G.Y2);
 End;
 Case(kType)of
  ktBig:Begin
   SetBorderSimple;
   PutBorderUnKr(X1,Y-1,X2,Y+1);
   SetBorderSimpleLuxe;
   If GetChr(X1,Y-2)='³'Then Begin
    SetChr(X1,Y-1,'Ã');
    SetChr(X2,Y-1,'´')
   End;
   At:=GetAttr(X1,Y)and $F0;
   BarSelHor(X1+1,Y+1,X2,At);
   BarSelVer(X2,Y-1,Y,At);
   PutTxtXY(X,Y,Msg,At+(Attr and$F));
  End;
  ktBubble:Begin
   If Not(IsGraf)Then Goto 1;
   G.Y2:=HeightChr shr 1;
   If(BitsPerPixel<8)or((Attr shr 4)<>$F)Then Begin
    PutFillRoundRect(G.X1,G.Y1-G.Y2,G.X2,G.Y1+HeightChr+G.Y2,HeightChr+1,Attr shr 4);
    PutRoundRect(G.X1+1,G.Y1-G.Y2+2,G.X2-1,G.Y1+HeightChr+G.Y2-2,1,HeightChr,(Attr shr 4)and 7);
   End
    Else
   Begin
    For J:=0to 5do Begin
     If BitsPerPixel>=15Then Kr:=RGB2Color(((J+2)shl 5)+31,((J+2)shl 5)+31,((J+2)shl 5)+31)
                        Else Kr:=32+4+((J shl 1)or 1);
     PutFillRoundRect(G.X1+J,G.Y1-G.Y2+J,G.X2-J,G.Y1+HeightChr+G.Y2-J,
                      HeightChr+1-J,Kr);
    End;
   End;
   PutTxtXY(X,Y,Msg,Attr);
  End;
  ktOS2Win:Begin
   ASM
    AND Attr,7Fh
   END;
   BarSpcHor(X1,Y,X2,Attr);
   PutTxtXY(X,Y,Msg,Attr);
   Dec(G.X1);Dec(G.Y1);
   G.X2:=(Succ(X2)shl 3);
   GraphBoxRelief(G.X1-3,G.Y1-3,G.X2+3,G.Y2+3,0);
   PutRect(G.X1-2,G.Y1-2,G.X2+2,G.Y2+2,Black);
   GraphBoxRelief(G.X1-1,G.Y1-1,G.X2+1,G.Y2+1,Attr);
   __GraphBoxRelief(G,Attr);
{   GraphBoxRelief(G.X1,G.Y1,G.X2,G.Y2,Attr);}
  End;
  ktMac:Begin
   If Not(IsGraf)Then Goto 1;
   At:=Byte(Attr=GetKeySelKr);
   If(At=0)and(GetPixel(G.X1+8,G.Y1-5)=Black)Then
    PutFillBox(G.X1-1,G.Y1-5,G.X2+1,G.Y2+4,GetPixel(G.X1,G.Y1-6));
   PutFillRoundRect(G.X1,G.Y1-3,G.X2,G.Y2+2,3,Attr shr 4);
   PutTxtXY(X,Y,Msg,Attr and$F0);
   PutRoundRect(G.X1,G.Y1-3-At,G.X2,G.Y2+2+At,1+(At shl 1),3,Black);
   PutRoundRect(G.X1+2+At,G.Y1-1,G.X2-2-At,G.Y2,1,1,Black);
  End;
  Else Begin
{   BarSpcHorRelief(X1,Y,X2,Attr);}
 1:BarSpcHorShade(X1,Y,X2,Attr,Shade);
   PutTxtXY(X,Y,Msg,Attr);
   If(IsGraf)Then Begin
    Dec(G.X2,7);
    For J:=0to HeightChr-1do Begin
     ClrLnHorImg(G.X1,G.Y1,8,4,Matrix[J,0]);
     ClrLnHorImg(G.X2,G.Y1,8,4,Matrix[J,0]);
     Inc(G.Y1);
    End;
   End;
  End;
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Proc‚dure PutMsg                             Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure tron‡one une chaŒne de caractŠres … partir de ses espaces,
 pour la faire rentrer dans une fenˆtre: (X1,Y1)-(X2,Y1+n).
}

Procedure PutMsg;
Var
 XS,AX,LAX,I,J:Byte;
Begin
 XS:=X2-X1+1;AX:=0;LAX:=$FF;
 While(Length(Msg)-AX>=XS)do Begin
  I:=AX+XS;
  While(Msg[I-1]>' ')and(Not(Msg[I-1]in['-','\','/']))and(I>AX)do Dec(I);
  PutTxtXY(X1,Y1,Copy(Msg,AX+1,I-1-AX),Attr);
  If(LAX=AX)Then Break;
  LAX:=AX;AX:=I-1;Inc(Y1);
 End;
 PutTxtXY(X1,Y1,Copy(Msg,AX+1,255),Attr);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Proc‚dure PutOTxtU                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure affiche, en mode graphique, une chaŒne de caractŠres sans
 modifier le fond soit centrer … gauche, au centre et … droite.
}

Procedure PutOTxtU;Begin
 PutTxtXYT(pCenter(Length(Msg),Center),Y,Msg,Attr)
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Proc‚dure PutPCharXY                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure affiche une chaŒne de caractŠre de type ASCIIZ … partir de
 la position texte (X,Y).


 Remarque
 ÍÍÍÍÍÍÍÍ

  ş Les coordonn‚es ®X¯ et ®Y¯ sont des coordonn‚es absolues partant du haut
    … gauche de l'‚cran et commence … (0,0) et non pas … (1,1) comme Borland
    le fait  avec  son unit‚  ®Crt¯.  Ceci contribue … gagn‚  du temps et du
    code inutilement gaspill‚.
}

Procedure PutPCharXY;Begin
 While Str^[0]<>#0do Begin
  SetCube(X,Y,Str^[0],Attr);
  ASM
   INC Word Ptr Str[0]
  END;
  Inc(X)
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Proc‚dure PutRect                            Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure affiche une rectangle vide avec comme coordonn‚e sup‚rieur
 gauche  (X1,Y1)  et inf‚rieur  droite  (X2,Y2)  avec la  couleur  graphique
 courante (D‚finit … la de la fonction _SetKr).
}

{$IFNDEF Adele}
Procedure PutRect;
Var
 J:Word;
Begin
 If(IsGraf)Then Begin
  _SetKr(Color);
  _LnHor(X1,Y1,X2);          { Trace la ligne sup‚rieure }
  For J:=Y1+1to Y2-1do Begin
   _SetPixel(X1,J);          { Trace la ligne de gauche }
   _SetPixel(X2,J)           { Trace la ligne de droite }
  End;
  _LnHor(X1,Y2,X2);          { Trace la ligne inf‚rieure }
 End;
End;
{$ENDIF}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                      Proc‚dure PutSmlTxtXY                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet  d'afficher  … un endroit  pr‚cis de l'‚cran
 graphique un message de taille r‚duite (8x8 pixels) avec une couleur
 sp‚cifi‚e.  En ‚cran de texte,  cette  proc‚dure  affiche le message
 d'un taille tout … fait normal.
}

Procedure PutSmlTxtXY(X,Y:Byte;Const S:String;Attr:Byte);
Var
 G:GraphPointRec;
Begin
 If(IsGrf)Then Begin
  {$IFDEF FLAT386}
   G.X:=X shl 3;G.Y:=GetRawY(Y);
  {$ELSE}
   ASM
     {G.X:=X shl 3;G.Y:=GetRawY(Y);}
    MOV AL,X
    MOV AH,Y
    PUSH AX
    PUSH SS
    MOV SI,Offset G
    ADD SI,BP
    PUSH SI
    PUSH CS
    CALL Near Ptr Word2Graph
   END;
  {$ENDIF}
  Case(HeightChr)of
   14:Inc(G.Y,3);
   16:Inc(G.Y,4);
  End;
  OutSmlTxtXY(G.X,G.Y,S,Attr);
 End
  Else
 PutTxtXY(X,Y,S,Attr)
End;

Procedure PutSmlTxtXYT(X,Y:Byte;Const S:String;Attr:Byte);
Var
 G:GraphPointRec;
Begin
 If(IsGrf)Then Begin
  {$IFDEF FLAT386}
   G.X:=X shl 3;G.Y:=GetRawY(Y);
  {$ELSE}
   ASM
     {G.X:=X shl 3;G.Y:=GetRawY(Y);}
    MOV AL,X
    MOV AH,Y
    PUSH AX
    PUSH SS
    MOV SI,Offset G
    ADD SI,BP
    PUSH SI
    PUSH CS
    CALL Near Ptr Word2Graph
   END;
  {$ENDIF}
  Case(HeightChr)of
   14:Inc(G.Y,3);
   16:Inc(G.Y,4);
  End;
  OutSmlTxtXYT(G.X,G.Y,S,Attr);
 End
  Else
 PutTxtXY(X,Y,S,Attr)
End;


{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Proc‚dure PutTxtCenter                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure affiche une chaŒne de caractŠre centrer … gauche, au
 centre  ou … droite  selon  la valeur  de la variable  de param‚trage
 ®Center¯,  avec la couleur d'attribut  d‚finit par une autre variable
 de param‚trage nomm‚ cette fois ®Attr¯.
}

Procedure PutTxtCenter;Begin
 PutTxtXY(pCenter(Length(Msg),Center),Y,Msg,Attr)
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure PutTxtLuxe                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure affiche une message avec la police de caractŠres de luxe
 aussi bien en mode graphiques quand mode texte.
}

Procedure PutTxtLuxe;
Var
 I,J,K,L:Byte;
 Chr:Char;
 W:Word;
 G:GraphPointRec;
Begin
 If(IsGrf)Then Begin
  {$IFDEF FLAT386}
   G.X:=X shl 3;
   G.Y:=GetRawY(Y);
  {$ELSE}
   ASM
     {G.X:=X shl 3;G.Y:=GetRawY(Y);}
    MOV AL,X
    MOV AH,Y
    PUSH AX
    PUSH SS
    MOV SI,Offset G
    ADD SI,BP
    PUSH SI
    PUSH CS
    CALL Near Ptr Word2Graph
   END;
  {$ENDIF}
  TextCube(W).Attr:=Attr;
  For J:=1to Length(S)do Begin
   Chr:=S[J];
   If(Chr<' ')and(LuxeMtx<>NIL)Then Begin
    For I:=0to GetHeightChr-1do Begin
     Copy8Bin(G.X,G.Y+I,LuxeMtx^[GetRawY(Byte(Chr))+I],Attr shr 4,Attr and$F);
    End;
    TextCube(W).Chr:=Chr;
    {$IFDEF FLAT386}
    {$ELSE}
     MemW[GetVideoSegBuf:(Y*NmXTxts+X)shl 1]:=W;
    {$ENDIF}
   End
    Else
   SetCube(X,Y,Chr,Attr);
   Inc(G.X,8);Inc(X);
  End;
 End
  Else
 PutTxtXY(X,Y,S,Attr);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure PutTxtXYT                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure affiche, en mode graphique seulement, une chaŒne de
 caractŠre transparent, c'est-…-dire sans modifier le fond de l'‚cran
 mais seulement le caractŠre lui-mˆme!
}

Procedure PutTxtXYT;
Var
 I:Byte;
 B:Word;
 Chr:Char;
 G:GraphPointRec;
Begin
 If(IsGraf)Then Begin
  {$IFDEF FLAT386}
   G.X:=X shl 3;G.Y:=GetRawY(Y);
  {$ELSE}
   ASM
     {G.X:=X shl 3;G.Y:=GetRawY(Y);}
    MOV AL,X
    MOV AH,Y
    PUSH AX
    PUSH SS
    MOV SI,Offset G
    ADD SI,BP
    PUSH SI
    PUSH CS
    CALL Near Ptr Word2Graph
   END;
  {$ENDIF}
  OutTxtXY(G.X,G.Y,Str,Attr);
  B:=Y*NmXTxts+X;
  For I:=1to Length(Str)do Begin
   Chr:=Str[I];
   {$IFDEF FLAT386}
   {$ELSE}
    ASM
     CALL GetVideoSegBuf
     MOV ES,AX
     MOV BX,B
     SHL BX,1
     MOV AL,Chr
     MOV ES:[BX],AL
     INC BX
     AND ES:[BX].Byte,$F0
     MOV AL,Attr
     ADD ES:[BX].Byte,AL
    END;
   {$ENDIF}
   Inc(B)
  End;
 End
  Else
 PutTxtXY(X,Y,Str,Attr)
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                             Proc‚dure PutTyping                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure affiche une chaŒne de caractŠre de style typ‚ … la m‚thode
 du Malte Genesis I … la position courante texte.
}

Procedure PutTyping;
Var
 I:Word;
 J,X:Byte;
 F,Trans:Boolean;
Begin
 {$IFDEF Win32}
 {$ELSE}
  With(VidBnkSwitch)do Begin
   X:=XP;
   UpDatePos;
   F:=True;Trans:=False;
   For J:=1to Length(Msg)do Begin
    If((Msg[J]>#31)and Not(Msg[J]in['^','|','~']))Then Begin
     If(IsGraf)and(Trans)Then Begin
      PutTxtXYT(XP,YP,Msg[J],NorColor and$F);
      _Right;
     End
      else
     If(F)Then _SetCube(Msg[J])Else _SetChr(Msg[J]);
    End
     else
    Case Msg[J]of
     '|':Begin
      VidBnkSwitch.XP:=X;
      _Dn;
     End;
      #2:_Up;
      #1:Begin
       Inc(J);
       F:=True;
       LastColor:=NorColor;
       NorColor:=Byte(Msg[J]);
      End;
      #4:Begin
          Inc(J);
          If Boolean(Msg[J])Then Begin
           If(F)Then BarSpcHor(XP,YP,XP+Length(Msg[J])-1,NorColor)
                Else BarChrHor(XP,YP,XP+Length(Msg[J])-1,' ');
          End;
         End;
      #5:_Dn;
      #6:_Left;
      #8:_Right;
 Char(caHT):Begin
           If(F)Then BarSpcHor(XP,YP,XP+7,NorColor)
                Else BarChrHor(XP,YP,XP+7,' ');
           Inc(XP,7);
          End;
     #10:Begin _Right;_Dn;End;
     #11:Begin _Left;_Dn;End;
     #12:Begin _Right;_Up;End;
      #3:Begin _Left;_Up;End;
     #14:Begin Dec(XP,2);_Up;End;
     #15:Begin Dec(XP,2);_Dn;End;
     #16:Begin
      Inc(J);XP:=Byte(Msg[J]);Inc(J);YP:=Byte(Msg[J]);
     End;
     ^Q :Trans:=True;
     '^':ASM
      MOV F,1
      MOV AH,LastColor
      MOV AL,NorColor
      MOV Word Ptr LastColor,AX
     END;
     #28:F:=False;
     #29:ClrLn(YP,' ',NorColor);
     #30:Begin
      Inc(J);
      _SetChr(Msg[J]);
     End;
     #31:Begin
      SetAttr(XP,YP,NorColor);
      _Right;
     End;
    Else _SetCube(Msg[J]);
    End;
   End;
  End;
 {$ENDIF} 
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                             Proc‚dure PutTypingXY                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure affiche … la position texte (X,Y) un message typ‚es selon
 le style Malte Genesis I.
}

Procedure PutTypingXY;Begin
 SetPos(X,Y);
 PutTyping(Msg)
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Fonction SearchHigh                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette  fonction recherche la partie haute du phrase de style ASCIIZ et la
 retourne sous forme de chaŒne de caractŠre standard Pascal. Cette fonction
 retourne donc,  techniquement,  la chaŒne de caractŠres comprise entre les
 caractŠres ®^¯ et ®^¯  de la variable de param‚trage ®Msg¯.  Si le dernier
 est manquant,  il va  jusqu'… la fin  de la chaŒne de caractŠres  et si au
 contraire il n'existe pas, il retourne une chaŒne de caractŠres vide.


 Remarque
 ÍÍÍÍÍÍÍÍ

  ş Voici le source de cette fonction en langage Pascal Standard:
    ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
    ³ Function SearchHigh;Var I,L:Byte;Begin                              ³
    ³  SearchHigh:='';                                                    ³
    ³  If IsPChrEmpty(Msg)Then Exit;                                      ³
    ³  I:=0;L:=0;                                                         ³
    ³  While Msg^[I]<>#0do Begin                                          ³
    ³   If Msg^[I]='^'Then Inc(L);                                        ³
    ³   Inc(I);                                                           ³
    ³  End;                                                               ³
    ³  If L>=2Then Begin                                                  ³
    ³   I:=0;                                                             ³
    ³   While Not(Msg^[I]in[#0,'^'])do Inc(I);                            ³
    ³   Inc(I);L:=0;                                                      ³
    ³   While Not(Msg^[I+L]in[#0,'^'])do Inc(L);                          ³
    ³   SearchHigh:=Copy(StrPas(Msg),I+1,L)                               ³
    ³  End;                                                               ³
    ³ End;                                                                ³
    ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
}

Function SearchHigh;
Var
 I,L:Byte; { ATTENTION! Ne pas changer l'ordre }
Begin
 SearchHigh:='';
 If IsPChrEmpty(Msg)Then Exit;
 ASM
  { L:=0;I:=0;
    While Msg^[I]<>#0do Begin
     If Msg^[I]='^'Then Inc(L);
     Inc(I);
   End;}
  CLD
  PUSH DS
   XOR BX,BX
   MOV AH,'^'
   LDS SI,Msg
@1:LODSB
   OR  AL,AL
   JE  @3
   CMP AL,AH
   JNE @2
   INC BL
@2:INC BH
   JMP @1
@3:
  POP DS
  MOV Word Ptr L,BX
 END;
 If L>=2Then Begin
  I:=0;
  While Not(Msg^[I]in[#0,'^'])do Inc(I);
  Inc(I);L:=0;
  While Not(Msg^[I+L]in[#0,'^'])do Inc(L);
  SearchHigh:=Copy(StrPas(Msg),I+1,L)
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure SetAllKr                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure fixe les couleurs d'affiche normal ainsi que la couleur
 des parties accentuer d'un texte devant ˆtre affich‚.
}

Procedure SetAllKr;Assembler;ASM
 MOV AL,Last
 MOV AH,New
 MOV Word Ptr LastColor,Ax
END;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                      Proc‚dure SetBorderAvenger                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure charge une bordure de style ®Avenger¯. Il sera ensuite
 utilis‚ lors d'un prochaine appelle d'affichage de cadre.
}

Procedure SetBorderAvenger;Begin
 CurBorder:='ÛßÛİŞÛÜÛ'
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                      Proc‚dure SetBorderDouble                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure charge une bordure double utilis‚ par d‚faut. Il sera
 ensuite utilis‚ lors d'un prochaine appelle d'affichage de cadre.
}

Procedure SetBorderDouble;Begin
 CurBorder:=BorderDouble {'ÉÍ»ººÈÍ¼'}
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                      Proc‚dure SetBorderSimple                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure charge une bordure simple utilis‚ par d‚faut. Il sera
 ensuite utilis‚ lors d'un prochaine appelle d'affichage de cadre.
}

Procedure SetBorderSimple;Begin
 CurBorder:=BorderSimple {'ÚÄ¿³³ÀÄÙ'}
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure SetBorderSimpleLuxe                  Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure charge le style de bordure simple appropri‚ en fonction de
 l'environnement normal ou de luxe.
}

Procedure SetBorderSimpleLuxe;Begin
 If Not(IsLuxe)Then SetBorderSimple
 Else CurBorder:=#31#3#7#1#2#5#4#6;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure SetCurType                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure fixe le style  de curseur … utiliser.  Peut s'appliquer
 ‚galement en mode graphique moyennant un certain nombre de temps allouer
 par une proc‚dure d'arriŠre plan enclench‚ par une attente au clavier.
}

Procedure SetCurType;Assembler;ASM
 MOV AL,X
 MOV CurType,AL
END;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Proc‚dure SetFontName                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure fixe le nom de la police graphique devant ˆtre utiliser.
 Il initialise par la mˆme occasion tous les donn‚es la concernant.
}

Procedure SetFontName;Begin
 PathFont:=FSearch(Name,';'+SetPath4AddFile(Path2Dir(FileExpand(Name)))+';'+MaltePath+'FONT');
 FontDegraded:=True;
 DegradLen:=16;
 SizeMulFont:=1;
 _Move2(0,0);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Proc‚dure SetKr                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure fixe la couleur d'attribut du texte … ˆtre ‚crit
 prochainement.
}

Procedure SetKr;Assembler;ASM
 MOV AL,Color
 MOV NorColor,AL
END;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Proc‚dure SetLuxe                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure ‚tablie le mode de luxe des modes d'‚cran de texte. En
 mode  graphique,  il ne fait  que charger  les  polices  de  caractŠres
 appropri‚ au mode.
}

Procedure SetLuxe;
Label Break;
Var
 Addr:^TByte;
 SizeOf_:Word;
 H:Byte;
Begin
 _FreeMemory(Pointer(LuxeMtx),LuxeMtxSize);
 If(IsEGA)Then Begin
  SetPalRGB(DefaultRGB[Blue],1,1);
  SetPalRGB(DefaultRGB[Magenta],5,1);
 End;
 Adele.SetLuxe(True);
 If(IsLuxe)Then Begin
  SetBorderSimpleLuxe;
  UnSelIconLen:=2;      { Largeur en caractŠre de l'ic“ne de d‚s‚lection }
  SelIconLen:=2;        { Largeur en caractŠre de l'ic“ne de s‚lection }
  CloseIconLen:=2;      { Largeur en caractŠre de l'ic“ne de fermeture }
  ZoomIconLen:=2;       { Largeur en caractŠre de l'ic“ne de Zooming }
  LeftIconLen:=2;       { Largeur en caractŠre de l'ic“ne de flŠche gauche }
  RightIconLen:=2;      { Largeur en caractŠre de l'ic“ne de flŠche droite }
  UpIconLen:=2;         { Largeur en caractŠre de l'ic“ne de flŠche haut }
  DownIconLen:=2;       { Largeur en caractŠre de l'ic“ne de flŠche bas }
 End
  Else
 Begin
  SetBorderSimple;
  UnSelIconLen:=3;      { Largeur en caractŠre de l'ic“ne de d‚s‚lection }
  SelIconLen:=3;        { Largeur en caractŠre de l'ic“ne de s‚lection }
  CloseIconLen:=3;      { Largeur en caractŠre de l'ic“ne de fermeture }
  ZoomIconLen:=3;       { Largeur en caractŠre de l'ic“ne de Zooming }
  LeftIconLen:=1;       { Largeur en caractŠre de l'ic“ne de flŠche gauche }
  RightIconLen:=1;      { Largeur en caractŠre de l'ic“ne de flŠche droite }
  UpIconLen:=1;         { Largeur en caractŠre de l'ic“ne de flŠche haut }
  DownIconLen:=1;       { Largeur en caractŠre de l'ic“ne de flŠche bas }
 End;
 CloseCur;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure SetPos                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure fixe la position du pointeur texte utilisez par les
 proc‚dures … comportement traditionnaliste.
}

Procedure SetPos;Assembler;ASM
 MOV AL,X
 MOV AH,Y
 MOV VidBnkSwitch.XP.Word,AX
END;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Proc‚dure SetPosHome                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure fixe la position du pointeur texte utilisez par les
 proc‚dures … comportement  traditionnaliste  en  haut  de  l'‚cran …
 droite.
}

Procedure SetPosHome;Assembler;ASM
 MOV VidBnkSwitch.XP.Word,0
END;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Proc‚dure SetSpc                           Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure fixe un caractŠre espace … la position (en texte) (X,Y)
 avec l'attribut sp‚cifi‚ par la variable ®Attr¯.
}

Procedure SetSpc;Begin
 SetCube(X,Y,' ',Attr)
End;

Type
 SetVideoObject=Record
  Info1:PIV;
  Q:MIV;
  M:Byte;
  OldMtx:Pointer;
 End;

Procedure SVInit(Var Q:SetVideoObject);Begin
 Q.OldMtx:=GetVideoTxtMtxPtr;
 FreeMemory(Q.OldMtx,MtxSize);
 InitMouse;
 InitDrv;
 {$IFDEF Real}
  GetPhysicalInfoVideo(Q.Info1);
  LoadDRC(dvSetMode,@Adele.Init);
 {$ENDIF}
End;

Function SVDone(Var Q:SetVideoObject):Boolean;Begin
 If Q.M=$FFThen Begin
  Q.M:=drvBios;
  SVDone:=False;
 End
  Else
 SVDone:=True;
 {$IFDEF Adele}
  If(Q.M>drvBios)Then Begin
   Inv:=Q.M in[drv320x400c256,drv360x480c256,drvVGA256];
   If(CPU>=cpu80286)Then Inc(Q.M);
   If(CPU>=cpui386)Then Inc(Q.M);
  End;
 {$ELSE}
  If(M=drvSVGA)and(Up32Bits)Then Inc(Q.M);
 {$ENDIF}
 DriverModel:=Q.M;
 {$IFDEF Real}
  LoadDRC(Q.M,@Adele.Init);
  SetModeValue(Q.Q.Mode);
  SetTxtMtx(Q.Q.TxtMtx);
  SetPhysicalInfoVideo(Q.Info1);
 {$ENDIF}
 DoneDrv;
 If(IsGrf)and(NmYPixels>=400)and(HeightChr=8)Then Begin
  SetHeightChr(16);
  SetNumYTexts(NmYPixels shr 4);
 End;
 {$IFDEF Adele}
  If(Inv)Then LoadMtx('STD')Else
 If{(TByte(GetVideoTxtMtxPtr^)[8]<>0)and}(HeightChr>8)Then Begin
  Case(HeightChr)of
   14:Q.M:=5;
   Else Q.M:=6;
  End;
  SetTxtMtx(AllocFont(Q.M,MtxSize));
 End;
 {$ENDIF}
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Fonction SetVideoMode                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de changer de mode vid‚o et de mettre en jour le
 gestionnaire vid‚o de l'application.
}

Function SetVideoMode;
Var
 Q:SetVideoObject;
Begin
 SVInit(Q);
 Q.M:=viSetVideoModePrim(Mode,Q.Info1,Q.Q);
 SetVideoMode:=SVDone(Q);
End;


{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Fonction SetVideoModeDeluxe                   Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction fixe le mode vid‚o sp‚cifier en mode grands luxe pour les
 applications.  Il  retourne  un  drapeau  indiquant  si l'op‚ration c'est
 correctement d‚roul‚s.
}

Function SetVideoModeDeluxe;Begin
 SetVideoModeDeluxe:=SetVideoMode(Mode);
 SetLuxe;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Fonction SetVideoSize                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de fixer un mode vid‚o en fonction d'une taille
 et d'un nombre de couleurs sp‚cifi‚e.
}

Function SetVideoSize;
Var
 Q:SetVideoObject;
Begin
 SVInit(Q);
 Q.M:=viSetVideoSizePrim(Grf,Length,Height,Q.Info1,Q.Q);
 SetVideoSize:=SVDone(Q);
 If(@SetVideoSizeInit<>NIL)Then SetVideoSizeInit;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                             Proc‚dure SimpleCur                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure fixe le format du curseur en un format r‚gulier une simple
 petite barre dans le coin inf‚rieure d'une position de caractŠre.
}

Procedure SimpleCur;Assembler;ASM
 CALL IsGraf
 CMP AL,True
 JNE @Other
 MOV CurType,curCoco3
@Other:
 CALL HeightChr
 XOR AH,AH
 DEC AX
 DEC AX
 PUSH AX
 INC AX
 PUSH AX
 CALL SetCur
END;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Fonction SizeBoxTxt                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction retourne la taille que prend en format texte la boŒte
 sp‚cifi‚ par les couples (X1,Y1)-(X2,Y2).
}

Function SizeBoxTxt;Assembler;ASM
 MOV AL,X2
 SUB AL,X1
 INC AL
 MOV AH,Y2
 SUB AH,Y1
 INC AH
 MUL AH
 SHL AX,1
END;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure WaitRetrace                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure attend un rafraŒchissement et un d‚fraŒchissement de
 l'‚cran avant de ce termine.
}

Procedure WaitRetrace;Assembler;ASM
 CMP OS2,True
 JE  @OS2Wait
 CMP Win,0
 JNE @WinWait
 MOV DX,03DAh
@1:
 IN AL,DX
 TEST AL,8
 JNZ @1
@2:
 IN AL,DX
 TEST AL,8
 JZ @2
 JMP @End
@WinWait:
(* {$IFOPT G+}
  PUSH 55
 {$ELSE}
  MOV AX,55
  PUSH AX
 {$ENDIF}
 CALL Delay
 JMP @End*)
@OS2Wait:
 MOV AH,86h
 XOR CX,CX
 MOV DX,55
 INT 15h
@End:
END;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Proc‚dure _BarSelectHori                 Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure affiche une barre de s‚lection horizontal avec la
 couleur d'affichage texte courante.
}

Procedure _BarSelectHori;Begin
 BarSelHor(X1,Y,X2,GetKr)
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                     Proc‚dure _BarSpcHori                  Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure affiche une barre d'espace horizontal avec la
 couleur d'affichage texte courante.
}

Procedure _BarSpcHor;Begin
 BarSpcHor(X1,Y,X2,GetKr)
End;

{$IFDEF __Windows__}
 Procedure _Dn;Begin
  Inc(VidBnkSwitch.YP);
 End;

 Procedure _Up;Begin
  Dec(VidBnkSwitch.YP);
 End;
{$ENDIF}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure _DrawPoly                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure affiche un polygone avec un nombre sp‚cifique de c“t‚
 avec la couleur graphique courante.
}

Procedure _DrawPoly;Begin
 DrawPoly(Num,TPointType(P),GraphColor)
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure _Left                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de faire reculer le pointeur texte courant.
}

Procedure _Left;Assembler;ASM
 DEC VidBnkSwitch.XP
END;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure _Ln                            Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'afficher une ligne de texte avec la couleur
 graphique courante.
}

Procedure _Ln;Begin
 PutLn(X1,Y1,X2,Y2,GraphColor);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure _Ln2                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'afficher  une ligne graphique … partir du
 pointeur graphique courant et positionne le pointeur graphique … la
 position du nouveau point.
}

Procedure _Ln2;Begin
 _Ln(VidBnkSwitch.XL,VidBnkSwitch.YL,X,Y);
 _Move2(X,Y);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure _LnHor                           Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'afficher une ligne horizontal avec la couleur
 d'affichage courant.
}

Procedure _LnHor;Begin
 PutLnHor(X1,Y,X2,GraphColor)
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure _Move2                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de d‚finir la nouvelle position du pointeur
 graphique courant.
}

Procedure _Move2;Begin
 VidBnkSwitch.XL:=X;
 VidBnkSwitch.YL:=Y;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure _PutFillBox                  Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'afficher une boŒte pleine avec la couleur
 graphique courante.
}

Procedure _PutFillBox;Begin
 PutFillBox(X1,Y1,X2,Y2,GraphColor)
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure _PutPCharXY                  Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'afficher  une chaŒne de caractŠres ASCIIZ
 de format C avec la couleur texte courante … la position sp‚cifier.
}

Procedure _PutPCharXY;Begin
 PutPCharXY(X,Y,Str,NorColor)
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure _PutRect                   Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'afficher une boŒte vide avec la couleur
 d'affichage graphique courante.
}

Procedure _PutRect;Begin
 PutRect(X1,Y1,X2,Y2,GraphColor)
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure _PutTxt                    Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'afficher une chaŒne de caractŠres texte
 … la position courante du pointeur texte.
}

Procedure _PutTxt;Begin
 _PutTxtXY(VidBnkSwitch.XP,VidBnkSwitch.YP,Msg)
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure _PutTxtLn                    Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'afficher une  chaŒne de caractŠres texte
 … la position courante du pointeur texte et passe ensuite au d‚but
 de la ligne suivante.
}

Procedure _PutTxtLn;Begin
 _PutTxt(Msg);
 _Dn;
 VidBnkSwitch.XP:=0;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure _PutTxtXY                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'afficher une chaŒne de caractŠres avec la
 couleur d'affichage texte courante  et positionne le pointeur texte
 … la fait de ce message.
}

Procedure _PutTxtXY;Begin
 PutTxtXY(X,Y,Msg,NorColor);
 VidBnkSwitch.XP:=X+Length(Msg);
 VidBnkSwitch.YP:=Y;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                             Proc‚dure _Right                           Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'avancer d'un caractŠre le pointeur texte courant
 sans affecter l'affichage … l'‚cran.
}

Procedure _Right;Begin
 Inc(VidBnkSwitch.XP);
 UpDatePos;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Proc‚dure _SetChr                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'afficher  un caractŠre … la position pointeur
 texte courant sans modifier la couleur d'attribut et ensuite positionne
 le pointeur texte aprŠs celui-ci.
}

Procedure _SetChr;Begin
 SetChr(VidBnkSwitch.XP,VidBnkSwitch.YP,Chr);
 _Right;
End;

{$IFDEF __Windows__}
 Procedure _SetKr(Color:Wd);Begin
  GraphColor:=Color;
 End;
{$ENDIF}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Proc‚dure _SetCube                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure affiche un caractŠre  avec la couleur texte courante
 … la position courante et ce positionne ensuite juste aprŠs celui-ci.
}

Procedure _SetCube;Begin
 SetCube(VidBnkSwitch.XP,VidBnkSwitch.YP,Chr,NorColor);
 _Right;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure _SetPixel                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet l'affichage … un endroit pr‚cis de l'‚cran d'un
 pixel avec la couleur courante.
}

Procedure _SetPixel;Begin
 SetPixel(X,Y,GraphColor)
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                    Proc‚dure _WaitRetrace                 Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'attendre que l'‚cran ne soit pas en
 plein  r‚affichage  avant   de   restituer   le   contr“le  …
 l'appellant.
}

Procedure _WaitRetrace;Assembler;ASM
 MOV DX,$3DA
@1:IN AL,DX;TEST AL,8;JNZ @1
END;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                    Proc‚dure _WaitDisplay                Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'attendre que l'‚cran soit en plein
 r‚affichage avant de restituer le contr“le … l'appellant.
}

Procedure _WaitDisplay;Assembler;ASM
 MOV DX,$3DA
@2:IN AL,DX;TEST AL,8;JZ @2
END;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Fonction GetWidthTxts                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de retourner la largeur en pixels d'une chaŒne de
 caractŠres sp‚cifier … l'‚cran.
}

{Function GetWidthTxts(Const S:String):Word;Begin
 GetWidthTxts:=Length(S)shl 3;
End;}

Function GetWidthTxts(Const S:String):Word;Assembler;ASM
 {$IFDEF FLAT386}
  MOVZX AX,Byte Ptr [EAX]
  SHL AX,3
 {$ELSE}
  PUSH DS
   LDS SI,S
   LODSB
   MOV AH,0
   SHL AX,1
   SHL AX,1
   SHL AX,1
  POP DS
 {$ENDIF}
END;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                      Proc‚dure Move1BitsTo8BitsOne               Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  La proc‚dure suivante permet de transformer une matrice binaire  (2
 couleurs) en format 256 couleurs de fa‡on transparente, c'est-…-dire
 quelle ne modifie que la partie … afficher et non pas le fond.


 Remarque
 ÍÍÍÍÍÍÍÍ

  ş Voici l'algorithme de cette routine en langage Pascal standard:
    ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
    ³ Procedure Move1BitsTo8BitsOne(Const Source;Var Target;        ³
    ³                               Length:Word;T:Byte);            ³
    ³ Var I,B:Word;Begin                                            ³
    ³  B:=0;                                                        ³
    ³  For I:=0to Length-1do Begin                                  ³
    ³   If TByte(Source)[I]and$80=$80Then TByte(Target)[B]:=T;      ³
    ³   If TByte(Source)[I]and$40=$40Then TByte(Target)[B+1]:=T;    ³
    ³   If TByte(Source)[I]and$20=$20Then TByte(Target)[B+2]:=T;    ³
    ³   If TByte(Source)[I]and$10=$10Then TByte(Target)[B+3]:=T;    ³
    ³   If TByte(Source)[I]and$08=$08Then TByte(Target)[B+4]:=T;    ³
    ³   If TByte(Source)[I]and$04=$04Then TByte(Target)[B+5]:=T;    ³
    ³   If TByte(Source)[I]and$02=$02Then TByte(Target)[B+6]:=T;    ³
    ³   If TByte(Source)[I]and$01=$01Then TByte(Target)[B+7]:=T;    ³
    ³   Inc(B,8);                                                   ³
    ³  End;                                                         ³
    ³ End;                                                          ³
    ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
}

Procedure Move1BitsTo8BitsOne(Source:Byte;Var Target;T:Byte);Assembler;ASM
 {$IFDEF FLAT386}
 {$ELSE}
  LES DI,Target
  MOV AL,Source
  MOV BL,T
  MOV CX,8
 @1:
  SHL AL,1
  JNC @B1
  XCHG AX,BX
  STOSB
  XCHG AX,BX
  JMP  @E1
 @B1:
  INC DI
 @E1:
  LOOP @1
 {$ENDIF}
END;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                     Proc‚dure Move1BitsTo16BitsOne               Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  La proc‚dure suivante permet de transformer une matrice binaire  (2
 couleurs) en format 65536 couleurs (en vraie couleur (TrueColor)) de
 fa‡on transparente,  c'est-…-dire qu'elle ne modifie que la partie …
 afficher et non pas le fond.
}

Procedure Move1BitsTo16BitsOne(Source:Byte;Var Target;T:Word);Assembler;ASM
 {$IFDEF FLAT386}
 {$ELSE}
  LES DI,Target
  MOV AL,Source
  MOV BX,T
  MOV CX,8
@1:
  SHL AL,1
  JNC @B1
  XCHG AX,BX
  STOSW
  XCHG AX,BX
  JMP  @E1
@B1:
  SCASW
@E1:
  LOOP @1
 {$ENDIF}
END;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure PutTxtFade                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'afficher un texte … la position sp‚cifier sans
 alt‚rer la couleur de fond et avec une texture autour du texte.
}

Procedure PutTxtFade(X,Y:Byte;Const S:String;Attr:Byte;Border:Boolean);
Label PutTxt;
Type
 PalType=Array[0..15]of Word;
Var
 I,J,Size,BytesPerLine,B,BS,BS1,BS2,BS3,BS4,BS5,BS6,Kr,SKr,BKr:Word;
 Tx,RA,GA,BA,C:Byte;
 Pal:PalType;
 T,Mtx:^TByte;
 G:GraphBoxRec;
 R:TextBoxRec;
Begin
 If Not(IsGrf)Then Goto PutTxt;
 BytesPerLine:=GetWidthTxts(S);
 If(BitsPerPixel)in[9..16]Then ASM SHL BytesPerLine,1;END;
 Size:=(HeightChr+3)*BytesPerLine+1;
 T:=MemNew(Size);
 If(T<>NIL)Then Begin
  Mtx:=GetVideoTxtMtxPtr;BKr:=Attr shr 4;
  If BitsPerPixel=8Then SKr:=8
   Else
  Begin
   SKr:=RGB2Color(128,128,128);
   BKr:=RGB2Color(DefaultRGB[BKr].R,DefaultRGB[BKr].G,DefaultRGB[BKr].B);
  End;
  If Attr and$F=0Then Begin
   If BitsPerPixel>8Then Begin
    For J:=0to 15do Pal[J]:=RGB2Color(J shl 4,J shl 4,J shl 4);
   End
    Else
   For J:=0to 15do Pal[J]:=J+32;
  End
   Else
  For J:=0to HeightChr-1do Begin
   Tx:=(15-J)shl 4;
   If Attr and 4=4Then RA:=Tx Else RA:=0;
   If Attr and 2=2Then GA:=Tx Else GA:=0;
   If Attr and 1=1Then BA:=Tx Else BA:=0;
   ASM
   {Inc(BA,J shl 4);
    Inc(GA,J shl 4);
    Inc(RA,J shl 4);}
    MOV CL,4
    MOV AL,Byte Ptr J
    SHL AL,CL
    ADD BA,AL
    ADD GA,AL
    ADD RA,AL
   END;
   Pal[J]:=RGB2Color(RA,GA,BA);
  End;
  B:=0;BS:=(BytesPerLine+1);
  If BitsPerPixel>8Then Inc(BS);
  If(Border)Then Begin
   Inc(B,BytesPerLine);
   BS1:=(BytesPerLine shl 1)-1;BS2:=BS1+2;
   BS3:=BytesPerLine-1;BS4:=BS3+2;
   BS5:=$FFFF;BS6:=1;
   If BitsPerPixel>8Then Begin
    Dec(BS1);
    Inc(BS2);
    Dec(BS3);
    Inc(BS4);
    Inc(BS6);
   End;
   If BitsPerPixel=8Then For J:=0to HeightChr-1do Begin
    For I:=0to Length(S)-1do Begin
     C:=Mtx^[GetRawY(Byte(S[I+1]))+J];
     If I=0Then C:=C and$7F;
     Move1BitsTo8BitsOne(C,T^[BS1],BKr); { Tra‡age de l'ombre...}
     Move1BitsTo8BitsOne(C,T^[BS2],BKr); { Tra‡age de l'ombre...}
     Move1BitsTo8BitsOne(C,T^[BS3],BKr); { Tra‡age de l'ombre...}
     Move1BitsTo8BitsOne(C,T^[BS4],BKr); { Tra‡age de l'ombre...}
     If BS5<>$FFFFThen Move1BitsTo8BitsOne(C,T^[BS5],BKr); { Tra‡age de l'ombre...}
     Move1BitsTo8BitsOne(C,T^[BS6],BKr); { Tra‡age de l'ombre...}
     Inc(BS1,8);Inc(BS2,8);
     Inc(BS3,8);Inc(BS4,8);
     Inc(BS5,8);Inc(BS6,8);
    End;
   End
    Else
   For J:=0to HeightChr-1do Begin
    For I:=0to Length(S)-1do Begin
     C:=Mtx^[GetRawY(Byte(S[I+1]))+J];
     If I=0Then C:=C and$7F;
     Move1BitsTo16BitsOne(C,T^[BS1],BKr); { Tra‡age de l'ombre...}
     Move1BitsTo16BitsOne(C,T^[BS2],BKr); { Tra‡age de l'ombre...}
     Move1BitsTo16BitsOne(C,T^[BS3],BKr); { Tra‡age de l'ombre...}
     Move1BitsTo16BitsOne(C,T^[BS4],BKr); { Tra‡age de l'ombre...}
     If BS5<>$FFFFThen Move1BitsTo16BitsOne(C,T^[BS5],BKr); { Tra‡age de l'ombre...}
     Move1BitsTo16BitsOne(C,T^[BS6],BKr); { Tra‡age de l'ombre...}
     Inc(BS1,16);Inc(BS2,16);
     Inc(BS3,16);Inc(BS4,16);
     Inc(BS5,16);Inc(BS6,16);
    End;
   End;
  End;
  For J:=0to HeightChr-1do Begin
   Kr:=Pal[J];
   If BitsPerPixel=8Then For I:=0to Length(S)-1do Begin
    C:=Mtx^[GetRawY(Byte(S[I+1]))+J];
    Move1BitsTo8BitsOne(C,T^[B],Kr);
    If Not(Border)Then Move1BitsTo8BitsOne(C,T^[BS],SKr); { Tra‡age de l'ombre...}
    Inc(B,8);Inc(BS,8);
   End
    Else
   For I:=0to Length(S)-1do Begin
    C:=Mtx^[GetRawY(Byte(S[I+1]))+J];
    Move1BitsTo16BitsOne(C,T^[B],Kr);
    If Not(Border)Then Move1BitsTo16BitsOne(C,T^[BS],SKr); { Tra‡age de l'ombre...}
    Inc(B,16);Inc(BS,16);
   End;
  End;
  ASM
   {$IFDEF FLAT386}
     {R.X1:=X;R.Y1:=Y;R.X2:=X+Length(S)-1;R.Y2:=Y;}
    MOV AL,X
    MOV AH,Y
    MOV Word Ptr R.X1,AX
    LEA EDX,S
    ADD AL,Byte Ptr [EDX]
    DEC AX
    MOV Word Ptr R.X2,AX
   {$ELSE}
     {R.X1:=X;R.Y1:=Y;R.X2:=X+Length(S)-1;R.Y2:=Y;}
    MOV AL,X
    MOV AH,Y
    MOV Word Ptr R.X1,AX
    LES DI,S
    ADD AL,Byte Ptr ES:[DI]
    DEC AX
    MOV Word Ptr R.X2,AX
   {$ENDIF}
  END;
  CoordTxt2Graph(R,G);
  PutSprite(G.X1,G.Y1,G.X2,G.Y2,T^[BytesPerLine]);
  FreeMemory(T,Size)
 End
  Else
 PutTxt:PutTxtXYT(X,Y,S,Attr)
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Fonction RGB2Color                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction retourne le code de couleur correspondant … l'‚quivalent
 de l'intensit‚ des trois couleurs primaire Rouge, Vert et Bleu.
}

Function RGB2Color{R,G,B:Byte):Word|LongInt};
{$IFDEF __Windows__}
 Assembler;ASM
  MOV AH,DL
  AND EAX,0FFFFh
  SHL ECX,16
  OR  EAX,ECX
 END;
{$ELSE}
 Begin
  RGB2Color:=_RGB2Color(BitsPerPixel,R,G,B);
 End;
{$ENDIF}

Function _RGB2Color(BitsPerPixel,R,G,B:Byte):Word;
{Var Kr:Byte;}Begin
 Case(BitsPerPixel)of
  4:ASM
   {Begin
    Kr:=0;
    If(R)and$80=$80Then Kr:=Kr or$04;
    If(R)and$40=$40Then Kr:=Kr or$20;
    If(G)and$80=$80Then Kr:=Kr or$02;
    If(G)and$40=$40Then Kr:=Kr or$10;
    If(B)and$80=$80Then Kr:=Kr or$01;
    If(B)and$40=$40Then Kr:=Kr or$08;
    RGB2Kr:=Kr and$F;
   End;}
   XOR BX,BX
   MOV AL,R
   MOV AH,AL
   AND AL,080h
   OR  AL,AL
   JZ  @1
   MOV BL,04h
@1:AND AH,040h
   OR  AH,AH
   JZ  @2
   OR  BL,20h
@2:MOV AL,G
   MOV AH,AL
   AND AL,080h
   OR  AL,AL
   JZ  @3
   OR  BL,02h
@3:AND AH,040h
   OR  AH,AH
   JZ  @4
   OR  BL,10h
@4:MOV AL,B
   MOV AH,AL
   AND AL,080h
   OR  AL,AL
   JZ  @5
   OR  BL,01h
@5:AND AH,040h
   OR  AH,AH
   JZ  @6
   OR  BL,08h
@6:MOV @Result,BX
  END;
  8:_RGB2Color:=64+(B shr 6)+((G shr 5)shl 2)+((R and$C0)shr 1);
  15:ASM
    {RGB2Color:=((B shr 2)+((((G and$F8)shl 3)+((R and$F8)shl 8))))shr 1;}
   MOV AL,B
   MOV AH,G
   MOV BL,R
   {$IFOPT G+}
    SHR AH,3
   {$ELSE}
    SHR AH,1
    SHR AH,1
    SHR AH,1
   {$ENDIF}
   AND BL,11111000b
   {$IFDEF G+}
    SHR AX,3
   {$ELSE}
    SHR AX,1
    SHR AX,1
    SHR AX,1
   {$ENDIF}
   SHR BL,1
   OR  AH,BL
   XOR DX,DX
   MOV @Result,AX
  END;
  16:ASM
    {RGB2Color:=(B shr 3)+((((G and$F8)shl 3)+((R and$F8)shl 8)))}
   MOV AH,R
   AND AH,0F8h
   MOV AL,B
   {$IFOPT G+}
    SHR AL,3
   {$ELSE}
    SHR AL,1
    SHR AL,1
    SHR AL,1
   {$ENDIF}
   MOV BL,G
   AND BX,00F8h
   {$IFOPT G+}
    SHR BX,3
   {$ELSE}
    SHL BX,1
    SHL BX,1
    SHL BX,1
   {$ENDIF}
   ADD AX,BX
   MOV @Result,AX
  END;
 End;
End;

Procedure Color2RGB(Color:Word;Var Q:RGB);Begin
 _Color2RGB(Color,BitsPerPixel,Q);
End;

Procedure _Color2RGB(Color:Word;BitsPerPixel:Byte;Var Q:RGB);Begin
 Case(BitsPerPixel)of
  4:Q:=DefaultRGB[Color and$F];
  8:GetPaletteRGB(Q,Color,1);
  15:ASM
   {$IFDEF FLAT386}
    LEA EDX,Q
    MOV AX,Color
    MOV BX,AX
    AND AL,11111b
    SHL AL,3
    MOV [EDX+2],AL
    MOV AX,BX
    AND AX,1111100000b
    SHR AX,2
    MOV [EDX+1],AL
    SHL BH,1
    AND BH,11111000b
    MOV [EDX],BH
   {$ELSE}
    LES DI,Q
    MOV AX,Color
    MOV BX,AX
    AND AL,11111b
    {$IFOPT G+}
     SHL AL,3
    {$ELSE}
     SHL AL,1
     SHL AL,1
     SHL AL,1
    {$ENDIF}
    MOV ES:[DI+2],AL
    MOV AX,BX
    AND AX,1111100000b
    {$IFOPT G+}
     SHR AX,2
    {$ELSE}
     SHR AX,1
     SHR AX,1
    {$ENDIF}
    MOV ES:[DI+1],AL
    SHL BH,1
    AND BH,11111000b
    MOV ES:[DI],BH
   {$ENDIF}
  END;
  16:ASM
   {$IFDEF FLAT386}
    LEA EDX,Q
    MOV AX,Color
    MOV BX,AX
    AND AL,11111b
    SHL AL,3
    MOV [EDX+2],AL
    MOV AX,BX
    AND AX,11111100000b
    SHR AX,3
    MOV [EDX+1],AL
    AND BH,11111000b
    MOV [EDX],BH
   {$ELSE}
    LES DI,Q
    MOV AX,Color
    MOV BX,AX
    AND AL,11111b
    {$IFOPT G+}
     SHL AL,3
    {$ELSE}
     SHL AL,1
     SHL AL,1
     SHL AL,1
    {$ENDIF}
    MOV ES:[DI+2],AL
    MOV AX,BX
    AND AX,11111100000b
    {$IFOPT G+}
     SHR AX,3
    {$ELSE}
     SHR AX,1
     SHR AX,1
     SHR AX,1
    {$ENDIF}
    MOV ES:[DI+1],AL
    AND BH,11111000b
    MOV ES:[DI],BH
   {$ENDIF}
  END;
 End;
End;

Function GetGrayColor(Value:Byte):Word;Begin
 GetGrayColor:=RGB2Color(Value,Value,Value);
End;

Function GetClassicToColor(Color:Byte):Word;Begin
 If BitsPerPixel>8Then
  GetClassicToColor:=RGB2Color(DefaultRGB[Color].R,DefaultRGB[Color].G,DefaultRGB[Color].B)
 Else
  GetClassicToColor:=Color;
End;

Function GetPalette(Var Palette;Num:Word):Word;
Var
 PaletteWord:Array[0..15]of Word Absolute Palette;
 PaletteByte:Array[0..15]of Byte Absolute Palette;
Begin
 Case(BitsPerPixel)of
  8:GetPalette:=PaletteByte[Num];
  Else GetPalette:=PaletteWord[Num];
 End;
End;

Procedure MakePaletteColorTo(Color:Byte;Num:Word;Inverse:Boolean;Var Palette);
Var
 PaletteWord:Array[0..15]of Word Absolute Palette;
 PaletteByte:Array[0..15]of Byte Absolute Palette;
 I,J:Word;
 NewColor:Word;
Begin
 ASM
  AND Color,0Fh
  DEC Num
 END;
 For I:=0to(Num)do Begin
  If(BitsPerPixel>=15)and(Color=7)Then Begin
   J:=64+(I shl 5);
   NewColor:=RGB2Color(J,J,J);
  End
   Else
  NewColor:=RGB2Color((DefaultRGB[Color].R*I)shr 3,
                      (DefaultRGB[Color].G*I)shr 3,
                      (DefaultRGB[Color].B*I)shr 3);
  If(Inverse)Then J:=Num-I
             Else J:=I;
  Case(BitsPerPixel)of
   8:PaletteByte[J]:=NewColor;
   Else PaletteWord[J]:=NewColor;
  End;
 End;
End;

Procedure MakePaletteColorToWhite(Color:Byte;Num:Word;Var Palette);Begin
 MakePaletteColorTo(Color,Num,False,Palette);
End;

Procedure MakePaletteWhiteToColor(Color:Byte;Num:Word;Var Palette);Begin
 MakePaletteColorTo(Color,Num,True,Palette);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                    Proc‚dure Conv4BitsMotorola2IntelKr              Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de convertir des couleurs 4 bits de couleurs de
 format Motorola  de format lin‚aire  en son  format INTEL. Il n'est pas
 convertie en 4 "plane"  cependant et  est donc conserv‚e en raison de 2
 pixel par octet.


 Remarque
 ÍÍÍÍÍÍÍÍ

  ş Voici l'algorithme Pascal d'origine de cette proc‚dure:
    ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
    ³ Procedure Conv4BitsMotorola2IntelKr(BytesPerLine:Word;           ³
    ³         Var Line:Array of Byte);Near;Var I:Byte;Begin            ³
    ³  For I:=0to BytesPerLine-1do Begin                               ³
    ³   Line[I]:=(MotorolaColor[Line[I]and$F]and$F)+                   ³
    ³            (MotorolaColor[Line[I]shr 4]shl 4);                   ³
    ³  End;                                                            ³
    ³ End;                                                             ³
    ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
}

Procedure Conv4BitsMotorola2IntelKr(BytesPerLine:Word;Var Line:Array of Byte);Assembler;ASM
 {$IFDEF FLAT386}
 {$ELSE}
  MOV CX,BytesPerLine
  LES DI,Line
  MOV BX,Offset MotorolaColor
 @1:
  MOV AL,ES:[DI]
  MOV AH,AL
  AND AL,0Fh
  {$IFOPT G+}
   SHR AH,4
  {$ELSE}
   SHR AH,1
   SHR AH,1
   SHR AH,1
   SHR AH,1
  {$ENDIF}
  XLAT
  XCHG AL,AH
  XLAT
  {$IFOPT G+}
   SHL AL,4
  {$ELSE}
   SHL AL,1
   SHL AL,1
   SHL AL,1
   SHL AL,1
  {$ENDIF}
  OR  AL,AH
  STOSB
  LOOP @1
 {$ENDIF}
END;

{ Cette fonction permet de convertir des lignes images en format 4 planes de
 de  bit  d'image   (16 couleurs)  en format lin‚aire BitMap … la Macintosh.
 Principalement utilis‚ pour convertir des images sauvegarder en fonction du
 mat‚riel EGA et VGA.
}

Function Conv4Planes2BitMap(BytesPerLine:Word;Var Line:Array of Byte):Boolean;
Var
 XL:Array[0..7]of Byte;
 PPln:^TByte;
 Base,XBytes,BT,P1,P2,P3,P4:Word;
 IBit,AndMask:Byte;
Begin
  { Transformation de 4 planes en BitMap }
 PPln:=MemAlloc(BytesPerLine);
 If(PPln<>NIL)Then Begin
  XBytes:=BytesPerLine shr 2;BT:=0;P1:=0;P2:=XBytes;P3:=XBytes shl 1;P4:=P2+P3;
  For Base:=0to XBytes-1do Begin
   For IBit:=0to 7do Begin
    AndMask:=1shl IBit;
    XL[7-IBit]:=(((Line[P1]and AndMask)shr IBit)shl 0)+
                (((Line[P2]and AndMask)shr IBit)shl 1)+
                (((Line[P3]and AndMask)shr IBit)shl 2)+
                (((Line[P4]and AndMask)shr IBit)shl 3);
   End;
   Inc(P1);Inc(P2);Inc(P3);Inc(P4);
   For IBit:=0to 3do Begin
    PPln^[BT]:=(XL[IBit shl 1]shl 4)+XL[(IBit shl 1)+1];
    Inc(BT);
   End;
  End;
  MoveLeft(PPln^,Line,BytesPerLine);
  FreeMemory(PPln,BytesPerLine);
  Conv4Planes2BitMap:=True;
 End
  Else
 Conv4Planes2BitMap:=False;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Proc‚dure InverseOrderLine                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'inverser l'ordre des lignes, c'est-…-dire que la
 premiŠre  ligne  se  retrouvera  en  dernier,  la dernier  en premier,  la
 deuxiŠme  en avant derniŠre,  l'avant-derniŠre  en deuxiŠme,  et  ainsi de
 suite...
}

Procedure InverseOrderLine{Var Buffer;Size,BytesPerLine,NumYPixels:Word};Assembler;ASM
 {$IFDEF FLAT386}
 {$ELSE}
  CLD
  PUSH DS
   LDS SI,Buffer
   LES DI,Buffer
   ADD DI,Size
   MOV BX,NumYPixels
   SHR BX,1
   MOV DX,BytesPerLine
   OR  DX,DX
   JZ  @End
@1: MOV CX,DX
   JCXZ @End
   SUB DI,CX
@2:MOV AH,ES:[DI]
   MOVSB
   MOV DS:[SI-1],AH
   LOOP @2
   SUB DI,DX
   DEC BX
   JNZ @1
 @End:
  POP DS
 {$ENDIF}
END;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                     Proc‚dure Update4BitsKrShadow                 Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de fixer une couleur  de fond pr‚cise dans un
 tableau lin‚aire de 16 couleur (4 bits) … partir d'un tableau binaire
 (shadow).


 Remarque
 ÍÍÍÍÍÍÍÍ

  ş Voici l'algorithme en langage Pascal de cette proc‚dure:
    ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
    ³ BS:=0;                                                         ³
    ³ For I:=0to NBS-1do Begin                                       ³
    ³  If Shadow[PS]and $80=$80Then                                  ³
    ³   Buffer[BS]:=(Buffer[BS] and$F)+(Kr shl 4);                   ³
    ³  If Shadow[PS]and $40=$40Then                                  ³
    ³   Buffer[BS]:=(Buffer[BS] and$F0)+Kr;                          ³
    ³  Inc(BS);                                                      ³
    ³  If Shadow[PS]and $20=$20Then                                  ³
    ³   Buffer[BS]:=(Buffer[BS] and$F)+(Kr shl 4);                   ³
    ³  If Shadow[PS]and $10=$10Then                                  ³
    ³   Buffer[BS]:=(Buffer[BS] and$F0)+Kr;                          ³
    ³  Inc(BS);                                                      ³
    ³  If Shadow[PS]and 8=8Then                                      ³
    ³   Buffer[BS]:=(Buffer[BS] and$F)+(Kr shl 4);                   ³
    ³  If Shadow[PS]and 4=4Then                                      ³
    ³   Buffer[BS]:=(Buffer[BS] and$F0)+Kr;                          ³
    ³  Inc(BS);                                                      ³
    ³  If Shadow[PS]and 2=2Then                                      ³
    ³   Buffer[BS]:=(Buffer[BS] and$F)+(Kr shl 4);                   ³
    ³  If Shadow[PS]and 1=1Then                                      ³
    ³   Buffer[BS]:=(Buffer[BS] and$F0)+Kr;                          ³
    ³  Inc(BS);                                                      ³
    ³  Inc(PS);                                                      ³
    ³ End;                                                           ³
    ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
}

Procedure Update4BitsKrShadow{Const Shadow;Var Buffer;Len:Word;Kr:Byte};Assembler;ASM
 {$IFDEF FLAT386}
 {$ELSE}
  CLD
  PUSH DS
   LDS SI,Shadow
   LES DI,Buffer
   MOV CX,Len
   MOV BL,Kr
   MOV BH,BL
   AND BL,0Fh
   {$IFOPT G+}
    SHL BH,4
   {$ELSE}
    SHL BH,1
    SHL BH,1
    SHL BH,1
    SHL BH,1
   {$ENDIF}
@0:LODSB
   MOV DL,ES:[DI]
   TEST AL,80h
   JZ   @1
   AND DL,0Fh
   OR  DL,BH
@1:TEST AL,40h
   JZ   @2
   AND DL,0F0h
   OR  DL,BL
@2:MOV ES:[DI],DL
   INC DI
   MOV DL,ES:[DI]
   TEST AL,20h
   JZ   @3
   AND DL,0Fh
   OR  DL,BH
@3:TEST AL,10h
   JZ   @4
   AND DL,0F0h
   OR  DL,BL
@4:MOV ES:[DI],DL
   INC DI
   MOV DL,ES:[DI]
   TEST AL,08h
   JZ   @5
   AND DL,0Fh
   OR  DL,BH
@5:TEST AL,04h
   JZ   @6
   AND DL,0F0h
   OR  DL,BL
@6:MOV ES:[DI],DL
   INC DI
   MOV DL,ES:[DI]
   TEST AL,02h
   JZ   @7
   AND DL,0Fh
   OR  DL,BH
@7:TEST AL,01h
   JZ   @8
   AND DL,0F0h
   OR  DL,BL
@8:MOV ES:[DI],DL
   INC DI
   LOOP @0
  POP DS
 {$ENDIF}
END;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                      Proc‚dure Conv4To8BitsKr                    Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de convertir une couleur 4 bits en 8 bits de
 couleur en prenant pour acquit  que leur ‚quivalent est situ‚e entre
 0 et 15.
}

Procedure Conv4To8BitsKr(Const Source;Var Dest;Len:Word);Assembler;ASM
 {$IFDEF FLAT386}
 {$ELSE}
  PUSH DS
   CLD
   LDS SI,Source
   LES DI,Dest
   MOV CX,Len
   JCXZ @End
 @Loop:
   LODSB
   MOV AH,AL
   AND AH,0Fh
   {$IFOPT G+}
    SHR AL,4
   {$ELSE}
    SHR AL,1
    SHR AL,1
    SHR AL,1
    SHR AL,1
   {$ENDIF}
   STOSW
   LOOP @Loop
 @End:
  POP DS
 {$ENDIF}
END;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                      Proc‚dure Conv8To4BitsKr                    Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de convertir une couleur 8 bits en 4 bits de
 couleur en prenant pour acquit  que leur ‚quivalent est situ‚e entre
 0 et 15.
}

Procedure Conv8To4BitsKr(Const Source;Var Dest;Len:Word);Assembler;ASM
 {$IFDEF FLAT386}
 {$ELSE}
  PUSH DS
   CLD
   LDS SI,Source
   LES DI,Dest
   MOV CX,Len
   JCXZ @End
 @Loop:
   LODSW
   AND AH,0Fh
   {$IFOPT G+}
    SHL AL,4
   {$ELSE}
    SHL AL,1
    SHL AL,1
    SHL AL,1
    SHL AL,1
   {$ENDIF}
   OR AL,AH
   STOSB
   LOOP @Loop
 @End:
  POP DS
 {$ENDIF} 
END;

{ Cette proc‚dure permet la conversion de coordonn‚es textes en coordonn‚es
 de format graphique.
}

{Procedure CoordTxt2Graph(Const Txt;Var Graph);
Var T:Record X1,Y1,X2,Y2:Byte;End Absolute Txt;
    G:Record X1,Y1,X2,Y2:Word;End Absolute Graph;
Begin
 G.X1:=T.X1 shl 3;G.Y1:=GetRawY(T.Y1);
 G.X2:=(T.X2 shl 3)+7;G.Y2:=GetRawY(T.Y2+1)-1;
End;}

Procedure CoordTxt2Graph(Const Txt;Var Graph);
{$IFDEF FLAT386}
 Var
  T:Record X1,Y1,X2,Y2:Byte;End Absolute Txt;
  G:Record X1,Y1,X2,Y2:Word;End Absolute Graph;
 Begin
  G.X1:=T.X1 shl 3;G.Y1:=GetRawY(T.Y1);
  G.X2:=(T.X2 shl 3)+7;G.Y2:=GetRawY(T.Y2+1)-1;
 End;
{$ELSE}
 Assembler;ASM
  PUSH DS
   CLD
   LDS SI,Txt
   LES DI,Graph
   LODSB
   XOR AH,AH
   {$IFOPT G+}
    SHL AX,1
   {$ELSE}
    SHL AX,1
    SHL AX,1
    SHL AX,1
   {$ENDIF}
   STOSW
   LODSB
   PUSH AX
   CALL GetRawY
   STOSW
   LODSB
   XOR AH,AH
   INC AX
   {$IFOPT G+}
    SHL AX,1
   {$ELSE}
    SHL AX,1
    SHL AX,1
    SHL AX,1
   {$ENDIF}
   DEC AX
   STOSW
   LODSB
   INC AX
   PUSH AX
   CALL GetRawY
   DEC AX
   STOSW
  POP DS
 END;
{$ENDIF}

Procedure CoordGraph(Var Graph;X1,Y1,X2,Y2:SmallInt);Assembler;ASM
 {$IFDEF Real}
  PUSH DS
   CLD
   LDS SI,Graph
   LES DI,Graph
   LODSW
   ADD AX,X1
   STOSW
   LODSW
   ADD AX,Y1
   STOSW
   LODSW
   ADD AX,X2
   STOSW
   LODSW
   ADD AX,Y2
   STOSW
  POP DS
 {$ENDIF}
END;

{Procedure PutBoxRect(X,Y:Byte;Var Q:BoxRectRec);
Var
 T:TextBoxRec;
 G:GraphBoxRec;
Begin
 If(IsGrf)Then Begin
  T.X1:=X;T.Y1:=Y;T.X2:=X+Q.MaxXTexts;T.Y2:=Y;
  CoordTxt2Graph(T,G);
  __PutSmlImg(G,Q.Up^);
  T.Y1:=Y+1;T.X2:=X;T.Y2:=Y+Q.MaxYTexts-1;
  CoordTxt2Graph(T,G);
  __PutSmlImg(G,Q.Left^);
  T.X1:=X+Q.MaxXTexts;T.X2:=T.X1;
  CoordTxt2Graph(T,G);
  __PutSmlImg(G,Q.Right^);
  T.X1:=X;T.Y1:=Y+Q.MaxYTexts;T.X2:=X+Q.MaxXTexts;T.Y2:=T.Y1;
  CoordTxt2Graph(T,G);
  __PutSmlImg(G,Q.Down^);
 End
  Else
 PutBoxTxt(X,Y,X+Q.MaxXTexts,Y+Q.MaxYTexts,Q.Up^);
End;}

Procedure PutBoxRect(X,Y:Byte;Var Q:BoxRectRec);
{$IFDEF FLAT386}
 Var
  T:TextBoxRec;
  G:GraphBoxRec;
 Begin
  If(IsGrf)Then Begin
   T.X1:=X;T.Y1:=Y;T.X2:=X+Q.MaxXTexts;T.Y2:=Y;
   CoordTxt2Graph(T,G);
   __PutSmlImg(G,Q.Up^);
   T.Y1:=Y+1;T.X2:=X;T.Y2:=Y+Q.MaxYTexts-1;
   CoordTxt2Graph(T,G);
   __PutSmlImg(G,Q.Left^);
   T.X1:=X+Q.MaxXTexts;T.X2:=T.X1;
   CoordTxt2Graph(T,G);
   __PutSmlImg(G,Q.Right^);
   T.X1:=X;T.Y1:=Y+Q.MaxYTexts;T.X2:=X+Q.MaxXTexts;T.Y2:=T.Y1;
   CoordTxt2Graph(T,G);
   __PutSmlImg(G,Q.Down^);
  End
   Else
  PutBoxTxt(X,Y,X+Q.MaxXTexts,Y+Q.MaxYTexts,Q.Up^);
 End;
{$ELSE}
 Var
  T:TextBoxRec;
  G:GraphBoxRec;
 Begin
  If(IsGrf)Then Begin
   ASM
     {T.X1:=X;T.Y1:=Y;T.X2:=X+Q.MaxXTexts;T.Y2:=Y;}
    LES DI,Q
    MOV AL,X
    MOV AH,Y
    MOV Word Ptr T.X1,AX
    ADD AL,Byte Ptr ES:[DI].BoxRectRec.MaxXTexts
    MOV Word Ptr T.X2,AX
   END;
   CoordTxt2Graph(T,G);
   __PutSmlImg(G,Q.Up^);
   ASM
    {T.Y1:=Y+1;T.X2:=X;T.Y2:=Y+Q.MaxYTexts-1;}
    LES DI,Q
    MOV AL,Y
    MOV AH,X
    INC AX
    MOV Word Ptr T.Y1,AX
    DEC AX
    ADD AL,Byte Ptr ES:[DI].BoxRectRec.MaxYTexts
    DEC AX
    MOV T.Y2,AL
   END;
   CoordTxt2Graph(T,G);
   __PutSmlImg(G,Q.Left^);
   ASM
    {T.X1:=X+Q.MaxXTexts;T.X2:=T.X1;}
    LES DI,Q
    MOV AL,X
    ADD AL,ES:[DI].BoxRectRec.MaxXTexts
    MOV T.X1,AL
    MOV T.X2,AL
   END;
   CoordTxt2Graph(T,G);
   __PutSmlImg(G,Q.Right^);
   ASM
     {T.X1:=X;T.Y1:=Y+Q.MaxYTexts;T.X2:=X+Q.MaxXTexts;T.Y2:=T.Y1;}
    LES DI,Q
    MOV BX,Word Ptr ES:[DI].BoxRectRec.MaxXTexts
    MOV AL,X
    MOV AH,Y
    ADD AH,BH
    MOV Word Ptr T.X1,AX
    ADD AL,BL
    MOV Word Ptr T.X2,AX
   END;
   CoordTxt2Graph(T,G);
   __PutSmlImg(G,Q.Down^);
  End
   Else
  ASM
    {PutBoxTxt(X,Y,X+Q.MaxXTexts,Y+Q.MaxYTexts,Q.Up^);}
   LES DI,Q
   MOV AL,X
   MOV AH,Y
   PUSH AX
   MOV BL,AH
   PUSH BX
   ADD AX,Word Ptr ES:[DI].BoxRectRec.MaxXTexts
   PUSH AX
   MOV AL,AH
   PUSH AX
   LES DI,ES:[DI].BoxRectRec.Up
   PUSH ES
   PUSH DI
   PUSH CS
   CALL Near Ptr PutBoxTxt
  END;
 End;
{$ENDIF}

Procedure ReSaveBoxRect(X,Y:Byte;Var Q:BoxRectRec);
Var
 T:TextBoxRec;
 G:GraphBoxRec;
Begin
 ASM
  {$IFDEF FLAT386}
    {Q.LastX:=X;Q.LastY:=Y;}
   LEA EDX,Q
   MOV AL,X
   MOV AH,Y
   MOV Word Ptr [EDX].BoxRectRec.LastX,AX
  {$ELSE}
    {Q.LastX:=X;Q.LastY:=Y;}
   LES DI,Q
   MOV AL,X
   MOV AH,Y
   MOV Word Ptr ES:[DI].BoxRectRec.LastX,AX
  {$ENDIF}
 END;
 If(IsGrf)Then Begin
  ASM
   {$IFDEF FLAT386}
     {TX1:=X;TY1:=Y;TX2:=X+Q.MaxXTexts;TY2:=Y;}
    LEA EDX,Q
    MOV AL,X
    MOV AH,Y
    MOV Word Ptr T.X1,AX
    ADD AL,Byte Ptr [EDX].BoxRectRec.MaxXTexts
    MOV Word Ptr T.X2,AX
   {$ELSE}
     {TX1:=X;TY1:=Y;TX2:=X+Q.MaxXTexts;TY2:=Y;}
    LES DI,Q
    MOV AL,X
    MOV AH,Y
    MOV Word Ptr T.X1,AX
    ADD AL,Byte Ptr ES:[DI].BoxRectRec.MaxXTexts
    MOV Word Ptr T.X2,AX
   {$ENDIF}
  END;
  CoordTxt2Graph(T,G);
  Q.GX1:=G.X1;Q.GY1:=G.Y1;
  If(Q.Up<>NIL)Then __GetSmlImg(G,Q.Up^);
  ASM
   {$IFDEF FLAT386}
     {T.Y1:=Y+1;T.X2:=X;T.Y2:=Y+Q.MaxYTexts-1;}
    LEA EDX,Q
    MOV AL,Y
    MOV AH,X
    INC AX
    MOV Word Ptr T.Y1,AX
    DEC AX
    ADD AL,Byte Ptr [EDX].BoxRectRec.MaxYTexts
    DEC AX
    MOV T.Y2,AL
   {$ELSE}
     {T.Y1:=Y+1;T.X2:=X;T.Y2:=Y+Q.MaxYTexts-1;}
    LES DI,Q
    MOV AL,Y
    MOV AH,X
    INC AX
    MOV Word Ptr T.Y1,AX
    DEC AX
    ADD AL,Byte Ptr ES:[DI].BoxRectRec.MaxYTexts
    DEC AX
    MOV T.Y2,AL
   {$ENDIF}
  END;
  CoordTxt2Graph(T,G);
  If(Q.Left<>NIL)Then __GetSmlImg(G,Q.Left^);
  ASM
   {$IFDEF FLAT386}
     {T.X1:=X+Q.MaxXTexts;T.X2:=T.X1;}
    LEA EDX,Q
    MOV AL,X
    ADD AL,[EDX].BoxRectRec.MaxXTexts
    MOV T.X1,AL
    MOV T.X2,AL
   {$ELSE}
     {T.X1:=X+Q.MaxXTexts;T.X2:=T.X1;}
    LES DI,Q
    MOV AL,X
    ADD AL,ES:[DI].BoxRectRec.MaxXTexts
    MOV T.X1,AL
    MOV T.X2,AL
   {$ENDIF}
  END;
  CoordTxt2Graph(T,G);
  If(Q.Right<>NIL)Then __GetSmlImg(G,Q.Right^);
  ASM
   {$IFDEF FLAT386}
     {T.X1:=X;T.Y1:=Y+Q.MaxYTexts;T.X2:=X+Q.MaxXTexts;T.Y2:=T.Y1;}
    LEA EDX,Q
    MOV BX,Word Ptr [EDX].BoxRectRec.MaxXTexts
    MOV AL,X
    MOV AH,Y
    ADD AH,BH
    MOV Word Ptr T.X1,AX
    ADD AL,BL
    MOV Word Ptr T.X2,AX
   {$ELSE}
     {T.X1:=X;T.Y1:=Y+Q.MaxYTexts;T.X2:=X+Q.MaxXTexts;T.Y2:=T.Y1;}
    LES DI,Q
    MOV BX,Word Ptr ES:[DI].BoxRectRec.MaxXTexts
    MOV AL,X
    MOV AH,Y
    ADD AH,BH
    MOV Word Ptr T.X1,AX
    ADD AL,BL
    MOV Word Ptr T.X2,AX
   {$ENDIF}
  END;
  CoordTxt2Graph(T,G);
  Q.GX2:=G.X2;Q.GY2:=G.Y2;
  If(Q.Down<>NIL)Then __GetSmlImg(G,Q.Down^);
 End
  Else
 {$IFDEF FLAT386}
  CopyBoxTxt(X,Y,X+Q.MaxXTexts,Y+Q.MaxYTexts,Q.Up^);
 {$ELSE}
  ASM
    {CopyBoxTxt(X,Y,X+Q.MaxXTexts,Y+Q.MaxYTexts,Q.Up^);}
   LES DI,Q
   MOV AL,X
   MOV AH,Y
   PUSH AX
   MOV BL,AH
   PUSH BX
   ADD AX,Word Ptr ES:[DI].BoxRectRec.MaxXTexts
   PUSH AX
   MOV AL,AH
   PUSH AX
   LES DI,ES:[DI].BoxRectRec.Up
   PUSH ES
   PUSH DI
   PUSH CS
   CALL Near Ptr CopyBoxTxt
  END;
 {$ENDIF}
End;

{Procedure _PutBoxRect(Var Q:BoxRectRec);Begin
 PutBoxRect(Q.LastX,Q.LastY,Q);
End;}

Procedure _PutBoxRect(Var Q:BoxRectRec);Assembler;ASM
 {$IFDEF FLAT386}
  XCHG ECX,EAX
  MOV AX,Word Ptr [ECX].BoxRectRec.LastX
  MOV DL,AH
  CALL PutBoxRect
 {$ELSE}
  LES DI,Q
  MOV AX,Word Ptr ES:[DI].BoxRectRec.LastX
  PUSH AX
  MOV AL,AH
  PUSH AX
  PUSH ES
  PUSH DI
  PUSH CS
  CALL Near Ptr PutBoxRect
 {$ENDIF}
END;

Function SaveBoxRect(X1,Y1,X2,Y2:Byte;Var Q:BoxRectRec):Boolean;
Label UpF,DnF;
Var
 T:TextBoxRec;
 G:GraphBoxRec;
Begin
 SaveBoxRect:=False;
 FillClr(Q,SizeOf(Q));
 ASM
  {$IFDEF FLAT386}
    {Q.MaxXTexts:=X2-X1;Q.MaxYTexts:=Y2-Y1;}
   LEA EDX,DWord Ptr Q
   MOV AL,X2
   MOV AH,Y2
   MOV BL,X1
   MOV BH,Y1
   SUB AX,BX
   MOV Word Ptr [EDX].BoxRectRec.MaxXTexts,AX
  {$ELSE}
    {Q.MaxXTexts:=X2-X1;Q.MaxYTexts:=Y2-Y1;}
   LES DI,Q
   MOV AL,X2
   MOV AH,Y2
   MOV BL,X1
   MOV BH,Y1
   SUB AX,BX
   MOV Word Ptr ES:[DI].BoxRectRec.MaxXTexts,AX
  {$ENDIF}
 END;
 If(IsGrf)Then Begin
  ASM
    {T.X1:=X1;T.Y1:=Y1;T.X2:=X2;T.Y2:=Y1;}
   MOV AL,X1
   MOV AH,Y1
   MOV Word Ptr T.X1,AX
   MOV AL,X2
   MOV AH,Y2
   MOV Word Ptr T.X2,AX
  END;
  CoordTxt2Graph(T,G);
  Q.UpSize:=__GetSizeSmlImg(G);
  Q.DownSize:=Q.UpSize;
  ASM
   {T.X1:=X1;T.Y1:=Y1+1;T.X2:=X1;T.Y2:=Y2-1;}
   MOV AL,X1
   MOV AH,Y1
   INC AH
   MOV Word Ptr T.X1,AX
   MOV AH,Y2
   DEC AH
   MOV Word Ptr T.X2,AX
  END;
  CoordTxt2Graph(T,G);
  Q.LeftSize:=__GetSizeSmlImg(G);
  Q.RightSize:=Q.LeftSize;
  Q.Up:=MemAlloc(Q.UpSize);
  If(Q.Up<>NIL)Then Begin
   Q.Down:=MemAlloc(Q.DownSize);
   If(Q.Down<>NIL)Then Begin
    Q.Left:=MemAlloc(Q.LeftSize);
    If(Q.Left<>NIL)Then Begin
     Q.Right:=MemAlloc(Q.RightSize);
     If(Q.Right<>NIL)Then Begin
      ReSaveBoxRect(X1,Y1,Q);
      SaveBoxRect:=True;
     End
      Else
     Begin
      FreeMemory(Q.Left,Q.LeftSize);
      Goto DnF;
     End;
    End
     Else
    Begin
 DnF:FreeMemory(Q.Down,Q.DownSize);
     Goto UpF;
    End;
   End
    Else
 UpF:FreeMemory(Q.Up,Q.UpSize);
  End;
 End
  Else
 Begin
  Q.UpSize:=SizeBoxTxt(X1,Y1,X2,Y2);
  Q.Up:=MemAlloc(Q.UpSize);
  If(Q.Up<>NIL)Then Begin
   ReSaveBoxRect(X1,Y1,Q);
   SaveBoxRect:=True;
  End;
 End;
End;

{Function _SaveBoxRect(Const X;Var Q:BoxRectRec):Boolean;
Var T:Record X1,Y1,X2,Y2:Byte;End Absolute X;Begin
 _SaveBoxRect:=SaveBoxRect(T.X1,T.Y1,T.X2,T.Y2,Q);
End;}

Function _SaveBoxRect(Const X;Var Q:BoxRectRec):Boolean;
{$IFDEF FLAT386}
 Var
  T:Record
   X1,Y1,X2,Y2:Byte;
  End Absolute X;
 Begin
  _SaveBoxRect:=SaveBoxRect(T.X1,T.Y1,T.X2,T.Y2,Q);
 End;
{$ELSE}
 Assembler;ASM
  LES DI,X
  LES AX,DWord Ptr ES:[DI].TextBoxRec.X1
  PUSH AX
  MOV AL,AH
  PUSH AX
  PUSH ES
  MOV AX,ES
  MOV AL,AH
  PUSH AX
  LES DI,Q
  PUSH ES
  PUSH DI
  PUSH CS
  CALL Near Ptr SaveBoxRect
 END;
{$ENDIF}

Procedure RestoreBoxRect(Var Q:BoxRectRec);Begin
 FreeMemory(Q.Up,Q.UpSize);
 FreeMemory(Q.Left,Q.LeftSize);
 FreeMemory(Q.Right,Q.RightSize);
 FreeMemory(Q.Down,Q.DownSize);
 FillClr(Q,SizeOf(Q));
End;

Function __GetSizeSmlImg(Var Q):Word;
{$IFDEF FLAT386}
 Var
  G:GraphBoxRec Absolute Q;
 Begin
  __GetSizeSmlImg:=GetSizeSmlImg(G.X1,G.Y1,G.X2,G.Y2);
 End;
{$ELSE}
 Assembler;ASM
  MOV DX,DS
  LDS SI,Q
  CLD
  LODSW
  PUSH AX
  LODSW
  PUSH AX
  LODSW
  PUSH AX
  LODSW
  PUSH AX
  MOV DS,DX
  CALL GetSizeSmlImg
 END;
{$ENDIF}

{Procedure __PutRect(Const Coord;Kr:Word);Var Q:GraphBoxRec Absolute Coord;Begin
 PutRect(Q.X1,Q.Y1,Q.X2,Q.Y2,Kr);
End;}

Procedure __PutRect(Const Coord;Kr:Word);
{$IFDEF FLAT386}
 Var
  Q:GraphBoxRec Absolute Coord;
 Begin
  PutRect(Q.X1,Q.Y1,Q.X2,Q.Y2,Kr);
 End;
{$ELSE}
 Assembler;ASM
  MOV DX,DS
  LDS SI,Coord
  CLD
  LODSW
  PUSH AX
  LODSW
  PUSH AX
  LODSW
  PUSH AX
  LODSW
  PUSH AX
  MOV DS,DX
  PUSH Kr
  CALL PutRect
 END;
{$ENDIF}

Procedure __PutFillBox2LineStyle(Var Q;Color1,Color2:Word);
Var
 G:GraphBoxRec Absolute Q;
 Color:Word;
 J:Word;
Begin
 For J:=G.Y1 to(G.Y2)do Begin
  If J and 2=2Then Color:=Color2
              Else Color:=Color1;
  PutLnHor(G.X1,J,G.X2,Color);
 End;
End;

Procedure __PutFillBox2Line(Var Q);Begin
 __PutFillBox2LineStyle(Q,RGB2Color($DF,$DF,$FF),White);
End;

Procedure _LineBox2LineStyle(X1,Y,X2:Byte;Color1,Color2:Word);
Var
 G:GraphBoxRec;
Begin
 G.X1:=X1 shl 3;
 G.Y1:=GetRawY(Y);
 G.X2:=((X2+1)shl 3)-1;
 G.Y2:=G.Y1+HeightChr-1;
 __PutFillBox2LineStyle(G,Color1,Color2);
End;

Procedure _LineBox2Line(X1,Y,X2:Byte);Begin
 _LineBox2LineStyle(X1,Y,X2,RGB2Color($DF,$DF,$FF),White);
End;

Procedure __PutLnHor(Const Coord;Kr:Word);
{$IFDEF FLAT386}
 Var
  G:GraphBoxRec Absolute Coord;
 Begin
  PutLnHor(G.X1,G.Y1,G.X2,Kr);
 End;
{$ELSE}
 Assembler;ASM
  MOV DX,DS
  LDS SI,Coord
  CLD
  LODSW
  PUSH AX
  LODSW
   PUSH AX
  LODSW
  PUSH AX
  MOV DS,DX
  PUSH Kr
  CALL PutLnHor
 END;
{$ENDIF}

{Procedure __GraphBoxRelief(Const Coord;Attr:Byte);Var Q:GraphBoxRec Absolute Coord;Begin
 GraphBoxRelief(Q.X1,Q.Y1,Q.X2,Q.Y2,Attr);
End;}

Procedure __GraphBoxRelief(Const Q;Attr:Byte);
{$IFDEF FLAT386}
 Var
  G:GraphBoxRec Absolute Q;
 Begin
  GraphBoxRelief(G.X1,G.Y1,G.X2,G.Y2,Attr);
 End;
{$ELSE}
 Assembler;ASM
  MOV DX,DS
  LDS SI,Q
  CLD
  LODSW
  PUSH AX
  LODSW
  PUSH AX
  LODSW
  PUSH AX
  LODSW
  PUSH AX
  MOV DS,DX
  PUSH Word Ptr Attr
  CALL GraphBoxRelief
 END;
{$ENDIF}

Procedure PutAiguillon(X,Y:Byte);
Const Aiguillon:Array[0..7,0..3]of Byte=(
  ($8F,$FF,$FF,$F8),
  ($87,$77,$77,$78),
  ($F8,$77,$77,$8F),
  ($FF,$08,$80,$FF),
  ($00,$0F,$F0,$00),
  ($F8,$77,$77,$8F),
  ($87,$77,$77,$78),
  ($87,$77,$77,$78));
Var G:GraphPointRec;J:Byte;
Begin
 If(IsGrf)Then Begin
  {$IFDEF FLAT386}
   G.X:=X shl 3;G.Y:=GetRawY(Y)+((HeightChr-8)shr 1);
  {$ELSE}
   ASM
     {G.X:=X shl 3;G.Y:=GetRawY(Y)+((HeightChr-8)shr 1);}
    MOV AL,X
    MOV AH,Y
    PUSH AX
    PUSH SS
    MOV SI,Offset G
    ADD SI,BP
    PUSH SI
    PUSH CS
    CALL Near Ptr Word2Graph
   END;
  {$ENDIF} 
  Inc(G.Y,((HeightChr-8)shr 1));
  For J:=0to 7do Begin
   ClrLnHorImg(G.X,G.Y,8,4,Aiguillon[J,0]);
   Inc(G.Y);
  End;
  {$IFDEF FLAT386}
  {$ELSE}
   Mem[GetVideoSegBuf:(X+(Y*NmXTxts))shl 1]:=0;
  {$ENDIF}
 End;
End;

Function LocalBytesPerLine(NumXPixels:Word;BitsPerPixel:Byte):Word;
{$IFDEF __Windows__}
 Begin
  Case(BitsPerPixel)of
   1:LocalBytesPerLine:=NumXPixels shr 3;
   2..4:LocalBytesPerLine:=(NumXPixels shr 1);
   5..8:LocalBytesPerLine:=NumXPixels;
   9..16:LocalBytesPerLine:=NumXPixels shl 1;
   17..24:LocalBytesPerLine:=NumXPixels+(NumXPixels shl 1);
   25..32:LocalBytesPerLine:=NumXPixels shl 2;
  End;
 End;
{$ELSE}
 Assembler;ASM
  MOV BL,BitsPerPixel
  MOV BH,0
  MOV AX,NumXPixels
  CMP BX,25
  JAE @4G
  SHL BX,1
  JMP @Label.Word[BX]
 @Label:
  DW Offset @0     { 0 }
  DW Offset @2     { 1 }
  DW Offset @16    { 2 }
  DW Offset @16    { 3 }
  DW Offset @16    { 4 }
  DW Offset @End   { 5 }
  DW Offset @End   { 6 }
  DW Offset @End   { 7 }
  DW Offset @End   { 8 }
  DW Offset @65536 { 9 }
  DW Offset @65536 { 10 }
  DW Offset @65536 { 11 }
  DW Offset @65536 { 12 }
  DW Offset @65536 { 13 }
  DW Offset @65536 { 14 }
  DW Offset @65536 { 15 }
  DW Offset @65536 { 16 }
  DW Offset @16777216 { 17 }
  DW Offset @16777216 { 18 }
  DW Offset @16777216 { 19 }
  DW Offset @16777216 { 20 }
  DW Offset @16777216 { 21 }
  DW Offset @16777216 { 22 }
  DW Offset @16777216 { 23 }
  DW Offset @16777216 { 24 }
 @0:
  XOR AX,AX
  JMP @End
 @2:
  SHR AX,1
  SHR AX,1
  SHR AX,1
  JMP @End
 @16:
  SHR AX,1
  JMP @End
 @65536:
  SHL AX,1
  JMP @End
 @16777216:
  MOV BX,AX
  SHL BX,1
  ADD AX,BX
  JMP @End
 @4G:
  SHL BX,1
  SHL BX,1
 @End:
 END;
{$ENDIF}

Procedure PutTxtZUnKr(Z:Word;Const Str:String);Assembler;ASM
 {$IFDEF FLAT386}
  MOV ECX,EDX
  MOV DL,AH
  CALL PutTxtXYUnKr
 {$ELSE}
  MOV AX,Z
  PUSH AX
  MOV AL,AH
  PUSH AX
  LES DI,Str
  PUSH ES
  PUSH DI
  CALL PutTxtXYUnKr
 {$ENDIF}
END;

Procedure BarHorDials(X1,Y,X2,Attr:Byte);
Var
 T:TextBoxRec;  { Coordonn‚e texte de la barre horizontal }
 G:GraphBoxRec; { Coordonn‚e graphique de la barre horizontal }
 Kr:Byte;       { Couleur d'attribut }
Begin
 If(IsGrf)and(BitsPerPixel>=4)Then Begin
  ASM
    {T.X1:=X1+1;T.Y1:=Y;T.X2:=X2-1;}
   MOV AL,X1
   MOV AH,Y
   INC AX
   MOV Word Ptr T.X1,AX
   MOV AL,X2
   DEC AX
   MOV Word Ptr T.X2,AX
  END;
  CoordTxt2Graph(T,G);
  Inc(G.Y1,HeightChr shr 1);
  __PutLnHor(G,Attr and$F);
  If Attr shr 4=$FThen Kr:=$7 Else
  If Attr shr 4>8Then Kr:=Attr shr 5 Else
  If Attr and$F=$FThen Kr:=7
                  Else Kr:=$F;
  Inc(G.X1);Inc(G.Y1);
  __PutLnHor(G,Kr);
 End
  Else
 BarChrHor(X1+1,Y,X2-1,'Ä');
End;

{Function GetKeyKr:Byte;Begin
 If(kType=ktOS2Win)Then GetKeyKr:=$70
                   Else GetKeyKr:=$F0;
End;}

Function GetKeyKr:Byte;Assembler;ASM
 MOV AL,070h
 CMP kType,ktOS2Win
 JE  @End
 MOV AL,0F0h
@End:
END;

{Function GetKeySelKr:Byte;Begin
 If(kType=ktOS2Win)Then GetKeySelKr:=$7C Else
 If(kType>=ktElvis)Then GetKeySelKr:=CurrKrs.Dialog.Wins.kSel
                   Else GetKeySelKr:=CurrKrs.Dialog.Wins.Border;
End;}

Function GetKeySelKr:Byte;Assembler;ASM
(* MOV BL,kType
 AND BX,7
 SHL BX,1
 JMP @Label.Word[BX]
@Label:
 DW Offset @Big     { 0 }
 DW Offset @Elvis   { 1 }
 DW Offset @Elvis   { 2 }
 DW Offset @WinOS2  { 3 }
 DW Offset @Elvis   { 4 }
 DW Offset @Elvis   { 5 }
 DW Offset @Elvis   { 6 }
 DW Offset @Elvis   { 7 }
@Big:
 MOV AL,07Ch
 JMP @End
@Elvis:
 MOV AL,CurrKrs.Dialog.Wins.kSel
 JMP @End
@WinOS2:
 MOV AL,CurrKrs.Dialog.Wins.Border
@End:*)
 MOV AL,07Ch
 CMP kType,ktOS2Win
 JE  @End
 MOV AL,CurrKrs.Dialog.Window.kSel
 CMP kType,ktElvis
 JAE @End
 MOV AL,CurrKrs.Dialog.Window.Border
@End:
END;

{ Cette fonction transforme les coordonn‚es texte renferm‚s dans les deux
 mots (et non pas octets) en coordonn‚e graphique correspondante.
}

Procedure WordTxt2Graph(Var Q);Assembler;ASM
 {$IFDEF FLAT386}
  PUSH EDI
   LEA EDI,DWord Ptr Q
   MOV AX,[EDI]
   SHL AX,3
   STOSW
   MOV AX,[EDI]
   CALL GetRawY
   STOSW
  POP EDI
 {$ELSE}
  LES DI,Q
  CLD
  MOV AX,ES:[DI]
  {$IFOPT G+}
   SHL AX,3
  {$ELSE}
   SHL AX,1
   SHL AX,1
   SHL AX,1
  {$ENDIF}
  STOSW
  PUSH Word Ptr ES:[DI]
  CALL GetRawY
  STOSW
 {$ENDIF}
END;

Procedure Word2Graph(Z:Word;Var Q);Assembler;ASM
 {$IFDEF FLAT386}
  PUSH EDI
   LEA EDI,DWord Ptr Q
   CLD
   MOV BX,Z
   MOVZX AX,BL
   SHL AX,3
   STOSW
   MOV AL,BH
   CALL GetRawY
   STOSW
  POP EDI
 {$ELSE}
  LES DI,Q
  CLD
  MOV BX,Z
  MOV AL,BL
  MOV AH,0
  {$IFOPT G+}
   SHL AX,3
  {$ELSE}
   SHL AX,1
   SHL AX,1
   SHL AX,1
  {$ENDIF}
  STOSW
  MOV AL,BH
  PUSH AX
  CALL GetRawY
  STOSW
 {$ENDIF}
END;

Function GetHoriCenter(L:Byte):Byte;Assembler;ASM
 CALL NmXTxts
 SUB AL,L
 SHR AL,1
END;

Function GetVertCenter(H:Byte):Byte;Assembler;ASM
 CALL NmYTxts
 SUB AL,H
 SHR AL,1
END;

{$IFDEF __Windows__}
Function GetForeground(Attribut:Byte):Byte;Assembler;ASM
 MOV AL,Attribut
 AND AL,0Fh
END;
{$ENDIF}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Fonction DegradSupport                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction indique si le d‚grader dans les boŒtes de dialogue, par
 exemple, est support‚e par le mode vid‚o.
}

Function DegradSupport{:Boolean};Begin
 {$IFDEF __Windows__}
  DegradSupport:=True
 {$ELSE}
  DegradSupport:=(BitsPerPixel>4)or((IsMono)and(BitsPerPixel>=4))
 {$ENDIF}
End;

Function LoadGlyphs24:Boolean;Begin
 LoadGlyphs24:=LoadQQF('GLYPHS.QQF|glyphs 24');
End;

Function GetVideoBufPtr(X,Y:Byte):Pointer;Begin
 {$IFNDEF FLAT386}
  GetVideoBufPtr:=Ptr(GetVideoSegBuf,(Y*NmXTxts+X)shl 1);
 {$ENDIF}
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ·}
{³         F o n c t i o n  d e  C o l o r i m ‚ t r i e       º}
{ÔÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼}

{ Cette proc‚dure permet de transformer des couleurs en format CMYK en format
 RVB (RGB).
}

Procedure CMYK2RGB(C,Y,M,K:Byte;Var Q:RGB);
Var
 tk:Real;
Begin
 tk:=(255-k)/255;
 Q.R:=Round(C*tk+K);
 Q.G:=Round(Y*tk+K);
 Q.B:=Round(M*tk+K);
End;

Procedure HSI2RGB(H,S,I:Real;Var C:RGB);
Var
 t:Real;
 rv,gv,bv:Real;
 L:LongInt Absolute C;
Begin
 t:=h;
 rv:=1+s*Sin(t-2*pi/3);
 gv:=1+s*Sin(t);
 bv:=1+s*Sin(t+2*pi/3);
 t:=255.999*i/2;
 L:=Trunc(bv*t)+Trunc(gv*t) shl 8+Trunc(rv*t)shl 16;
End;

Procedure RGB2YUV(Source:RGB;Var Target:YUV);Begin
 Target.Y:=Trunc(0.3*Source.R+0.59*Source.G+0.11*Source.G);
 Target.U:=Trunc((Source.B-Target.Y)*0.493);
 Target.V:=Trunc((Source.R-Target.Y)*0.877);
End;

Procedure RGB2CMY(Source:RGB;Var Target:CMY);Begin
 Target.C:=1-Source.R;
 Target.M:=1-Source.G;
 Target.Y:=1-Source.B;
End;

Procedure CMY2RGB(Source:CMY;Var Target:RGB);Begin
 Target.R:=1-Source.C;
 Target.G:=1-Source.M;
 Target.B:=1-Source.Y;
End;

Procedure CMY2CMYK(Source:CMY;Var Target:CMYK);Begin
 Target.K:=Source.C;
 If(Target.K<Source.M)Then Target.K:=Source.M;
 If(Target.K<Source.Y)Then Target.K:=Source.Y;
 Target.C:=(Source.C-Target.K)div(1-Target.K);
 Target.M:=(Source.M-Target.K)div(1-Target.K);
 Target.Y:=(Source.Y-Target.K)div(1-Target.K);
End;

Function YIQ2RGB(Source:YIQ;Var Target:RGB):Boolean;
Var
 RR,GR,BR:Real;
Begin
 YIQ2RGB:=False;
 RR:=(Source.Y+(0.956*Source.I)+(0.621*Source.Q));
 GR:=(Source.Y-(0.272*Source.I)-(0.647*Source.Q));
 BR:=(Source.Y-(1.105*Source.I)+(1.702*Source.Q));
 If(RR<0)or(RR>1)or(GR<0)or(GR>1)or(BR<0)or(BR>1)Then Exit;
 Target.R:=Trunc(RR*256);
 Target.G:=Trunc(GR*256);
 Target.B:=Trunc(BR*256);
 YIQ2RGB:=True;
End;

Procedure RGB2YIQ(Source:RGB;Var Target:YIQ);Begin
 Target.Y:=((0.299*Source.R)+(0.587*Source.G)+(0.114*Source.B))/256;
 Target.I:=((0.596*Source.R)-(0.274*Source.G)-(0.322*Source.B))/256;
 Target.Q:=((0.212*Source.R)-(0.523*Source.G)+(0.311*Source.B))/256;
End;

Function XYZ2RGB(Source:XYZ;Var Target:RGB):LongInt;
Var
 R,G,B:Integer;
Begin
 XYZ2RGB:=0;
 { Utilise des points blanc D65 }
 R:=Trunc((3.063*Source.X-1.393*Source.Y-0.476*Source.Z)*255);
 If(R<0)or(R>255)Then Exit;
 G:=Trunc((-0.969*Source.X+1.876*Source.Y+0.042*Source.Z)*255);
 If(G<0)or(G>255)Then Exit;
 B:=Trunc((0.068*Source.X-0.229*Source.Y+1.069*Source.Z)*255);
 If(B<0)or(B>255)Then Exit;
 Target.R:=R;
 Target.G:=G;
 Target.B:=B;
 ASM
   { XYZ2RGB:=(255 shl 24)or(R shl 16)or(G shl 8)or(B);}
  MOV AL,Byte Ptr B
  MOV AH,Byte Ptr G
  MOV Word Ptr @Result,AX
  MOV AL,Byte Ptr R
  XOR AH,AH
  MOV Word Ptr @Result[2],AX
 END;
End;

Procedure RGB2XYZ(Source:RGB;Var Target:XYZ);
Var
 RR,GR,BR:Real;
Begin
  { scalaire entre [0,1]}
 RR:=0.0039215*Source.R; { 0..1 }
 GR:=0.0039215*Source.G; { 0..1 }
 BR:=0.0039215*Source.B; { 0..1 }
 Target.X:=0.431*RR+0.342*GR+0.178*BR;
 Target.Y:=0.222*RR+0.707*GR+0.071*BR;
 Target.Z:=0.020*RR+0.130*GR+0.939*BR;
End;

Procedure LAB2XYZ(L,A,B:Real;Var Target:XYZ);
Var
 Frac,Tmp:Real;
Begin
 Frac:=(L+16)/116;
 If L<7.9996Then Begin
  Target.Y:=L/903.3;
  Target.X:=A/3893.5+Target.Y;
  Target.Z:=Target.Y-B/1557.4;
 End
  Else
 Begin
  Tmp:=Frac+A/500;
  Target.X:=Tmp*Tmp*Tmp;
  Target.Y:=Frac*Frac*Frac;
  Tmp:=Frac-B/200;
  Target.Z:=Tmp*Tmp*Tmp;
 End;
End;

Procedure XYZ2LAB(Source:XYZ;Var L,A,B:Real);Begin
 If Source.Y>0.008856Then L:=(116*Power(Source.Y,0.3333333)-16)
                     Else L:=903.3*Source.Y;
 A:=500*(Power(Source.X,0.3333333)-Power(Source.Y,0.3333333));
 B:=200*(Power(Source.Y,0.3333333)-Power(Source.Z,0.3333333));
End;

Procedure HSV2RGB(H,S,V:Real;Var Target:RGB);
Var
 Zone:Byte;
 F:Real;
 R,G,B:Real;
Begin
 If H=360Then H:=0;
 Zone:=Trunc(H/60);
 F:=H/60-Zone;
 Case(Zone)of
  0:Begin
   r:=v;
   g:=v*(1-s*(1-f));
   b:=v*(1-s);
  End;
  1:Begin
   r:=v*(1-s*f);
   g:=v;
   b:=v*(1-s);
  End;
  2:Begin
   r:=v*(1-s);
   g:=v;
   b:=v*(1-s*(1-f));
  End;
  3:Begin
   r:=v*(1-s);
   g:=v*(1-s*f);
   b:=v;
  End;
  4:Begin
   r:=v*(1-s*(1-f));
   g:=v*(1-s);
   b:=v;
  End;
  5:Begin
   r:=v;
   g:=v*(1-s);
   b:=v*(1-s*f);
  End;
  Else Begin
   R:=0;G:=0;B:=0;
  End;
 End;
 Target.R:=Trunc(R*256);
 Target.G:=Trunc(G*256);
 Target.B:=Trunc(B*256);
End;

Procedure RGB2HSV(Source:RGB;Var H,S,V:Real);
Var
 M:Real;
 R,G,B:Real;
Begin
 R:=Source.R/256;
 G:=Source.G/256;
 B:=Source.B/256;
 If(r>g)Then Begin
  If(r>b)Then v:=r
         Else v:=b;
  If(g<b)Then m:=g
         Else m:=b;
 End
  Else
 Begin
  If(g>b)Then v:=g
         Else v:=b;
  If(r<b)Then m:=r
         Else m:=b
 End;
  {En fait V:=Max(r,g,b) M:=Min(r,g,b)}
 If v<>0Then s:=(v-m)/v
        Else s:=0;      {Calcul saturation}
 If s<>0Then Begin      {Calcul de l'angle}
  If(v=r)Then If(m=g)Then h:=5+(v-b)/(v-m)
              Else h:=1-(v-g)/(v-m)
  Else If(v=g)Then If(m=b)Then h:=1+(v-r)/(v-m)
                          Else h:=3-(v-b)/(v-m)
  Else If(v=b)Then If(m=r)Then h:=3+(v-g)/(v-m)
                          Else h:=5-(v-r)/(v-m);
  h:=h*60;
  If h=360Then h:=0;
 End
  Else
 Begin
   {Noir}
  h:=0;
  s:=0;
 End;
End;

Procedure YCrCb2RGB(Y,Cr,Cb:Real;Var Target:RGB);
Var
 R,G,B:Real;
Begin
 R:=Y+1.402*Cr;
 B:=Y+1.772*Cb;
 G:=(Y-0.299*R-0.114*B)/0.587;
 Target.R:=Trunc(R*256);
 Target.G:=Trunc(G*256);
 Target.B:=Trunc(B*256);
End;

Procedure RGB2YCrCb(Source:RGB;Var Y,Cr,Cb:Real);
Var
 R,G,B:Real;
Begin
 R:=Source.R/256;
 G:=Source.G/256;
 B:=Source.B/256;
 Y:=0.299*R+0.587*G+0.114*B; {*Luminance de 0 … 1*}
 Cr:=(R-Y)/1.402;            {*Chrominance rouge normalis‚e de -0.5 … 0.5*}
 Cb:=(B-Y)/1.772;            {*Chrominance bleue normalis‚e de -0.5 … 0.5*}
End;

Function GetSaturationColor(Color:Word;Factor:Word):Word;
Var
 Q:RGB;
 T:Word;
Begin
 GetSaturationColor:=Color;
 Color2RGB(Color,Q);
 T:=Round(Word(Q.R)*Factor/100.0);
 If T>255Then T:=255;
 Q.R:=T;
 T:=Round(Word(Q.G)*Factor/100.0);
 If T>255Then T:=255;
 Q.G:=T;
 T:=Round(Word(Q.B)*Factor/100.0);
 If T>255Then T:=255;
 GetSaturationColor:=RGB2Color(Q.R,Q.G,T);
End;

Function GetNegativeColor(Color:Word):Word;
Var
 Q:RGB;
Begin
 Color2RGB(Color,Q);
 GetNegativeColor:=RGB2Color(255-Q.R,255-Q.G,255-Q.B);
End;

Function GetGreyColor(Color:Word):Word;
Var
 Q:RGB;
 Moy:Byte;
Begin
 Color2RGB(Color,Q);
 Moy:=(Q.R+Q.G+Q.B) div 3;
 GetGreyColor:=RGB2Color(Moy,Moy,Moy);
End;

Procedure PutFillRoundRectZone(x1,y1,x2,y2,b,Kr:Integer;Zone:ZoneType);
Var
 a,xr,yr,x,j,y,xN,yN:Integer;
 AO,BO,AO2,BO2,AO4,BO4,d:LongInt;
Begin
 y:=y1;y1:=y2;y2:=y;yr:=b;xr:=b;xN:=x1+xr;yN:=y1-yr;
 If Not(y2+b>=yN)Then PutFillBox(x1,y2+b,x2,yN,Kr);
 a:=b;BO:=b*b;AO:=a*a;y:=b;x:=0;
 ASM
   {AO2:=AO shl 1}
  {$IFDEF __386__}
   DB 66h;MOV AX,Word Ptr AO
   DB 66h;SHL AX,1
   DB 66h;MOV Word Ptr AO2,AX
  {$ELSE}
   LES AX,AO
   MOV DX,ES
   SHL AX,1
   RCL DX,1
   MOV Word Ptr AO2,AX
   MOV Word Ptr AO2[2],DX
  {$ENDIF}
   {AO4:=AO shl 2;}
  {$IFDEF __386__}
   DB 66h;SHL AX,1
   DB 66h;MOV Word Ptr AO4,AX
  {$ELSE}
   SHL AX,1
   RCL DX,1
   MOV Word Ptr AO4,AX
   MOV Word Ptr AO4[2],DX
  {$ENDIF}
   {BO2:=BO shl 1;}
  {$IFDEF __386__}
   DB 66h;MOV AX,Word Ptr BO
   DB 66h;SHL AX,1
   DB 66h;MOV Word Ptr BO2,AX
  {$ELSE}
   LES AX,BO
   MOV DX,ES
   SHL AX,1
   RCL DX,1
   MOV Word Ptr BO2,AX
   MOV Word Ptr BO2[2],DX
  {$ENDIF}
   {BO4:=BO shl 2;}
  {$IFDEF __386__}
   DB 66h;SHL AX,1
   DB 66h;MOV Word Ptr BO4,AX
  {$ELSE}
   SHL AX,1
   RCL DX,1
   MOV Word Ptr BO4,AX
   MOV Word Ptr BO4[2],DX
  {$ENDIF}
 END;
 {$IFDEF __386__}
  ASM
   {$IFDEF FLAT386}
    MOV AX,Word Ptr Y
    DEC AX
    MUL Y
    PUSH DX; PUSH AX
    POP EAX
    IMUL AO2
    MOV EBX,EAX
    XOR EAX,EAX
    INC AX
    SUB EAX,AO
    DEC EAX
    IMUL BO2
    ADD EAX,EBX
    ADD EAX,AO
    MOV d,EAX
   {$ELSE}
    MOV AX,Y
    DEC AX
    MUL Y
    DB ciPushDX,ciPushAX
    DW ciPopEAX
    DB 66h;IMUL Word Ptr AO2
    DB 66h;MOV BX,AX
    DB 66h;XOR AX,AX;INC AX
    DB 66h;SUB AX,Word Ptr AO
    DB 66h;DEC AX
    DB 66h;IMUL Word Ptr BO2
    DB 66h;ADD AX,BX
    DB 66h;ADD AX,Word Ptr AO
    DB 66h;MOV Word Ptr d,AX
   {$ENDIF}
  END;
 {$ELSE}
  d:=MulL(AO2,(y-1)*y)+AO+MulL(BO2,1-AO);
 {$ENDIF}
 While(MulL(AO,y)>MulL(BO,x))do Begin
  If(ztSouth)in(Zone)Then PutLnHor(xN-y,yN+x,x2-yr+y,Kr);
  If(ztNorth)in(Zone)Then PutLnHor(xN-y,y2+xr-x,x2-yr+y,Kr);
  If d>=0Then Begin
   Dec(y);
   Dec(d,MulL(AO4,y))
  End;
  {$IFDEF __386__}
   ASM
    {$IFDEF FLAT386}
     XOR EAX,EAX
     XOR EBX,EBX
     MOV AL,3
     MOV BX,Word Ptr X
     SHL EBX,1
     ADD EAX,EBX
     IMUL BO2
     ADD D,EAX
    {$ELSE}
     DB 66h;XOR AX,AX
     DB 66h;XOR BX,BX
     MOV AL,3
     MOV BX,X
     DB 66h;SHL BX,1
     DB 66h;ADD AX,BX
     DB 66h;IMUL Word Ptr BO2
     DB 66h;ADD Word Ptr D,AX
    {$ENDIF}
   END;
  {$ELSE}
   Inc(d,MulL(BO2,3+(x shl 1)));
  {$ENDIF}
  Inc(x);
 End;
 d:=MulL(BO2,(x+1)*x)+MulL(AO2,y*(y-2)+1)+MulL(1-AO2,BO);
 While y<>0do Begin
  If(ztSouth)in(Zone)Then PutLnHor(xN-y,x+yN,x2-yr+y,Kr);
  If(ztNorth)in(Zone)Then PutLnHor(xN-y,y2+xr-x,x2-yr+y,Kr);
  If d<=0Then Begin;Inc(x);Inc(d,MulL(BO4,x))End;
  Dec(y);
  {$IFDEF __386__}
   ASM
    {$IFDEF FLAT386}
     XOR EAX,EAX
     XOR EBX,EBX
     MOV AL,3
     MOV BX,Word Ptr Y
     SHL EBX,1
     SUB EAX,EBX
     IMUL AO2
     ADD D,EAX
    {$ELSE}
     DB 66h;XOR AX,AX
     DB 66h;XOR BX,BX
     MOV AL,3
     MOV BX,Y
     DB 66h;SHL BX,1
     DB 66h;SUB AX,BX
     DB 66h;IMUL Word Ptr AO2
     DB 66h;ADD Word Ptr D,AX
    {$ENDIF}
   END;
  {$ELSE}
   Inc(d,MulL(AO2,3-(y shl 1)));
  {$ENDIF}
 End;
End;


{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Proc‚dure Unluxe                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de mettre au service le systŠme de luxe de
 l'ensemble Malte Genesis. Utilisez par exemple lorsque vous voulez
 retourner au DOS sans restituer le mode vid‚o.
}

Procedure UnLuxe;Begin
 {$IFDEF Adele}
  Adele.SetLuxe(False);
 {$ELSE}
  SetDefaultIcon;
  If Not(IsGraf)Then SetBlink(Ya);
  SetChrWidth(9);
  LoadMtx('STD');
 {$ENDIF}
 SimpleCur;
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
END.