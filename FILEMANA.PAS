{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                                                               Û
 ³        Malte Genesis/Module de Gestionnaire de fichiers       Û
 ³                                                               Û
 ³                          Adapter pour                         Û
 ³                                                               Û
 ³        dition Chantal pour Mode R‚el IV - Version 1.0;       Û
 ³    dition Extension AdŠle pour Mode R‚el V - Version 1.0.    Û
 ³                                                               Û
 ³                    1995/02/02 … 2002/08/23                    Û
 ³                                                               Û
 ³       Tous droits r‚serv‚ par les Chevaliers de Malte(C)      Û
 ³                                                               Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette unit‚ contient des routines permettant de cr‚er une fenˆtre ayant
 les mˆmes attrait qu'un gestionnaire de fichier tel le  Norton Commander
 de Symantec.


 Remarques
 ÍÍÍÍÍÍÍÍÍ

  ş Cette unit‚ tient  compte des fichiers  de descriptions du 4DOS et du
    NDOS nomm‚ ®DESCRIPT.ION¯.

  ş Lorsqu'on clique sur fichier ®*.ZIP¯ dans la fenˆtre … l'aide ®Enter¯
    ou de la souris,  il change de r‚pertoire et utilise comme une entr‚e
    de r‚pertoire  le fichier ®ZIP¯  sans toutefois pouvoir effectuer des
    modifications r‚el.

  ş La technique de chargement des noms de fichiers rapides est ®ShortBF¯
    et est utilis‚ en mode r‚el.

  ş Pour permettre  une lecture directe  des noms de fichiers sans passer
    par  l'interruption 21h,  il faut d‚finir la directive de compilation
    conditionnel  ®DirectDos¯  … vrai  et  ne  pas  oublier  de fixer  la
    variable de mˆme nom … vrai ‚galement.
}

{$I DEF.INC}

Unit FileMana;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                    INTERFACE
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses Systex,Isatex,Dialex;

Type
 WCopyRec=Record
  W:Window;
  BP:BarProgress;
 End;

Var WCopy:^WCopyRec; { BoŒte de dialogue lors de copie ou transfert de fichiers }

Function  FMInit(Var Context;X1,Y1,X2,_Y2:Byte):Boolean;
Function  FMExplorer(Var Context;X1,Y1,X2,_Y2:Byte):Boolean;
Function  FMNortonCommander(Var Context;X1,Y1,X2,_Y2:Byte):Boolean;
Procedure FMMove2(Var Context;X,Y:Byte);
Procedure FMReSize(Var Context;X1,Y1,X2,Y2:Byte);
Procedure FMReadFiles(Var Q:FileManagerApp;Pln:Byte);
Procedure FMReadTree(Var Q:FileManagerApp;Pln:Byte);
Procedure FMSetPath(Var Q:FileManagerApp;Pln:Byte;Const _Path:String);
Function  FMGetCurrName(Var Q:FileManagerApp):String;
Function  FMNumSel(Var Q:FileManagerApp):Word;
Procedure FMGetCurrFile(Var Q:FileManagerApp;Var Info:SearchRec);
Function  FMGetCurrPathTree(Var Q:FileManagerApp;Pln:Byte):String;
Procedure FMGetFile(Var Q:FileManagerApp;_P:Word;Var Info:SearchRec);
Procedure FMChgBoard(Var Q:FileManagerApp);
Procedure FMRefresh(Var Q:FileManagerApp;Full:Boolean);
Function  FMGetBarTree(Var Q:FileManagerApp;Pln:Byte;_P:RBP):String;
Function  FMGetPath(Var Q:FileManagerApp):String;
Procedure FMChDsk(Var Q:FileManagerApp);
Procedure FMPrincipalPath(Var Q:FileManagerApp);
Procedure FMPutBar(Var Q:FileManagerApp;_Plane,_Y:Byte;_P:RBP;Var Info:SearchRec);
Procedure FMPutDisk(Var Q:FileManagerApp;Pln:Byte);
Function  FMRun(Var Context):Word;
Procedure FMSelectBar(Var Q:FileManagerApp;_Plane:Byte);
Procedure FMUpdateBoard(Var Q:FileManagerApp;Pln:Byte);
Procedure FMInverseBoard(Var Q:FileManagerApp);
Procedure FMOldOtherBoard(Var Q:FileManagerApp);
Function  FMTitle(Var Q;Max:Byte):String;
Procedure FMChangeCurrDirectory(Var Q:FileManagerApp;Const DirName:String);
Function  FMDone(Var Context):Word;
Procedure _FMRefresh(Var Q);
Function  RawSelectDisk(OldChoice:Byte):Byte;
Function  SelectDisk(OldChoice:Byte):Byte;
Function  SelectNewDisk(OldChoice:Byte):Byte;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                               IMPLEMENTATION
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses
 Adele,
 Memories,
 Systems,
 Video,
 Dials,
 Terminal,
 Mouse,
 Disk,
 Math,
 Registry,
 ToolHead,
 Packex,
 Show,
 SysPlus,
 ToolView,
 SysInter,
 Restex,
 ResLoadI,
 ResServI,
 ResSaveI,
 DialPlus,
 ToolDsk,
 ToolFile,
 PrnFileM,
 Sound,
 ToolMusi,
 EdtLoad,
 EdtSave,
 DialTree,
 ToolTerm;

Procedure FMPutIconAssociate(Var Q:FileManagerApp;_Plane:Byte;P:Word;Var Info:SearchRec);Near;Forward;
Procedure FMPutBarTree(Var Q:FileManagerApp;Pln,_Y:Byte;_P:RBP);Near;Forward;
Procedure WEResearchTree(Var Q:FileManagerApp);Near;Forward;
Procedure FMUndoBar(Var Q:FileManagerApp);Near;Forward;
Procedure FMkUp(Var Q:FileManagerApp);Near;Forward;
Procedure FMkDn(Var Q:FileManagerApp);Near;Forward;
Procedure FMkPgUp(Var Q:FileManagerApp);Near;Forward;
Procedure FMkPgDn(Var Q:FileManagerApp);Near;Forward;
Procedure FMkHome(Var Q:FileManagerApp);Near;Forward;
Procedure FMkEnd(Var Q:FileManagerApp);Near;Forward;
Procedure FMPutSelect(Var Q:FileManagerApp;Pln:Byte);Near;Forward;
Procedure _FMSetPath(Var Q:FileManagerApp;Pln:Byte;Const _Path:String);Near;Forward;

Type
 SearchPChr=Record
  Fill:Array[0..16]of Char;
  PC:PChr;
 End;

Function LZHorSwagSign(Var LZH:LZHEntryFiles):Boolean;Near;
Var SignLZH,SignSWAG:Array[0..2]of Char;Begin
 SignLZH:='lh'#0;SignSwag:='sw'#0;
 LZH.PackSize:=0;
 LZHorSwagSign:=(StrPos(@LZH.HeadID,@SignLZH)<>NIL)or
                (StrPos(@LZH.HeadID,@SignSWAG)<>NIL);
End;

Function PackedRec(Handle:Hdl):Boolean;Near;
Var
 Buffer:Array[0..127]of Byte;
 ArjSign:Word Absolute Buffer;
 LZH:LZHEntryFiles Absolute Buffer;
 ZipSign:Long Absolute Buffer;
 CabSign:Array[0..3]of Char Absolute Buffer;
 RAR:Array[0..6]of Char Absolute Buffer;
 ZooSign:Array[0..2]of Char Absolute Buffer;
 Arc:ArcHeader Absolute Buffer;
Begin
 _GetAbsRec(Handle,0,SizeOf(Buffer),Buffer);
 PackedRec:=(ArjSign=60000)or
            (CabSign='MSCF')or
            (CabSign=PAKSign)or
            (ZipSign=$04034B50)or
            (ZooSign='ZOO')or
            (RAR=RARSign)or
            ((Arc.HeadID=$1A)and(Not(Arc.DataType in[0,10,13,32,65..255])))or
            ((LZH.PackSize<LZH.OrigSize)and(LZH.HeadSize<>0)and
             (Length(LZH.FileName)>0)and(LZHorSwagSign(LZH)));
End;

Function PackedFile(Const Name:String):Boolean;Near;
Var
 Buffer:Array[0..127]of Byte;
 ArjSign:Word Absolute Buffer;
 LZH:LZHEntryFiles Absolute Buffer;
 ZipSign:Long Absolute Buffer;
 CabSign:Array[0..3]of Char Absolute Buffer;
 RAR:Array[0..6]of Char Absolute Buffer;
 ZooSign:Array[0..2]of Char Absolute Buffer;
 Arc:ArcHeader Absolute Buffer;
Begin
 GetFile(Name,0,SizeOf(Buffer),Buffer);
 PackedFile:=(ArjSign=60000)or
             (CabSign='MSCF')or
             (CabSign=PAKSign)or
             (ZipSign=$04034B50)or
             (ZooSign='ZOO')or
             (RAR=RARSign)or
             ((Arc.HeadID=$1A)and(Not(Arc.DataType in[0,10,13,32,65..255])))or
            ((LZH.PackSize<LZH.OrigSize)and(LZH.HeadSize<>0)and
             (Length(LZH.FileName)>0)and(LZHorSwagSign(LZH)));
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ·}
{³             O b j e t  P a n e l F i l e M a n a g e r      º}
{ÔÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼}

Procedure PFMSetKrItem(Var Q:PanelFileManager);Near;
Var
 Color:Byte;
Begin
 If(IsGrf)and(BitsPerPixel=1)Then Color:=$F Else
 If(Q.W.Palette.Border shr 4=7)or
   (Q.W.Palette.Border shr 4=$F)Then Color:=$0
                                Else Color:=$B;
 WESetKrBorderF(Q.W,Color);
End;

Procedure PFMSetKr(Var Q:PanelFileManager;P:Word);Near;Begin
 If(Q.Board=BoardTree)Then PFMSetKrItem(Q)Else
 If Q.Select^[P]Then Begin
  If Q.W.Palette.Border and$F0=$F0Then WESetKrBorderF(Q.W,LightRed)
                                  Else WESetKrBorderF(Q.W,Yellow);
 End
  Else
 PFMSetKrItem(Q);
End;

Procedure PFMPutFileStatus(Var Q:PanelFileManager);Near;Begin
 If(IsGrf){$IFNDEF GraphicOS}and Not(HoleMode){$ENDIF}Then Begin
  BarSpcHorRelief(Q.W.T.X1,Q.W.T.Y2,Q.W.T.X2,Q.W.Palette.Title);
  BarSpcHorReliefExt(Q.W.T.X1+1,Q.W.T.Y2,Q.W.T.X2-2,Q.W.Palette.Title);
  LuxeBox(Q.W.T.X2-1,Q.W.T.Y2);
 End;
 If BFNumFiles(Q.BF)=0Then
  WESetEndBarTxtX(Q.W,2,'Pas de fichier',Q.W.Palette.Title)
 Else
  WESetEndBarTxtX(Q.W,2,CStr(Q.SizeSelect)+' Fichiers',Q.W.Palette.Title);
End;

Procedure PFMPutIdentificator(Var Q:PanelFileManager);Near;
Var
 S:String;
 L,DL:Byte;
 LT:ListTitle;
 RX1:Byte;
Begin
 DL:=14;
 If Q.W.MaxX>47Then L:=13 Else
 If Q.W.MaxX>46Then L:=12 Else
 If Q.W.MaxX>45Then L:=11
  Else
 Begin
  L:=7;
  Dec(DL);
 End;
 RX1:=WEGetRX1(Q.W);
 If(Q.DescrList)Then S:='  Description|'
                Else S:='  Nom      Ext|';
 AddStr(S,'Taille|Date|Heure|');
 {$IFDEF DirectDos}
  If(DirectDos)Then S:=Spc(4)+'1ier cluster';
 {$ENDIF}
 LTInit(LT,RX1,WEGetRY1(Q.W),RX1+Q.W.MaxX,S);
 LTSetColumnSize(LT,0,DL);
 LTSetColumnSize(LT,1,L);
 LTSetColumnSize(LT,2,9+Byte(Q.W.MaxX>40));
 LTSetColumnSize(LT,3,8);
 LTRefresh(LT);
End;

Function PFMGetRealPath(Var Q:PanelFileManager;Max:Byte):String;Near;
Var
 LongFileName:Boolean;
 LongName,Target:Array[Byte]of Char;
Begin
 LongFileName:=((Win=winEnhanced)and(WinLoVer=4))or
               ((Hi(GetDosVer)=5)and(Lo(GetDosVer)=50));
 If(LongFileName)and((Q.DescrList){or(Q.Explorer)})Then Begin
  StrPascalCopy(LongName,SizeOf(LongName),Path2Dir(Q.Path));
  LGetLongName(LongName,Target);
  PFMGetRealPath:=TruncName(StrPas(@Target)+Path2NoDir(Q.Path),Max);
 End
  Else
 PFMGetRealPath:=TruncName(Q.Path,Max);
End;

Procedure PFMInitData(Var Q:PanelFileManager);Near;Begin
 BFInit(Q.BF);
 Q.Res.Output:=$FF;
 Q.RM.Output:=$FF;
 Q.BF.Tri:=fName;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ·}
{³                  O b j e t  F i l e M a n a g e r           º}
{ÔÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼}

Procedure FMSetKrItem(Var Q:FileManagerApp;Plane:Byte);Near;Begin
 PFMSetKrItem(Q.Panel[Plane]);
End;

{ Cette fonction permet  de retourner le nom de r‚pertoire correspondant
 au tableau. S'il est en mode description il retournera le nom long sous
 Windows 95/98/NT.
}

Function FMGetRealPath(Var Q:FileManagerApp;Plane,Max:Byte):String;Near;Begin
 FMGetRealPath:=PFMGetRealPath(Q.Panel[Plane],Max);
End;

Function FMFolderFound:Boolean;Near;Begin
 FMFolderFound:=(IsGrf)and(MediaSupport)and(BitsPerPixel>=4)and
                (FolderIcon<>NIL)and(FolderIcon^.Output<>$FF)
                {$IFNDEF GraphicOS}and Not(HoleMode){$ENDIF};
End;

{ Cette proc‚dure permet d'effectuer l'affichage d'un texte ASCII dans
 le panneau de visualisation d‚signer.
}

Procedure FMViewAscii(Var Q:FileManagerApp;Pln:Byte;Var H:SearchRec);Near;
Var
 ViewAscii:ViewAsciiApp;
Begin
 VAInitRaw(ViewAscii,Q.Panel[Pln].W.T.X1,Q.Panel[Pln].W.T.Y1,
                     Q.Panel[Pln].W.T.X2,Q.Panel[Pln].W.T.Y2,
                     Path2Dir(Q.Panel[Pln xor 1].Path)+H.Name);
 VADone(ViewAscii);
End;

Procedure FMViewBoard(Var Q:FileManagerApp;Pln:Byte);Near;
Label ReadImage;
Var
 H:SearchRec;
 Handle:Hdl;
 FP:LongInt;
 GX1,GY1,GX2,GY2,MX,MY,J,BPL:Word;
 Res:ImageHeaderRes;
 Buf:^TByte;
 Inf:MCanvas;
 S:String;
Begin
 BFGetFile(Q.Panel[Pln xor 1].BF,Q.Panel[Pln xor 1].P,H);
 XFreeMem(Q.Panel[Pln].Res);
 XFreeMem(Q.Panel[Pln].RM);
 WEClrScr(Q.Panel[Pln].W);
 S:=Path2Dir(Q.Panel[Pln xor 1].Path);
 If(H.Attr.Value and faDir=0)and(RILoadImage(S+H.Name,
    diAutoDetect,0,$FFFF,rmAllResSteady,
    [fpUserInterrupt],Q.Panel[Pln].Res)=0)Then Begin
