{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                Malte Genesis/Module du coeur de AdŠle               Û
 ³        dition AdŠle pour Mode R‚el et Windows/V - Version 1.33     Û
 ³                              1998/01/01                             Û
 ³                                                                     Û
 ³          Tous droits r‚serv‚ par les Chevaliers de Malte (C)        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Nom du programmeur
 ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

  Sylvain Maltais


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette unit‚ agit en tant que coeur d'AdŠle.  Il contient  la boŒte des
 techniques provoquant ses talents.


 Remarques
 ÍÍÍÍÍÍÍÍÍ

  ş Chantal n'est pas une fille facile,  elle a besoin  d'ˆtre  comprise
    pour bien agir.

  ş AVERTISSEMENT! Cette unit‚ doit … tout prix avoir comme offset 0. Il
    faut donc qu'elle soit la 1iŠre unit‚ ins‚rer dans un programme.  Si
    vous pr‚f‚rez Ofs(Init)=0 sinon il plante...


 Compilateur
 ÍÍÍÍÍÍÍÍÍÍÍ

  ş Turbo Pascal 7 ou post‚rieur
  ş Borland Pascal 7 ou post‚rieur
  ş Delphi 1.2 ou post‚rieur
}

Unit Adele;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                               INTERFACE
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

{$I DEF.INC}

Uses {$IFDEF Windows}
 Messages,
{$ENDIF}
Dostex,Systex;

