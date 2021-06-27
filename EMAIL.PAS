{ Cette unit‚ est utilis‚e pour permettre d'editer les courriels.
}

Unit Email;

INTERFACE

Uses Isatex;

Function  EMInit(Var Context;X1,Y1,X2,Y2:Byte):Boolean;
Procedure EMRefresh(Var Context);
Function  EMRun(Var Context):Word;
Function  EMTitle(Var Context;Max:Byte):String;
Procedure EMMove2(Var Context;X,Y:Byte);
Procedure EMReSize(Var Context;X1,Y1,X2,Y2:Byte);
Procedure EMSendTo(Var Q:EmailApp;Const EmailTo:String);
Function  EMDone(Var Context):Word;

IMPLEMENTATION

Uses Systex,Systems,Dialex,Dials,EdtLoad,Editor;

Function EMInit(Var Context;X1,Y1,X2,Y2:Byte):Boolean;
Var
 Q:EmailApp Absolute Context;
Begin
 FillClr(Q,SizeOf(Q));
 WEInit(Q.W,X1,Y1,X2,Y2);
 TENew(Q.TextEdit,X1+1,Y1+8,X2-1,Y2-1);
 EMRefresh(Context);
End;

Procedure EMRefreshEmailFrom(Var Q:EmailApp);Near;Begin
 WESetKr(Q.W,$8F);
 Q.W.Palette.kShade:=CurrKrs.Dialog.Window.kShade;
 WEBarSpcHorShade(Q.W,10,1,Q.W.MaxX-2);
 WEPutTxtXY(Q.W,10,1,Q.EmailFrom);
End;

Procedure EMRefreshEmailTo(Var Q:EmailApp);Near;Begin
 WESetKr(Q.W,$8F);
 Q.W.Palette.kShade:=CurrKrs.Dialog.Window.kShade;
 WEBarSpcHorShade(Q.W,10,3,Q.W.MaxX-2);
 WEPutTxtXY(Q.W,10,3,Q.EmailTo);
End;

Procedure EMRefreshEmailTitle(Var Q:EmailApp);Near;Begin
 WESetKr(Q.W,$8F);
 Q.W.Palette.kShade:=CurrKrs.Dialog.Window.kShade;
 WEBarSpcHorShade(Q.W,10,5,Q.W.MaxX-2);
 WEPutTxtXY(Q.W,10,5,Q.Title);
End;

Procedure EMRefresh(Var Context);
Var
 Q:EmailApp Absolute Context;
Begin
 WEPutWnKrDials(Q.W,EMTitle(Q,Q.W.MaxX));
 WECloseIcon(Q.W);
 WEZoomIcon(Q.W);
 WEBar(Q.W);
 WEPutTxtXY(Q.W,1,1,'De:');
 WEPutTxtXY(Q.W,1,3,'A:');
 WEPutTxtXY(Q.W,1,5,'Titre:');
 EMRefreshEmailFrom(Q);
 EMRefreshEmailTo(Q);
 EMRefreshEmailTitle(Q);
 WESetKrBorder(Q.W);
 TERefresh(Q.TextEdit);
End;

Procedure EMSendTo(Var Q:EmailApp;Const EmailTo:String);Begin
 Q.EmailTo:=EmailTo;
 EMRefreshEmailTo(Q);
End;

Function EMRun(Var Context):Word;
Var
 Q:EmailApp Absolute Context;
 K:Word;
Begin
 Repeat
  Case(Q.Pos)of
   0..2:K:=WEReadk(Q.W);
   3:K:=TERun(Q.TextEdit);
  End;
  Case(K)of
   kbTab:Q.Pos:=(Q.Pos+1)and 3;
   Else Break;
  End;
 Until False;
 EMRun:=K;
End;

Function EMTitle(Var Context;Max:Byte):String;
Var
 Q:EmailApp Absolute Context;
Begin
 EMTitle:='Courriel';
End;

Procedure EMMove2(Var Context;X,Y:Byte);
Var
 Q:EmailApp Absolute Context;
Begin
End;

Procedure EMReSize(Var Context;X1,Y1,X2,Y2:Byte);
Var
 Q:EmailApp Absolute Context;
Begin
End;

Function EMDone(Var Context):Word;
Var
 Q:EmailApp Absolute Context;
Begin
 EMDone:=0;
End;

END.