ReadImage:
  XGetAbsRec(Q.Panel[Pln].Res,0,SizeOf(Res),Res);
  GX1:=WEGetRX1(Q.Panel[Pln].W);
  GY1:=WEGetRY1(Q.Panel[Pln].W);
  GX2:=GX1+Q.Panel[Pln].W.MaxX;GY2:=GY1+Q.Panel[Pln].W.MaxY;
  GX1:=GX1 shl 3;GY1:=GetRawY(GY1);GX2:=(GX2 shl 3)+7;
  GY2:=GetRawY(GY2+2)-1-8;
  PutFillBox(GX1,GY2-8,GX2,GY2,Q.W.CurrColor shr 4);
  If(IsGrf)Then Begin
   MY:=GY2-GY1;MX:=Res.NumXPixels;
   If MX>GX2-GX1+1Then MX:=GX2-GX1+1
                  Else Inc(GX1,((GX2-GX1+1)-Res.NumXPixels)shr 1);
   If Res.NumYPixels<GY2-GY1+1Then Inc(GY1,((GY2-GY1+1)-Res.NumYPixels)shr 1);
   If Res.BitsPerPixel>=4Then Begin
    RIRes2WnImg(Q.Panel[Pln].Res,Inf);
    Inf.Miroir:=Q.Panel[Pln].RM;
    RIMakeDoublon(Q.Panel[Pln].Res,rmAllRes,False,Inf);
    Q.Panel[Pln].RM:=Inf.Miroir;
    BPL:=Res.NumXPixels;
    Case(BitsPerPixel)of
     4:If Res.BitsPerPixel>=8Then BPL:=BPL shr 1;
     9..16:BPL:=BPL shl 1;
     17..24:BPL:=BPL+(BPL shl 1);
    End;
    Buf:=MemAlloc(BPL);
    If(Buf<>NIL)Then Begin
     For J:=0to Res.NumYPixels-1do Begin
      If(J>MY)Then Break;
      XGetAbsRec(Q.Panel[Pln].RM,Long(J)*Long(BPL),BPL,Buf^);
      If(BitsPerPixel=4)and(Res.BitsPerPixel>=8)Then Begin
       ClrLnHorImg(GX1,GY1+J,MX,8,Buf^);
      End
       Else
      ClrLnHorImg(GX1,GY1+J,MX,BitsPerPixel,Buf^);
     End;
     FreeMemory(Buf,BPL);
    End;
   End
    Else
   Begin
    Buf:=MemAlloc(Res.BytesPerLine);
    If(Buf<>NIL)Then Begin
     For J:=0to Res.NumYPixels-1do Begin
      If(J>MY)Then Break;
      XGetAbsRec(Q.Panel[Pln].Res,SizeOf(Res)+Long(J)*Long(Res.BytesPerLine),Res.BytesPerLine,Buf^);
      ClrLnHorImg(GX1,GY1+J,MX,Res.BitsPerPixel,Buf^);
     End;
     FreeMemory(Buf,Res.BytesPerLine);
    End;
   End;
  End;
 End
  Else
 Begin
  BackStr(S);
  Handle:=FileOpen(S,fmRead);
  If(Handle<>errHdl)and(PackedRec(Handle))Then Begin
   FP:=Long(Pointer(@H.Fill[14])^);
   If RIReadImage(Handle,diAutoDetect,FP,0,$FFFF,rmAllResSteady,
                  [fpUserInterrupt],Q.Panel[Pln].Res)=0Then Begin
    FileClose(Handle);
    Goto ReadImage;
   End;
   FileClose(Handle);
  End
   Else
  Begin
    { Regarde ASCII }
   If H.Attr.Value and faDir=0Then FMViewAscii(Q,Pln,H);
  End;
 End;
End;

{ Cette proc‚dure permet de fixer la couleur par d‚faut d'un ‚l‚ment de
 la liste du gestionnaire de fichiers.
}

Procedure FMSetKr(Var Q:FileManagerApp;Pln:Byte;P:Word);Near;Begin
 PFMSetKr(Q.Panel[Pln],P);
End;

Procedure FMPutFileStatus(Var Q:FileManagerApp;Pln:Byte);Near;Begin
 PFMPutFileStatus(Q.Panel[Pln]);
End;

Procedure FMPutRawDriveIconXY(Var Q:FileManagerApp;X,Y,Dsk:Byte);Near;
Var
 T:^XInf;
 Buffer:Array[0..255]of Byte;
 GX,GY,I,J:Word;
Begin
 If(IsGrf){$IFNDEF GraphicOS}and Not(HoleMode){$ENDIF}Then Begin
  If DiskFixed(Dsk+1)Then Begin
   If Q.HR.Output=$FFThen
    RILoadImage('SYS:MEDIA.RLL',diAutoDetect,4,imHardDiskIcon,
                rmAllResSteady,[],Q.HR);
   T:=@Q.HR;
  End
   Else
  If IsCDROM(Dsk)Then Begin
   RILoadImage('SYS:MEDIA.RLL',diAutoDetect,4,imCDROMIcon,
                rmAllResSteady,[],Q.CR);
   T:=@Q.CR;
  End
   Else
  Begin
   If Q.DR.Output=$FFThen
    RILoadImage('SYS:MEDIA.RLL',diAutoDetect,4,imDriveIcon,
                rmAllResSteady,[],Q.DR);
   T:=@Q.DR;
  End;
  GX:=X shl 3;GY:=GetRawY(Y);
  XGetAbsRec(T^,SizeOf(ImageHeaderRes),SizeOf(Buffer),Buffer);
  I:=0;
  For J:=0to HeightChr-1do Begin
   ClrLnHorSprite(GX,GY,16,4,Buffer[I]);
   Inc(I,8);
   Inc(GY);
  End;
 End;
End;

Procedure FMPutDriveIconXY(Var Q:FileManagerApp;X,Y,Pln:Byte);Near;Begin
 FMPutRawDriveIconXY(Q,X,Y,Path2Dsk(Q.Panel[Pln].Path));
End;

Procedure FMPutDriveIcon(Var Q:FileManagerApp;Pln:Byte);Near;Begin
 FMPutDriveIconXY(Q,Q.Panel[Pln].W.T.X1,Pred(Q.Panel[Pln].W.T.Y1),Pln);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Proc‚dure _FMRefresh                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: FileManager
 Portabilit‚:  Globale


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure effectue une mise … jour de la fenˆtre de gestionnaire
 de fichier sans pour autant effectuer une relecture des r‚pertoires.
}

Procedure _FMRefresh;Begin
 FMRefresh(FileManagerApp(Q),False)
End;

Procedure FMPutIdentificator(Var Q:FileManagerApp;Pln:Byte);Near;Begin
 PFMPutIdentificator(Q.Panel[Pln]);
End;

Procedure PFMPutHeaderFile(Var Q:PanelFileManager;CurrPanel:Boolean);Near;
Var
 OldHole:Boolean;
Begin
 Dec(Q.W.T.Y1);
 Include(Q.W.Attribut,winNotClearBackground);
 Include(Q.W.Attribut,winNotBorderDown);
 {$IFNDEF GraphicOS}
  If Not(CurrPanel)Then Begin
   OldHole:=HoleMode;HoleMode:=True;
  End;
 {$ENDIF}
 _WEPutWn(Q.W,PFMGetRealPath(Q,Q.W.MaxX));
 WESetEndBarCTitle(Q.W);
 {$IFNDEF GraphicOS}
  If Not(CurrPanel)Then HoleMode:=OldHole;
 {$ENDIF}
 PFMPutIdentificator(Q);
 Inc(Q.W.T.Y1);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Proc‚dure FMPutHeaderFile                  Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: FileManager


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure ‚crit l'entˆte de tous les fichiers dans le tableau
 sp‚cifier par la variable de param‚trage ®Pln¯.
}

Procedure FMPutHeaderFile(Var Q:FileManagerApp;Pln:Byte);Near;Begin
 PFMPutHeaderFile(Q.Panel[Pln],Pln=Q.Plane);
End;

Procedure FMCopyFileName2Clipboard(Var Q:FileManagerApp);Near;
Var
 I,NF:Integer;
 Info:SearchRec;
Begin
 If(Q.Panel[Q.Plane].Board=BoardFile)Then Begin
  NF:=BFMaxFiles(Q.Panel[Q.Plane].BF);
  MakeClipboard(NF*14);
  For I:=0to(NF)do Begin
   FMGetFile(Q,I,Info);
   PutClipboardTxt(Info.Name+CRLF);
  End;
 End
  Else
 ErrNoMsgOk(CopyIncompatible);
End;

Procedure FMInitData(Var Q:FileManagerApp;X1,Y1,X2,_Y2:Byte);Near;Begin
 FillClr(Q,SizeOf(Q));
 ExtensiorInit(Q.ExtImg);
 Q.DR.Output:=$FF;Q.HR.Output:=$FF;Q.CR.Output:=$FF;
 Q.Panel[1].Board:=BoardInfo;Q.Panel[0].Board:=BoardFile;
 WEInit(Q.W,X1,Y1,X2,_Y2);
 Include(Q.W.Attribut,winNotClearBackground);
 Q.Panel[0].Path:=SetPath4AddFile(GetCurrentDir)+'*.*';
 Q.Panel[1].Path:=Q.Panel[0].Path;
 PFMInitData(Q.Panel[0]);
 PFMInitData(Q.Panel[1]);
 Q.WildCard:='*.*';
 HYInit(Q.HWildCard,256);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure FMInit                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: FileManager


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure initialise le tableau  de gestionnaire de fichier en
 d‚finissant d'un c“t‚ un tableau de fichier et de l'autre une fenˆtre
 d'information.
}

Function FMInit;
Var
 Q:FileManagerApp Absolute Context;
Begin
 FMInitData(Q,X1,Y1,X2,_Y2);
 FMRefresh(Q,True);
 FMInit:=True;
End;

Function FMExplorer{Var QX;X1,Y1,X2,_Y2:Byte):Boolean};
Var
 Q:FileManagerApp Absolute Context;
Begin
 FMInitData(Q,X1,Y1,X2,_Y2);
 Q.Panel[1].Board:=BoardFile;
 Q.Panel[0].Board:=BoardExplorer;
 DTInitBureau(Q.Panel[0].EW,X1,Y1,X2,_Y2);
{ DTChDir(Q.Panel[0].EW,Q.Panel[0].Path);}
 Q.Explorer:=True;
 FMRefresh(Q,True);
 FMExplorer:=True;
End;

Type
 CloneCommanderConfig=Record
  Len:Word;
  Board:Byte;
  Brief:Boolean;
  Status:Boolean;
  P:LongInt;
  Y:Byte;
  Res:Array[0..15]of Byte;
  Path:String;
 End;

Function FMNortonCommander{Var QX;X1,Y1,X2,_Y2:Byte):Boolean};
Var
 Q:FileManagerApp Absolute Context;
 CCC:CloneCommanderConfig;
 P:Array[0..1]of LongInt;
 Y:Array[0..1]of Byte;
 I:Byte;
Begin
 FMInitData(Q,X1,Y1,X2,_Y2);
 For I:=0to 1do Begin
  Q.Panel[I].Board:=BoardFile;
  If ReadMainKey(HKEY_CURRENT_USER,'Software\CloneCommander',WordToStr(I),CCC)Then Begin
   Q.Panel[I].Board:=CCC.Board;
   Q.Panel[I].Brief:=CCC.Brief;
   Q.Panel[I].Status:=CCC.Status;
   P[I]:=CCC.P;
   Y[I]:=CCC.Y;
   Q.Panel[I].Path:=CCC.Path;
  End;
 End;
 Q.NortonCommander:=True;
 FMRefresh(Q,True);
 For I:=0to 1do Begin
  If(P[I]or Y[I]>0)and(BFNumFiles(Q.Panel[I].BF)>=P[I])Then Begin
   Q.Panel[I].P:=P[I];
   Q.Panel[I].Y:=Y[I];
   FMUpdateBoard(Q,I);
  End;
 End;
 FMNortonCommander:=True;
End;

Procedure FMReSize{Var QX;X1,Y1,X2,Y2:Byte};
Var
 Q:FileManagerApp Absolute Context;
Begin
 WEDone(Q.W);
 WEInit(Q.W,X1,Y1,X2,Y2);
 FMRefresh(Q,False);
End;

Procedure FMMove2{Var QX;X,Y:Byte};
Var
 Q:FileManagerApp Absolute Context;
Begin
 FMReSize(Q,X,Y,X+Q.W.T.X2-Q.W.T.X1,Y+Q.W.T.Y2-Q.W.T.Y1);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Proc‚dure FMChDsk                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: FileManager


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure change l'unit‚ courante du tableau actuellement en usage
 et effectue  une mise  … jour  sur le tableau d'informations  s'il y en …
 actuel un.
}

Procedure FMChDsk;
Var
 Disk,Out:Byte;
Begin
 Disk:=Path2Dsk(FMGetPath(Q))+1;
 Out:=SelectDisk(Disk);
 If Out=$FFThen Exit;
 If(Out<>Disk)Then Begin
  If(Q.Panel[Q.Plane].Board=BoardFile)Then Dec(Q.Panel[Q.Plane].W.T.Y1);
  Q.Panel[Q.Plane].Path:=Chr(Out+Byte('@'))+':*.*';
  If(Q.Panel[Q.Plane].Board=BoardTree)Then Q.Panel[Q.Plane xor 1].Path:=Q.Panel[Q.Plane].Path;
  FMRefresh(Q,True);
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure FMPrincipalPath                   Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: FileManager


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure change le r‚pertoire d'un tableau celui racine du mˆme
 unit‚ disque. Si le tableau  n'est pas  une fenˆtre de fichier,  il est
 chang‚ automatiquement.
}

Procedure FMPrincipalPath;Begin
 FMSetPath(Q,Q.Plane,Path2Drv(Q.Panel[0].Path)+':\*.*')
End;

Procedure PutIconMenu(X,Y:Byte;Level:Word);Far;
Type
 FileManagerPtr=^FileManagerApp;
Var
 Q:FileManagerPtr Absolute WCopy;
Begin
 FMPutDriveIconXY(Q^,X,Y+7,Q^.Plane);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Proc‚dure FMChgBoard                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: FileManager


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de changer le tableau courant (droite ou gauche) de
 l'objet   de  Gestionnaire   de  fichiers.   Il  demande pour  ce  faire  …
 l'utilisateur quel est son choix.
}

Procedure FMChgBoard;
Var
 E:Byte;

 Function MouseMenu:Byte;
 Const
  fmInfo=$F001;
  fmFiles=$F002;
  fmTree=$F003;
  fmPreView=$F004;
  fmInverse=$F005;
  fmDrive=$F006;
  fmRead=$F007;
  fmPrn=$F008;
  fmCopyName2Clipboard=$F009;
  fmSel=$F00A;
  fmUnSel=$F00B;
  fmRoot=$F00C;
 Var
  K:Word;
  TM:MainMnuPtr;
  XM:Byte;
  CM:ContextMenu;
  PL:Boolean;
 Begin
  MouseMenu:=0;
  PL:=Q.Panel[Q.Plane].Board=BoardFile;
  _CMLoadApp(CM,21,PL);
  WCopy:=@Q;
  MainMenu.Space4Icon:=2;
  MainMenu.IconRoutine:=PutIconMenu;
  ALSetPtr(MainMenu.Mnu,0);
  TM:=_ALGetCurrBuf(MainMenu.Mnu);
  If(LastMouseX>=Q.Panel[Q.Plane].W.T.X1)and(LastMouseX<=Q.Panel[Q.Plane].W.T.X2)Then XM:=LastMouseX
  Else XM:=Q.Panel[Q.Plane].W.T.X1;
  K:=PMExecMnu(XM,Q.Panel[Q.Plane].W.T.Y1,TM^.Lst,TM^.P);
  CMDone(CM);
  Case(K)of
   fmInfo:MouseMenu:=BoardInfo;
   fmFiles:MouseMenu:=BoardFile;
   fmTree:MouseMenu:=BoardTree;
   fmPreView:MouseMenu:=BoardView;
   fmInverse:MouseMenu:=$7F;
   fmDrive:MouseMenu:=$80;
   fmRead:MouseMenu:=$81;
   fmPrn:MouseMenu:=$82;
   fmCopyName2Clipboard:MouseMenu:=$83;
   fmSel:MouseMenu:=$84;
   fmUnSel:MouseMenu:=$85;
   fmRoot:MouseMenu:=$86;
   kbMouse:WaitMouseBut0;
  End;
 End;

