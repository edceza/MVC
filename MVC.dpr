program MVC;

uses
  Vcl.Forms,
  Main in 'Main.pas' {Form1},
  GlobalInterfaces in 'GlobalInterfaces.pas',
  DBX_Connection in 'DBX_Connection.pas',
  SimpleDataSet in 'SimpleDataSet.pas',
  Functions in 'Functions.pas',
  MVC_Config in 'MVC_Config.pas',
  Model in 'Model.pas',
  dm_Custom in 'dm_Custom.pas' {dmCustom: TDataModule},
  Frame_Custom in 'Frame_Custom.pas' {FrameCustom: TFrame},
  Frame_CustomDBGrid in 'Frame_CustomDBGrid.pas' {TFrameCustomDBGrid: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TdmCustom, dmCustom);
  Application.Run;
end.
