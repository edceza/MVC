unit GlobalInterfaces;

interface

uses
  DB;

type
  IConnection = interface
  ['{56F26334-9409-4897-B476-8F85F0E06025}']

  end;

  IModel = interface
  ['{A1517EE6-4FEF-4EE7-8CC2-07CF9CFE0941}']
    function GetConnection: IConnection;
    procedure SetConnection(Value: IConnection);
    property Connection: IConnection read GetConnection write SetConnection;
  end;

  IFrame = interface
  ['{77ED2A5C-8826-4A99-9CFB-A5C4E311A379}']
    property dsMain: TDataSource;
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
