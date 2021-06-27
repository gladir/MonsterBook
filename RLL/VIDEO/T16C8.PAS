Program Test16Copy8Bin;

{$G+}

Uses Systex,Systems,D3v16;

Const Palette:Array[0..63]of Byte=(0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,
                                   0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,
                                   0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,
                                   0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15);

Const PaletteB:Array[0..63]of Byte=(15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,
                                   15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,
                                   15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,
                                   15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15);

{Procedure ClrLnHor8Bin(X,Y,Len:Word;Var Buffer);Var D1,D2,D3,D4:Byte;I,Base:Word;Begin
 I:=0;Base:=(X shr 3)+Y*80;
 While(I<Len)do Begin
  Port[$3C4]:=$02;Port[$3C5]:=1;
  ASM
   CLD
   PUSH DS
    XOR BL,BL
    MOV CX,1
    LDS SI,Buffer
    LODSW
    AND AX,101h
    SHL AH,CL
    OR  BL,AL
    OR  BL,AH
    LODSW
    AND AX,101h
    INC CX
    SHL AL,CL
    INC CX
    SHL AH,CL
    OR  BL,AL
    OR  BL,AH
    LODSW
    AND AX,101h
    INC CX
    SHL AL,CL
    INC CX
    SHL AH,CL
    OR  BL,AL
    OR  BL,AH
    LODSW
    AND AX,101h
    INC CX
    SHL AL,CL
    INC CX
    SHL AH,CL
    OR  BL,AL
    OR  BL,AH
   POP DS
   MOV D1,BL
  END;
  Mem[$A000:Base]:=D1;
  Port[$3C4]:=$02;Port[$3C5]:=2;
  ASM
   CLD
   PUSH DS
    XOR BL,BL
    MOV CX,1
    LDS SI,Buffer
    LODSW
    AND AX,202h
    SHR AX,1
    SHL AH,CL
    OR  BL,AL
    OR  BL,AH
    LODSW
    AND AX,202h
    SHR AX,1
    INC CX
    SHL AL,CL
    INC CX
    SHL AH,CL
    OR  BL,AL
    OR  BL,AH
    LODSW
    AND AX,202h
    SHR AX,1
    INC CX
    SHL AL,CL
    INC CX
    SHL AH,CL
    OR  BL,AL
    OR  BL,AH
    LODSW
    AND AX,202h
    SHR AX,1
    INC CX
    SHL AL,CL
    INC CX
    SHL AH,CL
    OR  BL,AL
    OR  BL,AH
   POP DS
   MOV D2,BL
  END;
  Mem[$A000:Base]:=D2;
  Port[$3C4]:=$02;Port[$3C5]:=4;
  ASM
   CLD
   PUSH DS
    XOR BL,BL
    MOV CX,1
    LDS SI,Buffer
    LODSW
    AND AX,404h
    SHR AX,1
    SHR AX,1
    SHL AH,CL
    OR  BL,AL
    OR  BL,AH
    LODSW
    AND AX,404h
    SHR AX,1
    SHR AX,1
    INC CX
    SHL AL,CL
    INC CX
    SHL AH,CL
    OR  BL,AL
    OR  BL,AH
    LODSW
    AND AX,404h
    SHR AX,1
    SHR AX,1
    INC CX
    SHL AL,CL
    INC CX
    SHL AH,CL
    OR  BL,AL
    OR  BL,AH
    LODSW
    AND AX,404h
    SHR AX,1
    SHR AX,1
    INC CX
    SHL AL,CL
    INC CX
    SHL AH,CL
    OR  BL,AL
    OR  BL,AH
   POP DS
   MOV D3,BL
  END;
  Mem[$A000:Base]:=D3;
  Port[$3C4]:=$02;Port[$3C5]:=8;
  ASM
   CLD
   PUSH DS
    XOR BL,BL
    MOV CX,1
    LDS SI,Buffer
    LODSW
    AND AX,808h
    SHR AX,1
    SHR AX,1
    SHR AX,1
    SHL AH,CL
    OR  BL,AL
    OR  BL,AH
    LODSW
    AND AX,808h
    SHR AX,1
    SHR AX,1
    SHR AX,1
    INC CX
    SHL AL,CL
    INC CX
    SHL AH,CL
    OR  BL,AL
    OR  BL,AH
    LODSW
    AND AX,808h
    SHR AX,1
    SHR AX,1
    SHR AX,1
    INC CX
    SHL AL,CL
    INC CX
    SHL AH,CL
    OR  BL,AL
    OR  BL,AH
    LODSW
    AND AX,808h
    SHR AX,1
    SHR AX,1
    SHR AX,1
    INC CX
    SHL AL,CL
    INC CX
    SHL AH,CL
    OR  BL,AL
    OR  BL,AH
   POP DS
   MOV D4,BL
  END;
  Mem[$A000:Base]:=D4;
  ASM ADD Word Ptr Buffer,8;END;
  Inc(I,8);Inc(Base);
 End;
End;
}

