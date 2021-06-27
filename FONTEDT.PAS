{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                                                                         Û
  ³                    Malte Genesis/diteur de police                      Û
  ³                                                                         Û
  ³            dition Chantal pour Mode R‚el/IV - Version 1.1              Û
  ³                              1997/01/01                                 Û
  ³                                                                         Û
  ³          Tous droits r‚serv‚s par les Chevaliers de Malte (C)           Û
  ³                                                                         Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Nom du programmeur
  ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

   Sylvain Maltais


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette unit‚ est utilis‚e pour l'‚dition de police de caractŠres de
  format brute (?x8x256).
}

Unit FontEdt;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                 INTERFACE
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

{$I DEF.INC}

Uses Systex,Isatex;

Const
 FEWidth=50;  { Largeur de la fenˆtre de la police de caractŠres }
 FEHeight=20; { Hauteur de la fenˆtre de la police de caractŠres }

Procedure FELoad(Var Q;X1,Y1,X2,Y2:Byte;Const FileName:String);
Procedure FEOpen(Var Q;X,Y:Byte;Const FileName:String);
Procedure FERefresh(Var Q);
Function  FESave(Var Q):Boolean;
Function  FESaveAs(Var Q;Const FileName:String):Boolean;
Function  FERun(Var Q):Wd;
Function  FETitle(Var Q;Max:Byte):String;
Procedure FECopy(Var QX);
Procedure FEPaste(Var QX);
Procedure FEMove2(Var QX;X,Y:Byte);
Function  FEDone(Var Q):Word;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                 IMPLEMENTATION
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses Adele,Math,Memories,Systems,Video,Dialex,Dials,DialPlus;

Procedure FEOpen;
Label New;
Var
 Handle:Hdl;
Begin
 FillClr(Q,SizeOf(FontEditor));
 FontEditor(Q).FileName:=FileName;
 WEInit(FontEditor(Q).W,X,Y,X+FEWidth-1,Y+FEHeight-1);
 {$IFNDEF H}
  WEPushWn(FontEditor(Q).W);
 {$ENDIF}
 If FileName<>''Then Begin
  Handle:=FileOpen(FileName,fmRead);
  If(Handle=errHdl)Then Goto New;
  FontEditor(Q).SizeOfPtr:=FileSize(Handle);
  FontEditor(Q).Height:=FontEditor(Q).SizeOfPtr shr 8;
  FontEditor(Q).Ptr:=MemAlloc(FontEditor(Q).SizeOfPtr);
  If(FontEditor(Q).Ptr=NIL)Then Begin
   __OutOfMemory;
   Exit;
  End;
  _GetAbsRec(Handle,0,FontEditor(Q).SizeOfPtr,FontEditor(Q).Ptr^);
  FileClose(Handle);
 End
  Else
 Begin
New:FontEditor(Q).Height:=16;
  FontEditor(Q).SizeOfPtr:=FontEditor(Q).Height shl 8;
  FontEditor(Q).Ptr:=MemNew(FontEditor(Q).SizeOfPtr);
 End;
 FERefresh(FontEditor(Q));
End;

Procedure FEPutPos(Var Q:FontEditor);Near;Begin
 WEPutTxtXY(Q.W,15,5,'Position X: '+Char(Q.X+48));
 WEPutTxtXY(Q.W,15,6,'Position Y: '+WordToStr(Q.Y)+' ');
End;

Function GetCurrMtx(Var Height:Byte):Pointer;Near;
Var
 _BH:Byte;
Begin
 Case(CurrHeightChr)of
  0..7: Exit;
  8..10: _BH:=$03;
  13..14: _BH:=$02;
  15..16: _BH:=$06;
 End;
 ASM
  MOV AX,$1130
  MOV BH,_BH
  PUSH BP
   INT $10
   MOV BX,BP
  POP BP
  MOV @Result.Word,BX
  MOV @Result.Word[2],ES
  LES DI,Height
  MOV ES:[DI],CL
 END;
End;

Procedure FEPutData(Var Q:FontEditor);Near;
Var
 I,J,T,Height:Byte;
 Base:Word;
 Chr:Char;
 PT:^TByte;
