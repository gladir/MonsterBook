Program Mario;

{$I \Source\Chantal\Def.Inc}
Uses {$IFDEF Adele}Adele,{$ELSE}Chantal,{$ENDIF}
     Systex,Systems,Video;

{$I Icon\Mario.Inc}
{$I Icon\Turtle.Inc}
{$I Icon\Crabe.Inc}
{$I Icon\Sauterelle.Inc}
{$I Icon\Money.Inc}
{$I Icon\Tornade.Inc}
{$I Icon\Ball.Inc}
{$I Icon\Nuage.Inc}
{$I Icon\Brick.Inc}
{$I Icon\Glace.Inc}
{$I Icon\Tuyaux.Inc}
{$I Icon\SortieTuyaux.Inc}
{$I Icon\Pow.Inc}
{$I Icon\Bille.Inc}
Procedure EndData;Begin;End;

Const iMario=1;
      iTurtle=2;
      iCrabe=3;
      iSauterelle=4;
      iNuage=5;
      iTornade=6;
      iBall=7;
      iGlace=8;
      iBrick=9;
      iMoney=10;
      iBille=11;
      GhostPix=[0,Byte('M')..Byte('P'),Byte('e')..Byte('f')];

Var RealRawY:Array[0..199]of Word;

Procedure PutInverseSprite(X1,Y1,X2,Y2:Wd;Var Buffer);Assembler;ASM
 CALL GetVideoSeg
 MOV ES,AX
 PUSH DS
  MOV AX,X2
  SUB AX,X1
  INC AX
  MOV BX,Y1
  SHL BX,1
  MOV BX,Word Ptr RealRawY[BX]
  ADD BX,X1
  MOV DX,Y1
  LDS SI,Buffer
  CLD
(*  {$IFDEF DPMI}
   MOV ES,SegA000
  {$ELSE}
   MOV ES,DataVideo.MIV.SegV
  {$ENDIF}*)
@@Home:
  MOV DI,BX
  ADD DI,AX
  MOV CX,AX
  PUSH AX
@1:LODSB
   OR AL,AL
   JE @2
   MOV ES:[DI],AL
   DEC DI
   LOOP @1
   JMP @3
@2:DEC DI
   LOOP @1
@3:
  POP AX
  ADD BX,320 {DataVideo.MIV.BytesPerLn}
  INC DX
  CMP Y2,DX
  JAE @@Home
 POP DS
END;

Procedure Sprite(X1,Y1,X2,Y2:Word;Dir:Int;Ofs:Word);Begin
 If Dir>0Then PutInverseSprite(X1,Y1,X2,Y2,Mem[Seg(MarioIcon):Ofs])
         Else PutSprite(X1,Y1,X2,Y2,Mem[Seg(MarioIcon):Ofs]);
End;

Var I,T:Word;FontTab,MakeUp:^TByte;

Procedure PutTuyaux(X,Y,P:Wd);Begin
 PutSprite(X,Y,X+26,Y+22,Mem[Seg(TuyauxIcon):Ofs(TuyauxIcon)+P*23*27]);
End;

Procedure PutSortieTuyaux(X,Y,P:Wd);Begin
 PutSprite(X,Y,X+19,Y+19,Mem[Seg(SortieTuyauxIcon):Ofs(SortieTuyauxIcon)+20*20*P]);
End;

Procedure PutBrick(X,Y,P:Wd);Begin
 PutSprite(X,Y,X+12,Y+9,Mem[Seg(BrickIcon):Ofs(BrickIcon)+13*10*P]);
End;

Procedure PutPow(X,Y,P:Wd);Begin
 PutSprite(X,Y,X+23,Y+15,Mem[Seg(PowIcon):Ofs(PowIcon)+24*16*P]);
End;

Procedure Font1;Assembler;ASM
 DB 'eeffeffefefeeffe'
 DB 'eefefefefeefefee'
 DB 'efffeeffefeefefe'
 DB 'ffeffeeeffeffefe'
 DB 'efefeeffefeffeff'
 DB 'efeefefefefeeffe'
 DB 'eefffeefefefffee'
 DB 'eeefeffefefeeffe'
 DB 'ffefeeffefefeffe'
 DB 'efefefefeefffeee'
 DB 'ffeefefeffeefefe'
 DB 'fefefefefefeffef'
 DB 'feeffefeffeffefe'
 DB 'efefeefeefeefeff'
 DB 'efffefefeffeffee'
 DB 'ffefffeffefeeffe'
