Function EtatImprimante(Numero:Byte) : Byte;
Begin
 Registre.AH := $02;
 Registre.DX := Numero;
 Intr($17,Registre);
 EtatImprimante := Registre.AH;
End;

Function InitialiseImprimante(Numero:Byte) : Byte;
Begin
 Registre.AH := $01;
 Registre.DX := Numero;
 Intr($17,Registre);
 InitialiseImprimante := Registre.AH;
End;

Function EcritImprimante(Var Numero:Byte;Chaine:String255) : Byte;
Label Fin;
Var Compteur : Byte;
Begin
 If(EtatImprimante(Numero)<>144)Then Goto Fin;
 For Compteur := 1 to Length(Chaine) do
 Begin
  Registre.AH := $00;
  Registre.AL := Ord(Chaine[Compteur]);
  Registre.DX := Numero;
  Intr($17,Registre);
  If(Registre.AH <> 144)Then Goto Fin;
 End;
 Fin : If(Compteur<>Length(Chaine))Then Numero := Compteur;
 EcritImprimante := Registre.AH;
End;

Function Question(X,Y,Limite:Byte;Phrase:String255) : String255;
Var Position  : Byte;
    ChaineTem : String255;
Begin
 FillChar(ChaineTem[0],255,0);
 ChaineTem := Phrase;
 ChaineRepetitiveCaractere(X,Y,32,14,Limite+1,0,0);
 Localise(X,Y);
 Ecrit(Phrase,14);
 Position := 0;
 Repeat
  Localise(X+Position,Y);
  Touche := LitClavier;
  Case Hi(Touche) of
   71 : Position := 0;
   75 : Begin
	 If(Position=0)Then
	 Begin
	  Sound(500);
	  Delay(100);
	  NoSound;
	 End
	  else
	 Dec(Position);
	End;
   77 : Begin
	 If(Position=Limite)Then
	 Begin
	  Sound(500);
	  Delay(100);
	  NoSound;
	 End
	  else
	 Inc(Position);
	End;
   79 : Position := Ord(ChaineTem[0]);
   83 : Begin
	 Delete(ChaineTem,Position+1,1);
	 Localise(X,Y);
	 Ecrit(ChaineTem+'  ',14);
	End;
  End;
  If((Lo(Touche)=8)and((Mem[$0040:$17] and $04)=0))Then
  Begin
   If(Position>0)and(Position=Mem[Seg(ChaineTem[0]):Ofs(ChaineTem[0])])Then
   Begin
    Chaine  := Copy(ChaineTem,1,Length(ChaineTem)-1);
    ChaineTem := Chaine;
    Localise(X,Y);
    Ecrit(ChaineTem+'  ',14);
    Dec(Position);
   End
    else
   If(Position>0)Then
   Begin
    Delete(ChaineTem,Position+1,1);
    Localise(X,Y);
    Ecrit(ChaineTem+'  ',46);
    Dec(Position);
   End
    else
   Begin
    Sound(500);
    Delay(100);
    NoSound;
   End;
  End
   else
  If((Lo(Touche)>31)and(Position<Limite))Then
  Begin
   Mem[Seg(ChaineTem[1]):Ofs(ChaineTem[1])+Position] := Lo(Touche);
   EcritUnCaractere(X+Position,Y,Lo(Touche),14);
   Inc(Position);
   If(Mem[Seg(ChaineTem[0]):Ofs(ChaineTem[0])]<Position)Then
   Begin
    Mem[Seg(ChaineTem[0]):Ofs(ChaineTem[0])] := Position;
    Mem[AdresseEcran:(X+Position+Y*Colonne)*2+1] := 14;
    Mem[AdresseEcran:(X+Position+Y*Colonne)*2] := 32
   End;
  End;
 Until (Lo(Touche) in [13,27]);
 Question := ChaineTem;
End;

Procedure AjustementImprimante;
Const Choix : Array[0..13] of String[21]=(
	       'Centrage',
	       'Compresser',
	       'Espacement au colonne',
	       'Nombre frappe',
	       'Initialisation',
	       'Interlignes',
	       'Justification',
	       'Longueur du papier',
	       'Marge',
	       'Num‚ro ligne',
	       'S‚parateur de colonne',
	       'S‚parateur de date',
	       'Soulignement',
	       'Commande sp‚cifique'
	      );
  Position : Byte = 0;
