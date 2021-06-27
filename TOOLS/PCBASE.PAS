{Gestion de la base de donn‚e}

Unit PCBase;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                  INTERFACE
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses Systex,PCCortex;

Type
 TempData=Record
  I:Byte;
  S,S3:String;
  FS,FP,NL:Long;
  UnitList:RBuf;
  ProgramFormat:ProgramFormatType;
  Handle:Hdl;
  {$IFDEF IDE}
   XEdt:Pointer;
  {$ENDIF}
 End;

Var StackPos,StackParam:Word;VarPosProc:Int;
    LastNameVar:String;LastUnitNum:Word;LastFP:Long;

Function  AddResWord(Const Name:String;Code:Word):Bool;
Procedure AddExternProcAddr(UnitNum:Word;FP,Addr:Long;Const Name:String);
Procedure AddExternVarAddr(UnitNum:Word;FP,Addr:Long;Const Name:String);
Function  AddJump(Access:AccessType;Off:Word;Const Nom:String):Bool;
Function  LocalVariable(X:SegDesType;QParam:QParamType):Int;
Function  GetOffVarGlobal(Const Nom:String):Integer;
Function  GetOffVarLocal(Const Nom:String):Integer;
Procedure MakeResWord;
Function  PtrProc(Const Name:String):ProcPtr;
Procedure RestoreData(Const Data:Pointer);
Function  SaveData:Pointer;
Function  SearchConstList(Const Name:String;Var Format:CstRec):Boolean;
Function  SearchJump(Const Nom:String;Access:AccessType):JumpPtr;
Function  SearchProcList(Const Name:String;Var UnitNum:Word;Var Addr:Long):Boolean;
Function  SearchVarList(Const Name:String;Var UnitNum:Word;Var Addr:Long):Boolean;
Function  SearchVarOnUnit(Const Name:String;UnitNum:Word;Var Addr:Long):Boolean;
Function  SearchTypeList(Const Name:String;Var UnitNum:Word;Var Addr:Long):Boolean;
Function  SearchPosProc(Const ProcName:String;Var Dupl:Bool):RBP;
Function  SearchPosConst(Var Dupl:Bool):RBP;
Function  SearchPosType(Var Dupl:Bool):RBP;
Procedure SwapString(Var Str1,Str2:String);
Function  Variable(X:SegDesType):Int;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                 IMPLEMENTATION
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses Systems,PCData,PCUnit;

Function OpenUnit(Const Name:String):Hdl;Begin
 OpenUnit:=FileOpen(Name+ExtFormat[fUnitTiny],fmRead)
End;

Function LocalVariable(X:SegDesType;QParam:QParamType):Integer;
Var
 VP:NoeudVarPasPtr;
 Present:Boolean;
