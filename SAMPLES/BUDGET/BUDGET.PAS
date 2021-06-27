Program BudgetSM3;

{$M 65520,0,200000 }

Uses DOS,Crt;

Label Debut,10;

Const NomFichier     : String[64] = 'PasNomBudg²';
      XCoordonne     : Byte = 0;
      YCoordonne     : Byte = 0;
      Ligne          : Word = 0;
      Horloge        : Word = 0;
      MinTableau     : Word = 0;
      MaxTableau     : Word = 2023;
      SeparateurDate : Char = '-';
      FinList        : Word = 0;
      Numero         : Byte = 0;

Type Chemin    = String[64];
     String2   = String[2];
     String4   = String[4];
     String12  = String[12];
     String64  = String[64];
     String132 = String[132];
     String255 = String[255];

Var Couleur       : Pointer;
    Annees        : Pointer;
    Mois          : Pointer;
    Jour          : Pointer;
    Retrait       : Pointer;
    Depense       : Pointer;
    Depot         : Pointer;
    Solde         : Pointer;
    Registre      : Registers;
    Compteur      : Word;
    Erreur        : Word;
    Touche        : Word;
    Colonne       : Word Absolute $0040:$004A;
    Chaine        : String[255];
    ChaineMemoire : String[255];
    Reel          : Real;
    Repertoire    : String[63];
    Handle        : Integer;
    Intermediaire : Array[0..43] of Byte;
    Segment,OffSet: Word;
    SegTem,OffTem : Word;
    Config        : Array[0..255] of Byte;
    SegmentPSP    : Word;
    X,Y,Bouton    : Word;
    TableauInterruption : Pointer;

{$I \Source\Chantal\Library\Video\WaitRetrace.Inc}

{$DEFINE NotVoid}
{$DEFINE MACRO}
Procedure FermeCurseur;
{$I \Source\Chantal\Library\Video\CloseCur.Inc}
{$I Clavier.inc  }
{$I Ecran.Inc    }
{$I Souris6.Inc  }
{$I Temps.Inc    }
{$I BGLoad.Inc  }
{$I BGCtrl.Inc  }
{$I BGPRN.Inc   }
{$I BGPre.Inc   }
{$I BGResid.Inc }

Procedure Down(Limite:Byte;Var Position:Byte);Begin
 If(Position<Limite)Then Inc(Position)Else Position:=0;
End;

Procedure Up(Limite:Byte;Var Position:Byte);Begin
 If(Position>0)Then Dec(Position)Else Position:=Limite;
End;

Procedure Beep;Var I:Byte;Begin
 Sound(500);
 Mem[AdresseEcran:(5+(2+YCoordonne)*Colonne)*2+1] := 12;
 Mem[AdresseEcran:(6+XCoordonne+22*Colonne)*2+1] := 12;
 For I:=0to 3do WaitRetrace;
 NoSound;
 Mem[AdresseEcran:(5+(2+YCoordonne)*Colonne)*2+1] := 31;
 Mem[AdresseEcran:(6+XCoordonne+22*Colonne)*2+1] := 31;
End;

Procedure Nouveau;Begin
 FillChar(Couleur^,2048,30);
 FillChar(Annees^ ,2048,0);
 FillChar(Mois^   ,2048,0);
 FillChar(Jour^   ,2048,0);
 FillChar(Retrait^,8096,0);
 FillChar(Depense^,40960,32);
 FillChar(Depot^  ,8096,0);
 FillChar(Solde^  ,8096,0);
End;

Procedure InitialiseMemoire;Begin
 GetMem(Couleur,2048);
 GetMem(Annees ,2048);
 GetMem(Mois   ,2048);
 GetMem(Jour   ,2048);
 GetMem(Retrait,8192);
 GetMem(Depense,40960);
 GetMem(Depot  ,8192);
 GetMem(Solde  ,8192);
 Nouveau;
End;

Procedure AfficheLigne(YCoordonne:Byte;Ligne:Word);
Var TemporaireCouleur,Compteur:Byte;

 {$I \Source\Chantal\Library\Spc.Inc}

  Procedure Interprete;
  Begin
   Chaine := Copy(Chaine,1,Length(Chaine)-2)+','+Copy(Chaine,Length(Chaine)-1,2);
  End;

Begin
 TemporaireCouleur := Mem[Seg(Couleur^):Ofs(Couleur^)+Ligne];
 Str(Ligne:4,Chaine);
 Localise(1,YCoordonne+2);
 Ecrit(Chaine,27);
 EcritUnCaractere(5,YCoordonne+2,195,31);
 If(Mem[Seg(Annees^):Ofs(Annees^)+Ligne]<>0)Then
 Begin
  Localise(6,YCoordonne+2);
  Str(1985+Mem[Seg(Annees^):Ofs(Annees^)+Ligne]:4,Chaine);
  Ecrit(Chaine+SeparateurDate,TemporaireCouleur);
 End;
 If(Mem[Seg(Mois^):Ofs(Mois^)+Ligne]<>0)Then
 Begin
  Localise(11,YCoordonne+2);
  Str(Mem[Seg(Mois^):Ofs(Mois^)+Ligne],Chaine);
  If(Length(Chaine)<2)Then Chaine := '0'+Chaine;
  Ecrit(Chaine+SeparateurDate,TemporaireCouleur);
 End;
 If(Mem[Seg(Jour^):Ofs(Jour^)+Ligne]<>0)Then
 Begin
  Localise(14,YCoordonne+2);
  Str(Mem[Seg(Jour^):Ofs(Jour^)+Ligne],Chaine);
  If(Length(Chaine)<2)Then Chaine := '0'+Chaine;
  Ecrit(Chaine,TemporaireCouleur);
 End;
 EcritUnCaractere(16,YCoordonne+2,179,31);
 If(MemL[Seg(Retrait^):Ofs(Retrait^)+Ligne*4]<>0)Then
 Begin
  Localise(17,YCoordonne+2);
  Str(MemL[Seg(Retrait^):Ofs(Retrait^)+Ligne*4],Chaine);
  Interprete;
  If(Config[0]=2)Then Chaine := Spc(11-Length(Chaine)) + Chaine Else
  If(Config[0]=1)Then Chaine := Spc(6-Length(Chaine) div 2) + Chaine;
  Ecrit(Chaine,TemporaireCouleur);
 End;
 EcritUnCaractere(28,YCoordonne+2,179,31);
 For Compteur := 0 to 19 do
 Begin
  EcritUnCaractere(29+Compteur,YCoordonne+2,
   Mem[Seg(Depense^):Ofs(Depense^)+Ligne*20+Compteur],TemporaireCouleur);
 End;
 EcritUnCaractere(49,YCoordonne+2,179,31);
 If(MemL[Seg(Depot^):Ofs(Depot^)+Ligne*4]<>0)Then
 Begin
  Localise(50,YCoordonne+2);
  Str(MemL[Seg(Depot^):Ofs(Depot^)+Ligne*4],Chaine);
  Interprete;
  If(Config[0]=2)Then Chaine := Spc(12-Length(Chaine)) + Chaine Else
  If(Config[0]=1)Then Chaine := Spc(6-Length(Chaine) div 2) + Chaine;
  Ecrit(Chaine,TemporaireCouleur);
 End;
 EcritUnCaractere(62,YCoordonne+2,179,31);
 If(MemL[Seg(Solde^):Ofs(Solde^)+Ligne*4]<>0)Then
 Begin
  Localise(63,YCoordonne+2);
  Str(MemL[Seg(Solde^):Ofs(Solde^)+Ligne*4],Chaine);
  Interprete;
  If(Config[0]=2)Then Chaine := Spc(16-Length(Chaine)) + Chaine Else
  If(Config[0]=1)Then Chaine := Spc(8-Length(Chaine) div 2) + Chaine;
  Ecrit(Copy(Chaine,1,16),TemporaireCouleur);
 End;
