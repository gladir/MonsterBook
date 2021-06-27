unit UnitStandardReseau;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, Db, DBTables;

type
  TFormStandardReseau = class(TForm)
    DatabaseStandardReseau: TDatabase;
    QueryStandardReseau: TQuery;
    DataSourceStandardReseau: TDataSource;
    DBGrid1: TDBGrid;
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  FormStandardReseau: TFormStandardReseau;

implementation

{$R *.DFM}

end.
