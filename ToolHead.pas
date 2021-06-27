{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                                                                         Û
 ³                      Malte Genesis/Tools Header                         Û
 ³                                                                         Û
 ³            dition Chantal pour Mode R‚el/IV - Version 1.1              Û
 ³                              1995/11/30                                 Û
 ³                                                                         Û
 ³          Tous droits r‚serv‚s par les Chevaliers de Malte (C)           Û
 ³                                                                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Nom du programmeur
 ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

  Sylvain Maltais


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette unit‚ fournit les outils n‚cessaires pour examiner les entˆtes de
 nombres  fichier  et   de   les  expos‚es   de  fa‡on  compr‚hensible  …
 l'utilisateur.
}

{$I DEF.INC}

Unit ToolHead;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                 INTERFACE
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Function InfoHeader(Const Path:String;Proc:Byte):Byte;
Function InfoDir(Const Path:String;Proc:Byte):Byte;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                IMPLEMENTATION
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses
 Adele,Systex,Imagetex,Isatex,Memories,Systems,Video,Dialex,Dials,
 DialPlus,Sourcer,ResServD;

Function AttrStr(Attr:Word):String;Near;
Var
 S:String;
Begin
 S:='';
 If Attr=0Then AddStr(S,'Nulle');
 If(Attr and faArchive=faArchive)Then AddStr(S,'Archive ');
 If(Attr and faDir=faDir)Then AddStr(S,'R‚pertoire ');
 If(Attr and faVolumeID=faVolumeID)Then AddStr(S,'Volume ');
 If(Attr and faSysFile=faSysFile)Then AddStr(S,'SystŠme ');
 If(Attr and faHidden=faHidden)Then AddStr(S,'Cach‚ ');
 If(Attr and faReadOnly=faReadOnly)Then AddStr(S,'Lecture seulement ');
 AttrStr:=S;
End;

Function InfoTag(Proc:Byte;Const Name:String):Byte;Near;
Var
 Handle:Hdl;
 K:Word;
 I:Byte;
 TagID3v1:Record
  Tag:Array[1..3]of Char;
  SongName,Artist,Album:Array[1..30]of Char;
  Year:Array[1..4]of Char;
  Comment:Array[1..30]of Char;
  Genre:Byte;
 End;
 Data:Record
  Title:String[30];
  Album:String[30];
  Artist:String[30];
  Year:String[4];
  Rem:String[30];
  Key:Byte;
 End;
Begin
 InfoTag:=$FF;
 Handle:=FileOpen(Name,fmRead);
 If(Handle<>errHdl)Then Begin
  _GetAbsRec(Handle,FileSize(Handle)-SizeOf(TagID3v1),SizeOf(TagID3v1),TagID3v1);
  If TagID3v1.Tag<>'TAG'Then ErrNoMsgOk(NoTagMP3)
   Else
  Begin
   FillClr(Data,SizeOf(Data));
   Data.Title:=StrPas(PChr(@TagID3v1.SongName));
   Data.Album:=StrPas(PChr(@TagID3v1.Album));
   Data.Artist:=StrPas(PChr(@TagID3v1.Artist));
   Data.Year:=StrPas(PChr(@TagID3v1.Year));
   Data.Rem:=StrPas(PChr(@TagID3v1.Comment));
   For I:=1to(Proc)do PushKey(kbRight);
   ExecuteAppDPU(84,Data);
   InfoTag:=Data.Key;
  End;
 End;
 FileClose(Handle);
End;

Function ExecHeader(Proc:Byte;Const Name:String):Byte;Near;
Var
 I:Byte;
 EXE:HeaderEXE;
 Data:Record
  Path:String[12];
  Format:String[30];
  NmOvr:String[40];
  NmSeg:String[40];
  Size:String[70];
  Sizes:String[70];
  OfsStack:String[30];
  Header:String[50];
  IP:String[50];
  Start:String[50];
  FileSize:String[50];
  Date:String[50];
  Attr:String[50];
  Key:Byte;
 End;
 X:SearchRec;
