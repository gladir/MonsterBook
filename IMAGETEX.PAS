Unit ImageTex;

INTERFACE

Uses Systex;

Const
  { Code de marqueur IMI (Intelligent Image) }
 imiEnd=0;            { Fin de l'image }
 imiTrueColor16=1;    { Couleur v�ritable en 16-bits }
 imiTrueColor24=2;    { Couleur v�ritable en 24-bits }
 imiTrueColor32=3;    { Couleur v�ritable en 32-bits }
 imiRealPoint=4;      { Point en format r�el }
 imiRealLine=5;       { Ligne en format r�el }
 imiRealBox=6;        { Rectangle }
 imiDFDProcessus=100; { DFD - Processus }
 imiDFDDepot=101;     { DFD - D�p�t }
 imiDFDEntite=102;    { DFD - Entit� externe }
 imiDFDFlux=120;      { DFD - Flux de donn�es diagonale }

  { Code de marqueur JPEG }
 mcjTEM=$01;
 mcjSOF0=$C0;
 mcjSOF1=$C1;
 mcjSOF2=$C2;
 mcjSOF3=$C3;
 mcjDHT=$C4;
 mcjSOF5=$C5;
 mcjSOF6=$C6;
 mcjSOF7=$C7;
 mcjJPG=$C8;
 mcjSOF9=$C9;
 mcjSOF10=$CA;
 mcjSOF11=$CB;
 mcjDAC=$CC;
 mcjSOF13=$CD;
 mcjSOF14=$CE;
 mcjSOF15=$CF;
 mcjRST0=$D0;
 mcjRST1=$D1;
 mcjRST2=$D2;
 mcjRST3=$D3;
 mcjRST4=$D4;
 mcjRST5=$D5;
 mcjRST6=$D6;
 mcjRST7=$D7;
 mcjSOI=$D8;
 mcjEOI=$D9;
 mcjSOS=$DA;
 mcjDQT=$DB;
 mcjDNL=$DC;
 mcjDRI=$DD;
 mcjDHP=$DE;
 mcjEXP=$DF;
 mcjAPP0=$E0;
 mcjAPP15=$EF;
 mcjJPG0=$F0;
 mcjJPG13=$FD;
 mcjCOM=$FE;
 mcjERROR=$100;

  {Constante d'Ic�ne Windows}
 ihwIcon=1;        { Ic�ne }
 ihwCursor=2;      { Curseur }

  {Type de compression Windows}
 bi_RGB=0;
 bi_RLE8=1;
 bi_RLE4=2;

Type
  {Ent�te d'un format d'image BGX }
 BGXHeader=Record
  Sign:Array[0..3]of Char;   { Signature }
  NumXPixels,NumYPixels:Word;{ Nombre de pixels horizontal et vertical }
  BitsPerPixel:Byte;         { Nombre de bits par pixel }
 End;

  {Ent�te d'un format d'image Gem/Img Ventura}
 HeaderGemImgRec=Record
  Sign:Array[0..1]of Char;  { Signature: #$00#$01 }
  StartOff:Word;            { Point de d�part (format Motorola) }
  BitsPerPixel:Word;        { Bits par pixel (format Motorola) }
  PatternSize:Word;         { Taille de la palette }
  ResA:Array[8..11]of Byte; { R�serv�s }
  NumXPixels:Word;          { Largeur de l'image (format Motorola) }
  NumYPixels:Word;          { Hauteur de l'image (format Motorola) }
  ResB:Array[16..18]of Byte;{ R�serv�s }
 End;

  {Ent�te d'un format d'image MacPaint }
 HeaderOldMacPaint=Record
  ZeroByte:Byte;               { Octet toujours � 0 }
  Name:String[63];             { V�ritable nom du dessin }
  TypeFile:Array[1..4]of Char; { PNTG }
  Creator:Array[1..4]of Char;  { Nom du cr�ateur du dessin }
  Filler:Array[0..9]of Byte;   { Non utilis� }
  DataForkSize:LongInt;
  RsrcForkSize:LongInt;
  CreationDate:LongInt;
  ModifData:LongInt;
  Filler2:Array[0..28]of Byte;
 End;

  {Ent�te d'un format d'image LBM }
 LBMHeader=Record
  Msg1:Array[1..4]of Char; { Signature: "FORM" }
  FLen:LongInt;            { Longueur du fichier - 8 }
  Msg2:Array[1..8]of Char; { Signature: "ILBMBMHD" ou "PBM BMHD" }
  HLen:LongInt;            { Longueur de l'ent�te }
  Width,Length,            { Largeur et longueur }
  XOff,YOff:Word;          { Position (X1,Y1) }
  BitsPerPixel,            { Nombre de bits par pixel }
  Masking,                 { Masque }
  Compression,             { Compression }
  Pad:Byte;                { Pad }
  Transparent:Integer;     { Transparence }
  XAspect,YAspect:Byte;    { Ratio X:Y }
  ScreenWidth,             { Largeur de l'image }
  ScreenHeight:Word;       { Hauteur de l'image }
 End;

  {Ent�te de fichier de format Targa}
 TGAHeader=Record
  IDFieldLength:Byte;        { Taille de l'en-t�te en octets }
  ColorMapType:Byte;         { Version du format TGA : }
                             { 1 -> Celle reconnue par cette unit� }
  ImageType:Byte;            { Format de codage des donn�es : }
                             {  1 -> Donn�es directes en 8bpp }
                             {  2 -> Donn�es directes en 24bpp (RVB) }
                             {  9 -> Codage des r�p�titions (RLE) en 8 bpp }
                             {       (non support� par cette unit�) }
                             { 10 -> Codage des r�p�titions (RLE) en 24 bpp}
                             {       (non support� par cette unit�) }
  CMapOrigin:Word;           { Position dans le fichier de la palette }
  CMapLength:Word;           { Nombre de couleurs }
  ColorMapEntrySize:Byte;
  Xmin,Ymin,                 { Position d'orgine dans l'image (rarement }
                             { utilis�, et non support� par cette unit�) }
  NumXPixels,NumYPixels:Word;{ Dimensions de l'image }
  BitsPerPixel,              { Nombre de bits par pixel }
  Option:Byte;               { Option de l'image : }
                             { 0  -> Image renvers�e verticalement }
                             { 32 -> Image dans le sens normal }
 End;

  {Ent�te de fichier de format BitMap Windows}
 HeaderBMP=Record
  Sign:Array[0..1]of Char;
  Size,Reserved0,OffBits:LongInt;
  biSize,NumXPixels,NumYPixels:LongInt;
  Planes,BitCount:Word;
  Compression,SizeImage:LongInt;
  XPelsPerMeter,YPelsPerMeter,ClrUsed,ClrImportant:LongInt;
 End;

  {Format d'image SCi - RIX3 }
 SCiHeader=Record
  Sign:Array[0..3]of Char; { Signature: RIX3 }
  NumXPixels:Word;         { Nombre de pixels horizontalement }
  NumYPixels:Word;         { Nombre de pixels verticalement }
  Reserved:Word;           { R�serv�e }
 End;

  {Ent�te de fichier de format GIF}
 HeaderGIF=Record
  Sign,Ver:Array[0..2]of Char; { Signature et version (GIF87a ou GIF89a)}
  NumXPixels,NumYPixels:Word;  { Largeur et hauteur de l'image en pixels }
  ExtInfo,                     { Information de palettes }
  Background,                  { Arri�re plan }
  AspectRatio:Byte;            { Ratio }
 End;

  {Ent�te d'image du fichier de format GIF}
 HeaderImageGIF=Record
  Seperator:Byte;             { S�parateur ',' }
  X1,Y1:Word;                 { Position X,Y ou commence l'image }
  NumXPixels,NumYPixels:Word; { Largeur et hauteur de l'image }
  ExtInfo:Byte;               { Information de palettes }
 End;

{$I Library\Files\Images\JFIFHead.Inc}
{$I Library\Files\Images\PCXHeade.Inc}
{$I Library\Files\Images\TiffData.Inc}

Type
   {Structure d'une image IMI (Intelligent Image) }
 ImiHeader=Record
  Sign:Array[0..2]of Char;       { Signature = "IMI" }
  NumXPixels:Word;               { Nombre de pixels horizontal }
  NumYPixels:Word;               { Nombre de pixels vertical }
  BitsPerPixel:Byte;             { Nombre de bits par pixel }
  ScaleX:Real;                   { �chelle horizontal }
  ScaleY:Real;                   { �chelle vertical }
  System:Byte;                   { Syst�me: 0=M�trique, 1=Imp�rial }
  Langue:Byte;                   { Langue: 0=Fran�ais, 1=Anglais, 2=Russes}
  CountryCode:Word;              { Code de pays/r�gion du Malte Genesis }
  BackgroundColor:RGB;           { Couleur d'arri�re plan }
  Mode:Byte;                     { Mode d'object (drw????) }
  NameProject:String[40];        { Nom du projet }
  NameModele:String[40];         { Nom du mod�le }
  Alias:String[30];              { Alias }
  Author:String[30];             { Auteur du dessin }
  Responsable:String[30];        { Nom du responsable }
  NameOrganisme:String[50];      { Nom de la compagnie }
  Description:String;            { Description du dessin }
  Version:String[10];            { Num�ro de version du dessin }
  Email:String[60];              { Courriel de l'auteur }
  Password:String[19];           { Mot de passe }
  Logo:String;                   { Chemin du Logo }
  ScaleZ:Real;                   { �chelle Z (3 dimensions seulement ) }
  Origin:Byte;                   { Mode de dessin (DFD, Electronique,...)}
  Reserved:Array[7..511]of Byte; { R�serv� pour des ajouts potentiel }
  DateCreated:LongInt;           { Date de cr�ation }
  DateModified:LongInt;          { Date de modification }
  NumModified:LongInt;           { Nombre de modification }
  CurrObject:LongInt;            { Object courant }
  NumObject:LongInt;             { Nombre d'objet }
 End;

  {Structure d'une image 3D Studio}
 Chunk3DStudio=Record
  ID:Word;
  Next:LongInt;
 End;

 {�� D�finition des structures par d�faut des ic�nes ��}
{$I Library\System\Windows\Icon.Inc}
{$I Library\System\OS2\Icon.Inc}

Function RGB2Win32bits(R:Byte;G:Byte;B:Byte):LongInt;
{$IFNDEF Win32}
 {$IFNDEF __TMT__}
   InLine($5A/       { POP DX    }
          $5B/       { POP BX    }
          $58/       { POP AX    }
          $8A/$E3/   { MOV AH,BL }
          $32/$F6);  { XOR DH,DH }
 {$ENDIF}
{$ENDIF}

IMPLEMENTATION

{$IFDEF Win32}
 Function RGB2Win32bits(R:Byte;G:Byte;B:Byte):LongInt;Begin
 End;
{$ENDIF}

{$IFDEF __TMT__}
 Function RGB2Win32bits(R:Byte;G:Byte;B:Byte):LongInt;Begin
 End;
{$ENDIF}

END.