Const
 {$IFDEF Real}
  Jump:Jumper=(
   FlagsMethod:stupJumperDef   { Drapeaux de configuration lors du lancement }
  );
 {$ENDIF}
 CheckSVGA:Boolean=False; {Cette constante permet  de fixer le  drapeau indiquant
                           si la d‚tection de carte vid‚o Super VGA est autoris‚.}
 VesaBiosBank:Boolean=False; {Cette constante permet interdit l'accŠs par la
                              routine BIOS plut“t que par la routine d'appel pour
                              les banques de m‚moires vid‚o}
 ModeSupport:^TWord=NIL;
 NumModeSupport:Word=0;{ Nombre de mode vid‚o support‚e }
{$IFDEF Windows}
 WindowOrg:TPoint=(X:cw_UseDefault;Y:cw_UseDefault); { Origine de la fenˆtre CRT }
 WindowSize:TPoint=(X:cw_UseDefault;Y:cw_UseDefault);{ Taille de la fenˆtre CRT }
 ScreenSize:TPoint=(X:80;Y:25);                      { Dimensions du tampon d'acc‚l‚ration }
 Cursor:TPoint=(X:0;Y:0);                            { Position du curseur }
 Origin:TPoint=(X:0;Y:0);                            { R‚gion d'origine du client }
 InactiveTitle:PChar='(Inactive %s)';                { Titre de la fenˆtre inactive}
 AutoTracking:Boolean=True;                          { Track curseur dans Write? }
 CheckEOF:Boolean=False;                             { D‚finit un Ctrl+Z comme EOF? }
 CheckBreak:Boolean=True;                            { D‚finit un Ctrl+C comme Break? }
 Focused:Boolean=False;                              { Fenˆtre CRT focus‚? }

Type
 LongRec=Record Lo,Hi:Integer;End;{ Enregistrement d'un double mots }
  { Tableau de MinMaxInfo }
 PMinMaxInfo=^TMinMaxInfo;
 TMinMaxInfo=Array[0..4]of TPoint;
  { Enregistrement de d‚finition des touches de la fenˆtre }
 TScrollKey=Record
  Key:Byte;
  Ctrl:Boolean;
  SBar:Byte;
  Action:Byte;
 End;
{$ENDIF}

Var
{$IFDEF Windows}
 WindowTitle:Array[0..79]of Char;                    { Nom de la fenˆtre CRT }
 DC:HDC;                                             { Device globale de contexte }
{$ENDIF}
  { Information sur le CPU et son bus }
 CPU:Byte;          { Code correspondant au CPU }
 Up32Bits:Boolean;  { Supporte le code 32-bits? }
 CPUID:Boolean;     { Supporte l'instruction CPUID? }
 CPUVendor:Byte;    { Fabricant du CPU (cv????)}
 Bus:Byte;          { Type de bus }
  {Information sur le modŠle d'Ordinateur}
 ComputerName:Word;
 PS2:Boolean;
  {Information sur les Interruptions}
 IntExistFlags:Word;
  { Information sur le systŠme d'exploitation }
 GetDosVer:Word;
 GetDosBlock:DosBlockPtr;
 HandleExist:Boolean;
 OS2:Boolean;
 OS2HiVer,OS2LoVer,Win,WinLoVer,WinHiVer:Byte;
  { Information de pays }
 CountryCode,CodePage:Word;
 Date:Word;
 Curr:Array[0..4]of Char;
 ThSep,DeSep,DtSep,TmSep:Array[0..1]of Char;
 CurrStyle,Digits:Byte;
 Time:TimeType;
 CaseUp:Pointer;
 DaSep:Array[0..1]of Char;
  { Information sur le(s) lecteur(s) de disquette }
 FloppyDskExist:Boolean;    { Lecteur de disquette exitante? }
 NmFloppyDsk:Byte;          { Nombre de lecteur de disquette }
  { Information sur le(s) disque(s) dur }
 HardDskExist:Boolean;      { Disque dur existant? }
 NmHardDsk:Byte;            { Nombre de disque dur }
 HardDskCtrl:Word;          { Type de contr“leur de disque dur }
  {Information r‚seau/spooler d'imprimante}
 IsNovell:Boolean;
 Spooler:Byte;
  { Information sur la manette de jeux }
 JoyExist,                  { Contr“leur de manette de jeux existant? }
 BiosJoy:Boolean;           { BIOS supporte la manette de jeux?       }
 JoyPort,                   { Adresse du port de manette de jeux      }
 JoyPotentioMeter:Word;     { PotentiomŠtre … utiliser avec la manette}
  { Information sur le clavier }
 KbdModel,KbdCtrl:Byte;
 KbdReadPort:Word;
 BiosKbdEnh:Boolean;
  { Information sur le port parallŠle }
 LPTExist:Boolean;
 NmLPT,Get1LPT:Byte;
  { Information sur le port s‚rie }
 SerialExist:Boolean;
 NmSerial:Byte;
  { Information sur la m‚moire conventionnel }
 MemTotalSize:Word;
 EmmExist:Boolean;
 EmmSeg,EmmTotalSize:Word;  { Information sur EMS }
  { Information sur l''eXtended Memory Manager (XMS) }
 XmsExist:Boolean;
 XmmCtrl:Pointer;
 XmsTotalSize:Word;
  { Information sur la m‚moire ‚tendu g‚r‚ par le Bios Int 15h }
 ExtBiosExist:Boolean;
 ExtBiosSizeK:Word;
  { Information sur le CMOS }
 CtrlCmos:Byte;
 CmosPort:Word;
  { Information sur la souris }
 Mouse:Byte;
 MouseVer,MsButton:Word;
  { Index de proc‚dure ou fonction … r‚f‚rence resource RLL }
 {$IFDEF Real}
  ind:indRec;
 {$ENDIF}
  { Information de port s‚rie pour la souris }
 DefMousePort:Word; { Adresse de port s‚rie de la souris par d‚faut }

Const
 DefMouseCom:Byte=1;     { Port s‚rie par d‚faut de la souris}
 TypeMouse:Byte=2;       { Type de souris? }
 ComLCR:Byte=2;          { Port souris LCR }
 PicStateMouse:Byte=$10; { tat du PIC? }
 IRQIntNumMouse:Byte=$C; { Interruption IRQ par d‚faut de la souris s‚rie }
 DefaultLanguage:Byte=0; { Langue Courante: 0 = Fran‡ais, 1 = Anglais }

Procedure AutoDetect;Far;
Procedure Init;Far;
Function  viSetVideoModePrim(Mode:Word;Var P:PIV;Var Q:MIV):Byte;Far;
Function  viSetVideoSizePrim(Grf,Length,Height:Word;Var P:PIV;Var Q:MIV):Byte;Far;
Procedure Bar(X1,Y1,X2,Y2:Integer;Kr:Word);Far;
Procedure BarChrHor(X1,Y,X2:Byte;Chr:Char);Far;
Procedure BarChrVer(X,Y1,Y2:Byte;Chr:Char);Far;
Procedure BarSpaceHor(X1,Y,X2,Attr:Byte);Far;
Procedure BarSpaceHori(X1,Y,X2,Attr:Byte);Far;
Procedure BarSpaceHorizontal(X1,Y,X2,Attr:Byte);Far;
Procedure BarSpcHor(X1,Y,X2,Attr:Byte);Far;
Procedure BarSpcVer(X,Y1,Y2,Attr:Byte);Far;
Procedure BarTxtHor(X1,Y,X2:Byte;Chr:Char;Attr:Byte);Far;
Function  BiosBlinkFound:Boolean;Far;
Function  BitsPerPixel:Byte;Far;
Function  BytesPerLine:Word;Far;
Function  BytesPerLn:Word;Far;
Procedure Circle(X,Y,Rayon:Integer;Color:Word);Far;
Procedure ClearLineHor(X,Y,L,Kr:Word);Far;
Procedure ClearLineHori(X,Y,L,Kr:Word);Far;
Procedure ClearScr(Attr:Byte);Far;
Procedure ClearScreen(Attr:Byte);Far;
Procedure ClearWindow(X1,Y1,X2,Y2,Attr:Byte);Far;
Procedure CloseCur;Far;
Procedure CloseCursor;Far;
Procedure ClrLnHor(X,Y,L,Kr:Word);Far;
Procedure ClrLnHorImg(X,Y,L:Word;BitsPerPixel:Byte;Const Buffer);Far;
Procedure ClrWn(X1,Y1,X2,Y2,Attr:Byte);Far;
Procedure ClrScr(Attr:Byte);Far;
Procedure Cls(Attr:Byte);Far;
Procedure ClsCur;Far;
Function  ColorFound:Boolean;Far;
Procedure CopT8Bin(X,Y:Word;Value:Byte;Fore:Word);Far;
Procedure Copy8Bin(X,Y:Word;Value:Byte;Back,Fore:Word);Far;
Procedure FillBnk(aY:LongInt;L,Kr:Word);Far;
Procedure FillBox(X1,Y1,X2,Y2:Byte;Chr:Char;Attr:Byte);Far;
Procedure FillScreen(Attr:Byte);Far;
{$IFNDEF __Windows__}
 Function Focused:Boolean;Far;
{$ENDIF}
Function  FontFound:Boolean;Far;
Function  GetAttr(X,Y:Byte):Byte;Far;
Function  GetBitsPerPixel:Byte;Far;
Function  GetBytesPerLine:Word;Far;
Function  GetBytesPerLn:Word;Far;
Function  GetChar(X,Y:Byte):Char;Far;
Function  GetCharacter(X,Y:Byte):Char;Far;
Function  GetChr(X,Y:Byte):Char;Far;
Function  GetCube(X,Y:Byte):Word;Far;
Function  GetCur:Word;Far;
Function  GetHeightChar:Byte;Far;
Function  GetHeightCharacter:Byte;Far;
Function  GetHeightChr:Byte;Far;
Procedure GetLnHorImg(X1,Y,X2:Word;Var Buffer);Far;
Function  GetMaxColors:Word;Far;
Function  GetMaxColor:Word;Far;
Function  GetMaxKr:Word;Far;
Function  GetMaxPal:Word;Far;
Function  GetMaxX:Word;Far;
Function  GetMaxXPixels:Word;Far;
Function  GetMaxXTxts:Byte;Far;
Function  GetMaxY:Word;Far;
Function  GetMaxYPixels:Word;Far;
Function  GetMaxYTxts:Byte;Far;
Procedure GetMIV(Var X:MIV);Far;
Procedure GetModeInfoVideo(Var X:PIV);Far;
Function  GetNmColors:LongInt;Far;
Function  GetNmKr:LongInt;Far;
Function  GetNmVideoPages:Byte;Far;
Function  GetNmXPixels:Word;Far;
Function  GetNmXTxts:Byte;Far;
Function  GetNmYPixels:Word;Far;
Function  GetNmYTxts:Byte;Far;
Function  GetNumColors:LongInt;Far;
Function  GetNumXPixels:Word;Far;
Function  GetNumYPixels:Word;Far;
Procedure GetPhysInfoVideo(Var X:PIV);Far;
Procedure GetPhysicalInfoVideo(Var X:PIV);Far;
Procedure GetPIV(Var X:PIV);Far;
Procedure GetPIVSec(Var X:PIV);Far;
Function  GetPixel(X,Y:Word):Word;Far;
Function  GetRawY(Y:Byte):Word;Far;
Function  GetRealRawY(Y:Word):LongInt;Far;
Function  GetRealRawYWord(Y:Word):Word;Far;
Function  GetSelPg:Byte;Far;
Function  GetSizeSmlImg(X1,Y1,X2,Y2:Word):Word;Far;
Procedure GetSmlImg(X1,Y1,X2,Y2:Word;Var Buffer);Far;
Function  GetVideoBitsDAC:Byte;Far;
Function  GetVideoBitsIO:Byte;Far;
Function  GetVideoBitsROM:Byte;Far;
Function  GetVideoBnkPg:Byte;Far;
Function  GetVideoCard:Byte;Far;
Function  GetVideoCardCat:Byte;Far;
Function  GetVideoPg:Byte;Far;
Function  GetVideoMem:LongInt;Far;
Function  GetVideoMemory:LongInt;Far;
Function  GetVideoMode:Word;Far;
Function  GetVideoMonitor:Byte;Far;
Function  GetVideoScrSize:LongInt;Far;
Function  GetVideoSeg:Word;Far;
Function  GetVideoSegBuf:Word;Far;
Function  GetVideoSegROM:Word;Far;
Function  GetVideoShowPg:Byte;Far;
Function  GetVideoSizeBnkPg:Word;Far;
Function  GetVideoTxtAddrPg:Word;Far;
Function  GetVideoTxtMtxPtr:Pointer;Far;
Function  GetVidMem:LongInt;Far;
Function  GetXCurPos:Byte;Far;
Function  GetYCurPos:Byte;Far;
Procedure GotoXY(X,Y:Byte);Far;
Function  HeightChr:Byte;Far;
Procedure InitSound;Far;
Function  IsBlink:Boolean;Far;
Function  IsColor:Boolean;Far;
Function  IsDblMtx:Boolean;Far;
Function  IsEGA:Boolean;Far;
Function  IsGraf:Boolean;Far;
Function  IsGraphics:Boolean;Far;
Function  IsGraphix:Boolean;Far;
Function  IsGrf:Boolean;Far;
Function  IsKr:Boolean;Far;
Function  IsMono:Boolean;Far;
Function  IsMonochrome:Boolean;Far;
Function  IsVESA:Boolean;Far;
Function  IsVGA:Boolean;Far;
Function  IsVideoBlink:Boolean;Far;
Function  IsVideoDirectAccess:Boolean;Far;
Function  IsVideoModeBios:Boolean;Far;
Function  IsVideoModeIBMLogic:Boolean;Far;
Function  IsVideoSnow:Boolean;Far;
Function  KrFound:Boolean;Far;
Procedure Locate(X,Y:Byte);Far;
Function  MaxXTxts:Byte;Far;
Function  MaxYTxts:Byte;Far;
Procedure MoveText(X1,Y1,X2,Y2,X3,Y3:Byte);Far;
Function  NmXPixels:Word;Far;
Function  NmXTxts:Byte;Far;
Function  NmYPixels:Word;Far;
Function  NmYTxts:Byte;Far;
Procedure PageCopy(S,T:Byte);Far;
Procedure PCopy(S,T:Byte);Far;
Procedure PCopy2Img(Page:Byte;X1,Y1,X2,Y2:Word);Far;
Procedure Plot(X,Y,Kr:Word);Far;
Procedure Point(X,Y,Kr:Word);Far;
Function  PrimCardCat:Byte;Far;
Procedure PSet(X,Y,Kr:Word);Far;
Procedure PutCharGAttr(X,Y:Byte;Chr:Char;Attr,GAttr:Byte);Far;
Procedure PutFillBox(X1,Y1,X2,Y2:Integer;Kr:Word);Far;
Procedure PutFillCircle(X,Y,Rayon:Integer;Kr:Word);Far;
Procedure PutFillRoundRect(x1,y1,x2,y2,b,Kr:Integer);Far;
Procedure PutLine(X1,Y1,X2,Y2,Kr:Word);Far;
Procedure PutLineHori(X1,Y,X2,Kr:Word);Far;
Procedure PutLn(X1,Y1,X2,Y2,Kr:Word);Far;
Procedure PutLnHor(X1,Y,X2,Kr:Word);Far;
Procedure PutRect(X1,Y1,X2,Y2,Kr:Integer);Far;
Procedure PutRoundRect(X1,Y1,X2,Y2,LineWidth,B,Kr:Word);Far;
Procedure PutSmlImg(X1,Y1,X2,Y2:Word;Var Buffer);Far;
Procedure PutSprite(X1,Y1,X2,Y2:Word;Var Buffer);Far;
Procedure PutTextXY(X,Y:Byte;Const Str:String;Attr:Byte);Far;
Procedure PutTxtXY(X,Y:Byte;Const Str:String;Attr:Byte);Far;
Procedure PutTxtXYUnCol(X,Y:Byte;Const Str:String);Far;
Procedure PutTxtXYUnKr(X,Y:Byte;Const Str:String);Far;
Procedure ReadBnk(aY:LongInt;L:Word;Var x0);Far;
Procedure SelBnkPg(Pg:Byte);Far;
Procedure SetAttr(X,Y,Attr:Byte);Far;
Procedure SetBackgroundColor(Kr:Byte);Far;
Procedure SetBlink(X:Boolean);Far;
Procedure SetBnkPg(Pg:Byte);Far;
Procedure SetBorderColor(Kr:Byte);Far;
Procedure SetBytesPerLn(X:Word);Far;
Procedure SetChar(X,Y:Byte;Chr:Char);Far;
Procedure SetCharacter(X,Y:Byte;Chr:Char);Far;
Procedure SetChr(X,Y:Byte;Chr:Char);Far;
Procedure SetChrWidth(L:Byte);Far;
Procedure SetCube(X,Y:Byte;Chr:Char;Attr:Byte);Far;
Procedure SetCur(A,B:Byte);Far;
Procedure SetCurPos(X,Y:Byte);Far;
Procedure SetCursor(A,B:Byte);Far;
Procedure SetCursorPos(X,Y:Byte);Far;
Procedure SetCursorPosition(X,Y:Byte);Far;
Procedure SetDblMtx(X:Boolean);Far;
Procedure SetExtChr(X,Y:Byte;Chr:Word);Far;
Procedure SetExtCube(X,Y:Byte;Chr:Word;Attr:Byte);Far;
Procedure SetGCube(X,Y:Word;C:Chr;Attr:Byte);
Procedure SetGCubeT(X,Y:Word;C:Chr;Attr:Byte);
Procedure SetHeightChr(H:Byte);
Procedure SetHorizontalScale(X:Word);Far;
Procedure SetMatrix(Palette,Height:Byte;Number,Start:Word;Var X:TByte);Far;
Procedure SetModeMatrix;Far;
Procedure SetModeMtx;Far;
Procedure SetModeScr;Far;
Procedure SetModeScreen;Far;
Procedure SetModeValue(Mode:Word);Far;
Procedure SetNumYTexts(Y:Byte);Far;
Procedure SetPage(Pg:Byte);Far;
Procedure SetPalBlk(Start,Nm:Word);Far;
Procedure SetPaletteRGB(Start:Word;R,G,B:Byte);Far;
Procedure SetPalRGB(Var P;Start,Num:Word);Far;
Procedure SetPg(Pg:Byte);Far;
Procedure SetPhysInfoVideo(Var X:PIV);Far;
Procedure SetPhysicalInfoVideo(Var X:PIV);Far;
Procedure SetPIV(Var X:PIV);Far;
Procedure SetPixel(X,Y,Kr:Word);Far;
Procedure SetTxtMtx(Mtx:Pointer);
Procedure SetUnderline(X:Boolean);Far;
Procedure SetVerticalScale(Y:Word);Far;
Procedure SetVideoSeg(Seg:Word);Far;
Procedure SetVisualPage(Pg:Byte);Far;
Procedure SetVisualPg(Pg:Byte);Far;
Procedure SetWriteMode(Mode:Byte);Far;
Procedure SplitScreen(Y:Word);Far;
Function  Stat(X,Y:Byte):Word;Far;
Function  VGA320x400Found:Boolean;Far;
Function  VideoFontFound:Boolean;Far;
Function  VideoHerculeFound:Boolean;Far;
Function  VideoMousePortFound:Boolean;Far;
Function  VideoPaletteFound:Boolean;Far;
Procedure WriteBnk(aY:LongInt;L:Word;Const x0);Far;
Procedure WriteXY(X,Y:Byte;Const Str:String;Attr:Byte);Far;
Procedure WriteXYUnKr(X,Y:Byte;Const Str:String);Far;
Function  _GetActivePage:Byte;Far;
Function  _GetPixel(X,Y:Word):Word;Far;
Function  _ImageSize(X1,Y1,X2,Y2:Word):Word;Far;
Procedure _SetActivePage(Pg:Byte);Far;
Procedure Done;Far;
Function viInitVideo:Byte;Far;{Ceci n'est pas … utiliser pour le programmeur...}

 {Routine de Luxe/Icon}
Procedure SetLuxe(X:Boolean);
Function  IsLuxe:Boolean;
Procedure CloseIcon(X,Y,Attr:Byte);
Procedure DownIcon(X,Y,Attr:Byte);
Procedure LeftIcon(X,Y,Attr:Byte);
Procedure RightIcon(X,Y,Attr:Byte);
Procedure SelIcon(X,Y,Attr:Byte);
Procedure UnSelIcon(X,Y,Attr:Byte);
Procedure UpIcon(X,Y,Attr:Byte);
Procedure ZoomIcon(X,Y,Attr:Byte);
Procedure PutCloseIcon(X,Y,Attr:Byte);
Procedure PutDownIcon(X,Y,Attr:Byte);
Procedure DossierDocumentIcon(X,Y,Attr:Byte);
Procedure DossierProgramIcon(X,Y,Attr:Byte);
{$IFDEF Real}
 Procedure mtxStartUp;{Ceci ne n'est pas une proc‚dure mais une table}
 Procedure StartUpChantal{(Var Jump:Jumper;Var StartUp:StartUpRec)};Far;
 Function DirectAltPress:Boolean;
 Function DirectCtrlPress:Boolean;
 Procedure DirectFillChar(Var X;Len:Word;Value:Byte);
 Procedure DirectGetIntVec(IntNo:Byte;Var Vector:Pointer);
 Function DirectGetRawTimer:LongInt;
 Function DirectGetRawTimerB:Byte;
 Function DirectJoyPos(Axe:Byte):Word;
 Function DirectKeyPress:Boolean;
 Function DirectLShiftPress:Boolean;
 Procedure DirectMove(Const Source;Var Dest;Count:Word);
 Procedure DirectMove386(Const Source;Var Dest;Count:Word);
 Procedure DirectPushKey(K:Word);
 Function DirectRawReadKey:Word;
 Function DirectRShiftPress:Boolean;
 Procedure DirectSetIntVec(IntNo:Byte;Vector:Pointer);
 Function DirectShiftPress:Boolean;
{$ENDIF}
{$IFDEF __Windows__}
 Procedure InitWinCrt;
 Procedure DoneWinCrt;
 Procedure WriteBuf(Buffer:PChar;Count:Word);
 Procedure WriteChar(Ch:Char);
 Function  KeyPressed:Boolean;
 Function  ReadKey:Char;
 Function  ReadBuf(Buffer:PChar;Count:Word):Word;
 Function  WhereX:Integer;
 Function  WhereY:Integer;
 Procedure ClrEol;
 Procedure ScrollTo(X,Y:Integer);
 Procedure TrackCursor;
 Procedure AssignCrt(Var F:Text);
 { Proc‚dure de fenˆtre CRT }
 Function CrtWinProc(Window:Word;Message,WParam:Word;LParam:Longint):Longint;Export;
{$ENDIF}

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                              IMPLEMENTATION
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

{$IFDEF __Windows__}

{ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ}
{ÛÛ                Destination/Plate-Forme: WINDOWS                   ÛÛ}
{ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ}

Uses Video;
Const
 {$IFNDEF Win32}
  CrtClass:TWndClass=(
   Style:cs_HRedraw+cs_VRedraw;
   lpfnWndProc:@CrtWinProc;
   cbClsExtra:0;
   cbWndExtra:0;
   hInstance:0;
   hIcon:0;
   hCursor:0;
   hbrBackground:0;
   lpszMenuName:NIL;
   lpszClassName:'TPWinCrt');
 CrtWindow:HWnd=0;                  { Handle du la fenˆtre CRT }
 {$ENDIF}
 FirstLine:Integer=0;               { PremiŠre ligne dans le tampon circulaire }
 KeyCount:Integer=0;                { Compteur de touche dans KeyBuffer }
 Created:Boolean=False;       	    { Fenˆtre CRT cr‚er? }
 Reading:Boolean=False;             { Lecture dans la fenêtre CRT? }
 Painting:Boolean=False;            { Handleur wm_Paint? }

{$IFNDEF Win32}
 Var
  SaveExit:Pointer;                  { Pointeur de sauvegarde de la sortie }
  ScrBuf:PChar;                      { Pointeur sur le tampon d'acc‚l‚ration }
  ClientSize:TPoint;                 { Dimensions de la r‚gion Client}
  Range:TPoint;                      { Rangs de la barre de fenˆtrage }
  CharSize:TPoint;                   { Taille de la cellule de caractŠre }
  CharAscent:Integer;                { CaractŠre ascentu‚ }
  PS:TPaintStruct;                   { Structure globale de peinture }
  SaveFont:HFont;                    { Sauvegarde de la device de police de contexte }
  KeyBuffer:Array[0..63]of Char;     { Tampon du clavier }

 { Table des touches de fenˆtre }
 Const
  ScrollKeyCount=12;
  ScrollKeys:Array[1..ScrollKeyCount]of TScrollKey=(
    (Key:vk_Left; Ctrl:False;SBar:sb_Horz;Action:sb_LineUp),
    (Key:vk_Right;Ctrl:False;SBar:sb_Horz;Action:sb_LineDown),
    (Key:vk_Left; Ctrl:True; SBar:sb_Horz;Action:sb_PageUp),
    (Key:vk_Right;Ctrl:True; SBar:sb_Horz;Action:sb_PageDown),
    (Key:vk_Home; Ctrl:False;SBar:sb_Horz;Action:sb_Top),
    (Key:vk_End;  Ctrl:False;SBar:sb_Horz;Action:sb_Bottom),
    (Key:vk_Up;   Ctrl:False;SBar:sb_Vert;Action:sb_LineUp),
    (Key:vk_Down; Ctrl:False;SBar:sb_Vert;Action:sb_LineDown),
    (Key:vk_Prior;Ctrl:False;SBar:sb_Vert;Action:sb_PageUp),
    (Key:vk_Next; Ctrl:False;SBar:sb_Vert;Action:sb_PageDown),
    (Key:vk_Home; Ctrl:True; SBar:sb_Vert;Action:sb_Top),
    (Key:vk_End;  Ctrl:True; SBar:sb_Vert;Action:sb_Bottom));
{$ENDIF}    

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                             Fonction Min                             Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction retourne lequel des deux nombres envoy‚ en paramŠtre est
 le plus petit.
}

Function Min(X,Y:Integer):Integer;Begin
 If(X<Y)Then Min:=X else Min:=Y
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                              Fonction Max                            Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction retourne lequel des deux nombres envoy‚ en paramŠtre est
 le plus grand.
}

Function Max(X,Y:Integer):Integer;Begin
 If(X>Y)Then Max:=X else Max:=Y
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Proc‚dure InitDeviceContext                    Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Destination/Plate-Forme: Windows 3.xx


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet l'allocation d'une device de contexte.
}

Procedure InitDeviceContext;Begin
 {$IFNDEF Win32}
  If(Painting)Then DC:=BeginPaint(CrtWindow,PS)Else DC:=GetDC(CrtWindow);
  SaveFont:=SelectObject(DC,GetStockObject(System_Fixed_Font))
 {$ENDIF} 
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Proc‚dure DoneDeviceContext                    Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Destination/Plate-Forme: Windows 3.xx


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet la restitution d'une device contexte.
}

Procedure DoneDeviceContext;Begin
 {$IFNDEF Win32}
  SelectObject(DC,SaveFont);
  If(Painting)Then EndPaint(CrtWindow,PS)Else ReleaseDC(CrtWindow,DC)
 {$ENDIF} 
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Proc‚dure DoneDeviceContext                    Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Destination/Plate-Forme: Windows 3.xx


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet l'affiche du curseur.
}

Procedure ShowCursor;Begin
 {$IFNDEF Win32}
  CreateCaret(CrtWindow,0,CharSize.X,2);
  SetCaretPos((Cursor.X-Origin.X)*CharSize.X,(Cursor.Y-Origin.Y)*CharSize.Y+CharAscent);
  ShowCaret(CrtWindow)
 {$ENDIF} 
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Proc‚dure DoneDeviceContext                    Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Destination/Plate-Forme: Windows 3.xx


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet la mise … jour de la barre de fenˆtrage.
}

Procedure SetScrollBars;Begin
 {$IFNDEF Win32}
  SetScrollRange(CrtWindow,sb_Horz,0,Max(1,Range.X),False);
  SetScrollPos(CrtWindow,sb_Horz,Origin.X,True);
  SetScrollRange(CrtWindow,sb_Vert,0,Max(1,Range.Y),False);
  SetScrollPos(CrtWindow,sb_Vert,Origin.Y,True)
 {$ENDIF} 
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Proc‚dure Terminate                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Destination/Plate-Forme: Windows 3.xx


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet la terminaison de la fenˆtre CRT.
}

Procedure Terminate;Begin
 {$IFNDEF Win32}
  If(Focused)and(Reading)Then CloseCur;
  Halt(255)
 {$ENDIF} 
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Proc‚dure ScrollTo                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Destination/Plate-Forme: Windows 3.xx


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet le d‚filement de fenˆtre … l'origine.
}

Procedure ScrollTo(X,Y:Integer);Begin
 {$IFNDEF Win32}
  If(Created)Then Begin
   X:=Max(0,Min(X,Range.X));Y:=Max(0,Min(Y,Range.Y));
   If(X<>Origin.X)or(Y<>Origin.Y)Then Begin
    If(X<>Origin.X)Then SetScrollPos(CrtWindow,sb_Horz,X,True);
    If(Y<>Origin.Y)Then SetScrollPos(CrtWindow,sb_Vert,Y,True);
    ScrollWindow(CrtWindow,(Origin.X-X)*CharSize.X,(Origin.Y-Y)*CharSize.Y,Nil,Nil);
    Origin.X:=X;Origin.Y:=Y;
    UpdateWindow(CrtWindow)
   End
  End
 {$ENDIF} 
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Proc‚dure TrackCursor                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Destination/Plate-Forme: Windows 3.xx


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'effectuer le d‚filement afin de faire rendre le
 curseur visible.
}

Procedure TrackCursor;Begin
 {$IFNDEF Win32}
  ScrollTo(Max(Cursor.X-ClientSize.X+1,Min(Origin.X,Cursor.X)),
           Max(Cursor.Y-ClientSize.Y+1,Min(Origin.Y,Cursor.Y)))
 {$ENDIF}           
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Fonction ScrPtr                            Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Destination/Plate-Forme: Windows 3.xx


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de retourner un pointeur … la position du tampon
 d'‚cran.
}

