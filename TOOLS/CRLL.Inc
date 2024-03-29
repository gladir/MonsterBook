{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                      Compilateur de RLL                         �
 �  Malte Genesis/Edition Chantal pour Mode R괻l/IV - Version 1.2  �
 �                          1995/01/01                             �
 �                                                                 �
 �       Tous droits r굎erv굎 par les Chevaliers de Malte (C)      �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Nom du programmeur
 袴袴袴袴袴袴袴袴袴

  Sylvain Maltais


 Description
 袴袴袴袴袴�

  Ce programme permet de compiler un listing  de format ressource en
 biblioth둸ue �.RLL� compatible avec l'ensemble Malte Genesis III ou
 IV ou V des Chevaliers de Malte.
}

Type FontIndexRecord=Record
 PosAbs:LongInt;
 Size,Height:Word;
 Name:String[55];
End;

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                          Proc괺ure _GetFileTxtLn                        �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Description
 袴袴袴袴袴�

  Cette fonction lit une ligne texte  ASCII � la  position  du pointeur d'un
 Handle DOS. Elle retourne cette ligne dans une cha똭e de caract둹es contenu
 dans une variable de param굏rage 췇uffer�.
}

Function _GetFilePTxtLn(Handle:Hdl;Buf:PChr;SizeBuf:Word):Word;Begin
 _GetRec(Handle,SizeBuf,Buf^);
 ASM
  {$IFNDEF FLAT386}
   LES DI,Buf
   MOV BX,-1
   MOV DX,SizeBuf
 @1:INC BX
   CMP BX,DX
   JNBE @3
   CMP Word Ptr ES:[DI+BX],13+(10 shl 8)
   JNE @1
   JMP @2
 @3:DEC BX
 @2:
   XOR AL,AL
   ADD DI,BX
   STOSB
   MOV @Result,BX
  {$ENDIF}
 END;
End;

Procedure __GetAbsFilePTxtLn(Handle:Hdl;Var P:LongInt;Buf:PChr;SizeBuf:Word);Begin
 SetFilePos(Handle,P);
 Inc(P,Long(_GetFilePTxtLn(Handle,Buf,SizeBuf)+2))
End;

Procedure PSkipSpcInLn(Var I:Word;Line:PChr);Begin
 If I>StrLen(Line)Then Exit;
 While(Line^[I]in SpcCode)do Inc(I)
End;

Function PStrI(I:Wd;Line:PChr):Chr;Begin;PStrI:=Line^[I]End;

Function PXtrkXNm(X:Byte;Var I:Word;L:PChr):String;
Var
 J:Word;
 S:String;
Begin
 PXtrkXNm:='';
 If I>StrLen(L)Then Exit;
 J:=I;
 Case(X)of
  2:While(L^[I]in BinArabicDigit)do Inc(I);
  8:While(L^[I]in OctArabicDigit)do Inc(I);
 10:While(L^[I]in ArabicDigit)do Inc(I);
 16:While(L^[I]in ArabicXDigit)do Inc(I);
 End;
 If(I=J)Then Exit;
 MoveLeft(L^[J],S[1],I-J);
 S[0]:=Chr(I-J);
 PXtrkXNm:=S
End;

Function PXtrkBinNm(Var I:Word;L:PChr):String;Begin
 PXtrkBinNm:=PXtrkXNm(2,I,L)
End;

Function PXtrkDecNm(Var I:Word;L:PChr):String;Begin
 PXtrkDecNm:=PXtrkXNm(10,I,L)
End;

Function PXtrkHexNm(Var I:Word;L:PChr):String;Begin
 PXtrkHexNm:=PXtrkXNm(16,I,L)
End;

Function PXtrkOctNm(Var I:Word;L:PChr):String;Begin
 PXtrkOctNm:=PXtrkXNm(8,I,L)
End;

Function PXtrkPasStr(Var I:Word;L:PChr;Var EM:Boolean):String;
Var
 T:String;