Var X 	      : Integer;
    PhraseTem : String64;
    Tableau   : Pointer;

 Procedure Centrage;
 Label 10;
 Var Tableau : Pointer;
 Begin
  InLine($B4/$01/
	 $B1/$07/
	 $B5/$06/
	 $CD/$10);
  GetMem(Tableau,4000);
  Move(Mem[AdresseEcran:$00],Tableau^,4000);
  CadrePlain(Config[3]+1,6,Config[3]+39,16,47,1);
  Localise(Config[3]+5,9);
  Ecrit('Centrage : Gauche/Centre/Droite',46);
  Case Config[5] of
   0 : PhraseTem := 'Gauche';
   1 : PhraseTem := 'Centre'
    else
   PhraseTem := 'Droite';
  End;
10:Chaine := Question(Config[3]+5,11,30,PhraseTem);
  If((Chaine='C')or(Chaine='Centre'))Then Config[5] := 1 else
  If((Chaine='D')or(Chaine='Droite'))Then Config[5] := 2 else
  If((Chaine='G')or(Chaine='Gauche'))Then Config[5] := 0 else
  If(Not(Lo(Touche)=27))Then
  Begin
   Localise(Config[3]+5,13);
   Ecrit('Erreur de commande',172);
   Goto 10;
  End;
  Move(Tableau^,Mem[AdresseEcran:$00],4000);
  FreeMem(Tableau,4000);
  FermeCurseur;
 End;

 Procedure Compression;
 Label 20;
 Var Tableau : Pointer;
 Begin
  InLine($B4/$01/
	 $B1/$07/
	 $B5/$06/
	 $CD/$10);
  GetMem(Tableau,4000);
  Move(Mem[AdresseEcran:$00],Tableau^,4000);
  CadrePlain(Config[3]+1,6,Config[3]+39,16,47,1);
  Localise(Config[3]+5,9);
  Ecrit('Compression : Active/Inactive',46);
  Case Config[4] of
   1 : PhraseTem := 'Active'
    else
   PhraseTem := 'Inactive';
  End;
20:Chaine := Question(Config[3]+5,11,30,PhraseTem);
  If((Chaine='A')or(Chaine='Active'))Then Config[4] := 1 else
  If((Chaine='I')or(Chaine='Inactive'))Then Config[4] := 0 else
  If(Not(Lo(Touche)=27))Then
  Begin
   Localise(Config[3]+5,13);
   Ecrit('Erreur de commande',172);
   Goto 20;
  End;
  Move(Tableau^,Mem[AdresseEcran:$00],4000);
  FreeMem(Tableau,4000);
  FermeCurseur;
 End;

 Procedure EspacementColonne;
 Label 30;
 Var Tableau : Pointer;
 Begin
  InLine($B4/$01/
	 $B1/$07/
	 $B5/$06/
	 $CD/$10);
  GetMem(Tableau,4000);
  Move(Mem[AdresseEcran:$00],Tableau^,4000);
  X := Config[3] - 7;
  If(X<0)Then X := 0;
  If(X+45>79)Then X := 34;
  CadrePlain(X,6,Config[3]+45,16,47,1);
  Localise(X+4,9);
  Ecrit('Espacement de colonne : Active/Inactive',46);
  Case Config[7] of
   1 : PhraseTem := 'Active'
    else
   PhraseTem := 'Inactive';
  End;
30:Chaine := Question(X+4,11,30,PhraseTem);
  If((Chaine='A')or(Chaine='Active'))Then Config[7] := 1 else
  If((Chaine='I')or(Chaine='Inactive'))Then Config[7] := 0 else
  If(Not(Lo(Touche)=27))Then
  Begin
   Localise(Config[3]+5,13);
   Ecrit('Erreur de commande',172);
   Goto 30;
  End;
  Move(Tableau^,Mem[AdresseEcran:$00],4000);
  FreeMem(Tableau,4000);
  FermeCurseur;
 End;

 Procedure NombreFrappe;
 Label 40;
 Var Tableau : Pointer;
 Begin
  InLine($B4/$01/
	 $B1/$07/
	 $B5/$06/
	 $CD/$10);
  GetMem(Tableau,4000);
  Move(Mem[AdresseEcran:$00],Tableau^,4000);
  CadrePlain(Config[3]+1,6,Config[3]+39,16,47,1);
  Localise(Config[3]+5,9);
  Ecrit('Nombre frappe : Simple/Double',46);
  Case Config[12] of
   1 : PhraseTem := 'Double'
    else
   PhraseTem := 'Simple';
  End;
