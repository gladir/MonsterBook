unit UnitApropos;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons;

type
  TFormAPropos = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    Button1: TBitBtn;
    procedure Button1Click(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  FormAPropos: TFormAPropos;

implementation

{$R *.DFM}

procedure TFormAPropos.Button1Click(Sender: TObject);
begin
Close;
end;

end.
