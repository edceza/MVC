unit Frame_CustomDBGrid;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Frame_Custom, System.Actions,
  Vcl.ActnList, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls;

type
  TTFrameCustomDBGrid = class(TFrameCustom)
    pFilter: TPanel;
    DBGrid1: TDBGrid;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TFrameCustomDBGrid: TTFrameCustomDBGrid;

implementation

{$R *.dfm}

end.
