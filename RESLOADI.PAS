{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                                                                         Û
 ³             Malte Genesis/Ressource de chargement d'Image               Û
 ³                                                                         Û
 ³              dition AdŠle pour Mode R‚el/V - Version 1.1               Û
 ³                              1999/07/10                                 Û
 ³                                                                         Û
 ³          Tous droits r‚serv‚s par les Chevaliers de Malte (C)           Û
 ³                                                                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Nom du programmeur
 ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

  Sylvain Maltais


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette unit‚ permet de charger des images contenue dans des divers fichiers
 dans une  des ressources  de l'ensemble afin  d'‚ventuellement effectuer un
 traŒtement particulier.
}

{$I DEF.INC}

Unit ResLoadI;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                 INTERFACE
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses Systex,Restex;

Function  RIDefaultImage(Handle:Hdl;Const Buffer:Array of Char):Word;
Procedure RIInitLoader(Var Q:ImageObjectLoader);
Function  RILoadImage(Const Name:String;DefaultImage,BitsPerPixel,Index:Word;
                      Ressource:Byte;Flags:FlagsProcessusImage;Var Q:XInf):Word;
Function  RIReadGIF(Var R:ImageObjectLoader;Var Q:XInf):Word;
Function  RILoaderImage(Var R:ImageObjectLoader;Var Q:XInf):Word;
Function  RIReadImage(Handle:Hdl;DefaultImage:Word;Var FilePos:LongInt;
                      BitsPerPixel,Index:Word;Ressource:Byte;
                      Flags:FlagsProcessusImage;Var Q:XInf):Word;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                               IMPLEMENTATION
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses
 Adele,Memories,Systems,Isatex,Math,Video,Dialex,Dials,
 ImageTex,WinTex,ResServI;

 {Structure pour les images en format compress‚e ou demandant une lecture
  octet par octet (PCX, TIFF, LBM, Gem/Img Ventura...)}
Type
 HandleExtended=Record
  Handle:Hdl;             { Handle attribu‚e au fichier }
  Position:Word;          { Position actuel dans le tampon }
  FP:LongInt;             { Position courante dans le fichier }
  FileSize:LongInt;       { Taille du fichier maximal }
  Size:Word;              { Taille du tampon }
  Buffer:^TByte;          { Adresse du tampon }
  Format:(Intel,Motorola);{ Format des donn‚es: Intel ou Motorola }
 End;

{ Cette  fonction  permet  d'effectuer une allocation  de m‚moire au niveau
 d'une ressource de m‚moire en fonction des dimensions de l'image sp‚cifier
 dans la variable de param‚trage ®Res¯.
}

Function BestAlloc(Const Res:ImageHeaderRes;Flags:FlagsProcessusImage;
                   Ressource:Byte;Size:LongInt;Var Load:Boolean;
                   Var Q:XInf):Boolean;Near;Begin
 Load:=False;BestAlloc:=False;
 If(fpViewScr)in(Flags)Then BestMode(Res);
 If(fpNotLoadInRessource)in(Flags)Then Begin
  If(fpPreserveHeader)in(Flags)Then
   BestAlloc:=XAllocMem(Ressource,SizeOf(ImageHeaderRes),Q)
  Else
   BestAlloc:=True;
 End
  Else
 If((fpLoadOnlyTooBig)in(Flags))and(Res.NumXPixels<=NmXPixels)and
   (Res.NumYPixels<=NmYPixels)Then Begin
  If(fpPreserveHeader)in(Flags)Then
   BestAlloc:=XAllocMem(Ressource,SizeOf(ImageHeaderRes),Q)
  Else
   BestAlloc:=True;
 End
  Else
 Begin
  Load:=True;
  BestAlloc:=XAllocMem(Ressource,Size,Q);
 End;
End;

{ Cette fonction permet de convertir un 3 planes de 8 bits de 24 bits de
 couleur en format lin‚aire BitMap.
}

Function Conv3Planes2BitMap(BytesPerLine:Word;Var Line:Array of Byte):Boolean;Near;
Var
 PPln:^TByte;
 XBytes,P1,P2,P3:Word;
Begin
  { Transformation de 3 planes en BitMap }
 PPln:=MemAlloc(BytesPerLine);
 If(PPln<>NIL)Then Begin
  XBytes:=BytesPerLine div 3;P1:=0;P2:=XBytes;P3:=XBytes shl 1;
  {La partie suivante coder en assembleur est l'‚quivalent de ceci en
   langage Pascal:
   ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   ³ For Base:=0to XBytes-1do Begin                                 ³
   ³  PPln^[P1]:=Line[P3];  Inc(P1);Inc(P3);                        ³
   ³  PPln^[P1]:=Line[P2];  Inc(P1);Inc(P2);                        ³
   ³  PPln^[P1]:=Line[Base];Inc(P1);                                ³
   ³ End;                                                           ³
   ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
  }
  ASM
   {$IFDEF FLAT386}
   {$ELSE}
    PUSH DS
     CLD
     LES DI,PPln
     MOV CX,XBytes
     LDS SI,Line
     MOV BX,P3
     MOV DX,P2
 @1: MOV AL,DS:[SI+BX]
     XCHG BX,DX
     MOV AH,DS:[SI+BX]
     XCHG BX,DX
     STOSW
     LODSB
     STOSB
     LOOP @1
    POP DS
   {$ENDIF}
  END;
  MoveLeft(PPln^,Line,BytesPerLine);
  FreeMemory(PPln,BytesPerLine);
  Conv3Planes2BitMap:=True;
 End
  Else
 Conv3Planes2BitMap:=False;
End;

{ Cette proc‚dure permet de transf‚rer un tableau de 24 bits dans un
 tableau de 32 bits avec rotation des couleurs RVB.
}

Procedure Conv24to32Swap(Var Source,Target;Count:Word);Assembler;ASM
 {$IFDEF FLAT386}
  CLD
  MOV  CX,Count
  JCXZ @End
  LEA  EDI,DWord Ptr Target
  LEA  ESI,DWord Ptr Source
@lp24to32sw:
  LODSW
  XCHG AX,BX
  LODSB
  XCHG AL,BL
  SHL  EAX,16
  MOV  AX,BX
  STOSD
  LOOP @lp24to32sw
@End:
 {$ELSE}
  CLD
  MOV  CX,Count
  JCXZ @End
  LES  DI,Target
  PUSH DS
   LDS SI,Source
@lp24to32sw:
   LODSW
   XCHG AX,BX
   LODSB
   XCHG AL,BL
   MOV  DX,AX
   MOV  AX,BX
   STOSW
   XCHG DX,AX
   STOSW
   LOOP @lp24to32sw
  POP DS
@End:
 {$ENDIF}
END;

{ Cette proc‚dure permet de transf‚rer un tableau de 32 bits dans un
 tableau de 24 bits.
}

Procedure Conv32to24(Var Source,Target;Count:Word);Assembler;ASM
 {$IFDEF FLAT386}
  CLD
  MOV  CX,Count
  JCXZ @End
  LEA  EDI,DWord Ptr Target
  LEA  ESI,DWord Ptr Source
@Loop:
  LODSD
  STOSW
  SHR  EAX,16
  STOSB
  LOOP @Loop
@End:
 {$ELSE}
  CLD
  MOV  CX,Count
  JCXZ @End
  LES  DI,Target
  PUSH DS
   LDS SI,Source
@Loop:
   LODSW
   STOSW
   LODSW
   STOSB
   LOOP @Loop
  POP DS
@End:
 {$ENDIF}
END;

{ Cette proc‚dure permet de transf‚rer un tableau de 32 bits dans un
 tableau de 24 bits avec rotation des couleurs RVB.
}

Procedure Conv32to24swap(Var Source,Target;Count:Word);Assembler;ASM
 {$IFDEF FLAT386}
  CLD
  MOV  CX,Count
  JCXZ @End
  LEA  EDI,DWord Ptr Target
  LEA  ESI,DWord Ptr Source
@Loop:
  LODSW
  MOV  BL,[ESI]
  ADD  ESI,2
  XCHG AL,BL
  STOSW
  MOV  [EDI],BL
  INC  EDI
  LOOP @Loop
@End:
 {$ELSE}
  CLD
  MOV  CX,Count
  JCXZ @End
  LES  DI,Target
  PUSH DS
   LDS SI,Source
@Loop:
   LODSW
   MOV  BL,DS:[SI]
   ADD  SI,2
   XCHG AL,BL
   STOSW
   MOV  ES:[DI],BL
   INC  DI
   LOOP @Loop
  POP DS
@End:
 {$ENDIF}
END;

{ Cette proc‚dure permet  d'afficher  une fenˆtre  de dialogue afin
 d'‚ventualement permet l'affichage de la progression du chargement
 en ressource m‚moire d'une image.
}

Procedure WEInitProgressBar(Var W:Window);Near;Begin
 WEInitO(W,40,6);
 WEPushWn(W);
 WEPutWnKrDials(W,'Chargement en cours...');
 WEBar(W);
 W.CurrColor:=$1F;
 WEBarSpcHorShade(W,0,3,wnMax);
 WESetKrBorder(W);
End;

{ Cette proc‚dure permet d'effectue une mise … jour de la progression du
 chargement  d'une  image ayant  au  pr‚alable  ‚t‚  initialis‚e  par la
 proc‚dure ®WEInitProgressBar¯.
}

Procedure WEUpDate(Var W:Window;Curr,Total:LongInt);Near;
Const
 OldT:Byte=$FF;
Var
 Pour,T:Byte;
Begin
 T:=GetRawTimerB and 3;
 If(T<>OldT)Then Begin
  WEPutTxtXY(W,0,1,CStr(Curr)+'/'+CStr(Total));
  Pour:=DivLong(LongInt(Curr)*100,LongInt(Total));
  WESetPos(W,0,3);
  WEPutOTxtU(W,IntToStr(Pour)+'%');
  W.CurrColor:=$F0;
  WEBarSelHor(W,0,3,DivLong(Pour*(W.MaxX-1),100));
  WESetKrBorder(W);
  OldT:=T;
 End;
End;

{ Cette fonction demande … l'utilisateur s'il souhaite interrompre le
 processus de chargement d'image.
}

Function UserCancel:Boolean;Near;Begin
 UserCancel:=InputMsg('Attention','D‚sirez-vous interrompre le processus de '+
                'chargement de l''image?',
             KeyYes+KeyNo,wfOctogone+wiExit,CurrKrs.WarningWin)=kbYes;
End;

{ Cette proc‚dure permet d'initialiser la routine de lecture de fichier
 par bloc.
}

Procedure InitReadPackData(Var Q:HandleExtended;Handle:Hdl;Pos:LongInt;Size:Word;Var Buffer);Begin
 FillClr(Q,SizeOf(Q));
 Q.Handle:=Handle;
 Q.Buffer:=@Buffer;
 Q.Size:=Size;
 Q.FP:=Pos;
 Q.Format:=INTEL;
 Q.Position:=Q.Size;
 Q.FileSize:=FileSize(Handle);
End;

{ Cette fonction indique si la fin du fichier a ‚t‚ atteint.
}

Function EOF(Var Q:HandleExtended):Boolean;Begin
 EOF:=Q.FP+Q.Position>=Q.FileSize;
End;

{ Cette proc‚dure permet de positionner le pointeur de fichier … un
 endroit pr‚cis.
}

Procedure Seek(Var Q:HandleExtended;Pos:LongInt);Begin
 Q.Position:=Q.Size;
 Q.FP:=Pos;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Fonction ReadByte                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Portabilit‚: Local


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de lire un octet dans un tampon d'une taille
 sp‚cifier plut“t que de lire chaque octet … partir du disque.
}

Function ReadByte(Var Q:HandleExtended):Byte;Near;Begin
 If(Q.Position=Q.Size)Then Begin
  _GetAbsRec(Q.Handle,Q.FP,Q.Size,Q.Buffer^);
  Inc(Q.FP,LongInt(Q.Size));Q.Position:=0
 End;
 ReadByte:=Q.Buffer^[Q.Position];Inc(Q.Position)
End;

{ Cette fonction permet de lire un mot dans un fichier avec l'objet de
 bloc.
}

Function ReadWord(Var Q:HandleExtended):Word;Near;
Var
 K:Word;
Begin
 If(Q.Position+1>=Q.Size)Then ASM
   {K:=ReadByte(Q)+(ReadByte(Q)shl 8);}
  LES DI,Q
  PUSH ES
  PUSH DI
  CALL ReadByte
  MOV Byte Ptr K,AL
  LES DI,Q
  PUSH ES
  PUSH DI
  CALL ReadByte
  MOV Byte Ptr K[1],AL
 END
  Else
 Begin
  ASM
    {K:=Q.Buffer^[Q.Position];
     Inc(Q.Position,2);}
   {$IFDEF FLAT386}
   {$ELSE}
    LES DI,Q
    MOV BX,ES:[DI].HandleExtended.Position
    MOV AX,BX
    INC AX
    INC AX
    MOV ES:[DI].HandleExtended.Position,AX
    LES DI,ES:[DI].HandleExtended.Buffer
    MOV AX,ES:[DI+BX]
    MOV K,AX
   {$ENDIF}
  END;
 End;
 ASM
  {$IFDEF FLAT386}
  {$ELSE}
   LES DI,Q
   CMP ES:[DI].HandleExtended.Format,INTEL
   JE  @End
   MOV AX,K
   XCHG AL,AH
   MOV K,AX
@End:
  {$ENDIF}
 END;
 ReadWord:=K;
End;

{ Cette fonction permet de lire un mot dans un fichier avec l'objet de
 bloc.
}

Function ReadLong(Var Q:HandleExtended):LongInt;Near;
Var
 K:LongInt;
Begin
 If(Q.Position+3>=Q.Size)Then ASM
  {K:=Long(ReadByte(Q))+
      Long(ReadByte(Q)shl 8)+
      Long(Long(ReadByte(Q))shl 16)+
      Long(Long(ReadByte(Q))shl 24);}
  LES DI,Q
  PUSH ES
  PUSH DI
  CALL ReadByte
  MOV Byte Ptr K,AL
  LES DI,Q
  PUSH ES
  PUSH DI
  CALL ReadByte
  MOV Byte Ptr K[1],AL
  LES DI,Q
  PUSH ES
  PUSH DI
  CALL ReadByte
  MOV Byte Ptr K[2],AL
  LES DI,Q
  PUSH ES
  PUSH DI
  CALL ReadByte
  MOV Byte Ptr K[3],AL
 END
  Else
 Begin
  ASM
    {K:=Q.Buffer^[Q.Position];
     Inc(Q.Position,4);}
   {$IFDEF FLAT386}
   {$ELSE}
    LES DI,Q
    MOV BX,ES:[DI].HandleExtended.Position
    MOV AX,BX
    ADD AX,4
    MOV ES:[DI].HandleExtended.Position,AX
    LES DI,ES:[DI].HandleExtended.Buffer
    LES AX,ES:[DI+BX]
    MOV Word Ptr K,AX
    MOV Word Ptr K[2],ES
   {$ENDIF}
  END;
 End;
 ASM
  {$IFDEF FLAT386}
  {$ELSE}
   LES DI,Q
   CMP ES:[DI].HandleExtended.Format,INTEL
   JE  @End
   LES AX,K
   MOV DX,ES
   XCHG AL,AH
   XCHG DL,DH
   XCHG AX,DX
   MOV Word Ptr K,AX
   MOV Word Ptr K[2],DX
  {$ENDIF}
@End:
 END;
 ReadLong:=K;
End;

{ Cette fonction permet de lire directement un bloc d'information
 dans un fichier.
}

Function ReadBuf(Var Q:HandleExtended;Size:Word;Var Buf):Word;Near;
Var
 N:Word;
Begin
 If(Q.Position<Q.Size)Then Inc(Q.FP,LongInt(Q.Position));
 N:=_GetAbsRec(Q.Handle,Q.FP,Size,Buf);
 Inc(Q.FP,LongInt(N));Q.Position:=Q.Size;
End;

{ Cette fonction permet de lire un bloc d'information dans un fichier.
}

Function ReadBuf2(Var Q:HandleExtended;Size:Word;Var Buf):Word;Near;
Var
 N:Word;
Begin
 If(Q.Position+Size<Q.Size)Then Begin
  MoveLeft(Q.Buffer^[Q.Position],Buf,Size);
  Inc(Q.Position,Size);
 End
  Else
 Begin
  For N:=0to Size-1do TByte(Buf)[N]:=ReadByte(Q);
 End;
End;

{ Cette fonction permet de lire un nombre r‚el dans un fichier.
}

Function ReadReal(Var Q:HandleExtended):Real;Near;
Var
 R:Real;
Begin
 ReadBuf2(Q,SizeOf(R),R);
 ReadReal:=R;
End;

{ Cette fonction permet de connaŒtre la position du pointeur de
 fichier.
}

Function GetFilePos(Const Q:HandleExtended):LongInt;Begin
 If(Q.Position<Q.Size)Then GetFilePos:=Q.FP+Q.Position
                      Else GetFilePos:=Q.FP;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Fonction LenNBits2BytesPerLine                  Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Portabilit‚: Local


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet d'effectuer une estimation de largeur en octets que
 prendra un nombre de pixels avec un nombre particulier de couleurs.
}

Function LenNBits2BytesPerLine(Width:Word;Bits4Pixel:Byte):Word;Near;Begin
 Case(Bits4Pixel)of
  1:LenNBits2BytesPerLine:=Width shr 3;
  2:LenNBits2BytesPerLine:=Width shr 2;
  4:LenNBits2BytesPerLine:=Width shr 1;
  9..16:LenNBits2BytesPerLine:=Width shl 1;
  17..24:LenNBits2BytesPerLine:=Width*3;
  25..32:LenNBits2BytesPerLine:=Width shl 2;
  33..64:LenNBits2BytesPerLine:=Width shl 4;
  Else LenNBits2BytesPerLine:=Width;
 End;
End;

{ Cette proc‚dure permet de transferer un tableau de 32 bits dans un
 tableau de 16 bits.
}

Procedure ConvElem32To16(Const Source;Var Dest;Len:Word);Near;Assembler;ASM
 {$IFDEF FLAT386}
  CLD
  MOVZX ECX,Len
  JECXZ @End
  LEA ESI,DWord Ptr Source
  LEA EDI,DWord Ptr Dest
@Loop:
  LODSD
  STOSW
  LOOP @Loop
@End:
 {$ELSE}
  CLD
  PUSH DS
   MOV CX,Len
   JCXZ @End
   LDS SI,Source
   LES DI,Dest
@Loop:
   LODSW
   STOSW
   LODSW
   LOOP @Loop
@End:
  POP DS
 {$ENDIF}
END;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Fonction RIReadIconWindows                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: XInf
 Portabilit‚:  Local


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de charger dans une ressource le contenu d'une ic“ne
 ou un curseur de format Windows.
}

Function RIReadIconWindows(Var R:ImageObjectLoader;Var Q:XInf):Word;Near;
Var
 I,J,J2,B,Size,Pos,Min,Max:Word;
 BytesPerLineMask,ImgSize:Word;
 Work:Record
  SizeBuffer:Word;
  SizeShadow:Word;
  Res:ImageHeaderRes;
  TmpPal256:Palette256RGB;
 End;
 Header:IconHeader;
 Buffer:Array[0..4095]of Byte;
 PBuffer:^TByte;
 BitMap:BitMapInfoHeader Absolute Buffer;
