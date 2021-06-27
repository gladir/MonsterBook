{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                                                                    Û
 ³          Malte Genesis/Module des SystŠmes suppl‚mentaire          Û
 ³                                                                    Û
 ³         dition Chantal pour Mode R‚el/IV - Version 1.1 &          Û
 ³           dition AdŠle pour Mode R‚el/V - Version 1.1             Û
 ³                             1995/02/02                             Û
 ³                                                                    Û
 ³         Tous droits r‚serv‚s par les Chevaliers de Malte (C)       Û
 ³                                                                    Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Nom du programmeur
 ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

  Sylvain Maltais


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette unit‚ fournit les outils suppl‚mentaire … la gestion du systŠme
 d'exploitation … travers les noms ‚tendue, les fichiers compress‚es et
 toutes les op‚rations  de classe extra.  Il n'est pas indispensable au
 systŠme pour fonctionner et peut donc ˆtre mis en recouvrement.
}

Unit SysPlus;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                 INTERFACE
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

{$I DEF.INC}

Uses
 Dostex,Systex;

Const
 MaxBlocks=4; { Nombre maximal de bloc UMB allouable }

  {Format du Presse-Papier Windows}
 cfText=1;           { Texte }
 cfBitmap=2;         { Bitmap OEM }
 cfOemText=7;        { Texte OEM }
 cfDspText=$81;      { Format texte }
 cfDspBitmap=$82;    { Format dessin }

Type
 TLSearchRec=Record
  Attr:LongInt;                  { Attribut }
  CreationTime,                  { Date de cr‚ation }
  LastAccessTime,                { Dernier temps d'accŠs }
  LastModTime:Comp;              { Dernier modification  }
  HiSize,LoSize:LongInt;         { Taille du fichier }
  Reserved:Comp;                 { R‚serv‚ }
  Name:Array[0..259]of Char;     { Nom long }
  ShortName:Array[0..13]of Char; { Seulement si le nom existe }
  Handle:Word;                   { Handle correspondant }
 End;

 Cyrix6x86Config=Record
  FastFrameBuffer:Boolean;
  WriteBackCache:Boolean;
  WriteAllocate:Boolean;
  CPUID:Boolean;
  SuspendonHALT:Boolean;
  CachedDirectoryTableEntry:Boolean;
  NegateLock:Boolean;
  DataForwarding:Boolean;
  FastLoop:Boolean;
 End;

 EnvSize=0..16383;

Const
 NumBlocks:Byte=0; { Nombre de bloc de m‚moire UMB allou‚e }
 RealHeapPtr:Pointer=NIL;
 RealHeapEnd:Pointer=NIL;

Var
 UMBHeapDebug:Boolean;
 BlockAddress,BlockSize:Array[1..MaxBlocks+1]of Pointer;

Function  BFSelPathExt(Var Q:BF;Path:String;Attr:Word):Boolean;
Function  ClipboardCompact(lDesired:LongInt):LongInt;
Function  ClipboardFunctionsAvailable:Boolean;
Function  CloseClipboard:Boolean;
Function  DskMount(Dsk:Byte):Boolean;
Function  EmptyClipboard:Boolean;
{$IFNDEF NotReal}
 Procedure ExtendHeap;
 Procedure DoneExtendHeap;
 Procedure FreeMaxHeapExtend;
{$ENDIF}
Function  GetBootDisk:Byte;
Function  GetClipboardDataSize(wFormat:Word):LongInt;
Function  GetClipboardData(wFormat:Word;DataPtr:Pointer):Boolean;
Procedure GetCyrix6x86Config(Var Q:Cyrix6x86Config);
Function  LFindFirst(FileSpec:PChar;Attr:Word;Var SRec:TLSearchRec):Word;
Function  LFindNext(Var SRec:TLSearchRec):Word;
Function  LFindClose(Var SRec:TLSearchRec):Word;
{$IFNDEF __Windows__}
 Function LTrueName(FileName:PChar;Result:PChar):Word;
 Function LGetShortName(FileName:PChar;Result:PChar):Word;
{$ENDIF}
Function  LGetLongName(FileName:PChar;_Result:PChar):Word;
Function  LFileSystemInfo(RootName:PChar;FSName:PChar;FSNameBufSize:Word;
                          Var Flags,MaxFileNameLen,MaxPathLen:Word):Word;
Function  LErase(Filename:PChar):Word;
Function  LMkDir(Directory:PChar):Word;
Function  LRmDir(Directory:PChar):Word;
Function  LChDir(Directory:PChar):Word;
{$IFNDEF __Windows__}
 Function LGetDir(Drive:Byte;Result:PChar):Word;
{$ENDIF}
Function  LGetAttr(Filename:PChar;Var Attr:Word):Word;
Function  LSetAttr(Filename:PChar;Attr:Word):Word;
Function  LRename(OldFilename,NewFilename:PChar):Word;
Function  LTime2Dos(Var LTime:Comp):LongInt;
Procedure LoadPathVolume(Var Q:BF;Dsk:Byte;Var NmF:Word;Const Path:String;At:Word);
Function  MountVolume(Const FileName:String;Drv:Char):Boolean;
Function  OpenClipboard:Boolean;
Function  OS2Exec(Const Data:OS2StartData):Word;
Procedure OS2SetTitle(Name:PChar);
Function  ALLoadFileASCII(Var L:ArrayList;Const FileName:String):Boolean;
Function  ALSaveFileASCII(Var L:ArrayList;Const FileName:String;Backup:Boolean):Boolean;
Procedure ALTri(Var L:ArrayList);
Function  SCSIExist:Boolean;
Function  SearchDescription(Const Path:String):String;
Function  SetClipboardData(wFormat:Word;DataPtr:Pointer;lSize:LongInt):Boolean;
Procedure SetCyrix6x86Config(Var Q:Cyrix6x86Config);
Function  SetDescription(Const Name,Descript:String):Boolean;
Procedure SetEnv(EnvVar,Value:String);
{$IFNDEF __Windows__}
 Function SizeOfUMB:LongInt;
{$ENDIF}
Function  TimeString(TimerValue:LongInt;TimerFormat:TimeType):String;
Procedure UnpackLTime(Var LTime:Comp;Var DT:DateTime);
Function  Win95SetTitle(Name:PChar):Boolean;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                               IMPLEMENTATION
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses
 Adele,SysInter,Memories,Systems,Packex,WordTex,Math;

Type
  {Enregistrement de recherche de fichier des fichiers compress‚ ®ARJ¯ }
 ArjFiles=Record
  SL:LongInt;
 End;

  {Enregistrement de recherche de fichier des fichiers compress‚ ®CAB¯ }
 CabFiles=Record
  Header:CabHeader;
  FP:LongInt;
  CurrFiles:LongInt;
 End;

  {Enregistrement de recherche de fichier des fichiers compress‚ ®LZH¯ }
 LZHFiles=Record
  FP,FS:LongInt;
 End;

  {Enregistrement de recherche de fichier des fichiers compress‚ ®RAR¯ }
 RARFiles=Record
  FP,FS:LongInt;
 End;

  {Enregistrement de recherche de fichier des fichiers compress‚ ®PAK¯ }
 PAKFiles=Record
  FP:LongInt;
  NumFiles:Word;
 End;

  {Enregistrement de recherche de fichier des fichiers compress‚ ®SWAG¯ }
 SwagFiles=Record
  FP,FS:LongInt;
 End;

  {Enregistrement de recherche de fichier des fichiers compress‚ ®ZOO¯ }
 ZooFiles=Record
  FP,FS:LongInt;
 End;

  {Enregistrement de recherche de fichier des fichiers compress‚ ®ARC¯ }
 ArcFiles=Record
  FP,FS:LongInt;
 End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Fonction ArjFindNext                    Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Portabilit‚: Local


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de rechercher l'‚l‚ment suivant de la liste
 d'un fichier compress‚ de format ®ARJ¯.
}

Function ArjFindNext(Handle:Hdl;Var Q:ArjFiles;Var X:SearchRec):Boolean;Near;
Var
 FHdr:ArjHeader;
 B:Byte;
 PL:^LongInt;
 {$IFDEF __Windows__}
  C:Char;
 {$ENDIF}
Begin
 ArjFindNext:=False;
 _GetAbsRec(Handle,Q.SL,SizeOf(FHdr),FHdr);
 If FHdr.BHdrSz>0Then Begin
  FillClr(X,SizeOf(X));
  B:=1;
  While FHdr.NameDat[b]<>#0do Begin
   If FHdr.NameDat[B]='/'Then X.Name:=''
    Else
   Begin
    {$IFDEF Win32}
     C:=FHdr.NameDat[B];
     X.Name[Length(X.Name)+1]:=C;
     Inc(X.Name[0]);
    {$ELSE}
     IncStr(X.Name,FHdr.NameDat[B]);
    {$ENDIF}
   End;
   Inc(B);
  End;
  X.Size:=FHdr.BHdrSz+FHdr.CSize;
  If FHdr.FType=2Then X.Size:=FHdr.BHdrSz;
  If FHdr.BHdrSz=0Then X.Size:=0;
  PL:=@X.Fill[14];
  If(FHdr.CSize=FHdr.OSize)Then Begin
   PL^:=Q.SL+34+Length(X.Name)+8;
  End
   Else
  PL^:=0;
  Inc(Q.SL,X.Size+10);
  X.Size:=FHdr.OSize;
  X.Time:=FHdr.DosDT;
  X.Attr.Value:=faArchive;
  ArjFindNext:=True;
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Proc‚dure ArjFindFirst                    Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Portabilit‚: Local


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de rechercher le premier ‚l‚ment de la liste
 d'un fichier compress‚ de format ®ARJ¯.
}

Procedure ArjFindFirst(Handle:Hdl;Var Q:ArjFiles;Var X:SearchRec);Near;Begin
 Q.SL:=0;
 ArjFindNext(Handle,Q,X); { Passer le nom de l'archive compress‚... }
 ArjFindNext(Handle,Q,X);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure CabInit                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Portabilit‚: Local


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de rechercher le premier ‚l‚ment de la liste
 d'un fichier compress‚ de format ®CAB¯ de Microsoft.
}

Procedure CabInit(Const Buffer;Var Q:CabFiles);Near;Begin
 FillClr(Q,SizeOf(Q));
 MoveLeft(Buffer,Q.Header,SizeOf(Q.Header));
 Q.FP:=Q.Header.StartTable;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Proc‚dure CabFindNext                    Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Portabilit‚: Local


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de rechercher l'‚l‚ment suivant de la liste
 d'un fichier compress‚ de format ®CAB¯ de Microsoft.
}

Procedure CabFindNext(Handle:Hdl;Var Q:CabFiles;Var X:SearchRec);Near;
Var EF:CabEntryFiles;Begin
 If(Q.CurrFiles>=Q.Header.NumFiles)Then SysErr:=18
  Else
 Begin
  _GetAbsRec(Handle,Q.FP,SizeOf(EF),EF);
  FillClr(X,SizeOf(X));
  {$IFDEF __Windows__}
   StrPCopy(@X.Name,StrPas(@EF.NameData));
  {$ELSE}
   X.Name:=StrPas(@EF.NameData);
  {$ENDIF}
  X.Size:=EF.OSize;
  X.Time:=EF.Date+EF.Time;
  Inc(Q.FP,16+Length(X.Name)+1);
  Inc(Q.CurrFiles);
  SysErr:=0;
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Fonction LZHInit                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Portabilit‚: Local


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de rechercher le premier ‚l‚ment de la liste
 d'un fichier compress‚ de format ®LZH¯.
}

