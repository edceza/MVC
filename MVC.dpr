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
  Unidade_Controller in 'Unidade\Unidade_Controller.pas',
  Unidade_Model in 'Unidade\Unidade_Model.pas',
  Controller in 'Controller.pas',
  Frame_Custom in 'Frame_Custom.pas' {FrameCustom: TFrame},
  Frame_CustomDBGrid in 'Frame_CustomDBGrid.pas' {FrameCustomDBGrid: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
