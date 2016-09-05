unit Frame_CustomDBGrid;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Frame_Custom, System.Actions,
  Vcl.ActnList, Data.DB, System.ImageList, Vcl.ImgList, cxGraphics,
  dxLayoutLookAndFeels, cxClasses, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, dxLayoutContainer, dxNavBar, dxLayoutControl,
  dxNavBarCollns, dxNavBarBase, dxLayoutControlAdapters, Vcl.Menus,
  Vcl.StdCtrls, cxButtons, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls;

type
  TFrameCustomDBGrid = class(TFrameCustom)
    actInsert: TAction;
    actEdit: TAction;
    actDelete: TAction;
    actPost: TAction;
    actCancel: TAction;
    actFiltrar: TAction;
    imglist: TcxImageList;
    dxLayoutLookAndFeelList1: TdxLayoutLookAndFeelList;
    dxLayoutStandardLookAndFeel1: TdxLayoutStandardLookAndFeel;
    d: TdxLayoutGroup;
    dxLayoutControl1: TdxLayoutControl;
    dxNavBar1: TdxNavBar;
    liNavBar: TdxLayoutItem;
    dxNavBar1Group1: TdxNavBarGroup;
    dxNavBar1Item1: TdxNavBarItem;
    dxNavBar1Item2: TdxNavBarItem;
    dxNavBar1Item3: TdxNavBarItem;
    pFiltro: TPanel;
    liFiltro: TdxLayoutItem;
    gGrid: TDBGrid;
    liGrid: TdxLayoutItem;
    btPost: TcxButton;
    liPost: TdxLayoutItem;
    btCancel: TcxButton;
    liCancel: TdxLayoutItem;
    btFiltrar: TcxButton;
    lgContainer: TdxLayoutGroup;
    lgGroup: TdxLayoutGroup;
    procedure actCancelExecute(Sender: TObject);
    procedure actInsertExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure actPostExecute(Sender: TObject);
    procedure actFiltrarExecute(Sender: TObject);
    procedure actFiltrarUpdate(Sender: TObject);
    procedure actCancelUpdate(Sender: TObject);
    procedure actPostUpdate(Sender: TObject);
    procedure actDeleteUpdate(Sender: TObject);
    procedure actEditUpdate(Sender: TObject);
    procedure actInsertUpdate(Sender: TObject);
  private
    FTransaction: TObject;
    procedure ConfigFilters;
  public
    procedure ReloadFrame; override;
  end;

var
  FrameCustomDBGrid: TFrameCustomDBGrid;

implementation

uses
  cxTextEdit, Datasnap.DBClient, cxLabel, System.Math;

{$R *.dfm}

procedure TFrameCustomDBGrid.actCancelExecute(Sender: TObject);
begin
  inherited;
  if (Application.MessageBox('Atenção! A ação CANCELAR irá perder as últimas alterações realizadas. Tem certeza?', 'Atenção', MB_ICONQUESTION + MB_YESNO) = mrYes) then
  begin
    dsMain.DataSet.Cancel;
    Controller.Model.Rollback(FTransaction);
  end;
end;

procedure TFrameCustomDBGrid.actCancelUpdate(Sender: TObject);
begin
  inherited;
  actCancel.Enabled := (dsMain.DataSet <> nil) and (dsMain.DataSet.State in dsEditModes);
end;

procedure TFrameCustomDBGrid.actDeleteExecute(Sender: TObject);
begin
  inherited;
  if (Application.MessageBox('Atenção! Você mandou excluir o registro selecionado, deseja continuar?', 'Atenção', MB_ICONQUESTION + MB_YESNO) = mrYes) then
  begin
    FTransaction := Controller.Model.StartTransaction;
    try
      dsMain.DataSet.Delete;
      Controller.Model.ApplyUpdates;
      Controller.Model.Commit(FTransaction);
    except
      Controller.Model.Rollback(FTransaction);
      raise;
    end;
  end;
end;

procedure TFrameCustomDBGrid.actDeleteUpdate(Sender: TObject);
begin
  inherited;
  actDelete.Enabled := (dsMain.DataSet <> nil) and (not dsMain.DataSet.IsEmpty) and (not (dsMain.DataSet.State in dsEditModes));
end;

procedure TFrameCustomDBGrid.actEditExecute(Sender: TObject);
begin
  inherited;
  FTransaction := Controller.Model.StartTransaction;
  dsMain.DataSet.Edit;
end;

procedure TFrameCustomDBGrid.actEditUpdate(Sender: TObject);
begin
  inherited;
  actEdit.Enabled := (dsMain.DataSet <> nil) and (not dsMain.DataSet.IsEmpty) and (not (dsMain.DataSet.State in dsEditModes));
end;

procedure TFrameCustomDBGrid.actFiltrarExecute(Sender: TObject);
var
  I: Integer;
  sql: string;
  F: TcxTextEdit;
begin
  inherited;
  dsMain.DataSet.Close;
  sql := Controller.Model.SimpleDataSet.SQLDefault;
  for I := 0 to pFiltro.ComponentCount - 1 do
  begin
    if pFiltro.Components[I].ClassType = TcxTextEdit then
    begin
      F := TcxTextEdit(pFiltro.Components[I]);
      if Trim(F.Text) <> '' then
      begin
        sql := sql + ' and ' + Controller.Model.FilterList.Values[Copy(F.Name, 3, Length(F.Name))] + ' = ' + QuotedStr(F.Text);
      end;
    end;
  end;
  Controller.Model.MainDataSet.CommandText := sql;
  dsMain.DataSet.Open;
end;

procedure TFrameCustomDBGrid.actFiltrarUpdate(Sender: TObject);
begin
  inherited;
//
end;

procedure TFrameCustomDBGrid.actInsertExecute(Sender: TObject);
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

procedure TFrameCustomDBGrid.actInsertUpdate(Sender: TObject);
begin
  inherited;
  actInsert.Enabled := (dsMain.DataSet <> nil) and (not (dsMain.DataSet.State in dsEditModes));
end;

procedure TFrameCustomDBGrid.actPostExecute(Sender: TObject);
begin
  inherited;
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

procedure TFrameCustomDBGrid.actPostUpdate(Sender: TObject);
begin
  inherited;
  actPost.Enabled := (dsMain.DataSet <> nil) and (dsMain.DataSet.State in dsEditModes);
end;

procedure TFrameCustomDBGrid.ConfigFilters;
var
  I: Integer;
  F: TcxTextEdit;
  L: TcxLabel;
  iL, iT: Integer;
begin
  if Assigned(Controller.Model) then
  begin
    iL := 0;
    iT := 0;
    for I := 0 to Controller.Model.FilterList.Count - 1 do
    begin
      L := TcxLabel.Create(pFiltro);
      L.Name := 'l' + Controller.Model.FilterList.Names[I];
      L.Caption := Controller.Model.FilterList.Names[I];
      L.Parent := pFiltro;
      L.Left := IL;
      L.Top := IT;

      F := TcxTextEdit.Create(pFiltro);
      F.Name := 'te' + Controller.Model.FilterList.Names[I];
      F.Text := '';
      F.Parent := pFiltro;
      F.Left := IL;
      F.Top := IT + 3 + L.Height;

      IL := Max(L.Width, F.Width) + 6;
    end;
  end;
end;

procedure TFrameCustomDBGrid.ReloadFrame;
begin
  inherited;
  ConfigFilters;
end;

end.
