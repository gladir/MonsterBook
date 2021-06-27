{$I DEF.INC}

Unit ResSaveI;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                 INTERFACE
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses Systex,ImageTex;

Function RISaveImage(Name:String;Page:Word;Var Q:XInf):Word;
Function RIWriteImage(Handle:Hdl;DefaultImage:Word;Page:Word;Var FilePos:LongInt;Var Q:XInf):Word;
Function RIPrintScreen(Const Name:String):Word;
Function _RISaveImage(Var Name:String;Page:Word;Var Q:XInf):Word;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                              IMPLEMENTATION
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses Adele,Math,ResTex,Dialex,Memories,Systems,Video;

Const
 hdlPrtScr=$80;

Type
 DataSaveRec=Record
  Name:String;
  Handle:Hdl;
  Res:ImageHeaderRes;
  FilePos:LongInt;
  Data:XInf;
 End;

Function ConvBit4PlanesMap(BytesPerLine:Word;Var Line:Array of Byte):Boolean;
Var
 XL:Array[0..7]of Byte;
 PPln:^TByte;
 Base,XBytes,BT,P1,P2,P3,P4:Word;
 IBit:Byte;
Begin
  { Transformation de 4 bits de couleurs lin‚aire
    en 4 planes de 1 bits de couleurs }
 PPln:=MemNew(BytesPerLine);
 If(PPln<>NIL)Then Begin
  XBytes:=BytesPerLine shr 2;BT:=0;P1:=0;
  P2:=XBytes;P3:=XBytes shl 1;P4:=P2+P3;
  For Base:=0to XBytes-1do Begin
   For IBit:=0to 3do Begin
    XL[((IBit)shl 1)+1]:=Line[BT]and$F;
    XL[((IBit)shl 1)]:=Line[BT] shr 4;
    Inc(BT);
   End;
   For IBit:=0to 7do Begin
    Inc(PPln^[P1],((XL[7-IBit]shr 0)and 1)shl IBit);
    Inc(PPln^[P2],((XL[7-IBit]shr 1)and 1)shl IBit);
    Inc(PPln^[P3],((XL[7-IBit]shr 2)and 1)shl IBit);
    Inc(PPln^[P4],((XL[7-IBit]shr 3)and 1)shl IBit);
   End;
   Inc(P1);Inc(P2);Inc(P3);Inc(P4);
  End;
  MoveLeft(PPln^,Line,BytesPerLine);
  FreeMemory(PPln,BytesPerLine);
  ConvBit4PlanesMap:=True;
 End
  Else
 ConvBit4PlanesMap:=False;
End;

Function Conv24to3PlanesMap(BytesPerLine:Word;Var Line:Array of Byte):Boolean;Near;
Var
 PPln:^TByte;
 Base,XBytes,P1,P2,P3:Word;
Begin
  { Transformation de 3 planes en BitMap }
 PPln:=MemAlloc(BytesPerLine);
 If(PPln<>NIL)Then Begin
  XBytes:=BytesPerLine div 3;P1:=0;P2:=XBytes;P3:=XBytes shl 1;
  For Base:=0to XBytes-1do Begin
   PPln^[P3]:=Line[P1];  Inc(P1);Inc(P3);
   PPln^[P2]:=Line[P1];  Inc(P1);Inc(P2);
   PPln^[Base]:=Line[P1];Inc(P1);
  End;
  MoveLeft(PPln^,Line,BytesPerLine);
  FreeMemory(PPln,BytesPerLine);
  Conv24to3PlanesMap:=True;
 End
  Else
 Conv24to3PlanesMap:=False;
End;

Procedure ResGetAbsRec(Var Q:XInf;FilePos:LongInt;Size:Word;Var Buffer);
Var
 Res:ImageHeaderRes Absolute Buffer;
Begin
 If(Q.Handle=hdlPrtScr)Then Begin
  If FilePos=0Then Begin
   FillClr(Res,Size);
   Res.ID:=idResImage;
   Res.BytesPerLine:=BytesPerLine;
   Res.NumXPixels:=GetNmXPixels;
   Res.NumYPixels:=GetNmYPixels;
   Res.BitsPerPixel:=BitsPerPixel;
   Res.Descr:='Impression de l''‚cran';
  End
   Else
  ReadBnk(FilePos-SizeOf(ImageHeaderRes),Size,Buffer);
 End
  Else
 XGetAbsRec(Q,FilePos,Size,Buffer);
End;

Function RISaveBGX(Var Q:DataSaveRec):Word;
Var
 BufImg:Array[0..4095]of Byte;
 FP,RS:LongInt;
 I:Word;
