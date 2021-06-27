Unit PCUnit;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                  INTERFACE
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses Systex;

Procedure DumpUnitProc(Const ProcName:String);
Function  GetUnitName(UnitNum:Word):String;
Procedure MakeHeaderUnit(Const Name:String);
Function  UnitInList(Const Name:String):Boolean;
Function  UnitListNum(Const Name:String):Word;
Function  UnitUpgrade(Const Name:String):Boolean;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                 IMPLEMENTATION
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses PCCortex,Systems{$IFDEF IDE},Dials{$ENDIF};

Procedure MakeHeaderUnit(Const Name:String);
Type
 DuplProcDataRec=Record
  FP:Long;
  Name:String;
 End;
Var
 UnitHeader:UnitHeaderRec;
 Handle:Hdl;
 StartPos:Word;
 FP:LongInt;
 DuplProc:RBuf;
 SRT:SearchRec;

 Function GetConst(Min,Max:Word):LongInt;
 Var
  X,HeadSize,DataSize,Size:Word;
  TS:String;
  PCst:^CstRec;
  UnitCst:UnitCstRec;
  MyPos:LongInt;
 Begin
  X:=((Max-Min)shr 1)+Min;
  PCst:=_RBGetBuf(ReDef,X);
  If(Not(PCst^.Free))and(Min<=Max)and(X<ReDef.NB)Then Begin
   PCst^.Free:=Ya;
   UnitCst.TypeDef:=PCst^.Q.TypeDef;
   UnitCst.Name:=PCst^.Name;
   GetConst:=FP;MyPos:=FP;
   HeadSize:=SizeOf(UnitCstRec)-255+Length(PCst^.Name);
   DataSize:=DefTypeSize[Ord(PCst^.Q.TypeDef)];
   If(PCst^.Q.TypeDef=tString)Then DataSize:=PCst^.Q.X.ArrayByte^[0]+1;
   Size:=HeadSize+DataSize;
   Inc(FP,Size);
   UnitCst.Gauche:=GetConst(Min,X-1);
   UnitCst.Droite:=GetConst(X+1,Max);
   _SetAbsRec(Handle,MyPos,HeadSize,UnitCst);
   Case(PCst^.Q.TypeDef)of
    tBool,tByte,tShort,tChar:_SetAbsRec(Handle,MyPos+HeadSize,1,PCst^.Q.X.DataByte);
    tWord,tInt:_SetAbsRec(Handle,MyPos+HeadSize,2,PCst^.Q.X.DataWord);
    tLong:_SetAbsRec(Handle,MyPos+HeadSize,4,PCst^.Q.X.DataLong);
    Else _SetAbsRec(Handle,MyPos+HeadSize,DataSize,PCst^.Q.X.Buf^);
   End;
  End
   Else
  GetConst:=0
 End;

 Function GetType(Min,Max:Word):LongInt;
 Var
  X,HeadSize,DataSize,Size:Word;
  PType:^TypeMainRec;
  UnitType:UnitTypeRec;
  MyPos:LongInt;
  Box:Word;

  Procedure Sub(Var Pile:RBuf);Var VType:^TypeRec;I:RBP;Begin
   RBSetPtr(Pile,0);
   For I:=0to Pile.NB-1do Begin
    VType:=_RBGetCurrBuf(Pile);
    If Box>0Then Begin
     _SetAbsRec(Handle,FP,Length(VType^.Name)+1,VType^.Name);
     Inc(FP,Length(VType^.Name)+1);
    End;
    Case(VType^.TypeDef)of
     tArray:Begin
      _SetAbsRec(Handle,FP,SizeOf(Word),VType^.Min);
      Inc(FP,SizeOf(Word));
      _SetAbsRec(Handle,FP,SizeOf(Word),VType^.Max);
      Inc(FP,SizeOf(Word));
      _SetAbsRec(Handle,FP,SizeOf(Byte),VType^.ArrayTypeDef);
      Inc(FP);
     End;
     tEnd:Begin
      If Box=0Then Exit;
      Dec(Box);
      Break;
     End;
     tRec:Begin
      Inc(Box);
      _SetAbsRec(Handle,FP,SizeOf(Byte),VType^.TypeDef);
      Inc(FP);
      Sub(VType^.Pile);
     End;
     Else Begin
      _SetAbsRec(Handle,FP,SizeOf(Byte),VType^.TypeDef);
      Inc(FP);
     End;
    End;
    RBNext(Pile);
   End;
  End;

 Begin
  X:=((Max-Min)shr 1)+Min;
  PType:=_RBGetBuf(TypeDef,X);
  If(Not(PType^.Free))and(Min<=Max)and(X<TypeDef.NB)Then Begin
   PType^.Free:=Ya;UnitType.Name:=PType^.Name;GetType:=FP;
   MyPos:=FP;HeadSize:=SizeOf(UnitTypeRec)-255+Length(PType^.Name);
   DataSize:=0;Size:=HeadSize+DataSize;Inc(FP,Size);Box:=0;
   Sub(PType^.Struct);
   Box:=0;
   _SetAbsRec(Handle,FP,SizeOf(Byte),Box);
   Inc(FP);
   UnitType.Gauche:=GetType(Min,X-1);
   UnitType.Droite:=GetType(X+1,Max);
   _SetAbsRec(Handle,MyPos,HeadSize,UnitType);
  End
   Else
  GetType:=0
 End;

 Function GetProc(Min,Max:Word):LongInt;
 Var
  X,HeadSize,DataSize,Size:Word;
  TS:String;
  PProc:^ProcRec;
  UnitProc:UnitProcRec;
  MyPos:LongInt;
  Reg:Byte;
  DuplData:DuplProcDataRec;
  PDupl:^DuplProcDataRec;
 Begin
  X:=((Max-Min)shr 1)+Min;
  PProc:=_RBGetBuf(ProcBk,X);
  If(Not(PProc^.Free))and(Min<=Max)and(X<ProcBk.NB)Then Begin
   PProc^.Free:=Ya;UnitProc.CurrPtr:=PProc^.CurrPtr;
   UnitProc.Name:=PProc^.Name;GetProc:=FP;MyPos:=FP;
   UnitProc.Dupl:=PProc^.Dupl;UnitProc.Func:=PProc^.Func;
   UnitProc.NmParam:=PProc^.Param.NB;
   If(UnitProc.Dupl)Then Begin
    DuplData.FP:=MyPos+13;
    DuplData.Name:=PProc^.Parent^.Name;
    PDupl:=RBAdd(DuplProc,SizeOf(DuplProcDataRec));
    If(PDupl=NIL)Then Exit;
    PDupl^:=DuplData;
   End;
   HeadSize:=SizeOf(UnitProcRec)-255+Length(PProc^.Name);
   DataSize:=(UnitProc.NmParam shl 1)+UnitProc.NmParam;
   If(UnitProc.Func)Then Inc(DataSize);
   Size:=HeadSize+DataSize;Inc(FP,Size);
   UnitProc.Gauche:=GetProc(Min,X-1);
   UnitProc.Droite:=GetProc(X+1,Max);
   _SetAbsRec(Handle,MyPos,HeadSize,UnitProc);
   If(UnitProc.Func)Then Begin
    _SetAbsRec(Handle,MyPos+HeadSize,1,PProc^.Return.TypeDef);
    Inc(HeadSize);
   End;
   If UnitProc.NmParam>0Then Begin
    RBSetPtr(PProc^.Param,0);
    Inc(MyPos,HeadSize);
    For X:=0to UnitProc.NmParam-1do Begin
     PVar:=_RBGetCurrBuf(PProc^.Param);
     _SetAbsRec(Handle,MyPos,1,PVar^.QParam);
     Inc(MyPos);
     _SetAbsRec(Handle,MyPos,1,PVar^.TypeDef);
     If(PProc^.ParamRegister)Then Reg:=PVar^.Reg Else Reg:=$FF;
     Inc(MyPos);
     _SetAbsRec(Handle,MyPos,1,Reg);
     Inc(MyPos);
     RBNext(PProc^.Param);
    End;
   End;
  End
   Else
  GetProc:=0
 End;

 Procedure UpDateDupl;
 Var
  I:Integer;
  PDupl:^DuplProcDataRec;
  P:LongInt;
  Proc:UnitProcRec;
 Begin
  RBSetPtr(DuplProc,0);
  For I:=0to DuplProc.NB-1do Begin
   PDupl:=_RBGetCurrBuf(DuplProc);
   If(PDupl<>NIL)Then Begin
    P:=UnitHeader.OffProc;
    _GetAbsRec(Handle,P,SizeOf(UnitProcRec),Proc);
    While(PDupl^.Name<>Proc.Name)do Begin
     If(PDupl^.Name<Proc.Name)Then P:=Proc.Gauche Else P:=Proc.Droite;
     If P=0Then Break;
     _GetAbsRec(Handle,P,SizeOf(UnitProcRec),Proc);
    End;
    If(PDupl^.Name=Proc.Name)Then
     _SetAbsRec(Handle,PDupl^.FP,SizeOf(LongInt),P);
   End;
   RBNext(DuplProc);
  End;
  RBDone(DuplProc)
 End;

 Procedure DumpVar;
 Var
  I:RBP;
  T:UnitVarRec;
  PVar:^VarRec;
  Size,HeadSize:Word;
 Begin
  If VarBk.NB>0Then Begin
   UnitHeader.OffVar:=FP;
   RBSetPtr(VarBk,0);
   For I:=0to VarBk.NB-1do Begin
    PVar:=_RBGetCurrBuf(VarBk);
    If(PVar<>NIL)Then Begin
     FillClr(T,SizeOf(T));
     HeadSize:=SizeOf(UnitVarRec)-255+Length(PVar^.Name);Size:=HeadSize;
     T.TypeDef:=PVar^.TypeDef;T.SegDes:=PVar^.SegDes;T.QParam:=PVar^.QParam;
     T.Volatile:=PVar^.Volatile;T.Size:=PVar^.Size;T.Name:=PVar^.Name;
     If(T.QParam=qConst)Then Inc(Size,T.Size);
     If I=VarBk.NB-1Then T.Suivant:=0 Else T.Suivant:=FP+Size;
     _SetAbsRec(Handle,FP,HeadSize,T);
     If(T.QParam=qConst)Then _SetAbsRec(Handle,FP+HeadSize,T.Size,PVar^.X);
     Inc(FP,Long(Size));
    End;
    RBNext(VarBk);
   End;
  End;
 End;

 Procedure WriteResWord;
 Var
  P:Pointer;
 Begin
  P:=MemAlloc(SizeResWord);
  If(P<>NIL)Then Begin
   GetFile('DATA.$$$',0,SizeResWord,P^);
   DeleteFile('DATA.$$$');
   _SetAbsRec(Handle,StartPos,SizeResWord,P^);
   FreeMem(P,SizeResWord);
  End;
 End;

