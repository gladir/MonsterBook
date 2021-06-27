{ Cette unit‚ est utilis‚e pour offrir un service de
 visualisation rapide d'un fichier ASCII.
}

{$I DEF.INC}

Unit ToolView;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                  INTERFACE
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses Systex,Isatex;

Procedure QHlp(Const FileName:String);
Procedure QHlp4RLL(Const FileName:String;IndexStart,IndexEnd:Wd);
Function  VAInit(Var Q:ViewAsciiApp;X1,Y1,X2,Y2:Byte;Const FileName:String;Hlp:Bool):Bool;
Function  VAInit4RLL(Var Q;X1,Y1,X2,Y2:Byte;Const FileName:String;Index,IndexEnd:Wd):Bool;
Function  VAInitRaw(Var Q:ViewAsciiApp;X1,Y1,X2,Y2:Byte;Const FileName:String):Bool;
Procedure VALoad(Var Q;X1,Y1,X2,Y2:Byte;Const Path:String);
Procedure VAGotoFilePos(Var Q:ViewAsciiApp;P:LongInt);
Procedure VADn(Var Q:ViewAsciiApp);
Procedure VAPgDn(Var Q:ViewAsciiApp);
Procedure VAPgUp(Var Q:ViewAsciiApp);
Procedure VAUp(Var Q:ViewAsciiApp);
Procedure VARefresh(Var Q);
Function  VARun(Var Q):Word;
Procedure VAReSize(Var Q;X1,Y1,X2,Y2:Byte);
Procedure VAMove2(Var QX;X,Y:Byte);
Function  VATitle(Var Q;Max:Byte):String;
Function  VADone(Var Q):Word;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                               IMPLEMENTATION
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses Adele,Memories,Systems,Video,Dialex,Dials;

Procedure VAPutData(Var Q:ViewAsciiApp);Near;Forward;
Procedure VARefreshData(Var Q:ViewAsciiApp;ClrEol:Boolean);Near;Forward;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Fonction GetBckFileTxtLn                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Portabilit‚: Local


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de lire une ligne ASCII en arriŠre (la pr‚c‚dante)
 plut“t que la prochaine afin de revenir en arriŠre...
}

Function GetBckFileTxtLn(Handle,P:Wd;PL:Long):String;Near;Label Break;Var Str:String;I:Byte;Chr:Char;Buf:PChrAByte;Begin
 GetBckFileTxtLn:='';Str:='';
 _GetAbsRec(Handle,PL,P,Buf);
 For I:=P-3downto 1do Begin
  Chr:=Buf[I-1];
  If Chr=#10Then Begin
   Chr:=Buf[I-2];
   If Chr=#13Then Goto Break;
   Str:=#10+Chr+Str
  End
   Else
  Str:=Chr+Str
 End;
Break:GetBckFileTxtLn:=Str
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure WaitRetrace2                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Portabilit‚: Local


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette routine fait simplement attendre 2 retour de balayage de l'‚cran.


  Remarque
  ÍÍÍÍÍÍÍÍ

   ş Elle est essentiellement utilis‚  afin d'‚conomiser  de la m‚moire et
     c'est la raison pour laquelle est a un statue local.
}

Procedure WaitRetrace2;Near;Begin
 WaitRetrace;WaitRetrace;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ·}
{³                    O b j e t  V i e w A s c i i             º}
{ÔÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼}

{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                           Proc‚dure VAPutTxt                          Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Propri‚taire: VA
  Portabilit‚:  Local


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette proc‚dure permet d'afficher  le contenu d'une chaŒne de caractŠres
  … la position courante du visualisateur de fichier ASCII en regard rapide
  en tenant compte du format de fichier de traitement de texte GAT.
}

Procedure VAPutTxt(Var Q:ViewAsciiApp;Str:String);Near;
Var
 I,X,XM,Y,GAttr:Byte;
 Chr:Char;
Begin
 _DelAllSpcRight(Str);
 If(Q.View=GAT)Then Begin
  I:=1;
  X:=WEGetRealX(Q.W);Y:=WEGetRealY(Q.W);
  XM:=X+Q.W.MaxX;
  While(Length(Str)>=I)do Begin
   If Str[I]<' 'Then Begin
    GAttr:=Byte(Str[I]);
    Inc(I);
    Chr:=Str[I]
   End
    Else
   Begin
    GAttr:=0;
    Chr:=Str[I]
   End;
   Inc(I);
   If(X>=XM)and(GAttr and $10=$10)Then Break;
   PutCharGAttr(X,Y,Chr,Q.W.CurrColor,GAttr);
   Inc(X);
   If GAttr and$10=$10Then Inc(X);
   If(X>XM)Then Break;
  End;
  Q.W.X:=X-WEGetRealX(Q.W)
 End
  Else
 WEPutTxt(Q.W,Str);