Begin
 RIReadIconWindows:=eriFormatNotFound;
 _GetAbsRec(R.Handle,R.FilePos,SizeOf(Header),Header);
 If {R.BitsPerPixel=0}True Then Begin
  Min:=1;
  Max:=Header.idCount;
 End
  Else
 Begin
  Min:=R.Index+1;
  Max:=R.Index+1;
 End;
 If(Header.idReserved=0)and(Header.idType in[1,2])Then For I:=Min to(Max)do Begin
  FillClr(Work,SizeOf(Work));
  PBuffer:=@Buffer;
  Size:=Header.idEntries[I-1].dwBytesInRes;
  If Size>SizeOf(Buffer)Then Begin
   Work.SizeBuffer:=Size;
   PBuffer:=MemAlloc(Work.SizeBuffer);
   If(PBuffer=NIL)Then Exit;
  End;
  _GetAbsRec(R.Handle,R.FilePos+Header.idEntries[I-1].dwImageOffset,Size,PBuffer^);
  If Work.SizeBuffer<>0Then MoveLeft(PBuffer^,Buffer,SizeOf(BitMapInfoHeader));
  Work.Res.NumXPixels:=Header.idEntries[I-1].bWidth;
  Work.Res.NumYPixels:=Header.idEntries[I-1].bHeight;
  If(Work.Res.NumXPixels=0)or(Work.Res.NumYPixels=0)Then Begin
   RIReadIconWindows:=eriInvalidHeader;
   Exit;
  End;
  B:=SizeOf(BitMapInfoHeader);
  If(BitMap.biBitCount>=R.BitsPerPixel)Then Begin
   BytesPerLineMask:=Work.Res.NumXPixels shr 3;
   Work.Res.NumPal:=BitMap.biClrUsed;
   If BitMap.biBitCount=4Then Begin
{    Res.NumPal:=16;}
    Conv32to24Swap(PBuffer^[B],Work.TmpPal256[0].R,16{Res.NumPal});
{    Inc(B,4*Res.NumPal);}
     Inc(B,4*16);
   End
    Else
   If Work.Res.NumPal>0Then Begin
     {Conversion de la palette 32 bits en format 24 bits RVB }
    If(BitMap.biClrUsed>0)and(BitMap.biClrUsed<=256)Then
     Conv32to24Swap(PBuffer^[B],Work.TmpPal256[0].R,BitMap.biClrUsed);
    {For J:=0to BitMap.biClrUsed-1do Begin
     TmpPal256[J].R:=Buffer[B+(J shl 2)+2];
     TmpPal256[J].G:=Buffer[B+(J shl 2)+1];
     TmpPal256[J].B:=Buffer[B+(J shl 2)];
    End;}
    Inc(B,BitMap.biClrUsed shl 2);
   End;
   Work.Res.BytesPerLine:=LenNBits2BytesPerLine(Bitmap.biWidth,BitMap.biBitCount);
   ImgSize:=Work.Res.BytesPerLine*Work.Res.NumYPixels;
   Work.Res.Shadow:=True;
   Work.SizeShadow:=BytesPerLineMask*Work.Res.NumYPixels;
   If XAllocMem(R.Ressource,SizeOf(ImageHeaderRes)+ImgSize+Work.SizeShadow+Work.Res.NumPal*3,Q)Then Begin
     {Transfert de l'image en format Binaire lin‚aire descendant }
    If(BitMap.biBitCount=4)and(Work.TmpPal256[1].B=0)Then Conv4BitsMotorola2IntelKr(ImgSize,PBuffer^[B]);
    InverseOrderLine(PBuffer^[B],ImgSize,Work.Res.BytesPerLine,Work.Res.NumYPixels);
    XSetAbsRec(Q,SizeOf(ImageHeaderRes),ImgSize,PBuffer^[B]);
    Inc(B,ImgSize);
     {Enregistrement de la palette si elle existe}
    Pos:=SizeOf(ImageHeaderRes)+ImgSize;
    If Work.Res.NumPal>0Then Begin
     XSetAbsRec(Q,Pos,SizeOf(Work.TmpPal256),Work.TmpPal256);
     Inc(Pos,Work.Res.NumPal*3);
    End;
    If(Work.Res.Shadow)Then Begin
     If Work.Res.NumXPixels=16Then Begin
      { Le "Shadow" d'une ic“ne est stock‚ en 32 bits mˆme s'il n'en prend
        que 16 bits en m‚moire, il faut donc les convertirs dans son format:}
      ConvElem32To16(PBuffer^[B],PBuffer^[B],16);
     End;
     InverseOrderLine(PBuffer^[B],Work.SizeShadow,BytesPerLineMask,Work.Res.NumYPixels);
     XSetAbsRec(Q,Pos,Work.SizeShadow,PBuffer^[B]);
    End;
     {Mise … jour des informations d'entˆte}
    Work.Res.ID:=idResImage;
    Work.Res.BitsPerPixel:=BitMap.biBitCount;
    Work.Res.Format:=fdiBinary;
    Work.Res.Original:=diIconWindows;
    Work.Res.Index:=I-1;
    XSetAbsRec(Q,0,SizeOf(ImageHeaderRes),Work.Res);
    RIReadIconWindows:=eriNone;
    FreeMemory(PBuffer,Work.SizeBuffer);
    Exit;
   End;
  End;
  FreeMemory(PBuffer,Work.SizeBuffer);
 End
  Else
 RIReadIconWindows:=eriInvalidHeader;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Fonction RIReadIconOS2                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: XInf
 Portabilit‚:  Local


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de lire un fichier d'Ic“ne de format OS/2 et de le
 placer dans une ressource d'image.
}

Function RIReadIconOS2(Handle:Hdl;FilePos:LongInt;
                       BitsPerPixel,Ressource:Byte;Var Q:XInf):Word;Near;
Var
 I,J,B,Size,K,Pos:Word;
 ExtHeaderOS2:ExtIconOS2DirEntry;
 HeaderOS2:IconOS2DirEntry Absolute ExtHeaderOS2;
 Buffer:Array[0..4095]of Byte;
 BitMap:BitMapInfoHeader Absolute Buffer;
 Res:ImageHeaderRes;
Begin
 RIReadIconOS2:=eriFormatNotFound;
 _GetAbsRec(Handle,FilePos,SizeOf(ExtHeaderOS2),ExtHeaderOS2);
 If ExtHeaderOS2.Sign='BA'Then Begin
  I:=1;Res.Original:=diIconOS2;
  Repeat
   _GetAbsRec(Handle,FilePos+ExtHeaderOS2.Data.PosAbs,SizeOf(Buffer),Buffer);
   B:=0;
   If(ExtHeaderOS2.Data.BitsPerPixel>=BitsPerPixel)Then Begin
    Res.NumXPixels:=ExtHeaderOS2.Data.NumXPixels;
    Res.NumYPixels:=ExtHeaderOS2.Data.NumYPixels;
    Res.BitsPerPixel:=ExtHeaderOS2.Data.BitsPerPixel;
    Res.BytesPerLine:=LenNBits2BytesPerLine(Res.NumXPixels,Res.BitsPerPixel);
    Pos:=SizeOf(ImageHeaderRes)+Res.BytesPerLine*Pred(Res.NumYPixels);
    If XAllocMem(Ressource,SizeOf(ImageHeaderRes)+Res.BytesPerLine*Res.NumYPixels,Q)Then Begin
     For J:=Res.NumYPixels-1downto 0do Begin
       { Les images OS/2 sont sauvegarder de la partie inf‚rieur vers la }
       { partie sup‚rieur...}
      XSetAbsRec(Q,Pos,Res.BytesPerLine,Buffer[B]);
      Dec(Pos,Res.BytesPerLine);
      Inc(B,Res.NumXPixels);
     End;
      {Mise … jour des informations d'entˆte}
     Res.ID:=idResImage;
     Res.BitsPerPixel:=BitMap.biBitCount;
     Res.Format:=fdiBinary;
     Res.Original:=diIconOS2;
     Res.Index:=I-1;
     Res.Descr:='';
     Res.Shadow:=False;
     XSetAbsRec(Q,0,SizeOf(ImageHeaderRes),Res);
     RIReadIconOS2:=eriNone;
    End;
    Break;
   End;
   _GetAbsRec(Handle,FilePos+I*SizeOf(ExtHeaderOS2),SizeOf(ExtHeaderOS2),ExtHeaderOS2);
   Inc(I);
  Until ExtHeaderOS2.Sign<>'BA'
 End
  Else
 If HeaderOS2.Sign='CI'#26Then Begin
  I:=1;Res.Original:=diIconOS2;
  Repeat
   _GetAbsRec(Handle,FilePos+HeaderOS2.PosAbs,SizeOf(Buffer),Buffer);
   If(HeaderOS2.BitsPerPixel>=BitsPerPixel)Then Begin
    B:=0;Res.NumXPixels:=HeaderOS2.NumXPixels shl 1;
    Res.NumYPixels:=HeaderOS2.NumYPixels shl 1;
    Res.BitsPerPixel:=HeaderOS2.BitsPerPixel;
    Res.BytesPerLine:=LenNBits2BytesPerLine(Res.NumXPixels,Res.BitsPerPixel);
    Pos:=SizeOf(ImageHeaderRes)+Res.BytesPerLine*Pred(Res.NumYPixels);
    If XAllocMem(Ressource,SizeOf(ImageHeaderRes)+Res.BytesPerLine*Res.NumYPixels,Q)Then Begin
     For J:=Res.NumYPixels-1downto 0do Begin
       { Les images OS/2 sont sauvegarder de la partie inf‚rieur vers la }
       { partie sup‚rieur...}
      XSetAbsRec(Q,Pos,Res.BytesPerLine,Buffer[B]);
      Dec(Pos,Res.BytesPerLine);
      Inc(B,HeaderOS2.NumXPixels);
     End;
      {Mise … jour des informations d'entˆte}
     Res.ID:=idResImage;
     Res.Format:=fdiBinary;
     Res.Original:=diIconOS2;
     Res.Index:=I-1;
     Res.Descr:='';
     Res.Shadow:=False;
     XSetAbsRec(Q,0,SizeOf(ImageHeaderRes),Res);
     RIReadIconOS2:=eriNone;
     Exit;
    End;
   End;
   _GetAbsRec(Handle,FilePos+I*SizeOf(IconOS2DirEntry),SizeOf(IconOS2DirEntry),HeaderOS2);
   Inc(I);
  Until HeaderOS2.Sign<>'CI'#26
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Fonction RIReadPCX                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: XInf
 Portabilit‚:  Local


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de lire un fichier d'image PCX de PaintBrush et de
 placer sous contenu dans une ressource d'image.


 Remarque
 ÍÍÍÍÍÍÍÍ

  ş Il support les images avec  2, 4, 16, 256  et 16 millions de couleurs,
    cependant dans le cas du  16 millions de couleurs,  il est primordiale
    que l'image soit  sauvegarder  sous trois  "planes"  diff‚rents sinon,
    l'image ne sera par reconnu.
}

Function RIReadPCX(Handle:Hdl;FilePos:LongInt;Ressource:Byte;
                   Flags:FlagsProcessusImage;Var Q:XInf):Word;Near;
Var
 Work:Record
  Res:ImageHeaderRes;
  SizeOfPLine:Word;
  Index:Word;
 End;
 Data,B:Byte;
 XH:HandleExtended;
 Y:Integer;
 RP,FS:LongInt;
 Len,Z:Byte;
 W:Window;
 Load:Boolean;
 PLine:^TByte;
 Header:HeaderPCX;
 Pal256:Palette256RGB;
 Buffer:Array[0..4095]of Byte;
 Line:Array[0..1279]of Byte;
Begin
 RIReadPCX:=eriFormatNotFound;
 FillClr(Work,SizeOf(Work));
 _GetAbsRec(Handle,FilePos,SizeOf(Header),Header);
 If(Header.MagicID<>10)or(Header.Encoding<>1)Then Begin
  RIReadPCX:=eriInvalidHeader;
  Exit;
 End;
 PLine:=@Line;
 InitReadPackData(XH,Handle,FilePos,SizeOf(Buffer),Buffer);
 Work.Res.NumYPixels:=Header.Y2-Header.Y1+1;
 Work.Res.NumXPixels:=Header.X2-Header.X1+1;
 If(Header.NumPlanes=3)and(Header.BitsPerPixel=8)Then Begin
  Work.Res.BitsPerPixel:=24;
 End
  Else
 If(Header.NumPlanes=4)and(Header.BitsPerPixel=1)Then Begin
  Work.Res.BitsPerPixel:=4;
  Work.Res.NumPal:=16;
 End
  else
 If Header.NumPlanes=1Then Begin
  Work.Res.BitsPerPixel:=Header.BitsPerPixel;
  Case(Header.BitsPerPixel)of
   1,2,4:;
   8:If Header.Version=5Then Begin
    XH.FP:=FileSize(Handle)-(SizeOf(Pal256)+1);
    Work.Res.NumPal:=256;
    _GetAbsRec(Handle,XH.FP,SizeOf(B),B);
    Inc(XH.FP,SizeOf(B));
    If B=12Then _GetAbsRec(Handle,XH.FP,SizeOf(Pal256),Pal256);
    XH.FP:=FilePos+SizeOf(Header)
   End;
   16:;
   Else Exit;
  End;
 End
  Else
 Exit;
 XH.Position:=SizeOf(Buffer);
 XH.FP:=LongInt(SizeOf(Header))+FilePos;
 XH.Format:=INTEL;
 If Header.BytesPerLinePerPlane=0Then Begin
  Work.Res.BytesPerLine:=LenNBits2BytesPerLine(Work.Res.NumXPixels,Work.Res.BitsPerPixel);
  Case(Work.Res.BitsPerPixel)of
   8:If Work.Res.BytesPerLine and 1=1Then Inc(Work.Res.BytesPerLine);
   24:If Work.Res.NumXPixels and 1=1Then Inc(Work.Res.BytesPerLine,3);
  End;
 End
  Else
 Work.Res.BytesPerLine:=Header.BytesPerLinePerPlane*Header.NumPlanes;
 If Work.Res.BytesPerLine>SizeOf(Line)Then Begin
  Work.SizeOfPLine:=Work.Res.BytesPerLine;
  PLine:=MemAlloc(Work.SizeOfPLine);
  If(PLine=NIL)Then Begin
   RIReadPCX:=eriLineTooBig;
   Exit;
  End;
 End;
 FS:=Mul2Word(Work.Res.BytesPerLine,Work.Res.NumYPixels);
 If BestAlloc(Work.Res,Flags,Ressource,SizeOf(Work.Res)+FS+LongInt(Work.Res.NumPal*3),Load,Q)Then Begin
  If(fpViewScr)in(Flags)Then Case(Work.Res.BitsPerPixel)of
   4:SetPalRGB(Header.PaletteRGB,0,16);
   8:SetPalRGB(Pal256,0,256);
  End;
  If(fpProgressBar)in(Flags)Then WEInitProgressBar(W);
  RP:=SizeOf(Work.Res);
  For Y:=0to Work.Res.NumYPixels-1do Begin
    {Lecture d'une ligne}
   {$IFDEF FLAT386}
    FillClr(PLine^,Work.Res.BytesPerLine);
    If Work.Index<>0Then FillChr(PLine^,Work.Index,Data);
    While(Work.Index<Work.Res.BytesPerLine)do Begin
     Data:=ReadByte(XH);
     If Data and$C0=$C0Then Begin
      Len:=Data and$3F;Data:=ReadByte(XH);
      If(Work.Index+Len>Work.Res.BytesPerLine)Then Z:=Work.Res.BytesPerLine-Work.Index-1
                                              Else Z:=Len;
      FillChr(PLine^[Work.Index],Z,Data);Inc(Work.Index,Len)
     End
      Else
     Begin
      PLine^[Work.Index]:=Data;
      Inc(Work.Index)
     End
    End;
    Dec(Work.Index,Work.Res.BytesPerLine);
   {$ELSE}
    ASM
     MOV BX,Work.Index
     LES DI,PLine
     MOV SI,Work.Res.BytesPerLine
     CLD
     MOV CX,SI
     CMP Up32Bits,True
     JNE @16bits
     DB 66h; XOR AX,AX
     OR  BX,BX
     JZ  @30
     MOV CX,BX
     MOV AL,Data
     MOV AH,AL
     SHR CX,1
     REP STOSW
     ADC CX,CX
     REP STOSB
     MOV CX,SI
     SUB CX,BX
     XOR AX,AX
@30: MOV DX,DI
     PUSH BX
      MOV BX,CX
      AND BX,3
      DB  0C1h,0E9h,002h    { SHR CX,2 }
      DB ciREP; DW ciSTOSD  { REP STOSD }
      MOV CX,BX
      REP STOSB
     POP BX
     MOV DI,DX
@3Restart:
     CMP BX,SI
     JNB @End
     CALL @ReadByte
     CMP AL,0C0h
     JB  @39
     XCHG AX,DX
     AND  DX,03Fh
     CALL @ReadByte
     CLD
     MOV AH,AL
     PUSH AX
     PUSH AX
     DW ciPopEAX
     MOV CX,BX
     ADD CX,DX
     CMP CX,SI
     JNA @31
     MOV CX,SI
     DEC CX
 @31:SUB CX,BX
     PUSH BX
      MOV BX,CX
      AND BX,3
      DB  0C1h,0E9h,002h    { SHR CX,2 }
      DB ciREP; DW ciSTOSD  { REP STOSD }
      MOV CX,BX
      REP STOSB
     POP BX
     ADD BX,DX
     JMP @3Restart
@39: STOSB
     INC BX
     JMP @3Restart
@16bits:
     XOR AX,AX
     OR  BX,BX
     JZ  @0
     MOV CX,BX
     MOV AL,Data
     MOV AH,AL
     SHR CX,1
     REP STOSW
     ADC CX,CX
     REP STOSB
     MOV CX,SI
     SUB CX,BX
     XOR AX,AX
@0:  MOV DX,DI
     SHR CX,1
     REP STOSW
     ADC CX,CX
     REP STOSB
     MOV DI,DX
@Restart:
     CMP BX,SI
     JNB @End
     CALL @ReadByte
     CMP AL,0C0h
     JB  @9
     XCHG AX,DX
     AND  DX,03Fh
     CALL @ReadByte
     CLD
     MOV AH,AL
     MOV CX,BX
     ADD CX,DX
     CMP CX,SI
     JNA @1
     MOV CX,SI
     DEC CX
  @1:SUB CX,BX
     SHR CX,1
     REP STOSW
     ADC CX,CX
     REP STOSB
     ADD BX,DX
     JMP @Restart
@9:  STOSB
     INC BX
     JMP @Restart
@ReadByte:
     PUSH SI
      PUSH ES
       PUSH DI
        PUSH DX
         PUSH BX
          PUSH SS
          MOV SI,Offset XH
          ADD SI,BP
          PUSH SI
          CALL ReadByte
         POP BX
        POP DX
       POP DI
      POP ES
     POP SI
     RETN
@End:SUB BX,SI
     MOV Data,AL
     MOV Work.Index,BX
    END;
   {$ENDIF}
   If(Header.NumPlanes=3)and(Header.BitsPerPixel=8)Then Begin
    Conv3Planes2BitMap(Work.Res.BytesPerLine,PLine^);
   End
    Else
   If(Header.NumPlanes=4)and(Header.BitsPerPixel=1)Then Begin
    Conv4Planes2BitMap(Work.Res.BytesPerLine,PLine^);
   End;
    {criture de la ligne dans la ressource}
   If(Load)Then XSetAbsRec(Q,RP,Work.Res.BytesPerLine,PLine^);
   Inc(RP,LongInt(Work.Res.BytesPerLine));
   If(fpProgressBar)in(Flags)Then WEUpDate(W,RP,FS);
   If(fpViewScr)in(Flags)Then BestClrLnHorImg(Y,Work.Res,PLine^);
  End;
  Work.Res.ID:=idResImage;
  Work.Res.Format:=fdiBinary;
  Work.Res.Original:=diPCX;
  XSetAbsRec(Q,0,SizeOf(ImageHeaderRes),Work.Res);
   {Enregistrer les palettes de couleurs s'il y a lieu!}
  Case(Work.Res.NumPal)of
   16:XSetAbsRec(Q,RP,SizeOf(Palette16RGB),Header.PaletteRGB);
   256:XSetAbsRec(Q,RP,SizeOf(Pal256),Pal256);
  End;
  If(fpProgressBar)in(Flags)Then WEDone(W);
  RIReadPCX:=eriNone;
 End
  Else
 RIReadPCX:=eriOutOfMemory;
 If Work.SizeOfPLine>0Then FreeMemory(PLine,Work.SizeOfPLine);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Fonction RIReadBitMapOS2                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: XInf
 Portabilit‚:  Local


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette  fonction  permet  de lire  un fichier  d'image  BitMap du systŠme
 d'exploitation OS/2 et de placer sous contenu dans une ressource d'image.
}

Function RIReadBitMapOS2(Handle:Hdl;Var FilePos:LongInt;Ressource:Byte;
                         Flags:FlagsProcessusImage;Var Q:XInf):Word;Near;
Type
 BitMapInfoOS2Header=Record
  Sign:Array[0..2]of Char;    { Signature de l'Icon 'BM'#26 }
  ResA:Char;ResB:Word;        { R‚serv‚s }
  XCenter,YCenter:Word;       { Milieu X et Y }
  PosAbs,ResC:LongInt;        { Position absolue depuis le d‚but du fichier }
  NumXPixels,NumYPixels:Word; { Largeur et Hauteur de l'image }
  Plane,BitsPerPixel:Word;    { Nombre de plane, Bits par pixel }
 End;
 BARec=Record
  Sign:Array[0..1]of Char;    { Signature 'BA' }
  ResA:Array[2..5]of Byte;    { R‚serv‚s }
  NextEntry:LongInt;          { Offset de l'adresse suivante }
  ResB:Array[10..13]of Byte;  { R‚serv‚s }
 End;
Var
 BIH:BitMapInfoOS2Header;
 BA:BARec Absolute BIH;
 Res:ImageHeaderRes;
 I,FS:LongInt;
 J:Word;
 Buffer:Array[0..2047]of Byte;
 W:Window;
 Load:Boolean;
 Pal256:Palette256RGB;
Begin
  { Recherche de l'entr‚e correspondant au BitMap OS/2 }
 Repeat
  _GetAbsRec(Handle,FilePos,SizeOf(BIH),BIH);
  If BIH.Sign='BA('Then Begin
    { Entr‚e ne contenant rien d'autre qu'une palette? }
   If BA.NextEntry>=FilePos+SizeOf(BIH)+SizeOf(BA)+16*3Then
    FilePos:=BA.NextEntry { Passer … l'entr‚e suivante }
   Else
    Inc(FilePos,14)
  End
   Else
  If BIH.Sign='BM'#26Then Break
   Else
  Begin
   RIReadBitMapOS2:=eriInvalidHeader;
   Exit;
  End;
 Until False;
 If BIH.Sign='BM'#26Then Begin
  FillClr(Res,SizeOf(Res));
  Res.NumXPixels:=BIH.NumXPixels;
  Res.NumYPixels:=BIH.NumYPixels;
  Res.BitsPerPixel:=BIH.BitsPerPixel;
  Case(Res.BitsPerPixel)of
   4:Begin
    Res.BytesPerLine:=Res.NumXPixels shr 3;
    If Res.NumXPixels and 7>0Then Inc(Res.BytesPerLine);
    Res.BytesPerLine:=Res.BytesPerLine shl 2;
   End;
   Else Res.BytesPerLine:=LenNBits2BytesPerLine(Res.NumXPixels,Res.BitsPerPixel);
  End;
  FS:=Mul2Word(Res.BytesPerLine,Res.NumYPixels);
  I:=FilePos+SizeOf(BIH);
  Case(Res.BitsPerPixel)of
   4:Begin
    Res.NumPal:=16;
    _GetAbsRec(Handle,I,SizeOf(Palette16RGB),Pal256);
    Inc(I,LongInt(16*3));
   End;
   8:Begin
    Res.NumPal:=256;
    _GetAbsRec(Handle,I,SizeOf(Palette256RGB),Pal256);
    Inc(I,LongInt(256*3));
   End;
  End;
  If Res.BytesPerLine>SizeOf(Buffer)Then Begin
   RIReadBitMapOS2:=eriLineTooBig;
   Exit;
  End;
  If(fpViewScr)in(Flags)Then Begin
   If Res.NumPal>0Then SetPalRGB(Pal256,0,Res.NumPal);
  End;
  If BestAlloc(Res,Flags,Ressource,SizeOf(Res)+FS+LongInt(Res.NumPal*3),Load,Q)Then Begin
   If(fpProgressBar)in(Flags)Then WEInitProgressBar(W);
   For J:=Res.NumYPixels-1downto 0do Begin
    _GetAbsRec(Handle,I,Res.BytesPerLine,Buffer);
    If(BIH.Plane=4)and(BIH.BitsPerPixel=1)Then Begin
     Conv4Planes2BitMap(Res.BytesPerLine,Buffer);
    End;
    If(Load)Then
     XSetAbsRec(Q,SizeOf(Res)+Mul2Word(J,Res.BytesPerLine),Res.BytesPerLine,Buffer);
    Inc(I,LongInt(Res.BytesPerLine));
    If(fpProgressBar)in(Flags)Then WEUpDate(W,I,FS);
    If(fpViewScr)in(Flags)Then BestClrLnHorImg(J,Res,Buffer);
   End;
    {Enregistrement des palettes de couleurs}
   XSetAbsRec(Q,SizeOf(Res)+I,Res.NumPal*3,Pal256);
    {criture des informations d'entˆte de la ressource d'image}
   Res.Index:=0;Res.ID:=idResImage;Res.Format:=fdiBinary;
   Res.Original:=diBitMapOS2;Res.Descr:='';Res.Shadow:=False;
   XSetAbsRec(Q,0,SizeOf(ImageHeaderRes),Res);
   If(fpProgressBar)in(Flags)Then WEDone(W);
   RIReadBitMapOS2:=eriNone;
  End
   Else
  RIReadBitMapOS2:=eriOutOfMemory;
 End
  Else
 RIReadBitMapOS2:=eriInvalidHeader;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Fonction RIReadBitMapWindows                  Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: XInf
 Portabilit‚:  Local


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de lire un fichier d'image BitMap de Windows et de
 placer sous contenu dans une ressource d'image.
}

Function RIReadBitMapWindows(Handle:Hdl;Var FilePos:Long;Ressource:Byte;
                             Flags:FlagsProcessusImage;Var Q:XInf):Word;Near;
Const SizeOfHeaderBMP=14;
Var
 HBMP:HeaderBMP;
 BIH:BitmapInfoHeader;
 Res:ImageHeaderRes;
 I,FS:LongInt;
 J,IK:Word;
 Palette:Array[0..255]of LongInt;
 Buffer:Array[0..4095]of Byte;
 Pal256:Palette256RGB;
 W:Window;
 Load:Boolean;

 RLE8Header:Record
  First:Byte;
  Second:Byte;
 End;

 DataXY:Record
  X,Y:Byte;
 End;

Begin
 RIReadBitMapWindows:=eriFormatNotFound;
 If Not((fpNoHeader)in(Flags))Then _GetAbsRec(Handle,FilePos,SizeOf(HeaderBMP),HBMP);
 If(HBMP.Sign='BM')or((fpNoHeader)in(Flags))Then Begin
  If Not((fpNoHeader)in(Flags))Then I:=FilePos+SizeOfHeaderBMP
                               Else I:=FilePos;
  _GetAbsRec(Handle,I,SizeOf(BIH),BIH);
  Res.NumXPixels:=BIH.biWidth;Res.NumYPixels:=BIH.biHeight;
  If(Res.NumXPixels=0)or(Res.NumYPixels=0)Then Exit;
  If BIH.biBitCount=16Then Res.BitsPerPixel:=15
                      Else Res.BitsPerPixel:=BIH.biBitCount;
  If BIH.biSizeImage=0Then Begin
   If Res.BitsPerPixel=4Then Begin
    Res.BytesPerLine:=Res.NumXPixels shr 3;
    If Res.NumXPixels and 7>0Then Inc(Res.BytesPerLine);
    Res.BytesPerLine:=Res.BytesPerLine shl 2;
   End
    Else
{   If Res.BitsPerPixel=8Then Begin
    Res.BytesPerLine:=Res.NumXPixels shr 2;
    If Res.NumXPixels and 3>0Then Inc(Res.BytesPerLine,2);
    Res.BytesPerLine:=Res.BytesPerLine shl 2;
   End
    Else}
   If Res.BitsPerPixel<8Then
    Res.BytesPerLine:=LenNBits2BytesPerLine((Res.NumXPixels+7)and$FFF8,Res.BitsPerPixel)
    Else
   Begin
    Res.BytesPerLine:=LenNBits2BytesPerLine((Res.NumXPixels+3)and$FFFC,Res.BitsPerPixel);
   End;
  End
   Else
  Begin
   Res.BytesPerLine:=DivLong(BIH.biSizeImage,BIH.biHeight);
   J:=LenNBits2BytesPerLine(Res.NumXPixels,Res.BitsPerPixel);
   If(Res.BytesPerLine<J)Then J:=Res.BytesPerLine;
  End;
  {ATTENTION! ATTENTION! Contrairement … la logique habituel, la largeur}
  {de l'image en octets ne se calcul pas avec la bonne vieille m‚thode: }
  {ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿}
  {³ BytesPerLine:=LenNBits2BytesPerLine(NumXPixels,BitsPerPixel)      ³}
  {ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
  {mais en divisiant la taille de l'image par son nombre de ligne!}
  If Res.BytesPerLine>SizeOf(Buffer)Then Begin
   RIReadBitMapWindows:=eriLineTooBig;
   Exit;
  End;
  If(BIH.biCompression=bi_RLE8)and(Res.BytesPerLine+256>SizeOf(Buffer))Then Begin
   RIReadBitMapWindows:=eriLineTooBig;
   Exit;
  End;
  Case(BIH.biBitCount)of
   8:Res.NumPal:=256;
   4:Res.NumPal:=16;
   Else Res.NumPal:=0;
  End;
  FS:=Mul2Word(Res.BytesPerLine,Res.NumYPixels);
  If BestAlloc(Res,Flags,Ressource,SizeOf(Res)+FS+Long(Res.NumPal*3),Load,Q)Then Begin
   If(fpProgressBar)in(Flags)Then WEInitProgressBar(W);
   If BIH.biBitCount<=8Then
    _GetAbsRec(Handle,I+SizeOf(BitmapInfoHeader),SizeOf(Palette),Palette);
    {Transformation de la palette de couleurs au format de la ressource}
   Case(BIH.biBitCount)of
    4,8:Conv32to24Swap(Palette,Pal256[0],Res.NumPal);
   End;
   If(fpViewScr)in(Flags)Then Case(Res.BitsPerPixel)of
    8:SetPalRGB(Pal256,0,256);
   End;
    {Chargement de l'image}
   If(fpNoHeader)in(Flags)Then Begin
    Inc(I,BIH.biSize+(Res.NumPal shl 2)-1);
   End
    Else
   I:=FilePos+HBMP.OffBits;
   IK:=0;
   For J:=Res.NumYPixels-1downto 0do Begin
    Case(BIH.biCompression)of
     bi_RLE8,bi_RLE4:Begin
      If IK>0Then MoveLeft(Buffer[Res.BytesPerLine],Buffer,IK);
      If(IK<=Res.BytesPerLine)Then Repeat
       _GetAbsRec(Handle,I,SizeOf(RLE8Header),RLE8Header);
       Inc(I,Long(SizeOf(RLE8Header)));
       If RLE8Header.First<>0Then Begin
        FillChr(Buffer[IK],RLE8Header.First,RLE8Header.Second);
        Inc(IK,RLE8Header.First);
       End
        Else
       Case(RLE8Header.Second)of
        0:Break;
        1:Begin
         BIH.biCompression:=bi_RGB;
         Break;
        End;
        2:Begin
         _GetAbsRec(Handle,I,SizeOf(DataXY),DataXY);
         Inc(I,Long(SizeOf(DataXY)));
         FillClr(Buffer[IK],DataXY.X);
         Inc(IK,DataXY.X);
        End;
        Else Begin
         _GetAbsRec(Handle,I,RLE8Header.Second,Buffer[IK]);
         Inc(I,Long(RLE8Header.Second));
         Inc(IK,RLE8Header.Second);
        End;
       End;
      Until IK>=Res.BytesPerLine;
      If(IK>=Res.BytesPerLine)Then Dec(IK,Res.BytesPerLine)
       Else
      Begin
       FillClr(Buffer[IK],Res.BytesPerLine-IK);
       IK:=0;
      End;
     End;
     Else Begin
      If(IK>0)and(IK+Res.BytesPerLine<SizeOf(Buffer))Then Begin
       MoveLeft(Buffer[IK],Buffer,Res.BytesPerLine);
       Inc(IK,Res.BytesPerLine);
       Inc(I,Long(Res.BytesPerLine));
      End
       Else
      Begin
       _GetAbsRec(Handle,I,SizeOf(Buffer),Buffer);
       IK:=Res.BytesPerLine;
       Inc(I,Long(Res.BytesPerLine));
      End;
     End;
    End;
    If(BIH.biPlanes=3)and(BIH.biBitCount=8)Then Begin
     Conv3Planes2BitMap(Res.BytesPerLine,Buffer);
    End
     Else
    If(BIH.biPlanes=4)and(BIH.biBitCount=1)Then Begin
     Conv4Planes2BitMap(Res.BytesPerLine,Buffer);
    End;
    If(Load)Then
     XSetAbsRec(Q,SizeOf(Res)+Mul2Word(J,Res.BytesPerLine),Res.BytesPerLine,Buffer);
    If(fpProgressBar)in(Flags)Then WEUpDate(W,I,FS);
    If(fpViewScr)in(Flags)Then BestClrLnHorImg(J,Res,Buffer);
   End;
   FilePos:=I; { Fixer le pointeur de fichier … la fin de l'image BitMap }
    {Enregistrement des palettes de couleurs}
   XSetAbsRec(Q,SizeOf(Res)+Mul2Word(Res.BytesPerLine,Res.NumYPixels),Res.NumPal*3,Pal256);
    {criture des informations d'entˆte de la ressource d'image}
   Res.Index:=0;
   Res.ID:=idResImage;
   Res.Format:=fdiBinary;
   Res.Original:=diBitMapWindows;
   Res.Descr:='';
   Res.Shadow:=False;
   XSetAbsRec(Q,0,SizeOf(ImageHeaderRes),Res);
   If(fpProgressBar)in(Flags)Then WEDone(W);
   RIReadBitMapWindows:=eriNone;
  End;
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Fonction RIReadBGX                           Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: XInf
 Portabilit‚:  Local


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de lire un fichier d'image BitMap de format Genesis
 ‚tendue et de placer sous contenu dans une ressource d'image.
}

Function RIReadBGX(Handle:Hdl;FilePos:LongInt;Ressource:Byte;
                   Flags:FlagsProcessusImage;Var Q:XInf):Word;Near;
Var
 BGX:BGXHeader;
 J:Word;
 Res:ImageHeaderRes;
 Buffer:Array[0..2047]of Byte;
 FP:LongInt;
Begin
 RIReadBGX:=eriUnknownFormat;
 _GetAbsRec(Handle,0,SizeOf(BGX),BGX);
 If BGX.Sign='BGX1'Then Begin
  FillClr(Res,SizeOf(Res));
  Res.NumXPixels:=BGX.NumXPixels;
  Res.NumYPixels:=BGX.NumYPixels;
  Res.BitsPerPixel:=BGX.BitsPerPixel;
  Res.BytesPerLine:=LenNBits2BytesPerLine(Res.NumXPixels,Res.BitsPerPixel);
  If Res.BytesPerLine>SizeOf(Buffer)Then Begin
   RIReadBGX:=eriLineTooBig;
   Exit;
  End;
  If XAllocMem(Ressource,SizeOf(Res)+Mul2Word(Res.BytesPerLine,Res.NumYPixels),Q)Then Begin
    {Chargement de l'image}
   Inc(FilePos,SizeOf(BGX));FP:=SizeOf(Res);
   For J:=0to Res.NumYPixels-1do Begin
    _GetAbsRec(Handle,FilePos,Res.BytesPerLine,Buffer);
    XSetAbsRec(Q,FP,Res.BytesPerLine,Buffer);
    Inc(FilePos,Long(Res.BytesPerLine));
    Inc(FP,Long(Res.BytesPerLine));
   End;
    {criture des informations d'entˆte de la ressource d'image}
   Res.ID:=idResImage;
   Res.Format:=fdiBinary;
   Res.Original:=diBGX;
   Res.Descr:='';
   Res.Shadow:=False;
   XSetAbsRec(Q,0,SizeOf(ImageHeaderRes),Res);
   RIReadBGX:=eriNone;
  End
   Else
  RIReadBGX:=eriOutOfMemory;
 End
  Else
 RIReadBGX:=eriInvalidHeader;
End;

Procedure CopyLastImage(Const Source;Var Dest;Len:Word);Assembler;ASM
 {$IFDEF FLAT386}
 {$ELSE}
  CLD
  PUSH DS
   LDS SI,Source
   LES DI,Dest
   MOV CX,Len
   JCXZ @End
@1:
   LODSB
   OR AL,AL
   JNZ @2
   MOV AL,ES:[DI]
   MOV DS:[SI-1],AL
@2:
   INC DI
   LOOP @1
@End:
  POP DS
 {$ENDIF}
END;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Fonction RIReadGIF                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: XInf
 Portabilit‚:  Local


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de lire un fichier d'image de format GIF de
 Compuserve et de placer sous contenu dans une ressource d'image.
}

Function RIReadGIF(Var R:ImageObjectLoader;Var Q:XInf):Word;
Label Restart,Xit,XitAll;
Const
 CodeMask:Array[0..12]of Word=(
  $0000,$0001,$0003,$0007,$000F,$001F,$003F,
  $007F,$00FF,$01FF,$03FF,$07FF,$0FFF
 );
 DecalProgress:Array[0..3]of ShortInt=(-1,3,1,0);

Type
 TDataSubBlock=Record
  Size:Byte;
  Data:Array[1..255]of Byte;
 End;

 TGif=Record
  DecodeStack:Array[0..4095]of Byte; { Toujours en commen‡ement}
  Prefix:Array[0..4095]of Word;      { Toujours dans le mˆme ordre }
  Suffix:Array[0..4095]of Byte;      { et donc ne jamais d‚placer }
  Debug:Array[0..1023]of Byte; { €a plante moins!!! }
 End;

Var
 X:^TGif;
  { Donn‚e de travail d'une des images }
 Work:Record
  SPX:Integer;
  Y:Word;                    { Num‚ro de ligne courant }
  TY:Word;                   { Num‚ro de ligne temporaire }
  CY:Word;
  MC:Word;
  BytesLeft:Integer;
  BitsLeft:Integer;
  OldCode:Word;              { Ancien code }
  CurrBuf:Word;
  FP:LongInt;                { Position temporaire }
 End;
 BufCnt,Code,C,Status,MY,MMY:Word;
 RP,FS:LongInt;
 HighCode:Word;
 NextByte,CurrByte:Byte;
 CurrCodeSize,ClearCode,EndingCode:Integer;
 Slot,TopSlot,BadCodeCount:Word;
 LZWCodeSize:Byte;
 Load:Boolean;
 I:Word;
  { Donn‚e de travail d‚part des images }
 WorkStart:Record
  Res:ImageHeaderRes;         { D‚finition de l'image ressource }
  ProgressDownload:Boolean;
  W:Window;                   { BoŒte de dialogue }
  Background:Byte;
 End;
 LogicalScreen:HeaderGIF;
 GlobalColorTable:Palette256RGB;
 LocalColorTable:Palette256RGB;
 ImageDescriptor:HeaderImageGIF;
 ImageData:TDataSubBlock;
 LineBuffer:Array[0..4095]of Byte;
 PtrLineBuffer:Pointer;
 MPD:Array[0..3]of Word;
 PtrFree:PtrRec;            { Pointeur temporaire }
 _FileSize:LongInt;         { Taille du fichier }
 TmpSize:Word;              { Taille temporaire }
 TRP:LongInt;               { Position temporaire d'effacement }
Begin
 RIReadGIF:=eriNone;Status:=eriNone;
 PtrLineBuffer:=@LineBuffer;
 X:=MemAlloc(SizeOf(TGif));
 If(X<>NIL)Then Begin
  FillClr(WorkStart.Res,SizeOf(WorkStart.Res));
  If R.MaxY=0Then R.MaxY:=$FFFF;
  Q.Output:=$FF;
  _FileSize:=FileSize(R.Handle);
  _GetAbsRec(R.Handle,R.FilePos,SizeOf(LogicalScreen),LogicalScreen);
  Inc(R.FilePos,SizeOf(LogicalScreen));{}
  If LogicalScreen.Sign<>'GIF'Then Begin
   Status:=eriInvalidHeader;
   Goto Xit;
  End;
  WorkStart.Res.BitsPerPixel:=(LogicalScreen.ExtInfo and$7)+1;
  If LogicalScreen.ExtInfo and $80=$80Then Begin
   WorkStart.Res.NumPal:=1 shl WorkStart.Res.BitsPerPixel;
   _GetRec(R.Handle,WorkStart.Res.NumPal*SizeOf(RGB),GlobalColorTable);
   Inc(R.FilePos,LongInt(WorkStart.Res.NumPal*SizeOf(RGB))){}
  End;
  WorkStart.Res.NumXPixels:=LogicalScreen.NumXPixels;
  If(LogicalScreen.NumYPixels>=R.MaxY)Then LogicalScreen.NumYPixels:=R.MaxY Else
  If(R.MaxY>LogicalScreen.NumYPixels)Then R.MaxY:=LogicalScreen.NumYPixels;
  WorkStart.Res.NumYPixels:=LogicalScreen.NumYPixels;
  WorkStart.Res.BytesPerLine:=LenNBits2BytesPerLine(WorkStart.Res.NumXPixels,WorkStart.Res.BitsPerPixel);
  FS:=Mul2Word(WorkStart.Res.BytesPerLine,WorkStart.Res.NumYPixels);
  If WorkStart.Res.BytesPerLine>SizeOf(LineBuffer)Then Begin
   RIReadGIF:=eriLineTooBig;
   Exit;
  End;
  If(fpAllImage)in(R.Option)Then Begin
   If MaxAvail<65520Then R.SizeAnim:=MaxAvail
                    Else R.SizeAnim:=65520;
   R.Anim:=MemAlloc(R.SizeAnim);
  End;
  WorkStart.Res.ID:=idResImage;
  WorkStart.Res.Format:=fdiBinary;
  WorkStart.Res.Original:=diGIF;
  Repeat
   FillClr(Work,SizeOf(Work));
   MY:=1;
   If BestAlloc(WorkStart.Res,R.Option,R.Ressource,SizeOf(WorkStart.Res)+FS+
                LongInt(WorkStart.Res.NumPal*3),Load,Q)Then Begin
    If(fpProgressBar)in(R.Option)Then WEInitProgressBar(WorkStart.W);
    WorkStart.Res.Index:=R.NumAnim;
Restart:
    _GetRec(R.Handle,SizeOf(ImageDescriptor),ImageDescriptor);
    If ImageDescriptor.Seperator<>$2CThen Begin
     If ImageDescriptor.Seperator=$21Then Begin { S'agit-il d'une remarque? }
      I:=Hi(ImageDescriptor.X1)+4;
      Repeat
       _GetAbsRec(R.Handle,R.FilePos,I,LineBuffer);
       Inc(R.FilePos,LongInt(I));
       If LineBuffer[I-1]=0Then Break;
       I:=LineBuffer[I-1]+1;
      Until False;
      Goto Restart;
     End;
     RIReadGIF:=eriImagePreceded;
     Goto Xit;
    End;
    Inc(Work.FP,LongInt(SizeOf(ImageDescriptor)));
    If(fpAllImage)in(R.Option)Then Begin
{     WorkStart.Res.NumXPixels:=ImageDescriptor.NumXPixels+ImageDescriptor.X1;
     WorkStart.Res.BytesPerLine:=LenNBits2BytesPerLine(WorkStart.Res.NumXPixels,WorkStart.Res.BitsPerPixel);}
     WorkStart.Res.NumYPixels:=ImageDescriptor.NumYPixels+ImageDescriptor.Y1;
     Work.Y:=ImageDescriptor.Y1;
    End;
    RP:=SizeOf(ImageHeaderRes)+Mul2Word(WorkStart.Res.NumYPixels,WorkStart.Res.BytesPerLine);
    WorkStart.ProgressDownload:=ImageDescriptor.ExtInfo and $40=$40;
    If(WorkStart.ProgressDownload)Then Begin
     MPD[0]:=WorkStart.Res.NumYPixels shr 3;
     MPD[1]:=WorkStart.Res.NumYPixels shr 3;
     MPD[2]:=WorkStart.Res.NumYPixels shr 2;
     MPD[3]:=WorkStart.Res.NumYPixels shr 1;
    End;
    If ImageDescriptor.ExtInfo and $80=$80Then Begin
     WorkStart.Res.NumPal:=1 shl((ImageDescriptor.ExtInfo and$7)+1);
     TmpSize:=WorkStart.Res.NumPal*SizeOf(RGB);
     _GetRec(R.Handle,TmpSize,LocalColorTable);
     Inc(Work.FP,LongInt(TmpSize));
     XSetAbsRec(Q,RP,SizeOf(Palette256RGB),LocalColorTable);
     If(fpViewScr)in(R.Option)Then SetPalRGB(LocalColorTable,0,256);
    End
     Else
    Begin
     XSetAbsRec(Q,RP,SizeOf(Palette256RGB),GlobalColorTable);
     If(fpViewScr)in(R.Option)Then SetPalRGB(GlobalColorTable,0,256);
    End;
    If(fpAllImage)in(R.Option)Then Begin
     RP:=SizeOf(WorkStart.Res)+Mul2Word(ImageDescriptor.Y1,WorkStart.Res.BytesPerLine);
    End
     Else
    RP:=SizeOf(WorkStart.Res);
    MMY:=WorkStart.Res.NumYPixels;
    If WorkStart.Res.BitsPerPixel>4Then WorkStart.Res.BitsPerPixel:=8;
    XSetAbsRec(Q,0,SizeOf(WorkStart.Res),WorkStart.Res);
    _GetRec(R.Handle,SizeOf(Byte),LZWCodeSize);
    Inc(Work.FP);
    ASM
      {If Not(LZWCodeSize in[2..9])Then Begin
        RIReadGIF:=eriBadCodeSize;
        Goto Xit;
       End;}
     MOV CL,LZWCodeSize
     CMP CL,2
     JNB @1
@ErrBadCodeSize:
     MOV @Result,eriBadCodeSize
     JMP Xit
@1:  CMP CL,9
     JA  @ErrBadCodeSize
      {CurrCodeSize:=Succ(LZWCodeSize);
       ClearCode:=1 shl LZWCodeSize;}
     MOV CH,0
     MOV AX,1
     SHL AX,CL
     MOV Word Ptr ClearCode,AX
     INC CX
     MOV Word Ptr CurrCodeSize,CX
     {EndingCode:=Succ(ClearCode);
      HighCode:=Pred(ClearCode);}
     MOV BX,AX
     INC BX
     MOV Word Ptr EndingCode,BX
     DEC AX
     MOV HighCode,AX
    END;
    BufCnt:=ImageDescriptor.NumXPixels;
    If Work.BitsLeft=0Then Begin
     If Work.BytesLeft<=0Then Begin
      _GetRec(R.Handle,SizeOf(ImageData.Size),ImageData.Size);
      _GetRec(R.Handle,ImageData.Size,ImageData.Data);
      Inc(Work.FP,LongInt(SizeOf(ImageData.Size)+ImageData.Size));
      NextByte:=1;
      Work.BytesLeft:=ImageData.Size;
     End;
     CurrByte:=ImageData.Data[NextByte];
     Inc(NextByte);
     Work.BitsLeft:=8;
     Dec(Work.BytesLeft);
    End;
    C:=CurrByte shr(8-Work.BitsLeft);
    While(CurrCodeSize>Work.BitsLeft)do Begin
     If Work.BytesLeft<=0Then Begin
      _GetRec(R.Handle,SizeOf(ImageData.Size),ImageData.Size);
      _GetRec(R.Handle,ImageData.Size,ImageData.Data);
      Inc(Work.FP,LongInt(SizeOf(ImageData.Size)+ImageData.Size));
      NextByte:=1;
      Work.BytesLeft:=ImageData.Size;
     End;
     ASM
      {CurrByte:=ImageData.Data[NextByte];
       Inc(NextByte);}
      MOV AL,NextByte
      PUSH DS
       PUSH SS
       POP DS
       MOV BX,Offset ImageData
       ADD BX,BP
       XLAT
      POP DS
      INC NextByte
      MOV CurrByte,AL
       {C:=C or(CurrByte shl BitsLeft);}
       {Inc(BitsLeft,8);}
      MOV CL,Byte Ptr Work.BitsLeft
      SHL AX,CL
      OR  C,AX
      ADD CL,8
      MOV Byte Ptr Work.BitsLeft,CL
     END;
     Dec(Work.BytesLeft);
    End;
    ASM
     {Dec(BitsLeft,CurrCodeSize);}
     MOV BX,Word Ptr CurrCodeSize
     SUB Word Ptr Work.BitsLeft,BX
     {C:=C and CodeMask[CurrCodeSize];}
     SHL BX,1
     {$IFDEF FLAT386}
      AND EBX,0FFFFh
      MOV AX,Word Ptr CodeMask[EBX]
     {$ELSE}
      MOV AX,Word Ptr CodeMask[BX]
     {$ENDIF}
     AND C,AX
    END;
    While(C<>EndingCode)do Begin
     If(fpUserInterrupt)in(R.Option)Then Begin
      If(KeyPress)and(Systems.ReadKey=kbEsc)Then Begin
       If(UserCancel)Then Begin
        Status:=eriUserCancel;
        Goto Xit;
       End;
      End;
     End;
     If(C=ClearCode)Then Begin
      CurrCodeSize:=LZWCodeSize+1;
      Slot:=EndingCode+1;
      TopSlot:=1 shl CurrCodeSize;
      While(C=ClearCode)do Begin
       If Work.BitsLeft=0Then Begin
        If Work.BytesLeft<=0Then Begin
         _GetRec(R.Handle,SizeOf(ImageData.Size),ImageData.Size);
         _GetRec(R.Handle,ImageData.Size,ImageData.Data);
         Inc(Work.FP,LongInt(SizeOf(ImageData.Size)+ImageData.Size));
         NextByte:=1;Work.BytesLeft:=ImageData.Size;
        End;
        CurrByte:=ImageData.Data[NextByte];
        Inc(NextByte);
        Work.BitsLeft:=8;
        Dec(Work.BytesLeft);
       End;
       C:=CurrByte shr(8-Work.BitsLeft);
       While(CurrCodeSize>Work.BitsLeft)do Begin
        If Work.BytesLeft<=0Then Begin
         _GetRec(R.Handle,SizeOf(ImageData.Size),ImageData.Size);
         _GetRec(R.Handle,ImageData.Size,ImageData.Data);
         Inc(Work.FP,LongInt(SizeOf(ImageData.Size)+ImageData.Size));
         NextByte:=1;Work.BytesLeft:=ImageData.Size;
        End;
        ASM
         {CurrByte:=ImageData.Data[NextByte];
          Inc(NextByte);}
         MOV AL,NextByte
         PUSH DS
          PUSH SS
          POP DS
          MOV BX,Offset ImageData
          ADD BX,BP
          XLAT
         POP DS
         INC NextByte
         MOV CurrByte,AL
          {C:=C or(CurrByte shl BitsLeft);}
          {Inc(BitsLeft,8);}
         MOV CL,Byte Ptr Work.BitsLeft
         SHL AX,CL
         OR  C,AX
         ADD CL,8
         MOV Byte Ptr Work.BitsLeft,CL
        END;
        Dec(Work.BytesLeft);
       End;
       ASM
         {Dec(BitsLeft,CurrCodeSize);}
        MOV BX,Word Ptr CurrCodeSize
        SUB Word Ptr Work.BitsLeft,BX
         {C:=C and CodeMask[CurrCodeSize];}
        SHL BX,1
        {$IFDEF FLAT386}
         AND EBX,0FFFFh
         MOV AX,Word Ptr CodeMask[EBX]
        {$ELSE}
         MOV AX,Word Ptr CodeMask[BX]
        {$ENDIF}
        AND C,AX
       END;
      End;
      {$IFDEF FLAT386}
        If(C=EndingCode)Then Begin
         Status:=eriBadCode;
         Goto Xit;
        End;
        If(C>=Slot)Then C:=0;
        Work.OldCode:=C;
        X^.DecodeStack[Work.SPX]:=C;
        Inc(Work.SPX);
      {$ELSE}
       ASM
        {If(C=EndingCode)Then Begin
          Status:=eriBadCode;
          Goto Xit;
         End;}
        MOV CX,C
        CMP CX,Word Ptr EndingCode
        JNE @1
        MOV Status,eriBadCode
        JMP Xit
        { If(C>=Slot)Then C:=0;
          Work.OldCode:=C;
          X^.DecodeStack[Work.SPX]:=C;
          Inc(Work.SPX);}
     @1:CMP CX,Slot
        JNAE @2
        XOR CX,CX
        MOV C,CX
 @2:    MOV Work.OldCode,CX
        LES DI,X
        ADD DI,Word Ptr Work.SPX
        MOV ES:[DI],CL
        INC Work.SPX
       END;
      {$ENDIF}
     End
      Else
     Begin
      Code:=C;
      If(Code<Slot)Then Begin
       ASM
        {While(Code>HighCode)do Begin
         X^.DecodeStack[SPX]:=X^.Suffix[Code];
         Inc(SPX);
         Code:=X^.Prefix[Code];
        End;
        X^.DecodeStack[SPX]:=Code;
        Inc(SPX);}
        {$IFDEF FLAT386}
         LEA ESI,X
         MOV DX,HighCode
         MOVZX EBX,Code
         MOVZX EDI,Word Ptr Work.SPX
         ADD EDI,ESI
         {ADD DI,TGif.DecodeStack} {Cette instruction n'est pas n‚cessaire
                                    parce que c'est le premier de
                                    l'enregistrement}
@Restart:CMP BX,DX
         JNA @EndWhile
         MOV AL,Byte Ptr [ESI].TGif.Suffix[EBX]
         STOSB
         SHL BX,1
         MOV BX,Word Ptr [ESI].TGif.Prefix[EBX]
         JMP @Restart
@EndWhile:
         MOV Code,BX
         XCHG AX,BX
         STOSB
         SUB EDI,ESI
         MOV Word Ptr Work.SPX,DI
        {$ELSE}
         PUSH DS
          LES SI,X
          PUSH ES
          POP DS
          MOV DX,HighCode
          MOV BX,Code
          MOV DI,Work.SPX
          ADD DI,SI
          {ADD DI,TGif.DecodeStack} {Cette instruction n'est pas n‚cessaire
                                     parce que c'est le premier de
                                     l'enregistrement}
 @Restart:CMP BX,DX
          JNA @EndWhile
          MOV AL,Byte Ptr DS:[SI].TGif.Suffix[BX]
          STOSB
          SHL BX,1
          MOV BX,Word Ptr DS:[SI].TGif.Prefix[BX]
          JMP @Restart
@EndWhile:MOV Code,BX
          XCHG AX,BX
          STOSB
          SUB DI,SI
          MOV Work.SPX,DI
          {If(Slot<=TopSlot)Then Begin
           X^.Suffix[Slot]:=Code;
           X^.PreFix[Slot]:=OldCode;
           Inc(Slot);
           OldCode:=C;
          End;}
          MOV BX,Slot
          MOV DX,TopSlot
          CMP BX,DX
          JNBE @3
          MOV Byte Ptr DS:[SI].TGif.Suffix[BX],AL
          MOV CX,Work.OldCode
          SHL BX,1
          MOV Word Ptr DS:[SI].TGif.Prefix[BX],CX
          SHR BX,1
          INC BX
          MOV AX,C
          MOV Work.OldCode,AX
@3:        {If(Slot>=TopSlot)and(CurrCodeSize<12)Then Begin
             ASM SHL TopSlot,1;END;
             Inc(CurrCodeSize)
            End;}
          CMP BX,DX
          JNAE @4
          CMP CurrCodeSize,12
          JNB  @4
          SHL DX,1
          INC CurrCodeSize
@4:       MOV TopSlot,DX
          MOV Slot,BX
         POP DS
        {$ENDIF}
       END;
      End
       Else
      Begin
       If(Code<>Slot)Then Begin
        Status:=eriBadCode;
        Goto Xit;
       End;
       ASM
        {$IFDEF FLAT386}
         LEA ESI,X
         MOV DX,HighCode
         MOVZX EBX,Code
         MOVZX EDI,Word Ptr Work.SPX
         ADD EDI,ESI
         {ADD DI,TGif.DecodeStack} {Cette instruction n'est pas n‚cessaire
                                    parce que c'est le premier de
                                    l'enregistrement}
@Restart:
         CMP BX,DX
         JNA @EndWhile
         MOV AL,Byte Ptr [ESI].TGif.Suffix[EBX]
         STOSB
         SHL BX,1
         MOV BX,Word Ptr [ESI].TGif.Prefix[EBX]
         JMP @Restart
 @EndWhile:
         MOV Code,BX
         XCHG AX,BX
         STOSB
         SUB EDI,ESI
         MOV Word Ptr Work.SPX,DI
        {$ELSE}
         {TempOldCode:=OldCode;
          While(OldCode>HighCode)do Begin
           X^.DecodeStack[SPX]:=X^.Suffix[OldCode];
           OldCode:=X^.Prefix[OldCode];
          End;
          X^.DecodeStack[SPX]:=OldCode;}
         PUSH DS
          LES SI,X
          PUSH ES
          POP DS
          MOV DX,HighCode
          MOV BX,Work.OldCode
          MOV CX,BX
          MOV DI,Work.SPX
          ADD DI,SI
 @RestartD:
          CMP BX,DX
          JNA @EndWhileD
          MOV AL,Byte Ptr DS:[SI].TGif.Suffix[BX]
          STOSB
          SHL BX,1
          MOV BX,Word Ptr DS:[SI].TGif.Prefix[BX]
          JMP @RestartD
 @EndWhileD:
          MOV Work.OldCode,BX
          XCHG AX,BX
          STOSB
          {If(Slot<=TopSlot)Then Begin
            X^.Suffix[Slot]:=OldCode;
            X^.Prefix[Slot]:=TempOldCode;
            Inc(Slot);
           End;}
          MOV BX,Slot
          MOV DX,TopSlot
          CMP BX,DX
          JNBE @3D
          MOV Byte Ptr DS:[SI].TGif.Suffix[BX],AL
          SHL BX,1
          MOV Word Ptr DS:[SI].TGif.Prefix[BX],CX
          SHR BX,1
          INC BX
         { If(Slot>=TopSlot)and(CurrCodeSize<12)Then Begin
            ASM SHL TopSlot,1;END;
            Inc(CurrCodeSize)
           End;}
 @3D:     CMP BX,DX
          JNAE @4D
          CMP CurrCodeSize,12
          JNB  @4D
          SHL DX,1
          INC CurrCodeSize
 @4D:     MOV TopSlot,DX
          MOV Slot,BX
          {While(Code>HighCode)do Begin
           X^.DecodeStack[SPX]:=X^.Suffix[Code];
           Inc(SPX);
           Code:=X^.Prefix[Code];
          End;
          X^.DecodeStack[SPX]:=Code;Inc(SPX);}
          MOV DX,HighCode
          MOV BX,Code
          MOV DI,Work.SPX
          ADD DI,SI
          {ADD DI,TGif.DecodeStack} {Cette instruction n'est pas n‚cessaire
                                     parce que c'est le premier de
                                     l'enregistrement}
  @Restart:
          CMP BX,DX
          JNA @EndWhile
          MOV AL,Byte Ptr DS:[SI].TGif.Suffix[BX]
          STOSB
          SHL BX,1
          MOV BX,Word Ptr DS:[SI].TGif.Prefix[BX]
          JMP @Restart
  @EndWhile:
          MOV Code,BX
          XCHG AX,BX
          STOSB
          SUB DI,SI
          MOV Work.SPX,DI
         POP DS
        {$ENDIF}
       END;
       Work.OldCode:=C;
      End;
     End;
     While Work.SPX>0do Begin
      ASM
        {Dec(Work.SPX);LineBuffer[CurrBuf]:=X^.DecodeStack[Work.SPX];
        Inc(CurrBuf);Dec(BufCnt);}
       CLD
       PUSH DS
        MOV CX,BufCnt
        MOV DX,Work.CurrBuf
        MOV BX,Word Ptr Work.SPX
        LDS SI,X
        ADD SI,Offset TGif.DecodeStack
        ADD SI,BX
        LES DI,PtrLineBuffer
        ADD DI,DX
 @1:    DEC BX
        DEC SI
        MOVSB
        DEC SI
        INC DX
        OR  BX,BX
        JZ  @2
        DEC CX
        JNZ @1
        JMP @3
 @2:    DEC CX
 @3:    MOV Word Ptr Work.SPX,BX
        MOV BufCnt,CX
        MOV Work.CurrBuf,DX
       POP DS
      END;
      If BufCnt=0Then Begin
       If(fpAllImage)in(R.Option)Then Begin
        If(R.NumAnim=0)and(Work.Y=0)Then Begin
         If WorkStart.Res.BitsPerPixel=4Then WorkStart.Background:=LineBuffer[0]+(LineBuffer[0]shl 4)
                                        Else WorkStart.Background:=LineBuffer[0];
        End;
        If ImageDescriptor.X1>0Then Begin
         MoveRight(LineBuffer,LineBuffer[ImageDescriptor.X1],ImageDescriptor.NumXPixels);
         FillChr(LineBuffer,ImageDescriptor.X1,WorkStart.Background);
        End;
       End;
       If WorkStart.Res.BitsPerPixel=4Then Begin
        Conv8To4BitsKr(LineBuffer,LineBuffer,WorkStart.Res.NumXPixels shr 1);
       End;
       If(WorkStart.ProgressDownload)Then Begin
        If Work.MC<=3Then Begin
         Work.TY:=Work.CY*(WorkStart.Res.NumYPixels div MPD[Work.MC])+DecalProgress[Work.MC];
         If Work.TY>32000Then Work.TY:=WorkStart.Res.NumYPixels-1;
         Inc(Work.CY);
         If Work.CY>=MPD[Work.MC]Then Begin
          Work.CY:=0;
          Inc(Work.MC);
         End;
        End;
       End
        Else
       Work.TY:=Work.Y;
       If(Load)Then Begin
        If(WorkStart.ProgressDownload)Then
         XSetAbsRec(Q,SizeOf(WorkStart.Res)+Mul2Word(WorkStart.Res.BytesPerLine,Work.TY),
                    WorkStart.Res.BytesPerLine,LineBuffer)
        Else
         XSetAbsRec(Q,RP,WorkStart.Res.BytesPerLine,LineBuffer);
       End;
       Inc(RP,Long(WorkStart.Res.BytesPerLine));
       If(fpProgressBar)in(R.Option)Then WEUpDate(WorkStart.W,RP,FS);
       If(fpViewScr)in(R.Option)Then BestClrLnHorImg(Work.TY,WorkStart.Res,LineBuffer);
       Inc(Work.Y);
       If(Work.Y>=R.MaxY)Then Goto Xit;
       Work.CurrBuf:=0;
       BufCnt:=ImageDescriptor.NumXPixels;
       If(fpAllImage)in(R.Option)Then Begin
        If(ImageDescriptor.Y1+1=Work.Y)Then Begin
         FillChr(LineBuffer,WorkStart.Res.BytesPerLine,WorkStart.Background);
         TRP:=SizeOf(ImageHeaderRes);
         {$IFNDEF __Windows__}
          For Work.TY:=0to Work.Y-1do Begin
           XSetAbsRec(Q,TRP,WorkStart.Res.BytesPerLine,LineBuffer);
           Inc(TRP,WorkStart.Res.BytesPerLine);
          End;
         {$ENDIF}
        End;
       End;
      End;
     End;
     If Work.BitsLeft=0Then Begin
      If Work.BytesLeft<=0Then Begin
       _GetRec(R.Handle,SizeOf(ImageData.Size),ImageData.Size);
       _GetRec(R.Handle,ImageData.Size,ImageData.Data);
       Inc(Work.FP,LongInt(SizeOf(ImageData.Size)+ImageData.Size));
       NextByte:=1;Work.BytesLeft:=ImageData.Size;
      End;
      CurrByte:=ImageData.Data[NextByte];
      Inc(NextByte);
      Work.BitsLeft:=8;
      Dec(Work.BytesLeft);
     End;
     C:=CurrByte shr(8-Work.BitsLeft);
     While(CurrCodeSize>Work.BitsLeft)do Begin
      If Work.BytesLeft<=0Then Begin
       _GetRec(R.Handle,SizeOf(ImageData.Size),ImageData.Size);
       _GetRec(R.Handle,ImageData.Size,ImageData.Data);
       Inc(Work.FP,LongInt(SizeOf(ImageData.Size)+ImageData.Size));
       NextByte:=1;
       Work.BytesLeft:=ImageData.Size;
      End;
      ASM
        {CurrByte:=ImageData.Data[NextByte];
         Inc(NextByte);}
        MOV AL,NextByte
        PUSH DS
         PUSH SS
         POP DS
         MOV BX,Offset ImageData
         ADD BX,BP
         XLAT
        POP DS
        INC NextByte
        MOV CurrByte,AL
        {C:=C or(CurrByte shl BitsLeft);}
        {Inc(BitsLeft,8);}
       MOV CL,Byte Ptr Work.BitsLeft
       SHL AX,CL
       OR  C,AX
       ADD CL,8
       MOV Byte Ptr Work.BitsLeft,CL
      END;
      Dec(Work.BytesLeft);
     End;
     ASM
       {Dec(BitsLeft,CurrCodeSize);}
      MOV BX,Word Ptr CurrCodeSize
      SUB Word Ptr Work.BitsLeft,BX
       {C:=C and CodeMask[CurrCodeSize];}
      SHL BX,1
      {$IFDEF FLAT386}
       AND EBX,0FFFFh
       MOV AX,Word Ptr CodeMask[EBX]
      {$ELSE}
       MOV AX,Word Ptr CodeMask[BX]
      {$ENDIF}
      AND C,AX
     END;
    End;
   End
    Else
   Begin
    Status:=eriOutOfMemory;
    Break;
   End;
Xit:
   If((fpAllImage)in(R.Option))and(Work.FP>0)Then Begin
    ImageData.Size:=1;
    Inc(Work.FP,LongInt(ImageData.Size));
    _GetRec(R.Handle,ImageData.Size,ImageData.Data);
   End;
   If(fpAllImage)in(R.Option)Then Begin
    If Work.FP=0Then Break;
    Inc(R.FilePos,LongInt(Work.FP));
    If(_FileSize<=R.FilePos)Then Break;
    R.Anim^[R.NumAnim]:=Q;
    If(R.NumAnim>0)and(WorkStart.Res.BitsPerPixel=8)Then Begin
     RP:=SizeOf(WorkStart.Res);
     {$IFNDEF __Windows__}
      For Work.Y:=0to WorkStart.Res.NumYPixels-1do Begin
       XGetAbsRec(R.Anim^[R.NumAnim-1],RP,WorkStart.Res.BytesPerLine,LineBuffer[2048]);
       XGetAbsRec(Q,RP,WorkStart.Res.BytesPerLine,LineBuffer);
       CopyLastImage(LineBuffer,LineBuffer[2048],WorkStart.Res.BytesPerLine);
       XSetAbsRec(Q,RP,WorkStart.Res.BytesPerLine,LineBuffer);
       Inc(RP,LongInt(WorkStart.Res.BytesPerLine));
      End;
     {$ELSE}
     {$ENDIF}
    End;
    Inc(R.NumAnim);
   End;
  Until Not((fpAllImage)in(R.Option));
XitAll:
  If(fpAllImage)in(R.Option)Then Begin
   If R.NumAnim=0Then _FreeMemory(Pointer(R.Anim),R.SizeAnim)
    Else
   Begin
    Pointer(PtrFree):=Pointer(R.Anim);
    Inc(PtrFree.Seg,((R.NumAnim+1)*(SizeOf(XInf)+1))shr 4);
    FreeMemory(Pointer(PtrFree),R.SizeAnim-((R.NumAnim+1)*(SizeOf(XInf)+1)));
    R.SizeAnim:=(R.NumAnim+1)*(SizeOf(XInf)+1);
   End;
  End;
  If(fpProgressBar)in(R.Option)Then WEDone(WorkStart.W);
  If(Status<>eriNone)Then XFreeMem(Q);
  RIReadGIF:=Status;
  FreeMemory(X,SizeOf(TGif));
 End
  Else
 RIReadGIF:=eriOutOfMemory;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                      Fonction RIReadTIFF                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: XInf
 Portabilit‚:  Local


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de lire un fichier d'image de format TIFF
 universel et de placer sous contenu dans une ressource d'image.
}

Function RIReadTIFF(Handle:Hdl;FilePos:Long;Ressource:Byte;
                    Flags:FlagsProcessusImage;Var Q:XInf):Word;Near;
Var
 Header:Array[0..15]of Char;   { Contiendra l'En-tˆte }
 NumberType:Word;              { Num‚ro de format de stockage }
 SignType:Array[0..1]of Char Absolute NumberType;
 Version:Word;                 { Version de TIFF }
 Entries:Word;                 { Nombres d'entr‚es }
 SubFile:Word;                 { Type sous-fichier }
 Samples:Word;                 { "Samples" }
 PlanCfg:Word;                 { Configuration de plan }
 Compres:Word;                 { Type de compression }
 PhotMet:Word;                 { Interpr‚tation Photom‚trique }
 Offset:LongInt;               { Offset TIFF }
 RowStrip:LongInt;
 StripOff:LongInt;             { o— se situe le 1ier }
 StripCnt:LongInt;             { Combien il y en a-t-il? }
 ByteCnt:LongInt;
 ImageSize:LongInt;            { Taille tampon pour l'image }
 ImageStart:LongInt;           { Premier octet de l'image }
 XH:HandleExtended;            { Handle de lecture par octet }
 Buffer:Array[0..4095]of Byte; { Tampon de lecture }
 I:Word;                       { Compteur de boucle }
 Res:ImageHeaderRes;           { Information d'entˆte de l'image charg‚e }
 FP:LongInt;                   { Position dans la ressource }
 L:Long;
 I2,N:Integer;
 P:^TByte;
 Load:Boolean;
 W:Window;

 Function DecodeTag:LongInt;
 Var
  Length,Offset:LongInt;
  Tag,_Type:Integer;
 Begin
  Tag:=ReadWord(XH);
  _Type:=ReadWord(XH);
  Length:=ReadLong(XH);
  Offset:=ReadLong(XH);
  If(_Type<>tiffLong)Then Begin
   Length:=Length and$FFFF;
   Offset:=Offset and$FFFF;
  End;
  Case(Tag)of
   tiffSubfileType:SubFile:=Offset;
   tiffImageWidth:Begin
    Res.NumXPixels:=Offset;
    Res.BytesPerLine:=(Res.NumXPixels+7)shr 3;
   End;
   tiffImageLength:Res.NumYPixels:=Offset;
   tiffRowsPerStrip:RowStrip:=Offset;
   tiffStripOffsets:Begin
    StripOff:=Offset;
    StripCnt:=Length;
   End;
   tiffStripByteCounts:ByteCnt:=Offset;
   tiffSamplesPerPixel:Samples:=Offset;
   tiffBitsPerSample:Res.BitsPerPixel:=Offset;
   tiffPlanarConfiguration:PlanCfg:=Offset;
   tiffCompression:Compres:=Offset;
   tiffGroup3Options:;
   tiffGroup4Options:;
   tiffFillOrder:;
   tiffThreshholding:;
   tiffCellWidth:;
   tiffCellLength:;
   tiffMinSampleValue:;
   tiffMaxSampleValue:;
   tiffPhotometricInterp:Begin
    If _Type and 2=2Then Res.BitsPerPixel:=24;
    PhotMet:=Offset;
   End;
   tiffGrayResponseUnit:;
   tiffGrayResponseCurve:;
   tiffColorResponseUnit:;
   tiffColorResponseCurves:;
   tiffXResolution:;
   tiffYResolution:;
   tiffResolutionUnit:;
   tiffOrientation:;
   tiffDocumentName:;
   tiffPageName:;
   tiffXPosition:;
   tiffYPosition:;
   tiffPageNumber:;
   tiffImageDescription:;
   tiffMake:;
   tiffModel:;
   tiffFreeOffsets:;
   tiffFreeByteCounts:;
  End;
  DecodeTag:=Length;
 End;

  { Lit et d‚code une ligne dans ®p¯ }
 Function ReadLine(Var P:Array of Byte):Word;
 Var
  N,C,I:Integer;
 Begin
  N:=0;ReadLine:=eriNone;
  FillClr(P,Res.BytesPerLine);
  Case(Compres)of
   tiffCompNone:Begin
    N:=ReadBuf(XH,Res.BytesPerLine,P);
    If PhotMet=1Then For I:=0to Res.BytesPerLine-1do P[I]:=Not P[I];
   End;
   tiffCompMpnt:Begin
    Repeat
     C:=ReadByte(XH);
     If(C)and$80=$80Then Begin
      If C<>$80Then Begin
       I:=((Not C)and$FF)+2;C:=ReadByte(XH);
       If PhotMet=1Then Begin
        While I<>0do Begin
         Dec(I);P[N]:=Not C;Inc(N);
        End
       End
        Else
       While i<>0do Begin
        Dec(I);P[N]:=ReadByte(XH);Inc(N);
       End;
      End;
     End;
    Until N>=Res.BytesPerLine;
   End;
{   Else RIReadTIFF:=eriInvalidData;}
  End;
 End;

Begin
 NumberType:=0;Version:=0;Entries:=0;SubFile:=0;Samples:=0;PlanCfg:=0;
 Compres:=1;PhotMet:=0;Offset:=0;RowStrip:=0;StripOff:=0;StripCnt:=0;
 ByteCnt:=0;ImageSize:=0;ImageStart:=0;
 FillClr(XH,SizeOf(XH));
 FillClr(Res,SizeOf(Res));
 FillClr(W,SizeOf(W));
 XH.Handle:=Handle;
 XH.Buffer:=@Buffer;
 XH.Size:=SizeOf(Buffer);
 XH.Position:=XH.Size;
 XH.FP:=FilePos;
 XH.Format:=INTEL;
 NumberType:=ReadWord(XH);
 If(SignType='MM')or(SignType='II')Then Begin
  If SignType='MM'Then XH.Format:=Motorola;
  Version:=ReadWord(XH);Offset:=ReadLong(XH);
  XH.FP:=ImageStart+Offset;
  Entries:=ReadWord(XH);
  For I:=0to Entries-1do DecodeTag;
  PhotMet:=Not PhotMet;
  If(Res.NumXPixels=0)or(Res.NumYPixels=0)or(StripOff=0)Then RIReadTIFF:=eriInvalidData
   Else
  Begin
   If Res.BitsPerPixel=24Then
    Res.BytesPerLine:=LenNBits2BytesPerLine(Res.NumXPixels,Res.BitsPerPixel);
   ImageSize:=Mul2Word(Res.BytesPerLine,Res.NumYPixels);
   P:=MemAlloc(Res.BytesPerLine);
   If(P=NIL)Then Begin
    RIReadTIFF:=eriLineTooBig;Exit;
   End;
   If BestAlloc(Res,Flags,Ressource,SizeOf(Res)+ImageSize+Long(Res.NumPal*3),Load,Q)Then Begin
    If(fpProgressBar)in(Flags)Then WEInitProgressBar(W);
    FP:=SizeOf(Res);
    If StripCnt=1Then Begin
      { S'il n'y a qu'une bande, l'offset pointe dessus }
     XH.FP:=ImageStart+StripOff;
     For I2:=0to Res.NumYPixels-1do Begin
      If(ReadLine(P^)<>eriNone)Then Break;
      If(Load)Then XSetAbsRec(Q,FP,Res.BytesPerLine,P^);
      Inc(FP,Res.BytesPerLine);
      If(fpProgressBar)in(Flags)Then WEUpDate(W,FP,ImageSize);
      If(fpViewScr)in(Flags)Then BestClrLnHorImg(I2,Res,P^);
      If(fpUserInterrupt)in(Flags)Then Begin
       If(KeyPress)and(Systems.ReadKey=kbEsc)Then Begin
        If(UserCancel)Then Begin;RIReadTIFF:=eriUserCancel;Exit;End;
       End;
      End;
     End;
    End
     Else
    Begin
      { S'il y a plus d'une bande, l'offset pointe vers l'offset de la 1iŠre bande }
     I2:=0;
     For l:=0to StripCnt-1do Begin
      XH.FP:=ImageStart+StripOff+(L*SizeOf(Long));XH.FP:=ReadLong(XH);
      If(ReadLine(P^)<>eriNone)Then Break;
      If(Load)Then XSetAbsRec(Q,FP,Res.BytesPerLine,P^);
      Inc(FP,Res.BytesPerLine);
      If(fpProgressBar)in(Flags)Then WEUpDate(W,FP,ImageSize);
      If(fpViewScr)in(Flags)Then Begin
       BestClrLnHorImg(I2,Res,P^);
       Inc(I2);
      End;
      If(fpUserInterrupt)in(Flags)Then Begin
       If(KeyPress)and(Systems.ReadKey=kbEsc)Then Begin
        If(UserCancel)Then Begin;RIReadTIFF:=eriUserCancel;Exit;End;
       End;
      End;
     End;
    End;
     {criture des informations d'entˆte de la ressource d'image}
    Res.Index:=0;Res.ID:=idResImage;Res.Format:=fdiBinary;
    Res.Original:=diTIFF;Res.Descr:='';Res.Shadow:=False;
    XSetAbsRec(Q,0,SizeOf(ImageHeaderRes),Res);
    RIReadTIFF:=eriNone;
   End
    Else
   RIReadTIFF:=eriOutOfMemory;
   FreeMemory(P,Res.BytesPerLine);
   If(fpProgressBar)in(Flags)Then WEDone(W);
  End;
 End
  Else
 RIReadTIFF:=eriInvalidHeader;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Fonction RIReadRESWindows                Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: XInf
 Portabilit‚:  Local


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de lire un fichier d'image contenue dans une
 ressource de format Windows (.RES)  et de placer sous  contenu dans
 une ressource d'image.
}

Function RIReadRESWindows(Handle:Hdl;FilePos:Long;Index:Word;Ressource:Byte;
                          Flags:FlagsProcessusImage;Var Q:XInf):Word;Near;
Type
 TTypeInfo=Record
  rtTypeID:Word; { Offset de la table de ressource ou Entier plus valeur 8000h }
  rtResourceCount:Word;
  rtReserved:Array[0..3]of Byte;
{ rtNameInfo:Array of TNameInfo;}
 End;

 TNameInfo=Record
  rnOffset:Word;
  rnLength:Word;
  rnFlags:Word;
  rnID:Word;
  rnHandle:Word;
  rnUsage:Word;
 End;

Var
 Header:Array[0..2]of Byte;
 K,I:Word;
 FP,FS:LongInt;

  {  OrigPos:Long;
    TypeInfo:TTypeInfo;
    NameInfo:TNameInfo;
    riAlignShift:Word;}

 Function GetLengthDescr:Word;
 Var Name:Array[Byte]of Char;
     Nm:Record
      ID:Byte;
      Data:Word;
     End Absolute Name;
 Begin
  _GetAbsRec(Handle,FilePos+3,SizeOf(Name),Name);
  If Nm.ID=$FFThen Begin
   K:=Nm.Data;
   GetLengthDescr:=2;
  End
   Else
  Begin
   K:=$FFFF;
   GetLengthDescr:=StrLen(@Name)
  End;
 End;

 Procedure AddDescr;
 Var
  Name:Array[Byte]of Char;
  Nm:Record
   ID:Byte;
   Data:Word;
  End Absolute Name;
  K:Word;
  Res:ImageHeaderRes;
 Begin
  XGetAbsRec(Q,0,SizeOf(Res),Res);
  _GetAbsRec(Handle,FilePos+3,SizeOf(Name),Name);
  If Nm.ID=$FFThen Res.Descr:=WordToStr(Nm.Data)
              Else Res.Descr:=StrPas(@Name);
  XSetAbsRec(Q,0,SizeOf(Res),Res);
 End;

(* Function CompareStrings(Const Key:String;Offset:Word):Boolean;
 Var
  Str:String;
 Begin
  CompareStrings:=No;
  _GetAbsRec(Handle,OrigPos+Offset,SizeOf(Str),Str);
  Str[Length(Str)]:=#0;
  CompareStrings:=StrUp(Key)=StrUp(Str);
 End;

 Function Compare(Key:Long;Const KeyMsg:String;ID:Word):Boolean;Begin
  If {LongRec(Key).Hi=0}KeyMsg=''Then Begin
   If ID<$8000Then Compare:=No
              Else Compare:=LongRec(Key).Lo=ID and $7FFF
  End
   Else
  If ID<$8000Then Compare:=CompareStrings(KeyMsg,ID)
             Else Compare:=No
 End;*)

Begin
{ FS:=FileSize(Handle);
 OrigPos:=FilePos;
 _GetAbsRec(Handle,FilePos,SizeOf(riAlignShift),riAlignShift);
 Inc(FilePos,2);
 Repeat
  _GetAbsRec(Handle,FilePos,SizeOf(TTypeInfo),TypeInfo);
  Inc(FilePos,Long(SizeOf(TTypeInfo)));
  _GetAbsRec(Handle,FilePos,SizeOf(TNameInfo),NameInfo);
  If TypeInfo.rtTypeID=0Then Break;
  If Compare(2,'',TypeInfo.rtTypeID)Then Begin
(*    SkipToResType:=TypeInfo.rtResourceCount;*)
   K:=RIReadBitMapWindows(Handle,FP,Ressource,Flags or fpNoHeader,Q);
   (*If K<>0Then AddDescr;*)
   Break;
  End
   else
  Inc(FilePos,Long(TypeInfo.rtResourceCount*SizeOf(TNameInfo)));
  If(FilePos>FS)Then Break;
 Until No;}

 FS:=FileSize(Handle);
 Repeat
  _GetAbsRec(Handle,FilePos,SizeOf(Header),Header);
  If(Header[0]=$FF)and(Header[1]in[2,3])Then Begin
   FP:=FilePos+GetLengthDescr+10;
   K:=RIReadBitMapWindows(Handle,FP,Ressource,Flags+[fpNoHeader],Q);
   If K<>0Then AddDescr;
   RIReadRESWindows:=K
  End
   Else
  Begin;RIReadRESWindows:=eriInvalidHeader;Break;End;
  FilePos:=FP;
  If(FilePos>FS)Then Begin
   RIReadRESWindows:=eriIndexNotFound;Break;
  End;
  If(Index=K)or(Index=$FFFF)Then Break
   Else
  XFreeMem(Q); { C'‚tait pas l'index voulu...}
 Until False;
End;

Function RIReadExeWindows(Handle:Hdl;Var FilePos:Long;Index:Word;Ressource:Byte;
                          Flags:FlagsProcessusImage;Var Q:XInf):Word;Near;

 Function SkipStub:Boolean;
 Var
  Header:HeaderExe4Res;
 Begin
  SkipStub:=False;
  _GetAbsRec(Handle,FilePos,SizeOf(Header),Header);
  If(Header.Signature<>$5A4D)or(Header.eRelocOfs<$40)Then Exit;
  Inc(FilePos,Long(Header.eNewHeader));
  SkipStub:=True;
 End;

 Function Skip2RessourceTable:Boolean;
 Var
  Header:HeaderExeWindows;
 Begin
  Skip2RessourceTable:=False;
  _GetAbsRec(Handle,FilePos,SizeOf(Header),Header);
  If Header.Signature<>$454EThen Exit;
  Inc(FilePos,Long(Header.ResourceTbl));
  Skip2RessourceTable:=True
 End;

Begin
 If(SkipStub)Then Begin
  If(Skip2RessourceTable)Then Begin
   RIReadRESWindows(Handle,FilePos,Index,Ressource,Flags,Q);
  End
   Else
  RIReadExeWindows:=eriInvalidHeader;
 End
  Else
 RIReadExeWindows:=eriInvalidHeader;
End;

Function RIReadGFX(Handle:Hdl;FilePos:LongInt;Ressource:Byte;Flags:FlagsProcessusImage;Var Q:XInf):Word;Near;
Var
 J,FP,FS:LongInt;
 Res:ImageHeaderRes;
 PBuf:^TByte;
 Buffer:Array[0..1279]of Byte;
 I:Word;
Begin
 FS:=FileSize(Handle)-FilePos;
 If XAllocMem(Ressource,FS,Q)Then Begin
  FillClr(Res,SizeOf(Res));
  If(FS=64000)or(FS=64768)Then Begin
   PBuf:=MemAlloc(FS);
   If(PBuf<>NIL)Then Begin
    If FS=64768Then Res.NumPal:=256;
    _GetAbsRec(Handle,FilePos,FS,PBuf^);
    XSetAbsRec(Q,SizeOf(Res),FS,PBuf^);
    FreeMemory(PBuf,FS);
   End
    Else
   Begin
    RIReadGFX:=eriOutOfMemory;
    Exit;
   End;
   Res.NumXPixels:=320;Res.NumYPixels:=200;
   Res.BytesPerLine:=320;Res.BitsPerPixel:=8;
  End
   Else
  If FS=128000Then Begin
   FP:=FilePos;J:=SizeOf(Res);
   For I:=0to 99do Begin
    _GetAbsRec(Handle,FP,1280,Buffer);
    XSetAbsRec(Q,J,1280,Buffer);
    Inc(FP,Long(1280));
   End;
   Res.NumXPixels:=320;Res.NumYPixels:=400;
   Res.BytesPerLine:=320;Res.BitsPerPixel:=8;
  End
   Else
  If FS=307200Then Begin
   FP:=FilePos;J:=SizeOf(Res);
   For I:=0to 239do Begin
    _GetAbsRec(Handle,FP,640*2,Buffer);
    XSetAbsRec(Q,J,640*2,Buffer);
    Inc(FP,Long(640*2));Inc(J,Long(640*2));
   End;
   Res.NumXPixels:=640;Res.NumYPixels:=480;
   Res.BytesPerLine:=640;Res.BitsPerPixel:=8;
  End
   Else
  Begin
   RIReadGFX:=eriInvalidSize;
   Exit;
  End;
  Res.Index:=0;
  Res.ID:=idResImage;
  Res.Format:=fdiBinary;
  Res.Original:=diGFX;
  Res.Descr:='';
  Res.Shadow:=False;
  XSetAbsRec(Q,0,SizeOf(Res),Res);
  RIReadGFX:=eriNone;
 End
  Else
 RIReadGFX:=eriOutOfMemory;
End;

{ Cette proc‚dure permet de lire l'ic“ne repr‚sentative du dessin Corel
 Draw.
}

Function RIReadCorelDraw(Handle:Hdl;FilePos:Long;Ressource:Byte;
                         Flags:FlagsProcessusImage;Var Q:XInf):Word;Near;Begin
 Inc(FilePos,$22);
 RIReadCorelDraw:=RIReadBitMapWindows(Handle,FilePos,Ressource,Flags+[fpNoHeader],Q);
End;

{ Cette proc‚dure permet de lire une image GEM/IMG.
}

Function RIReadGemImg(Handle:Hdl;FilePos:Long;Ressource:Byte;
                      Flags:FlagsProcessusImage;Var Q:XInf):Word;Near;
Var
 Header:HeaderGemImgRec;
 Res:ImageHeaderRes;
 RP,FS:LongInt;
 Load:Boolean;
 JL,Y:Word;
 LineBuf:Array[0..1279]of Byte;
 Buffer:Array[0..4095]of Byte;
 W:Window;
 XH:HandleExtended;
 Pr,J,K,N,C,I:Integer;
 RepCount:Word;
 P:Array[0..1279]of Byte;
Begin
 _GetAbsRec(Handle,FilePos,SizeOf(Header),Header);
 ASM
   { Conversion du format Motorola … INTEL }
  MOV AX,Header.StartOff
  XCHG AL,AH
  SHL AX,1
  MOV Header.StartOff,AX
   { Conversion du format Motorola … INTEL }
  MOV AX,Header.BitsPerPixel
  XCHG AL,AH
  MOV Header.BitsPerPixel,AX
   { Conversion du format Motorola … INTEL }
  MOV AX,Header.PatternSize
  XCHG AL,AH
  MOV Header.PatternSize,AX
   { Conversion du format Motorola … INTEL }
  MOV AX,Header.NumXPixels
  XCHG AL,AH
  MOV Header.NumXPixels,AX
   { Conversion du format Motorola … INTEL }
  MOV AX,Header.NumYPixels
  XCHG AL,AH
  MOV Header.NumYPixels,AX
 END;
 If Header.Sign=#$00#$01Then Begin
  FillClr(Res,SizeOf(Res));FillClr(W,SizeOf(W));
  Res.NumXPixels:=Header.NumXPixels;
  Res.NumYPixels:=Header.NumYPixels;
  Res.BitsPerPixel:=Header.BitsPerPixel;
  If Res.BitsPerPixel=1Then Res.BytesPerLine:=(Res.NumXPixels+7)shr 3
   Else
  Res.BytesPerLine:=LenNBits2BytesPerLine(Res.NumXPixels,Res.BitsPerPixel);
  FillClr(XH,SizeOf(XH));
  XH.Handle:=Handle;XH.Buffer:=@Buffer;XH.Size:=SizeOf(Buffer);
  XH.FP:=FilePos+Header.StartOff;
  XH.Position:=SizeOf(Buffer);RP:=SizeOf(Res);XH.Format:=Motorola;
  FS:=Mul2Word(Res.BytesPerLine,Res.NumYPixels);
  If Res.BytesPerLine>SizeOf(P)Then Begin
   RIReadGemImg:=eriLineTooBig;Exit;
  End;
  If BestAlloc(Res,Flags,Ressource,SizeOf(Res)+FS+Long(Res.NumPal*3),Load,Q)Then Begin
   If(fpProgressBar)in(Flags)Then WEInitProgressBar(W);
   FillClr(P,Res.BytesPerLine);
   N:=0;Y:=0;
   For JL:=0to Res.NumYPixels-1do Begin
    RepCount:=1;N:=0;
    Repeat
     C:=ReadByte(XH);
     If C=0Then Begin
      C:=ReadByte(XH);
      If C=0Then RepCount:=ReadWord(XH)
       Else
      Begin
       Pr:=N;
       For J:=0to Header.PatternSize-1do Begin
        P[N]:=ReadByte(XH);
        Inc(N);
       End;
       For K:=0to C-2do Begin
        MoveLeft(P[Pr],P[N],Header.PatternSize);
        Inc(N,Header.PatternSize);
       End;
      End;
     End
      Else
     If C=$80Then Begin { C'est une chaŒne de r‚p‚tition d'octets }
      For J:=0to ReadByte(XH)-1do Begin
       P[N]:=ReadByte(XH);
       Inc(N);
      End;
     End
      Else
     Begin
      I:=C and$7F;
      If C and$80=$80Then FillChr(P[N],I,$FF)
                     Else FillClr(P[N],I);
      Inc(N,I);
     End;
     If(fpUserInterrupt)in(Flags)Then Begin
      If(KeyPress)and(Systems.ReadKey=kbEsc)Then Begin
       If(UserCancel)Then Begin
        RIReadGemImg:=eriUserCancel;
        Exit;
       End;
      End;
     End;
    Until(N=0)or(N>=Res.BytesPerLine);
    If N=0Then FillClr(P,SizeOf(P));
    K:=0;
    While RepCount>0do Begin
     MoveLeft(P[K],LineBuf,Res.BytesPerLine);
     Inc(K,Res.BytesPerLine);
     XSetAbsRec(Q,RP,Res.BytesPerLine,LineBuf);
     Inc(RP,Long(Res.BytesPerLine));
     If(fpProgressBar)in(Flags)Then WEUpDate(W,RP,FS);
     If(fpViewScr)in(Flags)Then Begin
      BestClrLnHorImg(Y,Res,LineBuf);
      Inc(Y)
     End;
     Dec(RepCount);
    End;
   End;
   Res.Index:=0;Res.ID:=idResImage;Res.Format:=fdiBinary;
   Res.Original:=diGemImg;Res.Descr:='';Res.Shadow:=False;
   XSetAbsRec(Q,0,SizeOf(Res),Res);
   If(fpProgressBar)in(Flags)Then WEDone(W);
   RIReadGemImg:=eriNone;
  End;
 End
  Else
 RIReadGemImg:=eriInvalidHeader;
End;

Procedure ConvHex2Byte(Const Source;Var Dest;Num:Word);Assembler;ASM
 {$IFDEF FLAT386}
 {$ELSE}
  CLD
  PUSH DS
   SUB SP,100h
   MOV BX,SP
   MOV SS:[BX+Byte('0')],0
   MOV SS:[BX+Byte('1')],1
   MOV SS:[BX+Byte('2')],2
   MOV SS:[BX+Byte('3')],3
   MOV SS:[BX+Byte('4')],4
   MOV SS:[BX+Byte('5')],5
   MOV SS:[BX+Byte('6')],6
   MOV SS:[BX+Byte('7')],7
   MOV SS:[BX+Byte('8')],8
   MOV SS:[BX+Byte('9')],9
   MOV SS:[BX+Byte('A')],10
   MOV SS:[BX+Byte('B')],11
   MOV SS:[BX+Byte('C')],12
   MOV SS:[BX+Byte('D')],13
   MOV SS:[BX+Byte('E')],14
   MOV SS:[BX+Byte('F')],15
   MOV SS:[BX+Byte('a')],10
   MOV SS:[BX+Byte('b')],11
   MOV SS:[BX+Byte('c')],12
   MOV SS:[BX+Byte('d')],13
   MOV SS:[BX+Byte('e')],14
   MOV SS:[BX+Byte('f')],15
   LDS SI,Source
   LES DI,Dest
   MOV CX,Num
 @Loop:
   XOR DX,DX
   LODSW { "0x" }
 @Restart:
   CMP AL,' '
   JNE @Skip
   LODSB
   DEC DX
   JNZ @Restart
 @Skip:
   LODSW
   MOV BX,SP
   ADD BL,AL
   ADC BH,0
   MOV AL,SS:[BX]
   MOV BX,SP
   ADD BL,AH
   ADC BH,0
   MOV AH,SS:[BX]
   {$IFOPT G+}
    SHR AH,4
   {$ELSE}
    SHL AH,1
    SHL AH,1
    SHL AH,1
    SHL AH,1
   {$ENDIF}
   OR  AL,AH
   STOSB
   LODSB { "," }
   LOOP @Loop
   ADD SP,100h
  POP DS
 {$ENDIF}
END;

{ Cette fonction permet de lire une image XBM de format Unix.
}

Function RIReadXBM(Handle:Hdl;FilePos:Long;Ressource:Byte;
                   Flags:FlagsProcessusImage;Var Q:XInf):Word;Near;
Var
 Res:ImageHeaderRes;
 I,J,L,XS:Byte;
 S:String;
 FP,FS,TS:LongInt;
 Buffer:Array[0..127]of Byte;
 W:Window;
 Load:Boolean;
Begin
 RIReadXBM:=eriInvalidHeader;
 FillClr(Res,SizeOf(Res));
 Res.BitsPerPixel:=24;Res.ID:=idResImage;
 Res.Format:=fdiBinary;Res.Original:=diXBM;
 __GetAbsFileTxtLn(Handle,FilePos,S);
 If(S='')or(Pos('#define',S)=0)or(Pos('width',S)=0)Then Exit;
 For I:=1to Length(S)do If S[I]in['0'..'9']Then Begin
  Res.NumXPixels:=StrToWord(Copy(S,I,255));
  Break;
 End;
 __GetAbsFileTxtLn(Handle,FilePos,S);
 If(S='')or(Pos('#define',S)=0)or(Pos('height',S)=0)Then Exit;
 For I:=1to Length(S)do If S[I]in['0'..'9']Then Begin
  Res.NumYPixels:=StrToWord(Copy(S,I,255));
  Break;
 End;
 __GetAbsFileTxtLn(Handle,FilePos,S);
 Res.BytesPerLine:=LenNBits2BytesPerLine(Res.NumXPixels,Res.BitsPerPixel);
 FS:=FileSize(Handle);FP:=SizeOf(ImageHeaderRes);
 If BestAlloc(Res,Flags,Ressource,SizeOf(Res)+Res.BytesPerLine*Res.NumYPixels,Load,Q)Then Begin
  If(fpProgressBar)in(Flags)Then WEInitProgressBar(W);
  FillClr(Buffer,SizeOf(Buffer));
  Repeat
   __GetAbsFileTxtLn(Handle,FilePos,S);
   For I:=1to Length(S)do If S[I]='0'Then Break;
   XS:=0;
   For J:=I to Length(S)do If S[J]=' 'Then Inc(XS);
   L:=(Length(S)-XS-I+1)div 5;
   If L>SizeOf(Buffer)Then Break;
   ConvHex2Byte(S[I],Buffer,L);
   If(Load)Then
    XSetAbsRec(Q,FP,L,Buffer);
   Inc(FP,Long(L));
   If(fpProgressBar)in(Flags)Then WEUpDate(W,FP,FS);
  Until FilePos>=FS;
  TS:=Res.NumXPixels*Res.NumYPixels;
  If(FP*3>=TS)Then Res.BitsPerPixel:=24 Else
  If(FP shl 1>=TS)Then Res.BitsPerPixel:=16 Else
  If(FP>=TS)Then Res.BitsPerPixel:=8 Else
  If(FP shr 4>=TS)Then Res.BitsPerPixel:=4 Else
  If(FP shr 6>=TS)Then Res.BitsPerPixel:=2
                  Else Res.BitsPerPixel:=1;
  Res.BytesPerLine:=LenNBits2BytesPerLine(Res.NumXPixels,Res.BitsPerPixel);
  XSetAbsRec(Q,0,SizeOf(Res),Res);
  If(fpProgressBar)in(Flags)Then WEDone(W);
  RIReadXBM:=eriNone;
 End
  Else
 RIReadXBM:=eriOutOfMemory;
End;

{ Cette fonction permet de lire une image MacPaint.
}

Function RIReadMacPaint(Handle:Hdl;FilePos:LongInt;Ressource:Byte;
                        Flags:FlagsProcessusImage;Var Q:XInf):Word;Near;
Var
 StartSec:Array[0..511]of Byte;
 OldHeader:HeaderOldMacPaint Absolute StartSec;
 Res:ImageHeaderRes;
 J,Y:Word;
 Load,Ok:Bool;
 LineBuffer:Array[0..1279]of Byte;
 FP:Long;
 XH:HandleExtended;
 Buffer:Array[0..4095]of Byte;
 C:Byte;
 I,N:Integer;
 W:Window;
Begin
 _GetAbsRec(Handle,FilePos,SizeOf(HeaderOldMacPaint),OldHeader);
 If OldHeader.TypeFile='PNTG'Then Begin { MacPaint? }
  Res.Descr:=OldHeader.Name;Y:=0;Res.Shadow:=False;
  Res.NumXPixels:=576;Res.NumYPixels:=720;
  Res.BytesPerLine:=72;Res.BitsPerPixel:=1;
  Res.Index:=0;Res.ID:=idResImage;
  Res.Format:=fdiBinary;Res.Original:=diMacPaint;
  If BestAlloc(Res,Flags,Ressource,SizeOf(Res)+51840,Load,Q)Then Begin
   If(fpProgressBar)in(Flags)Then WEInitProgressBar(W);
   FP:=SizeOf(Res);
   FillClr(XH,SizeOf(XH));
   XH.Handle:=Handle;XH.Buffer:=@Buffer;XH.Size:=SizeOf(Buffer);
   XH.FP:=FilePos+640;XH.Position:=SizeOf(Buffer);XH.Format:=Motorola;
   For J:=0to 719do Begin
    N:=0;
    Repeat
     C:=ReadByte(XH);
     If(C)and$80=$80Then Begin
      I:=Byte(Not C)+2;
      C:=ReadByte(XH);
      While I>0do Begin;LineBuffer[N]:=C;Dec(I);Inc(N)End;
     End
      Else
     Begin
      I:=Succ(C);
      While I>0do Begin
       LineBuffer[N]:=ReadByte(XH);
       Inc(N);Dec(I);
      End;
     End;
    Until N>=72;
    If(Load)Then
     XSetAbsRec(Q,FP,72,LineBuffer);
    Inc(FP,Long(72));
    If(fpProgressBar)in(Flags)Then WEUpDate(W,FP,51840);
    If(fpViewScr)in(Flags)Then Begin
     BestClrLnHorImg(Y,Res,LineBuffer);
     Inc(Y)
    End;
   End;
   XSetAbsRec(Q,0,SizeOf(Res),Res);
   If(fpProgressBar)in(Flags)Then WEDone(W);
   RIReadMacPaint:=eriNone;
  End
   Else
  RIReadMacPaint:=eriOutOfMemory;
 End
  Else
 Begin
{  Ok:=No;
  For I:=0to 511do Ok:=Ok or(StartSec[I]=0);
  If(Ok)Then Begin
  End
   Else}
  RIReadMacPaint:=eriInvalidHeader;
 End;
End;

Function RIMBF(Handle:Hdl;FilePos:Long;Ressource:Byte;
               Flags:FlagsProcessusImage;Var Q:XInf):Word;Near;
Const
 ImageSize=54612;
Var
 Res:ImageHeaderRes;
 Buf:^TByte;
 Load:Boolean;
 B,Y:Word;
Begin
 FillClr(Res,SizeOf(Res));
 Res.NumXPixels:=246;Res.NumYPixels:=222;
 Res.BytesPerLine:=246;Res.BitsPerPixel:=8;
 Res.ID:=idResImage;Res.Format:=fdiBinary;Res.Original:=diMBF;
 Buf:=MemAlloc(ImageSize);
 If(Buf<>NIL)Then Begin
  If BestAlloc(Res,Flags,Ressource,SizeOf(Res)+ImageSize,Load,Q)Then Begin
   _GetAbsRec(Handle,FilePos,ImageSize,Buf^);
   XSetAbsRec(Q,0,SizeOf(Res),Res);
   If(Load)Then XSetAbsRec(Q,SizeOf(Res),ImageSize,Buf^);
   If(fpViewScr)in(Flags)Then Begin
    B:=0;
    For Y:=0to 221do Begin
     BestClrLnHorImg(Y,Res,Buf^[B]);
     Inc(B,246);
    End;
   End;
   RIMBF:=eriNone;
  End
   Else
  RIMBF:=eriOutOfMemory;
  FreeMemory(Buf,ImageSize);
 End
  Else
 RIMBF:=eriOutOfMemory;
End;

{ Cette fonction permet de lire un ic“ne de format AdŠle.
}

Function RIReadIconAdele(Var R:ImageObjectLoader;Var Q:XInf):Word;Near;
Var
 Data:Record
  Sign:Array[0..10]of Char;
  Res:ImageHeaderRes;
  Buffer:Array[0..4095]of Byte;
 End;
 TotalSize:Word;
 I:Word;
 Load:Boolean;
Begin
 RIReadIconAdele:=eriNone;
 If R.Index=$FFFFThen R.Index:=0;
 For I:=0to(R.Index)do Begin
  _GetAbsRec(R.Handle,R.FilePos,SizeOf(Data),Data);
  TotalSize:=Data.Res.BytesPerLine*Data.Res.NumYPixels+SizeOf(Data.Res);
  If Data.Res.NumPal>0Then Inc(TotalSize,Data.Res.NumPal*3);
  If(Data.Res.Shadow)Then Inc(TotalSize,(Data.Res.NumXPixels shr 3)*Data.Res.NumYPixels);
  If I=0Then Inc(R.FilePos,LongInt(TotalSize+11)); { + Signature 11 octets }
  If(I<R.Index)Then Inc(R.FilePos,TotalSize);
 End;
 If BestAlloc(Data.Res,R.Option,R.Ressource,TotalSize,Load,Q)Then Begin
  XSetAbsRec(Q,0,TotalSize,Data.Res);
 End
  Else
 RIReadIconAdele:=eriOutOfMemory;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Fonction RIRLL                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: XInf
 Portabilit‚:  Global


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de rechercher … l'int‚rieur d'une bibliothŠque
 d'image une image  d'un  format quelconque et  de le charger dans une
 ressource m‚moire.
}

Function RIRLL(Var R:ImageObjectLoader;Var Q:XInf;Old:Boolean):Word;Near;
Var
 Pos:LongInt;
Begin
 _GetAbsRec(R.Handle,R.FilePos+(Succ(R.Index)shl 2),SizeOf(Pos),Pos);
 If(Old)Then Begin
  RIRLL:=RIReadImage(R.Handle,diAutoDetect,Pos,R.BitsPerPixel,$FFFF,R.Ressource,R.Option,Q);
 End
  Else
 Begin
  R.Index:=0;
  R.FilePos:=Pos;
  R.DefaultImage:=diAutoDetect;
  RIRLL:=RILoaderImage(R,Q);
 End;
End;

{ Cette fonction permet de lire une image d'impression GPX.
}

Function RIGPX(Handle:Hdl;FilePos:Long;Ressource:Byte;
               Flags:FlagsProcessusImage;Var Q:XInf):Word;
Var
 Header:GPXHeader;
 Res:ImageHeaderRes;
 J:Word;
 LineBuffer:Array[0..4095]of Byte;
 Load:Boolean;
 ImageSize,FP,RP:LongInt;
 W:Window;
Begin
 _GetAbsRec(Handle,FilePos,SizeOf(Header),Header);
 If Header.Sign='GPX'#26Then Begin
  FillClr(Res,SizeOf(Res));
  Res.BitsPerPixel:=Header.BitsPerPixel;Res.NumXPixels:=Header.Len;
  Res.NumYPixels:=Header.Ln shl 3;
  Res.BytesPerLine:=LenNBits2BytesPerLine(Res.NumXPixels,Res.BitsPerPixel);
  Res.ID:=idResImage;Res.Format:=fdiBinary;Res.Original:=diGPX;
  ImageSize:=Mul2Word(Res.BytesPerLine,Res.NumYPixels);
  If BestAlloc(Res,Flags,Ressource,SizeOf(Res)+ImageSize,Load,Q)Then Begin
   If(fpProgressBar)in(Flags)Then WEInitProgressBar(W);
   RP:=SizeOf(Res);
   FP:=SizeOf(Header)+Mul2Word(Header.Len,Header.Ln);
   For J:=0to Res.NumYPixels-1do Begin
    _GetAbsRec(Handle,FP,Res.BytesPerLine,LineBuffer);
    XSetAbsRec(Q,RP,Res.BytesPerLine,LineBuffer);
    If(fpViewScr)in(Flags)Then BestClrLnHorImg(J,Res,LineBuffer);
    Inc(RP,Long(Res.BytesPerLine));Inc(FP,Long(Res.BytesPerLine));
    If(fpProgressBar)in(Flags)Then WEUpDate(W,RP,ImageSize);
   End;
   XSetAbsRec(Q,0,SizeOf(Res),Res);
   If(fpProgressBar)in(Flags)Then WEDone(W);
   RIGPX:=eriNone;
  End
   Else
  RIGPX:=eriOutOfMemory;
 End
  Else
 RIGPX:=eriInvalidHeader;
End;

{ Cette fonction permet de lire une image LBM ou PBM.
}

Function RILBM(Handle:Hdl;FilePos:Long;Ressource:Byte;
               Flags:FlagsProcessusImage;Var Q:XInf):Word;Near;
Var
 Header:LBMHeader;
 Msg:Array[1..4]of Char;
 Local:Record
  Cnt:Byte;
  Rle:Boolean;
  Dat:Byte;
  Vir:LongInt;
  Res:ImageHeaderRes;
  W:Window;
  XH:HandleExtended;
 End;
 Buffer:Array[0..4095]of Byte;
 RP,FS,BL,L,H:LongInt;
 B,I:Word;
 C:Byte;
 J,Y,K:Integer;
 LineBuffer:Array[0..2047]of Byte;
 Pal:Palette256RGB;
 Load:Boolean;
Begin
 _GetAbsRec(Handle,FilePos,SizeOf(Header),Header);
 If Header.Msg1='FORM'Then Begin
  FillClr(Local,SizeOf(Local));
  If(Header.Msg2='ILBMBMHD')or(Header.Msg2='PBM BMHD')Then Begin
   Header.Width:=Swap(Header.Width);
   Header.Length:=Swap(Header.Length);
   Header.XOff:=Swap(Header.XOff);
   Header.YOff:=Swap(Header.YOff);
   Header.ScreenWidth:=Swap(Header.ScreenWidth);
   Header.ScreenHeight:=Swap(Header.ScreenHeight);
   Local.Res.NumXPixels:=Header.Width;
   Local.Res.NumYPixels:=Header.Length;
   Local.Res.BitsPerPixel:=Header.BitsPerPixel;
   Local.Res.BytesPerLine:=LenNBits2BytesPerLine(Local.Res.NumXPixels,Local.Res.BitsPerPixel);
   FS:=Mul2Word(Local.Res.BytesPerLine,Local.Res.NumYPixels);
   _GetRec(Handle,SizeOf(Msg),Msg);
   Local.XH.Handle:=Handle;
   Local.XH.Buffer:=@Buffer;
   Local.XH.Size:=SizeOf(Buffer);
   Local.XH.FP:=FilePos+SizeOf(Header)+SizeOf(Msg);
   Local.XH.Position:=SizeOf(Buffer);
   Local.XH.Format:=Motorola;
   L:=ReadLong(Local.XH);
   If Odd(L)Then Inc(L);
   If Msg='CMAP'Then Begin
    ReadBuf2(Local.XH,L,Pal); { Chargement de la palette de couleur RVB }
    If L>0Then Local.Res.NumPal:=L div 3;
    ReadBuf2(Local.XH,SizeOf(Msg),Msg);
   End;
   If BestAlloc(Local.Res,Flags,Ressource,SizeOf(Local.Res)+FS+Long(Local.Res.NumPal*3),Load,Q)Then Begin
    RP:=SizeOf(Local.Res);
    If Local.Res.NumPal>0Then Begin
     XSetAbsRec(Q,SizeOf(Local.Res)+FS,L,Pal);
     If(fpViewScr)in(Flags)Then SetPalRGB(Pal,0,Local.Res.NumPal);
    End;
    If(fpProgressBar)in(Flags)Then WEInitProgressBar(Local.W);
    While Msg<>'BODY'do Begin
     L:=ReadLong(Local.XH);
     If Odd(L)Then Inc(L);
     For I:=1to(L)do ReadByte(Local.XH);
     ReadBuf2(Local.XH,SizeOf(Msg),Msg);
     If Msg=#0#0#0#0Then Begin
      RILBM:=eriBadCode;
      XFreeMem(Q);
      Exit;
     End;
    End;
    If Msg='BODY'Then Begin
     L:=ReadLong(Local.XH);
     H:=GetFilePos(Local.XH);
     IF Header.Compression=0Then BL:=L div Header.Length div Header.BitsPerPixel
                            Else BL:=Header.Width shr 3;
     For Y:=0to Header.Length-1do Begin
      FillClr(LineBuffer,SizeOf(LineBuffer));
      B:=0;
      For J:=0to Header.BitsPerPixel-1do For I:=0to BL-1do Begin
       If Header.Compression=0Then C:=ReadByte(Local.XH)
        Else
       Begin
        If Local.Cnt=0Then Begin
         C:=ReadByte(Local.XH);
         Local.Rle:=C>127;
         If(Local.Rle)Then Local.Cnt:=ShortInt(1-C)
                      Else Local.Cnt:=1+C;
         Local.Dat:=ReadByte(Local.XH);
        End
         Else
        If Not(Local.Rle)Then Local.Dat:=ReadByte(Local.XH);
        C:=Local.Dat;
       End;
       Dec(Local.Cnt);Inc(Local.Vir);
       If Local.Res.BitsPerPixel=8Then Begin
        LineBuffer[B]:=C;
        Inc(B);
       End
        Else
       For K:=0to 7do If(C)and(128 shr K)>0Then
        LineBuffer[(I shl 3)+K]:=LineBuffer[(I shl 3)+K]or 1 shl J;
      End;
      Case(Local.Res.BitsPerPixel)of
       4:Conv8To4BitsKr(LineBuffer,LineBuffer,Local.Res.NumXPixels shr 1);
      End;
      XSetAbsRec(Q,RP,Local.Res.BytesPerLine,LineBuffer);
      Inc(RP,Long(Local.Res.BytesPerLine));
      If(fpViewScr)in(Flags)Then BestClrLnHorImg(Y,Local.Res,LineBuffer);
      If(fpProgressBar)in(Flags)Then WEUpDate(Local.W,RP,FS);
     End;
    End;
    Local.Res.ID:=idResImage;
    Local.Res.Format:=fdiBinary;
    Local.Res.Original:=diLBM;
    XSetAbsRec(Q,0,SizeOf(Local.Res),Local.Res);
    If(fpProgressBar)in(Flags)Then WEDone(Local.W);
    RILBM:=eriNone;
   End
    Else
   RILBM:=eriOutOfMemory;
  End
   Else
  RILBM:=eriUnknownFormat;
 End
  Else
 RILBM:=eriInvalidHeader;
End;

{ Cette fonction permet de lire une image de format JPEG.
}

Function RIJPEG(Handle:Hdl;FilePos:Long;Ressource:Byte;
                Flags:FlagsProcessusImage;Var Q:XInf):Word;Near;
Const
 mSOF0=$FFC0;
 mSOF1=$FFC1;
 mSOF2=$FFC2;
 mSOF3=$FFC3;
 mDHT=$FFC4;
 mSOF5=$FFC5;
 mSOF6=$FFC6;
 mSOF7=$FFC7;
 mSOF8=$FFC8;
 mSOF9=$FFC9;
 mSOF10=$FFCA;
 mSOF11=$FFCB;
 mDAC=$FFCC;
 mSOF13=$FFCD;
 mSOF14=$FFCE;
 mSOF15=$FFCF;
 mRST0=$FFD0;
 mRST1=$FFD1;
 mRST2=$FFD2;
 mRST3=$FFD3;
 mRST4=$FFD4;
 mRST5=$FFD5;
 mRST6=$FFD6;
 mRST7=$FFD7;
 mSOI=$FFD8;
 mEOI=$FFD9;
 mSOS=$FFDA;
 mDQT=$FFDB;
 mDNL=$FFDC;
 mDRI=$FFDD;
 mDHP=$FFDE;
 mEXP=$FFDF;
 mAPP0=$FFE0;
 mAPP1=$FFE1;
 mAPP2=$FFE2;
 mAPP3=$FFE3;
 mAPP4=$FFE4;
 mAPP5=$FFE5;
 mAPP6=$FFE6;
 mAPP7=$FFE7;
 mAPP8=$FFE8;
 mAPP9=$FFE9;
 mAPP10=$FFEA;
 mAPP11=$FFEB;
 mAPP12=$FFEC;
 mAPP13=$FFED;
 mAPP14=$FFEE;
 mAPP15=$FFEF;
 mJPG0=$FFF0;
 mJPG1=$FFF1;
 mJPG2=$FFF2;
 mJPG3=$FFF3;
 mJPG4=$FFF4;
 mJPG5=$FFF5;
 mJPG6=$FFF6;
 mJPG7=$FFF7;
 mJPG8=$FFF8;
 mJPG9=$FFF9;
 mJPG10=$FFFA;
 mJPG11=$FFFB;
 mJPG12=$FFFC;
 mJPG13=$FFFD;
 mCOM=$FFFE;
 FixPt=16;
 MaxComp=3;
 Cuv=0.707106781;
 CX:Array[0..7]of Real=(Cuv,1.0,1.0,1.0,1.0,1.0,1.0,1.0);
 ZigZag:Array[0..7,0..7]of Byte=(
  ( 0, 1, 5, 6,14,15,27,28),
  ( 2, 4, 7,13,16,26,29,42),
  ( 3, 8,12,17,25,30,41,43),
  ( 9,11,18,24,31,40,44,53),
  (10,19,23,32,39,45,52,54),
  (20,22,33,38,46,51,55,60),
  (21,34,37,47,50,56,59,61),
  (35,36,48,49,57,58,62,63)
 );
 ZigiZagi:Array[0..63]of Byte=(
  0, 8, 1, 2, 9, 16,24,17,10,3, 4, 11,18,25,32,40,
  33,26,19,12,5, 6, 13,20,27,34,41,48,56,49,42,35,
  28,21,14,7, 15,22,29,36,43,50,57,58,51,44,37,30,
  23,31,38,45,52,59,60,53,46,39,47,54,61,62,55,63
 );
 BytPerPix=3;

Type
 DWord=LongInt;
 PHuff=^THuff;
 THuff=Record
  MinCode,MaxCode:Array[1..16]of DWord;
  ValPtr,Bits:Array[1..16]of LongInt;
  HuffSize:Array[0..256]of LongInt;
  HuffVal:array[0..256]of LongInt;
  HuffCode:array[0..256]of DWord;
  Lastk:LongInt;
 End;
 PHuffTable=^THuffTable;
 THuffTable=Array[0..1,0..3] of THuff;
 TBlockLongInt=Array[0..7,0..7] of LongInt;
 DQTp=^DQTt;
 DQTt=Record
  PqTq:Byte;
  Qk:Array[0..8*8-1]of SmallInt;
 End;
 TVectLongInt=Array[0..63]of LongInt;
 PCoeffBuf=^TCoeffBuf;
 TCoeffBuf=array[0..0,0..63]of SmallInt;
Var
 HuffTable:PHuffTable;
 CosTab:TBlockLongInt;
 EndOfImage,EndOfScan:Boolean;
 RestartInterval:LongInt;
 Qk:Array[0..3]of TVectLongInt;
 IdctFix:Array[0..1,0..1,1..3]of TBlockLongInt;
 SOFtype:Word;
 SOF:Record
  P:Byte;
  Y:Word;
  X:Word;
  Nf:Byte;
  Ci:Array[0..255]of Byte;
  HiVi:Array[0..255]of Byte;
  Tqi:Array[0..255]of Byte;
 End;
 SOS:Record
  Ns:Byte;
  Csj:Array[1..4]of Byte;
  TdjTaj:Array[1..10]of Byte;
  Ss:Byte;
  Se:Byte;
  AhAl:Byte;
 End;
 DHT:Record
  TcTh:Byte;
  Li:Array[1..16]of Byte;
  Vij:Array[0..256]of Byte;
 End;
 DQT:DQTt;
 CoeffBuf:array[1..MaxComp]of PCoeffbuf;
 CoeffBufW,CoeffBufH,CoeffBufIdx,CoeffEobRun,CoeffX,CoeffY,CoeffBufXd,CoeffBufYd:Array[1..MaxComp]of Longint;
 CntNb:LongInt;
 bNb:Byte;
 Pred:Array[1..MaxComp]of LongInt;
 Marker:Word;
 u,v,x,y:LongInt;
 Buffer:Array[0..2047]of Byte;
 Header:Record
  Fill:Array[0..5]of Byte;  { Donn‚e }
  Sign:Array[1..4]of Char;  { Signature: "JFIF" }
 End Absolute Buffer;
 XH:HandleExtended;         { Structure de lecture }
 Res:ImageHeaderRes;        { Entˆte d'image ressource }

 Procedure invDCTfix(Var dst,src:TBlockLongInt);Assembler;
 VAR
  Rows:TBlockLongInt;
 ASM
  {$IFDEF __386__}
   LEA EDI,rows
   MOV EDX,src
   MOV ECX,8
 @loop1a:
   PUSH ECX
    MOV EAX,[EBP+08h]
    LEA ESI,[EAX+OFFSET costab]
    MOV ECX,4
 @loop2a:
    PUSH ECX
     LODSD {0}
     IMUL EAX,DWORD PTR [EDX+000h]
     MOV EBX,EAX
     LODSD {1}
     IMUL EAX,DWORD PTR [EDX+004h]
     MOV ECX,EAX
     {----------}
     LODSD {2}
     IMUL EAX,DWORD PTR [EDX+008h]
     ADD EBX,EAX
     LODSD {3}
     IMUL EAX,DWORD PTR [EDX+00Ch]
     ADD ECX,EAX
     {----------}
     LODSD {4}
     IMUL EAX,DWORD PTR [EDX+010h]
     ADD EBX,EAX
     LODSD {5}
     IMUL EAX,DWORD PTR [EDX+014h]
     ADD ECX,EAX
     {----------}
     LODSD {6}
     IMUL EAX,DWORD PTR [EDX+018h]
     ADD EBX,EAX
     LODSD {7}
     IMUL EAX,DWORD PTR [EDX+01Ch]
     ADD ECX,EAX
     MOV EAX,EBX
     SUB EBX,ECX
     ADD EAX,ECX
    POP ECX
    MOV [EDI+ECX*8-4],EBX
    STOSD
    DEC ECX
    JNZ @loop2a
   POP ECX
   ADD EDI,16
   ADD EDX,020h
   DEC ECX
   JNZ @loop1a
   MOV EDI,dst
   MOV EAX,[EBP+08h]
   LEA ESI,[EAX+OFFSET costab]
   MOV ECX,4
 @loop1b:
   PUSH ECX
    MOV EAX,ECX
    SHL EAX,6
    SUB EAX,36
    MOV ECX,8
    LEA EDX,rows
 @loop2b:
    PUSH ESI
     PUSH EAX
      PUSH ECX
       LODSD {0}
       IMUL EAX,DWORD PTR [EDX]
       MOV EBX,EAX
       LODSD {1}
       IMUL EAX,DWORD PTR [EDX+020h]
       MOV ECX,EAX
       {----------}
       LODSD {2}
       IMUL EAX,DWORD PTR [EDX+040h]
       ADD EBX,EAX
       LODSD {3}
       IMUL EAX,DWORD PTR [EDX+060h]
       ADD ECX,EAX
       {----------}
       LODSD {4}
       IMUL EAX,DWORD PTR [EDX+080h]
       ADD EBX,EAX
       LODSD {5}
       IMUL EAX,DWORD PTR [EDX+0A0h]
       ADD ECX,EAX
       {----------}
       LODSD {6}
       IMUL EAX,DWORD PTR [EDX+0C0h]
       ADD EBX,EAX
       LODSD {7}
       IMUL EAX,DWORD PTR [EDX+0E0h]
       ADD ECX,EAX
       MOV EAX,EBX
       SUB EBX,ECX
       ADD EAX,ECX
      POP ECX
      STOSD
     POP EAX
     MOV [EDI+EAX],EBX
    POP ESI
    ADD EDX,4
    DEC ECX
    JNZ @loop2b
   POP ECX
   ADD ESI,32
   DEC ECX
   JNZ @loop1b
  {$ENDIF}
 END;

 Procedure GenerateSizeTable(tc,th:LongInt);
 Var
  i,j,k:LongInt;
 Begin
  With HuffTable^[tc,th]do Begin
   k:=0;
   For i:=1to 16do Begin
    For j:=1to Bits[i]do Begin
     HuffSize[k]:=i;
     Inc(k);
    End;
   End;
   HuffSize[k]:=0;
   Lastk:=k;
  End;
 End;

 Procedure GenerateCodeTable(tc,th:LongInt);
 Var
  k,si:LongInt;
  Code:DWord;
 Begin
  With hufftable^[tc,th]do Begin
   k:=0;
   Code:=0;
   si:=HuffSize[0];
   Repeat
    Repeat
     HuffCode[k]:=Code;
     Code:=Code+1;
     k:=k+1;
    Until HuffSize[k]<>si;
    If huffsize[k]<>0Then Begin
     Repeat
      Code:=Code shl 1;
      si:=si+1;
     Until HuffSize[k]=si;
    End;
   Until HuffSize[k]=0;
  End;
 End;

 Procedure DecoderTables(tc,th:LongInt);
 Var
  i,j:LongInt;
 Begin
  With HuffTable^[tc,th]do Begin
   j:=0;
   For i:=1to 16do Begin
    If bits[i]=0Then MaxCode[i]:=$FFFFFFFF
     Else
    Begin
     ValPtr[i]:=j;
     MinCode[i]:=HuffCode[j];
     j:=j+bits[i]-1;
     MaxCode[i]:=HuffCode[j];
     j:=j+1;
    End;
   End;
  End;
 End;

 Function InterpretMarkers(Marker:Word):Word;
 Var
  SegMarker,SegLength:Word;
  i,j,k,tc,th:LongInt;
 Begin
  InterpretMarkers:=0;
  If(EndOfImage)Then Exit;
  SegMarker:=ReadWord(XH);
  While Not((SegMarker>=$FFC0)and(SegMarker<=$FFFE))and(Not EOF(XH))do Begin
   Seek(XH,XH.FP-1);
   SegMarker:=ReadWord(XH);
  End;
  InterpretMarkers:=SegMarker;
  If EOF(XH)Then Begin
   EndOfScan:=True;
   EndOfImage:=True;
   Exit;
  End;
  If Marker<>0Then If(SegMarker<>Marker)Then Exit;
  Case(SegMarker)of
   mSOF0..mSOF3,mSOF5..mSOF11,mSOF13..mSOF15:Begin
    SegLength:=ReadWord(XH)-2;
    SOF.P:=ReadByte(XH);
    SOF.Y:=ReadWord(XH);
    SOF.X:=ReadWord(XH);
    SOF.Nf:=ReadByte(XH);
    Dec(SegLength,6);
    For i:=1to(SOF.Nf)do Begin
     SOF.Ci[i]:=ReadByte(XH);
     SOF.HiVi[i]:=ReadByte(XH);
     SOF.Tqi[i]:=ReadByte(XH);
     Dec(SegLength,3)
    End;
    Seek(XH,GetFilePos(XH)+SegLength);
    If(SegMarker>=mSOF0)and(SegMarker<=mSOF2)Then Begin
     Res.ID:=idResImage;
     Res.Format:=fdiBinary;
     Res.Original:=diJPEG;
     Res.NumXPixels:=SOF.X;
     Res.NumYPixels:=SOF.Y;
     Res.BitsPerPixel:=24;
     Res.BytesPerLine:=LenNBits2BytesPerLine(Res.NumXPixels,Res.BitsPerPixel);
     XAllocMem(Ressource,SizeOf(Res)+Mul2Word(Res.BytesPerLine,Res.NumYPixels),Q);
     XSetAbsRec(Q,0,SizeOf(Res),Res);
     RIJPEG:=0;
     SOFtype:=SegMarker;
    End
     Else
    Begin
     EndOfScan:=True;
     EndOfImage:=True;
    End;
   End;
   mDHT:Begin {FFC4}
    SegLength:=ReadWord(XH)-2;
    While SegLength>0do Begin
     DHT.TcTh:=ReadByte(XH);
     ReadBuf(XH,16,DHT.Li);
     Dec(SegLength,17);
     Tc:=DHT.TcTh shr 4;
     Th:=DHT.TcTh and $F;
     k:=0;
     For i:=1to 16do Begin
      HuffTable^[tc,th].Bits[i]:=DHT.Li[i];
      For j:=1to DHT.Li[i]do Begin
       HuffTable^[tc,th].HuffVal[k]:=ReadByte(XH);
       Dec(seglength);
       Inc(k);
      End;
     End;
     GenerateSizeTable(Tc,Th);
     GenerateCodeTable(Tc,Th);
     DecoderTables(Tc,Th);
    End;
    Seek(XH,GetFilePos(XH)+SegLength);
   End;
   mSOI:Begin {FFD8}
   End;
   mEOI:Begin {FFD9}
    EndOfScan:=True;
    EndOfImage:=True;
   End;
   mSOS:Begin {FFDA}
    SegLength:=ReadWord(XH)-2;
    SOS.Ns:=ReadByte(XH);
    Dec(SegLength);
    For i:=1to(SOS.Ns)do Begin
     SOS.Csj[i]:=ReadByte(XH);
     SOS.TdjTaj[i]:=ReadByte(XH);
     Dec(SegLength,2);
     If(SOS.Csj[i]>SOF.Nf)Then SOS.Csj[i]:=1;
    End;
    SOS.Ss:=ReadByte(XH);
    SOS.Se:=ReadByte(XH);
    SOS.AhAl:=ReadByte(XH);
    Dec(SegLength,3);
    Seek(XH,GetFilePos(XH)+SegLength);
   End;
   mDQT:Begin {FFDB}
    SegLength:=ReadWord(XH)-2;
    While SegLength>0do Begin
     DQT.PqTq:=ReadByte(XH);
     Dec(SegLength);
     For i:=0to 63do Begin
      DQT.Qk[i]:=0;
      Case DQT.PqTq shr 4of
       0:Begin
        DQT.Qk[i]:=ReadByte(XH);
        Dec(SegLength,1);
       End;
       1:Begin
        DQT.Qk[i]:=Swap(ReadWord(XH));
        Dec(Seglength,2);
       End;
      End;
      Qk[DQT.PqTq and$F][i]:=DQT.Qk[i];
     End;
    End;
    Seek(XH,GetFilePos(XH)+SegLength);
   End;
   mDRI:Begin {FFDD}
    SegLength:=ReadWord(XH)-2;
    RestartInterval:=ReadWord(XH);
    Dec(SegLength,2);
    Seek(XH,GetFilePos(XH)+SegLength);
   End;
   mAPP0..mAPP15,mCOM:Begin {FFE0..FFEF,FFFE}
    SegLength:=ReadWord(XH)-2;
    Seek(XH,GetFilePos(XH)+SegLength);
   End;
  End;
 End;

 Function NextByte:Byte;
 Var
  b,c:Byte;
 Begin
  B:=ReadByte(XH);
  If EOF(XH)Then Begin
   EndOfScan:=True;
   EndOfImage:=True;
  End
   Else
  Begin
   If b=$FFThen Begin
    c:=ReadByte(XH);
    If c<>0Then Begin
     Seek(XH,GetFilePos(XH)-2);
     EndOfScan:=True;
    End;
   End;
  End;
  NextByte:=b;
 End;

 Function NextBit:LongInt;
 Var
  Bit:LongInt;
 Begin
  If CntNb=0Then Begin
   bNb:=NextByte;
   CntNb:=8;
  End;
  Bit:=bNb shr 7;
  CntNb:=CntNb-1;
  bNb:=Byte(bNb shl 1);
  NextBit:=Bit and 1;
 End;

 Function Receive(n:LongInt):LongInt;
 Var
  Bits:LongInt;
 Begin
  If(EndOfScan)Then Exit;
  Bits:=0;
  If(n>=CntNb)Then Begin
   Bits:=bNb shr (8-CntNb);
   Dec(n,CntNb);
   bNb:=NextByte;
   CntNb:=8;
  End;
  While n>=8do Begin
   Bits:=(Bits shl 8) or bNb;
   bNb:=NextByte;
   Dec(n,8);
  End;
  While n>0do Begin
   If CntNb=0Then Begin
    bNb:=NextByte;
    CntNb:=8;
   End;
   Bits:=(Bits shl 1)or(bNb shr 7)and 1;
   Dec(CntNb);
   bNb:=Byte(bNb shl 1);
   Dec(n);
  End;
  Receive:=Bits;
 End;

 Function Extend(v,t:LongInt):LongInt;Assembler;ASM
  DB 66h;MOV CX,Word Ptr t
  DB 66h;MOV BX,1
  DB 66h;SHL BX,CL
  DB 66h;SHR BX,1
  DB 66h;MOV AX,Word Ptr v
  DB 66h;CMP AX,BX
  JGE @nosign
  DB 66h;MOV BX,-1
  DB 66h;SHL BX,CL
  DB 66h;INC BX
  DB 66h;ADD AX,BX
 @NoSign:
 END;

 Function Decode(tc,th:LongInt):LongInt;
 Var
  i,j,Value,Code:DWord;
 Begin
  With HuffTable^[tc,th]do Begin
   i:=1;
   Code:=NextBit;
   While((Code>MaxCode[i])or(Bits[i]=0))and Not(EndOfScan or EndOfImage)do Begin
    i:=i+1;
    Code:=(Code shl 1)+NextBit;
   End;
   If(EndOfScan)Then Exit;
   j:=ValPtr[i];
   j:=j+Code-MinCode[i];
   Value:=HuffVal[j];
  End;
  Decode:=Value;
 End;

 Procedure DecodeCoefficientsSOF0(Sosidx,Comp,v,h:LongInt);
 Var
  i,k,rs,ssss,rrrr,t,hdc,hac:LongInt;
  Coeff:Array[0..63]of LongInt;
  Q:^TVectLongInt;
 Begin
  If(EndOfScan)Then Exit;
  hdc:=SOS.TdjTaj[SosIdx]shr 4;
  hac:=SOS.TdjTaj[SosIdx]and$F;
  Q:=@Qk[SOF.Tqi[comp]];
  t:=Decode(0,hdc);
  If(EndOfScan)Then Exit;
  Pred[Comp]:=Pred[Comp]+Extend(Receive(t),t);
  Coeff[ZigiZagi[0]]:=Pred[Comp]*Q^[0];
  For i:=1to 63do Coeff[i]:=0;
  k:=1;
  Repeat
   rs:=Decode(1,hac);
   ssss:=RS and 15;
   rrrr:=(RS shr 4)and 15;
   k:=k+rrrr;
   If ssss<>0Then Begin
    If k<=63Then Coeff[ZigiZagi[k]]:=Extend(Receive(ssss),ssss)*Q^[k];
   End
    Else
   Begin
    If rrrr<>15Then Break;
   End;
   Inc(k);
  Until(k>63)or(EndOfScan)or(EndOfImage);
  invDCTfix(idctfix[v,h,Comp],TBlockLongInt(Coeff));
 End;

 Procedure DecodeCoefficientsSOF2(SosIdx,Comp:Longint);
 Var
  k,rs,ssss,rrrr,t,hdc,hac,cb,eobrun,Al,Ah:LongInt;
  p1,m1:SmallInt;
  Coeff:^SmallInt;
 Begin
  If(EndOfScan)Then Exit;
  cb:=CoeffBufIdx[Comp];
  EobRun:=CoeffEobRun[Comp];
  If cb>=CoeffBufW[Comp]*CoeffBufH[Comp]Then Begin
   While Not(EndOfScan)do NextBit;
   Exit;
  End;
  Ah:=SOS.AhAl shr 4;
  Al:=SOS.AhAl and$F;
  Hdc:=SOS.TdjTaj[SosIdx]shr 4;
  Hac:=SOS.TdjTaj[SosIdx]and$F;
  If SOS.Ss=0Then Begin
   If Ah=0Then Begin
    t:=Decode(0,hdc);
    Pred[Comp]:=Pred[Comp]+Extend(Receive(t),t);
    If(EndOfScan)Then Exit;
    CoeffBuf[Comp]^[cb,0]:=Pred[Comp]shl Al;
   End
    Else
   Begin
    Coeffbuf[Comp]^[cb,0]:=CoeffBuf[Comp]^[cb,0]or(Receive(1)shl Al);
   End;
  End
   Else
  Begin
   If Ah=0Then Begin
    If EobRun>0Then Dec(EobRun)
     Else
    Begin
     k:=SOS.Ss;
     While(k<=SOS.Se)do Begin
      rs:=Decode(1,hac);
      If(EndOfScan)Then Exit;
      ssss:=rs and$F;
      rrrr:=(rs shr 4)and$F;
      If ssss<>0Then Begin
       Inc(k,rrrr);
       Coeffbuf[Comp]^[cb,k]:=Extend(Receive(ssss),ssss)shl Al;
       If(EndOfScan)Then Exit;
      End
       Else
      Begin
       If rrrr=15Then Begin
        Inc(k,15);
       End
        Else
       Begin
        EobRun:=LongInt(1)shl rrrr;
        If rrrr<>0Then Begin
         rrrr:=Receive(rrrr);
         If(EndOfScan)Then Exit;
         Inc(EobRun,rrrr);
        End;
        Dec(EobRun);
        Break;
       End;
      End;
      Inc(k);
     End;
    End;
   End
    Else
   Begin
    p1:=SmallInt(1) shl Al;
    m1:=SmallInt(-1) shl Al;
    k:=SOS.Ss;
    If EobRun=0Then Begin
     While(k<=SOS.Se)do Begin
      rs:=Decode(1,hac);
      If(EndOfScan)Then Exit;
      ssss:=rs and 15;
      rrrr:=(rs shr 4) and 15;
      If ssss<>0Then Begin
       If Receive(1)<>0Then ssss:=p1
                       Else ssss:=m1;
       If(EndOfScan)Then Exit;
      End
       Else
      Begin
       If rrrr<>15Then Begin
        EobRun:=LongInt(1) shl rrrr;
        If rrrr<>0Then Begin
         rrrr:=Receive(rrrr);
         If(EndOfScan)Then Exit;
         Inc(EobRun,rrrr);
        End;
        Break;
       End;
      End;
      Repeat
       Coeff:=@(CoeffBuf[Comp]^[cb,k]);
       If Coeff^<>0Then Begin
        If Receive(1)<>0Then
         If Coeff^and p1=0Then
          If Coeff^>=0Then Inc(Coeff^,p1)
                      Else inc(coeff^,m1);
        If(EndOfScan)Then Exit;
       End
        Else
       Begin
        Dec(rrrr);
        If rrrr<0Then Break;
       End;
       Inc(k);
      Until k>SOS.Se;
      If ssss<>0Then Begin
       CoeffBuf[Comp]^[cb,k]:=ssss;
      End;
      Inc(k);
     End;
    End;
    If EobRun>0Then Begin
     While(k<=SOS.Se)do Begin
      Coeff:=@(coeffbuf[comp]^[cb,k]);
      If Coeff^<>0Then Begin
       If Receive(1)<>0Then
        If Coeff^ and p1=0Then
         If Coeff^>=0Then Inc(Coeff^,p1)
                     Else Inc(Coeff^,m1);
       If(EndOfScan)Then Exit;
      End;
      Inc(k);
     End;
     Dec(EobRun);
    End;
   End;
  End;
  CoeffEobRun[Comp]:=EobRun;
 End;

 Function GetCompIdx(Comp:LongInt):LongInt;
 Var
  n:LongInt;
 Begin
  n:=0;
  Repeat
   Inc(n);
  Until(n>SOF.Nf)or(SOF.Ci[n]=Comp);
  If(n>SOF.Nf)Then n:=1;
  GetCompIdx:=n;
 End;

 Function RGBColor32(Color:LongInt):LongInt;Assembler;ASM
  {$IFDEF __386__}
   MOV EAX,Color
  {$ELSE}
   LES AX,Color
   MOV DX,ES
  {$ENDIF}
 END;

 Function ycbcr2rgbfix(y,cb,cr:LongInt):LongInt;Assembler;
 Const
  Rcr=Trunc((1 shl(32-Fixpt))*1.40200);
  Gcb=Trunc((1 shl(32-Fixpt))*0.34414);
  Gcr=Trunc((1 shl(32-Fixpt))*0.71414);
  Bcb=Trunc((1 shl(32-Fixpt))*1.77200);
 ASM
  {$IFDEF __386__}
   MOV EBX,y
   SAR EBX,fixpt
   ADD EBX,128
   MOV EAX,Bcb
   IMUL cb
   ADD EDX,EBX
   TEST EDX,0FFFFFF00h
   SETZ AL
   SETS CL
   DEC AL
   OR DL,AL
   ADD DL,CL
   SHRD EDI,EDX,8
   MOV ECX,EBX
   MOV EAX,Gcr
   IMUL cr
   SUB ECX,EDX
   MOV EAX,Gcb
   IMUL cb
   SUB ECX,EDX
   TEST ECX,0FFFFFF00h
   SETZ AL
   SETS DL
   DEC AL
   OR CL,AL
   ADD CL,DL
   SHRD EDI,ECX,8
   MOV EAX,Rcr
   IMUL cr
   ADD EDX,EBX
   TEST EDX,0FFFFFF00h
   SETZ AL
   SETS CL
   DEC AL
   OR DL,AL
   ADD DL,CL
   SHRD EDI,EDX,8
   SHR EDI,8
   PUSH EDI
   CALL RGBColor32
  {$ENDIF}
 END;

 Procedure Draw;
 Var
  x,y,c,v,h,v1,h1,v2,h2,v3,h3,hx,vy,xx,yy:LongInt;
  hh1,hh2,hh3:LongInt;
  vv1,vv2,vv3:LongInt;
  ih1,ih2,ih3:LongInt;
  iv1,iv2,iv3:LongInt;
  hx1,hx2,hx3:LongInt;
  vy1,vy2,vy3:LongInt;
 Begin
  xx:=CoeffX[1];
  yy:=CoeffY[1];
  v1:=SOF.HiVi[1]and$F;
  h1:=SOF.HiVi[1]shr 4;
  v2:=SOF.HiVi[2]and$F;
  h2:=SOF.HiVi[2]shr 4;
  v3:=SOF.HiVi[3]and$F;
  h3:=SOF.HiVi[3]shr 4;
  If v1=0Then v1:=1;
  If h1=0Then h1:=1;
  If v2=0Then v2:=1;
  If h2=0Then h2:=1;
  IF v3=0Then v3:=1;
  IF h3=0Then h3:=1;
  ih1:=(h1 shl 4)div h1;
  ih2:=(h2 shl 4)div h1;
  ih3:=(h3 shl 4)div h1;
  iv1:=(v1 shl 4)div v1;
  iv2:=(v2 shl 4)div v1;
  iv3:=(v3 shl 4)div v1;
  For v:=0to v1-1do For h:=0to h1-1do Begin
   vv1:=v mod v1;
   hh1:=h mod h1;
   vv2:=v mod v2;
   hh2:=h mod h2;
   vv3:=v mod v3;
   hh3:=h mod h3;
   vy1:=(v*iv1)shl 3;
   vy2:=(v*iv2)shl 3;
   vy3:=(v*iv3)shl 3;
   For y:=0to 7do Begin
    hx1:=(h*ih1)shl 3;
    hx2:=(h*ih2)shl 3;
    hx3:=(h*ih3)shl 3;
    For x:=0to 7do Begin
     Case(SOF.Nf)of
      1:c:=ycbcr2rgbfix(Idctfix[vv1,hh1,1][x,y],0,0);
      3:c:=ycbcr2rgbfix(Idctfix[vv1,hh1,1][(hx1 shr 4) and 7,(vy1 shr 4) and 7],
                        Idctfix[vv2,hh2,2][(hx2 shr 4) and 7,(vy2 shr 4) and 7],
                        Idctfix[vv3,hh3,3][(hx3 shr 4) and 7,(vy3 shr 4) and 7]);
     End;
     hx:=xx+(h shl 3+x);
     vy:=yy+(v shl 3+y);
     If(hx<SOF.X)and(vy<SOF.Y)Then
      XSetAbsRec(Q,vy*Res.BytesPerLine+hx*BytPerPix,BytPerPix,C);
     Inc(hx1,ih1);
     Inc(hx2,ih2);
     Inc(hx3,ih3);
    End;
    Inc(vy1,iv1);
    Inc(vy2,iv2);
    Inc(vy3,iv3);
   End;
  End;
{  If xx=0Then ProgressMonitor(yy,(SOF.Y-1)and Not((v1*8)-1));}
  Inc(xx,(h1*8));
  If(xx>=SOF.X)Then Begin
   xx:=0;
   Inc(yy,(v1*8));
   If(yy>=SOF.Y)Then Begin
    Repeat
     NextBit;
    Until EndOfScan;
   End;
  End;
  CoeffX[1]:=xx;
  CoeffY[1]:=yy;
 End;

 Procedure DecodeMcuSOF0;
 Var
  i,j,v,h,vi,hi:LongInt;
 Begin
  For i:=1to(SOS.Ns)do Begin
   j:=GetCompIdx(SOS.Csj[i]);
   vi:=SOF.HiVi[j]and$F;
   hi:=SOF.HiVi[j]shr 4;
   For v:=0to vi-1do Begin
    For h:=0to hi-1do Begin
     DecodeCoefficientsSOF0(i,j,v,h);
     If(EndOfScan)Then Break;
    End;
    If(EndOfScan)Then Break;
   End;
   If(EndOfScan)Then Break;
  End;
  Draw;
 End;

 Procedure DecodeMcuSOF2;
 Var
  i,j,v,h,vi,hi:LongInt;
 Begin
  For i:=1to(SOS.Ns)do Begin
   j:=GetCompIdx(SOS.Csj[i]);
   Vi:=SOF.HiVi[j]and$F;
   Hi:=SOF.HiVi[j]shr 4;
   If SOS.Ss=0Then Begin
    For v:=0to vi-1do Begin
     For h:=0 TO hi-1do Begin
      CoeffBufIdx[j]:=(CoeffY[j]+v)*CoeffbufW[j]+CoeffX[j]+h;
      DecodeCoefficientsSOF2(i,j);
      If(EndOfScan)Then Break;
     End;
     If(EndOfScan)Then Break;
    End;
    Inc(CoeffX[j],Hi);
    If CoeffX[j]>=CoeffBufXd[j]Then Begin
     CoeffX[j]:=0;
     Inc(CoeffY[j],vi);
     If(CoeffY[j]>=CoeffBufYd[j])Then EndOfScan:=True;
    End;
    If(EndOfScan)Then Break;
   End
    Else
   Begin
    CoeffBufIdx[j]:=CoeffY[j]*CoeffBufW[j]+CoeffX[j];
    DecodeCoefficientsSOF2(i,j);
    Inc(CoeffX[j]);
    If CoeffX[j]>=CoeffBufXd[j]Then Begin
     CoeffX[j]:=0;
     Inc(CoeffY[j]);
     If CoeffY[j]>=CoeffBufYd[j]Then EndOfScan:=True;
    End;
   End;
  End;
 End;

 Procedure DecodeRestartInterval;
 Var
  Marker:Word;
  C:LongInt;
 Begin
  CntNb:=0;
  For c:=1to(MaxComp)do Pred[c]:=0;
  EndOfScan:=False;
  Repeat
   If RestartInterval=0Then Begin
    Case(SOFtype)of
     mSOF0:DecodeMcuSOF0;
     mSOF1:DecodeMcuSOF0;
     mSOF2:DecodeMcuSOF2;
    End;
   End
    Else
   Begin
    For c:=1to(RestartInterval)do Begin
     Case(SOFtype)of
      mSOF0:DecodeMcuSOF0;
      mSOF1:DecodeMcuSOF0;
      mSOF2:DecodeMcuSOF2;
     End;
     If(EndOfScan)Then Break;
    End;
    EndOfScan:=True;
   End;
  Until EndOfScan;
  Marker:=InterpretMarkers(mDNL);
  If(Marker<>mDNL)Then Seek(XH,GetFilePos(XH)-2);
 End;

 Procedure DecodeScan;
 Var
  Marker:Word;
  c:LongInt;
 Begin
  EndOfScan:=False;
  For c:=1to(MaxComp)do Begin
   CoeffBufIdx[c]:=0;
   CoeffEobRun[c]:=0;
   CoeffX[c]:=0;
   CoeffY[c]:=0;
  End;
  Repeat
   DecodeRestartInterval;
   Marker:=InterpretMarkers($FFFF);
   If(Marker>=mRST0)and(Marker<=mRST7)Then Begin
    EndOfScan:=False;
   End
    Else
   Seek(XH,GetFilePos(XH)-2);
  Until(EndOfScan)or(EndOfImage);
 End;

 Procedure DrawCoeffBuf;
 Var
  xx,yy,x,y,c,v,h,v1,h1,v2,h2,v3,h3,hx,vy,hh,vv,i,j,k,l,qq:LongInt;
  DEqu:TBlockLongInt;
  cbi,cbX,cbY:Array[1..MaxComp]of LongInt;
  hh1,hh2,hh3:LongInt;
  vv1,vv2,vv3:LongInt;
  ih1,ih2,ih3:LongInt;
  iv1,iv2,iv3:LongInt;
  hx1,hx2,hx3:LongInt;
  vy1,vy2,vy3:LongInt;
 Begin
  v1:=SOF.HiVi[1]and$F;
  h1:=SOF.HiVi[1]shr 4;
  v2:=SOF.HiVi[2]and$F;
  h2:=SOF.HiVi[2]shr 4;
  v3:=SOF.HiVi[3]and$F;
  h3:=SOF.HiVi[3]shr 4;
  If v1=0Then v1:=1;
  If h1=0Then h1:=1;
  If v2=0Then v2:=1;
  If h2=0Then h2:=1;
  If v3=0Then v3:=1;
  If h3=0Then h3:=1;
  ih1:=(h1 shl 4)div h1;
  ih2:=(h2 shl 4)div h1;
  ih3:=(h3 shl 4)div h1;
  iv1:=(v1 shl 4)div v1;
  iv2:=(v2 shl 4)div v1;
  iv3:=(v3 shl 4)div v1;
  xx:=0;
  yy:=0;
  For c:=1to(SOF.Nf)do Begin
   cbi[c]:=0;
   cbX[c]:=0;
   cbY[c]:=0;
  End;
  Repeat
   For c:=1to(SOF.Nf)do Begin
    vv:=SOF.HiVi[c]and$F;
    hh:=SOF.HiVi[c]shr 4;
    qq:=SOF.Tqi[c];
    For v:=0to vv-1do For h:=0to hh-1do Begin
     cbi[c]:=(cbY[c]+v)*CoeffBufW[c]+(cbX[c]+h);
     l:=cbi[c];
     For i:=0to 7do For j:=0to 7do Begin
      k:=ZigZag[j,i];
      dequ[i,j]:=CoeffBuf[c]^[l][k]*Qk[qq][k];
     End;
     invDCTfix(idctfix[v,h,c],dequ);
     Inc(cbi[c]);
    End;
    Inc(cbX[c],hh);
    If cbX[c]>=coeffbufXd[c]Then Begin
     cbX[c]:=0;
     Inc(cbY[c],vv);
    End;
   End;
   For v:=0to v1-1do For h:=0to h1-1do Begin
    vv1:=v mod v1;
    hh1:=h mod h1;
    vv2:=v mod v2;
    hh2:=h mod h2;
    vv3:=v mod v3;
    hh3:=h mod h3;
    vy1:=(v*iv1)shl 3;
    vy2:=(v*iv2)shl 3;
    vy3:=(v*iv3)shl 3;
    For y:=0to 7do Begin
     hx1:=(h*ih1)shl 3;
     hx2:=(h*ih2)shl 3;
     hx3:=(h*ih3)shl 3;
     For x:=0to 7do Begin
      Case(SOF.Nf)of
       1:c:=ycbcr2rgbfix(idctfix[vv1,hh1,1][x,y],0,0);
       3:c:=ycbcr2rgbfix(idctfix[vv1,hh1,1][(hx1 shr 4) and 7,(vy1 shr 4) and 7],
                         idctfix[vv2,hh2,2][(hx2 shr 4) and 7,(vy2 shr 4) and 7],
                         idctfix[vv3,hh3,3][(hx3 shr 4) and 7,(vy3 shr 4) and 7]);
      End;
      hx:=xx+(h shl 3+x);
      vy:=yy+(v shl 3+y);
      If(hx<SOF.X)and(vy<SOF.Y)Then
       XSetAbsRec(Q,vy*Res.BytesPerLine+hx*BytPerPix,BytPerPix,c);
      Inc(hx1,ih1);
      Inc(hx2,ih2);
      Inc(hx3,ih3);
     End;
     Inc(vy1,iv1);
     Inc(vy2,iv2);
     Inc(vy3,iv3);
    End;
   End;
{   If xx=0Then ProgressMonitor(yy,(SOF.Y-1) AND Not((v1*8)-1));}
   Inc(xx,(h1*8));
   If(xx>=SOF.X)Then Begin
    xx:=0;
    Inc(yy,(v1*8));
   End;
  Until yy>=SOF.Y;
 End;

 Procedure DecodeFrame;
 Var
  Marker:Word;
  c,h,v,v1,h1:LongInt;
 Begin
  If(SOFtype=mSOF2)Then Begin
   v1:=SOF.HiVi[1]and$F;
   h1:=SOF.HiVi[1]shr 4;
   For c:=1to(SOF.Nf)do Begin
    v:=SOF.HiVi[c]and$F;
    h:=SOF.HiVi[c]shr 4;
    CoeffbufW[c]:=((SOF.X+15)and$FFFF)div 8;
    CoeffbufH[c]:=((SOF.Y+15)and$FFFF)div 8;
    CoeffbufXd[c]:=(SOF.X+(h1 div h)*8-1)div(8*(h1 div h));
    CoeffbufYd[c]:=(SOF.Y+(v1 div v)*8-1)div(8*(v1 div v));
    GetMem(CoeffBuf[c],CoeffBufW[c]*CoeffBufH[c]*SizeOf(TCoeffBuf));
    FillClr(CoeffBuf[c]^,CoeffBufW[c]*CoeffBufH[c]*SizeOf(TCoeffBuf));
   End;
  End;
  Repeat
   Repeat
    Marker:=InterpretMarkers(0);
   Until(Marker=mSOS)or EndOfImage;
   DecodeScan;
   Marker:=InterpretMarkers(mEOI);
   If(Marker<>mEOI)Then Seek(XH,GetFilePos(XH)-2);
  Until(Marker=mEOI)or EndOfImage;
  If(SOFtype=mSOF2)Then Begin
   DrawCoeffBuf;
   For c:=1to(SOF.Nf)do Begin
    FreeMemory(coeffbuf[c],coeffbufW[c]*coeffbufH[c]*SizeOf(Tcoeffbuf));
   End;
  End;
 End;

Begin
 RIJPEG:=eriInvalidHeader;
 FillClr(Res,SizeOf(Res));
 _GetAbsRec(Handle,0,SizeOf(Header),Header);
 If Header.Sign='JFIF'Then Begin
  InitReadPackData(XH,Handle,LongInt(SizeOf(Header))+FilePos,SizeOf(Buffer),Buffer);
  XH.Format:=Motorola;
  HuffTable:=MemAlloc(SizeOf(THuffTable));
  If(HuffTable<>NIL)Then Begin
   For v:=0to 7do For u:=0to 7do CosTab[v,u]:=Trunc(Cos((2*v+1)*u*PI/16)*cx[u]*0.5*256);
   EndOfImage:=False;RestartInterval:=0;SOFtype:=0;
   Marker:=ReadWord(XH);
   If(Marker=mSOI)Then Begin
    Repeat
     Marker:=InterpretMarkers(0);
    Until(SOFtype<>0)or(EndOfImage);
    If SOFtype<>0Then DecodeFrame;
   End;
   FreeMemory(HuffTable,SizeOf(THuffTable));
  End
   Else
  RIJPEG:=eriOutOfMemory;
 End;
End;

{
 Cette fonction permet de lire une image de format PPM.
}

Function RIPPM(Handle:Hdl;FilePos:Long;Ressource:Byte;
               Flags:FlagsProcessusImage;Var Q:XInf):Word;Near;
Var
 Res:ImageHeaderRes;
 S:String;
 NumColor,FS,CurrSize,ImageSize,RP:LongInt;
 Buffer:Array[0..4095]of Byte;
 Load:Boolean;
 W:Window;
 I,J:Word;
Begin
 RIPPM:=eriInvalidHeader;
 FillClr(Res,SizeOf(Res));
 __GetAbsFileTxtLn(Handle,FilePos,S);
 If(S='P5')or(S='P6')Then Begin
  FS:=FileSize(Handle);
  __GetAbsFileTxtLn(Handle,FilePos,S);
  If S<>''Then Begin
   For I:=1to Length(S)do If S[I]=' 'Then Break;
   If I>=Length(S)Then Exit;
   Res.NumXPixels:=StrToWord(Left(S,I-1));
   If Res.NumXPixels=0Then Exit;
   Res.NumYPixels:=StrToWord(Copy(S,I+1,255));
   If Res.NumYPixels=0Then Exit;
   __GetAbsFileTxtLn(Handle,FilePos,S);
   NumColor:=StrToInt(S);
   Case(NumColor)of
    0,255:Begin
     CurrSize:=FS-FilePos;
     If CurrSize<>0Then CurrSize:=CurrSize div Res.NumYPixels;
     If CurrSize>=Res.NumXPixels*3Then Res.BitsPerPixel:=24 Else
     If CurrSize>=Res.NumXPixels shl 1Then Res.BitsPerPixel:=16 Else
     If(CurrSize>=Res.NumXPixels)Then Res.BitsPerPixel:=8 Else
     If CurrSize>=Res.NumXPixels shr 1Then Res.BitsPerPixel:=4 Else
     If CurrSize>=Res.NumXPixels shr 2Then Res.BitsPerPixel:=2 Else
     If CurrSize>=Res.NumXPixels shr 3Then Res.BitsPerPixel:=1;
    End;
    2:Res.BitsPerPixel:=1;
    4:Res.BitsPerPixel:=2;
    16:Res.BitsPerPixel:=4;
    256:Res.BitsPerPixel:=8;
    Else Begin
     If NumColor=65536Then Res.BitsPerPixel:=16 Else
     If NumColor=16777216Then Res.BitsPerPixel:=24;
    End;
   End;
   If Res.BitsPerPixel=0Then Exit;
   Res.BytesPerLine:=LenNBits2BytesPerLine(Res.NumXPixels,Res.BitsPerPixel);
   If Res.BytesPerLine>SizeOf(Buffer)Then Begin
    RIPPM:=eriLineTooBig;
    Exit;
   End;
   Res.ID:=idResImage;Res.Format:=fdiBinary;Res.Original:=diPPM;
   ImageSize:=Mul2Word(Res.BytesPerLine,Res.NumYPixels);
   If BestAlloc(Res,Flags,Ressource,SizeOf(Res)+ImageSize,Load,Q)Then Begin
    Inc(FilePos);
    If(fpProgressBar)in(Flags)Then WEInitProgressBar(W);
    RP:=SizeOf(Res);
    For J:=0to Res.NumYPixels-1do Begin
     _GetAbsRec(Handle,FilePos,Res.BytesPerLine,Buffer);
     XSetAbsRec(Q,RP,Res.BytesPerLine,Buffer);
     If(fpViewScr)in(Flags)Then BestClrLnHorImg(J,Res,Buffer);
     Inc(RP,Long(Res.BytesPerLine));
     Inc(FilePos,Long(Res.BytesPerLine));
     If(fpProgressBar)in(Flags)Then WEUpDate(W,RP,ImageSize);
    End;
    XSetAbsRec(Q,0,SizeOf(Res),Res);
    If(fpProgressBar)in(Flags)Then WEDone(W);
    RIPPM:=eriNone;
   End
    Else
   RIPPM:=eriOutOfMemory;
  End;
 End;
End;

{ Cette fonction permet de lire une imager de format SCi
}

Function RISCi(Handle:Hdl;FilePos:Long;Ressource:Byte;
               Flags:FlagsProcessusImage;Var Q:XInf):Word;Near;
Var
 Header:SCiHeader;
 Res:ImageHeaderRes;
 Pal256:Palette256RGB;
 I:Word;
 FP,RP:LongInt;
 Buffer:Array[0..4095]of Byte;
Begin
 RISci:=eriInvalidHeader;
 _GetAbsRec(Handle,FilePos,SizeOf(Header),Header);
 If Header.Sign='RIX3'Then Begin
  FillClr(Res,SizeOf(Res));
  Res.ID:=idResImage;Res.Format:=fdiBinary;
  Res.NumXPixels:=Header.NumXPixels;
  Res.NumYPixels:=Header.NumYPixels;
  Res.BytesPerLine:=Header.NumXPixels;
  Res.BitsPerPixel:=8;
  Res.NumPal:=256;Res.Original:=diSCi;
  If Res.BytesPerLine>SizeOf(Buffer)Then Begin
   RISCi:=eriLineTooBig;
   Exit;
  End;
  If XAllocMem(Ressource,SizeOf(Res)+Res.BytesPerLine*Res.NumYPixels+768,Q)Then Begin
   XSetAbsRec(Q,0,SizeOf(Res),Res);
   FP:=FilePos+768+SizeOf(Header);RP:=SizeOf(Res);
   For I:=0to Res.NumYPixels-1do Begin
    _GetAbsRec(Handle,FP,Res.BytesPerLine,Buffer);
    XSetAbsRec(Q,RP,Res.BytesPerLine,Buffer);
    Inc(FP,Long(Res.BytesPerLine));Inc(RP,Long(Res.BytesPerLine));
   End;
   _GetAbsRec(Handle,FilePos+SizeOf(Header),768,Pal256);
   For I:=0to 255do Begin
    Pal256[I].R:=Pal256[I].R shl 2;
    Pal256[I].G:=Pal256[I].G shl 2;
    Pal256[I].B:=Pal256[I].B shl 2;
   End;
   XSetAbsRec(Q,RP,768,Pal256);
   RISci:=eriNone;
  End;
 End;
End;

Function RIIntelligentImage(Handle:Hdl;FilePos:LongInt;Ressource:Byte;
                            Flags:FlagsProcessusImage;Var Q:XInf):Word;Near;
Var
 Header:ImiHeader;     { Entˆte du fichier }
 XH:HandleExtended;    { Structure de lecture }
 Buffer:Array[0..2047]of Byte;
 CurrColor:LongInt;    { Couleur courante }
 LX,LY:Word;           { Dernier coordonn‚e physique d'affichage }
 XB,YB:Real;           { Taille d'un bloc }
 Res:ImageHeaderRes;   { Entˆte d'image ressource }
 ImageSize:LongInt;    { Taille de l'image }
 I:Word;               { Compteur de boucle }

 Procedure PutPixel(X,Y:Word);Begin
  LX:=X;LY:=Y;
  Case(Header.BitsPerPixel)of
   16:;
   24:;
   32:XSetAbsRec(Q,SizeOf(ImageHeaderRes)+Y*Res.NumXPixels+X,SizeOf(Long),CurrColor);
  End;
 End;

 Procedure PutRealPixel(X,Y:Real);Begin
  PutPixel(Trunc(X*XB),Trunc(Y*YB));
 End;

Begin
 FillClr(Res,SizeOf(Res));
 _GetAbsRec(Handle,FilePos,SizeOf(Header),Header);
 InitReadPackData(XH,Handle,Long(SizeOf(Header))+FilePos,SizeOf(Buffer),Buffer);
 If Header.ScaleX=0Then XB:=0
 Else XB:=Header.NumXPixels/Header.ScaleX;
 If Header.ScaleY=0Then YB:=0
 Else YB:=Header.NumYPixels/Header.ScaleY;
 CurrColor:=$FFFFFFFF;
 Res.ID:=idResImage;Res.Format:=fdiBinary;
 Res.NumXPixels:=Header.NumXPixels;
 Res.NumYPixels:=Header.NumYPixels;
 Res.BytesPerLine:=LenNBits2BytesPerLine(Header.NumXPixels,Header.BitsPerPixel);
 Res.BitsPerPixel:=Header.BitsPerPixel;
 Res.Original:=diImi;
 ImageSize:=Res.BytesPerLine*Res.NumYPixels;
 LX:=Res.NumXPixels shr 1;LY:=Res.NumYPixels shr 1;
 If XAllocMem(Ressource,SizeOf(Res)+ImageSize,Q)Then Begin
  XSetAbsRec(Q,0,SizeOf(Res),Res);
   {Efface le fond de l'image}
  FillClr(Buffer,SizeOf(Buffer));
  For I:=0to Succ(ImageSize div SizeOf(Buffer))do Begin
   XSetAbsRec(Q,SizeOf(Res)+Long(I)*SizeOf(Buffer),SizeOf(Buffer),Buffer);
  End;
   {Traitement de l'image}
  Repeat
   Case ReadByte(XH)of
    imiTrueColor32:CurrColor:=ReadLong(XH);
    imiRealPoint:PutRealPixel(ReadReal(XH),ReadReal(XH));
    Else Break;
   End;
  Until False;
  RIIntelligentImage:=0;
 End;
End;

Function RIPNG(Handle:Hdl;FilePos:Long;Ressource:Byte;
               Flags:FlagsProcessusImage;Var Q:XInf):Word;Near;Begin
End;

{ Cette fonction permet de lire une image de format Targa.
}

Function RITGA(Handle:Hdl;FilePos:LongInt;Ressource:Byte;
               Flags:FlagsProcessusImage;Var Q:XInf):Word;Near;
Const
 _CodageTgaDirect8=1;
 _CodageTgaDirect24=2;
 _CodageTgaRle8=9;
 _CodageTgaRle24=10;
Var
 Res:ImageHeaderRes;        { Entˆte d'image ressource }
 Header:TGAHeader;
 Pal:Palette256RGB;
 XH:HandleExtended;         { Structure de lecture }
 RP:LongInt;                { Position absolue o— est rendu l'‚criture dans la ressource }
 ImageSize:LongInt;         { Taille physique de l'image }
 Buffer:Array[0..2047]of Byte;
 LineBuffer:Array[0..4095]of Byte;
 I,TmpO:Byte;
 ix,index:Word;
 J:Word;                    { Compteur de boucle vertical }
  { D‚compression RLE }
 NbrRepet:Byte;             { Nombre de r‚p‚tition }
 R,V,B:Byte;                { Rouge, Vert, Bleu }
 Load:Boolean;              { Chargement en m‚moire?}
 W:Window;                  { BoŒte de dialogue de barre de progression }
Begin
 RITGA:=0;
 _GetAbsRec(Handle,FilePos,SizeOf(Header),Header);
 FillClr(Res,SizeOf(Res));
 Res.ID:=idResImage;
 Res.Format:=fdiBinary;
 Res.NumXPixels:=Header.NumXPixels;
 Res.NumYPixels:=Header.NumYPixels;
 Res.BitsPerPixel:=Header.BitsPerPixel;
 Res.BytesPerLine:=LenNBits2BytesPerLine(Res.NumXPixels,Res.BitsPerPixel);
 If Res.BytesPerLine>SizeOf(LineBuffer)Then Begin
  RITGA:=eriLineTooBig;
  Exit;
 End;
 Res.Original:=diTGA;
 Inc(FilePos,SizeOf(Header));
 If Header.BitsPerPixel=8Then Begin
  _GetAbsRec(Handle,FilePos,Header.CMapLength*3,Pal);
  Inc(FilePos,Header.CMapLength*3);
 End;
 ImageSize:=Mul2Word(Res.BytesPerLine,Res.NumYPixels);
 If BestAlloc(Res,Flags,Ressource,SizeOf(Res)+ImageSize,Load,Q)Then Begin
  If(fpProgressBar)in(Flags)Then WEInitProgressBar(W);
  XSetAbsRec(Q,0,SizeOf(Res),Res);
  RP:=SizeOf(Res);
  InitReadPackData(XH,Handle,FilePos,SizeOf(Buffer),Buffer);
  Case(Header.BitsPerPixel)of
   8:If(Header.ImageType=_CodageTgaRle8)Then Begin
    { D‚compression RLE 8 bits/pixel }
    J:=Header.NumYPixels;
    Repeat
     ix:=0;
     Repeat
      TmpO:=ReadByte(XH);
      If TmpO and 128=0Then Begin { Lit X octets }
       For i:=0to TmpO and 127do Begin
        LineBuffer[ix]:=ReadByte(XH);
        Inc(ix);
       End;
      End
       Else
      Begin
        { R‚pŠte X octets }
       NbrRepet:=TmpO and 127+1;
       FillChr(LineBuffer[ix],NbrRepet,ReadByte(XH));
       Inc(ix,NbrRepet);
      End;
     Until Header.NumXPixels=ix;
     XSetAbsRec(Q,RP,Res.BytesPerLine,LineBuffer);
     Inc(RP,Long(Res.BytesPerLine));
     Dec(J);
    Until J+1=0;
   End
    else
   Begin
     { Image bitmap non compress‚e cod‚e en 8 bpp }
    For J:=Header.NumYPixels downto 0do Begin
     _GetAbsRec(XH.Handle,XH.FP,Res.BytesPerLine,LineBuffer);
     Inc(XH.FP,LongInt(Res.BytesPerLine));
     XSetAbsRec(Q,RP,Res.BytesPerLine,LineBuffer);
     Inc(RP,Long(Res.BytesPerLine));
    End;
   End;
   24:If(Header.ImageType=_CodageTgaRle24)Then Begin
    { D‚compression RLE 24 bits/pixel }
    J:=Header.NumYPixels;
    Repeat
     ix:=0;
     Repeat
      TmpO:=ReadByte(XH);
      If TmpO and 128=0Then Begin
       { Lit X octets }
       For i:=0to TmpO and 127do Begin
        LineBuffer[ix]:=ReadByte(XH);
        Inc(ix);
        LineBuffer[ix]:=ReadByte(XH);
        Inc(ix);
        LineBuffer[ix]:=ReadByte(XH);
        Inc(ix);
       End;
      End
       else
      Begin
        { R‚pŠte X octets }
       R:=ReadByte(XH);
       V:=ReadByte(XH);
       B:=ReadByte(XH);
       For i:=0to TmpO and 127do Begin
        LineBuffer[ix]:=R;
        Inc(ix);
        LineBuffer[ix]:=V;
        Inc(ix);
        LineBuffer[ix]:=B;
        Inc(ix);
       End;
      End;
     Until Header.NumXPixels*3=ix;
     XSetAbsRec(Q,RP,Res.BytesPerLine,LineBuffer);
     Inc(RP,Long(Res.BytesPerLine));
     Dec(J);
    Until J+1=0;
   End
    else { Image bitmap non compress‚e cod‚e en 24 bpp }
   Begin
    For J:=0to Res.NumYPixels-1do Begin
     ReadBuf(XH,Res.BytesPerLine,LineBuffer);
     XSetAbsRec(Q,RP,Res.BytesPerLine,LineBuffer);
     Inc(RP,LongInt(Res.BytesPerLine));
     If(fpProgressBar)in(Flags)Then WEUpDate(W,RP,ImageSize);
     If(fpViewScr)in(Flags)Then BestClrLnHorImg(J,Res,LineBuffer);
    End;
   End;
  End;
  If(fpProgressBar)in(Flags)Then WEDone(W);
 End
  Else
 RITGA:=eriOutOfMemory;
End;

Function RIDefaultImage{Handle:Hdl;Const Buffer:Array of Char):Word};
Label Other;
Var
 FS:Long;
 TGA:TGAHeader Absolute Buffer;
Begin
 RIDefaultImage:=diAutoDetect;
 Case Buffer[0]of
  #0:Case Buffer[1]of
   #0:If(TGA.ImageType{Buffer[2]}=2)and(TGA.CMapOrigin=0)and(TGA.CMapLength=0)and
        (TGA.XMin<TGA.NumXPixels)and(TGA.YMin<TGA.NumYPixels)and
        (TGA.ColorMapEntrySize=24)and(TGA.BitsPerPixel=24)Then RIDefaultImage:=diTGA Else
      If(Buffer[2]in[#1,#2])and(Buffer[3]=#0)Then RIDefaultImage:=diIconWindows
      Else Goto Other;
   #1:RIDefaultImage:=diGemImg;
   #9:If(Buffer[2]=#0)and(Buffer[3]=#9)Then RIDefaultImage:=diMBF;
   Else Goto Other;
  End;
  #10:RIDefaultImage:=diPCX;
  '#':If(Buffer[1]='d')and(Buffer[2]='e')Then RIDefaultImage:=diXBM;
  'B':Case Buffer[1]of
   'A':If(Buffer[14]='C')and(Buffer[15]='I')Then RIDefaultImage:=diIconOS2 Else
       If(Buffer[14]='B')and(Buffer[15]='M')Then RIDefaultImage:=diBitMapOS2;
   'G':If(Buffer[2]='X')and(Buffer[3]='1')Then RIDefaultImage:=diBGX;
   'M':{If Buffer[2]=#$1AThen RIDefaultImage:=diBitMapOS2
                        Else} RIDefaultImage:=diBitMapWindows;
   Else Goto Other;
  End;
  'C':Case Buffer[1]of
   'I':RIDefaultImage:=diIconOS2;
   'P':RIDefaultImage:=diPointerOS2;
   Else Goto Other;
  End;
  'F':If(Buffer[1]='O')and(Buffer[2]='R')and(Buffer[3]='M')Then RIDefaultImage:=diLBM
                                                           Else Goto Other;
  'G':Case Buffer[1]of
   'I':If Buffer[2]='F'Then RIDefaultImage:=diGif;
   'P':If(Buffer[2]='X')and(Buffer[3]=#26)Then RIDefaultImage:=diGPX;
   Else Goto Other;
  End;
  'I':Begin
   If(Buffer[1]='C')and(Buffer[2]='O')and(Buffer[3]='N')and
     (Buffer[4]='E')and(Buffer[5]='A')and(Buffer[6]='D')and
     (Buffer[7]='E')and(Buffer[8]='L')Then RIDefaultImage:=diIconAdele
    Else
   Case Buffer[1]of
    'C':RIDefaultImage:=diIconOS2;
    'I':RIDefaultImage:=diTIFF;
    'M':If Buffer[2]='I'Then RIDefaultImage:=diIMI;
    Else Goto Other;
   End;
  End;
  'M':Case Buffer[1]of
   'M':RIDefaultImage:=diTIFF;
   'Z':RIDefaultImage:=diExeWindows;
   Else Goto Other;
  End;
  'P':Case Buffer[1]of
   '5','6':RIDefaultImage:=diPPM;
   'T':RIDefaultImage:=diPointerOS2;
   Else Goto Other;
  End;
  'R':Case Buffer[1]of
   'I':Case Buffer[2]of
    'F':If(Buffer[3]='F')and(Buffer[8]='C')and
          (Buffer[9]='D')and(Buffer[$A]='R')and(Buffer[$B]='5')and
          (Buffer[$C]='v')and(Buffer[$D]='r')and(Buffer[$E]='s')and
          (Buffer[$F]='n')Then RIDefaultImage:=diCorelDraw
        Else
         Goto Other;
    'X':If(Buffer[3]='3')and(FileSize(Handle)>=64000)Then
         RIDefaultImage:=diSCi
        Else
         Goto Other;
    Else Goto Other;
   End;
   'L':If Buffer[2]='2'Then RIDefaultImage:=diRLL;
   Else Goto Other;
  End;
  #$FF:Case Buffer[1]of
   #2,#3:RIDefaultImage:=diResWindows;
   'W':If(Buffer[2]='P')and(Buffer[3]='C')and(Buffer[9]=#$16)Then
        RIDefaultImage:=diWordPerfectGraphics
       Else
        Goto Other;
   Else Goto Other;
  End;
  Else Begin
Other:
   If(Buffer[6]='J')and(Buffer[7]='F')and(Buffer[8]='I')and(Buffer[9]='F')Then RIDefaultImage:=diJPEG Else
   If(Buffer[$41]='P')and(Buffer[$42]='N')and
     (Buffer[$43]='T')and(Buffer[$44]='G')Then RIDefaultImage:=diMacPaint
    Else
   Begin
    FS:=FileSize(Handle);
    If FS=32Then RIDefaultImage:=diXBM Else
    If FS=64000Then RIDefaultImage:=diGFX Else
    If FS=64768Then RIDefaultImage:=diGFX Else
    If FS=128000Then RIDefaultImage:=diGFX Else
    If FS=307200Then RIDefaultImage:=diGFX
{      Else
    Begin
     Ok:=No;
     For J:=0to 7do Begin
      _GetAbsRec(Handle,J shl 6,64,Buffer);
      For I:=0to 63do Ok:=Ok or(Buffer[I]=#0);
     End;
     If(Ok)THen RIDefaultImage:=diMacPaint;
    End;}
   End;
  End;
 End;
End;

Procedure RIInitLoader(Var Q:ImageObjectLoader);Begin
 FillClr(Q,SizeOf(Q));
 Q.Handle:=errHdl;
 Q.MaxY:=$FFFF;
End;

Function RILoaderImage(Var R:ImageObjectLoader;Var Q:XInf):Word;

 Procedure Check;
 Var
  Buffer:Array[0..79]of Char;
 Begin
  If(R.DefaultImage=diAutoDetect)Then Begin
   _GetAbsRec(R.Handle,R.FilePos,SizeOf(Buffer),Buffer);
   R.DefaultImage:=RIDefaultImage(R.Handle,Buffer);
  End;
 End;

Begin
 FillClr(Q,SizeOf(Q));
 Check;
 Case(R.DefaultImage)of
  diGIF:RILoaderImage:=RIReadGIF(R,Q);
  diRLL:RILoaderImage:=RIRLL(R,Q,False);
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Fonction RIReadImage                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: XInf
 Portabilit‚:  Global


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de charger une image d'une format particulier dans
 une ressource d'image de l'ensemble Malte Genesis.


 ParamŠtres d'Entr‚e
 ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

  Handle         Fichier associ‚e ou devant subir la lecture
  DefaultImage   Format par d‚faut devant ˆtre utiliser pour comprendre
                 l'image contenu dans le fichier.
  FilePos        Adresse absolue en octet dans le fichier o— doit commencer
                 la lecture.
  Index          Ic“ne Malte Genesis: Le num‚ro de la page
                 Ic“ne Windows ou OS/2: Nombre de bits par pixel minimum
                 Codage hexad‚cimal: Nombre de bits par pixel
  Ressource      Ressource dans laquelle doit ˆtre stock‚e l'image.
  Flags          Drapeau de processus … effectuer en mˆme temps que le
                 chargement de l'image.


 ParamŠtres de sortie
 ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

  Q              Ressource allant contenir le dessin
}

Function RIReadImage{Handle:Hdl;DefaultImage:Word;Var FilePos:LongInt;
                     BitsPerPixel,Index:Word;Ressource:Byte;
                     Flags:FlagsProcessusImage;Var Q:XInf):Word};
Var
 R:ImageObjectLoader;

 Procedure Check;
 Var
  Buffer:Array[0..79]of Char;
 Begin
  If(DefaultImage=diAutoDetect)Then Begin
   _GetAbsRec(Handle,FilePos,SizeOf(Buffer),Buffer);
   DefaultImage:=RIDefaultImage(Handle,Buffer);
  End;
 End;

Begin
 RIInitLoader(R);
 R.Handle:=Handle;
 R.DefaultImage:=DefaultImage;
 R.FilePos:=FilePos;
 R.BitsPerPixel:=BitsPerPixel;
 R.Index:=Index;
 R.Ressource:=Ressource;
 R.Option:=Flags;
 FillClr(Q,SizeOf(Q));
 Check;
 Case(DefaultImage)of
  diIconWindows:RIReadImage:=RIReadIconWindows(R,Q);
  diIconAdele:Begin
   RIReadImage:=RIReadIconAdele(R,Q);
   FilePos:=R.FilePos;
  End;
  diIconOS2:RIReadImage:=RIReadIconOS2(Handle,FilePos,BitsPerPixel,Ressource,Q);
  diBitMapWindows:RIReadImage:=RIReadBitMapWindows(Handle,FilePos,Ressource,Flags,Q);
  diBitMapOS2:RIReadImage:=RIReadBitMapOS2(Handle,FilePos,Ressource,Flags,Q);
  diPCX:RIReadImage:=RIReadPCX(Handle,FilePos,Ressource,Flags,Q);
  diBGX:RIReadImage:=RIReadBGX(Handle,FilePos,Ressource,Flags,Q);
  diGFX:RIReadImage:=RIReadGFX(Handle,FilePos,Ressource,Flags,Q);
  diGIF:Begin
   R.MaxY:=Index;
   RIReadImage:=RIReadGIF(R,Q);
   FilePos:=R.FilePos;
  End;
  diGemImg:RIReadImage:=RIReadGemImg(Handle,FilePos,Ressource,Flags,Q);
  diTIFF:RIReadImage:=RIReadTIFF(Handle,FilePos,Ressource,Flags,Q);
  diResWindows:RIReadImage:=RIReadRESWindows(Handle,FilePos,Index,Ressource,Flags,Q);
  diExeWindows:RIReadImage:=RIReadExeWindows(Handle,FilePos,Index,Ressource,Flags,Q);
  diCorelDraw:RIReadImage:=RIReadCorelDraw(Handle,FilePos,Ressource,Flags,Q);
  diXBM:RIReadImage:=RIReadXBM(Handle,FilePos,Ressource,Flags,Q);
  diMacPaint:RIReadImage:=RIReadMacPaint(Handle,FilePos,Ressource,Flags,Q);
  diMBF:RIReadImage:=RIMBF(Handle,FilePos,Ressource,Flags,Q);
  diRLL:Begin
   RIReadImage:=RIRLL(R,Q,True);
   FilePos:=R.FilePos;
  End;
  diGPX:RIReadImage:=RIGPX(Handle,FilePos,Ressource,Flags,Q);
  diLBM:RIReadImage:=RILBM(Handle,FilePos,Ressource,Flags,Q);
  diTGA:RIReadImage:=RITGA(Handle,FilePos,Ressource,Flags,Q);
  diPPM:RIReadImage:=RIPPM(Handle,FilePos,Ressource,Flags,Q);
  diSCi:RIReadImage:=RISCi(Handle,FilePos,Ressource,Flags,Q);
  diJPEG:RIReadImage:=RIJPEG(Handle,FilePos,Ressource,Flags,Q);
  diIMI:RIReadImage:=RIIntelligentImage(Handle,FilePos,Ressource,Flags,Q);
  diPNG:RIReadImage:=RIPNG(Handle,FilePos,Ressource,Flags,Q);
  Else RIReadImage:=eriUnknownFormat;
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Fonction RILoadImage                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: XInf
 Portabilit‚:  Global


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet d'effectuer la lecture dans un fichier d'image et
 de le mettre dans une ressource d'image.
}

Function RILoadImage{Const Name:String;DefaultImage,BitsPerPixel,Index:Word;
                     Ressource:Byte;Flags:FlagsProcessusImage;Var Q:XInf):Word};
Label Read;
Var
 Handle:Hdl;
 P:LongInt;
 I:Char;
Begin
 RILoadImage:=eriFileNotFound;
 Q.Output:=$FF;
 If Name=''Then Exit;
 Handle:=FileOpen(Name,fmRead);
 If(Handle<>errHdl)Then Begin
Read:
  P:=0;
  RILoadImage:=RIReadImage(Handle,DefaultImage,P,
	                   BitsPerPixel,Index,Ressource,Flags,Q);
  FileClose(Handle);
 End
  Else
 Begin
  If(Name[1]in['*','?'])and(StrI(2,Name)=':')Then For I:='C'to'Z'do Begin
   Handle:=FileOpen(I+Copy(Name,2,255),fmRead);
   If(Handle<>errHdl)Then Begin
    SysErr:=0;
    Goto Read;
   End;
  End;
 End;
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
END.