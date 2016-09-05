unit Unidade_Controller;

interface

uses
  Controller, Model, Frame_Custom;

type
  TUnidadeController = class(TController)
  public
    class function GetFrameClass: TFrameCustomClass; override;
    class function GetModelClass: TModelClass; override;
  end;

implementation

uses
  Frame_CustomDBGrid, Unidade_Model;

{ TUnidadeController }

class function TUnidadeController.GetFrameClass: TFrameCustomClass;
begin
  Result := TFrameCustomDBGrid;
end;

class function TUnidadeController.GetModelClass: TModelClass;
begin
  Result := TUnidadeModel;
end;

end.
