{$I DEF.INC}

Procedure RefreshExterne;
Procedure PutAppTitleBar;
Procedure PutBarStatusMemory;
Procedure PutFrameTaskBar;
Procedure PutToolBar;
Procedure InitScr;
Procedure InitMouseImage;
Procedure PutTapis(Y1,Y2,Attr:Byte);

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                               IMPLEMENTATION
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses
 Adele,Systex,Math,Memories,Systems,Video,Mouse,Dialex,Dials,ToolTerm,
 Arcade,
 {$IFDEF FullVersion}
  MBCortex,
  MalLibra,
  MalEnv,
 {$ENDIF}
 {$IFDEF BureauVersion}
  MBBCrtex,
  MalBLibr,
  MalBEnv,
 {$ENDIF}
 Isatex,
 ResTex,
 ResLoadI,
 ResServI;

{$I \Source\Chantal\Library\System\Malte\Presenta.tio\PutTapis.Inc}
(*{$I Library\MulL.Inc}

Procedure PutFillRoundRect(x1,y1,x2,y2,b,Kr:Int);Var a,xr,yr,x,j,y,xN,yN:Int;AO,BO,AO2,BO2,AO4,BO4,d:Long;Begin
 y:=y1;y1:=y2;y2:=y;yr:=b;xr:=b;xN:=x1+xr;yN:=y1-yr;
 If Not(y2+b>=yN)Then PutFillBox(x1,y2+b,x2,yN,Kr);
 a:=b;BO:=b*b;AO:=a*a;y:=b;x:=0;
 ASM
   {AO2:=AO shl 1}
  {$IFDEF __386__}
   DB 66h;MOV AX,Word Ptr AO
   DB 66h;SHL AX,1
   DB 66h;MOV Word Ptr AO2,AX
  {$ELSE}
   LES AX,AO
   MOV DX,ES
   SHL AX,1
   RCL DX,1
   MOV Word Ptr AO2,AX
   MOV Word Ptr AO2[2],DX
  {$ENDIF}
   {AO4:=AO shl 2;}
  {$IFDEF __386__}
   DB 66h;SHL AX,1
   DB 66h;MOV Word Ptr AO4,AX
  {$ELSE}
   SHL AX,1
   RCL DX,1
   MOV Word Ptr AO4,AX
   MOV Word Ptr AO4[2],DX
  {$ENDIF}
   {BO2:=BO shl 1;}
  {$IFDEF __386__}
   DB 66h;MOV AX,Word Ptr BO
   DB 66h;SHL AX,1
   DB 66h;MOV Word Ptr BO2,AX
  {$ELSE}
   LES AX,BO
   MOV DX,ES
   SHL AX,1
   RCL DX,1
   MOV Word Ptr BO2,AX
   MOV Word Ptr BO2[2],DX
  {$ENDIF}
   {BO4:=BO shl 2;}
  {$IFDEF __386__}
   DB 66h;SHL AX,1
   DB 66h;MOV Word Ptr BO4,AX
  {$ELSE}
   SHL AX,1
   RCL DX,1
   MOV Word Ptr BO4,AX
   MOV Word Ptr BO4[2],DX
  {$ENDIF}
 END;
 {$IFDEF __386__}
  ASM
   MOV AX,Y
   DEC AX
   MUL Y
   DB ciPushDX,ciPushAX
   DW ciPopEAX
   DB 66h;IMUL Word Ptr AO2
   DB 66h;MOV BX,AX
   DB 66h;XOR AX,AX;INC AX
   DB 66h;SUB AX,Word Ptr AO
   DB 66h;DEC AX
   DB 66h;IMUL Word Ptr BO2
   DB 66h;ADD AX,BX
   DB 66h;ADD AX,Word Ptr AO
   DB 66h;MOV Word Ptr d,AX
  END;
 {$ELSE}
  d:=MulL(AO2,(y-1)*y)+AO+MulL(BO2,1-AO);
 {$ENDIF}
 While(MulL(AO,y)>MulL(BO,x))do Begin
  PutLnHor(xN-y,y2+xr-x,x2-yr+y,Kr);
  If d>=0Then Begin;Dec(y);Dec(d,MulL(AO4,y))End;
  {$IFDEF __386__}
   ASM
    DB 66h;XOR AX,AX
    DB 66h;XOR BX,BX
    MOV AL,3
    MOV BX,X
    DB 66h;SHL BX,1
    DB 66h;ADD AX,BX
    DB 66h;IMUL Word Ptr BO2
    DB 66h;ADD Word Ptr D,AX
   END;
  {$ELSE}
   Inc(d,MulL(BO2,3+(x shl 1)));
  {$ENDIF}
  Inc(x);
 End;
 d:=MulL(BO2,(x+1)*x)+MulL(AO2,y*(y-2)+1)+MulL(1-AO2,BO);
 While y<>0do Begin
  PutLnHor(xN-y,y2+xr-x,x2-yr+y,Kr);
  if d<=0Then Begin;Inc(x);Inc(d,MulL(BO4,x))End;
  Dec(y);
  {$IFDEF __386__}
   ASM
    DB 66h;XOR AX,AX
    DB 66h;XOR BX,BX
    MOV AL,3
    MOV BX,Y
    DB 66h;SHL BX,1
    DB 66h;SUB AX,BX
    DB 66h;IMUL Word Ptr AO2
    DB 66h;ADD Word Ptr D,AX
   END;
  {$ELSE}
   Inc(d,MulL(AO2,3-(y shl 1)));
  {$ENDIF}
 End;
End;

Procedure PutFillCircle(X,Y,Rayon:Integer;Color:Word);Begin
 PutFillRoundRect(x-Rayon,y-Rayon,x+Rayon,y+Rayon,Rayon,Color);
End;*)

