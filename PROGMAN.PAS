{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                                                                         Û
 ³                Malte Genesis/Gestionnaire de programmes                 Û
 ³                                                                         Û
 ³            dition Chantal pour Mode R‚el/IV - Version 1.1              Û
 ³                              1999/07/07                                 Û
 ³                                                                         Û
 ³          Tous droits r‚serv‚s par les Chevaliers de Malte (C)           Û
 ³                                                                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Nom du programmeur
 ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

  Sylvain Maltais


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette unit‚ est ‚labor‚e de fa‡on … pouvoir manipuler un gestionnaire de
 programmes et/ou de configuration ainsi qu'un menu de type Windows 9X.
}

Unit ProgMan;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                   INTERFACE
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses
 Systex,Isatex,Dialex;

Function  PMWInit(Var QX;X1,Y1,X2,Y2:Byte):Boolean;
Procedure PMWLoad(Var QX;X1,Y1,X2,Y2:Byte;Const Path:String);
Procedure PMWRefresh(Var Context);
Function  PMWRun(Var Context):Word;
Function  PMWTitle(Var Context;Max:Byte):String;
Procedure PMWPropriety(Var Q:ProgramsManagerApp);
Procedure PMWRename(Var Q:ProgramsManagerApp);
Procedure PMAddApp(Var Q:ProgramsManagerApp);
Procedure PMWDeleteApp(Var Q:ProgramsManagerApp);
Procedure PMWColorTitle(Var Q:ProgramsManagerApp);
Procedure PMWReSize(Var Context;X1,Y1,X2,Y2:Byte);
Procedure PMWMove2(Var Context;X,Y:Byte);
Procedure PMWMakeOngletMenu(Q:ProgramsManagerApp;Var X:PullSubMnu;Var Sub:Array of PullSubMnu);
Procedure PMWMakeGroupMenu(Q:ProgramsManagerApp;Num:Byte;Var X:PullSubMnu);
Procedure PMWPutIconVert(Q:ProgramsManagerApp;Num:Byte;X,Y,L,H,Kr:Word);
Function  PMWExecCmd(Q:ProgramsManagerApp;K:Word):Word;
Procedure PMWStartMode(Var Q:ProgramsManagerApp;Mode:Byte);
Procedure PMWExecute(Var Q:ProgramsManagerApp;Var TP:ProgramRec);
Procedure PMWInActif(Var Context);
Function  PMWDone(Var Context):Word;
Procedure _PMWLoad(Var Context;X1,Y1,X2,Y2:Byte;Const Path:String;StartMode:Boolean);
Function  WarningShortCut(Const Name:String):Boolean;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                IMPLEMENTATION
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses
 Memories,Systems,SysPlus,Dials,
 Adele,
 Math,            {Services math‚matique}
 Mouse,           {Gestionnaire de souris}
 Video,           {Gestionnaire vid‚o suppl‚mentaire}
 DialPlus,        {Dialogue suppl‚mentaires}
 ToolTerm,        {Prompt, Shell,...}
 ToolInfo,        {Outils d'Informations utilisateur}
 ResLoadI,        {Chargement de ressources d'image}
 ResServI,        {Sauvegarde de ressources d'image}
 ResSaveI,        {Service de ressources d'image}
 Restex,          {D‚finition des ressources}
 ResServD,        {Service de base de donn‚es}
 ToolFile;        {Outils de gestion des fichiers}

Type
CategoryRec=Record
 Name:String[31];
 X,Y,Kr:Byte;
 Min,Max:Word;
End;

 {Entˆte d'un groupe contenant tous les ic“nes
  pour un chargement plus rapide...}
HeaderGroupRec=Record
 Sign:Array[0..6]of Char; { "GROUPE"#26 }
 Info:SearchRec;
 NumCat,NumProg:Word;
End;

Procedure PutFillRoundRect(x1,y1,x2,y2,b,Kr:Integer);
Var
 a,xr,yr,x,j,y,xN,yN:Integer;
 AO,BO,AO2,BO2,AO4,BO4,d:Long;
Begin
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
{  PutLnHor(xN-y,yN+x,x2-yr+y,Kr);}
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
{  PutLnHor(xN-y,x+yN,x2-yr+y,Kr);}
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

Procedure PutLabel(X,Y,L:Byte;Const S:String;Attr:Byte);
Var
 GY1:Word;
Begin
 If(X<NmXTxts)and(Not InBarHole(X,Y,L+4))Then Begin
  GY1:=Y*HeightChr;
  PutFillRoundRect(X shl 3,GY1,((X+L+3)shl 3)+7,GY1+HeightChr-1,HeightChr-1,Attr shr 4);
  PutLnHor((X+2)shl 3,GY1,((X+3+L)shl 3)-7,Attr shr 4);
  PutTxtXY(X+2+((L-Length(S))shr 1),Y,S,Attr);
 End;
End;

Function PMHomeY(Var Q:ProgramsManagerApp):Byte;
Var
 Y:Byte;
Begin
 Y:=0;
 If(DirLine)in(Q.Option)Then Inc(Y);
 If(KeyTool)in(Q.Option)Then Inc(Y,2);
 PMHomeY:=Y;
End;

Function PMGetHomeY(Var Q:ProgramsManagerApp):Byte;Begin
 PMGetHomeY:=WEGetRY1(Q.W)+PMHomeY(Q);
End;

Procedure PMPutProgram(Var Q:ProgramsManagerApp;Var T:ProgramRec);
Var
 I,J,B,X1,Y1,XN,YN,Size,K,TX:Word;
 TX1,TY1:Byte;
 GX1,GX2:Word;       { Position horizontal de la boŒte d'effacement}
 GMX:Word;           { Position maximal horizontal }
 TY:Integer;
 S:String;           { ChaŒne de caractŠres de travail temporaire }
Begin
 If(@T=NIL)Then Exit;
 TX:=(T.X shr 3);TY:=2+(T.Y div HeightChr)+(Q.YP shl 2);
 If TY<=0Then Exit;
 TX1:=WEGetRX1(Q.W)+TX;
 TY1:=TY+PMGetHomeY(Q);
 K:=Length(T.Name);
 If HeightChr<=8Then Inc(TY,2);
 If K>4Then Dec(K,4);
 GX1:=(TX1 shl 3);
 X1:=GX1+(K shl 2);Y1:=GetRawY(TY1-2);
 If Not InBoxHole(TX1,TY1,5,4)Then Begin
  If(TY<Q.W.MaxY)Then Begin
   If(Q.Mode=mFolder)Then Begin
    GX2:=X1+Pred(12 shl 3);
    GMX:=(WEGetRX1(Q.W)+Q.W.MaxX)shl 3;
    If(GX2>GMX)Then GX2:=GMX;
    PutFillBox(GX1,Y1,GX2,Y1+31,CurrKrs.Dialog.Env.List.Border shr 4);
   End;
   RIPutImage(T.Res,X1,Y1,40,32);
  End;
 End;
 Q.W.CurrColor:=Q.Kr;
 S:=T.Name;
 If(Q.Mode=mFolder)Then S:=StrUSpc(S,12);
 Q.SXI:=TX+Length(S);Q.SYI:=TY+PMHomeY(Q);
 If(TY<=Q.W.MaxY)Then WEPutSmlTxtXY(Q.W,TX,Q.SYI,S);
End;

{ Cette proc‚dure permet de recalculer toutes les positions de chacun des
 applications dans l'onglet courant.
}

Procedure PMWRecalcIconPos(Var Q:ProgramsManagerApp);
Var
 TP:^ProgramRec;
 I,P,X,Y,MX,MY:Word;
Begin
 X:=0;Y:=HeightChr shl 1;
 MX:=(Q.W.MaxX+1)shl 3;MY:=GetRawY(Q.W.MaxY);
 ALSetPtr(Q.L,Q.Min);
 For I:=Q.Min to(Q.Max)do Begin
  TP:=_ALGetCurrBuf(Q.L);
  If(TP<>NIL)Then Begin
   TP^.X:=X;TP^.Y:=Y;
   Inc(X,(Length(TP^.Name)+1)shl 3);
   If(X>MX)Then Begin
    X:=0;
    Inc(Y,64);
    TP^.X:=X;TP^.Y:=Y;
    X:=(Length(TP^.Name)+1)shl 3;
   End;
  End;
  ALNext(Q.L);
 End;
 PMWRefresh(Q);
 ALSetPtr(Q.L,Q.P);
 TP:=_ALGetCurrBuf(Q.L);
 PutSmlTxtXY(WEGetRX1(Q.W)+(TP^.X shr 3),PMGetHomeY(Q)+2+(TP^.Y div HeightChr),
             TP^.Name,Q.W.Palette.Sel);
End;

Procedure PMWRecalcAllIconPos(Var Q:ProgramsManagerApp);
Var
 CT:^CategoryRec;
 TP:^ProgramRec;
 I,P,X,Y,MX,MY,IX,IY:Word;
Begin
 ALSetPtr(Q.ML,0);
 ALSetPtr(Q.L,0);
 If Q.ML.Count>0Then For I:=0to Q.ML.Count-1do Begin
  CT:=_ALGetCurrBuf(Q.ML);
  If(CT^.Min=I)Then Begin
   IX:=0;IY:=HeightChr shl 1;
   MX:=(Q.W.MaxX+1)shl 3;MY:=GetRawY(Q.W.MaxY);
  End;
  TP^.X:=IX;TP^.Y:=IY;Inc(IX,(Length(TP^.Name)+1)shl 3);
  If(IX>MX)Then Begin
   IX:=0;Inc(IY,64);TP^.X:=IX;TP^.Y:=IY;
   IX:=(Length(TP^.Name)+1)shl 3;
  End;
  If(I=CT^.Max)Then ALNext(Q.ML);
 End;
 PMWRefresh(Q);
 ALSetPtr(Q.L,Q.P);
 TP:=_ALGetCurrBuf(Q.L);
 PutSmlTxtXY(WEGetRX1(Q.W)+(TP^.X shr 3),PMGetHomeY(Q)+2+(TP^.Y div HeightChr),
             TP^.Name,Q.W.Palette.Sel);
End;

Procedure PMWPropriety(Var Q:ProgramsManagerApp);
Var
 TP:^ProgramRec;
 Data:ProgramRec;
Begin
 TP:=_ALGetCurrBuf(Q.L);
 Data:=TP^;
 If ExecuteAppDPU(25,Data)Then Begin
  If(Data.Icon<>TP^.Icon)Then Begin { Recharger l'ic“ne? }
   XFreeMem(TP^.Res);
   RILoadImage(Data.Icon,diAutoDetect,4,$FFFF,rmAllResSteady,[],TP^.Res);
  End;
  TP^:=Data;
  Q.Modified:=True;
  PMWRecalcIconPos(Q);
 End;
End;

Procedure PMAddApp(Var Q:ProgramsManagerApp);
Var
 I:SmallInt;
 Data:ProgramRec;
 PT:^ProgramRec;
 CT:^CategoryRec;
Begin
 FillClr(Data,SizeOf(Data));
 If ExecuteAppDPU(25,Data)Then Begin
  CT:=_ALGetBuf(Q.ML,Q.WP);
  If(CT<>NIL)Then Begin
   PT:=_ALGetBuf(Q.L,CT^.Max);
   If(PT<>NIL)Then Begin
    Data.X:=PT^.X;
    Data.Y:=PT^.Y;
    Inc(Data.X,(Length(PT^.Name)+1)shl 3);
    If Data.X>(Q.W.MaxX+1)shl 3Then Begin
     Inc(Data.Y,64);
     Data.X:=0;
    End;
   End;
   If(ALInsBlock(Q.L,CT^.Max+1,SizeOf(Data),Data))Then Begin
    For I:=Q.WP to Q.ML.Count-1do Begin
     CT:=_ALGetBuf(Q.ML,I);
     If(CT<>NIL)Then Begin
      If(I>Q.WP)Then Inc(CT^.Min);
      Inc(CT^.Max);
     End;
    End;
    Q.Modified:=True;
    PMWRecalcAllIconPos(Q);
   End;
  End;
 End;
End;

Function WarningShortCut(Const Name:String):Boolean;Begin
 WarningShortCut:=WarningMsgYesNo('Etes-vous certain de vouloir effacer le raccourci ®'+Name+'¯?')=kbYes;
End;

Procedure PMWDeleteApp(Var Q:ProgramsManagerApp);
Var
 I:SmallInt;
 CT:^CategoryRec;
 PT:^ProgramRec;
Begin
 PT:=_ALGetBuf(Q.L,Q.P);
 If WarningShortCut(PT^.Name)Then Begin
  If ALDelBuf(Q.L,Q.P)Then Begin
   For I:=Q.WP to Q.ML.Count-1do Begin
    CT:=_ALGetBuf(Q.ML,I);
    If(CT<>NIL)Then Begin
     If(I>Q.WP)Then Dec(CT^.Min);
     Dec(CT^.Max);
    End;
   End;
   Q.Modified:=True;
   PMWRecalcAllIconPos(Q);
  End;
 End;
End;

Procedure PMWRename(Var Q:ProgramsManagerApp);
Var
 TP:^ProgramRec;
 S:String;
 K:Word;
Begin
 ALSetPtr(Q.L,Q.P);
 TP:=_ALGetCurrBuf(Q.L);
 S:=TP^.Name;
 K:=_WinInp(40,'Renommer','Le nom de l''application:',No,S);
 If(K=kbEnter)and(S<>'')Then Begin
  Q.Modified:=Ya;TP^.Name:=S;
  PMWRecalcIconPos(Q);
 End;
End;

Procedure PMWRefreshStatusBar(Var Q:ProgramsManagerApp);Near;Begin
 WESetEndBar(Q.W,CurrKrs.Desktop.DialStatus);
 BarSpcHorRelief(Q.W.T.X1,Q.W.T.Y2,Q.W.T.X1+32,CurrKrs.Desktop.DialStatus);
 BarSpcHorReliefExt(Q.W.T.X1+1,Q.W.T.Y2,Q.W.T.X1+31,CurrKrs.Desktop.DialStatus);
 BarSpcHorRelief(Q.W.T.X1+33,Q.W.T.Y2,Q.W.T.X2,CurrKrs.Desktop.DialStatus);
 BarSpcHorReliefExt(Q.W.T.X1+34,Q.W.T.Y2,Q.W.T.X2-2,CurrKrs.Desktop.DialStatus);
 LuxeBox(Q.W.T.X2-1,Q.W.T.Y2);
 WESetEndBarTxtX(Q.W,2,CStr(Q.L.Count)+' objet(s)',CurrKrs.Desktop.DialStatus);
 WESetEndBarTxtX(Q.W,35,CStr(Q.SizeFolder)+' octet(s)',CurrKrs.Desktop.DialStatus);
End;

Procedure PMWRefreshIcon(Var Q:ProgramsManagerApp);Near;
Var
 I:Word;         { Compteur de boucle }
 TP:^ProgramRec; { Information sur le fichier associ‚e … l'ic“ne }
Begin
 If Q.L.Count>0Then Begin
  ALSetPtr(Q.L,Q.Min);
  For I:=Q.Min to(Q.Max)do Begin
   TP:=_ALGetCurrBuf(Q.L);
   If(TP<>NIL)Then PMPutProgram(Q,TP^);
   ALNext(Q.L);
  End;
  If(Q.Mode=mFolder)Then Begin
   WEClrWn(Q.W,Q.SXI,Q.SYI-3,wnMax,wnMax,CurrKrs.Dialog.Env.List.Border);
   WEClrWn(Q.W,0,Q.SYI+1,wnMax,wnMax,CurrKrs.Dialog.Env.List.Border);
  End;
 End;
End;

Procedure PMWRefresh{Var Q:ProgramsManager};
Var
 X1:Byte;        { Position horizontal }
 I,YW:Word;
 CT:^CategoryRec;
 Q:ProgramsManagerApp Absolute Context;
Begin
 If(Q.Mode<>mWin9X)Then Begin
  If(Q.W.T.Y1>Q.W.T.Y2)Then Exit;
  If(Q.W.MaxY>GetNmYTxts)Then Begin
   WEInit(Q.W,Q.W.T.X1,Q.W.T.Y1,Q.W.T.X2,Q.W.T.Y2);
  End;
  WEPutWnKrDials(Q.W,PMWTitle(Q,Q.W.MaxX));
  WECloseIcon(Q.W);
  WEZoomIcon(Q.W);
  If(DirLine)in(Q.Option)Then Begin
   WEPutTxtXY(Q.W,0,0,'Adresse');
   Q.W.CurrColor:=CurrKrs.Dialog.Env.List.Border;
   WEPutSmlTxtXY(Q.W,10,0,StrUSpc(Q.Path,Q.W.MaxX-12));
   WESetKrBorder(Q.W);
   WEBarSpcHorRelief(Q.W,0,0,wnMax);
   X1:=WEGetRX1(Q.W);
   BarSpcHorReliefExt(X1+10,WEGetRY1(Q.W),X1+Q.W.MaxX-3,$F0);
  End;
  YW:=0;
  If((NoOnglet)in(Q.Option))Then WEPutBarMsRight(Q.W)
   Else
  Begin
   If Q.ML.Count>0Then Begin
    ALSetPtr(Q.ML,0);
    For I:=0to Q.ML.Count-1do Begin
     CT:=_ALGetCurrBuf(Q.ML);
     If(CT<>NIL)Then Begin
      PutLabel(WEGetRX1(Q.W)+CT^.X,PMGetHomeY(Q)+CT^.Y,
               Length(CT^.Name),CT^.Name,CT^.Kr);
      YW:=CT^.Y+1;
     End;
     ALNext(Q.ML);
    End;
   End;
  End;
  ALSetPtr(Q.ML,Q.WP);
  CT:=_ALGetCurrBuf(Q.ML);
  If(CT<>NIL)Then Begin
   If(NoOnglet)in(Q.Option)Then Begin
    Q.Min:=0;Q.Max:=Q.L.Count-1;
   End
    Else
   Begin
    Q.Min:=CT^.Min;Q.Max:=CT^.Max;
   End;
   WEClrWn(Q.W,0,PMHomeY(Q)+YW,wnMax,wnMax,CT^.Kr);
   Q.Kr:=CT^.Kr;
   PMWRefreshIcon(Q);
  End;
  If(Q.Mode=mFolder)Then PMWRefreshStatusBar(Q);
 End;
End;

Procedure PMWSaveGroup(Var Q:ProgramsManagerApp);
Var
 Handle:Hdl;
 Header:HeaderGroupRec;
 I,J:Word;
 X:Boolean;
 CT:^CategoryRec;
 T:^ProgramRec;
 P:LongInt;
Begin
 Handle:=FileCreate(Path2NoExt(Q.Path)+'.GIX');
 If(Handle<>errHdl)Then Begin
  FillClr(Header,SizeOf(Header));
  Header.Sign:='GROUPE'#26;
  FindFirst(Q.Path,faArchive,Header.Info);
  Header.NumCat:=Q.ML.Count;Header.NumProg:=Q.L.Count;
  _SetAbsRec(Handle,0,SizeOf(Header),Header);
  P:=SizeOf(Header);
  ALSetPtr(Q.ML,0);
  For I:=0to Q.ML.Count-1do Begin
   CT:=_ALGetCurrBuf(Q.ML);
   If(CT<>NIL)Then Begin
    _SetAbsRec(Handle,P,SizeOf(CategoryRec),CT^);
    Inc(P,Long(SizeOf(CategoryRec)));
   End;
   ALNext(Q.ML);
  ENd;
  ALSetPtr(Q.L,0);
  For I:=0to Q.L.Count-1do Begin
   T:=_ALGetCurrBuf(Q.L);
   If(T<>NIL)Then Begin
    _SetAbsRec(Handle,P,SizeOf(ProgramRec),T^);
    Inc(P,Long(SizeOf(ProgramRec)));
    X:=Not((T^.Res.Handle=errHdl)or(T^.Res.Output=$FF));
    _SetAbsRec(Handle,P,SizeOf(X),X);
    Inc(P,SizeOf(X));
    RIWriteImage(Handle,diIconAdele,0,P,T^.Res);
   End;
   ALNext(Q.L);
  End;
  FileClose(Handle);
 End;
End;

Function PMWLoadGroup(Var Q:ProgramsManagerApp):Boolean;
Var
 Handle:Hdl;
 Header:HeaderGroupRec;
 I,J,IX,IY,MX,MY:Word;
 X:Boolean;
 CTP:^CategoryRec;
 CT:CategoryRec;
 T:ProgramRec;
 P:LongInt;
 Info:SearchRec;
 L:Window;
Begin
 PMWLoadGroup:=False;
 Handle:=FileOpen(Path2NoExt(Q.Path)+'.GIX',fmRead);
 If(Handle<>errHdl)Then Begin
  _GetAbsRec(Handle,0,SizeOf(Header),Header);
  FindFirst(Q.Path,faArchive,Info);
  If(Header.Sign<>'GROUPE'#26)or(Header.Info.Time<>Info.Time)Then Begin
   FileClose(Handle);
   Exit;
  End;
  WEInitO(L,42,4);
  WEPushWn(L);
  WEPutWnKrDials(L,'');
  WEPutTxtXY(L,1,1,'Chargement des groupes d''applications...');
  P:=SizeOf(Header);
  ALSetPtr(Q.ML,0);
  For I:=0to Header.NumCat-1do Begin
   _GetAbsRec(Handle,P,SizeOf(CategoryRec),CT);
   Inc(P,Long(SizeOf(CategoryRec)));
   ALAddBlock(Q.ML,SizeOf(CategoryRec),CT);
  ENd;
  ALSetPtr(Q.ML,0);
  ALSetPtr(Q.L,0);
  For I:=0to Header.NumProg-1do Begin
   _GetAbsRec(Handle,P,SizeOf(ProgramRec),T);
   Inc(P,Long(SizeOf(ProgramRec)));
   CTP:=_ALGetCurrBuf(Q.ML);
   If(CTP^.Min=I)Then Begin
    IX:=0;IY:=HeightChr shl 1;
    MX:=(Q.W.MaxX+1)shl 3;MY:=GetRawY(Q.W.MaxY);
   End;
   T.X:=IX;T.Y:=IY;Inc(IX,(Length(T.Name)+1)shl 3);
   If(IX>MX)Then Begin
    IX:=0;Inc(IY,64);T.X:=IX;T.Y:=IY;
    IX:=(Length(T.Name)+1)shl 3;
   End;
   _GetAbsRec(Handle,P,SizeOf(X),X);
   Inc(P,SizeOf(X));
   If(X)Then Begin
    RIReadImage(Handle,diAutoDetect,P,4,$FFFF,rmAllResSteady,[],T.Res);
   End;
   ALAddBlock(Q.L,SizeOf(ProgramRec),T);
   If(I=CTP^.Max)Then ALNext(Q.ML);
  End;
  FileClose(Handle);
  WEDone(L);
  PMWLoadGroup:=True;
 End;
End;

Function PMWInit{Var Q:ProgramsManager;X1,Y1,X2,Y2:Byte):Boolean};Begin
 PMWInit:=Ya;
 PMWLoad(QX,X1,Y1,X2,Y2,MaltePath+'PROGMAN.INI');
End;

Procedure _PMWLoad(Var Context;X1,Y1,X2,Y2:Byte;Const Path:String;StartMode:Boolean);
Var
 Handle:Hdl;       { ®Handle¯ associ‚e … la lecture d'un profil }
 S,TS:String;
 FP,FS:Long;       { Position actuel et taille d'un fichier }
 T:ProgramRec;     { Enregistrement de programme }
 CT:CategoryRec;   { Enregistrement de cat‚gorie }
 W:Window;         { BoŒte de dialogue temporaire }
 PT:^CategoryRec;  { Pointeur sur la cat‚gorie courante }
 I,J,P,CX,X,Y,MX,MY:Word;
 Q:ProgramsManagerApp Absolute Context;
 Files:BF;         { Objet de manipulation de fichier }
 Info:SearchRec;   { Information … propos d'un entr‚e fichier }
 MXP:Integer;      { Position maximal horizontal }
 Sep:Byte;         { Position du s‚p‚rateur }
 Color:DataSetInMemory;{ Nom des couleurs }
Begin
{ PMWInit:=No;}
 FillClr(Q,SizeOf(Q));
 If(StartMode)Then Q.Mode:=mWin9X;
 Q.Path:=Path;
 Sep:=Pos('|',Q.Path);
 If Sep>0Then Begin
  Q.Title:=Copy(Q.Path,Sep+1,255);
  Systems._Left(Q.Path,Sep-1);
 End;
 If Q.Path[Length(Q.Path)]='\'Then Begin
  Q.Mode:=mFolder;
  Include(Q.Option,DirLine);
  Include(Q.Option,NoOnglet);
  If Not((Left(Q.Path,4)='SYS:')or(Q.Path[2]=':')or(Q.Path[1]='\'))Then Q.Path:=MaltePath+Q.Path;
 End;
 WEInit(Q.W,X1,Y1,X2,Y2);
 X:=0;Y:=HeightChr shl 1;
 MX:=(Q.W.MaxX+1)shl 3;MY:=GetRawY(Q.W.MaxY);
 If Not PMWLoadGroup(Q)Then Begin
  FillClr(CT,SizeOf(CT));
  If(Q.Mode=mFolder)Then Begin
   CT.Kr:=CurrKrs.Dialog.Env.List.Border;
   ALAddBlock(Q.ML,SizeOf(CT),CT);
   PT:=_ALGetBuf(Q.ML,Q.ML.Count-1);
   Q.MYP:=0;Q.MXP:=0;MXP:=0;
   BFInit(Files);
   BFSelPathExt(Files,Q.Path+'*.*',faAll);
   For I:=0to BFMaxFiles(Files)do Begin
    FillClr(T,SizeOf(T));
    BFGetFile(Files,I,Info);
    If Not((Info.Name='..')and((sfaDir)in(Info.Attr.Flags)))Then Begin
     T.X:=X;T.Y:=Y;Inc(X,(14)shl 3);
     Inc(MXP);
     If(X>MX)Then Begin
      X:=0;
      Inc(Y,64);
      T.X:=X;T.Y:=Y;
      X:=14 shl 3;
      Dec(Q.MYP);
      MXP:=0;
     End;
     If(MXP>Q.MXP)Then Q.MXP:=MXP;
     T.Name:=Info.Name;
     T.Path:=Q.Path+T.Name;
     If(sfaDir)in(Info.Attr.Flags)Then T.Icon:=MaltePath+'ICON\FOLDER32.ICO'Else
     If Path2Ext(T.Name)='.ICO'Then T.Icon:=Q.Path+Info.Name;
     RILoadImage(T.Icon,diAutoDetect,4,$FFFF,rmAllResSteady,[],T.Res);
     If Not ALAddBlock(Q.L,SizeOf(ProgramRec),T)Then Break;
    End;
   End;
   Q.SizeFolder:=Files.SizeFiles;
   BFDone(Files);
  End
   Else
  Begin
   Handle:=FileOpen(Q.Path,fmRead);
   If(Handle<>errHdl)Then Begin
    WEInitO(W,40,4);
    WEPushWn(W);
    WEPutWnKrDials(W,'Chargement en cours...');
    DBOpenServerName(ChantalServer,'CHANTAL:/Materiel/Video/CouleurClassique.Dat');
    DBCopyToMemory(ChantalServer,Color);
    PT:=NIL;
    FS:=FileSize(Handle);FP:=0;CX:=0;
    Repeat
     FillClr(T,SizeOf(T));
     __GetAbsFileTxtLn(Handle,FP,S);
     If S<>''Then Begin
      If S[1]='['Then Begin
       If(PT<>NIL)Then PT^.Max:=Q.L.Count-1;
       FillClr(CT,SizeOf(CT));
       J:=Pos(':',S);
       If J>0Then Begin
        CT.Name:=Copy(S,2,J-3);
        S:=Copy(S,J+1,255);
        If DBLocateAbsIM(Color,5,S,[soNoCaseSensitive])Then CT.Kr:=Color.CurrRec.Byte^
                                                       Else CT.Kr:=White shl 4;
       End
        Else
       Begin
        CT.Name:=Copy(S,2,Length(S)-2);
        CT.Kr:=$E0-(Q.ML.Count shl 4);
       End;
       CT.Min:=Q.L.Count;CT.X:=CX;
       ALAddBlock(Q.ML,SizeOf(CT),CT);
       PT:=_ALGetBuf(Q.ML,Q.ML.Count-1);
       Inc(CX,Length(CT.Name)+4);
       X:=0;Y:=HeightChr shl 1;
      End
       Else
      If S[1]<>';'Then Begin
       J:=1;P:=0;TS:='';
       For I:=1to Length(S)do Begin
        If S[I]<>','Then IncStr(TS,S[I])
         Else
        Begin
         Case(P)of
          0:T.Name:=TS;
          1:T.Icon:=TS;
          2:T.Path:=TS;
          3:T.Args:=TS;
         End;
         TS:='';Inc(P);
        End;
       End;
       If TS<>''Then Begin
        Case(P)of
         0:T.Name:=TS;
         1:T.Icon:=TS;
         2:T.Path:=TS;
         3:T.Args:=TS;
        End;
       End;
       T.X:=X;T.Y:=Y;Inc(X,(Length(T.Name)+1)shl 3);
       If(X>MX)Then Begin
        X:=0;
        Inc(Y,64);
        T.X:=X;T.Y:=Y;
        X:=(Length(T.Name)+1)shl 3;
       End;
       WEPutTxtXY(W,0,PMHomeY(Q)+1,StrUSpc(TruncName(T.Icon,38),38));
       If Not FileExist(T.Icon)Then Begin
        If FileExist(MaltePath+T.Icon)Then T.Icon:=MaltePath+T.Icon;
       End;
       RILoadImage(T.Icon,diAutoDetect,4,$FFFF,rmAllResSteady,[],T.Res);
       If Not ALAddBlock(Q.L,SizeOf(ProgramRec),T)Then Break;
      End;
     End;
    Until FP>=FS;
    WEDone(W);
    FileClose(Handle);
    DBDispose(Color);
    If(PT<>NIL)Then PT^.Max:=Q.L.Count-1;
    PMWSaveGroup(Q);
   End;
  End;
 End;
 PMWRefresh(Q);
{ PMWInit:=Ya;}
End;

Procedure PMWLoad{Var QX;X1,Y1,X2,Y2:Byte;Const Path:String};Begin
 _PMWLoad(QX,X1,Y1,X2,Y2,Path,False);
End;

Procedure PMWColorTitle{Var Q:ProgramsManager};
Var
 Data:Record
  Background:MColorGrid16;
 End;
 CT:^CategoryRec;
Begin
 FillClr(Data,SizeOf(Data));
 CT:=_ALGetBuf(Q.ML,Q.WP);
 Data.Background.Color:=CT^.Kr shr 4;
 If ExecuteAppDPU(42,Data)Then Begin
  Data.Background.Color:=Data.Background.Color shl 4;
  If Data.Background.Color=0Then Data.Background.Color:=White;
  CT^.Kr:=Data.Background.Color;
  Q.Modified:=True;
 End;
End;

Procedure PMWExecute(Var Q:ProgramsManagerApp;Var TP:ProgramRec);
Var
 Buffer:Record
  ID:Word;
  Command:String;
 End;
 Data:OS2StartData Absolute Buffer;
 S:String;
 E:Word;
Begin
 Q.CurrProg:=pmwNone;TP.Path:=StrUp(TP.Path);
 DBOpenServerName(ChantalServer,'CHANTAL:/DOS/LocalExecutable.Dat');
 If DBLocateAbs(ChantalServer,1,TP.Path,[soNoCaseSensitive])Then Begin
  DBReadRec(ChantalServer,Buffer);
  Q.CurrProg:=Buffer.ID;
 End
  Else
 If(OS2)Then Begin
  FillClr(Data,SizeOf(Data));
  Data.LenStruct:=$32;
  Data.Process:=prNew;
  Data.Priority:=prForeground;
  PChr(Data.Title):=Str2PChr(TP.Name);
  If Copy(TP.Path,Length(TP.Path)-3,4)='.BAT'Then Begin
   S:='/C'+TP.Path;
   PChr(Data.Args):=Str2PChr(S);
  End
   Else
  Begin
   PChr(Data.Name):=Str2PChr(TP.Path);
   PChr(Data.Args):=Str2PChr(TP.Args);
  End;
  If(RIModel(TP.Res)=diIconOS2)Then PChr(Data.Icon):=Str2PChr(TP.Icon);
  E:=OS2Exec(Data);
  StrDispose(PChr(Data.Icon));
  StrDispose(PChr(Data.Title));
  StrDispose(PChr(Data.Name));
  StrDispose(PChr(Data.Args));
  If E>0Then ErrNoMsgOk(E);
 End
  Else
 ExecPrg(TP.Path,TP.Args);
End;

{  Cette fonction permet … l'utilisateur de faire traŒter sa commande par
  l'application.
}

Function PMWRun{Var Q:ProgramsManager):Word};
Const
  {Menu de programme (application)}
 pmNone=0;            { Aucune action }
 pmRename=1;          { Renommer }
 pmPropriety=2;       { Les propri‚t‚s }
 pmOpen=3;            { Ouvre un document, dessin, ic“ne,...}
 pmDelete=4;          { Supprimer }
  {Menu du titre (onglet)}
 tmNone=0;            { Auucune action}
 tmRename=1;          { Renommer }
 tmColor=2;           { Changer la couleur }
Label SetPlane,Enter;
Var
 TP,TPS:^ProgramRec;
 CT:^CategoryRec;
 RX,RY,I,K:Word;
 Q:ProgramsManagerApp Absolute Context;
 Ok:Boolean;
 BW:Window;

 Procedure PutItem(Kr:Byte);
 Var
  Y:Integer;
 Begin
  If(TP<>NIL)Then Begin
   Y:=2+(TP^.Y div HeightChr)+(Q.YP shl 2);
   If Y<=0Then Exit;
   Y:=PMGetHomeY(Q)+Y;
   If HeightChr<=8Then Inc(Y,2);
   PutSmlTxtXY(WEGetRX1(Q.W)+(TP^.X shr 3),Y,TP^.Name,Kr);
  End;
 End;

 Function LocalMenu:Byte;
 Var
  K:Word;
  PL:Array[0..3]of Boolean;
  Refresh:Boolean;       { Demande un rafraŒchissement des informations }
  H:SearchRec;           { Information associ‚ au fichier }
  SearchPChr:Record
   Fill:Array[0..16]of Char;
   PC:PChr;
  End Absolute H;
 Begin
  LocalMenu:=pmNone;
  TPS^.Path:=StrUp(TPS^.Path);
  If(Q.Mode=mFolder)Then Begin
   FindFirst(TPS^.Path,faAll,H);
   SearchPChr.PC:=NIL;
   Case FileMenuContext(NIL,TPS^.Path,H,Refresh)of
    1:LocalMenu:=pmOpen;
    5,6,10,11:ErrNoMsgOk(FunctionOutContext);
    7:Refresh:=RenameEntry(TPS^.Path,H);
    8:Refresh:=KillFile(TPS^.Path,H);
    9:Refresh:=SetPropriety(TPS^.Path,H);
   End;
  End
   Else
  Begin
   PL[0]:=TPS^.Path='WRITE.EXE';
   PL[1]:=TPS^.Path='PAINT.EXE';
   PL[2]:=TPS^.Path='NOTEPAD.EXE';
   PL[3]:=TPS^.Path='CONFIGURATION.SOURIS';
   K:=_RunMenuApp(44,PL);
   If(K=pmOpen)Then Begin
    If PL[0]Then Q.CurrProg:=pmwOpenWrite;
    If PL[1]Then Q.CurrProg:=pmwOpenPaint;
    If PL[2]Then Q.CurrProg:=pmwOpenNotePad;
    If PL[3]Then Q.CurrProg:=pmwCfgMouse;
   End;
   Case(K)of
    pmRename..pmDelete:Begin
     If(K=pmOpen)and(PL[3])Then MouseInfo
                           Else LocalMenu:=K;
    End;
    kbMouse:WaitMouseBut0;
   End;
  End;
 End;

 Function TitleMenu:Byte;
 Var
  K:Word;
 Begin
  TitleMenu:=pmNone;
  K:=RunMenuApp(24);
  Case(K)of
   tmRename..tmColor:TitleMenu:=K;
  End;
 End;

Begin
 If(Q.Mode=mWin9X)Then Begin
  FillClr(BW,SizeOf(BW));
  BW.T.X1:=$F0;BW.T.Y1:=$F1;BW.T.X2:=$F0;BW.T.Y2:=$F0;
  PMWRun:=WEReadk(BW)
 End
  Else
 Begin
  ALSetPtr(Q.L,Q.P);
  TP:=_ALGetCurrBuf(Q.L);
  PutItem(Q.W.Palette.Sel);
  Repeat
   K:=WEReadk(Q.W);
   Case(K)of
    kbUp:If Q.YP<0Then Begin
     PutItem(Q.Kr);
     Inc(Q.YP);
     Dec(Q.P,Q.MXP);
     If Q.MXP<0Then Q.P:=0;
     PMWRefreshIcon(Q);
     ALSetPtr(Q.L,Q.P);
     TP:=_ALGetCurrBuf(Q.L);
     PutItem(Q.W.Palette.Sel);
    End;
    kbDn:If(Q.YP>Q.MYP)Then Begin
     PutItem(Q.Kr);
     Dec(Q.YP);
     Inc(Q.P,Q.MXP);
     If(Q.MXP>Q.Max)Then Q.P:=Q.Max;
     PMWRefreshIcon(Q);
     ALSetPtr(Q.L,Q.P);
     TP:=_ALGetCurrBuf(Q.L);
     PutItem(Q.W.Palette.Sel);
    End;
    kbLeft:If(Q.P>Q.Min)Then Begin
     PutItem(Q.Kr);
     Dec(Q.P);
     ALPrevious(Q.L);
     TP:=_ALGetCurrBuf(Q.L);
     PutItem(Q.W.Palette.Sel);
    End;
    kbRight:If(Q.P<Q.Max)Then Begin
     PutItem(Q.Kr);
     Inc(Q.P);
     ALNext(Q.L);
     TP:=_ALGetCurrBuf(Q.L);
     PutItem(Q.W.Palette.Sel);
    End;
    kbPgUp:If Q.WP>0Then Begin
     Dec(Q.WP);
     PMWRefresh(Q);
     Q.P:=Q.Min;
     ALSetPtr(Q.L,Q.P);
     TP:=_ALGetCurrBuf(Q.L);
     PutItem(Q.W.Palette.Sel);
    End;
    kbPgDn:If Q.WP<Q.ML.Count-1Then Begin
     Inc(Q.WP);
 SetPlane:
     PMWRefresh(Q);
     Q.P:=Q.Min;
     ALSetPtr(Q.L,Q.P);
     TP:=_ALGetCurrBuf(Q.L);
     PutItem(Q.W.Palette.Sel);
    End;
    kbEnter:Begin
 Enter:
     PMWExecute(Q,TP^);
     If(Q.CurrProg<>pmwNone)Then Break;
    End;
    kbCtrlEnter:PMWPropriety(Q);
    kbInWn:Begin
     WaitMouseBut0;
     If(WEGetRY1(Q.W)=LastMouseY)Then Begin
      ALSetPtr(Q.ML,0);
      If Q.ML.Count>0Then For I:=0to Q.ML.Count-1do Begin
       CT:=_ALGetCurrBuf(Q.ML);
       RX:=CT^.X+WEGetRX1(Q.W);RY:=(CT^.Y div HeightChr)+PMGetHomeY(Q);
       If(RX<=LastMouseX)and(RX+Length(CT^.Name)+3>=LastMouseX)and
         (RY=LastMouseY)Then Begin
        If(Q.WP=I)and(LastMouseB=2)Then Begin
         Case(TitleMenu)of
          tmColor:PMWColorTitle(Q);
         End;
        End
         Else
        Q.WP:=I;
        Goto SetPlane;
       End;
       ALNext(Q.ML);
      End;
     End
      Else
     Begin
       {Recherche une position proportionnelle … un programme...}
      Ok:=No;
      ALSetPtr(Q.L,Q.Min);
      For I:=Q.Min to(Q.Max)do Begin
       TPS:=_ALGetCurrBuf(Q.L);
       RX:=(TPS^.X shr 3)+WEGetRX1(Q.W);RY:=(TPS^.Y div HeightChr)+PMGetHomeY(Q);
       If(RX<=LastMouseX)and(RX+Length(TPS^.Name)>=LastMouseX)and
         (RY<=LastMouseY)and(RY+2>=LastMouseY)Then Begin
        If(Q.P=I)Then Begin{ D‚ja dans la zone? }
         If LastMouseB=2Then Begin
          Case(LocalMenu)of
           pmRename:PMWRename(Q);
           pmDelete:PMWDeleteApp(Q);
           pmPropriety:PMWPropriety(Q);
           pmOpen:Begin
            PMWRun:=kbEnter;
            Exit;
           End;
          End;
         End
          Else
         Begin
          K:=kbEnter;
          Goto Enter;
         End;
        End
         Else
        Begin
         __HideMousePtr;
         PutItem(Q.Kr);
         Q.P:=I;Ok:=Ya;
         ALSetPtr(Q.L,Q.P);
         TP:=_ALGetCurrBuf(Q.L);
         PutItem(Q.W.Palette.Sel);
         __ShowMousePtr;
        End;
        Break;
       End;
       ALNext(Q.L);
      End;
      If Not(Ok)Then Begin
       ALSetPtr(Q.L,Q.P);
       If LastMouseB=2Then Begin
        If(Pos('SETUP',Q.Path)=0)Then Begin
         Case RunMenuApp(153)of
          $F006:PMAddApp(Q);
         End;
        End;
       End;
      End;
     End;
    End;
    Else Break;
   End;
  Until No;
  PMWRun:=K;
 End;
End;

Procedure PMWReSize{Var Context;X1,Y1,X2,Y2:Byte};
Var
 Q:ProgramsManagerApp Absolute Context;
Begin
 WEDone(Q.W);
 WEInit(Q.W,X1,Y1,X2,Y2);
 PMWRecalcAllIconPos(Q);
End;

Procedure PMWMove2(Var Context;X,Y:Byte);
Var
 Q:ProgramsManagerApp Absolute Context;
Begin
 PMWReSize(Q,X,Y,X+Q.W.T.X2-Q.W.T.X1,Y+Q.W.T.Y2-Q.W.T.Y1);
End;

{ Cette fonction permet de connaŒtre le titre de cette application.
}

Function PMWTitle{Var Context;Max:Byte):String};
Var
 Q:ProgramsManagerApp Absolute Context;
 S:String;
Begin
 If(Q.Mode=mWin9X)Then S:='D‚marrer³Start'Else
 If Q.Title<>''Then Begin
  PMWTitle:=Q.Title;
  Exit;
 End
  Else
 If(Q.Mode=mFolder)Then S:='Dossier³Folder'
                   Else S:='Gestionnaire de programmes³Program Manager';
 PMWTitle:=MessageByLanguage(S);
End;

Procedure PMWMakeOngletMenu{Q:ProgramsManager;Var X:PullSubMnu;Var Sub:Array of PullSubMnu};
Var
 CT:^CategoryRec;
 J:Integer;
 PC:PChar;
Begin
 SMInit(X);
 ALSetPtr(Q.ML,0);
 If Not((NoOnglet)in(Q.Option))Then Begin
  For J:=0to Q.ML.Count-1do Begin
   CT:=_ALGetCurrBuf(Q.ML);
   If(CT<>NIL)Then Begin
    PC:=@CT^.Name[1];
    If Length(CT^.Name)>=31Then CT^.Name[31]:=#0
                           Else CT^.Name[Length(CT^.Name)+1]:=#0;
    SMAddFullItem(X,PC,kbNoKey,$F100+J,Sub[J].Ptr,PC);
   End;
   ALNext(Q.ML);
  End;
 End;
End;

Procedure PMWMakeGroupMenu{Q:ProgramsManager;Num:Byte;Var X:PullSubMnu};
Var
 TP:^ProgramRec;
 CT:^CategoryRec;
 PC:PChar;
 I:Integer;
Begin
 ALSetPtr(Q.ML,Num);
 CT:=_ALGetCurrBuf(Q.ML);
 Q.Min:=CT^.Min;Q.Max:=CT^.Max;
 Q.Kr:=CT^.Kr;
 If Q.L.Count>0Then Begin
  ALSetPtr(Q.L,CT^.Min);
  For I:=CT^.Min to(CT^.Max)do Begin
   TP:=_ALGetCurrBuf(Q.L);
   If(TP<>NIL)Then Begin
    PC:=@TP^.Name[1];
    If Length(TP^.Name)>=80Then TP^.Name[80]:=#0
                           Else TP^.Name[Length(TP^.Name)+1]:=#0;
    SMAddFullItem(X,PC,kbNoKey,$F200+(Num shl 8)+I-CT^.Min,NIL,PC);
   End;
   ALNext(Q.L);
  End;
 End;
End;

Function PMWExecCmd{Q:ProgramsManager;K:Word):Word};
Var
 Num:Byte;
 TP:^ProgramRec;
 CT:^CategoryRec;
Begin
 PMWExecCmd:=pmwNone;
 Num:=(K-$F200)shr 8;
 CT:=_ALGetBuf(Q.ML,Num);
 TP:=_ALGetBuf(Q.L,CT^.Min+(K and$FF));
 If(TP<>NIL)Then Begin
  PMWExecute(Q,TP^);
  PMWExecCmd:=Q.CurrProg;
 End;
End;

Procedure PMWPutIconVert{Q:ProgramsManager;Num:Byte;X,Y,L,H,Kr:Word};
Var
 TP:^ProgramRec;
 CT:^CategoryRec;
 I:Integer;
Begin
 ALSetPtr(Q.ML,Num);
 CT:=_ALGetCurrBuf(Q.ML);
 Q.Min:=CT^.Min;Q.Max:=CT^.Max;
 Q.Kr:=CT^.Kr;
 If Q.L.Count>0Then Begin
  ALSetPtr(Q.L,CT^.Min);
  For I:=CT^.Min to(CT^.Max)do Begin
   TP:=_ALGetCurrBuf(Q.L);
   If(TP<>NIL)Then Begin
    RIPutImageScale(TP^.Res,X,Y,L,H,Kr);
    Inc(Y,H);
   End;
   ALNext(Q.L);
  End;
 End;
End;

Procedure PMWStartMode(Var Q:ProgramsManagerApp;Mode:Byte);Begin
 If(Mode=startInv)Then Begin
  If(Q.Mode=mWin9X)Then Q.Mode:=mDefault
                   Else Q.Mode:=mWin9X;
 End
  Else
 Begin
  If Mode=0Then Q.Mode:=mDefault
           Else Q.Mode:=mWin9X;
 End;
End;

Procedure PMWInActif(Var Context);
Var
 Q:ProgramsManagerApp Absolute Context;
Begin
 If(Q.Mode<>mWin9X)Then _WESetTitle(Q.W,Q.W.Title);
End;

{ Cette fonction permet de restituer la m‚moire attribu‚e par l'application
 de gestionnaire de programmes et de sauvegarder les modifications s'il y a
 lieu.
}

Function PMWDone{Var Context};
Var
 Q:ProgramsManagerApp Absolute Context;
 I,J:Integer;
 TP:^ProgramRec;
 CT:^CategoryRec;
 PStr:^String;
 Handle:Hdl;
 Color:DataSetInMemory;
Begin
  {Sauvegarder la nouvelle d‚finitions de programmes?}
 If(Q.Modified)Then Begin
  Handle:=FileCreateAndBackup(Q.Path);
  If(Handle<>errHdl)Then Begin
   DBOpenServerName(ChantalServer,'CHANTAL:/Materiel/Video/CouleurClassique.Dat');
   DBCopyToMemory(ChantalServer,Color);
   ALSetPtr(Q.ML,0);
   For J:=0to Q.ML.Count-1do Begin
    CT:=_ALGetCurrBuf(Q.ML);
    If(CT<>NIL)Then Begin
     If J>0Then PutFileLn(Handle);
     PutFileTxt(Handle,'['+CT^.Name+']:');
     For I:=0to Color.NumRec-1do Begin
      If(Color.Table^[Color.Index^[I]]=CT^.Kr)Then Begin
       PStr:=@Color.Table^[Color.Index^[I]+5];
       PutFileTxt(Handle,PStr^);
       Break;
      End;
     End;
     PutFileLn(Handle);
     ALSetPtr(Q.L,CT^.Min);
     For I:=CT^.Min to(CT^.Max)do Begin
      TP:=_ALGetCurrBuf(Q.L);
      If(TP<>NIL)Then Begin
       PutFileTxt(Handle,TP^.Name+',');
       If CmpLeft(TP^.Icon,MaltePath)Then
        TP^.Icon:=DelStr(TP^.Icon,1,Length(MaltePath));
       PutFileTxt(Handle,TP^.Icon+',');
       PutFileTxt(Handle,TP^.Path);
       If TP^.Args<>''Then Begin
        PutFileTxt(Handle,','+TP^.Args);
       End;
       PutFileLn(Handle);
      End;
      ALNext(Q.L);
     End;
    End;
    ALNext(Q.ML);
   End;
   FileClose(Handle);
   DBDispose(Color);
  End;
 End;
  { Restitu‚e la m‚moire ressource attribu‚ pour cette application }
 If Q.L.Count>0Then Begin
  ALSetPtr(Q.L,0);
  For I:=0to Q.L.Count-1do Begin
   TP:=_ALGetCurrBuf(Q.L);
   If(TP<>NIL)Then XFreeMem(TP^.Res);
   ALNext(Q.L);
  End;
 End;
 ALDone(Q.ML);
 ALDone(Q.L);
 WEDone(Q.W);
 PMWDone:=0;
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
END.