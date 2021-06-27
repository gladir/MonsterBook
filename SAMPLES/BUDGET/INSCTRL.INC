Procedure ReelEnDoubleMot(Reel : LongInt; Var Grand,Petit : Word);
Var Temporaire : LongInt;
Begin
 Grand := Trunc( Reel / 65536 );
 Temporaire := Reel - ( Grand * 65536 );
 Petit := Trunc(Temporaire);
End;

Function DoubleMotEnReel(Grand,Petit : Word) : LongInt;
Var Temporaire : LongInt;
Begin
 Temporaire := Petit;
 If(Temporaire < 0)Then Temporaire := Temporaire + 65536;
 DoubleMotEnReel := (Grand * 65536) + Temporaire;
End;

Procedure Positionne(Handle : Integer; RecNum : LongInt; Taille : Word);
Var Grand,Petit : Word;
    Position    : LongInt;
Begin
 Position := RecNum * Taille;
 ReelEnDoubleMot(Position,Grand,Petit);
 Registre.AX := $4200;
 Registre.BX := Handle;
 Registre.CX := Grand;
 Registre.DX := Petit;
 MsDos(Registre);
End;

Function TailleFichier(Handle : Integer) : LongInt;
Begin
 Registre.AX := $4202;
 Registre.BX := Handle;
 Registre.CX := $0000;
 Registre.DX := $0000;
 MsDos(Registre);
 If((Registre.Flags And 1) <> 0)Then
 Begin
  TailleFichier := -1;
 End
  Else
 Begin
  TailleFichier := DoubleMotEnReel(Registre.DX,Registre.AX);
 End;
End;

Function Ferme(Handle : Integer) : Integer;
Begin
 Registre.AX := $3E00;
 Registre.BX := Handle;
 MsDos(Registre);
 If((Registre.Flags and 1) <> 0)Then Ferme := Registre.AX Else Ferme := $0000;
End;

Function Ouvre(Nom : Chemin;Mode:Byte) : Integer;
Var Temporaire : Chemin;
Begin
 Temporaire := Nom + #00;
 Registre.AX := $3D40+Mode;
 Registre.DS := Seg(Temporaire[1]);
 Registre.DX := Ofs(Temporaire[1]);
 MsDos(Registre);
 If((Registre.Flags and 1) <> 0)Then
 Begin
  Ouvre  := -1;
 End
  else
 Begin
  Ouvre  := Registre.AX;
 End;
End;

Function Cree(Nom : Chemin) : Integer;
Var Temporaire : Chemin;
Begin
 Move(Nom[1],Temporaire,Length(Nom));
 Temporaire:= Nom + #00;
 Registre.AX := $3C00;
 Registre.DS := Seg(Temporaire[1]);
 Registre.DX := Ofs(Temporaire[1]);
 Registre.CX := $0000;
 MsDos(Registre);
 If((Registre.Flags and 1)<>0)Then Cree := -1
			Else Cree := Registre.AX;
End;

Function Efface(Nom : Chemin) : Integer;
Var Temporaire : Chemin;
Begin
 Temporaire := Nom + #00;
 Registre.AX := $4100;
 Registre.DS := Seg(Temporaire[1]);
 Registre.DX := Ofs(Temporaire[1]);
 MsDos(Registre);
 If((Registre.Flags and 1) <> 0)Then Efface := Registre.AX
			  Else Efface := $0000;
End;

Procedure LitEnregistrement(Handle : Integer; RecNum : LongInt; Taille : Word; Var Buffer);
Var BytesLus : Integer;
Begin
 Positionne(Handle,RecNum,Taille);
 Registre.AX := $3F00;
 Registre.BX := Handle;
 Registre.CX := Taille;
 Registre.DS := Seg(Buffer);
 Registre.DX := Ofs(Buffer);
 MsDos(Registre);
 If((Registre.Flags and 1) <> 0)Then BytesLus := 0
			  Else BytesLus := Registre.AX;
End;

Procedure ModifieEnregistrement(Handle : Integer; RecNum : LongInt; Taille : Word; Var Buffer);
Var Ecrits : Word;
Begin
 Positionne(Handle,RecNum,Taille);
 Registre.AX := $4000;
 Registre.BX := Handle;
 Registre.CX := Taille;
 Registre.DS := Seg(Buffer);
 Registre.DX := Ofs(Buffer);
 MsDos(Registre);
 If((Registre.Flags and 1) <> 0)Then Ecrits := 0
			  Else Ecrits := Registre.AX;
End;

