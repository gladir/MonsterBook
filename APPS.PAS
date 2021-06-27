{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³                                                                       ³²²
 ³                  Malte Genesis/Module d'Application                   ³²²
 ³                                                                       ³²²
 ³       dition Chantal & AdŠle pour Mode R‚el/IV - Version 1.0         ³²²
 ³     Tous droits r‚serv‚s XXIe siŠcle par les Chevaliers de Malte      ³²²
 ³                                                                       ³²²
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ²²
  ²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²


 Nom du programmeur
 ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

  Sylvain Maltais

 Description
 ÍÍÍÍÍÍÍÍÍÍÍ


  Cette unit‚ offre les services de gestion des applications interne … cette
 application,  c'est-…-dire … offrir  les services d'une gestion de fenˆtres
 de format MDI.
}

{$I DEF.INC}

Unit Apps;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                 INTERFACE
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses Isatex;

Procedure HInit(Var Q:HWins);
Procedure HAddNewModel(Var Q:HWins;Const X:HWin);
Function  HClose(Var Q:HWins):Boolean;
Function  HFastClose(Var Q:HWins;Num:Word):Boolean;
Procedure HGotoWin(Var Q:HWins);
Procedure HGotoNum(Var Q:HWins;Num:Word);
Procedure HInTaskBar(Var Q:HWins);
Function  HLastModel(Var Q:HWins):Byte;
Function  HLoad(Var Q:HWins;SerialNumber:Byte;Const Path:String):Boolean;
Function  HModel(Var Q:HWins):Byte;
Function  HNew(Var Q:HWins;SerialNumber:Byte):Boolean;
Function  HNewManual(Var Q:HWins;SerialNumber:Byte;Var X1,Y1,X2,Y2:Byte):Pointer;
Procedure HNext(Var Q:HWins);
Procedure HPrevious(Var Q:HWins);
Function  HPtr(Var Q:HWins):Pointer;
Procedure HRefresh(Var Q:HWins);
Procedure HRefreshBackground(Var Q:HWins);
Procedure HRefreshOtherWindows(Var Q:HWins);
Procedure HReSize(Var Q:HWins;X1,Y1,X2,Y2:Byte);
Function  HRun(Var Q:HWins):Word;
Procedure HSave(Var Q:HWins);
Procedure HSaveAs(Var Q:HWins);
Procedure HSaveAll(Var Q:HWins);
Function  HTitle(Var Q:HWins;Max:Byte):String;
Function  HTitleInLst(Var Q:HWins;Max:Byte;Index:Word):String;
Procedure HDone(Var Q:HWins);
Procedure _HGotoNum(Var Q:HWins;Num:Word;Refresh:Boolean);

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                               IMPLEMENTATION
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses Adele,Video,Systex,Dialex,Memories,Systems,Dials,Sound,Mouse,ResServI;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ·}
{³   O b j e t  G e s t i o n n a i r e  m ‚ t h o d e  ® H ¯  º}
{ÔÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼}

               { * * * * * * * Priv‚ * * * * * * *  }

{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                     Function HGetNextWnPos                   Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Propri‚taire: HWins


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette fonction pr‚pare une fenˆtre d'une taille al‚atoire en la
  calculant de fa‡on superpos‚e sur les autres fenˆtres.
}

Function HGetNextWnPos(Var Q:HWins;Var X1,Y1,X2,Y2:Byte;Model:Byte):Pointer;Near;
Var
 Ptr:^InternalModel;
 NewHWin:Pointer;
 Old:Boolean;
Begin
 If MaxYTxts-Q.YEditor>14Then Inc(Q.YEditor)
                         Else Q.YEditor:=1+LnsMnu+Q.HomeYEditor;
 If Q.YEditor>=2Then X1:=Q.YEditor-2
                Else X1:=0;
 Y1:=Q.YEditor;X2:=MaxXTxts;Y2:=MaxYTxts-2;
 ALSetPtr(Q.X,0);
 While(HWin(_ALGetCurrBuf(Q.X)^).SerialNumber<>Model)do ALNext(Q.X);
 NewHWin:=_ALGetCurrBuf(Q.X);
 Ptr:=ALAdd(Q.Lst,HWin(NewHWin^).SizeOfQ+SizeOf(Byte)+SizeOf(Byte)*5+SizeOf(Window));
 If(Ptr<>NIL)Then Begin
  Old:=GetShade;
  SetShade(False);
  WEInit(Ptr^.X.W,X1,Y1,X2,Y2);
  SetShade(Old);
  Ptr^.Model:=Model;
  Q.Curr:=Q.Lst.Count-1;
  Ptr^.InTaskBar:=False;
  Q.CurrHWin:=NewHWin;
 End;
 HGetNextWnPos:=Ptr
End;

{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                     Function HGetNextWnMin                    Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Propri‚taire: HWins


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette fonction pr‚pare une fenˆtre d'une taille pr‚d‚finie en la
  calculant de fa‡on superpos‚e sur les autres fenˆtres.
}

Function HGetNextWnMin(Var Q:HWins;L,H:Byte;Var X,Y:Byte;Model:Byte):Pointer;Near;
Var
 X1,Y1,X2,Y2:Byte;
 Ptr:^InternalModel;
 Old:Boolean;
Begin
 Ptr:=HGetNextWnPos(Q,X1,Y1,X2,Y2,Model);
 If(Ptr<>NIL)Then Begin
  If(X2-X1<L)Then X:=MaxXTxts-L Else X:=X1;
  If(Y2-Y1<H)Then Y:=MaxYTxts-H-2 Else Y:=Y1;
  Old:=GetShade;
  SetShade(False);
  WEInit(Ptr^.X.W,X,Y,X+L,Y+H);
  SetShade(Old);
 End;
 HGetNextWnMin:=Ptr;
End;

{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                        Proc‚dure FillBoxInPln                        Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de fixer une zone d'exclusion … l'int‚rieur d'une
 r‚gion logique imaginaire.
}

Procedure FillBoxInPln(X1,Y1,X2,Y2:Byte;Var Pln:Array of Boolean);Near;
Var
 B:Word;
 L,I:Byte;
Begin
 B:=Y1*NmXTxts+X1;L:=X2-X1+1;
 For I:=Y1 to(Y2)do Begin
  FillChr(Pln[B],L,Byte(True));
  Inc(B,NmXTxts)
 End;
End;

