{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                                                                         Û
 ³                  Malte Genesis/Module diteur d'ic“ne                   Û
 ³                                                                         Û
 ³            dition Chantal pour Mode R‚el/IV - Version 1.1              Û
 ³                              1994/12/29                                 Û
 ³                                                                         Û
 ³          Tous droits r‚serv‚s par les Chevaliers de Malte (C)           Û
 ³                                                                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Nom du programmeur
 ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

  Sylvain Maltais


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette unit‚ permet l'‚dition par l'utilisateur d'ic“ne de n'importe quel
 type support‚e avec de multiple page.
}

Unit EditIcon;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                  INTERFACE
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

{$I DEF.INC}
{$V-}
Uses
 Systex,Isatex;

Function  IENew(Var Q;X1,Y1,X2,Y2:Byte):Boolean;
Procedure IELoad(Var Context;X1,Y1,X2,Y2:Byte;Const Path:String);
Procedure IERefresh(Var Context);
Procedure IECpyClipBoard(Var Q:IconEditApp);
Procedure IEPasteClipBoard(Var Q:IconEditApp);
Function  IESave(Var Q):Boolean;
Function  IESaveAs(Var Context;Const FileName:String):Boolean;
Procedure IESaveIcon(Var Q:IconEditApp);
Procedure IESetMode(Var Q:IconEditApp;M:Byte);
Procedure IENewPg(Var Q:IconEditApp);
Procedure IEChgPg(Var Q:IconEditApp);
Function  IERun(Var Context):Word;
Function  IETitle(Var Q;Max:Byte):String;
Procedure IEMove2(Var Q;X,Y:Byte);
Function  IEDone(Var Q):Word;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                 IMPLEMENTATION
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses
 Adele,Memories,Systems,Video,Dials,Math,Mouse,Restex,
 ResServI,ResLoadI,ResSaveI,Dialex,DialPlus;

Procedure IEUpdatePgName(Var Q:IconEditApp);Near;Forward;
Procedure IEPutCube(Var Q:IconEditApp;Pset:Boolean);Near;Forward;
Procedure IESetPosKr(Var Q:IconEditApp);Near;Forward;
Procedure IEUndoPosKr(Var Q:IconEditApp);Near;Forward;
Procedure IEInputSaveModified(Var Q:IconEditApp);Near;Forward;
Procedure IEPutFillBox(Var Q:IconEditApp;X1,Y1,X2,Y2,Kr:Byte);Near;Forward;
Procedure _IEPutCube(Var Q:IconEditApp;X,Y:Byte;Pset:Boolean);Near;Forward;

Procedure IELoadPage(Var Q:IconEditApp;Page:Word);
Var
 Buffer:Array[0..2047]of Byte;  { Tampon temporaire }
 Size,B,B1,I,J,I2,XN,YN:Word;
 TQ:XInf;
 PosBuf:Word;                   { Position courante dans le tampon }
Begin
 RILoadImage(Q.Name,diAutoDetect,4,Page,rmAllRes,[],TQ);
 XGetAbsRec(TQ,0,SizeOf(Q.Res),Q.Res);
 Q.Block.Name:=Q.Res.Descr;
 XGetAbsRec(TQ,SizeOf(Q.Res),SizeOf(Buffer),Buffer);
 B:=0;
 XN:=Q.Res.NumXPixels;
 If XN>32Then XN:=32;
 YN:=Q.Res.NumYPixels;
 If YN>32Then YN:=32;
 For J:=0to YN-1do Begin
  Case(Q.Res.BitsPerPixel)of
   8:Begin
    B1:=B;
    For I2:=0to XN-1do Begin
     Q.Block.Data[J,I2]:=Buffer[B1];
     Inc(B1);
    End;
   End;
   4:Begin
    B1:=B;
    For I2:=0to(XN shr 1)-1do Begin
     Q.Block.Data[J,I2 shl 1]:=Buffer[B1]shr 4;
     Q.Block.Data[J,(I2 shl 1)+1]:=Buffer[B1]and$F;
     Inc(B1);
    End;
   End;
  End;
  Inc(B,Q.Res.BytesPerLine);
 End;
 PosBuf:=Q.Res.BytesPerLine*Q.Res.NumYPixels;
 If Q.Res.NumPal>0Then Begin
  MoveLeft(Buffer[PosBuf],Q.Palette,SizeOf(Q.Palette));
  Inc(PosBuf,Q.Res.NumPal*SizeOf(RGB));
 End;
 If(Q.Res.Shadow)Then Begin
  MoveLeft(Buffer[PosBuf],Q.Shadow,SizeOf(Q.Shadow));
 End;
 XFreeMem(TQ);
