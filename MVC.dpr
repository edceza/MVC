program MVC;

uses
  Vcl.Forms,
  Main in 'Main.pas' {Form1},
  GlobalInterfaces in 'GlobalInterfaces.pas',
  SQLLiteConnection in 'SQLLiteConnection.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