{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                         Proc‚dure HRefreshOtherWindows                Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Propri‚taire: HWins
  Portabilit‚:  Global


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de r‚actualiser l'affichage de toutes les fenˆtres
 … l'acception de la fenˆtre courante.


 Remarque
 ÍÍÍÍÍÍÍÍ

  ş La taille de la toile … trou  ®SizePln¯  doit obligatoirement avoir une
    ligne de plus que le  nombre de ligne de texte parcequ'en mode  800x600
    pixels,  le nombre de ligne avec des caractŠres en  16 pixels  de haut,
    n'arrive  pas juste  et donc  il y  a un  risque de  corruption m‚moire
    sinon dans ce mode vid‚o!
}

Procedure HRefreshOtherWindows(Var Q:HWins);
Label Free;
Var
 Windows:HWins;
 I,J,SizePln:Word;
 K:Word;
 T:TextBoxRec;
Begin
 Windows:=Q;
 If Q.Lst.Count>1Then Begin { Au moins deux fenˆtres? }
  SizePln:=NmXTxts*Succ(NmYTxts);
  Hole:=MemNew(SizePln);
  If(Hole<>NIL)Then Begin
   HoleMode:=True;
   FillBoxInPln(0,0,MaxXTxts,LnsMnu+Windows.HomeYEditor,Hole^);
   Windows.CurrModel:=_ALGetBuf(Windows.Lst,Windows.Curr);
   T:=Windows.CurrModel^.X.W.T;
   If Not(Windows.CurrModel^.InTaskBar)Then FillBoxInPln(T.X1,T.Y1,T.X2,T.Y2,Hole^);
   {If(IsGrf)and(BitsPerPixel>=8)Then} Begin
    J:=Windows.Curr;
    For I:=0to Windows.Lst.Count-1do Begin
     If(Windows.VisualLst=NIL)Then Windows.CurrModel:=_ALGetBuf(Windows.Lst,J)
      Else
     Begin
      If I+1>Windows.SizeVisualLst shr 1Then Goto Free;
      J:=Windows.VisualLst^[I+1];
      Windows.CurrModel:=_ALGetBuf(Windows.Lst,J);
     End;
     If(J<>Windows.Curr)and Not(Windows.CurrModel^.InTaskBar)Then Begin
      T:=Windows.CurrModel^.X.W.T;
       { Recherche le modŠle }
      ALSetPtr(Windows.X,0);
      K:=0;
      While(HWin(_ALGetCurrBuf(Windows.X)^).SerialNumber<>Windows.CurrModel^.Model)do Begin
       ALNext(Windows.X);
       Inc(K);
       If(K>Windows.X.Count)Then Break;
      End;
      Windows.CurrHWin:=_ALGetCurrBuf(Windows.X);
      If(@Windows.CurrHWin^.Refresh<>NIL)Then
       Windows.CurrHWin^.Refresh(Windows.CurrModel^.X.Data);
      FillBoxInPln(T.X1,T.Y1,T.X2,T.Y2,Hole^);
     End;
     If J=0Then J:=Windows.Lst.Count-1
           Else Dec(J);
    End;
   End;
Free:
   FreeMemory(Hole,SizePln);
   Hole:=NIL;
   HoleMode:=False;
  End;
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Proc‚dure HRefreshBackground                   Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: HWins


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de r‚actualiser la toile de fond sans toucher au
 fenˆtre s'il y en a.  Elle utilise la m‚thode  ®H¯,  elle n'est donc pas
 disosiable de ce m‚canisme.


 Remarque
 ÍÍÍÍÍÍÍÍ

  ş La taille de la toile … trou ®SizePln¯ doit obligatoirement avoir une
    ligne de plus que le nombre de ligne de texte parcequ'en mode 800x600
    pixels,  le nombre de ligne avec des caractŠres en 16 pixels de haut,
    n'arrive  pas juste  et donc  il y a un risque de  corruption m‚moire
    sinon dans ce mode vid‚o!
}

Procedure HRefreshBackground{Var Q:HWins};
Var
 SizePln,LW,AW,CW,CW2:Word;
 I,J,IE:Integer;
 W:Window;
 PtrW:Pointer;

 {$IFNDEF __Windows__}
  Procedure PutTapisDirect;
  Var
   I,J,K,JD,ID,Y1M,Y2M:Byte;
   JDC,JDC1:Word;
   T:Array[0..1,0..1]of TextCube;
   Attr:Byte;
   Base:Word;
  Begin
   Attr:=CurrKrs.Desktop.Tapiserie;
   If Not(FontFound)or Not(IsLuxe)Then Attr:=$80;
   If(IsMono)Then Attr:=$7F;
   FillChr(T,SizeOf(T),Attr);
   If(FontFound)and(IsLuxe)Then Begin
    T[0][0].Chr:=#29;
    T[0][1].Chr:=#30;
    T[1][0].Chr:=#30;
    T[1][1].Chr:=#29;
   End
    Else
   Begin
    T[0][0].Chr:=' ';
    T[0][1].Chr:=' ';
    T[1][0].Chr:=' ';
    T[1][1].Chr:=' '
   End;
   Y1M:=0;Y2M:=MaxYTxts shr 1;
   Base:=NmXTxts shl 1;
   JDC:=Y1M*Base;
   For J:=Y1M to(Y2M)do Begin
    JDC1:=JDC+NmXTxts;
    For K:=0to 1do For I:=0to(MaxXTxts)shr 1do Begin
     ID:=I shl 1;
     If Not Hole^[ID+JDC+K]Then Move(T[K],Mem[GetVideoSeg:(ID+JDC+K)shl 1],SizeOf(T[0])shr 1);
     If(J shl 1)+1<=MaxYTxts-2Then If Not Hole^[ID+JDC1+K]Then
      Move(T[(K+1)and 1],Mem[GetVideoSeg:(ID+JDC1+K)shl 1],SizeOf(T[1])shr 1);
    End;
    Inc(JDC,Base);
   End;
   If MainMenu.Mnu.Count<>0Then Begin
    If Not Hole^[NmXTxts*(MaxYTxts-Byte(HelpBar)-1)]Then BarSelHor(0,MaxYTxts-Byte(HelpBar),MaxXTxts,GetAttr(0,LnsMnu));
   End;
  End;
 {$ENDIF}

