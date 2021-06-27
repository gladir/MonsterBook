{PutCharG.Inc}

{$IFDEF SVGA256}
 Procedure CopyD8Bin(X,Y:Wd;Value,Back,Fore:Byte);Near;Assembler;Var Pg:Wd;ASM
  CLD
  MOV BX,Y
  {$IFOPT G+}
   SHL BX,2
  {$ELSE}
   SHL BX,1
   SHL BX,1
  {$ENDIF}
  MOV ES,DataVideo.MIV.AddrPage
  LES DI,ES:[BX]
  MOV DX,ES
  ADD DI,X
  ADC DX,0
  MOV Pg,DX
  PUSH DX
  PUSH CS
  CALL Near Ptr SetBnkPg
  MOV ES,DataVideo.MIV.SegVideo
  MOV BH,Value
  MOV AX,DI
  ADD AX,7
  JC  @@Long
  OR  BH,BH
  JE  @@1
  MOV AL,Fore
  CMP BH,0FFh
  JNE @@2
  JMP @@1x
 @@1:
  MOV AL,Back
 @@1x:
  MOV AH,AL
  STOSW
  STOSW
  STOSW
  STOSW
  STOSW
  STOSW
  STOSW
  STOSW
  JMP @@End
 @@2:
  MOV DL,Back
  MOV DH,AL
  ROL BH,1
  MOV AX,DX
  JNC @x1
  MOV AL,DH
 @x1:
  STOSB
  STOSB
  ROL BH,1
  JC  @x2
  MOV AH,DL
 @x2:
  MOV AL,AH
  STOSW
  ROL BH,1
  MOV AX,DX
  JNC @x3
  MOV AL,DH
 @x3:
  STOSB
  STOSB
  ROL BH,1
  JC  @x4
  MOV AH,DL
 @x4:
  MOV AL,AH
  STOSW
  ROL BH,1
  MOV AX,DX
  JNC @x5
  MOV AL,DH
 @x5:
  STOSB
  STOSB
  ROL BH,1
  JC  @x6
  MOV AH,DL
 @x6:
  MOV AL,AH
  STOSW
  ROL BH,1
  MOV AX,DX
  JNC @x7
  MOV AL,DH
 @x7:
  STOSB
  STOSB
  ROL BH,1
  JC  @x8
  MOV AH,DL
 @x8:
  MOV AL,AH
  STOSW
  JMP @@End
 @@Long:
  MOV AH,AL
  MOV DL,Back
  MOV DH,Fore
  MOV CX,8
 @@Long3:
  TEST DI,0FFFFh
  JNZ @@Long3A
  PUSH DI; PUSH ES; PUSH CX; PUSH DX
   MOV AX,Pg
   INC AL
   PUSH AX
   PUSH CS
   CALL SetBnkPg.Near
  POP DX; POP CX; POP ES; POP DI
 @@Long3A:
  MOV BL,BH
  ROR BL,CL
  JC  @@Long4
  MOV AL,DL
  STOSB
  STOSB
  {$IFDEF __386__}
   DEC CX
   JNZ @@Long3
  {$ELSE}
   LOOP @@Long3
  {$ENDIF}
  JMP @@End
 @@Long4:
  MOV AL,DH
  STOSB
  STOSB
  {$IFDEF __386__}
   DEC CX
   JNZ @@Long3
  {$ELSE}
   LOOP @@Long3
  {$ENDIF}
 @@End:
 END;
{$ENDIF}

{$IFDEF GrafDriver}
Procedure SetGCubeDouble(X,Y:Wd;Chr:Char;Attr:Byte);Near;
Var I,K,Masque,_X:Wd;
{$IFDEF Graf65536}
 Fore,Back:Word;
{$ELSE}
 Fore,Back:Byte;
{$ENDIF}
P:^Byte;H:Byte;
Begin
 Fore:=Attr and$F;Back:=Attr shr 4;
