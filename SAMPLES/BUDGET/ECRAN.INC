(***************************************************************************)
(*                                                                         *)
(*                          Ecran II Version 2.00A                         *)
(*                                                                         *)
(*                          Copyright (C) 1990 par                         *)
(*                         Les Chavaliers de Malte                         *)
(*                                                                         *)
(***************************************************************************)

Function AdresseEcran:Word;
Begin
 If(Mem[$0044:$09] = $07)Then AdresseEcran := $B000
			 Else AdresseEcran := $B800;
End;

Function XPosition:Byte;
Begin
 Registre.AH := $03;
 Registre.BH := $00;
 Intr($10,Registre);
 XPosition := Registre.DL;
End;

Function YPosition:Byte;
Begin
 Registre.AH := $03;
 Registre.BH := $00;
 Intr($10,Registre);
 YPosition := Registre.DH;
End;

Function IndiqueEcran:Byte;
Begin
 Registre.AH := $0F;
 Intr($10,Registre);
 IndiqueEcran := Registre.AL;
End;

Procedure Localise(X,Y:Byte);
Begin
 Registre.AH := $02;
 Registre.BH := $00;
 Registre.DL := X;
 Registre.DH := Y;
 Intr($10,Registre);
End;

Procedure InitialiseEcran(Caractere,Couleur:Byte);
Begin
 Localise(0,0);
 Registre.AL := Caractere;
 Registre.AH := $09;
 Registre.BL := Couleur;
 Registre.BH := $00;
 Registre.CX := 2000;
 Intr($10,Registre);
End;

Procedure BoiteCaractere(X1,Y1,X2,Y2,Couleur:Byte);
Begin
 Registre.AL := Y2-Y1+1;
 Registre.AH := $06;
 Registre.BH := Couleur;
 Registre.CL := X1;
 Registre.CH := Y1;
 Registre.DL := X2;
 Registre.DH := Y2;
 Intr($10,Registre);
End;

Procedure EcritUnCaractere(X,Y,Caractere,Couleur:Byte);
Begin
 Mem[AdresseEcran:(X+Y*Colonne)*2] := Caractere;
 Mem[AdresseEcran:(X+Y*Colonne)*2+1] := Couleur;
End;

Procedure Ecrit(Phrase:String132;Couleur:Byte);
Var Compteur,Position : Byte;
Begin
 Position := XPosition;
 For Compteur := 0 to Length(Phrase)-1 do
 Begin
  EcritUnCaractere(Position+Compteur,YPosition,Ord(Phrase[Compteur+1]),Couleur);
 End;
End;

Procedure CentreEcriture(Y:Byte;Phrase:String255;Couleur:Byte);
Begin
 Localise((80 div 2)-Trunc(Length(Phrase)/2),Y);
 Ecrit(Phrase,Couleur);
End;

Procedure CadreVide(X1,Y1,X2,Y2,Couleur,TypeTexture:Byte);
Var Compteur : Byte;
Begin
 If(IndiqueEcran in [0,1,2,3])Then
 Begin
  Case TypeTexture of
   0 : Begin
	For Compteur := Y1+1 to Y2-1 do
	Begin
	 EcritUnCaractere(X1,Compteur,$B3,Couleur);
	 EcritUnCaractere(X2,Compteur,$B3,Couleur);
	End;
	EcritUnCaractere(X1,Y1,218,Couleur);
	EcritUnCaractere(X1,Y2,192,Couleur);
	EcritUnCaractere(X2,Y1,191,Couleur);
	EcritUnCaractere(X2,Y2,217,Couleur);
	Localise(X1+1,Y1);
	Registre.AX := $09C4;
	Registre.BL := Couleur;
	Registre.BH := $00;
	Registre.CX := Abs(X2-X1)-1;
	Intr($10,Registre);
	Localise(X1+1,Y2);
	Registre.AX := $09C4;
	Registre.BL := Couleur;
	Registre.BH := $00;
	Registre.CX := Abs(X2-X1)-1;
	Intr($10,Registre);
       End;
   1 : Begin
	For Compteur := Y1+1 to Y2-1 do
	Begin
	 EcritUnCaractere(X1,Compteur,$BA,Couleur);
	 EcritUnCaractere(X2,Compteur,$BA,Couleur);
	End;
	EcritUnCaractere(X1,Y1,201,Couleur);
	EcritUnCaractere(X1,Y2,200,Couleur);
	EcritUnCaractere(X2,Y1,187,Couleur);
	EcritUnCaractere(X2,Y2,188,Couleur);
	Localise(X1+1,Y1);
	Registre.AX := $09CD;
	Registre.BL := Couleur;
	Registre.BH := $00;
	Registre.CX := Abs(X2-X1)-1;
	Intr($10,Registre);
	Localise(X1+1,Y2);
	Registre.AX := $09CD;
	Registre.BL := Couleur;
	Registre.BH := $00;
	Registre.CX := Abs(X2-X1)-1;
	Intr($10,Registre);
       End;
  End;
 End;