Begin
 ExecHeader:=$FF;
 FillClr(Data,SizeOf(Data));
 Data.Path:=Path2NoDir(Name);
 Data.Format:='Ex‚cutable';
 GetFile(Name,0,SizeOf(EXE),EXE);
 Data.NmOvr:=CStr(EXE.NmOvr);
 Data.NmSeg:=CStr(EXE.NmSeg)+' ('+IntToStr(Long(EXE.NmSeg)shl 2)+' octet(s))';
 Data.Size:=IntToStr(EXE.LenN511+(Long(EXE.LenShr9+1)shl 9))+
            ' octets; entˆte'+CStrBasic(EXE.SizeOfHeader)+' octets';
 Data.Sizes:='Pile:'+CStrBasic(EXE.SizeOfStack)+', tas min.:'+
	     CStrBasic(Long(EXE.MinParagraph)shl 4)+', tas max.:'+
	     CStrBasic(Long(EXE.MaxParagraph)shl 4)+'; octets';
 Data.OfsStack:=CStr(EXE.OfsLoadStack);
 Data.Header:=HexWord2Str(EXE.IP)+'h';
 Data.IP:=CStr(EXE.IP)+' ('+HexWord2Str(EXE.IP)+'h)';
 Data.Start:=CStr(EXE.OfsLoad)+', adresse de table:'+CStrBasic(EXE.AdrExeTable);
 FindFirst(Name,fa,X);
 Data.FileSize:=CStr(X.Size)+' octet(s)';
 Data.Date:=TimeToStr(X.Time);
 Data.Attr:=AttrStr(X.Attr.Value);
 For I:=1to(Proc)do PushKey(kbRight);
 ExecuteAppDPU(85,Data);
 ExecHeader:=Data.Key;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Fonction InfoHeader                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet … partir d'un nom de fichier d'afficher une boŒte
 de dialogue et de faire partager le sens de l'entˆte du fichier demander.
}

Function InfoHeader;
Label
 BreakAll;
Var
 Ext:ExtStr;
 W:Window;
 Xx,FS:LongInt;
 X,Y,NmKrs:Word;
 Handle:Hdl;
 L:Byte;
 Lx:LstMnu;
 K,I:Word;
 GIF:HeaderGIF;
 BMP:HeaderBMP;
 PCX:HeaderPCX;
 Data:Array[0..511]of Char;
 PStr:^String;

 Procedure BeginWn;Begin
  WEPushWn(W);
  WEPutWnKrDials(W,'Aide ParticuliŠre (Squelette)');
  WEBar(W);
  WELn(W);
  SetAllKr(W.Palette.High,W.Palette.Border);
  WEPutTypingLn(W,'Nom: ^'+Path2NoDir(Path)+'^');
 End;

 Procedure EndWindow;
 Var
  X:SearchRec;
  I:Byte;
 Begin
  FindFirst(Path,fa,X);
  WEPutTypingLn(W,'Taille fichier: ^'+CStr(X.Size)+'^ octet(s)');
  WEPutTypingLn(W,'Date: ^'+TimeToStr(X.Time));
  WEPutTypingLn(W,'^Attribut fichier: ^'+AttrStr(X.Attr.Value));
  For I:=1to(Proc)do PushKey(kbRight);
  K:=WEGetkHorDn(W,'Correcte|Suivant|Pr‚c‚dent');
  If(K=kbAbort)Then InfoHeader:=$FF Else InfoHeader:=K;
 End;

 Procedure EndWn;Begin
  EndWindow;
  WEDone(W);
 End;

 Procedure Format(Const S:String);Begin
  WEPutTypingLn(W,'Format: ^'+S+'^');
 End;

 Procedure UncodeRLL(X:Wd);
 Var
  Ptr:^TByte;
  SzOf:Word;
  L:LstMnu;
  S,S2:String;
  J,I,K:Word;
 Begin
  Ptr:=AllocFunc(X,Path,SzOf);
  LMInitCenter(L,75,20,'Code de routine',CurrKrs.Dialog.Window);
  WESetEndBar(L.W,L.W.Palette.Title);
  K:=0;
  While K<SzOf-1do Begin
   S:='CS:'+HexWord2Str(K)+'h ';I:=K; S2:=Decode(Ptr^,K);
   For J:=0to K-I-1do AddStr(S,HexByte2Str(Ptr^[I+J]));
   AddStr(S,Spc(16-(J shl 1)));
   If Not ALAddStr(L.List,S+S2)Then Begin
    __OutOfMemory;
    Break;
   End;
   WESetEndBarTxtX(L.W,1,'D‚compile:'+CStrBasic(L.List.Count),L.W.Palette.Title);
  End;
  WESetEndBarTxtX(L.W,1,'Nombre d''instruction:'+CStrBasic(L.List.Count),L.W.Palette.Title);
  FreeMemory(Ptr,SzOf);
  LMRun(L);
  LMDone(L);
 End;

