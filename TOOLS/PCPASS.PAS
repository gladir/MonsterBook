{ ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ

 ³                    Compilateur Pascal Niveau B57                     ³
                     Malte Genesis IV: Alias Chantal
 ³                                                                      ³
            Tous droits r‚serv‚s par les Chevaliers de Malte
 ³                                                                      ³

 ³                            1998 … 2000                               ³

  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ


 Nom du programmeur
 ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

  Sylvain Maltais


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette unit‚ passe le source Pascal lignes par ligne et effectue une
 compr‚hension de celle-ci.
}

Unit PCPass;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                 INTERFACE
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses Systex;

Function CompileFile(Const Name:PathStr;Var NL:Long):Int;
Function CompileInstr(OneInstr:Bool):Int;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                               IMPLEMENTATION
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses Systems,PCCortex,PCData,PCLine,PCBase,PCAsm,
     PCCompile,PCMake,PCLink,PCUnit,PCInit
     {$IFDEF IDE},Dials{$ENDIF};

Const XorReg:Array[0..7]of Byte=($C0,$C9,$D2,$DB,$E4,$ED,$F6,$FF);

Var tSegDes:SegDesType;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure AsmReadLn                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure est une fonction … additionner … l'ex‚cutable Pascal …
 construire si n‚cessaire.
}

Procedure AsmReadLn;Assembler;ASM
 MOV CX,00FFh
 SUB SP,CX
 MOV BX,SP
 MOV Byte Ptr [BX],CL
 MOV DX,BX
 MOV AH,0Ah
 INT 21h
 ADD SP,CX
END;

Procedure EndAsmReadLn;Assembler;ASM END;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure LoadProc                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de convertir en chaŒne de caractŠres Pascal une
 adresse de m‚moire et d'une longueur sp‚cifi‚e.
}

Function LoadProc(Addr:Pointer;Len:Byte):String;Assembler;ASM
 CLD
 PUSH DS
  LES DI,@Result
  MOV CL,Len
  MOV ES:[DI],CL
  INC DI
  MOV CH,0
  LDS SI,Addr
  REP MOVSB
 POP DS
END;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Proc‚dure CompileInstr                   Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet d'interpr‚ter les instructions du source. La
 partie "bloque" par exemple d'une proc‚dure ou d'une condition.
}

Function CompileInstr(OneInstr:Bool):Int;
Label
 __Int,Exit;
Type
 StackCaseRec=Record
  Q:Variant;
  IP:Word;
 End;
 StackCasePtr=^StackCaseRec;
Var
 _Ok:Boolean;
 J,K,K2:Byte;
 Iw,LR,R:Word;
 Q,Q2:Variant;
 UnitNum:Word;
 AddrUnit,TL:LongInt;
 TVar:^VarRec;
 InBegin:Word;
 StackCase:RBuf;
 SCP:StackCasePtr;
 MyCase,MyIf:Word;
 PJump:JumpPtr;
 UnitProc:UnitProcRec;
 Handle:Hdl;
 ParamHeader:Array[0..2]of Byte;
