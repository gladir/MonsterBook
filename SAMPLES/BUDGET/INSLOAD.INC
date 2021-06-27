Const HexData : Array[0..15] of Char='0123456789ABCDEF';

Var Nom              : Pointer;
    Taille           : Pointer;
    Attribt          : Pointer;
    Heure            : Pointer;
    Date             : Pointer;

Procedure HauteCouleur(Couleur:Byte);
Begin
 Registre.AH := $0B;
 Registre.BH := $00;
 Registre.BL := Couleur;
 Intr($10,Registre);
End;

Function Hex2(Byt : Byte) : String2;
Begin
 Hex2 := HexData[Byt shr 4] + HexData[Byt and 15];
End;

Function Hex(Byt : Integer) : String4;
Begin
 Hex := HexData[(Byt Shr 12)and 15]+HexData[(Byt Shr 8)and 15]+HexData[(Byt Shr 4)and 15]+HexData[Byt and 15];
End;

Function SupressionRepertoire(Nom:String64) : Word;
Begin
 Nom := Nom + #0;
 Registre.AH := $3A;
 Registre.DS := Seg(Nom[1]);
 Registre.DX := Ofs(Nom[1]);
 MSDos(Registre);
 SupressionRepertoire := Registre.AX;
End;

Function CreationRepertoire(Nom:String64) : Word;
Begin
 Nom := Nom + #0;
 Registre.AH := $39;
 Registre.DS := Seg(Nom[1]);
 Registre.DX := Ofs(Nom[1]);
 MSDos(Registre);
 CreationRepertoire := Registre.AX;
End;

Function ChangeRepertoire(Nom:String64) : Word;
Begin
 Nom := Nom + #0;
 Registre.AH := $3B;
 Registre.DS := Seg(Nom[1]);
 Registre.DX := Ofs(Nom[1]);
 MSDos(Registre);
 ChangeRepertoire := Registre.AX;
End;

Function Volume(Drive:Char):String12;
Var Compteur       : Byte;
    OK             : Boolean;
    Chaine         : String[7];
    Cobaye         : String[12];

  Procedure Cross;
  Begin
   Ok:=(Registre.Flags and $0001)=0;
   If(OK)And((Mem[Registre.ES:Registre.BX+21] and $16)=8)Then
   Begin
    Compteur:=30;Cobaye := '';
    While(Mem[Registre.ES:Registre.BX+Compteur]<>0)do
    Begin
     Cobaye:=Cobaye+Chr(Mem[Registre.ES:Registre.BX+Compteur]);
     Compteur:=Compteur+1;
    End;
   End;
  End;

Begin
 Cobaye:='Aucun';
 Chaine := Drive+':\*.*'+#0;
 Registre.AH := $4E;
 Registre.CX := $FFFF;
 Registre.DS := Seg(Chaine[1]);
 Registre.DX := Ofs(Chaine[1]);
 MSDos(Registre);
 Registre.AH := $2F;
 MSDos(Registre);
 Cross;
 Repeat
  Registre.AH := $4F;
  MSDos(Registre);
  Cross;
 Until Not(Ok);
 Volume:=Cobaye;
End;