Begin
 E:=MouseMenu;
 Case(E)of
  $7F:FMInverseBoard(Q);
  $80:Begin
   FMChDsk(Q);
   If Not(Q.Panel[Q.Plane].Board in[BoardFile,BoardTree])Then
    FMSetPath(Q,Q.Plane,Q.Panel[Q.Plane].Path)
  End;
  $81:FMReadFiles(Q,Q.Plane);
  $82:FMPrnDir(Q);
  $83:FMCopyFileName2Clipboard(Q);
  $84:FMSelWildCard(Q);
  $85:FMUnSelWildCard(Q);
  $86:FMPrincipalPath(Q);
  Else Begin
   If E=0Then Exit;
   If(Q.Panel[Q.Plane].Board=BoardFile)Then Begin
    Dec(Q.Panel[Q.Plane].W.T.Y1);
   End;
   Q.Panel[Q.Plane].Board:=E;
   FMRefresh(Q,Q.Panel[Q.Plane].Board in[BoardFile,BoardTree]);
  End;
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Proc‚dure FMReadTree                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: FileManager


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de (re)lire tous les r‚pertoires d'une unit‚ disque
 pour ensuite les communiqu‚s … l'objet  de Gestionnaire de fichiers.


 Remarque
 ÍÍÍÍÍÍÍÍ

  ş Si un fichier les contients d‚j…  alors il les lit  … partir du fichier.
    Le fichier doit porter un nom pr‚cis et ˆtre dans le r‚pertoire ®Malte¯.
    Son nom est ®TREE?.MBT¯, o— le ®?¯ est la lettre de l'unit‚.
}

Procedure FMReadTree;
Label errOpen;
Var
 J,OldPln:Byte;
 Info:FileInfoType;
 L:Window;
 Handle:Hdl;
 TreeName:String;
Begin
 WEPushEndBar(L);
 WEPutLastBar('Lecture des r‚pertoires en cours...');
 FreeMemory(Q.Panel[Pln].BufTree.Ptr,SizeOf(Q.Panel[Pln].BufTree.Ptr));
 FillClr(Q.Panel[Pln].BufTree,SizeOf(Q.Panel[Pln].BufTree));
 TreeName:=MaltePath+'TREE'+Path2Drv(Q.Panel[Pln xor 1].Path)+'.MBT';
 If FileExist(TreeName)Then Begin
  Handle:=FileOpen(TreeName,fmRead);
  If(Handle=errHdl)Then Goto errOpen;
  Q.Panel[Pln].BufTree.NB:=(FileSize(Handle)-SizeOf(Info))div 12;
  Q.Panel[Pln].BufTree.Ptr:=MemAlloc(Q.Panel[Pln].BufTree.NB*12);
  SetFilePos(Handle,0);
  _GetRec(Handle,SizeOf(Info),Info);
  If(Q.Panel[Pln].BufTree.Ptr<>NIL)Then
   _GetRec(Handle,Q.Panel[Pln].BufTree.NB*12,Q.Panel[Pln].BufTree.Ptr^);
  FileClose(Handle)
 End
  Else
 Begin
errOpen:
  Q.Panel[Pln].BufTree.Ptr:=GetFileInfo(Path2Drv(Q.Panel[Pln xor 1].Path),Info,
                            Q.Panel[Pln].BufTree.SizePtr,Q.Panel[Pln].BufTree.NB);
  Handle:=FileCreate(TreeName);
  _SetRec(Handle,SizeOf(Info),Info);
  _SetRec(Handle,Q.Panel[Pln].BufTree.NB*12,Q.Panel[Pln].BufTree.Ptr^);
  FileClose(Handle)
 End;
 WEDone(L);
 Q.Panel[Pln].Path:=Path2Drv(Q.Panel[Pln xor 1].Path)+':\';
 WESetPosHome(Q.Panel[Pln].W);
 FMSetKrItem(Q,Pln);
 For J:=0to(Q.Panel[Pln].W.MaxY)do FMPutBarTree(Q,Pln,J,J);
 WESetEndBarCTitle(Q.Panel[Pln].W);
 If(IsGrf)Then BarSpcHorRelief(Q.Panel[Pln].W.T.X1,Q.Panel[Pln].W.T.Y2,Q.Panel[Pln].W.T.X2,Q.Panel[Pln].W.Palette.Title);
 WESetEndBarTxtX(Q.Panel[Pln].W,2,CStr(Q.Panel[Pln].BufTree.NB)+' R‚pertoires',Q.Panel[Pln].W.Palette.Title);
 FMPutSelect(Q,Pln);
 FMSelectBar(Q,Pln);
 OldPln:=Q.Plane;Q.Plane:=Pln xor 1;
 WEResearchTree(Q);
 Q.Plane:=OldPln;
End;

Procedure PutLabel(X,Y,L:Byte;Const S:String;Attr:Byte);
Var
 GY1:Word;
Begin
 If Not InBarHole(X,Y,L+4)Then Begin
  GY1:=Y*HeightChr;
  PutFillRoundRectZone(X shl 3,GY1,((X+L+3)shl 3)+7,GY1+HeightChr-1,HeightChr-1,Attr shr 4,[ztSouth]);
  PutLnHor((X+2)shl 3,GY1+HeightChr-1,((X+3+L)shl 3)-7,Attr shr 4);
  PutTxtXY(X+2+((L-Length(S))shr 1),Y,S,Attr);
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Proc‚dure FMUpdateLabel                    Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: FileManager
 Portabilit‚:  Local


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet l'affichage des onglets correspondant au deux
 panneau du gestionnaire de fichiers.
}

Procedure FMUpDateLabel(Var Q:FileManagerApp);Near;
Var
 I,Attr:Byte;
Begin
 If(IsGrf)and(HeightChr>=14)Then For I:=0to 1do Begin
  If(Q.Plane=I)Then Attr:=$E0 Else Attr:=$60;
  PutLabel(Q.Panel[I].W.T.X1,Q.Panel[I].W.T.Y2+1,8,'Fichiers',Attr);
  If(Q.Plane=I)Then Attr:=$A0 Else Attr:=$20;
  PutLabel(Q.Panel[I].W.T.X1+12,Q.Panel[I].W.T.Y2+1,8,'Arbre',Attr);
  If(Q.Plane=I)Then Attr:=$B0 Else Attr:=$30;
  PutLabel(Q.Panel[I].W.T.X1+24,Q.Panel[I].W.T.Y2+1,8,'Info',Attr);
 End;
End;

Procedure PFMRefresh(Var Q:PanelFileManager;Parent:FileManagerApp;Full,CurrPanel:Boolean);
Var
 OldHole:Boolean;
Begin
 Q.W.Palette:=Parent.W.Palette;
 If Q.W.Palette.Border shr 4=7Then Begin
  Q.W.Palette.Border:=Q.W.Palette.Border or $80;
  Q.W.Palette.High:=Q.W.Palette.Border;
 End;
 Q.W.Palette.Title:=CurrKrs.FileManager.SubTitle;
 Case(Q.Board)of
  BoardExplorer:Begin
   Q.EW.W:=Q.W;
   {$IFNDEF GraphicOS}
    If Not(CurrPanel)Then Begin
     OldHole:=HoleMode;HoleMode:=True;
    End;
   {$ENDIF}
   _WEPutWn(Q.W,'Dossier');
   {$IFNDEF GraphicOS}
    If Not(CurrPanel)Then HoleMode:=OldHole;
   {$ENDIF}
   DTRefresh(Q.EW);
  End;
  BoardView:Begin
   {$IFNDEF GraphicOS}
    If Not(CurrPanel)Then Begin
     OldHole:=HoleMode;HoleMode:=True;
    End;
   {$ENDIF}
   _WEPutWn(Q.W,'Pr‚-Visualisation');
   {$IFNDEF GraphicOS}
    If Not(CurrPanel)Then HoleMode:=OldHole;
   {$ENDIF}
  End;
  BoardInfo:Begin
   {$IFNDEF GraphicOS}
    If Not(CurrPanel)Then Begin
     OldHole:=HoleMode;HoleMode:=True;
    End;
   {$ENDIF}
   _WEPutWn(Q.W,'Informations');
   {$IFNDEF GraphicOS}
    If Not(CurrPanel)Then HoleMode:=OldHole;
   {$ENDIF}
(*   FMPutDisk(Q,I);
   WESetKrBorder(Q.W);
   WEPutSmlTxtLn(Q.W,'Espace r‚pertoire utilis‚:');
   If(DescrInFile){$IFNDEF GraphicOS}and Not(HoleMode){$ENDIF}Then
    WEPutSmlTxtXY(Q.W,0,wnMax-4,'Description du fichier courant:');
   WEPutSmlTxtXY(Q.W,0,wnMax-1,'S‚lection:');*)
  End;
  BoardFile:Begin
   Dec(Q.W.MaxY);
   Dec(Q.W.HeightBar);
   Inc(Q.W.T.Y1);
   PFMPutHeaderFile(Q,CurrPanel);
{   FMPutFileStatus(Q,I);}
  End;
  BoardTree:Begin
   {$IFNDEF GraphicOS}
    If Not(CurrPanel)Then Begin
     OldHole:=HoleMode;HoleMode:=True;
    End;
   {$ENDIF}
   _WEPutWn(Q.W,'Arbre R‚pertoire');
   {$IFNDEF GraphicOS}
    If Not(CurrPanel)Then HoleMode:=OldHole;
   {$ENDIF}
   WEPutBarMsRight(Q.W);
(*   If(Full)Then FMReadTree(Q,I)Else Begin
    WESetPosHome(Q.Panel[I].W);
    FMSetKrItem(Q,I);
    For J:=0to(Q.Panel[I].W.MaxY)do FMPutBarTree(Q,I,J,J+Q.Panel[I].P-Q.Panel[I].Y);
    WESetEndBarCTitle(Q.Panel[I].W);
    {$IFNDEF GraphicOS}
     If(IsGrf)and Not(HoleMode)Then Begin
      BarSpcHorRelief(Q.Panel[I].W.T.X1,Q.Panel[I].W.T.Y2,Q.Panel[I].W.T.X2,Q.Panel[I].W.Palette.Title);
     End;
    {$ENDIF}
    WESetEndBarTxtX(Q.Panel[I].W,2,CStr(Q.Panel[I].BufTree.NB)+' R‚pertoires',Q.Panel[I].W.Palette.Title);
    FMPutSelect(Q,I);
    FMSelectBar(Q,I);
   End;*)
  End;
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Proc‚dure FMRefresh                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: FileManager
 Portabilit‚:  Globale


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de restaur‚ l'affichage du Gestionnaire de fichiers
 avec relecture des donn‚es d'un r‚pertoire si demand‚.
}

Procedure FMRefresh;
Var
 fY1,fX2,I,J,YMF,IP,M:Byte;
 GX1,GY2:Word;     { Position graphique (X,Y) }
 H:SearchRec;
 OldHole:Bool;
 S:String;         { ChaŒne de caractŠres de travail temporaire }
 XColrs:MtxColors; { Palette de couleur temporaire pour le mode Norton Commander }
Begin
 If Q.Panel[0].Path[Length(Q.Panel[0].Path)]='\'Then AddStr(Q.Panel[0].Path,'*.*');
 If Q.Panel[1].Path[Length(Q.Panel[1].Path)]='\'Then AddStr(Q.Panel[1].Path,'*.*');
 XColrs:=CurrKrs.FileManager.Window;
 If(Q.NortonCommander)Then Begin
  XColrs.Border:=$1B;
  XColrs.Sel:=$30;
 End;
 WEPutWn(Q.W,FMTitle(Q,24),XColrs);
 WECloseIcon(Q.W);
 WEZoomIcon(Q.W);
 SetShade(False);
 fX2:=((Q.W.T.X2-Q.W.T.X1)shr 1)-1;
 fY1:=0;
 If(Q.NortonCommander)Then Begin
  WESetEndBar(Q.W,CurrKrs.Desktop.DialStatus);
  BarSpcHorRelief(Q.W.T.X1,Q.W.T.Y2,Q.W.T.X2,CurrKrs.Desktop.DialStatus);
  If Q.W.MaxX>0Then Begin
   J:=Q.W.MaxX div 10;
   For I:=0to 9do Begin
    BarSpcHorReliefExt(Q.W.T.X1+1+J*I,Q.W.T.Y2,Q.W.T.X1+Pred(J*(I+1)),CurrKrs.Desktop.DialStatus);
    Case(I)of
     0:S:='F1-Aide';
     1:S:='F2-Menu';
     2:S:='F3-Regarde';
     3:S:='F4-Edit';
     4:S:='F5-Copie';
     5:S:='F6-RenD‚pl';
     6:S:='F7-Cr‚eRep';
     7:S:='F8-Efface';
     8:S:='F9-PullMenu';
     9:S:='F10-Quitter';
     Else S:='';
    End;
    WESetEndBarTxtX(Q.W,J*I+1,Left(S,J-1),CurrKrs.Desktop.DialStatus)
   End;
  End;
 End
  Else
 If Not(Q.Explorer)Then Begin
  BMLoadAll(Q.But,'SYS:MBFM.ICN',WEGetRX1(Q.W),WEGetRY1(Q.W));
  fY1:=BMUseYTexts(Q.But);
  If fY1>0Then WEClrWnBorder(Q.W,BMUseXTexts(Q.But),0,wnMax,fY1-1);
 End;
 If(IsGrf)and(HeightChr>=14)and(Not Q.Explorer)Then M:=wnMax-1
                                               Else M:=wnMax;
 WESubWins(Q.W,0,fY1,fX2+1,M,Q.Panel[0].W);
 WESubWins(Q.W,fX2+2,fY1,wnMax,M,Q.Panel[1].W);
 If Not(Q.Explorer)Then Begin
  If(IsGrf)Then Begin
   GX1:=WEGetRX1(Q.W)shl 3;
   GY2:=GetRawY(Q.W.T.Y2+1);
   If(Q.NortonCommander)Then Dec(GY2,HeightChr)
                        Else Dec(GY2,8);
   PutFillBox(GX1,
              GetRawY(Q.Panel[0].W.T.Y2+1),
              GX1+Pred((Q.W.MaxX+1)shl 3),
              GY2-1,Q.W.Palette.Border shr 4);
  End;
  FMUpDateLabel(Q);
 End;
 For I:=0to 1do Begin
  PFMRefresh(Q.Panel[I],Q,Full,I=Q.Plane);
  Case(Q.Panel[I].Board)of
   BoardInfo:Begin
    FMPutDisk(Q,I);
    WESetKrBorder(Q.Panel[I].W);
    WEPutSmlTxtLn(Q.Panel[I].W,'Espace r‚pertoire utilis‚:');
    If(DescrInFile){$IFNDEF GraphicOS}and Not(HoleMode){$ENDIF}Then
     WEPutSmlTxtXY(Q.Panel[I].W,0,wnMax-4,'Description du fichier courant:');
    WEPutSmlTxtXY(Q.Panel[I].W,0,wnMax-1,'S‚lection:');
   End;
   BoardFile:Begin
    FMPutFileStatus(Q,I);
   End;
   BoardTree:Begin
(*    {$IFNDEF GraphicOS}
     If(I<>Q.Plane)Then Begin
      OldHole:=HoleMode;HoleMode:=True;
     End;
    {$ENDIF}
    _WEPutWn(Q.Panel[I].W,'Arbre R‚pertoire');
    {$IFNDEF GraphicOS}
     If(I<>Q.Plane)Then HoleMode:=OldHole;
    {$ENDIF}
    WEPutBarMsRight(Q.Panel[I].W);*)
    If(Full)Then FMReadTree(Q,I)Else Begin
     WESetPosHome(Q.Panel[I].W);
     FMSetKrItem(Q,I);
     For J:=0to(Q.Panel[I].W.MaxY)do FMPutBarTree(Q,I,J,J+Q.Panel[I].P-Q.Panel[I].Y);
     WESetEndBarCTitle(Q.Panel[I].W);
     {$IFNDEF GraphicOS}
      If(IsGrf)and Not(HoleMode)Then Begin
       BarSpcHorRelief(Q.Panel[I].W.T.X1,Q.Panel[I].W.T.Y2,Q.Panel[I].W.T.X2,Q.Panel[I].W.Palette.Title);
      End;
     {$ENDIF}
     WESetEndBarTxtX(Q.Panel[I].W,2,CStr(Q.Panel[I].BufTree.NB)+' R‚pertoires',Q.Panel[I].W.Palette.Title);
     FMPutSelect(Q,I);
     FMSelectBar(Q,I);
    End;
   End;
  End;
  If Not(IsGrf)Then WEPutSmallBorder(Q.Panel[I].W);
 End;
 For I:=0to 1do Case(Q.Panel[I].Board)of
  BoardFile:If(Full)Then FMReadFiles(Q,I)Else Begin
   If BFNumFiles(Q.Panel[I].BF)=0Then Begin
    FMPutFileStatus(Q,I);
    WEClrScr(Q.Panel[I].W);
   End
    Else
   Begin
    WEPutBarMsRight(Q.Panel[I].W);
    YMF:=Q.Panel[I].W.MaxY;
    If(BFMaxFiles(Q.Panel[I].BF)>YMF)Then M:=YMF
     Else
    Begin
     Q.Panel[I].Y:=Q.Panel[I].P;
     M:=BFMaxFiles(Q.Panel[I].BF);
     WEClrWnBorder(Q.Panel[I].W,0,M+1,wnMax,wnMax);
    End;
    For J:=0to(M)do Begin
     BFGetFile(Q.Panel[I].BF,Q.Panel[I].P-Q.Panel[I].Y+J,H);
     FMPutBar(Q,I,J,Q.Panel[I].P-Q.Panel[I].Y+J,H);
    End;
    FMSelectBar(Q,I);
    FMPutSelect(Q,I);
   End;
  End;
  BoardTree:_FMSetPath(Q,I xor 1,FMGetCurrPathTree(Q,I));
  BoardInfo:If Not(Full)Then Begin
   FMSetKrItem(Q,I);
   WEPutTxtXY(Q.Panel[I].W,1,9,CStr(Q.Panel[I xor 1].BF.SizeFiles)+' octet(s)');
   WEClrEol(Q.Panel[I].W);
   WESetKrBorder(Q.Panel[I].W);
  End;
  BoardView:If Not(Full)Then FMViewBoard(Q,I);
 End;
 SetShade(True)