(* {$IFDEF Graf65536}
  ASM
   MOV DL,Attr
   MOV BL,DL
   AND BX,00F0h
   {$IFOPT G+}
    SHR BX,3
   {$ELSE}
    SHR BX,1
    SHR BX,1
    SHR BX,1
   {$ENDIF}
   MOV BX,Word Ptr ColorTable[BX]
   MOV Word Ptr Back,BX
   MOV BL,DL
   AND BX,000Fh
   SHL BX,1
   MOV DX,Word Ptr ColorTable[BX]
   MOV Word Ptr Fore,DX
  END;
 {$ENDIF}*)
 ASM
  MOV BL,Chr
  XOR BH,BH
  SHL BX,1
  MOV AX,Word Ptr RawY[BX]
  {$IFDEF Graf16}
   CLD
   PUSH DS
    LDS SI,DataVideo.MIV.TxtMtx
    ADD SI,AX
    MOV DX,03C4h
    MOV AX,0F02h
    OUT DX,AX
    MOV DL,0CEh { Index }
    MOV AX,0205h { GraphMode}
    OUT DX,AX
    MOV AX,3
    OUT DX,AX
    MOV ES,DataVideo.MIV.SegVideo
    MOV DI,Y
    SHL DI,1
    MOV AX,X
    {$IFOPT G+}
     SHR AX,3
    {$ELSE}
     SHR AX,1
     SHR AX,1
     SHR AX,1
    {$ENDIF}
    MOV DI,Word Ptr RealRawY[DI]
    ADD DI,AX
    MOV CL,DataVideo.MIV.HeightChar
    XOR CH,CH
    MOV DL,0CEh { Index }
@00:LODSB
    MOV BH,AL
    MOV BL,16
    PUSH CX
     MOV CL,7
@1:  MOV AX,0108h
     SHL AH,CL
     OUT DX,AX
     MOV AL,ES:[DI]
     SHL BH,1
     JC  @1F
     MOV AL,Back
     JMP @1B
@1F: MOV AL,Fore
@1B: STOSB
     DEC BL
     DEC CL
     DEC DI
     PUSH AX
      MOV AX,0108h
      SHL AH,CL
      OUT DX,AX
      MOV AL,ES:[DI]
     POP AX
     STOSB
     OR  CL,CL
     JNE @2
     MOV CL,7
     DEC BL
     OR  BL,BL
     JNZ @1
     JMP @4
@2:  DEC CL
     DEC DI
@3:  DEC BL
     OR  BL,BL
     JNZ @1
@4: POP CX
    DEC DI
    DEC DI
    ADD DI,DataVideo.MIV.BytesPerLine
    LOOP @00
    MOV AX,08FFh
    OUT DX,AX
    MOV AX,5
    OUT DX,AX
   POP DS
  END;
  {$ELSE}
   LES DI,DataVideo.MIV.TxtMtx
   ADD DI,AX
   MOV Word Ptr P,DI
   MOV Word Ptr P[2],ES
   MOV AL,DataVideo.MIV.HeightChar
   MOV H,AL
  END;
  For I:=0to H-1do Begin
   Masque:=P^;_X:=X;
   {$IFDEF SVGA256}
    CopyD8Bin(_X,Y,Masque,Back,Fore);
   {$ELSE}
    For K:=0to 7do Begin
     {$IFDEF InvChar}If Masque and 1<>0Then{$ELSE}If Masque and 128<>0Then{$ENDIF}Begin
      {$IFDEF Graf256}
       ClrLnHor(_X,Y,2,Fore);
       Inc(_X,2);
      {$ELSE}
       SetPixel(_X,Y,Fore);
       Inc(_X);
       SetPixel(_X,Y,Fore);
       Inc(_X);
      {$ENDIF}
     End
      Else
     Begin
      {$IFDEF Graf256}
       ClrLnHor(_X,Y,2,Back);
       Inc(_X,2);
      {$ELSE}
       SetPixel(_X,Y,Back);
       Inc(_X);
       SetPixel(_X,Y,Back);
       Inc(_X);
      {$ENDIF}
     End;
     ASM
      {$IFDEF InvChar}
       SHR Masque,1
      {$ELSE}
       SHL Masque,1
      {$ENDIF}
     END;
    End;
   {$ENDIF}
   Inc(Word(P));Inc(Y)
  End;
 {$ENDIF}
End;
{$ENDIF}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Proc‚dure PutCharGAttr                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'afficher un caractŠre sous le format d'attribut
 typ‚ du traŒtement de texte ®GAT¯.
}

Procedure PutCharGAttr(X,Y:Byte;Chr:Char;Attr,GAttr:Byte);
{$IFDEF GrafDriver}
 Label _DOver,_SOver,_Small,_NotExposant,_NotDoubleUnderLine;
{$ELSE}
 Var Bold,Underline,Italic,Inverse,Double:Boolean;
{$ENDIF}
Var P:^TByte;
{$IFDEF GrafDriver}H,GX,GY:Word;I:Byte;{$ENDIF}Begin
 {$IFDEF GrafDriver}
  ASM
   MOV AL,X
   XOR AH,AH
   {$IFOPT G+}
    SHL AX,3
   {$ELSE}
    SHL AX,1
    SHL AX,1
    SHL AX,1
   {$ENDIF}
   MOV GX,AX
   MOV BL,Y
   XOR BH,BH
   SHL BX,1
   MOV AX,Word Ptr RawY[BX]
   MOV GY,AX
   MOV AL,DataVideo.MIV.HeightChar
   XOR AH,AH
   MOV H,AX
    { If(Inverse)and Not(Bold)Then Attr:=$F0;}
   MOV AL,GAttr
   AND AL,09h
   CMP AL,8
   JNE @NotInv1
   MOV AL,Attr
   AND AL,0F0h
   CMP AL,0F0h
   JE  @111
   MOV Attr,0F0h
   JMP @NotInv1