Begin
 {$IFDEF IDE}
  WEPutTxtXY(WC,33,0,'Cr‚e l''entˆte de l''Unit‚');
 {$ELSE}
  WriteLn('Fabrication de l''entˆte de l''Unit‚ ',SuggName,' en cours...');
 {$ENDIF}
 FindFirst(SuggName+'.PAS',fa,SRT);
 RBInit(DuplProc);
 FillClr(UnitHeader,SizeOf(UnitHeader));
 StrPCopy(@UnitHeader.Sign,SignUnit);
 UnitHeader.ProgramFormat:=ProgramFormat;
 UnitHeader.NmConst:=ReDef.NB;UnitHeader.NmVar:=VarBk.NB;
 UnitHeader.NmProc:=ProcBk.NB;UnitHeader.Name:=SuggName;
 UnitHeader.NmType:=TypeDef.NB;
 UnitHeader.Date:=SRT.Time;
 StartPos:=SizeOf(UnitHeaderRec)-255+Length(UnitHeader.Name);FP:=StartPos;
 If(ResWordDef)Then Begin
  Inc(FP,SizeResWord);
 End;
 Handle:=NewNBak(Path2NoExt(Name)+'.UPC');
 If(Handle<>errHdl)Then Begin
  If(ResWordDef)Then Begin
   UnitHeader.ResWordFound:=Ya;
   UnitHeader.NmResWord:=NmResWord;
   UnitHeader.SizeResWord:=SizeResWord;
  End;
  UnitHeader.OffConst:=GetConst(0,ReDef.NB-1);
  UnitHeader.OffProc:=GetProc(0,ProcBk.NB-1);
  UnitHeader.OffType:=GetType(0,TypeDef.NB-1);
  UpDateDupl;
  DumpVar;
  _SetAbsRec(Handle,0,StartPos,UnitHeader);
  If(ResWordDef)Then Begin
   WriteResWord;
   ResWordDef:=No;NmResWord:=0;SizeResWord:=0;
  End;
  Inc(GhostConst,ReDef.NB);
  RBDone(ReDef);
  RBInit(ReDef);
  RBDone(ProcBk);
  RBInit(ProcBk);
  FileClose(Handle);
 End
  Else
 WriteLn('Erreur de cr‚ation de fichier!');
 {$IFDEF IDE}
  WEPutTxtXY(WC,33,0,StrUSpc('Compilation',30));
 {$ENDIF}
