program SeMal;

uses
  Forms,
  UnitMain in 'UnitMain.pas' {FormMain},
  UnitAnonymous in 'UnitAnonymous.pas' {Anonymous},
  UnitApropos in 'UnitApropos.pas' {FormAPropos},
  UnitBaseReg in 'UnitBaseReg.pas' {FormRegWindows};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TAnonymous, Anonymous);
  Application.CreateForm(TFormAPropos, FormAPropos);
  Application.CreateForm(TFormRegWindows, FormRegWindows);
  Application.Run;
end.
