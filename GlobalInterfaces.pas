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
    procedure RaiseException(ErrorMessage: string; UpdateKind: TUpdateKind);
    procedure Rollback(var Transaction: TObject);
  end;

  IModel = interface
  ['{A1517EE6-4FEF-4EE7-8CC2-07CF9CFE0941}']
    function GetConnection: IConnection;
    function GetDataSetFromSQL(const sql: string): TClientDataSet;
    function GetMainDataSet: TClientDataSet;
    function GetSimpleDataSet: TSimpleDataSet;
    function GetFilterList: TStringList;
    function StartTransaction: TObject;

    procedure Commit(Transaction: TObject);
    procedure ApplyUpdates(UpdateKind: TUpdateKind = ukModify);
    procedure DataSetAfterOpen(DataSet: TDataSet);
    procedure Rollback(Transaction: TObject);
    procedure SetMainDataSet(const Value: TClientDataSet);

    property Connection: IConnection read GetConnection;
    property MainDataSet: TClientDataSet read GetMainDataSet write SetMainDataSet;
    property SimpleDataSet: TSimpleDataSet read GetSimpleDataSet;
    property FilterList: TStringList read GetFilterList;
  end;

  IFrame = interface;

  IController = interface
  ['{16787CBD-58F7-4210-83F6-65DC48754763}']
    function GetFrame: IFrame;
    function GetModel: IModel;
    property Frame: IFrame read GetFrame;
    property Model: IModel read GetModel;
  end;

  IFrame = interface
  ['{77ED2A5C-8826-4A99-9CFB-A5C4E311A379}']
    function GetController: IController;
    procedure ReloadFrame;
    procedure SetController(const Value: IController);
    property Controller: IController read GetController write SetController;
  end;

implementation

end.
