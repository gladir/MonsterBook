Unit MCatDsk;

INTERFACE
{$I DEF.INC}
Uses Dos,Isatex,Systex;

Const
 ctProgram=0;
 ctCompress=1;
 ctConvers=2;
 ctTeleMatic=3;
 ctDraw=4;
 ctMusic=5;
 ctWindows=6;
 ctOS2=7;
 ctGames=8;
 ctUtility=9;
 ctProgrammer=10;
 ctDoc=11;
 ctOthers=12;

Type
 VolumeStr=String[12];

 IndexType=Record
  Volume:VolumeStr;
  NumberFile,SizeUsed,SizeFree,Time:Long;
  Description:String[80];
 End;

 DiskInfoType=Record
  Path:PathStr;
  Size,Time:Long;
  Attr,Category:Byte;
  Description :String[80];
 End;

Var
 PathCatDisk:PathStr;

Function  GetDiskInfo(Disk:Byte):Bool;
Procedure GlobalCatalog;
Function  InputDiskInfo(Var Info:DiskInfoType):Bool;
Procedure InputTime(X,Y:Byte;Var Time:Long;Var XP:Byte;Var K:Wd);
Function  SelectRemoveDisk(OldChoice:Byte):Byte;
Function  StrCategory(Category:Byte):String;
Procedure _GlobalCatalog(Path:PathStr);

IMPLEMENTATION

Uses {$IFDEF Adele}Adele,{$ELSE}Chantal,{$ENDIF}
     Systems,Video,Dials;

Function StrCategory;Begin
 Case(Category)of
  ctProgram:StrCategory:='Programmeur';
  ctCompress:StrCategory:='Compression';
  ctConvers:StrCategory:='Conversion';
  ctTeleMatic:StrCategory:='Communcication';
  ctDraw:StrCategory:='Dessin';
  ctMusic:StrCategory:='Musique';
  ctWindows:StrCategory:='Windows';
  ctOS2:StrCategory:='OS/2';
  ctGames:StrCategory:='Jeux';
  ctUtility:StrCategory:='Utilitaire';
  ctProgrammer:StrCategory:='Programmeur';
  ctDoc:StrCategory:='Documentation';
  Else StrCategory:='Divers';
 End;
End;

Function SelectRemoveDisk;Var DiskTab:Array[0..25]of Bool;DiskLet:Array[0..25]of Char;Res:Bool;P,I,N,FD,M:Byte;W:Wins;Begin
 SelectRemoveDisk:=$FF;
 If OldChoice=0Then OldChoice:=GetDsk Else Dec(OldChoice);
 N:=0;FD:=$FF;
 For I:=0to 25do Begin
  Res:=DskExist(I)and(Not DskFixed(I+1));DiskTab[I]:=Res;
  If(Res)Then Begin
   DiskLet[N]:=Char(I+Byte('A'));Inc(N);
   If(I<FD)Then FD:=I;
  End;
 End;
 If N=0Then Exit;
 If N=1Then Begin;SelectRemoveDisk:=FD;Exit;End;
 M:=N-1;
 If Not DiskTab[OldChoice]Then OldChoice:=FD;
 WEInitO(W,1+N*3,3);
 WEPushWn(W);
 WEPutWnKrDials(W,'Disque');
 For I:=0to(M)do Begin
  WEPutTxtXY(W,I*3+1,1,DiskLet[I]);
  If OldChoice=Byte(DiskLet[I])-Byte('A')Then Begin
   P:=I;
   WESetKrSel(W);
   WEBarSelHor(W,I*3,1,I*3+2);
   WESetKrBorder(W);
  End;
 End;
 Repeat
  Repeat
   Case GetRawTimerB and$Fof
    0: _WESetCubeCSelF(W,P*3+1,1,DiskLet[P],LightRed);
    4: _WESetCubeCSelF(W,P*3+1,1,DiskLet[P],Yellow);
    8: _WESetCubeCSelF(W,P*3+1,1,DiskLet[P],LightBlue);
    12: _WESetCubeCSelF(W,P*3+1,1,DiskLet[P],LightGreen);
   End;
  Until KeyPress;
  _WESetCubeCSel(W,P*3+1,1,DiskLet[P]);
  Case(ReadKey)of
   kbLeft:Begin
    WESetKrBorder(W);
    WEBarSelHor(W,P*3,1,P*3+2);
    P:=MinByte(P,M);
    WESetKrSel(W);
    WEBarSelHor(W,P*3,1,P*3+2);
   End;
   kbRight:Begin
    WESetKrBorder(W);
    WEBarSelHor(W,P*3,1,P*3+2);
    P:=MaxByte(P,M);
    WESetKrSel(W);
    WEBarSelHor(W,P*3,1,P*3+2);
   End;
   kbEnter:Begin
    SelectRemoveDisk:=Byte(DiskLet[P])-64;
    Break;
   End;
   kbEsc:Break;
  End;
 Until No;
 WEDone(W);