END;

Procedure PutTextureFont(X,Y:Byte);Begin
 PutSmlImg(X shl 4,Y shl 4,
 (X shl 4)+15,(Y shl 4)+15,Mem[Seg(Font1):Ofs(Font1)]);
End;

Procedure InitScr(X:Byte);Var L,R,T,J:Byte;Begin
 If X in[4,5]Then X:=3;
 If X in[7,8]Then X:=6;
 If X>13Then X:=13;
 L:=X;R:=X;
 Case(X)of
  3:Begin;L:=4;R:=5;End;
  6:Begin;L:=7;R:=8;End;
 End;
 {ClrScrBlack;}
 For J:=0to(MaxYTxts)shr 1do For I:=0to(MaxXTxts)do PutTextureFont(I,J);
 PutTuyaux(25,0,0);
 PutTuyaux(4,0,7);
 PutTuyaux(0,23,3);
 PutTuyaux(262,0,0);
 PutTuyaux(289,0,6);
 PutTuyaux(293,23,1);
 For I:=0to 10do Begin
  If I=10Then Begin
   PutBrick(12*I,43,R);
   PutBrick(307-12*I,43,L);
  End
   Else
  Begin
   PutBrick(12*I,43,X);
   PutBrick(307-12*I,43,X);
  End;
 End;
 For I:=0to 12do Begin
  Case(I)of
   0:T:=L;
   12:T:=R;
   Else T:=X;
  End;
  PutBrick(((320-(13*12+1))shr 1)+12*I,95,T);
 End;
 For I:=0to 3do Begin
  If I=3Then Begin
   PutBrick(12*I,100,R);
   PutBrick(307-12*I,100,L)
  End
   Else
  Begin
   PutBrick(12*I,100,X);
   PutBrick(307-12*I,100,X)
  End;
 End;
 For I:=0to 9do Begin
  If I=9Then Begin
   PutBrick(12*I,143,R);
   PutBrick(307-12*I,143,L)
  End
   Else
  Begin
   PutBrick(12*I,143,X);
   PutBrick(307-12*I,143,X)
  End;
 End;
 PutPow((320-24)shr 1,143,0);
 PutSortieTuyaux(0,170,2);
 PutSortieTuyaux(300,170,3);
 PutFillBox(0,189,GetMaxXPixels,199,LightRed);
 PutLnHor(0,192,GetMaxXPixels,Black);
 PutLnHor(0,196,GetMaxXPixels,Black);
 For I:=0to 39do Begin
  PutLn(I shl 3+4,189,I shl 3+4,191,255);
  SetPixel(I shl 3+2,189,Yellow);SetPixel(I shl 3+1,189,Yellow);SetPixel(I shl 3+2,190,Yellow);
  PutLn(I shl 3,193,I shl 3,195,255);
  SetPixel(I shl 3+6,193,Yellow);SetPixel(I shl 3+5,193,Yellow);SetPixel(I shl 3+6,194,Yellow);
  PutLn(I shl 3+4,197,I shl 3+4,199,255);
  SetPixel(I shl 3+2,197,Yellow);SetPixel(I shl 3+1,197,Yellow);SetPixel(I shl 3+2,198,Yellow);
 End;
 GetSmlImg(0,0,319,199,FontTab^);
 GetSmlImg(0,0,319,199,MakeUp^);
End;

Var Temp:Array[0..1000]of Byte;IM:Byte;
    XA,YA,MA,AA,XDir,YDir:Array[0..255]of Integer;Level:Byte;

