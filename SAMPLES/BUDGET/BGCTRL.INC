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

Procedure Sauvegarde;
Label 10,20;
Var NomTemporaire : String64;
    Tableau       : Pointer;

 Function EditeNomFichier(NomFichier:String64) : String64;
 Label 20;
 Var NomTemporaire : String64;
     Etat          : Boolean;
     Position      : Byte;
 Begin
  InLine($B4/$01/
	 $B1/$07/
	 $B5/$06/
	 $CD/$10);
  For Compteur := 0 to 50 do
  Begin
   EcritUnCaractere(14+Compteur,7,32,14);
  End;
  Localise(14,7);
  Ecrit(Copy(NomTemporaire,2,Length(NomTemporaire)),14);
  Localise(14,9);
  Ecrit('Position :',63);
  Mem[AdresseEcran:(25+9*Colonne)*2+1] := 59;
  Mem[AdresseEcran:(26+9*Colonne)*2+1] := 59;
  NomTemporaire := NomFichier;
  Position      := 0;
  Etat := False;
  Repeat
   Str(Position:2,Chaine);
   Mem[AdresseEcran:(25+9*Colonne)*2] := Ord(Chaine[1]);
   Mem[AdresseEcran:(26+9*Colonne)*2] := Ord(Chaine[2]);
   Localise(14+Position,7);
   Touche := LitClavier;
   Case Hi(Touche) of
    71 : Position := 0;
    75 : Begin
	  If(Position=0)Then
	  Begin
	   Sound(500);
	   Mem[AdresseEcran:(25+9*Colonne)*2+1] := 12;
	   Mem[AdresseEcran:(26+9*Colonne)*2+1] := 12;
	   Delay(100);
	   NoSound;
	   Mem[AdresseEcran:(25+9*Colonne)*2+1] := 59;
	   Mem[AdresseEcran:(26+9*Colonne)*2+1] := 59;
	  End
	   else
	  Dec(Position);
	 End;
    77 : Begin
	  If(Position=50)Then
	  Begin
	   Sound(500);
	   Mem[AdresseEcran:(25+9*Colonne)*2+1] := 12;
	   Mem[AdresseEcran:(26+9*Colonne)*2+1] := 12;
	   Delay(100);
	   NoSound;
	   Mem[AdresseEcran:(25+9*Colonne)*2+1] := 59;
	   Mem[AdresseEcran:(26+9*Colonne)*2+1] := 59;
	  End
	   else
	  Inc(Position);
	 End;
    79 : Position := Ord(NomTemporaire[0]);
    83 : Begin
	  Delete(NomTemporaire,Position+1,1);
	  Localise(14,7);
	  Ecrit(NomTemporaire+'  ',14);
	 End;
   End;
   If((Lo(Touche)=8)and((Mem[$0040:$17] and $04)=0))Then { BackSpace }
   Begin
    If((Position>0)and(Position=Mem[Seg(NomTemporaire[0]):Ofs(NomTemporaire[0])]))Then
    Begin
     Chaine := Copy(NomTemporaire,1,Length(NomTemporaire)-1);
     NomTemporaire := Chaine;
     Localise(14,7);
     Ecrit(NomTemporaire+'  ',14);
     Dec(Position);
    End
     else
    If(Position>0)Then
    Begin
     Delete(NomTemporaire,Position+1,1);
     Localise(14,7);
     Ecrit(NomTemporaire+'  ',14);
     Dec(Position);
    End
     else
    Begin
     Sound(500);
     Mem[AdresseEcran:(25+9*Colonne)*2+1] := 12;
     Mem[AdresseEcran:(26+9*Colonne)*2+1] := 12;
     Delay(100);
     NoSound;
     Mem[AdresseEcran:(25+9*Colonne)*2+1] := 59;
     Mem[AdresseEcran:(26+9*Colonne)*2+1] := 59;
    End;
   End
    else
   If(Lo(Touche)>31)and(Position<51)Then
   Begin
    If(Etat=False)Then
    Begin
     For Compteur := 0 to 50 do
     Begin
      EcritUnCaractere(14+Compteur,7,32,14);
     End;
     FillChar(NomTemporaire[0],64,0);
     Etat := True;
    End;
    Mem[Seg(NomTemporaire[1]):Ofs(NomTemporaire[1])+Position] := Lo(Touche);
    If(Chr(Position)>NomTemporaire[0])Then
    Begin
     Mem[Seg(NomTemporaire[0]):Ofs(NomTemporaire[0])] := Position + 1;
     Mem[AdresseEcran:(15+Position+7*Colonne)*2+1] := 14;
     Mem[AdresseEcran:(15+Position+7*Colonne)*2] := 32;
    End;
    EcritUnCaractere(14+Position,7,Lo(Touche),14);
    Inc(Position);
   End;
  Until (Lo(Touche) in [13,27]);
  FermeCurseur;
  For Compteur := 0 to 51 do
  Begin
   Mem[AdresseEcran:(14+Compteur+7*Colonne)*2+1] := 59;
  End;
  If(Lo(Touche)=27)Then EditeNomFichier := NomFichier
		   Else EditeNomFichier := NomTemporaire;
 End;

 Function Recherche(Chaine:String255;Caractere:Char):Byte;
 Var Compteur : Byte;
 Begin
  Recherche := 0;
  For Compteur := 1 to Length(Chaine) do
  Begin
   If(Chaine[Compteur]=Caractere)Then
   Begin
    Recherche := Compteur;
   End;
  End;
 End;

