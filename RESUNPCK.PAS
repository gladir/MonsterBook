{ Cette unit‚ offre des services permettant de lire des fichiers de donn‚es
 compress‚e.
}

Unit ResUnPck;

INTERFACE

Uses ResTex;

Procedure RUInit(Var Q:UnpackRec;Const Source,Target:String);
Procedure RURun(Var Q:UnpackRec);
Procedure RUDone(Var Q:UnpackRec);

IMPLEMENTATION

Uses Dos,Systex,Systems,Dials,Packex;

Procedure RUInit{Var Q:UnpackRec;Const Source,Target:String};
Var
 Sign3:Array[0..2]of Char Absolute Q;
 Sign4:Array[0..3]of Char Absolute Q;
 Sign7:Array[0..6]of Char Absolute Q;
 SignWord:Word Absolute Q;
 SignLong:Long Absolute Q;
 H:SwagHeader Absolute Q;
 Sign:Array[0..2]of Char;
Begin
 FillClr(Q,SizeOf(Q));
 Q.Source:=Source;
 Q.Target:=Target;
 Q.Handle:=Open(Source,fmRead);
 If(Q.Handle<>errHdl)Then Begin
  Q.FileSize:=FileSize(Q.Handle);
  _GetAbsRec(Q.Handle,0,SizeOf(Q.ReadBuffer),Q.ReadBuffer);
  If Q.ReadBuffer[0]=$1AThen Q.FileType:=ftArc Else
  If SignWord=60000Then Q.FileType:=ftArj Else
  IF Sign4='MSCF'Then Q.FileType:=ftCab Else
  If Sign3='lh'#0Then Q.FileType:=ftLZH Else
  If(Sign4=PakSign)Then Q.FileType:=ftPak Else
  If(Sign7=RARSign)Then Q.FileType:=ftRAR Else
  If SignLong=$04034B50Then Q.FileType:=ftZIP Else
  If Sign3='ZOO'Then Q.FileType:=ftZoo
   Else
  Begin
   Sign:='sw'#0;
   If(StrPos(@H.HeadID,@Sign)<>NIL)and(Length(H.FileName)>0)Then Q.FileType:=ftSwg;
  End;
 End;
End;

Function ArjFindNext(Var Q:UnpackRec):Bool;Near;
Var FHdr:ArjHeader;B:Byte;Begin
 ArjFindNext:=No;
 _GetAbsRec(Q.Handle,Q.FilePosFindFiles,SizeOf(FHdr),FHdr);
 If FHdr.BHdrSz>0Then Begin
  B:=1;
  Q.TargetName:=Path2Dir(Q.Target);
  While FHdr.NameDat[b]<>#0do Begin
   If FHdr.NameDat[B]='/'Then Q.TargetName:=''
                         Else IncStr(Q.TargetName,FHdr.NameDat[B]);
   Inc(B);
  End;
  Q.PackSize:=FHdr.BHdrSz+FHdr.CSize;
  If FHdr.FType=2Then Q.PackSize:=FHdr.BHdrSz;
  If FHdr.BHdrSz=0Then Q.PackSize:=0;
  Q.FilePos:=Q.FilePosFindFiles+34+Length(Q.TargetName)+8;
  Inc(Q.FilePosFindFiles,Q.PackSize+10);
  Q.UnPackSize:=FHdr.OSize;
  Q.Time:=FHdr.DosDT;
  Q.Attr:=faArchive;
  Q.Methode:=FHdr.SVer;
  ArjFindNext:=Ya;
 End;
End;

Procedure RUFind(Var Q:UnpackRec);Near;Var Ok:Bool;Begin
 SysErr:=0;
 Case(Q.FileType)of
  ftArj:Begin
   Ok:=ArjFindNext(Q);
   While(Ok)do Begin
    If WildCardMatch(Q.TargetName,Q.Target)Then Break;
    Ok:=ArjFindNext(Q);
   End;
   If Not(Ok)Then SysErr:=18;
  End;
  Else SysErr:=18;
 End;
