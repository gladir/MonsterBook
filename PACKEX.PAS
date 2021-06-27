Unit Packex;

INTERFACE

Uses Systex;

Type
  {Structure de fichier compress‚ ®.ZIP¯ }
 Crc32Rec=Array[Byte]of LongInt;

 ZipSFEntry=Record
  Code:Word;
  Value,BitLen:Byte;
 End;

 ZipSFTree=Record
  Entry:Array[0..256]of ZipSFEntry;
  Entries,MaxLen:Integer;
 End;

 ZipSFTreep=^ZipSFTree;

 ZipResult=Record
  TotalFiles,TotalPackSize,TotalSize,Timer,Error:LongInt;
  TotalCompress:Byte;
 End;

 ZipRecL=Record
  Sign:LongInt;
  VerNeeded2Xtrk,GeneralPurposeBitFlag,CompressMethod:Word;
  LastModFileTime,LastModFileDate:Word;
  CRC32,CompressSize,UncompressSize:LongInt;
  FilenameLen,ExtraFieldLen:Word;
 End;

  {Structure d'un fichier compress‚ ®.ARJ¯ }
 ArjHeader=Record
  HeadId:Word;                 { Signature: 60000 }
  BHdrSz:Word;                 { Taille de la simple entˆte de fichier }
  FHdrSz:Byte;                 { Taille de l'entˆte fichier }
  AVNo:Byte;
  MAVX:Byte;
  HostOS:Byte;
  Flags:Byte;
  SVer:Byte;
  FType:Byte;
  Res1:Byte;
  DosDT:LongInt;
  CSize:LongInt;               { Taille compress‚ }
  OSize:LongInt;               { Taille original }
  SEFP:LongInt;
  FSFPos:Word;
  SEDLgn:Word;
  Res2:Word;
  NameDat:Array[1..120]of Char;{ D‚but du nom,... }
  Res3:Array[1..10]of Char;
 End;

  {Entˆte de fichier compress‚ LZH et des ICE }
 LZHEntryFiles=Record
  HeadSize,HeadChk:Byte;             { Taille de l'entˆte, v‚rification }
  HeadID:Array[1..5]of Char;         { Identificateur de validation }
  PackSize,OrigSize,FileTime:LongInt;{ Taille compress‚, original et heure}
  Attr:Word;                         { Attribut du fichier }
  FileName:String[12];               { Nom du fichier }
 End;

  {Entˆte de fichier compress‚ d'installation de Windows 95/98: ®.CAB¯ }
 CabHeader=Record
  Sign:Array[0..3]of Char;    { Signature: Toujours "MSCF" }
  ResA:LongInt;               { R‚serv‚, souvent 0 }
  FileSize:LongInt;           { Taille du fichier }
  ResB:LongInt;               { R‚serv‚, souvent 0 }
  StartTable:LongInt;         { Position de d‚part de la table des fichiers }
  ResC:LongInt;               { Inconnu?? }
  ResD:Word;                  { Inconnu?? }
  NumPreFiles:Word;           { Nombre de fichiers pr‚requis }
  NumFiles:Word;              { Nombre de fichiers compress‚ dans ce fichier }
  ResE:Word;                  { Inconnu?? }
  ResF:LongInt;               { Inconnu?? }
 End;

  {Entr‚e de fichier d'un fichier compress‚ CAB }
 CabEntryFiles=Record
  OSize:LongInt;                 { Taille original }
  ResB:LongInt;                  { R‚serv‚???}
  Date:LongInt;                  { Date en format compact‚ }
  Time:LongInt;                  { Heure en format compact‚ }
  NameData:Array[0..255]of Char; { D‚but du nom...}
 End;

  {Fichier compress‚ ®RAR¯}
Const
 RARSign=#$52#$61#$72#$21#$1A#$07#$00; { Signature des fichiers ®RAR¯ }

  {Entˆte d'un fichier compress‚ ®RAR¯ }
Type
 RARHeader=Record
  Sign:Array[0..6]of Char;          { Signature }
  HeadCRC:Word;                     { Code de v‚rification CRC }
  HeadType:Byte;                    { ModŠle d'entˆte }
  HeadFlags:Word;                   { Drapeau d'entˆte }
  HeadSize:Word;                    { Taille de l'entˆte }
  Reserved1:Word;                   { R‚serv‚ }
  Reserved2:LongInt;                { R‚serv‚ }
 End;

  {Enregistrement de l'entr‚e d'un nom de fichier d'un fichier compress‚ }
 RAREntryFiles=Record
  PackSize:Longint;        { Taille compress‚ du fichier }
  UnpackSize:Longint;      { Taille original du fichier }
  OS:Byte;                 { Code correspondant … un systŠme d'exploitation }
  CRC:Longint;             { Code de v‚rification CRC }
  DateTime:Longint;        { Date et heure du fichier }
  RarVer:Byte;             { Version }
  Method:Byte;             { M‚thode de compression }
  NameSize:Word;           { Taille du nom }
  Attr:Longint;            { Attribut }
 End;

  {Structure des fichiers ®.PAK¯ de Borland }
Const
 PAKSign='DS'#0'Z';

Type
 PAKHeader=Record
  Sign:Array[0..3]of Char; { Signature: "DS"#0"Z" }
  NumFiles:Word;           { Nombre de fichiers }
  Res:Word;                { Inconnu????}
 End;

 PAKEntryFiles=Record
   {FileName:String[Length(FileName)];}
  Size:LongInt;
  Time:LongInt;
 End;

  {Fichier compress‚ ®SWAG¯ bibliothŠque de fichier Pascal}
 SwagHeader=Record
  HeadSize:Byte;                {Taille de l'entˆte}
  HeadChk:Byte;                 {Sommation de v‚rification de l'entˆte}
  HeadID:Array[1..5]of Char;    {Identificateur de type de compression}
  NewSize:LongInt;              {Taille compress‚e}
  OrigSize:LongInt;             {Taille original}
  Time:LongInt;                 {Heure et date compact‚e}
  Attr:Word;                    {Attributs et drapeaux de fichier}
  BufCRC:LongInt;               {V‚rification CRC-32 du tampon }
  Swag:String[12];              {Nom du fichier SWAG}
  Subject:String[40];           {Sujet, description}
  Contrib:String[35];           {Auteur ou contribution}
  Keys:String[70];              {Cl‚ de recherche, d‚limit‚ par une virgule}
  FileName:String[79];          {Nom du fichier (longueur variable)}
  CRC:Word;                     {CRC 16-bit (immediatemant aprŠs ®FName¯)}
 End;

  {Fichier compress‚ ®ZOO¯ }
 ZooHeader=Record
  Sign:Array[0..19]of Char;     { Signature du fichier ZOO }
  LoTag,HiTag:Word;
  Start:LongInt;                { Position absolue de d‚part de la table des fichiers }
  Minus:LongInt;
  MajorVer:Char;                { Version }
  MinorVer:Char;                { Sous-Version }
 End;

  {Entr‚e de fichier d'un format de fichier ®ZOO¯ }
 ZooEntryFile=record
  LoTag,HiTag:Word;
  _Type:Byte;
  PackingMethod:Byte;           { M‚thode de compression }
  Next:LongInt;                 { Position de la prochaine entr‚e de fichier  }
  Offset:LongInt;
  Time:LongInt;                 { Date et heure en format compact‚ }
  FileCRC:Word;                 { CRC de ce fichier }
  OrigSize:LongInt;             { Taille original }
  SizeNow:Longint;              { Taille compact‚ }
  MajorVer:Byte;                { Version }
  MinorVer:Byte;                { Sous-Version }
  Deleted:Boolean;
  Comment:LongInt;              { Commentaire associ‚e }
  CmtSize:Word;                 { Longueur des commentaires, 0 si aucun }
  Unknown:Byte;
  FileName:Array[0..12]of Char; { Nom du fichier }
 End;

  { Entˆte de fichier compress‚ ®ARC¯ }
 ArcHeader=Record
  HeadId:Byte;               { Identificateur 1Ah }
  DataType:Byte;             { Vaut 0 si plus aucune donn‚e }
  Name:Array[0..12]of char;  { Nom du fichier }
  CompSize:LongInt;          { Taille compress‚ }
  Time:LongInt;              { Date et heure }
  Crc:Word;                  { V‚rification CRC }
  OrigSize:LongInt;          { Taille original }
 End;

IMPLEMENTATION

END.