Begin
 RISaveBGX:=0;
 If Q.Res.BytesPerLine>SizeOf(BufImg)Then Begin
  RISaveBGX:=eriLineTooBig;
  Exit;
 End;
  {criture de l'entˆte du BGX - Format 1 }
 _PutFileTxtLn(Q.Handle,'BGX1');
 _SetAbsRec(Q.Handle,Q.FilePos+4,2*SizeOf(Word)+SizeOf(Byte),Q.Res.NumXPixels);
 FP:=Q.FilePos+9;RS:=SizeOf(Q.Res);
  { Sauvegarde de l'image }
 For I:=0to Q.Res.NumYPixels-1do Begin
  ResGetAbsRec(Q.Data,RS,Q.Res.BytesPerLine,BufImg);
  _SetAbsRec(Q.Handle,FP,Q.Res.BytesPerLine,BufImg);
  Inc(FP,Long(Q.Res.BytesPerLine));Inc(RS,Long(Q.Res.BytesPerLine));
 End;
End;

Function RISaveBMP(Var Q:DataSaveRec):Word;
Var
 BufImg:Array[0..4095]of Byte;
 BufWord:Array[0..2047]of Word Absolute BufImg;
 Header:HeaderBMP Absolute BufImg;
 BIH:BitmapInfoHeader Absolute BufImg;
 Palette:Array[0..255]of LongInt Absolute BufImg;
 FP,RS:LongInt;
 I,J:Word;                { Compteur de boucle }
 PalRGB:Palette256RGB;
Begin
 RISaveBMP:=0;
 If Q.Res.BytesPerLine>SizeOf(BufImg)Then Begin
  RISaveBMP:=eriLineTooBig;
  Exit;
 End;
  {criture de l'entˆte du BitMap Windows }
 FillClr(Header,SizeOf(Header));
 Header.Sign:='BM';
 Header.Size:=14;
 Header.Planes:=1;
 Header.BitCount:=Q.Res.BitsPerPixel;
 Header.SizeImage:=LongInt(Q.Res.BytesPerLine)*LongInt(Q.Res.NumYPixels);
 Header.NumXPixels:=Q.Res.NumXPixels;
 Header.NumYPixels:=Q.Res.NumYPixels;
 Header.OffBits:=14+SizeOf(BIH)+(Q.Res.NumPal shl 2);
 If Q.Res.NumPal=0Then Inc(Header.OffBits,Long((1 shl Q.Res.BitsPerPixel)shl 2));
 _SetAbsRec(Q.Handle,Q.FilePos,14,Header);
 FP:=Q.FilePos+14;
 FillClr(BIH,SizeOf(BIH));
 BIH.biSize:=SizeOf(BIH);
 BIH.biWidth:=Q.Res.NumXPixels;
 BIH.biHeight:=Q.Res.NumYPixels;
 BIH.biPlanes:=1;
 If Q.Res.BitsPerPixel=15Then BIH.biBitCount:=16
                         Else BIH.biBitCount:=Q.Res.BitsPerPixel;
 BIH.biSizeImage:=LongInt(Q.Res.BytesPerLine)*LongInt(Q.Res.NumYPixels);
 BIH.biXPelsPerMeter:=Q.Res.NumXPixels;
 BIH.biYPelsPerMeter:=Q.Res.NumYPixels;
 _SetAbsRec(Q.Handle,FP,SizeOf(BIH),BIH);
 Inc(FP,Long(SizeOf(BIH)));
  { criture de la palette de couleurs }
 RS:=SizeOf(Q.Res);
 If Q.Res.NumPal>0Then Begin
  ResGetAbsRec(Q.Data,RS+Long(Q.Res.BytesPerLine)*Long(Q.Res.NumYPixels),
               Q.Res.NumPal*3,PalRGB);
  For I:=0to Q.Res.NumPal-1do Begin
   Palette[I]:=RGB2Win32bits(PalRGB[I].B,PalRGB[I].G,PalRGB[I].R);
  End;
  _SetAbsRec(Q.Handle,FP,Q.Res.NumPal shl 2,Palette);
  Inc(FP,Long(Q.Res.NumPal shl 2));
 End
  Else
 Begin
  For I:=0to 255do Begin
   Palette[I]:=RGB2Win32bits(DefaultRGB[I and$F].B,DefaultRGB[I and$F].G,DefaultRGB[I and$F].R);
  End;
  _SetAbsRec(Q.Handle,FP,(1 shl Q.Res.BitsPerPixel)shl 2,Palette);
  Inc(FP,Long((1 shl Q.Res.BitsPerPixel)shl 2));
 End;
 RS:=Long(Long(SizeOf(Q.Res))+Long(Q.Res.BytesPerLine)*Long(Q.Res.NumYPixels));
  { Sauvegarde de l'image }
 For I:=0to Q.Res.NumYPixels-1do Begin
  Dec(RS,Long(Q.Res.BytesPerLine));
  ResGetAbsRec(Q.Data,RS,Q.Res.BytesPerLine,BufImg);
  If Q.Res.BitsPerPixel=16Then Begin
   For J:=0to Q.Res.NumXPixels-1do Begin
    BufWord[J]:=((BufWord[J]and 31))+
                (((BufWord[J]shr 6)and 31)shl 5)+
                (((BufWord[J]shr 11)and 31)shl 10);
   End;
  End;
  _SetAbsRec(Q.Handle,FP,Q.Res.BytesPerLine,BufImg);
  Inc(FP,Long(Q.Res.BytesPerLine));
 End;
End;

Function RISaveSCI(Var Q:DataSaveRec):Word;
Var
 BufImg:Array[0..4095]of Byte;
 FP,RS:LongInt;
 I:Word;
 Header:SCiHeader;
Begin
 RISaveSCI:=0;
 If Q.Res.BytesPerLine>SizeOf(BufImg)Then Begin
  RISaveSCI:=eriLineTooBig;
  Exit;
 End;
 If Q.Res.BitsPerPixel<>8Then Begin
  RISaveSCI:=eriNotCompatibleColor;
  Exit;
 End;
  {criture de l'entˆte du SCi (RIX) }
 FillClr(Header,SizeOf(Header));
 Header.Sign:='RIX3';
 Header.NumXPixels:=Q.Res.NumXPixels;
 Header.NumYPixels:=Q.Res.NumYPixels;
 Header.Reserved:=175;
 _SetAbsRec(Q.Handle,Q.FilePos,SizeOf(Header),Header);
 FP:=Q.FilePos+SizeOf(Header);RS:=SizeOf(Q.Res);
 ResGetAbsRec(Q.Data,RS+Long(Q.Res.BytesPerLine)*Long(Q.Res.NumYPixels),768,BufImg);
 _SetAbsRec(Q.Handle,FP,768,BufImg);
 Inc(FP,Long(768));
  { Sauvegarde de l'image }
 For I:=0to Q.Res.NumYPixels-1do Begin
  ResGetAbsRec(Q.Data,RS,Q.Res.BytesPerLine,BufImg);
  _SetAbsRec(Q.Handle,FP,Q.Res.BytesPerLine,BufImg);
  Inc(FP,Long(Q.Res.BytesPerLine));Inc(RS,Long(Q.Res.BytesPerLine));
 End;
End;

Function RISaveGIF(Var Q:DataSaveRec):Word;
Const
 BlcSize:Byte=125; {De 1 … 126}
Var
 Header:HeaderGIF;
 SubHeader:HeaderImageGIF;
 Buffer:Array[0..4095]of Byte;
 FP:LongInt;
 SizeImage:LongInt;            { Taille physique de l'image }
 PB:Word;
 AtPct:LongInt;
 CodeSize,ClearCode,EOFCode,FirstFree,FreeCode,
 InitCodeSize,Maxcode,Bitmask:Integer;
 GetByte:Byte;
 OutCount:Word;
 D,C,A:Byte;
 lblc,DateLng,DateLngCnt:Byte;
 Fnd:Boolean;
 Prefix:Array[0..256]of Byte;
 Suffix:Array[0..256]of Byte;
 Lng:Array[0..256]of Byte;
 OutCode:Array[0..512]of Byte;

 Function ReadAbs(Pos:LongInt):Byte;
 Var
  Buffer:Byte;
 Begin
  If Q.Res.BitsPerPixel=4Then Begin
   ResGetAbsRec(Q.Data,SizeOf(ImageHeaderRes)+(Pos shr 1),SizeOf(Byte),Buffer);
   If Odd(Pos)Then ReadAbs:=Buffer and $F
              Else ReadAbs:=Buffer shr 4;
  End
   Else
  Begin
   Inc(Pos,SizeOf(ImageHeaderRes));
   ResGetAbsRec(Q.Data,Pos,SizeOf(Byte),Buffer);
   ReadAbs:=Buffer;
  End;
 End;

 Procedure PushByte(Value:Byte);Begin
  Buffer[PB]:=Value;
  If PB>=SizeOf(Buffer)-1Then Begin
   _SetAbsRec(Q.Handle,FP,SizeOf(Buffer),Buffer);
   PB:=0;Inc(FP,LongInt(SizeOf(Buffer)));
  End
   Else
  Inc(PB);
 End;

 Procedure DumpBuf;Begin
  _SetAbsRec(Q.Handle,FP,PB,Buffer);
  Inc(FP,LongInt(PB));PB:=0;
 End;

Begin
 FillClr(Header,SizeOf(Header));
 Header.Sign:='GIF';
 Header.Ver:='87a';
 Header.NumXPixels:=Q.Res.NumXPixels;
 Header.NumYPixels:=Q.Res.NumYPixels;
 Header.ExtInfo:=(Q.Res.BitsPerPixel-1)and$7;
 If Q.Res.NumPal>0Then ASM OR Header.ExtInfo,080h;END;
 FP:=Q.FilePos;
 _SetAbsRec(Q.Handle,FP,SizeOf(Header),Header);
 Inc(FP,LongInt(SizeOf(Header)));
 If Q.Res.NumPal>0Then Begin
  _SetAbsRec(Q.Handle,Q.FilePos,Q.Res.NumPal*SizeOf(RGB),Buffer);
  Inc(FP,LongInt(Q.Res.NumPal*SizeOf(RGB)));
 End;
 SizeImage:=Mul2Word(Q.Res.NumXPixels,Q.Res.NumYPixels);
 FillClr(SubHeader,SizeOf(SubHeader));
 SubHeader.Seperator:=44;
 SubHeader.NumXPixels:=Q.Res.NumXPixels;
 SubHeader.NumYPixels:=Q.Res.NumYPixels;
 _SetAbsRec(Q.Handle,FP,SizeOf(SubHeader),SubHeader);
 Inc(FP,LongInt(SizeOf(SubHeader)));
 PB:=0;
 PushByte(7); { Taille du code? }
 AtPct:=0;
 While(AtPct<SizeImage)do Begin
  If(SizeImage-AtPct<=BlcSize)Then BlcSize:=SizeImage-AtPct-1;
  OutCount:=0;
  DateLngCnt:=0;
  DateLng:=0;
  CodeSize:=7;
  ClearCode:=128;
  EOFCode:=129;
  FirstFree:=130;
  FreeCode:=FirstFree;
  CodeSize:=CodeSize+1;
  InitCodeSize:=CodeSize;
  MaxCode:=256;
  BitMask:=127;
  Lng[FreeCode]:=0;
  Repeat
   C:=FreeCode;
   Repeat
    Dec(c);
    DateLngCnt:=Lng[c];
    fnd:=true;
    d:=c;
    If(d<FirstFree)Then fnd:=False;
    DateLng:=1;
    If(AtPct+1+DateLngCnt>SizeImage)Then Fnd:=False;
    While(d>=FirstFree)and(fnd)do Begin
     If Prefix[d]<>ReadAbs(AtPct+DateLngCnt)Then Fnd:=False;
     DateLng:=DateLng+1;
     DateLngCnt:=DateLngCnt-1;
     D:=suffix[D];
     If(D<=BitMask)Then If(ReadAbs(AtPct)<>D)Then Fnd:=False;
    End;
   Until(Fnd)or(C<FirstFree);
   If Not(Fnd)Then C:=ReadAbs(AtPct);
   OutCode[OutCount]:=c;
   Inc(OutCount);
   Inc(AtPct,DateLng);
   Prefix[FreeCode]:=ReadAbs(AtPct);
   Suffix[FreeCode]:=C;
   If(C>BitMask)Then Lng[FreeCode]:=Lng[c]+1
                Else Lng[FreeCode]:=1;
   Inc(FreeCode);
  Until OutCount>=BlcSize;
  If(AtPct>=SizeImage)Then Lblc:=2
                      Else Lblc:=1;
  PushByte(OutCount+lblc);              {Longueur du bloc}
  PushByte(ClearCode);                  {Code d'effacement}
  For A:=0to OutCount-1do PushByte(OutCode[A]);
 End;
 PushByte(EofCode);
 PushByte(0);
 PushByte(59);
 DumpBuf;
End;

Function RISavePCX(Var Q:DataSaveRec):Word;
Var
 Header:HeaderPCX;
 BufImg:Array[0..1279]of Byte;
 PBufImg:^TByte;
 SizeOfPBufImg:Word;
 Buf:Array[0..4095]of Byte;
 P,FP:LongInt;
 Count,Valeur,LastByt:Byte;
 I,J,PB:Word;
 BytesPerLine:Word; { Nombre d'octets par ligne … extraire? }

 Procedure PushByte(Value:Byte);Begin
  Buf[PB]:=Value;
  If PB>=SizeOf(Buf)-1Then Begin
   _SetAbsRec(Q.Handle,P,SizeOf(Buf),Buf);
   PB:=0;Inc(P,Long(SizeOf(Buf)));
  End
   Else
  Inc(PB);
 End;

 Procedure DumpBuf;Begin
  _SetAbsRec(Q.Handle,P,PB,Buf);
  Inc(P,Long(PB));PB:=0;
 End;

Begin
 RISavePCX:=0;
  {M‚moire de travail}
 PBufImg:=@BufImg;SizeOfPBufImg:=0;
 If Q.Res.BytesPerLine>SizeOf(BufImg)Then Begin
  SizeOfPBufImg:=Q.Res.BytesPerLine;
  PBufImg:=MemAlloc(SizeOfPBufImg);
  If(PBufImg=NIL)Then Begin
   RISavePCX:=eriLineTooBig;
   Exit;
  End;
 End;
 BytesPerLine:=Q.Res.BytesPerLine;
  {criture de l'entˆte}
 FillClr(Header,SizeOf(Header));
 Header.MagicID:=10;
 Header.Version:=5;
 Header.Encoding:=1;
 If Q.Res.BitsPerPixel=24Then Begin
  Header.BitsPerPixel:=8;
  Header.NumPlanes:=3;
  Header.BytesPerLinePerPlane:=(Q.Res.BytesPerLine div 3);
  Repeat
   Case Q.Res.BytesPerLine mod 3of
    1:Inc(BytesPerLine,2);
    2:Inc(BytesPerLine);
    Else Break;
   End;
   Inc(Header.BytesPerLinePerPlane);
  Until True;
 End
  Else
 Begin
  If Q.Res.BitsPerPixel=4Then Begin
   Header.BytesPerLinePerPlane:=Q.Res.NumXPixels shr 3;
   Header.BitsPerPixel:=1;
   Header.NumPlanes:=4;
  End
   Else
  Begin
   Header.BytesPerLinePerPlane:=Q.Res.BytesPerLine;
   Header.BitsPerPixel:=Q.Res.BitsPerPixel;
   Header.NumPlanes:=1;
  End;
  If Q.Res.NumPal=0Then GetPaletteRGB(Header.PaletteRGB,0,16)
                   Else ResGetAbsRec(Q.Data,SizeOf(ImageHeaderRes)+
                                     Q.Res.BytesPerLine*Q.Res.NumYPixels,
                                     16*3,Header.PaletteRGB);
 End;
 Header.X2:=Q.Res.NumXPixels-1;Header.Y2:=Q.Res.NumYPixels-1;
 _SetAbsRec(Q.Handle,Q.FilePos,SizeOf(Header),Header);
  {Sauvegarde de l'image}
 P:=128+Q.FilePos;Count:=1;FP:=SizeOf(ImageHeaderRes);PB:=0;
 For J:=0to Q.Res.NumYPixels-1do Begin
  ResGetAbsRec(Q.Data,FP,Q.Res.BytesPerLine,PBufImg^);
  If(Header.NumPlanes=3)and(Header.BitsPerPixel=8)Then Begin
   Conv24to3PlanesMap(Q.Res.BytesPerLine,PBufImg^);
  End
   Else
  If(Header.NumPlanes=4)and(Header.BitsPerPixel=1)Then Begin
   ConvBit4PlanesMap(Q.Res.BytesPerLine,PBufImg^);
  End;
  Inc(FP,Long(Q.Res.BytesPerLine));
  For I:=0to BytesPerLine-1do Begin
   Valeur:=PBufImg^[I];
   If(I or J)<>0Then Begin
    If(Valeur=LastByt)Then Begin
     Inc(Count);
     If(Count=64)or(I=0)Then Begin
      PushByte($C0or(Count-1));
      PushByte(LastByt);
      Count:=1;
     End
    End
     Else
    If(Count>1)or(LastByt and$C0<>0)Then Begin
     PushByte($C0or Count);
     PushByte(LastByt);
     Count:=1;LastByt:=Valeur;
    End
     Else
    Begin
     PushByte(LastByt);
     LastByt:=Valeur;
    End;
   End
    Else
   LastByt:=Valeur;
  End;
 End;
 PushByte($C);
 DumpBuf;
  {Sauvegarde la palette de couleur }
 If Q.Res.NumPal>=256Then Begin
  ResGetAbsRec(Q.Data,FP,Q.Res.NumPal*3,Buf);
  _SetAbsRec(Q.Handle,P,Q.Res.NumPal*3,Buf);
 End
  Else
 If Q.Res.BitsPerPixel=8Then Begin
  GetPaletteRGB(Buf,0,256);
  _SetAbsRec(Q.Handle,P,256*3,Buf);
 End;
 If SizeOfPBufImg>0Then FreeMemory(PBufImg,SizeOfPBufImg);
End;

Function RISaveIconWindows(Var Q:DataSaveRec):Word;
Var
 Header:IconHeader;
 Buffer:Array[0..4095]of Byte;
 Palette:Array[0..15]of LongInt;
 Info:BitmapInfoHeader;
 I,BP,ImgSize,BytesPerLineMask:Word;
Begin
 RISaveIconWindows:=0;
  {criture de l'entˆte}
 FillClr(Info,SizeOf(Info));
 Info.biSize:=SizeOf(BitmapInfoHeader);
 Info.biWidth:=Q.Res.NumXPixels;
 Info.biHeight:=Q.Res.NumYPixels shl 1;
 Info.biPlanes:=1;
 Info.biBitCount:=Q.Res.BitsPerPixel;
 Info.biCompression:=bi_RGB;
 ImgSize:=Q.Res.BytesPerLine*Q.Res.NumYPixels;
 BytesPerLineMask:=Q.Res.NumXPixels shr 3;
 Info.biSizeImage:=ImgSize+BytesPerLineMask*Q.Res.NumYPixels;
 FillClr(Header,SizeOf(Header));
 Header.idType:=ihwIcon;
 Header.idCount:=1;
 Header.idEntries[0].bWidth:=Q.Res.NumXPixels;
 Header.idEntries[0].bHeight:=Q.Res.NumYPixels;
 Header.idEntries[0].bColorCount:=1 shl Q.Res.BitsPerPixel;
 Header.idEntries[0].wPlanes:=1;
 Header.idEntries[0].wBitCount:=Q.Res.BitsPerPixel;
 Header.idEntries[0].dwBytesInRes:=SizeOf(Info)+SizeOf(Palette)+Info.biSizeImage;
 Header.idEntries[0].dwImageOffset:={Q.FilePos+}22;
 _SetAbsRec(Q.Handle,Q.FilePos,SizeOf(Header),Header);
 Inc(Q.FilePos,22);
 ResGetAbsRec(Q.Data,SizeOf(ImageHeaderRes),SizeOf(Buffer),Buffer);
 _SetAbsRec(Q.Handle,Q.FilePos,SizeOf(Info),Info);
 Inc(Q.FilePos,SizeOf(Info));
  {criture des palettes de couleurs}
 For I:=0to 15do Begin
  Palette[I]:=RGB2Win32bits(DefaultRGB[I].R,DefaultRGB[I].G,DefaultRGB[I].B);
 End;
 _SetAbsRec(Q.Handle,Q.FilePos,SizeOf(Palette),Palette);
 Inc(Q.FilePos,SizeOf(Palette));
  {criture de l'image}
 Conv4BitsMotorola2IntelKr(ImgSize,Buffer);
 InverseOrderLine(Buffer,ImgSize,Q.Res.BytesPerLine,Q.Res.NumYPixels);
 _SetAbsRec(Q.Handle,Q.FilePos,ImgSize,Buffer);
 Inc(Q.FilePos,Long(ImgSize));
  {criture du masque}
 BP:=Info.biSizeImage;
 If Not(Q.Res.Shadow)Then FillClr(Buffer,SizeOf(Buffer))
                     Else Inc(BP,ImgSize);
 For I:=0to Q.Res.NumYPixels-1do Begin
  Dec(BP,BytesPerLineMask);
  _SetAbsRec(Q.Handle,Q.FilePos,BytesPerLineMask,Buffer[BP]);
  Inc(Q.FilePos,Long(BytesPerLineMask));
 End;
End;

Function RISaveIconAdele(Var Q:DataSaveRec;Page:Word):Word;
Var
 Buffer:Array[0..4096]of Byte;          { Tampon d'‚change de donn‚es }
 TmpRes:ImageHeaderRes Absolute Buffer; { Entˆte temporaire de recherche de page}
 PalRGB:Array[0..255]of RGB Absolute Buffer;
 Sign:Array[0..10]of Char;              { Ne jamais changer la taille de celle-ci! }
 SizeData:Word;                         { Taille des donn‚es }
 InvColor:Boolean;                      { Inverse la palette de couleur? }
 I:Word;                                { Compteur de num‚ro de page }
Begin
 InvColor:=False;
 Sign:='ICONEADELE'#26;
 _SetAbsRec(Q.Handle,Q.FilePos,SizeOf(Sign),Sign);
 Inc(Q.FilePos,SizeOf(Sign));
 If Page>0Then Begin
  For I:=0to(Page)do Begin
   _GetAbsRec(Q.Handle,Q.FilePos,SizeOf(TmpRes),TmpRes);
   If(TmpRes.ID=idResImage)Then Begin
    Inc(Q.FilePos,SizeOf(ImageHeaderRes));
    Inc(Q.FilePos,Mul2Word(TmpRes.BytesPerLine,TmpRes.NumYPixels));
    Inc(Q.FilePos,LongInt(TmpRes.NumPal*SizeOf(RGB)));
    If(TmpRes.Shadow)Then Begin
     Inc(Q.FilePos,Mul2Word(TmpRes.NumXPixels shr 3,TmpRes.NumYPixels));
    End;
   End
    Else
   Break;
  End;
 End;
 _SetAbsRec(Q.Handle,Q.FilePos,SizeOf(ImageHeaderRes),Q.Res);
 Inc(Q.FilePos,SizeOf(ImageHeaderRes));
 SizeData:=Q.Res.BytesPerLine*Q.Res.NumYPixels;
 If Q.Res.NumPal>0Then Begin
  Inc(SizeData,Q.Res.NumPal*3);
  ResGetAbsRec(Q.Data,SizeOf(ImageHeaderRes)+Long(Q.Res.BytesPerLine)*Long(Q.Res.NumYPixels),
               Q.Res.NumPal*3,PalRGB);
  InvColor:=(Q.Res.BitsPerPixel=4)and(PalRGB[1].B=0);
 End;
 If(Q.Res.Shadow)Then Inc(SizeData,(Q.Res.NumXPixels shr 3)*Q.Res.NumYPixels);
 If SizeData>SizeOf(Buffer)Then Begin
  RISaveIconAdele:=eriDataTooBig;
  Exit;
 End;
 ResGetAbsRec(Q.Data,SizeOf(ImageHeaderRes),SizeData,Buffer);
 If(InvColor)Then Conv4BitsMotorola2IntelKr(SizeData,Buffer);
 _SetAbsRec(Q.Handle,Q.FilePos,SizeData,Buffer);
 Inc(Q.FilePos,SizeData);
 RISaveIconAdele:=eriNone;
End;

Function RISavePPM(Var Q:DataSaveRec):Word;
Var
 S:String;
 J:Word;
 Buffer:Array[0..4095]of Byte;
 FP:LongInt;
Begin
 RISavePPM:=0;
 S:='P6'#10+WordToStr(Q.Res.NumXPixels)+' '+
            WordToStr(Q.Res.NumYPixels)+#10+'255'+#10;
 PutFileTxt(Q.Handle,S);
 If Q.Res.BytesPerLine>SizeOf(Buffer)Then Begin
  RISavePPM:=eriLineTooBig;
  Exit;
 End;
 FP:=SizeOf(ImageHeaderRes);
 For J:=0to Q.Res.NumYPixels-1do Begin
  ResGetAbsRec(Q.Data,FP,Q.Res.BytesPerLine,Buffer);
  _SetRec(Q.Handle,Q.Res.BytesPerLine,Buffer);
  Inc(FP,Long(Q.Res.BytesPerLine));
 End;
End;

Function RISaveTGA(Var Q:DataSaveRec):Word;
Var
 S:String;
 J:Word;
 Buffer:Array[0..4095]of Byte;
 Header:TGAHeader;
 FP:LongInt;
Begin
 RISaveTGA:=0;
 FillClr(Header,SizeOf(Header));
 Header.NumXPixels:=Q.Res.NumXPixels;
 Header.NumYPixels:=Q.Res.NumYPixels;
 Header.BitsPerPixel:=Q.Res.BitsPerPixel;
 If Q.Res.BitsPerPixel=24Then Header.ImageType:=2;
 _SetAbsRec(Q.Handle,0,SizeOf(Header),Header);
 If Q.Res.BytesPerLine>SizeOf(Buffer)Then Begin
  RISaveTGA:=eriLineTooBig;
  Exit;
 End;
 FP:=SizeOf(ImageHeaderRes);
 For J:=0to Q.Res.NumYPixels-1do Begin
  ResGetAbsRec(Q.Data,FP,Q.Res.BytesPerLine,Buffer);
  _SetRec(Q.Handle,Q.Res.BytesPerLine,Buffer);
  Inc(FP,Long(Q.Res.BytesPerLine));
 End;
End;

Function RISaveXBM(Var Q:DataSaveRec):Word;
Var
 I,J:Word;
 FP:LongInt;
 Buffer:Array[0..4095]of Byte;
 S:String[1];
Begin
 PutFileTxtLn(Q.Handle,'#define '+Q.Name+'_width '+WordToStr(Q.Res.NumXPixels));
 PutFileTxtLn(Q.Handle,'#define '+Q.Name+'_height '+WordToStr(Q.Res.NumYPixels));
 PutFileTxtLn(Q.Handle,'static char '+Q.Name+'_bits[] = {');
 FP:=SizeOf(ImageHeaderRes);
 For J:=0to Q.Res.NumYPixels-1do Begin
  ResGetAbsRec(Q.Data,FP,Q.Res.BytesPerLine,Buffer);
  PutFileTxt(Q.Handle,'   ');
  Inc(FP,Long(Q.Res.BytesPerLine));S:=',';
  For I:=0to Q.Res.BytesPerLine-1do Begin
   If(I=Q.Res.BytesPerLine-1)and(J=Q.Res.NumYPixels-1)Then S:='';
   PutFileTxt(Q.Handle,'0x'+HexByte2Str(Buffer[I])+S);
  End;
  PutFileLn(Q.Handle);
 End;
 PutFileTxtLn(Q.Handle,'};');
End;

Function RISaveIconGenesis(Var Q:DataSaveRec;Page:Word):Word;
Var
 Block:BlockButton;
 Buffer:Array[0..63]of Byte;
 I,J:Byte;
 B:Word;
 FP:LongInt;
 Len:Word;
Begin
 RISaveIconGenesis:=0;
 B:=0;FP:=SizeOf(ImageHeaderRes);
 Len:=Q.Res.BytesPerLine;
 If Len>SizeOf(Buffer)Then Len:=SizeOf(Buffer);
 For J:=0to 31do Begin
  ResGetAbsRec(Q.Data,FP,Len,Buffer);
  For I:=0to 15do Begin
   Block.Data[J,(I shl 1)+1]:=Buffer[B]and$F;
   Block.Data[J,I shl 1]:=Buffer[B]shr 4;
   Inc(B)
  End;
  Inc(FP,LongInt(Q.Res.BytesPerLine));
 End;
 SetRec(Q.Handle,Page,SizeOf(BlockButton),Block);
End;

Function RISaveInternal(Var Q:DataSaveRec;Page:Word):Word;Begin
 If(Q.Data.Handle=errHdl)or(Q.Data.Output=$FF)Then Begin
  RISaveInternal:=eriInvalidHeader;
  Exit;
 End;
 Case(Q.Res.Original)of
  diIconWindows:RISaveInternal:=RISaveIconWindows(Q);
  diIconAdele:RISaveInternal:=RISaveIconAdele(Q,Page);
  diIconGenesis:RISaveInternal:=RISaveIconGenesis(Q,Page);
  diBGX:RISaveInternal:=RISaveBGX(Q);
  diBitMapWindows:RISaveInternal:=RISaveBMP(Q);
  diGIF:RISaveInternal:=RISaveGIF(Q);
  diPCX:RISaveInternal:=RISavePCX(Q);
  diPPM:RISaveInternal:=RISavePPM(Q);
  diSCI:RISaveInternal:=RISaveSCI(Q);
  diXBM:RISaveInternal:=RISaveXBM(Q);
  diTGA:RISaveInternal:=RISaveTGA(Q);
  Else RISaveInternal:=eriFormatNotSupport;
 End;
End;

Function CodeImage(Path:String):Byte;Begin
 CodeImage:=diAutoDetect;
 Path:=StrUp(Path);
 If Pos('.BGX',Path)>0Then CodeImage:=diBGX;
 If Pos('.BMP',Path)>0Then CodeImage:=diBitMapWindows;
 If Pos('.GIF',Path)>0Then CodeImage:=diGIF;
 If Pos('.PCX',Path)>0Then CodeImage:=diPCX;
 If Pos('.PPM',Path)>0Then CodeImage:=diPPM;
 If Pos('.SCI',Path)>0Then CodeImage:=diSCI;
 If Pos('.XBM',Path)>0Then CodeImage:=diXBM;
End;

Function _RISaveImage{Var Name:String;Page:Word;Var Q:XInf):Word};
Var
 DS:DataSaveRec;
Begin
 _RISaveImage:=eriNone;
 FillClr(DS,SizeOf(DS));
 DS.Data:=Q;DS.Name:=Name;
 ResGetAbsRec(Q,0,SizeOf(DS.Res),DS.Res);
 If Path2Ext(Name)=''Then Case(DS.Res.Original)of
  diIconWindows,diIconOS2,diIconAdele:AddStr(Name,'.ICO');
  diIconGenesis:AddStr(Name,'.ICN');
  diIconGeoWorks:;
  diIconGemDesktop:;
  diPointerOS2:AddStr(Name,'.PTR');
  diBitMapWindows,diBitMapOS2:AddStr(Name,'.BMP');
  diMacPaint:AddStr(Name,'.MAC');
  diGemImg:AddStr(Name,'.IMG');
  diGFX:AddStr(Name,'.GFX');
  diPPM:AddStr(Name,'.PPM');
  diPCX:AddStr(Name,'.PCX');
  diLBM:AddStr(Name,'.LBM');
  diTGA:AddStr(Name,'.TGA');
  diTIFF:AddStr(Name,'.TIF');
  diGIF:AddStr(Name,'.GIF');
  diJPEG:AddStr(Name,'.JPG');
  diWPG:AddStr(Name,'.WPG');
  diGPX:AddStr(Name,'.GPX');
  diBGX:AddStr(Name,'.BGX');
  diHex:;
  diGatElectric:AddStr(Name,'.GAT');
  diResWindows:AddStr(Name,'.RES');
  diExeWindows:AddStr(Name,'.EXE');
  diCorelDraw:AddStr(Name,'.CDR');
  diXBM:AddStr(Name,'.XBM');
  diWordPerfectGraphics:AddStr(Name,'.WPG');
  diMBF:AddStr(Name,'.MBF');
  diRLL:AddStr(Name,'.RLL');
  diSCI:AddStr(Name,'.SCI');
 End;
 DS.Handle:=FileCreateAndBackup(Name);
 If(DS.Handle<>errHdl)Then Begin
  _RISaveImage:=RISaveInternal(DS,Page);
  FileClose(DS.Handle);
 End
  Else
 _RISaveImage:=eriCantCreate;
End;

Function RISaveImage(Name:String;Page:Word;Var Q:XInf):Word;Begin
 RISaveImage:=_RISaveImage(Name,Page,Q);
End;

Function RIWriteImage{Handle:Hdl;DefaultImage:Word;Page:Word;Var FilePos:LongInt;Var Q:XInf):Word};
Var
 DS:DataSaveRec;
Begin
 RIWriteImage:=eriNone;
 FillClr(DS,SizeOf(DS));
 DS.Handle:=Handle;
 DS.FilePos:=FilePos;
 DS.Data:=Q;
 ResGetAbsRec(Q,0,SizeOf(DS.Res),DS.Res);
 If(DefaultImage<>diAutoDetect)Then Begin
  DS.Res.Original:=DefaultImage;
 End;
 If(DS.Handle<>errHdl)Then Begin
  RIWriteImage:=RISaveInternal(DS,Page);
  FilePos:=DS.FilePos;
 End
  Else
 RIWriteImage:=eriCantCreate;
End;

Function RIPrintScreen(Const Name:String):Word;
Var
 Handle:Hdl;
 FilePos:LongInt;
 Q:XInf;
Begin
 RIPrintScreen:=0;
 Handle:=FileCreateAndBackup(Name);
 If(Handle<>errHdl)Then Begin
  FilePos:=0;Q.Handle:=hdlPrtScr;
  RIWriteImage(Handle,CodeImage(Name),0,FilePos,Q);
  FileClose(Handle);
 End
  Else
 RIPrintScreen:=eriCantCreate;
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
END.