@111:
   MOV Attr,0Fh
@NotInv1:
   TEST GAttr,10h
   JZ _Small
  END;
  PutLnHor(GX,GY,GX+15,Attr shr 4);
  ASM
   TEST GAttr,1h
   JZ  @NotBold
   CMP Attr,0F0h
   JAE @NotBold
   OR  Attr,8h
@NotBold:
  END;
  SetGCubeDouble(GX,GY,Chr,(Attr and$F8)+$7);
  ASM
   TEST GAttr,02h
   JZ   _NotDoubleUnderLine
  END;
  PutLnHor(GX,(Y+1)*H-2,GX+15,Attr and$F);
_NotDoubleUnderLine:
  Goto _DOver;
_Small:
  ASM
   MOV AL,GAttr
   AND AL,9h
   CMP AL,9h
   JNE _NotExposant { Exposant? }
   MOV AX,$E
   MOV DX,$FFA6
   MOV BL,Chr
   MOV BH,0
   TEST BL,$80
   JZ @1
   XOR AX,AX
   MOV ES,AX
   LES AX,ES:[$7C]
   MOV DX,ES
   AND BX,$7F
@1:
   {$IFOPT G+}
    SHL BX,3
   {$ELSE}
    SHL BX,1
    SHL BX,1
    SHL BX,1
   {$ENDIF}
   ADD AX,BX
   MOV Word Ptr P[0],AX
   MOV Word Ptr P[2],DX
  END;
  For I:=0to 7do Copy8Bin(GX,GY+I,P^[I],Attr shr 4,Attr and$F);
  If H>8Then PutFillBox(GX,GY+8,GX+7,GY+H-1,Attr shr 4);
  Goto _SOver;
  ASM
_NotExposant:
   TEST GAttr,01h { Gras? }
   JZ   @NotBold
{  PutLnHor(GX,GY,GX+7,Attr shr 4);
   SetGCube(GX+1,GY+1,Chr,(Attr and$F0)+$7);
   SetGCubeT(GX,GY,Chr,$F);}
   XOR BH,BH
   LES DI,DataVideo.MIV.TxtMtx
   MOV BL,Chr
   SHL BX,1
   MOV AX,Word Ptr RawY[BX]
   ADD DI,AX
   MOV Word Ptr P,DI
   MOV Word Ptr P[2],ES
   MOV CX,H
   ADD GY,CX
   DEC GY
   PUSH CX
    {PutLnHor(GX,GY,GX+7,Attr shr 4);}
    PUSH GX
    PUSH GY
    MOV AX,GX
    ADD AX,7
    PUSH AX
    MOV AL,Attr
    XOR AH,AH
    {$IFOPT G+}
     SHR AL,4
    {$ELSE}
     SHR AL,1
     SHR AL,1
     SHR AL,1
     SHR AL,1
    {$ENDIF}
    PUSH AX
    PUSH CS
    CALL Near Ptr PutLnHor
   POP CX
@4A:
   ADD Word Ptr P,CX
   DEC Word Ptr P
@4B:LES DI,P
   MOV BL,ES:[DI]
   PUSH CX
    TEST GAttr,4 {Italique?}
    JE  @6B
    CMP CL,10
    JNB @5B
    {$IFDEF InvChar}SHL BL,1{$ELSE}SHR BL,1{$ENDIF}
@5B:CMP CL,2
    JNB @6B
    {$IFDEF InvChar}SHL BL,1{$ELSE}SHR BL,1{$ENDIF}
@6B:CMP Attr,0F0h
    JAE @NotT8Bin
    PUSH BX
     {CopT8Bin(GX+1,GY+1,_BL,$F);}
     PUSH GX
     PUSH GY
     {$IFDEF InvChar}
      SHL BL,1
     {$ELSE}
      SHR BL,1
     {$ENDIF}
     PUSH BX
     MOV AX,08h
     CMP Attr,0F0h
     JAE @BlackBold
     MOV AX,0Fh
@BlackBold:
     PUSH AX
     PUSH CS
     CALL Near Ptr CopT8Bin
    POP BX
@NotT8Bin:
    DEC GY
    {Copy8Bin(GX,GY,_BL,Attr shr 4,7);}
    PUSH GX
    PUSH GY
    CMP Attr,0F0h
    JNAE @36
    MOV AL,BL
    SHL AL,1
    OR  BL,AL