40:Chaine := Question(Config[3]+5,11,30,PhraseTem);
  If((Chaine='S')or(Chaine='Simple')
   Or(Chaine='N')or(Chaine='Normal'))Then Config[12] := 0 else
  If((Chaine='D')or(Chaine='Double'))Then Config[12] := 1 else
  If(Not(Lo(Touche)=27))Then
  Begin
   Localise(Config[3]+5,13);
   Ecrit('Erreur de commande',172);
   Goto 40;
  End;
  Move(Tableau^,Mem[AdresseEcran:$00],4000);
  FreeMem(Tableau,4000);
  FermeCurseur;
 End;

 Procedure Initialise;
 Label 50;
 Var Tableau : Pointer;
 Begin
  InLine($B4/$01/
	 $B1/$07/
	 $B5/$06/
	 $CD/$10);
  GetMem(Tableau,4000);
  Move(Mem[AdresseEcran:$00],Tableau^,4000);
  CadrePlain(Config[3]+1,6,Config[3]+39,16,47,1);
  Localise(Config[3]+5,9);
  Ecrit('Initialise : Page/Ligne/Fermer',46);
  Case Config[9] of
   2 : PhraseTem := 'Fermer';
   1 : PhraseTem := 'Ligne';
   0 : PhraseTem := 'Page'
    else
   PhraseTem := 'Debut';
  End;
50:Chaine := Question(Config[3]+5,11,30,PhraseTem);
  If((Chaine='P')or(Chaine='Page'))Then Config[9] := 2 else
  If((Chaine='L')or(Chaine='Ligne'))Then Config[9] := 1	else
  If((Chaine='F')or(Chaine='Fermer'))Then Config[9] := 0 else
  If((Chaine='D')or(Chaine='Debut'))Then Config[9] := 3	else
  If Not(Lo(Touche)=27)Then
  Begin
   Localise(Config[3]+5,13);
   Ecrit('Erreur de commande',172);
   Goto 50;
  End;
  Move(Tableau^,Mem[AdresseEcran:$00],4000);
  FreeMem(Tableau,4000);
  FermeCurseur;
 End;

 Procedure InterLigne;
 Label 60;
 Var Tableau : Pointer;
 Begin
  InLine($B4/$01/
	 $B1/$07/
	 $B5/$06/
	 $CD/$10);
  GetMem(Tableau,4000);
  Move(Mem[AdresseEcran:$00],Tableau^,4000);
  CadrePlain(Config[3]+1,6,Config[3]+39,16,47,1);
  Localise(Config[3]+5,9);
  Ecrit('Interligne : Simple/Double',46);
  Case Config[11] of
   1 : PhraseTem := 'Double'
    else
   PhraseTem := 'Simple';
  End;
60:Chaine := Question(Config[3]+5,11,30,PhraseTem);
  If((Chaine='S')or(Chaine='Simple')
   Or(Chaine='N')or(Chaine='Normal'))Then Config[11] := 0 else
  If((Chaine='D')or(Chaine='Double'))Then Config[11] := 1 else
  If(Not(Lo(Touche)=27))Then
  Begin
   Localise(Config[3]+5,13);
   Ecrit('Erreur de commande',172);
   Goto 60;
  End;
  Move(Tableau^,Mem[AdresseEcran:$00],4000);
  FreeMem(Tableau,4000);
  FermeCurseur;
 End;

 Procedure Justification;
 Label 70;
 Var Tableau : Pointer;
 Begin
  InLine($B4/$01/
	 $B1/$07/
	 $B5/$06/
	 $CD/$10);
  GetMem(Tableau,4000);
  Move(Mem[AdresseEcran:$00],Tableau^,4000);
  CadrePlain(Config[3]+1,6,Config[3]+39,16,47,1);
  Localise(Config[3]+5,9);
  Ecrit('Justification : Active/Inactive',46);
  Case Config[10] of
   1 : PhraseTem := 'Active'
    else
   PhraseTem := 'Inactive';
  End;
70:Chaine := Question(Config[3]+5,11,30,PhraseTem);
  If((Chaine='A')or(Chaine='Active'))Then Config[10] := 1 else
  If((Chaine='I')or(Chaine='Inactive'))Then Config[10] := 0 else
  If(Not(Lo(Touche)=27))Then
  Begin
   Localise(Config[3]+5,13);
   Ecrit('Erreur de commande',172);
   Goto 70;
  End;
  Move(Tableau^,Mem[AdresseEcran:$00],4000);
  FreeMem(Tableau,4000);
  FermeCurseur;
 End;

 Procedure NumeroLigne;
 Label 100;
 Var Tableau : Pointer;
 Begin
  InLine($B4/$01/
	 $B1/$07/
	 $B5/$06/
	 $CD/$10);
  GetMem(Tableau,4000);
  Move(Mem[AdresseEcran:$00],Tableau^,4000);
  CadrePlain(Config[3]+1,6,Config[3]+39,16,47,1);
  Localise(Config[3]+5,9);
  Ecrit('Numero Ligne : Espace/Zero',46);
  Case Config[5] of
   1 : PhraseTem := 'Espace'
    else
   PhraseTem := 'Zero';
  End;