Begin
 SizePln:=NmXTxts*Succ(NmYTxts);
 Hole:=MemNew(SizePln);IE:=Q.Curr;
 {$IFDEF __Windows__}
  RIPutImageJuxtap(FontApp,0,GetRawY(2),NmXPixels,NmYPixels-16-1-GetRawY(1));
 {$ELSE}
  If(Hole=NIL)Then Exit;
  HoleMode:=True;
  If(ViewAppTitle)Then FillChr(Hole^,NmXTxts,Byte(True));
  If MainMenu.Mnu.Count=0Then FillChr(Hole^[NmXTxts*(1+LnsMnu)],NmXTxts*Q.HomeYEditor,Byte(True))
                         Else FillBoxInPln(0,0,MaxXTxts,Q.HomeYEditor+LnsMnu,Hole^);
  FillChr(Hole^[NmXTxts*Pred(NmYTxts)],NmXTxts,Byte(True));
  If Q.Lst.Count>0Then Repeat
   PtrW:=@Q.CurrModel^.X.W;
   MoveLeft(PtrW^,W,SizeOf(Window));
   AW:=(W.T.Y1)*NmXTxts+W.T.X1;
   LW:=W.T.X2-W.T.X1+1;
   If Not(Q.CurrModel^.InTaskBar)Then FillBoxInPln(W.T.X1,W.T.Y1,W.T.X2,W.T.Y2,Hole^);
   If IE>0Then Dec(IE)
          Else IE:=Q.Lst.Count-1;
   Q.CurrModel:=_ALGetBuf(Q.Lst,IE);
   W:=Q.CurrModel^.X.W;
   If(W.Buffer<>NIL)Then Begin
    LW:=W.T.X2-W.T.X1+1;
    If W.T.X2=MaxXTxts-1Then Inc(LW)Else
    If(W.T.X2<MaxXTxts)Then Inc(LW,2);
    CW:=W.T.Y1*NmXTxts+W.T.X1;
    CW2:=(CW+(NmXTxts shl 1))shl 1;
    AW:=0;
    For J:=0to(W.T.Y2-W.T.Y1)do Begin
     For I:=0to(W.T.X2-W.T.X1)do If Not Hole^[CW+I]Then MemW[GetVideoSeg:I shl 1+CW2]:=Word(PTTxtCube(W.Buffer)^[AW+I]);
     Inc(CW,NmXTxts);
     Inc(CW2,BytesPerLn);
     Inc(AW,LW);
    End;
   End;
  Until IE=Q.Curr;
  If(IsGrf)Then RIPutImageJuxtap(FontApp,0,0,NmXPixels,GetRawY(MaxYTxts-Byte(HelpBar))-1,WallPaperCfg)
           Else PutTapisDirect;
 {$ENDIF}
 If(Pointer(@Q.OnRefreshBackground)<>NIL)Then Q.OnRefreshBackground;
 Q.CurrModel:=_ALGetBuf(Q.Lst,Q.Curr);
 HoleMode:=False;
 _FreeMemory(Pointer(Hole),SizePln)
End;

Procedure HDelFirst(Var Q:HWins;Position:Word);Near;
Var
 Tmp:^TWord;
 TmpSize:Word;
 I:Integer;
Begin
 If(Q.SizeVisualLst>0)and(Q.VisualLst<>NIL)Then Begin
  If Q.SizeVisualLst<=SizeOf(Word)Then _FreeMemory(Pointer(Q.VisualLst),Q.SizeVisualLst)
   Else
  Begin
   Pointer(Tmp):=Pointer(Q.VisualLst);
   TmpSize:=Q.SizeVisualLst;
   Dec(Q.SizeVisualLst,SizeOf(Word));
   Q.VisualLst:=MemAlloc(Q.SizeVisualLst);
   If(Q.VisualLst=NIL)Then Q.SizeVisualLst:=0
    Else
   Begin
    MoveLeft(Tmp^[1],Q.VisualLst^,Q.SizeVisualLst);
    For I:=0to Q.Lst.Count-1do If(Q.VisualLst^[I]>Position)Then Dec(Q.VisualLst^[I]);
   End;
   FreeMemory(Tmp,TmpSize);
  End;
 End;
End;

Procedure HInsFirst(Var Q:HWins;Position:Word);Near;
Var
 Tmp:^TWord;
 TmpSize:Word;
Begin
 If(Q.SizeVisualLst=0)or(Q.VisualLst=NIL)Then Begin
  Q.SizeVisualLst:=SizeOf(Word);
  Q.VisualLst:=MemAlloc(SizeOf(Word));
  If(Q.VisualLst<>NIL)Then Q.VisualLst^[0]:=Position;
 End
  Else
 Begin
  Pointer(Tmp):=Pointer(Q.VisualLst);
  TmpSize:=Q.SizeVisualLst;
  Inc(Q.SizeVisualLst,SizeOf(Word));
  Q.VisualLst:=MemAlloc(Q.SizeVisualLst);
  If(Q.VisualLst=NIL)Then Q.SizeVisualLst:=0
   Else
  Begin
   MoveLeft(Tmp^,Q.VisualLst^[1],TmpSize);
   Q.VisualLst^[0]:=Position;
  End;
  FreeMemory(Tmp,TmpSize);
 End;
End;

Procedure HMoveFirst(Var Q:HWins;Position:Word);Near;
Var
 I,J,P,M:Integer;
Begin
 If Not(Q.SizeVisualLst=0)or(Q.VisualLst=NIL)Then Begin
  P:=-1;M:=Q.Lst.Count-1;
  For I:=0to(M)do If(Q.VisualLst^[I]=Position)Then Begin
   P:=I;
   Break;
  End;
  If(P<>I)or(P=0)Then Exit;
  For I:=P-1downto 0do Q.VisualLst^[I+1]:=Q.VisualLst^[I];
  Q.VisualLst^[0]:=Position;
 End;
End;

Procedure HFindCurr(Var Q:HWins);Near;Begin
 Q.CurrModel:=_ALGetBuf(Q.Lst,Q.Curr);
 If(Q.CurrModel<>NIL)Then Begin
  ALSetPtr(Q.X,0);
  While(HWin(_ALGetCurrBuf(Q.X)^).SerialNumber<>Q.CurrModel^.Model)do Begin
   ALNext(Q.X);
   If(_ALGetCurrBuf(Q.X)=NIL)Then Exit;
  End;
  Q.CurrHWin:=_ALGetCurrBuf(Q.X);
  If Not(Q.CurrModel^.InTaskBar)Then Begin
   If(Q.CurrHWin<>NIL)and(@Q.CurrHWin^.Refresh<>NIL)Then
    Q.CurrHWin^.Refresh(Q.CurrModel^.X.Data);
   HMoveFirst(Q,Q.Curr);
  End;
 End
  Else
 Q.CurrHWin:=NIL;
