object Fm_FormaPagto: TFm_FormaPagto
  Left = 0
  Top = 0
  Width = 278
  Height = 43
  TabOrder = 0
  object Lb_FormaPagamento: TLabel
    AlignWithMargins = True
    Left = 3
    Top = 0
    Width = 272
    Height = 14
    Margins.Top = 0
    Margins.Bottom = 0
    Align = alTop
    Caption = 'Forma de Pagamento'
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ExplicitWidth = 101
  end
  object pnl_Forma: TPanel
    Left = 0
    Top = 14
    Width = 278
    Height = 29
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object SB_FormaPag: TSpeedButton
      AlignWithMargins = True
      Left = 252
      Top = 0
      Width = 23
      Height = 26
      Margins.Top = 0
      Align = alRight
      Caption = '...'
      OnClick = SB_FormaPagClick
      ExplicitLeft = 258
      ExplicitHeight = 25
    end
    object DBLCB_FormaPagto: TDBLookupComboBox
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 243
      Height = 21
      Align = alClient
      KeyField = 'FPT_CODIGO'
      ListField = 'FPT_DESCRICAO'
      ListSource = Ds_ListaFormPagto
      TabOrder = 0
      OnKeyDown = DBLCB_FormaPagtoKeyDown
    end
  end
  object Qr_ListaFormPagto: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = IB_Local
    ForcedRefresh = True
    FieldOptions.AutoCreateMode = acCombineComputed
    FieldOptions.PositionMode = poFirst
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT * FROM TB_FORMAPAGTO a'
      'where  FPT_ATIVO = '#39'S'#39
      ' ORDER BY FPT_DESCRICAO')
    Left = 188
    Top = 92
  end
  object Ds_ListaFormPagto: TDataSource
    AutoEdit = False
    DataSet = Qr_ListaFormPagto
    Left = 188
    Top = 140
  end
  object IB_Local: TSTTransaction
    DefaultDatabase = DM.IBD_Gestao
    Params.Strings = (
      'read_committed'
      'rec_version'
      'wait')
    Left = 188
    Top = 49
  end
end
