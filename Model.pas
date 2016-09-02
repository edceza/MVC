unit Model;

interface

uses
  System.Classes, GlobalInterfaces, Data.DB, Datasnap.DBClient, SimpleDataSet,
  dm_Custom;

type
  TModel = class(TdmCustom, IModel)
  protected
    procedure DataSetAfterOpen(DataSet: TDataSet); virtual;
    procedure ApplyUpdates(UpdateKind: TUpdateKind = ukModify); virtual;
    procedure Commit(Transaction: TObject); virtual;
    procedure Rollback(Transaction: TObject); virtual;
    function StartTransaction: TObject; virtual;
  private
    FSimpleDataSet: TSimpleDataSet;
    FConnection: IConnection;
    FMainDataset: TClientDataSet;
    function GetConnection: IConnection;
    function GetDataSetFromSQL(sql: string): TClientDataSet;
    function GetMainDataSet: TClientDataSet;
    function GetSimpleDataSet: TSimpleDataSet;

    procedure SetMainDataSet(Value: TClientDataSet);
  public
    constructor Create(AOwner: TComponent; sql: string); reintroduce; overload; virtual;

    class function GetKeyFieldName: string; virtual;

    property Connection: IConnection read GetConnection;
    property MainDataset: TClientDataSet read GetMainDataSet write SetMainDataset;
    property SimpleDataSet: TSimpleDataSet read GetSimpleDataSet;
  end;

implementation

uses
  MVC_Config, System.SysUtils;

{ TModel }

procedure TModel.ApplyUpdates(UpdateKind: TUpdateKind);
begin
  if MainDataSet.State in dsEditModes then
    MainDataSet.Post;

  if MainDataSet.ChangeCount > 0 then
  begin
    try
      MainDataSet.ApplyUpdates(0);
    except
      on E: Exception do
        Connection.RaiseException(E.Message, UpdateKind);
    end;
  end;
end;

procedure TModel.Commit(Transaction: TObject);
begin
  FConnection.Commit(Transaction);
end;

constructor TModel.Create(AOwner: TComponent; sql: string);
begin
  Create(AOwner);
  FConnection := TMVCConfig.GetInstance.Connection;
  MainDataSet := GetDataSetFromSQL(sql);
end;

procedure TModel.DataSetAfterOpen(DataSet: TDataSet);
var
  I: Integer;
begin
  for I := 0 to DataSet.FieldCount - 1 do
  begin
    DataSet.Fields[I].ProviderFlags := [pfInUpdate];
    if DataSet.Fields[I].FieldName = GetKeyFieldName then
      DataSet.Fields[I].ProviderFlags := [pfInKey, pfInWhere, pfInUpdate];
  end;
end;

function TModel.GetConnection: IConnection;
begin
  Result := FConnection;
end;

function TModel.GetDataSetFromSQL(sql: string): TClientDataSet;
begin
  FSimpleDataSet := TSimpleDataSet.Create(Self, FConnection.GetDataSet(Self));
  FSimpleDataSet.ClientDataSet.CommandText := sql;
  FSimpleDataSet.ClientDataSet.FetchParams;
  FSimpleDataSet.ClientDataSet.AfterOpen := DataSetAfterOpen;
  FSimpleDataSet.Query.AfterOpen := DataSetAfterOpen;
  Result := FSimpleDataSet.ClientDataSet;
end;

class function TModel.GetKeyFieldName: string;
begin
  raise Exception.Create('Abstract Method');
end;

function TModel.GetMainDataSet: TClientDataSet;
begin
  Result := FMainDataset;
end;

function TModel.GetSimpleDataSet: TSimpleDataSet;
begin
  Result := FSimpleDataSet;
end;

procedure TModel.Rollback(Transaction: TObject);
begin
  FConnection.Rollback(Transaction);
end;

procedure TModel.SetMainDataSet(Value: TClientDataSet);
begin
  FMainDataset := Value;
end;

function TModel.StartTransaction: TObject;
begin
  Result := FConnection.StartTransaction;
end;

end.