End;

Procedure HInActifCurr(Var Q:HWins);Near;Begin
 HFindCurr(Q);
 If(Q.CurrModel<>NIL)and(Q.CurrHWin<>NIL)and(Not Q.CurrModel^.InTaskBar)Then Begin
  HoleMode:=True;
  If(@Q.CurrHWin^.OnDeactivate<>NIL)Then Begin
   Q.CurrHWin^.OnDeactivate(Q.CurrModel^.X.Data);
  End
   Else
  _WESetTitle(Q.CurrModel^.X.W,Q.CurrModel^.X.W.Title);
  HoleMode:=False;
 End;
End;

               { * * * * * * * Public * * * * * * *  }

{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                           Proc‚dure HInit                        Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Propri‚taire: HWins


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette proc‚dure initialise le m‚canisme de gestion de multi-fenˆtre
  de m‚thode ®H¯.
}

Procedure HInit{Var Q:HWins};Begin
 FillClr(Q,SizeOf(Q));
 Q.YEditor:=$FF;
End;

{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                           Proc‚dure HAddNewModel                      Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Propri‚taire: HWins


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette proc‚dure permet d'ajouter un nouveau modŠle de fenˆtre accessible
  via le gestionnaire multi-fenˆtre de m‚thode ®H¯.
}

Procedure HAddNewModel{Var Q:HWins;Const X:HWin};
Var
 Ptr:Pointer;
Begin
 Ptr:=ALAdd(Q.X,SizeOf(X));
 If(Ptr=NIL)Then Exit;
 MoveLeft(X,Ptr^,SizeOf(X))
End;

Function HFastClose(Var Q:HWins;Num:Word):Boolean;Begin
 HFastClose:=False;
 If(Num<>Q.Curr)Then _HGotoNum(Q,Num,False);
 Q.CurrModel:=_ALGetBuf(Q.Lst,Num);
 If(@Q.CurrHWin^.Done<>NIL)Then Begin
  If Q.CurrHWin^.Done(Q.CurrModel^.X.Data)<>0Then Exit;
 End;
 WEFreeAll(Q.CurrModel^.X.W);
 ALDelBuf(Q.Lst,Num);
 HDelFirst(Q,Num);
 HFastClose:=True;
End;

{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                               Fonction HClose                            Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Propri‚taire: HWins


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette proc‚dure permet de fermer la fenˆtre courante active du gestionnaire
  multi-fenˆtre de m‚thode ®H¯.
}

Function HClose{Var Q:HWins):Boolean};Begin
 _LoadWave(StrPas(SoundPlay[sndCloseWin]));
 _PlayWave;
 HClose:=False;
 If Not HFastClose(Q,Q.Curr)Then Exit;
 If(Q.VisualLst<>NIL)and(Q.VisualLst^[0]<Q.Lst.Count)Then _HGotoNum(Q,Q.VisualLst^[0],False)
  Else
 Begin
  HFindCurr(Q);
  HPrevious(Q)
 End;
 If Q.Curr<=0Then Q.YEditor:=LnsMnu+Q.HomeYEditor;
 HRefreshBackground(Q);
 HRefreshOtherWindows(Q);
 HRefresh(Q);
 HClose:=True
End;

{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                           Fonction HGotoWin                          Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Propri‚taire: HWins


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette proc‚dure offre comme moyen … l'utilisateur de choisir la fenˆtre
  … activ‚ dans le gestionnaire de multi-fenˆtre de m‚thode ®H¯.
}

Procedure HGotoWin{Var Q:HWins};
Var
 List:LstMnu;
 K:Word;
 I:LongInt;
Begin
 If Q.Lst.Count=0Then Begin
  ErrNoMsgOk(ErrNoWindowOpen);
  Exit;
 End;
 LMInitKrDials(List,10,4,wnMax-10,wnMax-4,'Liste des fenˆtres ouvertes');
 For I:=0to Q.Lst.Count-1do ALAddStrByte(List.List,HTitleInLst(Q,MaxXTxts-20,I),I+1);
 K:=LMRun(List);
 LMDone(List);
 If(Q.Lst.Count>0)and(K>0)Then HGotoNum(Q,K-1)
  Else
 Begin
  Q.CurrModel:=_ALGetBuf(Q.Lst,Q.Curr);
  HMoveFirst(Q,Q.Curr);
 End;
End;

Procedure _HGotoNum(Var Q:HWins;Num:Word;Refresh:Boolean);
Var
 Ptr:Pointer;
Begin
 If Q.Lst.Count>0Then Begin
  If(Q.Lst.Count>1)and(Refresh)and(Q.Curr<>Num)Then HInActifCurr(Q);
  Q.Curr:=Num;
  Q.CurrModel:=_ALGetBuf(Q.Lst,Q.Curr);
  If(Q.CurrModel<>NIL)Then Begin
{   Q.CurrModel^.InTaskBar:=No;}
   ALSetPtr(Q.X,0);
   Ptr:=_ALGetCurrBuf(Q.X);
   While(HWin(Ptr^).SerialNumber<>Q.CurrModel^.Model)do Begin
    If(Ptr=NIL)Then Break;
    ALNext(Q.X);
    Ptr:=_ALGetCurrBuf(Q.X);
   End;
   Q.CurrHWin:=_ALGetCurrBuf(Q.X);
   If(Refresh)Then HRefresh(Q);
  End;
 End
  Else
 Q.CurrModel:=_ALGetBuf(Q.Lst,Q.Curr);
End;

Procedure HGotoNum{Var Q:HWins;Num:Word};Begin
 _HGotoNum(Q,Num,True);
End;

{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                         Fonction HLastModel                        Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Propri‚taire: HWins


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette fonction  retourne  le modŠle  (num‚ro de s‚rie)  de la fenˆtre
  ‚tant actif juste avant celle actuellement active dans le gestionnaire
  multi-fenˆtre de m‚thode ®H¯.
}

Function HLastModel{Var Q:HWins):Byte};
Var
 Old:Byte;
 WPtr:^InternalModel;
