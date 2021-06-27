unit UnitGriform;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus;

type
  TMainGriform = class(TForm)
    MainMenu1: TMainMenu;
    Fichier: TMenuItem;
    Quitter: TMenuItem;
    Table1: TMenuItem;
    Erreur1: TMenuItem;
    Commodore64K1: TMenuItem;
    TurboDebugger1: TMenuItem;
    QuickPascalpourDOS1: TMenuItem;
    Disquedur1: TMenuItem;
    Rseau1: TMenuItem;
    NormeetStandard1: TMenuItem;
    procedure Commodore64K1Click(Sender: TObject);
    procedure QuitterClick(Sender: TObject);
    procedure TurboDebugger1Click(Sender: TObject);
    procedure QuickPascalpourDOS1Click(Sender: TObject);
    procedure Disquedur1Click(Sender: TObject);
    procedure NormeetStandard1Click(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  MainGriform: TMainGriform;

implementation

uses UnitCommodore64, UnitTD, UnitQP, UnitDisqueDur, UnitStandardReseau;

{$R *.DFM}

procedure TMainGriform.Commodore64K1Click(Sender: TObject);
begin
ErreurCommodore64.Visible:=True;
end;

procedure TMainGriform.QuitterClick(Sender: TObject);
begin
Halt;
end;

procedure TMainGriform.TurboDebugger1Click(Sender: TObject);
begin
 ErreurTurboDebug.Visible:=True;
end;

procedure TMainGriform.QuickPascalpourDOS1Click(Sender: TObject);
begin
 ErreurQP.Visible:=True;
end;

procedure TMainGriform.Disquedur1Click(Sender: TObject);
begin
 FormDisqueDur.Visible:=True;
end;

procedure TMainGriform.NormeetStandard1Click(Sender: TObject);
begin
FormStandardReseau.visible:=True;
end;

end.