Begin
  { Existe d‚j… ? }
 RBSetPtr(VarBk,VarPosProc);
 PVar:=_RBGetCurrBuf(VarBk);
 While(PVar<>NIL)do Begin
  If(PVar^.Name=S3)Then Begin
   LocalVariable:=VarDupl;
   Exit;
  End;
  RBNext(VarBk);
  PVar:=_RBGetCurrBuf(VarBk);
 End;
  { Identifie le type de variable...}
 LocalVariable:=0;PVar:=RBAdd(VarBk,SizeOf(ProcRec));
 If(PProc=NIL)Then Begin;LocalVariable:=OutOfMemory;Exit;End;
 PVar^.SegDes:=X;PVar^.Name:=S3;PVar^.Ofs:=StackPos;PVar^.QParam:=QParam;
 PVar^.Reg:=$FF;PVar^.SizeReg:=0;
 If S4=''Then Begin
  PVar^.TypeDef:=tNoType;PVar^.Size:=4;Inc(StackPos,4);
 End
  Else
 Begin
  VP:=SearchVarPas(S4);
  If(VP=NIL)Then Begin
   {Recherche dans l'unit‚/programme courant }
   SwapString(S3,S4);
   SearchPosType(Present);
   SwapString(S3,S4);
   If(Present)Then Begin
    PVar^.TypeDef:=tExtern;
    PVar^.ExternType:=_RBGetCurrBuf(TypeDef);
    If(PVar^.ExternType^.PointTo)Then PVar^.Size:=4
                                 Else PVar^.Size:=0;{...}
    Inc(StackPos,PVar^.Size);
   End
    Else
    {Recherche le type dans les unit‚s sp‚cifier...}
   If SearchTypeList(S4,PVar^.UnitNum,PVar^.OfsUnit)Then Begin
    PVar^.Size:=0;{...}
    Inc(StackPos,PVar^.Size);
   End
    Else
   LocalVariable:=UnknownIdentifier;
  End
   Else
  Begin
   PVar^.TypeDef:=VP^.TypeDef;
   If(QParam)in[qVar,qConst]Then Begin;PVar^.Size:=4;Inc(StackPos,4)End
    Else
   Begin
    PVar^.Size:=VP^.Size;
    If VP^.Size<=1Then Inc(StackPos,2)
                  Else Inc(StackPos,VP^.Size);
   End;
  End;
 End;
End;

Function GetOffVarGlobal(Const Nom:String):Integer;Begin
 GetOffVarGlobal:=-1;
 RBSetPtr(VarBk,0);
 PVar:=_RBGetCurrBuf(VarBk);
 While(PVar<>NIL)do Begin
  If(PVar^.Name=Nom)Then Begin
   If(ProgramFormat)in[fUnitTiny,fUnitLarge]Then GetOffVarGlobal:=0
   Else GetOffVarGlobal:=PVar^.Ofs;
   LastNameVar:=Nom;LastUnitNum:=$FFFF;
   Exit;
  End;
  RBNext(VarBk);
  PVar:=_RBGetCurrBuf(VarBk)
 End;
End;

Function GetOffVarLocal(Const Nom:String):Integer;Var Size,Home:Word;Begin
 GetOffVarLocal:=$7FFF;
 RBSetPtr(PProc^.Param,0);
 PVar:=_RBGetCurrBuf(PProc^.Param);
 While(PVar<>NIL)do Begin
  If(PVar^.Name=Nom)Then Begin
   If(PProc^.ParamRegister)and(PVar^.Reg<>$FF)Then GetOffVarLocal:=$7FFE
    Else
   Begin
    Size:=PVar^.Size;
    If Size<=1Then Size:=2;
    If(PVar^.QParam)in[qConst,qVar]Then Size:=4;
    If(PVar^.SegDes=vSSParam)Then Begin
     If(PProc^.CurrPtr=cmwpNear)Then Home:=4 Else Home:=6;
     GetOffVarLocal:=Home+(StackPos-(PVar^.Ofs+Size))
    End
     Else
    GetOffVarLocal:=2-(PVar^.Ofs+Size);
   End;
   Exit;
  End;
  RBNext(PProc^.Param);
  PVar:=_RBGetCurrBuf(PProc^.Param)
 End;
End;

Function AddJump(Access:AccessType;Off:Word;Const Nom:String):Bool;Begin
 AddJump:=No;
  { Existe d‚j… ? }
 If(Access=isLabel)Then Begin
  RBSetPtr(Jump,0);PJump:=_RBGetCurrBuf(Jump);
  While(PJump<>NIL)do Begin
   If(PJump^.Nom=Nom)and(PJump^.Access=isLabel)Then Exit;
   RBNext(Jump);
   PJump:=_RBGetCurrBuf(Jump);
  End;
 End;
  { Identifie le type de variable...}
 PJump:=RBAdd(Jump,SizeOf(JumpRec));
 If(PJump=NIL)Then Exit;
 PJump^.Access:=Access;PJump^.Nom:=Nom;
 PJump^.Off:=Off;PJump^.Setted:=NoSetted;
 AddJump:=Ya;
End;

Function SearchJump(Const Nom:String;Access:AccessType):JumpPtr;Var I:Word;TJump:JumpPtr;Begin
 SearchJump:=NIL;
 For I:=0to Jump.NB-1do Begin
  TJump:=_RBGetBuf(Jump,I);
  If(TJump<>NIL)and(TJump^.Access=Access)and(TJump^.Nom=Nom)Then Begin
   SearchJump:=TJump;
   Exit;
  End;
 End;
End;

Function Variable(X:SegDesType):Int;Var VP:NoeudVarPasPtr;Begin
  { Existe d‚j… ? }
 RBSetPtr(VarBk,0);PVar:=_RBGetCurrBuf(VarBk);
 While(PVar<>NIL)do Begin
  If(PVar^.Name=S3)Then Begin;Variable:=VarDupl;Exit;End;
  RBNext(VarBk);
  PVar:=_RBGetCurrBuf(VarBk);
 End;
  { Identifie le type de variable...}
 Variable:=0;PVar:=RBAdd(VarBk,SizeOf(ProcRec));
 If(PVar=NIL)Then Begin;Variable:=OutOfMemory;Exit;End;
 PVar^.SegDes:=X;PVar^.Name:=S3;PVar^.Ofs:=DP;
 VP:=SearchVarPas(S4);
 If(VP=NIL)Then Variable:=UnknownIdentifier
  Else
 Begin
  PVar^.TypeDef:=VP^.TypeDef;PVar^.Size:=VP^.Size;
  Inc(DP,VP^.Size)
 End;
End;

Function SearchPosProc(Const ProcName:String;Var Dupl:Bool):RBP;Var I:RBP;PProc:^ProcRec;Begin
 Dupl:=No;
 RBSetPtr(ProcBk,0);
 If ProcBk.NB=0Then SearchPosProc:=0
  Else
 Begin
  For I:=0to ProcBk.NB-1do Begin
   PProc:=_RBGetCurrBuf(ProcBk);
   If(PProc^.Name>ProcName)Then Begin
    RBPrevious(ProcBk);
    Dupl:=PProc^.Name=ProcName;SearchPosProc:=I;Exit;
   End;
   RBNext(ProcBk);
  End;
  SearchPosProc:=I+1;
 End;
End;

Function SearchPosConst(Var Dupl:Bool):RBP;Var I:RBP;PConst:^CstRec;Begin
 Dupl:=No;
 RBSetPtr(ReDef,0);
 If ReDef.NB=0Then SearchPosConst:=0
  Else
 Begin
  For I:=0to ReDef.NB-1do Begin
   PConst:=_RBGetCurrBuf(ReDef);
   If(PConst^.Name>S3)Then Begin
    RBPrevious(ReDef);
    Dupl:=PConst^.Name=S3;SearchPosConst:=I;Exit;
   End;
   RBNext(ReDef);
  End;
  SearchPosConst:=I+1;
 End;
End;

{ Cette fonction retourne la position o— se situe un type et indique s'il
 est d‚j… pr‚sent dans la liste.
}

Function SearchPosType(Var Dupl:Boolean):RBP;
Var
 I:RBP;
 PType:^TypeMainRec;
Begin
 Dupl:=False;
 RBSetPtr(TypeDef,0);
 If TypeDef.NB=0Then SearchPosType:=0
  Else
 Begin
  For I:=0to TypeDef.NB-1do Begin
   PType:=_RBGetCurrBuf(TypeDef);
   If(PType^.Name>=S3)Then Begin
    RBPrevious(TypeDef);
    Dupl:=PType^.Name=S3;SearchPosType:=I;Exit;
   End;
   RBNext(TypeDef);
  End;
  SearchPosType:=I+1;
 End;
End;

Function SearchConstList;
Var
 I:Integer;
 PC:PChr;
 Handle:Hdl;
 Cst:UnitCstRec;
 Header:UnitHeaderRec;
Begin
 SearchConstList:=No;
 For I:=UnitList.NB-1downto 0do Begin
  PC:=_RBGetBuf(UnitList,I);
  If(PC=NIL)Then Exit;
  Handle:=OpenUnit(StrPas(PC));
  If(Handle=errHdl)Then Exit;
  _GetAbsRec(Handle,0,SizeOf(Header),Header);
  If Header.NmConst>0Then Begin
   _GetAbsRec(Handle,Header.OffConst,SizeOf(Cst),Cst);
   While(Name<>Cst.Name)do Begin
    If(Name<Cst.Name)Then Header.OffConst:=Cst.Gauche Else Header.OffConst:=Cst.Droite;
    If Header.OffConst=0Then Break;
    _GetAbsRec(Handle,Header.OffConst,SizeOf(Cst),Cst);
   End;
   If(Name=Cst.Name)Then Begin
    Format.Name:=Name;Format.Q.TypeDef:=Cst.TypeDef;Format.Free:=Ya;
    _GetAbsRec(Handle,Header.OffConst+SizeOf(UnitCstRec)-255+Length(Cst.Name),
               SizeOf(XVariant),Format.Q.X);
    SearchConstList:=True;
    FileClose(Handle);
    Exit;
   End;
  End;
  FileClose(Handle);
 End;
End;

Function SearchProcList;
Var
 I:Integer;
 PC:PChr;
 Handle:Hdl;
 Proc:UnitProcRec;
 Header:UnitHeaderRec;
Begin
 SearchProcList:=No;
 For I:=UnitList.NB-1downto 0do Begin
  PC:=_RBGetBuf(UnitList,I);
  If(PC=NIL)Then Exit;
  Handle:=OpenUnit(StrPas(PC));
  If(Handle=errHdl)Then Exit;
  _GetAbsRec(Handle,0,SizeOf(Header),Header);
  If Header.NmProc>0Then Begin
   _GetAbsRec(Handle,Header.OffProc,SizeOf(Proc),Proc);
   While(Name<>Proc.Name)do Begin
    If(Name<Proc.Name)Then Header.OffProc:=Proc.Gauche
                      Else Header.OffProc:=Proc.Droite;
    If Header.OffProc=0Then Break;
    _GetAbsRec(Handle,Header.OffProc,SizeOf(Proc),Proc);
   End;
   If(Name=Proc.Name)Then Begin
    UnitNum:=I;
    Addr:=Header.OffProc;
    SearchProcList:=True;
    FileClose(Handle);
    Exit;
   End;
  End;
  FileClose(Handle);
 End;
End;

{ Cette fonction recherche dans les unit‚s le type sp‚cifier et retourne
 son adresse et son num‚ro d'unit‚.
}

Function SearchTypeList{Const Name:String;Var UnitNum:Word;Var Addr:Long):Boolean};
Var
 I,J:Integer;
 PC:PChr;
 Handle:Hdl;
 _Type:UnitTypeRec;
 Header:UnitHeaderRec;