End;

Procedure CadrePlain(X1,Y1,X2,Y2,Couleur,TypeTexture:Byte);
Var Compteur,Hauteur,Largeur,XT1,YT1,XT2,YT2 : Integer;
Begin
 If(IndiqueEcran in [0,1,2,3])Then
 Begin
  Largeur := (X2-X1) div 2;
  Hauteur := (Y2-Y1) div 2;
  For Compteur := 3 to Largeur do
  Begin
   XT1 := X1 + Largeur - (Compteur * 2);If(XT1<X1)Then XT1 := X1;
   YT1 := Y1 + Hauteur - (Compteur div 2);If(YT1<Y1)Then YT1 := Y1;
   XT2 := X1 + Largeur + (Compteur * 2);If(XT2>X2)Then XT2 := X2;
   YT2 := Y1 + Hauteur + (Compteur div 2);If(YT2>Y2)Then YT2 := Y2;
   BoiteCaractere(XT1,YT1,XT2,YT2,Couleur);
  End;
  BoiteCaractere(X1,Y1,X2,Y2,Couleur);
  If((Y2+1)<25)Then
  For Compteur := X1+2 to X2+2 do
  Begin
   If(Compteur<80)Then
   Begin
    Mem[AdresseEcran:(Compteur+(Y2+1)*80)*2+1]:=7;
   End;
  End;
  For Compteur:=Y1+1 to Y2+1 do
  Begin
   If(X2+1<80)Then Mem[AdresseEcran:(X2+1+Compteur*80)*2+1]:=7;
   If(X2+2<80)Then Mem[AdresseEcran:(X2+2+Compteur*80)*2+1]:=7;
  End;
  CadreVide(X1+2,Y1+1,X2-2,Y2-1,Couleur,TypeTexture);
 End
End;

Procedure ClaireColonne(Colonne,Caractere,Couleur:Byte);
Var Compteur : Byte;
Begin
 For Compteur:=0 to 24 do EcritUnCaractere(Colonne,Compteur,Caractere,Couleur);
End;

Procedure ClaireLigne(Ligne,Caractere,Couleur:Byte);
Begin
 Localise(0,Ligne);
 Registre.AL := Caractere;
 Registre.AH := $09;
 Registre.BL := Couleur;
 Registre.BH := $00;
 Registre.CX := 80;
 Intr($10,Registre);
End;

Procedure SauvegardeTexte(X1,Y1,X2,Y2:Byte; Var Buffer);
Var Compteur,Longeur : Byte;
Begin
 Inc(X2);
 Longeur := (X2-X1)*2;
 For Compteur := Y1 to Y2 do
 Begin
  Move(Mem[AdresseEcran:Compteur*160+X1*2],
       Mem[Seg(Buffer):Ofs(Buffer)+(Compteur-Y1)*Longeur],
       Longeur);
 End;
End;

Procedure AfficheTexte(X1,Y1,X2,Y2:Byte; Var Buffer);
Var Compteur,Longeur : Byte;
Begin
 Inc(X2);
 Longeur := (X2-X1)*2;
 For Compteur := Y1 to Y2 do
 Begin
  Move(Mem[Seg(Buffer):Ofs(Buffer)+(Compteur-Y1)*Longeur],
       Mem[AdresseEcran:Compteur*160+X1*2],
       Longeur);
 End;
End;

Procedure ModeVideo(Mode:Byte);
Begin
 Registre.AX := Mode;
 Intr($10,Registre);
End;

Procedure ChaineRepetitiveCaractere(X,Y,Caractere,Attribut:Byte;Nombre:Word;Step,Page:Byte);
Var Compteur       : Word;
    YCompteur      : Byte;
    Segment,OffSet : Word;
Begin
 If(Mem[$0044:09]<$04)OR(Mem[$0044:$09]=$07)Then
 Begin
  Localise(X,Y);
  If(Attribut = $00)Then Registre.Ah := $0A else Registre.Ah := $09;
  Registre.Al := Caractere;
  Registre.Bl := Attribut;
  Registre.Bh := Page;
  Registre.CX := Nombre;
  Intr($10,Registre);
 End;
End;

Function Espace(Nombre:Byte):String255;
Var Phrase : String255;
Begin
 Phrase:='';
 FillChar(Phrase,Nombre,32);
 Espace:=Copy(Phrase,1,Nombre);
End;

Function Zero(Nombre:Byte):String255;
Var Phrase : String255;
Begin
 Phrase:='';
 FillChar(Phrase,Nombre+1,48);
 Zero:=Copy(Phrase,1,Nombre);
End;


