unit SamplesGenesisWindows;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Systex,Systems,Dials;

type
  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
   W:Window;
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.FormCreate(Sender: TObject);
begin
 WEInitWindows(W,Canvas);
 WESetChr(W,1,1,'Z');
 W.Canvas.Refresh;
end;

procedure TForm1.FormPaint(Sender: TObject);
begin
 W.CurrColor:=$F0;
 WESetChr(W,0,0,'X');
 Canvas.TextOut(100,100,'Merde!');
 Canvas.MoveTo(0,0);
 Canvas.LineTo(300,300);
 Canvas.MoveTo(0,0);
 Canvas.LineTo(300,300);
end;

end.
