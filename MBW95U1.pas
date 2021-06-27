unit MBW95U1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus;

type
  TMonsterBook = class(TForm)
    MainMenu1: TMainMenu;
    Fichier1: TMenuItem;
    Aide1: TMenuItem;
    Apropos1: TMenuItem;
    Quitter1: TMenuItem;
    Nouveautexte1: TMenuItem;
    Ouvrirtexte1: TMenuItem;
    N1: TMenuItem;
    OpenText: TOpenDialog;
    Fentre1: TMenuItem;
    Gestionnairedefichiers1: TMenuItem;
    procedure Apropos1Click(Sender: TObject);
    procedure Quitter1Click(Sender: TObject);
    procedure Nouveautexte1Click(Sender: TObject);
    procedure Ouvrirtexte1Click(Sender: TObject);
    procedure Gestionnairedefichiers1Click(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  MonsterBook: TMonsterBook;

implementation

uses MBW95EDT, MBW95FM, Mbwabout;

{$R *.DFM}

procedure TMonsterBook.Apropos1Click(Sender: TObject);
begin
 AboutBox.Visible:=True;
end;

procedure TMonsterBook.Quitter1Click(Sender: TObject);
begin
 Halt;
end;

procedure TMonsterBook.Nouveautexte1Click(Sender: TObject);
begin
 TTextEditor.Create(Self);
end;

procedure TMonsterBook.Ouvrirtexte1Click(Sender: TObject);
begin
 if OpenText.Execute then
   with TTextEditor.Create(Self) do
     Open(OpenText.FileName);
end;

procedure TMonsterBook.Gestionnairedefichiers1Click(Sender: TObject);
begin
 TFileManager.Create(Self);
end;

end.
