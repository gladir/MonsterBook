{ Cette unitÇ est destinÇe Ö offrir des services concernant l'utilisation des
 ressources d'images.
}

{$I DEF.INC}

Unit ResServI;

{ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ}
                                INTERFACE
{ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ}

Uses Systex,Restex,Isatex,Dialex;

Const
 MediaSupport:Boolean=True;
 FolderIcon:^XInf=NIL;

Procedure BarSpcHorDegrad(X1,Y,X2,Attr:Byte);
Procedure BestClrLnHorImg(Y:Word;Const Res:ImageHeaderRes;Const Buffer);
Function  BestMode(Const Res:ImageHeaderRes):Boolean;
Procedure ClrLnHorSprite(X,Y,Len:Word;BitsPerPixel:Byte;Const Buffer);
Procedure ExtensiorPutIcon(Var Q:Extensior;X,Y,L,H,Code:Word;Kr:Byte;Const Path:String);
Function  ExtensiorSearch(Var Q:Extensior;Const Path:String;Attr:Byte):Word;
Procedure Line2Doublon(Const Source;Var Target;Const Palette;BitsPerPixel,
                       NewBitsPerPixel:Byte;NumXPixels:Word);
Procedure MakePaletteDoublon(Const SourcePalette;Var TargetPalette;NumPal:Word);
Procedure RICopy2Clipboard(Var Q:XInf);
Procedure RIDoneLoaderImage(Var R:ImageObjectLoader);
Function  RIIsImage(Var Q:XInf):Boolean;
Procedure RIRes2WnImg(Var Q:XInf;Var Inf:MCanvas);
Function  RIMakeDoublon(Var Q:XInf;Ressource:Byte;Header:Boolean;Var Inf:MCanvas):Word;
Function  RIModel(Var Q:XInf):Word;
Procedure RIPutImage(Var Q:XInf;X,Y,MX,MY:Word);
Procedure RIPutImageJuxtap(Var Q:XInf;X,Y,MX,MY:Word;Mode:WallPaperMode);
Procedure RIPutImageScale(Var Q:XInf;X,Y,SX,SY,Kr:Word);
Procedure RIPutImageLine(Var Q:XInf;X,Y,Decal,MX,L:Word);
Procedure RIPutScale(Var Image:XInf;X1,Y1,X2,Y2:Word);
Procedure RISetPalette(Var Q:XInf);
Procedure RIPreViewImage(Const Name:String;Var W:Window;Y1,X2:Byte;Width,Height:Word);
Procedure RIViewImage(Const Name:String;Var W:Window;Y1,X2:Byte;Height,DecalY:Word);
Procedure RIMediaImage(Index:Word;Var W:Window;Y1,X2:Byte;Height,DecalY:Word);
Procedure ScaleSmall8Bits(Const Source;Var Dest;NumXPixels,NumYPixels:Word;
                          NewNumXPixels,NewNumYPixels:Word);
Procedure _RIPutScale(Var Image:XInf;X1,Y1,X2,Y2:Word;BitsPerPixel:Byte;Option:WorkImage;Var Target:XInf);
Function _RIViewImage(Const Name:String;Index:Word;Var W:Window;
                       Y1,X2:Byte;Height,Width,DecalY:Word):Boolean;

{ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ}
                                IMPLEMENTATION
{ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ}

Uses
 Adele,Memories,Systems,Math,Mouse,Dials,Video,ResLoadI,DialPlus;

Procedure RIPutImage{Var Q:XInf;X,Y,MX,MY:Word};
Label Xit;
Var
 Res:ImageHeaderRes;
 FP:LongInt;
 I,J,PS,Kr,NBS,SizeShadow,SizeImg,SizePal:Word;
 TB1,TB2,TB3:Word;
 Buffer:Array[0..4095]of Byte;
 ShowMouse:Boolean;
 MsX,MsY,MsB:Word;
Begin
 If(Q.Handle=$FFFF)or(Q.Output=$FF)or(Q.Size=0)Then Exit;
 XGetAbsRec(Q,0,SizeOf(Res),Res);
 If(Res.ID<>idResImage)or(Byte(Res.Shadow)>1)Then Exit; { Erreur de donnÇe? }
 FP:=SizeOf(Res);NBS:=Res.NumXPixels shr 3;
 If MY=0Then MY:=Res.NumYPixels;
 If MX=0Then MX:=Res.NumXPixels;
 If(Res.NumYPixels<=MY)Then MY:=Res.NumYPixels;
 If(Res.NumXPixels<=MX)Then MX:=Res.NumXPixels;
 GetMouseSwitch(MsX,MsY,MsB);
 ShowMouse:=(IsShowMouse)and(MsX>=X)and(MsX<=X+MX)and
                            (MsY>=Y)and(MsY<=Y+MY);
 If(ShowMouse)Then __HideMousePtr;
 If(Res.Shadow)and(LongInt(NBS*Res.NumYPixels)<512)Then Begin
  If BitsPerPixel>8Then Kr:=GetAttr(X shr 3,Y div HeightChr)shr 4
                   Else Kr:=GetPixel(X,Y);
  FP:=SizeOf(Res);SizeShadow:=NBS*MY;
  PS:=0;SizeImg:=Res.BytesPerLine*Res.NumYPixels;
  If Res.NumPal>0Then SizePal:=Res.NumPal*3
                 Else SizePal:=0;
  If SizeImg+SizePal+SizeShadow>SizeOf(Buffer)Then Exit;
  XGetAbsRec(Q,FP,SizeImg+SizePal+SizeShadow,Buffer);
  Update4BitsKrShadow(Buffer[SizeImg+SizePal],Buffer,SizeShadow,Kr);
  For J:=0to MY-1do Begin
   ClrLnHorImg(X,Y+J,MX,Res.BitsPerPixel,Buffer[PS]);
   Inc(FP,Res.BytesPerLine);Inc(PS,Res.BytesPerLine);
  End;
 End
  Else
 Begin
  If(Res.BitsPerPixel=8)and(Res.BytesPerLine=Res.NumXPixels)Then Begin
   TB1:=0;TB2:=0;
   While TB2+Res.BytesPerLine<=SizeOf(Buffer)do Begin
    Inc(TB2,Res.BytesPerLine);
    Inc(TB1);
   End;
   J:=0;
   Repeat
    XGetAbsRec(Q,FP,TB2,Buffer);
    Inc(FP,TB2);TB3:=0;
    For I:=0to TB1-1do Begin
     ClrLnHorImg(X,Y+J,MX,Res.BitsPerPixel,Buffer[TB3]);
     Inc(TB3,Res.BytesPerLine);
     Inc(J);
     If(J>=MY)Then Goto Xit;
    End;
   Until False;
  End
   Else
  For J:=0to MY-1do Begin
   XGetAbsRec(Q,FP,Res.BytesPerLine,Buffer);
   ClrLnHorImg(X,Y+J,MX,Res.BitsPerPixel,Buffer);
   Inc(FP,Res.BytesPerLine);
  End;
 End;
Xit:
 If(ShowMouse)Then __ShowMousePtr;
End;

Function RIIsImage(Var Q:XInf):Boolean;Begin
 RIIsImage:=Not((Q.Handle=$FFFF)or(Q.Output=$FF)or(Q.Size=0));
End;

Procedure ClrLnHorSprite(X,Y,Len:Word;BitsPerPixel:Byte;Const Buffer);
Var
 BufByte:Byte Absolute Buffer; { Pointeur ÆByteØ sur le tampon }
 I,J:Word;
Begin
 If Len=0Then Exit;
 Case(BitsPerPixel)of
  4:For I:=0to Pred(Len shr 3)do For J:=0to 3do Begin
   If BufByte shr 4>0Then SetPixel(X,Y,BufByte shr 4);
   Inc(X);
   If BufByte and $F>0Then SetPixel(X,Y,BufByte and$F);
   Inc(X);
   ASM
    INC Word Ptr Buffer
   END;
  End;
 End;
End;

Procedure ClrLnHorGhost(X,Y,Len:Word;BitsPerPixel:Byte;Const Buffer);Far;Begin
 ClrLnHor(X,Y,Len,CurrKrs.Desktop.Tapiserie shr 4);
End;