Function ScrPtr(X,Y:Integer):PChar;Begin
 {$IFNDEF Win32}
  Inc(Y,FirstLine);
  If(Y>=ScreenSize.Y)Then Dec(Y,ScreenSize.Y);
  ScrPtr:=@ScrBuf[Y*ScreenSize.X+X]
 {$ENDIF} 
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Proc‚dure ShowText                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Destination/Plate-Forme: Windows 3.xx


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet la mise … jour du texte o— le curseur se trouve.
}

Procedure ShowText(L,R:Integer);Begin
 {$IFNDEF Win32}
  If(L<R)Then Begin
   InitDeviceContext;
   TextOut(DC,(L-Origin.X)*CharSize.X,(Cursor.Y-Origin.Y)*CharSize.Y,ScrPtr(L,Cursor.Y),R-L);
   DoneDeviceContext;
  End;
 {$ENDIF} 
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Proc‚dure WriteBuf                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Destination/Plate-Forme: Windows 3.xx


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'‚crit dans le tampon de texte de la fenˆtre CRT.
}

Procedure WriteBuf(Buffer:PChar;Count:Word);Var L,R:Integer;

{$IFNDEF Win32}
 Procedure NewLine;Begin
  ShowText(L,R);
  L:=0;R:=0;Cursor.X:=0;Inc(Cursor.Y);
  If(Cursor.Y=ScreenSize.Y)Then Begin
   Dec(Cursor.Y);Inc(FirstLine);
   If(FirstLine=ScreenSize.Y)Then FirstLine:=0;
   FillChar(ScrPtr(0,Cursor.Y)^,ScreenSize.X,' ');
   ScrollWindow(CrtWindow,0,-CharSize.Y,Nil,Nil);
   UpdateWindow(CrtWindow);
  End;
 End;
{$ENDIF}

Begin
 {$IFNDEF Win32}
  InitWinCrt;
  L:=Cursor.X;R:=Cursor.X;
  While Count>0do Begin
   Case Buffer^of
    #32..#255:Begin
     ScrPtr(Cursor.X, Cursor.Y)^:=Buffer^;
     Inc(Cursor.X);
     If(Cursor.X>R)Then R:=Cursor.X;
     If(Cursor.X=ScreenSize.X)Then NewLine;
    End;
    #13:NewLine;
    #8:If Cursor.X>0Then	Begin
     Dec(Cursor.X);
     ScrPtr(Cursor.X,Cursor.Y)^:=' ';
     If(Cursor.X<L)Then L:=Cursor.X;
    End;
    #7:MessageBeep(0);
   End;
   Inc(Buffer);Dec(Count)
  End;
  ShowText(L,R);
  If(AutoTracking)Then TrackCursor
 {$ENDIF}
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Proc‚dure WriteChar                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Destination/Plate-Forme: Windows 3.xx


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'‚crire un caractŠre dans la fenˆtre CRT.
}

Procedure WriteChar(Ch:Char);Begin
 WriteBuf(@Ch,1)
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Fonction KeyPressed                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Destination/Plate-Forme: Windows 3.xx


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

 Cette fonction retourne l'‚tat du clavier.
}

Function KeyPressed:Boolean;{$IFNDEF Win32}Var M:TMsg;{$ENDIF}Begin
 {$IFNDEF Win32}
  InitWinCrt;
  While PeekMessage(M,0,0,0,pm_Remove)do Begin
   If(M.Message=wm_Quit)Then Terminate;
   TranslateMessage(M);
   DispatchMessage(M);
  End;
  KeyPressed:=KeyCount>0
 {$ENDIF}
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Fonction ReadKey                            Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Destination/Plate-Forme: Windows 3.xx


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet la lecture d'un touche dans la fenˆtre CRT.
}

Function ReadKey:Char;Begin
 {$IFNDEF Win32}
  TrackCursor;
  If Not(KeyPressed)Then Begin
   Reading:=True;
   If(Focused)Then ShowCursor;
   Repeat Until KeyPressed;
   If(Focused)Then CloseCur;
   Reading:=False;
  End;
  ReadKey:=KeyBuffer[0];Dec(KeyCount);
  Move(KeyBuffer[1],KeyBuffer[0],KeyCount);
 {$ENDIF} 
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Fonction ReadBuf                            Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Destination/Plate-Forme: Windows 3.xx


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet la lecture d'un tampon de la fenˆtre CRT.
}

Function ReadBuf(Buffer:PChar;Count:Word):Word;Var Ch:Char;I:Word;Begin
 {$IFNDEF Win32}
  I:=0;
  Repeat
   Ch:=ReadKey;
   Case(Ch)of
    #8:If I>0Then Begin
     Dec(I);
     WriteChar(#8);
    End;
    #32..#255:If I<Count-2Then Begin
     Buffer[I]:=Ch;Inc(I);
     WriteChar(Ch);
    End;
   End;
  Until(Ch=#13)or(CheckEOF and(Ch=#26));
  Buffer[I]:=Ch;Inc(I);
  If Ch=#13Then Begin
   Buffer[I]:=#10;Inc(I);
   WriteChar(#13)
  End;
  TrackCursor;
  ReadBuf:=I
 {$ENDIF}
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Fonction WhereX                            Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Destination/Plate-Forme: Windows 3.xx


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction retourne la position horizontal actuel dans la fenˆtre
 active du curseur.
}

Function WhereX:Integer;Begin
 {$IFNDEF Win32}
  WhereX:=Cursor.X;
 {$ENDIF} 
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Fonction WhereY                            Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Destination/Plate-Forme: Windows 3.xx


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction retourne la position vertical actuel dans la fenˆtre
 active du curseur.
}

Function WhereY:Integer;Begin
 {$IFNDEF Win32}
  WhereY:=Cursor.Y;
 {$ENDIF}
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Procedure ClrScr                           Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Destination/Plate-Forme: Windows 3.xx


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'effacer la fenˆtre de l'application.
}

Procedure ClrScr;Begin
 {$IFNDEF Win32}
  InitWinCrt;
  FillChar(ScrBuf^,ScreenSize.X*ScreenSize.Y,' ');
  LongInt(Cursor):=0;LongInt(Origin):=0;
  SetScrollBars;
  InvalidateRect(CrtWindow,NIL,True);
  UpdateWindow(CrtWindow);
 {$ENDIF}
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Procedure FillScreen                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Destination/Plate-Forme: Windows 3.xx


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'effacer la fenˆtre de l'application.
}

Procedure FillScreen;Begin
 ClrScr(Attr)
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Procedure ClrEol                           Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Destination/Plate-Forme: Windows 3.xx


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'effacer la fin d'une ligne.
}

Procedure ClrEol;Begin
 {$IFNDEF Win32}
  InitWinCrt;
  FillChar(ScrPtr(Cursor.X,Cursor.Y)^,ScreenSize.X-Cursor.X,' ');
  ShowText(Cursor.X,ScreenSize.X);
 {$ENDIF} 
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Procedure WindowCreate                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Destination/Plate-Forme: Windows 3.xx


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure cr‚e une fenˆtre.
}

Procedure WindowCreate;Begin
 {$IFNDEF Win32}
  Created:=True;
  GetMem(ScrBuf,ScreenSize.X*ScreenSize.Y);
  FillChar(ScrBuf^,ScreenSize.X*ScreenSize.Y,' ');
  If Not(CheckBreak)Then
   EnableMenuItem(GetSystemMenu(CrtWindow,False),sc_Close,mf_Disabled+mf_Grayed);
 {$ENDIF}
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Procedure WindowPaint                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Destination/Plate-Forme: Windows 3.xx


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de restituer la fenˆtre.
}

Procedure WindowPaint;Var X1,X2,Y1,Y2:Integer;Begin
 {$IFNDEF Win32}
  Painting:=True;
  InitDeviceContext;
  X1:=Max(0,PS.rcPaint.Left div CharSize.X+Origin.X);
  X2:=Min(ScreenSize.X,(PS.rcPaint.Right+CharSize.X-1)div CharSize.X+Origin.X);
  Y1:=Max(0,PS.rcPaint.top div CharSize.Y+Origin.Y);
  Y2:=Min(ScreenSize.Y,(PS.rcPaint.bottom+CharSize.Y-1)div CharSize.Y+Origin.Y);
  While(Y1<Y2)do Begin
   TextOut(DC,(X1-Origin.X)*CharSize.X,(Y1-Origin.Y)*CharSize.Y,ScrPtr(X1,Y1),X2-X1);
   Inc(Y1)
  End;
  DoneDeviceContext;
  Painting:=False
 {$ENDIF} 
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                    Procedure WindowScroll                    Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Destination/Plate-Forme: Windows 3.xx


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure est utilis‚ afin d'effectuer la mise-…-jour des
 informations dans le cas d'un d‚filement.
}

Procedure WindowScroll(Which,Action,Thumb:Integer);Var X,Y:Integer;

{$IFNDEF Win32}
 Function GetNewPos(Pos,Page,Range:Integer):Integer;Begin
  Case(Action)of
   sb_LineUp:GetNewPos:=Pos-1;
   sb_LineDown:GetNewPos:=Pos+1;
   sb_PageUp:GetNewPos:=Pos-Page;
   sb_PageDown:GetNewPos:=Pos+Page;
   sb_Top:GetNewPos:=0;
   sb_Bottom:GetNewPos:=Range;
   sb_ThumbPosition:GetNewPos:=Thumb;
   Else GetNewPos:=Pos;
  End;
 End;
{$ENDIF}

