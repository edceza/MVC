object FrameCustom: TFrameCustom
  Left = 0
  Top = 0
  Width = 320
  Height = 240
  TabOrder = 0
  object dsMain: TDataSource
    AutoEdit = False
    Left = 72
    Top = 28
  end
  object actList: TActionList
    Left = 108
    Top = 28
    object actClose: TAction
      Category = 'Frame'
      Caption = 'Fechar'
      ShortCut = 16499
      OnExecute = actCloseExecute
    end
  end
end