Begin
 SearchTypeList:=False;
 For I:=UnitList.NB-1downto 0do Begin
  PC:=_RBGetBuf(UnitList,I);
  If(PC=NIL)Then Exit;
  Handle:=OpenUnit(StrPas(PC));
  If(Handle=errHdl)Then Exit;
  _GetAbsRec(Handle,0,SizeOf(Header),Header);
  If Header.NmType>0Then Begin
   _GetAbsRec(Handle,Header.OffType,SizeOf(_Type),_Type);
   While(Name<>_Type.Name)do Begin
    If(Name<_Type.Name)Then Header.OffType:=_Type.Gauche
                       Else Header.OffType:=_Type.Droite;
    If Header.OffType=0Then Break;
    _GetAbsRec(Handle,Header.OffType,SizeOf(_Type),_Type);
   End;
   If(Name=_Type.Name)Then Begin
    UnitNum:=I;
    Addr:=Header.OffType;
    SearchTypeList:=True;
    FileClose(Handle);
    Exit;
   End;
  End;
  FileClose(Handle);
 End;
End;

Function SearchVarList;
Var
 I,J:Integer;
 PC:PChr;
 Handle:Hdl;
 _Var:UnitVarRec;
 Header:UnitHeaderRec;
Begin
 SearchVarList:=False;
 For I:=UnitList.NB-1downto 0do Begin
  PC:=_RBGetBuf(UnitList,I);
  If(PC=NIL)Then Exit;
  Handle:=OpenUnit(StrPas(PC));
  If(Handle=errHdl)Then Exit;
  _GetAbsRec(Handle,0,SizeOf(Header),Header);
  If Header.NmVar>0Then Begin
   For J:=0to Header.NmVar-1do Begin
    _GetAbsRec(Handle,Header.OffVar,SizeOf(_Var),_Var);
    If(Name=_Var.Name)Then Begin
     UnitNum:=I;
     Addr:=Header.OffVar;
     SearchVarList:=True;
     FileClose(Handle);
     Exit;
    End;
    Header.OffVar:=_Var.Suivant;
    If Header.OffVar=0Then Break;
   End;
  End;
  FileClose(Handle);
 End;
