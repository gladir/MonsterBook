{Donn‚e de base: Information brute}

Unit PCData;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                  INTERFACE
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses PCCortex;

Function CompStrPChr(Const Str2:String;Str1:PChar):Integer;
Function GetCodeIfCondAsm(Const Word:String):Byte;
Function GetCodeInstrPas(Word:String;Var Extra:Byte):Byte;
Function GetCodeMainWordPas(Const Word:String):Byte;
Function GetCodeRegAsm(Const Word:String;Var Extra:Byte):Byte;
Function SearchVarPas(Word:String):NoeudVarPasPtr;
Function SearchWordAsm(Const Word:String):NoeudAsmPtr;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                IMPLEMENTATION
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses ResServD,Systex;

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

Function SearchWordAsm(Const Word:String):NoeudAsmPtr;Begin
 If DBLocateAbsIM(CurrPC.InstrAsm,3,Word,[])Then Begin
  SearchWordAsm:=CurrPC.InstrAsm.CurrRec.Ptr;
  Inc(PtrRec(CurrPC.InstrAsm.CurrRec).Ofs,4);
  Inc(PtrRec(CurrPC.InstrAsm.CurrRec).Ofs,CurrPC.InstrAsm.CurrRec.Byte^+1);
  Pointer(CurrPC.SuggOpCode):=CurrPC.InstrAsm.CurrRec.Ptr;
 End
  Else
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

Function GetCodeIfCondAsm(Const Word:String):Byte;Begin
 If DBLocateAbsIM(CurrPC.IfCondAsm,1,Word,[])Then Begin
  GetCodeIfCondAsm:=CurrPC.IfCondAsm.CurrRec.Byte^;
 End
  Else
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

Function GetCodeRegAsm(Const Word:String;Var Extra:Byte):Byte;Begin
 If DBLocateAbsIM(CurrPC.RegAsm,2,Word,[])Then Begin
  GetCodeRegAsm:=CurrPC.RegAsm.CurrRec.Byte^;
  Inc(PtrRec(CurrPC.RegAsm.CurrRec).Ofs);
  Extra:=CurrPC.RegAsm.CurrRec.Byte^;
 End
  Else
 GetCodeRegAsm:=$FF;
End;

Function GetCodeMainWordPas;Begin
 If DBLocateAbsIM(CurrPC.MainWord,2,Word,[])Then Begin
  GetCodeMainWordPas:=CurrPC.MainWord.CurrRec.Byte^;
 End
  Else
 GetCodeMainWordPas:=cmwpError;
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
END.