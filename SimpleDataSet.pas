unit SimpleDataSet;

interface

uses
  System.Classes, Datasnap.DBClient, Datasnap.Provider, Data.DB, System.SysUtils,
  Functions;

type
  TSimpleDataSet = class(TComponent)
  private
    FClientDataSet: TClientDataSet;
    FDataSetProvider: TDataSetProvider;
    FQuery: TDataSet;
  public
    constructor Create(AOwner: TComponent; AQuery: TDataSet); reintroduce; overload;
    property ClientDataSet: TClientDataSet read FClientDataSet;
    property DataSetProvider: TDataSetProvider read FDataSetProvider;
    property Query: TDataSet read FQuery;
  end;

implementation

{ TSimpleDataSet }

constructor TSimpleDataSet.Create(AOwner: TComponent; AQuery: TDataSet);
begin
  Create(AOwner);
  FQuery := AQuery;
  FQuery.Name := GenerateUniqueNameFromOwner(FQuery.Owner, 'qry_' + AOwner.Name);

  FDataSetProvider := TDataSetProvider.Create(AOwner);
  FDataSetProvider.DataSet := FQuery;
  FDataSetProvider.Options := [
    poCascadeDeletes, poCascadeUpdates, poAutoRefresh,
    poPropogateChanges, poAllowCommandText
  ];
//  FDataSetProvider.UpdateMode := upWhereAll;
  FDataSetProvider.UpdateMode := upWhereKeyOnly;
  FDataSetProvider.Name := GenerateUniqueNameFromOwner(FDataSetProvider.Owner, 'dsp_' + AOwner.Name);

  FClientDataSet := TClientDataSet.Create(AOwner);
  FClientDataSet.Name := GenerateUniqueNameFromOwner(FClientDataSet.Owner, 'cds_' + AOwner.Name);
  FClientDataSet.ProviderName := FDataSetProvider.Name;
  FClientDataSet.FetchParams;

end;

end.