End;

Function InputDiskInfo;Var W:Wins;L:LstMnu;P,XP:Byte;
Descr,Path:Array[0..80]of Char;Size:Array[0..14]of Char;
Buffer:PChr;Time:Long;Attr,Category:Byte;K:Wd;DT:DateTime;Begin
 InputDiskInfo:=No;
 WEInitO(W,60,15);
 WEPushWn(W);
 WEPutWnKrDials(W,'Table Fichier');WELn(W);
 WEPutTxtLn(W,'Description');WELn(W);
 WEPutTxtLn(W,'Nom');WELn(W);
 WEPutTxtLn(W,'Taille');WELn(W);
 WEPutTxtLn(W,'Temps');WELn(W);
 WEPutTxtLn(W,'Cat‚gorie');
 WEPutkHorDn(W,'Correcte|Annule');
 WESetKrSel(W);
 WEBarSpcHorShade(W,12,1,wnMax-1);WEPutTxtXY(W,12,1,Info.Description);
 WEBarSpcHorShade(W,12,3,wnMax-1);WEPutTxtXY(W,12,3,Info.Path);
 WEBarSpcHorShade(W,12,5,wnMax-1);WEPutTxtXY(W,12,5,Str(Info.Size));
 UnpackTime(Info.Time,DT);
 WEBarSpcHorShade(W,12,7,21);WEPutTxtXY(W,12,7,CStrDate(Info.Time));
 WEBarSpcHorShade(W,21,7,29);WEPutTxtXY(W,23,7,CStrTime(Info.Time));
 WEBarSpcHorShade(W,12,9,wnMax-1);WEPutTxtXY(W,12,9,StrCategory(Info.Category));
 SetAllKr(CurrKrs.Dial.Wins.Sel,$B0);
 P:=0;XP:=0;Category:=Info.Category;Attr:=Info.Attr;Time:=Info.Time;
 StrPCopy(@Descr,Info.Description);
 StrPCopy(@Path,Info.Path);
 StrPCopy(@Size,Str(Info.Size));
 Repeat
  Case(P)of
   0:Begin { Description }
    Buffer:=@Descr;
    SetKr($B0);
    K:=Input(W.X1+13,W.Y1+2,W.X2-2,SizeOf(Descr)-1,No,Buffer);
    SetKr(CurrKrs.Dial.Wins.Sel);
    WEBarSelHor(W,12,1,wnMax-1);
    Case(K)of
     kbTab,kbDn:P:=1;
     kbUp:P:=4;
     kbEnter:P:=5;
     kbEsc:Break;
    End;
   End;
   1:Begin { Nom }
    Buffer:=@Path;
    SetKr($B0);
    K:=Input(W.X1+13,W.Y1+4,W.X2-2,SizeOf(Path)-1,No,Buffer);
    SetKr(CurrKrs.Dial.Wins.Sel);
    WEBarSelHor(W,12,3,wnMax-1);
    Case(K)of
     kbTab,kbDn:P:=2;
     kbUp:P:=0;
     kbEnter:P:=5;
     kbEsc:Break;
    End;
   End;
   2:Begin { Taille }
    Buffer:=@Size;
    SetKr($B0);
    K:=Input(W.X1+13,W.Y1+6,W.X2-2,SizeOf(Size)-1,No,Buffer);
    SetKr(CurrKrs.Dial.Wins.Sel);
    WEBarSelHor(W,12,5,wnMax-1);
    Case(K)of
     kbTab,kbDn:P:=3;
     kbUp:P:=1;
     kbEnter:P:=5;
     kbEsc:Break;
    End;
   End;
   3:Begin { Temps }
    InputTime(W.X1+13,W.Y1+8,Time,XP,K);
    Case(K)of
     kbTab,kbDn:P:=4;
     kbUp:P:=2;
     kbEnter:P:=5;
     kbEsc:Break;
    End;
   End;
   4:Begin { Categorie }
    LMInit(L,20,8,MaxXTxts-20,MaxYTxts-8,'Categorie',CurrKrs.Dial.Wins);
    RBAddStrByte(L.X,'Compression',ctCompress);
    RBAddStrByte(L.X,'Conversion',ctConvers);
    RBAddStrByte(L.X,'Communication',ctTeleMatic);
    RBAddStrByte(L.X,'Dessin',ctDraw);
    RBAddStrByte(L.X,'Musique',ctMusic);
    RBAddStrByte(L.X,'Windows',ctWindows);
    RBAddStrByte(L.X,'OS/2',ctOS2);
    RBAddStrByte(L.X,'Jeux',ctGames);
    RBAddStrByte(L.X,'Utilitaire',ctUtility);
    RBAddStrByte(L.X,'Programmeur',ctProgrammer);
    RBAddStrByte(L.X,'Documentation',ctDoc);
    RBAddStrByte(L.X,'Programme',ctProgram);
    RBAddStrByte(L.X,'Divers',ctOthers);
    Category:=LMRun(L);
    If Category=$FFThen Break;
    LMDone(L);
    P:=5;
    WEPutTxtXY(W,12,9,StrUSpc(StrCategory(Category),20));
   End;
   5:Begin
    K:=WEGetkHorDn(W,'Correcte|Annule');
    Case(K)of
     0,kbEnter:Begin
      Info.Category:=Category;
      Val(StrPas(@Size),Info.Size,K);
      Info.Attr:=Attr;Info.Time:=Time;
      Info.Description:=StrPas(@Descr);Info.Path:=StrPas(@Path);
      Break;
     End;
     1,kbEsc:Break;
     kbTab:P:=0;
    End;
   End;
  End;
 Until No;
 WEDone(W);
 InputDiskInfo:=Ya;