Begin
 {$IFNDEF Win32}
  X:=Origin.X;Y:=Origin.Y;
  Case(Which)of
   sb_Horz:X:=GetNewPos(X,ClientSize.X shr 1,Range.X);
   sb_Vert:Y:=GetNewPos(Y,ClientSize.Y,Range.Y);
  End;
  ScrollTo(X,Y);
 {$ENDIF} 
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Procedure WindowReSize                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Destination/Plate-Forme: Windows 3.xx


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de changer le format de la fenˆtre d'affichage
 de l'application.
}

Procedure WindowResize(X,Y:Integer);Begin
 {$IFNDEF Win32}
  If(Focused)and(Reading)Then CloseCur;
  ClientSize.X:=X div CharSize.X;
  ClientSize.Y:=Y div CharSize.Y;
  Range.X:=Max(0,ScreenSize.X-ClientSize.X);
  Range.Y:=Max(0,ScreenSize.Y-ClientSize.Y);
  Origin.X:=Min(Origin.X,Range.X);
  Origin.Y:=Min(Origin.Y,Range.Y);
  SetScrollBars;
  If(Focused)and(Reading)Then ShowCursor;
 {$ENDIF} 
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Procedure WindowMinMaxInfo                   Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Destination/Plate-Forme: Windows 3.xx


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure est utilis‚e afin de connaŒtre divers information sur
 la fenˆtre d'application.
}

{$IFNDEF Win32}
 Procedure WindowMinMaxInfo(MinMaxInfo:PMinMaxInfo);Var X,Y:Integer;Metrics:TTextMetric;Begin
  InitDeviceContext;
  GetTextMetrics(DC,Metrics);
  CharSize.X:=Metrics.tmMaxCharWidth;
  CharSize.Y:=Metrics.tmHeight+Metrics.tmExternalLeading;
  CharAscent:=Metrics.tmAscent;
  X:=Min(ScreenSize.X*CharSize.X+GetSystemMetrics(sm_CXVScroll),
     GetSystemMetrics(sm_CXScreen))+(GetSystemMetrics(sm_CXFrame)shl 1);
  Y:=Min(ScreenSize.Y*CharSize.Y+GetSystemMetrics(sm_CYHScroll)+
     GetSystemMetrics(sm_CYCaption),GetSystemMetrics(sm_CYScreen))+
     (GetSystemMetrics(sm_CYFrame)shl 1);
  MinMaxInfo^[1].x:=X;MinMaxInfo^[1].y:=Y;
  MinMaxInfo^[3].x:=(CharSize.X shl 4)+GetSystemMetrics(sm_CXVScroll)+
                    (GetSystemMetrics(sm_CXFrame)shl 1);
  MinMaxInfo^[3].y:=(CharSize.Y shl 2)+GetSystemMetrics(sm_CYHScroll)+
     (GetSystemMetrics(sm_CYFrame)shl 1)+GetSystemMetrics(sm_CYCaption);
  MinMaxInfo^[4].x:=X;MinMaxInfo^[4].y:=Y;
  DoneDeviceContext;
 End;
{$ENDIF} 

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Procedure WindowChar                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Destination/Plate-Forme: Windows 3.xx


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure est un handleur de message ®wm_Char¯.
}

Procedure WindowChar(Ch:Char);Begin
 {$IFNDEF Win32}
  If(CheckBreak)and(Ch=#3)Then Terminate;
  If KeyCount<SizeOf(KeyBuffer)Then Begin;KeyBuffer[KeyCount]:=Ch;Inc(KeyCount)End;
 {$ENDIF} 
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Procedure WindowKeyDown                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Destination/Plate-Forme: Windows 3.xx


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure est un handleur de message ®wm_KeyDown¯.
}

Procedure WindowKeyDown(KeyDown:Byte);Var CtrlDown:Boolean;I:Integer;Begin
 {$IFNDEF Win32}
  If(CheckBreak)and(KeyDown=vk_Cancel)Then Terminate;
  CtrlDown:=GetKeyState(vk_Control)<0;
  For I:=1to(ScrollKeyCount)do With ScrollKeys[I]do If(Key=KeyDown)and(Ctrl=CtrlDown)Then Begin
   WindowScroll(SBar,Action,0);
   Exit;
  End;
 {$ENDIF} 
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure WindowSetFocus                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Destination/Plate-Forme: Windows 3.xx


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure est un handleur de message ®wm_SetFocus¯.
}

Procedure WindowSetFocus;Begin
 {$IFNDEF Win32}
  Focused:=True;
  If(Reading)Then ShowCursor;
 {$ENDIF}
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Procedure WindowKillFocus                    Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Destination/Plate-Forme: Windows 3.xx


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure est un handleur de message ®wm_KillFocus¯.
}

Procedure WindowKillFocus;Begin
 {$IFNDEF Win32}
  If(Reading)Then CloseCur;
  Focused:=False;
 {$ENDIF}
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Procedure WindowDestroy                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Destination/Plate-Forme: Windows 3.xx


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure est un handleur de message ®wm_Destroy¯.
}

Procedure WindowDestroy;Begin
 {$IFNDEF Win32}
  FreeMem(ScrBuf,ScreenSize.X*ScreenSize.Y);
  Longint(Cursor):=0;Longint(Origin):=0;
  PostQuitMessage(0);
  Created:=False
 {$ENDIF}
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Fonction CrtWinProc                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Destination/Plate-Forme: Windows 3.xx


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction effectue le traŒtement de fenˆtre de la fenˆtrage CRT.
}

Function CrtWinProc(Window:Word;Message,WParam:Word;LParam:Longint):Longint;Begin
 {$IFNDEF Win32}
  CrtWinProc:=0;CrtWindow:=Window;
  Case(Message)of
   wm_Create:WindowCreate;
   wm_Paint:WindowPaint;
   wm_VScroll:WindowScroll(sb_Vert,WParam,LongRec(LParam).Lo);
   wm_HScroll:WindowScroll(sb_Horz,WParam,LongRec(LParam).Lo);
   wm_Size:WindowResize(LongRec(LParam).Lo,LongRec(LParam).Hi);
   wm_GetMinMaxInfo:WindowMinMaxInfo(PMinMaxInfo(LParam));
   wm_Char:WindowChar(Char(WParam));
   wm_KeyDown:WindowKeyDown(Byte(WParam));
   wm_SetFocus:WindowSetFocus;
   wm_KillFocus:WindowKillFocus;
   wm_Destroy:WindowDestroy;
   Else CrtWinProc:=DefWindowProc(Window,Message,WParam,LParam);
  End;
{$ENDIF}
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Fonction CrtOutput                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Destination/Plate-Forme: Windows 3.xx


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Fonction de sortie pour le pilote de fichier texte.
}

{$IFNDEF Win32}
 Function CrtOutput(Var F:TTextRec):Integer;Far;Begin
  If F.BufPos<>0Then Begin
   WriteBuf(PChar(F.BufPtr),F.BufPos);
   F.BufPos:=0;
   KeyPressed;
  End;
  CrtOutput:=0;
 End;
{$ENDIF}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Fonction CrtInput                           Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Destination/Plate-Forme: Windows 3.xx


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Fonction d'entr‚e pour le pilote de fichier texte.
}

{$IFNDEF Win32}
 Function CrtInput(Var F:TTextRec):Integer;Far;Begin
  F.BufEnd:=ReadBuf(PChar(F.BufPtr),F.BufSize);
  F.BufPos:=0;
  CrtInput:=0;
 End;
{$ENDIF} 

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Fonction CrtClose                           Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Destination/Plate-Forme: Windows 3.xx


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Fonction de fermeture pour le pilote de fichier texte
}

{$IFNDEF Win32}
 Function CrtClose(Var F:TTextRec):Integer;Far;Begin
  CrtClose:=0
 End;
{$ENDIF} 

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Fonction CrtOpen                            Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Destination/Plate-Forme: Windows 3.xx


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  C'est une fonction d'ouverture pour le pilote de fichier texte
}

{$IFNDEF Win32}
 Function CrtOpen(Var F:TTextRec):Integer;Far;Begin
  If(F.Mode=fmInput)Then Begin
   F.InOutFunc:=@CrtInput;
   F.FlushFunc:=Nil;
  End
   else
  Begin
   F.Mode:=fmOutput;
   F.InOutFunc:=@CrtOutput;
   F.FlushFunc:=@CrtOutput;
  End;
  F.CloseFunc:=@CrtClose;
  CrtOpen:=0;
 End;
{$ENDIF} 

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure AssignCrt                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Destination/Plate-Forme: Windows 3.xx


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet l'initialisation d'un fichier texte … une device
 CRT.
}

Procedure AssignCrt(Var F:Text);Begin
 {$IFNDEF Win32}
  With TTextRec(F)do Begin
   Handle:=$FFFF;Mode:=fmClosed;
   BufSize:=SizeOf(Buffer);
   BufPtr:=@Buffer;
   OpenFunc:=@CrtOpen;
   Name[0]:=#0;
  End;
 {$ENDIF}
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure InitWinCrt                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Destination/Plate-Forme: Windows 3.xx


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure effectue la cr‚ation de fenˆtre CRT si n‚cessaire.
}

Procedure InitWinCrt;Begin
 {$IFNDEF Win32}
  If Not(Created)Then Begin
   CrtWindow:=CreateWindow(CrtClass.lpszClassName,WindowTitle,
              ws_OverlappedWindow+ws_HScroll+ws_VScroll,
              WindowOrg.X,WindowOrg.Y,WindowSize.X,WindowSize.Y,0,0,HInstance,Nil);
   ShowWindow(CrtWindow,CmdShow);
   UpdateWindow(CrtWindow);
  End;
 {$ENDIF}
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Fonction GetRawY                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Destination/Plate-Forme: Windows 3.xx


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction retourne une position correspondant … la coordonn‚e
 ou commence les caractŠres au niveau des lignes en pixel.
}

Function GetRawY;Begin
 GetRawY:=0;
 { A d‚velopper...}
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure InitSound                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Destination/Plate-Forme: Windows 3.xx


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'effectuer une d‚tection de la carte de son
 actuellement install‚e sur la machine.
}

Procedure InitSound;Begin
 { A d‚velopper...}
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Fonction IsLuxe                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Destination/Plate-Forme: Windows 3.xx


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de savoir si l'application utilise actuellement
 une police de caractŠre de 512 caractŠres (True) ou non (False).
}
Function IsDblMtx;Begin
 IsDblMtx:=No;
 { A d‚velopper...}
End;

Procedure SetNumYTexts;Begin
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Fonction IsLuxe                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Destination/Plate-Forme: Windows 3.xx


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de d‚terminer s'il s'agit d'un mode vid‚o de
 luxe ou ordinaire sans effet sp‚cial.
}

Function IsLuxe;Begin
 IsLuxe:=Ya;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure SetLuxe                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Destination/Plate-Forme: Windows 3.xx


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de s‚lectionner le mode de luxe de l'affiche
 vid‚o.
}

Procedure SetLuxe;Begin
 {A d‚velopper...}
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                      Fonction _ImageSize                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Destination/Plate-Forme: Windows 3.xx


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de d‚terminer la dimension d'une image en
 fonction de la d‚finition actuel de l'‚cran de l'application.
}

Function _ImageSize;Begin
 _ImageSize:=GetSizeSmlImg(X1,Y1,X2,Y2)
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure DoneWinCrt                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Destination/Plate-Forme: Windows 3.xx


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure effectue la destruction de fenˆtre CRT si n‚cessaire.
}

Procedure DoneWinCrt;Begin
 {$IFNDEF Win32}
  If(Created)Then DestroyWindow(CrtWindow);
  Halt(0)
 {$ENDIF}
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure ExitWinCrt                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Destination/Plate-Forme: Windows 3.xx


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Proc‚dure de fermeture de cette unit‚.
}

Procedure ExitWinCrt;Far;
{$IFNDEF Win32}
 Var
  P:PChar;
  Message:TMsg;
  Title:Array[0..127]of Char;
{$ENDIF}
Begin
 {$IFNDEF Win32}
  If(Created)and(ErrorAddr=Nil)Then Begin
   P:=WindowTitle;
   WVSPrintF(Title,InactiveTitle,P);
   SetWindowText(CrtWindow,Title);
   EnableMenuItem(GetSystemMenu(CrtWindow,True),sc_Close,mf_Enabled);
   ExitProc:=SaveExit;CheckBreak:=False;
   While GetMessage(Message,0,0,0)do Begin
    TranslateMessage(Message);
    DispatchMessage(Message);
   End;
  End;
 {$ENDIF}
End;

{$IFDEF Adele}

 Procedure CloseIcon(X,Y,Attr:Byte);Begin
 End;

 Procedure DownIcon(X,Y,Attr:Byte);Begin
 End;

 Procedure LeftIcon(X,Y,Attr:Byte);Begin
 End;

 Procedure RightIcon(X,Y,Attr:Byte);Begin
 End;

 Procedure SelIcon(X,Y,Attr:Byte);Begin
 End;

 Procedure UnSelIcon(X,Y,Attr:Byte);Begin
 End;

 Procedure UpIcon(X,Y,Attr:Byte);Begin
 End;

 Procedure ZoomIcon(X,Y,Attr:Byte);Begin
 End;

 Procedure PutCloseIcon(X,Y,Attr:Byte);Begin
 End;

 Procedure PutDownIcon(X,Y,Attr:Byte);Begin
 End;

 Procedure DossierDocumentIcon(X,Y,Attr:Byte);Begin
 End;

 Procedure DossierProgramIcon(X,Y,Attr:Byte);Begin
 End;

{$ENDIF}

{$ENDIF}

{$IFDEF Real}
{ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ}
{ÛÛ                Destination/Plate-Forme: Mode r‚el                 ÛÛ}
{ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ}

Uses CommBase,Memories,Systems;