Begin
 If Q.FileName=''Then WEPutTxtXY(Q.W,15,1,'Nom de la police:  inexistant!')
 Else WEPutTxtXY(Q.W,15,1,'Nom de la police:  ®'+Path2NoDir(Q.FileName)+'¯');
 If Not(IsGrf)and((FontFound)and(IsKr))and(Q.CurrChr<32)Then Begin
  Chr:=#14;
  PT:=GetCurrMtx(Height);
  Inc(PtrRec(PT).Ofs,Q.CurrChr*Height);
  SetModeMtx;
  For J:=0to 31do Mem[_A000:14*32+J]:=PT^[J];
  SetModeScr;
 End
  Else
 If Q.CurrChr=255Then Chr:=' 'Else Chr:=Char(Q.CurrChr);
 WEPutTxtXY(Q.W,15,2,'CaractŠre courant: #'+WordToStr(Q.CurrChr)+', ®'+Chr+'¯   ');
 WEPutTxtXY(Q.W,15,3,'Hauteur caractŠre: '+WordToStr(Q.Height));
 FEPutPos(Q);
 Base:=Q.CurrChr*Q.Height;
 For J:=0to Q.Height-1do Begin
  T:=Q.Ptr^[Base+J];
  For I:=0to 7do Begin
   If T and 128<>0Then Chr:='ş'
                  Else Chr:='ú';
   WESetChr(Q.W,4+I,1+J,Chr);
   ASM SHL T,1;END;
  End;
 End;
End;

Procedure FERefresh;
Var
 X,Y:Byte;
Begin
 WEPutWnKrDials(FontEditor(Q).W,'diteur de Police');
 WECloseIcon(FontEditor(Q).W);
 X:=WEGetRX1(FontEditor(Q).W);Y:=WEGetRY1(FontEditor(Q).W);
 If(IsGraf)Then PutRect((X+3)shl 3,GetRawY(Y),((X+4+8+1)shl 3)-1,
                        GetRawY(Y+FontEditor(Q).Height+2)-1,15)
           Else PutBorderUnKr(X+3,Y,X+4+8,Y+FontEditor(Q).Height+1);
 FEPutData(FontEditor(Q));
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure FECopy                            Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de copier le caractŠre courant dans une m‚moire
 tampon  afin  d'‚ventuellement la recopier  …  partir  de la  proc‚dure
 ®FEPaste¯.
}

Procedure FECopy;
Var
 Q:FontEditor Absolute QX;
Begin
 MoveLeft(Q.Ptr^[Q.CurrChr*Q.Height],Q.Clipboard,Q.Height);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure FEPaste                           Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de coller le caractŠre pr‚alablement copier par
 la proc‚dure ®FEPaste¯ sur le caractŠre courant.
}

Procedure FEPaste;
Var
 Q:FontEditor Absolute QX;
Begin
 MoveLeft(Q.Clipboard,Q.Ptr^[Q.CurrChr*Q.Height],Q.Height);
 FERefresh(QX);
End;

Function FERun;
Var
 K:Word;
 T,T1:Byte;
 Chr:Char;
 Q1:FontEditor Absolute Q;