Procedure RIPutImageJuxtap(Var Q:XInf;X,Y,MX,MY:Word;Mode:WallPaperMode);
Label Blk;
Var
 ClrLnHorImage:Procedure(X,Y,Len:Word;BitsPerPixel:Byte;Const Buffer);
 Res:ImageHeaderRes;            { Information d'entàte sur l'image }
 MaxY,I,I2,I5,I6,J,JP,Base,Len,LenBlock:Word;
 K:Integer;                     { Compteur de boucle }
 Ofs:Word;                      { Ligne courante d'affichage }
 SaveXLimit:Word;               { Copie de sauvegarde de limite de l'image affichÇe }
 XMinReal:Word;                 { Minimum X en pixel }
 Background:Word;               { Couleur de fond }
 FP:LongInt;                    { Position actuel dans le fichier }
 Ok,Valid,Curr:Boolean;         { Drapeau d'Çtat d'affichage d'une ligne }
 LoadPtr:Pointer;               { Adresse de chargement de la ligne d'image}
 Black:Boolean;                 { Aucune image? }
 Work:Record
  StartBuffer:Word;             { Position de dÇpart dans le tampon }
  NP:Word;                      { Nombre de passage vertical }
  XMinimum:Word;                { Minimum X }
  YMinimum:Word;                { Minimum Y}
  XLimit:Word;                  { Limite de l'image affichÇe }
  TB1,TB2:Word;                 { Nombre d'octet par ligne remplissage }
  Buffer:Array[0..2047]of Byte; { Tampon de travail de la ligne d'image }
 End;
Begin
 Black:=Not RIIsImage(Q);
 FillClr(Work,SizeOf(Work));
 If(wpSprite)in(Mode)Then ClrLnHorImage:=ClrLnHorSprite
                     Else ClrLnHorImage:=ClrLnHorImg;
 Background:=CurrKrs.Desktop.Tapiserie shr 4;
 ASM
   {Valid:=Hole<>NIL}
  LES CX,Hole
  MOV AX,ES
  OR  CX,AX
  JCXZ @1
  MOV AL,True
  AND AL,HoleMode
@1:
  MOV Valid,AL
 END;
 If(Black)Then Begin
Blk:
  ClrLnHorImage:=ClrLnHorGhost;
  Res.BitsPerPixel:=BitsPerPixel;
  Res.NumXPixels:=MX;
  Res.NumYPixels:=MY;
  Res.BytesPerLine:=MX;
  Case(BitsPerPixel)of
   1:Res.BytesPerLine:=Res.BytesPerLine shr 3;
   4:ASM SHR Res.BytesPerLine,1;END;
   9..16:ASM SHL Res.BytesPerLine,1;END;
  End;
 End
  Else
 XGetAbsRec(Q,0,SizeOf(Res),Res);
 If((Res.ID<>idResImage)or(Byte(Res.Shadow)>1))and(Not(Black))Then Begin
  Black:=True;
  Goto Blk;
 End;
 FP:=SizeOf(Res);
 MaxY:=MY;
 Case(Res.BitsPerPixel)of
  1: LenBlock:=1;
  4: LenBlock:=4;
  16:LenBlock:=16;
  Else LenBlock:=8;
 End;
 If MX=0Then MX:=Res.NumXPixels Else
 If(Res.NumXPixels<MX)Then Begin
  If(wpCenter)in(Mode)Then Work.XMinimum:=(MX-Res.NumXPixels)shr 4;
 End;
 If MY=0Then MY:=Res.NumYPixels Else
 If(Res.NumYPixels<MY)Then Begin
  Work.NP:=(MY div Res.NumYPixels);
  MaxY:=Res.NumYPixels;
  If(wpCenter)in(Mode)Then Work.YMinimum:=(MY-Res.NumYPixels)shr 1;
 End;
 XMinReal:=(Work.XMinimum shl 3)+X;
 If Res.BytesPerLine<=SizeOf(Work.Buffer)Then Begin
  Work.StartBuffer:=Work.XMinimum*LenBlock;
  LoadPtr:=@Work.Buffer[Work.StartBuffer];
  If(wpJuxtap)in(Mode)Then Begin
   Work.TB2:=Res.BytesPerLine;
   Work.TB1:=1;
  End
   Else
  While Work.StartBuffer+Work.TB2+Res.BytesPerLine<=SizeOf(Work.Buffer)do Begin
   Inc(Work.TB2,Res.BytesPerLine);
   Inc(Work.TB1);
  End;
  If Work.YMinimum>0Then Begin
   For J:=0to Work.YMinimum-1do Begin
    Ofs:=Y+J;I2:=X;
    If(Valid)Then Begin
     Base:=(Ofs div HeightChr)*NmXTxts+(I2 shr 3);
     Len:=0;Ok:=True;
     For I:=0to(MX shr 3)-1do Begin
      If(Valid)Then Begin
       Curr:=Hole^[I+Base];
      End
       Else
      Curr:=False;
      If(Ok<>Curr)and(Len>0)Then Begin
       ClrLnHor(I2,Ofs,Len,Background);
       Inc(I2,Len);
       Len:=0;
      End;
      Ok:=Curr;
      If Not(Ok)Then Inc(Len,8)
                Else Inc(I2,8);
     End;
    End
     Else
    Len:=MX;
    If Len>0Then ClrLnHor(I2,Ofs,Len,Background)
   End;
  End;
  J:=0;
  Repeat
   If Not(Black)Then Begin
    XGetAbsRec(Q,FP,Work.TB2,LoadPtr^);
    Inc(FP,Work.TB2);
   End;
   If(Res.NumXPixels<=MX)Then Begin
    SaveXLimit:=Res.NumXPixels;
    Ofs:=Res.BytesPerLine;
    If(wpJuxtap)in(Mode)Then Begin
     For I:=1to(MX div Res.NumXPixels)do Begin
      If Ofs+Res.BytesPerLine>SizeOf(Work.Buffer)Then Break;
      MoveLeft(Work.Buffer,Work.Buffer[Ofs],Res.BytesPerLine);
      Inc(Ofs,Res.BytesPerLine);
      Inc(SaveXLimit,Res.NumXPixels);
     End;
    End;
   End;
   I6:=0;
   For K:=0to Work.TB1-1do Begin
    Ofs:=Y+J+Work.YMinimum;
    For JP:=0to(Work.NP)do Begin
     I5:=I6;
     If(Ofs>MY+Y)Then Break
      Else
     Begin
      I2:=X;
      If((Not((wpJuxtap)in(Mode)))and(JP>0))Then Work.XLimit:=0
                                            Else Work.XLimit:=SaveXLimit+XMinReal;
      If(Valid)Then Begin
       Base:=(Ofs div HeightChr)*NmXTxts+(I2 shr 3);
       Len:=0;Ok:=True;
       For I:=0to(MX shr 3)-1do Begin
        If(Valid)Then Begin
         Curr:=Hole^[I+Base];
        End
         Else
        Curr:=False;
        If(Ok<>Curr)and(Len>0)Then Begin
         If(I2>=Work.XLimit)or(I2+Len<=XMinReal)Then ClrLnHor(I2,Ofs,Len,Background)
          Else
         Begin
          ClrLnHorImage(I2,Ofs,Len,Res.BitsPerPixel,Work.Buffer[I5]);
          If(I2<XMinReal)Then ClrLnHor(I2,Ofs,XMinReal-I2,Background);
          If(I2+Len>Work.XLimit)Then ClrLnHor(Work.XLimit,Ofs,(I2+Len)-Work.XLimit,Background);
         End;
         Inc(I2,Len);
         Case(Res.BitsPerPixel)of
          1:Inc(I5,Len shr 3);
          4:Inc(I5,Len shr 1);
          9..16:Inc(I5,Len shl 1);
          Else Inc(I5,Len);
         End;
         Len:=0;
        End;
        Ok:=Curr;
        If Not(Ok)Then Begin
         Inc(Len,8)
        End
         Else
        Begin
         Inc(I5,LenBlock);
         Inc(I2,8);
        End;
       End;
      End
       Else
      Len:=MX;
      If Len>0Then Begin
       If(I2>=Work.XLimit)Then ClrLnHor(I2,Ofs,Len,Background)
        Else
       Begin
        ClrLnHorImage(I2,Ofs,Len,Res.BitsPerPixel,Work.Buffer[I5]);
        If(I2<XMinReal)Then ClrLnHor(I2,Ofs,XMinReal-I2,Background);
        If(I2+Len>Work.XLimit)Then ClrLnHor(Work.XLimit,Ofs,(I2+Len)-Work.XLimit,Background);
       End;
      End;
      Inc(I2,Len);
      Inc(Ofs,Res.NumYPixels);
     End;
    End;
    Inc(J);
    If(J>=MaxY)Then Exit;
    Inc(I6,Res.BytesPerLine);
   End;
  Until False;
 End;
End;

Function RIModel{Var Q:XInf):Word};
Var
 Res:ImageHeaderRes;
Begin
 XGetAbsRec(Q,0,SizeOf(Res),Res);
 RIModel:=Res.Original;
End;

Procedure Move1BitsTo8BitsOne(Const Source;Var Target;Length:Word;F,T:Byte);
Var
 I,B:Word;
Begin
 FillChr(Target,Length shl 3,F);
 B:=0;
 For I:=0to Length-1do Begin
  If TByte(Source)[I]and$80=$80Then TByte(Target)[B]:=T;
  If TByte(Source)[I]and$40=$40Then TByte(Target)[B+1]:=T;
  If TByte(Source)[I]and$20=$20Then TByte(Target)[B+2]:=T;
  If TByte(Source)[I]and$10=$10Then TByte(Target)[B+3]:=T;
  If TByte(Source)[I]and$08=$08Then TByte(Target)[B+4]:=T;
  If TByte(Source)[I]and$04=$04Then TByte(Target)[B+5]:=T;
  If TByte(Source)[I]and$02=$02Then TByte(Target)[B+6]:=T;
  If TByte(Source)[I]and$01=$01Then TByte(Target)[B+7]:=T;
  Inc(B,8);
 End;
End;

Procedure MakePaletteDoublon(Const SourcePalette;Var TargetPalette;NumPal:Word);
Var
 SourcePaletteRGB:Palette256RGB Absolute SourcePalette;
 TargetBytePalette:TByte Absolute TargetPalette;
 TargetWordPalette:TWord Absolute TargetPalette;
 I:Integer;
Begin
 Case(BitsPerPixel)of
  9..16:For I:=0to NumPal-1do Begin
   TargetWordPalette[I]:=RGB2Color(SourcePaletteRGB[I].R,
                                   SourcePaletteRGB[I].G,
                                   SourcePaletteRGB[I].B);
  End;
 End;
End;

Procedure Line2Doublon(Const Source;Var Target;Const Palette;
                       BitsPerPixel,NewBitsPerPixel:Byte;NumXPixels:Word);
Label _4bits,_8bits,_16bits,_None;
Var
 WordTarget:TWord Absolute Target;
 ByteTarget:TByte Absolute Target;
 ByteSource:TByte ABsolute Source;
 BytePalette:TByte Absolute Palette;
 WordPalette:TWord Absolute Palette;
 T:RGB;
 B,J:Word;
Begin
 {$IFDEF FLAT386}
  Case(BitsPerPixel)of
   4:Goto _4bits;
   8:Goto _8bits;
   9..16:Goto _16bits;
   Else Exit;
  End;
 {$ELSE}
  ASM
   MOV BL,BitsPerPixel
   AND BX,001Fh
   SHL BX,1
   JMP @Label.Word[BX]
 @Label:
   DW Offset _None   { 0 - 1 }
   DW Offset _None   { 1 - 2 }
   DW Offset _None   { 2 - 4 }
   DW Offset _None   { 3 - 8 }
   DW Offset _4bits  { 4 - 16 }
   DW Offset _None   { 5 - 32 }
   DW Offset _None   { 6 - 64 }
   DW Offset _None   { 7 - 128 }
   DW Offset _8bits  { 8 - 256 }
   DW Offset _16bits { 9 - 512 }
   DW Offset _16bits { 10 - 1024 }
   DW Offset _16bits { 11 - 2048 }
   DW Offset _16bits { 12 - 4096 }
   DW Offset _16bits { 13 - 8192 }
   DW Offset _16bits { 14 - 16384 }
   DW Offset _16bits { 15 - 32768 }
   DW Offset _16bits { 16 - 65536 }
   DW Offset _None   { 17 - 132072 }
   DW Offset _None   { 18 - 264144 }
   DW Offset _None   { 19 - ... }
   DW Offset _None   { 20 - ... }
   DW Offset _None   { 21 - ... }
   DW Offset _None   { 22 - ... }
   DW Offset _None   { 23 - ... }
   DW Offset _None   { 24 - ... }
   DW Offset _None   { 25 - ... }
   DW Offset _None   { 26 - ... }
   DW Offset _None   { 27 - ... }
   DW Offset _None   { 28 - ... }
   DW Offset _None   { 29 - ... }
   DW Offset _None   { 30 - ... }
   DW Offset _None   { 31 - ... }
  END;
 {$ENDIF}
_4bits:Case(NewBitsPerPixel)of
  24:Begin { Transfert en 4 bits mais Çtaler sur 8 bits...}
   ASM
    {B:=0;
    For J:=0to NumXPixels-1do Begin
     ByteTarget[J]:=RGB2Color(ByteSource[B+2],ByteSource[B+1],ByteSource[B]);
     Inc(B,3);
    End;}
    CLD
    PUSH DS
     LDS SI,Source
     LES DI,Target
     MOV CX,NumXPixels
@0:  XOR BX,BX
     LODSW
     MOV DH,AL
     AND AL,080h
     OR  AL,AL
     JZ  @1
     MOV BL,01h
  @1:AND DH,040h
     OR  DH,DH
     JZ  @2
     OR  BL,08h
  @2:MOV AL,AH
     AND AL,080h
     OR  AL,AL
     JZ  @3
     OR  BL,02h
  @3:AND AH,040h
     OR  AH,AH
     JZ  @4
     OR  BL,10h
  @4:LODSB
     MOV AH,AL
     AND AL,080h
     OR  AL,AL
     JZ  @5
     OR  BL,04h
  @5:AND AH,040h
     OR  AH,AH
     JZ  @6
     OR  BL,20h
  @6:XCHG AX,BX
     STOSB
     LOOP @0
    POP DS
   END;
  End;
  Else ASM
   {For J:=0to Res.BytesPerLine-1do Begin
     ByteTarget[J]:=(BytePalette[ByteSource[J]shr 4]shl 4)+BytePalette[ByteSource[J]and$F];
    End;}
   {$IFDEF FLAT386}
    LEA ESI,Palette
    MOV ECX,16
    SUB ESP,ECX
    SHR ECX,1
    MOV EDI,ESP
    REP MOVSW
    LEA ESI,Source
    MOV CX,NumXPixels
    SHR CX,1
    LEA EDI,Target
 @1:LODSB
    MOV EBX,ESP
    MOV DL,AL
    AND EAX,0Fh
    ADD EBX,EAX
    MOV AL,[EBX]
    MOV EBX,ESP
    AND DX,0F0h
    SHR DX,4
    ADD BX,DX
    MOV AH,[EBX]
    SHL AH,4
    OR  AL,AH
    STOSB
    LOOP @1
    ADD SP,16
   {$ELSE}
    PUSH DS
     LDS SI,Palette
     MOV CX,16
     SUB SP,CX
     SHR CX,1
     MOV AX,SS
     MOV ES,AX
     MOV DI,SP
     REP MOVSW
     LDS SI,Source
     MOV CX,NumXPixels
     SHR CX,1
     LES DI,Target
  @1:LODSB
     MOV BX,SP
     MOV DL,AL
     AND AX,0Fh
     ADD BX,AX
     MOV AL,SS:[BX]
     MOV BX,SP
     AND DX,0F0h
     SHR DX,1
     SHR DX,1
     SHR DX,1
     SHR DX,1
     ADD BX,DX
     MOV AH,SS:[BX]
     {$IFOPT G+}
      SHL AH,4
     {$ELSE}
      SHL AH,1
      SHL AH,1
      SHL AH,1
      SHL AH,1
     {$ENDIF}
     OR  AL,AH
     STOSB
     DEC CX
     JNZ @1
     ADD SP,16
    POP DS
   {$ENDIF}
  END;
 End;
 Goto _None;
_8bits:Case(NewBitsPerPixel)of
  4:ASM
   {For I:=0to(NumXPixels shr 1)-1do Begin
    ByteTarget[(I shl 1)+1]:=BytePalette[ByteSource[I]shr 4];
    ByteTarget[(I shl 1)]:=BytePalette[ByteSource[I]and$F];
   End;}
   {$IFDEF FLAT386}
    LEA ESI,Palette
    MOV ECX,16
    SUB ESP,ECX
    SHR ECX,1
    MOV EDI,ESP
    REP MOVSW
    LEA ESI,Source
    MOV CX,NumXPixels
    SHR CX,1
    LEA EDI,Target
 @1:LODSB
    MOV EBX,ESP
    MOV DL,AL
    AND EAX,0F0h
    SHR EAX,4
    ADD EBX,EAX
    MOV AL,[EBX]
    STOSB
    MOV EBX,ESP
    AND EDX,0Fh
    ADD EBX,EDX
    MOV AL,[EBX]
    STOSB
    LOOP @1
    ADD SP,16
   {$ELSE}
    PUSH DS
     LDS SI,Palette
     MOV CX,16
     SUB SP,CX
     SHR CX,1
     MOV AX,SS
     MOV ES,AX
     MOV DI,SP
     REP MOVSW
     LDS SI,Source
     MOV CX,NumXPixels
     SHR CX,1
     LES DI,Target
  @1:LODSB
     MOV BX,SP
     MOV DL,AL
     AND AX,0F0h
     {$IFOPT G+}
      SHR AX,4
     {$ELSE}
      SHR AX,1
      SHR AX,1
      SHR AX,1
      SHR AX,1
     {$ENDIF}
     ADD BX,AX
     MOV AL,SS:[BX]
     STOSB
     MOV BX,SP
     AND DX,0Fh
     ADD BX,DX
     MOV AL,SS:[BX]
     STOSB
     DEC CX
     JNZ @1
     ADD SP,16
    POP DS
   {$ENDIF}
  END;
  5..8:ASM
    {For I:=0to NumXPixels-1do ByteTarget[I]:=BytePalette[ByteSource[I]];}
   {$IFDEF FLAT386}
   {$ELSE}
    CLD
    PUSH DS
     LDS SI,Palette
     MOV CX,100h
     SUB SP,CX
     SHR CX,1
     MOV AX,SS
     MOV ES,AX
     MOV DI,SP
     REP MOVSW
     LDS SI,Source
     MOV CX,NumXPixels
     LES DI,Target
     MOV AH,0
  @1:LODSB
     MOV BX,SP
     ADD BX,AX
     MOV AL,SS:[BX]
     STOSB
     DEC CX
     JNZ @1
     ADD SP,100h
    POP DS
   {$ENDIF}
  END;
  15,16:Begin
   B:=0;
   For J:=0to NumXPixels-1do Begin
    _Color2RGB((ByteSource[B+1]shl 8)+ByteSource[B],NewBitsPerPixel,T);
    ByteTarget[J]:=RGB2Color(T.R,T.G,T.B);
    Inc(B,2);
   End;
  End;
  24:Begin
   {$IFDEF NoAsm}
    B:=0;
    For J:=0to NumXPixels-1do Begin
     ByteTarget[J]:=RGB2Color(ByteSource[B+2],ByteSource[B+1],ByteSource[B]);
     {64+(TBuf^[B]shr 6)+((TBuf^[B+1]shr 5)shl 2)+((TBuf^[B+2]shr 1)and$60);}
     Inc(B,3);
    End;
   {$ELSE}
    ASM
     CLD
     PUSH DS
      MOV CX,NumXPixels
      LDS SI,Source
      LES DI,Target
   @0:LODSW
      ROL AL,1
      ROL AL,1
      AND AL,3
      {$IFOPT G+}
       SHR AH,3
      {$ELSE}
       SHR AH,1
       SHR AH,1
       SHR AH,1
      {$ENDIF}
      AND AH,01Ch
      ADD AL,AH
      XCHG AX,BX
      LODSB
      SHR AL,1
      AND AL,060h
      ADD AL,BL
      ADD AL,64
      STOSB
      LOOP @0
     POP DS
    END;
   {$ENDIF}
  End;
 End;
 Goto _None;
_16bits:
 Case(NewBitsPerPixel)of
  4:ASM
   {For I:=0to(NumXPixels shr 1)-1do Begin
    WordTarget[(I shl 1)+1]:=WordPalette[ByteSource[I]shr 4];
    WordTarget[(I shl 1)]:=WordPalette[ByteSource[I]and$F];
   End;}
   {$IFDEF FLAT386}
    LEA ESI,Palette
    MOV ECX,32
    SUB ESP,ECX
    SHR ECX,1
    MOV EDI,ESP
    REP MOVSW
    LEA ESI,Source
    MOV CX,NumXPixels
    SHR CX,1
    LEA EDI,Target
 @1:LODSB
    MOV EBX,ESP
    MOV DL,AL
    AND EAX,0F0h
    SHR AX,3
    ADD EBX,EAX
    MOV AX,[EBX]
    STOSW
    MOV BX,SP
    AND DX,0Fh
    SHL DX,1
    ADD EBX,EDX
    MOV AX,[EBX]
    STOSW
    LOOP @1
    ADD SP,32
   {$ELSE}
    PUSH DS
     LDS SI,Palette
     MOV CX,32
     SUB SP,CX
     SHR CX,1
     MOV AX,SS
     MOV ES,AX
     MOV DI,SP
     REP MOVSW
     LDS SI,Source
     MOV CX,NumXPixels
     SHR CX,1
     LES DI,Target
  @1:LODSB
     MOV BX,SP
     MOV DL,AL
     AND AX,0F0h
     {$IFOPT G+}
      SHR AX,3
     {$ELSE}
      SHR AX,1
      SHR AX,1
      SHR AX,1
     {$ENDIF}
     ADD BX,AX
     MOV AX,SS:[BX]
     STOSW
     MOV BX,SP
     AND DX,0Fh
     SHL DX,1
     ADD BX,DX
     MOV AX,SS:[BX]
     STOSW
     DEC CX
     JNZ @1
     ADD SP,32
    POP DS
   {$ENDIF}
  END;
  5..8:ASM
    {For I:=0to NumXPixels-1do WordTarget[I]:=WordPalette[ByteSource[I]];}
   {$IFDEF FLAT386}
   {$ELSE}
    CLD
    PUSH DS
     LDS SI,Palette
     SUB SP,200h
     MOV CX,100h
     MOV AX,SS
     MOV ES,AX
     MOV DI,SP
     REP MOVSW
     LDS SI,Source
     MOV CX,NumXPixels
     LES DI,Target
  @1:LODSB
     MOV AH,0
     MOV BX,SP
     SHL AX,1
     ADD BX,AX
     MOV AX,SS:[BX]
     STOSW
     DEC CX
     JNZ @1
     ADD SP,200h
    POP DS
   {$ENDIF}
  END;
  15:If BitsPerPixel=16Then ASM { 16 Ö 15 }
   CLD
   LES DI,Target
   MOV CX,NumXPixels
   JCXZ @End
   PUSH DS
    LDS SI,Source
@lp16to15:
    LODSW
    MOV BX,AX
    AND AX,1111111111000000b
    AND BX,11111b
    SHR AX,1
    OR  AX,BX
    STOSW
    LOOP @lp16to15
   POP DS
@End:
  END;
  16:If BitsPerPixel=15Then ASM { 15 Ö 16 }
   CLD
   LES DI,Target
   MOV CX,NumXPixels
   JCXZ @End
   PUSH DS
    LDS SI,Source
@lp15to16:
    LODSW
    MOV BX,AX
    AND AX,111111111100000b
    AND BX,11111b
    ADD AX,AX
    OR  AX,BX
    STOSW
    DEC CX
    JNZ @lp15to16
   POP DS
@End:
  END;
  24..32:ASM
    { B:=0;
   For I:=0to NumXPixels-1do Begin
    WordTarget[I]:=RGB2Color(ByteSource[B+2],ByteSource[B+1],ByteSource[B]);
    Inc(B,3);
   End;}
   MOV  AL,BitsPerPixel
   AND  AL,1
   MOV  DH,AL
   CLD
   PUSH DS
    MOV CX,NumXPixels
    LES DI,Target
    LDS SI,Source
 @1:LODSW
    SHR AL,1
    SHR AL,1
    OR  DH,DH
    JNZ @15bits
    SHR AL,1
@15bits:
    MOV DL,AL
    MOV AL,AH
    AND AX,0F8h
    {$IFOPT G+}
     SHL AX,3
    {$ELSE}
     SHL AX,1
     SHL AX,1
     SHL AX,1
    {$ENDIF}
    XCHG AX,BX
    LODSB
    MOV AH,AL
    AND AX,0F800h
    OR  AX,BX
    OR  AL,DL
    OR  DH,DH
    JZ  @16Bits
    SHR AX,1
@16bits:
    STOSW
    LOOP @1
   POP DS
  END;
 End;
_None:
End;

{ Remarque
  ÕÕÕÕÕÕÕÕ

   ˛ Cette fonction rÇclame des lignes de taille paires  et ne supporte pas
     les lignes de taille impaires! La raison est causÇe par les transferts
     effectuÇe Ö la mÇmoire ressource  ÆXMSØ ne supportant pas ce probläme.
     Cependant,  l'unitÇ  ÆSYSTEMSØ   avec  les   derniäres  modifications,
     effectue un manipulation fictive  d'une taille impaire, rÇduisant donc
     ce genre de conflit...
}

Function RIMakeDoublon{Var Q:XInf;Ressource:Byte;Header:Bool;Var Inf:MCanvas):Word};
Var
 Res:ImageHeaderRes;
 B,I,J,ND,NM:Word;
 Buffer:Array[0..2559]of Byte;
 PBuffer:Array[0..2047]of Byte;
 NewPal:Array[0..255]of Word Absolute PBuffer;
 Pal:Palette256RGB;
 PPBuffer,TBuf:^TByte;
 SH,FP,RP,SizeImg:LongInt;
 PWord:^TWord;
Begin
 RIMakeDoublon:=eriNone;
 XGetAbsRec(Q,0,SizeOf(Res),Res);
 If(Header)Then SH:=SizeOf(Res)
           Else SH:=0;
 If(Res.ID<>idResImage)or(Byte(Res.Shadow)>1)Then Begin
  RIMakeDoublon:=eriInvalidHeader; { Erreur de donnÇe? }
  Exit;
 End;
 TBuf:=@Buffer;
 PPBuffer:=@PBuffer;
 Inf.Miroir.Output:=$FF;
 Case(BitsPerPixel)of
   { êcran en 2 couleurs }
  1:Begin
   If XAllocMem(Ressource,SH+Mul2Word(Res.BytesPerLine,Res.NumYPixels),Inf.Miroir)Then Begin
    FP:=SH;RP:=SizeOf(Res);
    For I:=0to Res.NumYPixels-1do Begin
     XGetAbsRec(Q,RP,Res.BytesPerLine,PBuffer);
     XSetAbsRec(Inf.Miroir,FP,Res.BytesPerLine,PBuffer);
     Inc(FP,LongInt(Res.BytesPerLine));Inc(RP,LongInt(Res.BytesPerLine));
    End;
   End
    Else
   RIMakeDoublon:=eriOutOfMemory;
  End;
   { êcran en 16 couleurs }
  4:Case(Res.BitsPerPixel)of
   4:Begin
    If XAllocMem(Ressource,SH+Mul2Word(Res.BytesPerLine,Res.NumYPixels),Inf.Miroir)Then Begin
     FP:=SH;RP:=SizeOf(Res);
     If Res.NumPal>0Then Begin
      XGetAbsRec(Q,SizeOf(Res)+Mul2Word(Res.BytesPerLine,Res.NumYPixels),Res.NumPal*3,Pal);
      For I:=0to 15do Inf.CT[I]:=RGB2Color(Pal[I].R,Pal[I].G,Pal[I].B);
     End;
     For I:=0to Res.NumYPixels-1do Begin
      XGetAbsRec(Q,RP,Res.BytesPerLine,PBuffer);
      If Res.NumPal=0Then XSetAbsRec(Inf.Miroir,FP,Res.BytesPerLine,PBuffer)
       Else
      Begin
       Line2Doublon(PBuffer,Buffer,Inf.CT,BitsPerPixel,4,Res.NumXPixels);
       XSetAbsRec(Inf.Miroir,FP,Res.BytesPerLine,TBuf^);
      End;
      Inc(FP,LongInt(Res.BytesPerLine));Inc(RP,LongInt(Res.BytesPerLine));
     End;
    End
     Else
    RIMakeDoublon:=eriOutOfMemory;
   End;
   8:Begin
    If XAllocMem(Ressource,SH+Mul2Word(Res.BytesPerLine,Res.NumYPixels),Inf.Miroir)Then Begin
     FP:=SH;RP:=SizeOf(Res);
     If Res.NumPal>0Then Begin
      XGetAbsRec(Q,SizeOf(Res)+Mul2Word(Res.BytesPerLine,Res.NumYPixels),Res.NumPal*3,Pal);
      For I:=0to 255do Inf.CT[I]:=RGB2Color(Pal[I].R,Pal[I].G,Pal[I].B);
     End;
     For I:=0to Res.NumYPixels-1do Begin
      XGetAbsRec(Q,RP,Res.BytesPerLine,PBuffer);
      If Res.NumPal=0Then XSetAbsRec(Inf.Miroir,FP,Res.BytesPerLine,PBuffer)
       Else
      Begin
       ASM
         {For I:=0to Res.NumXPixels-1do TBuf^[I]:=Inf.CT[PBuffer[I]];}
        {$IFDEF FLAT386}
        {$ELSE}
         CLD
         PUSH DS
          LDS SI,Inf
          ADD SI,Offset MCanvas.CT
          MOV CX,100h
          SUB SP,CX
          SHR CX,1
          MOV AX,SS
          MOV ES,AX
          MOV DI,SP
          REP MOVSW
          LDS SI,PPBuffer
          MOV CX,Res.NumXPixels
          LES DI,TBuf
          MOV AH,0
       @1:LODSB
          MOV BX,SP
          ADD BX,AX
          MOV AL,SS:[BX]
          STOSB
          DEC CX
          JNZ @1
          ADD SP,100h
         POP DS
        {$ENDIF}
       END;
       XSetAbsRec(Inf.Miroir,FP,Res.BytesPerLine,TBuf^);
      End;
      Inc(FP,LongInt(Res.BytesPerLine));
      Inc(RP,LongInt(Res.BytesPerLine));
     End;
    End
     Else
    RIMakeDoublon:=eriOutOfMemory;
   End;
   17..24:Begin
    If XAllocMem(Ressource,SH+Mul2Word(Res.NumXPixels,Res.NumYPixels),Inf.Miroir)Then Begin
     FP:=SH;RP:=SizeOf(Res);
     If(SizeOf(Buffer)<Res.BytesPerLine)Then Begin
      TBuf:=MemAlloc(Res.BytesPerLine);
      If(TBuf=NIL)Then Exit;
     End;
     For I:=0to Res.NumYPixels-1do Begin
      XGetAbsRec(Q,RP,Res.BytesPerLine,TBuf^);
      Line2Doublon(TBuf^,PBuffer,TBuf^,BitsPerPixel,24,Res.NumXPixels);
      XSetAbsRec(Inf.Miroir,FP,Res.NumXPixels,PBuffer);
      Inc(FP,LongInt(Res.NumXPixels));
      Inc(RP,LongInt(Res.BytesPerLine));
     End;
     If(SizeOf(Buffer)<Res.BytesPerLine)Then FreeMemory(TBuf,Res.BytesPerLine);
     Res.BitsPerPixel:=8;Res.BytesPerLine:=Res.NumXPixels;
    End;
   End;
   Else Begin
    If XAllocMem(Ressource,SH+Mul2Word(Res.BytesPerLine,Res.NumYPixels),Inf.Miroir)Then Begin
     FP:=SH;RP:=SizeOf(Res);
     For I:=0to Res.NumYPixels-1do Begin
      XGetAbsRec(Q,RP,Res.BytesPerLine,PBuffer);
      XSetAbsRec(Inf.Miroir,FP,Res.BytesPerLine,PBuffer);
      Inc(FP,LongInt(Res.BytesPerLine));Inc(RP,LongInt(Res.BytesPerLine));
     End;
    End
     Else
    RIMakeDoublon:=eriOutOfMemory;
   End;
  End;
   { êcran en 256 couleurs }
  8:Case(Res.BitsPerPixel)of
   1:Begin
    If XAllocMem(Ressource,SH+Mul2Word(Res.NumXPixels,Res.NumYPixels),Inf.Miroir)Then Begin
     FP:=SH;RP:=SizeOf(Res);
     For I:=0to Res.NumYPixels-1do Begin
      XGetAbsRec(Q,RP,Res.BytesPerLine,PBuffer);
      Move1BitsTo8BitsOne(PBuffer,Buffer,Res.BytesPerLine,15,0);
      XSetAbsRec(Inf.Miroir,FP,Res.NumXPixels,Buffer);
      Inc(FP,LongInt(Res.NumXPixels));Inc(RP,LongInt(Res.BytesPerLine));
     End;
     Res.BitsPerPixel:=8;Res.BytesPerLine:=Res.NumXPixels;
    End
     Else
    RIMakeDoublon:=eriOutOfMemory;
   End;
   4:Begin
    If XAllocMem(Ressource,SH+Mul2Word(Res.NumXPixels,Res.NumYPixels),Inf.Miroir)Then Begin
     FP:=SH;RP:=SizeOf(Res);
     For I:=0to Res.NumYPixels-1do Begin
      XGetAbsRec(Q,RP,Res.BytesPerLine,PBuffer);
      If Res.NumPal=0Then Begin
       Conv4To8BitsKr(PBuffer,Buffer,Res.NumXPixels shr 1);
      End
       Else
      Line2Doublon(PBuffer,Buffer,Inf.CT,BitsPerPixel,Res.BitsPerPixel,Res.NumXPixels);
      XSetAbsRec(Inf.Miroir,FP,Res.NumXPixels,Buffer);
      Inc(FP,LongInt(Res.NumXPixels));
      Inc(RP,LongInt(Res.BytesPerLine));
     End;
     Res.BitsPerPixel:=8;Res.BytesPerLine:=Res.NumXPixels;
    End
     Else
    RIMakeDoublon:=eriOutOfMemory;
   End;
   5..8:Begin
    SizeImg:=Mul2Word(Res.NumXPixels,Res.NumYPixels);
    If XAllocMem(Ressource,SH+SizeImg,Inf.Miroir)Then Begin
     FP:=SH;RP:=SizeOf(Res);
     If(Res.BytesPerLine<>Res.NumXPixels)Then For I:=0to Res.NumYPixels-1do Begin
      XGetAbsRec(Q,RP,Res.BytesPerLine,PBuffer);
      If Res.NumPal=0Then XSetAbsRec(Inf.Miroir,FP,Res.NumXPixels,PBuffer)
       Else
      Begin
       Line2Doublon(PBuffer,TBuf^,Inf.CT,BitsPerPixel,Res.BitsPerPixel,Res.NumXPixels);
       XSetAbsRec(Inf.Miroir,FP,Res.NumXPixels,TBuf^);
      End;
      Inc(FP,LongInt(Res.NumXPixels));
      Inc(RP,LongInt(Res.BytesPerLine));
     End
      Else
     Begin
       {êdition en copie par bloc pour accÇlÇrer le traåtement...}
      ND:=LongInt(SizeImg)shr 11{div SizeOf(PBuffer)};
      NM:=SizeImg and 2047{mod SizeOf(PBuffer)};
      If ND>0Then For I:=0to ND-1do Begin
       XGetAbsRec(Q,RP,SizeOf(PBuffer),PBuffer);
       If Res.NumPal=0Then XSetAbsRec(Inf.Miroir,FP,SizeOf(PBuffer),PBuffer)
        Else
       Begin
        Line2Doublon(PBuffer,TBuf^,Inf.CT,BitsPerPixel,Res.BitsPerPixel,SizeOf(PBuffer));
        XSetAbsRec(Inf.Miroir,FP,SizeOf(PBuffer),TBuf^);
       End;
       Inc(FP,LongInt(SizeOf(PBuffer)));
       Inc(RP,LongInt(SizeOf(PBuffer)));
      End;
      If NM>0Then Begin
       XGetAbsRec(Q,RP,NM,PBuffer);
       If Res.NumPal=0Then XSetAbsRec(Inf.Miroir,FP,SizeOf(PBuffer),PBuffer)
        Else
       Begin
        Line2Doublon(PBuffer,TBuf^,Inf.CT,BitsPerPixel,Res.BitsPerPixel,NM);
        XSetAbsRec(Inf.Miroir,FP,NM,TBuf^);
       End;
      End;
     End;
     Res.BytesPerLine:=Res.NumXPixels;
    End
     Else
    RIMakeDoublon:=eriOutOfMemory;
   End;
   15..24:Begin
    If XAllocMem(Ressource,SH+Mul2Word(Res.NumXPixels,Res.NumYPixels),Inf.Miroir)Then Begin
     FP:=SH;RP:=SizeOf(Res);
     If(SizeOf(Buffer)<Res.BytesPerLine)Then Begin
      TBuf:=MemAlloc(Res.BytesPerLine);
      If(TBuf=NIL)Then Exit;
     End;
     For I:=0to Res.NumYPixels-1do Begin
      XGetAbsRec(Q,RP,Res.BytesPerLine,TBuf^);
      Line2Doublon(TBuf^,PBuffer,TBuf^,BitsPerPixel,Res.BitsPerPixel,Res.NumXPixels);
      XSetAbsRec(Inf.Miroir,FP,Res.NumXPixels,PBuffer);
      Inc(FP,LongInt(Res.NumXPixels));
      Inc(RP,LongInt(Res.BytesPerLine));
     End;
     If(SizeOf(Buffer)<Res.BytesPerLine)Then FreeMemory(TBuf,Res.BytesPerLine);
     Res.BitsPerPixel:=8;Res.BytesPerLine:=Res.NumXPixels;
    End;
   End;
   Else RIMakeDoublon:=eriUnknownFormat;
  End;
   { êcran en 32768 ou 65536 couleurs }
  15,16:Case(Res.BitsPerPixel)of
   4:Begin
    XGetAbsRec(Q,SizeOf(Res)+Mul2Word(Res.BytesPerLine,Res.NumYPixels),Res.NumPal*3,Pal);
    If Res.NumPal>0Then MakePaletteDoublon(Pal,NewPal,16)
                   Else MakePaletteDoublon(DefaultRGB,NewPal,16);
    If XAllocMem(Ressource,SH+Mul2Word(Res.NumXPixels shl 1,Res.NumYPixels),Inf.Miroir)Then Begin
     If(SizeOf(Buffer)<Res.BytesPerLine)Then Begin
      TBuf:=MemAlloc(Res.BytesPerLine);
      If(TBuf=NIL)Then Exit;
     End;
     FP:=SH;RP:=SizeOf(Res);
     PWord:=MemAlloc(Res.NumXPixels shl 1);
     If(PWord<>NIL)Then Begin
      For J:=0to Res.NumYPixels-1do Begin
       XGetAbsRec(Q,RP,Res.NumXPixels,Buffer);
       Line2Doublon(TBuf^,PWord^,NewPal,BitsPerPixel,4,Res.NumXPixels);
       XSetAbsRec(Inf.Miroir,FP,Res.NumXPixels shl 1,PWord^);
       Inc(FP,LongInt(Res.NumXPixels shl 1));
       Inc(RP,LongInt(Res.BytesPerLine));
      End;
      FreeMemory(PWord,Res.NumXPixels shl 1);
     End;
     If(SizeOf(Buffer)<Res.BytesPerLine)Then FreeMemory(TBuf,Res.BytesPerLine);
     Res.BitsPerPixel:=16;Res.BytesPerLine:=Res.NumXPixels shl 1;
    End
     Else
    RIMakeDoublon:=eriOutOfMemory;
   End;
   5..8:Begin
    If Res.NumPal=0Then MoveLeft(DefaultRGB,Pal,SizeOf(DefaultRGB))
     Else
    Begin
     XGetAbsRec(Q,SizeOf(Res)+LongInt(Res.BytesPerLine)*
                LongInt(Res.NumYPixels),Res.NumPal*3,Pal);
    End;
    MakePaletteDoublon(Pal,NewPal,256);
    If XAllocMem(Ressource,SH+Mul2Word(Res.NumXPixels shl 1,Res.NumYPixels),Inf.Miroir)Then Begin
     If(SizeOf(Buffer)<Res.BytesPerLine)Then Begin
      TBuf:=MemAlloc(Res.BytesPerLine);
      If(TBuf=NIL)Then Exit;
     End
      Else
     TBuf:=@Buffer;
     FP:=SH;RP:=SizeOf(Res);
     PWord:=MemAlloc(Res.NumXPixels shl 1);
     If(PWord<>NIL)Then Begin
      For J:=0to Res.NumYPixels-1do Begin
       XGetAbsRec(Q,RP,Res.NumXPixels,TBuf^);
       Line2Doublon(TBuf^,PWord^,NewPal,BitsPerPixel,Res.BitsPerPixel,Res.NumXPixels);
       XSetAbsRec(Inf.Miroir,FP,Res.NumXPixels shl 1,PWord^);
       Inc(FP,LongInt(Res.NumXPixels shl 1));Inc(RP,LongInt(Res.BytesPerLine));
      End;
      FreeMemory(PWord,Res.NumXPixels shl 1);
     End;
     If(SizeOf(Buffer)<Res.BytesPerLine)Then FreeMemory(TBuf,Res.BytesPerLine);
     Res.BitsPerPixel:=16;Res.BytesPerLine:=Res.NumXPixels shl 1;
    End
     Else
    RIMakeDoublon:=eriOutOfMemory;
   End;
   24:Begin
    If XAllocMem(Ressource,SH+Mul2Word(Res.NumXPixels shl 1,Res.NumYPixels),Inf.Miroir)Then Begin
     If(SizeOf(Buffer)<Res.BytesPerLine)Then Begin
      TBuf:=MemAlloc(Res.BytesPerLine);
      If(TBuf=NIL)Then Exit;
     End
      Else
     TBuf:=@Buffer;
     FP:=SH;RP:=SizeOf(Res);
     PWord:=MemAlloc(Res.NumXPixels shl 1);
     If(PWord<>NIL)Then Begin
      For J:=0to Res.NumYPixels-1do Begin
       XGetAbsRec(Q,RP,Res.BytesPerLine,TBuf^);
       Line2Doublon(TBuf^,PWord^,TBuf^,BitsPerPixel,24,Res.NumXPixels);
       XSetAbsRec(Inf.Miroir,FP,Res.NumXPixels shl 1,PWord^);
       Inc(FP,LongInt(Res.NumXPixels shl 1));Inc(RP,LongInt(Res.BytesPerLine));
      End;
      FreeMemory(PWord,Res.NumXPixels shl 1);
     End;
     If(SizeOf(Buffer)<Res.BytesPerLine)Then FreeMemory(TBuf,Res.BytesPerLine);
     Res.BitsPerPixel:=16;Res.BytesPerLine:=Res.NumXPixels shl 1;
    End
     Else
    RIMakeDoublon:=eriOutOfMemory;
   End;
   Else Begin
    If XAllocMem(Ressource,SH+Mul2Word(Res.BytesPerLine,Res.NumYPixels),Inf.Miroir)Then Begin
     FP:=SH;RP:=SizeOf(Res);
     For I:=0to Res.NumYPixels-1do Begin
      XGetAbsRec(Q,RP,Res.BytesPerLine,PBuffer);
      Line2Doublon(PBuffer,PBuffer,PBuffer,Res.BitsPerPixel,BitsPerPixel,Res.NumXPixels);
      XSetAbsRec(Inf.Miroir,FP,Res.BytesPerLine,PBuffer);
      Inc(FP,LongInt(Res.BytesPerLine));
      Inc(RP,LongInt(Res.BytesPerLine));
     End;
    End
     Else
    RIMakeDoublon:=eriOutOfMemory;
   End;
  End;
 End;
 If(Header)Then Begin
  Res.NumPal:=0;
  XSetAbsRec(Inf.Miroir,0,SizeOf(Res),Res);
 End;
End;

Procedure RISetPalette(Var Q:XInf);
Var
 P:Palette256RGB;
 Res:ImageHeaderRes;
Begin
 XGetAbsRec(Q,0,SizeOf(Res),Res);
 If Res.NumPal>0Then Begin
  XGetAbsRec(Q,SizeOf(Res)+Mul2Word(Res.BytesPerLine,Res.NumYPixels),SizeOf(P),P);
  SetPalRGB(P,0,Res.NumPal);
 End;
End;

Procedure RIRes2WnImg(Var Q:XInf;Var Inf:MCanvas);
Var
 Pal:Palette256RGB;
 I:Byte;
Begin
 FillClr(Inf,SizeOf(Inf));
 XGetAbsRec(Q,0,SizeOf(Inf.Res),Inf.Res);
 Inf.Struct.BitsPerPixel:=8;
 Inf.Struct.NumXPixels:=Inf.Res.NumXPixels;
 Inf.Struct.NumYPixels:=Inf.Res.NumYPixels;
 If Inf.Res.NumPal=0Then Begin
  MoveLeft(DefaultRGB,Pal,16*3);
 End
  Else
 XGetAbsRec(Q,SizeOf(Inf.Res)+Mul2Word(Inf.Res.BytesPerLine,Inf.Res.NumYPixels),
              SizeOf(Palette256RGB),Pal);
 For I:=0to 255do Begin
  Inf.CT[I]:=64+(Pal[I].B shr 6)+
                ((Pal[I].G shr 5)shl 2)+
                ((Pal[I].R and$C0)shr 1);
 End;
End;

Procedure BestClrLnHorImg(Y:Word;Const Res:ImageHeaderRes;Const Buffer);
Var
 X,YS,K,B,MX:Word;
 Kr:Byte;
 TBuf:TByte Absolute Buffer;
 XBuf:^TByte;
 WBuf:^TWord Absolute XBuf;
Begin
 If(Y>=NmYPixels)Then Exit;
 If(NmXPixels<=Res.NumXPixels)Then X:=0
                              Else X:=(NmXPixels-Res.NumXPixels)shr 1;
 If(NmYPixels<=Res.NumYPixels)Then YS:=0
                              Else YS:=(NmYPixels-Res.NumYPixels)shr 1;
 If Res.BitsPerPixel=24Then Begin
  Case(BitsPerPixel)of
   15,16:Begin
    XBuf:=MemAlloc(Res.NumXPixels shl 1);
    If(XBuf<>NIL)Then Begin
     Line2Doublon(Buffer,WBuf^,WBuf^,BitsPerPixel,24,Res.NumXPixels);
     ClrLnHorImg(X,YS+Y,Res.NumXPixels,BitsPerPixel,WBuf^);
     FreeMemory(XBuf,Res.NumXPixels shl 1);
    End;
   End;
   8:Begin { êmulation 8 bits du 24 bits}
    B:=0;MX:=Res.NumXPixels;
    If(MX+X>NmXPixels)Then MX:=NmXPixels-X;
     {For K:=0to MX-1do Begin
       SetPixel(X,YS+Y,TBuf[B]shr 6)+((TBuf[B+1]shr 5)shl 2)+(TBuf[B+2]and$E0);
       Inc(B,3);
      End;}
    XBuf:=MemAlloc(MX);
    If(XBuf<>NIL)Then Begin
     ASM { Transformation du tableaux de 24 Ö 8 bits }
      CLD
      MOV CX,MX
      PUSH DS
       LES DI,XBuf
       LDS SI,Buffer
    @1:LODSW
       AND AH,0E0h
       {$IFOPT G+}
        SHR AX,5
       {$ELSE}
        SHR AX,1
        SHR AX,1
        SHR AX,1
        SHR AX,1
        SHR AX,1
       {$ENDIF}
       SHR AL,1
       {$IFOPT G+}
        SHL AH,2
       {$ELSE}
        SHL AH,1
        SHL AH,1
       {$ENDIF}
       XCHG AX,BX
       LODSB
       AND AL,0E0h
       OR  AL,BL
       OR  AL,BH
       STOSB
       LOOP @1
      POP DS
     END;
     ClrLnHorImg(X,YS+Y,MX,8,XBuf^);
     FreeMemory(XBuf,MX);
    End;
   End;
   4:Begin { êmulation 4 bits du 24 bits }
    XBuf:=MemAlloc(Res.NumXPixels);
    If(XBuf<>NIL)Then Begin
     Line2Doublon(Buffer,WBuf^,WBuf^,BitsPerPixel,24,Res.NumXPixels);
     ClrLnHorImg(X,YS+Y,Res.NumXPixels,8,WBuf^);
     FreeMemory(XBuf,Res.NumXPixels);
    End;
   End;
   Else ClrLnHorImg(X,YS+Y,Res.NumXPixels,Res.BitsPerPixel,Buffer);
  End;
 End
  Else
 ClrLnHorImg(X,YS+Y,Res.NumXPixels,Res.BitsPerPixel,Buffer);
End;

Function BestMode{Const Res:ImageHeaderRes):Boolean};
Label 1;
Var
 I:Byte;
Begin
 BestMode:=False;
 If(Res.BitsPerPixel>=15)and(Win<>winNT)Then Begin
  If((BitsPerPixel>=15)and(Res.NumXPixels<=GetNumXPixels)and
     (Res.NumYPixels<=GetNumYPixels)and(Res.NumXPixels>640))Then Begin
   ClrScrBlack;
   BestMode:=True;
  End
   Else
  If Not SetVideoMode(vmGrf640x480c65536)Then Goto 1;
  BestMode:=True;
 End
  Else
1:If Res.BitsPerPixel=1Then Begin
  If Res.NumYPixels>200Then BestMode:=SetVideoMode(vmGrf640x480c2)
                       Else BestMode:=SetVideoMode(vmGrf640x200c2);
 End
  Else
 If Res.NumXPixels<=320Then Begin
  If Res.NumYPixels<=200Then BestMode:=SetVideoMode(vmGrf320x200c256)
                        Else BestMode:=SetVideoMode(vmGrf320x400c256);
 End
  Else
 If Res.NumXPixels<=360Then Begin
  If SetVideoMode(vmGrf360x480c256)Then BestMode:=True
  Else BestMode:=SetVideoMode(vmGrf320x200c256);
 End
  Else
 If SetVideoMode(vmGrf640x480c256)Then BestMode:=True
  Else
 Begin
  BestMode:=SetVideoMode(vmGrf320x200c256);
  If(NmXPixels<Res.NumXPixels)Then SetBytesPerLn(Res.NumXPixels);
 End;
 CloseCur;
 If(Res.BitsPerPixel=24)and(BitsPerPixel=8)Then Begin { TrueColor 8 bits?}
  For I:=0to 255do SetPaletteRGB(I,I and $E0,(I shr 2)shl 5,I shl 6);
 End;
End;

Procedure ScaleSmall8Bits{Const Source;Var Dest;NumXPixels,NumYPixels:Word;
                          NewNumXPixels,NewNumYPixels:Word};
Type
 Fixed=Record Case Boolean of
  False:(DW:LongInt);
  True:(F,I:Word);
 End;
Var
 Bitmap:Record
  Sx,Sy,Cy:Fixed;
 End;
Begin
 FillClr(Bitmap,SizeOf(Bitmap));
 Bitmap.Sx.I:=NumXPixels;
 Bitmap.Sx.DW:=Bitmap.Sx.DW div NewNumXPixels;
 Bitmap.Sy.I:=NumYPixels;
 Bitmap.Sy.DW:=Bitmap.Sy.DW div NewNumYPixels;
 ASM
  {$IFDEF FLAT386}
  {$ELSE}
   CLD
   PUSH DS
    MOV DS,Word Ptr Source[2]
    LES DI,Dest
 @L2:
    MOV AX,Bitmap.Cy.I
    MUL NumXPixels
    MOV BX,AX
    ADD BX,Word Ptr Source
    MOV CX,NewNumXPixels
    XOR SI,SI
    MOV DX,Bitmap.Sx.F
 @L:MOV AL,DS:[BX]
    STOSB
    ADD SI,DX
    ADC BX,Bitmap.Sx.I
    LOOP @L
    MOV AX,Bitmap.Sy.F
    MOV BX,Bitmap.Sy.I
    ADD Bitmap.Cy.F,AX
    ADC Bitmap.Cy.I,BX
    DEC Word Ptr NewNumYPixels
    JNZ @L2
   POP DS
  {$ENDIF}
 END;
End;

Procedure RIPutImageScale(Var Q:XInf;X,Y,SX,SY,Kr:Word);
Var
 Loader:Record
  Res:ImageHeaderRes;
  Source:Array[0..511]of Byte;
  Shadow:Array[0..127]of Byte;
 End;
 Loader16:Record
  Res:ImageHeaderRes;
  Source:Array[0..127]of Byte;
  Shadow:Array[0..31]of Byte;
 End Absolute Loader;
 Dest:Array[0..1023]of Byte;
 J:Byte;
 Len,Base:Word;
Begin
 If Q.Output=$FFThen Exit;
 XGetAbsRec(Q,0,SizeOf(Loader),Loader);
 If Loader.Res.NumXPixels=16Then Begin
  If Loader.Res.NumPal>0Then Begin
   XGetAbsRec(Q,SizeOf(ImageHeaderRes)+Loader.Res.NumPal*3+
                Loader.Res.BytesPerLine*Loader.Res.NumYPixels,
                SizeOf(Loader16.Shadow),Loader16.Shadow);
  End;
  If(Loader.Res.Shadow)Then Update4BitsKrShadow(Loader16.Shadow,Loader16.Source,32,Kr);
  Len:=128;
 End
  Else
 Begin
  If Loader.Res.NumPal>0Then Begin
   XGetAbsRec(Q,SizeOf(ImageHeaderRes)+Loader.Res.NumPal*3+
                Loader.Res.BytesPerLine*Loader.Res.NumYPixels,
                SizeOf(Loader.Shadow),Loader.Shadow);
  End;
  If(Loader.Res.Shadow)Then Update4BitsKrShadow(Loader.Shadow,Loader.Source,128,Kr);
  Len:=512;
 End;
 Conv4To8BitsKr(Loader.Source,Dest,Len);
 If SY>16Then SY:=16;
 ScaleSmall8Bits(Dest,Loader.Source,Loader.Res.NumXPixels,
                      Loader.Res.NumYPixels,SX,SY);
 Base:=0;
 For J:=0to Pred(SY)do Begin
  ClrLnHorImg(X,Y+J,SX,8,Loader.Source[Base]);
  Inc(Base,SX);
 End;
End;

Function _RIViewImage(Const Name:String;Index:Word;Var W:Window;
                       Y1,X2:Byte;Height,Width,DecalY:Word):Boolean;
Var
 Img:XInf;
 Miroir:MCanvas;
 Res:ImageHeaderRes;
 G:GraphPointRec;
Begin
 _RIViewImage:=False;
 If(IsGrf)Then Begin
  If(RILoadImage(Name,diAutoDetect,0,Index,rmAllRes,[],Img)=eriNone)Then Begin
   XGetAbsRec(Img,0,SizeOf(Res),Res);
   If(Width<Res.NumXPixels)Then Res.NumXPixels:=Width;
   {G.X:=(WEGetRX1(W)shl 3)+((W.MaxX-X2+1)shl 3)-Res.NumXPixels;
   G.Y:=GetRawY(WEGetRY1(W)+Y1)+DecalY;}
   ASM
    {$IFDEF FLAT386}
     LEA EDI,W
     MOV AX,Word Ptr [EDI].Window.T.X1
     ADD AX,Word Ptr [EDI].Window.NotFullScrnX
     ADD AL,[EDI].Window.MaxX
     SUB AL,X2
     ADD AH,Y1
     INC AX
     PUSH AX
     MOV ESI,Offset G
     ADD ESI,EBP
     PUSH ESI
     CALL Word2Graph
    {$ELSE}
     LES DI,W
     MOV AX,Word Ptr ES:[DI].Window.T.X1
     ADD AX,Word Ptr ES:[DI].Window.NotFullScrnX
     ADD AL,ES:[DI].Window.MaxX
     SUB AL,X2
     ADD AH,Y1
     INC AX
     PUSH AX
     PUSH SS
     MOV SI,Offset G
     ADD SI,BP
     PUSH SI
     CALL Word2Graph
    {$ENDIF}
   END;
   Dec(G.X,Res.NumXPixels);
   Inc(G.Y,DecalY);
   If(Res.Original)in[diIconWindows..diPointerOS2]Then Begin
    RIPutImage(Img,G.X,G.Y,Res.NumXPixels,Res.NumYPixels);
    XFreeMem(Img);
   End
    Else
   Begin
    RIRes2WnImg(Img,Miroir);
    RIMakeDoublon(Img,rmAllRes,True,Miroir);
    XFreeMem(Img);
    RIPutImage(Miroir.Miroir,G.X,G.Y,Res.NumXPixels,Height);
    XFreeMem(Miroir.Miroir);
   End;
   _RIViewImage:=True;
  End;
 End;
End;

Procedure RIViewImage{Const Name:String;Var W:Wins;
                      Y1,X2:Byte;Height,DecalY:Word};Begin
 _RIViewImage(Name,$FFFF,W,Y1,X2,Height,$FFFF,DecalY);
End;

Procedure RIPreViewImage(Const Name:String;Var W:Window;Y1,X2:Byte;Width,Height:Word);
Var
 G:GraphPointRec;
 OldKr:Byte;
Begin
  {G.X:=(WEGetRX1(W)shl 3)+((W.MaxX-X2+1)shl 3)-Width;
   G.Y:=GetRawY(WEGetRY1(W)+Y1);}
 ASM
   {G.X:=X shl 3;G.Y:=GetRawY(Y);}
  {$IFDEF FLAT386}
   LEA EDI,W
   MOV AX,Word Ptr [EDI].Window.T.X1
   ADD AX,Word Ptr [EDI].Window.NotFullScrnX
   ADD AL,[EDI].Window.MaxX
   SUB AL,X2
   ADD AH,Y1
   INC AX
   PUSH AX
   MOV ESI,Offset G
   ADD ESI,EBP
   PUSH ESI
   CALL Word2Graph
  {$ELSE}
   LES DI,W
   MOV AX,Word Ptr ES:[DI].Window.T.X1
   ADD AX,Word Ptr ES:[DI].Window.NotFullScrnX
   ADD AL,ES:[DI].Window.MaxX
   SUB AL,X2
   ADD AH,Y1
   INC AX
   PUSH AX
   PUSH SS
   MOV SI,Offset G
   ADD SI,BP
   PUSH SI
   CALL Word2Graph
  {$ENDIF}
 END;
 Dec(G.X,Width);
 PutFillBox(G.X,G.Y,G.X+Width,G.Y+Height,0);
 If Not _RIViewImage(Name,$FFFF,W,Y1,X2,Height,Width,0)Then Begin
  OldKr:=W.CurrColor;W.CurrColor:=$F;
  WEPutTxtXY(W,W.MaxX-(Width shr 3),Y1,'Format inconnue...');
  W.CurrColor:=OldKr;
 End;
End;

Procedure RIMediaImage(Index:Word;Var W:Window;Y1,X2:Byte;Height,DecalY:Word);Begin
 If(MediaSupport)Then _RIViewImage('SYS:MEDIA.RLL',Index,W,Y1,X2,Height,$FFFF,DecalY);
End;

Procedure RIPutImageLine{Var Q:XInf;X,Y,Decal,MX,L:Word};
Var
 J,ImageSize:Word;
 Img:Pointer;
 DImg:^TByte;
 Res:ImageHeaderRes;
 OfsStart:LongInt;
Begin
 If(IsGrf)Then Begin
  XGetAbsRec(Q,0,SizeOf(Res),Res);
  ImageSize:=Res.BytesPerLine shl 3;
  Img:=MemAlloc(ImageSize);
  If(Img<>NIL)Then Begin
   DImg:=Img;
   OfsStart:=Mul2Word(L shl 3,Res.BytesPerLine)+SizeOf(Res);
   If(ImageSize<Q.Size)Then Begin
    XGetAbsRec(Q,OfsStart,ImageSize,Img^);
    If(Res.NumXPixels>MX)Then Res.NumXPixels:=MX;
    For J:=0to 7do Begin
     ClrLnHorImg(X,Y,Res.NumXPixels,Res.BitsPerPixel,DImg^[Decal shl 3]);
     If HeightChr<>8Then Begin
      Inc(Y);
      ClrLnHorImg(X,Y,Res.NumXPixels,Res.BitsPerPixel,DImg^[Decal shl 3]);
     End;
     Inc(Y);Inc(PtrRec(DImg).Ofs,Res.BytesPerLine)
    End;
   End;
   FreeMemory(Img,ImageSize);
  End;
 End;
End;

Procedure FillSwapWord(Var Source;Len:Word);Assembler;ASM
 {$IFDEF FLAT386}
  CLD
  LEA   ESI,DWord Ptr Source
  MOV   EDI,ESI
  MOVZX ECX,Len
  JCXZ  @End
@Loop:
  LODSW
  XCHG  AX,BX
  LODSW
  STOSW
  XCHG  AX,BX
  STOSW
  LOOP @Loop
@End:
 {$ELSE}
  CLD
  PUSH DS
   LDS SI,Source
   LES DI,Source
   MOV CX,Len
   JCXZ @End
 @Loop:
   LODSW
   XCHG AX,BX
   LODSW
   STOSW
   XCHG AX,BX
   STOSW
   LOOP @Loop
 @End:
  POP DS
 {$ENDIF}
END;

Procedure BarSpcHorDegrad{X1,Y,X2,Attr:Byte};
Var LineBuffer:Array[0..1023+16]of Word;
    LineBufferByte:Array[0..2047]of Byte Absolute LineBuffer;
    I,Len:Word;R,G,B,X,Color:Byte;
    ID:Real;
Begin
 If(BitsPerPixel<15)or(NmXPixels>1024)Then BarSpcHor(X1,Y,X2,Attr)
  Else
 Begin
  Color:=Attr shr 4;Len:=(X2-X1+1)shl 3;
  ID:=$80/Len;
  R:=DefaultRGB[Color].R and$7F;
  G:=DefaultRGB[Color].G and$7F;
  B:=DefaultRGB[Color].B and$7F;
  If BitsPerPixel=8Then Begin
   For I:=0to Len-1do Begin
    X:=Trunc(I*ID);
    LineBufferByte[I]:=RGB2Color(R+X,G+X,B+X);
   End;
  End
   Else
  For I:=0to Len-1do Begin
   X:=Trunc(I*ID);
   LineBuffer[I]:=RGB2Color(R+X,G+X,B+X);
  End;
  FillSwapWord(LineBuffer,512);
  For I:=0to HeightChr-1do Begin
   ClrLnHorImg(X1 shl 3,GetRawY(Y)+I,Len,BitsPerPixel,LineBuffer[I and 1]);
  End;
 End;
End;

Procedure RICopy2Clipboard(Var Q:XInf);
Var
 NM:Word;
 I,ND,M:LongInt;
 Buf:Array[0..4095]of Byte;
Begin
 MakeClipboard(Q.Size);
 ND:=Q.Size div SizeOf(Buf);NM:=Q.Size mod SizeOf(Buf);M:=0;
 For I:=0to ND-1do Begin
  XGetAbsRec(Q,M,SizeOf(Buf),Buf);
  SetAbsClipboard(M,SizeOf(Buf),Buf);
  Inc(M,LongInt(SizeOf(Buf)));
 End;
 If NM>0Then Begin
  XGetAbsRec(Q,M,NM,Buf);
  SetAbsClipboard(M,NM,Buf);
 End;
End;

Type PExtensior=Record
 Size:Word;       { Taille d'extensior }
 Reference:Word;  { RÇfÇrence d'image }
 Attr:Word;       { Attribut associÇe l'extension }
 WildCard:String; { GÇnÇrique associÇ }
End;

Function ExtensiorSearch{Var Q:Extensior;Const Path:String;Attr:Byte):Word};
Var
 S:String;
 {Handle:Hdl;}
 {EXE:HeaderEXE Absolute Buffer;}

 Function Block:Boolean;
 Var
  H:ExtensiorHeader;
  PExt:^PExtensior;
  I:Word;
  FS:LongInt;
  PB,PosIcon:Word;
  Buffer:Array[0..2047]of Char;
 Begin
  Block:=False;
  If(Q.Handle=errHdl)Then Begin
{   ExtensiorInit(Q);}
   Q.Handle:=FileOpen('SYS:EXTENSIO.DAT',fmDef);
   If(Q.Handle=errHdl)Then Exit;
  End;
  FS:=FileSize(Q.Handle);
  If FS<=SizeOf(H)Then Exit;
  _GetAbsRec(Q.Handle,0,SizeOf(H),H);
  PosIcon:=0;S:=StrUp(Path2NoDir(Path));
  While(H.HomeData<=FS)do Begin
   _GetAbsRec(Q.Handle,H.HomeData,SizeOf(Buffer),Buffer);
   Inc(H.HomeData,LongInt(SizeOf(Buffer)));
   PB:=0;
   Repeat
    PExt:=@Buffer[PB];
    If PExt^.Size=0Then Break;
    If PExt^.Size>=SizeOf(Buffer)Then Break;
    If PB+PExt^.Size>=SizeOf(Buffer)Then Begin
     Dec(H.HomeData,LongInt(SizeOf(Buffer)-PB));
     Break;
    End;
    If((PExt^.Attr and Attr>0)or((Attr=0)and(PExt^.Attr and faDir=0)))and
      (WildCardMatch(S,PExt^.WildCard))Then Begin
     ExtensiorSearch:=PosIcon;Block:=True;
     Exit;
    End;
    Inc(PosIcon);
    Inc(PB,PExt^.Size);
   Until PB>=SizeOf(Buffer);
  End;
 End;

 Procedure Rep;
 Var
  Res:ImageHeaderRes;
  Img:XInf;
 Begin
  If Attr and faDir=0Then Begin
   If WildCardMatch(S,'*.EXE;*.COM')Then Begin
 {   Handle:=Open(Path,fmRead);
    If(Handle<>errHdl)Then Begin
     _GetAbsRec(Handle,0,SizeOf(Buffer),Buffer);
     For I:=0to SizeOf(Buffer)do Begin
      If EXE.SizeOfHeader>$1CThen
      If(Buffer[$3C]<>#0)and(Buffer[$3D]<>#0)Then Begin}
       ExtensiorSearch:=1;
 {      Break;
      End;
     End;
     Close(Handle);
    End;}
   End
    Else
   If(RILoadImage(Path,diAutoDetect,4,$FFFF,rmAllRes,[],Img)=eriNone)Then Begin
    XGetAbsRec(Img,0,SizeOf(Res),Res);
    If(Res.NumXPixels<=32)and(Res.NumYPixels<=32)Then ExtensiorSearch:=$FFFE;
    XFreeMem(Img);
   End;
  End;
 End;

Begin
 ExtensiorSearch:=$FFFF;
 If Not(Block)Then Rep;
End;

Procedure ExtensiorPutIcon(Var Q:Extensior;X,Y,L,H,Code:Word;Kr:Byte;Const Path:String);
Var
 Buffer:Array[0..159]of Byte;
 J:Byte;
 B:Word;
 Img:XInf;
Begin
 If Code=$FFFFThen Exit;
 If Code=$FFFEThen Begin
  If(RILoadImage(Path,diAutoDetect,4,$FFFF,rmAllRes,[],Img)=eriNone)Then Begin
   RIPutImageScale(Img,X,Y,L,H,Kr);
   XFreeMem(Img);
  End;
 End
  Else
 Begin
  If(Q.Handle=errHdl)Then ExtensiorInit(Q);
  _GetAbsRec(Q.Handle,SizeOf(ExtensiorHeader)+(Mul2Word(Code,160)),SizeOf(Buffer),Buffer);
  Update4BitsKrShadow(Buffer[128],Buffer,32,Kr);
  If(L=16)and(H=16)Then Begin
   B:=0;
   For J:=0to 15do Begin
    ClrLnHorImg(X,Y,16,4,Buffer[B]);
    Inc(B,8);Inc(Y);
   End;
  End;
 End;
End;

Procedure Scale8(Var Source,Dest;Count:Word;WX:LongInt);Near;Assembler;ASM
 {$IFDEF FLAT386}
 {$ELSE}
  LES DI,Dest
  PUSH DS
   LDS SI,Source
   MOV CX,Count
   SHR CX,1
   JZ  @StopSc8
   MOV DX,Word Ptr WX
   XOR BX,BX
   MOV AX,Word Ptr WX[2]
   PUSH BP
    MOV BP,AX
    OR  BP,BP
    JZ  @LpSc8
 @Lp2Sc8:
    MOV AL,DS:[SI]
    ADD BX,DX
    ADC SI,BP
    MOV AH,DS:[SI]
    ADD BX,DX
    ADC SI,BP
    STOSW
    DEC CX
    JNZ @Lp2Sc8
   POP BP
   JMP @StopSc8
 @LpSc8:
    MOV AL,DS:[SI]
    ADD BX,DX
    JC  @CarrySc8
    MOV AH,AL
    ADD BX,DX
    ADC SI,BP
    STOSW
    DEC CX
    JNZ @LpSc8
   POP BP
   JMP @StopSc8
 @carrySc8:
    MOV AH,DS:[SI+1]
    INC SI
    ADD BX,DX
    ADC SI,BP
    STOSW
    DEC CX
    JNZ @LpSc8
   POP BP
 @StopSc8:
   TEST Count,1
   JZ  @EndSc8
   MOV AL,DS:[SI]
   MOV ES:[DI],AL
 @EndSc8:
  POP DS
 @End:
 {$ENDIF}
END;

Procedure Scale16(Var Source,Dest;Count:Word;WX:LongInt);Near;Assembler;ASM
 {$IFDEF FLAT386}
 {$ELSE}
  LES DI,Dest
  PUSH DS
   LDS SI,Source
   MOV CX,Count
   SHR CX,1
   JZ  @EndSc16
   MOV DX,Word Ptr WX
   XOR BX,BX
   MOV AX,Word Ptr WX[2]
   PUSH BP
    MOV BP,AX
    SHL BP,1
    JNZ @LpDownSc16
    MOV AX,DS:[SI]
@LpSc16:
    ADD BX,DX
    JNC @NextSc16
    MOV AX,DS:[SI+2]
    ADD SI,2
@NextSc16:
    STOSW
    DEC cx
    JNZ @LpSc16
   POP BP
  POP DS
  JMP @End
@LpDownSc16:
    MOV AX,DS:[SI]
    ADD BX,DX
    JNC @Next2Sc16
    ADD SI,2
@Next2Sc16:
    ADD SI,BP
    STOSW
    DEC CX
    JNZ @lpdownSc16
   POP BP
@EndSc16:
  POP DS
@End:
 {$ENDIF}
END;

Procedure _RIPutScale(Var Image:XInf;X1,Y1,X2,Y2:Word;BitsPerPixel:Byte;Option:WorkImage;Var Target:XInf);
Label Put,Classic16bits;
Type
 Fixed=Record case Boolean of
  True:(L:LongInt);
  False:(F:Word;I:Integer);
 End;
Var
 Buffer:Array[0..2047]of Byte;
 Buffer2:Array[0..4095]of Word;
 Res:ImageHeaderRes;
 ResTarget:ImageHeaderRes Absolute Buffer;
 Palette:Palette256RGB;
 PalWord:Array[0..255]of Word;
 PalByte:Array[0..255]of Byte Absolute PalWord;
 J:Word;
 Len,Height:Word;
 NewSize:LongInt;
 Sy,Cy,S:Fixed;
  { Variable rÇservÇ pour la copie }
 SizeTargetImage:LongInt;
 TargetBytesPerLine:Word;
 TargetP:LongInt;
Begin
 If BitsPerPixel=0Then BitsPerPixel:=Adele.BitsPerPixel;
 Len:=X2-X1+1;Height:=Y2-Y1+1;
 XGetAbsRec(Image,0,SizeOf(Res),Res);
 XGetAbsRec(Image,SizeOf(Res)+LongInt(Mul2Word(Res.BytesPerLine,Res.NumYPixels)),
            SizeOf(Palette),Palette);
 Sy.L:=(Res.NumYPixels*$10000)div Height;
 Cy.I:=Pred(Res.NumYPixels);
 Cy.F:=$FFFF;
 If(BitsPerPixel=4)and(Res.BitsPerPixel=4)Then Begin
  NewSize:=(65536*Res.NumXPixels)div Len;
 End
  Else
 NewSize:=(65536*Res.BytesPerLine)div Len;
 If(wiCopy2Target)in(Option)Then Begin
  TargetBytesPerLine:=LocalBytesPerLine(Len,BitsPerPixel);
  SizeTargetImage:=SizeOf(Res)+Long(Mul2Word(TargetBytesPerLine,Height));
  If XAllocMem(rmAllRes,SizeTargetImage,Target)Then Begin
   FillClr(ResTarget,SizeOf(ResTarget));
   ResTarget.ID:=idResImage;
   ResTarget.BytesPerLine:=TargetBytesPerLine;
   ResTarget.NumXPixels:=Len;
   ResTarget.NumYPixels:=Height;
   ResTarget.BitsPerPixel:=BitsPerPixel;
   ResTarget.Original:=Res.Original;
   ResTarget.Descr:=Res.Descr;
   XSetAbsRec(Target,0,SizeOf(ResTarget),ResTarget);
   TargetP:=SizeTargetImage;
  End
   Else
  Exclude(Option,wiCopy2Target);
 End;
 If BitsPerPixel=8Then Begin
  For J:=0to 255do Begin
   PalByte[J]:=RGB2Color(Palette[J].R,Palette[J].G,Palette[J].B);
  End;
 End
  Else
 Begin
  If(Res.NumPal=0)and(Res.BitsPerPixel=4)Then Begin
   MakePaletteDoublon(DefaultRGB,PalWord,16);
  End
   Else
  MakePaletteDoublon(Palette,PalWord,Res.NumPal);
 End;
 J:=Height;
 If Res.BytesPerLine>SizeOf(Buffer)Then Exit;
 If Res.BytesPerLine=0Then Exit;
 While Cy.I>=0do Begin
  S.L:=(Cy.I*Res.BytesPerLine)*$10000;
  XGetAbsRec(Image,Mul2Word(Cy.I,Res.BytesPerLine)+SizeOf(Res),
             Res.BytesPerLine,Buffer);
  Case(BitsPerPixel)of
   4:Begin
    Case(Res.BitsPerPixel)of
     4:Begin
      Conv4To8BitsKr(Buffer,Buffer2,Res.BytesPerLine);
      Scale8(Buffer2,Buffer2,Res.NumXPixels,NewSize);
      Conv8To4BitsKr(Buffer2,Buffer2,TargetBytesPerLine);
      Goto Put;
     End;
    End;
   End;
   8:Begin
    Case(Res.BitsPerPixel)of
     4,8:Begin
      If TargetBytesPerLine>SizeOf(Buffer)Then Exit;
      Line2Doublon(Buffer,Buffer2,PalByte,BitsPerPixel,Res.BitsPerPixel,Res.NumXPixels);
      If(TargetBytesPerLine<Res.BytesPerLine)Then
       Scale8(Buffer2,Buffer2,Res.NumXPixels,NewSize);
      Goto Put;
     End;
    End;
   End;
   15,16:Begin
    Case(Res.BitsPerPixel)of
     4:Begin
      NewSize:=(65536*Res.NumXPixels)div Len;
      If TargetBytesPerLine>SizeOf(Buffer)Then Exit;
      Line2Doublon(Buffer,Buffer2,PalWord,BitsPerPixel,Res.BitsPerPixel,Res.NumXPixels);
      If TargetBytesPerLine<(Res.BytesPerLine shl 2)Then Begin
       Scale16(Buffer2,Buffer2,Res.NumXPixels,NewSize);
      End;
      Goto Put;
     End;
     8:Begin
Classic16bits:
      If TargetBytesPerLine>SizeOf(Buffer)Then Exit;
      Line2Doublon(Buffer,Buffer2,PalWord,BitsPerPixel,Res.BitsPerPixel,Res.NumXPixels);
      If(TargetBytesPerLine<Res.BytesPerLine)Then Begin
       Scale16(Buffer2,Buffer2,Res.NumXPixels,NewSize);
      End;
  Put:If(wiPut2Screen)in(Option)Then ClrLnHorImg(X1,J+Y1,Len,BitsPerPixel,Buffer2);
      If(wiCopy2Target)in(Option)Then Begin
       XSetAbsRec(Target,TargetP,TargetBytesPerLine,Buffer2);
       Dec(TargetP,LongInt(TargetBytesPerLine));
      End;
     End;
     15,16,24:Begin
      NewSize:=(65536*Res.NumXPixels)div Len;
      Goto Classic16bits;
     End;
    End;
   End;
  End;
  Dec(Cy.l,Sy.L);
  Dec(J);
 End;
End;

Procedure RIPutScale(Var Image:XInf;X1,Y1,X2,Y2:Word);
Var
 Target:XInf;
Begin
 _RIPutScale(Image,X1,Y1,X2,Y2,0,[wiPut2Screen],Target);
End;

Procedure RIDoneLoaderImage(Var R:ImageObjectLoader);
Var
 I:Integer;
Begin
 For I:=0to R.NumAnim-1do Begin
  XFreeMem(R.Anim^[I]);
 End;
End;

{ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ}
END.