Procedure AjouteEnregistrement(Handle : Integer; RecNum : LongInt; Taille : Word; Var Buffer);
Begin
 RecNum := Trunc((TailleFichier(Handle))/Taille);
 ModifieEnregistrement(Handle,RecNum,Taille,Buffer);
End;

Function MajDirectoire(Handle : Integer) : Integer;
Begin
 Registre.AX := $4500;
 Registre.BX := Handle;
 MsDos(Registre);
 If((Registre.Flags and 1) <> 0)Then MajDirectoire := Registre.AX Else MajDirectoire := Ferme(Registre.AX);
End;

Function SelectionCouleur(Couleur:Byte):Byte;
Label Debut,Rep,Fin;
Var X,Y : Byte;
Begin
 Move(Mem[AdresseEcran:$00],Tableau[4]^,4000);
 InLine($B4/$01/
	$B1/$07/
	$B5/$08/
	$CD/$10);
 CadrePlain(8,0,76,21,63,1);
 Localise(14,2);
 Ecrit('Couleur de Fond :     Couleur Ecriture :',63);
 For X := 0 to 15 do For Y := 0 to 15 do
 Begin
  Mem[AdresseEcran:((4+Y)*80+15+X*3)*2+1] := X*16+Y;
  Mem[AdresseEcran:((4+Y)*80+16+X*3)*2+1] := X*16+Y;
  Mem[AdresseEcran:((4+Y)*80+17+X*3)*2+1] := X*16+Y;
  Mem[AdresseEcran:((4+Y)*80+16+X*3)*2] := 120;
 End;
 X := Couleur Div 16;
 Y := Couleur Mod 16;
 CadreVide(64,12,72,14,63,0);
 Localise(65,13);
 Ecrit('Retire',62);
 CadreVide(64,8,72,10,63,1);
 Localise(65,9);
 Ecrit('Correct',62);
 Debut : Move(Mem[AdresseEcran:$00],Tableau[5]^,3680);
	 Localise(32,2);
	 Ecrit('ллл',X);
	 Localise(55,2);
	 Ecrit('ллл',Y);
	 CadreVide(14+X*3,Y+3,18+X*3,Y+5,15,0);
	 Touche := LitClavier;
	 Move(Tableau[5]^,Mem[AdresseEcran:$00],3680);
	 Case Hi(Touche) of
	  72 : Y := (Y-1) and 15;
	  80 : Y := (Y+1) and 15;
	  75 : X := (X-1) and 15;
	  77 : X := (X+1) and 15;
	 End;
	 If Not(Lo(Touche) in [13,27])Then Goto Debut;
 Fin   :
 InLine($B4/$01/
	$B1/$07/
	$B5/$06/
	$CD/$10);
 Move(Tableau[4]^,Mem[AdresseEcran:$00],4000);
 If(Lo(Touche) = 13)Then SelectionCouleur := 16*X+Y
  else
 SelectionCouleur := Couleur;
 Touche := 0;
End;

Function Parque:Boolean;
Var Disque,Nombre       : Byte;
    CodeErreur,Compteur : Integer;
Begin
 CodeErreur  := $00;
 Registre.AH := $08;
 Registre.DL := $80;
 Intr($13,Registre);
 Nombre := Registre.DL;
 For Compteur := $00 to (Nombre-1) do
 Begin
  Registre.AX := $0C01;
  Registre.CX := Registre.CX + 1;
  Registre.DL := $80 + Compteur;
  Intr($13,Registre);
  If((Registre.Flags and 1)<>0)Then CodeErreur := CodeErreur + Registre.AX;
  Registre.AH := $08;
  Registre.DL := $80 + Compteur;
  Intr($13,Registre);
 End;
 If(CodeErreur<>0)Then Parque := False Else Parque := True;
End;

Procedure ParqueDisqueDur;
Var Resultat : Boolean;
Begin
 Move(Mem[AdresseEcran:$00],Tableau[4]^,4000);
 CadrePlain(15,9,64,17,63,1);
 CentreEcriture(12,'Parquage du/des disque dur en cours...',62);
 Resultat := Parque;
 If(Resultat)Then
 Begin
  CentreEcriture(12,'Parquage du/des disque dur reussits...',62);
  CentreEcriture(14,'Tu peux maintenant fermer l''ordinateur',62);
 End
  else
 Begin
  CadrePlain(15,11,64,15,79,1);
  CentreEcriture(13,'Erreur de parquage...',78);
 End;
 Touche := LitClavier;
 Touche := 0;
 Move(Tableau[4]^,Mem[AdresseEcran:$00],4000);
End;
