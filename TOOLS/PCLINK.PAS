{ Outils fabricant les liens du programme }

Unit PCLink;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                  INTERFACE
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Procedure DumpSuppData;
Procedure LinkJump;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                IMPLEMENTATION
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses Systex,PCCortex,Systems,PCBase,PCUnit;

Procedure DumpSuppData;Var UN,NV,NA,I,J,L,Pos:Word;FP,DFP:Long;
Ptr:^StrWordRec;UVR:UnitVarRec;PX:^ExternProcRec;PV:^ExternVarRec;
PL:^Long;Proc:UnitProcRec;
Handle,HT:Hdl;DataHomeProc:Record
 Len:Word;
 Suppl:Bool;
End;
Begin
 If ExternProc.NB>0Then Begin
  RBSetPtr(ExternProc,0);
  For I:=0to ExternProc.NB-1do Begin
   PX:=_RBGetCurrBuf(ExternProc);
   If(PX<>NIL)Then Begin
    RBSetPtr(PX^.BankAddr,0);
    For J:=0to PX^.BankAddr.NB-1do Begin
     PL:=_RBGetCurrBuf(PX^.BankAddr);
     If(PL<>NIL)Then Begin
      L:=IP-PL^-2;
      CodePrg^[PL^]:=Lo(L);CodePrg^[PL^+1]:=Hi(L);
     End;
     RBNext(PX^.BankAddr);
    End;
     { Copie la routine }
    S3:=StrPas(PChr(_RBGetBuf(UnitList,PX^.UnitNum)));
    Handle:=FileOpen(S3+'.UPC',fmRead);
    If(Handle<>errHdl)Then Begin
     Repeat
      _GetAbsRec(Handle,PX^.FP,SizeOf(Proc),Proc);
      If(Proc.Dupl)Then PX^.FP:=Proc.OffBody;
     Until Not(Proc.Dupl);
     _GetAbsRec(Handle,Proc.OffBody,SizeOf(DataHomeProc),DataHomeProc);
     _GetAbsRec(Handle,Proc.OffBody+SizeOf(DataHomeProc),DataHomeProc.Len,
                       CodePrg^[IP]);
     FP:=Proc.OffBody+SizeOf(DataHomeProc)+DataHomeProc.Len;
     If(DataHomeProc.Suppl)Then Begin
      _GetAbsRec(Handle,FP,SizeOf(Word),NV);
      Inc(FP,SizeOf(Word));
      For J:=0to NV-1do Begin
       _GetAbsRec(Handle,FP,SizeOf(String),S4);
       Inc(FP,Length(S4)+1);
       _GetAbsRec(Handle,FP,SizeOf(String),S5);
       If Length(S5)=0Then Begin;Inc(FP);S5:=S3;End
                      Else Inc(FP,Length(S5)+1);
       UN:=UnitListNum(S5);
       _GetAbsRec(Handle,FP,SizeOf(Word),NA);
       Inc(FP,SizeOf(Word));
       For I:=0to NA-1do Begin
        _GetAbsRec(Handle,FP,SizeOf(Word),Pos);
        Inc(FP,SizeOf(Word));
        AddExternVarAddr(UN,DP,IP+Pos,S4);
       End;
      End;
     End;
     Inc(IP,DataHomeProc.Len);
     FileClose(Handle);
    End;
   End;
   RBNext(ExternProc);
  End;
 End;
 If SuppData.NB>0Then Begin
  RBSetPtr(SuppData,0);
  For I:=0to SuppData.NB-1do Begin
   Ptr:=_RBGetCurrBuf(SuppData);
   If(Ptr<>NIL)Then Begin
    CodePrg^[Ptr^.Nm]:=Lo(IP);CodePrg^[Ptr^.Nm+1]:=Hi(IP);
    MoveLeft(Ptr^.PChr^,CodePrg^[IP],Ptr^.Len);
    Inc(IP,Ptr^.Len);
   End;
   RBNext(SuppData);
  End;
 End;
 If ExternVar.NB>0Then Begin
  RBSetPtr(ExternVar,0);
  For I:=0to ExternVar.NB-1do Begin
   PV:=_RBGetCurrBuf(ExternVar);
   If(PV<>NIL)Then Begin
    If Not SearchVarOnUnit(PV^.VarName,PV^.UnitNum,DFP)Then Exit;
    HT:=FileOpen(GetUnitName(PV^.UnitNum)+'.UPC',fmRead);
    If(HT=errHdl)Then Exit;
    _GetAbsRec(HT,DFP,SizeOf(UnitVarRec),UVR);
    If(UVR.QParam=qConst)Then Begin
     _GetAbsRec(HT,DFP+SizeOf(UnitVarRec)-255+Length(UVR.Name),UVR.Size,CodePrg^[IP]);
    End;
    FileClose(HT);
    RBSetPtr(PV^.BankAddr,0);
    For J:=0to PV^.BankAddr.NB-1do Begin
     PL:=_RBGetCurrBuf(PV^.BankAddr);
     If(PL<>NIL)Then Begin
       {Inc(Word(CodePrg^[PL^]),IP);}
      ASM
       LES DI,PL
       MOV AX,ES:[DI];
       LES DI,CodePrg
       ADD DI,AX
       MOV AX,IP
       ADD ES:[DI],AX
      END;
     End;
     RBNext(PV^.BankAddr);
    End;
    Inc(IP,UVR.Size);
   End;
   RBNext(ExternVar);
  End;
 End;
