{ Cette unit‚ contient les routines de manipulation de la base de registres
 de format ®XOKY¯ g‚rer par le MonsterBook.
}

Unit Registry;

INTERFACE

{$I DEF.INC}

Uses Systex,Restex;

Const

 HKEY_CLASSES_ROOT=0;        { Les registres HKEY_CLASSES_ROOT }
 HKEY_CURRENT_USER=1;        { Les registres HKEY_CURRENT_USER }
 HKEY_LOCAL_MACHINE=2;       { Les registres HKEY_LOCAL_MACHINE }
 HKEY_USERS=3;               { Les registres HKEY_USERS }
 HKEY_PERFORMANCE_DATA=4;    { Les registres HKEY_PERFORMANCE_DATA }
 HKEY_CURRENT_CONFIG=5;      { Les registres HKEY_CURRENT_CONFIG }
 HKEY_DYN_DATA=6;            { Les registres HKEY_DYN_DATA }
 HKEY_SYSTEM=7;              { Les registres HKEY_SYSTEM (du MonsterBook) }
 HKEY_DEVELOPPER=8;          { Les registres HKEY_DEVELOPPER (associ‚ au d‚veloppeur) }
 HKEY_WEB=9;                 { Les registres de r‚pertoires Web }
 HKEY_FileDOS=10;            { Les registres de fichiers de format DOS }
 HKEY_FileUnix=11;           { Les registres de fichiers de format Unix }
 HKEY_FileVAX=12;            { Les registres de fichiers de format VAX/Alpha }
 HKEY_FileMAC=13;            { Les registres de fichiers de format Macintosh }
 HKEY_FileMOS=14;            { Les registres de fichiers de format MOS }