Function LZHInit(Handle:Hdl;Const Buffer;Var Q:LZHFiles):Boolean;Near;
Var
 H:LZHEntryFiles;
 Sign:Array[0..2]of Char;
Begin
 LZHInit:=False;
 FillClr(Q,SizeOf(Q));
 MoveLeft(Buffer,H,SizeOf(H));
 If(H.PackSize>H.OrigSize)or(H.HeadSize=0)Then Exit;
 H.PackSize:=0;Sign:='lh'#0;
 If(StrPos(@H.HeadID,@Sign)<>NIL)and
   (Length(H.FileName)>0)Then LZHInit:=True;
 Q.FS:=FileSize(Handle);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure LZHFindNext                   Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Portabilit‚: Local


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de rechercher l'‚l‚ment suivant de la liste
 d'un fichier compress‚ de format ®LZH¯.
}

Procedure LZHFindNext(Handle:Hdl;Var Q:LZHFiles;Var X:SearchRec);Near;
Var
 H:LZHEntryFiles;
Begin
 If(Q.FP>=Q.FS)Then SysErr:=18
  Else
 Begin
  FillClr(X,SizeOf(X));
  _GetAbsRec(Handle,Q.FP,SizeOf(H),H);
  If(H.Headsize=0)or(Length(H.FileName)=0)Then SysErr:=18
   Else
  Begin
   If(H.PackSize=H.OrigSize)Then
    LongInt(Pointer(@X.Fill[14])^):=Q.FP+LongInt(H.HeadSize)+LongInt(2);
   Inc(Q.FP,LongInt(H.HeadSize)+LongInt(2)+LongInt(H.PackSize));
   {$IFDEF __Windows__}
    StrPCopy(@X.Name,H.FileName);
   {$ELSE}
    X.Name:=H.FileName;
   {$ENDIF}
   X.Size:=H.OrigSize;
   X.Time:=H.FileTime;
   SysErr:=0;
  End;
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Fonction RARInit                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Portabilit‚: Local


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de rechercher le premier ‚l‚ment de la liste
 d'un fichier compress‚ de format ®RAR¯.
}

Function RARInit(Handle:Hdl;Const Buffer;Var Q:RARFiles):Boolean;Near;
Var
 H:RARHeader Absolute Buffer;
 X:Record
  Sign:Array[0..4]of Byte;
  HeadSize:Word;
 End Absolute Buffer;
Begin
 RARInit:=False;
 FillClr(Q,SizeOf(Q));
 If(H.Sign=RARSign)Then Begin
  RARInit:=True;
  Q.FP:=H.HeadSize+7;
  Q.FS:=FileSize(Handle);
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure RARFindNext                   Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Portabilit‚: Local


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de rechercher l'‚l‚ment suivant de la liste
 d'un fichier compress‚ de format ®RAR¯.
}

Procedure RARFindNext(Handle:Hdl;Var Q:RARFiles;Var X:SearchRec);Near;
Label ReRead;
Var
 Data:Record
  HeadCRC:Word;
  HeadType:Byte;
  HeadFlags:Word;
  HeadSize:Word;
  Info:RAREntryFiles;
  Name:Array[0..255]of Char;
 End;
Begin
ReRead:
 If(Q.FP>=Q.FS)Then SysErr:=18
  Else
 Begin
  FillClr(X,SizeOf(X));
  _GetAbsRec(Handle,Q.FP,SizeOf(Data),Data);
  If Data.HeadType=$74Then Begin
   MoveLeft(Data.Name,X.Name[1],Byte(Data.Info.NameSize));
   X.Name[0]:=Char(Data.Info.NameSize);
   {$IFDEF __Windows__}
    StrPCopy(@X.Name,Path2NoDir(X.Name));
   {$ELSE}
    X.Name:=Path2NoDir(X.Name);
   {$ENDIF}
   X.Time:=Data.Info.DateTime;
   X.Size:=Data.Info.UnpackSize;
   X.Attr.Value:=Data.Info.Attr;
   Inc(Q.FP,LongInt(Data.HeadSize)+LongInt(Data.Info.PackSize));
  End
   Else
  Begin
   Inc(Q.FP,LongInt(Data.HeadSize));
   Goto ReRead;
  End;
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Fonction PAKInit                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Portabilit‚: Local


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de rechercher le premier ‚l‚ment de la liste
 d'un fichier compress‚ de format ®PAK¯.
}

Function PAKInit(Const Buffer;Var Q:PAKFiles):Boolean;
Var
 H:PAKHeader Absolute Buffer;
Begin
 PAKInit:=False;
 FillClr(Q,SizeOf(Q));
 If(H.Sign=PAKSign)Then Begin
  Q.NumFiles:=H.NumFiles;
  Q.FP:=SizeOf(H);
  PAKInit:=True;
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure PAKFindNext                   Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Portabilit‚: Local


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de rechercher l'‚l‚ment suivant de la liste
 d'un fichier compress‚ de format ®PAK¯.
}

Procedure PAKFindNext(Handle:Hdl;Var Q:PAKFiles;Var X:SearchRec);
Var
 Buffer:Array[0..511]of Byte;
 Name:String Absolute Buffer;
Begin
 If Q.NumFiles=0Then SysErr:=18
  Else
 Begin
  FillClr(X,SizeOf(X));
  _GetAbsRec(Handle,Q.FP,SizeOf(Buffer),Buffer);
  {$IFDEF __Windows__}
   StrPCopy(@X.Name,Name);
  {$ELSE}
   X.Name:=Name;
  {$ENDIF}
  X.Time:=PAKEntryFiles(Pointer(@Buffer[Length(Name)+2])^).Time;
  X.Size:=PAKEntryFiles(Pointer(@Buffer[Length(Name)+2])^).Size;
  Dec(Q.NumFiles);
  Inc(Q.FP,LongInt(SizeOf(PAKEntryFiles)+Length(Name)+2));
  SysErr:=0;
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Fonction SwagInit                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Portabilit‚: Local


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de rechercher le premier ‚l‚ment de la liste
 d'un fichier compress‚ de format ®SWAG¯ de programmation.
}

Function SwagInit(Handle:Hdl;Const Buffer;Var Q:SwagFiles):Boolean;Near;
Var
 H:SwagHeader;
 Sign:Array[0..2]of Char;
Begin
 SwagInit:=False;
 FillClr(Q,SizeOf(Q));
 MoveLeft(Buffer,H,SizeOf(H));
 If(H.NewSize>H.OrigSize)or(H.HeadSize=0)Then Exit;
 H.NewSize:=0;Sign:='sw'#0;
 If(StrPos(@H.HeadID,@Sign)<>NIL)and
   (Length(H.FileName)>0)Then SwagInit:=True;
 Q.FS:=FileSize(Handle);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure SwagFindNext                  Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Portabilit‚: Local


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de rechercher l'‚l‚ment suivant de la liste
 d'un fichier compress‚ de format ®SWAG¯ de programmation.
}

Procedure SwagFindNext(Handle:Hdl;Var Q:SwagFiles;Var X:SearchRec);Near;
Var
 H:SwagHeader;
 PC:^Pointer;
Begin
 If(Q.FP>=Q.FS)Then SysErr:=18
  Else
 Begin
  FillClr(X,SizeOf(X));
  _GetAbsRec(Handle,Q.FP,SizeOf(H),H);
  If(H.Headsize=0)or(Length(H.FileName)=0)Then SysErr:=18
   Else
  Begin
   If(H.NewSize=H.OrigSize)Then
    LongInt(Pointer(@X.Fill[14])^):=Q.FP+LongInt(H.HeadSize)+LongInt(2);
   Inc(Q.FP,LongInt(H.HeadSize)+LongInt(2)+LongInt(H.NewSize));
   {$IFDEF __Windows__}
    StrPCopy(@X.Name,H.FileName);
   {$ELSE}
    X.Name:=H.FileName;
   {$ENDIF}
   X.Size:=H.OrigSize;
   X.Time:=H.Time;
   If H.Subject<>''Then Begin
    PC:=@X.Fill[18];
    PC^:=Str2PChr(H.Subject);
   End;
   SysErr:=0;
  End;
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Fonction ZooInit                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Portabilit‚: Local


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de rechercher le premier ‚l‚ment de la liste
 d'un fichier compress‚ de format ®ZOO¯.
}

Function ZooInit(Handle:Hdl;Const Buffer;Var Q:ZooFiles):Boolean;Near;
Var
 H:ZooHeader Absolute Buffer;
 Sign:Array[0..2]of Char Absolute Buffer;
Begin
 ZooInit:=False;
 If Sign='ZOO'Then Begin
  FillClr(Q,SizeOf(Q));
  Q.FS:=FileSize(Handle);
  Q.FP:=H.Start;
  ZooInit:=True;
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure ZooFindNext                   Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Portabilit‚: Local


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de rechercher l'‚l‚ment suivant de la liste
 d'un fichier compress‚ de format ®ZOO¯.
}

Procedure ZooFindNext(Handle:Hdl;Var Q:ZooFiles;Var X:SearchRec);Near;
Var
 H:ZooEntryFile;
Begin
 If(Q.FP>=Q.FS)Then SysErr:=18
  Else
 Begin
  FillClr(X,SizeOf(X));
  _GetAbsRec(Handle,Q.FP,SizeOf(H),H);
  {$IFDEF __Windows__}
   StrPCopy(@X.Name,StrPas(@H.FileName));
  {$ELSE}
   X.Name:=StrPas(@H.FileName);
  {$ENDIF}
  X.Size:=H.OrigSize;
  X.Time:=H.Time;
  Q.FP:=H.Next;
  SysErr:=0;
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Fonction ArcInit                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Portabilit‚: Local


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de rechercher le premier ‚l‚ment de la liste
 d'un fichier compress‚ de format ®ARC¯.
}

Function ArcInit(Handle:Hdl;Const Buffer;Var Q:ArcFiles):Boolean;Near;
Var
 H:ArcHeader Absolute Buffer;
Begin
 ArcInit:=False;
 If(H.HeadID=$1A)and(Not(H.DataType in[0,10,13,32,65..255]))Then Begin
  FillClr(Q,SizeOf(Q));
  Q.FS:=FileSize(Handle);Q.FP:=0;
  ArcInit:=True;
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Proc‚dure ArcFindNext                    Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Portabilit‚: Local


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de rechercher l'‚l‚ment suivant de la liste
 d'un fichier compress‚ de format ®ARC¯ }

Procedure ArcFindNext(Handle:Hdl;Var Q:ArcFiles;Var X:SearchRec);Near;
Var
 H:ArcHeader;