End;

Procedure InitialiseEcranEditeur;
Begin
 InLine($B8/$03/$00/    { MOV AX,0003 }
	$CD/$10/        { INT 10      }

	$B4/$01/        { Mov Ah,01 }
	$B1/$20/ 	{ Mov Cl,20 }
	$B5/$20/ 	{ Mov Ch,20 }
	$CD/$10/ 	{ Int 10    }

	$B8/$00/$00/    { MOV AX,0000 }
	$CD/$33);       { INT 33      }

	BoiteCaractere(0,1,79,23,31);
	ClaireColonne(0,179,31);
	ClaireColonne(79,179,31);
	If(Config[14] = 0)Then
	Begin
	 ClaireLigne(24,32,63);
	 ClaireLigne(0,32,63);
	 Localise(3,0);
	 Ecrit({'F1-Aide }'F2-Fichier'{ F3-Edite'},63);
	 Localise(64,0);
	 Ecrit(' Budget SM III ',94);
	 Localise(3,24);
	 Ecrit('Esc-Quitter  Alt+C-Charge  Alt+I-Imprime  Alt+S-Sauvegarde',63);
	End
	 else
	Begin
	 ClaireLigne(24,219,15);
	 ClaireLigne(0,219,15);
	End;
	BoiteCaractere(1,2,4,21,27);
	BoiteCaractere(6,2,78,21,30);
	Localise(2,1);
	Ecrit('no ³Date A-M-J³  Retrait  ³      Remarque      ³    Depot   ³     Solde',30);
	Mem[$B80A:$0B] := 31;
	Mem[$B80C:$01] := 31;
	Mem[$B80D:$09] := 31;
	Mem[$B810:$03] := 31;
	Mem[$B811:$0D] := 31;
	For Compteur := 0 to 19 do AfficheLigne(Compteur,Compteur);
	ClaireLigne(22,193,31);
	Mem[AdresseEcran:(22*80)*2] := 195;
	Mem[$B8EF:$09] := 27;
	Mem[$B8EF:$0B] := 27;
	Mem[$B8EF:$06] := 58;
	Mem[$B8EF:$05] := 27;
	Mem[$B8EF:$03] := 27;
	Mem[$B8EF:$00] := 58;
	Mem[$B8EE:$0F] := 27;
	Mem[$B8EE:$0D] := 27;
	Mem[$B8DE:$0A] := 197;
	Mem[$B8E0:$06] := 197;
	Mem[$B8E3:$08] := 197;
	EcritUnCaractere(79,22,180,31);
	Localise(9,23);
	Ecrit('Ligne :     ³ Colonne :   ³ Fichier :              ³ Heure :',31);
	Localise(47,23);
	Ecrit(Copy(NomFichier,1,10),27);
	Mem[$B8E8:$09] := 27;
	Mem[$B8E8:$07] := 27;
	Mem[$B8E8:$05] := 27;
	Mem[$B8E8:$03] := 27;
	Mem[$B8EA:$03] := 27;
	Mem[$B8EA:$05] := 27;
 InLine($B4/$01/ { Mov Ah,01 }
	$B1/$07/ { Mov Cl,07 }
	$B5/$06/ { Mov Ch,06 }
	$CD/$10);{ Int 10    }
End;

Procedure Monte;
Begin
 If(Ligne>MinTableau)Then
 Begin
  Dec(Ligne);
  If(YCoordonne>0)Then Dec(YCoordonne)
   else
  Begin
   InLine($B8/$01/$07/ { Mov Ax,0701 }
	  $B7/$1E/     { Mov Bh,1E   }
	  $B1/$01/
	  $B5/$02/
	  $B2/$4E/
	  $B6/$15/
	  $CD/$10);    { Int 10      }
   AfficheLigne(0,Ligne);
  End;
  ChaineMemoire := '';
 End
  else
 Beep;
End;

Procedure Descend;
Begin
 If(Ligne<MaxTableau)Then
 Begin
  Inc(Ligne);
  If(YCoordonne<19)Then Inc(YCoordonne)
   else
  Begin
   InLine($B8/$01/$06/ { Mov Ax,0601 }
	  $B7/$1E/     { Mov Bh,1E   }
	  $B1/$01/
	  $B5/$02/
	  $B2/$4E/
	  $B6/$15/
	  $CD/$10);    { Int 10      }
   AfficheLigne(19,Ligne);
  End;
  ChaineMemoire := '';
 End
  else
 Beep;
End;

Procedure Avance;
Begin
 Inc(XCoordonne);
 If(XCoordonne in [10,22,43,56])Then Inc(XCoordonne);
 If(XCoordonne = 73)Then
 Begin
  XCoordonne := 0;
  Descend;
 End;
 ChaineMemoire := '';
