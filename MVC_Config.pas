unit MVC_Config;

interface

uses
  System.Classes, GlobalInterfaces;

type
  TMVCConfig = class(TComponent)
  private
    FConnection: IConnection;
  public
    constructor Create(AOwner: TComponent); Override;
    class function GetInstance: TMVCConfig;
    property Connection: IConnection read FConnection;
  end;


var
  MVCConfig: TMVCConfig;

implementation

uses
  SQLLiteConnection;

{ TMVCConfig }

constructor TMVCConfig.Create(AOwner: TComponent);
begin
  inherited;
  FConnection := TSQLLiteConnection.Create(Self);
end;

class function TMVCConfig.GetInstance: TMVCConfig;
begin
  if MVCConfig = nil then
    MVCConfig := TMVCConfig.Create(nil);

  Result := MVCConfig;
end;

initialization
  if MVCConfig = nil then
    MVCConfig := TMVCConfig.GetInstance;

finalization
  if MVCConfig <> nil then
    MVCConfig.Free;

end.