Begin
 If(Q.FP>=Q.FS)Then SysErr:=18
  Else
 Begin
  FillClr(X,SizeOf(X));
  _GetAbsRec(Handle,Q.FP,SizeOf(H),H);
  If(H.HeadID<>$1A)or(H.DataType=0)Then SysErr:=18
   Else
  Begin
   {$IFDEF __Windows__}
    StrPCopy(@X.Name,StrPas(@H.Name));
   {$ELSE}
    X.Name:=StrPas(@H.Name);
   {$ENDIF}
   X.Size:=H.OrigSize;
   X.Time:=H.Time;
   Inc(Q.FP,LongInt(H.CompSize)+LongInt(SizeOf(ArcHeader)));
   SysErr:=0;
  End;
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Fonction BFSelPathExt                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: BF (BankFiles)
 Portabilit‚:  Global


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction chargent en m‚moire la liste d'un/des r‚pertoire(s) d‚finit
 par la  variable  de  param‚trage  ®Path¯.  Celle - ci  supporte  plusieurs
 r‚pertoires  s‚par‚s  par  des  points-virgules (;).  Elle  est  accessible
 dor‚navant  par toutes  les fonctions  de l'objet  ®BF¯.  Si  une  tri  est
 autoris‚, … partir de la variable objet ®Tri¯, il l'effectue en fonction du
 format demand‚ (par nom, par taille,...). Elle retourne ®Ya¯ si l'op‚ration
 s'est correctement pass‚ ou ®No¯ si des problŠmes sont survenus  (manque de
 m‚moire, problŠme disque ou DOS,...). Dans le cas o— vous d‚j… pr‚c‚demment
 fait appelle  … cette fonction  pour charger d'autres r‚pertoires  (ou  qui
 c'est  pour  les  mˆmes),  la  fonction  se charge  automatiquement  de les
 ‚liminer  de la  m‚moire  pour  ˆtre  utiliser  par  d'autres  fonctions et
 proc‚dures. Il n'y a donc aucun danger de perte de m‚moire...


 Remarques
 ÍÍÍÍÍÍÍÍÍ

  ş La directive conditionnel ®ShortBF¯ permet  d'utiliser la m‚thode rapide
    pour mode r‚el si elle est d‚finit lors de la compilation.

  ş Cette fonction supporte les descriptions contenu dans les fichiers 4DOS/
    NDOS:  ®DESCRIPT.ION¯.  En plus,  elle supporte le contenu  des fichiers
    r‚pertoires  ®PFS.DIR¯,  sans oublier qu'elle assume le nom des fichiers
    contenu dans les fichiers de musique ®.MOD¯.

  ş Cette fonction ne distingue  pas les sens des barres oblique  "\" ou "/"
    du systŠme d'exploitation DOS ou de Unix. Un sens ou l'autre, pour elle,
    elle retournera le mˆme r‚sultat.

  ş Cette  fonction  supporte  les  noms  long  de  Windows 95,  98 et NT et
    l'addition comme des descriptions.

  ş Cette fonction  supporte  ‚galement les noms  contenue dans les fichiers
    d'anciennement ®GeoWorks Ensemble¯, nomm‚e maintenant ®New Deal Office¯.

  ş Cette fonction permet de lire les r‚pertoires  contenu dans des fichiers
    compress‚s comme ®ARC¯, ®ARJ¯, ®CAB¯, ®ICE¯, ®LHA¯, ®PAK¯, ®RAR¯,®SWAG¯,
    ®ZIP¯, ®ZOO¯ par exemple.


 ParamŠtres
 ÍÍÍÍÍÍÍÍÍÍ

  Q         Nom de l'objet de banque de fichier
  Path      Chemin de recherche des fichiers
  Attr      Attribut de recherche des fichiers
}