End;

Procedure Recule;
Begin
 If(YCoordonne=0)and(XCoordonne=0)Then Beep
  else
 Begin
  Dec(XCoordonne);
  If(XCoordonne in [56,43,22,10])Then Dec(XCoordonne);
  If(XCoordonne = $FF)Then
  Begin
   XCoordonne := 57;
   Monte;
  End;
  ChaineMemoire := '';
 End;
End;

Procedure ErreurDonnee;
Var Tableau : Pointer;
Begin
 FermeCurseur;
 GetMem(Tableau,4000);
 Move(Mem[AdresseEcran:$00],Tableau^,4000);
 CadrePlain(10,7,69,17,79,1);
 CentreEcriture(10,'Erreur de Donn‚e',78);
 CentreEcriture(12,'Le chiffre inser‚ est trop gros pour ˆtre en',79);
 CentreEcriture(13,'m‚moire. Le Budget SM 3.01 ne garde pas plus',79);
 CentreEcriture(14,'que 8 chiffres avant et 2 apres la virgule. ',79);
 Sound(500);
 Mem[AdresseEcran:(5+(2+YCoordonne)*Colonne)*2+1] := 12;
 Mem[AdresseEcran:(6+XCoordonne+22*Colonne)*2+1] := 12;
 Delay(100);
 NoSound;
 Touche := LitClavier;
 Touche := 0;
 Mem[AdresseEcran:(5+(2+YCoordonne)*Colonne)*2+1] := 31;
 Mem[AdresseEcran:(6+XCoordonne+22*Colonne)*2+1] := 31;
 Move(Tableau^,Mem[AdresseEcran:$00],4000);
 FreeMem(Tableau,4000);
 InLine($B4/$01/ { Mov Ah,01 }
	$B1/$07/ { Mov Cl,07 }
	$B5/$06/ { Mov Ch,06 }
	$CD/$10);{ Int 10    }
End;

Procedure Ajustement;
Var Tableau  : Pointer;
    OK       : Boolean;
    Position : Byte;
Begin
 GetMem(Tableau,4000);
 Move(Mem[$B800:00],Tableau^,4000);
 InLine($B4/$01/ { Mov Ah,01 }
	$B1/$20/ { Mov Cl,20 }
	$B5/$20/ { Mov Ch,20 }
	$CD/$10);{ Int 10    }
 CadrePlain(27,8,52,21,47,1);
 CentreEcriture(11,'Ajustement',46);
 CentreEcriture(13,'Couleur',43);
 CentreEcriture(14,'Environnement',43);
 CentreEcriture(15,'Fenetre',43);
 CentreEcriture(16,'Divers',43);
 CentreEcriture(17,'Chercher',43);
 CentreEcriture(18,'Sauvegarde',43);
 Position := 0;
 OK := False;
 Repeat
  For Compteur := 31 to 48 do
  Begin
   Mem[$B800:(Compteur+(Position+13)*80)*2+1] := 94;
  End;
  Touche := LitClavier;
  For Compteur := 31 to 48 do
  Begin
   Mem[$B800:(Compteur+(Position+13)*80)*2+1] := 43;
  End;
  Case Lo(Touche) of
   27 : OK := True;
  End;
  If(Lo(Touche)=0)Then
  Begin
   Case Hi(Touche) of
    71 : Position := 0;
    72 : Up(5,Position);
    79 : Position := 5;
    80 : Down(5,Position);
   End;
  End;
 Until OK;
 Move(Tableau^,Mem[$B800:00],4000);
 FreeMem(Tableau,4000);
 InLine($B4/$01/ { Mov Ah,01 }
	$B1/$07/ { Mov Cl,07 }
	$B5/$06/ { Mov Ch,06 }
	$CD/$10);{ Int 10    }
 Touche := 0;
End;

Procedure Charge;Forward;

Procedure Fichier;
Var Tableau  : Pointer;
    OK       : Boolean;
    Position : Byte;
Begin
 GetMem(Tableau,4000);
 Move(Mem[$B800:00],Tableau^,4000);
 FermeCurseur;
 CadrePlain(26,6,53,21,47,1);
 CentreEcriture(9,'Fichier',46);
 CentreEcriture(11,'Chercher document',43);
 CentreEcriture(12,'~Copier un document~',43);
 CentreEcriture(13,'~Effacer un document~',43);
 CentreEcriture(14,'Imprimer document',43);
 CentreEcriture(15,'~Nouveau document~',43);
 CentreEcriture(16,'~Renommer document~',43);
 CentreEcriture(17,'~Repertoire~',43);
 CentreEcriture(18,'Sauvegarde document',43);
 Position := 0;
 OK := False;
 Repeat
  For Compteur := 30 to 49 do
  Begin
   Mem[$B800:(Compteur+(Position+11)*80)*2+1] := 94;
  End;
  Touche := LitClavier;
  For Compteur := 30 to 49 do
  Begin
   Mem[$B800:(Compteur+(Position+11)*80)*2+1] := 43;
  End;
  Case Lo(Touche) of
   27 : OK := True;
   13 : Begin
	 Case Position of
	  0: Charge;
	  3: ImprimeListe;
	  7: Sauvegarde;
	 End;
	 FermeCurseur;
	End;
  End;
  If(Lo(Touche)=0)Then
  Begin
   Case Hi(Touche) of
    71 : Position := 0;
    72 : Up(7,Position);
    79 : Position := 7;
    80 : Down(7,Position);
   End;
  End;
 Until OK;
 Move(Tableau^,Mem[$B800:00],4000);
 FreeMem(Tableau,4000);
 InLine($B4/$01/ { Mov Ah,01 }
	$B1/$07/ { Mov Cl,07 }
	$B5/$06/ { Mov Ch,06 }
	$CD/$10);{ Int 10    }
 Touche := 0;
End;

Procedure Option;
Var Tableau  : Pointer;
    OK       : Boolean;
    Position : Byte;