End;

Procedure DumpUnitProc(Const ProcName:String);
Var
 PC:PChr;
 Handle:Hdl;
 FP:Long;
 I,J:RBP;
 PX:^ExternVarRec;
 L:^Long;
 TS:String;
 Proc:UnitProcRec;
 X:Byte;
 Header:UnitHeaderRec;
 DataHomeProc:Record
  Len:Word;
  Suppl:Boolean;
 End;
Begin
 Handle:=FileOpen(SuggName+'.UPC',fmDef);
 If(Handle=errHdl)Then Exit;
 _GetAbsRec(Handle,0,SizeOf(Header),Header);
 If Header.NmProc>0Then Begin
  _GetAbsRec(Handle,Header.OffProc,SizeOf(UnitProcRec),Proc);
  While(ProcName<>Proc.Name)do Begin
   If(ProcName<Proc.Name)Then Header.OffProc:=Proc.Gauche Else Header.OffProc:=Proc.Droite;
   If Header.OffProc=0Then Break;
   _GetAbsRec(Handle,Header.OffProc,SizeOf(Proc),Proc);
  End;
  If(ProcName=Proc.Name)Then Begin
   FP:=FileSize(Handle);
   Proc.OffBody:=FP;
   _SetAbsRec(Handle,Header.OffProc,SizeOf(Proc)-SizeOf(String),Proc);
   DataHomeProc.Len:=IP;DataHomeProc.Suppl:=Bool(ExternVar.NB>0);
   _SetAbsRec(Handle,FP,SizeOf(DataHomeProc),DataHomeProc);
   Inc(FP,SizeOf(DataHomeProc));
   _SetAbsRec(Handle,FP,IP,CodePrg^);
   Inc(FP,IP);
   If ExternVar.NB>0Then Begin
    _SetAbsRec(Handle,FP,SizeOf(Word),ExternVar.NB);
    Inc(FP,SizeOf(Word));
    RBSetPtr(ExternVar,0);
    For I:=0to ExternVar.NB-1do Begin
     PX:=_RBGetCurrBuf(ExternVar);
     If(PX<>NIL)Then Begin
      _SetAbsRec(Handle,FP,Length(PX^.VarName)+1,PX^.VarName);
      Inc(FP,Length(PX^.VarName)+1);
      If PX^.UnitNum=$FFFFThen Begin
       X:=0;
       _SetAbsRec(Handle,FP,SizeOf(Byte),X);
       Inc(FP);
      End
       Else
      Begin
       TS:=GetUnitName(PX^.UnitNum);
       _SetAbsRec(Handle,FP,Length(TS)+1,TS);
       Inc(FP,Length(TS)+1);
      End;
      _SetAbsRec(Handle,FP,SizeOf(Word),PX^.BankAddr.NB);
      Inc(FP,SizeOf(Word));
      RBSetPtr(PX^.BankAddr,0);
      For J:=0to PX^.BankAddr.NB-1do Begin
       L:=_RBGetCurrBuf(PX^.BankAddr);
       If(L<>NIL)Then Begin
        _SetAbsRec(Handle,FP,SizeOf(Word),L^);
        Inc(FP,SizeOf(Word));
       End;
       RBNext(PX^.BankAddr);
      End;
     End;
     RBNext(ExternVar);
    End;
    RBDone(ExternVar);
    RBInit(ExternVar);
   End;
   FileClose(Handle);
   Exit;
  End;
 End;
 FileClose(Handle);
