unit Frame_Custom;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, GlobalInterfaces, Data.DB,
  System.Actions, Vcl.ActnList;

type
  TFrameCustomClass = class of TFrameCustom;
  TFrameCustom = class(TFrame, IFrame)
    dsMain: TDataSource;
    actList: TActionList;
    actClose: TAction;
    procedure actCloseExecute(Sender: TObject);
  private
    FController: IController;
    procedure SetController(const Value: IController);
    function GetController: IController;
  public
    constructor Create(AOwner: TComponent); override;
    procedure ReloadFrame; virtual;
    property Controller: IController read GetController write SetController;
  end;

implementation

{$R *.dfm}

{ TFrameCustom }

procedure TFrameCustom.actCloseExecute(Sender: TObject);
begin
  PostMessage(Handle, WM_CLOSE, 0, 0);
end;

constructor TFrameCustom.Create(AOwner: TComponent);
var
  i: Integer;
begin
  inherited;
  i := 0;
  while AOwner.FindComponent(ClassName + IntToStr(i)) <> nil do
    Inc(i);
  Name := ClassName + IntToStr(i);

  DoubleBuffered := True;
  TabStop := False;
end;

function TFrameCustom.GetController: IController;
begin
  Result := FController;
end;

procedure TFrameCustom.ReloadFrame;
begin
  dsMain.DataSet := Controller.Model.MainDataSet;
end;

procedure TFrameCustom.SetController(const Value: IController);
begin
  FController := Value;
end;

end.