Procedure ClrLnHor8Bin(X,Y,L:Word;Var Buffer);Var Base:Word;Begin
 Base:=(X shr 3)+Y*80;
 ASM
  CLD
  PUSH DS
   MOV AX,0A000h
   MOV ES,AX
   MOV DI,Base
   MOV CX,L
   {$IFOPT G+}SHR CX,3{$ELSE}SHR CX,1;SHR CX,1;SHR CX,1{$ENDIF}
   MOV DX,03C4h
@1:PUSH CX
    MOV AX,0102h
    OUT DX,AX
    LDS SI,Buffer
@A: {$IFOPT G-}PUSH CX{$ENDIF}
     XOR BX,BX
     {$IFOPT G-}MOV CX,8{$ENDIF}
     LODSW
     AND AX,101h
     {$IFOPT G+}
      SHL AL,7
      SHL AH,6
     {$ELSE}
      DEC CX
      SHL AL,CL
      DEC CX
      SHL AH,CL
     {$ENDIF}
     OR  BX,AX
     LODSW
     AND AX,101h
     {$IFOPT G+}
      SHL AL,5
      SHL AH,4
     {$ELSE}
      DEC CX
      SHL AL,CL
      DEC CX
      SHL AH,CL
     {$ENDIF}
     OR  BX,AX
     LODSW
     AND AX,101h
     {$IFOPT G+}
      SHL AL,3
      SHL AH,2
     {$ELSE}
      DEC CX
      SHL AL,CL
      DEC CX
      SHL AH,CL
     {$ENDIF}
     OR  BX,AX
     LODSW
     AND AX,101h
     SHL AL,1
     OR  BX,AX
     OR  BL,BH
     MOV ES:[DI],BL { Plane 0 }
     INC DI
    {$IFOPT G-}POP CX{$ENDIF}
    DEC CX
    OR  CX,CX
    JNZ @A
   POP CX
   PUSH CX
    MOV DI,Base
    LDS SI,Buffer
    MOV AX,0202h
    OUT DX,AX
@B: {$IFOPT G-}PUSH CX{$ENDIF}
     XOR BX,BX
     {$IFOPT G-}MOV CX,8{$ENDIF}
     LODSW
     AND AX,202h
     SHR AX,1
     {$IFOPT G+}
      SHL AL,7
      SHL AH,6
     {$ELSE}
      DEC CX
      SHL AL,CL
      DEC CX
      SHL AH,CL
     {$ENDIF}
     OR  BX,AX
     LODSW
     AND AX,202h
     SHR AX,1
     {$IFOPT G+}
      SHL AL,5
      SHL AH,4
     {$ELSE}
      DEC CX
      SHL AL,CL
      DEC CX
      SHL AH,CL
     {$ENDIF}
     OR  BX,AX
     LODSW
     AND AX,202h
     SHR AX,1
     {$IFOPT G+}
      SHL AL,3
      SHL AH,2
     {$ELSE}
      DEC CX
      SHL AL,CL
      DEC CX
      SHL AH,CL
     {$ENDIF}
     OR  BX,AX
     LODSW
     AND AX,202h
     SHR AX,1
     SHL AL,1
     OR  BX,AX
     OR  BL,BH
     MOV ES:[DI],BL { Plane 1 }
     INC DI
    {$IFOPT G-}POP CX{$ENDIF}
    DEC CX
    OR  CX,CX
    JNZ @B
   POP CX
   PUSH CX
    MOV DI,Base
    LDS SI,Buffer
    MOV AX,0402h
    OUT DX,AX