@36:
    PUSH BX
    MOV AL,Attr
    MOV AH,0
    {$IFOPT G+}
     SHR AL,4
    {$ELSE}
     SHR AL,1
     SHR AL,1
     SHR AL,1
     SHR AL,1
    {$ENDIF}
    PUSH AX
    MOV AL,0
    CMP Attr,0F0h
    JAE @37
    MOV AL,7
@37:PUSH AX
    PUSH CS
    CALL Near Ptr Copy8Bin
    DEC Word Ptr P  { Inc(PtrRec(P).Ofs); }
   POP CX
   LOOP @4B
   JMP @End
@NotBold:
   XOR BH,BH
   TEST GAttr,04h
   JE  @7
   LES DI,DataVideo.MIV.TxtMtx
   MOV BL,Chr
   SHL BX,1
   MOV AX,Word Ptr RawY[BX]
   ADD DI,AX
   MOV Word Ptr P,DI
   MOV Word Ptr P[2],ES
   XOR CX,CX
@4: LES DI,P
   MOV BL,ES:[DI]
   PUSH CX
    CMP CL,12
    JNA @5
    {$IFDEF InvChar}
     SHR BL,1
    {$ELSE}
     SHL BL,1
    {$ENDIF}
@5:  CMP CL,6
    JNA @6
    {$IFDEF InvChar}
     SHR BL,1
    {$ELSE}
     SHL BL,1
    {$ENDIF}
@6:  {Copy8Bin(GX,GY,_BL,Attr shr 4,Attr and$F);}
    PUSH GX
    PUSH GY
    PUSH BX
    MOV AL,Attr
    XOR AH,AH
    MOV BH,AL
    {$IFOPT G+}SHR AL,4{$ELSE}SHR AL,1;SHR AL,1;SHR AL,1;SHR AL,1{$ENDIF}
    PUSH AX
    MOV AL,BH
    AND AX,0Fh
    PUSH AX
    PUSH CS
    CALL Near Ptr Copy8Bin
    INC Word Ptr P  { Inc(PtrRec(P).Ofs); }
    INC GY
   POP CX
   INC CX
   CMP CX,H
   JB  @4
   JMP @End
@7: {SetCube(X,Y,Chr,(Attr and$F0)+$7);}
   PUSH Word Ptr X
   PUSH Word Ptr Y
   PUSH Word Ptr Chr
   MOV AL,Attr
   AND AX,0F0h
   CMP AL,0F0h
   JAE @8
   OR  AL,7
@8:PUSH AX
   PUSH CS
   CALL Near Ptr SetCube
@End:
  END;
_SOver:
  ASM
   TEST GAttr,02h { Soulign‚? }
   JZ   _DOver
  END;
  PutLnHor(GX,(Y+1)*H-2,GX+7,Attr and$F);
_DOver:
 {$ELSE}
 ASM
  MOV AL,GAttr
  PUSH AX
   AND AL,1
   MOV Bold,AL
  POP AX
  SHR AL,1
  PUSH AX
   AND AL,1
   MOV Underline,AL
  POP AX
  SHR AL,1
  PUSH AX
   AND AL,1
   MOV Italic,AL
  POP AX
  SHR AL,1
  PUSH AX
   AND AL,1
   MOV Inverse,AL
  POP AX
  SHR AL,1
  AND AL,1
  MOV Double,AL
 END;

  ASM
   PUSH Word Ptr X
   PUSH Word Ptr Y
   PUSH Word Ptr Chr
   MOV AL,Attr
   CMP Inverse,Ya
   JE  @0
   AND AL,0F0h
   CMP Bold,Ya
   JE  @1
   MOV BL,GAttr
   AND BL,7
   ADD BL,7
   ADD AL,BL
   JMP @2
@0:{$IFOPT G+}
    SHL AL,4
   {$ELSE}
    MOV CL,4
    SHL AL,CL
   {$ENDIF}
   MOV BL,GAttr
   AND BL,0Fh
   ADD AL,BL
   JMP @2
@1:ADD AL,0Fh
@2:PUSH AX
   PUSH CS
   {$IFDEF BiosDriver}
    CALL Near Ptr SetCube
   {$ELSE}
    CALL Near Ptr SetCubeTxt
   {$ENDIF}
  END;
  If(Double)Then
  {$IFDEF BiosDriver}
   SetCube(X+1,Y,' ',(Attr and$F0)+(GAttr and$7)+$7);
  {$ELSE}
   SetCubeTxt(X+1,Y,' ',(Attr and$F0)+(GAttr and$7)+$7);
  {$ENDIF}
 {$ENDIF}
End;