End;

{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                          Proc‚dure IELoad                        Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Propri‚taire: IconEdt


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette proc‚dure permet d'ouvrir une fenˆtre de dialogue ‚ditant les
  Icon de format Malte Genesis, Windows ou OS/2.  Si le nom du fichier
  est inexistant, il ouvre tout simplement une nouvelle fenˆtre.
}

Procedure IELoad;
Var
 Q:IconEditApp Absolute Context;
Begin
 FillClr(Q,SizeOf(IconEditApp));
 Q.Res.Original:=diIconGenesis;
 Q.XM:=$FF;Q.YM:=$FF;
 Q.CurrKr:=15;
 WEInit(Q.W,X1,Y1,X1+64+1,Y1+16+2);
 {$IFNDEF H}
  WEPushWn(Q.W);
 {$ENDIF}
 Q.Name:=Path;
 If Path<>''Then Begin
  If FileExist(Path)Then Begin
   If Pos(Path2Ext(Path),'.CUR;.ICO')>0Then IELoadPage(Q,0)
   Else GetFile(Path,0,SizeOf(BlockButton),Q.Block);
  End
   Else
  If Path2Ext(Q.Name)=''Then AddStr(Q.Name,'.ICN')
 End;
 IERefresh(Q);
 Q.X:=15;Q.Y:=15
End;

Function IENew{Var Q;X1,Y1,X2,Y2:Byte):Boolean};Begin
 IELoad(Q,X1,Y1,X2,Y2,'');
 IENew:=True;
End;

Procedure IEPutFillBox;
Var
 I,J,L:Byte;
Begin
 If(X1>X2)Then SwapByte(X1,X2);
 If(Y1>Y2)Then SwapByte(Y1,Y2);
 L:=X2-X1+1;
 For J:=Y1 to(Y2)do Begin
  FillChr(Q.Block.Data[J,X1],L,Kr);
  For I:=X1 to(X2)do _IEPutCube(Q,I,J,True)
 End;
End;

Procedure IECircle(Var Q:IconEditApp;X1,Y1,X2,Y2,Kr:Byte);Near;
Var
 _End,Step,I:Real;
 A,B,Rayon:Integer;

 Procedure SetPixel(X,Y,Color:Byte);Begin
  If(X<32)and(Y<32)Then Begin
   Q.Block.Data[Y,X]:=Color;
  _IEPutCube(Q,X,Y,True)
  End;
 End;

Begin
 Rayon:=DivLong(Abs(X2-X1+1),Abs(Y2-Y1+1));
 If Rayon=0Then Rayon:=1;
 _End:=11/7;Step:=_End/(Rayon shl 1);I:=0;
 Repeat
  A:=Trunc(Cos(I)*Rayon);B:=Trunc(Sin(I)*Rayon);
  SetPixel(X1+A,Y1+B,Kr);
  SetPixel(X1+A,Y1-B,Kr);
  SetPixel(X1-A,Y1+B,Kr);
  SetPixel(X1-A,Y1-B,Kr);
  I:=I+Step;
 Until I>_End;
End;

Procedure IEInputSaveModified;Begin
 If(Q.Modified)Then Begin
  If(WarningMsgYesNo('Ic“ne n''a pas ‚t‚ sauvegard‚! Dois-je le sauver ?')=kbYes)Then IESave(Q);
  Q.Modified:=False
 End;
End;

Procedure IENewPg;Begin
 IEInputSaveModified(Q);
 Q.CurrPg:=GetFileSize(Q.Name)div SizeOf(Q.Block);
 FillClr(Q.Block,SizeOf(Q.Block));
 IERefresh(Q);
 Q.X:=15;Q.Y:=15