End;

{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                           Proc‚dure VADn                           Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Propri‚taire: VA
  Portabilit‚:  Globale


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette proc‚dure permet de passer … la lecture d'une liste du texte de
  ASCII  suivant  … l'‚cran  de l'objet  de visualisation  de fichier en
  regard rapide.
}

Procedure VADn{Var Q:VA};
Var
 Handle:Hdl;
 Str:String;
 MY,L:Byte;
 P:LongInt;
Begin
 MY:=Q.W.MaxY;
 If Q.FileSize<=Q.PBnk^[MY]Then Exit;
 Handle:=FileOpen(Q.FileName,fmRead);
 If(Handle<>errHdl)Then Begin
  MoveLeft(Q.PBnk^[1],Q.PBnk^,Q.SizeBnk-4);
  _WEScrollDn(Q.W);
  WESetPos(Q.W,0,MY);
{  L:=Length(GetAbsFileTxtLn(Handle,Q.PBnk^[MY-1]));
  If(L>Q.W.MaxX)Then L:=Q.W.MaxX+1 Else Inc(L,2);}
  P:=Q.PBnk^[MY-1];
  __GetAbsFileTxtLn(Handle,P,Str);
  L:=Length(Str);
  If L>Q.W.MaxX+1Then L:=Q.W.MaxX+1 Else L:=P-Q.PBnk^[MY-1];
  Q.PBnk^[MY]:=Q.PBnk^[MY-1]+L;P:=Q.PBnk^[MY];
  __GetAbsFileTxtLn(Handle,P,Str);
  VAPutTxt(Q,Str);
  WEClrEOL(Q.W);
  FileClose(Handle);
  VAPutData(Q)
 End
End;

{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                        Destructeur VADone                       Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Propri‚taire: VA
  Portabilit‚:  Globale


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Ce destructeur met fin … l'objet de visualisation de fichier ASCII
  en regard rapide.
}

Function VADone{Var Q):Word};Begin
 FreeMemory(ViewAsciiApp(Q).PBnk,ViewAsciiApp(Q).SizeBnk);
 WEDone(ViewAsciiApp(Q).W);
 VADone:=0;
End;

{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                       Proc‚dure VAInitFrame                      Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Propri‚taire: VA


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette proc‚dure permet d'initaliser la structure de base interne du
  visualisateur de fichier ASCII en regard rapide.
}

Procedure VAInitFrame(Var Q:ViewAsciiApp;Const FileName:String;X1,Y1,X2,Y2:Byte;Hlp,Raw:Boolean);
Var
 S:String;
