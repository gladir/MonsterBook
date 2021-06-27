program Griform;

uses
  Forms,
  UnitGriform in 'UnitGriform.pas' {MainGriform},
  UnitCommodore64 in 'UnitCommodore64.pas' {ErreurCommodore64},
  UnitTD in 'UnitTD.pas' {ErreurTurboDebug},
  UnitQP in 'UnitQP.pas' {ErreurQP},
  UnitDisqueDur in 'UnitDisqueDur.pas' {FormDisqueDur},
  UnitStandardReseau in 'UnitStandardReseau.pas' {FormStandardReseau};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Griform - Grimoire Informatique';
  Application.CreateForm(TMainGriform, MainGriform);
  Application.CreateForm(TErreurCommodore64, ErreurCommodore64);
  Application.CreateForm(TErreurTurboDebug, ErreurTurboDebug);
  Application.CreateForm(TErreurQP, ErreurQP);
  Application.CreateForm(TFormDisqueDur, FormDisqueDur);
  Application.CreateForm(TFormStandardReseau, FormStandardReseau);
  Application.Run;
end.