Procedure PutAppTitleBar;
Var
 Name:String;
 I:Byte;
 MY:Byte;
 XP:Byte;
 BX1:Word;
 Color:Word;
 ColorWhite:Word;
Begin
 If(ViewAppTitle)Then Begin
  {If(IsGrf)and(HeightChr=16)Then Begin
   BarSpcHor(0,0,MaxXTxts-2,CurrKrs.LastBar.Normal);
   BarSpcHor(MaxXTxts-1,0,MaxXTxts,0);
   PutFillCircle((MaxXTxts-1)shl 3,15,15,CurrKrs.LastBar.Normal shr 4);
  End
   Else}
  BarSpcHor(0,0,MaxXTxts,CurrKrs.LastBar.Normal);
  If(ModePH)Then Name:='Power Hacken (PH)'
            Else Name:=NamePrg+' '+VerPrg+' (L''Oeuvre Inhumaine)';
  XP:=(MaxXTxts-Length(Name))shr 1;
  {If(BitsPerPixel>8)and(tsK in TitleSetting)Then Begin
   BX1:=(XP shr 1)shl 3;
   Color:=RGB2Color(92,92,160);
   ColorWhite:=RGB2Color(192,192,192);
   MY:=HeightChr shr 1;
   PutFillBox(16,0,Pred(BX1),MY-1,Color);
   For I:=0to 7do ClrLnHor(BX1,I,8-I,ColorWhite);
   For I:=0to 6do PutLn(24+(I shl 1),0,16+8+(I shl 1),7,Blue);
   For I:=0to 7do Begin
    ClrLnHor(BX1,MY+I,I,ColorWhite);
    ClrLnHor(BX1+I,MY+I,8-I,Color);
   End;
   PutFillBox(BX1+8,MY,(MaxXTxts-21)shl 3,HeightChr-1,Color);
  End;}
  PutCloseIcon(0,0,$F);
  If BitsPerPixel>8Then PutTxtFade(XP,0,Name,$F,False)
                   Else PutTxtXY(XP,0,Name,$1F);
 End;
End;

Procedure PutToolBar;
Var
 Name:String;
Begin
 If GetBitsPerPixel<4Then Name:='MALBOO2.ICN'
                     Else Name:='MALBOOK.ICN';
 If(ViewToolBar)Then BMLoadAll(But,SYSDrive+Name,0,1+LnsMnu)
                Else FillClr(But,SizeOf(But));
 Windows.HomeYEditor:=BMUseYTexts(But);
End;

Procedure PutBarStatusMemory;
Var
 G:GraphBoxRec;
Begin
 If(EnvMode<>emDESQview)Then Begin
  If(FullDate)Then Begin
   If NmXTxts>40Then Begin
    SetPosDate(MaxXTxts-11,0);
    SetPosTime(MaxXTxts-20,0);
   End;
   TaskBar.MaxX:=MaxXTxts-15;
   If(SoundIconOnStatus)Then Dec(TaskBar.MaxX,3);
   If(CountryIconOnStatus)Then Dec(TaskBar.MaxX,3);
   G.X1:=0;
   G.Y1:=GetRawY(YTaskMnu);
   G.X2:=Pred(Succ(MaxXTxts)shl 3);
   G.Y2:=GetMaxYPixelsTaskBar;
   If(TaskBar.Visible)Then __GraphBoxRelief(G,CurrKrs.Menu.Normal);
  End
   Else
  Begin
   If MaxXTxts<55Then TaskBar.MaxX:=39
                 Else TaskBar.MaxX:=55;
  End;
  PutFreeMemory;
 End;