Function BFSelPathExt(Var Q:BF;Path:String;Attr:Word):Boolean;
Var
 DirInfo:SearchRec;
 I:Byte;
 MPath,MExt,FPath:String;
 tE,tI,tJ,tK,tM,tX:Integer;
 NameI,NameM:String;
 Dsk:Byte;
 NmF:Word;
 {$IFDEF ShortBF}
  Handle:Hdl;
  XChg:Search32Rec;
  PtrFree:PtrRec;
 {$ELSE}
  PtrI,PtrM:^SearchRec;
 {$ENDIF}
 BufHead:Array[0..511]of Byte;
 RecL:ZipRecL Absolute BufHead;
 ARJ:ArjHeader Absolute BufHead;
 CABSign:Array[0..3]of Char Absolute RecL;
 ZipFP:LongInt;
 List:(fNone,fArc,fArj,fCab,fLZH{ICE},fPAK,fRAR,fSWG,fZIP,fZOO);
 HandleZip:Hdl;             { ®Handle¯ fichier attribu‚ au fichier compress‚}
 LongFileName:Boolean;      { Autorise l'utilisation des noms long? }
 LX:TLSearchRec;            { Donn‚e de travail des fichiers au nom long }
 DT:DateTime;
 QC:CabFiles;               { Donn‚e de travail de fichiers compress‚ ®CAB¯ }
 QA:ArjFiles Absolute QC;   { Donn‚e de travail de fichiers compress‚ ®ARJ¯ }
 QArc:ArcFiles Absolute QC; { Donn‚e de travail de fichiers compress‚ ®ARC¯ }
 QL:LZHFiles Absolute QC;   { Donn‚e de travail de fichiers compress‚ ®LZH¯ et ®ICE¯ }
 QP:PAKFiles ABsolute QC;   { Donn‚e de travail de fichiers compress‚ ®PAK¯ }
 QR:RARFiles Absolute QC;   { Donn‚e de travail de fichiers compress‚ ®RAR¯ }
 QS:SWAGFiles Absolute QC;  { Donn‚e de travail de fichiers compress‚ ®SWAG¯ }
 QZO:ZooFiles Absolute QC;  { Donn‚e de travail de fichiers compress‚ ®ZOO¯ }
Const
 ZipSign:LongInt=$04034B50;

 Procedure FindNext(Var X:SearchRec);
 Var
  L:Word;
  PL:^LongInt;
 Begin
  Case(List)of
   fArc:ArcFindNext(HandleZip,QArc,X);
   fArj:Begin
    If ArjFindNext(HandleZip,QA,X)Then SysErr:=0
                                  Else SysErr:=18;
   End;
   fCab:CabFindNext(HandleZip,QC,X);
   fLZH:LZHFindNext(HandleZip,QL,X);
   fSWG:SwagFindNext(HandleZip,QS,X);
   fPAK:PAKFindNext(HandleZip,QP,X);
   fRAR:RARFindNext(HandleZip,QR,X);
   fZip:Begin
    _GetAbsRec(HandleZip,ZipFP,SizeOf(RecL),RecL);
    If(RecL.Sign=ZipSign)Then Begin
     {$IFDEF __Windows__}
      SetLength(NameI,RecL.FileNameLen);
     {$ELSE}
      NameI[0]:=Char(RecL.FileNameLen);
     {$ENDIF}
     _GetRec(HandleZip,Length(NameI),NameI[1]);
     ChgChr(NameI,'/','\');
     {$IFDEF __Windows__}
      StrPCopy(@X.Name,Path2NoDir(NameI));
     {$ELSE}
      X.Name:=Path2NoDir(NameI);
     {$ENDIF}
     MoveLeft(RecL.LastModFileTime,X.Time,SizeOf(Word)shl 1);
     X.Size:=RecL.UnCompressSize;
     X.Attr.Value:={RecL.GeneralPurposeBitFlag}faArchive;
     PL:=@X.Fill[14];
     If RecL.CompressMethod=0Then Begin
      PL^:=ZipFP+SizeOf(RecL)+RecL.FileNameLen;
     End
      Else
     PL^:=0;
     Inc(ZipFP,SizeOf(RecL)+RecL.CompressSize+RecL.FileNameLen);
     SysErr:=0;
    End
     Else
    SysErr:=18;
   End;
   fZoo:ZOOFindNext(HandleZip,QZO,X);
   Else Begin
    If(LongFileName)Then Begin
     LFindNext(LX);
      { Transformation des informations de long nom au format de la liste }
     X.Attr.Value:=LX.Attr;
     If LX.ShortName[0]=#0Then
     Begin
      {$IFDEF __Windows__}
       MoveLeft(LX.Name,X.Name,SizeOf(LX.Name));
      {$ELSE}
       X.Name:=StrPas(@LX.Name);
      {$ENDIF}
     End
      Else
     Begin
      {$IFDEF __Windows__}
       MoveLeft(LX.ShortName,X.Name,SizeOf(X.Name));
      {$ELSE}
       X.Name:=StrPas(@LX.ShortName);
      {$ENDIF}
     End;
     X.Size:=LX.LoSize;
     X.Time:=LTime2Dos(LX.LastModTime);
    End
     Else
    Systems.FindNext(X);
   End;
  End;
 End;

 Procedure FindFirst(S:String;Attr:Word;Var X:SearchRec);
 Label Normal;
 Var
  P:Array[0..255]of Char;
 Begin
  List:=fNone;
  StrPCopy(@P,S);
  If(LongFileName)Then Begin
   LFindFirst(P,Attr and$3F,LX);
   If SysErr=1Then Begin
    LongFileName:=False; { Si ‚chec de la technique de lecture par nom long }
    Goto Normal;         { d‚sactiver cette m‚thode et passer … la m‚thode normal }
   End;
  End
   Else
  Begin
Normal:
   Systems.FindFirst(S,Attr,X);
  End;
  If SysErr=0Then
   If(LongFileName)Then Begin { Lecture par nom long de Windows? }
    LFindFirst(P,Attr and$3F,LX);
    X.Attr.Value:=LX.Attr;
    If LX.ShortName[0]=#0Then Begin
     X.Name:=StrPas(@LX.Name)
    End
     Else
    Begin
     X.Name:=StrPas(@LX.ShortName);
    End;
    X.Size:=LX.LoSize;
    X.Time:=LTime2Dos(LX.LastModTime);
   End
    Else
   Begin
    Systems.FindFirst(S,Attr,X);
   End
   Else
   { Autrement il s'agit peut ˆtre d'un r‚pertoire se trouvant dans un
     fichier compress‚ (ARC, ARJ, CAB, LZH, PAK, RAR, SWAG, ZIP, ZOO,...)? }
  Begin
   S:=Path2Dir(S);
   BackStr(S);
   HandleZip:=FileOpen(S,fmRead);
   If(HandleZip<>errHdl)Then Begin
    _GetAbsRec(HandleZip,0,SizeOf(RecL),RecL);
    If(RecL.Sign=ZipSign)Then List:=fZip Else
    If Arj.HeadID=60000Then List:=fArj Else
    If CABSign='MSCF'Then List:=fCab Else { MicroSoft Compressed File? }
    If ZooInit(HandleZip,BufHead,QZO)Then List:=fZoo Else
    If PAKInit(BufHead,QP)Then List:=fPAK Else
    If LZHInit(HandleZip,BufHead,QL)Then List:=fLZH Else
    If SwagInit(HandleZip,BufHead,QS)Then List:=fSWG Else
    If RARInit(HandleZip,BufHead,QR)Then List:=fRAR Else
    If ARCInit(HandleZip,BufHead,QArc)Then List:=fARC
                         Else List:=fNone;
    ZipFP:=0;
    Case(List)of
      {TraŒtement particulier pour les fichiers ®.ARJ¯ }
     fArj:Begin
      QA.SL:=0;
      ArjFindNext(HandleZip,QA,X);
      If QA.SL=0Then Begin
       List:=fNone;
       FileClose(HandleZip);
      End;
     End;
      {TraŒtement particulier pour les fichiers ®.CAB¯ de Windows: }
     fCab:CabInit(BufHead,QC);
    End;
     {Si fait partie de l'ensemble des fichiers compress‚ reconnu alors}
     {faire comme s'il s'agissait d'un entr‚e parent (®..¯)? }
    If(List)in[fArc,fArj,fCab,fLZH,fPAK,fRAR,fSWG,fZip,fZoo]Then Begin
     Q.Compressed:=True; { Il s'agit d'un fichier r‚pertoire compress‚! }
     FillClr(X,SizeOf(X));
     X.Name:='..';
     X.Attr.Value:=faDir;
     SysErr:=0;
    End;
   End;
  End;
 End;

  {Cette fonction permet d'ajouter le nom du fichier/r‚pertoire dans la liste}
 Function AddFile:Boolean;
 Label Store;
 Var Ext:ExtStr;  { Extension du fichier ou du r‚pertoire }
     Str:String;  { ChaŒne de caractŠres de travail }
 Begin
  AddFile:=False;
   { Nom absent? }
  If Length(DirInfo.Name)=0Then Begin
   AddFile:=True; { Quitter en indiquant que tous ces biens pass‚s et }
   Exit;          { qu'il ne manque donc pas de m‚moire pour l'ajout de }
                  { la liste de fichier en m‚moire... }
  End;
  {$IFDEF ShortBF}
   If(NmF shl 5>Q.SizeB)Then Exit;
   MoveLeft(DirInfo.Fill[OfsBF],Q.Buffer^[NmF],SizeOf(Search32Rec));
    { Ce n'est pas une recherche effectu‚ dans un fichier compress‚ Swag? }
   If(List<>fSWG)Then Begin
    If(LongFileName)and(LX.ShortName[0]<>#0)Then Begin
     Q.Buffer^[NmF].PtrDescr:=StrNew(@LX.Name);
    End
     Else
    Begin
     Q.Buffer^[NmF].PtrDescr:=NIL;
     If(DescrInFile)Then Begin
      Ext:=Path2Ext(Q.Buffer^[NmF].Name);
       {Recherche d'une description d'un fichier de musique .MOD }
      If Ext='.MOD'Then Begin
       GetFile(SetPath4AddFile(Path2Dir(FPath))+Q.Buffer^[NmF].Name,0,20,Str[1]);
       Str[0]:=#20;
       Goto Store;
      End
       Else
       {Recherche d'un nom si c'est un fichier GeoWorks/New Deal Office }
      If(Ext='.000')and(Path2Name(Q.Buffer^[NmF].Name)<>'@DIRNAME')Then Begin
       If(Q.Buffer^[NmF].Attr and faDir=faDir)Then Begin
         { Les r‚pertoires GeoWorks/New Deal Office contiennent presque tout
           le temps un fichier nomm‚ ®@DIRNAME.000¯ refermant le nom
           attribu‚ au r‚pertoire en question.}
        GetFile(SetPath4AddFile(Path2Dir(FPath))+Q.Buffer^[NmF].Name+'\@DIRNAME.000',0,256,Str[0]);
       End
        Else
       GetFile(SetPath4AddFile(Path2Dir(FPath))+Q.Buffer^[NmF].Name,0,256,Str[0]);
        {V‚rification de signature de fichier GeoWorks/New Deal Office?}
       If(Str[0]=#$C7)and(Str[1]=#$45)and(Str[2]=#$C1)and(Str[3]=#$53)Then Begin
        Str[255]:=#0;
        Str:=StrPas(@Str[4]);
  Store:Q.Buffer^[NmF].PtrDescr:=Str2PChr(Str);
       End;
      End;
     End;
    End;
   End;
   Inc(NmF);
  {$ELSE}
   ALAddBlock(Q.Buffer,SizeOf(DirInfo),DirInfo);
  {$ENDIF}
  AddFile:=True;
 End;

 Procedure ReadLst;Begin
  While SysErr=0do Begin
   If Not(AddFile)Then Exit;
   Inc(Q.SizeFiles,DirInfo.Size);
   FindNext(DirInfo);
  End;
   {Si fichier compress‚: Zip...}
  If(List=fZip)Then FileClose(HandleZip);
 End;

  {Lecture d'un r‚pertoire entier }
 Procedure ReadDir;Begin
  FPath:=Path2Dir(MPath)+'*.*';
  FindFirst(FPath,faDir,DirInfo);
  While SysErr=0do Begin
   If((sfaDir)in(DirInfo.Attr.Flags))and(DirInfo.Name<>'.')Then Begin
    If Not(AddFile)Then Exit;
   End;
   FindNext(DirInfo);
  End;
  Attr:=Attr and Not(faDir);
 End;

 {$IFDEF ShortBF}
  {Recherche des fichiers de descriptions contenant des indications pour}
  {les fichiers du r‚pertoires. Il effectue des recherches dans une vue}
  {d'ensemble et non pas fichier par cas par cas! }
  Procedure ReadDescr(Path:String);
  Var{Variable local:}
   FP,FS:LongInt;          { Position de lecture et taille du fichier }
   S,Name:String;          { R‚pertoire de recherche, nom de fichier courant }
   I,J:Word;               { Compteur de boucle }
   PFS:PFS1;               { Entˆte contenant les descriptions de format ®PFS¯}
   Sign:Array[0..3]of Chr; { Conteneur de signature }
  Begin
   If(DescrInFile)Then Begin
    S:=SetPath4AddFile(Path2Dir(Path));
    Handle:=FileOpen(S+'DESCRIPT.ION',fmRead);FP:=0;
    If(Handle=errHdl)Then Begin
     Handle:=FileOpen(S+'PFS.DIR',fmRead);
     If(Handle<>errHdl)Then Begin
      GetRec(Handle,0,SizeOf(Sign),Sign);
      If Sign='PFS1'Then Begin
       For J:=0to(FileSize(Handle)-SizeOf(Sign))div SizeOf(PFS)do Begin
        _GetAbsRec(Handle,4+J*SizeOf(PFS),SizeOf(PFS),PFS);
        For I:=0to NmF-1do If(Q.Buffer^[I].Name=PFS.Name)Then Begin
         If(Q.Buffer^[I].PtrDescr=NIL)Then Q.Buffer^[I].PtrDescr:=Str2PChr(PFS.Descr);
         Break;
        End;
       End;
      End;
      FileClose(Handle);
     End;
    End
     Else
    Begin
     FS:=FileSize(Handle);
     Repeat
      __GetAbsFileTxtLn(Handle,FP,S);J:=Pos(' ',S);
      If J=0Then Continue;
      Name:=StrUp(Left(S,J-1));
      For I:=0to NmF-1do If(Q.Buffer^[I].Name=Name)Then Begin
       If(Q.Buffer^[I].PtrDescr=NIL)Then Q.Buffer^[I].PtrDescr:=Str2PChr(Copy(S,J+1,255));
       Break;
      End;
     Until FP>=FS;
     FileClose(Handle);
    End;
   End;
  End;
 {$ENDIF}

Begin
 BFSelPathExt:=False;  { Attribu‚ par d‚faut un ‚chec d'op‚ration }
 HandleZip:=$FF;       { D‚sactiver le Handle de fichier compress‚ }
 List:=fNone;          { Aucune liste de fichiers compress‚ }
  {V‚rification de nom long support‚, c'est … dire dans le cas de
   Windows 95/98/NT?}
 LongFileName:=((Win=winEnhanced)and(WinLoVer=4))or
                ((Hi(GetDosVer)=5)and(Lo(GetDosVer)=50));
 If(Q.Init)Then {$IFDEF ShortBF}
                 BFDone(Q)
                {$ELSE}
                 ALDone(Q.Buffer)
                {$ENDIF}
           Else Q.Init:=True;
 Q.Compressed:=False;
 {$IFDEF ShortBF}
   {Allou‚ le maximum de m‚moire possible en une "traŒte"!}
  If MaxAvail<65520Then Q.SizeB:=MaxAvail
                   Else Q.SizeB:=65520;
  Q.Buffer:=MemAlloc(Q.SizeB); { Allou‚ le maximum de m‚moire }
  NmF:=0; { Nombre de fichier au d‚part naturellement 0 }
 {$ELSE}
  ALInit(Q.Buffer);
 {$ENDIF}
 Q.SizeFiles:=0;
 If(Path='*:')or(Path='*:\')Then Begin
  For I:=0to 25do If DiskExist(I)Then Begin
   {$IFDEF ShortBF}
    If(NmF shl 5>Q.SizeB)Then Break;
    DirInfo.Name:=Chr(I+65)+':';
    DirInfo.Attr.Value:=faDir;
    MoveLeft(DirInfo.Fill[OfsBF],Q.Buffer^[NmF],SizeOf(Search32Rec));
    Inc(NmF);
   {$ENDIF}
  End;
 End
  Else
 Begin
  ChgChr(Path,'/','\'); { Modifie les caractŠres Unix ®/¯ pour ®\¯ }
  Dsk:=Path2Dsk(Path);
  If DskMount(Dsk)Then Begin
   If Pos(';',Path)>0Then Begin
    For I:=1to Length(Path)do If Path[I]=';'Then Break;
    MPath:=Left(Path,I-1);
    LoadPathVolume(Q,Dsk,NmF,MPath,Attr);
    While I<=Length(Path)do Begin
     If StrI(I,Path)=';'Then Inc(I);
     MExt:='';
     While Not(StrI(I,Path)in[#0,';'])do Begin
      IncStr(MExt,Path[I]);
      Inc(I)
     End;
     If MExt=''Then Exit;
     FPath:=Path2Dir(MPath)+MExt;
     LoadPathVolume(Q,Dsk,NmF,FPath,Attr and Not(faDir));
    End;
   End
    Else
   Begin
    LoadPathVolume(Q,Dsk,NmF,Path,Attr);
   End;
  End
   Else
  {$IFDEF DirectDos}
    {Autorise d'effectue des accŠs directe de lecture sur la FAT 12 et 16
     afin d'acc‚l‚rer la lecture par 16 fois. }
   If(DirectDos)Then Begin
    If Pos(';',Path)>0Then Begin
     For I:=1to Length(Path)do If Path[I]=';'Then Break;
     MPath:=Left(Path,I-1);
     LoadPath(Q,NmF,MPath,Attr);
     While I<=Length(Path)do Begin
      If StrI(I,Path)=';'Then Inc(I);
      MExt:='';
      While Not(StrI(I,Path)in[#0,';'])do Begin
       IncStr(MExt,Path[I]);
       Inc(I)
      End;
      If MExt=''Then Exit;
      FPath:=Path2Dir(MPath)+MExt;
      LoadPath(Q,NmF,FPath,Attr and Not(faDir));
      {$IFDEF ShortBF}
       ReadDescr(FPath);
      {$ENDIF}
     End;
    End
     Else
    Begin
     LoadPath(Q,NmF,Path,Attr);
     {$IFDEF ShortBF}
      ReadDescr(Path);
     {$ENDIF}
    End;
   End
    Else
  {$ENDIF}
  If Pos(';',Path)>0Then Begin
   For I:=1to Length(Path)do If Path[I]=';'Then Break;
   MPath:=Left(Path,I-1);
   ReadDir;
   FPath:=MPath;
   FindFirst(MPath,Attr,DirInfo);
   ReadLst;
   While I<=Length(Path)do Begin
    If StrI(I,Path)=';'Then Inc(I);
    MExt:='';
    While Not(StrI(I,Path)in[#0,';'])do Begin
     IncStr(MExt,Path[I]);
     Inc(I)
    End;
    If MExt=''Then Exit;
    FPath:=Path2Dir(MPath)+MExt;
    FindFirst(FPath,Attr,DirInfo);
    ReadLst;
    {$IFDEF ShortBF}
     ReadDescr(Path2Dir(MPath)+MExt);
    {$ENDIF}
   End;
  End
   Else
  If Path2Ext(Path)<>'.*'Then Begin
   MPath:=Path;
   ReadDir;
   FPath:=Path;
   FindFirst(Path,Attr,DirInfo);
   ReadLst;
   {$IFDEF ShortBF}
    ReadDescr(Path);
   {$ENDIF}
  End
   Else
  Begin
   FPath:=Path;
   FindFirst(Path,Attr,DirInfo);
   While SysErr=0do Begin
    If Not(((sfaDir)in(DirInfo.Attr.Flags))and(DirInfo.Name='.'))Then Begin
     AddFile;
     Inc(Q.SizeFiles,DirInfo.Size);
    End;
    FindNext(DirInfo);
   End;
   {$IFDEF ShortBF}
    ReadDescr(Path);
   {$ENDIF}
  End;
 End;
 {$IFDEF ShortBF}
   {Lib‚rer la m‚moire n'ayant pas ‚t‚ utilis‚:}
  If NmF=0Then _FreeMemory(Pointer(Q.Buffer),Q.SizeB)
   Else
  Begin
   Pointer(PtrFree):=Pointer(Q.Buffer);
   Inc(PtrFree.Seg,NmF shl 1);
   FreeMemory(Pointer(PtrFree),Q.SizeB-(NmF shl 5));
   Q.SizeB:=NmF shl 5;
 {$ENDIF}
  (*******************************************************************)
  (*      Effectu‚ une Tri des fichiers selon la sorte demander      *)
  (*******************************************************************)
 If(Q.Tri>fUnsort)and({$IFDEF ShortBF}NmF{$ELSE}Q.Buffer.Count{$ENDIF}>2)Then Begin
  tE:={$IFDEF ShortBF}NmF{$ELSE}Q.Buffer.Count{$ENDIF}-1;
  Repeat
   ASM SHR tE,1;END;
   tJ:=0;
   tK:={$IFDEF ShortBF}NmF{$ELSE}Q.Buffer.Count{$ENDIF}-1-tE;
   Repeat
    tI:=tJ;
    Repeat
     tM:=tI+tE;
     {$IFNDEF ShortBF}
      PtrI:=_ALGetBuf(Q.Buffer,tI);
      PtrM:=_ALGetBuf(Q.Buffer,tM);
     {$ENDIF}
     Case(Q.Tri)of
  fExt:{$IFDEF ShortBF}
        If Not(Path2Ext(Q.Buffer^[tI].Name)>Path2Ext(Q.Buffer^[tM].Name))Then
       {$ELSE}
        If Not(Path2Ext(PtrI^.Name)>Path2Ext(PtrM^.Name))Then
       {$ENDIF}
       Break;
 fSize: {$IFDEF ShortBF}
         If Not(Q.Buffer^[tI].Size>Q.Buffer^[tM].Size)Then
        {$ELSE}
         If Not(PtrI^.Size>PtrM^.Size)Then
        {$ENDIF}
        Break;
 fTime: {$IFDEF ShortBF}
         If Not(Q.Buffer^[tI].Time>Q.Buffer^[tM].Time)Then
        {$ELSE}
         If Not(PtrI^.Time>PtrM^.Time)Then
        {$ENDIF}
        Break;
   Else Begin
         {$IFDEF ShortBF}
          NameI:=Q.Buffer^[tI].Name;
          NameM:=Q.Buffer^[tM].Name;
         {$ELSE}
          NameI:=PtrI^.Name;
          NameM:=PtrM^.Name;
         {$ENDIF}
         {$IFDEF ShortBF}
          If(Q.Buffer^[tI].Attr and faDir=faDir)Then
         {$ELSE}
          If(sfaDir)in(PtrI^.Attr.Flags)Then
         {$ENDIF}
         NameI:=#1+NameI;
         {$IFDEF ShortBF}
          If(Q.Buffer^[tM].Attr and faDir=faDir)Then
         {$ELSE}
          If(sfaDir)in(PtrM^.Attr.Flags)Then
         {$ENDIF}
         NameM:=#1+NameM;
         If Not(NameI>NameM)Then Break;
        End;
     End;
     {$IFDEF ShortBF}
      xchg:=Q.Buffer^[tI];
      Q.Buffer^[tI]:=Q.Buffer^[tM];
      Q.Buffer^[tM]:=xchg;
     {$ELSE}
      ALXchgBuf(Q.Buffer,tI,tM);
     {$ENDIF}
     Dec(tI,tE);
    Until tI<0;
    Inc(tJ);
   Until tJ>tK;
  Until tE=1;
 End;
  (*******************************************************************)
  (*                      Fin de la partie de Tri                    *)
  (*******************************************************************)
 {$IFDEF ShortBF}
  End;
 {$ENDIF}
 If(LongFileName)Then Begin
  LFindClose(LX);
 End;
 FileClose(HandleZip);
 BFSelPathExt:=True;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Fonction GetDescriptPath                    Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction retourne le chemin complet correspondant au fichier de
 description du 4DOS/NDOS.
}

Function GetDescriptPath(Const Name:String):String;Begin
 If Name=''Then GetDescriptPath:=''
           Else GetDescriptPath:=Path2Dir(Name)+'DESCRIPT.ION';
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Fonction SearchDescription                    Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction retourne la description correspondant au chemin de fichier
 sp‚cifi‚e en param‚trage.
}

{$I \Source\Chantal\Library\System\Dos\Shell\4Dos\SearchDe.Inc}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Fonction LFindFirst                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Portabilit‚: Global
 Sp‚cialit‚:  Windows 95 et 98


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de trouver le premier ‚l‚ment d'une liste de
 fichiers de format nom long du systŠme d'exploitation 95 et 98.
}

Function LFindFirst{FileSpec:PChar;Attr:Word;Var SRec:TLSearchRec):Word};Assembler;ASM
 {$IFDEF Win32}
 {$ELSE}
  PUSH DS
   LDS DX,FileSpec
   LES DI,SRec
   MOV CX,Attr
   XOR SI,SI
   MOV AX,714Eh
  INT 21h
  POP DS
  SBB BX,BX
  MOV ES:[DI].TLSearchRec.Handle,AX
  AND AX,BX
  MOV SysErr,AX
 {$ENDIF}
END;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Fonction LFindNext                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Portabilit‚: Global
 Sp‚cialit‚:  Windows 95 et 98


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de trouver l'‚l‚ment suivant d'une liste de
 fichiers de format nom long du systŠme d'exploitation 95 et 98.
}

Function LFindNext{Var SRec:TLSearchRec):Word};Assembler;ASM
 {$IFDEF Win32}
 {$ELSE}
  MOV AX,714Fh
  XOR SI,SI
  LES DI,SRec
  MOV BX,ES:[DI].TLSearchRec.Handle
  INT 21h
  SBB BX,BX
  AND AX,BX
  MOV SysErr,AX
 {$ENDIF}
END;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Fonction LFindClose                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Portabilit‚: Global
 Sp‚cialit‚:  Windows 95 et 98


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction doit toujours ˆtre appel‚e aprŠs que la terminaison
 de  la lecture  effectu‚e  par les  deux  routines  ®LFindFirst¯ et
 ®FindNext¯ est termin‚e  afin que le systŠme  d'exploitation puisse
 restituer les ressources allou‚.
}

Function LFindClose{Var SRec:TLSearchRec):Word};Assembler;ASM
 {$IFDEF Win32}
 {$ELSE}
  MOV AX,71A1h
  MOV BX,ES:[DI].TLSearchRec.Handle
  INT 21h
  SBB BX,BX
  AND AX,BX
  MOV SysErr,AX
 {$ENDIF}
END;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Fonction LTrueName                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Portabilit‚: Global
 Sp‚cialis‚:  Windows 95 et 98


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de retourner le v‚ritable nom d'un nom de fichier
 du systŠme d'exploitation 95, 98 et NT.
}

{$IFNDEF __Windows__}
 Function LTrueName{FileName:PChar;Result:PChar):Word};Assembler;ASM
  PUSH DS
   MOV AX,7160h
   XOR CX,CX
   LDS SI,FileName
   LES DI,Result
   INT 21h
  POP DS
  SBB BX,BX
  AND AX,BX
  MOV SysErr,AX
 END;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Fonction LGetShortName                    Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Portabilit‚: Global
 Sp‚cialis‚:  Windows 95 et 98


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de retourner le nom court en format DOS d'un nom
 long de fichier de format Windows 95/98 et NT.
}

 Function LGetShortName{FileName:PChar;Result:PChar):Word};Assembler;ASM
  PUSH DS
   LDS SI,FileName
   LES DI,Result
   MOV AX,7160h
   MOV CX,1
   INT 21h
  POP DS
  SBB BX,BX
  AND AX,BX
  MOV SysErr,AX
 END;

{$ENDIF}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Fonction LGetLongName                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Portabilit‚: Global
 Sp‚cialis‚:  Windows 95 et 98


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de retourner le nom long en format Windows 95/98
 et NT en format DOS court (8 de noms, 3 d'extension).
}

Function LGetLongName{FileName:PChar;_Result:PChar):Word};Assembler;ASM
 {$IFDEF FLAT386}
  PUSH ESI
   PUSH EDI
    LEA ESI,DWord Ptr FileName
    LEA EDI,DWord Ptr _Result
    MOV AX,7160h
    MOV CX,2
    INT 21h
    SBB BX,BX
    AND AX,BX
    MOV SysErr,AX
   POP EDI 
  POP ESI
 {$ELSE}
  PUSH DS
   LDS SI,FileName
   LES DI,_Result
   MOV AX,7160h
   MOV CX,2
   INT 21h
  POP DS
  SBB BX,BX
  AND AX,BX
  MOV SysErr,AX
 {$ENDIF}
END;

Function LFileSystemInfo{RootName:PChar;FSName:PChar;FSNameBufSize:Word;
Var Flags,MaxFileNameLen,MaxPathLen:Word):Word};Assembler;ASM
 {$IFDEF Win32}
 {$ELSE}
  PUSH DS
   LDS DX,RootName
   LES DI,FSName
   MOV CX,FSNameBufSize
   MOV AX,71A0h
   INT 21h
  POP DS
  LES DI,Flags
  MOV ES:[DI],BX
  LES DI,MaxFileNameLen
  MOV ES:[DI],CX
  LES DI,MaxPathLen
  MOV ES:[DI],DX
  SBB BX,BX
  AND AX,BX
  MOV SysErr,AX
 {$ENDIF} 
END;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Fonction LTime2Dos                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de convertir les dates des noms long … l'ancien
 format DOS.
}

Function LTime2Dos{Var LTime:Comp):Long};Assembler;ASM
 {$IFDEF Win32}
 {$ELSE}
  PUSH DS
   LDS SI,LTime
   XOR BL,BL
   MOV AX,71A7h
   INT 21h
  POP DS
  MOV AX,CX
  CMC
  SBB CX,CX
  AND AX,CX
  AND DX,CX
 {$ENDIF}
END;

Procedure UnpackLTime{Var LTime:Comp;Var DT:DateTime};Begin
 Systems.UnpackTime(LTime2Dos(LTime),DT);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Fonction LMkDir                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de cr‚er un r‚pertoire … nom long du systŠme
 d'exploitation Windows 95/98/NT.
}

Function LMkDir{Directory:PChar):Word};Assembler;ASM
 {$IFDEF Win32}
 {$ELSE}
  PUSH DS
   LDS DX,Directory
   MOV AX,7139h
   INT 21h
  POP DS
  SBB BX,BX
  AND AX,BX
  MOV SysErr,AX
 {$ENDIF}
END;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Fonction LRmDir                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet d'effacer un r‚pertoire … nom long du systŠme
 d'exploitation Windows 95/98/NT.
}

Function LRmDir{Directory:PChar):Word};Assembler;ASM
 {$IFDEF Win32}
 {$ELSE}
  PUSH DS
   LDS DX,Directory
   MOV AX,713Ah
   INT 21h
  POP DS
  SBB BX,BX
  AND AX,BX
  MOV SysErr,AX
 {$ENDIF}
END;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Fonction LChDir                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de changer de r‚pertoire … nom long du systŠme
 d'exploitation Windows 95/98/NT.
}