End;

Procedure PFMPutStr(Var Q:PanelFileManager;Disk:Byte;S:String;X:LongInt);
Var
 Serial:LongInt; { Num‚ro de s‚rie de l'unit‚ de disque }
Begin
 WESetKrBorder(Q.W);
 WEPutSmlTxtLn(Q.W,S);
 PFMSetKrItem(Q);
 If X=-1Then S:='Inconnu'Else
 If X=-2Then Begin
  S:=GetDskLabel(Disk);
  If S=''Then S:='Inexistant';
  InsStr(S,1,' ');
  If(Win=winNT)Then Serial:=0
               Else Serial:=GetSerialNm(Disk-1);
  If Serial<>0Then
   AddStr(S,' ('+_GetSerialNmStr(Serial)+')');
  WEPutTxt(Q.W,S)
 End
 Else WEPutTxt(Q.W,CStrBasic(X)+' octet(s)');
 WEClrEol(Q.W);
 WELn(Q.W);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure FMPutDisk                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: FileManager


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction actualise les informations concernant une unit‚ dans le
 tableau sp‚cifier par la variable de param‚trage ®Pln¯.
}

Procedure FMPutDisk;
Var
 Disk:Byte;
Begin
 Disk:=Path2Dsk(Q.Panel[Pln xor 1].Path)+1;
 WESetPosHome(Q.Panel[Pln].W);
 PFMPutStr(Q.Panel[Pln],Disk,'Nom du volume:',-2);
 If(Q.CurrDsk<>Disk)or(Q.SizeDsk<=0)Then Begin
  Q.SizeDsk:=DiskSize(Disk);
  Q.FreeDsk:=DiskFree(Disk);
  Q.UsedDsk:=Q.SizeDsk-Q.FreeDsk;
  Q.CurrDsk:=Disk;
 End
  Else
 If Q.FreeDsk=-1Then Begin
  Q.FreeDsk:=DiskFree(Disk);
  Q.UsedDsk:=Q.SizeDsk-Q.FreeDsk;
 End;
 PFMPutStr(Q.Panel[Pln],Disk,'Espace disque total:',Q.SizeDsk);
 PFMPutStr(Q.Panel[Pln],Disk,'Espace disque utilis‚:',Q.UsedDsk);
 PFMPutStr(Q.Panel[Pln],Disk,'Espace disque libre:',Q.FreeDsk);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure FMSetPath                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: FileManager
 Portabilit‚:  Globale


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure change le chemin du r‚pertoire du tableau sp‚cifier. Si
  le tableau n'est pas affect‚ … des fichiers,  il change le tableau pour
  qu'il le devienne.
}

Procedure FMSetPath;Begin
 Q.Panel[Pln].W.MaxY:=Q.W.MaxY-(3+BMUseYTexts(Q.But));
 If Not(Q.Explorer)Then Begin
  If(IsGrf)and(HeightChr>=14)Then Dec(Q.Panel[Pln].W.MaxY);
 End;
 _FMSetPath(Q,Pln,_Path);
 If(Pln<>Q.Plane)Then Q.Plane:=Pln;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Proc‚dure _FMSetPath                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: FileManager


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure change le chemin du r‚pertoire du tableau courant.  Si le
  tableau n'est pas affect‚ … des fichiers, il change le tableau pour qu'il
  le devienne.
}

Procedure _FMSetPath;
Var
 ChgDsk:Boolean;
Begin
 If(Q.Panel[Pln].Board<>BoardFile)Then Begin
  Q.Panel[Pln].Board:=BoardFile;
  Inc(Q.Panel[Pln].W.T.Y1);
  FMPutHeaderFile(Q,Pln);
  ChgDsk:=True;
 End
  Else
 ChgDsk:=Path2Dsk(Q.Panel[Pln].Path)<>Path2Dsk(_Path);
 Q.Panel[Pln].Path:=_Path;
 If(ChgDsk)Then Begin
  Case(Q.Panel[Pln xor 1].Board)of
   BoardInfo:FMPutDisk(Q,Pln xor 1);
   BoardExplorer:DTChDir(Q.Panel[Pln xor 1].EW,_Path);
  End;
 End;
 FMReadFiles(Q,Pln);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                             Fonction FMGetPath                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: FileManager


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction demande le r‚pertoire courant du tableau courant de l'objet
 gestionnaire de fichiers.
}

Function FMGetPath;Begin
 FMGetPath:=Q.Panel[Q.Plane].Path
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Fonction FMNumSel                           Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: FileManager


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction demande de fichier s‚lectionn‚ dans le r‚pertoire courant
 du tableau courant de l'objet gestionnaire de fichiers.
}

Function FMNumSel;Begin
 FMNumSel:=Q.Panel[Q.Plane].SelFiles
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure FMGetCurrFile                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: FileManager


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure demande  des informations  concernant  l'item courant du
 tableau courant du gestionnaire de fichier. Le tableau doit naturellement
 ˆtre fix‚ au format fichiers.
}

Procedure FMGetCurrFile;Begin
 BFGetFile(Q.Panel[Q.Plane].BF,Q.Panel[Q.Plane].P,Info)
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Proc‚dure FMGetCurrName                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: FileManager


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction retourne le nom complet de l'item  courant du tableau
 courant du gestionnaire de fichier s'il ne s'agit pas d'un r‚pertoire
 mais bien d'un fichier.
}

Function FMGetCurrName;
Var
 H:SearchRec;
Begin
 BFGetFile(Q.Panel[Q.Plane].BF,Q.Panel[Q.Plane].P,H);
 If H.Attr.Value and faDir=0Then FMGetCurrName:=Path2Dir(FMGetPath(Q))+H.Name
		            Else FMGetCurrName:='';
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                      Proc‚dure FMGetFile                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: FileManager


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de connaŒtre des informations sur le fichier
 courant du tableau de fichier particulier.
}

Procedure FMGetFile;Begin
 BFGetFile(Q.Panel[Q.Plane].BF,_P,Info)
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                      Proc‚dure FMPutSelect                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: FileManager


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure actualise les informations concernant les fichiers
 s‚lectionn‚ dans le tableau d'informations.
}

Procedure FMPutSelect;
Var
 PlnNext:Byte;
 S:String;
Begin
 PlnNext:=Pln xor 1;
 If(Q.Panel[PlnNext].Board=BoardInfo)Then Begin
  FMSetKrItem(Q,PlnNext);
  If Q.Panel[Pln].SelFiles=0Then S:='Aucun'
                            Else S:=CStr(Q.Panel[Pln].SelFiles);
  WEPutTxtXY(Q.Panel[PlnNext].W,1,wnMax,StrUSpc(S,13));
  If Q.Panel[Pln].SizeFileSel>0Then WEPutTxtXY(Q.Panel[PlnNext].W,14,wnMax,CStr(Q.Panel[Pln].SizeFileSel)+' octet(s)');
  WEClrEol(Q.Panel[PlnNext].W);
 End;
End;

{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                         Proc‚dure FMPutBar                        Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Propri‚taire: FileManager


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette proc‚dure affiche l'item courant du tableau de fichier du c“t‚
  correspondant  … la variable de param‚trage ®_Plane¯  dans l'objet de
  gestionnaire de fichiers.
}

Procedure FMPutBar;
Label 1,2,3;
Var
 NX,S:String;
 L,Max,TX,TY:Byte;
 WX:Window;
 InfP:SearchPChr Absolute Info;
Begin
 FMSetKr(Q,_Plane,_P);
 WX:=Q.Panel[_Plane].W;
 Max:=WX.MaxX;
 WESetPos(WX,0,_Y);
 If(IsLuxe)Then Begin
  {$IFNDEF GraphicOS}If Not(HoleMode)Then{$ENDIF}Begin
   Q.Panel[_Plane].W:=WX;
   FMPutIconAssociate(Q,_Plane,_P,Info);
   WX:=Q.Panel[_Plane].W;
  End;
  Inc(WX.X,2);
 End;
 If(Q.Panel[_Plane].DescrList)Then Begin
  S:=StrPas(InfP.PC);
  If S=''Then Goto 1;
  If(Length(S)<12)and(Pos('.',S)>0)Then Begin
   S:=SetFullName(S);
   Goto 2;
  End;
  S:=Left(StrUSpc(S,12),12);
  Goto 3;
 End
  Else
 Begin
1:S:=SetFullName(Info.Name);
2:ASM
   {$IFDEF FLAT386}
    LEA  EDX,Info
    MOV  AL,' '
    TEST [EDX].SearchRec.Attr,faHidden
    JZ   @7
    MOV  AL,'°'
@7: MOV  Byte Ptr S[9],AL
   {$ELSE}
    LES  DI,Info
    MOV  AL,' '
    TEST ES:[DI].SearchRec.Attr,faHidden
    JZ   @7
    MOV  AL,'°'
@7: MOV  Byte Ptr S[9],AL
   {$ENDIF}
  END;
 End;
 If(sfaDir)in(Info.Attr.Flags)Then Begin
  3:WEPutTxt(WX,S);
 End
  Else
 WEPutTxt(WX,StrDn(S));
 If Max>46Then Begin
  If(sfaDir)in(Info.Attr.Flags)Then NX:=' <R‚pertoire> '
                               Else NX:=CStr2(Info.Size,14);
  If Max>47Then IncStr(NX,' ');
 End
  Else
 If Max>45Then Begin
  If(sfaDir)in(Info.Attr.Flags)Then NX:=' <R‚pertoire>'
                               Else NX:=CStr2(Info.Size,13);
 End
  Else
 If(sfaDir)in(Info.Attr.Flags)Then NX:='<R‚per.>'
                              Else NX:=Str2(Info.Size,8);
 IncStr(NX,' ');
 WEPutTxt(WX,NX);
 S:=TimeToStr(Info.Time);
 If Max>40Then WEPutTxt(WX,S)
          Else WEPutTxt(WX,Copy(S,3,255));
 {$IFDEF DirectDos}
 If(DirectDos)and(WX.X<Max)Then WEPutTxt(WX,{StrUSpc(}BasicStrW(Word(Info.Fill[14]+(Info.Fill[15]shl 8))){,6)});
 {$ENDIF}
 WEClrEOL(WX);
 Q.Panel[_Plane].W:=WX;
End;

Function ExpName(Var Buffer):String;Near;
Var
 S:String;
Begin
 MoveLeft(Buffer,S[1],11);S[0]:=#11;
{ ASM
  MOV AX,Word Ptr S[9]
  MOV BL,Byte Ptr S[11]
  MOV BH,AL
  OR  BH,AL
  OR  BH,BL
  CMP BH,' '
  JE  @7
  MOV Byte Ptr S[12],BL
  MOV Word Ptr S[10],AX
  MOV Byte Ptr S[9],'.'
@7:
 END;}
 If Copy(S,9,3)<>'   'Then InsStr(S,9,'.');
 ExpName:=RTrim(S);
End;

Function PFMGetBarTree(Var Q:PanelFileManager;_P:RBP):String;Near;
Var
 S:String;
 C:Char;
 I,J,K:RBP;
 Nm,CC:Byte;
Begin
 PFMGetBarTree:='';
 If(_P>=Q.BufTree.NB)Then Exit;
 Nm:=Q.BufTree.Ptr^[_P].Nm;
 If Nm>0Then Begin
  S:=Spc(Nm);
  S[Nm]:='À';
  For J:=Q.BufTree.NB-1downto 0do Begin
   K:=Q.BufTree.Ptr^[J].Nm;
   If(K>0)and(J>=_P)Then Begin
    For I:=J-1downto 0do Begin
     If(I=_P)Then Begin
      CC:=Q.BufTree.Ptr^[J].Nm;
      If S[CC]in['³','À']Then S[CC]:='Ã'
                         Else S[CC]:='³';
      Break;
     End;
     If(Q.BufTree.Ptr^[I].Nm<=Q.BufTree.Ptr^[J].Nm)Then Break;
    End;
   End;
  End;
  AddStr(S,ExpName(Q.BufTree.Ptr^[_P].Name));
 End
  Else
 S:=ExpName(Q.BufTree.Ptr^[_P].Name);
 PFMGetBarTree:=S;
End;

Function FMGetBarTree;Begin
 FMGetBarTree:=PFMGetBarTree(Q.Panel[Pln],_P);
End;

Procedure PFMPutBarTree(Var Q:PanelFileManager;Var Parent:FileManagerApp;Pln:Byte;_Y:Byte;_P:RBP);Near;
Var
 X,I:Byte;
 S:String;
 Folder,Root:Boolean;
 GX1,GY1:Word;
 Drv:Char;
Begin
 X:=0;Root:=False;Folder:=FMFolderFound;
 S:=PFMGetBarTree(Q,_P);
 If S<>''Then Begin
  If(Folder)Then Begin
   If S='\'Then Root:=True;
   For I:=1to Length(S)do If Not(S[I]in[' ','³'..'Ú'])Then Begin
    If Not((S[I]in['-','+'])and(S[I-1]in['³'..'Ú']))Then Begin
     X:=I;
     InsStr(S,I,'  ');
     Break;
    End;
   End;
  End;
  WEPutTxtXY(Q.W,0,_Y,S);
  If(Folder)Then Begin
   If(Root)Then Begin
    FMPutDriveIconXY(Parent,WEGetRX1(Q.W),WEGetRY1(Q.W)+_Y,Pln);
   End
    Else
   Begin
    GX1:=(WEGetRX1(Q.W)+X-2)shl 3;
    GY1:=GetRawY(WEGetRY1(Q.W)+_Y);
    RIPutImageScale(FolderIcon^,GX1+8,GY1,16,HeightChr,Q.W.CurrColor shr 4);
   End;
   X:=2;
  End;
 End;
 WEClrEol(Q.W);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Proc‚dure FMPutBarTree                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: FileManager


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

   Cette proc‚dure affiche r‚actualise la position courante d'un tableau
 d'arbre de r‚pertoire.
}

Procedure FMPutBarTree;Begin
 PFMPutBarTree(Q.Panel[Pln],Q,Pln,_Y,_P);
End;

Function FMGetCurrPathTree;
Var
 _Path:String;
 J,Nm:Integer;
 Chr:String[1];
Begin
 FMGetCurrPathTree:='';
 Nm:=Q.Panel[Pln].BufTree.Ptr^[Q.Panel[Pln].P].Nm;
 If Nm=0Then Begin
  Chr[0]:=#1;Chr[1]:=Path2Drv(Q.Panel[Pln].Path);
  If Q.Panel[Pln].BufTree.Ptr^[Q.Panel[Pln].P].Name[0]='\'Then FMGetCurrPathTree:=Chr+':\*.*'
  Else FMGetCurrPathTree:=Chr+':\'+ExpName(Q.Panel[Pln].BufTree.Ptr^[Q.Panel[Pln].P].Name)+'\*.*';
 End
  Else
 Begin
  _Path:=ExpName(Q.Panel[Pln].BufTree.Ptr^[Q.Panel[Pln].P].Name);
  For J:=Q.Panel[Pln].P downto 0do Begin
   If(Q.Panel[Pln].BufTree.Ptr^[J].Nm<Nm)Then
   Begin Dec(Nm);_Path:=ExpName(Q.Panel[Pln].BufTree.Ptr^[J].Name)+'\'+_Path;End;
  End;
  FMGetCurrPathTree:=Path2Drv(Q.Panel[Pln].Path)+':\'+_Path+'\*.*';
 End;
End;

