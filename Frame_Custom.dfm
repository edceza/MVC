object FrameCustom: TFrameCustom
  Left = 0
  Top = 0
  Width = 320
  Height = 240
  TabOrder = 0
  object dsMain: TDataSource
    AutoEdit = False
    Left = 16
    Top = 8
  end
  object actList: TActionList
    Left = 64
    Top = 8
    object actClose: TAction
      Category = 'Frame'
      Caption = 'Fechar'
      ShortCut = 16499
      OnExecute = actCloseExecute
    end
    object actInsert: TAction
      Category = 'DataSet'
      Caption = 'Novo'
      ShortCut = 113
      OnExecute = actInsertExecute
      OnUpdate = actInsertUpdate
    end
    object actEdit: TAction
      Category = 'DataSet'
      Caption = 'Alterar'
      ShortCut = 114
      OnExecute = actEditExecute
      OnUpdate = actEditUpdate
    end
    object actDelete: TAction
      Category = 'DataSet'
      Caption = 'Excluir'
      ShortCut = 16430
      OnExecute = actDeleteExecute
      OnUpdate = actDeleteUpdate
    end
    object actPost: TAction
      Category = 'DataSet'
      Caption = 'Salvar'
      ShortCut = 115
      OnExecute = actPostExecute
      OnUpdate = actPostUpdate
    end
    object actCancel: TAction
      Category = 'DataSet'
      Caption = 'Cancelar'
      ShortCut = 119
      OnExecute = actCancelExecute
      OnUpdate = actCancelUpdate
    end
  end
end