End;

Procedure InputTime;Var DT:DateTime;Ok:Bool;Begin
 UnpackTime(Time,DT);
 Ok:=No;
 Repeat
  Case(XP)of
   0:Begin
    BarSelHor(X,Y,X+3,GetKr);
    Repeat
     K:=ReadKey;
     Case(K)of
      kbRight:Begin;XP:=1;Break;End;
      kbLeft:Begin;XP:=5;Break;End;
      kbEsc:Exit;
      kbBS:Begin
       If DT.Year>0Then Dec(DT.Year)Else Beep;
       PutTxtXYUnCol(X,Y,Str2(DT.Year,4));
      End;
      Else If Char(K)in[' ','+']Then Begin
       If DT.Year<3192Then Inc(DT.Year)Else Beep;
       PutTxtXYUnCol(X,Y,Str2(DT.Year,4));
      End;
     End;
     Ok:=(K=kbEnter)or(K=kbUp)or(K=kbDn)or(K=kbTab);
    Until Ok;
    BarSelHor(X,Y,X+3,GetLastKr);
   End;
   1:Begin
    BarSelHor(X+5,Y,X+5+1,GetKr);
    Repeat
     K:=ReadKey;
     Case(K)of
      kbLeft:Begin;XP:=0;Break;End;
      kbRight:Begin;XP:=2;Break;End;
      kbEsc:Exit;
      kbBS:Begin
       If DT.Month>1Then Dec(DT.Month)Else Beep;
       PutTxtXYUnCol(X+5,Y,Str0(DT.Month,2));
      End;
      Else If Char(K)in[' ','+']Then Begin
       If DT.Month<12Then Inc(DT.Month)Else Beep;
       PutTxtXYUnCol(X+5,Y,Str0(DT.Month,2));
      End;
     End;
     Ok:=(K=kbEnter)or(K=kbUp)or(K=kbDn)or(K=kbTab);
    Until Ok;
    BarSelHor(X+5,Y,X+5+1,GetLastKr);
   End;
   2:Begin
    BarSelHor(X+8,Y,X+8+1,GetKr);
    Repeat
     K:=ReadKey;
     Case(K)of
      kbLeft:Begin;XP:=1;Break;End;
      kbRight:Begin;XP:=3;Break;End;
      kbEsc:Exit;
      kbBS:Begin
       If DT.Day>1Then Dec(DT.Day)Else Beep;
       PutTxtXYUnCol(X+8,Y,Str0(DT.Day,2));
      End;
      Else If Char(K)in[' ','+']Then Begin
       If DT.Day<31Then Inc(DT.Day)Else Beep;
       PutTxtXYUnCol(X+8,Y,Str0(DT.Day,2));
      End;
     End;
     Ok:=(K=kbEnter)or(K=kbUp)or(K=kbDn)or(K=kbTab);
    Until Ok;
    BarSelHor(X+8,Y,X+8+1,GetLastKr);
   End;
   3:Begin
    BarSelHor(X+11,Y,X+11+1,GetKr);
    Repeat
     K:=ReadKey;
     Case(K)of
      kbLeft:Begin;XP:=2;Break;End;
      kbRight:Begin;XP:=4;Break;End;
      kbEsc:Exit;
      kbBS:Begin
       If DT.Hour>0Then Dec(DT.Hour)Else DT.Hour:=23;
       PutTxtXYUnCol(X+11,Y,Str2(DT.Hour,2));
      End;
      Else If Char(K)in[' ','+']Then Begin
       If DT.Hour<23Then Inc(DT.Hour)Else DT.Hour:=0;
       PutTxtXYUnCol(X+11,Y,Str2(DT.Hour,2));
      End;
     End;
     Ok:=(K=kbEnter)or(K=kbUp)or(K=kbDn)or(K=kbTab);
    Until Ok;
    BarSelHor(X+11,Y,X+11+1,GetLastKr);
   End;
   4:Begin
    BarSelHor(X+14,Y,X+14+1,GetKr);
    Repeat
     K:=ReadKey;
     Case(K)of
      kbLeft:Begin;XP:=3;Break;End;
      kbRight:Begin;XP:=5;Break;End;
      kbEsc:Exit;
      kbBS:Begin
       If DT.Min>0Then Dec(DT.Min)Else DT.Min:=59;
       PutTxtXYUnCol(X+14,Y,Str0(DT.Min,2));
      End;
      Else If Char(K)in[' ','+']Then Begin
       If DT.Min<59Then Inc(DT.Min)Else DT.Min:=0;
       PutTxtXYUnCol(X+14,Y,Str0(DT.Min,2));
      End;
     End;
     Ok:=(K=kbEnter)or(K=kbUp)or(K=kbDn)or(K=kbTab);
    Until Ok;
    BarSelHor(X+14,Y,X+14+1,GetLastKr);
   End;
   5:Begin
    BarSelHor(X+17,Y,X+17+1,GetKr);
    Repeat
     K:=ReadKey;
     Case(K)of
      kbLeft:Begin;XP:=4;Break;End;
      kbRight:Begin;XP:=0;Break;End;
      kbEsc:Exit;
      kbBS:Begin
       If DT.Sec>0Then Dec(DT.Sec)Else DT.Sec:=59;
       PutTxtXYUnCol(X+17,Y,Str0(DT.Sec,2));
      End;
      Else If Char(K)in[' ','+']Then Begin
       If DT.Sec<59Then Inc(DT.Sec)Else DT.Sec:=0;
       PutTxtXYUnCol(X+17,Y,Str0(DT.Sec,2));
      End;
     End;
     Ok:=(K=kbEnter)or(K=kbUp)or(K=kbDn)or(K=kbTab);
    Until Ok;
    BarSelHor(X+17,Y,X+17+1,GetLastKr);
   End;
  End;
 Until Ok;
 PackTime(DT,Time);