{Cette objet contient les proc‚dures de base sans aucun superflue pour la
 gestion du vid‚o. Il est impensable de l'amaigrir et de le modifier...}
{$L ADELE.OBJ}
{$L HEADER.OBJ}

Var StartUp:StartUpRec Absolute CPU; { Enregistrement des donn‚es recueillis
                                       lors de la d‚tection du mat‚riel
                                       install‚ sur la machine.}
{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Fonction DirectAltPress                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Destination/Plate-Forme: Mode r‚el
 SystŠme d'exploitation:  DOS
 Machine:                 IBM PC
 Source:                  ADELE.ASM (\Source\Chantal\)


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction  contient une adresse  de la routine d'accŠs directe au
 donn‚es BIOS permettant de connaŒtre l'‚tat de la touche de combinaison
 ®ALT¯ dans le pilote vid‚o d'AdŠle.


 Remarque
 ÍÍÍÍÍÍÍÍ

  ş ATTENTION!  Ne  doit  jamais  ˆtre appeler  aprŠs  initialisation du
    pilote car  son  adresse est  totalement  chang‚e et  la position de
    d‚marrage  est ‚craser  afin de  laisser  place au  routine  d'accŠs
    directe vid‚o d'AdŠle.
}

Function DirectAltPress;External;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Fonction DirectCtrlPress                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Destination/Plate-Forme: Mode r‚el
 SystŠme d'exploitation:  DOS
 Machine:                 IBM PC
 Source:                  ADELE.ASM (\Source\Chantal\)


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction  contient une adresse  de la routine d'accŠs directe au
 donn‚es BIOS permettant de connaŒtre l'‚tat de la touche de combinaison
 ®CTRL¯ dans le pilote vid‚o d'AdŠle.


 Remarque
 ÍÍÍÍÍÍÍÍ

  ş ATTENTION!  Ne  doit  jamais  ˆtre appeler  aprŠs  initialisation du
    pilote car  son  adresse est  totalement  chang‚e et  la position de
    d‚marrage  est ‚craser  afin de  laisser  place au  routine  d'accŠs
    directe vid‚o d'AdŠle.
}

Function DirectCtrlPress;External;
Procedure DirectFillChar;External;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Proc‚dure DirectGetIntVec                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Destination/Plate-Forme: Mode r‚el
 SystŠme d'exploitation:  DOS
 Machine:                 IBM PC
 Source:                  ADELE.ASM (\Source\Chantal\)


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction  contient une adresse  de la routine d'accŠs directe au
 donn‚es m‚moire  d'interruption permettant  de connaŒtre l'adresse d'un
 vecteur d'interruption.


 Remarque
 ÍÍÍÍÍÍÍÍ

  ş ATTENTION!  Ne  doit  jamais  ˆtre appeler  aprŠs  initialisation du
    pilote car  son  adresse est  totalement  chang‚e et  la position de
    d‚marrage  est ‚craser  afin de  laisser  place au  routine  d'accŠs
    directe vid‚o d'AdŠle.
}

Procedure DirectGetIntVec;External;
Function DirectGetRawTimer;External;
Function DirectGetRawTimerB;External;
Function DirectJoyPos;External;
Function DirectKeyPress;External;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Fonction DirectLShiftPress                    Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Destination/Plate-Forme: Mode r‚el
 SystŠme d'exploitation:  DOS
 Machine:                 IBM PC
 Source:                  ADELE.ASM (\Source\Chantal\)


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction  contient une adresse  de la routine d'accŠs directe au
 donn‚es BIOS permettant de connaŒtre l'‚tat de la touche de combinaison
 ®SHIFT¯ de gauche dans le pilote vid‚o d'AdŠle.


 Remarque
 ÍÍÍÍÍÍÍÍ

  ş ATTENTION!  Ne  doit  jamais  ˆtre appeler  aprŠs  initialisation du
    pilote car  son  adresse est  totalement  chang‚e et  la position de
    d‚marrage  est ‚craser  afin de  laisser  place au  routine  d'accŠs
    directe vid‚o d'AdŠle.
}

Function DirectLShiftPress;External;

Procedure DirectMove;External;
Procedure DirectMove386;External;
Procedure DirectPushKey;External;
Function DirectRawReadKey;External;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Fonction DirectRShiftPress                    Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Destination/Plate-Forme: Mode r‚el
 SystŠme d'exploitation:  DOS
 Machine:                 IBM PC
 Source:                  ADELE.ASM (\Source\Chantal\)


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction  contient une adresse  de la routine d'accŠs directe au
 donn‚es BIOS permettant de connaŒtre l'‚tat de la touche de combinaison
 ®SHIFT¯ de droite dans le pilote vid‚o d'AdŠle.


 Remarque
 ÍÍÍÍÍÍÍÍ

  ş ATTENTION!  Ne  doit  jamais  ˆtre appeler  aprŠs  initialisation du
    pilote car  son  adresse est  totalement  chang‚e et  la position de
    d‚marrage  est ‚craser  afin de  laisser  place au  routine  d'accŠs
    directe vid‚o d'AdŠle.
}

Function DirectRShiftPress;External;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Proc‚dure DirectSetIntVec                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Destination/Plate-Forme: Mode r‚el
 SystŠme d'exploitation:  DOS
 Machine:                 IBM PC
 Source:                  ADELE.ASM (\Source\Chantal\)


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction  contient une adresse  de la routine d'accŠs directe au
 donn‚es  m‚moire  d'interruption  permettant  de fixer  l'adresse  d'un
 vecteur d'interruption.


 Remarque
 ÍÍÍÍÍÍÍÍ

  ş ATTENTION!  Ne  doit  jamais  ˆtre appeler  aprŠs  initialisation du
    pilote car  son  adresse est  totalement  chang‚e et  la position de
    d‚marrage  est ‚craser  afin de  laisser  place au  routine  d'accŠs
    directe vid‚o d'AdŠle.
}

Procedure DirectSetIntVec;External;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Fonction DirectShiftPress                    Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Destination/Plate-Forme: Mode r‚el
 SystŠme d'exploitation:  DOS
 Machine:                 IBM PC
 Source:                  ADELE.ASM (\Source\Chantal\)


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction  contient une adresse  de la routine d'accŠs directe au
 donn‚es BIOS permettant de connaŒtre l'‚tat de la touche de combinaison
 ®SHIFT¯ dans le pilote vid‚o d'AdŠle.


 Remarque
 ÍÍÍÍÍÍÍÍ

  ş ATTENTION!  Ne  doit  jamais  ˆtre appeler  aprŠs  initialisation du
    pilote car  son  adresse est  totalement  chang‚e et  la position de
    d‚marrage  est ‚craser  afin de  laisser  place au  routine  d'accŠs
    directe vid‚o d'AdŠle.
}

Function DirectShiftPress;External;

