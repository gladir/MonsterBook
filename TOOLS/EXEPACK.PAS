{Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Ce programme r‚duit la taille des fichiers EXE en compressant la table
 d'entˆte en une structure plus petite. C'est l'‚quivalent du ExePack de
 Microsoft ou SpMaker de Realia.


 Nom des programmeurs
 ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

  Kim Kokkonen
  Sylvain Maltais
}
{$S-,I-,R-}

Program Pack;

Function StrUp(S:String):String;Var I:Byte;Begin
 For I:=1to Length(S)do S[I]:=UpCase(S[I]);
 StrUp:=S;
End;

{Cette foncion recherche et retourne la posiution du s‚parateur d'extension
 dans un chemin r‚pertoire.}
Function HasExtension(Name:String;Var DotPos:Word):Boolean;Var I:Word;Begin
 DotPos:=0;
 For I:=Length(Name)downto 1do If(Name[I]='.')and(DotPos=0)Then DotPos:=I;
 HasExtension:=(DotPos>0)and(Pos('\',Copy(Name,DotPos+1,64))=0);
End;

Function ForceExtension(Name,Ext:String):String;Var DotPos:Word;Begin
 If HasExtension(Name,DotPos)Then ForceExtension:=Copy(Name,1,DotPos)+Ext
                             else ForceExtension:=Name+'.'+Ext;
End;

Procedure Error(Msg:String);Begin
 If Msg<>''Then WriteLn(^M^J,Msg);
 Halt(1);
End;

Function BlkRead(Var F:File;Var Buffer;Size:Word):Boolean;Var BytesRead:Word;Begin
 BlockRead(F,Buffer,Size,BytesRead);
 BlkRead:=(IoResult=0)and(BytesRead=Size)
End;

Function BlkWrite(Var F:File;Var Buffer;Size:Word):Boolean;Var BytesWritten:Word;Begin
 BlockWrite(F,Buffer,Size,BytesWritten);
 BlkWrite:=(IoResult=0)and(BytesWritten=Size)
End;

Procedure PackExe(ExeName,OutName:String);
Const
 MaxRWbufSize=$8000;
 FlagWord=$FFFF;
 OrigIPofs=3;
 ShowRLEeffect=TRUE;
 Threshold=4;
 MaxReloc=$3FFC;
 NewLoaderSize=82;
 NewLoader:Array[1..NewLoaderSize]of Byte=(
    {C'est un DUMP du fichier assembleur NEWLOAD.ASM}
  $EB,$08,$00,$00,$00,$00,$00,$00,$00,$00,$2E,$8C,$1E,$06,$00,$2E,
  $8C,$06,$08,$00,$8C,$C3,$83,$C3,$10,$8C,$C8,$8E,$D8,$BE,$52,$00,
  $FC,$AD,$3D,$FF,$FF,$75,$0B,$AD,$3D,$FF,$FF,$74,$0C,$03,$C3,$8E,
  $C0,$AD,$8B,$F8,$26,$01,$1D,$EB,$E8,$2E,$8E,$06,$08,$00,$2E,$8E,
  $1E,$06,$00,$8B,$C3,$2E,$03,$06,$04,$00,$50,$2E,$A1,$02,$00,$50,
  $CB,$90);

Type
 ExeHeaderRec=Record
  Signature,LengthRem,LengthPages,NumReloc,HeaderSize:Word;
  MinHeap,MaxHeap,StackSeg,StackPtr,CheckSum,IpInit,CodeSeg:Word;
  RelocOfs,OverlayNum:Word;
 End;
 RelocRec=Record Offset,Segment:Word;End;
 RelocArray=Array[1..MaxReloc]of RelocRec;
 PackedTable=Array[1..$7FF0]of Word;
 ReadWriteBuffer=Array[1..MaxRWbufSize]of Byte;

Var
 ExeF,OutF:File;
 BytesRead,BytesWritten,RWbufSize,I,TableSize,TablePos,LastSeg,
 BlockSize,OldNumReloc,OldHeaderSize:Word;
 OldExeSize,ExeSize,RLEbytes:LongInt;
 LastByte:Byte;
 ExeHeader:ExeHeaderRec;
 RA:^RelocArray;
 PT:^PackedTable;
 RWbuf:^ReadWriteBuffer;

 Procedure SetTable(Var TA:PackedTable;Var TablePos:Word;Value:Word);Begin
  TA[TablePos]:=Value;Inc(TablePos)
 End;

Begin
 If StrUp(ExeName)=StrUp(OutName)Then Error('Fichiers d''entr‚e et de sortie diff‚rent');
 Assign(ExeF,ExeName);
 Reset(ExeF,1);
 If IoResult<>0Then Error(ExeName+' introuvable');
 If Not BlkRead(ExeF,ExeHeader,SizeOf(ExeHeaderRec))Then Error('Erreur de lecture du fichier EXE');
 With ExeHeader do Begin
  If Signature<>$5A4DThen Error('Ce fichier n''est pas de format EXE standard');
  If NumReloc=0Then Error('Ne peut pas ˆtre compacter. Pas de fichier de sortie ‚crit');
  If(NumReloc>MaxReloc)Then Error('Nombre d''items relog‚ excŠde la capacit‚ d''EXEPACK');
  If(NumReloc shl 2>MaxAvail)Then Error('M‚moire insufficiente');
  GetMem(RA,NumReloc shl 2);
  Seek(ExeF,RelocOfs);
  If Not BlkRead(ExeF,RA^,NumReloc shl 2)Then Error('Erreur de lecture du fichier EXE');
  LastSeg:=$FFFF;TableSize:=0;
  For I:=1to(NumReloc)do With RA^[I]do Begin
   If(Segment<>LastSeg)Then Begin;LastSeg:=Segment;Inc(TableSize,4)End;
   Inc(TableSize,2);
  End;
  Inc(TableSize,4);
  If(TableSize>MaxAvail)Then Error('M‚moire insufficiente');
  GetMem(PT,TableSize);
  LastSeg:=$FFFF;TablePos:=1;
  For I:=1to(NumReloc)do With RA^[I]do Begin
   If(Segment<>LastSeg)Then Begin
    LastSeg:=Segment;
    SetTable(PT^,TablePos,FlagWord);
    SetTable(PT^,TablePos,Segment);
   End;
   SetTable(PT^,TablePos,Offset);
  End;
  For I:=1to 2do SetTable(PT^,TablePos,FlagWord);
  FreeMem(RA,NumReloc shl 2);
  If(MaxAvail>MaxRWbufSize)Then RWbufSize:=MaxRWbufSize
                           else RWbufSize:=MaxAvail;
  GetMem(RWbuf,RWbufSize);
  OldNumReloc:=NumReloc;OldHeaderSize:=HeaderSize;
  If LengthRem=0Then OldExeSize:=LongInt(LengthPages)shl 9
                else OldExeSize:=(LongInt(LengthPages-1)shl 9)+LongInt(LengthRem);
  NumReloc:=0;HeaderSize:=(SizeOf(ExeHeaderRec)+15)shr 4;
  Move(IpInit,NewLoader[OrigIPofs],4);
  IpInit:=0;CodeSeg:=Succ(OldExeSize shr 4)-OldHeaderSize;
  ExeSize:=(LongInt(HeaderSize)+LongInt(CodeSeg))shl 4+
           LongInt(NewLoaderSize)+LongInt(TableSize);
  If(ExeSize>=OldExeSize)Then Error('Taille de compactage excŠde la taille original. Pas sortie ‚crite');
  If ExeSize and 511=0Then Begin;LengthPages:=ExeSize shr 9;LengthRem:=0;End
   else
  Begin
   LengthPages:=Succ(ExeSize shr 9);
   LengthRem:=ExeSize-LongInt(Pred(LongInt(LengthPages))shl 9);
  End;
  Assign(OutF,OutName);
  Rewrite(OutF,1);
  If IoResult<>0Then Error('Ne peut pas cr‚er '+OutName);
  If Not BlkWrite(OutF,ExeHeader,HeaderSize shl 4)Then Error('Erreur d''‚criture du fichier EXE');
  Seek(ExeF,OldHeaderSize shl 4);
  LastByte:=0;BlockSize:=0;RLEbytes:=00;
  Repeat
   BlockRead(ExeF,RWbuf^,RWbufSize,BytesRead);
   If IoResult<>0Then Error('Erreur de lecture du fichier EXE');
   If BytesRead<>0Then Begin
    If Not BlkWrite(OutF,RWbuf^,BytesRead)Then Error('Erreur d''‚criture du fichier EXE');
    If(ShowRLEeffect)Then For I:=1to(BytesRead)do If LastByte=RWbuf^[I]Then Inc(BlockSize)
     else
    Begin
     LastByte:=RWbuf^[I];
     If(BlockSize>Threshold)Then Inc(RLEbytes,BlockSize-Threshold);
     BlockSize:=0;
    End;
   End;
  Until BytesRead=0;
  If(ShowRLEeffect)and(BlockSize>Threshold)Then Inc(RLEbytes,BlockSize-Threshold);
  Seek(OutF,(LongInt(HeaderSize)+LongInt(CodeSeg))shl 4);
  If Not BlkWrite(OutF,NewLoader,NewLoaderSize)Then Error('Erreur d''‚criture du fichier EXE');
  If Not BlkWrite(OutF,PT^,TableSize)Then Error('Erreur d''‚criture du fichier EXE');
  If(ShowRLEeffect)Then WriteLn('AprŠs compression de l''entˆte du programme la longueur ‚conomis‚ est ',RLEbytes,' octets');
 End;
 FreeMem(PT,TableSize);
 FreeMem(RWbuf,RWbufSize);
 Close(ExeF);
 Close(OutF);
End;

BEGIN
 Writeln('EXEPACK  Tous droits r‚serv‚s par les Chevaliers de Malte  1997');
 If ParamCount<2Then Error('Usage: PACK AncienNomExe NouveauNomExe');
 PackExe(ForceExtension(ParamStr(1),'EXE'),ForceExtension(ParamStr(2),'EXE'));
END.
