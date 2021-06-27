unit Mbwabout;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls;

type
  TAboutBox = class(TForm)
    Panel1: TPanel;
    OKButton: TBitBtn;
    ProgramIcon: TImage;
    ProductName: TLabel;
    Version: TLabel;
    Copyright: TLabel;
    Comments: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure OKButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AboutBox: TAboutBox;

implementation

Uses Systex,Dials;

{$R *.DFM}

procedure TAboutBox.OKButtonClick(Sender: TObject);
{Var W:Wins;}
begin
{ WEInitWindows(W,Canvas);
 WESetKr(W,$1E);
 WESetCube(W,0,0,'A');
 WEPutTxtXY(W,1,0,'Salut');}
Close;
end;

end.