100:Chaine := Question(Config[3]+5,11,30,PhraseTem);
  If((Chaine='E')or(Chaine='Espace'))Then Config[13] := 1 else
  If((Chaine='Z')or(Chaine='Zero'))Then	Config[13] := 0	else
  If(Not(Lo(Touche)=27))Then
  Begin
   Localise(Config[3]+5,13);
   Ecrit('Erreur de commande',172);
   Goto 100;
  End;
  Move(Tableau^,Mem[AdresseEcran:$00],4000);
  FreeMem(Tableau,4000);
  FermeCurseur;
 End;

 Procedure Soulignement;
 Label 120;
 Var Tableau : Pointer;
 Begin
  InLine($B4/$01/
	 $B1/$07/
	 $B5/$06/
	 $CD/$10);
  GetMem(Tableau,4000);
  Move(Mem[AdresseEcran:$00],Tableau^,4000);
  CadrePlain(Config[3]+1,6,Config[3]+39,16,47,1);
  Localise(Config[3]+5,9);
  Ecrit('Soulignement : Active/Inactive',46);
  Case Config[8] of
   1 : PhraseTem := 'Active';
    else
   PhraseTem := 'Inactive';
  End;
120:Chaine := Question(Config[3]+5,11,30,PhraseTem);
  If((Chaine='A')or(Chaine='Active'))Then Config[8] := 1 else
  If((Chaine='I')or(Chaine='Inactive'))Then Config[8] := 0 else
  If(Not(Lo(Touche)=27))Then
  Begin
   Localise(Config[3]+5,13);
   Ecrit('Erreur de commande',172);
   Goto 120;
  End;
  Move(Tableau^,Mem[AdresseEcran:$00],4000);
  FreeMem(Tableau,4000);
  FermeCurseur;
 End;