End;

Function SearchVarOnUnit;
Var
 PC:PChr;
 Handle:Hdl;
 _Var:UnitVarRec;
 Header:UnitHeaderRec;
Begin
 SearchVarOnUnit:=False;
 Handle:=OpenUnit(GetUnitName(UnitNum));
 If(Handle=errHdl)Then Exit;
 _GetAbsRec(Handle,0,SizeOf(Header),Header);
 If Header.NmVar>0Then Begin
  For I:=0to Header.NmVar-1do Begin
   _GetAbsRec(Handle,Header.OffVar,SizeOf(_Var),_Var);
   If(Name=_Var.Name)Then Begin
    Addr:=Header.OffVar;
    SearchVarOnUnit:=True;
    FileClose(Handle);
    Exit;
   End;
   Header.OffVar:=_Var.Suivant;
   If Header.OffVar=0Then Break;
  End;
 End;
 FileClose(Handle);
End;

Procedure AddExternProcAddr;
Var
 I:RBP;
 PX:^ExternProcRec;
 L:^Long;
Begin
 If ExternProc.NB>0Then Begin
  RBSetPtr(ExternProc,0);
  For I:=0to ExternProc.NB-1do Begin
   PX:=_RBGetCurrBuf(ExternProc);
   If(PX<>NIL)Then Begin
    If(PX^.UnitNum=UnitNum)and(PX^.ProcName=Name)Then Begin
     L:=RBAdd(PX^.BankAddr,SizeOf(Long));
     If(L=NIL)Then Exit;
     L^:=Addr;
     Exit;
    End;
   End;
   RBNext(ExternProc);
  End;
 End;
 PX:=RBAdd(ExternProc,SizeOf(ExternProcRec));
 If(PX=NIL)Then Exit;
 PX^.UnitNum:=UnitNum;PX^.ProcName:=Name;PX^.FP:=FP;
 RBInit(PX^.BankAddr);
 L:=RBAdd(PX^.BankAddr,SizeOf(Long));
 If(L=NIL)Then Exit;
 L^:=Addr;
