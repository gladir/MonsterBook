{$IFDEF VER70}{$Q-}{$ENDIF}{$A-,B-,E+,F+,G-,I-,N+,O-,P-,R-,S-,T-,V-,X+}

Uses Systex,Systems;

Procedure CheckSoundCard(Var Info:SoundRec);Var A1,A2,A3,A4,A5,A6,A7,I:Byte;W,W1:Word;Ok:Bool;Begin
 {--AdLib Detection--}
 ASM
  MOV DX,0388h
  IN  AL,DX
  MOV BL,AL
  MOV AL,0BDh
  OUT DX,AL
  IN  AL,DX
  IN  AL,DX
  IN  AL,DX
  IN  AL,DX
  INC DX
  IN  AL,DX
  MOV BH,AL
  XOR AL,AL
  OUT DX,AL
  DEC DX
  MOV CX,36
@@Loop1:
  IN AL,DX
  LOOP @@Loop1
  AND AL,7
  MOV A1,AL
  MOV AL,BL
  OUT DX,AL
  INC DX
  MOV AL,BH
  OUT DX,AL
 END;
 Info.IsAdLib:=A1=6;
 {--SoundBlaster--}
 A1:=1;
 While(A1<7)and(Not(Info.IsSoundBlaster))do Begin
  W:=$200+$10*A1;W1:=0;Ok:=No;
  While(W1<$201)and(Not(Ok))do Begin
   If Port[W+$0C]and$80=0Then Ok:=Ya;
   Inc(W1);
  End;
  If(Ok)Then Begin
   ASM
    MOV DX,W
    PUSH DX
     ADD DX,0000Ch
     IN  AL,DX
     MOV A3,AL
     MOV AL,0D3h
     OUT DX,AL
     MOV CX,01000h
@@LoopSB:
     LOOP @@LoopSB
    POP DX
    ADD DX,6
    IN  AL,DX
    MOV A4,AL
    MOV AL,1
    OUT DX,AL
    IN  AL,DX
    IN  AL,DX
    IN  AL,DX
    IN  AL,DX
    MOV A1,AL
    XOR AL,AL
    OUT DX,AL
   END;
   A2:=0;
   Repeat
    W1:=0;Ok:=No;
    While(W1<$201)and(Not(Ok))do Begin
     If Port[W+$0E]and$80=$80Then Ok:=Ya;
     Inc(W1);
    End;
    If(Ok)Then If Port[W+$0A]=$AAThen Info.IsSoundBlaster:=Ya;
    Inc(A2);
   Until (A2=$10)or(Ok);
   If Not(Ok)Then Begin
    Port[W+$0C]:=A3;
    Port[W+6]:=A4;
   End;
  End;
  If Not(Info.IsSoundBlaster)Then Inc(A1);
 End;
 If(Info.IsSoundBlaster)Then Info.Port:=W;
 {----Roland MPU-401----}
 Ok:=No;Info.IsMidi:=No;A1:=0;
 Repeat
  If Port[$331]and$40=0Then Ok:=Ya;
  Inc(A1);
 Until(A1=$FF)or(Ok);
 If(Ok)Then Begin
  ASM
   CLI
   MOV DX,0331h
   IN  AL,DX
   MOV AL,A2
   MOV AL,0FFh
   OUT DX,AL
  END;
  Ok:=No;A1:=0;
  Repeat
   If Port[$331]and$80=0Then Ok:=Ya;
   Inc(A1);
  Until(A1=$FF)or(Ok);
  A1:=Port[$330];
  STI;
  If(Ok)and(A1=$FE)Then Info.IsMidi:=Ya Else Port[$331]:=A2;
 End;
 {----TandyDigital----}
 ASM
  MOV AX,08100h
  INT 01Ah
  MOV A1,AH
 END;
 Info.IsTandyDigital:=A1>$81;
 {----Gravis UltraSound----}
 Info.IsGravis:=No;A1:=1;
 While(A1<7)and(Not(Info.IsGravis))do Begin
  ASM
   MOV DL,A1
   MOV DH,0
   MOV CL,4
   SHL DX,CL
   ADD DX,0303h
   MOV W,DX
   PUSH DX
    IN  AL,DX
    MOV A3,AL
    INC DX
    IN  AL,DX
    MOV A4,AL
    INC DX
    IN  AL,DX
    MOV A5,AL
    INC DX
    IN  AL,DX
    MOV A6,AL
    INC DX
    IN  AL,DX
    MOV A7,AL
   POP DX
   MOV AL,04Ch
   OUT DX,AL
   PUSH DX
    INC DX
    INC DX
    XOR AL,AL
    OUT DX,AL
    MOV DX,0300h
    MOV CX,14
