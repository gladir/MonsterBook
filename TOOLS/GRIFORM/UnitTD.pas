unit UnitTD;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, Db, DBTables;

type
  TErreurTurboDebug = class(TForm)
    Database1: TDatabase;
    QueryTD: TQuery;
    DataSourceTD: TDataSource;
    DBGrid1: TDBGrid;
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  ErreurTurboDebug: TErreurTurboDebug;

implementation

{$R *.DFM}

end.
