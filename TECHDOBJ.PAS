{ Cette unit‚ est destin‚ … la manipulation des objets des dessins
 techniques (nomm‚ aussi dessins vectorielle).
}

Unit TechDObj;

INTERFACE

Uses Isatex;

Procedure TDShowObjectList(Var Q:TechDrawApp);

IMPLEMENTATION

Uses
 Adele,Systex,Systems,Memories,Dialex,Imagetex,
 Restex,Dials,Mouse,TechDraw,DialPlus;

Function TDLReadLine(Var Q:TechDrawApp;P:RBP):String;
Var
 Obj:^TDObject;
Begin
 Obj:=_ALGetBuf(Q.Lst,P);
 Case(Obj^.DrawLine.ID)of
  imiRealLine:TDLReadLine:='Ligne';
  imiRealBox:TDLReadLine:='Rectangle';
  imiDFDFlux:TDLReadLine:='Flux de donn‚es DFD';
  imiDFDProcessus:TDLReadLine:='Processus DFD ('+WordToStr(Obj^.DFDProcessus.NumID)+') '+Obj^.DFDProcessus.Name;
  Else TDLReadLine:='';
 End;
End;

Procedure TDLSelectBar(Var Q:TechDrawApp;Var W:Window);Begin
 WESetKrSel(W);
 WEBarSelHor(W,0,Q.CurrYObject,wnMax);
End;

Procedure TDLUnSelectBar(Var Q:TechDrawApp;Var W:Window);Begin
 If(IsBanderolle)Then Begin
  WEBarSpcHorBanderolle(W,Q.CurrYObject,Q.CurrPosObject);
  WEPutTxtXYT(W,0,Q.CurrYObject,TDLReadLine(Q,Q.CurrPosObject));
 End
  Else
 Begin
  WESetKrBorder(W);
  WEBarSelHor(W,0,Q.CurrYObject,wnMax);
 End;
End;

Procedure TDLPutLine(Var Q:TechDrawApp;Var W:Window);Begin
 If(IsBanderolle)Then Begin
  WEBarSpcHorBanderolle(W,Q.CurrYObject,Q.CurrPosObject);
  WEPutTxtXYT(W,0,Q.CurrYObject,TDLReadLine(Q,Q.CurrPosObject));
 End
  Else
 WEPutTxtXY(W,0,Q.CurrYObject,TDLReadLine(Q,Q.CurrPosObject));
End;

Procedure TDLShowObject(Var Q:TechDrawApp;Var W:Window);
Var
 I:Byte;
 PT:Word;
Begin
 WEClrWnBorder(W,0,0,wnMax,wnMax);
 WESetPosHome(W);
 PT:=Q.CurrPosObject-Q.CurrYObject;
 For I:=0to(W.MaxY)do Begin
  If(IsBanderolle)Then Begin
   WEBarSpcHorBanderolle(W,I,PT);
   WEPutTxtTLn(W,TDLReadLine(Q,PT));
  End
   Else
  WEPutTxtLn(W,TDLReadLine(Q,PT));
  Inc(PT);
  If(PT>=Q.Lst.Count)Then Break;
 End;
 TDLSelectBar(Q,W);
End;

Procedure TDLUp(Var Q:TechDrawApp;Var W:Window);Begin
 If Q.CurrPosObject>0Then Begin
  TDLUnSelectBar(Q,W);
  Dec(Q.CurrPosObject);
  If Q.CurrYObject>0Then Dec(Q.CurrYObject)
   Else
  Begin
   WEScrollUp(W,0,0,wnMax,wnMax);
   TDLPutLine(Q,W);
  End;
  TDLSelectBar(Q,W);
 End;
End;

Procedure TDLDn(Var Q:TechDrawApp;Var W:Window);Begin
 If Q.CurrPosObject<Q.Lst.Count-1Then Begin
  TDLUnSelectBar(Q,W);
  Inc(Q.CurrPosObject);
  If(Q.CurrYObject<W.MaxY)Then Inc(Q.CurrYObject)
   Else
  Begin
   WEScrollDn(W,0,0,wnMax,wnMax);
   TDLPutLine(Q,W);
  End;
  TDLSelectBar(Q,W);
 End;
End;

Procedure TDLRefresh(Var Q:TechDrawApp;Var W:Window);Begin
 WEPutWn(W,'Liste des Objets',CurrKrs.Dialog.Env.List);
 WECloseIcon(W);
 WEPutBarMsRight(W);
 TDLShowObject(Q,W);
End;

Procedure TDShowObjectList(Var Q:TechDrawApp);
Var
 W:Window;
 K,P:Word;
Begin
 If Q.Lst.Count=0Then Begin
  ErrMsgOk('Aucun objet trouv‚.');
  Exit;
 End;
 WEInitO(W,NmXTxts shr 1,NmYTxts shr 1);
 WEPushWn(W);
 If(Q.CurrYObject<Q.CurrPosObject)Then Begin
  If(Q.CurrPosObject<=W.MaxY)Then Q.CurrYObject:=Q.CurrPosObject
                             Else Q.CurrYObject:=W.MaxY shr 1;
 End
  Else
 Q.CurrYObject:=Q.CurrPosObject;
 TDLRefresh(Q,W);
 Repeat
  K:=WEReadk(W);
  Case(K)of
   kbInWn:Begin
    TDLUnSelectBar(Q,W);
    P:=Q.CurrPosObject-Q.CurrYObject;
    Q.CurrYObject:=LastMouseY-WEGetRY1(W);
    Inc(P,Q.CurrYObject);
    Q.CurrPosObject:=P;
    ALSetPtr(Q.Lst,Q.CurrPosObject);
    Q.CurrObject:=_ALGetCurrBuf(Q.Lst);
    TDLSelectBar(Q,W);
    If LastMouseB=2Then Begin
     WaitMouseBut0;
     Case RunMenuApp(166)of
      $F001:Begin
       TDObjectPropriety(Q);
       TDLRefresh(Q,W);
      End;
      $F002:Begin
       ALDelBuf(Q.Lst,Q.CurrPosObject);
       TDRefresh(Q);
       TDLRefresh(Q,W);
      End;
     End;
    End
     Else
    WaitMouseBut0;
   End;
   kbRBarMsUp,kbRBarMsDn:Begin
    __HideMousePtr;
    Case(K)of
     kbRBarMsUp:TDLUp(Q,W);
     Else TDLDn(Q,W);
    End;
    DelayMousePress(100);
    __ShowMousePtr;
   End;
   kbUp:TDLUp(Q,W);
   kbDn:TDLDn(Q,W);
   Else Break;
  End;
 Until False;
 WEDone(W);
End;

END.