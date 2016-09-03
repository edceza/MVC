object FrameCustom: TFrameCustom
  Left = 0
  Top = 0
  Width = 661
  Height = 456
  TabOrder = 0
  object pFiltro: TPanel
    Left = 0
    Top = 0
    Width = 661
    Height = 41
    Align = alTop
    TabOrder = 0
    ExplicitLeft = -3
    object btFiltrar: TButton
      Left = 576
      Top = 9
      Width = 75
      Height = 25
      Caption = 'Filtrar'
      TabOrder = 0
    end
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 41
    Width = 661
    Height = 29
    Caption = 'ToolBar1'
    TabOrder = 1
    ExplicitLeft = 208
    ExplicitTop = 96
    ExplicitWidth = 150
    object ToolButton1: TToolButton
      Left = 0
      Top = 0
      Action = actInsert
    end
    object ToolButton2: TToolButton
      Left = 23
      Top = 0
      Action = actEdit
    end
    object ToolButton3: TToolButton
      Left = 46
      Top = 0
      Action = actDelete
    end
    object ToolButton4: TToolButton
      Left = 69
      Top = 0
      Width = 8
      Caption = 'ToolButton4'
      ImageIndex = 3
      Style = tbsSeparator
    end
    object ToolButton5: TToolButton
      Left = 77
      Top = 0
      Action = actPost
    end
    object ToolButton6: TToolButton
      Left = 100
      Top = 0
      Action = actCancel
    end
  end
  object dsMain: TDataSource
    AutoEdit = False
    Left = 520
    Top = 152
  end
  object actList: TActionList
    Left = 552
    Top = 152
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
