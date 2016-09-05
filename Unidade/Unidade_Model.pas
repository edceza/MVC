unit Unidade_Model;

interface

uses
  Model;

type
  TUnidadeModel = class(TModel)
  protected
    procedure ConfigFilters; override;
  public
    class function GetSQL: string; override;
    class function GetKeyFieldName: string; override;
  end;

implementation

{ TUnidadeModel }

procedure TUnidadeModel.ConfigFilters;
begin
  inherited;
  FFilterList.Values['SIGLA'] := 'SIGLA';
  FFilterList.Values['NOME'] := 'NOME';
end;

class function TUnidadeModel.GetKeyFieldName: string;
begin
  Result := 'UNIDADE_ID';
end;

class function TUnidadeModel.GetSQL: string;
begin
  Result := 'select UNIDADE_ID, SIGLA, NOME from unidade where 1=1';
end;

end.
