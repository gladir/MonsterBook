unit Mbwunit;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, Menus, StdCtrls, ExtCtrls{, VBXCtrl, Pict};

type
  TMainForm = class(TForm)
    MainMenu1: TMainMenu;
    Fichier1: TMenuItem;
    Dessin1: TMenuItem;
    Nouveautexte1: TMenuItem;
    Ouvrirtexte1: TMenuItem;
    Ouvrir1: TMenuItem;
    Insertiondunfichier1: TMenuItem;
    N1: TMenuItem;
    Nouveaudocument1: TMenuItem;
    Ouvredocument1: TMenuItem;
    N2: TMenuItem;
    RegardeHexadcimal1: TMenuItem;
    RegardeAscii1: TMenuItem;
    N3: TMenuItem;
    Nouveautableur1: TMenuItem;
    Ouvrirtableur1: TMenuItem;
    N4: TMenuItem;
    Sauve1: TMenuItem;
    Soussous1: TMenuItem;
    Sauvegardetous1: TMenuItem;
    N5: TMenuItem;
    Changerpertoire1: TMenuItem;
    Crerunrpertoire1: TMenuItem;
    Imprime1: TMenuItem;
    InterprteurDOS1: TMenuItem;
    Quitter1: TMenuItem;
    Nouveau1: TMenuItem;
    Ouvre1: TMenuItem;
    N6: TMenuItem;
    NouvelIcon1: TMenuItem;
    OuvreIcon1: TMenuItem;
    N7: TMenuItem;
    NouvelPolice1: TMenuItem;
    OuvrePolice1: TMenuItem;
    N8: TMenuItem;
    CataloguedImage1: TMenuItem;
    Edition1: TMenuItem;
    Annulation1: TMenuItem;
    Assembleur1: TMenuItem;
    Basic1: TMenuItem;
    CC1: TMenuItem;
    Dessin2: TMenuItem;
    Euphoria1: TMenuItem;
    Fortran1: TMenuItem;
    Gat1: TMenuItem;
    Gat2: TMenuItem;
    Iniation1: TMenuItem;
    Macrotexte1: TMenuItem;
    Recherche1: TMenuItem;
    Menu1: TMenuItem;
    Pascal1: TMenuItem;
    Ressource1: TMenuItem;
    Tableur1: TMenuItem;
    Trouve1: TMenuItem;
    Remplacer1: TMenuItem;
    Essaieencore1: TMenuItem;
    N9: TMenuItem;
    Ligne1: TMenuItem;
    Colonne1: TMenuItem;
    Page1: TMenuItem;
    Procedure1: TMenuItem;
    Commande1: TMenuItem;
    Alleraudbut1: TMenuItem;
    Allerlafin1: TMenuItem;
    N10: TMenuItem;
    Tri1: TMenuItem;
    Filtre1: TMenuItem;
    N11: TMenuItem;
    Verbe1: TMenuItem;
    N12: TMenuItem;
    Mnagrededisque1: TMenuItem;
    Aide1: TMenuItem;
    Apropos1: TMenuItem;
    Conversion1: TMenuItem;
    N13: TMenuItem;
    Information1: TMenuItem;
    Sommaire1: TMenuItem;
    SommaireVido1: TMenuItem;
    Pays1: TMenuItem;
    CartedeSon1: TMenuItem;
    N14: TMenuItem;
    Souris1: TMenuItem;
    ManettedeJeux1: TMenuItem;
    Clavier1: TMenuItem;
    N15: TMenuItem;
    InformationMmoire1: TMenuItem;
    CMOS1: TMenuItem;
    N16: TMenuItem;
    DisqueLogique1: TMenuItem;
    Partition1: TMenuItem;
    ChangerlenomdeVolume1: TMenuItem;
    Regardedisquehexadcimal1: TMenuItem;
    Excutiondunecommande1: TMenuItem;
    Excuterlconomiseurdcran1: TMenuItem;
    Videletampondimpression1: TMenuItem;
    Sucker: TLabel;
    Fenetre1: TMenuItem;
    Ferme1: TMenuItem;
    N17: TMenuItem;
    MonsterBookpourDOS1: TMenuItem;
    procedure Quitter1Click(Sender: TObject);
    procedure Crerunrpertoire1Click(Sender: TObject);
    procedure Apropos1Click(Sender: TObject);
    procedure Sommaire1Click(Sender: TObject);
    procedure Nouveautexte1Click(Sender: TObject);
    procedure QuitterVraiment(Sender: TObject; var CanClose: Boolean);
    procedure InterprteurDOS1Click(Sender: TObject);
    procedure MonsterBookpourDOS1Click(Sender: TObject);
  private
    { Déclarations private }
  public
    { Déclarations public }
  end;

var
  MainForm: TMainForm;

implementation

Uses Adele,Systex,Systems,Video,Dials,MbwAbout,MbwInfo,MBWEdit,
     WinDos,DialPlus;

{$R *.DFM}
{$H-}

procedure TMainForm.Quitter1Click(Sender: TObject);
begin
  Close; { Termine le programme à cette endroit }
end;

procedure TMainForm.Crerunrpertoire1Click(Sender: TObject);
Var S:String;
begin
  S:='';
  If(_WinInp(40,'Création Répertoire',
             'Nom du répertore à créer:',No,S)=kbEnter)Then
   MkDir(S);
end;

procedure TMainForm.Apropos1Click(Sender: TObject);
begin
 AboutBox.ShowModal;
end;

procedure TMainForm.Sommaire1Click(Sender: TObject);
begin
 InfoSomary.Run;
end;

procedure TMainForm.Nouveautexte1Click(Sender: TObject);
Var Edit:TEditorWin;
begin
 Edit:=TEditorWin.Create(Application);
 Edit.NewText;
 Edit.Run;
end;

procedure TMainForm.QuitterVraiment(Sender: TObject;
  var CanClose: Boolean);
begin
 CanClose:=__InputExit('Voulez-vous vraiment quitter '+
                       'le MonsterBook pour Windows?');
end;

Procedure TMainForm.InterprteurDOS1Click(Sender: TObject);Begin
 WinExec(GetEnvVar('COMSPEC'),SW_SHOW);
End;

procedure TMainForm.MonsterBookpourDOS1Click(Sender: TObject);
Var Path:Array[Byte]of Char;I:Byte;Begin
 StrCopy(@Path,PChr(GetEnvVar('MALTE')));
 If IsPChrEmpty(@Path)Then StrPCopy(@Path,'\MALTE');
 For I:=0to 255do If Path[I]=#0Then Begin
  If Path[I-1]<>'\'Then Begin;Path[I]:='\';Path[I+1]:=#0;End;
  Break;
 End;
 StrCatPas(@Path,'MB.EXE /NOPRESENTATION /NOLUXE');
 WinExec(Path,SW_SHOW);
end;

END.
