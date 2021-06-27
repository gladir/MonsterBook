{ Programme ‚mulant le Bios CGA pour les Graphic Solutions }
{ Version 1.0 }

Program BiosCGA;

{$M 3072,0,0 }

Uses Dos;

Type

     PtrRec=Record
      Ofs,Seg:Word;
     End;

     Bool=Boolean;
     TableIntRec=Array[0..255] of Pointer;
     TableIntRR=Array[0..255] of PtrRec;

     MaterialRec=Record
      Reg6845:Array[0..15] of Byte;
     End;

     DataBiosRec=Record
      Mode:Byte;
      NumXTxts,SizePgScr,OfsVid:Word;
      CurPos:Array[0..7] of Word;
      FormatCurA,FormatCurB:Byte;
      CurPg:Byte;
      PortVid:Word;
      SelMode:Byte;
      PalCol:Byte;
      MaxYTxts:Byte;
      HeightChr:Word;
      CtrlVid:Word;
     End;

     ColorRec=Record
      Palette:Byte;
     End;
Var

    TableInt:TableIntRec Absolute $0000:$0000;
    TableIntR:TableIntRR Absolute $0000:$0000;
    OldInt10h:Pointer;

Const

    InfoVid:Record
     ModeSupport:Array[0..6] of Byte;
     ScanLine:Byte;
     NmBlocChr:Byte;
     MaxBlocChr:Byte;
     FlagBiosFunc:Word;
     Reserved:Word;
     SaveFunc:Word;
    End
     =
    (            {0 1 2 3 4  5  6  7 }
     ModeSupport:(1+2+4+8+16+32+64+128, 0,0,0,0,0,0);
     ScanLine:1;
     NmBlocChr:1;
     MaxBlocChr:0;
     FlagBiosFunc:(1 shl 9);
     Reserved:0;
     SaveFunc:0
    );

Procedure GetIntVec(IntNo:Byte;Var Vector:Pointer);
Begin
 ASM CLI; END;
 Vector := TableInt[IntNo];
 ASM STI; END;
End;

Procedure SetIntVec(IntNo:Byte;Vector:Pointer);
Begin
 ASM CLI; END;
 TableInt[IntNo] := Vector;
 ASM STI; END;
End;

Procedure FillWord(Var X;Len,Value:Word);
Assembler;
ASM
 CLD;
 LES DI,X;
 MOV CX,Len;
 MOV AX,Value;
 REP STOSW;
END;

Procedure MoveText(X1,Y1,X2,Y2,X3,Y3:Byte);
Var I,J,L,L2,SegV:Word;

 Procedure TextI;
 Begin
  Move(Mem[SegV:((Y1+I)*Mem[$0040:$4A]+X1) shl 1],
       Mem[SegV:((Y3+I)*Mem[$0040:$4A]+X3) shl 1],L)
 End;

 Procedure Graph640x200c2;
 Var L1,L2,YL1,YL2:Word;
 Begin
  YL1 := ((J+Y1)*8)+I; L1 := ($2000 * (YL1 and 1)) + (80 * (YL1 shr 1)) + X1;
  YL2 := ((J+Y3)*8)+I; L2 := ($2000 * (YL2 and 1)) + (80 * (YL2 shr 1)) + X3;
  Move(Mem[SegV:L1],Mem[SegV:L2],L);
 End;

Begin
 If(X2 < X1)or(Y2 < Y1)Then Exit;
 If(MemW[$0040:$63] = $3D4)Then SegV := $B800 Else SegV := $B000;
 Case Mem[$0040:$49] of
  0..3,7,8:
  Begin
   L := (X2-X1+1) shl 1;
   If(Y3 < Y1)Then
   Begin
    If(X3 < X1)Then For I := 0 to Y2 - Y1 do TextI
	       Else For I := 0 to Y2 - Y1 do TextI;
   End
    else
   Begin
    If(X3 < X1)Then For I := Y2 - Y1 downto 0 do TextI
	       Else For I := Y2 - Y1 downto 0 do TextI;
   End;
  End;
  6:
  Begin
   L := (X2-X1+1) shl 1;
   If(Y3 < Y1)Then
    For J := 0 to Y2-Y1 do For I := 0 to 7 do Graph640x200c2
   Else
    For J := Y2-Y1 downto 0 do For I := 0 to 7 do Graph640x200c2;
  End;
 End;
