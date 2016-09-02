unit dm_Custom;

interface

uses
  System.SysUtils, System.Classes;

type
  TdmCustom = class(TDataModule)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmCustom: TdmCustom;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