Begin
 If Q.Lst.Count-1<1Then HLastModel:=0
  Else
 Begin
  Old:=Q.Curr;
  If Q.Curr>0Then Dec(Q.Curr)
             Else Q.Curr:=Q.Lst.Count-1;
  WPtr:=_ALGetBuf(Q.Lst,Q.Curr);
  HLastModel:=WPtr^.Model;Q.Curr:=Old;
 End;
End;

{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                             Fonction HLoad                          Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Propri‚taire: HWins


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette fonction permet l'ouverture d'une nouvelle fenˆtre contenant des
  information pertinente dans un fichier sp‚cifique.  La valeur retourner
  indique si l'op‚ration c'est bien pass‚ (True) ou non (False).
}

Function HLoad{Var Q:HWins;SerialNumber:Byte;Const Path:String):Bool};
Var
 X1,Y1,X2,Y2:Byte;
Begin
 HLoad:=False;
 If(HNewManual(Q,SerialNumber,X1,Y1,X2,Y2)<>NIL)Then Begin
  If(@Q.CurrHWin^.Load<>NIL)Then Begin
   __HideMousePtr;
   Q.CurrHWin^.Load(Q.CurrModel^.X.Data,X1,Y1,X2,Y2,Path);
  End;
  HLoad:=True;
 End;
End;

Procedure HInTaskBar{Var Q:HWins};Begin
 If Q.Lst.Count=0Then Exit;
 Q.CurrModel^.InTaskBar:=True;
 HRefreshBackground(Q);
 HRefreshOtherWindows(Q);
End;

{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                         Fonction HModel                        Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Propri‚taire: HWins


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette fonction retourne le modŠle (num‚ro de s‚rie) de la fenˆtre
  actuellement actif.
}

Function HModel{Var Q:HWins):Byte};Begin
 If(Q.CurrModel=NIL)Then HModel:=0
                    Else HModel:=Q.CurrModel^.Model
End;

Function HNewManual{Var Q:HWins;SerialNumber:Byte;Var X1,Y1,X2,Y2:Byte):Pointer};
Var
 Ptr:Pointer;
 NumXTexts,NumYTexts:Byte;
 NewHWin:^HWin;
Begin
 HNewManual:=NIL;
 If Q.Lst.Count>1Then HInActifCurr(Q);
 ALSetPtr(Q.X,0);
 Ptr:=_ALGetCurrBuf(Q.X);
 While(HWin(_ALGetCurrBuf(Q.X)^).SerialNumber<>SerialNumber)do Begin
   { Erreur critique? }
  If(Ptr=NIL)Then Begin
   ErrNoMsgOk(ErrAppModeleNotFound);
   Exit;
  End;
  ALNext(Q.X);
  Ptr:=_ALGetCurrBuf(Q.X);
 End;
 NewHWin:=_ALGetCurrBuf(Q.X);
 NumXTexts:=NewHWin^.NumXTexts;NumYTexts:=NewHWin^.NumYTexts;
 If(NumXTexts)or(NumYTexts)<>0Then Begin
  Ptr:=HGetNextWnMin(Q,NumXTexts,NumYTexts,X1,Y1,SerialNumber);
  X2:=X1+NumXTexts;Y2:=Y1+NumYTexts;
 End
  Else
 Ptr:=HGetNextWnPos(Q,X1,Y1,X2,Y2,SerialNumber);
 If(Ptr=NIL)Then Exit;
 Q.CurrModel:=Ptr;HNewManual:=@Q.CurrModel^.X.Data;
 HInsFirst(Q,Q.Curr);
 _LoadWave(StrPas(SoundPlay[sndOpenWin]));
 _PlayWave;
End;

{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                             Fonction HNew                           Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Propri‚taire: HWins


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette fonction permet d'ouvrir une nouvelle fenˆtre sans fichier comme
  r‚f‚rence dans le gestionnaire de m‚thode ®H¯.
}

Function HNew{Var Q:HWins;SerialNumber:Byte):Bool};
Var
 X1,Y1,X2,Y2:Byte;
Begin
 HNew:=False;
 If(HNewManual(Q,SerialNumber,X1,Y1,X2,Y2)<>NIL)Then Begin
  If(@Q.CurrHWin^.Init<>NIL)Then Begin
   If Not Q.CurrHWin^.Init(Q.CurrModel^.X.Data,X1,Y1,X2,Y2)Then Begin
    ALDelBuf(Q.Lst,Q.Curr);
    HPrevious(Q);
    HNew:=False;
    Exit;
   End;
  End;
  HNew:=True;
 End;
End;

{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                           Fonction HNext                           Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Propri‚taire: HWins


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette proc‚dure permet de passer … la fenˆtre suivante d'un groupe de
  multiple fenˆtre du gestionnaire de fenˆtre de m‚thode ®H¯.
}

Procedure HNext{Var Q:HWins};Begin
 If Q.Lst.Count>1Then Begin
  HInActifCurr(Q);
  If(Q.Lst.Count-1>Q.Curr)Then Inc(Q.Curr)
                       Else Q.Curr:=0;
  HFindCurr(Q);
  ClrKbd;
 End;
End;

{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                           Fonction HPrevious                         Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Propri‚taire: HWins


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette proc‚dure permet de passer … la fenˆtre pr‚c‚dente d'un groupe de
  multiple fenˆtre du gestionnaire de fenˆtre de m‚thode ®H¯.
}

Procedure HPrevious{Var Q:HWins};Begin
 If Not ALIsEmpty(Q.Lst)Then Begin
  If Q.Lst.Count>1Then HInActifCurr(Q);
  If Q.Curr>0Then Dec(Q.Curr)
             Else Q.Curr:=Q.Lst.Count-1;
  If Q.Curr>=0Then Begin
   HFindCurr(Q);
   ClrKbd;
  End;
 End;
End;

{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                           Fonction HPtr                             Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Propri‚taire: HWins


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette fonction permet d'obtenir un pointeur sur les donn‚es concernant
  la fenˆtre actuellement en usage  dans le gestionnaire multi-fenˆtre de
  m‚thode ®H¯.
}

Function HPtr{Var Q:HWins):Pointer};Begin
 If(Q.CurrModel=NIL)Then HPtr:=NIL
                    Else HPtr:=@Q.CurrModel^.X.Data
End;

{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                        Fonction HRefresh                       Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Propri‚taire: HWins


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette proc‚dure permet d'effectuer une restauration de la fenˆtre
  actuellement active dans le gestionnaire  multi-fenˆtre de m‚thode
  ®H¯.
}

