Unit WS;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                 INTERFACE
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Function  WSNew(Var Context;X1,Y1,X2,Y2:Byte):Boolean;
Procedure WSOpen(Var Context;X1,Y1,X2,Y2:Byte;Const Path:String);
Procedure WSRefresh(Var Context);
Function  WSRun(Var Context):Word;
Function  WSTitle(Var Context;Max:Byte):String;
Procedure WSMove2(Var Context;X,Y:Byte);
Procedure WSReSize(Var Context;X1,Y1,X2,Y2:Byte);
Function  WSDone(Var Context):Word;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                IMPLEMENTATION
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses Adele,Video,Systex,WinTex,Isatex,Systems,Dials,DialTree,DialPlus,Mouse,GeoTex,Dialex;

Type
 PEHeader=Record
  EnteteExeDos:PETypeHeaderExeDos;
  Entete:PETypeHeaderPE;
  EnteteOptionnelPE:PETypeHeaderOptionnelPE;
 End;

Procedure PEReadHeader(Handle:Hdl;Var PE:PEHeader);Begin
 _GetAbsRec(Handle,0,SizeOf(PE.EnteteExeDos),PE.EnteteExeDos);
 _GetAbsRec(Handle,PE.EnteteExeDos.OfstEntetePE,SizeOf(PETypeHeaderPE),PE.Entete);
 _GetRec(Handle,SizeOf(PETypeHeaderOptionnelPE),PE.EnteteOptionnelPE);
End;

Procedure PELoadHeader(Var Q:WorkShopApp;Var PE:PEHeader);
Var
 Handle:Hdl;
Begin
 Handle:=FileOpen(Q.FileName,fmRead);
 If(Handle<>errHdl)Then Begin
   PEReadHeader(Handle,PE);
  FileClose(Handle);
 End;
End;

Function FindOffsetResource(Var Q:WorkShopApp):LongInt;
Var
 Handle:Hdl;
 Txt:String;
 PE:PEHeader;
 EnteteSection:PETypeHeaderSection;
 RvaSectionTmp,IndexSection:LongInt;
Begin
 Handle:=FileOpen(Q.FileName,fmRead);
 If(Handle<>errHdl)Then Begin
  FindOffsetResource:=-1;
  PEReadHeader(Handle,PE);
  If PE.Entete.NbrSection=0Then Exit;
  RvaSectionTmp:=PE.EnteteOptionnelPE.RvaCode;
  IndexSection:=1;
  Txt:='';
  While IndexSection<PE.Entete.NbrSection+1do Begin
   _GetRec(Handle,SizeOf(PETypeHeaderSection),EnteteSection);
   Txt:=StrUp(Trim(LoadStr(EnteteSection.Nom,8)));
   If Pos('RSRC',txt)<>0Then Begin
    FindOffsetResource:=EnteteSection.PosDonnee;
    FileClose(Handle);
    Exit;
   End;
   Inc(IndexSection);
   Inc(RvaSectionTmp,EnteteSection.TailleVirtuelle);
  End;
  FileClose(Handle);
 End;
End;

Function PENomCpuRecquis(Var Q:WorkShopApp;CPU:Word):String;Begin
 PENomCpuRecquis:='';
 Case(CPU)of
  $0000:PENomCpuRecquis:='inconnu';
  $014C:PENomCpuRecquis:='Intel 80386 ou sup‚rieur';
  $014D:PENomCpuRecquis:='Intel 80486 ou sup‚rieur';
  $014E:PENomCpuRecquis:='Intel Pentium ou sup‚rieur';
  $0160:PENomCpuRecquis:='R3000 (MIPS)';
  $0162:PENomCpuRecquis:='R3000 (MIPS)';
  $0166:PENomCpuRecquis:='R4000 (MIPS)';
  $0168:PENomCpuRecquis:='R10000 (MIPS)';
  $0184:PENomCpuRecquis:='DEC Alpha AXP';
  $01F0:PENomCpuRecquis:='IBM Power PC';
 End;
End;

Function PENomSousSystem(Var Q:WorkShopApp;SousSystemRecquis:Word):String;Begin
 PENomSousSystem:='';
 Case(SousSystemRecquis)of
  1:PENomSousSystem:='Aucun';
  2:PENomSousSystem:='Sous-systŠme graphique';
  3:PENomSousSystem:='Console Windows';
  4:PENomSousSystem:='Console OS/2';
  5:PENomSousSystem:='Console POSIX';
 End;
