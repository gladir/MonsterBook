{ Compilation du code machine }

Unit PCCompile;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                 INTERFACE
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses Systex;

Procedure InsertCode(_Label,Code:String);
Procedure Push2Byte(L1,L2:Byte);
Procedure Push2ByteOffset(L1,L2:Byte;Off:Word);
Procedure Push3Byte(L1,L2,L3:Byte);
Procedure PushAddByte(L:Byte);
Procedure PushAddWord(L:Word);
Procedure PushAddLong(L:Long);
Procedure PushByte(L:Byte);
Procedure PushInstr(Const S:String);
Procedure PushInstrOffset(Const S:String;Off:Word);
Procedure PushLongInt(L:Long);
Procedure PushWord(L:Wd);

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                IMPLEMENTATION
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses PCCortex,Memories,Systems,PCData,PCBase;

Procedure InsertCode(_Label,Code:String);
Var
 Ok:Boolean;
 L,I,K,T,TIP:Word;
 TJump,SJump,UJump,LJump:JumpPtr;
Begin
 For I:=0to CurrPC.Jump.Count-1do Begin
  CurrPC.PJump:=_ALGetBuf(CurrPC.Jump,I);
  If(CurrPC.PJump<>NIL)and(CurrPC.PJump^.Access=isLabel)and(CurrPC.PJump^.Nom=_Label)Then Break;
 End;
 If(CurrPC.PJump<>NIL)Then Begin
  TIP:=CurrPC.PJump^.Off;Ok:=No;
  L:=Length(Code);
  MoveRight(CurrPC.CodePrg^[TIP],CurrPC.CodePrg^[TIP+L],CurrPC.IP-TIP+1);
  Inc(CurrPC.IP,L);
  MoveLeft(Code[1],CurrPC.CodePrg^[TIP],L);
  For K:=I+1to CurrPC.Jump.Count-1do Begin
   UJump:=_ALGetBuf(CurrPC.Jump,K);
   If(UJump<>NIL)Then Inc(UJump^.Off,L);
  End;
  If I>0Then For K:=0to I-1do Begin
   UJump:=_ALGetBuf(CurrPC.Jump,K);
   If(UJump<>NIL)and(UJump^.Access=isJump)Then Begin
    Ok:=False;
    LJump:=SearchJump(UJump^.Nom,isLabel);
    If(LJump<>NIL)and(LJump^.Off>TIP)Then Ok:=Ya;
    If(Ok)Then Case(UJump^.Setted)of
     NoSetted:;
     ShortJmp:If CurrPC.CodePrg^[UJump^.Off+1]<$80Then Begin
      If(CurrPC.CodePrg^[UJump^.Off+CurrPC.CodePrg^[UJump^.Off+1]]>TIP)Then Begin
       Inc(CurrPC.CodePrg^[UJump^.Off+1],L);
      End;
      If CurrPC.CodePrg^[UJump^.Off+1]>=$80Then Begin
       UJump^.Setted:=NoSetted;
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
 End;
End;

Procedure PushInstr(Const S:String);Begin
 CurrPC.PrevIP:=CurrPC.IP;
 MoveLeft(S[1],CurrPC.CodePrg^[CurrPC.IP],Length(S));
 Inc(CurrPC.IP,Length(S));
End;

Procedure PushInstrOffset;Begin
 If LastNameVar<>''Then Begin
  AddExternVarAddr(LastUnitNum,LastFP,CurrPC.IP+Length(S),LastNameVar);
 End;
 PushInstr(S+Chr(Lo(Off))+Chr(Hi(Off)))
End;

Procedure PushLongInt(L:Long);Var S:String;Begin
 MoveLeft(L,S[1],SizeOf(L));
 S[0]:=#4;
 PushInstr(S);
End;

Procedure PushWord(L:Word);Var S:String;Begin
 MoveLeft(L,S[1],SizeOf(L));
 S[0]:=#2;
 PushInstr(S);
End;

Procedure PushByte(L:Byte);Begin
 PushInstr(Chr(L))
End;

Procedure PushAddByte;Begin
 CurrPC.CodePrg^[CurrPC.IP]:=L;
 Inc(CurrPC.IP);
End;

Procedure PushAddWord;Begin
 MoveLeft(L,CurrPC.CodePrg^[CurrPC.IP],SizeOf(L));
 Inc(CurrPC.IP,2);
End;

Procedure PushAddLong;Begin
 MoveLeft(L,CurrPC.CodePrg^[CurrPC.IP],SizeOf(L));
 Inc(CurrPC.IP,4);
End;

Procedure Push2Byte;Begin
 PushInstr(Chr(L1)+Chr(L2))
End;

Procedure Push2ByteOffset;Begin
 PushInstrOffset(Chr(L1)+Chr(L2),Off);
End;

Procedure Push3Byte;Begin
 PushInstr(Chr(L1)+Chr(L2)+Chr(L3))
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
END.