Procedure PFMPutIconAssociate(Var Q:PanelFileManager;Var Parent:FileManagerApp;P:Word;Var Info:SearchRec);Near;
Var
 TX,TY:Byte;
Begin
 TX:=WEGetRX1(Q.W);TY:=WEGetRealY(Q.W);
 If(Parent.Explorer)and(StrI(2,Info.Name)=':')Then Begin
  BarSpcHor(TX,TY,TX+1,Q.W.CurrColor);
  FMPutRawDriveIconXY(Parent,TX,TY,Byte(Info.Name[1])-65);
 End
  Else
 If(IsGrf)and(UseExtensior)and(Q.Ext.Ass<>NIL)and(Q.Ext.Ass^[P]>0)and(Q.Ext.Ass^[P]<>$FFFF)Then Begin
  ExtensiorPutIcon(Parent.ExtImg,TX shl 3,GetRawY(TY),16,HeightChr,Q.Ext.Ass^[P],
                   Q.W.CurrColor shr 4,Path2Dir(Q.Path)+Info.Name);
 End
  Else
 If(FMFolderFound)and((sfaDir)in(Info.Attr.Flags))Then Begin
  RIPutImageScale(FolderIcon^,TX shl 3,GetRawY(TY),16,HeightChr,Q.W.CurrColor shr 4);
 End
  Else
 Begin
  If Pos(Copy(Info.Name,Length(Info.Name)-3,4),'.EXE;.COM;.CMD;.BAT;.BTM')>0Then
   DossierProgramIcon(TX,TY,Q.W.CurrColor)
    Else
   DossierDocumentIcon(TX,TY,Q.W.CurrColor);
 End;
End;

Procedure FMPutIconAssociate(Var Q:FileManagerApp;_Plane:Byte;P:Word;Var Info:SearchRec);Begin
 PFMPutIconAssociate(Q.Panel[_Plane],Q,P,Info);
End;

(*Procedure PFMSelectBar(Var Q:PanelFileManager;Var Parent:FileManager);Near;
Var
 PC:PChr;
 Info:SearchRec;
 InfP:SearchPChr Absolute Info;
 S:String;
Begin
 If Not(Q.Board in[BoardFile,BoardTree])Then Exit;
 If(Q.Board=BoardTree)Then WESetKrSel(Q.LF)Else
 If Q.Select^[Q.P]Then WESetKrSelF(Q.LF,$E)
                  Else WESetKrSel(Q.LF);
 {$IFDEF Adele}
  If(IsGrf)and(Q.Board<>BoardTree)
    {$IFNDEF GraphicOS}and Not(HoleMode){$ENDIF}Then Begin
   BFGetFile(Q.BF,Q.P,Info);
   Q.LF.Y:=Q.Y;
   PFMPutIconAssociate(Q,Parent,Q.P,Info);
   WEBarSelHor(Q.LF,2,Q.Y,wnMax);
  End
   Else
 {$ENDIF}
 If(FMFolderFound)and(Q.Board=BoardTree)
    {$IFNDEF GraphicOS}and Not(HoleMode){$ENDIF}Then Begin
  FMPutBarTree(Parent,_Plane,Q.Y,Q.Panel[_Plane].P);
 End
  Else
 WEBarSelHor(Q.Panel[_Plane].LF,0,Q.Panel[_Plane].Y,wnMax);
 If(DescrInFile)and(Q.Panel[_Plane xor 1].Board=BoardInfo)Then Begin
  BFGetFile(Q.Panel[_Plane].BF,Q.Panel[_Plane].P,Info);
  FMSetKrItem(Q,_Plane xor 1);
  If BFNumFiles(Q.Panel[_Plane].BF)=0Then S:='Inconnu'Else
  If IsPChrEmpty(InfP.PC)Then Begin
   If Info.Name='..'Then S:='R‚pertoire parent'Else
   If Info.Name='DESCRIPT.ION'Then S:='C''est un fichier de description...'Else
   If Info.Name[1]='å'Then S:='C''est un fichier effacer...'
                              Else S:='Inexistante'
  End
   Else
  S:=StrPas(InfP.PC);
  WEPutTxtXY(Q.Panel[_Plane xor 1].LF,1,wnMax-3,StrUSpc(S,wnMax));
 End;
 If(Q.Panel[_Plane].Board=BoardTree)Then
  WESelRightBarPos(Q.Panel[_Plane].LF,Q.Panel[_Plane].P,Q.Panel[_Plane].BufTree.NB)
 Else
  WESelRightBarPos(Q.Panel[_Plane].LF,Q.Panel[_Plane].P,BFMaxFiles(Q.Panel[_Plane].BF));
End;*)

Procedure FMSelectBar;
Var
 PC:PChr;
 Info:SearchRec;
 InfP:SearchPChr Absolute Info;
 S:String;
Begin
 If Not(Q.Panel[_Plane].Board in[BoardFile,BoardTree])Then Exit;
 If(Q.Panel[_Plane].Board=BoardTree)Then WESetKrSel(Q.Panel[_Plane].W)Else
 If Q.Panel[_Plane].Select^[Q.Panel[_Plane].P]Then WESetKrSelF(Q.Panel[_Plane].W,$E)
                                              Else WESetKrSel(Q.Panel[_Plane].W);
 {$IFDEF Adele}
  If(IsGrf)and(Q.Panel[_Plane].Board<>BoardTree)
    {$IFNDEF GraphicOS}and Not(HoleMode){$ENDIF}Then Begin
   BFGetFile(Q.Panel[_Plane].BF,Q.Panel[_Plane].P,Info);
   Q.Panel[_Plane].W.Y:=Q.Panel[_Plane].Y;
   FMPutIconAssociate(Q,_Plane,Q.Panel[_Plane].P,Info);
   WEBarSelHor(Q.Panel[_Plane].W,2,Q.Panel[_Plane].Y,wnMax);
  End
   Else
 {$ENDIF}
 If(FMFolderFound)and(Q.Panel[_Plane].Board=BoardTree)
    {$IFNDEF GraphicOS}and Not(HoleMode){$ENDIF}Then Begin
  FMPutBarTree(Q,_Plane,Q.Panel[_Plane].Y,Q.Panel[_Plane].P);
 End
  Else
 WEBarSelHor(Q.Panel[_Plane].W,0,Q.Panel[_Plane].Y,wnMax);
 If(DescrInFile)and(Q.Panel[_Plane xor 1].Board=BoardInfo)Then Begin
  BFGetFile(Q.Panel[_Plane].BF,Q.Panel[_Plane].P,Info);
  FMSetKrItem(Q,_Plane xor 1);
  If BFNumFiles(Q.Panel[_Plane].BF)=0Then S:='Inconnu'Else
  If IsPChrEmpty(InfP.PC)Then Begin
   If Info.Name='..'Then S:='R‚pertoire parent'Else
   If Info.Name='DESCRIPT.ION'Then S:='C''est un fichier de description...'Else
   If Info.Name[1]='å'Then S:='C''est un fichier effacer...'
                              Else S:='Inexistante'
  End
   Else
  S:=StrPas(InfP.PC);
  WEPutTxtXY(Q.Panel[_Plane xor 1].W,1,wnMax-3,StrUSpc(S,wnMax));
 End;
 If(Q.Panel[_Plane].Board=BoardTree)Then
  WESelRightBarPos(Q.Panel[_Plane].W,Q.Panel[_Plane].P,Q.Panel[_Plane].BufTree.NB)
 Else
  WESelRightBarPos(Q.Panel[_Plane].W,Q.Panel[_Plane].P,BFMaxFiles(Q.Panel[_Plane].BF));
End;

Procedure FMUndoBar;
Var
 C:Byte;
 {$IFDEF Adele}
  Info:SearchRec;
 {$ENDIF}
Begin
 FMSetKr(Q,Q.Plane,Q.Panel[Q.Plane].P);
 {$IFDEF Adele}
  If(IsGrf)and(Q.Panel[Q.Plane].Board<>BoardTree)Then Begin
   BFGetFile(Q.Panel[Q.Plane].BF,Q.Panel[Q.Plane].P,Info);
   Q.Panel[Q.Plane].W.Y:=Q.Panel[Q.Plane].Y;
   FMPutIconAssociate(Q,Q.Plane,Q.Panel[Q.Plane].P,Info);
   WEBarSelHor(Q.Panel[Q.Plane].W,2,Q.Panel[Q.Plane].Y,wnMax);
  End
   Else
 {$ENDIF}
 If(FMFolderFound)and(Q.Panel[Q.Plane].Board=BoardTree)
    {$IFNDEF GraphicOS}and Not(HoleMode){$ENDIF}Then Begin
  FMPutBarTree(Q,Q.Plane,Q.Panel[Q.Plane].Y,Q.Panel[Q.Plane].P);
 End
  Else
 WEBarSelHor(Q.Panel[Q.Plane].W,0,Q.Panel[Q.Plane].Y,wnMax);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                      Proc‚dure FMReadFiles                    Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: FileManager


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'effectuer une relecture d'un panneau de
 fichiers du gestionnaire de fichiers.
}

Procedure FMReadFiles;
Var
 I,PlnNext,YMF:Byte;
 H:SearchRec;
 M,J:Word;
 LW:Window;
 OldHole:Boolean;
Begin
 WEPushEndBar(LW);
 WEPutLastBar('Lecture des fichiers du r‚pertoires actuel en cours...');
 Q.Panel[Pln].Y:=0;Q.Panel[Pln].P:=0;Q.Panel[Pln].SelFiles:=0;
 Q.Panel[Pln].DirSelFiles:=0;Q.Panel[Pln].SizeFileSel:=0;
 _FreeMemory(Pointer(Q.Panel[Pln].Select),Q.Panel[Pln].SizeSelect);
 Q.Panel[Pln].Path:=FileExpand(Q.Panel[Pln].Path);
 Dec(Q.Panel[Pln].W.T.Y1);
 {$IFNDEF GraphicOS}
  If(I<>Q.Plane)Then Begin
   OldHole:=HoleMode;HoleMode:=True;
  End;
 {$ENDIF}
 _WESetTitle(Q.Panel[Pln].W,FMGetRealPath(Q,Pln,Q.Panel[Pln].W.MaxX));
 {$IFNDEF GraphicOS}
  If(I<>Q.Plane)Then HoleMode:=OldHole;
 {$ENDIF}
 Inc(Q.Panel[Pln].W.T.Y1);
 WEPutBarMsRight(Q.Panel[Pln].W);
 Repeat
  BFSelPathExt(Q.Panel[Pln].BF,Q.Panel[Pln].Path,faAll); {*****}
  FreeMemory(Q.Panel[Pln].Ext.Ass,Q.Panel[Pln].Ext.AssSize);
  If(IsGrf)and(UseExtensior)Then Begin
   Q.Panel[Pln].Ext.AssSize:=Succ(BFMaxFiles(Q.Panel[Pln].BF))shl 1;
   Q.Panel[Pln].Ext.Ass:=MemNew(Q.Panel[Pln].Ext.AssSize);
   Q.Panel[Pln].Ext.AssCurrPos:=0;
  End
   Else
  Begin
   Q.Panel[Pln].Ext.Ass:=NIL;Q.Panel[Pln].Ext.AssSize:=0;
  End;
  If SysErr=$98Then Begin { Unit‚ pas prˆte? }
   If(__DiskNotReady(Path2Dsk(Q.Panel[Pln].Path)+1)=kbCancel)Then Break;
  End
   Else
  Break;
 Until False;
 Q.Panel[Pln].SizeSelect:=BFNumFiles(Q.Panel[Pln].BF);
 Dec(Q.Panel[Pln].W.T.Y1);
 WESetEndBarCTitle(Q.Panel[Pln].W);
 Inc(Q.Panel[Pln].W.T.Y1);
 FMPutFileStatus(Q,Pln);
 If BFNumFiles(Q.Panel[Pln].BF)=0Then WEClrScr(Q.Panel[Pln].W)
  Else
 Begin
  Q.Panel[Pln].Select:=MemNew(Q.Panel[Pln].SizeSelect);
  If(Q.Panel[Pln].Select=NIL)Then Begin
   __OutOfMemory;
   WEDone(LW);
   Exit;
  End;
  YMF:=Q.Panel[Pln].W.MaxY;M:=BFMaxFiles(Q.Panel[Pln].BF);
  If Q.Name<>''Then Begin
   For J:=0to BFMaxFiles(Q.Panel[Pln].BF)do Begin
    BFGetFile(Q.Panel[Pln].BF,J,H);
    If(((sfaDir)in(H.Attr.Flags))or
       (Path2Ext(H.Name)='.ZIP')or
       (Path2Ext(H.Name)='.CAB')or
       (Path2Ext(H.Name)='.ARJ'))and(H.Name=Q.Name)Then Begin
     Q.Panel[Pln].P:=J;
     If(YMF+J>M)Then Begin
      If(YMF>M)Then Q.Panel[Pln].Y:=M-J
               Else Q.Panel[Pln].Y:=J;
      If(Q.Panel[Pln].Y>YMF)Then Q.Panel[Pln].Y:=YMF-(M-J);
     End;
     Break;
    End;
   End;
  End;
  If(M>YMF)Then M:=YMF
   Else
  Begin
   Q.Panel[Pln].Y:=Q.Panel[Pln].P;
   WEClrWnBorder(Q.Panel[Pln].W,0,M+1,wnMax,wnMax);
  End;
  For I:=0to(M)do Begin
   BFGetFile(Q.Panel[Pln].BF,Q.Panel[Pln].P-Q.Panel[Pln].Y+I,H);
   FMPutBar(Q,Pln,I,Q.Panel[Pln].P-Q.Panel[Pln].Y+I,H);
  End;
 End;
 PlnNext:=Pln xor 1;
 Case(Q.Panel[PlnNext].Board)of
  BoardInfo:Begin
   FMSetKrItem(Q,PlnNext);
   WEPutTxtXY(Q.Panel[PlnNext].W,1,9,CStr(Q.Panel[Pln].BF.SizeFiles)+' octet(s)');
   WEClrEol(Q.Panel[PlnNext].W);
  End;
  BoardExplorer:Begin
   DTChDir(Q.Panel[PlnNext].EW,Q.Panel[Pln].Path);
   DTRefresh(Q.Panel[PlnNext].EW);
  End;
 End;
 FMSelectBar(Q,Pln);
 FMPutSelect(Q,Pln);
 WEDone(LW);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure FMkHome                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: FileManager


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de passer en haut de la liste du gestionnaire
 de fichiers.
}

Procedure FMkHome;
Var
 I,M,YMF:Byte;
 H:SearchRec;
Begin
 If Q.Panel[Q.Plane].P or Q.Panel[Q.Plane].Y=0Then Exit;
 FMSetKrItem(Q,Q.Plane);
 FMUndoBar(Q);
 Q.Panel[Q.Plane].Y:=0;Q.Panel[Q.Plane].P:=0;YMF:=Q.Panel[Q.Plane].W.MaxY;
 If(Q.Panel[Q.Plane].Board=BoardTree)Then Begin
  If(Q.Panel[Q.Plane].BufTree.NB-1>YMF)Then M:=YMF
  Else WEClrWnBorder(Q.Panel[Q.Plane].W,0,M+1,wnMax,wnMax);
 End
  else
 Begin
  If BFNumFiles(Q.Panel[Q.Plane].BF)=0Then Exit;
  If(BFMaxFiles(Q.Panel[Q.Plane].BF)>YMF)Then M:=YMF
   Else
  Begin
   Q.Panel[Q.Plane].Y:=Q.Panel[Q.Plane].P;
   M:=BFMaxFiles(Q.Panel[Q.Plane].BF);
   WEClrWnBorder(Q.Panel[Q.Plane].W,0,M+1,wnMax,wnMax);
  End;
 End;
 If(Q.Panel[Q.Plane].Board=BoardTree)Then Begin
  For I:=0to(M)do FMPutBarTree(Q,Q.Plane,I,I);
  _FMSetPath(Q,Q.Plane xor 1,FMGetCurrPathTree(Q,Q.Plane));
 End
  Else
 FMUpdateBoard(Q,Q.Plane);
 FMSelectBar(Q,Q.Plane);
 FMPutSelect(Q,Q.Plane);
 If(Q.Panel[Q.Plane xor 1].Board=BoardView)Then FMViewBoard(Q,Q.Plane xor 1);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure FMkEnd                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: FileManager


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de passer en bas de la liste du gestionnaire
 de fichiers.
}

Procedure FMkEnd;
Var
 J,MB:Word;
 H:SearchRec;
 YMF:Byte;
