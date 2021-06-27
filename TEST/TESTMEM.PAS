Type
 PtrRec=Record
  Ofs,Seg:Word;
 End;

 {Structure de manipulation de m‚moire par l'Interruption 15h}
 SDES=Record
  Length,AdrLo:Word;
  AdrHi,Attribut:Byte;
  Res:Word;
 End;

 GDT=Record
  Dummy,GDTS,Start,But,Code,Stack:SDES;
 End;

 LI=Record
  LoWord:Word;
  HiByte,Dummy:Byte;
 End;

Var SysErr:Byte;

Function AddrExt2Conv(Addr:Pointer):LongInt;Begin
 AddrExt2Conv:=LongInt(PtrRec(Addr).Seg)shl 4+PtrRec(Addr).Ofs;
End;

 Procedure ExtBiosCopy(Start,But:LongInt;Len:Word);Var GTab:GDT;Adr:LongInt;Begin
  FillChar(GTab,SizeOf(GTab),0);
  GTab.Start.AdrLo:=LI(Start).LoWord;
  GTab.Start.AdrHi:=LI(Start).HiByte;
  GTab.But.AdrLo:=LI(But).LoWord;
  GTab.But.AdrHi:=LI(But).HiByte;
  ASM
   PUSH SS;POP ES
   MOV SI,Offset GTab
   MOV AH,$92
   MOV GTab(SS:[SI]).Start.Attribut,AH
   MOV GTab(SS:[SI]).But.Attribut,AH
   MOV CX,Len
   MOV GTab(SS:[SI]).Start.Length,CX
   MOV GTab(SS:[SI]).But.Length,CX
   SHR CX,1
   MOV AH,$87
   INT $15
   MOV SysErr.Byte,AH
   CMP AH,0
   JE  @1
   MOV SysErr.Byte[1],3
 @1:
  END
 End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Proc‚dure ExtBiosRead                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet  d'effectuer une lecture   dans une zone de m‚moire
 prot‚g‚ en passant par le BIOS.
}

 Procedure ExtBiosRead(ExtAddr:LongInt;BuPtr:Pointer;Len:Word);Begin
  ExtBiosCopy(ExtAddr,AddrExt2Conv(BuPtr),Len)
 End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Proc‚dure ExtBiosWrite                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet  d'effectuer une ‚criture  dans une zone de m‚moire
 prot‚g‚ en passant par le BIOS.
}

 Procedure ExtBiosWrite(BuPtr:Pointer;ExtAddr:LongInt;Len:Word);Begin
  ExtBiosCopy(AddrExt2Conv(BuPtr),ExtAddr,Len)
 End;


Var Data:Array[0..30000]of Byte;

BEGIN
 ExtBiosRead($E0000000,@Data,1000);
END.