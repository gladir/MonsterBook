{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                          Malte Genesis/Loader                           �
 �            릁ition Chantal pour Mode R괻l/IV - Version 1.1              �
 �                              1995/11/30                                 �
 �                                                                         �
 �          Tous droits r굎erv굎 par les Chevaliers de Malte (C)           �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Nom du programmeur
 袴袴袴袴袴袴袴袴袴

  Sylvain Maltais


 Description
 袴袴袴袴袴�

  Cette unit� permet d'ex괹uter un menu d'application dans une fen늯re de
 dialogue et de lancer le programme s굃ectionner par l'utilisateur.
}

Unit Loader;

{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�}
                                 INTERFACE
{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�}

{$I DEF.INC}
Uses
 Systex,Isatex;

Function  MAInit(Var Context;X1,Y1,X2,Y2:Byte):Boolean;
Function  MARun(Var Context):Word;
Function  MATitle(Var Context;Max:Byte):String;
Function  MADone(Var Context):Word;
Procedure RunMnu;

{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�}
                                IMPLEMENTATION
{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�}

Uses
 Memories,Systems,Dials,Adele,Video,Mouse,Editor,dialex;

Procedure MAPutDataHome(Var Q:LoaderMenuApp);Near;Forward;
Procedure MAkDn(Var Q:LoaderMenuApp);Near;Forward;
Procedure MAkUp(Var Q:LoaderMenuApp);Near;Forward;
Procedure MABackMnu(Var Q:LoaderMenuApp);Near;Forward;

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                          Proc괺ure MABar                          �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Propri굏aire: LoaderMnu
 Portabilit�:  Local


 Description
 袴袴袴袴袴�

  Cette proc괺ure permet d'afficher la barre de s굃ection du programme
 courant du menu d'application.
}

Procedure MABar(Var Q:LoaderMenuApp);Near;Begin
 Q.LastKr:=GetAttr(WEGetRX1(Q.W),WEGetRY1(Q.W)+Q.Ym);
 Q.W.CurrColor:=$1F;WEBarSelHor(Q.W,0,Q.Ym,wnMax)
End;

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴콘
 �                          Proc괺ure MABar                         �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複蔔


 Propri굏aire: LoaderMnu
 Portabilit�:  Local


 Description
 袴袴袴袴袴�

  Cette proc괺ure permet d'effacer la barre de s굃ection du programme
 courant du menu d'application.
}

Procedure MAUndo(Var Q:LoaderMenuApp);Near;Begin
 Q.W.CurrColor:=Q.LastKr;
 WEBarSelHor(Q.W,0,Q.Ym,wnMax)
End;

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴콘
 �                              Constructeur MAInit                         �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複蔔


 Propri굏aire: LoaderMnu
 Portabilit�:  Globale


 Description
 袴袴袴袴袴�

  Cette fonction permet de lancer l'ex괹ution du menu d'application et charge
 le fichier contenant le menu, c'est-�-dire 췓OADER.MNU�.
}

Function MAInit;
Label R;
Var
 P,FS:LongInt;
 Handle:Hdl;
 S,S1:String;
 Sub:Byte;
 Q:LoaderMenuApp Absolute Context;
Begin
 FillClr(Q,SizeOf(Q));
 MAInit:=False;
 Q.Path:=GetCurrentDir;
 Handle:=FileOpen('LOADER.MNU',fmRead);
 If(Handle=errHdl)Then Exit;
 FS:=FileSize(Handle);
 Sub:=0;P:=0;
 Repeat