Begin
 FillClr(Q,SizeOf(Q));
 Q.Raw:=Raw;
 If Not FileExist(FileName)Then Exit;
 If(Hlp)Then Q.View:=Isatex.Hlp Else
 If Path2Ext(FileName)='.GAT'Then Begin
  Q.View:=GAT;S[0]:=#255;
  GetFile(FileName,0,SizeOf(S)-1,S[1]);
  S[0]:=Char(Pos(#13,S));Q.Min:=Length(S)+2;Q.PBnk^[0]:=Q.Min;
 End
  Else
 Q.Min:=0;
 Q.FileSize:=GetFileSize(FileName);
 WEInit(Q.W,X1,Y1,X2,Y2);
 If(Raw)Then Begin
  Q.W.Palette.Border:=GetAttr(X1+1,Y1+1);
  Q.W.Palette.High:=Q.W.Palette.Border;
  Q.W.CurrColor:=Q.W.Palette.Border;
 End;
 Q.SizeBnk:=(Q.W.T.Y2-Q.W.T.Y1+2)shl 2;Q.PBnk:=MemNew(Q.SizeBnk);
 If(Q.PBnk=NIL)Then Exit;
 If(Q.View=GAT)Then Q.PBnk^[0]:=Q.Min;
 {$IFNDEF H}
  WEPushWn(Q.W);
 {$ENDIF}
 Q.FileName:=FileName;
End;

{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                        Proc‚dure VAGotoFilePos                     Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Propri‚taire: VA
  Portabilit‚:  Globale


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette proc‚dure permet d'envoyer le visualisateur de fichier ASCII en
  regarde rapide … une position absolue  … partir du d‚but du fichier en
  octets.
}

Procedure VAGotoFilePos{Var Q:VA;P:Long};Begin
 Q.PBnk^[0]:=P;
 VARefreshData(Q,True)
End;

{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                          Constructeur VAInit                         Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Propri‚taire: VA
  Portabilit‚:  Globale


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Ce constructeur permet d'initialiser une visualisateur de fichier ASCII
  rapide sur justement un fichier existant quelque part sur une des unit‚s
  logique disponible.
}

Function VAInit{Var Q:VA;X1,Y1,X2,Y2:Byte;Const FileName:String;Hlp:Bool):Bool};Begin
 VAInit:=False;
 VAInitFrame(Q,FileName,X1,Y1,X2,Y2,Hlp,False);
 VARefresh(Q);
 VAInit:=True
End;

Function VAInitRaw;Begin
 VAInitRaw:=False;
 VAInitFrame(Q,FileName,X1,Y1,X2,Y2,False,True);
 VARefresh(Q);
 VAInitRaw:=True
End;

Procedure VALoad{Var Q;X1,Y1,X2,Y2:Byte;Const Path:String};Begin
 VAInit(ViewAsciiApp(Q),X1,Y1,X2,Y2,Path,False);
End;

{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                        Constructeur VAInit4RLL                     Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Propri‚taire: VA
  Portabilit‚:  Globale


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Ce constructeur permet d'afficher le contenu ASCII d'un index contenu
  dans un fichier bibliothŠque de format ®RLL¯ … partir du visualisateur
  rapide.
}

Function VAInit4RLL{Var Q:VA;X1,Y1,X2,Y2:Byte;Const FileName:String;Index,IndexEnd:Wd):Bool};
Var
 XP:Array[0..1]of LongInt;
 Handle:Hdl;
 I:Word;
 Name:String;
Begin
 VAInit4RLL:=False;
 Name:=FSearch(FileName,MaltePath+';'+MaltePath+'HLP;'+MaltePath+'HELP;'+MaltePath+';\MALTE\HLP;');
 VAInitFrame(ViewAsciiApp(Q),Name,X1,Y1,X2,Y2,True,False);
 Handle:=FileOpen(Name,fmRead);
 If(Handle<>errHdl)Then Begin
  If Index=$FFFFThen Begin
   GetRec(Handle,0,SizeOf(XP[0]),XP[0]);
   If XP[0]=$1A324C52Then Begin
    XP[0]:=4;I:=1;
    While ViewAsciiApp(Q).FileSize<>XP[0]do Begin
     GetRec(Handle,I,SizeOf(XP[0]),XP[0]);
     If GetSysErr<>0Then Break;
     Inc(I);
    End;
    ViewAsciiApp(Q).Min:=I shl 2;
   End;
  End
   Else
  Begin
   _GetAbsRec(Handle,(Index+1)shl 2,SizeOf(XP),XP);
   ViewAsciiApp(Q).Min:=XP[0];
   If(IndexEnd<>Index)Then _GetAbsRec(Handle,(IndexEnd+1)shl 2,SizeOf(XP),XP);
   ViewAsciiApp(Q).FileSize:=XP[1]-1;
  End;
  FileClose(Handle);
  ViewAsciiApp(Q).PBnk^[0]:=ViewAsciiApp(Q).Min;
 End;
 VARefresh(Q);
 VAInit4RLL:=True
End;

{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                             Proc‚dure VAPgDn                          Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Propri‚taire: VA
  Portabilit‚:  Globale


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette proc‚dure permet de descendre … l'‚cran plus haut du fichier ASCII
  actuellement en visualisation.
}

Procedure VAPgDn{Var Q:VA};
Var
 MY:Byte;
Begin
 MY:=Q.W.MaxY;
 If Q.FileSize<=Q.PBnk^[MY]Then Exit;
 Q.PBnk^[0]:=Q.PBnk^[MY];
 VARefreshData(Q,True)
End;

{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                            Proc‚dure VAPgUp                          Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Propri‚taire: VA
  Portabilit‚:  Globale


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ


   Cette proc‚dure permet de remonter … l'‚cran plus haut du fichier ASCII
  actuellement en visualisation.
}

