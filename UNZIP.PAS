Unit Unzip;

{$I DEF.INC}
{$IFNDEF __Windows__}
 {$Define assembler}
{$ENDIF}

{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�}
                                  INTERFACE
{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�}

Uses
 Systex;

Type
 PLongint=^Longint;

Const
 TFileBufferSize=High(Word)-16;
 TFileNameSize=79;

Type
 BufType=Array[0..TFileBufferSize]of Char;
 TDirType=Array[0..TFileNameSize]of Char;
 TZipRec=Record
  Buf:^BufType;
  BufSize,
  LocalStart:Word;
  Time:LongInt;
  Size:LongInt;
  CompressSize:LongInt;
  HeaderOffset:LongInt;
  FileName:TDirType;
  PackMethod:Word;
  Attr:Byte;
  DirFile:File;
 End;
 PReportRec=^TReportRec;
 TReportRec=Record
  FileName:TDirType;
  Time:LongInt;
  Size:LongInt;
  CompressSize:LongInt;
  Attr:Integer;
  PackMethod:Word;
  Ratio:Byte;
  Status:LongInt;
  IsaDir:Boolean;
 End;

Const
 fileStarting=-1000;
 fileUnzipping=-1001;
 fileCompleted=-1002;
 fileFailure=-1003;

Type
 pUnzipReportProc=^UnzipReportProc;
 UnzipReportProc=Procedure(Retcode:LongInt;Rec:PReportRec);
 pUnzipQuestionProc=^UnzipQuestionProc;
 UnzipQuestionProc=Function(Rec:PReportRec):Boolean;

Const
 ezOk=0;
 ezCRCErr=16001;
 ezWriteErr=16002;
 ezReadErr=16003;
 ezZipFileErr=16004;
 ezUserAbort=16005;
 ezNotSupported=16006;
 ezEncrypted=16007;
 ezInUse=16008;
 ezInternalError=16009;
 ezNoMoreItems=16010;
 ezFileError=16011;
 ezNotZipfile=16012;
 ezHeaderTooLarge=16013;
 ezZipFileOpenError=16014;
 ezSeriousError=16100;
 ezMissingParameter=16500;
 ezStarting=17004;
 ezCompleted=17005;

 huftComplete=0;
 huftIncomplete=1;
 huftError=2;
 huftOutOfMem=3;
 MaxMax=31*1024;
 wsize=$8000;
 INBUFSIZ=1024*4;
 lbits:Integer=9;
 dbits:Integer=6;
 b_Max=16;
 n_Max=288;
 BMAX=16;

 MaxCode=8192;
 MaxStack=8192;
 InitialCodeSize=9;
 FinalCodeSize=13;
 WriteMax=WSize-3*(MaxCode-256)-MaxStack-2;

Type
 Prev=Array[257..MaxCode]of Integer;
 PPrev=^Prev;
 cds=Array[257..MaxCode]of Char;
 pcds=^cds;
 StackType=Array[0..MaxStack]of Char;
 PStackType=^StackType;
 WriteBufType=Array[0..WriteMax]of Char;
 PWriteBufType=^WriteBufType;