@C: {$IFOPT G-}PUSH CX{$ENDIF}
     XOR BX,BX
     {$IFOPT G-}MOV CX,8{$ENDIF}
     LODSW
     AND AX,404h
     {$IFOPT G+}SHR AX,2{$ELSE}SHR AX,1;SHR AX,1{$ENDIF}
     {$IFOPT G+}
      SHL AL,7
      SHL AH,6
     {$ELSE}
      DEC CX
      SHL AL,CL
      DEC CX
      SHL AH,CL
     {$ENDIF}
     OR  BX,AX
     LODSW
     AND AX,404h
     {$IFOPT G+}SHR AX,2{$ELSE}SHR AX,1;SHR AX,1{$ENDIF}
     {$IFOPT G+}
      SHL AL,5
      SHL AH,4
     {$ELSE}
      DEC CX
      SHL AL,CL
      DEC CX
      SHL AH,CL
     {$ENDIF}
     OR  BX,AX
     LODSW
     AND AX,404h
     {$IFOPT G+}SHR AX,2{$ELSE}SHR AX,1;SHR AX,1{$ENDIF}
     {$IFOPT G+}
      SHL AL,3
      SHL AH,2
     {$ELSE}
      DEC CX
      SHL AL,CL
      DEC CX
      SHL AH,CL
     {$ENDIF}
     OR  BX,AX
     LODSW
     AND AX,404h
     {$IFOPT G+}SHR AX,2{$ELSE}SHR AX,1;SHR AX,1{$ENDIF}
     SHL AL,1
     OR  BX,AX
     OR  BL,BH
     MOV ES:[DI],BL { Plane 2 }
     INC DI
    {$IFOPT G-}POP CX{$ENDIF}
    DEC CX
    OR  CX,CX
    JNZ @C
   POP CX
   MOV DI,Base
   LDS SI,Buffer
   MOV AX,0802h
   OUT DX,AX
@D:{$IFOPT G-}PUSH CX{$ENDIF}
    XOR BX,BX
    {$IFOPT G-}MOV CX,8{$ENDIF}
    LODSW
    AND AX,808h
    {$IFOPT G+}SHR AX,3{$ELSE}SHR AX,1;SHR AX,1;SHR AX,1{$ENDIF}
    {$IFOPT G+}
     SHR AL,7
     SHR AH,6
    {$ELSE}
     DEC CX
     SHL AL,CL
     DEC CX
     SHL AH,CL
    {$ENDIF}
    OR  BX,AX
    LODSW
    AND AX,808h
    {$IFOPT G+}SHR AX,3{$ELSE}SHR AX,1;SHR AX,1;SHR AX,1{$ENDIF}
    {$IFOPT G+}
     SHL AL,5
     SHL AH,4
    {$ELSE}
     DEC CX
     SHL AL,CL
     DEC CX
     SHL AH,CL
    {$ENDIF}
    OR  BX,AX
    LODSW
    AND AX,808h
    {$IFOPT G+}SHR AX,3{$ELSE}SHR AX,1;SHR AX,1;SHR AX,1{$ENDIF}
    {$IFOPT G+}
     SHL AL,3
     SHL AH,2
    {$ELSE}
     DEC CX
     SHL AL,CL
     DEC CX
     SHL AH,CL
    {$ENDIF}
    OR  BX,AX
    LODSW
    AND AX,808h
    {$IFOPT G+}SHR AX,3{$ELSE}SHR AX,1;SHR AX,1;SHR AX,1{$ENDIF}
    SHL AL,1
    OR  BX,AX
    OR  BL,BH
    MOV ES:[DI],BL { Plane 3 }
    INC DI
   {$IFOPT G-}POP CX{$ENDIF}
   DEC CX
   OR  CX,CX
   JNZ @D
  POP DS
  MOV AX,0F02h
  OUT DX,AX
 END;
End;

Var I,J:Word;

BEGIN
 InitSystems(suIsabel);
 ASM
  MOV AX,18
  INT 10h
 END;
 Init;
 For J:=0to 479do Begin
  I:=0;
  While I<640do Begin
{   ClrLnHor8Bin(I,J,64,Palette);}
{   ClrLnHorImg(I+(J and 7),J,63,8,Palette);}
   ClrLnHorImg(I{+(J and 7)},J,62,4,PaletteB);
   Inc(I,64)
  End;
 End;
 ASM
  XOR AX,AX
  INT 16h
 END;
END.