End;

Procedure LinkJump;Label Restart;Var Bad,Ok:Bool;
L,I,K,T,TIP:Word;SJump,UJump,LJump:JumpPtr;Begin
 If Jump.NB=0Then Exit;
 Bad:=No;
 For I:=0to Jump.NB-1do Begin
Restart:PJump:=_RBGetBuf(Jump,I);
  If(PJump<>NIL)and(PJump^.Access=isJump)and(PJump^.Setted=NoSetted)Then Begin
   SJump:=SearchJump(PJump^.Nom,isLabel);
   If(SJump<>NIL)Then Begin
    TIP:=PJump^.Off;Ok:=No;
    If(TIP>SJump^.Off)Then Begin
     If TIP-SJump^.Off<=$80-2Then Begin
      CodePrg^[TIP+1]:=$FE-(TIP-SJump^.Off);
      PJump^.Setted:=ShortJmp;Ok:=Ya;
     End;
    End
     Else
    If SJump^.Off-TIP<$80+2Then Begin
     CodePrg^[TIP+1]:=SJump^.Off-TIP-2;
     PJump^.Setted:=ShortJmp;Ok:=Ya;
    End;
    If Not(Ok)Then Begin
     If CodePrg^[TIP]=$EBThen Begin
      L:=1;
      MoveRight(CodePrg^[TIP],CodePrg^[TIP+L],IP-TIP+1);
      Inc(IP,L);CodePrg^[TIP]:=$E9;
      If(SJump^.Off>TIP)Then T:=SJump^.Off-(TIP+2)
                        Else T:=$10000-((TIP+2+L)-SJump^.Off);
      CodePrg^[TIP+1]:=Lo(T);CodePrg^[TIP+2]:=Hi(T);
      PJump^.Setted:=NearGoto;
     End
      Else
     If(InstrFormat=p386)Then Begin
      L:=2;
      MoveRight(CodePrg^[TIP],CodePrg^[TIP+L],IP-TIP+1);
      Inc(IP,L);CodePrg^[TIP+1]:=CodePrg^[TIP]+$10;
      CodePrg^[TIP]:=$F;
      If(SJump^.Off>TIP)Then T:=SJump^.Off-(TIP+2)
                        Else T:=$10000-((TIP+2+L)-SJump^.Off);
      CodePrg^[TIP+2]:=Lo(T);CodePrg^[TIP+3]:=Hi(T);
      PJump^.Setted:=NearJmp386;
     End
      Else
     Begin
      L:=3;
      MoveRight(CodePrg^[TIP],CodePrg^[TIP+L],IP-TIP+1);
      Inc(IP,L);CodePrg^[TIP]:=CodePrg^[TIP] xor 1;
      CodePrg^[TIP+1]:=3;CodePrg^[TIP+2]:=$E9;
      If(SJump^.Off>TIP)Then T:=SJump^.Off-(TIP+2)
      Else T:=$10000-((TIP+2+L)-SJump^.Off);
      CodePrg^[TIP+3]:=Lo(T);CodePrg^[TIP+4]:=Hi(T);
      PJump^.Setted:=NearJmpManual;
     End;
     For K:=I+1to Jump.NB-1do Begin
      UJump:=_RBGetBuf(Jump,K);
      If(UJump<>NIL)Then Inc(UJump^.Off,L);
     End;
     If I>0Then For K:=0to I-1do Begin
      UJump:=_RBGetBuf(Jump,K);
      If(UJump<>NIL)and(UJump^.Access=isJump)Then Begin
       Ok:=No;LJump:=SearchJump(UJump^.Nom,isLabel);
       If(LJump<>NIL)and(LJump^.Off>TIP)Then Ok:=Ya;
       If(Ok)Then Case(UJump^.Setted)of
        NoSetted:;
        ShortJmp:If CodePrg^[UJump^.Off+1]<$80Then Begin
         If(CodePrg^[UJump^.Off+CodePrg^[UJump^.Off+1]]>TIP)Then Begin
          Inc(CodePrg^[UJump^.Off+1],L);
         End;
         If CodePrg^[UJump^.Off+1]>=$80Then Begin
          UJump^.Setted:=NoSetted;Bad:=Ya;
         End;
        End;
        NearJmpManual:Begin
         T:=CodePrg^[UJump^.Off+3]+(CodePrg^[UJump^.Off+4]shl 8);Inc(T,L);
         CodePrg^[UJump^.Off+3]:=Lo(T);CodePrg^[UJump^.Off+4]:=Hi(T);
        End;
        NearJmp386:Begin
         T:=CodePrg^[UJump^.Off+2]+(CodePrg^[UJump^.Off+3]shl 8);
         Inc(T,L);
         CodePrg^[UJump^.Off+2]:=Lo(T);CodePrg^[UJump^.Off+3]:=Hi(T);
        End;
        NearGoto:Begin
         T:=CodePrg^[UJump^.Off+1]+(CodePrg^[UJump^.Off+2]shl 8);
         Inc(T,L);
         CodePrg^[UJump^.Off+1]:=Lo(T);CodePrg^[UJump^.Off+2]:=Hi(T);
        End;
       End;
      End;
     End;
     If(Bad)Then Begin
      I:=0;Bad:=No;
      Goto Restart;
     End;
    End;
   End;
  End;
 End;
 RBDone(Jump);
 RBInit(Jump);
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
END.