End;

Procedure PutTxtBar(Pg:Byte;I,Cube:Word);
Var Offset:Word;
Begin
 If(I = 0)Then Exit;
 Offset := MemW[$0040:$4E]+((Mem[$0040:$50+(Pg shl 1)]+
	  (Mem[$0040:$51+(Pg shl 1)] * Mem[$0040:$4A])) shl 1);
 Case Mem[$0040:$49] of
  0..3,8: FillWord(MemW[$B800:Offset],I,Cube);
  7: FillWord(MemW[$B000:Offset],I,Cube);
 End;
 Inc(Mem[$0040:$50+(Pg shl 1)],I);
End;

Procedure PutChrBar(Pg:Byte;I,Cube:Word);
Var Offset,J:Word;
Begin
 If(I = 0)Then Exit;
 Offset := MemW[$0040:$4E]+((Mem[$0040:$50+(Pg shl 1)]+
	  (Mem[$0040:$51+(Pg shl 1)] * Mem[$0040:$4A])) shl 1);
 Case Mem[$0040:$49] of
  0..3,8: For J := 0 to I-1 do Mem[$B800:Offset+(J shl 1)] := Lo(Cube);
  7: For J := 0 to I-1 do Mem[$B000:Offset+(J shl 1)] := Lo(Cube);
 End;
 Inc(Mem[$0040:$50+(Pg shl 1)],I);
End;

Procedure SetPixel640x200To819c2(X,Y:Integer;C:Word);
Assembler;
ASM
 MOV AX,$B800;
 MOV ES,AX;
 MOV DI,8192;
 MOV AX,Y;
 AND AX,1;
 MUL DI;
 MOV DI,AX;
 MOV AX,Y;
 AND AX,-2;
 SHL AX,1;
 SHL AX,1;
 SHL AX,1;
 ADD DI,AX;
 SHL AX,1;
 SHL AX,1;
 ADD DI,AX;
 MOV AX,X;
 SHR AX,1;
 SHR AX,1;
 SHR AX,1;
 ADD DI,AX;
 MOV CH,Byte Ptr X;
 AND CH,7;
 MOV CL,7;
 SUB CL,CH;
 MOV BH,Byte Ptr C;
 AND BH,1;
 SHL BH,CL;
 MOV BL,1;
 SHL BL,CL;
 NOT BL;
 MOV AL,ES:[DI];
 AND AL,BL;
 OR  AL,BH;
 MOV ES:[DI],AL;
END;

Function GetPixel640x200c2(X,Y:Integer):Byte;
Assembler;
ASM
 MOV CL,13;
 MOV AX,Y;
 AND AX,1;
 SHL AX,CL;
 MOV DI,AX;
 MOV AX,Y;
 AND AX,-2;
 SHL AX,1;
 SHL AX,1;
 SHL AX,1;
 ADD DI,AX;
 SHL AX,1;
 SHL AX,1;
 ADD DI,AX;
 MOV AX,X;
 SHR AX,1;
 SHR AX,1;
 SHR AX,1;
 ADD DI,AX;
 MOV AX,$B800;
 MOV ES,AX;
 MOV AL,ES:[DI];
 MOV CH,Byte Ptr X;
 AND CH,7;
 MOV CL,7;
 SUB CL,CH;
 SHR AL,CL;
 AND AL,1;
END;

