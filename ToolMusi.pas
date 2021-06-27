{$I DEF.INC}

Unit ToolMusi;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                   INTERFACE
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Procedure Snd2Wav(Source,Target:String);

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                IMPLEMENTATION
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses
 Systex,Systems,Dials,DialPlus;

Type
 SndNoteRec=Record { Enregistrement des notes .SND de Deskmate Tandy }
  Start:LongInt;   { Offset de d‚but dans le fichier pour un note "Samples" }
  Length:LongInt;  { Nombre de note "Samples" }
 End;

 NoteArray=Array[1..16]of SndNoteRec;

Function LastPos(Const S:String;Chr:Char):Integer;Near;
Var
 I:Integer;         { Compteur de boucle }
 Place:Integer;     { Emplacement o— le ®Chr¯ a ‚t‚ trouv‚ }
Begin
 I:=Length(S);
 Place:=0;
 While(I>0)and(Place=0)do Begin
  If(S[I]=Chr)Then Place:=I;
  Dec(I);
 End;
 LastPos:=Place;
End;

{ Cette fonction indique s'il s'agit du nouveau format de fichier .SND
 (True) ou non (False).
}

Function IsNewSnd(Const SndName:String):Boolean;
Var
 Handle:Hdl;
 FirstByte:Byte;
 IDTag:Word;
Begin
 IsNewSnd:=False;
 Handle:=FileOpen(SndName,fmRead);
 If(Handle=errHdl)Then Exit;
 If FileSize(Handle)<46Then Exit;
 _GetAbsRec(Handle,0,1,FirstByte);
 _GetAbsRec(Handle,44,SizeOf(IDTag),IDTag);
 FileClose(Handle);
 IsNewSnd:=(FirstByte<>$1A)and(IDTag=$801A);
End;

Function ReadNewHeader(Var SndName:String;Var SndFile:File;
                       Var Rate:Word;Var NumNotes:Byte;
                       Var NoteList:NoteArray):Byte;
Var
 FixedHeader:Array[0..113]of Byte;
 BytesRead:Integer;
 Valid:Boolean;
 WordPtr:^Word;
 LongPtr:^LongInt;
 I:Integer;
 NoteHeader:Array[0..45]of Byte;
 NextNote:LongInt;
Begin
 ReadNewHeader:=0;
 Assign(SndFile,SndName);
 {$I-}
 Reset(SndFile,1);
 {$I+}
 If IOResult<>0Then Begin
  ReadNewHeader:=6;
  Exit;
 End;
 BlockRead(SndFile,FixedHeader,114,BytesRead);
 Valid:=(BytesRead=114);
 Valid:=Valid and(FixedHeader[$2C]=$1A);
 Valid:=Valid and(FixedHeader[$2D]=$80);
 Valid:=Valid and(FixedHeader[$42]<=2);
 Valid:=Valid and(FixedHeader[$2E]in[1..16]);
 If Not(Valid)Then Begin
  ReadNewHeader:=3;
  System.Close(SndFile);
  Exit;
 End;
 If FixedHeader[$42]<>0Then Begin
  ReadNewHeader:=7;
  System.Close(SndFile);
  Exit;
 End;
 NumNotes:=FixedHeader[$2E];
 WordPtr:=@FixedHeader[$58];
 Rate:=WordPtr^;
 For I:=1to(NumNotes)do Begin
  BlockRead(SndFile,NoteHeader,46,BytesRead);
  If BytesRead<>46Then Begin
   ReadNewHeader:=8;
   System.Close(SndFile);
   Exit;
  End;
  LongPtr:=@NoteHeader[$0A];
  NoteList[I].Start:=LongPtr^;
  LongPtr:=@NoteHeader[$12];
  NoteList[I].Length:=LongPtr^;
  LongPtr:=@NoteHeader[0];
  NextNote:=LongPtr^;
  If NextNote>System.FileSize(SndFile)Then Begin
   ReadNewHeader:=8;
   System.Close(SndFile);
   Exit;
  End;
  Seek(SndFile,NextNote);
 End;
End;

Function ReadSndHeader(Var SndName:String;Var SndFile:File;
                       Var Rate:Word;Var NumNotes:Byte;
                       Var NoteList:NoteArray):Byte;