End;

Procedure PutFrameTaskBar;
Var
 G:GraphBoxRec;
Begin
 If(TaskBar.Visible)Then Begin
  BarSpcHor(0,MaxYTxts-Byte(HelpBar),MaxXTxts,CurrKrs.Menu.Normal);
  If(GetNmYPixels>NmYTxts*HeightChr)Then Begin
   G.X1:=0;
   G.Y1:=GetRawY(Succ(YTaskMnu));
   G.X2:=Pred(Succ(MaxXTxts)shl 3);
   G.Y2:=GetMaxYPixelsTaskBar;
   If(G.Y1>G.Y2)Then
    PutFillBox(0,NmYTxts*HeightChr,GetNmXPixels,GetNmYPixels,Black)
   Else
    PutFillBox(G.X1,G.Y1,G.X2,G.Y2,CurrKrs.Menu.Normal shr 4);
  End;
 (* If(GetNmYPixels>NmYTxts*HeightChr)Then Begin
    { Zone d'extra la partie inf‚rieur de l'‚cran }
   PutFillBox(0,NmYTxts*HeightChr,GetNmXPixels,GetNmYPixels,Black);
  End;*)
  If Not(IsGrf)Then Begin
   SetChr(33,MaxYTxts-Byte(HelpBar),'³');
   SetChr(44,MaxYTxts-Byte(HelpBar),'³');
   SetChr(55,MaxYTxts-Byte(HelpBar),'³');
  End;
 End
  Else
 Begin
  BarSpcHor(0,MaxYTxts-Byte(HelpBar),MaxXTxts,CurrKrs.Desktop.Tapiserie);
  If(GetNmYPixels>NmYTxts*HeightChr)Then Begin
   G.X1:=0;
   G.Y1:=GetRawY(Succ(YTaskMnu));
   G.X2:=Pred(Succ(MaxXTxts)shl 3);
   G.Y2:=GetMaxYPixelsTaskBar;
   If(G.Y1>G.Y2)Then
    PutFillBox(0,NmYTxts*HeightChr,GetNmXPixels,GetNmYPixels,Black)
   Else
    PutFillBox(G.X1,G.Y1,G.X2,G.Y2,CurrKrs.Desktop.Tapiserie shr 4);
  End;
 End;
End;

Procedure RefreshExterne;Begin
 PutAppTitleBar;
 PutToolBar;
 PutFrameTaskBar;
 PutBarStatusMemory;
End;

Procedure InitMouseImage;
Var
 Image:XInf;
 Inf:MCanvas;
 Res:ImageHeaderRes;
 SizePtr:LongInt;
 PtrMs:Pointer;
Begin
 If(Application.MousePointerFileName<>NIL)Then Begin
  If(RILoadImage(StrPas(Application.MousePointerFileName),diAutoDetect,0,$FFFF,
                    rmAllResSteady,[],Image)=eriNone)Then Begin
   RIRes2WnImg(Image,Inf);
   RIMakeDoublon(Image,rmAllResSteady,False,Inf);
    { Garder seulement le doublon car l'image est toujours afficher
      en  fonction  de  l'‚cran  et  n'a pas  lieu  d'effectuer  de
      traitement en fonction de l'original...}
   XGetAbsRec(Image,0,SizeOf(Res),Res);
   XFreeMem(Image);
   SizePtr:=Mul2Word(LocalBytesPerLine(Res.NumXPixels,BitsPerPixel),Res.NumYPixels);
   If LongRec(SizePtr).Hi<>0Then ErrNoMsgOk(errImgPtrMouseTooBig)
    Else
   Begin
    PtrMs:=MemAlloc(SizePtr);
    If(PtrMs<>NIL)Then Begin
     XGetAbsRec(Inf.Miroir,0,SizePtr,PtrMs^);
     MakeMousePtrSprite(Res.NumXPixels,Res.NumYPixels,PtrMs);
    End;
   End;
   XFreeMem(Inf.Miroir);
  End;
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Proc‚dure InitScr                            Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure initialise l'‚cran avec le fond, les menus, les barres,...
 sp‚cifiquement pour l'application ®MonsterBook¯ ou ®PowerHacken¯.


 Remarque
 ÍÍÍÍÍÍÍÍ

  ş Elle ne  s'occupe  pas  de  charger en  m‚moire et  de tenir  compte  du
    ®desktop¯ des fenˆtres ou  de la configuration mais seulement de la base
    indispensable au bon fonctionnement de l'application.
}

