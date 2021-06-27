{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                                                                         Û
 ³                  Malte Genesis/Gestionnaire de Police                   Û
 ³                                                                         Û
 ³            dition Chantal pour Mode R‚el/IV - Version 1.1              Û
 ³                              1998/06/30                                 Û
 ³                                                                         Û
 ³          Tous droits r‚serv‚s par les Chevaliers de Malte (C)           Û
 ³                                                                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Nom du programmeur
 ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

  Sylvain Maltais


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette unit‚ renferme toutes les routines de la gestion des polices de
 caractŠres vid‚o de format ®QQF¯.
}

{$I DEF.INC}

Unit FontMana;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                 INTERFACE
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses Systex,Isatex;

Function SelectFont(Var FT:ItemFont):Boolean;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                               IMPLEMENTATION
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses Dialex,Adele,Memories,Systems,Mouse,Video,Dials,DialPlus;

Type
 SelectFontRec=Record
  W,L,Image:Window;          { Fenˆtre de dialogue, derniŠre barre, zone image}
  IFR:ItemFont;
  R:ArrayList;
  LM:LstMnu;                 { Fenˆtre comprenant la liste des noms de police }
  Path:String;
  F:SearchRec;
  Handle:Hdl;
  FP:Long;
  P:^ItemFont;
  OldWinType:WinModelType;
  Kr:MtxColors;
  TP:Integer;
 End;

Procedure UpDatePolice(Var Context);
Var
 Q:SelectFontRec Absolute Context;
 Police:^TByte;
 WPolice:^TWord Absolute Police;
 I,J,XN,YN,XG,YG,B,SX,SY:Word;
Begin
 Q.P:=_ALGetBuf(Q.R,Q.LM.P);
 Q.Handle:=FileOpen(Q.P^.Path,fmRead);
 If(Q.Handle<>errHdl)Then Begin
  Police:=MemAlloc(Q.P^.Index.Size);
  _GetAbsRec(Q.Handle,Q.P^.Index.PosAbs,Q.P^.Index.Size,Police^);
  XN:=WPolice^[512 shr 1]shr 3;
  If WPolice^[512 shr 1]and 7<>0Then Inc(XN);
  YN:=WPolice^[(512+2) shr 1];B:=512+4;SX:=0;
  XG:=(WEGetRX1(Q.W)+1)shl 3;YG:=(WEGetRY1(Q.W)+10)*HeightChr;
  If(YN<Q.Image.MaxY*HeightChr)Then Begin
   SY:=(Q.Image.MaxY*HeightChr-YN)shr 1;
   PutFillBox(XG,YG,XG+((Q.W.MaxX-1)shl 3),YG+SY,White);
   Inc(YG,SY)
  End;
  If(XN>Q.Image.MaxX)Then XN:=Q.Image.MaxX
   Else
  Begin
   SX:=((Q.Image.MaxX-XN)shr 1)shl 3;
   PutFillBox(XG,YG,XG+SX-1,(WEGetRY1(Q.W)+17)*HeightChr-1,White);
   Inc(XG,SX)
  End;
  For J:=0to YN-1do Begin
   For I:=0to XN-1do Begin
    Copy8Bin(XG,YG,Police^[B],White,0);
    Inc(B);Inc(XG,8);
   End;
   If(XN<Q.Image.MaxX)Then PutLnHor(XG,YG,XG-SX-(XN shl 3)+((Q.W.MaxX-1)shl 3),15);
   Dec(XG,XN shl 3);
   Inc(YG)
  End;
  PutFillBox(XG,YG,XG-SX+((Q.W.MaxX-1)shl 3),(WEGetRY1(Q.W)+17)*HeightChr-1,15);
  FreeMemory(Police,Q.P^.Index.Size);
  FileClose(Q.Handle);
 End;
End;

Procedure FullScr(Var Context);
Label Restart;
Var
 Q:SelectFontRec Absolute Context;
 X:ImgRec;
 S:String;
 I:Byte;
 OldDialTimer:Boolean;
Begin
 OldDialTimer:=DialTimer;DialTimer:=False;
 PushScr(X);
 S[0]:=#255;
 For I:=1to 255do S[I]:=Chr(I);