End;

Function EOF(Var Q:UnpackRec):Bool;Begin
 EOF:=(Q.FilePos>=Q.FileSize)and(Q.PosBuf>=Q.SizeBuf);
End;

Function RUReadByte(Var Q:UnpackRec):Byte;Begin
 If(Q.PosBuf<>$FFFF)and EOF(Q)Then RUReadByte:=0
  Else
 Begin
  If(Q.PosBuf>=Q.SizeBuf)Then Begin
   Q.SizeBuf:=_GetAbsRec(Q.Handle,Q.FilePos,SizeOf(Q.ReadBuffer),Q.ReadBuffer);
   Inc(Q.FilePos,Long(Q.SizeBuf));
   Q.PosBuf:=0;
  End;
  RUReadByte:=Q.ReadBuffer[Q.PosBuf];
  Inc(Q.PosBuf);
 End;
End;

Procedure RUStored(Var Q:UnpackRec);
Var NM:Wd;M,I,ND:Long;Begin
 ND:=Q.UnPackSize div SizeOf(Q.ReadBuffer);
 NM:=Q.UnPackSize mod SizeOf(Q.ReadBuffer);
 M:=0;
 For I:=0to ND-1do Begin
  _GetAbsRec(Q.Handle,Q.FilePos,SizeOf(Q.ReadBuffer),Q.ReadBuffer);
  _SetAbsRec(Q.HandleTarget,M,SizeOf(Q.ReadBuffer),Q.ReadBuffer);
  Inc(Q.FilePos,Long(SizeOf(Q.ReadBuffer)));
  Inc(M,Long(SizeOf(Q.ReadBuffer)));
  {Proc((Long(M)*100)div Long(Q.UnpackSize),M,Q.UnpackSize);}
 End;
 If NM>0Then Begin
  _GetAbsRec(Q.Handle,Q.FilePos,NM,Q.ReadBuffer);
  _SetAbsRec(Q.HandleTarget,M,NM,Q.ReadBuffer);
 End;
End;