Function ChercherFichier(Chaine:String64;Attribut:Word;Titre:String255) : String64;
Label Start,Debut,10,Fin;
Var NombreFichier     : Word;
    CompteurB         : Word;
    Position          : Word;
    YCoordonne        : Word;
    RepertoireCourant : String[64];

    Procedure Fichiers(Chaine:String64;Attribut:Word);
    Var Compteur                   : Word;
	Position                   : Word;
	PositionNom                : 0..12;
	Correct                    : Boolean;
	Ecart,I,J,K,M              : LongInt;
	Sortie                     : Boolean;
	TemporaireNom              : String[12];
	TemporaireTaille           : LongInt;
	TemporaireAttribut         : Byte;
	TemporaireSeconde          : 0..59;
	TemporaireMinute           : 0..59;
	TemporaireHeure            : 0..23;
	TemporaireJour             : 1..31;
	TemporaireMois             : 1..12;
	TemporaireAnnees           : Byte;
	Segment                    : Word;
	OffSet                     : Word;

       Procedure Cross;
       Begin
	Correct:=(Registre.Flags and $0001)=0;
	If((Correct)And(Not((Mem[Segment:OffSet+21] and 31)=8))And
	   Not((MemW[Segment:OffSet+30]=$2E)))Then
	Begin
	 Mem[Seg(Attribt^):Ofs(Attribt^)+Position] := MemW[Segment:OffSet+21];
	 MemW[Seg(Heure^):Ofs(Heure^)+Position]    := MemW[Segment:OffSet+22];
	 MemW[Seg(Date^):Ofs(Date^)+Position]      := MemW[Segment:OffSet+24];
	 MemL[Seg(Taille^):Ofs(Taille^)+Position*4]:= (MemW[Segment:OffSet+26])+(Mem[Segment:OffSet+28])*65536;
	 For PositionNom := 0 to 11 do Mem[Seg(Nom^):Ofs(Nom^)+Position*12+PositionNom] := 0;
	 Compteur                                  := 30;
	 PositionNom                               := 0;
	 While(Ord(Mem[Segment:OffSet+Compteur])<>0)do
	 Begin
	  If((Mem[Segment:OffSet+Compteur]=46)And(PositionNom<8)And
	     (Mem[Seg(Attribt^):Ofs(Attribt^)+Position] and 31<>16))Then
	  Begin
	   PositionNom := 8;
	  End;
	  Mem[Seg(Nom^):Ofs(Nom^)+Position*12+PositionNom] := Mem[Segment:OffSet+Compteur];
	  Compteur := Compteur + 1; PositionNom := PositionNom + 1;
	 End;
	 If((Mem[Seg(Nom^):Ofs(Nom^)+Position*12+11]=178)or
	   (Mem[Seg(Attribt^):Ofs(Attribt^)+Position] and 31=16))Then Position := Position + 1;
	End;
       End;

    Begin
     Chaine := Chaine+#0;
     Position := 1;
     Registre.AH := $4E;
     Registre.CX := Attribut;
     Registre.DS := Seg(Chaine[1]);
     Registre.DX := Ofs(Chaine[1]);
     MSDos(Registre);
     Registre.AH := $2F;
     MSDos(Registre);
     Segment := Registre.ES;
     OffSet  := Registre.BX;
     Cross;
     Repeat
      Registre.AH := $4F;
      MSDos(Registre);
      Segment := Registre.ES;
      OffSet  := Registre.BX;
      Cross;
     Until Not(Correct);
     NombreFichier := Position -1;
    End;

    Procedure AfficheLigne(YCoordonne:Byte;Position:Word);
    Begin
     Str(Position-1:2,Chaine);
     EcritUnCaractere(16,YCoordonne+8,0,63);
     Localise(14,YCoordonne+8);
     Ecrit(Chaine,59);
     EcritUnCaractere(17,YCoordonne+8,179,63);
     If(NombreFichier>=Position)Then
     Begin
      EcritUnCaractere(18,YCoordonne+8,0,63);
      For CompteurB := 0 to 7 do
       EcritUnCaractere(CompteurB+19,YCoordonne+8,Mem[Seg(Nom^):Ofs(Nom^)+Position*12+CompteurB],59);
      EcritUnCaractere(27,YCoordonne+8,0,63);
      For CompteurB := 9 to 10 do
       EcritUnCaractere(CompteurB+18,YCoordonne+8,Mem[Seg(Nom^):Ofs(Nom^)+Position*12+CompteurB],59);
      EcritUnCaractere(31,YCoordonne+8,0,63);
      EcritUnCaractere(30,YCoordonne+8,0,63);
      EcritUnCaractere(29,YCoordonne+8,0,63);
     End;
     EcritUnCaractere(32,YCoordonne+8,179,63);
     If(NombreFichier>=Position)Then
     Begin
      EcritUnCaractere(33,YCoordonne+8,0,63);
      If(MemW[Seg(Nom^):Ofs(Nom^)+Position*12]=$2E2E)Then
      Begin
       Localise(34,YCoordonne+8);
       Ecrit('Sous-Rep',62);
      End
       else
      If((Mem[Seg(Attribt^):Ofs(Attribt^)+Position] and 31)=16)Then
      Begin
       Localise(34,YCoordonne+8);
       Ecrit(' Sur-Rep',62);
      End
       else
      Begin
       Str(MemL[Seg(Taille^):Ofs(Taille^)+Position*4]:9,Chaine);
       Localise(33,YCoordonne+8);
       Ecrit(Chaine,59);
      End;
      EcritUnCaractere(42,YCoordonne+8,0,63);
     End;
     EcritUnCaractere(43,YCoordonne+8,179,63);
     If(NombreFichier>=Position)Then
     Begin
      EcritUnCaractere(44,YCoordonne+8,0,63);
      Str(((MemW[Seg(Date^):Ofs(Date^)+Position*2] and $FE00)shr 12)+1980,Chaine);
      Localise(45,YCoordonne+8);
      Ecrit(Chaine+SeparateurDate,59);
      Str((MemW[Seg(Date^):Ofs(Date^)+Position*2] and $01E0)shr 5,Chaine);
      If(Length(Chaine)<2)Then Chaine := '0' + Chaine;
      Localise(50,YCoordonne+8);
      Ecrit(Chaine+SeparateurDate,59);
      Str((MemW[Seg(Date^):Ofs(Date^)+Position*2] and $001F),Chaine);
      If(Length(Chaine)<2)Then Chaine := '0' + Chaine;
      Localise(53,YCoordonne+8);
      Ecrit(Chaine,59);
      EcritUnCaractere(55,YCoordonne+8,0,63);
     End;
     EcritUnCaractere(56,YCoordonne+8,179,63);
     If(NombreFichier>=Position)Then
     Begin
      EcritUnCaractere(57,YCoordonne+8,0,63);
      Localise(58,YCoordonne+8);
      Str((MemW[Seg(Heure^):Ofs(Heure^)+Position*2] and $ED00)shr 11,Chaine);
      If(Length(Chaine)<2)Then Chaine := '0' + Chaine;
      Ecrit(Chaine+':',59);
      Localise(61,YCoordonne+8);
      Str((MemW[Seg(Heure^):Ofs(Heure^)+Position*2] and $01D0)shr 5,Chaine);
      If(Length(Chaine)<2)Then Chaine := '0' + Chaine;
      Ecrit(Chaine+':',59);
      Localise(64,YCoordonne+8);
      Str((MemW[Seg(Heure^):Ofs(Heure^)+Position*2] and $001E)*2,Chaine);
      If(Length(Chaine)<2)Then Chaine := '0' + Chaine;
      Ecrit(Chaine,59);
     End;
    End;

    Procedure Descend;
    Begin
     If(Position<NombreFichier)Then
     Begin
      Inc(Position);
      If(YCoordonne < 12)Then Inc(YCoordonne)
       else
      Begin
       InLine($B8/$01/$06/
	      $B7/$5E/
	      $B1/$0E/
	      $B5/$09/
	      $B2/$41/
	      $B6/$14/
	      $CD/$10);
       AfficheLigne(YCoordonne,Position);
      End;
     End;
    End;

    Procedure Monte;
    Begin
     If(Position>1)Then
     Begin
      Dec(Position);
      If(YCoordonne>1)Then Dec(YCoordonne)
       else
      Begin
       InLine($B8/$01/$07/
	      $B7/$5E/
	      $B1/$0E/
	      $B5/$09/
	      $B2/$41/
	      $B6/$14/
	      $CD/$10);
       AfficheLigne(YCoordonne,Position);
      End;
     End;
    End;

