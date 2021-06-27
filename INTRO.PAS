{⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ‹
 ≥                                                              €
 ≥                            Intro!!!                          €
 ≥                                                              €
 ≥                             pour                             €
 ≥                                                              €
 ≥ L'ensemble Malte Genesis III,IV & V: Isabel, Chantal & Adäle €
 ≥ Tous droits rÇservÇs par les Chevaliers de Malte 1995 Ö 1998 €
 ≥                                                              €
 ¿‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹€


 Description
 ÕÕÕÕÕÕÕÕÕÕÕ

  Ce petit programme vise Ö montrer la puissance des outils fournit par
 l'ensemble Chantal pour l'animation graphique et de prÇsentation.


 Programmeur
 ÕÕÕÕÕÕÕÕÕÕÕ

  Sylvain Maltais,
  Shane Smit (WormHole).
}

Program Intro;
{$I DEF.INC}
Uses {$IFDEF Adele}Adele,{$ELSE}Chantal,{$ENDIF}Dialex,
     Video,Isatex,Systex,Systems,GoldNaxe,Mouse,Dials,Arcade,Volume;

Procedure Boule;Begin
 SetVideoMode(vmGrf320x200c256);
 PutTxtCenter(0,__Justified__,'Dessin avec le "DRAW" du BASIC',LightBlue);
 PutRect(0,16,319,199,15);
 Draw('C15BM160,59M163,58M168,60M172,61M175,64M176,67M176,68'+
      'M173,72M168,75M164,76M160,77M156,75M152,73M150,72M149,68'+
      'M151,63M157,59M160,59'); {Nez}
 _PutFillCircle(161,64,4);{Boule du nez}
 Draw('BM174,69M176,72M177,76M176,78M175,80M173,83M169,78M165,85M166,85'+
      'M163,86M160,87M152,85M148,86M144,85M139,85M137,83');{Gueule}
 Draw('BM150,72M148,77');{Haut de la gueule}
 Draw('BM135,83M139,84BM135,80M139,81');{Ligne dans la joue}
 Draw('BM152,85M152,88M150,89M150,92');{Ligne du cou}
 Draw('BM148,77M147,72M144,70M141,67M137,62M134,63M139,68M141,70M144,71');{Sourcils}
 Draw('BM134,63M139,64BM138,62M131,66M130,64M135,59M133,59M129,61M123,63'+
      'M122,67M123,69M121,66M122,61BM118,64M117,66M120,70M122,71M121,74'+
      'M120,77M122,82M124,85M125,81M121,92M120,94M116,96M112,98M108,100'+
      'M104,102M102,104M99,107M97,111M97,114M98,116M100,120');{Haut de la tàte}
 Draw('BM100,120M102,122M104,124M108,126M112,127M116,126M120,123M123,120'+
      'M124,116M126,112M128,104M129,96M130,91M129,90M128,85M130,83'+
      'BM129,90M134,91M136,92M141,89M144,91M146,93M142,94M148,99');{Oreille gauche}
 Draw('BM148,99M152,95M157,93M156,91M151,92M146,93');{Collier}
 Draw('BM144,80M146,77BM144,77M146,74M144,73BM140,78M142,77'+
      'BM141,78E0BM140,76M142,76M141,75M139,74M139,76BM137,77M135,75');{Les yeux}
 Draw('BM141,75M139,72M136,71M134,71M133,72M134,73BM138,70M137,69'+
      'M138,67BM131,74M128,72M128,69M131,67M133,69M131,70M131,72M131,74');
 Draw('BM138,90M139,92M138,97M135,101M132,107M130,109M130,113M133,117'+
      'M136,118M142,116M144,114M148,111');{Oreille droite}
 Draw('BM148,99M147,103M147,106BM150,101M147,106M148,109M148,111'+
      'M152,113M155,112M153,108BM155,112M160,113'+
      'M163,109M164,108BM157,93M163,94M168,96');{Patte gauche}
 Draw('BM168,96M166,100M164,99M163,109M168,112M171,112M174,108'+
      'M175,102M180,98M176,95M172,93M170,93M168,96'+{Patte droite}
      'BM175,107M179,112M182,115M183,120M182,123M181,126M180,128');
 Draw('BM179,98M180,101M177,102BM180,101M181,105M181,107M179,109M175,108');{Coude}
 Draw('BM176,123M175,123M175,124M177,124M178,122');{Nombril}
 Draw('BM177,126M174,127M168,126M165,120M164,116M164,114');{Ventre}
 Draw('BM151,113M152,115M151,120M150,123');{Dos}
 Draw('BM148,123M157,121M162,122M165,123M164,126M163,128M157,132'+
      'M172,129M177,130M180,133M176,139M167,142M160,144M146,141'+
      'M144,138M147,134M144,131M146,125M148,123'+{Patte gauche en bas}
      'BM177,136M172,132BM176,140M172,136');
 Draw('BM145,128M141,126M143,123M141,125M141,120M140,125M139,120'+{Queue}
      'M139,124M135,123M137,126M135,131M136,134M140,136M144,137'+
      'BM182,123M185,124M184,126M182,127M187,130M187,133M183,137M176,139');
 ClsCur;
 ClrKbd;
 ReadKey;
End;

Procedure CAO;Const Vert:RGB=(R:$00;G:$50;B:$00);Var I:Byte;Begin
 SetVideoMode(vmGrf320x200c256);
 PutTxtCenter(0,__Justified__,'CAO avec le "DRAW" du BASIC',LightBlue);
 SetPalRGB(Vert,2,1);
 For I:=2to(MaxYTxts)do ClrLnHor(0,I shl 3,NmXPixels,Green);
 For I:=0to(MaxXTxts)do PutLn(I shl 3,12,I shl 3,GetMaxYPixels,Green);
 Draw('C10BM65,50R60D10NL20D20L20NU20L20NU20L20U20NR20U10');{ Vue de dessus }
 Draw('BM65,100R20ND20R20ND20R20D20NL20D10L60U10NR20U20');{ Vue de devant }
 Draw('BM200,100R30D30L30U10NE20U20'); { Vue de cìtÇ }
 Draw('BM200,50U5E15R10BF20BD30NR5L20H25U10');
 Draw('BM200,50U5F8U15R15H8F8L15F8NR15D15F8ND10E15NR10H8');
 Draw('BM225,30M250,55BM250,55D25BM217,60M233,46');
 ClsCur;
 ClrKbd;
 ReadKey;
End;

