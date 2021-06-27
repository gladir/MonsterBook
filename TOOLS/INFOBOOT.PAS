Program BootFatDir;

Uses Dos;

Const

 Root=True;
 NoRoot=False;
 TailleSect=512; { Nombre d'octets d'un secteur }

Type

 Str12=String[12];

  { Pour stocker les paramŠtres lus dans le l'enregistrement Boot
    "BR"=Boot Record, "ofs"=Offset }

 ParamDisque=Record
  BytesPSecteur:Word; { Ofs 11 du BR, 2 octets }
  SectsPCluster:Byte; { Ofs 13 du BR, 1 octet }
  SectsReserves:Word; { Ofs 14 du BR, 2 octets }
  NbrDeFats:Byte;     { Ofs 16 du BR, 1 octet }
  MaxEntrees:Word;    { Ofs 17 du BR, 2 octets }
  RawTotSects:Word;   { Ofs 19 du BR, 2 octets }
  Media:Byte;         { Ofs 21 du BR, 1 octet }
  SectsPFat:Word;     { Ofs 22 du BR, 2 octets }
  SectsPPiste:Word;   { Ofs 24 du BR, 2 octets }
  NbrTetes:Word;      { Ofs 26 du BR, 2 octets }
  TotSects:LongInt;   { Total de Secteur }
  PremFat:Word;       { Premier secteur de la FAT, calcul‚ }
  PremRoot:Word;      { Premier secteur du r‚pertoire, calcul‚ }
  SectsPRoot:Word;    { Nombre de secteur du r‚pertoire, calcul‚ }
  PremData:Word;      { Premier secteur des fichiers, calcul‚ }
  TotPistes:Word;     { Nombre de pistes, calcul‚ }
  TotClusters:Word;   { Nombre de clusters (pour les fichiers) }
  BitsdeFat:Byte;     { Nombre de bits d'un ‚l‚ment de la FAT }
 End; { Param Disque }

 FatRec=Array[0..65520]of Byte;

Var

 Disque:Byte; { Num‚ro du disque }
 Params:ParamDisque; { ParamŠtres du disque }

  { En fonction du niveau du r‚pertoire, doit ˆtre global }
 Indent:String[80];

  { Copie de la FAT en m‚moire }
 FAT:^FatRec;

Var Data:Record LSN:LongInt; Sects:Word; Buffer:Pointer; End;

Procedure Int25h(Drive:Byte;LSN,Sects:Word;Var Buffer;Var Erreur:Word);
Assembler;
Const __POPF = $9D;
ASM
 PUSH BP;
 PUSH DS;
  MOV AL,Drive;
  MOV DX,LSN;
  MOV CX,Sects;
  LDS BX,Buffer;
  INT $25;
  JB  @@Suite;
  XOR AX,AX;
@@Suite:
  DB __POPF;
 POP DS;
 POP BP;
 LES DI,Erreur;
 MOV ES:[DI],AX;
 CMP AX,519;
 JNE @@No32Bits;
 PUSH BP;
 PUSH DS;
  MOV AL,Drive;
  MOV DX,LSN;
  MOV CX,Sects;
  MOV BX,Offset Data;
  MOV DS:[BX],DX;
  MOV DS:[BX+2].Word,0;
  MOV DS:[BX+4],CX;
  LES DI,Buffer;
  MOV DS:[BX+6],DI;
  MOV DS:[BX+8],ES;
  MOV CX,$FFFF;
  INT $25;
  JB  @@Suite2;
  XOR AX,AX;
@@Suite2:
  DB __POPF;
 POP DS;
 POP BP;
 LES DI,Erreur;
 MOV ES:[DI],AX;
@@No32Bits:
End;

Function Char2EnWord(a,b:char):Word;
Begin
 Char2EnWord := (Byte(b) * 256) + Byte(a); { Inversion des octets...}
End;

Procedure LitBootRecord(drive:Byte);
Var
 Erreur:Word;
 Buffer:Array[0..TailleSect] of Char; { Buffer pour Int25h }
 TempLong:LongInt;
Begin
 {Lecture de secteur … partir du secteur 0}
 Int25h(drive,0,1,Buffer,Erreur);
 If(Erreur<>0)Then
 Begin
  WriteLn('Erreur de lecture sur le secteur BOOT');
  Halt;
 End;
 With Params do
 Begin
  Move(Buffer[11],Params,17);
  If RawTotSects=0Then Move(Buffer[$20],TotSects,4)
		  Else TotSects:=RawTotSects;
  If BytesPSecteur=0Then BytesPSecteur:=512;
  If NbrDeFats=0Then NbrDeFats:=2;
  PremFat       := SectsReserves;
  PremRoot      := SectsReserves + (NbrDeFats*SectsPFat);
  SectsPRoot    := (MaxEntrees*32) div BytesPSecteur;
  If(((MaxEntrees*32) mod BytesPSecteur)<>0)Then Inc(SectsPRoot);
  PremData := PremRoot + SectsPRoot;
  TempLong := LongInt(TotSects) div (LongInt(NbrTetes)*LongInt(SectsPPiste));
  TotPistes := TempLong;
  If(TempLong-TotPistes > 0)Then Inc(TotPistes);
  TempLong := (LongInt(TotSects)-LongInt(PremData)) div LongInt(SectsPCluster);
  TotClusters := TempLong;
  If RawTotSects=0Then BitsDeFat:=32 Else
  If(RawTotSects>4086)Then BitsDeFat:=16
		      Else BitsDeFat:=12;
 End; { With Params }
End; {LitBootRecord}

Procedure LitFat(Drive,PremierSect,NbrSect:Word);
Var I,J,Erreur,Secteur:Word;
    Buffer:Array[0..TailleSect] of Char; { Buffer pour Int25h }
Begin
 Secteur:=PremierSect; I:=0; J:=0;
 GetMem(Fat,NbrSect*512);
 While(I<NbrSect)do
 Begin
  Int25h(drive,Secteur,1,Buffer,Erreur);
  If(Erreur<>0)Then
  Begin
   WriteLn('Erreur de lecture de la FAT');
   Halt;
  End;
  Move(Buffer,Fat^[J],512);
  Inc(J,512);
  Inc(Secteur);
  Inc(I);
 End; { While I }
End; { LitFat }

Procedure AfficheDiskParams;
Begin
 { Affiche, '\' = r‚pertoire principal...}
 With Params do
 Begin
  WriteLn('Nombre d''octets par secteur:',BytesPSecteur);
  WriteLn('Nombre de secteurs par cluster:',SectsPCluster);
  WriteLn('Nombre de secteurs r‚serv‚s:',SectsReserves,' (pour le Secteur Boot)');
  WriteLn('Nombre de FATs:',NbrDeFats);
  WriteLn('Nombre d''entr‚es dans le "\":',MaxEntrees);
  WriteLn('Nombre total de secteurs:',TotSects);
  WriteLn('Nombre de secteurs par piste:',SectsPPiste);
  WriteLn('Nombre de tˆtes (faces):',NbrTetes);
  WriteLn('Premier secteur de la FAT:',PremFat);
  WriteLn('Premier secteur de "\":',PremRoot);
  WriteLn('Nombre de secteur de "\":',SectsPRoot);
  WriteLn('Premier secteur des fichiers:',PremData);
  WriteLn('Nombre de pistes (cylindres):',TotPistes);
  WriteLn('Nombre de clusters (pour fichiers):',TotClusters);
  WriteLn('Longueur des ‚l‚ments de la FAT:',BitsDeFat,' bits');
  WriteLn;
  Case Byte(Media) of
   $FF: WriteLn(' --> Disquette double face, 8 secteurs/piste');
   $FE: WriteLn(' --> Disquette simple face, 8 secteurs/piste');
   $FD: WriteLn(' --> Disquette double face, 9 secteurs/piste');
   $FC: WriteLn(' --> Disquette simple face, 9 secteurs/piste');
   $F9: WriteLn(' --> Disquette double face, 15 secteurs/piste');
   $F8: WriteLn(' --> Disque dur');
  End;
 End; { With Params }
End; { AfficheDiskParams }

Function ElSuivantDeFat(cluster:Word):Word;
Var El,Temp:Word;
Begin
 El:=0;
 If Params.BitsDeFat in[16,32]Then Move(Fat^[Cluster shl 1],el,2)
  Else
 Begin
  Temp:=3*Cluster;
  Move(Fat^[Temp shr 1],el,2); { SHR = /2 }
  If(Odd(Cluster))Then { Cluster impaire ? }
  Begin
   El:=El and $FFF0; { On supprime le dernier signe hexa }
   El:=El shr 4;
  End
   Else { Cluster Pair }
  El:=El and $0FFF; { On supprime le premier signe hexa }
 End;
 ElSuivantDeFat:=El;
End;

Procedure LitRepertoire(Drive,PremierSect,NbrSect:Word;RootDir:Boolean;Masque:Str12);
Const
 Normal=0;      { Attribut normal }
 Lecture=1;     { Attribut lecture seulement }
 Cache=2;       { Attribut cach‚ }
 Systeme=4;     { Attribut systŠme }
 Volume=8;      { Attribut Nom de Volume }
 Repertoire=16; { Attribut R‚pertoire }
Type
 { D‚tail d'un des ‚l‚ments de 32 bits du r‚pertoire }
 EntreeRepert=Record
  NomFichier:Array[1..8] of Char;
  ExtFichier:Array[1..3] of Char;
  AttFichier:Byte; { Attribut }
  Rien:Array[1..10] of Char;
  Heure,Date:Word;
  PremCluster:Word;
  Time:LongInt;
 End;
Var
 TempLong:LongInt;
 FinList:Boolean;
 Erreur,i,j,k,l:Word;
 Secteur:Word; { Num‚ro du secteur … lire }
 Buffer:Array[0..TailleSect] of Char; { Tampon pour Int25h }
 UnElement:EntreeRepert; { Contient les 32 ‚l‚ments du r‚pertoire }
 Sdc:Byte; { Num‚ro de secteur dans un cluster }
 Choix:Str12;

 Procedure Mask(Var Masque:Str12);
 Type Str3=String[3]; Str8=String[8];
 Var Etoile,point,k:Byte; Nom:Str8; Ext:Str3;
 Begin
  For k:=1to Length(Masque)do Masque[k]:=UpCase(Masque[k]);
  Nom:='????????'; Ext:='???'; Point:=Pos('.',Masque);
   {Analyse l'extension }
  If Point<>0Then
  Begin
   Ext := Copy(Masque,Point+1,Length(Masque)-Point);
    { Pour '*.' --> '*.   ' }
   If Ext=''Then Ext:='   ';
    { ComplŠte si moins de 3 caractŠres }
   Ext:=Ext+'???';
    { S'il y a une ‚toile }
   Etoile:=Pos('*',Ext);
   If Etoile<>0Then { Tous des '?' … partir de l'‚toile }
   For k:=etoile to 3do Ext[k]:='?';
    {Point=derniŠre position du nom}
   Dec(Point);
  End
   Else
  Point := Length(Masque); { Simule le point }
   { Analyse le nom: }
  Nom:=Copy(Masque,1,Point)+Nom;
  Etoile:=Pos('*',Nom);
  If(Etoile<>0)Then For k:=Etoile to 8do Nom[k]:='?';
   { Pr‚pare le masque que l'on renvoie modifi‚:}
  Move(Nom[1],Masque[1],8);
  Masque[9]:='.';
  Move(Ext[1],Masque[10],3);
  Masque[0]:=#12;
 End;

Begin
 If(RootDir)Then Mask(Masque); { On analyse le masque qu'une seule fois }
  { Affiche un titre }
 WriteLn;
 WriteLn(Indent,'FICHIER  EXT PremC  Taille  date heure NBClu Attribut');
 WriteLn(Indent,'======== === ====== ======= ==== ===== ===== ========');
  {"Secteur" contient le secteur … lire et analyser ensuite }
 Secteur:=PremierSect; Sdc:=0; i:=0;
 While (i<NbrSect) do { Parcours de tous les secteurs du r‚pertoire }
 Begin
  { Lit un secteur:}
  Int25h(Drive,Secteur,1,Buffer,Erreur);
  If Erreur<>0Then
  Begin
   WriteLn('Erreur de lecture du r‚pertoire');
   Halt;
  End;
  j:=0;
  While j<512do
   { D‚coupe le secteur en unit‚s de 32 octets }
   { Pour d‚coder les informations des fichiers }
  Begin
   Move(Buffer[j],UnElement,32);
   With UnElement do
   Begin
    Choix:=NomFichier+'.'+ExtFichier;
    For k:=1to 12do If Masque[k]='?'Then Choix[k]:='?';
    If NomFichier[1]<>#0Then {=0 alors entr‚e du r‚pertoire vierge...}
    Begin
     k:=0; { k compte le nombre de clusters }
     l:=PremCluster;
     Repeat
       {Consulte la FAT et calcule le nombre de clusters d'un fichier ou r‚pertoire }
      l:=ElSuivantDeFat(l);
      If l=0Then FinList:=True { cas d'un fichier effac‚ }
       Else
      Begin
       Inc(k);
       If Params.BitsDeFat in[16,32]Then { $FFF8 est un nombre trop grand, et donc }
	finlist:=(l shr 4=$FFF)and(l and$F>=8)
       Else finlist:=l>=$FF8;
      End;
     Until FinList;
     {maintenant k=Nombre de clusters}
     If(choix=masque)or(attFichier=Repertoire)Then
     Begin
      Write(Indent);
      Write(NomFichier,' ',extfichier,' ',PremCluster:5,' ',Time:7);
      Write(k:5,' '); { nombre de clusters }
       { d‚code les attributs et affiche... }
       { Supprime les bits 8,7,6. }
      AttFichier:=AttFichier and 31; { 31=00011111 }
      If AttFichier=0Then Write('Archive ')
       Else
      Begin
       If AttFichier and Lecture<>0Then Write('Lecture seulement ');
       If AttFichier and Cache<>0Then Write('Cach‚ ');
       If AttFichier and Volume<>0Then Write('Volume ');
       If AttFichier and Systeme<>0Then Write('SystŠme ');
       If AttFichier and Repertoire<>0Then Write('<R‚pertoire>');
      End;
      If NomFichier[1]=#$E5Then { Code pour fichier effac‚ } Write(' Effac‚');
      WriteLn;
     End;
    End;
    With Params do { On consulte le sous-r‚pertoire }
    Begin
     If(AttFichier=Repertoire)and Not(NomFichier[1]in[#0,'.',' '])Then
     Begin
      Indent:=Indent+' ** '; { Augmente l'indentation }
      l := (PremCluster-2)*SectsPCluster+PremData;
       { Convertit premier cluster num‚ro de secteur }
      k := k*SectsPCluster; { Convertit nombre de clusters en nombre de secteurs }
      LitRepertoire(Drive,l,k,NoRoot,Masque);
       { Appel r‚cursif }
      Indent := Copy(Indent,1,Length(Indent)-4);
       { Diminue l'indentation }
     End;
    End;
   End;
   Inc(j,32);
  End;
  If(RootDir)Then Inc(Secteur)
   Else
  Begin { Dans un sous-r‚pertoire, il faut consulter la FAT, un sous- }
	{ r‚pertoire est trait‚ comme un fichier }
   With Params do
   Begin
    Inc(Sdc); { Num‚ro du secteur dans le cluster }
    If Sdc>SectsPCluster-1Then { On a lu le dernier secteur du cluster, }
			       { On change de cluster }
    Begin
     { On traduit secteur en cluster pour consultation de la FAT }
     k:=((LongInt(Secteur)-LongInt(PremData))div LongInt(SectsPCluster)+2);
     l:=ElSuivantDeFAT(k);
      { On traduit cluster en secteur }
     Secteur:=(l-2)*SectsPCluster+PremData;
     Sdc:=0; { R‚initialise … 0, c'est le premier secteur du cluster }
    End
     Else
    { On n'a pas lu le dernier secteur du cluster dans un cluster, les }
    { secteurs sont contignus }
    Inc(Secteur);
   End;
  End;
  Inc(I);
 End; { While I }
End; { LitRepertoire }

BEGIN
 Disque:=2;
 LitBootRecord(Disque);
 LitFat(Disque,Params.PremFat,Params.SectsPFat);
 LitRepertoire(Disque,Params.PremRoot,Params.SectsPRoot,True,'*.*');
 AfficheDiskParams;
 FreeMem(Fat,Params.SectsPFat*512);
END.