Restart:
 ClrScrBlack;
 If LoadQQF(Q.P^.Index.Name)Then Begin
  OutTextXY(0,0,S,White);
  Case(ReadKey)of
   kbDn:If Q.LM.P<Q.LM.List.Count-1Then Begin
    Inc(Q.LM.P);
    Q.P:=_ALGetBuf(Q.R,Q.LM.P);
    Goto Restart;
   End;
  End;
 End
  Else
 If(QQF=NIL)Then __OutOfMemory
            Else ErrNoMsgOk(FontNotFound);
 PopScr(X);
 DialTimer:=OldDialTimer;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Fonction SelectFont                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction offre … l'utilisateur la possibilit‚ de s‚lectionner une
 police de caractŠre de format ®QQF¯.
}

Function SelectFont{Var FT:ItemFont):Boolean};
Var
 Q:SelectFontRec;
 K:Word;
Begin
 SelectFont:=False;
 If(IsGrf)Then Begin
  FillClr(Q,SizeOf(Q));
  WEInitO(Q.W,75,20);
  WEPushWn(Q.W);
  WEPutWnKrDials(Q.W,'Choisir une police de caractŠres');
  WECloseIcon(Q.W);
  WESubList(Q.W,0,0,wnMax-1,8,'Police',Q.LM);
  Q.LM.Context:=@Q;Q.LM.OnMove:=UpdatePolice;Q.LM.EnterOnDoubleClick:=True;
  WEPushEndBar(Q.L);
  WEPutLastBar('Analyse des polices de caractŠres en cours...');
  Q.Path:=WildCardSearch('*.QQF',MaltePath+'FONT;'+MaltePath+'FNT;'+MaltePath+';\MALTE\FONT;');
  If Q.Path=''Then Begin
   ErrNoMsgOk(NothingFontFound);
   WEDone(Q.L);
   WEDone(Q.W);
   Exit;
  End;
  ALInit(Q.R);
  FindFirst(Q.Path,fa,Q.F);
  While SysErr=0do Begin
   Q.IFR.Path:=Path2Dir(Q.Path)+Q.F.Name;
   Q.Handle:=FileOpen(Q.IFR.Path,fmRead);
   If(Q.Handle<>errHdl)Then Begin
    Q.FP:=4;
    _GetAbsRec(Q.Handle,Q.FP,SizeOf(FontIndexRecord),Q.IFR.Index);
    Repeat
     Q.P:=ALAdd(Q.R,SizeOf(Q.IFR));
     If(Q.P<>NIL)Then Begin
      MoveLeft(Q.IFR,Q.P^,SizeOf(Q.IFR));
      ALAddStr(Q.LM.List,Q.P^.Index.Name);
     End;
     Inc(Q.FP,SizeOf(FontIndexRecord));
     _GetAbsRec(Q.Handle,Q.FP,SizeOf(FontIndexRecord),Q.IFR.Index);
    Until Q.IFR.Index.Name='FIN';
    FileClose(Q.Handle)
   End;
   FindNext(Q.F);
  End;
  WEPutLastBar('^Enter^  S‚lectionner la police  ^Esc^ Annuler  ^Ctrl+F1^ Police en pleine ‚cran');
  Q.OldWinType:=WinType;WinType:=Normal;
  Q.Kr.Border:=$F0;
  WEInit(Q.Image,WEGetRX1(Q.W),WEGetRY1(Q.W)+9,WEGetRX1(Q.W)+Q.W.MaxX,WEGetRY1(Q.W)+Q.W.MaxY);
  WEPutWn(Q.Image,'',Q.Kr);
  WinType:=Q.OldWinType;
  Q.P:=_ALGetBuf(Q.R,0);
  LMRefresh(Q.LM);
  LMSelBar(Q.LM);
  UpDatePolice(Q);
  Repeat
   K:=LMRunKbd(Q.LM);
   Case(K)of
    kbMouse:If WEInCloseIcon(Q.W,LastMouseX,LastMouseY)Then Break;
    kbCtrlF1:FullScr(Q);
    kbEsc,kbClose:Break;
    Else If(K<Q.LM.List.Count)Then Begin
     FT:=Q.P^;
     SelectFont:=True;
     Break;
    End;
   End;
  Until No;
  ALDone(Q.R);
  LMDone(Q.LM);
  WEDone(Q.L);
  WEDone(Q.W);
 End
  Else
 ErrNoMsgOk(errGraphicModeRequired);
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
END.