Procedure Ile;

 Procedure Wait;Begin
  WaitRetrace;WaitRetrace;WaitRetrace;
  PutFillBox(0,16,GetMaxXPixels,GetMaxYPixels,0);
{  ClrScrBlack;}
  _Move2(160,100)
 End;

Begin
 SetVideoMode(vmGrf320x200c256);
 PutTxtCenter(0,__Justified__,'Animation avec le "DRAW" du BASIC',LightBlue);
 Wait;
 ClrKbd;
 Repeat
  Draw('C10BL13E15F2NG13E5R4F18');Wait;
  Draw('BL18E18R4F16BH2E2F6');Wait;
  Draw('BL26E18R4F14G1E3F6BL1BH6H9G1BF6BR3E2F10');Wait;
  Draw('BL33E18R4F14NG3E2F6BR12H15G7F3H5G1BR16F2E3F10');Wait;
  Draw('BL40E18R4F14NG4E2F6BR5H10G4BR9BF1E10F12BH4E3F10');Wait;
  Draw('BL47E18R4F14NG4E2NF6BF2E6F9BH1E13F9G3E7F10');Wait;
  Draw('BL6H6G6BL22E18R4F12NG3E4F6NG4E11F8NG7E3F10');Wait;
  Draw('BL10H6G6BL11E18R4F9NG8E1F3NG7E8F6NG9E1F10');Wait;
  Draw('BL13H6G6BL1E18R4F7BG3H2G10BR4E15F15BL4H10G10');Wait;
  Draw('BL28E6F6E18R4F18BL5H15G15BR3E10F10');Wait;
  Draw('BL24E6F3NG3E7NF10BF2E7NF15BF3E6R4F18');Wait;
  Draw('BL26E10F10BH6E9F15BR2H10G1BF3BE1E11R4F18');Wait;
  Draw('BL33E10NF7BF5E10F15BH6E4F10BH4E14R4F18');Wait;
  Draw('BL39E10F6G2E13F15BH4E6F10E18R4F18');Wait;
  Draw('BL32E10F5NG4E10F7G2E4F7BG3E18R4F18');Wait;
 Until KeyPress;
 ReadKey;
End;

Type Block=Array[0..99,0..319]of Byte;
Var SrcFrame,DestFrame:^Block;