@@LoopGravis:
    IN  AL,DX
    LOOP @@LoopGravis
   POP DX
   MOV AL,04Ch
   OUT DX,AL
   INC DX
   INC DX
   MOV AL,1
   OUT DX,AL
   DEC DX
   DEC DX
   MOV AL,043h
   OUT DX,AL { 103h }
   PUSH DX
    INC DX
    XOR AL,AL
    OUT DX,AL { 104h }
    DEC DX
    MOV AL,044h
    OUT DX,AL { 103h }
    INC DX
    INC DX
    XOR AL,AL
    OUT DX,AL { 105h }
    INC DX
    INC DX
    MOV AL,0AAh
    OUT DX,AL { 107h }
   POP DX
   MOV AL,043h
   OUT DX,AL { 103h }
   INC DX
   XOR AL,AL
   OUT DX,AL { 104h }
   DEC DX
   MOV AL,044h
   OUT DX,AL { 103h }
   PUSH DX
    INC DX
    INC DX
    MOV AL,1
    OUT DX,AL { 105h }
    INC DX
    INC DX
    MOV AL,055h
    OUT DX,AL { 107h }
   POP DX
   MOV AL,043h
   OUT DX,AL { 103h }
   INC DX
   XOR AL,AL
   OUT DX,AL { 104h }
   DEC DX
   MOV AL,044h
   OUT DX,AL { 103h }
   PUSH DX
    INC DX
    INC DX
    XOR AL,AL
    OUT DX,AL { 105h }
    INC DX
    INC DX
    IN  AL,DX { 107h }
    MOV A2,AL
   POP DX
   MOV AL,043h
   OUT DX,AL { 103h }
   XOR AX,AX
   INC DX
   OUT DX,AX { 104h }
   DEC DX
   MOV AL,044h
   OUT DX,AL { 103h }
   PUSH DX
    INC DX
    INC DX
    XOR AL,AL
    OUT DX,AL { 105h }
    INC DX
    INC DX
    OUT DX,AL { 107h }
   POP DX
   MOV AL,4Ch
   OUT DX,AL { 103h }
   INC DX
   INC DX
   XOR AL,AL
   OUT DX,AL { 105h }
  END;
  If A2=$AAThen Begin
   Info.IsGravis:=Ya;A3:=0;Ok:=No;Info.Port:=W;
   While(A3<=4)and(Not(Ok))do Begin
    ASM
     MOV DX,W
     MOV AL,043h
     OUT DX,AL { 103h }
     INC DX
     CMP A3,4
     JE  @@GravisB
     XOR AL,AL
     OUT DX,AL { 104h }
     DEC DX
     MOV AL,044h
     OUT DX,AL { 103h }
     PUSH DX
      INC DX
      INC DX
      MOV AL,A3
      SHL AL,1
      SHL AL,1
      OUT DX,AL { 105h }
      INC DX
      INC DX
      MOV AL,0AAh
      OUT DX,AL { 107h }
     POP DX
     MOV AL,043h
     OUT DX,AL { 103h }
     INC DX
     XOR AL,AL
     OUT DX,AL { 104h }
     DEC DX
     MOV AL,044h
     OUT DX,AL { 103h }
     INC DX
     INC DX
     MOV AL,A3
     SHL AL,1
     SHL AL,1
     OUT DX,AL { 105h }
     INC DX
     INC DX
     IN  AL,DX { 107h }
     MOV A2,AL
     JMP @@EndGravisChk
   @@GravisB:
     MOV AX,0FFFFh
     OUT DX,AX { 104h }
     DEC DX
     MOV AL,044h
     OUT DX,AL { 103h }
     PUSH DX
      INC DX
      INC DX
      MOV AL,0Fh
      OUT DX,AL { 105h }
      INC DX
      INC DX
      MOV AL,0AAh
      OUT DX,AL { 107h }
     POP DX
     MOV AL,043h
     OUT DX,AL { 103h }
     INC DX
     MOV AX,0FFFFh
     OUT DX,AX { 104h }
     DEC DX
     MOV AL,044h
     OUT DX,AL { 103h }
     INC DX
     INC DX
     MOV AL,0Fh
     OUT DX,AL { 105h }
     INC DX
     INC DX
     OUT DX,AL { 107h }
     MOV A2,AL
    @@EndGravisChk:
    END;
    If A2<>$AAThen Begin
     Ok:=Ya;Info.Memory:=A3*256; { En Kilo-octets }
    End;
   End;
  End
   Else
  Begin
   ASM
    MOV DX,W
    MOV AL,A3
    OUT DX,AL { 103h }
    INC DX
    MOV AL,A4
    OUT DX,AL { 104h }
    INC DX
    MOV AL,A5
    OUT DX,AL { 105h }
    INC DX
    MOV AL,A6
    OUT DX,AL { 106h }
    INC DX
    MOV AL,A7
    OUT DX,AL { 107h }
   END;
   Inc(A1);
  End;
 End;
