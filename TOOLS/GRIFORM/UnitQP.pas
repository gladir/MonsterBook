unit UnitQP;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, Db, DBTables;

type
  TErreurQP = class(TForm)
    Database1: TDatabase;
    QueryQP: TQuery;
    DataSourceQP: TDataSource;
    DBGrid1: TDBGrid;
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  ErreurQP: TErreurQP;

implementation

{$R *.DFM}

end.