Procedure RUDecode(Var Q:UnpackRec);
Const WriteBufSize=26624;
Var
 I,J,C,R:Integer;
 Count:Long;
 Text:^TByte;
 BlockSize:Word;
 BitBuf:Word;
 SubBitBuf:Byte;
 BitCount:Integer;
 PtLen:Array[0..19]of Byte;
 PtTable:Array[0..256]of Word;
 Left,Right:Array[0..1019]of Word;
 CLen:Array[0..510]of Byte;
 CTable:Array[0..4096]of Word;

 Procedure WriteText;Begin
  If(R>=WriteBufSize)Then Begin
   R:=0;
   _SetRec(Q.HandleTarget,WriteBufSize,Text^);
  End;
 End;

 Procedure FillBuf(N:Integer);Begin
  BitBuf:=BitBuf shl N;
  While(N>BitCount)do Begin
   BitBuf:=BitBuf or (SubBitBuf shl N);
   Dec(N,BitCount);
   If Q.PackSize<>0Then Begin
    Dec(Q.PackSize);
    SubBitBuf:=RUReadByte(Q);
   End
    Else
   SubBitBuf:=0;
   BitCount:=8;
  End;
  BitBuf:=BitBuf or (SubBitBuf shr BitCount);
  Dec(BitCount,N);
 End;

 Function GetBits(N:Integer):Word;Begin
  GetBits:=BitBuf shr (16-N);
  FillBuf(N);
 End;

 Procedure MakeTable(NChar:Integer;Const BitLen:Array of Byte;
                     TableBits:Integer;Var Table:Array of Word;
                     TableSize:Integer);
 Var
  Count,Weight:Array[0..16]of Word;
  Start:Array[0..17]of Word;
  P:^Word;
  I,K,Len,Ch,JutBits,Avail,NextCode,Mask:Word;
 Begin
  FillClr(Count,SizeOf(Count));
  For I:=0to NChar-1do Inc(Count[BitLen[I]]);
  Start[1]:=0;
  For I:=1to 16do Start[I+1]:=Start[I]+(Count[I]shl(16-I));
  If Start[17]<>1 shl 16Then Begin
   ErrMsgOk('Erreur de table!');
   Halt;
  End;
  JutBits:=16-TableBits;
  For I:=1to(TableBits)do Begin
   Start[I]:=Start[I]shr JutBits;
   Weight[I]:=1 shl(TableBits-I);
  End;
  While I<=16do Begin
   Weight[I]:=1 shl(16-I);
   Inc(I);
  End;
  I:=Start[TableBits+1]shr JutBits;
  If I<>1 shl 16Then Begin
   K:=1 shl TableBits;
   While(I<>K)do Begin
    Table[I]:=0;
    Inc(I);
   End;
  End;
  Avail:=NChar;
  Mask:=1 shl(15-TableBits);
  For Ch:=0to NChar-1do Begin
   Len:=BitLen[Ch];
   If Len=0Then Continue;
   K:=Start[Len];
   NextCode:=K+Weight[Len];
   If(Len<=TableBits)Then Begin
    If(NextCode>TableSize)Then Begin
     ErrMsgOk('Erreur de table!');
     Halt;
    End;
    For I:=Start[Len]to NextCode-1do Table[I]:=Ch;
   End
    Else
   Begin
    P:=@Table[K shr JutBits];
    I:=Len-TableBits;
    While I<>0do Begin
     If P^=0Then Begin
      Right[Avail]:=0;Left[Avail]:=0;
      P^:=Avail;
      Inc(Avail);
     End;
     If K and Mask<>0Then P:=@Right[P^]
                     Else P:=@Left[P^];
     K:=K shl 1;
     Dec(I);
    End;
    P^:=Ch;
   End;
   Start[Len]:=NextCode;
  End;
 End;

 Procedure ReadPtLen(NN,NBit,ISpecial:Integer);Var I,N,C:Integer;Mask:Word;Begin
  N:=GetBits(NBit);
  If N=0Then Begin
   C:=GetBits(NBit);
   FillClr(PtLen,NN);
   FillWord(PtTable,256,C);
  End
   Else
  Begin
   I:=0;
   While(I<N)do Begin
    C:=BitBuf shr 13;
    If C=7Then Begin
     Mask:=1 shl 12;
     While(Mask and BitBuf)<>0do Begin
      Mask:=Mask shr 1;
      Inc(C);
     End;
    End;
    If C<7Then FillBuf(3)
          Else FillBuf(C-3);
    PtLen[I]:=C;
    Inc(I);
    If(I=ISpecial)Then Begin
     C:=GetBits(2)-1;
     While C>=0do Begin
      PtLen[I]:=0;
      Inc(I);
      Dec(C);
     End;
    End;
   End;
   While(I<NN)do Begin
    PtLen[I]:=0;
    Inc(I);
   End;
   MakeTable(NN,PtLen,8,PtTable,SizeOf(PtTable));
  End;
 End;

 Procedure ReadCLen;Var I,C,N:Integer;Mask:Word;Begin
  N:=GetBits(9);
  If N=0Then Begin
   C:=GetBits(9);
   FillClr(CLen,SizeOf(CLen));
   FillWord(CTable,4096,C);
  End
   Else
  Begin
   I:=0;
   While(I<N)do Begin
    C:=PtTable[Hi(BitBuf)];
    If C>=19Then Begin
     Mask:=1 shl 7;
     Repeat
      If BitBuf and Mask<>0Then C:=Right[C]
                           Else C:=Left[C];
      Mask:=Mask shr 1;
     Until C<19;
    End;
    FillBuf(PtLen[C]);
    If C<=2Then Begin
     Case(C)of
      0:C:=1;
      1:C:=GetBits(4)+3;
      Else C:=GetBits(9)+20;
     End;
     Dec(C);
     While C>=0do Begin
      CLen[I]:=0;
      Dec(I);
      Dec(C);
     End;
    End
     Else
    Begin
     CLen[I]:=C-2;
     Inc(I);
    End;
   End;
   While I<510do Begin
    CLen[I]:=0;
    Inc(I);
   End;
   MakeTable(510,CLen,12,CTable,SizeOf(CTable));
  End;
 End;

 Function DecodeC:Word;Var J,Mask:Word;Begin
  If BlockSize=0Then Begin
   BlockSize:=GetBits(16);
   ReadPtLen(19,5,3);
   ReadCLen;
   ReadPtLen(17,5,-1);
  End;
  Dec(BlockSize);
  J:=CTable[BitBuf shr 4];
  If J>=510Then Begin
   Mask:=1 shl 3;
   Repeat
    If BitBuf and Mask<>0Then J:=Right[J]
                         Else J:=Left[J];
    Mask:=Mask shr 1;
   Until J<510;
  End;
  FillBuf(CLen[J]);
  DecodeC:=J;
 End;

 Function DecodeP:Word;Var J,Mask:Word;Begin
  J:=PtTable[Hi(BitBuf)];
  If J>=17Then Begin
   Mask:=1 shl 7;
   Repeat
    If BitBuf and Mask<>0Then J:=Right[J]
                         Else J:=Left[J];
    Mask:=Mask shr 1;
   Until J<17;
  End;
  FillBuf(PtLen[J]);
  If J<>0Then Begin
   Dec(J);
   J:=(1 shl J)+GetBits(J);
  End;
  DecodeP:=J;
 End;