Procedure Int10h(_Flags,_CS,_IP,_AX,_BX,_CX,_DX,_SI,_DI,_DS,_ES,_BP:Word);
Interrupt;
Const ModeTxt:Array[0..1,0..15] of Byte =
     (($38,$28,$2D,$0A,$1F,$06,$19,$1C,$02,$07,$06,$07,$00,$00,$00,$00),
      ($71,$50,$5A,$0A,$1F,$06,$19,$1C,$02,$07,$06,$07,$00,$00,$00,$00));
      ModeTxt132:Array[0..15] of Byte =
      ($B5,$84,$97,$0A,$1F,$06,$19,$1C,$02,$07,$06,$07,$00,$00,$00,$00);
      ModeMono:Array[0..15] of Byte =
      ($61,$50,$52,$0F,$19,$06,$19,$19,$02,$0D,$0b,$0c,$00,$00,$00,$00);
      ModeGrf:Array[0..15] of Byte =
      ($38,$28,$2D,$0A,$7F,$06,$64,$70,$02,$01,$06,$07,$00,$00,$00,$00);
Var ClearFlag:Bool; I,x80:Byte; Offset:Word;
    _AL,_AH:Byte Absolute _AX;
    _BL,_BH:Byte Absolute _BX;
    _CL,_CH:Byte Absolute _CX;
    _DL,_DH:Byte Absolute _DX;