R:_GetAbsFileTxtLn(Handle,P,S);
  Inc(P,LongInt(Length(S)+2));
  S:=LTrim(S);
  If S=''Then Goto R;
  If S='}'Then Dec(Sub)
   Else
  Begin
   _GetAbsFileTxtLn(Handle,P,S1);
   Inc(P,Long(Length(S1)+2));
   S1:=LTrim(S1);
   If S1='{'Then Begin
    ALAddStr(Q.LstMnu,Chr(Sub)+#3+S);
    Inc(Sub);
   End
    Else
   ALAddStr(Q.LstMnu,Chr(Sub)+#2+S+#1+S1);
  End;
 Until P>{=}FS;
 FileClose(Handle);
 Q.NameL:='';
 Q.ParamL:='';
 __InitMouse;
 WEInit(Q.W,X1,Y1,X2,Y2);
 {$IFNDEF H}
  WEPushWn(Q.W);
 {$ENDIF}
 WEPutWn(Q.W,'Menu Principal',CurrKrs.MalteDos.Window);
 WECloseIcon(Q.W);
 WEPutBarMsRight(Q.W);
 WESetEndBar(Q.W,$F0);
 WESetEndBarTxtX(Q.W,3,GetCurrentDir,$F0);
 PutMemory;
 MABar(Q);
 MAPutDataHome(Q);
 MAInit:=Ya;
End;

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴콘
 �                            Destructeur MADone                          �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複蔔


 Propri굏aire: LoaderMnu
 Portabilit�:  Globale


 Description
 袴袴袴袴袴�

  Cette proc괺ure met fin � la fen늯re de dialogue de menu d'application et
 lib둹e ainsi toutes les ressources solicit�.
}

Function MADone;Begin
 ALDone(LoaderMenuApp(Context).LstMnu);
 ChDir(LoaderMenuApp(Context).Path);
 MADone:=0;
End;

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                          Proc괺ure MAPutDataHome                      �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Propri굏aire: LoaderMnu
 Portabilit�:  Local


 Description
 袴袴袴袴袴�

  Cette proc괺ure l'affichage du menu d'application en partant du d괷ut la
 liste.
}

Procedure MAPutDataHome;
Var
 J:Byte;
 PC,Msg:PChr;