End;

Procedure AddExternVarAddr;
Var
 I:RBP;
 PX:^ExternVarRec;
 L:^Long;
Begin
 If ExternVar.NB>0Then Begin
  RBSetPtr(ExternVar,0);
  For I:=0to ExternVar.NB-1do Begin
   PX:=_RBGetCurrBuf(ExternVar);
   If(PX<>NIL)Then Begin
    If(PX^.UnitNum=UnitNum)and(PX^.VarName=Name)Then Begin
     L:=RBAdd(PX^.BankAddr,SizeOf(Long));
     If(L=NIL)Then Exit;
     L^:=Addr;
     Exit;
    End;
   End;
   RBNext(ExternVar);
  End;
 End;
 PX:=RBAdd(ExternVar,SizeOf(ExternVarRec));
 If(PX=NIL)Then Exit;
 PX^.UnitNum:=UnitNum;PX^.VarName:=Name;PX^.FP:=FP;
 RBInit(PX^.BankAddr);
 L:=RBAdd(PX^.BankAddr,SizeOf(Long));
 If(L=NIL)Then Exit;
 L^:=Addr;
End;

Function AddResWord(Const Name:String;Code:Word):Boolean;Begin
 AddResWord:=False;
 RBAddStrWord(ResWordBk,Name,Code);
 AddResWord:=Ya;