Begin
 FMSetKrItem(Q,Q.Plane);
 YMF:=Q.Panel[Q.Plane].W.MaxY;
 If(Q.Panel[Q.Plane].Board=BoardTree)Then Begin
  MB:=Q.Panel[Q.Plane].BufTree.NB-1;
  If(MB<=YMF)Then Begin
   FMUndoBar(Q);
   Q.Panel[Q.Plane].Y:=MB;
   Q.Panel[Q.Plane].P:=Q.Panel[Q.Plane].Y;
  End
   Else
  Begin
   Q.Panel[Q.Plane].P:=MB;
   Q.Panel[Q.Plane].Y:=YMF;
   For J:=0to(YMF)do FMPutBarTree(Q,Q.Plane,J,Q.Panel[Q.Plane].P-YMF+J);
  End;
  FMSelectBar(Q,Q.Plane);
  _FMSetPath(Q,Q.Plane xor 1,FMGetCurrPathTree(Q,Q.Plane));
 End
  Else
 Begin
  If BFNumFiles(Q.Panel[Q.Plane].BF)=0Then Exit;
  MB:=BFMaxFiles(Q.Panel[Q.Plane].BF);
  FMUndoBar(Q);
  If(MB<=YMF)Then Begin
   Q.Panel[Q.Plane].Y:=MB;
   Q.Panel[Q.Plane].P:=Q.Panel[Q.Plane].Y;
   FMSelectBar(Q,Q.Plane);
  End
   Else
  Begin
   Q.Panel[Q.Plane].P:=MB;
   Q.Panel[Q.Plane].Y:=YMF;
   FMUpdateBoard(Q,Q.Plane)
  End;
  FMPutSelect(Q,Q.Plane);
 End;
 If(Q.Panel[Q.Plane xor 1].Board=BoardView)Then FMViewBoard(Q,Q.Plane xor 1);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Proc‚dure FMkUp                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: FileManager


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de remonter … l'‚l‚ment pr‚c‚dent de la liste
 du gestionnaire de fichiers.
}

Procedure FMkUp;
Var
 H:SearchRec;
Begin
 If(Q.Panel[Q.Plane].Board=BoardTree)Then Begin
  If Q.Panel[Q.Plane].P>0Then Begin
   FMUndoBar(Q);
   Dec(Q.Panel[Q.Plane].P);
   If Q.Panel[Q.Plane].Y>0Then Dec(Q.Panel[Q.Plane].Y)
    else
   Begin
    _WEScrollUp(Q.Panel[Q.Plane].W);
    FMPutBarTree(Q,Q.Plane,0,Q.Panel[Q.Plane].P);
   End;
   FMSelectBar(Q,Q.Plane);
  End;
  _FMSetPath(Q,Q.Plane xor 1,FMGetCurrPathTree(Q,Q.Plane));
 End
  Else
 Begin
  If BFNumFiles(Q.Panel[Q.Plane].BF)=0Then Exit;
  If Q.Panel[Q.Plane].P>0Then Begin
   FMUndoBar(Q);
   Dec(Q.Panel[Q.Plane].P);
   If Q.Panel[Q.Plane].Y>0Then Dec(Q.Panel[Q.Plane].Y)
    else
   Begin
    _WEScrollUp(Q.Panel[Q.Plane].W);
    BFGetFile(Q.Panel[Q.Plane].BF,Q.Panel[Q.Plane].P,H);
    FMPutBar(Q,Q.Plane,0,Q.Panel[Q.Plane].P,H);
   End;
   FMSelectBar(Q,Q.Plane);
  End;
 End;
 If(Q.Panel[Q.Plane xor 1].Board=BoardView)Then FMViewBoard(Q,Q.Plane xor 1);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure FMkPgUp                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: FileManager


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de remonter … la page pr‚c‚dent de la liste
 du gestionnaire de fichiers.
}

Procedure FMkPgUp;
Var
 H:SearchRec;
 I:Byte;
Begin
 If(Q.Panel[Q.Plane].P<Q.Panel[Q.Plane].W.MaxY)Then PushKey(kbHome)Else Begin
  FMUndoBar(Q);
  Dec(Q.Panel[Q.Plane].P,Q.Panel[Q.Plane].W.MaxY);
  If Q.Panel[Q.Plane].P<Q.Panel[Q.Plane].Y Then Q.Panel[Q.Plane].Y:=Q.Panel[Q.Plane].P;
  If(Q.Panel[Q.Plane].Board=BoardTree)Then Begin
   For I:=0to Q.Panel[Q.Plane].W.MaxY do FMPutBarTree(Q,Q.Plane,I,Q.Panel[Q.Plane].P-Q.Panel[Q.Plane].Y+I);
   FMSelectBar(Q,Q.Plane);
   _FMSetPath(Q,Q.Plane xor 1,FMGetCurrPathTree(Q,Q.Plane));
  End
   Else
  Begin
   FMUpdateBoard(Q,Q.Plane)
  End;
 End;
 If(Q.Panel[Q.Plane xor 1].Board=BoardView)Then FMViewBoard(Q,Q.Plane xor 1);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure FMkDn                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: FileManager


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de remonter … l'‚l‚ment suivant de la liste
 du gestionnaire de fichiers.
}

Procedure FMkDn;
Var
 H:SearchRec;
Begin
 If(Q.Panel[Q.Plane].Board=BoardTree)Then Begin
  If Q.Panel[Q.Plane].P<Q.Panel[Q.Plane].BufTree.NB-1Then Begin
   FMUndoBar(Q);
   Inc(Q.Panel[Q.Plane].P);
   If(Q.Panel[Q.Plane].Y<Q.Panel[Q.Plane].W.MaxY)Then Inc(Q.Panel[Q.Plane].Y)
    Else
   Begin
    _WEScrollDn(Q.Panel[Q.Plane].W);
    FMPutBarTree(Q,Q.Plane,Q.Panel[Q.Plane].Y,Q.Panel[Q.Plane].P);
   End;
   FMSelectBar(Q,Q.Plane);
  End;
  _FMSetPath(Q,Q.Plane xor 1,FMGetCurrPathTree(Q,Q.Plane));
 End
  Else
 Begin
  If BFNumFiles(Q.Panel[Q.Plane].BF)=0Then Exit;
  If Q.Panel[Q.Plane].P<BFMaxFiles(Q.Panel[Q.Plane].BF)Then Begin
   FMUndoBar(Q);
   Inc(Q.Panel[Q.Plane].P);
   If(Q.Panel[Q.Plane].Y<Q.Panel[Q.Plane].W.MaxY)Then Inc(Q.Panel[Q.Plane].Y)
    Else
   Begin
    _WEScrollDn(Q.Panel[Q.Plane].W);
    BFGetFile(Q.Panel[Q.Plane].BF,Q.Panel[Q.Plane].P,H);
    FMPutBar(Q,Q.Plane,Q.Panel[Q.Plane].Y,Q.Panel[Q.Plane].P,H);
   End;
   FMSelectBar(Q,Q.Plane);
  End;
 End;
 If(Q.Panel[Q.Plane xor 1].Board=BoardView)Then FMViewBoard(Q,Q.Plane xor 1);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                      Proc‚dure FMUpdateBoard                Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: FileManager


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ


  Cette proc‚dure permet d'effectuer la mise … jour d'un tableau
 sp‚cifiquement sans relecture de l'autre tableau ou effectation
 du reste de la boŒte de dialogue.
}

Procedure FMUpdateBoard;
Var
 I,YMF:Byte;
 MF,Base:Word;
 H:SearchRec;
Begin
 Case(Q.Panel[Pln].Board)of
  BoardFile:Begin
   YMF:=Q.Panel[Pln].W.MaxY;Base:=Q.Panel[Pln].P-Q.Panel[Pln].Y;MF:=BFMaxFiles(Q.Panel[Pln].BF);
   If(Base+YMF>MF)Then Begin
    YMF:=MF-Q.Panel[Pln].P+Q.Panel[Pln].Y;
    WEClrWnBorder(Q.Panel[Pln].W,0,YMF+1,wnMax,wnMax);
   End;
   For I:=0to(YMF)do Begin
    BFGetFile(Q.Panel[Pln].BF,Base+I,H);
    FMPutBar(Q,Pln,I,Base+I,H)
   End;
   FMSelectBar(Q,Pln)
  End;
  BoardTree:Begin
   WESetKrHigh(Q.Panel[Pln].W);
   For I:=0to(Q.Panel[Pln].W.MaxY)do
    FMPutBarTree(Q,Pln,I,Q.Panel[Pln].P-Q.Panel[Pln].Y+I);
   FMSelectBar(Q,Pln);
   _FMSetPath(Q,Pln xor 1,FMGetCurrPathTree(Q,Pln));
  End;
 End;
End;

Procedure FMkPgDn;
Var
 H:SearchRec;
 I:Byte;
 MX:RBP;
Begin
 If(Q.Panel[Q.Plane].Board=BoardTree)Then MX:=Q.Panel[Q.Plane].BufTree.NB-1
 Else MX:=BFMaxFiles(Q.Panel[Q.Plane].BF);
 If Not(Q.Panel[Q.Plane].P+(Q.Panel[Q.Plane].W.MaxY shl 1)<MX)Then PushKey(kbEnd)
  Else
 Begin
  FMUndoBar(Q);
  Inc(Q.Panel[Q.Plane].P,Q.Panel[Q.Plane].W.MaxY);
  If Q.Panel[Q.Plane].P<Q.Panel[Q.Plane].Y Then Q.Panel[Q.Plane].Y:=Q.Panel[Q.Plane].P;
  If(Q.Panel[Q.Plane].Board=BoardTree)Then Begin
   For I:=0to(Q.Panel[Q.Plane].W.MaxY)do FMPutBarTree(Q,Q.Plane,I,Q.Panel[Q.Plane].P-Q.Panel[Q.Plane].Y+I);
   FMSelectBar(Q,Q.Plane);
   _FMSetPath(Q,Q.Plane xor 1,FMGetCurrPathTree(Q,Q.Plane));
  End
   Else
  FMUpdateBoard(Q,Q.Plane);
 End;
 If(Q.Panel[Q.Plane xor 1].Board=BoardView)Then FMViewBoard(Q,Q.Plane xor 1);
End;

Procedure WEResearchTree(Var Q:FileManagerApp);
Label 1;
Var
 I,Level:Byte;
 J,J2:Word;
 S,TreeName:String;

 Procedure SetName;
 Var
  I2:Byte;
 Begin
  S:=DelStr(S,1,I+1);I2:=I;
  For I2:=1to Length(S)do If S[I2]='\'Then Break;
  If StrI(I2,S)='\'Then Dec(I2);
  I:=I2;
 End;

