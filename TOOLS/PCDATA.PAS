{Donn‚e de base: Information brute}

Unit PCData;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                  INTERFACE
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses PCCortex;

Function CompStrPChr(Const Str2:String;Str1:PChar):Integer;
Function GetCodeIfCondAsm(Word:String):Byte;
Function GetCodeInstrPas(Word:String;Var Extra:Byte):Byte;
Function GetCodeMainWordPas(Word:String):Byte;
Function GetCodeRegAsm(Const Word:String;Var Extra:Byte):Byte;
Function SearchVarPas(Word:String):NoeudVarPasPtr;
Function SearchWordAsm(Word:String):NoeudAsmPtr;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                IMPLEMENTATION
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses Systex;

Function CompStrPChr(Const Str2:String;Str1:PChar):Integer;Assembler;ASM
 PUSH DS
  XOR AX,AX
  XOR DX,DX
  CLD
  LES DI,Str1
  LDS SI,Str2
  LODSB
  MOV CL,AL
  XOR CH,CH
  REPE CMPSB
  MOV AL,DS:[SI-1]
  MOV DL,ES:[DI-1]
  SUB AX,DX
 POP DS
END;

{ Cette fonction permet de connaŒtre les informations relatif … une
 instruction d'assembleur. Si le mot n'est pas dans la liste alors
 un pointeur est retourn‚e.
}

Function SearchWordAsm(Word:String):NoeudAsmPtr;Var T:Int;P:NoeudAsmPtr;Begin
 Word:=Word+#0;P:=@AsmCode;
 Repeat
  T:=CompStrPChr(Word,P^.Nom);
  If T=0Then Begin;SearchWordAsm:=P;Exit;End;
  If T<0Then PtrRec(P).Ofs:=P^.Gauche
        Else PtrRec(P).Ofs:=P^.Droite;
 Until P=Ptr(DSeg,0);
 SearchWordAsm:=NIL;
End;

Function SearchVarPas(Word:String):NoeudVarPasPtr;Var T:Int;P:NoeudVarPasPtr;Begin
 Word:=Word+#0;P:=@VarPas;
 Repeat
  T:=CompStrPChr(Word,P^.Nom);
  If T=0Then Begin;SearchVarPas:=P;Exit;End;
  If T<0Then PtrRec(P).Ofs:=P^.Gauche Else PtrRec(P).Ofs:=P^.Droite;
 Until P=Ptr(DSeg,0);
 SearchVarPas:=NIL;
End;

Function GetCodeIfCondAsm(Word:String):Byte;Var T:Int;P:NoeudIfCondAsmPtr;Begin
 Word:=Word+#0;P:=@AsmIfCond;
 Repeat
  T:=CompStrPChr(Word,P^.Nom);
  If T=0Then Begin;GetCodeIfCondAsm:=P^.Code;Exit;End;
  If T<0Then PtrRec(P).Ofs:=P^.Gauche Else PtrRec(P).Ofs:=P^.Droite;
 Until P=Ptr(DSeg,0);
 GetCodeIfCondAsm:=$FF;
End;

Function GetCodeInstrPas(Word:String;Var Extra:Byte):Byte;Var T:Int;P:NoeudInstrPasPtr;Begin
 Word:=Word+#0;P:=@InstrPas;
 Repeat
  T:=CompStrPChr(Word,P^.Nom);
  If T=0Then Begin;GetCodeInstrPas:=P^.Code;Extra:=P^.Extra;Exit;End;
  If T<0Then PtrRec(P).Ofs:=P^.Gauche Else PtrRec(P).Ofs:=P^.Droite;
 Until P=Ptr(DSeg,0);
 GetCodeInstrPas:=$FF;
End;

Function GetCodeRegAsm(Const Word:String;Var Extra:Byte):Byte;Var T:Int;P:NoeudRegAsmPtr;Begin
 P:=@RegAsm;
 Repeat
  If(Word=P^.Nom)Then Begin;GetCodeRegAsm:=P^.Code;Extra:=P^.Extra;Exit;End;
  If(Word<P^.Nom)Then PtrRec(P).Ofs:=P^.Gauche Else PtrRec(P).Ofs:=P^.Droite;
 Until P=Ptr(DSeg,0);
 GetCodeRegAsm:=$FF;
End;

Function GetCodeMainWordPas;Var T:Int;P:NoeudMainWordPasPtr;Begin
 Word:=Word+#0;P:=@MainWordPas;
 Repeat
  T:=CompStrPChr(Word,P^.Nom);
  If T=0Then Begin;GetCodeMainWordPas:=P^.Code;Exit;End;
  If T<0Then PtrRec(P).Ofs:=P^.Gauche Else PtrRec(P).Ofs:=P^.Droite;
 Until P=Ptr(DSeg,0);
 GetCodeMainWordPas:=cmwpError;
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
END.