Procedure VAPgUp{Var Q:VA};
Var
 Handle:Hdl;
 P:Word;
 Str:String;
 PL:LongInt;
 J:Byte;
Begin
 If(Q.PBnk^[0]<=Q.Min)Then Exit;
 Handle:=FileOpen(Q.FileName,fmRead);
 If(Handle<>errHdl)Then Begin
  Q.PBnk^[Q.W.MaxY+1]:=Q.PBnk^[1];
  For J:=Q.W.MaxY downto 0do Begin
   WESetPos(Q.W,0,J);
{   If(Q.PBnk^[J+1]<=Q.Min)Then Begin Q.PBnk^[0]:=Q.Min;VARefresh(Q);Break;End
    Else
   Begin}
    P:=256;PL:=Q.PBnk^[J+1]-255;
    If PL<0Then Begin;P:=Q.PBnk^[J+1]+1;PL:=0;End;
    Str:=GetBckFileTxtLn(Handle,P,PL);
    VAPutTxt(Q,Str);
{   End;}
   WEClrEOL(Q.W);
   Q.PBnk^[J]:=Q.PBnk^[J+1]-Length(Str)-2;
   If(Q.PBnk^[J]<=Q.Min)Then Begin
    Q.PBnk^[0]:=Q.Min;
    VARefresh(Q);
    Break;
   End
  End;
  FileClose(Handle);
  VAPutData(Q)
 End
End;

{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                           Proc‚dure VAPutData                       Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Propri‚taire: VA


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette proc‚dure permet d'afficher l'indicateur de position actuel dans
  le regardeur  de fichiers ASCII  de l'objet d‚finit  par la variable de
  param‚trage ®Q¯.
}

Procedure VAPutData;
Var
 S,S2:String;
Begin
 If Not(Q.Raw)Then Begin
  S:=CStr(Q.PBnk^[0]);
  If(Q.PBnk^[Q.W.MaxY]>Q.FileSize)Then S2:='la Fin'
                                  Else S2:=CStr(Q.PBnk^[Q.W.MaxY]);
  S2:=StrUSpc(S2,13);
  WESetEndBarTxtX(Q.W,1,Spc(14-Length(S))+S+' … '+S2,CurrKrs.Desktop.DialStatus)
 End;
End;

{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                          Proc‚dure VARefresh                         Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Propri‚taire: VA
  Portabilit‚:  Globale


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette proc‚dure permet de restituer complŠtement la fenˆtre de dialogue
  de visualisation de fichier ASCII en regard rapide sans aucune ommission
  quelqu'elle soit.
}

Procedure VARefresh(Var Q);Begin
 If(ViewAsciiApp(Q).Raw)Then Begin
 End
  Else
 Begin
  If(ViewAsciiApp(Q).View=Hlp)Then WEPutWn(ViewAsciiApp(Q).W,'Aide',CurrKrs.Help.Window)
   Else
  Begin
   If(ViewAsciiApp(Q).View=GAT)Then WEPutWn(ViewAsciiApp(Q).W,'Regarde: '+ViewAsciiApp(Q).FileName,CurrKrs.Help.Window)
   Else WEPutWn(ViewAsciiApp(Q).W,'Regarde: '+ViewAsciiApp(Q).FileName,CurrKrs.ViewAscii.Window);
  End;
  WECloseIcon(ViewAsciiApp(Q).W);
  WEZoomIcon(ViewAsciiApp(Q).W);
  WESetEndBar(ViewAsciiApp(Q).W,CurrKrs.Desktop.DialStatus);
  WEPutBarMsRight(ViewAsciiApp(Q).W);
 End;
 VARefreshData(ViewAsciiApp(Q),False);
 If Not(ViewAsciiApp(Q).Raw)Then Begin
  If Not(ViewAsciiApp(Q).View=Hlp)Then Begin
   If(IsGrf)Then Begin
    BarSpcHorRelief(ViewAsciiApp(Q).W.T.X1,ViewAsciiApp(Q).W.T.Y2,ViewAsciiApp(Q).W.T.X1+32,CurrKrs.Desktop.DialStatus);
    BarSpcHorReliefExt(ViewAsciiApp(Q).W.T.X1+1,ViewAsciiApp(Q).W.T.Y2,ViewAsciiApp(Q).W.T.X1+31,CurrKrs.Desktop.DialStatus);
    BarSpcHorRelief(ViewAsciiApp(Q).W.T.X1+33,ViewAsciiApp(Q).W.T.Y2,ViewAsciiApp(Q).W.T.X2,CurrKrs.Desktop.DialStatus);
    BarSpcHorReliefExt(ViewAsciiApp(Q).W.T.X1+34,ViewAsciiApp(Q).W.T.Y2,ViewAsciiApp(Q).W.T.X2-2,CurrKrs.Desktop.DialStatus);
    LuxeBox(ViewAsciiApp(Q).W.T.X2-1,ViewAsciiApp(Q).W.T.Y2);
   End
    Else
   WESetEndBarTxtX(ViewAsciiApp(Q).W,32,'³',CurrKrs.Desktop.DialStatus);
   WESetEndBarTxtX(ViewAsciiApp(Q).W,34,'Taille'+CStrBasic(ViewAsciiApp(Q).FileSize)+' octet(s)',CurrKrs.Desktop.DialStatus)
  End;
 End;