Begin
 WESetPosHome(Q.W);
 J:=Q.Pm;
 Repeat
  PC:=_ALGetBuf(Q.LstMnu,J);
  If(PC=NIL)Then Break;
  If Q.Level>0Then Begin
   If(Byte(PC^[0])<Q.Level)Then Break;
  End;
  If Q.Level=Byte(PC^[0])Then Begin
   If PC^[1]=#3Then WESetKrBorderF(Q.W,$E)
               Else WESetKrBorderF(Q.W,$B);
   Msg:=@PC^[2];
   If PC^[1]=#3Then WEPutPTxt(Q.W,Msg)
   Else WEPutPTxtXYAtChr(Q.W,0,Q.W.Y,#1,Msg);
   WEClrEol(Q.W);
   WELn(Q.W);
  End;
  If(Q.W.Y>Q.W.MaxY)Then Break;
  Inc(J);
 Until J>Q.LstMnu.Count-1;
 WEClrWnBorder(Q.W,0,Q.W.Y,wnMax,wnMax);
 MABar(Q);
End;

Procedure MAkDn;
Var
 J:Word;
 PC:PChr;
Begin
 If Q.Pm<Q.LstMnu.Count-1Then For J:=Q.Pm+1to Q.LstMnu.Count-1do Begin
  PC:=_ALGetBuf(Q.LstMnu,J);
  If(PC=NIL)Then Exit;
  If Q.Level>0Then Begin
   If(Byte(PC^[0])<Q.Level)Then Break;
  End;
  If Q.Level=Byte(PC^[0])Then Begin
   MAUndo(Q);
   If(Q.Ym>=Q.W.MaxY)Then Begin
   End
    Else
   Inc(Q.Ym);
   MABar(Q);
   Q.Pm:=J;
   Break;
  End;
 End;
End;

Procedure MAkUp;
Var
 J:Word;
 PC:PChr;
Begin
 If Q.Pm>0Then
  For J:=Q.Pm-1downto 0do Begin
  PC:=_ALGetBuf(Q.LstMnu,J);
  If(PC=NIL)Then Exit;
  If Q.Level>0Then Begin
   If(Byte(PC^[0])<Q.Level)Then Break;
  End;
  If Q.Level=Byte(PC^[0])Then Begin
   MAUndo(Q);
   If Q.Ym>0Then Dec(Q.Ym);
   MABar(Q);
   Q.Pm:=J;
   Break;
  End;
 End;
End;

Procedure MABackMnu;
Var
 J:Word;
 PC:PChr;
Begin
 If Q.Level>0Then Begin
  For J:=Q.Pm downto 0do Begin
   PC:=_ALGetBuf(Q.LstMnu,J);
   If(PC=NIL)Then Exit;
   If(Byte(PC^[0])<Q.Level)Then Begin
    Q.Pm:=J;
    Dec(Q.Level);
    Q.Ym:=0;
    For J:=Q.Pm downto 0do Begin
     PC:=_ALGetBuf(Q.LstMnu,J);
     If(PC=NIL)Then Break;
     If(Byte(PC^[0])<Q.Level)Then Begin
      Inc(J);
      Break;
     End;
    End;
    Q.Pm:=J;
    MAPutDataHome(Q);
    Break;
   End;
  End;
 End;
End;

Function MARun;
Var
 K:Word;
 Ok:Boolean;
 PC:PChr;
 S:String;
 Q:LoaderMenuApp Absolute Context;
Begin
 Ok:=No;
 Repeat
  K:=WEReadk(Q.W);
  Case K of
kbClose,kbEsc:Begin
   Ok:=True;
   K:=kbEsc;
  End;
kbRBarMsDn,kbDn:Begin
   MAkDn(Q);
   DelayMousePress(100);
  End;
kbRBarMsUp,kbUp:Begin
   MAkUp(Q);
   DelayMousePress(100);
  End;
  kbBS:MABackMnu(Q);
  kbEnter:Begin
   PC:=_ALGetBuf(Q.LstMnu,Q.Pm);
   If(PC<>NIL)Then Begin
    If PC^[1]=#3Then Begin
     Inc(Q.Level);
     Inc(Q.Pm);
     Q.Ym:=0;
     MAPutDataHome(Q);
    End
     Else
    Begin
     Ok:=True;
     If PC^[0]=#0Then S:=#0+StrPas(@PC^[1])
                 Else S:=StrPas(PC);
     For K:=2to Length(S)do Begin
      If S[K]=#1Then Begin
       S:=Copy(S,K+1,255);
       Break;
      End;
     End;
     Q.NameL:=S;
     For K:=1to Length(S)do Begin
      If S[K]=' 'Then Begin
       Q.NameL:=Left(S,K-1);
       Q.ParamL:=Copy(S,K+1,255);
       Break;
      End;
     End;
     K:=Pos('$CHPATH',Q.ParamL);
     If K>0Then Begin
      Q.ParamL:=DelStr(Q.ParamL,K,Length('$CHPATH'));
      S:=Path2Dir(Q.NameL);
      ChDir(S);
     End;
    End;
   End;
   K:=kbEnter;
  End;
  Else
  Ok:=Ya;
  End;
 Until Ok;
 MARun:=K;
End;

Function MATitle(Var Context;Max:Byte):String;Begin
 MATitle:='Menu';
End;

Procedure RunMnu;
Var
 Mnu:LoaderMenuApp;
 M:ImgRec;
Begin
 MAInit(Mnu,5,5,MaxXTxts-5,MaxYTxts-5);
 Repeat
  Mnu.Ym:=0;
  Mnu.Level:=0;
  Mnu.Pm:=0;
  If(MARun(Mnu)=kbEsc)Then Break;
  DialTimer:=No;
  PushScr(M);
  ClrScrBlack;
  SimpleCur;
  {$IFNDEF DPMI}FreeMaxHeap;{$ENDIF}
  Exec(Mnu.NameL,Mnu.ParamL);
  {$IFNDEF DPMI}MaxExpandHeap;{$ENDIF}
  SetBlink(No);
  CloseCur;
  PopScr(M);
  DialTimer:=True;
 Until False;
 MADone(Mnu);
End;

{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�}
END.