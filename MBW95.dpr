program MBW95;

uses
  Forms,
  MBW95U1 in 'MBW95U1.pas' {MonsterBook},
  MBW95EDT in 'MBW95EDT.pas' {TextEditor},
  MBW95FM in 'MBW95FM.pas' {FileManager},
  Mbwabout in 'MBWABOUT.PAS' {AboutBox},
  Systex,Systems{,Dials,Graphics};

{$R *.RES}

{Var
 W:Wins;}

begin
  InitSystems(suIsabel);
  Application.Initialize;
  Application.Title := 'MonsterBook';
  Application.CreateForm(TMonsterBook, MonsterBook);
  Application.CreateForm(TAboutBox, AboutBox);
{  FillChar(W,SizeOf(W),0);
  W.Canvas:=MonsterBook.Canvas;
  W.CurrColor:=$1F;
  WESetCube(W,0,0,'A');}
  Application.Run;
end.