Function LChDir{Directory:PChar):Word};Assembler;ASM
 {$IFDEF Win32}
 {$ELSE}
  PUSH DS
   LDS DX,Directory
   MOV AX,713Bh
   INT 21h
  POP DS
  SBB BX,BX
  AND AX,BX
  MOV SysErr,AX
 {$ENDIF}
END;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Fonction LErase                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet d'effacer un fichier … nom long du systŠme
 d'exploitation Windows 95/98/NT.
}

Function LErase{(Filename:PChar):Word};Assembler;ASM
 {$IFDEF Win32}
 {$ELSE}
  PUSH DS
   LDS DX,Filename
   MOV AX,7141h
   INT 21h
  POP DS
  SBB BX,BX
  AND AX,BX
  MOV SysErr,AX
 {$ENDIF}
END;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Fonction LGetAttr                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de modifier les attributs d'un fichiers … nom
 long du systŠme d'exploitation Windows 95/98/NT.
}

Function LGetAttr{Filename:PChar;Var Attr:Word):Word};Assembler;ASM
 {$IFDEF Win32}
 {$ELSE}
  PUSH DS
   LDS DX,Filename
   MOV AX,7143h
   XOR BL,BL
   INT 21h
  POP DS
  LES DI,Attr
  MOV ES:[DI],CX
  SBB BX,BX
  AND AX,BX
  MOV SysErr,AX
 {$ENDIF}
