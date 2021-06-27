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

Function CompileFile(Const Name:PathStr;Var NL:LongInt):Integer;
Function CompileInstr(OneInstr:Boolean):Integer;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                               IMPLEMENTATION
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses Memories,Systems,PCCortex,PCData,PCLine,PCBase,PCAsm,
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
 StackCase:ArrayList;
 SCP:StackCasePtr;
 MyCase,MyIf:Word;
 PJump:JumpPtr;
 UnitProc:UnitProcRec;
 Handle:Hdl;
 ParamHeader:Array[0..2]of Byte;
Begin
 CompileInstr:=0;LR:=$FFFF;R:=$FFFF;InBegin:=0;
 ALInit(StackCase);
 Repeat
  CurrPC.S3:=XtrkWd;
  LR:=R;
  R:=GetCodeMainWordPas(CurrPC.S3);
  Case(R)of
   cmwpAsm:Begin
    CurrPC.W:=CompileAsm(No);
    If CurrPC.W<>0Then Begin
     CompileInstr:=CurrPC.W;
     Goto Exit;
    End;
   End;
   cmwpBegin:Begin
    Inc(InBegin);
    CurrPC.W:=CompileInstr(No);
    If CurrPC.W<>0Then Begin
     CompileInstr:=CurrPC.W;
     Goto Exit;
    End;
   End;
   cmwpCase:Begin
    If Not XtrkFormule(Q,Ya,K)Then Begin
     CompileInstr:=SyntaxError;
     Goto Exit;
    End;
    If Not AddJump(isLabel,CurrPC.IP,'#cas'+WordToStr(CurrPC.CaseLevel))Then Begin
     CompileInstr:=LabelDupl;
     Goto Exit;
    End;
    MyCase:=CurrPC.CaseLevel;Inc(CurrPC.CaseLevel);
    ALInit(StackCase);
    Repeat
     If Not XtrkFormule(Q2,Ya,K)Then Begin
      CompileInstr:=SyntaxError;
      Goto Exit;
     End;
     If K<>$FFThen Begin
      CompileInstr:=SyntaxError;
      Goto Exit;
     End;
     SCP:=ALAdd(StackCase,SizeOf(StackCaseRec));
     If(SCP=NIL)Then Begin
      CompileInstr:=OutOfMemory;
      Goto Exit;
     End;
     SCP^.Q:=Q2;
     SCP^.IP:=CurrPC.IP;
     CurrPC.W:=CompileInstr(Ya);
     If CurrPC.W<>0Then Begin
      CompileInstr:=CurrPC.W;
      Goto Exit;
     End;
     SaveAddr;
     CurrPC.S3:=XtrkWd;
     If(GetCodeMainWordPas(CurrPC.S3)=cmwpEnd)Then Break;
     RestoreAddr;
    Until No;
    If Not AddJump(isLabel,CurrPC.IP,'#fcas'+WordToStr(CurrPC.CaseLevel))Then Begin
     CompileInstr:=LabelDupl;
     Goto Exit;
    End;
    PJump:=SearchJump('#cas'+WordToStr(CurrPC.CaseLevel),isLabel);
    CurrPC.S5:='';
    ALSetPtr(StackCase,0);
    For Iw:=0to StackCase.Count-1do Begin
     SCP:=_ALGetCurrBuf(StackCase);
     IncStr(CurrPC.S5,SCP^.Q.X.DataChar);
     ALNext(StackCase);
    End;
    ALAddStrWord(CurrPC.SuppData,CurrPC.S5,PJump^.Off+3);
    CurrPC.S4:=#$0E#$07+                                     { MOV ES,CS }
               #$BF#$00#$00+                                 { MOV DI,0000 }
               #$B1+Chr(StackCase.Count)+Chr(Hi(StackCase.Count))+ { MOV CX,Nombre de cas }
               #$AE;                                         { SCASB }
    InsertCode('#cas'+WordToStr(MyCase),CurrPC.S4);
    ALDone(StackCase);
   End;
   cmwpEnd:If InBegin>=0Then Break
    Else
   Begin
    CompileInstr:=MisplacedEndSymbol;
    Goto Exit;
   End;
   cmwpIf:Begin
    MyIf:=CurrPC.IfLevel;
    Inc(CurrPC.IfLevel);
    If Not XtrkFormule(Q,Ya,K)Then Begin
     CompileInstr:=SyntaxError;
     Goto Exit;
    End;
    PushInstr(#$50);     { PUSH AX }
    Case(SI)of
     '=':Begin
      Inc(CurrPC.I);
      Iw:=0;
     End;
     '<':Begin
      Inc(CurrPC.I);
      Iw:=1;
     End;
     '>':Begin
      Inc(CurrPC.I);
      Iw:=2;
     End;
    End;
    If Not XtrkFormule(Q2,Ya,K)Then Begin
     CompileInstr:=SyntaxError;
     Goto Exit;
    End;
    PushInstr(#$5A+      { POP DX }
              #$3B#$C2); { CMP AX,DX }
    If Not AddJump(isJump,CurrPC.IP,'#sinon'+WordToStr(MyIf))Then Begin
     CompileInstr:=OutOfMemory;
     Goto Exit;
    End;
    Case(Iw)of
     0:Push2Byte($75{JNZ},0);
     1:Push2Byte($77{JA},0);
     2:Push2Byte($72{JB},0);
    End;
    CurrPC.S3:=XtrkWd;
    If(GetCodeMainWordPas(CurrPC.S3)<>cmwpThen)Then Begin
     CompileInstr:=ThenExpected;
     Goto Exit;
    End;
    CurrPC.W:=CompileInstr(No);
    If CurrPC.W<>0Then Begin
     CompileInstr:=CurrPC.W;
     Goto Exit;
    End;
    If SI=';'Then Begin
     Inc(CurrPC.I);
     If Not AddJump(isLabel,CurrPC.IP,'#sinon'+WordToStr(MyIf))Then Begin
      CompileInstr:=OutOfMemory;
      Goto Exit;
     End;
    End
     Else
    Begin
     If Not AddJump(isJump,CurrPC.IP,'#fsi'+WordToStr(MyIf))Then Begin
      CompileInstr:=OutOfMemory;
      Goto Exit;
     End;
     Push2Byte($EB{JMP},0);
     CurrPC.S3:=XtrkWd;
     If(GetCodeMainWordPas(CurrPC.S3)<>cmwpElse)Then Begin
      CompileInstr:=SyntaxError;
      Goto Exit;
     End;
     CurrPC.W:=CompileInstr(No);
     If CurrPC.W<>0Then Begin
      CompileInstr:=CurrPC.W;
      Goto Exit;
     End;
     If Not AddJump(isLabel,CurrPC.IP,'#fsi'+WordToStr(MyIf))Then Begin
      CompileInstr:=OutOfMemory;
      Goto Exit;
     End;
    End;
    Dec(CurrPC.IfLevel);
   End;
   cmwpInLine:Begin
    If SI<>'('Then Begin
     CompileInstr:=OpenParExpected;
     Goto Exit;
    End;
    Repeat
     Inc(CurrPC.I);
     CurrPC.l1:=XtrkInteger(CurrPC.Ok);
     If CurrPC.l1>$FFThen Push2Byte(Lo(CurrPC.l1),Hi(CurrPC.l1))
                     Else PushByte(CurrPC.l1);
     If Not(SI in[')','/'])Then Begin
      CompileInstr:=SyntaxError;
      Goto Exit;
     End;
    Until SI=')';
    Inc(CurrPC.I);
   End;
   cmwpInterrupt:Goto __Int;
   Else Begin
    ALSetPtr(CurrPC.ProcBk,0);
    CurrPC.Ok:=No;
    CurrPC.PProc:=_ALGetCurrBuf(CurrPC.ProcBk);
    While(CurrPC.PProc<>NIL)do Begin
     If(CurrPC.PProc^.Name=CurrPC.S3)Then Begin
      If CurrPC.PPRoc^.Param.Count>0Then Begin
       If SI<>'('Then Begin
        CompileInstr:=OpenParExpected;
        Goto Exit;
       End;
       Inc(CurrPC.I);
       CurrPC.Ok:=No;
       ALSetPtr(CurrPC.PProc^.Param,0);
       For J:=0to CurrPC.PProc^.Param.Count-1do Begin
        TVar:=_ALGetCurrBuf(CurrPC.PProc^.Param);
        If(TVar^.TypeDef=tString)Then Begin
         If Not XtrkString(CurrPC.S4)Then Begin
          CompileInstr:=SyntaxError;
          Goto Exit;
         End;
         PushByte($1E);      { PUSH DS }
         ALAddStrWord(CurrPC.SuppData,Chr(Length(CurrPC.S4))+CurrPC.S4,CurrPC.IP+1);
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
        ALNext(CurrPC.PProc^.Param);
        If J<CurrPC.PProc^.Param.Count-1Then Begin
         If SI<>','Then Begin
          CompileInstr:=VirguleExpected;
          Goto Exit;
         End;
         Inc(CurrPC.I);
        End;
       End;
       If SI<>')'Then Begin
        CompileInstr:=CloseParExpected;
        Goto Exit;
       End;
       Inc(CurrPC.I);
      End;
      CurrPC.W:=CurrPC.PProc^.Ofs-(CurrPC.IP+3);
      If(CurrPC.PPRoc^.CurrPtr=cmwpFar)Then Begin
       PushByte(ciPushCS);
       Dec(CurrPC.W)
      End;
      PushInstrOffset(asmCallNear,CurrPC.W);
      CurrPC.Ok:=Ya;
      LR:=$FFFF;
      Break;
     End;
     ALNext(CurrPC.ProcBk);
     CurrPC.PProc:=_ALGetCurrBuf(CurrPC.ProcBk);
    End;
    If Not(CurrPC.Ok)Then Begin
     CurrPC.Ok:=SearchProcList(CurrPC.S3,UnitNum,AddrUnit);
     If(CurrPC.Ok)Then Begin
      CurrPC.S5:=StrPas(PChr(_ALGetBuf(CurrPC.UnitList,UnitNum)));
      {Handle:=FileOpen(CurrPC.S5+'.UPC',fmRead);}
      Handle:=OpenUnit(CurrPC.S5);
      If(Handle<>errHdl)Then Begin
       _GetAbsRec(Handle,AddrUnit,SizeOf(UnitProc),UnitProc);
      End;
      If UnitProc.NmParam>0Then Begin
       If SI<>'('Then Begin
        CompileInstr:=OpenParExpected;
        Goto Exit;
       End;
       Inc(CurrPC.I);
       TL:=AddrUnit+SizeOf(UnitProc)-SizeOf(String)+1+Length(UnitProc.Name);
       For J:=0to UnitProc.NmParam-1do Begin
        _GetAbsRec(Handle,TL,SizeOf(ParamHeader),ParamHeader);
        Inc(TL,SizeOf(ParamHeader));
        If(DefType(ParamHeader[1])=tString)Then Begin
         If Not XtrkString(CurrPC.S4)Then Begin
          CompileInstr:=SyntaxError;
          Goto Exit;
         End;
         PushByte($1E);      { PUSH DS }
         ALAddStrWord(CurrPC.SuppData,Chr(Length(CurrPC.S4))+CurrPC.S4,CurrPC.IP+1);
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
         Inc(CurrPC.I);
        End;
       End;
       If SI<>')'Then Begin
        CompileInstr:=CloseParExpected;
        Goto Exit;
       End;
       Inc(CurrPC.I);
      End;
      FileClose(Handle);
      AddExternProcAddr(UnitNum,AddrUnit,CurrPC.IP+1,CurrPC.S3);
      PushInstrOffset(asmCallNear,CurrPC.W);
     End;
    End;
    If Not(CurrPC.Ok)Then Begin
     R:=GetCodeInstrPas(CurrPC.S3,J);
     Case(R)of
      cipWrite,cipWriteLn:Begin
       If SI<>'('Then Begin
        CompileInstr:=OpenParExpected;
        Goto Exit;
       End;
       Inc(CurrPC.I);
       If Not XtrkString(CurrPC.S4)Then Begin
        CompileInstr:=SyntaxError;
        Goto Exit;
       End;
       If(r=cipWriteLn)Then AddStr(CurrPC.S4,#13#10);
       ALAddStrWord(CurrPC.SuppData,CurrPC.S4+'$',CurrPC.IP+1);
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
       Inc(CurrPC.I);
      End;
      cipReadLn:Begin
       PushInstr(LoadProc(@AsmReadLn,Ofs(EndAsmReadLn)-Ofs(AsmReadLn)-1));
      End;
      cipPort,cipPortW:Begin
       If SI<>'['Then Begin
        CompileInstr:=OpenArrayExpected;
        Goto Exit;
       End;
       Inc(CurrPC.I);
       CurrPC.l1:=XtrkInteger(CurrPC.Ok);
       If Not(CurrPC.Ok)Then Begin
        CompileInstr:=SyntaxNumber;
        Goto Exit;
       End;
       If LongRec(CurrPC.l1).Hi and$7FFF>0Then Begin
        CompileInstr:=TooBigNumber;
        Goto Exit;
       End;
       If SI<>']'Then Begin
        CompileInstr:=CloseArrayExpected;
        Goto Exit;
       End;
       Inc(CurrPC.I);
       If SI<>':'Then Begin
        CompileInstr:=ColonExpected;
        Goto Exit;
       End;
       Inc(CurrPC.I);
       If SI<>'='Then Begin
        CompileInstr:=EqualExpected;
        Goto Exit;
       End;
       Inc(CurrPC.I);
       CurrPC.l2:=XtrkInteger(CurrPC.Ok);
       If Not(CurrPC.Ok)Then Begin
        CompileInstr:=SyntaxNumber;
        Goto Exit;
       End;
       Push3Byte(ciMovDX_Word,Lo(CurrPC.l1),Hi(CurrPC.l1));
       If(R=cipPort)Then Begin
        Push2Byte(ciMovAL_Byte,CurrPC.l2);
        PushByte(ciOutDX_AL);
       End
        Else
       Begin
        Push3Byte(ciMovAX_Word,CurrPC.l2,Hi(Wd(CurrPC.l2)));
        PushByte(ciOutDX_AX);
       End;
      End;
      cipMem,cipMemW:Begin
       If SI<>'['Then Begin
        CompileInstr:=OpenArrayExpected;
        Goto Exit;
       End;
       Inc(CurrPC.I);CurrPC.S4:=XtrkWd;
       If SI<>':'Then Begin
        CompileInstr:=ColonExpected;
        Goto Exit;
       End;
       Inc(CurrPC.I);
       CurrPC.S5:=XtrkWd;
       If CurrPC.S5[1]='_'Then K:=GetCodeRegAsm(Copy(CurrPC.S5,2,255),J)
                          Else J:=$FF;
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
        Inc(CurrPC.I);
        CurrPC.l1:=XtrkInteger(_Ok);
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
       Inc(CurrPC.I);
       If SI<>':'Then Begin
        CompileInstr:=ColonExpected;
        Goto Exit;
       End;
       Inc(CurrPC.I);
       If SI<>'='Then Begin
        CompileInstr:=EqualExpected;
        Goto Exit;
       End;
       Inc(CurrPC.I);
       CurrPC.l2:=XtrkInteger(CurrPC.Ok);
       If Not(CurrPC.Ok)Then CurrPC.S6:=XtrkWd
                        Else CurrPC.S6:='';
       If CurrPC.S4='_SS'Then PushByte(ciSS)Else
       If CurrPC.S4='_GS'Then PushByte(ciGS)Else
       If CurrPC.S4='_FS'Then PushByte(ciFS)Else
       If CurrPC.S4='_ES'Then PushByte(ciES)Else
       If CurrPC.S4='_DS'Then PushByte(ciDS)Else
       If CurrPC.S4='_CS'Then PushByte(ciCS)
       Else Begin
        CompileInstr:=SyntaxError;
        Goto Exit;
       End;
       If Not(CurrPC.Ok)Then Begin
        If(R=cipMemW)Then Begin
         If J=7Then Begin
          If(_Ok)and(CurrPC.S6='_DS')Then Begin
            { MOV [BX+??],DS }
           If CurrPC.l1>=$80Then PushInstrOffset(#$8C#$9F,CurrPC.l1)
                            Else Push3Byte($8C,$5F,CurrPC.l1);
          End
           Else
          If CurrPC.S6='_AX'Then PushInstr(asmMovAdrBX_AX)Else
          If CurrPC.S6='_CX'Then Push2Byte($89,$0F)Else
          If CurrPC.S6='_DX'Then Push2Byte($89,$17)Else
          If CurrPC.S6='_BX'Then Push2Byte($89,$1F)Else
          If CurrPC.S6='_DS'Then Push2Byte($8C,$1C)
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
        If(R=cipMem)Then Push3Byte($C6,J,CurrPC.l2)
                    Else Push3Byte($C7,J,CurrPC.l2);
       End;
      End;
      cipIntr,cipGenInterrupt:Begin
 __Int:If SI<>'('Then Begin
        CompileInstr:=OpenParExpected;
        Goto Exit;
       End;
       Inc(CurrPC.I);
       CurrPC.l1:=XtrkInteger(CurrPC.Ok);
       If Not(CurrPC.Ok)Then Begin
        CompileInstr:=SyntaxNumber;
        Goto Exit;
       End;
       If(LongRec(CurrPC.l1).Hi<>0)or(Hi(LongRec(CurrPC.l1).Lo)<>0)Then Begin
        CompileInstr:=TooBigNumber;
        Goto Exit;
       End;
       Push2Byte($CD,CurrPC.l1);
       If CurrPC.l1 in[$25,$26]Then Case(InstrFormat)of
        p88:PushInstr(#$81#$C4#$02#$00);
        Else Push3Byte($83,$C4,$02);
       End;
       If SI<>')'Then Begin
        CompileInstr:=CloseParExpected;
        Goto Exit;
       End;
       Inc(CurrPC.I);
      End;
      cipInc:Begin
       If SI<>'('Then Begin
        CompileInstr:=OpenParExpected;
        Goto Exit;
       End;
       Inc(CurrPC.I);CurrPC.S4:=XtrkWd;
       If CurrPC.S4=''Then Begin
        CompileInstr:=IdentifierExpected;
        Goto Exit;
       End;
       If CurrPC.S4[1]='_'Then K:=GetCodeRegAsm(Copy(CurrPC.S4,2,255),J)
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
       Inc(CurrPC.I);
      End;
      cipRunError,cipHalt:Begin
       If SI='('Then Begin
        Inc(CurrPC.I);
        CurrPC.l1:=XtrkInteger(_Ok);
        If Not(_Ok)Then Begin
         CompileInstr:=SyntaxNumber;
         Goto Exit;
        End;
        If SI<>')'Then Begin
         CompileInstr:=CloseParExpected;
         Goto Exit;
        End;
        Inc(CurrPC.I);
        PushInstr(#$B8+Char(CurrPC.l1)+#$4C+ { MOV AX,4C00h + l1 }
                  #$CD#$21);                 { INT 21h }
       End
        Else
       PushInstr(#$CD#$20);
      End;
      cipEnable,cipSTI:Begin
       If SI='('Then Begin
        Inc(CurrPC.I);
        If SI<>')'Then Begin
         CompileInstr:=CloseParExpected;
         Goto Exit;
        End;
        Inc(CurrPC.I);
       End;
       PushByte(ciSTI)
      End;
      cipDisable,cipCLI:Begin
       If SI='('Then Begin { Compatibilit‚ avec le C/C++ }
        Inc(CurrPC.I);
        If SI<>')'Then Begin
         CompileInstr:=CloseParExpected;
         Goto Exit;
        End;
        Inc(CurrPC.I);
       End;
       PushByte(ciCLI)
      End;
      cipDec:Begin
       If SI<>'('Then Begin
        CompileInstr:=OpenParExpected;
        Goto Exit;
       End;
       Inc(CurrPC.I);CurrPC.S4:=XtrkWd;
       If CurrPC.S4=''Then Begin
        CompileInstr:=IdentifierExpected;
        Goto Exit;
       End;
       If CurrPC.S4[1]='_'Then K:=GetCodeRegAsm(Copy(CurrPC.S4,2,255),J)
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
       Inc(CurrPC.I);
      End;
      cip_IF,cip_DF,cip_CF:Begin
       If SI<>':'Then Begin
        CompileInstr:=ColonExpected;
        Goto Exit;
       End;
       Inc(CurrPC.I);
       If SI<>'='Then Begin
        CompileInstr:=ColonExpected;
        Goto Exit;
       End;
       Inc(CurrPC.I);
       If(r<>cip_IF)Then CurrPC.S4:=XtrkWd;
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
         If CurrPC.S4='NOT'Then Begin
          CurrPC.S4:=XtrkWd;
          If CurrPC.S4='_CF'Then PushByte(ciCMC)
          Else Begin
           CompileInstr:=CFExpected;
           Goto Exit;
          End;
         End
          Else
         If CurrPC.S4='TRUE'Then PushByte(ciSTC)Else
         If CurrPC.S4='FALSE'Then PushByte(ciCLC)
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
          Inc(CurrPC.I);
         End;
        End;
       End;
      End;
      Else Begin { Ce sont des variables problablement...}
       If CurrPC.S3[1]='_'Then K:=GetCodeRegAsm(Copy(CurrPC.S3,2,255),J)
                   Else J:=$FF;
       Case(J)of
        17:Begin
         If SI<>':'Then Begin
          CompileInstr:=ColonExpected;
          Goto Exit;
         End;
         Inc(CurrPC.I);
         If SI<>'='Then Begin
          CompileInstr:=EqualExpected;
          Goto Exit;
         End;
         Inc(CurrPC.I);CurrPC.W:=XtrkInteger(CurrPC.Ok);
         If Not(CurrPC.Ok)Then Begin
          CompileInstr:=SyntaxNumber;
          Goto Exit;
         End;
         If(InstrFormat>=p286)Then Begin
          If Hi(CurrPC.W)=0Then Push2Byte($6A,CurrPC.W) { Push ?? }
                    Else Push3Byte($68,Lo(CurrPC.W),Hi(CurrPC.W)); { Push ???? }
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
          If CurrPC.W=0Then Push2Byte($33,XorReg[0])                  { XOR AX,AX }
                       Else Push3Byte($B8,Lo(CurrPC.W),Hi(CurrPC.W)); { MOV AX,???? }
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
           Inc(CurrPC.I);
           If SI<>'+'Then Begin
            CompileInstr:=PlusExpected;
            Goto Exit;
           End;
           Inc(CurrPC.I);
           PushByte(ciIncAX+K);
          End;
          '-':Begin
           Inc(CurrPC.I);
           If SI<>'-'Then Begin
            CompileInstr:=MinusExpected;
            Goto Exit;
           End;
           Inc(CurrPC.I);
           PushByte(ciDecAX+K);
          End;
          '<':Begin
           Inc(CurrPC.I);
           If SI<>'<'Then Begin
            CompileInstr:=LowerExpected;
            Goto Exit;
           End;
           Inc(CurrPC.I);
           If SI<>':'Then Begin
            CompileInstr:=ColonExpected;
            Goto Exit;
           End;
           Inc(CurrPC.I);
           If SI<>'='Then Begin
            CompileInstr:=EqualExpected;
            Goto Exit;
           End;
           Inc(CurrPC.I);
           CurrPC.W:=XtrkInteger(CurrPC.Ok);
           If Not(CurrPC.Ok)Then Begin
            CompileInstr:=SyntaxNumber;
            Goto Exit;
           End;
           If(InstrFormat>=p286)and(CurrPC.W>1)Then Push3Byte($C1,$E0+K,CurrPC.W)
           Else For J:=1to(CurrPC.W)do Push2Byte($D1,$E0+K);
          End;
          '>':Begin
           Inc(CurrPC.I);
           If SI<>'>'Then Begin
            CompileInstr:=GrExpected;
            Goto Exit;
           End;
           Inc(CurrPC.I);
           If SI<>':'Then Begin
            CompileInstr:=ColonExpected;
            Goto Exit;
           End;
           Inc(CurrPC.I);
           If SI<>'='Then Begin
            CompileInstr:=EqualExpected;
            Goto Exit;
           End;
           Inc(CurrPC.I);
           CurrPC.W:=XtrkInteger(CurrPC.Ok);
           If Not(CurrPC.Ok)Then Begin
            CompileInstr:=SyntaxNumber;
            Goto Exit;
           End;
           If(InstrFormat>=p286)and(CurrPC.W>1)Then Push3Byte($C1,$E8+K,CurrPC.W)
           Else For J:=1to(CurrPC.W)do Push2Byte($D1,$E8+K);
          End;
          ':':Begin
           Inc(CurrPC.I);
           If SI<>'='Then Begin
            CompileInstr:=EqualExpected;
            Goto Exit;
           End;
           Inc(CurrPC.I);CurrPC.W:=XtrkInteger(CurrPC.Ok);
           If Not(CurrPC.Ok)Then Begin
            CurrPC.S4:=XtrkWd;
            If CurrPC.S4[1]='_'Then K2:=GetCodeRegAsm(Copy(CurrPC.S4,2,255),J)
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
            If CurrPC.W=0Then Push2Byte($33,XorReg[K])
            Else Push3Byte($B8+K,Lo(CurrPC.W),Hi(CurrPC.W));
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
         Inc(CurrPC.I);
         If SI<>'='Then Begin
          CompileInstr:=ColonExpected;
          Goto Exit;
         End;
         Inc(CurrPC.I);CurrPC.l1:=XtrkInteger(CurrPC.Ok);
         If Not(CurrPC.Ok)Then Begin
          CompileInstr:=SyntaxNumber;
          Goto Exit;
         End;
         Push2Byte($66,$B8+K);
         PushAddLong(CurrPC.l1);
        End;
        8:Begin
         If SI<>':'Then Begin
          CompileInstr:=ColonExpected;
          Goto Exit;
         End;
         Inc(CurrPC.I);
         If SI<>'='Then Begin
          CompileInstr:=ColonExpected;
          Goto Exit;
         End;
         Inc(CurrPC.I);
         CurrPC.l1:=XtrkInteger(CurrPC.Ok);
         If(K=0)and(CurrPC.CodePrg^[CurrPC.PrevIP]=$B4)Then Begin { _AL et pr‚c‚dent _AH ? }
          CurrPC.CodePrg^[CurrPC.PrevIP]:=$B8;
          CurrPC.CodePrg^[CurrPC.PrevIP+2]:=CurrPC.CodePrg^[CurrPC.PrevIP+1];
          CurrPC.CodePrg^[CurrPC.PrevIP+1]:=CurrPC.l1;Inc(CurrPC.IP);
         End
          Else
         If(K=4)and(CurrPC.CodePrg^[CurrPC.PrevIP]=$B0)Then Begin { _AH et pr‚c‚dent _AL ? }
          CurrPC.CodePrg^[CurrPC.PrevIP]:=$B8;
          CurrPC.CodePrg^[CurrPC.PrevIP+2]:=CurrPC.l1;
          Inc(CurrPC.IP);
         End
          Else
         Begin
          If Not(CurrPC.Ok)Then Begin
           CompileInstr:=SyntaxNumber;
           Goto Exit;
          End;
          Push2Byte($B0+K,CurrPC.l1);
         End;
        End;
        Else Begin
         _Ok:=No;
         ALSetPtr(CurrPC.VarBk,0);
         If CurrPC.VarBk.Count>0Then For Iw:=0to CurrPC.VarBk.Count-1do Begin
          CurrPC.PVar:=_ALGetCurrBuf(CurrPC.VarBk);
          If(CurrPC.PVar^.Name=CurrPC.S3)Then Begin
           Case(SI)of
            '+':Begin
             Inc(CurrPC.I);
             If SI<>'+'Then Begin
              CompileInstr:=PlusExpected;
              Goto Exit;
             End;
             Inc(CurrPC.I);
             Case(CurrPC.PVar^.SegDes)of
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
             Case(CurrPC.PVar^.TypeDef)of
              tBool,tByte,tShort,tChar:Push2ByteOffset($FE,$06,CurrPC.PVar^.Ofs);
              tInt,tWord:Push2ByteOffset($FF,$06,CurrPC.PVar^.Ofs);
              Else Begin
               CompileInstr:=TypeMistmatch;
               Goto Exit;
              End;
             End;
            End;
            ':':If StrI(CurrPC.I+1,CurrPC.S)='='Then Begin
             Inc(CurrPC.I,2);
             If Not XtrkFormule(Q,Ya,K)Then Begin
              CompileInstr:=SyntaxError;
              Goto Exit;
             End;
             Case(K)of
              $FF:Case(CurrPC.PVar^.TypeDef)of
               tBool,tByte,tShort:Begin
                PushInstrOffset(#$C6#06,CurrPC.PVar^.Ofs);
                PushAddByte(Q.X.DataByte);
               End;
               tWord,tInt:Begin
                PushInstrOffset(#$C7#06,CurrPC.PVar^.Ofs);
                PushAddWord(Q.X.DataWord);
               End;
               tLong:If(InstrFormat>=p386)Then Begin
                PushInstrOffset(#$66#$C7#06,CurrPC.PVar^.Ofs);
                PushAddLong(Q.X.DataLong);
               End
                Else
               Begin
                PushInstrOffset(#$C7#06,CurrPC.PVar^.Ofs);
                PushAddWord(Q.X.DataWord);
                PushInstrOffset(#$C7#06,CurrPC.PVar^.Ofs+2);
                PushAddWord(LongRec(Q.X.DataLong).Hi);
               End;
               Else Begin
                CompileInstr:=TypeMistmatch;
                Goto Exit;
               End;
              End;
              0:Case(CurrPC.PVar^.TypeDef)of
               tBool,tByte,tShort:PushInstrOffset(#$A2,CurrPC.PVar^.Ofs);
               tWord,tInt:PushInstrOffset(#$A3,CurrPC.PVar^.Ofs);
               tLong:If(InstrFormat>=p386)Then PushInstrOffset(#$66#$A3,CurrPC.PVar^.Ofs)
                Else
               Begin
                PushInstrOffset(#$A3,CurrPC.PVar^.Ofs);       { MOV Variable,AX }
                PushInstrOffset(#$89#$16,CurrPC.PVar^.Ofs+2); { MOV Variable,DX }
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
          ALNext(CurrPC.VarBk);
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
  Inc(CurrPC.I);
  If(InBegin=0)and(OneInstr)Then Goto Exit;
 Until No;
Exit:
 ALDone(StackCase);
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
 TPile:ArrayList;
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
  MakeMacro:=No;
  Mac.Name:=XtrkWd;
  If Mac.Name=''Then Begin
   CompileFile:=IdentifierExpected;
   Exit;
  End;
  If SI<>';'Then Begin
   CompileFile:=PointCommaExpected;
   Exit;
  End;
  Inc(CurrPC.I);
  Mac.FB:=CurrPC.FP;
  Mac.Path:=CurrPC.CurrFile;
  Repeat
   While SI<>'E'do Begin
    If SI=#0Then Begin
     CompileFile:=EndOfSourceExpected;
     Exit;
    End;
    Inc(CurrPC.I);
    SaveAddr;
   End;
   EStr:=XtrkWd
  Until(EStr='ENDMACRO')or(EStr='FINMACRO');
  RestoreAddr;
  XtrkWd;
  Mac.FE:=CurrPC.FP;
  If SI<>';'Then Begin
   CompileFile:=PointCommaExpected;
   Exit;
  End;
  Inc(CurrPC.I);
  PMac:=ALAdd(CurrPC.Macro,SizeOf(MacroRec));
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
  Cst.Name:=CurrPC.S3;AddConst:=False;
  SaveAddr;
  CurrPC.S2:=XtrkWd;VP:=SearchVarPas(CurrPC.S2);
  If(VP=NIL)Then Goto Other;
  Case(VP^.TypeDef)of
   tBool:Begin
    If SI<>'('Then Begin
     CompileFile:=OpenParExpected;
     Exit;
    End;
    Inc(CurrPC.I);
    CurrPC.l1:=XtrkInteger(Ok);
    If(Ok)Then Begin
     Cst.Q.TypeDef:=tBool;
     Cst.Q.X.DataByte:=CurrPC.l1;
     PCst:=ALIns(CurrPC.ReDef,SearchPosConst(Ok),SizeOf(CstRec));
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
     Inc(CurrPC.I);
     AddConst:=Ya;
    End;
   End;
   Else Begin
Other:RestoreAddr;
    If XtrkFormule(Cst.Q,No,K)Then Begin
     PCst:=ALIns(CurrPC.ReDef,SearchPosConst(Ok),SizeOf(CstRec){-SizeOf(String)+Length(Cst.Name)+16});
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
     If Not XtrkString(CurrPC.S2)Then Begin
      CompileFile:=SyntaxError;
      Exit;
     End;
     If Length(CurrPC.S2)=1Then Begin
      Cst.Q.TypeDef:=tChar;
      Cst.Q.X.DataChar:=CurrPC.S2[1];
     End
      Else
     Begin
      Cst.Q.TypeDef:=tString;
      Cst.Q.X.Buf:=MemAlloc(Length(CurrPC.S2)+1);
      If(Cst.Q.X.Buf=NIL)Then Begin
       CompileFile:=OutOfMemory;
       Exit;
      End;
      Cst.Q.X.PString^:=CurrPC.S2;
     End;
     PCst:=ALIns(CurrPC.ReDef,SearchPosConst(Ok),SizeOf(CstRec));
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

  Function Sub(Var Pile:ArrayList):Boolean;
  Label EndBranch;
  Var
   VType:^TypeRec;
   PointTo:Boolean;
  Begin
   ALInit(Pile);
   Sub:=No;
   Repeat
    If Box>0Then Begin
     CurrPC.S4:=XtrkWd;
     If(GetCodeMainWordPas(CurrPC.S4)=cmwpEnd)Then Goto EndBranch;
     If SI<>':'Then Exit;
     Inc(CurrPC.I);
    End;
    If SI='^'Then Begin
     Inc(CurrPC.I);
     PointTo:=Ya;
    End
     Else
    PointTo:=No;
    CurrPC.S2:=XtrkWd;
    Case GetCodeMainWordPas(CurrPC.S2)of
      { Traitement d'un tableau ®RECORD¯ }
     cmwpArray:Begin
      VType:=ALAdd(Pile,SizeOf(TypeRec));
      If(VType=NIL)Then Exit;
      FillClr(VType^,SizeOf(TypeRec));
      VType^.TypeDef:=tArray;
      VType^.PointTo:=PointTo;
      If Box>0Then VType^.Name:=CurrPC.S4
              Else VType^.Name:='';
      Case(SI)of
       '[':Inc(CurrPC.I);
       '(':Begin
        Inc(CurrPC.I);
        If SI<>'.'Then Exit;
       End;
       Else Exit;
      End;
      Ok:=No;VType^.Min:=XtrkInteger(Ok);
      If Not(Ok)Then Exit;
      If SI<>'.'Then Exit;
      Inc(CurrPC.I);
      If SI<>'.'Then Exit;
      Inc(CurrPC.I);
      Ok:=No;VType^.Max:=XtrkInteger(Ok);
      If Not(Ok)Then Exit;
      Case(SI)of
       ']':Inc(CurrPC.I);
       '.':Begin
        Inc(CurrPC.I);
        If SI<>')'Then Exit;
       End;
       Else Exit;
      End;
      CurrPC.S2:=XtrkWd;
      If(GetCodeMainWordPas(CurrPC.S2)<>cmwpOf)Then Exit;
      CurrPC.S2:=XtrkWd;VP:=SearchVarPas(CurrPC.S2);
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
      VType:=ALAdd(Pile,SizeOf(TypeRec));
      If(VType=NIL)Then Exit;
      FillClr(VType^,SizeOf(TypeRec));
      VType^.TypeDef:=tRec;
      VType^.PointTo:=PointTo;
      If Not Sub(VType^.Pile)Then Exit;
     End;
      { Type de variable simple }
     Else Begin
      VP:=SearchVarPas(CurrPC.S2);
      If(VP=NIL)Then Exit;
      Case(VP^.TypeDef)of
       tBool,tByte,tShort,tChar,tInt,tWord,tLong,tPtr:Begin
        VType:=ALAdd(Pile,SizeOf(TypeRec));
        If(VType=NIL)Then Exit;
        FillClr(VType^,SizeOf(TypeRec));
        VType^.TypeDef:=VP^.TypeDef;
        VType^.PointTo:=PointTo;
        If Box>0Then VType^.Name:=CurrPC.S4
                Else VType^.Name:='';
       End;
       Else Exit;
      End;
     End;
    End;
    If Box>0Then Begin
     If SI<>';'Then Exit;
     Inc(CurrPC.I);
    End;
   Until Box=0;
   Sub:=Ya;
  End;

 Begin
  FillClr(DefType,SizeOf(DefType));
  Box:=0;
  DefType.Name:=CurrPC.S3;
  AddType:=No;
  P:=SearchPosType(Ok);
  If(Ok)Then Exit;
  PType:=ALIns(CurrPC.TypeDef,P,SizeOf(TypeMainRec));
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
  CurrPC.PProc^.ParamRegister:=Ya;CurrReg:=0;
  For J:=0to CurrPC.PProc^.Param.Count-1do Begin
   PVar:=_ALGetBuf(CurrPC.PProc^.Param,J);
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
    ALSetPtr(CurrPC.PProc^.Param,J+1);
    For K:=J+1to CurrPC.PProc^.Param.Count-1do Begin
     PVar2:=_ALGetCurrBuf(CurrPC.PProc^.Param);
     If(PVar2<>NIL)Then Dec(PVar2^.Ofs,Size);
     ALNext(CurrPC.PProc^.Param);
    End;
   End;
  End;
 End;

Begin
 CompileFile:=0;NL:=0;
 ALInit(TPile);
 InitCompiler;
 {$IFDEF IDE}
  If(Name=CurrPC.XEdt^.EditName)Then Begin
   CurrPC.Handle:=50;
   ALSetPtr(CurrPC.XEdt^.List,0);
  End
   Else
  CurrPC.Handle:=FileOpen(Name,fmRead);
 {$ELSE}
  Handle:=Open(Name,fmRead);
 {$ENDIF}
 If(CurrPC.Handle=errHdl)Then Begin
  CompileFile:=FileNotFound;
  Exit;
 End;
 CurrPC.FP:=0;CurrPC.FS:=FileSize(CurrPC.Handle);
 Repeat
  CurrPC.S:=ReadLn;
  While CurrPC.I<=Length(CurrPC.S)do Begin
   CurrPC.S2:=XtrkWd;
Restart:
   R:=GetCodeMainWordPas(CurrPC.S2);
   Case(R)of
    cmwpUses:Begin
     CurrPC.S3:=XtrkWd;
     If CurrPC.S3=''Then Begin
      CompileFile:=UnitNameExpected;
      Goto Err;
     End;
     If Not UnitInList(CurrPC.S3)Then Begin
      CompileFile:=DuplDefUnit;
      Goto Err;
     End;
     If UnitUpgrade(CurrPC.S3)Then Begin
      OD:=SaveData;
      ALInit(CurrPC.UnitList);
      {$IFDEF IDE}
       WEPutTxtXY(CurrPC.WC,33,0,'Recompile l''unit‚ '+CurrPC.S3+'...');
      {$ELSE}
       WriteLn('Recompile l''unit‚ ',CurrPC.S3,'...');
      {$ENDIF}
      AddStr(CurrPC.S3,'.PAS');
      If Not FileExist(CurrPC.S3)Then Begin
       CurrPC.S3:=Path2Dir(Name)+CurrPC.S3;
      End;
      CurrPC.W:=CompileFile(CurrPC.S3,TL);
      If CurrPC.W<>0Then Begin
       CompileFile:=CurrPC.W;
       Goto Err;
      End;
      InitCompiler;
      RestoreData(OD);
     End;
     ALAddStr(CurrPC.UnitList,CurrPC.S3);
     If SI<>';'Then Begin
      CompileFile:=PointCommaExpected;
      Goto Err;
     End;
     Inc(CurrPC.I);
    End;
    cmwpUnit:Begin
     If CurrPC.UnitList.Count>1Then Begin
      CompileFile:=MisplacedUnit;
      Goto Err;
     End;
     If(ProgramFormat=fCOM)Then ProgramFormat:=fUnitLarge
      Else
     Begin
      CompileFile:=MisplacedUnit;
      Goto Err;
     End;
     CurrPC.SuggName:=XtrkWd;
     If CurrPC.SuggName='SYSTEM'Then Begin
      ALDone(CurrPC.UnitList);
      ALInit(CurrPC.UnitList)
     End;
     If SI<>';'Then Begin
      CompileFile:=PointCommaExpected;
      Goto Err;
     End;
     Inc(CurrPC.I);
     CurrPC.IP:=0;CurrPC.Org:=0;
    End;
    cmwpType:Begin
     CurrPC.S3:=XtrkWd;
     Repeat
      If SI<>'='Then Begin
       CompileFile:=EqualExpected;
       Goto Err;
      End;
      Inc(CurrPC.I);
      If Not(AddType)Then Goto Err;
      If SI<>';'Then Begin
       CompileFile:=PointCommaExpected;
       Goto Err;
      End;
      Inc(CurrPC.I);
      CurrPC.S3:=XtrkWd;
      If CurrPC.S3=''Then Break;
      Case GetCodeMainWordPas(CurrPC.S3)of
       cmwpError:;
        { Le type ®FILE OF¯ est autoris‚ dans l'unit‚ ®SYSTEM¯ seulement!}
       cmwpFile:If CurrPC.SuggName<>'SYSTEM'Then Goto FinishType;
       Else Begin
FinishType:
        CurrPC.S2:=CurrPC.S3;
        Goto Restart;
       End;
      End;
     Until No;
    End;
    cmwpProgram:If(ProgramFormat)in[fBOOT,fCOM,fEXE]Then Begin
     CurrPC.SuggName:=XtrkWd;
     If CurrPC.SuggName=''Then Begin
      CompileFile:=NamePrgExpected;
      Goto Err;
     End;
     If SI<>';'Then Begin
      CompileFile:=PointCommaExpected;
      Goto Err;
     End;
     Inc(CurrPC.I);
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
      ALAddStr(CurrPC.UnitList,CurrPC.SuggName);
     End
      Else
     Begin
      CompileFile:=MisplacedImplementation;
      Goto Err;
     End;
    End;
    cmwpConst:Begin
     CurrPC.Ok:=No;
     Repeat
      CurrPC.S3:=XtrkWd;
      If(CurrPC.Ok)Then Begin
       If(GetCodeMainWordPas(CurrPC.S3)<>cmwpError)Then Begin
        CurrPC.S2:=CurrPC.S3;
        Goto Restart;
       End;
      End;
      If CurrPC.S3=''Then Begin
       CompileFile:=ConstNameExpected;
       Goto Err;
      End;
      If SI=':'Then Begin { Variable ? }
       Inc(CurrPC.I);
       CurrPC.S4:=XtrkWd;
       If CurrPC.S4=''Then Begin
        CompileFile:=IdentifierExpected;
        Goto Err;
       End;
       CurrPC.W:=Variable(tSegDes);
       If CurrPC.W<>0Then Begin
        CompileFile:=CurrPC.W;
        Goto Err;
       End;
       CurrPC.PVar^.QParam:=qConst;
       If SI<>'='Then Begin
        CompileFile:=SyntaxError;
        Goto Err;
       End;
       Inc(CurrPC.I);
       If XtrkFormule(V,No,R)Then CurrPC.PVar^.X:=V.X
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
       Inc(CurrPC.I);
       If Not(AddConst)Then Exit;
      End;
      If SI<>';'Then Begin
       CompileFile:=PointCommaExpected;
       Goto Err;
      End;
      Inc(CurrPC.I);
      CurrPC.Ok:=Ya;
     Until No
    End;
    cmwpCSConst:Begin
     Repeat
      CurrPC.S3:=XtrkWd;
      If CurrPC.S3='DB'Then Begin
       CurrPC.W:=DataAsm(DB);
       If CurrPC.W<>0Then Begin
        CompileFile:=CurrPC.W;
        Exit;
       End;
      End
       Else
      If CurrPC.S3='DD'Then Begin
       CurrPC.W:=DataAsm(DD);
       If CurrPC.W<>0Then Begin
        CompileFile:=CurrPC.W;
        Exit;
       End;
      End
       Else
      If CurrPC.S3='DW'Then Begin
       CurrPC.W:=DataAsm(DW);
       If CurrPC.W<>0Then Begin
        CompileFile:=CurrPC.W;
        Exit;
       End;
      End
       Else
      If(GetCodeMainWordPas(CurrPC.S3)=cmwpEnd)Then Break;
     Until No;
     If SI<>';'Then Begin
      CompileFile:=PointCommaExpected;
      Goto Err;
     End;
     Inc(CurrPC.I);
    End;
    cmwpVar:Begin
     CurrPC.Ok:=No;
     tSegDes:=vDS;
     Repeat
      CurrPC.S3:=XtrkWd;
      If(CurrPC.Ok)Then Begin
       If(GetCodeMainWordPas(CurrPC.S3)<>cmwpError)Then Begin
        CurrPC.S2:=CurrPC.S3;
        Goto Restart;
       End;
      End
       Else
      Begin
       If(CurrPC.S3='CODE')or
         (CurrPC.S3='CS')or
         (CurrPC.S3='CSEG')or
         (CurrPC.S3='PREFIXSEG')or
         (CurrPC.S3='DEFAULT')or
         (CurrPC.S3='STANDARD')Then Begin
        tSegDes:=vCS;
        CurrPC.S3:=XtrkWd;
       End
        Else
       If(CurrPC.S3='DATA')or(CurrPC.S3='DS')or(CurrPC.S3='DSEG')Then Begin
        tSegDes:=vDS;
        CurrPC.S3:=XtrkWd;
       End
        Else
       If(CurrPC.S3='EXTRA')or(CurrPC.S3='ES')Then Begin
        tSegDes:=vES;
        CurrPC.S3:=XtrkWd;
       End
        Else
       If CurrPC.S3='FS'Then Begin
        tSegDes:=vFS;
        CurrPC.S3:=XtrkWd;
       End
        Else
       If CurrPC.S3='GS'Then Begin
        tSegDes:=vGS;
        CurrPC.S3:=XtrkWd;
       End
        Else
       If(CurrPC.S3='STACK')or(CurrPC.S3='SS')or(CurrPC.S3='SSEG')Then Begin
        tSegDes:=vSS;
        CurrPC.S3:=XtrkWd;
       End;
      End;
      If CurrPC.S3=''Then Begin
       CompileFile:=ConstNameExpected;
       Goto Err;
      End;
      If SI<>':'Then Begin
       CompileFile:=ColonExpected;
       Goto Err;
      End;
      Inc(CurrPC.I);
      CurrPC.S4:=XtrkWd;
      If CurrPC.S4=''Then Begin
       CompileFile:=IdentifierExpected;
       Goto Err;
      End;
      CurrPC.W:=Variable(tSegDes);
      CurrPC.PVar^.QParam:=qNone;
      If CurrPC.W<>0Then Begin
       CompileFile:=CurrPC.W;
       Goto Err;
      End;
      If SI<>';'Then Begin
       CompileFile:=PointCommaExpected;
       Goto Err;
      End;
      Inc(CurrPC.I);
      CurrPC.Ok:=Ya;
     Until No;
    End;
    cmwpProcedure,cmwpFunction:Begin
     CurrPC.ProcName:=XtrkWd;
     StackPos:=0;StackParam:=0;
     VarPosProc:=CurrPC.VarBk.Count;
     If CurrPC.ProcName=''Then Begin
      CompileFile:=IdentifierExpected;
      Goto Err;
     End;
     CurrPC.PProc:=PtrProc(CurrPC.ProcName);
     If(CurrPC.PProc<>NIL)Then Begin
      CompileFile:=DuplExpression;
      Goto Err;
     End;
     CurrPC.PProc:=ALIns(CurrPC.ProcBk,SearchPosProc(CurrPC.ProcName,CurrPC.Ok),SizeOf(ProcRec));
     If(CurrPC.PProc=NIL)Then Begin
      CompileFile:=OutOfMemory;
      Goto Err;
     End;
     CurrPC.PProc^.Func:=R=cmwpFunction;
     CurrPC.PProc^.Name:=CurrPC.ProcName;
     CurrPC.PProc^.Ofs:=CurrPC.IP;
     CurrPC.PProc^.CurrPtr:=CurrPointer;
     CurrPC.PProc^.Free:=No;
     CurrPC.PProc^.Dupl:=No;
     CurrPC.PProc^.ParamRegister:=No;
     ALInit(CurrPC.PProc^.Param);
     CurrPC.VarInProc:=No;{S'il y a des paramŠtres, fixer … vrai...}
     If SI='('Then Begin { ParamŠtre dans la proc‚dure... }
      Inc(CurrPC.I);
      CurrPC.VarInProc:=Ya;
      Repeat
       ALInit(TPile);
       CurrPC.S3:=XtrkWd;
       Case GetCodeMainWordPas(CurrPC.S3)of
        cmwpVar:Begin
         QParam:=qVar;
         CurrPC.S3:=XtrkWd;
        End;
        cmwpConst:Begin
         QParam:=qConst;
         CurrPC.S3:=XtrkWd;
        End;
        Else QParam:=qNone;
       End;
       ALAddStr(TPile,CurrPC.S3);
       If CurrPC.S3=''Then Begin
        CompileFile:=ConstNameExpected;
        Goto Err;
       End;
       While SI=','do Begin
        Inc(CurrPC.I);
        CurrPC.S3:=XtrkWd;
        If CurrPC.S3=''Then Begin
         CompileFile:=ConstNameExpected;
         Goto Err;
        End;
        ALAddStr(TPile,CurrPC.S3);
       End;
       If SI=':'Then Begin
        Inc(CurrPC.I);
        CurrPC.S4:=XtrkWd;
        If CurrPC.S4=''Then Begin
         CompileFile:=IdentifierExpected;
         Goto Err;
        End;
       End
        Else
       If(QParam=qNone)Then Begin
        CompileFile:=ColonExpected;
        Goto Err;
       End
        Else
       CurrPC.S4:='';
       ALSetPtr(TPile,0);
       For J:=0to TPile.Count-1do Begin
        CurrPC.S3:=StrPas(PChr(_ALGetCurrBuf(TPile)));
        CurrPC.W:=LocalVariable(vSSParam,QParam);
        If CurrPC.W<>0Then Begin
         CompileFile:=CurrPC.W;
         Goto Err;
        End;
        TVar:=ALAdd(CurrPC.PProc^.Param,SizeOf(VarRec));
        If(TVar=NIL)Then Begin
         CompileFile:=OutOfMemory;
         Goto Err;
        End;
        TVar^:=CurrPC.PVar^;
        ALNext(TPile);
       End;
       ALDone(TPile);
       Case(SI)of
        ')':Break;
        ';':Inc(CurrPC.I);
        Else Begin
         CompileFile:=CloseParExpected;
         Goto Err;
        End;
       End;
      Until No;
      Inc(CurrPC.I);
     End;
     If(R=cmwpFunction)and(SI=':')Then Begin
      Inc(CurrPC.I);
      CurrPC.S3:=XtrkWd;
      VP:=SearchVarPas(CurrPC.S3);
      If(VP=NIL)Then Begin
       CompileFile:=UnknownIdentifier;
       Goto Err;
      End
       Else
      Begin
       CurrPC.PProc^.Return.TypeDef:=VP^.TypeDef;
       CurrPC.PProc^.Return.Size:=VP^.Size;
      End;
     End;
     If SI<>';'Then Begin
      CompileFile:=PointCommaExpected;
      Goto Err;
     End;
     Inc(CurrPC.I);CurrPC.S3:=XtrkWd;
     CurrPC.W:=GetCodeMainWordPas(CurrPC.S3);
     Case(CurrPC.W)of
      cmwpRegister:Begin
       ParamRegister;
       If SI<>';'Then Begin
        CompileFile:=PointCommaExpected;
        Goto Err;
       End;
       Inc(CurrPC.I);
       CurrPC.S3:=XtrkWd;
      End;
      cmwpFar,cmwpNear:Begin
       CurrPC.PProc^.CurrPtr:=CurrPC.W;
       If SI<>';'Then Begin
        CompileFile:=PointCommaExpected;
        Goto Err;
       End;
       Inc(CurrPC.I);
       CurrPC.S3:=XtrkWd;
      End;
     End;
     Case GetCodeMainWordPas(CurrPC.S3)of
      cmwpDuplicate:If(Body=bINTERFACE)Then Begin
       CurrPC.S3:=XtrkWd;CurrPC.PProc^.Parent:=PtrProc(CurrPC.S3);
       If(CurrPC.PProc^.Parent=NIL)Then Begin
        CompileFile:=UnknownIdentifier;
        Goto Err;
       End;
       If SI<>';'Then Begin
        CompileFile:=PointCommaExpected;
        Goto Err;
       End;
       Inc(CurrPC.I);
       CurrPC.S3:=XtrkWd;
       CurrPC.PProc^.Dupl:=Ya;
      End;
     End;
     If(Body=bINTERFACE)Then Begin
      CurrPC.S2:=CurrPC.S3;
      If(CurrPC.VarInProc)Then Begin
       For J:=CurrPC.VarBk.Count-1downto(VarPosProc)do ALDelBuf(CurrPC.VarBk,J);
      End;
      Goto Restart;
     End
      Else
     Begin
      If(Body=bIMPLEMENTATION)Then Begin
       Inc(CurrPC.GhostCode,CurrPC.IP);
       CurrPC.IP:=0;CurrPC.PrevIP:=$FFFF;
      End;
      CurrPC.ProcAsm:=No;
      If(GetCodeMainWordPas(CurrPC.S3)=cmwpAssembler)Then Begin
       CurrPC.ProcAsm:=Ya;
       If SI<>';'Then Begin
        CompileFile:=PointCommaExpected;
        Goto Err;
       End;
       Inc(CurrPC.I);
       CurrPC.S3:=XtrkWd;
      End;
      If(GetCodeMainWordPas(CurrPC.S3)=cmwpVar)Then Begin
       CurrPC.Ok:=False;
       CurrPC.VarInProc:=Ya;
       Repeat
        CurrPC.S3:=XtrkWd;
        If CurrPC.S3=''Then Begin
         CompileFile:=ConstNameExpected;
         Goto Err;
        End;
        If(CurrPC.Ok)Then Begin
         If(GetCodeMainWordPas(CurrPC.S3)<>cmwpError)Then Break;
        End;
        If SI<>':'Then Begin
         CompileFile:=ColonExpected;
         Goto Err;
        End;
        Inc(CurrPC.I);
        CurrPC.S4:=XtrkWd;
        If CurrPC.S4=''Then Begin
         CompileFile:=IdentifierExpected;
         Goto Err;
        End;
        CurrPC.W:=LocalVariable(vSS,qNone);
        If CurrPC.W<>0Then Begin
         CompileFile:=CurrPC.W;
         Goto Err;
        End;
        TVar:=ALAdd(CurrPC.PProc^.Param,SizeOf(VarRec));
        If(TVar=NIL)Then Begin
         CompileFile:=OutOfMemory;
         Goto Err;
        End;
        TVar^:=CurrPC.PVar^;
        CurrPC.Ok:=Ya;
        If SI<>';'Then Begin
         CompileFile:=PointCommaExpected;
         Goto Err;
        End;
        Inc(CurrPC.I);
       Until No;
{       S3:=XtrkWd;}
      End;
      If(CurrPC.ProcAsm)Then Begin
       If(GetCodeMainWordPas(CurrPC.S3)<>cmwpAsm)Then Begin
        CompileFile:=BeginExpected;
        Goto Err;
       End;
      End
       Else
      If Not(GetCodeMainWordPas(CurrPC.S3)in[cmwpBegin,cmwpAsm])Then Begin
       CompileFile:=BeginExpected;
       Goto Err;
      End;
      If(CurrPC.VarInProc)and(StackPos>0)Then Begin
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
      If(CurrPC.ProcAsm)Then CurrPC.W:=CompileAsm(No)
                        Else CurrPC.W:=CompileInstr(No);
      If CurrPC.W<>0Then Begin
       CompileFile:=CurrPC.W;
       Goto Err;
      End;
      If(CurrPC.VarInProc)and(StackPos>0)Then Begin
       If(InstrFormat>=p186)Then PushByte($C9) { LEAVE }
        Else
       Push3Byte($89,$EC,    { MOV SP,BP }
                 ciPopBP);   { POP BP }
      End;
      CurrPC.PProc:=PtrProc(CurrPC.ProcName);
      If(CurrPC.PProc^.CurrPtr=cmwpNear)Then Begin
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
      If SI<>';'Then Begin
       CompileFile:=SemicolonExpected;
       Goto Err;
      End;
      Inc(CurrPC.I);
      LinkJump;
      If(Body=bIMPLEMENTATION)Then DumpUnitProc(CurrPC.ProcName);
      If(CurrPC.VarInProc)Then Begin
       For J:=CurrPC.VarBk.Count-1downto(VarPosProc)do ALDelBuf(CurrPC.VarBk,J);
      End;
     End;
    End;
    cmwpAsm:Begin
     If CurrPC.IP=CurrPC.Org+3Then Dec(CurrPC.IP,3)
      Else
     Begin
      CurrPC.CodePrg^[CurrPC.Org]:=ciJMP_Word;
      CurrPC.W:=CurrPC.IP-(CurrPC.Org+3);
      CurrPC.CodePrg^[CurrPC.Org+1]:=Lo(CurrPC.W);
      CurrPC.CodePrg^[CurrPC.Org+2]:=Hi(CurrPC.W);
     End;
     CurrPC.W:=CompileAsm(No);
     If CurrPC.W<>0Then Begin
      CompileFile:=CurrPC.W;
      Goto Err;
     End;
     If SI<>'.'Then Begin
      CompileFile:=CommaExpected;
      Goto Err;
     End;
     Inc(CurrPC.I);
     LinkJump;
    End;
    cmwpBegin:Begin { Programme Principal }
     If CurrPC.IP=CurrPC.Org+3Then Dec(CurrPC.IP,3) { Jmp juste en avant de soit c'est imb‚cile...}
      Else
     Begin
      CurrPC.CodePrg^[CurrPC.Org]:=ciJMP_Word;
      CurrPC.W:=CurrPC.IP-(CurrPC.Org+3);
      CurrPC.CodePrg^[CurrPC.Org+1]:=Lo(CurrPC.W);
      CurrPC.CodePrg^[CurrPC.Org+2]:=Hi(CurrPC.W);
     End;
     If(ProgramFormat=fEXE)Then Begin
      Case(ProgramTarget)of
       ftDOS:PushInstr(#$0E#$1F);
       ftWin31:PushInstr(#$9A#$FF#$FF#$00#$00);
      End;
     End;
     CurrPC.W:=CompileInstr(No);
     If CurrPC.W<>0Then Begin
      CompileFile:=CurrPC.W;
      Goto Err;
     End;
     If SI<>'.'Then Begin
      CompileFile:=CommaExpected;
      Goto Err;
     End;
     Inc(CurrPC.I);
     If Not((ProgramFormat)in[fUnitTiny,fUnitLarge])Then LinkJump;
    End;
    cmwpEnd:If(ProgramFormat)in[fUnitTiny,fUnitLarge]Then Begin { Fin d'unit‚? }
     If SI<>'.'Then Begin
      CompileFile:=CommaExpected;
      Goto Err;
     End;
     Inc(CurrPC.I);
     Break;
    End
     Else
    Begin
     CompileFile:=SyntaxError;
     Goto Err;
    End;
    Else Begin
     CompileFile:=SyntaxError;
     Goto Err;
    End;
   End;
   If(EOF)Then Break;
  End;
 Until EOF;
Err:
 ALDone(TPile);
 If CurrPC.Handle<50Then FileClose(CurrPC.Handle);
 If(ProgramFormat)in[fUnitTiny,fUnitLarge]Then Begin
  If CurrPC.VarBk.Count>0Then Begin
   ALSetPtr(CurrPC.VarBk,0);
   For CurrPC.I:=0to CurrPC.VarBk.Count-1do Begin
    CurrPC.PVar:=_ALGetCurrBuf(CurrPC.VarBk);
    If(CurrPC.PVar<>NIL)Then Begin
     ALDone(CurrPC.PVar^.ExternType^.Pile);
{     FreeMem(CurrPC.PVar^.ExternType,SizeOf(TypeRec));}
    End;
    ALNext(CurrPC.VarBk);
   End;
  End;
  ALDone(CurrPC.VarBk);      { Initialise la liste des variables }
  ALDone(CurrPC.ReDef);      { Initialise la liste des constantes }
  If CurrPC.ProcBk.Count>0Then Begin
   ALSetPtr(CurrPC.ProcBk,0);
   For CurrPC.I:=0to CurrPC.ProcBk.Count-1do Begin
    CurrPC.PProc:=_ALGetCurrBuf(CurrPC.ProcBk);
    If(CurrPC.PProc<>NIL)Then Begin
{     If(PProc^.Return.ExternType<>NIL)Then Begin
      RBDone(PProc^.Return.ExternType^.Pile);
      FreeMem(PProc^.Return.ExternType,SizeOf(TypeRec));
     End;}
     ALDone(CurrPC.PProc^.Param);
    End;
    ALNext(CurrPC.ProcBk);
   End;
  End;
  ALDone(CurrPC.ProcBk);     { Initialise la liste des proc‚dures }
  ALDone(CurrPC.UnitList);   { Initialise la liste des unit‚s }
  ALDone(CurrPC.Include);    { Initialise la liste des inclusions }
  ALDone(CurrPC.Jump);       { Initialise la liste des sauts }
  ALDone(CurrPC.SuppData);   { Initialise la liste des donn‚es suppl‚mentaires }
  ALDone(CurrPC.Macro);      { Initialise la liste des Macros }
  ALDone(CurrPC.ExternProc); { Initialise la liste des routines externes }
  ALDone(CurrPC.ExternVar);  { Initialise la liste des variables externes }
  ALDone(CurrPC.TypeDef);    { Initialise la liste des types }
 End;
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
END.