End;

Procedure WSShowHeaderPE(Var Q:WorkShopApp);
Var
 Handle:Hdl;
 Form:Record
  NomFichier:String[80];
  CPURequired:String[30];
  NumSection:String[5];
  CreateDate:String[30];
  SizeHeaderOptional:String[40];
  Option:Array[0..11]of String[38];
  RVAImageBase:String[30];
  RvaPointEntreeCode:String[30];
  RvaCode:String[50];
  SizeCode:String[30];
  RvaData:String[50];
  SizeData:String[30];
  VarSize:String[15];
  SizeHeader:String[30];
  AlignMem:String[30];
  AlignFile:String[30];
  VerOS:String[30];
  VerBin:String[30];
  VerWin32:String[30];
  SubSys:String[30];
 End;
 PE:PEHeader;
 I:Byte;

 Procedure PushOption(Const Option:String);Begin
  If I>11Then Exit;
  Form.Option[I]:=Option;
  Inc(I);
 End;

Begin
 FillClr(Form,SizeOf(Form));
 Form.NomFichier:=Path2NoDir(Q.FileName);
 PELoadHeader(Q,PE);
 Form.CPURequired:=PENomCpuRecquis(Q,PE.Entete.CPU);
 Form.NumSection:=WordToStr(PE.Entete.NbrSection);
 Form.CreateDate:=HexLong2Str(PE.Entete.DateCreation);
 Form.SizeHeaderOptional:=IntToStr(PE.Entete.TailleEnteteOptionnel)+
            ' octets ('+HexLong2Str(PE.Entete.TailleEnteteOptionnel)+')';
 I:=0;
 If PE.Entete.Option<>0Then Begin
  PushOption('(='+HexLong2Str(PE.Entete.Option)+')');
  If PE.Entete.Option shr 13 and 1=1Then PushOption('ş BibliothŠque DLL');
  If PE.Entete.Option shr 8 and 1=1Then PushOption('ş Programme 32 bits');
  If PE.Entete.Option shr 1 and 1=1Then PushOption('ş Ex‚cutable');
  If PE.Entete.Option shr 9 and 1=1Then PushOption('ş Aucune information de d‚bogage');
  If PE.Entete.Option shr 0 and 1=0Then PushOption('ş Informations r‚allouables');
  If PE.Entete.Option shr 14 and 1=1Then PushOption('ş Anti-multi-processeurs');
  If PE.Entete.Option shr 10 and 1=1Then PushOption('ş Lancement de support amovible interdit');
  If PE.Entete.Option shr 11 and 1=1Then PushOption('ş Lancement sur r‚seau interdit');
  If PE.Entete.Option shr 3 and 1=0Then PushOption('ş Informations sur les symboles locaux');
  If PE.Entete.Option shr 4 and 1=1Then PushOption('ş Compatible aux SystŠme d''exploitation');
  If(PE.Entete.Option shr 7 and 1=1)and(PE.Entete.Option shr 15 and 1=1)Then
   PushOption('ş Octets doivent ˆtre ‚chang‚s mot/mot');
  If PE.Entete.Option shr 12 and 1=1Then PushOption('ş Fichier systŠme (pilote)');
 End
  Else
 PushOption('ş Aucune');
 Form.RVAImageBase:=HexLong2Str(PE.EnteteOptionnelPE.RvaImageBase)+'h';
 Form.RvaPointEntreeCode:=HexLong2Str(PE.EnteteOptionnelPE.RvaPointEntreeCode)+'h';
 Form.RvaCode:=HexLong2Str(PE.EnteteOptionnelPE.RvaCode)+'h';
 Form.SizeCode:=HexLong2Str(PE.EnteteOptionnelPE.TailleCode)+'h';
 Form.RvaData:=HexLong2Str(PE.EnteteOptionnelPE.RvaDonnee)+'h';
 Form.SizeData:=HexLong2Str(PE.EnteteOptionnelPE.TailleDonnee)+'h';
 If PE.EnteteOptionnelPE.TailleVar<>0Then Form.VarSize:=HexLong2Str(PE.EnteteOptionnelPE.TailleVar)
                                     Else Form.VarSize:='(nulle)';
 Form.SizeHeader:=IntToStr(PE.EnteteOptionnelPE.TailleDesEntete)+' octets';
 Form.AlignMem:='par '+IntToStr(PE.EnteteOptionnelPE.AlignementRam)+' octets';
 Form.AlignFile:='par '+IntToStr(PE.EnteteOptionnelPE.AlignementFichier)+' octets';
 Form.VerOS:=WordToStr(PE.EnteteOptionnelPE.VerMajOS)+'.'+WordToStr(PE.EnteteOptionnelPE.VerMinOS);
 Form.VerBin:=WordToStr(PE.EnteteOptionnelPE.VerMaj)+'.'+WordToStr(PE.EnteteOptionnelPE.VerMin);
 Form.VerWin32:=WordToStr(PE.EnteteOptionnelPE.VerMajSousOS)+'.'+WordToStr(PE.EnteteOptionnelPE.VerMinSousOS);
 If(PE.EnteteOptionnelPE.VerMajSousOS=4)and(PE.EnteteOptionnelPE.VerMinSousOS=0)Then AddStr(Form.VerWin32,' (Windows 95)');
 Form.SubSys:=PENomSousSystem(Q,PE.EnteteOptionnelPE.SousSystemeRecquis);
 WERInit(Q.R);
 Q.R.IsWindowFixed:=True;
 WESubWins(Q.W,Q.MinX,Q.MinY,wnMax,wnMax-1,Q.R.W);
 WERLoadApp(Q.R,163,Form);
 {Result:=}WERRun(Q.R);
 WERDone(Q.R);
{ ExecuteAppDPU(163,Form);}
End;