Begin
 Case Hi(_AX) of
  $00:
  Begin { SetVideoMode }
   ClearFlag := Bool(_AL shr 7);
   Case _AL and $7F of
    $00,$01, { Mode Texte 40x25 }
    $02,$03: { Mode Texte 80x25 }
    Begin
     x80 := _AL shr 1;
     ASM
     XOR AX,AX;
     MOV ES,AX;
     MOV DX,$3B4;
     CMP ES:[$0463],DX;
     JNE @@1;
     MOV DL,$BA;
     MOV AL,$80;
     OUT DX,AL;
     MOV DL,$D4;
     MOV ES:[$0463],DX;
     MOV AL,ES:[$0410];
     AND AL,NOT(16 + 32);
     OR  AL,32;
     MOV ES:[$0410],AL;
    @@1:
     END;
     Port[$3D8] := $02 or (Mem[$0040:$65] and (1 shl 5));
     Port[$3DD] := $00;
     Mem[$0040:$65] := (Mem[$0040:$65] and (1 shl 5)) or x80;
     Port[$3D8] := $04 or Mem[$0040:$65];
     For I := 0 to 15 do
     Begin
      Port[$3D4] := I;
      Port[$3D5] := ModeTxt[x80,I];
     End;
     Port[$3D8] := $0C or Mem[$0040:$65];
     Port[$3D9] := $30; Port[$3DD] := $00; Port[$3DF] := $80;
     If Not(ClearFlag)Then FillWord(Mem[$B800:0],$2000,$0720);
     Mem[$0040:$49] := _AL and $7F;
     MemW[$0040:$4C] := 4096; MemW[$0040:$4E] := 0; Mem[$0040:$62] := 0;
     MemW[$0040:$4A] := 80; Mem[$0040:$84] := 24; MemW[$0040:$85] := 8;
    End;
    $04,$05,$06: { Graphique 320/640x200 en 4/2 couleurs }
    Begin
     x80 := Byte(_AL = $06) shl 4;
     ASM
      CLI;
      XOR AX,AX;
      MOV ES,AX;
      MOV DX,$3B4;
      CMP ES:[$0463],DX;
      JNE @@1;
      MOV DL,$BA;
      MOV AL,$80;
      OUT DX,AL;
      MOV DL,$D4;
      MOV ES:[$0463],DX;
      MOV AL,ES:[$0410];
      AND AL,NOT(16 + 32);
      OR  AL,32;
      MOV ES:[$0410],AL;
     @@1:
      MOV DL,$D8;
      MOV AL,$06;
      OR  AL,x80;
      OUT DX,AL;
     END;
     For I := 0 to 15 do
     Begin
      Port[$3D4] := I;
      Port[$3D5] := ModeGrf[I];
     End;
     ASM
      MOV DX,$3D8;
      MOV AL,$0E;
      OR  AL,x80;
      OUT DX,AL;
      INC DX; { DX = 3D9h }
      MOV AL,15;
      OUT DX,AL;
      MOV DL,$DF;
      MOV AL,$80;
      OUT DX,AL; { Port[3DFh] := 80h }
      STI;
     END;
     If Not(ClearFlag)Then FillChar(Mem[$B800:0],$7FFF,0);
     Mem[$0040:$49] := _AL and $7F;
     MemW[$0040:$4C] := 16384; MemW[$0040:$4E] := 0; Mem[$0040:$62] := 0;
     MemW[$0040:$4A] := 80; Mem[$0040:$84] := 24; MemW[$0040:$85] := 8;
    End;
    $07: { Mono Texte }
    Begin
     If(MemW[$0040:$63] = $3D4)Then
     Begin
      Port[$3DF] := $47; Port[$3BF] := $00;
      MemW[$0040:$63] := $3B4;
      Mem[$0040:$10] := (Mem[$0040:$10] and Not(16+32)) or (16+32);
     End;
     Port[$3B8] := $08;
     For I := 0 to 15 do
     Begin
      Port[$3B4] := I;
      Port[$3B5] := ModeMono[I];
     End;
     Port[$3B8] := $08;
     Mem[$0040:$49] := 7;
     MemW[$0040:$4C] := 4096; MemW[$0040:$4E] := 0; Mem[$0040:$62] := 0;
     MemW[$0040:$63] := $3B4;
     MemW[$0040:$4A] := 80; Mem[$0040:$84] := 24; MemW[$0040:$85] := 14;
    End;
    $08: { 132x25 }
    Begin
     ASM
      XOR AX,AX;
      MOV ES,AX;
      MOV DX,$3B4;
      CMP ES:[$0463],DX;
      JNE @@1;
      MOV DL,$BA;
      MOV AL,$80;
      OUT DX,AL;
      MOV DL,$D4;
      MOV ES:[$0463],DX;
      MOV AL,ES:[$0410];
      AND AL,NOT(16 + 32);
      OR  AL,32;
      MOV ES:[$0410],AL;
     @@1:
     END;
     If Not(ClearFlag)Then FillWord(Mem[$B800:0],$2000,$0720);
     Port[$3D8] := $02; Port[$3DD] := $00; Port[$3D8] := $05;
     For I := 0 to 15 do
     Begin
      Port[$3D4] := I;
      Port[$3D5] := ModeTxt132[I];
     End;
     Port[$3D8] := $0D; Port[$3D9] := $30; Port[$3DD] := $00; Port[$3DF] := $90;
     Mem[$0040:$49] := 7;
     MemW[$0040:$4C] := 6600; MemW[$0040:$4E] := 0; Mem[$0040:$62] := 0;
     Mem[$0040:$4A] := 132; Mem[$0040:$84] := 24; MemW[$0040:$85] := 8;
    End;
   End;
   FillChar(Mem[$0040:$50],16,0);
  End;
  $01:
  Begin { SetCursorType }
   Port[MemW[$0040:$63]] := $0A;
   Port[MemW[$0040:$63]+1] := _CL;
   Port[MemW[$0040:$63]] := $0B;
   Port[MemW[$0040:$63]+1] := _CH;
   MemW[$0040:$60] := _CX;
  End;
  $02:
  Begin { SetCursorPos }
   Offset := (_DH * MemW[$0040:$4A]) + _DL;
   Port[MemW[$0040:$63]] := $0E;
   Port[MemW[$0040:$63]+1] := Hi(Offset);
   Port[MemW[$0040:$63]] := $0F;
   Port[MemW[$0040:$63]+1] := Lo(Offset);
   MemW[$0040:$50+(_BH shl 1)] := _DX;
  End;
  $03: { GetCursorInfo }
  Begin
   _CX := MemW[$0040:$60];
   _DX := MemW[$0040:$50+(_BH shl 1)];
  End;
  $05: { SetPage }
  Begin
   _AL := _AL and 7;
   Mem[$0040:$62] := _AL;
   MemW[$0040:$4E] := Word(_AL) * MemW[$0040:$4C];
   Port[MemW[$0040:$63]] := $0C;
   Port[MemW[$0040:$63]+1] := Mem[$0040:$4F];
   Port[MemW[$0040:$63]] := $0D;
   Port[MemW[$0040:$63]+1] := Mem[$0040:$4E];
  End;
  $06:
  For I := 1 to _AL do MoveText(_CL,_CH,_DL,_DH-1,_CL,_CH+1);
  $07:
  For I := 1 to _AL do MoveText(_CL,_CH+1,_DL,_DH,_CL,_CH);
  $08: { GetCube }
  Case Mem[$0040:$49] of
   0..3: _AX := MemW[$B800:MemW[$0040:$4E]+((Mem[$0040:$50+(_BH shl 1)]+
	       (Mem[$0040:$51+(_BH shl 1)] * Mem[$0040:$4A])) shl 1)];
   7: _AX := MemW[$B000:MemW[$0040:$4E]+((Mem[$0040:$50+(_BH shl 1)]+
	    (Mem[$0040:$51+(_BH shl 1)] * Mem[$0040:$4A])) shl 1)];
  End;
  $09: { PutBarTxt }
  PutTxtBar(_BH,_CX,_AL or (_BL shl 8));
  $0A: { PutBarChr }
  PutChrBar(_BH,_CX,_AL or (_BL shl 8));
  $0B: { SetPalette }
  Case Mem[$0040:$49] of
   0..3,6: Port[$3D9] := _BL;
   4,5: Port[$3D9] := _BL or (_BH shl 4)
  End;
  $0C: { SetPixel }
  Case Mem[$0040:$49] of
   4,5,6: SetPixel640x200To819c2(_CX,_DX,_AL);
  End;
  $0D: { GetPixel }
  Case Mem[$0040:$49] of
   4,5,6: _AL := GetPixel640x200c2(_CX,_DX);
   Else _AL := 0;
  End;
  $0E:
  Begin
   Case Char(_AX) of
    #0,#7,#10:;
    #13:Inc(Mem[$0040:$51+(Hi(_BX) shl 1)]);
    #9: PutChrBar(_BH,8,_BL shl 8);
    Else PutChrBar(_BH,1,_AL or (_BL shl 8));
   End;
   If(Mem[$0040:$50+(_BH shl 1)] > Mem[$0040:$4A]-1)Then
   Begin
    Mem[$0040:$50+(_BH shl 1)] := 0;
    Inc(Mem[$0040:$51+(_BH shl 1)]);
   End;
   If(Mem[$0040:$51+(_BH shl 1)] > Mem[$0040:$84])Then
   Begin
    Mem[$0040:$51+(_BH shl 1)] := Mem[$0040:$84];
    MoveText(_CL,_CH+1,_DL,_DH,_CL,_CH);
   End;
   Offset := (Mem[$0040:$51+(_BH shl 1)] * MemW[$0040:$4A]) +
	     Mem[$0040:$50+(_BH shl 1)];
   Port[MemW[$0040:$63]] := $0E;
   Port[MemW[$0040:$63]+1] := Hi(Offset);
   Port[MemW[$0040:$63]] := $0F;
   Port[MemW[$0040:$63]+1] := Lo(Offset);
  End;
  $0F:
  Begin { GetVideoInfo }
   _AX := MemW[$0040:$49]; _BH := Mem[$0040:$62];
  End;
  $10:
  Case _AL of
   $01:
   Case Mem[$0040:$49] of
    0..3,7: Port[$3D9] := _BH;
   End;
   $03:
   ASM
    {$IFOPT G+}
     PUSH $0000;
     POP  ES;
    {$ELSE}
     XOR AX,AX;
     MOV ES,AX;
    {$ENDIF}
    MOV DX,ES:[$0463];
    ADD DX,4;
    MOV AL,_BL;
    AND AL,1;
    {$IFOPT G+}
     ROR AL,2;
    {$ELSE}
     ROR AL,1;
     ROR AL,1;
    {$ENDIF}
    MOV BL,AL;
    ADD AL,$09;
    OUT DX,AL;
    MOV AL,1 shl 5;
    AND ES:[$0465],AL;
    OR  ES:[$0465],BL;
   END;
  End;
  $11:
  Case _AL of
   $30:
   Begin
    _CX := MemW[$0040:$85]; _DL := Mem[$0040:$84];
    Case _BL of
     0: { Contenu de l'interruption 1Fh }
     Begin
      _ES := TableIntR[$1F].Seg; _BP := TableIntR[$1F].Ofs;
     End;
     1: { Contenu de l'interruption 43h }
     Begin
      _ES := TableIntR[$43].Seg; _BP := TableIntR[$43].Ofs;
     End;
     3: { Contenu de la premiŠre moiti‚ de la table de caractŠre 8x8 en ROM}
     Begin
      _ES := $FFA6; _BP := $E;
     End;
    End;
   End;
  End;
  $12:
  Case _AL of
   $36: { Interdit/Autorise la constrution de l'‚cran }
   Begin
    _AL := ((Not(_AL)) and 1) shl 3;
    Port[MemW[$0040:$63]+4] := (Mem[$0040:$65] and 8) or _AL;
   End;
  End;
  $1A:
  Case _AL of
   00:
   Begin
    _AL := $1A;
    _BX := $0002;
   End;
  End;
  $1B:
  Case _AL of
   0:Case _BX of
    0:
    Begin
     MemW[_ES:_DI] := Ofs(InfoVid);
     MemW[_ES:_DI+$02] := Seg(InfoVid);
     Move(Mem[$0040:$49],Mem[_ES:_DI+$04],$1E);
     Mem[_ES:_DI+$22] := Mem[$0040:$84];
     MemW[_ES:_DI+$23] := MemW[$0040:$85];
     MemW[_ES:_DI+$25] := $0002;
     Case MemW[$0040:$49] of
      0..3:
      Begin
       MemW[_ES:_DI+$27] := 16;
       Mem[_ES:_DI+$29] := 8;
       Mem[_ES:_DI+$2A] := $00;
      End;
      4,5:
      Begin
       MemW[_ES:_DI+$27] := 4;
       Mem[_ES:_DI+$29] := 2;
       Mem[_ES:_DI+$2A] := $00;
      End;
      6:
      Begin
       MemW[_ES:_DI+$27] := 2;
       Mem[_ES:_DI+$29] := 2;
       Mem[_ES:_DI+$2A] := $00;
      End;
      7:
      Begin
       MemW[_ES:_DI+$27] := 0;
       Mem[_ES:_DI+$29] := 8;
       Mem[_ES:_DI+$2A] := $01;
      End;
      8: { 132x25 }
      Begin
       MemW[_ES:_DI+$27] := 16;
       Mem[_ES:_DI+$29] := 4;
       Mem[_ES:_DI+$2A] := $00;
      End;
     End;
     MemW[_ES:_DI+$2B] := 0;
     Mem[_ES:_DI+$2D] := Mem[$0040:$65] and (1 shl 5);
     MemW[_ES:_DI+$31] := 0;
    End;
   End;
  End;
 Else
 ASM
  MOV AX,_AX;
  MOV BX,_BX;
  MOV CX,_CX;
  MOV DX,_DX;
  MOV SI,_SI;
  MOV DI,_DI;
  MOV ES,_ES;
  PUSH DS;
   MOV DS,_DS;
   PUSH BP;
    MOV BP,_BP;
    PUSHF;
    CALL OldInt10h;
   POP BP;
  POP DS;
 END;
 End;
End;

Procedure Test10h;
Begin
 ASM
  MOV AH,$02;
  MOV BH,0;
  XOR DX,DX;
  INT $10;
 END;
 Repeat Until Not(MemW[$0040:$001A] = MemW[$0040:$001C]);
End;

BEGIN
 WriteLn('Isabel - Bios CGA - Version 1.0');
 WriteLn('Redirection de l''interruption 10h.');
 WriteLn;
 GetIntVec($10,OldInt10h);
 SetIntVec($10,@Int10h);
 ASM
  MOV AX,$0003;
  INT $10;
 END;
 WriteLn('Programme r‚sident! ABCDEFGHIJKLMNOPQRSTUVWXYZ');
 Test10h;
{ Keep(0);}
 SetIntVec($10,OldInt10h);
END.