Begin
1:
 S:=Path2Dir(FileExpand(Q.Panel[Q.Plane].Path));
 Q.Plane:=Q.Plane xor 1;
 If(Length(S)=3)and(S[3]='\')Then Begin
  Q.Panel[Q.Plane].P:=0;
  Q.Panel[Q.Plane].Y:=0;
 End
  Else
 Begin
  I:=2;SetName;Level:=0;
  If I>0Then For J2:=0to Q.Panel[Q.Plane].BufTree.NB-1do Begin
   If(Q.Panel[Q.Plane].BufTree.Ptr^[J2].Nm=Level)and(Left(S,I)=ExpName(Q.Panel[Q.Plane].BufTree.Ptr^[J2].Name))Then Begin
    SetName;
    Inc(Level);
    Q.Panel[Q.Plane].P:=J2;
    If I=0Then Break;
   End;
  End;
{  J2:=0;S:=Q.Path[Q.Plane xor 1];
  For I:=4to Length(S)do If S[I]='\'Then Inc(J2);}
  If({J2<>Level}Length(S)>0)Then Begin
   TreeName:=MaltePath+'TREE'+Path2Drv(Q.Panel[Q.Plane].Path)+'.MBT';
   DeleteFile(TreeName);
   FMReadTree(Q,Q.Plane);
   Goto 1;
  End;
  If(Q.Panel[Q.Plane].P<Q.Panel[Q.Plane].W.MaxY)Then Q.Panel[Q.Plane].Y:=Q.Panel[Q.Plane].P Else
  If Q.Panel[Q.Plane].Y+Q.Panel[Q.Plane].BufTree.NB>Q.Panel[Q.Plane].P Then
   Q.Panel[Q.Plane].Y:=Q.Panel[Q.Plane].W.MaxY-((Q.Panel[Q.Plane].BufTree.NB-1)-Q.Panel[Q.Plane].P);
  If(Q.Panel[Q.Plane].Y>Q.Panel[Q.Plane].W.MaxY)Then Q.Panel[Q.Plane].Y:=Q.Panel[Q.Plane].W.MaxY;
 End;
 WESetKrHigh(Q.Panel[Q.Plane].W);
 For I:=0to(Q.Panel[Q.Plane].W.MaxY)do FMPutBarTree(Q,Q.Plane,I,Q.Panel[Q.Plane].P-Q.Panel[Q.Plane].Y+I);
 Q.Plane:=Q.Plane xor 1;
 FMSelectBar(Q,Q.Plane xor 1);
End;

{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                       Proc‚dure FMInverseBoard                 Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Propri‚taire: FileManager
  Portabilit‚:  Globale


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette proc‚dure permet d'inverser le contenu des deux tableaux du
  gestionnaire  de fichiers  de l'objet d‚finit  par la  variable de
  param‚trage ®Q¯.
}

Procedure FMInverseBoard;
Var
 Panel:PanelFileManager;
Begin
 Panel:=Q.Panel[0];
 Q.Panel[0]:=Q.Panel[1];
 Q.Panel[1]:=Panel;
 Q.Plane:=Q.Plane xor 1;
 _FMRefresh(Q)
End;

Procedure PFMOldOtherBoard(Var Q:PanelFileManager);Near;
Var
 B:Byte;
Begin
 B:=Q.Board;
 If(B=BoardInfo)Then Begin
  If(B=BoardFile)Then Dec(Q.W.T.Y1);
  If Q.OldBoard=0Then Q.OldBoard:=BoardFile;
  Q.Board:=Q.OldBoard;
 End
  Else
 Q.Board:=BoardInfo;
 Q.OldBoard:=B;
End;

Procedure FMOldOtherBoard;Begin
 PFMOldOtherBoard(Q.Panel[Q.Plane xor 1]);
 FMRefresh(Q,True)
End;

Var
 CurrFileManager:^FileManagerApp;
 OldKbd:Procedure;

Procedure UpDateExtensior;Far;
Var
 X:SearchRec;
 P,Max:Word;
 Pln:Byte;
 S:String;
Begin
 OldKbd;
 Pln:=CurrFileManager^.Plane;
 Max:=BFMaxFiles(CurrFileManager^.Panel[Pln].BF);
 P:=CurrFileManager^.Panel[Pln].Ext.AssCurrPos;
 If(P<=Max)Then Begin
  If(CurrFileManager^.Panel[Pln].Ext.Ass<>NIL)Then Begin
   BFGetFile(CurrFileManager^.Panel[Pln].BF,P,X);
   If X.Attr.Value and faDir=0Then S:=Path2Dir(CurrFileManager^.Panel[CurrFileManager^.Plane].Path)+X.Name
                              Else S:=X.Name;
   CurrFileManager^.Panel[Pln].Ext.Ass^[P]:=ExtensiorSearch(CurrFileManager^.ExtImg,S,X.Attr.Value);
  End;
  Inc(CurrFileManager^.Panel[Pln].Ext.AssCurrPos);
 End
  Else
 If P=Max+1Then Begin
  If(CurrFileManager^.RefreshAnyWay)Then Begin
   FMUpdateBoard(CurrFileManager^,CurrFileManager^.Plane);
   Inc(CurrFileManager^.Panel[Pln].Ext.AssCurrPos);
  End;
 End;
End;

Procedure PFMConcatDir(Var Q:PanelFileManager;Var R:FileManagerApp;Const Name:String);
Var
 T:String;
Begin
 If CmpLeft(Name,'..')Then Begin
  R.Name:=Path2Dir(Q.Path);
  BackStr(R.Name);
  R.Name:=Path2NoDir(R.Name);
 End
  Else
 R.Name:='';
 T:=Path2NoDir(Q.Path);
 If Q.Path='*:\'Then Begin
  Q.Path:='';
  T:='*.*';
 End
  Else
 Q.Path:=Path2Dir(Q.Path);
 AddStr(Q.Path,Name);
 If Q.Path[Length(Q.Path)]<>'\'Then IncStr(Q.Path,'\');
 AddStr(Q.Path,T);
End;

Procedure PFMPutTitle(Var Q:PanelFileManager;Actif:Boolean);Near;
Var
 Title:String;
 OldHole:Boolean;
Begin
 If Not(Actif)Then Begin
  {$IFNDEF GraphicOS}
   OldHole:=HoleMode;HoleMode:=True;
  {$ENDIF}
 End;
 Case(Q.Board)of
  BoardInfo:_WESetTitleF(Q.W,'Informations',$C);
  BoardFile:Begin
   Dec(Q.W.T.Y1);
   _WESetTitleF(Q.W,PFMGetRealPath(Q,Q.W.MaxX),$C);
   Inc(Q.W.T.Y1);
  End;
  BoardTree:_WESetTitleF(Q.W,'Arbre R‚pertoire',$C);
  BoardView:_WESetTitleF(Q.W,'Pr‚-Visualisation',$C);
  BoardExplorer:_WESetTitleF(Q.W,'Dossier',$C);
 End;
 Case(Q.Board)of
  BoardInfo:Title:='Informations';
  BoardFile:Title:=PFMGetRealPath(Q,Q.W.MaxX);
  BoardTree:Title:='Arbre R‚pertoire';
  BoardView:Title:='Pr‚-Visualisation';
  BoardExplorer:Title:='Dossier';
 End;
 If(Q.Board=BoardFile)Then Dec(Q.W.T.Y1);
 If(Actif)Then _WESetTitleF(Q.W,Title,$C)
          Else _WESetTitle(Q.W,Title);
 If(Q.Board=BoardFile)Then Inc(Q.W.T.Y1);
 If Not(Actif)Then Begin
  {$IFNDEF GraphicOS}
   HoleMode:=OldHole;
  {$ENDIF}
 End;
End;

{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                            Fonction FMRun                           Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Propri‚taire: FileManager
  Portabilit‚:  Globale


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette fonction permet d'ex‚cuter une commande utilisateur et de
  l'appliquer … l'objet ®FileManager¯ s'il est concern‚,  sinon le
  code clavier est retourn‚e.
}

Function FMRun;
Label PgDn,PgUp,Enter,Sq,RereadKey,Ins,InsUp,Exit;
Var
 Q:FileManagerApp Absolute Context;
 Ok:Boolean;
 K:Word;
 H:SearchRec;
 E:ExtStr;
 T,T2:String;
 Out,X7,BK,OMX,OMY:Byte;
 TP,NE:Word;
 InKeyMouse:Boolean;
 WKM:Window;
 PL:^LongInt;

 Procedure SelectTitle(Plane:Byte);Begin
  If Plane>1Then System.Exit;
  PFMPutTitle(Q.Panel[Plane],True);
  If(Q.Panel[Plane].Board=BoardFile)Then Begin
   FMPutDriveIcon(Q,Plane);
  End;
 End;

 Procedure UnSelTitle(Plane:Byte);Begin
  If Plane>1Then System.Exit;
  PFMPutTitle(Q.Panel[Plane],False);
 End;

 Function IsMove:Boolean;Begin
  IsMove:=Q.Panel[Q.Plane].Board in[BoardFile,BoardTree]
 End;

 Procedure Step;Begin
  UnSelTitle(Q.Plane);
  Q.Plane:=Q.Plane xor 1;
  SelectTitle(Q.Plane);
  If Not(Q.Explorer)Then FMUpDateLabel(Q)
 End;

 Procedure SearchName(Chr:Char);
 Var
  L:Window;
  S:String;
  Pln:Byte;
  J,M:RBP;
  YMF:Byte;
  H:SearchRec;
 Begin
  Pln:=Q.Plane;
  If BFNoFile(Q.Panel[Pln].BF)Then System.Exit;
  WEPushEndBar(L);
  S:=ChrUp(Chr);
  Repeat
   YMF:=Q.Panel[Pln].W.MaxY;M:=BFMaxFiles(Q.Panel[Pln].BF);
   For J:=0to(M)do Begin
    BFGetFile(Q.Panel[Pln].BF,J,H);
    If(Left(H.Name,Length(S))=S)Then Begin
     Q.Panel[Pln].P:=J;
     If(YMF+J>M)Then Begin
      If(YMF>M)Then Q.Panel[Pln].Y:=M-J
               Else Q.Panel[Pln].Y:=J;
      If(Q.Panel[Pln].Y>YMF)Then Q.Panel[Pln].Y:=YMF-(M-J);
     End;
{     FMRefresh(Q,No);}
     FMUpdateBoard(Q,Pln);
     Break;
    End;
   End;
   WEPutLastBar('Recherche le nom ®'+S+'¯');
   K:=WEReadk(Q.W);
   If(K=kbBS)Then BackStr(S)Else
   If Char(K)in['A'..'Z','a'..'z','_','.','0'..'9']Then IncStr(S,ChrUp(Char(K)))
   Else Break;
  Until False;
  WEDone(L);
 End;

 Procedure Description;Begin
  BFGetFile(Q.Panel[Q.Plane].BF,Q.Panel[Q.Plane].P,H);
  T:=SearchDescription(Path2Dir(Q.Panel[Q.Plane].Path)+H.Name);
  If(H.Name<>'DESCRIPT.ION')and(H.Name<>'..')Then Begin
   If(_WinInp(45,'Description','Entrez la description d‚sirez (40 maximum):',False,T)=kbYes)Then Begin
    SetDescription(Path2Dir(Q.Panel[Q.Plane].Path)+H.Name,T);
    BFSetDescription(Q.Panel[Q.Plane].BF,Q.Panel[Q.Plane].P,Str2PChr(T));
    FMSelectBar(Q,Q.Plane);
   End;
  End;
 End;

 Function MouseMenu:Byte;
 Var
  Refresh:Boolean;
  Code:Word;
 Begin
  MouseMenu:=0;
  BFGetFile(Q.Panel[Q.Plane].BF,Q.Panel[Q.Plane].P,H);
  Code:=FileMenuContext(@Q,Path2Dir(Q.Panel[Q.Plane].Path)+H.Name,H,Refresh);
  Case(Code)of
   5:Description;
   6:FMCopyFiles(Q,False);
   7:FMCopyFiles(Q,True);
   8:FMDeleteFiles(Q);
   9:FMSetAttr(Q);
   10:FMPrnFile(Q);
   11:FMCopyFile2Clipboard(Q);
   20..26:FMConvSelect(Q,Code);
   200..225:Q.Panel[Q.Plane].Path:=Chr(Code-199+Byte('@'))+':\*.*';
   Else MouseMenu:=Code;
  End;
  If(Refresh)Then Begin
   FMReadFiles(Q,Q.Plane);
   SelectTitle(Q.Plane);
  End;
 End;

 Function IsStation(Var Q:DialogTreeObject):Boolean;
 Var
  S:String;
  PC:PDialogTreeElement;
 Begin
  IsStation:=False;
  S:=DTGetBarTree(Q,Q.P,PC);
  If PC^.LongName='Poste de travail'Then IsStation:=True;
 End;

Begin
 CurrFileManager:=@Q;OldKbd:=_BackKbd;
 If(IsGrf)and(UseExtensior)Then _BackKbd:=UpDateExtensior;
 Q.Name:='';TP:=$FFFF;OMX:=$FF;OMY:=$FF;InKeyMouse:=False;
 SelectTitle(Q.Plane);
 Repeat
  Ok:=False;
  Case(Q.Plane)of
  0,1:Begin
  Q.RefreshAnyWay:=True;
  _InitKbd;
  __ShowMousePtr;
  If(Q.Panel[Q.Plane].Board=BoardExplorer)Then Begin
   K:=DTRun(Q.Panel[Q.Plane].EW);
   If(K=kbMouse)Then K:=WEReadk(Q.W);
   T:=DTGetShortDir(Q.Panel[Q.Plane].EW,Q.Panel[Q.Plane].EW.P)+'*.*';
   If(T<>Q.Panel[Q.Plane].Path)Then Begin
    If IsStation(Q.Panel[Q.Plane].EW)Then T:='*:';
    FMSetPath(Q,Q.Plane xor 1,T);
   End;
  End
   Else
  Begin
   Repeat
    _BackKbd;
    K:=WEBackReadk(Q.W);
    If(K=0)and(IsGrf)Then Begin
     K:=BMGetBut(Q.But,LastMouseX,LastMouseY);
     If(K)in[0..9]Then Begin
      If(OMX<>LastMouseX)or(OMY<>LastMouseY)Then Begin
       If Not(InKeyMouse)Then WEPushEndBar(WKM);
       InKeyMouse:=True;OMX:=LastMouseX;OMY:=LastMouseY;
       Case(K)of
        0:WEPutLastBar('Copier(s) un/des fichier(s)');
        1:WEPutLastBar('D‚placement/Renommer');
        2:WEPutLastBar('Cr‚ation d''un nouveau r‚pertoire');
        3:WEPutLastBar('Effacer le(s) fichier(s)/r‚pertoire(s)');
        4:WEPutLastBar('S‚lectionner l''unit‚ du tableau de gauche');
        5:WEPutLastBar('S‚lectionner l''unit‚ du tableau de droite');
        6:WEPutLastBar('Autopsie: Analyse de l''entˆte de fichier...');
        7:WEPutLastBar('change les deux tableaux');
        8:WEPutLastBar('Passe au tableau pr‚c‚dent');
        9:WEPutLastBar('Modification des propri‚t‚s');
       End;
      End;
     End
      Else
     If(InKeyMouse)Then Begin
      InKeyMouse:=False;
      WEDone(WKM);
     End;
    End
     Else
    If K>0Then Break;
   Until KeyPress;
   __HideMousePtr;
   K:=WEReadk(Q.W);
  End;
  Q.RefreshAnyWay:=False;
  If(InKeyMouse)Then Begin
   InKeyMouse:=False;
   WEDone(WKM);
  End;
RereadKey:
  Case(K)of
   kbInWn:Begin
    Case WEInRightBarMs(Q.Panel[Q.Plane].W,LastMouseX,LastMouseY)of
     kbRBarMsUp:Begin
      DelayMousePress(100);
      FMkUp(Q);
     End;
     kbRBarMsDn:Begin
      DelayMousePress(100);
      FMkDn(Q);
     End;
     kbRBarMsPgDn,kbRBarMsPgUp:Begin
      Case WEBackReadk(Q.Panel[Q.Plane].W)of
       kbRBarMsPgDn:Begin
        DelayMousePress(100);
        Goto PgDn;
       End;
       kbRBarMsPgUp:Begin
        DelayMousePress(100);
        Goto PgUp;
       End;
       kbCompat:Repeat
        If(Q.Panel[Q.Plane].Board=BoardFile)Then NE:=BFMaxFiles(Q.Panel[Q.Plane].BF)
                                            Else NE:=Pred(Q.Panel[Q.Plane].BufTree.NB);
        TP:=WEGetCompatPosition(Q.W,NE);
        If(Q.Panel[Q.Plane].P<>TP)Then Begin
         Q.Panel[Q.Plane].P:=TP;
         If(Q.Panel[Q.Plane].P<Q.Panel[Q.Plane].W.MaxY)Then
          Q.Panel[Q.Plane].Y:=Q.Panel[Q.Plane].P
         Else
          Q.Panel[Q.Plane].Y:=Q.Panel[Q.Plane].W.MaxY;
         __HideMousePtr;
         FMUpdateBoard(Q,Q.Plane);
         FMSelectBar(Q,Q.Plane);
         __ShowMousePtr;
        End;
       Until WEBackReadk(Q.Panel[Q.Plane].W)<>kbCompat;
      End;
     End;
     Else Begin
      If WEInRightBarMs(Q.Panel[Q.Plane xor 1].W,LastMouseX,LastMouseY)>0Then Q.Plane:=Q.Plane xor 1
       Else
      If LastMouseY-WEGetRY1(Q.W)<BMUseYTexts(Q.But)Then Begin
       BK:=BMGetBut(Q.But,LastMouseX,LastMouseY);
       WaitMouseBut0;
       Case(BK)of
        0:FMCopyFiles(Q,False);
        1:FMCopyFiles(Q,True);
        2:Begin
         K:=kbF7;
         Ok:=True;
        End;
        3:FMDeleteFiles(Q);
        4:Begin
         Out:=SelectDisk(Path2Dsk(Q.Panel[0].Path));
         If Out=$FFThen Goto Exit;
         FMSetPath(Q,0,Char(Out+Byte('@'))+':*.*');
        End;
        5:Begin
         Out:=SelectDisk(Path2Dsk(Q.Panel[1].Path));
         If Out=$FFThen Goto Exit;
         FMSetPath(Q,1,Char(Out+Byte('@'))+':*.*');
        End;
        6:Goto Sq;
        7:FMInverseBoard(Q);
        8:FMOldOtherBoard(Q);
        9:FMSetAttr(Q);
       End;
      End
       Else
      Begin
        { Souris pointe l'ic“ne d'unit‚ de disque? }
       If(IsGrf)and(Q.Panel[Q.Plane].Board=BoardFile)and
         (LastMouseX<=Q.Panel[Q.Plane].W.T.X1+1)and
         (LastMouseX>=Q.Panel[Q.Plane].W.T.X1)and
         (LastMouseY+1=Q.Panel[Q.Plane].W.T.Y1)Then Begin
        WaitMouseBut0;
        If LastMouseB=2Then DriveInfo(Path2Dsk(Q.Panel[Q.Plane].Path)+1)
         Else
        Begin
         UnSelTitle(Q.Plane);
         FMChDsk(Q);
         SelectTitle(Q.Plane);
        End;
       End
         Else
       If WEInTitle(Q.Panel[Q.Plane].W,LastMouseX,LastMouseY+1)or
          WEInTitle(Q.Panel[Q.Plane].W,LastMouseX,LastMouseY)Then Begin
        WaitMouseBut0;
        If(Q.Panel[Q.Plane].Board=BoardFile)and(WEInTitle(Q.Panel[Q.Plane].W,LastMouseX,LastMouseY))Then Begin
         Q.Panel[Q.Plane].DescrList:=Not Q.Panel[Q.Plane].DescrList;
         Dec(Q.Panel[Q.Plane].W.T.Y1);
         FMPutIdentificator(Q,Q.Plane);
         Inc(Q.Panel[Q.Plane].W.T.Y1);
         FMUpdateBoard(Q,Q.Plane);
         SelectTitle(Q.Plane);
        End
         Else
        Begin
         UnSelTitle(Q.Plane);
         FMChgBoard(Q);
         SelectTitle(Q.Plane);
        End;
       End
        Else
       If WEInTitle(Q.Panel[Q.Plane xor 1].W,LastMouseX,LastMouseY)or
          WEInTitle(Q.Panel[Q.Plane xor 1].W,LastMouseX,LastMouseY+1)Then Begin
        WaitMouseBut0;
        UnSelTitle(Q.Plane);
        Q.Plane:=Q.Plane xor 1;
        If LastMouseB=2Then FMChgBoard(Q)Else
        If Not(Q.Explorer)Then FMUpDateLabel(Q);
        SelectTitle(Q.Plane);
       End
        Else
       If WEInWindow(Q.Panel[(Q.Plane+1)and 1].W,LastMouseX,LastMouseY)Then Step Else
       If(IsGrf)and(HeightChr>=14)and(LastMouseY=Q.Panel[Q.Plane].W.T.Y2+1)Then Begin
        X7:=LastMouseX-Q.Panel[0].W.T.X1;Out:=$FF;
        If X7<12Then Out:=0 Else
        If X7<24Then Out:=1 Else
        If X7<36Then Out:=2
         Else
        Begin
         X7:=LastMouseX-Q.Panel[1].W.T.X1;
         If X7<12Then Out:=3 Else
         If X7<24Then Out:=4 Else
         If X7<36Then Out:=5;
        End;
        If Out<3Then Begin
         If(Q.Panel[0].Board=BoardFile)Then Dec(Q.Panel[0].W.T.Y1);
         Q.Panel[0].Board:=Out+FirstBoard;
        End
         Else
        If Out<6Then Begin
         If(Q.Panel[1].Board=BoardFile)Then Dec(Q.Panel[1].W.T.Y1);
         Q.Panel[1].Board:=Out-3+FirstBoard;
        End;
        If Out<>$FFThen Begin
         FMRefresh(Q,True);
         SelectTitle(Q.Plane)
        End;
       End
        Else
       If WEInWindow(Q.Panel[Q.Plane].W,LastMouseX,LastMouseY)and(Q.Panel[Q.Plane].Board in[BoardFile,BoardTree])Then Begin
        WaitMouseBut0;
        __HideMousePtr;
        FMUndoBar(Q);
        X7:=Q.Panel[Q.Plane].Y;
        Q.Panel[Q.Plane].P:=Q.Panel[Q.Plane].P-Q.Panel[Q.Plane].Y;
        Q.Panel[Q.Plane].Y:=LastMouseY-WEGetRY1(Q.Panel[Q.Plane].W);
        Inc(Q.Panel[Q.Plane].P,Q.Panel[Q.Plane].Y);
        If Q.Panel[Q.Plane].P>BFMaxFiles(Q.Panel[Q.Plane].BF)Then Begin
         Q.Panel[Q.Plane].P:=BFMaxFiles(Q.Panel[Q.Plane].BF);
         Q.Panel[Q.Plane].Y:=Q.Panel[Q.Plane].P;
        End;
        FMSelectBar(Q,Q.Plane);
        If(Q.Panel[Q.Plane].Board=BoardTree)and(Q.Panel[Q.Plane xor 1].Board=BoardFile)Then Begin
         _FMSetPath(Q,Q.Plane xor 1,FMGetCurrPathTree(Q,Q.Plane));
        End;
        If(Q.Panel[Q.Plane xor 1].Board=BoardView)Then FMViewBoard(Q,Q.Plane xor 1);
        If LastMouseB=2Then Begin
         If(Q.Panel[Q.Plane].Board=BoardFile)Then Case(MouseMenu)of
          1:Goto Enter;
          2:Begin
           K:=kbView;
           Ok:=True;
          End;
          3:Begin
           K:=kbEdit;
           Ok:=True;
          End;
          4:Goto Sq;
          12:Begin
           K:=kbHexView;
           Ok:=True;
          End;
          13:Begin
           K:=kbPartitionManager;
           Ok:=True;
          End;
          30:Begin
           K:=kbOpenWorkShop;
           Ok:=True;
          End;
         End;
        End
         Else
        If X7=Q.Panel[Q.Plane].Y Then Begin
         K:=kbEnter;
         Goto Enter;
        End;
        __ShowMousePtr;
       End;
      End;
     End;
    End;
   End;
   kbMouse:Begin
    WaitMouseBut0;
    __HideMousePtr;
    Ok:=True;
   End;
kbTab,kbCtrlRight,kbCtrlLeft:Step;
    kbDel:If(Q.Panel[Q.Plane].Board=BoardFile)Then FMDeleteFiles(Q);
  kbLeft,kbRight:If(Q.Panel[Q.Plane].Board=BoardFile)Then Description;
  kbCtrlIns:FMCopyFileName2Clipboard(Q);
kbShiftIns:If(Q.Panel[Q.Plane].Board=BoardFile)Then FMCopyFiles(Q,False);
kbCtrlF1:Sq:If(Q.Panel[Q.Plane].Board=BoardFile)Then Begin
	     X7:=0;
	     Repeat
	      BFGetFile(Q.Panel[Q.Plane].BF,Q.Panel[Q.Plane].P,H);
	      If(sfaDir)in(H.Attr.Flags)Then
	       X7:=InfoDir(SetPath4AddFile(Path2Dir(Q.Panel[Q.Plane].Path))+H.Name,X7)
              Else
	       X7:=InfoHeader(SetPath4AddFile(Path2Dir(Q.Panel[Q.Plane].Path))+H.Name,X7);
	      Case(X7)of
	       1: FMkDn(Q);
	       2: FMkUp(Q);
	     $FF: Break;
	      End;
	     Until X7=0;
	    End;
    kbIns : Ins:Begin
             Ok:=True;
       InsUp:If(Q.Panel[Q.Plane].Board=BoardFile)Then If BFMaxFiles(Q.Panel[Q.Plane].BF)>=0Then Begin
	      BFGetFile(Q.Panel[Q.Plane].BF,Q.Panel[Q.Plane].P,H);
 {	     If H.Attr and faDir=0Then} Begin
	       Q.Panel[Q.Plane].Select^[Q.Panel[Q.Plane].P]:=Not(Q.Panel[Q.Plane].Select^[Q.Panel[Q.Plane].P]);
	       If Q.Panel[Q.Plane].Select^[Q.Panel[Q.Plane].P]Then Begin
	        Inc(Q.Panel[Q.Plane].SelFiles);
                Inc(Q.Panel[Q.Plane].SizeFileSel,H.Size);
                If(sfaDir)in(H.Attr.Flags)Then Inc(Q.Panel[Q.Plane].DirSelFiles);
	       End
	        Else
	       Begin
	        Dec(Q.Panel[Q.Plane].SelFiles);
                Dec(Q.Panel[Q.Plane].SizeFileSel,H.Size);
                If(sfaDir)in(H.Attr.Flags)Then Dec(Q.Panel[Q.Plane].DirSelFiles);
	       End;
	       FMPutSelect(Q,Q.Plane);
	       If(Ok)Then FMkDn(Q)
                     Else FMkUp(Q);
	      End;
             End;
	    End;
   kbHome: If(IsMove)Then FMkHome(Q);
    kbEnd: If(IsMove)Then FMkEnd(Q);
     kbUp: Begin
            If(IsMove)Then Begin
             If(ShiftPress)Then Begin
              Ok:=False;
              Goto InsUp;
             End;
             FMkUp(Q);
            End;
           End;
     kbDn: Begin
            If(IsMove)Then Begin
             If(ShiftPress)Then Goto Ins;
             FMkDn(Q);
            End;
           End;
   kbPgUp: PgUp:If(IsMove)Then FMkPgUp(Q);
   kbPgDn: PgDn:If(IsMove)Then FMkPgDn(Q);
kbCtrlPgUp:Begin
	    T2:=Path2Dir(Q.Panel[Q.Plane].Path);
	    If Length(T2)>3Then Begin
	     T2:=FileExpand(T2);Dec(Byte(T2[0]));
	     T2:=SetPath4AddFile(Path2Dir(T2));
	     T:=Path2NoDir(Q.Panel[Q.Plane].Path);
	     Q.Panel[Q.Plane].Path:=T2+T;
	     If BoardTree=Q.Panel[Q.Plane xor 1].Board Then WEReSearchTree(Q);
	     FMReadFiles(Q,Q.Plane);
	     SelectTitle(Q.Plane);
	    End;
	   End;
    kbEnter:If BoardFile=Q.Panel[Q.Plane].Board Then Begin
       Enter:BFGetFile(Q.Panel[Q.Plane].BF,Q.Panel[Q.Plane].P,H);
             PL:=@H.Fill[14];
	     If H.Name[1]='å'Then ErrNoMsgOk(errFileOrDirAlreadyDelete)
	      Else
 	     If((sfaDir)in(H.Attr.Flags))or(PackedFile(Path2Dir(Q.Panel[Q.Plane].Path)+H.Name))Then Begin
	      FMUndoBar(Q);
              PFMConcatDir(Q.Panel[Q.Plane],Q,H.Name);
	      If BoardTree=Q.Panel[Q.Plane xor 1].Board Then WEReSearchTree(Q);
	      FMReadFiles(Q,Q.Plane);
	      SelectTitle(Q.Plane);
	     End
	      Else
             Begin
              T:=Path2Dir(Q.Panel[Q.Plane].Path);
              BackStr(T);
 	      If(H.Attr.Value and faDir=0)and(PackedFile(T))and(PL^<>0)Then Begin
               If Not FullScreenAtPos(T,PL^)Then Begin
                FMRun:=K;
                Goto Exit;
               End;
              End
               Else
	      Begin
	       Q.Name:=Path2Dir(Q.Panel[Q.Plane].Path)+H.Name;
               E:=Path2Ext(Q.Name);
               If E='.BAT'Then ExecBatch(Q.Name)Else
               If(E='.WAV')or(E='.VOC')Then Begin
                _LoadSound(Q.Name);
                _PlayWave;
               End
                Else
               If E='.FLI'Then RunFLI(Q.Name)Else
               If Pos(E,'.DOC;.GAT')>0Then Begin
                FMRun:=kbLoad;
                Goto Exit;
               End
                Else
               If Pos(E,'.CUR;.ICO')>0Then ViewIcon(Q.Name)Else
               If(Q.Panel[Q.Plane xor 1].Board=BoardView)Then Begin
                If Q.Panel[Q.Plane xor 1].Res.Output<>$FFThen Begin
                 _FullScreen(Q.Panel[Q.Plane xor 1].Res,True);
                End;
               End
                Else
               If Not FullScreen(Q.Name)Then Begin
                FMRun:=K;
                Goto Exit;
               End;
              End;
             End;
	    End;
       kbF2:Begin
        If(Q.NortonCommander)Then K:=kbMenuApp;
        Ok:=True;
       End;
       kbF3:Begin
        If(Q.NortonCommander)Then K:=kbView;
        Ok:=True;
       End;
       kbF4:Begin
        If(Q.NortonCommander)Then K:=kbEdit;
        Ok:=True;
       End;
       kbF6:If(Q.NortonCommander)Then FMCopyFiles(Q,True)
                                 Else Ok:=True;
       kbF9:Begin
        If(Q.NortonCommander)Then K:=kbWindows95Menu;
        Ok:=True;
       End;
       kbF10:Begin
        If(Q.NortonCommander)Then K:=kbClose;
        Ok:=True;
       End;
       Else Repeat Case Chr(K)of
             '+':FMSelWildCard(Q);
             '-':FMUnSelWildCard(Q);
	     '^':Begin
              If(Q.Panel[Q.Plane].Board=BoardFile)Then Dec(Q.Panel[Q.Plane].W.T.Y1);
              FMChgBoard(Q);
              If(Q.Panel[Q.Plane].Board=BoardFile)Then Inc(Q.Panel[Q.Plane].W.T.Y1);
             End;
	     '*':FMInverseWildCard(Q);
	     '\':FMPrincipalPath(Q);
             'A'..'Z','a'..'z','_','.','0'..'9':Begin
              If(Q.Panel[Q.Plane].Board=BoardFile)Then Begin
               SearchName(Chr(K));
               Goto RereadKey;
              End;
             End;
	     Else Begin
              Ok:=True;
              Break;
             End;
	    End;
	    SelectTitle(Q.Plane);
	   Until True;
  End;
  End;
  Else Break;
  End;
 Until Ok;
 UnSelTitle(Q.Plane);
 FMRun:=K;
Exit:
 _BackKbd:=OldKbd;
 ExtensiorDone(Q.ExtImg);
End;

Function FMTitle(Var Q;Max:Byte):String;
Var
 S:String;
Begin
 If(FileManagerApp(Q).NortonCommander)Then FMTitle:='Clone Commander'Else
 If(FileManagerApp(Q).Explorer)Then FMTitle:=MessageByLanguage('Explorateur³Explorer')
  Else
 Begin
  S:=MessageByLanguage('Gestionnaire de fichiers³File Manager');
  If Max<=Length(S)+1Then FMTitle:=S
                     Else FMTitle:=S+' '+FMGetRealPath(FileManagerApp(Q),FileManagerApp(Q).Plane,Max-24);
 End;
End;

Procedure PFMDone(Var Q:PanelFileManager);Near;Begin
 FreeMemory(Q.Ext.Ass,Q.Ext.AssSize);
 XFreeMem(Q.Res);
 XFreeMem(Q.RM);
 FreeMemory(Q.Select,Q.SizeSelect);
 WEDone(Q.W);
 BFDone(Q.BF);
End;

Procedure FMChangeCurrDirectory(Var Q:FileManagerApp;Const DirName:String);Begin
 FMSetPath(Q,Q.Plane,DirName);
End;

Function FMDone;
Var
 Q:FileManagerApp Absolute Context;
 I:Byte;
 CCC:CloneCommanderConfig;
Begin
 If(Q.NortonCommander)Then Begin
  For I:=0to 1do Begin
   CCC.Len:=SizeOf(CCC)-2;
   CCC.Board:=Q.Panel[I].Board;
   CCC.Brief:=Q.Panel[I].Brief;
   CCC.Status:=Q.Panel[I].Status;
   CCC.P:=Q.Panel[I].P;
   CCC.Y:=Q.Panel[I].Y;
   CCC.Path:=Q.Panel[I].Path;
   CreateKeyFormat(HKEY_CURRENT_USER,'Software\CloneCommander',WordToStr(I),tdBlob,CCC);
  End;
 End;
 ExtensiorDone(Q.ExtImg);
 For I:=0to 1do PFMDone(Q.Panel[I]);
 XFreeMem(Q.DR);
 XFreeMem(Q.HR);
 XFreeMem(Q.CR);
 HYDone(Q.HWildCard);
 WEDone(Q.W);
 FMDone:=0;
End;

Function SelectDisk(OldChoice:Byte):Byte;
Var
 L:Window;
Begin
 WEPushEndBar(L);
 WEPutLastBar('S.V.P. S‚lectionnez le lecteur appropri‚');
 SelectDisk:=RawSelectDisk(OldChoice);
 WEDone(L);
End;

Function _RawSelectDisk(OldChoice:Byte;Inv:Boolean):Byte;
Label Enter,BreakAll;
Var
 DiskTab:Array[0..25]of Boolean;
 DiskLet:Array[0..25]of Char;
 W:Window;
 K:Word;
 Res:Boolean;
 P,I,N,FD,M:Byte; { Nombre de disque, First Disk, Maximum }
Begin
 _RawSelectDisk:=$FF;
 If OldChoice=0Then OldChoice:=GetDsk
               Else Dec(OldChoice);
 N:=0; FD:=$FF;
 For I:=0to 25do Begin
  Res:=DiskExist(I);
  If(Inv)Then Res:=Not Res;
  DiskTab[I]:=Res;
  If(Res)Then Begin
   If Not((I=1)and(NmFloppyDsk<=1))Then Begin
    DiskLet[N]:=Char(I+Byte('A')); Inc(N);
    If(I<FD)Then FD:=I;
   End;
  End
   Else
  If(Inv)and Not(Res)and(OldChoice<>$FF)Then OldChoice:=I;
 End;
 If N=0Then Exit;
 If N=1Then Begin
  _RawSelectDisk:=FD;
  Exit;
 End;
 M:=N-1;
 If Not DiskTab[OldChoice]Then OldChoice:=FD;
 WEInitO(W,1+N*3,3);
 WEPushWn(W);
 WEPutWnKrDials(W,'Disque');
 WECloseIcon(W);
 WEBar(W);
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
  _InitKbd;
  __ShowMousePtr;
  Repeat
   _BackKbd;
   K:=WEBackReadk(W);
   If K>0Then Begin
    Case(K)of
     kbInWn:Begin
      Dec(LastMouseY,WEGetRY1(W));Dec(LastMouseX,WEGetRX1(W));
      If LastMouseY=1Then Begin
       WaitMouseBut0;
       I:=(LastMouseX)div 3;
       __HideMousePtr;
       If(I=P)Then Goto Enter
        Else
       Begin
        WESetKrBorder(W);
        WEBarSelHor(W,P*3,1,P*3+2);
        P:=I;
        WESetKrSel(W);
        WEBarSelHor(W,P*3,1,P*3+2);
        __ShowMousePtr;
       End;
      End;
     End;
     kbClose:Begin
      WaitMouseBut0;
      __HideMousePtr;
      Goto BreakAll;
     End;
    End;
   End;
   Case(GetRawTimerB)and$Fof
    0: _WESetCubeCSelF(W,P*3+1,1,DiskLet[P],LightRed);
    4: _WESetCubeCSelF(W,P*3+1,1,DiskLet[P],Yellow);
    8: _WESetCubeCSelF(W,P*3+1,1,DiskLet[P],LightBlue);
    12: _WESetCubeCSelF(W,P*3+1,1,DiskLet[P],LightGreen);
   End;
  Until KeyPress;
  __HideMousePtr;
  _WESetCubeCSel(W,P*3+1,1,DiskLet[P]);
  Case WEReadk(W)of
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
Enter:
    _RawSelectDisk:=Byte(DiskLet[P])-64;
    Break;
   End;
   kbEsc:Break;
  End;
 Until False;
BreakAll:
 WEDone(W);
End;

Function RawSelectDisk(OldChoice:Byte):Byte;Begin
 RawSelectDisk:=_RawSelectDisk(OldChoice,False)
End;

Function SelectNewDisk(OldChoice:Byte):Byte;
Var
 L:Window;
Begin
 WEPushEndBar(L);
 WEPutLastBar('S.V.P. S‚lectionnez une nouvelle unit‚');
 SelectNewDisk:=_RawSelectDisk(OldChoice,True);
 WEDone(L);
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
END.