Var
 FixedHeader:Array[0..15]of Byte;
 BytesRead:Integer;
 Valid:Boolean;
 WordPtr:^Word;
 LongPtr:^LongInt;
 I:Integer;
 NoteHeader:Array[0..27]of Byte;
Begin
 ReadSndHeader:=0;
 Assign(SndFile,SndName);
 {$I-}
 Reset(SndFile,1);
 {$I+}
 If IOResult<>0Then Begin
  ReadSndHeader:=6;
  Exit;
 End;
 BlockRead(SndFile,FixedHeader,16,BytesRead);
 Valid:=(BytesRead=16);
 Valid:=Valid and(FixedHeader[0]=$1A);
 Valid:=Valid and(FixedHeader[1]<=2);
 Valid:=Valid and(FixedHeader[2]in[1..16]);
 Valid:=Valid and(FixedHeader[3]in[0..32,$FF]);
 If Not(Valid)Then Begin
  ReadSndHeader:=3;
  System.Close(SndFile);
  Exit;
 End;
 If FixedHeader[1]<>0Then Begin
  ReadSndHeader:=7;
  System.Close(SndFile);
  Exit;
 End;
 NumNotes:=FixedHeader[2];
 WordPtr:=@FixedHeader[$0E];
 Rate:=WordPtr^;
 For I:=1to(NumNotes)do Begin
  BlockRead(SndFile,NoteHeader,28,BytesRead);
  If BytesRead<>28Then Begin
   ReadSndHeader:=7;
   System.Close(SndFile);
   Exit;
  End;
  LongPtr:=@NoteHeader[4];
  NoteList[I].Start:=LongPtr^;
  LongPtr:=@NoteHeader[$10];
  NoteList[I].Length:=LongPtr^;
 End;
End;

Function SetLast(St:String;C:Char):String;
Var
 SlashPlace:Integer;
 ColonPlace:Integer;
 DotPlace:Integer;
 PathName:String;
 FileName:String;
 Ext:String;
