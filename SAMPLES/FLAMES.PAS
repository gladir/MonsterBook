Program Flames;
{$I ..\DEF.INC}
Uses {$IFDEF Adele}Adele{$ELSE}Chantal{$ENDIF},Systex,Systems,Video;
Type Block=Array[0..99,0..319]of Byte;
Var SrcFrame,DestFrame:^Block;

{fait d‚filer l'image d'une ligne vers le haut et interpole}
Procedure ScrollUp;Assembler;ASM
 PUSH DS
  LES DI,DestFrame     {pointeur sur image de destination }
  LDS SI,SrcFrame      {pointeur sur image source }
  ADD SI,320            {ligne 1 de l'image source }
  MOV CX,320*98         {fait d‚filer 99 lignes }
  XOR BL,BL             {octet de poids fort fant“me }
@lp1:
  XOR AX,AX
  XOR BX,BX
  MOV AL,[SI-321]       {cherche le premier point }
  MOV BL,[SI-320]       {ajoute le deuxiŠme }
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
  OR AX,AX              {d‚j… 0 ?}
  JE @null
  DEC AL                {si non, d‚cr‚menter}
@null:
  STOSB                 {valeur en destination }
  INC SI                {point suivant }
  DEC CX                {autres points ?}
  JNE @lp1
 POP DS
END;

{reconstruit les lignes inf‚rieures }
Procedure NewLine;Var I,X:Word;Begin
 For X:=0to 319do Begin {remplit 3 lignes avec des valeurs al‚atoires }
  DestFrame^[97,X]:=Random(15)+64;
  DestFrame^[98,X]:=Random(15)+64;
  DestFrame^[99,X]:=Random(15)+64;
 End;
 For I:=0to Random(45)do Begin{ajoute un nombre al‚atoires de foyers br–lants }
  X:=Random(320);               {… des endroits au hasard }
  ASM
   LES DI,DestFrame   {adresse l'image de destination }
   ADD DI,98*320       {traite la ligne 98 (deuxiŠme du bas) }
   ADD DI,X            {ajoute l'abscisse x }
   MOV AL,0FFh         {couleur la plus claire }
   MOV ES:[DI-321],AL  {produit un foyer br–lant de grande taille (9 pixels)}
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

{copie l'‚cran dans la carte graphique pour permuter les pointeurs}
Procedure ShowScreen;Var T:Pointer;Begin
 MoveLeft(DestFrame^,Mem[$A000:320*100],320*100);
 T:=DestFrame;DestFrame:=SrcFrame;SrcFrame:=T;{‚change les pointeurs sur source et destination}
End;

{pr‚pare la palette pour Flames }
Procedure PrepPal;Var I:Word;Palette:Array[0..767]of Byte;Begin
 FillClr(Palette,80*3);       {Au d‚but: tout noir }
 For I:=0to 7do Begin
  Palette[I*3+2]:=I*4;        {Couleurs 0-7: bleu croissant}
  Palette[(I+8)*3+2]:=64-I*4; {Couleurs 8-15: bleu d‚croissant}
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

BEGIN
 InitSystems(suIsabel);
 Randomize;{initialise le g‚n‚rateur de nombres al‚atoires }
 SrcFrame:=MemNew(320*100);DestFrame:=MemNew(320*100);
 SetVideoMode(vmGrf320x200c256);
 PrepPal;     {pr‚pare la palette}
 Repeat
  ScrollUp;   {flammes montantes}
  NewLine;    {ajoute une nouvelle ligne en bas}
  ShowScreen; {affiche l'‚cran}
  WaitRetrace;
 Until KeyPress;
 SetVideoMode(vmTxtDef);
 DoneSystems;
END.