Type
 DateRegistry=Record
  Year:LongInt;       { Ann‚e }
  Month:Byte;         { Mois }
  Day:Byte;           { Jour }
  Hour:Byte;          { Heure }
  Minute:Byte;        { Minute }
  Seconde:Byte;       { Seconde }
 End;

 HeaderRegistryRec=Record
  Sign:Array[0..7]of Char;   { Signature: XOKYREG#26 }
  HKEY:Record Case Byte Of
   0:(
    CLASSES_ROOT:LongInt;    { Pointeur sur les registres HKEY_CLASSES_ROOT }
    CURRENT_USER:LongInt;    { Pointeur sur les registres HKEY_CURRENT_USER }
    LOCAL_MACHINE:LongInt;   { Pointeur sur les registres HKEY_LOCAL_MACHINE }
    USERS:LongInt;           { Pointeur sur les registres HKEY_USERS }
    PERFORMANCE_DATA:LongInt;{ Pointeur sur les registres HKEY_PERFORMANCE_DATA }
    CURRENT_CONFIG:LongInt;  { Pointeur sur les registres HKEY_CURRENT_CONFIG }
    DYN_DATA:LongInt;        { Pointeur sur les registres HKEY_DYN_DATA }
    SYSTEM:LongInt;          { Pointeur sur les registres HKEY_SYSTEM (du MonsterBook) }
    DEVELOPPER:LongInt;      { Pointeur sur les registres HKEY_DEVELOPPER }
   );
   1:(Address:Array[0..15]of LongInt);
  End;
  SerialNumber:LongInt;      { Num‚ro de s‚rie }
  Fragment:LongInt;          { Pointeur sur les fragments }
  Color:Word;                { Couleur d'arriŠre plan en 16-bits }
  Background:LongInt;        { Pointeur sur un nom de fichier d'arriŠre plan }
  Icon:LongInt;              { Pointeur sur un ic“ne }
  NextFree:LongInt;          { Pointeur sur la prochaine zone libre }
  Size:LongInt;              { Taille de l'unit‚ }
  Free:LongInt;              { Zone libre sur l'unit‚ }
  Created:DateRegistry;      { Date de cr‚ation }
 End;

 NoeudRec=Record
  Prev:LongInt;        { Pr‚c‚dent }
  Child:LongInt;       { Enfant }
  Next:LongInt;        { Prochain }
  Parent:LongInt;      { Parent du noeud }
  TypeDef:Byte;        { Type de donn‚es }
  Color:Word;          { Couleur d'arriŠre plan en 16-bits }
  Background:LongInt;  { Pointeur sur un nom de fichier d'arriŠre plan }
  Attribut:Word;       { Attribut }
  FamilyMac:Byte;      { Famille Macintosh }
  TypeMac:LongInt;     { Type Macintosh }
  CreatorMac:LongInt;  { Cr‚ateur Macintosh }
  Created:DateRegistry;{ Date de cr‚ation}
  Modified:DateRegistry;{Date de modification}
  Len:Word;            { Longueur des donn‚es }
  Name:String;         { Nom de la cl‚ }
 End;

 RegistryObject=Record
  Handle:Hdl;               { Handle associ‚ … la base de registre }
  FileName:^String;         { Nom de la base de registres }
 End;

 SearchRegistryRec=Record
  Pos:LongInt;
  Name:String;
 End;

Function  CreateKeyFormat(RootKey:Byte;Const Path,Name:String;Format:Byte;Const Data):Boolean;
Function  MainRegistryExist:Boolean;
Function  MainRegistryPath:String;
Function  ReadMainKey(RootKey:Byte;Const Path,Name:String;Var Data):Boolean;
Procedure ROOpen(Var Q:RegistryObject;Const Path:String);
Procedure ROOpenFile(Var Q:RegistryObject);
Procedure ROOpenMain(Var Q:RegistryObject);
Function  ROCreateFile(Var Q:RegistryObject;RootKey:Byte;Const Path,Name:String):LongInt;
Function  ROGetAbsRec(Var Q:RegistryObject;Handle,FilePos:LongInt;Size:Word;Var Buffer):Word;
Function  ROSetAbsRec(Var Q:RegistryObject;Handle,FilePos:LongInt;Size:Word;Const Buffer):Boolean;
Function  ROCreateKeyFormat(Var Q:RegistryObject;RootKey:Byte;
           Path:String;Const Name:String;Format:Byte;Const Data):Boolean;
Function  ROReadKey(Var Q:RegistryObject;RootKey:Byte;
           Const Path,Name:String;Var Data):Boolean;
Function  ROFindFirst(Var Q:RegistryObject;RootKey:Byte;Const Path:String;Var Info:SearchRegistryRec):Boolean;
Function  ROFindNext(Var Q:RegistryObject;Var Info:SearchRegistryRec):Boolean;
Procedure RODone(Var Q:RegistryObject);
Function _ROReadKey(Var Q:RegistryObject;RootKey:Byte;
           Path:String;Const Name:String;Var Data;CloseFile:Boolean):Boolean;

IMPLEMENTATION

Uses Memories,Systems;

Procedure UpdateNoeudInfo(Var Q:NoeudRec);Near;
Var
 Year:Word;
 DOW:Byte;
Begin
 GetDate(Year,Q.Created.Month,Q.Created.Day,DOW);
 Q.Created.Year:=Year;
 Q.Modified:=Q.Created;
End;

Function MainRegistryExist:Boolean;Begin
 MainRegistryExist:=FileExist(MainRegistryPath);
End;

Function MainRegistryPath:String;Begin
 MainRegistryPath:=MaltePath+'MALTE.REG';
End;

Procedure ROOpenFile(Var Q:RegistryObject);
Var
 Header:HeaderRegistryRec;
Begin
 If(Q.Handle=errHdl)Then Begin
  Q.Handle:=FileOpen(Q.FileName^,fmDef);
  If(Q.Handle=errHdl)Then Begin
   Q.Handle:=FileCreate(Q.FileName^);
   If(Q.Handle<>errHdl)Then Begin
    FillClr(Header,SizeOf(Header));
    Header.Sign:='XOKYREG'#26;
    _SetAbsRec(Q.Handle,0,SizeOf(Header),Header);
   End;
  End;
 End;
End;

Procedure ROOpen(Var Q:RegistryObject;Const Path:String);
Var
 Header:HeaderRegistryRec;
Begin
 FillClr(Q,SizeOf(Q));
 Q.Handle:=errHdl;
 Q.FileName:=MemAlloc(Length(Path)+1);
 If(Q.FileName<>NIL)Then Q.FileName^:=Path;
 ROOpenFile(Q);
 FileClose(Q.Handle);
End;

Procedure ROOpenMain(Var Q:RegistryObject);Begin
 ROOpen(Q,MainRegistryPath);
End;

Procedure RODone(Var Q:RegistryObject);Begin
 If Q.Handle<>0Then FileClose(Q.Handle);
 FreeMemory(Q.FileName,Length(Q.FileName^)+1);
 FillClr(Q,SizeOf(Q));
End;

Function ROGetFreePos(Var Q:RegistryObject):LongInt;Begin
 ROGetFreePos:=FileSize(Q.Handle);
End;

Procedure ROWriteKey(Var Q:RegistryObject;Var Noeud:NoeudRec;Pos:LongInt;Format:Byte;Data:Pointer);
Var
 Size:Word;
 Str:^String Absolute Data;
 PWord:^Word Absolute Data;
 Len:Word;
 FileHeader:Record
  FileSize:LongInt;
  FirstBlock:LongInt;
 End;
Begin
 Case(Format)of
  tdBoolean,tdByte:Size:=1;
  tdBlob:Size:=PWord^;
  tdWord:Size:=SizeOf(Word);
  tdInteger:Size:=SizeOf(LongInt);
  tdSmallInt:Size:=SizeOf(Integer);
  tdVarChar:Size:=Length(Str^)+1;
  Else Size:=0;
 End;
 Noeud.TypeDef:=Format;
 Noeud.Len:=Size;
 Len:=SizeOf(NoeudRec)-SizeOf(String)+Length(Noeud.Name)+1;
 UpdateNoeudInfo(Noeud);
 _SetAbsRec(Q.Handle,Pos,Len,Noeud);
 Inc(Pos,LongInt(Len));
 If(Format=tdFile)Then Begin
  FillClr(FileHeader,SizeOf(FileHeader));
  Data:=@FileHeader;
  Size:=SizeOf(FileHeader);
 End;
 _SetAbsRec(Q.Handle,Pos,Size,Data^);
End;

Function ExtractName(Var Path:String;Update:Boolean):String;
Var
 CurrName:String;   { Nom du r‚pertoire en cours }
 I:Byte;            { Position dans le r‚pertoire }
Begin
 CurrName:='';
 For I:=1to Length(Path)do Begin
  If Path[I]in['\','/']Then Begin
   ASM INC I;END;
   Break;
  End;
  IncStr(CurrName,Path[I]);
 End;
 If(UpDate)Then Begin
  If Length(CurrName)=Length(Path)Then Path:=''
  Else Path:=Copy(Path,I,255);
 End;
 ExtractName:=CurrName;
End;

Function ROSearchDir(Var Q:RegistryObject;Var Noeud:NoeudRec;Var Pos:LongInt;Path:String;Create:Boolean):Boolean;
Var
 CurrName:String;   { Nom du r‚pertoire en cours }
 NewNoeud:NoeudRec; { Nouveau noeud }
 OldPos:LongInt;
 NextPos:LongInt;
Begin
 ROSearchDir:=True;
 If Path=''Then Exit;
 Repeat
  CurrName:=ExtractName(Path,True);
  If CurrName=''Then Break;
  Repeat
   _GetAbsRec(Q.Handle,Pos,SizeOf(Noeud),Noeud);
   OldPos:=Pos;
   If(Noeud.Name=CurrName)Then Break;
   If(Noeud.Name>CurrName)Then Pos:=Noeud.Prev
                          ELse Pos:=Noeud.Next;
  Until Pos=0;
  If(Noeud.Name<>CurrName)Then Begin
   Pos:=OldPos;
   NextPos:=ROGetFreePos(Q);
   If(Noeud.Name>CurrName)Then Noeud.Prev:=NextPos
                          Else Noeud.Next:=NextPos;
   FillClr(NewNoeud,SizeOf(NewNoeud));
   NewNoeud.Name:=CurrName;
   ROWriteKey(Q,NewNoeud,NextPos,tdDirectory,NIL);
   _SetAbsRec(Q.Handle,Pos,SizeOf(NoeudRec)-SizeOf(String),Noeud);
   Noeud:=NewNoeud;
   OldPos:=NextPos;
  End;
  Pos:=Noeud.Child;
  If Pos=0Then Begin
   Pos:=OldPos;
   If(Create)Then Begin
    Repeat
     CurrName:=ExtractName(Path,True);
     If CurrName=''Then Begin
      {Pos:=OldPos;}
      ROSearchDir:=True;
      Exit;
     End;
     Noeud.Child:=ROGetFreePos(Q);
     FillClr(NewNoeud,SizeOf(NewNoeud));
     NewNoeud.Name:=CurrName;
     NewNoeud.Parent:=Pos;
     ROWriteKey(Q,NewNoeud,Noeud.Child,tdDirectory,NIL);
     _SetAbsRec(Q.Handle,Pos,SizeOf(NoeudRec)-SizeOf(String),Noeud);
     OldPos:=Pos;
     Pos:=Noeud.Child;
     Noeud:=NewNoeud;
    Until False;
   End;
   Break;
  End;
 Until False;
 ROSearchDir:=(CurrName='')or(CurrName=Noeud.Name);
End;

Function ROKeyExist(Var Q:RegistryObject;Var Pos:LongInt;Const CurrName:String):Boolean;
Var
 Noeud:NoeudRec;
 OldPos:LongInt;
Begin
 ROKeyExist:=True;
 If Pos>0Then Begin
  Repeat
   _GetAbsRec(Q.Handle,Pos,SizeOf(Noeud),Noeud);
   If(Noeud.Name=CurrName)Then Exit;
   OldPos:=Pos;
   If(Noeud.Name>CurrName)Then Pos:=Noeud.Prev
                          Else Pos:=Noeud.Next;
  Until Pos=0;
  Pos:=OldPos;
 End;
 ROKeyExist:=False;
End;

Procedure ROKillKey(Var Q:RegistryObject;RootKey:Byte;Const Noeud:NoeudRec);Near;
Var
 Header:HeaderRegistryRec;
 PrevNoeud,NextNoeud,ParentNoeud:NoeudRec;
Begin
 _GetAbsRec(Q.Handle,Noeud.Prev,SizeOf(NoeudRec),PrevNoeud);
 _GetAbsRec(Q.Handle,Noeud.Next,SizeOf(NoeudRec),NextNoeud);
 _GetAbsRec(Q.Handle,Noeud.Parent,SizeOf(NoeudRec),ParentNoeud);
 PrevNoeud.Next:=Noeud.Next;
 NextNoeud.Prev:=Noeud.Prev;
 If Noeud.Next=0Then ParentNoeud.Child:=Noeud.Prev
                Else ParentNoeud.Child:=Noeud.Next;
 If Noeud.Prev<>0Then _SetAbsRec(Q.Handle,Noeud.Prev,SizeOf(NoeudRec),PrevNoeud);
 If Noeud.Next<>0Then _SetAbsRec(Q.Handle,Noeud.Next,SizeOf(NoeudRec),NextNoeud);
 If Noeud.Parent<>0Then _SetAbsRec(Q.Handle,Noeud.Parent,SizeOf(NoeudRec),ParentNoeud)
  Else
 Begin
  Header.HKEY.Address[RootKey]:=ParentNoeud.Child;
  _SetAbsRec(Q.Handle,0,SizeOf(Header),Header);
 End;
End;

Function ROCreateKeyFormat(Var Q:RegistryObject;RootKey:Byte;Path:String;Const Name:String;Format:Byte;Const Data):Boolean;
Label Restart,Default,WriteData,Finish;
Var
 Header:HeaderRegistryRec;
 CurrPos,Pos:LongInt;
 Noeud,NewNoeud:NoeudRec;
 Simple:Boolean;
 DataPos:^LongInt Absolute Data;
 Str:^String Absolute Data;
Begin
 ROCreateKeyFormat:=False;
 If RootKey>15Then Exit;
 ROOpenFile(Q);
Restart:
 _GetAbsRec(Q.Handle,0,SizeOf(Header),Header);
 CurrPos:=Header.HKEY.Address[RootKey];
 FillClr(Noeud,SizeOf(Noeud));
 If CurrPos=0Then Begin { Premier du r‚pertoire racine? }
  Simple:=Path='';
  CurrPos:=ROGetFreePos(Q);
  If Not(Simple)Then Begin
   Noeud.Name:=ExtractName(Path,False);
   ROWriteKey(Q,Noeud,CurrPos,tdDirectory,NIL);
  End
   Else
  Begin
   Noeud.Name:=Name;
   ROWriteKey(Q,Noeud,CurrPos,Format,@Data);
  End;
  Header.HKEY.Address[RootKey]:=CurrPos;
  _SetAbsRec(Q.Handle,0,SizeOf(Header),Header);
  If(Simple)Then Goto Finish;
 End;
 If ROSearchDir(Q,Noeud,CurrPos,Path,True)and(Name<>'')Then Begin
  If Noeud.Child=0Then Begin
   Noeud.Child:=ROGetFreePos(Q);
   Pos:=Noeud.Child;
   Goto WriteData;
  End
   Else
  Begin
   Pos:=Noeud.Child;
   If Not ROKeyExist(Q,Pos,Name)Then Begin
    _GetAbsRec(Q.Handle,Pos,SizeOf(Noeud),Noeud);
    Pos:=ROGetFreePos(Q);
    If(Noeud.Name>Name)Then Noeud.Prev:=Pos
                       Else Noeud.Next:=Pos;
WriteData:
    FillClr(NewNoeud,SizeOf(NewNoeud));
    NewNoeud.Name:=Name;
    ROWriteKey(Q,NewNoeud,Pos,Format,@Data);
    If(Format=tdFile)Then DataPos^:=Pos;
    _SetAbsRec(Q.Handle,CurrPos,SizeOf(NoeudRec)-SizeOf(String),Noeud);
   End
    Else
   Begin { Existe d‚j… ... }
    _GetAbsRec(Q.Handle,Pos,SizeOf(Noeud),Noeud);
    Case(Format)of
     tdFile:DataPos^:=Pos;
     tdVarChar:If Noeud.Len>Length(Str^)+1Then Begin
      ROKillKey(Q,RootKey,Noeud);
      Goto Restart;
     End
      Else
     Goto Default;
     Else Default:ROWriteKey(Q,Noeud,Pos,Format,@Data);
    End;
   End;
  End;
 End;
Finish:
 If(Format<>tdFile)Then FileClose(Q.Handle);
 ROCreateKeyFormat:=True;
End;

Function ROCreateFile(Var Q:RegistryObject;RootKey:Byte;Const Path,Name:String):LongInt;
Var
 Handle:LongInt;
Begin
 If Not ROCreateKeyFormat(Q,RootKey,Path,Name,tdFile,Handle)Then ROCreateFile:=-1
                                                            Else ROCreateFile:=Handle;
End;

Function ROGetAbsRec(Var Q:RegistryObject;Handle,FilePos:LongInt;Size:Word;Var Buffer):Word;
Var
 MainNoeud:NoeudRec;
 FileHeader:Record
  FileSize:LongInt;
  FirstBlock:LongInt;
 End;
 ChainHeader:Record
  Size:LongInt;
  NextBlock:LongInt;
 End;
 CurrSize:Word;
 CurrPos,Pos:LongInt;
Begin
 ROGetAbsRec:=0;
 _GetAbsRec(Q.Handle,Handle,SizeOf(MainNoeud),MainNoeud);
 CurrPos:=Handle+SizeOf(MainNoeud)-SizeOf(String)+Length(MainNoeud.Name)+1;
 _GetAbsRec(Q.Handle,CurrPos,SizeOf(FileHeader),FileHeader);
 If(FilePos>FileHeader.FileSize)Then Exit;
 Pos:=0;
 CurrPos:=FileHeader.FirstBlock;
 Repeat
  _GetAbsRec(Q.Handle,CurrPos,SizeOf(ChainHeader),ChainHeader);
  If(FilePos>=Pos)Then Begin
   If(FilePos+Size<Pos+ChainHeader.Size)Then Begin
    ROGetAbsRec:=_GetAbsRec(Q.Handle,CurrPos+(FilePos-Pos),Size,Buffer);
    Break;
   End;
   If(FilePos<Pos+ChainHeader.Size)Then Begin
    CurrSize:=Pos+ChainHeader.Size-FilePos;
    Repeat
     _GetAbsRec(Q.Handle,CurrPos+(FilePos-Pos),CurrSize,Buffer);
     Dec(Size,CurrSize);
     ASM
      MOV AX,CurrSize
      ADD Word Ptr Buffer,AX
     END;
     CurrPos:=ChainHeader.NextBlock;
     _GetAbsRec(Q.Handle,CurrPos,SizeOf(ChainHeader),ChainHeader);
     If Size>0Then Begin
      If(ChainHeader.Size>=Size)Then CurrSize:=Size
                                Else CurrSize:=ChainHeader.Size;
     End;
    Until Size=0;
    Break;
   End;
  End;
  Inc(Pos,ChainHeader.Size);
  CurrPos:=ChainHeader.NextBlock;
 Until(ChainHeader.NextBlock=0)or(ChainHeader.Size=0);
End;

Function ROSetAbsRec(Var Q:RegistryObject;Handle,FilePos:LongInt;Size:Word;Const Buffer):Boolean;
Var
 MainNoeud:NoeudRec;
 FileHeader:Record
  FileSize:LongInt;
  FirstBlock:LongInt;
 End;
 ChainHeader:Record
  Size:LongInt;
  NextBlock:LongInt;
 End;
 CurrPos,FragPos:LongInt;
Begin
 _GetAbsRec(Q.Handle,Handle,SizeOf(MainNoeud),MainNoeud);
 CurrPos:=Handle+SizeOf(MainNoeud)-SizeOf(String)+Length(MainNoeud.Name)+1;
 _GetAbsRec(Q.Handle,CurrPos,SizeOf(FileHeader),FileHeader);
 If FileHeader.FirstBlock=0Then Begin
  FillClr(ChainHeader,SizeOf(ChainHeader));
  FileHeader.FirstBlock:=ROGetFreePos(Q);
  FileHeader.FileSize:=FilePos+Size;
  _SetAbsRec(Q.Handle,CurrPos,SizeOf(FileHeader),FileHeader);
  CurrPos:=FileHeader.FirstBlock;
  _SetAbsRec(Q.Handle,CurrPos,SizeOf(ChainHeader),ChainHeader);
  Inc(CurrPos,SizeOf(ChainHeader));
  ChainHeader.Size:=FileHeader.FileSize;
  _SetAbsRec(Q.Handle,CurrPos+FilePos,Size,Buffer);
 End
  Else
(* If(FilePos+Size<FileHeader.FileSize)Then Begin
  CurrPos:=FileHeader.FirstBlock;
  _GetAbsRec(Q.Handle,CurrPos,SizeOf(ChainHeader),ChainHeader);
   {...}
 End
  Else*)
 Begin
  FragPos:=0;
  CurrPos:=FileHeader.FirstBlock;
  While(FragPos<FilePos)do Begin
   _GetAbsRec(Q.Handle,CurrPos,SizeOf(ChainHeader),ChainHeader);
   If(ChainHeader.NextBlock=0)or(ChainHeader.Size=0)Then Break;
   CurrPos:=ChainHeader.NextBlock;
   Inc(FragPos,ChainHeader.Size);
  End;
  If(FragPos>FilePos)Then Begin
    _SetAbsRec(Q.Handle,{CurrPos}0{..},Size-FragPos-FilePos,Buffer);
    _SetAbsRec(Q.Handle,{CurrPos}0{..},FragPos-FilePos-Size,Buffer);
  End;
  If ChainHeader.NextBlock=0Then Begin
   ChainHeader.NextBlock:=ROGetFreePos(Q);
   _SetAbsRec(Q.Handle,CurrPos,SizeOf(ChainHeader),ChainHeader);
   ChainHeader.Size:=Size+(FilePos-FragPos);
   ChainHeader.NextBlock:=0;
   _SetAbsRec(Q.Handle,CurrPos,SizeOf(ChainHeader),ChainHeader);
  End;
  _SetAbsRec(Q.Handle,CurrPos+FilePos-FragPos,Size,Buffer);
  Inc(FileHeader.FileSize,Size);
  _SetAbsRec(Q.Handle,CurrPos+FilePos,Size,Buffer);
 End;
End;

Function ROReadKey(Var Q:RegistryObject;RootKey:Byte;
          Const Path,Name:String;Var Data):Boolean;Begin
 ROReadKey:=_ROReadKey(Q,RootKey,Path,Name,Data,True);
End;

Function _ROReadKey(Var Q:RegistryObject;RootKey:Byte;
           Path:String;Const Name:String;Var Data;CloseFile:Boolean):Boolean;
Var
 Header:HeaderRegistryRec;
 CurrPos,Pos:LongInt;
 Len:Word;
 Noeud:NoeudRec;
Begin
 _ROReadKey:=False;
 If Name<>''Then Begin
  ROOpenFile(Q);
  _GetAbsRec(Q.Handle,0,SizeOf(Header),Header);
  CurrPos:=Header.HKEY.Address[RootKey];
  If CurrPos<>0Then Begin
   If ROSearchDir(Q,Noeud,CurrPos,Path,False)Then Begin
    If Noeud.Child<>0Then Begin
     Pos:=Noeud.Child;
     If ROKeyExist(Q,Pos,Name)Then Begin
      _GetAbsRec(Q.Handle,Pos,SizeOf(Noeud),Noeud);
      Len:=SizeOf(NoeudRec)-SizeOf(String)+Length(Noeud.Name)+1;
      _GetAbsRec(Q.Handle,Pos,Len,Noeud);
      Inc(Pos,LongInt(Len));
      _GetAbsRec(Q.Handle,Pos,Noeud.Len,Data);
      _ROReadKey:=True;
     End;
    End;
   End;
  End;
 End;
 If(CloseFile)Then FileClose(Q.Handle);
End;

Function ROFindFirst(Var Q:RegistryObject;RootKey:Byte;Const Path:String;Var Info:SearchRegistryRec):Boolean;
Label
 Finish;
Var
 Header:HeaderRegistryRec;
 Noeud:NoeudRec;
 CurrPos:LongInt;
Begin
 ROFindFirst:=False;
 FillClr(Info,SizeOf(Info));
 ROOpenFile(Q);
 _GetAbsRec(Q.Handle,0,SizeOf(Header),Header);
 CurrPos:=Header.HKEY.Address[RootKey];
 If CurrPos>0Then Begin
  If Path<>''Then Begin
   If ROSearchDir(Q,Noeud,CurrPos,Path,False)Then CurrPos:=Noeud.Child
                                             Else Goto Finish;
  End;
  Repeat
   _GetAbsRec(Q.Handle,CurrPos,SizeOf(Noeud),Noeud);
   If Noeud.Next=0Then Break;
   CurrPos:=Noeud.Next;
  Until False;
  Info.Name:=Noeud.Name;
  Info.Pos:=CurrPos;
  ROFindFirst:=True;
 End;
Finish:
 FileClose(Q.Handle);
End;

Function ROFindNext(Var Q:RegistryObject;Var Info:SearchRegistryRec):Boolean;
Label
 Restart;
Var
 Noeud,NoeudNext,NoeudPrev:NoeudRec;
Begin
 ROFindNext:=False;
 _GetAbsRec(Q.Handle,Info.Pos,SizeOf(Noeud),Noeud);
 If Noeud.Next=0Then Begin
Restart:
  Info.Pos:=Noeud.Parent;
  If Info.Pos=0Then Exit;
  _GetAbsRec(Q.Handle,Info.Pos,SizeOf(Noeud),Noeud);
  If(Noeud.Name>Info.Name)Then Begin
   Info.Name:=Noeud.Name;
   ROFindNext:=True;
   Exit;
  End;
  Goto Restart;
 End;
 _GetAbsRec(Q.Handle,Noeud.Next,SizeOf(NoeudNext),NoeudNext);
 Info.Name:=Noeud.Name;
 ROFindNext:=True;
End;

Function CreateKeyFormat(RootKey:Byte;Const Path,Name:String;Format:Byte;Const Data):Boolean;
Var
 Q:RegistryObject;
Begin
 ROOpenMain(Q);
 ROCreateKeyFormat(Q,RootKey,Path,Name,Format,Data);
 RODone(Q);
End;

Function ReadMainKey(RootKey:Byte;Const Path,Name:String;Var Data):Boolean;
Var
 Q:RegistryObject;
Begin
 If(MainRegistryExist)Then Begin
  ROOpenMain(Q);
  ReadMainKey:=ROReadKey(Q,RootKey,Path,Name,Data);
  RODone(Q);
 End
  Else
 ReadMainKey:=False;
End;

END.