Begin
 SlashPlace:=LastPos(St,'\');
 ColonPlace:=LastPos(St,':');
 If(ColonPlace>SlashPlace)Then SlashPlace:=ColonPlace;
 If SlashPlace=0Then PathName:=''
  Else
 Begin
  PathName:=Left(St,SlashPlace);
  Delete(St,1,slashplace);
 End;
 DotPlace:=LastPos(St,'.');
 If DotPlace=0Then Begin
  FileName:=st;
  Ext:='';
 End
  Else
 If DotPlace=1Then Begin
  FileName:='';
  Delete(St,1,1);
  Ext:=St;
 End
  Else
 Begin
  FileName:=Left(St,DotPlace-1);
  Delete(St,1,DotPlace);
  Ext:=St;
 End;
 If FileName=''Then SetLast:=' '
  Else
 Begin
  If Length(FileName)=8Then FileName[8]:=C
                       Else IncStr(FileName,C);
  SetLast:=PathName+FileName+'.'+Ext;
 End;
End;

Function Byte2Char(B:Byte):Char;Near;Begin
 If B<10Then Byte2char:=Chr(B+Byte('0'))
        Else Byte2char:=Chr(B-10+Byte('A'));
End;

Function ConvertNote(Var SndFile:File;WavName:String;Rate:Word;
                     Note:Byte;NoteList:NoteArray):Byte;Near;
Label 0,1;
Const BufSize=2048;
Type Paoc4=Array[0..3]of Char;
Var
 WavFile:File;
 Valid:Boolean;
 NoteStart:LongInt;
 NoteLength:LongInt;
 WavHeader:Array[0..43]of Byte;
 StPtr:^Paoc4;
 WordPtr:^Word;
 LongPtr:^LongInt;
 BytesWritten:Integer;
 Buffer:Array[1..BufSize]of Byte;
 BytesLeft:LongInt;
 ByteStoread:Word;
 BytesRead:Integer;
Begin
 ConvertNote:=0;
 If Note>1Then WavName:=SetLast(WavName,Byte2Char(Note));
 Assign(WavFile,WavName);
 {$I-}
 ReWrite(WavFile,1);
 {$I+}
 If IOResult<>0Then Begin
  ConvertNote:=1;
  Exit;
 End;
 NoteStart:=NoteList[Note].Start;
 NoteLength:=NoteList[Note].Length;
 If NoteLength=0Then Begin
  ConvertNote:=2;
  Goto 0;
 End;
 If(NoteStart=0)and(Note=1)Then Begin
  NoteStart:=44;
  If NoteLength>255Then NoteLength:=System.filesize(SndFile)-44;
 End;
 Valid:=(NoteStart>=44)and(Notelength>0);
 Valid:=Valid and(NoteStart<System.FileSize(SndFile))and
        (NoteLength<System.filesize(SndFile));
 Valid:=Valid and(NoteStart+NoteLength<=System.FileSize(SndFile));
 If Not(Valid)Then Begin
  ConvertNote:=3;
0:System.Close(WavFile);
  Erase(WavFile);
  Exit;
 End;
  {Constructure le WAVE }
 StPtr:=@WavHeader[0];
 StPtr^:='RIFF';
 LongPtr:=@WavHeader[4];
 LongPtr^:=NoteLength+36;
 StPtr:=@WavHeader[8];
 StPtr^:='WAVE';
 StPtr:=@WavHeader[12];
 StPtr^:='fmt ';
 LongPtr:=@WavHeader[16];
 LongPtr^:=16;
 WordPtr:=@WavHeader[20];
 WordPtr^:=1;
 WordPtr:=@WavHeader[22];
 WordPtr^:=1;
 LongPtr:=@WavHeader[24];
 LongPtr^:=LongInt(Rate);
 LongPtr:=@WavHeader[28];
 LongPtr^:=LongInt(Rate);
 WordPtr:=@WavHeader[32];
 WordPtr^:=1;
 WordPtr:=@WavHeader[34];
 WordPtr^:=8;
 StPtr:=@WavHeader[36];
 StPtr^:='data';
 LongPtr:=@WavHeader[40];
 LongPtr^:=NoteLength;
 BlockWrite(WavFile,WavHeader,44,BytesWritten);
 If BytesWritten<>44Then Begin
  ConvertNote:=4;
  Goto 1;
 End;
 Seek(SndFile,NoteStart);
 BytesLeft:=NoteLength;
 While BytesLeft>0do Begin
  If(BytesLeft>BufSize)Then ByteStoread:=BufSize
                       Else ByteStoread:=BytesLeft;
  BlockRead(SndFile,Buffer,ByteStoread,BytesRead);
  If(BytesRead<>ByteStoread)Then Begin
   ConvertNote:=5;
 1:System.Close(SndFile);
   System.Close(Wavfile);
   Erase(WavFile);
   Exit;
  End;
  BlockWrite(WavFile,Buffer,BytesRead,BytesWritten);
  If(BytesWritten<>BytesRead)Then Begin
   ConvertNote:=4;
   System.Close(SndFile);
   System.Close(WavFile);
   Erase(WavFile);
   Exit;
  End;
  Dec(BytesLeft,BytesWritten);
 End;
 System.Close(WavFile);
End;

Procedure Snd2Wav(Source,Target:String);
Var
 SndFile:File;
 NumNotes:Byte;
 Rate:Word;
 Note:Byte;
 NoteList:NoteArray;
 X:Byte;
Begin
 If IsNewSnd(Source)Then X:=ReadNewHeader(Source,SndFile,Rate,NumNotes,NoteList)
                    Else X:=ReadSndheader(Source,SndFile,Rate,NumNotes,NoteList);
 Case(X)of
  3:Begin
   ErrNoMsgOk(ErrInvalidFileHeader);
   Exit;
  End;
  6:Begin
   __FileNotFound(Source);
   Exit;
  End;
  7:Begin
   __UnknownCompress;
   Exit;
  End;
  8:Begin
   ErrNoMsgOk(ErrInvalidFileData);
   Exit;
  End;
 End;
 For Note:=1to(NumNotes)do Begin
  Case ConvertNote(SndFile,Target,Rate,Note,NoteList)of
   1:Begin
    __CreateError(Target);
    Break;
   End;
   2:Begin
    ErrNoMsgOk(ErrNoSamplesInSoundFile);
    Break;
   End;
   3:Begin
    ErrNoMsgOk(ErrInvalidFileHeader);
    Break;
   End;
   4:Begin
    __DiskFull;
    Break;
   End;
   5:Begin
    ErrNoMsgOk(ErrCorruptFile);
    Break;
   End;
  End;
 End;
 System.Close(SndFile);
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
END.