Begin
 EM:=True;Inc(I);T:='';
 While(L^[I]<>'''')or((L^[I]='''')and(L^[I+1]=''''))do Begin
  If L^[I]=#0Then Break;
  If(L^[I]='''')and(L^[I+1]='''')Then Begin
   IncStr(T,'''');
   Inc(I,2)
  End
   Else
  Begin
   IncStr(T,L^[I]);
   Inc(I)
  End;
 End;
 If L^[I]=''''Then Inc(I);
 EM:=No;PXtrkPasStr:=T;
End;

Function MakeRLLFile(Path:String;Q:Pointer):Word;
Label BreakAll,UnknownInstr;
Var
 NmIndex,BankFont:Word;
 Index2Set:Word;
 Handle,HandleRLL,HandleLoad:Hdl;
 FP,FS,PF,FSL,FM,NL,M:Long;
 Str,StrU,Word,Msg:String;
 DB,DB2:Byte;
 I:Wd;                         { Compteur de boucle }
 Instr:DataSetInMemory;        { Table d'instruction dans la base de donn괻s }
 EM,Ok:Boolean;
 Target:PathStr;
 Buf:Pointer;
 XFIR:FontIndexRecord;
 ModeFont:(mfNone,mfImageBin,mfMatrix);
 SzX,SzY,SzH,CBF,LP,NM,ND,DW:Wd;
 MtxPos:Array[Byte]of Wd;
 PC:PChr;
 PStr:Array[0..4095]of Char;
 CopyMethode:MethodeCopySet;
 BnkClr:Array[0..255]of Byte;
 LenBnkClr:Byte;
 NoErr:Boolean;             { Pas d'erreur de compilation? }
 J:Wd;                      { Compteur de boucle }
 Edit:^EditorApp Absolute Q;{ Objet utilis� pour la compilation � partir d'un tra똳ement de texte }
 {$IFNDEF CONSOLE}
  W:Window;                 { Fen늯re pour l'affichage de l'굏at actuel de progression }
  TimeIn:LongInt;           { Temps de d굆arrage de la compilation }
  OldTime:Byte;             { Temps de modification...}
  SizeRLL:LongInt;          { Taille du RLL }
 {$ENDIF}
 Param:^String;             { Param둻re de fonction }
 LenParam:Integer;          { Nombre de param둻res }
 JP:Integer;                { Compteur de param둻res }
 IP:Wd;                     { Position de variable 췝ariant� }
 SP:Wd;                     { Position de variable 췚tring� }
 OpenPar:Boolean;           { Ouverture de parenth둺e? }

 Procedure Error(Const Msg:String);Begin
  {$IFDEF CONSOLE}
   WriteLn('Erreur: ',Msg);
  {$ELSE}
   WEDone(W);
   If(HelpBar)Then Begin
    BarSpcHor(0,MaxYTxts,MaxXTxts,$CF);
    SetAllKr($CE,$CF);
    PutTypingXY(2,MaxYTxts,Msg);
   End
    Else
   Dials.ErrMsgOk('Erreur: '+Msg);
  {$ENDIF}
 End;

 Procedure ErrorNo(X:Wd);Begin
  Error(GetErrMsg(X));
 End;

 Procedure PushByte(X:Byte);Begin
  _SetAbsRec(HandleRLL,PF,1,X);
  Inc(PF,1);
 End;

 Function XtrkByte:Byte;Begin
  PSkipSpcInLn(I,PC);
  XtrkByte:=StrToWord(PXtrkDecNm(I,PC));
  PSkipSpcInLn(I,PC);
 End;

 Procedure XtrkNPushByte;Begin
  PushByte(XtrkByte);
 End;

 Procedure XtrkNPushWord;
 Var
  DW:Wd;
 Begin
  PSkipSpcInLn(I,PC);
  DW:=StrToWord(PXtrkDecNm(I,PC));
  _SetAbsRec(HandleRLL,PF,2,DW);Inc(PF,2);
  PSkipSpcInLn(I,PC);
 End;

 Procedure XtrkNPushStr;
 Var
  Msg:String;
 Begin
  PSkipSpcInLn(I,PC);
  EM:=False;
  Msg:=PXtrkPasStr(I,PC,EM);
  _SetAbsRec(HandleRLL,PF,Length(Msg)+1,Msg);
  Inc(PF,Length(Msg)+1);
  PSkipSpcInLn(I,PC);
 End;

 Procedure XtrkNPushPChar;
 Var
  Msg:String;
 Begin
  PSkipSpcInLn(I,PC);EM:=No;
  Msg:=PXtrkPasStr(I,PC,EM);
  IncStr(Msg,#0);
  _SetAbsRec(HandleRLL,PF,Length(Msg),Msg[1]);
  Inc(PF,Length(Msg));
  PSkipSpcInLn(I,PC);
 End;

 Function _SkipVirgule(Message:Boolean):Boolean;Begin
  _SkipVirgule:=True;
  PSkipSpcInLn(I,PC);
  If PStrI(I,PC)<>','Then Begin
   If(Message)Then ErrorNo(VirguleExpected);
   _SkipVirgule:=False;
   Exit;
  End;
  Inc(I);
  PSkipSpcInLn(I,PC);
 End;

 Function SkipVirgule:Boolean;Begin
  SkipVirgule:=_SkipVirgule(True);
 End;

 Function SkipMoins:Boolean;Begin
  SkipMoins:=True;
  PSkipSpcInLn(I,PC);
  If PStrI(I,PC)<>'-'Then Begin
   ErrorNo(MinusExpected);
   SkipMoins:=False;
   Exit;
  End;
  Inc(I);
  PSkipSpcInLn(I,PC);
 End;

 Function SkipDeuxPoint:Boolean;Begin
  SkipDeuxPoint:=True;
  PSkipSpcInLn(I,PC);
  If PStrI(I,PC)<>':'Then Begin
   ErrorNo(ColonExpected);
   SkipDeuxPoint:=False;
   Exit;
  End;
  Inc(I);
  PSkipSpcInLn(I,PC);
 End;

 Function SkipOpenPar:Boolean;Begin
  SkipOpenPar:=True;
  PSkipSpcInLn(I,PC);
  If PStrI(I,PC)<>'('Then Begin
   ErrorNo(OpenParExpected);
   SkipOpenPar:=False;
   Exit;
  End;
  Inc(I);
  PSkipSpcInLn(I,PC);
 End;

 Function SkipClosePar:Boolean;Begin
  SkipClosePar:=True;
  PSkipSpcInLn(I,PC);
  If PStrI(I,PC)<>')'Then Begin
   ErrorNo(CloseParExpected);
   SkipClosePar:=False;
   Exit;
  End;
  Inc(I);
  PSkipSpcInLn(I,PC);
 End;

 {$IFNDEF CONSOLE}
  Function GetStrTimeInPrg:String;
  Var
   Hour,Min,Sec:Wd;
   Time:LongInt;
  Begin
   Time:=Long(Long(GetRawTimer-TimeIn)*901)shr 14;
   If Time<>0Then Begin
    Hour:=Time div 360;
    Min:=Wd(Time div 60)mod 60;
    Sec:=Time mod 60
   End
    Else
   Begin
    Hour:=0;Min:=0;Sec:=0;
   End;
   GetStrTimeInPrg:=CStrTimeDos(Hour,Min,Sec)
  End;

  Procedure PutInfo;Begin
   W.Y:=2;
   WEPutTxtLn(W,'Programme principal            = '+Path2NoDir(Path));
   WEPutTxtLn(W,'Source courante                = '+Path2NoDir(Path));
   WEPutTxtLn(W,'Nom du programme de sortie     = '+Path2NoDir(Target));
   WEPutTxtLn(W,'Nombre de ligne(s) compil�     = '+CStr(NL));
   WEPutTxtLn(W,'Nombre d''index(s)              = '+CStr(NmIndex));
   WEPutTxtLn(W,'Nombre de police(s)            = '+CStr(BankFont));
   WEPutTxtLn(W,'Nombre de code machine DPU     = '+CStr(SizeRLL));
   WEPutTxtLn(W,'M굆oire disponible en octet(s) = '+CStr(MemAvail));
   WEPutTxtLn(W,'Temps de compilation           = '+GetStrTimeInPrg);
  End;
 {$ENDIF}

 Function ReadLine:Boolean;
 Var
  XT:Byte;
 Begin
  ReadLine:=True;
  {$IFNDEF Console}
   XT:=GetRawTimerB and$F8;
   If(XT<>OldTime)Then Begin
    PutInfo;
    OldTime:=XT;
   End;
   If(Q<>NIL)Then Begin
    PC:=_ALGetCurrBuf(Edit^.List);
    ALNext(Edit^.List);
    Inc(FP,StrLen(@PC));
   End
    Else
  {$ENDIF}
  Begin
   __GetAbsFilePTxtLn(Handle,FP,@PStr,SizeOf(PStr));
   If GetSysErr<>0Then Begin
    ErrorNo(GetSysErr);
    ReadLine:=False;
    Exit;
   End;
  End;
  Inc(NL);
  I:=0;
  PSkipSpcInLn(I,PC);
 End;

 Function EOF:Boolean;Begin
  If(Q<>NIL)Then EOF:=NL>=Edit^.List.Count
            Else EOF:=FP>=FS;
 End;

Begin
 MakeRLLFile:=$FFFF;BankFont:=0;NmIndex:=0;NoErr:=False;
 PF:=0;FP:=0;ModeFont:=mfNone;CBF:=0;NL:=0;PC:=@PStr;
 {$IFNDEF CONSOLE}
  OldTime:=$FF;SizeRLL:=0;
  FillClr(W,SizeOf(W));
 {$ENDIF}
 DBOpenServerName(ChantalServer,'CHANTAL:/Compilateur/CRLL/Instruction.Dat');
 If Not DBCopyToMemory(ChantalServer,Instr)Then Begin
  ErrorNo(OutOfMemory);
  Exit;
 End;
 If Path=''Then Begin
  {$IFDEF CONSOLE}
   WriteLn('Erreur: Fichier ressource non sp괹ifi�!');
   Halt;
  {$ELSE}
   ErrNoMsgOk(ResFileNoSpecified);
   Exit;
  {$ENDIF}
 End;
 Handle:=FileOpen(Path,fmRead);
 If(Handle=errHdl)Then Begin
  {$IFDEF CONSOLE}
   WriteLn('Erreur: Fichier ',Path,' introuvable!');
   Halt;
  {$ELSE}
   ErrMsgOk('Fichier '+Path+' introuvable!');
   Exit;
  {$ENDIF}
 End;
 Target:=Path2NoExt(Path)+'.RLL';
 {$IFNDEF CONSOLE}
  WEInitO(W,55,15);
  WEPushWn(W);
  WEPutWnKrDials(W,'Compilation');
  WEBar(W);
  WELn(W);
  WEPutTxtLn(W,'릘at                           = Compilation');
  WEPutkHorDn(W,'Annuler');
  PutInfo;
  TimeIn:=GetRawTimer;
 {$ENDIF}
 If FileExist(Target)Then DeleteFile(Target);
 HandleRLL:=FileCreate(Target);
 SetFilePos(HandleRLL,0);
 _PutFileTxt(HandleRLL,'RL2'+#26);
 If(Q=NIL)Then FS:=FileSize(Handle)
 {$IFNDEF Console}
   Else
  Begin
   FS:=Edit^.FileSize;
   ALSetPtr(Edit^.List,0);
  End
 {$ENDIF};
 Repeat
  If Not(ReadLine)Then Goto BreakAll;
  If Not IsPChrEmpty(PC)Then Begin
   Word:=StrUp(PXtrkWord(I,PC));
   If DBLocateAbsIM(Instr,1,Word,[])Then Begin
    Case(Instr.CurrRec.Byte^)of
     $EF:Begin { BANKFONT }
      PSkipSpcInLn(I,PC);
      If PStrI(I,PC)='='Then Inc(I);
      PSkipSpcInLn(I,PC);
      Msg:=PXtrkDecNm(I,PC);
      BankFont:=StrToWord(Msg)+1;
      PF:=BankFont*SizeOf(FontIndexRecord)+SizeOf(Long);
      SetFilePos(HandleRLL,0);
      _PutFileTxt(HandleRLL,'QQF'#26);
     End;
     $EE:Begin { NAME }
      FillClr(XFIR,SizeOf(XFIR));
      PSkipSpcInLn(I,PC);
      If PStrI(I,PC)='='Then Inc(I);
      PSkipSpcInLn(I,PC);
      If PStrI(I,PC)<>'"'Then Begin
       MakeRLLFile:=GuillExpected;
       Goto BreakAll;
      End;
      Inc(I);Str:=StrPas(PC);
      Inc(I);XFIR.Name:=Copy(Str,I,Length(Str)-I);
     End;
     $ED:Begin { HEIGHT }
      PSkipSpcInLn(I,PC);
      If PStrI(I,PC)='='Then Inc(I);
      PSkipSpcInLn(I,PC);
      Msg:=PXtrkDecNm(I,PC);
      XFIR.Height:=StrToWord(Msg);
      XFIR.PosAbs:=PF;
      _SetAbsRec(HandleRLL,CBF*SizeOf(XFIR)+SizeOf(Long),SizeOF(XFIR),XFIR);
      Inc(CBF);
     End;
     $EC:Begin { IMAGEBIN }
      ModeFont:=mfImageBin;
      FillClr(MtxPos,SizeOf(MtxPos));
      FM:=PF;LP:=512;Inc(PF,512);
     End;
     $01:Begin { SIZE }
      PSkipSpcInLn(I,PC);
      If PStrI(I,PC)<>':'Then Begin
       ErrorNo(ColonExpected);
       Goto BreakAll;
      End;
      Inc(I);
      PSkipSpcInLn(I,PC);
      Msg:=PXtrkDecNm(I,PC);
      SzX:=StrToWord(Msg);
      If PStrI(I,PC)<>','Then Begin
       ErrorNo(VirguleExpected);
       Goto BreakAll;
      End;
      Inc(I);
      PSkipSpcInLn(I,PC);
      Msg:=PXtrkDecNm(I,PC);
      SzY:=StrToWord(Msg);
      If(ModeFont=mfMatrix)Then Begin
       If PStrI(I,PC)<>':'Then Begin
        ErrorNo(ColonExpected);
        Goto BreakAll;
       End;
       Inc(I);
       Msg:=PXtrkDecNm(I,PC);
       SzH:=StrToWord(Msg);
       _SetAbsRec(HandleRLL,PF,1,SzX);Inc(PF,1);Inc(LP,1);
       _SetAbsRec(HandleRLL,PF,1,SzY);Inc(PF,1);Inc(LP,1);
       _SetAbsRec(HandleRLL,PF,1,SzH);Inc(PF,1);Inc(LP,1);
      End
       Else
      Begin
       _SetAbsRec(HandleRLL,PF,2,SzX);Inc(PF,2);Inc(LP,2);
       _SetAbsRec(HandleRLL,PF,2,SzY);Inc(PF,2);Inc(LP,2);
      End;
     End;
     $EB:Begin { MATRIX }
      PSkipSpcInLn(I,PC);
      Msg:=PXtrkDecNm(I,PC);
      MtxPos[Byte(StrToWord(Msg))]:=LP;ModeFont:=mfMatrix;
      _SetAbsRec(HandleRLL,FM,SizeOf(MtxPos),MtxPos);
     End;
     $F9:Begin { END }
      Case(ModeFont)of
       mfNone:Begin
        MakeRLLFile:=MisplacedEndSymbol;
        Goto BreakAll;
       End;
       mfMatrix:Begin
        XFIR.Size:=LP;
        _SetAbsRec(HandleRLL,(CBF-1)*SizeOf(XFIR)+SizeOf(Long),SizeOF(XFIR),XFIR);
       End;
      End;
      ModeFont:=mfNone;
     End;
     $EA:Begin { BIN }
      Case(ModeFont)of
       mfNone:Begin
        MakeRLLFile:=SyntaxError;
        Break;
       End;
       mfMatrix,mfImageBin:Begin
        PSkipSpcInLn(I,PC);
        If PStrI(I,PC)<>':'Then Begin
         MakeRLLFile:=ColonExpected;
         Goto BreakAll;
        End;
        Repeat
         Inc(I);
         PSkipSpcInLn(I,PC);
         Msg:=PXtrkBinNm(I,PC);DB:=BinStr2Nm(Msg);
         _SetAbsRec(HandleRLL,PF,1,DB);Inc(PF,1);Inc(LP,1);
         PSkipSpcInLn(I,PC)
        Until PStrI(I,PC)<>','
       End;
      End;
     End;
     $E9:Begin { NUMBERINDEX }
      PSkipSpcInLn(I,PC);
      If PStrI(I,PC)='='Then Inc(I);
      PSkipSpcInLn(I,PC);
      Msg:=PXtrkDecNm(I,PC);
      NmIndex:=StrToWord(Msg);
      PF:=(NmIndex+2)*SizeOf(Long);
     End;
     $E8:Begin { INDEXMSG }
      PSkipSpcInLn(I,PC);
      Index2Set:=StrToWord(PXtrkDecNm(I,PC));
      If(Index2Set>=NmIndex)Then Begin
       ErrorNo(OverloadIndex);
       Goto BreakAll;
      End;
      PSkipSpcInLn(I,PC);
      If PStrI(I,PC)=','Then Inc(I);
      PSkipSpcInLn(I,PC);
      Msg:=PXtrkPasStr(I,PC,Ok);
      SetRec(HandleRLL,Index2Set+1,SizeOf(PF),PF);
      IncStr(Msg,#0);
      _SetAbsRec(HandleRLL,PF,Length(Msg),Msg[1]);
      Inc(PF,Length(Msg));
     End;
     $E7:Begin { INDEXMENUCONTEXT }
      PSkipSpcInLn(I,PC);
      Index2Set:=StrToWord(PXtrkDecNm(I,PC));
      If(Index2Set>=NmIndex)Then Begin
       ErrorNo(OverloadIndex);
       Goto BreakAll;
      End;
      SetRec(HandleRLL,Index2Set+1,SizeOf(PF),PF);
      Repeat
       If Not(ReadLine)Then Begin
        MakeRLLFile:=errEdtRead;
        Break;
       End;
       Word:=StrUp(PXtrkWord(I,PC));
       If Word='END'Then Begin
        PSkipSpcInLn(I,PC);
        Word:=StrUp(PXtrkWord(I,PC));
        If Word='GROUP'Then PushByte(6)Else{ Teste FIN GROUP}
        If Word='IF'Then PushByte(9){ Teste FIN SI}
         Else
        Begin
          { Code de fin }
         PushByte(0);
         Break;
        End;
       End
        Else
       If Word='GROUP'Then Begin
        PSkipSpcInLn(I,PC);
        Word:=StrUp(PXtrkWord(I,PC));
        If Word='ITEM'Then Begin
         PSkipSpcInLn(I,PC);
          { Group Item }
         Msg:=PXtrkHexNm(I,PC);
         If Msg<>''Then Begin
          PushByte($15);
          DW:=HexStrToInt(Msg);
          If PStrI(I,PC)='h'Then Inc(I);
          PSkipSpcInLn(I,PC);
          _SetAbsRec(HandleRLL,PF,2,DW);Inc(PF,2);
          If PStrI(I,PC)<>','Then Begin
           ErrorNo(VirguleExpected);
           Goto BreakAll;
          End;
          Inc(I);
         End
          Else
         PushByte(5);
         XtrkNPushPChar;
         If PStrI(I,PC)<>','Then Begin
          Msg:='';
         End
          Else
         Begin
          Inc(I);
          PSkipSpcInLn(I,PC);
          EM:=False;
          Msg:=PXtrkPasStr(I,PC,EM);
         End;
         IncStr(Msg,#0);
         _SetAbsRec(HandleRLL,PF,Length(Msg),Msg[1]);
         Inc(PF,Length(Msg));
        End
         Else
        Begin
         ErrorNo(ItemExpected);
         Goto BreakAll;
        End;
       End
        Else
       If Word='ITEM'Then Begin
        PSkipSpcInLn(I,PC);
        If PStrI(I,PC)='-'Then PushByte(1){ Barre item }
         Else
        Begin
         PSkipSpcInLn(I,PC);
         Msg:=PXtrkHexNm(I,PC);
         DW:=HexStrToInt(Msg);
         If PStrI(I,PC)='h'Then Inc(I);
         PSkipSpcInLn(I,PC);
         If PStrI(I,PC)=';'Then Begin
          Inc(I);
          PSkipSpcInLn(I,PC);
           { Item avec cl� }
          PushByte(4);
          _SetAbsRec(HandleRLL,PF,2,DW);Inc(PF,2);
          EM:=False;
          Word:=StrUp(PXtrkWord(I,PC));
          If Word<>''Then Begin
           If Word='CTRLENTER'Then DW:=kbCtrlEnter Else
           If Word='CTRLINS'Then DW:=kbCtrlIns Else
           If Word='F1'Then DW:=kbF1 Else
           If Word='SHIFTINS'Then DW:=kbShiftIns
            Else
           Begin
            ErrorNo(IdentifierExpected);
            Goto BreakAll;
           End;
          End
           Else
          Begin
           Msg:=PXtrkPasStr(I,PC,EM);
           DW:=Byte(Msg[1]);
          End;
          If Not(SkipVirgule)Then Goto BreakAll;
         End
          Else
         Begin
          If PStrI(I,PC)<>','Then Begin
           ErrorNo(VirguleExpected);
           Goto BreakAll;
          End;
          Inc(I);
          PSkipSpcInLn(I,PC);
          Word:=StrUp(PXtrkWord(I,PC));
          If Word='BOOLEAN'Then Begin
           DB:=3; { Item avec switch }
           If Not(SkipVirgule)Then Goto BreakAll;
          End
           Else
          DB:=2; { Item normal }
          PushByte(DB);
         End;
         _SetAbsRec(HandleRLL,PF,2,DW);Inc(PF,2);
         XtrkNPushPChar;
         If PStrI(I,PC)<>','Then Msg:=''
          Else
         Begin
          Inc(I);
          PSkipSpcInLn(I,PC);EM:=No;
          Msg:=PXtrkPasStr(I,PC,EM);
         End;
         IncStr(Msg,#0);
         _SetAbsRec(HandleRLL,PF,Length(Msg),Msg[1]);
         Inc(PF,Length(Msg));
        End;
       End
        Else
       If Word='IF'Then Begin
         { Teste SI VRAI ALORS }
        PushByte($7);
        PSkipSpcInLn(I,PC);
        Word:=StrUp(PXtrkWord(I,PC));
        If Word<>'TRUE'Then Begin
         ErrorNo(TrueExpected);
         Goto BreakAll;
        End;
        PSkipSpcInLn(I,PC);
        Word:=StrUp(PXtrkWord(I,PC));
        If Word<>'THEN'Then Begin
         ErrorNo(ThenExpected);
         Goto BreakAll;
        End;
       End
        Else
       If Word='ELSE'Then PushByte($8)Else{ Teste SINON }
       If Word='MENU'Then Begin
        PushByte($A);
        XtrkNPushPChar;
       End;
      Until EOF;
     End;
     $E6:Begin { INDEXDIALOG }
      PSkipSpcInLn(I,PC);
      Index2Set:=StrToWord(PXtrkDecNm(I,PC));
      If(Index2Set>=NmIndex)Then Begin
       ErrorNo(OverloadIndex);
       Goto BreakAll;
      End;
      SetRec(HandleRLL,Index2Set+1,SizeOf(PF),PF);
      Repeat
       If Not(ReadLine)Then Begin
        MakeRLLFile:=errEdtRead;
        Break;
       End;
       If Not IsPChrEmpty(PC)Then Begin
        Word:=StrUp(PXtrkWord(I,PC));
        PSkipSpcInLn(I,PC);
        If DBLocateAbsIM(Instr,1,Word,[])Then Begin
         If Instr.CurrRec.Byte^<=$C0Then PushByte(Instr.CurrRec.Byte^);
         Param:=Pointer(Instr.CurrRec);
         _DBGotoColumnAbs(Instr.FieldRec,2,Pointer(Param));
         LenParam:=Length(Param^);
         If LenParam>0Then Begin
          OpenPar:=False;
          For JP:=1to(LenParam)do Begin
           ASM
            INC Word Ptr Param
           END;
           Case Param^[0]of
            #0:Break;
            '|':Begin
             PSkipSpcInLn(I,PC);
             If PStrI(I,PC)=')'Then Begin
              Inc(I);
              Break;
             End;
            End;
            ',':If Not(SkipVirgule)Then Goto BreakAll;
            '-':If Not(SkipMoins)Then Goto BreakAll;
            ':':If Not(SkipDeuxPoint)Then Goto BreakAll;
            '(':If Not(SkipOpenPar)Then Goto BreakAll;
            ')':If Not(SkipClosePar)Then Goto BreakAll;
            'B':XtrkNPushByte;
            'S':XtrkNPushStr;
            'W':XtrkNPushWord;
            Else Begin
             ErrorNo(ErrorParamInternal);
             Goto BreakAll;
            End;
           End;
          End;
         End;
         Case(Instr.CurrRec.Byte^)of
          $FE:Begin
           PSkipSpcInLn(I,PC);
           Word:=StrUp(PXtrkWord(I,PC));
           If Word='STRING'Then PushByte($19)
            Else
           Begin
            PushByte($09);
            XtrkNPushStr;
           End;
          End;
          $10:Begin { IF }
            { Teste SI VRAI ALORS }
           PSkipSpcInLn(I,PC);
           Word:=StrUp(PXtrkWord(I,PC));
           If Word<>'TRUE'Then Begin
            ErrorNo(TrueExpected);
            Goto BreakAll;
           End;
           PSkipSpcInLn(I,PC);
           Word:=StrUp(PXtrkWord(I,PC));
           If Word<>'THEN'Then Begin
            ErrorNo(ThenExpected);
            Goto BreakAll;
           End;
          End;
          $50:Begin { COPY MOVE }
           CopyMethode:=[];
           If Word<>'COPY'Then Include(CopyMethode,mcsMove);
           PushByte(Byte(CopyMethode));
          End;
          $87:Begin { LISTBOX }
           PSkipSpcInLn(I,PC);
           Word:=StrUp(PXtrkWord(I,PC));
           If Word='SHADOW'Then Begin
            If Not(SkipVirgule)Then Goto BreakAll;
            DB:=1;
           End
            Else
           DB:=0;
           PushByte(DB);
           XtrkNPushStr;
          End;
          $88:Begin { SCROLLBAR }
           If PStrI(I,PC)<>','Then DB:=0
            Else
           Begin
            Inc(I);
            PSkipSpcInLn(I,PC);
            Word:=StrUp(PXtrkWord(I,PC));
            If Word='FALSE'Then DB:=1 Else
            If Word='TRUE'Then DB:=0;
           End;
           PushByte(DB);
          End;
          $8B:Begin { COLORGRID }
           PSkipSpcInLn(I,PC);
           If PStrI(I,PC)<>','Then Begin
            PushByte(16);
            PushByte(1);
            PushByte(0);
           End
            Else
           Begin
            Inc(I);
            XtrkNPushByte;
            If Not(SkipVirgule)Then Goto BreakAll;
            XtrkNPushByte;
            If Not(SkipVirgule)Then Goto BreakAll;
            Word:=StrUp(PXtrkWord(I,PC));
            If(Word='TRUE')or(Word='PALETTE')Then DB:=1
                                             Else DB:=0;
            PushByte(DB);
            PSkipSpcInLn(I,PC);
           End;
          End;
          $B0:Begin { SECTORIAL }
           LenBnkClr:=0;
           Repeat
            BnkClr[LenBnkClr]:=XtrkByte;
            Inc(LenBnkClr);
           Until Not(_SkipVirgule(No));
           PushByte(LenBnkClr);
           For J:=0to LenBnkClr-1do PushByte(BnkClr[J]);
          End;
          $F0,$F1:Begin { INPUT - CAPTION }
           If Word='INPUT'Then DB2:=0
                          Else DB2:=1;
           Word:=StrUp(PXtrkWord(I,PC));
           If(DB2=1)and(Word='COPY')Then Begin
             { CAPTION COPY (X1,Y1),(X2,Y2),(X3,Y3),(X4,Y4) }
            PushByte($4F);
            If Not(SkipOpenPar)Then Goto BreakAll;
            XtrkNPushByte;
            If Not(SkipVirgule)Then Goto BreakAll;
            XtrkNPushByte;
            If Not(SkipClosePar)Then Goto BreakAll;
            If Not(SkipVirgule)Then Goto BreakAll;
            If Not(SkipOpenPar)Then Goto BreakAll;
            XtrkNPushByte;
            If Not(SkipVirgule)Then Goto BreakAll;
            XtrkNPushByte;
            If Not(SkipClosePar)Then Goto BreakAll;
            If Not(SkipVirgule)Then Goto BreakAll;
            If Not(SkipOpenPar)Then Goto BreakAll;
            XtrkNPushByte;
            If Not(SkipVirgule)Then Goto BreakAll;
            XtrkNPushByte;
            If Not(SkipClosePar)Then Goto BreakAll;
            If Not(SkipVirgule)Then Goto BreakAll;
            If Not(SkipOpenPar)Then Goto BreakAll;
            XtrkNPushByte;
            If Not(SkipVirgule)Then Goto BreakAll;
            XtrkNPushByte;
            If Not(SkipClosePar)Then Goto BreakAll;
           End
            Else
           Begin
            If Word='EXTERN'Then Begin
             Inc(DB2,$20);
             PSkipSpcInLn(I,PC);
             Word:=StrUp(PXtrkWord(I,PC));
            End;
            If Word='BYTE'Then DB:=$81 Else { WEAddInputByte }
            If Word='WORD'Then DB:=$82 Else { WEAddInputWord }
            If Word='LONG'Then DB:=$83 Else { WEAddInputLong }
            If Word='REAL'Then DB:=$84 Else { WEAddInputReal }
            If Word='STRING'Then DB:=$86 Else { WEAddInputString }
            If Word='COUNTRY'Then DB:=$80 Else
            If Word='FILE'Then Begin
             DB:=$89;
            End
             Else
            Begin
             ErrorNo(IdentifierExpected);
             Goto BreakAll;
            End;
            Case(DB2)of
             1:Dec(DB,$40); { Caption? }
             $20:Begin
              Inc(DB,$20);{ Extern? }
              DB2:=0;
             End;
            End;
            PushByte(DB);
            If Not(SkipOpenPar)Then Goto BreakAll;
            XtrkNPushByte;
            If PStrI(I,PC)=')'Then PushByte($FF)
             Else
            Begin
             If Not(SkipVirgule)Then Goto BreakAll;
             XtrkNPushByte;
             If DB2=0Then Begin
              If Not(SkipVirgule)Then Goto BreakAll;
              XtrkNPushByte;
             End;
            End;
            If Not(SkipClosePar)Then Goto BreakAll;
            If Not(SkipVirgule)Then Goto BreakAll;
            XtrkNPushByte;
            If DB<>$80Then Begin
             If DB2=0Then Begin
              If PStrI(I,PC)<>','Then PushByte(0) { Cha똭e de cl� vide }
               Else
              Begin
               Inc(I);
               XtrkNPushStr;
              End;
             End;
            End;
           End;
          End;
          $F2:Begin { WINDOWCOLORCLASSIC }
           Word:=StrUp(PXtrkWord(I,PC));
           If Word='CAPTION'Then Begin
            PushByte($0D);
           End
            Else
           Begin
            PushByte($02);
            XtrkNPushStr;
           End;
          End;
          $F7:Begin { CLICKBOX/CHECKBOX }
           PSkipSpcInLn(I,PC);
           Word:=StrUp(PXtrkWord(I,PC));
           If Word<>''Then Begin
            If Word='EXTERN'Then DB:=$6F
             Else
            Begin
             ErrorNo(ExternCallExpected);
             Goto BreakAll;
            End;
            PSkipSpcInLn(I,PC);
           End
            Else
           DB:=$8F;
           PushByte(DB);
           If PStrI(I,PC)='('Then Begin
            Inc(I);
            XtrkNPushByte;
            If Not(SkipVirgule)Then Goto BreakAll;
            XtrkNPushByte;
            If Not(SkipClosePar)Then Goto BreakAll;
            If Not(SkipVirgule)Then Goto BreakAll;
            Msg:=PXtrkDecNm(I,PC);
            If Msg=''Then PushByte(0)
             Else
            Begin
             DB:=StrToWord(Msg);
             PushByte(DB);
             If Not(SkipVirgule)Then Goto BreakAll;
            End;
           End
            Else
           Begin
            PushByte(0);
            PushByte(0);
            PushByte(0);
           End;
           XtrkNPushStr;
          End;
          $F8:Begin { RADIOBUTTON }
           Word:=StrUp(PXtrkWord(I,PC));
           If Word<>''Then Begin
            If Word='EXTERN'Then DB:=$6D
             Else
            Begin
             ErrorNo(ExternCallExpected);
             Goto BreakAll;
            End;
            PSkipSpcInLn(I,PC);
           End
            Else
           DB:=$8D;
           PushByte(DB);
           If Not(SkipOpenPar)Then Goto BreakAll;
           XtrkNPushByte;
           If Not(SkipVirgule)Then Goto BreakAll;
           XtrkNPushByte;
           If Not(SkipClosePar)Then Goto BreakAll;
           If Not(SkipVirgule)Then Goto BreakAll;
           PSkipSpcInLn(I,PC);
           Msg:=PXtrkDecNm(I,PC);
           If Msg=''Then PushByte(0)
            Else
           Begin
            DB:=StrToWord(Msg);
            PushByte(DB);
            If Not(SkipVirgule)Then Goto BreakAll;
           End;
           XtrkNPushStr;
           If Not(SkipVirgule)Then Goto BreakAll;
           XtrkNPushStr;
          End;
          $F9:Begin
           Word:=StrUp(PXtrkWord(I,PC));
           If Word='LIST'Then PushByte($72)Else { Teste FIN LIST }
           If Word='IF'Then PushByte($12) { Teste FIN SI}
            Else
           Begin
             { Code de fin }
            PushByte(0);
            Break;
           End;
          End;
          $FA:Begin { TEXT }
           Msg:=PXtrkDecNm(I,PC);
           If Msg=''Then PushByte(6) { WEPutTextLn }
            Else
           Begin
            DB:=StrToWord(Msg);
            If Not(SkipVirgule)Then Goto BreakAll;
            Msg:=PXtrkDecNm(I,PC);
            If Msg=''Then DB2:=8 { WEPutTextX }
             Else
            Begin
             DB2:=7; { WEPutTextXY }
             PushByte(DB2);
             If Not(SkipVirgule)Then Goto BreakAll;
             DB2:=DB;DB:=StrToWord(Msg);
            End;
            PushByte(DB2);
            PushByte(DB);
           End;
           XtrkNPushStr;
          End;
          $FB:Begin { GHOST }
           Word:=StrUp(PXtrkWord(I,PC));
           If Word='BYTE'Then DB:=$91 Else { Byte }
           If Word='WORD'Then DB:=$92 Else { Word }
           If Word='LONG'Then DB:=$93 Else { Long }
           If Word='REAL'Then DB:=$94 Else { Real }
           If Word='STRING'Then DB:=$96    { String }
            Else
           Begin
            ErrorNo(IdentifierExpected);
            Goto BreakAll;
           End;
           PushByte(DB);
          End;
          $FC:Begin { EXTERNAL }
           Word:=StrUp(PXtrkWord(I,PC));
           If Word='PREPARATION'Then DB:=$70 Else
           If Word='PROCESSUS'Then DB:=$71
            Else
           Begin
            ErrorNo(ValidIdentificatorExpected);
            Goto BreakAll;
           End;
           PushByte(DB);
          End;
          $FD:Begin { SIMPLE }
           Word:=StrUp(PXtrkWord(I,PC));
           If Word='GRID'Then Begin
            PushByte($0A);
            If Not(SkipOpenPar)Then Goto BreakAll;
            XtrkNPushByte;
            If Not(SkipVirgule)Then Goto BreakAll;
            XtrkNPushByte;
            If Not(SkipClosePar)Then Goto BreakAll;
            If Not(SkipVirgule)Then Goto BreakAll;
            XtrkNPushByte;
           End
            Else
           Begin
            ErrorNo(ValidIdentificatorExpected);
            Goto BreakAll;
           End;
          End;
         End;
        End
         Else
        If Not((PC^[I]='/')and(PC^[I+1]='/'))Then Begin
         ErrorNo(SyntaxError);
         Goto BreakAll;
        End;
       End;
      Until EOF;
     End;
     $E5:Begin { INDEXREC }
      PSkipSpcInLn(I,PC);
      Index2Set:=StrToWord(PXtrkDecNm(I,PC));
      If(Index2Set>=NmIndex)Then Begin
       ErrorNo(OverloadIndex);
       Goto BreakAll;
      End;
      SetRec(HandleRLL,Index2Set+1,SizeOf(PF),PF);
      Repeat
       If Not(ReadLine)Then Begin
        MakeRLLFile:=errEdtRead;
        Break;
       End;
       Word:=StrUp(PXtrkWord(I,PC));
       If Word='END'Then Break;
       If Word='STRING'Then Begin
        If PStrI(I,PC)<>':'Then Begin
         ErrorNo(ColonExpected);
         Goto BreakAll;
        End;
        Inc(I);
        Msg:=PXtrkPasStr(I,PC,EM);
        _SetAbsRec(HandleRLL,PF,Length(Msg)+1,Msg);
        Inc(PF,Length(Msg)+1);
       End
        Else
       If Word='BYTE'Then Begin
        If PStrI(I,PC)<>':'Then Begin
         ErrorNo(ColonExpected);
         Goto BreakAll;
        End;
        Inc(I);
        DB:=StrToWord(PXtrkDecNm(I,PC));
        _SetAbsRec(HandleRLL,PF,1,DB);
        Inc(PF);
       End
        Else
       If Word='HEXBYTE'Then Begin
        PSkipSpcInLn(I,PC);
        If PStrI(I,PC)<>':'Then Begin
         MakeRLLFile:=ColonExpected;
         Goto BreakAll;
        End;
        Repeat
         Inc(I);
         PSkipSpcInLn(I,PC);
         Msg:=PXtrkHexNm(I,PC);
         DB:=HexStrToInt(Msg);
         _SetAbsRec(HandleRLL,PF,1,DB);Inc(PF,1);Inc(LP,1);
         PSkipSpcInLn(I,PC)
        Until PStrI(I,PC)<>',';
       End
        Else
       If Not((StrI(I,Str)='/')and(StrI(I+1,Str)='/'))Then Begin
        ErrorNo(SyntaxErrorRec);
        Goto BreakAll;
       End;
      Until EOF;
     End;
     $E4:Begin { INDEXFILE }
      PSkipSpcInLn(I,PC);
      Index2Set:=StrToWord(PXtrkDecNm(I,PC));
      If(Index2Set>=NmIndex)Then Begin
       ErrorNo(OverloadIndex);
       Goto BreakAll;
      End;
      PSkipSpcInLn(I,PC);
      If PStrI(I,PC)=','Then Inc(I);
      PSkipSpcInLn(I,PC);
      SetRec(HandleRLL,Index2Set+1,SizeOf(PF),PF);
      Msg:=PXtrkPasStr(I,PC,EM);
      HandleLoad:=FileOpen(Msg,fmRead);
      If(HandleLoad<>errHdl)Then Begin
       FSL:=FileSize(HandleLoad);
       If FSL>65520Then Begin
        Buf:=MemAlloc(65520);
        If(Buf<>NIL)Then Begin
         ND:=FSL div 65520;NM:=FSL mod 65520;M:=0;
         For I:=0to ND-1do Begin
          _GetAbsRec(HandleLoad,M,65520,Buf^);
          _SetAbsRec(HandleRLL,PF,65520,Buf^);
          Inc(M,Long(65520));Inc(PF,Long(65520));
         End;
         If NM>0Then Begin
          _GetAbsRec(HandleLoad,M,NM,Buf^);
          _SetAbsRec(HandleRLL,PF,NM,Buf^);
          Inc(PF,Long(NM));
         End;
         FreeMemory(Buf,65520);
        End;
       End
        Else
       Begin
        Buf:=MemAlloc(FSL);
        If(Buf<>NIL)Then Begin
         GetRec(HandleLoad,0,FSL,Buf^);
         _SetAbsRec(HandleRLL,PF,FSL,Buf^);
         Inc(PF,FSL);
         FreeMemory(Buf,FSL);
        End;
       End;
       FileClose(HandleLoad);
      End;
     End;
     $E3:Begin { INDEXSQL }
      PSkipSpcInLn(I,PC);
      Index2Set:=StrToWord(PXtrkDecNm(I,PC));
      If(Index2Set>=NmIndex)Then Begin
       ErrorNo(OverloadIndex);
       Goto BreakAll;
      End;
      SetRec(HandleRLL,Index2Set+1,SizeOf(PF),PF);
      Repeat
       If Not(ReadLine)Then Begin
        MakeRLLFile:=errEdtRead;
        Break;
       End;
       Word:=PXtrkWord(I,PC);
       If StrUp(Word)='END'Then Break;
       Str:=Trim(StrPas(PC));
       _SetAbsRec(HandleRLL,PF,Length(Str),Str[1]);
       Inc(PF,Length(Str));
       PushByte(0);
       Inc(PF);
      Until EOF;
      PushByte(0);
      Inc(PF);
     End;
     $E2:Begin { INDEXASCII }
      PSkipSpcInLn(I,PC);
      Index2Set:=StrToWord(PXtrkDecNm(I,PC));
      If(Index2Set>=NmIndex)Then Begin
       ErrorNo(OverloadIndex);
       Goto BreakAll;
      End;
      SetRec(HandleRLL,Index2Set+1,SizeOf(PF),PF);
      Repeat
       If Not(ReadLine)Then Begin
        MakeRLLFile:=errEdtRead;
        Break;
       End;
       Word:=PXtrkWord(I,PC);
       If StrUp(Word)='END'Then Break;
       Str:=StrPas(PC);
       _SetAbsRec(HandleRLL,PF,Length(Str),Str[1]);
       Inc(PF,Length(Str));
       _SetAbsRec(HandleRLL,PF,2,CRLF[1]);
       Inc(PF,2);
      Until EOF;
      _SetAbsRec(HandleRLL,PF,2,CRLF[1]);
      Inc(PF,2);
     End;
     $E1:Begin { COPYRIGHT }
      PSkipSpcInLn(I,PC);
      Msg:=PXtrkPasStr(I,PC,Ok);
      _SetAbsRec(HandleRLL,PF,Length(Msg),Msg[1]);
      Inc(PF,Length(Msg));
     End;
     Else UnknownInstr:If Not(PStrI(I,PC)in[#9,#10])Then Begin
      If Not((PStrI(I,PC)='/')and(PStrI(I+1,PC)='/'))Then Begin{ Ce n'est pas une remarque... }
       If Not IsPChrEmpty(PC)Then Begin
        {$IFDEF CONSOLE}
         WriteLn('Erreur: Erreur de syntaxe!');
         WriteLn('Ligne = "',PC^,'"');
        {$ELSE}
         ErrorNo(SyntaxError);
        {$ENDIF}
        Goto BreakAll;
       End;
      End;
     End;
    End;
   End
    Else
   Goto UnknownInstr;
  End;
 Until EOF;
 MakeRLLFile:=0;NoErr:=True;
BreakAll:
 {$IFDEF CONSOLE}
  WriteLn('Fichier: ',Path,', nombre de ligne compil괻 = ',NL);
 {$ENDIF}
 If BankFont=0Then SetRec(HandleRLL,NmIndex+1,SizeOf(PF),PF)
  Else
 Begin
  FillClr(XFIR,SizeOf(XFIR));
  XFIR.Name:='FIN';XFIR.PosAbs:=PF;
  _SetAbsRec(HandleRLL,CBF*SizeOf(XFIR)+SizeOf(Long),SizeOF(XFIR),XFIR);
 End;
 FileClose(HandleRLL);
 FileClose(Handle);
 If BankFont>0Then Begin
  Word:=Path2NoExt(Target)+'.QQF';
  DeleteFile(Word);
  RenameFile(Target,Word);
  Target:=Word;
 End;
 DBDispose(Instr);
 {$IFNDEF CONSOLE}
  If Not(NoErr)Then Begin
   TEGotoXY(Edit^,I,NL-1);
   If(Edit^.InsMode)Then SimpleCur
                    Else FullCur;
   __ShowMousePtr;
   _InitKbd;
   Repeat
    _BackKbd;
   Until KeyPress;
   __HideMousePtr;
  End
   Else
  Begin
   WEPutTxtXY(W,33,1,StrUSpc('Terminer.',32));
   SizeRLL:=GetFileSize(Target);
   PutInfo;
   While WEOk(W)do;
   WEDone(W);
  End;
 {$ENDIF}
End;