Procedure StartUpChantal;External;
Procedure AutoDetect;External;{D‚tection automatique de la carte vid‚o}
Procedure Bar;External;{Affiche une boŒte graphique}
Procedure BarChrHor;External;{Affiche une banderole de caractŠre horizontal}
Procedure BarChrVer;External;{Affiche une banderole de caractŠre verticale}
Procedure BarSpaceHor;External;{Affiche une banderole}
Procedure BarSpaceHori;External;{Affiche une banderole}
Procedure BarSpaceHorizontal;External;{Affiche une banderole}
Procedure BarSpcHor;External;{Affiche une banderole horizontal}
Procedure BarSpcVer;External;{Affiche une banderole vertical}
Procedure BarTxtHor;External;{Affiche une banderole horizontal avec un caractŠre particulier}
Function  BiosBlinkFound;External;{Le Bios supporte le mode clignotement/intensit‚?}
Function  BitsPerPixel;External;{Nombre de Bit(s) utilis‚ pour l'affichage d'un pixel}
Function  BytesPerLine;External;{Nombre d'octet par ligne affich‚ (trŠs relatif en VGA...)}
Function  BytesPerLn;External;{Nombre d'octet par ligne affich‚ (trŠs relatif en VGA...)}
Procedure Circle;External;{Affiche un cercle}
Procedure ClearLineHor;External;{Trace une ligne graphique de tel longueur}
Procedure ClearLineHori;External;{Trace une ligne graphique de tel longueur}
Procedure ClearScr;External;{Efface l'‚cran avec tel attribut}
Procedure ClearScreen;External;{Efface l'‚cran avec tel attribut}
Procedure ClearWindow;External;{Efface une boŒte de caractŠres}
Procedure CloseCur;External;{Efface le curseur}
Procedure CloseCursor;External;{Efface le curseur}
Procedure ClrLnHor;External;{Trace une ligne graphique de tel longueur}
Procedure ClrLnHorImg;External;{Affiche une ligne image graphique de tel longueur}
Procedure ClrWn;External;{Efface une boŒte de caractŠres}
Procedure ClrScr;External;{Efface l'‚cran avec tel attribut}
Procedure Cls;External;{BASIC:Efface l'‚cran}
Procedure ClsCur;External;{Efface le curseur}
Function  ColorFound;External;{Carte de type couleur? autrement monochrome}
Procedure CopT8Bin;External;{Affiche une bar de 8 bits cons‚cutif et affecte le font s'ils sont … 1}
Procedure Copy8Bin;External;{Affiche une bar de 8 bits cons‚cutif pour un motif...}
Procedure FillBnk;External;{Efface une partie absolue de la m‚moire vid‚o}
Procedure FillBox;External;{Efface une boŒte avec les caractŠres et attributs sp‚cifi‚}
Procedure FillScreen;External;{Efface l'‚cran avec tel attribut}
Function  Focused;External;{Indique si le curseur est visible?}
Function  FontFound;External;{Police programme support‚ par cette carte?}
Function  GetAttr;External;{Demande l'attribut actuel … la position (X,Y)}
Function  GetBitsPerPixel;External;{Nombre de Bit(s) utilis‚ pour l'affichage d'un pixel}
Function  GetBytesPerLine;External;{Nombre d'octet par ligne affich‚ (trŠs relatif en VGA...)}
Function  GetBytesPerLn;External;{Nombre d'octet par ligne affich‚ (trŠs relatif en VGA...)}
Function  GetChar;External;{Demande le caractŠre … la position (X,Y)}
Function  GetCharacter;External;{Demande le caractŠre … la position (X,Y)}
Function  GetChr;External;{Demande le caractŠre … la position (X,Y)}
Function  GetCube;External;{Retourne les informations: CaractŠre, Attribut}
Function  GetCur;External;{Demande le format du curseur}
Function  GetHeightChar;External;{Hauteur de la police de caractŠre actuel}
Function  GetHeightCharacter;External;{Hauteur de la police de caractŠre actuel}
Function  GetHeightChr;External;{Hauteur de la police de caractŠre actuel}
Procedure GetLnHorImg;External;{Demande l'image vid‚o de la ligne sp‚cifi‚}
Function  GetMaxColors;External;{Demande le num‚ro maximum de couleur}
Function  GetMaxColor;External;{BORLAND:Demande le num‚ro maximum de couleur}
Function  GetMaxKr;External;{Demande le num‚ro maximum de couleur}
Function  GetMaxPal;External;{Demande le nombre maximum de palette}
Function  GetMaxX;External;{BORLAND: Retourne la coordonn‚e X maximal}
Function  GetMaxXPixels;External;{BORLAND: Retourne la coordonn‚e X maximal}
Function  GetMaxXTxts;External;{Demande la coordonn‚e texte X maximal }
Function  GetMaxY;External;{BORLAND: Retourne la coordonn‚e Y maximal}
Function  GetMaxYPixels;External;{BORLAND: Retourne la coordonn‚e Y maximal}
Function  GetMaxYTxts;External;{Demande la coordonn‚e texte Y maximal }
Procedure GetMIV;External;{Charge tous les informations de mode con‡ernant la carte vid‚o actuel}
Procedure GetModeInfoVideo;External;{Charge tous les informations de mode con‡ernant la carte vid‚o actuel}
Function  GetNmColors;External;{Nombre de couleurs affich‚}
Function  GetNmKr;External;{Nombre de couleurs affich‚}
Function  GetNmVideoPages;External;{Nombre de page vid‚o que supporte le mode actuel}
Function  GetNmXPixels;External;{Nombre de pixels horizontal qu'affiche l'‚cran}
Function  GetNmXTxts;External;{Nombre de caractŠre texte horizontal qu'affiche l'‚cran}
Function  GetNmYPixels;External;{Nombre de pixels vertical qu'affiche l'‚cran}
Function  GetNmYTxts;External;{Nombre de caractŠre texte vertical qu'affiche l'‚cran}
Function  GetNumColors;External;{Nombre de couleurs affich‚}
Function  GetNumXPixels;External;{Nombre de pixels horizontal qu'affiche l'‚cran}
Function  GetNumYPixels;External;{Nombre de pixels vertical qu'affiche l'‚cran}
Procedure GetPhysInfoVideo;External;{Charge tous les informations physique con‡ernant la carte vid‚o actuel}
Procedure GetPhysicalInfoVideo;External;{Charge tous les informations physique con‡ernant la carte vid‚o actuel}
Procedure GetPIV;External;{Charge tous les informations physique con‡ernant la carte vid‚o actuel}
Procedure GetPIVSec;External;{Charge tous les informations physique con‡ernant la carte vid‚o secondaire}
Function  GetPixel;External;{BORLAND: Demande la couleur du Pixel se trouvant … (X,Y)}
Function  GetRawY;External;
Function  GetRealRawY;External;
Function  GetRealRawYWord;External;
Function  GetSelPg;External;{Demande le num‚ro de banque de la page courant}
Function  GetSizeSmlImg;External;{Demande la taille que demande l'image sp‚cifi‚}
Procedure GetSmlImg;External;{Sauvegarde dans un tampon l'image d‚finit dans (X1,Y1)-(X2,Y2)}
Function  GetVideoBitsDAC;External;{Nombre de bits utilis‚ pour modifi‚ un des 3 DAC RGB}
Function  GetVideoBitsIO;External;{Nombre d'accŠs bits au entr‚e/sortie vid‚o}
Function  GetVideoBitsROM;External;{Nombre d'accŠs bits … la ROM Bios}
Function  GetVideoBnkPg;External;{Demande le num‚ro de banque de la page courant}
Function  GetVideoCard;External;{Demande le nom de la carte vid‚o (vn????)}
Function  GetVideoCardCat;External;{Demande la cat‚gorie de la carte vid‚o(MDA,CGA,...)(cvn????)}
Function  GetVideoPg;External;{Num‚ro de la page vid‚o de travail}
Function  GetVideoMem;External;{Nombre de m‚moire (en octet) dont dispose la carte vid‚o}
Function  GetVideoMemory;External;{Nombre de m‚moire (en octet) dont dispose la carte vid‚o}
Function  GetVideoMode;External;{Demande le mode vid‚o actuel (vm???)}
Function  GetVideoMonitor;External;{Demande le nom du moniteur (mn????)}
Function  GetVideoScrSize;External;{Demande la taille de l'‚cran}
Function  GetVideoSeg;External;{Segment vid‚o (A000h,B000h,B800h,...)}
Function  GetVideoSegBuf;External;{Graphique: Segment du tampon de l'acc‚lateur}
Function  GetVideoSegROM;External;{Demande l'adresse de la ROM Bios}
Function  GetVideoShowPg;External;{Num‚ro de la page vid‚o actuellement affich‚?}
Function  GetVideoSizeBnkPg;External;{Taille d'un page de la banque (0=64Ko)}
Function  GetVideoTxtAddrPg;External;{En texte, adresse en m‚moire vid‚o de la page actuel}
Function  GetVideoTxtMtxPtr;External;{Pointeur sur la police de caractŠre courante}
Function  GetVidMem;External;{Nombre de m‚moire (en octet) dont dispose la carte vid‚o}
Function  GetXCurPos:Byte;External;
Function  GetYCurPos:Byte;External;
Procedure GotoXY;External;{PASCAL: Fixe la position du curseur}
Function  HeightChr;External;{Hauteur de la police de caractŠre actuel}
Procedure Init;External;{Initialise le pilote charg‚ en m‚moire}
Procedure InitSound;External;{D‚tection des cartes de son}
Function  IsBlink;External;{Clignotement?}
Function  IsColor;External;{Mode couleur? Sinon monochrome for‡‚ment...}
Function  IsDblMtx;External;{En 512 caractŠres?}
Function  IsEGA;External;{La carte est post‚rieur ou ‚gale … l'EGA?}
Function  IsGraf;External;{Mode graphique? Sinon texte}
Function  IsGraphics;External;{Mode graphique? Sinon texte}
Function  IsGraphix;External;{Mode graphique? Sinon texte}
Function  IsGrf;External;{Mode graphique? Sinon texte}
Function  IsKr;External;{Mode couleur? Sinon for‡‚ment monochrome...}
Function  IsMono;External;{Mode monochrome? Sinon for‡‚ment couleur...}
Function  IsMonochrome;External;{Mode monochrome? Sinon for‡‚ment couleur...}
Function  IsVESA;External;{Le standard VESA support‚?}
Function  IsVGA;External;{La carte est post‚rieur ou ‚gale … la VGA?}
Function  IsVideoBlink;External;{Clignotement?}
Function  IsVideoDirectAccess;External;{M‚thode directe? Sinon Bios ou Dos}
Function  IsVideoModeBios;External;{Mode support‚ par le Bios (Par exemple, la GS en 16 couleurs le Bios ne le connaŒt pas)}
Function  IsVideoModeIBMLogic;External;{Mode dans la logique IBM (pas hors cas texte … la SVGA...)}
Function  IsVideoSnow;External;{Neige lors de l'envoie de donn‚e dans le tampon vid‚o?}
Function  KrFound;External;{Carte de type couleur? autrement monochrome}
Procedure Locate;External;{BASIC: Fixe la position du curseur}
Function  MaxXTxts;External;{Demande la coordonn‚e texte X maximal }
Function  MaxYTxts;External;{Demande la coordonn‚e texte Y maximal }
Procedure MoveText;External;{D‚place une fenˆtre texte}
Function  NmXPixels;External;{Nombre de pixels horizontal qu'affiche l'‚cran}
Function  NmXTxts;External;{Nombre de caractŠre texte horizontal qu'affiche l'‚cran}
Function  NmYPixels;External;{Nombre de pixels vertical qu'affiche l'‚cran}
Function  NmYTxts;External;{Nombre de caractŠre texte vertical qu'affiche l'‚cran}
Procedure PageCopy;External;{Copie une page dans une autres}
Procedure PCopy;External;{BASIC: Copie une page dans une autres}
Procedure PCopy2Img;External;{Copy une page sur une partie d'une autre page}
Procedure Plot;External;{BASIC APPLE ][: Affiche un Pixel}
Procedure Point;External;{BASIC: Affiche un Pixel}
Function  PrimCardCat;External;{Demande la cat‚gorie de la carte vid‚o(MDA,CGA,...)(cvn????)}
Procedure PSet;External;{BASIC: Affiche un Pixel}
Procedure PutCharGAttr;External;{Affichage typ‚ pour le traitement de texte}
Procedure PutFillBox;External;{Affiche une boŒte de couleur sp‚cifi‚ de (X1,Y1)-(X2,Y2)}
Procedure PutFillCircle;External;{Affiche un cercle plein}
Procedure PutFillRoundRect;External;{Affiche un rectangle plein avec les coins rond}
Procedure PutLine;External;{Affiche une ligne}
Procedure PutLineHori;External;{Affiche une ligne horizontal}
Procedure PutLn;External;{Affiche une ligne}
Procedure PutLnHor;External;{Affiche une ligne horizontal}
Procedure PutRect;External;{Affiche un rectangle vide}
Procedure PutRoundRect;External;{Affiche un rectangle avec les coins rond}
Procedure PutSmlImg;External;{Affiche … l'‚cran l'image contenu dans un tampon}
Procedure PutSprite;External;{Affiche … l'‚cran l'image contenu dans un tampon}
Procedure PutTextXY;External;{Affiche un message … (X,Y)}
Procedure PutTxtXY;External;{Affiche un message … (X,Y)}
Procedure PutTxtXYUnCol;External;{Affiche un message … (X,Y) sans affecter les couleurs}
Procedure PutTxtXYUnKr;External;{Affiche un message … (X,Y) sans affecter les couleurs}
Procedure ReadBnk;External;{Lit des donn‚es dans la banque vid‚o Super VGA}
Procedure SelBnkPg;External;{Fixe le plane de la banque vid‚o Super VGA}
Procedure SetAttr;External;{Fixe un attribut … (X,Y)}
Procedure SetBackgroundColor;External;
Procedure SetBlink;External;{Fixe l'affichage … Clignotement ou Intensit‚}
Procedure SetBnkPg;External;{Fixe le plane de la banque vid‚o Super VGA}
Procedure SetBorderColor;External;{Fixe la couleur de la bordure de l'‚cran}
Procedure SetBytesPerLn;External;{VGA+:Fixe la largeur des bandes}
Procedure SetChar;External;{Fixe un caractŠre … (X,Y)}
Procedure SetCharacter;External;{Fixe un caractŠre … (X,Y)}
Procedure SetChr;External;{Fixe un caractŠre … (X,Y)}
Procedure SetChrWidth;External;{Fixe la largeur des caractŠres 8/9 pixels}
Procedure SetCube;External;{Fixe un caractŠre et son attribut … (X,Y)}
Procedure SetCur;External;{Fixe le format du curseur}
Procedure SetCurPos;External;{Fixe la position du curseur}
Procedure SetCursor;External;{Fixe le format du curseur}
Procedure SetCursorPos;External;{Fixe la position du curseur}
Procedure SetCursorPosition;External;{Fixe la position du curseur}
Procedure SetDblMtx;External;{Fixe la police … 512 caractŠres}
Procedure SetExtChr;External;
Procedure SetExtCube;External;
Procedure SetHorizontalScale;External;
Procedure SetHeightChr;External;{Fixe la hauteur des caractŠres}
Procedure SetGCube;External;{Affiche un caractŠre et son attribut … la position (X,Y) en pixel}
Procedure SetGCubeT;External;{Affiche un caractŠre et son attribut … la position (X,Y) en pixel sans changer le fond}
Procedure SetPage;External;{Fixe la page de travail}
Procedure SetPalBlk;External;{Fixe les palettes noir}
Procedure SetPaletteRGB;External;{Fixe une palette isol‚e}
Procedure SetPalRGB;External;{Fixe un groupe de palette}
Procedure SetMatrix;External;{Charge une police en m‚moire vid‚o}
Procedure SetModeMatrix;External;{Fixe le contr“leur vid‚o … la m‚moire des polices}
Procedure SetModeMtx;External;{Fixe le contr“leur vid‚o … la m‚moire des polices}
Procedure SetModeScr;External;{Fixe le contr“leur vid‚o … la m‚moire ‚cran}
Procedure SetModeScreen;External;{Fixe le contr“leur vid‚o … la m‚moire ‚cran}
Procedure SetModeValue;External;{Fixe le seulement le code du mode vid‚o actuel}
Procedure SetPg;External;{Fixe la page de travail}
Procedure SetPixel;External;{Fixe un pixel … l'‚cran}
Procedure SetPhysInfoVideo;External;{Fixe tous les informations physique con‡ernant la carte vid‚o actuel}
Procedure SetPhysicalInfoVideo;External;{Fixe tous les informations physique con‡ernant la carte vid‚o actuel}
Procedure SetPIV;External;{Fixe tous les informations physique con‡ernant la carte vid‚o actuel}
Procedure SetTxtMtx;External;{Fixe l'adresse de la nouvelle police texte}
Procedure SetUnderline;External;{VGA Texte Coulour:Fixe l'attribut haut de couleur d'‚criture pour Soulignement/Intensit‚}
Procedure SetVerticalScale;External;{Fixe le d‚calage vertical:Animation vertical...}
Procedure SetVideoSeg;External;{Fixe l'adresse de segment vid‚o}
Procedure SetVisualPage;External;{Fixe le num‚ro de la page actuellement affich‚}
Procedure SetVisualPg;External;{Fixe le num‚ro de la page actuellement affich‚}
Procedure SetWriteMode;External;{Fixe le mode d'‚criture: 0=crase,1=Et,2=Ou,3=Ou exclusif}
Procedure SplitScreen;External;{VGA+: Fractionne l'‚cran en deux parties...}
Function  Stat;External;{BASIC ‚tendue du Coco 3: Retourne les informations: CaractŠre, Attribut}
Function  VGA320x400Found;External;{Le mode VGA 320x400 est support‚ (pas toujours le cas chez les clones)?}
Function  VideoFontFound;External;{Police programme support‚ par cette carte?}
Function  VideoHerculeFound;External;{Mode Hercule support‚ par cette carte?}
Function  VideoMousePortFound;External;{Port souris inclue … la carte vid‚o?}
Function  VideoPaletteFound;External;{Palette de couleur programme support‚?}
Procedure WriteBnk;External;{crit des donn‚es dans la banque vid‚o Super VGA}
Procedure WriteXY;External;{Turbo Pascal 3: Affiche un message … (X,Y)}
Procedure WriteXYUnKr;External;{Affiche un message sans affecter les couleurs pr‚sente}
Procedure SetLuxe;External;
Function  IsLuxe;External;
Procedure CloseIcon;External;{Affiche un icon de fermeture}
Procedure DownIcon;External;{Affiche un icon de flŠche vers le bas}
Procedure LeftIcon;External;{Affiche un icon de flŠche vers la gauche}
Procedure RightIcon;External;{Affiche un icon de flŠche vers la droite}
Procedure SelIcon;External;{Affiche un icon de s‚lection}
Procedure UnSelIcon;External;{Affiche un icon d'annulation de s‚lection}
Procedure UpIcon;External;{Affiche un icon de flŠche vers le haut}
Procedure ZoomIcon;External;{Affiche un icon de plein ‚cran}
Procedure PutCloseIcon;External;{Affiche un icon de fermeture}
Procedure PutDownIcon;External;{Affiche un icon de flŠche vers le bas}
Procedure DossierDocumentIcon;External;{Affiche un icon de dossier de document}
Procedure DossierProgramIcon;External;{Affiche un icon de dossier de programme}
Procedure SetNumYTexts;External;{Fixe le nombre de ligne texte}
Procedure Done;External;{D‚branche tous les services entraŒner par le pilote}
Function  _GetActivePage;External;{QuickPascal: Demande la page de travail}
Function  _GetPixel;External;{QuickPascal: Demande la couleur du Pixel affich‚ … tel endroit}
Function  _ImageSize;External;{QuickPascal: Taille d'une image}
Procedure _SetActivePage;External;{QuickPascal: Fixe la page de travail}
Function  viInitVideo;External;
Function  viSetVideoModePrim;External;
Function  viSetVideoSizePrim;External;
Procedure mtxStartUp;External;
{$ELSE}

{ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ}
{ÛÛ       Destination/Plate-Forme: Mode prot‚g‚, DPMI et Windows      ÛÛ}
{ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ}

Procedure _AutoDetect(CheckSVGA:Bool);Begin
End;

Procedure AutoDetect;Begin
 _AutoDetect(CheckSVGA)
End;

 {Affiche une boŒte graphique}
Procedure Bar;Begin
End;

Procedure BarChrHor;Begin
End;

Procedure BarChrVer;Begin
End;

 {Affiche une banderole}
Procedure BarSpaceHor;Begin
End;

 {Affiche une banderole}
Procedure BarSpaceHori;Begin
End;

 {Affiche une banderole}
Procedure BarSpaceHorizontal;Begin
End;

 {Affiche une banderole}
Procedure BarSpcHor;Begin
End;

 {Affiche une banderole vertical}
Procedure BarSpcVer;Begin
End;

 {Affiche une banderole d'un caractŠre}
Procedure BarTxtHor;Begin
End;

 {Le Bios supporte le mode clignotement/intensit‚?}
Function BiosBlinkFound;Begin
End;

 {Nombre de Bit(s) utilis‚ pour l'affichage d'un pixel}
Function BitsPerPixel;Begin
End;

 {Nombre d'octet par ligne affich‚ (trŠs relatif en VGA...)}
Function BytesPerLine;Begin
End;

 {Nombre d'octet par ligne affich‚ (trŠs relatif en VGA...)}
Function BytesPerLn;Begin
End;

 {Affiche un cercle}
Procedure Circle;Begin
End;

 {Trace une ligne graphique de tel longueur}
Procedure ClearLineHor;Begin
End;

 {Trace une ligne graphique de tel longueur}
Procedure ClearLineHori;Begin
End;

Procedure ClearScr;Begin
 ClrScr(Attr)
End;

 {Efface l'‚cran avec tel attribut}
Procedure ClearScreen;Begin
 ClrScr(Attr)
End;

 {Efface une boŒte de caractŠres}
Procedure ClearWindow;Begin
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Procedure CloseCur                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Destination/Plate-Forme: DPMI 0.92 ou post‚rieur


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'efface le curseur.
}

Procedure CloseCur;
{$IFDEF Windows}
 External'USER' index 164;
{$ELSE}
 Begin
 End;
{$ENDIF}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Procedure CloseCursor                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Destination/Plate-Forme: DPMI 0.92 ou post‚rieur


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'efface le curseur.
}

Procedure CloseCursor;
{$IFDEF __Windows__}
 External'USER' index 164;
{$ELSE}
 Begin
 End;
{$ENDIF}

{$IFNDEF Win32}
 Procedure CloseIcon;Begin
 End;
{$ENDIF}

 {Trace une ligne graphique de tel longueur}
Procedure ClrLnHor;Begin
End;

 {Affiche une ligne image graphique de tel longueur}
Procedure ClrLnHorImg;Begin
End;

 {Efface une boŒte de caractŠres}
Procedure ClrWn;Begin
End;

{$IFNDEF __Windows__}
  {Efface l'‚cran avec tel attribut}
 Procedure ClrScr;Begin
 End;
{$ENDIF}

 {BASIC:Efface l'‚cran}
Procedure Cls;Begin
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Procedure ClsCur                            Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Destination/Plate-Forme: DPMI 0.92 ou post‚rieur


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'efface le curseur.
}

Procedure ClsCur;
{$IFDEF Windows}
 External'USER' index 164;
{$ELSE}
 Begin
 End;
{$ENDIF}

 {Carte de type couleur? autrement monochrome}
Function  ColorFound;Begin
End;

 {Affiche une bar de 8 bits cons‚cutif et affecte le font s'ils sont … 1}
Procedure CopT8Bin;Begin
End;

 {Affiche une bar de 8 bits cons‚cutif pour un motif...}
Procedure Copy8Bin;Begin
End;

{$IFNDEF Win32}
Procedure DossierDocumentIcon;Begin
End;

Procedure DossierProgramIcon;Begin
End;

Procedure DownIcon;Begin
End;
{$ENDIF}

 {Efface une boŒte avec les caractŠres et attributs sp‚cifi‚}
Procedure FillBox;Begin
End;

 {Efface une zone m‚moire vid‚o}
Procedure FillBnk;Begin
End;

{$IFNDEF Win32}
Procedure FillScreen;Begin
End;
{$ENDIF}

 {Police programme support‚ par cette carte?}
Function FontFound;Begin
End;

 {Demande l'attribut actuel … la position (X,Y)}
Function GetAttr;Begin
End;

 {Nombre de Bit(s) utilis‚ pour l'affichage d'un pixel}
Function GetBitsPerPixel;Begin
End;

 {Nombre d'octet par ligne affich‚ (trŠs relatif en VGA...)}
Function GetBytesPerLine;Begin
End;

 {Nombre d'octet par ligne affich‚ (trŠs relatif en VGA...)}
Function GetBytesPerLn;Begin
End;

 {Demande le caractŠre … la position (X,Y)}
Function GetChar;Begin
End;

 {Demande le caractŠre … la position (X,Y)}
Function GetCharacter;Begin
End;

 {Demande le caractŠre … la position (X,Y)}
Function GetChr;Begin
End;

 {Retourne les informations: CaractŠre, Attribut}
Function GetCube;Begin
End;

Function GetCur:Wd;Begin
End;

Function GetXCurPos:Byte;Begin
End;

Function GetYCurPos:Byte;Begin
End;

 {Hauteur de la police de caractŠre actuel}
Function GetHeightChar;Begin
 {$IFDEF Windows}
  GetHeightChar:=CharSize.Y
 {$ENDIF}
End;

 {Hauteur de la police de caractŠre actuel}
Function GetHeightCharacter;Begin
 {$IFDEF Windows}
  GetHeightCharacter:=CharSize.Y
 {$ENDIF}
End;

 {Hauteur de la police de caractŠre actuel}
Function GetHeightChr;Begin
 {$IFDEF Windows}
  GetHeightChr:=CharSize.Y
 {$ENDIF}
End;

 {Demande l'image vid‚o de la ligne sp‚cifi‚}
Procedure GetLnHorImg;Begin
End;

 {Demande le num‚ro maximum de couleur}
Function GetMaxColors;Begin
End;

 {BORLAND:Demande le num‚ro maximum de couleur}
Function GetMaxColor;Begin
End;

 {Demande le num‚ro maximum de couleur}
Function GetMaxKr;Begin
End;

 {Demande le nombre maximum de palette}
Function GetMaxPal;Begin
End;

 {BORLAND: Retourne la coordonn‚e X maximal}
Function GetMaxX;Begin
End;

 {BORLAND: Retourne la coordonn‚e X maximal}
Function GetMaxXPixels;Begin
End;

 {Demande la coordonn‚e texte X maximal }
Function GetMaxXTxts;Begin
 GetMaxXTxts:=NmXTxts-1
End;

 {BORLAND: Retourne la coordonn‚e Y maximal}
Function GetMaxY;Begin
End;

 {BORLAND: Retourne la coordonn‚e Y maximal}
Function GetMaxYPixels;Begin
End;

 {Demande la coordonn‚e texte Y maximal }
Function GetMaxYTxts;Begin
 GetMaxYTxts:=NmYTxts-1
End;

 {Charge tous les informations de mode con‡ernant la carte vid‚o actuel}
Procedure GetMIV;Begin
End;

 {Charge tous les informations de mode con‡ernant la carte vid‚o actuel}
Procedure GetModeInfoVideo;Begin
End;

 {Nombre de couleurs affich‚}
Function  GetNmColors;Begin
End;

 {Nombre de couleurs affich‚}
Function GetNmKr;Begin
End;

 {Nombre de page vid‚o que supporte le mode actuel}
Function GetNmVideoPages;Begin
End;

 {Nombre de pixels horizontal qu'affiche l'‚cran}
Function GetNmXPixels;Begin
End;

 {Nombre de caractŠre texte horizontal qu'affiche l'‚cran}
Function GetNmXTxts;Begin
End;

 {Nombre de pixels vertical qu'affiche l'‚cran}
Function GetNmYPixels;Begin
End;

 {Nombre de caractŠre texte vertical qu'affiche l'‚cran}
Function GetNmYTxts;Begin
End;

 {Nombre de couleurs affich‚}
Function GetNumColors;Begin
End;

 {Nombre de pixels horizontal qu'affiche l'‚cran}
Function GetNumXPixels;Begin
End;

 {Nombre de pixels vertical qu'affiche l'‚cran}
Function GetNumYPixels;Begin
End;

 {Charge tous les informations physique con‡ernant la carte vid‚o actuel}
Procedure GetPhysInfoVideo;Begin
End;

 {Charge tous les informations physique con‡ernant la carte vid‚o actuel}
Procedure GetPhysicalInfoVideo;Begin
End;

 {Charge tous les informations physique con‡ernant la carte vid‚o actuel}
Procedure GetPIV;Begin
End;

 {Charge tous les informations physique con‡ernant la carte vid‚o secondaire}
Procedure GetPIVSec;Begin
End;

 {BORLAND: Demande la couleur du Pixel se trouvant … (X,Y)}
Function GetPixel;Begin
End;

{$IFNDEF Win32}
Function GetRawY;Begin
End;
{$ENDIF}

Function  GetRealRawY;Begin
End;

Function GetRealRawYWord;Begin
End;

 {Demande le num‚ro de banque de la page courant}
Function GetSelPg;Begin
End;

 {Demande la taille que demande l'image sp‚cifi‚}
Function GetSizeSmlImg;Begin
End;

 {Sauvegarde dans un tampon l'image d‚finit dans (X1,Y1)-(X2,Y2)}
Procedure GetSmlImg;Begin
End;

 {Nombre de bits utilis‚ pour modifi‚ un des 3 DAC RGB}
Function GetVideoBitsDAC;Begin
End;

 {Nombre d'accŠs bits au entr‚e/sortie vid‚o}
Function GetVideoBitsIO;Begin
End;

 {Nombre d'accŠs bits … la ROM Bios}
Function GetVideoBitsROM;Begin
End;

 {Demande le num‚ro de banque de la page courant}
Function GetVideoBnkPg;Begin
End;

 {Demande le nom de la carte vid‚o (vn????)}
Function GetVideoCard;Begin
End;

 {Demande la cat‚gorie de la carte vid‚o(MDA,CGA,...)(cvn????)}
Function GetVideoCardCat;Begin
End;

 {Num‚ro de la page vid‚o de travail}
Function GetVideoPg;Begin
End;

 {Nombre de m‚moire (en octet) dont dispose la carte vid‚o}
Function GetVideoMem;Begin
End;

 {Nombre de m‚moire (en octet) dont dispose la carte vid‚o}
Function  GetVideoMemory;Begin
End;

 {Demande le mode vid‚o actuel (vm???)}
Function GetVideoMode;Begin
End;

 {Demande le nom du moniteur (mn????)}
Function GetVideoMonitor;Begin
End;

 {Demande la taille de l'‚cran}
Function GetVideoScrSize;Begin
End;

 {Segment vid‚o (A000h,B000h,B800h,...)}
Function GetVideoSeg;Begin
End;

 {Graphique: Segment du tampon de l'acc‚lateur}
Function GetVideoSegBuf;Begin
 {$IFDEF Windows}
  GetVideoSegBuf:=PtrRec(ScrBuf).Seg
 {$ENDIF}
End;

 {Demande l'adresse de la ROM Bios}
Function GetVideoSegROM;Begin
End;

 {Num‚ro de la page vid‚o actuellement affich‚?}
Function GetVideoShowPg;Begin
End;

 {Taille d'un page de la banque (0=64Ko)}
Function GetVideoSizeBnkPg;Begin
End;

 {En texte, adresse en m‚moire vid‚o de la page actuel}
Function GetVideoTxtAddrPg;Begin
End;

 {Pointeur sur la police de caractŠre courante}
Function GetVideoTxtMtxPtr;Begin
End;

 {Nombre de m‚moire (en octet) dont dispose la carte vid‚o}
Function GetVidMem;Begin
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Procedure GotoXY                            Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Destination/Plate-Forme: DPMI 0.92 ou post‚rieur


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de fixer la position du curseur et de pointeur
 texte … une position pr‚cis dans une fenˆtre sous Windows ou par
 rapport … l'‚cran en mode prot‚g‚.
}

Procedure GotoXY;Begin
 {$IFDEF Windows}
  Cursor.X:=Max(0,Min(X,ScreenSize.X-1));
  Cursor.Y:=Max(0,Min(Y,ScreenSize.Y-1))
 {$ENDIF}
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Fonction HeightChr                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Destination/Plate-Forme: DPMI 0.92 ou post‚rieur


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de connaŒtre la hauteur de la police de caractŠre
 actuel en usage.
}

Function HeightChr;Begin
 {$IFDEF Windows}
  HeightChr:=CharSize.Y
 {$ENDIF}
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Procedure Init                              Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Destination/Plate-Forme: DPMI 0.92 ou post‚rieur


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'initialiser le pilote charg‚ en m‚moire en mode
 prot‚g‚ et d'initialiser une fenˆtre en mode Windows.
}

Procedure Init;Begin
 InitWinCrt;
End;

{$IFNDEF __Windows__}
 Procedure InitSound;Begin
 End;
{$ENDIF}

 {Clignotement?}
Function IsBlink;Begin
End;

 {Mode couleur? Sinon monochrome for‡‚ment...}
Function IsColor;Begin
End;

{$IFNDEF __Windows__}
 Function IsDblMtx;Begin
 End;
{$ENDIF}

 {La carte est post‚rieur ou ‚gale … l'EGA?}
Function IsEGA;Begin
End;

 {Mode graphique? Sinon texte}
Function IsGraf;Begin
End;

 {Mode graphique? Sinon texte}
Function IsGraphics;Begin
 {$IFDEF __Windows__}
  IsGraphics:=True;
 {$ENDIF}
End;

 {Mode graphique? Sinon texte}
Function IsGraphix;Begin
 {$IFDEF __Windows__}
  IsGraphix:=True;
 {$ENDIF}
End;

 {Mode graphique? Sinon texte}
Function IsGrf;Begin
 {$IFDEF __Windows__}
  IsGrf:=True;
 {$ENDIF}
End;

 {Mode couleur? Sinon for‡‚ment monochrome...}
Function IsKr;Begin
End;

{$IFNDEF Win32}
 Function IsLuxe;Begin
 End;
{$ENDIF}

 {Mode monochrome? Sinon for‡‚ment couleur...}
Function IsMono;Begin
End;

 {Mode monochrome? Sinon for‡‚ment couleur...}
Function IsMonochrome;Begin
End;

 {Le standard VESA support‚?}
Function IsVESA;Begin
End;

 {La carte est post‚rieur ou ‚gale … la VGA?}
Function IsVGA;Begin
End;

 {Clignotement?}
Function IsVideoBlink;Begin
End;

 {M‚thode directe? Sinon Bios ou Dos}
Function IsVideoDirectAccess;Begin
End;

 {Mode support‚ par le Bios (Par exemple, la GS en 16 couleurs le Bios ne le connaŒt pas)}
Function IsVideoModeBios;Begin
End;

 {Mode dans la logique IBM (pas hors cas texte … la SVGA...)}
Function  IsVideoModeIBMLogic;Begin
End;

 {Neige lors de l'envoie de donn‚e dans le tampon vid‚o?}
Function IsVideoSnow;Begin
End;

 {Carte de type couleur? autrement monochrome}
Function KrFound;Begin
End;

{$IFNDEF Win32}
 Procedure LeftIcon;Begin
 End;
{$ENDIF}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Procedure Locate                            Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Destination/Plate-Forme: DPMI 0.92 ou post‚rieur


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette routine tir‚e du langage BASIC permet de fixer la position du
 curseur.
}

Procedure Locate;Begin
 GotoXY(X,Y);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Fonction MaxXTxts                           Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Destination/Plate-Forme: DPMI 0.92 ou post‚rieur


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction demande la coordonn‚e texte X maximal.
}

Function  MaxXTxts;Begin
 MaxXTxts:=NmXTxts-1
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Fonction MaxYTxts                           Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Destination/Plate-Forme: DPMI 0.92 ou post‚rieur


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction demande la coordonn‚e texte Y maximal.
}

Function  MaxYTxts;Begin
 MaxYTxts:=NmYTxts-1
End;

Procedure MoveText;Begin
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Fonction NmXPixels                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Destination/Plate-Forme: DPMI 0.92 ou post‚rieur


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de connaŒtre le nombre de pixels horizontal
 qu'affiche l'‚cran ou la fenˆtre.
}

Function NmXPixels;Begin
 {$IFDEF Windows}
  NmXPixels:=WindowSize.X*CharSize.X
 {$ENDIF}
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Fonction NmXTxts                            Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Destination/Plate-Forme: DPMI 0.92 ou post‚rieur


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de connaŒtre le nombre de caractŠre texte horizontal
 qu'affiche l'‚cran.
}

Function NmXTxts;Begin
 {$IFDEF Windows}
  NmXTxts:=WindowSize.X
 {$ENDIF}
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                             Fonction NmYPixels                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Destination/Plate-Forme: DPMI 0.92 ou post‚rieur


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de connaŒtre le nombre de pixels vertical qu'affiche
 l'‚cran.
}

Function NmYPixels;Begin
 {$IFDEF Windows}
  NmYPixels:=WindowSize.X*CharSize.X
 {$ENDIF}
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                             Fonction NmYTxts                            Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Destination/Plate-Forme: DPMI 0.92 ou post‚rieur


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de connaŒtre le nombre de caractŠre texte vertical
 qu'affiche l'‚cran
}

Function NmYTxts;Begin
 {$IFDEF Windows}
  NmYTxts:=WindowSize.Y
 {$ENDIF}
End;

 {Copie une page dans une autres}
Procedure PageCopy;Begin
End;

 {BASIC: Copie une page dans une autres}
Procedure PCopy;Begin
End;

 {Copie une page dans une image d'‚cran}
Procedure PCopy2Img;Begin
End;

 {BASIC APPLE ][: Affiche un Pixel}
Procedure Plot;Begin
End;

 {BASIC: Affiche un Pixel}
Procedure Point;Begin
End;

 {Demande la cat‚gorie de la carte vid‚o(MDA,CGA,...)(cvn????)}
Function PrimCardCat;Begin
End;

 {BASIC: Affiche un Pixel}
Procedure PSet;Begin
End;

Procedure PutCharGAttr;Begin
End;

{$IFNDEF Win32}
 Procedure PutCloseIcon;Begin
 End;

 Procedure PutDownIcon;Begin
 End;
{$ENDIF}

 {Affiche une boŒte de couleur sp‚cifi‚ de (X1,Y1)-(X2,Y2)}
Procedure PutFillBox;Begin
End;

Procedure PutFillCircle;Begin
End;

Procedure PutFillRoundRect;Begin
End;

 {Affiche une ligne}
Procedure PutLine;Begin
End;

 {Affiche une ligne horizontal}
Procedure PutLineHori;Begin
End;

 {Affiche une ligne}
Procedure PutLn;Begin
End;

 {Affiche une ligne horizontal}
Procedure PutLnHor;Begin
End;

Procedure PutRect;Begin
End;

Procedure PutRoundRect;Begin
End;

 {Affiche … l'‚cran l'image contenu dans un tampon}
Procedure PutSmlImg;Begin
End;

Procedure PutSprite;Begin
End;

 {Affiche un message … (X,Y)}
Procedure PutTxtXY;Begin
 {$IFDEF Windows}
  GotoXY(X,Y);
  SetBkColor(DC,  WinProcs.RGB(DefRGB[Attr shr 4].R,DefRGB[Attr shr 4].G,DefRGB[Attr shr 4].B));
  SetTextColor(DC,WinProcs.RGB(DefRGB[Attr and$F].R,DefRGB[Attr and$F].G,DefRGB[Attr and$F].B));
  Write(Str);
 {$ENDIF}
End;

 {Affiche un message … (X,Y)}
Procedure PutTextXY;Begin
 PutTextXY(X,Y,Str,Attr)
End;

 {Affiche un message … (X,Y) sans affecter les couleurs}
Procedure PutTxtXYUnCol;Begin
End;

 {Affiche un message … (X,Y) sans affecter les couleurs}
Procedure PutTxtXYUnKr;Begin
End;

 {Lit des donn‚es dans la banque vid‚o Super VGA}
Procedure ReadBnk;Begin
End;

{$IFNDEF Win32}
 Procedure RightIcon;Begin
 End;
{$ENDIF}

 {Fixe le plane de la banque vid‚o Super VGA}
Procedure SelBnkPg;Begin
End;

{$IFNDEF Win32}
 Procedure SelIcon;Begin
 End;
{$ENDIF}

 {Fixe un attribut … (X,Y)}
Procedure SetAttr;Begin
End;

Procedure SetBackgroundColor;Begin
End;

 {Fixe l'affichage … Clignotement ou Intensit‚}
Procedure SetBlink;Begin
End;

 {Fixe le plane de la banque vid‚o Super VGA}
Procedure SetBnkPg;Begin
End;

Procedure SetBorderColor;Begin
End;

Procedure SetBytesPerLn;Begin
End;

 {Fixe un caractŠre … (X,Y)}
Procedure SetChar;Begin
End;

 {Fixe un caractŠre … (X,Y)}
Procedure SetCharacter;Begin
End;

 {Fixe un caractŠre … (X,Y)}
Procedure SetChr;Begin
End;

 {Fixe la largeur des caractŠres 8/9 pixels}
Procedure SetChrWidth;Begin
End;

 {Fixe un caractŠre et son attribut … (X,Y)}
Procedure SetCube;Begin
End;

 {Fixe le format du curseur}
Procedure SetCur;Begin
End;

 {Fixe la position du curseur}
Procedure SetCurPos;Begin
End;

 {Fixe le format du curseur}
Procedure SetCursor;Begin
End;

 {Fixe la position du curseur}
Procedure SetCursorPos;Begin
End;

 {Fixe la position du curseur}
Procedure SetCursorPosition;Begin
End;

Procedure SetDblMtx;Begin
End;

Procedure SetExtChr;Begin
End;

Procedure SetExtCube;Begin
End;

 {Fixe la hauteur des caractŠres}
Procedure SetHeightChr;Begin
End;

Procedure SetHorizontalScale;Begin
End;

 {Affiche un caractŠre et son attribut … la position (X,Y) en pixel}
Procedure SetGCube;Begin
End;

 {Affiche un caractŠre et son attribut … la position (X,Y) en pixel sans changer le fond}
Procedure SetGCubeT;Begin
End;

{$IFNDEF Win32}
 Procedure SetLuxe;Begin
 End;
{$ENDIF}

 {Fixe la page de travail}
Procedure SetPage;Begin
End;

Procedure SetPaletteRGB;Begin
End;

 {Charge une police en m‚moire vid‚o}
Procedure SetMatrix;Begin
End;

 {Fixe le contr“leur vid‚o … la m‚moire des polices}
Procedure SetModeMatrix;Begin
End;

 {Fixe le contr“leur vid‚o … la m‚moire des polices}
Procedure SetModeMtx;Begin
End;

 {Fixe le contr“leur vid‚o … la m‚moire ‚cran}
Procedure SetModeScr;Begin
End;

 {Fixe le contr“leur vid‚o … la m‚moire ‚cran}
Procedure SetModeScreen;Begin
End;

 {Fixe le seulement le code du mode vid‚o actuel}
Procedure SetModeValue;Begin
End;

{$IFNDEF Win32}
 Procedure SetNumYTexts;Begin
 End;
{$ENDIF}

 {Fixe un nombre d‚terminer de palette en couleur noir.}
Procedure SetPalBlk;Begin
End;

{Cette proc‚dure fixe une palette de style Rouge-Vert-Bleu. Peu importe
 la carte install‚, si elle supporte des palettes de couleurs, il fait
 avec!}
Procedure SetPalRGB;Begin
End;

 {Fixe la page de travail}
Procedure SetPg;Begin
End;

 {Fixe un pixel … l'‚cran}
Procedure SetPixel;Begin
End;

 {Fixe tous les informations physique con‡ernant la carte vid‚o actuel}
Procedure SetPhysInfoVideo;Begin
End;

 {Fixe tous les informations physique con‡ernant la carte vid‚o actuel}
Procedure SetPhysicalInfoVideo;Begin
End;

 {Fixe tous les informations physique con‡ernant la carte vid‚o actuel}
Procedure SetPIV;Begin
End;

 {Fixe l'adresse de la nouvelle police texte}
Procedure SetTxtMtx;Begin
End;

Procedure SetUnderline;Begin
End;

Procedure SetVerticalScale;Begin
End;

Procedure SetVideoSeg;Begin
End;

 {Fixe le num‚ro de la page actuellement affich‚}
Procedure SetVisualPage;Begin
End;

 {Fixe le num‚ro de la page actuellement affich‚}
Procedure SetVisualPg;Begin
End;

Procedure SetWriteMode;Begin
End;

Procedure SplitScreen;Begin
End;

 {BASIC ‚tendue du Coco 3: Retourne les informations: CaractŠre, Attribut}
Function Stat;Begin
End;

{$IFNDEF Win32}
 Procedure UnselIcon;Begin
 End;

 Procedure UpIcon;Begin
 End;
{$ENDIF}

 {Le mode VGA 320x400 est support‚ (pas toujours le cas chez les clones)?}
Function VGA320x400Found;Begin
End;

 {Police programme support‚ par cette carte?}
Function VideoFontFound;Begin
End;

 {Mode Hercule support‚ par cette carte?}
Function VideoHerculeFound;Begin
End;

 {Port souris inclue … la carte vid‚o?}
Function  VideoMousePortFound;Begin
End;

 {Palette de couleur programme support‚?}
Function VideoPaletteFound;Begin
End;

 {crit des donn‚es dans la banque vid‚o Super VGA}
Procedure WriteBnk;Begin
End;

 {Turbo Pascal 3: Affiche un message … (X,Y)}
Procedure WriteXY;Begin
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Procedure WriteXYUnKr                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Destination/Plate-Forme: DPMI 0.92 ou post‚rieur


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure affiche un message sans affecter les couleurs pr‚sente
 du pilote vid‚o.
}

Procedure WriteXYUnKr;Begin
End;

{$IFNDEF Win32}
 Procedure ZoomIcon;Begin
 End;
{$ENDIF}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Procedure Done                              Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Destination/Plate-Forme: DPMI 0.92 ou post‚rieur


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure d‚branche tous les services entraŒner par le pilote en
 mode prot‚g‚ et ‚limine la fenˆtre sous Windows.

}

Procedure Done;Begin
 DoneWinCrt;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Fonction _GetActivePage                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Destination/Plate-Forme: DPMI 0.92 ou post‚rieur


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction demande au pilote vid‚o la page de travail.


 Remarques
 ÍÍÍÍÍÍÍÍÍ

  ş Cette fonction existe seulement … titre de compatibilit‚ avec l'unit‚
    ®MSGraph¯ du QuickPascal.

}

Function  _GetActivePage;Begin
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Fonction _GetPixel                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Destination/Plate-Forme: DPMI 0.92 ou post‚rieur


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction demande le num‚ro de la  couleur du Pixel  affich‚ … tel
 endroit au pilote vid‚o.


 Remarques
 ÍÍÍÍÍÍÍÍÍ

  ş Cette fonction existe seulement … titre de compatibilit‚ avec l'unit‚
    ®MSGraph¯ du QuickPascal.
}

Function _GetPixel;Begin
{  _GetPixel:=Canvas.Pixels[X,Y];}
End;

{$IFNDEF Win32}
 Function _ImageSize;Begin
 End;
{$ENDIF}

 {QuickPascal: Fixe la page de travail}
Procedure _SetActivePage;Begin
End;

Function viSetVideoModePrim;Begin
End;

Function viSetVideoSizePrim;Begin
End;

Function viInitVideo;Begin
End;
{$ENDIF}

{$IFDEF Windows}
BEGIN
 If HPrevInst=0Then Begin
  CrtClass.hInstance:=HInstance;
  CrtClass.hIcon:=LoadIcon(0,idi_Application);
  CrtClass.hCursor:=LoadCursor(0,idc_Arrow);
  CrtClass.hbrBackground:=GetStockObject(White_Brush);
  RegisterClass(CrtClass)
 End;
 AssignCrt(Input);
 Reset(Input);
 AssignCrt(Output);
 Rewrite(Output);
 GetModuleFileName(HInstance,WindowTitle,SizeOf(WindowTitle));
 SaveExit:=ExitProc;
 ExitProc:=@ExitWinCrt;
{$ENDIF}
END.