Procedure HRefresh{Var Q:HWins};Begin
 If(Q.CurrModel<>NIL)and(Q.CurrHWin<>NIL)and(@Q.CurrHWin^.Refresh<>NIL)Then Begin
  Q.CurrModel^.InTaskBar:=False;
  Q.CurrHWin^.Refresh(Q.CurrModel^.X.Data);
  HMoveFirst(Q,Q.Curr);
 End;
End;

Procedure HReSize{Var Q:HWins;X1,Y1,X2,Y2:Byte};
Var
 Old:Boolean;
Begin
 If Q.Lst.Count=0Then Exit;
 If(Q.CurrModel<>NIL)and(@Q.CurrHWin^.ReSize<>NIL)Then Begin
  Q.CurrHWin^.ReSize(Q.CurrModel^.X.Data,X1,Y1,X2,Y2);
  HRefreshOtherWindows(Q);
  HRefreshBackground(Q);
  HRefresh(Q);
 End;
End;

{ Remarque
  ÍÍÍÍÍÍÍÍ

   ş La taille de la toile … trou ®SizePln¯ doit obligatoirement avoir une
     ligne de plus que le nombre de ligne de texte parcequ'en mode 800x600
     pixels,  le nombre de ligne avec des caractŠres en 16 pixels de haut,
     n'arrive  pas juste  et donc  il y a un risque de  corruption m‚moire
     sinon dans ce mode vid‚o!
}

Function HChangeWindow(Var Q:HWins):Boolean;Near;
Label Free;
Var
 Windows:HWins;
 I,J,SizePln:Word;
 T:TextBoxRec;
Begin
 HChangeWindow:=False;Windows:=Q;
 If Q.Lst.Count>1Then Begin { Au moins deux fenˆtres? }
  {HInActifCurr(Q);}
  SizePln:=NmXTxts*Succ(NmYTxts);
  Hole:=MemNew(SizePln);
  If(Hole<>NIL)Then Begin
   FillBoxInPln(0,0,MaxXTxts,LnsMnu+Windows.HomeYEditor,Hole^);
   J:=Windows.Curr;
   For I:=0to Windows.Lst.Count-1do Begin
    If(Windows.VisualLst=NIL)Then Windows.CurrModel:=_ALGetBuf(Windows.Lst,J)
     Else
    Begin
     If I+1=Windows.SizeVisualLst shr 1Then Goto Free;
     J:=Windows.VisualLst^[I+1];
     Windows.CurrModel:=_ALGetBuf(Windows.Lst,J);
    End;
    If Not(Windows.CurrModel^.InTaskBar)Then Begin
     T:=Windows.CurrModel^.X.W.T;
     If(LastMouseX>=T.X1)and(LastMouseX<=T.X2)and(LastMouseY>=T.Y1)and(LastMouseY<=T.Y2)Then Begin
      WaitMouseBut0;
      __HideMousePtr;
      HInActifCurr(Q);
      HGotoNum(Q,J);
      HChangeWindow:=True;
      Goto Free;
     End;
     FillBoxInPln(T.X1,T.Y1,T.X2,T.Y2,Hole^);
    End;
    If J=0Then J:=Windows.Lst.Count-1
          Else Dec(J);
   End;
Free:
   FreeMemory(Hole,SizePln);
   Hole:=NIL;
  End;
 End;
End;

Procedure HMoveWinApp(Var Q:HWins);
Var
 Win:BoxRectRec;
 MB:Word;
 OrgX,OrgY,IY2,IX2,IY1,IX1:Integer;
 LX,LY,MX,MY,YM,XM:Byte;
 T:TextBoxRec;
Begin
 If(@Q.CurrHWin^.Move2<>NIL)Then Begin
  __HideMousePtr;
  If _SaveBoxRect(Q.CurrModel^.X.W.T.X1,Win)Then Begin
   MoveLeft(Q.CurrModel^.X.W.T.X1,T.X1,2);
   If(IsGrf)Then __PutRect(Win.GX1,$C)
    Else
   Begin
    ASM
     MOV AX,Word Ptr T.X1
     ADD AX,Word Ptr Win.MaxXTexts
     MOV Word Ptr T.X2,AX
    END;
    __PutBorderUnKr(T);
   End;
   __ShowMousePtr;
   If __GetMouseButton<>0Then Begin
    OrgX:=LastMouseX;
    OrgY:=LastMouseY;
    LX:=$FF;LY:=$FF;
    IX1:=T.X1;IY1:=T.Y1;
    XM:=Win.MaxXTexts;YM:=Win.MaxYTexts;
    Repeat
     __GetMouseTextSwitch(MX,MY,MB);
     If(MX<>LX)or(MY<>LY)Then Begin
      IX1:=T.X1-(OrgX-MX);
      IY1:=T.Y1-(OrgY-MY);
      IX2:=IX1+XM;
      IY2:=IY1+YM;
      If IX1<0Then Begin
       IX1:=0;
       IX2:=XM;
      End;
      If(IY1<=LnsMnu+Q.HomeYEditor)Then Begin
       IY1:=Q.HomeYEditor+LnsMnu+1;
       IY2:=IY1+YM;
      End;
      If(IX2>MaxXTxts)Then Begin
       IX1:=MaxXTxts-XM;
       IX2:=MaxXTxts;
      End;
      If(IY2>=MaxYTxts-Byte(HelpBar))Then Begin
       IY1:=MaxYTxts-YM-1-Byte(HelpBar);
       IY2:=MaxYTxts-1-Byte(HelpBar);
      End;
      WaitRetrace;
      __HideMousePtr;
      _PutBoxRect(Win);
      ReSaveBoxRect(IX1,IY1,Win);
      If(IsGrf)Then __PutRect(Win.GX1,$C)
               Else PutBorderUnKr(IX1,IY1,IX2,IY2);
      __ShowMousePtr;
      LX:=MX;LY:=MY;
     End;
    Until MB=0;
   End;
   __HideMousePtr;
   RestoreBoxRect(Win);
   Q.CurrHWin^.Move2(Q.CurrModel^.X.Data,IX1,IY1);
   HRefreshOtherWindows(Q);
   HRefreshBackground(Q);
  End;
  __ShowMousePtr;
 End
  Else
 WaitMouseBut0;
End;

Procedure HReSizeMouse(Var Q:HWins);Near;
Var
 Win:BoxRectRec;
 MB:Word;
 IY2,IX2,IY1,IX1:Integer;
 LX,LY,MX,MY,YM,XM:Byte;
 T:TextBoxRec;
