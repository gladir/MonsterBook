unit UnitDisqueDur;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, Db, DBTables;

type
  TFormDisqueDur = class(TForm)
    DatabaseDisqueDur: TDatabase;
    QueryDisqueDur: TQuery;
    DataSourceDisqueDur: TDataSource;
    DBGrid1: TDBGrid;
  private
    { D�clarations priv�es }
  public
    { D�clarations publiques }
  end;

var
  FormDisqueDur: TFormDisqueDur;

implementation

{$R *.DFM}

end.