END;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Fonction LSetAttr                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de fixer un attribut d'un fichier sous forme d'un
 nom long dans le systŠme d'exploitation Windows 95 et 98.
}

Function LSetAttr{Filename:PChar;Attr:Word):Word};Assembler;ASM
 {$IFDEF Win32}
 {$ELSE}
  PUSH DS
   LDS DX,Filename
   MOV AX,7143h
   MOV BL,1
   MOV CX,Attr
   INT 21h
  POP DS
  SBB BX,BX
  AND AX,BX
  MOV SysErr,AX
 {$ENDIF} 
END;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Fonction LGetDir                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de demander un r‚pertoire courant d'un unit‚ sous
 forme d'un nom long dans le systŠme d'exploitation Windows 95 et 98.
}

{$IFNDEF __Windows__}
 Function LGetDir{Drive:Byte;Result:PChar):Word};Assembler;ASM
  CLD
  LES DI,Result
  MOV AL,Drive
  MOV DL,AL
  DEC AL
  JNS @GotDrive
  MOV AH,19h
  INT 21h
 @GotDrive:
  ADD AL,41h
  MOV AH,':'
  STOSW
  MOV AX,'\'
  STOSW
  PUSH DS
   PUSH ES
   POP DS
   MOV SI,DI
   DEC SI
   MOV AX,7147h
   INT 21h
  POP DS
  SBB BX,BX
  AND AX,BX
  MOV SysErr,AX
 END;
{$ENDIF}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Fonction LRename                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de renommer un fichier … long nom sous un nouveau
 nom dans le systŠme d'exploitation Windows 95 et 98.
}

Function LRename{OldFilename,NewFilename:PChar):Word};Assembler;ASM
 {$IFDEF Win32}
 {$ELSE}
  PUSH DS
   LDS DX,OldFilename
   LES DI,NewFilename
   MOV AX,7156h
   INT 21h
  POP DS
  SBB BX,BX
  AND AX,BX
  MOV SysErr,AX
 {$ENDIF} 
END;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Fonction SetDescription                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet d'associ‚e un description de format 4DOS/NDOS … un
 chemin de fichier particulier.
}

Function SetDescription{Const Name,Descript:String):Boolean};
Type
 FileRec=Record
  FileName,Str:String;
 End;
Var
 Handle:Text;
 IOBuf:Array[0..2047]of Char;
 Regel,Tmp:String;
 FileFound:Boolean;
 Lst:ArrayList;
 Data:FileRec;
 FullName:String;

 { Lecture de toutes les descriptions et les transferts dans un tableau }
 Procedure ReadInfo;Begin
  {$I-} Reset(Handle); {$I+}
  FileFound:=False;
  If(IOResult<>0)or(Eof(Handle))Then Begin
   Data.FileName:=StrUp(Path2NoDir(Name));
   Data.Str:=Descript;
   ALAddBlock(Lst,SizeOf(FileRec),Data);
   System.Close(Handle);
   Exit;
  End
   Else
  While Not Eof(Handle)do Begin
   Readln(Handle,Regel);
   Tmp:=Left(Regel,Pos(' ',Regel)-1);
   Data.FileName:=Tmp;
   If StrUp(Tmp)=StrUp(Path2NoDir(Name))Then Begin
    FileFound:=True;
    If Descript<>''Then Begin
     Data.FileName:=Path2NoDir(Tmp);
     Data.Str:=Descript;
    End;
   End
    Else
   Begin
    Data.FileName:=Path2NoDir(Tmp);
    If Regel<>''Then Tmp:=Copy(Regel,Pos(' ',Regel)+1,Length(Regel))
                Else Tmp:='';
    Data.Str:=Tmp;
   End;
   If Descript<>''Then ALAddBlock(Lst,SizeOf(FileRec),Data);
  End;
  If(Not FileFound)and(Descript<>'')Then Begin
   Data.FileName:=StrDn(Path2NoDir(Name));
   Data.Str:=Descript;
   ALAddBlock(Lst,SizeOf(FileRec),Data);
  End;
  System.Close(Handle); {Fermeture du fichier}
 End;

 Function WriteInfo:Boolean;
 Var
  Handle:Hdl;
  S:String;
  PF:^FileRec;
  I:Word;
 Begin
  WriteInfo:=True;
  S:=GetDescriptPath(Name);
  If FileExist(S)Then Begin
   FileSetAttr(S,faArchive);
   DeleteFile(S);
  End;
  If Lst.Count>0Then Begin
   Handle:=New_(S,faHidden+faArchive);
   If(Handle=errHdl)Then Begin
    WriteInfo:=False;
    Exit;
   End;
   ALSetPtr(Lst,0);
   For I:=0to Lst.Count-1do Begin
    PF:=_ALGetCurrBuf(Lst);
    PutFileTxtLn(Handle,PF^.FileName+' '+PF^.Str);
    ALNext(Lst);
   End;
   FileClose(Handle);
  End;
 End;

 Procedure MakeFile;
 Var
  Handle:Hdl;
  Path:String;
 Begin
  Path:=GetDescriptPath(Name);
  Handle:=New_(Path,faHidden+faArchive);
  If(Handle<>errHdl)Then Begin
   PutFileTxtLn(Handle,StrDn(Path2NoDir(Name))+' '+Descript);
   FileClose(Handle);
   SetDescription:=True;
  End;
 End;

Begin
 SetDescription:=False;
 If(Name='')or(Descript='')Then Exit;
 If Not FileExist(GetDescriptPath(Name))Then MakeFile
  Else
 Begin
  ALInit(Lst);
  FullName:=GetDescriptPath(Name);
  FileSetAttr(FullName,faArchive); { Sous Windows 95 et 98 indispensable... }
  Assign(Handle,FullName);
  SetTextBuf(Handle,IOBuf);
  ReadInfo;
  SetDescription:=WriteInfo;
  FileSetAttr(FullName,faHidden+faArchive); { Sous Windows 95 et 98 indispensable... }
  ALDone(Lst);
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Fonction SetEnv                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure  permet  d'ajouter  des variables  d'environnement
 temporairement au programme ou de les modifiers si l'espace m‚moire
 n‚cessaire est disponible.
}

Procedure SetEnv{EnvVar,Value:String};
Var
 Link,PrevLink,EnvirP:Word;
 Size,Scan,Where,Dif:Integer;
 NewVar,OldVar,Test:String;

 Function CheckSpace(Wanted:Integer):Boolean;Begin
  If(Wanted+Scan>Size)Then InOutRes:=8;
  CheckSpace:=InOutRes=0
 End;