Begin
 CompileInstr:=0;LR:=$FFFF;R:=$FFFF;InBegin:=0;
 RBInit(StackCase);
 Repeat
  S3:=XtrkWd;LR:=R;R:=GetCodeMainWordPas(S3);
  Case(R)of
   cmwpAsm:Begin
    W:=CompileAsm(No);
    If W<>0Then Begin
     CompileInstr:=W;
     Goto Exit;
    End;
   End;
   cmwpBegin:Begin
    Inc(InBegin);
    W:=CompileInstr(No);
    If W<>0Then Begin
     CompileInstr:=W;
     Goto Exit;
    End;
   End;
   cmwpCase:Begin
    If Not XtrkFormule(Q,Ya,K)Then Begin
     CompileInstr:=SyntaxError;
     Goto Exit;
    End;
    If Not AddJump(isLabel,IP,'#cas'+WordToStr(CaseLevel))Then Begin
     CompileInstr:=LabelDupl;
     Goto Exit;
    End;
    MyCase:=CaseLevel;Inc(CaseLevel);
    RBInit(StackCase);
    Repeat
     If Not XtrkFormule(Q2,Ya,K)Then Begin
      CompileInstr:=SyntaxError;
      Goto Exit;
     End;
     If K<>$FFThen Begin
      CompileInstr:=SyntaxError;
      Goto Exit;
     End;
     SCP:=RBAdd(StackCase,SizeOf(StackCaseRec));
     If(SCP=NIL)Then Begin
      CompileInstr:=OutOfMemory;
      Goto Exit;
     End;
     SCP^.Q:=Q2;SCP^.IP:=IP;W:=CompileInstr(Ya);
     If W<>0Then Begin
      CompileInstr:=W;
      Goto Exit;
     End;
     SaveAddr;
     S3:=XtrkWd;
     If(GetCodeMainWordPas(S3)=cmwpEnd)Then Break;
     RestoreAddr;
    Until No;
    If Not AddJump(isLabel,IP,'#fcas'+WordToStr(CaseLevel))Then Begin
     CompileInstr:=LabelDupl;
     Goto Exit;
    End;
    PJump:=SearchJump('#cas'+WordToStr(CaseLevel),isLabel);
    S5:='';
    RBSetPtr(StackCase,0);
    For Iw:=0to StackCase.NB-1do Begin
     SCP:=_RBGetCurrBuf(StackCase);
     IncStr(S5,SCP^.Q.X.DataChar);
     RBNext(StackCase);
    End;
    RBAddStrWord(SuppData,S5,PJump^.Off+3);
    S4:=#$0E#$07+                                     { MOV ES,CS }
        #$BF#$00#$00+                                 { MOV DI,0000 }
        #$B1+Chr(StackCase.NB)+Chr(Hi(StackCase.NB))+ { MOV CX,Nombre de cas }
        #$AE;                                         { SCASB }
    InsertCode('#cas'+WordToStr(MyCase),S4);
    RBDone(StackCase);
   End;
   cmwpEnd:If InBegin>=0Then Break
    Else
   Begin
    CompileInstr:=MisplacedEndSymbol;
    Goto Exit;
   End;
   cmwpIf:Begin
    MyIf:=IfLevel;Inc(IfLevel);
    If Not XtrkFormule(Q,Ya,K)Then Begin
     CompileInstr:=SyntaxError;
     Goto Exit;
    End;
    PushInstr(#$50);     { PUSH AX }
    Case(SI)of
     '=':Begin
      Inc(I);
      Iw:=0;
     End;
     '<':Begin
      Inc(I);
      Iw:=1;
     End;
     '>':Begin
      Inc(I);
      Iw:=2;
     End;
    End;
    If Not XtrkFormule(Q2,Ya,K)Then Begin
     CompileInstr:=SyntaxError;
     Goto Exit;
    End;
    PushInstr(#$5A+      { POP DX }
              #$3B#$C2); { CMP AX,DX }
    If Not AddJump(isJump,IP,'#sinon'+WordToStr(MyIf))Then Begin
     CompileInstr:=OutOfMemory;
     Goto Exit;
    End;
    Case(Iw)of
     0:Push2Byte(Byte(acJNZ.OpCode[1]),0);
     1:Push2Byte(Byte(acJA.OpCode[1]),0);
     2:Push2Byte(Byte(acJB.OpCode[1]),0);
    End;
    S3:=XtrkWd;
    If(GetCodeMainWordPas(S3)<>cmwpThen)Then Begin
     CompileInstr:=ThenExpected;
     Goto Exit;
    End;
    W:=CompileInstr(No);
    If W<>0Then Begin
     CompileInstr:=W;
     Goto Exit;
    End;
    If SI=';'Then Begin
     Inc(I);
     If Not AddJump(isLabel,IP,'#sinon'+WordToStr(MyIf))Then Begin
      CompileInstr:=OutOfMemory;
      Goto Exit;
     End;
    End
     Else
    Begin
     If Not AddJump(isJump,IP,'#fsi'+WordToStr(MyIf))Then Begin
      CompileInstr:=OutOfMemory;
      Goto Exit;
     End;
     Push2Byte(Byte(acJMP.OpCode[1]),0);
     S3:=XtrkWd;
     If(GetCodeMainWordPas(S3)<>cmwpElse)Then Begin
      CompileInstr:=SyntaxError;
      Goto Exit;
     End;
     W:=CompileInstr(No);
     If W<>0Then Begin
      CompileInstr:=W;
      Goto Exit;
     End;
     If Not AddJump(isLabel,IP,'#fsi'+WordToStr(MyIf))Then Begin
      CompileInstr:=OutOfMemory;
      Goto Exit;
     End;
    End;
    Dec(IfLevel);
   End;
   cmwpInLine:Begin
    If SI<>'('Then Begin
     CompileInstr:=OpenParExpected;
     Goto Exit;
    End;
    Repeat
     Inc(I);
     l1:=XtrkInteger(Ok);
     If l1>$FFThen Push2Byte(Lo(l1),Hi(l1))
              Else PushByte(l1);
     If Not(SI in[')','/'])Then Begin
      CompileInstr:=SyntaxError;
      Goto Exit;
     End;
    Until SI=')';
    Inc(I);
   End;
   cmwpInterrupt:Goto __Int;
   Else Begin
    RBSetPtr(ProcBk,0);Ok:=No;PProc:=_RBGetCurrBuf(ProcBk);
    While(PProc<>NIL)do Begin
     If(PProc^.Name=S3)Then Begin
      If PPRoc^.Param.NB>0Then Begin
       If SI<>'('Then Begin
        CompileInstr:=OpenParExpected;
        Goto Exit;
       End;
       Inc(I);Ok:=No;
       RBSetPtr(PProc^.Param,0);
       For J:=0to PProc^.Param.NB-1do Begin
        TVar:=_RBGetCurrBuf(PProc^.Param);
        If(TVar^.TypeDef=tString)Then Begin
         If Not XtrkString(S4)Then Begin
          CompileInstr:=SyntaxError;
          Goto Exit;
         End;
         PushByte($1E);      { PUSH DS }
         RBAddStrWord(SuppData,Chr(Length(S4))+S4,IP+1);
         If(InstrFormat>=p286)Then Push3Byte($68,0,0) { PUSH 0000h }
          Else
         Begin
          Push3Byte($BE,0,0); { MOV SI,0000h }
          PushByte($56);      { PUSH SI }
         End;
        End
         Else
        Begin
         If Not XtrkFormule(Q,Ya,K)Then Begin
          CompileInstr:=SyntaxError;
          Goto Exit;
         End;
         If K=$FFThen Begin
          If(InstrFormat>=p286)Then Begin
           If(Q.TypeDef)in[tBool,tByte,tShort]Then Push2Byte($6A,Q.X.DataByte)
            Else
           Begin
            PushByte($68);
            PushAddWord(Q.X.DataWord);
           End;
          End
           Else
          Begin
           PushByte($B8);             { MOV AX,W.X.DataWord }
           PushAddWord(Q.X.DataWord);
           PushByte($50);             { PUSH AX }
          End;
         End
          Else
         PushByte($50); { PUSH AX }
        End;
        RBNext(PProc^.Param);
        If J<PProc^.Param.NB-1Then Begin
         If SI<>','Then Begin
          CompileInstr:=VirguleExpected;
          Goto Exit;
         End;
         Inc(I);
        End;
       End;
       If SI<>')'Then Begin
        CompileInstr:=CloseParExpected;
        Goto Exit;
       End;
       Inc(I);
      End;
      W:=PProc^.Ofs-(IP+3);
      If(PPRoc^.CurrPtr=cmwpFar)Then Begin
       PushByte(ciPushCS);
       Dec(W)
      End;
      PushInstrOffset(asmCallNear,W);
      Ok:=Ya;LR:=$FFFF;Break;
     End;
     RBNext(ProcBk);
     PProc:=_RBGetCurrBuf(ProcBk);
    End;
    If Not(Ok)Then Begin
     Ok:=SearchProcList(S3,UnitNum,AddrUnit);
     If(Ok)Then Begin
      S5:=StrPas(PChr(_RBGetBuf(UnitList,UnitNum)));
      Handle:=FileOpen(S5+'.UPC',fmRead);
      If(Handle<>errHdl)Then Begin
       _GetAbsRec(Handle,AddrUnit,SizeOf(UnitProc),UnitProc);
      End;
      If UnitProc.NmParam>0Then Begin
       If SI<>'('Then Begin
        CompileInstr:=OpenParExpected;
        Goto Exit;
       End;
       Inc(I);TL:=AddrUnit+SizeOf(UnitProc)-SizeOf(String)+1+Length(UnitProc.Name);
       For J:=0to UnitProc.NmParam-1do Begin
        _GetAbsRec(Handle,TL,SizeOf(ParamHeader),ParamHeader);
        Inc(TL,SizeOf(ParamHeader));
        If(DefType(ParamHeader[1])=tString)Then Begin
         If Not XtrkString(S4)Then Begin
          CompileInstr:=SyntaxError;
          Goto Exit;
         End;
         PushByte($1E);      { PUSH DS }
         RBAddStrWord(SuppData,Chr(Length(S4))+S4,IP+1);
         If(InstrFormat>=p286)Then Push3Byte($68,0,0) { PUSH 0000h }
          Else
         Begin
          Push3Byte($BE,0,0); { MOV SI,0000h }
          PushByte($56);      { PUSH SI }
         End;
        End
         else
        Begin
         If Not XtrkFormule(Q,Ya,K)Then Begin
          CompileInstr:=SyntaxError;
          Goto Exit;
         End;
         If K=$FFThen Begin
          If ParamHeader[2]<$FFThen Begin
           Case ParamHeader[2]of
            0..7:If(Q.TypeDef)in[tBool,tByte,tShort]Then
                  Push2Byte($B0+ParamHeader[2],Q.X.DataByte)
                 Else
                  Push3Byte($B0+ParamHeader[2],Q.X.DataByte,Q.X.DirectByte[1]);
            Else Begin
             CompileInstr:=SyntaxError;
             Goto Exit;
            End;
           End;
          End
           Else
          If(InstrFormat>=p286)Then Begin
           If(Q.TypeDef)in[tBool,tByte,tShort]Then Push2Byte($6A,Q.X.DataByte)
            Else
           Begin
            PushByte($68);
            PushAddWord(Q.X.DataWord);
           End;
          End
           Else
          Begin
           PushByte($B8);             { MOV AX,W.X.DataWord }
           PushAddWord(Q.X.DataWord);
           PushByte($50);             { PUSH AX }
          End;
         End
          Else
         PushInstr(#$50); { PUSH AX }
        End;
        If J<UnitProc.NmParam-1Then Begin
         If SI<>','Then Begin
          CompileInstr:=VirguleExpected;
          Goto Exit;
         End;
         Inc(I);
        End;
       End;
       If SI<>')'Then Begin
        CompileInstr:=CloseParExpected;
        Goto Exit;
       End;
       Inc(I);
      End;
      FileClose(Handle);
      AddExternProcAddr(UnitNum,AddrUnit,IP+1,S3);
      PushInstrOffset(asmCallNear,W);
     End;
    End;
    If Not(Ok)Then Begin
     R:=GetCodeInstrPas(S3,J);
     Case(R)of
      cipWrite,cipWriteLn:Begin
       If SI<>'('Then Begin
        CompileInstr:=OpenParExpected;
        Goto Exit;
       End;
       Inc(I);
       If Not XtrkString(S4)Then Begin
        CompileInstr:=SyntaxError;
        Goto Exit;
       End;
       If(r=cipWriteLn)Then AddStr(S4,#13#10);
       RBAddStrWord(SuppData,S4+'$',IP+1);
       If(LR=cipWrite)or(LR=cipWriteLn)Then Begin
        PushInstr(#$BA#$00#$00+                { MOV DX,Offset }
                  #$CD#$21);                   { INT 21h }
       End
        Else
       PushInstr(#$BA#$00#$00+                { MOV DX,Offset }
                 #$B4#09+                     { MOV AH,09h }
                 #$CD#$21);                   { INT 21h }
       If SI<>')'Then Begin
        CompileInstr:=CloseParExpected;
        Goto Exit;
       End;
       Inc(I);
      End;
      cipReadLn:Begin
       PushInstr(LoadProc(@AsmReadLn,Ofs(EndAsmReadLn)-Ofs(AsmReadLn)-1));
      End;
      cipPort,cipPortW:Begin
       If SI<>'['Then Begin
        CompileInstr:=OpenArrayExpected;
        Goto Exit;
       End;
       Inc(I);l1:=XtrkInteger(Ok);
       If Not(Ok)Then Begin
        CompileInstr:=SyntaxNumber;
        Goto Exit;
       End;
       If LongRec(l1).Hi and$7FFF>0Then Begin
        CompileInstr:=TooBigNumber;
        Goto Exit;
       End;
       If SI<>']'Then Begin
        CompileInstr:=CloseArrayExpected;
        Goto Exit;
       End;
       Inc(I);
       If SI<>':'Then Begin
        CompileInstr:=ColonExpected;
        Goto Exit;
       End;
       Inc(I);
       If SI<>'='Then Begin
        CompileInstr:=EqualExpected;
        Goto Exit;
       End;
       Inc(I);
       l2:=XtrkInteger(Ok);
       If Not(Ok)Then Begin
        CompileInstr:=SyntaxNumber;
        Goto Exit;
       End;
       Push3Byte(ciMovDX_Word,Lo(l1),Hi(l1));
       If(R=cipPort)Then Begin
        Push2Byte(ciMovAL_Byte,l2);
        PushByte(ciOutDX_AL);
       End
        Else
       Begin
        Push3Byte(ciMovAX_Word,l2,Hi(Wd(l2)));
        PushByte(ciOutDX_AX);
       End;
      End;
      cipMem,cipMemW:Begin
       If SI<>'['Then Begin
        CompileInstr:=OpenArrayExpected;
        Goto Exit;
       End;
       Inc(I);S4:=XtrkWd;
       If SI<>':'Then Begin
        CompileInstr:=ColonExpected;
        Goto Exit;
       End;
       Inc(I);
       S5:=XtrkWd;
       If S5[1]='_'Then K:=GetCodeRegAsm(Copy(S5,2,255),J)Else J:=$FF;
       If J=16Then Case(K)of
        3:J:=7;
        5:J:=6;
        6:J:=4;
        7:J:=5;
        Else Begin
         CompileInstr:=SyntaxError;
         Goto Exit;
        End;
       End
        Else
       Begin
        CompileInstr:=SyntaxError;
        Goto Exit;
       End;
       If SI='+'Then Begin
        Inc(I);
        l1:=XtrkInteger(_Ok);
        If Not(_Ok)Then Begin
         CompileInstr:=SyntaxNumber;
         Goto Exit;
        End;
       End
        Else
       _Ok:=Ya;
       If SI<>']'Then Begin
        CompileInstr:=CloseArrayExpected;
        Goto Exit;
       End;
       Inc(I);
       If SI<>':'Then Begin
        CompileInstr:=ColonExpected;
        Goto Exit;
       End;
       Inc(I);
       If SI<>'='Then Begin
        CompileInstr:=EqualExpected;
        Goto Exit;
       End;
       Inc(I);
       l2:=XtrkInteger(Ok);
       If Not(Ok)Then S6:=XtrkWd Else S6:='';
       If S4='_SS'Then PushByte(ciSS)Else
       If S4='_GS'Then PushByte(ciGS)Else
       If S4='_FS'Then PushByte(ciFS)Else
       If S4='_ES'Then PushByte(ciES)Else
       If S4='_DS'Then PushByte(ciDS)Else
       If S4='_CS'Then PushByte(ciCS)
       Else Begin
        CompileInstr:=SyntaxError;
        Goto Exit;
       End;
       If Not(Ok)Then Begin
        If(R=cipMemW)Then Begin
         If J=7Then Begin
          If(_Ok)and(S6='_DS')Then Begin
            { MOV [BX+??],DS }
           If l1>=$80Then PushInstrOffset(#$8C#$9F,l1)
                     Else Push3Byte($8C,$5F,l1);
          End
           Else
          If S6='_AX'Then PushInstr(asmMovAdrBX_AX)Else
          If S6='_CX'Then Push2Byte($89,$0F)Else
          If S6='_DX'Then Push2Byte($89,$17)Else
          If S6='_BX'Then Push2Byte($89,$1F)Else
          If S6='_DS'Then Push2Byte($8C,$1C)
           Else
          Begin
           CompileInstr:=SyntaxError;
           Goto Exit;
          End;
         End
          Else
         Begin
          CompileInstr:=SyntaxError;
          Goto Exit;
         End;
        End
         Else
        Begin
         CompileInstr:=SyntaxError;
         Goto Exit;
        End;
       End
        Else
       Begin
        If(R=cipMem)Then Push3Byte($C6,J,l2)
                    Else Push3Byte($C7,J,l2);
       End;
      End;
      cipIntr,cipGenInterrupt:Begin
 __Int:If SI<>'('Then Begin
        CompileInstr:=OpenParExpected;
        Goto Exit;
       End;
       Inc(I);l1:=XtrkInteger(Ok);
       If Not(Ok)Then Begin
        CompileInstr:=SyntaxNumber;
        Goto Exit;
       End;
       If(LongRec(l1).Hi<>0)or(Hi(LongRec(l1).Lo)<>0)Then Begin
        CompileInstr:=TooBigNumber;
        Goto Exit;
       End;
       Push2Byte($CD,l1);
       If l1 in[$25,$26]Then Case(InstrFormat)of
        p88:PushInstr(#$81#$C4#$02#$00);
        Else Push3Byte($83,$C4,$02);
       End;
       If SI<>')'Then Begin
        CompileInstr:=CloseParExpected;
        Goto Exit;
       End;
       Inc(I);
      End;
      cipInc:Begin
       If SI<>'('Then Begin
        CompileInstr:=OpenParExpected;
        Goto Exit;
       End;
       Inc(I);S4:=XtrkWd;
       If S4=''Then Begin
        CompileInstr:=IdentifierExpected;
        Goto Exit;
       End;
       If S4[1]='_'Then K:=GetCodeRegAsm(Copy(S4,2,255),J)
                   Else J:=$FF;
       Case(J)of
        8:Push2Byte($FE,$C0+K);
        16:PushByte(ciIncAX+K);
        32:If(InstrFormat>=p386)Then Push2Byte($66,ciIncAX+K);
        Else Begin
         CompileInstr:=UnknownIdentifier;
         Goto Exit;
        End;
       End;
       If SI<>')'Then Begin
        CompileInstr:=CloseParExpected;
        Goto Exit;
       End;
       Inc(I);
      End;
      cipRunError,cipHalt:Begin
       If SI='('Then Begin
        Inc(I);
        l1:=XtrkInteger(_Ok);
        If Not(_Ok)Then Begin
         CompileInstr:=SyntaxNumber;
         Goto Exit;
        End;
        If SI<>')'Then Begin
         CompileInstr:=CloseParExpected;
         Goto Exit;
        End;
        Inc(I);
        PushInstr(#$B8+Char(l1)+#$4C+ { MOV AX,4C00h + l1 }
                  #$CD#$21);          { INT 21h }
       End
        Else
       PushInstr(asmINT20);
      End;
      cipEnable,cipSTI:Begin
       If SI='('Then Begin
        Inc(I);
        If SI<>')'Then Begin
         CompileInstr:=CloseParExpected;
         Goto Exit;
        End;
        Inc(I);
       End;
       PushByte(ciSTI)
      End;
      cipDisable,cipCLI:Begin
       If SI='('Then Begin { Compatibilit‚ avec le C/C++ }
        Inc(I);
        If SI<>')'Then Begin
         CompileInstr:=CloseParExpected;
         Goto Exit;
        End;
        Inc(I);
       End;
       PushByte(ciCLI)
      End;
      cipDec:Begin
       If SI<>'('Then Begin
        CompileInstr:=OpenParExpected;
        Goto Exit;
       End;
       Inc(I);S4:=XtrkWd;
       If S4=''Then Begin
        CompileInstr:=IdentifierExpected;
        Goto Exit;
       End;
       If S4[1]='_'Then K:=GetCodeRegAsm(Copy(S4,2,255),J)
                   Else J:=$FF;
       Case(J)of
        8:Push2Byte($FE,$C8+K);
        16:PushByte(ciDecAX+K);
        32:If(InstrFormat>=p386)Then Push2Byte($66,ciDecAX+K);
        Else Begin
         CompileInstr:=UnknownIdentifier;
         Goto Exit;
        End;
       End;
       If SI<>')'Then Begin
        CompileInstr:=CloseParExpected;
        Goto Exit;
       End;
       Inc(I);
      End;
      cip_IF,cip_DF,cip_CF:Begin
       If SI<>':'Then Begin
        CompileInstr:=ColonExpected;
        Goto Exit;
       End;
       Inc(I);
       If SI<>'='Then Begin
        CompileInstr:=ColonExpected;
        Goto Exit;
       End;
       Inc(I);
       If(r<>cip_IF)Then S4:=XtrkWd;
       Case(r)of
        cip_IF:Begin
         If Not XtrkFormule(Q,Ya,K)Then Begin
          CompileInstr:=SyntaxError;
          Goto Exit;
         End;
         If K<>$FFThen Begin
          CompileInstr:=SyntaxError;
          Goto Exit;
         End;
         Case(Q.X.DataByte)of
          0:PushByte(ciCLI);
          1:PushByte(ciSTI);
          Else Begin
           CompileInstr:=SyntaxError;
           Goto Exit;
          End;
         End;
        End;
        cip_DF:Begin
         If Not XtrkFormule(Q,Ya,K)Then Begin
          CompileInstr:=SyntaxError;
          Goto Exit;
         End;
         If K<>$FFThen Begin
          CompileInstr:=SyntaxError;
          Goto Exit;
         End;
         Case(Q.X.DataByte)of
          0:PushByte(ciCLD);
          1:PushByte(ciSTD);
          Else Begin
           CompileInstr:=SyntaxError;
           Goto Exit;
          End;
         End;
        End;
        Else Begin
         If S4='NOT'Then Begin
          S4:=XtrkWd;
          If S4='_CF'Then PushByte(ciCMC)
          Else Begin
           CompileInstr:=CFExpected;
           Goto Exit;
          End;
         End
          Else
         If S4='TRUE'Then PushByte(ciSTC)Else
         If S4='FALSE'Then PushByte(ciCLC)
          Else
         Begin
          Case(SI)of
           '0':PushByte(ciCLC);
           '1':PushByte(ciSTC);
           Else Begin
            CompileInstr:=SyntaxError;
            Goto Exit;
           End;
          End;
          Inc(I);
         End;
        End;
       End;
      End;
      Else Begin { Ce sont des variables problablement...}
       If S3[1]='_'Then K:=GetCodeRegAsm(Copy(S3,2,255),J)
                   Else J:=$FF;
       Case(J)of
        17:Begin
         If SI<>':'Then Begin
          CompileInstr:=ColonExpected;
          Goto Exit;
         End;
         Inc(I);
         If SI<>'='Then Begin
          CompileInstr:=EqualExpected;
          Goto Exit;
         End;
         Inc(I);W:=XtrkInteger(Ok);
         If Not(Ok)Then Begin
          CompileInstr:=SyntaxNumber;
          Goto Exit;
         End;
         If(InstrFormat>=p286)Then Begin
          If Hi(W)=0Then Push2Byte($6A,W) { Push ?? }
                    Else Push3Byte($68,Lo(W),Hi(W)); { Push ???? }
          Case(K)of
           0:PushByte(ciPopES); { Pop ES }
           2:PushByte(ciPopSS); { Pop SS }
           3:PushByte(ciPopDS); { Pop DS }
           4:PushWord(ciPopFS); { Pop FS }
           5:PushWord(ciPopGS); { Pop GS }
          End;
         End
          Else
         Begin
          If W=0Then Push2Byte($33,XorReg[0])    { XOR AX,AX }
                Else Push3Byte($B8,Lo(W),Hi(W)); { MOV AX,???? }
          Case(K)of
           0:Push2Byte($8E,$C0);     { MOV ES,AX }
           2:PushInstr(asmMovSS_AX); { MOV SS,AX }
           3:Push2Byte($8E,$D8);     { MOV DS,AX }
           4,5:Begin
            CompileInstr:=OpCode386;
            Goto Exit;
           End;
          End;
         End;
        End;
        16:Begin
         Case(SI)of
          '+':Begin
           Inc(I);
           If SI<>'+'Then Begin
            CompileInstr:=PlusExpected;
            Goto Exit;
           End;
           Inc(I);
           PushByte(ciIncAX+K);
          End;
          '-':Begin
           Inc(I);
           If SI<>'-'Then Begin
            CompileInstr:=MinusExpected;
            Goto Exit;
           End;
           Inc(I);
           PushByte(ciDecAX+K);
          End;
          '<':Begin
           Inc(I);
           If SI<>'<'Then Begin
            CompileInstr:=LowerExpected;
            Goto Exit;
           End;
           Inc(I);
           If SI<>':'Then Begin
            CompileInstr:=ColonExpected;
            Goto Exit;
           End;
           Inc(I);
           If SI<>'='Then Begin
            CompileInstr:=EqualExpected;
            Goto Exit;
           End;
           Inc(I);W:=XtrkInteger(Ok);
           If Not(Ok)Then Begin
            CompileInstr:=SyntaxNumber;
            Goto Exit;
           End;
           If(InstrFormat>=p286)and(W>1)Then Push3Byte($C1,$E0+K,W)
           Else For J:=1to(W)do Push2Byte($D1,$E0+K);
          End;
          '>':Begin
           Inc(I);
           If SI<>'>'Then Begin
            CompileInstr:=GrExpected;
            Goto Exit;
           End;
           Inc(I);
           If SI<>':'Then Begin
            CompileInstr:=ColonExpected;
            Goto Exit;
           End;
           Inc(I);
           If SI<>'='Then Begin
            CompileInstr:=EqualExpected;
            Goto Exit;
           End;
           Inc(I);W:=XtrkInteger(Ok);
           If Not(Ok)Then Begin
            CompileInstr:=SyntaxNumber;
            Goto Exit;
           End;
           If(InstrFormat>=p286)and(W>1)Then Push3Byte($C1,$E8+K,W)
           Else For J:=1to(W)do Push2Byte($D1,$E8+K);
          End;
          ':':Begin
           Inc(I);
           If SI<>'='Then Begin
            CompileInstr:=EqualExpected;
            Goto Exit;
           End;
           Inc(I);W:=XtrkInteger(Ok);
           If Not(Ok)Then Begin
            S4:=XtrkWd;
            If S4[1]='_'Then K2:=GetCodeRegAsm(Copy(S4,2,255),J)
                        Else J:=$FF;
            Case(J)of
             8:If(InstrFormat=p386)Then Push3Byte($0F,$B6,$C0+(K shl 3)+K2)
                Else
               Begin
                Push2Byte($B0+((K+4)and 7),0);
                Push2Byte($8A,$C0+(K shl 3)+K2);
               End;
             16,32:Push2Byte($8B,$C0+(K shl 3)+K2);
             Else Begin
              CompileInstr:=SyntaxNumber;
              Goto Exit;
             End;
            End;
           End
            Else
           Begin
            If W=0Then Push2Byte($33,XorReg[K])
            Else Push3Byte($B8+K,Lo(W),Hi(W));
           End;
          End;
          Else Begin
           CompileInstr:=ColonExpected;
           Goto Exit;
          End;
         End;
        End;
        32:Begin
         If SI<>':'Then Begin
          CompileInstr:=ColonExpected;
          Goto Exit;
         End;
         Inc(I);
         If SI<>'='Then Begin
          CompileInstr:=ColonExpected;
          Goto Exit;
         End;
         Inc(I);l1:=XtrkInteger(Ok);
         If Not(Ok)Then Begin
          CompileInstr:=SyntaxNumber;
          Goto Exit;
         End;
         Push2Byte($66,$B8+K);
         PushAddLong(l1);
        End;
        8:Begin
         If SI<>':'Then Begin
          CompileInstr:=ColonExpected;
          Goto Exit;
         End;
         Inc(I);
         If SI<>'='Then Begin
          CompileInstr:=ColonExpected;
          Goto Exit;
         End;
         Inc(I);
         l1:=XtrkInteger(Ok);
         If(K=0)and(CodePrg^[PrevIP]=$B4)Then Begin { _AL et pr‚c‚dent _AH ? }
          CodePrg^[PrevIP]:=$B8;CodePrg^[PrevIP+2]:=CodePrg^[PrevIP+1];
          CodePrg^[PrevIP+1]:=l1;Inc(IP);
         End
          Else
         If(K=4)and(CodePrg^[PrevIP]=$B0)Then Begin { _AH et pr‚c‚dent _AL ? }
          CodePrg^[PrevIP]:=$B8;CodePrg^[PrevIP+2]:=l1;Inc(IP);
         End
          Else
         Begin
          If Not(Ok)Then Begin
           CompileInstr:=SyntaxNumber;
           Goto Exit;
          End;
          Push2Byte($B0+K,l1);
         End;
        End;
        Else Begin
         _Ok:=No;
         RBSetPtr(VarBk,0);
         If VarBk.NB>0Then For Iw:=0to VarBk.NB-1do Begin
          PVar:=_RBGetCurrBuf(VarBk);
          If(PVar^.Name=S3)Then Begin
           Case(SI)of
            '+':Begin
             Inc(I);
             If SI<>'+'Then Begin
              CompileInstr:=PlusExpected;
              Goto Exit;
             End;
             Inc(I);
             Case(PVar^.SegDes)of
              vES:PushByte(ciES);
              vCS:PushByte(ciCS);
              vSS:PushByte(ciSS);
              vDS:PushByte(ciDS);
              vFS:PushByte(ciFS);
              vGS:PushByte(ciGS);
              Else Begin
               CompileInstr:=InternalError;
               Goto Exit;
              End;
             End;
             Case(PVar^.TypeDef)of
              tBool,tByte,tShort,tChar:Push2ByteOffset($FE,$06,PVar^.Ofs);
              tInt,tWord:Push2ByteOffset($FF,$06,PVar^.Ofs);
              Else Begin
               CompileInstr:=TypeMistmatch;
               Goto Exit;
              End;
             End;
            End;
            ':':If StrI(I+1,S)='='Then Begin
             Inc(I,2);
             If Not XtrkFormule(Q,Ya,K)Then Begin
              CompileInstr:=SyntaxError;
              Goto Exit;
             End;
             Case(K)of
              $FF:Case(PVar^.TypeDef)of
               tBool,tByte,tShort:Begin
                PushInstrOffset(#$C6#06,PVar^.Ofs);
                PushAddByte(Q.X.DataByte);
               End;
               tWord,tInt:Begin
                PushInstrOffset(#$C7#06,PVar^.Ofs);
                PushAddWord(Q.X.DataWord);
               End;
               tLong:If(InstrFormat>=p386)Then Begin
                PushInstrOffset(#$66#$C7#06,PVar^.Ofs);
                PushAddLong(Q.X.DataLong);
               End
                Else
               Begin
                PushInstrOffset(#$C7#06,PVar^.Ofs);
                PushAddWord(Q.X.DataWord);
                PushInstrOffset(#$C7#06,PVar^.Ofs+2);
                PushAddWord(LongRec(Q.X.DataLong).Hi);
               End;
               Else Begin
                CompileInstr:=TypeMistmatch;
                Goto Exit;
               End;
              End;
              0:Case(PVar^.TypeDef)of
               tBool,tByte,tShort:PushInstrOffset(#$A2,PVar^.Ofs);
               tWord,tInt:PushInstrOffset(#$A3,PVar^.Ofs);
               tLong:If(InstrFormat>=p386)Then PushInstrOffset(#$66#$A3,PVar^.Ofs)
                Else
               Begin
                PushInstrOffset(#$A3,PVar^.Ofs);       { MOV Variable,AX }
                PushInstrOffset(#$89#$16,PVar^.Ofs+2); { MOV Variable,DX }
               End;
               Else Begin
                CompileInstr:=TypeMistmatch;
                Goto Exit;
               End;
              End;
              Else Begin
               CompileInstr:=TypeMistmatch;
               Goto Exit;
              End;
             End;
            End;
            Else Begin
             CompileInstr:=SyntaxError;
             Goto Exit;
            End;
           End;
           _Ok:=Ya;
           Break;
          End;
          RBNext(VarBk);
         End;
         If Not(_Ok)Then Begin
          CompileInstr:=EndExpected;
          Goto Exit;
         End;
        End;
       End;
      End;
     End;
    End;
   End;
  End;
  If SI<>';'Then Begin
   CompileInstr:=SemicolonExpected;
   Goto Exit;
  End;
  Inc(I);
  If(InBegin=0)and(OneInstr)Then Goto Exit;
 Until No;
Exit:
 RBDone(StackCase);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Fonction CompileFile                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de compiler une unit‚ ou un programme. C'est une
 mise … z‚ro du m‚canisme de compilation.
}

Function CompileFile;
Label Restart,Err,FinishType;
Var
 V:Variant;
 R:Byte;
 VP:NoeudVarPasPtr;
 TPile:RBuf;
 J:Wd;
 TVar:^VarRec;
 QParam:QParamType;
 TL:Long;
 OD:Pointer;

 Function MakeMacro:Boolean;
 Var
  Mac:MacroRec;
  PMac:^MacroRec;
  EStr:String;
 Begin
  MakeMacro:=No;Mac.Name:=XtrkWd;
  If Mac.Name=''Then Begin
   CompileFile:=IdentifierExpected;
   Exit;
  End;
  If SI<>';'Then Begin
   CompileFile:=PointCommaExpected;
   Exit;
  End;
  Inc(I);Mac.FB:=FP;Mac.Path:=CurrFile;
  Repeat
   While SI<>'E'do Begin
    If SI=#0Then Begin
     CompileFile:=EndOfSourceExpected;
     Exit;
    End;
    Inc(I);
    SaveAddr;
   End;
   EStr:=XtrkWd
  Until(EStr='ENDMACRO')or(EStr='FINMACRO');
  RestoreAddr;
  XtrkWd;
  Mac.FE:=FP;
  If SI<>';'Then Begin
   CompileFile:=PointCommaExpected;
   Exit;
  End;
  Inc(I);
  PMac:=RBAdd(Macro,SizeOf(MacroRec));
  If(PMac=NIL)Then Begin
   CompileFile:=OutOfMemory;
   Exit;
  End;
  PMac^:=Mac;MakeMacro:=Ya;
 End;

 Function AddConst:Bool;
 Label Other;
 Var
  Cst:CstRec;
  Ok:Bool;
  K:Byte;
  PCst:^CstRec;
  VP:NoeudVarPasPtr;
  {Q:Variant;}
 Begin
  FillClr(Cst,SizeOf(CstRec));
  Cst.Name:=S3;AddConst:=False;
  SaveAddr;
  S2:=XtrkWd;VP:=SearchVarPas(S2);
  If(VP=NIL)Then Goto Other;
  Case(VP^.TypeDef)of
   tBool:Begin
    If SI<>'('Then Begin
     CompileFile:=OpenParExpected;
     Exit;
    End;
    Inc(I);
    l1:=XtrkInteger(Ok);
    If(Ok)Then Begin
     Cst.Q.TypeDef:=tBool;Cst.Q.X.DataByte:=l1;
     PCst:=RBIns(ReDef,SearchPosConst(Ok),SizeOf(CstRec));
     If(Ok)Then Begin
      CompileFile:=ConstDupl;
      Exit;
     End;
     If(PCst=NIL)Then Begin
      CompileFile:=OutOfMemory;
      Exit;
     End;
     PCst^:=Cst;
     If SI<>')'Then Begin
      CompileFile:=CloseParExpected;
      Exit;
     End;
     Inc(I);AddConst:=Ya;
    End;
   End;
   Else Begin
Other:RestoreAddr;
    If XtrkFormule(Cst.Q,No,K)Then Begin
     PCst:=RBIns(ReDef,SearchPosConst(Ok),SizeOf(CstRec){-SizeOf(String)+Length(Cst.Name)+16});
     If(Ok)Then Begin
      CompileFile:=ConstDupl;
      Exit;
     End;
     If(PCst=NIL)Then Begin
      CompileFile:=OutOfMemory;
      Exit;
     End;
     PCst^:=Cst;AddConst:=Ya;
    End
     Else
    Begin
     If Not XtrkString(S2)Then Begin
      CompileFile:=SyntaxError;
      Exit;
     End;
     If Length(S2)=1Then Begin
      Cst.Q.TypeDef:=tChar;
      Cst.Q.X.DataChar:=S2[1];
     End
      Else
     Begin
      Cst.Q.TypeDef:=tString;
      Cst.Q.X.Buf:=MemAlloc(Length(S2)+1);
      If(Cst.Q.X.Buf=NIL)Then Begin
       CompileFile:=OutOfMemory;
       Exit;
      End;
      Cst.Q.X.PString^:=S2;
     End;
     PCst:=RBIns(ReDef,SearchPosConst(Ok),SizeOf(CstRec));
     If(Ok)Then Begin
      CompileFile:=ConstDupl;
      Exit;
     End;
     If(PCst=NIL)Then Begin
      CompileFile:=OutOfMemory;
      Exit;
     End;
     PCst^:=Cst;
     AddConst:=Ya;
    End;
   End;
  End;
 End;

 Function AddType:Boolean;
 Var
  DefType:TypeMainRec;
  Ok:Bool;
  K:Byte;
  P:Word;
  PType:^TypeMainRec;
  VP:NoeudVarPasPtr;
  Box:Word;

  Function Sub(Var Pile:RBuf):Boolean;
  Label EndBranch;
  Var
   VType:^TypeRec;
   PointTo:Boolean;
  Begin
   RBInit(Pile);
   Sub:=No;
   Repeat
    If Box>0Then Begin
     S4:=XtrkWd;
     If(GetCodeMainWordPas(S4)=cmwpEnd)Then Goto EndBranch;
     If SI<>':'Then Exit;
     Inc(I);
    End;
    If SI='^'Then Begin
     Inc(I);
     PointTo:=Ya;
    End
     Else
    PointTo:=No;
    S2:=XtrkWd;
    Case GetCodeMainWordPas(S2)of
      { Traitement d'un tableau ®RECORD¯ }
     cmwpArray:Begin
      VType:=RBAdd(Pile,SizeOf(TypeRec));
      If(VType=NIL)Then Exit;
      FillClr(VType^,SizeOf(TypeRec));
      VType^.TypeDef:=tArray;
      VType^.PointTo:=PointTo;
      If Box>0Then VType^.Name:=S4
              Else VType^.Name:='';
      Case(SI)of
       '[':Inc(I);
       '(':Begin
        Inc(I);
        If SI<>'.'Then Exit;
       End;
       Else Exit;
      End;
      Ok:=No;VType^.Min:=XtrkInteger(Ok);
      If Not(Ok)Then Exit;
      If SI<>'.'Then Exit;
      Inc(I);
      If SI<>'.'Then Exit;
      Inc(I);
      Ok:=No;VType^.Max:=XtrkInteger(Ok);
      If Not(Ok)Then Exit;
      Case(SI)of
       ']':Inc(I);
       '.':Begin
        Inc(I);
        If SI<>')'Then Exit;
       End;
       Else Exit;
      End;
      S2:=XtrkWd;
      If(GetCodeMainWordPas(S2)<>cmwpOf)Then Exit;
      S2:=XtrkWd;VP:=SearchVarPas(S2);
      If(VP=NIL)Then Exit;
      Case(VP^.TypeDef)of
       tBool,tByte,tShort,tChar,tInt,tWord,tLong,tPtr:VType^.ArrayTypeDef:=VP^.TypeDef;
       Else Exit;
      End;
     End;
     cmwpEnd:Begin
EndBranch:
      If Box=0Then Break;
      Dec(Box);
      Break;
     End;
      { Traitement d'une structure ®RECORD¯ }
     cmwpRecord:Begin
      Inc(Box);
      VType:=RBAdd(Pile,SizeOf(TypeRec));
      If(VType=NIL)Then Exit;
      FillClr(VType^,SizeOf(TypeRec));
      VType^.TypeDef:=tRec;
      VType^.PointTo:=PointTo;
      If Not Sub(VType^.Pile)Then Exit;
     End;
      { Type de variable simple }
     Else Begin
      VP:=SearchVarPas(S2);
      If(VP=NIL)Then Exit;
      Case(VP^.TypeDef)of
       tBool,tByte,tShort,tChar,tInt,tWord,tLong,tPtr:Begin
        VType:=RBAdd(Pile,SizeOf(TypeRec));
        If(VType=NIL)Then Exit;
        FillClr(VType^,SizeOf(TypeRec));
        VType^.TypeDef:=VP^.TypeDef;
        VType^.PointTo:=PointTo;
        If Box>0Then VType^.Name:=S4
                Else VType^.Name:='';
       End;
       Else Exit;
      End;
     End;
    End;
    If Box>0Then Begin
     If SI<>';'Then Exit;
     Inc(I);
    End;
   Until Box=0;
   Sub:=Ya;
  End;

 Begin
  FillClr(DefType,SizeOf(DefType));
  Box:=0;
  DefType.Name:=S3;
  AddType:=No;
  P:=SearchPosType(Ok);
  If(Ok)Then Exit;
  PType:=RBIns(TypeDef,P,SizeOf(TypeMainRec));
  If(PType=NIL)Then Begin
   CompileFile:=OutOfMemory;
   Exit;
  End;
  PType^:=DefType;AddType:=Sub(PType^.Struct);
 End;

 Procedure ParamRegister;
 Const
  ByteReg:Array[0..7]of Byte=(0,4,1,5,2,6,3,7);
 Var
  J,K:Integer;
  Size:Word;
  CurrReg:Byte;
  PVar,PVar2:^VarRec;
 Begin
  PProc^.ParamRegister:=Ya;CurrReg:=0;
  For J:=0to PProc^.Param.NB-1do Begin
   PVar:=_RBGetBuf(PProc^.Param,J);
   If(PVar<>NIL)Then Begin
    Case(PVar^.TypeDef)of
     tBool,tByte,tChar,tShort:Begin
      PVar^.Reg:=ByteReg[CurrReg];PVar^.SizeReg:=8;Inc(CurrReg);
      Size:=2;
     End;
     tWord,tInt:Begin
      If CurrReg and 1=1Then Inc(CurrReg);
      PVar^.Reg:=CurrReg shr 1;PVar^.SizeReg:=16;Inc(CurrReg,2);
      Size:=2;
     End;
     Else Break;
    End;
    Dec(StackPos,Size);
    RBSetPtr(PProc^.Param,J+1);
    For K:=J+1to PProc^.Param.NB-1do Begin
     PVar2:=_RBGetCurrBuf(PProc^.Param);
     If(PVar2<>NIL)Then Dec(PVar2^.Ofs,Size);
     RBNext(PProc^.Param);
    End;
   End;
  End;
 End;

Begin
 CompileFile:=0;NL:=0;
 RBInit(TPile);
 InitCompiler;
 {$IFDEF IDE}
  If(Name=XEdt^.EditName)Then Begin
   Handle:=50;
   RBSetPtr(XEdt^.List,0);
  End
   Else
  Handle:=FileOpen(Name,fmRead);
 {$ELSE}
  Handle:=Open(Name,fmRead);
 {$ENDIF}
 If(Handle=errHdl)Then Begin
  CompileFile:=FileNotFound;
  Exit;
 End;
 FP:=0;FS:=FileSize(Handle);
 Repeat
  S:=ReadLn;
  While I<=Length(S)do Begin
   S2:=XtrkWd;
Restart:
   R:=GetCodeMainWordPas(S2);
   Case(R)of
    cmwpUses:Begin
     S3:=XtrkWd;
     If S3=''Then Begin
      CompileFile:=UnitNameExpected;
      Goto Err;
     End;
     If Not UnitInList(S3)Then Begin
      CompileFile:=DuplDefUnit;
      Goto Err;
     End;
     If UnitUpgrade(S3)Then Begin
      OD:=SaveData;
      RBInit(UnitList);
      {$IFDEF IDE}
       WEPutTxtXY(WC,33,0,'Recompile l''unit‚ '+S3+'...');
      {$ELSE}
       WriteLn('Recompile l''unit‚ ',S3,'...');
      {$ENDIF}
      W:=CompileFile(S3+'.PAS',TL);
      If W<>0Then Begin
       CompileFile:=W;
       Goto Err;
      End;
      InitCompiler;
      RestoreData(OD);
     End;
     RBAddStr(UnitList,S3);
     If SI<>';'Then Begin
      CompileFile:=PointCommaExpected;
      Goto Err;
     End;
     Inc(I);
    End;
    cmwpUnit:Begin
     If UnitList.NB>1Then Begin
      CompileFile:=MisplacedUnit;
      Goto Err;
     End;
     If(ProgramFormat=fCOM)Then ProgramFormat:=fUnitLarge
      Else
     Begin
      CompileFile:=MisplacedUnit;
      Goto Err;
     End;
     SuggName:=XtrkWd;
     If SuggName='SYSTEM'Then Begin
      RBDone(UnitList);
      RBInit(UnitList)
     End;
     If SI<>';'Then Begin
      CompileFile:=PointCommaExpected;
      Goto Err;
     End;
     Inc(I);IP:=0;Org:=0;
    End;
    cmwpType:Begin
     S3:=XtrkWd;
     Repeat
      If SI<>'='Then Begin
       CompileFile:=EqualExpected;
       Goto Err;
      End;
      Inc(I);
      If Not(AddType)Then Goto Err;
      If SI<>';'Then Begin
       CompileFile:=PointCommaExpected;
       Goto Err;
      End;
      Inc(I);
      S3:=XtrkWd;
      If S3=''Then Break;
      Case GetCodeMainWordPas(S3)of
       cmwpError:;
        { Le type ®FILE OF¯ est autoris‚ dans l'unit‚ ®SYSTEM¯ seulement!}
       cmwpFile:If SuggName<>'SYSTEM'Then Goto FinishType;
       Else Begin
FinishType:
        S2:=S3;
        Goto Restart;
       End;
      End;
     Until No;
    End;
    cmwpProgram:If(ProgramFormat)in[fBOOT,fCOM,fEXE]Then Begin
     SuggName:=XtrkWd;
     If SuggName=''Then Begin
      CompileFile:=NamePrgExpected;
      Goto Err;
     End;
     If SI<>';'Then Begin
      CompileFile:=PointCommaExpected;
      Goto Err;
     End;
     Inc(I);
    End
     Else
    Begin
     CompileFile:=SyntaxError;
     Goto Err;
    End;
    cmwpMacro:Begin
     If Not(MakeMacro)Then Goto Err;
    End;
    cmwpInterface:Begin
     If(ProgramFormat)in[fUnitTiny,fUnitLarge]Then Body:=bINTERFACE
      Else
     Begin
      CompileFile:=MisplacedInterface;
      Goto Err;
     End;
    End;
    cmwpImplementation:Begin
     If(ProgramFormat)in[fUnitTiny,fUnitLarge]Then Begin
      MakeHeaderUnit(Name);
      Body:=bIMPLEMENTATION;
      RBAddStr(UnitList,SuggName);
     End
      Else
     Begin
      CompileFile:=MisplacedImplementation;
      Goto Err;
     End;
    End;
    cmwpConst:Begin
     Ok:=No;
     Repeat
      S3:=XtrkWd;
      If(Ok)Then Begin
       If(GetCodeMainWordPas(S3)<>cmwpError)Then Begin
        S2:=S3;
        Goto Restart;
       End;
      End;
      If S3=''Then Begin
       CompileFile:=ConstNameExpected;
       Goto Err;
      End;
      If SI=':'Then Begin { Variable ? }
       Inc(I);S4:=XtrkWd;
       If S4=''Then Begin
        CompileFile:=IdentifierExpected;
        Goto Err;
       End;
       W:=Variable(tSegDes);
       If W<>0Then Begin
        CompileFile:=W;
        Goto Err;
       End;
       PVar^.QParam:=qConst;
       If SI<>'='Then Begin
        CompileFile:=SyntaxError;
        Goto Err;
       End;
       Inc(I);
       If XtrkFormule(V,No,R)Then PVar^.X:=V.X
        Else
       Begin
        CompileFile:=SyntaxError;
        Goto Err;
       End;
      End
       Else
      Begin
       If SI<>'='Then Begin
        CompileFile:=SyntaxError;
        Goto Err;
       End;
       Inc(I);
       If Not(AddConst)Then Exit;
      End;
      If SI<>';'Then Begin
       CompileFile:=PointCommaExpected;
       Goto Err;
      End;
      Inc(I);Ok:=Ya;
     Until No
    End;
    cmwpCSConst:Begin
     Repeat
      S3:=XtrkWd;
      If S3='DB'Then Begin
       W:=DataAsm(DB);
       If W<>0Then Begin
        CompileFile:=W;
        Exit;
       End;
      End
       Else
      If S3='DD'Then Begin
       W:=DataAsm(DD);
       If W<>0Then Begin
        CompileFile:=W;
        Exit;
       End;
      End
       Else
      If S3='DW'Then Begin
       W:=DataAsm(DW);
       If W<>0Then Begin
        CompileFile:=W;
        Exit;
       End;
      End
       Else
      If(GetCodeMainWordPas(S3)=cmwpEnd)Then Break;
     Until No;
     If SI<>';'Then Begin
      CompileFile:=PointCommaExpected;
      Goto Err;
     End;
     Inc(I);
    End;
    cmwpVar:Begin
     Ok:=No;tSegDes:=vDS;
     Repeat
      S3:=XtrkWd;
      If(Ok)Then Begin
       If(GetCodeMainWordPas(S3)<>cmwpError)Then Begin
        S2:=S3;
        Goto Restart;
       End;
      End
       Else
      Begin
       If(S3='CODE')or(S3='CS')or(S3='CSEG')or(S3='PREFIXSEG')or
         (S3='DEFAULT')or(S3='STANDARD')Then Begin
        tSegDes:=vCS;
        S3:=XtrkWd;
       End
        Else
       If(S3='DATA')or(S3='DS')or(S3='DSEG')Then Begin
        tSegDes:=vDS;
        S3:=XtrkWd;
       End
        Else
       If(S3='EXTRA')or(S3='ES')Then Begin
        tSegDes:=vES;
        S3:=XtrkWd;
       End
        Else
       If S3='FS'Then Begin
        tSegDes:=vFS;
        S3:=XtrkWd;
       End
        Else
       If S3='GS'Then Begin
        tSegDes:=vGS;
        S3:=XtrkWd;
       End
        Else
       If(S3='STACK')or(S3='SS')or(S3='SSEG')Then Begin
        tSegDes:=vSS;
        S3:=XtrkWd;
       End;
      End;
      If S3=''Then Begin
       CompileFile:=ConstNameExpected;
       Goto Err;
      End;
      If SI<>':'Then Begin
       CompileFile:=ColonExpected;
       Goto Err;
      End;
      Inc(I);S4:=XtrkWd;
      If S4=''Then Begin
       CompileFile:=IdentifierExpected;
       Goto Err;
      End;
      W:=Variable(tSegDes);
      PVar^.QParam:=qNone;
      If W<>0Then Begin
       CompileFile:=W;
       Goto Err;
      End;
      If SI<>';'Then Begin
       CompileFile:=PointCommaExpected;
       Goto Err;
      End;
      Inc(I);
      Ok:=Ya;
     Until No;
    End;
    cmwpProcedure,cmwpFunction:Begin
     ProcName:=XtrkWd;StackPos:=0;StackParam:=0;VarPosProc:=VarBk.NB;
     If ProcName=''Then Begin
      CompileFile:=IdentifierExpected;
      Goto Err;
     End;
     PProc:=PtrProc(ProcName);
     If(PProc<>NIL)Then Begin;CompileFile:=DuplExpression;Goto Err;End;
     PProc:=RBIns(ProcBk,SearchPosProc(ProcName,Ok),SizeOf(ProcRec));
     If(PProc=NIL)Then Begin;CompileFile:=OutOfMemory;Goto Err;End;
     PProc^.Func:=R=cmwpFunction;
     PProc^.Name:=ProcName;PProc^.Ofs:=IP;PProc^.CurrPtr:=CurrPointer;
     PProc^.Free:=No;PProc^.Dupl:=No;PProc^.ParamRegister:=No;
     RBInit(PProc^.Param);
     VarInProc:=No;{S'il y a des paramŠtres, fixer … vrai...}
     If SI='('Then Begin { ParamŠtre dans la proc‚dure... }
      Inc(I);VarInProc:=Ya;
      Repeat
       RBInit(TPile);
       S3:=XtrkWd;
       Case GetCodeMainWordPas(S3)of
        cmwpVar:Begin;QParam:=qVar;S3:=XtrkWd;End;
        cmwpConst:Begin;QParam:=qConst;S3:=XtrkWd;End;
        Else QParam:=qNone;
       End;
       RBAddStr(TPile,S3);
       If S3=''Then Begin;CompileFile:=ConstNameExpected;Goto Err;End;
       While SI=','do Begin
        Inc(I);S3:=XtrkWd;
        If S3=''Then Begin;CompileFile:=ConstNameExpected;Goto Err;End;
        RBAddStr(TPile,S3);
       End;
       If SI=':'Then Begin
        Inc(I);S4:=XtrkWd;
        If S4=''Then Begin;CompileFile:=IdentifierExpected;Goto Err;End;
       End
        Else
       If(QParam=qNone)Then Begin;CompileFile:=ColonExpected;Goto Err;End
                       Else S4:='';
       RBSetPtr(TPile,0);
       For J:=0to TPile.NB-1do Begin
        S3:=StrPas(PChr(_RBGetCurrBuf(TPile)));
        W:=LocalVariable(vSSParam,QParam);
        If W<>0Then Begin;CompileFile:=W;Goto Err;End;
        TVar:=RBAdd(PProc^.Param,SizeOf(VarRec));
        If(TVar=NIL)Then Begin;CompileFile:=OutOfMemory;Goto Err;End;
        TVar^:=PVar^;
        RBNext(TPile);
       End;
       RBDone(TPile);
       Case(SI)of
        ')':Break;
        ';':Inc(I);
        Else Begin;CompileFile:=CloseParExpected;Goto Err;End;
       End;
      Until No;
      Inc(I);
     End;
     If(R=cmwpFunction)and(SI=':')Then Begin
      Inc(I);S3:=XtrkWd;VP:=SearchVarPas(S3);
      If(VP=NIL)Then Begin;CompileFile:=UnknownIdentifier;Goto Err;End
       Else
      Begin
       PProc^.Return.TypeDef:=VP^.TypeDef;PProc^.Return.Size:=VP^.Size;
      End;
     End;
     If SI<>';'Then Begin;CompileFile:=PointCommaExpected;Goto Err;End;
     Inc(I);S3:=XtrkWd;W:=GetCodeMainWordPas(S3);
     Case(W)of
      cmwpRegister:Begin
       ParamRegister;
       If SI<>';'Then Begin;CompileFile:=PointCommaExpected;Goto Err;End;
       Inc(I);S3:=XtrkWd;
      End;
      cmwpFar,cmwpNear:Begin
       PProc^.CurrPtr:=W;
       If SI<>';'Then Begin;CompileFile:=PointCommaExpected;Goto Err;End;
       Inc(I);S3:=XtrkWd;
      End;
     End;
     Case GetCodeMainWordPas(S3)of
      cmwpDuplicate:If(Body=bINTERFACE)Then Begin
       S3:=XtrkWd;PProc^.Parent:=PtrProc(S3);
       If(PProc^.Parent=NIL)Then Begin;CompileFile:=UnknownIdentifier;Goto Err;End;
       If SI<>';'Then Begin;CompileFile:=PointCommaExpected;Goto Err;End;
       Inc(I);S3:=XtrkWd;PProc^.Dupl:=Ya;
      End;
     End;
     If(Body=bINTERFACE)Then Begin
      S2:=S3;
      If(VarInProc)Then Begin
       For J:=VarBk.NB-1downto(VarPosProc)do RBDelBuf(VarBk,J);
      End;
      Goto Restart;
     End
      Else
     Begin
      If(Body=bIMPLEMENTATION)Then Begin
       Inc(GhostCode,IP);IP:=0;PrevIP:=$FFFF;
      End;
      ProcAsm:=No;
      If(GetCodeMainWordPas(S3)=cmwpAssembler)Then Begin
       ProcAsm:=Ya;
       If SI<>';'Then Begin;CompileFile:=PointCommaExpected;Goto Err;End;
       Inc(I);
       S3:=XtrkWd;
      End;
      If(GetCodeMainWordPas(S3)=cmwpVar)Then Begin
       Ok:=No;VarInProc:=Ya;
       Repeat
        S3:=XtrkWd;
        If S3=''Then Begin;CompileFile:=ConstNameExpected;Goto Err;End;
        If(Ok)Then Begin
         If(GetCodeMainWordPas(S3)<>cmwpError)Then Break;
        End;
        If SI<>':'Then Begin;CompileFile:=ColonExpected;Goto Err;End;
        Inc(I);S4:=XtrkWd;
        If S4=''Then Begin;CompileFile:=IdentifierExpected;Goto Err;End;
        W:=LocalVariable(vSS,qNone);
        If W<>0Then Begin;CompileFile:=W;Goto Err;End;
        TVar:=RBAdd(PProc^.Param,SizeOf(VarRec));
        If(TVar=NIL)Then Begin;CompileFile:=OutOfMemory;Goto Err;End;
        TVar^:=PVar^;
        Ok:=Ya;
        If SI<>';'Then Begin CompileFile:=PointCommaExpected;Goto Err;End;
        Inc(I);
       Until No;
{       S3:=XtrkWd;}
      End;
      If(ProcAsm)Then Begin
       If(GetCodeMainWordPas(S3)<>cmwpAsm)Then Begin;CompileFile:=BeginExpected;Goto Err;End;
      End
       Else
      If Not(GetCodeMainWordPas(S3)in[cmwpBegin,cmwpAsm])Then Begin;CompileFile:=BeginExpected;Goto Err;End;
      If(VarInProc)and(StackPos>0)Then Begin
       If(InstrFormat>=p186)Then Begin
        PushByte($C8);        { ENTER StackPos,0}
        PushAddWord(StackPos);
        PushAddByte(0);
       End
        Else
       Begin
        Push3Byte(ciPushBP,                       { PUSH BP }
                  Lo(ciMovBP_SP),Hi(ciMovBP_SP)); { MOV BP,SP }
        PushInstr(#$81#$EC);                      { SUB SP,StackPos }
        PushAddWord(StackPos);
       End;
      End;
      If(ProcAsm)Then W:=CompileAsm(No)
                 Else W:=CompileInstr(No);
      If W<>0Then Begin;CompileFile:=W;Goto Err;End;
      If(VarInProc)and(StackPos>0)Then Begin
       If(InstrFormat>=p186)Then PushByte($C9) { LEAVE }
        Else
       Push3Byte($89,$EC,    { MOV SP,BP }
                 ciPopBP);   { POP BP }
      End;
      PProc:=PtrProc(ProcName);
      If(PProc^.CurrPtr=cmwpNear)Then Begin
       If StackPos=0Then PushByte(ciRETN)
        Else
       Begin
        PushByte($C2);
        PushAddWord(StackPos);
       End;
      End
       Else
      Begin
       If StackPos=0Then PushByte(ciRETF)
        Else
       Begin
        PushByte($CA);
        PushAddWord(StackPos);
       End;
      End;
      If SI<>';'Then Begin;CompileFile:=SemicolonExpected;Goto Err;End;
      Inc(I);
      LinkJump;
      If(Body=bIMPLEMENTATION)Then DumpUnitProc(ProcName);
      If(VarInProc)Then Begin
       For J:=VarBk.NB-1downto(VarPosProc)do RBDelBuf(VarBk,J);
      End;
     End;
    End;
    cmwpAsm:Begin
     If IP=Org+3Then Dec(IP,3)
      Else
     Begin
      CodePrg^[Org]:=ciJMP_Word;
      W:=IP-(Org+3);
      CodePrg^[Org+1]:=Lo(W);
      CodePrg^[Org+2]:=Hi(W);
     End;
     W:=CompileAsm(No);
     If W<>0Then Begin;CompileFile:=W;Goto Err;End;
     If SI<>'.'Then Begin;CompileFile:=CommaExpected;Goto Err;End;
     Inc(I);
     LinkJump;
    End;
    cmwpBegin:Begin { Programme Principal }
     If IP=Org+3Then Dec(IP,3) { Jmp juste en avant de soit c'est imb‚cile...}
      Else
     Begin
      CodePrg^[Org]:=ciJMP_Word;
      W:=IP-(Org+3);
      CodePrg^[Org+1]:=Lo(W);
      CodePrg^[Org+2]:=Hi(W);
     End;
     If(ProgramFormat=fEXE)Then Begin
      Case(ProgramTarget)of
       ftDOS:PushInstr(#$0E#$1F);
       ftWin31:PushInstr(#$9A#$FF#$FF#$00#$00);
      End;
     End;
     W:=CompileInstr(No);
     If W<>0Then Begin;CompileFile:=W;Goto Err;End;
     If SI<>'.'Then Begin;CompileFile:=CommaExpected;Goto Err;End;
     Inc(I);
     If Not((ProgramFormat)in[fUnitTiny,fUnitLarge])Then LinkJump;
    End;
    cmwpEnd:If(ProgramFormat)in[fUnitTiny,fUnitLarge]Then Begin { Fin d'unit‚? }
     If SI<>'.'Then Begin;CompileFile:=CommaExpected;Goto Err;End;
     Inc(I);
     Break;
    End
     Else
    Begin;CompileFile:=SyntaxError;Goto Err;End;
    Else Begin;CompileFile:=SyntaxError;Goto Err;End;
   End;
   If(EOF)Then Break;
  End;
 Until EOF;
Err:
 RBDone(TPile);
 If Handle<50Then FileClose(Handle);
 If(ProgramFormat)in[fUnitTiny,fUnitLarge]Then Begin
  If VarBk.NB>0Then Begin
   RBSetPtr(VarBk,0);
   For I:=0to VarBk.NB-1do Begin
    PVar:=_RBGetCurrBuf(VarBk);
    If(PVar<>NIL)Then Begin
     RBDone(PVar^.ExternType^.Pile);
     FreeMem(PVar^.ExternType,SizeOf(TypeRec));
    End;
    RBNext(VarBk);
   End;
  End;
  RBDone(VarBk);      { Initialise la liste des variables }
  RBDone(ReDef);      { Initialise la liste des constantes }
  If ProcBk.NB>0Then Begin
   RBSetPtr(ProcBk,0);
   For I:=0to ProcBk.NB-1do Begin
    PProc:=_RBGetCurrBuf(ProcBk);
    If(PProc<>NIL)Then Begin
{     If(PProc^.Return.ExternType<>NIL)Then Begin
      RBDone(PProc^.Return.ExternType^.Pile);
      FreeMem(PProc^.Return.ExternType,SizeOf(TypeRec));
     End;}
     RBDone(PProc^.Param);
    End;
    RBNext(ProcBk);
   End;
  End;
  RBDone(ProcBk);     { Initialise la liste des proc‚dures }
  RBDone(UnitList);   { Initialise la liste des unit‚s }
  RBDone(Include);    { Initialise la liste des inclusions }
  RBDone(Jump);       { Initialise la liste des sauts }
  RBDone(SuppData);   { Initialise la liste des donn‚es suppl‚mentaires }
  RBDone(Macro);      { Initialise la liste des Macros }
  RBDone(ExternProc); { Initialise la liste des routines externes }
  RBDone(ExternVar);  { Initialise la liste des variables externes }
  RBDone(TypeDef);    { Initialise la liste des types }
 End;
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
END.