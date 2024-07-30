object Fm_ListaSituacao: TFm_ListaSituacao
  Left = 0
  Top = 0
  Width = 357
  Height = 39
  TabOrder = 0
  object Label14: TLabel
    Left = 0
    Top = 0
    Width = 357
    Height = 14
    Align = alTop
    Caption = 'Situa'#231#227'o do Conserto'
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ExplicitWidth = 104
  end
  object Sb_Cadastro: TSpeedButton
    AlignWithMargins = True
    Left = 331
    Top = 14
    Width = 23
    Height = 22
    Margins.Top = 0
    Align = alRight
    Caption = '...'
    Font.Charset = ANSI_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    NumGlyphs = 2
    ParentFont = False
    OnClick = Sb_CadastroClick
    ExplicitLeft = 232
    ExplicitTop = 10
    ExplicitHeight = 20
  end
  object DBLCB_Situacao: TDBLookupComboBox
    Left = 0
    Top = 14
    Width = 328
    Height = 21
    Align = alClient
    KeyField = 'SIT_CODIGO'
    ListField = 'SIT_DESCRICAO'
    ListSource = Ds_Situacao
    TabOrder = 0
    OnKeyDown = DBLCB_SituacaoKeyDown
  end
  object Qr_Situacao: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = IBT_Frame
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT *'
      'FROM TB_SITUACAO'
      'WHERE SIT_MODULO=:SIT_MODULO'
      'ORDER BY SIT_DESCRICAO')
    Left = 30
    Top = 70
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'SIT_MODULO'
        ParamType = ptUnknown
      end>
  end
  object Ds_Situacao: TDataSource
    DataSet = Qr_Situacao
    Left = 92
    Top = 68
  end
  object IBT_Frame: TSTTransaction
    DefaultDatabase = DM.IBD_Gestao
    Params.Strings = (
      'concurrency'
      'nowait')
    Left = 188
    Top = 70
  end
end
