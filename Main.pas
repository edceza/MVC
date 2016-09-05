unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.Menus,
  Frame_CustomDBGrid, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters,
  Vcl.StdCtrls, cxButtons, cxControls, dxBarBuiltInMenu, cxPC;

type
  TForm1 = class(TForm)
    cxPageControl1: TcxPageControl;
    MainMenu1: TMainMenu;
    UnidadeMenu: TMenuItem;
    procedure UnidadeMenuClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  Unidade_Controller;

{$R *.dfm}

procedure TForm1.UnidadeMenuClick(Sender: TObject);
var
  UnidadeController: TUnidadeController;
  ts: TcxTabSheet;
begin
  UnidadeController := TUnidadeController.Create(Self);
  ts := TcxTabSheet.Create(cxPageControl1);
  ts.Caption := 'Unidade';
  ts.PageControl := cxPageControl1;
  TFrame(UnidadeController.Frame).Parent := ts;
  TFrame(UnidadeController.Frame).Align := alClient;
end;

end.