Begin
 __HideMousePtr;
 If _SaveBoxRect(Q.CurrModel^.X.W.T.X1,Win)Then Begin
  MoveLeft(Q.CurrModel^.X.W.T.X1,T.X1,4);
  If(IsGrf)Then __PutRect(Win.GX1,$C)
           Else __PutBorderUnKr(T);
  __ShowMousePtr;
  If __GetMouseButton<>0Then Begin
   LX:=$FF;LY:=$FF;
   IX1:=T.X1;IY1:=T.Y1;
   XM:=Win.MaxXTexts;YM:=Win.MaxYTexts;
   Repeat
    __GetMouseTextSwitch(MX,MY,MB);
    If(MX<>LX)or(MY<>LY)Then Begin
     IX2:=MX;
     IY2:=MY;
     If(IX2>MaxXTxts)Then IX2:=MaxXTxts;
     If(IY2>=MaxYTxts-Byte(HelpBar))Then IY2:=MaxYTxts-1-Byte(HelpBar);
     T.X2:=IX2;
     T.Y2:=IY2;
     WaitRetrace;
     __HideMousePtr;
     _PutBoxRect(Win);
     RestoreBoxRect(Win);
     If Not _SaveBoxRect(T,Win)Then Begin
      WaitMouseBut0;
      Break;
     End;
     If(IsGrf)Then __PutRect(Win.GX1,$C)
              Else PutBorderUnKr(IX1,IY1,IX2,IY2);
     __ShowMousePtr;
     LX:=MX;LY:=MY;
    End;
   Until MB=0;
  End;
  __HideMousePtr;
  RestoreBoxRect(Win);
  Q.CurrHWin^.ReSize(Q.CurrModel^.X.Data,IX1,IY1,IX2,IY2);
  HRefreshOtherWindows(Q);
  HRefreshBackground(Q);
 End;
 __ShowMousePtr;
End;

{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                               Fonction HRun                           Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Propri‚taire: HWins


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette fonction permet de connaŒtre  l'action d' une touche de la fenˆtre
  active n'‚tant pas traŒt‚ par celle-ci dans le gestionnaire multi-fenˆtre
  de m‚thode ®H¯.
}

Function HRun{Var Q:HWins):Word};
Label MsChg,Restart,ReSize,1;
Var
 MX,MY:Byte;
 LB,B,K,Shift:Word;
 IX,IY:Integer;

 Function OnWindow:Boolean;
 Var
  XW,YW:Byte;
  MIX:Word Absolute IX;
  MIY:Word Absolute IY;
 Begin
  If(WEInWindow(Q.CurrModel^.X.W,LastMouseX,LastMouseY){or
    (WEOnWn(Q.CurrModel^.X.W,LastMsX,LastMsY))})and
    (Not Q.CurrModel^.InTaskBar)Then Begin
   OnWindow:=True;
   GetMouseSwitch(MIX,MIY,B);
   XW:=WEGetRX1(Q.CurrModel^.X.W);
   YW:=WEGetRY1(Q.CurrModel^.X.W);
   Dec(IX,XW shl 3);
   Dec(IY,GetRawY(YW));
   Dec(MX,XW);
   Dec(MY,YW);
  End
   Else
  Begin
   OnWindow:=False;
   __ShowMousePtr;
  End;
 End;

Begin
 Repeat
ReStart:
  If(Q.CurrModel<>NIL)and(Not Q.CurrModel^.InTaskBar)and
    (Q.CurrHWin<>NIL)and(@Q.CurrHWin^.Run<>NIL)Then
    K:=Q.CurrHWin^.Run(Q.CurrModel^.X.Data)
   Else
  Begin
   _InitKbd;
   __ShowMousePtr;
   LB:=0;
   SetMouseMove(True);
   Repeat
  1:__GetMouseTextSwitch(MX,MY,B);
    If B>0Then Begin
     LB:=B;
     If(LastMouseY=0)and(LastMouseX<CloseIconLen)Then Begin
      __HideMousePtr;
      HRun:=kbPrgClsIcon;
      Exit;
     End;
     If(LastMouseX>=Q.CurrModel^.X.W.T.X2-1)and
       (LastMouseX<=Q.CurrModel^.X.W.T.X2)and
       (LastMouseY=Q.CurrModel^.X.W.T.Y2)Then Goto ReSize;
     If(Q.CurrHWin<>NIL)Then Begin
      If(@Q.CurrHWin^.OnMouseControl<>NIL)Then Begin
       Shift:=WEInRightBarMs(Q.CurrModel^.X.W,LastMouseX,LastMouseY);
       If Shift>0Then Begin
        Q.CurrHWin^.OnMouseControl(Q.CurrModel^.X.Data,Shift);
        Goto 1;
       End;
      End;
      If WEInCloseIcon(Q.CurrModel^.X.W,LastMouseX,LastMouseY)Then Begin
       WaitMouseBut0;
       __HideMousePtr;
       HRun:=kbClose;
       Exit;
      End;
      If WEInZoomIcon(Q.CurrModel^.X.W,LastMouseX,LastMouseY)Then Begin
       WaitMouseBut0;
       __HideMousePtr;
       HRun:=kbZoom;
       Exit;
      End;
      If WEInTitle(Q.CurrModel^.X.W,LastMouseX,LastMouseY)and
         Not(Q.CurrModel^.InTaskBar)Then Begin
       If(Q.CurrModel^.X.W.ZoomIcon)and
         (LastMouseX<=Q.CurrModel^.X.W.T.X2-2)and
         (LastMouseX>=Q.CurrModel^.X.W.T.X2-3)Then Begin
        WaitMouseBut0;
        __HideMousePtr;
        HRun:=kbTaskBar;
        Exit;
       End;
       If LastMouseB=2Then Begin
        If(@Q.MenuTitleContext<>NIL)Then Q.MenuTitleContext(Q);
       End
        Else
       HMoveWinApp(Q);
       Goto 1;
      End;
      If(@Q.CurrHWin^.OnMouseDown<>NIL)and(OnWindow)Then Begin
       Q.CurrHWin^.OnMouseDown(Q.CurrModel^.X.Data,IX,IY,MX,MY,B);
       Goto 1;
      End;
     End;
     If(LastMouseY<>MainMenu.Y)Then Begin
      __HideMousePtr;