End;

{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                           Proc‚dure VARefreshData                     Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Propri‚taire: VA


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette proc‚dure permet de restaurer sp‚cifiquement la partie des donn‚es
  actuellement visible dans la fenˆtre,  c'est-…-dire le contenu du fichier
  seulement sans tenir compte du reste de la fenˆtre et des indicateurs.
}

Procedure VARefreshData;
Var
 Handle:Hdl;
 L,J:Byte;
 Str:String;
 P:LongInt;
Begin
 WESetPosHome(Q.W);
 Handle:=FileOpen(Q.FileName,fmRead);
 If(Handle<>errHdl)Then Begin
  For J:=0to(Q.W.MaxY)do Begin
   P:=Q.PBnk^[J];
   __GetAbsFileTxtLn(Handle,P,Str);
   If Length(Str)>Q.W.MaxX+1Then L:=Q.W.MaxX+1
                            Else L:=P-Q.PBnk^[J]{Length(Str)+2};
   VAPutTxt(Q,Str);
   If(ClrEol)Then WEClrEol(Q.W);
   WELn(Q.W);
   Q.PBnk^[J+1]:=Q.PBnk^[J]+L
  End;
  FileClose(Handle);
  VAPutData(Q);
 End
End;

{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                        Proc‚dure VAReSize                       Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Propri‚taire: VA
  Portabilit‚:  Globale


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette proc‚dure permet de changer la taille d'une multi-fenˆtre de
  visualisation de fichier ASCII en regard rapide.


  Remarque
  ÍÍÍÍÍÍÍÍ

   ş Elle  s'applique  seulement  … la m‚thode ®H¯  de gestion multi-
     fenˆtre et abolument pas  aux autres  ancienne m‚thode demendant
     un  application  interne  pour  chaque objet  le restitution  de
     l'image...
}

Procedure VAReSize{Var Q:VA;X1,Y1,X2,Y2:Byte};
Var
 Old:LongInt;
 N:String;
Begin
 Old:=ViewAsciiApp(Q).PBnk^[0];
 N:=ViewAsciiApp(Q).FileName;
 VADone(Q);
 VAInitFrame(ViewAsciiApp(Q),N,X1,Y1,X2,Y2,ViewAsciiApp(Q).View=Isatex.Hlp,False);
 ViewAsciiApp(Q).PBnk^[0]:=Old;
 VARefresh(Q)
End;

Procedure VAMove2{Var QX;X,Y:Byte};
Var
 Q:ViewAsciiApp Absolute QX;
Begin
 VAReSize(Q,X,Y,X+Q.W.T.X2-Q.W.T.X1,Y+Q.W.T.Y2-Q.W.T.Y1);
End;

{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                            Proc‚dure VARun                          Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Propri‚taire: VA
  Portabilit‚:  Globale


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette fonction attend une r‚action de la part de l'utilisateur et agit
  en fonction de sa demande.  Si la demande ne concerne pas  l'objet,  la
  fonction retourne un code clavier correspondant  … la demande ayant ‚t‚
  faite.
}

Function VARun{Var Q):Wd};
Var
 K:Word;