Begin
 FermeCurseur;
 GetMem(Tableau,4000);
 Move(Mem[AdresseEcran:$00],Tableau^,4000);
 SauvegardeTexte(Config[3],0,Config[3]+41,22,Mem[AdresseEcran:8000]);
 CadrePlain(Config[3],0,Config[3]+39,21,63,1);
 Localise(Config[3]+10,3);
 Ecrit('Ajustement Imprimante',62);
 For Compteur := 0 to 13 do
 Begin
  Localise(Config[3]+5,5+Compteur);
  Chaine := Copy(Hex(Compteur+1)+' - ',4,4);
  Ecrit(Chaine + Choix[Compteur],63);
 End;
 SauvegardeTexte(Config[3],0,Config[3]+39,22,Mem[AdresseEcran:4000]);
 Repeat
  For Compteur := Config[3]+4 to Config[3]+35 do
  Begin
   Mem[AdresseEcran:((Position+5)*Colonne+Compteur)*2+1] := 94;
  End;
  Touche := LitClavier;
  For Compteur := Config[3]+4 to Config[3]+35 do
  Begin
   Mem[AdresseEcran:((Position+5)*Colonne+Compteur)*2+1] := 63;
  End;
  If(Lo(Touche)=13)Then
  Begin
   Case Position of
    00 : Centrage;
    01 : Compression;
    02 : EspacementColonne;
    03 : NombreFrappe;
    04 : Initialise;
    05 : InterLigne;
    06 : Justification;
    09 : NumeroLigne;
    12 : Soulignement;
   End;
   If(Lo(Touche)=13)Then Touche := 0;
  End;
  Case Hi(Touche) of
    72 : Begin
	  If(Position>0)Then Dec(Position)
			Else Position := 13;
	 End;
    75 : Begin
	  If((Config[3]>0)and((Mem[$0040:$17] and $10)<>0))Then
	  Begin
	   For Compteur := 0 to 21 do
	   Begin
	    MemW[AdresseEcran:(Compteur*Colonne+Config[3]+41)*2] :=
	    MemW[Seg(Tableau^):Ofs(Tableau^)+(Compteur*Colonne+Config[3]+41)*2];
	    MemW[AdresseEcran:((Compteur+1)*Colonne+Config[3]+40)*2] :=
	    Mem[Seg(Tableau^):Ofs(Tableau^)+((Compteur+1)*Colonne+Config[3]+40)*2] + 256 * 7;
	    MemW[AdresseEcran:((Compteur+1)*Colonne+Config[3]+39)*2] :=
	    Mem[Seg(Tableau^):Ofs(Tableau^)+((Compteur+1)*Colonne+Config[3]+39)*2] + 256 * 7;
	   End;
	   MemW[AdresseEcran:(22*Colonne+Config[3]+41)*2] :=
	   MemW[Seg(Tableau^):Ofs(Tableau^)+(22*Colonne+Config[3]+41)*2];
	   MemW[AdresseEcran:(22*Colonne+Config[3]+1)*2] :=
	   Mem[Seg(Tableau^):Ofs(Tableau^)+(22*Colonne+Config[3]+1)*2] + 256 * 7;
	   MemW[AdresseEcran:(Config[3]+40)*2] :=
	   MemW[Seg(Tableau^):Ofs(Tableau^)+(Config[3]+40)*2];
	   MemW[AdresseEcran:(Config[3]+39)*2] :=
	   MemW[Seg(Tableau^):Ofs(Tableau^)+(Config[3]+39)*2];
	   Dec(Config[3]);
	   AfficheTexte(Config[3],0,Config[3]+39,21,Mem[AdresseEcran:4000])
	  End;
	 End;
    77 : Begin
	  If((Config[3]+41<79)and((Mem[$0040:$17] and $10)<>0))Then
	  Begin
	   For Compteur := 0 to 21 do
	   Begin
	    MemW[AdresseEcran:(Compteur*Colonne+Config[3])*2] :=
	    MemW[Seg(Tableau^):Ofs(Tableau^)+(Compteur*Colonne+Config[3])*2];
	    MemW[AdresseEcran:((Compteur+1)*Colonne+Config[3]+42)*2] :=
	    Mem[Seg(Tableau^):Ofs(Tableau^)+((Compteur+1)*Colonne+Config[3]+42)*2] + 256 * 7;
	    MemW[AdresseEcran:((Compteur+1)*Colonne+Config[3]+41)*2] :=
	    Mem[Seg(Tableau^):Ofs(Tableau^)+((Compteur+1)*Colonne+Config[3]+41)*2] + 256 * 7;
	   End;
	   MemW[AdresseEcran:(22*Colonne+Config[3]+2)*2] :=
	   MemW[Seg(Tableau^):Ofs(Tableau^)+(22*Colonne+Config[3]+2)*2];
	   Inc(Config[3]);
	   AfficheTexte(Config[3],0,Config[3]+39,21,Mem[AdresseEcran:4000]);
	  End;
	 End;
    80 : Begin
	  If(Position<13)Then Inc(Position)
			 Else Position := 0;
	 End;
   End;
 Until (Lo(Touche) in [13,27]);
 Touche := 0;
 Move(Tableau^,Mem[AdresseEcran:$00],4000);
 InLine($B4/$01/
	$B1/$07/
	$B5/$06/
	$CD/$10);
End;