End;

Procedure EndList;
Begin
End;

{$IFOPT G+}
 Const HeaderRLL:String = 'BibliothŠque en Mode R‚el pour 80286'+#26;
{$ELSE}
 Const HeaderRLL:String = 'BibliothŠque en Mode R‚el'+#26;
{$ENDIF}

Const

      NumIndex=1;

      NameIndex:Array[0..NumIndex]of System.PChar=(
      'RL2'#26,
      'CheckSoundCard');

Var SD:Word;HandleData,HandleMap:Hdl;PF,NmIndex:Long;

Procedure AddIndex;Begin
 SetRec(HandleData,NmIndex+1,SizeOf(PF),PF);
 If(SD<>0)Then
  PutFileTxtLn(HandleMap,'Index '+Str(NmIndex)+' : '+StrPas(@NameIndex[NmIndex+1])+
	       ', Taille '+Str(SD)+' octets');
 Inc(NmIndex);
 SetFilePos(HandleData,PF);
End;

Var X:SoundRec;

BEGIN
 CheckSoundCard(X);
 NmIndex:=0;
 HandleData:=New('SOUND.RLL');
 If(HandleData=errHdl)Then
 Begin
  WriteLn('Impossible de cr‚er le fichier SOUND.RLL');
  Halt;
 End;
 HandleMap := New('SOUND.MAP');
 If(HandleMap=errHdl)Then
 Begin
  WriteLn('Impossible de cr‚er le fichier SOUND.MAP');
  Halt;
 End;
 SetFilePos(HandleData,0);
 PutFileTxt(HandleData,'RL2'+#26);
 PF:=(NumIndex+2)*SizeOf(Long);
  { Header }
 SetFilePos(HandleData,PF);
 _SetRec(HandleData,Length(HeaderRLL),HeaderRLL[1]);
 Inc(PF,Length(HeaderRLL));
  { -- Index 0 -- : CheckSoundCard }
 SD:=Ofs(EndList)-Ofs(CheckSoundCard)+1;
 AddIndex;
 _SetRec(HandleData,SD,Mem[Seg(CheckSoundCard):Ofs(CheckSoundCard)]);
 Inc(PF,SD);
  { -- Index End -- }
 SD:=0;
 AddIndex;
 Close(HandleMap);
 Close(HandleData);
END.