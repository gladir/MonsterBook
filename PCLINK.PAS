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

Uses Systex,PCCortex,Memories,Systems,PCBase,PCUnit;

Procedure DumpSuppData;
Var
 UN,NV,NA,I,J,L,Pos:Word;
 FP,DFP:Long;
 Ptr:^StrWordRec;
 UVR:UnitVarRec;
 PX:^ExternProcRec;
 PV:^ExternVarRec;
 PL:^Long;
 Proc:UnitProcRec;
 Handle,HT:Hdl;
 DataHomeProc:Record
  Len:Word;
  Suppl:Bool;
 End;
Begin
 If CurrPC.ExternProc.Count>0Then Begin
  ALSetPtr(CurrPC.ExternProc,0);
  For I:=0to CurrPC.ExternProc.Count-1do Begin
   PX:=_ALGetCurrBuf(CurrPC.ExternProc);
   If(PX<>NIL)Then Begin
    ALSetPtr(PX^.BankAddr,0);
    For J:=0to PX^.BankAddr.Count-1do Begin
     PL:=_ALGetCurrBuf(PX^.BankAddr);
     If(PL<>NIL)Then Begin
      L:=CurrPC.IP-PL^-2;
      CurrPC.CodePrg^[PL^]:=Lo(L);
      CurrPC.CodePrg^[PL^+1]:=Hi(L);
     End;
     ALNext(PX^.BankAddr);
    End;
     { Copie la routine }
    CurrPC.S3:=StrPas(PChr(_ALGetBuf(CurrPC.UnitList,PX^.UnitNum)));
    {Handle:=FileOpen(CurrPC.S3+'.UPC',fmRead);}
    Handle:=OpenUnit(CurrPC.S3{+'.UPC',fmRead});
    If(Handle<>errHdl)Then Begin
     Repeat
      _GetAbsRec(Handle,PX^.FP,SizeOf(Proc),Proc);
      If(Proc.Dupl)Then PX^.FP:=Proc.OffBody;
     Until Not(Proc.Dupl);
     _GetAbsRec(Handle,Proc.OffBody,SizeOf(DataHomeProc),DataHomeProc);
     _GetAbsRec(Handle,Proc.OffBody+SizeOf(DataHomeProc),DataHomeProc.Len,
                       CurrPC.CodePrg^[CurrPC.IP]);
     FP:=Proc.OffBody+SizeOf(DataHomeProc)+DataHomeProc.Len;
     If(DataHomeProc.Suppl)Then Begin
      _GetAbsRec(Handle,FP,SizeOf(Word),NV);
      Inc(FP,SizeOf(Word));
      For J:=0to NV-1do Begin
       _GetAbsRec(Handle,FP,SizeOf(String),CurrPC.S4);
       Inc(FP,Length(CurrPC.S4)+1);
       _GetAbsRec(Handle,FP,SizeOf(String),CurrPC.S5);
       If Length(CurrPC.S5)=0Then Begin
        Inc(FP);CurrPC.S5:=CurrPC.S3;
       End
        Else
       Inc(FP,Length(CurrPC.S5)+1);
       UN:=UnitListNum(CurrPC.S5);
       _GetAbsRec(Handle,FP,SizeOf(Word),NA);
       Inc(FP,SizeOf(Word));
       For I:=0to NA-1do Begin
        _GetAbsRec(Handle,FP,SizeOf(Word),Pos);
        Inc(FP,SizeOf(Word));
        AddExternVarAddr(UN,CurrPC.DP,CurrPC.IP+Pos,CurrPC.S4);
       End;
      End;
     End;
     Inc(CurrPC.IP,DataHomeProc.Len);
     FileClose(Handle);
    End;
   End;
   ALNext(CurrPC.ExternProc);
  End;
 End;
 If CurrPC.SuppData.Count>0Then Begin
  ALSetPtr(CurrPC.SuppData,0);
  For I:=0to CurrPC.SuppData.Count-1do Begin
   Ptr:=_ALGetCurrBuf(CurrPC.SuppData);
   If(Ptr<>NIL)Then Begin
    CurrPC.CodePrg^[Ptr^.Nm]:=Lo(CurrPC.IP);
    CurrPC.CodePrg^[Ptr^.Nm+1]:=Hi(CurrPC.IP);
    MoveLeft(Ptr^.PChr^,CurrPC.CodePrg^[CurrPC.IP],Ptr^.Len);
    Inc(CurrPC.IP,Ptr^.Len);
   End;
   ALNext(CurrPC.SuppData);
  End;
 End;
 If CurrPC.ExternVar.Count>0Then Begin
  ALSetPtr(CurrPC.ExternVar,0);
  For I:=0to CurrPC.ExternVar.Count-1do Begin
   PV:=_ALGetCurrBuf(CurrPC.ExternVar);
   If(PV<>NIL)Then Begin
    If Not SearchVarOnUnit(PV^.VarName,PV^.UnitNum,DFP)Then Exit;
    {HT:=FileOpen(GetUnitName(PV^.UnitNum)+'.UPC',fmRead);}
    HT:=OpenUnit(GetUnitName(PV^.UnitNum));
    If(HT=errHdl)Then Exit;
    _GetAbsRec(HT,DFP,SizeOf(UnitVarRec),UVR);
    If(UVR.QParam=qConst)Then Begin
     _GetAbsRec(HT,DFP+SizeOf(UnitVarRec)-255+Length(UVR.Name),UVR.Size,CurrPC.CodePrg^[CurrPC.IP]);
    End;
    FileClose(HT);
    ALSetPtr(PV^.BankAddr,0);
    For J:=0to PV^.BankAddr.Count-1do Begin
     PL:=_ALGetCurrBuf(PV^.BankAddr);
     If(PL<>NIL)Then Begin
       {Inc(Word(CodePrg^[PL^]),IP);}
      ASM
       LES DI,PL
       MOV AX,ES:[DI];
       LES DI,CurrPC.CodePrg
       ADD DI,AX
       MOV AX,CurrPC.IP
       ADD ES:[DI],AX
      END;
     End;
     ALNext(PV^.BankAddr);
    End;
    Inc(CurrPC.IP,UVR.Size);
   End;
   ALNext(CurrPC.ExternVar);
  End;
 End;