Procedure ImprimeListe;
Label 10,20,30,40,50,100,200,300,Fin;
Var ChaineTem     : String[64];
    Position      : Byte;
    Ligne1,Ligne2 : Word;
    ErreurByte    : Byte;
    Resultat      : Byte;
    Sauve         : Boolean;
    Tableau	  : Pointer;

 Function TraiteErreur : Byte;
 Var Tableau  : Pointer;
     TableauA : Pointer;
     TableauB : Pointer;
 Begin
  FermeCurseur;
  GetMem(Tableau,4000);
  GetMem(TableauA,4000);
  GetMem(TableauB,4000);
  Move(Mem[AdresseEcran:$00],Tableau^,4000);
  If(Sauve=False)Then
  Begin
   CadreVide(7,5,72,18,47,0);
   SauvegardeTexte(Config[1],Config[2],Config[1]+61,Config[2]+12,TableauB^);
   CadrePlain(Config[1],Config[2],Config[1]+59,Config[2]+11,79,1);
   CentreEcriture(Config[2]+3,'Erreur Imprimante',78);
   Localise(Config[1]+5,Config[2]+5);
   Ecrit('L''imprimante n''est pas prˆte',79);
   Localise(Config[1]+5,Config[2]+7);
   Ecrit('Enter ',94);
   Localise(Config[1]+13,Config[2]+7);
   Ecrit('- Pour reprendre l''execution',79);
   Localise(Config[1]+5,Config[2]+8);
   Ecrit('Escape',112);
   Localise(Config[1]+13,Config[2]+8);
   Ecrit('- Pour retourner a l''‚diteur',79);
   SauvegardeTexte(Config[1],Config[2],Config[1]+61,Config[2]+12,TableauA^);
   Sauve := True;
  End
   else
  Begin
   AfficheTexte(Config[1],Config[2],Config[1]+61,Config[2]+12,TableauB^);
   AfficheTexte(Config[1],Config[2],Config[1]+61,Config[2]+12,TableauA^);
  End;
  Repeat
   Touche := LitClavier;
   Case Hi(Touche) of
    72 : Begin
	  If(Config[2]>0)Then
	  Begin
	   AfficheTexte(Config[1],Config[2],Config[1]+61,Config[2]+12,TableauB^);
	   Dec(Config[2]);
	   SauvegardeTexte(Config[1],Config[2],Config[1]+61,Config[2]+12,TableauB^);
	   AfficheTexte(Config[1],Config[2],Config[1]+61,Config[2]+12,TableauA^);
	  End;
	 End;
    75 : Begin
	  If(Config[1]>0)Then
	  Begin
	   AfficheTexte(Config[1],Config[2],Config[1]+61,Config[2]+12,TableauB^);
	   Dec(Config[1]);
	   SauvegardeTexte(Config[1],Config[2],Config[1]+61,Config[2]+12,TableauB^);
	   AfficheTexte(Config[1],Config[2],Config[1]+61,Config[2]+12,TableauA^)
	  End;
	 End;
    77 : Begin
	  If(Config[1]+59<79)Then
	  Begin
	   AfficheTexte(Config[1],Config[2],Config[1]+61,Config[2]+12,TableauB^);
	   Inc(Config[1]);
	   SauvegardeTexte(Config[1],Config[2],Config[1]+61,Config[2]+12,TableauB^);
	   AfficheTexte(Config[1],Config[2],Config[1]+61,Config[2]+12,TableauA^);
	  End;
	 End;
    80 : Begin
	  If(Config[2]+11<22)Then
	  Begin
	   AfficheTexte(Config[1],Config[2],Config[1]+61,Config[2]+12,TableauB^);
	   Inc(Config[2]);
	   SauvegardeTexte(Config[1],Config[2],Config[1]+61,Config[2]+12,TableauB^);
	   AfficheTexte(Config[1],Config[2],Config[1]+61,Config[2]+12,TableauA^);
	  End;
	 End;
   End;
  Until (Lo(Touche) in [13,27]);
  If(Lo(Touche)=27)Then TraiteErreur := 0
		   Else TraiteErreur := 1;
  Move(Tableau^,Mem[AdresseEcran:$00],4000);
  FreeMem(Tableau,4000);
  FreeMem(TableauA,4000);
  FreeMem(TableauB,4000);
  InLine($B4/$01/
	 $B1/$07/
	 $B5/$06/
	 $CD/$10);
 End;

