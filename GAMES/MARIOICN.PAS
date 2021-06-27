Program Mario;

Uses Chantal,Systex,Systems,Video;

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

Const XM:Word=200;

Procedure PutMario(X:Byte);Begin
 PutSmlImg(XM,183,XM+19,199,Mem[Seg(MarioIcon):Ofs(MarioIcon)+X*17*20]);
 PutLn(XM+20,183,XM+20,199,0);
End;

Procedure PutTurtle(X:Byte);Begin
 PutSmlImg(XM+40,183,XM+59,199,Mem[Seg(TurtleIcon):Ofs(TurtleIcon)+X*17*20]);
 PutLn(XM+60,183,XM+60,199,0);
End;

Procedure PutCrabe(X:Byte);Begin
 PutSmlImg(XM+60,183,XM+79,199,Mem[Seg(CrabeIcon):Ofs(CrabeIcon)+X*17*20]);
 PutLn(XM+80,183,XM+80,199,0);
End;

Procedure AnimateMario;Var J,TR:Byte;Begin
 Repeat
  TR:=0;
  For J:=0to 6do Begin
   PutMario(J);
   PutTurtle(TR);
   PutCrabe(TR);
   Dec(XM);
   PutMario(J);
   PutTurtle(TR);
   PutCrabe(TR);
   WaitRetrace;WaitRetrace;WaitRetrace;WaitRetrace;
   Dec(XM);
   If XM<10Then Begin
    XM:=200;
    PutFillBox(0,183,GetMaxXPixels,199,0);
   End;
   TR:=(TR+1)and 3;
  End;
 Until KeyPress;
End;

BEGIN
 InitSystems(suIsabel);
 SetVideoMode(vmGrf320x200c256);
 CloseCur;
 PutSmlImg(0,0,19,17*10-1,Mem[Seg(MarioIcon):Ofs(MarioIcon)]);
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
 PutSmlImg(180,1*17,185,1*17+6*3-1,Mem[Seg(BilleIcon):Ofs(BilleIcon)]);
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
 {254}SetPaletteRGB(Byte('þ'),$48,$48,$48);
 {255}SetPaletteRGB(255,0,0,0);
 AnimateMario;
END.