Begin
 Text:=MemAlloc(WriteBufSize);
 If(Text<>NIL)Then Begin
  BlockSize:=0;BitBuf:=0;SubBitBuf:=0;BitCount:=0;
  FillBuf(16);
  Count:=0;R:=0;
  While(Count<Q.UnpackSize)do Begin
   C:=DecodeC;
   If C<=255Then Begin
    Text^[R]:=C;
    Inc(Count);
    Inc(R);
    WriteText;
   End
    Else
   Begin
    J:=C-(256-3);
    Inc(Count,J);
    I:=DecodeP;
    I:=R-I-1;
    If I<0Then Inc(I,WriteBufSize);
    If(R>I)and(R<WriteBufSize-255)Then Begin
     Dec(J);
     While J>=0do Begin
      Text^[R]:=Text^[I];
      Inc(R);Inc(I);
      Dec(J);
     End;
    End
     Else
    Begin
     Dec(J);
     While J>=0do Begin
      Text^[R]:=Text^[I];
      Inc(R);
      WriteText;
      Inc(I);
      If(I>=WriteBufSize)Then I:=0;
     End;
    End;
   End;
  End;
  If R<>0Then _SetRec(Q.HandleTarget,R,Text^);
  FreeMem(Text,WriteBufSize);
 End;
End;

