{ Cette unit‚ est destin‚ … offrir des services d'aide directe aux
 programmeurs en fonction d'un mot cl‚.
}

Unit EditHelp;

INTERFACE

Uses Isatex;

Procedure TEOnlineHelp(Var Q:EditorApp);

IMPLEMENTATION

Uses Adele,Systex,Memories,Systems,Dialex,Video,Restex,ResServD,Mouse,Dials;

Procedure TEPutHelpMessage(Var Q:EditorApp;Const Instr,Param,Descr:String);
Var
 X,Y:Byte;
 I:Byte;
 W:Window;
 Palette:MtxColors;
 OldWinType:WinModelType;
 S:String;
Begin
 X:=WEGetRX1(Q.W)+Q.PX;
 Y:=WEGetRY1(Q.W)+Q.Y;
 If(X+60>MaxXTxts)Then X:=MaxXTxts-60;
 WEInit(W,X,Y+1,X+60,Y+10);
 WEPushWn(W);
 OldWinType:=WinType;
 WinType:=Normal;
 Palette:=CurrKrs.Dialog.Window;
 Palette.Border:=$E0;
 WEPutWn(W,'',Palette);
 WinType:=OldWinType;
 WEPutTxt(W,Instr+' ');
 For I:=1to Length(Param)do Begin
  If Param[I]in['A'..'Z']Then WEPutCube(W,Param[I])
                         Else WEPutChrGAttr(W,Param[I],cgItalic);
 End;
 WELn(W);
 WELn(W);
 WEPutMsg(W,Descr);
 _InitKbd;
 __ShowMousePtr;
 Repeat
  _BackKbd;
  If __GetMouseButton>0Then Break;
 Until KeyPress;
 __HideMousePtr;
 WEDone(W);
End;

Procedure TELoadOnlineHelp(Var Q:EditorApp;Code:Byte;Const Word,Entry:String);
Var
 Help:DataSet;
 Buffer:Array[0..511]of Byte;
 PParam:^String;
 PDescr:^String;
Begin
 If(IsGraf)Then WEPushCur(Q.W);
 If(Q.InsMode)Then SimpleCur
              Else FullCur;
 DBInit(Help,MaltePath+'DATA\AIDE.DAT');
 DBOpenServerName(Help,Entry);
 If DBLocateAbs(Help,0,Code,[])Then Begin
  DBReadRec(Help,Buffer);
  PParam:=@Buffer;
  DBGotoColumnAbs(Help,1,Pointer(PParam));
  PDescr:=@Buffer;
  DBGotoColumnAbs(Help,2,Pointer(PDescr));
  TEPutHelpMessage(Q,Word,PParam^,PDescr^);
 End
  Else
 ErrMsgOk('Mot introuvable!');
 DBDone(Help);
 CloseCur;
 If(IsGraf)Then WEPopCur(Q.W);
End;

Procedure TEOnlineHelp(Var Q:EditorApp);
Var
 Func:Boolean;
 PC:PChr;
 I:Word;
 Word:String;
Begin
 PC:=_ALGetBuf(Q.List,Q.P);
 If(PC<>NIL)Then Begin
  Case(Q.Mode)of
   vtBas:Begin
    Word:='';Func:=False;
    I:=Q.PX;
    If I>0Then Begin
     While ChrUp(PC^[I])in['A'..'Z']do Begin
      Dec(I);
      If I=0Then Break;
     End;
     Func:=PC^[I]in['=','+','-','*','/','\','^',',',';'];
     If Not(ChrUp(PC^[I])in['A'..'Z'])Then Inc(I);
    End;
    While ChrUp(PC^[I])in['A'..'Z']do Begin
     IncStr(Word,PC^[I]);
     Inc(I);
    End;
    If Not(Func)Then Begin
     Func:=PC^[I]in['=','+','-','*','/','\','^',',',';'];
    End;
    If(Func)Then Begin
     If DBLocateAbsIM(Q.DBFunc,2,Word,[soNoCaseSensitive])Then Begin
      TELoadOnlineHelp(Q,Q.DBFunc.CurrRec.Byte^,Word,'AIDE:/Compilateur/Basic/Fonction.Dat');
     End;
    End
     Else
    If DBLocateAbsIM(Q.DBInstr,2,Word,[soNoCaseSensitive])Then Begin
     TELoadOnlineHelp(Q,Q.DBInstr.CurrRec.Byte^,Word,'AIDE:/Compilateur/Basic/Instruction.Dat');
    End
     Else
    Begin
     ErrMsgOk('D‚sol‚! Aide introuvable.');
    End;
   End;
  End;
 End;
End;

END.