Begin
 {$IFDEF Win32}
 {$ELSE}
  If InOutRes>0Then Exit;
  For Scan:=1to Length(EnvVar)do EnvVar[Scan]:=UpCase(EnvVar[Scan]);
  AddStr(EnvVar,'=');
  NewVar:=EnvVar+Value+#0;
  Link:=PrefixSeg;
  Repeat
   PrevLink:=Link;
   Link:=MemW[Link:$16]
  Until Link=PrevLink;
  EnvirP:=MemW[Link:$2C];
  Size:=MemW[Envirp-1:$03]shl 4;
  Scan:=0;Where:=-1;
  While Mem[EnvirP:Scan]<>0do Begin
   MoveLeft(Mem[EnvirP:Scan],Test[1],255);
   Test[0]:=#255;
   Test[0]:=Chr(Pos(#0,Test));
   If Pos(EnvVar,Test)=1Then Begin
    Where:=Scan;
    OldVar:=Test
   End;
   Inc(Scan,Length(Test));
  End;
  If Where=-1Then Begin
   Where:=Scan;
   AddStr(NewVar,#0#0#0);
   If Not CheckSpace(Length(NewVar))Then Exit
  End
   Else
  Begin
   Dif:=Length(NewVar)-Length(OldVar);
   If Dif>0Then Begin
    If Not CheckSpace(Dif)Then Exit;
    MoveLeft(Mem[EnvirP:Where],Mem[EnvirP:Where+Dif],Scan-Where+3)
   End
    Else
   If Dif<0Then MoveLeft(Mem[EnvirP:Where-Dif],Mem[EnvirP:Where],Size-Where+Dif)
  End;
  MoveLeft(NewVar[1],Mem[EnvirP:Where],Length(NewVar))
 {$ENDIF} 
End;

Type
 PFreeRec=^TFreeRec;      {  De la page 216 du guide ®TP6 programmer's¯. }
 TFreeRec=Record
  Next:PFreeRec;
  Size:Pointer;
 End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                             Proc‚dure PointerSwap                    Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'effectuer l'‚change entre les adresses de deux
 pointeurs.
}

Procedure PointerSwap(Var A,B:Pointer);
Var
 Temp:Pointer; { Variable temporaire pour le transfert des variables }
Begin
 Temp:=A;
 A:=B;
 B:=Temp;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure AllocateUMBHeap                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'ajouter des blocs de m‚moire de l'UMB dans le tas
 d‚ja existant de l'application.
}

{$IFNDEF NotReal}
Procedure AllocateUMBHeap;
Var
 i,j:Word;         { Compteur de boucle }
 UMBStrategy,      { Strat‚gie d'allocation des blocs de m‚moire UMB }
 DOSStrategy,      { Strat‚gie d'allocation des blocs de m‚moire DOS }
 Segment,Size:Word;{ Segment et taille }
 GetDirect:Boolean;{ Demande UMB direct de l'XMS si vrai, autrement de DOS }
Begin
 NumBlocks:=0;
 For i:=1to(MaxBlocks)do Begin
  BlockAddress[i]:=NIL;
  BlockSize[i]:=NIL;
 End;
 ASM
  MOV AX,5800h
  INT 21h
  MOV DOSStrategy,AX
  MOV AX,5802h
  INT 21h
  MOV UMBStrategy,AX
  MOV AX,5801h
  XOR BX,BX
  INT 21h
  MOV AX,5803h
  MOV BX,0001h
  INT 21h
 END;
 GetDirect:=True;
 For i:=1to(MaxBlocks)do Begin
  Segment:=0;
  Size:=0;
  If(GetDirect)Then Begin
   ASM
@Begin:
    MOV AX,01000h
    MOV DX,0FFFFh
    PUSH DS
     MOV CX,DS
     MOV ES,CX
     CALL ES:XMMCtrl
     CMP DX,100h
     JL @End
     MOV AX,01000h
     CALL ES:XMMCtrl
     CMP AX,1
     JNE @End
     CMP BX,0A000h
     JL @End
     MOV Segment,BX
     MOV Size,DX
@End:
    POP DS
   END;
   if(i=1)and(Size=0)Then GetDirect:=False;
  End;
  If Not(GetDirect)Then Begin
   ASM
@Begin:
    MOV AX,4800h
    MOV BX,0FFFFh
    INT 21h
    CMP BX,100h
    JL @End
    MOV AX,4800h
    INT 21h
    JC @End
    CMP AX,0A000h
    JL @End
    MOV Segment,AX
    MOV Size,BX
@End:
   END;
  End;
  If Segment>0Then Begin
   BlockAddress[i]:=Ptr(Segment,0);
   Inc(NumBlocks);
  End;
  BlockSize[i]:=Ptr(Size,0);
 End;
 If NumBlocks>0Then Begin
  For i:=1to NumBlocks-1do For j:=i+1to(NumBlocks)do
   If Seg(BlockAddress[i]^)>Seg(BlockAddress[j]^)Then Begin
    PointerSwap(BlockAddress[i],BlockAddress[j]);
    PointerSwap(BlockSize[i],BlockSize[j]);
   End;
 End;
 ASM
  MOV AX,5803h
  MOV BX,UMBStrategy
  INT 21h
  MOV AX,5801h
  MOV BX,DOSStrategy
  INT 21h
 END;
End;
{$ENDIF}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure ReleaseUMB                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de lib‚rer les blocs de m‚moires UMB pr‚c‚damment
 allou‚e par cette unit‚.
}

{$IFNDEF NotReal}
 Procedure ReleaseUMB;Far;Var i,Segment:Word;Begin
  If NumBlocks>0Then Begin
   ASM
    MOV AX,5803h
    XOR BX,BX
    INT 21h
   END;
   For i:=1to(NumBlocks)do Begin
    Segment:=Seg(BlockAddress[i]^);
    If Segment>0Then ASM
     MOV AX,04901h
     MOV BX,Segment
     MOV ES,BX
     INT 21h
    END;
   End;
  End;
 End;
{$ENDIF}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Proc‚dure ExtendHeap                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'ajouter au tas (Heap) les blocs de m‚moires
 disponibles situ‚e dans la partie des UMB.
}

{$IFNDEF NotReal}
 Procedure ExtendHeap;Var i:Word;Temp:PFreeRec;Begin
  If(XMSExist)Then Begin
   AllocateUMBHeap;
   If(UMBHeapDebug)Then ReleaseUMB;
   If NumBlocks>0Then Begin
    RealHeapEnd:=HeapEnd;RealHeapPtr:=HeapPtr;
    For i:=1to(NumBlocks)do PFreeRec(BlockAddress[i])^.Size:=BlockSize[i];
    For i:=1to(NumBlocks)do PFreeRec(BlockAddress[i])^.Next:=BlockAddress[i+1];
    PFreeRec(BlockAddress[NumBlocks])^.Next:=NIL;
    If(FreeList=HeapPtr)Then With PFreeRec(FreeList)^do Begin
     Next:=BlockAddress[1];
     Size:=Ptr(Seg(HeapEnd^)-Seg(HeapPtr^),0);
    End
     else
    With PFreeRec(HeapPtr)^do Begin
     Next:=BlockAddress[1];
     Size:=Ptr(Seg(HeapEnd^)-Seg(HeapPtr^),0);
    End;
    HeapPtr:=BlockAddress[NumBlocks];
    HeapEnd:=Ptr(Seg(BlockAddress[NumBlocks]^)+Seg(BlockSize[NumBlocks]^),0);
   End;
  End;
 End;
{$ENDIF}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Proc‚dure ExtendHeap                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de lib‚rer les blocs de m‚moire UMB inclus au tas
 (Heap) de l'application.
}

{$IFNDEF NotReal}
 Procedure DoneExtendHeap;Begin
  If NumBlocks>0Then Begin
   UMBHeapDebug:=False;
   NumBlocks:=0;
   ReleaseUMB;
  End;
 End;
{$ENDIF}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Proc‚dure FreeMaxExtendHeap                   Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de lib‚rer la m‚moire allou‚e par le DOS du tas
 malgr‚ l'ambiguit‚ des blocs UMB.
}

{$IFNDEF NotReal}
 Procedure FreeMaxHeapExtend;Begin
  If(RealHeapPtr=NIL)or(RealHeapEnd=NIL)Then FreeMaxHeap
   Else
  Begin
   PointerSwap(HeapPtr,RealHeapPtr);
   PointerSwap(HeapEnd,RealHeapEnd);
   FreeMaxHeap;
   PointerSwap(HeapPtr,RealHeapPtr);
   PointerSwap(HeapEnd,RealHeapEnd);
  End;
 End;
{$ENDIF}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Fonction SizeOfUMB                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Portabilit‚: Global


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de retourner la taille des blocs de m‚moire
 attribu‚ … l'allocation de m‚moire UMB.
}

{$IFNDEF __Windows__}
 Function SizeOfUMB:LongInt;
 Var
  Size:LongInt;
  I:Byte;
 Begin
  Size:=0;
  For I:=1to(SysPlus.NumBlocks)do Begin
   Size:=LongInt(LongInt(LongInt(PtrRec(BlockSize[I]).Seg) shl 4)+
                 LongInt(PtrRec(BlockSize[I]).Ofs));
  End;
  SizeOfUMB:=Size;
 End;
{$ENDIF}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Fonction OS2Exec                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Portabilit‚: Global
 Sp‚cialit‚:  OS/2


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet d'ex‚cuter une session d'application OS/2.
}

Function OS2Exec{Const Data:OS2StartData):Word};Assembler;ASM
 {$IFDEF Win32}
 {$ELSE}
  PUSH DS
   LDS SI,Data
   MOV AH,064h
   MOV BX,0025h
   MOV CX,636Ch
   INT 21h
  POP DS
 {$ENDIF}
END;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                      Proc‚dure OS2SetTitle                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Portabilit‚: Global
 Sp‚cialit‚:  OS/2


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de sp‚cifier le nouveau nom que doit avoir
 l'application actuel sous une session d'OS/2.


 Remarques
 ÍÍÍÍÍÍÍÍÍ

  ş Cette proc‚dure  requŠre  naturellement de  fonctionner sous le
    systŠme d'exploitation  d'OS/2  sans cela elle aura aucun effet
    peut peut-ˆtre cr‚er un plantage sous un systŠme d'exploitation
    DOS compatible mal cod‚.

  ş Le  nombre  maximal  de  caractŠres support‚e  comme  titre est
    malheureusement que 13 caractŠres.

  ş Il est possible de  restitu‚e le nom  original en envoyant tout
    simplement une chaŒne de caractŠres vide.
}

Procedure OS2SetTitle{Name:PChar};Assembler;ASM
 {$IFDEF Win32}
 {$ELSE}
  MOV AH,64h
  MOV DX,0001h
  MOV CX,636Ch
  MOV BX,0000h
  LES DI,Name
  INT 21h
 {$ENDIF}
END;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                      Fonction Win95SetTitle                   Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Portabilit‚: Global
 Sp‚cialit‚:  Windows 95 et 98


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de sp‚cifier le nouveau nom que doit avoir
 l'application actuel sous une session DOS de Windows 95 ou 98.
}

Function Win95SetTitle{Name:PChar):Bool};Assembler;ASM
 {$IFDEF Win32}
 {$ELSE}
  MOV AX,168Eh
  XOR DX,DX
  LES DI,Name
  INT 2Fh
 {$ENDIF}
END;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                    Fonction ClipboardFunctionsAvailable             Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Portabilit‚: Global
 Sp‚cialit‚:  Windows 95 et 98


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction indique si les outils du presse-papier sont disponibles
 pour application DOS.
}

Function ClipboardFunctionsAvailable{:Bool};Assembler;ASM
 MOV AX,1700h
 INT 2Fh
 XOR BL,BL
 CMP AX,1700h
 JE  @1
 MOV BL,1
@1:
 XCHG AX,BX
END;

Function ClipboardCompact{(lDesired:Long):Long};Assembler;ASM
 {$IFDEF Win32}
 {$ELSE}
  MOV AX,1709h
  LES CX,lDesired
  MOV SI,ES
  INT 2Fh
 {$ENDIF}
END;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Fonction CloseClipboard                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Portabilit‚: Global
 Sp‚cialit‚:  Windows 95 et 98


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet d'effectuer la fermeture (terminaison du processus
 de lecture) du presse-papier pr‚c‚dement pr‚parer par ®OpenClipboard¯.
}

Function CloseClipboard{:Bool};Assembler;ASM
 {$IFDEF Win32}
 {$ELSE}
  MOV AX,1708h
  INT 2Fh
  OR  AX,AX
  JE  @End
  MOV AL,1
@End:
 {$ENDIF}
END;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Fonction EmptyClipboard                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Portabilit‚: Global
 Sp‚cialit‚:  Windows 95 et 98


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de savoir si le presse-papier est actuellement
 vide et sans aucun contenu.
}

Function EmptyClipboard{:Bool};Assembler;ASM
 {$IFDEF Win32}
 {$ELSE}
  MOV AX,1702h
  INT 2Fh
  OR  AX,AX
  JE  @End
  MOV AL,1
@End:
 {$ENDIF}
END;

Function GetClipboardDataSize{wFormat:Word):Long};Assembler;ASM
 MOV AX,1704h
 MOV DX,wFormat
 INT 2Fh
END;

Function GetClipboardData{wFormat:Word;DataPtr:Pointer):Bool};Assembler;ASM
 {$IFDEF Win32}
 {$ELSE}
  MOV AX,1705h
  MOV DX,wFormat
  LES BX,DataPtr
  INT 2Fh
  OR  AX,AX
  JE  @End
  MOV AL,1
@End:
 {$ENDIF}
END;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                      Fonction OpenClipboard                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Portabilit‚: Global
 Sp‚cialit‚:  Windows 95 et 98


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet d'effectuer l'ouverture du presse-papier afin
 d'‚ventuellement lire le contenu de celui-ci.
}

Function OpenClipboard{:Bool};Assembler;ASM
 MOV AX,1701h
 INT 2Fh
 OR  AX,AX
 JE  @End
 MOV AL,1
@End:
END;

Function SetClipboardData{wFormat:Word;DataPtr:Pointer;lSize:Long):Bool};Begin
 SetClipboardData:=False;
 If(DataPtr<>Nil)and(lSize<>0)and(ClipboardCompact(lSize)>=lSize)Then Begin
  ASM
   MOV AX,1703h
   MOV DX,wFormat
   LES CX,lSize
   MOV SI,ES
   LES BX,DataPtr
   INT 2Fh
   OR  AX,AX
   JE  @End
   MOV AL,1
@End:
   MOV @Result,AL
  END;
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Fonction RBLoadFileASCII                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Portabilit‚: Global


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de charger dans une liste sym‚trique le contenu d'un
 fichier de format ASCII.
}

Function ALLoadFileASCII(Var L:ArrayList;Const FileName:String):Boolean;
Var
 Handle:Hdl;
 FP,FS:LongInt;
 Buffer:Array[0..2047]of Byte;
 S:String Absolute Buffer;
 Len:Word;
Begin
 ALLoadFileASCII:=False;
 ALInit(L);
 Handle:=FileOpen(FileName,fmRead);
 If(Handle<>errHdl)Then Begin
  FP:=0;FS:=FileSize(Handle);
  Repeat
   __GetAbsFileTxtLn(Handle,FP,S);
   If SysErr<>0Then Begin
    FileClose(Handle);
    Exit;
   End;
   If Length(S)=255Then Begin
    Dec(FP,LongInt(255));
    SetFilePos(Handle,FP);
    Len:=_GetFilePTxtLn(Handle,PChr(@Buffer),SizeOf(Buffer));
    Inc(FP,LongInt(Len));
    ALAddBlock(L,Len,Buffer);
   End
    Else
   ALAddStr(L,S);
  Until FP>=FS;
  FileClose(Handle);
  ALLoadFileASCII:=True;
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Fonction ALSaveFileASCII                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Portabilit‚: Global


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de sauvegarder le contenu d'une liste sym‚trique
 d'allocation dynamique dans un fichier de format ASCII.
}