Procedure PutAnim;Var J,Y:Byte;Begin
 J:=0;
 While MA[J]<>0do Begin
  SetVideoSeg(PtrRec(FontTab).Seg);
  GetSmlImg(XA[J]-10,YA[J]-20,XA[J]+29,YA[J]+4,Temp);
  SetVideoSeg(PtrRec(MakeUp).Seg);
  PutSmlImg(XA[J]-10,YA[J]-20,XA[J]+29,YA[J]+4,Temp);
  Inc(J);
 End;
 J:=0;
 While MA[J]<>0do Begin
  Y:=YA[J];
  Case MA[J]of
   iMario:Begin
    Sprite(XA[J],Y-16,XA[J]+19,Y,XDir[J],Ofs(MarioIcon)+(AA[J]shr 1)*17*20);
    If(YDir[J]=0)and(XDir[J]<>0)Then AA[J]:=(AA[J]+1)and 7;
   End;
   iTurtle:Begin
    Sprite(XA[J],Y-16,XA[J]+19,Y,XDir[J],Ofs(TurtleIcon)+(AA[J]shr 1)*17*20);
    If(YDir[J]=0)and(XDir[J]<>0)Then AA[J]:=(AA[J]+1)and 7;
   End;
   iCrabe:Begin
    Sprite(XA[J],Y-16,XA[J]+19,Y,XDir[J],Ofs(CrabeIcon)+(AA[J]shr 1)*17*20);
    If(YDir[J]=0)and(XDir[J]<>0)Then AA[J]:=(AA[J]+1)and 7;
   End;
   iSauterelle:Begin
    If AA[J]=0Then Dec(Y,3);
    Sprite(XA[J],Y-16,XA[J]+19,Y,XDir[J],Ofs(SauterelleIcon)+(AA[J]shr 1)*17*20);
    If(YDir[J]=0)and(XDir[J]<>0)Then AA[J]:=(AA[J]+1)and 7;
   End;
   iMoney:Begin
    Sprite(XA[J],Y-16,XA[J]+19,Y,XDir[J],Ofs(MoneyIcon)+(AA[J]shr 1)*17*20);
    AA[J]:=MaxByte(AA[J],19);
   End;
   iTornade:Begin
    Sprite(XA[J],Y-16,XA[J]+19,Y,XDir[J],Ofs(TornadeIcon)+(AA[J]shr 1)*17*20);
    AA[J]:=MaxByte(AA[J],21);
   End;
   iNuage:Begin
    Sprite(XA[J],Y-16,XA[J]+19,Y,XDir[J],Ofs(NuageIcon)+(AA[J]shr 1)*17*20);
    If(YDir[J]=0)and(XDir[J]<>0)Then AA[J]:=MaxByte(AA[J],3);
   End;
  End;
  Inc(J);
 End;
 J:=0;
 While MA[J]<>0do Begin
  SetVideoSeg(PtrRec(MakeUp).Seg);
  GetSmlImg(XA[J]-10,YA[J]-20,XA[J]+29,YA[J]+4,Temp);
  SetVideoSeg($A000);
  PutSmlImg(XA[J]-10,YA[J]-20,XA[J]+29,YA[J]+4,Temp);
  Inc(J);
 End;
End;

Procedure MakeAnimal;Var Pres:Bool;I:Byte;Begin
 Pres:=No;
 If IM>=250Then Exit;
 For I:=1to(IM)do Begin
  If(YA[I]<50)and(XA[I]<80)Then Begin;Pres:=True;Break;End;
 End;
 If Not(Pres)Then Begin
  Inc(IM);
  Case(Level)of
   0:MA[IM]:=iTurtle;
   1:MA[IM]:=iCrabe;
   2:If Random(2)=1Then MA[IM]:=iTurtle Else MA[IM]:=iCrabe;
   3:MA[IM]:=iSauterelle;
   4:MA[IM]:=iMoney;
   Else MA[IM]:=Random(4)+2;
  End;
  XA[IM]:=50;YA[IM]:=20;XDir[IM]:=1;AA[IM]:=0;
 End;
 Pres:=No;
 If IM>=250Then Exit;
 For I:=1to(IM)do Begin
  If(YA[I]<50)and(XA[I]>200)Then Begin;Pres:=True;Break;End;
 End;
 If Not(Pres)Then Begin
  Inc(IM);
  Case(Level)of
   0:MA[IM]:=iTurtle;
   1:MA[IM]:=iCrabe;
   2:If Random(2)=1Then MA[IM]:=iTurtle Else MA[IM]:=iCrabe;
   3:MA[IM]:=iSauterelle;
   4:MA[IM]:=iMoney;
   Else MA[IM]:=Random(4)+2;
  End;
  XA[IM]:=250;YA[IM]:=20;XDir[IM]:=-1;AA[IM]:=0;
 End;
