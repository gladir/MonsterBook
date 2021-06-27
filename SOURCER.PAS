{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                     Sourcer de code machine                   Û
 ³ Malte Genesis/Edition Chantal pour Mode R‚el/IV - Version 1.2 Û
 ³                          1997/01/02                           Û
 ³                                                               Û
 ³      Tous droits r‚serv‚ par les Chevaliers de Malte (C)      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ}


Unit Sourcer;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                  INTERFACE
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

{$I DEF.INC}

Uses Systex;

Const
 fAsm=0;
 fAlgol68=1;
 fC=2;
 f8080=0;
 fINTEL=1;
 f6502=2;

 DebugRLLCode:Byte=$FF; { ModŠle de pilote actuellement charg‚s en m‚moire }
 DebugRLLSeg:Word=0;    { Pointeur sur le pilote }

 OpCodeFormat:Byte=fAlgol68;
 OpCodeCPU:Byte=fINTEL;

 Reg8080:Array[0..7]of Char='BCDEHLMA';
 RegWord:Array[0..7]of String[2]=('AX','CX','DX','BX','SP','BP','SI','DI');
 RegByte:Array[0..7]of String[2]=('AL','CL','DL','BL','AH','CH','DH','BH');
 RegS:Array[0..3]of String[2]=('ES','CS','SS','DS');
 BasS:Array[0..7]of String[3]=('ADD','OR', 'ADC','SBB','AND','SUB','XOR','CMP');
 RotS:Array[0..7]of String[3]=('ROL','ROR','RCL','RCR','SHL','SHR','SAR','SAL');
 SmpS:Array[2..7]of String[4]=('NOT','NEG','MUL','IMUL','DIV','IDIV');
 PtrS:Array[0..1]of String[9]=('Byte Ptr ','Word Ptr ');
 PrcS:Array[0..1]of String[9]=('Near Ptr ','Far Ptr ');
 FlgS:Array[0..$F]of String[2]=(
  {0} 'O ',
  {1} 'NO',
  {2} 'C ',
  {3} 'NC',
  {4} 'Z ',
  {5} 'NZ',
  {6} 'BE',
  {7} 'A ',
  {8} 'S ',
  {9} 'NS',
  {A} 'P ',
  {B} 'NP',
  {C} 'L ',
  {D} 'NL',
  {E} 'G ',
  {F} 'NG');

Function Decode(Var Buf;Var I:Word):String;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                IMPLEMENTATION
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses
 Restex,ResServD,Memories,Systems,Dialex;

Const
 SourcerTable:Byte=$FF;
 SourcerDataBase:^DataSetInMemory=NIL;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                              Fonction HexByte                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet la transformation d'un valeur entiŠre de type octet
 en sa valeur hexad‚cimal en fonction du format de langage souhaiter.
}

Function HexByte(X:Byte):String;Near;
Var
 S:String;
Begin
 S:=HexByte2Str(X);
 Case(OpCodeFormat)of
fAlgol68:S:='$'+S;
      fC:S:='0x'+S;
    Else IncStr(S,'h');
 End;
 HexByte:=S;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Fonction HexWord                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet la transformation d'un valeur entiŠre de type mot
 en sa valeur hexad‚cimal en fonction du format de langage souhaiter.
}

Function HexWord(X:Word):String;Near;
Var
 S:String;
Begin
 S:=HexWord2Str(X);
 Case(OpCodeFormat)of
fAlgol68:S:='$'+S;
      fC:S:='0x'+S;
    Else IncStr(S,'h');
 End;
 HexWord:=S;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Fonction HalfWord                           Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet la transformation d'un valeur entiŠre de type octet
 sign‚e en sa valeur hexad‚cimal en fonction du format de langage souhaiter.
}

Function HalfWord(I:Byte):String;Near;
Var
 W:Word;
Begin
 If I<$80Then W:=0
         Else W:=$FF00;
 ASM
  MOV AL,I
  OR  Byte Ptr W,AL
 END;
 HalfWord:=HexWord(W)
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure ChgStr                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de changer des expressions dans une chaŒne de
 caractŠres par une nouvelle.
}

Procedure ChgStr(Var Source:String;InS:Chr;Const OutS:String);Near;
Var
 I:Byte;
 S:String;
Begin
 S:='';
 For I:=1to Length(Source)do Begin
  If InS=Source[I]Then AddStr(S,OutS)
                  Else IncStr(S,Source[I]);
 End;
 Source:=S;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Fonction Decode                           Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction  permet de d‚coder un code machine et de le transformer
 en format assembleur INTEL, Motorola,... et le retourne dans une chaŒne
 de caractŠre afin de permettre sa compr‚hension.
}

Function Decode;
Label
 ReStart,JMP1,Out1,Rep,_0,_1,_2,_5,_6,
 _7,_10,_11,_12,_15,_16,_17,_18,_19,_20,_22,
 _25,_27,_30,_33,_37,
 _38,_39,_40,_41,_42,_44,_INT,_50,
 _52,_53,_60,_61,_62,_63,
 _67,_68,_69,_71,99,_888,_999,Xit,AsmStr,DefaultAsmStr;