Begin
 GetMem(Tableau,4000);
 Move(Mem[$B800:00],Tableau^,4000);
 InLine($B4/$01/ { Mov Ah,01 }
	$B1/$20/ { Mov Cl,20 }
	$B5/$20/ { Mov Ch,20 }
	$CD/$10);{ Int 10    }
 CadrePlain(25,10,54,21,47,1);
 CentreEcriture(13,'Option',46);
 CentreEcriture(15,'Calculatrice',43);
 CentreEcriture(16,'Generique',43);
 CentreEcriture(17,'Info-Budget',43);
 CentreEcriture(18,'Tri',43);
 Position := 0;
 OK := False;
 Repeat
  For Compteur := 29 to 50 do
  Begin
   Mem[$B800:(Compteur+(Position+15)*80)*2+1] := 94;
  End;
  Touche := LitClavier;
  For Compteur := 29 to 50 do
  Begin
   Mem[$B800:(Compteur+(Position+15)*80)*2+1] := 43;
  End;
  Case Lo(Touche) of
   27 : OK := True;
  End;
  If(Lo(Touche)=0)Then
  Begin
   Case Hi(Touche) of
    71 : Position := 0;
    72 : Up(3,Position);
    79 : Position := 3;
    80 : Down(3,Position);
   End;
  End;
 Until OK;
 Move(Tableau^,Mem[$B800:00],4000);
 FreeMem(Tableau,4000);
 InLine($B4/$01/ { Mov Ah,01 }
	$B1/$07/ { Mov Cl,07 }
	$B5/$06/ { Mov Ch,06 }
	$CD/$10);{ Int 10    }
 Touche := 0;
End;

Procedure Protection;
Var Tableau  : Pointer;
    OK       : Boolean;
    Position : Byte;
Begin
 GetMem(Tableau,4000);
 Move(Mem[$B800:00],Tableau^,4000);
 InLine($B4/$01/ { Mov Ah,01 }
	$B1/$20/ { Mov Cl,20 }
	$B5/$20/ { Mov Ch,20 }
	$CD/$10);{ Int 10    }
 CadrePlain(24,11,55,21,47,1);
 CentreEcriture(14,'Protection',46);
 CentreEcriture(16,'ProtŠge ce document',43);
 CentreEcriture(17,'D‚protŠge ce document',43);
 CentreEcriture(18,'Type protection',43);
 Position := 0;
 OK := False;
 Repeat
  For Compteur := 28 to 51 do
  Begin
   Mem[$B800:(Compteur+(Position+16)*80)*2+1] := 94;
  End;
  Touche := LitClavier;
  For Compteur := 28 to 51 do
  Begin
   Mem[$B800:(Compteur+(Position+16)*80)*2+1] := 43;
  End;
  Case Lo(Touche) of
   27 : OK := True;
  End;
  If(Lo(Touche)=0)Then
  Begin
   Case Hi(Touche) of
    71 : Position := 0;
    72 : Up(2,Position);
    79 : Position := 2;
    80 : Down(2,Position);
   End;
  End;
 Until OK;
 Move(Tableau^,Mem[$B800:00],4000);
 FreeMem(Tableau,4000);
 InLine($B4/$01/ { Mov Ah,01 }
	$B1/$07/ { Mov Cl,07 }
	$B5/$06/ { Mov Ch,06 }
	$CD/$10);{ Int 10    }
 Touche := 0;
End;

Procedure DosShell;
Var Tableau : Pointer;
Begin
 GetMem(Tableau,4000);
 Move(Mem[$B800:00],Tableau^,4000);
 InLine($B8/$03/$00/ { Mov AX,0003 }
	$CD/$10);    { Int 10      }
 Ecrit('Taper : Exit<Enter>, pour retourner au Budget',7);
 Exec('C:\Command.com','');
 Move(Tableau^,Mem[$B800:00],4000);
 FreeMem(Tableau,4000);
End;

Procedure Restoration;
Var Tableau : Pointer;
Begin
 FermeCurseur;
 GetMem(Tableau,4000);
 Move(Mem[$B800:00],Tableau^,4000);
 CadrePlain(10,10,69,14,47,1);
 CentreEcriture(12,'Es-tu certain de bien vouloir Quitter (O/N) ?',46);
 Touche := LitClavier;
 If(Lo(Touche) in [79,111,89,121])Then
 Begin
  InLine($FA);        { CLI         }
  Move(TableauInterruption^,Mem[0:0],1024);
  InLine($FB/         { STI 	    }
	 $B8/$03/$00/ { Mov AX,0003 }
	 $CD/$10);    { Int 10      }
  Halt;
 End;
 Move(Tableau^,Mem[$B800:00],4000);
 FreeMem(Tableau,4000);
 InLine($B4/$01/ { Mov Ah,01 }
	$B1/$07/ { Mov Cl,07 }
	$B5/$06/ { Mov Ch,06 }
	$CD/$10);{ Int 10    }
End;

Procedure MenuPrincipal;
Var OK       : Boolean;
    Position : Byte;
    Tableau  : Pointer;

Begin
 OK       := False;
 Position := 0;
 GetMem(Tableau,4000);
 Move(Mem[$B800:00],Tableau^,4000);
 FermeCurseur;
 CadrePlain(28,2,51,15,63,1);
 CentreEcriture(5,'Menu Principal',62);
 CentreEcriture(7,'Ajustement',59);
 CentreEcriture(8,'Fichier',59);
 CentreEcriture(9,'Option',59);
 CentreEcriture(10,'Protection',59);
 CentreEcriture(11,'Dos Shell',59);
 CentreEcriture(12,'Quitter',59);
 Repeat
  For Compteur := 32 to 47 do
  Begin
   Mem[$B800:(Compteur+(Position+7)*80)*2+1] := 94;
  End;
  Touche := LitClavier;
  For Compteur := 32 to 47 do
  Begin
   Mem[$B800:(Compteur+(Position+7)*80)*2+1] := 59;
  End;
  Case Lo(Touche) of
   08 : Up(5,Position);
   13 : Begin
	 CadreVide(30,3,49,14,63,0);
	 For Compteur := 32 to 47 do
	 Begin
	  Mem[$B800:(Compteur+(Position+7)*80)*2+1] := 94;
	 End;
	 InLine($B8/$02/$00/ { Mov AX,0002h }
		$CD/$33);    { Int 33h      }
	 Case Position of
	  0 : Ajustement;
	  1 : Fichier;
	  2 : Option;
	  3 : Protection;
	  4 : DosShell;
	  5 : Restoration;
	 End;
	 InLine($B4/$01/     { Mov Ah,01h   }
		$B1/$20/     { Mov Cl,20h   }
		$B5/$20/     { Mov Ch,20h   }
		$CD/$10/     { Int 10h      }
		$B8/$01/$00/ { Mov AX,0001h }
		$CD/$33);    { Int 33h      }
	 CadreVide(30,3,49,14,63,1);
	End;
   27 : OK := True;
   32 : Down(5,Position);
  End;
  If(Lo(Touche)=0)Then
  Begin
   Case Hi(Touche) of
    71 : Position := 0;
    72 : Up(5,Position);
    79 : Position := 5;
    80 : Down(5,Position);
   End;
  End;
 Until OK;
 Move(Tableau^,Mem[$B800:00],4000);
 FreeMem(Tableau,4000);
 InLine($B4/$01/ { Mov Ah,01 }
	$B1/$07/ { Mov Cl,07 }
	$B5/$06/ { Mov Ch,06 }
	$CD/$10);{ Int 10    }
 Touche := 0;