Type
 push=^Word;
 PushList=^ushList;
 ushlist=Array[0..MaxMax]of Word;
 piobuf=^iobuf;
 iobuf=Array[0..InBufSiz-1]of Byte;
 pphuft=^phuft;
 phuft=^huft;
 phuftlist=^huftlist;
 huft=Record
  e,
  b:Byte;
  v_n:Word;
  v_t:phuftList;
 End;
 HuftList=Array[0..8190]of Huft;

 PLocalHeader=^TLocalHeader;
 TLocalHeader=Packed Record
  Signature:Array[0..3]of Char;  {'PK'#1#2}
  ExtractVer,
  BitFlag,
  ZipType:Word;
  FileTimeDate,
  CRC32:LongInt;
  CompressSize,
  UncompressSize:LongInt;
  FilenameLen,
  ExtraFieldLen:Word;
 End;

Type
 ZipClass=Record
  Slide:PChar;
  InBuf:IOBuf;
  InPos,ReadPos:Integer;
  DlgHandle:Word;
  DlgNotify:Integer;
  W:Word;
  B:LongInt;
  k:Byte;
  InFile:Hdl;
  OutFile:File;
  CompSize:LongInt;
  ReachedSize:LongInt;
  UnCompSize:LongInt;
  Crc32val:LongInt;
  HuftType:Word;
  TotalAbort:Boolean;
  ZipEOF:Boolean;
  InUse:Boolean;
  ZipReport:UnzipReportProc;
  ZipQuestion:UnzipQuestionProc;
  ZipRec:TReportRec;
  ShowPercent:Procedure(Pour:Byte);
  NoRecurseDirs:Boolean;
  LowcaseFileNames:Boolean;
  PreviousCode:PPrev;
  ActualCode:pcds;
  Stack:PStackType;
  WriteBuf:PWriteBufType;
  NextFree:Integer;
  WritePtr:Integer;
 End;

Procedure UnzipInit(Var Q:ZipClass);
Function  StripPath(Const S:String):String;
Function  CalcRatio(NewSize,OrgSize:LongInt):LongInt;
Procedure ConvertPath(P:PChar);
Function  FileUnzip(Var Q:ZipClass;Const SourceZipFile,TargetDirectory,FileSpecs:String;
                    Report:UnzipReportProc;Question:UnzipQuestionProc):Integer;
Function  FileUnzipEx(Var Q:ZipClass;Const SourceZipFile,TargetDirectory,FileSpecs:String):Integer;
Function  ViewZip(Var Q:ZipClass;Const SourceZipFile,FileSpecs:String;Report:UnzipReportProc):Integer;
Function  SetUnZipReportProc(Var Q:ZipClass;aProc:UnzipReportProc):Pointer;
Function  SetUnZipQuestionProc(Var Q:ZipClass;aProc:UnzipQuestionProc):Pointer;
Function  UnZipSize(Var Q:ZipClass;Const SourceZipFile:String;Var Compressed:LongInt):LongInt;
Function  SetNoRecurseDirs(Var Q:ZipClass;DontRecurse:Boolean):Boolean;
Function  GetHeaderOffset(Const FileName:String;PEndoffSet:PLongint):Longint;
Function  GetSupportedMethods:LongInt;
Function  UnzipFile(Var Q:ZipClass;Const InName:String;OutName:String;
                    Offset:Longint;hFileAction:Word;CmIndex:Integer):Integer;
Function  GetFirstInZip(Const ZipFileName:String;Var ZPRec:TZipRec):Integer;
Function  GetNextInZip(Var Zprec:TZiprec):Integer;
Function  IsZip(FileName:String;Var StartOffSet:Longint):Boolean;
Procedure CloseZipFile(Var Zprec:TZipRec);
Procedure UnzipDone(Var Q:ZipClass);

{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�}
                               IMPLEMENTATION
{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�}

Uses
 Memories,Systems
 {$IFDEF __Windows__}
  ,Windows
 {$ENDIF};

Function StripPath(Const S:String):String;
Var
 I,J:Integer;
Begin
 StripPath:=S;
 J:=Length(S);
 For I:=J downto 1do Begin
  If S[I]in['\',':','/']Then Begin
   StripPath:=Copy(S,Succ(I),J-I);
   Exit;
  End;
 End;
End;

Function CalcRatio(NewSize,OrgSize:LongInt):LongInt;Begin
 If NewSize>MaxLongint div 100Then Begin
  NewSize:=NewSize div 100;
  OrgSize:=OrgSize div 100;
 End;
 If OrgSize=0Then CalcRatio:=0
             Else CalcRatio:=100-((NewSize*100)div orgsize);
End;

Procedure ConvertPath(P:PChar);
Var
 I,Len:LongInt;
Begin
 Len:=StrLen(PChr(P));
 For I:=1to(Len)do If P[I]='/'Then P[I]:='\';
End;

Const
 fmOpenRead=$0000;
 fmOpenWrite=$0001;
 fmOpenReadWrite=$0002;
 fmShareCompat=$0000;
 fmShareExclusive=$0010;
 fmShareDenyWrite=$0020;
 fmShareDenyRead=$0030;
 fmShareDenyNone=$0040;
 FileModeCompat=fmOpenRead or fmShareDenyNone;

Function ExtractFileDir(Const aName:String):String;
Var
 I:Word;
Begin
 I:=Length(aName);
 While Not(aName[I]in['\',':'])and(I<>0)do Dec(I);
 If I=0Then ExtractFileDir:=''Else
 If I=1Then ExtractFileDir:=Left(GetCurrentDir,3)
       Else ExtractFileDir:=Left(aName,I)
End;

Function DirectoryExists(Const S:String):Boolean;
Var
 Attr:Word;
Begin
 Attr:=FileGetAttr(S);
 DirectoryExists:=(Attr>=0)and(Attr and faDir<>0);
End;

Const
 MaskBits:Array[0..16]of Word=(
  $0000, $0001, $0003, $0007, $000F, $001F, $003F, $007F, $00FF,
  $01FF, $03FF, $07FF, $0FFF, $1FFF, $3FFF, $7FFF, $FFFF
 );
 Border:Array[0..18]of Byte=(
  16, 17, 18, 0, 8, 7, 9, 6, 10, 5, 11, 4, 12, 3, 13, 2, 14, 1, 15
 );
 cplens:Array[0..30]of Word=(
  3, 4, 5, 6, 7, 8, 9, 10, 11, 13, 15, 17, 19, 23, 27, 31,
  35, 43, 51, 59, 67, 83, 99, 115, 131, 163, 195, 227, 258, 0, 0
 );
 cplext:Array[0..30]of Word=(
  0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 2, 2, 2, 2,
  3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 0, 99, 99
 );
 cpdist:Array[0..29]of Word=(
  1, 2, 3, 4, 5, 7, 9, 13, 17, 25, 33, 49, 65, 97, 129, 193,
  257, 385, 513, 769, 1025, 1537, 2049, 3073, 4097, 6145,
  8193, 12289, 16385, 24577
 );
 cpdext:Array[0..29]of Word=(
  0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6,
  7, 7, 8, 8, 9, 9, 10, 10, 11, 11,
  12, 12, 13, 13
 );
 cplen2:Array[0..63]of Word=(
  2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17,
  18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34,
  35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51,
  52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65
 );
 cplen3:Array[0..63]of Word=(
  3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18,
  19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35,
  36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52,
  53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66
 );
 Extra:Array[0..63]of Word=(
  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  8
 );
 cpdist4:Array[0..63]of Word=(
  1, 65, 129, 193, 257, 321, 385, 449, 513, 577, 641, 705,
  769, 833, 897, 961, 1025, 1089, 1153, 1217, 1281, 1345, 1409, 1473,
  1537, 1601, 1665, 1729, 1793, 1857, 1921, 1985, 2049, 2113, 2177,
  2241, 2305, 2369, 2433, 2497, 2561, 2625, 2689, 2753, 2817, 2881,
  2945, 3009, 3073, 3137, 3201, 3265, 3329, 3393, 3457, 3521, 3585,
  3649, 3713, 3777, 3841, 3905, 3969, 4033
 );
 cpdist8:Array[0..63]of Word=(
  1, 129, 257, 385, 513, 641, 769, 897, 1025, 1153, 1281,
  1409, 1537, 1665, 1793, 1921, 2049, 2177, 2305, 2433, 2561, 2689,
  2817, 2945, 3073, 3201, 3329, 3457, 3585, 3713, 3841, 3969, 4097,
  4225, 4353, 4481, 4609, 4737, 4865, 4993, 5121, 5249, 5377, 5505,
  5633, 5761, 5889, 6017, 6145, 6273, 6401, 6529, 6657, 6785, 6913,
  7041, 7169, 7297, 7425, 7553, 7681, 7809, 7937, 8065
 );

Procedure UpdateCRC32(Var CRC:Longint;Var InBuf;InLen:LongInt);
Const
 CRC32Table:Array[0..255]of LongInt=(
   $00000000, $77073096, $ee0e612c, $990951ba, $076dc419, $706af48f, $e963a535, $9e6495a3,
   $0edb8832, $79dcb8a4, $e0d5e91e, $97d2d988, $09b64c2b, $7eb17cbd, $e7b82d07, $90bf1d91,
   $1db71064, $6ab020f2, $f3b97148, $84be41de, $1adad47d, $6ddde4eb, $f4d4b551, $83d385c7,
   $136c9856, $646ba8c0, $fd62f97a, $8a65c9ec, $14015c4f, $63066cd9, $fa0f3d63, $8d080df5,
   $3b6e20c8, $4c69105e, $d56041e4, $a2677172, $3c03e4d1, $4b04d447, $d20d85fd, $a50ab56b,
   $35b5a8fa, $42b2986c, $dbbbc9d6, $acbcf940, $32d86ce3, $45df5c75, $dcd60dcf, $abd13d59,
   $26d930ac, $51de003a, $c8d75180, $bfd06116, $21b4f4b5, $56b3c423, $cfba9599, $b8bda50f,
   $2802b89e, $5f058808, $c60cd9b2, $b10be924, $2f6f7c87, $58684c11, $c1611dab, $b6662d3d,
   $76dc4190, $01db7106, $98d220bc, $efd5102a, $71b18589, $06b6b51f, $9fbfe4a5, $e8b8d433,
   $7807c9a2, $0f00f934, $9609a88e, $e10e9818, $7f6a0dbb, $086d3d2d, $91646c97, $e6635c01,
   $6b6b51f4, $1c6c6162, $856530d8, $f262004e, $6c0695ed, $1b01a57b, $8208f4c1, $f50fc457,
   $65b0d9c6, $12b7e950, $8bbeb8ea, $fcb9887c, $62dd1ddf, $15da2d49, $8cd37cf3, $fbd44c65,
   $4db26158, $3ab551ce, $a3bc0074, $d4bb30e2, $4adfa541, $3dd895d7, $a4d1c46d, $d3d6f4fb,
   $4369e96a, $346ed9fc, $ad678846, $da60b8d0, $44042d73, $33031de5, $aa0a4c5f, $dd0d7cc9,
   $5005713c, $270241aa, $be0b1010, $c90c2086, $5768b525, $206f85b3, $b966d409, $ce61e49f,
   $5edef90e, $29d9c998, $b0d09822, $c7d7a8b4, $59b33d17, $2eb40d81, $b7bd5c3b, $c0ba6cad,
   $edb88320, $9abfb3b6, $03b6e20c, $74b1d29a, $ead54739, $9dd277af, $04db2615, $73dc1683,
   $e3630b12, $94643b84, $0d6d6a3e, $7a6a5aa8, $e40ecf0b, $9309ff9d, $0a00ae27, $7d079eb1,
   $f00f9344, $8708a3d2, $1e01f268, $6906c2fe, $f762575d, $806567cb, $196c3671, $6e6b06e7,
   $fed41b76, $89d32be0, $10da7a5a, $67dd4acc, $f9b9df6f, $8ebeeff9, $17b7be43, $60b08ed5,
   $d6d6a3e8, $a1d1937e, $38d8c2c4, $4fdff252, $d1bb67f1, $a6bc5767, $3fb506dd, $48b2364b,
   $d80d2bda, $af0a1b4c, $36034af6, $41047a60, $df60efc3, $a867df55, $316e8eef, $4669be79,
   $cb61b38c, $bc66831a, $256fd2a0, $5268e236, $cc0c7795, $bb0b4703, $220216b9, $5505262f,
   $c5ba3bbe, $b2bd0b28, $2bb45a92, $5cb36a04, $c2d7ffa7, $b5d0cf31, $2cd99e8b, $5bdeae1d,
   $9b64c2b0, $ec63f226, $756aa39c, $026d930a, $9c0906a9, $eb0e363f, $72076785, $05005713,
   $95bf4a82, $e2b87a14, $7bb12bae, $0cb61b38, $92d28e9b, $e5d5be0d, $7cdcefb7, $0bdbdf21,
   $86d3d2d4, $f1d4e242, $68ddb3f8, $1fda836e, $81be16cd, $f6b9265b, $6fb077e1, $18b74777,
   $88085ae6, $ff0f6a70, $66063bca, $11010b5c, $8f659eff, $f862ae69, $616bffd3, $166ccf45,
   $a00ae278, $d70dd2ee, $4e048354, $3903b3c2, $a7672661, $d06016f7, $4969474d, $3e6e77db,
   $aed16a4a, $d9d65adc, $40df0b66, $37d83bf0, $a9bcae53, $debb9ec5, $47b2cf7f, $30b5ffe9,
   $bdbdf21c, $cabac28a, $53b39330, $24b4a3a6, $bad03605, $cdd70693, $54de5729, $23d967bf,
   $b3667a2e, $c4614ab8, $5d681b02, $2a6f2b94, $b40bbe37, $c30c8ea1, $5a05df1b, $2d02ef8d
);
Var
 BytePtr:^Byte;
 WCount:Word;
 aCRC:Longint;
Begin
 aCRC:=CRC;
 BytePtr:=Addr(InBuf);
 For WCount:=1to(InLen)do Begin
  aCRC:=CRC32Table[Byte(aCRC xor LongInt(BytePtr^))]xor((aCRC shr 8)and$00ffffff);
  Inc(BytePtr);
 End;
 CRC:=aCRC;
End;

Procedure InitCRC32(Var CRC:Longint);Begin
 CRC:=-1;
End;

Function FinalCRC32(CRC:Longint):Longint;Begin
 FinalCRC32:=Not CRC;
End;

Procedure UpdateCRC(Var Q:ZipClass;Var s:iobuf;Len:Integer);Begin
 UpdateCRC32(Q.Crc32val,s,len);
End;

Procedure MessageLoop(Var Q:ZipClass);
Var
 K:Word;
Begin
 If(KeyPress)Then Begin
  K:=ReadKey;
  If(K=Q.DlgNotify)Then Q.TotalAbort:=True;
 End;
 If(@Q.ShowPercent<>NIL)Then Begin
  Q.ShowPercent(Q.ReachedSize*100 div Q.CompSize);
 End;
End;

Procedure ReadBuf(Var Q:ZipClass);Begin
 If Q.ReachedSize>Q.CompSize+2Then Begin
  Q.ReadPos:=SizeOf(Q.InBuf);
  Q.ZipEOF:=True
 End
  Else
 Begin
  MessageLoop(Q);
  Q.ReadPos:=_GetRec(Q.InFile,SizeOf(Q.InBuf),Q.InBuf);
  If(SysErr<>0)or(Q.ReadPos=0)Then Begin
   Q.ReadPos:=SizeOf(Q.InBuf);
   Q.ZipEOF:=True;
  End;
  Inc(Q.ReachedSize,Q.ReadPos);
  Dec(Q.ReadPos);
 End;
 Q.Inpos:=0;
End;

Function ReadByte(Var Q:ZipClass):Byte;Begin
 If(Q.Inpos>Q.ReadPos)Then ReadBuf(Q);
 ReadByte:=Q.Inbuf[Q.Inpos];
 Inc(Q.Inpos);
End;

Procedure NeedBits(Var Q:ZipClass;N:Byte);
Var
 nb:LongInt;
 D:Word;
Begin
 {$IFNDEF Assembler}
  While(Q.k<n)do Begin
   If(Q.InPos>Q.ReadPos)Then ReadBuf(Q);
   nb:=Q.InBuf[Q.InPos];
   Inc(Q.Inpos);
   Q.b:=Q.b OR nb SHL Q.k;
   Inc(Q.k,8);
  End;
 {$ELSE}
  ASM
   CLD
   LES DI,Q
   MOV SI,Offset ZipClass.InBuf
   ADD SI,DI
   MOV CH,n
   MOV CL,ES:[DI].ZipClass.K
   MOV BX,ES:[DI].ZipClass.InPos
@again:
   CMP CL,CH
   JAE @Finished
   CMP BX,ES:[DI].ZipClass.ReadPos
   JG @ReadBuf
@FullBuf:
   MOV AL,ES:[SI+BX] {DX:AX=NB}
   XOR AH,AH
   XOR DX,DX
   CMP CL,8
   JAE @Bigger8
   SHL AX,CL
   JMP @Continue
@Bigger8:
   MOV D,CX
   MOV AH,AL
   XOR AL,AL
   SUB CL,8
@Rotate:
   OR CL,CL
   JZ @Continue1
   SHL AH,1
   RCL DX,1
   DEC CL
   JMP @Rotate
@Continue1:
   MOV CX,D
@Continue:
   OR  Word Ptr ES:[DI].ZipClass.B[2],DX
   OR  Word Ptr ES:[DI].ZipClass.B[0],AX
   INC BX
   ADD CL,8
   JMP @Again
@ReadBuf:
   PUSH ES
    PUSH DI
     PUSH SI
      PUSH CX
       PUSH ES
       PUSH DI
       CALL ReadBuf
      POP CX
     POP SI
    POP DI
   POP ES
   MOV BX,ES:[DI].ZipClass.InPos
   JMP @FullBuf
@Finished:
   MOV ES:[DI].ZipClass.K,CL
   MOV ES:[DI].ZipClass.InPos,BX
  END;
 {$ENDIF}
End;

Procedure DumpBits(Var Q:ZipClass;N:Byte);Begin
 {$IFNDEF Assembler}
  Q.b:=Q.b shr N;
  Q.k:=Q.k-N;
 {$ELSE}
  ASM
   LES DI,Q
   MOV CL,N
   MOV AX,Word Ptr ES:[DI].ZipClass.B[0]
   MOV DX,Word Ptr ES:[DI].ZipClass.B[2]
   MOV CH,CL
   JCXZ @Finished
@Rotate:
   SHR DX,1
   RCR AX,1
   DEC CH
   JNZ @Rotate
@Finished:
   MOV Word Ptr ES:[DI].ZipClass.B[0],AX
   MOV Word Ptr ES:[DI].ZipClass.B[2],DX
   SUB ES:[DI].ZipClass.K,CL
  END;
{$ENDIF}
END;

Function Flush(Var Q:ZipClass;w:LongInt):Boolean;
Var
 {$IFDEF __Windows__}
  n:LongInt;
 {$ELSE}
  n:Word;
 {$ENDIF}
 b:Boolean;
Begin
 BlockWrite(Q.OutFile,Q.Slide[0],w,n);
 b:=(n=w)and(IOResult=0);
 UpdateCRC(Q,IOBuf(Pointer(@Q.Slide[0])^),w);
 If(b)and(@Q.ZipReport<>NIL)Then Begin
  Q.ZipRec.Status:=fileUnzipping;
  Q.ZipReport(n,@Q.ZipRec);
 End;
 Flush:=b;
End;

Var
 _Token:PChar;

Function StrTok(Source:PChar;Token:Char):PChar;
Var
 P:PChr;
Begin
 If(Source<>NIL)Then _Token:=Source;
 If(_Token=NIL)Then Begin
  StrTok:=NIL;
  Exit
 End;
 P:=StrScan(PChr(_Token),Token);
 StrTok:=_Token;
 If(P<>NIL)Then Begin
  P^[0]:=#0;
  Inc(P);
 End;
 _Token:=PChar(P);
End;

Procedure HuftFree(t:phuftlist);
Var
 p,q:PHuftList;
 z:Integer;
Begin
 P:=Pointer(t);
 While(P<>NIL)do Begin
  Dec(LongInt(P),SizeOf(Huft));
  q:=p^[0].v_t;
  z:=p^[0].v_n;
  FreeMemory(p,(z+1)*SizeOf(Huft));
  p:=q;
 End;
End;

Function HuftBuild(b:pword;n,s:Word;d,e:PushList;t:pphuft;Var m:Integer):Integer;
Var
 a:Word;
 c:Array[0..b_max+1]of Word;
 f:Word;
 g,
 h:Integer;
 i,
 j:Word;
 k:Integer;
 p:PWord;
 QP:PHuftList;
 r:Huft;
 u:Array[0..b_max]of PHuftList;
 v:Array[0..n_max]of Word;
 w:Integer;
 x:Array[0..b_max+1]of Word;
 l:Array[-1..b_max+1]of Word;
 xp:PWord;
 y:Integer;
 z:Word;
 TryAgain:Boolean;
 pt:PHuft;
 el:Word;
Begin
 If n>256Then el:=PWord(LongInt(b)+256*SizeOf(Word))^
         Else el:=BMAX;
 FillClr(c,SizeOf(c));
 p:=b;i:=n;
 Repeat
  If(p^>b_max)Then Begin
   T^:=NIL;
   m:=0;
   HuftBuild:=huftError;
   Exit
  End;
  Inc(c[p^]);
  Inc(LongInt(p),SizeOf(Word));
  Dec(i);
 Until i=0;
 If(c[0]=n)Then Begin
  t^:=NIL;
  m:=0;
  HuftBuild:=huftComplete;
  Exit
 End;
 j:=1;
 While(j<=b_max)and(c[j]=0)do Inc(J);
 k:=j;
 If(m<j)Then m:=j;
 i:=b_max;
 While(I>0)and(c[i]=0)do Dec(i);
 g:=i;
 If(m>i)Then m:=i;
 y:=1 SHL j;
 While(j<i)do Begin
  Dec(Y,C[J]);
  If y<0Then Begin
   HuftBuild:=huftError;
   Exit
  End;
  y:=y shl 1;
  Inc(j);
 End;
 Dec(y,c[i]);
 If y<0Then Begin
  HuftBuild:=huftError;
  Exit
 End;
 Inc(c[i],y);
 x[1]:=0;
 j:=0;
 p:=PWord(@c);
 Inc(LongInt(p),SizeOf(Word));
 xp:=pword(@x);
 Inc(LongInt(xp),2*SizeOf(Word));
 Dec(i);
 While i<>0do Begin
  Inc(j,p^);
  xp^:=j;
  Inc(LongInt(p),2);
  Inc(LongInt(xp),2);
  Dec(i);
 End;
 p:=b;i:=0;
 Repeat
  j:=p^;
  Inc(LongInt(p),SizeOf(Word));
  If j<>0Then Begin
   v[x[J]]:=I;
   Inc(x[J]);
  End;
  Inc(I);
 Until I>=n;
 x[0]:=0;I:=0;
 p:=PWord(@v);
 h:=-1;
 l[-1]:=0;
 w:=0;
 u[0]:=NIL;
 QP:=NIL;
 z:=0;
 For K:=K to(G)do Begin
  For a:=c[k]downto 1do Begin
   While k>w+l[h]do Begin
    Inc(w,l[h]);
    Inc(h);
    z:=g-w;
    If(z>m)Then z:=m;
    j:=k-w;
    f:=1 shl j;
    If f>a+1Then Begin
     Dec(f,a+1);
     xp:=@c[k];
     Inc(j);
     TryAgain:=True;
     While(j<z)and(TryAgain)do Begin
      f:=f shl 1;
      Inc(LongInt(xp),SizeOf(Word));
      If f<=xp^Then TryAgain:=False
       Else
      Begin
       Dec(f,xp^);
       Inc(j);
      End;
     End;
    End;
    If(w+j>el)and(w<el)Then j:=el-w;
    If w=0Then j:=m;
    z:=1shl j;
    l[h]:=j;
    QP:=MemNew((Z+1)*SizeOf(Huft));
    If(QP=NIL)Then Begin
     If h<>0Then HuftFree(Pointer(u[0]));
     HuftBuild:=huftOutOfMem;
     Exit
    End;
    QP^[0].v_n:=z;
    t^:=@QP^[1];
    t:=pphuft(@QP^[0].v_t);
    t^:=NIL;
    QP:=phuftlist(@QP^[1]);
    u[h]:=QP;
    If h<>0Then Begin
     x[h]:=i;
     r.b:=l[h-1];
     r.e:=16+j;
     r.v_t:=QP;
     j:=(i and((1 shl w)-1))shr(w-l[h-1]);
     pt:=phuft(LongInt(u[h-1])-SizeOf(huft));
     If(j>pt^.v_n)Then Begin
      HuftFree(Pointer(u[0]));
      HuftBuild:=huftError;
      Exit
     End;
     pt:=@u[h-1]^[j];
     pt^:=r;
    End;
   End;
   r.b:=Word(k-w);
   r.v_t:=NIL;
   If LongInt(p)>=LongInt(@v[n])Then r.e:=99 Else
   If(p^<s)Then Begin
    If p^<256Then r.e:=16
             Else r.e := 15;
    r.v_n := p^;
    Inc(LongInt(p),SizeOf(Word));
   End
    Else
   Begin
    If(d=NIL)or(e=NIL)Then Begin
     HuftFree(Pointer(u[0]));
     HuftBuild:=huftError;
     Exit
    End;
    r.e:=Word(e^[p^-s]);
    r.v_n:=d^[p^-s];
    Inc(LongInt(p),SizeOf(Word));
   End;
   f:=1shl(k-w);
   j:=i shr w;
   While(j<z)do Begin
    QP^[j]:=r;
    Inc(j,f);
   End;
   j:=1shl(k-1);
   While(i and j)<>0do Begin
    i:=i xor j;
    j:=j shr 1;
   End;
   i:=i xor j;
   While((i and((1 shl w)-1))<>x[h])do Begin
    Dec(h);
    Dec(w,l[h]);
   End;
  End;
 End;
 If(y<>0)and(g<>1)Then HuftBuild:=huftIncomplete
                  Else HuftBuild:=huftComplete;
End;

Function InflateCodes(Var Q:ZipClass;tl,td:PHuftList;bl,bd:Integer):Integer;
Var
 n,d,e1,
 ml,md:Word;
 t:phuft;
 e:Byte;
Begin
 ml:=MaskBits[bl];
 md:=MaskBits[bd];
 While Not(Q.TotalAbort or Q.ZipEOF)do Begin
  NeedBits(Q,bl);
  t:=@tl^[Q.b and ml];
  e:=t^.e;
  If e>16Then Repeat
   If e=99Then Begin
    InflateCodes:=ezZipFileErr;
    Exit
   End;
   DumpBits(Q,t^.b);
   Dec(e,16);
   NeedBits(Q,e);
   t:=@t^.v_t^[Q.b and MaskBits[e]];
   e:=t^.e;
  Until e<=16;
  DumpBits(Q,t^.b);
  If e=16Then Begin
   Q.Slide[Q.W]:=Char(t^.v_n);
   Inc(Q.W);
   If(Q.W=WSize)Then Begin
    If Not Flush(Q,Q.W)Then Begin
     InflateCodes:=ezWriteErr;
     Exit;
    End;
    Q.W:=0
   End;
  End
   Else
  Begin
   If e=15Then Begin
    InflateCodes:=ezOk;
    Exit;
   End;
   NeedBits(Q,e);
   n:=t^.v_n+(Q.b and MaskBits[e]);
   DumpBits(Q,e);
   NeedBits(Q,bd);
   t:=@td^[Q.b and md];
   e:=t^.e;
   If e>16Then Repeat
    If e=99Then Begin
     InflateCodes:=ezZipFileErr;
     Exit
    End;
    DumpBits(Q,t^.b);
    Dec(e,16);
    NeedBits(Q,e);
    t:=@t^.v_t^[Q.b and MaskBits[e]];
    e:=t^.e;
   Until e<=16;
   DumpBits(Q,t^.b);
   NeedBits(Q,e);
   d:=Q.W-t^.v_n-Q.b and MaskBits[e];
   DumpBits(Q,e);
   Repeat
    d:=d and(WSize-1);
    If(d>Q.W)Then e1:=WSize-d
             Else e1:=WSize-Q.W;
    If(e1>n)Then e1:=n;
    Dec(n,e1);
    If(Q.W-d>=e1)Then Begin
     Move(Q.Slide[d],Q.Slide[Q.W],e1);
     Inc(Q.W,e1);
     Inc(d,e1);
    End
     Else
    Repeat
     Q.Slide[Q.W]:=Q.Slide[d];
     Inc(Q.W);
     Inc(d);
     Dec(e1);
    Until e1=0;
    If(Q.W=WSize)Then Begin
     If Not Flush(Q,Q.W)Then Begin
      InflateCodes:=ezWriteErr;
      Exit;
     End;
     Q.W:=0;
    End;
   Until n=0;
  End;
 End;
 If(Q.TotalAbort)Then InflateCodes:=ezUserAbort
                 Else InflateCodes:=ezReadErr;
End;

Function InflateStored(Var Q:ZipClass):Integer;
Var
 n:Word;
Begin
 n:=Q.k and 7;
 DumpBits(Q,n);
 NeedBits(Q,16);
 n:=Q.b and $FFFF;
 DumpBits(Q,16);
 NeedBits(Q,16);
 If n<>(Not Q.b)and$FFFFThen Begin
  InflateStored:=ezZipFileErr;
  Exit
 End;
 DumpBits(Q,16);
 While(n>0)and Not(Q.TotalAbort or Q.ZipEOF)do Begin
  Dec(n);
  NeedBits(Q,8);
  Q.Slide[Q.W]:=Char(Q.b);
  Inc(Q.W);
  If(Q.W=WSize)Then Begin
   If Not Flush(Q,Q.W)Then Begin
    InflateStored:=ezWriteErr;
    Exit
   End;
   Q.W:=0;
  End;
  DumpBits(Q,8);
 End;
 If(Q.TotalAbort)Then InflateStored:=ezUserAbort Else
 If(Q.ZipEOF)Then InflateStored:=ezReadErr
           Else InflateStored:=ezOk;
End;

Function InflateFixed(Var Q:ZipClass):Integer;
Var
 i:Integer;
 tl,td:phuftlist;
 bl,bd:Integer;
 L:Array[0..287]of Word;
Begin
 FillWord(L,SizeOf(L)shr 1,8);
 FillWord(L[144],112,9);
 FillWord(L[256],24,7);
 bl:=7;
 i:=HuftBuild(PWord(@l),288,257,PushList(@cplens),PushList(@cplext),pphuft(@tl ),bl);
 If(i<>huftComplete)Then Begin
  InflateFixed:=i;
  Exit
 End;
 FillWord(L,30,5);
 bd:=5;
 i:=HuftBuild(PWord(@l),30,0,PushList(@cpdist),PushList(@cpdext),pphuft(@td),bd);
 If(i>huftIncomplete)Then Begin
  HuftFree(tl);
  InflateFixed:=ezZipFileErr;
  Exit
 End;
 InflateFixed:=InflateCodes(Q,tl,td,bl,bd);
 HuftFree(tl);
 HuftFree(td);
End;

Function InflateDynamic(Var Q:ZipClass):Integer;
Var
 i:Integer;
 j,
 l,
 m,
 n:Word;
 tl,
 td:PHuftList;
 bl,bd:Integer;
 nb,nl,nd:Word;
 ll:Array[0..288+32-1]of Word;
Begin
 NeedBits(Q,5);
 nl:=257+Word(Q.b)and$1F;
 DumpBits(Q,5);
 NeedBits(Q,5);
 nd:=1+Word(Q.b)and$1F;
 DumpBits(Q,5);
 NeedBits(Q,4);
 nb:=4+Word(Q.b)and$F;
 DumpBits(Q,4);
 If(nl>288)or(nd>32)Then Begin
  InflateDynamic:=1;
  Exit
 End;
 FillClr(ll,SizeOf(ll));
 For j:=0to nb-1do Begin
  NeedBits(Q,3);
  ll[Border[j]]:=Q.b and 7;
  DumpBits(Q,3);
 End;
 For J:=nb to 18do ll[Border[J]]:=0;
 bl:=7;
 i:=HuftBuild(PWord(@ll),19,19,NIL,NIL,pphuft(@tl),bl);
 If(i<>huftComplete)Then Begin
  If(i=HuftIncomplete)Then HuftFree(tl);
  InflateDynamic:=ezZipFileErr;
  Exit
 End;
 n:=nl+nd;
 m:=MaskBits[bl];
 i:=0;l:=0;
 While Word(i)<n do Begin
  NeedBits(Q,bl);
  td:=PHuftList(@tl^[Q.b and m]);
  j:=PHuft(td)^.b;
  DumpBits(Q,j);
  j:=PHuft(td)^.v_n;
  If j<16Then Begin
   l:=j;
   ll[i]:=l;
   Inc(i)
  End
   Else
  If j=16Then Begin
   NeedBits(Q,2);
   j:=3+Q.b and 3;
   DumpBits(Q,2);
   If(i+j>n)Then Begin
    InflateDynamic:=1;
    Exit
   End;
   While j>0do Begin
    ll[i]:=l;
    Dec(j);
    Inc(i);
   End;
  End
   Else
  If j=17Then Begin
   NeedBits(Q,3);
   j:=3+Q.b and 7;
   DumpBits(Q,3);
   If(i+j>n)Then Begin
    InflateDynamic:=1;
    Exit
   End;
   While j>0do Begin
    ll[i]:=0;
    Inc(i);
    Dec(j);
   End;
   l:=0;
  End
   Else
  Begin
   NeedBits(Q,7);
   j:=11+Q.b and $7F;
   DumpBits(Q,7);
   If(i+j>n)Then Begin
    InflateDynamic:=ezZipFileErr;
    Exit
   End;
   While j>0do Begin
    ll[i]:=0;
    Dec(j);
    Inc(i);
   End;
   l:=0;
  End;
 End;
 HuftFree(tl);
 bl:=lbits;
 i:=HuftBuild(PWord(@ll),nl,257,PushList(@cplens),PushList(@cplext),pphuft(@tl),bl);
 If(i<>huftComplete)Then Begin
  If(i=huftIncomplete)Then huftFree(tl);
  InflateDynamic:=ezZipFileErr;
  Exit
 End;
 bd:=dbits;
 i:=HuftBuild(PWord(@ll[nl]),nd,0,PushList(@cpdist),PushList(@cpdext),pphuft(@td),bd);
 If(i>HuftIncomplete)Then Begin
  If(i=huftIncomplete)Then huftFree(td);
  huftFree(tl);
  InflateDynamic:=ezZipFileErr;
  Exit
 End;
 InflateDynamic:=InflateCodes(Q,tl,td,bl,bd);
 HuftFree(tl);
 HuftFree(td);
End;

Function InflateBlock(Var Q:ZipClass;Var e:Integer):Integer;
Var
 t:Word;
Begin
 NeedBits(Q,1);
 e:=Q.b and 1;
 DumpBits(Q,1);
 NeedBits(Q,2);
 t:=Q.b and 3;
 DumpBits(Q,2);
 Case(t)of
  0:InflateBlock:=InflateStored(Q);
  1:InflateBlock:=InflateFixed(Q);
  2:InflateBlock:=InflateDynamic(Q);
  Else InflateBlock:=ezZipFileErr;
 End
End;

Function Inflate(Var Q:ZipClass):Integer;
Var
 e,
 r:integer;
Begin
 Q.InPos:=0;
 Q.ReadPos:=-1;
 Q.W:=0;
 Q.k:=0;
 Q.b:=0;
 Repeat
  r:=InflateBlock(Q,e);
  If r<>0Then Begin
   Inflate:=r;
   Exit
  End;
 Until e<>0;
 If Not Flush(Q,Q.W)Then Inflate:=ezWriteErr
                    Else Inflate:=ezOk;
End;

Function CopyStored(Var Q:ZipClass):Integer;
Var
 Readin:Longint;
 OutCnt:Word;
Begin
 While(Q.ReachedSize<Q.CompSize)and Not(Q.TotalAbort)do Begin
  Readin:=Q.CompSize-Q.ReachedSize;
  If(Readin>WSize)Then Readin:=WSize;
   OutCnt:=_GetRec(Q.InFile,Readin,Q.Slide[0]);
  If(OutCnt<>Readin)or(SysErr<>0)Then Begin
   CopyStored:=ezReadErr;
   Exit
  End;
  If Not Flush(Q,OutCnt)Then Begin
   CopyStored:=ezWriteErr;
   Exit
  End;
  Inc(Q.ReachedSize,OutCnt);
  MessageLoop(Q);
 End;
 If Not(Q.TotalAbort)Then CopyStored:=ezOk
                     Else CopyStored:=ezUserabort;
End;

Function GetTree(Var Q:ZipClass;l:PWord;n:Word):Integer;
Var
 i,k,j,b:Word;
 ByteBuf:Byte;
Begin
 ByteBuf:=ReadByte(Q);
 i:=ByteBuf;
 Inc(i);
 k:=0;
 Repeat
  ByteBuf:=ReadByte(Q);
  j:=ByteBuf;
  b:=(j and$F)+1;
  j:=((j and$F0)shr 4)+1;
  If(k+j>n)Then Begin
   GetTree:=4;
   Exit
  End;
  Repeat
   l^:=b;
   Inc(LongInt(l),SizeOf(Word));
   Inc(k);
   Dec(j);
  Until j=0;
  Dec(i);
 Until i=0;
 If(k<>n)Then GetTree:=4
         Else GetTree:=0;
End;

Function ExplodeLit8(Var Q:ZipClass;tb,tl,td:PHuftList;bb,bl,bd:Integer):Integer;
Var
 s:LongInt;
 e:Word;
 n,d:Word;
 w:Word;
 t:PHuft;
 mb,ml,md:Word;
 u:Word;
Begin
 Q.b:=0;Q.k:=0;w:=0;
 u:=1;
 mb:=MaskBits[bb];
 ml:=MaskBits[bl];
 md:=MaskBits[bd];
 s:=Q.UncompSize;
 While(s>0)and Not(Q.TotalAbort or Q.ZipEOF)do Begin
  NeedBits(Q,1);
  If Q.b and 1<>0Then Begin
   DumpBits(Q,1);
   Dec(s);
   NeedBits(Q,bb);
   t:=@tb^[(Not Q.b)and mb];
   e:=t^.e;
   If e>16Then Repeat
    If e=99Then Begin
     ExplodeLit8:=ezZipFileErr;
     Exit
    End;
    DumpBits(Q,t^.b);
    Dec(e,16);
    NeedBits(Q,e);
    t:=@t^.v_t^[(Not Q.b)and MaskBits[e]];
    e:=t^.e;
   Until e<=16;
   DumpBits(Q,t^.b);
   Q.Slide[w]:=Char(t^.v_n);
   Inc(w);
   If(w=WSize)Then Begin
    If Not Flush(Q,W)Then Begin
     ExplodeLit8:=ezWriteErr;
     Exit
    End;
    w:=0;u:=0;
   End;
  End
   Else
  Begin
   DumpBits(Q,1);
   NeedBits(Q,7);
   d:=Q.b and $7F;
   DumpBits(Q,7);
   NeedBits(Q,bd);
   t:=@td^[(Not Q.b)and md];
   e:=t^.e;
   If e>16Then Repeat
    If e=99Then Begin
     ExplodeLit8:=ezZipFileErr;
     Exit
    End;
    DumpBits(Q,t^.b);
    Dec(e,16);
    NeedBits(Q,e);
    t:=@t^.v_t^[(Not Q.b)and MaskBits[e]];
    e:=t^.e;
   Until e<=16;
   DumpBits(Q,t^.b);
   d:=w-d-t^.v_n;
   NeedBits(Q,bl);
   t:=@tl^[(Not Q.b)and ml];
   e:=t^.e;
   If e>16Then Repeat
    If e=99Then Begin
     ExplodeLit8:=ezZipFileErr;
     Exit
    End;
    DumpBits(Q,t^.b);
    Dec(e,16);
    NeedBits(Q,e);
    t:=@t^.v_t^[(Not Q.b)and MaskBits[e]];
    e:=t^.e;
   Until e<=16;
   DumpBits(Q,t^.b);
   n:=t^.v_n;
   If e<>0Then Begin
    NeedBits(Q,8);
    Inc(n,Byte(Q.b)and$FF);
    DumpBits(Q,8);
   End;
   Dec(s,n);
   Repeat
    d:=d and Pred(WSize);
    If(d>w)Then e:=WSize-d
           Else e:=WSize-w;
    If(e>n)Then e:=n;
    Dec(n,e);
    If(u<>0)and(w<=d)Then Begin
     FillClr(Q.Slide[w],e);
     Inc(w,e);
     Inc(d,e);
    End
     Else
    If(w-d>=e)Then Begin
     Move(Q.Slide[d],Q.Slide[w],e);
     Inc(w,e);
     Inc(d,e);
    End
     Else
    Repeat
     Q.Slide[w]:=Q.Slide[d];
     Inc(w);
     Inc(d);
     Dec(e);
    Until e=0;
    If(w=WSize)Then Begin
     If Not Flush(Q,W)Then Begin
      ExplodeLit8:=ezWriteErr;
      Exit
     End;
     w:=0;u:=0;
    End;
   Until n=0;
  End;
 End;
 If(Q.TotalAbort)Then ExplodeLit8:=ezUserAbort Else
 If Not Flush(Q,W)Then ExplodeLit8:=ezWriteErr Else
 If(Q.ZipEOF)Then ExplodeLit8:=ezReadErr
           Else ExplodeLit8:=ezOk;
End;

Function ExplodeLit4(Var Q:ZipClass;tb,tl,td:PHuftlist;bb,bl,bd:Integer):Integer;
Var
 s:LongInt;
 e:Word;
 n,d:Word;
 w:Word;
 t:PHuft;
 mb,ml,md:Word;
 u:Word;
Begin
 Q.b:=0;Q.k:=0;w:=0;u:=1;
 mb:=MaskBits[bb];
 ml:=MaskBits[bl];
 md:=MaskBits[bd];
 s:=Q.UncompSize;
 While(s>0)and Not(Q.TotalAbort or Q.ZipEOF)do Begin
  NeedBits(Q,1);
  If Q.b and 1<>0Then Begin
   DumpBits(Q,1);
   Dec(s);
   NeedBits(Q,bb);
   t:=@tb^[(Not Q.b)and mb];
   e:=t^.e;
   If e>16Then Repeat
    If e=99Then Begin
     ExplodeLit4:=ezZipFileErr;
     Exit
    End;
    DumpBits(Q,t^.b);
    Dec(e,16);
    NeedBits(Q,e);
    t:=@t^.v_t^[(Not Q.b)and MaskBits[e]];
    e:=t^.e;
   Until e<=16;
   DumpBits(Q,t^.b);
   Q.Slide[w]:=Char(t^.v_n);
   Inc(w);
   If(w=WSize)Then Begin
    If Not Flush(Q,W)Then Begin
     ExplodeLit4:=ezWriteErr;
     Exit
    End;
    w:=0;u:=0;
   End;
  End
   Else
  Begin
   DumpBits(Q,1);
   NeedBits(Q,6);
   d:=Q.b and$3F;
   DumpBits(Q,6);
   NeedBits(Q,bd);
   t:=@td^[(Not Q.b)and md];
   e:=t^.e;
   If e>16Then Repeat
    If e=99Then Begin
     ExplodeLit4:=ezZipFileErr;
     Exit
    End;
    DumpBits(Q,t^.b);
    Dec(e,16);
    NeedBits(Q,e);
    t:=@t^.v_t^[(Not Q.b)and MaskBits[e]];
    e:=t^.e;
   Until e<=16;
   DumpBits(Q,t^.b);
   d:=w-d-t^.v_n;
   NeedBits(Q,bl);
   t:=@tl^[(Not Q.b)and ml];
   e:=t^.e;
   If e>16Then Repeat
    If e=99Then Begin
     ExplodeLit4:=ezZipFileErr;
     Exit
    End;
    DumpBits(Q,t^.b);
    Dec(e,16);
    NeedBits(Q,e);
    t:=@t^.v_t^[(Not Q.b)and MaskBits[e]];
    e:=t^.e;
   Until e<=16;
   DumpBits(Q,t^.b);
   n:=t^.v_n;
   If e<>0Then Begin
    NeedBits(Q,8);
    Inc(n,Q.b and $FF);
    DumpBits(Q,8);
   End;
   Dec(s,n);
   Repeat
    d:=d and Pred(WSize);
    If(d>w)Then e:=WSize-d
           Else e:=WSize-w;
    If(e>n)Then e:=n;
    Dec(n,e);
    If(u<>0)and(w<=d)Then Begin
     FillClr(Q.Slide[w],e);
     Inc(w,e);
     Inc(d,e);
    End
     Else
    If(w-d>=e)Then Begin
     Move(Q.Slide[d],Q.Slide[w],e);
     Inc(w,e);
     Inc(d,e);
    End
     Else
    Repeat
     Q.Slide[w]:=Q.slide[d];
     Inc(w);
     Inc(d);
     Dec(e);
    Until e=0;
    If(w=WSize)Then Begin
     If Not Flush(Q,W)Then Begin
      ExplodeLit4:=ezWriteErr;
      Exit
     End;
     w:=0;u:=0;
    End;
   Until n=0;
  End;
 End;
 If(Q.TotalAbort)Then ExplodeLit4:=ezUserAbort Else
 If Not Flush(Q,W)Then ExplodeLit4:=ezWriteErr Else
 If(Q.ZipEOF)Then ExplodeLit4:=ezReadErr
           Else ExplodeLit4:=ezOk;
End;

Function ExplodeNoLit8(Var Q:ZipClass;tl,td:PHuftList;bl,bd:Integer):Integer;
Var
 s:LongInt;
 e:Word;
 n,d:Word;
 w:Word;
 t:phuft;
 ml,md:Word;
 u:Word;
Begin
 Q.b:=0;Q.k:=0;w:=0;
 u:=1;
 ml:=MaskBits[bl];
 md:=MaskBits[bd];
 s:=Q.UncompSize;
 While(s>0)and Not(Q.TotalAbort or Q.ZipEOF)do Begin
  NeedBits(Q,1);
  If Q.b and 1<>0Then Begin
   DumpBits(Q,1);
   Dec(s);
   NeedBits(Q,8);
   Q.Slide[w]:=Char(Q.b);
   Inc(w);
   If(w=WSize)Then Begin
    If Not Flush(Q,W)Then Begin
     ExplodeNolit8:=ezWriteErr;
     Exit
    End;
    w:=0;u:=0;
   End;
   DumpBits(Q,8);
  End
   Else
  Begin
   DumpBits(Q,1);
   NeedBits(Q,7);
   d:=Q.b and$7F;
   DumpBits(Q,7);
   NeedBits(Q,bd);
   t:=@td^[(Not Q.b)and md];
   e:=t^.e;
   If e>16Then Repeat
    If e=99Then Begin
     ExplodeNoLit8:=ezZipFileErr;
     Exit
    End;
    DumpBits(Q,t^.b);
    Dec(e,16);
    NeedBits(Q,e);
    t:=@t^.v_t^[(Not Q.b)and MaskBits[e]];
    e:=t^.e;
   Until e<=16;
   DumpBits(Q,t^.b);
   d:=w-d-t^.v_n;
   NeedBits(Q,bl);
   t:=@tl^[(Not Q.b)and ml];
   e:=t^.e;
   If e>16Then Repeat
    If e=99Then Begin
     ExplodeNoLit8:=ezZipFileErr;
     Exit
    End;
    DumpBits(Q,t^.b);
    Dec(e,16);
    NeedBits(Q,e);
    t:=@t^.v_t^[(Not Q.b)and MaskBits[e]];
    e:=t^.e;
   Until e<=16;
   DumpBits(Q,t^.b);
   n:=t^.v_n;
   If e<>0Then Begin
    NeedBits(Q,8);
    Inc(n,Q.b and $FF);
    DumpBits(Q,8);
   End;
   Dec(s,n);
   Repeat
    d:=d and Pred(WSize);
    If(d>w)Then e:=WSize-d
           Else e:=WSize-w;
    If(e>n)Then e:=n;
    Dec(n,e);
    If(u<>0)and(w<=d)Then Begin
     FillClr(Q.Slide[w],e);
     Inc(w,e);
     Inc(d,e);
    End
     Else
    If(w-d>=e)Then Begin
     Move(Q.Slide[d],Q.Slide[w],e);
     Inc(w,e);
     Inc(d,e);
    End
     Else
    Repeat
     Q.Slide[w]:=Q.Slide[d];
     Inc(w);
     Inc(d);
     Dec(e);
    Until e=0;
    If(w=WSize)Then Begin
     If Not Flush(Q,W)Then Begin
      ExplodeNoLit8:=ezWriteErr;
      Exit
     End;
     w:=0;u:=0;
    End;
   Until n=0;
  End;
 End;
 If(Q.TotalAbort)Then ExplodeNoLit8:=ezUserAbort Else
 If Not Flush(Q,W)Then ExplodeNoLit8:=ezWriteErr Else
 If(Q.ZipEOF)Then ExplodeNoLit8:=ezReadErr
           Else ExplodeNoLit8:=ezOk;
End;

Function ExplodeNoLit4(Var Q:ZipClass;tl,td:PHuftList;bl,bd:Integer):Integer;
Var
 s:LongInt;
 e:Word;
 n,d:Word;
 w:Word;
 t:PHuft;
 ml,md:Word;
 u:Word;
Begin
 Q.b:=0;Q.k:=0;w:=0;
 u:=1;
 ml:=MaskBits[bl];
 md:=MaskBits[bd];
 s:=Q.UncompSize;
 While(s>0)and Not(Q.TotalAbort or Q.ZipEOF)do Begin
  NeedBits(Q,1);
  If Q.b and 1<>0Then Begin
   DumpBits(Q,1);
   Dec(s);
   NeedBits(Q,8);
   Q.Slide[w]:=Char(Q.b);
   Inc(w);
   If(w=WSize)Then Begin
    If Not Flush(Q,W)Then Begin
     ExplodeNoLit4:=ezWriteErr;
     Exit
    End;
    w:=0;u:=0;
   End;
   DumpBits(Q,8);
  End
   Else
  Begin
   DumpBits(Q,1);
   NeedBits(Q,6);
   d:=Q.b and$3F;
   DumpBits(Q,6);
   NeedBits(Q,bd);
   t:=@td^[(Not Q.b)and md];
   e:=t^.e;
   If e>16Then Repeat
    If e=99Then Begin
     ExplodeNoLit4:=ezZipFileErr;
     Exit
    End;
    DumpBits(Q,t^.b);
    Dec(e,16);
    NeedBits(Q,e);
    t:=@t^.v_t^[(Not Q.b)and MaskBits[e]];
    e:=t^.e;
   Until e<=16;
   DumpBits(Q,t^.b);
   d:=w-d-t^.v_n;
   NeedBits(Q,bl);
   t:=@tl^[(Not Q.b)and ml];
   e:=t^.e;
   If e>16Then Repeat
    If e=99Then Begin
     ExplodeNolit4:=ezZipFileErr;
     Exit
    End;
    DumpBits(Q,t^.b);
    Dec(e,16);
    NeedBits(Q,e);
    t:=@t^.v_t^[(Not Q.b)and MaskBits[e]];
    e:=t^.e;
   Until e<=16;
   DumpBits(Q,t^.b);
   n:=t^.v_n;
   If e<>0Then Begin
    NeedBits(Q,8);
    Inc(n,Q.b and $FF);
    DumpBits(Q,8);
   End;
   Dec(s,n);
   Repeat
    d:=d and Pred(WSize);
    If(d>w)Then e:=WSize-d
           Else e:=WSize-w;
    If(e>n)Then e:=n;
    Dec(n,e);
    If(u<>0)and(w<=d)Then Begin
     FillClr(Q.Slide[w],e);
     Inc(w,e);
     Inc(d,e);
    End
     Else
    If(w-d>=e)Then Begin
     Move(Q.Slide[d],Q.Slide[w],e);
     Inc(w,e);
     Inc(d,e);
    End
     Else
    Repeat
     Q.Slide[w]:=Q.Slide[d];
     Inc(w);
     Inc(d);
     Dec(e);
    Until e=0;
    If(w=WSize)Then Begin
     If Not Flush(Q,W)Then Begin
      ExplodeNolit4:=ezWriteErr;
      Exit
     End;
     w:=0;u:=0;
    End;
   Until n=0;
  End;
 End;
 If(Q.TotalAbort)Then ExplodeNoLit4:=ezUserabort Else
 If Not Flush(Q,W)Then ExplodeNoLit4:=ezWriteErr Else
 If(Q.ZipEOF)Then ExplodeNoLit4:=ezReadErr
             Else ExplodeNoLit4:=ezOk;
End;

Function Explode(Var Q:ZipClass):Integer;
Var
 r:Integer;
 tb,tl,td:PHuftList;
 bb,bl,bd:Integer;
 l:Array[0..255]of Word;
Begin
 Q.InPos:=0;
 Q.ReadPos:=-1;
 bl:=7;
 If Q.CompSize>200000Then bd:=8
                     Else bd:=7;
 If Q.HuftType and 4<>0Then Begin
  bb:=9;
  r:=GetTree(Q,@l[0],256);
  If r<>0Then Begin
   Explode:=ezZipFileErr;
   Exit
  End;
  r:=HuftBuild(PWord(@l),256,256,NIL,NIL,pphuft(@tb),bb);
  If r<>0Then Begin
   If(r=huftIncomplete)Then HuftFree(tb);
   Explode:=ezZipFileErr;
   Exit
  End;
  r:=GetTree(Q,@l[0],64);
  If r<>0Then Begin
   HuftFree(tb);
   Explode:=ezZipFileErr;
   Exit
  End;
  r:=HuftBuild(PWord(@l),64,0,PushList(@cplen3),PushList(@Extra),pphuft(@tl),bl);
  If r<>0Then Begin
   If(r=huftIncomplete)Then HuftFree(tl);
   HuftFree(tb);
   Explode:=ezZipFileErr;
   Exit
  End;
  r:=GetTree(Q,@l[0],64);
  If r<>0Then Begin
   HuftFree(tb);
   HuftFree(tl);
   Explode:=ezZipFileErr;
   Exit
  End;
  If Q.HuftType and 2<>0Then Begin
   r:=HuftBuild(PWord(@l),64,0,PushList(@cpdist8),pushlist(@extra),pphuft(@td),bd);
   If r<>0Then Begin
    If(r=huftIncomplete)Then HuftFree(td);
    HuftFree(tb);
    HuftFree(tl);
    Explode:=ezZipFileErr;
    Exit
   End;
   r:=ExplodeLit8(Q,tb,tl,td,bb,bl,bd);
  End
   Else
  Begin
   r:=HuftBuild(PWord(@l),64,0,PushList(@cpdist4),PushList(@extra),pphuft(@td),bd);
   If r<>0Then Begin
    If(r=huftIncomplete)Then HuftFree(td);
    HuftFree(tb);
    HuftFree(tl);
    Explode:=ezZipFileErr;
    Exit
   End;
   r:=ExplodeLit4(Q,tb,tl,td,bb,bl,bd);
  End;
  HuftFree(td);
  HuftFree(tl);
  HuftFree(tb);
 End
  Else
 Begin
  r:=GetTree(Q,@l[0],64);
  If r<>0Then Begin
   Explode:=ezZipFileErr;
   Exit
  End;
  r:=HuftBuild(PWord(@l),64,0,PushList(@cplen2),PushList(@extra),pphuft(@tl),bl);
  If r<>0Then Begin
   If(r=huftIncomplete)Then HuftFree(tl);
   Explode:=ezZipFileErr;
   Exit
  End;
  r:=GetTree(Q,@l[0],64);
  If r<>0Then Begin
   HuftFree(tl);
   Explode:=ezZipFileErr;
   Exit
  End;
  If Q.HuftType and 2<>0Then Begin {8k}
   r:=HuftBuild(PWord(@l),64,0,PushList(@cpdist8),PushList(@extra),PPhuft(@td),bd);
   If r<>0Then Begin
    If(r=huftIncomplete)Then HuftFree(td);
    HuftFree(tl);
    Explode:=ezZipFileErr;
    Exit
   End;
   r:=ExplodeNoLit8(Q,tl,td,bl,bd);
  End
   Else
  Begin
   r:=HuftBuild(PWord(@l),64,0,PushList(@cpdist4),PushList(@extra),pphuft(@td),bd);
   If r<>0Then Begin
    If(r=huftIncomplete)Then HuftFree(td);
    HuftFree(tl);
    Explode:=ezZipFileErr;
    Exit
   End;
   r:=ExplodeNoLit4(Q,tl,td,bl,bd);
  End;
  HuftFree(td);
  HuftFree(tl);
 End;
 Explode:=r;
End;

Function UnshrinkFlush(Var Q:ZipClass):Boolean;
Var
 {$IFDEF __Windows__}
  n:LongInt;
 {$ELSE}
  n:Word;
 {$ENDIF}
 b:Boolean;
Begin
 BlockWrite(Q.OutFile,Q.WriteBuf^[0],Q.WritePtr,n);
 b:=(n=Q.WritePtr)and(IOResult=0);
 UpdateCRC(Q,IOBuf(Pointer(@Q.WriteBuf^[0])^),Q.WritePtr);
 If(b)and(@Q.ZipReport<>NIL)Then Begin
  With Q.ZipRec do Begin
   Status:=fileUnzipping;
   Q.ZipReport(n,@Q.ZipRec);
  End;
 End;
 UnshrinkFlush:=b;
End;

Function WriteChar(Var Q:ZipClass;c:Char):Boolean;Begin
 Q.WriteBuf^[Q.WritePtr]:=c;
 Inc(Q.WritePtr);
 If(Q.WritePtr>WriteMax)Then Begin
  WriteChar:=UnshrinkFlush(Q);
  Q.WritePtr:=0;
 End
  Else
 WriteChar:=True;
END;

Procedure ClearLeafNodes(Var Q:ZipClass);
Var
 pc,
 i,
 act_max_code:Integer;
 Previous:PPrev;
Begin
 Previous:=Q.PreviousCode;
 Act_Max_Code:=Q.NextFree-1;
 For I:=257to(Act_Max_Code)do Previous^[i]:=Previous^[i]or$8000;
 For I:=257to(Act_Max_Code)do Begin
  pc:=Previous^[i]and Not$8000;
  If pc>256Then Previous^[pc]:=Previous^[pc]and(Not$8000);
 End;
 pc:=-1;
 Q.NextFree:=-1;
 For I:=257to(act_max_code)do If Previous^[I]and$C000<>0Then Begin
  If pc<>-1Then Previous^[pc]:=-I
           Else Q.NextFree:=I;
  pc:=I;
 End;
 If pc<>-1Then Previous^[pc]:=-act_max_code-1;
End;

Function Unshrink(Var Q:ZipClass):Integer;
Var
 InCode:Integer;
 LastInCode:Integer;
 LastOutCode:Char;
 CodeSize:Byte;
 StackPtr,
 NewCode,
 CodeMask,
 I:Integer;
 a1,a2,a3,
 BitsToRead:LongInt;
Begin
 If(Q.CompSize=MaxLongint)Then Begin
  Unshrink:=ezNotSupported;
  Exit
 End;
 Q.InPos:=0;
 Q.ReadPos:=-1;
 Q.W:=0;
 Q.k:=0;
 Q.b:=0;
 a1:=SizeOf(Prev);
 a2:=SizeOf(Prev)+SizeOf(cds);
 a3:=SizeOf(Prev)+SizeOf(cds)+SizeOf(StackType);
 Q.PreviousCode:=PPrev(@Q.Slide[0]);
 Q.ActualCode:=pcds(@Q.Slide[a1]);
 Q.Stack:=PStackType(@Q.Slide[a2]);
 Q.WriteBuf:=PWriteBufType(@Q.Slide[a3]);
 FillClr(Q.Slide^,WSize);
 For I:=257to(MaxCode)do Q.PreviousCode^[I]:=-(I+1);
 Q.NextFree:=257;
 StackPtr:=MaxStack;
 Q.WritePtr:=0;
 CodeSize:=InitialCodeSize;
 CodeMask:=MaskBits[CodeSize];
 NeedBits(Q,CodeSize);
 InCode:=Q.b and CodeMask;
 DumpBits(Q,CodeSize);
 LastInCode:=InCode;
 LastOutCode:=Char(InCode);
 If Not WriteChar(Q,LastOutCode)Then Begin
  Unshrink:=ezWriteErr;
  Exit
 End;
 BitsToRead:=8*Q.CompSize-CodeSize;
 While Not Q.TotalAbort and(BitsToRead>=CodeSize)do Begin
  NeedBits(Q,CodeSize);
  InCode:=Q.b and CodeMask;
  DumpBits(Q,CodeSize);
  Dec(BitsToRead,CodeSize);
  If InCode=256Then Begin
   NeedBits(Q,CodeSize);
   InCode:=Q.b and CodeMask;
   DumpBits(Q,CodeSize);
   Dec(BitsToRead,CodeSize);
   Case(InCode)of
    1:Begin
     Inc(CodeSize);
     If(CodeSize>FinalCodeSize)Then Begin
      Unshrink:=ezZipFileErr;
      Exit
     End;
     CodeMask:=MaskBits[CodeSize];
    End;
    2:ClearLeafNodes(Q);
    Else Unshrink:=ezZipFileErr;
         Exit
   End;
  End
   Else
  Begin
   NewCode:=Incode;
   If InCode<256Then Begin
    LastOutCode:=Char(InCode);
    If Not WriteChar(Q,LastOutCode)Then Begin
     Unshrink:=ezWriteErr;
     Exit
    End;
   End
    Else
   Begin
    If Q.PreviousCode^[InCode]<0Then Begin
     Q.Stack^[StackPtr]:=LastOutCode;
     Dec(StackPtr);
     InCode:=LastIncode;
    End;
    While InCode>256do Begin
     Q.Stack^[StackPtr]:=Q.ActualCode^[Incode];
     Dec(StackPtr);
     Incode:=Q.PreviousCode^[InCode];
    End;
    LastOutCode:=Char(InCode);
    If Not WriteChar(Q,LastOutCode)Then Begin
     Unshrink:=ezWriteErr;
     Exit
    End;
    For I:=StackPtr+1to(MaxStack)do If Not WriteChar(Q,Q.Stack^[I])Then Begin
     Unshrink:=ezWriteErr;
     Exit
    End;
    StackPtr:=MaxStack;
   End;
   InCode:=Q.NextFree;
   If(InCode<=MaxCode)Then Begin
    Q.NextFree:=-Q.PreviousCode^[InCode];
    Q.PreviousCode^[InCode]:=LastIncode;
    Q.ActualCode^[InCode]:=LastOutCode;
   End;
   LastIncode:=NewCode;
  End;
 End;
 If(Q.TotalAbort)Then Unshrink:=ezUserAbort Else
 If UnshrinkFlush(Q)Then Unshrink:=ezOk
                    Else Unshrink:=ezWriteErr;
End;

Function GetSupportedMethods:LongInt;Begin
 GetSupportedMethods:=1+(1 shl 1)+(1 shl 6)+(1 shl 8);
  {stored, shrunk, imploded et deflated}
End;

Function UnzipFile(Var Q:ZipClass;Const InName:String;OutName:String;
                   Offset:Longint;hFileAction:Word;CmIndex:Integer):Integer;
Label Exit2,Exit3,Exit4;
Var
 Err:Integer;
 Header:PLocalHeader;
 Buf:TDirType;
 Buf0:Array[0..3]of Char;
 TimeDate:LongInt;
 OriginalCRC:LongInt;
 ZipType,aResult:Integer;
 p,p1:PChar;
 IsaDir:Boolean;
 Tmp:String;
 OldCurDir:String;
Begin
 Tmp:=OutName;
 Q.Slide:=MemNew(WSize);
 Q.InFile:=FileOpen(InName,fmRead);
 If(Q.InFile=errHdl)Then Begin
  UnzipFile:=ezZipFileOpenError;
  Goto Exit3;
 End;
 SetFilePos(Q.InFile,Offset);
 If SysErr<>0Then Begin
  UnzipFile:=ezReadErr;
  Goto Exit2;
 End;
 Header:=PLocalHeader(@Q.InBuf);
 _GetRec(Q.InFile,SizeOf(Header^),Header^);
 If SysErr<>0Then Begin
  UnzipFile:=ezZipFileErr;
  Goto Exit2;
 End;
 If StrLComp(@Header^.Signature,PChr(PChar('PK'#3#4)),4)<>0Then Begin
  UnzipFile:=ezZipFileErr;
  Goto Exit2;
 End;
 Inc(Offset,Header^.FileNameLen+Header^.ExtraFieldLen+SizeOf(TLocalHeader));
 TimeDate:=Header^.FileTimeDate;
 If Q.HuftType and 8=0Then Begin
  Q.CompSize:=Header^.CompressSize;
  Q.UncompSize:=Header^.UncompressSize;
  Originalcrc:=Header^.CRC32;
 End
  Else
 Begin
  Q.CompSize:=MaxLongint;
  Q.UncompSize:=MaxLongint;
  OriginalCRC:=0
 End;
 ZipType:=Header^.ZipType;     {0=stored, 6=imploded, 8=deflated}
 If(1 shl ZipType)and GetSupportedMethods=0Then Begin
  UnzipFile:=ezNotSupported;
  Goto Exit2;
 End;
 Q.HuftType:=Header^.BitFlag;
 If Q.HuftType and 1<>0Then Begin
  Unzipfile:=ezEncrypted;
  Goto Exit2;
 End;
 Q.ReachedSize:=0;
 SetFilePos(Q.InFile,Offset);
 Assign(Q.OutFile,Tmp);
 Rewrite(Q.OutFile,1);
 Err:=IOResult;
 ChgChr(OutName,'/','\');
 Isadir:=OutName[Length(OutName)]='\';
 If(Err<>0)or(Isadir)Then Begin
  OldCurDir:=GetCurrentDir;
  If(OldCurDir[Length(OldCurDir)]='\')and(Length(OldCurDir)>3)Then BackStr(OldCurDir);
  If IOResult<>0Then;
  StrPCopy(@Buf,OutName);
  P1:=PChar(StrRScan(@Buf,'\'));
  If(P1<>NIL)Then Inc(P1);
  P:=Strtok(Buf,'\');
  If(P<>NIL)and(P[1]=':')Then Begin
   StrCopy(@Buf0,PChr(PChar('c:\')));
   Buf0[0]:=P[0];
   ChDir(StrPas(@Buf0));
   If IOResult<>0Then;
   P:=Strtok(NIL,'\');
  End;
  While(P<>NIL)and(P<>P1)do Begin
   Tmp:=StrPas(PChr(p));
   ChDir(Tmp);
   Err:=IOResult;
   If Err<>0Then Begin
    MkDir(Tmp);
    Err:=IOResult;
    If Err=0Then Begin
     ChDir(Tmp);
     Err:=IOResult;
    End;
   End;
   If Err=0Then P:=Strtok(NIL,'\')
           Else P:=NIL;
  End;
  ChDir(OldCurDir);
  If IOResult<>0Then;
  If(IsaDir)Then Begin
   UnzipFile:=ezOk;
   Goto Exit2;
  End;
  ReWrite(Q.OutFile,1);
  Err:=IOResult;
 End;
 If Err<>0Then Begin
  Tmp:=ExtractFileDir(OutName);
  If(Tmp<>'')and(Not DirectoryExists(Tmp))Then Begin
   Err:=RecursiveMkDir(Tmp);
   If Err=0Then Begin
    ReWrite(Q.OutFile,1);
    Err:=IOResult;
   End;
  End;
  If Err<>0Then Begin
   UnzipFile:=ezWriteErr;
Exit2:
   FileClose(Q.InFile);
Exit3:
   FreeMemory(Q.Slide,WSize);
   Q.InUse:=False;
   Exit;
  End;
 End;
 Q.TotalAbort:=False;
 Q.ZipEOF:=False;
 Q.DlgHandle:=hFileAction;
 Q.DlgNotify:=CmIndex;
 InitCrc32(Q.crc32val);
 Case(ZipType)of
  0:aResult:=CopyStored(Q);
  1:aResult:=Unshrink(Q);
  6:aResult:=Explode(Q);
  8:aResult:=Inflate(Q);
  Else aResult:=ezNotSupported;
 End;
 Unzipfile:=aResult;
 If(aResult=ezOk)and(Q.HuftType and 8<>0)Then Begin
  DumpBits(Q,Q.k and 7);
  NeedBits(Q,16);
  Dumpbits(Q,16);
  NeedBits(Q,16);
  OriginalCRC:=(Q.b and$FFFF)shl 16;
  DumpBits(Q,16);
 End;
 FileClose(Q.InFile);
 Close(Q.OutFile);
 If IOResult<>0Then;
 Q.CRC32val:=FinalCrc32(Q.CRC32val);
 If aResult<>0Then Goto Exit4 Else
 If(OriginalCRC<>Q.crc32val)Then Begin
  Unzipfile:=ezCRCErr;
Exit4:
  Erase(Q.OutFile);
  If IOResult<>0Then;
 End
  Else
 Begin
  Reset(Q.OutFile);
  SetFTime(Q.OutFile,TimeDate);
  System.Close(Q.OutFile);
  If IOResult<>0Then;
 End;
 FreeMemory(Q.Slide,WSize);
 Q.InUse:=False;
End;

Const
 MainHeader:PChar='PK'#5#6;
 MaxBufSize=TFileBufferSize;

Type
 PMainHeader=^TMainHeader;
 TMainHeader=Packed Record
  Signature:Array[0..3]of Char; {'PK'#5#6}
  ThisDisk,
  CentralStartDisk,
  EntriesThisDisk,
  EntriesCentralDir:Word;
  HeadSize,
  HeadStart,
  CommentLen:LongInt;
  Unknown:Word;
 End;

 PHeader=^THeader;
 THeader=Packed Record
  Signature:Array[0..3]of Char; { 'PK'#1#2 }
  OSversion,
  OSmadeby:Byte;
  ExtractVer,
  BitFlag,
  ZipType:Word;
  FileTimeDate,
  Crc32,
  CompressSize,
  UncompressSize:LongInt;
  FileNameLen,
  ExtraFieldLen,
  FileCommentLen,
  DiskNumberStart,
  InternalAttr:Word;
  ExternalAttr:Array[0..3]of Byte;
  OffsetLocalHeader:LongInt;
 End;

Function FillOutRec(Var ZPRec:TZipRec):Integer;
Var
 Incr:LongInt;
 Header:PHeader;
 Offs:Word;
 Old:Char;
 {$IFDEF __Windows__}
  Err:LongInt;
 {$ELSE}
  Err:Word;
 {$ENDIF}
Begin
 With ZPRec do Begin
  Header:=PHeader(@Buf^[LocalStart]);
  If(BufSize>=MaxBufSize)Then Begin
   If((LocalStart+SizeOf(THeader))>BufSize)or
      (LocalStart+Header^.FileNameLen+Header^.ExtraFieldLen+
       Header^.FileCommentLen+SizeOf(THeader)>BufSize)Then Begin
    Move(Buf^[LocalStart],Buf^[0],BufSize-LocalStart);
    BlockRead(DirFile,Buf^[BufSize-LocalStart],LocalStart,Err);
    If(IOResult<>0)or(Err+LocalStart<SizeOf(THeader))Then Begin
     FillOutRec:=ezNoMoreItems;
     Exit
    End;
    LocalStart:=0;
    Header:=PHeader(@Buf^[LocalStart]);
   End;
  End;
  If(LocalStart+4<=BufSize)and(StrLComp(@Header^.Signature,@MainHeader,4)=0)Then Begin
   FillOutRec:=ezNoMoreItems;
   Exit
  End;
  If(LocalStart+SizeOf(Header)>BufSize)or
    (LocalStart+Header^.FileNameLen+Header^.ExtraFieldLen+
     Header^.FileCommentLen+SizeOf(THeader)>BufSize)or
    (StrLComp(@Header^.Signature,PChr(PChar('PK'#1#2)),4)<>0)Then Begin
   FillOutRec:=ezNoMoreItems;
   Exit
  End;
  Size:=Header^.UncompressSize;
  CompressSize:=Header^.CompressSize;
  If Header^.Osmadeby=0Then Attr:=Header^.ExternalAttr[0]
                       Else Attr:=0;
  Time:=Header^.FileTimeDate;
  HeaderOffset:=Header^.OffsetLocalHeader;
  PackMethod:=Header^.ZipType;
  Offs:=LocalStart+Header^.FileNameLen+SizeOf(Header^);
  Old:=Buf^[Offs];
  Buf^[Offs]:=#0;
  StrLCopy(@FileName,PChr(PChar(@Buf^[LocalStart+SizeOf(Header^)])),SizeOf(FileName)-1);
  Buf^[Offs]:=Old;
  ConvertPath(FileName);
  Incr:=Header^.FileNameLen+Header^.ExtraFieldLen+
        Header^.FileCommentLen+SizeOf(Header^);
  If Incr<=0Then Begin
   FillOutRec:=ezInternalError;
   Exit
  End;
  LocalStart:=LocalStart+Incr;
  FillOutRec:=ezOk;
 End;
End;

Function GetFirstInZip(Const ZipFileName:String;Var ZPRec:TZipRec):Integer;
Label Exit2,Exit3;
Var
 BufStart,HeaderStart,Start:LongInt;
 I:Word;
 {$IFDEF __Windows__}
  Err:LongInt;
 {$ELSE}
  Err:Word;
 {$ENDIF}
 MainH:TMainHeader;
Begin
 ZPRec.Buf:=NIL;
 Assign(ZPRec.DirFile,ZipFileName);
 Err:=FileMode;
 FileMode:=FileModeCompat;
 Reset(ZPRec.DirFile,1);
 FileMode:=Err;
 If IOResult<>0Then Begin
  GetFirstInZip:=ezFileError;
  Exit
 End;
 ZPRec.Size:=System.FileSize(ZPRec.DirFile);
 If ZPRec.Size=0Then Begin
  GetFirstInZip:=ezFileError;
  Goto Exit3;
 End;
 ZPRec.BufSize:=4096;
 If(ZPRec.Size>ZPRec.BufSize)Then BufStart:=ZPRec.Size-ZPRec.BufSize
  Else
 Begin
  BufStart:=0;
  ZPRec.BufSize:=ZPRec.Size;
 End;
 GetMem(ZPRec.Buf,ZPRec.BufSize+1);
 Start:=-1;
 Repeat
  Seek(ZPRec.DirFile,BufStart);
  If IOResult<>0Then Begin
   GetFirstInZip:=ezFileError;
   Goto Exit2;
  End;
  BlockRead(ZPRec.DirFile,ZPRec.Buf^,ZPRec.BufSize,Err);
  If(IOResult<>0)or(Err<>ZPRec.BufSize)Then Begin
   GetFirstInZip:=ezFileError;
   Goto Exit2;
  End;
  If BufStart=0Then Start:=MaxLongInt;{Break}
  For I:=ZPRec.BufSize-22downto 0do Begin
   If((ZPRec.Buf^[I]='P')and(ZPRec.Buf^[I+1]='K')and
      (ZPrec.Buf^[I+2]=#5)and(ZPRec.Buf^[I+3]=#6))Then Begin
    Start:=BufStart+I;
    Break;
   End;
  End;
  If Start=-1Then Begin
   Dec(BufStart,ZPRec.BufSize-22);
   If BufStart<0Then BufStart:=0;
  End;
 Until Start>=0;
 If(Start=MaxLongInt)Then Begin
  GetFirstInZip:=ezFileError;
  Goto Exit2;
 End;
 Move(ZPRec.Buf^[Start-BufStart],MainH,SizeOf(MainH));
 HeaderStart:=MainH.headstart;
 ZPRec.LocalStart:=0;
 FreeMemory(ZPRec.Buf,ZPRec.BufSize+1);
 If(ZPRec.LocalStart+SizeOf(THeader)>Start)Then Begin
  ZPRec.Buf:=NIL;
  GetFirstInZip:=ezInternalError;
  Goto Exit3;
 End;
 BufStart:=HeaderStart;
 Dec(Start,HeaderStart-4);
 If(Start>=MaxBufSize)Then ZPRec.BufSize:=MaxBufSize
                      Else ZPRec.BufSize:=Start;
 GetMem(ZPRec.Buf,ZPRec.BufSize+1);
 Seek(ZPRec.DirFile,BufStart);
 If IOResult<>0Then Begin
  GetFirstInZip:=ezFileError;
  Goto Exit2;
 End;
 BlockRead(ZPRec.DirFile,ZPRec.Buf^,ZPRec.BufSize,Err);
 If IOResult<>0Then Begin
  GetFirstInZip:=ezFileError;
Exit2:
  FreeMemory(ZPRec.Buf,ZPRec.BufSize+1);
  ZPRec.Buf:=NIL;
Exit3:
  System.Close(ZPRec.DirFile);
  Exit
 End;
 Err:=FilloutRec(ZPRec);
 If(Err<>ezOk)Then Begin
  CloseZipFile(ZPRec);
  GetFirstInZip:=Err;
  Exit
 End;
 GetFirstInZip:=Err;
End;

Function GetNextInZip(Var Zprec:tZiprec):Integer;
Var
 Err:Integer;
Begin
 If(ZPRec.Buf<>NIL)Then Begin
  Err:=FillOutRec(ZPRec);
  If(Err<>ezOk)Then CloseZipFile(ZPRec);
  GetNextInZip:=Err;
 End
  Else
 GetNextInZip:=ezNoMoreItems;
End;

Procedure CloseZipFile(Var ZPrec:tZiprec);Begin
 If(ZPRec.Buf<>NIL)Then Begin
  System.Close(ZPRec.DirFile);
  If IOResult<>0Then;
  FreeMemory(ZPRec.Buf,ZPRec.BufSize+1);
  ZPRec.Buf:=NIL
 End;
End;

Function IsZip(FileName:String;Var StartOffSet:LongInt):Boolean;
Var
 l,Err:Integer;
 Buf:Array[0..3]of Char;
 OldCurDir:String;
 j:LongInt;
Begin
 StartOffSet:=-1;
 GetDir(0,OldCurDir);
 Err:=IOResult;
 IsZip:=False;
 ChgChr(FileName,'/','\');
 If FileName[Length(FileName)]='\'Then BackStr(FileName);
 ChDir(FileName);
 If IOResult<>0Then Begin
  GetFile(FileName,0,SizeOf(Buf),Buf);
  If SysErr<>0Then Begin
   ChDir(OldCurDir);
   Err:=IOResult;
   Exit;
  End;
  ChDir(OldCurDir);
  If IOResult<>0Then;
  If Buf='PK'#3#4Then Begin
   IsZip:=True;
   StartOffSet:=0;
  End
   Else
  Begin
   J:=GetHeaderOffSet(FileName,NIL);
   IsZip:=J>0;
   StartOffSet:=J;
  End;
 End;
End;

Function GetHeaderOffset(Const FileName:String;PEndoffSet:PLongint):LongInt;
Const
 MaxBuf=63*1024;
Var
 Buffer:^TChar;
 F:File;
 j,k,l:LongInt;
 {$IFDEF __Windows__}
  I:LongInt;
 {$ELSE}
  I:Word;
 {$ENDIF}
 OldMode:Integer;
Begin
 GetHeaderOffSet:=-1;
 If Assigned(PEndoffSet)Then PEndOffSet^:=-1;
 If FileName=''Then Exit;
 Assign(f,FileName);
 OldMode:=FileMode;
 FileMode:=FileModeCompat;
 Reset(f,1);
 FileMode:=OldMode;
 If IOResult<>0Then Exit;
 l:=System.FileSize(f);
 If IOResult<>0Then;
 If Assigned(PEndoffSet)Then PEndoffSet^:=l;
 If l<5Then Begin
  System.Close(f);
  If IOResult<>0Then;
  Exit;
 End
  Else
 If(l>=MaxBuf)Then l:=Pred(MaxBuf);
 Dec(l,l div 4);
 GetMem(Buffer,l);
 BlockRead(f,Buffer^,l,i);
 If IOResult<>0Then;
 System.Close(f);
 If IOResult<>0Then;
 k:=-1;
 If(Buffer^[0]='P')and(Buffer^[1]='K')and(Buffer^[2]=#3)and(Buffer^[3]=#4)Then Begin
  k:=0;
  If Assigned(PEndoffSet)Then PEndoffSet^:=0;
 End
  Else
 Begin
  For j:=0to i-5do
   If(Buffer^[j]='P')and(Buffer^[j+1]='K')and(Buffer^[j+2]=#3)and(Buffer^[j+3]=#4)Then Begin
    k:=j;
    Break;
   End;
 End;
 If k<0Then If Assigned(pEndoffSet)Then pEndoffSet^:=-1;
 GetHeaderOffSet:=k;
 FreeMemory(Buffer,l);
End;

Procedure DummyReport(Retcode:LongInt;Rec:PReportRec);Begin
End;

Function FileUnzip(Var Q:ZipClass;Const SourceZipFile,TargetDirectory,FileSpecs:String;
                   Report:UnzipReportProc;Question:UnzipQuestionProc):Integer;
Var
 r:TZipRec;
 rc:Integer;
 Buf,
 Target:TDirType;
 StartOffSet,
 Count:LongInt;
 rSize,
 cSize:LongInt;
 s:String;
 b:Boolean;
Begin
 Count:=0;
 rSize:=0;
 cSize:=0;
 StartOffSet:=0;
 FileUnzip:=ezMissingParameter;
 If(SourceZipFile='')or(TargetDirectory='')Then Exit;
 StrPCopy(@Target,TargetDirectory);
 ConvertPath(Target);
 If(Target[0]<>#0)and(Target[StrLen(@Target)-1]<>'\')Then StrCatPas(@Target,'\');
 FileUnzip:=ezNotZipFile;
 If Not IsZip(SourceZipFile,StartOffset)Then Exit;
 FillClr(Q.ZipRec,SizeOf(Q.ZipRec));
 FileUnzip:=ezInternalError;
 rc:=GetFirstInZip(SourceZipFile,r);
 If(rc<>ezOk)Then Exit;
 If(@Report<>NIL)Then Begin
  Q.ZipRec.IsaDir:=False;
  StrPCopy(@Q.ZipRec.FileName,SourceZipFile);
  Q.ZipRec.Size:=UnZipSize(Q,SourceZipFile,Q.ZipRec.CompressSize);
  Q.ZipRec.Ratio:=CalcRatio(Q.ZipRec.CompressSize,Q.ZipRec.Size);
  Q.ZipRec.Status:=ezStarting;
  Report(Q.ZipRec.Status,@Q.ZipRec);
 End
  Else
 Report:=DummyReport;
 Q.ZipReport:=Report;
 While(rc=ezOk)do Begin
  If WildCardMatch(StrPas(@R.FileName),FileSpecs)Then Begin
   Inc(rSize,r.Size);
   Inc(cSize,r.CompressSize);
   Inc(R.HeaderOffset,StartOffSet);
   If(Q.LowcaseFileNames)Then StrLower(@R.FileName);
   StrCopy(@Buf,@Target);
   If(Q.NoRecurseDirs)Then Begin
    S:=StripPath(StrPas(@R.filename));
    StrCatPas(@Buf,S);
   End
    Else
   StrCat(@Buf,@r.FileName);
   S:=StrPas(@Buf);
   Q.ZipRec.IsaDir:=S[Length(S)]in['\','/'];
   Q.ZipRec.Time:=r.Time;
   Q.ZipRec.Size:=r.Size;
   Q.ZipRec.CompressSize:=r.CompressSize;
   StrCopy(@Q.ZipRec.FileName,@Buf);
   Q.ZipRec.PackMethod:=r.PackMethod;
   Q.ZipRec.Attr:=r.Attr;
   Q.ZipRec.Ratio:=CalcRatio(Q.ZipRec.CompressSize,Q.ZipRec.Size);
   Q.ZipRec.Status:=FileStarting;
   If(Q.ZipRec.IsaDir)and(Q.NoRecurseDirs)Then {}
   Else Q.ZipReport(Q.ZipRec.Status,@Q.ZipRec);
   b:=FileExist(StrPas(@Buf));
   If(@Question<>NIL)and(b)and(Question(@Q.ZipRec)=False)Then Begin
    rc:=ezOk;
    Q.ZipRec.Status:=fileUnzipping;
    Q.ZipRec.PackMethod:=9;
    Q.ZipReport(Q.ZipRec.Size,@Q.ZipRec);
   End
    Else
   Begin
    If(B)Then FileSetAttr(StrPas(@Buf),0);
    rc:=UnZipFile(Q,SourceZipFile,StrPas(@Buf),r.HeaderOffset,0,27);
    If(rc=ezOk)Then FileSetAttr(StrPas(@Buf),Q.ZipRec.Attr);
   End;
   If(rc=ezOk)Then Begin
    Inc(Count);
    Q.ZipRec.Status:=fileCompleted;
    If(Q.ZipRec.IsaDir)and(Q.NoRecurseDirs)Then {}
    Else Q.ZipReport(Q.ZipRec.Status,@Q.ZipRec);
   End
    Else
   Begin
    Q.ZipRec.Status:=fileFailure;
    Case(rc)of
     ezCRCErr,
     ezWriteErr,
     ezEncrypted,
     ezNotSupported:Q.ZipReport(rc,@Q.ZipRec);
     ezZipFileOpenError,ezReadErr,ezUserabort,
     ezFileError,ezInternalError,ezInUse,ezZipFileErr:Begin
      Q.ZipRec.Status:=rc;
      FileUnzip:=rc;
      Q.ZipReport(ezSeriousError,@Q.ZipRec);
      CloseZipFile(r);
      SetUnZipReportProc(Q,NIL);
      SetUnZipQuestionProc(Q,NIL);
      Exit;
     End;
    End;
    rc:=ezOk;
    {Continue;}
   End;
  End;
  rc:=GetNextInZip(r);
 End;
 CloseZipFile(r);
 Q.ZipRec.Time:=-1;
 Q.ZipRec.Attr:=-1;
 Q.ZipRec.PackMethod:=0;
 Q.ZipRec.Size:=rSize;
 Q.ZipRec.CompressSize:=cSize;
 StrPCopy(@Q.ZipRec.FileName,SourceZipFile);
 Q.ZipRec.Ratio:=CalcRatio(Q.ZipRec.CompressSize,Q.ZipRec.Size);
 Q.ZipRec.Status:=ezCompleted;
 Q.ZipReport(Q.ZipRec.Status,@Q.ZipRec);
 SetUnZipReportProc(Q,NIL);
 SetUnZipQuestionProc(Q,NIL);
 FileUnzip:=Count;
End;

Function FileUnzipEx(Var Q:ZipClass;Const SourceZipFile,TargetDirectory,FileSpecs:String):Integer;Begin
 FileUnzipEx:=FileUnzip(Q,SourceZipFile,TargetDirectory,FileSpecs,Q.ZipReport,Q.ZipQuestion);
End;

Function ViewZip(Var Q:ZipClass;Const SourceZipFile,FileSpecs:String;
                 Report:UnzipReportProc):Integer;
Var
 rc:Integer;
 r:TZipRec;
 Count:Integer;
 rSize,cSize:LongInt;
 l:LongInt;
Begin
 Count:=0;
 rSize:=0;
 cSize:=0;
 l:=0;
 Viewzip:=ezMissingParameter;
 If(SourceZipFile='')or(@Report=NIL)Then Exit;
 ViewZip:=ezNotZipFile;
 If Not IsZip(SourceZipFile,L)Then Exit;
 FillClr(Q.ZipRec,Sizeof(Q.ZipRec));
 ViewZip:=ezInternalError;
 rc:=GetFirstInZip(SourceZipFile,r);
 If(rc<>ezOk)Then Exit;
 If(@Report=NIL)Then Report:=DummyReport;
 While(rc=ezOk)do Begin
  If WildCardMatch(StrPas(@R.FileName),FileSpecs)Then Begin
   Inc(rSize,r.Size);
   Inc(cSize,r.CompressSize);
   If(Q.LowcaseFileNames)Then StrLower(@R.FileName);
   Q.ZipRec.Time:=r.Time;
   Q.ZipRec.Size:=r.Size;
   Q.ZipRec.CompressSize:=r.CompressSize;
   StrCopy(@Q.ZipRec.FileName,@r.Filename);
   Q.ZipRec.PackMethod:=r.PackMethod;
   Q.ZipRec.Attr:=r.Attr;
   Q.ZipRec.Ratio:=CalcRatio(Q.ZipRec.CompressSize,Q.ZipRec.Size);
   Q.ZipRec.Status:=fileUnzipping;
   Inc(Count);
   Report(rc,@Q.ZipRec);
  End;
  rc:=GetNextInZip(r);
 End;
 CloseZipFile(r);
 Q.ZipRec.Time:=-1;
 Q.ZipRec.Attr:=-1;
 Q.ZipRec.PackMethod:=0;
 Q.ZipRec.Size:=rSize;
 Q.ZipRec.CompressSize:=cSize;
 StrPCopy(@Q.ZipRec.FileName,SourceZipFile);
 Q.ZipRec.Ratio:=CalcRatio(Q.ZipRec.CompressSize,Q.ZipRec.Size);
 Q.ZipRec.Status:=ezCompleted;
 Report(Count,@Q.ZipRec);
 ViewZip:=Count;
End;

Function UnZipSize(Var Q:ZipClass;Const SourceZipFile:String;
                   Var Compressed:LongInt):LongInt;
Var
 rc:Integer;
 r:TZipRec;
 Count:LongInt;
 f:File;
 Offset:LongInt;
Begin
 Compressed:=0;
 UnZipSize:=0;
 If SourceZipFile=''Then Exit;
 Assign(f,SourceZipFile);
 Count:=FileMode;
 FileMode:=FileModeCompat;
 Reset(f,1);
 FileMode:=Count;
 If IOResult<>0Then Exit;
 Count:=System.FileSize(f);
 System.Close(f);
 UnZipSize:=Count;
 Compressed:=Count;
 Offset:=0;
 If Not IsZip(SourceZipFile,Offset)Then Exit;
 Count:=0;
 Compressed:=0;
 rc:=GetFirstInZip(SourceZipFile,r);
 If(rc<>ezOk)Then Exit;
 While(rc=ezOk)do Begin
  Inc(Count,r.Size);
  Inc(Compressed,r.CompressSize);
  rc:=GetNextInZip(r);
 End;
 CloseZipFile(r);
 UnZipSize:=Count;
End;

Function SetUnZipReportProc;Begin
 SetUnZipReportProc:=@Q.ZipReport;
 Q.ZipReport:=aProc;
End;

Function SetUnZipQuestionProc;Begin
 SetUnZipQuestionProc:=@Q.ZipQuestion;
 Q.ZipQuestion:=aProc;
End;

Function SetNoRecurseDirs;Begin
 SetNoRecurseDirs:=Q.NoRecurseDirs;
 Q.NoRecurseDirs:=DontRecurse;
End;

Procedure UnzipInit(Var Q:ZipClass);Begin
 FillClr(Q,SizeOf(Q));
End;

Procedure UnzipDone(Var Q:ZipClass);Begin
 SetUnZipReportProc(Q,NIL);
 SetUnZipQuestionProc(Q,NIL);
End;

{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�}
END.