Procedure WSShowHeaderGeoWorks(Var Q:WorkShopApp);
Var
 Handle:Hdl;
 Form:Record
  Name:String[80];
  Copyright:String[30];
  Class:String[40];
  VersionRelease:String[30];
  Protocol:String[30];
 End;
 Buffer:Array[0..255]of Char;
 Geos:GeosHeader Absolute Buffer;
 Geos2:Geos2Header Absolute Buffer;
Begin
 FillClr(Form,SizeOf(Form));
 Handle:=FileOpen(Q.FileName,fmRead);
 If(Handle<>errHdl)Then Begin
  _GetAbsRec(Handle,0,SizeOf(Buffer),Buffer);
  If(Geos.ID=GeosSignID)Then Begin
   Form.Name:=Trim(StrPas(@Geos.Name));
   Form.Copyright:=Trim(StrPas(@Geos.Copyright));
   Case(Geos.Class_)of
    $00:Form.Class:='Application';
    $01:Form.Class:='Fichier VM';
   End;
   Form.VersionRelease:=WordToStr(Geos.Release.VersMaj)+'.'+WordToStr(Geos.Release.VersMin)+'-'+
                        WordToStr(Geos.Release.RevMaj)+'.'+WordToStr(Geos.Release.RevMin);
   Form.Protocol:=WordToStr(Geos.Protocol.Vers)+'.'+WordToStr(Geos.Protocol.Rev);
  End
   Else
  If(Geos2.ID=Geos2SignID)Then Begin
   Form.Name:=Trim(StrPas(@Geos2.Name));
   Form.Copyright:=Trim(StrPas(@Geos2.Copyright));
   Case(Geos2.Class_)of
    $01:Form.Class:='Application';
    $02:Form.Class:='Fichier VM';
    $03:Form.Class:='Fichier d''octet';
    $04:Form.Class:='Information de r‚pertoire';
    $05:Form.Class:='Lien';
   End;
   Form.VersionRelease:=WordToStr(Geos2.Release.VersMaj)+'.'+WordToStr(Geos2.Release.VersMin)+'-'+
                        WordToStr(Geos2.Release.RevMaj)+'.'+WordToStr(Geos2.Release.RevMin);
   Form.Protocol:=WordToStr(Geos2.Protocol.Vers)+'.'+WordToStr(Geos2.Protocol.Rev);
  End;
  FileClose(Handle);
 End;
 WERInit(Q.R);
 Q.R.IsWindowFixed:=True;
 WESubWins(Q.W,Q.MinX,Q.MinY,wnMax,wnMax-1,Q.R.W);
 WERLoadApp(Q.R,164,Form);
 WERRun(Q.R);
 WERDone(Q.R);
End;

Function WSOnContextMenu(Var QX;Var Context):Boolean;
Var
 Q:WorkShopApp Absolute Context;