Begin
 InfoHeader:=$FF;
 Ext:=StrUp(Path2Ext(Path));
 If Ext='.BMP'Then Begin
  WEInitO(W,45,11);
  BeginWn;
  Format('Graphique Bitmap Windows');
  GetFile(Path,0,SizeOf(BMP),BMP);
  WEPutTxtLn(W,'Taille image:'+BasicStr(BMP.NumXPixels)+'x'+
	     IntToStr(BMP.NumYPixels)+','+
             CStrBasic(Long(Long(BMP.Planes)shl Long(BMP.BitCount)))+
             ' couleurs');
  EndWn;
  Exit;
 End;
 If(Ext='.386')or(Ext='.EXE')Then Begin
  InfoHeader:=ExecHeader(Proc,Path);
  Exit;
 End;
 If Ext='.GFX'Then Begin
  WEInitO(W,40,11);
  BeginWn;
  Format('GFX (Graphique d''image Brute)');
  WEPutTyping(W,'Taille image: ^');
  FS:=GetFileSize(Path);
  Repeat
   If FS=16384Then Begin X:=640;Y:=200;NmKrs:=2;End Else
   If FS=64000Then Begin X:=320;Y:=200;NmKrs:=256;End Else
   If FS=307200Then Begin X:=640;Y:=480;NmKrs:=256;End
    Else
   Begin
    WEPutTypingLn(W,'Inconnu (?)^');
    Break;
   End;
   WEPutTypingLn(W,CStr(X)+'^x^'+CStr(Y)+'^,^'+CStrBasic(NmKrs)+'^ couleurs');
  Until True;
  EndWn;
  Exit;
 End;
 If Ext='.GIF'Then Begin
  WEInitO(W,40,12);
  BeginWn;
  Format('The Graphics Interchange Format');
  GetFile(Path,0,SizeOf(GIF),GIF);
  WEPutTxtLn(W,'Signature: '+GIF.Sign[0]+GIF.Sign[1]+GIF.Sign[2]+
			     GIF.Ver[0]+GIF.Ver[1]+GIF.Ver[2]);
  WEPutTxtLn(W,'Taille image:'+CStrBasic(GIF.NumXPixels)+'x'+
	       CStr(GIF.NumYPixels)+','+CStrBasic(2 shl(GIF.ExtInfo and 7))+' couleurs');
  EndWn;
  Exit;
 End;
 If Ext='.MP3'Then Begin
  InfoHeader:=InfoTag(Proc,Path);
  Exit;
 End;
 If Ext='.PCX'Then Begin
  WEInitO(W,45,13);
  BeginWn;
  Format('Dessin PaintBrush');
  GetFile(Path,0,SizeOf(PCX),PCX);
  WEPutTxtLn(W,'Version:'+BasicStr(PCX.Version));
  WEPutTxtLn(W,'Taille image:'+CStrBasic(PCX.NumXPixels)+'x'+
   CStr(PCX.NumYPixels)+','+CStrBasic(Long(Long(1)shl Long(PCX.BitsPerPixel*PCX.NumPlanes)))+' couleurs');
  WEPutTxtLn(W,'BoŒte: ('+IntToStr(PCX.X1)+','+IntToStr(PCX.Y1)+')-('+IntToStr(PCX.X2)+','+IntToStr(PCX.Y2)+')');
  EndWn;
  Exit;
 End;
 If Ext='.RLL'Then Begin
  WEInitO(W,40,18);
  BeginWn;
  WESubList(W,0,W.Y,wnMax,wnMax-8,'Entr‚e',Lx);
  WESetEndBar(Lx.W,Lx.W.Palette.Title);
  Handle:=FileOpen(Path,fmRead);
  I:=1;Xx:=0;
  FS:=FileSize(Handle);
  If(Handle<>errHdl)Then Begin
   While(Xx<FS)do Begin
    GetRec(Handle,I,SizeOf(Xx),Xx);
    If Not ALAddStrByte(Lx.List,CStr(I)+': '+HexLong2Str(Xx)+'h ('+CStr(Xx)+')',I)Then Begin
     __OutOfMemory;
     FileClose(Handle);
     WEDone(W);
     Exit;
    End;
    Inc(I);
   End;
   Dec(Lx.List.Count);
   FileClose(Handle);
  End;
  WESetEndBarTxtX(Lx.W,1,'Nombre d''index:'+CStrBasic(Lx.List.Count),Lx.W.Palette.Title);
  LMRefresh(Lx);
  W.Y:=10;
  PushKey(kbTab);
  EndWindow;
  If(K=kbTab)Then Begin
   Repeat
    Repeat
     I:=LMRunKbd(Lx);
     Case(I)of
      0:;
      kbEsc:Begin
       InfoHeader:=$FF;
       Goto BreakAll;
      End;
      kbTab:Break;
      Else UncodeRLL(I-1);
     End;
    Until I=0;
    K:=WEGetkHorDn(W,'Correcte|Suivant|Pr‚c‚dent');
    Case(K)of
     kbAbort,kbEsc:Begin
      InfoHeader:=$FF;
      Break;
     End;
     Else InfoHeader:=K;
    End;
   Until(K<>kbTab);
  End;
