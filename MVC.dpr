program MVC;

uses
  Vcl.Forms,
  Main in 'Main.pas' {Form1},
  GlobalInterfaces in 'GlobalInterfaces.pas',
  DBX_Connection in 'DBX_Connection.pas',
  SimpleDataSet in 'SimpleDataSet.pas',
  Functions in 'Functions.pas',
  MVC_Config in 'MVC_Config.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