End;

Procedure _GlobalCatalog;Var W:Wins;Info:IndexType;Y:Byte;K,P:Wd;Volume:RBuf;

 Procedure Sub;Var Handle:Hdl;DskP,Max:Wd;DskY:Byte;W:Wins;Info:^IndexType;

  Procedure DskSelBar;Begin;WESetKrSel(W);WEBarSelHor(W,0,DskY,wnMax)End;
  Procedure DskUnSelBar;Begin;WESetKrBorder(W);WEBarSelHor(W,0,DskY,wnMax)End;

  Procedure DskPutLine(Data:DiskInfoType);Begin
   WEPutTxt(W,SetFullName(Data.Path));
   WEPutTxt(W,Str2(Data.Size,8));
   WEPutTxt(W,' '+Data.Description);
  End;

  Procedure DskPutDataHome;Var I:Word;Data:DiskInfoType;Begin
   DskP:=0;DskY:=0;
   WESetPosHome(W);
   For I:=0to(W.MaxY)do Begin
    If(Max<I)Then Break;
    _GetAbsRec(Handle,I*SizeOf(DiskInfoType)+SizeOf(IndexType),SizeOf(DiskInfoType),Data);
    DskPutLine(Data);
    WELn(W);
   End;
  End;

  Procedure DskkUp;Var Data:DiskInfoType;Begin
   If DskP>0Then Begin
    Dec(DskP);
    If DskY>0Then Begin;DskUnSelBar;Dec(DskY);DskSelBar;End
     else
    Begin
     DskUnSelBar;
     _WEScrollUp(W);
     _GetAbsRec(Handle,DskP*SizeOf(DiskInfoType)+SizeOf(IndexType),SizeOf(DiskInfoType),Data);
     DskPutLine(Data);
     WEClrEol(W);
     WELn(W);
     DskSelBar;
    End;
   End;
  End;

  Procedure DskkDn;Var Data:DiskInfoType;Begin
   If(DskP<Max)Then Begin
    Inc(DskP);
    If(DskY<W.MaxY)Then Begin;DskUnSelBar;Inc(DskY);DskSelBar;End
     Else
    Begin
     DskUnSelBar;
     _WEScrollDn(W);
     _GetAbsRec(Handle,DskP*SizeOf(DiskInfoType)+SizeOf(IndexType),SizeOf(DiskInfoType),Data);
     DskPutLine(Data);
     WEClrEol(W);
     WELn(W);
     DskSelBar;
    End;
   End;
  End;

  Procedure Rename;Var Data:DiskInfoType;Begin
   _GetAbsRec(Handle,DskP*SizeOf(DiskInfoType)+SizeOf(IndexType),SizeOf(DiskInfoType),Data);
   If(WinInp(60,'Fichier','Choisiser la description de fichier d‚sirer:',
	     CurrKrs.Dial.Wins,No,Data.Description)=kbEsc)Then Exit;
   _SetAbsRec(Handle,DskP*SizeOf(DiskInfoType)+SizeOf(IndexType),SizeOf(DiskInfoType),Data);
   WESetPos(W,0,DskY);
   DskPutLine(Data);
   WEClrEol(W);
   WELn(W);
   DskSelBar;
  End;

 Begin
  Info:=_RBGetBuf(Volume,P);Handle:=Open(SetPath4AddFile(PathCatDisk)+Info^.Volume,fmDef);
  If(Handle=errHdl)Then Exit;
  Max:=((FileSize(Handle)-SizeOf(IndexType))div SizeOf(DiskInfoType))-1;
  WEInitO(W,75,17);
  WEPushWn(W);
  WEPutWnKrDials(W,Info^.Volume);
  DskPutDataHome;
  DskSelBar;
  Repeat
   K:=WEReadk(W);
   Case(K)of
    kbEsc:Break;
    kbUp:DskkUp;
    kbDn:DskkDn;
    kbF6:Rename;
   End;
  Until No;
  WEDone(W);
  Close(Handle);
 End;

 Procedure PutLine(Info:IndexType);Begin
  WEPutTxt(W,SetFullName(Info.Volume));
  WEPutTxt(W,Str2(Info.SizeUsed,8));
  WEPutTXt(W,Str2(Info.SizeFree,8));
  WEPutTxt(W,Str2(Info.NumberFile,3));
  WEPutTxt(W,' '+Info.Description);
 End;

 Procedure SelBar;Begin
  WESetKrSel(W);
  WEBarSelHor(W,0,Y,wnMax);
 End;

 Procedure UnSelBar;Begin
  WESetKrBorder(W);
  WEBarSelHor(W,0,Y,wnMax);
 End;

 Procedure ReadFiles;Var I:Byte;Inf:SearchRec;Ptr:Pointer;Begin
  RBInit(Volume);
  FindFirst(SetPath4AddFile(PathCatDisk)+'*.*',fa,Inf);
  While DosError=0do Begin
   GetFile(SetPath4AddFile(PathCatDisk)+Inf.Name,0,SizeOf(Info),Info);
   Ptr:=RBAdd(Volume,SizeOf(Info));
   MoveLeft(Info,Ptr^,SizeOf(Info));
   FindNext(Inf);
  End;
 End;

 Procedure PutDataHome;Var I:Byte;Inf:SearchRec;Info:^IndexType;Begin
  WESetPosHome(W);
  For I:=0to(W.MaxY)do Begin
   If(RBMaxBuf(Volume)<I)Then Break;
   Info:=_RBGetBuf(Volume,I);
   PutLine(Info^);
   WELn(W);
   FindNext(Inf);
  End;
 End;

 Procedure kUp;Var Info:^IndexType;Begin
  If P>0Then Begin
   Dec(P);
   If Y>0Then Begin;UnSelBar;Dec(Y);SelBar;End
    else
   Begin
    UnSelBar;
    _WEScrollUp(W);
    Info:=_RBGetBuf(Volume,P);
    PutLine(Info^);
    WEClrEol(W);
    WELn(W);
    SelBar;
   End;
  End;
 End;

 Procedure kDn;Var Info:^IndexType;Begin
  If P<RBMaxBuf(Volume)Then Begin
   Inc(P);
   If(Y<W.MaxY)Then Begin;UnSelBar;Inc(Y);SelBar;End
    Else
   Begin
    UnSelBar;
    _WEScrollDn(W);
    Info:=_RBGetBuf(Volume,P);
    PutLine(Info^);
    WEClrEol(W);
    WELn(W);
    SelBar;
   End;
  End;
 End;

 Procedure Rename;Var Info:^IndexType;Begin
  Info:=_RBGetBuf(Volume,P);
  If(WinInp(60,'Volume','Choisiser la description de volume d‚sirer:',
	    CurrKrs.Dial.Wins,No,Info^.Description)=kbEsc)Then Exit;
  SetFile(SetPath4AddFile(PathCatDisk)+Info^.Volume,0,SizeOf(IndexType),Info^);
  WESetPos(W,0,Y);
  PutLine(Info^);
  WEClrEol(W);
  WELn(W);
  SelBar;
 End;

