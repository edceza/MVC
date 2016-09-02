inherited TFrameCustomDBGrid: TTFrameCustomDBGrid
  object pFilter: TPanel [0]
    Left = 0
    Top = 0
    Width = 320
    Height = 41
    Align = alTop
    TabOrder = 0
    ExplicitLeft = 96
    ExplicitTop = 48
    ExplicitWidth = 185
  end
  object DBGrid1: TDBGrid [1]
    Left = 0
    Top = 41
    Width = 320
    Height = 199
    Align = alClient
    DataSource = dsMain
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
end
