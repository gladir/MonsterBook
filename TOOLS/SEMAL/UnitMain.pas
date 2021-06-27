unit UnitMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ExtCtrls;

type
  TFormMain = class(TForm)
    MainMenu1: TMainMenu;
    Fichier: TMenuItem;
    Quitter1: TMenuItem;
    Aide1: TMenuItem;
    APropos1: TMenuItem;
    Outil1: TMenuItem;
    MettreWindowsanonyme1: TMenuItem;
    RactiverlidentificationWindowspossible1: TMenuItem;
    Information1: TMenuItem;
    DirectX1: TMenuItem;
    Image1: TImage;
    Image2: TImage;
    ConfigurationIP1: TMenuItem;
    N1: TMenuItem;
    Image3: TImage;
    Configurer1: TMenuItem;
    BasederegistresdeWindows1: TMenuItem;
    diteurmanuellementlabasederegistres1: TMenuItem;
    N2: TMenuItem;
    procedure Quitter1Click(Sender: TObject);
    procedure MettreWindowsanonyme1Click(Sender: TObject);
    procedure RactiverlidentificationWindowspossible1Click(
      Sender: TObject);
    procedure APropos1Click(Sender: TObject);
    procedure DirectX1Click(Sender: TObject);
    procedure ConfigurationIP1Click(Sender: TObject);
    procedure BasederegistresdeWindows1Click(Sender: TObject);
    procedure diteurmanuellementlabasederegistres1Click(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  FormMain: TFormMain;

implementation

uses UnitAnonymous, UnitApropos, UnitBaseReg;

{$R *.DFM}

procedure TFormMain.Quitter1Click(Sender: TObject);
begin
 Halt;
end;

procedure TFormMain.MettreWindowsanonyme1Click(Sender: TObject);
begin
 Anonymous.ShowModal;
end;

procedure TFormMain.RactiverlidentificationWindowspossible1Click(
  Sender: TObject);
Var
 PWinPath,Target:Array[Byte]of Char;
 Erreur:Word;
begin
 GetWindowsDirectory(@PWinPath,SizeOf(PWinPath));
 Target:='regsvr32.exe -c ';
 StrCat(Target,PWinPath);
 StrCat(Target,'\system\regwizc.dll');
 Erreur:=WinExec(Target,SW_HIDE);
 If Not((Erreur=0)or(Erreur=16791))Then Begin
  MessageDlg('Impossible d''effectuer l''opération demander!',mtError,[mbOk],0);
 End
  Else
 Begin
  MessageDlg('Opération correctement effectuer!',mtInformation,[mbOk],0);
 End;
end;

procedure TFormMain.APropos1Click(Sender: TObject);
begin
FormAPropos.ShowModal;
end;

procedure TFormMain.DirectX1Click(Sender: TObject);
{Var
 Erreur:Word;}
begin
 {Erreur:=}WinExec('DXDIAG.EXE',SW_SHOW);
 {If Not((Erreur=0)or(Erreur=22951))Then Begin
  MessageDlg('DIRECT X introuvable, non ou mal installé!',mtError,[mbOk],0);
 End;}
end;

procedure TFormMain.ConfigurationIP1Click(Sender: TObject);
begin
 WinExec('WINIPCFG.EXE',SW_SHOW);
end;

procedure TFormMain.BasederegistresdeWindows1Click(Sender: TObject);
begin
 FormRegWindows.FormCreate(Sender);
 FormRegWindows.ShowModal;
end;

procedure TFormMain.diteurmanuellementlabasederegistres1Click(
  Sender: TObject);
begin
 WinExec('REGEDIT.EXE',SW_SHOW);
end;

end.