End;

Function UnitInList;
Var
 I:Integer;
 PC:PChr;
Begin
 UnitInList:=False;
 RBSetPtr(UnitList,0);
 For I:=0to UnitList.NB-1do Begin
  PC:=_RBGetCurrBuf(UnitList);
  If(PC=NIL)Then Exit;
  If Name=StrPas(PC)Then Exit;
  RBNext(UnitList);
 End;
 UnitInList:=True;
End;

Function UnitListNum(Const Name:String):Word;
Var
 I:Integer;
 PC:PChr;
Begin
 RBSetPtr(UnitList,0);
 For I:=0to UnitList.NB-1do Begin
  PC:=_RBGetCurrBuf(UnitList);
  If(PC=NIL)Then Exit;
  If Name=StrPas(PC)Then Begin
   UnitListNum:=I;
   Exit;
  End;
  RBNext(UnitList);
 End;
End;

Function GetUnitName(UnitNum:Word):String;Begin
 GetUnitName:=StrPas(_RBGetBuf(UnitList,UnitNum))
End;

Function UnitUpgrade(Const Name:String):Boolean;
Var
 Header:UnitHeaderRec;
 Handle:Hdl;
 SRT:SearchRec;
Begin
 UnitUpgrade:=True;
 If Not(MakeModifiedUnit)Then Exit;
 Handle:=FileOpen(Name+'.UPC',fmRead);
 If(Handle<>errHdl)Then Begin
  _GetAbsRec(Handle,0,SizeOf(Header),Header);
  FindFirst(Name+'.PAS',fa,SRT);
  If SysErr=0Then Begin
   If(BuildAll)Then UnitUpgrade:=False
               Else UnitUpgrade:=SRT.Time<>Header.Date;
  End;
  FileClose(Handle);
 End;
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
END.