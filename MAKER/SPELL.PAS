Program MakerSpell;

Uses Dos,Systex,Systems;

Var I:Char;
    TabPos:Array[0..8191]of LongInt;

Procedure InsFile(Handle:Hdl;Const FileName:String;Var PF:Long);
Var HandleLoad:Hdl;FSL,M:Long;Buf:Pointer;I,NM,ND:Wd;Begin
 HandleLoad:=Open(FileName,fmRead);
 If(HandleLoad<>errHdl)Then Begin
  FSL:=FileSize(HandleLoad);
  If FSL>65520Then Begin
   Buf:=MemAlloc(65520);
   If(Buf<>NIL)Then Begin
    ND:=FSL div 65520;NM:=FSL mod 65520;M:=0;
    For I:=0to ND-1do Begin
     _GetAbsRec(HandleLoad,M,65520,Buf^);
     _SetAbsRec(Handle,PF,65520,Buf^);
     Inc(M,Long(65520));Inc(PF,Long(65520));
    End;
    If NM>0Then Begin
     _GetAbsRec(HandleLoad,M,NM,Buf^);
     _SetAbsRec(Handle,PF,NM,Buf^);
     Inc(PF,Long(NM));
    End;
    FreeMem(Buf,65520);
   End;
  End
   Else
  Begin
   Buf:=MemAlloc(FSL);
   If(Buf<>NIL)Then Begin
    GetRec(HandleLoad,0,FSL,Buf^);
    _SetAbsRec(Handle,PF,FSL,Buf^);
    Inc(PF,Long(FSL));
    FreeMem(Buf,FSL);
   End;
  End;
  Close(HandleLoad);
 End;
End;

Procedure InsRec(Handle:Hdl;Position,Size:Long);
Var M,FS,SizeTransfert:Long;ND,NM,I:Word;Buffer:Array[0..1023]of Byte;Begin
 FS:=FileSize(Handle);
 SizeTransfert:=FS-Position;
 ND:=SizeTransfert div SizeOf(Buffer);
 NM:=SizeTransfert mod SizeOf(Buffer);
 M:=FS;
 If ND>0Then Begin
  For I:=ND-1downto 0do Begin
   Dec(M,Long(SizeOf(Buffer)));
   _GetAbsRec(Handle,M,SizeOf(Buffer),Buffer);
   _SetAbsRec(Handle,Long(M)+Long(Size),SizeOf(Buffer),Buffer);
  End;
  M:=Position;
 End
  Else
 M:=FS-NM;
 If NM>0Then Begin
  _GetAbsRec(Handle,M,NM,Buffer);
  _SetAbsRec(Handle,Long(M)+Long(Size),NM,Buffer);
 End;
End;

Procedure MakeTable(Const NameSource,NameTarget:String);
Var HS,HT:Hdl;Pour,Hour,Min,OldSec,Sec,Sec100:Byte;
IP,FP,FS,InsSize:Long;S,SPour,Target:String;NumWord,I:Word;
Begin
 HS:=Open(NameSource,fmRead);
 HT:=NewNBak(NameTarget);
 If(HT=errHdl)Then Begin
  WriteLn('Impossible de cr‚er le fichier de donn‚e!');
  Halt(7);
 End;
 FS:=FileSize(HS);FP:=0;OldSec:=$FF;NumWord:=0;IP:=0;
 Write('Progression (');
 Repeat
  __GetAbsFileTxtLn(HS,FP,S);
  _SetRec(HT,Length(S)+1,S);
  Inc(IP,Length(S)+1);
  Inc(NumWord);
  TabPos[NumWord]:=IP;
  GetTime(Hour,Min,Sec,Sec100);
  If(OldSec<>Sec)Then Begin
   Pour:=Long(Long(FP)*100)div FS;SPour:=Str(Pour)+'%)';
   Write(SPour+MultChr(#8,Length(SPour)));
  End;
 Until FS<=FP;
 WriteLn;
 InsSize:=Long(Succ(NumWord)shl 2);
 TabPos[0]:=NumWord;
 For I:=1to(NumWord)do Inc(TabPos[I],InsSize);
 InsRec(HT,0,InsSize);
 _SetAbsRec(HT,0,InsSize,TabPos);
 Close(HT);
 Close(HS);
End;

Procedure FinalMake;
Var
 Handle:Hdl;
 TabCar:Array[0..255]of Long;
 TabAscii:Array[0..255]of Char;
 I:Char;
 J:Word;
 FP,OP:Long;
Begin
 FillClr(TabAscii,SizeOf(TabAscii));
 For J:=0to 25do Begin
  TabAscii[J+Byte('A')]:=Char(J+Byte('a'));
  TabAscii[J+Byte('a')]:=Char(J+Byte('a'));
 End;
 TabAscii[128]:='c';TabAscii[129]:='u';TabAscii[130]:='e';
 TabAscii[131]:='a';TabAscii[132]:='a';TabAscii[133]:='a';
 TabAscii[134]:='a';TabAscii[135]:='c';TabAscii[136]:='e';
 TabAscii[137]:='e';TabAscii[138]:='e';TabAscii[139]:='i';
 TabAscii[140]:='i';TabAscii[141]:='i';TabAscii[142]:='a';
 TabAscii[143]:='a';TabAscii[144]:='e';
                    TabAscii[147]:='o';TabAscii[148]:='o';
 TabAscii[149]:='o';TabAscii[150]:='u';TabAscii[151]:='u';
 TabAscii[152]:='y';TabAscii[153]:='o';TabAscii[154]:='u';
 TabAscii[160]:='a';TabAscii[161]:='i';TabAscii[162]:='o';
 TabAscii[163]:='u';TabAscii[164]:='n';TabAscii[165]:='n';
 Handle:=NewNBak('SPELL.DAT');
 If(Handle<>errHdl)Then Begin
  FillClr(TabCar,SizeOf(TabCar));
  PutFileTxt(Handle,'Dictionnaire AdŠle'#26);
  _SetAbsRec(Handle,19,SizeOf(TabCar),TabCar);
  FP:=19+SizeOf(TabCar);
  For I:='a'to'z'do Begin
   OP:=FP;
   InsFile(Handle,'E:\'+I+'.DTA',FP);
   DelFile('E:\'+I+'.DTA');
   For J:=0to 255do Begin
    If(TabAscii[J]=I)Then TabCar[J]:=OP;
   End;
   _GetAbsRec(Handle,OP,SizeOf(TabPos),TabPos);
   For J:=1to TabPos[0]do Inc(TabPos[J],OP);
   _SetAbsRec(Handle,OP,Succ(TabPos[0])shl 2,TabPos);
  End;
  _SetAbsRec(Handle,19,SizeOf(TabCar),TabCar);
  Close(Handle);
 End;
End;

BEGIN
 InitSystems(suIsabel);
 For I:='A'to'Z'do Begin
  MakeTable('E:\ATLAS\LISTES\'+I+'.LST','E:\'+I+'.DTA');
 End;
 FinalMake;
END.