Begin
 Repeat
  WESetCurPos(Q1.W,Q1.X+4,Q1.Y+1);
  WESetPos(Q1.W,Q1.X+4,Q1.Y+1);
{  If(IsGraf)Then WEPushCur(Edt(Q).W);}
  SimpleCur;
  K:=WEReadk(Q1.W);
  CloseCur;
  If(IsGraf)Then WESetAttr(Q1.W,Q1.X+4,Q1.Y+1,CurrKrs.Dialog.Window.Border);
  {WEPopCur(Edt(Q).W);}
  Case(K)of
   kbUp:Begin
    Q1.Y:=MinByte(Q1.Y,Q1.Height-1);
    FEPutPos(Q1)
   End;
   kbDn:Begin
    Q1.Y:=MaxByte(Q1.Y,Q1.Height-1);
    FEPutPos(Q1)
   End;
   kbLeft:Begin
    Q1.X:=MinByte(Q1.X,7);
    FEPutPos(Q1)
   End;
   kbRight:Begin
    Q1.X:=MaxByte(Q1.X,7);
    FEPutPos(Q1)
   End;
   kbPgUp:Begin
    Q1.CurrChr:=MinByte(Q1.CurrChr,255);
    FEPutData(Q1)
   End;
   kbPgDn:Begin
    Q1.CurrChr:=MaxByte(Q1.CurrChr,255);
    FEPutData(Q1)
   End;
   kbCtrlPgUp:Begin
    Q1.CurrChr:=MinByte(Q1.CurrChr-9,255);
    FEPutData(Q1)
   End;
   kbCtrlPgDn:Begin
    Q1.CurrChr:=MaxByte(Q1.CurrChr+9,255);
    FEPutData(Q1)
   End;
   Else Begin
    If Lo(K)=32Then Begin
     T:=$80 shr Q1.X;T1:=Q1.Ptr^[Q1.CurrChr*Q1.Height+Q1.Y];
     If(T1 and T=T)Then Begin
      Q1.Ptr^[Q1.CurrChr*Q1.Height+Q1.Y]:=T1 and Not(T);
      Chr:='ú'
     End
      Else
     Begin
      Q1.Ptr^[Q1.CurrChr*Q1.Height+Q1.Y]:=T1 or T;
      Chr:='ş'
     End;
     WESetChr(Q1.W,4+Q1.X,1+Q1.Y,Chr);
    End
     Else
    Begin
     FERun:=K;
     Break;
    End;
   End;
  End;
 Until No;
End;

Function FESaveAs;
Var
 J:RBP;
 Handle:Hdl;
 UpDate:Boolean;
 LW:Window;
 OldPtr:Pointer;
 Path:String;
Begin
 Path:=FileName;
 If Path=''Then Path:=OpenWin(Path,'Sauvegarde sous');
 UpDate:=FontEditor(Q).FileName<>Path;
 If(UpDate)Then Begin{ Existe toujours ? }
  If FileExist(Path)Then If Not __InputOverwriteFile(Path)Then Exit;
  FontEditor(Q).FileName:=StrUp(Path);
 End;
 WEPushEndBar(LW);
 WEPutLastBar('Sauvegarde en cours...');
{ FEPutInfo(Q);}
 Path:=Path2NoExt(Path)+'.FNT';
 Handle:=FileCreateAndBackup(Path);
 If(Handle=errHdl)Then Begin
  ErrNoMsgOk(CannotCreateFile);
  WEDone(LW);
  Exit;
 End;
 _SetAbsRec(Handle,0,FontEditor(Q).SizeOfPtr,FontEditor(Q).Ptr^);
 FileClose(Handle);
 FontEditor(Q).Modified:=No;
{ FEPutPos(Q);}
 WEDone(LW);
 FESaveAs:=Ya;
End;

Function FESave;Begin
 FESave:=FESaveAs(Q,FontEditor(Q).FileName)
End;

Function FETitle(Var Q;Max:Byte):String;
Const
 Name='Editeur Police';
Begin
 FETitle:=Name+TruncName(FontEditor(Q).FileName,Max-Length(Name));
End;

Function FEDone;Begin
 FreeMemory(FontEditor(Q).Ptr,FontEditor(Q).SizeOfPtr);
 FEDone:=0;
End;

Procedure FELoad(Var Q;X1,Y1,X2,Y2:Byte;Const FileName:String);Begin
 FEOpen(Q,X1,Y1,FileName);
End;

Procedure FEMove2(Var QX;X,Y:Byte);
Var
 Q:FontEditor Absolute QX;
 MX,MY:Byte;
Begin
 MX:=Q.W.T.X2-Q.W.T.X1;MY:=Q.W.T.Y2-Q.W.T.Y1;
 Q.W.T.X1:=X;Q.W.T.X2:=X+MX;
 Q.W.T.Y1:=Y;Q.W.T.Y2:=Y+MY;
 FERefresh(Q);
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
END.