Procedure InitScr;
Const
 FirstTime:Boolean=False;
Var
 SavePalette,PaletteFree:Array[Byte]of RGB;
 I,J,K:Word;
 PSavePalette:Array[0..767]of Byte Absolute SavePalette;
 PPaletteFree:Array[0..767]of Byte Absolute PaletteFree;
 Inf:MCanvas;
 S:String;
 L:Window;
Begin
 If(DefaultMode<>vmNone)or Not(IsVideoDirectAccess)Then FirstTime:=True;
 If(OS2)or(Win>0)Then FirstTime:=True;
 If(IsGraf)Then Begin
  If BitsPerPixel=1Then StyleBarTitle:=sttMacintosh;
{                   Else StyleBarTitle:=sttNone;}
  If BitsPerPixel=8Then Begin
   GetPaletteRGB(SavePalette,0,256);
   FillClr(PaletteFree,SizeOf(PaletteFree));
   SetPalBlk(0,256);
  End;
 End
  Else
 If(IsLuxe)Then Begin
  If Not(FirstTime)Then Begin
   PCopy(0,1);
   SetVisualPg(1);
  End;
 End;
 If(EnvMode=emDESQview)Then CurrKrs.Desktop.Tapiserie:=$8F;
 If(IsGrf)and(BitsPerPixel>=4)Then Begin
  LoadWallPaper(True);
 End
  Else
 PutTapis(2,MaxYTxts,$19);
 PMSetWinBar(0,LnsMnu,MaxXTxts);
 PMPutMnuBar;
 If(MemoryModel=mmAutoDetect)Then Begin
  If(IsGrf)Then MemoryModel:=mmProgressBar
           Else MemoryModel:=mmNumber;
 End;
 If(EnvMode<>emDESQview)Then RefreshExterne;
 DefEndBar;
 If(IsGraf)Then Begin
  If(FX)Then Begin
   If BitsPerPixel=8Then For J:=0to 63do Begin
    For I:=0to 767do If PPaletteFree[I]<PSavePalette[I]Then Inc(PPaletteFree[I],4);
    WaitRetrace;
    SetPalRGB(PaletteFree,0,256);
   End;
  End
   Else
  SetPalRGB(PSavePalette,0,256);
 End
  Else
 If(IsLuxe)and Not(FirstTime)Then Begin
  ScrollPage1to0;
  FirstTime:=True;
 End;
 __InitMouse;
 InitMouseImage;
 If Not IsPChrEmpty(FontTitlePath)Then Begin
  WEPushEndBar(L);
  WEPutLastBar('Chargement de l''image de barre titre en cours...');
  XFreeMem(FontTitle);
  S:=StrPas(FontTitlePath);
   { Note: Seul la partie ‚quivalente … la hauteur d'un caractŠre est
           stock‚ en m‚moire afin d'acc‚l‚rer le traŒtement et ne pas
           faire  paniquer  l'utilisateur  trouvant cette option trop
           gourmant en puissant pour sa machine...
   }
  If(RILoadImage(S,diAutoDetect,0,HeightChr,
                  rmAllResSteady,[],FontTitle)=eriNone)Then Begin
   RIRes2WnImg(FontTitle,Inf);
   RIMakeDoublon(FontTitle,rmAllResSteady,True,Inf);
    { Garder seulement le doublon car l'image est toujours afficher
      en  fonction  de  l'‚cran  et  n'a pas  lieu  d'effectuer  de
      traitement en fonction de l'original...}
   XFreeMem(FontTitle);
   FontTitle:=Inf.Miroir;
  End;
  XFreeMem(FontInActifTitle);
  S:=StrPas(FontInActifTitlePath);
  If(RILoadImage(S,diAutoDetect,0,HeightChr,
                  rmAllResSteady,[],FontInActifTitle)=eriNone)Then Begin
   RIRes2WnImg(FontInActifTitle,Inf);
   RIMakeDoublon(FontInActifTitle,rmAllResSteady,True,Inf);
    { Garder seulement le doublon car l'image est toujours afficher
      en  fonction  de  l'‚cran  et  n'a pas  lieu  d'effectuer  de
      traitement en fonction de l'original...}
   XFreeMem(FontInActifTitle);
   FontInActifTitle:=Inf.Miroir;
  End;
  WEDone(L);
 End;
 If(MediaSupport)Then Begin
  PutTaskIcon($FF,icnFolder,False);
 End;
End;