BreakAll:
  LMDone(Lx);
  WEDone(W);
  Exit;
 End;
 If NmXTxts>40Then L:=60 Else L:=40;
 WEInitO(W,L,10);
 BeginWn;
 DBOpenServerName(ChantalServer,'CHANTAL:/Fichier/Index.Dat');
 If DBLocateAbs(ChantalServer,0,Ext,[])Then Begin
  DBReadRec(ChantalServer,Data);
  PStr:=@Data;
  DBGotoColumnAbs(ChantalServer,1,Pointer(PStr));
  Format(PStr^);
 End
  Else
 Format('Inconnu');
 EndWn;
End;

Function InfoDir(Const Path:String;Proc:Byte):Byte;
Var
 Data:Record
  CaptionName:String[20];
  CaptionDate:String[20];
  CaptionAttr:String[40];
  Key:Byte;
 End;
 X:SearchRec;
 I:Byte;
Begin
 FindFirst(Path,faDir,X);
 FillClr(Data,SizeOf(Data));
 Data.CaptionName:=Path2NoDir(Path);
 Data.CaptionDate:=TimeToStr(X.Time);
 Data.CaptionAttr:=AttrStr(X.Attr.Value);
 For I:=1to(Proc)do PushKey(kbRight);
 ExecuteAppDPU(71,Data);
 InfoDir:=Data.Key;
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
END.