Begin
 Repeat
  K:=WEReadk(ViewAsciiApp(Q).W);
  Case(K)of
   kbRBarMsUp:Begin
    WaitRetrace2;
    VAUp(ViewAsciiApp(Q))
   End;
   kbRBarMsDn:Begin
    WaitRetrace2;
    VADn(ViewAsciiApp(Q))
   End;
   kbRBarMsPgUp:Begin
    WaitRetrace2;
    VAPgUp(ViewAsciiApp(Q))
   End;
   kbRBarMsPgDn:Begin
    WaitRetrace2;
    VAPgDn(ViewAsciiApp(Q))
   End;
   kbDn:VADn(ViewAsciiApp(Q));
   kbPgDn:VAPgDn(ViewAsciiApp(Q));
   kbUp:VAUp(ViewAsciiApp(Q));
   kbPgUp:VAPgUp(ViewAsciiApp(Q))
   Else Begin
    VARun:=K;
    Break;
   End
  End
 Until False
End;

{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                          Proc‚dure VAUp                           Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Propri‚taire: VA


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette proc‚dure permet de retourner en arriŠre dans la lecture d'une
  liste du texte ASCII.
}

Procedure VAUp{Var Q:VA};
Var
 Handle:Hdl;
 L:Byte;
 P:Word;
 Str:String;
 PL:LongInt;
Begin
 If(Q.PBnk^[0]<=Q.Min)Then Exit;
 Handle:=FileOpen(Q.FileName,fmRead);
 If(Handle<>errHdl)Then Begin
  MoveRight(Q.PBnk^,Q.PBnk^[1],Q.SizeBnk-4);
  _WEScrollUp(Q.W);
  WESetPosHome(Q.W);
  P:=Q.W.MaxX+4;PL:=Q.PBnk^[1]-(P-1);
  If PL<0Then Begin;P:=Q.PBnk^[1]+1;PL:=0;End;
  Str:=GetBckFileTxtLn(Handle,P,PL);
  If(Length(Str)>=Q.W.MaxX)Then L:=Q.W.MaxX+1+4 Else L:=Length(Str);
  VAPutTxt(Q,Str);WEClrEOL(Q.W);
  Q.PBnk^[0]:=Q.PBnk^[1]-L-2;
  FileClose(Handle);
  If(Q.PBnk^[0]<Q.Min)Then Begin
   Q.PBnk^[0]:=Q.Min;
   VARefresh(Q)
  End
   Else
  VAPutData(Q)
 End;
End;

Function VATitle(Var Q;Max:Byte):String;
Const Name='Regarde ASCII ';
Begin
 If(ViewAsciiApp(Q).View=Hlp)Then VATitle:='Aide'
 Else VATitle:=Name+TruncName(ViewAsciiApp(Q).FileName,Max-Length(Name))
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Proc‚dure QHlp                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure d'obtenir de l'aide … partir d'un fichier ASCII ayant
 comme extension ®.HLP¯.
}

Procedure QHlp{Const FileName:String};
Var
 Name:String;
 V:ViewAsciiApp;
 {$IFDEF H}
  W:Window;
 {$ENDIF}
Begin
 If DirExist('\MALTE\HLP')Then Name:='\MALTE\HLP\'+Path2Name(FileName)+'.HLP'
 Else Name:=MaltePath+'HLP\'+Path2Name(FileName)+'.HLP';
 {$IFDEF H}
  WEInit(W,5,5,MaxXTxts-5,MaxYTxts-5);
  WEPushWn(W);
 {$ENDIF}
 VAInit(V,5,5,MaxXTxts-5,MaxYTxts-5,Name,True);
 Repeat Until VARun(V)=kbEsc;
 VADone(V);
 {$IFDEF H}
  WEDone(W)
 {$ENDIF}
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                             Proc‚dure QHlp4RLL                           Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'afficher l'aide associer … un fichier de ressource
 de format ®RLL¯.
}

Procedure QHlp4RLL{Const FileName:String;IndexStart,IndexEnd:Wd};
Var
 V:ViewAsciiApp;
 {$IFDEF H}
  W:Window;
 {$ENDIF}
Begin
 {$IFDEF H}
  WEInit(W,5,5,MaxXTxts-5,MaxYTxts-5);
  WEPushWn(W);
 {$ENDIF}
 VAInit4RLL(V,5,5,MaxXTxts-5,MaxYTxts-5,{SYSDrive+}FileName,IndexStart,IndexEnd);
 Repeat Until VARun(V)=kbEsc;
 VADone(V);
 {$IFDEF H}
  WEDone(W)
 {$ENDIF}
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
END.