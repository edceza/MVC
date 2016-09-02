unit Frame_Custom;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Actions,
  Vcl.ActnList, Data.DB, GlobalInterfaces, Datasnap.DBClient;

type
  TFrameCustom = class(TFrame, IFrame)
    dsMain: TDataSource;
    actList: TActionList;
    actClose: TAction;
    actInsert: TAction;
    actEdit: TAction;
    actDelete: TAction;
    actPost: TAction;
    actCancel: TAction;
    procedure actCloseExecute(Sender: TObject);
    procedure actInsertExecute(Sender: TObject);
    procedure actInsertUpdate(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure actEditUpdate(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure actDeleteUpdate(Sender: TObject);
    procedure actPostExecute(Sender: TObject);
    procedure actPostUpdate(Sender: TObject);
    procedure actCancelExecute(Sender: TObject);
    procedure actCancelUpdate(Sender: TObject);
  private
    FController: IController;
    FTransaction: TObject;
    procedure SetController(const Value: IController);
    function GetController: IController;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;

    property Controller: IController read GetController write SetController;
  end;

implementation

uses
  SimpleDataSet;

{$R *.dfm}

{ TFrameCustom }

procedure TFrameCustom.actCancelExecute(Sender: TObject);
var
  Cancelar: Boolean;
begin
  inherited;
  if (Application.MessageBox('Atenção! A ação CANCELAR irá perder as últimas alterações realizadas. Tem certeza?', 'Atenção', MB_ICONQUESTION + MB_YESNO) = mrYes) then
  begin
    dsMain.DataSet.Cancel;
    Controller.Model.Rollback(FTransaction);
  end;
end;

procedure TFrameCustom.actCancelUpdate(Sender: TObject);
begin
  actCancel.Enabled := (dsMain.DataSet <> nil) and (dsMain.DataSet.State in dsEditModes);
end;

procedure TFrameCustom.actCloseExecute(Sender: TObject);
begin
  PostMessage(Handle, WM_CLOSE, 0, 0);
end;

procedure TFrameCustom.actDeleteExecute(Sender: TObject);
begin
  FTransaction := Controller.Model.StartTransaction;
  dsMain.DataSet.Delete;
end;

procedure TFrameCustom.actDeleteUpdate(Sender: TObject);
begin
  actDelete.Enabled := (dsMain.DataSet <> nil) and (not dsMain.DataSet.IsEmpty) and (not (dsMain.DataSet.State in dsEditModes));
end;

procedure TFrameCustom.actEditExecute(Sender: TObject);
begin
  FTransaction := Controller.Model.StartTransaction;
  dsMain.DataSet.Edit;
end;

procedure TFrameCustom.actEditUpdate(Sender: TObject);
begin
  actEdit.Enabled := (dsMain.DataSet <> nil) and (not dsMain.DataSet.IsEmpty) and (not (dsMain.DataSet.State in dsEditModes));
end;

procedure TFrameCustom.actInsertExecute(Sender: TObject);
begin
  inherited;
  if not dsMain.DataSet.Active then
  begin
    if dsMain.DataSet.InheritsFrom(TCustomClientDataSet) and (dsMain.DataSet.FieldCount > 0) then
      TCustomClientDataSet(dsMain.DataSet).CreateDataSet
    else
      dsMain.DataSet.Open;
  end;
  FTransaction := Controller.Model.StartTransaction;
  if dsMain.DataSet.IsEmpty then
    dsMain.DataSet.Insert
  else
    dsMain.DataSet.Append;
end;

procedure TFrameCustom.actInsertUpdate(Sender: TObject);
begin
  actInsert.Enabled := (dsMain.DataSet <> nil) and (not (dsMain.DataSet.State in dsEditModes));
end;

procedure TFrameCustom.actPostExecute(Sender: TObject);
begin
  try
    Controller.Model.ApplyUpdates;
  except
    on e: Exception do
    begin
      dsMain.DataSet.Edit;
      Controller.Model.Rollback(FTransaction);
      FTransaction := Controller.Model.StartTransaction;
      raise;
    end;
  end;
  Controller.Model.Commit(FTransaction);
end;

procedure TFrameCustom.actPostUpdate(Sender: TObject);
begin
  actPost.Enabled := (dsMain.DataSet <> nil) and (dsMain.DataSet.State in dsEditModes);
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

procedure TFrameCustom.SetController(const Value: IController);
begin
  FController := Value;
end;

end.