End;

Procedure DelList(P:Byte);{Var I:Byte;}Begin
 MoveLeft(XA[P+1],XA[P],(IM-P)shl 1);
 MoveLeft(YA[P+1],YA[P],(IM-P)shl 1);
 MoveLeft(XDir[P+1],XDir[P],(IM-P)shl 1);
 MoveLeft(YDir[P+1],YDir[P],(IM-P)shl 1);
 MoveLeft(MA[P+1],MA[P],(IM-P)shl 1);
 MoveLeft(AA[P+1],AA[P],(IM-P)shl 1);
{ For I:=P to IM-1do Begin
  XA[I]:=XA[I+1];
  YA[I]:=YA[I+1];
  XDir[I]:=XDir[I+1];
  YDir[I]:=YDir[I+1];
  MA[I]:=MA[I+1];
  AA[I]:=AA[I+1];
 End;}
 Dec(IM);
End;

Procedure AnimateMario;Var I,J,TPow:Byte;Begin
 FillClr(XA,SizeOf(XA));FillClr(YA,SizeOf(YA));
 FillClr(MA,SizeOf(MA));FillClr(AA,SizeOf(AA));
 FillClr(XDir,SizeOf(XDir));FillClr(YDir,SizeOf(YDir));
 IM:=0;MA[0]:=iMario;XA[0]:=199;YA[0]:=187;
 Repeat
  TPow:=0;
  Repeat
   For I:=0to(IM)do Begin
    Inc(XA[I],XDir[I]);
    If XA[I]<0Then XA[I]:=319;
    If XA[I]>319Then XA[I]:=0;
    Inc(YA[I],YDir[I]);
    If YDir[I]<0Then Begin
     If YA[I]<22Then YDir[I]:=0;
     If XDir[I]>0Then Begin
      If Not(GetPixel(XA[I]+19,YA[I]-17)in GhostPix)Then Begin;YDir[I]:=0;AA[I]:=0;End;
     End
      Else
     If Not(GetPixel(XA[I],YA[I]-17)in GhostPix)Then Begin;YDir[I]:=0;AA[I]:=0;End;
    End
     Else
    If YDir[I]>0Then Begin
     If Not(GetPixel(XA[I],YA[I])in GhostPix)Then Begin;YDir[I]:=0;AA[I]:=0;End;
    End
     Else
    If((GetPixel(XA[I],YA[I]+1)in GhostPix)and
      (GetPixel(XA[I]+19,YA[I]+1)in GhostPix))Then YDir[I]:=2;
   End;
   WaitRetrace;WaitRetrace;
   PutAnim;
   TPow:=(TPow+1)and$F;
   Case(TPow)of
    7:SetPaletteRGB(Byte('U'),$8C,$00,$00);{Fond du POW}
    15:SetPaletteRGB(Byte('U'),$00,$00,$8C);{Fond du POW}
   End;
   MakeAnimal;
   I:=1;
   While(I<=IM)do Begin
    If(XDir[I]<0)and(XA[I]<30)and(YA[I]>170)Then DelList(I)Else
    If(XDir[I]>0)and(XA[I]>264)and(YA[I]>170)Then DelList(I)
     Else
    Inc(I)
   End;
  Until KeyPress;
  Case(ReadKey)of
   kbEsc:Break;
   kbLeft:XDir[0]:=-1;
   kbRight:XDir[0]:=1;
   kbDn:Begin;XDir[0]:=0;AA[0]:=0;End;
   kbSpc:If YDir[0]=0Then Begin;AA[0]:=4;YDir[0]:=-2;End;
   kbCtrlL:Begin;Inc(Level);InitScr(Level)End;
  End;
 Until No;
End;