End;

Procedure IEChgPg;
Var
 Lst:LstMnu;
 Handle:Hdl;
 I:Word;
 Old:Boolean;
 TmpRes:ImageHeaderRes; { Entˆte temporaire de recherche de page }
 FilePos:LongInt;       { Position dans le fichier }
 FileIconSize:LongInt;  { Taille du fichier d'ic“ne }
Begin
 Old:=Q.Modified;
 IEInputSaveModified(Q);
 Handle:=FileOpen(Q.Name,fmRead);
 If(Handle=errHdl)Then Begin
  If(Old)Then __FileNotFound(Q.Name)
         Else ErrNoMsgOk(errOnlyOnePage);
  Exit;
 End;
 FileIconSize:=FileSize(Handle);
 Case(Q.Res.Original)of
  diIconGenesis:Begin
   LMInit(Lst,10,4,wnMax-10,wnMax-4,'Page d''ic“ne',CurrKrs.EditButt);
   For I:=0to(FileIconSize div SizeOf(Q.Block))-1do Begin
    GetRec(Handle,I,SizeOf(Q.Block),Q.Block);
    If Q.Block.Name=''Then Q.Block.Name:='Pasnom';
    ALAddStr(Lst.List,IntToStr(I+1)+' - '+Q.Block.Name)
   End;
   Q.CurrPg:=LMRun(Lst);
   GetRec(Handle,Q.CurrPg,SizeOf(Q.Block),Q.Block);
   FileClose(Handle);
   LMDone(Lst);
  End;
  diIconAdele:Begin
   LMInit(Lst,10,4,wnMax-10,wnMax-4,'Page d''ic“ne',CurrKrs.EditButt);
   I:=0;FilePos:=11;
   While(FileIconSize>FilePos)do Begin
    _GetAbsRec(Handle,FilePos,SizeOf(TmpRes),TmpRes);
    If(TmpRes.ID=idResImage)Then Begin
     Inc(FilePos,SizeOf(ImageHeaderRes));
     Inc(FilePos,Mul2Word(TmpRes.BytesPerLine,TmpRes.NumYPixels));
     Inc(FilePos,LongInt(TmpRes.NumPal*SizeOf(RGB)));
     If(TmpRes.Shadow)Then Begin
      Inc(FilePos,Mul2Word(TmpRes.NumXPixels shr 3,TmpRes.NumYPixels));
     End;
     If TmpRes.Descr=''Then TmpRes.Descr:='Pasnom';
     ALAddStr(Lst.List,IntToStr(I+1)+' - '+TmpRes.Descr);
     Inc(I);
    End
     Else
    Break;
   End;
   Q.CurrPg:=LMRun(Lst);
   IELoadPage(Q,Q.CurrPg);
   FileClose(Handle);
   LMDone(Lst);
  End;
 End;
 IERefresh(Q);
 Q.X:=15;Q.Y:=15
End;

Function IESave;Begin
 IESave:=IESaveAs(Q,IconEditApp(Q).Name)
End;

Procedure IESetPageName(Var Q:IconEditApp);
Var
 Str:String;
Begin
 Str:=Q.Block.Name;
 WinInp(40,'Page','Entrez le nom de cette page:',CurrKrs.Dialog.Window,False,Str);
 If Length(Str)>SizeOf(Q.Block.Name)-1Then Str[0]:=Chr(SizeOf(Q.Block.Name)-1);
 If(Q.Block.Name<>Str)Then Begin
  Q.Block.Name:=Str;
  Q.Modified:=True;
  IEUpdatePgName(Q)
 End;
End;

Function IESaveAs;
Var
 Q:IconEditApp Absolute Context;
 Path:String;                       { Nom de l'ic“ne … sauvegarder }
 Handle:Hdl;
 I,J:Byte;                          { Compteur de boucle }
 B:Word;                            { Adresse de position de base de l'image }
 PosBuf:Word;
 R:XInf;                            { Ressource }
 Data:Record
  Res:ImageHeaderRes;               { Entˆte de ressource }
  Image:Array[0..511]of Byte;       { Image }
  Buffer:Array[0..127+3*16]of Byte; { Palette et la partie … ne pas alt‚rer }
 End;
Begin
 IESaveAs:=False;
 Path:=FileName;
 If(FileName='')or(Q.Name='')Then Begin
  Path:=OpenWin(Path,'Sauvegarde sous');
  If Path=''Then Exit;
  Q.Name:=Path;
  If Pos('.ICO',Path)>0Then Q.Res.Original:=diIconWindows;
 End;
 If(Path<>Q.Name)Then Begin
  If FileExist(Path)Then Begin
   If Not __InputOverwriteFile(Path)Then Exit;
   Q.Name:=Path;
  End;
 End;
 If Path2Ext(Path)=''Then Begin
  Case(Q.Res.Original)of
   diIconGenesis:AddStr(Path,'.ICN');
   Else AddStr(Path,'.ICO');
  End;
 End;
 If Not(FileExist(Path))Then Begin
  Handle:=FileCreate(Path);
  FileClose(Handle)
 End;
 If(Q.Block.Name='')and(Q.Res.Original=diIconGenesis)Then IESetPageName(Q);
 Case(Q.Res.Original)of
  diIconGenesis:SetFile(Path,Q.CurrPg,SizeOf(BlockButton),Q.Block);
  Else Begin
   FillClr(Data,SizeOf(Data));
   Data.Res:=Q.Res;
   Data.Res.ID:=idResImage;
   Data.Res.BytesPerLine:=16;
   Data.Res.NumXPixels:=32;
   Data.Res.NumYPixels:=32;
   Data.Res.BitsPerPixel:=4;
   Data.Res.Format:=fdiBinary;
   Data.Res.Descr:=Q.Block.Name;
   PosBuf:=0;
   If Q.Res.NumPal>0Then Begin
    MoveLeft(Q.Palette,Data.Buffer[PosBuf],SizeOf(Q.Palette));
    Inc(PosBuf,Q.Res.NumPal*SizeOf(RGB));
   End;
   MoveLeft(Q.Shadow,Data.Buffer[PosBuf],SizeOf(Q.Shadow));
   B:=0;
   For J:=0to 31do For I:=0to 15do Begin
    Data.Image[B]:=Q.Block.Data[J,(I shl 1)+1]+
                   (Q.Block.Data[J,I shl 1]shl 4);
    Inc(B)
   End;
   If XAllocMem(rmAllRes,SizeOf(Data),R)Then Begin
    XSetAbsRec(R,0,SizeOf(Data),Data);
    RISaveImage(Path,0,R);
    Q.WritePathIcon:=Path2Dir(Path);
    XFreeMem(R);
   End
    Else
   ErrNoMsgOk(errOutOfResource);
  End;
 End;
 Q.Modified:=False;
 IESaveAs:=True;
End;

Procedure IESaveIcon(Var Q:IconEditApp);
Var
 Path:String;
Begin
 Path:=Q.WritePathIcon+'*.ICO';
 Path:=OpenWin(Path,'Sauvegarde cette ic“ne sous');
 If Path<>''Then IESaveAs(Q,Path);
End;

Procedure IESetMode;Begin
 Q.Mode:=M;
End;

Procedure IESetPosKr;Begin
 If(IsGrf)Then Begin
  Case(Q.CurrKr)of
   White,Yellow:Q.W.CurrColor:=Black;
   Else Q.W.CurrColor:=White;
  End;
  WEPutTxtXYT(Q.W,(Q.CurrKr shl 2)+2,16,'ş');
 End
  Else
 WESetChr(Q.W,(Q.CurrKr shl 2)+2,wnMax,'ş')
End;

Procedure WEPutColorBox(Var W:Window;X1,Y,X2:Byte;Kr:Word);
Var
 GX1,GY1,GX2,GY2:Word;
Begin
 Inc(X1,WEGetRX1(W));
 Inc(Y,WEGetRY1(W));
 Inc(X2,WEGetRX1(W));
 GX1:=X1 shl 3;GX2:=((X2+1)shl 3)-1;
 GY1:=GetRawY(Y);GY2:=GetRawY(Y+1)-1;
 Inc(GX1,4);Dec(GX2,4);
 If HeightChr>8Then Begin
  Inc(GY1,4);Dec(GY2,4);
 End
  Else
 Begin
  Inc(GY1,2);Dec(GY2,2);
 End;
 PutFillBox(GX1,GY1,GX2,GY2,Kr);
 Dec(GX1);Dec(GY1);
 Inc(GX2);Inc(GY2);
 PutRect(GX1,GY1,GX2,GY2,Black);
 Dec(GX1);Dec(GY1);
 Inc(GX2);Inc(GY2);
 _SetKr(8);
 _Ln(GX1,GY1,GX1,GY2);
 _LnHor(GX1,GY1,GX2);
 _SetKr($F);
 _Ln(GX2,GY1+1,GX2,GY2);
 _LnHor(GX1+1,GY2,GX2);
End;

Procedure IEUndoPosKr;Begin
 If(IsGrf)Then Begin
  WEPutColorBox(IconEditApp(Q).W,(Q.CurrKr shl 2)+1,16,(Q.CurrKr shl 2)+3,Q.CurrKr)
 End
  Else
 WESetChr(Q.W,(Q.CurrKr shl 2)+2,wnMax,' ')
End;

Procedure IERefresh;
Var
 Q:IconEditApp Absolute Context;
 XT,YT,I,J:Byte;
Begin
 If Q.Name=''Then WEPutWn(Q.W,'Pasnom',CurrKrs.EditButt)
	     Else WEPutWn(Q.W,Q.Name,CurrKrs.EditButt);
 WECloseIcon(Q.W);
 XT:=Q.X;YT:=Q.Y;
 For J:=0to 15do For I:=0to 31do Begin
  Q.X:=I;Q.Y:=J shl 1;
  IEPutCube(Q,True)
 End;
 Q.X:=XT;Q.Y:=YT;
 If(IsGrf)Then Begin
  WEBarSpcHor(Q.W,0,wnMax,wnMax);
  WEBarSpcHorRelief(Q.W,0,wnMax,wnMax);
 End;
 For I:=0to 15do Begin
  If(IsGrf)Then Begin
   WEPutColorBox(Q.W,(I shl 2)+1,16,(I shl 2)+3,I);
  End
   Else
  Begin
   WESetKr(Q.W,I shl 4);
   WEPutTxtXY(Q.W,I shl 2,Q.W.MaxY,Spc(4))
  End;
 End;
 WESetEndBar(Q.W,CurrKrs.Desktop.DialStatus);
 If(IsGrf)and Not(HoleMode)Then Begin
  BarSpcHorRelief(Q.W.T.X1,Q.W.T.Y2,Q.W.T.X1+21,CurrKrs.Desktop.DialStatus);
  BarSpcHorReliefExt(Q.W.T.X1+1,Q.W.T.Y2,Q.W.T.X1+20,CurrKrs.Desktop.DialStatus);
 End;
 WESetEndBarTxtX(Q.W,1,'Page actuel:'+BasicStrW(Q.CurrPg+1),CurrKrs.Desktop.DialStatus);
 IEUpdatePgName(Q);
 IESetPosKr(Q)
End;

Procedure IECpyClipBoard;
Var
 XT,YT,I,J:Byte;
Begin
 MakeClipBoard(4*SizeOf(BlockButton)+100);
 For J:=0to 31do Begin
  For I:=0to 31do PutClipBoardTxt('$'+HexByte2Str(Q.Block.Data[J,I])+',');
  PutClipBoardTxt(CRLF);
 End;
End;

Procedure IEPasteClipBoard;
Var
 XT,YT,I,J,Kr:Byte;
 MaxX,MaxY:SmallInt;
 Color:RGB;
 WColor:Word;
 P:LongInt;
 B:Array[0..129]of Char;
 Res:ImageHeaderRes;
 Pal:Palette256RGB;
Begin
 GetAbsClipboard(0,SizeOf(Res),Res);
 If(Res.ID=idResImage)and(Res.NumXPixels<>0)and(Res.NumYPixels<>0)Then Begin
  P:=SizeOf(Res);
  GetAbsClipboard(SizeOf(Res)+Long(Res.BytesPerLine)*Long(Res.NumYPixels),
                  SizeOf(Pal),Pal);
  MaxY:=Pred(Res.NumYPixels);
  If MaxY>31Then MaxY:=31;
  MaxX:=Pred(Res.NumXPixels);
  If MaxX>31Then MaxX:=31;
  For J:=0to(MaxY)do Begin
   GetAbsClipboard(P,SizeOf(B),B);
   Case(Res.BitsPerPixel)of
    4:For I:=0to MaxX shr 1do Begin
     Q.Block.Data[J,I shl 1]:=Byte(B[I])shr 4;
     Q.Block.Data[J,(I shl 1)+1]:=Byte(B[I])and$F;
    End;
    8,15,16,24:For I:=0to(MaxX)do Begin
     Kr:=0;
     Case(Res.BitsPerPixel)of
      8:Color:=Pal[Byte(B[I])];
      15,16:Begin
       MoveLeft(B[I shl 1],WColor,SizeOf(Word));
       _Color2RGB(WColor,Res.BitsPerPixel,Color);
      End;
      24:MoveLeft(B[I*3],Color,SizeOf(Color));
     End;
     If Byte(Color.R)and$80=$80Then Kr:=Kr or$04;
     If Byte(Color.R)and$40=$40Then Kr:=Kr or$20;
     If Byte(Color.G)and$80=$80Then Kr:=Kr or$02;
     If Byte(Color.G)and$40=$40Then Kr:=Kr or$10;
     If Byte(Color.B)and$80=$80Then Kr:=Kr or$01;
     If Byte(Color.B)and$40=$40Then Kr:=Kr or$08;
     Q.Block.Data[J,I]:=Kr and$F;
    End;
   End;
   Inc(P,LongInt(Res.BytesPerLine));
  End;
 End
  Else
 For J:=0to 31do Begin
  GetAbsClipBoard(J*130,130,B);
  For I:=0to 31do Q.Block.Data[J,I]:=HexStrToInt(B[(I shl 2)+1]+B[(I shl 2)+2]);
 End;
 IERefresh(Q)
End;

{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                         Proc‚dure IEUpDatePgName                        Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Propri‚taire: IconEdt


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette proc‚dure affiche la nom utilisateur de la page d'ic“ne actuellement
  en ‚dition de l'objet d'‚dition d'ic“ne.
}

Procedure IEUpdatePgName;Begin
 If(IsGrf)and Not(HoleMode)Then Begin
  BarSpcHorRelief(Q.W.T.X1+22,Q.W.T.Y2,Q.W.T.X2,CurrKrs.Desktop.DialStatus);
  BarSpcHorReliefExt(Q.W.T.X1+23,Q.W.T.Y2,Q.W.T.X2-1,CurrKrs.Desktop.DialStatus);
  WESetEndBarTxtX(Q.W,24,Q.Block.Name,CurrKrs.Desktop.DialStatus)
 End
  Else
 WESetEndBarTxtX(Q.W,22,'³ '+Q.Block.Name,CurrKrs.Desktop.DialStatus)
End;

Procedure IEPutCube;Begin
 _IEPutCube(Q,Q.X,Q.Y,Pset)
End;

Procedure _IEPutCube;
Var
 Attr:Byte;
Begin
 Attr:=Q.Block.Data[Y and$FE,X]shl 4+Q.Block.Data[(Y and$FE)+1,X];
 If Not(Pset)Then Begin
  If Y and 1=1Then Attr:=Attr xor$F
              Else Attr:=Attr xor$F0
 End;
 _WESetCube(Q.W,X shl 1,Y shr 1,'Ü',Attr);
 _WESetCube(Q.W,(X shl 1)+1,Y shr 1,'Ü',Attr)
End;

Function IERun;
Var
 Q:IconEditApp Absolute Context;
 K:Word;
 Ok:Boolean;
 XM,YM,BM:Word;
{ CM:ContextMenu;
 TM:MainMnuPtr;}
Begin
 Ok:=False;
 Repeat
  IEPutCube(Q,False);
  K:=WEReadk(Q.W);
  If(Q.Mode=drwTrace)Then Begin
   Q.Block.Data[Q.Y,Q.X]:=Q.CurrKr;
   Q.Modified:=True
  End;
  IEPutCube(Q,True);
  Case(K)of
   kbInWn:If LastMouseB=2Then Begin
    Case RunMenuApp(106)of
     $F001:IESaveIcon(Q);
     $F002:IECpyClipboard(Q);
     $F003:IEPasteClipboard(Q);
     $F004:IENewPg(Q);
     $F005:IEChgPg(Q);
     $F006:IESetPageName(Q);
     $F007:Q.Mode:=drwNone;
     $F008:Q.Mode:=drwTrace;
     $F009:Q.Mode:=drwBox;
     $F00A:Q.Mode:=drwCircle;
    End;
   End
    Else
   Begin
    If(LastMouseY=WEGetRY1(Q.W)+Q.W.MaxY)Then Begin
     __HideMousePtr;
     IEUndoPosKr(Q);
     Q.CurrKr:=((LastMouseX-WEGetRX1(Q.W))shr 2)and$F;
     IESetPosKr(Q);
     WaitMouseBut0;
    End
     Else
    Begin
     __HideMousePtr;
     GetMouseSwitch(XM,YM,BM);
     Q.X:=(LastMouseX-WEGetRX1(Q.W))shr 1;
     Q.Y:=(YM-GetRawY(WEGetRY1(Q.W)))div(GetHeightChr shr 1);
     Q.Modified:=True;
     Q.Block.Data[Q.Y,Q.X]:=Q.CurrKr;
     IEPutCube(Q,True);
     WaitMouseBut0;
    End;
   End;
   kbCtrlLeft:Begin
    IEUndoPosKr(Q);
    Q.CurrKr:=(Q.CurrKr-1)and$F;
    IESetPosKr(Q)
   End;
   kbCtrlRight:Begin
    IEUndoPosKr(Q);
    Q.CurrKr:=(Q.CurrKr+1)and$F;
    IESetPosKr(Q)
   End;
   kbEnter:Case(Q.Mode)of
    drwNone,drwText:Begin
     Q.Modified:=True;
     Q.Block.Data[Q.Y,Q.X]:=Q.CurrKr;
    End;
    drwBox:Begin
     Q.Modified:=True;
     If Not(Q.SM)Then Begin
      Q.XM:=Q.X;Q.YM:=Q.Y;
     End
      Else
     IEPutFillBox(Q,Q.X,Q.Y,Q.XM,Q.YM,Q.CurrKr);
     Q.SM:=Not(Q.SM)
    End;
    drwCircle:Begin
     Q.Modified:=True;
     If Not(Q.SM)Then Begin
      Q.XM:=Q.X;Q.YM:=Q.Y;
     End
      Else
     IECircle(Q,Q.XM,Q.YM,Q.X,Q.Y,Q.CurrKr);
     Q.SM:=Not(Q.SM)
    End;
   End;
   kbUp:Q.Y:=(Q.Y-1)and$1F;
   kbDn:Q.Y:=(Q.Y+1)and$1F;
   kbLeft:Q.X:=(Q.X-1)and$1F;
   kbRight:Q.X:=(Q.X+1)and$1F;
   Else Ok:=True;
  End
 Until Ok;
 IERun:=K
End;

Function IETitle{Var Q;Max:Byte):String};Begin
 IETitle:='diteur d''ic“ne '+IconEditApp(Q).Name;
End;

Procedure IEMove2{Var Q;X,Y:Byte};
Var
 QX:IconEditApp Absolute Q;
 MX,MY:Byte;
Begin
 MX:=QX.W.T.X2-QX.W.T.X1;
 MY:=QX.W.T.Y2-QX.W.T.Y1;
 QX.W.T.X1:=X;QX.W.T.X2:=X+MX;
 QX.W.T.Y1:=Y;QX.W.T.Y2:=Y+MY;
 IERefresh(QX);
End;

Function IEDone{Var Q):Word};Begin
 IEInputSaveModified(IconEditApp(Q));
 WEDone(IconEditApp(Q).W);
 IEDone:=0;
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
END.