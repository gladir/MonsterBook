unit MBW95EDT;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, Menus;

type
  TTextEditor = class(TForm)
    MainMenu1: TMainMenu;
    Fichier1: TMenuItem;
    N1: TMenuItem;
    Ouvrirtexte1: TMenuItem;
    N2: TMenuItem;
    Sauvegarde1: TMenuItem;
    Sauvegardesous1: TMenuItem;
    EditName: TRichEdit;
    SaveText: TSaveDialog;
    N3: TMenuItem;
    Quitter1: TMenuItem;
    Aide1: TMenuItem;
    Apropos1: TMenuItem;
    Edition1: TMenuItem;
    Lectureseulement1: TMenuItem;
    N4: TMenuItem;
    Copier1: TMenuItem;
    Coller1: TMenuItem;
    Couper1: TMenuItem;
    Efface1: TMenuItem;
    N5: TMenuItem;
    SlectionneTous1: TMenuItem;
    N6: TMenuItem;
    Imprimer1: TMenuItem;
    Ajustementd1: TMenuItem;
    PrintText: TPrintDialog;
    PrinterSetupText: TPrinterSetupDialog;
    PopupMenu1: TPopupMenu;
    Couper2: TMenuItem;
    Copier2: TMenuItem;
    Coller2: TMenuItem;
    StatusBarText: TStatusBar;
    procedure SiFermeture(Sender: TObject; var Action: TCloseAction);
    procedure FeuilleCreer(Sender: TObject);
    procedure AppelFermeture(Sender: TObject; var CanClose: Boolean);
    procedure Sauvegarde1Click(Sender: TObject);
    procedure Sauvegardesous1Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure Quitter1Click(Sender: TObject);
    procedure Apropos1Click(Sender: TObject);
    procedure Ouvrirtexte1Click(Sender: TObject);
    procedure Lectureseulement1Click(Sender: TObject);
    procedure Couper1Click(Sender: TObject);
    procedure Copier1Click(Sender: TObject);
    procedure Coller1Click(Sender: TObject);
    procedure Efface1Click(Sender: TObject);
    procedure SlectionneTous1Click(Sender: TObject);
    procedure Imprimer1Click(Sender: TObject);
    procedure Ajustementd1Click(Sender: TObject);
    procedure Couper2Click(Sender: TObject);
    procedure Copier2Click(Sender: TObject);
    procedure Coller2Click(Sender: TObject);
    procedure ContextMenu(Sender: TObject);
    procedure EtatLigne(Sender: TObject);
  private
    { Déclarations privées }
   PathName: string;
  public
    { Déclarations publiques }
   procedure Open(const AFileName: string);
  end;

var
  TextEditor: TTextEditor;

Const
 DefaultFileName='sansnom';

implementation

uses MBW95U1;

{$R *.DFM}

procedure TTextEditor.SiFermeture(Sender: TObject;
  var Action: TCloseAction);
begin
 Action:=caFree;
end;

procedure TTextEditor.FeuilleCreer(Sender: TObject);
begin
 PathName:=DefaultFileName;
end;

procedure TTextEditor.AppelFermeture(Sender: TObject;
  var CanClose: Boolean);
begin
 If(EditName.Modified)Then Begin
  Case MessageDlg(Format('Dois-je sauvegarde les changements de %s?',
                  [PathName]),mtConfirmation,[mbYes,mbNo,mbCancel],0)of
   idYes: Sauvegarde1Click(Self);
   idCancel: CanClose := False;
  End;
 End;
end;

procedure TTextEditor.Sauvegarde1Click(Sender: TObject);
begin
 If(PathName=DefaultFileName)Then SauvegardeSous1Click(Sender)
  Else
 Begin
  EditName.Lines.SaveToFile(PathName);
  EditName.Modified := False;
  StatusBarText.SimpleText:='';
 End;
end;

procedure TTextEditor.Sauvegardesous1Click(Sender: TObject);
begin
 SaveText.FileName:=PathName;
 If(SaveText.Execute)Then Begin
  PathName:=SaveText.FileName;
  Caption:=ExtractFileName(PathName);
  Sauvegarde1Click(Sender);
 End;
end;

procedure TTextEditor.N1Click(Sender: TObject);
begin
 MonsterBook.NouveauTexte1Click(Sender);
end;

procedure TTextEditor.Quitter1Click(Sender: TObject);
begin
 MonsterBook.Quitter1Click(Sender);
end;

procedure TTextEditor.Apropos1Click(Sender: TObject);
begin
 MonsterBook.Apropos1Click(Sender);
end;

Procedure TTextEditor.Open(Const AFileName:String);Begin
 PathName:=AFileName;
 Caption:=ExtractFileName(AFileName);
 With EditName do begin
  Lines.LoadFromFile(PathName);
  SelStart:=0;
  Modified:=False;
 End;
End;

procedure TTextEditor.Ouvrirtexte1Click(Sender: TObject);
begin
 MonsterBook.OuvrirTexte1Click(Sender);
end;

procedure TTextEditor.Lectureseulement1Click(Sender: TObject);
begin
 EditName.ReadOnly:=Not EditName.ReadOnly;
 Lectureseulement1.Checked:=EditName.ReadOnly;
end;

procedure TTextEditor.Couper1Click(Sender: TObject);
begin
 EditName.CutToClipboard;
end;

procedure TTextEditor.Copier1Click(Sender: TObject);
begin
 EditName.CopyToClipboard;
end;

procedure TTextEditor.Coller1Click(Sender: TObject);
begin
 EditName.PasteFromClipboard;
end;

procedure TTextEditor.Efface1Click(Sender: TObject);
begin
 EditName.ClearSelection;
end;

procedure TTextEditor.SlectionneTous1Click(Sender: TObject);
begin
 EditName.SelectAll;
end;

procedure TTextEditor.Imprimer1Click(Sender: TObject);
begin
 If(PrintText.Execute)Then EditName.Print(PathName);
end;

procedure TTextEditor.Ajustementd1Click(Sender: TObject);
begin
 PrinterSetupText.Execute;
end;

procedure TTextEditor.Couper2Click(Sender: TObject);
begin
 EditName.CutToClipboard;
end;

procedure TTextEditor.Copier2Click(Sender: TObject);
begin
 EditName.CopyToClipboard;
end;

procedure TTextEditor.Coller2Click(Sender: TObject);
begin
 EditName.PasteFromClipboard;
end;

procedure TTextEditor.ContextMenu(Sender: TObject);
var
  HasSelection: Boolean;
begin
  Coller1.Enabled:={Clipboard.HasFormat(CF_TEXT)}True;
  Coller2.Enabled:=Coller1.Enabled;
  HasSelection:=EditName.SelLength > 0;
  Couper1.Enabled:=HasSelection;
  Couper2.Enabled:=HasSelection;
  Copier1.Enabled:=HasSelection;
  Copier2.Enabled:=HasSelection;
  Efface1.Enabled:=HasSelection;
end;

procedure TTextEditor.EtatLigne(Sender: TObject);
begin
 StatusBarText.SimpleText:='Modifié';
end;

end.