End;

Function PtrProc;
Var
 PProc:ProcPtr;
Begin
 RBSetPtr(ProcBk,0);PProc:=_RBGetCurrBuf(ProcBk);
 While(PProc<>NIL)do Begin
  If(PProc^.Name=Name)Then Break;
  RBNext(ProcBk);
  PProc:=_RBGetCurrBuf(ProcBk);
 End;
 PtrProc:=PProc;
End;

Procedure RestoreData(Const Data:Pointer);
Var
 P:^TempData Absolute Data;
Begin
 S:=P^.S;S3:=P^.S3;FS:=P^.FS;
 I:=P^.I;FP:=P^.FP;NL:=P^.NL;UnitList:=P^.UnitList;
 ProgramFormat:=P^.ProgramFormat;Handle:=P^.Handle;
 XEdt:=P^.XEdt;
 FreeMem(Data,SizeOf(TempData));
End;

Function SaveData:Pointer;Var P:^TempData;Begin
 P:=MemAlloc(SizeOf(TempData));
 If(P=NIL)Then Exit;
 P^.S:=S;P^.S3:=S3;P^.FS:=FS;
 P^.I:=I;P^.FP:=FP;P^.NL:=NL;P^.UnitList:=UnitList;
 P^.ProgramFormat:=ProgramFormat;P^.Handle:=Handle;
 P^.XEdt:=XEdt;
 SaveData:=P;
End;

Procedure SwapString(Var Str1,Str2:String);Var T:String;Begin
 T:=Str1;Str1:=Str2;Str2:=T;
End;

Procedure MakeResWord;Var Handle:Hdl;
Type
 TBool=Array[0..65520]of Bool;
Var
 M,I:Word;
 S:String;
 Free:^TBool;
 FP:LongInt;

  Function GetLine(Min,Max:Word):Word;
  Var X,MyPos:Word;P:^StrWordRec;Data:Record
   Code:Byte;
   Gauche,Droite:Word;
  End;

 Begin
  X:=((Max-Min)shr 1)+Min;
  If(Not(Free^[X]))and(Min<=Max)and(X<ResWordBk.NB)Then Begin
   P:=_RBGetBuf(ResWordBk,X);
   S:=StrPas(P^.PChr);Free^[X]:=Ya;
   GetLine:=FP;
   _SetAbsRec(Handle,FP,Succ(Length(S)),S);
   Inc(FP,Succ(Length(S)));
   MyPos:=FP;
   Inc(FP,SizeOf(Data));
   Data.Gauche:=GetLine(Min,X-1);
   Data.Droite:=GetLine(X+1,Max);
   _SetAbsRec(Handle,MyPos,SizeOf(Data),Data);
  End
   Else
  GetLine:=0;
 End;

Begin
 Handle:=NewNBak('DATA.$$$');
 If(Handle<>errHdl)Then Begin
  ResWordDef:=Ya;
  SetFilePos(Handle,0);
  Free:=MemNew(ResWordBk.NB);
  FP:=0;
  GetLine(0,ResWordBk.NB-1);
  FreeMem(Free,ResWordBk.NB);
  FileClose(Handle);
  NmResWord:=ResWordBk.NB;
  SizeResWord:=GetFileSize('DATA.$$$');
  RBDone(ResWordBk);
  RBInit(ResWordBk);
 End;
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
END.