Var
 T:TByte Absolute Buf;
 CurrCode,X2,X3:Byte;
 S:String;
 XSeg,Prefix:Byte;
 X386,Wd:Boolean;
 PS,OldPS:^String;

 Procedure DB;Begin
  If Chr(CurrCode)in[' ','A'..'z']Then S:='DB '''+Chr(CurrCode)+''''
   Else
  Begin
   Case(OpCodeFormat)of
fAlgol68:S:='InLine('+HexByte(CurrCode)+')';
    Else Begin
     {If(OpCodeCPU=fINTEL)Then }S:='DB'{Else S:='BAD'};
     IncStr(S,' ');
     AddStr(S,HexByte(CurrCode));
    End;
   End;
  End;
 End;

 Function TWd(X:Word):Word;Begin
  TWd:=T[X]+T[X+1]*256;
 End;

 Function SegS:String;Begin
  Case(XSeg)of
   ciCS:SegS:='CS:';
   ciDS:SegS:='DS:';
   ciES:SegS:='ES:';
   ciFS:SegS:='FS:';
   ciGS:SegS:='GS:';
   ciSS:SegS:='SS:';
   Else SegS:='';
  End;
 End;

 Function JmpAddr:String;Begin
  If T[I+1]>$7FThen JmpAddr:=HexWord(I-($100-2-T[I+1]))
               Else JmpAddr:=HexWord(I+2+T[I+1]);
 End;

 Function OfsByte:String;Begin
  If T[I]>=$7FThen OfsByte:='-'+HexByte($100-T[I])
              Else OfsByte:='+'+HexByte(T[I]);
 End;

 Function OfsWord:String;Begin
  If T[I]>$7FFFThen OfsWord:='-'+HexWord($10000-TWd(I))
               Else OfsWord:='+'+HexWord(TWd(I));
 End;

 Function RegWord(I:Byte):String;Begin
  If(X386)Then RegWord:='E'+Sourcer.RegWord[I]
          Else RegWord:=Sourcer.RegWord[I];
 End;

 Function D:String;Begin
  If(X386)Then D:='D'
          Else D:=''
 End;

 Function LoadAddr:String;
 Const
  SAddr:Array[0..7]of PChar=(
   '[BX+SI]',
   '[BX+DI]',
   '[BP+SI]',
   '[BP+DI]',
   '[SI]',
   '[DI]',
   '[BP]',
   '[BX]'
  );
 Var
  S:String;
  X2:Byte;
 Begin
  S:=StrPas(PChr(SAddr[T[I+1]and$7]));
  Case(OpCodeFormat)of
fAlgol68: InsStr(S,2,SegS);
     Else S:=SegS+S;
  End;
  X2:=(T[I+1]shr 3)and 7;
  If(CurrCode>=$FE)and(X2 in[2..5])Then LoadAddr:=PrcS[X2 and 1]+S
   Else
  Begin
   Case(OpCodeFormat)of
fAlgol68:If CurrCode and 1=1Then Begin
     If(X386)Then S:='MemL'+S Else S:='MemW'+S
    End
     Else
    S:='Mem'+S;
    Else S:=PtrS[CurrCode and 1]+S;
   End;
   If Bool(CurrCode and 1)Then S:=D+S;
   LoadAddr:=S;
  End;
 End;

 Function WordAddr:String;Begin
  WordAddr:=SegS+'['+HexWord(TWd(I+1))+']'
 End;

 Function XtrkAddr:String;
 Var
  S:String;
 Begin
  S:=LoadAddr;
  Case T[I+1]of
   0..$3F:Inc(I);
   $40..$7F:Begin
    BackStr(S);
    Inc(I,2);
    AddStr(S,OfsByte);
    IncStr(S,']');
   End;
   Else Begin { 80h … BFh }
    BackStr(S);
    Inc(I,2);
    AddStr(S,OfsWord);
    Inc(I);
    IncStr(S,']');
   End;
  End;
  XtrkAddr:=S;
 End;

 Var First:Boolean;

 Function Register:String;
 Label 1;
 Var
  T2:Byte;
 Begin
  T2:=T[I+1];
  If CurrCode=$8EThen Begin
   If(First)Then Begin
    Register:=RegS[(T2 and$3F)shr 3];
    First:=False;
    Exit;
   End;
   Goto 1;
  End
   Else
  If CurrCode=$8CThen Begin
   If Not(First)Then Begin
    Register:=RegS[(T2 and$3F)shr 3];
    First:=True;
    Exit;
   End;
 1:Register:=RegWord(T2 and 7)
  End
   Else
  Begin
   If CurrCode in[$E4..$E7]Then T2:=0;
   Case(T2)of
    $40..$7F:T2:=(T2 and$3F)shr 3;
    $C0..$FF:Begin
     If(First=True)Then T2:=T2 and 7
                   Else T2:=(T2 and$3F)shr 3;
     First:=False;
    End;
    Else T2:=(T2 shr 3)and 7;
   End;
   If CurrCode and 1=1Then Register:=RegWord(T2)
                      Else Register:=RegByte[T2];
  End;
 End;

 Function XtrkStandard:String;
 Label Swp;
 Var
  R,S:String;
  Wd:Boolean;
  Reg:Byte;
 Begin
  Wd:=Boolean(CurrCode and 1);
  Case T[I+1]of
   $06:Reg:=0;
   $0E:Reg:=1;
   $16:Reg:=2;
   $1E:Reg:=3;
   $26:Reg:=4;
   $2E:Reg:=5;
   $36:Reg:=6;
   $3E:Reg:=7;
   $40..$7F:Begin
    S:=XtrkAddr;
    Dec(I,2);
    R:=Register;
    Inc(I);
    Goto Swp;
   End;
   $C0..$FF:Begin
    XtrkStandard:=Register+','+Register;
    Exit;
   End;
   Else Begin
    R:=Register;
    S:=LoadAddr;
    Goto Swp;
   End;
  End;
  If T[I+1]in[$06,$0E,$16,$1E,$26,$2E,$36,$3E]Then Begin
   If CurrCode in[$8C,$8E]Then Begin
    R:=RegS[Reg and 3];
    Wd:=True;
   End
    Else
   If(Wd)Then R:=RegWord(Reg)
         Else R:=RegByte[Reg];
   Inc(I,2);
   Case(OpCodeFormat)of
fAlgol68:Begin
     If(Wd)Then S:='MemW'
           Else S:='Mem';
     AddStr(S,'['+SegS)
    End;
    Else S:=PtrS[Byte(Wd)]+SegS+'[';
   End;
   AddStr(S,HexWord(TWd(I))+']');
Swp:If CurrCode and 2=0Then XtrkStandard:=S+','+R
                       Else XtrkStandard:=R+','+S;
  End;
 End;

 Function _286A:String;Begin
  If T[I]and 1=1Then _286A:=RegWord(0)+','+HexWord(TWd(I+1))
                Else _286A:='AL,'+HexByte(T[I+1])
 End;

 Procedure UpDateBasHome(CurrCode:Byte);Begin
  If(OpCodeFormat<>fAlgol68)Then Begin
   If CurrCode>=$88Then S:='MOV'
                   Else S:=BasS[CurrCode];
   IncStr(S,' ');
  End
   Else
  S:='';
 End;

 Procedure UpDateBasEnd(CC:Byte);
 Label
  SetJmp;
 Begin
  If(OpCodeFormat=fAlgol68)Then Begin
   If CC>=$88Then ChgStr(S,',',':=')
    Else
   Case(CC)of
    0:ChgStr(S,',','+:=');
    1:ChgStr(S,',','|:=');
    2:ChgStr(S,',','+:=CF+');
    3:ChgStr(S,',','-:=CF+');
    4:ChgStr(S,',','&:=');
    5:ChgStr(S,',','-:=');
    6:ChgStr(S,',','^:=');
    7:Begin
     S:='If('+S+')Then ';
     SourcerDataBase^.CurrRec.Byte:=@SourcerDataBase^.Table^[SourcerDataBase^.Index^[CurrCode]];
     Case T[I+SourcerDataBase^.CurrRec.Byte^]of
      $72,$7C:Begin { JB ? }
       ChgChr(S,',','<');
       Goto SetJmp;
      End;
      $73,$7D:Begin { JAE ? }
       ChgStr(S,',','>=');
       Goto SetJmp;
      End;
      $74:Begin { JZ ? }
       ChgChr(S,',','=');
       Goto SetJmp;
      End;
      $75:Begin { JNZ ? }
       ChgStr(S,',','<>');
       Goto SetJmp;
      End;
      $76,$7F:Begin { JBE ? }
       ChgStr(S,',','<=');
       Goto SetJmp;
      End;
      $77,$7E:Begin { JA ? }
       ChgChr(S,',','>');
SetJmp:Inc(I,SourcerDataBase^.CurrRec.Byte^);
       CurrCode:=T[I];
       AddStr(S,'Goto '+JmpAddr);
      End;
      Else Begin
       ChgChr(S,',','=');
       AddStr(S,'.?.');
      End;
     End;
    End;
   End;
  End;
 End;

 Procedure PushData(Const D:String);Begin
  Case(OpCodeFormat)of
fAlgol68:S:='MemW[SS:SP]:='+D+',SP-:=2';
      fC:S:='poke(_SS,_SP,'+D+');_SP-=2';
    Else S:='PUSH '+D;
  End;
 End;

 Procedure PopData(Const D:String);Begin
  Case(OpCodeFormat)of
  fAlgol68:S:=D+':=MemW[SS:SP],SP+:=2';
        fC:S:=D+'=peek(_SS,_SP),_SP+=2';
      Else S:='POP '+D;
  End;
 End;

Begin
 First:=True;Prefix:=0;XSeg:=0;X386:=False;
 If(SourcerTable<>OpCodeCPU)Then Begin
  If(SourcerDataBase<>NIL)Then DBDispose(SourcerDataBase^)
                          Else SourcerDataBase:=MemAlloc(SizeOf(DataSetInMemory));
  If(SourcerDataBase<>NIL)Then Begin
   Case(OpCodeCPU)of
    f6502:DBOpenServerName(ChantalServer,'CHANTAL:/CPU/Motorola/Inline6502.Dat');
    f8080:DBOpenServerName(ChantalServer,'CHANTAL:/CPU/Intel/Inline8080.Dat');
    Else DBOpenServerName(ChantalServer,'CHANTAL:/CPU/Intel/Inline8086.Dat');
   End;
   DBCopyToMemory(ChantalServer,SourcerDataBase^);
  End;
 End;
ReStart:
 CurrCode:=T[I];
 Case(OpCodeCPU)of
  fINTEL:Begin
   PS:=@SourcerDataBase^.Table^[SourcerDataBase^.Index^[CurrCode]];
   OldPS:=PS;
   Case(OpCodeFormat)of
    fC:Begin
     _DBGotoColumnAbs(SourcerDataBase^.FieldRec,3,Pointer(PS));
     If PS^=''Then Begin
      PS:=OldPS;
      Goto AsmStr;
     End;
    End;
    fAlgol68:Begin
     _DBGotoColumnAbs(SourcerDataBase^.FieldRec,2,Pointer(PS));
     If PS^=''Then Begin
      PS:=OldPS;
      Goto AsmStr;
     End;
    End;
    Else AsmStr:Begin
     If(X386)Then Begin
      _DBGotoColumnAbs(SourcerDataBase^.FieldRec,4,Pointer(PS));
      If PS^=''Then Goto DefaultAsmStr;
     End
      Else
DefaultAsmStr:_DBGotoColumnAbs(SourcerDataBase^.FieldRec,1,Pointer(PS));
    End;
   End;
   S:=PS^;
   {$IFDEF FLAT386}
    Case(CurrCode)of
    $00:Goto _0;
    $01:Goto _0;
    $02:Goto _0;
    $03:Goto _0;
    $04:Goto _0;
    $05:Goto _0;
    $06:Goto _1;
    $07:Goto _1;
    $08:Goto _0;
    $09:Goto _0;
    $0A:Goto _0;
    $0B:Goto _0;
    $0C:Goto _0;
    $0D:Goto _0;
    $0E:Goto _1;
    $0F:Goto _2;
    $10:Goto _0;
    $11:Goto _0;
    $12:Goto _0;
    $13:Goto _0;
    $14:Goto _0;
    $15:Goto _0;
    $16:Goto _1;
    $17:Goto _2;
    $18:Goto _0;
    $19:Goto _0;
    $1A:Goto _0;
    $1B:Goto _0;
    $1C:Goto _0;
    $1D:Goto _0;
    $1E:Goto _1;
    $1F:Goto _1;
    $20:Goto _0;
    $21:Goto _0;
    $22:Goto _0;
    $23:Goto _0;
    $24:Goto _0;
    $25:Goto _0;
    $26:Goto _999;
    $27:Goto Xit;
    $28:Goto _0;
    $29:Goto _0;
    $2A:Goto _0;
    $2B:Goto _0;
    $2C:Goto _0;
    $2D:Goto _0;
    $2E:Goto _999;
    $2F:Goto Xit;
    $30:Goto _0;
    $31:Goto _0;
    $32:Goto _0;
    $33:Goto _0;
    $34:Goto _0;
    $35:Goto _0;
    $36:Goto _999;
    $37:Goto Xit;
    $38:Goto _0;
    $39:Goto _0;
    $3A:Goto _0;
    $3B:Goto _0;
    $3C:Goto _0;
    $3D:Goto _0;
    $3E:Goto _999;
    $3F:Goto Xit;
    $40:Goto _5;
    $41:Goto _5;
    $42:Goto _5;
    $43:Goto _5;
    $44:Goto _5;
    $45:Goto _5;
    $46:Goto _5;
    $47:Goto _5;
    $48:Goto _5;
    $49:Goto _5;
    $4A:Goto _5;
    $4B:Goto _5;
    $4C:Goto _5;
    $4D:Goto _5;
    $4E:Goto _5;
    $4F:Goto _5;
    $50:Goto _6;
    $51:Goto _6;
    $52:Goto _6;
    $53:Goto _6;
    $54:Goto _6;
    $55:Goto _6;
    $56:Goto _6;
    $57:Goto _6;
    $58:Goto _7;
    $59:Goto _7;
    $5A:Goto _7;
    $5B:Goto _7;
    $5C:Goto _7;
    $5D:Goto _7;
    $5E:Goto _7;
    $5F:Goto _7;
    $60:Goto Xit;
    $61:Goto Xit;
    $62:Goto _888;
    $63:Goto _888;
    $64:Goto _999;
    $65:Goto _999;
    $66:Goto _10;
    $67:Goto _888;
    $68:Goto _11;
    $69:Goto _888;
    $6A:Goto _12;
    $6B:Goto _888;
    $6C:Goto Xit;
    $6D:Goto Xit;
    $6E:Goto Xit;
    $6F:Goto Xit;
    $70:Goto _15;
    $71:Goto _15;
    $72:Goto _15;
    $73:Goto _15;
    $74:Goto _15;
    $75:Goto _15;
    $76:Goto _15;
    $77:Goto _15;
    $78:Goto _15;
    $79:Goto _15;
    $7A:Goto _15;
    $7B:Goto _15;
    $7C:Goto _15;
    $7D:Goto _15;
    $7E:Goto _15;
    $7F:Goto _15;
    $80:Goto _16;
    $81:Goto _16;
    $82:Goto _16;
    $83:Goto _16;
    $84:Goto _17;
    $85:Goto _17;
    $86:Goto _18;
    $87:Goto _18;
    $88:Goto _0;
    $89:Goto _0;
    $8A:Goto _0;
    $8B:Goto _0;
    $8C:Goto _19;
    $8D:Goto _20;
    $8E:Goto _19;
    $8F:Goto _888;
    $90:Goto Xit;
    $91:Goto _22;
    $92:Goto _22;
    $93:Goto _22;
    $94:Goto _22;
    $95:Goto _22;
    $96:Goto _22;
    $97:Goto _22;
    $98:Goto Xit;
    $99:Goto Xit;
    $9A:Goto _25;
    $9B:Goto Xit;
    $9C:Goto Xit;
    $9D:Goto Xit;
    $9E:Goto Xit;
    $9F:Goto Xit;
    $A0:Goto _30;
    $A1:Goto _30;
    $A2:Goto _30;
    $A3:Goto _30;
    $A4:Goto Xit;
    $A5:Goto Xit;
    $A6:Goto Xit;
    $A7:Goto Xit;
    $A8:Goto _33;
    $A9:Goto _33;
    $AA:Goto Xit;
    $AB:Goto Xit;
    $AC:Goto Xit;
    $AD:Goto Xit;
    $AE:Goto Xit;
    $AF:Goto Xit;
    $B0:Goto _37;
    $B1:Goto _37;
    $B2:Goto _37;
    $B3:Goto _37;
    $B4:Goto _37;
    $B5:Goto _37;
    $B6:Goto _37;
    $B7:Goto _37;
    $B8:Goto _37;
    $B9:Goto _37;
    $BA:Goto _37;
    $BB:Goto _37;
    $BC:Goto _37;
    $BD:Goto _37;
    $BE:Goto _37;
    $BF:Goto _37;
    $C0:Goto _38;
    $C1:Goto _38;
    $C2:Goto _39;
    $C3:Goto Xit;
    $C4:Goto _40;
    $C5:Goto _40;
    $C6:Goto _41;
    $C7:Goto _41;
    $C8:Goto _42;
    $C9:Goto Xit;
    $CA:Goto _44;
    $CB:Goto Xit;
    $CC:Goto Xit;
    $CD:Goto _INT;
    $CE:Goto Xit;
    $CF:Goto Xit;
    $D0:Goto _50;
    $D1:Goto _50;
    $D2:Goto _50;
    $D3:Goto _50;
    $D4:Goto Xit;
    $D5:Goto Xit;
    $D6:Goto Xit;
    $D7:Goto Xit;
    $D8:Goto _888;
    $D9:Goto _52;
    $DA:Goto _888;
    $DB:Goto _53;
    $DC:Goto _888;
    $DD:Goto _888;
    $DE:Goto _888;
    $DF:Goto _888;
    $E0:Goto Jmp1;
    $E1:Goto Jmp1;
    $E2:Goto Jmp1;
    $E3:Goto Jmp1;
    $E4:Goto Out1;
    $E5:Goto Out1;
    $E6:Goto Out1;
    $E7:Goto Out1;
    $E8:Goto _60;
    $E9:Goto _61;
    $EA:Goto _62;
    $EB:Goto _63;
    $EC:Goto Xit;
    $ED:Goto Xit;
    $EE:Goto Xit;
    $EF:Goto _67;
    $F0:Goto _68;
    $F1:Goto _888;
    $F2:Goto _68;
    $F3:Goto _68;
    $F4:Goto Xit;
    $F5:Goto Xit;
    $F6:Goto _69;
    $F7:Goto _69;
    $F8:Goto Xit;
    $F9:Goto Xit;
    $FA:Goto Xit;
    $FB:Goto Xit;
    $FC:Goto Xit;
    $FD:Goto Xit;
    $FE:Goto _71;
    $FF:Goto _71;
    End;
   {$ELSE}
    ASM
     JMP @Next
 @Label:
     DW Offset _0 { 0 }
     DW Offset _0 { 1 }
     DW Offset _0 { 2 }
     DW Offset _0 { 3 }
     DW Offset _0 { 4 }
     DW Offset _0 { 5 }
     DW Offset _1 { 6 }
     DW Offset _1 { 7 }
     DW Offset _0 { 8 }
     DW Offset _0 { 9 }
     DW Offset _0 { A }
     DW Offset _0 { B }
     DW Offset _0 { C }
     DW Offset _0 { D }
     DW Offset _1 { E }
     DW Offset _2 { F }
     DW Offset _0 { 10 }
     DW Offset _0 { 11 }
     DW Offset _0 { 12 }
     DW Offset _0 { 13 }
     DW Offset _0 { 14 }
     DW Offset _0 { 15 }
     DW Offset _1 { 16 }
     DW Offset _2 { 17 }
     DW Offset _0 { 18 }
     DW Offset _0 { 19 }
     DW Offset _0 { 1A }
     DW Offset _0 { 1B }
     DW Offset _0 { 1C }
     DW Offset _0 { 1D }
     DW Offset _1 { 1E }
     DW Offset _1 { 1F }
     DW Offset _0 { 20 }
     DW Offset _0 { 21 }
     DW Offset _0 { 22 }
     DW Offset _0 { 23 }
     DW Offset _0 { 24 }
     DW Offset _0 { 25 }
     DW Offset _999{26 }
     DW Offset Xit {27 }
     DW Offset _0  {28 }
     DW Offset _0  {29 }
     DW Offset _0  {2A }
     DW Offset _0  {2B }
     DW Offset _0  {2C }
     DW Offset _0  {2D }
     DW Offset _999{2E }
     DW Offset Xit {2F }
     DW Offset _0  {30 }
     DW Offset _0  {31 }
     DW Offset _0  {32 }
     DW Offset _0  {33 }
     DW Offset _0  {34 }
     DW Offset _0  {35 }
     DW Offset _999{36 }
     DW Offset Xit { 37 }
     DW Offset _0 { 38 }
     DW Offset _0 { 39 }
     DW Offset _0 { 3A }
     DW Offset _0 { 3B }
     DW Offset _0 { 3C }
     DW Offset _0 { 3D }
     DW Offset _999{3E }
     DW Offset Xit { 3F }
     DW Offset _5 { 40 }
     DW Offset _5 { 41 }
     DW Offset _5 { 42 }
     DW Offset _5 { 43 }
     DW Offset _5 { 44 }
     DW Offset _5 { 45 }
     DW Offset _5 { 46 }
     DW Offset _5 { 47 }
     DW Offset _5 { 48 }
     DW Offset _5 { 49 }
     DW Offset _5 { 4A }
     DW Offset _5 { 4B }
     DW Offset _5 { 4C }
     DW Offset _5 { 4D }
     DW Offset _5 { 4E }
     DW Offset _5 { 4F }
     DW Offset _6 { 50 }
     DW Offset _6 { 51 }
     DW Offset _6 { 52 }
     DW Offset _6 { 53 }
     DW Offset _6 { 54 }
     DW Offset _6 { 55 }
     DW Offset _6 { 56 }
     DW Offset _6 { 57 }
     DW Offset _7 { 58 }
     DW Offset _7 { 59 }
     DW Offset _7 { 5A }
     DW Offset _7 { 5B }
     DW Offset _7 { 5C }
     DW Offset _7 { 5D }
     DW Offset _7 { 5E }
     DW Offset _7 { 5F }
     DW Offset Xit {60 }
     DW Offset Xit {61 }
     DW Offset _888{62 }
     DW Offset _888{63 }
     DW Offset _999{64 }
     DW Offset _999{65 }
     DW Offset _10 {66 }
     DW Offset _888{67 }
     DW Offset _11 {68 }
     DW Offset _888{69 }
     DW Offset _12 {6A }
     DW Offset _888{6B }
     DW Offset Xit {6C }
     DW Offset Xit {6D }
     DW Offset Xit {6E }
     DW Offset Xit {6F }
     DW Offset _15 {70 }
     DW Offset _15 {71 }
     DW Offset _15 {72 }
     DW Offset _15 {73 }
     DW Offset _15 {74 }
     DW Offset _15 {75 }
     DW Offset _15 {76 }
     DW Offset _15 {77 }
     DW Offset _15 {78 }
     DW Offset _15 {79 }
     DW Offset _15 {7A }
     DW Offset _15 {7B }
     DW Offset _15 {7C }
     DW Offset _15 {7D }
     DW Offset _15 {7E }
     DW Offset _15 {7F }
     DW Offset _16 {80 }
     DW Offset _16 {81 }
     DW Offset _16 {82 }
     DW Offset _16 {83 }
     DW Offset _17 {84 }
     DW Offset _17 {85 }
     DW Offset _18 {86 }
     DW Offset _18 {87 }
     DW Offset _0  {88 }
     DW Offset _0  {89 }
     DW Offset _0  {8A }
     DW Offset _0  {8B }
     DW Offset _19 {8C }
     DW Offset _20 {8D }
     DW Offset _19 {8E }
     DW Offset _888{8F }
     DW Offset Xit {90 }
     DW Offset _22 {91 }
     DW Offset _22 {92 }
     DW Offset _22 {93 }
     DW Offset _22 {94 }
     DW Offset _22 {95 }
     DW Offset _22 {96 }
     DW Offset _22 {97 }
     DW Offset Xit {98 }
     DW Offset Xit {99 }
     DW Offset _25 {9A }
     DW Offset Xit {9B }
     DW Offset Xit {9C }
     DW Offset Xit {9D }
     DW Offset Xit {9E }
     DW Offset Xit {9F }
     DW Offset _30 {A0 }
     DW Offset _30 {A1 }
     DW Offset _30 {A2 }
     DW Offset _30 {A3 }
     DW Offset Xit {A4 }
     DW Offset Xit {A5 }
     DW Offset Xit {A6 }
     DW Offset Xit {A7 }
     DW Offset _33 {A8 }
     DW Offset _33 {A9 }
     DW Offset Xit {AA }
     DW Offset Xit {AB }
     DW Offset Xit {AC }
     DW Offset Xit {AD }
     DW Offset Xit {AE }
     DW Offset Xit {AF }
     DW Offset _37 {B0 }
     DW Offset _37 {B1 }
     DW Offset _37 {B2 }
     DW Offset _37 {B3 }
     DW Offset _37 {B4 }
     DW Offset _37 {B5 }
     DW Offset _37 {B6 }
     DW Offset _37 {B7 }
     DW Offset _37 {B8 }
     DW Offset _37 {B9 }
     DW Offset _37 {BA }
     DW Offset _37 {BB }
     DW Offset _37 {BC }
     DW Offset _37 {BD }
     DW Offset _37 {BE }
     DW Offset _37 {BF }
     DW Offset _38 {C0 }
     DW Offset _38 {C1 }
     DW Offset _39 {C2 }
     DW Offset Xit {C3 }
     DW Offset _40 {C4 }
     DW Offset _40 {C5 }
     DW Offset _41 {C6 }
     DW Offset _41 {C7 }
     DW Offset _42 {C8 }
     DW Offset Xit {C9 }
     DW Offset _44 {CA }
     DW Offset Xit {CB }
     DW Offset Xit {CC }
     DW Offset _INT {CD }
     DW Offset Xit {CE }
     DW Offset Xit {CF }
     DW Offset _50 {D0 }
     DW Offset _50 {D1 }
     DW Offset _50 {D2 }
     DW Offset _50 {D3 }
     DW Offset Xit {D4 }
     DW Offset Xit {D5 }
     DW Offset Xit {D6 }
     DW Offset Xit {D7 }
     DW Offset _888{D8 }
     DW Offset _52 {D9 }
     DW Offset _888{DA }
     DW Offset _53 {DB }
     DW Offset _888{DC }
     DW Offset _888{DD }
     DW Offset _888{DE }
     DW Offset _888{DF }
     DW Offset Jmp1{E0 }
     DW Offset Jmp1{E1 }
     DW Offset Jmp1{E2 }
     DW Offset Jmp1{E3 }
     DW Offset Out1{E4 }
     DW Offset Out1{E5 }
     DW Offset Out1{E6 }
     DW Offset Out1{E7 }
     DW Offset _60 {E8 }
     DW Offset _61 {E9 }
     DW Offset _62 {EA }
     DW Offset _63 {EB }
     DW Offset Xit {EC }
     DW Offset Xit {ED }
     DW Offset Xit {EE }
     DW Offset _67 {EF }
     DW Offset _68 {F0 }
     DW Offset _888{F1 }
     DW Offset _68 {F2 }
     DW Offset _68 {F3 }
     DW Offset Xit {F4 }
     DW Offset Xit {F5 }
     DW Offset _69 {F6 }
     DW Offset _69 {F7 }
     DW Offset Xit {F8 }
     DW Offset Xit {F9 }
     DW Offset Xit {FA }
     DW Offset Xit {FB }
     DW Offset Xit {FC }
     DW Offset Xit {FD }
     DW Offset _71 {FE }
     DW Offset _71 {FF }
 @Next:
     MOV BL,CurrCode
     XOR BH,BH
     SHL BX,1
     JMP @Label.Word[BX]
    END;
   {$ENDIF}
_999:XSeg:=CurrCode;Inc(I);
    Goto ReStart;
_0:If CurrCode>=$88Then UpDateBasHome(CurrCode)
                   Else UpDateBasHome(CurrCode shr 3);
   If CurrCode and 7>3Then AddStr(S,_286A)
                      Else AddStr(S,XtrkStandard);
   If CurrCode>=$88Then UpDateBasEnd(CurrCode)
                   Else UpDateBasEnd(CurrCode shr 3);
   Goto Xit;
_1:S:=RegS[CurrCode shr 3];
   Case CurrCode and$7of
    6:PushData(S);
    7:PopData(S);
   End;
   Goto Xit;
    { Code 0Fh xx }
_2:_DBGotoColumnAbs(SourcerDataBase^.FieldRec,5,Pointer(PS));
   If PS^=''Then DB
            Else S:=PS^;
_5:S:=RegWord(CurrCode and 7);
   If CurrCode and 8=8Then Case(OpCodeFormat)of
    fAlgol68,fC:AddStr(S,'--');
    Else S:='DEC '+S;
   End
    Else
   Case(OpCodeFormat)of
    fAlgol68,fC:AddStr(S,'++');
    Else S:='INC '+S;
   End;
   If(OpCodeFormat=fC)Then S:='_'+S;
   Goto Xit;
_6:PushData(RegWord(CurrCode and 7));
   Goto XIt;
_7:PopData(RegWord(CurrCode and 7));
   Goto Xit;
_10:X386:=True;Inc(I);
    Goto Restart;
_11:PushData(HexWord(TWd(I+1)));
    Goto Xit;
_12:PushData(HexWord(T[I+1]));
    Goto Xit;
_15:S:=FlgS[CurrCode and$F];
    Case(OpCodeFormat)of
     fAlgol68:S:='If('+RTrim(S)+'F)Then Goto';
     fC:S:='if('+RTrim(S)+'F) goto';
     Else S:='J'+S;
    End;
    Goto Jmp1;
_16:X2:=T[I+1];
    UpDateBasHome((X2 and$3F)shr 3);
    Wd:=Boolean(CurrCode and 1);
    Case(X2)of
     $C0..$FF:Begin
      AddStr(S,Register);
      IncStr(S,',');
      If CurrCode and 2=2Then Begin
       Inc(I,2);
       AddStr(S,HalfWord(T[I]))
      End
       Else
      Begin
       If(Wd)Then Begin
        Inc(I,2);
        AddStr(S,HexWord(TWd(I)))
       End
        Else
       AddStr(S,HexByte(T[I+2]));
       Inc(I)
      End
     End;
     Else Begin
      AddStr(S,XtrkAddr);
      IncStr(S,',');
      Inc(I);
      If CurrCode and 2=2Then AddStr(S,HalfWord(T[I]))Else
      If(Wd)Then Begin
       AddStr(S,HexWord(TWd(I)));
       Inc(I)
      End
       Else
      AddStr(S,HexByte(T[I]));
     End;
    End;
    UpDateBasEnd((X2 and$3F)shr 3);
    Goto Xit;
_17:S:='TEST '+XtrkStandard;
    Goto Xit;
_18:S:='XCHG '+XtrkStandard;
    Goto Xit;
_19:UpDateBasHome(CurrCode);
    AddStr(S,XtrkStandard);
    UpDateBasEnd(CurrCode);
    Goto Xit;
_20:Case T[I+1]of
     $40..$BF:S:='LEA '+RegWord(T[I+1]and 7)+','+XtrkAddr;
     Else S:='DW '+HexWord(TWd(I));
    End;
    Goto Xit;
_22:S:='XCHG '+RegWord(0)+','+RegWord(CurrCode and$7);
    Goto Xit;
_25:S:='CALL '+HexWord(TWd(I+3))+':'+HexWord(TWd(I+1));
    Goto Xit;
_30:UpDateBasHome(CurrCode);
    If CurrCode and 2=2Then Begin
     AddStr(S,WordAddr);
     IncStr(S,',');
     If Boolean(CurrCode and 1)Then AddStr(S,RegWord(0))
                               Else AddStr(S,RegByte[0]);
    End
     Else
    Begin
     If Boolean(CurrCode and 1)Then AddStr(S,RegWord(0))
                               Else AddStr(S,RegByte[0]);
     IncStr(S,',');
     AddStr(S,WordAddr);
    End;
    UpDateBasEnd(CurrCode);
    Goto Xit;
_33:S:='TEST '+_286A;
    Goto Xit;
_37:UpDateBasHome(CurrCode);
    If CurrCode and$8=8Then AddStr(S,RegWord(CurrCode and 7)+','+HexWord(TWd(I+1)))
                       Else AddStr(S,RegByte[CurrCode and 7]+','+HexByte(T[I+1]));
    UpDateBasEnd(CurrCode);
    Goto Xit;
_38:X2:=T[I+1];
    S:=RotS[(X2 and$3F)shr 3];
    IncStr(S,' ');
    AddStr(S,Register+',');
    Case(X2)of
     $C0..$FF:Begin
      Inc(I,2);
      AddStr(S,HexByte(T[I]))
     End;
     Else AddStr(S,XtrkAddr);
    End;
    Goto Xit;
_40:If Boolean(CurrCode and 1)Then S:='LDS '
                              Else S:='LES ';
    Case T[I+1]of
     $76:Begin
      Inc(I,2);
      AddStr(S,'SI,'+SegS+'[BP'+OfsByte+']');
      Dec(I);
     End;
     $7E:Begin
      Inc(I,2);
      AddStr(S,'DI,'+SegS+'[BP'+OfsByte+']');
      Dec(I);
     End;
     $B4:If T[I+2]=$B4Then Begin
      Inc(I,3);
      AddStr(S,'DI,'+SegS+'[SI'+OfsWord+']');
     End;
     $BE:Begin
      Inc(I,2);
      AddStr(S,SegS+'[BP'+OfsWord+']')
     End;
     Else AddStr(S,RegWord((T[I+1]shr 3)and 7)+','+LoadAddr);
    End;
    Goto Xit;
_41:UpDateBasHome(CurrCode);
    Case T[I+1]of
     $C0..$FF:Begin
      AddStr(S,Register);
      Inc(I)
     End;
     Else AddStr(S,XtrkAddr);
    End;
    Inc(I);
    IncStr(S,',');
    If Boolean(CurrCode and 1)Then Begin
     AddStr(S,HexWord(TWd(I)));
     Inc(I)
    End
     Else
    AddStr(S,HexByte(T[I]));
    UpDateBasEnd(CurrCode);
    Goto Xit;
_42:AddStr(S,HexWord(TWd(I+1))+','+HexByte(T[I+3]));
    Goto Xit;
_39:
_44:AddStr(S,HexWord(TWd(I+1)));
    Goto Xit;
_INT:AddStr(S,HexByte(T[I+1]));
    If(OpCodeFormat<>fAsm)Then IncStr(S,')');
    Goto Xit;
_50:Case T[I+1]of
     $C0..$FF:Begin
      S:=RotS[(T[I+1]and$3F)shr 3];
      IncStr(S,' ');
      AddStr(S,Register+',');
      Inc(I);
      If T[I]and 2=2Then AddStr(S,RegByte[1])
                    Else IncStr(S,'1');
     End;
     Else DB;
    End;
    Goto Xit;
_52:Case T[I+1]of
     $D0:S:='FNOP';
     $E0:S:='FCHS';
     $E1:S:='FABS';
     $E2:S:='FCLEX';
     $E4:S:='FTST';
     $E5:S:='FXAM';
     $E8:S:='FLD1';
     $E9:S:='FLDL2T';
     $EA:S:='FLDL2E';
     $EB:S:='FLDPI';
     $EC:S:='FLDLG2';
     $ED:S:='FLDLN2';
     $EE:S:='FLDZ';
     $F1:S:='FYL2X';
     $F2:S:='FPTAN';
     $F3:S:='FPATAN';
     $F4:S:='FXTRACT';
     $F6:S:='FDECSTP';
     $F7:S:='FINCSTP';
     $F8:S:='FPREM';
     $FA:S:='FSQRT';
     $FB:S:='FSINCOS';
     $FC:S:='FRNDINT';
     $FD:S:='FSCALE';
     $FE:S:='FSIN';
     Else DB;
    End;
    Goto Xit;
_53:Case T[I+1]of
     $E0:S:='FENI';
     $E1:S:='FDISI';
     $E3:S:='FINIT';
     $E4:S:='FSETPM';
     Else DB;
    End;
    Goto Xit;
Out1:IncStr(S,' ');
    AddStr(S,Register+','+HexByte(T[I+1]));
    Goto Xit;
_61:IncStr(S,' ');
_60:AddStr(S,HexWord(TWd(I+1)+3+I));
    Goto Xit;
_62:AddStr(S,' '+HexWord(TWd(I+3))+':'+HexWord(TWd(I+1)));
    Goto Xit;
_63:
Jmp1:IncStr(S,' ');
    AddStr(S,JmpAddr);
    Goto Xit;
_67:AddStr(S,RegWord(0));
    Goto Xit;
_68:Prefix:=CurrCode;
    Inc(I);
    Goto Restart;
_69:If T[I+1]in[$10..$3F,$50..$7F,$D0..$FF]Then Begin
     S:=SmpS[(T[I+1]and$3F)shr 3];
     IncStr(S,' ');
    End;
    Case T[I+1]of
     $00..$07,$40..$47:Begin
      S:='TEST ';
      If T[I+1]=6Then Begin
       Inc(I,2);
       AddStr(S,SegS+'['+HexWord(TWd(I))+']');
       Inc(I,2)
      End
       Else
      Begin
       AddStr(S,XtrkAddr);
       Inc(I)
      End;
      IncStr(S,',');
      If CurrCode and 1=1Then Begin
       AddStr(S,HexWord(TWd(I)));
       Inc(I)
      End
       Else
      AddStr(S,HexByte(T[I]));
     End;
     $10..$3F,$50..$7F:AddStr(S,XtrkAddr);
     $D0..$FF:Begin
      AddStr(S,Register);
      Inc(I)
     End;
     Else DB;
    End;
    Goto Xit;
_71:X2:=(T[I+1]shr 3)and 7;
    Wd:=Boolean(CurrCode and 1);
    X3:=0;
    Repeat
     DB;
     Case(X2)of
      0:If(OpCodeFormat<>fAsm)Then Begin
       S:='';X3:=1;
      End
       Else
      S:='INC ';
      1:If(OpCodeFormat<>fAsm)Then Begin
       S:='';X3:=2;
      End
       Else
      S:='DEC ';
      2,3:If(Wd)Then S:='CALL '
                Else Break;
      4,5:If(Wd)Then S:='JMP '
                Else Break;
      7:S:='PUSH ';
      Else Break;
     End;
     Case T[I+1]of
      $06,$16,$26,$36:Begin
       If T[I+1]in[$06,$36]Then AddStr(S,PtrS[1])
                           Else AddStr(S,PrcS[0]);
       Goto 99;
      End;
      $0E,$1E,$2E,$3E:Begin
       If T[I+1]in[$06,$36]Then AddStr(S,PtrS[1])
                           Else AddStr(S,PrcS[1]);
    99:Inc(I,2);
       AddStr(S,SegS+'['+HexWord(TWd(I))+']');
      End;
      $C0..$FF:Begin
       AddStr(S,Register);
       Inc(I)
      End;
      Else AddStr(S,XtrkAddr);
     End;
     Case(X3)of
      1:AddStr(S,'++');
      2:AddStr(S,'--');
     End;
    Until True;
    Goto Xit;
_888:DB;
Xit:Repeat
    Case(Prefix)of
       $F0:S:='LOCK '+S;
       $F2:S:='REPNZ '+S;
{F3h}ciREP:S:='REP '+S;
(*REP MOVSB:Case(OpCodeFormat)of
   fAlgol68: S:='Move(Mem[DS:SI],Mem[ES:DI],CX);SI+:=CX,DI+:=CX';
             S:='Repeat Mem[ES:DI]:=Mem[DS:SI],SI++,DI++Until CX=0;'
         fC: S:='do {pokeb(_ES,_DI,peek(_DS,_SI));} while(_CX==0)';
        Else AddStr(S,'MOVSB');
            End;*)
      Else Break;
    End;
    IncStr(S,' ');
    AddStr(S,SegS);
   Until True;
   SourcerDataBase^.CurrRec.Byte:=@SourcerDataBase^.Table^[SourcerDataBase^.Index^[CurrCode]];
   Inc(I,SourcerDataBase^.CurrRec.Byte^);
  End;
  f8080:Begin
   PS:=@SourcerDataBase^.Table^[SourcerDataBase^.Index^[CurrCode]];
   Prefix:=Byte(PS^[0]);
   Inc(PtrRec(PS).Ofs);
   S:=PS^;
   If S=''Then Case(CurrCode)of
    $40..$75,$77..$7F:S:='MOV '+Reg8080[(CurrCode-$40)shr 3]+','+Reg8080[CurrCode and 7];
    $88..$8F:S:='ADC ';
    $80..$87:S:='ADD ';
    $90..$97:S:='SUB ';
    $98..$9F:S:='SBB ';
    $A0..$A7:S:='ANA ';
    $A8..$AF:S:='XRA ';
    $B0..$B7:S:='ORA ';
    $B8..$BF:S:='CMP ';
    Else DB;
   End;
   If Prefix=1Then AddStr(S,Reg8080[CurrCode and 7]);
   Inc(I);
  End;
  f6502:Begin
   PS:=@SourcerDataBase^.Table^[SourcerDataBase^.Index^[CurrCode]];
   Prefix:=Byte(PS^[0]);
   Inc(PtrRec(PS).Ofs);
   S:=PS^;
   If S=''Then DB;
   If Prefix<>0Then Begin
    IncStr(S,' ');
    Case(Prefix)of
     1:Begin { DP }
      Inc(I);
      AddStr(S,HexByte(T[I]));
     End;
     2:Begin { ABS }
      Inc(I);
      AddStr(S,HexWord(TWd(I)));
      Inc(I)
     End;
     3:Begin { AI }
      Inc(I);
      AddStr(S,'('+HexWord(TWd(I))+')');
      Inc(I)
     End;
     4:Begin { IMM }
      Inc(I);
      AddStr(S,'#'+HexByte(T[I]));
     End;
     5:Begin { DIY }
      Inc(I);
      AddStr(S,HexByte(T[I])+',Y');
     End;
     6:Begin { AIY }
      Inc(I);
      AddStr(S,'('+HexWord(TWd(I))+'),Y');
      Inc(I)
     End;
     {7: AIIX ;}
     8:Begin { DIIX }
      Inc(I);
      AddStr(S,'@'+HexByte(T[I])+',X');
     End;
     9:Begin { DIIY }
      Inc(I);
      AddStr(S,'@'+HexByte(T[I])+',Y');
     End;
     10:Begin { PCR }
      Inc(I);
      AddStr(S,HexByte(T[I]));
     End;
     {11: DI ;}
     12:Begin { DIX }
      Inc(I);
      AddStr(S,HexByte(T[I])+',X');
     End;
     13:Begin { AIX }
      Inc(I);
      AddStr(S,'('+HexWord(TWd(I))+'),X');
      Inc(I)
     End;
    End;
   End;
   Inc(I);
  End;
 End;
 If OpCodeFormat in[fAlgol68,fC]Then IncStr(S,';');
 Decode:=S;
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
END.