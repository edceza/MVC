unit DBX_Connection;

interface

uses
  System.Classes, GlobalInterfaces, Data.DB, Data.SqlExpr;

type
  TDBXConnection = class(TComponent, IConnection)
  private
    con: TSQLConnection;
  public
    constructor Create(AOwner: TComponent); override;

    function GetDataSet(AOwner: TComponent): TDataSet;
    function StartTransaction: TObject;

    procedure Connect;
    procedure Disconect;
    procedure Commit(var Transaction: TObject);
    procedure RaiseException(ErrorMessage: string; UpdateKind: TUpdateKind);
    procedure Rollback(var Transaction: TObject);
  end;

implementation

uses
  Data.DBXCommon, System.SysUtils, Data.DBXFirebird;

{ TDBXConnection }

procedure TDBXConnection.Commit(var Transaction: TObject);
begin
  if Transaction.InheritsFrom(TDBXTransaction) then
  begin
    con.CommitFreeAndNil(TDBXTransaction(Transaction));
    Transaction.Free;
  end;
end;

procedure TDBXConnection.Connect;
begin
  con.Connected := True;
end;

constructor TDBXConnection.Create(AOwner: TComponent);
begin
  inherited;
  con := TSQLConnection.Create(AOwner);
  con.ConnectionName := 'FBConnection';
  con.DriverName := 'Firebird';
  con.LoginPrompt := False;
  con.Params.Add('DriverName=Firebird');
  con.Params.Add('Database=C:\Users\cassi\Desktop\MVC\MVC.FDB');
  con.Params.Add('RoleName=RoleName');
  con.Params.Add('User_Name=sysdba');
  con.Params.Add('Password=123');
  con.Params.Add('ServerCharSet=');
  con.Params.Add('SQLDialect=3');
  con.Params.Add('ErrorResourceFile=');
  con.Params.Add('LocaleCode=0000');
  con.Params.Add('BlobSize=-1');
  con.Params.Add('CommitRetain=False');
  con.Params.Add('WaitOnLocks=True');
  con.Params.Add('IsolationLevel=ReadCommitted');
  con.Params.Add('Trim Char=False');
end;

procedure TDBXConnection.Disconect;
begin
  if con.Connected then
    con.Connected := False;
end;

function TDBXConnection.GetDataSet(AOwner: TComponent): TDataSet;
begin
  if AOwner = nil then
    AOwner := Self.Owner;

  Result := TSQLQuery.Create(AOwner);
  TSQLQuery(Result).SQLConnection := con;
end;

procedure TDBXConnection.RaiseException(ErrorMessage: string;
  UpdateKind: TUpdateKind);
begin
  raise Exception.Create(ErrorMessage);
end;

procedure TDBXConnection.Rollback(var Transaction: TObject);
begin
  if Transaction.InheritsFrom(TDBXTransaction) then
  begin
    con.RollbackFreeAndNil(TDBXTransaction(Transaction));
    Transaction.Free;
  end;
end;

function TDBXConnection.StartTransaction: TObject;
begin
  Result := con.BeginTransaction;
end;

end.
