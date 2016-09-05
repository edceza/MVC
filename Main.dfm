object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 571
  ClientWidth = 831
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object cxPageControl1: TcxPageControl
    Left = 0
    Top = 0
    Width = 831
    Height = 571
    Align = alClient
    TabOrder = 0
    Properties.CustomButtons.Buttons = <>
    Properties.Options = [pcoCloseButton, pcoRedrawOnResize]
    ClientRectBottom = 567
    ClientRectLeft = 4
    ClientRectRight = 827
    ClientRectTop = 4
  end
  object MainMenu1: TMainMenu
    OwnerDraw = True
    Left = 152
    Top = 144
    object UnidadeMenu: TMenuItem
      Caption = 'Unidade'
      OnClick = UnidadeMenuClick
    end
  end
end