End;

Procedure AjustementCouleur;
Begin
 Compteur := Mem[Seg(Couleur^):Ofs(Couleur^)+Ligne];
 Mem[Seg(Couleur^):Ofs(Couleur^)+Ligne] := SelectionCouleur(Mem[Seg(Couleur^):Ofs(Couleur^)+Ligne]);
 If(Compteur <> Mem[Seg(Couleur^):Ofs(Couleur^)+Ligne])Then
 Begin
  Chaine := Chr(Mem[AdresseEcran:322]) + Chr(Mem[AdresseEcran:324]) +
	    Chr(Mem[AdresseEcran:326]) + Chr(Mem[AdresseEcran:328]);
  For Erreur := 1 to 4 do
  Begin
   If(Mem[Seg(Chaine):Ofs(Chaine)+Erreur]=0)Then
   Begin
    Mem[Seg(Chaine):Ofs(Chaine)+Erreur] := 32;
   End;
  End;
  While(Chaine[1]=#32)do Delete(Chaine,1,1);
  Val(Chaine,Compteur,Erreur);
  If(Erreur=0)Then
  Begin
   For Erreur := Compteur to Compteur + 19 do AfficheLigne(Erreur-Compteur,Erreur);
  End;
 End;
End;

Procedure FindeList;
Begin
 InLine($B4/$01/ { Mov Ah,01 }
	$B1/$20/ { Mov Cl,20 }
	$B5/$20/ { Mov Ch,20 }
	$CD/$10);{ Int 10    }
 If(FinList < 10)Then
 Begin
  For Compteur := 0 to 19 do AfficheLigne(Compteur,Compteur);
  Ligne := FinList;
  YCoordonne := FinList;
 End
  else
 If(FinList > 9)Then
 Begin
  BoiteCaractere(1,2,4,21,30);
  BoiteCaractere(6,2,15,21,30);
  BoiteCaractere(17,2,27,21,30);
  BoiteCaractere(50,2,61,21,30);
  BoiteCaractere(63,2,78,21,30);
  For Compteur := FinList - 7 to FinList + 12 do AfficheLigne(Compteur-FinList+7,Compteur);
  Ligne := FinList;
  YCoordonne := 7;
 End;
 ChaineMemoire := '';
 InLine($B4/$01/ { Mov Ah,01 }
	$B1/$07/ { Mov Cl,07 }
	$B5/$06/ { Mov Ch,06 }
	$CD/$10);{ Int 10    }
End;

Procedure DebutdeList;
Begin
 FermeCurseur;
 BoiteCaractere(1,2,4,21,30);
 BoiteCaractere(6,2,15,21,30);
 BoiteCaractere(17,2,27,21,30);
 BoiteCaractere(50,2,61,21,30);
 BoiteCaractere(63,2,78,21,30);
 For Compteur := 0 to 19 do AfficheLigne(Compteur,Compteur);
 ChaineMemoire := '';
 InLine($B4/$01/ { Mov Ah,01 }
	$B1/$07/ { Mov Cl,07 }
	$B5/$06/ { Mov Ch,06 }
	$CD/$10);{ Int 10    }
 Ligne      := 0;
 YCoordonne := 0;
End;

Var Tableau : Pointer;

Procedure Charge;Label 1000;Begin
 NomFichier:=ChercherFichier(Repertoire,$FFFF,'Charger un Fichier');
 If NomFichier<>'Escape'Then Begin
  FermeCurseur;
  GetMem(Tableau,4000);
  Move(Mem[AdresseEcran:$00],Tableau^,4000);
  CadrePlain(26,7,53,15,47,1);
  CentreEcriture(10,'Lecture du Fichier',46);
  EcritUnCaractere(39,12,Ord('%'),47);
  Nouveau;
  Handle := Ouvre(NomFichier,0);
  If(TailleFichier(Handle)<36)Then Goto 1000;
  LitEnregistrement(Handle,0,36,Intermediaire);
   { Tentative de Load d'un programme EXE }
  If((Intermediaire[0]=77)and(Intermediaire[1]=90))Then Begin
   CadrePlain(10,7,69,15,79,1);
   CentreEcriture(10,'Erreur de Fichier',78);
   CentreEcriture(12,'Le fichier selectionn‚ est un programme.',79);
   Sound(500);
   Mem[AdresseEcran:(5+(2+YCoordonne)*Colonne)*2+1] := 12;
   Mem[AdresseEcran:(6+XCoordonne+22*Colonne)*2+1] := 12;
   For Compteur:=0to 4do WaitRetrace;
   NoSound;
   Touche := LitClavier;
   Touche := 0;
   Mem[AdresseEcran:(5+(2+YCoordonne)*Colonne)*2+1] := 31;
   Mem[AdresseEcran:(6+XCoordonne+22*Colonne)*2+1] := 31;
  End
   else
   { Load de la Maniere Budget SM 3.01A }
  If((Intermediaire[0]=86)and(Intermediaire[1]=3)and
     (Intermediaire[2]=46)and(Intermediaire[3]=0)and
     (Intermediaire[4]=1)and(Intermediaire[5]=65))Then Begin
   Erreur := Intermediaire[6] + 1;
   FinList := TailleFichier(Handle) div 36;
   For Compteur := Erreur to FinList-1 do Begin
    LitEnregistrement(Handle,Compteur,36,Intermediaire);
    Mem[Seg(Couleur^):Ofs(Couleur^)+Compteur-Erreur] := Intermediaire[0];
    Mem[Seg(Annees^):Ofs(Annees^)+Compteur-Erreur] := Intermediaire[1];
    Mem[Seg(Mois^):Ofs(Mois^)+Compteur-Erreur] := Intermediaire[2];
    Mem[Seg(Jour^):Ofs(Jour^)+Compteur-Erreur] := Intermediaire[3];
    Move(Intermediaire[4],Mem[Seg(Retrait^):Ofs(Retrait^)+(Compteur-Erreur)*4],4);
    Move(Intermediaire[8],Mem[Seg(Depense^):Ofs(Depense^)+(Compteur-Erreur)*20],20);
    Move(Intermediaire[28],Mem[Seg(Depot^):Ofs(Depot^)+(Compteur-Erreur)*4],4);
    Move(Intermediaire[32],Mem[Seg(Solde^):Ofs(Solde^)+(Compteur-Erreur)*4],4);
    If(MemL[Seg(Retrait^):Ofs(Retrait^)+(Compteur-Erreur)*4]<0)Then Begin
     MemL[Seg(Retrait^):Ofs(Retrait^)+(Compteur-Erreur)*4] := 0;
    End;
    If(MemL[Seg(Depot^):Ofs(Depot^)+(Compteur-Erreur)*20]<0)Then Begin
     MemL[Seg(Depot^):Ofs(Depot^)+(Compteur-Erreur)*20] := 0;
    End;
    If(MemL[Seg(Solde^):Ofs(Solde^)+(Compteur-Erreur)*4]<0)Then Begin
     MemL[Seg(Solde^):Ofs(Solde^)+(Compteur-Erreur)*4] := 0;
    End;
    If(FinList>0)and(Compteur>0)Then Reel := Compteur/FinList Else Reel := 0;
    Str(Reel:2:2,Chaine);
    Localise(40,12);
    Ecrit(Copy(Chaine,3,2),43);
   End;
  End
   else { Load de la Maniere Budget SM 1.01A a 2.01A }
  Begin
   FinList:=TailleFichier(Handle) div 37;
   For Compteur := 0 to FinList-1 do Begin
    LitEnregistrement(Handle,Compteur,44,Intermediaire);
    Mem[Seg(Couleur^):Ofs(Couleur^)+Compteur] := Intermediaire[0];
    Mem[Seg(Annees^):Ofs(Annees^)+Compteur] := Intermediaire[1];
    Mem[Seg(Mois^):Ofs(Mois^)+Compteur] := Intermediaire[2];
    Mem[Seg(Jour^):Ofs(Jour^)+Compteur] := Intermediaire[3];
    Move(Intermediaire[5],Reel,6);
    Str(Reel:15:2,Chaine);
    Localise(XCoordonne+6,YCoordonne+2);
    For Erreur := 1 to Length(Chaine) do
    If(Chaine[Erreur]='.')Then Chaine[Erreur] := ',';
    For Erreur := 1 to Length(Chaine) do
    If(Chaine[Erreur] in [',','.'])Then Delete(Chaine,Erreur,1);
    Val(Chaine,MemL[Seg(Retrait^):Ofs(Retrait^)+Ligne*4],Erreur);
    Move(Intermediaire[12],Mem[Seg(Depense^):Ofs(Depense^)+Compteur*20],20);
    Move(Intermediaire[32],Reel,6);
    Str(Reel:15:2,Chaine);
    Localise(XCoordonne+6,YCoordonne+2);
    For Erreur := 1 to Length(Chaine) do
    If(Chaine[Erreur]='.')Then Chaine[Erreur] := ',';
    For Erreur := 1 to Length(Chaine) do
    If(Chaine[Erreur] in [',','.'])Then Delete(Chaine,Erreur,1);
    Val(Chaine,MemL[Seg(Depot^):Ofs(Depot^)+Ligne*4],Erreur);
    Move(Intermediaire[38],Reel,6);
    Str(Reel:15:2,Chaine);
    Localise(XCoordonne+6,YCoordonne+2);
    For Erreur := 1 to Length(Chaine) do
    If(Chaine[Erreur]='.')Then Chaine[Erreur] := ',';
    For Erreur := 1 to Length(Chaine) do
    If(Chaine[Erreur] in [',','.'])Then Delete(Chaine,Erreur,1);
    Val(Chaine,MemL[Seg(Solde^):Ofs(Solde^)+Ligne*4],Erreur);
    If(FinList>0)and(Compteur>0)Then Reel := Compteur/FinList Else Reel := 0;
    Str(Reel:2:2,Chaine);
    Localise(40,12);Ecrit(Copy(Chaine,3,2),43);
   End;
  End;
1000:Move(Tableau^,Mem[AdresseEcran:$00],4000);
  FreeMem(Tableau,4000);
  InLine($B4/$01/ { Mov Ah,01 }
	 $B1/$07/ { Mov Cl,07 }
	 $B5/$06/ { Mov Ch,06 }
	 $CD/$10);{ Int 10    }
  For Compteur := 0 to 19 do AfficheLigne(Compteur,Compteur);
  XCoordonne := 0; YCoordonne := 0; Ligne := 0;
 End
  else
 NomFichier:='PasNomBSM ²';
 Localise(47,23);
 Ecrit(Copy(NomFichier,Length(NomFichier)-11,8)+Copy(NomFichier,Length(NomFichier)-2,2),27);
End;

Begin { Main Program }
 Config[0] :=  2;  { Centrage Gauche/Centre/Droite }
 Config[1] := 10;  { X1 d'Erreur Imprimante        }
 Config[2] := 8;   { Y1 d'Erreur Imprimante        }
 Config[3] := 0;   { X d'Ajustement Imprimante     }
 Config[4] := 0;   { PRN : Compression : I/A       }
 Config[5] := 0;   { PRN : Centrage : D/G/C        }
 Config[6] := Numero;
 Config[7] := 0;   { PRN : Separateur de colonne I/A }
 Config[8] := 0;   { PRN : Soulignement I/A          }
 Config[9] := 0;   { PRN : Initialisation F/L/P/D    }
 Config[10]:= 0;   { PRN : Justification A/I         }
 Config[11]:= 0;   { PRN : Interligne S/D            }
 Config[12]:= 0;   { PRN : Nombre Frappe S/D         }
 Config[13]:= 0;   { PRN : Numero ligne Z/E          }
 Config[14]:= 0;   { ECR : Type bar menu 3/1         }
 InitialiseMemoire;
 Presentation;
 InitialiseEcranEditeur;
 GetMem(TableauInterruption,1024);
 InLine($FA);
 Move(Mem[$0:0],TableauInterruption^,1024);
 InLine($FB);
 Registre.AH := $33;
 Registre.AL := $01;
 Registre.DL := $00;
 MsDos(Registre);
 ChaineMemoire := '';
 GetDir(0,Repertoire);
 ApplicationHeure;
 Compteur1C := 0;
 Debut : Str(Ligne:4,Chaine);
	 Mem[$B8E8:$02] := Ord(Chaine[1]);
	 Mem[$B8E8:$04] := Ord(Chaine[2]);
	 Mem[$B8E8:$06] := Ord(Chaine[3]);
	 Mem[$B8E8:$08] := Ord(Chaine[4]);
	 Str(XCoordonne:2,Chaine);
	 Mem[$B8EA:$02] := Ord(Chaine[1]);
	 Mem[$B8EA:$04] := Ord(Chaine[2]);
	 Localise(6+XCoordonne,2+YCoordonne);
	 Mem[AdresseEcran:(5+(2+YCoordonne)*Colonne)*2+1] := 14;
	 Mem[AdresseEcran:(6+XCoordonne+22*Colonne)*2+1] := 14;
	 InLine($B8/$01/$00/$CD/$33);
	 Repeat
	  Inc(Compteur1C);
	  If(Compteur1C>$4FF)Then
	  Begin
	   Compteur1C := 0;
	   Chaine     := Heures;
	   Mem[$B800:3820] := Ord(Chaine[1]);
	   Mem[$B800:3822] := Ord(Chaine[2]);
	   Mem[$B800:3826] := Ord(Chaine[3]);
	   Mem[$B800:3828] := Ord(Chaine[4]);
	   Mem[$B800:3832] := Ord(Chaine[5]);
	   Mem[$B800:3834] := Ord(Chaine[6]);
	   PositionEtatSouris(X,Y,Bouton);
	   If(Bouton=1)Then
	   Begin
	    X := X div 8;
	    Y := Y div 8;
	    If(Y=0)Then	MenuPrincipal;
	   End;
	  End;
	 Until KeyPressed;
	 InLine($B8/$02/$00/$CD/$33);
	 Touche := LitClavier;
	 Mem[AdresseEcran:(5+(2+YCoordonne)*Colonne)*2+1] := 31;
	 Mem[AdresseEcran:(6+XCoordonne+22*Colonne)*2+1] := 31;
	 If((XCoordonne>=0)and(XCoordonne<4)and(Lo(Touche)>47)and(Lo(Touche)<58))Then
	 Begin
	  ChaineMemoire := ChaineMemoire + Chr(Lo(Touche));
	  Val(ChaineMemoire,Compteur,Erreur);
	  Inc(XCoordonne);
	  Localise(6,2+YCoordonne);
	  If(Compteur>1985)Then
	  Begin
	   Mem[Seg(Annees^):Ofs(Annees^)+Ligne] := Compteur - 1985;
	   Str(Mem[Seg(Annees^):Ofs(Annees^)+Ligne]+1985,Chaine);
	   Ecrit(Chaine+SeparateurDate,Mem[Seg(Couleur^):Ofs(Couleur^)+Ligne]);
	   XCoordonne    := 5;
	   ChaineMemoire := '';
	   If(FinList<Ligne)Then FinList := Ligne;
	  End
	   else
	  Ecrit(ChaineMemoire,142);
	 End
	  else
	 If((XCoordonne>4)and(XCoordonne<7)and(Lo(Touche)>47)and(Lo(Touche)<58))Then
	 Begin
	  ChaineMemoire := ChaineMemoire + Chr(Lo(Touche));
	  Val(ChaineMemoire,Compteur,Erreur);
	  Inc(XCoordonne);
	  Localise(11,2+YCoordonne);
	  If(Length(ChaineMemoire)=2)Then
	  Begin
	   Mem[Seg(Mois^):Ofs(Mois^)+Ligne] := Compteur;
	   Str(Mem[Seg(Mois^):Ofs(Mois^)+Ligne],Chaine);
	   If(Length(Chaine)<2)Then Chaine := '0' + Chaine;
	   Ecrit(Chaine+SeparateurDate,Mem[Seg(Couleur^):Ofs(Couleur^)+Ligne]);
	   XCoordonne    := 8;
	   ChaineMemoire := '';
	   If(FinList<Ligne)Then FinList := Ligne;
	  End
	   else
	  Ecrit(ChaineMemoire,142);
	 End
	  else
	 If((XCoordonne>7)and(XCoordonne<10)and(Lo(Touche)>47)and(Lo(Touche)<58))Then
	 Begin
	  ChaineMemoire := ChaineMemoire + Chr(Lo(Touche));
	  Val(ChaineMemoire,Compteur,Erreur);
	  Inc(XCoordonne);
	  Localise(14,2+YCoordonne);
	  If(Length(ChaineMemoire)=2)Then
	  Begin
	   Mem[Seg(Jour^):Ofs(Jour^)+Ligne] := Compteur;
	   Str(Mem[Seg(Jour^):Ofs(Jour^)+Ligne],Chaine);
	   If(Length(Chaine)<2)Then Chaine := '0' + Chaine;
	   Ecrit(Chaine,Mem[Seg(Couleur^):Ofs(Couleur^)+Ligne]);
	   XCoordonne    := 11;
	   ChaineMemoire := '';
	   If(FinList<Ligne)Then FinList := Ligne;
	  End
	   else
	  Ecrit(ChaineMemoire,142);
	 End
	  else
	 If((XCoordonne>10)and(XCoordonne<22)and(((Lo(Touche)>47)and(Lo(Touche)<58))or(Lo(Touche)=44)or(Lo(Touche)=46)))Then
	 Begin
	  If(Length(ChaineMemoire)>7)Then ErreurDonnee
	   else
	  Begin
	   ChaineMemoire := ChaineMemoire + Chr(Lo(Touche));
	   For Compteur := 1 to Length(ChaineMemoire) do
	    If(ChaineMemoire[Compteur]=',')Then ChaineMemoire[Compteur] := '.';
	   Val(ChaineMemoire,Reel,Erreur);
	   Str(Reel:11:2,Chaine);
	   Localise(XCoordonne+6,YCoordonne+2);
	   For Compteur := 1 to Length(Chaine) do
	    If(Chaine[Compteur]='.')Then Chaine[Compteur] := ',';
	   Ecrit(Chaine,Mem[Seg(Couleur^):Ofs(Couleur^)+Ligne]);
	   For Compteur := 1 to Length(Chaine) do
	    If(Chaine[Compteur] in [',','.'])Then Delete(Chaine,Compteur,1);
	   Val(Chaine,MemL[Seg(Retrait^):Ofs(Retrait^)+Ligne*4],Erreur);
	   If(FinList<Ligne)Then FinList := Ligne;
	  End;
	 End
	  else
	 If((XCoordonne>22)and(XCoordonne<43)and(Lo(Touche)>31))Then
	 Begin
	  EcritUnCaractere(XCoordonne+6,YCoordonne+2,Lo(Touche),Mem[Seg(Couleur^):Ofs(Couleur^)+Ligne]);
	  Mem[Seg(Depense^):Ofs(Depense^)+Ligne*20+XCoordonne-23] := Lo(Touche);
	  Avance;
	  If(FinList<Ligne)Then FinList := Ligne;
	 End
	  else
	 If((XCoordonne>43)and(XCoordonne<57)and(((Lo(Touche)>47)and(Lo(Touche)<58))or(Lo(Touche)=44)or(Lo(Touche)=46)))Then
	 Begin
	  If(Length(ChaineMemoire)>7)Then ErreurDonnee
	   else
	  Begin
	   ChaineMemoire := ChaineMemoire + Chr(Lo(Touche));
	   For Compteur := 1 to Length(ChaineMemoire) do
	    If(ChaineMemoire[Compteur]=',')Then ChaineMemoire[Compteur] := '.';
	   Val(ChaineMemoire,Reel,Erreur);
	   Str(Reel:12:2,Chaine);
	   Localise(XCoordonne+6,YCoordonne+2);
	   For Compteur := 1 to Length(Chaine) do
	    If(Chaine[Compteur]='.')Then Chaine[Compteur] := ',';
	   Ecrit(Chaine,Mem[Seg(Couleur^):Ofs(Couleur^)+Ligne]);
	   For Compteur := 1 to Length(Chaine) do
	    If(Chaine[Compteur] in [',','.'])Then Delete(Chaine,Compteur,1);
	   Val(Chaine,MemL[Seg(Depot^):Ofs(Depot^)+Ligne*4],Erreur);
	   If(FinList<Ligne)Then FinList := Ligne;
	  End;
	 End
	  else
	 If((XCoordonne>56)and(XCoordonne<79)and(((Lo(Touche)>47)and(Lo(Touche)<58))or(Lo(Touche)=44)or(Lo(Touche)=46)))Then
	 Begin
	  If(Length(ChaineMemoire)>7)Then ErreurDonnee
	   else
	  Begin
	   ChaineMemoire := ChaineMemoire + Chr(Lo(Touche));
	   For Compteur := 1 to Length(ChaineMemoire) do
	    If(ChaineMemoire[Compteur]=',')Then ChaineMemoire[Compteur] := '.';
	   Val(ChaineMemoire,Reel,Erreur);
	   Str(Reel:15:2,Chaine);
	   Localise(XCoordonne+6,YCoordonne+2);
	   For Compteur := 1 to Length(Chaine) do
	    If(Chaine[Compteur]='.')Then Chaine[Compteur] := ',';
	   Ecrit(Chaine,Mem[Seg(Couleur^):Ofs(Couleur^)+Ligne]);
	   For Compteur := 1 to Length(Chaine) do
	    If(Chaine[Compteur] in [',','.'])Then Delete(Chaine,Compteur,1);
	   Val(Chaine,MemL[Seg(Solde^):Ofs(Solde^)+Ligne*4],Erreur);
	   If(FinList<Ligne)Then FinList := Ligne;
	  End;
	 End
	  else
	 Case Lo(Touche) of
	  9   : Begin
		 If((Mem[$0040:$17] and $04)<>0)Then
 { Ctrl - I }    Begin
		 End
		  else
 { Tabulation }  Begin
		  If(XCoordonne<10)Then XCoordonne := 11 else
		  If(XCoordonne<22)Then XCoordonne := 23 else
		  If(XCoordonne<43)Then XCoordonne := 44 else
		  If(XCoordonne<56)Then XCoordonne := 57
		   else
		  Begin
		   XCoordonne := 0;
		   Descend;
		  End;
		  ChaineMemoire := '';
		 End;
		End;
{ Ctrl-O }15  : XCoordonne := 11;
{ Ctrl-T }20  : XCoordonne := 23;
{ Ctrl-V }22  : XCoordonne := 57;
{ Ctrl-W }23  : XCoordonne := 44;
{ ESC    }27  : Restoration;
	 End;
	 If(Lo(Touche)=0)Then
	 Begin
	  Case Hi(Touche) of
{Ctrl-Home}119 : DebutdeList;
{ Ctrl-End}117 : FindeList;
{ Ctrl-F1 } 94 : Ajustement;
{ Ctrl-F2 } 95 : Fichier;
{ Ctrl-F3 } 96 : Option;
{ Ctrl-F4 } 97 : Protection;
{ Ctrl-F5 } 98 : DosShell;
{ Shift-F2} 85 : AjustementImprimante;
{ Shift-F1} 84 : AjustementCouleur;
{  Down   } 80 : Descend;
{  End    } 79 : XCoordonne := 57;
{  Right  } 77 : Avance;
{  Left   } 75 : Recule;
{  Up     } 72 : Monte;
{  Home   } 71 : XCoordonne := 0;
{  F2     } 60 : Fichier;
{  Alt-O  } 50 : MenuPrincipal;
{  Alt-C  } 46 : Charge;
 { Alt-S }  31 : Sauvegarde;
 { Alt-P }  25 : ParqueDisqueDur;
 { Alt-I }  23 : ImprimeListe;
	  End;
	 End;
	 Goto Debut;
End.
