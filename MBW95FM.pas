unit MBW95FM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, FileCtrl;

type
  TFileManager = class(TForm)
    FileListBox1: TFileListBox;
    FileListBox2: TFileListBox;
    procedure SiFermeture(Sender: TObject; var Action: TCloseAction);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  FileManager: TFileManager;

implementation

{$R *.DFM}

procedure TFileManager.SiFermeture(Sender: TObject;
  var Action: TCloseAction);
begin
 Action:=caFree;
end;

end.
