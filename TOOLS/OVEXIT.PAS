Unit OVExit;

INTERFACE

Procedure ExitPrg;

IMPLEMENTATION

Uses Adele,Systex,Systems,Isatex,Dials,OVIde,Apps;

Procedure ExitPrg;
Var
 PathDesktop:String;
 Handle:Hdl;
 I:Integer;
 TW:^EditorApp;
Begin
 {Sauvegarde le Desktop}
 PathDesktop:=MaltePath+'OVP.DSK';
  { Cr‚ation du desktop }
 If StrUp(PathDesktop)<>'NONE'Then Begin
  If Windows.Lst.NB=0Then DeleteFile(PathDesktop) { Pas fenˆtre donc pas desktop...}
   Else
  Begin
   Handle:=FileCreate(PathDesktop);
   If(Handle=errHdl)Then ErrMsgOk('Impossible de cr‚er un fichier de ®Desktop¯!')
    Else
   Begin
    For I:=0to Windows.Lst.NB-1do Begin
     TW:=HPtr(Windows);
     If(TW=NIL)Then Break;
     Case HModel(Windows)of
      0:Break;
      snEdt:PutFileTxtLn(Handle,'ED:'+TW^.EditName+' '+
			 WordToStr(TW^.PX)+','+WordToStr(TW^.P));
     End;
     HNext(Windows);
    End;
    FileClose(Handle);
   End;
  End;
 End;
End;

END.