Begin
 Case(Q.ID)of
  cfoGeoWorks:WSShowHeaderGeoWorks(Q);
  Else WSShowHeaderPE(Q);
 End;
End;

Function WSNew(Var Context;X1,Y1,X2,Y2:Byte):Boolean;
Var
 Q:WorkShopApp Absolute Context;
Begin
 FillClr(Q,SizeOf(Q));
 WEInit(Q.W,X1,Y1,X2,Y2);
 Q.MinY:=1;
 Q.MinX:=20+((Q.W.MaxX+1-22)and$F);
 DTInit(Q.Tree,X1+2,Y1+2,X1+Q.MinX-1,Y1+Q.W.MaxY);
 DTMkDir(Q.Tree,'Programmes\');
 _DTMkDir(Q.Tree,'Programmes\Entˆte\',$F010);
 DTSetEndShortName(Q.Tree,'HEADER');
 Q.Tree.OnContextMenu:=WSOnContextMenu;
 Q.Tree.Context:=@Q;
 WSRefresh(Q);
End;

Procedure WSOpen(Var Context;X1,Y1,X2,Y2:Byte;Const Path:String);
Var
 Q:WorkShopApp Absolute Context;
 Handle:Hdl;
 Buffer:Array[0..79]of Char;
 Geos:GeosHeader Absolute Buffer;
Begin
 WSNew(Q,X1,Y1,X2,Y2);
 Q.FileName:=Path;
 Handle:=FileOpen(Q.FileName,fmRead);
 If(Handle<>errHdl)Then Begin
  _GetAbsRec(Handle,0,SizeOf(Buffer),Buffer);
  If(Geos.ID=GeosSignID)or(Geos.ID=Geos2SignID)Then Q.ID:=cfoGeoWorks;
  FileClose(Handle);
 End;
 Q.OffsetResource:=FindOffsetResource(Q);
 WSRefresh(Q);
End;

Procedure WSUpdateStatusBar(Var Q:WorkShopApp);
Var
 S:String;
Begin
 WESetEndBar(Q.W,CurrKrs.Desktop.DialStatus);
 Case(Q.ID)of
  cfoGeoWorks:S:='GeoWorks';
  Else S:='Windows';
 End;
 WESetEndBarTxtX(Q.W,1,S,CurrKrs.Desktop.DialStatus);
 WESetEndBarTxtX(Q.W,15,Q.FileName,CurrKrs.Desktop.DialStatus);
 If(IsGrf)Then Begin
  BarSpcHorRelief(Q.W.T.X1,Q.W.T.Y2,Q.W.T.X2,CurrKrs.Desktop.DialStatus);
  BarSpcHorReliefExt(Q.W.T.X1+1,Q.W.T.Y2,Q.W.T.X1+13,CurrKrs.Desktop.DialStatus);
  BarSpcHorReliefExt(Q.W.T.X1+15,Q.W.T.Y2,Q.W.T.X2-2,CurrKrs.Desktop.DialStatus);
  LuxeBox(Q.W.T.X2-1,Q.W.T.Y2);
 End;
End;

Procedure WSRefresh(Var Context);
Var
 Q:WorkShopApp Absolute Context;
Begin
 WEPutWnKrDials(Q.W,WSTitle(Q,Q.W.MaxX));
 WEBar(Q.W);
 WECloseIcon(Q.W);
 WEZoomIcon(Q.W);
 DTRefresh(Q.Tree);
 WSUpdateStatusBar(Q);
End;

Function WSRun(Var Context):Word;
Var
 Q:WorkShopApp Absolute Context;
 K:Word;
Begin
 {WSRun:=WEReadk(Q.W);}
 K:=DTRun(Q.Tree);
 If(K=kbMouse)Then Begin
  If WEInCloseIcon(Q.W,LastMouseX,LastMouseY)Then Begin
   WaitMouseBut0;
   K:=kbClose;
  End;
 End;
 WSRun:=K;
End;

Function  WSTitle(Var Context;Max:Byte):String;Begin
 WSTitle:='WorkShop';
End;

Procedure WSMove2(Var Context;X,Y:Byte);Begin
End;

Procedure WSReSize(Var Context;X1,Y1,X2,Y2:Byte);Begin
End;

Function  WSDone(Var Context):Word;Begin
 WSDone:=0;
End;

END.
