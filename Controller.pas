unit Controller;

interface

uses
  System.Classes, GlobalInterfaces, Model, Frame_Custom;

type
  TController = class(TComponent, IController)
  private
    FFrame: IFrame;
    FModel: IModel;
    function GetFrame: IFrame;
    function GetModel: IModel;
  public
    constructor Create(AOwner: TComponent); override;
    property Frame: IFrame read GetFrame;
    property Model: IModel read GetModel;
    class function GetModelClass: TModelClass; virtual;
    class function GetFrameClass: TFrameCustomClass; virtual;
  end;

implementation

uses
  System.SysUtils;

{ TController }

constructor TController.Create(AOwner: TComponent);
begin
  inherited;
  FModel := GetModelClass.Create(Self, GetModelClass.GetSQL);
  FFrame := GetFrameClass.Create(Self);
  FFrame.Controller := Self;
  FFrame.ReloadFrame;
end;

function TController.GetFrame: IFrame;
begin
  Result := FFrame;
end;

class function TController.GetFrameClass: TFrameCustomClass;
begin
  raise Exception.Create('Abstract Method');
end;

function TController.GetModel: IModel;
begin
  Result := FModel;
end;

class function TController.GetModelClass: TModelClass;
begin
  raise Exception.Create('Abstract Method');
end;

end.