Begin
 FermeCurseur;
 NomTemporaire := NomFichier;
 GetMem(Tableau,4000);
 Move(Mem[AdresseEcran:$00],Tableau^,4000);
 CadrePlain(10,0,69,24,63,1);
 CentreEcriture(3,'Sauvegarde le Fichier',62);
 Localise(14,5);
 Ecrit('Nom du Fichier :',63);
 10 : Localise(14,7);
      Ecrit(Copy(NomTemporaire,1,Length(NomTemporaire)-1),59);
 If(NomTemporaire[Length(NomTemporaire)-3]<>'.')Then
 Begin
  Insert('.',NomTemporaire,Length(NomTemporaire)-2);
 End;
 CentreEcriture(11,'Est-il correct (O)ui/(N)on ?',62);
 Touche := LitClavier;
 If(Lo(Touche) in [79,111])Then
 Begin
  Handle := Cree(NomTemporaire);
  For Compteur := 0 to 35 do Intermediaire[Compteur]:=0;
  Intermediaire[0] := 86;
  Intermediaire[1] := 3;
  Intermediaire[2] := 46;
  Intermediaire[3] := 0;
  Intermediaire[4] := 1;
  Intermediaire[5] := 65;
  Intermediaire[6] := 0;
  ModifieEnregistrement(Handle,0,36,Intermediaire);
  CadrePlain(26,7,53,15,47,1);
  CentreEcriture(10,'Position de la Fin',46);
  Localise(32,12);
  Ecrit('Lignes =',47);
  Localise(41,12);
  Str(FinList:4,Chaine);
  Ecrit(Chaine,174);
  For Compteur := 0 to FinList do
  Begin
   Intermediaire[0] := Mem[Seg(Couleur^):Ofs(Couleur^)+Compteur];
   Intermediaire[1] := Mem[Seg(Annees^):Ofs(Annees^)+Compteur];
   Intermediaire[2] := Mem[Seg(Mois^):Ofs(Mois^)+Compteur];
   Intermediaire[3] := Mem[Seg(Jour^):Ofs(Jour^)+Compteur];
   Move(Mem[Seg(Retrait^):Ofs(Retrait^)+Compteur*4],Intermediaire[4],4);
   Move(Mem[Seg(Depense^):Ofs(Depense^)+Compteur*20],Intermediaire[8],20);
   Move(Mem[Seg(Depot^):Ofs(Depot^)+Compteur*4],Intermediaire[28],4);
   Move(Mem[Seg(Solde^):Ofs(Solde^)+Compteur*4],Intermediaire[32],4);
   ModifieEnregistrement(Handle,Compteur+1+Intermediaire[6],36,Intermediaire[0]);
  End;
  Handle := Ferme(Handle);
 End
  else
 If(Lo(Touche) in [78,110])Then
 Begin
  CentreEcriture(11,'                            ',62);
  If(Recherche(NomTemporaire,'.')>0)Then
  Begin
   Delete(NomTemporaire,Recherche(NomTemporaire,'.'),1);
  End;
  Chaine := Copy(NomTemporaire,1,Length(NomTemporaire)-1);
  NomTemporaire := Chaine;
  NomTemporaire := EditeNomFichier(NomTemporaire);
  Compteur := 11 - (Length(NomTemporaire) - Recherche(NomTemporaire,'\'));
  NomTemporaire := NomTemporaire + Espace(Compteur);
  NomTemporaire[Length(NomTemporaire)] := 'В';
  If(Lo(Touche)=13)Then
  Begin
   Touche := 0;
   Goto 10;
  End;
 End;
 Move(Tableau^,Mem[AdresseEcran:$00],4000);
 FreeMem(Tableau,4000);
 InLine($B4/$01/
	$B1/$07/
	$B5/$06/
	$CD/$10);
 If(Touche = 27)Then NomFichier := NomTemporaire;
 Touche := 0;
End;

Function SelectionCouleur(Couleur:Byte):Byte;
Label Debut,Rep,Fin;
Var X,Y      : Byte;
    Tableau  : Pointer;
    TableauA : Pointer;
Begin
 GetMem(Tableau,4000);
 GetMem(TableauA,4000);
 Move(Mem[AdresseEcran:$00],Tableau^,4000);
 FermeCurseur;
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
 Debut : Move(Mem[AdresseEcran:$00],TableauA^,3680);
	 Localise(32,2);
	 Ecrit('ллл',X);
	 Localise(55,2);
	 Ecrit('ллл',Y);
	 CadreVide(14+X*3,Y+3,18+X*3,Y+5,15,0);
	 Touche := LitClavier;
	 Move(TableauA^,Mem[AdresseEcran:$00],3680);
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
 Move(Tableau^,Mem[AdresseEcran:$00],4000);
 If(Lo(Touche) = 13)Then SelectionCouleur := 16*X+Y
  else
 SelectionCouleur := Couleur;
 FreeMem(Tableau,4000);
 FreeMem(TableauA,4000);
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
    Tableau  : Pointer;
Begin
 GetMem(Tableau,4000);
 Move(Mem[AdresseEcran:$00],Tableau^,4000);
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
 Move(Tableau^,Mem[AdresseEcran:$00],4000);
 FreeMem(Tableau,4000);
End;
