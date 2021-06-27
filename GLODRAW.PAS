{ Global Draw: Genre d'ACDSee }

Unit GloDraw;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                    INTERFACE
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses
 Isatex;

Function  GDInit(Var Context;X1,Y1,X2,Y2:Byte):Boolean;
Procedure GDRefresh(Var Context);
Procedure GDChangePath(Var Q:GlobalDrawApp;Const Path:String);
Function  GDGetCurrName(Var Q:GlobalDrawApp):String;
Function  GDRun(Var Context):Word;
Function  GDTitle(Var Context;Max:Byte):String;
Procedure GDMove2(Var Context;X,Y:Byte);
Procedure GDReSize(Var Context;X1,Y1,X2,Y2:Byte);
Function  GDDone(Var Context):Word;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                  IMPLEMENTATION
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses
 Registry,Adele,Systex,Memories,Systems,SysPlus,Dialex,Dials,Video,
 Restex,ResLoadI,ResServI,Show,ToolFile,Mouse,ToolHead,
 DialTree;

Type
 ConfigGlobalDraw=Record
  Len:Word;               { Longueur des donn‚es }
  Path:String;            { Chemin }
  Tri:FileSort;           { Tri des fichiers }
  P:Word;                 { Position }
  X,Y:Byte;               { Position X et Y }
  MinX:Byte;              { Position X minimum }
  Res:Array[0..15]of Byte;{ R‚serv‚ }
 End;

Function GDInit(Var Context;X1,Y1,X2,Y2:Byte):Boolean;
Var
 Q:GlobalDrawApp Absolute Context;
 Config:ConfigGlobalDraw;
Begin
 GDInit:=True;
 FillClr(Q,SizeOf(Q));
 WEInit(Q.W,X1,Y1,X2,Y2);
 BFInit(Q.Files);
 Q.Files.Tri:=fName;
 Q.Path:=GetCurrentDir;
 Q.MinY:=1;
 Q.MinX:=20+((Q.W.MaxX+1-22)and$F);
 If ReadMainKey(HKEY_CURRENT_USER,'Software\ACDSee','Config',Config)Then Begin
  Q.Files.Tri:=Config.Tri;
  If DirExist(Config.Path)Then Begin
   Q.Path:=Config.Path;
   If Q.P<BFNumFiles(Q.Files)Then Begin
    Q.X:=Config.X;
    Q.Y:=Config.Y;
    Q.MinX:=Config.MinX;
    Q.P:=Config.P;
   End;
  End;
 End;
 DTInitBureau(Q.Tree,X1+2,Y1+2,X1+Q.MinX-1,Y1+Q.W.MaxY);
{ Include(Q.Tree.Option,dtEnterExit);}
 GDRefresh(Q);
End;

Function GDGetName(H:SearchRec):String;
Type
 SearchPChr=Record
  Fill:Array[0..16]of Char;
  PC:PChr;
 End;
Var
 InfP:SearchPChr Absolute H;
 S:String;
Begin
 S:='';
 If(InfP.PC<>NIL)Then S:=StrPas(InfP.PC);
 Repeat
  If((sfaDir)in(H.Attr.Flags))and(S<>'')Then Break;
  If Pos('.',S)>0Then Break;
  S:=H.Name;
 Until True;
 GDGetName:=StrUSpc(Left(S,15),15);
End;

Procedure GDRefreshImage(Var Q:GlobalDrawApp);
Label Normal,Restart;
Var
 I,J:Byte;
 H:SearchRec;
 Y,X,P:Word;
 XT,YT:Byte;
 OldTap:Byte;
 Image:XInf;
 NumFiles:Word;
 Res:ImageHeaderRes;
 Inf:MCanvas;
Begin
 Y:=GetRawY(WEGetRY1(Q.W)+Q.MinY);
 P:=Q.P-(Q.NumWidth*Q.Y);YT:=7+Q.MinY;
 NumFiles:=BFNumFiles(Q.Files);
 For J:=0to Q.NumHeight-1do Begin
  X:=(WEGetRX1(Q.W)+Q.MinX)shl 3;
  XT:=Q.MinX;
  For I:=0to Q.NumWidth-1do Begin
Restart:
   BFGetFile(Q.Files,P,H);
   If(NumFiles<=P)Then Begin
    WEClrWn(Q.W,XT,YT-7,XT+15,YT,Q.W.Palette.Border);
{    If RILoadImage(MaltePath+'ICON\FOLDER32.ICO',0,0,$FFFF,rmAllRes,[],Image)=0Then Begin
     OldTap:=CurrKrs.Desktop.Tapiserie;
     CurrKrs.Desktop.Tapiserie:=Q.W.Palette.Border;
     RIPutImageJuxtap(Image,X,Y,128,7*16,[wpCenter]);
     CurrKrs.Desktop.Tapiserie:=OldTap;
    End;}
   End
    Else
   Begin
    WEPutSmlTxtXY(Q.W,XT+1,YT,GDGetName(H));
    WEBarSpcHorRelief(Q.W,XT,YT,XT+15);
    If(sfaDir)in(H.Attr.Flags)Then Begin
     WEClrWn(Q.W,XT,YT-7,XT+15,YT-1,Q.W.Palette.Border);
     If RILoadImage(MaltePath+'ICON\FOLDER32.ICO',0,0,$FFFF,rmAllRes,[],Image)=0Then Begin
      OldTap:=CurrKrs.Desktop.Tapiserie;
      CurrKrs.Desktop.Tapiserie:=Q.W.Palette.Border;
      RIPutImageJuxtap(Image,X,Y,128,7*16,[wpCenter,wpSprite]);
      CurrKrs.Desktop.Tapiserie:=OldTap;
     End;
    End
     Else
    If Q.Image^[P].Output<>$FFThen Begin
     XGetAbsRec(Q.Image^[P],0,SizeOf(Res),Res);
     If(Res.NumXPixels<=128)and(Res.NumYPixels<=128)Then Begin
Normal:
      OldTap:=CurrKrs.Desktop.Tapiserie;
      CurrKrs.Desktop.Tapiserie:=Q.W.Palette.Border;
      RIPutImageJuxtap(Q.Image^[P],X,Y,128,7*16-1,[wpCenter]);
      CurrKrs.Desktop.Tapiserie:=OldTap;
     End
      Else
     RIPutImage(Q.Image^[P],X,Y,128,7*16-1);
    End
     Else
    If RILoadImage(Q.Path+H.Name,0,0,$FFFF,rmAllRes,[],Image)=0Then Begin
     XGetAbsRec(Image,0,SizeOf(Res),Res);
     If(Res.NumXPixels<=128)and(Res.NumYPixels<=128)Then Begin
      RIRes2WnImg(Image,Inf);
      RIMakeDoublon(Image,rmAllRes,True,Inf);
      XFreeMem(Image);
      Image:=Inf.Miroir;
      Q.Image^[P]:=Image;
      Goto Normal;
     End
      Else
     Begin
      _RIPutScale(Image,X,Y,X+127,Y+7*16-1,0,[wiCopy2Target,wiPut2Screen],Q.Image^[P]);
      XFreeMem(Image);
     End;
    End
     Else
    Begin
     Dec(NumFiles);
     BFDeleteEntry(Q.Files,P);
     Goto Restart;
    End;
   End;
   Inc(X,128);
   Inc(XT,16);
   Inc(P);
  End;
  Inc(Y,128);
  Inc(YT,8);
 End;
End;

Procedure GDBar(Var Q:GlobalDrawApp);
Var
 XT,YT:Byte;
 H:SearchRec;
Begin
 XT:=Q.MinX+(Q.X shl 4);
 YT:=Q.MinY+7+(Q.Y shl 3);
 WEBarSpcHor(Q.W,XT,YT,XT+15);
 If Q.P+Q.X<BFNumFiles(Q.Files)Then Begin
  BFGetFile(Q.Files,Q.P+Q.X,H);
  WEPutSmlTxtXY(Q.W,XT+1,YT,GDGetName(H));
 End;
 WEBarSpcHorRelief(Q.W,XT,YT,XT+15);
End;

Procedure GDSelectBar(Var Q:GlobalDrawApp);Begin
 WESetKrSel(Q.W);
 GDBar(Q);
End;

Procedure GDUnSelectBar(Var Q:GlobalDrawApp);Begin
 WESetKrBorder(Q.W);
 GDBar(Q);
End;

Procedure GDFreeImage(Var Q:GlobalDrawApp);
Var
 I:Word;
Begin
 If(Q.Image<>NIL)Then Begin
  For I:=0to BFNumFiles(Q.Files)-1do XFreeMem(Q.Image^[I]);
 End;
 FreeMemory(Q.Image,Q.ImageSize);
 Q.Image:=NIL;
 Q.ImageSize:=0;
End;

Procedure GDChangePath(Var Q:GlobalDrawApp;Const Path:String);Begin
 Q.Path:=Path;
 GDRefresh(Q);
End;

Procedure GDRefreshStatusBar(Var Q:GlobalDrawApp);Begin
 If(IsGrf)Then Begin
  BarSpcHorRelief(Q.W.T.X1,Q.W.T.Y2,Q.W.T.X1+32,CurrKrs.Desktop.DialStatus);
  BarSpcHorReliefExt(Q.W.T.X1+1,Q.W.T.Y2,Q.W.T.X1+31,CurrKrs.Desktop.DialStatus);
  BarSpcHorRelief(Q.W.T.X1+33,Q.W.T.Y2,Q.W.T.X2,CurrKrs.Desktop.DialStatus);
  BarSpcHorReliefExt(Q.W.T.X1+34,Q.W.T.Y2,Q.W.T.X2-2,CurrKrs.Desktop.DialStatus);
  LuxeBox(Q.W.T.X2-1,Q.W.T.Y2);
 End
  Else
 WESetEndBarTxtX(Q.W,32,'³',CurrKrs.Desktop.DialStatus);
 WESetEndBarTxtX(Q.W,34,'Total'+CStrBasic(BFNumFiles(Q.Files))+' fichier(s), '+
                 CStrBasic(Q.Files.SizeFiles)+' octet(s)',CurrKrs.Desktop.DialStatus);
End;

Procedure GDRefresh(Var Context);
Var
 Q:GlobalDrawApp Absolute Context;
 NumFiles:Word;
 I:Word;
Begin
 Q.W.NotFullScrnX:=True;
 WEPutWnKrDials(Q.W,GDTitle(Q,Q.W.MaxX));
 WEBar(Q.W);
 WECloseIcon(Q.W);
 WEZoomIcon(Q.W);
 WEPutBarMsRight(Q.W);
 WESetEndBar(Q.W,CurrKrs.Desktop.DialStatus);
 Q.NumWidth:=((Q.W.MaxX+1-Q.MinX)shl 3)shr 7;
 Q.NumHeight:=GetRawY(Q.W.MaxY+1)shr 7;
{ If BFNoFile(Q.Files)Then Begin}
  BFSelPathExt(Q.Files,SetPath4AddFile(Q.Path)+'*.*',faAll);
  DTChDir(Q.Tree,Q.Path);
  GDFreeImage(Q);
  Q.ImageSize:=NumFiles*SizeOf(XInf);
  Q.Image:=MemAlloc(Q.ImageSize);
{ End;}
 DTRefresh(Q.Tree);
 GDRefreshStatusBar(Q);
 NumFiles:=BFNumFiles(Q.Files);
 GDFreeImage(Q);
 Q.ImageSize:=NumFiles*SizeOf(XInf);
 Q.Image:=MemAlloc(Q.ImageSize);
 If(Q.Image<>NIL)Then Begin
  For I:=0to NumFiles-1do Q.Image^[I].Output:=$FF;
  GDRefreshImage(Q);
 End;
 GDRefreshStatusBar(Q);
End;

Function GDGetCurrName(Var Q:GlobalDrawApp):String;
Var
 H:SearchRec;
Begin
 BFGetFile(Q.Files,Q.P+Q.X,H);
 GDGetCurrName:=Q.Path+H.Name
End;

Function GDRun(Var Context):Word;
Label InWn,Enter,Dn,Up,kDn,kUp;
Var
 Q:GlobalDrawApp Absolute Context; { Objet ®Global Draw¯ }
 K:Word;                           { Cl‚ clavier }
 H:SearchRec;                      { Information sur l'entr‚e de fichier courante }
 T:String;                         { ChaŒne de caractŠres temporaires }
 Refresh:Boolean;                  { Demande un rafraŒchissement? }
 OldP,OldX,OldY:Integer;
Begin
 GDSelectBar(Q);
 Repeat
  K:=WEReadk(Q.W);
  Case(K)of
   kbInWn:InWn:If LastMouseB=2Then Begin
    WaitMouseBut0;
    BFGetFile(Q.Files,Q.P+Q.X,H);
    T:=Q.Path+H.Name;
    Case FileMenuContext(NIL,T,H,Refresh)of
     1,5,6,7,10,11:ErrNoMsgOk(FunctionOutContext);
     2:Begin
      GDRun:=kbView;
      Break;
     End;
     3:Begin
      GDRun:=kbEdit;
      Break;
     End;
     4:Begin
      K:=0;
      Repeat
       BFGetFile(Q.Files,Q.P+Q.X,H);
       If(sfaDir)in(H.Attr.Flags)Then K:=InfoDir(Q.Path+H.Name,K)
                                 Else K:=InfoHeader(Q.Path+H.Name,K);
       Case(K)of
{	1:FMkDn(Q);
	2:FMkUp(Q);}
      $FF:Break;
       End;
      Until K=0;
     End;
     8:Refresh:=KillFile(T,H);
     9:SetPropriety(Q.Path+H.Name,H);
     12:Begin
      GDRun:=kbHexView;
      Break
     End;
    End;
   End
    Else
   Begin
    If(LastMouseX>=WEGetRX1(Q.W)+Q.MinX)Then Begin
     WaitMouseBut0;
     GDUnSelectBar(Q);
     OldX:=Q.X;OldY:=Q.Y;OldP:=Q.P;
     Dec(Q.P,Q.NumWidth*Q.Y);
     Q.X:=((LastMouseX-WEGetRX1(Q.W)-Q.MinX)shr 4);
     Q.Y:=((LastMouseY-WEGetRY1(Q.W))shr 3);
     Inc(Q.P,Q.NumWidth*Q.Y);
     GDSelectBar(Q);
     If(OldX=Q.X)and(OldY=Q.Y)and(OldP=Q.P)Then Goto Enter;
    End
     Else
    Begin
     GDRun:=DTRun(Q.Tree);
     T:=DTGetShortDir(Q.Tree,Q.Tree.P);
     If(T<>Q.Path)Then Begin
      Q.Path:=T;
      GDRefresh(Q);
     End;
     If WEInWindow(Q.W,LastMouseX,LastMouseY)Then Goto InWn;
     Break;
    End;
   End;
   kbEnter:Begin
Enter:
    BFGetFile(Q.Files,Q.P+Q.X,H);
    If(sfaDir)in(H.Attr.Flags)Then Begin
{     T:={Path2NoDir(Q.Path);}
     If H.Name='..'Then Begin
      If Q.Path[Length(Q.Path)]<>'\'Then BackStr(Q.Path);
      Q.Path:=Path2NoDir(Q.Path);
     End
      Else
     Begin
      Q.Path:=SetPath4AddFile(Q.Path)+H.Name;
      If Q.Path[Length(Q.Path)]<>'\'Then IncStr(Q.Path,'\');
     End;
{     AddStr(Q.Path,T);}
     Q.X:=0;Q.Y:=0;Q.P:=0;
     GDRefresh(Q);
     GDSelectBar(Q);
    End
     Else
    FullScreen(Q.Path+H.Name);
   End;
   kbLeft:If Q.X>0Then Begin
    GDUnSelectBar(Q);
    Dec(Q.X);
    GDSelectBar(Q);
   End
    Else
   If Q.Y>0Then Begin
    GDUnSelectBar(Q);
    Q.X:=Q.NumWidth-1;
    Goto Up;
   End;
   kbRight:If Q.P+Q.X<BFNumFiles(Q.Files)-1Then Begin
    If Q.X<Q.NumWidth-1Then Begin
     GDUnSelectBar(Q);
     Inc(Q.X);
     GDSelectBar(Q);
    End
     Else
    Begin
      GDUnSelectBar(Q);
     Q.X:=0;
     Goto Dn;
    End;
   End;
   kbRBarMsUp:Begin
    DelayMousePress(200);
    Goto kUp;
   End;
   kbRBarMsDn:Begin
    DelayMousePress(200);
    Goto kDn;
   End;
   kbUp:kUp:If Q.P>0Then Begin
    GDUnSelectBar(Q);
 Up:Dec(Q.P,Q.NumWidth);
    If Q.P<0Then Q.P:=0;
    If Q.Y>0Then Dec(Q.Y)
            Else GDRefreshImage(Q);
    GDSelectBar(Q)
   End;
   kbDn:kDn:If Q.P<BFNumFiles(Q.Files)-1Then Begin
    GDUnSelectBar(Q);
 Dn:Inc(Q.P,Q.NumWidth);
    If(Q.Y<Q.NumHeight-1)Then Inc(Q.Y)
                         Else GDRefreshImage(Q);
    GDSelectBar(Q)
   End;
   Else Begin
    GDRun:=K;
    Break;
   End;
  End;
 Until False;
 GDUnSelectBar(Q);
End;

Function GDTitle(Var Context;Max:Byte):String;Begin
 GDTitle:='Visualisateur Global';
End;

Procedure GDMove2(Var Context;X,Y:Byte);
Var
 Q:GlobalDrawApp Absolute Context;
Begin
 GDReSize(Q,X,Y,X+Q.W.T.X2-Q.W.T.X1,Y+Q.W.T.Y2-Q.W.T.Y1);
End;

Procedure GDReSize(Var Context;X1,Y1,X2,Y2:Byte);
Var
 Q:GlobalDrawApp Absolute Context;
Begin
 WEInit(Q.W,X1,Y1,X2,Y2);
 GDRefresh(Q);
End;

Function GDDone(Var Context):Word;
Var
 Q:GlobalDrawApp Absolute Context;
 Config:ConfigGlobalDraw;
Begin
 FillClr(Config,SizeOf(Config));
 Config.Len:=SizeOf(Config)-2;
 Config.Tri:=Q.Files.Tri;
 Config.Path:=Q.Path;
 Config.P:=Q.P;
 Config.X:=Q.X;
 Config.Y:=Q.Y;
 Config.MinX:=Q.MinX;
 CreateKeyFormat(HKEY_CURRENT_USER,'Software\ACDSee','Config',tdBlob,Config);
 GDFreeImage(Q);
 DTDone(Q.Tree);
 BFDone(Q.Files);
 GDDone:=0;
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
END.