End;

Procedure LinkJump;
Label
 Restart;
Var
 Bad,Ok:Boolean;
 L,I,K,T,TIP:Word;
 SJump,UJump,LJump:JumpPtr;
Begin
 If CurrPC.Jump.Count=0Then Exit;
 Bad:=No;
 For I:=0to CurrPC.Jump.Count-1do Begin
Restart:CurrPC.PJump:=_ALGetBuf(CurrPC.Jump,I);
  If(CurrPC.PJump<>NIL)and(CurrPC.PJump^.Access=isJump)and(CurrPC.PJump^.Setted=NoSetted)Then Begin
   SJump:=SearchJump(CurrPC.PJump^.Nom,isLabel);
   If(SJump<>NIL)Then Begin
    TIP:=CurrPC.PJump^.Off;Ok:=No;
    If(TIP>SJump^.Off)Then Begin
     If TIP-SJump^.Off<=$80-2Then Begin
      CurrPC.CodePrg^[TIP+1]:=$FE-(TIP-SJump^.Off);
      CurrPC.PJump^.Setted:=ShortJmp;Ok:=Ya;
     End;
    End
     Else
    If SJump^.Off-TIP<$80+2Then Begin
     CurrPC.CodePrg^[TIP+1]:=SJump^.Off-TIP-2;
     CurrPC.PJump^.Setted:=ShortJmp;Ok:=Ya;
    End;
    If Not(Ok)Then Begin
     If CurrPC.CodePrg^[TIP]=$EBThen Begin
      L:=1;
      MoveRight(CurrPC.CodePrg^[TIP],CurrPC.CodePrg^[TIP+L],CurrPC.IP-TIP+1);
      Inc(CurrPC.IP,L);
      CurrPC.CodePrg^[TIP]:=$E9;
      If(SJump^.Off>TIP)Then T:=SJump^.Off-(TIP+2)
                        Else T:=$10000-((TIP+2+L)-SJump^.Off);
      CurrPC.CodePrg^[TIP+1]:=Lo(T);
      CurrPC.CodePrg^[TIP+2]:=Hi(T);
      CurrPC.PJump^.Setted:=NearGoto;
     End
      Else
     If(InstrFormat=p386)Then Begin
      L:=2;
      MoveRight(CurrPC.CodePrg^[TIP],CurrPC.CodePrg^[TIP+L],CurrPC.IP-TIP+1);
      Inc(CurrPC.IP,L);
      CurrPC.CodePrg^[TIP+1]:=CurrPC.CodePrg^[TIP]+$10;
      CurrPC.CodePrg^[TIP]:=$F;
      If(SJump^.Off>TIP)Then T:=SJump^.Off-(TIP+2)
                        Else T:=$10000-((TIP+2+L)-SJump^.Off);
      CurrPC.CodePrg^[TIP+2]:=Lo(T);
      CurrPC.CodePrg^[TIP+3]:=Hi(T);
      CurrPC.PJump^.Setted:=NearJmp386;
     End
      Else
     Begin
      L:=3;
      MoveRight(CurrPC.CodePrg^[TIP],CurrPC.CodePrg^[TIP+L],CurrPC.IP-TIP+1);
      Inc(CurrPC.IP,L);
      CurrPC.CodePrg^[TIP]:=CurrPC.CodePrg^[TIP] xor 1;
      CurrPC.CodePrg^[TIP+1]:=3;
      CurrPC.CodePrg^[TIP+2]:=$E9;
      If(SJump^.Off>TIP)Then T:=SJump^.Off-(TIP+2)
      Else T:=$10000-((TIP+2+L)-SJump^.Off);
      CurrPC.CodePrg^[TIP+3]:=Lo(T);
      CurrPC.CodePrg^[TIP+4]:=Hi(T);
      CurrPC.PJump^.Setted:=NearJmpManual;
     End;
     For K:=I+1to CurrPC.Jump.Count-1do Begin
      UJump:=_ALGetBuf(CurrPC.Jump,K);
      If(UJump<>NIL)Then Inc(UJump^.Off,L);
     End;
     If I>0Then For K:=0to I-1do Begin
      UJump:=_ALGetBuf(CurrPC.Jump,K);
      If(UJump<>NIL)and(UJump^.Access=isJump)Then Begin
       Ok:=No;LJump:=SearchJump(UJump^.Nom,isLabel);
       If(LJump<>NIL)and(LJump^.Off>TIP)Then Ok:=Ya;
       If(Ok)Then Case(UJump^.Setted)of
        NoSetted:;
        ShortJmp:If CurrPC.CodePrg^[UJump^.Off+1]<$80Then Begin
         If(CurrPC.CodePrg^[UJump^.Off+CurrPC.CodePrg^[UJump^.Off+1]]>TIP)Then Begin
          Inc(CurrPC.CodePrg^[UJump^.Off+1],L);
         End;
         If CurrPC.CodePrg^[UJump^.Off+1]>=$80Then Begin
          UJump^.Setted:=NoSetted;Bad:=Ya;
         End;
        End;
        NearJmpManual:Begin
         T:=CurrPC.CodePrg^[UJump^.Off+3]+(CurrPC.CodePrg^[UJump^.Off+4]shl 8);Inc(T,L);
         CurrPC.CodePrg^[UJump^.Off+3]:=Lo(T);
         CurrPC.CodePrg^[UJump^.Off+4]:=Hi(T);
        End;
        NearJmp386:Begin
         T:=CurrPC.CodePrg^[UJump^.Off+2]+(CurrPC.CodePrg^[UJump^.Off+3]shl 8);
         Inc(T,L);
         CurrPC.CodePrg^[UJump^.Off+2]:=Lo(T);
         CurrPC.CodePrg^[UJump^.Off+3]:=Hi(T);
        End;
        NearGoto:Begin
         T:=CurrPC.CodePrg^[UJump^.Off+1]+(CurrPC.CodePrg^[UJump^.Off+2]shl 8);
         Inc(T,L);
         CurrPC.CodePrg^[UJump^.Off+1]:=Lo(T);
         CurrPC.CodePrg^[UJump^.Off+2]:=Hi(T);
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
 ALDone(CurrPC.Jump);
 ALInit(CurrPC.Jump);
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
END.