BEGIN
 Randomize;
 InitSystems(suIsabel);
 FontTab:=MemAlloc(64016);
 If(FontTab=NIL)Then Begin;WriteLn('Manque de m‚moire!');Halt;End;
 MakeUp:=MemAlloc(64016);
 If(MakeUp=NIL)Then Begin;WriteLn('Manque de m‚moire!');Halt;End;
 Inc(PtrRec(FontTab).Seg);Inc(PtrRec(MakeUp).Seg);
 PtrRec(FontTab).Ofs:=0;PtrRec(MakeUp).Ofs:=0;
 For I:=Ofs(MarioIcon)to Ofs(EndData)do Begin
{  If Not((I>=Ofs(BrickIcon))and(I<=Ofs(GlaceIcon)))Then} Begin
   If Mem[Seg(MarioIcon):I]=255Then Mem[Seg(MarioIcon):I]:=0;
  End;
 End;
 SetVideoMode(vmGrf320x200c256);
 CloseCur;
{ PutSmlImg(0,0,19,17*10-1,Mem[Seg(MarioIcon):Ofs(MarioIcon)]);
 PutSmlImg(20,0,39,9*17-1,Mem[Seg(MarioIcon):Ofs(MarioIcon)+10*17*20]);
 PutSmlImg(40,0,59,17*10-1,Mem[Seg(TurtleIcon):Ofs(TurtleIcon)]);
 PutSmlImg(60,0,79,10*17-1,Mem[Seg(TurtleIcon):Ofs(TurtleIcon)+10*17*20]);
 PutSmlImg(80,0,99,7*17-1,Mem[Seg(TurtleIcon):Ofs(TurtleIcon)+20*17*20]);
 PutSmlImg(100,0,119,10*17-1,Mem[Seg(MoneyIcon):Ofs(MoneyIcon)]);
 PutSmlImg(120,0,139,10*17-1,Mem[Seg(CrabeIcon):Ofs(CrabeIcon)]);
 PutSmlImg(140,0,159,2*17-1,Mem[Seg(CrabeIcon):Ofs(CrabeIcon)+10*17*20]);
 PutSmlImg(160,0,179,10*17-1,Mem[Seg(TornadeIcon):Ofs(TornadeIcon)]);
 PutSmlImg(180,0,199,1*17-1,Mem[Seg(TornadeIcon):Ofs(TornadeIcon)+10*17*20]);
 PutSmlImg(200,0,219,7*17-1,Mem[Seg(SauterelleIcon):Ofs(SauterelleIcon)]);
 PutSmlImg(220,0,239,10*17-1,Mem[Seg(BallIcon):Ofs(BallIcon)]);
 PutSmlImg(240,0,259,2*17-1,Mem[Seg(BallIcon):Ofs(BallIcon)+10*17*20]);
 PutSmlImg(260,0,279,5*17-1,Mem[Seg(NuageIcon):Ofs(NuageIcon)]);
 PutSmlImg(280,0,292,10*14-1,Mem[Seg(BrickIcon):Ofs(BrickIcon)]);
 PutSmlImg(260,100,273,100+9*7-1,Mem[Seg(GlaceIcon):Ofs(GlaceIcon)]);
 PutSmlImg(293,0,319,8*23-1,Mem[Seg(TuyauxIcon):Ofs(TuyauxIcon)]);
 PutSmlImg(180,120,203,120+3*16-1,Mem[Seg(PowIcon):Ofs(PowIcon)]);
 PutSmlImg(140,2*17,159,2*17+20*4-1,Mem[Seg(SortieTuyauxIcon):Ofs(SortieTuyauxIcon)]);
 PutSmlImg(180,1*17,185,1*17+6*3-1,Mem[Seg(BilleIcon):Ofs(BilleIcon)]);}
 {33}SetPaletteRGB(Byte('!'),$00,$00,$FF);
 {34}SetPaletteRGB(Byte('"'),$00,$90,$00);
 {35}SetPaletteRGB(Byte('#'),$FF,$90,$7F);{Visage}
 {36}SetPaletteRGB(Byte('$'),$FC,$FC,$24);{Monaie}
 {37}SetPaletteRGB(Byte('%'),$DF,$70,$1F);
 {38}SetPaletteRGB(Byte('&'),$70,$70,$70);
 {39}SetPaletteRGB(Byte(''''),$70,$70,$70);{Jamais utilis‚}
 {40}SetPaletteRGB(Byte('('),$FF,$00,$00);
 {41}SetPaletteRGB(Byte(')'),$00,$C0,$00);
 {42}SetPaletteRGB(Byte('*'),$FF,$FF,$FF);{Yeux tortue, ailes de sauterelles}
 {43}SetPaletteRGB(Byte('+'),$7E,$7E,$12);{Monaie}
 {44}SetPaletteRGB(Byte(','),$CC,$CC,$14);
 {45}SetPaletteRGB(Byte('-'),$00,$60,$00);
 {46}SetPaletteRGB(Byte('.'),$F0,$F0,$F0);{Dor‚e des 4 Balles}
 {47}SetPaletteRGB(Byte('/'),$90,$90,$90);{Tache de Sauterelle}
 {48}SetPaletteRGB(Byte('0'),$00,$00,$FC);{Tornade et floque d'eau}
 {53}SetPaletteRGB(Byte('5'),$FC,$B0,$2C);{Fond des 4 Balles}
 {64}SetPaletteRGB(Byte('@'),$70,$48,$00);{Pied Mario}
 {65}SetPaletteRGB(Byte('A'),$0,$B0,$EF);
 {66}SetPaletteRGB(Byte('B'),$0,$0,$7F);{Brick}
  {Brick Niveau 1}
 {72}SetPaletteRGB(Byte('H'),$0,$C0,$FF);{Triangle Haut}
 {73}SetPaletteRGB(Byte('I'),$0,0,$FF);{Cadre}
 {74}SetPaletteRGB(Byte('J'),$0,0,$8F);{Triangle Bas}
 {75}SetPaletteRGB(Byte('K'),$0,0,$FF);{Triangle Gauche}
 {76}SetPaletteRGB(Byte('L'),$0,0,$DF);{Triangle Droite}
  {Tuyaux}
 {77}SetPaletteRGB(Byte('M'),$FF,$FF,$2E);{Tuyaux: Barre haute}
 {78}SetPaletteRGB(Byte('N'),0,0,$FF);{Tuyaux: Manivelle}
 {79}SetPaletteRGB(Byte('O'),$DF,$50,$2E);{Tuyaux}
 {80}SetPaletteRGB(Byte('P'),$FF,0,0);{Tuyaux: Barre bas}
  {POW}
 {83}SetPaletteRGB(Byte('S'),$00,$CC,$CC);{Cadrage du POW}
 {84}SetPaletteRGB(Byte('T'),$FF,$FF,$FF);{criture du POW}
 {85}SetPaletteRGB(Byte('U'),$00,$00,$8C);{Fond du POW}
  {Brick Niveau 4}
 {86}SetPaletteRGB(Byte('V'),$FC,$FC,$24);{Partie Haute}
 {87}SetPaletteRGB(Byte('W'),$FF,$80,$2E);{Partie Moyenne}
 {88}SetPaletteRGB(Byte('X'),$FF,$40,$20);{Partie Basse}
  {Glace...}
 {90}SetPaletteRGB(Byte('Z'),$CF,$CF,$CF);
 {91}SetPaletteRGB(Byte('['),$8F,$8F,$8F);
 {92}SetPaletteRGB(Byte('\'),$4F,$4F,$4F);
 {93}SetPaletteRGB(Byte(']'),$FF,$FF,$FF);{Formation de Glace-Fond}
 {94}SetPaletteRGB(Byte('^'),$00,$FF,$FF);{Formation de Glace-Petit piqueau}
 {95}SetPaletteRGB(Byte('_'),$00,$C0,$FF);{Formation de Glace-Bas}
 {97}SetPaletteRGB(Byte('a'),$CF,$50,$2E);{Brick de Pomme}
 {98}SetPaletteRGB(Byte('b'),$DF,$0,$0);{Brick de Pomme}
 {99}SetPaletteRGB(Byte('c'),$FF,$FF,$2F);{Brick de Pomme}
 {99}SetPaletteRGB(Byte('e'),$33,$44,$33);{Brick de Pomme}
 {99}SetPaletteRGB(Byte('f'),$22,$33,$22);{Brick de Pomme}
 {254}SetPaletteRGB(Byte('þ'),$48,$48,$48);
 {255}SetPaletteRGB(255,0,0,0);
 InitScr(0);
 T:=0;
 For I:=0to 199do Begin;RealRawY[I]:=T;Inc(T,320)End;
 Level:=0;
 AnimateMario;
END.