Begin
 If Not FileExist(SetPath4AddFile(PathCatDisk)+'*.*')Then
  ErrMsgOk('Catalogue de disque introuvable.')
  Else
 Begin
  ReadFiles;
  WEInitO(W,70,15);
  WEPushWn(W);
  WEPutWnKrDials(W,'Catalogue Global');
  WESetEndBar(W,CurrKrs.Dial.Wins.Title);
  WESetEndBarTxtX(W,1,Str(Volume.NB)+' volume(s)',CurrKrs.Dial.Wins.Title);
  WEPutLastBar('^Enter^ Voir le contenu  ^F6^ Changer la description');
  PutDataHome;
  P:=0;Y:=0;
  SelBar;
  Repeat
   K:=WEReadk(W);
   Case(K)of
    kbEsc:Break;
    kbEnter:Sub;
    kbUp:kUp;
    kbDn:kDn;
    kbF6:Rename;
   End;
  Until No;
  WEDone(W);
 End;
End;

Procedure GlobalCatalog;Begin
 _GlobalCatalog(FileExpand(Path2Dir(PathCatDisk)+'CATDISK.*'))
End;

Function GetDiskInfo;
Var Vol:String; K,Error,I,Size:Wd;Handle:Hdl; L,WD,WF:Wins; List:RBuf; TS:Long;
    DirInfo:SearchRec; DiskInfo:DiskInfoType; Ptr:Pointer; Index:IndexType;

 Procedure PutBarDisk(N:Byte;Msg:String);Begin
  WESetPos(WD,0,1);
  WEPutOTxt(WD,StrW(N)+'%');
  WESetKr(WD,$B0);
  If N>0Then WEBarSelHor(WD,0,1,Trunc(N*(WD.MaxX/100)));
  WESetKrBorder(WD);
  WEPutTxtXY(WD,0,3,StrUSpc(Msg,WD.MaxX));
  WESetKrSel(WD);
 End;

 Procedure PutBarFiles(N:Byte;Msg:String);Begin
  WESetPos(WF,0,1);
  WEPutOTxt(WF,StrW(N)+'%');
  WESetKr(WF,$B0);
  If N>0Then WEBarSelHor(WF,0,1,Trunc(N*(WF.MaxX/100)));
  WESetKrBorder(WF);
  WEPutTxtXY(WF,0,3,StrUSpc(Msg,WF.MaxX));
  WESetKrSel(WF);
 End;