Function ALSaveFileASCII(Var L:ArrayList;Const FileName:String;Backup:Boolean):Boolean;
Var
 I:RBP;
 Handle:Hdl;
 PC:PChr;
Begin
 ALSaveFileASCII:=False;
 If(Backup)Then Handle:=FileCreateAndBackup(FileName)
           Else Handle:=FileCreate(FileName);
 If(Handle<>errHdl)Then Begin
  ALSetPtr(L,0);
  If L.Count>0Then For I:=0to L.Count-1do Begin
   PC:=_ALGetCurrBuf(L);
   If Not IsPChrEmpty(PC)Then Begin
    _SetRec(Handle,StrLen(PC),PC^);
   End;
   PutFileLn(Handle);
   ALNext(L);
  End;
  FileClose(Handle);
  ALSaveFileASCII:=True;
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Fonction ALTri                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Portabilit‚: Global


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de trier une liste sym‚trique d'allocation
 dynamique de m‚moire en ordre alphab‚tique.
}

Procedure ALTri(Var L:ArrayList);
Var
 tE,tI,tJ,tK,tM,tX:Integer;
 PtrI,PtrM:PChr;
Begin
 Repeat
  ASM SHR tE,1;END;
  tJ:=0;
  tK:=L.Count-1-tE;
  Repeat
   tI:=tJ;
   Repeat
    tM:=tI+tE;
    PtrI:=_ALGetBuf(L,tI);
    PtrM:=_ALGetBuf(L,tM);
    If Not(StrComp(PtrI,PtrM)>0)Then Break;
    ALXchgBuf(L,tI,tM);
    Dec(tI,tE);
   Until tI<0;
   Inc(tJ);
  Until tJ>tK;
 Until tE=1;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Fonction TimeString                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Portabilit‚: Global


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction retourne l'heure sous forme d'une chaŒne de caractŠres
 contenant … la fin un indicatif AM ou PM.
}

Function TimeString{TimerValue:Long;TimerFormat:TimeType):String};
Var
 Hours:Byte;SaveHrs,SaveH:LongInt;
 Minutes,Seconds:Integer;
 S:String[3];
 Sx:String;
Begin
 Hours:=DivLong(TimerValue,3600);
 SaveHrs:=Hours;
 SaveH:=TimerValue-SaveHrs*3600;
 Minutes:=DivLong(SaveH,60);
 Seconds:=SaveH-Minutes*60;
 Sx:=CStrTimeDos(Hours,Minutes,Seconds);
 If(TimerFormat=AmPm)Then Begin
  If Hours<12Then Begin
   S:='am';
   If Hours=0Then Hours:=12
  End
   Else
  Begin
   S:='pm';
   If Hours<>12Then Dec(Hours,12)
  End;
  AddStr(Sx,S);
 End;
 TimeString:=Sx
End;

{$I Library\System\Dos\GetBootD.Inc}

Procedure GetCyrix6x86Config(Var Q:Cyrix6x86Config);Assembler;ASM
 {$IFDEF FLAT386}
  LEA EDI,DWord Ptr Q
  MOV AL,0C1h
  OUT 22h,AL
  IN  AL,23h
  SHR AL,4
  AND AL,1
  MOV [EDI].Cyrix6x86Config.NegateLock,AL
  MOV AL,0C2h
  OUT 22h,AL
  IN  AL,23h
  SHR AL,1
  MOV BL,AL
  AND BL,1
  MOV [EDI].Cyrix6x86Config.WriteBackCache,BL
  SHR AL,2
  AND AL,1
  MOV [EDI].Cyrix6x86Config.SuspendOnHALT,AL
  MOV AL,0C3h { CCR3 }
  OUT 22h,AL
  IN  AL,23h
  SHR AL,2
  AND AL,1
  MOV [EDI].Cyrix6x86Config.FastFrameBuffer,AL
  MOV AL,0E8h { CCR4 }
  OUT 22h,AL
  IN  AL,23h
  MOV BL,AL
  ROL BL,1
  AND BL,1
  MOV [EDI].Cyrix6x86Config.CPUID,BL
  SHR AL,4
  AND AL,1
  MOV [EDI].Cyrix6x86Config.CachedDirectoryTableEntry,AL
  MOV AL,0E9h { CCR5 }
  OUT 22h,AL
  IN  AL,23h
  MOV BL,AL
  AND AL,1
  MOV [EDI].Cyrix6x86Config.WriteAllocate,AL
  SHR BL,1
  AND BL,1
  XOR BL,1
  MOV [EDI].Cyrix6x86Config.FastLoop,AL
 {$ELSE}
  LES DI,Q
  MOV AL,0C1h
  OUT 22h,AL
  IN  AL,23h
  {$IFOPT G+}
   SHR AL,4
  {$ELSE}
   SHR AL,1
   SHR AL,1
   SHR AL,1
   SHR AL,1
  {$ENDIF}
  AND AL,1
  MOV ES:[DI].Cyrix6x86Config.NegateLock,AL
  MOV AL,0C2h
  OUT 22h,AL
  IN  AL,23h
  SHR AL,1
  MOV BL,AL
  AND BL,1
  MOV ES:[DI].Cyrix6x86Config.WriteBackCache,BL
  {$IFOPT G+}
   SHR AL,2
  {$ELSE}
   SHR AL,1
   SHR AL,1
  {$ENDIF}
  AND AL,1
  MOV ES:[DI].Cyrix6x86Config.SuspendOnHALT,AL
  MOV AL,0C3h { CCR3 }
  OUT 22h,AL
  IN  AL,23h
  {$IFOPT G+}
   SHR AL,2
  {$ELSE}
   SHR AL,1
   SHR AL,1
  {$ENDIF}
  AND AL,1
  MOV ES:[DI].Cyrix6x86Config.FastFrameBuffer,AL
  MOV AL,0E8h { CCR4 }
  OUT 22h,AL
  IN  AL,23h
  MOV BL,AL
  ROL BL,1
  AND BL,1
  MOV ES:[DI].Cyrix6x86Config.CPUID,BL
  {$IFOPT G+}
   SHR AL,4
  {$ELSE}
   SHR AL,1
   SHR AL,1
   SHR AL,1
   SHR AL,1
  {$ENDIF}
  AND AL,1
  MOV ES:[DI].Cyrix6x86Config.CachedDirectoryTableEntry,AL
  MOV AL,0E9h { CCR5 }
  OUT 22h,AL
  IN  AL,23h
  MOV BL,AL
  AND AL,1
  MOV ES:[DI].Cyrix6x86Config.WriteAllocate,AL
  SHR BL,1
  AND BL,1
  XOR BL,1
  MOV ES:[DI].Cyrix6x86Config.FastLoop,AL
 {$ENDIF}
END;

Procedure SetCyrix6x86Config(Var Q:Cyrix6x86Config);Assembler;ASM
 {$IFDEF FLAT386}
  LEA  EDI,DWord Ptr Q
  MOV  DX,0022h { Port de contr“le de configuration }
  MOV  AL,0C3h  { Registres de contr“le de configuration CCR3 }
  OUT  DX,AL
  INC  DX
  IN   AL,DX
  MOV  CL,AL    { Sauvegarde dans CL la valeur CCR3 }
   { Fixe les bits 4 … 7 du registre CCR3 … 1 pour autoriser une modification }
  AND  AL,0Fh
  OR   AL,010h
  XCHG AL,AH
  DEC  DX
  MOV  AL,0C3h  { Registre CCR3 }
  OUT  DX,AL
  INC  DX
  XCHG AL,AH
  OUT  DX,AL
  DEC  DX
  MOV  AL,0E8h
  OUT  DX,AL
  INC  DX
  IN   AL,DX
   { Ajuste le 7 bits du registre … la valeur de ®X¯ }
  MOV  CH,[EDI].Cyrix6x86Config.CPUID
  MOV  CPUID,CH
  CMP  CH,True
  JE   @2
  AND  AL,LOW(NOT 80h)
  JMP  @3
 @2:
  OR   AL,80h
 @3:
  XCHG AL,AH
  DEC  DX
  MOV  AL,0E8h
  OUT  DX,AL
  INC  DX
  XCHG AL,AH
  OUT  DX,AL
  DEC  DX
   { Restitution de la valeur original du CCR3 }
  MOV  AL,0C3h  { Registre CCR3 }
  OUT  DX,AL
  INC  DX
  MOV  AL,CL
  OUT  DX,AL
 {$ELSE}
  LES  DI,Q
  MOV  DX,0022h { Port de contr“le de configuration }
  MOV  AL,0C3h  { Registres de contr“le de configuration CCR3 }
  OUT  DX,AL
  INC  DX
  IN   AL,DX
  MOV  CL,AL    { Sauvegarde dans CL la valeur CCR3 }
   { Fixe les bits 4 … 7 du registre CCR3 … 1 pour autoriser une modification }
  AND  AL,0Fh
  OR   AL,010h
  XCHG AL,AH
  DEC  DX
  MOV  AL,0C3h  { Registre CCR3 }
  OUT  DX,AL
  INC  DX
  XCHG AL,AH
  OUT  DX,AL
  DEC  DX
  MOV  AL,0E8h
  OUT  DX,AL
  INC  DX
  IN   AL,DX
   { Ajuste le 7 bits du registre … la valeur de ®X¯ }
  MOV  CH,ES:[DI].Cyrix6x86Config.CPUID
  MOV  CPUID,CH
  CMP  CH,True
  JE   @2
  AND  AL,LOW(NOT 80h)
  JMP  @3
 @2:
  OR   AL,80h
 @3:
  XCHG AL,AH
  DEC  DX
  MOV  AL,0E8h
  OUT  DX,AL
  INC  DX
  XCHG AL,AH
  OUT  DX,AL
  DEC  DX
   { Restitution de la valeur original du CCR3 }
  MOV  AL,0C3h  { Registre CCR3 }
  OUT  DX,AL
  INC  DX
  MOV  AL,CL
  OUT  DX,AL
 {$ENDIF}
END;

Function MountVolume{Const FileName:String;Drv:Char):Bool};Var Dsk:Byte;Begin
 MountVolume:=False;
 Dsk:=Drv2Dsk(Drv);
 If(Dsk=0)or(Dsk>26)Then Exit;
 Dec(Dsk);
 If(DriveMount[Dsk]<>NIL)Then StrDispose(DriveMount[Dsk]);
 DriveMount[Dsk]:=Str2PChr(FileName);
 DriveFormat[Dsk]:=dfiMount;
 MountVolume:=True;
End;

Function DskMount{Dsk:Byte):Bool};Begin
 DskMount:=DriveFormat[Dsk]=dfiMount;
End;

Procedure LoadPathVolume{Var Q:BF;Dsk:Byte;Var NmF:Wd;Const Path:String;At:Wd};Begin
 LoadPathByFileImage(Q,StrPas(DriveMount[Dsk]),NmF,Path,At);
End;

{ Cette fonction permet de d‚terminer la pr‚sence de contr“leur SCSI
 utilis‚ pour les unit‚s de disque.
}

Function SCSIExist:Boolean;Assembler;ASM
 XOR CX,CX
 MOV ES,CX
 MOV CL,ES:[0475h]
@1:
 PUSH CX
  MOV AL,18h
  MOV DL,80h
  ADD DL,CL
  DEC DL
  STC
  INT 13h
 POP CX
 MOV AL,True
 JNC @End
 LOOP @1
 MOV AL,False
@End:
END;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
END.