Procedure Flames;
{fait dÇfiler l'image d'une ligne vers le haut et interpole}
Procedure ScrollUp;Assembler;ASM
 PUSH DS
  LES DI,DestFrame     {pointeur sur image de destination }
  LDS SI,SrcFrame      {pointeur sur image source }
  ADD SI,320            {ligne 1 de l'image source }
  MOV CX,320*98         {fait dÇfiler 99 lignes }
  XOR BL,BL             {octet de poids fort fantìme }
@lp1:
  XOR AX,AX
  XOR BX,BX
  MOV AL,[SI-321]       {cherche le premier point }
  MOV BL,[SI-320]       {ajoute le deuxiäme }
  ADD AX,BX
  MOV BL,[SI-319]       {ajoute le suivant }
  ADD AX,BX
  MOV BL,[SI-1]         {etc...}
  ADD AX,BX
  MOV BL,[SI+1]
  ADD AX,BX
  MOV BL,[SI+319]
  ADD AX,BX
  MOV BL,[SI+320]
  ADC AX,BX
  MOV BL,[SI+321]
  ADC AX,BX
  {$IFOPT G+}SHR AX,3{$ELSE}SHR AX,1;SHR AX,1;SHR AX,1{$ENDIF}
  OR AX,AX              {dÇjÖ 0 ?}
  JE @null
  DEC AL                {si non, dÇcrÇmenter}
  CMP AL,1
  JNZ @null
  DEC AL
@null:
  STOSB                 {valeur en destination }
  INC SI                {point suivant }
  DEC CX                {autres points ?}
  JNE @lp1
 POP DS
END;

{reconstruit les lignes infÇrieures }
Procedure NewLine;Var I,X:Word;Begin
 For X:=0to 319do Begin {remplit 3 lignes avec des valeurs alÇatoires }
  DestFrame^[97,X]:=Random(15)+64;
  DestFrame^[98,X]:=Random(15)+64;
  DestFrame^[99,X]:=Random(15)+64;
 End;
 For I:=0to Random(45)do Begin{ajoute un nombre alÇatoires de foyers brñlants }
  X:=Random(320);               {Ö des endroits au hasard }
  ASM
   LES DI,DestFrame   {adresse l'image de destination }
   ADD DI,98*320       {traite la ligne 98 (deuxiäme du bas) }
   ADD DI,X            {ajoute l'abscisse x }
   MOV AL,0FFh         {couleur la plus claire }
   MOV ES:[DI-321],AL  {produit un foyer brñlant de grande taille (9 pixels)}
   MOV ES:[DI-320],AL
   MOV ES:[DI-319],AL
   MOV ES:[DI-1],AL
   MOV ES:[DI],AL
   MOV ES:[DI+1],AL
   MOV ES:[DI+319],AL
   MOV ES:[DI+320],AL
   MOV ES:[di+321],AL
  END;
 End;
End;

{copie l'Çcran dans la carte graphique pour permuter les pointeurs}
Procedure ShowScreen;Var T:Pointer;Begin
 MoveLeft(DestFrame^,Mem[_A000:320*100],320*100);
 T:=DestFrame;DestFrame:=SrcFrame;SrcFrame:=T;{Çchange les pointeurs sur source et destination}
End;

{prÇpare la palette pour Flames }
Procedure PrepPal;Var I:Word;Palette:Array[0..767]of Byte;Begin
 FillClr(Palette,80*3);       {Au dÇbut: tout noir }
 FillChr(Palette[3],3,$FF);
 For I:=0to 7do Begin
  Palette[I*3+2]:=I*4;        {Couleurs 0-7: bleu croissant}
  Palette[(I+8)*3+2]:=64-I*4; {Couleurs 8-15: bleu dÇcroissant}
 End;
 For I:=8to 31do Palette[I*3]:=(I-8)*255div 23;{couleurs 8-31: rouge croissant}
 For I:=32to 55do Begin       {couleurs 32-55: vert croissant, rouge constant}
  Palette[I*3]:=255;
  Palette[I*3+1]:=(I-32)*255div 23;
 End;
 For I:=56to 79do Begin       {couleurs 56-79: bleu croissant, rouge et vert const.}
  Palette[I*3]:=255;
  Palette[I*3+1]:=255;
  Palette[I*3+2]:=(I-56)*255div 23;
 End;
 FillChr(Palette[80*3],176*3,255);  {le reste blanc}
 SetPalRGB(Palette,0,256);
End;

Begin
 SrcFrame:=MemNew(320*100);DestFrame:=MemNew(320*100);
 If(SrcFrame=NIL)or(DestFrame=NIL)Then Begin
  ErrMsgOk('Manque de mÇmoire pour cette partie d''Intro!');
  Exit;
 End;
 SetVideoMode(vmGrf320x200c256);
 PrepPal;     {prÇpare la palette}
 PutTxtCenter(1,__Justified__,'Des simples petites flames',$01);
 ClrKbd;
 Repeat
  ScrollUp;   {flammes montantes}
  NewLine;    {ajoute une nouvelle ligne en bas}
  ShowScreen; {affiche l'Çcran}
  WaitRetrace;
 Until KeyPress;
 ReadKey;
 FreeMem(SrcFrame,320*100);FreeMem(DestFrame,320*100);
End;

Const ScrollYPos=80;Radius=50;NumSlices=90;
AngleInc=2*Pi/NumSlices;Spacing=4;NumXCoords=300div Spacing;
MsgDisp='         * * * * * Voici un simple dÇfilement de texte en pixel sinusoãdale * * * * *        ';
NumDispChars=Length(MsgDisp);CharLength=8;HeightChr=8;NumChars=256;NumCycles=200;
DispStr:String=MsgDisp;CharColor=239;
Var ScreenPath:Array[1..HeightChr*80]of Wd;ScreenPathLine:Array[1..HeightChr*80]of Byte;
    CurrentLine,CurrentArrayLoc:Wd;DispChars:Array[1..NumDispChars*CharLength*HeightChr]of Byte;

Procedure SetPaletteWhite2Blue(S,N:Byte);Var J,T:Byte;Begin
 Port[$3C8]:=S;
 For J:=0to N-1do Begin
  T:=(7-J)shl 3;
  Port[$3C9]:=T;
  Port[$3C9]:=T;
  Port[$3C9]:=T+(J shl 3);
 End;
End;

Procedure SetPaletteRed2White(S,N:Byte);Var J,T:Byte;Begin
 Port[$3C8]:=S;
 For J:=0to N-1do Begin
  T:=J shl 3;
  Port[$3C9]:=T+((7-J)shl 3);
  Port[$3C9]:=T;
  Port[$3C9]:=T;
 End;
End;

Procedure Message;Var H,I,J:Byte;AP,T:Wd;TxtMtx:^TByte;CA,OldCA:Real;Begin
 SetVideoMode(vmGrf320x200c256);
 SetPalBlk(0,256);
 SetPaletteRed2White(CharColor,HeightChr);
 AP:=1;TxtMtx:=GetVideoTxtMtxPtr;
 For H:=1to(NumDispChars)do For I:=0to CharLength-1do For J:=0to HeightChr-1do Begin
  If(TxtMtx^[Byte(DispStr[H])*HeightChr+J]shl I)and$80=0Then DispChars[AP]:=0
                                                        Else DispChars[AP]:=CharColor+J;
  Inc(AP);
 End;
 CA:=Pi;AP:=1;
 For I:=0to NumXCoords-1do Begin
  OldCA:=CA;
  For J:=1to(HeightChr)do Begin
   T:=ScrollYPos+Round(Radius*Sin(CA));
   ScreenPath[AP]:=T*320+I*Spacing+1; ScreenPathLine[AP]:=T;
   CA:=CA+AngleInc; Inc(AP);
  End;
  CA:=OldCA+AngleInc;
 End;
 CurrentLine:=0;CurrentArrayLoc:=0;
 ClrKbd;
 Repeat
  WaitRetrace;
  ASM
   CALL GetVideoSeg
   MOV ES,AX
   MOV BX,CurrentLine
   MOV SI,BX
   {$IFOPT G+}
    SHL BX,3
   {$ELSE}
    MOV CL,3
    SHL BX,CL
   {$ENDIF}
   MOV DX,BX
   MOV AX,NumXCoords
@Loop1:
   MOV CX,HeightChr
@Loop2:
   PUSH AX
    MOV AL,Byte Ptr DispChars[BX]
    PUSH BX
     SUB BX,DX
     OR  AL,AL
     JNE @@2
     MOV AL,Byte Ptr ScreenPathLine[BX]
@@2: SHL BX,1
     MOV DI,Word Ptr ScreenPath[BX]
     STOSB
    POP BX
   POP AX
   INC BX
   CMP BX,(NumDispChars-1)*CharLength*HeightChr
   JNG @@3
   XOR BX,BX
   XOR DX,DX
@@3:
   LOOP @Loop2
   DEC AX
   JNZ @Loop1
   INC SI
   CMP SI,(NumDispChars-1)*CharLength {HeightChr}
   JNG @@4
   XOR SI,SI
@@4:
   MOV CurrentLine,SI
  END;
  WaitRetrace;
 Until KeyPress;
 ReadKey;
End;

Const NmLn=200;NumberBar=4;
 Colors:Array[1..4]of Array[1..15*3]of Byte=
((Trunc(7 /1.2)shl 2,0,0,Trunc(15/1.2)shl 2,0,0,Trunc(23/1.2)shl 2,0,0,
  Trunc(31/1.2)shl 2,0,0,Trunc(39/1.2)shl 2,0,0,Trunc(47/1.2)shl 2,0,0,
  Trunc(55/1.2)shl 2,0,0,Trunc(63/1.2)shl 2,0,0,Trunc(55/1.2)shl 2,0,0,
  Trunc(47/1.2)shl 2,0,0,Trunc(39/1.2)shl 2,0,0,Trunc(31/1.2)shl 2,0,0,
  Trunc(23/1.2)shl 2,0,0,Trunc(15/1.2)shl 2,0,0,Trunc( 7/1.2)shl 2,0,0),
 (0,0,Trunc(7 /1.2)shl 2,0,0,Trunc(15/1.2)shl 2,0,0,Trunc(23/1.2)shl 2,
  0,0,Trunc(31/1.2)shl 2,0,0,Trunc(39/1.2)shl 2,0,0,Trunc(47/1.2)shl 2,
  0,0,Trunc(55/1.2)shl 2,0,0,Trunc(63/1.2)shl 2,0,0,Trunc(55/1.2)shl 2,
  0,0,Trunc(47/1.2)shl 2,0,0,Trunc(39/1.2)shl 2,0,0,Trunc(31/1.2)shl 2,
  0,0,Trunc(23/1.2)shl 2,0,0,Trunc(15/1.2)shl 2,0,0,Trunc( 7/1.2)shl 2),
 (0,Trunc(7 /1.2)shl 2,0,0,Trunc(15/1.2)shl 2,0,0,Trunc(23/1.2)shl 2,0,
  0,Trunc(31/1.2)shl 2,0,0,Trunc(39/1.2)shl 2,0,0,Trunc(47/1.2)shl 2,0,
  0,Trunc(55/1.2)shl 2,0,0,Trunc(63/1.2)shl 2,0,0,Trunc(55/1.2)shl 2,0,
  0,Trunc(47/1.2)shl 2,0,0,Trunc(39/1.2)shl 2,0,0,Trunc(31/1.2)shl 2,0,
  0,Trunc(23/1.2)shl 2,0,0,Trunc(15/1.2)shl 2,0,0,Trunc( 7/1.2)shl 2,0),
 (Trunc(7 /1.2)shl 2,Trunc(7 /1.2)shl 2,0,
  Trunc(15/1.2)shl 2,Trunc(15/1.2)shl 2,0,
  Trunc(23/1.2)shl 2,Trunc(23/1.2)shl 2,0,
  Trunc(31/1.2)shl 2,Trunc(31/1.2)shl 2,0,
  Trunc(39/1.2)shl 2,Trunc(39/1.2)shl 2,0,
  Trunc(47/1.2)shl 2,Trunc(47/1.2)shl 2,0,
  Trunc(55/1.2)shl 2,Trunc(55/1.2)shl 2,0,
  Trunc(63/1.2)shl 2,Trunc(63/1.2)shl 2,0,
  Trunc(55/1.2)shl 2,Trunc(55/1.2)shl 2,0,
  Trunc(47/1.2)shl 2,Trunc(47/1.2)shl 2,0,
  Trunc(39/1.2)shl 2,Trunc(39/1.2)shl 2,0,
  Trunc(31/1.2)shl 2,Trunc(31/1.2)shl 2,0,
  Trunc(23/1.2)shl 2,Trunc(23/1.2)shl 2,0,
  Trunc(15/1.2)shl 2,Trunc(15/1.2)shl 2,0,
  Trunc( 7/1.2)shl 2,Trunc( 7/1.2)shl 2,0));

Procedure Copper;Var Locs:Array[1..NumCycles]of Byte;BarLocs:Array[1..NumberBar]of Byte;J,I,PrevBar:Wd;Begin
 SetVideoMode(vmGrf320x200c256);
 For J:=1to(NumCycles)do Locs[J]:=Round(80*Sin((2*Pi/NumCycles)*J))+80+1;
 For J:=1to(NumberBar)do BarLocs[J]:=J*10;
 SetPalBlk(0,NmLn);
 For J:=0to NmLn-1do ClrLnHor(0,J,320,J);
 SetPaletteRGB(255,$FF,$FF,$FF);
 PutOTxtU(12,__Justified__,'Les barres Copper',255);
 ClrKbd;
 Repeat
  WaitRetrace;
  For J:=1to(NumberBar)do Begin
   If BarLocs[J]=1Then PrevBar:=Locs[NumCycles]Else PrevBar:=Locs[BarLocs[J]-1];
   SetPalBlk(PrevBar,15);
   SetPalRGB(Colors[J],Locs[BarLocs[J]],15);
   Inc(BarLocs[J]);
   If(BarLocs[J]>NumCycles)Then BarLocs[J]:=1;
  End;
 Until KeyPress;
 ReadKey;
End;

Procedure MaxScreen(Ecl:Bool);Var Palette:Array[0..767]of Byte;I,J:Wd;P:^TByte;Begin
 SetVideoMode(vmGrf360x480c256);
 CloseCur;
 P:=MemAlloc(64000);
 If(P=NIL)Then Begin;ErrMsgOk('Pas assez de mÇmoire pour charger l''image!');Exit;End;
 PutOTxtU(0,__Justified__,'VGA: 360 x 480 en 256 couleurs    ',252);
 ExecGetFile('RESOURCE\INTRO\TNG.GFX',0,64000,P^);
 ExecGetFile('RESOURCE\INTRO\TNG.PAL',0,768,Palette);
 For I:=0to 767do Begin
  Palette[I]:=Palette[I]shl 2;
 End;
 SetPalRGB(Palette,0,256);
 I:=0;
 For J:=0to 199do Begin
  ClrLnHorImg(20,40+(J shl 1),320,8,P^[I]);
  ClrLnHorImg(20,40+((J shl 1)+1),320,8,P^[I]);
  Inc(I,320);
 End;
 If(Ecl)Then Begin
  For J:=0to 30do WaitRetrace;
  Ecoule;
 End;
 ClrKbd;
 ReadKey;
 FreeMem(P,64000);
End;

Procedure Star;Var Etoiles:Array[0..500]of Record x,y,Plan:Int;End;I:Wd;Begin
 SetVideoMode(vmGrf360x480c256);
 Randomize;
 Repeat
  For I:=0to 500do Begin
   With Etoiles[I]do Begin
    If(x>=0)and(y>=0)and(y<NmYPixels)and(x<NmXPixels)Then SetPixel(x,y,0);
    Dec(x,Plan shr 5+1);
    If X<=0Then Begin x:=GetMaxXPixels;y:=Random(GetMaxYPixels);Plan:=Random(256);End;
    If(x>=0)and(Y>=0)and(y<NmYPixels)and(x<NmXPixels)Then SetPixel(x,y,(Plan shr 4+16)and$FF);
   End;
  End;
  WaitRetrace;
 Until(KeyPress)or(MouseMove);
 ReadKey;
End;

Procedure Star3D;Const NofStars=50;ZFactor=200;Xc=160;Yc=100;
Type StarRec=Record X,Y,Z:Integer;End;
  StarPos=Array[0..NofStars]of StarRec;
  StarSpd=Array[0..NofStars]of Word;
Var Stars:StarPos;Speed:StarSpd;

 Procedure InitStar;Var I,X,Y:Byte;Begin
  Randomize;
  For I:=0to(NofStars)do begin
   Stars[I].X:=Random(100)-50;
   Stars[I].Y:=Random(100)-50;
   Stars[I].Z:=Random(900)+200;
   Speed[I]:=0;
  End;
  For I:=0to 50do SetPaletteRGB(I,I shl 4,I shl 4,I shl 4);
 End;

 Procedure DoStars;Var X,Y:Integer;I,Color:Byte;

  Procedure NewStar(Num:Byte);Var X,Y:Integer;Begin
   X:=Xc+round(Stars[Num].X*Stars[Num].Z/ZFactor);
   Y:=Yc+round(Stars[Num].Y*Stars[Num].Z/ZFactor);
   If(X>0)and(X<320)and(Y>0)and(Y<200)Then SetPixel(X,Y,0);
   Stars[Num].X:=Random(100)-50;
   Stars[Num].Y:=Random(100)-50;
   Stars[Num].Z:=Random(100)+200;
  End;

 Begin
  WaitRetrace;
  For I:=0to(NofStars)do Begin
   X:=Xc+round(Stars[I].X*Stars[I].Z/ZFactor);
   Y:=Yc+round(Stars[I].Y*Stars[I].Z/ZFactor);
   If GetPixel(X,Y)<=31Then SetPixel(X,Y,0);
   X:=Xc+round(Stars[I].X*(Stars[I].Z+Speed[I])/ZFactor);
   Y:=Yc+round(Stars[I].Y*(Stars[I].Z+Speed[I])/ZFactor);
   If(X>0)and(X<320)and(Y>0)and(Y<200)Then Begin
    Color:=8+(Stars[I].Z div 150);
    If Color>31Then Color:=31;
    If GetPixel(X,Y)=0Then SetPixel(X,Y,Color);
   End
    else
   NewStar(I);
   Inc(Stars[I].Z,Speed[I]);
   If Stars[I].Z>20000Then NewStar(I);
   Speed[I]:=(Stars[I].Z div 150)*(5-(abs(Stars[I].X*Stars[I].Y)div 500));
  End;
 End;

Begin
 SetVideoModeDeluxe(vmGrf320x200c256);
 InitStar;
 ClrKbd;
 Repeat
  WaitRetrace;
  SetPalBlk(0,1);
  doStars;
 Until Keypress;
 ClrKbd;
End;

Const
 NmPntMxObj=63;
 NmFaceMxObj=63;
 NmPntMxFace=10;
 PROFONDEUR=150;
 DISTANCE=400;
 Delta=10000;
 Speed:Word=1;

Type TPolyface=Record
 Pix:Array[0..NmPntMxFace]of Int;
 nbPixs,Kr:Int;
End;

TObjet=Record
 face:Array[0..NmFaceMxObj]of TPolyface;
 x3d,y3d,z3d:Array[0..NmPntMxObj]of Int;
 nbPixs,nbfaces:Int;
End;

Var
 TCos,TSin:Array[0..360]of Int;
 objet:Array[0..6]of TObjet;
 x,y:Array[0..NmPntMxObj]of Int;

Procedure QuickSort(Var A:Array of Int;l,r:Int);Var i,j,x,y:Int;Begin
 i:=l;j:=r;x:=a[(l+r)shr 1];
 While(i<j)do Begin
  While(a[i]<x)do Inc(i);
  While x<a[j]do Inc(j);
  If(i<=j)Then Begin;y:=a[i];a[i]:=a[j];a[j]:=y;Inc(i);Dec(j)End;
 End;
 if(l<j)Then QuickSort(a,l,j);
 if(i<r)Then QuickSort(a,i,r);
End;

Procedure DrawPoly(Var x0:TObjet;N:Int;Kr:Byte);Var I:Int;Begin
 For i:=0to x0.face[N].nbPixs-1do
  PutLine(x[x0.face[N].Pix[i]],y[x0.face[N].Pix[i]],x[x0.face[N].Pix[i+1]],y[x0.face[N].Pix[i+1]],Kr);
End;

Procedure FillPoly(Var x0:TObjet;nf:Int;Kr:Byte);
Var n,i,j,yMin,yMax,PixMin,PixMax,DPixs,k,Chk:Int;xg,xd:Array[0..200]of Int;
Dx,Dy,signe,Nx,Ny:Array[0..NmPntMxFace]of Int;Begin
 yMax:=-1;yMin:=y[x0.face[nf].Pix[0]];PixMin:=0;
 For n:=0to x0.face[nf].nbPixs-1do Begin
  If(y[x0.face[nf].Pix[n]]<yMin)Then Begin;yMin:=y[x0.face[nf].Pix[n]];PixMin:=n;End else
  if(y[x0.face[nf].Pix[n]]>yMax)Then Begin;yMax:=y[x0.face[nf].Pix[n]];PixMax:=n;End;
 End;
 i:=0;
 for n:=PixMin to x0.face[nf].nbPixs-1do Begin
  Nx[i]:=x[x0.face[nf].Pix[n]];Ny[i]:=y[x0.face[nf].Pix[n]];Inc(i)
 ENd;
 Nx[x0.face[nf].nbPixs]:=x[x0.face[nf].Pix[PixMin]];
 Ny[x0.face[nf].nbPixs]:=y[x0.face[nf].Pix[PixMin]];
 For n:=0to PixMin-1do Begin
  Nx[i]:=x[x0.face[nf].Pix[n]];Ny[i]:=y[x0.face[nf].Pix[n]];Inc(i)
 End;
 If(PixMax>PixMin)Then DPixs:=PixMax-PixMin Else DPixs:=x0.face[nf].nbPixs-PixMin+PixMax;
 For i:=0to x0.face[nf].nbPixs-1do Begin
  Dx[i]:=Nx[i+1]-Nx[i];Dy[i]:=Ny[i+1]-Ny[i];
  if Dx[i]<0Then signe[i]:=-1 Else signe[i]:=1;
  if Dy[i]<0Then Dy[i]:=-Dy[i];
  if Dx[i]<0Then Dx[i]:=-Dx[i];
 End;
 j:=0;
 for n:=0to DPixs-1do if Dy[n]<Dx[n]Then Begin
  Chk:=Dx[n]-Dy[n];i:=Ny[n];k:=Nx[n];
  While i<>Ny[n+1]do Begin
   while Chk>0do Begin;Dec(Chk,Dy[n]);Inc(k,signe[n])End;
   Inc(Chk,Dx[n]);xd[j]:=k;Inc(i);Inc(j)
  End;
 End
  else
 Begin
  Chk:=Dy[n]-Dx[n];i:=Ny[n];k:=Nx[n];
  While i<>Ny[n+1]do Begin
   If Chk<0Then Begin;Inc(Chk,Dy[n]);Inc(k,signe[n])End;
   Dec(Chk,Dx[n]);xd[j]:=k;Inc(i);Inc(j)
  End;
 End;
 j:=0;
 For n:=x0.face[nf].nbPixs downto DPixs+1do if Dy[n-1]<Dx[n-1]Then Begin
  Chk:=Dx[n-1]-Dy[n-1];i:=Ny[n];k:=Nx[n];
  While i<>Ny[n-1]do Begin
   While Chk>0do Begin;Dec(Chk,Dy[n-1]);Dec(k,signe[n-1])End;
   Inc(Chk,Dx[n-1]);xg[j]:=k;Inc(i);Inc(j)
  End;
 End
  else
 Begin
  Chk:=Dy[n-1]-Dx[n-1];i:=Ny[n];k:=Nx[n];
  While i<>Ny[n-1]do Begin
   if Chk<0Then Begin;Inc(Chk,Dy[n-1]);Dec(k,signe[n-1])End;
   Dec(Chk,Dx[n-1]);xg[j]:=k;Inc(i);Inc(j)
  End;
 End;
 If xg[5]<xd[5]Then Begin
  I:=0;
  For N:=yMin to yMax-1do Begin
   PutLnHor(xg[I],N,xd[I],Kr);
   Inc(I)
  End;
 End;
End;

Procedure LoaderObjet(No:Int;Name:String);Var f:Text;i,n:Int;Begin
 If Not FileExist(Name)Then Name:='SAMPLES\'+Name;
 Assign(f,Name);
 Reset(f);
 ReadLn(f,Objet[No].NbPixs);
 ReadLn(f,Objet[No].NbFaces);
 Dec(Objet[No].NbFaces);
 ReadLn(f);
 For n:=0to objet[No].nbPixs-1do ReadLn(f,objet[No].x3d[n],objet[No].y3d[n],objet[No].z3d[n]);
 ReadLn(f);
 for N:=0to(Objet[No].NbFaces)do Begin
  Objet[No].Face[n].Kr:=Random(230)+16;
  Read(f,objet[No].face[n].nbPixs);
  For i:=0to objet[No].face[n].nbPixs-1do Begin
   Read(F,objet[No].face[n].Pix[i]);
   Dec(objet[No].face[n].Pix[i]);
  End;
  Objet[No].face[n].Pix[i+1]:=Objet[No].face[n].Pix[0];
  ReadLn(f);
 End;
 System.Close(f);
End;

Procedure InitSinCos;Var N:Int;Begin
 For N:=0to 359do Begin
  TCos[N]:=Trunc(cos(N*3.141592654/180)*Delta);
  TSin[N]:=Trunc(sin(N*3.141592654/180)*Delta);
 End;
End;

Procedure _3D(FilDeFer:Bool);

Procedure DrawObject(Var x0:TObjet);Const i:Int=0;SensX{:Integer}=1;
SensY{:Integer}=1;SensZ{:Integer}=1;Var N,t:Int;ZR,YR,XR:Long;Begin
 If(I<359-Speed)Then Inc(I,Speed)else I:=0;
 for N:=0to x0.nbPixs-1do Begin
  t:=x0.y3d[N];
  YR:=((T*Long(TCos[I]))-(SensX*x0.z3d[N]*Long(TSin[I])))div Delta;
  ZR:=((SensX*T*Long(TSin[I]))+(x0.z3d[N]*Long(TCos[I])))div Delta;
  t:=x0.x3d[N];
  XR:=((T*Long(TCos[i]))-(SensY*ZR*Long(TSin[I])))div Delta;
  ZR:=((SensX*T*Long(TSin[i]))+(ZR*Long(TCos[I])))div Delta;
  t:=XR;
  XR:=((T*Long(TCos[i]))-(SensZ*YR*Long(TSin[i])))div Delta;
  YR:=((SensZ*T*Long(TSin[i]))+(YR*Long(TCos[i])))div Delta;
  x[n]:=(PROFONDEUR*XR)div(DISTANCE+ZR)+(GetNmXPixels shr 1);
  y[n]:=(PROFONDEUR*YR)div(DISTANCE+ZR)+(GetNmYPixels shr 1);
 End;
 If(FilDeFer)Then For N:=0to(x0.nbfaces)do DrawPoly(x0,n,x0.face[n].Kr)
             Else For N:=0to(x0.nbfaces)do FillPoly(x0,n,x0.face[n].Kr);
End;

Const Pg:Byte=0;K:Wd=0;Mode:Byte=0;Obj:Array[0..5]of Bool=(Ya,Ya,Ya,Ya,Ya,Ya);
Begin
 SetVideoModeDeluxe(vmGrf320x400c256);
 SetChrWidth(Mode);
 InitSinCos;
 LoaderObjet(0,'cube.3d');
 LoaderObjet(1,'pyra1.3d');
 LoaderObjet(2,'torus1.3d');
 LoaderObjet(3,'pyra2.3d');
 LoaderObjet(4,'arai.3d');
 LoaderObjet(5,'Carre.3d');
 Repeat
  Pg:=(Pg+1)and 1;
  SetPage(Pg);
  ClrScr(0);
  For K:=0to 5do If Obj[K]Then DrawObject(Objet[K]);
  If(KeyPress)Then Begin
   K:=ReadKey;
   Case(K)of
    kbF2:Begin;Mode:=(Mode+1)and 1;ClrScr(0);SetChrWidth(Mode)End;
    kbF3:If Speed<31Then Inc(Speed);
    kbF4:If Speed>1Then Dec(Speed);
    kbF5:ASM XOR Byte Ptr Obj[0],1;END;
    kbF6:ASM XOR Byte Ptr Obj[1],1;END;
    kbF7:ASM XOR Byte Ptr Obj[2],1;END;
    kbF8:ASM XOR Byte Ptr Obj[3],1;END;
    kbF9:ASM XOR Byte Ptr Obj[4],1;END;
    kbF10:ASM XOR Byte Ptr Obj[5],1;END;
    Else Exit;
   End;
  End;
  SetVisualPg(Pg);
  WaitRetrace;
 Until No;
End;

Procedure TestScroll;Var J,I,X,Y,XDir,YDir,IDir:Wd;Output:ImgRec;Begin
 SetVideoMode(vmTxtDef);
 If Not(IsVGA)Then Begin                                      { Les cartes MDA, CGA et EGA ne supporte pas cette technique}
  ErrMsgOk('Carte VGA rÇclamÇ pour ce genre d''effet spÇciaux!');
  Exit;
 End;
 SetBytesPerLn(320);                                          { Double la largeur des bandes (normalement Ö 160) }
 FillBox(0,0,159,49,'-',7);                                   { Affiche une tapiserie vulgaire }
 For J:=0to 49do For I:=0to 15do PutTxtXYUnKr(10*I,J,Str(I)); { Affiche les chiffres de colonnes...}
  {***DÇplacement Vertical}
 Y:=0;YDir:=1;
 Repeat
  Inc(Y,YDir);If(Y<=0)or(Y>=NmYTxts*16)Then YDir:=-YDir;
  SetVerticalScale(Y);
 Until KeyPress;
 ReadKey;
  {***DÇplacement Horizontal***}
 X:=0;XDir:=1;
 Repeat
  Inc(X,XDir);If(X<=0)or(X>=NmXTxts*9)Then XDir:=-XDir;
  SetHorizontalScale(X);
 Until KeyPress;
 ReadKey;
  {***DÇplacement bidimensionnel***}
 Repeat
  Inc(X,XDir);If(X<=0)or(X>=NmXTxts*9)Then XDir:=-XDir;
  Inc(Y,YDir);If(Y<=0)or(Y>=NmYTxts*16)Then YDir:=-YDir;
  SetVerticalScale(Y);SetHorizontalScale(X);
 Until KeyPress;
 ReadKey;
  {***Superposition de page***}
 FillBox(0,0,159,49,'˛',$70);
 SetPg(1);
 FillBox(0,0,159,49,'-',7);
 For J:=0to 49do For I:=0to 15do PutTxtXYUnKr(10*I,J,Str(I));
 X:=0;XDir:=1;Y:=0;YDir:=1;I:=0;IDir:=1;
 Repeat
  Inc(X,XDir);Inc(Y,YDir);Inc(I,IDir);
  If(I<=0)or(I>=NmYTxts*16)Then IDir:=-IDir;
  If(X<=0)or(X>=NmXTxts*9)Then XDir:=-XDir;
  If(Y<=0)or(Y>=NmYTxts*16)Then YDir:=-YDir;
  SplitScreen(I);
  SetVerticalScale(Y);
  SetHorizontalScale(X);
 Until KeyPress;
 ReadKey;
End;

Procedure WormHole;Var Sens,Speed:Bool;J,I,Off:Word;Reg:Array[0..15]of Integer;
Var Handle:{Hdl}ExecHandle;PalT:Array[0..255]of RGB;Pal:Array[0..225]of RGB;

 Procedure ShiftDown;Var I:Byte;Begin
  For I:=0to 15-1do Reg[I]:=Pal[I+210].R;
  For I:=209downto 0do Pal[I+15].R:=Pal[I].R;
  For I:=0to 15-1do Pal[I].R:=Reg[I];
  For I:=0to 15-1do Reg[I]:=Pal[I+210].G;
  For I:=209downto 0do Pal[I+15].G:=Pal[I].G;
  For I:=0to 15-1do Pal[I].G:=Reg[I];
  For I:=0to 15-1do Reg[I]:=Pal[I+210].B;
  For I:=209downto 0do Pal[I+15].B:=Pal[I].B;
  For I:=0to 15-1do Pal[I].B:=Reg[I];
 End;

 Procedure ShiftLeft;Var LoopYX,I:Byte;Begin
  For I:=0to 15-1do Begin
   Reg[I]:=Pal[15*I].R;
   For LoopYX:=0to 14-1do Pal[15*I+LoopYX].R:=Pal[15*I+LoopYX+1].R;
   Pal[15*I+14].R:=Reg[I];
   Reg[I]:=Pal[15*I].G;
   For LoopYX:=0to 14-1do Pal[15*I+LoopYX].G:=Pal[15*I+LoopYX+1].G;
   Pal[15*I+14].G:=Reg[I];
   Reg[I]:=Pal[15*I].B;
   For LoopYX:=0to 14-1do Pal[15*I+LoopYX].B:=Pal[15*I+LoopYX+1].B;
   Pal[15*I+14].B:=reg[I]
  End;
 End;

 Procedure ShiftUp;Var I:Byte;Begin
  For I:=0to 15-1do Reg[I]:=Pal[I].R;
  For I:=15to 225-1do Pal[I-15].R:=Pal[I].R;
  For I:=0to 15-1do Pal[I+210].R:=reg[I];
  For I:=0to 15-1do Reg[I]:=Pal[I].G;
  For I:=15to 225-1do Pal[I-15].G:=Pal[I].G;
  For I:=0to 15-1do Pal[I+210].G:=reg[I];
  For I:=0to 15-1do reg[I]:=Pal[I].B;
  For I:=15to 225-1do Pal[I-15].B:=Pal[I].B;
  For I:=0to 15-1do Pal[I+210].B:=Reg[I];
 End;

 Procedure ShiftRight;Var LoopYX,I:Byte;Begin
  For I:=0to 15-1do Begin
   Reg[I]:=Pal[15*I+14].R;
   For loopyx:=14downto 1do Pal[15*I+Loopyx].R:=Pal[15*I+loopyx-1].R;
   Pal[15*I].R:=reg[I];
   reg[I]:=Pal[15*I+14].G;
   For loopyx:=14downto 1do Pal[15*I+loopyx].G:=Pal[15*I+loopyx-1].G;
   Pal[15*I].G:=reg[I];
   reg[I]:=Pal[15*I+14].B;
   For loopyx:=14downto 1do Pal[15*I+loopyx].B:=Pal[15*I+loopyx-1].B;
   Pal[15*I].B:=reg[I]
  End;
 End;

Begin
 SetVideoModeDeluxe(vmGrf320x200c256);
 SetPalBlk(1,225);
 If Not ExecOpen('RESOURCE\INTRO\WORMHOLE.GFX',Handle)Then ErrMsgOk('Fichier WORMHOLE.GFX introuvable!')
  Else
 Begin
  _ExecGetAbsRec(Handle,0,64000,Mem[_A000:0]);
  _ExecGetAbsRec(Handle,64000,SizeOf(PalT),PalT);
  ExecClose(Handle);
  MoveLeft(PalT[1],Pal,SizeOf(Pal));
  SetPalRGB(PalT,0,256);
  Sens:=No;Speed:=Ya;
  Repeat
   If(KeyPress)Then Begin
    Case(ReadKey)of
     kbF1:Sens:=Not(Sens);
     kbF2:Speed:=Not(Speed);
     Else Break;
    End;
   End;
   If(Sens)Then Begin
    ShiftDown;
    ShiftLeft;
   End
    Else
   Begin
    ShiftUp;
    ShiftRight;
   End;
   WaitRetrace;
   If Not(Speed)Then WaitRetrace;
   SetPalRGB(Pal,1,225);
  Until No;
  ClrKbd;
 End;
End;

Procedure Plasma;Var D:Palette256RGB;Temp:RGB;Handle:ExecHandle;Begin
 SetVideoModeDeluxe(vmGrf320x200c256);
 If Not ExecOpen('RESOURCE\INTRO\PLASMA1.GFX',Handle)Then ErrMsgOk('Fichier PLASMA.GFX introuvable!')
  Else
 Begin
  _ExecGetAbsRec(Handle,0,64000,Mem[_A000:0]);
  _ExecGetAbsRec(Handle,64000,SizeOf(D),D);
  ExecClose(Handle);
  Repeat
   Temp:=D[0+1];
   MoveLeft(D[1+1],D[0+1],768-3-3);
   D[255]:=Temp;
   SetPalRGB(D,0,255);
   WaitRetrace;
  Until KeyPress;
  ReadKey;
 End;
End;

Const
 inAll=$F101;
 inBoule=$F102;
 inCAO=$F103;
 inIle=$F104;
 inMaxScreen=$F105;
 inEcoule=$F106;
 inFlames=$F107;
 inMessage=$F108;
 inCopper=$F109;
 inPlasma=$F10A;
 inStar=$F10B;
 inStar3D=$F10C;
 inWormHole=$F10D;
 in3DEmpty=$F10E;
 in3DFull=$F10F;
 inTestScroll=$F110;
 inExit=$F1FF;

Var TM:MainMnuPtr;K:Wd;

BEGIN
 Randomize;{initialise le gÇnÇrateur de nombres alÇatoires }
 InitSystems(suIsabel);
 InitExecVolume;
 SetVideoModeDeluxe(vmTxtDef);
 InitEnv;
 PMInit;
 PMAddMnu('');
 PMAddItemKey('^T^ous les DEMOS',kbNoKey,inAll,'ExÇcute tous les dÇmonstrateurs de cette liste');
 PMAddItemKey('^D^essin avec le "DRAW" du BASIC',kbNoKey,inBoule,'Simple dessin de'+
                              'boule dessin Ö l''aide de l''instruction "DRAW"...');
 PMAddItemKey('^C^AO avec le "DRAW" du BASIC',kbNoKey,inCAO,'Exemple d''utilisation '+
                                                            'de l''instruction "DRAW" pour faire du CAO');
 PMAddItemKey('^A^nimation avec "DRAW" du BASIC',kbNoKey,inIle,'Exemple d''animation avec l''instruction "DRAW" du BASIC');
 PMAddItemKey('DÇfilement de te^x^te',kbNoKey,inTestScroll,'Montre des dÇfilements de texte en superposition...');
 PMAddItemKey('êcran ^M^aximum',kbNoKey,inMaxScreen,'Affichage de 360x480 pixels en 256 couleurs en VGA sans avoir de SVGA');
 PMAddItemKey('êco^u^lement',kbNoKey,inEcoule,'Fait un Çcoulement de l''Çcran');
 PMAddItemKey('^F^lames brñlantes',kbNoKey,inFlames,'Effet spÇciaux de flames brñlantes');
 PMAddItemKey('DÇfilement de pixel ^s^inusoãdale',kbNoKey,inMessage,'C''est un simple '+
                                              'dÇfilement de texte en pixel sinusoãdale');
 PMAddItemKey('C^o^pper',kbNoKey,inCopper,'Des barres se promenant Ö l''Çcran');
 PMAddItemKey('^P^lasma',kbNoKey,inPlasma,'Effets de plasma');
 PMAddItemKey('^W^ormHole',kbNoKey,inWormHole,'Animation d''un trou noir');
 PMAddItemKey('DÇfilement horizontal d''Çtoil^e^',kbNoKey,inStar,'Effectue un dÇfilement Ö l''Çcran sur l''axe horizontal');
 PMAddItemKey('DÇfilement 3 dimensions d''Çtoile',kbNoKey,inStar3d,'Effectue un dÇfilement Ö l''Çcran en 3 dimensions');
 PMAddItemKey('^3^ Dimensions en file de fer',kbNoKey,in3DEmpty,'Effectue des animations en 3 dimensions en file de fer');
 PMAddItemKey('3 Dimensions ^p^lein',kbNoKey,in3DFull,'Effectue des animations en 3 dimensions avec les images remplis');
 PMAddItemKey('^Q^uitter',kbNoKey,inExit,'Quitter l''Intro!!!');
 RBSetPtr(MainMenu.Mnu,0);
 TM:=_RBGetCurrBuf(MainMenu.Mnu);
 Repeat
  __InitMouse;
  PutTxtCenter(0,__Justified__,'Menu d''Intro',14);
  PutTxtXY(0,2,'Tous droits rÇservÇs par les Chevaliers de Malte 1995-1998',$C);
  K:=PMExecMnu(4,4,TM^.Lst,TM^.P);
  Case(K)of
   inAll:Begin
    Boule;CAO;Ile;TestScroll;MaxScreen(Ya);
    Flames;Message;Copper;Plasma;WormHole;
    Star;Star3D;_3D(Ya);_3D(No);
    SetVideoModeDeluxe(vmTxtDef)
   End;
   inBoule:Begin;Boule;SetVideoModeDeluxe(vmTxtDef)End;
   inCAO:Begin;CAO;SetVideoModeDeluxe(vmTxtDef)End;
   inIle:Begin;Ile;SetVideoModeDeluxe(vmTxtDef)End;
   inMaxScreen:Begin;MaxScreen(No);SetVideoModeDeluxe(vmTxtDef)End;
   inEcoule:Begin;MaxScreen(Ya);SetVideoModeDeluxe(vmTxtDef)End;
   inFlames:Begin;Flames;SetVideoModeDeluxe(vmTxtDef)End;
   inMessage:Begin;Message;SetVideoModeDeluxe(vmTxtDef)End;
   inCopper:Begin;Copper;SetVideoModeDeluxe(vmTxtDef)End;
   inPlasma:Begin;Plasma;SetVideoModeDeluxe(vmTxtDef)End;
   inWormHole:Begin;WormHole;SetVideoModeDeluxe(vmTxtDef);End;
   inStar:Begin;Star;SetVideoModeDeluxe(vmTxtDef)End;
   inStar3D:Begin;Star3D;SetVideoModeDeluxe(vmTxtDef)End;
   in3DEmpty:Begin;_3D(Ya);SetVideoModeDeluxe(vmTxtDef)End;
   in3DFull:Begin;_3D(No);SetVideoModeDeluxe(vmTxtDef)End;
   inTestScroll:Begin;TestScroll;SetVideoModeDeluxe(vmTxtDef)End;
   kbEsc,kbAltX:K:=inExit;
  End;
 Until K=inExit;
 DoneLuxeVideo;
 DoneExecVolume;
 DoneSystems;
END.