Begin
 GetDiskInfo:=Ya;TS:=0;
 FillClr(Index,SizeOf(Index));
 WEInit(L,0,MaxYTxts,MaxXTxts,MaxYTxts);
 WEPushWn(L);
 SetAllKr($1B,$1F);
 PutLastBar(2,'S.V.P. attendre, recherche le nom du volume en cours...');
 WEInit(WD,3,2,MaxXTxts-3,7);
 WEPushWn(WD);
 WEPutWnKrDials(WD,'Statistique disque');
 WESetKrSel(WD);
 WEBarSpcHor(WD,0,1,wnMax);
 PutBarDisk(0,'Volume');
 Repeat
  Vol:=GetDskLabel(Disk);Error:=DosError;
  If Error=18Then Begin
   PutLastBar(2,'Pas de nom de volume, S.V.P. le d‚finir.');
   Error:=0; { Plus de fichier ? }
  End;
  If Error<>0Then Begin
   If(__DiskNotReady(Disk)=kbCancel)Then Begin;WEDone(WD);WEDone(L);Exit;End;
  End;
 Until Error=0;
 While Vol=''do Begin
  K:=WinInp(40,'Nom Volume','Choisiser le nom de volume d‚sirer :',CurrKrs.Dial.Wins,No,Vol);
  If(K=kbEsc)Then Begin WEDone(WD);WEDone(L);Exit;End;
  {$IFDEF External}
   SetDskLabel(Disk,Vol);
  {$ELSE}
   FreeMaxHeap;
   Exec('C:\DOS\LABEL.EXE',Char(Disk+64)+':'+Vol);
   MaxExpandHeap;
  {$ENDIF}
 End;
 If FileExist(SetPath4AddFile(PathCatDisk)+Vol)Then Begin
  If(WarningMsg('Volume d‚j… enregistr‚e, dois-je faire une mise … jour?',KeyYes+KeyNo)=kbNo)Then Begin
   WEDone(WD);
   WEDone(L);
   Exit;
  End;
  DelFile(SetPath4AddFile(PathCatDisk)+Vol);
 End;
 Index.Volume:=Vol;
 PutLastBar(2,'Lecture du disque.');
 PutBarDisk(20,'Espace de libre sur disque');
 Index.SizeFree:=DiskFree(Disk);
 PutBarDisk(40,'Espace total du disque');
 Index.SizeUsed:=DiskSize(Disk)-Index.SizeFree;
 Index.NumberFile:=0;Index.Description:='';
 PutBarDisk(100,'Lecture des fichiers');
 PutLastBar(2,'Lecture des fichiers');
 WEInit(WF,3,9,MaxXTxts-3,14);
 WEPushWn(WF);
 WEPutWnKrDials(WF,'Statistique Fichiers');
 WESetKrSel(WF);
 WEBarSpcHor(WF,0,1,wnMax);
 RBInit(List);
 FindFirst(Char(Disk+64)+':\*.*',faAll,DirInfo);
 While DosError=0do Begin
  Ptr:=RBAdd(List,SizeOf(DiskInfo));
  If(Ptr=NIL)Then Begin
   RBDone(List);
   WEDone(L);
   WEDone(WD);
   WEDone(WF);
   __OutOfMemory;
   Exit;
  End;
  FillClr(DiskInfo,SizeOf(DiskInfo));
  Inc(Index.NumberFile);Inc(TS,Long(DirInfo.Size));
  DiskInfo.Path:=DirInfo.Name;
  PutBarFiles(Trunc((TS/Index.SizeUsed)*100),DiskInfo.Path);
  DiskInfo.Size:=DirInfo.Size;DiskInfo.Time:=DirInfo.Time;
  DiskInfo.Attr:=DirInfo.Attr;DiskInfo.Category:=ctOthers;
  DiskInfo.Description:='';
  InputDiskInfo(DiskInfo);
  MoveLeft(DiskInfo,Ptr^,SizeOf(DiskInfo));
  FindNext(DirInfo);
 End;
 Handle:=New(SetPath4AddFile(PathCatDisk)+Vol);
 If(Handle<>errHdl)Then Begin
  SetRec(Handle,0,SizeOf(Index),Index);
  For I:=0to RBMaxBuf(List)do Begin
   Ptr:=RBGetBuf(List,I,Size);
   _SetAbsRec(Handle,I*SizeOf(DiskInfo)+SizeOf(Index),SizeOf(DiskInfo),Ptr^);
  End;
  Close(Handle);
 End;
 RBDone(List);
 WEDone(L);
 WEDone(WD);
 WEDone(WF);
 GetDiskInfo:=No;
End;

BEGIN { Main Unit }
 PathCatDisk:='';
END.