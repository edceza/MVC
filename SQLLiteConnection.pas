unit SQLLiteConnection;

interface

uses
  System.Classes, GlobalInterfaces, Data.DB;

type
  TSQLLiteConnection = class(TComponent, IConnection)
  public
    constructor Create(AOwner: TComponent); override;
    procedure Commit(var Transaction: TObject);
    procedure Connect;
    procedure Disconect;
    function GetDataSet(AOwner: TComponent): TDataSet;
    procedure Rollback(var Transaction: TObject);
    function StartTransaction: TObject;
  end;

implementation

{ TSQLLiteConnection }

procedure TSQLLiteConnection.Commit(var Transaction: TObject);
begin

end;

procedure TSQLLiteConnection.Connect;
begin

end;

constructor TSQLLiteConnection.Create(AOwner: TComponent);
begin
  inherited;

end;

procedure TSQLLiteConnection.Disconect;
begin

end;

function TSQLLiteConnection.GetDataSet(AOwner: TComponent): TDataSet;
begin

end;

procedure TSQLLiteConnection.Rollback(var Transaction: TObject);
begin

end;

function TSQLLiteConnection.StartTransaction: TObject;
begin

end;

end.