Begin
 Sauve := False;
 GetMem(Tableau,4000);
 Move(Mem[AdresseEcran:$00],Tableau^,4000);
 CadrePlain(5,4,74,19,47,1);
 CentreEcriture(7,'Imprime la Liste',46);
 Localise(10,10);
 Ecrit('J''imprime de la ligne :',47);
 FillChar(ChaineTem[0],64,0);
 Position := 0;
 30 : Repeat
  Localise(34+Position,10);
  Touche := LitClavier;
  Case Hi(Touche) of
   60 : AjustementImprimante;
   71 : Position := 0;
   75 : Begin
	 If(Position=0)Then
	 Begin
	  Sound(500);
	  Delay(100);
	  NoSound;
	 End
	  else
	 Dec(Position);
	End;
   77 : Begin
	 If(Position=30)Then
	 Begin
	  Sound(500);
	  Delay(100);
	  NoSound;
	 End
	  else
	 Inc(Position);
	End;
   79 : Position := Ord(ChaineTem[0]);
   83 : Begin
	 Delete(ChaineTem,Position+1,1);
	 Localise(34,10);
	 Ecrit(ChaineTem+'  ',46);
	End;
  End;
  If((Lo(Touche)=8)and((Mem[$0040:$17] and $04)=0))Then
  Begin
   If(Position>0)and(Position=Mem[Seg(ChaineTem[0]):Ofs(ChaineTem[0])])Then
   Begin
    Chaine  := Copy(ChaineTem,1,Length(ChaineTem)-1);
    ChaineTem := Chaine;
    Localise(34,10);
    Ecrit(ChaineTem+'  ',46);
    Dec(Position);
   End
    else
   If(Position>0)Then
   Begin
    Delete(ChaineTem,Position+1,1);
    Localise(34,10);
    Ecrit(ChaineTem+'  ',46);
    Dec(Position);
   End
    else
   Begin
    Sound(500);
    Delay(100);
    NoSound;
   End;
  End
   else
  If((Hi(Touche)=32)and(Position<26))Then
  Begin
   Mem[Seg(ChaineTem[1]):Ofs(ChaineTem[1])+Position]   := Ord('D');
   Mem[Seg(ChaineTem[1]):Ofs(ChaineTem[1])+Position+1] := Ord('e');
   Mem[Seg(ChaineTem[1]):Ofs(ChaineTem[1])+Position+2] := Ord('b');
   Mem[Seg(ChaineTem[1]):Ofs(ChaineTem[1])+Position+3] := Ord('u');
   Mem[Seg(ChaineTem[1]):Ofs(ChaineTem[1])+Position+4] := Ord('t');
   Localise(34+Position,10);
   Ecrit('Debut',46);
   Inc(Position,5);
   If(Mem[Seg(ChaineTem[0]):Ofs(ChaineTem[0])]<Position)Then
   Begin
    Mem[Seg(ChaineTem[0]):Ofs(ChaineTem[0])] := Position;
    Mem[AdresseEcran:(34+Position+10*Colonne)*2+1] := 46;
    Mem[AdresseEcran:(34+Position+10*Colonne)*2] := 32
   End;
  End
   else
  If((Lo(Touche)>31)and(Position<30))Then
  Begin
   Mem[Seg(ChaineTem[1]):Ofs(ChaineTem[1])+Position] := Lo(Touche);
   EcritUnCaractere(34+Position,10,Lo(Touche),46);
   Inc(Position);
   If(Mem[Seg(ChaineTem[0]):Ofs(ChaineTem[0])]<Position)Then
   Begin
    Mem[Seg(ChaineTem[0]):Ofs(ChaineTem[0])] := Position;
    Mem[AdresseEcran:(34+Position+10*Colonne)*2+1] := 46;
    Mem[AdresseEcran:(34+Position+10*Colonne)*2] := 32
   End;
  End;
 Until (Lo(Touche) in [13,27]);
 For Compteur := 1 to Length(ChaineTem) do
 Begin
  ChaineTem[Compteur] := UpCase(ChaineTem[Compteur]);
 End;
 If((ChaineTem='DEBUT')or(ChaineTem=''))Then
 Begin
  Ligne1 := 0;
  If(ChaineTem = '')Then
  Begin
   Localise(34,10);
   Ecrit('Debut',46);
  End;
 End
  else
 Begin
  Val(ChaineTem,Ligne1,Erreur);
  CentreEcriture(12,'Erreur de limitation',172);
  If(Erreur<>0)Then Goto 30;
 End;
 FillChar(ChaineTem[0],64,0);
 Position := 0;
 CentreEcriture(12,Espace(23),34);
 Localise(10,12);
 Ecrit('A la ligne :',47);
 If(Lo(Touche)<>27)Then
 Begin
 40 : Repeat
  Localise(23+Position,12);
  Touche := LitClavier;
  Case Hi(Touche) of
   60 : AjustementImprimante;
   71 : Position := 0;
   75 : Begin
	 If(Position=0)Then
	 Begin
	  Sound(500);
	  Delay(100);
	  NoSound;
	 End
	  else
	 Dec(Position);
	End;
   77 : Begin
	 If(Position=30)Then
	 Begin
	  Sound(500);
	  Delay(100);
	  NoSound;
	 End
	  else
	 Inc(Position);
	End;
   79 : Position := Ord(ChaineTem[0]);
   83 : Begin
	 Delete(ChaineTem,Position+1,1);
	 Localise(23,12);
	 Ecrit(ChaineTem+'  ',46);
	End;
  End;
  If((Lo(Touche)=8)and((Mem[$0040:$17] and $04)=0))Then
  Begin
   If(Position>0)and(Position=Mem[Seg(ChaineTem[0]):Ofs(ChaineTem[0])])Then
   Begin
    Chaine  := Copy(ChaineTem,1,Length(ChaineTem)-1);
    ChaineTem := Chaine;
    Localise(23,12);
    Ecrit(ChaineTem+'  ',46);
    Dec(Position);
   End
    else
   If(Position>0)Then
   Begin
    Delete(ChaineTem,Position+1,1);
    Localise(23,12);
    Ecrit(ChaineTem+'  ',46);
    Dec(Position);
   End
    else
   Begin
    Sound(500);
    Delay(100);
    NoSound;
   End;
  End
   else
  If((Hi(Touche)=33)and(Position<27))Then
  Begin
   Mem[Seg(ChaineTem[1]):Ofs(ChaineTem[1])+Position]   := Ord('F');
   Mem[Seg(ChaineTem[1]):Ofs(ChaineTem[1])+Position+1] := Ord('i');
   Mem[Seg(ChaineTem[1]):Ofs(ChaineTem[1])+Position+2] := Ord('n');
   Localise(23+Position,12);
   Ecrit('Fin',46);
   Inc(Position,3);
   If(Mem[Seg(ChaineTem[0]):Ofs(ChaineTem[0])]<Position)Then
   Begin
    Mem[Seg(ChaineTem[0]):Ofs(ChaineTem[0])] := Position;
    Mem[AdresseEcran:(23+Position+12*Colonne)*2+1] := 46;
    Mem[AdresseEcran:(23+Position+12*Colonne)*2] := 32
   End;
  End
   else
  If((Lo(Touche)>31)and(Position<30))Then
  Begin
   Mem[Seg(ChaineTem[1]):Ofs(ChaineTem[1])+Position] := Lo(Touche);
   EcritUnCaractere(23+Position,12,Lo(Touche),46);
   Inc(Position);
   If(Mem[Seg(ChaineTem[0]):Ofs(ChaineTem[0])]<Position)Then
   Begin
    Mem[Seg(ChaineTem[0]):Ofs(ChaineTem[0])] := Position;
    Mem[AdresseEcran:(23+Position+12*Colonne)*2+1] := 46;
    Mem[AdresseEcran:(23+Position+12*Colonne)*2] := 32
   End;
  End;
 Until (Lo(Touche) in [13,27]);
 End;
 For Compteur := 1 to Length(ChaineTem) do
 Begin
  ChaineTem[Compteur] := UpCase(ChaineTem[Compteur]);
 End;
 If((ChaineTem='FIN')or(ChaineTem=''))Then
 Begin
  Ligne2 := FinList;
  If(ChaineTem='')Then
  Begin
   Localise(23,12);
   Ecrit('Fin',46);
  End;
 End
  else
 Begin
  Val(ChaineTem,Ligne2,Erreur);
  CentreEcriture(14,'Erreur de limitation',172);
  If(Erreur<>0)Then Goto 40;
 End;
 CentreEcriture(14,Espace(23),34);
 If(Lo(Touche)<>27)Then
 Begin
  Localise(10,14);
  Ecrit('Numero d''imprimante :',47);
  EcritUnCaractere(32,14,$31+Numero,46);
  Localise(32,14);
  50 : Touche := LitClavier;
  If(Hi(Touche)=60)Then AjustementImprimante
   else
  If(Lo(Touche) in [$31,$32,$33])Then
  Begin
   Numero := Lo(Touche) - $31;
  End
   else
  If Not(Lo(Touche) in [67,99,13,27])Then
  Begin
   Sound(500);
   Delay(100);
   NoSound;
   Goto 50;
  End;
 End;
 If(Lo(Touche)<>27)Then
 Begin
100:ErreurByte := InitialiseImprimante(Numero);
  If(ErreurByte <> 144)Then
  Begin
   Resultat := TraiteErreur;
   If(Resultat = 0)Then Goto Fin
		   Else Goto 100;
  End;
  For Compteur := Ligne1 to Ligne2 do
  Begin
   Str(Compteur:4,Chaine);
200:ErreurByte := EcritImprimante(Numero,Chaine);
   If(ErreurByte <> 144)Then
   Begin
    Resultat := TraiteErreur;
    If(Resultat = 0)Then Goto Fin
		    Else Goto 100;
   End;
300:ErreurByte := EcritImprimante(Numero,'³');
   If(ErreurByte <> 144)Then
   Begin
    Resultat := TraiteErreur;
    If(Resultat = 0)Then Goto Fin
		    Else Goto 200;
   End;
  End;
 End;
 Fin : Move(Tableau^,Mem[AdresseEcran:$00],4000);
 FreeMem(Tableau,4000);
 Touche := 0;
End;
