unit GlobalInterfaces;

interface

uses
  Datasnap.DBClient, Data.DB, System.Classes, SimpleDataSet;

type
  IConnection = interface
  ['{56F26334-9409-4897-B476-8F85F0E06025}']
    function GetDataSet(AOwner: TComponent): TDataSet;
    function StartTransaction: TObject;

    procedure Commit(var Transaction: TObject);
    procedure Connect;
    procedure Disconect;
    procedure Rollback(var Transaction: TObject);
  end;

  IModel = interface
  ['{A1517EE6-4FEF-4EE7-8CC2-07CF9CFE0941}']
    function GetConnection: IConnection;
    function GetDataSetFromSQL(sql: string): TClientDataSet;
    function GetMainDataSet: TClientDataSet;
    function GetSimpleDataSet: TSimpleDataSet;
    function StartTransaction: TObject;

    procedure Commit(Transaction: TObject);
    procedure DataSetAfterOpen(DataSet: TDataSet);
    procedure Rollback(Transaction: TObject);
    procedure SetConnection(Value: IConnection);
    procedure SetMainDataSet(Value: TClientDataSet);

    property Connection: IConnection read GetConnection write SetConnection;
    property MainDataSet: TClientDataSet read GetMainDataSet write SetMainDataSet;
    property SimpleDataSet: TSimpleDataSet read GetSimpleDataSet;
  end;

  IFrame = interface
  ['{77ED2A5C-8826-4A99-9CFB-A5C4E311A379}']
    function GetMainDataSource: TDataSource;
    function GetModel: IModel;
    procedure SetMainDataSource(Value: TDataSource);
    procedure SetModel(Value: IModel);
    property MainDataSource: TDataSource read GetMainDataSource write SetMainDataSource;
    property Model: IModel read GetModel write SetModel;
  end;

  IController = interface
  ['{16787CBD-58F7-4210-83F6-65DC48754763}']
    function GetFrame: IFrame;
    function GetModel: IModel;
    procedure SetFrame(Value: IFrame);
    procedure SetModel(Value: IModel);
    property Frame: IFrame read GetFrame write SetFrame;
    property Model: IModel read GetModel write SetModel;
  end;

implementation

end.