Procedure RUDecodeF(Var Q:UnpackRec);
Const WriteBufSize=26624;
Var
 I,J,C,R,Pos:Integer;
 Count:LongInt;
 Text:^TByte;
 BitBuf:Word;
 SubBitBuf:Byte;
 BitCount:Integer;
 GetLen:Integer;
 GetBuf:Integer;

 Procedure FillBuf(N:Integer);Begin
  BitBuf:=BitBuf shl N;
  While(N>BitCount)do Begin
   BitBuf:=BitBuf or (SubBitBuf shl N);
   Dec(N,BitCount);
   If Q.PackSize<>0Then Begin
    Dec(Q.PackSize);
    SubBitBuf:=RUReadByte(Q);
   End
    Else
   SubBitBuf:=0;
   BitCount:=8;
  End;
  BitBuf:=BitBuf or (SubBitBuf shr N);
  Dec(N,BitCount);
 End;

 Procedure Bfil;Begin
  GetBuf:=GetBuf or (BitBuf shr GetLen);
  FillBuf(16-GetLen);
  GetLen:=16;
 End;

 Procedure GetBits(Width:Integer);Begin
  If(GetLen<Width)Then Begin
   Bfil;
   C:=GetBuf shr (16-Width);
  End;
  GetBuf:=GetBuf shl Width;
  Dec(GetLen,Width);
 End;

 Procedure GetBit;Begin
  If GetLen<=0Then Begin
   Bfil;
   C:=Word(GetBuf and$8000<>0);
  End;
  GetBuf:=GetBuf shl 1;
  Dec(GetLen);
 End;

 Function DecodePtr:Integer;Var C,Width,Plus,Pwr:Integer;Begin
  Plus:=0;
  Pwr:=1 shl 9;
  For Width:=9to 13do Begin
   GetBit;
   If C=0Then Break;
   Inc(Plus,Pwr);
   Pwr:=Pwr shl 1;
  End;
  If Width<>0Then GetBits(Width);
  Inc(C,Plus);
  DecodePtr:=C;
 End;

 Function DecodeLen:Integer;Var C:Word;Width,Plus,Pwr:Integer;Begin
  Plus:=0;Pwr:=1;
  For Width:=0to 7do Begin
   GetBit;
   If C=0Then Break;
   Inc(Plus,Pwr);
   Pwr:=Pwr shl 1;
  End;
  If Width<>0Then GetBits(Width);
  Inc(C,Plus);
  DecodeLen:=C;
 End;

Begin
 Text:=MemAlloc(WriteBufSize);
 If(Text<>NIL)Then Begin
  BitBuf:=0;SubBitBuf:=0;BitCount:=0;
  FillBuf(16);
  GetLen:=0;GetBuf:=0;Count:=0;R:=0;
  While(Count<Q.UnpackSize)do Begin
   C:=DecodeLen;
   If C=0Then Begin
    GetBits(8);
    Text^[R]:=C;
    Inc(Count);
    Inc(R);
    If(R>=WriteBufSize)Then Begin
     R:=0;
     _SetRec(Q.HandleTarget,WriteBufSize,Text^);
    End;
   End
    Else
   Begin
    J:=C-1+3;
    Inc(Count,J);
    Pos:=DecodePtr;
    I:=R-Pos-1;
    If I<0Then Inc(I,WriteBufSize);
    While J>0do Begin
     Dec(J);
     Text^[R]:=Text^[I];
     Inc(R);
     If(R>=WriteBufSize)Then Begin
      R:=0;
      _SetRec(Q.HandleTarget,WriteBufSize,Text^);
     End;
     Inc(I);
     If(I>=WriteBufSize)Then I:=0;
    End;
   End;
  End;
  If R<>0Then _SetRec(Q.HandleTarget,R,Text^);
  FreeMem(Text,WriteBufSize);
 End;
End;

Procedure RURun{Var Q:UnpackRec};Begin
 RUFind(Q);
 While SysErr=0do Begin
  Q.PosBuf:=$FFFF;Q.SizeBuf:=SizeOf(Q.ReadBuffer);
  Q.HandleTarget:=New_(Q.TargetName,Q.Attr);
  If(Q.HandleTarget<>errHdl)Then Begin
   SetFilePos(Q.HandleTarget,0);
   Case(Q.FileType)of
    ftArj:Case(Q.Methode)of
     0:RUStored(Q);
     1..3:RUDecode(Q);
     4:RUDecodeF(Q);
    End;
    ftZip:Case(Q.Methode)of
     0:RUStored(Q);
    End;
   End;
   SetFileTime(Q.HandleTarget,fmWrite,LongRec(Q.Time).Lo,LongRec(Q.Time).Hi);
   Close(Q.HandleTarget);
  End
   Else
  ErrMsgOk('Impossible de cr‚er le fichier ®'+Q.TargetName+'¯');
  RUFind(Q);
 End;
End;

Procedure RUDone{Var Q:UnpackRec};Begin
 Close(Q.Handle);
End;

END.