Begin
 InLine($B4/$01/
	$B1/$07/
	$B5/$08/
	$CD/$10);
 RepertoireCourant := Chaine;
 If(Length(RepertoireCourant)=3)Then Delete(RepertoireCourant,Length(RepertoireCourant),1);
 RepertoireCourant := RepertoireCourant + '\*.*';
 Move(Mem[$B800:$00],Tableau[4]^,4000);
 Start : Fichiers(RepertoireCourant,Attribut);
 CadrePlain(10,0,69,24,63,1);
 CentreEcriture(3,Titre,62);
 Localise(14,5);
 Ecrit('Nom du Repertoire :',63);
 Localise(14,7);
 Ecrit(RepertoireCourant,59);
 EcritUnCaractere(12,8,204,63);
 ChaineRepetitiveCaractere(13,8,205,63,54,0,0);
 EcritUnCaractere(17,8,209,63);
 EcritUnCaractere(32,8,209,63);
 EcritUnCaractere(43,8,209,63);
 EcritUnCaractere(56,8,209,63);
 EcritUnCaractere(67,8,185,63);
 EcritUnCaractere(12,21,204,63);
 ChaineRepetitiveCaractere(13,21,205,63,54,0,0);
 EcritUnCaractere(17,21,207,63);
 EcritUnCaractere(32,21,207,63);
 EcritUnCaractere(43,21,207,63);
 EcritUnCaractere(56,21,207,63);
 EcritUnCaractere(67,21,185,63);
 For Compteur := 1 to 12 do
 Begin
  AfficheLigne(Compteur,Compteur);
 End;
 YCoordonne := 1; Position := 1;
 Debut : For CompteurB := 0 to 51 do Mem[AdresseEcran:(14+CompteurB+(YCoordonne+8)*Colonne)*2+1] := 94;
	 Touche := LitClavier;
	 If(Not(
	    ((Hi(Touche)=72)and(YCoordonne=1)and(Position=1))or
	    ((Hi(Touche)=80)and(YCoordonne=12)and(Position=NombreFichier))
	    ))Then AfficheLigne(YCoordonne,Position);
	 Case Hi(Touche) of
	  72 : Monte;
	  80 : Descend;
	 End;
	 Case Lo(Touche) of
	  13 : Begin
		If(MemW[Seg(Nom^):Ofs(Nom^)+Position*12]=$2E2E)Then
		Begin
		 Delete(RepertoireCourant,Length(RepertoireCourant)-3,4);
		 While(RepertoireCourant[Length(RepertoireCourant)]<>'\') do
		 Begin
		  Delete(RepertoireCourant,Length(RepertoireCourant),1);
		 End;
		 RepertoireCourant := RepertoireCourant + '*.*';
		 Goto Start;
		End
		 else
		If((Mem[Seg(Attribt^):Ofs(Attribt^)+Position] and 31)=16)Then
		Begin
		 Delete(RepertoireCourant,Length(RepertoireCourant)-2,3);
		 If(RepertoireCourant[Length(RepertoireCourant)]<>'\')Then
		 Begin
		  RepertoireCourant := RepertoireCourant + '\';
		 End;
		 For CompteurB := 0 to 7 do
		 Begin
		  If(Mem[Seg(Nom^):Ofs(Nom^)+Position*12+CompteurB]>0)Then
		  Begin
		   RepertoireCourant := RepertoireCourant + Chr(Mem[Seg(Nom^):Ofs(Nom^)+Position*12+CompteurB]);
		  End;
		 End;
		 If(Length(RepertoireCourant)=3)Then Delete(RepertoireCourant,Length(RepertoireCourant),1);
		 RepertoireCourant := RepertoireCourant + '\*.*';
		 Goto Start;
		End
		 else
		Begin
		 Delete(RepertoireCourant,Length(RepertoireCourant)-2,3);
		 If(RepertoireCourant[Length(RepertoireCourant)]<>'\')Then
		 Begin
		  RepertoireCourant := RepertoireCourant + '\';
		 End;
		 For CompteurB := 0 to 11 do
		 Begin
		  If(Mem[Seg(Nom^):Ofs(Nom^)+Position*12+CompteurB]>0)Then
		  Begin
		   RepertoireCourant := RepertoireCourant + Chr(Mem[Seg(Nom^):Ofs(Nom^)+Position*12+CompteurB]);
		  End
		   else
		  Begin
		   RepertoireCourant := RepertoireCourant + ' ';
		  End;
		 End;
		 Goto Fin;
		End;
	       End;
	 End;
	 If(Lo(Touche)<>27)Then Goto Debut;
 Fin   : Move(Tableau[4]^,Mem[$B800:$00],4000);
 InLine($B4/$01/
	$B1/$07/
	$B5/$06/
	$CD/$10);
 If(Lo(Touche) = 27)Then
 Begin
  ChercherFichier := 'Escape';
 End
  else
 ChercherFichier := RepertoireCourant;
 Touche := 0;
End;