MsChg:If HChangeWindow(Q)Then HRun:=kbRefreshTaskBar
                         Else HRun:=kbMouse;
      Exit;
     End;
     If LastMouseB=1Then PMGetMnuBar(LastMouseX,LastMouseY)Else Begin
      HRun:=kbMouse;
      Exit;
     End;
    End
     Else
    If(Q.CurrHWin<>NIL)and(@Q.CurrHWin^.OnMouseUp<>NIL)and(LB<>B)Then Begin
     LB:=0;
     If(OnWindow)Then Q.CurrHWin^.OnMouseUp(Q.CurrModel^.X.Data,IX,IY,MX,MY,LB);
    End;
    _BackKbd;
    If(Q.CurrHWin<>NIL)Then Begin
     If(@Q.CurrHWin^.OnMouseMove<>NIL)and(IsMouseMove)and(OnWindow)Then Begin
      Q.CurrHWin^.OnMouseMove(Q.CurrModel^.X.Data,IX,IY,MX,MY);
      Goto 1;
     End;
     If(@Q.CurrHWin^.OnWaiting<>NIL)Then Q.CurrHWin^.OnWaiting(Q.CurrModel^.X.Data);
    End;
   Until KeyPress;
   __HideMousePtr;
   K:=ReadKeyTypeWriter;
   If(Q.CurrHWin<>NIL)and(@Q.CurrHWin^.OnKeyPress<>NIL)and(Lo(K)>=32)Then Begin
    Q.CurrHWin^.OnKeyPress(Q.CurrModel^.X.Data,Chr(K));
    Goto 1;
   End;
  End;
  If(K=kbPrgMnuBar)Then Begin
   PMGetMnuBar(LastMouseX,LastMouseY);
   Goto Restart;
  End
   Else
  Begin
   K:=_PMWaitForMnuAction(K);
   Case(K)of
    kbReSize:ReSize:If(@Q.CurrHWin^.ReSize<>NIL)Then HReSizeMouse(Q);
    kbMouse:Goto MsChg;
    kbTitle:Begin
     If LastMouseB=2Then Begin
      If(@Q.MenuTitleContext<>NIL)Then Q.MenuTitleContext(Q);
     End
      Else
     HMoveWinApp(Q);
    End;
   End;
  End;
  If(Q.CurrHWin<>NIL)and(@Q.CurrHWin^.OnKeyDown<>NIL)Then Begin
   {$IFNDEF FLAT386}
    CLI;
    Shift:=MemW[_0040:$17];
    STI;
   {$ENDIF}
   Q.CurrHWin^.OnKeyDown(Q.CurrModel^.X.Data,K,ShiftState(Shift));
  End;
 Until True;
 HRun:=K;
End;

{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                               Fonction HSave                            Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Propri‚taire: HWins


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette proc‚dure permet de sauvegarder les donn‚es contenue dans la fenˆtre
  actuellement active du gestionnaire multi-fenˆtre de m‚thode ®H¯.
}

Procedure HSave{Var Q:HWins};Begin
 If(Q.CurrModel<>NIL)and(@Q.CurrHWin^.Save<>NIL)Then
  Q.CurrHWin^.Save(Q.CurrModel^.X.Data);
End;

{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                              Fonction HSaveAs                           Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Propri‚taire: HWins


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette proc‚dure permet de sauvegarder les donn‚es contenue dans la fenˆtre
  actuellement active sous  un nom particulier  du gestionnaire multi-fenˆtre
  de m‚thode ®H¯.
}

Procedure HSaveAs{Var Q:HWins};Begin
 If(Q.CurrModel<>NIL)and(@Q.CurrHWin^.SaveAs<>NIL)Then
  Q.CurrHWin^.SaveAs(Q.CurrModel^.X.Data,'');
End;

{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                           Fonction HSaveAll                          Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Propri‚taire: HWins


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette proc‚dure permet de sauvegarder le contenu de toutes les fenˆtres
  actuellement  ouverte  ayant des donn‚es  non encore sauvegard‚  dans le
  gestionnaire multi-fenˆtre de m‚thode ®H¯.
}

Procedure HSaveAll{Var Q:HWins};
Var
 TW:^InternalModel;
 FW:^HWin;
 I,J:Integer;
Begin
 For I:=0to Q.Lst.Count-1do Begin
  TW:=_ALGetBuf(Q.Lst,I);
  If TW^.Model<>0Then For J:=0to Q.X.Count-1do Begin
   FW:=_ALGetBuf(Q.X,J);
   If(FW^.SerialNumber=TW^.Model)Then Begin
    If(@FW^.Save<>NIL)Then FW^.Save(TW^.X.Data);
    Break;
   End;
  End;
 End;
End;

{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                         Fonction HTitle                         Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Propri‚taire: HWins


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction retourne le nom attribu‚ … l'application courante du
 gestionnaire multi-fenˆtre de m‚thode ®H¯.
}

Function HTitle{Var Q:HWins;Max:Byte):String};Begin
 If(@Q.CurrHWin^.Title<>NIL)Then HTitle:=Q.CurrHWin^.Title(Q.CurrModel^.X.Data,Max)
                            Else HTitle:='Sans titre';
End;

Function HTitleInLst{Var Q:HWins;Max:Byte;Index:Word):String};
Var
 Windows:HWins;
 Model:Byte;
Begin
 Windows:=Q;Windows.CurrModel:=_ALGetBuf(Windows.Lst,Index);
 Model:=Windows.CurrModel^.Model;
 ALSetPtr(Windows.X,0);
 While(HWin(_ALGetCurrBuf(Windows.X)^).SerialNumber<>Model)do Begin
  ALNext(Windows.X);
  If(_ALGetCurrBuf(Windows.X)=NIL)Then Exit;
 End;
 Windows.CurrHWin:=_ALGetCurrBuf(Windows.X);
 HTitleInLst:=HTitle(Windows,Max);
End;

{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                             Fonction HDone                            Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Propri‚taire: HWins


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette proc‚dure sauvegarde  tous les fenˆtres ouvertes  s'il ne sont pas
  sauvegarder et les fermes toutes sans aception aprŠs et libŠre la m‚moire
  attribu‚ au gestionnaire multi-fenˆtre de m‚thode ®H¯.
}

Procedure HDone{Var Q:HWins};Begin
 HSaveAll(Q);
 ALDone(Q.Lst);
 ALDone(Q.X)
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
END.