{ Gestion de l'assembleur en ligne directe }

Unit PCAsm;

{ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ}
                                  INTERFACE
{ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ}

Uses Systex,PCCortex;

Function CompileAsm(OneInstr:Bool):SmallInt;
Function DataAsm(X:DataAsmType):SmallInt;

{ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ}
                                IMPLEMENTATION
{ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ}

Uses Memories,Systems,PCBase,PCData,PCLine,PCCompile;

Function DataAsm(X:DataAsmType):SmallInt;

 Function Sub:Boolean;Begin
  CurrPC.l1:=XtrkInteger(CurrPC.Ok);
  Sub:=No;
  If Not(CurrPC.Ok)Then Begin
   DataAsm:=SyntaxNumber;
   Exit;
  End;
  Case(X)of
   DB:Begin
    If(CurrPC.l1>255)or(CurrPC.l1<-128)Then Begin
     DataAsm:=TooBigNumber;
     Exit;
    End;
    PushInstr(Chr(CurrPC.l1));
   End;
   DD:PushLongInt(CurrPC.l1);
   DW:Begin
    If(CurrPC.l1>65535)or(CurrPC.l1<-32768)Then Begin
     DataAsm:=TooBigNumber;
     Exit;
    End;
    PushWord(CurrPC.l1);
   End;
  End;
  Sub:=Ya;
 End;

Begin
 DataAsm:=0;
 Sub;
 While SI=','do Begin
  Inc(CurrPC.I);
  If Not(Sub)Then Exit;
 End;
End;

Function CompileAsm(OneInstr:Bool):Int;
Label
 MovChipe;
Const
 SegComma:Array[0..5]of Byte=(ciES,ciCS,ciSS,ciDS,ciFS,ciGS);
Var
 Nm:AsmNmType;
 PrevNL:LongInt;
 J,r,r0,r1,r2,r3,o1,o2,o3,o4:Byte;
 w1,w2,s1,s2:Word;
 Co:Boolean;
 PA:NoeudAsmPtr;

 { Paramätres de retour
   ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕ

    r0 ou r2 =  8     Registre 8 bits AH, AL, BH, BL, CH, CL, DH ou DL
                16    Registre 16 bits AX, BP, BX, CX, DI, DX, SI ou SP
                17    Registre segment 16 bits (CS, DS, ES ou SS)
                18    Registre segment 16 bits du 80386 (FS ou GS)
                32    Registre 32 bits EAX, EBP, EBX, ECX, EDI, EDX, ESI ou ESP
                33    Registre 32 bits CR0, CR2, CR3, CR4
                34    Registre 32 bits DR0, DR1, DR2, DR3, DR6 ou DR7
                35    Registre 32 bits TR3, TR4, TR5, TR6 ou TR7
                64    Registre 64 bits MM0, MM1, MM2, MM3, MM4, MM5, MM6, MM7
                80    Registre 80 bits ST(0), ST(1), ..., ST(7)
                B0h   Offset [yyxxh]
                B1h   Valeur numÇrique contenu dans w?
                C0h   Offset [BX+SI] ou [EBX+ESI]
                C1h   Offset [BX+DI] ou [EBX+EDI]
                C2h   Offset [BP+SI] ou [EBP+ESI]
                C3h   Offset [BP+DI] ou [EBP+EDI]
                C4h   Offset [SI] ou [ESI]
                C5h   Offset [DI] ou [EDI]
                C6h   Reporter Ö 80h...
                C7h   Offset [BX] ou [EBX]
                D0h   Offset [BX+SI+w?] ou [EBX+ESI+w?]
                D1h   Offset [BX+DI+w?] ou [EBX+EDI+w?]
                D2h   Offset [BP+SI+w?] ou [EBP+ESI+w?]
                D3h   Offset [BP+DI+w?] ou [EBP+EDI+w?]
                D4h   Offset [SI+w?] ou [ESI+w?]
                D5h   Offset [DI+w?] ou [EDI+w?]
                D6h   Offset [BP+w?] ou [EBP+w?]
                D7h   Offset [BX+w?] ou [EBX+w?]
                E0h   Offset [BX+SI-w?] ou [EBX+ESI-w?]
                E1h   Offset [BX+DI-w?] ou [EBX+EDI-w?]
                E2h   Offset [BP+SI-w?] ou [EBP+ESI-w?]
                E3h   Offset [BP+DI-w?] ou [EBP+EDI-w?]
                E4h   Offset [SI-w?] ou [ESI-w?]
                E5h   Offset [DI-w?] ou [EDI-w?]
                E6h   Offset [BP-w?] ou [EBP-w?]
                E7h   Offset [BX-w?] ou [EBX-w?]
                F0h   Offset [BP+Integer(w?)]

    r1 ou r3 =  00h   Registre AL, AX, EAX, MM0, ES,  CR0, DR0 ou ST(0)
                01h   Registre CL, CX, ECX, MM1, CS,  DR1 ou ST(1)
                02h   Registre DL, DX, EDX, MM2, SS,  CR2, DR2 ou ST(2)
                03h   Registre BL, BX, EBX, MM3, DS,  CR3, TR3, DR3 ou ST(3)
                04h   Registre AH, SP, ESP, MM4, FS,  CR4, TR4 ou ST(4)
                05h   Registre CH, BP, EBP, MM5, GS,  TR5 ou ST(5)
                06h   Registre DH, SI, ESI, MM6, TR6, DR6 ou ST(6)
                07h   Registre BH, DI, ESI, MM7, TR7, DR7 ou ST(7)
                FFh   Inconnu

    w1 ou w2 =  Offset s'il y a lieu
 }

 Function Instr2Param(NumParam:Byte):Boolean;
 Label
  Addr1,Addr2,Off1,Off2;
 Begin
  Instr2Param:=No;
  r2:=0;r3:=0;s1:=0;s2:=0;
  If NumParam=1Then Begin
   w1:=XtrkInteger(CurrPC.Ok);
   If(CurrPC.Ok)Then Begin
    r0:=$B1;
    Instr2Param:=Ya;
    Exit;
   End;
  End;
  CurrPC.S4:=XtrkLabelAsm;
  r1:=GetCodeRegAsm(CurrPC.S4,r0);
  If r1=$FFThen Begin
   If CurrPC.S4='QWORD'Then Begin
    CurrPC.S4:=XtrkLabelAsm;
    If CurrPC.S4<>'PTR'Then Begin
     CompileAsm:=SyntaxError;
     Exit;
    End;
    CurrPC.S4:=XtrkLabelAsm;
    w1:=GetOffVarLocal(CurrPC.S4);
    s1:=8;
    Case(w1)of
     $7FFE:Begin
      r0:=CurrPC.PVar^.SizeReg;
      r1:=CurrPC.PVar^.Reg;
      Goto Addr1;
     End;
     $7FFF:Begin
      r1:=GetCodeRegAsm(CurrPC.S4,r0);
      Goto Addr1;
     End;
    End;
   End
    Else
   If(CurrPC.S4='DOUBLEWORD')or(CurrPC.S4='DWORD')Then Begin
    CurrPC.S4:=XtrkLabelAsm;
    If CurrPC.S4<>'PTR'Then Begin
     CompileAsm:=SyntaxError;
     Exit;
    End;
    CurrPC.S4:=XtrkLabelAsm;
    w1:=GetOffVarLocal(CurrPC.S4);s1:=4;
    Case(w1)of
     $7FFE:Begin
      r0:=CurrPC.PVar^.SizeReg;
      r1:=CurrPC.PVar^.Reg;
      Goto Addr1;
     End;
     $7FFF:Begin
      r1:=GetCodeRegAsm(CurrPC.S4,r0);
      Goto Addr1;
     End;
    End;
   End
    Else
   If CurrPC.S4='WORD'Then Begin
    CurrPC.S4:=XtrkLabelAsm;
    If CurrPC.S4<>'PTR'Then Begin
     CompileAsm:=SyntaxError;
     Exit;
    End;
    CurrPC.S4:=XtrkLabelAsm;
    w1:=GetOffVarLocal(CurrPC.S4);
    s1:=2;
    Case(w1)of
     $7FFE:Begin
      r0:=CurrPC.PVar^.SizeReg;
      r1:=CurrPC.PVar^.Reg;
      Goto Addr1;
     End;
     $7FFF:Begin
      r1:=GetCodeRegAsm(CurrPC.S4,r0);
      Goto Addr1;
     End;
    End;
   End
    Else
   If CurrPC.S4='BYTE'Then Begin
    CurrPC.S4:=XtrkLabelAsm;
    If CurrPC.S4<>'PTR'Then Begin
     CompileAsm:=SyntaxError;
     Exit;
    End;
    CurrPC.S4:=XtrkLabelAsm;
    w1:=GetOffVarLocal(CurrPC.S4);
    s1:=1;
    Case(w1)of
     $7FFE:Begin
      r0:=CurrPC.PVar^.SizeReg;
      r1:=CurrPC.PVar^.Reg;
      Goto Addr1;
     End;
     $7FFF:Begin
      r1:=GetCodeRegAsm(CurrPC.S4,r0);
      Goto Addr1;
     End;
    End;
   End;
   w1:=GetOffVarLocal(CurrPC.S4);
   If w1=$7FFEThen Begin
    r0:=CurrPC.PVar^.SizeReg;
    r1:=CurrPC.PVar^.Reg;
    Goto Addr1;
   End;
   If(w1<>$7FFF)Then Begin
    r0:=$F0;
    s1:=CurrPC.PVar^.Size;
    Goto Addr1;
   End
    Else
   Begin
    w1:=GetOffVarGlobal(CurrPC.S4);
    If w1<>-1Then Begin
     r0:=$B0;s1:=CurrPC.PVar^.Size;
     If NumParam=2Then Begin
      If SI<>','Then Begin
       CompileAsm:=VirguleExpected;
       Exit;
      End;
      Inc(CurrPC.I);
     End;
    End
     Else
    Goto Addr1;
   End
{   Goto Addr1;}
  End
   Else
  Repeat
Addr1:
   If(NumParam=1)and(r0 in[8,16,32])Then Break;
   SaveAddr;
   Case(SI)of
    ',':Begin
     Inc(CurrPC.I);
     Break;
    End;
    '[':Goto Off1;
    ':':If(r0)in[17,18]Then Begin
     Inc(CurrPC.I);
     PushByte(SegComma[r1]);
Off1:If SI<>'['Then Begin
      CompileAsm:=OpenArrayExpected;
      Exit;
     End;
     r0:=$B0;
     Inc(CurrPC.I);
     w1:=XtrkInteger(CurrPC.Ok);
     If Not(CurrPC.Ok)Then Begin
      CurrPC.S5:=XtrkLabelAsm;
      o1:=GetCodeRegAsm(CurrPC.S5,o2);
      If(o2 in[16,32])and(o1 in[3,5,6,7])Then Begin
       Inc(r0,$10);
       Case(SI)of
        '+':Begin
         Inc(CurrPC.I);
         CurrPC.S5:=XtrkLabelAsm;
         o3:=GetCodeRegAsm(CurrPC.S5,o4);
         If(o2<>o4)Then Begin { Registre offset de taille diffÇrente? }
          CompileAsm:=SyntaxError;
          Exit;
         End;
         If o3=$FFThen Begin
          w1:=XtrkInteger(CurrPC.Ok);
          If Not(CurrPC.Ok)Then Begin
           CompileAsm:=SyntaxError;
           Exit;
          End
           Else
          Case(o1)of
           3:r0:=$D7;
           5:r0:=$D6;
           6:r0:=$D4;
           7:r0:=$D5;
          End;
         End
          Else
         Begin
          If(o4=16)and(o3 in[3,5,6,7])Then Begin
           If((o1=3)and(o3=6))or((o3=3)and(o1=6))Then r0:=$C0 Else
           If((o1=3)and(o3=7))or((o3=3)and(o1=7))Then r0:=$C1 Else
           If((o1=5)and(o3=6))or((o3=5)and(o1=6))Then r0:=$C2 Else
           If((o1=5)and(o3=7))or((o3=5)and(o1=7))Then r0:=$C3
            Else
           Begin
            CompileAsm:=SyntaxError;
            Exit;
           End;
          End
           Else
          Begin
           CompileAsm:=SyntaxError;
           Exit;
          End;
          Case(SI)of
           '+':Begin
            Inc(CurrPC.I);
            w1:=XtrkInteger(CurrPC.Ok);
            If Not(CurrPC.Ok)Then Begin
             CompileAsm:=SyntaxNumber;
             Exit;
            End;
            Inc(r0,$10);
           End;
           '-':Begin
            Inc(CurrPC.I);
            w1:=XtrkInteger(CurrPC.Ok);
            If Not(CurrPC.Ok)Then Begin
             CompileAsm:=SyntaxNumber;
             Exit;
            End;
            Inc(r0,$20);
           End;
          End;
         End;
        End;
        '-':Begin
         Inc(CurrPC.I);
         w1:=XtrkInteger(CurrPC.Ok);
         If Not(CurrPC.Ok)Then Begin
          CompileAsm:=SyntaxNumber;
          Exit;
         End;
         Inc(r0,$20);
        End;
        ']':Case(o1)of
         3:r0:=$C7;
         5:Begin
          r0:=$F0;
          w1:=0;
         End;
         6:r0:=$C4;
         7:r0:=$C5;
        End;
       End;
      End
       Else
      Begin
       CompileAsm:=SyntaxError;
       Exit;
      End;
     End;
     If SI<>']'Then Begin
      CompileAsm:=CloseArrayExpected;
      Exit;
     End;
     Inc(CurrPC.I);
    End;
    Else If(r0)in[17,18]Then Begin
     RestoreAddr;
     Break;
    End
     Else
    Begin
     CompileAsm:=VirguleExpected;
     Exit;
    End;
   End;
   If NumParam=1Then Break;
  Until No;
  If NumParam>=2Then Begin
   w2:=XtrkInteger(CurrPC.Ok);
   If(CurrPC.Ok)Then r2:=$B1
    Else
   Begin
    CurrPC.S5:=XtrkLabelAsm;
    r3:=GetCodeRegAsm(CurrPC.S5,r2);
    If r3=$FFThen Begin
     w2:=GetOffVarLocal(CurrPC.S5);
     If w2=$7FFEThen Begin
      r2:=CurrPC.PVar^.SizeReg;
      r3:=CurrPC.PVar^.Reg;
      Instr2Param:=Ya;
      Exit;
     End
      Else
     Begin
      If w2=$7FFFThen Begin
       w2:=GetOffVarGlobal(CurrPC.S5);
       If w2<>-1Then Begin
        r2:=$B0;
       End;
      End
       Else
      Begin
       r2:=$F0;
       s2:=CurrPC.PVar^.Size;
      End;
     End;
    End
     Else
    Begin
     Begin
Addr2:
      SaveAddr;
      Case(SI)of
       '[':Goto Off2;
       ':':If(r2)in[17,18]Then Begin
        Inc(CurrPC.I);
        PushByte(SegComma[r3]);
   Off2:If SI<>'['Then Begin
         CompileAsm:=OpenArrayExpected;
         Exit;
        End;
        r2:=$B0;Inc(CurrPC.I);
        w2:=XtrkInteger(CurrPC.Ok);
        If Not(CurrPC.Ok)Then Begin
         CurrPC.S5:=XtrkLabelAsm;
         o1:=GetCodeRegAsm(CurrPC.S5,o2);
         If(o2 in[16,32])and(o1 in[3,5,6,7])Then Begin
          Inc(r2,$10);
          Case(SI)of
           '+':Begin
            Inc(CurrPC.I);
            CurrPC.S5:=XtrkLabelAsm;
            o3:=GetCodeRegAsm(CurrPC.S5,o4);
            If(o2<>o4)Then Begin { Registre offset de taille diffÇrente? }
             CompileAsm:=SyntaxError;
             Exit;
            End;
            If o3=$FFThen Begin
             w2:=XtrkInteger(CurrPC.Ok);
             If Not(CurrPC.Ok)Then Begin
              CompileAsm:=SyntaxError;
              Exit;
             End
              Else
             Case(o1)of
              3:r2:=$D7;
              5:r2:=$D6;
              6:r2:=$D4;
              7:r2:=$D5;
             End;
            End
             Else
            Begin
             If(o4=16)and(o3 in[3,5,6,7])Then Begin
              If((o1=3)and(o3=6))or((o3=3)and(o1=6))Then r2:=$C0 Else
              If((o1=3)and(o3=7))or((o3=3)and(o1=7))Then r2:=$C1 Else
              If((o1=5)and(o3=6))or((o3=5)and(o1=6))Then r2:=$C2 Else
              If((o1=5)and(o3=7))or((o3=5)and(o1=7))Then r2:=$C3
               Else
              Begin
               CompileAsm:=SyntaxError;
               Exit;
              End;
             End
              Else
             Begin
              CompileAsm:=SyntaxError;
              Exit;
             End;
             Case(SI)of
              '+':Begin
               Inc(CurrPC.I);
               w2:=XtrkInteger(CurrPC.Ok);
               If Not(CurrPC.Ok)Then Begin
                CompileAsm:=SyntaxNumber;
                Exit;
               End;
               Inc(r2,$10);
              End;
              '-':Begin
               Inc(CurrPC.I);
               w2:=XtrkInteger(CurrPC.Ok);
               If Not(CurrPC.Ok)Then Begin
                CompileAsm:=SyntaxNumber;
                Exit;
               End;
               Inc(r2,$20);
              End;
             End;
            End;
           End;
           '-':Begin
            Inc(CurrPC.I);
            w2:=XtrkInteger(CurrPC.Ok);
            If Not(CurrPC.Ok)Then Begin
             CompileAsm:=SyntaxNumber;
             Exit;
            End;
            Inc(r2,$20);
           End;
           ']':Case(o1)of
            3:r2:=$C7;
            5:Begin
             r2:=$F0;
             w2:=0;
            End;
            6:r2:=$C4;
            7:r2:=$C5;
           End;
          End;
         End
          Else
         Begin
          CompileAsm:=SyntaxError;
          Exit;
         End;
        End;
        If SI<>']'Then Begin
         CompileAsm:=CloseArrayExpected;
         Exit;
        End;
        Inc(CurrPC.I);
       End;
       Else RestoreAddr;
      End;
     End;
    End;
   End;
  End;
  Instr2Param:=Ya;
 End;

 Function PushAddr(Const S:String;Code:Byte):Boolean;
 Var
  wI:Integer;
 Begin
  PushAddr:=True;
  Case(r0)of
   $B0:If r3<8Then PushInstrOffset(S+Chr(Code+6),w1)
        Else
       Begin
        PushAddr:=False;
        CompileAsm:=SyntaxError;
       End;
   $C0..$C7:If r3<8Then PushInstr(S+Chr(Code+(r0 and 7)+(r3 shl 3)))
            Else Begin
             PushAddr:=False;
             CompileAsm:=SyntaxError;
            End;
   $D0..$D7:If r3<8Then Begin
             If w1<=127Then PushInstr(S+Chr(Code+$40+(r0 and 7)+(r3 shl 3))+Chr(w1))
                       Else PushInstr(S+Chr(Code+$80+(r0 and 7)+(r3 shl 3))+Chr(Lo(w1))+Chr(Hi(w1)))
            End
            Else Begin
             PushAddr:=False;
             CompileAsm:=SyntaxError;
            End;
   $E0..$E7:If r3<8Then Begin
             If w1<=128Then PushInstr(S+Chr(Code+$40+(r0 and 7)+(r3 shl 3))+Chr($100-w1))
              Else
             Begin
              wi:=-w1;
              PushInstr(S+Chr(Code+$80+(r0 and 7)+(r3 shl 3))+Chr(Lo(wi))+Chr(Hi(wi)))
             End;
            End
            Else Begin
             PushAddr:=False;
             CompileAsm:=SyntaxError;
            End;
   $F0:Case Integer(w1)of
    -128..127:PushInstr(S+Chr($80+Code)+Chr(ShortInt(w1)));
         Else PushInstrOffset(S+Chr($80+Code),w1);
   End;
   Else If(r1<8)and(r3<8)Then PushInstr(S+Chr(Code+$C0+r1+(r3 shl 3)))
        Else Begin
         PushAddr:=False;
         CompileAsm:=SyntaxError;
        End;
  End;
 End;

 Function PushAddr1(Const S:String):Boolean;
 Var
  wI:Integer;
 Begin
  PushAddr1:=True;
  Case(r0)of
   $B0:If r3<8Then PushInstrOffset(S+Chr(SikReg[r3]),w1)
       Else Begin
        PushAddr1:=False;
        CompileAsm:=SyntaxError;
       End;
   $B1:Begin
    Case(r2)of
     8:Push2Byte($80,$C0+(Byte(S[1])and$FC)+r3);
     16:Push2Byte($81,$C0+(Byte(S[1])and$FC)+r3);
     32:Push3Byte($66,$81,$C0+(Byte(S[1])and$FC)+r3);
    End;
    PushAddWord(w1);
   End;
   $C0..$C7:If r3<8Then PushInstr(S+Chr((r0 and 7)+(r3 shl 3)))
            Else Begin
             PushAddr1:=False;
             CompileAsm:=SyntaxError;
            End;
   $D0..$D7:If r3<8Then Begin
             If w1<=127Then PushInstr(S+Chr($40+(r0 and 7)+(r3 shl 3))+Chr(w1))
                       Else PushInstr(S+Chr($80+(r0 and 7)+(r3 shl 3))+Chr(Lo(w1))+Chr(Hi(w1)))
            End
            Else Begin
             PushAddr1:=False;
             CompileAsm:=SyntaxError;
            End;
   $E0..$E7:If r3<8Then Begin
             If w1<=128Then PushInstr(S+Chr($40+(r0 and 7)+(r3 shl 3))+Chr($100-w1))
              Else
             Begin
              wi:=-w1;
              PushInstr(S+Chr($80+(r0 and 7)+(r3 shl 3))+Chr(Lo(wi))+Chr(Hi(wi)))
             End;
            End
            Else Begin
             PushAddr1:=False;
             CompileAsm:=SyntaxError;
            End;
   $F0:Case Integer(w1)of
    -128..127:PushInstr(S+Chr($40+SikReg[r3])+Chr(ShortInt(w1)));
         Else PushInstrOffset(S+Chr($80+SikReg[r3]),w1);
   End;
   Else If(r1<8)and(r3<8)Then PushInstr(S+Chr($C0+r1+(r3 shl 3)))
        Else Begin;PushAddr1:=No;CompileAsm:=SyntaxError;End;
  End;
 End;

 Function PushAddr2(Const S:String):Boolean;
 Var
  T:Byte;
  TW:Word;
 Begin
  T:=r0;r0:=r2;r2:=T;
  (*If(r0 or r2>80){(r1 or r3>8)}Then*) Begin
   T:=r1;r1:=r3;r3:=T;
  End;
  TW:=w1;w1:=w2;w2:=TW;
  PushAddr2:=PushAddr1(S);
 End;

Begin
 CompileAsm:=0;
 Repeat
  CurrPC.S3:=XtrkLabelAsm;Co:=Ya;r:=$FF;r0:=$FF;r1:=$FF;r2:=$FF;
  LastNameVar:='';PA:=SearchWordAsm(CurrPC.S3);
  If(PA<>NIL)and(Not PA^.Parameters)Then Begin
   PushInstr(CurrPC.SuggOpCode^);
  End
   Else
  If(PA<>NIL)Then Case(PA^.Code)of
   caMOV:Begin
    If Not Instr2Param(2)Then Exit;
    Case(r0 or r2)of
     8:Begin
      o1:=CurrPC.CodePrg^[CurrPC.PrevIP];
      o2:=CurrPC.CodePrg^[CurrPC.PrevIP+1];
      If(o1=$88)and(o2 in[$C0..$C3])and($C0-4+r1-o2=0)and(r3=4)Then Begin
       r1:=r1 and 3;r3:=r3 and 3;
       Inc(CurrPC.CodePrg^[CurrPC.PrevIP]);
       CurrPC.CodePrg^[CurrPC.PrevIP+1]:=$C0+r1+(r3 shl 3);
      End
       Else
      PushAddr1(#$88);
     End;
     16:PushAddr1(#$89);
     32:PushAddr1(#$66#$89);
     Else Case(r0)of
      8:Case(r2)of
       $B0:If r1=0Then PushInstrOffset(#$A0,w2)Else
           If Not PushAddr2(#$8A)Then Exit;
       $B1:If s1<=1Then Push2Byte($B0+r1,w2)
        Else
       Begin
        CompileAsm:=TypeMistmatch;
        Exit;
       End;
       $B2..$F0:If Not PushAddr2(#$8A)Then Exit;
       Else Begin
        CompileAsm:=SyntaxError;
        Exit;
       End;
      End;
      16:Case(r2)of
       $B0:If r1=0Then PushInstrOffset(#$A1,w2)
                  Else PushAddr2(#$8B);
       $B1:If(s1)in[0,2]Then Push3Byte($B8+r1,Lo(w2),Hi(w2))
        Else
       Begin
        CompileAsm:=TypeMistmatch;
        Exit;
       End;
       $B2..$F0:If Not PushAddr2(#$8B)Then Exit;
       17:If Not PushAddr1(#$8C)Then Exit;
       Else Begin
        CompileAsm:=SyntaxError;
        Exit;
       End;
      End;
      17:Case(r2)of
       $B0:PushAddr2(#$8E);
       16,$B1..$F0:PushAddr1(#$8E);
       17:Begin { MOV SEG,SEG ? }
        Case(r1)of
         0:PushByte(ciPushES);
         1:PushByte(ciPushCS);
         2:PushByte(ciPushSS);
         3:PushByte(ciPushDS);
         4:PushWord(ciPushFS);
         5:PushWord(ciPushGS);
        End;
        Case(r3)of
         0:PushByte(ciPopES);
         1:Begin
          CompileAsm:=TypeMistmatch;
          Exit;
         End;
         2:PushByte(ciPopSS);
         3:PushByte(ciPopDS);
         4:PushWord(ciPopFS);
         5:PushWord(ciPopGS);
        End;
       End;
       Else Begin
        CompileAsm:=SyntaxError;
        Exit;
       End;
      End;
      32:Case(r2)of
       33:If Not PushAddr2(#$0F#$22)Then Exit;
       34:If Not PushAddr2(#$0F#$23)Then Exit;
       35:If Not PushAddr2(#$0F#$26)Then Exit;
       $B0:If r1=0Then PushInstrOffset(#$66#$A1,w2)
                  Else PushAddr2(#$66#$87);
       $B1:If(s1)in[0,4]Then Begin
        If Not PushAddr1(#$66#$C7)Then Exit;
       End
        Else
       Begin
        CompileAsm:=TypeMistmatch;
        Exit;
       End;
       $B2..$F0:If Not PushAddr2(#$66#$87)Then Exit;
       Else Begin
        CompileAsm:=SyntaxError;
        Exit;
       End;
      End;
      33:Case(r2)of
       32,$B0..$F0:If Not PushAddr2(#$0F#$20)Then Exit;
       Else Begin
        CompileAsm:=SyntaxError;
        Exit;
       End;
      End;
      34:Case(r2)of
       32,$B0..$F0:If Not PushAddr2(#$0F#$21)Then Exit;
       Else Begin
        CompileAsm:=SyntaxError;
        Exit;
       End;
      End;
      35:Case(r2)of
       32,$B0..$F0:If Not PushAddr2(#$0F#$24)Then Exit;
       Else Begin
        CompileAsm:=SyntaxError;
        Exit;
       End;
      End;
      80:Case(r2)of
       32,$B0..$F0:If Not PushAddr2(#$0F#$6E)Then Exit;
       Else Begin
        CompileAsm:=SyntaxError;
        Exit;
       End;
      End;
      $B0:Case(r2)of
       8,16,32:Begin
        If r3=0Then Case(r2)of
         8:PushInstrOffset(#$A2,w1);
         16:PushInstrOffset(#$A3,w1);
         32:PushInstrOffset(#$66#$A3,w1);
         Else Begin
          CompileAsm:=SyntaxError;
          Exit;
         End;
        End
         Else
        Case(r2)of
         8:PushAddr1(#$88);
         16:PushAddr1(#$89);
         32:PushAddr1(#$66#$89);
         Else Begin
          CompileAsm:=SyntaxError;
          Exit;
         End;
        End;
       End;
       33:If Not PushAddr1(#$0F#$22)Then Exit;
       34:If Not PushAddr1(#$0F#$23)Then Exit;
       35:If Not PushAddr1(#$0F#$26)Then Exit;
       80:If Not PushAddr1(#$0F#$7E)Then Exit;
       Else Begin
        CompileAsm:=SyntaxError;
        Exit;
       End;
      End;
      $B1..$F0:Case(r2)of
       8:If Not PushAddr1(#$88)Then Exit;
       16:If Not PushAddr1(#$89)Then Exit;
       32:If Not PushAddr1(#$66#$89)Then Exit;
       33:If Not PushAddr1(#$0F#$22)Then Exit;
       34:If Not PushAddr1(#$0F#$23)Then Exit;
       35:If Not PushAddr1(#$0F#$26)Then Exit;
       80:If Not PushAddr1(#$0F#$7E)Then Exit;
       Else Begin
        CompileAsm:=SyntaxError;
        Exit;
       End;
      End;
      Else Begin
       CompileAsm:=SyntaxError;
       Exit;
      End;
     End;
    End;
   End;
caADD,caOR,caADC,caSBB,caAND,caSUB,caXOR,caCMP:Begin
    r:=Byte(CurrPC.SuggOpCode^[1]);
    If Not Instr2Param(2)Then Exit;
    If(InstrFormat>=p286)and(r0 in[8,16,32])and(r1=0)and(r2=$B1)Then Begin
     Case(r0)of
      32:If(InstrFormat>=p386)Then Begin
       CompileAsm:=OpCode386;
       Exit;
      End
       Else
      PushInstr(Chr((r+1)or 4)+Chr(Lo(w2))+Chr(Hi(w2))+#0#0);
      16:Push3Byte((r+1)or 4,Lo(w2),Hi(w2));
      Else Push2Byte(r or 4,w2);
     End;
    End
     Else
    Case(r0)of
     8:Case(r2)of
      8,$B0..$F0:If Not PushAddr2(Chr(r+2))Then Exit;
      Else Begin
       CompileAsm:=SyntaxError;
       Exit;
      End;
     End;
     16:Case(r2)of
      16,$B0..$F0:If Not PushAddr2(Chr(r+1+2))Then Exit;
      Else Begin
       CompileAsm:=SyntaxError;
       Exit;
      End;
     End;
     32:Case(r2)of
      32,$B0..$F0:If Not PushAddr2(#$66+Chr(r+1+2))Then Exit;
      Else Begin
       CompileAsm:=SyntaxError;
       Exit;
      End;
     End;
     $B0..$F0:Case(r2)of
      8:If Not PushAddr1(Chr(r))Then Exit;
      16:If Not PushAddr1(Chr(r+1))Then Exit;
      32:If Not PushAddr1(Chr(r+1))Then Exit;
      $B1:Case(s1)of
       1:Begin
        If Not PushAddr(#$80,r)Then Exit;
        PushAddByte(w2);
       End;
       2:Begin
        If Not PushAddr(#$81,r)Then Exit;
        PushAddWord(w2);
       End;
       4:Begin
        If Not PushAddr(#$66#$81,r)Then Exit;
        PushAddLong(w2);
       End;
       Else Begin
        CompileAsm:=TypeMistmatch;
        Exit;
       End;
      End;
      Else Begin
       CompileAsm:=SyntaxError;
       Exit;
      End;
     End;
     Else Begin
      CompileAsm:=SyntaxError;
      Exit;
     End;
    End;
   End;
caROL,caROR,caSAL,caSAR,caSHL,caSHR:Begin
   If Not Instr2Param(2)Then Exit;
   r:=r1+Byte(CurrPC.SuggOpCode^[1])+$C0;
   Case(r0)of
    8:Case(r2)of
     8:If r3=1Then Push2Byte($D2,r);
     $B1:Begin
      If w1=1Then Push2Byte($D0,r)Else
      If(InstrFormat>=p286)Then Push3Byte($C0,r,w1)
      Else Begin
       CompileAsm:=OpCode286;
       Exit;
      End;
     End;
     Else Begin
      CompileAsm:=SyntaxError;
      Exit;
     End;
    End;
    16:Case(r2)of
     8:If r3=1Then Push2Byte($D3,r);
     $B1:Begin
      If w2=1Then Push2Byte($D1,r)Else
      If(InstrFormat>=p286)Then Push3Byte($C1,r,w1)
      Else Begin
       CompileAsm:=OpCode286;
       Exit;
      End;
     End;
     Else Begin
      CompileAsm:=SyntaxError;
      Exit;
     End;
    End;
    32:If(InstrFormat<p386)Then Begin
     CompileAsm:=OpCode386;
     Exit;
    End
     Else
    Case(r2)of
     8:If r3=1Then Push3Byte($66,$D3,r);
     $B1:Begin
      If w1=1Then Push3Byte($66,$D1,r)Else
      If(InstrFormat>=p286)Then PushInstr(#$66#$C1+Chr(r)+Chr(w1))
      Else Begin
       CompileAsm:=OpCode286;
       Exit;
      End;
     End;
     Else Begin
      CompileAsm:=SyntaxError;
      Exit;
     End;
    End;
    $B0..$F0:Begin
     If r2=$B1Then Begin
      If w1=1Then Begin
       Case(s1)of
        1:If Not PushAddr(#$D0,Byte(CurrPC.SuggOpCode^[1]))Then Exit;
        2:If Not PushAddr(#$D1,Byte(CurrPC.SuggOpCode^[1]))Then Exit;
        4:If Not PushAddr(#$66#$D1,Byte(CurrPC.SuggOpCode^[1]))Then Exit;
        Else Begin
         CompileAsm:=TypeMistmatch;
         Exit;
        End;
       End;
      End
       Else
      If(InstrFormat>=p286)Then Begin
       Case(s1)of
        1:If Not PushAddr(#$C0,Byte(CurrPC.SuggOpCode^[1]))Then Exit;
        2:If Not PushAddr(#$C1,Byte(CurrPC.SuggOpCode^[1]))Then Exit;
        4:If Not PushAddr(#$66#$C1,Byte(CurrPC.SuggOpCode^[1]))Then Exit;
        Else Begin
         CompileAsm:=TypeMistmatch;
         Exit;
        End;
       End;
       PushAddByte(w1);
      End
       Else
      Begin
       CompileAsm:=OpCode286;
       Exit;
      End;
     End
      Else
     If r3=1Then Begin
      Case(s1)of
       1:If Not PushAddr(#$D2,Byte(CurrPC.SuggOpCode^[1]))Then Exit;
       2:If Not PushAddr(#$D3,Byte(CurrPC.SuggOpCode^[1]))Then Exit;
       4:If Not PushAddr(#$66#$D3,Byte(CurrPC.SuggOpCode^[1]))Then Exit;
       Else Begin
        CompileAsm:=TypeMistmatch;
        Exit;
       End;
      End;
     End
      Else
     Begin
      CompileAsm:=SyntaxError;
      Exit;
     End;
    End;
    Else Begin
     CompileAsm:=SyntaxError;
     Exit;
    End;
   End;
  End;
caXCHG:Begin
   If Not Instr2Param(2)Then Exit;
   Case(r0)of
    8:If Not PushAddr2(#$86)Then Exit;
    16:Case(r2)of
     16:If r1=0Then PushByte($90+r3)Else
        If r3=0Then PushByte($90+r1)
               Else If Not PushAddr2(#$87)Then Exit;
     Else If Not PushAddr2(#$87)Then Exit;
    End;
    32:Case(r2)of
     32:If r1=0Then Push2Byte($66,$90+r3)Else
        If r3=0Then Push2Byte($66,$90+r1)
               Else If Not PushAddr2(#$66#$87)Then Exit;
     Else If Not PushAddr2(#$66#$87)Then Exit;
    End;
    Else Begin
     CompileAsm:=SyntaxError;
     Exit;
    End;
   End;
  End;
caTest:Begin
   If Not Instr2Param(2)Then Exit;
   Case(r0)of
    8:If r2=$B1Then Push3Byte($F6,$C0+r1,w1)
     Else
    Begin
     CompileAsm:=SyntaxError;
     Exit;
    End;
    16:If r2=$B1Then Begin
     Push2Byte($F7,$C0+r1);
     PushAddWord(w1);
    End
     Else
    Begin
     CompileAsm:=SyntaxError;
     Exit;
    End;
    32:If r2=$B1Then Begin
     Push3Byte($66,$F7,$C0+r1);
     PushAddWord(w1);
    End
     Else
    Begin
     CompileAsm:=SyntaxError;
     Exit;
    End;
    Else Begin
     CompileAsm:=SyntaxError;
     Exit;
    End;
   End;
  End;
  caSETA,caSETAE,caSETB,caSETBE,caSETC,caSETE,caSETG,caSETGE,caSETL,caSETLE,
  caSETNA,caSETNAE,caSETNB,caSETNC,caSETNE,caSETNG,caSETNGE,caSETNL,caSETNLE,
  caSETNO,caSETNP,caSETNS,caSETNZ,caSETO,caSETP,caSETPE,caSETPO,caSETS,
  caSETZ:If(InstrFormat<p386)Then Begin
   CompileAsm:=OpCode386;
   Exit;
  End
   Else
  Begin
   If Not Instr2Param(1)Then Exit;
   If((r0)in[8,$B0..$F0])and(s1<=1)Then If Not PushAddr1(CurrPC.SuggOpCode^)Then Exit;
  End;
caRETN,caRET:PushByte(ciRETN);
caRETF:PushByte(ciRETF);
caREP,caREPE,caREPZ,caREPNZ,caREPNE:Begin
   PushByte(Byte(CurrPC.SuggOpCode^[1]));
   Co:=No;
  End;
caPUSH:Begin
    If Not Instr2Param(1)Then Exit;
    Case(r0)of
     16:PushByte($50+r1);
     17:PushByte($06+(r1 shl 3));
     18:If(InstrFormat<p386)Then Begin;CompileAsm:=OpCode386;Exit;End
        Else Push2Byte($0F,$80+(r1 shl 3));
     32:If(InstrFormat<p386)Then Begin;CompileAsm:=OpCode386;Exit;End
        Else Push2Byte($66,$50+r1);
     $B1:Begin
      If Hi(w1)<>0Then Push3Byte($68,Lo(w1),Hi(w1))
                  Else Push2Byte($6A,w1);
     End;
     Else Begin
      CompileAsm:=SyntaxError;
      Exit;
     End;
    End;
   End;
caPOP:Begin
    CurrPC.S4:=XtrkLabelAsm;
    r1:=GetCodeRegAsm(CurrPC.S4,r);
    If r1<>$FFThen Case(r)of
     16:PushByte($58+r1);
     17:PushByte($07+(r1 shl 3));
     18:If(InstrFormat<p386)Then Begin
      CompileAsm:=OpCode386;
      Exit;
     End
      Else
     Push2Byte($0F,$81+(r1 shl 3));
     32:If(InstrFormat<p386)Then Begin
      CompileAsm:=OpCode386;
      Exit;
     End
      Else
     Push2Byte($66,$58+r1);
     Else Begin
      CompileAsm:=SyntaxError;
      Exit;
     End;
    End
     Else
    Begin
      { Mot ou valeur inconnu ... }
     CompileAsm:=SyntaxError;
     Exit;
    End;
   End;
caOUT:Begin
    If Not Instr2Param(2)Then Exit;
    If(r0=16)and(r1=2)and(r3=0)Then Case(r2)of
     8:PushInstr(#$EE);
     16:PushInstr(#$EF);
     32:PushInstr(#$66#$EF);
     Else Begin
      CompileAsm:=TypeMistmatch;
      Exit;
     End;
    End
     Else
    Begin
     CompileAsm:=SyntaxError;
     Exit;
    End;
   End;
caMOVZX:Begin
    If Not Instr2Param(2)Then Exit;
    Case(r0)of
     16:Case(r2)of
      8,$B0..$F0:
      If(r2=8)and(r1=r3 shr 1)and(r3 and 1=0)Then Push2Byte($B4+(r1 shl 1),0)
       Else
      If(InstrFormat>=p386)Then Begin
       If Not PushAddr2(#$0F#$B6)Then Exit;
      End
       Else
      Begin
       r:=r1;
       If Not PushAddr2(#$8A)Then Exit;
       If r<=3Then Push2Byte($B4+r,0)
        Else
       Begin
        Push2Byte($81,$E0+r);
        PushAddWord($FF)
       End
      End;
      Else Begin
       CompileAsm:=SyntaxError;
       Exit;
      End;
     End;
     Else Begin
      CompileAsm:=SyntaxError;
      Exit;
     End;
    End;
   End;
caMOVQ:Begin
    If Not Instr2Param(2)Then Exit;
    Case(r0)of
     64:If((r2)in[32,$B0..$F0])and(s1 in[0,8])Then Begin
      If Not PushAddr2(#$0F#$6F)Then Exit;
     End
      Else
     Begin
      CompileAsm:=TypeMistmatch;
      Exit;
     End;
     32,$B0..$F0:If(s2)in[0,8]Then Begin
      If Not PushAddr1(#$0F#$7F)Then Exit;
     End
      else
     Begin
      CompileAsm:=TypeMistmatch;
      Exit;
     End;
     Else Begin
      CompileAsm:=SyntaxError;
      Exit;
     End;
    End;
   End;
caMOVD:Begin
    If Not Instr2Param(2)Then Exit;
    Case(r0)of
     64:If((r2)in[32,$B0..$F0])and(s1 in[0,4])Then Begin
      If Not PushAddr2(#$0F#$6E)Then Exit;
     End
      Else
     Begin
      CompileAsm:=TypeMistmatch;
      Exit;
     End;
     32,$B0..$F0:If(s2)in[0,4]Then Begin
      If Not PushAddr1(#$0F#$7E)Then Exit;
     End
      Else
     Begin
      CompileAsm:=TypeMistmatch;
      Exit;
     End;
     Else Begin
      CompileAsm:=SyntaxError;
      Exit;
     End;
    End;
   End;
caLDS,caLEA,caLES,caLFS,caLGS,caLSS:Begin
    If Not Instr2Param(2)Then Exit;
    Case(r0)of
     16:If Not PushAddr2(CurrPC.SuggOpCode^)Then Exit;
     32:If Not PushAddr2(#$66+CurrPC.SuggOpCode^)Then Exit;
     Else Begin
      CompileAsm:=SyntaxError;
      Exit;
     End;
    End;
   End;
caINC:Begin
    If Not Instr2Param(1)Then Exit;
    Case(r0)of
     8:Push2Byte($FE,$C0+r1);
     16:PushByte(ciIncAX+r1);
     32:If(InstrFormat<p386)Then Begin
      CompileAsm:=OpCode386;
      Exit;
     End
      Else
     Push2Byte($66,ciIncAX+r1);
     $B0..$F0:Case(s1)of
      1:If Not PushAddr(#$FE,0)Then Exit;
      2:If Not PushAddr(#$FF,0)Then Exit;
      4:If(InstrFormat<p386)Then Begin
       CompileAsm:=OpCode386;
       Exit;
      End
       Else
      If Not PushAddr(#$66#$FF,0)Then Exit;
      Else Begin
       CompileAsm:=SyntaxError;
       Exit;
      End;
     End
     Else Begin
      CompileAsm:=SyntaxError;
      Exit;
     End;
    End;
   End;
caIN:Begin
    If Not Instr2Param(2)Then Exit;
    If(r2=16)and(r3=2)and(r1=0)Then Case(r0)of
     8:PushInstr(#$EC);
     16:PushInstr(#$ED);
     32:PushInstr(#$66#$ED);
     Else Begin
      CompileAsm:=TypeMistmatch;
      Exit;
     End;
    End
     Else
    Begin
     CompileAsm:=SyntaxError;
     Exit;
    End;
   End;
caIF:Begin
    r:=GetCodeIfCondAsm(XtrkLabelAsm);
    If r=$FFThen Begin
     CompileAsm:=SyntaxError;
     Exit;
    End;
    w1:=CurrPC.IP;
    Push2Byte(r,0);
    CurrPC.W:=CompileAsm(Ya);
    If CurrPC.W<>0Then Begin
     CompileAsm:=CurrPC.W;
     Exit;
    End;
    CurrPC.CodePrg^[w1+1]:=CurrPC.IP-w1-2;
    If SI=';'Then Inc(CurrPC.I);
    Continue;
   End;
  caLOOP,caLOOPNZ,caLOOPNE,caLOOPE,caLOOPZ,
  caJA,caJAE,caJB,caJBE,caJC,caJE,caJG,caJGE,caJL,caJLE,caJNA,caJNAE,
  caJNB,caJNC,caJNE,caJNG,caJNGE,caJNL,caJNLE,caJNO,caJNP,caJNS,caJNZ,
  caJO,caJP,caJPE,caJPO,caJS,caJZ,caJmp,caJCXZ,caJECXZ:Begin
    CurrPC.S4:=XtrkLabelAsm;
    If Not AddJump(isJump,CurrPC.IP,CurrPC.S4)Then Begin
     CompileAsm:=OutOfMemory;
     Exit;
    End;
    Push2Byte(Byte(CurrPC.SuggOpCode^[1]),0);
   End;
caFLOAT:Begin
    CurrPC.S4:=XtrkLabelAsm;
    If CurrPC.S4='TEST'Then PushInstr(asmFTST)Else
    If CurrPC.S4='SIN'Then PushInstr(asmFSIN)Else
    If CurrPC.S4='SCALE'Then PushInstr(asmFSCALE)Else
    If CurrPC.S4='ROUND'Then Begin
     CurrPC.S4:=XtrkLabelAsm;
     If CurrPC.S4='INTEGER'Then PushInstr(asmFRNDINT)
      Else
     Begin
      CompileAsm:=SyntaxError;
      Exit;
     End;
    End
     Else
    If CurrPC.S4='NOP'Then PushInstr(asmFNOP)Else
    If CurrPC.S4='LOAD'Then Begin
     CurrPC.S4:=XtrkLabelAsm;
     If(CurrPC.S4='Z')or(CurrPC.S4='ZERO')Then PushInstr(asmFLDZ)Else
     If CurrPC.S4='PI'Then PushInstr(asmFLDPI){Else
     If(S4='CONTROL')or(S4='CTRL')or(S4='C')Then Begin
      S4:=XtrkWd;
      If(S4='WORD')or(S4='W')Then PushInstr(asmFLDCW)
      Else Begin;CompileAsm:=SyntaxeError;Exit;End;
     End}
      Else
     Begin
      If SI<>'1'Then Begin
       CompileAsm:=SyntaxError;
       Exit;
      End;
      Inc(CurrPC.I);
      PushInstr(asmFLD1);
     End;
    End
     Else
    If CurrPC.S4='INIT'Then PushInstr(asmFINIT)Else
    If CurrPC.S4='EXTRACT'Then PushInstr(asmFXTRACT)Else
    If(CurrPC.S4='ABS')or(CurrPC.S4='ABSOLUE')Then PushInstr(asmFABS)
    Else Begin;CompileAsm:=SyntaxError;Exit;End;
   End;
caFin,caEND:Break;
caDW:Begin
    CurrPC.W:=DataAsm(DW);
    If CurrPC.W<>0Then Begin
     CompileAsm:=CurrPC.W;
     Exit;
    End;
   End;
caDIV,caIDIV,caMUL,caIMUL,caNEG,caNOT:Begin
    If Not Instr2Param(1)Then Exit;
    r:=r1+Byte(CurrPC.SuggOpCode^[1]);
    Case(r0)of
     8:Push2Byte($F6,r);
     16:Push2Byte($F7,r);
     32:If(InstrFormat<p386)Then Begin
      CompileAsm:=OpCode386;
      Exit;
     End
      Else
     Push3Byte($66,$F7,r);
     $B0..$F0:Case(s1)of
      1:If Not PushAddr(#$F6,Byte(CurrPC.SuggOpCode^[1])-$C0)Then Exit;
      2:If Not PushAddr(#$F7,Byte(CurrPC.SuggOpCode^[1])-$C0)Then Exit;
      4:If(InstrFormat<p386)Then Begin;CompileAsm:=OpCode386;Exit;End
        Else If Not PushAddr(#$66#$F7,Byte(CurrPC.SuggOpCode^[1])-$C0)Then Exit;
      Else Begin
       CompileAsm:=SyntaxError;
       Exit;
      End;
     End;
     Else Begin
      CompileAsm:=SyntaxError;
      Exit;
     End;
    End;
   End;
caDEC:Begin
    CurrPC.S4:=XtrkLabelAsm;
    r1:=GetCodeRegAsm(CurrPC.S4,r);
    If r1<>$FFThen Case(r)of
     8:Push2Byte($FE,$C8+r1);
     16:PushByte(ciDecAX+r1);
     32:If(InstrFormat<p386)Then Begin
      CompileAsm:=OpCode386;
      Exit;
     End
      Else
     Push2Byte($66,ciDecAX+r1);
     Else Begin
      CompileAsm:=SyntaxError;
      Exit;
     End;
    End
     Else
    Begin
     { Mot ou valeur inconnu ... }
     CompileAsm:=SyntaxError;Exit;
    End;
   End;
caDD:Begin
    CurrPC.W:=DataAsm(DD);
    If CurrPC.W<>0Then Begin
     CompileAsm:=CurrPC.W;
     Exit;
    End;
   End;
caDB:Begin
    CurrPC.W:=DataAsm(DB);
    If CurrPC.W<>0Then Begin
     CompileAsm:=CurrPC.W;
     Exit;
    End;
   End;
caCALL:Begin
    CurrPC.l1:=XtrkNmAsm(Nm);
    If(Nm=aError)Then Begin
     CurrPC.S4:=XtrkLabelAsm;
     ALSetPtr(CurrPC.ProcBk,0);
     CurrPC.Ok:=No;
     CurrPC.PProc:=_ALGetCurrBuf(CurrPC.ProcBk);
     While(CurrPC.PProc<>NIL)do Begin
      If(CurrPC.PProc^.Name=CurrPC.S4)Then Begin
       CurrPC.W:=CurrPC.PProc^.Ofs-(CurrPC.IP+3);
       If(CurrPC.PPRoc^.CurrPtr=cmwpFar)Then Begin
        PushByte(ciPushCS);
        Dec(CurrPC.W)
       End;
       PushInstrOffset(asmCallNear,CurrPC.W);
       CurrPC.Ok:=Ya;
       Break;
      End;
      ALNext(CurrPC.ProcBk);
      CurrPC.PProc:=_ALGetCurrBuf(CurrPC.ProcBk);
     End;
     If Not(CurrPC.Ok)Then Begin
      CompileAsm:=SyntaxNumber;
      Exit;
     End;
    End
     Else
    Begin
     If CurrPC.l1>65535Then Begin
      CompileAsm:=TooBigNumber;
      Exit;
     End;
     If SI<>':'Then Begin
      CompileAsm:=ColonExpected;
      Exit;
     End;
     Inc(CurrPC.I);
     CurrPC.l2:=XtrkNmAsm(Nm);
     If(Nm=aError)Then Begin
      CompileAsm:=SyntaxNumber;
      Exit;
     End;
     If CurrPC.l2>65535Then Begin
      CompileAsm:=TooBigNumber;
      Exit;
     End;
     PushInstr(asmCallFarAbs);
     PushAddWord(CurrPC.l2);
     PushAddWord(CurrPC.l1);
    End;
   End;
caCS,caDS,caES,caFS,caGS,caSS:Begin
    If SI=':'Then Inc(CurrPC.I)
     Else
    Begin
     CompileAsm:=ColonExpected;
     Exit;
    End;
    PushByte(Byte(CurrPC.SuggOpCode^[1]));
   End;
caInt,caInterrupt:Begin
    J:=XtrkInteger(CurrPC.Ok);
    If Not(CurrPC.Ok)Then Begin
     CompileAsm:=SyntaxNumber;
     Exit;
    End;
    Push2Byte($CD,J);
   End;
  End
   Else
  Begin
   SaveAddr;
   If SI=':'Then Begin { êtiquette? }
    Inc(CurrPC.I);
    If Not AddJump(isLabel,CurrPC.IP,CurrPC.S3)Then Begin
     CompileAsm:=LabelDupl;
     Exit;
    End;
   End
    Else
   Begin
    RestoreAddr;
    CompileAsm:=EndExpected;
    Exit;
   End;
  End;
  PrevNL:=CurrPC.NL;
  If SI=';'Then Inc(CurrPC.I)Else
  If(PrevNL=CurrPC.NL)Then Begin
   If(Co)Then Begin
    CompileAsm:=PointCommaExpected;
    Exit;
   End;
  End;
  If(OneInstr)Then Break;
 Until No;
End;

{ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ}
END.